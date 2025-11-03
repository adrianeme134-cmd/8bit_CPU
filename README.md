## 8-Bit CPU Design (Verilog, BASYS3 FPGA)

## Overview
This project is an **in-progress educational 8-bit CPU** built entirely in Verilog.  
It is being developed as a learning exercise to understand how a processor executes instructions through the **fetch, decode, execute, and writeback** stages of a basic RISC-style architecture.  

The design targets the **BASYS3 FPGA (Xilinx Artix-7)** and is tested through simulation in **Vivado** using testbenches and waveform analysis.

The goal of this project is not yet to achieve full functionality, but rather to gain a hands-on understanding of **digital logic design**, **datapath construction**, and **finite-state control**.

---

## Architecture Summary (In Progress)

| Component | Description |
|------------|-------------|
| **Program Counter (PC.v)** | Holds the address of the next instruction. Increments by 2 bytes each cycle (since instructions are 16 bits). |
| **Instruction Register (Instruction_Register.v)** | Fetches and assembles 16-bit instructions from an 8-bit-wide ROM. |
| **Decoder (Decoder.v)** | Splits the 16-bit instruction into opcode and register fields to route control signals to the FSM and datapath. |
| **FSM (FSM.v)** | Controls CPU operation across Fetch → Execute → Writeback stages. Generates control signals like `RegWrite`, `MemRead`, `MemWrite`, `PCWrite`, and `ALUOp`. |
| **ALU (ALU.v)** | Performs arithmetic and logic operations (ADD, SUB, AND, OR, XOR, XNOR, shifts, rotates, comparisons). |
| **Register File (Register_file.v)** | Eight 8-bit general-purpose registers for operands and results. Supports synchronous writes and combinational reads. |
| **Data Memory (Data_RAM.v)** | 1 KB of main memory (1024 × 8 bits). Used for load/store instructions. |
| **Testbenches (RAM_TEST.v, etc.)** | Verify module behavior and timing using simulated waveforms. |

>  **Note:**  
> The CPU is still under active development.  
> Current functionality includes instruction fetching, decoding, ALU operations, register file updates, and memory read/write testing.  
> Upcoming work includes full top-level integration, branching logic, and memory-mapped I/O.

---

##  Instruction Format

Each instruction is 16 bits (2 bytes) wide and stored in ROM as two consecutive bytes:

| 15–12 | 11–9 | 8–6 | 5–3 | 2–0 |
|--------|-------|------|------|------|
| Opcode | Dest | Reg1 | Reg2 | Flags/unused |

- **Opcode (4 bits):** Operation type (ADD, SUB, LD, ST, etc.)  
- **Destination / Source Registers (3 bits each):** Identify which registers participate in the instruction  
- **Flags (3 bits):** Reserved for future condition codes  

---

## Supported Instructions

More to be added soon!

| Mnemonic | Opcode | Description |
|-----------|:------:|-------------|
| `NOP` | `0000` | No operation |
| `ADD` | `0001` | A + B → Dest |
| `SUB` | `0010` | A – B → Dest |
| `ORR` | `0011` | Logical OR |
| `XORR` | `0100` | Logical XOR |
| `LD`  | `0101` | Load from memory |
| `ST`  | `0110` | Store to memory |
| `JMP` | `0111` | Jump to address |
| `BEQ` | `1000` | Branch if equal |
| `LDI` | `1001` | Load immediate |
| `NOTI`| `1010` | Bitwise NOT |
| `HLT` | `1011` | Halt execution |

---

##  Tools Used

- **Vivado 2017.4** – Synthesis, simulation, and testbench verification   
- **Git / GitHub** – Version control and project documentation  

---

## Learning Objectives

- Understand how CPUs execute instructions at the hardware level  
- Learn how to design and connect datapath components (PC, ALU, registers, RAM)  
- Implement control flow through a finite-state machine  
- Build foundational experience in digital systems and FPGA design  

---

## Future Work

- Create top-level CPU integration connecting all modules  
- Implement branching and jump logic  
- Add immediate value and I/O instructions  
- Extend instruction set

