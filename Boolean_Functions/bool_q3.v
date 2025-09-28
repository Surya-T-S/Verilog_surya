/*
* Question 3: F(ABC) = Σ(0,2,5,6)
* ------------------------------
* Sum of minterms implementation using three modeling styles
*/

// Dataflow implementation
module bool_q3_dataflow(
    input A, B, C,
    output F
);
    // F = Σ(0,2,5,6)
    // m0 = A'B'C' (000)
    // m2 = A'B'C  (010)
    // m5 = AB'C   (101)
    // m6 = ABC'   (110)
    assign F = (~A & ~B & ~C) |  // m0
              (~A & B & ~C) |    // m2
              (A & ~B & C) |     // m5
              (A & B & ~C);      // m6
endmodule

// Behavioral implementation
module bool_q3_behavioral(
    input A, B, C,
    output reg F
);
    always @(*) begin
        case({A,B,C})
            3'b000: F = 1;  // m0
            3'b010: F = 1;  // m2
            3'b101: F = 1;  // m5
            3'b110: F = 1;  // m6
            default: F = 0;
        endcase
    end
endmodule

// Structural implementation
module bool_q3_structural(
    input A, B, C,
    output F
);
    wire not_A, not_B, not_C;
    wire m0, m2, m5, m6;
    
    // Inverters
    not g1(not_A, A);
    not g2(not_B, B);
    not g3(not_C, C);
    
    // Minterm gates
    and g4(m0, not_A, not_B, not_C);  // m0 = A'B'C'
    and g5(m2, not_A, B, not_C);      // m2 = A'BC'
    and g6(m5, A, not_B, C);          // m5 = AB'C
    and g7(m6, A, B, not_C);          // m6 = ABC'
    
    // Sum of minterms
    or g8(F, m0, m2, m5, m6);
endmodule
