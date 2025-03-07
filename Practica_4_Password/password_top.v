module password_top #(
        parameter DIG_1 = 2, 
        DIG_2 = 0, 
        DIG_3 = 1, 
        DIG_4 = 6, 
        WIRE_SIZE = 4, 
        SEGMENTOS = 7, 
        BIT_SIZE = 10,
        INVERT_RST = 1,
        INVERT_SW = 0,
        DEBOUNCE_THRESHOLD = 5000

) (
    input clk, rst,
    input [9:0] sw,
    output [0: SEGMENTOS - 1] HEX_0, HEX_1, HEX_2, HEX_3, HEX_4, HEX_5
);

wire incorrect, done;
wire one_shot_rst;
wire [9:0] sw_one_shot;

genvar i;

// Gracias al begin : nombre, no necesitamos preocuparnos por que la instancia tenga un nombre unico
generate
    for (i = 0; i < 10 ; i = i + 1) 
    begin : debouncer_gen
        debouncer_one_shot #(.INVERT_LOGIC(INVERT_RST), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_SW(
            .clk(clk),
            .signal(sw[i]),
            .signal_one_shot(sw_one_shot[i])
        );
    end
endgenerate

debouncer_one_shot #(.INVERT_LOGIC(INVERT_RST), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_RST (
    .clk(clk),
    .signal(rst),
    .signal_one_shot(one_shot_rst)
);

password_fsm #(.DIG_1(DIG_1), .DIG_2(DIG_2), .DIG_3(DIG_3), .DIG_4(DIG_4)) PASSWORD_FSM(
    .clk(clk),
    .rst(one_shot_rst),
    .sw(sw),
    .sw_one_shot(sw_one_shot),
    .incorrect(incorrect),
    .done(done)
);

status_display STATUS_DISPLAY(
    .incorrect(incorrect),
    .done(done),
    .HEX_0(HEX_0),
    .HEX_1(HEX_1),
    .HEX_2(HEX_2),
    .HEX_3(HEX_3),
    .HEX_4(HEX_4),
    .HEX_5(HEX_5)
);

endmodule