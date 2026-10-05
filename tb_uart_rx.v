`timescale 1ns/1ps

module tb_uart_rx;

reg clk;
reg rx;
reg reset;

wire baud_rx;
wire busy;
wire [7:0] d;

uart_rx uut (
    .rx(rx),
    .clk(clk),
    .baud_rx(baud_rx),
    .reset(reset),
    .busy(busy),
    .d(d)
);

baud_gen_rx baud_gen (
    .clk(clk),
    .busy(busy),
    .baud_rx(baud_rx)
);

// 100 MHz clock
always #5 clk = ~clk;


// Send one UART bit for 868 clock cycles
task send_bit;
    input bit_value;

    begin
        rx = bit_value;

        repeat (868)
            @(posedge clk);
    end
endtask


initial begin

    // VCD
    $dumpfile("uart_rx.vcd");
    $dumpvars(0, tb_uart_rx);

    // Initial conditions
    clk   = 0;
    rx    = 1;       // UART idle
    reset = 1;

    // Reset
    repeat (5)
        @(posedge clk);

    reset = 0;

    // Idle before transmission
    repeat (10)
        @(posedge clk);


    // =====================================
    // SEND 10110010 (0xB2)
    // UART sends LSB FIRST
    // =====================================

    // START
    send_bit(0);

    // D0
    send_bit(0);

    // D1
    send_bit(1);

    // D2
    send_bit(0);

    // D3
    send_bit(0);

    // D4
    send_bit(1);

    // D5
    send_bit(1);

    // D6
    send_bit(0);

    // D7
    send_bit(1);

    // STOP
    send_bit(1);


    // Wait for RX to finish
    repeat (20)
        @(posedge clk);


    $display("Received data = %h", d);

    $finish;

end

endmodule