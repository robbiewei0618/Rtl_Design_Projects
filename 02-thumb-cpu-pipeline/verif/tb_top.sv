// =============================================================================
// tb_top.sv - lockstep differential test of the Thumb pipeline
//
//   DUT: rtl/thumb_pipe.v    (module thumb, stage-split refactoring)
//   REF: golden/thumb_ref.v  (course-provided pipelined Thumb CPU)
//
// The refactoring must be cycle-for-cycle equivalent to the reference, so
// both cores run the same random program from separate memories and every
// cycle the testbench compares: instruction address, all memory strobes and
// addresses, store data, the 8 general registers and the N/Z/C/V flags.
// (Neither core forwards or stalls on data hazards; equivalence is the
// contract, not ISA-level correctness of hazard-free code.)
//
// Programs: +PROGS=<n> programs (default 300) of 128 instructions, drawn
// from every Thumb-1 format the cores decode (shifts, add/sub, imm8, ALU,
// loads/stores of all widths, SP/PC-relative, PUSH/POP, conditional and
// unconditional branches, BL pairs) plus 10 % fully random encodings, run for
// +CYCLES=<n> cycles each (default 400). Data memory starts random.
// SVA: read and write strobes never both active, no X on addresses or store
// data. Coverage: every internal opcode reaching EX, branch taken/not taken
// per condition code, loads/stores.
// =============================================================================
`timescale 1ns/1ns
`define WORD_SIZE 32
`define HWORD_SIZE 16
`define REG_FILE_SIZE 8

