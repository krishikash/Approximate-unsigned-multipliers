`timescale 1ns/1ps
module approx_16x16(y, a, b);
input [15:0] a, b;
output reg [31:0] y;
wire [15:0] pp [15:0]; 

  
genvar i, j;
generate
  for (i = 0; i < 16; i = i + 1) begin : PARTIAL_PRODUCTS
    for (j = 0; j < 16; j = j + 1) begin : AND_GATES
      assign pp[i][j] = b[i] & a[j];
    end
  end
endgenerate

///stage 0
wire sum_stage1_col9_1, sum_stage1_col10_1, sum_stage1_col11_1, sum_stage1_col12_1, sum_stage1_col13_1, sum_stage1_col13_2, sum_stage1_col14_1, sum_stage1_col14_2, sum_stage1_col15_1, sum_stage1_col15_2, sum_stage1_col16_1, sum_stage1_col16_2, sum_stage1_col17_1, sum_stage1_col17_2, sum_stage1_col17_3, sum_stage1_col18_1, sum_stage1_col18_2, sum_stage1_col18_3, sum_stage1_col19_1, sum_stage1_col19_2, sum_stage1_col19_3, sum_stage1_col20_1, sum_stage1_col20_2, sum_stage1_col20_3, sum_stage1_col21_1, sum_stage1_col21_2, sum_stage1_col22_1, sum_stage1_col22_2, sum_stage1_col23_1,sum_stage1_col23_2, sum_stage1_col24_1, sum_stage1_col24_2, sum_stage1_col25_1,sum_stage1_col25_2, sum_stage1_col26_1, sum_stage1_col26_2;
wire carry_stage1_col9_1, carry_stage1_col10_1, carry_stage1_col11_1, carry_stage1_col12_1, carry_stage1_col13_1, carry_stage1_col13_2, carry_stage1_col14_1, carry_stage1_col14_2, carry_stage1_col15_1, carry_stage1_col15_2, carry_stage1_col16_1, carry_stage1_col16_2, carry_stage1_col17_1, carry_stage1_col17_2, carry_stage1_col17_3, carry_stage1_col18_1, carry_stage1_col18_2, carry_stage1_col18_3, carry_stage1_col19_1, carry_stage1_col19_2, carry_stage1_col19_3, carry_stage1_col20_1, carry_stage1_col20_2, carry_stage1_col20_3, carry_stage1_col21_1, carry_stage1_col21_2, carry_stage1_col22_1, carry_stage1_col22_2, carry_stage1_col23_1,carry_stage1_col23_2 ,carry_stage1_col24_1, carry_stage1_col24_2, carry_stage1_col25_1, carry_stage1_col25_2, carry_stage1_col26_1, carry_stage1_col26_2;

acfgi1 col9_stage0_1(sum_stage1_col9_1,carry_stage1_col9_1,pp[2][6],pp[3][5],pp[4][4],pp[5][3]);
acfgi1 col10_stage0_1(sum_stage1_col10_1,carry_stage1_col10_1,pp[3][6],pp[4][5],pp[5][4],pp[6][3]);
acfgi1 col11_stage0_1(sum_stage1_col11_1,carry_stage1_col11_1,pp[3][7],pp[4][6],pp[5][5],pp[6][4]);
acfgi1 col12_stage0_1(sum_stage1_col12_1,carry_stage1_col12_1,pp[4][7],pp[5][6],pp[6][5],pp[7][4]);
acfgi1 col13_stage0_1(sum_stage1_col13_1,carry_stage1_col13_1,pp[3][9],pp[4][8],pp[5][7],pp[6][6]);
acfgi1 col13_stage0_2(sum_stage1_col13_2,carry_stage1_col13_2,pp[7][5],pp[8][4],pp[9][3],pp[10][2]);
acfgi1 col14_stage0_1(sum_stage1_col14_1,carry_stage1_col14_1,pp[3][10],pp[4][9],pp[5][8],pp[6][7]);
acfgi1 col14_stage0_2(sum_stage1_col14_2,carry_stage1_col14_2,pp[7][6],pp[8][5],pp[9][4],pp[10][3]);
acfgi1 col15_stage0_1(sum_stage1_col15_1,carry_stage1_col15_1,pp[3][11],pp[4][11],pp[5][9],pp[6][8]);
acfgi1 col15_stage0_2(sum_stage1_col15_2,carry_stage1_col15_2,pp[7][7],pp[8][6],pp[9][5],pp[10][4]);
acfgi1 col16_stage0_1(sum_stage1_col16_1,carry_stage1_col16_1,pp[4][11],pp[5][10],pp[6][9],pp[7][8]);
acfgi1 col16_stage0_2(sum_stage1_col16_2,carry_stage1_col16_2,pp[8][7],pp[9][6],pp[10][5],pp[11][4]);

ac6g1 col17_stage0_1(sum_stage1_col17_1,carry_stage1_col17_1,pp[1][15],pp[2][14],pp[3][13],pp[4][12]);
ac6g1 col17_stage0_2(sum_stage1_col17_2,carry_stage1_col17_2,pp[5][11],pp[6][10],pp[7][9],pp[8][8]);
ac6g1 col17_stage0_3(sum_stage1_col17_3,carry_stage1_col17_3,pp[9][7],pp[10][6],pp[11][5],pp[12][4]);

ac6g1 col18_stage0_1(sum_stage1_col18_1,carry_stage1_col18_1,pp[2][15],pp[3][14],pp[4][13],pp[5][12]);
ac6g1 col18_stage0_2(sum_stage1_col18_2,carry_stage1_col18_2,pp[6][11],pp[7][10],pp[8][9],pp[9][8]);
ac6g1 col18_stage0_3(sum_stage1_col18_3,carry_stage1_col18_3,pp[10][7],pp[11][6],pp[12][5],pp[13][4]);

ac6g1 col19_stage0_1(sum_stage1_col19_1,carry_stage1_col19_1,pp[3][15],pp[4][14],pp[5][13],pp[6][12]);
ac6g1 col19_stage0_2(sum_stage1_col19_2,carry_stage1_col19_2,pp[7][11],pp[8][10],pp[9][9],pp[10][8]);
ac6g1 col19_stage0_3(sum_stage1_col19_3,carry_stage1_col19_3,pp[11][7],pp[12][6],pp[13][5],pp[14][4]);

ac6g1 col20_stage0_1(sum_stage1_col20_1,carry_stage1_col20_1,pp[4][15],pp[5][14],pp[6][13],pp[7][12]);
ac6g1 col20_stage0_2(sum_stage1_col20_2,carry_stage1_col20_2,pp[8][11],pp[9][10],pp[10][9],pp[11][8]);
ac6g1 col20_stage0_3(sum_stage1_col20_3,carry_stage1_col20_3,pp[12][7],pp[13][6],pp[14][5],pp[15][4]);

ac6g1 col21_stage0_1(sum_stage1_col21_1,carry_stage1_col21_1,pp[5][15],pp[6][14],pp[7][13],pp[8][12]);
ac6g1 col21_stage0_2(sum_stage1_col21_2,carry_stage1_col21_2,pp[9][11],pp[10][10],pp[11][9],pp[12][8]);

ac6g1 col22_stage0_1(sum_stage1_col22_1,carry_stage1_col22_1,pp[6][15],pp[7][14],pp[8][13],pp[9][12]);
ac6g1 col22_stage0_2(sum_stage1_col22_2,carry_stage1_col22_2,pp[10][11],pp[11][10],pp[12][9],pp[13][8]);

ac6g1 col23_stage0_1(sum_stage1_col23_1,carry_stage1_col23_1,pp[7][15],pp[8][14],pp[9][13],pp[10][12]);
ac6g1 col23_stage0_2(sum_stage1_col23_2,carry_stage1_col23_2,pp[11][11],pp[12][10],pp[13][9],pp[14][8]);

fa col24_stage0_1(sum_stage1_col24_1,carry_stage1_col24_1,pp[8][15],pp[9][14],pp[10][13]);
fa col24_stage0_2(sum_stage1_col24_2,carry_stage1_col24_2,pp[11][12],pp[12][11],pp[13][10]);

fa col25_stage0_1(sum_stage1_col25_1,carry_stage1_col25_1,pp[9][15],pp[10][14],pp[11][13]);
fa col25_stage0_2(sum_stage1_col25_2,carry_stage1_col25_2,pp[12][12],pp[13][11],pp[14][10]);

fa col26_stage0_1(sum_stage1_col26_1,carry_stage1_col26_1,pp[10][15],pp[11][14],pp[12][13]);
fa col26_stage0_2(sum_stage1_col26_2,carry_stage1_col26_2,pp[13][12],pp[14][11],pp[15][10]);

////stage 1
wire sum_stage2_col13_1, sum_stage2_col14_1, sum_stage2_col15_1, sum_stage2_col16_1,sum_stage2_col17_1, sum_stage2_col17_2,sum_stage2_col18_1, sum_stage2_col18_2,sum_stage2_col19_1, sum_stage2_col20_1,sum_stage2_col21_1, sum_stage2_col21_2,sum_stage2_col22_1, sum_stage2_col23_1,sum_stage2_col24_1, sum_stage2_col24_2,sum_stage2_col25_1, sum_stage2_col26_1,sum_stage2_col27_1, sum_stage2_col27_2;
wire carry_stage2_col13_1, carry_stage2_col14_1, carry_stage2_col15_1, carry_stage2_col16_1,carry_stage2_col17_1, carry_stage2_col17_2,carry_stage2_col18_1, carry_stage2_col18_2,carry_stage2_col19_1, carry_stage2_col20_1,carry_stage2_col21_1, carry_stage2_col21_2,carry_stage2_col22_1, carry_stage2_col23_1,carry_stage2_col24_1, carry_stage2_col24_2,carry_stage2_col25_1, carry_stage2_col26_1,carry_stage2_col27_1, carry_stage2_col27_2;

acfgi1 col13_stage1_1(sum_stage2_col13_1,carry_stage2_col13_1,sum_stage1_col13_1,sum_stage1_col13_2,carry_stage1_col12_1,pp[2][10]);
acfgi1 col14_stage1_1(sum_stage2_col14_1,carry_stage2_col14_1,sum_stage1_col14_1,sum_stage1_col14_2,carry_stage1_col13_1,carry_stage1_col13_2);
acfgi1 col15_stage1_1(sum_stage2_col15_1,carry_stage2_col15_1,sum_stage1_col15_1,sum_stage1_col15_2,carry_stage1_col14_1,carry_stage1_col14_2);
acfgi1 col16_stage1_1(sum_stage2_col16_1,carry_stage2_col16_1,sum_stage1_col16_1,sum_stage1_col16_2,carry_stage1_col15_1,carry_stage1_col15_2);

ac6g1 col17_stage1_1(sum_stage2_col17_1,carry_stage2_col17_1,sum_stage1_col17_1,sum_stage1_col17_2,sum_stage1_col17_3,carry_stage1_col16_1);
ac6g1 col17_stage1_2(sum_stage2_col17_2,carry_stage2_col17_2,carry_stage1_col16_2,pp[13][3],pp[14][2],pp[15][1]);

ac6g1 col18_stage1_1(sum_stage2_col18_1,carry_stage2_col18_1,sum_stage1_col18_1,sum_stage1_col18_2,sum_stage1_col18_3,carry_stage1_col17_1);
ac6g1 col18_stage1_2(sum_stage2_col18_2,carry_stage2_col18_2,carry_stage1_col17_2,carry_stage1_col17_3,pp[14][3],pp[15][2]);

ac6g1 col19_stage1_1(sum_stage2_col19_1,carry_stage2_col19_1,sum_stage1_col19_1,sum_stage1_col19_2,sum_stage1_col19_3,carry_stage1_col18_1);
ac6g1 col20_stage1_1(sum_stage2_col20_1,carry_stage2_col20_1,sum_stage1_col20_1,sum_stage1_col20_2,sum_stage1_col20_3,carry_stage1_col19_1);

ac6g1 col21_stage1_1(sum_stage2_col21_1,carry_stage2_col21_1,sum_stage1_col21_1,sum_stage1_col21_2,carry_stage1_col20_1,carry_stage1_col20_2);
ac6g1 col21_stage1_2(sum_stage2_col21_2,carry_stage2_col21_2,carry_stage1_col20_3,pp[13][7],pp[14][6],pp[15][5]);

ac6g1 col22_stage1_1(sum_stage2_col22_1,carry_stage2_col22_1,sum_stage1_col22_1,sum_stage1_col22_2,carry_stage1_col21_1,carry_stage1_col21_2);
ac6g1 col23_stage1_1(sum_stage2_col23_1,carry_stage2_col23_1,sum_stage1_col23_1,sum_stage1_col23_2,carry_stage1_col22_1,carry_stage1_col22_2);

fa col24_stage1_1(sum_stage2_col24_1,carry_stage2_col24_1,sum_stage1_col24_1,sum_stage1_col24_2,carry_stage1_col23_1);
fa col24_stage1_2(sum_stage2_col24_2,carry_stage2_col24_2,carry_stage1_col23_2,pp[14][9],pp[15][8]);

fa col25_stage1_1(sum_stage2_col25_1,carry_stage2_col25_1,sum_stage1_col25_1,sum_stage1_col25_2,carry_stage1_col24_1);
fa col26_stage1_1(sum_stage2_col26_1,carry_stage2_col26_1,sum_stage1_col26_1,sum_stage1_col26_2,carry_stage1_col25_1);

fa col27_stage1_1(sum_stage2_col27_1,carry_stage2_col27_1,pp[11][15],pp[12][14],pp[13][13]);
fa col27_stage1_2(sum_stage2_col27_2,carry_stage2_col27_2,pp[14][12],pp[15][11],carry_stage1_col26_1);

////stage 2
wire sum_stage3_col17_1, sum_stage3_col18_1, sum_stage3_col19_1, sum_stage3_col20_1, sum_stage3_col22_1;
wire carry_stage3_col17_1, carry_stage3_col18_1, carry_stage3_col19_1, carry_stage3_col20_1, carry_stage3_col22_1;


ac6g1 col17_stage2_1(sum_stage3_col17_1,carry_stage3_col17_1,sum_stage2_col17_1,carry_stage2_col16_1,1'b0,1'b0);
ac6g1 col18_stage2_1(sum_stage3_col18_1,carry_stage3_col18_1,sum_stage2_col18_1,sum_stage2_col18_2,carry_stage2_col17_1,carry_stage2_col17_2);
ac6g1 col19_stage2_1(sum_stage3_col19_1,carry_stage3_col19_1,sum_stage2_col19_1,carry_stage1_col18_2,carry_stage1_col18_3,pp[15][3]);
ac6g1 col20_stage2_1(sum_stage3_col20_1,carry_stage3_col20_1,sum_stage2_col20_1,carry_stage1_col19_2,carry_stage1_col19_3,carry_stage2_col19_1);
ac6g1 col22_stage2_1(sum_stage3_col22_1,carry_stage3_col22_1,sum_stage2_col22_1,pp[14][7],pp[15][6],carry_stage2_col21_1);

///stage 3
wire sum_stage4_col19_1, sum_stage4_col21_1, sum_stage4_col23_1;
wire carry_stage4_col19_1, carry_stage4_col21_1, carry_stage4_col23_1;


ac6g1 col19_stage3_1(sum_stage4_col19_1,carry_stage4_col19_1,sum_stage3_col19_1,carry_stage2_col18_1,carry_stage2_col18_2,carry_stage3_col18_1);
ac6g1 col21_stage3_1(sum_stage4_col21_1,carry_stage4_col21_1,sum_stage2_col21_1,sum_stage2_col21_2,carry_stage2_col20_1,carry_stage3_col20_1);
ac6g1 col23_stage3_1(sum_stage4_col23_1,carry_stage4_col23_1,sum_stage2_col23_1,pp[15][7],carry_stage2_col22_1,carry_stage3_col22_1);

///stage 4
wire sum_stage5_col20_1, sum_stage5_col22_1, sum_stage5_col24_1, sum_stage5_col25_1, sum_stage5_col26_1, sum_stage5_col27_1;
wire carry_stage5_col20_1, carry_stage5_col22_1, carry_stage5_col24_1, carry_stage5_col25_1, carry_stage5_col26_1, carry_stage5_col27_1;

ac6g1 col20_stage4_1(sum_stage5_col20_1,carry_stage5_col20_1,sum_stage3_col20_1,carry_stage3_col19_1,carry_stage4_col19_1,1'b0);
ac6g1 col22_stage4_1(sum_stage5_col22_1,carry_stage5_col22_1,sum_stage3_col22_1,carry_stage2_col21_2,carry_stage4_col21_1,1'b0);

// Fixed duplicate input
fa col24_stage4_1(sum_stage5_col24_1,carry_stage5_col24_1,sum_stage2_col24_1,sum_stage2_col24_2,carry_stage2_col23_1);
fa col25_stage4_1(sum_stage5_col25_1,carry_stage5_col25_1,sum_stage2_col25_1,carry_stage2_col24_1,carry_stage2_col24_2);
fa col26_stage4_1(sum_stage5_col26_1,carry_stage5_col26_1,sum_stage2_col26_1,carry_stage1_col25_1,carry_stage2_col25_1);
fa col27_stage4_1(sum_stage5_col27_1,carry_stage5_col27_1,sum_stage2_col27_1,sum_stage2_col27_2,carry_stage2_col26_1);

///stage 5
wire sum_stage6_col25_1, sum_stage6_col28_1, sum_stage6_col28_2;
wire carry_stage6_col25_1, carry_stage6_col28_1, carry_stage6_col28_2;

fa col25_stage5_1(sum_stage6_col25_1,carry_stage6_col25_1,sum_stage5_col25_1,carry_stage1_col24_2,pp[15][9]);
fa col28_stage5_1(sum_stage6_col28_1,carry_stage6_col28_1,pp[12][15],pp[13][14],pp[14][13]);
fa col28_stage5_2(sum_stage6_col28_2,carry_stage6_col28_2,pp[15][12],carry_stage2_col27_1,carry_stage2_col27_2);

///stage 6
wire sum_stage7_col26_1, sum_stage7_col28_1;
wire carry_stage7_col26_1, carry_stage7_col28_1;

// Added missing carry_stage6_col26_1
fa col26_stage6_1(sum_stage7_col26_1,carry_stage7_col26_1,sum_stage5_col26_1,carry_stage5_col25_1,carry_stage6_col25_1);
fa col28_stage6_1(sum_stage7_col28_1,carry_stage7_col28_1,sum_stage6_col28_1,sum_stage6_col28_2,carry_stage5_col27_1);

//stage 7
wire sum_stage8_col27_1, sum_stage8_col29_1, sum_stage8_col29_2;
wire carry_stage8_col27_1, carry_stage8_col29_1, carry_stage8_col29_2;

fa col27_stage7_1(sum_stage8_col27_1,carry_stage8_col27_1,sum_stage5_col27_1,carry_stage1_col26_1,carry_stage5_col26_1);
fa col29_stage7_1(sum_stage8_col29_1,carry_stage8_col29_1,pp[13][15],pp[14][14],pp[15][13]);
fa col29_stage7_2(sum_stage8_col29_2,carry_stage8_col29_2,carry_stage6_col28_1,carry_stage6_col28_2,carry_stage7_col28_1);

//stage 8
wire sum_stage9_col30_1;
wire carry_stage9_col30_1;
fa col30_stage8_1(sum_stage9_col30_1,carry_stage9_col30_1,pp[15][14],carry_stage8_col29_1,carry_stage8_col29_2);

//RCA
wire s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31;
wire c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;

ha h1(s9,c9,sum_stage1_col9_1,1'b0);
fa f1(s10,c10,c9,sum_stage1_col10_1,carry_stage1_col9_1);
fa f2(s11,c11,c10,sum_stage1_col11_1,carry_stage1_col10_1);
fa f3(s12,c12,c11,sum_stage1_col12_1,carry_stage1_col11_1);
fa f4(s13,c13,c12,sum_stage2_col13_1,1'b0);
fa f5(s14,c14,c13,sum_stage2_col14_1,carry_stage2_col13_1);
fa f6(s15,c15,c14,sum_stage2_col15_1,carry_stage2_col14_1);
fa f7(s16,c16,c15,sum_stage2_col16_1,carry_stage2_col15_1);

fa f8(s17,c17,c16,sum_stage3_col17_1,1'b0);
fa f9(s18,c18,c17,sum_stage3_col18_1,carry_stage3_col17_1);
fa f10(s19,c19,c18,sum_stage4_col19_1,1'b0);
fa f11(s20,c20,c19,sum_stage5_col20_1,1'b0);
fa f12(s21,c21,c20,sum_stage4_col21_1,carry_stage5_col20_1);
fa f13(s22,c22,c21,sum_stage5_col22_1,1'b0);
fa f14(s23,c23,c22,sum_stage4_col23_1,carry_stage5_col22_1);

fa f15(s24,c24,c23,sum_stage5_col24_1,carry_stage4_col23_1);
fa f16(s25,c25,c24,sum_stage6_col25_1,carry_stage5_col24_1);
fa f17(s26,c26,c25,sum_stage7_col26_1,1'b0);
fa f18(s27,c27,c26,sum_stage8_col27_1,carry_stage7_col26_1);
fa f19(s28,c28,c27,sum_stage7_col28_1,carry_stage8_col27_1);
fa f20(s29,c29,c28,sum_stage8_col29_1,sum_stage8_col29_2);
fa f21(s30,c30,c29,pp[14][15],sum_stage9_col30_1);
fa f22(s31,c31,c30,pp[15][15],carry_stage9_col30_1);


always @(*) begin
    y[7:0] = 8'b0;
    y[8] = s9;
    y[9] = s10;
    y[10] = s11;
    y[11] = s12;
    y[12] = s13;
    y[13] = s14;
    y[14] = s15;
    y[15] = s16;
    y[16] = s17;
    y[17] = s18;
    y[18] = s19;
    y[19] = s20;
    y[20] = s21;
    y[21] = s22;
    y[22] = s23;
    y[23] = s24;
    y[24] = s25;
    y[25] = s26;
    y[26] = s27;
    y[27] = s28;
    y[28] = s29;
    y[29] = s30;
    y[30] = s31;
    y[31] = c31;
end

endmodule

module acfgi1(sum, carry, x1, x2, x3, x4);
input x1, x2, x3, x4;
output sum, carry;
  assign sum = 1;      // Always 1 (approximation)
  assign carry = x1;      // Carry = first input (approximation)
  // assign carry  = 0;
endmodule

module ac6g1(sum, carry, x1, x2, x3, x4);
input x1, x2, x3, x4;
output sum, carry;
  assign sum = (x1 | x2 | x3 | x4);      // Approximate OR
  assign carry = (x1 & (x3 | x4)) | (x2 & x3);  // Approximate carry
endmodule

module fa(Sum, Carry, a, b, c);
input a, b, c;
output Sum, Carry;
assign Sum = a ^ b ^ c;
assign Carry = (a & b) | (b & c) | (c & a);
endmodule

module ha(Sum, Carry, a, b);
input a, b;
output Sum, Carry;
assign Sum = a ^ b;
assign Carry = a & b;
endmodule



`timescale 1ns/1ps

