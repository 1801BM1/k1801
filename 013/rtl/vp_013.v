//
// Copyright (c) 2013 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 100ps

module vp_013
(
   input[15:0] PIN_nAD,       // Address/Data inverted bus
                              //
   input       PIN_nSYNC,     //
   input       PIN_nDIN,      //
   input       PIN_nDOUT,     //
   input       PIN_nWTBT,     //
   input       PIN_MSEL,      //
   input       PIN_nSEL,      //
   input       PIN_CLK,       //
   input       PIN_RC,        //
   output      PIN_nRPLY,     //
                              //
   output[6:0] PIN_A,         //
   output[1:0] PIN_nRAS,      //
   output[1:0] PIN_nCAS,      //
   output      PIN_nWE,       //
   output      PIN_nDME,      //
   output      PIN_RSTB,      //
   output      PIN_LOCK       //
);

//______________________________________________________________________________
//
// Autogenerated netlist
//
wire PH4;
wire nPH4;
wire MH0;
wire nRESET;
wire TEST;
wire nDIN;
wire RA0;
wire nRAS;
wire WFLG;
wire nWFLG;
wire DOUT;
wire nDOUT;
wire DONE;
wire nREF_REQ;
wire nRACLK;
wire nRC4;
wire REF_GNT;
wire nRC3;
wire CLK;
wire PH6;
wire RC1;
wire RC2;
wire ACTIVE;
wire ACC_DONE;
wire ACC_REQ;
wire nRC1;
wire nSYNC1;
wire A5;
wire nRC2;
wire SYNC;
wire A9;
wire nRA5;
wire RA6;
wire A2;
wire nRA3;
wire nRFSH;
wire MODE;
wire nWE;
wire nRA1;
wire nRA0;
wire DIN;
wire A10;
wire A3;
wire A11;
wire A4;
wire nRA2;
wire A12;
wire RAMSEL;
wire RPLY;
wire nTEST;
wire nXSEL;
wire nACC_REQ;
wire nPH0;
wire PH1;
wire nPH2;
wire nPH3;
wire RC0;
wire RACLK;
wire PH2;
wire PH0;
wire nMODE;
wire WTBT;
wire AMUX;
wire nSYWTBT;
wire PH3;
wire nACCS;
wire nRC0;
wire nREF_DONE;
wire nPH6;
wire nMH1;
wire nRA7;
wire nCLK;
wire RA3;
wire nRA4;
wire RA5;
wire nA13;
wire A7;
wire A0;
wire nA0;
wire nMH2;
wire RESET;
wire A14;
wire ACS_DONE;
wire RC3;
wire nMH0;
wire MH1;
wire nSTART;
wire A1;
wire A6;
wire A13;
wire MSEL;
wire nCAS;
wire nSYNC0;
wire MH2;
wire A8;
wire nA14;
wire A15;
wire nA15;
wire RA7;
wire nRA6;
wire RA1;
wire RA2;
wire RA4;
wire nMSEL;
wire RC4;
wire nROMSEL;
wire nSEL;
wire RFSH;
wire nWTBT;
wire ACCS;
wire DINOUT;

wire NET00097;
wire NETA0097;
wire NETB0097;
wire NET00099;
wire NETA0099;
wire NETB0099;
wire NET00112;
wire NETA0112;
wire NETB0112;
wire NET00113;
wire NETA0113;
wire NETB0113;
wire NET00060;
wire NETA0060;
wire NETB0060;
wire NET00205;
wire NETA0205;
wire NETB0205;
wire NET00287;
wire NETA0287;
wire NETB0287;

