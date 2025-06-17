def approx_mul(a, b):
    """
    Approximate 8x8 multiplier using custom compressors and adders.
    a, b: 8-bit integers (0 to 255)
    returns: 16-bit approximate product
    """
    assert 0 <= a <= 0xFF and 0 <= b <= 0xFF, "Inputs must be 8-bit"
    # Initialize partial product matrix (8x8)
    pp = [[0 for j in range(8)] for i in range(8)]

    # Generate partial products (same as Verilog-style AND gates)
    for i in range(8):
        for j in range(8):
            ai = (a >> j) & 1
            bi = (b >> i) & 1
            pp[i][j] = ai & bi

    #stage 0
    sum_stage1_col5_1,carry_stage1_col5_1 = acgfii(pp[1][3],pp[2][2],pp[3][1],0)
    sum_stage1_col6_1,carry_stage1_col6_1 = acgfii(pp[1][4],pp[2][3],pp[3][2],pp[4][1])
    sum_stage1_col7_1,carry_stage1_col7_1 = acgfii(pp[1][5],pp[2][4],pp[3][3],pp[4][2])
    sum_stage1_col8_1,carry_stage1_col8_1 = acgfii(pp[2][5],pp[3][4],pp[4][3],pp[5][2])

    sum_stage1_col9_1,carry_stage1_col9_1 = ac6g(pp[1][7],pp[2][6],pp[3][5],pp[4][4])
    sum_stage1_col9_2,carry_stage1_col9_2 = ac6g(pp[5][3],pp[6][2],pp[7][1],0)
    sum_stage1_col10_1,carry_stage1_col10_1 = ac6g(pp[2][7],pp[3][6],pp[4][5],pp[5][4])
    sum_stage1_col11_1,carry_stage1_col11_1 = ac6g(pp[3][7],pp[4][6],pp[5][5],pp[6][4])
    
    sum_stage1_col12_1,carry_stage1_col12_1 = fa(pp[5][6],pp[6][5],pp[7][4])
    sum_stage1_col13_1,carry_stage1_col13_1 = fa(pp[5][7],pp[6][6],pp[7][5])
    
    #stage 1
    sum_stage2_col9_1,carry_stage2_col9_1 = ac6g(sum_stage1_col9_1,sum_stage1_col9_2,carry_stage1_col8_1,0)
    sum_stage2_col10_1,carry_stage2_col10_1 = ac6g(sum_stage1_col10_1,carry_stage1_col9_1,carry_stage1_col9_2,pp[6][3])
    sum_stage2_col12_1,carry_stage2_col12_1 = fa(sum_stage1_col12_1,carry_stage1_col11_1,pp[4][7])
    sum_stage2_col14_1,carry_stage2_col14_1 = fa(pp[6][7],pp[7][6],carry_stage1_col13_1)

    #stage 2
    sum_stage3_col10_1,carry_stage3_col10_1 = ac6g(sum_stage2_col10_1,pp[7][2],carry_stage2_col9_1,0)
    sum_stage3_col11_1,carry_stage3_col11_1 = ac6g(sum_stage1_col11_1,carry_stage1_col10_1,pp[7][3],carry_stage2_col10_1)
    sum_stage3_col13_1,carry_stage3_col13_1 = fa(sum_stage1_col13_1,carry_stage1_col12_1,carry_stage2_col12_1)
    
    #ripple carry adder
    s1,c1 = ha(sum_stage1_col5_1,0)
    s2,c2 = fa(sum_stage1_col6_1,carry_stage1_col5_1,c1)
    s3,c3 = fa(sum_stage1_col7_1,carry_stage1_col6_1,c2)
    s4,c4 = fa(sum_stage1_col8_1,carry_stage1_col7_1,c3)
    s5,c5 = fa(sum_stage2_col9_1,c4,0)
    s6,c6 = fa(sum_stage3_col10_1,c5,0)
    s7,c7 = fa(sum_stage3_col11_1,carry_stage3_col10_1,c6)
    s8,c8 = fa(sum_stage2_col12_1,carry_stage3_col11_1,c7)
    s9,c9 = fa(sum_stage3_col13_1,c8,0)
    s10,c10 = fa(sum_stage2_col14_1,carry_stage3_col13_1,c9)
    s11,c11 = fa(pp[7][7],carry_stage2_col14_1,c10)

    y = 0
    y |= 0 << 0
    y |= 0 << 1
    y |= 0 << 2
    y |= 0 << 3  # Truncating lower bits

    y |= s1 << 4
    y |= s2 << 5
    y |= s3 << 6
    y |= s4 << 7
    y |= s5 << 8
    y |= s6 << 9
    y |= s7 << 10
    y |= s8 << 11
    y |= s9 << 12
    y |= s10 << 13
    y |= s11 << 14
    y |= c11 << 15  # Final MSB

    return y & 0xFFFF  # 16-bit output



def ac6g(a, b, c, d):
    sum_ = a | b | c | d
    carry = (a & (c | d)) | (b & c)
    return (sum_ & 1, carry & 1)

def acgfii(a, b, c, d):
    sum_ = a
    carry = b
    return (sum_ & 1, carry & 1)

def ha(a, b):
    sum_ = a ^ b       # XOR for sum
    carry = a & b      # AND for carry
    return (sum_ & 1, carry & 1)

def fa(a, b, cin):
    sum_ = a ^ b ^ cin
    carry = (a & b) | (b & cin) | (a & cin)
    return (sum_ & 1, carry & 1)


print(approx_mul(255, 255))
