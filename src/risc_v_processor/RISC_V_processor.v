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
	input [31:0] intruction,
	input [31:0] received_data,

	output memwrite,
	output memread,
	output [31:0] data_address,
	output [31:0] writedata,
	output [31:0] pc_address,
	output [31:0] aluresultout
);

wire clk_wire = clk;
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

wire regwrite_wire;
wire memwrite_wire;

wire branch_pc_mux_wire;

wire [31:0 ]immediateextend_wire;

wire [31:0] pc_wire;

wire [31:0] reg_instruction_wire = intruction;

wire [31:0] readdata1_wire;
wire [31:0] readdata2_wire;

wire [31:0] aluresult_wire;

wire [31:0] aluout_mux_wire;

wire [31:0] b_mux_wire;

wire [3:0] aluop_wire;

wire [3:0] alu_control_wire;

wire [31:0] address_mux_wire;

wire memtoreg_wire;

wire addr_sel_wire;

//******************************************************************/
//******control units***********************************************/
control
controlunit
(
	// input
	.op(reg_instruction_wire[6:0]),
	// Para identificar las instrucciones JR, asi como para activar offset cuando ocurre SW y LW
	// no basta con el codigo de operacion, pues las instrucciones R por ejemplo no se diferencian por opcode (todas 00).
	// Sino que se utiliza func en descripciones de compuertas logicas para tener el control correcto de dichas señales.
	
	// output
	.addr_sel(addr_sel_wire),
	.beq_out(brancheq_wire),
	.bne_out(branchne_wire),
	.blt_out(branchlt_wire),
	.bge_out(branchge_wire),
	.alusrc(alusrc_wire),
	.memtoreg(memtoreg_wire),
	.regwrite(regwrite_wire),
	.memread(memread_wire),
	.memwrite(memwrite_wire),
	.aluop(aluop_wire)
);

alucontrol
alu_control
(
	.aluop(aluop_wire),
	.func3(reg_instruction_wire[14:12]),
	.func7(reg_instruction_wire[31:25]),
	
	.aluoperation(alu_control_wire)

);

//******************************************************************/
//******multiplexer*************************************************/

multiplexer2to1
#(
	.nbits(32)
)
branch_pc_mux
(
	.selector(
		(zero_wire & (brancheq_wire | branchge_wire)) |
		(~zero_wire & branchne_wire) |
		(alessb_wire & branchlt_wire) |
		(~alessb_wire & branchge_wire)
	),
	.mux_data0(4 + pc_wire),
	.mux_data1(immediateextend_wire + pc_wire),
	
	.mux_output(branch_pc_mux_wire)

);

multiplexer2to1
#(
	.nbits(32)
)
b_mux
(
	.selector(alusrc_wire),
	.mux_data0(readdata2_wire),
	.mux_data1(immediateextend_wire),
	
	.mux_output(b_mux_wire)

);

multiplexer2to1
#(
	.nbits(32)
)
aluout_mux
(
	.selector(memtoreg_wire),
	.mux_data0(aluresult_wire),
	.mux_data1(received_data),
	
	.mux_output(aluout_mux_wire)

);
//******************************************************************/
//******registers****************************************************/
pc_register
#(
	.n(32)
)
pc
(
	.clk(clk_wire),
	.reset(reset),
	.enable(1'b1),
	.newpc(branch_pc_mux_wire),
	
	
	.pcvalue(pc_wire)
);

registerfile
register_file
(
	.clk(clk_wire),
	.reset(reset),
	.regwrite(regwrite_wire),
	.writeregister(reg_instruction_wire[11:7]),
	.readregister1(reg_instruction_wire[19:15]),
	.readregister2(reg_instruction_wire[24:20]),
	.writedata(aluout_mux_wire),
	
	.readdata1(readdata1_wire),
	.readdata2(readdata2_wire)

);

//******************************************************************/
//******extend*******************************************************/
signextend
signextendforconstants
(   
	.datainput(reg_instruction_wire),
	.signextendoutput(immediateextend_wire)
);


//******************************************************************/
//******alu*********************************************************/
alu
arithmeticlogicunit 
(
	.aluoperation(alu_control_wire),
	.a(readdata1_wire),
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

assign memread = memread_wire;
assign memwrite = memwrite_wire;
assign writedata = readdata2_wire;
assign pc_address = pc_wire;
assign data_address = aluresult_wire;

endmodule
