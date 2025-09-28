/*
* Testbench for Question 1: F = AB + A'C
* ------------------------------------
* Tests all three implementations:
* - Dataflow
* - Behavioral
* - Structural
*/

`timescale 1ns/1ps

module bool_q1_tb;
    // Test signals
    reg A, B, C;
    wire F_dataflow, F_behavioral, F_structural;

    // Instantiate all three implementations
    bool_q1_dataflow dut_d(
        .A(A), .B(B), .C(C),
        .F(F_dataflow)
    );

    bool_q1_behavioral dut_b(
        .A(A), .B(B), .C(C),
        .F(F_behavioral)
    );

    bool_q1_structural dut_s(
        .A(A), .B(B), .C(C),
        .F(F_structural)
    );

    // Test stimulus
    initial begin
        $display("\n=== Testing Question 1: F = AB + A'C ===");
        $display("A B C | Dataflow | Behavioral | Structural | Match?");
        $display("------|----------|------------|-----------|-------");

        // Test all input combinations
        for(integer i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;
            #5; // Wait for outputs to settle
            
            // Display results
            $display("%b %b %b |    %b     |     %b      |     %b     |   %s",
                    A, B, C, F_dataflow, F_behavioral, F_structural,
                    (F_dataflow === F_behavioral && F_behavioral === F_structural) ? "Yes" : "No");
        end

        // Verify all implementations match
        if(F_dataflow === F_behavioral && F_behavioral === F_structural)
            $display("\nTest Passed: All implementations match!");
        else
            $display("\nTest Failed: Implementations differ!");

        $finish;
    end
endmodule
