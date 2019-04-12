`timescale 1ns / 1ns

module CON_test();

reg clk,reset;
wire RW,Valid,fetch;
wire [4:0] Rc,Rb,Ra;
wire [5:0] opcode;
wire [31:0] Data;
wire [31:0] Data_in;
reg [7:0] Addr_in;
wire [7:0] Addr;
wire [31:0] literal;
wire ready,wrEn,rdEn;

Control  C(literal,Valid,Rb,Ra,Rc,opcode,fetch,RW,ready,Data_in,clk,reset);
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
