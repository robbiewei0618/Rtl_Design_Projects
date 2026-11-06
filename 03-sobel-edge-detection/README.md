# 03 — Streaming Sobel edge detector

One RGB pixel per clock of a zero-padded 480 × 360 image → luminance
(`Y ≈ 0.28 R + 0.56 G + 0.12 B` from shifts) → a 967-entry line buffer
holding two rows + three pixels → horizontal and vertical 3×3 Sobel
kernels → threshold (255 / 0). `en` marks the outputs that are image
pixels.

| File | Module |
|---|---|
| `rtl/edge_detection.v` | `Edge_Detection` (top) |
| `rtl/Intensity.v`, `LineBuffer.v`, `Conv.v` | the three stages |

## Verification
* `make legacy` — the course testbench on the photo (`tb/legacy/data/cat.bmp`),
  then `tb/legacy/check_images.py` compares both output images with a
  bit-exact Python model: 0 of 172 800 pixels differ. The model's images
  are in `tb/legacy/golden/`, next to the original VCS outputs.
* `make verif` — a bit-exact SV model checks every output against the window
  it belongs to and checks `en` on every cycle; five images (photo, noise,
  vertical and horizontal steps, ramps sweeping every gradient) at
  thresholds 0, 130 and 400 — 1.56 M checked pixels. Coverage: gradient
  relative to the threshold (negative / below / equal / just above / far
  above) × threshold, window position (corner / border / interior).

**[BUGS.md](BUGS.md)** — `en` was one cycle out of phase with the window,
and the course testbench raced the clock.
