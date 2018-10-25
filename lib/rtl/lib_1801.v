//
// Copyright (c) 2013-2014 by 1801BM1@gmail.com
//______________________________________________________________________________
//
`timescale 1ns / 10ps

//______________________________________________________________________________
//
module tINPUT
(
	input		x1,
	output	y1,
	output	y2
);		

assign #5.25 y1 = x1;
assign #4.25 y2 = ~x1;
endmodule

//______________________________________________________________________________
//
module tOUTPUT
(
	input		x1,
	output	y1
);		

assign #16.50 y1 = x1;
endmodule

//______________________________________________________________________________
//
module tOUTPUT_OC
(
	input		x1,
	output	y1
);		

assign #16.50 y1 = x1 ? 1'bz : 1'b0;
endmodule

//______________________________________________________________________________
//
module tOUTPUT_OE
(
	input		x1,
	input		x2,
	output	y1
);		

assign #16.50 y1 = x2 ? 1'bz : x1;
endmodule

//______________________________________________________________________________
//
module t370
(
	output	y2,
	input		x5
);

assign	#3.75 y2 = ~x5;
endmodule

//______________________________________________________________________________
//
module t371
(
	input		x1,
	output	y3,
	output	y4,
	input		x6
);

assign	#3.75 y3 = ~x1;
assign	#3.75 y4 = ~x6;
endmodule

//______________________________________________________________________________
//
module t372
(
	input		x1,
	output	y2,
	output	y3,
	output	y4,
	input		x5,
	input		x6
);

assign	#3.75 y2 = ~x5;
assign	#3.75 y3 = ~x1;
assign	#3.75 y4 = ~x6;
endmodule

//______________________________________________________________________________
//
module t373
(
	input		x1,
	input		x3,
	output	y4
);

assign	#4.50 y4 = ~(x1 | x3);
endmodule

//______________________________________________________________________________
//
module t374
(
	input		x1,
	input		x2,
	input		x3,
	output	y4,
	output	y8
);

assign	#3.75 y8 = ~x2;
assign	#4.50 y4 = ~(x1 | x3);
endmodule

//______________________________________________________________________________
//
module t375
(
	input		x1,
	output	y2,
	output	y3,
	input		x4,
	input		x5,
	input		x6,
	output	y9
);

assign	#3.75 y9 = ~x6;
assign	#3.75 y3 = ~x5;
assign	#4.50 y2 = ~(x1 | x4);
endmodule

//______________________________________________________________________________
//
module t376
(
	input		x1,
	input		x3,
	output	y4,
	input		x6,
	input		x8,
	output	y9
);

assign	#4.50 y4 = ~(x1 | x3);
assign	#4.50 y9 = ~(x6 | x8);
endmodule

//______________________________________________________________________________
//
module t377
(
	input		x1,
	output	y2,
	input		x3,
	output	y4,
	input		x5,
	input		x6,
	input		x8,
	output	y9
);

assign	#4.50 y9 = ~(x6 | x8);
assign	#4.50 y4 = ~(x3 | x1);
assign	#3.75 y2 = ~x5;
endmodule

//______________________________________________________________________________
//
module t378
(
	input		x1,
	output	y2,
	input		x3,
	input		x5
);

assign	#5.25 y2 = ~(x1 | x3 | x5);
endmodule

//______________________________________________________________________________
//
module t379
(
	input		x1,
	output	y2,
	input		x3,
	output	y4,
	input		x5,
	input		x6,
	input		x8
);

assign	#5.25 y2 = ~(x1 | x3 | x5);
assign	#4.50 y4 = ~(x6 | x8);
endmodule

//______________________________________________________________________________
//
module t380
(
	input		x1,
	output	y2,
	output	y3,
	input		x4,
	input		x5,
	input		x6
);

assign	#3.75 y2 = ~x5;
assign	#5.25 y3 = ~(x1 | x4 | x6);
endmodule

//______________________________________________________________________________
//
module t381
(
	input		x1,
	output	y2,
	input		x3,
	input		x4,
	input		x6
);

assign #5.75 y2 = ~(x1 | x3 | x4 | x6);
endmodule

//______________________________________________________________________________
//
module t382
(
	input		x1,
	output	y2,
	input		x3,
	input		x4,
	input		x5,
	input		x6,
	output	y8
);

assign #5.75 y2 = ~(x1 | x3 | x4 | x6);
assign #3.75 y8 = ~x5;
endmodule

//______________________________________________________________________________
//
module t383
(
	input		x1,
	output	y2,
	input		x3,
	input		x4,
	input		x5,
	input		x6
);

assign #7.25 y2 = ~(x1 | x3 | x4 | x5 | x6);
endmodule

//______________________________________________________________________________
//
module t384
(
	input		x1,
	output	y3,
	input		x5
);

assign	#6.50 y3 = ~(x1 & x5);
endmodule

//______________________________________________________________________________
//
module t385
(
	input		x1,
	input		x2,
	output	y3,
	input		x5,
	output	y8
);

assign 	#3.75 y8 = ~x2;
assign	#6.50 y3 = ~(x1 & x5);
endmodule

//______________________________________________________________________________
//
module t386
(
	input		x1,
	output	y2,
	output	y3,
	output	y4,
	input		x5,
	input		x6,
	input		x7
);

assign	#6.50 y4 = ~(x1 & x5);
assign	#3.75 y2 = ~x6;
assign	#3.75 y3 = ~x7;
endmodule

//______________________________________________________________________________
//
module t387
(
	input		x1,
	output	y2,
	input		x3,
	output	y4,
	input		x5,
	input		x6
);

assign	#6.50 y2 = ~(x1 & x5);
assign	#4.50 y4 = ~(x3 | x6);
endmodule

//______________________________________________________________________________
//
module t388
(
	input		x1,
	output	y2,
	input		x3,
	output	y4,
	output	y5,
	input		x6,
	input		x7,
	input		x10
);

assign	#3.75 y2 = ~x7;
assign	#4.50 y4 = ~(x1 | x3);
assign	#4.50 y5 = ~(x6 & x10);
endmodule

//______________________________________________________________________________
//
module t389
(
	input		x1,
	input		x2,
	output	y3,
	input		x4,
	output	y5,
	input		x6,
	input		x10
);

assign	#5.25 y3 = ~(x1 | x2 | x4);
assign	#4.50 y5 = ~(x6 & x10);
endmodule

//______________________________________________________________________________
//
module t390
(
	input		x1,
	output	y4,
	input		x5,
	input		x6,
	output	y9,
	input		x10
);

assign #6.50 y9 = ~(x6 & x10);
assign #6.50 y4 = ~(x1 & x5);
endmodule

//______________________________________________________________________________
//
module t391
(
	input		x1,
	input		x2,
	output	y3,
	output	y4,
	input		x5,
	input		x6,
	output	y9,
	input		x10
);

assign #6.50 y9 = ~(x6 & x10);
assign #6.50 y4 = ~(x1 & x5);
assign #3.75 y3 = ~x2;
endmodule

//______________________________________________________________________________
//
module t392
(
	input		x1,
	input		x3,
	output	y4,
	input		x5
);

assign #7.00 y4 = ~(x3 | (x1 & x5));
endmodule

//______________________________________________________________________________
//
module t393
(
	input		x1,
	input		x3,
	output	y4,
	input		x5,
	input		x6,
	output	y9
);

assign #3.75 y9 = ~x6;
assign #7.00 y4 = ~(x3 | (x1 & x5));
endmodule

//______________________________________________________________________________
//
module t394
(
	input		x1,
	output	y2,
	input		x3,
	output	y4,
	input		x5,
	input		x6,
	output	y9,
	input		x10
);

assign #3.75 y9 = ~x6;
assign #3.75 y2 = ~x10;
assign #7.00 y4 = ~(x3 | (x1 & x5));
endmodule

//______________________________________________________________________________
//
module t395
(
	input		x1,
	output	y2,
	input		x3,
	input		x4,
	input		x5,
	input		x6,
	output	y8
);

assign #4.50 y2 = ~(x1 | x4);
assign #7.00 y8 = ~(x3 | (x5 & x6));
endmodule


//______________________________________________________________________________
//
module t398
(
	input		x1,
	output	y2,
	input		x4,
	input		x5,
	input		x6,
	output	y9,
	input		x10
);

assign #4.50 y9 = ~(x6 & x10);
assign #7.00 y2 = ~(x4 | (x1 & x5));
endmodule

//______________________________________________________________________________
//
module t399
(
	input		r1,
	input		x2,
	output	q3,
	output	q4,
	input		s6,
	output	y7
);

assign   #4.50 q3 = ~(r1 | q4);
assign   #4.50 q4 = ~(s6 | q3);
assign	#3.75  y7 = ~x2;
endmodule

//______________________________________________________________________________
//
module t402
(
	input		r1,
	output	q3,
	output	q4,
	input		s6
);

assign   #4.50 q3 = ~(r1 | q4);
assign   #4.50 q4 = ~(s6 | q3);
endmodule

//______________________________________________________________________________
//
module t403
(
	input		x1,
	input		x2,
	input		x3,
	output	y4,
	input		x5,
	input		x6,
	output	y7,
	input		x8,
	output	y9,
	input		x10
);

assign #7.00 y4 = ~(x3 | (x1 & x5));
assign #7.00 y9 = ~(x8 | (x6 & x10));
assign #3.75 y7 = ~x2;
endmodule


//______________________________________________________________________________
//
module t404
(
	input		c1,
	output	q3,
	output	q4,
	input		r5,
	input		s10
);

assign   #7.00 q3 = ~((r5  & c1) | q4);
assign   #7.00 q4 = ~((s10 & c1) | q3);
endmodule

//______________________________________________________________________________
//
module t405
(
	input		c1,
	input		x2,
	output	q3,
	output	q4,
	input		r5,
	output	y7,
	input		s10
);

assign 	#3.75 y7 =~x2;
assign   #7.00 q3 = ~((r5  & c1) | q4);
assign   #7.00 q4 = ~((s10 & c1) | q3);
endmodule

//______________________________________________________________________________
//
module t406
(
	input		c1,
	input		r2,
	output 	q3,
	output 	q4,
	input		r5,
	input		s10
);

assign   #6.50 q3 = ~((r5  & c1) | q4 | r2);
assign   #7.00 q4 = ~((s10 & c1) | q3);
endmodule

//______________________________________________________________________________
//
module t408
(
	output	q2,
	output	q3,
	input		r5,
	input		s10
);

assign   #6.50 q2 = ~(q3 & s10);
assign   #6.50 q3 = ~(q2 & r5);
endmodule

//______________________________________________________________________________
//
module t411
(
	output	q1,
	output	q4,
	input		r5,
	input		r3,
	input		s10
);

assign   #6.50 q1 = ~((q4 & s10) | r3);
assign   #6.50 q4 = ~(q1 & r5);
endmodule


//______________________________________________________________________________
//
module t413
(
	output	q1,
	input		r3,
	output	q4,
	input		r5,
	input		x7,
	output	y8,
	input		s10
);

assign   #7.00 q1 = ~(r3 | (q4 & s10));
assign   #6.50 q4 = ~(q1 & r5);
assign   #3.75 y8 = ~x7;
endmodule

//______________________________________________________________________________
//
module t414
(
	output	q1,
	input		s4,
	input		r5,
	output	q6,
	input		r9,
	input		s10
);

assign   #7.00 q1 = ~(r9 | (q6 & s10));
assign   #7.00 q6 = ~(s4 | (q1 & r5));
endmodule

//______________________________________________________________________________
//
module t416
(
	input		c1,
	input		d5,
	output	q3,
	output	q4
);

wire s;
wire r;

assign 	#0.00	s =  d5 & c1;
assign 	#3.75	r = ~d5 & c1;

assign   #6.50 q4 = ~(r | q3);
assign   #6.50 q3 = ~(s | q4);
endmodule

//______________________________________________________________________________
//
module t417
(
	input		x1,
	output	y4,
	input		x5,
	input		x6,
	input		x10
);

assign	#8.25 y4 = ~((x1 & x5) | (x6 & x10));
endmodule

//______________________________________________________________________________
//
module t418
(
	input		x1,
	input		x2,
	output	y3,
	output	y4,
	input		x5,
	input		x6,
	input		x10
);

assign 	#3.75	y3 = ~x2;
assign	#8.25 y4 = ~((x1 & x5) | (x6 & x10));
endmodule

//______________________________________________________________________________
//
module t419
(
	input		x1,
	output	y2,
	input		x4,
	input		x5,
	input		x6,
	input		x10
);

assign	#9.00 y2 = ~((x1 & x5) | (x6 & x10) | x4);
endmodule

//______________________________________________________________________________
//
module t420
(
	input		x1,
	output	y2,
	output	y3,
	input		x4,
	input		x5,
	input		x6,
	input		x7,
	input		x10
);

assign 	#3.75	y3 = ~x7;
assign	#9.00 y2 = ~((x1 & x5) | (x6 & x10) | x4);
endmodule

//______________________________________________________________________________
//
module t421
(
	input		x1,
	output	y2,
	input		x3,
	input		x4,
	input		x5,
	input		x6,
	input		x10
);

assign	#9.00 y2 = ~((x1 & x5) | (x6 & x10) | x3 | x4);
endmodule

//______________________________________________________________________________
//
module t423
(
	input		x1,
	output	y2,
	input		x4,
	input		x5,
	input		x6
);

assign	#9.00 y2 = ~((x1 & x5) | x4 | x6);
endmodule


//______________________________________________________________________________
//
module t428
(
	input		x2,
	output	y3
);

assign	#3.00 y3 = x2;
endmodule

//______________________________________________________________________________
//
module t429
(
	input		x5,
	output	y3
);

assign	#4.00 y3 = ~x5;
endmodule
