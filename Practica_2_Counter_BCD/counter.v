module counter #(parameter SEGMENTOS = 7, BIT_SIZE = 20, FREQ = 1, DATA_IN_SIZE = 6)(
    input clk, rst_btn, clear_btn, enable, up_down, load,
    input [DATA_IN_SIZE-1:0] data_in,
    output [0:SEGMENTOS-1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares
);

wire clk_div;
wire [BIT_SIZE - 1:0] count;
wire c_out;
wire rst_one_shot;
wire clear_one_shot;

debouncer_one_shot #(.INVERT_LOGIC(1)) DEB_ONE_SHOT_RST (
    .clk(clk),
    .signal(rst_btn),
    .signal_one_shot(rst_one_shot)
);

debouncer_one_shot #(.INVERT_LOGIC(1)) DEB_ONE_SHOT_CLEAR (
    .clk(clk),
    .signal(clear_btn),
    .signal_one_shot(clear_one_shot)
);

clock_divider #(.FREQ(FREQ)) CLOCK_DIVIDER (
    .clk(clk),
    .rst(rst_one_shot),
    .clk_div(clk_div)
);

up_down_counter_parallel_load #(.COUNT_SIZE(BIT_SIZE), .DATA_IN_SIZE(DATA_IN_SIZE)) UP_DOWN_COUNTER_PARALLEL_LOAD (
	.clk(clk_div),
	.clear(clear_one_shot),
	.up_down(up_down),
	.data_in(data_in),
	.load(load),
	.enable(enable),
	.count(count),
	.c_out(c_out)
);

display_module #(.BIT_SIZE(BIT_SIZE)) DISPLAY_MODULE (
    .number(count),
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares)
);

endmodule