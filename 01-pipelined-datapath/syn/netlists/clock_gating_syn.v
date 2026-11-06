/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : V-2023.12
// Date      : Sat Oct 19 19:49:25 2024
/////////////////////////////////////////////////////////////


module clock_gate16_0 ( Q, D, en, rst );
  output [15:0] Q;
  input [15:0] D;
  input en, rst;
  wire   n1;

  DFCNQD2BWP16P90LVT Q_reg_15_ ( .D(D[15]), .CP(en), .CDN(n1), .Q(Q[15]) );
  DFCNQD2BWP16P90LVT Q_reg_14_ ( .D(D[14]), .CP(en), .CDN(n1), .Q(Q[14]) );
  DFCNQD2BWP16P90LVT Q_reg_13_ ( .D(D[13]), .CP(en), .CDN(n1), .Q(Q[13]) );
  DFCNQD2BWP16P90LVT Q_reg_12_ ( .D(D[12]), .CP(en), .CDN(n1), .Q(Q[12]) );
  DFCNQD2BWP16P90LVT Q_reg_11_ ( .D(D[11]), .CP(en), .CDN(n1), .Q(Q[11]) );
  DFCNQD2BWP16P90LVT Q_reg_10_ ( .D(D[10]), .CP(en), .CDN(n1), .Q(Q[10]) );
  DFCNQD2BWP16P90LVT Q_reg_9_ ( .D(D[9]), .CP(en), .CDN(n1), .Q(Q[9]) );
  DFCNQD2BWP16P90LVT Q_reg_8_ ( .D(D[8]), .CP(en), .CDN(n1), .Q(Q[8]) );
  DFCNQD2BWP16P90LVT Q_reg_7_ ( .D(D[7]), .CP(en), .CDN(n1), .Q(Q[7]) );
  DFCNQD2BWP16P90LVT Q_reg_6_ ( .D(D[6]), .CP(en), .CDN(n1), .Q(Q[6]) );
  DFCNQD2BWP16P90LVT Q_reg_5_ ( .D(D[5]), .CP(en), .CDN(n1), .Q(Q[5]) );
  DFCNQD2BWP16P90LVT Q_reg_4_ ( .D(D[4]), .CP(en), .CDN(n1), .Q(Q[4]) );
  DFCNQD2BWP16P90LVT Q_reg_3_ ( .D(D[3]), .CP(en), .CDN(n1), .Q(Q[3]) );
  DFCNQD2BWP16P90LVT Q_reg_2_ ( .D(D[2]), .CP(en), .CDN(n1), .Q(Q[2]) );
  DFCNQD2BWP16P90LVT Q_reg_1_ ( .D(D[1]), .CP(en), .CDN(n1), .Q(Q[1]) );
  DFCNQD2BWP16P90LVT Q_reg_0_ ( .D(D[0]), .CP(en), .CDN(n1), .Q(Q[0]) );
  CKND1BWP16P90LVT U3 ( .I(rst), .ZN(n1) );
endmodule


module stage1_cg_DW01_sub_0 ( DIFF, \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , 
        \A[2] , \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , 
        \B[1] , \B[0]  );
  output [8:0] DIFF;
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  wire   n1, n3, n4, n5, n6, n7, n8, n9, n10;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [8:1] carry;
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
  FA1D1BWP16P90LVT U2_1 ( .A(A[1]), .B(n9), .CI(carry[1]), .CO(carry[2]), .S(
        DIFF[1]) );
  INVD1BWP16P90LVT U1 ( .I(carry[8]), .ZN(DIFF[8]) );
  CKND1BWP16P90LVT U2 ( .I(B[2]), .ZN(n8) );
  CKND1BWP16P90LVT U3 ( .I(B[3]), .ZN(n7) );
  CKND1BWP16P90LVT U4 ( .I(B[4]), .ZN(n6) );
  CKND1BWP16P90LVT U5 ( .I(B[5]), .ZN(n5) );
  CKND1BWP16P90LVT U6 ( .I(B[6]), .ZN(n4) );
  CKND1BWP16P90LVT U7 ( .I(B[1]), .ZN(n9) );
  CKND1BWP16P90LVT U8 ( .I(B[7]), .ZN(n3) );
  XNR2D1BWP16P90 U9 ( .A1(n10), .A2(A[0]), .ZN(DIFF[0]) );
  CKND2BWP16P90LVT U10 ( .I(n1), .ZN(carry[1]) );
  CKNR2D4BWP16P90LVT U11 ( .A1(A[0]), .A2(n10), .ZN(n1) );
  CKND2BWP16P90LVT U12 ( .I(B[0]), .ZN(n10) );
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


module stage1_cg ( sum, a, b, s );
  output [15:0] sum;
  input [7:0] a;
  input [7:0] b;
  input s;
  wire   sum_9_, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16,
         N17, N18, N19, N20, n60, n2;
  assign sum[9] = sum[15];
  assign sum[10] = sum[15];
  assign sum[11] = sum[15];
  assign sum[12] = sum[15];
  assign sum[13] = sum[15];
  assign sum[14] = sum[15];

  AO21D1BWP16P90LVT U6 ( .A1(s), .A2(N11), .B(sum_9_), .Z(sum[8]) );
  AO22D1BWP16P90LVT U7 ( .A1(N19), .A2(n2), .B1(N10), .B2(s), .Z(sum[7]) );
  AO22D1BWP16P90LVT U8 ( .A1(N9), .A2(s), .B1(N18), .B2(n2), .Z(sum[6]) );
  AO22D1BWP16P90LVT U9 ( .A1(N8), .A2(s), .B1(N17), .B2(n2), .Z(sum[5]) );
  AO22D1BWP16P90LVT U10 ( .A1(N7), .A2(s), .B1(N16), .B2(n2), .Z(sum[4]) );
  AO22D1BWP16P90LVT U11 ( .A1(N6), .A2(s), .B1(N15), .B2(n2), .Z(sum[3]) );
  AO22D1BWP16P90LVT U12 ( .A1(N5), .A2(s), .B1(N14), .B2(n2), .Z(sum[2]) );
  AO22D1BWP16P90LVT U13 ( .A1(N4), .A2(s), .B1(N13), .B2(n2), .Z(sum[1]) );
  AO22D1BWP16P90LVT U15 ( .A1(N3), .A2(s), .B1(N12), .B2(n2), .Z(sum[0]) );
  stage1_cg_DW01_sub_0 sub_30 ( .DIFF({N20, N19, N18, N17, N16, N15, N14, N13, 
        N12}), .\A[7] (a[7]), .\A[6] (a[6]), .\A[5] (a[5]), .\A[4] (a[4]), 
        .\A[3] (a[3]), .\A[2] (a[2]), .\A[1] (a[1]), .\A[0] (a[0]), .\B[7] (
        b[7]), .\B[6] (b[6]), .\B[5] (b[5]), .\B[4] (b[4]), .\B[3] (b[3]), 
        .\B[2] (b[2]), .\B[1] (b[1]), .\B[0] (b[0]) );
  stage1_cg_DW01_add_0 add_30 ( .SUM({N11, N10, N9, N8, N7, N6, N5, N4, N3}), 
        .\A[7] (a[7]), .\A[6] (a[6]), .\A[5] (a[5]), .\A[4] (a[4]), .\A[3] (
        a[3]), .\A[2] (a[2]), .\A[1] (a[1]), .\A[0] (a[0]), .\B[7] (b[7]), 
        .\B[6] (b[6]), .\B[5] (b[5]), .\B[4] (b[4]), .\B[3] (b[3]), .\B[2] (
        b[2]), .\B[1] (b[1]), .\B[0] (b[0]) );
  TIELBWP20P90LVT U2 ( .ZN(n60) );
  CKBD1BWP16P90LVT U3 ( .I(sum_9_), .Z(sum[15]) );
  INR2D2BWP16P90LVT U4 ( .A1(N20), .B1(s), .ZN(sum_9_) );
  CKND1BWP16P90LVT U5 ( .I(s), .ZN(n2) );
endmodule


module clock_gate16_2 ( Q, D, en, rst );
  output [15:0] Q;
  input [15:0] D;
  input en, rst;
  wire   n1;

  DFCNQD2BWP16P90LVT Q_reg_15_ ( .D(D[15]), .CP(en), .CDN(n1), .Q(Q[15]) );
  DFCNQD2BWP16P90LVT Q_reg_14_ ( .D(D[14]), .CP(en), .CDN(n1), .Q(Q[14]) );
  DFCNQD2BWP16P90LVT Q_reg_12_ ( .D(D[12]), .CP(en), .CDN(n1), .Q(Q[12]) );
  DFCNQD2BWP16P90LVT Q_reg_10_ ( .D(D[10]), .CP(en), .CDN(n1), .Q(Q[10]) );
  DFCNQD2BWP16P90LVT Q_reg_8_ ( .D(D[8]), .CP(en), .CDN(n1), .Q(Q[8]) );
  DFCNQD2BWP16P90LVT Q_reg_6_ ( .D(D[6]), .CP(en), .CDN(n1), .Q(Q[6]) );
  DFCNQD2BWP16P90LVT Q_reg_4_ ( .D(D[4]), .CP(en), .CDN(n1), .Q(Q[4]) );
  DFCNQD2BWP16P90LVT Q_reg_2_ ( .D(D[2]), .CP(en), .CDN(n1), .Q(Q[2]) );
  DFCNQD2BWP16P90LVT Q_reg_1_ ( .D(D[1]), .CP(en), .CDN(n1), .Q(Q[1]) );
  DFCNQD2BWP16P90LVT Q_reg_0_ ( .D(D[0]), .CP(en), .CDN(n1), .Q(Q[0]) );
  DFCNQD2BWP16P90LVT Q_reg_13_ ( .D(D[13]), .CP(en), .CDN(n1), .Q(Q[13]) );
  DFCNQD2BWP16P90LVT Q_reg_7_ ( .D(D[7]), .CP(en), .CDN(n1), .Q(Q[7]) );
  DFCNQD2BWP16P90LVT Q_reg_9_ ( .D(D[9]), .CP(en), .CDN(n1), .Q(Q[9]) );
  DFCNQD2BWP16P90LVT Q_reg_11_ ( .D(D[11]), .CP(en), .CDN(n1), .Q(Q[11]) );
  DFCNQD2BWP16P90LVT Q_reg_5_ ( .D(D[5]), .CP(en), .CDN(n1), .Q(Q[5]) );
  DFCNQD2BWP16P90LVT Q_reg_3_ ( .D(D[3]), .CP(en), .CDN(n1), .Q(Q[3]) );
  INVD1BWP16P90LVT U3 ( .I(rst), .ZN(n1) );
