/*
* Question 2: F₁ = (A + B + C)(A + B' + C)(A' + B + C')(A' + B' + C')
* ------------------------------------------------------------------
* Complex Boolean function implementation using three modeling styles
*/

// Dataflow implementation
module bool_q2_dataflow(
    input A, B, C,
    output F
);
    // F₁ = (A + B + C)(A + B' + C)(A' + B + C')(A' + B' + C')
    assign F = (A | B | C) & 
              (A | ~B | C) & 
              (~A | B | ~C) & 
              (~A | ~B | ~C);
endmodule

// Behavioral implementation
module bool_q2_behavioral(
    input A, B, C,
    output reg F
);
    always @(*) begin
        // Breaking down into terms for clarity
        F = (A | B | C) &        // Term 1
            (A | ~B | C) &       // Term 2
            (~A | B | ~C) &      // Term 3
            (~A | ~B | ~C);      // Term 4
    end
endmodule

// Structural implementation
module bool_q2_structural(
    input A, B, C,
    output F
);
    wire not_A, not_B, not_C;
    wire term1, term2, term3, term4;
    
    // Inverters
    not g1(not_A, A);
    not g2(not_B, B);
    not g3(not_C, C);
    
    // Each term is a 3-input OR gate
    or g4(term1, A, B, C);          // Term 1: A + B + C
    or g5(term2, A, not_B, C);      // Term 2: A + B' + C
    or g6(term3, not_A, B, not_C);  // Term 3: A' + B + C'
    or g7(term4, not_A, not_B, not_C); // Term 4: A' + B' + C'
    
    // Final AND of all terms
    and g8(F, term1, term2, term3, term4);
endmodule
