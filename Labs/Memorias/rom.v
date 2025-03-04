module rom #(parameter DATA_WIDTH = 10, ADDRESS_WIDTH = 8)(
    input ce, read_en //ce - chip enable, read_en - read enable
    input [ADDRESS_WIDTH - 1:0] address,
    output [DATA_WIDTH - 1:0] data
);

reg [DATA_WIDTH:0] mem [0:2 ** (ADDRESS_WIDTH - 1)]; // Porque al revez, es recomendable hacer lo asi 0:255?

initial
    begin
        $readmemb("numbers.bin", mem)
        $readmemh("numbers.hex", mem)
    end

assign data = (ce && read_en) ? mem[address] : 0;
endmodule

// Revisar el bloque y porque cada entrada de la memoria