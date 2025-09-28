/*
* Testbench for Question 2: F₁ = (A + B + C)(A + B' + C)(A' + B + C')(A' + B' + C')
* ------------------------------------------------------------------------------
* Tests all three implementations:
* - Dataflow
* - Behavioral
* - Structural
*/

`timescale 1ns/1ps

module bool_q2_tb;
    // Test signals
    reg A, B, C;
    wire F_dataflow, F_behavioral, F_structural;

    // Instantiate all three implementations
    bool_q2_dataflow dut_d(
        .A(A), .B(B), .C(C),
        .F(F_dataflow)
    );

    bool_q2_behavioral dut_b(
        .A(A), .B(B), .C(C),
        .F(F_behavioral)
    );

    bool_q2_structural dut_s(
        .A(A), .B(B), .C(C),
        .F(F_structural)
    );

    // Test stimulus
    initial begin
        $display("\n=== Testing Question 2: Complex Function ===");
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

            // Optional: Print terms for debugging
            /* $display("Terms: T1=%b T2=%b T3=%b T4=%b",
                    (A | B | C),
                    (A | ~B | C),
                    (~A | B | ~C),
                    (~A | ~B | ~C)); */
        end

        // Verify all implementations match
        if(F_dataflow === F_behavioral && F_behavioral === F_structural)
            $display("\nTest Passed: All implementations match!");
        else
            $display("\nTest Failed: Implementations differ!");

        $finish;
    end
endmodule
