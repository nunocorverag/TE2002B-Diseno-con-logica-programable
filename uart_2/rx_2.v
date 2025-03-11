module uart_rx #(
    parameter CLOCKS_PER_BIT = 434,
                DATA_BITS = 8,
                CLOCK_CTR_WIDTH = 32
)(
	input rst,
	input clk,
	input serial_data_in,
	output [DATA_BITS-1:0] rx_data,
    output reg [DATA_BITS-1:0] leds
);
 
// define states 
localparam RX_IDLE_STATE 		= 2'b00;
localparam RX_START_BIT_STATE = 2'b01;
localparam RX_DATA_RX_STATE 	= 2'b10;
localparam RX_STOP_BIT_STATE 	= 2'b11;
 
localparam D_IDX_WIDTH = (DATA_BITS > 1) ? $clog2(DATA_BITS) : 1;

// TODO: Implement parity state
reg [1:0] active_state 	= RX_IDLE_STATE;
reg [D_IDX_WIDTH-1:0] rx_bit_idx 					= 0;
reg [CLOCK_CTR_WIDTH-1:0] data_rx_count 			= 0;

reg [DATA_BITS-1:0] reg_rx_data 								= 0;
 
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
					rx_bit_idx <= 0;
					data_rx_count <= 0;
					if (serial_data_in == 1'b0)
						active_state <= RX_START_BIT_STATE;
					else
						active_state <= RX_IDLE_STATE;
				end //end RX_IDLE_STATE
			RX_START_BIT_STATE:
				begin
					if (data_rx_count == (CLOCKS_PER_BIT - 1)/2)
						begin
							if (serial_data_in == 1'b0)
								begin
									active_state <= RX_DATA_RX_STATE;
									data_rx_count <= 0;
								end
							else
								active_state <= RX_IDLE_STATE; // error in transmission
						end
					else
						begin
							data_rx_count <= data_rx_count + 1;
							active_state <= RX_START_BIT_STATE;
						end
				end // end RX_START_BIT_STATE
			RX_DATA_RX_STATE:
				begin
					if (data_rx_count < CLOCKS_PER_BIT - 1)
						begin
							data_rx_count <= data_rx_count + 1;
							active_state <= RX_DATA_RX_STATE;
						end
					else
						begin
							data_rx_count <= 0;
							reg_rx_data[rx_bit_idx] <= serial_data_in;
							if (rx_bit_idx < 7)
								begin
									rx_bit_idx <= rx_bit_idx + 1;
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
					if (data_rx_count < CLOCKS_PER_BIT - 1)
						begin
							active_state <= RX_STOP_BIT_STATE;
							data_rx_count <= data_rx_count + 1;
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

always @(posedge clk or negedge rst) begin
	if(~rst)
        leds <= 0;
	else
		leds <= rx_data;
end

endmodule