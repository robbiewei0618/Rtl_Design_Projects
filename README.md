# Digital Systems in Verilog — RTL and Verification

[![CI](https://github.com/robbiewei0618/Rtl_Design_Projects/actions/workflows/ci.yml/badge.svg)](https://github.com/robbiewei0618/Rtl_Design_Projects/actions/workflows/ci.yml)
![Simulators](https://img.shields.io/badge/simulators-Icarus%2012%20%7C%20Verilator%205.054-blue)

Four graduate-course projects on digital *systems*: a clock-gated pipelined
datapath, a pipelined Thumb CPU, a streaming Sobel edge detector and a CNN
convolution engine for the first two VGG-16 layers. (The arithmetic-unit
projects — adders, multipliers, FMA, dot product — are in
[digital-hardware-projects](https://github.com/robbiewei0618/digital-hardware-projects).)

Each project keeps its RTL, synthesis scripts, netlists and report, and now has:

* the **course testbench**, runnable on Icarus Verilog (`make legacy`), with
  image outputs checked pixel by pixel against Python models where the
  original only wrote files;
* a new **verification environment** on Verilator (`make verif`): reference
  models, scoreboards that know which output belongs to which input,
  assertions and functional coverage.

What the verification found is in each project's `BUGS.md`: a glitching
clock gate, a CPU that never released its data bus, an edge detector whose
valid flag was one cycle out of phase, and a CNN engine whose 3×3 window was
sheared — none of which the course testbenches could see.

<!-- results:begin -->
| Project | Checker | Checks | Errors | Result |
|---|---|---:|---:|:---:|
| 01-pipelined-datapath | hw2_nonpipe | 100,000 | 0 | ✅ |
| 01-pipelined-datapath | hw2_pipe | 99,998 | 0 | ✅ |
| 01-pipelined-datapath | hw2_cg | 99,998 | 0 | ✅ |
| 02-thumb-cpu-pipeline | lockstep vs ref (300 programs, cycle-by-cycle) | 115,800 | 0 | ✅ |
| 03-sobel-edge-detection | Edge_Detection (en: 0 missing, 0 extra) | 1,555,200 | 0 | ✅ |
| 04-cnn-accelerator | conv_engine (56 x 56 maps, 2 network(s) x 272 passes) | 7,225,344 | 0 | ✅ |

| Project | Course testbenches (Icarus) | Functional coverage | SVA failures |
|---|---|---|---:|
| 01-pipelined-datapath | 1/1 pass | cg_dp 100.0 % | 0 |
| 02-thumb-cpu-pipeline | 2/2 pass | cg_cpu 100.0 % | 0 |
| 03-sobel-edge-detection | 2/2 pass | cg_sobel 100.0 % | 0 |
| 04-cnn-accelerator | 2/2 pass | cg_cnn 100.0 % | 0 |
<!-- results:end -->

*Generated from `make test` by `scripts/summarize.py` (seed 1). CI re-runs everything on every push.*

## The projects

| # | Folder | Design | How it is verified now | Bugs |
|---|--------|--------|------------------------|-----:|
| 01 | [`01-pipelined-datapath`](01-pipelined-datapath) | `d = (a ± b) · c`: combinational, 2-stage pipeline, pipeline with clock gating | scoreboard at each latency with inputs driven like an upstream register, gated-clock glitch assertion, gating on/off coverage | **1** — [BUGS.md](01-pipelined-datapath/BUGS.md) |
| 02 | [`02-thumb-cpu-pipeline`](02-thumb-cpu-pipeline) | 4-stage Thumb CPU (IF / ID / EX / WB) refactored into stage modules from the course core | random programs run in lockstep against the course core, every cycle compared; 4-state tri-state bus test; opcode / branch coverage | **2** — [BUGS.md](02-thumb-cpu-pipeline/BUGS.md) |
| 03 | [`03-sobel-edge-detection`](03-sobel-edge-detection) | streaming Sobel edge detector, 480×360, luminance → 2-row line buffer → 3×3 kernels | pixel-exact model, 5 images × 3 thresholds, `en` checked on every cycle; course images checked against a Python model | **2** — [BUGS.md](03-sobel-edge-detection/BUGS.md) |
| 04 | [`04-cnn-accelerator`](04-cnn-accelerator) | 3×3 convolution engine, 144 MACs, VGG-16 conv1_1 (3→64) + conv1_2 (64→64) | testbench as controller + psum memory, every output and partial sum checked against an exact model; NumPy cross-check of all 128 feature maps | **7** — [BUGS.md](04-cnn-accelerator/BUGS.md) |

Highlights:

* **Clock gating without a latch** (01): `gclk = clk && c` pulsed in the
  middle of the cycle 15 046 times in 100 000 when `c` changed during the
  high phase. The outputs were still right in RTL simulation, so only an
  assertion on the clock itself shows it. Replaced by a latch-based ICG.
* **A bus that was never released** (02): the CPU drove `0` on the shared
  data bus outside writes, so every load read `X` bits. A 2-state simulator
  (Verilator) resolves that silently; a small 4-state Icarus test catches it.
* **Equivalence as the contract** (02): the refactored pipeline runs 300
  random programs cycle-for-cycle against the course core without a single
  difference — after the testbench learned to flush both pipelines and to
  ignore the reference core's reset behaviour.
* **Valid flag one cycle out of phase** (03): every output row was shifted by
  two pixels with two wrap-around pixels at its start; the course testbench
  also raced the clock, so VCS and Icarus wrote different images.
* **Plausible but wrong** (04): the CNN's feature maps looked like
  convolution outputs, but the window was sheared (taps 224/448 apart in a
  226-wide stream) and 70 % of conv1_1 pixels were wrong; conv1_2 could not
  be computed by the original architecture at all. The rewritten engine
  keeps partial sums outside, as a real accelerator would.

## Running it

Needs Icarus Verilog (≥ 11), Verilator (≥ 5.0 with `--timing`) and Python 3
with NumPy.

```bash
make test          # every course testbench + every verification run
make legacy        # course testbenches only
make verif         # new verification only
make -C 04-cnn-accelerator/verif full    # the full 224x224 CNN run (~10 min)
```

## Repository layout

```
common/mk/       shared Verilator rules, course-testbench runner
NN-project/
  rtl/           final design (rtl/archive/: earlier or alternative versions)
  golden/        reference model, where one exists (02: the course Thumb core)
  tb/legacy/     course testbench, inputs, image checkers
  verif/         new testbench, assertions, coverage
  syn/ apr/      Design Compiler / PrimeTime / Innovus scripts, netlists, reports
  docs/          course report, waveforms, result images
  BUGS.md        what the verification found
```

## Synthesis

From the course runs (Synopsys Design Compiler, TSRI N16 ADFP), before the
fixes above. Thumb CPU: 4 641 µm², setup slack met at the delay-optimised
constraint (`syn/reports/`). Sobel edge detector: 28 264 µm² (`syn/edge_detection/`),
dominated by the 967-entry line buffer. Netlists and SDF files are kept
under each project's `syn/`.
