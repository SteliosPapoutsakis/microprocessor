module Multiply(Prod,A,B);

parameter size = 32;
input [size-1:0] A,B;
output reg [size-1:0] Prod;

always @(*)
Prod <= A*B;

endmodule 