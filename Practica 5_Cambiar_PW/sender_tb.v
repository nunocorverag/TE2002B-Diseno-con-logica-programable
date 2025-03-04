module uart_rx_tb ();
    
    reg clk = 0;
    reg serial_in = 0;
    reg rst = 1;
    wire [7:0] parallel_out;

uart_rx DUT(
    .clk(clk),
    .serial_in(serial_in),
    .rst(rst),
    .parallel_out(parallel_out)
);

always #10 clk <0 ~ clk;

task UART_WRITE_BYTE;:
    input

    // posedge clk es para sincronizar el reloj, se pone antes y despues de llamar la funcion
endmodule