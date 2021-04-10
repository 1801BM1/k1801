//
// Copyright (c) 2021 by 1801BM1@gmail.com
//
// PIO mode testbench
//______________________________________________________________________________
//
`timescale 1ns / 100ps
`define  SIM_DELAY 100
`define  SIM_HDELAY 50

`define  PRC 4'b0101          // chip configuration
`define  PIO 16'o167770       // control & status register
`define  TXD 16'o167772       // transmitter register
`define  RXD 16'o167774       // receiver register

//______________________________________________________________________________
//
module tb_pio();
//
// 1801VP1-033 PIO mode simulation testbench
//
tri1 [15:0] nAD;
reg  [15:0] AD_in;
reg  [15:0] AD_out;
reg         AD_oe;
reg         nBS;

reg         nSYNC;
reg         nWTBT;
reg         nDOUT;
reg         nDIN;
tri1        nRPLY;
reg         nINIT;
reg         nIAKI;
tri1        nVIRQ;
wire        nIAKO;

wire        RDO, RDI;
wire        CSR0, CSR1;
reg         REQA, REQB;
wire        nB0R, nB1R;
wire        nDTR, nNDR, nORR;

//______________________________________________________________________________
//
assign nAD[15:0] = AD_oe ? ~AD_in[15:0] : 16'hZZZZ;
assign #`SIM_HDELAY RDI = RDO;

//_____________________________________________________________________________
//
// Instantiation modules under test
//
vp_033 vp_pio
(
   .PIN_RC({RDI, 1'b0, `PRC}),
   .PIN_RDO(RDO),
   .PIN_nAD(nAD),
   .PIN_nBS(nBS),

   .PIN_nSYNC(nSYNC),
   .PIN_nWTBT(nWTBT),
   .PIN_nDOUT(nDOUT),
   .PIN_nDIN(nDIN),
   .PIN_nRPLY(nRPLY),
   .PIN_nINIT(nINIT),

   .PIN_nIAKI(nIAKI),
   .PIN_nVIRQ(nVIRQ),
   .PIN_nIAKO(nIAKO),

   .PIN_nSHIFT(CSR0),
   .PIN_nOUT(CSR1),
   .PIN_nDI(nB1R),
   .PIN_nDO(nDTR),
   .PIN_nRUN(nNDR),
   .PIN_nSET(nB0R),
   .PIN_nERR(REQB),
   .PIN_nDONE(nORR),
   .PIN_nTR(REQA)
);

//______________________________________________________________________________
//
// Simulation
//
task qbus_write
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   nWTBT = 0;
   AD_oe = 1;
   AD_in = addr;
#`SIM_HDELAY
   nSYNC = 0;
#`SIM_HDELAY
   AD_in = data;
   nWTBT = 1;
#`SIM_HDELAY
   nDOUT = 0;
@(negedge nRPLY);
#`SIM_HDELAY
   nSYNC = 1;
   nDOUT = 1;
@(posedge nRPLY);
#`SIM_HDELAY
   AD_oe = 0;
   $display("Write @ %06O, %06O", addr, data);
end
endtask

task qbus_read
(
   input [15:0]  addr
);
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   AD_oe = 1;
   AD_in = addr;
#`SIM_HDELAY
   nSYNC = 0;
#`SIM_HDELAY
   AD_oe = 0;
   nDIN  = 0;
@(negedge nRPLY);
#`SIM_DELAY
   AD_out = ~nAD;
   nSYNC = 1;
   nDIN  = 1;
@(posedge nRPLY);
#`SIM_HDELAY;
   $display("Read  @ %06O, %06O", addr, AD_out);
end
endtask

task qbus_iako();
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   AD_oe = 0;
#`SIM_HDELAY
   nIAKI = 0;
   nDIN  = 0;
@(negedge nRPLY);
#`SIM_DELAY
   AD_out = ~nAD;
   nIAKI = 1;
   nDIN  = 1;
@(posedge nRPLY);
#`SIM_HDELAY;
   $display("Ivec  @ %06O", AD_out);
end
endtask

initial
begin
   AD_in    = 16'o000000;
   AD_out   = 16'o000000;
   AD_oe    = 1'b0;
   nBS      = 1'b0;

   nSYNC    = 1'b1;
   nWTBT    = 1'b1;
   nDOUT    = 1'b1;
   nDIN     = 1'b1;
   nINIT    = 1'b1;
   nIAKI    = 1'b1;
   REQA     = 1'b0;
   REQB     = 1'b0;

#`SIM_DELAY
   nINIT    = 1'b0;
#(`SIM_DELAY*4)
   nINIT    = 1'b1;
#`SIM_DELAY

   qbus_read(`PIO);
   qbus_read(`RXD);
   qbus_read(`TXD);
   qbus_write(`PIO, 16'o000000);
   qbus_write(`RXD, 16'o000000);
   qbus_write(`TXD, 16'o000000);
   qbus_write(`PIO, 16'o000143);
   REQB     = 1'b1;
   qbus_read(`PIO);
   if (~nVIRQ)
      qbus_iako();
   qbus_read(`PIO);
   REQB     = 1'b0;
   //
   // to trigger the new interrupt on nVIRQ
   // all requests must be deasserted
   //
   qbus_read(`PIO);
   REQA     = 1'b1;
   qbus_read(`PIO);
   if (~nVIRQ)
      qbus_iako();
   qbus_read(`PIO);
   REQA     = 1'b0;
   qbus_read(`PIO);
   if (~nVIRQ)
      qbus_iako();
   qbus_read(`PIO);
   $stop;
end

//______________________________________________________________________________
//
endmodule
