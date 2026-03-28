# Digital Hardware Design Projects

A portfolio of Verilog RTL design projects covering arithmetic circuit design, pipelined datapaths, CPU pipeline partitioning, image-processing hardware, and CNN accelerator architecture exploration.

This repository contains a collection of graduate-level digital hardware design projects implemented in Verilog HDL. The projects focus on practical RTL development, hardware architecture design, simulation and verification, synthesis-aware implementation, and design trade-off analysis in terms of area, delay, throughput, and power.

The goal of this repository is to demonstrate hands-on experience in digital circuit design and hardware-oriented problem solving across multiple abstraction levels, from basic combinational logic to pipelined arithmetic datapaths, CPU pipeline partitioning, image-processing accelerators, and CNN hardware design.

---

## Repository Overview

This repository currently includes the following project categories:

1. **Adder design using different Verilog modeling styles**
2. **Pipelined add/subtract multiplier with clock gating**
3. **THUMB CPU 4-stage pipeline partitioning**
4. **Sobel edge detection hardware**
5. **CNN accelerator for VGG-16**

These projects collectively demonstrate experience in:

- Verilog RTL design
- structural, dataflow, and behavioral modeling
- pipelined architecture design
- arithmetic datapath implementation
- clock gating and power-aware hardware design
- CPU pipeline partitioning
- image-processing hardware
- CNN accelerator architecture
- RTL simulation and gate-level verification
- synthesis and implementation trade-off analysis

---

## Project List

---

### 1. 32-bit Adder Design with Structural, Dataflow, and Behavioral Modeling

This project implements a 32-bit adder using three different Verilog modeling styles:

- **Structural modeling**
- **Dataflow modeling**
- **Behavioral modeling**

In addition to the basic combinational versions, registered-output versions of the adders were also implemented for comparison under synthesis constraints.

#### Key Design Tasks
- Designed a **1-bit full adder** using gate-level primitives
- Built a **32-bit ripple-carry adder**
- Implemented the same logic using different HDL abstraction styles
- Added **output registers** to analyze sequential versions
- Performed **RTL simulation** and **gate-level simulation**
- Compared synthesis results under:
  - delay-optimized constraints
  - area-optimized constraints
  - balanced constraints

#### Skills Demonstrated
- Understanding of Verilog abstraction levels
- Combinational vs. sequential circuit design
- Ripple-carry adder construction
- Synthesis trade-off analysis
- Area / delay / power comparison

---

### 2. Pipelined Add/Subtract Multiplier with Clock Gating

This project implements the arithmetic datapath:

`d = (a +/- b) * c`

Three implementations were developed:

- **Non-pipelined version**
- **2-stage pipelined version**
- **Clock-gated pipelined version**

The design emphasizes datapath partitioning, latency/throughput trade-offs, and power reduction through clock gating.

#### Key Design Tasks
- Partitioned the datapath into pipeline stages
- Designed the arithmetic flow for addition/subtraction followed by multiplication
- Implemented **clock gating** to reduce unnecessary switching activity
- Verified correctness through **RTL simulation**
- Performed **gate-level simulation**
- Conducted **power analysis** using synthesis/timing tools
- Compared performance across non-pipelined and pipelined implementations

#### Skills Demonstrated
- Pipelined datapath design
- Throughput vs. latency analysis
- Clock-gating design
- Dynamic power reduction
- Post-synthesis verification
- Arithmetic hardware optimization

---

### 3. THUMB CPU 4-Stage Pipeline Partitioning

This project restructures a THUMB CPU into four pipeline stages:

- **IF** (Instruction Fetch)
- **ID** (Instruction Decode)
- **EX** (Execute)
- **WB** (Write Back)

The project focuses on modularizing the CPU datapath, analyzing timing behavior across stages, and observing implementation results under synthesis and physical-design-oriented flow.

#### Key Design Tasks
- Partitioned an existing CPU design into four modules
- Organized RTL according to pipeline-stage functionality
- Performed **RTL simulation**
- Conducted **gate-level verification**
- Compared **area, delay, and power**
- Evaluated timing behavior across IF / ID / EX / WB
- Observed implementation results after synthesis / APR-oriented flow

#### Skills Demonstrated
- CPU pipeline architecture
- Stage partitioning
- Modular RTL design
- Pipeline-oriented system organization
- Timing analysis across pipeline stages
- Digital design flow awareness

