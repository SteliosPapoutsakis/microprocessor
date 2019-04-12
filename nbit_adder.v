module nbit_adder(sum, C_out, A, B, C_in);

input [31:0] A, B;
input C_in;
output C_out;
wire C_out_in [31:0];
output [31:0] sum;

carry_look_ahead_adder adder0(sum[0], C_out_in[0], A[0], B[0], C_in);
carry_look_ahead_adder adder1(sum[1], C_out_in[1], A[1], B[1], C_out_in[0]);
carry_look_ahead_adder adder2(sum[2], C_out_in[2], A[2], B[2], C_out_in[1]);
carry_look_ahead_adder adder3(sum[3], C_out_in[3], A[3], B[3], C_out_in[2]);
carry_look_ahead_adder adder4(sum[4], C_out_in[4], A[4], B[4], C_out_in[3]);
carry_look_ahead_adder adder5(sum[5], C_out_in[5], A[5], B[5], C_out_in[4]);
carry_look_ahead_adder adder6(sum[6], C_out_in[6], A[6], B[6], C_out_in[5]);
carry_look_ahead_adder adder7(sum[7], C_out_in[7], A[7], B[7], C_out_in[6]);
carry_look_ahead_adder adder8(sum[8], C_out_in[8], A[8], B[8], C_out_in[7]);
carry_look_ahead_adder adder9(sum[9], C_out_in[9], A[9], B[9], C_out_in[8]);
carry_look_ahead_adder adder10(sum[10], C_out_in[10], A[10], B[10], C_out_in[9]);
carry_look_ahead_adder adder11(sum[11], C_out_in[11], A[11], B[11], C_out_in[10]);
carry_look_ahead_adder adder12(sum[12], C_out_in[12], A[12], B[12], C_out_in[11]);
carry_look_ahead_adder adder13(sum[13], C_out_in[13], A[13], B[13], C_out_in[12]);
carry_look_ahead_adder adder14(sum[14], C_out_in[14], A[14], B[14], C_out_in[13]);
carry_look_ahead_adder adder15(sum[15], C_out_in[15], A[15], B[15], C_out_in[14]);
carry_look_ahead_adder adder16(sum[16], C_out_in[16], A[16], B[16], C_out_in[15]);
carry_look_ahead_adder adder17(sum[17], C_out_in[17], A[17], B[17], C_out_in[16]);
carry_look_ahead_adder adder18(sum[18], C_out_in[18], A[18], B[18], C_out_in[17]);
carry_look_ahead_adder adder19(sum[19], C_out_in[19], A[19], B[19], C_out_in[18]);
carry_look_ahead_adder adder20(sum[20], C_out_in[20], A[20], B[20], C_out_in[19]);
carry_look_ahead_adder adder21(sum[21], C_out_in[21], A[21], B[21], C_out_in[20]);
carry_look_ahead_adder adder22(sum[22], C_out_in[22], A[22], B[22], C_out_in[21]);
carry_look_ahead_adder adder23(sum[23], C_out_in[23], A[23], B[23], C_out_in[22]);
carry_look_ahead_adder adder24(sum[24], C_out_in[24], A[24], B[24], C_out_in[23]);
carry_look_ahead_adder adder25(sum[25], C_out_in[25], A[25], B[25], C_out_in[24]);
carry_look_ahead_adder adder26(sum[26], C_out_in[26], A[26], B[26], C_out_in[25]);
carry_look_ahead_adder adder27(sum[27], C_out_in[27], A[27], B[27], C_out_in[26]);
carry_look_ahead_adder adder28(sum[28], C_out_in[28], A[28], B[28], C_out_in[27]);
carry_look_ahead_adder adder29(sum[29], C_out_in[29], A[29], B[29], C_out_in[28]);
carry_look_ahead_adder adder30(sum[30], C_out_in[30], A[30], B[30], C_out_in[29]);
carry_look_ahead_adder adder31(sum[31], C_out, A[31], B[31], C_out_in[30]);

endmodule 