wire NET00002;
wire NET00009;
wire NET00010;
wire NET00013;
wire NET00015;
wire NET00016;
wire NET00017;
wire NET00020;
wire NET00022;
wire NET00023;
wire NET00024;
wire NET00025;
wire NET00030;
wire NET00031;
wire NET00034;
wire NET00036;
wire NET00037;
wire NET00039;
wire NET00040;
wire NET00041;
wire NET00042;
wire NET00043;
wire NET00046;
wire NET00048;
wire NET00049;
wire NET00050;
wire NET00051;
wire NET00052;
wire NET00054;
wire NET00055;
wire NET00056;
wire NET00057;
wire NET00058;
wire NET00063;
wire NET00065;
wire NET00069;
wire NET00070;
wire NET00071;
wire NET00073;
wire NET00074;
wire NET00077;
wire NET00078;
wire NET00079;
wire NET00080;
wire NET00082;
wire NET00083;
wire NET00084;
wire NET00085;
wire NET00086;
wire NET00087;
wire NET00090;
wire NET00091;
wire NET00092;
wire NET00094;
wire NET00095;
wire NET00096;
wire NET00101;
wire NET00102;
wire NET00104;
wire NET00105;
wire NET00106;
wire NET00109;
wire NET00117;
wire NET00118;
wire NET00252;
wire NET00120;
wire NET00121;
wire NET00125;
wire NET00126;
wire NET00258;
wire NET00129;
wire NET00130;
wire NET00174;
wire NET00134;
wire NET00136;
wire NET00137;
wire NET00138;
wire NET00139;
wire NET00141;
wire NET00144;
wire NET00145;
wire NET00146;
wire NET00147;
wire NET00242;
wire NET00151;
wire NET00152;
wire NET00158;
wire NET00161;
wire NET00162;
wire NET00163;
wire NET00245;
wire NET00167;
wire NET00168;
wire NET00237;
wire NET00170;
wire NET00171;
wire NET00172;
wire NET00249;
wire NET00202;
wire NET00177;
wire NET00178;
wire NET00180;
wire NET00181;
wire NET00182;
wire NET00183;
wire NET00184;
wire NET00185;
wire NET00187;
wire NET00189;
wire NET00191;
wire NET00192;
wire NET00193;
wire NET00194;
wire NET00195;
wire NET00196;
wire NET00197;
wire NET00198;
wire NET00199;
wire NET00200;
wire NET00201;
wire NET00207;
wire NET00206;
wire NET00208;
wire NET00209;
wire NET00211;
wire NET00213;
wire NET00214;
wire NET00215;
wire NET00217;
wire NET00218;
wire NET00221;
wire NET00222;
wire NET00224;
wire NET00225;
wire NET00226;
wire NET00230;
wire NET00234;
wire NET00236;
wire NET00239;
wire NET00274;
wire NET00265;
wire NET00247;
wire NET00276;
wire NET00275;
wire NET00262;
wire NET00251;
wire NET00261;
wire NET00257;
wire NET00255;
wire NET00259;
wire NET00291;
wire NET00284;
wire NET00283;
wire NET00290;
wire NET00266;
wire NET00268;
wire NET00278;
wire NET00270;
wire NET00271;
wire NET00288;
wire NET00298;
wire NET00297;
wire NET00305;
wire NET00306;
wire NET00304;
wire NET00303;
wire NET00296;
wire NET00295;
wire NET00285;
wire NET00301;
wire NET00302;

//______________________________________________________________________________
//
tOUTPUT     PIN2( .x1(NET00097), .y1(PIN_A[0]));
tOUTPUT     PIN3( .x1(NET00099), .y1(PIN_A[1]));
tOUTPUT     PIN4( .x1(NET00112), .y1(PIN_A[2]));
tOUTPUT     PIN5( .x1(NET00113), .y1(PIN_A[3]));
tOUTPUT     PIN6( .x1(NET00060), .y1(PIN_A[4]));
tOUTPUT     PIN7( .x1(NET00205), .y1(PIN_A[5]));
tOUTPUT     PIN8( .x1(NET00287), .y1(PIN_A[6]));
tOUTPUT     PIN29(.x1(NET00208), .y1(PIN_nWE));
tOUTPUT     PIN33(.x1(NET00087), .y1(PIN_nCAS[0]));
tOUTPUT     PIN34(.x1(NET00079), .y1(PIN_nCAS[1]));
tOUTPUT     PIN30(.x1(NET00084), .y1(PIN_nRAS[0]));
tOUTPUT     PIN31(.x1(NET00085), .y1(PIN_nRAS[1]));
tOUTPUT     PIN28(.x1(NET00209), .y1(PIN_LOCK));
tOUTPUT     PIN35(.x1(NET00082), .y1(PIN_nDME));
tOUTPUT     PIN36(.x1(NET00083), .y1(PIN_RSTB));
tOUTPUT_OC  PIN39(.x1(NET00094), .y1(PIN_nRPLY));

