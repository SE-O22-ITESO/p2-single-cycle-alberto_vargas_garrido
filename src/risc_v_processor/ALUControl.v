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
localparam r_type_add    = 13'b111_10_0000; // funct = 20 hex
localparam r_type_sub    = 13'b111_10_0010; // funct = 22 hex
localparam r_type_or     = 13'b111_10_0101; // funct = 25 hex
localparam r_type_and    = 13'b111_10_0100; // funct = 24 hex
localparam r_type_nor    = 13'b111_10_0111; // funct = 27 hex
localparam r_type_sll    = 13'b111_00_0000; // funct = 00 hex
localparam r_type_srl    = 13'b111_00_0010; // funct = 02 hex
localparam r_type_jr     = 13'b111_00_1000; // funct = 08 hex
localparam r_type_mul    = 13'b111_00_1000; // funct = 08 hex

// jump j, jal 
// no aplican a la alu

localparam i_type_addi   = 13'b000_xxx_xxx; 
localparam i_type_ori    = 13'b101_xxx_xxx;
localparam i_type_andi   = 13'b001_xxx_xxx;
localparam i_type_lui    = 13'b100_xxx_xxx;

localparam i_type_beq    = 13'b010_xxx_xxx;
localparam i_type_bneq   = 13'b011_xxx_xxx;

localparam i_type_lw     = 13'b000_xxx_xxx; //usan add
localparam i_type_sw     = 13'b000_xxx_xxx; //usan add




reg [3:0] alucontrolvalues;
wire [8:0] selector;

assign selector = {aluop, func3, func7};

always@(selector)begin
	casex(selector)
		
		// add, sub, or, and, nor, sll, srl, jr 
		r_type_add:    	alucontrolvalues = 4'b0000;
		r_type_and: 		alucontrolvalues = 4'b0001;
		r_type_nor: 		alucontrolvalues = 4'b0011;
		r_type_or :  		alucontrolvalues = 4'b0100;
		r_type_sub :  		alucontrolvalues = 4'b0111;
		
		r_type_sll:			alucontrolvalues = 4'b0101;
		r_type_srl:			alucontrolvalues = 4'b0110;
		
		//addi, ori, andi, lui, lw, sw, beq, bne
		i_type_addi:		alucontrolvalues = 4'b0000;
		i_type_andi: 		alucontrolvalues = 4'b0001;
		i_type_lui : 		alucontrolvalues = 4'b0010;
		i_type_ori : 		alucontrolvalues = 4'b0100;
		
		i_type_lw : 		alucontrolvalues = 4'b0000; // add r[rs]+signextimm
		i_type_sw : 		alucontrolvalues = 4'b0000; // add r[rs]+signextimm
		
		i_type_beq : 		alucontrolvalues = 4'b0111; // sub r[rs]-r[rt]	
		i_type_bneq:		alucontrolvalues = 4'b0111; // sub r[rs]-r[rt]	
				
				
		default: alucontrolvalues = 4'b1111;
	endcase
end


assign aluoperation = alucontrolvalues;

endmodule
//alucontrol