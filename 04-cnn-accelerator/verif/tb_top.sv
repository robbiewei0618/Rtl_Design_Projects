// =============================================================================
// tb_top.sv - project 04: conv_engine running VGG-16 conv1_1 + conv1_2
//
// The testbench is the accelerator's controller and memory: it streams the
// zero-padded input maps, loads 4 output channels of weights per pass, holds
// the conv1_2 partial sums between passes, and stores the conv1_1 results as
// the zero-padded input of conv1_2.
//
// Reference: an exact integer model of the same arithmetic in SV (3x3
// windows over the padded map, 9-bit pixels x 16-bit weights, ReLU, >>4 or
// >>7, saturation to 8 bits), computed independently of the DUT. conv1_2 is
// fed from the *reference* conv1_1 maps, so a layer-1 error cannot hide or
// cascade into layer 2.
// Checked every cycle: en exactly on the S x S valid windows; conv1_1 outputs;
// conv1_2 partial sums after every pass; conv1_2 outputs on the last pass.
// Runs: real VGG-16 weights on the photo, then random weights on random
// pixels (negative / saturated outputs).  +define+S_IMG=<S> picks the map
// size (default 56; 224 is the full image, see Makefile target `full`).
// =============================================================================
`timescale 1ns/1ns
`ifndef S_IMG
  `define S_IMG 56
`endif

