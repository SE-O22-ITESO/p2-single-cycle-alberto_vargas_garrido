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
module clk_div #(
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
	
	input		div_clk_en,
	
	// Output -  Enable signal when counter is active
	output reg		enb_cont
);

	localparam DW = $clog2(MAX_CNT);
	localparam DIV_MAX_CNT = MAX_CNT/2;
	//localparam DIV_MAX_CNT = MAX_CNT/2;
	// Variable for the current and next counter value
	reg [31:0] cntr_r, cntr_next, cnt_treshold;
	reg enb_cont_r = 1'b0;
	
	// Always to update the counter value
	always@( posedge clk, negedge rst ) begin
		// Restar to default values in case that reset is pressed
		if (!rst) begin
			cntr_r <= 0;
			enb_cont <= 1'b0;
		end
		// Update the value when the counter is enabled
		else begin
			if ( enb )begin
				cntr_r <= cntr_next;
				enb_cont <= enb_cont_r;
			end
			else begin
				cntr_r <= 0;
				enb_cont <= 1'b0;
			end
		end

	end
	
	// Always to enable the output when needed
	always @(cntr_next, cntr_r, enb_cont_r, div_clk_en) begin
		cntr_next = cntr_r + 1'b1 ;
		
		if (div_clk_en)
			cnt_treshold = DIV_MAX_CNT;
		else
			cnt_treshold = MAX_CNT;
			
		if ( cntr_r == cnt_treshold ) begin
			enb_cont_r = 1'b1;
			cntr_next = 0;
		end
		else
			enb_cont_r = 1'b0;
end

	
endmodule
