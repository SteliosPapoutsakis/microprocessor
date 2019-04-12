module carrylookaheadsub(out,Bout,A,B,Bin);
output out,Bout;
input A,B,Bin;
wire Gen_Del,P,Gen_Del_and_B,P_and_Bin,Gen_del_and_Bin_not,Bin_not;

//gates to find delete and generate, and propagate
xnor(P,A,B);
xor(Gen_Del,A,B);

//implementing functions
not(Bin_not,Bin);
and(Gen_Del_and_B,Gen_Del,B);
and(P_and_Bin,P,Bin);
and(Gen_del_and_Bin_not,Gen_Del,Bin_not);
or(Bout,Gen_Del_and_B,P_and_Bin);
or(out,Gen_del_and_Bin_not,P_and_Bin);

endmodule 

