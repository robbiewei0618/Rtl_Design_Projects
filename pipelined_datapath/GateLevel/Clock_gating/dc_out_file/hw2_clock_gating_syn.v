/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : V-2023.12
// Date      : Thu Oct 17 21:10:51 2024
/////////////////////////////////////////////////////////////


module stage1_cg_DW01_sub_0 ( DIFF, \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , 
        \A[2] , \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , 
        \B[1] , \B[0]  );
  output [8:0] DIFF;
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [8:2] carry;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;

  FA1D1BWP16P90LVT U2_7 ( .A(A[7]), .B(n3), .CI(carry[7]), .CO(carry[8]), .S(
        DIFF[7]) );
  FA1D1BWP16P90LVT U2_6 ( .A(A[6]), .B(n4), .CI(carry[6]), .CO(carry[7]), .S(
        DIFF[6]) );
  FA1D1BWP16P90LVT U2_5 ( .A(A[5]), .B(n5), .CI(carry[5]), .CO(carry[6]), .S(
        DIFF[5]) );
  FA1D1BWP16P90LVT U2_4 ( .A(A[4]), .B(n6), .CI(carry[4]), .CO(carry[5]), .S(
        DIFF[4]) );
  FA1D1BWP16P90LVT U2_3 ( .A(A[3]), .B(n7), .CI(carry[3]), .CO(carry[4]), .S(
        DIFF[3]) );
  FA1D1BWP16P90LVT U2_2 ( .A(A[2]), .B(n8), .CI(carry[2]), .CO(carry[3]), .S(
        DIFF[2]) );
  FA1D1BWP16P90LVT U2_1 ( .A(A[1]), .B(n9), .CI(n1), .CO(carry[2]), .S(DIFF[1]) );
  CKND1BWP16P90LVT U1 ( .I(B[1]), .ZN(n9) );
  CKND1BWP16P90LVT U2 ( .I(carry[8]), .ZN(DIFF[8]) );
  CKND1BWP16P90LVT U3 ( .I(B[6]), .ZN(n4) );
  CKND1BWP16P90LVT U4 ( .I(B[5]), .ZN(n5) );
  CKND1BWP16P90LVT U5 ( .I(B[4]), .ZN(n6) );
  CKND1BWP16P90LVT U6 ( .I(B[2]), .ZN(n8) );
  CKND1BWP16P90LVT U7 ( .I(B[3]), .ZN(n7) );
  OR2D1BWP16P90LVT U8 ( .A1(A[0]), .A2(n10), .Z(n1) );
  CKND1BWP16P90LVT U9 ( .I(B[7]), .ZN(n3) );
  CKND1BWP16P90LVT U10 ( .I(B[0]), .ZN(n10) );
  XNR2D1BWP16P90LVT U11 ( .A1(n10), .A2(A[0]), .ZN(DIFF[0]) );
endmodule


module stage1_cg_DW01_add_0 ( SUM, \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , 
        \A[2] , \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , 
        \B[1] , \B[0]  );
  output [8:0] SUM;
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  wire   n1;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [7:2] carry;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;

  FA1D1BWP16P90LVT U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(
        SUM[7]) );
  FA1D1BWP16P90LVT U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), 
        .S(SUM[6]) );
  FA1D1BWP16P90LVT U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), 
        .S(SUM[5]) );
  FA1D1BWP16P90LVT U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), 
        .S(SUM[4]) );
  FA1D1BWP16P90LVT U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), 
        .S(SUM[3]) );
  FA1D1BWP16P90LVT U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), 
        .S(SUM[2]) );
  FA1D1BWP16P90LVT U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(
        SUM[1]) );
  AN2D1BWP16P90LVT U1 ( .A1(B[0]), .A2(A[0]), .Z(n1) );
  XOR2D1BWP16P90LVT U2 ( .A1(B[0]), .A2(A[0]), .Z(SUM[0]) );
endmodule


module stage1_cg ( sum, co, a, b, c, s, clk, rst );
  output [15:0] sum;
  output [15:0] co;
  input [7:0] a;
  input [7:0] b;
  input [7:0] c;
  input s, clk, rst;
  wire   N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19,
         N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32,
         \co[15] , n2, n3, n4, n50;
  assign co[8] = \co[15] ;
  assign co[9] = \co[15] ;
  assign co[10] = \co[15] ;
  assign co[11] = \co[15] ;
  assign co[12] = \co[15] ;
  assign co[13] = \co[15] ;
  assign co[14] = \co[15] ;
  assign co[15] = \co[15] ;

  AO21D1BWP16P90LVT U14 ( .A1(s), .A2(N13), .B(N32), .Z(N31) );
  AO22D1BWP16P90LVT U16 ( .A1(N21), .A2(n4), .B1(N12), .B2(s), .Z(N30) );
  AO22D1BWP16P90LVT U17 ( .A1(N20), .A2(n4), .B1(N11), .B2(s), .Z(N29) );
  AO22D1BWP16P90LVT U18 ( .A1(N19), .A2(n4), .B1(N10), .B2(s), .Z(N28) );
  AO22D1BWP16P90LVT U19 ( .A1(N9), .A2(s), .B1(N18), .B2(n4), .Z(N27) );
  AO22D1BWP16P90LVT U20 ( .A1(N8), .A2(s), .B1(N17), .B2(n4), .Z(N26) );
  AO22D1BWP16P90LVT U21 ( .A1(N7), .A2(s), .B1(N16), .B2(n4), .Z(N25) );
  AO22D1BWP16P90LVT U22 ( .A1(N6), .A2(s), .B1(N15), .B2(n4), .Z(N24) );
  AO22D1BWP16P90LVT U23 ( .A1(N5), .A2(s), .B1(N14), .B2(n4), .Z(N23) );
  DFCNQD2BWP16P90LVT sum_reg_15_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[15]) );
  DFCNQD2BWP16P90LVT sum_reg_14_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[14]) );
  DFCNQD2BWP16P90LVT sum_reg_13_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[13]) );
  DFCNQD2BWP16P90LVT sum_reg_12_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[12]) );
  DFCNQD2BWP16P90LVT sum_reg_11_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[11]) );
  DFCNQD2BWP16P90LVT sum_reg_10_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[10]) );
  DFCNQD2BWP16P90LVT sum_reg_9_ ( .D(N32), .CP(clk), .CDN(n3), .Q(sum[9]) );
  DFCNQD2BWP16P90LVT sum_reg_8_ ( .D(N31), .CP(clk), .CDN(n3), .Q(sum[8]) );
  DFCNQD2BWP16P90LVT sum_reg_7_ ( .D(N30), .CP(clk), .CDN(n3), .Q(sum[7]) );
  DFCNQD2BWP16P90LVT sum_reg_6_ ( .D(N29), .CP(clk), .CDN(n3), .Q(sum[6]) );
  DFCNQD2BWP16P90LVT sum_reg_5_ ( .D(N28), .CP(clk), .CDN(n3), .Q(sum[5]) );
  DFCNQD2BWP16P90LVT sum_reg_4_ ( .D(N27), .CP(clk), .CDN(n2), .Q(sum[4]) );
  DFCNQD2BWP16P90LVT sum_reg_3_ ( .D(N26), .CP(clk), .CDN(n2), .Q(sum[3]) );
  DFCNQD2BWP16P90LVT sum_reg_2_ ( .D(N25), .CP(clk), .CDN(n2), .Q(sum[2]) );
  DFCNQD2BWP16P90LVT sum_reg_1_ ( .D(N24), .CP(clk), .CDN(n2), .Q(sum[1]) );
  DFCNQD2BWP16P90LVT sum_reg_0_ ( .D(N23), .CP(clk), .CDN(n2), .Q(sum[0]) );
  DFCNQD2BWP16P90LVT co_reg_7_ ( .D(c[7]), .CP(clk), .CDN(n2), .Q(co[7]) );
  DFCNQD2BWP16P90LVT co_reg_6_ ( .D(c[6]), .CP(clk), .CDN(n2), .Q(co[6]) );
  DFCNQD2BWP16P90LVT co_reg_5_ ( .D(c[5]), .CP(clk), .CDN(n2), .Q(co[5]) );
  DFCNQD2BWP16P90LVT co_reg_4_ ( .D(c[4]), .CP(clk), .CDN(n2), .Q(co[4]) );
  DFCNQD2BWP16P90LVT co_reg_3_ ( .D(c[3]), .CP(clk), .CDN(n2), .Q(co[3]) );
  DFCNQD2BWP16P90LVT co_reg_2_ ( .D(c[2]), .CP(clk), .CDN(n2), .Q(co[2]) );
  DFCNQD2BWP16P90LVT co_reg_1_ ( .D(c[1]), .CP(clk), .CDN(n2), .Q(co[1]) );
  DFCNQD2BWP16P90LVT co_reg_0_ ( .D(c[0]), .CP(clk), .CDN(n2), .Q(co[0]) );
  stage1_cg_DW01_sub_0 sub_47 ( .DIFF({N22, N21, N20, N19, N18, N17, N16, N15, 
        N14}), .\A[7] (a[7]), .\A[6] (a[6]), .\A[5] (a[5]), .\A[4] (a[4]), 
        .\A[3] (a[3]), .\A[2] (a[2]), .\A[1] (a[1]), .\A[0] (a[0]), .\B[7] (
        b[7]), .\B[6] (b[6]), .\B[5] (b[5]), .\B[4] (b[4]), .\B[3] (b[3]), 
        .\B[2] (b[2]), .\B[1] (b[1]), .\B[0] (b[0]) );
  stage1_cg_DW01_add_0 add_44 ( .SUM({N13, N12, N11, N10, N9, N8, N7, N6, N5}), 
        .\A[7] (a[7]), .\A[6] (a[6]), .\A[5] (a[5]), .\A[4] (a[4]), .\A[3] (
        a[3]), .\A[2] (a[2]), .\A[1] (a[1]), .\A[0] (a[0]), .\B[7] (b[7]), 
        .\B[6] (b[6]), .\B[5] (b[5]), .\B[4] (b[4]), .\B[3] (b[3]), .\B[2] (
        b[2]), .\B[1] (b[1]), .\B[0] (b[0]) );
  TIELBWP20P90LVT U3 ( .ZN(\co[15] ) );
  BUFFD1BWP16P90LVT U4 ( .I(n50), .Z(n2) );
  BUFFD1BWP16P90LVT U5 ( .I(n50), .Z(n3) );
  INR2D1BWP16P90LVT U6 ( .A1(N22), .B1(s), .ZN(N32) );
  CKND1BWP16P90LVT U7 ( .I(s), .ZN(n4) );
  CKND1BWP16P90LVT U8 ( .I(rst), .ZN(n50) );
endmodule


module SNPS_CLOCK_GATE_HIGH_clock_gate16_0 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CKLNQD1BWP20P90 latch ( .CP(CLK), .E(EN), .TE(TE), .Q(ENCLK) );
endmodule


