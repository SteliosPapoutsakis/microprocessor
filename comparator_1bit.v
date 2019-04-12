module comparator_1bit (EQ, LT, GT, A, B, en);

input A, B, en;
wire A_not, B_not, EQ_en, LT_en, GT_en;
output EQ, LT, GT;

xnor (EQ_en, A, B);
not (A_not, A);
not (B_not, B);
and (LT_en, A_not, B);
and (GT_en, A, B_not);
and (EQ, en, EQ_en);
and (LT, en, LT_en);
and (GT, en, GT_en);


endmodule 