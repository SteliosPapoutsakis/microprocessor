

module reg_file(out0,out1,data,select0,select1,wr);

parameter width  = 32;
parameter numRegs = 32;
parameter abits = 5;


input wr;
input [width-1:0] data;
input [abits-1:0] select;
reg [width-1:0] registers [numReg-1:0];
output [width-1:0] out0,out1;


always @(wr or data)
begin
if(address<width-5 && en)
	registers[select0] = data;
end
assign out0 = registers[select0];
assign out1 = registers[select1];


initial
registers[width-1] = 32'b0;


endmodule
