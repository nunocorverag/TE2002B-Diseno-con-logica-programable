// Sincroniza una señal para evitar problemas de metastabilidad
module synchronizer(
    input clk,
    input signal_in,
    output reg signal_sync
);
    reg signal_meta;
    always @(posedge clk) begin
        signal_meta <= signal_in;
        signal_sync <= signal_meta;
    end
endmodule