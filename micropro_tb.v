`timescale 1ns / 1ns

module MicroProcessor_test();

reg clk,reset;
wire Valid,regEn;
wire [4:0] oppA,oppB;
wire [5:0] opcode;
wire [31:0] Data_RAM;
wire [31:0] Data_CPU;
wire [31:0] Addr_CPU;
wire [31:0] Addr_RAM;
wire [31:0] literal;
wire ready,wrEn,rdEn,increment,Branch_En,fetch,DataBus_En,store_databusvalue,literalEn,store_PC,Datawr_En,Addwr_En;

Control control(fetch,store_PC,Datawr_En,Addwr_En,regEn,PCEn,DataBus_En,store_databusvalue,Branch_En,
	increment,literal,Valid,oppB,oppA,opcode,literalEn,RW,ready,Data_CPU,clk,reset);
Data_path data(Addr_CPU,Data_CPU,Valid,regEn,oppB,oppA,opcode,literal,increment,reset,Branch_En,
	fetch,DataBus_En,store_databusvalue,Datawr_En,Addwr_En,store_PC,literalEn,PCEn);
MemController con(Data_CPU,Data_RAM,ready,Addr_RAM,wrEn,rdEn,Valid,RW,Addr_CPU,reset,clk);
Ram ram1(Data_RAM, Addr_RAM, rdEn, wrEn, clk);


initial
 begin

   clk = 0;
   forever #10 clk = !clk;
end

initial
begin
reset=0;
#5 reset =1;
#7 reset=0;


end
endmodule
