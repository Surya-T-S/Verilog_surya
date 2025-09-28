/*
* Testbench for 4-to-2 Priority Encoder
* -----------------------------------
* Tests both logic and conditional implementations
*/

`timescale 1ns/1ps

module enc42_tb;
    // Test signals
    reg [3:0] in;                    // Input
    wire [1:0] code_logic, code_cond; // Encoded outputs
    wire valid_logic, valid_cond;     // Valid flags

    // Instantiate both implementations
    enc42_logic dut_logic(
        .in(in),
        .code(code_logic),
        .valid(valid_logic)
    );

    enc42_cond dut_cond(
        .in(in),
        .code(code_cond),
        .valid(valid_cond)
    );

    // Test stimulus
    initial begin
        $display("\n=== 4-to-2 Priority Encoder Test ===");
        $display("Input | Logic (Code,Valid) | Conditional (Code,Valid) | Match?");
        $display("-----------------------------------------------------");

        // Test all input combinations
        for(integer i = 0; i < 16; i = i + 1) begin
            in = i;
            #5;
            $display("%b |      %b,%b       |         %b,%b        |   %s",
                    in, code_logic, valid_logic, code_cond, valid_cond,
                    (code_logic === code_cond && valid_logic === valid_cond) ? "Yes" : "No");
        end

        if (code_logic === code_cond && valid_logic === valid_cond)
            $display("\nTest passed: Both implementations match!");
        else
            $display("\nTest failed: Implementations differ!");

        $finish;
    end
endmodule