---

### 4. Sobel Edge Detection Hardware

This project implements a Sobel edge detection pipeline for BMP images.

The system includes both hardware and testbench-side functionality. The image is read in through the testbench, processed through hardware modules, and written back after edge detection.

#### Processing Flow
- Read BMP image file in testbench
- Apply zero padding in testbench
- Convert RGB to grayscale in hardware
- Build line buffer architecture in hardware
- Perform Sobel convolution in hardware
- Apply thresholding to generate binary output
- Write processed image back to BMP format in testbench

#### Key Design Tasks
- Designed grayscale transformation hardware
- Implemented line-buffer-based streaming architecture
- Built 3x3 convolution logic for Sobel operators
- Applied threshold logic for edge map generation
- Verified the design using RTL and gate-level simulation

#### Skills Demonstrated
- Image-processing hardware design
- Streaming datapath implementation
- Line buffer architecture
- Convolution engine design
- RTL + testbench co-design
- Hardware acceleration for vision algorithms

---

### 5. CNN Accelerator for VGG-16

This project explores a hardware accelerator for the first two convolution layers of **VGG-16**.

The design focuses on efficient convolution hardware architecture using line buffers, processing elements (PEs), and configurable parallelism across multiple dimensions.

#### Architecture Features
- **Processing Elements (PEs)** with multiply-adder-tree structure
- **Line buffers** for input feature map reuse
- Configurable parallelism in:
  - **ICP** (Input Channel Parallelism)
  - **OCP** (Output Channel Parallelism)
  - **KWP** (Kernel Window Parallelism)

#### Key Design Tasks
- Designed 3D convolution hardware architecture
- Analyzed execution cycles and memory access behavior
- Built PE-based multiply-accumulate structures
- Studied hardware parallelism trade-offs
- Implemented feature-map generation for VGG-16 early layers

#### Skills Demonstrated
- CNN accelerator design
- PE architecture
- Line-buffer-based dataflow
- Memory reuse optimization
- Parallel hardware architecture
- Area / performance trade-off exploration

---

## Technical Topics Covered

This repository reflects practical experience in the following areas:

### RTL Design
- Verilog HDL
- structural modeling
- dataflow modeling
- behavioral modeling
- modular hardware design

### Arithmetic Hardware
- adder design
- multiplier datapath design
- fused arithmetic flow
- fixed-point and arithmetic pipeline implementation

### Architecture
- pipeline partitioning
- datapath decomposition
- throughput / latency trade-offs
- CPU stage organization
- accelerator architecture design

### Power / Performance Optimization
- clock gating
- area / delay / power trade-off analysis
- architecture-level optimization
- synthesis-aware hardware design

### Hardware Acceleration
- Sobel image-processing hardware
- convolution engine design
- line buffer architecture
- CNN accelerator design

---

## Design Flow and Methodology

Across these projects, the design flow generally includes:

1. **Architecture definition**
2. **RTL implementation in Verilog**
3. **Testbench development**
4. **RTL simulation**
5. **Gate-level verification**
6. **Synthesis / implementation-oriented analysis**
7. **Comparison of area, delay, power, latency, and throughput**

This workflow reflects a hardware engineering mindset that emphasizes both functional correctness and implementation feasibility.

---

## Tools Used

The projects involve the use of common digital design and verification tools, including:

- **Verilog HDL**
- **VCS simulation**
- **waveform-based debugging**
- **Synopsys Design Compiler**
- **PrimeTime**
- **FPGA / implementation flow tools**

---

## Repository Structure

Each subdirectory corresponds to one project or design topic. Depending on the project, the folder may include:

- RTL source code
- testbenches
- simulation scripts
- reports
- implementation notes

The repository is intended as a project portfolio rather than a production-ready release, so some directories may preserve coursework-style organization while still documenting architecture and implementation clearly.

---

## Author

**Fan-Sheng Wei**  
Graduate Student, Department of Computer Science and Engineering  
National Sun Yat-sen University

---

## Notes

This repository is intended to present practical digital hardware design experience developed through coursework and implementation projects. The focus is not only on writing Verilog code, but also on understanding how hardware architectures behave under realistic design constraints and how to evaluate implementation trade-offs systematically.
