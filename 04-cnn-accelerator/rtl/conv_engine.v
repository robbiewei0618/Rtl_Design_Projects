// =============================================================================
// conv_engine.v - streaming 3x3 convolution engine for the first two VGG-16
//                 layers (conv1_1: 3 -> 64 channels, conv1_2: 64 -> 64)
//
// One pass streams a zero-padded W_PAD x W_PAD feature map of up to four input
// channels, one pixel per clock (pixel 0 at the first rising edge after reset),
// and produces four output channels in parallel (4 PE groups x 4 channels x 9
// taps = 144 multipliers).
//
//   layer   = 0 : conv1_1 pass  (3 input channels, pixel_4 ignored)
//                 y = ReLU(sum + bias) >> 4, saturated to 8 bits
//   layer   = 1 : conv1_2 pass  (4 of the 64 input channels per pass)
//                 psum_out = psum_in + sum                 (last = 0)
//                 y = ReLU(psum_in + sum + bias) >> 7, sat (last = 1)
//
// Partial sums of conv1_2 live outside the engine (in a real accelerator: an
// SRAM; here: the testbench). psum_in must hold the partial sum of the output
// pixel whose window is on the outputs in the same cycle; psum_out is
// combinational from it.
//
// en = 1 exactly when the outputs belong to a real output pixel: the 3x3
// window ends at column >= 2 and row >= 2 of the padded map, i.e. it neither
// wraps around a row end nor reaches into the rows before the map.
//
// This replaces rtl/archive/layer_1.v; see BUGS.md for what changed and why.
// =============================================================================
`timescale 1ns / 1ns

module conv_engine #(
    parameter W_PAD = 226                       // padded width (= height)
) (
    input                        clk,
    input                        rst,           // synchronous, active high
    input                        layer,         // 0: conv1_1, 1: conv1_2
    input                        last,          // conv1_2: last input-channel pass
    output reg                   en,
    input  signed [8:0]          pixel_1, pixel_2, pixel_3, pixel_4,
    input  signed [9*4*16-1:0]   input_weight_1, input_weight_2, input_weight_3, input_weight_4,
    input  signed [15:0]         input_bias_1, input_bias_2, input_bias_3, input_bias_4,
    input  signed [4*36-1:0]     psum_in,       // {ch4, ch3, ch2, ch1}
    output signed [4*36-1:0]     psum_out,
    output [7:0]                 out_1, out_2, out_3, out_4
);
    localparam BUF = 2 * W_PAD + 3;             // two rows + three pixels

    // ------------------------------------------------------------ line buffer
    // buffer[c][BUF-1] is the newest pixel; the window taps are the oldest
    // three pixels of each of the three rows: [0..2], [W_PAD..W_PAD+2],
    // [2*W_PAD..2*W_PAD+2]
    reg signed [8:0] buffer [0:3][0:BUF-1];
    reg [8:0]        col, row;                  // position of buffer[*][BUF-1]
    reg              have_pixel;
    integer i, c;

    always @(posedge clk) begin
        if (rst) begin
            for (c = 0; c < 4; c = c + 1)
                for (i = 0; i < BUF; i = i + 1)
                    buffer[c][i] <= 9'sd0;
            col <= 9'd0; row <= 9'd0; have_pixel <= 1'b0; en <= 1'b0;
        end else begin
            for (c = 0; c < 4; c = c + 1)
                for (i = 0; i < BUF - 1; i = i + 1)
                    buffer[c][i] <= buffer[c][i + 1];
            buffer[0][BUF - 1] <= pixel_1;      // input channels in order
            buffer[1][BUF - 1] <= pixel_2;
            buffer[2][BUF - 1] <= pixel_3;
            buffer[3][BUF - 1] <= layer ? pixel_4 : 9'sd0;

            // the window ending at the pixel captured now is valid iff that
            // pixel sits at column >= 2 and row >= 2
            have_pixel <= 1'b1;
            if (!have_pixel) begin
                col <= 9'd0; row <= 9'd0;
                en  <= 1'b0;
            end else if (col == W_PAD - 1) begin
                col <= 9'd0; row <= row + 9'd1;
                en  <= 1'b0;                    // new pixel is at column 0
            end else begin
                col <= col + 9'd1;
                en  <= (col + 9'd1 >= 9'd2) && (row >= 9'd2);
            end
        end
    end

    // ------------------------------------------------------------ weights
    wire signed [9*4*16-1:0] wbus [0:3];
    assign wbus[0] = input_weight_1;
    assign wbus[1] = input_weight_2;
    assign wbus[2] = input_weight_3;
    assign wbus[3] = input_weight_4;
    wire signed [15:0] bias [0:3];
    assign bias[0] = input_bias_1;
    assign bias[1] = input_bias_2;
    assign bias[2] = input_bias_3;
    assign bias[3] = input_bias_4;

    // ------------------------------------------------------------ 4 PE groups
    genvar k;
    generate
        for (k = 0; k < 4; k = k + 1) begin : pe
            // weight index: channel*9 + tap, tap = row*3 + column.
            // (an always block, not a function in a continuous assignment:
            // such an assignment is only re-evaluated when its arguments
            // change, so a function reading buffer[] would never update)
            reg signed [35:0] s0, s1, s2, s3;
            reg signed [35:0] part;
            integer ch, t;
            always @(*) begin
                for (ch = 0; ch < 4; ch = ch + 1) begin
                    part = 36'sd0;
                    for (t = 0; t < 9; t = t + 1)
                        part = part + buffer[ch][(t / 3) * W_PAD + (t % 3)]
                                    * $signed(wbus[k][(ch * 9 + t) * 16 +: 16]);
                    case (ch)
                        0: s0 = part;
                        1: s1 = part;
                        2: s2 = part;
                        default: s3 = layer ? part : 36'sd0;
                    endcase
                end
            end

            wire signed [35:0] sum = s0 + s1 + s2 + s3;
            wire signed [35:0] pin = psum_in[k * 36 +: 36];

            // conv1_1: sum + bias; conv1_2: running partial sum (+ bias on the last pass)
            wire signed [35:0] acc = layer ? (pin + sum) : sum;
            wire signed [35:0] pre = acc + ((!layer || last) ? {{20{bias[k][15]}}, bias[k]} : 36'sd0);
            assign psum_out[k * 36 +: 36] = acc;

            // ReLU, scale, saturate to 8 bits
            wire signed [35:0] scaled = layer ? (pre >>> 7) : (pre >>> 4);
            wire [7:0] y = pre[35]            ? 8'd0   :
                           (scaled > 36'sd255) ? 8'd255 : scaled[7:0];
        end
    endgenerate

    assign out_1 = pe[0].y;
    assign out_2 = pe[1].y;
    assign out_3 = pe[2].y;
    assign out_4 = pe[3].y;
endmodule
