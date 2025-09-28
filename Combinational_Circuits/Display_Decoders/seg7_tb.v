/*
* Testbench for 7-Segment Display Decoder
* -------------------------------------
* Tests both logic and conditional implementations
*/

`timescale 1ns/1ps

module seg7_tb;
    // Test signals
    reg [3:0] hex;                    // Input hex digit
    wire [6:0] seg_logic, seg_cond;   // 7-segment outputs

    // Instantiate both implementations
    seg7_logic dut_logic(
        .hex(hex),
        .seg(seg_logic)
    );

    seg7_cond dut_cond(
        .hex(hex),
        .seg(seg_cond)
    );

    // Test stimulus
    initial begin
        $display("\n=== 7-Segment Display Decoder Test ===");
        $display("Hex | Logic Output | Conditional Output | Match?");
        $display("--------------------------------------------");

        // Test all valid hex digits and beyond
        for(integer i = 0; i < 16; i = i + 1) begin
            hex = i;
            #5;
            $display(" %h  |    %b    |     %b     |   %s",
                    hex, seg_logic, seg_cond, (seg_logic === seg_cond) ? "Yes" : "No");
        end

        if (seg_logic === seg_cond)
            $display("\nTest passed: Both implementations match!");
        else
            $display("\nTest failed: Implementations differ!");

        $finish;
    end
endmodule
