/*
* 2-to-4 Decoder (Logic Implementation)
* ------------------------------------
* This module implements a 2-to-4 decoder using logic equations
* 
* Inputs:
*   - in[1:0]: 2-bit input
*
* Outputs:
*   - out[3:0]: 4-bit decoded output where:
*     out[0] = 1 when in = 00
*     out[1] = 1 when in = 01
*     out[2] = 1 when in = 10
*     out[3] = 1 when in = 11
*
* Implementation:
*   Uses direct logic implementation with AND gates and inverters
*/

module dec24_logic(
    input [1:0] in,      // 2-bit input
    output [3:0] out     // 4-bit decoded output
);
    // Internal wire declarations for inverted inputs
    wire [1:0] in_n;     // Inverted inputs
    
    // Generate inverted inputs
    assign in_n = ~in;
    
    // Decode logic equations:
    // out[0] = in̄1 · in̄0
    // out[1] = in̄1 · in0
    // out[2] = in1 · in̄0
    // out[3] = in1 · in0
    assign out[0] = in_n[1] & in_n[0];    // Decode 00
    assign out[1] = in_n[1] & in[0];      // Decode 01
    assign out[2] = in[1] & in_n[0];      // Decode 10
    assign out[3] = in[1] & in[0];        // Decode 11

endmodule
