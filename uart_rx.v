module uart_rx (
    input        rx,
    input        clk,
    input        baud_rx,
    input        reset,
    output reg   busy,
    output reg [7:0] d
);

reg [9:0] sipo;
reg [3:0] count;

always @(posedge clk) begin

    if (reset) begin
        sipo  <= 10'b0;
        count <= 0;
        busy  <= 0;
        d     <= 0;
    end

    else if (!rx && !busy) begin
        busy  <= 1;
        count <= 0;
    end
    else if (busy && baud_rx) begin

        if (count == 0) begin

            if (rx == 0) begin
                sipo[count] <= rx;
                count <= count + 1;
            end

            else begin
                busy  <= 0;
                count <= 0;
            end
        end

        
        else if (count == 9) begin

            if (rx == 1) begin
                busy <= 0;
                d <= sipo[8:1];
                count <= 0;
            end

            else begin
                
                busy <= 0;
                count <= 0;
            end
        end

       
        else begin
            sipo[count] <= rx;
            count <= count + 1;
        end
    end

end

endmodule