//
// Copyright (c) 2013 by 1801BM1@gmail.com
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
`define  SIM_CONFIG_TIME_LIMIT            1000000

//______________________________________________________________________________
//

module tb_128();
//
// 1801VP1-128 pins
//
tri1  [15:0]   nAD;
reg   [15:0]   AD_in;
reg   [15:0]   AD_out;
reg            AD_oe;

reg            CLK;
reg            nDIN;
reg            nDOUT;
reg            nSYNC;
reg            nINIT;
tri1           nRPLY;

wire [3:0]     nDS;
wire           nMSW;
wire           nST;
wire           DIR;
wire           HS;
wire           nWRE;
wire [3:1]     nDO;
wire           nREZ;
reg            nDI;
reg            IND;
reg            TR0;
reg            RDY;
reg            WRP;

//______________________________________________________________________________
//
assign nAD[15:0] = AD_oe ? AD_in[15:0] : 16'hZZZZ;

//_____________________________________________________________________________
//
// Clock generator (4MHz typical)
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
         AD_in = 0;
         AD_oe = 0;
         nDOUT = 1;
         nDIN  = 1;
         nSYNC = 1;
         nINIT = 0;
         nDI   = 1;
         IND   = 1;
         TR0   = 1;
         RDY   = 1;
         WRP   = 0;

#(`SIM_CONFIG_CLOCK_HPERIOD*2);
         nDI   = 0;
#250     nDI   = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*4);
         nINIT = 1;