module tb_top;
  localparam int S = `S_IMG, WP = S + 2, NP = WP * WP;
  logic clk = 0, rst = 1, layer = 0, last = 0;
  always #5 clk = ~clk;

  logic signed [8:0]        px[4];
  logic signed [9*4*16-1:0] wt[4];
  logic signed [15:0]       bs[4];
  logic signed [4*36-1:0]   psum_in, psum_out;
  logic [7:0]               out[4];
  logic                     en;

  conv_engine #(.W_PAD(WP)) dut (
    .clk, .rst, .layer, .last, .en,
    .pixel_1(px[0]), .pixel_2(px[1]), .pixel_3(px[2]), .pixel_4(px[3]),
    .input_weight_1(wt[0]), .input_weight_2(wt[1]), .input_weight_3(wt[2]), .input_weight_4(wt[3]),
    .input_bias_1(bs[0]), .input_bias_2(bs[1]), .input_bias_3(bs[2]), .input_bias_4(bs[3]),
    .psum_in, .psum_out, .out_1(out[0]), .out_2(out[1]), .out_3(out[2]), .out_4(out[3]));

  int unsigned sva_errors = 0;
  a_known: assert property (@(negedge clk) !rst |-> !$isunknown(en) && (!en || !$isunknown({out[0], out[1], out[2], out[3]})))
    else begin $error("[SVA] X on en/outputs"); sva_errors++; end

  // ---------------------------------------------------------------- data
  logic [23:0]       img [S * S];
  logic signed [15:0] w1 [64 * 3 * 9], b1 [64], w2 [64 * 64 * 9], b2 [64];
  byte unsigned      in_map  [64][NP];   // padded input maps of the current layer
  byte unsigned      l1_ref  [64][S * S];
  byte unsigned      l2_dut  [64][S * S];
  longint            psum    [4][S * S];  // conv1_2 partial sums (DUT side)
  longint            psum_ref[4][S * S];

  // ---------------------------------------------------------------- reference
  function automatic byte unsigned quant(longint v, int sh);
    longint q;
    if (v < 0) return 0;
    q = v >>> sh;
    return q > 255 ? 8'd255 : byte'(q);
  endfunction
  function automatic longint conv_px(int ic, int oc, int n, bit l2);   // one input channel, one output pixel
    int r = n / S, c = n % S;
    longint acc = 0;
    for (int t = 0; t < 9; t++) begin
      int pr = r + t / 3, pc = c + t % 3;    // padded coordinates of the tap
      longint w = l2 ? longint'(w2[(oc * 64 + ic) * 9 + t]) : longint'(w1[(oc * 3 + ic) * 9 + t]);
      acc += longint'(in_map[ic][pr * WP + pc]) * w;
    end
    return acc;
  endfunction

  // ---------------------------------------------------------------- coverage
  int cv_kind;   // 0: negative -> 0, 1: in range, 2: saturated
  int cv_pass;   // 0: conv1_1, 1: conv1_2 first, 2: middle, 3: last
  covergroup cg_cnn;
    option.per_instance = 1;
    cp_kind: coverpoint cv_kind { bins relu0 = {0}; bins in_range = {1}; bins saturated = {2}; }
    cp_pass: coverpoint cv_pass { bins l1 = {0}; bins l2_first = {1}; bins l2_mid = {2}; bins l2_last = {3}; }
    x_kind_layer: cross cp_kind, cp_pass { ignore_bins no_output = binsof(cp_pass) intersect {1, 2}; }
  endgroup
  cg_cnn cov = new();
  function automatic int kind_of(longint pre, int sh);
    if (pre < 0) return 0;
    return (pre >>> sh) > 255 ? 2 : 1;
  endfunction

  // ---------------------------------------------------------------- one pass
  longint unsigned n_checks = 0, n_errors = 0, n_en = 0;
  task automatic err(string msg);
    n_errors++;
    if (n_errors <= 8) $display("[MISMATCH] %s", msg);
  endtask

  // og: output group (4 channels), ig: input group (conv1_2 only)
  task automatic run_pass(bit l2, int og, int ig);
    int n_out = 0;
    layer = l2; last = l2 && (ig == 15);
    for (int k = 0; k < 4; k++) begin
      int oc = og * 4 + k;
      bs[k] = l2 ? b2[oc] : b1[oc];
      for (int j = 0; j < 36; j++) begin
        int ic = j / 9, t = j % 9;
        logic signed [15:0] w;
        if (l2) w = w2[(oc * 64 + ig * 4 + ic) * 9 + t];
        else    w = (ic < 3) ? w1[(oc * 3 + ic) * 9 + t] : 16'sd0;
        wt[k][j * 16 +: 16] = w;
      end
    end
    rst = 1; foreach (px[c]) px[c] = 0; psum_in = '0;
    repeat (2) @(negedge clk);
    rst = 0;
    for (int c = 0; c < 4; c++) px[c] = (l2 || c < 3) ? 9'(in_map[l2 ? ig * 4 + c : c][0]) : 9'sd0;
    for (int kk = 1; kk <= NP; kk++) begin
      int q;
      @(negedge clk);
      q = kk - 1;                                          // window ending at pixel q
      begin
        bit valid = (q % WP) >= 2 && (q / WP) >= 2;
        int n = (q / WP - 2) * S + (q % WP - 2);
        if (en !== valid) err($sformatf("pass %0d/%0d: en=%b for window ending at row %0d col %0d", og, ig, en, q / WP, q % WP));
        if (valid) begin
          // present the stored partial sums of this output pixel
          for (int k = 0; k < 4; k++) psum_in[k * 36 +: 36] = (l2 && ig > 0) ? 36'(psum[k][n]) : 36'sd0;
          #1;
          for (int k = 0; k < 4; k++) begin
            int oc = og * 4 + k;
            longint sum = 0, pre;
            if (!l2) begin
              for (int ic = 0; ic < 3; ic++) sum += conv_px(ic, oc, n, 0);
              pre = sum + b1[oc];
              n_checks++;
              if (out[k] !== quant(pre, 4)) err($sformatf("conv1_1 ch %0d pixel %0d: %0d, expected %0d", oc, n, out[k], quant(pre, 4)));
              l1_ref[oc][n] = quant(pre, 4);
              cv_kind = kind_of(pre, 4); cv_pass = 0; cov.sample();
            end else begin
              for (int ic = 0; ic < 4; ic++) sum += conv_px(ig * 4 + ic, oc, n, 1);
              psum_ref[k][n] = (ig == 0 ? 0 : psum_ref[k][n]) + sum;
              n_checks++;
              if (longint'($signed(psum_out[k * 36 +: 36])) != psum_ref[k][n])
                err($sformatf("conv1_2 ch %0d pixel %0d pass %0d: partial sum %0d, expected %0d", oc, n, ig,
                              $signed(psum_out[k * 36 +: 36]), psum_ref[k][n]));
              psum[k][n] = longint'($signed(psum_out[k * 36 +: 36]));
              cv_pass = ig == 0 ? 1 : (ig == 15 ? 3 : 2);
              if (ig == 15) begin
                pre = psum_ref[k][n] + b2[oc];
                n_checks++;
                if (out[k] !== quant(pre, 7)) err($sformatf("conv1_2 ch %0d pixel %0d: %0d, expected %0d", oc, n, out[k], quant(pre, 7)));
                l2_dut[oc][n] = out[k];
                cv_kind = kind_of(pre, 7);
              end else cv_kind = 1;
              cov.sample();
            end
          end
          n_out++; n_en++;
        end
      end
      // next pixel (zeros after the last one)
      for (int c = 0; c < 4; c++)
        px[c] = (kk < NP && (l2 || c < 3)) ? 9'(in_map[l2 ? ig * 4 + c : c][kk]) : 9'sd0;
    end
    if (n_out != S * S) err($sformatf("pass %0d/%0d: %0d outputs, expected %0d", og, ig, n_out, S * S));
  endtask

  task automatic run_network(string tag);
    // conv1_1 input: the image, zero-padded
    foreach (in_map[c, k]) in_map[c][k] = 0;
    for (int n = 0; n < S * S; n++) begin
      int p = (n / S + 1) * WP + (n % S + 1);
      in_map[0][p] = img[n][23:16]; in_map[1][p] = img[n][15:8]; in_map[2][p] = img[n][7:0];
    end
    for (int og = 0; og < 16; og++) run_pass(0, og, 0);
    if ($test$plusargs("L1_ONLY")) return;
    // conv1_2 input: the reference conv1_1 maps, zero-padded
    foreach (in_map[c, k]) in_map[c][k] = 0;
    for (int c = 0; c < 64; c++)
      for (int n = 0; n < S * S; n++) in_map[c][(n / S + 1) * WP + (n % S + 1)] = l1_ref[c][n];
    for (int og = 0; og < 16; og++)
      for (int ig = 0; ig < 16; ig++) run_pass(1, og, ig);
    $display("  %s: done (%0d checks so far, %0d errors)", tag, n_checks, n_errors);
  endtask

  task automatic dump_maps(string dir);
    int fd;
    for (int c = 0; c < 64; c++) begin
      fd = $fopen($sformatf("%s/l1_%0d.pgm", dir, c), "w");
      $fwrite(fd, "P2\n%0d %0d\n255\n", S, S);
      for (int n = 0; n < S * S; n++) $fwrite(fd, "%0d\n", l1_ref[c][n]);
      $fclose(fd);
      fd = $fopen($sformatf("%s/l2_%0d.pgm", dir, c), "w");
      $fwrite(fd, "P2\n%0d %0d\n255\n", S, S);
      for (int n = 0; n < S * S; n++) $fwrite(fd, "%0d\n", l2_dut[c][n]);
      $fclose(fd);
    end
  endtask

  initial begin
    string dump, dir = "build";
    void'($value$plusargs("DATA=%s", dir));   // directory written by prep.py
    $readmemh({dir, "/img.hex"}, img);
    $readmemh({dir, "/w1.hex"}, w1); $readmemh({dir, "/b1.hex"}, b1);
    $readmemh({dir, "/w2.hex"}, w2); $readmemh({dir, "/b2.hex"}, b2);
    run_network("VGG-16 weights, photo");
    if ($value$plusargs("DUMP=%s", dump)) dump_maps(dump);
    if (!$test$plusargs("VGG_ONLY")) begin
    // random weights / pixels: large and negative sums
    foreach (img[n]) img[n] = $urandom;
    foreach (w1[i]) w1[i] = 16'($urandom_range(0, 1) ? $urandom : ($urandom_range(0, 255) - 128));
    foreach (w2[i]) w2[i] = 16'($urandom_range(0, 1) ? ($urandom & 16'h0FFF) - 16'h0800 : ($urandom_range(0, 63) - 32));
    foreach (b1[i]) b1[i] = 16'($urandom);
    foreach (b2[i]) b2[i] = 16'($urandom);
    run_network("random weights, random pixels");
    end
    $display("\n================ project 04 results ================");
    $display("  %-18s checks=%0d  errors=%0d  %s   (%0d x %0d maps, %0d network(s) x 272 passes)", "conv_engine",
             n_checks, n_errors, n_errors == 0 ? "PASS" : "FAIL", S, S, $test$plusargs("VGG_ONLY") ? 1 : 2);
    $display("COVERAGE cg_cnn   %0.2f", cov.get_inst_coverage());
    $display("  %-18s failures=%0d  %s", "SVA", sva_errors, sva_errors == 0 ? "PASS" : "FAIL");
    if (n_errors || sva_errors) $fatal(1, "TEST FAILED");
    $display("TEST PASSED");
    $finish;
  end
endmodule
