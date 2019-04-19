module register(out,data,wr);
paramter size = 32;
input [size-1:0] data;
input wr;
output [size-1:0] out;

always @ ( * ) begin
if(wr) out <= data;
end
endmodule
