//
// Copyright (c) 2013 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// External clock frequency
//
`define  SIM_CONFIG_CLOCK_HPERIOD         50
//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            100000

//______________________________________________________________________________
//
module tb_013();
//
// 1801VP1-013 pins
//
reg   [15:0]   nAD;
reg            CLK;
reg            nDIN;
reg            nDOUT;
reg            nSYNC;
reg            nWTBT;
reg            nSEL;
reg            MSEL;
reg            RC;

wire  [6:0]    A;
tri1           nRPLY;

wire  [1:0]    nRAS;
wire  [1:0]    nCAS;
wire           nWE;
wire           nDME;
wire           RSTB;
wire           LOCK;

//______________________________________________________________________________
//
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

//______________________________________________________________________________
//
initial
begin
      nAD   = 16'hFFFF;
      nSEL  = 1;
      nDOUT = 1;
      nDIN  = 1;
      nSYNC = 1;
      nWTBT = 1;
      MSEL  = 1;

//
// Reset with RC=0 to reset the internal state machine
//
      RC    = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*8)
      qbus_reset();
#200;
      RC    = 1;
#1000;
      qbus_write(16'O000000, 16'O001002);
      qbus_write(16'O000002, 16'O003004);
      qbus_write(16'O100000, 16'O001002);
      qbus_write(16'O177000, 16'O003004);
      qbus_read (16'O100000);
      qbus_wbyte(16'O000000, 16'O000377);
      qbus_wbyte(16'O000001, 16'O000205);
      qbus_read (16'O160000);
#4000
      qbus_read (16'O100000);
#4000
      qbus_read (16'O100000);
#4000
      qbus_read (16'O100000);
#4000
      qbus_read (16'O100000);
//
// Test mode
//
#200;
      RC    = 1;
      nDOUT = 0;
      nDIN  = 0;
#20000;
end

//______________________________________________________________________________
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
   nAD   = ~addr;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nWTBT = 1;
   nAD   = ~data;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nDOUT = 0;

@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
   nSYNC = 1;
   nDOUT = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
   nAD   = 16'hFFFF;
end
endtask

task qbus_wbyte
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   nWTBT = 0;
   nAD   = ~addr;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nAD   = ~data;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nDOUT = 0;

@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
   nSYNC = 1;
   nDOUT = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
   nAD   = 16'hFFFF;
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
   nWTBT = 1;
   nAD   = ~addr;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nDIN  = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);

@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 1;
   nDIN  = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nAD   = 16'hFFFF;
end
endtask

task qbus_reset();
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
   nDOUT = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*16);
   nDOUT = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
end
endtask

vp_013 vp_013
(
   .PIN_nAD(nAD),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nWTBT(nWTBT),
   .PIN_MSEL(MSEL),
   .PIN_nSEL(nSEL),
   .PIN_RC(RC),
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

