# 04 — CNN convolution engine (VGG-16 conv1_1 + conv1_2)

A streaming 3×3 convolution engine: a two-row line buffer per input channel,
4 PE groups × 4 input channels × 9 taps = 144 multipliers, four output
channels per pass. conv1_1 (3 → 64 channels) takes 16 passes over the
224 × 224 photo; conv1_2 (64 → 64) takes 16 × 16 passes, with the partial
sums kept between passes outside the engine (`psum_in` / `psum_out`).
9-bit pixels, 16-bit weights and biases, 36-bit accumulation, ReLU, then
`>> 4` (conv1_1) or `>> 7` (conv1_2) saturated to 8 bits.

| File | Content |
|---|---|
| `rtl/conv_engine.v` | the engine (`W_PAD` parameter = padded width, default 226) |
| `rtl/archive/` | the original `layer_1.v` / `layer_2.v` |
| `data/` | photo, conv1_1 / conv1_2 kernels and biases (hex) |
| `docs/` | conv1_1 / conv1_2 feature maps of the full 224 × 224 run (`*_original.png`: the original engine), original README |

## Verification
* `make legacy` — `tb/legacy/pre_syn_tb.v` runs both layers on a 24 × 24
  crop in Icarus, writes all 128 feature maps as PGM, and
  `tb/legacy/check_maps.py` compares them with a NumPy model
  (`make legacy-full`: the full image, slow in Icarus).
* `make verif` — the testbench acts as controller and memory and checks
  every cycle: `en` on exactly the valid windows, every conv1_1 output, every
  conv1_2 partial sum after every pass, every conv1_2 output — against an
  exact SV model, with real VGG-16 weights and with random weights / pixels
  (negative and saturated sums). 56 × 56 by default (7.2 M checks);
  `make -C verif full` runs 224 × 224 and dumps the feature maps.

**[BUGS.md](BUGS.md)** — why the original engine was rewritten: a sheared
3×3 window, a line buffer that did not fill, swapped channels, a misaligned
`en`, an impossible conv1_2 accumulator and wrap-around instead of
saturation.
