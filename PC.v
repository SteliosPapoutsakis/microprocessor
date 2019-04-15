module PC(out,reset,increment);

output reg [31:0] out;
//input [31:0] in;
input reset,increment;



always @(reset or posedge increment) begin
// the instructions start at 0x64 in our micro controller
  if(reset) out<=32'h64;
  else out <= out + {31'b0,1'b1};
  end


endmodule