module clock_gate16_0 ( Q, D, en, rst, clk );
  output [15:0] Q;
  input [15:0] D;
  input en, rst, clk;
  wire   gclk, net39, n1;

  DFCNQD2BWP16P90LVT Q_reg_15_ ( .D(D[15]), .CP(gclk), .CDN(n1), .Q(Q[15]) );
  DFCNQD2BWP16P90LVT Q_reg_14_ ( .D(D[14]), .CP(gclk), .CDN(n1), .Q(Q[14]) );
  DFCNQD2BWP16P90LVT Q_reg_13_ ( .D(D[13]), .CP(gclk), .CDN(n1), .Q(Q[13]) );
  DFCNQD2BWP16P90LVT Q_reg_12_ ( .D(D[12]), .CP(gclk), .CDN(n1), .Q(Q[12]) );
  DFCNQD2BWP16P90LVT Q_reg_11_ ( .D(D[11]), .CP(gclk), .CDN(n1), .Q(Q[11]) );
  DFCNQD2BWP16P90LVT Q_reg_10_ ( .D(D[10]), .CP(gclk), .CDN(n1), .Q(Q[10]) );
  DFCNQD2BWP16P90LVT Q_reg_9_ ( .D(D[9]), .CP(gclk), .CDN(n1), .Q(Q[9]) );
  DFCNQD2BWP16P90LVT Q_reg_8_ ( .D(D[8]), .CP(gclk), .CDN(n1), .Q(Q[8]) );
  DFCNQD2BWP16P90LVT Q_reg_6_ ( .D(D[6]), .CP(gclk), .CDN(n1), .Q(Q[6]) );
  DFCNQD2BWP16P90LVT Q_reg_4_ ( .D(D[4]), .CP(gclk), .CDN(n1), .Q(Q[4]) );
  DFCNQD2BWP16P90LVT Q_reg_3_ ( .D(D[3]), .CP(gclk), .CDN(n1), .Q(Q[3]) );
  DFCNQD2BWP16P90LVT Q_reg_2_ ( .D(D[2]), .CP(gclk), .CDN(n1), .Q(Q[2]) );
  DFCNQD2BWP16P90LVT Q_reg_0_ ( .D(D[0]), .CP(gclk), .CDN(n1), .Q(Q[0]) );
  SNPS_CLOCK_GATE_HIGH_clock_gate16_0 clk_gate_C45 ( .CLK(clk), .EN(en), 
        .ENCLK(gclk), .TE(net39) );
  DFCNQD2BWP16P90LVT Q_reg_7_ ( .D(D[7]), .CP(gclk), .CDN(n1), .Q(Q[7]) );
  DFCNQD2BWP16P90LVT Q_reg_1_ ( .D(D[1]), .CP(gclk), .CDN(n1), .Q(Q[1]) );
  DFCNQD2BWP16P90LVT Q_reg_5_ ( .D(D[5]), .CP(gclk), .CDN(n1), .Q(Q[5]) );
  TIELBWP20P90LVT U3 ( .ZN(net39) );
  INVD1BWP16P90LVT U4 ( .I(rst), .ZN(n1) );
endmodule


module SNPS_CLOCK_GATE_HIGH_clock_gate16_1 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CKLNQD1BWP20P90 latch ( .CP(CLK), .E(EN), .TE(TE), .Q(ENCLK) );
endmodule


module clock_gate16_1 ( Q, D, en, rst, clk );
  output [15:0] Q;
  input [15:0] D;
  input en, rst, clk;
  wire   gclk, net39, n1;

  DFCNQD2BWP16P90LVT Q_reg_15_ ( .D(D[15]), .CP(gclk), .CDN(n1), .Q(Q[15]) );
  DFCNQD2BWP16P90LVT Q_reg_14_ ( .D(D[14]), .CP(gclk), .CDN(n1), .Q(Q[14]) );
  DFCNQD2BWP16P90LVT Q_reg_13_ ( .D(D[13]), .CP(gclk), .CDN(n1), .Q(Q[13]) );
  DFCNQD2BWP16P90LVT Q_reg_12_ ( .D(D[12]), .CP(gclk), .CDN(n1), .Q(Q[12]) );
  DFCNQD2BWP16P90LVT Q_reg_11_ ( .D(D[11]), .CP(gclk), .CDN(n1), .Q(Q[11]) );
  DFCNQD2BWP16P90LVT Q_reg_10_ ( .D(D[10]), .CP(gclk), .CDN(n1), .Q(Q[10]) );
  DFCNQD2BWP16P90LVT Q_reg_9_ ( .D(D[9]), .CP(gclk), .CDN(n1), .Q(Q[9]) );
  DFCNQD2BWP16P90LVT Q_reg_8_ ( .D(D[8]), .CP(gclk), .CDN(n1), .Q(Q[8]) );
  DFCNQD2BWP16P90LVT Q_reg_7_ ( .D(D[7]), .CP(gclk), .CDN(n1), .Q(Q[7]) );
  DFCNQD2BWP16P90LVT Q_reg_6_ ( .D(D[6]), .CP(gclk), .CDN(n1), .Q(Q[6]) );
  DFCNQD2BWP16P90LVT Q_reg_5_ ( .D(D[5]), .CP(gclk), .CDN(n1), .Q(Q[5]) );
  DFCNQD2BWP16P90LVT Q_reg_4_ ( .D(D[4]), .CP(gclk), .CDN(n1), .Q(Q[4]) );
  DFCNQD2BWP16P90LVT Q_reg_3_ ( .D(D[3]), .CP(gclk), .CDN(n1), .Q(Q[3]) );
  DFCNQD2BWP16P90LVT Q_reg_2_ ( .D(D[2]), .CP(gclk), .CDN(n1), .Q(Q[2]) );
  DFCNQD2BWP16P90LVT Q_reg_1_ ( .D(D[1]), .CP(gclk), .CDN(n1), .Q(Q[1]) );
  DFCNQD2BWP16P90LVT Q_reg_0_ ( .D(D[0]), .CP(gclk), .CDN(n1), .Q(Q[0]) );
  SNPS_CLOCK_GATE_HIGH_clock_gate16_1 clk_gate_C45 ( .CLK(clk), .EN(en), 
        .ENCLK(gclk), .TE(net39) );
  TIELBWP20P90LVT U3 ( .ZN(net39) );
  INVD1BWP16P90LVT U4 ( .I(rst), .ZN(n1) );
endmodule


