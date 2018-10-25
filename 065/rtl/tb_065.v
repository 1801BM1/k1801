//
// Copyright (c) 2013-2014 by 1801BM1@gmail.com
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
`define  SIM_CONFIG_TIME_LIMIT            2000000

//______________________________________________________________________________
//
module tb_065();
//
// 1801VP1-065 pins
//
tri1  [15:0]   nAD;
reg   [15:0]   AD_in;
reg   [15:0]   AD_out;
reg   [15:0]   AD_vec;
reg            AD_oe;

reg            nINIT;
reg            nSYNC;
reg            nDIN;
reg            nDOUT;
reg            nDCLO;
reg            nBS;
tri1           nRPLY;
tri1           nVIRQ;
wire  [1:0]    nEVNT;
tri1  [1:0]    nSEL;
reg            nIAKI;
wire  [1:0]    nIAKO;
reg            CLK;

wire           TXD, DTR, RXD, CTS;

reg   [15:0]   sym0, sym1;

//_____________________________________________________________________________
//
// Clock generator (4608kHz / 9216kHz typical)
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


//______________________________________________________________________________
//
assign nAD = AD_oe ? AD_in[15:0] : 16'hZZZZ;

// assign RXD = 1'b0;
// assign CTS = 1'b0;

initial
begin
   sym0     = 16'O00040;
   sym1     = 16'O00245;

   AD_out   = 0;
   AD_vec   = 0;
   AD_in    = 0;
   AD_oe    = 0;
   nBS      = 1;
   nIAKI    = 1;
   nDOUT    = 1;
   nDIN     = 1;
   nSYNC    = 1;
   nDCLO    = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*24)
   nDCLO    = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4)

   nINIT    = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*24)
   nINIT    = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4)
   nINIT    = 1;

   qbus_read(16'O177560);
   qbus_write(16'O177560, 16'O000100);

   qbus_read(16'O177564);
   qbus_write(16'O177564, 16'O000101);

   qbus_read(16'O176560);
   qbus_write(16'O176560, 16'O000100);

   qbus_read(16'O176564);
   qbus_write(16'O176564, 16'O000100);

#(`SIM_CONFIG_CLOCK_HPERIOD*100)

forever
begin
   if (~nVIRQ)
   begin
      qbus_inta();
      case(AD_vec)
         16'O000060:
         begin
            qbus_read(16'O177562);
            $display("RX0: %06O", AD_out);
         end
         16'O000064:
         begin
            qbus_write(16'O177566, sym0);
            $display("TX0: %06O", sym0);
            sym0 = sym0 + 16'O000001;
         end
         16'O000360:
         begin
            qbus_read(16'O176562);
            $display("RX1: %06O", AD_out);
         end
         16'O000364:
         begin
            qbus_write(16'O176566, sym1);
            $display("TX1: %06O", sym1);
            sym1 = sym1 + 16'O000001;
         end
         default:
         begin
            $display("Invalid vector %O", AD_vec);
         end
      endcase
   end
   else
   begin
#(`SIM_CONFIG_CLOCK_HPERIOD*8);
   end
end
end

task qbus_write
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nBS   = 0;
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
   nBS   = 1;
end
endtask

task qbus_read
(
   input [15:0]  addr
);
begin
   nBS   = 0;
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
   nBS   = 1;
end
endtask

task qbus_inta();
begin
   nBS   = 1;
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
   nBS   = 1;
end
endtask

//_____________________________________________________________________________
//
// Instantiation module under test
//
vp_065 master
(
   .PIN_nAD(nAD),
   .PIN_nINIT(nINIT),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nBS(nBS),
   .PIN_nDCLO(nDCLO),
   .PIN_nIAKI(nIAKI),
   .PIN_nIAKO(nIAKO[0]),
   .PIN_nRPLY(nRPLY),
   .PIN_nVIRQ(nVIRQ),
   .PIN_nEVNT(nEVNT[0]),
   .PIN_nSEL(nSEL[0]),
   .PIN_nTF(TXD),
   .PIN_nRR(DTR),
   .PIN_nIP(RXD),
   .PIN_nBSYD(1'b0/* CTS*/),
   .PIN_CLK(CLK),
   .PIN_ACL0(1'b0),  // 177560 060/064
   .PIN_ACL1(1'b0),
   .PIN_NB0(1'b1),
   .PIN_NP(1'b0),
   .PIN_PEV(1'b1),
   .PIN_FR(4'b1100), // 115200 @ 9216kHz
   .GND(1'b0),
   .VCC(1'b1)
);

vp_065 slave
(
   .PIN_nAD(nAD),
   .PIN_nINIT(nINIT),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nBS(nBS),
   .PIN_nDCLO(nDCLO),
   .PIN_nIAKI(nIAKO[0]),
   .PIN_nIAKO(nIAKO[1]),
   .PIN_nRPLY(nRPLY),
   .PIN_nVIRQ(nVIRQ),
   .PIN_nEVNT(nEVNT[1]),
   .PIN_nSEL(nSEL[1]),
   .PIN_nTF(RXD),
   .PIN_nRR(CTS),
   .PIN_nIP(TXD),
   .PIN_nBSYD(/*1'b0*/ DTR),
   .PIN_CLK(CLK),
   .PIN_ACL0(1'b1),  // 176560 360/364
   .PIN_ACL1(1'b0),
   .PIN_NB0(1'b1),
   .PIN_NP(1'b0),
   .PIN_PEV(1'b1),
   .PIN_FR(4'b1100), // 115200 @ 9216kHz
   .GND(1'b0),
   .VCC(1'b1)
);

endmodule
