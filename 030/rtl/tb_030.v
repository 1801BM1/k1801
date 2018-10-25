//
// Copyright (c) 2013 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// External clock frequency
//
`define  SIM_CONFIG_CLOCK_HPERIOD         100
//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            50000

//______________________________________________________________________________
//

module tb_030();
//
// 1801VP1-030 pins
//
tri1  [15:0]   nAD;
reg   [15:0]   AD_in;
reg   [15:0]   AD_out;
reg            AD_oe;

reg            CLK;
reg            nDIN;
reg            nDOUT;
reg            nSYNC;
reg            nWTBT;
reg            nDCLO;
reg            nRSEL;
reg            MSEL;
wire  [6:0]    A;
tri1           nRPLY;

wire  [1:0]    nRAS;
wire  [1:0]    nCAS;
wire           nWE;
wire           nDME;
wire           RSTB;
wire           LOCK;

assign nAD[15:0] = AD_oe ? AD_in[15:0] : 16'hZZZZ;

initial
begin
         CLK = 1'b0;
#`SIM_CONFIG_CLOCK_HPERIOD forever #`SIM_CONFIG_CLOCK_HPERIOD CLK = ~CLK;
end
//
// Simulation time limit
//
initial
begin
#`SIM_CONFIG_TIME_LIMIT $stop;
end

initial
begin
         AD_in = 0;
         AD_oe = 0;
         nDCLO = 0;
         nRSEL = 0;
         nDOUT = 1;
         nDIN  = 1;
         nSYNC = 1;
         nWTBT = 1;
         MSEL  = 1;

#(`SIM_CONFIG_CLOCK_HPERIOD*20)
         nDCLO = 1;
         nRSEL = 1;
         MSEL  = 1;
#100;

//
// Manufacture test - nDIN and nDOUT active, the DRAM address counts every clock
//
//       nDIN  = 0;
//       nDOUT = 0;
//#1000
//       nDIN  = 1;
//       nDOUT = 1;
         AD_in = 16'h508C;
         AD_oe = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*1)
         nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*1)
         AD_oe = 0;
         nDIN  = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*32)
         nDIN  = 1;
         nSYNC = 1;

         qbus_read(16'O000000);
         qbus_read(16'O000002);
         qbus_read(16'O000004);
         qbus_read(16'O000006);

end

//
// 1801BM1 write cycle
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
@(negedge CLK);
   AD_in = ~addr;
@(negedge CLK)
   nSYNC = 0;
@(posedge CLK);
   AD_in = ~data;
   nWTBT = 1;
@(negedge CLK);
   nDOUT = 0;
@(negedge nRPLY);
@(posedge CLK);
@(posedge CLK);
   nDOUT = 1;
@(posedge nRPLY);
   nSYNC = 1;
   AD_oe = 0;
//@(posedge CLK);
end
endtask

//
// 1801BM1 write cycle
//
task qbus_read
(
   input [15:0]  addr
);
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   nWTBT = 1;
   AD_oe = 1;
   AD_in = ~addr;
@(negedge CLK);
   AD_in = ~addr;
@(negedge CLK)
   nSYNC = 0;
@(posedge CLK);
   AD_oe = 0;
   nDIN = 0;
@(negedge nRPLY);
@(posedge CLK);
   AD_out = ~nAD;
@(posedge CLK);
   nDIN = 1;
@(posedge nRPLY);
   nSYNC = 1;
   AD_oe = 0;
//@(posedge CLK);
end
endtask

vp_030 vp_030
(
   .PIN_nAD(nAD),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nWTBT(nWTBT),
   .PIN_MSEL(MSEL),
   .PIN_nRSEL(nRSEL),
   .PIN_nDCLO(nDCLO),
   .PIN_CLK(CLK),
   .PIN_nRPLY(nRPLY),
   .PIN_A(A),
   .PIN_nRAS(nRAS),
   .PIN_nCAS(nCAS),
   .PIN_nWE(nWE),
   .PIN_nDME(nDME),
   .PIN_RSTB(RSTB),
   .PIN_LOCK(LOCK)
);
endmodule

