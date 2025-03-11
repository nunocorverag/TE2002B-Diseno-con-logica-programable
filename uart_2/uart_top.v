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
	input serial_data_in,

    output reg [DATA_BITS-1:0] leds
    // output [0: SEGMENTOS - 1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares
);

localparam CLOCKS_PER_BIT = BASE_CLK / BAUDRATE;

wire one_shot_rst, one_shot_send_data;
wire [DATA_BITS-1:0] rx_data;

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
    .rx_data(rx_data)
);

always @(posedge clk or posedge one_shot_rst) begin
    if (one_shot_rst)
        leds <= 8'b00000001;
    else if (one_shot_send_data)
        leds <= 8'b00000010;
    else
        leds <= rx_data;
end

endmodule