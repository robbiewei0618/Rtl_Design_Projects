/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : V-2023.12
// Date      : Tue Nov 19 00:28:19 2024
/////////////////////////////////////////////////////////////


module Intensity_DW01_add_4 ( \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , 
        \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] , 
        \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] , 
        \SUM[1] , \SUM[0]  );
  input \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] , \B[6] ,
         \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  output \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] ;
  wire   n1, n2, n3, n4, n8, n9, n10, n11, n12, n13, n16, n18, n19, n20, n21,
         n22, n24, n66, n67;
  wire   [8:0] SUM;
  wire   [6:0] A;
  assign \SUM[8]  = SUM[8];
  assign \SUM[7]  = SUM[7];
  assign \SUM[6]  = SUM[6];
  assign \SUM[5]  = SUM[5];
  assign \SUM[4]  = SUM[4];
  assign \SUM[3]  = SUM[3];
  assign \SUM[2]  = SUM[2];
  assign \SUM[1]  = SUM[1];
  assign \SUM[0]  = SUM[0];
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;

  HA1D2BWP16P90LVT U6 ( .A(\B[7] ), .B(n8), .CO(SUM[8]), .S(SUM[7]) );
  FA1D1BWP16P90LVT U7 ( .A(A[6]), .B(\B[6] ), .CI(n9), .CO(n8), .S(SUM[6]) );
  FA1D1BWP16P90LVT U8 ( .A(A[5]), .B(\B[5] ), .CI(n10), .CO(n9), .S(SUM[5]) );
  OAI21D1BWP16P90LVT U10 ( .A1(n11), .A2(n1), .B(n12), .ZN(n10) );
  ND2D1BWP16P90LVT U12 ( .A1(n24), .A2(n12), .ZN(n2) );
  ND2D1BWP16P90LVT U15 ( .A1(A[4]), .A2(\B[4] ), .ZN(n12) );
  FA1D1BWP16P90LVT U16 ( .A(\B[3] ), .B(A[3]), .CI(n66), .CO(n13), .S(SUM[3])
         );
  ND2D1BWP16P90LVT U22 ( .A1(n67), .A2(n18), .ZN(n3) );
  ND2D1BWP16P90LVT U25 ( .A1(A[2]), .A2(\B[2] ), .ZN(n18) );
  FA1D1BWP16P90LVT U26 ( .A(n20), .B(\B[1] ), .CI(A[1]), .CO(n19), .S(SUM[1])
         );
  ND2D1BWP16P90LVT U32 ( .A1(\B[0] ), .A2(A[0]), .ZN(n22) );
  CKND1BWP16P90LVT U37 ( .I(n4), .ZN(SUM[0]) );
  AO21D1BWP16P90LVT U38 ( .A1(n67), .A2(n19), .B(n16), .Z(n66) );
  CKND1BWP16P90LVT U39 ( .I(n18), .ZN(n16) );
  CKND1BWP16P90LVT U40 ( .I(n13), .ZN(n1) );
  OR2D1BWP16P90LVT U41 ( .A1(A[2]), .A2(\B[2] ), .Z(n67) );
  NR2D1BWP16P90LVT U42 ( .A1(A[4]), .A2(\B[4] ), .ZN(n11) );
  XNR2D1BWP16P90LVT U43 ( .A1(n2), .A2(n13), .ZN(SUM[4]) );
  CKND1BWP16P90LVT U44 ( .I(n11), .ZN(n24) );
  XNR2D1BWP16P90LVT U45 ( .A1(n3), .A2(n19), .ZN(SUM[2]) );
  IND2D1BWP16P90LVT U46 ( .A1(n21), .B1(n22), .ZN(n4) );
  NR2D1BWP16P90LVT U47 ( .A1(\B[0] ), .A2(A[0]), .ZN(n21) );
  CKND1BWP16P90LVT U48 ( .I(n22), .ZN(n20) );
endmodule


