/*
* 4-to-1 Multiplexer (Logic Implementation)
* ---------------------------------------------
* This module implements a 4-to-1 multiplexer using logic equations
* 
* Inputs:
*   - d[3:0]: 4-bit input data
*   - s[1:0]: 2-bit select line
*             s[1:0] = 00 selects d[0]
*             s[1:0] = 01 selects d[1]
*             s[1:0] = 10 selects d[2]
*             s[1:0] = 11 selects d[3]
*
* Output:
*   - y: Selected input based on select lines
*
* Implementation:
*   Uses direct logic implementation with AND-OR structure
*/

module mux41_logic(
    input [3:0] d,     // 4-bit input data
    input [1:0] s,     // 2-bit select
    output y          // Output
);

    // Logic equation for 4:1 multiplexer:
    // y = d0·s̄1·s̄0 + d1·s̄1·s0 + d2·s1·s̄0 + d3·s1·s0
    assign y = (d[0] & ~s[1] & ~s[0]) |    // Select d[0] when s = 00
               (d[1] & ~s[1] &  s[0]) |    // Select d[1] when s = 01
               (d[2] &  s[1] & ~s[0]) |    // Select d[2] when s = 10
               (d[3] &  s[1] &  s[0]);     // Select d[3] when s = 11

endmodule
