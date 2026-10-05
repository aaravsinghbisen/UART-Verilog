module baud_gen_rx (
    input clk,
    input busy,
    output reg baud_rx
);
reg busy_baud;
reg [9:0] count;

always @(posedge clk ) begin
    if (!busy) begin
	count <=0;
	busy_baud <=0;
	baud_rx <= 0 ;
    end
    else if (count == 434 && !busy_baud ) begin
	busy_baud <=1;
	baud_rx <= 1;
	count <=0;
    end
    else if (count == 868 && busy_baud) begin
        count <= 0;
        baud_rx <= 1;
    end
    else begin
        count <= count + 1;
        baud_rx <= 0;
    end
end

endmodule