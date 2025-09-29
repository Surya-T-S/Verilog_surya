# Verilog Digital Circuit Implementations

A compact reference of combinational building blocks and Boolean functions written in Verilog, each paired with a self-checking testbench.

## Highlights
- Logic and conditional implementations for multiplexers, decoders, encoders, and seven-segment drivers.
- Boolean function examples organized from simple to complex expressions.
- Ready-to-run simulation outputs generated with Icarus Verilog.

## Quick Start
1. Pick a module and its testbench (for example `Combinational_Circuits/Multiplexers/mux41_logic.v` and `mux41_logic_tb.v`).
2. Compile and simulate:
   ```bash
   iverilog -o sim.out mux41_logic_tb.v mux41_logic.v
   vvp sim.out
   ```
3. Inspect the terminal output or open the waveform (`.vcd`) file if generated.

## Repository Layout

| Directory | Description |
| --- | --- |
| `Combinational_Circuits/` | Multiplexers, decoders, encoders, and display drivers, each with testbenches and sample outputs. |
| `Boolean_Functions/` | Simple and complex Boolean expressions with verification harnesses. |

For a deeper walkthrough of language concepts and best practices, read `VerilogGuide.md`.
