## 8-Bit CPU Design (Verilog, ZedBoard FPGA)

## Overview
This project is an in-progress educational 8-bit CPU built entirely in Verilog.
It is being developed as a learning exercise to understand how a processor executes instructions through the fetch, decode, execute, and writeback stages of a basic, non-pipelined, RISC-style architecture.

The design targets the ZedBoard FPGA (Zynq-7000 XC7Z020) and is tested through simulation in Vivado using testbenches and waveform analysis.

The goal of this project is not yet to achieve full functionality, but rather to gain a hands-on understanding of digital logic design, datapath construction, and finite-state control.

---

## CPU Classification

### ISA:
- Custom 8-bit RISC ISA
- Fixed-width 16-bit instructions
- Load/store architecture
- Register-to-register ALU operations
- Simple opcode format
- No complex addressing modes

### Microarchitecture:
- Multicycle, FSM-controlled microarchitecture
- Each instruction completes in multiple cycles
- Typical CPI ≈ 3
- Single shared ALU (used for arithmetic, logic, and address generation)
- Non-pipelined, single-issue
- No forwarding or hazard logic required
- Hardwired control (no microcode ROM)
- Single clock domain
- Von Neumann style memory interface

### Datapath Style:
- Single ALU datapath
- Synchronous register file write, combinational read
- Operand multiplexers
- Sign extension unit
- Zero/Carry/Overflow flag logic

---

## Architecture Summary (In Progress)

| Component | Description |
|----------|-------------|
| Program Counter (PC.v) | Holds the address of the next instruction. Increments by 2 bytes each cycle (since instructions are 16 bits). |
| Instruction Register (Instruction_Register.v) | Fetches and assembles 16-bit instructions from an 8-bit-wide ROM. |
| Decoder (Decoder.v) | Splits the 16-bit instruction into opcode and register fields to route control signals to the FSM and datapath. |
| FSM (FSM.v) | Controls CPU operation across Fetch → Execute → Writeback stages. Generates control signals like RegWrite, MemRead, MemWrite, PCWrite, and ALUOp. |
| ALU (ALU.v) | Performs arithmetic and logic operations (ADD, SUB, NAND, MUL, shifts, comparisons). |
| Register File (Register_file.v) | Eight 8-bit general-purpose registers for operands and results. Supports synchronous writes and combinational reads. |
| Data Memory (Data_RAM.v) | 256 Bytes of main memory (256 × 8 bits). Used for load/store instructions. |
| Testbenches (RAM_TEST.v, etc.) | Verify module behavior and timing using simulated waveforms. |

Note:  
The CPU is still under active development.  
Current functionality includes instruction fetching, decoding, ALU operations, register file updates, and memory read/write testing.  
Upcoming work includes full top-level integration, branching logic, and memory-mapped I/O.

---

## Instruction Format

All instructions follow this unified format:

| op (4 bits) | rd (3 bits) | rs (3 bits) | rt / immediate / address (6 bits) |


R-Type Instructions (Register–Register)
---------------------------------------
Used for ALU operations (ADD, SUB, AND, OR, SLT, etc.).

Format:
| op[15:12] | rd[11:9] | rs[8:6] | rt[5:0] |

Notes:
- rt uses only the upper 3 bits (rt[5:3]).
- Lower 3 bits (rt[2:0]) are unused padding.

Fields:
- op  = operation code
- rd  = destination register
- rs  = first source register
- rt  = second source register (encoded in upper 3 bits)


I-Type Instructions (Immediate, Load, Store, Branch)
----------------------------------------------------
Used for ADDI, SUBI, SLL, SRA, LW, SW, BEQ, etc.

Format:
| op[15:12] | rd[11:9] | rs[8:6] | immediate[5:0] |

Fields:
- op         = operation code
- rd         = destination register
- rs         = source register
- immediate  = 6-bit signed or unsigned constant


J-Type Instructions (Jump)
--------------------------
Used for jump instructions.

Format:
| op[15:12] | address[11:0] |

---

## Supported Instructions

| **Category** | **Instruction** | **Example** | **Meaning** | **Comments** | **Format** | **Type** |
|---------------|----------------|--------------|--------------|---------------|------------|----------|
| **Arithmetic** | `add` | `add R1,R2,R3` | R1 = R2 + R3 | 3-register addition | Register to Register | R-Type |
|  | `addi` | `addi R1,R2,5` | R1 = R2 + 5 | Immediate addition | Immediate | I-Type |
|  | `sub` | `sub R1,R2,R3` | R1 = R2 - R3 | 3-register subtraction | Register to Register | R-Type |
|  | `subi` | `subi R1,R2,5` | R1 = R2 - 5 | Immediate subtraction | Immediate | I-Type |
|  | `slt` | `slt R1,R2,R3` | R1 = (R2 < R3) ? 1 : 0 | Set if less than | Register to Register | R-Type |
|  | `slti` | `slti R1,R2,5` | R1 = (R2 < 5) ? 1 : 0 | Immediate comparison | Immediate | I-Type |
| **Logical / Bitwise** | `bitAND` | `bitAND R1,R2,R3` | R1 = R2 & R3 | Logical AND | Register to Register | R-Type |
|  | `bitNAND` | `bitNAND R1,R2,R3` | R1 = ~(R2 & R3)` | Logical NAND | Register to Register | R-Type |
|  | `sll` | `sll R1,R2` | R1 = R2 << 1 | Shift left logical | Immediate | I-Type |
|  | `sra` | `sra R1,R2` | R1 = R2 >>> 1 | Shift right arithmetic | Immediate | I-Type |
| **Data Transfer** | `lb` | `lb R1,5(R2)` | R1 = Mem[R2 + 5] | Load byte from memory | Immediate | I-Type |
|  | `sb` | `sb R1,5(R2)` | Mem[R2 + 5] = R1 | Store byte to memory | Immediate | I-Type |
| **Branch / Control** | `beq` | `beq R1,R2,label` | if (R1 == R2) PC = label | Branch if equal | Immediate | I-Type |
|  | `bne` | `bne R1,R2,label` | if (R1 != R2) PC = label | Branch if not equal | Immediate | I-Type |
|  | `blt` | `blt R1,R2,label` | if (R1 < R2) PC = label | Branch if less than | Immediate | I-Type |
| **Jump** | `jump` | `jump label` | PC = label | Unconditional jump | Jump Type | J-Type |
|  | `HLT` | `HLT` | HLT | Terminates program | N/A | — |

---

## ISA Summary
- Instruction Width: 16 bits
- Data Width: 8 bits
- Registers: 8 general-purpose (R0–R7)
- Opcode Field: 4 bits (16 total operations)
- Addressing: Byte-addressable memory

---

## Tools Used
- Vivado 2025.2 – Synthesis, simulation, and testbench verification
- Git / GitHub – Version control and project documentation
- ZedBoard FPGA – FPGA used for testing and design verification

---

## Learning Objectives
- Understand how CPUs execute instructions at the hardware level
- Learn how to design and connect datapath components (PC, ALU, registers, RAM)
- Implement control flow through a finite-state machine
- Build foundational experience in digital systems and FPGA design

---

## Future Work
- Create top-level CPU datapath connecting all modules
- Implement Booths Encoding into the Wallace Tree Multiplier
- Possible floating point unit in the far future
- Document full multicycle microarchitecture state diagram and CPI behavior
