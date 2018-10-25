//
// Copyright (c) 2013 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// External clock frequency
//
`define  SIM_CONFIG_CLOCK_HPERIOD         83
//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            25000000

//______________________________________________________________________________
//

module tb_037();
//
// 1801VP1-037 pins
//
tri1  [15:0]   nAD;
reg   [15:0]   AD_in;
reg   [15:0]   AD_out;
reg            AD_oe;

reg            R;
reg            C;
reg            CLK;
reg            nDIN;
reg            nDOUT;
reg            nSYNC;
reg            nWTBT;
tri1           nRPLY;

wire  [6:0]    A;
wire  [1:0]    nCAS;
wire           nRAS;
wire           nWE;
wire           nE;
wire           nBS;
wire           WTI;
wire           WTD;
wire           nVSYNC;

reg            d28, d3;
wire           c28, nIRQ2;
//______________________________________________________________________________
//
assign nAD[15:0] = AD_oe ? AD_in[15:0] : 16'hZZZZ;

//_____________________________________________________________________________
//
// Clock generator (6MHz typical)
//
initial
begin
         CLK = 1'b0;
#`SIM_CONFIG_CLOCK_HPERIOD
         forever #`SIM_CONFIG_CLOCK_HPERIOD CLK = ~CLK;
end

//
// Simulation time limit (first breakpoint)
//
initial
begin
#`SIM_CONFIG_TIME_LIMIT $stop;
end

//_____________________________________________________________________________
//
// IRQ2 selector (from HSYNC & VSYNC)
//
assign nIRQ2 = ~d3;
assign #5 c28 = ~(d28 | nVSYNC);
initial d28 = 1'b0;

always @(negedge c28 or posedge (WTI & CLK))
begin
   if (WTI & CLK)
      d28 <= 1'b0;
   else
      d28 <= ~d28;
end

always @(posedge nVSYNC) d3 <= d28;
//_____________________________________________________________________________
//
initial
begin
         AD_in = 0;
         AD_oe = 0;
         nDOUT = 1;
         nDIN  = 1;
         nSYNC = 1;
         nWTBT = 1;
         C     = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD*2);
         R     = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
         qbus_write(16'O177664, 16'O000000);
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
         qbus_write(16'O177664, 16'O000000);
#(`SIM_CONFIG_CLOCK_HPERIOD*2);
         R     = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*8);

         qbus_write(16'O177664, 16'O000000);

#(`SIM_CONFIG_CLOCK_HPERIOD*8);
         qbus_read (16'O177664);
#(`SIM_CONFIG_CLOCK_HPERIOD*8);

         qbus_write(16'O177664, 16'O000001);
         qbus_write(16'O177664, 16'O000002);
         qbus_write(16'O177664, 16'O000004);
         qbus_write(16'O177664, 16'O000007);
         qbus_write(16'O177664, 16'O000010);
         qbus_write(16'O177664, 16'O000020);
         qbus_write(16'O177664, 16'O000040);
         qbus_write(16'O177664, 16'O000070);
         qbus_write(16'O177664, 16'O000100);
         qbus_write(16'O177664, 16'O000200);
         qbus_write(16'O177664, 16'O000330);
//#(`SIM_CONFIG_CLOCK_HPERIOD*4);

         qbus_write(16'O000000, 16'O000001);
         qbus_write(16'O000010, 16'O000015);
         qbus_read(16'O000000);
         qbus_read(16'O000010);

forever qbus_read(16'O000016);

end

task qbus_write
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   AD_oe = 1;
   AD_in = ~addr;
#(`SIM_CONFIG_CLOCK_HPERIOD);

   nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   AD_in = ~data;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nDOUT = 0;

@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 1;
   nDOUT = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   AD_oe = 0;
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
   AD_in = ~addr;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   AD_oe = 0;

   nDIN  = 0;
@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   AD_out = ~nAD;
   nSYNC = 1;
   nDIN  = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

//_____________________________________________________________________________
//
// Instantiation module under test
//
//
va_037 vp_037
(
   .PIN_CLK(CLK),
   .PIN_R(R),
   .PIN_C(C),
   .PIN_nAD(nAD),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nWTBT(nWTBT),
   .PIN_nRPLY(nRPLY),
   .PIN_A(A),
   .PIN_nCAS(nCAS),
   .PIN_nRAS(nRAS),
   .PIN_nWE(nWE),
   .PIN_nE(nE),
   .PIN_nBS(nBS),
   .PIN_WTI(WTI),
   .PIN_WTD(WTD),
   .PIN_nVSYNC(nVSYNC)
);
endmodule

