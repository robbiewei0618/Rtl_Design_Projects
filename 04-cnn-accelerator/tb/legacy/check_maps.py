#!/usr/bin/env python3
"""check_maps.py S - compare out_layer{1,2}/cat_*.pgm with a NumPy model.

Model (same integer arithmetic as the engine): zero-padded 3x3 convolution,
weights [out][in][ky][kx]; conv1_1 = sat8(ReLU(sum + bias) >> 4) on the RGB
crop; conv1_2 = sat8(ReLU(sum + bias) >> 7) on the conv1_1 maps. Exit 1 on
any difference."""
import sys
import numpy as np

S = int(sys.argv[1]) if len(sys.argv) > 1 else 224

def hexfile(p):
    v = np.array([int(l, 16) for l in open(p) if l.strip()], dtype=np.int64)
    return np.where(v >= 0x8000, v - 0x10000, v)

def conv(x, w, b, shift):            # x: [C,S,S], w: [O,C,3,3]
    C = x.shape[0]
    xp = np.zeros((C, S + 2, S + 2), dtype=np.int64); xp[:, 1:-1, 1:-1] = x
    acc = np.zeros((w.shape[0], S, S), dtype=np.int64)
    for ky in range(3):
        for kx in range(3):
            acc += np.einsum('oc,chw->ohw', w[:, :, ky, kx], xp[:, ky:ky + S, kx:kx + S])
    pre = acc + b[:, None, None]
    return np.where(pre < 0, 0, np.minimum(pre >> shift, 255))

b = open('../../data/cat224.bmp', 'rb').read()
off = int.from_bytes(b[10:14], 'little')
px = np.frombuffer(b[off:off + 224 * 224 * 3], dtype=np.uint8).reshape(224, 224, 3)[:S, :S]
rgb = np.stack([px[:, :, 2], px[:, :, 1], px[:, :, 0]]).astype(np.int64)
w1 = hexfile('../../data/conv1_kernel_hex.txt').reshape(64, 3, 3, 3); b1 = hexfile('../../data/conv1_bias_hex.txt')
w2 = hexfile('../../data/conv2_kernel_hex.txt').reshape(64, 64, 3, 3); b2 = hexfile('../../data/conv2_bias_hex.txt')
l1 = conv(rgb, w1, b1, 4)
l2 = conv(l1, w2, b2, 7)

bad = 0
for layer, ref in ((1, l1), (2, l2)):
    for c in range(64):
        vals = open(f'out_layer{layer}/cat_{c}.pgm').read().split()[4:]
        got = np.array([int(v) if v.isdigit() else -1 for v in vals]).reshape(S, S)
        bad += int((got != ref[c]).sum())
print(f'{S}x{S}: {bad} of {2 * 64 * S * S} feature-map pixels differ from the NumPy model')
print('ALL FEATURE MAPS MATCH' if bad == 0 else 'FEATURE MAP MISMATCH')
sys.exit(1 if bad else 0)
