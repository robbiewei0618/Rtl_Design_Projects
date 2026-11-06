// =============================================================================
// tb_top.sv - project 03: streaming Sobel edge detector, 480x360, pixel-exact
//
// The DUT receives one RGB pixel per clock of the zero-padded 482x362 image
// (row by row) and outputs, one clock after the window is complete, the
// thresholded horizontal / vertical Sobel responses of the 3x3 window that
// ends at the previous pixel. `en` must mark exactly the 480x360 windows that
// lie inside one image row band (not the ones that wrap around a row end,
// and not during the first two rows).
//
// Reference: a bit-exact SV model (same luminance approximation, same
// kernels and threshold compare) fed with the same stream.
// Images: the course photo (data/cat.bmp), RGB noise, sharp vertical and
// horizontal steps, and a ramp whose gradient sits right at the threshold;
// each is run with thresholds 130 (course value), 0 and 400.
// Inputs are driven on the falling edge so nothing races the rising edge.
// SVA: outputs are 0 or 255, no X when en is high.
// Coverage: Gx/Gy around the threshold (below / at / just above / far
// above / negative), window position (corner, border, interior), images.
// =============================================================================
`timescale 1ns/1ps
module tb_top;
  localparam int W = 480, H = 360, PW = W + 2, PH = H + 2, N = PW * PH;
  logic clk = 0, rst = 0;
  always #10 clk = ~clk;

  logic [7:0]         R, G, B, out_x, out_y;
  logic               en;
  logic signed [19:0] threshold;
  Edge_Detection dut (.clk, .rst, .threshold, .R, .G, .B, .out_x, .out_y, .en);

  int unsigned sva_errors = 0;
  a_binary: assert property (@(negedge clk) en |-> (out_x inside {8'd0, 8'd255}) && (out_y inside {8'd0, 8'd255}))
    else begin $error("[SVA] output not 0/255: %h %h", out_x, out_y); sva_errors++; end
  a_known: assert property (@(negedge clk) rst |-> !$isunknown(en) && (!en || !$isunknown({out_x, out_y})))
    else begin $error("[SVA] X on en / outputs"); sva_errors++; end

  // ---------------------------------------------------------------- stimulus
  logic [23:0] cat [W * H];
  logic [23:0] img [N];            // padded stream, RGB
  int          Y   [N];
  int          image_id;

  function automatic int lum(logic [23:0] p);
    logic [7:0] r = p[23:16], g = p[15:8], b = p[7:0];
    return int'(r >> 2) + int'(r >> 5) + int'(g >> 1) + int'(g >> 4) + (int'(b >> 3) - int'(b >> 7));
  endfunction

  task automatic build_image(int id);
    for (int k = 0; k < N; k++) img[k] = 24'h0;
    for (int h = 0; h < H; h++)
      for (int w = 0; w < W; w++) begin
        logic [23:0] p;
        case (id)
          0: p = cat[h * W + w];
          1: p = 24'($urandom);
          2: p = ((w / 7) % 2) ? 24'hFFFFFF : 24'h000000;                       // vertical steps
          3: p = ((h / 5) % 2) ? 24'hC0C0C0 : 24'h202020;                       // horizontal steps
          default: begin                                                       // ramp: Gx = 4*slope
            logic [7:0] v = 8'((w * 33) / 4);                                  // slope ~8.25 grey/pixel
            p = {v, v, v};
          end
        endcase
        img[(h + 1) * PW + (w + 1)] = p;
      end
    for (int k = 0; k < N; k++) Y[k] = lum(img[k]);
  endtask

  // ---------------------------------------------------------------- reference
  function automatic bit window_valid(int q);
    return (q % PW) >= 2 && (q / PW) >= 2;
  endfunction
  function automatic void ref_window(int q, int th, output logic [7:0] ex, output logic [7:0] ey, output int gx, output int gy);
    int r0 = Y[q - 2 * PW - 2], r1 = Y[q - 2 * PW - 1], r2 = Y[q - 2 * PW];
    int r3 = Y[q - PW - 2],     r5 = Y[q - PW];
    int r6 = Y[q - 2],          r7 = Y[q - 1],          r8 = Y[q];
    gx = (r2 - r0) + 2 * (r5 - r3) + (r8 - r6);
    gy = (r0 - r6) + 2 * (r1 - r7) + (r2 - r8);
    ex = gx > th ? 8'd255 : 8'd0;
    ey = gy > th ? 8'd255 : 8'd0;
  endfunction

  // ---------------------------------------------------------------- coverage
  int cv_gx_rel, cv_gy_rel, cv_pos, cv_img, cv_th;
  covergroup cg_sobel;
    option.per_instance = 1;
    cp_gx: coverpoint cv_gx_rel { bins negative = {-2}; bins below = {-1}; bins at = {0}; bins just_above = {1}; bins far_above = {2}; }
    cp_gy: coverpoint cv_gy_rel { bins negative = {-2}; bins below = {-1}; bins at = {0}; bins just_above = {1}; bins far_above = {2}; }
    cp_pos: coverpoint cv_pos { bins corner = {0}; bins border = {1}; bins interior = {2}; }
    cp_img: coverpoint cv_img { bins img[] = {[0:4]}; }
    cp_th: coverpoint cv_th { bins th[] = {0, 130, 400}; }
    x_gx_pos: cross cp_gx, cp_pos;
  endgroup
  cg_sobel cov = new();
  function automatic int rel(int g, int th);
    if (g < 0 && th >= 0) return -2;
    if (g < th) return -1;
    if (g == th) return 0;
    if (g <= th + 8) return 1;
    return 2;
  endfunction

  // ---------------------------------------------------------------- scoreboard
  longint unsigned n_checks = 0, n_errors = 0, n_missing = 0, n_extra = 0;
  task automatic run_image(int id, int th);
    longint unsigned outs = 0;
    logic [7:0] ex, ey;
    int gx, gy, q, row, col;
    build_image(id);
    threshold = th;
    rst = 0; {R, G, B} = '0;
    repeat (2) @(negedge clk);
    rst = 1;
    for (int k = 0; k < N + 2; k++) begin
      @(negedge clk);
      q = k - 2;      // window whose last pixel was captured two edges ago
      if (q >= 0) begin
        bit valid = window_valid(q);
        if (en && !valid) begin n_extra++; if (n_extra <= 5) $display("[MISMATCH] image %0d: en high for window ending at row %0d col %0d (not a valid window)", id, q / PW, q % PW); end
        if (!en && valid) begin n_missing++; if (n_missing <= 5) $display("[MISMATCH] image %0d: en low for valid window ending at row %0d col %0d", id, q / PW, q % PW); end
        if (en && valid) begin
          ref_window(q, th, ex, ey, gx, gy);
          n_checks++; outs++;
          if (out_x !== ex || out_y !== ey) begin
            n_errors++;
            if (n_errors <= 5) $display("[MISMATCH] image %0d th %0d window (%0d,%0d): out %0d/%0d expected %0d/%0d (Gx %0d Gy %0d)",
                                        id, th, q / PW - 2, q % PW - 2, out_x, out_y, ex, ey, gx, gy);
          end
          row = q / PW - 2; col = q % PW - 2;
          cv_gx_rel = rel(gx, th); cv_gy_rel = rel(gy, th); cv_img = id; cv_th = th;
          cv_pos = ((row == 0 || row == H - 1) && (col == 0 || col == W - 1)) ? 0 :
                   (row == 0 || row == H - 1 || col == 0 || col == W - 1) ? 1 : 2;
          cov.sample();
        end
      end
      if (k < N) {R, G, B} = img[k];
      else {R, G, B} = '0;
    end
    if (outs != W * H) begin n_errors++; $display("[MISMATCH] image %0d: %0d outputs, expected %0d", id, outs, W * H); end
  endtask

  initial begin
    $readmemh("build/cat_rgb.hex", cat);
    foreach (img[k]) img[k] = 0;
    for (int id = 0; id < 5; id++) run_image(id, 130);
    run_image(1, 0);
    run_image(4, 400);
    run_image(0, 0);
    run_image(2, 400);
    $display("\n================ project 03 results ================");
    $display("  %-18s checks=%0d  errors=%0d  %s   (en: %0d missing, %0d extra)", "Edge_Detection", n_checks,
             n_errors + n_missing + n_extra, (n_errors + n_missing + n_extra) == 0 ? "PASS" : "FAIL", n_missing, n_extra);
    $display("COVERAGE cg_sobel %0.2f", cov.get_inst_coverage());
    $display("  %-18s failures=%0d  %s", "SVA", sva_errors, sva_errors == 0 ? "PASS" : "FAIL");
    if (n_errors || n_missing || n_extra || sva_errors) $fatal(1, "TEST FAILED");
    $display("TEST PASSED");
    $finish;
  end
endmodule