module stage2_cg_DW_mult_uns_2 ( a, b, \product[15] , \product[14] , 
        \product[13] , \product[12] , \product[11] , \product[10] , 
        \product[9] , \product[8] , \product[7] , \product[6] , \product[5] , 
        \product[4] , \product[3] , \product[2] , \product[1] , \product[0] 
 );
  input [15:0] a;
  input [15:0] b;
  output \product[15] , \product[14] , \product[13] , \product[12] ,
         \product[11] , \product[10] , \product[9] , \product[8] ,
         \product[7] , \product[6] , \product[5] , \product[4] , \product[3] ,
         \product[2] , \product[1] , \product[0] ;
  wire   n6, n9, n12, n16, n17, n21, n23, n27, n29, n32, n34, n37, n39, n41,
         n42, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n74, n75, n76, n78, n80, n81, n87, n89, n91, n92, n93, n94, n95, n97,
         n99, n100, n101, n102, n103, n105, n107, n108, n109, n110, n111, n113,
         n115, n121, n122, n123, n124, n126, n127, n128, n134, n136, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n237, n238, n239,
         n240, n241, n242, n243, n244, n245, n246, n247, n248, n249, n250,
         n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, n261,
         n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272,
         n273, n274, n275, n276, n277, n278, n279, n280, n281, n282, n283,
         n284, n285, n286, n287, n288, n289, n290, n291, n292, n293, n294,
         n295, n296, n297, n298, n299, n300, n301, n302, n303, n304, n305,
         n306, n307, n308, n309, n310, n311, n312, n313, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338,
         n339, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349,
         n350, n351, n352, n353, n354, n355, n356, n357, n358, n359, n360,
         n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, n371,
         n372, n373, n374, n375, n376, n377, n378, n379, n380, n381, n382,
         n383, n384, n385, n386, n387, n388, n389, n406, n407, n408, n409,
         n410, n411, n412, n413, n418, n419, n420, n422, n424, n425, n485,
         n486, n487, n488, n489, n490, n491, n492, n493, n494, n495, n496,
         n497, n498, n499, n500, n501, n502, n503, n504, n505, n506, n507,
         n508, n509, n510, n511, n512, n513, n514, n515, n516, n517, n518,
         n519, n520, n521, n522, n523, n524, n525, n526, n527, n528, n529,
         n530, n531, n532, n533, n534, n535, n536, n537, n538, n539, n540,
         n541, n542, n543, n544, n545, n546, n547, n548, n549, n550, n551,
         n552, n553, n554, n555, n556, n557, n558, n559, n560, n561, n562,
         n563, n564, n565, n566, n567, n568, n569, n570, n571, n572, n573,
         n574, n575, n576, n577, n578, n579, n580, n581, n582, n583, n584,
         n585, n586, n587, n588, n589, n590, n591, n592, n593, n594, n595,
         n596, n597, n598, n599, n600, n601, n602, n603, n604, n605, n606,
         n607, n608, n609, n610, n611, n612, n613, n614, n615, n616, n617,
         n618, n619, n620, n621, n622, n623, n624, n625, n626, n627, n628,
         n629, n630, n631, n632, n633, n634, n635, n636, n637;
  wire   [15:0] product;
  assign \product[15]  = product[15];
  assign \product[14]  = product[14];
  assign \product[13]  = product[13];
  assign \product[12]  = product[12];
  assign \product[11]  = product[11];
  assign \product[10]  = product[10];
  assign \product[9]  = product[9];
  assign \product[8]  = product[8];
  assign \product[7]  = product[7];
  assign \product[6]  = product[6];
  assign \product[5]  = product[5];
  assign \product[4]  = product[4];
  assign \product[3]  = product[3];
  assign \product[2]  = product[2];
  assign \product[1]  = product[1];
  assign \product[0]  = product[0];

  ND2D1BWP16P90LVT U34 ( .A1(n609), .A2(n61), .ZN(n45) );
  ND2D1BWP16P90LVT U37 ( .A1(n147), .A2(n140), .ZN(n61) );
  ND2D1BWP16P90LVT U40 ( .A1(n126), .A2(n64), .ZN(n46) );
  ND2D1BWP16P90LVT U43 ( .A1(n148), .A2(n159), .ZN(n64) );
  ND2D1BWP16P90LVT U48 ( .A1(n127), .A2(n69), .ZN(n47) );
  ND2D1BWP16P90LVT U68 ( .A1(n182), .A2(n191), .ZN(n80) );
  NR2D2BWP16P90LVT U90 ( .A1(n208), .A2(n213), .ZN(n93) );
  ND2D1BWP16P90LVT U99 ( .A1(n214), .A2(n219), .ZN(n99) );
  ND2D1BWP16P90LVT U116 ( .A1(n136), .A2(n110), .ZN(n56) );
  ND2D1BWP16P90LVT U119 ( .A1(n228), .A2(n229), .ZN(n110) );
  ND2D1BWP16P90LVT U124 ( .A1(n608), .A2(n115), .ZN(n57) );
  ND2D1BWP16P90LVT U127 ( .A1(n230), .A2(n293), .ZN(n115) );
  ND2D1BWP16P90LVT U133 ( .A1(n610), .A2(n121), .ZN(n58) );
  ND2D1BWP16P90LVT U136 ( .A1(n308), .A2(n294), .ZN(n121) );
  ND2D1BWP16P90LVT U142 ( .A1(n309), .A2(n238), .ZN(n124) );
  FA1D1BWP16P90LVT U152 ( .A(n167), .B(n165), .CI(n158), .CO(n151), .S(n152)
         );
  FA1D1BWP16P90LVT U153 ( .A(n296), .B(n282), .CI(n169), .CO(n153), .S(n154)
         );
  FA1D1BWP16P90LVT U155 ( .A(n240), .B(n242), .CI(n246), .CO(n157), .S(n158)
         );
  FA1D1BWP16P90LVT U159 ( .A(n297), .B(n271), .CI(n283), .CO(n165), .S(n166)
         );
  FA1D1BWP16P90LVT U160 ( .A(n232), .B(n253), .CI(n261), .CO(n167), .S(n168)
         );
  HA1D2BWP16P90LVT U161 ( .A(n247), .B(n243), .CO(n169), .S(n170) );
  FA1D1BWP16P90LVT U187 ( .A(n268), .B(n278), .CI(n304), .CO(n221), .S(n222)
         );
  HA1D2BWP16P90LVT U189 ( .A(n236), .B(n279), .CO(n225), .S(n226) );
  FA1D1BWP16P90LVT U190 ( .A(n280), .B(n292), .CI(n306), .CO(n227), .S(n228)
         );
  OAI22D1BWP16P90LVT U192 ( .A1(n312), .A2(n41), .B1(n42), .B2(n419), .ZN(n231) );
  OAI22D1BWP16P90LVT U193 ( .A1(n311), .A2(n42), .B1(n310), .B2(n41), .ZN(n239) );
  OAI22D1BWP16P90LVT U199 ( .A1(n39), .A2(n314), .B1(n313), .B2(n37), .ZN(n241) );
  OAI22D1BWP16P90LVT U226 ( .A1(n29), .A2(n329), .B1(n328), .B2(n545), .ZN(
        n254) );
  OAI22D1BWP16P90LVT U229 ( .A1(n332), .A2(n29), .B1(n331), .B2(n545), .ZN(
        n257) );
  OAI22D1BWP16P90LVT U240 ( .A1(n23), .A2(n550), .B1(n344), .B2(n489), .ZN(
        n235) );
  OAI22D1BWP16P90LVT U245 ( .A1(n622), .A2(n339), .B1(n338), .B2(n21), .ZN(
        n263) );
  OAI22D1BWP16P90LVT U247 ( .A1(n23), .A2(n341), .B1(n340), .B2(n489), .ZN(
        n265) );
  OAI22D1BWP16P90LVT U248 ( .A1(n622), .A2(n342), .B1(n341), .B2(n487), .ZN(
        n266) );
  OAI22D1BWP16P90LVT U266 ( .A1(n17), .A2(n349), .B1(n16), .B2(n348), .ZN(n272) );
  OAI22D1BWP16P90LVT U267 ( .A1(n559), .A2(n350), .B1(n16), .B2(n349), .ZN(
        n273) );
  OAI22D1BWP16P90LVT U272 ( .A1(n17), .A2(n355), .B1(n354), .B2(n16), .ZN(n278) );
  OAI22D1BWP16P90LVT U273 ( .A1(n356), .A2(n559), .B1(n355), .B2(n16), .ZN(
        n279) );
  OAI22D1BWP16P90LVT U291 ( .A1(n560), .A2(n361), .B1(n9), .B2(n360), .ZN(n283) );
  OAI22D1BWP16P90LVT U295 ( .A1(n12), .A2(n365), .B1(n9), .B2(n364), .ZN(n287)
         );
  OAI22D1BWP16P90LVT U318 ( .A1(n547), .A2(n485), .B1(n389), .B2(n418), .ZN(
        n238) );
  OAI22D1BWP16P90LVT U319 ( .A1(n534), .A2(n374), .B1(n373), .B2(n418), .ZN(
        n295) );
  OAI22D1BWP16P90LVT U320 ( .A1(n6), .A2(n375), .B1(n374), .B2(n418), .ZN(n296) );
  OAI22D1BWP16P90LVT U322 ( .A1(n534), .A2(n377), .B1(n376), .B2(n418), .ZN(
        n298) );
  OAI22D1BWP16P90LVT U323 ( .A1(n619), .A2(n378), .B1(n377), .B2(n418), .ZN(
        n299) );
  OAI22D1BWP16P90LVT U325 ( .A1(n534), .A2(n380), .B1(n379), .B2(n418), .ZN(
        n301) );
  OAI22D1BWP16P90LVT U328 ( .A1(n618), .A2(n383), .B1(n382), .B2(n418), .ZN(
        n304) );
  OAI22D1BWP16P90LVT U329 ( .A1(n548), .A2(n384), .B1(n383), .B2(n418), .ZN(
        n305) );
  OAI22D1BWP16P90LVT U330 ( .A1(n548), .A2(n385), .B1(n384), .B2(n418), .ZN(
        n306) );
  OAI22D1BWP16P90LVT U331 ( .A1(n618), .A2(n386), .B1(n385), .B2(n418), .ZN(
        n307) );
  OAI22D1BWP16P90LVT U332 ( .A1(n534), .A2(n387), .B1(n386), .B2(n418), .ZN(
        n308) );
  OAI22D1BWP16P90LVT U333 ( .A1(n388), .A2(n534), .B1(n387), .B2(n418), .ZN(
        n309) );
  XOR2D2BWP16P90LVT U393 ( .A1(n221), .A2(n218), .Z(n528) );
  XOR2D1BWP16P90 U394 ( .A1(n596), .A2(n48), .Z(product[12]) );
  CKND2BWP16P90LVT U395 ( .I(n107), .ZN(n105) );
  HA1D1BWP16P90LVT U396 ( .A(n235), .B(n267), .CO(n217), .S(n218) );
  XOR2D2BWP16P90LVT U397 ( .A1(n587), .A2(n256), .Z(n198) );
  XNR2D2BWP16P90LVT U398 ( .A1(b[2]), .A2(n538), .ZN(n354) );
  XNR2D2BWP16P90 U399 ( .A1(n532), .A2(b[4]), .ZN(n367) );
  XNR2D2BWP16P90 U400 ( .A1(n532), .A2(b[8]), .ZN(n363) );
  XNR2D2BWP16P90 U401 ( .A1(n532), .A2(b[3]), .ZN(n368) );
  XNR2D2BWP16P90 U402 ( .A1(n532), .A2(b[1]), .ZN(n370) );
  XOR2D4BWP16P90LVT U403 ( .A1(n523), .A2(n222), .Z(n220) );
  XNR2D1BWP16P90 U404 ( .A1(n51), .A2(n578), .ZN(product[9]) );
  OAI21D2BWP16P90LVT U405 ( .A1(n596), .A2(n71), .B(n72), .ZN(n70) );
  ND2D4BWP16P90LVT U406 ( .A1(n27), .A2(n409), .ZN(n29) );
  OAI21D2BWP16P90LVT U407 ( .A1(n68), .A2(n72), .B(n69), .ZN(n67) );
  ND2D2BWP16P90LVT U408 ( .A1(n172), .A2(n181), .ZN(n72) );
  ND2D1BWP16P90 U409 ( .A1(n256), .A2(n264), .ZN(n588) );
  ND3D2BWP16P90LVT U410 ( .A1(n565), .A2(n566), .A3(n567), .ZN(n193) );
  OAI22D2BWP16P90LVT U411 ( .A1(n573), .A2(n322), .B1(n321), .B2(n32), .ZN(
        n248) );
  XNR2D2BWP16P90 U412 ( .A1(b[4]), .A2(n636), .ZN(n319) );
  XOR3D4BWP16P90LVT U413 ( .A1(n231), .A2(n245), .A3(n251), .Z(n145) );
  OAI22D1BWP16P90LVT U414 ( .A1(n560), .A2(n425), .B1(n372), .B2(n9), .ZN(n237) );
  AO21D4BWP16P90LVT U415 ( .A1(n578), .A2(n599), .B(n572), .Z(n574) );
  XNR2D2BWP16P90 U416 ( .A1(n532), .A2(b[5]), .ZN(n366) );
  XOR2D2BWP16P90LVT U417 ( .A1(n497), .A2(n217), .Z(n210) );
  XNR2D2BWP16P90LVT U418 ( .A1(n532), .A2(b[6]), .ZN(n365) );
  XNR2D2BWP16P90LVT U419 ( .A1(n532), .A2(b[7]), .ZN(n364) );
  XNR2D2BWP16P90LVT U420 ( .A1(n532), .A2(b[12]), .ZN(n359) );
  XNR2D2BWP16P90 U421 ( .A1(n532), .A2(b[13]), .ZN(n358) );
  XNR2D2BWP16P90 U422 ( .A1(n532), .A2(b[2]), .ZN(n369) );
  ND3D2BWP16P90LVT U423 ( .A1(n554), .A2(n555), .A3(n556), .ZN(n171) );
  CKBD8BWP16P90LVT U424 ( .I(b[0]), .Z(n637) );
  XNR2D1BWP16P90LVT U425 ( .A1(n637), .A2(n635), .ZN(n332) );
  XNR2D1BWP16P90LVT U426 ( .A1(n637), .A2(a[13]), .ZN(n316) );
  INVD1BWP16P90 U427 ( .I(n637), .ZN(n549) );
  IND2D1BWP16P90LVT U428 ( .A1(n637), .B1(n634), .ZN(n344) );
  XOR2D2BWP16P90LVT U429 ( .A1(n632), .A2(a[2]), .Z(n412) );
  OAI22D1BWP16P90LVT U430 ( .A1(n316), .A2(n39), .B1(n315), .B2(n37), .ZN(n243) );
  ND3D1BWP16P90LVT U431 ( .A1(n503), .A2(n504), .A3(n505), .ZN(n215) );
  OR2D1BWP16P90LVT U432 ( .A1(n29), .A2(n422), .Z(n562) );
  XNR2D1BWP16P90 U433 ( .A1(b[3]), .A2(n636), .ZN(n320) );
  ND2D2BWP16P90LVT U434 ( .A1(n511), .A2(n512), .ZN(n284) );
  OR2D1BWP16P90LVT U435 ( .A1(n12), .A2(n362), .Z(n511) );
  CKND2D1BWP16P90LVT U436 ( .A1(n9), .A2(n412), .ZN(n560) );
  ND2D1BWP16P90LVT U437 ( .A1(n16), .A2(n411), .ZN(n559) );
  ND2D1BWP16P90LVT U438 ( .A1(n16), .A2(n411), .ZN(n620) );
  ND2D1BWP16P90LVT U439 ( .A1(n16), .A2(n411), .ZN(n17) );
  ND2D1BWP16P90LVT U440 ( .A1(n413), .A2(n418), .ZN(n618) );
  ND2D1BWP16P90LVT U441 ( .A1(n197), .A2(n195), .ZN(n625) );
  XNR2D1BWP16P90 U442 ( .A1(n532), .A2(b[11]), .ZN(n360) );
  XNR2D1BWP16P90 U443 ( .A1(n538), .A2(b[9]), .ZN(n347) );
  CKND1BWP16P90LVT U444 ( .I(a[10]), .ZN(n569) );
  XNR2D1BWP16P90LVT U445 ( .A1(b[6]), .A2(n635), .ZN(n326) );
  CKND1BWP16P90LVT U446 ( .I(n488), .ZN(n489) );
  XOR2D1BWP16P90LVT U447 ( .A1(n528), .A2(n216), .Z(n214) );
  ND3D2BWP16P90LVT U448 ( .A1(n628), .A2(n629), .A3(n630), .ZN(n181) );
  OR2D1BWP16P90LVT U449 ( .A1(n502), .A2(n227), .Z(n606) );
  OR2D1BWP16P90LVT U450 ( .A1(n214), .A2(n219), .Z(n607) );
  CKND1BWP16P90LVT U451 ( .I(n99), .ZN(n97) );
  XOR2D1BWP16P90LVT U452 ( .A1(n518), .A2(n522), .Z(n200) );
  XOR2D1BWP16P90LVT U453 ( .A1(n204), .A2(n209), .Z(n518) );
  XNR2D1BWP16P90LVT U454 ( .A1(b[1]), .A2(n636), .ZN(n322) );
  XNR2D1BWP16P90LVT U455 ( .A1(b[3]), .A2(a[9]), .ZN(n329) );
  OR2D1BWP16P90LVT U456 ( .A1(n378), .A2(n418), .Z(n577) );
  XNR2D1BWP16P90LVT U457 ( .A1(n538), .A2(b[5]), .ZN(n351) );
  XNR2D1BWP16P90LVT U458 ( .A1(n538), .A2(b[6]), .ZN(n350) );
  XNR2D1BWP16P90LVT U459 ( .A1(n601), .A2(b[10]), .ZN(n378) );
  XNR2D1BWP16P90LVT U460 ( .A1(b[2]), .A2(n636), .ZN(n321) );
  XNR2D1BWP16P90LVT U461 ( .A1(b[4]), .A2(a[9]), .ZN(n328) );
  XNR2D1BWP16P90LVT U462 ( .A1(n601), .A2(b[11]), .ZN(n377) );
  XNR2D1BWP16P90LVT U463 ( .A1(n538), .A2(b[4]), .ZN(n352) );
  XNR2D1BWP16P90LVT U464 ( .A1(b[3]), .A2(n538), .ZN(n353) );
  XNR2D1BWP16P90LVT U465 ( .A1(n601), .A2(b[5]), .ZN(n383) );
  CKND2D1BWP16P90LVT U466 ( .A1(n562), .A2(n563), .ZN(n234) );
  OR2D1BWP16P90LVT U467 ( .A1(n333), .A2(n545), .Z(n563) );
  CKNR2D1BWP16P90LVT U468 ( .A1(n621), .A2(n352), .ZN(n535) );
  XNR2D1BWP16P90LVT U469 ( .A1(b[2]), .A2(n517), .ZN(n341) );
  ND2D2BWP16P90LVT U470 ( .A1(n9), .A2(n412), .ZN(n12) );
  ND2D1BWP16P90LVT U471 ( .A1(n9), .A2(n412), .ZN(n561) );
  XNR2D1BWP16P90LVT U472 ( .A1(n634), .A2(b[7]), .ZN(n336) );
  XNR2D1BWP16P90LVT U473 ( .A1(b[5]), .A2(n635), .ZN(n327) );
  XNR2D1BWP16P90LVT U474 ( .A1(n538), .A2(b[10]), .ZN(n346) );
  XNR2D1BWP16P90LVT U475 ( .A1(n538), .A2(b[11]), .ZN(n345) );
  XNR2D1BWP16P90LVT U476 ( .A1(n634), .A2(b[8]), .ZN(n335) );
  XNR2D1BWP16P90LVT U477 ( .A1(n601), .A2(b[15]), .ZN(n373) );
  INR2D1BWP16P90LVT U478 ( .A1(n637), .B1(n41), .ZN(n240) );
  OAI22D1BWP16P90LVT U479 ( .A1(n6), .A2(n376), .B1(n375), .B2(n418), .ZN(n297) );
  BUFFD1BWP16P90LVT U480 ( .I(n162), .Z(n501) );
  FA1D1BWP16P90LVT U481 ( .A(n170), .B(n179), .CI(n177), .CO(n163), .S(n164)
         );
  ND3D1BWP16P90LVT U482 ( .A1(n508), .A2(n509), .A3(n510), .ZN(n177) );
  OAI22D1BWP16P90LVT U483 ( .A1(n620), .A2(n424), .B1(n357), .B2(n16), .ZN(
        n236) );
  ND2D1BWP16P90LVT U484 ( .A1(n597), .A2(n598), .ZN(n303) );
  XOR2D1BWP16P90LVT U485 ( .A1(n288), .A2(n302), .Z(n497) );
  OR2D1BWP16P90LVT U486 ( .A1(n543), .A2(n544), .Z(n267) );
  AN2D1BWP16P90LVT U487 ( .A1(n192), .A2(n199), .Z(n602) );
  AOI21D1BWP16P90LVT U488 ( .A1(n608), .A2(n604), .B(n113), .ZN(n111) );
  ND2D1BWP16P90LVT U489 ( .A1(n224), .A2(n227), .ZN(n107) );
  NR2D1BWP16P90LVT U490 ( .A1(n148), .A2(n159), .ZN(n63) );
  CKND1BWP16P90LVT U491 ( .I(n59), .ZN(product[1]) );
  XOR2D1BWP16P90LVT U492 ( .A1(n54), .A2(n533), .Z(product[6]) );
  OR2D1BWP16P90LVT U493 ( .A1(n208), .A2(n213), .Z(n527) );
  CKND1BWP16P90LVT U494 ( .I(a[1]), .ZN(n485) );
  CKND1BWP16P90LVT U495 ( .I(n634), .ZN(n550) );
  INR2D1BWP20P90LVT U496 ( .A1(n637), .B1(n32), .ZN(n250) );
  ND2D1BWP16P90LVT U497 ( .A1(n16), .A2(n411), .ZN(n507) );
  OAI22D1BWP16P90LVT U498 ( .A1(n507), .A2(n351), .B1(n16), .B2(n350), .ZN(
        n274) );
  INVD2BWP16P90LVT U499 ( .I(n631), .ZN(n579) );
  XOR2D4BWP16P90LVT U500 ( .A1(n611), .A2(n162), .Z(n160) );
  ND2D1BWP16P90LVT U501 ( .A1(n203), .A2(n205), .ZN(n567) );
  BUFFD2BWP16P90LVT U502 ( .I(n21), .Z(n486) );
  XOR2D1BWP16P90LVT U503 ( .A1(n196), .A2(n201), .Z(n513) );
  FA1D2BWP16P90LVT U504 ( .A(n301), .B(n206), .CI(n211), .CO(n201), .S(n202)
         );
  XOR2D2BWP16P90LVT U505 ( .A1(n164), .A2(n173), .Z(n611) );
  XNR2D1BWP16P90LVT U506 ( .A1(n532), .A2(b[10]), .ZN(n361) );
  XNR2D1BWP16P90LVT U507 ( .A1(n532), .A2(b[9]), .ZN(n362) );
  XNR2D1BWP16P90LVT U508 ( .A1(b[4]), .A2(a[7]), .ZN(n339) );
  BUFFD2BWP16P90LVT U509 ( .I(n21), .Z(n487) );
  XOR2D4BWP16P90LVT U510 ( .A1(n183), .A2(n176), .Z(n553) );
  XNR2D1BWP16P90LVT U511 ( .A1(n623), .A2(b[4]), .ZN(n384) );
  XNR2D1BWP16P90LVT U512 ( .A1(n623), .A2(b[12]), .ZN(n376) );
  XNR2D1BWP16P90LVT U513 ( .A1(n623), .A2(b[9]), .ZN(n379) );
  XNR2D1BWP16P90LVT U514 ( .A1(n623), .A2(b[8]), .ZN(n380) );
  XNR2D1BWP16P90LVT U515 ( .A1(n623), .A2(b[3]), .ZN(n385) );
  XNR2D1BWP16P90LVT U516 ( .A1(n623), .A2(b[2]), .ZN(n386) );
  NR2D1BWP16P90 U517 ( .A1(n351), .A2(n16), .ZN(n536) );
  XNR2D2BWP16P90 U518 ( .A1(b[1]), .A2(a[9]), .ZN(n331) );
  ND2D1BWP16P90LVT U519 ( .A1(a[9]), .A2(a[10]), .ZN(n570) );
  INVD1BWP16P90LVT U520 ( .I(n21), .ZN(n488) );
  XOR2D4BWP16P90LVT U521 ( .A1(n631), .A2(a[0]), .Z(n413) );
  OAI22D1BWP16P90 U522 ( .A1(n561), .A2(n360), .B1(n9), .B2(n359), .ZN(n282)
         );
  OAI22D1BWP16P90 U523 ( .A1(n371), .A2(n12), .B1(n370), .B2(n9), .ZN(n293) );
  OAI22D2BWP16P90LVT U524 ( .A1(n23), .A2(n338), .B1(n337), .B2(n486), .ZN(
        n262) );
  BUFFD4BWP16P90LVT U525 ( .I(a[3]), .Z(n532) );
  XNR2D4BWP16P90LVT U526 ( .A1(b[5]), .A2(n517), .ZN(n338) );
  CKND2D1BWP16P90LVT U527 ( .A1(n32), .A2(n408), .ZN(n34) );
  XOR2D4BWP16P90LVT U528 ( .A1(n205), .A2(n203), .Z(n564) );
  OR2D2BWP16P90LVT U529 ( .A1(a[7]), .A2(a[8]), .Z(n558) );
  XOR3D4BWP16P90LVT U530 ( .A1(n156), .A2(n163), .A3(n154), .Z(n150) );
  XOR2D1BWP16P90LVT U531 ( .A1(n152), .A2(n161), .Z(n490) );
  XOR2D1BWP16P90LVT U532 ( .A1(n490), .A2(n150), .Z(n148) );
  ND2D1BWP16P90LVT U533 ( .A1(n156), .A2(n163), .ZN(n491) );
  ND2D1BWP16P90LVT U534 ( .A1(n156), .A2(n154), .ZN(n492) );
  ND2D1BWP16P90LVT U535 ( .A1(n163), .A2(n154), .ZN(n493) );
  ND3D1BWP16P90LVT U536 ( .A1(n491), .A2(n492), .A3(n493), .ZN(n149) );
  ND2D1BWP16P90LVT U537 ( .A1(n152), .A2(n161), .ZN(n494) );
  ND2D1BWP16P90 U538 ( .A1(n152), .A2(n150), .ZN(n495) );
  ND2D1BWP16P90LVT U539 ( .A1(n161), .A2(n150), .ZN(n496) );
  ND3D1BWP16P90LVT U540 ( .A1(n494), .A2(n495), .A3(n496), .ZN(n147) );
  FA1D1BWP16P90LVT U541 ( .A(n252), .B(n260), .CI(n270), .CO(n155), .S(n156)
         );
  XNR2D1BWP16P90LVT U542 ( .A1(n623), .A2(b[14]), .ZN(n374) );
  ND2D2BWP16P90LVT U543 ( .A1(n605), .A2(n603), .ZN(n75) );
  AOI21D2BWP16P90LVT U544 ( .A1(n605), .A2(n602), .B(n78), .ZN(n76) );
  ND2D1BWP16P90 U545 ( .A1(n605), .A2(n80), .ZN(n49) );
  XNR2D2BWP16P90LVT U546 ( .A1(n517), .A2(b[6]), .ZN(n337) );
  ND2D1BWP16P90 U547 ( .A1(n217), .A2(n302), .ZN(n498) );
  ND2D1BWP16P90 U548 ( .A1(n217), .A2(n288), .ZN(n499) );
  ND2D1BWP16P90 U549 ( .A1(n302), .A2(n288), .ZN(n500) );
  ND3D1BWP16P90LVT U550 ( .A1(n498), .A2(n499), .A3(n500), .ZN(n209) );
  XOR3D4BWP16P90LVT U551 ( .A1(n204), .A2(n209), .A3(n202), .Z(n615) );
  FA1D1BWP16P90LVT U552 ( .A(n215), .B(n212), .CI(n210), .CO(n207), .S(n208)
         );
  ND2D1BWP16P90LVT U553 ( .A1(n591), .A2(a[6]), .ZN(n594) );
  CKND2BWP16P90LVT U554 ( .I(a[6]), .ZN(n592) );
  ND2D1BWP16P90LVT U555 ( .A1(n272), .A2(n262), .ZN(n510) );
  XOR3D1BWP16P90LVT U556 ( .A1(n305), .A2(n291), .A3(n226), .Z(n502) );
  OAI22D1BWP16P90 U557 ( .A1(n29), .A2(n326), .B1(n325), .B2(n545), .ZN(n251)
         );
  ND2D1BWP16P90 U558 ( .A1(n264), .A2(n250), .ZN(n590) );
  XOR3D4BWP16P90LVT U559 ( .A1(n277), .A2(n303), .A3(n289), .Z(n216) );
  ND2D1BWP16P90 U560 ( .A1(n303), .A2(n289), .ZN(n503) );
  ND2D1BWP16P90 U561 ( .A1(n303), .A2(n277), .ZN(n504) );
  ND2D1BWP16P90LVT U562 ( .A1(n289), .A2(n277), .ZN(n505) );
  CKND2D4BWP16P90LVT U563 ( .A1(n21), .A2(n410), .ZN(n23) );
  OAI21D1BWP16P90 U564 ( .A1(n109), .A2(n111), .B(n110), .ZN(n506) );
  OAI21D1BWP16P90LVT U565 ( .A1(n109), .A2(n111), .B(n110), .ZN(n108) );
  OAI22D1BWP16P90 U566 ( .A1(n23), .A2(n336), .B1(n335), .B2(n486), .ZN(n260)
         );
  OAI22D1BWP16P90LVT U567 ( .A1(n23), .A2(n335), .B1(n334), .B2(n489), .ZN(
        n259) );
  OAI22D1BWP16P90LVT U568 ( .A1(n621), .A2(n348), .B1(n16), .B2(n347), .ZN(
        n271) );
  BUFFD4BWP16P90LVT U569 ( .I(a[9]), .Z(n635) );
  XNR2D2BWP16P90LVT U570 ( .A1(b[2]), .A2(a[9]), .ZN(n330) );
  XOR2D4BWP16P90LVT U571 ( .A1(n624), .A2(n184), .Z(n182) );
  OR2D2BWP16P90LVT U572 ( .A1(n615), .A2(n207), .Z(n599) );
  ND2D1BWP16P90 U573 ( .A1(n527), .A2(n94), .ZN(n52) );
  ND2D1BWP16P90LVT U574 ( .A1(n174), .A2(n176), .ZN(n554) );
  XOR3D4BWP16P90LVT U575 ( .A1(n262), .A2(n284), .A3(n272), .Z(n178) );
  ND2D1BWP16P90LVT U576 ( .A1(n284), .A2(n272), .ZN(n508) );
  ND2D1BWP16P90LVT U577 ( .A1(n284), .A2(n262), .ZN(n509) );
  OR2D2BWP16P90LVT U578 ( .A1(n9), .A2(n361), .Z(n512) );
  XOR2D1BWP16P90LVT U579 ( .A1(n513), .A2(n194), .Z(n192) );
  ND2D1BWP16P90LVT U580 ( .A1(n194), .A2(n201), .ZN(n514) );
  ND2D1BWP16P90LVT U581 ( .A1(n194), .A2(n196), .ZN(n515) );
  ND2D1BWP16P90 U582 ( .A1(n201), .A2(n196), .ZN(n516) );
  ND3D1BWP16P90LVT U583 ( .A1(n514), .A2(n515), .A3(n516), .ZN(n191) );
  XOR2D2BWP16P90LVT U584 ( .A1(n564), .A2(n198), .Z(n194) );
  CKND2D4BWP16P90LVT U585 ( .A1(n21), .A2(n410), .ZN(n622) );
  OAI22D1BWP16P90 U586 ( .A1(n23), .A2(n337), .B1(n336), .B2(n21), .ZN(n261)
         );
  BUFFD4BWP16P90LVT U587 ( .I(a[7]), .Z(n517) );
  HA1D1BWP16P90LVT U588 ( .A(n307), .B(n237), .CO(n229), .S(n230) );
  ND2D8BWP16P90LVT U589 ( .A1(n581), .A2(n582), .ZN(n9) );
  CKND2D2BWP16P90LVT U590 ( .A1(n32), .A2(n408), .ZN(n573) );
  OAI22D1BWP16P90 U591 ( .A1(n29), .A2(n327), .B1(n326), .B2(n545), .ZN(n252)
         );
  FA1D2BWP16P90LVT U592 ( .A(n258), .B(n266), .CI(n276), .CO(n211), .S(n212)
         );
  CKND2D2BWP16P90LVT U593 ( .A1(n16), .A2(n411), .ZN(n621) );
  ND2D1BWP16P90 U594 ( .A1(n522), .A2(n209), .ZN(n519) );
  ND2D1BWP16P90 U595 ( .A1(n522), .A2(n204), .ZN(n520) );
  ND2D1BWP16P90 U596 ( .A1(n209), .A2(n204), .ZN(n521) );
  ND3D1BWP16P90LVT U597 ( .A1(n519), .A2(n520), .A3(n521), .ZN(n199) );
  XOR3D2BWP16P90LVT U598 ( .A1(n301), .A2(n206), .A3(n211), .Z(n522) );
  ND2D1BWP16P90LVT U599 ( .A1(n200), .A2(n207), .ZN(n91) );
  NR2D1BWP16P90LVT U600 ( .A1(n622), .A2(n343), .ZN(n543) );
  XOR2D1BWP16P90LVT U601 ( .A1(n290), .A2(n225), .Z(n523) );
  ND2D1BWP16P90LVT U602 ( .A1(n222), .A2(n225), .ZN(n524) );
  ND2D1BWP16P90LVT U603 ( .A1(n222), .A2(n290), .ZN(n525) );
  ND2D1BWP16P90LVT U604 ( .A1(n225), .A2(n290), .ZN(n526) );
  ND3D1BWP16P90LVT U605 ( .A1(n524), .A2(n525), .A3(n526), .ZN(n219) );
  OAI22D1BWP16P90 U606 ( .A1(n561), .A2(n368), .B1(n9), .B2(n367), .ZN(n290)
         );
  INVD1BWP16P90LVT U607 ( .I(n636), .ZN(n539) );
  ND2D1BWP16P90LVT U608 ( .A1(n636), .A2(a[12]), .ZN(n541) );
  XOR2D2BWP16P90LVT U609 ( .A1(n636), .A2(a[10]), .Z(n408) );
  XNR2D2BWP16P90LVT U610 ( .A1(b[3]), .A2(n517), .ZN(n340) );
  XNR2D2BWP16P90LVT U611 ( .A1(n637), .A2(n636), .ZN(n323) );
  ND2D1BWP16P90 U612 ( .A1(n176), .A2(n183), .ZN(n556) );
  CKNR2D4BWP16P90LVT U613 ( .A1(n172), .A2(n181), .ZN(n71) );
  OAI22D1BWP16P90 U614 ( .A1(n29), .A2(n328), .B1(n327), .B2(n545), .ZN(n253)
         );
  XNR2D2BWP16P90LVT U615 ( .A1(b[1]), .A2(n517), .ZN(n342) );
  CKND2D4BWP16P90LVT U616 ( .A1(n485), .A2(n580), .ZN(n582) );
  ND2D2BWP16P90LVT U617 ( .A1(n631), .A2(a[2]), .ZN(n581) );
  XNR2D2BWP16P90LVT U618 ( .A1(n601), .A2(b[13]), .ZN(n375) );
  ND2D1BWP16P90LVT U619 ( .A1(n198), .A2(n203), .ZN(n565) );
  XNR2D2BWP16P90LVT U620 ( .A1(n637), .A2(n538), .ZN(n356) );
  INR2D1BWP16P90 U621 ( .A1(n637), .B1(n487), .ZN(n268) );
  ND3D4BWP16P90LVT U622 ( .A1(n625), .A2(n626), .A3(n627), .ZN(n183) );
  ND2D1BWP16P90LVT U623 ( .A1(n216), .A2(n218), .ZN(n529) );
  ND2D1BWP16P90 U624 ( .A1(n216), .A2(n221), .ZN(n530) );
  ND2D1BWP16P90 U625 ( .A1(n218), .A2(n221), .ZN(n531) );
  ND3D1BWP16P90LVT U626 ( .A1(n529), .A2(n530), .A3(n531), .ZN(n213) );
  ND2D2BWP16P90LVT U627 ( .A1(n208), .A2(n213), .ZN(n94) );
  ND2D1BWP16P90 U628 ( .A1(n607), .A2(n99), .ZN(n53) );
  OAI22D1BWP16P90LVT U629 ( .A1(n34), .A2(n539), .B1(n324), .B2(n32), .ZN(n233) );
  OAI21D1BWP16P90LVT U630 ( .A1(n546), .A2(n93), .B(n94), .ZN(n578) );
  AOI21D1BWP16P90 U631 ( .A1(n606), .A2(n506), .B(n105), .ZN(n533) );
  BUFFD4BWP16P90LVT U632 ( .I(a[3]), .Z(n632) );
  AOI21D2BWP16P90LVT U633 ( .A1(n606), .A2(n108), .B(n105), .ZN(n103) );
  XOR2D4BWP16P90LVT U634 ( .A1(a[4]), .A2(n633), .Z(n411) );
  ND2D2BWP16P90LVT U635 ( .A1(n557), .A2(n558), .ZN(n27) );
  ND2D1BWP20P90LVT U636 ( .A1(n41), .A2(n406), .ZN(n42) );
  XNR2D2BWP16P90LVT U637 ( .A1(a[13]), .A2(a[14]), .ZN(n41) );
  INVD1BWP16P90LVT U638 ( .I(n91), .ZN(n89) );
  ND2D1BWP16P90LVT U639 ( .A1(n174), .A2(n183), .ZN(n555) );
  XNR2D2BWP16P90 U640 ( .A1(n637), .A2(n532), .ZN(n371) );
  XNR2D2BWP16P90LVT U641 ( .A1(n538), .A2(b[7]), .ZN(n349) );
  XNR2D2BWP16P90LVT U642 ( .A1(b[1]), .A2(n538), .ZN(n355) );
  OR2D2BWP16P90LVT U643 ( .A1(n182), .A2(n191), .Z(n605) );
  NR2D1BWP16P90LVT U644 ( .A1(n342), .A2(n487), .ZN(n544) );
  OAI22D1BWP16P90LVT U645 ( .A1(n547), .A2(n381), .B1(n380), .B2(n418), .ZN(
        n302) );
  XNR2D2BWP16P90LVT U646 ( .A1(n538), .A2(b[8]), .ZN(n348) );
  HA1D2BWP16P90LVT U647 ( .A(n234), .B(n257), .CO(n205), .S(n206) );
  FA1D2BWP16P90LVT U648 ( .A(n244), .B(n248), .CI(n254), .CO(n179), .S(n180)
         );
  OR2D2BWP16P90LVT U649 ( .A1(n192), .A2(n199), .Z(n603) );
  XOR2D4BWP16P90LVT U650 ( .A1(n250), .A2(n264), .Z(n587) );
  OAI22D2BWP16P90LVT U651 ( .A1(n622), .A2(n340), .B1(n339), .B2(n21), .ZN(
        n264) );
  FA1D2BWP16P90LVT U652 ( .A(n305), .B(n291), .CI(n226), .CO(n223), .S(n224)
         );
  OAI21D2BWP16P90LVT U653 ( .A1(n101), .A2(n103), .B(n102), .ZN(n100) );
  OA21D2BWP16P90LVT U654 ( .A1(n75), .A2(n586), .B(n76), .Z(n596) );
  OAI21D2BWP16P90LVT U655 ( .A1(n87), .A2(n75), .B(n76), .ZN(n74) );
  ND2D1BWP16P90LVT U656 ( .A1(a[7]), .A2(a[8]), .ZN(n557) );
  INVD1BWP16P90LVT U657 ( .I(a[7]), .ZN(n591) );
  XOR2D2BWP16P90LVT U658 ( .A1(a[9]), .A2(a[8]), .Z(n409) );
  INVD1BWP16P90LVT U659 ( .I(a[9]), .ZN(n568) );
  HA1D1BWP16P90LVT U660 ( .A(n255), .B(n249), .CO(n189), .S(n190) );
  OAI22D2BWP16P90LVT U661 ( .A1(n29), .A2(n330), .B1(n329), .B2(n545), .ZN(
        n255) );
  ND2D1BWP16P90LVT U662 ( .A1(n413), .A2(n418), .ZN(n534) );
  OR2D2BWP16P90LVT U663 ( .A1(n535), .A2(n536), .Z(n275) );
  ND3D1BWP16P90 U664 ( .A1(n565), .A2(n566), .A3(n567), .ZN(n537) );
  BUFFD4BWP16P90LVT U665 ( .I(a[5]), .Z(n538) );
  BUFFD4BWP16P90LVT U666 ( .I(a[5]), .Z(n633) );
  INVD1BWP16P90 U667 ( .I(n101), .ZN(n134) );
  ND2D2BWP16P90LVT U668 ( .A1(n539), .A2(n540), .ZN(n542) );
  ND2D2BWP16P90LVT U669 ( .A1(n541), .A2(n542), .ZN(n37) );
  CKND1BWP16P90LVT U670 ( .I(a[12]), .ZN(n540) );
  BUFFD4BWP16P90LVT U671 ( .I(a[11]), .Z(n636) );
  OAI22D1BWP16P90LVT U672 ( .A1(n39), .A2(n315), .B1(n314), .B2(n37), .ZN(n242) );
  CKND2D4BWP16P90LVT U673 ( .A1(n37), .A2(n407), .ZN(n39) );
  XOR3D4BWP16P90LVT U674 ( .A1(n197), .A2(n195), .A3(n188), .Z(n184) );
  FA1D2BWP16P90LVT U675 ( .A(n274), .B(n300), .CI(n286), .CO(n195), .S(n196)
         );
  ND2D2BWP16P90LVT U676 ( .A1(n557), .A2(n558), .ZN(n545) );
  AOI21D1BWP16P90LVT U677 ( .A1(n100), .A2(n607), .B(n97), .ZN(n546) );
  ND2D1BWP16P90 U678 ( .A1(n413), .A2(n418), .ZN(n547) );
  ND2D1BWP16P90 U679 ( .A1(n413), .A2(n418), .ZN(n548) );
  ND2D1BWP16P90 U680 ( .A1(n413), .A2(n418), .ZN(n619) );
  ND2D1BWP16P90 U681 ( .A1(n637), .A2(n634), .ZN(n551) );
  ND2D1BWP16P90LVT U682 ( .A1(n549), .A2(n550), .ZN(n552) );
  ND2D1BWP16P90LVT U683 ( .A1(n551), .A2(n552), .ZN(n343) );
  BUFFD2BWP16P90LVT U684 ( .I(a[7]), .Z(n634) );
  FA1D2BWP16P90LVT U685 ( .A(n275), .B(n265), .CI(n287), .CO(n203), .S(n204)
         );
  XOR2D4BWP16P90LVT U686 ( .A1(n553), .A2(n174), .Z(n172) );
  FA1D2BWP16P90LVT U687 ( .A(n298), .B(n189), .CI(n187), .CO(n175), .S(n176)
         );
  FA1D2BWP16P90LVT U688 ( .A(n180), .B(n178), .CI(n185), .CO(n173), .S(n174)
         );
  NR2D2BWP16P90LVT U689 ( .A1(n160), .A2(n171), .ZN(n68) );
  INR2D1BWP16P90LVT U690 ( .A1(n637), .B1(n545), .ZN(n258) );
  OAI22D1BWP16P90LVT U691 ( .A1(n29), .A2(n331), .B1(n330), .B2(n545), .ZN(
        n256) );
  INVD1BWP16P90LVT U692 ( .I(n91), .ZN(n572) );
  ND2D1BWP16P90LVT U693 ( .A1(n198), .A2(n205), .ZN(n566) );
  ND2D1BWP16P90LVT U694 ( .A1(n537), .A2(n184), .ZN(n630) );
  XOR2D4BWP16P90LVT U695 ( .A1(n186), .A2(n193), .Z(n624) );
  ND2D2BWP16P90LVT U696 ( .A1(n568), .A2(n569), .ZN(n571) );
  ND2D4BWP16P90LVT U697 ( .A1(n570), .A2(n571), .ZN(n32) );
  OAI22D1BWP16P90LVT U698 ( .A1(n573), .A2(n321), .B1(n320), .B2(n32), .ZN(
        n247) );
  OAI22D1BWP16P90LVT U699 ( .A1(n573), .A2(n319), .B1(n318), .B2(n32), .ZN(
        n245) );
  OAI22D1BWP16P90LVT U700 ( .A1(n573), .A2(n320), .B1(n319), .B2(n32), .ZN(
        n246) );
  INVD1BWP16P90 U701 ( .I(a[2]), .ZN(n580) );
  INVD1BWP16P90LVT U702 ( .I(n602), .ZN(n617) );
  ND2D2BWP16P90LVT U703 ( .A1(n576), .A2(n577), .ZN(n300) );
  OAI22D1BWP16P90LVT U704 ( .A1(n17), .A2(n353), .B1(n352), .B2(n16), .ZN(n276) );
  OR2D1BWP16P90LVT U705 ( .A1(n619), .A2(n379), .Z(n576) );
  XNR2D8BWP16P90LVT U706 ( .A1(n633), .A2(a[6]), .ZN(n21) );
  ND2D1BWP16P90LVT U707 ( .A1(n128), .A2(n72), .ZN(n48) );
  OAI21D1BWP16P90 U708 ( .A1(n101), .A2(n533), .B(n102), .ZN(n575) );
  INVD2BWP16P90LVT U709 ( .I(a[0]), .ZN(n418) );
  OR2D1BWP16P90LVT U710 ( .A1(n381), .A2(n418), .Z(n598) );
  OR2D1BWP16P90LVT U711 ( .A1(n618), .A2(n382), .Z(n597) );
  OAI22D1BWP16P90LVT U712 ( .A1(n561), .A2(n363), .B1(n9), .B2(n362), .ZN(n285) );
  OAI22D1BWP16P90LVT U713 ( .A1(n560), .A2(n366), .B1(n9), .B2(n365), .ZN(n288) );
  OAI22D1BWP16P90LVT U714 ( .A1(n560), .A2(n359), .B1(n9), .B2(n358), .ZN(n281) );
  OAI22D1BWP16P90LVT U715 ( .A1(n561), .A2(n364), .B1(n9), .B2(n363), .ZN(n286) );
  OAI22D1BWP16P90LVT U716 ( .A1(n561), .A2(n370), .B1(n369), .B2(n9), .ZN(n292) );
  OAI22D1BWP16P90LVT U717 ( .A1(n561), .A2(n369), .B1(n368), .B2(n9), .ZN(n291) );
  XNR2D1BWP16P90 U718 ( .A1(n574), .A2(n50), .ZN(product[10]) );
  OAI21D1BWP16P90LVT U719 ( .A1(n95), .A2(n93), .B(n94), .ZN(n92) );
  AOI21D1BWP16P90LVT U720 ( .A1(n100), .A2(n607), .B(n97), .ZN(n95) );
  ND2D1BWP16P90 U721 ( .A1(a[7]), .A2(n592), .ZN(n593) );
  ND2D1BWP16P90 U722 ( .A1(n601), .A2(b[7]), .ZN(n584) );
  ND2D1BWP16P90LVT U723 ( .A1(n485), .A2(n583), .ZN(n585) );
  ND2D1BWP16P90LVT U724 ( .A1(n584), .A2(n585), .ZN(n381) );
  INVD1BWP16P90 U725 ( .I(b[7]), .ZN(n583) );
  AOI21D1BWP16P90LVT U726 ( .A1(n578), .A2(n599), .B(n572), .ZN(n586) );
  AOI21D1BWP16P90LVT U727 ( .A1(n92), .A2(n599), .B(n89), .ZN(n87) );
  ND2D1BWP16P90LVT U728 ( .A1(n220), .A2(n223), .ZN(n102) );
  INVD4BWP16P90LVT U729 ( .I(n579), .ZN(n601) );
  XNR2D1BWP16P90LVT U730 ( .A1(n623), .A2(b[6]), .ZN(n382) );
  ND2D1BWP16P90 U731 ( .A1(n256), .A2(n250), .ZN(n589) );
  ND3D1BWP16P90LVT U732 ( .A1(n588), .A2(n589), .A3(n590), .ZN(n197) );
  ND2D1BWP16P90LVT U733 ( .A1(n197), .A2(n188), .ZN(n626) );
  ND2D2BWP16P90LVT U734 ( .A1(n593), .A2(n594), .ZN(n410) );
  AOI21D1BWP16P90 U735 ( .A1(n575), .A2(n607), .B(n97), .ZN(n595) );
  OAI22D1BWP16P90LVT U736 ( .A1(n621), .A2(n354), .B1(n353), .B2(n16), .ZN(
        n277) );
  INVD1BWP16P90LVT U737 ( .I(n63), .ZN(n126) );
  INVD1BWP16P90 U738 ( .I(n109), .ZN(n136) );
  ND2D1BWP16P90 U739 ( .A1(n413), .A2(n418), .ZN(n6) );
  INR2D1BWP16P90 U740 ( .A1(n637), .B1(n16), .ZN(n280) );
  XNR2D1BWP16P90 U741 ( .A1(n637), .A2(n623), .ZN(n388) );
  IND2D1BWP16P90 U742 ( .A1(n637), .B1(n601), .ZN(n389) );
  IND2D1BWP16P90 U743 ( .A1(n637), .B1(n636), .ZN(n324) );
  INR2D1BWP16P90 U744 ( .A1(n637), .B1(n9), .ZN(n294) );
  INR2D1BWP16P90 U745 ( .A1(n637), .B1(n418), .ZN(product[0]) );
  XNR2D8BWP16P90LVT U746 ( .A1(n632), .A2(a[4]), .ZN(n16) );
  XOR2D1BWP16P90 U747 ( .A1(a[13]), .A2(a[12]), .Z(n407) );
  XNR2D1BWP16P90 U748 ( .A1(n601), .A2(b[1]), .ZN(n387) );
  XOR2D1BWP16P90 U749 ( .A1(a[15]), .A2(a[14]), .Z(n406) );
  AOI21D1BWP16P90 U750 ( .A1(n74), .A2(n66), .B(n67), .ZN(n600) );
  AOI21D1BWP16P90LVT U751 ( .A1(n74), .A2(n66), .B(n67), .ZN(n65) );
  INVD1BWP16P90LVT U752 ( .I(n80), .ZN(n78) );
  NR2D1BWP16P90LVT U753 ( .A1(n68), .A2(n71), .ZN(n66) );
  XOR2D1BWP16P90LVT U754 ( .A1(n600), .A2(n46), .Z(product[14]) );
  INVD1BWP16P90 U755 ( .I(n71), .ZN(n128) );
  XOR2D1BWP16P90LVT U756 ( .A1(n52), .A2(n595), .Z(product[8]) );
  INVD1BWP16P90LVT U757 ( .I(n115), .ZN(n113) );
  IOA21D1BWP16P90LVT U758 ( .A1(n610), .A2(n122), .B(n121), .ZN(n604) );
  INVD1BWP16P90LVT U759 ( .I(n124), .ZN(n122) );
  ND2D1BWP16P90LVT U760 ( .A1(n160), .A2(n171), .ZN(n69) );
  XNR2D1BWP16P90 U761 ( .A1(n575), .A2(n53), .ZN(product[7]) );
  XNR2D1BWP16P90 U762 ( .A1(n55), .A2(n506), .ZN(product[5]) );
  XOR2D1BWP16P90 U763 ( .A1(n56), .A2(n111), .Z(product[4]) );
  XNR2D1BWP16P90 U764 ( .A1(n57), .A2(n604), .ZN(product[3]) );
  XNR2D1BWP16P90 U765 ( .A1(n58), .A2(n122), .ZN(product[2]) );
  OAI21D1BWP16P90LVT U766 ( .A1(n65), .A2(n63), .B(n64), .ZN(n62) );
  NR2D1BWP16P90LVT U767 ( .A1(n220), .A2(n223), .ZN(n101) );
  OR2D1BWP16P90LVT U768 ( .A1(n230), .A2(n293), .Z(n608) );
  FA1D1BWP16P90LVT U769 ( .A(n168), .B(n166), .CI(n175), .CO(n161), .S(n162)
         );
  OR2D1BWP16P90LVT U770 ( .A1(n147), .A2(n140), .Z(n609) );
  NR2D1BWP16P90LVT U771 ( .A1(n228), .A2(n229), .ZN(n109) );
  OR2D1BWP16P90LVT U772 ( .A1(n308), .A2(n294), .Z(n610) );
  IND2D1BWP16P90 U773 ( .A1(n123), .B1(n124), .ZN(n59) );
  NR2D1BWP16P90 U774 ( .A1(n309), .A2(n238), .ZN(n123) );
  OAI22D1BWP16P90LVT U775 ( .A1(n560), .A2(n367), .B1(n9), .B2(n366), .ZN(n289) );
  OAI22D1BWP16P90LVT U776 ( .A1(n323), .A2(n34), .B1(n322), .B2(n32), .ZN(n249) );
  FA1D1BWP16P90LVT U777 ( .A(n299), .B(n285), .CI(n190), .CO(n185), .S(n186)
         );
  INR2D1BWP16P90LVT U778 ( .A1(n637), .B1(n37), .ZN(n244) );
  FA1D1BWP16P90LVT U779 ( .A(n263), .B(n233), .CI(n273), .CO(n187), .S(n188)
         );
  OAI22D1BWP16P90LVT U780 ( .A1(n317), .A2(n37), .B1(n39), .B2(n420), .ZN(n232) );
  XOR3D2BWP16P90LVT U781 ( .A1(n142), .A2(n149), .A3(n141), .Z(n140) );
  XOR3D2BWP16P90LVT U782 ( .A1(n155), .A2(n145), .A3(n144), .Z(n142) );
  XOR3D2BWP16P90LVT U783 ( .A1(n153), .A2(n143), .A3(n151), .Z(n141) );
  XOR3D2BWP16P90LVT U784 ( .A1(n259), .A2(n269), .A3(n295), .Z(n144) );
  BUFFD2BWP16P90LVT U785 ( .I(a[1]), .Z(n623) );
  XOR3D1BWP16P90LVT U786 ( .A1(n239), .A2(n146), .A3(n157), .Z(n143) );
  XOR2D1BWP16P90LVT U787 ( .A1(n281), .A2(n241), .Z(n146) );
  XNR2D1BWP16P90 U788 ( .A1(b[1]), .A2(a[15]), .ZN(n310) );
  XNR2D1BWP16P90 U789 ( .A1(b[2]), .A2(a[13]), .ZN(n314) );
  XNR2D1BWP16P90 U790 ( .A1(b[1]), .A2(a[13]), .ZN(n315) );
  XNR2D1BWP16P90 U791 ( .A1(b[3]), .A2(a[13]), .ZN(n313) );
  XNR2D1BWP16P90 U792 ( .A1(n634), .A2(b[9]), .ZN(n334) );
  IND2D1BWP16P90 U793 ( .A1(n637), .B1(a[13]), .ZN(n317) );
  IND2D1BWP16P90 U794 ( .A1(n637), .B1(a[15]), .ZN(n312) );
  XNR2D1BWP16P90 U795 ( .A1(b[5]), .A2(n636), .ZN(n318) );
  XNR2D1BWP16P90 U796 ( .A1(b[7]), .A2(n635), .ZN(n325) );
  INVD1BWP16P90 U797 ( .I(a[13]), .ZN(n420) );
  CKND1BWP16P90LVT U798 ( .I(a[15]), .ZN(n419) );
  XNR2D1BWP16P90 U799 ( .A1(n637), .A2(a[15]), .ZN(n311) );
  INVD1BWP16P90 U800 ( .I(n532), .ZN(n425) );
  INVD1BWP16P90 U801 ( .I(n538), .ZN(n424) );
  IND2D1BWP16P90 U802 ( .A1(n637), .B1(n538), .ZN(n357) );
  INVD1BWP16P90 U803 ( .I(n635), .ZN(n422) );
  IND2D1BWP16P90 U804 ( .A1(n637), .B1(n635), .ZN(n333) );
  AOI21D1BWP16P90LVT U805 ( .A1(n574), .A2(n603), .B(n616), .ZN(n81) );
  ND2D1BWP16P90 U806 ( .A1(n501), .A2(n173), .ZN(n612) );
  ND2D1BWP16P90 U807 ( .A1(n501), .A2(n164), .ZN(n613) );
  ND2D1BWP16P90 U808 ( .A1(n173), .A2(n164), .ZN(n614) );
  ND3D1BWP16P90LVT U809 ( .A1(n612), .A2(n613), .A3(n614), .ZN(n159) );
  INVD1BWP16P90LVT U810 ( .I(n68), .ZN(n127) );
  INVD1BWP16P90LVT U811 ( .I(n617), .ZN(n616) );
  XOR2D1BWP16P90LVT U812 ( .A1(n81), .A2(n49), .Z(product[11]) );
  ND2D1BWP16P90 U813 ( .A1(n606), .A2(n107), .ZN(n55) );
  OAI22D1BWP16P90 U814 ( .A1(n507), .A2(n347), .B1(n346), .B2(n16), .ZN(n270)
         );
  ND2D1BWP16P90 U815 ( .A1(n603), .A2(n617), .ZN(n50) );
  BUFFD4BWP16P90LVT U816 ( .I(a[1]), .Z(n631) );
  ND2D1BWP16P90 U817 ( .A1(n599), .A2(n91), .ZN(n51) );
  IND2D1BWP16P90 U818 ( .A1(n637), .B1(n532), .ZN(n372) );
  OAI22D1BWP16P90 U819 ( .A1(n621), .A2(n346), .B1(n16), .B2(n345), .ZN(n269)
         );
  ND2D1BWP16P90 U820 ( .A1(n134), .A2(n102), .ZN(n54) );
  ND2D1BWP16P90LVT U821 ( .A1(n195), .A2(n188), .ZN(n627) );
  ND2D1BWP16P90 U822 ( .A1(n186), .A2(n537), .ZN(n628) );
  ND2D1BWP16P90 U823 ( .A1(n186), .A2(n184), .ZN(n629) );
  XNR2D1BWP16P90LVT U824 ( .A1(n70), .A2(n47), .ZN(product[13]) );
  XNR2D1BWP16P90LVT U825 ( .A1(n62), .A2(n45), .ZN(product[15]) );