endmodule


module clock_gate16_1 ( Q, D, en, rst );
  output [15:0] Q;
  input [15:0] D;
  input en, rst;
  wire   n1;

  DFCNQD2BWP16P90LVT Q_reg_15_ ( .D(D[15]), .CP(en), .CDN(n1), .Q(Q[15]) );
  DFCNQD2BWP16P90LVT Q_reg_14_ ( .D(D[14]), .CP(en), .CDN(n1), .Q(Q[14]) );
  DFCNQD2BWP16P90LVT Q_reg_13_ ( .D(D[13]), .CP(en), .CDN(n1), .Q(Q[13]) );
  DFCNQD2BWP16P90LVT Q_reg_12_ ( .D(D[12]), .CP(en), .CDN(n1), .Q(Q[12]) );
  DFCNQD2BWP16P90LVT Q_reg_11_ ( .D(D[11]), .CP(en), .CDN(n1), .Q(Q[11]) );
  DFCNQD2BWP16P90LVT Q_reg_10_ ( .D(D[10]), .CP(en), .CDN(n1), .Q(Q[10]) );
  DFCNQD2BWP16P90LVT Q_reg_9_ ( .D(D[9]), .CP(en), .CDN(n1), .Q(Q[9]) );
  DFCNQD2BWP16P90LVT Q_reg_8_ ( .D(D[8]), .CP(en), .CDN(n1), .Q(Q[8]) );
  DFCNQD2BWP16P90LVT Q_reg_7_ ( .D(D[7]), .CP(en), .CDN(n1), .Q(Q[7]) );
  DFCNQD2BWP16P90LVT Q_reg_6_ ( .D(D[6]), .CP(en), .CDN(n1), .Q(Q[6]) );
  DFCNQD2BWP16P90LVT Q_reg_1_ ( .D(D[1]), .CP(en), .CDN(n1), .Q(Q[1]) );
  DFCNQD2BWP16P90LVT Q_reg_0_ ( .D(D[0]), .CP(en), .CDN(n1), .Q(Q[0]) );
  DFCNQD2BWP16P90LVT Q_reg_5_ ( .D(D[5]), .CP(en), .CDN(n1), .Q(Q[5]) );
  DFCNQD2BWP16P90LVT Q_reg_2_ ( .D(D[2]), .CP(en), .CDN(n1), .Q(Q[2]) );
  DFCNQD2BWP16P90LVT Q_reg_3_ ( .D(D[3]), .CP(en), .CDN(n1), .Q(Q[3]) );
  DFCNQD2BWP16P90LVT Q_reg_4_ ( .D(D[4]), .CP(en), .CDN(n1), .Q(Q[4]) );
  INVD1BWP16P90LVT U3 ( .I(rst), .ZN(n1) );
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
  wire   n6, n9, n12, n16, n17, n21, n23, n27, n29, n32, n37, n39, n41, n42,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n78, n80, n81, n83, n85, n87, n89, n91, n92, n93, n94,
         n95, n97, n99, n100, n101, n102, n103, n108, n109, n110, n111, n113,
         n115, n121, n122, n123, n124, n126, n127, n128, n132, n134, n135,
         n136, n139, n140, n141, n142, n143, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324,
         n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n406,
         n407, n408, n409, n410, n411, n412, n413, n418, n419, n420, n421,
         n422, n423, n424, n425, n426, n485, n486, n487, n488, n489, n490,
         n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501,
         n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512,
         n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523,
         n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n534,
         n535, n536, n537, n538, n539, n540, n541, n542, n543, n544, n545,
         n546, n547, n548, n549, n550, n551, n552, n553, n554, n555, n556,
         n557, n558, n559, n560, n561, n562, n563, n564, n565, n566, n567,
         n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578,
         n579, n580, n581, n582, n583, n584, n585, n586, n587, n588, n589,
         n590, n591, n592, n593, n594, n595, n596, n597, n598, n599, n600,
         n601, n602, n603, n604, n605, n606, n607, n608, n609, n610, n611,
         n612, n613, n614, n615, n616, n617, n618, n619, n620, n621, n622,
         n623, n624, n625, n626, n627, n628, n629, n630;
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

  ND2D1BWP16P90LVT U34 ( .A1(n605), .A2(n61), .ZN(n45) );
  ND2D1BWP16P90LVT U37 ( .A1(n147), .A2(n140), .ZN(n61) );
  ND2D1BWP16P90LVT U43 ( .A1(n148), .A2(n159), .ZN(n64) );
  ND2D1BWP16P90LVT U68 ( .A1(n182), .A2(n191), .ZN(n80) );
  ND2D1BWP16P90LVT U116 ( .A1(n136), .A2(n110), .ZN(n56) );
  ND2D1BWP16P90LVT U119 ( .A1(n228), .A2(n229), .ZN(n110) );
  ND2D1BWP16P90LVT U124 ( .A1(n604), .A2(n115), .ZN(n57) );
  ND2D1BWP16P90LVT U127 ( .A1(n230), .A2(n293), .ZN(n115) );
  ND2D1BWP16P90LVT U133 ( .A1(n606), .A2(n121), .ZN(n58) );
  ND2D1BWP16P90LVT U136 ( .A1(n308), .A2(n294), .ZN(n121) );
  ND2D1BWP16P90LVT U139 ( .A1(n139), .A2(n124), .ZN(n59) );
  FA1D1BWP16P90LVT U150 ( .A(n152), .B(n161), .CI(n150), .CO(n147), .S(n148)
         );
  FA1D1BWP16P90LVT U151 ( .A(n163), .B(n156), .CI(n154), .CO(n149), .S(n150)
         );
  FA1D1BWP16P90LVT U153 ( .A(n296), .B(n282), .CI(n169), .CO(n153), .S(n154)
         );
  FA1D1BWP16P90LVT U155 ( .A(n240), .B(n242), .CI(n246), .CO(n157), .S(n158)
         );
  FA1D1BWP16P90LVT U159 ( .A(n271), .B(n297), .CI(n283), .CO(n165), .S(n166)
         );
  FA1D1BWP16P90LVT U160 ( .A(n232), .B(n253), .CI(n261), .CO(n167), .S(n168)
         );
  FA1D1BWP16P90LVT U165 ( .A(n272), .B(n262), .CI(n284), .CO(n177), .S(n178)
         );
  FA1D1BWP16P90LVT U166 ( .A(n244), .B(n248), .CI(n254), .CO(n179), .S(n180)
         );
  FA1D1BWP16P90LVT U170 ( .A(n263), .B(n233), .CI(n273), .CO(n187), .S(n188)
         );
  FA1D1BWP16P90LVT U175 ( .A(n250), .B(n256), .CI(n264), .CO(n197), .S(n198)
         );
  HA1D2BWP16P90LVT U179 ( .A(n234), .B(n257), .CO(n205), .S(n206) );
  FA1D1BWP16P90LVT U181 ( .A(n302), .B(n288), .CI(n217), .CO(n209), .S(n210)
         );
  FA1D1BWP16P90LVT U182 ( .A(n258), .B(n266), .CI(n276), .CO(n211), .S(n212)
         );
  HA1D2BWP16P90LVT U189 ( .A(n236), .B(n279), .CO(n225), .S(n226) );
  FA1D1BWP16P90LVT U190 ( .A(n280), .B(n306), .CI(n292), .CO(n227), .S(n228)
         );
  HA1D2BWP16P90LVT U191 ( .A(n307), .B(n237), .CO(n229), .S(n230) );
  OAI22D1BWP16P90LVT U192 ( .A1(n312), .A2(n41), .B1(n42), .B2(n419), .ZN(n231) );
  OAI22D1BWP16P90LVT U193 ( .A1(n311), .A2(n42), .B1(n310), .B2(n41), .ZN(n239) );
  OAI22D1BWP16P90LVT U198 ( .A1(n317), .A2(n530), .B1(n39), .B2(n420), .ZN(
        n232) );
  OAI22D1BWP16P90LVT U199 ( .A1(n39), .A2(n314), .B1(n313), .B2(n530), .ZN(
        n241) );
  OAI22D1BWP16P90LVT U209 ( .A1(n486), .A2(n319), .B1(n318), .B2(n32), .ZN(
        n245) );
  OAI22D1BWP16P90LVT U210 ( .A1(n486), .A2(n320), .B1(n319), .B2(n32), .ZN(
        n246) );
  OAI22D1BWP16P90LVT U211 ( .A1(n486), .A2(n321), .B1(n320), .B2(n32), .ZN(
        n247) );
  INR2D2BWP16P90LVT U214 ( .A1(n630), .B1(n32), .ZN(n250) );
  OAI22D1BWP16P90LVT U222 ( .A1(n525), .A2(n422), .B1(n333), .B2(n27), .ZN(
        n234) );
  OAI22D1BWP16P90LVT U223 ( .A1(n525), .A2(n326), .B1(n325), .B2(n515), .ZN(
        n251) );
  OAI22D1BWP16P90LVT U224 ( .A1(n526), .A2(n327), .B1(n326), .B2(n27), .ZN(
        n252) );
  OAI22D1BWP16P90LVT U225 ( .A1(n526), .A2(n328), .B1(n327), .B2(n27), .ZN(
        n253) );
  OAI22D1BWP16P90LVT U226 ( .A1(n29), .A2(n329), .B1(n328), .B2(n27), .ZN(n254) );
  OAI22D1BWP16P90LVT U229 ( .A1(n332), .A2(n525), .B1(n331), .B2(n27), .ZN(
        n257) );
  OAI22D1BWP16P90LVT U240 ( .A1(n23), .A2(n423), .B1(n344), .B2(n527), .ZN(
        n235) );
  OAI22D1BWP16P90LVT U244 ( .A1(n561), .A2(n338), .B1(n337), .B2(n527), .ZN(
        n262) );
  OAI22D1BWP16P90LVT U262 ( .A1(n17), .A2(n424), .B1(n16), .B2(n357), .ZN(n236) );
  OAI22D1BWP16P90LVT U265 ( .A1(n595), .A2(n348), .B1(n609), .B2(n347), .ZN(
        n271) );
  OAI22D1BWP16P90LVT U268 ( .A1(n594), .A2(n351), .B1(n350), .B2(n609), .ZN(
        n274) );
  OAI22D1BWP16P90LVT U271 ( .A1(n595), .A2(n354), .B1(n353), .B2(n609), .ZN(
        n277) );
  OAI22D1BWP16P90LVT U318 ( .A1(n6), .A2(n426), .B1(n389), .B2(n418), .ZN(n238) );
  OAI22D1BWP16P90LVT U320 ( .A1(n6), .A2(n375), .B1(n374), .B2(n418), .ZN(n296) );
  OAI22D1BWP16P90LVT U322 ( .A1(n6), .A2(n377), .B1(n376), .B2(n418), .ZN(n298) );
  OAI22D1BWP16P90LVT U323 ( .A1(n6), .A2(n378), .B1(n377), .B2(n418), .ZN(n299) );
  OAI22D1BWP16P90LVT U325 ( .A1(n6), .A2(n380), .B1(n379), .B2(n418), .ZN(n301) );
  OAI22D1BWP16P90LVT U326 ( .A1(n6), .A2(n381), .B1(n380), .B2(n418), .ZN(n302) );
  OAI22D1BWP16P90LVT U330 ( .A1(n6), .A2(n385), .B1(n384), .B2(n418), .ZN(n306) );
  OAI22D1BWP16P90LVT U331 ( .A1(n6), .A2(n386), .B1(n385), .B2(n418), .ZN(n307) );
  OAI22D1BWP16P90LVT U332 ( .A1(n6), .A2(n387), .B1(n386), .B2(n418), .ZN(n308) );
  ND2D1BWP16P90LVT U367 ( .A1(n41), .A2(n406), .ZN(n42) );
  CKND2D4BWP16P90LVT U393 ( .A1(n412), .A2(n9), .ZN(n12) );
  ND3D2BWP16P90LVT U394 ( .A1(n547), .A2(n548), .A3(n549), .ZN(n171) );
  OR2D4BWP16P90LVT U395 ( .A1(n214), .A2(n219), .Z(n602) );
  ND3D1BWP16P90LVT U396 ( .A1(n619), .A2(n620), .A3(n621), .ZN(n485) );
  ND3D1BWP16P90LVT U397 ( .A1(n619), .A2(n620), .A3(n621), .ZN(n221) );
  XNR2D1BWP16P90LVT U398 ( .A1(n503), .A2(n50), .ZN(product[10]) );
  ND2D2BWP16P90LVT U399 ( .A1(n21), .A2(n410), .ZN(n561) );
  CKND2D4BWP16P90LVT U400 ( .A1(n32), .A2(n408), .ZN(n486) );
  CKND2D2BWP16P90LVT U401 ( .A1(n32), .A2(n408), .ZN(n582) );
  XNR2D2BWP16P90LVT U402 ( .A1(b[4]), .A2(a[9]), .ZN(n328) );
  XNR2D2BWP16P90LVT U403 ( .A1(b[3]), .A2(a[9]), .ZN(n329) );
  CKND2BWP16P90LVT U404 ( .I(n517), .ZN(n518) );
  INVD1BWP16P90LVT U405 ( .I(n162), .ZN(n517) );
  XNR2D2BWP16P90LVT U406 ( .A1(n587), .A2(b[7]), .ZN(n381) );
  ND2D1BWP16P90LVT U407 ( .A1(n485), .A2(n218), .ZN(n553) );
  ND2D1BWP16P90LVT U408 ( .A1(n216), .A2(n485), .ZN(n551) );
  ND3D4BWP16P90LVT U409 ( .A1(n584), .A2(n585), .A3(n586), .ZN(n159) );
  ND2D1BWP16P90LVT U410 ( .A1(n518), .A2(n164), .ZN(n585) );
  AN2D2BWP16P90LVT U411 ( .A1(n531), .A2(n227), .Z(n487) );
  ND2D1BWP16P90 U412 ( .A1(n202), .A2(n209), .ZN(n541) );
  XNR2D1BWP16P90LVT U413 ( .A1(n564), .A2(b[7]), .ZN(n364) );
  XNR2D2BWP16P90 U414 ( .A1(n587), .A2(b[2]), .ZN(n386) );
  INVD1BWP16P90 U415 ( .I(n198), .ZN(n603) );
  ND2D2BWP16P90LVT U416 ( .A1(n411), .A2(n16), .ZN(n17) );
  CKND2D2BWP16P90LVT U417 ( .A1(n411), .A2(n16), .ZN(n595) );
  ND2D2BWP16P90LVT U418 ( .A1(n21), .A2(n410), .ZN(n488) );
  ND2D2BWP16P90LVT U419 ( .A1(n559), .A2(n181), .ZN(n489) );
  ND2D1BWP16P90LVT U420 ( .A1(n559), .A2(n181), .ZN(n72) );
  XOR2D4BWP16P90LVT U421 ( .A1(n583), .A2(n162), .Z(n160) );
  INVD1BWP16P90 U422 ( .I(n489), .ZN(n490) );
  INVD1BWP16P90LVT U423 ( .I(n490), .ZN(n491) );
  ND2D1BWP16P90LVT U424 ( .A1(n626), .A2(n591), .ZN(n592) );
  CKND2D2BWP16P90LVT U425 ( .A1(n527), .A2(n410), .ZN(n23) );
  OAI21D1BWP16P90LVT U426 ( .A1(n68), .A2(n489), .B(n69), .ZN(n492) );
  CKND2D2BWP16P90LVT U427 ( .A1(n578), .A2(n579), .ZN(n265) );
  OAI22D1BWP16P90LVT U428 ( .A1(n343), .A2(n23), .B1(n342), .B2(n527), .ZN(
        n267) );
  OAI21D1BWP16P90LVT U429 ( .A1(n68), .A2(n72), .B(n69), .ZN(n67) );
  ND2D1BWP16P90 U430 ( .A1(n176), .A2(n183), .ZN(n549) );
  OAI22D2BWP16P90LVT U431 ( .A1(n356), .A2(n594), .B1(n355), .B2(n609), .ZN(
        n279) );
  INVD4BWP16P90LVT U432 ( .I(n424), .ZN(n537) );
  XOR2D4BWP16P90LVT U433 ( .A1(n290), .A2(n225), .Z(n493) );
  XOR2D4BWP16P90LVT U434 ( .A1(n493), .A2(n222), .Z(n220) );
  ND2D1BWP16P90 U435 ( .A1(n222), .A2(n225), .ZN(n494) );
  ND2D1BWP16P90 U436 ( .A1(n222), .A2(n290), .ZN(n495) );
  ND2D1BWP16P90 U437 ( .A1(n225), .A2(n290), .ZN(n496) );
  ND3D1BWP16P90LVT U438 ( .A1(n494), .A2(n495), .A3(n496), .ZN(n219) );
  XNR2D2BWP16P90LVT U439 ( .A1(n607), .A2(n278), .ZN(n222) );
  ND2D2BWP16P90LVT U440 ( .A1(n214), .A2(n219), .ZN(n99) );
  OAI22D2BWP16P90LVT U441 ( .A1(n563), .A2(n331), .B1(n330), .B2(n27), .ZN(
        n256) );
  ND2D1BWP16P90LVT U442 ( .A1(n148), .A2(n159), .ZN(n528) );
  XOR3D4BWP16P90LVT U443 ( .A1(n142), .A2(n149), .A3(n141), .Z(n140) );
  XOR3D2BWP16P90LVT U444 ( .A1(n155), .A2(n145), .A3(n144), .Z(n142) );
  XNR2D2BWP16P90 U445 ( .A1(n519), .A2(b[9]), .ZN(n334) );
  ND2D1BWP16P90LVT U446 ( .A1(n70), .A2(n47), .ZN(n499) );
  ND2D2BWP16P90LVT U447 ( .A1(n497), .A2(n498), .ZN(n500) );
  ND2D1BWP16P90LVT U448 ( .A1(n499), .A2(n500), .ZN(product[13]) );
  INVD2BWP16P90LVT U449 ( .I(n70), .ZN(n497) );
  CKND2BWP20P90LVT U450 ( .I(n47), .ZN(n498) );
  ND2D1BWP16P90 U451 ( .A1(n127), .A2(n69), .ZN(n47) );
  XOR2D2BWP16P90LVT U452 ( .A1(n196), .A2(n201), .Z(n610) );
  OAI21D1BWP16P90LVT U453 ( .A1(n95), .A2(n93), .B(n94), .ZN(n501) );
  INR2D1BWP16P90LVT U454 ( .A1(n630), .B1(n609), .ZN(n280) );
  DEL025D1BWP16P90LVT U455 ( .I(n598), .Z(n502) );
  AO21D4BWP16P90LVT U456 ( .A1(n501), .A2(n599), .B(n89), .Z(n503) );
  XNR2D2BWP16P90LVT U457 ( .A1(b[1]), .A2(n627), .ZN(n355) );
  OAI22D1BWP16P90 U458 ( .A1(n594), .A2(n347), .B1(n609), .B2(n346), .ZN(n270)
         );
  BUFFD4BWP16P90LVT U459 ( .I(a[7]), .Z(n504) );
  XOR3D4BWP16P90LVT U460 ( .A1(n197), .A2(n195), .A3(n188), .Z(n184) );
  ND2D1BWP16P90LVT U461 ( .A1(n195), .A2(n188), .ZN(n505) );
  ND2D1BWP16P90 U462 ( .A1(n195), .A2(n197), .ZN(n506) );
  ND2D1BWP16P90LVT U463 ( .A1(n188), .A2(n197), .ZN(n507) );
  ND3D2BWP16P90LVT U464 ( .A1(n505), .A2(n506), .A3(n507), .ZN(n183) );
  BUFFD4BWP16P90LVT U465 ( .I(a[7]), .Z(n628) );
  ND2D1BWP16P90LVT U466 ( .A1(n184), .A2(n545), .ZN(n556) );
  ND2D2BWP16P90LVT U467 ( .A1(n184), .A2(n524), .ZN(n557) );
  CKND2D4BWP16P90LVT U468 ( .A1(n412), .A2(n9), .ZN(n508) );
  CKND2D4BWP16P90LVT U469 ( .A1(n412), .A2(n9), .ZN(n509) );
  ND2D4BWP16P90LVT U470 ( .A1(n592), .A2(n593), .ZN(n412) );
  XOR2D4BWP16P90LVT U471 ( .A1(n164), .A2(n173), .Z(n583) );
  ND2D1BWP16P90LVT U472 ( .A1(n173), .A2(n164), .ZN(n586) );
  ND2D1BWP16P90LVT U473 ( .A1(n518), .A2(n173), .ZN(n584) );
  ND2D1BWP16P90LVT U474 ( .A1(n537), .A2(b[6]), .ZN(n512) );
  ND2D2BWP16P90LVT U475 ( .A1(n510), .A2(n511), .ZN(n513) );
  ND2D2BWP16P90LVT U476 ( .A1(n512), .A2(n513), .ZN(n350) );
  CKND2BWP16P90LVT U477 ( .I(n537), .ZN(n510) );
  CKND1BWP16P90 U478 ( .I(b[6]), .ZN(n511) );
  ND2D1BWP16P90LVT U479 ( .A1(n174), .A2(n183), .ZN(n548) );
  IND2D4BWP16P90LVT U480 ( .A1(n227), .B1(n514), .ZN(n135) );
  ND3D2BWP16P90LVT U481 ( .A1(n571), .A2(n572), .A3(n573), .ZN(n173) );
  XNR2D4BWP16P90LVT U482 ( .A1(n624), .A2(b[6]), .ZN(n382) );
  XNR2D1BWP16P90 U483 ( .A1(n625), .A2(b[9]), .ZN(n379) );
  XNR2D1BWP16P90LVT U484 ( .A1(b[5]), .A2(n629), .ZN(n327) );
  ND2D1BWP16P90LVT U485 ( .A1(n567), .A2(n568), .ZN(n339) );
  OAI22D1BWP16P90LVT U486 ( .A1(n39), .A2(n315), .B1(n314), .B2(n530), .ZN(
        n242) );
  OAI22D1BWP16P90LVT U487 ( .A1(n582), .A2(n322), .B1(n321), .B2(n32), .ZN(
        n248) );
  OAI22D2BWP16P90LVT U488 ( .A1(n12), .A2(n362), .B1(n9), .B2(n361), .ZN(n284)
         );
  OAI22D1BWP16P90LVT U489 ( .A1(n6), .A2(n379), .B1(n378), .B2(n418), .ZN(n300) );
  XNR2D4BWP16P90LVT U490 ( .A1(n51), .A2(n521), .ZN(product[9]) );
  XNR2D1BWP16P90LVT U491 ( .A1(n53), .A2(n522), .ZN(product[7]) );
  XOR2D1BWP16P90LVT U492 ( .A1(n52), .A2(n569), .Z(product[8]) );
  ND2D2BWP16P90LVT U493 ( .A1(n64), .A2(n126), .ZN(n46) );
  XOR2D4BWP16P90LVT U494 ( .A1(n65), .A2(n46), .Z(product[14]) );
  OAI22D2BWP16P90LVT U495 ( .A1(n316), .A2(n39), .B1(n315), .B2(n530), .ZN(
        n243) );
  XNR2D2BWP16P90LVT U496 ( .A1(n630), .A2(a[13]), .ZN(n316) );
  ND2D2BWP16P90LVT U497 ( .A1(n622), .A2(n623), .ZN(n278) );
  CKOR2D1BWP16P90LVT U498 ( .A1(n354), .A2(n609), .Z(n623) );
  CKND8BWP16P90LVT U499 ( .I(a[0]), .ZN(n418) );
  OAI22D1BWP16P90LVT U500 ( .A1(n6), .A2(n383), .B1(n382), .B2(n418), .ZN(n529) );
  FA1D1BWP16P90LVT U501 ( .A(n252), .B(n270), .CI(n260), .CO(n155), .S(n156)
         );
  XNR2D2BWP16P90LVT U502 ( .A1(b[1]), .A2(a[13]), .ZN(n315) );
  XNR2D2BWP16P90LVT U503 ( .A1(n504), .A2(b[6]), .ZN(n337) );
  CKND2BWP16P90LVT U504 ( .I(n224), .ZN(n514) );
  XNR2D1BWP16P90 U505 ( .A1(n630), .A2(n504), .ZN(n343) );
  XNR2D2BWP16P90LVT U506 ( .A1(b[5]), .A2(n504), .ZN(n338) );
  XNR2D1BWP16P90 U507 ( .A1(n504), .A2(b[8]), .ZN(n335) );
  OAI22D2BWP16P90LVT U508 ( .A1(n595), .A2(n353), .B1(n352), .B2(n609), .ZN(
        n276) );
  BUFFD2BWP16P90LVT U509 ( .I(n27), .Z(n515) );
  XNR2D4BWP16P90LVT U510 ( .A1(n588), .A2(a[6]), .ZN(n21) );
  XNR2D2BWP16P90LVT U511 ( .A1(b[9]), .A2(n588), .ZN(n347) );
  XNR2D4BWP16P90LVT U512 ( .A1(n588), .A2(a[6]), .ZN(n527) );
  XNR2D2BWP16P90LVT U513 ( .A1(n624), .A2(b[12]), .ZN(n376) );
  XNR2D2BWP16P90 U514 ( .A1(n587), .A2(b[10]), .ZN(n378) );
  XNR2D1BWP16P90LVT U515 ( .A1(n520), .A2(n630), .ZN(n356) );
  XOR3D2BWP16P90LVT U516 ( .A1(n299), .A2(n285), .A3(n190), .Z(n524) );
  OR2D2BWP16P90LVT U517 ( .A1(n339), .A2(n527), .Z(n618) );
  DEL025D1BWP16P90 U518 ( .I(n103), .Z(n516) );
  OR2D1BWP16P90LVT U519 ( .A1(n562), .A2(n340), .Z(n617) );
  XOR2D4BWP16P90LVT U520 ( .A1(a[11]), .A2(a[10]), .Z(n408) );
  OR2D2BWP16P90LVT U521 ( .A1(a[11]), .A2(a[12]), .Z(n581) );
  BUFFD4BWP16P90LVT U522 ( .I(n504), .Z(n519) );
  INVD1BWP16P90 U523 ( .I(n424), .ZN(n520) );
  INVD4BWP16P90LVT U524 ( .I(n627), .ZN(n424) );
  XOR2D1BWP20P90 U525 ( .A1(n54), .A2(n516), .Z(product[6]) );
  INVD1BWP16P90LVT U526 ( .I(n504), .ZN(n566) );
  CKND2D4BWP16P90LVT U527 ( .A1(n27), .A2(n409), .ZN(n526) );
  XNR2D4BWP16P90LVT U528 ( .A1(n304), .A2(n268), .ZN(n607) );
  DEL025D1BWP16P90LVT U529 ( .I(n501), .Z(n521) );
  DEL025D1BWP16P90 U530 ( .I(n100), .Z(n522) );
  DEL025D1BWP16P90 U531 ( .I(n111), .Z(n523) );
  AOI21D2BWP16P90LVT U532 ( .A1(n604), .A2(n601), .B(n113), .ZN(n111) );
  CKOR2D2BWP16P90LVT U533 ( .A1(n594), .A2(n355), .Z(n622) );
  XNR2D2BWP16P90LVT U534 ( .A1(n589), .A2(b[10]), .ZN(n346) );
  INVD1BWP16P90LVT U535 ( .I(n68), .ZN(n127) );
  NR2D2BWP16P90LVT U536 ( .A1(n160), .A2(n171), .ZN(n68) );
  HA1D2BWP16P90LVT U537 ( .A(n249), .B(n255), .CO(n189), .S(n190) );
  ND2D2BWP16P90LVT U538 ( .A1(n27), .A2(n409), .ZN(n525) );
  ND2D2BWP16P90LVT U539 ( .A1(n27), .A2(n409), .ZN(n563) );
  XNR2D2BWP16P90LVT U540 ( .A1(n537), .A2(b[8]), .ZN(n348) );
  XNR2D2BWP16P90 U541 ( .A1(n589), .A2(b[11]), .ZN(n345) );
  XNR2D2BWP16P90 U542 ( .A1(n589), .A2(b[5]), .ZN(n351) );
  ND3D2BWP16P90LVT U543 ( .A1(n614), .A2(n615), .A3(n616), .ZN(n191) );
  ND2D1BWP16P90LVT U544 ( .A1(n194), .A2(n201), .ZN(n616) );
  ND2D1BWP16P90LVT U545 ( .A1(n27), .A2(n409), .ZN(n29) );
  ND2D1BWP16P90LVT U546 ( .A1(a[11]), .A2(a[12]), .ZN(n580) );
  OAI22D1BWP16P90LVT U547 ( .A1(n509), .A2(n363), .B1(n9), .B2(n362), .ZN(n285) );
  XNR2D2BWP16P90LVT U548 ( .A1(n564), .A2(b[9]), .ZN(n362) );
  OAI22D4BWP16P90LVT U549 ( .A1(n526), .A2(n330), .B1(n329), .B2(n27), .ZN(
        n255) );
  XNR2D4BWP16P90LVT U550 ( .A1(b[2]), .A2(n629), .ZN(n330) );
  XNR2D2BWP16P90LVT U551 ( .A1(b[4]), .A2(a[11]), .ZN(n319) );
  OAI22D4BWP16P90LVT U552 ( .A1(n6), .A2(n383), .B1(n382), .B2(n418), .ZN(n304) );
  OAI22D1BWP16P90LVT U553 ( .A1(n509), .A2(n359), .B1(n9), .B2(n358), .ZN(n281) );
  OAI22D2BWP16P90LVT U554 ( .A1(n594), .A2(n350), .B1(n609), .B2(n349), .ZN(
        n273) );
  ND2D2BWP16P90LVT U555 ( .A1(n580), .A2(n581), .ZN(n530) );
  HA1D1BWP16P90LVT U556 ( .A(n243), .B(n247), .CO(n169), .S(n170) );
  OAI22D1BWP16P90LVT U557 ( .A1(n23), .A2(n337), .B1(n336), .B2(n527), .ZN(
        n261) );
  ND2D1BWP16P90LVT U558 ( .A1(n265), .A2(n287), .ZN(n576) );
  ND2D1BWP16P90LVT U559 ( .A1(n278), .A2(n268), .ZN(n620) );
  XNR2D2BWP16P90LVT U560 ( .A1(n587), .A2(b[13]), .ZN(n375) );
  XOR3D1BWP16P90LVT U561 ( .A1(n608), .A2(n291), .A3(n226), .Z(n531) );
  OAI22D2BWP16P90LVT U562 ( .A1(n323), .A2(n582), .B1(n322), .B2(n32), .ZN(
        n249) );
  OAI22D2BWP16P90LVT U563 ( .A1(n488), .A2(n339), .B1(n338), .B2(n527), .ZN(
        n263) );
  OAI22D1BWP16P90LVT U564 ( .A1(n561), .A2(n342), .B1(n341), .B2(n527), .ZN(
        n266) );
  HA1D2BWP16P90LVT U565 ( .A(n235), .B(n267), .CO(n217), .S(n218) );
  AOI21D4BWP16P90LVT U566 ( .A1(n135), .A2(n108), .B(n487), .ZN(n103) );
  XOR2D8BWP16P90LVT U567 ( .A1(n628), .A2(a[6]), .Z(n410) );
  XNR2D2BWP16P90LVT U568 ( .A1(n519), .A2(b[7]), .ZN(n336) );
  XOR2D4BWP16P90LVT U569 ( .A1(n215), .A2(n212), .Z(n532) );
  XOR2D4BWP16P90LVT U570 ( .A1(n532), .A2(n210), .Z(n208) );
  ND2D1BWP16P90 U571 ( .A1(n210), .A2(n212), .ZN(n533) );
  ND2D1BWP16P90 U572 ( .A1(n210), .A2(n215), .ZN(n534) );
  ND2D1BWP16P90 U573 ( .A1(n212), .A2(n215), .ZN(n535) );
  ND3D1BWP16P90LVT U574 ( .A1(n533), .A2(n534), .A3(n535), .ZN(n207) );
  FA1D1BWP16P90LVT U575 ( .A(n277), .B(n303), .CI(n289), .CO(n215), .S(n216)
         );
  NR2D2BWP16P90LVT U576 ( .A1(n208), .A2(n213), .ZN(n93) );
  ND2D1BWP16P90 U577 ( .A1(n220), .A2(n223), .ZN(n536) );
  BUFFD4BWP16P90LVT U578 ( .I(a[5]), .Z(n588) );
  XOR2D8BWP16P90LVT U579 ( .A1(n625), .A2(a[0]), .Z(n413) );
  INVD1BWP16P90 U580 ( .I(n487), .ZN(n538) );
  XOR2D4BWP16P90LVT U581 ( .A1(n209), .A2(n204), .Z(n539) );
  XOR2D2BWP16P90LVT U582 ( .A1(n539), .A2(n202), .Z(n200) );
  ND2D1BWP16P90 U583 ( .A1(n202), .A2(n204), .ZN(n540) );
  ND2D1BWP16P90 U584 ( .A1(n204), .A2(n209), .ZN(n542) );
  ND3D1BWP16P90LVT U585 ( .A1(n540), .A2(n541), .A3(n542), .ZN(n199) );
  FA1D2BWP16P90LVT U586 ( .A(n301), .B(n206), .CI(n211), .CO(n201), .S(n202)
         );
  XNR2D4BWP16P90LVT U587 ( .A1(n626), .A2(a[4]), .ZN(n609) );
  INVD1BWP16P90LVT U588 ( .I(n626), .ZN(n590) );
  FA1D2BWP16P90LVT U589 ( .A(n167), .B(n165), .CI(n158), .CO(n151), .S(n152)
         );
  INVD1BWP16P90 U590 ( .I(n89), .ZN(n543) );
  XNR2D2BWP16P90LVT U591 ( .A1(b[1]), .A2(a[9]), .ZN(n331) );
  ND2D1BWP16P90LVT U592 ( .A1(n160), .A2(n171), .ZN(n69) );
  XNR2D1BWP16P90LVT U593 ( .A1(b[3]), .A2(a[11]), .ZN(n320) );
  OAI22D1BWP16P90LVT U594 ( .A1(n509), .A2(n368), .B1(n9), .B2(n367), .ZN(n290) );
  CKOR2D2BWP16P90LVT U595 ( .A1(n561), .A2(n341), .Z(n578) );
  OR2D2BWP16P90LVT U596 ( .A1(n192), .A2(n199), .Z(n600) );
  XOR2D4BWP16P90LVT U597 ( .A1(n610), .A2(n194), .Z(n192) );
  XNR2D8BWP16P90LVT U598 ( .A1(n626), .A2(a[4]), .ZN(n16) );
  OAI22D1BWP16P90LVT U599 ( .A1(n6), .A2(n382), .B1(n381), .B2(n418), .ZN(n303) );
  CKND2D1BWP16P90 U600 ( .A1(n554), .A2(n543), .ZN(n51) );
  BUFFD1BWP16P90LVT U601 ( .I(n599), .Z(n554) );
  CKND2D4BWP16P90LVT U602 ( .A1(n21), .A2(n410), .ZN(n562) );
  OAI21D2BWP16P90LVT U603 ( .A1(n596), .A2(n63), .B(n528), .ZN(n62) );
  OR2D4BWP16P90LVT U604 ( .A1(n182), .A2(n191), .Z(n598) );
  XNR2D2BWP16P90 U605 ( .A1(n587), .A2(b[1]), .ZN(n387) );
  OAI22D1BWP16P90 U606 ( .A1(n6), .A2(n374), .B1(n373), .B2(n418), .ZN(n295)
         );
  OAI22D1BWP16P90 U607 ( .A1(n6), .A2(n383), .B1(n382), .B2(n418), .ZN(n597)
         );
  OAI21D4BWP16P90LVT U608 ( .A1(n111), .A2(n109), .B(n110), .ZN(n108) );
  XNR2D2BWP16P90LVT U609 ( .A1(n624), .A2(b[3]), .ZN(n385) );
  XOR2D4BWP16P90LVT U610 ( .A1(n555), .A2(n184), .Z(n182) );
  ND2D1BWP16P90LVT U611 ( .A1(n178), .A2(n180), .ZN(n573) );
  XNR2D2BWP16P90LVT U612 ( .A1(n564), .A2(b[10]), .ZN(n361) );
  INVD1BWP16P90 U613 ( .I(n193), .ZN(n544) );
  INVD1BWP16P90LVT U614 ( .I(n544), .ZN(n545) );
  ND3D2BWP16P90LVT U615 ( .A1(n613), .A2(n612), .A3(n611), .ZN(n193) );
  XNR2D2BWP16P90LVT U616 ( .A1(a[13]), .A2(a[14]), .ZN(n41) );
  XNR2D1BWP16P90LVT U617 ( .A1(b[2]), .A2(a[13]), .ZN(n314) );
  XOR2D2BWP16P90LVT U618 ( .A1(a[13]), .A2(a[12]), .Z(n407) );
  NR2D4BWP16P90LVT U619 ( .A1(n220), .A2(n223), .ZN(n101) );
  XOR2D2BWP16P90LVT U620 ( .A1(n176), .A2(n183), .Z(n546) );
  XOR2D2BWP16P90LVT U621 ( .A1(n546), .A2(n174), .Z(n172) );
  ND2D1BWP16P90 U622 ( .A1(n174), .A2(n176), .ZN(n547) );
  XOR2D2BWP16P90LVT U623 ( .A1(n570), .A2(n185), .Z(n174) );
  NR2D2BWP16P90LVT U624 ( .A1(n172), .A2(n181), .ZN(n71) );
  XNR2D2BWP16P90LVT U625 ( .A1(n624), .A2(b[4]), .ZN(n384) );
  XNR2D2BWP16P90LVT U626 ( .A1(n624), .A2(b[8]), .ZN(n380) );
  XNR2D2BWP16P90LVT U627 ( .A1(n624), .A2(b[14]), .ZN(n374) );
  XOR2D4BWP16P90LVT U628 ( .A1(n218), .A2(n221), .Z(n550) );
  XOR2D4BWP16P90LVT U629 ( .A1(n550), .A2(n216), .Z(n214) );
  ND2D1BWP16P90 U630 ( .A1(n216), .A2(n218), .ZN(n552) );
  ND3D1BWP16P90LVT U631 ( .A1(n551), .A2(n552), .A3(n553), .ZN(n213) );
  OAI22D2BWP16P90LVT U632 ( .A1(n595), .A2(n349), .B1(n609), .B2(n348), .ZN(
        n272) );
  CKND2D4BWP16P90LVT U633 ( .A1(n411), .A2(n16), .ZN(n594) );
  FA1D2BWP16P90LVT U634 ( .A(n298), .B(n189), .CI(n187), .CO(n175), .S(n176)
         );
  FA1D1BWP16P90LVT U635 ( .A(n168), .B(n166), .CI(n175), .CO(n161), .S(n162)
         );
  CKND2D2BWP16P90LVT U636 ( .A1(n590), .A2(a[2]), .ZN(n593) );
  XNR2D8BWP16P90LVT U637 ( .A1(n628), .A2(a[8]), .ZN(n27) );
  XOR2D2BWP16P90LVT U638 ( .A1(a[9]), .A2(a[8]), .Z(n409) );
  ND2D2BWP16P90LVT U639 ( .A1(n208), .A2(n213), .ZN(n94) );
  XOR2D4BWP16P90LVT U640 ( .A1(n186), .A2(n193), .Z(n555) );
  ND2D1BWP16P90 U641 ( .A1(n545), .A2(n524), .ZN(n558) );
  ND3D2BWP16P90LVT U642 ( .A1(n556), .A2(n557), .A3(n558), .ZN(n181) );
  XNR2D8BWP16P90LVT U643 ( .A1(n625), .A2(a[2]), .ZN(n9) );
  XNR2D2BWP16P90LVT U644 ( .A1(n625), .A2(b[5]), .ZN(n383) );
  BUFFD8BWP16P90LVT U645 ( .I(a[1]), .Z(n625) );
  XOR3D2BWP16P90LVT U646 ( .A1(n183), .A2(n176), .A3(n174), .Z(n559) );
  OAI21D2BWP16P90LVT U647 ( .A1(n73), .A2(n71), .B(n491), .ZN(n70) );
  XNR2D2BWP16P90LVT U648 ( .A1(b[3]), .A2(n589), .ZN(n353) );
  OAI21D4BWP16P90LVT U649 ( .A1(n103), .A2(n101), .B(n102), .ZN(n100) );
  ND2D2BWP16P90LVT U650 ( .A1(n220), .A2(n223), .ZN(n102) );
  XOR3D1BWP16P90LVT U651 ( .A1(n152), .A2(n161), .A3(n150), .Z(n560) );
  XNR2D2BWP16P90LVT U652 ( .A1(n589), .A2(b[7]), .ZN(n349) );
  XOR2D2BWP16P90 U653 ( .A1(n73), .A2(n48), .Z(product[12]) );
  CKND2D4BWP16P90LVT U654 ( .A1(n37), .A2(n407), .ZN(n39) );
  XNR2D2BWP16P90LVT U655 ( .A1(n589), .A2(b[4]), .ZN(n352) );
  OR2D2BWP16P90LVT U656 ( .A1(n200), .A2(n207), .Z(n599) );
  CKND2BWP16P90LVT U657 ( .I(n63), .ZN(n126) );
  NR2D2BWP16P90LVT U658 ( .A1(n560), .A2(n159), .ZN(n63) );
  FA1D2BWP16P90LVT U659 ( .A(n274), .B(n300), .CI(n286), .CO(n195), .S(n196)
         );
  XNR2D2BWP16P90LVT U660 ( .A1(b[2]), .A2(n537), .ZN(n354) );
  OAI22D1BWP16P90LVT U661 ( .A1(n508), .A2(n425), .B1(n372), .B2(n9), .ZN(n237) );
  OAI22D1BWP16P90LVT U662 ( .A1(n508), .A2(n361), .B1(n9), .B2(n360), .ZN(n283) );
  OAI22D1BWP16P90LVT U663 ( .A1(n509), .A2(n367), .B1(n9), .B2(n366), .ZN(n289) );
  OAI22D1BWP16P90LVT U664 ( .A1(n509), .A2(n360), .B1(n9), .B2(n359), .ZN(n282) );
  OAI22D1BWP16P90LVT U665 ( .A1(n509), .A2(n369), .B1(n368), .B2(n9), .ZN(n291) );
  BUFFD8BWP16P90LVT U666 ( .I(a[3]), .Z(n564) );
  BUFFD4BWP16P90LVT U667 ( .I(a[3]), .Z(n626) );
  ND2D1BWP16P90 U668 ( .A1(b[4]), .A2(n504), .ZN(n567) );
  ND2D1BWP16P90LVT U669 ( .A1(n565), .A2(n566), .ZN(n568) );
  CKND1BWP16P90 U670 ( .I(b[4]), .ZN(n565) );
  DEL025D1BWP16P90 U671 ( .I(n95), .Z(n569) );
  AOI21D4BWP16P90LVT U672 ( .A1(n100), .A2(n602), .B(n97), .ZN(n95) );
  ND2D1BWP16P90 U673 ( .A1(n602), .A2(n99), .ZN(n53) );
  ND2D2BWP16P90LVT U674 ( .A1(n598), .A2(n600), .ZN(n75) );
  XOR2D2BWP16P90LVT U675 ( .A1(n178), .A2(n180), .Z(n570) );
  ND2D1BWP16P90 U676 ( .A1(n185), .A2(n180), .ZN(n571) );
  ND2D1BWP16P90LVT U677 ( .A1(n185), .A2(n178), .ZN(n572) );
  XNR2D2BWP16P90LVT U678 ( .A1(b[1]), .A2(n504), .ZN(n342) );
  OAI21D2BWP16P90LVT U679 ( .A1(n87), .A2(n75), .B(n76), .ZN(n74) );
  XOR2D2BWP16P90LVT U680 ( .A1(n287), .A2(n275), .Z(n574) );
  XOR2D2BWP16P90LVT U681 ( .A1(n574), .A2(n265), .Z(n204) );
  ND2D1BWP16P90LVT U682 ( .A1(n265), .A2(n275), .ZN(n575) );
  ND2D1BWP16P90LVT U683 ( .A1(n275), .A2(n287), .ZN(n577) );
  ND3D4BWP16P90LVT U684 ( .A1(n575), .A2(n576), .A3(n577), .ZN(n203) );
  CKOR2D2BWP16P90 U685 ( .A1(n340), .A2(n21), .Z(n579) );
  XNR3D4BWP16P90LVT U686 ( .A1(n205), .A2(n203), .A3(n603), .ZN(n194) );
  XNR2D2BWP16P90LVT U687 ( .A1(b[2]), .A2(n504), .ZN(n341) );
  XNR2D2BWP16P90LVT U688 ( .A1(b[3]), .A2(n504), .ZN(n340) );
  ND2D2BWP16P90LVT U689 ( .A1(n580), .A2(n581), .ZN(n37) );
  INVD1BWP16P90LVT U690 ( .I(n74), .ZN(n73) );
  OAI22D1BWP16P90LVT U691 ( .A1(n6), .A2(n384), .B1(n383), .B2(n418), .ZN(n305) );
  OAI22D1BWP16P90LVT U692 ( .A1(n6), .A2(n376), .B1(n375), .B2(n418), .ZN(n297) );
  CKND2D8BWP16P90LVT U693 ( .A1(n413), .A2(n418), .ZN(n6) );
  FA1D2BWP16P90LVT U694 ( .A(n170), .B(n179), .CI(n177), .CO(n163), .S(n164)
         );
  BUFFD2BWP16P90LVT U695 ( .I(a[1]), .Z(n587) );
  BUFFD2BWP16P90LVT U696 ( .I(a[5]), .Z(n589) );
  BUFFD4BWP16P90LVT U697 ( .I(a[5]), .Z(n627) );
  CKND1BWP16P90LVT U698 ( .I(a[2]), .ZN(n591) );
  OAI22D1BWP16P90LVT U699 ( .A1(n508), .A2(n364), .B1(n9), .B2(n363), .ZN(n286) );
  INVD1BWP16P90LVT U700 ( .I(n80), .ZN(n78) );
  XNR2D1BWP16P90 U701 ( .A1(n624), .A2(b[15]), .ZN(n373) );
  AOI21D1BWP16P90LVT U702 ( .A1(n74), .A2(n66), .B(n67), .ZN(n596) );
  FA1D1BWP16P90LVT U703 ( .A(n608), .B(n291), .CI(n226), .CO(n223), .S(n224)
         );
  BUFFD2BWP16P90LVT U704 ( .I(a[1]), .Z(n624) );
  CKND2BWP16P90LVT U705 ( .I(n99), .ZN(n97) );
  CKND2BWP16P90LVT U706 ( .I(n91), .ZN(n89) );
  INVD1BWP16P90LVT U707 ( .I(n124), .ZN(n122) );
  INR2D1BWP16P90 U708 ( .A1(n630), .B1(n41), .ZN(n240) );
  IND2D1BWP16P90 U709 ( .A1(n630), .B1(a[11]), .ZN(n324) );
  INVD1BWP16P90 U710 ( .I(a[11]), .ZN(n421) );
  IND2D1BWP16P90 U711 ( .A1(n630), .B1(n629), .ZN(n333) );
  ND2D1BWP16P90 U712 ( .A1(n600), .A2(n85), .ZN(n50) );
  INVD1BWP16P90 U713 ( .I(n629), .ZN(n422) );
  INR2D1BWP16P90 U714 ( .A1(n630), .B1(n418), .ZN(product[0]) );
  ND2D1BWP16P90LVT U715 ( .A1(n200), .A2(n207), .ZN(n91) );
  INVD1BWP16P90LVT U716 ( .I(n115), .ZN(n113) );
  IOA21D1BWP16P90LVT U717 ( .A1(n606), .A2(n122), .B(n121), .ZN(n601) );
  ND2D1BWP16P90LVT U718 ( .A1(n198), .A2(n205), .ZN(n612) );
  ND2D1BWP16P90LVT U719 ( .A1(n198), .A2(n203), .ZN(n613) );
  OR2D1BWP16P90LVT U720 ( .A1(n230), .A2(n293), .Z(n604) );
  ND2D1BWP16P90LVT U721 ( .A1(n309), .A2(n238), .ZN(n124) );
  NR2D1BWP16P90LVT U722 ( .A1(n228), .A2(n229), .ZN(n109) );
  OR2D1BWP16P90LVT U723 ( .A1(n147), .A2(n140), .Z(n605) );
  OR2D1BWP16P90LVT U724 ( .A1(n308), .A2(n294), .Z(n606) );
  XNR2D1BWP16P90 U725 ( .A1(n55), .A2(n108), .ZN(product[5]) );
  XOR2D1BWP16P90 U726 ( .A1(n56), .A2(n523), .Z(product[4]) );
  INVD1BWP16P90 U727 ( .I(n109), .ZN(n136) );
  XNR2D1BWP16P90 U728 ( .A1(n57), .A2(n601), .ZN(product[3]) );
  XNR2D1BWP16P90 U729 ( .A1(n58), .A2(n122), .ZN(product[2]) );
  CKND1BWP16P90LVT U730 ( .I(n59), .ZN(product[1]) );
  CKND1BWP16P90LVT U731 ( .I(n123), .ZN(n139) );
  NR2D1BWP16P90 U732 ( .A1(n309), .A2(n238), .ZN(n123) );
  OAI22D1BWP16P90LVT U733 ( .A1(n486), .A2(n421), .B1(n324), .B2(n32), .ZN(
        n233) );
  XOR2D1BWP16P90LVT U734 ( .A1(n81), .A2(n49), .Z(product[11]) );
  INR2D1BWP16P90LVT U735 ( .A1(n630), .B1(n515), .ZN(n258) );
  INR2D1BWP16P90LVT U736 ( .A1(n630), .B1(n530), .ZN(n244) );
  XNR2D1BWP16P90LVT U737 ( .A1(n630), .A2(n629), .ZN(n332) );
  XNR2D1BWP16P90LVT U738 ( .A1(n630), .A2(a[11]), .ZN(n323) );
  CKND1BWP16P90LVT U739 ( .I(n625), .ZN(n426) );
  OAI22D1BWP16P90LVT U740 ( .A1(n388), .A2(n6), .B1(n387), .B2(n418), .ZN(n309) );
  XOR3D1BWP16P90LVT U741 ( .A1(n153), .A2(n143), .A3(n151), .Z(n141) );
  XOR3D1BWP16P90LVT U742 ( .A1(n259), .A2(n269), .A3(n295), .Z(n144) );
  ND2D1BWP16P90 U743 ( .A1(n128), .A2(n489), .ZN(n48) );
  INVD1BWP16P90 U744 ( .I(n71), .ZN(n128) );
  XOR3D1BWP16P90LVT U745 ( .A1(n231), .A2(n245), .A3(n251), .Z(n145) );
  ND2D1BWP16P90 U746 ( .A1(n132), .A2(n94), .ZN(n52) );
  INVD1BWP16P90 U747 ( .I(n93), .ZN(n132) );
  ND2D1BWP16P90 U748 ( .A1(n134), .A2(n536), .ZN(n54) );
  INVD1BWP16P90 U749 ( .I(n101), .ZN(n134) );
  BUFFD4BWP16P90LVT U750 ( .I(a[9]), .Z(n629) );
  XNR2D4BWP16P90LVT U751 ( .A1(a[9]), .A2(a[10]), .ZN(n32) );
  XNR2D1BWP16P90LVT U752 ( .A1(b[2]), .A2(a[11]), .ZN(n321) );
  XNR2D1BWP16P90 U753 ( .A1(n564), .A2(b[8]), .ZN(n363) );
  BUFFD8BWP16P90LVT U754 ( .I(b[0]), .Z(n630) );
  XOR3D1BWP16P90LVT U755 ( .A1(n239), .A2(n146), .A3(n157), .Z(n143) );
  XOR2D1BWP16P90LVT U756 ( .A1(n281), .A2(n241), .Z(n146) );
  XNR2D1BWP16P90 U757 ( .A1(n630), .A2(a[15]), .ZN(n311) );
  XNR2D1BWP16P90 U758 ( .A1(b[6]), .A2(a[9]), .ZN(n326) );
  XNR2D1BWP16P90 U759 ( .A1(n587), .A2(b[11]), .ZN(n377) );
  XNR2D1BWP16P90 U760 ( .A1(b[3]), .A2(a[13]), .ZN(n313) );
  XOR2D1BWP16P90 U761 ( .A1(a[15]), .A2(a[14]), .Z(n406) );
  IND2D1BWP16P90 U762 ( .A1(n630), .B1(a[15]), .ZN(n312) );
  XNR2D1BWP16P90 U763 ( .A1(b[1]), .A2(a[15]), .ZN(n310) );
  INVD1BWP16P90 U764 ( .I(a[15]), .ZN(n419) );
  XNR2D1BWP16P90 U765 ( .A1(b[7]), .A2(n629), .ZN(n325) );
  OAI22D1BWP16P90LVT U766 ( .A1(n12), .A2(n365), .B1(n9), .B2(n364), .ZN(n287)
         );
  XNR2D1BWP16P90 U767 ( .A1(n630), .A2(n564), .ZN(n371) );
  XNR2D1BWP16P90 U768 ( .A1(n564), .A2(b[2]), .ZN(n369) );
  XNR2D1BWP16P90LVT U769 ( .A1(b[5]), .A2(a[11]), .ZN(n318) );
  OAI22D1BWP16P90LVT U770 ( .A1(n508), .A2(n370), .B1(n369), .B2(n9), .ZN(n292) );
  IND2D1BWP16P90 U771 ( .A1(n630), .B1(n587), .ZN(n389) );
  XNR2D1BWP16P90 U772 ( .A1(n630), .A2(n587), .ZN(n388) );
  INVD1BWP16P90 U773 ( .I(n564), .ZN(n425) );
  XNR2D1BWP16P90 U774 ( .A1(n564), .A2(b[13]), .ZN(n358) );
  XNR2D1BWP16P90 U775 ( .A1(n564), .A2(b[3]), .ZN(n368) );
  XNR2D1BWP16P90 U776 ( .A1(n564), .A2(b[4]), .ZN(n367) );
  XNR2D1BWP16P90 U777 ( .A1(n564), .A2(b[5]), .ZN(n366) );
  XNR2D1BWP16P90 U778 ( .A1(n564), .A2(b[11]), .ZN(n360) );
  XNR2D1BWP16P90 U779 ( .A1(n564), .A2(b[12]), .ZN(n359) );
  XNR2D1BWP16P90 U780 ( .A1(n564), .A2(b[6]), .ZN(n365) );
  XNR2D1BWP16P90 U781 ( .A1(n564), .A2(b[1]), .ZN(n370) );
  OAI22D1BWP16P90LVT U782 ( .A1(n594), .A2(n352), .B1(n351), .B2(n609), .ZN(
        n275) );
  ND2D1BWP16P90 U783 ( .A1(n135), .A2(n538), .ZN(n55) );
  BUFFD2BWP16P90LVT U784 ( .I(n305), .Z(n608) );
  INR2D1BWP16P90 U785 ( .A1(n630), .B1(n9), .ZN(n294) );
  INVD1BWP16P90 U786 ( .I(n519), .ZN(n423) );
  IND2D1BWP16P90 U787 ( .A1(n630), .B1(n519), .ZN(n344) );
  IND2D1BWP16P90 U788 ( .A1(n630), .B1(n537), .ZN(n357) );
  OAI22D1BWP16P90 U789 ( .A1(n23), .A2(n335), .B1(n334), .B2(n527), .ZN(n259)
         );
  OAI22D1BWP16P90 U790 ( .A1(n488), .A2(n336), .B1(n335), .B2(n527), .ZN(n260)
         );
  ND2D1BWP16P90 U791 ( .A1(n502), .A2(n80), .ZN(n49) );
  IND2D1BWP16P90 U792 ( .A1(n630), .B1(n564), .ZN(n372) );
  OAI22D1BWP16P90 U793 ( .A1(n508), .A2(n366), .B1(n9), .B2(n365), .ZN(n288)
         );
  OAI22D1BWP16P90 U794 ( .A1(n371), .A2(n508), .B1(n370), .B2(n9), .ZN(n293)
         );
  IND2D1BWP16P90 U795 ( .A1(n630), .B1(a[13]), .ZN(n317) );
  INVD1BWP16P90LVT U796 ( .I(a[13]), .ZN(n420) );
  FA1D2BWP16P90LVT U797 ( .A(n299), .B(n285), .CI(n190), .CO(n185), .S(n186)
         );
  OAI22D1BWP16P90 U798 ( .A1(n595), .A2(n346), .B1(n609), .B2(n345), .ZN(n269)
         );
  ND2D1BWP16P90LVT U799 ( .A1(n205), .A2(n203), .ZN(n611) );
  ND2D1BWP16P90 U800 ( .A1(n196), .A2(n201), .ZN(n614) );
  ND2D1BWP16P90LVT U801 ( .A1(n196), .A2(n194), .ZN(n615) );
  ND2D2BWP16P90LVT U802 ( .A1(n617), .A2(n618), .ZN(n264) );
  ND2D1BWP16P90LVT U803 ( .A1(n278), .A2(n597), .ZN(n619) );
  ND2D1BWP16P90 U804 ( .A1(n529), .A2(n268), .ZN(n621) );
  INR2D1BWP16P90LVT U805 ( .A1(n630), .B1(n527), .ZN(n268) );
  AOI21D2BWP16P90LVT U806 ( .A1(n598), .A2(n83), .B(n78), .ZN(n76) );
  AOI21D1BWP16P90LVT U807 ( .A1(n503), .A2(n600), .B(n83), .ZN(n81) );
  ND2D2BWP16P90LVT U808 ( .A1(n192), .A2(n199), .ZN(n85) );
  XOR2D4BWP16P90LVT U809 ( .A1(n627), .A2(a[4]), .Z(n411) );
  NR2D1BWP16P90LVT U810 ( .A1(n68), .A2(n71), .ZN(n66) );
  AOI21D4BWP16P90LVT U811 ( .A1(n92), .A2(n599), .B(n89), .ZN(n87) );
  XNR2D1BWP16P90LVT U812 ( .A1(b[1]), .A2(a[11]), .ZN(n322) );
  XNR2D1BWP16P90LVT U813 ( .A1(n62), .A2(n45), .ZN(product[15]) );
  AOI21D1BWP16P90LVT U814 ( .A1(n74), .A2(n66), .B(n492), .ZN(n65) );
  OAI21D4BWP16P90LVT U815 ( .A1(n95), .A2(n93), .B(n94), .ZN(n92) );
  CKND2BWP16P90LVT U816 ( .I(n85), .ZN(n83) );
