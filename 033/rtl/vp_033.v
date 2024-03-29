//
// Copyright (c) 2021 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 100ps

module vp_033
(
   input[5:0]  PIN_RC,        // configuration select
   output      PIN_RDO,       // reply delay output
   inout       PIN_nSHIFT,    // serial data clock
   inout       PIN_nOUT,      // data output direction
   inout[15:0] PIN_nAD,       // Address/Data inverted bus, no nAD13
   input       PIN_nBS,       // device select, dedicated input
                              //
   inout       PIN_nDI,       // input data
   output      PIN_nDO,       // output data
   output      PIN_nRUN,      //
   output      PIN_nSET,      //
   input       PIN_nERR,      // REQB
   inout       PIN_nDONE,     // ORR
   input       PIN_nTR,       // REQA
                              //
   input       PIN_nIAKI,     //
   input       PIN_nINIT,     //
   output      PIN_nVIRQ,     //
   output      PIN_nIAKO,     //
   input       PIN_nDOUT,     //
   input       PIN_nDIN,      //
   output      PIN_nRPLY,     //
   input       PIN_nWTBT,     //
   input       PIN_nSYNC      //
);

//______________________________________________________________________________
//
// Pin sharing table
//
//    Mode  FDC      PIO      BPIC
//
//    5     RC4      RDO      ~AO-A    - RDO dedicated output
//    6     RC5      RDI      ~AC-A
//    7     ~SHFT    CSR0     ~AC-S
//    8     ~OUT     CSR1     ~SC-A
//    26    ~DI     ~B1R      ~SC-S
//    27    ~DO     ~DTR      ~IN
//    28    ~RUN    ~NDR      ~OUT
//    29    ~SET    ~B0R      ~SET
//    30    ~ERR     REQB      ERR     - input only
//    31    ~DONE   ~ORR       DONE
//    32    ~TR      REQA      TR      - input only
//    40    ~WTBT   ~WTBT     ~SO-S
//______________________________________________________________________________
//
// Autogenerated netlist
//
wire AD0;
wire AD1;
wire AD2;
wire AD3;
wire AD4;
wire AD5;
wire AD6;

wire nSHR3;
wire nSHR4;
wire nSHR6;
wire nSHR7;
wire SHR7;

wire RC1;
wire RC2;
wire RC4;
wire RC5;

wire nRC0;
wire nRC1;
wire nRC2;
wire nRC3;

wire nREQ;
wire nSHIFT;
wire F170;
wire FVEN0;
wire CSR0;
wire nSEL;
wire M3;
wire F174;
wire M1;
wire M14;
wire FDC0;
wire M4;
wire A1;
wire nA0;
wire nSDIN0;
wire EN15;
wire A02;
wire A04;
wire A06;
wire AP0;
wire SELX;
wire VEC6;
wire M7;
wire nREQB;
wire M2;
wire A2;
wire nAP0;
wire nWREIB;
wire RC3;
wire F200;
wire nFVEC;
wire nSRUN2;
wire nDIN;
wire RDB4;
wire nSDOUT;
wire nWREIA;
wire nVEN;
wire WRB4;
wire RDP0_B4;
wire RC0;
wire CSR1;
wire IEB;
wire AD7;
wire M5;
wire nSHR1;
wire nAD0;
wire nA2;
wire M6;
wire nA1;
wire A00;
wire nSHR2;
wire nSHR0;
wire nFDC;
wire nSC_S;
wire M13;
wire M0;
wire RCNT;
wire nPINIT;
wire AB0;
wire nBPIC;
wire nSELA;
wire AB4;
wire SC_A;
wire BPIC0;
wire nRC4;
wire IRQA;
wire PIO;
wire IEA;
wire nIEB;
wire nIEA;
wire nSDIN;
wire FSEL2;
wire nFTR;
wire nSYNC;
wire REQB;
wire VEC5;
wire IRQB;
wire PINIT;
wire A0;
wire VEC4;
wire RDP4;
wire FINIT;
wire nFIRQ;
wire nFERR;
wire nREQA;
wire nSIRQ;
wire SH_nLD;
wire VEC2;
wire RDP2;
wire WRP2H;
wire AC_S;
wire FXX0;
wire FDC;
wire WRB6;
wire FVEN;
wire VEC3;
wire VEC7;
wire nSHR5;
wire nRC5;
wire SHIFT;
wire CNT8;
wire nPIO;
wire PIOB;
wire RDB0;
wire nOUT;
wire nSCLK;
wire nSELX;
wire RDB2;
wire nSDOUT0;
wire FVEC;
wire nWTBTS;
wire nWTBT;
wire FRUN;
wire nM15;
wire nINIT;
wire INIT;
wire BPIC;
wire nIRQ;
wire nFSYNC;
wire nDONE;
wire WRP2L;
wire WRF0;
wire FRW;
wire RDP0;
wire FSEL0;
wire nFSEL0;
wire nSRUN0;
wire FSTR;
wire NET00001;
wire NET00067;
wire NET00007;
wire NET00008;
wire NET00009;
wire NET00012;
wire NET00014;
wire NET00015;
wire NET00016;
wire NET00017;
wire NET00018;
wire NET00019;
wire NET00068;
wire NET00021;
wire NET00022;
wire NET00023;
wire NET00025;
wire NET00026;
wire NET00028;
wire NET00029;
wire NET00030;
wire NET00123;
wire NET00121;
wire NET00034;
wire NET00035;
wire NET00036;
wire NET00039;
wire NET00041;
wire NET00042;
wire NET00043;
wire NET00045;
wire NET00141;
wire NET00051;
wire NET00092;
wire NET00470;
wire NET00056;
wire NET00059;
wire NET00061;
wire NET00062;
wire NET00054;
wire NET00091;
wire NET00101;
wire NET00070;
wire NET00071;
wire NET00076;
wire NET00079;
wire NET00443;
wire NET00080;
wire NET00376;
wire NET00082;
wire NET00083;
wire NET00084;
wire NET00444;
wire NET00170;
wire NET00094;
wire NET00095;
wire NET00096;
wire NET00098;
wire NET00103;
wire NET00104;
wire NET00107;
wire NET00108;
wire NET00115;
wire NET00116;
wire NET00118;
wire NET00119;
wire NET00120;
wire NET00122;
wire NET00300;
wire NET00124;
wire NET00125;
wire NET00127;
wire NET00130;
wire NET00132;
wire NET00133;
wire NET00134;
wire NET00135;
wire NET00136;
wire NET00137;
wire NET00138;
wire NET00139;
wire NET00392;
wire NET00142;
wire NET00143;
wire NET00145;
wire NET00146;
wire NET00147;
wire NET00148;
wire NET00149;
wire NET00150;
wire NET00156;
wire NET00159;
wire NET00161;
wire NET00163;
wire NET00164;
wire NET00429;
wire NET00430;
wire NET00261;
wire NET00263;
wire NET00384;
wire NET00173;
wire NET00174;
wire NET00175;
wire NET00177;
wire NET00178;
wire NET00386;
wire NET00331;
wire NET00183;
wire NET00185;
wire NET00404;
wire NET00188;
wire NET00190;
wire NET00191;
wire NET00192;
wire NET00193;
wire NET00327;
wire NET00197;
wire NET00198;
wire NET00202;
wire NET00205;
wire NET00209;
wire NET00210;
wire NET00395;
wire NET00213;
wire NET00215;
wire NET00216;
wire NET00217;
wire NET00218;
wire NET00219;
wire NET00220;
wire NET00221;
wire NET00222;
wire NET00224;
wire NET00226;
wire NET00228;
wire NET00229;
wire NET00482;
wire NET00235;
wire NET00236;
wire NET00238;
wire NET00241;
wire NET00242;
wire NET00243;
wire NET00244;
wire NET00245;
wire NET00248;
wire NET00249;
wire NET00251;
wire NET00252;
wire NET00253;
wire NET00451;
wire NET00255;
wire NET00256;
wire NET00257;
wire NET00329;
wire NET00260;
wire NET00405;
wire NET00262;
wire NET00324;
wire NET00397;
wire NET00265;
wire NET00266;
wire NET00449;
wire NET00269;
wire NET00385;
wire NET00383;
wire NET00323;
wire NET00322;
wire NET00275;
wire NET00276;
wire NET00277;
wire NET00278;
wire NET00279;
wire NET00280;
wire NET00281;
wire NET00282;
wire NET00283;
wire NET00287;
wire NET00288;
wire NET00289;
wire NET00402;
wire NET00403;
wire NET00000;
wire NET00328;
wire NET00326;
wire NET00396;
wire NET00298;
wire NET00394;
wire NET00452;
wire NET00302;
wire NET00303;
wire NET00450;
wire NET00439;
wire NET00307;
wire NET00315;
wire NET00310;
wire NET00311;
wire NET00313;
wire NET00314;
wire NET00317;
wire NET00319;
wire NET00455;
wire NET00368;
wire NET00370;
wire NET00373;
wire NET00374;
wire NET00466;
wire NET00332;
wire NET00333;
wire NET00334;
wire NET00335;
wire NET00336;
wire NET00337;
wire NET00338;
wire NET00467;
wire NET00341;
wire NET00342;
wire NET00343;
wire NET00344;
wire NET00465;
wire NET00347;
wire NET00348;
wire NET00349;
wire NET00350;
wire NET00464;
wire NET00391;
wire NET00353;
wire NET00354;
wire NET00355;
wire NET00356;
wire NET00357;
wire NET00358;
wire NET00359;
wire NET00362;
wire NET00363;
wire NET00388;
wire NET00366;
wire NET00367;
wire NET00389;
wire NET00369;
wire NET00382;
wire NET00371;
wire NET00372;
wire NET00387;
wire NET00378;
wire NET00375;
wire NET00381;
wire NET00471;
wire NET00474;
wire NET00424;
wire NET00423;
wire NET00425;
wire NET00446;
wire NET00447;
wire NET00428;
wire NET00393;
wire NET00438;
wire NET00483;
wire NET00445;
wire NET00475;
wire NET00435;
wire NET00434;
wire NET00416;
wire NET00417;
wire NET00440;
wire NET00409;
wire NET00441;
wire NET00413;
wire NET00414;
wire NET00457;
wire NET00459;
wire NET00419;
wire NET00460;
wire NET00421;
wire NET00422;
wire NET00472;
wire NET00473;
wire NET00463;
wire NET00462;
wire NET00458;
wire NET00437;
wire NET00436;
wire NET00454;
wire NET00321;
wire NET00478;
wire NET00479;

