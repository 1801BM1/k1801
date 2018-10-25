//
// Copyright (c) 2013 by 1801BM1@gmail.com
//
// The reformatted Verilog HDL model of 1801VP1-037
// 17-Oct-2015 - PIN_nE corrected
//______________________________________________________________________________
//
`timescale 1ns / 100ps

module va_037
(
   input       PIN_CLK,       //
   input       PIN_R,         //
   input       PIN_C,         //
                              //
   inout[15:0] PIN_nAD,       // Address/Data inverted bus
   input       PIN_nSYNC,     //
   input       PIN_nDIN,      //
   input       PIN_nDOUT,     //
   input       PIN_nWTBT,     //
   output      PIN_nRPLY,     //
                              //
   output[6:0] PIN_A,         //
   output[1:0] PIN_nCAS,      //
   output      PIN_nRAS,      //
   output      PIN_nWE,       //
                              //
   output      PIN_nE,        //
   output      PIN_nBS,       //
   output      PIN_WTI,       //
   output      PIN_WTD,       //
   output      PIN_nVSYNC     //
);

//______________________________________________________________________________
//
reg            nWTBT;         // BYTE flag
reg [15:0]     A;             // Q-bus address latch
reg [7:0]      RA;            // 177664 register start address
reg            M256;          // 1/4 screen mode
                              //
wire           RWR, ROE;      // 177664 register strobes
                              //
wire           RESET;         // external reset
wire           CLKIN;         // external clock (pixel/2)
                              //
reg [2:0]      PC;            // pixel counter
reg [13:1]     VA;            // video address counter
reg [7:0]      LC;            // line counter
                              //
wire           ALOAD, TV51;   // base address load strobe
reg            HGATE, VGATE;  //
reg            PC90;          //
reg            RASEL, AMUXSEL;//
wire           CAS;           //
reg            CAS322;        //
wire           FREEZ;         //
                              //
reg            VTSYN;         //
wire           SYNC2, SYNC5;  //
                              //
wire           RPLY;          //
reg            TRPLY;         //
                              //
//______________________________________________________________________________
//
assign PIN_nRPLY        = ~(ROE | RWR | RPLY);
assign PIN_nAD[7:0]     = ~ROE ? 8'hZZ : ~RA[7:0];    // read 177664 register back
assign PIN_nAD[8]       = 1'bZ;                       //
assign PIN_nAD[9]       = ~ROE ? 1'bZ  : ~M256;       //
assign PIN_nAD[14:10]   = 5'hZZ;                      //
assign PIN_nAD[15]      = (~PIN_nDIN & ~PIN_nSYNC &   // start address vector 177716
                          (A[15:1] == (16'o177716 >> 1))) ? 1'b0 : 1'bZ;

assign PIN_nE  = PIN_nSYNC | PIN_nDIN | (A[15:7] == (16'o177600 >> 7));
assign PIN_nBS = ~(A[15:2] == (16'o177660 >> 2));

always @(*) if (PIN_nDOUT) nWTBT <= PIN_nWTBT;

assign RWR     = ~PIN_nSYNC & ~PIN_nDOUT & (A[15:1] == (16'o177664 >> 1));
assign ROE     = ~PIN_nSYNC & ~PIN_nDIN  & (A[15:1] == (16'o177664 >> 1));
assign RESET   = PIN_R;
assign CLKIN   = PIN_CLK;

always @(*) if (PIN_nSYNC) A[15:0] = ~PIN_nAD[15:0];
always @(*) if (RWR) RA[7:0] = ~PIN_nAD[7:0];
always @(*) if (RWR) M256 = ~PIN_nAD[9];
always @(*) if (RASEL) TRPLY = 1'b1; else if (PIN_nDIN & PIN_nDOUT) TRPLY = 1'b0;
assign RPLY = TRPLY & ~RASEL;

//______________________________________________________________________________
//
// Pixel counter (within word)
//
always @(negedge CLKIN) if (~PC[0]) PC90 <= PC[1];
always @(negedge CLKIN or posedge RESET)
begin
   if (RESET)
      PC[2:0] <= 3'b000;
   else
      PC[2:0] <= PC[2:0] + 3'b001;
end

//
// Word counter (within line)
//
always @(negedge CLKIN or posedge RESET)
begin
   if (RESET)
      VA[5:1] <= 5'b00000;
   else
      if (&PC[2:0])
      begin
         VA[4:1] <= VA[4:1] + 4'b0001;
         if (&VA[4:1] & ~HGATE)  VA[5] <= ~VA[5];
      end
end
//
// Test clock assignment
//
assign TV51 = PIN_C ? 1'b0 : ~(&PC[2:0] & &VA[5:1]);
//
// RWR at active RESET is added for simulation and debug purposes
//
assign ALOAD = (FREEZ & ~LC[1]) | (RESET & RWR);
//
// Loadable part of video address counter
//
always @(negedge CLKIN)
begin
   if (ALOAD)
      VA[13:6] <= RA[7:0];
   else
      if (~TV51 & ~FREEZ)
         VA[13:6] <= VA[13:6] + 8'b00000001;
end

always @(negedge CLKIN or posedge RESET)
begin
   if (RESET)
   begin
      HGATE <= 1'b0;
      VGATE <= 1'b1;
   end
   else
   begin
      if (&PC[2:0] & &VA[4:1] & (HGATE | VA[5]))
         HGATE <= ~HGATE;
      if (~TV51 & (LC[5:0] == 6'b000000) & (VGATE | (LC[7:6] == 2'b00)))
         VGATE <= ~VGATE;
   end
end
//
// Line counter
//
always @(negedge CLKIN or posedge RESET)
begin
   if (RESET)
      LC[7:0] <= 8'b11111111;
   else
      if (~TV51)
      begin
         LC[5:0] <= LC[5:0] - 6'b000001;
         if ((LC[5:0] == 6'b000000) & ~VGATE) LC[6] <= ~LC[6];
         if ( LC[6:0] == 7'b0000000) LC[7] <= ~LC[7];
      end
end

assign FREEZ = VGATE & (LC[5:2] == 4'b1010);
//______________________________________________________________________________
//
// DRAM address mux and controls
//
assign PIN_A[6:0]    = RASEL ? (AMUXSEL ? ~A[7:1]  : ~A[14:8])
                             : (AMUXSEL ? ~VA[7:1] : {1'b0, ~VA[13:8]});
assign PIN_nCAS[0]   = ~(CAS & (~A[0] | ~PC[2] | nWTBT));
assign PIN_nCAS[1]   = ~(CAS & ( A[0] | ~PC[2] | nWTBT));
assign PIN_nRAS      =  PC90 | (PC[2] & ~RASEL);

assign PIN_WTI       = ~VGATE & ~HGATE & (M256 | (LC[6] & LC[7])) & PC90 & ~PC[2] & PC[1];
assign PIN_WTD       = RPLY & ~PIN_nDIN;
assign PIN_nWE       = ~(RASEL & ~PIN_nDOUT);
//
// Converted to synchronous flip-flop without asynch reset, generates the same waveform
//
// always @(posedge CLKIN or posedge (PC[1] & AMUXSEL))
// begin
//    if (PC[1] & AMUXSEL)
//       RASEL <= 1'b0;
//    else
//    if (PC90 & ~PC[1] & PC[2])
//       RASEL <= ~(PIN_nSYNC | A[15] | RPLY | (PIN_nDIN & PIN_nDOUT));
// end
//
always @(posedge CLKIN) AMUXSEL <= PC90;
always @(posedge CLKIN)
begin
   if (PC90 & PC[1])
      RASEL <= 1'b0;
   else
      if (PC90 & ~PC[1] & PC[2])
         RASEL <= ~(PIN_nSYNC | A[15] | RPLY | (PIN_nDIN & PIN_nDOUT));
end

always @(negedge CLKIN) CAS322 <= RASEL;
//assign CAS = ~(~(PC[1] & CAS322 & PC[2]) & (VGATE | HGATE | PC[2] | ~PC[1]));

assign CAS = (CAS322 & PC[1] & PC[2]) | (~VGATE & ~HGATE & PC[1] & ~PC[2]);

//______________________________________________________________________________
//
// Video synchronization
//
always @(negedge CLKIN or posedge RESET)
begin
   if (RESET)
      VTSYN <= 1'b0;
   else
   begin
      if ((VA[3:1] == 3'b000) & (PC[1:0] == 2'b11))
         VTSYN <= 1'b1;

      if ((VA[4:1] == 4'b0100) & (PC[2:0] == 3'b111))
         VTSYN <= 1'b0;
   end
end
//
// Latch converted to clock synchronous flip-flop, generates the same waveform
//
// assign VTSET = (VA[3:1] == 3'b000) & PC[2];
// assign VTCLR = (VA[4:1] == 4'b0101);
//
// always @(*)
// begin
//    if (VTCLR) VTSYN = 1'b0;
//    if (VTSET) VTSYN = 1'b1;
// end
//
assign SYNC2 = ~(VGATE & (LC[5:2] == 4'b1010) & ~(LC[0] & LC[1]));
assign SYNC5 =  VTSYN | (SYNC2 & ~HGATE);
assign PIN_nVSYNC = ~(SYNC2 ^ SYNC5);

//______________________________________________________________________________
//
endmodule
