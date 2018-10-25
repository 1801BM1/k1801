//
// Copyright (c) 2014-2018 by 1801BM1@gmail.com
//
// The reformatted Verilog HDL model of 1801VP1-095
// One 16-bit data bridge, no RC0 dependence
//______________________________________________________________________________
//
`timescale 1ns / 100ps

module vb_095
(
   inout[21:0] PIN_nADC,      // CPU Address/Data inverted bus
   inout[15:0] PIN_nADP,      // PPU Address/Data inverted bus
                              //
   input[2:1]  PIN_RC,        // configuration
   input       PIN_nINITP,    // initialization from PPU
   input       PIN_nSYNCC,    //
   input       PIN_nSYNCP,    //
   input       PIN_nDLV,      // combined with nDLV
   input       PIN_nDLA,      // output address
   input       PIN_nDLD,      // output data
   input       PIN_nCLD,      // output vector
   input       PIN_nWWC,      // CPU writes
   input       PIN_nRDC,      // CPU reads
   input       PIN_nWWP,      // PPU writes
   input       PIN_nRDP,      // PPU reads
   input       PIN_nBSI,      //
                              //
   output      PIN_nCMPC,     // Address compare CPU bus
   output      PIN_nCMPP,     // Address compare PPU bus
   output      PIN_nWD,       //
   output      PIN_nRQ,       //
   output      PIN_nBSO       //
);

//______________________________________________________________________________
//
wire [21:0] adco;    // Central QBUS outputs
wire [15:0] adpo;    // Peripheral QBUS outputs
wire[15:0] ivec;     // Central QBus interrupt vector
reg [15:0] sa;       // Peripheral address register
reg [15:0] rd;       // Data register
reg [15:0] csr;      // Control and Status register
wire wc_dat;         // Write Data register from Central QBUS
wire wc_csr;         // Write Control register  from Central QBUS
wire wp_dat;         // Write Data register from Peripheral QBUS
wire wp_csr;         // Write Control register from Peripheral QBUS
wire w_dat;          //
wire rc_csr;         //
wire rc_dat;         //
wire rp_csr;         //
wire rp_dat;         //
wire init;           //
wire init_csr5;      //
wire init_csr7;      //
                     //
reg a1p, a1c;        //

//______________________________________________________________________________
//
// Configuration and reset pins
//
assign init = ~PIN_nINITP;

//______________________________________________________________________________
//
// Central host QBUS outputs, "open collector" schematics
//
genvar i;
generate
for(i=0; i<22; i=i+1)
begin : adc_gen
   assign PIN_nADC[i] = adco[i] ? 1'b0 : 1'bz;
end
endgenerate

assign ivec[15:0] = {11'o0003, ~PIN_RC[2], 1'b1, PIN_RC[1], 2'b00};
assign adco[15:0] = (PIN_nDLA ? 16'o000000 : {rd[1:0],sa[13:0]})
                  | (PIN_nDLD ? 16'o000000 : ~PIN_nADP[15:0])
                  | (PIN_nDLV ? 16'o000000 : ivec)
                  | (rc_dat   ? 16'o000000 : rd[15:0])
                  | (rc_csr   ? 16'o000000 : {csr[15], 7'o000, csr[7:5], 5'o00});
//
// Highest address lines - address only
//
assign adco[21:16] = PIN_nDLA ? 6'b000000 : rd[7:2];

//______________________________________________________________________________
//
// Peripheral QBUS outputs, "open collector" schematics
//
generate
for(i=0; i<16; i=i+1)
begin : adp_gen
   assign PIN_nADP[i] = adpo[i] ? 1'b0 : 1'bz;
end
endgenerate

assign adpo[15:0] = (PIN_nCLD ? 8'b00000000 : ~PIN_nADC[15:0])
                  | (rp_csr   ? 8'b00000000 : csr[15:0])
                  | (rp_dat   ? 8'b00000000 : rd[15:0]);

//______________________________________________________________________________
//
// Peripheral address register, used for Direct Memory Access on Central QBus
//
always @(negedge PIN_nSYNCP or posedge init)
begin
   if (init)
      sa[15:0] <= 16'o000000;
   else
      sa[15:0] <= PIN_nADP[15:0];
end

always @(negedge PIN_nSYNCP or posedge init)
   if (init)
      a1p = 1'b1;
   else
      a1p = ~PIN_nADP[1];

always @(negedge PIN_nSYNCC or posedge init)
   if (init)
      a1c = 1'b1;
   else
      a1c = ~PIN_nADC[1];

assign wp_csr = ~PIN_nWWP & ~a1p;
assign wp_dat = ~PIN_nWWP & a1p;
assign rp_csr = ~PIN_nRDP & ~a1p;
assign rp_dat = ~PIN_nRDP & a1p;

assign wc_csr = ~PIN_nWWC & ~a1c;
assign wc_dat = ~PIN_nWWC & a1c;
assign rc_csr = ~PIN_nRDC & ~a1c;
assign rc_dat = ~PIN_nRDC & a1c;

//______________________________________________________________________________
//
// Data register, writable from Central and Peripheral Q-Bus
//
assign w_dat = wc_dat | wp_dat;

always @(posedge w_dat or posedge init)
begin
   if (init)
      rd[15:0] <= 16'o000000;
   else
      if (wc_dat)
         rd[15:0] <= ~PIN_nADC[15:0];
      else
         if (wp_dat)
            rd[15:0] <= ~PIN_nADP[15:0];
end

//______________________________________________________________________________
//
// Control and Status register
//
//         rdc   wrc   rdp   wrp
//
// 0  GO    0     +     +     -
// 1  F1    0     +     +     -
// 2  F2    0     +     +     -
// 3  F3    0     +     +     -
// 4  F4    0     +     +     -
// 5  DONE  +     -     +     +        reset by write 1 to GO (csr[0])
// 6  IE    +     +     +     -
// 7  TR    +     -     +     +        reset by write Data register
// 8  A16   0     +     +     -
// 9  A17   0     +     +     -
// 10 A18   0     +     +     -
// 11 A19   0     +     +     -
// 12 A20   0     +     +     -
// 13 A21   0     +     +     -
// 14 INIT  0     +     +     -
// 15 ERR   +     -     +     +
//
always @(posedge wc_csr or posedge init)
begin
   if (init)
      begin
         csr[4:0] <= 5'o00;
         csr[6] <= 1'b0;
         csr[14:8] <= 7'o000;
      end
   else
      begin
         csr[4:0] <= PIN_nADC[4:0];
         csr[6] <= PIN_nADC[6];
         csr[14:8] <= PIN_nADC[14:8];
      end
end

assign init_csr5 = init | wc_csr & ~PIN_nADC[0];
always @(posedge wp_csr or posedge init_csr5)
begin
   if (init_csr5)
      csr[5] <= 1'b0;      // reset by write '1'
   else                    // into csr[0] from CPU bus
      csr[5] <= PIN_nADP[5];
end

assign init_csr7 = init | wc_dat;
always @(posedge wp_csr or posedge init_csr7)
begin
   if (init_csr7)          // reset TR by write
      csr[7] <= 1'b0;      // Data register
   else
      csr[7] <= PIN_nADP[7];
end

always @(posedge wp_csr or posedge init)
begin
   if (init)
      csr[15] <= 1'b0;
   else
      csr[15] <= PIN_nADP[15];
end

//______________________________________________________________________________
//
assign PIN_nBSO = PIN_nDLA | ~(&rd[12:5] & sa[13]);

//______________________________________________________________________________
//
// nRQ - interrupt request, write 1 to DONE bit in CSR
// nWD - data access request, depends on PA[15:14] and rc1
//
assign PIN_nWD = PIN_RC[1] ? ~( PIN_nADP[14] & ~PIN_nADP[15])
                           : ~(~PIN_nADP[14] &  PIN_nADP[15]);
assign PIN_nRQ = ~(wp_csr & ~PIN_nADP[5]);   // set DONE bit

//______________________________________________________________________________
//
assign PIN_nCMPP = (~PIN_nADP[15:3] != 13'b1111111001000)
                 | (PIN_RC[1] ^ ~PIN_nADP[2]);
assign PIN_nCMPC = (~PIN_nADC[21:16] != 6'b111111)
                 | (~PIN_nADP[15:8] != 8'b11110100)
                 | (~PIN_nADP[7:2] != {4'b0110, PIN_RC[2:1]});
endmodule

