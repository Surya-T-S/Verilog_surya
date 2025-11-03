`timescale 1ns/1ps
module sync_up_2bit_tb;
    reg clk;
    reg reset;
    wire [1:0]Q;

    sync_up_2bit ddt (.clk(clk),.reset(reset),.Q(Q));

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;    // clock toggles every 5ns(10ns time period)
    end

    initial begin
        reset = 1'b1;
        #15;
        reset = 1'b0;
        #100;
        reset = 1'b1;
        #20;
        reset = 1'b0;
        #50;
        $finish;
    end

    initial begin
        $display("-----------------------------------------------------------------");
        $display("|        Time            | Reset |  Counter Output |  Decimal |");
        $display("-----------------------------------------------------------------");
        $monitor("|  %t  |   %b  |       %b       |    %d   |",$time,reset,Q,Q);

        
    end

endmodule