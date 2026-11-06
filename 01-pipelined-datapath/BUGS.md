# Bug log — project 01

| # | DUT | Found by | Effect |
|---|-----|----------|--------|
| 1 | `hw2_cg` | gated-clock assertion | the gated clock pulsed in the middle of the cycle 15 046 times in 100 000 cycles |
| — | course testbench | review | prints results but checks nothing, and the clock-gating lines it prints pair each input with the output of a different vector (`cg_arr[i+3]` for a 2-cycle pipeline) |

## 1. Clock gating without a latch

**Symptom.** With inputs driven shortly after each rising edge (as from an
upstream register), `gclk` rose while `clk` was already high whenever `c`
went from 0 to non-zero.

**Root cause.**

```verilog
wire gclk = clk && c;
```

An AND gate gates the clock only if its enable never changes while the
clock is high. Here the enable is the data input `c`, which changes right
after the rising edge, so every 0 → non-zero transition makes a second,
short `gclk` pulse in the high phase. In RTL simulation the extra edge
happens to load the same values the next real edge would load and the
output stays correct (the scoreboard passed); in silicon it is a runt pulse
racing the data it is supposed to sample — a hold-time hazard and a
standard sign-off / lint violation.

**Fix.** A latch-based integrated clock gate: the enable `|c` is latched
while `clk` is low and `gclk = clk & en_latch`, so `gclk` can only pulse
with `clk`. The scoreboard still passes, the glitch assertion is clean, and
the stage registers are clocked only in cycles with `c != 0` (≈ 40 % of
cycles gated off with this stimulus).

The course testbench applies its inputs while `clk` is low, which is why it
never produced the glitch.
