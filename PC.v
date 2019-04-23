module PC(out,reset,increment);

output reg [31:0] out;
//input [31:0] in;
input reset,increment;



always @(posedge reset or posedge increment) begin
// the instructions start at 0x64 in our micro controller
  if(reset) out<=32'h190;
  else out <= out + {28'b0,4'b0100};
  end


endmodule
