#!/usr/bin/env python3
from __future__ import print_function
# Author: Yuriy Shestakov
# Date: 2019-03-09
# Based on 1801PE2 ROM convertion tool written by Vslav
#    https://github.com/1801BM1/k1801/tree/master/rom/rev16
#
import os
import sys
import argparse
import array
import struct
from collections import namedtuple
from functools import reduce

# config.h
REV16_SIZE = 0x2000


class BF(object):
    # A bit array demo - written for Python 3.0
    # https://wiki.python.org/moin/BitArrays

    def __init__(self, bit_sz, fill=0, offset=0):
        self._offs = offset  # remap addresses for write_byte/insert_ary
        self._bit_sz = bit_sz        # size in bits
        self._map_sz = bit_sz >> 3  # size in bytes
        if bit_sz & 7:
            self._map_sz += 1
        fill = 0xff if fill != 0 else 0
        self._map = array.array('B')  # 'B' = unsigned 8-bit integer
        self._map.extend((0,) * self._map_sz)
        self._data = array.array('B')
        self._data.extend((fill,) * self._bit_sz)

    def size(self):
        return self._bit_sz

    def __iter__(self):
        return self

    def __next__(self):
        # return enumerate(self._data)
        for addr, c in enumerate(self._data):
            if not self.has_byte(addr):
                continue
            yield (addr, c)

    def next(self):
        return self.__next__()

    def write_byte(self, addr, c):
        """
        put single byte into the buffer
        """
        addr -= self._offs
        if addr < 0:
            raise ValueError("Buffer underrun at addr %04Xh (offs %04Xh)" %
                             (addr + self._offs, self._offs))
        if addr + 1 > self.size():
            raise ValueError("Buffer overflow at addr %04Xh (size %04Xh)" %
                             (addr + self._offs, self.size()))
        if self.has_byte(addr):
            raise ValueError("overwrite byte at addr %04Xh" %
                             (addr + self._offs))
        self._data[addr] = c
        self.set_map_bit(addr)

    def insert_ary(self, addr, data):
        """
        Put an array (data) into the buffer
        """
        addr -= self._offs
        if addr < 0:
            raise ValueError("Buffer underrun at addr %04Xh (offs %04Xh)" %
                             (addr + self._offs, self._offs))
        if addr + len(data) > self.size():
            raise ValueError("Buffer overflow at addr %04Xh size %d" %
                             (addr + self._offs, len(data)))
        for i, c in enumerate(data):
            pos = addr + i
            if self.has_byte(pos):
                raise ValueError("overwrite byte at addr %04Xh" % pos)
            self._data[pos] = c
            self.set_map_bit(pos)

    def squeeze_tail(self):
        """
        purpose try to remove trailing bytes
        filled with `fill` value like 0xFF
        """
        pass

    def has_byte(self, bit_idx):
        """
        test that the byte is present in array (by _map)
        return 1 or 0
        """
        byte_idx = bit_idx >> 3
        offset = bit_idx & 7
        mask = 1 << offset
        return(self._map[byte_idx] & mask)

    def set_map_bit(self, bit_num):
        """
        returns an integer with the bit at 'bit_num' set to 1.
        """
        record = bit_num >> 3
        offset = bit_num & 7
        mask = 1 << offset
        self._map[record] |= mask
        return(self._map[record])

    def clear_map_bit(self, bit_num):
        """
        returns an integer with the bit at 'bit_num' cleared.
        """
        record = bit_num >> 3
        offset = bit_num & 7
        mask = ~(1 << offset)
        self._map[record] &= mask
        return(self._map[record])

    def toggle_map_bit(self, bit_num):
        """
        returns an integer with the bit
        at 'bit_num' inverted, 0 -> 1 and 1 -> 0.
        """
        record = bit_num >> 3
        offset = bit_num & 7
        mask = 1 << offset
        self._map[record] ^= mask
        return(self._map[record])


# * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
def do_sum(a, b):
    return a + b


def csum(data):
    return (256 - (reduce(do_sum, data, 0) & 255)) & 255


class IHexDat(namedtuple('IHexDat', ['addr', 'data'])):

    def __str__(self):
        assert type(self.data) == bytes, "data has type %s" % type(self.data)
        l = len(self.data)
        if l > 255:
            raise ValueError("len(data)> 255")
        v = struct.pack('>BHB', l, self.addr, 0)  # header
        v += self.data
        return ':%s%02X' % (bytes(v).hex(), csum(v))


class IHexSSA(namedtuple('IHexSSA', ['cs', 'ip'])):

    def __str__(self):
        v = struct.pack('>BHBHH', 4, 0, 3, self.cs, self.ip)
        return ':%s%02X' % (v.hex(), csum(v))


class IHexEOF(object):

    def __str__(self):
        return ':00000001FF'


# * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
class IHEX(object):
    """
    Read Intel HEX file, convert to bytearray
    https://en.wikipedia.org/wiki/Intel_HEX
    """
    def __init__(self, buf):
        self.buf = buf
        self.lnum = 0
        self._esa = 0  # Extended Segment Address
        self._scs = 0  # Start Segment Address (CS:IP)
        self._sip = 0  # Start Segment Address (CS:IP)
        self._ela = 0  # Extended Linear Address
        self._sla = 0  # Start Linear Address

    def _parse_ihex_rec(self, line):
        self.lnum += 1
        if line[0] == ';':  # is a comment?
            return
        if line[0] != ':':
            raise ValueError("Invalid hex-record found at line %d" %
                             self.lnum)
        # print(line,)
        x = bytearray.fromhex(line[1:].rstrip())
        cs = csum(x)
        if cs & 255 != 0:
            raise ValueError("Invalid checksum %02xh at line %d" %
                             (csum, self.lnum))
        bcnt = x[0]
        addr = (x[1] << 8) + x[2]
        rtype = x[3]
        data = x[4:-1]
        return (bcnt, addr, rtype, data)

    def read_file(self, in_fn):
        in_f = open(in_fn, 'r')
        self.lnum = 0
        for line in in_f.readlines():
            (bcnt, addr, rtype, data) = self._parse_ihex_rec(line)
            if rtype == 0:  # data
                # for 16bit ISA like PDP-11 we ignore ESA
                # use use only addr there
                assert len(data) == bcnt
                self.buf.insert_ary(addr, data)
                print(":DAT [%2d] %04Xh" % (bcnt, addr))
            elif rtype == 1:  # EOF
                # close/flush the file?
                print(":EOF")
            elif rtype == 2:  # extended segment address
                self._esa, = struct.unpack('>H', data)
                self._esa <<= 4
                if (self._esa > self.buf.size()):
                    raise ValueError("ESA(%04Xh) is beyond of buf size at "
                                     "line %d" % (self._esa, self.lnum))
                print(":ESA %04Xh" % (self._esa))

            elif rtype == 3:  # Start Segment Address
                self._scs, self._sip = struct.unpack('>HH', data)
                print(":SSA %04X:%04X" % (self._scs, self._sip))
            elif rtype == 4:  # Extended Linear Address
                # The two data bytes (big endian) specify the upper 16 bits of
                # the 32 bit absolute address for all subsequent type 00
                # records;
                self._ela, = struct.unpack('>H', data)
                print(":ELA %04X0000h" % self._ela)
            elif rtype == 5:  # Start Linear Address
                self._sla = struct.unpack('>L', data)
                print(":SLA %08Xh" % self._sla)


def my_int(val):
    if val.startswith('0x'):
        return int(val, base=16)
    if val.endswith('h'):
        return int(val[:-1], base=16)
    if val.startswith('0'):
        return int(val, base=8)
    return int(val)


def write_rom_file(out_rom_fn, buf):
    with(open(out_rom_fn, 'wb')) as fo:
        fo.write(buf._data)


def do_decode(args):
    """
    do decoding from ROM into HEX format
    """
    with open(args.rom_fn, 'rb') as fi:
        dat = fi.read(REV16_SIZE+2)
        if len(dat) != REV16_SIZE+2:
            raise RuntimeError("Unexpexted ROM file size: %d" % len(dat))
        ibuf = BF(REV16_SIZE, fill=args.fill)
        ibuf.insert_ary(0, dat[:-2])  # w/o chip-code
    obuf = BF(REV16_SIZE, fill=args.fill)
    for addr, c in ibuf.next():
        if addr == REV16_SIZE:
            break
        oaddr = addr ^ (REV16_SIZE-2)
        oc = ((~c) & 255)
        obuf.write_byte(oaddr, oc)
        # print("%04X [%02X] -> %04X [%02X]" % (addr, c, oaddr, oc))
    with open('tmp.rom', 'wb') as fo:
        fo.write(obuf._data[:REV16_SIZE])
    obuf.squeeze_tail()
    # write out IHEX
    with open(args.hex_fn, 'w') as fo:
        #
        # if args.offset:
        addr = 0
        while addr < obuf.size():
            rec = IHexDat(addr + args.offset,
                          bytes(obuf._data[addr:addr+16]))
            fo.write(str(rec))
            fo.write("\r\n")
            addr += 16

        rec = IHexSSA(0, args.start_addr)
        # print("IHexSSA: %s" % str(rec))
        fo.write(str(rec))
        fo.write("\r\n")
        fo.write(str(IHexEOF()))
        fo.write("\r\n")


def do_encode(args):
    """
    do encoding from IHEX into ROM format
    """
    ibuf = BF(REV16_SIZE+2, fill=args.fill, offset=args.offset)
    rom = IHEX(ibuf)
    rom.read_file(args.hex_fn)
    obuf = BF(REV16_SIZE+2, fill=args.fill)
    for addr, c in ibuf.next():
        oaddr = addr ^ (REV16_SIZE-2)
        oc = ((~c) & 255)
        obuf.write_byte(oaddr, oc)
        # print("%04X [%02X] -> %04X [%02X]" % (addr, c, oaddr, oc))
    # 1801PE2 ROM footer
    sig = array.array('B', [0, args.chip_code])
    obuf.insert_ary(REV16_SIZE, sig)
    write_rom_file(args.rom_fn, obuf)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog='1801PE2 ROM convereted')
    parser.add_argument('-x', dest='hex_fn', required=True,
                        help='input HEX file')
    parser.add_argument('-b', dest='rom_fn', required=True,
                        help='output ROM file')
    parser.add_argument('-c', dest='chip_code', type=int, default=3,
                        help='ROM chip code')
    parser.add_argument('-f', dest='fill', type=int, default=0xff,
                        help='fill byte')
    parser.add_argument('-o', dest='offset', type=my_int, default=0,
                        help='offset')
    parser.add_argument('-a', dest='start_addr', type=my_int, default=0,
                        help='start address')
    group = parser.add_mutually_exclusive_group()
    group.add_argument('-D', action='store_true')
    group.add_argument('-E', action='store_true')
    args = parser.parse_args()
    if args.E:
        do_encode(args)
    elif args.D:
        do_decode(args)
    else:
        print("Either -D or -E option should be specified", file=sys.stderr)
        sys.exit(os.EX_USAGE)
