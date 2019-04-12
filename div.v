module Div(Quod,A,B);

parameter size = 32;
input [size-1:0] A,B;
output reg [size-1:0] Quod;

always @(*)
Quod <= A/B;

endmodule 