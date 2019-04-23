`timescale 1ns / 1ns
module Ram(Data,Addr,rdEn,wrEn,clk);
// MODULE Ram
//BY Stelios and Jessie
//
parameter DWIDTH = 32;
//2^32 memory locations
parameter ADepth = 1000;
parameter Delay=40;


parameter AWIDTH = $clog2(ADepth);

input rdEn,wrEn,clk;
input [AWIDTH-1:0] Addr;
inout tri [DWIDTH-1:0] Data;
reg [DWIDTH-1:0] Meme [ADepth-1:0];

initial begin
  Meme[100] = 32'b01100010000000000000000000001000;
  Meme[101] = 32'b11000000100000000000000110000011;
  Meme[102] = 32'b10000110100001001000000000000000;
  Meme[103] = 32'b01100110000100000000000000000111;
  Meme[2] = 32'h000034;
end

always @ (posedge clk) begin
if(rdEn)
 Meme[Addr] = Data;
end
assign  #(Delay) Data = (rdEn)? 32'bzz : Meme[Addr];
endmodule
