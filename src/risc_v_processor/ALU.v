/******************************************************************
* description
*	this is an 32-bit arithetic logic unit that can execute the next set of operations:
*		add
*		sub
*		or
*		and
*		nor
* this alu is written by using behavioral description.
* version:
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
******************************************************************/

module alu 
(
	input [3:0] aluoperation,
	input [31:0] a,
	input [31:0] b,
	output reg zero,
	output reg alessb,
	output reg [31:0] aluresult
);

// localparam == c define. 
// no tienen que coindicir con el green sheet de mips
localparam alu_add = 4'b0000;
localparam alu_sub = 4'b0001;
localparam alu_xor = 4'b0010;
localparam alu_or = 4'b0011;
localparam alu_and  = 4'b0100;
localparam i_alu_sll = 4'b0101;
localparam i_alu_srl = 4'b0110;
localparam r_alu_sll = 4'b0111;
localparam r_alu_srl = 4'b1000;
localparam alu_slt = 4'b1001;
localparam r_alu_mul = 4'b1010;
   
   always @ (a or b or aluoperation)
     begin
		case (aluoperation)
		  alu_and:
			aluresult = a & b;
		  alu_or:
			aluresult = a | b;
		  alu_xor:
			aluresult = a ^ b;
		  alu_add: 
			aluresult =  a + b;
		  alu_sub: 
			aluresult =  a - b;
		  r_alu_sll:
		   aluresult = a << b;
		  r_alu_srl:
		   aluresult = a >> b;
		  i_alu_sll:
		   aluresult = a << b[4:0];
		  i_alu_srl:
		   aluresult = a >> b[4:0];
		  alu_slt:
		   aluresult = (a < b) ? 1'b1 : 1'b0;
		  r_alu_mul:
		   aluresult = a*b;
		default: //also 1111
			aluresult = 0;
		endcase // case(control)
		zero = (aluresult==0) ? 1'b1 : 1'b0;
		alessb = (aluresult < 0) ? 1'b1 : 1'b0;
     end // always @ (a or b or control)
endmodule // alu
