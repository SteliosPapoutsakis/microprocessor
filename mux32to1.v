module mux32to1 (out,regs,select,enable);
parameter SIZE = 32;
parameter numReg = 32;
parameter selectSIZE = $clog2(32);

input [SIZE-1:0] regs [numReg-1:0];
input [selectSIZE-1:0] select;
output [SIZE-1:0] out;
wire [SIZE-1/2:0] out0,out1;

mux1to16 mux0(out0,regs[0],regs[1],regs[2],regs[3],regs[4],regs[5],regs[6],regs[7],regs[8],regs[9],regs[10],regs[11],regs[12],regs[13],regs[14],regs[15],select[selectSIZE-2:0]);
mux1to16 mux1(out0,regs[16],regs[17],regs[18],regs[19],regs[20],regs[21],regs[22],regs[23],regs[24],regs[25],regs[26],regs[27],regs[28],regs[29],regs[30],regs[31],select[selectSIZE-2:0]);






endmodule //
