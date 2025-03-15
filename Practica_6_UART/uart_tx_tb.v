`timescale 1ns/100ps

module uart_tx_tb();

reg [7:0] data = 8'b11010010;
reg send_data = 0;
reg clk = 0;
reg rst = 1;
reg [1:0] parity_type;
wire serial_out;

uart_tx DUT(
    .inp_data(data),
    .send_data(send_data),
    .clk(clk),
    .rst(rst),
    .parity_type(parity_type),
    .output_data_serial(serial_out)
);

always #10 clk <= ~clk;

initial 
begin
    parity_type = 2;
    rst = 0;    
    #5000;
    rst = 1;
    #5000;
    rst = 0;
    #5000;
    send_data = 1;
end

endmodule