module approx_16x16_tb;
    reg [15:0] a, b;
    wire [31:0] y;
    reg [31:0] expected;

    
    approx_16x16 uut (.y(y), .a(a), .b(b));

    initial begin
        // Test case 1: 65535 * 65535
        #10 a = 16'd65535; b = 16'd65535; expected = a * b;
        $display("Test 1: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 2: 43690 * 21845
        #10 a = 16'd43690; b = 16'd21845; expected = a * b;
        $display("Test 2: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 3: 32768 * 32768
        #10 a = 16'd32768; b = 16'd32768; expected = a * b;
        $display("Test 3: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 4: 65280 * 255
        #10 a = 16'd65280; b = 16'd255; expected = a * b;
        $display("Test 4: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 5: 4660 * 22136
        #10 a = 16'd4660; b = 16'd22136; expected = a * b;
        $display("Test 5: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 6: 12345 * 54321
        #10 a = 16'd12345; b = 16'd54321; expected = a * b;
        $display("Test 6: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 7: 40000 * 30000
        #10 a = 16'd40000; b = 16'd30000; expected = a * b;
        $display("Test 7: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 8: 65535 * 1
        #10 a = 16'd65535; b = 16'd1; expected = a * b;
        $display("Test 8: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 9: 1234 * 5678
        #10 a = 16'd1234; b = 16'd5678; expected = a * b;
        $display("Test 9: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 10: 60000 * 60000
        #10 a = 16'd60000; b = 16'd60000; expected = a * b;
        $display("Test 10: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        #10 $finish;
    end

    initial begin
        $monitor("At time %t: a = %d, b = %d, y = %d", $time, a, b, y);
    end
endmodule
