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

always #5 clk = ~clk;

task send_bit;
    input bit_value;

    begin
        rx = bit_value;

        repeat (868)
            @(posedge clk);
    end
endtask


initial begin

    $dumpfile("uart_rx.vcd");
    $dumpvars(0, tb_uart_rx);

  
    clk   = 0;
    rx    = 1;       
    reset = 1;

    repeat (5)
        @(posedge clk);

    reset = 0;


    repeat (10)
        @(posedge clk);


    send_bit(0);

    send_bit(0);

    send_bit(1);

    send_bit(0);

    send_bit(0);

    send_bit(1);

    send_bit(1);

    send_bit(0);

    send_bit(1);

    send_bit(1);

    repeat (20)
        @(posedge clk);


    $display("Received data = %h", d);

    $finish;

end

endmodule
