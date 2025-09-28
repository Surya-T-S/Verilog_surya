/*
* Testbench for 2-to-4 Decoder
* ---------------------------
* Tests both logic and conditional implementations
*/

`timescale 1ns/1ps

module dec24_tb;
    // Test signals
    reg [1:0] in;                  // Input
    wire [3:0] out_logic, out_cond; // Outputs from both implementations

    // Instantiate both implementations
    dec24_logic dut_logic(
        .in(in),
        .out(out_logic)
    );

    dec24_cond dut_cond(
        .in(in),
        .out(out_cond)
    );

    // Test stimulus
    initial begin
        $display("\n=== 2-to-4 Decoder Test ===");
        $display("Input | Logic Output | Conditional Output | Match?");
        $display("-------------------------------------------");

        // Test all input combinations
        for(integer i = 0; i < 4; i = i + 1) begin
            in = i;
            #5;
            $display(" %b  |    %b     |      %b       |   %s",
                    in, out_logic, out_cond, (out_logic === out_cond) ? "Yes" : "No");

            // Verify one-hot encoding
            if (out_logic !== (4'b0001 << in))
                $display("Error: Logic implementation output incorrect");
            if (out_cond !== (4'b0001 << in))
                $display("Error: Conditional implementation output incorrect");
        end

        if (out_logic === out_cond)
            $display("\nTest passed: Both implementations match!");
        else
            $display("\nTest failed: Implementations differ!");

        $finish;
    end
endmodule