endmodule


module stage2_cg ( d, sum, c, clk, rst );
  output [15:0] d;
  input [15:0] sum;
  input [15:0] c;
  input clk, rst;
  wire   N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16,
         n17, SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4,
         SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6,
         SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8,
         SYNOPSYS_UNCONNECTED_9, SYNOPSYS_UNCONNECTED_10,
         SYNOPSYS_UNCONNECTED_11, SYNOPSYS_UNCONNECTED_12,
         SYNOPSYS_UNCONNECTED_13, SYNOPSYS_UNCONNECTED_14,
         SYNOPSYS_UNCONNECTED_15, SYNOPSYS_UNCONNECTED_16;

  DFCNQD2BWP16P90LVT d_reg_15_ ( .D(N16), .CP(clk), .CDN(n17), .Q(d[15]) );
  DFCNQD2BWP16P90LVT d_reg_14_ ( .D(N15), .CP(clk), .CDN(n17), .Q(d[14]) );
  DFCNQD2BWP16P90LVT d_reg_13_ ( .D(N14), .CP(clk), .CDN(n17), .Q(d[13]) );
  DFCNQD2BWP16P90LVT d_reg_12_ ( .D(N13), .CP(clk), .CDN(n17), .Q(d[12]) );
  DFCNQD2BWP16P90LVT d_reg_11_ ( .D(N12), .CP(clk), .CDN(n17), .Q(d[11]) );
  DFCNQD2BWP16P90LVT d_reg_10_ ( .D(N11), .CP(clk), .CDN(n17), .Q(d[10]) );
  DFCNQD2BWP16P90LVT d_reg_9_ ( .D(N10), .CP(clk), .CDN(n17), .Q(d[9]) );
  DFCNQD2BWP16P90LVT d_reg_8_ ( .D(N9), .CP(clk), .CDN(n17), .Q(d[8]) );
  DFCNQD2BWP16P90LVT d_reg_7_ ( .D(N8), .CP(clk), .CDN(n17), .Q(d[7]) );
  DFCNQD2BWP16P90LVT d_reg_6_ ( .D(N7), .CP(clk), .CDN(n17), .Q(d[6]) );
  DFCNQD2BWP16P90LVT d_reg_5_ ( .D(N6), .CP(clk), .CDN(n17), .Q(d[5]) );
  DFCNQD2BWP16P90LVT d_reg_4_ ( .D(N5), .CP(clk), .CDN(n17), .Q(d[4]) );
  DFCNQD2BWP16P90LVT d_reg_3_ ( .D(N4), .CP(clk), .CDN(n17), .Q(d[3]) );
  DFCNQD2BWP16P90LVT d_reg_2_ ( .D(N3), .CP(clk), .CDN(n17), .Q(d[2]) );
  DFCNQD2BWP16P90LVT d_reg_1_ ( .D(N2), .CP(clk), .CDN(n17), .Q(d[1]) );
  DFCNQD2BWP16P90LVT d_reg_0_ ( .D(N1), .CP(clk), .CDN(n17), .Q(d[0]) );
  stage2_cg_DW_mult_uns_2 mult_63 ( .a(sum), .b(c), .\product[15] (N16), 
        .\product[14] (N15), .\product[13] (N14), .\product[12] (N13), 
        .\product[11] (N12), .\product[10] (N11), .\product[9] (N10), 
        .\product[8] (N9), .\product[7] (N8), .\product[6] (N7), 
        .\product[5] (N6), .\product[4] (N5), .\product[3] (N4), 
        .\product[2] (N3), .\product[1] (N2), .\product[0] (N1) );
  CKND1BWP16P90LVT U3 ( .I(rst), .ZN(n17) );
