// =============================================================================
// tb_top.sv - project 01: d = s ? (a + b) * c : (a - b) * c   (8-bit in, 16-bit out)
//
//   hw2_nonpipe  combinational
//   hw2_pipe     2-stage pipeline (latency 2)
//   hw2_cg       2-stage pipeline whose stage registers are clock-gated when
//                c == 0 (the product is 0 anyway)
//
// Inputs are driven 1 ns after each rising edge, the way a register upstream
// would drive them, so they also change while clk is high.
// Checks: scoreboard per DUT at its latency; SVA that no gated clock ever
// pulses except together with clk (a glitch on a gated clock is a spurious
// capture edge); coverage of s, c == 0 runs and gating on/off transitions.
// =============================================================================
`timescale 1ns/1ps
module tb_top;
  localparam int HIST = 8;
  logic clk = 0, rst = 1;
  always #5 clk = ~clk;

  logic [7:0] a, b, c;
  logic       s;
  logic [15:0] d_np, d_p, d_cg;

  hw2_nonpipe u_np (.a, .b, .c, .s, .d(d_np));
  hw2_pipe    u_p  (.d(d_p),  .a, .b, .c, .s, .rst, .clk);
  hw2_cg      u_cg (.d(d_cg), .a, .b, .c, .s, .rst, .clk);

  function automatic logic [15:0] model(logic [7:0] x, logic [7:0] y, logic [7:0] z, logic sel);
    logic [15:0] t = sel ? (16'(x) + 16'(y)) : (16'(x) - 16'(y));
    return t * 16'(z);
  endfunction

  // ---------------------------------------------------------------- SVA
  // A gated clock may only rise when clk rises. Any other edge is a glitch
  // that clocks the stage registers in the middle of a cycle.
  int unsigned sva_errors = 0, glitches = 0;
  realtime last_clk_rise = -1;
  longint unsigned n_clk = 0, n_gclk = 0;
  always @(posedge clk) begin last_clk_rise = $realtime; n_clk++; end
  always @(posedge u_cg.gclk) n_gclk++;
  always @(posedge u_cg.gclk) begin
    #0;   // let the clk process of the same time step run first
    if ($realtime != last_clk_rise) begin
      glitches++;
      if (glitches <= 5) $error("[SVA] hw2_cg: gated clock rose at %0t without a clk edge (c changed while clk was high)", $realtime);
    end
  end

  logic started = 0;
  a_known: assert property (@(posedge clk) started |-> !$isunknown({d_np, d_p, d_cg}))
    else begin $error("[SVA] X on an output"); sva_errors++; end

  // ---------------------------------------------------------------- coverage
  bit cv_s, cv_c0, cv_prev_c0;
  covergroup cg_dp @(posedge clk);
    option.per_instance = 1;
    cp_s: coverpoint cv_s;
    cp_gate: coverpoint {cv_prev_c0, cv_c0} {
      bins run = {2'b00}; bins gate_off = {2'b01}; bins idle = {2'b11}; bins gate_on = {2'b10};
    }
    x_s_gate: cross cp_s, cp_gate;
  endgroup
  cg_dp cov = new();

  // ---------------------------------------------------------------- scoreboard
  logic [15:0] hist[HIST];
  longint unsigned n = 0, e_np = 0, e_p = 0, e_cg = 0;
  task automatic chk(string name, logic [15:0] got, logic [15:0] exp, ref longint unsigned err);
    if (got !== exp) begin
      err++;
      if (err <= 5) $display("[MISMATCH] %s: got %0d expected %0d at %0t", name, got, exp, $time);
    end
  endtask

  initial begin
    longint unsigned num = 100000;
    longint t = 0;
    void'($value$plusargs("NUM=%d", num));
    {a, b, c, s} = '0;
    repeat (2) @(posedge clk);
    #1 rst = 0;
    started = 1;
    for (longint i = 0; i < num; i++) begin
      @(posedge clk);
      #0.5;   // registers have updated; the vector of 2 edges ago is on d
      if (t >= 2) begin chk("hw2_pipe", d_p, hist[(t - 2) % HIST], e_p); chk("hw2_cg", d_cg, hist[(t - 2) % HIST], e_cg); end
      #0.5;
      // runs of c == 0 so that gating turns on and off
      if (($urandom_range(0, 3) == 0) || (c == 0 && $urandom_range(0, 1))) c = 0; else c = $urandom;
      a = $urandom; b = $urandom; s = $urandom_range(0, 1);
      hist[t % HIST] = model(a, b, c, s);
      #1 chk("hw2_nonpipe", d_np, hist[t % HIST], e_np);
      cv_prev_c0 = cv_c0; cv_c0 = (c == 0); cv_s = s;
      t++; n++;
    end
    $display("\n================ project 01 results ================");
    $display("  %-18s checks=%0d  errors=%0d  %s", "hw2_nonpipe", n, e_np, e_np == 0 ? "PASS" : "FAIL");
    $display("  %-18s checks=%0d  errors=%0d  %s", "hw2_pipe", n - 2, e_p, e_p == 0 ? "PASS" : "FAIL");
    $display("  %-18s checks=%0d  errors=%0d  %s", "hw2_cg", n - 2, e_cg, e_cg == 0 ? "PASS" : "FAIL");
    $display("  %-18s stage registers clocked in %0d of %0d cycles (%0.1f %% gated off)", "hw2_cg gating",
             n_gclk, n_clk, 100.0 * real'(n_clk - n_gclk) / real'(n_clk));
    $display("COVERAGE cg_dp    %0.2f", cov.get_inst_coverage());
    $display("  %-18s failures=%0d  %s", "SVA", sva_errors + glitches, (sva_errors + glitches) == 0 ? "PASS" : "FAIL");
    if (e_np || e_p || e_cg || sva_errors || glitches) $fatal(1, "TEST FAILED");
    $display("TEST PASSED");
    $finish;
  end
endmodule
