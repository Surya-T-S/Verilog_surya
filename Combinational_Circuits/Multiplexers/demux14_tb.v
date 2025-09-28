/*
* Testbench for 1-to-4 Demultiplexer
* ----------------------------------
* Tests both logic and conditional implementations
*/

`timescale 1ns/1ps

module demux14_tb;
    // Test signals
    reg d;          // Input data
    reg [1:0] s;    // Select lines
    wire [3:0] y_logic, y_cond;  // Outputs from both implementations

    // Instantiate both implementations
    demux14_logic dut_logic(
        .d(d),
        .s(s),
        .y(y_logic)
    );

    demux14_cond dut_cond(
        .d(d),
        .s(s),
        .y(y_cond)
    );

    // Test stimulus
    initial begin
        $display("\n=== 1-to-4 Demultiplexer Test ===");
        $display("Input Select | Logic Output | Conditional Output | Match?");
        $display("------------------------------------------");

        // Test all combinations
        for(integer i = 0; i < 8; i = i + 1) begin
            {d, s} = i;
            #5;
            $display("  %b   %b   |    %b     |      %b      |   %s",
                    d, s, y_logic, y_cond, (y_logic === y_cond) ? "Yes" : "No");
        end

        if (y_logic === y_cond)
            $display("\nTest passed: Both implementations match!");
        else
            $display("\nTest failed: Implementations differ!");

        $finish;
    end
endmodule
