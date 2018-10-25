//
// Copyright (c) 2013-2014 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// External clock frequency
//
`define  SIM_CONFIG_CLOCK_HPERIOD         125
//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            8000000

//______________________________________________________________________________
//
module rp
(
   input reset,
   input clock,
   output rp
);
reg [3:0] count;

assign rp = (count >= 8) & reset;

initial
begin
   count = 0;
end

always @(negedge(reset) or posedge(clock))
begin
   if (!reset)
      count <= 0;
   else
      if (count < 8)
         count <= count + 1;
end
endmodule

//______________________________________________________________________________
//
module tb_014();
//
// 1801VP1-014 pins
//
tri1  [7:0]    nAD;
reg   [7:0]    AD_in;
reg   [7:0]    AD_out;
reg   [7:0]    AD_vec;
reg            AD_oe;

reg            nCS;
reg            nDIN;
reg            nDOUT;
reg            nSYNC;
reg            nINIT;
tri1           nRPLY;
tri1           nIRQ;
reg            nIAKI;
wire           nIAKO;

wire  [7:1]    Y_in;
tri1  [7:1]    Y_out;
wire  [9:0]    X_in;

reg            CTRL;
reg            SHIFT;
reg            EC1;
reg            EC2;

tri1           RP1_out;
tri1           RP2_out;
wire           RP1_in;
wire           RP2_in;
reg            CLK;

reg   [79:0]   kb;
integer        k;
integer        m;

//______________________________________________________________________________
//
assign nAD[7:0] = AD_oe ? AD_in[7:0] : 8'hZZ;

//_____________________________________________________________________________
//
// Keyboard matrix
//
generate
genvar i;
   for(i=0; i<7; i=i+1)
   begin: Y
      assign Y_in[i+1] = Y_out[i+1] &
                  ( kb[10*i+19]
                  | kb[10*i+18]
                  | kb[10*i+17]
                  | kb[10*i+16]
                  | kb[10*i+15]
                  | kb[10*i+14]
                  | kb[10*i+13]
                  | kb[10*i+12]
                  | kb[10*i+11]
                  | kb[10*i+10]);
   end

   for(i=0; i<10; i=i+1)
   begin: X
      assign X_in[i] = ( !kb[0+i])
                  & (!kb[10+i] | Y_out[1])
                  & (!kb[20+i] | Y_out[2])
                  & (!kb[30+i] | Y_out[3])
                  & (!kb[40+i] | Y_out[4])
                  & (!kb[50+i] | Y_out[5])
                  & (!kb[60+i] | Y_out[6])
                  & (!kb[70+i] | Y_out[7]);
   end
endgenerate

//_____________________________________________________________________________
//
// Clock generator (2-4MHz typical)
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

initial
begin
   kb       = 0;
   CTRL     = 1;
   SHIFT    = 1;
   EC1      = 1;
   EC2      = 1;
@ (posedge nINIT)
#(`SIM_CONFIG_CLOCK_HPERIOD*24)

   for(m=0; m<16; m=m+1)
   begin
      EC2   = (m & (1<<3)) ? 1 : 0;
      EC1   = (m & (1<<2)) ? 1 : 0;
      CTRL  = (m & (1<<1)) ? 1 : 0;
      SHIFT = (m & (1<<0)) ? 1 : 0;
      $display("EC2:%b, EC1:%b, Ctrl:%b, Shift:%b", EC2, EC1, CTRL, SHIFT);
      key_scan();
   end
end

task key_scan();
for(k=0; k<80; k=k+1)
begin
#(`SIM_CONFIG_CLOCK_HPERIOD*4)
//
// kb[k] = 1;
//
   kb[(k % 8) * 10 + k / 8] = 1;
@ (posedge nIRQ)
#(`SIM_CONFIG_CLOCK_HPERIOD*4)
   kb = 0;
@ (posedge RP2_in)
   kb[0] = 0;
end
endtask

initial
begin
   AD_out   = 0;
   AD_vec   = 0;
   AD_in    = 0;
   AD_oe    = 0;
   nDOUT    = 1;
   nDIN     = 1;
   nSYNC    = 1;
   nINIT    = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*24)
   nINIT    = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4)

   qbus_read(8'O260);
   qbus_read(8'O262);
   qbus_write(8'O260, 8'O000);
   qbus_read(8'O260);

forever
begin
@ (negedge nIRQ)
   qbus_inta();
   qbus_read(8'O262);
   if (m==0)
   begin
      if (AD_vec == 8'O274)
         $display("%d, *%d", k, AD_out);
      else
         $display("%d,  %d", k, AD_out);
   end
   else
   begin
      if (AD_vec == 8'O274)
         $display(", *%d", AD_out);
      else
         $display(",  %d", AD_out);
   end
end
end

task qbus_write
(
   input [7:0]  addr,
   input [7:0]  data
);
begin
   nCS   = 0;
   nIAKI = 1;
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
   nCS   = 1;
end
endtask

task qbus_read
(
   input [7:0]  addr
);
begin
   nCS   = 0;
   nIAKI = 1;
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
   nCS   = 1;
end
endtask

task qbus_inta();
begin
   nCS   = 1;
   nIAKI = 1;
   nSYNC = 1;
   nDIN  = 1;
   nDOUT = 1;
   AD_oe = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNC = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nIAKI = 0;
   nDIN  = 0;
@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   AD_vec = ~nAD;
   nSYNC = 1;
   nIAKI = 1;
   nDIN  = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nCS   = 1;
end
endtask

//_____________________________________________________________________________
//
rp rp1(.reset(RP1_out), .clock(CLK), .rp(RP1_in));
rp rp2(.reset(RP2_out), .clock(CLK), .rp(RP2_in));

//_____________________________________________________________________________
//
// Instantiation module under test
//
vp_014 vp_014
(
   .PIN_nAD(nAD),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nINIT(nINIT),
   .PIN_nCS(nCS),
   .PIN_nIAKI(nIAKI),
   .PIN_nIAKO(nIAKO),
   .PIN_nRPLY(nRPLY),
   .PIN_nIRQ(nIRQ),
   .PIN_Y(Y_in),
   .PIN_Y_OC(Y_out),
   .PIN_X(X_in),
   .PIN_RP1_OC(RP1_out),
   .PIN_RP2_OC(RP2_out),
   .PIN_RP1(RP1_in),
   .PIN_RP2(RP2_in),
   .PIN_nCTRL(CTRL),
   .PIN_nSHIFT(SHIFT),
   .PIN_nEC1(EC1),
   .PIN_EC2(EC2)
);
endmodule
