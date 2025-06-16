`timescale 1ns/1ps
module approx_32x32(y,a,b);
input [31:0] a,b;
output  [63:0] y;

wire [31:0] p1,p2,p3,p4;

submod_16x16 s1(p1,a[15:0] , b[15:0]);
submod_16x16 s2(p2,a[31:16],b[15:0]);
submod_16x16 s3(p3,a[15:0],b[31:16]);
submod_16x16 s4(p4,a[31:16],b[31:16]);

assign y = (p4<<32) + (p3<<16) + (p2<<16) + p1; 

endmodule

module tb_japlak;
    reg [31:0] a, b;
    wire [63:0] y;
    reg [63:0] expected;

    // Instantiate the 32x32 multiplier
    japlak uut (.y(y), .a(a), .b(b));

    initial begin
        // Test case 1: Max unsigned (FFFFFFFF * FFFFFFFF)
        #10 a = 32'hFFFF_FFFF; b = 32'hFFFF_FFFF; expected = a * b;
        $display("Test 1: %h * %h = %h (Expected: %h)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 2: 32'h12345678 * 32'h9ABCDEF0
        #10 a = 32'h12345678; b = 32'h9ABCDEF0; expected = a * b;
        $display("Test 2: %h * %h = %h (Expected: %h)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 3: 32'd4294967295 * 32'd1 (edge case)
        #10 a = 32'd4294967295; b = 32'd1; expected = a * b;
        $display("Test 3: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 4: 32'd4000000000 * 32'd3000000000
        #10 a = 32'd4000000000; b = 32'd3000000000; expected = a * b;
        $display("Test 4: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 5: 32'd2147483648 * 32'd2147483648 (2^31 * 2^31)
        #10 a = 32'd2147483648; b = 32'd2147483648; expected = a * b;
        $display("Test 5: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 6: Random 32-bit numbers
        #10 a = 32'hA5A5A5A5; b = 32'h5A5A5A5A; expected = a * b;
        $display("Test 6: %h * %h = %h (Expected: %h)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 7: Zero case
        #10 a = 32'd0; b = 32'd0; expected = a * b;
        $display("Test 7: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 8: 32'd123456789 * 32'd987654321
        #10 a = 32'd123456789; b = 32'd987654321; expected = a * b;
        $display("Test 8: %d * %d = %d (Expected: %d)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 9: 32'h80000000 * 32'h80000000 (signed min * signed min)
        #10 a = 32'h80000000; b = 32'h80000000; expected = a * b;
        $display("Test 9: %h * %h = %h (Expected: %h)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        // Test case 10: Alternating bit pattern
        #10 a = 32'hAAAA_AAAA; b = 32'h5555_5555; expected = a * b;
        $display("Test 10: %h * %h = %h (Expected: %h)", a, b, y, expected);
        if (y !== expected) $display("  ERROR: Mismatch!");

        #10 $finish;
    end

    initial begin
        $monitor("At time %t: a = %h, b = %h, y = %h", $time, a, b, y);
    end
endmodule
