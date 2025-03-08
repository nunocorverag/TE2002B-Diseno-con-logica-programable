`timescale 1ns / 100ps

module pwm_tb();

reg pb_inc, pb_dec, clk, rst;
wire pwm_out;
wire [9:0] leds;

pwm #(.FREQ(25_000_000), .INVERT_INC(0), .INVERT_DEC(0), .INVERT_RST(0), .DEBOUNCE_THRESHOLD(10)) DUT (
    .pb_inc(pb_inc),
    .pb_dec(pb_dec),
    .clk(clk),
    .rst(rst),
    .pwm_out(pwm_out),
    .leds(leds)
);

always #10 clk = ~clk;

initial begin
    clk = 0;
    rst = 0;
    pb_inc = 0;
    pb_dec = 0;
    
    #5000 rst = 1;
    #5000 rst = 0;
    
    #20_000_000;

    repeat (5) begin
        #1000000 pb_inc = 1;
        #1000000 pb_inc = 0;
    end

    #20_000_000;

    repeat (5) begin
        #1000000 pb_dec = 1;
        #1000000 pb_dec = 0;
    end
	 
    #20_000_000;

    repeat (7) begin
        #1000000 pb_inc = 1;
        #1000000 pb_inc = 0;
    end

    #20_000_000;

    repeat (12) begin
        #1000000 pb_dec = 1;
        #1000000 pb_dec = 0;
    end


    #20_000_000;
    $stop;
end

endmodule