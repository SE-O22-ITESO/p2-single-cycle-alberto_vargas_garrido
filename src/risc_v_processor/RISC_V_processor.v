/******************************************************************
* description
*	this is the top-level of a mips processor
* this processor is written verilog-hdl. also, it is synthesizable into hardware.
* parameter memory_depth configures the program memory to allocate the program to
* be execute. if the size of the program changes, thus, memory_depth must change.
* this processor was made for computer organization class at iteso.
******************************************************************/

//******************************************************************/
//******top module**************************************************/
module RISC_V_processor
#(
	parameter memory_depth = 64 //if the size of the program changes, thus, memory_depth must change.
	// 92 es el numero de palabras en el archivo text.dat generado por mips.
	// Este es el numero de palabras de 32 bits en el que se traduce nuestro programa hanoi.asm por MARS
	// y se guarda en la memoria ROM (memoria del programa).
)(
	input clk,
	input reset,
	input [31:0] received_data,

	output memwrite,
	output [31:0] writedata,
	output [31:0] relative_address,
	output [31:0] aluresultout
);

wire clk_wire;
//******wire decl.**************************************************/
// Se agregaron por separado señales de control para las instrucciones branch.
// Esto a fin de poderlas utilizar en conjunto con una compuerta AND con el valor zero
// de alu. Es necesario separarlas pues una ha de activarse con zero = 1 (BNE R[rs] != R[rt]), 
// mientras que la otra depende de zero = 0 (BEQ, pues ambos parametros eran R[rs] == R[rt]).
// Dichas compuestas se declaran en el selector de 1 MUX especializado (MUX PC1 - BRANCH) 
// para decidir el PC new value dependiendo de si procede o no una instruccion Branch.
wire branchne_wire;
wire brancheq_wire;
wire branchlt_wire;
wire branchge_wire;
//-------------------
wire pcwrite_wire;
wire [3:0] aluop_wire;
//wire memwrite;
wire memread;
wire memtoreg;
// Señal utilizada en el MUX PC2 - JUMP, activa si la instruccion siendo leida es j jal
wire jump;
wire alusrc_wire;
wire regwrite_wire;
wire [2:0]immsrc_wire;
wire addrsrc_wire;
wire memwrite_wire;
wire iren_wire;
wire [1:0]resultsrc_wire;
wire [1:0]alusrca_wire;
wire [1:0]alusrcb_wire;

//alu control
wire [3:0] state_wire;
//mux
wire [15:0] mux_immmediate_offset_wire;
wire [31:0] mux_jal_wire;
wire [31:0] pctobranch_wire;
wire [31:0] mux_pc4_branch_wire;
wire [31:0] mux_pc_jump_wire;
wire [31:0] mux_pcjump_jr_wire;
wire [4:0]  writeregister_wire;
wire [4:0]  ritype_rajal_wire;
wire [31:0] readdata2orinmmediate_wire;
wire [31:0] datamemory_aluresult;
wire [31:0] memaddress_mux_reg;
wire [31:0] a_mux_wire;
wire [31:0] b_mux_wire;
//adder
wire [31:0] pc_4_wire;
wire [31:0] jump_address_fix_wire;
//divider
wire [15:0] actual_offset_wire;

//registers
wire [31:0] pc_wire;
wire [31:0] instruction_wire;
wire [31:0] reg_instruction_wire;
wire [31:0] datamemory_rd_wire;
wire [31:0] readdata1_wire;
wire [31:0] readdata2_wire;
wire [31:0] aluout_register_wire;
wire [31:0] memdata_register_wire;
wire [31:0] a_register_wire;
wire [31:0] b_register_wire;
wire [31:0] old_pc_wire;
//extend
wire [31:0] immediateextend_wire;

//alu
wire zero_wire;
wire alessb_wire;
wire [31:0] aluresult_wire;
wire [31:0] aluaut_mux_wire;

assign clk_wire = clk;
assign instruction_wire = received_data;
assign datamemory_rd_wire = received_data;

//******************************************************************/
//******control units***********************************************/
control
controlunit
(
	// input
	.clk(clk_wire),
	.rst(reset),
	.op(reg_instruction_wire[6:0]),
	// Para identificar las instrucciones JR, asi como para activar offset cuando ocurre SW y LW
	// no basta con el codigo de operacion, pues las instrucciones R por ejemplo no se diferencian por opcode (todas 00).
	// Sino que se utiliza func en descripciones de compuertas logicas para tener el control correcto de dichas señales.
	.func3(reg_instruction_wire[14:12]),
	.func7(reg_instruction_wire[31:25]),
	
	// output
	.controlvalues({
		brancheq_wire,
		branchne_wire,
		branchlt_wire,
		branchge_wire,
		pcwrite_wire,
		immsrc_wire,
		addrsrc_wire,
		memwrite_wire,
		iren_wire,
		resultsrc_wire,
		alusrca_wire,
		alusrcb_wire,
		regwrite_wire,
		aluop_wire
	})
);

//******************************************************************/
//******multiplexer*************************************************/


//******************************************************************/
//******registers****************************************************/


//******************************************************************/
//******extend*******************************************************/
signextend
signextendforconstants
(   
	.datainput(reg_instruction_wire),
	.select(immsrc_wire),
	.signextendoutput(immediateextend_wire)
);


//******************************************************************/
//******alu*********************************************************/
alu
arithmeticlogicunit 
(
	.aluoperation(aluop_wire),
	.a(a_mux_wire),
	.b(b_mux_wire),
	
	.zero(zero_wire),
	.alessb(alessb_wire),
	.aluresult(aluresult_wire)
);

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//*assign section***************************************************/

assign memwrite = memwrite_wire;
assign writedata = b_register_wire;
assign relative_address = memaddress_mux_reg;
assign aluresultout = aluaut_mux_wire;

endmodule
