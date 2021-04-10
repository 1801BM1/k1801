//
// Copyright (c) 2021 by 1801BM1@gmail.com
//
// PIO mode testbench
//______________________________________________________________________________
//
`timescale 1ns / 100ps
`define  SIM_DELAY 100
`define  SIM_HDELAY 50

`define  RC 6'b000101         // chip configuration
`define  CSR 16'o167770       // control & status register
`define  SRC 16'o167772       // transmitter register
`define  SRC 16'o167774       // receiver register

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

wire        RDO;     //
wire        nSHIFT;  // serial data clock
wire        nOUT;    // data output direction
wire        nDI;     // input data
wire        nDO;     // output data
wire        nRUN;
wire        nSET;
wire        nERR;
wire        nDONE;
wire        nTR;

//______________________________________________________________________________
//
assign nAD[15:0] = AD_oe ? ~AD_in[15:0] : 16'hZZZZ;

//_____________________________________________________________________________
//
// Instantiation modules under test
//
vp_033 vp_pio
(
   .PIN_RC(`RC),
   .PIN_nAD(nAD),
   .PIN_nBS(nBS),
   .PIN_RDO(RDO),

   .PIN_nSYNC(nSYNC),
   .PIN_nWTBT(nWTBT),
   .PIN_nDOUT(nDOUT),
   .PIN_nDIN(nDIN),
   .PIN_nRPLY(nRPLY),
   .PIN_nINIT(nINIT),

   .PIN_nIAKI(nIAKI),
   .PIN_nVIRQ(nVIRQ),
   .PIN_nIAKO(nIAKO),

   .PIN_nSHIFT(nSHIFT),
   .PIN_nOUT(nOUT),
   .PIN_nDI(nDI),
   .PIN_nDO(nDO),
   .PIN_nRUN(nRUN),
   .PIN_nSET(nSET),
   .PIN_nERR(nERR),
   .PIN_nDONE(nDONE),
   .PIN_nTR(nTR)
);

fdc vp_rdx
(
   .PIN_nSHIFT(nSHIFT),
   .PIN_nOUT(nOUT),
   .PIN_nDI(nDI),
   .PIN_nDO(nDO),
   .PIN_nRUN(nRUN),
   .PIN_nSET(nSET),
   .PIN_nERR(nERR),
   .PIN_nDONE(nDONE),
   .PIN_nTR(nTR)
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

#`SIM_DELAY
   nINIT    = 1'b0;
#(`SIM_DELAY*4)
   nINIT    = 1'b1;
#`SIM_DELAY

   qbus_read(`CSR);
   qbus_write(`CSR, 16'o040000);
   qbus_read(`CSR);
   qbus_write(`CSR, 16'o000101);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_write(`DAT, 16'o000165);
   qbus_read(`CSR);
@(negedge nVIRQ)
   qbus_iako();
   qbus_read(`CSR);
   qbus_write(`CSR, 16'o000103);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`CSR);
   qbus_read(`DAT);
   qbus_read(`CSR);
   qbus_read(`CSR);
@(negedge nVIRQ)
   qbus_iako();
   qbus_read(`CSR);
   qbus_read(`CSR);
   $stop;
end

//______________________________________________________________________________
//
endmodule
