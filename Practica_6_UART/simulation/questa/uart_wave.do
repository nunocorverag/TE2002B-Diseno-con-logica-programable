onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uart_top_tb/clk
add wave -noupdate /uart_top_tb/rst
add wave -noupdate /uart_top_tb/send_data
add wave -noupdate /uart_top_tb/data
add wave -noupdate /uart_top_tb/parity_type
add wave -noupdate /uart_top_tb/serial_out
add wave -noupdate /uart_top_tb/parity_leds
add wave -noupdate -divider One_Shot
add wave -noupdate /uart_top_tb/DUT/DEB_ONE_SHOT_RST/signal_one_shot
add wave -noupdate /uart_top_tb/DUT/DEB_ONE_SHOT_SEND_DATA/signal_one_shot
add wave -noupdate -divider UART_TX
add wave -noupdate /uart_top_tb/DUT/UART_TX/parity_type
add wave -noupdate /uart_top_tb/DUT/UART_TX/parity_type_reg
add wave -noupdate /uart_top_tb/DUT/UART_TX/active_state
add wave -noupdate /uart_top_tb/DUT/UART_TX/output_data_serial
add wave -noupdate /uart_top_tb/DUT/UART_TX/tx_bit_idx
add wave -noupdate /uart_top_tb/DUT/UART_TX/data_tx_count
add wave -noupdate -divider UART_RX
add wave -noupdate /uart_top_tb/DUT/UART_TX/parity_type
add wave -noupdate /uart_top_tb/DUT/UART_RX/parity_type_reg
add wave -noupdate /uart_top_tb/DUT/UART_RX/parity_error
add wave -noupdate /uart_top_tb/DUT/UART_RX/active_state
add wave -noupdate /uart_top_tb/DUT/UART_RX/serial_data_in
add wave -noupdate /uart_top_tb/DUT/UART_RX/rx_bit_idx
add wave -noupdate /uart_top_tb/DUT/UART_RX/data_rx_count
add wave -noupdate /uart_top_tb/DUT/UART_RX/rx_data
add wave -noupdate -divider Display
add wave -noupdate /uart_top_tb/DUT/DISPLAY_MODULE/centenas_millares_wire
add wave -noupdate /uart_top_tb/DUT/DISPLAY_MODULE/decenas_millares_wire
add wave -noupdate /uart_top_tb/DUT/DISPLAY_MODULE/millares_wire
add wave -noupdate /uart_top_tb/DUT/DISPLAY_MODULE/centenas_wire
add wave -noupdate /uart_top_tb/DUT/DISPLAY_MODULE/decenas_wire
add wave -noupdate /uart_top_tb/DUT/DISPLAY_MODULE/unidades_wire
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {340529137 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 371
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
WaveRestoreZoom {0 ps} {346252316 ps}