tINPUT      PIN1( .y2(NET00290), .x1(PIN_CLK));
tINPUT      PIN32(.y2(NET00086), .x1(PIN_RC));
tINPUT      PIN37(.y2(NET00051), .x1(PIN_nDOUT));
tINPUT      PIN38(.y2(NET00056), .x1(PIN_nDIN));
tINPUT      PIN41(.y2(NET00063), .x1(PIN_nSYNC));
tINPUT      PIN40(.y2(WTBT),     .x1(PIN_nWTBT));
tINPUT      PIN27(.y2(NET00198), .x1(PIN_MSEL));
tINPUT      PIN26(.y2(NET00199), .x1(PIN_nSEL));

tINPUT      PIN9( .y2(NET00252), .x1(PIN_nAD[0]));
tINPUT      PIN10(.y2(NET00074), .x1(PIN_nAD[1]));
tINPUT      PIN11(.y2(NET00258), .x1(PIN_nAD[2]));
tINPUT      PIN12(.y2(NET00174), .x1(PIN_nAD[3]));
tINPUT      PIN13(.y2(NET00058), .x1(PIN_nAD[4]));
tINPUT      PIN14(.y2(NET00242), .x1(PIN_nAD[5]));
tINPUT      PIN15(.y2(NET00245), .x1(PIN_nAD[6]));
tINPUT      PIN16(.y2(NET00249), .x1(PIN_nAD[7]));
tINPUT      PIN17(.y2(NET00065), .x1(PIN_nAD[8]));
tINPUT      PIN18(.y2(NET00130), .x1(PIN_nAD[9]));
tINPUT      PIN19(.y2(NET00147), .x1(PIN_nAD[10]));
tINPUT      PIN20(.y2(NET00202), .x1(PIN_nAD[11]));
tINPUT      PIN22(.y2(NET00207), .x1(PIN_nAD[12]));
tINPUT      PIN23(.y2(NET00206), .x1(PIN_nAD[13]));
tINPUT      PIN24(.y2(NET00194), .x1(PIN_nAD[14]));
tINPUT      PIN25(.y2(NET00193), .x1(PIN_nAD[15]));

