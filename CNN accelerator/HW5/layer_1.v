`timescale 1ns / 1ns
`define buffer_size 226*2+3
`define a 225
`define b 224
`define c 225
`define weight_1_input_size     9*3 
`define weight_2_input_size     9*4

module layer_1 (input clk, rst, sel, sel2, output en, input signed [8:0] pixel_1, pixel_2, pixel_3, pixel_4,
                input signed [9*4*16-1:0] input_weight_1, input_weight_2, input_weight_3, input_weight_4,  
                input signed [15:0] input_bias_1, input_bias_2, input_bias_3, input_bias_4,
                output [7:0] out_1, out_2, out_3, out_4);

    reg signed [8:0]    buffer  [0:3] [0:`buffer_size-1];
    reg signed [15:0]   weight  [0:3] [0:`weight_2_input_size-1];
    reg signed [15:0]   bias    [0:3];
    reg signed [35:0]   tmp     [0:3][0:3];
    reg signed [35:0]   sum     [0:3];
    reg signed [35:0]   tmp_sum;
    reg signed [7:0]    out     [0:3];
    integer     i, j, k;
    reg [19:0]  check, valid;
    wire        c, v;

    // line buffer
    always @(posedge clk) begin
        if (rst) begin
            check <= 0; valid <= 0;
            for(i = 0; i < `buffer_size; i = i+1) begin
                buffer[0][i] <= 0; buffer[1][i] <= 0; buffer[2][i] <= 0; buffer[3][i] <= 0;
            end
            for (i = 0; i < 4; i = i+1) begin
                tmp[0][i] <= 0; tmp[1][i] <= 0; tmp[2][i] <= 0; tmp[3][i] <= 0;sum[i] <= 0;
                bias[i] <= 0;
            end
            for (i = 0; i < `weight_2_input_size; i = i+1) begin
                weight[0][i] <= 0; weight[1][i] <= 0; weight[2][i] <= 0; weight[3][i] <= 0;
            end
        end else begin
            // line buffer
            if (check < `buffer_size) begin
                buffer[0][i] <= pixel_1;
                buffer[1][i] <= pixel_3;
                buffer[2][i] <= pixel_2;
                buffer[3][i] <= pixel_4;
            end 
            else begin
                for (i = 0; i < `buffer_size-1; i = i+1) begin
                    buffer[0][i] <= buffer[0][i+1];
                    buffer[1][i] <= buffer[1][i+1];
                    buffer[2][i] <= buffer[2][i+1];
                    buffer[3][i] <= buffer[3][i+1];
                end
                buffer[0][i] <= pixel_1;
                buffer[1][i] <= pixel_3;
                buffer[2][i] <= pixel_2;
                buffer[3][i] <= pixel_4;
            end
            // weight
            for (i = 0; i < `weight_2_input_size; i = i+1) begin // 1d to 2d
                weight[0][i] <= input_weight_1[i*16 +: 16]; 
                weight[1][i] <= input_weight_2[i*16 +: 16]; 
                weight[2][i] <= input_weight_3[i*16 +: 16]; 
                weight[3][i] <= input_weight_4[i*16 +: 16];
            end
            // bias
            bias[0] <= input_bias_1;
            bias[1] <= input_bias_2;
            bias[2] <= input_bias_3;
            bias[3] <= input_bias_4;
            // count
            check <= check + 1;
            if (valid < `a) valid <= valid + 1;
            else valid <= 0;
        end 
    end
    assign c = (check < `buffer_size) ? 0 : 1;
    assign v = (valid == `b || valid == `c) ? 0 : 1;
    assign en = c & v;

    always @(*) begin
        // PE GROUP*4
        for (k = 0; k < 4; k = k+1) begin
            // Channel 1
            tmp[0][k] = buffer[0][0]*weight[k][0] + buffer[0][1]*weight[k][1] + buffer[0][2]*weight[k][2] +
                    buffer[0][224]*weight[k][3] + buffer[0][225]*weight[k][4] + buffer[0][226]*weight[k][5] +
                    buffer[0][448]*weight[k][6] + buffer[0][449]*weight[k][7] + buffer[0][450]*weight[k][8];
            // Channel 2
            tmp[1][k] = buffer[1][0]*weight[k][9] + buffer[1][1]*weight[k][10] + buffer[1][2]*weight[k][11] +
                    buffer[1][224]*weight[k][12] + buffer[1][225]*weight[k][13] + buffer[1][226]*weight[k][14] +
                    buffer[1][448]*weight[k][15] + buffer[1][449]*weight[k][16] + buffer[1][450]*weight[k][17];
            // Channel 3
            tmp[2][k] = buffer[2][0]*weight[k][18] + buffer[2][1]*weight[k][19] + buffer[2][2]*weight[k][20] +
                    buffer[2][224]*weight[k][21] + buffer[2][225]*weight[k][22] + buffer[2][226]*weight[k][23] +
                    buffer[2][448]*weight[k][24] + buffer[2][449]*weight[k][25] + buffer[2][450]*weight[k][26];
            // Channel 4
            if(sel) begin
                 tmp[3][k] = buffer[3][0]*weight[k][27] + buffer[3][1]*weight[k][28] + buffer[3][2]*weight[k][29] +
                    buffer[3][224]*weight[k][30] + buffer[3][225]*weight[k][31] + buffer[3][226]*weight[k][32] +
                    buffer[3][448]*weight[k][33] + buffer[3][449]*weight[k][34] + buffer[3][450]*weight[k][35];
            end
        end      

        // Bias
        for (k = 0; k < 4; k = k+1) begin
            tmp_sum = sum[k];
            if(sel & sel2) sum[k] = tmp_sum + tmp[0][k] + tmp[1][k] + tmp[2][k] + tmp[3][k] + bias[k]; // layer 2 last
            else if(sel) sum[k] = tmp_sum + tmp[0][k] + tmp[1][k] + tmp[2][k] + tmp[3][k]; // layer 2 
            else sum[k] = tmp[0][k] + tmp[1][k] + tmp[2][k] + bias[k]; // layer 1
        end 

        // ReLU
        if(~sel) begin  // layer 1
            for (k = 0; k < 4; k = k+1) begin
                if (sum[k] < 0) out[k] = 8'd0; 
                else out[k] = sum[k][11:4];
            end 
        end else begin  // layer 2
            for (k = 0; k < 4; k = k+1) begin
                if (sum[k] < 0) out[k] = 8'd0; 
                else out[k] = sum[k][14:7];
            end 
        end
    end
    assign out_1 = out[0];
    assign out_2 = out[1];
    assign out_3 = out[2];
    assign out_4 = out[3];
endmodule
