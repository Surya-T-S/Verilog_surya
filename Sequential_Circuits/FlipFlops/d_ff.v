//==============================================================================
// Module: d_ff
// Description: Synchronous D flip-flop with active-high reset
//
// The D flip-flop is the most fundamental sequential storage element. It
// captures the input data 'd' on the rising edge of the clock and holds it
// until the next clock edge. The reset input provides initialization.
//
// Parameters:
//   - None
//
// Ports:
//   - clk    : Clock input (rising edge triggered)
//   - reset  : Synchronous reset (active-high, overrides data input)
//   - d      : Data input
//   - q      : Output (follows d after clock edge)
//   - q_bar  : Complementary output (inverse of q)
//
// Behavior:
//   - On reset: q = 0
//   - On rising clock edge: q = d
//
// Author: Surya-T-S
// Date: November 4, 2025
//==============================================================================

module d_ff (
    input  wire clk,      // Clock signal
    input  wire reset,    // Synchronous reset (active-high)
    input  wire d,        // Data input
    output reg  q,        // Registered output
    output wire q_bar     // Complementary output
);

    // Continuous assignment for complementary output
    assign q_bar = ~q;

    // Sequential logic: capture data on rising clock edge
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;    // Reset state
        end else begin
            q <= d;       // Store input data
        end
    end

endmodule
