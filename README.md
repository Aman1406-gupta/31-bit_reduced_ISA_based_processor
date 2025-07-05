# 31-bit Reduced Instruction Set Architecture

This project presents the design and implementation of **31-bit Reduced Instruction Set Architecture**, created as part of the CS-210 Computer Architecture course.

For a complete overview of the architecture, instruction formats, opcodes, and control signals, refer to:

- [`Reduced Isa.pdf`] – ISA specification, detailed design, pipeline diagrams
- [`Outputs For testbench for Reduced ISA.pdf`] – Outputs for testbench

## Features

- **Custom 31-bit Instruction Format**
  - Supports **27 core instructions** across R, I and J types.

- **5-stage pipeline**:  Instruction Fetch, Decode, Execute, Memory, Writeback
  
- **Hazard Resolution**:
    - **Data hazards**: Resolved using **forwarding techniques**
    - **Control hazards**: Handled using appropriate **branch resolution logic**

## Getting Started

You will need a VHDL simulation tool such as **Xilinx Vivado**.

1. Clone the repository or download the ZIP.
2. Set up Project:  
   - Add `31_bit_Reduced_ISA_based_processor.xpr` in Vivado.
   - Add the testbench files under the `simulation sources` group.
4. Run behavioral simulation

