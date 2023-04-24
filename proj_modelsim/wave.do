onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_processor_TB/clk
add wave -noupdate /RISC_V_processor_TB/rst
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_input
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_output
add wave -noupdate /RISC_V_processor_TB/top/uart/finished_tx
add wave -noupdate /RISC_V_processor_TB/top/uart/rxInterrupt
add wave -noupdate /RISC_V_processor_TB/top/uart/transmit
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/writeregister
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readregister1
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readregister2
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/writedata
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readdata1
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readdata2
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_ifid/datainput
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_ifid/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_idex/datainput
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_idex/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_exmem/datainput
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_exmem/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_memwb/datainput
add wave -noupdate /RISC_V_processor_TB/top/core/pipeline_memwb/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluoperation
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/a
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/b
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluresult
add wave -noupdate /RISC_V_processor_TB/top/core/controlunit/aluop
add wave -noupdate /RISC_V_processor_TB/top/core/alu_control/aluoperation
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/zero
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/alessb
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_exmem_regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_memwb_regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_idex_rs1
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_idex_rs2
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_exmem_rd
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/in_memwb_rd
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/out_forwarda_sel
add wave -noupdate /RISC_V_processor_TB/top/core/forwarding/out_forwardb_sel
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/forwarda_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/forwardb_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/forwardb_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/forwardb_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/forwardb_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/forwardb_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/forwardb_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/pc/enable
add wave -noupdate /RISC_V_processor_TB/top/core/pc/newpc
add wave -noupdate /RISC_V_processor_TB/top/core/pc/pcvalue
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand /RISC_V_processor_TB/top/datamemory/ram
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1196558194 ps} 0}
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
WaveRestoreZoom {1196405730 ps} {1196710658 ps}
