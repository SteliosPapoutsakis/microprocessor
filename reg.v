module register(out,data,wr);
parameter size = 32;
input [size-1:0] data;
input wr;
output reg [size-1:0] out;

initial begin
  out <= 32'b0;
end
always @ ( * ) begin
if(wr) out <= data;
end
endmodule
