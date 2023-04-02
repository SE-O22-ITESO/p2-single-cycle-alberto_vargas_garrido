/*************************************************************************
Module name:
	FSM_UART_RX.SV
Description:
	Control module to generate the state machine needes to execute the 
	UART receptor using a Moore FSM
Version:
	1.0
Authors: 			
	Alberto Vargas  ie710231@iteso.mx
Date: 
	11/18/2021
**************************************************************************/

module fsm_uart_rx
(
	// Input - Input clock
	input clk,
	// Input - Reset
	input rst,
	// Input - One shot start signal to trigger the FSM sequence
	input enb_cont,
	// Input - UART serial input for the frame
	input rx_data,
	// Input -  Bit for clearing the interrption
	input 	clearInterrupt,
	// Input -  Bit for enable clk generator
	input 	enb_generator,


	
	// Output - Enable the RX 
	output reg enb_rx,
	// Output - Enable to obtain the parity from the UART frame
	output reg enb_parity,
	// Output - Enable to save the interruption value and the data value
	output reg enb_interrupt,
	
	output reg o_enb_generator,
	
	output reg div_clk, 
	
	output reg clear_reg,
	
	output reg reg_out
	
);
	localparam STATE_RX_IDLE = 3'b000;  
	localparam START_BIT = 3'b001;
	localparam START_BIT2 = 3'b010; 
	localparam DELAY = 3'b011; 
	localparam STATE_RX = 3'b100; 
	localparam STATE_RX_STOP = 3'b101; 
	localparam STATE_RX_STOP2 = 3'b110; 

	reg [2:0] state_current, state_next;

	// Always to update the state and counter values
	always @(posedge clk, negedge rst) begin
		// Restar to default values in case that reset is pressed
		if (!rst) begin
			state_current 	<= STATE_RX_IDLE;
		end
		// Update the state and counter values
		else begin
			state_current 	<= state_next;
		end
	end

	always @(state_current, rx_data, enb_cont, enb_generator) begin
		case( state_current )
			STATE_RX_IDLE: begin
				
				// Start the sequence when the bus changes from 1 to 0
				if ( !rx_data ) begin								
					state_next = START_BIT;
				end
				// Stay in IDLE state
				else begin
					state_next = STATE_RX_IDLE;
				end
			end
			
			START_BIT: 	begin

				if ((!rx_data) && enb_generator) begin
				// Change to PARITY state
					state_next = STATE_RX;
					
				end
				else begin
					// STay in START BIT state
					state_next = START_BIT;
				end
			end
			/*
			START_BIT2: 	begin

				if (enb_generator) begin
				// Change to PARITY state
					state_next = DELAY;
					
				end
				else begin
					// STay in START BIT state
					state_next = START_BIT2;
				end
			end
			*/
			/*
			DELAY: 	begin

				if (enb_generator) begin
				// Change to PARITY state
					state_next = STATE_RX;
					
				end
				else begin
					// STay in START BIT state
					state_next = DELAY;
				end
			end
			*/
			STATE_RX: 	begin

				// Stay in OFF  state for DW-1 clock cycles
				if ( !enb_cont ) begin
					// STay in rx state
					state_next = STATE_RX;
					
				end
				else begin
					// Change to PARITY state
					state_next = STATE_RX_STOP;
				end
			end

			STATE_RX_STOP: begin
				// Change to IDLE state
				if (enb_generator) begin
				// Change to PARITY state
					state_next = STATE_RX_STOP2;
					
				end
				else begin
					// STay in START BIT state
					state_next = STATE_RX_STOP;
				end
			end
			STATE_RX_STOP2: begin
				// Change to IDLE state
				if (rx_data && enb_generator) begin
				// Change to PARITY state
					state_next = STATE_RX_IDLE;
					
				end
				else begin
					// STay in START BIT state
					state_next = STATE_RX_STOP2;
				end

			end
			//default: begin
			//	state_next = STATE_RX_IDLE;
			//end
		endcase
	end

	always @(state_current) begin
			
			case ( state_current ) 
				STATE_RX_IDLE:	begin
					enb_rx 			= 1'b0;
					enb_parity 		= 1'b0;
					enb_interrupt 		= 1'b0;
					o_enb_generator		= 1'b0;
					clear_reg		= 1'b0;
					div_clk			= 1'b0;
					reg_out			= 1'b0;
				end
							
				START_BIT: 	begin
					enb_rx 			= 1'b0;
					enb_parity 		= 1'b0;
					enb_interrupt 		= 1'b0;
					o_enb_generator		= 1'b1;
					clear_reg		= 1'b0;
					div_clk			= 1'b1;
					reg_out			= 1'b0;
				end
				/*
				START_BIT2: 	begin
					enb_rx 			= 1'b0;
					enb_parity 		= 1'b0;
					enb_interrupt 		= 1'b0;
					o_enb_generator		= 1'b1;
					clear_reg		= 1'b0;
					div_clk			= 1'b0;
				end
				*/
				/*
				DELAY: 	begin
					enb_rx 			= 1'b1;
					enb_parity 		= 1'b0;
					enb_interrupt 		= 1'b0;
					o_enb_generator		= 1'b1;
					clear_reg		= 1'b0;
					div_clk			= 1'b1;
				end
				*/
				
				STATE_RX: 	begin
					enb_rx 			= 1'b1;
					enb_parity 		= 1'b0;
					enb_interrupt 		= 1'b0;
					o_enb_generator		= 1'b1;
					clear_reg		= 1'b0;
					div_clk			= 1'b0;
					reg_out			= 1'b0;
				end
				
				STATE_RX_STOP: 	begin
					enb_rx 			= 1'b0;
					enb_parity 		= 1'b1;
					enb_interrupt 		= 1'b0;
					o_enb_generator		= 1'b1;
					clear_reg		= 1'b0;
					div_clk			= 1'b0;
					reg_out			= 1'b1;
				end
				
				STATE_RX_STOP2: 	begin
					enb_rx 			= 1'b0;
					enb_parity 		= 1'b0;
					enb_interrupt 		= 1'b1;
					o_enb_generator		= 1'b1;
					clear_reg		= 1'b1;
					div_clk			= 1'b0;
					reg_out			= 1'b0;
				end
			endcase
		end

endmodule