//______________________________________________________________________________
//
t429 cell_K8(.y3(NET00077), .x5(NET00078));
t370 cell_J8(.y2(NET00078), .x5(nRA3));
t370 cell_J37(.y2(NET00087), .x5(NET00217));
t428 cell_K11(.x2(NET00284), .y3(CLK));
t370 cell_G37(.y2(NET00085), .x5(NET00239));
t370 cell_L34(.y2(nDIN), .x5(DIN));
t428 cell_K14(.x2(RESET), .y3(NET00071));
t370 cell_L37(.y2(NET00079), .x5(NET00167));
t370 cell_J16(.y2(NET00285), .x5(NET00105));
t370 cell_M28(.y2(NET00009), .x5(RAMSEL));
t429 cell_K16(.y3(NET00134), .x5(NET00285));
t416 cell_A2(.c1(nSYNC0), .q4(A6), .d5(NET00245));
t379 cell_J4(.x1(NET00080), .y2(NET00288), .x3(nRA5), .y4(NET00069), .x5(nRA4), .x6(NET00080), .x8(nRA4));
t406 cell_L4(.c1(NET00189), .r2(NET00071), .q3(NET00050), .q4(NET00191), .r5(RA4), .s10(nRA4));
t416 cell_A20(.c1(nSYNC0), .q4(A11), .d5(NET00202));
t370 cell_B20(.y2(NET00201), .x5(nRC2));
t429 cell_K20(.y3(NET00025), .x5(RC2));
t416 cell_B24(.c1(nSYNC1), .q4(A12), .d5(NET00207));
t416 cell_B32(.c1(nSYNC1), .q3(nA14), .q4(A14), .d5(NET00194));
t429 cell_E36(.y3(MODE), .x5(NET00086));
t404 cell_G22(.c1(NET00017), .q4(nREF_REQ), .r5(NET00139), .s10(NET00137));
t404 cell_G28(.c1(CLK), .q3(NET00034), .q4(NET00031), .r5(nPH4), .s10(PH4));
t373 cell_I34(.x1(MH2), .x3(PH4), .y4(nCAS));
t429 cell_K22(.y3(nSYNC0), .x5(NET00063));
t418 cell_M22(.x1(ACS_DONE), .x2(NET00023), .y3(NET00022), .y4(NET00024), .x5(NET00020), .x6(NET00022), .x10(NET00020));
t384 cell_N22(.x1(RACLK), .y3(NET00023), .x5(RC4));
t373 cell_M31(.x1(nXSEL), .x3(NET00040), .y4(DONE));
t421 cell_N29(.x1(ACTIVE), .y2(NET00141), .x3(RPLY), .x4(ACC_REQ), .x5(RAMSEL), .x6(nSYWTBT), .x10(RAMSEL));
t416 cell_B2(.c1(nSYNC0), .q4(A7), .d5(NET00249));
t406 cell_J6(.c1(NET00288), .r2(NET00071), .q3(NET00257), .q4(NET00255), .r5(RA6), .s10(nRA6));
t406 cell_D20(.c1(NET00134), .r2(NET00170), .q3(RC2), .q4(nRC2), .r5(NET00221), .s10(NET00222));
t417 cell_B28(.x1(NET00234), .y4(NET00213), .x5(MODE), .x6(nMSEL), .x10(nMODE));
t384 cell_B30(.x1(ACCS), .y3(nXSEL), .x5(NET00213));
t404 cell_G29(.c1(nCLK), .q3(PH4), .q4(nPH4), .r5(nPH3), .s10(PH3));
t404 cell_G30(.c1(CLK), .q3(MH2), .q4(nMH2), .r5(nMH1), .s10(MH1));
t429 cell_K26(.y3(SYNC), .x5(nSYNC1));
t391 cell_M24(.x1(nRESET), .x2(NET00017), .y3(NET00016), .y4(nREF_DONE), .x5(NET00015), .x6(NET00016), .y9(NET00015), .x10(PH3));
t370 cell_O28(.y2(nWTBT), .x5(WTBT));
t416 cell_D4(.c1(nSYNC0), .q4(A3), .d5(NET00174));
t406 cell_M6(.c1(NET00259), .r2(NET00071), .q3(RA3), .q4(nRA3), .r5(NET00197), .s10(NET00196));
t406 cell_F18(.c1(NET00054), .r2(NET00170), .q3(NET00055), .q4(NET00057), .r5(RC1), .s10(nRC1));
t418 cell_C34(.x1(NET00270), .x2(NET00271), .y3(nROMSEL), .y4(NET00234), .x5(MSEL), .x6(MSEL), .x10(nSEL));
t404 cell_G31(.c1(nCLK), .q3(MH1), .q4(nMH1), .r5(nMH0), .s10(MH0));
t416 cell_J26(.c1(CLK), .q4(nSTART), .d5(NET00118));
t402 cell_N31(.r1(DONE), .q3(NET00129), .q4(NET00126), .s6(NET00121));
t416 cell_G2(.c1(nSYNC0), .q4(A1), .d5(NET00074));
t417 cell_O8(.x1(A8), .y4(NETA0097), .x5(NET00095), .x6(A1), .x10(NET00096));
t406 cell_F20(.c1(NET00134), .r2(NET00170), .q3(RC0), .q4(nRC0), .r5(NET00163), .s10(NET00162));
t370 cell_D35(.y2(NET00236), .x5(AMUX));
t392 cell_G36(.x1(nA15), .x3(nRAS), .y4(NET00239), .x5(NET00237));
t406 cell_L24(.c1(ACC_DONE), .r2(RESET), .q3(ACC_REQ), .q4(nACC_REQ), .r5(NET00043), .s10(NET00046));
t428 cell_K28(.x2(NET00052), .y3(RAMSEL));
t398 cell_M34(.x1(nWE), .y2(NET00083), .x4(nXSEL), .x5(nRAS), .x6(RPLY), .y9(NET00094), .x10(DINOUT));
t428 cell_K37(.x2(NET00056), .y3(DIN));
t390 cell_J3(.x6(RA6), .y9(NETB0287), .x10(NET00101));
t406 cell_M8(.c1(NET00259), .r2(NET00071), .q3(RA2), .q4(nRA2), .r5(NET00187), .s10(NET00185));
t428 cell_E22(.x2(RESET), .y3(NET00170));
t404 cell_H29(.c1(nCLK), .q3(PH2), .q4(nPH2), .r5(NET00136), .s10(PH1));
t373 cell_I26(.x1(PH0), .x3(nPH2), .y4(NET00041));
t428 cell_K31(.x2(NET00144), .y3(NET00181));
t404 cell_O26(.c1(DOUT), .q4(NET00145), .r5(NET00298), .s10(NET00297));
t390 cell_O34(.x1(RAMSEL), .y4(NET00120), .x5(DINOUT), .x6(RAMSEL), .y9(NET00121), .x10(NET00120));
t384 cell_O35(.x1(nDIN), .y3(DINOUT), .x5(nDOUT));
t429 cell_K2(.y3(NET00080), .x5(RA3));
t417 cell_J2(.x1(A14), .y4(NETA0287), .x5(NET00095), .x6(A7), .x10(NET00096));
t406 cell_L8(.c1(NET00184), .r2(NET00071), .q3(NET00185), .q4(NET00187), .r5(RA2), .s10(nRA2));
t370 cell_J18(.y2(NET00161), .x5(NET00036));
t373 cell_I18(.x1(NET00036), .x3(nRC0), .y4(NET00054));
t428 cell_E26(.x2(NET00172), .y3(ACCS));
t374 cell_H36(.x1(NET00230), .x2(RFSH), .x3(nXSEL), .y4(NET00125), .y8(nRFSH));
t406 cell_I29(.c1(nCLK), .r2(NET00090), .q3(nPH0), .q4(PH0), .r5(NET00091), .s10(NET00092));
t428 cell_K34(.x2(NET00183), .y3(NET00095));
t418 cell_M37(.x1(TEST), .x2(NET00152), .y3(NET00151), .y4(NET00152), .x5(nCLK), .x6(nTEST), .x10(nRACLK));
t417 cell_N37(.x1(TEST), .y4(NET00144), .x5(CLK), .x6(nTEST), .x10(RACLK));
t390 cell_M2(.x1(RA5), .y4(NETB0205), .x5(NET00101), .x6(RA4), .y9(NETB0060), .x10(NET00101));
t417 cell_L2(.x1(A13), .y4(NETA0205), .x5(NET00095), .x6(A6), .x10(NET00096));
t406 cell_N10(.c1(NET00268), .r2(NET00071), .q3(NET00262), .q4(NET00261), .r5(RA1), .s10(nRA1));
t429 cell_K18(.y3(NET00036), .x5(NET00102));
t428 cell_E34(.x2(NET00086), .y3(nMODE));
t373 cell_I37(.x1(nACCS), .x3(nCAS), .y4(ACS_DONE));
t381 cell_J29(.x1(PH6), .y2(NET00091), .x3(nSTART), .x4(nMODE), .x6(RESET));
t417 cell_O37(.x1(RPLY), .y4(NET00082), .x5(DIN), .x6(NET00125), .x10(DIN));
t417 cell_N2(.x1(A12), .y4(NETA0060), .x5(NET00095), .x6(A5), .x10(NET00096));
t390 cell_O3(.x1(RA3), .y4(NETB0113), .x5(NET00101), .x6(RA2), .y9(NETB0112), .x10(NET00101));
t406 cell_O10(.c1(NET00259), .r2(NET00071), .q3(RA1), .q4(nRA1), .r5(NET00261), .s10(NET00262));
t406 cell_N18(.c1(NET00200), .r2(NET00170), .q3(RC3), .q4(nRC3), .r5(NET00266), .s10(NET00306));
t392 cell_D24(.x1(AMUX), .x3(RFSH), .y4(NET00192), .x5(ACCS));
t381 cell_J31(.x1(MH2), .y2(NET00211), .x3(nSTART), .x4(MODE), .x6(RESET));
t377 cell_J34(.x1(NET00214), .y2(NET00215), .x3(NET00215), .y4(ACTIVE), .x5(NET00213), .x6(DIN), .x8(DOUT), .y9(NET00214));
t406 cell_F4(.c1(NET00077), .r2(NET00071), .q3(RA5), .q4(nRA5), .r5(NET00073), .s10(NET00070));
t377 cell_J10(.x1(NET00283), .y2(NET00291), .x3(NET00291), .y4(NET00284), .x5(NET00290), .x6(NET00290), .x8(NET00284), .y9(NET00283));
t406 cell_I20(.c1(nCLK), .r2(NET00170), .q3(NET00102), .q4(NET00105), .r5(NET00106), .s10(NET00104));
t406 cell_J20(.c1(CLK), .r2(NET00170), .q3(NET00104), .q4(NET00106), .r5(NET00102), .s10(NET00105));
t416 cell_D26(.c1(nSYNC1), .q3(nA13), .q4(A13), .d5(NET00206));
t376 cell_F22(.x1(nACC_REQ), .x3(NET00171), .y4(NET00172), .x6(NET00172), .x8(nREF_REQ), .y9(NET00171));
t406 cell_N20(.c1(NET00030), .r2(NET00170), .q3(NET00306), .q4(NET00266), .r5(RC3), .s10(nRC3));
t406 cell_O20(.c1(NET00302), .r2(NET00170), .q3(NET00303), .q4(NET00304), .r5(RC4), .s10(nRC4));
t373 cell_F26(.x1(nPH4), .x3(nPH0), .y4(NET00039));
t399 cell_J22(.r1(nREF_DONE), .x2(REF_GNT), .q3(NET00049), .q4(NET00048), .s6(NET00109), .y7(NET00109));
t382 cell_I4(.x1(nRA6), .y2(NET00177), .x3(nRA5), .x4(NET00080), .x5(NET00080), .x6(nRA4), .y8(NET00189));
t382 cell_M20(.x1(RACLK), .y2(REF_GNT), .x3(RC4), .x4(NET00025), .x5(NET00025), .x6(RC3), .y8(NET00030));
t379 cell_O21(.x1(nRC3), .y2(NET00301), .x3(nRC4), .y4(NET00302), .x5(NET00025), .x6(nRC3), .x8(NET00025));
t373 cell_G26(.x1(RFSH), .x3(ACCS), .y4(NET00118));
t373 cell_F30(.x1(nMH2), .x3(nMH0), .y4(NET00042));
t406 cell_M26(.c1(RAMSEL), .r2(DOUT), .q3(nWFLG), .q4(WFLG), .r5(NET00010), .s10(NET00013));
t416 cell_C8(.c1(nSYNC0), .q4(A8), .d5(NET00065));
t382 cell_M12(.x1(nRA2), .y2(NET00195), .x3(nRA1), .x4(NET00181), .x5(NET00181), .x6(nRA0), .y8(NET00278));
t406 cell_O24(.c1(NET00200), .r2(NET00170), .q3(RACLK), .q4(nRACLK), .r5(NET00295), .s10(NET00296));
t373 cell_F31(.x1(NET00234), .x3(nSYNC1), .y4(NET00052));
t373 cell_F32(.x1(MH0), .x3(PH1), .y4(nRAS));
t399 cell_N26(.r1(DOUT), .x2(RAMSEL), .q3(NET00013), .q4(NET00010), .s6(NET00305), .y7(NET00305));
t416 cell_D10(.c1(nSYNC0), .q4(A9), .d5(NET00130));
t384 cell_H16(.x1(nPH6), .y3(NET00002), .x5(nPH4));
t416 cell_A36(.c1(nSYNC1), .q3(nSEL), .d5(NET00199));
t392 cell_F36(.x1(A15), .x3(nRAS), .y4(NET00247), .x5(NET00237));
t405 cell_O27(.c1(nDOUT), .x2(DOUT), .q3(NET00297), .q4(NET00298), .r5(nWTBT), .y7(nDOUT), .s10(WTBT));
t406 cell_F6(.c1(NET00077), .r2(NET00071), .q3(RA7), .q4(nRA7), .r5(NET00180), .s10(NET00178));
t416 cell_B37(.c1(nSYNC1), .q3(nA15), .q4(A15), .d5(NET00193));
t384 cell_G24(.x1(nPH4), .y3(NET00158), .x5(nMH2));
t380 cell_I31(.x1(nWFLG), .y2(NET00208), .y3(NET00226), .x4(nWE), .x5(NET00226), .x6(nXSEL));
t380 cell_M29(.x1(DIN), .y2(nRESET), .y3(RESET), .x4(SYNC), .x5(RESET), .x6(nDOUT));
t428 cell_K10(.x2(NET00283), .y3(nCLK));
t428 cell_K12(.x2(NET00151), .y3(NET00259));
t416 cell_A3(.c1(nSYNC0), .q4(A5), .d5(NET00242));
t416 cell_C2(.c1(nSYNC0), .q4(A4), .d5(NET00058));
t416 cell_F2(.c1(nSYNC0), .q4(A2), .d5(NET00258));
t416 cell_I2(.c1(nSYNC0), .q3(nA0), .q4(A0), .d5(NET00252));
t406 cell_M4(.c1(NET00077), .r2(NET00071), .q3(RA4), .q4(nRA4), .r5(NET00191), .s10(NET00050));
t406 cell_L6(.c1(NET00195), .r2(NET00071), .q3(NET00196), .q4(NET00197), .r5(RA3), .s10(nRA3));
t417 cell_O4(.x1(A10), .y4(NETA0112), .x5(NET00095), .x6(A3), .x10(NET00096));
t417 cell_O6(.x1(A9), .y4(NETA0099), .x5(NET00095), .x6(A2), .x10(NET00096));
t406 cell_C20(.c1(NET00037), .r2(NET00170), .q3(NET00222), .q4(NET00221), .r5(RC2), .s10(nRC2));
t406 cell_D18(.c1(NET00134), .r2(NET00170), .q3(RC1), .q4(nRC1), .r5(NET00057), .s10(NET00055));
t429 cell_E20(.y3(NET00200), .x5(NET00201));
t406 cell_G20(.c1(NET00161), .r2(NET00170), .q3(NET00162), .q4(NET00163), .r5(RC0), .s10(nRC0));
t379 cell_C32(.x1(nA15), .y2(NET00270), .x3(nA14), .y4(NET00271), .x5(nA13), .x6(nSEL), .x8(NET00270));
t418 cell_C37(.x1(NET00274), .x2(MODE), .y3(NET00274), .y4(NET00209), .x5(NET00265), .x6(MODE), .x10(nROMSEL));
t417 cell_D32(.x1(nSEL), .y4(NET00265), .x5(NET00095), .x6(nA15), .x10(NET00096));
t379 cell_G34(.x1(NET00236), .y2(NET00183), .x3(nACCS), .y4(NET00182), .x5(RFSH), .x6(TEST), .x8(RFSH));
t404 cell_H28(.c1(CLK), .q3(PH3), .q4(nPH3), .r5(nPH2), .s10(PH2));
t429 cell_K24(.y3(nSYNC1), .x5(NET00063));
t406 cell_L22(.c1(REF_GNT), .r2(nREF_DONE), .q3(NET00020), .r5(NET00048), .s10(NET00049));
t406 cell_N24(.c1(NET00301), .r2(NET00170), .q3(NET00296), .q4(NET00295), .r5(RACLK), .s10(nRACLK));
t405 cell_J24(.c1(NET00117), .x2(ACC_DONE), .q3(NET00046), .q4(NET00043), .r5(ACCS), .y7(NET00117), .s10(nACCS));
t379 cell_J28(.x1(nACCS), .y2(NET00090), .x3(nMODE), .y4(NET00092), .x5(NET00002), .x6(NET00091), .x8(NET00090));
t428 cell_K29(.x2(NET00051), .y3(DOUT));
t406 cell_O29(.c1(NET00009), .r2(DONE), .q3(nSYWTBT), .r5(WTBT), .s10(nWTBT));
t406 cell_O31(.c1(NET00120), .r2(DONE), .q4(RPLY), .r5(NET00126), .s10(NET00129));
t373 cell_N32(.x1(NET00145), .x3(nWFLG), .y4(NET00146));
t380 cell_N34(.x1(nDIN), .y2(nTEST), .y3(TEST), .x4(nDOUT), .x5(TEST), .x6(SYNC));
t406 cell_M10(.c1(NET00259), .r2(NET00071), .q3(RA0), .q4(nRA0), .r5(NET00275), .s10(NET00276));
t406 cell_L10(.c1(NET00278), .r2(NET00071), .q3(NET00276), .q4(NET00275), .r5(RA0), .s10(nRA0));
t378 cell_G18(.x1(NET00036), .y2(NET00037), .x3(nRC1), .x5(nRC0));
t428 cell_E24(.x2(NET00192), .y3(NET00096));
t428 cell_E28(.x2(NET00171), .y3(RFSH));
t370 cell_F37(.y2(NET00084), .x5(NET00247));
t404 cell_H30(.c1(CLK), .q3(MH0), .q4(nMH0), .r5(NET00224), .s10(NET00225));
t406 cell_H37(.c1(nSYNC1), .r2(ACS_DONE), .q3(NET00230), .r5(nRFSH), .s10(RFSH));
t404 cell_I28(.c1(CLK), .q3(PH1), .q4(NET00136), .r5(nPH0), .s10(PH0));
t416 cell_I30(.c1(nCLK), .q3(NET00224), .q4(NET00225), .d5(NET00211));
t429 cell_K33(.y3(NET00101), .x5(NET00182));
t417 cell_O2(.x1(A11), .y4(NETA0113), .x5(NET00095), .x6(A4), .x10(NET00096));
t406 cell_G4(.c1(NET00069), .r2(NET00071), .q3(NET00070), .q4(NET00073), .r5(RA5), .s10(nRA5));
t405 cell_I3(.c1(NET00251), .x2(nSYNC0), .q3(NET00218), .q4(NET00168), .r5(nA0), .y7(NET00251), .s10(A0));
t406 cell_I6(.c1(NET00077), .r2(NET00071), .q3(RA6), .q4(nRA6), .r5(NET00255), .s10(NET00257));
t379 cell_L12(.x1(NET00181), .y2(NET00184), .x3(nRA1), .y4(NET00268), .x5(nRA0), .x6(NET00181), .x8(nRA0));
t406 cell_O22(.c1(NET00200), .r2(NET00170), .q3(RC4), .q4(nRC4), .r5(NET00304), .s10(NET00303));
t384 cell_F24(.x1(RFSH), .y3(NET00017), .x5(NET00158));
t373 cell_F28(.x1(MH1), .x3(PH2), .y4(nWE));
t399 cell_I22(.r1(nREF_DONE), .x2(NET00024), .q3(NET00137), .q4(NET00139), .s6(NET00138), .y7(NET00138));
t393 cell_I24(.x1(ACCS), .x3(NET00141), .y4(ACC_DONE), .x5(PH3), .x6(ACCS), .y9(nACCS));
t423 cell_J36(.x1(NET00218), .y2(NET00217), .x4(nCAS), .x5(NET00146), .x6(nXSEL));
t419 cell_L26(.x1(WFLG), .y2(NET00040), .x4(NET00042), .x5(NET00039), .x6(nWFLG), .x10(NET00041));
t423 cell_L36(.x1(NET00168), .y2(NET00167), .x4(nCAS), .x5(NET00146), .x6(nXSEL));
t406 cell_D6(.c1(NET00177), .r2(NET00071), .q3(NET00178), .q4(NET00180), .r5(RA7), .s10(nRA7));
t416 cell_C14(.c1(nSYNC0), .q4(A10), .d5(NET00147));
t404 cell_G16(.c1(nCLK), .q3(PH6), .q4(nPH6), .r5(NET00031), .s10(NET00034));
t384 cell_A28(.x1(nPH3), .y3(AMUX), .x5(nMH1));
t416 cell_A37(.c1(nSYNC1), .q3(MSEL), .q4(nMSEL), .d5(NET00198));
t373 cell_F34(.x1(nMODE), .x3(RFSH), .y4(NET00237));
t390 cell_O7(.x1(RA1), .y4(NETB0099), .x5(NET00101), .x6(RA0), .y9(NETB0097), .x10(NET00101));

//______________________________________________________________________________
//
// Manual corrections - wired-AND implementations
//
assign   NET00097 = NETA0097 & NETB0097;
assign   NET00099 = NETA0099 & NETB0099;
assign   NET00112 = NETA0112 & NETB0112;
assign   NET00113 = NETA0113 & NETB0113;
assign   NET00060 = NETA0060 & NETB0060;
assign   NET00205 = NETA0205 & NETB0205;
assign   NET00287 = NETA0287 & NETB0287;
endmodule
//______________________________________________________________________________
//