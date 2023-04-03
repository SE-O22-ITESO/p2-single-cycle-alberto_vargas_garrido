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
	input [3:0] aluop,
	input [2:0] func3,
	input [6:0] func7,
	
	output [3:0] aluoperation

);
// 3'b aluop de controlunit , 6´b alufunction (instr[5:0])

// r aluop = 111 from controlunit
// add, sub, or, and, nor, sll, srl, mul
localparam r_type_add    = 14'b0000_000_0000000; // funct = 20 hex
localparam r_type_sub    = 14'b0000_000_0000010; // funct = 22 hex
localparam r_type_xor    = 14'b0000_100_0000000; // funct = 25 hex
localparam r_type_or     = 14'b0000_110_0000000; // funct = 24 hex
localparam r_type_and    = 14'b0000_111_0000000; // funct = 27 hex
localparam r_type_sll    = 14'b0000_001_0000000; // funct = 00 hex
localparam r_type_srl    = 14'b0000_101_0000000; // funct = 02 hex
localparam r_type_slt    = 14'b0000_010_0000000; // funct = 08 hex
localparam r_type_mul    = 14'b0000_011_0000001; // funct = 08 hex

// jump j, jal 
// no aplican a la alu

localparam i_type_addi   = 14'b0001_000_xxxxxxx; 
localparam i_type_xori   = 14'b0001_100_xxxxxxx;
localparam i_type_ori    = 14'b0001_110_xxxxxxx;
localparam i_type_andi   = 14'b0001_111_xxxxxxx;
localparam i_type_slli   = 14'b0001_001_0000000;
localparam i_type_srli   = 14'b0001_101_0000000;
localparam i_type_slti   = 14'b0001_010_xxxxxxx;

localparam b_type_branch = 14'b0011_xxx_xxxxxxx;

localparam i_type_lw     = 14'b0111_010_xxxxxxx; //usan add
localparam s_type_sw     = 14'b0010_010_xxxxxxx; //usan add

localparam j_type_jal    = 14'b0110_xxx_xxxxxxx; 
localparam i_type_jalr   = 14'b1000_000_xxxxxxx; 

localparam u_type_lui    = 14'b0100_xxx_xxxxxxx; 
localparam u_type_auipc  = 14'b0101_xxx_xxxxxxx; 


reg [3:0] alucontrolvalues;
wire [13:0] selector;

assign selector = {aluop, func3, func7};

always@(*)begin
	casex(selector)
		r_type_add: 	alucontrolvalues = 4'b0000;
		r_type_sub: 	alucontrolvalues = 4'b0001;
		r_type_xor: 	alucontrolvalues = 4'b0010;
		r_type_or: 		alucontrolvalues = 4'b0011;
		r_type_and: 	alucontrolvalues = 4'b0100;
		r_type_sll: 	alucontrolvalues = 4'b0111;
		r_type_srl: 	alucontrolvalues = 4'b1000;
		r_type_slt: 	alucontrolvalues = 4'b1001;
		r_type_mul: 	alucontrolvalues = 4'b1010;
		i_type_addi: 	alucontrolvalues = 4'b0000; 
		i_type_xori: 	alucontrolvalues = 4'b0010; 
		i_type_ori: 	alucontrolvalues = 4'b0011;  
		i_type_andi: 	alucontrolvalues = 4'b0100; 
		i_type_slli: 	alucontrolvalues = 4'b0101; 
		i_type_srli: 	alucontrolvalues = 4'b0110; 
		i_type_slti: 	alucontrolvalues = 4'b1001; 
		b_type_branch:  alucontrolvalues = 4'b0001;  
		i_type_lw: 		alucontrolvalues = 4'b0000;   
		s_type_sw: 		alucontrolvalues = 4'b0000;   
		j_type_jal: 	alucontrolvalues = 4'b0000;  
		i_type_jalr: 	alucontrolvalues = 4'b0000; 
		u_type_lui: 	alucontrolvalues = 4'b0000;  
		u_type_auipc: 	alucontrolvalues = 4'b0000;
		default: alucontrolvalues = 4'b1111;
	endcase
end


assign aluoperation = alucontrolvalues;

endmodule
//alucontrol