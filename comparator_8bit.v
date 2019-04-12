module comparator_8bit (EQ, LT, GT, A, B);

input [7:0] A, B;
output EQ, LT, GT;
wire [7:0] EQ_wire, LT_wire, GT_wire;

comparator_1bit comp1(EQ_wire[7], LT_wire[7], GT_wire[7], A[7], B[7], 1'b1);
comparator_1bit comp2(EQ_wire[6], LT_wire[6], GT_wire[6], A[6], B[6], EQ_wire[7]);
comparator_1bit comp3(EQ_wire[5], LT_wire[5], GT_wire[5], A[5], B[5], EQ_wire[6]);
comparator_1bit comp4(EQ_wire[4], LT_wire[4], GT_wire[4], A[4], B[4], EQ_wire[5]);
comparator_1bit comp5(EQ_wire[3], LT_wire[3], GT_wire[3], A[3], B[3], EQ_wire[4]);
comparator_1bit comp6(EQ_wire[2], LT_wire[2], GT_wire[2], A[2], B[2], EQ_wire[3]);
comparator_1bit comp7(EQ_wire[1], LT_wire[1], GT_wire[1], A[1], B[1], EQ_wire[2]);
comparator_1bit comp8(EQ_wire[0], LT_wire[0], GT_wire[0], A[0], B[0], EQ_wire[1]);

or (GT,GT_wire[7],GT_wire[6],GT_wire[5],GT_wire[4],GT_wire[3],GT_wire[2],GT_wire[1],GT_wire[0]);
or (LT,LT_wire[7],LT_wire[6],LT_wire[5],LT_wire[4],LT_wire[3],LT_wire[2],LT_wire[1],LT_wire[0]);

assign EQ = EQ_wire[0];

endmodule 