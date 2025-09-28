# Verilog Digital Circuit Implementations

This repository contains various digital circuit implementations in Verilog, organized by circuit type and functionality.

## Project Structure

```
Verilog_surya/
├── Combinational_Circuits/
│   ├── Multiplexers/          # MUX implementations
│   │   ├── mux41_logic.v     # 4:1 MUX using logic equations
│   │   ├── mux41_cond.v      # 4:1 MUX using conditional operator
│   │   └── testbenches/      # Individual testbenches
│   │
│   ├── Decoders/             # Decoder implementations
│   │   ├── dec24_logic.v     # 2:4 decoder using logic
│   │   ├── dec24_cond.v      # 2:4 decoder using conditional
│   │   └── testbenches/      # Individual testbenches
│   │
│   ├── Encoders/             # Encoder implementations
│   │   ├── enc42_logic.v     # 4:2 priority encoder using logic
│   │   ├── enc42_cond.v      # 4:2 priority encoder using conditional
│   │   └── testbenches/      # Individual testbenches
│   │
│   └── Display_Decoders/     # Display decoder implementations
│       ├── seg7_logic.v      # 7-segment using logic
│       ├── seg7_cond.v       # 7-segment using conditional
│       └── testbenches/      # Individual testbenches
│
└── Boolean_Functions/         # Boolean function implementations
    ├── Simple_Functions/     # Simple boolean expressions
    ├── Complex_Functions/    # Complex boolean expressions
    └── testbenches/         # Individual testbenches

## File Naming Convention

- *_logic.v: Implementation using direct logic equations
- *_cond.v: Implementation using conditional operators
- *_tb.v: Testbench files for corresponding modules

## Testing

Each module has its own dedicated testbench that:
1. Tests all possible input combinations
2. Verifies correct output behavior
3. Provides clear, formatted output for easy verification

## Implementation Styles

Each circuit is implemented in two styles:
1. Logic Implementation: Using direct boolean equations
2. Conditional Implementation: Using conditional operators

## How to Run Tests

To run individual testbenches:
```bash
# Navigate to the specific directory
cd Combinational_Circuits/[Circuit_Type]

# Compile and run specific testbench
iverilog -o sim.out [module_name]_tb.v [module_name].v
vvp sim.out
```
