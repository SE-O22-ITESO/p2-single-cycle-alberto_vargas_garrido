/*************************************************************************
Name of the module:
	DEVICE_UART_RX.sv
Description:
	In this module the implementation of a UART Receiver device
Version:
	1.0
Author:
	Isaac Vázquez 	ie703092@iteso.mx
	Alberto Vargas  ie710231@iteso.mx
Date: 
	11/18/2021
*************************************************************************/


module device_uart_rx
(
	// Input - Input clock
	input 	clk,
	// Input - Reset	
	input		rst,
	// Input - Serial bus to receive the incoming serial data
	input 	serialDataRX,
	// Input - Bit used for cleaning the interruption
	input 	clearInterrupt,

	// Output - Parallel value for received data
	output [7:0]	receivedData,
	// Output - Interruption to indicate when a data was received
	output				rxInterrupt,
	// Output - Bit to inidcate if there was a parity error
	output				parityError
);

	// Wires needed to connect the FSM's enable signals
	wire enb_rx_w;
	wire enb_parity_w;
	
	// Wires to interconnect modules for the RX UART device
	wire input_parity_w;
	wire xor_parity_w;
	wire reg_parity_w;
	wire comp_val_w;
	wire and_enable_w;
	wire[7:0] reg_input_data_w;
	wire enb_cont_w; 
	wire reg_interrupt_w;
	wire ff_d0_wire;
	wire ff_d1_wire;
	wire ff_d2_wire;
	wire ff_d3_wire;
	wire cntr_rx_wire;
	wire rx_enb_generator_w;
	wire clear_reg_wire;
	wire div_clk_wire;
	wire reg_out_wire;
	wire parity_mux_wire;
	
	clk_div 
	#(
		.MAX_CNT(5199)
	)
	cntr_rx
	(
		.clk(clk),
		.rst(rst),
		.enb(rx_enb_generator_w),
		.div_clk_en(div_clk_wire),
		
		.enb_cont(cntr_rx_wire)
	);
	
	// Module to Control the FSM and other modules
	fsm_uart_rx fsm_rx
	(
		.clk(clk),
		.rst(rst),
		.enb_cont(enb_cont_w),
		.rx_data(serialDataRX),
		.clearInterrupt(clearInterrupt),
		.enb_generator(cntr_rx_wire),
		
		.enb_rx(enb_rx_w),
		.enb_parity(enb_parity_w),	
		.enb_interrupt(reg_interrupt_w),
		.o_enb_generator(rx_enb_generator_w),
		.div_clk(div_clk_wire),
		.clear_reg(clear_reg_wire),
		.reg_out(reg_out_wire)
	);
	
	sipo_lsb 
	reg_input_data
	(
		.clk(clk), 
		.rst(rst),
		.enb(enb_rx_w & cntr_rx_wire),
		.clear(clear_reg_wire),
		.inp(serialDataRX),
		
		.out(reg_input_data_w)
	);
	
	// Module to count DW_PC times for the TX
	counter 
	#(
		.MAX_CNT(9)
	)
	cntr_r
	(
		.clk(clk),
		.rst(rst),
		.enb(enb_rx_w & cntr_rx_wire),
		.clear(clear_reg_wire),
		
		.enb_cont(enb_cont_w)
	);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////Registers//////////////////////////////////////////////////////////////////////////////
	
	register
	#(
		.n(8)
	)
	pipo
	(
		.clk(clk),
		.reset(rst),
		.enable(reg_out_wire),
		.datainput(reg_input_data_w),
		
		
		.dataoutput(receivedData)
	);
	
	multiplexer2to1
	#(
		.nbits(1)
	)
	parity_mux
	(
		.selector(enb_rx_w),
		.mux_data0(1'b0),
		.mux_data1(serialDataRX ^ ff_d0_wire),
		
		.mux_output(parity_mux_wire)

	);
	
	register
	#(
		.n(1)
	)
	ff_d0
	(
		.clk(clk),
		.reset(rst),
		.enable(rx_enb_generator_w & cntr_rx_wire),
		.datainput(parity_mux_wire),
		
		
		.dataoutput(ff_d0_wire)
	);
	
	register
	#(
		.n(1)
	)
	ff_d1
	(
		.clk(clk),
		.reset(rst),
		.enable(enb_parity_w),
		.datainput(ff_d0_wire ^ serialDataRX),
		
		
		.dataoutput(parityError)
	);
	
	assign rxInterrupt = reg_interrupt_w;
	
endmodule
