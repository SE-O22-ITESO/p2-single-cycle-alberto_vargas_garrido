/******************************************************************
* description
*	this is  a rom memory that represents the program memory. 
* 	internally, the memory is read without a signal clock. the initial 
*	values (program) of this memory are written from a file named text.dat.
* version:
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/
module programmemory
#
(
	parameter memory_depth=128,
	parameter data_width=32
)
(
	input [(data_width-1):0] address,
	output reg [(data_width-1):0] instruction
);
wire [(data_width-1):0] realaddress;

//assign realaddress = {2'b0,address[(data_width-1):2]};

	// declare the rom variable
	reg [data_width-1:0] rom[memory_depth-1:0];

	initial
	begin
		$readmemh("../assembly_code/mul_matrix.txt", rom);
		//$readmemh("../assembly_code/Taera_GPIO.txt", rom);
	end

	always @ (address)
	begin
		instruction = rom[address];
	end

endmodule
//programmemory
