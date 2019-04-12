module carry_look_ahead_adder(sum, C_out, A, B, C_in);

input A, B, C_in;
output sum, C_out;
wire P, G;
wire P_and_Cin;

xor (P, A, B);
and (G, A, B);
xor (sum, P, C_in);
and (P_and_Cin, P, C_in);
or (C_out, G, P_and_Cin);

endmodule 