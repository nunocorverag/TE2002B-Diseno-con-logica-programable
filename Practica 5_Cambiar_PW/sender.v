// Solo tenemos una entrada de 1 bit porque todo viene en la misma linea electrica
// El parallel_out es de 8 bits es porque el receptor es entrada serial y salida paralela
// Aqui vamos a contar a la mitad, porque?
module uart_rx(
    input clk,
    input serial_in,
    input rst,
    output [7:0] parallel_out
);

localparam baudrate = '115_200';
localparam base_freq = '50_000_000';
localparam clocks_per_bit = base_freq / baudrate;

localparam RX_IDLE  = 0;
localparam RX_START  = 1;
localparam RX_DATA  = 2;
localparam RX_STOP  = 3;

reg [1:0] active_state = RX_IDLE;
reg [31:0] clock_ctr = 0;
reg [2:0] d_idx = 0;

always @(posedge clk or negedge rst)
begin
    if (rst) 
        active_state <= RX_IDLE;
    else
        begin
          case (active_states)
            RX_IDLE:
                begin
                    d_idx <= 0;
                    clock_ctr <= 0;
                    if (serial_in == 0)
                        active_state <= RX_START;
                    else
                        active_state <= RX_IDLE;
                end
            RX_START:
                begin
                    if (clock_ctr <= (clocks_per_bit - 1) / 2)
                        begin
                            clock_ctr <= clock_ctr + 1;
                            active_state <= RX_START;
                        end
                    else
                        begin
                            active_state <= RX_START;
                            clock_ctr <= 0;
                        end
                end
            RX_DATA:
                begin
                    if (clock_ctr <= (clocks_per_bit - 1))
                        begin
                            clock_ctr <= clock_ctr + 1;
                            active_state <= RX_DATA;
                        end
                    else
                        begin
                            clock_ctr <= 0;
                            parallel_out[d_idx] <= serial_in;
                            if (d_idx < 7)
                                begin
                                    d_idx <= d_idx + 1;
                                    active_state <= RX_DATA;
                                end
                            else
                                active_state <= RX_STOP;

                        end
                end
            RX_STOP:
                begin
                    if (clock_ctr <= (clocks_per_bit - 1))
                        begin
                            clock_ctr <= clock_ctr + 1;
                            active_state <= RX_STOP;
                        end
                    else
                        begin
                            clock_ctr <= 0;
                            active_state <= RX_IDLE;
                        end
                end
            default: 
          endcase
        end
end

endmodule