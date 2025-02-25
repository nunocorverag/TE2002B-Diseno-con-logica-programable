module bcd #(parameter WIRE_SIZE = 4, parameter SEGMENTOS = 7, BIT_SIZE=10)(
    input [BIT_SIZE-1:0] binary_in,
    output [0: SEGMENTOS - 1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares
);

// Instancia del modulo display para manejar la conversion
display_module #(.WIRE_SIZE(WIRE_SIZE), .SEGMENTOS(SEGMENTOS), .BIT_SIZE(BIT_SIZE))  DISPLAY_MODULE (
    .number(binary_in),
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares)
);

endmodule