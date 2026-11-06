module Edge_Detection(clk, rst, threshold, R, G, B, out_x, out_y, en);
    input clk, rst;
    input signed [19:0] threshold;
    input [7:0] R, G, B;
    output [7:0] out_x, out_y;
    output en;

    wire signed [19:0] Y;
    wire signed [19:0] R0, R1, R2, R3, R4, R5, R6, R7, R8;

    Intensity step0(.R(R), .G(G), .B(B), .Y(Y));
    LineBuffer step1(.clk(clk), .rst(rst), .Y(Y), .en(en), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .R8(R8));
    Conv step2(.threshold(threshold), .R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .R8(R8), .x(out_x), .y(out_y));
endmodule