// Mide la frecuencia de una señal y la muestra en un display de 7 segmentos

module frequency_meter #(parameter INVERT_RST = 1, DEBOUNCE_THRESHOLD = 5000, SEGMENTOS = 7, BIT_SIZE = 20, FREQ = 1, DATA_IN_SIZE = 6)(
    input clk,
    input rst,
    input signal_in,
    output [0:SEGMENTOS-1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares
);

wire one_shot_rst;

debouncer_one_shot #(.INVERT_LOGIC(INVERT_RST), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_RST (
    .clk(clk),
    .signal(rst),
    .signal_one_shot(one_shot_rst)
);

// Sincronización de la señal de entrada
wire synced_signal;
synchronizer SYNCHRONIZER (
    .clk(clk),
    .signal_in(signal_in),
    .signal_sync(synced_signal)
);

// Detección de flanco ascendente
wire rise_edge;
edge_detector EDGE_DETECTOR (
    .clk(clk),
    .signal_sync(synced_signal),
    .rise_edge(rise_edge)
);

// Captura del período
wire [23:0] period;
period_capture PERIOD_CAPTURE (
    .clk(clk),
    .reset(one_shot_rst),
    .rise_edge(rise_edge),
    .period(period)
);

// Cálculo de frecuencia (50 MHz / período)
wire [BIT_SIZE-1:0] frequency;
frequency_calculator FREQUENCY_CALCULATOR (
    .clk(clk),
    .signal_in(signal_in),
    .period(period),
    .frequency(frequency)
);

display_module #(.BIT_SIZE(BIT_SIZE)) DISPLAY_MODULE (
    .number(frequency),
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares)
);

endmodule