module bcd_tb #(parameter WIRE_SIZE = 4, parameter SEGMENTOS = 7, BIT_SIZE=10, ITERACIONES = 10)();

reg [BIT_SIZE-1 : 0] bcd_in_sw;
wire [0: SEGMENTOS - 1] D_decenas, D_unidades, D_centenas, D_millares, D_decenas_millares, D_centenas_millares;

bcd #(.WIRE_SIZE(WIRE_SIZE), .SEGMENTOS(SEGMENTOS), .BIT_SIZE(BIT_SIZE)) DUT(
	 .binary_in(bcd_in_sw),
    .D_unidades(D_unidades),
    .D_decenas(D_decenas),
    .D_centenas(D_centenas),
    .D_millares(D_millares),
    .D_decenas_millares(D_decenas_millares),
    .D_centenas_millares(D_centenas_millares)
);

// Asignar valores aleatorios a la entrada
task set_input();
	bcd_in_sw = $urandom_range(0,2**BIT_SIZE-1);
	$display("Valor a probar = %d", bcd_in_sw);
	#10;
endtask

integer i;

// Ejecucion de i pruebas
initial begin
	for(i = 0; i < ITERACIONES; i = i + 1)
	begin
		set_input();
	end
end

endmodule