`timescale 1ns/1ps
module acfgimd(y, a, b);
input [7:0] a, b;
output reg [15:0] y;  // Changed to 'reg' to ensure all bits are driven
wire [7:0] pp [7:0]; 

// Generate partial products
genvar i, j;
generate
  for (i = 0; i < 8; i = i + 1) begin : PARTIAL_PRODUCTS
    for (j = 0; j < 8; j = j + 1) begin : AND_GATES
      assign pp[i][j] = b[i] & a[j];
    end
  end
endgenerate

//always @(*) begin
  //  y[3:0] = 4'b000;  // Set lower bits to 0
 //end
 
wire s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10;
wire ss1,ss2,ss3,ss4,cc1,cc2,cc3,cc4;
wire sss1,ccc1,sss2,ccc2,ccc3,sss3;

acfgi1 acf1(s1,c1,pp[1][3],pp[2][2],pp[3][1],1'b0);
acfgi1 acf2(s2,c2,pp[1][4],pp[2][3],pp[3][2],pp[4][1]);
acfgi1 acf3(s3,c3,pp[1][5],pp[2][4],pp[3][3],pp[4][2]);
acfgi1 acf4(s4,c4,pp[2][5],pp[3][4],pp[4][3],pp[5][2]);

ac6g1 acg1(s5,c5,pp[1][7],pp[2][6],pp[3][5],pp[4][4]);
ac6g1 acg2(s6,c6,pp[5][3],pp[6][2],pp[7][1],1'b0);
ac6g1 acg3(s7,c7,pp[2][7],pp[3][6],pp[4][5],pp[5][4]);
ac6g1 acg4(s8,c8,pp[3][7],pp[4][6],pp[5][5],pp[6][4]);

fa faa(s9,c9,pp[5][6],pp[6][5],pp[7][4]);
fa fab(s10,c10,pp[5][7],pp[6][6],pp[7][5]);

ac6g1 acg5(ss1,cc1,s5,s6,c4,1'b0);
ac6g1 acg6(ss2,cc2,s7,c5,c6,pp[6][3]);


fa fad(ss3,cc3,s9,c8,pp[4][7]);
fa fae(ss4,cc4,pp[6][7],pp[7][6],c10);

ac6g1 acg7(sss1,ccc1,ss2,pp[7][2],cc1,1'b0);
ac6g1 acg8(sss2,ccc2,s8,c7,pp[7][3],cc2);
fa faf(sss3,ccc3,s10,c9,cc3);



wire sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,sum11;
wire carry1,carry2,carry3,carry4,carry5,carry6,carry7,carry8,carry9,carry10,carry11;

ha ha1(sum1,carry1,s1,1'b0);
fa fa1(sum2,carry2,s2,c1,carry1);
fa fa2(sum3,carry3,s3,c2,carry2);
fa fa3(sum4,carry4,s4,c3,carry3);
fa fa4(sum5,carry5,1'b0,ss1,carry4);
fa fa5(sum6,carry6,sss1,1'b0,carry5);
fa fa6(sum7,carry7,sss2,ccc1,carry6);
fa fa7(sum8,carry8,ss3,ccc2,carry7);
fa fa8(sum9,carry9,sss3,1'b0,carry8);
fa fa9(sum10,carry10,ss4,ccc3,carry9);
fa fa10(sum11,carry11,pp[7][7],cc4,carry10);

always @(*) begin
    y[3:0] = 4'b000;
    y[4] = sum1;
    y[5] = sum2;
    y[6] = sum3;
    y[7] = sum4;
    y[8] = sum5;
    y[9] = sum6;
    y[10] = sum7;
    y[11] = sum8;
    y[12] = sum9;
    y[13] = sum10;
    y[14] = sum11;
    y[15]= carry11;
    
end
endmodule

// ACFGI Compressor (as per Table III)
module acfgi1(sum, carry, x1, x2, x3, x4);
input x1, x2, x3, x4;
output sum, carry;
  assign sum = 1;      // Always 1 (approximation)
  assign carry = x1;      // Carry = first input (approximation)
endmodule

// AC6G1 Compressor (fixed syntax)
module ac6g1(sum, carry, x1, x2, x3, x4);
input x1, x2, x3, x4;
output sum, carry;
  assign sum = (x1 | x2 | x3 | x4);      // Approximate OR
  assign carry = (x1 & (x3 | x4)) | (x2 & x3);  // Approximate carry
endmodule

// Full Adder Module 
module fa(Sum, Carry, a, b, c);
input a, b, c;
output Sum, Carry;
assign Sum = a ^ b ^ c;
assign Carry = (a & b) | (b & c) | (c & a);
endmodule

// Half Adder Module
module ha(Sum, Carry, a, b);
input a, b;
output Sum, Carry;
assign Sum = a ^ b;
assign Carry = a & b;
endmodule

`timescale 1ns/1ps

