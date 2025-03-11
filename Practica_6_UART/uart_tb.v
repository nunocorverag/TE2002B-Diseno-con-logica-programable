`timescale 1ns/100ps

module uart_tb();

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
wire [9:0] leds;

// Instancia del módulo UART con parámetros adaptados
uart #(
    .DEBOUNCE_THRESHOLD(DEBOUNCE_TB), .INVERT_RST(1), .INVERT_SEND_DATA(1)
) DUT (
    .clk(clk),
    .rst(rst),
    .parity_type(parity_type),
	 
	 // Transmitter
    .data(data),
    .send_data(send_data),
    .serial_out(serial_out),
	 
	 // Receiver
    .serial_data_in(serial_out),

    //Display
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares),
	 
	 //LEDs
    .leds(leds)
);

// Generación de reloj
always #(CLOCK_PERIOD/2) clk = ~clk;

// Tarea para enviar un byte
task automatic send_byte;
    input [7:0] tx_data;
    input [1:0] p_type;
    begin
        data = tx_data;
        parity_type = p_type;
        // #(DEBOUNCE_TB * CLOCK_PERIOD);  // Espera debounce
        //send_data = 1; // Esto esta raro hay que ver como implementarlo luego bien
        
        // Espera según tipo de paridad
        if(p_type == 0) #(10 * BIT_TIME);  // Sin paridad
        else            #(11 * BIT_TIME);  // Con paridad
    end
endtask

// Tarea para verificar resultados
//task automatic check_result;
//     input [7:0] expected_data;
//     input expected_error;
//     begin
//         // Acceso a las señales internas usando jerarquía de nombres
//         if(DUT.parallel_out !== expected_data) begin
//             $display("[ERROR] Tiempo %t: Dato recibido %h != Esperado %h",
//                     $time, DUT.parallel_out, expected_data);
//         end
//         else begin
//             $display("[OK] Tiempo %t: Dato correcto %h",
//                     $time, DUT.parallel_out);
//         end
        
//         if(DUT.parity_error !== expected_error) begin
//             $display("[ERROR] Tiempo %t: Error de paridad %b != Esperado %b",
//                     $time, DUT.parity_error, expected_error);
//         end
//         else begin
//             $display("[OK] Tiempo %t: Estado paridad correcto",
//                     $time);
//         end
//     end
// endtask

// Secuencia de prueba
initial begin
    // Reset inicial
	 clk = 0;
    rst = 1;
	 send_data = 1;
    #5000;
	 // RST EN 1 AL PARECER NO HACE NADA
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
    // check_result(8'hA5, 0);
    
	 send_data = 0;
    #5000;
	 send_data = 1;
    #5000;
	 
    // Test 2: Paridad par correcta
    $display("\nTest 2: Paridad par (4 bits '1')");
    send_byte(8'hAA, 2);  // 8'b10101010 (4 unos)
    // check_result(8'hAA, 0);
    
	 send_data = 0;
    #5000;
	 send_data = 1;
    #5000;
	 
    // Test 3: Paridad par incorrecta
    $display("\nTest 3: Paridad par (5 bits '1')");
    send_byte(8'hAB, 2);  // 8'b10101011 (5 unos)
    // check_result(8'hAB, 1);
    
	 send_data = 9;
    #5000;
	 send_data = 1;
    #5000;
	 
    // Test 4: Paridad impar correcta
    $display("\nTest 4: Paridad impar (5 bits '1')");
    send_byte(8'hAB, 1);  // 8'b10101011 (5 unos)
    // check_result(8'hAB, 0);
   
	 send_data = 0;
    #5000;
	 send_data = 1;
    #5000;
	 
    // Test 5: Paridad impar incorrecta
    $display("\nTest 5: Paridad impar (4 bits '1')");
    send_byte(8'hAA, 1);  // 8'b10101010 (4 unos)
    // check_result(8'hAA, 1);

    // Finalizar simulación
    #100;
    $display("\nSimulación completada");
    $stop;
end

endmodule