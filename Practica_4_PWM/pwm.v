module pwm #(parameter FREQ = 25_000_000, INVERT_INC = 1, INVERT_DEC = 1, INVERT_RST = 0, DEBOUNCE_THRESHOLD = 5000)(
    input pb_inc, pb_dec, clk, rst,
    output reg pwm_out,
    output reg [9:0] leds
);

wire clk_div;
wire one_shot_pb_inc, one_shot_pb_dec, one_shot_rst;

reg [31:0] DC;
reg [31:0] counter;

localparam MIN_DC = 25_000;  // Minimo - 0°
localparam MAX_DC = 125_000; // Maximo - 180°
localparam STEP = 10_000;     // 5°

// Parametros para el duty cycle
localparam base_freq = 'd10_000_000;
localparam target_freq = 'd10;
localparam periodo = base_freq/target_freq;


// Debouncer
debouncer_one_shot #(.INVERT_LOGIC(INVERT_RST), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_RST (
    .clk(clk),
    .signal(rst),
    .signal_one_shot(one_shot_rst)
);

debouncer_one_shot #(.INVERT_LOGIC(INVERT_INC), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_PB_INC (
    .clk(clk),
    .signal(pb_inc),
    .signal_one_shot(one_shot_pb_inc)
);

debouncer_one_shot #(.INVERT_LOGIC(INVERT_DEC), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_PB_DEC (
    .clk(clk),
    .signal(pb_dec),
    .signal_one_shot(one_shot_pb_dec)
);

// Reducir el reloj
clock_divider #(.FREQ(FREQ)) CLOCK_DIVIDER (
    .clk(clk),
    .rst(rst_one_shot),
    .clk_div(clk_div)
);


// Generador de Duty Cycle
// Tenemos que tener el control de 2 cosas (2 alwys)
// 1: Duty Cycle
// 2: Dependiendo del Duty Cycle estamos arriba o abajo
// Control de LEDs
// Inicialización de LEDs
always @(posedge clk_div or posedge one_shot_rst) 
begin
    // if(clk_div)
    //     leds <= 10'b1000000000; // Solo el LED2 encendido (Reset)
    // else
        // leds <= 10'b0100000000; // Solo el LED2 encendido (Reset)
    if (one_shot_rst) 
        begin
            DC <= 75_000; // Posición inicial - 90°
            leds <= 10'b0000000100; // Solo el LED2 encendido (Reset)
        end 
    else 
        begin
            if (one_shot_pb_dec) 
                begin
                    if (DC > MIN_DC) 
                        DC <= DC - STEP;
                    leds <= 10'b0000000010; // Solo el LED2 encendido (Reset)
                end
            else if (one_shot_pb_inc)
                begin
                    if (DC < MAX_DC) 
                        DC <= DC + STEP;
                    leds <= 10'b0000000001; // Solo el LED2 encendido (Reset)
                end
        end
end

// Comparar ciclo de trabajo y el periodo
// Generación de la señal PWM

// Contador de periodo
always @(posedge clk or posedge one_shot_rst)
begin
  if (one_shot_rst) 
	begin
		counter <= 32'd0;
		pwm_out <= 1'b0;
  end
  else 
	begin
		// Incrementamos el contador
		counter <= counter + 32'd1;
		
		// Reiniciamos el contador al completar un periodo
		if (counter >= periodo)
			 counter <= 32'd0;
		
		// Generamos la salida PWM
		if (counter < DC)
			 pwm_out <= 1'b1;
		else
			 pwm_out <= 1'b0;
  end
end

// Comparar ciclo de trabajo y el periodo
// Generación de la señal PWM

// Contador de periodo
// always @(posedge clk_div or posedge one_shot_rst)
// begin
//     if (one_shot_rst)
//         counter <= 0;
//     else if (counter >= count - 1)
//         counter <= 0;
//     else
//         counter <= counter + 1;
// end

// always @(posedge clk_div or posedge one_shot_rst)
// begin
//     if (one_shot_rst)
//         pwm_out <= 0;
//     else
//         pwm_out <= (counter < DC) ? 1 : 0;
// end

endmodule