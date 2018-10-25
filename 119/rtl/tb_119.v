//
// Copyright (c) 2016 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//
// External clock frequency
//
`define  SIM_CONFIG_CLOCK_REFREQ          5000
`define  SIM_CONFIG_CLOCK_HPERIOD         100
`define  SIM_DELAY                        25
`define  SIM_DELAY_TA                     50
`define  SIM_EDAC                         10
//
// Simulation stops (breakpoint) after this time elapsed
//
`define  SIM_CONFIG_TIME_LIMIT            2000000
`define  TA_VALUE                         1'b0

//______________________________________________________________________________
//
// EDAC 74ls630 module definition
//
//   s1 s0                          db    cb    sef   def
//    0  0  generate check word     in    out    0     0
//    0  1  read data and check     in    in     0     0
//    1  0  correct data            out   out    f     f
//    1  1  latch data and check    in    in     f     f
//
module ls_630
(
   inout    [15:0] db,
   inout    [5:0] cb,
   input    [1:0] s,
   output   sef,
   output   def
);

reg   [15:0] dlat;
wire  [15:0] dout;
wire  [21:0] derr;
reg   [5:0] clat;
wire  [5:0] cout;

assign db = (s == 2'b10) ? dout : 16'hZZZZ;
assign cb = (s[0] == 1'b0) ? cout : 6'bZZZZZZ;

always @(*)
if (s[1] == 1'b0)
begin
   dlat = db;
   clat = cb;
end

assign cout[0] = ^(dlat[15:0] & 16'b0010011100011011) ^ ((s == 2'b00) | clat[0]);
assign cout[1] = ^(dlat[15:0] & 16'b0100100101101101) ^ ((s == 2'b00) | clat[1]);
assign cout[2] = ^(dlat[15:0] & 16'b1001001010110110) ^ ((s == 2'b00) | clat[2]);
assign cout[3] = ^(dlat[15:0] & 16'b0001110011000111) ^ ((s == 2'b00) | clat[3]);
assign cout[4] = ^(dlat[15:0] & 16'b1110000011111000) ^ ((s == 2'b00) | clat[4]);
assign cout[5] = ^(dlat[15:0] & 16'b1111111100000000) ^ ((s == 2'b00) | clat[5]);

assign derr[0]  = (cout[5:0] == 6'b110100);
assign derr[1]  = (cout[5:0] == 6'b110010);
assign derr[2]  = (cout[5:0] == 6'b110001);
assign derr[3]  = (cout[5:0] == 6'b101100);
assign derr[4]  = (cout[5:0] == 6'b101010);
assign derr[5]  = (cout[5:0] == 6'b101001);
assign derr[6]  = (cout[5:0] == 6'b100101);
assign derr[7]  = (cout[5:0] == 6'b100011);
assign derr[8]  = (cout[5:0] == 6'b011100);
assign derr[9]  = (cout[5:0] == 6'b011010);
assign derr[10] = (cout[5:0] == 6'b010110);
assign derr[11] = (cout[5:0] == 6'b010101);
assign derr[12] = (cout[5:0] == 6'b010011);
assign derr[13] = (cout[5:0] == 6'b001110);
assign derr[14] = (cout[5:0] == 6'b001101);
assign derr[15] = (cout[5:0] == 6'b001011);
assign derr[16] = (cout[5:0] == 6'b111110);
assign derr[17] = (cout[5:0] == 6'b111101);
assign derr[18] = (cout[5:0] == 6'b111011);
assign derr[19] = (cout[5:0] == 6'b110111);
assign derr[20] = (cout[5:0] == 6'b101111);
assign derr[21] = (cout[5:0] == 6'b011111);

assign dout = dlat ^ derr[15:0];
assign sef = s[1] & (cout[5:0] != 6'b111111);
assign def = s[1] & ~^derr[21:0];
endmodule

//______________________________________________________________________________
//
// EDAC 74LS630 testbench
//
module tb_630();

tri1  [15:0] db;
tri1  [5:0] cb;
reg   [15:0] d;
reg   [5:0] c;
reg [1:0] s;
wire def, sef;
integer i, x;

ls_630 edac
(
      .db(db),
      .cb(cb),
      .s(s),
      .sef(sef),
      .def(def)
);

assign db = (s != 2'b10) ? d : 16'hZZZZ;
assign cb = (s[0] == 1'b1) ? c : 6'bZZZZZZ;

initial
begin
      s = 0;
      d = 0;
      c = 0;
      $display("Generate check word");

      for (i=0; i <= 16'hFFFF; i = i + 1)
      begin
        s = 0;
         d = i[15:0];
         #(`SIM_DELAY);
         c = cb;
         #(`SIM_DELAY);

         for(x=0; x<16; x = x + 1)
         begin
            s = 2'b01;
            d[x] = ~d[x];
            #(`SIM_EDAC);
            s = 2'b10;
            #(`SIM_EDAC);
            d[x] = ~d[x];
            if (db != d)
            begin
              $display("Error D(%06O, %06O, %06O, %d)", i, d, db, x);
              $stop;
            end
         end
         for(x=0; x<6; x = x + 1)
         begin
            s = 2'b01;
            c[x] = ~c[x];
            #(`SIM_EDAC);
            s = 2'b10;
            #(`SIM_EDAC);
            c[x] = ~c[x];
            if (db != d)
            begin
              $display("Error C(%06O, %06O, %06O, %d)", i, d, db, x);
              $stop;
            end
         end
      end
      $stop;
