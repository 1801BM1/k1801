//
// Copyright (c) 2021 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps
`define  SIM_DELAY 100

//______________________________________________________________________________
//

module tb_034();
//
// 1801VP1-034 pins, register mode
//
wire [15:0] lat_nAD;
reg  [15:0] lat_nD;
reg         lat_C;
reg         lat_nDME;
integer     lat_i;

//
// 1801VP1-034 pins, pio mode
//
wire [7:0]  pio_D;
wire [7:0]  pio_nC;
wire        pio_nCOM;

reg [7:0]   pio_A;
reg [7:0]   pio_B;
reg         pio_nR;
reg         pio_nST;
reg         pio_nCA;
reg         pio_nCB;
reg         pio_nCD;
reg         nCOM;

//
// 1801VP1-034 pins, avic mode
//
wire        nSB;
wire        nVIRQ;
wire [12:2] av_nAD;
wire        av_nBS;
wire [1:0]  av_NC;

reg [12:2]  nAD;
reg [9:0]   av_A;
reg [5:0]   av_V;
reg         nIAKI;
reg         nSYNC;
reg         nDIN;
reg         nVIRI;
reg         nBS;
tri1        nRPLY;

//______________________________________________________________________________
//
// VP1-034 register mode test
//
initial
begin
   lat_nD = 16'h0000;
   lat_C = 0;
   lat_nDME = 1;

   for(lat_i=0; lat_i<16; lat_i=lat_i+1)
   begin
#`SIM_DELAY
      lat_nD = 16'h0001 << lat_i;
#`SIM_DELAY
      lat_C = 1;
#`SIM_DELAY
      lat_C = 0;
#`SIM_DELAY
      lat_nD = 16'h0000;
#`SIM_DELAY
      lat_nDME = 1;
#`SIM_DELAY
      lat_nDME = 0;
   end
end

//______________________________________________________________________________
//
// VP1-034 pio mode test
//
assign pio_nCOM = nCOM;

initial
begin
   pio_A = 8'h00;
   pio_B = 8'h00;
   pio_nR = 1;
   pio_nST = 1;
   pio_nCA = 1;
   pio_nCB = 1;
   pio_nCD = 1;
   nCOM = 1;

#`SIM_DELAY
   pio_A = 8'hA5;
#`SIM_DELAY
   pio_nCA = 0;
#`SIM_DELAY
   pio_nST = 0;
#`SIM_DELAY
   pio_nST = 1;
#`SIM_DELAY
   nCOM = 0;
#`SIM_DELAY
   nCOM = 1;
#`SIM_DELAY
   pio_nCA = 1;

#`SIM_DELAY
   pio_nCD = 0;
#`SIM_DELAY
   pio_B = 8'h8B;
#`SIM_DELAY
   pio_nCB = 0;
#`SIM_DELAY
   pio_nCB = 1;
#`SIM_DELAY
   pio_nST = 0;
#`SIM_DELAY
   nCOM = 0;
#`SIM_DELAY
   nCOM = 1;
#`SIM_DELAY
   pio_nST = 1;
#`SIM_DELAY
   pio_nCB = 1;

#`SIM_DELAY
   pio_nR = 0;
#`SIM_DELAY
   pio_nR = 1;

#`SIM_DELAY
   pio_nCB = 0;
#`SIM_DELAY
   nCOM = 0;
#`SIM_DELAY
   pio_nCB = 1;
end

//______________________________________________________________________________
//
// VP1-034 avic mode test
//
assign av_nBS = nBS;
assign av_nAD = nAD;
initial
begin
   nAD = 13'hZZZZ;
   av_A = 13'o01762 >> 3;
   av_V = 8'o064 >> 2;
   nIAKI = 1;
   nSYNC = 1;
   nDIN = 1;
   nVIRI = 1;
   nBS = 1;

#`SIM_DELAY
   nVIRI = 0;
#`SIM_DELAY
   nDIN = 0;
#`SIM_DELAY
   nIAKI = 0;
#`SIM_DELAY
#`SIM_DELAY
   nDIN = 1;
#`SIM_DELAY
   nIAKI = 1;
   nVIRI = 1;

#`SIM_DELAY
#`SIM_DELAY
   nBS = 0;
   nAD = 13'o01762 >> 2;
#`SIM_DELAY
   nSYNC = 0;
#`SIM_DELAY
#`SIM_DELAY
   nSYNC = 1;
   nAD = 13'o11762 >> 2;
#`SIM_DELAY
   nSYNC = 0;
#`SIM_DELAY
#`SIM_DELAY
   nSYNC = 1;
end

//_____________________________________________________________________________
//
// Instantiation modules under test
//
//
vp_034 vp_034_reg
(
   .PIN_RC(2'b10),
   .PIN_nAD(lat_nAD),
   .PIN_nD(lat_nD),
   .PIN_nDME(lat_nDME),
   .PIN_C(lat_C)
);

vp_034 vp_034_pio
(
   .PIN_RC(2'b01),
   .PIN_nAD({pio_D, pio_nC}),
   .PIN_nD({pio_B, pio_A}),
   .PIN_nDME(pio_nR),
   .PIN_C(pio_nST),
   .PIN_nCA(pio_nCA),
   .PIN_nCB(pio_nCB),
   .PIN_nCD(pio_nCD),
   .PIN_nCOM(pio_nCOM)
);

vp_034 vp_034_avic
(
   .PIN_RC(2'b11),
   .PIN_nAD({av_NC, av_nBS, av_nAD[12:2], nVIRQ, nSB}),
   .PIN_nD({av_V, av_A}),
   .PIN_nDME(nIAKI),
   .PIN_nCA(nSYNC),
   .PIN_nCB(nDIN),
   .PIN_nCD(nVIRI),
   .PIN_nCOM(nRPLY)
);
endmodule

