//this is a data flow path for the micro processor

module Data_path(Address,data,Valid,regEn,oppB,oppA,opcode,literal,
  increment,reset,Branch_En,fetch,DataBus_En,store_en,Datareg_wr_En,Addreg_wr_En,store_PC,literalEn,PC_wr_En);
parameter WIDTH = 32;
parameter AWIDTH = 32;

inout tri [AWIDTH-1:0] Address;
inout tri [WIDTH-1:0] data;

input Valid,regEn,increment,Branch_En,fetch,DataBus_En,store_en,reset,Datareg_wr_En,Addreg_wr_En,store_PC,literalEn,PC_wr_En;

input [4:0] oppA,oppB;
input [WIDTH-1:0] literal;
input [5:0] opcode;

tri [WIDTH-1:0] ALU1_In,AddR_in,regorPC_in,ALU2_in,data_in;

wire [WIDTH-1:0] interconect[3:0];
wire [WIDTH-1:0] out,dataR_out;
wire NEG;

//creating the reg file
reg_file regg(interconect[0],interconect[1],regorPC_in,oppA,oppB,regEn);
ALU alu(interconect[2], ALU1_In,ALU2_in, (opcode[5:4]==2'b01)?{3'b000,NEG}:opcode[3:0]);
PC pc(out,reset,regorPC_in,increment,PC_wr_En);
register dataR(dataR_out,data_in,Datareg_wr_En);
register AddR(Address,AddR_in,Addreg_wr_En);
twoComp comp(interconect[3],NEG,literal);


//assigning all the tri variables
assign ALU1_In = (Branch_En)? out:interconect[0];
assign ALU2_in = (literalEn)?interconect[3]:interconect[1];
assign AddR_in = (fetch)? out:interconect[2];
assign data_in = (store_en)?data:interconect[2];
assign data = (DataBus_En)? dataR_out:32'bzz;
assign regorPC_in = (store_PC)? out:dataR_out;









endmodule //
