`timescale 1ns / 1ns

module RAMCON_test();

reg clk,reset,RW,Valid;
wire [31:0] Data;
tri [31:0] Data_in;
reg [31:0] InData;
reg [7:0] Addr_in;
wire [7:0] Addr;
wire ready,wrEn,rdEn;

MemController con(Data_in,Data,ready,Addr,wrEn,rdEn,Valid,RW,Addr_in,reset,clk);
Ram ram1(Data, Addr, rdEn, wrEn, clk);

assign Data_in = (!RW && Valid)? InData:32'bzz;

initial
 begin
   clk = 0;
   forever #10 clk = !clk;
end

initial
begin
reset=1;
#10 Valid=1'b0;reset=0; 
#75 Addr_in = 8'hAA; InData = 32'hAFFFA; RW=1'b0; Valid=1'b1; 
#100 Valid=1'b0; 
#20  Addr_in = 8'hCC; InData = 32'h00CFA; RW=1'b0; Valid=1'b1; 
#100 Valid=1'b0; 
#20 Addr_in = 8'hAA;  RW=1'b1; Valid=1'b1; 
#100 Valid=1'b0; 
#20 Addr_in = 8'hCC; RW=1'b1; Valid=1'b1; 
#100 Valid=1'b0; 
end
endmodule
