`timescale 1ns / 1ns
module Ram(Data,Addr,rdEn,wrEn,clk);
// MODULE Ram
//BY Stelios and Jessie
//
parameter DWIDTH = 32;
parameter ADepth = 256;
parameter Delay=40;


parameter AWIDTH = $clog2(ADepth);

input rdEn,wrEn,clk;
input [AWIDTH-1:0] Addr;
inout tri [DWIDTH-1:0] Data;
reg [DWIDTH-1:0] Meme [ADepth-1:0];

initial begin
  Meme[250] = 32'b01100000000110001111111111110001;
end

always @ (posedge clk) begin
if(rdEn)
 Meme[Addr] = Data;
end
assign  #(Delay) Data = (rdEn)? 32'bzz : Meme[Addr];
endmodule
