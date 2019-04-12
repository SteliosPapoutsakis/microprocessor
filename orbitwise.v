module orbitwise(out,A,B);
parameter width = 32;
input [width-1:0] A,B;
output [width-1:0] out;

genvar i;

generate for(i=0;i<width;i=i+1) begin: and_loop
  or g1(out[i],A[i],B[i]);
  end
endgenerate

endmodule