end
endmodule

//______________________________________________________________________________
//
module k155_li1
(
   input       x0,
   input       x1,
   output reg  y0
);
wire f0;

assign f0 = x0 & x1;

always @(negedge f0) #27 y0 = 1'b0;
always @(posedge f0) #19 y0 = 1'b1;
endmodule

//______________________________________________________________________________
//
module tb_119();
//
// 1801VP1-119 pins
//
reg         CLK;
reg         RCLK;
reg         nDCLO;
reg         DCE, DEF;
reg [21:0]  A;
reg         nSEL;
reg         nHLTM;
reg         nTA;
reg         nSYNC;
reg         nDIN;
reg         nDOUT;
reg         nWTBT;
reg         nSACK;
reg         ERRF;

tri1        nRPLY;
tri1        nFRPY;
wire        LA;
wire        nESYNC;
wire        nRAS0;
wire        nRAS1;
wire        nCAS;
wire        nWE;
wire        nWEC;
wire        S0;
wire        S1;

wire        nRB;
wire        CB0;
wire        CB1;
wire        nSROM;
wire        nSRAM0;
wire        nSRAM1;
wire        nIN;
wire        nOUT;

//_____________________________________________________________________________
//
// Internal testbench varialbles
//
reg         nRU5_RAS0;
reg         nRU5_RAS1;

//_____________________________________________________________________________
//
// Clock generator (10 MHz typical)
//
initial
begin
   CLK = 1'b0;
#`SIM_CONFIG_CLOCK_HPERIOD
   forever #`SIM_CONFIG_CLOCK_HPERIOD CLK = ~CLK;
end

initial
begin
   RCLK = 1'b0;
#`SIM_CONFIG_CLOCK_REFREQ
   forever #`SIM_CONFIG_CLOCK_REFREQ RCLK = ~RCLK;
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
k155_li1 ru5_ras0(.x0(nRAS0), .x1(nRAS0), .y0(RU5_nRAS0));
k155_li1 ru5_ras1(.x0(nRAS1), .x1(nRAS1), .y0(RU5_nRAS1));

always @(*) DEF = ~S0 & S1 & ERRF;

