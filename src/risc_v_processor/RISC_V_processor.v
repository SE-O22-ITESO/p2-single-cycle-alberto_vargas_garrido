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
	output [31:0] pc_address
	//output [31:0] aluresultout
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

wire [31:0] ifid_intruction_wire;

wire [31:0] branch_pc_mux_wire;

wire [31:0 ]immediateextend_wire;

wire [31:0] pc_wire;
wire [31:0] ifid_pc_wire;

wire [31:0] reg_instruction_wire;

wire [31:0] readdata1_wire;
wire [31:0] readdata2_wire;

wire [31:0] aluresult_wire;

wire [31:0] aluout_mux_wire;

wire [31:0] a_mux_wire;
wire [31:0] b_mux_wire;

wire [3:0] aluop_wire;

wire [3:0] alu_control_wire;

wire [31:0] alu_pc_mux_wire;

wire [31:0] address_mux_wire;
wire address_sel_wire;

wire [1:0]memtoreg_wire;

wire alu_pc_sel_wire;

wire jal_wire;

wire a_alusrc_wire;
wire [1:0] b_alusrc_wire;

wire memread_wire;

wire zero_wire;
wire alessb_wire;

////Pipelines wires////
wire idex_address_sel_wire;
wire idex_jal_wire;
wire idex_alu_pc_sel_wire;
wire idex_brancheq_wire;
wire idex_branchne_wire;
wire idex_branchlt_wire;
wire idex_branchge_wire;
wire idex_a_alusrc_wire;
wire [1:0] idex_b_alusrc_wire;
wire [1:0] idex_memtoreg_wire;
wire idex_regwrite_wire;
wire idex_memread_wire;
wire idex_memwrite_wire;
wire [3:0] idex_aluop_wire;
wire [31:0] idex_ifid_pc_wire;
wire [31:0] idex_readdata1_wire; 
wire [31:0] idex_readdata2_wire; 
wire [31:0] idex_immediateextend_wire;
wire [21:0] idex_ifid_intruction_wire;

//******************************************************************/
//******control units***********************************************/
control
controlunit
(
	// input
	.op(ifid_intruction_wire[6:0]),
	.func3(ifid_intruction_wire[14:12]),
	// Para identificar las instrucciones JR, asi como para activar offset cuando ocurre SW y LW
	// no basta con el codigo de operacion, pues las instrucciones R por ejemplo no se diferencian por opcode (todas 00).
	// Sino que se utiliza func en descripciones de compuertas logicas para tener el control correcto de dichas señales.
	
	// output
	.address_sel(address_sel_wire),
	.jal(jal_wire),
	.alu_pc_sel(alu_pc_sel_wire),
	.beq_out(brancheq_wire),
	.bne_out(branchne_wire),
	.blt_out(branchlt_wire),
	.bge_out(branchge_wire),
	.a_alusrc(a_alusrc_wire),
	.b_alusrc(b_alusrc_wire),
	.memtoreg(memtoreg_wire),
	.regwrite(regwrite_wire),
	.memread(memread_wire),
	.memwrite(memwrite_wire),
	.aluop(aluop_wire)
);

alucontrol
alu_control
(
	.aluop(),
	.func3(),
	.func7(),
	
	.aluoperation(alu_control_wire)

);

//******************************************************************/
//******multiplexer*************************************************/

//(zero_wire & (brancheq_wire | branchge_wire)) |
//		(~zero_wire & branchne_wire) |
//		(alessb_wire & branchlt_wire) |
//		(~alessb_wire & branchge_wire)) |
//		jal_wire

multiplexer2to1
#(
	.nbits(32)
)
branch_pc_mux
(
	.selector(),
	.mux_data0(),
	.mux_data1(),
	
	.mux_output()

);

multiplexer2to1
#(
	.nbits(32)
)
alu_pc_mux
(
	.selector(),
	.mux_data0(),
	.mux_data1(),
	
	.mux_output()

);

multiplexer2to1
#(
	.nbits(32)
)
a_mux
(
	.selector(),
	.mux_data0(),
	.mux_data1(),
	
	.mux_output()

);

