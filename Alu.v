//ALU module for beta proccessor

module Alu (output [31:0] out,input [31:0] data0,input [31:0] data1, input oppcode);

wire [31:0] interconnect [32:0];

//instas of all opperations
//add
nbit_adder add(interconnect[0],,data0,data1,1'b0);
//sub
sub32bit sub(interconnect[1],,data0,data1,1'b0);
//comparator
comparator_32bit com(interconnect[2],interconnect[3],interconnect[4],data0,data1);


//xor bitwise
xorBitwise opp(interconnect[5],data0,data1);

//xnor bitwise

xnorBitwise opp(interconnect[6],data0,data1);


//and bitwise

andbitwise opp2(interconnect[7],data0,data1);




endmodule / Alu
