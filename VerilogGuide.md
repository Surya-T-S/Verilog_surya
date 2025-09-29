# Verilog Design Guide

Build intuition for Verilog with concise explanations, proven patterns, and practical checklists. Use this guide as a quick reference while exploring the designs in this repository.

---

## 1. Mindset: Hardware, Not Software

| Concept | Verilog Perspective |
| --- | --- |
| Concurrency | All `always` blocks and continuous assignments run in parallel. |
| Time | Simulation advances in discrete steps by delays, events, or clock edges. |
| Hardware intent | Code describes gates and flip-flops; the synthesizer infers structures from your style. |
| Determinism | Unconnected or unassigned signals become `x` (unknown) and propagate. |

**Design flow in a nutshell**
1. Describe the circuit (`.v` module).
2. Create a verification environment (`_tb.v` testbench).
3. Compile & simulate (e.g., Icarus Verilog: `iverilog` + `vvp`).
4. Iterate until the waveform or printed results match intent.

---

## 2. Core Syntax at a Glance

### Module Skeleton

```verilog
module module_name #(
  parameter WIDTH = 8
)(
  input  wire             clk,
  input  wire [WIDTH-1:0] a,
  output reg  [WIDTH-1:0] y
);
  // declarations + logic
endmodule
```

**Key elements**
- **Ports**: `input`, `output`, `inout`; add bit widths like `[3:0]` for buses.
- **Nets vs. regs**: Use `wire` for connections driven by continuous assignments; use `reg` (or `logic` in SystemVerilog) for values assigned inside `always`/`initial` blocks.
- **Parameters**: Provide compile-time customization (`WIDTH`, timing constants, etc.). Prefer `localparam` for internal constants.

### Common Declarations

| Declaration | Purpose | Example |
| --- | --- | --- |
| `wire` | Represents combinational connections | `wire sum = a ^ b;` |
| `reg` | Holds state within procedural blocks | `reg [3:0] counter;` |
| `parameter` | Module-wide constant | `parameter DEPTH = 16;` |
| `localparam` | Internal constant | `localparam RESET = 4'b0000;` |
| `genvar` | Index for generate loops | `genvar i;` |

---

## 3. Procedural Building Blocks

### Always Blocks
- `always @(*)` → combinational logic; assign every output on every path.
- `always @(posedge clk or negedge rst_n)` → sequential logic; model flip-flops with reset behavior.

```verilog
// Combinational template
always @(*) begin
  y = '0;           // default assignment prevents inferred latches
  case (sel)
    2'b00: y = a;
    2'b01: y = b;
    2'b10: y = c;
  endcase
end

// Sequential template
always @(posedge clk) begin
  if (!rst_n)
    q <= '0;      // synchronous reset
  else
    q <= d;
end
```

### Blocking (`=`) vs. Non-blocking (`<=`)
- Use **non-blocking** (`<=`) for sequential logic to model real flip-flops.
- Use **blocking** (`=`) in purely combinational blocks to enforce ordered evaluation.
- Never mix `=` and `<=` on the same signal inside the same block.

### Sensitivity Lists
- `@(*)` ensures the simulator reacts to every RHS signal—ideal for combinational logic.
- Explicit lists (e.g., `@(posedge clk)`) model clock or event-driven logic.

---

## 4. Modeling Styles (Pick the Best Fit)

| Style | Quick Idea | Typical Usage |
| --- | --- | --- |
| **Dataflow** | Continuous `assign` statements | Simple gates, arithmetic expressions |
| **Behavioral** | `always` blocks with procedural code | FSMs, counters, pipelined logic |
| **Structural** | Instantiate primitives/modules | Gate-level netlists, layered designs |

```verilog
// Dataflow mux
assign y = sel ? b : a;

// Behavioral mux
always @(*) begin
  case (sel)
    1'b0: y = a;
    1'b1: y = b;
  endcase
end

// Structural mux
not  n0(sel_n, sel);
and  a0(w0, a, sel_n);
and  a1(w1, b, sel);
or   o0(y, w0, w1);
```

**Choosing a style**: Start with behavioral for clarity, fall back to dataflow for simple combinational logic, and use structural when wiring up reusable submodules.

---

## 5. Operators & Expressions

### Quick Reference

