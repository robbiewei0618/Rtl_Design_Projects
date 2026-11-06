module clock_gate1(Q, D, en, rst, clk);
    input en;
	input rst, clk;
	input D;
	output reg Q;

	always @ (posedge en or posedge rst) begin
		if (rst) Q <= 0;
		else     Q <= D;
	end
endmodule

module clock_gate16(Q, D, en, rst, clk);
    input en;
	input rst, clk;
	input [15:0] D;
	output reg [15:0] Q;
	
	always @ (posedge en or posedge rst) begin
		if (rst) Q <= 0;
		else     Q <= D;
	end
endmodule

module stage1_cg(sum, a, b, s);
    parameter width = 8;
    output     [2*width-1:0] sum;
    input      [width-1:0] a, b;
    input      s;
    assign sum = (s) ? (a + b) : (a - b);
endmodule

module stage2_cg(d, sum, c);
    parameter width = 8;
    output  [2*width-1:0] d;
    input   [2*width-1:0] sum, c;
    assign d = sum * c;
endmodule

module hw2_cg(d, a, b, c, s, rst, clk);
    parameter width = 8;
	output reg [2*width-1:0] d;
    input      [width-1:0]   a, b, c;
	input                    s;
	input                    rst, clk;
	
    wire [2*width-1:0] sum, sumo, c0, c1, product;

    wire gclk = clk && c;
	
	clock_gate16 cg2(.Q(c0), .D({8'b0, c}), .en(clk), .rst(rst), .clk(clk));
    stage1_cg uut1(.sum(sum), .a(a), .b(b), .s(s));
	clock_gate16 cg0(.Q(sumo), .D(sum), .en(gclk), .rst(rst), .clk(clk));
	clock_gate16 cg1(.Q(c1), .D({8'b0, c}), .en(gclk), .rst(rst), .clk(clk));
    stage2_cg uut2(.d(product), .sum(sumo), .c(c1));
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            d <= 0;
        end else begin
            d <= c0 ? product : 0;
        end
    end
endmodule