module acfgimd_tb;
    reg [7:0] a, b;
    wire [15:0] y;
    reg [15:0] expected;

    // Instantiate the multiplier
    acfgi9md uut (.y(y), .a(a), .b(b));

    initial begin
        // Test case 1: 255 * 255
        #10 a = 8'd255; b = 8'd255; expected = a * b;
        $display("Test 1: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 3: 240 * 240
        #10 a = 8'd240; b = 8'd240; expected = a * b;
        $display("Test 3: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");
        
        // Test case 2: 255 * 200
        #10 a = 8'd255; b = 8'd200; expected = a * b;
        $display("Test 2: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 4: 200 * 199
        #10 a = 8'd200; b = 8'd199; expected = a * b;
        $display("Test 4: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 5: 230 * 180
        #10 a = 8'd230; b = 8'd180; expected = a * b;
        $display("Test 5: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 6: 210 * 210
        #10 a = 8'd210; b = 8'd210; expected = a * b;
        $display("Test 6: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 7: 255 * 128
        #10 a = 8'd255; b = 8'd128; expected = a * b;
        $display("Test 7: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 8: 190 * 185
        #10 a = 8'd190; b = 8'd185; expected = a * b;
        $display("Test 8: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 9: 220 * 145
        #10 a = 8'd220; b = 8'd145; expected = a * b;
        $display("Test 9: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 10: 250 * 135
        #10 a = 8'd250; b = 8'd135; expected = a * b;
        $display("Test 10: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 11: 200 * 255
        #10 a = 8'd200; b = 8'd255; expected = a * b;
        $display("Test 11: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 12: 180 * 220
        #10 a = 8'd180; b = 8'd220; expected = a * b;
        $display("Test 12: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 13: 199 * 199
        #10 a = 8'd199; b = 8'd199; expected = a * b;
        $display("Test 13: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");
        
                // --- Lower Bit Range Tests ---
        // Test case 14: 1 * 1
        #10 a = 8'd1; b = 8'd1; expected = a * b;
        $display("Test 14: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 15: 2 * 3
        #10 a = 8'd2; b = 8'd3; expected = a * b;
        $display("Test 15: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 16: 7 * 15
        #10 a = 8'd7; b = 8'd15; expected = a * b;
        $display("Test 16: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 17: 8 * 16
        #10 a = 8'd8; b = 8'd16; expected = a * b;
        $display("Test 17: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // --- Mid-Range Tests ---
        // Test case 18: 64 * 64
        #10 a = 8'd64; b = 8'd64; expected = a * b;
        $display("Test 18: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 19: 90 * 100
        #10 a = 8'd90; b = 8'd100; expected = a * b;
        $display("Test 19: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 20: 110 * 110
        #10 a = 8'd110; b = 8'd110; expected = a * b;
        $display("Test 20: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 21: 127 * 127
        #10 a = 8'd127; b = 8'd127; expected = a * b;
        $display("Test 21: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // --- Mixed Range Tests ---
        // Test case 22: 8 * 200
        #10 a = 8'd8; b = 8'd200; expected = a * b;
        $display("Test 22: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 23: 16 * 190
        #10 a = 8'd16; b = 8'd190; expected = a * b;
        $display("Test 23: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 24: 32 * 180
        #10 a = 8'd32; b = 8'd180; expected = a * b;
        $display("Test 24: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 25: 64 * 140
        #10 a = 8'd64; b = 8'd140; expected = a * b;
        $display("Test 25: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");


        #10 $finish;
    end

    initial begin
        $monitor("At time %t: a = %d, b = %d, y = %d", $time, a, b, y);
    end
endmodule


