//
// Copyright (c) 2019 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            10000000
`define  SIM_DELAY                        50
//
// External clock frequency
//
`define  SIM_CONFIG_CLOCK_HPERIOD         100

//______________________________________________________________________________
//
module tb_096();

reg CLK;
//
// 1801VP1-095 pins
//
reg [2:1] RC;     // configuration
wire nDLA, nDLD, nDLV, nCLD;
wire nWWC, nRDC;
wire nWWP, nRDP;
wire nBSI, nBSO;

wire [1:0] nCMPC;
wire [1:0] nCMPP;
wire nRQ, nWD;

tri1 [21:0] nADC;
tri1 [10:0] nADC_gap;
reg [21:0] ADC_reg;
reg ADC_oe;

tri1 [15:0] nADP;
reg [15:0] ADP_reg;
reg ADP_oe;

reg nINITP;

reg nDMGIC;
reg nIAKIC;
wire nDMGO;
wire nIAKO;
wire nDMRC;
wire nVIRQC;
wire nSACK, SACK;
wire nCON, CON;

reg GNT;
reg nSYNC_reg;
reg nDIN_reg;
reg nDOUT_reg;
reg nRPLY_reg;

tri1 nSYNCC;
tri1 nDINC;
tri1 nDOUTC;
tri1 nWTBTC;
tri1 nRPLYC;
wire nBSC;

reg  nSYNCP;
reg  nDINP;
reg  nDOUTP;
reg  nWTBTP;
tri1 nRPLYP;
reg  nBSP;

integer a;
reg [15:0] DATAC;
reg [15:0] DATAP;
reg [15:0] DATAC2;
reg [15:0] DATAP2;

//_____________________________________________________________________________
//
// Clock generator (5 MHz typical)
//
initial
begin
   CLK = 1'b0;
#`SIM_CONFIG_CLOCK_HPERIOD
   forever #`SIM_CONFIG_CLOCK_HPERIOD CLK = ~CLK;
end

//_____________________________________________________________________________
//
// Simulation time limit (first breakpoint)
//
initial
begin
#`SIM_CONFIG_TIME_LIMIT $stop;
end

//_____________________________________________________________________________
//
assign nADC = ADC_oe ? ~ADC_reg : 22'hzzzzzz;
assign nADP = ADP_oe ? ~ADP_reg : 16'hzzzz;

assign nSYNCC = GNT ? 1'bz : nSYNC_reg;
assign nDINC  = GNT ? 1'bz : nDIN_reg;
assign nDOUTC = GNT ? 1'bz : nDOUT_reg;
assign nRPLYC = GNT ? nRPLY_reg : 1'bz;


//_____________________________________________________________________________
//
// Background central bus access
//
initial
begin
   GNT = 0;
   forever
   begin
      @ (posedge GNT); #1;
      $display("DMA: start");
      while(GNT) dma_exec();
      $display("DMA: stop");
   end
end

task dma_exec();
begin
   while(GNT & nDMRC) #1;
   if (GNT & !nDMRC) begin
      $display("DMA: nDMRC asserted");
      #(`SIM_DELAY) nDMGIC = 0;
   end
   while(GNT & nSACK) #1;
   if (GNT & !nSACK) begin
      $display("DMA: nSACK asserted");
      #(`SIM_DELAY) nDMGIC = 1;
   end
   while(GNT & nSYNCC & !nSACK) #1;
   if (GNT & !nSYNCC & !nSACK) begin
      $display("DMA: nSYNC asserted");
   end
   while(GNT & !nSYNCC & !nSACK & nDINC & nDOUTC) #1;
   if (GNT & !nSYNCC & !nSACK & !nDINC) begin
      $display("DMA: nDIN asserted");
   end
   if (GNT & !nSYNCC & !nSACK & !nDOUTC) begin
      $display("DMA: nDOUT asserted");
   end
   if (GNT & !nSYNCC & !nSACK & (!nDOUTC | !nDINC)) begin
#(`SIM_DELAY * 4)
      nRPLY_reg = 0;
      while(GNT & !nSYNCC & !nSACK & (!nDOUTC | !nDINC)) #1;
