/*************************************************************************
Name of the module:
	DEVICE_UART_TX.sv
Description:
	In this module the implementation of a UART Transmitter device
Version:
	1.0
Author:
	Isaac Vázquez 	ie703092@iteso.mx
	Alberto Vargas  ie710231@iteso.mx
Date: 
	11/18/2021
*************************************************************************/
module device_uart_tx
(
	// Input - Input clock
	input 				clk,
	// Input - Reset	
	input				rst,
	// Input - Enable signal to start the transmision
	input 				transmit,
	// Input - Data to transmit 
	input [7:0]			dataToTransmit,
	
	output 				finishedTx,
	// Output - Serial bit to transmit the dataToTransmit value
	output				serialOutputTx
);
	
	// Wires needed to connect the FSM's enable signals
	wire [7:0] pipo_tx_wire;
	wire in_data_wire;
	wire enb_cont_w;
	wire enb_fsm_cont_w;
	wire enb_load_w;
	wire enb_rx_w;
	wire [1:0] sel_mux_w;
	wire ff_d_out_wire;
	// Wires to interconnect modules for the TX UART device	
	wire data_out_w;
	wire xor_out_w;
	wire parity_out_w;
	wire tx_enb_generator_wire;
	wire cntr_rx_wire;
	wire clear_reg_wire;
	wire cntr_tx_wire;
	wire finished_tx_wire;
	wire div_clk_en_wire;
	wire load_shift_wire;
	
	register
	#(
		.n(8)
	)
	pipo_tx
	(
		.clk(clk),
		.reset(rst),
		.enable(transmit),
		.datainput(dataToTransmit),
		
		
		.dataoutput(pipo_tx_wire)
	);
	
	piso_lsb
	piso_uart_tx
	(
		.clk(clk),    // Clock
		.rst(rst),    // asynchronous reset low active 
		.enb(enb_rx_w & cntr_tx_wire),    // Enable
		.l_s(enb_load_w),    // load or shift
		.piso_input(pipo_tx_wire),    // Parallel data input
		.piso_out(data_out_w)     // Serial output
	);
	
	clk_div 
	#(
		.MAX_CNT(5199)
	)
	cntr_tx
	(
		.clk(clk),
		.rst(rst),
		.enb(tx_enb_generator_wire),
		.div_clk_en(1'b0),
		
		.enb_cont(cntr_tx_wire)
	);
	
	counter #(
		// Parameter - Times to enable the counter
		.MAX_CNT(9)
		// Bits needed to represent he 
	)
	counter_tx
	( 
		// Input - Input clock
		.clk(clk),
		// Input - Reset	
		.rst(rst),
		// Input - Start signal to trigger the counter	
		.enb(enb_fsm_cont_w & cntr_tx_wire),
		
		.clear(clear_reg_wire),
		
		// Output -  Enable signal when counter is active
		.enb_cont(enb_cont_w)
	);
	
	multiplexer2to1
	#(
		.nbits(1)
	)
	in_data
	(
		.selector(finished_tx_wire & cntr_tx_wire),
		.mux_data0(data_out_w ^ parity_out_w),
		.mux_data1(1'b0),
		
		.mux_output(in_data_wire)

	);
	
	register
	#(
		.n(1)
	)
	ff_d
	(
		.clk(clk),
		.reset(rst),
		.enable((enb_fsm_cont_w & cntr_tx_wire) | (finished_tx_wire & cntr_tx_wire)),
		.datainput(in_data_wire),
		
		
		.dataoutput(parity_out_w)
	);
	
	// Module to Control the FSM and other modules
	fsm_uart_tx
	control_tx
	(	
		// Input - Input clock
		.clk(clk),
		.rst(rst),
		.transmit(transmit),
		.enb_cont(enb_cont_w),
		.enb_generator(cntr_tx_wire),
		
		.enb_load(enb_load_w),
		.enb_rx(enb_rx_w),
		.sel_mux(sel_mux_w),
		.enb_cnt(enb_fsm_cont_w),
		.clear_reg(clear_reg_wire),
		.finished_tx(finished_tx_wire),
		//.div_clk_en(div_clk_en_wire),
		//.load_shift_en(load_shift_wire),
		.o_enb_generator(tx_enb_generator_wire)
	);
	
	multiplexer4to1
	#(
	.nbits(1)
	)
	mux_uart_tx
	(
		.selector(sel_mux_w),
		.mux_data0(1'b0),
		.mux_data1(data_out_w),
		.mux_data2(data_out_w ^ parity_out_w),
		//.mux_data2(1'b0),
		.mux_data3(1'b1),
		
		.mux_output(serialOutputTx)

	);

	assign finishedTx = finished_tx_wire;

endmodule
