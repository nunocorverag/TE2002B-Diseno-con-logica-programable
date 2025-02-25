transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD/display_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD/decoder_7_seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD/bcd.v}

vlog -sv -work work +incdir+C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD {C:/Users/gnuno/OneDrive/Documentos/Tec/4to/logica_programable/TE2002B-Diseno-con-logica-programable/Practica_1_BCD/bcd_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  bcd_tb

add wave *
view structure
view signals
run -all
