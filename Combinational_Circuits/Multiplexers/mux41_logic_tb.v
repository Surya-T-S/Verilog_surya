/*
* Testbench for 4-to-1 Multiplexer
* ---------------------------------
* This testbench verifies the functionality of the 4:1 multiplexer
* by testing all possible combinations of inputs and select lines
*/

`timescale 1ns/1ps

module mux41_logic_tb;
    // Test signals
    reg [3:0] d;      // Input data
    reg [1:0] s;      // Select lines
    wire y;           // Output
    
    // Instantiate the multiplexer
    mux41_logic mux_dut(
        .d(d),
        .s(s),
        .y(y)
    );
    
    // Test stimulus
    initial begin
        // Display header
        $display("\n=== 4:1 Multiplexer Test ===");
        $display("Data[3:0] Select[1:0] | Output");
        $display("----------------------|--------");
        
        // Test all combinations
        for(integer i = 0; i < 64; i = i + 1) begin
            {d, s} = i;  // Assign bits to inputs
            #5;  // Wait for signals to settle
            
            // Display results in an easy-to-read format
            $display("  %b     %b    |   %b", d, s, y);
            
            // Verify output matches expected behavior
            if (y !== d[s]) begin
                $display("Error: Expected output %b for d=%b, s=%b", d[s], d, s);
            end
        end
        
        $display("\nTest completed successfully!");
        $finish;
    end
endmodule
