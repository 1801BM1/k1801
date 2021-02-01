//
// Copyright (c) 2021 by 1801BM1@gmail.com
//
// Refactored Verilog sources of VP1-034
//______________________________________________________________________________
//
`timescale 1ns / 100ps

module va_034_reg
(
   inout [15:0]   PIN_nAD,    // inverted register output
   input [15:0]   PIN_nD,     // inverted register input
                              //
   input          PIN_nDME,   // register output enable
   input          PIN_C       // register strobe
);

reg [15:0] d;

always @(*) if (PIN_C) d <= PIN_nD;
assign PIN_nAD = PIN_nDME ? 16'hzzzz : d;

endmodule
//______________________________________________________________________________
//
module va_034_pio
(
   inout  [7:0]   PIN_nC,     // bidirectional, inverted/configurable
   output [7:0]   PIN_D,      // register output
   input  [7:0]   PIN_A,      // input A
   input  [7:0]   PIN_B,      // input A
                              //
   input          PIN_nR,     // register reset
   input          PIN_nST,    // register strobe
   input          PIN_nCA,    // select A input
   input          PIN_nCB,    // select B input
   input          PIN_nCD,    // enable register output
   input          PIN_nCOM    // inversion control
);

reg  [7:0] d;
wire [7:0] pd;
wire [7:0] mx;

always @(*)
begin
   if (~PIN_nR)
      d <= 8'hFF;
   else
      if (~PIN_nST)
         d <= PIN_nC;
end

assign pd = PIN_nCD ? 8'h00 : ~d;
assign mx = (PIN_nCA ? 8'h00 : PIN_A) | (PIN_nCB ? 8'h00 : PIN_B);

assign PIN_D = PIN_nCOM ? pd : ~pd;
assign PIN_nC = (PIN_nCA & PIN_nCB) ? 8'hZZ : (PIN_nCOM ? mx : ~mx);

endmodule
//______________________________________________________________________________
//
module va_034_aciv
(
   inout [12:2]   PIN_nAD,
   input [9:0]    PIN_A,
   input [5:0]    PIN_V,
   input          PIN_nBS,
   input          PIN_nSYNC,
   input          PIN_nIAKI,
   input          PIN_nDIN,
   input          PIN_nVIRI,
   output         PIN_nVIRQ,
   output         PIN_nRPLY,
   output         PIN_nSB
);

reg irq;
reg match;

always @(*) if (PIN_nSYNC) match <= ~PIN_nBS & (PIN_nAD[12:3] == PIN_A);
assign PIN_nSB = ~match;

always @(*) if (PIN_nDIN) irq <= ~PIN_nVIRI;
assign PIN_nVIRQ = PIN_nVIRI;
assign PIN_nRPLY = (~PIN_nIAKI & irq) ? 1'b0 : 1'bZ;
assign PIN_nAD[12:8] = 5'bZZZZZ;
assign PIN_nAD[7:2] = (~PIN_nIAKI & irq) ? PIN_V : 6'bZZZZZZ;

endmodule
//______________________________________________________________________________
//
