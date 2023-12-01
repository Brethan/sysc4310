/*
 * Module: RISC Decode
 * Student Name: Ethan Bradley
 * Student Number: 101158848
 */

//------------------------------------------------------------------------
//the decode unit will take the instruction from IU and decodes it
// it must extract the information based on the instruction format
// these information are: opcode, operand a and operand b and address in case
// of load and store instructions

module risc_decode (
	input wire clk, 
	input wire rst_n, 
	input wire [12:0] instr, 
	output reg [3:0] dmaddr, 
	output reg [2:0] opnda, 
	output reg [2:0] opndb, 
	output reg [2:0] dst, 
	output reg [3:0] opcode
);


wire [3:0] opcode_i;
reg [3:0] dmaddr_i;
reg [2:0] opnda_i;
reg [2:0] opndb_i = 3'b0;
reg [2:0] dst_i;


parameter ld = 4'b1110, st = 4'b1111;

parameter add = 4'b0001, sub = 4'b0010;
parameter AND = 4'b0011, OR = 4'b0100;
parameter XOR = 4'b0101, inc = 4'b0110;
parameter dec = 4'b0111, NOT = 4'b1000;
parameter neg = 4'b1001, shr = 4'b1010;
parameter shl = 4'b1011, ror = 4'b1100;
parameter rol = 4'b1101, nop = 4'b0000;

//fillout2: extract the opcode from the instruction and assign it to opcode
assign opcode_i = instr[12:9];

// in this always block you need to chack the opcode,
// and depending on the opcode you will have to extract information accordingly
// note that the format for arithmatic/logical instructions are the same,
// so you need to check if the opcode represents a load, a store or arithmatic/logical
// make sure to consider a default for your case, so if something goes wrong it resets
//	to a specific case
// refer to the instructions format given in the lab document

always @ (opcode_i or instr)
begin
	//fillout3:
	case (opcode_i)
	ld: begin
		dmaddr_i <= instr[7:4];
		dst_i	 <= instr[2:0];
		opnda_i	 <= 3'b000;
	end
	st: begin
		dmaddr_i <= instr[3:0];
		dst_i	 <=  3'b000;
		opnda_i	 <= instr[6:4];
	end
	add, sub, AND, OR, XOR,
	inc, dec, NOT, neg, shr,
	shl, ror, rol: begin
		dmaddr_i <= 4'b0000;
		opnda_i	 <= instr[8:6];
		opndb_i	 <= instr[5:3];
		dst_i	 <= instr[2:0];
	end
	default: begin
		dmaddr_i <= 4'b0000;
		dst_i	 <= 3'b000;
		opnda_i	 <= 3'b000;
		opndb_i	 <= 3'b000;
	end
	endcase
end



always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
	// fillout4: reset all outputs with 0
		opcode <= 4'b0;
		dmaddr <= 4'b0;
		opnda <= 3'b0;
		opndb <= 3'b0;
		dst <= 3'b0;

	end else begin
	//fillout5:
	// pass the extracted information from the
	// instructions to the next unit, this include opcode,
	// dmaddr, dst, opnda, and opndb
		opcode <= opcode_i;
		dmaddr <= dmaddr_i;
		opnda <= opnda_i;
		opndb <= opndb_i;
		dst <= dst_i;
	end
end
endmodule