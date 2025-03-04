`timescale 1ns / 100ps

module pwm_tb;

// Señales de prueba
reg pb_inc, pb_dec, clk, rst;
wire pwm_out;

// Instanciación del módulo PWM
pwm #(.FREQ(50_000_000)) DUT (
    .pb_inc(pb_inc),
    .pb_dec(pb_dec),
    .clk(clk),
    .rst(rst),
    .pwm_out(pwm_out)
);

// Generación del reloj de 50 MHz (Período = 20ns)
always #10 clk = ~clk;

initial begin
    // Inicialización
    clk = 0;
    rst = 1;
    pb_inc = 0;
    pb_dec = 0;
    
    // Reset por 50 ns
    #50 rst = 0;

    // Incrementar el duty cycle
    #100 pb_inc = 1;
    #20 pb_inc = 0;

    // Esperar y ver PWM
    #500;

    // Disminuir el duty cycle
    #100 pb_dec = 1;
    #20 pb_dec = 0;

    // Esperar y ver PWM
    #500;

    // Más incrementos
    #100 pb_inc = 1;
    #20 pb_inc = 0;
    #100 pb_inc = 1;
    #20 pb_inc = 0;

    // Esperar un poco más
    #1000;

    // Fin de simulación
    $stop;
end

endmodule
