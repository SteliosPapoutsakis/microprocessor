module PC(out,in,reset);

output reg [31:0] out;
input [31:0] in;
input reset;



always @(posedge clk or posedge reset)
// the instructions start at 0x96 in our micro controller
  if(reset) out=32'h96;
	else	out <= in;
	end

endmodule
