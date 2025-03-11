module uart_rx(
	input rst,
	input clk,
	input serial_data_in,
	output [7:0] rx_data,
    output reg [7:0] leds
);
 
// define states
parameter baudrate = 'd115_200;
parameter base_clk = 'd50_000_000;
parameter clocks_per_bit = base_clk/baudrate;
 
localparam RX_IDLE_STATE 		= 2'b00;
localparam RX_START_BIT_STATE = 2'b01;
localparam RX_DATA_RX_STATE 	= 2'b10;
localparam RX_STOP_BIT_STATE 	= 2'b11;
 
reg [1:0] active_state 	= RX_IDLE_STATE;
reg [31:0] ctr_clk 		= 0;
reg [2:0] rx_idx 			= 0;
reg [7:0] reg_rx_data 	= 0;
 
always @(posedge clk or negedge rst)
begin
	if (~rst)
		begin
			active_state <= RX_IDLE_STATE;
			reg_rx_data <= 0;
		end
	else
		begin
			case (active_state)
			RX_IDLE_STATE:
				begin
					rx_idx <= 0;
					ctr_clk <= 0;
					leds <= reg_rx_data;
					if (serial_data_in == 1'b0)
						active_state <= RX_START_BIT_STATE;
					else
						active_state <= RX_IDLE_STATE;
				end //end RX_IDLE_STATE
			RX_START_BIT_STATE:
				begin
					if (ctr_clk == (clocks_per_bit - 1)/2)
						begin
							if (serial_data_in == 1'b0)
								begin
									active_state <= RX_DATA_RX_STATE;
									ctr_clk <= 0;
								end
							else
								active_state <= RX_IDLE_STATE; // error in transmission
						end
					else
						begin
							ctr_clk <= ctr_clk + 1;
							active_state <= RX_START_BIT_STATE;
						end
				end // end RX_START_BIT_STATE
			RX_DATA_RX_STATE:
				begin
					if (ctr_clk < clocks_per_bit - 1)
						begin
							ctr_clk <= ctr_clk + 1;
							active_state <= RX_DATA_RX_STATE;
						end
					else
						begin
							ctr_clk <= 0;
							reg_rx_data[rx_idx] <= serial_data_in;
							if (rx_idx < 7)
								begin
									rx_idx <= rx_idx + 1;
									active_state <= RX_DATA_RX_STATE;
								end
							else
								begin
									active_state <= RX_STOP_BIT_STATE;
								end
						end
				end // end RX_DATA_RX_STATE
			RX_STOP_BIT_STATE:
				begin
					if (ctr_clk < clocks_per_bit - 1)
						begin
							active_state <= RX_STOP_BIT_STATE;
							ctr_clk <= ctr_clk + 1;
						end
					else
						active_state <= RX_IDLE_STATE;
				end // end RX_STOP_BIT_STATE
			default:
				active_state <= RX_IDLE_STATE;
			endcase
		end // end else
end
 
assign rx_data = reg_rx_data;
endmodule