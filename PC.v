module PC(out,reset,in,increment,En);

output reg [31:0] out;
input [31:0] in;
input reset,increment,En;




always @(posedge reset or posedge increment or posedge En) begin
// the instructions start at 0x64 in our micro controller
  if(reset) out<=32'h190;
  else if(En) out<=in;
  else out <= out + {28'b0,4'b0100};
  end


endmodule
