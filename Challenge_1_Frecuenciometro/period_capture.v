// Mide el período entre dos flancos ascendentes
module period_capture(
    input clk,
    input reset,
    input rise_edge,
    output reg [23:0] period
);
    reg [23:0] counter;
    reg [23:0] prev_count;
    reg first_edge;
    
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            prev_count <= 0;
            period <= 0;
            first_edge <= 1;
        end else begin
            counter <= counter + 1;
            if (rise_edge) begin
                if (first_edge) begin
                    prev_count <= counter;
                    first_edge <= 0;
                end else begin
                    period <= counter - prev_count;
                    prev_count <= counter;
                end
            end
        end
    end
endmodule