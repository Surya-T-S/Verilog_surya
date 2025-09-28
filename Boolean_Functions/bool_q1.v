/*
* Question 1: F = AB + A'C
* -----------------------
* Simple Boolean function implementation using three modeling styles
*/

// Dataflow (continuous assignment) implementation
module bool_q1_dataflow(
    input A, B, C,
    output F
);
    // F = AB + A'C
    assign F = (A & B) | (~A & C);
endmodule

// Behavioral implementation
module bool_q1_behavioral(
    input A, B, C,
    output reg F
);
    always @(*) begin
        F = (A & B) | (~A & C);
    end
endmodule

// Structural (gate-level) implementation
module bool_q1_structural(
    input A, B, C,
    output F
);
    wire w1, w2, not_A;
    
    // Component instantiation
    not g1(not_A, A);    // not_A = A'
    and g2(w1, A, B);    // w1 = AB
    and g3(w2, not_A, C);// w2 = A'C
    or  g4(F, w1, w2);   // F = w1 + w2
endmodule
