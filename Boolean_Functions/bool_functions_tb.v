/*
* Testbench for all Boolean Functions
*/

`timescale 1ns/1ps

module bool_functions_tb;
    // Test signals for 3-input functions (Q1, Q2, Q3)
    reg A, B, C;
    wire F1_d, F1_b, F1_s;  // Question 1 outputs
    wire F2_d, F2_b, F2_s;  // Question 2 outputs
    wire F3_d, F3_b, F3_s;  // Question 3 outputs
    
    // Test signals for 4-input function (Q4)
    reg W, X, Y, Z;
    wire F4_d, F4_b, F4_s;  // Question 4 outputs

    // Question 1: F = AB + A'C
    bool_q1_dataflow  q1_d(A, B, C, F1_d);
    bool_q1_behavioral q1_b(A, B, C, F1_b);
    bool_q1_structural q1_s(A, B, C, F1_s);

    // Question 2: F₁ = (A+B+C)(A+B'+C)(A'+B+C')(A'+B'+C')
    bool_q2_dataflow  q2_d(A, B, C, F2_d);
    bool_q2_behavioral q2_b(A, B, C, F2_b);
    bool_q2_structural q2_s(A, B, C, F2_s);

    // Question 3: F(ABC) = Σ(0,2,5,6)
    bool_q3_dataflow  q3_d(A, B, C, F3_d);
    bool_q3_behavioral q3_b(A, B, C, F3_b);
    bool_q3_structural q3_s(A, B, C, F3_s);

    // Question 4: F(WXYZ) = (W+X'+Y)(X+Y')(X+Y'+Z)
    bool_q4_dataflow  q4_d(W, X, Y, Z, F4_d);
    bool_q4_behavioral q4_b(W, X, Y, Z, F4_b);
    bool_q4_structural q4_s(W, X, Y, Z, F4_s);

    // Test stimulus
    initial begin
        $display("=== Testing Boolean Functions ===\n");

        // Test 3-input functions
        $display("=== Q1: F = AB + A'C ===");
        $display("A B C | Dataflow | Behavioral | Structural");
        $display("------|----------|------------|----------");
        for (integer i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;
            #5;
            $display("%b %b %b |    %b     |     %b      |    %b", 
                    A, B, C, F1_d, F1_b, F1_s);
        end

        $display("\n=== Q2: Complex Function ===");
        $display("A B C | Dataflow | Behavioral | Structural");
        $display("------|----------|------------|----------");
        for (integer i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;
            #5;
            $display("%b %b %b |    %b     |     %b      |    %b", 
                    A, B, C, F2_d, F2_b, F2_s);
        end

        $display("\n=== Q3: F(ABC)=Σ(0,2,5,6) ===");
        $display("A B C | Dataflow | Behavioral | Structural");
        $display("------|----------|------------|----------");
        for (integer i = 0; i < 8; i = i + 1) begin
            {A, B, C} = i;
            #5;
            $display("%b %b %b |    %b     |     %b      |    %b", 
                    A, B, C, F3_d, F3_b, F3_s);
        end

        $display("\n=== Q4: 4-Input Function ===");
        $display("W X Y Z | Dataflow | Behavioral | Structural");
        $display("--------|----------|------------|----------");
        for (integer i = 0; i < 16; i = i + 1) begin
            {W, X, Y, Z} = i;
            #5;
            $display("%b %b %b %b |    %b     |     %b      |    %b", 
                    W, X, Y, Z, F4_d, F4_b, F4_s);
        end

        $finish;
    end
endmodule
