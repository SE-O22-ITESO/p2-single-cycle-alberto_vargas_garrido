/*************************************************************************
Name of the module:
	UART_TOP.sv
Description:
	This is the top module for UART, including tx and rx
Version:
	1.0
Author:
	Isaac Vázquez 	ie703092@iteso.mx
	Alberto Vargas  ie710231@iteso.mx
Date: 
	11/18/2021
*************************************************************************/


module uart_top
(
	// Input - Input clock
	input 	clk,
	// Input - Reset	/
	input		rst,
	input 		serialDataRX,
	input 		clearInterrupt,
	input 		transmit,
	input [7:0]	dataToTransmit,

	output [7:0]	receivedData,
	output		finished_tx,
	output		rxInterrupt,
	output		parityError,
	output		serialOutputTx
);

/** Clk of 115.2 kHz*/
wire			pll_clk;

//data_DW_t dataToTransmit;
//wire transmit;
wire[8:0] dataToTest;
wire transmit_w;
wire clk2_wire;

/*
clk_div 
#(
	.MAX_CNT(15'd1_042)
)
cntr_r
(
	.clk(clk_tx),
	.rst(rst),
	.enb(transmit),
	
	.enb_cont(clk2_wire)
);
*/


// UART TX
device_uart_tx 
uart_tx
(
	.clk(clk),
	.rst(rst),
	.transmit(transmit),
	.dataToTransmit(dataToTransmit),
	
	.finishedTx(finished_tx),
	.serialOutputTx(serialOutputTx)
);

// UART RX
device_uart_rx 
uart_rx
(
	.clk(clk),
	.rst(rst),
	.serialDataRX(serialDataRX),
	.clearInterrupt(clearInterrupt),

	.receivedData(receivedData),
	.rxInterrupt(rxInterrupt),
	.parityError(parityError)
);

//assign rxInterrupt = transmit;
//assign receivedData = dataToTransmit;
endmodule
