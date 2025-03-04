module password #(parameter DIG_1 = 2, DIG_2 = 0, DIG_3 = 1, DIG_4 = 6) (
    input clk, rst,
    input [9:0] sw,
    output reg incorrect, done
);

parameter IDLE = 0;
parameter FIRST_DIG = 1;
parameter SECOND_DIG = 2;
parameter THIRD_DIG = 3;
parameter COMPLETE = 4;
parameter ERROR = 5;

reg [2:0] current_state;
reg [2:0] next_state;

wire [9:0] sw_one_shot;

always @(posedge clk or posedge rst) 
    begin
        if (rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

// FALTA el if sw == 0 para mantener el estado
always @(posedge current_state) 
    begin
        case (current_state)
            IDLE: 
                begin
                    if (sw == 0) 
                        begin
                            if (sw_one_shot[DIG_1])
                                current_state <= FIRST_DIG;
                            else
                                current_state <= ERROR;
                        end
                    else
                        current_state <= IDLE;
                end
            FIRST_DIG: 
                begin
                    if (sw_one_shot[DIG_2])
                        current_state <= SECOND_DIG;
                    else
                        current_state <= ERROR;
                end
            SECOND_DIG: 
                begin
                    if (sw_one_shot[DIG_3])
                        current_state <= THIRD_DIG;
                    else
                        current_state <= ERROR;
                end
            THIRD_DIG: 
                begin
                    if (sw_one_shot[DIG_4])
                        current_state <= COMPLETE;
                    else
                        current_state <= ERROR;
                end
            COMPLETE:
                if(sw == 0)
                    current_state <= IDLE;
                else
                    current_state <= COMPLETE;
            ERROR:
                if(sw == 0)
                    current_state <= IDLE;
                else
                    current_state <= COMPLETE;
            default: 
                current_state <= IDLE;
        endcase
    end

always @(posedge current_state) 
    begin
        case (current_state)
            COMPLETE:
                done <= 1;
                incorrect <= 0;
            ERROR:
                done <= 0;
                incorrect <= 1
            default: 
                incorrect <= 0;
                done <= 0;
        endcase
    end

genvar i;

generate
    for (i = 0; i < 10 ; i = i + 1) begin
        debouncer_one_shot(
            .clk(clk),
            .signal(sw[i])
            .signal_one_shot(sw_one_shot[i])
        )
    end
endgenerate

endmodule