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

tri [WIDTH-1:0] ALU1_In,AddR_in,regorPC_in,PC_in,ALU2_in;

wire [WIDTH-1:0] interconect[2:0];
wire [WIDTH-1:0] out,dataR_out;

//creating the reg file
reg_file regg(interconect[0],interconect[1],data,oppA,oppB,regEn);
ALU alu(interconect[2], ALU1_In,ALU2_in, (opcode[5:4]==2'b01)?4'b0000:opcode[3:0]);
PC pc(out,reset,increment);
register dataR(dataR_out,interconect[2],wrData);
register AddR(Address,AddR_in,wrAdd);

//assigning all the tri variables
assign ALU1_In = (Branch_En)? out:interconect[0];
assign ALU2_in = (opcode[4] == 1'b1)?literal:interconect[1];
assign AddR_in = (fetch)? out:interconect[2];
assign data = (DataBus_En)? dataR_out:32'bzz;
assign regorPC_in = (store_en)?(data:dataR_out);








endmodule //
