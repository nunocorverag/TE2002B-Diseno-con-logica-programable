`timescale 1ns/1ps

module counter_tb;
    parameter SEGMENTOS = 7;
    parameter BIT_SIZE = 20;
    parameter FREQ = 12_500_000;
    parameter DATA_IN_SIZE = 6;
    parameter INVERT_RST = 0;
    parameter INVERT_CLEAR = 0;
    parameter DEBOUNCE_THRESHOLD = 10;
    
    reg clk;
    reg rst_btn;
    reg clear_btn;
    reg enable;
    reg up_down;
    reg load;
    reg [DATA_IN_SIZE-1:0] data_in;
    wire [0:SEGMENTOS-1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares;
    
    counter #(.SEGMENTOS(SEGMENTOS), .BIT_SIZE(BIT_SIZE), .FREQ(FREQ), .DATA_IN_SIZE(DATA_IN_SIZE), .INVERT_RST(INVERT_RST), .INVERT_CLEAR(INVERT_CLEAR), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DUT (
        .clk(clk),
        .rst_btn(rst_btn),
        .clear_btn(clear_btn),
        .enable(enable),
        .up_down(up_down),
        .load(load),
        .data_in(data_in),
        .D_decenas(D_decenas),
        .D_unidades(D_unidades),
        .D_centenas(D_centenas),
        .D_millares(D_millares),
        .D_decenas_millares(D_decenas_millares),
        .D_centenas_millares(D_centenas_millares)
    );
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_btn = 0;
        clear_btn = 0;
        enable = 0;
        up_down = 0;
        load = 0;
        data_in = 6'd0;
        up_down = 1;

        #5000 
        clear_btn = 1;
        rst_btn = 1;
        
        #2000
        clear_btn = 0;
        rst_btn = 0;
        
        #1000
        enable = 1;
        
        #5000
        up_down = 0;

        #5000 
        up_down = 0;
        
        #5000
        
        load = 1;
        data_in = 6'd25;

        #1000
        load = 0;
        
        #5000
        clear_btn = 1;

        #1000
        clear_btn = 0;
        
        #2000
        
        $stop;
    end
    
endmodule
