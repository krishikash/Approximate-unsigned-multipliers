`timescale 1ns/1ps
module acfgi9020(y, a, b);
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

// Declare all intermediate wires
wire s1, c1, s2, c2, s3, c3, s4, c4, s5, c5, s6, c6;
wire s7, c7, s8, c8;
wire sa1, ca1, sa2, ca2, sa3, ca3, sb1, cb1, sb2, cb2;
wire sc1, cc1, sc2, cc2;
wire sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8;
wire sum9, sum10, sum11;

// Stage 1: First level of compression (ACFGI compressors)
acfgi1 ac1(s1, c1, pp[0][4], pp[1][3], pp[2][2], pp[3][1]);
acfgi1 ac2(s2, c2, pp[0][5], pp[1][4], pp[2][3], pp[3][2]);
acfgi1 ac3(s3, c3, pp[0][6], pp[1][5], pp[2][4], pp[3][3]);
acfgi1 ac4(s4, c4, pp[0][7], pp[1][6], pp[2][5], pp[3][4]);
acfgi1 ac5(s5, c5, pp[1][7], pp[2][6], pp[3][5], pp[4][4]);
acfgi1 ac6(s6, c6, pp[2][7], pp[3][6], pp[4][5], pp[5][4]);

// Stage 2: Second level of compression (AC6G1 compressors)
ac6g1 acg1(s7, c7, pp[3][7], pp[4][6], pp[5][5], pp[6][4]);
ac6g1 acg2(s8, c8, pp[4][7], pp[5][6], pp[6][5], pp[7][4]);

// Fixed wire declarations - removed syntax error
wire ss3, ss4, ss5, ss7, ss9, ss10, sss1, cc3, cc4, cc5, cc7, cc9, cc10, ccc1;

acfgi1 ac7(ss3, cc3, s3, c2, pp[4][2], 1'b0);
acfgi1 ac8(ss4, cc4, s4, c3, pp[4][3], 1'b0);
acfgi1 ac9(ss5, cc5, s5, c4, pp[5][3], 1'b0);
acfgi1 acg3(ss7, cc7, s7, pp[7][3], c6, 1'b0);
acfgi1 acg4(ss9, cc9, pp[5][7], pp[6][6], pp[7][5], c8);
ha haa(ss10, cc10, pp[6][7], pp[7][6]);
acfgi1 acg5(sss1, ccc1, s8, c7, cc7, 1'b0);

wire carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9, carry10;

// Fixed output assignment - can't assign to reg in continuous assignment
always @(*) begin
    y[2:0] = 3'b000;  // Set lower bits to 0
    y[3] = pp[0][3];  // Direct assignment for bit 3
    y[4] = pp[0][4] ^ pp[1][3] ^ pp[2][2] ^ pp[3][1];  // Simple approximation for bit 4
end

wire k1,k2,k3,k4,k5,k6,k7,k8k9,k10;
ha ha1(k1, carry1, s1, 1'b0);
fa fa1(k2, carry2, s2, c1, carry1);
fa fa2(k3, carry3, ss3, carry2, 1'b0);
fa fa3(k4, carry4, ss4, cc3, carry3);
fa fa4(k5, carry5, ss5, cc4, carry4);
fa fa5(k6, carry6, s6, cc5, carry5);
fa fa6(k7, carry7, ss7, carry6, 1'b0);
fa fa7(k8, carry8, sss1, carry7, 1'b0);
fa fa8(k9, carry9, ss9, ccc1, carry8);
fa fa9(k10, carry10, ss10, cc9, carry9);

// Fixed the final adder - removed invalid y[16] output
wire k11,k12;
fa fa10(k11,k12, pp[7][7], cc10, carry10);



always @(*) begin
    y[4] = k1;
    y[5] = k2;
    y[6] = k3;
    y[7] = k4;
    y[8] = k5;
    y[9] = k6;
    y[10] = k7;
    y[11] = k8;
    y[12] = k9;
    y[13] = k10;
    y[14] = k11;
    y[15] = k12;
end


endmodule

// ACFGI Compressor (as per Table III)
module acfgi1(sum, carry, x1, x2, x3, x4);
input x1, x2, x3, x4;
output sum, carry;
  assign sum = 1'b1;      // Always 1 (approximation)
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

// Enhanced Testbench
`timescale 1ns/1ps

`timescale 1ns/1ps

module acfgi9020_tb;
    reg [7:0] a, b;
    wire [15:0] y;
    reg [15:0] expected;
    real error_percentage;
    integer total_tests;
    integer passed_tests;
    real total_error;

    // Instantiate the DUT
    acfgi9020 uut (.y(y), .a(a), .b(b));

    // ?? ADD THIS TASK ? the one that was missing
    task calculate_and_display;
        real rel_error;
        begin
            rel_error = (expected != 0) ? (100.0 * (expected - y)) / expected : 0.0;
            if (rel_error < 0) rel_error = -rel_error;

            $display("%0t\t| %0d\t| %0d\t| %0d\t\t| %0d\t\t| %0d\t| %.2f%%", 
                     $time, a, b, y, expected, expected - y, rel_error);

            total_tests = total_tests + 1;
            total_error = total_error + rel_error;

            if (rel_error < 10.0)
                passed_tests = passed_tests + 1;
        end
    endtask

    // ?? Main simulation logic
    initial begin
        $display("Starting ACFGI99 Approximate Multiplier Test");
        $display("==================================================");
        $display("Time\t| a\t| b\t| Result\t| Expected\t| Error\t| Error%%");
        $display("--------|-------|-------|---------------|---------------|-------|--------");

        // Initialize counters
        total_tests = 0;
        passed_tests = 0;
        total_error = 0.0;

        // Test cases
        #10 a = 8'd0; b = 8'd0; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd1; b = 8'd187; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd5; b = 8'd3; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd16; b = 8'd8; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd50; b = 8'd40; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd123; b = 8'd45; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd200; b = 8'd150; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd255; b = 8'd255; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd17; b = 8'd19; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd64; b = 8'd32; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd100; b = 8'd100; expected = a * b; #1 calculate_and_display();
        #10 a = 8'd85; b = 8'd73; expected = a * b; #1 calculate_and_display();

        // Final summary
        $display("--------|-------|-------|---------------|---------------|-------|--------");
        $display("Test Summary:");
        $display("Total tests: %0d", total_tests);
        $display("Passed tests (error < 10%%): %0d", passed_tests);
        $display("Pass rate: %.1f%%", (passed_tests * 100.0) / total_tests);
        $display("Average error: %.2f%%", total_error / total_tests);
        $display("==================================================");

        // End simulation
        #10 $finish;
    end
endmodule