module tb_top;
  logic clk = 0, reset_n = 0;
  always #50 clk = ~clk;

  // ------------------------------------------------------------------ cores
  wire        d_rin, d_rdn, d_wrn, r_rin, r_rdn, r_wrn;
  wire [31:0] d_iaddr, d_daddr, d_data, r_iaddr, r_daddr, r_data;
  wire [15:0] d_instr, r_instr;

  thumb     u_dut (d_rin, d_iaddr, d_instr, d_rdn, d_wrn, d_daddr, d_data, reset_n, clk);
  thumb_ref u_ref (r_rin, r_iaddr, r_instr, r_rdn, r_wrn, r_daddr, r_data, reset_n, clk);

  // ------------------------------------------------------------------ memories
  logic [15:0] imem [256];
  logic [31:0] dmem_d [256], dmem_r [256];
  assign d_instr = imem[d_iaddr[7:0]];
  assign r_instr = imem[r_iaddr[7:0]];
  assign d_data  = d_rdn ? 32'hzzzz_zzzz : dmem_d[d_daddr[7:0]];
  assign r_data  = r_rdn ? 32'hzzzz_zzzz : dmem_r[r_daddr[7:0]];
  always @(negedge clk) begin
    if (reset_n && !d_wrn) dmem_d[d_daddr[7:0]] <= d_data;
    if (reset_n && !r_wrn) dmem_r[r_daddr[7:0]] <= r_data;
  end

  // ------------------------------------------------------------------ SVA
  int unsigned sva_errors = 0, reset_errors = 0;
  a_strobes: assert property (@(negedge clk) reset_n |-> !(!d_rdn && !d_wrn))
    else begin $error("[SVA] DUT reads and writes data memory in the same cycle"); sva_errors++; end
  a_known: assert property (@(negedge clk) reset_n |-> !$isunknown({d_iaddr, d_rin, d_rdn, d_wrn}))
    else begin $error("[SVA] X on instruction address / strobes"); sva_errors++; end
  a_store: assert property (@(negedge clk) reset_n && !d_wrn |-> !$isunknown({d_daddr, d_data}))
    else begin $error("[SVA] X on store address / data"); sva_errors++; end

  // ------------------------------------------------------------------ coverage
  int  cv_op;
  bit  cv_taken;
  int  cv_cond;
  covergroup cg_cpu;
    option.per_instance = 1;
    // internal opcodes (thumb_pipe.v `defines); the cores do not implement
    // LDMIA / STMIA / POP-PC / PUSH-LR (decoded as UNDEF), BL_BLX_H11 is
    // only reached as the second half of a BL pair, which is generated
    cp_op: coverpoint cv_op {
      bins op[] = {[0:18], [20:44], [46:58]};
      bins undef = {63};
      ignore_bins unimplemented = {19, 45, 39, 40, 41, 42};   // LDMIA STMIA POP_R0/R1 PUSH_R0/R1 checked below
    }
    cp_push_pop: coverpoint cv_op { bins push_pop[] = {39, 41}; }
    cp_branch: coverpoint {cv_cond, cv_taken} iff (cv_op == 10) {   // B_1 (conditional)
      bins eq_t = {5'h01}; bins eq_n = {5'h00}; bins ne_t = {5'h03}; bins ne_n = {5'h02};
      bins cs_t = {5'h05}; bins cs_n = {5'h04}; bins mi_t = {5'h09}; bins mi_n = {5'h08};
      bins ge_t = {5'h15}; bins ge_n = {5'h14}; bins lt_t = {5'h17}; bins lt_n = {5'h16};
      bins gt_t = {5'h19}; bins gt_n = {5'h18}; bins le_t = {5'h1B}; bins le_n = {5'h1A};
    }
  endgroup
  cg_cpu cov = new();
  int id_cond_q;   // condition of the instruction that has just moved from ID to EX
  always @(negedge clk) if (reset_n) begin
    cv_op = int'(u_dut.EX_opcode); cv_taken = u_dut.branch_taken; cv_cond = id_cond_q;
    cov.sample();
    id_cond_q = int'(u_dut.ID_cond);
  end

  // ------------------------------------------------------------------ programs
  function automatic logic [2:0] r3(); return 3'($urandom); endfunction
  function automatic logic [15:0] rand_instr();
    case ($urandom_range(0, 19))
      0:  return {3'b000, 2'($urandom_range(0, 2)), 5'($urandom), r3(), r3()};          // LSL/LSR/ASR imm
      1:  return {5'b00011, 1'($urandom), 1'($urandom), r3(), r3(), r3()};              // ADD/SUB reg/imm3
      2, 3: return {3'b001, 2'($urandom), r3(), 8'($urandom)};                          // MOV/CMP/ADD/SUB imm8
      4, 5: return {6'b010000, 4'($urandom), r3(), r3()};                               // ALU ops
      6:  return {5'b01001, r3(), 8'($urandom)};                                        // LDR PC-relative
      7:  return {4'b0101, 3'($urandom), r3(), r3(), r3()};                             // load/store reg offset
      8, 9: return {3'b011, 1'($urandom), 1'($urandom), 5'($urandom), r3(), r3()};      // LDR/STR(B) imm
      10: return {4'b1000, 1'($urandom), 5'($urandom), r3(), r3()};                     // LDRH/STRH imm
      11: return {4'b1001, 1'($urandom), r3(), 8'($urandom)};                           // LDR/STR SP-relative
      12: return {4'b1010, 1'($urandom), r3(), 8'($urandom)};                           // ADD Rd, PC/SP
      13: return {8'b1011_0000, 1'($urandom), 7'($urandom_range(0, 8))};                // ADD/SUB SP
      14: return {4'b1011, 1'($urandom), 2'b10, 1'b0, 8'(1 << $urandom_range(0, 7))};   // PUSH/POP one reg
      15, 16: return {4'b1101, 4'($urandom_range(0, 13)), 8'($urandom_range(0, 12) - 6)}; // B<cond>
      17: return {5'b11100, 11'($urandom_range(0, 16) - 8)};                            // B
      18: return {5'b11110, 11'd0};                                                     // BL prefix (offset 0)
      default: return 16'($urandom);                                                    // anything
    endcase
  endfunction

  task automatic load_program(int p);
    for (int k = 0; k < 256; k++) begin
      dmem_d[k] = $urandom; dmem_r[k] = dmem_d[k];
      imem[k] = 16'h2000;   // MOV r0,#0 (odd addresses are never fetched)
    end
    for (int k = 0; k < 256; k += 2) begin
      imem[k] = rand_instr();
      if (imem[k][15:11] == 5'b11110) imem[k + 2 > 255 ? k : k + 2] = {5'b11111, 11'($urandom_range(0, 12))};  // BL suffix
    end
    // prologue: define every register and all four flags before comparing
    for (int k = 0; k < 16; k += 2) imem[k] = {3'b001, 2'b00, 3'(k / 2), 8'($urandom)};  // MOV rN,#imm
    imem[16] = {5'b00101, 3'($urandom), 8'($urandom)};                                   // CMP rN,#imm
  endtask
  localparam int WARM = 14;   // prologue (9 instructions) + pipeline depth

  // ------------------------------------------------------------------ lockstep compare
  longint unsigned n_cycles = 0, n_mismatch = 0, n_progs = 0;
  int unsigned prog_mismatch;
  task automatic compare(int p, int cyc);
    string what = "";
    if (d_iaddr !== r_iaddr) what = {what, $sformatf(" iaddr %h/%h", d_iaddr, r_iaddr)};
    if ({d_rin, d_rdn, d_wrn} !== {r_rin, r_rdn, r_wrn}) what = {what, $sformatf(" strobes %b/%b", {d_rin, d_rdn, d_wrn}, {r_rin, r_rdn, r_wrn})};
    if ((!d_rdn || !d_wrn) && d_daddr !== r_daddr) what = {what, $sformatf(" daddr %h/%h", d_daddr, r_daddr)};
    if (!d_wrn && d_data !== r_data) what = {what, $sformatf(" store %h/%h", d_data, r_data)};
    for (int r = 0; r < 8; r++) if (u_dut.R[r] !== u_ref.R[r]) what = {what, $sformatf(" r%0d %h/%h", r, u_dut.R[r], u_ref.R[r])};
    if ({u_dut.step3.N_Flag, u_dut.step3.Z_Flag, u_dut.step3.C_Flag, u_dut.step3.V_Flag} !==
        {u_ref.N_Flag, u_ref.Z_Flag, u_ref.C_Flag, u_ref.V_Flag}) what = {what, " flags"};
    n_cycles++;
    if (what != "") begin
      n_mismatch++; prog_mismatch++;
      if (n_mismatch <= 8) $display("[MISMATCH] program %0d cycle %0d (EX opcode %0d):%s", p, cyc, u_ref.EX_opcode, what);
    end
  endtask

  initial begin
    int unsigned progs = 300, cycles = 400;
    void'($value$plusargs("PROGS=%d", progs));
    void'($value$plusargs("CYCLES=%d", cycles));
    for (int p = 0; p < progs; p++) begin
      // flush both pipelines with a harmless instruction, then reset
      foreach (imem[k]) imem[k] = 16'h2000;   // MOV r0,#0
      reset_n = 1;
      repeat (6) @(negedge clk);
      reset_n = 0;
      load_program(p);
      repeat (3) @(negedge clk);
      reset_n = 1;
      prog_mismatch = 0;
      for (int c = 0; c < cycles; c++) begin
        @(negedge clk);
        // nothing can retire in the first 3 cycles after reset: the register
        // file must still hold its reset value
        if (c < 3) for (int r = 0; r < 8; r++)
          if (u_dut.R[r] !== 32'hFFFF_FFFF) begin
            reset_errors++;
            if (reset_errors <= 3) $error("[SVA] DUT: r%0d = %h in cycle %0d after reset (an instruction retired out of reset)", r, u_dut.R[r], c);
          end
        if (c >= WARM) compare(p, c);
        if (prog_mismatch > 3) break;     // one divergence is enough per program
      end
      for (int k = 0; k < 256; k++)
        if (dmem_d[k] !== dmem_r[k]) begin
          n_mismatch++;
          if (n_mismatch <= 8) $display("[MISMATCH] program %0d: data memory word %0d %h/%h", p, k, dmem_d[k], dmem_r[k]);
          break;
        end
      n_progs++;
    end
    $display("\n================ project 02 results ================");
    $display("  %-18s checks=%0d  errors=%0d  %s   (%0d programs, cycle-by-cycle)", "lockstep vs ref", n_cycles,
             n_mismatch, n_mismatch == 0 ? "PASS" : "FAIL", n_progs);
    $display("COVERAGE cg_cpu   %0.2f", cov.get_inst_coverage());
    $display("  %-18s failures=%0d  %s", "SVA", sva_errors + reset_errors, (sva_errors + reset_errors) == 0 ? "PASS" : "FAIL");
    if (n_mismatch != 0 || sva_errors != 0 || reset_errors != 0) $fatal(1, "TEST FAILED");
    $display("TEST PASSED");
    $finish;
  end
endmodule
