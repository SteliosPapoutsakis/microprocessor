`timescale 1ns / 1ns

module ALU_test;

reg [31:0] data0,data1;
wire [31:0] out;
reg [3:0] opcode;

ALU opp(out, data0, data1, opcode);

initial
  begin
   #20 opcode = 4'b0000; data0= 32'd35; data1=32'd12;
   #20 opcode = 4'b0001; data0= 32'd50; data1=32'd10;
   #20 opcode = 4'b0010; data0= 32'd30; data1=32'd20;
   #20 opcode = 4'b0011; data0= 32'd5; data1=32'd5;
   #20 opcode = 4'b0100; data0= 32'd12; data1=32'd40;
   #20 opcode = 4'b0101; data0= 32'd10; data1=32'd21;
   #20 opcode = 4'b0110; data0= 32'd2; data1=32'd4;
   #20 opcode = 4'b1000; data0= 32'd34; data1=32'd17;
   #20 opcode = 4'b1001; data0= 32'd1; data1=32'd5;
   #20 opcode = 4'b1010; data0= 32'd20; data1=32'd10;
   #20 opcode = 4'b1011; data0= 32'd13; data1=32'd3;
   #20 opcode = 4'b1100; data0= 32'd15; data1=32'd3;
   #20 opcode = 4'b1101; data0= 32'd23; data1=32'd2;
   #20 opcode = 4'b1110; data0= 32'd35; data1=32'd4;
  end

initial
   begin
    $display("     time data0  data1  opcode out "); 
    $monitor($stime,, data0,,, data1,,,,,, opcode,,,,,, out); 
   end

endmodule  