endmodule


module stage2_cg ( d, sum, c );
  output [15:0] d;
  input [15:0] sum;
  input [15:0] c;
  wire   SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4,
         SYNOPSYS_UNCONNECTED_5, SYNOPSYS_UNCONNECTED_6,
         SYNOPSYS_UNCONNECTED_7, SYNOPSYS_UNCONNECTED_8,
         SYNOPSYS_UNCONNECTED_9, SYNOPSYS_UNCONNECTED_10,
         SYNOPSYS_UNCONNECTED_11, SYNOPSYS_UNCONNECTED_12,
         SYNOPSYS_UNCONNECTED_13, SYNOPSYS_UNCONNECTED_14,
         SYNOPSYS_UNCONNECTED_15, SYNOPSYS_UNCONNECTED_16;

  stage2_cg_DW_mult_uns_2 mult_37 ( .a(sum), .b(c), .\product[15] (d[15]), 
        .\product[14] (d[14]), .\product[13] (d[13]), .\product[12] (d[12]), 
        .\product[11] (d[11]), .\product[10] (d[10]), .\product[9] (d[9]), 
        .\product[8] (d[8]), .\product[7] (d[7]), .\product[6] (d[6]), 
        .\product[5] (d[5]), .\product[4] (d[4]), .\product[3] (d[3]), 
        .\product[2] (d[2]), .\product[1] (d[1]), .\product[0] (d[0]) );
