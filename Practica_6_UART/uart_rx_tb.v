`timescale 1ns / 100ps
module uart_rx_tb();

// helper registers/wires
reg rst = 1;
reg clk = 0;
reg serial_data_in = 1;
reg [1:0] parity_type;
wire [7:0] rx_data; // Se corrigió el nombre del puerto de salida
wire parity_error;

// instantiate DUT
uart_rx DUT(  
    .serial_data_in(serial_data_in),
    .rst(rst),
    .clk(clk),
    .parity_type(parity_type),
    .rx_data(rx_data),
    .parity_error(parity_error)
);

//generate clock signal
always #10 clk <= ~clk; 
parameter clock_period = 20;
parameter baudrate = 'd115_200;
parameter base_clk = 'd50_000_000;
parameter clocks_per_bit = base_clk/baudrate;
parameter c_BIT_PERIOD_NS = clocks_per_bit * clock_period;

// define task for sending serial data with control over parity bit
task UART_WRITE_BYTE;
  input [7:0] i_Data;
  input parity_error_inject; // Flag to introduce parity error
  reg parity_bit;
  reg [0:10] serial_log; 
  integer ii;
  begin
    $display("Tiempo: %t | Enviando Byte: %h | Parity Type: %d", $time, i_Data, parity_type);
    
    // Start Bit
    serial_data_in <= 1'b0;
    serial_log[0] = serial_data_in;
    #(c_BIT_PERIOD_NS);
    
    // Data Bits
    for (ii = 0; ii < 8; ii = ii + 1) begin
      serial_data_in <= i_Data[ii];
      serial_log[ii+1] = i_Data[ii];
      #(c_BIT_PERIOD_NS);
    end

    // Parity Bit (if used)
    if (parity_type == 1) // Paridad impar
      parity_bit = ~(^i_Data);
    else if (parity_type == 2) // Paridad par
      parity_bit = (^i_Data);
    else
      parity_bit = 1'b0; // No parity

    if (parity_error_inject)
      parity_bit = ~parity_bit; // Introducir error de paridad

    if (parity_type != 0) begin
      serial_data_in <= parity_bit;
      serial_log[9] = serial_data_in;
      #(c_BIT_PERIOD_NS);
    end

    // Stop Bit
    serial_data_in <= 1'b1;
    serial_log[10] = serial_data_in;
    
    // Print entire serial transmission
    $display("Tiempo: %t | Serial Data Sent: %b", $time, serial_log);

    // Check for parity error
    if (parity_error)
      $display("ERROR: Parity Error detected at %t", $time);
    else
      $display("Transmission completed successfully at %t", $time);
    
    #(c_BIT_PERIOD_NS);
  end
endtask

initial begin
    rst = 0;
    #5000;
    rst = 1;
    #5000;
    rst = 0;
    #5000;

    // 1. Prueba con error de paridad impar
    parity_type = 1;
    @(posedge clk);
    UART_WRITE_BYTE(8'b00110110, 1); // Introduce error de paridad

    #5000;
    
    // 2. Prueba con paridad impar correcta
    @(posedge clk);
    UART_WRITE_BYTE(8'b11001100, 0); // Paridad correcta

    #5000;

    // 3. Prueba con error de paridad par
    parity_type = 2;
    @(posedge clk);
    UART_WRITE_BYTE(8'b10011001, 1); // Introduce error de paridad

    #5000;

    // 4. Prueba con paridad par correcta
    @(posedge clk);
    UART_WRITE_BYTE(8'b01010101, 0); // Paridad correcta

    #5000;

    // 5. Prueba sin paridad
    parity_type = 0;
    @(posedge clk);
    UART_WRITE_BYTE(8'b11110000, 0); // Sin paridad
	 
	 #5000;
	 $stop;

end
endmodule
