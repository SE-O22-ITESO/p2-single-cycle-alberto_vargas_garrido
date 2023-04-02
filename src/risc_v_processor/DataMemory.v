/******************************************************************
* description
*	this is the data memory for the mips processor
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/

module datamemory 
#(	parameter data_width=8,
	parameter memory_depth = 1024

)
(
	input [data_width-1:0] writedata,
	input [data_width-1:0]  address,
	input memwrite,memread, clk,

	output  [data_width-1:0]  readdata
);
	
	// declare the ram variable
	reg [data_width-1:0] ram[memory_depth-1:0];
	wire [data_width-1:0] readdataaux;

	always @ (posedge clk)
	begin
		// write
		if (memwrite)
			ram[address] <= writedata;
	end
	assign readdataaux = ram[address];
  	assign readdata = {data_width{memread}}& readdataaux;

endmodule
//datamemory
