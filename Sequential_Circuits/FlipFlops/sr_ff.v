//==============================================================================
// Module: sr_ff
// Description: Synchronous SR (Set-Reset) flip-flop with active-high reset
//
// The SR flip-flop provides independent set and reset control. It's useful
// for control logic and state machines where asynchronous set/reset behavior
// is needed within a synchronous framework.
//
// Parameters:
//   - None
//
// Ports:
//   - clk    : Clock input (rising edge triggered)
//   - reset  : Synchronous reset (active-high, overrides s and r)
//   - s      : Set input (when high, sets q to 1)
//   - r      : Reset input (when high, clears q to 0)
//   - q      : Output state
//   - q_bar  : Complementary output (inverse of q)
//
// Behavior:
//   - On reset: q = 0
//   - s=1, r=0: q = 1 (set)
//   - s=0, r=1: q = 0 (reset)
//   - s=0, r=0: q holds previous value
//   - s=1, r=1: q holds previous value (undefined in classical SR, here treated as hold)
//
// Truth Table:
//   | reset | s | r | q(next) | Operation |
//   |-------|---|---|---------|-----------|
//   |   1   | x | x |    0    | Reset     |
//   |   0   | 0 | 0 |    q    | Hold      |
//   |   0   | 0 | 1 |    0    | Reset     |
//   |   0   | 1 | 0 |    1    | Set       |
//   |   0   | 1 | 1 |    q    | Hold      |
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

module sr_ff (
    input  wire clk,      // Clock signal
    input  wire reset,    // Synchronous reset (active-high)
    input  wire s,        // Set input
    input  wire r,        // Reset input
    output reg  q,        // Registered output
    output wire q_bar     // Complementary output
);

    // Continuous assignment for complementary output
    assign q_bar = ~q;

    // Sequential logic: SR behavior on rising clock edge
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;              // Reset state overrides all
        end else begin
            if (s && !r) begin
                q <= 1'b1;          // Set operation
            end else if (r && !s) begin
                q <= 1'b0;          // Reset operation
            end else begin
                q <= q;             // Hold (including s=r=1 condition)
            end
        end
    end

endmodule


