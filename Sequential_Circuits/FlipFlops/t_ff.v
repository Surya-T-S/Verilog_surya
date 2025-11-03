//==============================================================================
// Module: t_ff
// Description: Synchronous T (Toggle) flip-flop with active-high reset
//
// The T flip-flop is specialized for toggling behavior, making it ideal for
// frequency dividers, binary counters, and clock generation circuits. When
// the toggle input is high, the output inverts on each clock edge.
//
// Parameters:
//   - None
//
// Ports:
//   - clk    : Clock input (rising edge triggered)
//   - reset  : Synchronous reset (active-high, overrides toggle input)
//   - t      : Toggle input (when high, inverts q on clock edge)
//   - q      : Output state
//   - q_bar  : Complementary output (inverse of q)
//
// Behavior:
//   - On reset: q = 0
//   - t=0: q holds previous value
//   - t=1: q toggles (inverts)
//
// Truth Table:
//   | reset | t | q(next) | Operation |
//   |-------|---|---------|-----------|
//   |   1   | x |    0    | Reset     |
//   |   0   | 0 |    q    | Hold      |
//   |   0   | 1 |   ~q    | Toggle    |
//
// Applications:
//   - Frequency divider (divide by 2 when t=1 continuously)
//   - Binary counters
//   - Clock domain crossing
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

module t_ff (
    input  wire clk,      // Clock signal
    input  wire reset,    // Synchronous reset (active-high)
    input  wire t,        // Toggle input
    output reg  q,        // Registered output
    output wire q_bar     // Complementary output
);

    // Continuous assignment for complementary output
    assign q_bar = ~q;

    // Sequential logic: toggle behavior on rising clock edge
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;              // Reset state overrides all
        end else begin
            if (t) begin
                q <= ~q;            // Toggle operation
            end else begin
                q <= q;             // Hold operation
            end
        end
    end

endmodule


