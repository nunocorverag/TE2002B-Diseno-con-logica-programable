onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_tb/clk
add wave -noupdate /uart_tb/rst
add wave -noupdate /uart_tb/data
add wave -noupdate -radix unsigned /uart_tb/data
add wave -noupdate /uart_tb/parity_type
add wave -noupdate /uart_tb/serial_out
add wave -noupdate -radix binary /uart_tb/leds
add wave -noupdate -divider Display
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/number
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/centenas_millares_wire
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/decenas_millares_wire
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/millares_wire
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/centenas_wire
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/decenas_wire
add wave -noupdate -radix ufixed /uart_tb/dut/DISPLAY_MODULE/unidades_wire
add wave -noupdate -divider Signals
add wave -noupdate /uart_tb/send_data
add wave -noupdate /uart_tb/dut/one_shot_rst
add wave -noupdate /uart_tb/dut/one_shot_send_data
add wave -noupdate -divider Transmitter
add wave -noupdate /uart_tb/dut/UART_TX/serial_out
add wave -noupdate /uart_tb/dut/UART_TX/active_state
add wave -noupdate /uart_tb/dut/UART_TX/parity_bit
add wave -noupdate -radix ufixed /uart_tb/dut/UART_TX/clock_ctr
add wave -noupdate /uart_tb/dut/UART_TX/d_idx
add wave -noupdate -divider Receiver
add wave -noupdate /uart_tb/dut/UART_RX/serial_data_in
add wave -noupdate /uart_tb/dut/UART_RX/parity_error
add wave -noupdate /uart_tb/dut/UART_RX/parallel_out
add wave -noupdate /uart_tb/dut/UART_RX/active_state
add wave -noupdate /uart_tb/dut/UART_RX/parity_bit
add wave -noupdate -radix ufixed /uart_tb/dut/UART_RX/clock_ctr
add wave -noupdate /uart_tb/dut/UART_RX/d_idx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {92568379 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 332
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {8735709 ps} {152125179 ps}
