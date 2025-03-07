`timescale 1ns/ 100ps

module password_top_tb();

//Parametros
localparam CLOCK_PERIOD = 20;       // 20ns = 50 MHz

localparam DIG_1 = 2;
localparam DIG_2 = 0; 
localparam DIG_3 = 1; 
localparam DIG_4 = 6; 
localparam WIRE_SIZE = 4; 
localparam SEGMENTOS = 7;
localparam BIT_SIZE = 10;
localparam INVERT_RST = 0;
localparam INVERT_SW = 0;
localparam DEBOUNCE_THRESHOLD = 10;

reg clk, rst;
reg [9:0] sw;
wire [0: SEGMENTOS - 1] HEX_0, HEX_1, HEX_2, HEX_3, HEX_4, HEX_5;

password_top #(
    .DIG_1(DIG_1), 
    .DIG_2(DIG_2), 
    .DIG_3(DIG_3), 
    .DIG_4(DIG_4), 
    .WIRE_SIZE(WIRE_SIZE), 
    .SEGMENTOS(SEGMENTOS),
    .BIT_SIZE(BIT_SIZE),
    .INVERT_RST(INVERT_RST),
    .INVERT_SW(INVERT_SW),
    .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)
) DUT (
    .clk(clk),
    .rst(rst),
    .sw(sw),
    .HEX_0(HEX_0),
    .HEX_1(HEX_1),
    .HEX_2(HEX_2),
    .HEX_3(HEX_3),
    .HEX_4(HEX_4),
    .HEX_5(HEX_5)
);

always #(CLOCK_PERIOD/2) clk <= ~clk;

initial 
    begin
        rst = 0;
        clk = 0;
        sw = 0;
        #5000;
        rst = 1;
        #5000;
        rst = 0;
        
        // CORRECT
        sw[2] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[0] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[1] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[6] = 1;
        #5000;
        sw = 0;
        #5000;
        
        // INCORRECT 4TH
        sw[2] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[0] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[1] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[2] = 1;
        #5000;
        sw = 0;
        #5000;

        // INCORRECT 3RD
        sw[2] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[0] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[2] = 1;
        #5000;
        sw = 0;
        #5000;

        // INCORRECT 2ND
        sw[2] = 1;
        #5000;
        sw = 0;
        #5000;
        sw[1] = 1;
        #5000;
        sw = 0;
        #5000;

        // INCORRECT 1ST
        sw[1] = 1;
        #5000;
        sw = 0;
        #5000;
        $stop;
    end
endmodule