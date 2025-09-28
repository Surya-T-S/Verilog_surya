/*
* Testbench for Question 4: F(WXYZ) = (W+X'+Y)(X+Y')(X+Y'+Z)
* -------------------------------------------------------
* Tests all three implementations:
* - Dataflow
* - Behavioral
* - Structural
*/

`timescale 1ns/1ps

module bool_q4_tb;
    // Test signals
    reg W, X, Y, Z;
    wire F_dataflow, F_behavioral, F_structural;

    // Instantiate all three implementations
    bool_q4_dataflow dut_d(
        .W(W), .X(X), .Y(Y), .Z(Z),
        .F(F_dataflow)
    );

    bool_q4_behavioral dut_b(
        .W(W), .X(X), .Y(Y), .Z(Z),
        .F(F_behavioral)
    );

    bool_q4_structural dut_s(
        .W(W), .X(X), .Y(Y), .Z(Z),
        .F(F_structural)
    );

    // Test stimulus
    initial begin
        $display("\n=== Testing Question 4: F(WXYZ) = (W+X'+Y)(X+Y')(X+Y'+Z) ===");
        $display("W X Y Z | Dataflow | Behavioral | Structural | Match?");
        $display("---------|----------|------------|-----------|-------");

        // Test all input combinations
        for(integer i = 0; i < 16; i = i + 1) begin
            {W, X, Y, Z} = i;
            #5; // Wait for outputs to settle
            
            // Display results
            $display("%b %b %b %b |    %b     |     %b      |     %b     |   %s",
                    W, X, Y, Z, F_dataflow, F_behavioral, F_structural,
                    (F_dataflow === F_behavioral && F_behavioral === F_structural) ? "Yes" : "No");

            // Optional: Print terms for debugging
            /* $display("Terms: T1=%b T2=%b T3=%b",
                    (W | ~X | Y),
                    (X | ~Y),
                    (X | ~Y | Z)); */
        end

        // Verify all implementations match
        if(F_dataflow === F_behavioral && F_behavioral === F_structural)
            $display("\nTest Passed: All implementations match!");
        else
            $display("\nTest Failed: Implementations differ!");

        $finish;
    end
endmodule
