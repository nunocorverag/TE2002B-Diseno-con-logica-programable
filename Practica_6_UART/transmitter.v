// Transmisor
module transmitter#(parameter INVERT_RST = 0, DEBOUNCE_THRESHOLD = 5000)(
	input [7:0] data,
	input send_data,
	input clk,
	input rst,
	input [1:0] parity_type, // 0: Sin paridad, 1: Paridad impar, 2: Paridad par
	output reg serial_out
);

wire one_shot_rst;

localparam base_freq = 50_000_000;
// Quiero una señal que este a cierto baud rate
// Quiero saber cuantos ciclos de reloj de 50MHz me dan 115_200
localparam baudrate = 115_200;

localparam counts_per_bit = base_freq / baudrate;

// FALTA EL ESTADO DE PARIDAD
localparam TX_IDLE = 0;
localparam TX_START = 1;
localparam TX_DATA = 2;
localparam TX_PARITY = 3;
localparam TX_STOP = 4;

reg [2:0] active_state;
reg [31:0] clock_ctr; // Contador de ciclos
reg [7:0] d_idx; // Indice de input data para saber que bit estamos usando
reg [1:0] parity_type_reg; // Registro para alimentar la paridad seleccioanda
reg parity_bit;        // Bit de paridad calculado

debouncer_one_shot #(.INVERT_LOGIC(INVERT_RST), .DEBOUNCE_THRESHOLD(DEBOUNCE_THRESHOLD)) DEB_ONE_SHOT_RST (
    .clk(clk),
    .signal(rst),
    .signal_one_shot(one_shot_rst)
);

always @(posedge clk or posedge one_shot_rst) 
	begin
		if (one_shot_rst) 
			begin
				active_state <= TX_IDLE;
				serial_out <= 1;
				clock_ctr <= 0;
				d_idx <= 0;
				parity_type_reg <= 0;
			end
		else if (active_state == TX_IDLE)
			if (^parity_type === 1'bX || parity_type === 3)  
				parity_type_reg <= 0;  
			else
				parity_type_reg <= parity_type;
		case (active_state)
			TX_IDLE: 
				begin
					serial_out <= 1;
					clock_ctr <= 0;
					if(send_data)
						active_state <= TX_START;
					else
						active_state <= TX_IDLE;
				end 
			TX_START: 
				begin
					// Generar flanco de bajada
					// No se si ponerle el = o el <=
					serial_out <= 0;
					if(clock_ctr < counts_per_bit - 1)
						begin
							clock_ctr <= clock_ctr + 1;
							active_state <= TX_START;
						end
					else
						begin
							clock_ctr <= 0;
							active_state <= TX_DATA;
						end
				end 
			TX_DATA:
				begin
					serial_out <= data[d_idx];
					if(clock_ctr < counts_per_bit - 1)
						begin
							clock_ctr <= clock_ctr + 1;
							active_state <= TX_DATA;	
						end
					else
						begin
						// ¿Por qué `d_idx < 7` es mejor que `d_idx == 7`?
						// - En Verilog, todas las asignaciones `<=` ocurren en paralelo al final del ciclo de reloj.
						// - Si usamos `if (d_idx == 7)`, la comparación se hace con el valor **del ciclo anterior**.
						//   Esto significa que `TX_PARITY` podría activarse **antes de que el último bit de `data` 
						//   se haya transmitido completamente**, ya que `d_idx` se reinicia a `0` en el mismo ciclo.
						//
						// - Con `if (d_idx < 7)`, la condición se evalúa **antes de incrementar `d_idx`**, lo que 
						//   garantiza que `TX_DATA` complete correctamente los 8 bits antes de cambiar de estado.
						//
						// - Esto evita un problema en el que `TX_PARITY` recibe `d_idx = 0` prematuramente y
						//   puede generar errores en la transmisión.
						//
						// Si un valor cambia dentro del mismo bloque `always`, es más seguro 
						//   comparar con `<` en lugar de `==` para evitar efectos de concurrencia en hardware.**

							clock_ctr <= 0;
							if (d_idx < 7)
								begin
									d_idx <= d_idx + 1;
									active_state <= TX_DATA;
								end
							else
								begin
									d_idx <= 0;
									if (parity_type_reg == 0) 
										active_state <= TX_STOP;
									else
										active_state <= TX_PARITY;
								end
						end
				end
			TX_PARITY:
				begin
					parity_bit = ^data;
					
					if (parity_type_reg  == 1)  // Paridad impar
						serial_out <= ~parity_bit;
					else if (parity_type_reg  == 2) // Paridad par
						serial_out <= parity_bit;

					if (clock_ctr < counts_per_bit - 1)
						begin
							clock_ctr <= clock_ctr + 1;
							active_state <= TX_PARITY;
						end
					else
						begin
							clock_ctr <= 0;
							active_state <= TX_STOP;
						end
				end
			TX_STOP: 
				begin
					serial_out <= 1;
					if( clock_ctr < counts_per_bit - 1)
						begin
							clock_ctr <= clock_ctr + 1;
							active_state <= TX_STOP;
						end
					else
						active_state <= TX_IDLE;
				end
		endcase	
	end

endmodule