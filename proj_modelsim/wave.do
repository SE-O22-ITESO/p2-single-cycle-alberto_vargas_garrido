onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_input
add wave -noupdate /RISC_V_processor_TB/top/uart_serial_output
add wave -noupdate /RISC_V_processor_TB/top/uart/finished_tx
add wave -noupdate /RISC_V_processor_TB/top/uart/rxInterrupt
add wave -noupdate /RISC_V_processor_TB/top/uart/transmit
add wave -noupdate /RISC_V_processor_TB/top/uart/uart_tx/pipo_tx/dataoutput
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/pc/clk
add wave -noupdate /RISC_V_processor_TB/top/core/pc/reset
add wave -noupdate /RISC_V_processor_TB/top/core/pc/enable
add wave -noupdate /RISC_V_processor_TB/top/core/pc/newpc
add wave -noupdate /RISC_V_processor_TB/top/core/pc/pcvalue
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/clk
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/reset
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/regwrite
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/writeregister
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readregister1
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readregister2
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/writedata
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readdata1
add wave -noupdate /RISC_V_processor_TB/top/core/register_file/readdata2
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluoperation
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/a
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/b
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/zero
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/alessb
add wave -noupdate /RISC_V_processor_TB/top/core/arithmeticlogicunit/aluresult
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/signextendforconstants/datainput
add wave -noupdate /RISC_V_processor_TB/top/core/signextendforconstants/signextendoutput
add wave -noupdate /RISC_V_processor_TB/top/core/signextendforconstants/select
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/a_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/a_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/a_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/a_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/core/b_mux/selector
add wave -noupdate /RISC_V_processor_TB/top/core/b_mux/mux_data0
add wave -noupdate /RISC_V_processor_TB/top/core/b_mux/mux_data1
add wave -noupdate /RISC_V_processor_TB/top/core/b_mux/mux_data2
add wave -noupdate /RISC_V_processor_TB/top/core/b_mux/mux_data3
add wave -noupdate /RISC_V_processor_TB/top/core/b_mux/mux_output
add wave -noupdate -divider {New Divider}
add wave -noupdate /RISC_V_processor_TB/top/datamemory/writedata
add wave -noupdate /RISC_V_processor_TB/top/datamemory/address
add wave -noupdate /RISC_V_processor_TB/top/datamemory/memwrite
add wave -noupdate /RISC_V_processor_TB/top/datamemory/memread
add wave -noupdate /RISC_V_processor_TB/top/datamemory/clk
add wave -noupdate /RISC_V_processor_TB/top/datamemory/readdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7849097187 ps} 0}
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
WaveRestoreZoom {0 ps} {19983621 ns}
