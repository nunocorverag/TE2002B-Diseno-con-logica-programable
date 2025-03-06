onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /receiver_tb/rst
add wave -noupdate /receiver_tb/clk
add wave -noupdate /receiver_tb/serial_data_in
add wave -noupdate /receiver_tb/parity_type
add wave -noupdate /receiver_tb/parallel_out
add wave -noupdate /receiver_tb/parity_error
add wave -noupdate /receiver_tb/rst
add wave -noupdate /receiver_tb/clk
add wave -noupdate /receiver_tb/serial_data_in
add wave -noupdate /receiver_tb/parity_type
add wave -noupdate /receiver_tb/parallel_out
add wave -noupdate /receiver_tb/parity_error
add wave -noupdate /receiver_tb/DUT/one_shot_rst
add wave -noupdate /receiver_tb/DUT/active_state
add wave -noupdate /receiver_tb/DUT/clock_ctr
add wave -noupdate /receiver_tb/DUT/d_idx
add wave -noupdate /receiver_tb/DUT/parity_type_reg
add wave -noupdate /receiver_tb/DUT/parity_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {724026751 ps}
