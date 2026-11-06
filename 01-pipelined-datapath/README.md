# 01 — Pipelined datapath with clock gating

`d = s ? (a + b) · c : (a − b) · c` with 8-bit inputs and a 16-bit result,
in three versions:

| File | Module | Latency |
|---|---|---:|
| `rtl/non_pipeline.v` | `hw2_nonpipe`, combinational | 0 |
| `rtl/pipeline.v` | `hw2_pipe`, add/subtract stage + multiply stage | 2 |
| `rtl/clock_gating.v` | `hw2_cg`, same pipeline; stage registers clock-gated when `c == 0` | 2 |

`syn/` has the Design Compiler / PrimeTime scripts and the gate-level
netlist + SDF of the clock-gated version.

## Verification
* `make legacy` — the course testbench. It prints results but checks
  nothing, and pairs each input with the output of a different vector in
  the clock-gating lines.
* `make verif` — 100 000 vectors driven 1 ns after each rising edge (as an
  upstream register would), scoreboard at each DUT's latency, an assertion
  that the gated clock only ever rises together with `clk`, coverage of
  gating turning on / off. Reports how often the stage registers are
  actually clocked (≈ 60 % of cycles with this stimulus).

**[BUGS.md](BUGS.md)** — the clock gate had no latch and glitched.
