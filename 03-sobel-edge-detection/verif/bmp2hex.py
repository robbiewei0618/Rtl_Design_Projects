#!/usr/bin/env python3
"""bmp2hex.py IN.bmp OUT.hex - 24-bit BMP to one 'RRGGBB' hex word per pixel,
in the BMP's own row order (the order the course testbench streams it)."""
import sys
b = open(sys.argv[1], 'rb').read()
off = int.from_bytes(b[10:14], 'little'); w = int.from_bytes(b[18:22], 'little'); h = int.from_bytes(b[22:26], 'little')
assert (w, h) == (480, 360), (w, h)
with open(sys.argv[2], 'w') as f:
    for i in range(w * h):
        B, G, R = b[off + 3 * i: off + 3 * i + 3]
        f.write(f'{R:02x}{G:02x}{B:02x}\n')
