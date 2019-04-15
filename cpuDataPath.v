//this is a data flow path for the micro processor

module Data_path(Address,data,Valid,regEn,oppB,oppA,opcode,literal,DataCon,AddCon,increment,reset);
parameter WIDTH = 32;
parameter AWIDTH = 8;

inout tri [AWIDTH-1:0] Address;
inout tri [WIDTH-1:0] data;

input Valid,regEn,increment,DataCon,AddCon,reset;

input [4:0] oppA,oppB;
input [WIDTH-1:0] literal;
input [5:0] opcode;

tri [WIDTH-1:0] ALUIn1;

wire [WIDTH-1:0] interconect[2:0];
wire [WIDTH-1:0] out;

//creating the reg file
reg_file regg(interconect[0],interconect[1],data,oppA,oppB,regEn);
ALU alu(interconect[2], interconect[0],ALUIn1, (opcode[5:4]==2'b01)?4'b0000:opcode[3:0]);
PC pc(out,reset,increment);

//assigning all the tri variables
assign data = (DataCon && !AddCon)?interconect[2]:32'bzz;
assign data = (DataCon && AddCon)?oppB:32'bzz;
assign ALUIn1 = (opcode[4])? literal:interconect[1];
assign Address = (AddCon)? interconect[2]:out;






endmodule //