endmodule


module hw2_cg ( d, a, b, c, s, rst, clk );
  output [15:0] d;
  input [7:0] a;
  input [7:0] b;
  input [7:0] c;
  input s, rst, clk;
  wire   N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18,
         N19, N34, n2, n3, n40, n50, n60, n70, n80, n90, n100, n110, n120,
         n130, n140, n150, SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4,
         SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6,
         SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8;
  wire   [7:0] co;
  wire   [15:0] sum;
  wire   [15:0] sumo;
  wire   [15:0] c1;
  wire   [15:0] product;

  AN2D1BWP16P90LVT U4 ( .A1(product[5]), .A2(N34), .Z(N9) );
  AN2D1BWP16P90LVT U5 ( .A1(product[4]), .A2(N34), .Z(N8) );
  AN2D1BWP16P90LVT U6 ( .A1(product[3]), .A2(N34), .Z(N7) );
  AN2D1BWP16P90LVT U7 ( .A1(product[2]), .A2(N34), .Z(N6) );
  AN2D1BWP16P90LVT U8 ( .A1(product[1]), .A2(N34), .Z(N5) );
  AN2D1BWP16P90LVT U9 ( .A1(product[0]), .A2(N34), .Z(N4) );
  AN2D1BWP16P90LVT U10 ( .A1(product[15]), .A2(N34), .Z(N19) );
  AN2D1BWP16P90LVT U11 ( .A1(product[14]), .A2(N34), .Z(N18) );
  AN2D1BWP16P90LVT U12 ( .A1(product[13]), .A2(N34), .Z(N17) );
  AN2D1BWP16P90LVT U13 ( .A1(product[12]), .A2(N34), .Z(N16) );
  AN2D1BWP16P90LVT U14 ( .A1(product[11]), .A2(N34), .Z(N15) );
  AN2D1BWP16P90LVT U15 ( .A1(product[10]), .A2(N34), .Z(N14) );
  AN2D1BWP16P90LVT U16 ( .A1(product[9]), .A2(N34), .Z(N13) );
  AN2D1BWP16P90LVT U17 ( .A1(product[8]), .A2(N34), .Z(N12) );
  AN2D1BWP16P90LVT U18 ( .A1(product[7]), .A2(N34), .Z(N11) );
  AN2D1BWP16P90LVT U19 ( .A1(product[6]), .A2(N34), .Z(N10) );
  DFCNQD2BWP16P90LVT d_reg_15_ ( .D(N19), .CP(clk), .CDN(n150), .Q(d[15]) );
  DFCNQD2BWP16P90LVT d_reg_14_ ( .D(N18), .CP(clk), .CDN(n150), .Q(d[14]) );
  DFCNQD2BWP16P90LVT d_reg_13_ ( .D(N17), .CP(clk), .CDN(n150), .Q(d[13]) );
  DFCNQD2BWP16P90LVT d_reg_12_ ( .D(N16), .CP(clk), .CDN(n150), .Q(d[12]) );
  DFCNQD2BWP16P90LVT d_reg_11_ ( .D(N15), .CP(clk), .CDN(n150), .Q(d[11]) );
  DFCNQD2BWP16P90LVT d_reg_10_ ( .D(N14), .CP(clk), .CDN(n150), .Q(d[10]) );
  DFCNQD2BWP16P90LVT d_reg_9_ ( .D(N13), .CP(clk), .CDN(n150), .Q(d[9]) );
  DFCNQD2BWP16P90LVT d_reg_8_ ( .D(N12), .CP(clk), .CDN(n150), .Q(d[8]) );
  DFCNQD2BWP16P90LVT d_reg_7_ ( .D(N11), .CP(clk), .CDN(n150), .Q(d[7]) );
  DFCNQD2BWP16P90LVT d_reg_6_ ( .D(N10), .CP(clk), .CDN(n150), .Q(d[6]) );
  DFCNQD2BWP16P90LVT d_reg_5_ ( .D(N9), .CP(clk), .CDN(n150), .Q(d[5]) );
  DFCNQD2BWP16P90LVT d_reg_4_ ( .D(N8), .CP(clk), .CDN(n150), .Q(d[4]) );
  DFCNQD2BWP16P90LVT d_reg_3_ ( .D(N7), .CP(clk), .CDN(n150), .Q(d[3]) );
  DFCNQD2BWP16P90LVT d_reg_2_ ( .D(N6), .CP(clk), .CDN(n150), .Q(d[2]) );
  DFCNQD2BWP16P90LVT d_reg_1_ ( .D(N5), .CP(clk), .CDN(n150), .Q(d[1]) );
  DFCNQD2BWP16P90LVT d_reg_0_ ( .D(N4), .CP(clk), .CDN(n150), .Q(d[0]) );
  stage1_cg uut1 ( .sum(sum), .co({SYNOPSYS_UNCONNECTED_1, 
        SYNOPSYS_UNCONNECTED_2, SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4, 
        SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6, SYNOPSYS_UNCONNECTED_7, 
        SYNOPSYS_UNCONNECTED_8, co}), .a(a), .b(b), .c({n70, n80, n90, n100, 
        n110, n120, n130, n140}), .s(s), .clk(clk), .rst(rst) );
  clock_gate16_0 cg1 ( .Q(sumo), .D(sum), .en(N34), .rst(rst), .clk(clk) );
  clock_gate16_1 cg2 ( .Q(c1), .D({n60, n60, n60, n60, n60, n60, n60, n60, co}), .en(N34), .rst(rst), .clk(clk) );
  stage2_cg uut2 ( .d(product), .sum(sumo), .c(c1), .clk(clk), .rst(rst) );
  TIELBWP20P90LVT U25 ( .ZN(n60) );
  CKBD1BWP20P90 U26 ( .I(c[7]), .Z(n70) );
  CKBD1BWP20P90 U27 ( .I(c[6]), .Z(n80) );
  CKBD1BWP20P90 U28 ( .I(c[5]), .Z(n90) );
  CKBD1BWP20P90 U29 ( .I(c[4]), .Z(n100) );
  CKBD1BWP20P90 U30 ( .I(c[3]), .Z(n110) );
  CKBD1BWP20P90 U31 ( .I(c[2]), .Z(n120) );
  CKBD1BWP20P90 U32 ( .I(c[1]), .Z(n130) );
  CKBD1BWP20P90 U33 ( .I(c[0]), .Z(n140) );
  ND4D1BWP16P90LVT U34 ( .A1(n2), .A2(n3), .A3(n40), .A4(n50), .ZN(N34) );
  CKND1BWP16P90LVT U35 ( .I(co[0]), .ZN(n2) );
  CKND1BWP16P90LVT U36 ( .I(co[1]), .ZN(n3) );
  NR2D1BWP16P90LVT U37 ( .A1(co[7]), .A2(co[6]), .ZN(n50) );
  NR4D1BWP16P90LVT U38 ( .A1(co[5]), .A2(co[4]), .A3(co[3]), .A4(co[2]), .ZN(
        n40) );
  CKND1BWP16P90LVT U39 ( .I(rst), .ZN(n150) );
endmodule

