`timescale 1ns / 1ps

module frequency_meter_tb();

    reg clk;
    reg rst;
    reg signal_in;
    
    wire [6:0] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares;

    frequency_meter #(.INVERT_RST(0), .DEBOUNCE_THRESHOLD(10)) DUT (
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

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        signal_in = 0;
		#5000 rst = 1;
        #5000 rst = 0;
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
        $stop;
    end

    initial begin
        $monitor("Time: %0t | signal_in: %b | Frecuencia detectada: %d Hz", 
                 $time, signal_in, DUT.frequency);
    end

endmodule
