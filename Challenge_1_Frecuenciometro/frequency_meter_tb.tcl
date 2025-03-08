`timescale 1ns / 1ps

module tb_frequency_meter;

    // Parámetros del reloj
    reg clk;
    reg rst;
    reg signal_in;
    
    // Salidas del frecuenciómetro
    wire [6:0] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares;

    // Instanciar el módulo a probar (DUT - Device Under Test)
    frequency_meter DUT (
        .clk(clk),
        .rst(rst),
        .signal_in(signal_in),
        .D_decenas(D_decenas),
        .D_unidades(D_unidades),
        .D_centenas(D_centenas),
        .D_millares(D_millares),
        .D_decenas_millares(D_decenas_millares),
        .D_centenas_millares(D_centenas_millares)
    );

    // Generar el reloj de 50 MHz (Período = 20 ns)
    always #10 clk = ~clk;

    // Generar señal de entrada con diferentes frecuencias
    initial begin
        // Inicializar señales
        clk = 0;
        rst = 1;
        signal_in = 0;
        #100 rst = 0; // Desactivar reset

        // Primera frecuencia de prueba: 1 kHz (Período = 1 ms)
        repeat (10) begin
            #500000 signal_in = ~signal_in;
        end

        // Segunda frecuencia de prueba: 10 kHz (Período = 100 us)
        repeat (10) begin
            #50000 signal_in = ~signal_in;
        end

        // Tercera frecuencia de prueba: 100 kHz (Período = 10 us)
        repeat (20) begin
            #5000 signal_in = ~signal_in;
        end

        // Detener simulación
        #1000000;
        $finish;
    end

    // Monitorear la frecuencia calculada
    initial begin
        $monitor("Time: %0t | signal_in: %b | Frecuencia detectada: %d Hz", 
                 $time, signal_in, DUT.frequency);
    end

endmodule
