onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_processor_TB/clk
add wave -noupdate /RISC_V_processor_TB/rst
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_input
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_output
add wave -noupdate /RISC_V_processor_TB/top/uart/finished_tx
add wave -noupdate /RISC_V_processor_TB/top/uart/rxInterrupt
add wave -noupdate /RISC_V_processor_TB/top/uart/transmit
add wave -noupdate -radix unsigned /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/datamemory/ram
add wave -noupdate {/RISC_V_processor_TB/top/datamemory/ram[2]}
add wave -noupdate /RISC_V_processor_TB/top/datamemory/readdata
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/forwardwd_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/intruction
add wave -noupdate /RISC_V_processor_TB/top/core/received_data
add wave -noupdate /RISC_V_processor_TB/top/core/memwrite
add wave -noupdate /RISC_V_processor_TB/top/core/memread
add wave -noupdate /RISC_V_processor_TB/top/core/data_address
add wave -noupdate /RISC_V_processor_TB/top/core/writedata
add wave -noupdate /RISC_V_processor_TB/top/core/pc_address
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/selector
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/top_memory_system/mux_new_address/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix binary /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluoperation
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/a
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/b
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/zero
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/alessb
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluresult
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/in_idex_memread
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/in_branch_jal
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/in_ifid_rs1
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/in_ifid_rs2
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/in_idex_rd
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/pcwrite
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/ifidwrite
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/controlsel
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/ifid_clear
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/idex_clear
add wave -noupdate /RISC_V_processor_TB/top/core/hazard/exmem_clear
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_exmem_regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_memwb_regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_memeread
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_memwrite
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_exmem_memeread
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_idex_upcode
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_idex_rs1
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_idex_rs2
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_exmem_rd
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_memwb_rd
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/out_forwarda_sel
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/out_forwardb_sel
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/out_forwardwd_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22932359986 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 395
configure wave -valuecolwidth 97
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
WaveRestoreZoom {22932063068 ps} {22932564614 ps}
