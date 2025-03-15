// Receptor
module uart_top #(
        parameter INVERT_RST = 1, 
                INVERT_SEND_DATA = 1,
                DEBOUNCE_THRESHOLD = 500_000, 
                BASE_CLK = 50_000_000, 
                BAUDRATE = 115_200,
                DATA_BITS = 8,
                CLOCK_CTR_WIDTH = 32,
                WIRE_SIZE = 4, 
                SEGMENTOS = 7
    )(
    input clk, rst,

	input [1:0] parity_type_sw, // 0: Sin paridad, 1: Paridad impar, 2: Paridad par
    // Transmitter
    input [DATA_BITS-1:0] inp_data,
    input send_data, 
    output output_data_serial, // TX a GPIO

    // Receiver
	input serial_data_in, // RX a GPIO

    output [0: SEGMENTOS - 1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares,
    output reg [1:0] parity_leds // 2 bits para indicar estado de paridad
);

localparam CLOCKS_PER_BIT = BASE_CLK / BAUDRATE;

wire one_shot_rst, one_shot_send_data;
wire [DATA_BITS-1:0] rx_data;
wire parity_error;

debouncer_one_shot #(.INVERT_LOGIC(INVERT_RST), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_RST (
    .clk(clk),
    .signal(rst),
    .signal_one_shot(one_shot_rst)
);

debouncer_one_shot #(.INVERT_LOGIC(INVERT_SEND_DATA), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_SEND_DATA (
    .clk(clk),
    .signal(send_data),
    .signal_one_shot(one_shot_send_data)
);

uart_tx #(.CLOCKS_PER_BIT(CLOCKS_PER_BIT), .DATA_BITS(DATA_BITS), .CLOCK_CTR_WIDTH(CLOCK_CTR_WIDTH)) UART_TX (
    .clk(clk),
    .rst(one_shot_rst),
    .send_data(one_shot_send_data),
    .inp_data(inp_data),
    .parity_type(parity_type_sw),
    .output_data_serial(output_data_serial)
);

uart_rx #(.CLOCKS_PER_BIT(CLOCKS_PER_BIT), .DATA_BITS(DATA_BITS), .CLOCK_CTR_WIDTH(CLOCK_CTR_WIDTH)) UART_RX (
    .clk(clk),
    .rst(one_shot_rst),
    .serial_data_in(serial_data_in),
    .parity_type(parity_type_sw),
    .rx_data(rx_data),
    .parity_error(parity_error)
);

display_module #(.WIRE_SIZE(WIRE_SIZE), .SEGMENTOS(SEGMENTOS), .BIT_SIZE(DATA_BITS))  DISPLAY_MODULE (
    .number(rx_data),
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares)
);

always @(posedge clk or posedge one_shot_rst) 
begin
    if (one_shot_rst == 1'b1) 
        parity_leds <= 2'b00;
    else 
        parity_leds <= {parity_error, ~parity_error}; // LED de error y LED de correcto
end


endmodule