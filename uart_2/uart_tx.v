module uart_tx #(
    parameter CLOCKS_PER_BIT = 434,
                DATA_BITS = 8,
                CLOCK_CTR_WIDTH = 32,
                D_IDX_WIDTH = (DATA_BITS > 1) ? $clog2(DATA_BITS) : 1 // Que genere al menos 1
)(
    input clk,
    input rst,
    input send_data,
    input [DATA_BITS-1:0] inp_data,
	input [1:0] parity_type, // 0: Sin paridad, 1: Paridad impar, 2: Paridad par
    output reg output_data_serial
);
 
// STATES
localparam TX_IDLE_STATE = 3'b000;
localparam TX_START_BIT_STATE = 3'b001;
localparam TX_DATA_TX_STATE = 3'b010;
localparam TX_PARITY_TX_STATE = 3'b011;
localparam TX_STOP_BIT_STATE = 3'b100;
 
reg [2:0] active_state                     = TX_IDLE_STATE;
reg [D_IDX_WIDTH-1:0] tx_bit_idx           = 0;
reg [CLOCK_CTR_WIDTH-1:0] data_tx_count    = 0;

// Add
reg [1:0] parity_type_reg; // Registro para alimentar la paridad seleccioanda

// control state machine
always @(posedge clk or posedge rst)
begin
 
    if (rst)
        active_state <= TX_IDLE_STATE;
    else
        begin
            case (active_state)
           
            TX_IDLE_STATE:
                begin
                    // Add
                    if (parity_type === 2'b11 || parity_type === 2'b00)  
                        parity_type_reg <= 0;
                    else
                        parity_type_reg <= parity_type;

                    output_data_serial <= 1;
                    tx_bit_idx <= 0;
                    data_tx_count <= 0;
 
                    if (send_data)
                        active_state <= TX_START_BIT_STATE;
                    else
                        active_state <= TX_IDLE_STATE;
                end //end TX_IDLE_STATE
 
           
            TX_START_BIT_STATE:
                begin
                    output_data_serial <= 0;
                    if (data_tx_count < CLOCKS_PER_BIT - 1)
                        begin
                            data_tx_count <= data_tx_count + 1;
                            active_state <= TX_START_BIT_STATE;
                        end
                    else
                        begin
                            data_tx_count <= 0;
                            active_state <= TX_DATA_TX_STATE;
                        end
                end // end TX_START_BIT_STATE
 
            TX_DATA_TX_STATE:
                begin
                    // set line to high/low depending on input data tx
                    output_data_serial <= inp_data[tx_bit_idx];
                    if (data_tx_count < CLOCKS_PER_BIT - 1)
                        begin
                            data_tx_count <= data_tx_count + 1;
                            active_state <= TX_DATA_TX_STATE;
                        end
                    else
                        begin
                            data_tx_count <= 0;
                            if (tx_bit_idx < 7)
                                begin
                                    tx_bit_idx <= tx_bit_idx + 1;
                                    active_state <= TX_DATA_TX_STATE;
                                end
                            else
                                begin
                                    tx_bit_idx <= 0;
                                    if (parity_type_reg == 0) 
                                        active_state <= TX_STOP_BIT_STATE;
                                    else
                                        active_state <= TX_PARITY_TX_STATE;
                                end
                        end
                end // end TX_DATA_TX_STATE

			TX_PARITY_TX_STATE:
				begin					
					if (parity_type_reg  == 1)  // Paridad impar
						output_data_serial <= ~(^inp_data);
					else
						output_data_serial <= ^inp_data;

					if (data_tx_count < CLOCKS_PER_BIT - 1)
						begin
							data_tx_count <= data_tx_count + 1;
							active_state <= TX_PARITY_TX_STATE;
						end
					else
						begin
							data_tx_count <= 0;
							active_state <= TX_STOP_BIT_STATE;
						end
				end
           
            TX_STOP_BIT_STATE:
                begin
                    output_data_serial <= 1;
                    if (data_tx_count < CLOCKS_PER_BIT - 1)
                        begin
                            data_tx_count <= data_tx_count + 1;
                            active_state <= TX_STOP_BIT_STATE;
                        end
                    else
                        active_state <= TX_IDLE_STATE;
                end //end TX_STOP_BIT_STATE    
            default:
                active_state <= TX_IDLE_STATE;
        endcase
    end
end
 
endmodule