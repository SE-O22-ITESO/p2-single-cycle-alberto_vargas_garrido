/******************************************************************
* description
*	this is the control unit for the alu. it receves an signal called 
*	aluop from the control unit and a signal called alufunction from
*	the intrctuion field named function.
* version:
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/
module alucontrol
(
	input [2:0] aluop,
	input [2:0] func3,
	input [6:0] func7,
	
	output [3:0] aluoperation

);
// 3'b aluop de controlunit , 6´b alufunction (instr[5:0])

// r aluop = 111 from controlunit
// add, sub, or, and, nor, sll, srl, jr 
localparam r_type_add    = 13'b111_000_0000000; // funct = 20 hex
localparam r_type_sub    = 13'b111_000_0000010; // funct = 22 hex
localparam r_type_xor    = 13'b111_100_0000000; // funct = 25 hex
localparam r_type_or     = 13'b111_110_0000000; // funct = 24 hex
localparam r_type_and    = 13'b111_111_0000000; // funct = 27 hex
localparam r_type_sll    = 13'b111_001_0000000; // funct = 00 hex
localparam r_type_srl    = 13'b111_101_0000000; // funct = 02 hex
localparam r_type_slt    = 13'b111_000_0000000; // funct = 08 hex
localparam r_type_mul    = 13'b111_000_0000000; // funct = 08 hex

// jump j, jal 
// no aplican a la alu

localparam i_type_addi   = 13'b000_000_xxxxxxx; 
localparam i_type_xori   = 13'b101_100_xxxxxxx;
localparam i_type_ori    = 13'b001_110_xxxxxxx;
localparam i_type_andi   = 13'b100_111_xxxxxxx;
localparam i_type_slli   = 13'b100_001_0000000;
localparam i_type_srli   = 13'b100_101_0000000;
localparam i_type_slti   = 13'b100_010_xxxxxxx;

localparam i_type_beq    = 13'b010_000_xxxxxxx;
localparam i_type_bne    = 13'b010_001_xxxxxxx;
localparam i_type_blt    = 13'b010_100_xxxxxxx;
localparam i_type_bge    = 13'b010_101_xxxxxxx;

localparam i_type_lw     = 13'b000_010_xxxxxxx; //usan add
localparam s_type_sw     = 13'b000_010_xxxxxxx; //usan add

localparam j_type_jal    = 13'b000_010_xxxxxxx; 
localparam i_type_jalr   = 13'b000_010_xxxxxxx; 

localparam u_type_lui    = 13'b000_010_xxxxxxx; 
localparam u_type_auipc  = 13'b000_010_xxxxxxx; 


reg [3:0] alucontrolvalues;
wire [8:0] selector;

assign selector = {aluop, func3, func7};

always@(selector)begin
	casex(selector)
		r_type_add: 	alucontrolvalues = 4'b000;
		r_type_sub: 	alucontrolvalues = 4'b000;
		r_type_xor: 	alucontrolvalues = 4'b000;
		r_type_or: 		alucontrolvalues = 4'b000;
		r_type_and: 	alucontrolvalues = 4'b000;
		r_type_sll: 	alucontrolvalues = 4'b000;
		r_type_srl: 	alucontrolvalues = 4'b000;
		r_type_slt: 	alucontrolvalues = 4'b000;
		r_type_mul: 	alucontrolvalues = 4'b000;
		i_type_addi: 	alucontrolvalues = 4'b000; 
		i_type_xori: 	alucontrolvalues = 4'b000; 
		i_type_ori: 	alucontrolvalues = 4'b000;  
		i_type_andi: 	alucontrolvalues = 4'b000; 
		i_type_slli: 	alucontrolvalues = 4'b000; 
		i_type_srli: 	alucontrolvalues = 4'b000; 
		i_type_slti: 	alucontrolvalues = 4'b000; 
		i_type_beq: 	alucontrolvalues = 4'b000;  
		i_type_bne: 	alucontrolvalues = 4'b000;  
		i_type_blt: 	alucontrolvalues = 4'b000;  
		i_type_bge: 	alucontrolvalues = 4'b000;  
		i_type_lw: 		alucontrolvalues = 4'b000;   
		s_type_sw: 		alucontrolvalues = 4'b000;   
		j_type_jal: 	alucontrolvalues = 4'b000;  
		i_type_jalr: 	alucontrolvalues = 4'b000; 
		u_type_lui: 	alucontrolvalues = 4'b000;  
		u_type_auipc: 	alucontrolvalues = 4'b000;
		default: alucontrolvalues = 4'b1111;
	endcase
end


assign aluoperation = alucontrolvalues;

endmodule
//alucontrol