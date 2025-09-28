/*
* Question 4: F(WXYZ) = (W+X'+Y)(X+Y')(X+Y'+Z)
* -------------------------------------------
* Complex Boolean function implementation using three modeling styles
*/

// Dataflow implementation
module bool_q4_dataflow(
    input W, X, Y, Z,
    output F
);
    // F = (W+X'+Y)(X+Y')(X+Y'+Z)
    assign F = (W | ~X | Y) & (X | ~Y) & (X | ~Y | Z);
endmodule

// Behavioral implementation
module bool_q4_behavioral(
    input W, X, Y, Z,
    output reg F
);
    always @(*) begin
        // Breaking down into terms for clarity
        F = (W | ~X | Y) &     // Term 1
            (X | ~Y) &         // Term 2
            (X | ~Y | Z);      // Term 3
    end
endmodule

// Structural implementation
module bool_q4_structural(
    input W, X, Y, Z,
    output F
);
    wire not_X, not_Y;
    wire term1, term2, term3;
    
    // Inverters
    not g1(not_X, X);
    not g2(not_Y, Y);
    
    // Terms
    or g3(term1, W, not_X, Y);     // Term 1: W + X' + Y
    or g4(term2, X, not_Y);        // Term 2: X + Y'
    or g5(term3, X, not_Y, Z);     // Term 3: X + Y' + Z
    
    // Final AND of all terms
    and g6(F, term1, term2, term3);
endmodule
