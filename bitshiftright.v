module bitshiftright(out,A,B);
parameter width =32;


output [width-1:0] out;
input [width-1:0] A,B;

assign out = A >> B;

endmodule
