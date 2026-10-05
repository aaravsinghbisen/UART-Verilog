module baud_gen (
    input clk,
    output reg baud
);

reg [9:0] count;

always @(posedge clk) begin
    if (count == 868) begin
        count <= 0;
        baud <= 1;
    end
    else begin
        count <= count + 1;
        baud <= 0;
    end
end

endmodule