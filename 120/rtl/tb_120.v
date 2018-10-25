//
// Copyright (c) 2016 by 1801BM1@gmail.com
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
module tb_120();
//
// 1801VP1-120 pins
//
tri1  [9:0] nADC;
reg   [9:0] ADC_out;
reg   [9:0] ADC_vec;
reg   [9:0] ADC_in;
reg         ADC_oe;

reg         nSYNCC;
reg         nDINC;
reg         nDOUTC;
reg         nINITC;
reg         nCSC;
tri1        nARC;
tri1        nRPLYC;

reg         nIAKIC;
wire        nIAKOC;
tri1        nVIRQC;

tri1  [7:0] nADP;
reg   [7:0] ADP_out;
reg   [7:0] ADP_vec;
reg   [7:0] ADP_in;
reg         ADP_oe;

reg         nSYNCP;
reg         nDINP;
reg         nDOUTP;
reg         nINITP;
reg         nCSP;
tri1        nRPLYP;

reg         nIAKIP;
wire        nIAKOP;
tri1        nVIRQP;

wire        A0;
wire        A1;
wire        nEP;
//
// Internal testbench varialbles
//
reg         CLK;
reg [15:0]  t0, t1, t2, r0, r1, r2;

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

//
// Simulation time limit (first breakpoint)
//
initial
begin
#`SIM_CONFIG_TIME_LIMIT $stop;
end

//______________________________________________________________________________
//
assign nADC = ADC_oe ? ADC_in[9:0] : 10'hZZZ;
assign nADP = ADP_oe ? ADP_in[7:0] : 8'hZZ;

