# Simple 8-Bit CPU

A custom 8-bit RISC-style CPU designed entirely in Verilog HDL and synthesized using **Cadence Genus** and **Cadence Innovus**. The processor uses an multi-cycle accumulator-based architecture with a 16-bit instruction word and supports arithmetic, logic, memory, branch, and interrupt service routine (ISR) operations.

---

## Architecture Overview

| Parameter           | Value                        |
|---------------------|------------------------------|
| Data Width          | 8-bit                        |
| Instruction Width   | 16-bit                       |
| Address Width       | 8-bit (PC), 4-bit (IM index) |
| Register File       | 8 × 8-bit GPRs (R0–R7)       |
| Accumulator         | 8-bit dedicated ACC register |
| Instruction Memory  | 16 × 16-bit (hardcoded ROM)  |
| Architecture Type   | Accumulator-based RISC       |
| Pipeline            | Multi-cycle                  |

---

## Block Diagram

```
         ┌──────────────────────────────────────────────┐                                        
         │                simple_8bit_cpu               │
         │                                              │
  CLK ──►│  ┌─────┐    ┌────┐    ┌─────────────────┐    │
  RST ──►│  │ PCU │───►│ IM │───►│ IR (Instr. Reg) │   │
         │  └──┬──┘    └────┘    └────────┬────────┘    │
         │     │                          │             │
         │     │                 ┌────────▼────────┐    │ 
         │     │                 │   Control Unit  │    │
         │     │                 └──┬──────┬───────┘    │
         │     │                    │      │            │
         │  ┌──▼──────────┐  ┌──────▼──┐  │            │
         │  │ Register    │  │ALU+Accum│  │             │
         │  │ File (R0-R7)│◄─┤         │◄─┘            │
         │  └─────────────┘  └─────────┘                │
         └──────────────────────────────────────────────┘
```

---

## Instruction Set Architecture (ISA)

### Instruction Format (16-bit)

```
[ 15:12 ]  [ 11:9 ]  [ 8:3 ]   [ 2:0  ]
  OPCODE    DEST_REG   IMM/--   SRC_REG
```

### Instruction Table

| Opcode | Mnemonic   | Operation                              |
|--------|------------|----------------------------------------|
| 0001   | LOAD IMM   | ACC ← Immediate (instr[7:0])           |
| 0010   | MOV        | R[dest] ← ACC                          |
| 0011   | AND        | ACC ← ACC & R[src]                     |
| 0100   | ADD        | ACC ← ACC + R[src]                     |
| 0101   | SUB        | ACC ← ACC - R[src]                     |
| 1011   | OR         | ACC ← ACC \| R[src]                    |
| 1100   | NOP/STALL  | PC hold (pc_write_en = 0)              |
| 1110   | JMP        | PC ← branch_addr (immediate)           |
| 1111   | ISR CALL   | stackPC ← PC; PC ← 0x10               |

### ALU Operations

| alu_op | Operation               |
|--------|-------------------------|
| 000    | Load Immediate → ACC    |
| 001    | ACC + R[src]            |
| 010    | ACC - R[src]            |
| 011    | ACC & R[src]            |
| 100    | ACC \| R[src]           |
| 101    | ~ACC (bitwise NOT)      |

---

## Module Descriptions

| File                | Module                  | Description                                                  |
|---------------------|-------------------------|--------------------------------------------------------------|
| `Top.v`             | `simple_8bit_cpu`       | Top-level integration of all submodules                      |
| `CU.v`              | `control_unit`          | Decodes 16-bit instruction and generates all control signals |
| `CU.v`              | `instruction_register`  | Pipeline register that latches fetched instruction           |
| `ALU_accu.v`        | `alu_accumulator`       | ALU with integrated accumulator register                     |
| `Program_counter.v` | `program_control_unit`  | PC with sequential, branch, ISR call, and ISR return modes   |
| `IM.v`              | `instruction_memory`    | 16-entry hardcoded ROM (16-bit instructions)                 |
| `register_file.v`   | `register_file`         | 8 × 8-bit synchronous register file; R7 mapped to output    |

---

## PC Modes

The `program_control_unit` supports 4 modes via `pc_sel[1:0]`:

| pc_sel | Mode          | Behaviour                        |
|--------|---------------|----------------------------------|
| 00     | Sequential    | PC ← PC + 1                      |
| 01     | Branch        | PC ← branch_addr (from immediate)|
| 10     | ISR Call      | stackPC ← PC; PC ← 0x10         |
| 11     | ISR Return    | PC ← stackPC                     |

---

## Synthesis Results

> Synthesized using **Cadence Genus 17.22** | Technology: `slow` library | Date: May 20, 2025

### Timing

| Parameter         | Value     |
|-------------------|-----------|
| Clock Period      | 2000 ps   |
| Critical Path     | 1407 ps   |
| Slack             | **399 ps (MET)** |
| Setup Uncertainty | 10 ps     |

### Area

| Instance         | Module                  | Cell Count | Total Area (μm²) |
|------------------|-------------------------|------------|-----------------|
| `simple_8bit_cpu`| Top                     | 90         | 867.407         |
| `IM`             | instruction_memory      | 17         | 161.220         |
| `PCU`            | program_control_unit    | 10         | 112.778         |
| `IR`             | instruction_register    | 7          | 111.264         |
| `CU`             | control_unit            | 7          | 26.491          |

| Cell Type       | Instances | Area (μm²) | % of Total |
|-----------------|-----------|------------|------------|
| Sequential      | 34        | 619.144    | 71.4%      |
| Logic           | 44        | 221.015    | 25.5%      |
| Inverter        | 12        | 27.248     | 3.1%       |

### Power

| Instance          | Leakage (nW) | Dynamic (nW) | Total (nW)  |
|-------------------|-------------|-------------|-------------|
| `simple_8bit_cpu` | 4955.218    | 449101.154  | 454056.372  |
| `IM`              | 921.927     | 60532.964   | 61454.891   |
| `IR`              | 685.454     | 59907.528   | 60592.983   |
| `PCU`             | 597.619     | 49260.444   | 49858.063   |
| `CU`              | 115.645     | 5694.122    | 5809.767    |

---

## Directory Structure

```
simple_8bit_cpu/
├── ALU_accu.v           # ALU + Accumulator
├── CU.v                 # Control Unit + Instruction Register
├── IM.v                 # Instruction Memory (ROM)
├── Program_counter.v    # Program Counter with ISR support
├── register_file.v      # 8×8 Register File
├── Top.v                # Top-level integration
├── tb.v                 # Testbench
├── constraints_top.sdc  # Timing constraints
├── processor_sdc.sdc    # Processor-level SDC
├── processor_netlist.v  # Post-synthesis netlist
└── README.md
```

---

## Toolchain

| Tool              | Purpose                        |
|-------------------|--------------------------------|
| Verilog HDL       | RTL Design                     |
| Cadence nclaunch  | Simulation & functional verify |
| Cadence Genus     | Logic Synthesis                |
| Cadence Innovus   | Place & Route                  |

---

## Author

**ANIRUDHA JAYPARAKASH** 

**THE NATIONAL INSTITUTE OF ENGINEERING, MYSURU**
