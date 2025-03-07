module status_display(
    input incorrect, done,
    output reg [0:6] HEX_0, HEX_1, HEX_2, HEX_3, HEX_4, HEX_5
);
    always @(*) 
        begin
            if(done == 1)
                begin
                    if(incorrect == 1)
                        begin
                            HEX_5 = 7'b1111_111;
                            HEX_4 = 7'b1111_111;
                            HEX_3 = 7'b0100_001;
                            HEX_2 = 7'b1000_000;
                            HEX_1 = 7'b1001_000;
                            HEX_0 = 7'b0000_110;
                        end
                    else
                        begin
                            HEX_5 = 7'b1111_111;
                            HEX_4 = 7'b0000_110;
                            HEX_3 = 7'b0101_111;
                            HEX_2 = 7'b0101_111;
                            HEX_1 = 7'b0100_011;
                            HEX_0 = 7'b0101_111;
                        end
                end
            else
                begin
                    HEX_5 = 7'b1111_111;
                    HEX_4 = 7'b1111_111;
                    HEX_3 = 7'b1111_111;
                    HEX_2 = 7'b1111_111;
                    HEX_1 = 7'b1111_111;
                    HEX_0 = 7'b1111_111;
                end
        end
endmodule