//______________________________________________________________________________
//
// Central Processor Bus activity
//
initial
begin
   ADC_out  = 0;
   ADC_vec  = 0;
   ADC_in   = 0;
   ADC_oe   = 0;
   nCSC     = 1;
   nIAKIC   = 1;
   nDOUTC   = 1;
   nDINC    = 1;
   nSYNCC   = 1;
   nINITC   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*12)
   nINITC   = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4)

   t0       = 1;
   t1       = 0;
   t2       = 0;
   //
   // Channel 0
   //
   cpu_read(16'O177560);
   cpu_read(16'O177562);
   cpu_read(16'O177564);
   cpu_read(16'O177566);
   //
   // Channel 1
   //
   cpu_read(16'O176660);
   cpu_read(16'O176662);
   cpu_read(16'O176664);
   cpu_read(16'O176666);
   //
   // Channel 2
   //
   cpu_read(16'O176670);
   cpu_read(16'O176672);
   cpu_read(16'O176674);
   cpu_read(16'O176676);

   cpu_write(16'O177560, 16'O000100);  // 060   - rx0
   cpu_write(16'O177564, 16'O000100);  // 064   - tx0
   cpu_write(16'O176660, 16'O000100);  // 460   - rx1
   cpu_write(16'O176664, 16'O000100);  // 464   - tx1
   cpu_write(16'O176674, 16'O000100);  // 474   - tx2

#(`SIM_CONFIG_CLOCK_HPERIOD*100);
forever
begin
   if (~nVIRQC)
   begin
      cpu_inta();
      case(ADC_vec)
         16'O000060:
         begin
            cpu_read(16'O177562);
            $display("crx0: %06O", ADC_out);
            if (t1)
               $display("crx0: overflow");
            else
               t1 = ADC_out;
            cpu_read(16'O176664);
            if (ADC_out[7])
            begin
               cpu_write(16'O176666, t1);
               t1 = 0;
            end
         end
         16'O000460:
         begin
            cpu_read(16'O176662);
            $display("crx1: %06O", ADC_out);
            if (t2)
               $display("crx1: overflow");
            else
               t2 = ADC_out;
            cpu_read(16'O176674);
            if (ADC_out[7])
            begin
               cpu_write(16'O176676, t2);
               t2 = 0;
            end
         end
         16'O000064:
         begin
            if (t0)
            begin
               cpu_write(16'O177566, t0);
               $display("ctx0: %06O", t0);
               t0 = 0;
            end
            else
               $display("ctx0: done");
         end
         16'O000464:
         begin
            if (t1)
            begin
               cpu_write(16'O176666, t1);
               $display("ctx1: %06O", t1);
               t1 = 0;
            end
            else
               $display("ctx1: done");
         end
         16'O000474:
         begin
            if (t2)
            begin
               cpu_write(16'O176676, t2);
               $display("ctx2: %06O", t2);
               t2 = 0;
            end
            else
               $display("ctx2: done");
         end
         default:
         begin
            $display("Invalid vector %O", ADC_vec);
         end
      endcase
   end
   else
   begin
#(`SIM_CONFIG_CLOCK_HPERIOD*8);
      if (t0)
      begin
         cpu_read(16'O177564);
         if (ADC_out[7])
         begin
            cpu_write(16'O177566, t0);
            $display("sta0: %06O", t0);
            t0 = 0;
            r2 = 0;
         end
      end
   end
end
end
//
// Central Processor Qbus write
//
task cpu_write
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nIAKIC   = 1;
   nSYNCC   = 1;
   nDINC    = 1;
   nDOUTC   = 1;

   ADC_in   = ~addr;
   ADC_oe   = 1;
   nCSC     = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCC   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADC_in   = ~data;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nDOUTC   = 0;
@ (negedge nRPLYC);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCC   = 1;
   nDOUTC   = 1;
@ (posedge nRPLYC);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADC_oe   = 0;
   nCSC     = 1;
end
endtask

//
// Central Processor Qbus read
//
task cpu_read
(
   input [15:0]  addr
);
begin
   nIAKIC   = 1;
   nSYNCC   = 1;
   nDINC    = 1;
   nDOUTC   = 1;

   ADC_in   = ~addr;
   ADC_oe   = 1;
   nCSC     = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCC   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADC_oe   = 0;
   nDINC    = 0;
@ (negedge nRPLYC);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADC_out  = ~nADC;
   nSYNCC   = 1;
   nDINC    = 1;
@ (posedge nRPLYC);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nCSC     = 1;
end
endtask

//
// Central Processor Qbus Interrupt Acknowledgement
//
task cpu_inta();
begin
   nCSC     = 1;
   nIAKIC   = 1;
   nSYNCC   = 1;
   nDINC    = 1;
   nDOUTC   = 1;
   ADC_oe   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCC   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nIAKIC   = 0;
   nDINC    = 0;
@ (negedge nRPLYC);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADC_vec  = ~nADC;
   nSYNCC   = 1;
   nIAKIC   = 1;
   nDINC    = 1;
@ (posedge nRPLYC);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

//______________________________________________________________________________
//
// Peripheral Processor Bus activity
//
initial
begin
   ADP_out  = 0;
   ADP_vec  = 0;
   ADP_in   = 0;
   ADP_oe   = 0;
   nCSP     = 1;
   nIAKIP   = 1;
   nDOUTP   = 1;
   nDINP    = 1;
   nSYNCP   = 1;
   nINITP   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD*12)
   nINITP   = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4);

   r0       = 0;
   r1       = 0;
   r2       = 0;
   pio_write(16'O177066, 16'O000007);  // rx ints
   pio_write(16'O177076, 16'O000003);  // tx ints

#(`SIM_CONFIG_CLOCK_HPERIOD*100);
forever
begin
   if (~nVIRQP)
   begin
      pio_inta();
      case(ADP_vec)
         16'O000320:
         begin
            pio_read(16'O177060);
            $display("prx0: %06O", ADP_out);
            if (r0)
               $display("prx0: overflow");
            else
               r0 = ADP_out;
            pio_read(16'O177076);
            if (ADP_out[3])
            begin
               pio_write(16'O177070, r0);
               r0 = 0;
            end
         end
         16'O000330:
         begin
            pio_read(16'O177062);
            $display("prx1: %06O", ADP_out);
            if (r1)
               $display("prx1: overflow");
            else
               r1 = ADP_out;
            pio_read(16'O177076);
            if (ADP_out[4])
            begin
               pio_write(16'O177072, r1);
               r1 = 0;
            end
         end
         16'O000340:
         begin
            pio_read(16'O177064);
            $display("prx2: %06O", ADP_out);
            if (r2)
               $display("prx2: overflow");
            else
               r2 = ADP_out;
            //
            // Test writing to 8255 PIO port A
            //
            pio_write(16'O177100, r2);

            t0 = r2 + 1;
            if (t0 == 0)
               t0 = 1;
         end
         16'O000324:
         begin
            if (r0 == 0)
               $display("ptx0: done");
            else
            begin
               pio_read(16'O177076);
               if (ADP_out[3])
               begin
                  pio_write(16'O177070, r0);
                  $display("ptx0: %06O", r0);
                  r0 = 0;
               end
            end
         end
         16'O000334:
         begin
            if (r1 == 0)
               $display("ptx1: done");
            else
            begin
               pio_read(16'O177076);
               if (ADP_out[4])
               begin
                  pio_write(16'O177072, r1);
                  $display("ptx1: %06O", r1);
                  r1 = 0;
               end
            end
         end
         default:
         begin
            $display("Invalid vector %O", ADP_vec);
         end
      endcase
   end
   else
   begin
#(`SIM_CONFIG_CLOCK_HPERIOD*8);
   end
end
end

//
// Peripheral Processor Qbus write
//
task pio_write
(
   input [15:0]  addr,
   input [15:0]  data
);
begin
   nIAKIP   = 1;
   nSYNCP   = 1;
   nDINP    = 1;
   nDOUTP   = 1;

   ADP_in   = ~addr;
   ADP_oe   = 1;
   nCSP     = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCP   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADP_in   = ~data;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nDOUTP   = 0;
@ (negedge nRPLYP);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCP   = 1;
   nDOUTP   = 1;
@ (posedge nRPLYP);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADP_oe   = 0;
   nCSP     = 1;
end
endtask

//
// Peripheral Processor Qbus read
//
task pio_read
(
   input [15:0]  addr
);
begin
   nIAKIP   = 1;
   nSYNCP   = 1;
   nDINP    = 1;
   nDOUTP   = 1;

   ADP_in   = ~addr;
   ADP_oe   = 1;
   nCSP     = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCP   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADP_oe   = 0;
   nDINP    = 0;
@ (negedge nRPLYP);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADP_out  = ~nADP;
   nSYNCP   = 1;
   nDINP    = 1;
@ (posedge nRPLYP);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nCSP     = 1;
end
endtask

//
// Peripheral Processor Qbus Interrupt Acknowledgement
//
task pio_inta();
begin
   nCSP     = 1;
   nIAKIP   = 1;
   nSYNCP   = 1;
   nDINP    = 1;
   nDOUTP   = 1;
   ADP_oe   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nSYNCP   = 0;
#(`SIM_CONFIG_CLOCK_HPERIOD);
   nIAKIP   = 0;
   nDINP    = 0;
@ (negedge nRPLYP);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   ADP_vec  = ~nADP;
   nSYNCP   = 1;
   nIAKIP   = 1;
   nDINP    = 1;
@ (posedge nRPLYP);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask

//_____________________________________________________________________________
//
// Instantiation module under test
//
vp_120 bridge
(
   .PIN_nADC(nADC),
   .PIN_nSYNCC(nSYNCC),
   .PIN_nDINC(nDINC),
   .PIN_nDOUTC(nDOUTC),
   .PIN_nINITC(nINITC),
   .PIN_nCSC(nCSC),
   .PIN_nARC(nARC),
   .PIN_nRPLYC(nRPLYC),
   .PIN_nIAKIC(nIAKIC),
   .PIN_nIAKOC(nIAKOC),
   .PIN_nVIRQC(nVIRQC),

   .PIN_nADP(nADP),
   .PIN_nSYNCP(nSYNCP),
   .PIN_nDINP(nDINP),
   .PIN_nDOUTP(nDOUTP),
   .PIN_nINITP(nINITP),
   .PIN_nCSP(nCSP),
   .PIN_nRPLYP(nRPLYP),

   .PIN_nIAKIP(nIAKIP),
   .PIN_nIAKOP(nIAKOP),
   .PIN_nVIRQP(nVIRQP),

   .PIN_A0(A0),
   .PIN_A1(A1),
   .PIN_nEP(nEP)
);
endmodule
