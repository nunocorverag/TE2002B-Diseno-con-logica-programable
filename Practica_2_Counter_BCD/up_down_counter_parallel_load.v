module up_down_counter_parallel_load #(parameter COUNT_SIZE = 20, DATA_IN_SIZE = 10) (
    input [DATA_IN_SIZE-1:0] data_in,
    input up_down, // 0 down, 1 up
    input load, // number to load 0 disabled, 1 enabled
    input clk, // clock
    input clear, // clear & set default value
	 input enable, // enable counter
    output reg [COUNT_SIZE - 1:0] count,
    output c_out //carry
);

// CARRY OUT TO SEND IT TO ANOTHER COUNTER
// assign c_out = up_down & (~load) && (count >= COUNT_SIZE)

always @(posedge clk or posedge clear)
begin
    if(clear)
        count <= 0;
    else if(load)
        count <= data_in;
	else if(enable)
        begin
            if(up_down)
            begin
                    if(count + 1 >= 1000000)
                        count <= 0;
                    else
                        count <= count + 1;
                end
            else
                begin
                    if(count - 1 > 999999)
                        count <= 999999;
                    else
                        count <= count - 1;
                end
        end
end
    
endmodule