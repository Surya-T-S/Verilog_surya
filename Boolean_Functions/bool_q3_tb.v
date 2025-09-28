/*
* Testbench for Question 3: F(ABC) = Σ(0,2,5,6)
* --------------------------------------------
* Tests all three implementations of the minterm function.
* Each implementation should output 1 for minterms 0,2,5,6
* and 0 for all other inputs.
*/

`timescale 1ns/1ps

module bool_q3_tb;
    // Test signals
    reg A, B, C;
    wire F_dataflow, F_behavioral, F_structural;

    // Instantiate all three implementations
    bool_q3_dataflow dut_d(
        .A(A), .B(B), .C(C),
        .F(F_dataflow)
    );

    bool_q3_behavioral dut_b(
        .A(A), .B(B), .C(C),
        .F(F_behavioral)
    );

    bool_q3_structural dut_s(
        .A(A), .B(B), .C(C),
        .F(F_structural)
    );

    // Task to check if current input is a minterm
    function automatic is_minterm;
        input [2:0] abc;
        begin
            is_minterm = (abc == 3'b000) || // m0
                        (abc == 3'b010) || // m2
                        (abc == 3'b101) || // m5
                        (abc == 3'b110);   // m6
        end
    endfunction

    // Test stimulus
    initial begin
        $display("\n=== Testing Question 3: F(ABC) = Σ(0,2,5,6) ===");
        $display("A B C | Minterm? | Dataflow | Behavioral | Structural | All Match?");
        $display("------|----------|----------|------------|-----------|------------");

        // Test all input combinations
        for(integer i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;
            #5; // Wait for outputs to settle
            
            // Display results
            $display("%b %b %b |    %b     |    %b     |     %b      |     %b     |     %s    ", 
                    A, B, C,
                    is_minterm({A,B,C}),
                    F_dataflow,
                    F_behavioral,
                    F_structural,
                    (F_dataflow === F_behavioral && F_behavioral === F_structural && 
                     F_dataflow === is_minterm({A,B,C})) ? "YES" : "NO");
                     
            // Check for errors
            if(F_dataflow !== is_minterm({A,B,C}))
                $display("Error in dataflow: expected %b", is_minterm({A,B,C}));
            if(F_behavioral !== is_minterm({A,B,C}))
                $display("Error in behavioral: expected %b", is_minterm({A,B,C}));
            if(F_structural !== is_minterm({A,B,C}))
                $display("Error in structural: expected %b", is_minterm({A,B,C}));
        end

        $display("\nTest Summary:");
        $display("------------");
        $display("Minterms (should be 1): m0(000), m2(010), m5(101), m6(110)");
        $display("All other inputs should be 0");
        
        // Final verification
        if(F_dataflow === F_behavioral && F_behavioral === F_structural)
            $display("PASS: All implementations match!");
        else
            $display("FAIL: Implementations differ!");

        $finish;
    end
endmodule
