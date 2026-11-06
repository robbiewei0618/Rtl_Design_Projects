#!/usr/bin/env python3
"""prep.py S OUTDIR - inputs for the conv_engine testbench.

Writes OUTDIR/img.hex: the top-left S x S crop of data/cat224.bmp, one
'RRGGBB' word per pixel in file (stream) order, and OUTDIR/{w1,b1,w2,b2}.hex:
the conv1_1 / conv1_2 kernels and biases (16-bit, [out][in][ky][kx])."""
import shutil
import sys

S, out = int(sys.argv[1]), sys.argv[2]
b = open('../data/cat224.bmp', 'rb').read()
off = int.from_bytes(b[10:14], 'little'); W = int.from_bytes(b[18:22], 'little')
with open(f'{out}/img.hex', 'w') as f:
    for h in range(S):
        for w in range(S):
            B, G, R = b[off + 3 * (h * W + w): off + 3 * (h * W + w) + 3]
            f.write(f'{R:02x}{G:02x}{B:02x}\n')
for src, dst in (('conv1_kernel_hex', 'w1'), ('conv1_bias_hex', 'b1'), ('conv2_kernel_hex', 'w2'), ('conv2_bias_hex', 'b2')):
    shutil.copy(f'../data/{src}.txt', f'{out}/{dst}.hex')
