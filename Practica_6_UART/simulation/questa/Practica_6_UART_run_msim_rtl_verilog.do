transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_6_UART {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_6_UART/receiver.v}

vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_6_UART {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_6_UART/receiver_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  receiver_tb

add wave *
view structure
view signals
run -all
