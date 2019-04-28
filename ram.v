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
  Meme[101] = 32'b01111111000000000000000000000011;
  // Meme[101] = 32'b11000110000100000000000000000001;
  // // Meme[101] = 32'b11000000100000000000000110000011;
  // // Meme[102] = 32'b10000110100001001000000000000000;
  // // Meme[103] = 32'b01100110000100000000000000000111;
  // Meme[102] = 32'b01110100100100001111111111111110;
   Meme[2] = 32'h000005;
   Meme[105] = 32'hFFFFF;

  //FIBONICCA S_Decode
  // Meme[100] = 32'b11000000000000000000000000000001;//ADDc R0 + constant 1
  // Meme[101] = 32'b11000000010000100000000000000111;// A == 7
  // Meme[102] = 32'b01110010000000100000000000000100;// BEQ if A is already 0
  // Meme[103] = 32'b10000000001000010000000000000000;// adding R0 + R1
  // Meme[104] = 32'b10000100000000010000000000000000; //R1-R0 to get orginatl R1
  // Meme[105] = 32'b11000100010000100000000000000001;// A= A-1
  // Meme[106] = 32'b01110110000000101111111111111100; // BNE if not zero do this again
  // Meme[107] = 32'b01100100001111110000000000010000; //storing R1 in ram in location

end

always @ (posedge clk) begin
if(rdEn)
 Meme[Addr] = Data;
end
assign  #(Delay) Data = (rdEn)? 32'bzz : Meme[Addr];
endmodule
