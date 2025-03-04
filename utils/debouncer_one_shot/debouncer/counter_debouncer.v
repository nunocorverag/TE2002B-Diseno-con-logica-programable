/* 
    counter_debouncer.v

    Descripción:
    ------------
    Este módulo implementa un **contador** que mide cuánto tiempo la señal de entrada
    se mantiene estable. Se usa dentro del módulo `debouncer` para detectar si la
    señal ha estado sin cambios durante `N_MAX` ciclos de reloj.

    Funcionamiento:
    ---------------
    - Cada ciclo de reloj (`clk`), el contador (`counter_out`) incrementa su valor.
    - Si la señal `rst_a_p` se activa, el contador se reinicia.
    - Cuando el contador llega a `N_MAX`, se activa la señal `counter_match`, 
      indicando que la señal ha sido estable por suficiente tiempo.
    - Si `counter_out` aún no ha alcanzado `N_MAX`, sigue contando.

    Parámetro configurable:
    -----------------------
    - `N_MAX = 5000` significa que el sistema espera 5000 ciclos de reloj antes de 
      considerar la señal como estable.
    - El tiempo total de espera depende de la frecuencia del reloj (`clk`).
    - Si la frecuencia del reloj (`clk`) es de **50 MHz** (En caso de la tarjeta DE10-Lite de Intel), significa que hay **50,000,000 ciclos por segundo**.
    - Para calcular cuánto tiempo representan 5000 ciclos en este reloj, usamos la fórmula:

        Tiempo (segundos) = Número de ciclos / Frecuencia del reloj

        Tiempo = 5000 ciclos / 50,000,000 ciclos/segundo
               = 0.0001 segundos
               = 0.1 milisegundos (ms)
               = 100 microsegundos (µs)

    - Esto significa que con `N_MAX = 5000`, el debounce dura **0.1 ms (100 µs)**, 
*/

module counter_debouncer #(parameter N_MAX = 5000)(
	input clk,                                          // Señal de reloj (sincroniza el debounce)
          rst_a_p,                                      // Señal de reset (borra la salida si se activa)
	output reg [ceillog2(N_MAX) - 1: 0] counter_out,    // Valor del contador
    output reg counter_match                            // Señal que indica si la entrada ha sido estable por N_MAX ciclos
);

// Lógica del contador
always @(posedge clk or posedge rst_a_p) //Depende de los flancos de subida del reloj
begin
    if(rst_a_p)
    begin
        counter_out <= 0;   // Reinicia el contador y la señal de estabilidad en caso de reset
        counter_match <= 0;
    end
    else
    begin
        if(counter_out >= N_MAX - 1) // Si el contador llega a N_MAX entonces:
        begin
            counter_out <= 0;   // Reinicia el contador
            counter_match <= 1; // Activa la señal de estabilidad
        end
        else
        begin
            counter_out <= counter_out + 1; // Incremento de contador
            counter_match <= 0;             // Mantiene la señal de estabilidad en 0
        end
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