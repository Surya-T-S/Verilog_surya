//==============================================================================
// Module: jk_ff
// Description: Synchronous JK flip-flop with active-high reset
//
// The JK flip-flop is a versatile sequential element that extends the SR
// flip-flop by adding a toggle mode. It's commonly used in counters,
// frequency dividers, and state machines.
//
// Parameters:
//   - None
//
// Ports:
//   - clk    : Clock input (rising edge triggered)
//   - reset  : Synchronous reset (active-high, overrides j and k)
//   - j      : J input (set/toggle control)
//   - k      : K input (reset/toggle control)
//   - q      : Output state
//   - q_bar  : Complementary output (inverse of q)
//
// Behavior:
//   - On reset: q = 0
//   - j=0, k=0: q holds previous value
//   - j=0, k=1: q = 0 (reset)
//   - j=1, k=0: q = 1 (set)
//   - j=1, k=1: q toggles (most distinctive feature)
//
// Truth Table:
//   | reset | j | k | q(next) | Operation |
//   |-------|---|---|---------|-----------|
//   |   1   | x | x |    0    | Reset     |
//   |   0   | 0 | 0 |    q    | Hold      |
//   |   0   | 0 | 1 |    0    | Reset     |
//   |   0   | 1 | 0 |    1    | Set       |
//   |   0   | 1 | 1 |   ~q    | Toggle    |
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

module jk_ff (
    input  wire clk,      // Clock signal
    input  wire reset,    // Synchronous reset (active-high)
    input  wire j,        // J input
    input  wire k,        // K input
    output reg  q,        // Registered output
    output wire q_bar     // Complementary output
);

    // Continuous assignment for complementary output
    assign q_bar = ~q;

    // Sequential logic: JK behavior on rising clock edge
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;              // Reset state overrides all
        end else begin
            case ({j, k})
                2'b10: q <= 1'b1;   // Set operation
                2'b01: q <= 1'b0;   // Reset operation
                2'b11: q <= ~q;     // Toggle operation
                default: q <= q;    // Hold operation
            endcase
        end
    end

endmodule