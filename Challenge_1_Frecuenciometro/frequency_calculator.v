// Calcula la frecuencia a partir del período medido
module frequency_calculator(
    input clk,
    input [23:0] period,
    input signal_in,
    output reg [19:0] frequency
);

    always @(posedge clk) begin
        if (signal_in === 1'bz) begin
            frequency <= 0;
        end else if (period == 0) begin
            frequency <= 0;
        end else begin
            frequency <= 50000000 / period; // 50 MHz
        end
    end

endmodule
