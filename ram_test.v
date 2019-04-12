`timescale 1ns / 1ns

module RAM_test();

reg clk,rdEn,wrEn;
reg [7:0] Addr;
tri [31:0] Data;
reg [31:0] InData;

MemController con()
Ram ram1(Data, Addr, rdEn, wrEn, clk);

assign Data = (wrEn)? 32'bzz : InData;

initial
 begin
   clk = 0;
   forever #10 clk = !clk;
end

initial
begin
rdEn = 1; InData = 32'hDDAA; wrEn =0; Addr = 8'hAA;
#80 rdEn = 1; InData = 32'hFFFF; wrEn =0; Addr = 8'h00;
#80 rdEn = 0; wrEn = 1; Addr = 8'hAA;
end
endmodule
