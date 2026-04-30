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



The main hardware modules include:

Line Buffer
Stores input feature map rows.
Generates 3×3 sliding windows for convolution.
Reduces repeated memory access by reusing overlapping input pixels.
Processing Element (PE)
Performs the core 3×3 convolution computation.
Multiplies input window values with kernel weights.
Produces partial convolution results.
Adder Tree
Accumulates the 9 multiplication results from a 3×3 kernel window.
Reduces the accumulation depth compared with serial addition.
Partial Sum Accumulation
Accumulates convolution results across multiple input channels.
Required when the number of input channels is larger than the input-channel parallelism.
Bias Addition
Adds the corresponding bias value for each output channel.
ReLU Activation
Applies the activation function ReLU(x) = max(0, x).
Parallelism Design

The accelerator uses three parallelism parameters:

Parameter	Meaning	Description
ICP	Input Channel Parallelism	Number of input channels processed in parallel
OCP	Output Channel Parallelism	Number of output channels computed in parallel
KWP	Kernel Window Parallelism	Number of kernel values processed in parallel

In this implementation:

ICP = 4
OCP = 4
KWP = 9

Since the convolution kernel size is 3×3, KWP = 9 allows all 9 kernel multiplications to be performed in parallel.

The total number of multipliers is:

ICP × OCP × KWP = 4 × 4 × 9 = 144

This parallelism reduces execution cycles, but it also increases hardware cost, including multiplier count, adder logic, area, power, and routing complexity.

Conv1 Execution

The first convolution layer has 3 input channels and 64 output channels.

For each output pixel and each output channel:

3 × 3 × 3 = 27 MAC operations

Although the hardware supports ICP = 4, Conv1 only has 3 input channels, so one input-channel lane is unused in this layer.

With OCP = 4, the accelerator computes 4 output channels in parallel. Since Conv1 has 64 output channels, the output channels are processed in 16 groups.

64 / 4 = 16 output-channel groups
Conv2 Execution

The second convolution layer has 64 input channels and 64 output channels.

For each output pixel and each output channel:

3 × 3 × 64 = 576 MAC operations

Since ICP = 4, the accelerator processes 4 input channels at a time. Therefore, Conv2 requires 16 partial-sum accumulation steps for each output channel group.

64 / 4 = 16 partial-sum accumulation steps

With OCP = 4, the accelerator computes 4 output channels in parallel.

Padding

The input feature map size is 224×224. Since the convolution kernel size is 3×3 and the stride is 1, zero-padding is applied to preserve the output feature map size.

Input size before padding: 224 × 224
Input size after padding:  226 × 226
Output size:               224 × 224

Padding is handled in the testbench before the data is sent to the hardware convolution datapath.

Verification Methodology

The testbench performs the following tasks:

Reads the input image data.
Reads the convolution weights and biases.
Applies zero-padding.
Sends input feature maps, weights, and biases to the RTL modules.
Captures the convolution outputs.
Applies output scaling and bit extraction for image generation.
Writes the Conv1 and Conv2 output feature maps as image files.

The generated feature maps are used to visually verify whether the convolution results preserve meaningful edge, texture, and object-shape information from the original image.

Output Feature Maps
Conv1 Output Feature Maps

The first convolution layer generates 64 output feature maps. These feature maps mainly capture low-level image features such as edges, textures, contrast changes, and local patterns.

Conv2 Output Feature Maps

The second convolution layer also generates 64 output feature maps. Compared with Conv1, the Conv2 outputs contain more transformed feature responses because they are computed from the 64 feature maps produced by the first layer.

Synthesis and Timing Analysis

The design was synthesized to obtain area and critical path information.

The critical path is mainly located in the convolution computation datapath, especially through the multiply-add and adder-tree accumulation logic.

If timing optimization is required, possible improvements include:

Inserting pipeline registers after multipliers.
Pipelining intermediate levels of the adder tree.
Registering partial-sum accumulation stages.
Reducing ICP or OCP to lower combinational complexity.
Balancing the adder-tree structure.
Key Design Trade-Offs

This project highlights the trade-off between performance and hardware cost.

Increasing ICP and OCP improves throughput and reduces execution cycles, but also increases:

Multiplier count
Adder logic
Line buffer resources
Area
Power consumption
Routing complexity

Therefore, the accelerator design must balance parallelism, timing, area, and memory-access efficiency.

What I Learned

Through this project, I learned how CNN convolution can be mapped from a software-level operation to a hardware RTL datapath.

Key takeaways include:

Designing a convolution datapath using Verilog.
Using line buffers to reduce repeated memory accesses.
Exploiting output-channel parallelism with PE groups.
Using partial-sum accumulation for multi-channel convolution.
Understanding how ICP, OCP, and KWP affect performance and hardware cost.
Verifying CNN hardware output through generated feature maps.
Analyzing how arithmetic-heavy datapaths affect area and critical path.
Repository Structure
CNN accelerator/
├── README.md
├── layer1.png
├── layer2.png
├── data/
└── rtl/
Conclusion

This project implements a Verilog-based CNN accelerator for the first two convolution layers of VGG-16. The design uses line buffers, PE groups, adder-tree accumulation, partial-sum accumulation, bias addition, and ReLU activation to perform 3×3 convolution efficiently.

By using ICP = 4, OCP = 4, and KWP = 9, the accelerator exploits both input-channel and output-channel parallelism. This project demonstrates the fundamental design considerations of CNN hardware acceleration, including data reuse, parallel computation, memory access reduction, timing, area, and verification.
