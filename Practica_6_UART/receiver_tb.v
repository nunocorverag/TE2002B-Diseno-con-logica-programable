`timescale 1ns / 100ps
module receiver_tb();

// helper registers/wires
reg rst = 1;
reg clk = 0;
reg serial_data_in = 1;
reg [1:0] parity_type;
wire [7:0] parallel_out;
wire parity_error;

// instantiate DUT
receiver #(.INVERT_RST(0), .DEBOUNCE_THRESHOLD(10)) DUT(
.serial_data_in(serial_data_in),
.rst(rst),
.clk(clk),
.parity_type(parity_type),
.parallel_out(parallel_out),
.parity_error(parity_error)
);

//generate clock signal
always #10 clk <= ~clk; 
parameter clock_period = 20;
parameter baudrate = 'd115_200;
parameter base_clk = 'd50_000_000;
parameter clocks_per_bit = base_clk/baudrate;
parameter c_BIT_PERIOD_NS = clocks_per_bit * clock_period;
// define task for sending serial data

task UART_WRITE_BYTE;
  input [7:0] i_Data;
  reg [0:10] serial_log; // Store transmitted bits (1 start bit + 8 data + 1 parity + 1 stop bit)
  integer     ii;
  begin
  $display("Tiempo: %t | Enviando Byte: %h | Parity Type: %d", $time, i_Data, parity_type);
  // Send Start Bit
  serial_data_in <= 1'b0;
  serial_log[0] = serial_data_in;  // Store start bit
  #(c_BIT_PERIOD_NS);
  // Send Data Byte
  for (ii=0; ii<8; ii=ii+1)
    begin
      serial_data_in <= i_Data[ii];
      serial_log[ii+1] = i_Data[ii]; // Store data bit
      #(c_BIT_PERIOD_NS);
    end
  // Send Parity Bit
    if (parity_type == 1 || parity_type == 2)
      serial_data_in <= 1'b1;
      serial_log[9] = serial_data_in; // Store parity bit
      #(c_BIT_PERIOD_NS);
  // Send Stop Bit
  serial_data_in <= 1'b1;
  serial_log[10] = serial_data_in; // Store stop bit
  // Print entire serial transmission
  $display("Tiempo: %t | Serial Data Sent: %b", $time, serial_log);

  // Check for parity error
  if (parity_error)
    $display("ERROR: Parity Error detected at %t", $time);
  else
    $display("Transmission completed successfully at %t", $time);
  #(c_BIT_PERIOD_NS);
    end
endtask // UART_WRITE_BYTE

initial
  begin
	 parity_type = 0;
    rst = 0;
    # 5000;
    rst = 1;
    # 5000;
    rst = 0;
    // Si no le damos suficiente tiempo, parity como que se suma o hay perdidas de bits parece ser
    // Porque sucede esto?
    # 5000;
    @(posedge clk);
    UART_WRITE_BYTE(8'b00110110); // 0x36 -> 54 --> Paridad par
    @(posedge clk);
    # 5000;
    @(posedge clk);
    UART_WRITE_BYTE(8'b11111111); // 0xFF -> 255 --> Paridad par
    @(posedge clk);
    # 5000;
    @(posedge clk);
    UART_WRITE_BYTE(8'b11111110); // 0xFE -> 254 --> Aunque sea numero par, su paridad es impar
    @(posedge clk);
    # 5000;
    @(posedge clk);
    UART_WRITE_BYTE(8'b11111101); // 0xFD -> 253 --> Paridad impar
    @(posedge clk);
    // # 5000;
    // @(posedge clk);
    // UART_WRITE_BYTE(8'b11111111);
    // @(posedge clk);
    // # 5000;
    // @(posedge clk);
    // UART_WRITE_BYTE(8'b11111111);
    // @(posedge clk);
    // # 5000;
    // @(posedge clk);
    // UART_WRITE_BYTE(8'b11111111);
    // @(posedge clk);
    // # 5000;
    // @(posedge clk);
    // UART_WRITE_BYTE(8'b11111111);
    // @(posedge clk);
    // # 5000;
    // @(posedge clk);
    // UART_WRITE_BYTE(8'b11111111);
    // @(posedge clk);

  end
endmodule