module Intensity ( R, G, B, Y );
  input [7:0] R;
  input [7:0] G;
  input [7:0] B;
  output [19:0] Y;
  wire   add_2_root_add_0_root_add_4_4_carry_6_,
         add_2_root_add_0_root_add_4_4_SUM_0_,
         add_2_root_add_0_root_add_4_4_SUM_1_,
         add_2_root_add_0_root_add_4_4_SUM_2_,
         add_2_root_add_0_root_add_4_4_SUM_3_,
         add_2_root_add_0_root_add_4_4_SUM_4_,
         add_2_root_add_0_root_add_4_4_SUM_5_,
         add_1_root_add_0_root_add_4_4_SUM_0_,
         add_1_root_add_0_root_add_4_4_SUM_1_,
         add_1_root_add_0_root_add_4_4_SUM_2_,
         add_1_root_add_0_root_add_4_4_SUM_3_,
         add_1_root_add_0_root_add_4_4_SUM_4_,
         add_1_root_add_0_root_add_4_4_SUM_5_,
         add_1_root_add_0_root_add_4_4_SUM_6_,
         add_1_root_add_0_root_add_4_4_SUM_7_, n1, n2, n3, \Y[9] , n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, SYNOPSYS_UNCONNECTED_1,
         SYNOPSYS_UNCONNECTED_2;
  assign Y[19] = \Y[9] ;
  assign Y[18] = \Y[9] ;
  assign Y[17] = \Y[9] ;
  assign Y[16] = \Y[9] ;
  assign Y[15] = \Y[9] ;
  assign Y[14] = \Y[9] ;
  assign Y[13] = \Y[9] ;
  assign Y[12] = \Y[9] ;
  assign Y[11] = \Y[9] ;
  assign Y[10] = \Y[9] ;
  assign Y[9] = \Y[9] ;

  Intensity_DW01_add_4 add_0_root_add_0_root_add_4_4 ( .\A[6] (
        add_2_root_add_0_root_add_4_4_carry_6_), .\A[5] (
        add_2_root_add_0_root_add_4_4_SUM_5_), .\A[4] (
        add_2_root_add_0_root_add_4_4_SUM_4_), .\A[3] (
        add_2_root_add_0_root_add_4_4_SUM_3_), .\A[2] (
        add_2_root_add_0_root_add_4_4_SUM_2_), .\A[1] (
        add_2_root_add_0_root_add_4_4_SUM_1_), .\A[0] (
        add_2_root_add_0_root_add_4_4_SUM_0_), .\B[7] (
        add_1_root_add_0_root_add_4_4_SUM_7_), .\B[6] (
        add_1_root_add_0_root_add_4_4_SUM_6_), .\B[5] (
        add_1_root_add_0_root_add_4_4_SUM_5_), .\B[4] (
        add_1_root_add_0_root_add_4_4_SUM_4_), .\B[3] (
        add_1_root_add_0_root_add_4_4_SUM_3_), .\B[2] (
        add_1_root_add_0_root_add_4_4_SUM_2_), .\B[1] (
        add_1_root_add_0_root_add_4_4_SUM_1_), .\B[0] (
        add_1_root_add_0_root_add_4_4_SUM_0_), .\SUM[8] (Y[8]), .\SUM[7] (Y[7]), .\SUM[6] (Y[6]), .\SUM[5] (Y[5]), .\SUM[4] (Y[4]), .\SUM[3] (Y[3]), 
        .\SUM[2] (Y[2]), .\SUM[1] (Y[1]), .\SUM[0] (Y[0]) );
  TIELBWP20P90LVT U1 ( .ZN(\Y[9] ) );
  CKND1BWP16P90LVT U2 ( .I(n43), .ZN(n67) );
  CKND1BWP16P90LVT U3 ( .I(n46), .ZN(n65) );
  CKND1BWP16P90LVT U4 ( .I(n37), .ZN(n36) );
  CKND1BWP16P90LVT U5 ( .I(n49), .ZN(n63) );
  CKND1BWP16P90LVT U6 ( .I(n34), .ZN(n33) );
  CKND1BWP16P90LVT U7 ( .I(n58), .ZN(n31) );
  CKND1BWP16P90LVT U8 ( .I(n40), .ZN(n39) );
  CKND1BWP16P90LVT U9 ( .I(n11), .ZN(n28) );
  CKND1BWP16P90LVT U10 ( .I(n29), .ZN(n8) );
  CKND1BWP16P90LVT U11 ( .I(n61), .ZN(n62) );
  CKND1BWP16P90LVT U12 ( .I(n24), .ZN(n25) );
  CKND1BWP16P90LVT U13 ( .I(n14), .ZN(n26) );
  CKND1BWP16P90LVT U14 ( .I(n55), .ZN(n56) );
  XOR2D1BWP16P90LVT U15 ( .A1(G[7]), .A2(n56), .Z(
        add_1_root_add_0_root_add_4_4_SUM_6_) );
  XOR2D1BWP16P90LVT U16 ( .A1(n57), .A2(G[6]), .Z(
        add_1_root_add_0_root_add_4_4_SUM_5_) );
  XOR2D1BWP16P90LVT U17 ( .A1(n20), .A2(R[7]), .Z(
        add_2_root_add_0_root_add_4_4_SUM_5_) );
  XNR3D2BWP16P90LVT U18 ( .A1(G[5]), .A2(R[6]), .A3(n29), .ZN(n1) );
  XNR3D2BWP16P90LVT U19 ( .A1(G[3]), .A2(n65), .A3(n64), .ZN(
        add_1_root_add_0_root_add_4_4_SUM_2_) );
  CKND1BWP16P90LVT U20 ( .I(n66), .ZN(n42) );
  XNR2D1BWP16P90LVT U21 ( .A1(n16), .A2(G[4]), .ZN(n2) );
  AN2D1BWP16P90LVT U22 ( .A1(R[2]), .A2(n2), .Z(n3) );
  XNR3D2BWP16P90LVT U23 ( .A1(R[6]), .A2(n21), .A3(n23), .ZN(
        add_2_root_add_0_root_add_4_4_SUM_4_) );
  XOR2D1BWP16P90LVT U24 ( .A1(n22), .A2(G[7]), .Z(n14) );
  XOR2D1BWP16P90LVT U25 ( .A1(R[2]), .A2(n2), .Z(
        add_2_root_add_0_root_add_4_4_SUM_0_) );
  XOR2D1BWP16P90LVT U26 ( .A1(n68), .A2(G[1]), .Z(
        add_1_root_add_0_root_add_4_4_SUM_0_) );
  XNR3D2BWP16P90LVT U27 ( .A1(G[5]), .A2(n59), .A3(n60), .ZN(
        add_1_root_add_0_root_add_4_4_SUM_4_) );
  ND2D1BWP16P90LVT U28 ( .A1(R[5]), .A2(G[4]), .ZN(n29) );
  MAOI222D1BWP16P90LVT U29 ( .A(G[5]), .B(R[6]), .C(n8), .ZN(n5) );
  INVD1BWP16P90LVT U30 ( .I(n5), .ZN(n7) );
  MAOI222D1BWP16P90LVT U31 ( .A(G[6]), .B(R[7]), .C(n7), .ZN(n6) );
  INVD1BWP16P90LVT U32 ( .I(G[7]), .ZN(n54) );
  NR2D1BWP16P90LVT U33 ( .A1(n6), .A2(n54), .ZN(n17) );
  INVD1BWP16P90LVT U34 ( .I(n6), .ZN(n22) );
  INVD1BWP16P90LVT U35 ( .I(R[5]), .ZN(n16) );
  XOR3D1BWP16P90LVT U36 ( .A1(G[6]), .A2(R[7]), .A3(n7), .Z(n11) );
  INVD1BWP16P90LVT U37 ( .I(R[4]), .ZN(n13) );
  XOR3D1BWP16P90LVT U38 ( .A1(G[5]), .A2(R[6]), .A3(n8), .Z(n9) );
  MAOI222D1BWP16P90LVT U39 ( .A(n9), .B(R[3]), .C(n3), .ZN(n27) );
  INVD1BWP16P90LVT U40 ( .I(n27), .ZN(n10) );
  OAI21D1BWP16P90LVT U41 ( .A1(R[4]), .A2(n11), .B(n10), .ZN(n12) );
  OAI21D1BWP16P90LVT U42 ( .A1(n28), .A2(n13), .B(n12), .ZN(n24) );
  OAI21D1BWP16P90LVT U43 ( .A1(R[5]), .A2(n14), .B(n24), .ZN(n15) );
  OAI21D1BWP16P90LVT U44 ( .A1(n26), .A2(n16), .B(n15), .ZN(n21) );
  MAOI222D1BWP16P90LVT U45 ( .A(R[6]), .B(n17), .C(n21), .ZN(n19) );
  INVD1BWP16P90LVT U46 ( .I(R[7]), .ZN(n18) );
  NR2D1BWP16P90LVT U47 ( .A1(n19), .A2(n18), .ZN(
        add_2_root_add_0_root_add_4_4_carry_6_) );
  INVD1BWP16P90LVT U48 ( .I(n19), .ZN(n20) );
  ND2D1BWP16P90LVT U49 ( .A1(G[7]), .A2(n22), .ZN(n23) );
  XOR3D1BWP16P90LVT U50 ( .A1(R[5]), .A2(n26), .A3(n25), .Z(
        add_2_root_add_0_root_add_4_4_SUM_3_) );
  XOR3D1BWP16P90LVT U51 ( .A1(R[4]), .A2(n28), .A3(n27), .Z(
        add_2_root_add_0_root_add_4_4_SUM_2_) );
  XOR3D1BWP16P90LVT U52 ( .A1(R[3]), .A2(n1), .A3(n3), .Z(
        add_2_root_add_0_root_add_4_4_SUM_1_) );
  INVD1BWP16P90LVT U53 ( .I(B[3]), .ZN(n41) );
  ND2D1BWP16P90LVT U54 ( .A1(B[7]), .A2(n41), .ZN(n40) );
  INVD1BWP16P90LVT U55 ( .I(B[4]), .ZN(n38) );
  ND2D1BWP16P90LVT U56 ( .A1(n39), .A2(n38), .ZN(n37) );
  INVD1BWP16P90LVT U57 ( .I(B[5]), .ZN(n35) );
  ND2D1BWP16P90LVT U58 ( .A1(n36), .A2(n35), .ZN(n34) );
  INVD1BWP16P90LVT U59 ( .I(B[6]), .ZN(n32) );
  ND2D1BWP16P90LVT U60 ( .A1(n33), .A2(n32), .ZN(n58) );
  INVD1BWP16P90LVT U61 ( .I(B[7]), .ZN(n30) );
  NR2D1BWP16P90LVT U62 ( .A1(n31), .A2(n30), .ZN(n52) );
  OAI21D1BWP16P90LVT U63 ( .A1(n33), .A2(n32), .B(n58), .ZN(n49) );
  INVD1BWP16P90LVT U64 ( .I(G[4]), .ZN(n51) );
  OAI21D1BWP16P90LVT U65 ( .A1(n36), .A2(n35), .B(n34), .ZN(n46) );
  INVD1BWP16P90LVT U66 ( .I(G[3]), .ZN(n48) );
  OAI21D1BWP16P90LVT U67 ( .A1(n39), .A2(n38), .B(n37), .ZN(n43) );
  INVD1BWP16P90LVT U68 ( .I(G[2]), .ZN(n45) );
  OAI21D1BWP16P90LVT U69 ( .A1(B[7]), .A2(n41), .B(n40), .ZN(n68) );
  ND2D1BWP16P90LVT U70 ( .A1(G[1]), .A2(n68), .ZN(n66) );
  OAI21D1BWP16P90LVT U71 ( .A1(G[2]), .A2(n43), .B(n42), .ZN(n44) );
  OAI21D1BWP16P90LVT U72 ( .A1(n67), .A2(n45), .B(n44), .ZN(n64) );
  OAI21D1BWP16P90LVT U73 ( .A1(G[3]), .A2(n46), .B(n64), .ZN(n47) );
  OAI21D1BWP16P90LVT U74 ( .A1(n65), .A2(n48), .B(n47), .ZN(n61) );
  OAI21D1BWP16P90LVT U75 ( .A1(G[4]), .A2(n49), .B(n61), .ZN(n50) );
  OAI21D1BWP16P90LVT U76 ( .A1(n63), .A2(n51), .B(n50), .ZN(n60) );
  MAOI222D1BWP16P90LVT U77 ( .A(n52), .B(G[5]), .C(n60), .ZN(n53) );
  INVD1BWP16P90LVT U78 ( .I(n53), .ZN(n57) );
  ND2D1BWP16P90LVT U79 ( .A1(G[6]), .A2(n57), .ZN(n55) );
  NR2D1BWP16P90LVT U80 ( .A1(n55), .A2(n54), .ZN(
        add_1_root_add_0_root_add_4_4_SUM_7_) );
  ND2D1BWP16P90LVT U81 ( .A1(B[7]), .A2(n58), .ZN(n59) );
  XOR3D1BWP16P90LVT U82 ( .A1(G[4]), .A2(n63), .A3(n62), .Z(
        add_1_root_add_0_root_add_4_4_SUM_3_) );
  XOR3D1BWP16P90LVT U83 ( .A1(G[2]), .A2(n67), .A3(n66), .Z(
        add_1_root_add_0_root_add_4_4_SUM_1_) );
endmodule

