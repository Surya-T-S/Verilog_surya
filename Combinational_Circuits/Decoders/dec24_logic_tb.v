/*
* Testbench for 2-to-4 Decoder
* ----------------------------
* This testbench verifies the functionality of the 2:4 decoder
* by testing all possible input combinations
*/

`timescale 1ns/1ps

module dec24_logic_tb;
    // Test signals
    reg [1:0] in;        // Input
    wire [3:0] out;      // Output
    
    // Instantiate the decoder
    dec24_logic dec_dut(
        .in(in),
        .out(out)
    );
    
    // Test stimulus
    initial begin
        // Display header
        $display("\n=== 2:4 Decoder Test ===");
        $display("Input[1:0] | Output[3:0]");
        $display("-----------|------------");
        
        // Test all input combinations
        for(integer i = 0; i < 4; i = i + 1) begin
            in = i;  // Assign input
            #5;     // Wait for signals to settle
            
            // Display results
            $display("    %b     |    %b", in, out);
            
            // Verify one-hot encoding (exactly one output should be 1)
            if (out !== (4'b0001 << in)) begin
                $display("Error: Expected output %b for input %b", (4'b0001 << in), in);
            end
        end
        
        $display("\nTest completed successfully!");
        $finish;
    end
endmodule
