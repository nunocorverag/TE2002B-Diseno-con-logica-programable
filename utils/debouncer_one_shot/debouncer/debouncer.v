/*
    debouncer.v

    Descripción:
    ------------
    Este módulo implementa un **debouncer digital**, eliminando el ruido y los rebotes 
    en señales mecánicas. Filtra la señal de entrada `debouncer_in` y 
    genera una salida estable `debouncer_out` solo cuando la entrada ha sido estable 
    por `N_MAX` ciclos de reloj.

    Funcionamiento:
    ---------------
    - Usa el módulo `counter_debouncer` para contar ciclos de reloj.
    - Si la señal `debouncer_in` cambia antes de `N_MAX`, el contador se reinicia.
    - Si `debouncer_in` se mantiene constante por `N_MAX` ciclos, `debouncer_out` se actualiza.
    - Si `rst_a_p` está en alto, `debouncer_out` se resetea a 0.
*/


module debouncer #(parameter N_MAX = 5000, INVERT_LOGIC = 0)(
	input clk, 					// Señal de reloj (sincroniza el debounce)
		  rst_a_p,				// Señal de reset (borra la salida si se activa)
		  debouncer_in,			// Entrada (Señal Mecánica)
	output reg debouncer_out	// Salida limpia (Señal de entrada estable y sin rebotes)
);

// Señales internas
wire [ceillog2(N_MAX) - 1: 0] counter_out; // Contador de estabilidad de la señal
wire counter_match;						  // Señal de estabilidad
wire debouncer_in_processed;
assign debouncer_in_processed = (INVERT_LOGIC) ? ~debouncer_in : debouncer_in; // Inversión de la lógica

// Instancia del contador que mide estabilidad de la señal de entrada
counter_debouncer #(.N_MAX(N_MAX)) CONTADOR_PARA_RATE(
	.clk(clk),
	.rst_a_p(rst_a_p),
	.counter_out(counter_out),
	.counter_match(counter_match)
);

// Lógica del debounce
always @(posedge counter_match or posedge rst_a_p)
begin
	if(rst_a_p)
	  debouncer_out <= 0; // Reinicia la salida si el reset está activado
	else
	begin
	  	if(counter_match)
	  		debouncer_out <= debouncer_in_processed; 	// Actualiza la salida si la señal fue estable
		else
			debouncer_out <= debouncer_out; // Mantiene el estado actual
	end
end

// Función para calcular el número de bits necesarios para el contador
function integer ceillog2;
	input integer data;
	integer i, result;
	begin
		for(i = 0; 2**i < data; i = i + 1)
			result = i + 1;
		ceillog2 = result;
	end
	
endfunction
endmodule