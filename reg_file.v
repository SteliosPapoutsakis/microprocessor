

module reg_file(registers,data,select,en);

parameter width  = 32;
parameter numRegs = 32;
parameter abits = 5;
input en;
input [width-1:0] data;
input [abits-1:0] select;
output [width-1:0] registers [numReg-1:0];

always @(en or data)
begin
if(address<width-5 && en)
	registers[select] = data;
end


initial
registers[width-1] = 32'b0;


endmodule
