//
// Copyright (c) 2016 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            20000000
`define  SIM_DELAY                        100

//______________________________________________________________________________
//
module tb_095();
//
// 1801VP1-095 pins
//
reg [2:1] RC;     // configuration
reg nSYNCC, nSYNCP;
reg nDLA, nDLD, nDLV, nCLD;
reg nWWC, nRDC;
reg nWWP, nRDP;
reg nINITP;
wire nBSI, nBSO;

wire [1:0] nCMPC;
wire [1:0] nCMPP;
wire nRQ, nWD;
tri1 [21:0] nADC;
tri1 [15:0] nADP;
tri1 [10:0] nADC_GAP;

reg [21:0] ADC;
reg [15:0] ADP;
reg ADC_OE;
reg ADP_OE;

integer a;

//_____________________________________________________________________________
//
// Simulation time limit (first breakpoint)
//
initial
begin
//#`SIM_CONFIG_TIME_LIMIT  $stop;
end

//_____________________________________________________________________________
//
assign nADC = ADC_OE ? ~ADC : 22'hzzzzz;
assign nADP = ADP_OE ? ~ADP : 16'hzzzzz;

//_____________________________________________________________________________
//
initial
begin
   RC[2:1] = 2'b00;

   ADC_OE = 0;
   ADP_OE = 0;
   ADC = 22'h000000;
   ADP = 16'h0000;

   nINITP = 0;
   nSYNCC = 1;
   nSYNCP = 1;
   nDLA = 1;
   nDLD = 1;
   nDLV = 1;
   nCLD = 1;

   nWWC = 1;
   nRDC = 1;
   nWWP = 1;
   nRDP = 1;

#(`SIM_DELAY   * 2)
   nINITP = 1;

   cpu_addr(22'O00177130);
   cpu_addr(22'O00177132);

   pio_addr(16'O177130);
   pio_addr(16'O177132);

   RC[2:1] = 2'b00;
   $display("Configuration RC[2:1]=%b", RC[2:1]);
   cmpc_scan();
   cmpp_scan();
   ivec_scan();
   pdr_scan();

   RC[2:1] = 2'b01;
   $display("Configuration RC[2:1]=%b", RC[2:1]);
   cmpc_scan();
   cmpp_scan();
   ivec_scan();
   pdr_scan();

   RC[2:1] = 2'b10;
   $display("Configuration RC[2:1]=%b", RC[2:1]);
   cmpc_scan();
   cmpp_scan();
   ivec_scan();
   pdr_scan();

   RC[2:1] = 2'b11;
   $display("Configuration RC[2:1]=%b", RC[2:1]);
   cmpc_scan();
   cmpp_scan();
   ivec_scan();
   pdr_scan();

   $display("Done");
   $stop;
end

task ivec_scan();
begin
   ADC = 0;
   ADC_OE = 0;

   $display("Scanning vector QBus (%b)..", RC[2:1]);
   nDLV = 0;
#(`SIM_DELAY * 2)
   $display("%o", ~nADC[7:0]);
   nDLV = 1;
end
endtask

task cmpc_scan();
begin
   ADC = 0;
   ADC_OE = 1;

   $display("Scanning central QBus (%b)..", RC[2:1]);
   for(a='o17600000; a<'o20000000; a=a+1)
   begin
      ADC = a;
#`SIM_DELAY
      if (nCMPC == 2'b00)
         $display("  %o, %b", a, nCMPC);
   end
   ADC_OE = 0;
end
endtask

task cmpp_scan();
begin
   ADP = 0;
   ADP_OE = 1;

   $display("Scanning peripheral QBus (%b)..", RC[2:1]);
   for(a='o000000; a<'o200000; a=a+1)
   begin
      ADP = a;
#`SIM_DELAY
      if (nCMPP == 2'b00)
         $display("  %o, %b", a, nCMPP);
   end
   ADP_OE = 0;
end
endtask

task pdr_scan();
begin
   ADP = 0;
   ADP_OE = 1;

   $display("Scanning data request QBus (%b)..", RC[2:1]);
   for(a='o000000; a<'o200000; a=a+'o40000)
   begin
      ADP = a;
#`SIM_DELAY
#`SIM_DELAY
      if (nWD == 0)
         $display("  %o, %b", a, nWD);
   end
   ADP_OE = 0;
end
endtask

task cpu_addr
(
   input [21:0]  addr
);
begin
   ADC = addr;
   ADC_OE = 1;
#`SIM_DELAY
   nSYNCC = 0;

#`SIM_DELAY
   ADC_OE = 0;

#`SIM_DELAY
   nSYNCC = 1;
end
endtask

task pio_addr
(
   input [15:0]  addr
);
begin
   ADP = addr;
   ADP_OE = 1;
#`SIM_DELAY
   nSYNCP = 0;

#`SIM_DELAY
   ADP_OE = 0;

#`SIM_DELAY
   nSYNCP = 1;
end
endtask

//_____________________________________________________________________________
//
// Instantiation modules under test
//
vp_095 low_b
(
   .PIN_nADC({nADC[18:16], nADC_GAP, nADC[7:0]}),
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

vp_095 high_b
(
   .PIN_nADC({nADC[21:19], nADC_GAP, nADC[15:8]}),
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
endmodule
