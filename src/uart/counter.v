/*************************************************************************
Name of the module:
	COUNTER.sv
Description:
	Parametrizable binary counter 
Version:
	1.0
Author:
	Isaac Vázquez 	ie703092@iteso.mx
	Alberto Vargas  ie710231@iteso.mx
Date: 
	11/18/2021
*************************************************************************/
module counter #(
	// Parameter - Times to enable the counter
	parameter MAX_CNT = 2
	// Bits needed to represent he 
	)( 
	// Input - Input clock
	input		clk,
	// Input - Reset	
	input 		rst,
	// Input - Start signal to trigger the counter	
	input    	enb,
	
	input		clear,
	
	// Output -  Enable signal when counter is active
	output reg		enb_cont
);

	localparam DW = $clog2(MAX_CNT);
	// Variable for the current and next counter value
	reg [DW-1:0] cntr_r, cntr_next;
	
	
	// Always to update the counter value
	always@( posedge clk, negedge rst ) begin
		// Restar to default values in case that reset is pressed
		if (!rst) begin
			cntr_r <= 0;
		end
		// Update the value when the counter is enabled
		else 
			if ( enb )begin
				cntr_r <= cntr_next;
			end
			else if (clear) begin
				cntr_r <= 0;
			end

	end
	
	// Always to enable the output when needed
	always @(cntr_next, cntr_r) begin
		cntr_next = cntr_r + 1'b1 ;
		
		if ( cntr_r < MAX_CNT-1'b1 )
			enb_cont	=   1'b0;    
		else
			enb_cont	=   1'b1;
end

	
endmodule