multiplexer4to1
#(
	.nbits(32)
)
b_mux
(
	.selector(),
	.mux_data0(),
	.mux_data1(),
	.mux_data2(),
	.mux_data3(),

	.mux_output()

);

multiplexer4to1
#(
	.nbits(32)
)
aluout_mux
(
	.selector(),
	.mux_data0(),
	.mux_data1(),
	.mux_data2(),
	.mux_data3(),
	
	.mux_output()

);

multiplexer2to1
#(
	.nbits(32)
)
address_mux
(
	.selector(),
	.mux_data0(),
	.mux_data1(),
	
	.mux_output()

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
	.newpc(),
	
	
	.pcvalue(pc_wire)
);

registerfile
register_file
(
	.clk(clk_wire),
	.reset(reset),
	.regwrite(),
	.writeregister(),
	.readregister1(ifid_intruction_wire[19:15]),
	.readregister2(ifid_intruction_wire[24:20]),
	.writedata(),
	
	.readdata1(readdata1_wire),
	.readdata2(readdata2_wire)

);
//******************************************************************/
//******pipeline*******************************************************/

registerpipeline
#(
	.n(64)
)
pipeline_ifid
(
	.clk(clk_wire),
	.reset(reset),
	.enable(),
    .clear(),
	.datainput({pc_wire, intruction}),
	
	.dataoutput({ifid_pc_wire, ifid_intruction_wire})
);

registerpipeline
#(
	.n(32+32+32+32+7+3+7+5+19)
)
pipeline_idex
(
	.clk(clk_wire),
	.reset(reset),
	.enable(),
    .clear(),
	.datainput({
		address_sel_wire,
		jal_wire,
		alu_pc_sel_wire,
		brancheq_wire,
		branchne_wire,
		branchlt_wire,
		branchge_wire,
		a_alusrc_wire,
		b_alusrc_wire,
		memtoreg_wire,
		regwrite_wire,
		memread_wire,
		memwrite_wire,
		aluop_wire,
		ifid_pc_wire,
		readdata1_wire, 
		readdata2_wire, 
		immediateextend_wire,
		ifid_intruction_wire[31:25],
		ifid_intruction_wire[14:12],
		ifid_intruction_wire[6:0],
		ifid_intruction_wire[11:7]
	}),
	
	.dataoutput({
		idex_address_sel_wire,
		idex_jal_wire,
		idex_alu_pc_sel_wire,
		idex_brancheq_wire,
		idex_branchne_wire,
		idex_branchlt_wire,
		idex_branchge_wire,
		idex_a_alusrc_wire,
		idex_b_alusrc_wire,
		idex_memtoreg_wire,
		idex_regwrite_wire,
		idex_memread_wire,
		idex_memwrite_wire,
		idex_aluop_wire,
		idex_ifid_pc_wire,
		idex_readdata1_wire, 
		idex_readdata2_wire, 
		idex_immediateextend_wire,
		idex_ifid_intruction_wire[21:15],
		idex_ifid_intruction_wire[14:12],
		idex_ifid_intruction_wire[11:5],
		idex_ifid_intruction_wire[4:0]
	})
);

registerpipeline
#(
	.n(32)
)
pipeline_exmem
(
	.clk(clk_wire),
	.reset(reset),
	.enable(),
    .clear(),
	.datainput(),
	
	.dataoutput()
);

registerpipeline
#(
	.n(32)
)
pipeline_memwb
(
	.clk(clk_wire),
	.reset(reset),
	.enable(),
    .clear(),
	.datainput(),
	
	.dataoutput()
);

//******************************************************************/
//******extend******************************************************/
signextend
signextendforconstants
(   
	.datainput(ifid_intruction_wire),
	.signextendoutput(immediateextend_wire)
);


//******************************************************************/
//******alu*********************************************************/
alu
arithmeticlogicunit 
(
	.aluoperation(),
	.a(),
	.b(),
	
	.zero(),
	.alessb(),
	.aluresult()
);

//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//*assign section***************************************************/

//assign memread = memread_wire;
//assign memwrite = memwrite_wire;
//assign writedata = readdata2_wire;
assign pc_address = pc_wire;
assign data_address = address_mux_wire;

endmodule
