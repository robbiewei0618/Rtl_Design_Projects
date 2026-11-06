`timescale 1ns / 1ps

module testbench;
    parameter width = 8;
    // Reset & Clock
    reg rst, clk;
    // Inputs
    reg [width-1:0]   a_reg, b_reg, c_reg;
    reg s_reg;
    wire [2*width-1:0] d_nonpipe, d_pipe, d_cg;
    
    reg [2*width-1:0] real_arr[0:1][0:99];
    reg [2*width-1:0] nonpipe_arr [0:1][0:99];
    reg [2*width-1:0] pipe_arr [0:1][0:102];
    reg [2*width-1:0] cg_arr [0:1][0:102];

    reg [width-1:0] a[0:1][0:99], b[0:1][0:99], c[0:1][0:99];
	reg s[0:1][0:99];
    integer i;

    hw2_nonpipe nonpipe_uut (
        .a(a_reg), .b(b_reg), .c(c_reg), .s(s_reg), .d(d_nonpipe)
    );
	
	hw2_pipe pipe_uut (
		.a(a_reg), .b(b_reg), .c(c_reg), .s(s_reg), .rst(rst), .clk(clk), .d(d_pipe)
	);

	hw2_cg cg_uut (
		.a(a_reg), .b(b_reg), .c(c_reg), .s(s_reg), .rst(rst), .clk(clk), .d(d_cg)
	);

    // Test
    initial begin
        clk = 0;
		rst = 1;
        a_reg = 0;
        b_reg = 0;
		c_reg = 0;
        s_reg = 1;
		#1
		rst = 0;

        for (i=0; i < 100; i=i+1) begin
            a[0][i] = {$random}; b[0][i] = {$random}; c[0][i] = {$random}; s[0][i] = {$random} % 2;
            a[1][i] = {$random}; b[1][i] = {$random}; c[1][i] = 0; s[1][i] = {$random} % 2;
        end

        for (i=0; i < 100; i=i+1) begin
            #10 a_reg = a[0][i]; b_reg = b[0][i]; c_reg = c[0][i]; s_reg = s[0][i];
            #1 clk=~clk; // posedge clk
            #1 clk=~clk; // negedge clk
            real_arr[0][i] = 16'b0+(a_reg+b_reg)*c_reg;
            nonpipe_arr[0][i] = d_nonpipe;
            pipe_arr[0][i] = d_pipe;
            cg_arr[0][i] = d_cg;
        end
        for (i=100; i < 103; i=i+1) begin
            #1 clk=~clk; // posedge clk
            #1 clk=~clk; // negedge clk
            pipe_arr[0][i] = d_pipe;
            cg_arr[0][i] = d_cg;
        end
        
        for (i=0; i < 100; i=i+1) begin
            if (s[0][i]) begin
                //$display("nonpipe:      (%d + %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], nonpipe_arr[0][i]);
                //$display("pipe:         (%d + %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], pipe_arr[0][i+2]);
                $display("clock gating: (%d + %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], cg_arr[0][i+3]);
                //$display("Expected:     (%d + %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], 16'b0+(a[0][i]+b[0][i])*c[0][i]);
            end else begin
                //$display("nonpipe:      (%d - %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], nonpipe_arr[0][i]);
                //$display("pipe:         (%d - %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], pipe_arr[0][i+2]);
                $display("clock gating: (%d - %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], cg_arr[0][i+3]);
                //$display("Expected:     (%d - %d) * %d = %d\n", a[0][i], b[0][i], c[0][i], 16'b0+(a[0][i]-b[0][i])*c[0][i]);
            end
        end

        for (i=0; i < 100; i=i+1) begin
            #10 a_reg = a[1][i]; b_reg = b[1][i]; c_reg = c[1][i]; s_reg = s[1][i];
            #1 clk=~clk; // posedge clk
            #1 clk=~clk; // negedge clk
            real_arr[1][i] = 16'b0+(a_reg+b_reg)*c_reg;
            nonpipe_arr[1][i] = d_nonpipe;
            pipe_arr[1][i] = d_pipe;
            cg_arr[1][i] = d_cg;
        end
        for (i=100; i < 102; i=i+1) begin
            #1 clk=~clk; // posedge clk
            #1 clk=~clk; // negedge clk
            pipe_arr[1][i] = d_pipe;
            cg_arr[1][i] = d_cg;
        end
        
        /*
        for (i=0; i < 100; i=i+1) begin
            if (s[0][i]) begin
                $display("nonpipe:      (%d + %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], nonpipe_arr[1][i]);
                $display("pipe:         (%d + %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], pipe_arr[1][i+2]);
                $display("clock gating: (%d + %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], cg_arr[1][i+2]);
                $display("Expected:     (%d + %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], 16'b0+(a[1][i]+b[1][i])*c[1][i]);
            end else begin
                $display("nonpipe:      (%d - %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], nonpipe_arr[1][i]);
                $display("pipe:         (%d - %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], pipe_arr[1][i+2]);
                $display("clock gating: (%d - %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], cg_arr[1][i+2]);
                $display("Expected:     (%d - %d) * %d = %d\n", a[1][i], b[1][i], c[1][i], 16'b0+(a[1][i]-b[1][i])*c[1][i]);
            end
        end
        */

        #10 $finish;
    end

endmodule
