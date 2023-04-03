/**********************
* description
*	this is control unit for the mips processor. the control unit is 
*	in charge of generation of the control signals. its only input 
*	corresponds to opcode from the instruction.
*	1.0
* author:
*	dr. josé luis pizano escalante
* email:
*	luispizano@iteso.mx
* date:
*	01/03/2014
**********************/
module control
(
	input [6:0]op, //intr[31-26] opcode mips green card
	
	output addr_sel,
	output beq_out,
	output bne_out,
	output blt_out,
	output bge_out,
	output alusrc,
	output memtoreg,
	output regwrite,
	output memread,
	output memwrite,
	output [3:0] aluop

);

//localparam = c define para switch del
//intr[31-26] opcode mips green card

// "implementar en verilog un procesador basado en la arquitectura mips, el cual sea capaz de ejecutar las instrucciones 
// add, addi, sub, or, ori, and, andi, lui, nor, sll, srl, lw, sw, beq, bne, j, jal, jr" 

//add, sub, or, and, nor, sll, srl, jr 
localparam r_type       = 7'b0110011;

//B_type
localparam b_type		= 7'b1100011;

//jalr, jal 
localparam i_type_jalr 	= 7'b1100111;
localparam j_type_jal	= 7'b1101111;

//lui, auipc
localparam u_type_lui	= 7'b0110111;
localparam u_type_auipc = 7'b0010111;

//sw, lw
localparam i_type_lw   	= 7'b0000011;
localparam s_type_sw   	= 7'b0100011;

//addi, ori, andi, lui, lw, sw, beq, bne
localparam i_type		= 7'b0010011;


reg [13:0] controlvalues;


always@(op) begin
	casex(op)
		r_type:      	controlvalues = 13'b0_0000_001XX_0111;
		b_type:			controlvalues = 13'b0_01xx_xxx0x_xxxx;
		i_type_jalr:	controlvalues = 13'b0_11xx_x1x0x_xxxx;
		j_type_jal:     controlvalues = 13'b0_0001_01000_0000; 
		u_type_lui:     controlvalues = 13'b0_0001_01000_0101; 
		u_type_auipc:   controlvalues = 13'b0_0001_01000_0001;
		i_type_lw:      controlvalues = 13'b0_0001_01000_0100;
		default:
			controlvalues= 13'b0_0000_0000_0000; 
		endcase
end

//lw   = 6'h23;  10 0011
//sw   = 6'h2b;  10 1011 
//assign offset   = ((op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]) | (op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]));
//jr func jr 8 hex & op 00
//assign jr       = (~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0]&~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]); 

assign addr_sel = controlvalues[13];
assign beq 		= controlvalues[12]; // branch ~zero
assign bne 		= controlvalues[11]; // branch ~zero
assign blt 		= controlvalues[10]; // branch ~zero
assign bge 		= controlvalues[9]; // branch  zero

//assign jal		= controlvalues[12];

//assign jump		= controlvalues[11];
//assign regdst   = controlvalues[10];// rom-mux-reg : typei 0 -> rt instr[20:16], typer 1 -> rd instr[15:11]
assign alusrc   = controlvalues[8]; // reg-mux-alu : 0 -> readdata2, 1 -> immediate signextended
assign memtoreg = controlvalues[7]; // data-mux-reg: 0 -> aluresult, 1 -> readdata

assign regwrite = controlvalues[6]; // enable write: writereg (registerfile)
assign memread  = controlvalues[5]; // enable out readdata  (datamemory)
assign memwrite = controlvalues[4]; // enable in  writedata (datamemory)

assign aluop    = controlvalues[3:0];	// 

endmodule
//control