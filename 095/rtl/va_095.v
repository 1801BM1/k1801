//
// Copyright (c) 2014-2018 by 1801BM1@gmail.com
//
// The reformatted Verilog HDL model of 1801VP1-095
//______________________________________________________________________________
//
`timescale 1ns / 100ps

module va_095
(
   inout[21:0] PIN_nADC,      // CPU Address/Data inverted bus (with gap 18:8)
   inout[7:0]  PIN_nADP,      // PPU Address/Data inverted bus
                              //
   input[2:0]  PIN_RC,        // configuration
   input       PIN_nINITP,    // initialization from PPU
   input       PIN_nSYNCC,    //
   input       PIN_nSYNCP,    //
   input       PIN_nA1C_nDLV, // combined with nDLV
   input       PIN_nA1P,      //
   input       PIN_nDLA,      // output address
   input       PIN_nDLD,      // output data
   input       PIN_nCLD,      // output vector
   input       PIN_nWWC,      // CPU writes
   input       PIN_nRDC,      // CPU reads
   input       PIN_nWWP,      // PPU writes
   input       PIN_nRDP,      // PPU reads
   input       PIN_nBSI,      //
                              //
   output      PIN_nCMPC,     //
   output      PIN_nCMPP,     //
   output      PIN_nWD_nRQ,   //
   output      PIN_nBSO       //
);

//______________________________________________________________________________
//
wire [21:0] adco;    // Central QBUS outputs
wire [7:0] adpo;     // Peripheral QBUS outputs
wire[7:0] ivec;      // Central QBus interrupt vector
reg [7:0] sa;        // Peripheral address register
reg [7:0] rd;        // Data register
reg [7:0] csr;       // Control and Status register
wire wc_dat;         // Write Data register from Central QBUS
wire wc_csr;         // Write Control register  from Central QBUS
wire wp_dat;         // Write Data register from Peripheral QBUS
wire wp_csr;         // Write Control register from Peripheral QBUS
wire wp_done;        // Write Done bit (csr[5]) from Peripheral QBUS
wire w_dat;          //
wire w_csr;          //
wire init;           //
wire rc_csr;         //
wire rc_dat;         //
wire rc_vec;         //
wire rp_csr;         //
wire rp_dat;         //
                     //
reg a1p, a1c;        //
wire rc0;            //

//______________________________________________________________________________
//
// Configuration and reset pins
//
assign init = ~PIN_nINITP;
//
// PIN_RC[0]:  0 - lower byte, 1 - upper byte
//
assign rc0 = PIN_RC[0];

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

assign adco[18:8] = 11'b11111111111;
assign ivec[7:0] = {3'b011, ~PIN_RC[2], 1'b1, PIN_RC[1], 2'b00};
assign adco[7:0]  = (PIN_nDLA ? 8'b00000000 : (rc0 ? {rd[1:0],sa[5:0]} : sa[7:0]))
                  | (PIN_nDLD ? 8'b00000000 : ~PIN_nADP[7:0])
                  | (rc_vec   ? 8'b00000000 : ivec)
                  | (rc_dat   ? 8'b00000000 : rd[7:0])
                  | (rc_csr   ? 8'b00000000 : {csr[7], rc0 ? 2'b00 : csr[6:5], 5'b00000});
//
// Highest address lines - address only
//
assign adco[21:19] = PIN_nDLA ? 3'b000 : (rc0 ? rd[4:2] : rd[7:5]);

//______________________________________________________________________________
//
// Peripheral QBUS outputs, "open collector" schematics
//
generate
for(i=0; i<8; i=i+1)
begin : adp_gen
   assign PIN_nADP[i] = adpo[i] ? 1'b0 : 1'bz;
end
endgenerate

assign adpo[7:0]  = (PIN_nCLD ? 8'b00000000 : ~PIN_nADC[7:0])
                  | (rp_csr   ? 8'b00000000 : csr[7:0])
                  | (rp_dat   ? 8'b00000000 : rd[7:0]);

//______________________________________________________________________________
//
// Peripheral address register, used for Direct Memory Access on Central QBus
//
always @(negedge PIN_nSYNCP or posedge init)
begin
   if (init)
      sa[7:0] <= 8'b00000000;
   else
      sa[7:0] <= PIN_nADP[7:0];
end

always @(negedge PIN_nSYNCP or posedge init)
   if (init)
      a1p = 1'b1;
   else
      a1p = rc0 ? ~PIN_nA1P : ~PIN_nADP[1];

always @(negedge PIN_nSYNCC or posedge init)
   if (init)
      a1c = 1'b1;
   else
      a1c = rc0 ? ~PIN_nA1C_nDLV : ~PIN_nADC[1];

assign wp_csr = ~PIN_nWWP & ~a1p;
assign wp_dat = ~PIN_nWWP & a1p;
assign rp_csr = ~PIN_nRDP & ~a1p;
assign rp_dat = ~PIN_nRDP & a1p;

assign wc_csr = ~PIN_nWWC & ~a1c;
assign wc_dat = ~PIN_nWWC & a1c;
assign rc_csr = ~PIN_nRDC & ~a1c;
assign rc_dat = ~PIN_nRDC & a1c;

assign rc_vec = ~PIN_nA1C_nDLV & ~rc0;
//______________________________________________________________________________
//
// Data register, writable from Central and Peripheral Q-Bus
//
assign w_dat = wc_dat | wp_dat;

always @(posedge w_dat or posedge init)
begin
   if (init)
      rd[7:0] <= 8'b00000000;
   else
      if (wc_dat)
         rd[7:0] <= ~PIN_nADC[7:0];
      else
         if (wp_dat)
            rd[7:0] <= ~PIN_nADP[7:0];
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
assign w_csr = wc_csr | wp_csr;
assign wp_done = wp_csr & ~rc0;

always @(posedge wc_csr or posedge init)
begin
   if (init)
      begin
         csr[4:0] <= 5'b00000;
         csr[6] <= 1'b0;
      end
   else
      begin
         csr[4:0] <= PIN_nADC[4:0];
         csr[6] <= PIN_nADC[6];
      end
end

always @(posedge w_csr or posedge init)
begin
   if (init)
      csr[5] <= 1'b0;
   else
      if (~rc0)
         begin
            if (wp_csr)
               csr[5] <= PIN_nADP[5];
            else
               if (wc_csr & ~PIN_nADC[0])    // reset by write '1'
                  csr[5] <= 1'b0;            // into csr[0] from Host
         end
      else
         if (wc_csr)
            csr[5] <= PIN_nADC[5];
end

always @(posedge (wp_csr | wc_dat) or posedge init)
begin
   if (init)
      csr[7] <= 1'b0;
   else
      if (wp_csr)
         csr[7] <= PIN_nADP[7];
      else
         if (wc_dat & ~rc0)   // reset TR by write
            csr[7] <= 1'b0;   // Data register
end

//______________________________________________________________________________
//
assign PIN_nBSO = PIN_nDLA | (rc0 ? (PIN_nBSI | ~((rd[4:0] == 5'b11111) & sa[5]))
                                  : ~(rd[7:5] == 3'b111));
//______________________________________________________________________________
//
// nRQ - interrupt request, write 1 to DONE bit in CSR
// nWD - data access request, depends on PA[15:14] and rc2
//
assign PIN_nWD_nRQ = rc0 ? (PIN_RC[1] ? ~( PIN_nADP[6] & ~PIN_nADP[7])
                                      : ~(~PIN_nADP[6] &  PIN_nADP[7]))
                         : ~(wp_done & ~PIN_nADP[5]); // set DONE bit

//______________________________________________________________________________
//
assign PIN_nCMPP = ~(rc0 ? (~PIN_nADP[7:0] == 8'b11111110)
                         : ((~PIN_nADP[7:3] == 5'b01000) & PIN_RC[1] ^ PIN_nADP[2]));
assign PIN_nCMPC = (PIN_nADC[21:19] != 3'b111)
                 | ~(rc0 ? (~PIN_nADP[7:0] == 8'b11110100)
                         : (~PIN_nADP[7:2] == {4'b0110,PIN_RC[2:1]}));
endmodule

