module comparator_32bit (EQ, LT, GT, A, B);
input [31:0] A,B;
wire [3:0] eqs,gts,lts;
wire [5:0] interconnect;
output [31:0] EQ,LT,GT;
wire EQtemp,LTtemp,GTtemp;

comparator_8bit c0(eqs[3],lts[3],gts[3],A[31:24],B[31:24]);
comparator_8bit c1(eqs[2],lts[2],gts[2],A[23:16],B[23:16]);
comparator_8bit c2(eqs[1],lts[1],gts[1],A[15:8],B[15:8]);
comparator_8bit c3 (eqs[0],lts[0],gts[0],A[7:0],B[7:0]);

and(EQtemp,eqs[3],eqs[2],eqs[1],eqs[0]);


//getting greater than
and(interconnect[0],gts[2],eqs[3]);
and(interconnect[1],gts[1],eqs[3],eqs[2]);
and(interconnect[2],gts[0],eqs[3],eqs[2],eqs[1]);
or(GTtemp,gts[3],interconnect[2],interconnect[0],interconnect[1]);

//getting less than
and(interconnect[3],lts[2],eqs[3]);
and(interconnect[4],lts[1],eqs[3],eqs[2]);
and(interconnect[5],lts[0],eqs[3],eqs[2],eqs[1]);
or(LTtemp,lts[3],interconnect[3],interconnect[4],interconnect[5]);

//fixing the issue that the output has to be 32 bit
assign GT = {31'b0,GTtemp};
assign LT = {31'b0,LTtemp};
assign EQ = {31'b0,EQtemp};
endmodule 
