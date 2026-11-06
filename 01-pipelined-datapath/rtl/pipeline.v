module d_ff(Q, D, clk, rst);
    parameter width = 8;
    output reg [2*width-1:0] Q;
    input [2*width-1:0] D;
    input clk, rst;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= 0;
        end else begin
            Q <= D;
        end
    end
endmodule

module stage1_pipe(sum, a, b, s);
    parameter width = 8;
    output [2*width-1:0] sum;
    input [width-1:0] a, b;
    input s;

    assign sum = (s) ? (a + b) : (a - b);
endmodule

module stage2_pipe(r, sum, c);
    parameter width = 8;
    output [2*width-1:0] r;
    input [2*width-1:0] sum, c;

    assign r = sum * c;
endmodule

module hw2_pipe(d, a, b, c, s, rst, clk);
    parameter width = 8;
    output reg [2*width-1:0] d;
    input      [width-1:0]   a, b, c;
	input                    s;
	input                    rst, clk;

    wire [2*width-1:0] sum, c0, c1, sum_o;
    wire [2*width-1:0] product;
    
    stage1_pipe uut1(.sum(sum), .a(a), .b(b), .s(s));
    d_ff stage1_reg1(.Q(sum_o), .D(sum), .clk(clk), .rst(rst));
    d_ff stage1_reg2(.Q(c1), .D({8'b0, c}), .clk(clk), .rst(rst));
    stage2_pipe uut2(.r(product), .sum(sum_o), .c(c1));

	always @(posedge clk or posedge rst) begin
        if (rst) begin
            d <= 0;
        end else begin
            d <= product;
        end
    end
endmodule
