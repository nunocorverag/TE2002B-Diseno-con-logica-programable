module password_fsm #(parameter DIG_1 = 2, DIG_2 = 0, DIG_3 = 1, DIG_4 = 6) (
    input clk, rst,
    input [9:0] sw, sw_one_shot,
    output reg incorrect, done
);

parameter IDLE = 0;
parameter FIRST_DIG = 1;
parameter SECOND_DIG = 2;
parameter THIRD_DIG = 3;
parameter COMPLETE = 4;
parameter ERROR = 5;

reg [2:0] current_state, next_state;

// FSM secuencial para que current state solo cambie on la sincronizacion del reloj
always @(posedge clk or posedge rst) 
begin
    if (rst)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Next state se tiene que calcular inmediatamente del cambio de current_state o sw_one_shot
always @(*) 
begin
    next_state = current_state;

    case (current_state)
        IDLE: 
            if (sw_one_shot[DIG_1]) 
                next_state = FIRST_DIG;
            else if (sw_one_shot != 0)
                next_state = ERROR;

        FIRST_DIG: 
            if (sw_one_shot[DIG_2])
                next_state = SECOND_DIG;
            else if (sw_one_shot != 0)
                next_state = ERROR;

        SECOND_DIG: 
            if (sw_one_shot[DIG_3])
                next_state = THIRD_DIG;
            else if (sw_one_shot != 0)
                next_state = ERROR;

        THIRD_DIG: 
            if (sw_one_shot[DIG_4])
                next_state = COMPLETE;
            else if (sw_one_shot != 0)
                next_state = ERROR;

        COMPLETE, ERROR:
            if (sw == 0)
                next_state = IDLE;

    endcase
end

// Actualizar solamente las salidas sincronizando el reloj
always @(posedge clk) 
begin
    case (current_state)
        COMPLETE:
        begin
            done <= 1;
            incorrect <= 0;
        end
        ERROR:
        begin
            done <= 1;
            incorrect <= 1;
        end
        default:
        begin
            incorrect <= 0;
            done <= 0;
        end
    endcase
end

endmodule
