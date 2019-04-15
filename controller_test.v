`timescale 1ns / 1ns

module CON_test();

reg clk,reset;
wire RW,Valid,fetch;
wire [4:0] oppA,oppB;
wire [5:0] opcode;
wire [31:0] Data;
wire [31:0] Data_in;
reg [7:0] Addr_in;
wire [7:0] Addr;
wire [31:0] literal;
wire ready,wrEn,rdEn,datarn,addrn,increment;

Control control(datarn,addrn,increment,literal,Valid,regEn,oppB,oppA,opcode,fetch,RW,ready,Data,clk,reset);
MemController con(Data_in,Data,ready,Addr,wrEn,rdEn,Valid,RW,Addr_in,reset,clk);
Ram ram1(Data, Addr, rdEn, wrEn, clk);


initial
 begin

   clk = 0;
   forever #10 clk = !clk;
end

initial
begin
reset=1;
#5 reset =0;
#5 Addr_in = 32'hFA;

end
endmodule
