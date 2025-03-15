`timescale 1ns/100ps

module uart_top_tb();

// Parámetros de configuración
localparam CLOCK_PERIOD = 20;       // 20ns = 50 MHz
localparam BASE_FREQ    = 50_000_000;
localparam BAUDRATE     = 115_200;
localparam COUNTS_PER_BIT = BASE_FREQ / BAUDRATE;
localparam BIT_TIME     = COUNTS_PER_BIT * CLOCK_PERIOD;
localparam DEBOUNCE_TB  = 5;       // Umbral reducido para simulación
localparam SEGMENTOS = 7;

// Señales de entrada/salida
reg clk;
reg rst;
reg send_data;
reg [7:0] data = 0;
reg [1:0] parity_type = 0;

wire serial_out;
wire [0: SEGMENTOS - 1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares;
wire [1:0] parity_leds;
wire [7:0] rx_data;  // Nueva señal para capturar la salida del receptor

// Instancia del módulo UART con parámetros adaptados
uart_top #(
    .DEBOUNCE_THRESHOLD(DEBOUNCE_TB), .INVERT_RST(1), .INVERT_SEND_DATA(1)
) DUT (
    .clk(clk),
    .rst(rst),
    .parity_type_sw(parity_type),
	 
    // Transmitter
    .inp_data(data),
    .send_data(send_data),
    .output_data_serial(serial_out),
	 
    // Receiver
    .serial_data_in(serial_out),

    // Display
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares),

    // Paridad
    .parity_leds(parity_leds)
);

assign rx_data = DUT.UART_RX.rx_data;

// Generación de reloj
always #(CLOCK_PERIOD/2) clk = ~clk;

// Tarea para enviar un byte
task automatic send_byte;
    input [7:0] tx_data;
    input [1:0] p_type;
    begin
        data = tx_data;
        parity_type = p_type;
        
        if(p_type == 0) #(10 * BIT_TIME);  // Sin paridad
        else            #(11 * BIT_TIME);  // Con paridad
    end
endtask

// Tarea para verificar resultados
task automatic check_result;
    input [7:0] expected_data;
    input expected_error;
    begin
        #1000;
        
        // Verificación del dato recibido
        if (rx_data !== expected_data) begin
            $display("[ERROR] Tiempo %t: Dato recibido %h != Esperado %h",
                    $time, rx_data, expected_data);
        end else begin
            $display("[OK] Tiempo %t: Dato correcto %h",
                    $time, rx_data);
        end
    end
endtask

// Secuencia de prueba
initial begin
    // Reset inicial
    clk = 0;
    rst = 1;
    send_data = 1;
    #5000;
    rst = 0;
    #5000;
    rst = 1;
    send_data = 0;
    #5000;
    send_data = 1;
    #5000;

    // Test 1: Sin paridad
    $display("\nTest 1: Transmisión sin paridad");
    send_byte(8'hA5, 0);
    check_result(8'hA5, 0);
    #(BIT_TIME * 5);

    send_data = 0;
    #5000;
    send_data = 1;
    #5000;
	 
    // Test 2: Paridad par
    $display("\nTest 2: Paridad par");
    send_byte(8'hAA, 2);
    check_result(8'hAA, 0);
    #(BIT_TIME * 5);

    send_data = 0;
    #5000;
    send_data = 1;
    #5000;
	 
    // Test 3: Paridad par
    $display("\nTest 3: Paridad par");
    send_byte(8'hAB, 2);
    check_result(8'hAB, 1);
    #(BIT_TIME * 5);

    send_data = 9;
    #5000;
    send_data = 1;
    #5000;
	 
    // Test 4: Paridad impar
    $display("\nTest 4: Paridad impar");
    send_byte(8'hAB, 1);
    check_result(8'hAB, 0);
    #(BIT_TIME * 5);

    send_data = 0;
    #5000;
    send_data = 1;
    #5000;
	 
    // Test 5: Paridad impar
    $display("\nTest 5: Paridad impar");
    send_byte(8'hAA, 1);
    check_result(8'hAA, 1);
    #(BIT_TIME * 5);
    
    // Finalizar simulación
    #100;
    $display("\nSimulación completada");
    $stop;
end

endmodule
