// Detector de flanco de subida, compara el estado actual con el anterior
module edge_detector(
    input clk,
    input signal_sync,
    output wire rise_edge
);
    reg signal_delayed;
    always @(posedge clk) begin
        signal_delayed <= signal_sync;
    end
    assign rise_edge = signal_sync & ~signal_delayed;
endmodule