wire NET00207;
wire NET00207A;
wire NET00207B;
wire NET00207C;

wire NET00272;
wire NET00272A;
wire NET00272B;

//______________________________________________________________________________
//
tOUTPUT_OE cell_PINOU9 (.x1(NET00141), .x2(NET00122), .y1(PIN_nAD[0]));
tOUTPUT_OE cell_PINOU10(.x1(NET00121), .x2(NET00122), .y1(PIN_nAD[1]));
tOUTPUT_OE cell_PINOU11(.x1(NET00123), .x2(NET00124), .y1(PIN_nAD[2]));
tOUTPUT_OE cell_PINOU12(.x1(NET00068), .x2(NET00122), .y1(PIN_nAD[3]));
tOUTPUT_OE cell_PINOU13(.x1(NET00067), .x2(NET00122), .y1(PIN_nAD[4]));
tOUTPUT_OE cell_PINOU14(.x1(NET00478), .x2(NET00116), .y1(PIN_nAD[5]));
tOUTPUT_OE cell_PINOU15(.x1(NET00479), .x2(NET00116), .y1(PIN_nAD[6]));
tOUTPUT_OE cell_PINOU16(.x1(NET00119), .x2(NET00116), .y1(PIN_nAD[7]));
tOUTPUT_OE cell_PINOU25(.x1(NET00221), .x2(NET00222), .y1(PIN_nAD[15]));

tINPUT cell_PIN9(.y2(AD0),  .x1(PIN_nAD[0]));
tINPUT cell_PIN10(.y2(AD1), .x1(PIN_nAD[1]));
tINPUT cell_PIN11(.y2(AD2), .x1(PIN_nAD[2]));
tINPUT cell_PIN12(.y2(AD3), .x1(PIN_nAD[3]));
tINPUT cell_PIN13(.y2(AD4), .x1(PIN_nAD[4]));
tINPUT cell_PIN14(.y2(AD5), .x1(PIN_nAD[5]));
tINPUT cell_PIN15(.y2(AD6), .x1(PIN_nAD[6]));
tINPUT cell_PIN16(.y2(AD7), .x1(PIN_nAD[7]));
tINPUT cell_PIN17(.y2(NET00034), .x1(PIN_nAD[8]));
tINPUT cell_PIN18(.y2(NET00092), .x1(PIN_nAD[9]));
tINPUT cell_PIN19(.y2(NET00091), .x1(PIN_nAD[10]));
tINPUT cell_PIN20(.y2(NET00101), .x1(PIN_nAD[11]));
tINPUT cell_PIN22(.y2(NET00041), .x1(PIN_nAD[12]));
tINPUT cell_PIN24(.y2(NET00428), .x1(PIN_nAD[14]));
tINPUT cell_PIN23(.y2(NET00025), .x1(PIN_nBS));

