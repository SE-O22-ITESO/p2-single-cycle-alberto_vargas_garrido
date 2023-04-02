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
	input [5:0]op, //intr[31-26] opcode mips green card
	input [5:0]func, // only for jr
	
	output regdst,
	output branchne,
	output brancheq,
	output [2:0]aluop,
	output memwrite,
	output memread,
	output memtoreg,
	output jump,
	output alusrc,
	output regwrite,
	output jal,
	output jr,
	output offset
);

//localparam = c define para switch del
//intr[31-26] opcode mips green card

// "implementar en verilog un procesador basado en la arquitectura mips, el cual sea capaz de ejecutar las instrucciones 
// add, addi, sub, or, ori, and, andi, lui, nor, sll, srl, lw, sw, beq, bne, j, jal, jr" 

//add, sub, or, and, nor, sll, srl, jr 
localparam r_type      = 6'h00;

//j, jal 
localparam j_type		  = 6'h02;
localparam jal_type	  = 6'h03;

//addi, ori, andi, lui, lw, sw, beq, bne
localparam i_type_addi = 6'h08;
localparam i_type_ori  = 6'h0d;
localparam i_type_andi = 6'h0c;
localparam i_type_lui  = 6'h0f;
localparam i_type_lw   = 6'h23;
localparam i_type_sw   = 6'h2b;
localparam i_type_beq  = 6'h04;
localparam i_type_bneq = 6'h05;



reg [12:0] controlvalues;


always@(op) begin
	casex(op)
		r_type     :      controlvalues = 13'b0_0100_1000_0111;
		j_type	  :		controlvalues = 13'b0_1xxx_xx0x_xxxx;
		jal_type	  :		controlvalues = 13'b1_1xxx_1x0x_xxxx;
		i_type_addi:      controlvalues = 13'b0_0010_1000_0000; 
		i_type_ori :      controlvalues = 13'b0_0010_1000_0101; 
		i_type_andi:      controlvalues = 13'b0_0010_1000_0001;
		i_type_lui :      controlvalues = 13'b0_0010_1000_0100;
		i_type_lw  :      controlvalues = 13'b0_0011_1100_0000;
		i_type_sw  :      controlvalues = 13'b0_0010_0010_0000;
		i_type_beq :      controlvalues = 13'b0_0000_0000_1010;
		i_type_bneq:      controlvalues = 13'b0_0000_0001_0011;
		
		
		
		default:
			controlvalues= 13'b0_0000_0000_0000; 
		endcase
end

//lw   = 6'h23;  10 0011
//sw   = 6'h2b;  10 1011 
//assign offset   = ((op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0]) | (op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0]));
//jr func jr 8 hex & op 00
//assign jr       = (~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0]&~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0]); 
assign jal		 = controlvalues[12];

assign jump		 = controlvalues[11];
assign regdst   = controlvalues[10];// rom-mux-reg : typei 0 -> rt instr[20:16], typer 1 -> rd instr[15:11]
assign alusrc   = controlvalues[9]; // reg-mux-alu : 0 -> readdata2, 1 -> immediate signextended
assign memtoreg = controlvalues[8]; // data-mux-reg: 0 -> aluresult, 1 -> readdata

assign regwrite = controlvalues[7]; // enable write: writereg (registerfile)
assign memread  = controlvalues[6]; // enable out readdata  (datamemory)
assign memwrite = controlvalues[5]; // enable in  writedata (datamemory)
assign branchne = controlvalues[4]; // branch ~zero

assign brancheq = controlvalues[3]; // branch  zero
assign aluop    = controlvalues[2:0];	// 

endmodule
//control