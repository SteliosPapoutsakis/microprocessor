module sub32bit(out,Bout,A,B,Bin);
parameter Width = 32;
output [Width-1:0] out;
output Bout;
input Bin;
input [Width-1:0] A,B;
wire interconnect [30:0];

//groups of 8 subtractors
carrylookaheadsub sub0(out[Width-32],interconnect[0],A[Width-32],B[Width-32],Bin);
carrylookaheadsub sub1(out[Width-31],interconnect[1],A[Width-31],B[Width-31],interconnect[0]);
carrylookaheadsub sub2(out[Width-30],interconnect[2],A[Width-30],B[Width-30],interconnect[1]);
carrylookaheadsub sub3(out[Width-29],interconnect[3],A[Width-29],B[Width-29],interconnect[2]);
carrylookaheadsub sub4(out[Width-28],interconnect[4],A[Width-28],B[Width-28],interconnect[3]);
carrylookaheadsub sub5(out[Width-27],interconnect[5],A[Width-27],B[Width-27],interconnect[4]);
carrylookaheadsub sub6(out[Width-26],interconnect[6],A[Width-26],B[Width-26],interconnect[5]);
carrylookaheadsub sub7(out[Width-25],interconnect[7],A[Width-25],B[Width-25],interconnect[6]);



carrylookaheadsub sub8(out[Width-24],interconnect[8],A[Width-24],B[Width-24],interconnect[7]);
carrylookaheadsub sub9(out[Width-23],interconnect[9],A[Width-23],B[Width-23],interconnect[8]);
carrylookaheadsub sub10(out[Width-22],interconnect[10],A[Width-22],B[Width-22],interconnect[9]);
carrylookaheadsub sub11(out[Width-21],interconnect[11],A[Width-21],B[Width-21],interconnect[10]);
carrylookaheadsub sub12(out[Width-20],interconnect[12],A[Width-20],B[Width-20],interconnect[11]);
carrylookaheadsub sub13(out[Width-19],interconnect[13],A[Width-19],B[Width-19],interconnect[12]);
carrylookaheadsub sub14(out[Width-18],interconnect[14],A[Width-18],B[Width-18],interconnect[13]);
carrylookaheadsub sub15(out[Width-17],interconnect[15],A[Width-17],B[Width-17],interconnect[14]);



carrylookaheadsub sub16(out[Width-16],interconnect[16],A[Width-16],B[Width-16],interconnect[15]);
carrylookaheadsub sub17(out[Width-15],interconnect[17],A[Width-15],B[Width-15],interconnect[16]);
carrylookaheadsub sub18(out[Width-14],interconnect[18],A[Width-14],B[Width-14],interconnect[17]);
carrylookaheadsub sub19(out[Width-13],interconnect[19],A[Width-13],B[Width-13],interconnect[18]);
carrylookaheadsub sub20(out[Width-12],interconnect[20],A[Width-12],B[Width-12],interconnect[19]);
carrylookaheadsub sub21(out[Width-11],interconnect[21],A[Width-11],B[Width-11],interconnect[20]);
carrylookaheadsub sub22(out[Width-10],interconnect[22],A[Width-10],B[Width-10],interconnect[21]);
carrylookaheadsub sub23(out[Width-9],interconnect[23],A[Width-9],B[Width-9],interconnect[22]);


carrylookaheadsub sub24(out[Width-8],interconnect[24],A[Width-8],B[Width-8],interconnect[23]);
carrylookaheadsub sub25(out[Width-7],interconnect[25],A[Width-7],B[Width-7],interconnect[24]);
carrylookaheadsub sub26(out[Width-6],interconnect[26],A[Width-6],B[Width-6],interconnect[25]);
carrylookaheadsub sub27(out[Width-5],interconnect[27],A[Width-5],B[Width-5],interconnect[26]);
carrylookaheadsub sub28(out[Width-4],interconnect[28],A[Width-4],B[Width-4],interconnect[27]);
carrylookaheadsub sub29(out[Width-3],interconnect[29],A[Width-3],B[Width-3],interconnect[28]);
carrylookaheadsub sub30(out[Width-2],interconnect[30],A[Width-2],B[Width-2],interconnect[29]);
carrylookaheadsub sub31(out[Width-1],Bout,A[Width-1],B[Width-1],interconnect[30]);


endmodule
