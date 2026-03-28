module hw2_nonpipe(a, b, c, s, d);
    parameter width = 8;
    input      [width-1:0]   a, b, c;
	input                    s;
	output wire [2*width-1:0] d;
	
	assign d = s ? (a+b)*c : (a-b)*c;
endmodule
