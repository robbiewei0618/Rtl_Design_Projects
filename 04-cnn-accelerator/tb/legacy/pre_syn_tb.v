// =============================================================================
// pre_syn_tb.v - VGG-16 conv1_1 + conv1_2 on cat224.bmp with conv_engine
//
// Course-style image testbench (plain Verilog, runs on Icarus): streams the
// zero-padded image through the engine 16 times for conv1_1 (4 of 64 output
// channels per pass) and 16 x 16 times for conv1_2 (4 output x 4 input
// channels per pass, partial sums kept in psum[] between passes), and writes
// every feature map as a PGM image to out_layer1/ and out_layer2/.
//   -DS_IMG=<S>  run on the top-left S x S crop (default 224: about 14 M
//                clock cycles, hours in Icarus; `make legacy` uses 24)
// The original course testbench for the first engine is archive_pre_syn_tb.v.
// =============================================================================
`timescale 1ns / 1ns
`define period 10
`ifndef S_IMG
  `define S_IMG 224
`endif
`define S   `S_IMG
`define WP  (`S_IMG + 2)
`define NP  ((`S_IMG + 2) * (`S_IMG + 2))

module pre_syn_tb;
    reg         clk, rst, layer, last;
    wire        en;
    reg  [7:0]  bmp [0:224*224*3+54-1];
    reg  signed [15:0] w1 [0:64*3*9-1], b1 [0:63], w2 [0:64*64*9-1], b2 [0:63];
    reg  [7:0]  in0 [0:3*`NP-1];        // padded RGB (channel-major)
    reg  [7:0]  l1  [0:64*`NP-1];       // padded conv1_1 maps
    reg  [7:0]  l2  [0:64*`S*`S-1];     // conv1_2 maps
    reg  signed [35:0] psum [0:4*`S*`S-1];
    reg  signed [8:0]  pixel_1, pixel_2, pixel_3, pixel_4;
    reg  signed [9*4*16-1:0] wt1, wt2, wt3, wt4;
    reg  signed [15:0] bs1, bs2, bs3, bs4;
    reg  signed [4*36-1:0] psum_in;
    wire signed [4*36-1:0] psum_out;
    wire [7:0]  out_1, out_2, out_3, out_4;
    integer off, og, ig, k, j, idx, n, fd, ch;
    reg [8*64-1:0] fname;

    conv_engine #(.W_PAD(`WP)) engine (
        .clk(clk), .rst(rst), .layer(layer), .last(last), .en(en),
        .pixel_1(pixel_1), .pixel_2(pixel_2), .pixel_3(pixel_3), .pixel_4(pixel_4),
        .input_weight_1(wt1), .input_weight_2(wt2), .input_weight_3(wt3), .input_weight_4(wt4),
        .input_bias_1(bs1), .input_bias_2(bs2), .input_bias_3(bs3), .input_bias_4(bs4),
        .psum_in(psum_in), .psum_out(psum_out),
        .out_1(out_1), .out_2(out_2), .out_3(out_3), .out_4(out_4));

    initial clk = 1'b0;
    always #(`period / 2) clk = ~clk;

    // pixel idx of input group g of the current layer
    function [8:0] in_px;
        input integer g, c, i;
        begin
            if (!layer) in_px = (c < 3) ? {1'b0, in0[c * `NP + i]} : 9'd0;
            else        in_px = {1'b0, l1[(g * 4 + c) * `NP + i]};
        end
    endfunction

    task run_pass;   // uses layer, last, og, ig
        begin
            rst = 1'b1; pixel_1 = 0; pixel_2 = 0; pixel_3 = 0; pixel_4 = 0; psum_in = 0;
            #(`period * 2);
            rst = 1'b0;                              // pixel 0 meets the first rising edge
            n = 0;
            for (idx = 0; idx <= `NP; idx = idx + 1) begin
                if (idx < `NP) begin
                    pixel_1 = in_px(ig, 0, idx); pixel_2 = in_px(ig, 1, idx);
                    pixel_3 = in_px(ig, 2, idx); pixel_4 = in_px(ig, 3, idx);
                end else begin
                    pixel_1 = 0; pixel_2 = 0; pixel_3 = 0; pixel_4 = 0;
                end
                // the rising edge is at +period/2; give the engine the stored
                // partial sums of the window it now shows, read it at +period
                #(`period - 1);
                for (k = 0; k < 4; k = k + 1)
                    psum_in[k * 36 +: 36] = (layer && ig > 0 && en) ? psum[k * `S * `S + n] : 36'sd0;
                #1;
                if (en) begin                            // output pixel n of this pass
                    for (k = 0; k < 4; k = k + 1) psum[k * `S * `S + n] = psum_out[k * 36 +: 36];
                    if (!layer) begin
                        j = (n / `S + 1) * `WP + (n % `S + 1);
                        l1[(og * 4 + 0) * `NP + j] = out_1; l1[(og * 4 + 1) * `NP + j] = out_2;
                        l1[(og * 4 + 2) * `NP + j] = out_3; l1[(og * 4 + 3) * `NP + j] = out_4;
                    end else if (last) begin
                        l2[(og * 4 + 0) * `S * `S + n] = out_1; l2[(og * 4 + 1) * `S * `S + n] = out_2;
                        l2[(og * 4 + 2) * `S * `S + n] = out_3; l2[(og * 4 + 3) * `S * `S + n] = out_4;
                    end
                    n = n + 1;
                end
            end
            if (n != `S * `S) $display("ERROR: pass %0d/%0d produced %0d outputs, expected %0d", og, ig, n, `S * `S);
        end
    endtask

    task load_weights;   // 4 output channels og*4.. ; conv1_2: input group ig
        integer oc;
        begin
            for (k = 0; k < 4; k = k + 1) begin
                oc = og * 4 + k;
                for (j = 0; j < 36; j = j + 1) begin
                    if (!layer) ch = (j < 27) ? w1[oc * 27 + j] : 16'sd0;
                    else        ch = w2[(oc * 64 + ig * 4) * 9 + j];
                    case (k)
                        0: wt1[j * 16 +: 16] = ch;  1: wt2[j * 16 +: 16] = ch;
                        2: wt3[j * 16 +: 16] = ch;  default: wt4[j * 16 +: 16] = ch;
                    endcase
                end
            end
            bs1 = layer ? b2[og * 4] : b1[og * 4];         bs2 = layer ? b2[og * 4 + 1] : b1[og * 4 + 1];
            bs3 = layer ? b2[og * 4 + 2] : b1[og * 4 + 2]; bs4 = layer ? b2[og * 4 + 3] : b1[og * 4 + 3];
        end
    endtask

    task write_pgm;      // channel ch of l1 (layer 0) or l2 (layer 1)
        begin
            $sformat(fname, "%s/cat_%0d.pgm", layer ? "out_layer2" : "out_layer1", ch);
            fd = $fopen(fname, "w");
            $fwrite(fd, "P2\n%0d %0d\n255\n", `S, `S);
            for (n = 0; n < `S * `S; n = n + 1)
                $fwrite(fd, "%0d\n", layer ? l2[ch * `S * `S + n] : l1[ch * `NP + (n / `S + 1) * `WP + (n % `S + 1)]);
            $fclose(fd);
        end
    endtask

    initial begin
        $readmemh("../../data/conv1_kernel_hex.txt", w1);
        $readmemh("../../data/conv1_bias_hex.txt", b1);
        $readmemh("../../data/conv2_kernel_hex.txt", w2);
        $readmemh("../../data/conv2_bias_hex.txt", b2);
        fd = $fopen("../../data/cat224.bmp", "rb");
        k = $fread(bmp, fd);
        $fclose(fd);
        off = {bmp[13], bmp[12], bmp[11], bmp[10]};
        for (j = 0; j < 3 * `NP; j = j + 1) in0[j] = 0;
        for (j = 0; j < 64 * `NP; j = j + 1) l1[j] = 0;
        for (n = 0; n < `S * `S; n = n + 1) begin
            j = (n / `S + 1) * `WP + (n % `S + 1);
            in0[0 * `NP + j] = bmp[((n / `S) * 224 + (n % `S)) * 3 + off + 2];   // R
            in0[1 * `NP + j] = bmp[((n / `S) * 224 + (n % `S)) * 3 + off + 1];   // G
            in0[2 * `NP + j] = bmp[((n / `S) * 224 + (n % `S)) * 3 + off + 0];   // B
        end
        layer = 0; last = 0; ig = 0;
        for (og = 0; og < 16; og = og + 1) begin
            $display("conv1_1 output channels %0d-%0d", og * 4, og * 4 + 3);
            load_weights; run_pass;
        end
        for (ch = 0; ch < 64; ch = ch + 1) write_pgm;
        layer = 1;
        for (og = 0; og < 16; og = og + 1) begin
            $display("conv1_2 output channels %0d-%0d", og * 4, og * 4 + 3);
            for (ig = 0; ig < 16; ig = ig + 1) begin
                last = (ig == 15);
                load_weights; run_pass;
            end
        end
        for (ch = 0; ch < 64; ch = ch + 1) write_pgm;
        $display("ALL FEATURE MAPS WRITTEN");
        $finish;
    end
endmodule
