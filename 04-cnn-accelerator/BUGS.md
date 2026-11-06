# Bug log — project 04

The original engine (`rtl/archive/layer_1.v`, course testbench
`tb/legacy/archive_pre_syn_tb.v`) produced feature maps that *looked* like
edge and texture responses, which is why nothing seemed wrong. Checked
pixel by pixel against an exact integer model, conv1_1 was wrong in
4 467 642 of 6 422 528 channel-pixel checks (70 %), and conv1_2 could not
be computed by that architecture at all.

The fix is a rewrite of the engine as `rtl/conv_engine.v`. It keeps the
original structure (226-wide line buffer, 4 PE groups × 4 input channels ×
9 taps = 144 multipliers, 4 output channels per pass, 16 / 256 passes for
the two layers, same quantisation), and changes the items below.

| # | Where | Found by | Effect |
|---|-------|----------|--------|
| 1 | window taps | scoreboard | the 3×3 window used rows 224 and 448 pixels apart in a 226-wide stream: the middle row was shifted 2 pixels and the bottom row 4 pixels — a sheared window |
| 2 | line-buffer fill | review + scoreboard | for the first 455 pixels of every pass, every pixel was written to the same buffer entry and nothing shifted, so the first rows were wrong |
| 3 | channel order | review | input channels 2 and 3 were swapped (`buffer[1] <= pixel_3`), so conv1_1 applied the G kernel to B and vice versa, and conv1_2 swapped every second channel pair |
| 4 | `en` | scoreboard | `en` was derived from a free-running counter and did not mark the windows that wrap around a row end |
| 5 | conv1_2 accumulation | review, Verilator lint | one 36-bit accumulator per output channel, updated combinationally from itself (`sum = sum + ...`, a zero-delay loop) and also reset in the clocked block (two drivers): partial sums of 50 176 pixels cannot be kept across 16 passes in four registers |
| 6 | output quantisation | scoreboard (random weights) | `sum[11:4]` / `sum[14:7]` without saturation: a sum of 4 096 or more wrapped around and a bright pixel came out dark |
| 7 | course testbench | review | conv1_2 fed `padding_img_after_layer1[jdx+4]` as the 4th input channel instead of `jdx+3` |

## Fixes

1. Taps at offsets `0..2`, `W_PAD..W_PAD+2`, `2·W_PAD..2·W_PAD+2`, with
   the padded width a parameter (`W_PAD`, default 226), so the same engine
   can be verified quickly on small maps.
2. The buffer always shifts; there is no special fill phase.
3. `buffer[c]` receives `pixel_{c+1}`, in order.
4. `en` follows the row/column of the newest pixel and is high exactly for
   the S × S windows that lie inside the map (same scheme as project 03).
5. Partial sums leave the engine: `psum_out = psum_in + Σ` per output
   pixel, and the controller keeps them in a buffer between passes — in a
   real accelerator an SRAM of S² × 4 × 36 bits, here the testbench. The
   bias, ReLU and scaling are applied on the last pass (`last = 1`).
6. ReLU, arithmetic shift, then saturation to 0…255.
7. The new image testbench feeds channels `4·ig … 4·ig+3`.

## How it is checked now

* `verif/` (Verilator): the testbench acts as controller and memory and
  checks **every cycle** — `en` on exactly the valid windows, every conv1_1
  output, every conv1_2 partial sum after every pass, every conv1_2 output —
  against an exact SV model fed from its own copies of the maps (conv1_2
  uses the *reference* conv1_1 maps, so a layer-1 error cannot hide in layer
  2). Two networks per run: the real VGG-16 weights on the photo, then
  random weights and pixels to drive sums negative and into saturation.
  56 × 56 by default (7.2 M checks, ~10 s); `make -C verif full` runs the
  whole 224 × 224 image.
* `tb/legacy/` (Icarus): a course-style testbench writes all 128 feature
  maps as PGM images and `check_maps.py` compares them with an independent
  NumPy implementation.

So three implementations — RTL, SV model, NumPy model — agree bit for bit.
