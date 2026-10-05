module uart_tx (
    input  [7:0] d,
    input        start,
    input        clk,
    input        baud,
    input        reset,
    output reg   tx
);

reg [9:0] piso;
reg [3:0] count;
reg busy;

always @(posedge clk) begin

    if (reset) begin
        piso  <= 10'b0;
        count <= 0;
        busy  <= 0;
        tx    <= 1;       // UART idle
    end

    else if (start && !busy) begin
        piso  <= {1'b1, d, 1'b0};
        count <= 0;
        busy  <= 1;
        tx    <= 0;       // START
    end

    else if (busy && baud) begin
        if (count == 8) begin
            tx    <= piso[1];
            piso  <= {1'b0, piso[9:1]};
            count <= count + 1;
        end

        else if (count == 9) begin
            tx    <= 1;       // STOP
            busy  <= 0;
            count <= 0;
        end

        else begin
            tx    <= piso[1];
            piso  <= {1'b0, piso[9:1]};
            count <= count + 1;
        end
    end

end

endmodule