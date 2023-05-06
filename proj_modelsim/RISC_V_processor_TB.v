/******************************************************************
* Description
*	This is the verifaction envioroment ofr testeting the basic MIPS
*	procesor.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2015
******************************************************************/
`timescale 1ns / 1ps

module RISC_V_processor_TB;
parameter c_CLOCK_PERIOD_NS = 20;
parameter c_CLKS_PER_BIT    = 5208;
parameter c_BIT_PERIOD      = 104000;

//Inputs
reg			clk = 1;
reg			rst = 0;
reg			serialDataRX = 0;
reg 			clearInterrupt = 0;

reg [7:0]	data_to_tx;

wire [7:0]	receivedData;
wire 			rxInterrupt;
wire 			serialOutputTx;

Risc_V_Single_Cycle
top
(
    .clk(clk),
    .reset(rst),
    .gpio_port_in(),
    .uart_serial_input(serialDataRX),
    
    .uart_serial_output(serialOutputTx),
    .gpio_port_out()
);

task UART_WRITE_BYTE;
    input [7:0] i_Data;
    integer     ii;
    integer	cnt_parity;
    integer	parity;
    begin
	parity = 1'b0;
      // Send Start Bit
      serialDataRX <= 1'b0;
      #(c_BIT_PERIOD);


      // Send Data Byte
      for (ii=0; ii<8; ii=ii+1)
        begin
          serialDataRX <= i_Data[ii];
          if(1'b1 == i_Data[ii]) begin
          	parity = ~parity;
        end
          	
          #(c_BIT_PERIOD);
        end
        
        serialDataRX <= parity;
        #(c_BIT_PERIOD);
	
      // Send Stop Bit
      serialDataRX <= 1'b1;
     #(c_BIT_PERIOD);
     end
  endtask // UART_WRITE_BYTE


	always #(c_CLOCK_PERIOD_NS/2) clk <= ~clk;


// Finite sequence for testing bin2seg_top's behavior
//	initial begin
//		// Simulate reset event by setting the reset value
//		#4 rst = 1;
//		
//		dataToTransmit = 8'b00001101;
//		clearInterrupt = 0;
//		
//		#7 transmit = 1;
//		#10 transmit = 0;
//
//		#20
//		dataToTransmit = 8'b01101111;
//		clearInterrupt = 0;
//		
//		#30 transmit = 1;
//		#10 transmit = 0;
//	end
/*********************************************************/
initial 
begin

	clk					= 1;
	rst					= '0;

	//clearInterrupt	= 0;
	serialDataRX 	= 1'd1;
	
	/** Begins system functionality*/
	#2 rst = 1;

	/** Transmit*/
	
	//#2 data_to_tx = 8'b00101110;

	#(c_BIT_PERIOD)
	/** Receive*/
//	#3 serialDataRX = 3'd0;
	@(posedge clk);
	UART_WRITE_BYTE(8'h01);
	@(posedge clk);
	UART_WRITE_BYTE(8'h02);
	@(posedge clk);
	UART_WRITE_BYTE(8'h03);
	@(posedge clk);
	UART_WRITE_BYTE(8'h04);
	@(posedge clk);
	UART_WRITE_BYTE(8'h05);
	@(posedge clk);
	UART_WRITE_BYTE(8'h06);
	@(posedge clk);
	UART_WRITE_BYTE(8'h07);
	@(posedge clk);
	UART_WRITE_BYTE(8'h08);
	@(posedge clk);
	UART_WRITE_BYTE(8'h09);
	@(posedge clk);
	UART_WRITE_BYTE(8'h0a);
	@(posedge clk);
	UART_WRITE_BYTE(8'h0b);
	@(posedge clk);
	UART_WRITE_BYTE(8'h0c);
	@(posedge clk);
	UART_WRITE_BYTE(8'h0d);
	@(posedge clk);
	UART_WRITE_BYTE(8'h0e);
	@(posedge clk);
	UART_WRITE_BYTE(8'h0f);
	@(posedge clk);
	UART_WRITE_BYTE(8'h10);

	@(posedge clk);
	UART_WRITE_BYTE(8'h01);
	@(posedge clk);
	UART_WRITE_BYTE(8'h02);
	@(posedge clk);
	UART_WRITE_BYTE(8'h03);
	@(posedge clk);
	UART_WRITE_BYTE(8'h04);
	
	#(80*c_BIT_PERIOD);
	$stop;	
	
end
endmodule
