//
// Copyright (c) 2021 by 1801BM1@gmail.com
//
// FDC mode testbench
//______________________________________________________________________________
//
`timescale 1ns / 100ps
`define  SIM_DELAY 100
`define  SIM_HDELAY 50

`define  FRC 6'b001111        // chip configuration
`define  CSR 16'o177170       // control & status register
`define  DAT 16'o177172       // data register


//______________________________________________________________________________
//
module fdc(
   output   PIN_nSHIFT,       // serial clock
   output   PIN_nOUT,
   output   PIN_nDI,
   input    PIN_nDO,
   input    PIN_nRUN,
   input    PIN_nSET,
   output   PIN_nERR,
   output   PIN_nDONE,
   output   PIN_nTR
);

reg   CLK;
reg   nSH;
reg   nOUT;
reg   nDI;
wire  nDO;
wire  nRUN;
wire  nSET;
reg   nERR;
reg   nDONE;
reg   nTR;

reg [2:0] stat;
reg [3:0] cnt;
reg [8:0] cmd;
reg [7:0] dat;

assign PIN_nSHIFT = nSH;
assign PIN_nOUT = nOUT;
assign PIN_nDI = nDI;
assign PIN_nERR = nERR;
assign PIN_nDONE = nDONE;
assign PIN_nTR = nTR;

assign nDO = PIN_nDO;
assign nRUN = PIN_nRUN;
assign nSET = PIN_nSET;

//_____________________________________________________________________________
//
// Clock generator
//
initial
begin
   CLK = 1'b0;
#`SIM_HDELAY
   forever #`SIM_DELAY CLK = ~CLK;
end

initial
begin
   nSH   = 1'b1;
   nOUT  = 1'b1;
   nDI   = 1'b1;
   nERR  = 1'b1;
   nDONE = 1'b1;
   nTR   = 1'b1;
   stat  = 3'b000;
end

always @(negedge nSET or posedge CLK)
begin
   if (~nSET)
   begin
      nSH   = 1'b1;
      nOUT  = 1'b1;
      nDI   = 1'b1;
      nERR  = 1'b1;
      nDONE = 1'b1;
      nTR   = 1'b1;
      stat  = 3'b000;
   end
   else
      case(stat)
      3'b000:     // wait command
         begin
            nDONE = 1'b0;
            if (~nRUN)
            begin
               nDONE = 1'b1;
               cnt = 4'h8;
               cmd = {8'b0, ~nDO};
               stat = 3'b001;
            end
         end
      3'b001:     // get command
         begin
            if (nSH)
            begin
               cmd = {cmd[7:0], ~nDO};
               nSH = 1'b0;
            end
            else
            begin
               nSH = 1'b1;
               cnt = cnt - 4'h1;
               if (cnt == 4'h0)
               begin
                  $display("FDC cmd: %03O", cmd);
                  stat = 3'b010;
               end
            end
         end
      3'b010:     // analyze command
         case(cmd[4:1])
         3'b000:  // write buffer
            begin
               nTR = 1'b0;
               stat = 3'b011;
            end
         3'b001:  // read buffer
            begin
               nOUT = 1'b0;
               stat = 3'b101;
               dat = 8'o054;
               cnt = 7;
               nDI = ~dat[7];
            end
         default:       // unrecognized
            begin
               stat = 3'b000;
               nDONE = 1'b0;
               nERR = 1'b0;
            end
         endcase
      3'b011:
         if (~nRUN)
         begin
            nTR = 1'b1;
            dat = {7'b0, ~nDO};
            cnt = 4'h8;
            stat = 4'b100;
         end
      3'b100:  // write buffer data
         begin
            if (nSH)
            begin
               dat = {dat[6:0], ~nDO};
               nSH = 1'b0;
            end
            else
            begin
               nSH = 1'b1;
               cnt = cnt - 4'h1;
               if (cnt == 4'h0)
               begin
                  $display("FDC dat: %03O", dat);
                  stat = 3'b000;
                  nDONE = 1'b0;
                  nERR = 1'b1;
               end
            end
         end
      3'b101:  // read buffer data
         begin
            if (nSH)
            begin
               dat = {dat[6:0], ~nDO};
               nSH = 1'b0;
               nDI = ~dat[7];
            end
            else
            begin
               nSH = 1'b1;
               cnt = cnt - 4'h1;
               if (cnt == 4'h0)
               begin
                  $display("FDC dat: %03O", dat);
                  stat = 3'b110;
                  nTR = 1'b0;
               end
            end
         end
      3'b110:  // read buffer data
         begin
            if (~nRUN)
            begin
               stat = 3'b000;
               nDONE = 1'b0;
               nERR = 1'b1;
               nOUT = 1'b1;
               nTR = 1'b1;
            end
         end
      endcase
end
endmodule

//______________________________________________________________________________
//
module tb_fdc();
//
// 1801VP1-033 FDC mode simulation testbench
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

wire        RDO;     // unused
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
vp_033 vp_fdc
(
   .PIN_RC(`FRC),
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
