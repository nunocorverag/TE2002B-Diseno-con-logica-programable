transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_4_Password {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_4_Password/password_fsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_4_Password {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_4_Password/password_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/display {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/display/status_display.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/debouncer {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/debouncer/debouncer.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/debouncer {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/debouncer/counter_debouncer.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/one_shot {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/one_shot/one_shot.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/utils/debouncer_one_shot/debouncer_one_shot.v}

vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_4_Password {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_4_Password/password_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  password_top_tb

add wave *
view structure
view signals
run -all
