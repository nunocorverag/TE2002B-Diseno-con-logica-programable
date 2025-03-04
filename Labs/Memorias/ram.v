// Las memorias ram si necesitan reloj
// Escriturta y lectura asincrona
// Si el boton esta encendido, escribe 5 bits en la posicion 5 que le demos
// Si no esta encendido, lee los 5 bits en la posicion que le demos

// SW[9:5] - ADDRESS
// SW[4:0] - DATA
module ram #(parameter DATA_WIDTH = 5, ADDRESS_WIDTH = 5)(
    input clk,
    input wr_en, // Wirete enable
    input [DATA_WIDTH - 1:0] data_in,
    input [ADDRESS_WIDTH - 1:0] address_in,
    // Si tiene output reg porque lo vamos a meter en un always
    output reg [DATA_WIDTH - 1:0] data_out
);

reg [DATA_WIDTH:0] RAM_MEMORY [0:2 ** (ADDRESS_WIDTH - 1)]; // Porque al revez, es recomendable hacer lo asi 0:255?

initial
    begin
        $readmemb("numbers.bin", mem)
        $readmemh("numbers.hex", mem)
    end

assign data = (ce && read_en) ? mem[address] : 0;
endmodule

wire wr_en_boton = wr_en; //Boton con logica negativa

always @(posedge clk) 
    begin
        if (wr_en_boton)
            RAM_MEMORY[address_in] <= data_in;
        else
            data_out <= RAM_MEMORY[address_in];
    end

// Revisar el bloque y porque cada entrada de la memoria