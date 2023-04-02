/*************************************************************************
Module name:
	FSM_UART_TX.SV
Description:
	Control module to generate the state machine needes to execute the 
	Sequential Multiplier using a Moore FSM
Version:
	1.0
Authors: 			
	Alberto Vargas  ie710231@iteso.mx
Date: 
	11/18/2021
**************************************************************************/

module fsm_uart_tx 
(
	// Input - Input clock
	input  	clk,
	// Input - Reset
	input   rst,
	// Input - Transmit signal to trigger the TX sequence
	input   transmit,
	// Input -  Enable signal when counter is active
	input   enb_cont,
	
	input enb_generator,
	
	// Output - Enable to load the input data
	output reg  enb_load,
	// Output - Enable to transmit from the UART frame
	output  reg enb_rx,	
	// Output - Select the value for the mux
	output  reg [1:0] sel_mux,
	
	output reg o_enb_generator,
	
	output reg clear_reg,
	
	output reg finished_tx,
	
	output reg enb_cnt
	
);

	reg [7:0] state_curr, state_next;

	localparam STATE_TX_IDLE = 3'b000;  
	localparam STATE_TX_START = 3'b001; 
	localparam STATE_TX = 3'b010; 
	localparam STATE_TX_PARITY = 3'b011;
	localparam STATE_TX_STOP = 3'b100; 

	
	// Always to update the state and counter values
	always @(posedge clk, negedge rst) begin
		// Restar to default values in case that reset is pressed
		if (!rst) begin
			state_curr 	<= STATE_TX_IDLE;
		end
		// Update the state and counter values
		else begin
			//if (transmit)
				state_curr 	<= state_next;
		end
	end
	
	// Always to control the UART TX moore FSM
	always @(state_curr, state_next, transmit, enb_cont, enb_generator) begin	
		case( state_curr )
			STATE_TX_IDLE: begin
			
				// Start the sequence if trsnsmit is triggered
				if ( transmit ) begin								
					state_next = STATE_TX_START;
				end
				// Stay in IDLE state
				else begin
					state_next = STATE_TX_IDLE;
				end
					
			end
		
			STATE_TX_START: begin
				// Change to TX state
				if(enb_generator)
					state_next = STATE_TX;
				else
					state_next = STATE_TX_START;
					
			end
	
			STATE_TX: begin
			
				if ( !enb_cont ) begin
					// Stay in TRANSMISION state
					state_next = STATE_TX;
				end
				else begin
					// Change to PARITY state
					state_next = STATE_TX_PARITY;
				end

			end
			
			STATE_TX_PARITY: begin
				if(enb_generator)
					// Change to STOP state				
					state_next = STATE_TX_STOP;
				else
					state_next = STATE_TX_PARITY;

			end
			
			STATE_TX_STOP: 	begin
				if(enb_generator)
					// Change to IDLE state				
					state_next = STATE_TX_IDLE;
				else
					state_next = STATE_TX_STOP;
			
			end
				
		endcase
	end
	
	// Always to set the output value depending on the current state
	always @(state_curr, enb_rx, sel_mux, enb_cnt) begin
	
		case ( state_curr ) 
			STATE_TX_IDLE:	begin
				enb_load		= 1'b0;
				enb_rx 			= 1'b0;
				sel_mux 		= 2'b11;
				enb_cnt			= 1'b0;
				clear_reg		= 1'b0;
				finished_tx		= 1'b0;
				o_enb_generator		= 1'b0;
			end
			
			STATE_TX_START: begin
				enb_load		= 1'b1;			
				enb_rx 			= 1'b1;
				sel_mux 		= 2'b00;
				enb_cnt			= 1'b0;
				clear_reg		= 1'b0;
				finished_tx		= 1'b0;
				o_enb_generator		= 1'b1;
			end
			
			STATE_TX: 	begin
				enb_load		= 1'b0;
				enb_rx 			= 1'b1;
				sel_mux 		= 2'b01;
				enb_cnt			= 1'b1;
				clear_reg		= 1'b0;
				finished_tx		= 1'b0;
				o_enb_generator		= 1'b1;
			end

			STATE_TX_PARITY: 	begin
				enb_load		= 1'b0;
				enb_rx 			= 1'b0;
				sel_mux 		= 2'b10;
				enb_cnt			= 1'b0;
				clear_reg		= 1'b0;
				finished_tx		= 1'b0;
				o_enb_generator		= 1'b1;
			end
			
			STATE_TX_STOP: 	begin
				enb_load		= 1'b0;
				enb_rx 			= 1'b0;
				sel_mux 		= 2'b11;
				enb_cnt			= 1'b0;
				clear_reg		= 1'b1;
				finished_tx		= 1'b1;
				o_enb_generator		= 1'b1;
			end
			
//			default
//				begin
//					enb_load		= '0;
//					enb_rx 		= '0;
//					sel_mux 		= '0;
//					o_full_half_count           = '0;   
//					o_enb_generator              = '0;
//				end
			
		endcase
	end
	
	
endmodule