endmodule


module hw2_cg ( d, a, b, c, s, rst, clk );
  output [15:0] d;
  input [7:0] a;
  input [7:0] b;
  input [7:0] c;
  input s, rst, clk;
  wire   n_Logic0_, gclk, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14,
         N15, N16, N17, N18, n2, n30, n90, n100, n110, n120, n130, n140, n150,
         n160, n170, n180, n19, n20, n21, n22, n23, n24;
  wire   [15:0] c0;
  wire   [15:0] sum;
  wire   [15:0] sumo;
  wire   [15:0] c1;
  wire   [15:0] product;

  OA21D1BWP16P90LVT U4 ( .A1(n2), .A2(n30), .B(clk), .Z(gclk) );
  DFCNQD2BWP16P90LVT d_reg_12_ ( .D(N15), .CP(clk), .CDN(n24), .Q(d[12]) );
  DFCNQD2BWP16P90LVT d_reg_10_ ( .D(N13), .CP(clk), .CDN(n24), .Q(d[10]) );
  DFCNQD2BWP16P90LVT d_reg_9_ ( .D(N12), .CP(clk), .CDN(n24), .Q(d[9]) );
  DFCNQD2BWP16P90LVT d_reg_8_ ( .D(N11), .CP(clk), .CDN(n24), .Q(d[8]) );
  DFCNQD2BWP16P90LVT d_reg_7_ ( .D(N10), .CP(clk), .CDN(n24), .Q(d[7]) );
  DFCNQD2BWP16P90LVT d_reg_6_ ( .D(N9), .CP(clk), .CDN(n24), .Q(d[6]) );
  DFCNQD2BWP16P90LVT d_reg_5_ ( .D(N8), .CP(clk), .CDN(n24), .Q(d[5]) );
  DFCNQD2BWP16P90LVT d_reg_4_ ( .D(N7), .CP(clk), .CDN(n24), .Q(d[4]) );
  DFCNQD2BWP16P90LVT d_reg_3_ ( .D(N6), .CP(clk), .CDN(n24), .Q(d[3]) );
  DFCNQD2BWP16P90LVT d_reg_2_ ( .D(N5), .CP(clk), .CDN(n24), .Q(d[2]) );
  DFCNQD2BWP16P90LVT d_reg_1_ ( .D(N4), .CP(clk), .CDN(n24), .Q(d[1]) );
  DFCNQD2BWP16P90LVT d_reg_0_ ( .D(N3), .CP(clk), .CDN(n24), .Q(d[0]) );
  clock_gate16_0 cg2 ( .Q(c0), .D({n_Logic0_, n_Logic0_, n_Logic0_, n_Logic0_, 
        n_Logic0_, n_Logic0_, n_Logic0_, n_Logic0_, n100, n110, n120, n130, 
        n140, n150, n160, n170}), .en(clk), .rst(rst) );
  stage1_cg uut1 ( .sum(sum), .a(a), .b(b), .s(s) );
  clock_gate16_2 cg0 ( .Q(sumo), .D(sum), .en(gclk), .rst(rst) );
  clock_gate16_1 cg1 ( .Q(c1), .D({n_Logic0_, n_Logic0_, n_Logic0_, n_Logic0_, 
        n_Logic0_, n_Logic0_, n_Logic0_, n_Logic0_, n100, n110, n120, n130, 
        n140, n150, n160, n170}), .en(gclk), .rst(rst) );
  stage2_cg uut2 ( .d(product), .sum(sumo), .c(c1) );
  DFCNQD2BWP16P90LVT d_reg_13_ ( .D(N16), .CP(clk), .CDN(n24), .Q(d[13]) );
  DFCNQD2BWP16P90LVT d_reg_15_ ( .D(N18), .CP(clk), .CDN(n24), .Q(d[15]) );
  DFCNQD2BWP16P90LVT d_reg_14_ ( .D(N17), .CP(clk), .CDN(n24), .Q(d[14]) );
  DFCNQD2BWP16P90LVT d_reg_11_ ( .D(N14), .CP(clk), .CDN(n24), .Q(d[11]) );
  TIELBWP20P90LVT U28 ( .ZN(n_Logic0_) );
  AN2D1BWP16P90LVT U29 ( .A1(product[13]), .A2(n90), .Z(N16) );
  CKND16BWP16P90LVT U30 ( .I(n180), .ZN(n90) );
  CKBD1BWP16P90LVT U31 ( .I(c[7]), .Z(n100) );
  CKBD1BWP16P90LVT U32 ( .I(c[6]), .Z(n110) );
  CKBD1BWP16P90LVT U33 ( .I(c[5]), .Z(n120) );
  CKBD1BWP16P90LVT U34 ( .I(c[4]), .Z(n130) );
  CKBD1BWP16P90LVT U35 ( .I(c[3]), .Z(n140) );
  CKBD1BWP16P90LVT U36 ( .I(c[2]), .Z(n150) );
  CKBD1BWP16P90LVT U37 ( .I(c[1]), .Z(n160) );
  CKBD1BWP16P90LVT U38 ( .I(c[0]), .Z(n170) );
  AN2D1BWP16P90LVT U39 ( .A1(product[15]), .A2(n23), .Z(N18) );
  CKND1BWP16P90LVT U40 ( .I(n23), .ZN(n180) );
  INR2D1BWP16P90LVT U41 ( .A1(product[5]), .B1(n180), .ZN(N8) );
  INR2D1BWP16P90LVT U42 ( .A1(product[4]), .B1(n180), .ZN(N7) );
  INR2D1BWP16P90LVT U43 ( .A1(product[3]), .B1(n180), .ZN(N6) );
  INR2D1BWP16P90LVT U44 ( .A1(product[2]), .B1(n180), .ZN(N5) );
  INR2D1BWP16P90LVT U45 ( .A1(product[1]), .B1(n180), .ZN(N4) );
  INR2D1BWP16P90LVT U46 ( .A1(product[0]), .B1(n180), .ZN(N3) );
  ND4D1BWP16P90LVT U47 ( .A1(n22), .A2(n21), .A3(n20), .A4(n19), .ZN(n23) );
  CKND1BWP16P90LVT U48 ( .I(rst), .ZN(n24) );
  OR4D1BWP16P90LVT U49 ( .A1(c[5]), .A2(c[4]), .A3(c[7]), .A4(c[6]), .Z(n2) );
  OR4D1BWP16P90LVT U50 ( .A1(c[1]), .A2(c[0]), .A3(c[3]), .A4(c[2]), .Z(n30)
         );
  NR4D1BWP16P90LVT U51 ( .A1(c0[12]), .A2(c0[13]), .A3(c0[14]), .A4(c0[15]), 
        .ZN(n22) );
  NR4D1BWP16P90LVT U52 ( .A1(c0[8]), .A2(c0[9]), .A3(c0[10]), .A4(c0[11]), 
        .ZN(n21) );
  NR4D1BWP16P90LVT U53 ( .A1(c0[4]), .A2(c0[5]), .A3(c0[6]), .A4(c0[7]), .ZN(
        n20) );
  NR4D1BWP16P90LVT U54 ( .A1(c0[0]), .A2(c0[1]), .A3(c0[2]), .A4(c0[3]), .ZN(
        n19) );
  AN2D1BWP16P90LVT U55 ( .A1(product[6]), .A2(n23), .Z(N9) );
  AN2D1BWP16P90LVT U56 ( .A1(product[7]), .A2(n23), .Z(N10) );
  AN2D1BWP16P90LVT U57 ( .A1(product[8]), .A2(n23), .Z(N11) );
  AN2D1BWP16P90LVT U58 ( .A1(product[9]), .A2(n23), .Z(N12) );
  AN2D1BWP16P90LVT U59 ( .A1(product[10]), .A2(n23), .Z(N13) );
  AN2D1BWP16P90LVT U60 ( .A1(product[11]), .A2(n23), .Z(N14) );
  AN2D1BWP16P90LVT U61 ( .A1(product[12]), .A2(n23), .Z(N15) );
  AN2D1BWP16P90LVT U62 ( .A1(product[14]), .A2(n23), .Z(N17) );
endmodule

