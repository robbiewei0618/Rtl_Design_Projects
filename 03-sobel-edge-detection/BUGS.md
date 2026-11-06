# Bug log — project 03

The datapath (luminance, line buffer taps, Sobel kernels, threshold) is
pixel-exact: wherever the testbench and the DUT agreed on *which* window an
output belongs to, the value was right. What was wrong was the framing.

| # | Where | Found by | Effect |
|---|-------|----------|--------|
| 1 | `LineBuffer` `en` | window-validity check in the scoreboard | per image 1 680 outputs flagged valid that were not (windows wrapping around a row end, and the first two rows) and 720 valid ones dropped; every output row came out shifted by two pixels |
| 2 | course testbench | comparing VCS, Icarus and a Python model | inputs and reset changed on the rising clock edge: a race, so VCS and Icarus wrote different images (1.1–1.4 % of pixels) and neither matched the model; the last window was never written |
| — | `Conv` | review | non-blocking assignments in a combinational block (cleaned up; no functional change) |

## 1. `en` did not mark the valid windows

The DUT gets the zero-padded image as a 482-pixel-wide stream. A 3×3 window
is real only if its last pixel is in column ≥ 2 and row ≥ 2 of the padded
image; otherwise it wraps around a row end or still contains the padding
rows above the image. The design generated `en` from a free-running counter:

```verilog
if (counter == 481 || counter == 0) en <= 0; else en <= 1;
counter <= (counter == 481 ? 0 : counter + 1);
```

The counter is one cycle out of phase with the window registers, so `en`
dropped the windows ending in columns 480–481 and passed the two wrapping
windows instead; it was also high during the first two rows, which the
course testbench papered over with `if (en && idx > 482+482-1)`.

**Fix.** Track the row and column of the pixel in the newest line-buffer
register and set `en` when the window loaded into `R0..R8` ends at column
≥ 2 and row ≥ 2. `en` now means exactly "this output is a pixel of the
result" — 480 × 360 of them, nothing else.

## 2. The course testbench raced the clock

Reset was released and every pixel applied at the same instant as a
rising clock edge, and the outputs were sampled at rising edges too. Which
value a flip-flop sees is then up to the simulator's event ordering: the
original VCS images and an Icarus run of the same RTL differ in 1 941 (x)
and 2 451 (y) pixels. The original VCS RTL and gate-level images are kept
in `tb/legacy/golden/original_vcs_*.bmp` for reference.

**Fix.** Reset release and pixels move to the falling edge; one extra clock
at the end lets the last window out. `make legacy` now compares both
images with a bit-exact Python model (`tb/legacy/check_images.py`): 0 of
172 800 pixels differ, and the model's images are in `tb/legacy/golden/`.
