module risc_cpu_top1 (clk, rst_n, instruction, pc, dmenbl,
dmaddr, dmdatain, dmdataout, rdwr);

input wire clk, rst_n;
input wire [12:0] instruction;
output wire [4:0] pc;
output wire dmenbl, rdwr;
output wire [3:0] dmaddr;
output wire [7:0] dmdatain, dmdataout;


//fillout 1: define all wires you may need here
// to connect the modules you need to use wires, 
// for example if one module's output is an input to another 
// module you must define use a wire to make this connection. 
// review the modules block diagram to find this information.

// Instruction Unit wires
wire [12:0] ir;

// Decode Unit Wires
wire [12:0] instr;
assign instr = ir;
wire [3:0] opcode;
wire [3:0] dmaddr;
wire [2:0] opnda;
wire [2:0] opndb;
wire [2:0] dst;

// Execution Unit Wires
wire [2:0] dstin;
assign dstin = dst;
wire[ 3:0] dmaddr_o;
wire [3:0] dmaddrin;
assign dmaddrin = dmaddr;
wire [7:0] oprnd_a;
wire [7:0] oprnd_b;
wire [7:0] rslt;
wire load_op;
wire reg_wr_vld;
wire [2:0] dst_o;


// Regfile Wire
wire [2:0] opnda_addr;
wire [2:0] opndb_addr;
assign opnda_addr = opnda;
assign opndb_addr = opndb;




// fillout2: instantiate iunit
risc_iunit iunit (
	.clk(clk), 
	.rst_n(rst_n), 
	.instruction(instruction), 
	.pc(pc), 
	.ir(ir)
);

// fillout3: instantiate decode unit
risc_decode decode (
	.clk(clk), .rst_n(rst_n), .instr(instr),
	.dmaddr(dmaddr), .opnda(opnda), .opndb(opndb),
	.dst(dst), .opcode(opcode)
);

//fillout4
risc_eunit eunit (
	.clk(clk), .rst_n(rst_n), .opcode(opcode), .dmaddrin(dmaddrin),
	.oprnd_a(oprnd_a), .oprnd_b(oprnd_b), .dstin(dstin), .dmenbl(dmenbl),
	.rdwr(rdwr), .dmaddr_o(dmaddr_o), .rslt(rslt), .dst_o(dst_o), 
	.reg_wr_vld(reg_wr_vld), .dmdatain(dmdatain), .load_op(load_op)
);

// fillout5
risc_regfile regfile (
	.clk(clk), .rst_n(rst_n), .reg_wr_vld(reg_wr_vld),
	.load_op(load_op), .rslt(rslt), .dst(dst_o), .opnda_addr(opnda_addr),
	.opndb_addr(opndb_addr), .dmdataout(dmdataout), .oprnd_a(oprnd_a),
	.oprnd_b(oprnd_b)
);

endmodule