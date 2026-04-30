# VGG-16 CNN Accelerator in Verilog

This project implements a Verilog-based CNN hardware accelerator for the first two convolution layers of the VGG-16 neural network. The design focuses on accelerating 3×3 convolution operations using line buffers, processing elements (PEs), adder-tree accumulation, partial-sum accumulation, bias addition, and ReLU activation.

The goal of this project is to demonstrate how convolutional neural network computation can be mapped onto an RTL datapath with configurable hardware parallelism.

---

## Project Overview

The target workload is the first two convolution layers of VGG-16.

| Layer | Input Channels | Output Channels | Feature Map Size | Kernel Size | Stride |
|------|---------------:|----------------:|-----------------:|------------:|-------:|
| Conv1 | 3 | 64 | 224 × 224 | 3 × 3 | 1 |
| Conv2 | 64 | 64 | 224 × 224 | 3 × 3 | 1 |

The first convolution layer takes an RGB image as input and generates 64 output feature maps.  
The second convolution layer takes the 64 feature maps from Conv1 and generates another 64 output feature maps.

---

## Architecture

The overall accelerator dataflow is:

```text
Input Feature Map
→ Padding
→ Line Buffer
→ Processing Element
→ Adder Tree
→ Partial Sum Accumulation
→ Bias Addition
→ ReLU
→ Output Feature Map



