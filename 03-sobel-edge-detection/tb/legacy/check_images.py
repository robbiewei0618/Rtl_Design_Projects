#!/usr/bin/env python3
"""check_images.py - compare the course testbench's output images with a
bit-exact Python model of the edge detector (exit 1 on any difference).

Model: Y = R/4 + R/32 + G/2 + G/16 + (B/8 - B/128) (integer shifts) on the
zero-padded image; Gx = (R2-R0) + 2(R5-R3) + (R8-R6), Gy = (R0-R6) +
2(R1-R7) + (R2-R8) over each 3x3 window; output 255 if G > 130 else 0.
With --write it also writes the model's images to golden/.
"""
import sys

TH = 130

def load(p):
    b = open(p, 'rb').read()
    off = int.from_bytes(b[10:14], 'little'); w = int.from_bytes(b[18:22], 'little'); h = int.from_bytes(b[22:26], 'little')
    return b, off, w, h

def model(path):
    b, off, W, H = load(path)
    Y = [[0] * (W + 2) for _ in range(H + 2)]
    for h in range(H):
        for w in range(W):
            B, G, R = b[off + 3 * (h * W + w): off + 3 * (h * W + w) + 3]
            Y[h + 1][w + 1] = (R >> 2) + (R >> 5) + (G >> 1) + (G >> 4) + ((B >> 3) - (B >> 7))
    ox, oy = [], []
    for h in range(H):
        for w in range(W):
            r = [Y[h + i][w + j] for i in range(3) for j in range(3)]
            gx = (r[2] - r[0]) + 2 * (r[5] - r[3]) + (r[8] - r[6])
            gy = (r[0] - r[6]) + 2 * (r[1] - r[7]) + (r[2] - r[8])
            ox.append(255 if gx > TH else 0); oy.append(255 if gy > TH else 0)
    return b, off, ox, oy

def main():
    b, off, ox, oy = model('data/cat.bmp')
    if '--write' in sys.argv:
        for name, o in (('x', ox), ('y', oy)):
            img = bytearray(b[:off]) + bytes(v for p in o for v in (p, p, p))
            open(f'golden/cat_after_sobel_{name}.bmp', 'wb').write(img)
    bad = 0
    for name, o in (('x', ox), ('y', oy)):
        a, aoff, _, _ = load(f'cat_after_sobel_{name}.bmp')
        px = a[aoff::3]
        d = sum(1 for i in range(len(o)) if i >= len(px) or px[i] != o[i]) + abs(len(px) - len(o))
        print(f'cat_after_sobel_{name}.bmp: {d} of {len(o)} pixels differ from the model')
        bad += d
    print('ALL PIXELS MATCH' if bad == 0 else 'IMAGE MISMATCH')
    sys.exit(1 if bad else 0)

if __name__ == '__main__':
    main()
