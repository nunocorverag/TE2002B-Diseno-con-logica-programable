module pwm #(parameter FREQ = 1000)(
    input pb_inc, pb_dec, clk, rst,
    output reg pwm_out
);

wire clk_div;
wire one_shot_pc_inc, one_shot_pb_dec;

reg [31:0] DC;
reg [31:0] counter;

parameter MIN_DC = 50_000;  // Minimo - 0°
parameter MAX_DC = 100_000; // Maximo - 180°
parameter STEP = 2_500;     // 5°

// Parametros para el duty cycle
parameter base_freq = 'd10_000_000;
parameter target_freq = 'd10;
parameter count = base_freq/target_freq;

// Reducir el reloj
clock_divider #(.FREQ(FREQ)) CLK_DIV_INST (
    .clk(clk), 
    .rst(rst), 
    .clk_div(clk_div)
);

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
		DC <= 75_000; // Posición inicial - 90°
    else if (one_shot_pb_dec)
        if (DC > MIN_DC) 
            DC <= DC - STEP;
    else if (one_shot_pc_inc)
        if (DC < MAX_DC) 
            DC <= DC + STEP;
end

// Comparar ciclo de trabajo y el periodo
// Generación de la señal PWM

// Contador de periodo
always @(posedge clk_div or posedge rst)
begin
    if (rst)
        counter <= 0;
    else if (counter >= count - 1)
        counter <= 0;
    else
        counter <= counter + 1;
end

always @(posedge clk_div or posedge rst)
begin
    if (rst)
        pwm_out <= 0;
    else
        pwm_out <= (counter < DC) ? 1 : 0;
end
	

endmodule