`timescale 1ns/1ps

module uart_tx_tb;

reg [7:0] d;
reg start;
reg clk;
reg baud;
reg reset;

wire tx;

uart_tx uut (
    .d(d),
    .start(start),
    .clk(clk),
    .baud(baud),
    .reset(reset),
    .tx(tx)
);

// 10 ns clock
always #5 clk = ~clk;

initial begin
    $dumpfile("uart_tx.vcd");
    $dumpvars(0, uart_tx_tb);

    clk   = 0;
    baud  = 0;
    start = 0;
    reset = 1;
    d     = 8'b10110010;

    // Reset
    #20;
    reset = 0;

    // Start transmission
    #10;
    start = 1;
    #10;
    start = 0;

    // 9 baud ticks after START
    repeat (9) begin
        #40;
        baud = 1;
        #10;
        baud = 0;
    end

    // Wait
    #50;

    $finish;
end

endmodule