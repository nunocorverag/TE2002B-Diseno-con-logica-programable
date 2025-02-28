module pwm (
    input pb_inc, pb_dec, clk, rst,
    output reg pwm_out
);

wire clk_div;
wire one_shot_pc_inc, one_shot_pb_dec;

reg [31:0] DC;
reg [31:0] X;

// Parametros para el duty cycle
parameter base_freq = 'd10_000_000;
parameter target_freq = 'd10;
parameter count = base_freq/target_freq;

// Reducir el reloj
clock_divider(clk, rst, clk_div);

// Debouncer
debouncer_one_shot #(.INVERT_LOGIC(1)) DEB_ONE_SHOT_PB_INC (
    .clk(clk_div),
    .signal(pb_inc),
    .signal_one_shot(one_shot_pc_inc)
);

debouncer_one_shot #(.INVERT_LOGIC(1)) DEB_ONE_SHOT_PB_DEC (
    .clk(clk_div),
    .signal(pb_dec),
    .signal_one_shot(one_shot_pb_dec)
);

// Generador de Duty Cycle
// Tenemos que tener el control de 2 cosas (2 alwys)
// 1: Duty Cycle
// 2: Dependiendo del Duty Cycle estamos arriba o abajo
always @(posedge clk_div or posedge rst)
begin
    if (rst)
        DC <= 0;
    else if (one_shot_pb_dec)
        DC <= DC - X;
    else if (one_shot_pc_inc)
        DC <= DC + X;
end

// Comparar ciclo de trabajo y el periodo
always @(posedge clk_div) 
begin
	begin
	end
end

// Generación de la señal PWM
always @(posedge clk_div)
begin
    if (DC < count / 2)
        pwm_out <= 1;
    else
        pwm_out <= 0;
end
	
	

endmodule