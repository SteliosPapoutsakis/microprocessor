module buff32(out,in,select);
parameter SIZE = 32;
output [SIZE-1:0] out;
input [SIZE-1:0] in;
genvar i;
generate for(i=0;i<SIZE;i=i+1) begin
bufif1(out[i],in[i],select);
end
endgenerate
endmodule 