#(`SIM_CONFIG_CLOCK_HPERIOD*2);

         qbus_write(16'O177130, 16'O000000);
         qbus_read (16'O177130);
         qbus_read (16'O177132);
         qbus_write(16'O177130, 16'O000000);
         qbus_read (16'O177130);
         qbus_write(16'O177130, 16'O000001);
//
//       qbus_write(16'O177130, 16'O000003);
//       qbus_write(16'O177130, 16'O000007);
//       qbus_write(16'O177130, 16'O000017);
//       qbus_write(16'O177130, 16'O000037);
//       qbus_write(16'O177130, 16'O000077);
//       qbus_write(16'O177130, 16'O000177);
//       qbus_write(16'O177130, 16'O000377);
//       qbus_read (16'O177130);
//       qbus_write(16'O177130, 16'O000400);
//       qbus_write(16'O177130, 16'O002000);
//       qbus_read (16'O177130);
//       qbus_write(16'O177130, 16'O000000);
//       qbus_read (16'O177130);
//

//______________________________________________________________________________
//
// *** Write data model start ***
//
         nDI = 0;
#100     nDI = 1;
#10000
         qbus_write(16'O177130, 16'H0300);
         qbus_write(16'O177132, 16'H0000);
         qbus_waitr();
         qbus_write(16'O177132, 16'H0000);
         qbus_waitr();
         qbus_write(16'O177132, 16'HA1A1);
         qbus_waitr();
         qbus_write(16'O177132, 16'HFEA1);
         qbus_waitr();
         qbus_write(16'O177132, 16'H3130);
         qbus_waitr();
         qbus_write(16'O177132, 16'H3332);
         qbus_waitr();
//
//#20000
//       qbus_read(16'O177132); //##
//       qbus_waitr();
//       qbus_write(16'O177132, 16'H0000);
//       qbus_waitr();
//       qbus_write(16'O177132, 16'HA1A1);
//       qbus_waitr();
//       qbus_write(16'O177132, 16'HFEA1);
//       qbus_waitr();
//
#2000
         IND = 0;
#2000    IND = 1;
#2000
         qbus_read(16'O177132); //##
#12000
#(`SIM_CONFIG_CLOCK_HPERIOD*12);
         qbus_write(16'O177130, 16'O002000);
         qbus_read (16'O177130);
         qbus_write(16'O177130, 16'O000000);
         qbus_read (16'O177130);
//       repeat(10)
//       begin
//          qbus_waitr();
//          qbus_write(16'O177132, 16'h55CC);
//       end
         repeat(10)
         begin
            qbus_waitr();
            qbus_read(16'O177132);
         end
//
//
// *** Write data model end ***
//______________________________________________________________________________
//

//______________________________________________________________________________
//
// *** Read data model start ***
//
//       qbus_write(16'O177130, 16'O002000);
//       qbus_read (16'O177130);
//       qbus_write(16'O177130, 16'O000000);
//       qbus_read (16'O177130);
//
//       repeat(3)
//       begin
//          qbus_waitr();
//          qbus_read(16'O177132);
//       end
//
// *** Read data model end ***
//______________________________________________________________________________
//

//       qbus_write(16'O177130, 16'O002000);
//       qbus_read (16'O177130);
//       qbus_write(16'O177130, 16'O000000);
//       qbus_read (16'O177130);


//       while(1)
//       begin
//          qbus_waitr();
//          qbus_read (16'O177132);
//       end
//       repeat(10)
//       begin
//          qbus_waitr();
//          qbus_write(16'O177132, 16'h55CC);
//       end
end

//initial
//begin
//IND = 1;
//#100000 IND = 0;
//#2000   IND = 1;
//end


initial
begin
   @ (negedge nREZ);

#(`SIM_CONFIG_CLOCK_HPERIOD*16);

   fdin_data(8'h00);
   fdin_data(8'h00);
   fdin_data(8'h00);
   fdin_mark(8'hA1);
   fdin_mark(8'hA1);
   fdin_data(8'h30);
   fdin_data(8'h31);
   fdin_data(8'h32);
   fdin_data(8'h33);
   fdin_data(8'h91);
   fdin_data(8'h16);

   fdin_data(8'h00);
   fdin_data(8'h55);
   fdin_data(8'h00);
   fdin_data(8'h00);

end

reg fdin_prev = 0;
task fdin_data
(
   input [7:0]  data
);
reg dbit;
integer i;
begin
   for(i=0; i<8; i=i+1)
   begin
      dbit = data[7-i];
      if (dbit)
         begin
            fdin_prev = 1;
            #2000 nDI = 0;
            #100  nDI = 1;
            #1900;
         end
      else
         begin
            if (fdin_prev)
               begin
                  fdin_prev = 0;
                  #4000;
               end
            else
               begin
                  fdin_prev = 0;
                  nDI = 0;
                  #100 nDI = 1;
                  #3900;
               end
         end
   end
end
endtask

task fdin_mark
(
   input [7:0]  data
);
reg dbit;
integer i;
begin
   for(i=0; i<8; i=i+1)
   begin
      dbit = data[7-i];
      if (dbit)
         begin
            fdin_prev = 1;
            #2000 nDI = 0;
            #100  nDI = 1;
            #1900;
         end
      else
         begin
            if (fdin_prev)
               begin
                  fdin_prev = 0;
                  #4000;
               end
            else
               begin
                  fdin_prev = 0;
                  nDI = (i != 5) ? 0 : 1;
                  #100 nDI = 1;
                  #3900;
               end
         end
   end
end
endtask


task qbus_waitr();
begin
   AD_out[7] = 0;
   while(AD_out[7] == 0)
      qbus_read (16'O177130);

#(`SIM_CONFIG_CLOCK_HPERIOD);
#(`SIM_CONFIG_CLOCK_HPERIOD);
#(`SIM_CONFIG_CLOCK_HPERIOD);
#(`SIM_CONFIG_CLOCK_HPERIOD);
#(`SIM_CONFIG_CLOCK_HPERIOD);
#(`SIM_CONFIG_CLOCK_HPERIOD);

end
endtask

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

/*
task qbus_read
(
   input [15:0]  addr,
   output reg [15:0]  data
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
#(`SIM_CONFIG_CLOCK_HPERIOD);

@ (negedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
   data  = ~nAD;
   nSYNC = 1;
   nDIN  = 1;
@ (posedge nRPLY);
#(`SIM_CONFIG_CLOCK_HPERIOD);
end
endtask
*/

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
#(`SIM_CONFIG_CLOCK_HPERIOD);

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
vp_128 vp_128
(
   .PIN_nAD(nAD),
   .PIN_nSYNC(nSYNC),
   .PIN_nDIN(nDIN),
   .PIN_nDOUT(nDOUT),
   .PIN_nINIT(nINIT),
   .PIN_CLK(CLK),
   .PIN_nRPLY(nRPLY),
   .PIN_nDS(nDS),
   .PIN_nMSW(nMSW),
   .PIN_nST(nST),
   .PIN_DIR(DIR),
   .PIN_HS(HS),
   .PIN_nWRE(nWRE),
   .PIN_nDO(nDO),
   .PIN_nREZ(nREZ),
   .PIN_nDI(nDI),
   .PIN_IND(IND),
   .PIN_TR0(TR0),
   .PIN_RDY(RDY),
   .PIN_WRP(WRP)
);
endmodule

