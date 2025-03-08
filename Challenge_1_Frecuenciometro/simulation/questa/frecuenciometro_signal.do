onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /frequency_meter_tb/clk
add wave -noupdate /frequency_meter_tb/rst
add wave -noupdate /frequency_meter_tb/signal_in
add wave -noupdate /frequency_meter_tb/D_decenas
add wave -noupdate /frequency_meter_tb/D_unidades
add wave -noupdate /frequency_meter_tb/D_centenas
add wave -noupdate /frequency_meter_tb/D_millares
add wave -noupdate /frequency_meter_tb/D_decenas_millares
add wave -noupdate /frequency_meter_tb/D_centenas_millares
add wave -noupdate /frequency_meter_tb/clk
add wave -noupdate /frequency_meter_tb/rst
add wave -noupdate /frequency_meter_tb/signal_in
add wave -noupdate -divider synchronizer
add wave -noupdate /frequency_meter_tb/DUT/SYNCHRONIZER/signal_sync
add wave -noupdate -divider edge_detector
add wave -noupdate /frequency_meter_tb/DUT/EDGE_DETECTOR/rise_edge
add wave -noupdate -divider period_capture
add wave -noupdate /frequency_meter_tb/DUT/PERIOD_CAPTURE/rise_edge
add wave -noupdate /frequency_meter_tb/DUT/PERIOD_CAPTURE/period
add wave -noupdate /frequency_meter_tb/DUT/PERIOD_CAPTURE/counter
add wave -noupdate /frequency_meter_tb/DUT/PERIOD_CAPTURE/prev_count
add wave -noupdate -divider freq_calculator
add wave -noupdate -radix ufixed /frequency_meter_tb/DUT/FREQUENCY_CALCULATOR/period
add wave -noupdate -radix ufixed /frequency_meter_tb/DUT/FREQUENCY_CALCULATOR/frequency
add wave -noupdate -divider display
add wave -noupdate /frequency_meter_tb/DUT/DISPLAY_MODULE/centenas_millares_wire
add wave -noupdate /frequency_meter_tb/DUT/DISPLAY_MODULE/decenas_millares_wire
add wave -noupdate /frequency_meter_tb/DUT/DISPLAY_MODULE/millares_wire
add wave -noupdate /frequency_meter_tb/DUT/DISPLAY_MODULE/centenas_wire
add wave -noupdate /frequency_meter_tb/DUT/DISPLAY_MODULE/decenas_wire
add wave -noupdate /frequency_meter_tb/DUT/DISPLAY_MODULE/unidades_wire
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {371208344 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 415
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
WaveRestoreZoom {2761994125 ps} {6812526625 ps}