tINPUT cell_PIN2(.y2(nRC0),     .x1(PIN_RC[0]));
tINPUT cell_PIN3(.y2(nRC1),     .x1(PIN_RC[1]));
tINPUT cell_PIN4(.y2(nRC2),     .x1(PIN_RC[2]));
tINPUT cell_PIN1(.y2(nREQ),     .x1(PIN_RC[3]));
tINPUT cell_PIN5(.y2(NET00076), .x1(PIN_RC[4]));
tINPUT cell_PIN6(.y2(NET00079), .x1(PIN_RC[5]));

tOUTPUT_OC cell_PINOU39(.x1(NET00463), .y1(PIN_nRPLY));
tOUTPUT_OC cell_PINOU35(.x1(NET00276), .y1(PIN_nVIRQ));
tOUTPUT cell_PINOU36(.x1(NET00243), .y1(PIN_nIAKO));
tINPUT cell_PIN33(.y2(NET00083), .x1(PIN_nIAKI));
tINPUT cell_PIN41(.y2(NET00387), .x1(PIN_nSYNC));
tINPUT cell_PIN40(.y2(NET00470), .x1(PIN_nWTBT));
tINPUT cell_PIN34(.y2(NET00381), .x1(PIN_nINIT));
tINPUT cell_PIN37(.y2(NET00382), .x1(PIN_nDOUT));
tINPUT cell_PIN38(.y2(NET00084), .x1(PIN_nDIN));

tOUTPUT_OE cell_PINOU8(.x1(NET00161), .x2(FDC), .y1(PIN_nOUT));
tOUTPUT_OE cell_PINOU7(.x1(NET00164), .x2(FDC), .y1(PIN_nSHIFT));
tOUTPUT_OE cell_PINOU5(.x1(NET00438), .x2(nPIO), .y1(PIN_RDO));
tOUTPUT_OE cell_PINOU26(.x1(NET00219), .x2(NET00220), .y1(PIN_nDI));
tOUTPUT_OE cell_PINOU31(.x1(NET00213), .x2(NET00220), .y1(PIN_nDONE));

tOUTPUT cell_PINOU28(.x1(NET00217), .y1(PIN_nRUN));
tOUTPUT cell_PINOU29(.x1(NET00216), .y1(PIN_nSET));
tOUTPUT cell_PINOU27(.x1(NET00218), .y1(PIN_nDO));

tINPUT cell_PIN7(.y2(NET00471), .x1(PIN_nSHIFT));
tINPUT cell_PIN8(.y2(NET00474), .x1(PIN_nOUT));
tINPUT cell_PIN32(.y2(NET00082), .x1(PIN_nTR));
tINPUT cell_PIN31(.y2(NET00080), .x1(PIN_nDONE));
tINPUT cell_PIN26(.y2(NET00439), .x1(PIN_nDI));
tINPUT cell_PIN30(.y2(nREQB), .x1(PIN_nERR));

