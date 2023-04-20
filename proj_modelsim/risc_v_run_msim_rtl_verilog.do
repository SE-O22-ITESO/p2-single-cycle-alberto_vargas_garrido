quit -sim

vlog -vlog01compat -work work ../src/risc_v_processor/RISC_V_processor.v
vlog -vlog01compat -work work ./RISC_V_processor_TB.v
vlog -vlog01compat -work work ../src/risc_v_processor/Adder32bits.v
vlog -vlog01compat -work work ../src/risc_v_processor/ALU.v
vlog -vlog01compat -work work ../src/risc_v_processor/ALUControl.v
vlog -vlog01compat -work work ../src/risc_v_processor/ANDGate.v
vlog -vlog01compat -work work ../src/risc_v_processor/Control.v
vlog -vlog01compat -work work ../src/risc_v_processor/DataMemory.v
vlog -vlog01compat -work work ../src/risc_v_processor/DecoderRegisterFile.v
vlog -vlog01compat -work work ../src/risc_v_processor/Definitions.v
vlog -vlog01compat -work work ../src/risc_v_processor/Multiplexer2to1.v
vlog -vlog01compat -work work ../src/risc_v_processor/Multiplexer4to1.v
vlog -vlog01compat -work work ../src/risc_v_processor/MUXRegisterFile.v
vlog -vlog01compat -work work ../src/risc_v_processor/PC_Register.v
vlog -vlog01compat -work work ../src/risc_v_processor/ProgramMemory.v
vlog -vlog01compat -work work ../src/risc_v_processor/Register.v
vlog -vlog01compat -work work ../src/risc_v_processor/RegisterFile.v
vlog -vlog01compat -work work ../src/risc_v_processor/ShiftLeft2.v
vlog -vlog01compat -work work ../src/risc_v_processor/SignExtend.v
vlog -vlog01compat -work work ../src/Risc_V_Single_Cycle.v
vlog -vlog01compat -work work ../src/gpio/gpio_top.v
vlog -vlog01compat -work work ../src/risc_v_processor/Register_sp.v
vlog -vlog01compat -work work ../src/risc_v_processor/RegisterPipeline.v
vlog -vlog01compat -work work ../src/risc_v_processor/HazardUnit.v

vlog -vlog01compat -work work ../src/uart/clk_div.v
vlog -vlog01compat -work work ../src/uart/fsm_uart_rx.v
vlog -vlog01compat -work work ../src/uart/fsm_uart_tx.v
vlog -vlog01compat -work work ../src/uart/piso_lsb.v
vlog -vlog01compat -work work ../src/uart/sipo_lsb.v
vlog -vlog01compat -work work ../src/uart/counter.v
vlog -vlog01compat -work work ../src/uart/device_uart_rx.v
vlog -vlog01compat -work work ../src/uart/device_uart_tx.v
vlog -vlog01compat -work work ../src/uart/uart_top.v

vlog -vlog01compat -work work ../src/memory_x_controller/memory_x_control.v
vlog -vlog01compat -work work ../src/memory_x_controller/top_memory_x.v

vsim -voptargs=+acc work.RISC_V_processor_TB
