module clock_divider #(parameter CYCLES = 50000000)
(
	input clk, rst,
	output reg clk_div 
);

reg [31:0] count;

always @(posedge clk or posedge rst)
    begin
        if(rst == 1)
            count <= 0;
        else if(count == CYCLES - 1)
				count <= 0;
		  else	
            count <= count +  1;
    end

always @(posedge clk or posedge rst)
	begin
		if(rst == 1)
			clk_div <= 0;
		else if(count == CYCLES - 1)
			clk_div <= ~clk_div;
		else
			clk_div <= clk_div;
	end

endmodule