//______________________________________________________________________________
//
t370 cell_D14(.y2(NET00016), .x5(NET00091));
t370 cell_H9(.y2(NET00042), .x5(PIO));
t370 cell_F29(.y2(NET00150), .x5(AD7));
t428 cell_K9(.x2(NET00071), .y3(nPIO));
t370 cell_N20(.y2(NET00472), .x5(PIO));
t370 cell_G25(.y2(NET00132), .x5(AD5));
t370 cell_G32(.y2(FDC0), .x5(nFDC));
t370 cell_H36(.y2(nFERR), .x5(nREQB));
t370 cell_H38(.y2(nDIN), .x5(NET00084));
t428 cell_K16(.x2(NET00300), .y3(nFDC));
t376 cell_C1(.x1(nWTBT), .x3(nA0), .y4(NET00051), .x6(nWTBT), .x8(A0), .y9(NET00483));
t381 cell_B6(.x1(nSEL), .y2(WRP2L), .x3(nSDOUT0), .x4(NET00054), .x6(NET00051));
t416 cell_D5(.c1(nSYNC), .q3(nA2), .q4(A2), .d5(AD2));
t388 cell_C10(.x1(AP0), .y2(AB4), .x3(AB4), .y4(NET00098), .y5(NET00096), .x6(A04), .x7(NET00096), .x10(BPIC));
t385 cell_D9(.x1(A00), .x2(nAP0), .y3(nAP0), .x5(PIO), .y8(AP0));
t416 cell_D21(.c1(nSYNC), .q4(NET00185), .d5(NET00135));
t395 cell_F24(.x1(NET00142), .y2(NET00143), .x3(NET00143), .x4(AD6), .x5(AD6), .x6(NET00142), .y8(NET00139));
t376 cell_F23(.x1(F200), .x3(M0), .y4(NET00148), .x6(F200), .x8(M3), .y9(NET00142));
t371 cell_O10(.x1(RC3), .y3(nRC3), .y4(RC3), .x6(nREQ));
t421 cell_H28(.x1(nFVEC), .y2(NET00238), .x3(NET00454), .x4(nFDC), .x5(FVEN), .x6(nSHR6), .x10(NET00009));
t406 cell_J17(.c1(SHIFT), .r2(RCNT), .q3(NET00319), .q4(NET00321), .r5(NET00467), .s10(NET00466));
t428 cell_K25(.x2(nSDOUT), .y3(nSDOUT0));
t381 cell_M23(.x1(NET00349), .y2(NET00350), .x3(RCNT), .x4(nSHR7), .x6(SHIFT));
t374 cell_M24(.x1(nSHIFT), .x2(NET00344), .x3(NET00347), .y4(NET00348), .y8(NET00347));
t416 cell_D2(.c1(nSYNC), .q3(nA1), .q4(A1), .d5(AD1));
t376 cell_A1(.x1(NET00235), .x3(NET00236), .y4(NET00124), .x6(nVEN), .x8(FDC), .y9(NET00236));
t381 cell_A8(.x1(EN15), .y2(NET00245), .x3(NET00248), .x4(RDB0), .x6(RDP0_B4));
t376 cell_G5(.x1(NET00104), .x3(VEC4), .y4(NET00067), .x6(NET00012), .x8(VEC3), .y9(NET00068));
t378 cell_M3(.x1(nRC0), .y2(M1), .x3(RC1), .x5(RC2));
t418 cell_D22(.x1(NET00025), .x2(nSELX), .y3(SELX), .y4(NET00173), .x5(SELX), .x6(nSELX), .x10(NET00185));
t370 cell_D24(.y2(NET00183), .x5(NET00317));
t383 cell_G17(.x1(NET00015), .y2(NET00017), .x3(NET00016), .x4(NET00019), .x5(NET00014), .x6(NET00018));
t380 cell_H13(.x1(F200), .y2(nFVEC), .y3(FVEC), .x4(F174), .x5(FVEC), .x6(F170));
t429 cell_K24(.y3(RCNT), .x5(NET00362));
t370 cell_N23(.y2(nSC_S), .x5(NET00439));
t380 cell_N24(.x1(nWTBT), .y2(nWTBT), .y3(IRQB), .x4(nBPIC), .x5(NET00470), .x6(nSC_S));
t372 cell_A5(.x1(NET00116), .y2(NET00116), .y3(NET00235), .y4(NET00244), .x5(NET00244), .x6(NET00245));
t429 cell_K1(.y3(RC4), .x5(NET00076));
t373 cell_A7(.x1(nVEN), .x3(SELX), .y4(NET00248));
t381 cell_B9(.x1(nSEL), .y2(RDB0), .x3(nSDIN0), .x4(NET00062), .x6(M0));
t378 cell_M5(.x1(nRC0), .y2(M3), .x3(nRC1), .x5(RC2));
t378 cell_M6(.x1(RC0), .y2(M4), .x3(RC1), .x5(nRC2));
t385 cell_D27(.x1(nINIT), .x2(WRB6), .y3(NET00177), .x5(NET00317), .y8(NET00175));
t428 cell_E32(.x2(NET00207), .y3(nIRQ));
t376 cell_F31(.x1(nPIO), .x3(NET00082), .y4(nREQA), .x6(nPIO), .x8(nREQB), .y9(REQB));
t406 cell_I13(.c1(NET00252), .r2(FINIT), .q3(NET00327), .q4(NET00324), .r5(NET00326), .s10(NET00328));
t428 cell_K29(.x2(NET00376), .y3(NET00252));
t380 cell_N28(.x1(NET00475), .y2(NET00475), .y3(NET00298), .x4(NET00366), .x5(nOUT), .x6(nFDC));
t418 cell_L33(.x1(FSEL2), .x2(NET00336), .y3(NET00332), .y4(NET00336), .x5(nSRUN2), .x6(FSEL0), .x10(nSRUN0));
t378 cell_M2(.x1(RC0), .y2(NET00000), .x3(RC1), .x5(RC2));
t378 cell_B11(.x1(nSEL), .y2(RDB4), .x3(nSDIN0), .x5(NET00096));
t383 cell_L4(.x1(M0), .y2(nBPIC), .x3(M2), .x4(M4), .x5(M1), .x6(M3));
t380 cell_N4(.x1(nBPIC), .y2(nRC4), .y3(IRQA), .x4(RC4), .x5(RC4), .x6(nREQ));
t374 cell_D32(.x1(nDIN), .x2(NET00282), .x3(NET00279), .y4(NET00282), .y8(NET00269));
t373 cell_D33(.x1(nIRQ), .x3(NET00281), .y4(NET00277));
t428 cell_E36(.x2(NET00249), .y3(BPIC0));
t373 cell_F32(.x1(PIOB), .x3(FDC0), .y4(NET00249));
t429 cell_K13(.y3(FDC), .x5(NET00300));
t370 cell_H29(.y2(NET00103), .x5(AD6));
t376 cell_M20(.x1(NET00350), .x3(NET00355), .y4(NET00357), .x6(NET00356), .x8(NET00353), .y9(NET00358));
t428 cell_K31(.x2(SH_nLD), .y3(NET00265));
t372 cell_M25(.x1(NET00343), .y2(NET00343), .y3(NET00344), .y4(NET00342), .x5(NET00342), .x6(nSHIFT));
t393 cell_N33(.x1(NET00414), .x3(FVEN), .y4(NET00393), .x5(NET00413), .x6(nFSYNC), .y9(NET00413));
t388 cell_M34(.x1(NET00419), .y2(NET00419), .x3(nAD0), .y4(NET00422), .y5(FSTR), .x6(NET00421), .x7(FSTR), .x10(nWTBTS));
t378 cell_B13(.x1(nSEL), .y2(RDP0_B4), .x3(nSDIN0), .x5(NET00098));
t378 cell_B14(.x1(nSEL), .y2(NET00120), .x3(nSDOUT0), .x5(nWREIA));
t429 cell_K5(.y3(BPIC), .x5(nBPIC));
t370 cell_A38(.y2(NET00219), .x5(WRP2H));
t395 cell_F14(.x1(NET00035), .y2(NET00036), .x3(NET00036), .x4(NET00034), .x5(NET00034), .x6(NET00035), .y8(NET00015));
t376 cell_F13(.x1(F200), .x3(F170), .y4(NET00039), .x6(FDC), .x8(M3), .y9(NET00035));
t416 cell_D34(.c1(NET00215), .q3(NET00278), .q4(NET00275), .d5(NET00280));
t391 cell_D35(.x1(NET00275), .x2(NET00277), .y3(NET00276), .y4(NET00279), .x5(NET00083), .x6(NET00278), .y9(NET00242), .x10(NET00083));
t373 cell_F36(.x1(nFIRQ), .x3(nFDC), .y4(NET00205));
t370 cell_F35(.y2(PINIT), .x5(nPINIT));
t378 cell_M12(.x1(nM15), .y2(F170), .x3(RC4), .x5(RC5));
t378 cell_M13(.x1(nM15), .y2(F174), .x3(nRC4), .x5(RC5));
t406 cell_L16(.c1(nSHIFT), .r2(RCNT), .q3(NET00466), .q4(NET00467), .r5(NET00319), .s10(NET00321));
t428 cell_K33(.x2(FSEL2), .y3(NET00009));
t375 cell_M28(.x1(FRUN), .y2(NET00341), .y3(FRW), .x4(FRW), .x5(NET00338), .x6(NET00341), .y9(NET00333));
t376 cell_I37(.x1(nFTR), .x3(FRUN), .y4(NET00455), .x6(NET00455), .x8(nFSEL0), .y9(NET00209));
t370 cell_N34(.y2(nFSEL0), .x5(FSEL0));
t372 cell_O32(.x1(NET00392), .y2(NET00392), .y3(NET00389), .y4(NET00391), .x5(NET00391), .x6(NET00387));
t370 cell_I1(.y2(nAD0), .x5(AD0));
t370 cell_G1(.y2(NET00070), .x5(AD1));
t378 cell_B5(.x1(nSEL), .y2(RDP2), .x3(nSDIN0), .x5(NET00054));
t390 cell_C4(.x1(A06), .y4(NET00059), .x5(BPIC), .x6(A04), .y9(NET00061), .x10(PIO));
t382 cell_L6(.x1(nRC2), .y2(NET00170), .x3(nRC3), .x4(nRC1), .x5(NET00170), .x6(nRC0), .y8(nM15));
t385 cell_G12(.x1(NET00021), .x2(NET00022), .y3(NET00022), .x5(FDC), .y8(NET00023));
t373 cell_B24(.x1(nVEN), .x3(NET00226), .y4(VEC2));
t381 cell_D38(.x1(FRUN), .y2(NET00217), .x3(WRB6), .x4(WRP2L), .x6(WRP2H));
t381 cell_F16(.x1(M13), .y2(NET00028), .x3(M14), .x4(F200), .x6(M1));
t370 cell_G37(.y2(nDONE), .x5(NET00080));
t370 cell_G38(.y2(nFTR), .x5(NET00082));
t378 cell_M14(.x1(nM15), .y2(F200), .x3(RC4), .x5(nRC5));
t378 cell_M15(.x1(nM15), .y2(FXX0), .x3(nRC4), .x5(nRC5));
t406 cell_L18(.c1(NET00319), .r2(RCNT), .q3(NET00465), .q4(NET00464), .r5(NET00372), .s10(NET00375));
t384 cell_C29(.x1(IEA), .y3(NET00207A), .x5(NET00205));
t418 cell_I30(.x1(nSHR5), .x2(NET00396), .y3(NET00394), .y4(NET00396), .x5(NET00265), .x6(NET00103), .x10(NET00266));
t429 cell_K35(.y3(INIT), .x5(nINIT));
t376 cell_I38(.x1(nDONE), .x3(FRUN), .y4(NET00229), .x6(NET00229), .x8(nFSEL0), .y9(nSIRQ));
t373 cell_O28(.x1(NET00409), .x3(nFDC), .y4(NET00460));
t374 cell_M36(.x1(nA1), .x2(NET00108), .x3(nFSYNC), .y4(FSEL2), .y8(nFSYNC));
t378 cell_B2(.x1(nSEL), .y2(WRB6), .x3(nSDOUT0), .x5(NET00059));
t378 cell_B15(.x1(nSEL), .y2(NET00118), .x3(nSDOUT0), .x5(nAP0));
t376 cell_D3(.x1(A1), .x3(nA2), .y4(A04), .x6(A1), .x8(A2), .y9(A00));
t390 cell_C6(.x1(PIO), .y4(NET00054), .x5(A02), .x6(BPIC), .y9(NET00056), .x10(A02));
t381 cell_M7(.x1(RC3), .y2(M5), .x3(nRC2), .x4(nRC0), .x6(RC1));
t370 cell_B25(.y2(NET00228), .x5(AD6));
t417 cell_O15(.x1(A00), .y4(NET00272A), .x5(M0), .x6(A02), .x10(M0));
t383 cell_L9(.x1(M13), .y2(NET00071), .x3(M6), .x4(M7), .x5(M5), .x6(M14));
t395 cell_F22(.x1(NET00148), .y2(NET00149), .x3(NET00149), .x4(AD5), .x5(AD5), .x6(NET00148), .y8(NET00137));
t370 cell_L37(.y2(nINIT), .x5(NET00381));
t378 cell_H25(.x1(nSEL), .y2(NET00108), .x3(nSYNC), .x5(nFDC));
t376 cell_O19(.x1(NET00458), .x3(PIO), .y4(NET00462), .x6(SELX), .x8(nVEN), .y9(FVEN0));
t399 cell_J30(.r1(nSCLK), .x2(nSCLK), .q3(NET00443), .q4(NET00376), .s6(NET00444), .y7(NET00444));
t378 cell_B16(.x1(nSEL), .y2(RDP0), .x3(nSDIN0), .x5(nAP0));
t378 cell_B3(.x1(nSEL), .y2(RDP4), .x3(nSDIN0), .x5(NET00061));
t379 cell_F3(.x1(nVEN), .y2(VEC7), .x3(FDC), .y4(NET00314), .x5(NET00314), .x6(PIO), .x8(M0));
t378 cell_F4(.x1(nVEN), .y2(VEC6), .x3(FDC), .x5(NET00311));
t370 cell_J4(.y2(NET00315), .x5(AD3));
t381 cell_M9(.x1(nRC1), .y2(M6), .x3(nRC2), .x4(RC0), .x6(RC3));
t381 cell_M10(.x1(nRC1), .y2(M14), .x3(nRC2), .x4(RC0), .x6(nRC3));
t370 cell_D16(.y2(NET00018), .x5(NET00092));
t406 cell_C33(.c1(NET00288), .r2(NET00283), .q4(NET00281), .r5(NET00287), .s10(NET00289));
t399 cell_C32(.r1(nIRQ), .x2(nIRQ), .q3(NET00287), .q4(NET00289), .s6(NET00283), .y7(NET00288));
t406 cell_I28(.c1(NET00257), .r2(FINIT), .q4(nSHR6), .r5(NET00397), .s10(NET00395));
t390 cell_O37(.x1(NET00382), .y4(nSDOUT), .x5(NET00387), .x6(NET00084), .y9(nSDIN), .x10(NET00387));
t421 cell_H32(.x1(FVEC), .y2(NET00210), .x3(NET00209), .x4(nFDC), .x5(FVEN), .x6(nSHR7), .x10(NET00009));
t418 cell_I34(.x1(nSHR6), .x2(NET00452), .y3(NET00450), .y4(NET00452), .x5(NET00265), .x6(NET00150), .x10(NET00266));
t406 cell_M30(.c1(NET00341), .r2(NET00335), .q3(FRUN), .r5(NET00337), .s10(NET00334));
t379 cell_F5(.x1(M3), .y2(NET00307), .x3(M2), .y4(NET00311), .x5(M1), .x6(M3), .x8(PIO));
t381 cell_M11(.x1(nRC1), .y2(M7), .x3(nRC2), .x4(nRC0), .x6(RC3));
t416 cell_C35(.c1(nDIN), .q4(NET00280), .d5(NET00277));
t406 cell_I29(.c1(NET00252), .r2(FINIT), .q3(NET00395), .q4(NET00397), .r5(NET00394), .s10(NET00396));
t392 cell_A18(.x1(CSR0), .x3(NET00159), .y4(NET00141), .x5(RDP0));
t406 cell_B26(.c1(NET00120), .r2(INIT), .q3(IEA), .q4(nIEA), .r5(NET00228), .s10(AD6));
t370 cell_H18(.y2(NET00001), .x5(AD4));
t406 cell_I32(.c1(NET00257), .r2(FINIT), .q3(SHR7), .q4(nSHR7), .r5(NET00449), .s10(NET00451));
t397 cell_L32(.x1(FSTR), .y2(NET00434), .x3(NET00434), .x4(nOUT), .x5(nOUT), .x6(FSTR), .y7(NET00436), .y8(NET00435), .x10(NET00435));
t378 cell_F6(.x1(nVEN), .y2(VEC5), .x3(FDC), .x5(NET00307));
t392 cell_A20(.x1(CSR1), .x3(NET00156), .y4(NET00121), .x5(RDP0));
t392 cell_A22(.x1(NET00202), .x3(NET00008), .y4(NET00123), .x5(VEC2));
t406 cell_C26(.c1(NET00115), .r2(INIT), .q3(IEB), .q4(nIEB), .r5(NET00198), .s10(NET00197));
t406 cell_D26(.c1(NET00175), .r2(NET00177), .q3(SC_A), .r5(NET00174), .s10(NET00178));
t383 cell_F26(.x1(F170), .y2(NET00145), .x3(M2), .x4(M1), .x5(F174), .x6(M0));
t421 cell_H24(.x1(FVEC), .y2(NET00107), .x3(nSIRQ), .x4(nFDC), .x5(FVEN), .x6(nSHR5), .x10(NET00009));
t406 cell_I20(.c1(NET00257), .r2(FINIT), .q4(nSHR4), .r5(NET00386), .s10(NET00384));
t406 cell_J20(.c1(NET00252), .r2(FINIT), .q3(NET00384), .q4(NET00386), .r5(NET00383), .s10(NET00385));
t418 cell_I14(.x1(nSHR1), .x2(NET00328), .y3(NET00326), .y4(NET00328), .x5(NET00265), .x6(NET00163), .x10(NET00266));
t421 cell_H8(.x1(nFVEC), .y2(NET00156), .x3(NET00007), .x4(nFDC), .x5(FVEN), .x6(nSHR1), .x10(NET00009));
t417 cell_C30(.x1(IEA), .y4(NET00207B), .x5(IRQA), .x6(IEA), .x10(nREQA));
t421 cell_A26(.x1(nFIRQ), .y2(NET00478), .x3(VEC5), .x4(NET00107), .x5(RDB4), .x6(RDP0), .x10(IEB));
t417 cell_B31(.x1(SC_A), .y4(NET00161), .x5(BPIC0), .x6(NET00224), .x10(PIOB));
t417 cell_B32(.x1(AC_S), .y4(NET00164), .x5(BPIC0), .x6(NET00130), .x10(PIOB));
t421 cell_H16(.x1(F170), .y2(NET00012), .x3(NET00007), .x4(nFDC), .x5(FVEN), .x6(nSHR3), .x10(NET00009));
t406 cell_L19(.c1(NET00321), .r2(RCNT), .q3(NET00372), .q4(NET00375), .r5(NET00464), .s10(NET00465));
t406 cell_L20(.c1(NET00372), .r2(RCNT), .q3(NET00373), .q4(NET00374), .r5(NET00367), .s10(NET00371));
t379 cell_O20(.x1(NET00472), .y2(NET00473), .x3(NET00458), .y4(NET00463), .x5(nRC5), .x6(NET00462), .x8(NET00473));
t372 cell_O2(.x1(nRC2), .y2(RC0), .y3(RC2), .y4(RC1), .x5(nRC0), .x6(nRC1));
t388 cell_C8(.x1(AP0), .y2(AB0), .x3(AB0), .y4(nWREIB), .y5(NET00062), .x6(A00), .x7(NET00062), .x10(BPIC));
t421 cell_A30(.x1(IRQB), .y2(NET00119), .x3(VEC7), .x4(NET00210), .x5(RDB0), .x6(RDP0_B4), .x10(nFTR));
t378 cell_A31(.x1(RDP0_B4), .y2(NET00222), .x3(EN15), .x5(RDB0));
t373 cell_B33(.x1(REQB), .x3(IRQA), .y4(NET00226));
t370 cell_B35(.y2(NET00220), .x5(PIOB));
t374 cell_F34(.x1(nDIN), .x2(NET00241), .x3(NET00242), .y4(NET00241), .y8(NET00243));
t406 cell_I17(.c1(NET00252), .r2(FINIT), .q3(NET00331), .q4(NET00329), .r5(NET00322), .s10(NET00323));
t379 cell_M19(.x1(RCNT), .y2(NET00349), .x3(NET00358), .y4(NET00354), .x5(NET00354), .x6(NET00349), .x8(NET00357));
t388 cell_J36(.x1(NET00381), .y2(NET00447), .x3(NET00447), .y4(nPINIT), .y5(NET00446), .x6(NET00428), .x7(NET00446), .x10(WRB4));
t379 cell_J37(.x1(nSDOUT), .y2(NET00445), .x3(NET00417), .y4(nSCLK), .x5(SH_nLD), .x6(NET00445), .x8(NET00348));
t383 cell_F1(.x1(M6), .y2(NET00313), .x3(M3), .x4(M14), .x5(M1), .x6(M2));
t381 cell_F7(.x1(M13), .y2(NET00310), .x3(M14), .x4(M3), .x6(M2));
t378 cell_F8(.x1(nVEN), .y2(VEC3), .x3(FDC), .x5(NET00310));
t419 cell_C38(.x1(BPIC0), .y2(NET00216), .x4(WRP2L), .x5(PINIT), .x6(FINIT), .x10(FDC0));
t382 cell_G20(.x1(nSELA), .y2(NET00135), .x3(NET00134), .x4(NET00023), .x5(NET00133), .x6(NET00026), .y8(NET00134));
t383 cell_G22(.x1(NET00136), .y2(NET00133), .x3(NET00137), .x4(NET00139), .x5(NET00030), .x6(NET00138));
t406 cell_I16(.c1(NET00257), .r2(FINIT), .q4(nSHR3), .r5(NET00329), .s10(NET00331));
t406 cell_I5(.c1(NET00252), .r2(FINIT), .q3(NET00261), .q4(NET00263), .r5(NET00260), .s10(NET00262));
t406 cell_B20(.c1(NET00118), .r2(INIT), .q3(CSR1), .q4(NET00224), .r5(NET00125), .s10(AD1));
t371 cell_C22(.x1(RDB2), .y3(NET00188), .y4(NET00193), .x6(RDB2));
t370 cell_C24(.y2(NET00191), .x5(IRQB));
t406 cell_L21(.c1(NET00375), .r2(RCNT), .q3(NET00367), .q4(NET00371), .r5(NET00374), .s10(NET00373));
t406 cell_I8(.c1(NET00257), .r2(FINIT), .q4(nSHR1), .r5(NET00256), .s10(NET00253));
t406 cell_C20(.c1(NET00193), .r2(NET00191), .q4(AC_S), .r5(NET00192), .s10(NET00190));
t418 cell_C25(.x1(AD6), .x2(NET00198), .y3(NET00197), .y4(NET00198), .x5(BPIC0), .x6(AD5), .x10(PIOB));
t380 cell_M22(.x1(SHIFT), .y2(SHIFT), .y3(NET00353), .x4(nSHR7), .x5(nSHIFT), .x6(NET00354));
t406 cell_L23(.c1(NET00371), .r2(RCNT), .q3(CNT8), .q4(NET00369), .r5(NET00370), .s10(NET00368));
t406 cell_I24(.c1(NET00257), .r2(FINIT), .q4(nSHR5), .r5(NET00405), .s10(NET00404));
t406 cell_I25(.c1(NET00252), .r2(FINIT), .q3(NET00404), .q4(NET00405), .r5(NET00402), .s10(NET00403));
t395 cell_N37(.x1(FVEN), .y2(NET00409), .x3(nFSYNC), .x4(NET00338), .x5(nSDIN0), .x6(nSDOUT), .y8(NET00338));
t428 cell_K30(.x2(NET00443), .y3(NET00257));
t428 cell_K21(.x2(NET00378), .y3(nSYNC));
t393 cell_L36(.x1(NET00428), .x3(NET00429), .y4(NET00430), .x5(WRF0), .x6(nINIT), .y9(NET00429));
t370 cell_H6(.y2(NET00163), .x5(AD2));
t370 cell_H34(.y2(NET00215), .x5(nDIN));
t370 cell_H37(.y2(NET00213), .x5(RDP2));
t370 cell_G34(.y2(nFIRQ), .x5(NET00229));
t370 cell_O21(.y2(NET00438), .x5(NET00458));
t416 cell_D1(.c1(nSYNC), .q3(nA0), .q4(A0), .d5(AD0));
t374 cell_N3(.x1(RC5), .x2(RC5), .x3(RC4), .y4(NET00317), .y8(nRC5));
t428 cell_K2(.x2(NET00000), .y3(M0));
t370 cell_A3(.y2(NET00122), .x5(NET00235));
t381 cell_B7(.x1(nSEL), .y2(RDB2), .x3(nSDIN0), .x4(NET00056), .x6(M0));
t381 cell_B10(.x1(nSEL), .y2(NET00115), .x3(nSDOUT0), .x4(nWREIB), .x6(M0));
t378 cell_B12(.x1(nSEL), .y2(WRB4), .x3(nSDOUT0), .x5(NET00096));
t378 cell_C11(.x1(AB4), .y2(nWREIA), .x3(NET00095), .x5(AP0));
t378 cell_M4(.x1(RC0), .y2(M2), .x3(nRC1), .x5(RC2));
t418 cell_L25(.x1(SHR7), .x2(CNT8), .y3(NET00363), .y4(NET00366), .x5(NET00363), .x6(CNT8), .x10(NET00354));
t385 cell_D11(.x1(nA1), .x2(NET00094), .y3(NET00094), .x5(FDC), .y8(NET00095));
t395 cell_F10(.x1(NET00042), .y2(NET00043), .x3(NET00043), .x4(NET00041), .x5(NET00041), .x6(NET00042), .y8(NET00014));
t371 cell_B19(.x1(AD1), .y3(NET00125), .y4(NET00127), .x6(AD0));
t395 cell_F12(.x1(NET00039), .y2(NET00482), .x3(NET00482), .x4(AD2), .x5(AD2), .x6(NET00039), .y8(NET00021));
t406 cell_D25(.c1(WRB6), .r2(NET00177), .q3(NET00178), .q4(NET00174), .r5(NET00183), .s10(NET00317));
t384 cell_D31(.x1(nINIT), .y3(NET00283), .x5(NET00279));
t383 cell_F19(.x1(M6), .y2(NET00045), .x3(M14), .x4(M2), .x5(F200), .x6(M0));
t428 cell_E20(.x2(NET00173), .y3(nSEL));
t428 cell_E33(.x2(NET00269), .y3(nVEN));
t429 cell_E31(.y3(PIOB), .x5(nPIO));
t371 cell_G19(.x1(NET00017), .y3(nSELA), .y4(NET00026), .x6(NET00025));
t421 cell_H12(.x1(F174), .y2(NET00008), .x3(NET00007), .x4(nFDC), .x5(FVEN), .x6(nSHR2), .x10(NET00009));
t406 cell_I12(.c1(NET00257), .r2(FINIT), .q4(nSHR2), .r5(NET00324), .s10(NET00327));
t418 cell_I10(.x1(nSHR0), .x2(NET00255), .y3(NET00251), .y4(NET00255), .x5(NET00265), .x6(NET00070), .x10(NET00266));
t378 cell_L11(.x1(FXX0), .y2(nSELX), .x3(M7), .x5(M4));
t428 cell_K26(.x2(FSEL0), .y3(NET00007));
t428 cell_K28(.x2(FVEN0), .y3(FVEN));
t385 cell_O34(.x1(NET00388), .x2(NET00389), .y3(NET00378), .x5(NET00387), .y8(NET00388));
t429 cell_K32(.y3(NET00266), .x5(SH_nLD));
t370 cell_O25(.y2(nSHIFT), .x5(NET00471));
t418 cell_I18(.x1(nSHR2), .x2(NET00323), .y3(NET00322), .y4(NET00323), .x5(NET00265), .x6(NET00315), .x10(NET00266));
t416 cell_N26(.c1(NET00391), .q3(nWTBTS), .d5(NET00470));
t399 cell_M32(.r1(nFSYNC), .x2(nSDIN0), .q3(NET00423), .q4(NET00424), .s6(NET00414), .y7(NET00414));
t373 cell_O33(.x1(NET00393), .x3(nFDC), .y4(EN15));
t405 cell_M33(.c1(NET00425), .x2(NET00414), .q4(NET00421), .r5(NET00424), .y7(NET00425), .s10(NET00423));
t378 cell_F2(.x1(nVEN), .y2(VEC4), .x3(FDC), .x5(NET00313));
t381 cell_B4(.x1(nSEL), .y2(WRP2H), .x3(nSDOUT0), .x4(NET00054), .x6(NET00483));
t376 cell_D4(.x1(nA1), .x3(nA2), .y4(A06), .x6(nA1), .x8(A2), .y9(A02));
t429 cell_K6(.y3(RC5), .x5(NET00079));
t429 cell_K8(.y3(PIO), .x5(NET00071));
t381 cell_M8(.x1(nRC3), .y2(M13), .x3(nRC2), .x4(nRC0), .x6(RC1));
t370 cell_C18(.y2(NET00019), .x5(NET00101));
t381 cell_L13(.x1(F200), .y2(NET00300), .x3(FXX0), .x4(F174), .x6(F170));
t418 cell_I26(.x1(nSHR4), .x2(NET00403), .y3(NET00402), .y4(NET00403), .x5(NET00265), .x6(NET00132), .x10(NET00266));
t376 cell_O17(.x1(nSEL), .x3(nSDOUT), .y4(NET00457), .x6(nSEL), .x8(nSDIN), .y9(NET00459));
t421 cell_O18(.x1(NET00457), .y2(NET00458), .x3(FVEN0), .x4(NET00460), .x5(NET00272), .x6(NET00459), .x10(NET00272));
t429 cell_K34(.y3(FINIT), .x5(NET00430));
t428 cell_K38(.x2(nSDIN), .y3(nSDIN0));
t370 cell_N29(.y2(nOUT), .x5(NET00474));
t391 cell_L30(.x1(nDONE), .x2(nDONE), .y3(NET00437), .y4(nSRUN2), .x5(NET00436), .x6(NET00437), .y9(nSRUN0), .x10(NET00422));
t406 cell_M29(.c1(NET00333), .r2(NET00335), .q3(NET00334), .q4(NET00337), .r5(NET00332), .s10(NET00336));
t378 cell_N35(.x1(NET00409), .y2(WRF0), .x3(nSDOUT), .x5(nFSEL0));
t381 cell_N36(.x1(nSDIN0), .y2(NET00303), .x3(nFERR), .x4(nFDC), .x6(nFSEL0));
t421 cell_H4(.x1(nFVEC), .y2(NET00159), .x3(NET00007), .x4(nFDC), .x5(FVEN), .x6(nSHR0), .x10(NET00009));
t420 cell_A32(.x1(nWTBT), .y2(NET00221), .y3(NET00302), .x4(NET00303), .x5(RDB0), .x6(RDP0_B4), .x7(nREQB), .x10(NET00302));
t378 cell_B38(.x1(NET00298), .y2(NET00218), .x3(RDP4), .x5(RDB2));
t395 cell_F27(.x1(NET00145), .y2(NET00146), .x3(NET00146), .x4(AD7), .x5(AD7), .x6(NET00145), .y8(NET00138));
t397 cell_M37(.x1(A1), .y2(FSEL0), .x3(FSEL0), .x4(nFSYNC), .x5(FSEL2), .x6(NET00416), .y7(NET00416), .y8(NET00417), .x10(nFTR));
t421 cell_H20(.x1(FVEC), .y2(NET00104), .x3(NET00007), .x4(nFDC), .x5(FVEN), .x6(nSHR4), .x10(NET00009));
t384 cell_O16(.x1(A06), .y3(NET00272B), .x5(PIO));
t379 cell_M21(.x1(RCNT), .y2(NET00356), .x3(NET00353), .y4(NET00355), .x5(NET00355), .x6(NET00356), .x8(NET00350));
t406 cell_I33(.c1(NET00252), .r2(FINIT), .q3(NET00451), .q4(NET00449), .r5(NET00450), .s10(NET00452));
t373 cell_I36(.x1(IEA), .x3(nFSEL0), .y4(NET00454));
t375 cell_J38(.x1(NET00440), .y2(SH_nLD), .y3(NET00440), .x4(NET00441), .x5(nDONE), .x6(nFTR), .y9(NET00441));
t406 cell_I4(.c1(NET00257), .r2(FINIT), .q4(nSHR0), .r5(NET00263), .s10(NET00261));
t418 cell_I6(.x1(nSC_S), .x2(NET00262), .y3(NET00260), .y4(NET00262), .x5(NET00265), .x6(nAD0), .x10(NET00266));
t406 cell_I9(.c1(NET00252), .r2(FINIT), .q3(NET00253), .q4(NET00256), .r5(NET00251), .s10(NET00255));
t406 cell_B18(.c1(NET00118), .r2(INIT), .q3(CSR0), .q4(NET00130), .r5(NET00127), .s10(AD0));
t395 cell_F20(.x1(NET00045), .y2(NET00147), .x3(NET00147), .x4(AD4), .x5(AD4), .x6(NET00045), .y8(NET00136));
t406 cell_C21(.c1(RDB2), .r2(NET00191), .q3(NET00190), .q4(NET00192), .r5(NET00188), .s10(RDB2));
t417 cell_C31(.x1(REQB), .y4(NET00207C), .x5(IEB), .x6(IRQB), .x10(IEB));
t419 cell_C27(.x1(nIEA), .y2(NET00202), .x4(M0), .x5(BPIC0), .x6(nIEB), .x10(PIOB));
t395 cell_F17(.x1(NET00028), .y2(NET00029), .x3(NET00029), .x4(AD3), .x5(AD3), .x6(NET00028), .y8(NET00030));
t406 cell_L22(.c1(NET00367), .r2(RCNT), .q3(NET00368), .q4(NET00370), .r5(CNT8), .s10(NET00369));
t377 cell_L28(.x1(FINIT), .y2(NET00335), .x3(SH_nLD), .y4(NET00359), .x5(NET00359), .x6(FINIT), .x8(FRUN), .y9(NET00362));
t421 cell_A28(.x1(IEA), .y2(NET00479), .x3(VEC6), .x4(NET00238), .x5(RDP0_B4), .x6(RDB0), .x10(IEB));
t418 cell_I22(.x1(nSHR3), .x2(NET00385), .y3(NET00383), .y4(NET00385), .x5(NET00265), .x6(NET00001), .x10(NET00266));

//______________________________________________________________________________
//
// Manual corrections - wired-AND implementations
//
assign   NET00207 = NET00207A & NET00207B & NET00207C;
assign   NET00272 = NET00272A & NET00272B;

endmodule
//______________________________________________________________________________
//
