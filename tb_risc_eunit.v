/*
 * Module: RISC Execution Unit Test Bench
 * Student Name: Ethan Bradley
 * Student Number: 101158848
 */

//------------------------------------------------------
//*************************************************************

//test bench for the execution unit
module risc_eunit_tb;

//fillout1: list all input and output ports
reg clk, rst_n;
reg [3:0] opcode;
reg [3:0] dmaddrin;
reg [2:0] dstin;
reg [2:0] opnda_addr;
reg [2:0] opndb_addr;
reg [7:0] dmdataout;

wire dmenbl, rdwr, reg_wr_vld, load_op;
wire [3:0] dmaddr;
wire [2:0] dst;
wire [7:0] rslt;
wire [7:0] dmdatain;
wire [7:0] oprnd_a;
wire [7:0] oprnd_b;

//fillout 2: instantiate the behavioral model into the test bench
risc_eunit inst1 (
	.clk(clk), .rst_n(rst_n), .opcode(opcode), .dmaddrin(dmaddrin),
	.oprnd_a(oprnd_a), .oprnd_b(oprnd_b), .dstin(dstin), .dmenbl(dmenbl),
	.rdwr(rdwr), .dmaddr(dmaddr), .rslt(rslt), .dst(dst), 
	.reg_wr_vld(reg_wr_vld), .dmdatain(dmdatain), .load_op(load_op)
);

risc_regfile inst2 (
	.clk(clk), .rst_n(rst_n), .reg_wr_vld(reg_wr_vld),
	.load_op(load_op), .rslt(rslt), .dst(dst), .opnda_addr(opnda_addr),
	.opndb_addr(opndb_addr), .dmdataout(dmdataout), .oprnd_a(oprnd_a),
	.oprnd_b(oprnd_b)
);

//define clock
initial begin
	clk = 1'b0;
	forever
	#10 clk = ~clk;
end

//define input vectors
initial begin
 	#0 rst_n = 1'b0;

	//add -------------------------------------------------------
	@ (negedge clk)
	rst_n = 1'b1;
	opcode = 4'b0001; //add
	opnda_addr = 3'b000; //00h + ffh
	opndb_addr = 3'b111; //rslt = ffh, next page
	// dstin = opnda_addr;

	@ (negedge clk)
	$display ("add: regfile0 = %h, regfile7 = %h, add, rslt = %h",
		inst2.regfile0, inst2.regfile7, rslt);
	
	//sub -------------------------------------------------------
	opcode = 4'b0010; //sub
	opnda_addr = 3'b001; //22h - cch
	opndb_addr = 3'b110; //rslt = 56h
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("sub: regfile1 = %h, regfile6 = %h, sub, rslt = %h",
		inst2.regfile1, inst2.regfile6, rslt);
	
	//and -------------------------------------------------------
	opcode = 4'b0011; //and
	opnda_addr = 3'b010; //44h & aah
	opndb_addr = 3'b101; //rslt = 00h
	dstin = 8'bx;
	
	@ (negedge clk)
	$display ("and: regfile2 = %h, regfile5 = %h, and, rslt = %h",
		inst2.regfile2, inst2.regfile5, rslt);
	
	//or --------------------------------------------------------
	opcode = 4'b0100; //or
	opnda_addr = 3'b011; //66h | 88h
	opndb_addr = 3'b100; //rslt = eeh
	dstin = opnda_addr;

	@ (negedge clk)
	$display (" or: regfile3 = %h, regfile4 = %h, or , rslt = %h",
		inst2.regfile3, inst2.regfile4, rslt);
	
	//xor -------------------------------------------------------
	opcode = 4'b0101; //xor
	opnda_addr = 3'b100; //88h ^ eeh
	opndb_addr = 3'b011; //rslt = 66h
	dstin = opnda_addr;

	$display("Bruh what is wrong with this xor: %h", inst2.regfile4 ^ inst2.regfile3);
	@ (negedge clk)
	$display ("xor: regfile4 = %h, regfile3 = %h, xor, rslt = %h",
		inst2.regfile4, inst2.regfile3, rslt);

	//inc -------------------------------------------------------
	opcode = 4'b0110; //inc
	opnda_addr = 3'b101; //aah + 1
	opndb_addr = 3'b000; //rslt = abh
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("inc: regfile5 = %h, regfile0 = %h, inc, rslt = %h",
		inst2.regfile5, inst2.regfile0, rslt);
	
	//dec --------------------------------------------------------
	opcode = 4'b0111; //dec
	opnda_addr = 3'b110; //cch - 1
	opndb_addr = 3'b000; //rslt = cbh
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("dec: regfile6 = %h, regfile0 = %h, dec, rslt = %h",
		inst2.regfile6, inst2.regfile0, rslt);
	
	//not --------------------------------------------------------
	opcode = 4'b1000; //not
	opnda_addr = 3'b111; //ffh = 00h
	opndb_addr = 3'b000; //rslt = 00h
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("not: regfile7 = %h, regfile0 = %h, not, rslt = %h",
		inst2.regfile7, inst2.regfile0, rslt);
	
	//neg --------------------------------------------------------
	opcode = 4'b1001; //neg
	opnda_addr = 3'b000; //00h = 00h
	opndb_addr = 3'b000; //rslt = 00h
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("neg: regfile0 = %h, regfile0 = %h, neg, rslt = %h",
		inst2.regfile0, inst2.regfile0, rslt);
	
	//shr --------------------------------------------------------
	opcode = 4'b1010; //shr
	opnda_addr = 3'b001; //56h = 2bh
	opndb_addr = 3'b000; //rslt = 2bh
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("shr: regfile1 = %h, regfile0 = %h, shr, rslt = %h",
		inst2.regfile1, inst2.regfile0, rslt);
	
	//shl --------------------------------------------------------
	opcode = 4'b1011; //shl
	opnda_addr = 3'b010; //44h = 88h
	opndb_addr = 3'b000; //rslt = 88h
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("shl: regfile2 = %h, regfile0 = %h, shl, rslt = %h",
		inst2.regfile2, inst2.regfile0, rslt);
	
	//ror --------------------------------------------------------
	opcode = 4'b1100; //ror
	opnda_addr = 3'b011; //eeh = 77h
	opndb_addr = 3'b000; //rslt = 77h
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("ror: regfile3 = %h, regfile0 = %h, ror, rslt = %h",
		inst2.regfile3, inst2.regfile0, rslt); //next pag
	
	//rol --------------------------------------------------------
	opcode = 4'b1101; //rol
	opnda_addr = 3'b100; //66h = cch
	opndb_addr = 3'b000; //rslt = cch
	dstin = opnda_addr;

	@ (negedge clk)
	$display ("rol: regfile4 = %h, regfile0 = %h, rol, rslt = %h",
		inst2.regfile4, inst2.regfile0, rslt);
	
	//-----------------------------------------------------------
	//Investigate the effect of the following lines on your circuit, 
	// which signals change as a result of the following three lines
	opcode = 4'b0000; //nop
	#20 opcode = 4'b1111; //st
	#20 opcode = 4'b0000; //nop
	#20 $stop;
end

endmodule