//_____________________________________________________________________________
//
initial
begin
   nRU5_RAS0 = 1;
   nRU5_RAS1 = 1;

   ERRF     = 0;
   nDCLO    = 0;
   DCE      = 0;
   A        = 22'O17777777;
   nSEL     = 1;
   nHLTM    = 1;
   nTA      = 1;
   nDOUT    = 1;
   nDIN     = 1;
   nSYNC    = 1;
   nWTBT    = 1;
   nSACK    = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*12)
   nDCLO    = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4)

   nSEL = 0;
   read_word(22'O00014000);
   write_word(22'O00014000, 16'O177777);
   write_byte(22'O00014000, 16'O000001);
   write_byte(22'O00014001, 16'O001400);

   nSEL = 1;
   read_word(22'O00000000);
   read_word(22'O00000000);
   read_word(22'O00000000);
   read_word(22'O00000000);
   read_word(22'O00000000);
   write_word(22'O00000000, 16'O177777);
   write_byte(22'O00000000, 16'O000001);
   write_byte(22'O00000001, 16'O001400);

   DCE      = 1;
   read_word(22'O00000000);
   read_word(22'O00000000);
   write_word(22'O00000000, 16'O177777);
   write_byte(22'O00000000, 16'O000001);
   write_byte(22'O00000001, 16'O001400);

   ERRF     = 1;
   read_word(22'O00000000);

end

task read_word
(
   input [21:0]  addr
);
begin
   nSYNC    = 1;
   nDIN     = 1;
   nDOUT    = 1;
   nWTBT    = 1;
@ (negedge CLK);
#(`SIM_DELAY);
   A        = addr;
#(`SIM_DELAY_TA);
   nTA      = `TA_VALUE;
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNC    = 0;
@ (negedge nESYNC);
@ (negedge CLK);
#(`SIM_DELAY);
   nTA      = 1;
   A        = 22'O17777777;
   nDIN     = 0;
@ (negedge nRPLY);
@ (negedge CLK);
#(`SIM_DELAY);
   nDIN     = 1;
@ (posedge nRPLY);
#(`SIM_DELAY);
   nSYNC    = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task write_word
(
   input [21:0]  addr,
   input [15:0]  data
);
begin
   nSYNC    = 1;
   nDIN     = 1;
   nDOUT    = 1;
@ (negedge CLK);
#(`SIM_DELAY);
   A        = addr;
#(`SIM_DELAY_TA);
   nTA      = 1;
   nWTBT    = 0;
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNC    = 0;
@ (negedge nESYNC);
@ (negedge CLK);
#(`SIM_DELAY);
   nTA      = 1;
   A        = 22'O17777777;
   nWTBT    = 1;
#(`SIM_DELAY);
   nDOUT    = 0;
@ (negedge nRPLY);
@ (negedge CLK);
#(`SIM_DELAY);
   nDOUT    = 1;
   nSYNC    = 1;
@ (posedge nRPLY);
#(`SIM_DELAY);
// nSYNC    = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

task write_byte
(
   input [21:0]  addr,
   input [15:0]  data
);
begin
   nSYNC    = 1;
   nDIN     = 1;
   nDOUT    = 1;
@ (negedge CLK);
#(`SIM_DELAY);
   A        = addr;
#(`SIM_DELAY_TA);
   nTA      = 1;
   nWTBT    = 0;
@ (posedge CLK);
#(`SIM_DELAY);
   nSYNC    = 0;
@ (negedge nESYNC);
@ (negedge CLK);
#(`SIM_DELAY);
   nTA      = 1;
   A        = 22'O17777777;
   nWTBT    = 0;
#(`SIM_DELAY);
   nDOUT    = 0;
@ (negedge nRPLY);
@ (negedge CLK);
#(`SIM_DELAY);
   nDOUT    = 1;
   nSYNC    = 1;
   nWTBT    = 1;
@ (posedge nRPLY);
#(`SIM_DELAY);
// nSYNC    = 1;
// nWTBT    = 1;
@ (negedge CLK);
#(`SIM_CONFIG_CLOCK_HPERIOD);

end
endtask

//_____________________________________________________________________________
//
// Instantiation module under test
//
vp_119 memc
(
   .PIN_CLK(CLK),                // primary clock
   .PIN_RCLK(RCLK),              // refresh clock
   .PIN_nDCLO(nDCLO),            // system reset
                                 //
   .PIN_DCE(DCE),                // error correction
   .PIN_DEF(DEF),                // unit control
                                 //
   .PIN_nA21(nSEL & ~A[20]),     // inverted A21 (DRAM address decoder)
   .PIN_nA20(~A[20]),            // inverted A20 (DRAM address decoder)
   .PIN_nA19(~A[19]),            // inverted A19
   .PIN_nA12(~A[12]),            // inverted A12
   .PIN_nA11(~A[11]),            // inverted A11
   .PIN_nA0(~A[0]),              // inverted A0
                                 //
   .PIN_nSEL(nSEL),              // special supervisor mode, nSEL VM3
   .PIN_nHLTM(nHLTM),            // halt mode
                                 //
   .PIN_nSYNC(nSYNC),            //
   .PIN_nDIN(nDIN),              //
   .PIN_nDOUT(nDOUT),            //
   .PIN_nWTBT(nWTBT),            //
   .PIN_nSACK(nSACK),            //
   .PIN_nTA(nTA),                //
                                 //
   .PIN_nLA(LA),                 //
   .PIN_nESYNC(nESYNC),          //
   .PIN_nRPLY(nRPLY),            // open collector
   .PIN_nFRPL(nFRPY),            // open collector
                                 //
   .PIN_nRAS0(nRAS0),            //
   .PIN_nRAS1(nRAS1),            //
   .PIN_nCAS(nCAS),              //
   .PIN_nWE(nWE),                //
   .PIN_nWEC(nWEC),              //
                                 //
   .PIN_S0(S0),                  //
   .PIN_S1(S1),                  //
                                 //
   .PIN_nRB(nRB),                //
   .PIN_CB0(CB0),                //
   .PIN_CB1(CB1),                //
   .PIN_nSROM(nSROM),            //
   .PIN_nCS0(nSRAM0),            //
   .PIN_nCS1(nSRAM1),            //
   .PIN_nIN(nIN),                //
   .PIN_nOUT(nOUT)               //
);
endmodule