| Category | Operators | Notes |
| --- | --- | --- |
| Logical | `!`, `&&`, `||` | Result is 1-bit (0/1/`x`). |
| Bitwise | `~`, `&`, `|`, `^`, `~^` | Operate bit-by-bit on vectors. |
| Reduction | `&a`, `|a`, `^a` | Collapse a vector to 1 bit. |
| Arithmetic | `+`, `-`, `*`, `/`, `%` | Signedness matters; declare with `signed`. |
| Shift | `<<`, `>>`, `<<<`, `>>>` | Use arithmetic shifts (`<<<`, `>>>`) for signed data. |
| Concatenation | `{a, b}` | Combine signals; repeat with `{4{bit}}`. |
| Conditional | `condition ? a : b` | Single-line multiplexer. |

### Literals & Sizes
- Format: `width'baseValue` (e.g., `8'h3F`, `4'b1010`, `32'd255`).
- `'0` and `'1` fill the entire width with zeros or ones; `'x` and `'z` propagate unknown/high-impedance.
- Add `_` for readability: `16'hDEAD`.

---

## 6. Control Structures

```verilog
// Conditional
if (enable) begin
  y = a;
end else begin
  y = b;
end

// Case with default
case (opcode)
  3'b000: alu_out = a + b;
  3'b001: alu_out = a - b;
  default: alu_out = '0;
endcase

// For loop (synthesis-friendly when bounds are static)
integer i;
always @(*) begin
  sum = '0;
  for (i = 0; i < WIDTH; i = i + 1)
    sum = sum + data[i];
end
```

Tips
- Always include a `default` case to avoid inferred latches.
- Keep loop bounds constant for synthesizability.
- Prefer `casez`/`casex` sparingly; `x`/`z` matching can hide bugs.

---

## 7. Time & Simulation Control

| Construct | Meaning |
| --- | --- |
| `` `timescale 1ns/1ps `` | Declares simulation unit/precision. Place at top of files. |
| `#10` | Wait 10 time units. Combinational logic should avoid delays in synthesizable code. |
| `@(posedge clk)` | Block until next rising edge. |
| `$display`, `$monitor`, `$dumpfile`, `$dumpvars` | Print or record waveforms for debugging. |

Remember: explicit delays (`#`) rarely synthesize—reserve them for testbenches.

---

## 8. Building Great Testbenches

```verilog
`timescale 1ns/1ps

module module_tb;
  reg clk = 0;
  reg rst_n = 0;
  reg [3:0] a;
  wire [3:0] y;

  module_name dut(
    .clk  (clk),
    .rst_n(rst_n),
    .a    (a),
    .y    (y)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    $display("Starting test at %0t", $time);
    repeat (2) @(posedge clk);
    rst_n = 1;

    a = 4'h0; @(posedge clk);
    a = 4'hF; @(posedge clk);

    check_output(4'hF);
    $finish;
  end

  task check_output(input [3:0] expected);
    if (y !== expected) begin
      $error("Mismatch: expected %0h got %0h", expected, y);
    end
  endtask
endmodule
```

**Checklist for effective verification**
- Generate clocks and resets explicitly.
- Drive all DUT inputs; initialize regs to known values.
- Use tasks/functions to organize stimulus and self-checking.
- Print informative messages and dump waveforms for GTKWave analysis.

---

## 9. Debugging & Best Practices

1. **Reset strategy**: Decide between synchronous vs. asynchronous resets; keep it consistent.
2. **Default assignments**: Initialize combinational outputs to avoid latches and `x` propagation.
3. **One driver per signal**: Multiple procedural drivers on a `reg` cause conflicts.
4. **Version control waveforms**: Save `.vcd` files during tricky debugging sessions for later review.
5. **Modularize**: Break large designs into reusable submodules; document the interface above the module definition.
6. **Synthesis alignment**: Verify that constructs you use (loops, functions, casez) are supported by your target FPGA/ASIC flow.

---

## 10. Where to Go Next

- Study the example circuits in this repo under `Combinational_Circuits/` and `Boolean_Functions/`—each includes a testbench to mirror.
- Experiment with parameterized modules (e.g., variable-width multiplexers).
- Explore SystemVerilog enhancements (`logic`, `always_comb`, interfaces) once you're comfortable with classic Verilog.
- Practice reading synthesis reports to understand how code translates into actual hardware resources.

**Keep iterating**: Simulation + analysis + refinement is the core loop for mastering digital design with Verilog.
