//
// Copyright (c) 2021 by 1801BM1@gmail.com
//
// BPIC mode testbench
//______________________________________________________________________________
//
`timescale 1ns / 100ps
`define  SIM_DELAY 100
`define  SIM_HDELAY 50

`define  BRC 3'b001          // chip configuration
`define  RX_CSR 16'o177560
`define  RX_DAT 16'o177562
`define  TX_CSR 16'o177564
`define  TX_DAT 16'o177566

//______________________________________________________________________________
//
module vp_tty(
   input    PIN_nIN,
   input    PIN_nOUT,
   input    PIN_nSET,
   output   PIN_ERR,
   output   PIN_DONE,
   output   PIN_TR,

   output   PIN_nAO_A,
   output   PIN_nAC_A,
   output   PIN_nSC_S,
   output   PIN_nSO_S,

   input    PIN_nAC_S,
   input    PIN_nSC_A
);

wire  nIN, nOUT, nSET;
reg   ERR, DONE, TR;

wire  nAC_S, nSC_A;
reg   nAO_A, nAC_A, nSC_S, nSO_S;

assign nIN = PIN_nIN;
assign nOUT = PIN_nOUT;
assign nSET = PIN_nSET;
assign PIN_ERR = ERR;
assign PIN_DONE = DONE;
assign PIN_TR = TR;

assign nAC_S = PIN_nAC_S;
assign nSC_A = PIN_nSC_A;
assign PIN_nAO_A = nAO_A;
assign PIN_nAC_A = nAC_A;
assign PIN_nSC_S = nSC_S;
assign PIN_nSO_S = nSO_S;

initial
begin
   ERR   = 1'b1;
   DONE  = 1'b1;
   TR    = 1'b1;
   nAO_A = 1'b1;
   nAC_A = 1'b1;
   nSC_S = 1'b1;
   nSO_S = 1'b1;
end

always @(negedge nSET)
begin
   nAO_A = 1'b0;
   nAC_A = 1'b0;
   nSO_S = 1'b0;

   ERR   = 1'b0;
   DONE  = 1'b0;
end

always @(negedge nSC_A)
begin
   #`SIM_HDELAY nAC_A = 1'b1;
   TR = 0;
end

always @(posedge nSC_A)
begin
   #`SIM_HDELAY nAC_A = 1'b0;
   TR = 1;
end

always @(negedge nAC_S)
begin
   #`SIM_HDELAY nSC_S = 1'b0;
end

always @(posedge nAC_S)
begin
   #`SIM_HDELAY nSC_S = 1'b1;
end

endmodule

//______________________________________________________________________________
//
module tb_bpic();
//
// 1801VP1-033 BPIC mode simulation testbench
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

wire  nIN, nOUT, nSET;
wire  ERR, DONE, TR;
wire  nAO_A, nAC_A, nSC_S;
wire  nAC_S, nSC_A, nSO_S;
reg   REQ;

//______________________________________________________________________________
//
assign nAD[15:0] = AD_oe ? ~AD_in[15:0] : 16'hZZZZ;

//_____________________________________________________________________________
//
// Instantiation modules under test
//
vp_033 vp_bpic
(
   .PIN_RC({nAO_A, nAC_A, REQ, `BRC}),
   .PIN_nAD(nAD),
   .PIN_nBS(nBS),

   .PIN_nSYNC(nSYNC),
   .PIN_nWTBT(nSO_S),
   .PIN_nDOUT(nDOUT),
   .PIN_nDIN(nDIN),
   .PIN_nRPLY(nRPLY),
   .PIN_nINIT(nINIT),

   .PIN_nIAKI(nIAKI),
   .PIN_nVIRQ(nVIRQ),
   .PIN_nIAKO(nIAKO),

   .PIN_nSHIFT(nAC_S),
   .PIN_nOUT(nSC_A),
   .PIN_nDI(nSC_S),
   .PIN_nDO(nIN),
   .PIN_nRUN(nOUT),
   .PIN_nSET(nSET),
   .PIN_nERR(ERR),
   .PIN_nDONE(DONE),
   .PIN_nTR(TR)
);

vp_tty tty
(
   .PIN_nIN(nIN),
   .PIN_nOUT(nOUT),
   .PIN_nSET(nSET),
   .PIN_ERR(ERR),
   .PIN_DONE(DONE),
   .PIN_TR(TR),
   .PIN_nAO_A(nAO_A),
   .PIN_nAC_A(nAC_A),
   .PIN_nSC_S(nSC_S),
   .PIN_nSO_S(nSO_S),
   .PIN_nAC_S(nAC_S),
   .PIN_nSC_A(nSC_A)
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
   REQ      = 1'b0;

   qbus_read(`TX_CSR);
   qbus_read(`RX_CSR);
   if (~nVIRQ)
      qbus_iako();

#`SIM_DELAY
   nINIT    = 1'b0;
#(`SIM_DELAY*4)
   nINIT    = 1'b1;
#`SIM_DELAY

   qbus_read(`TX_CSR);
   qbus_read(`RX_CSR);
   qbus_write(`TX_DAT, 16'o000065);
   qbus_write(`TX_CSR, 16'o000100);
   qbus_read(`TX_CSR);
   qbus_read(`TX_CSR);
   REQ = 1'b1;
   qbus_write(`TX_DAT, 16'o000065);
   qbus_read(`TX_CSR);
   if (~nVIRQ)
      qbus_iako();
   REQ = 1'b0;
   qbus_read(`TX_CSR);
   qbus_read(`TX_CSR);
   qbus_write(`TX_CSR, 16'o000000);
   qbus_read(`TX_CSR);
   qbus_read(`RX_CSR);
   qbus_write(`RX_CSR, 16'o000100);
   if (~nVIRQ)
      qbus_iako();
   qbus_read(`RX_DAT);
   qbus_read(`RX_CSR);
   qbus_write(`RX_CSR, 16'o000000);
   qbus_read(`RX_CSR);
   $stop;
end

//______________________________________________________________________________
//
endmodule