#(`SIM_DELAY * 4)
      nRPLY_reg = 1;
   end
   while(GNT & !nSYNCC & !nSACK) #1;
   if (GNT & nSYNCC & !nSACK) begin
      $display("DMA: nSYNC deasserted");
   end
   #(`SIM_DELAY) nDMGIC = 1;
end
endtask

//_____________________________________________________________________________
//
// Main CPU thread
//
initial
begin
   $display("CPU: start");

   RC[2:1] = 2'b00;

   ADC_oe  = 0;
   ADP_oe  = 0;
   ADC_reg = 22'h000000;
   ADP_reg = 16'h0000;

   GNT = 0;

   nINITP = 0;
   nSYNCP = 1;
   nDINP  = 1;
   nDOUTP = 1;
   nWTBTP = 1;
   nBSP   = 1;

   nDMGIC = 1;
   nIAKIC = 1;

   nSYNC_reg = 1;
   nSYNC_reg = 1;
   nDIN_reg  = 1;
   nDOUT_reg = 1;
   nRPLY_reg = 1;

#(`SIM_DELAY * 2)
   nINITP = 1;

#(`SIM_CONFIG_CLOCK_HPERIOD * 10);
   cpu_read_word(22'O17772140);
   cpu_read_word(22'O17772142);

   exe_cmd(15'O00002, 16'O123456);
   exe_cmd(15'O00004, 16'O000123);

   $display("CPU: done");
   $stop;
end

//_____________________________________________________________________________
//
task exe_cmd
(
   input [14:0]  cmd,
   input [15:0]  data
);
begin
   $display("CPU: send cmd(%06o, %06o)", cmd, data);
   cpu_write_word(22'O17772142, data);
   cpu_write_word(22'O17772140, cmd | 15'O000101); // IE and GO set

   DATAP = 0;
   while(!DATAP[0]) ppu_read_word(16'O177100);  // GO wait
   DATAP2 = DATAP;
   ppu_read_word(16'O177102);
   $display("PPU: read command(%06o)",DATAP2, DATAP);

   // direct access test
   GNT = 1;
   #(`SIM_DELAY);

   ppu_read_word(16'O40200);
   ppu_write_word(16'O40200, 16'O054321);
   ppu_write_byte(16'O40400, 16'O000222);
   ppu_write_byte(16'O40401, 16'O111000);
   GNT = 0;
   #(`SIM_DELAY);

   ppu_write_word(16'O177100, 16'O000040); // DONE set

   $display("CPU: wait for interrupt");
   while(nVIRQC) nIAKIC = 1;
   $display("CPU: process interrupt");
   cpu_iako();

   DATAC = 0;
   while(!DATAC[5]) cpu_read_word(22'O17772140);   // DONE wait wait
   DATAC2 = DATAC;
   cpu_read_word(22'O17772142);
   $display("CPU: done cmd(%06o, %06o)", DATAC2, DATAC);
   cpu_write_word(22'O17772140, cmd | 15'O000100); // IE and GO unset
end
endtask

//_____________________________________________________________________________
//
// QBus transaction primitives
//
task cpu_iako();
begin
   nSYNC_reg = 1;
   nDIN_reg  = 1;
   nDOUT_reg = 1;
   nIAKIC    = 1;
   ADC_oe    = 0;
@ (negedge CLK);
#(`SIM_DELAY);
@ (negedge CLK);
   nDIN_reg  = 0;
   nIAKIC    = 0;
@ (negedge nRPLYC);
@ (negedge CLK);
@ (posedge CLK);
@ (negedge CLK);
@ (posedge CLK);
   DATAC     = ~nADC;
   $display("cpu read ivec(%06o)", DATAC[15:0]);
@ (negedge CLK);
#(`SIM_DELAY);
   nDIN_reg  = 1;
   nIAKIC    = 1;
@ (posedge nRPLYC);
#(`SIM_DELAY);
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task cpu_read_word
(
   input [21:0]  addr
);
begin
   nSYNC_reg = 1;
   nDIN_reg  = 1;
   nDOUT_reg = 1;
   nIAKIC    = 1;
   ADC_reg   = addr;
   ADC_oe    = 1;
@ (negedge CLK);
#(`SIM_DELAY);
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNC_reg = 0;
@ (negedge CLK);
   ADC_oe    = 0;
   nDIN_reg  = 0;
@ (negedge nRPLYC);
@ (negedge CLK);
@ (posedge CLK);
@ (negedge CLK);
@ (posedge CLK);
   DATAC     = ~nADC;
// $display("cpu read word(%08o, %06o)", addr, DATAC[15:0]);
@ (negedge CLK);
#(`SIM_DELAY);
   nDIN_reg  = 1;
@ (posedge nRPLYC);
#(`SIM_DELAY);
   nSYNC_reg = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task cpu_write_word
(
   input [21:0]  addr,
   input [15:0]  data
);
begin
   nSYNC_reg = 1;
   nDIN_reg  = 1;
   nDOUT_reg = 1;
   nIAKIC    = 1;
   ADC_reg   = addr;
   ADC_oe    = 1;
@ (negedge CLK);
@ (posedge CLK);
   nSYNC_reg = 0;
#(`SIM_DELAY);
   ADC_reg  = data;
   nDOUT_reg = 0;
@ (negedge nRPLYC);
#(`SIM_DELAY);
// $display("CPU: write word(%08o, %06o)", addr, ~nADC[15:0]);
@ (negedge CLK);
#(`SIM_DELAY);
   nDOUT_reg = 1;
@ (posedge nRPLYC);
#(`SIM_DELAY);
   ADC_oe     = 0;
   nSYNC_reg = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task ppu_read_word
(
   input [15:0]  addr
);
begin
   nSYNCP  = 1;
   nDINP   = 1;
   nDOUTP  = 1;
   nWTBTP  = 1;
   ADP_reg = addr;
   ADP_oe  = 1;
@ (negedge CLK);
#(`SIM_DELAY);
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNCP  = 0;
@ (negedge CLK);
   ADP_oe  = 0;
   nDINP   = 0;
@ (negedge nRPLYP);
@ (negedge CLK);
@ (posedge CLK);
@ (negedge CLK);
@ (posedge CLK);
   DATAP     = ~nADP;
   $display("PPU: read word(%06o, %06o)", addr, DATAP);
@ (negedge CLK);
#(`SIM_DELAY);
   nDINP   = 1;
   nSYNCP  = 1;
@ (posedge nRPLYP);
#(`SIM_DELAY);
   nSYNCP  = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task ppu_write_word
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nSYNCP    = 1;
   nDINP     = 1;
   nDOUTP    = 1;
   ADP_reg   = addr;
   ADP_oe    = 1;
   nWTBTP    = 0;
@ (negedge CLK);
#(`SIM_DELAY);
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNCP    = 0;
@ (negedge CLK);
   nWTBTP    = 1;
   ADP_reg   = data;
   nDOUTP    = 0;
@ (negedge nRPLYP);
// $display("PPU: write word(%06o, %06o)", addr, ~nADP);
@ (negedge CLK);
@ (posedge CLK);
@ (negedge CLK);
#(`SIM_DELAY);
   nDOUTP    = 1;
@ (posedge nRPLYP);
#(`SIM_DELAY);
   ADP_oe    = 0;
   nSYNCP    = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task ppu_write_byte
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nSYNCP    = 1;
   nDINP     = 1;
   nDOUTP    = 1;
   ADP_reg   = addr;
   ADP_oe    = 1;
   nWTBTP    = 0;
@ (negedge CLK);
#(`SIM_DELAY);
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNCP    = 0;
@ (negedge CLK);
   ADP_reg   = data;
   nDOUTP    = 0;
@ (negedge nRPLYP);
// $display("PPU: write byte(%06o, %06o)", addr, ~nADP);
@ (negedge CLK);
@ (posedge CLK);
@ (negedge CLK);
#(`SIM_DELAY);
   nDOUTP    = 1;
@ (posedge nRPLYP);
#(`SIM_DELAY);
   nWTBTP    = 1;
   ADP_oe    = 0;
   nSYNCP    = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

//_____________________________________________________________________________
//
// Instantiation modules under test
//
vp_095 low_095
(
   .PIN_nADC({nADC[18:16], nADC_gap, nADC[7:0]}),
   .PIN_nADP(nADP[7:0]),
   .PIN_RC({RC[2:1], 1'b0}),
   .PIN_nINITP(nINITP),
   .PIN_nSYNCC(nSYNCC),
   .PIN_nSYNCP(nSYNCP),
   .PIN_nA1C_nDLV(nDLV),
   .PIN_nA1P(nADP[1]),
   .PIN_nDLA(nDLA),
   .PIN_nDLD(nDLD),
   .PIN_nCLD(nCLD),
   .PIN_nWWC(nWWC),
   .PIN_nRDC(nRDC),
   .PIN_nWWP(nWWP),
   .PIN_nRDP(nRDP),
   .PIN_nBSI(1'b0),
   .PIN_nCMPC(nCMPC[0]),
   .PIN_nCMPP(nCMPP[0]),
   .PIN_nWD_nRQ(nRQ),
   .PIN_nBSO(nBSI)
);

vp_095 high_095
(
   .PIN_nADC({nADC[21:19], nADC_gap, nADC[15:8]}),
   .PIN_nADP(nADP[15:8]),
   .PIN_RC({RC[2:1], 1'b1}),
   .PIN_nINITP(nINITP),
   .PIN_nSYNCC(nSYNCC),
   .PIN_nSYNCP(nSYNCP),
   .PIN_nA1C_nDLV(nADC[1]),
   .PIN_nA1P(nADP[1]),
   .PIN_nDLA(nDLA),
   .PIN_nDLD(nDLD),
   .PIN_nCLD(nCLD),
   .PIN_nWWC(nWWC),
   .PIN_nRDC(nRDC),
   .PIN_nWWP(nWWP),
   .PIN_nRDP(nRDP),
   .PIN_nBSI(nBSI),
   .PIN_nCMPC(nCMPC[1]),
   .PIN_nCMPP(nCMPP[1]),
   .PIN_nWD_nRQ(nWD),
   .PIN_nBSO(nBSO)
);

vp_096 ctrl_096
(
   .PIN_CLK(CLK),
   .PIN_nINIT(nINITP),
   .PIN_nRQ(nRQ),
   .PIN_nWD(nWD),
   .PIN_nCMPC1(nCMPC[0]),
   .PIN_nCMPC2(nCMPC[1]),
   .PIN_nCMPP1(nCMPP[0]),
   .PIN_nCMPP2(nCMPP[1]),

   .PIN_nDMGIC(nDMGIC),
   .PIN_nIAKIC(nIAKIC),
   .PIN_nDMGO(nDMGO),
   .PIN_nIAKO(nIAKO),
   .PIN_nDMRC(nDMRC),
   .PIN_nVIRQC(nVIRQC),
   .PIN_nSACKC1(nSACK),
   .PIN_nSACKC2(SACK),

   .PIN_nSYNCC(nSYNCC),
   .PIN_nDINC(nDINC),
   .PIN_nDOUTC(nDOUTC),
   .PIN_nWTBTC(nWTBTC),
   .PIN_nRPLYC(nRPLYC),
   .PIN_nBSC(nBSC),

   .PIN_nSYNCP(nSYNCP),
   .PIN_nDINP(nDINP),
   .PIN_nDOUTP(nDOUTP),
   .PIN_nWTBTP(nWTBTP),
   .PIN_nRPLYP(nRPLYP),
   .PIN_nBSP(nBSP),

   .PIN_CON1(nCON),
   .PIN_CON2(CON),
   .PIN_nDLA(nDLA),
   .PIN_nDLD(nDLD),
   .PIN_nDLV(nDLV),
   .PIN_nCLD(nCLD),
   .PIN_nWWC(nWWC),
   .PIN_nRDC(nRDC),
   .PIN_nWWP(nWWP),
   .PIN_nRDP(nRDP)
);
endmodule
