onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /password_top_tb/clk
add wave -noupdate /password_top_tb/rst
add wave -noupdate /password_top_tb/sw
add wave -noupdate /password_top_tb/HEX_0
add wave -noupdate /password_top_tb/HEX_1
add wave -noupdate /password_top_tb/HEX_2
add wave -noupdate /password_top_tb/HEX_3
add wave -noupdate /password_top_tb/HEX_4
add wave -noupdate /password_top_tb/HEX_5
add wave -noupdate -divider Pass_FSM
add wave -noupdate /password_top_tb/DUT/PASSWORD_FSM/incorrect
add wave -noupdate /password_top_tb/DUT/PASSWORD_FSM/done
add wave -noupdate /password_top_tb/DUT/PASSWORD_FSM/current_state
add wave -noupdate /password_top_tb/DUT/PASSWORD_FSM/next_state
add wave -noupdate -divider Rst_One_Shot
add wave -noupdate /password_top_tb/DUT/DEB_ONE_SHOT_RST/signal_one_shot
add wave -noupdate -divider SW_One_Shot
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[0]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[1]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[2]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[3]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[4]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[5]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[6]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[7]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[8]/DEB_ONE_SHOT_SW/signal_one_shot}
add wave -noupdate {/password_top_tb/DUT/debouncer_gen[9]/DEB_ONE_SHOT_SW/signal_one_shot}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14999238 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 463
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
WaveRestoreZoom {14999328 ps} {15000036 ps}
