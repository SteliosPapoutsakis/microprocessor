module mux16to1(out,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,select);
parameter size = 32;

output [size-1:0] out;
input [size-1:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
input [3:0] select;

genvar i;
generate for(i=0;i<size;i=i+1) begin: mux_loop
//first set in mux
wire [13:0] inter;
bufif0(inter[0],a0[i],select[0]);
bufif1(inter[0],a1[i],select[0]);
bufif0(inter[1],a2[i],select[0]);
bufif1(inter[1],a3[i],select[0]);
bufif0(inter[2],a4[i],select[0]);
bufif1(inter[2],a5[i],select[0]);
bufif0(inter[3],a6[i],select[0]);
bufif1(inter[3],a7[i],select[0]);
bufif0(inter[4],a8[i],select[0]);
bufif1(inter[4],a9[i],select[0]);
bufif0(inter[5],a10[i],select[0]);
bufif1(inter[5],a11[i],select[0]);
bufif0(inter[6],a12[i],select[0]);
bufif1(inter[6],a13[i],select[0]);
bufif0(inter[7],a14[i],select[0]);
bufif1(inter[7],a15[i],select[0]);

//second round
bufif0(inter[8],inter[0],select[1]);
bufif1(inter[8],inter[1],select[1]);
bufif0(inter[9],inter[2],select[1]);
bufif1(inter[9],inter[3],select[1]);
bufif0(inter[10],inter[4],select[1]);
bufif1(inter[10],inter[5],select[1]);
bufif0(inter[11],inter[6],select[1]);
bufif1(inter[11],inter[7],select[1]);

//third round
bufif0(inter[12],inter[8],select[2]);
bufif1(inter[12],inter[9],select[2]);
bufif0(inter[13],inter[10],select[2]);
bufif1(inter[13],inter[11],select[2]);

//last round
bufif0(out[i],inter[12],select[3]);
bufif1(out[i],inter[13],select[3]);
 end
endgenerate





endmodule
