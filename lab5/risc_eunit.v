/*
 * Module: RISC Execution Unit
 * Student Name: Ethan Bradley
 * Student Number: 101158848
 */
//-------------------------------------------------------------------
//******************************************************************

//execution unit
//mixed-design eunit
module risc_eunit (
	input wire clk, 
	input wire rst_n, 
	input wire [3:0] opcode, 
	input wire [3:0] dmaddrin, // memory address coming from decode
	input wire [7:0] oprnd_a, 
	input wire [7:0] oprnd_b, 
	input wire [2:0] dstin,
	output reg dmenbl, // control signal
	output wire rdwr, // control signal
	output reg [3:0] dmaddr, 
	output reg [7:0] rslt, 
	output reg [2:0] dst, // address of destination register
	output wire reg_wr_vld, // control signal
	output wire [7:0] dmdatain, 
	output wire load_op // control signal
);
	
	
	
	//fillout1: complete the interface list
	wire [7:0] adder_in_a;
	wire [7:0] rslt_or;
	wire [7:0] rslt_xor;
	wire [7:0] rslt_and;
	wire [7:0] rslt_shl;
	wire [7:0] rslt_shr;
	wire [7:0] rslt_ror;
	wire [7:0] rslt_rol;
	wire [7:0] rslt_not;

	wire ci; // carry in
	reg [7:0] rslt_i;
	reg [7:0] rslt_sum; //continued on next page

	reg [7:0] adder_in_b;
	reg adder_mode;
	reg co; // carry out

	//define internal registers
	reg [3:0] opcode_out;
	
	// parameters to define each instruction opcode
	parameter add = 1'b0;
	parameter sub = 1'b1;
	parameter nop_op = 4'b0000;
	parameter add_op = 4'b0001;
	parameter sub_op = 4'b0010;
	parameter and_op = 4'b0011;
	parameter or_op = 4'b0100;
	parameter xor_op = 4'b0101;
	parameter inc_op = 4'b0110;
	parameter dec_op = 4'b0111;
	parameter not_op = 4'b1000;
	parameter neg_op = 4'b1001;
	parameter shr_op = 4'b1010;
	parameter shl_op = 4'b1011;
	parameter ror_op = 4'b1100;
	parameter rol_op = 4'b1101;
	parameter ld_op = 4'b1110;
	parameter st_op = 4'b1111;
	
	//use assign stmt to show mix of dataflow and behavioral
	assign load_op = (opcode_out == ld_op);
	assign rdwr = ~(opcode_out == st_op);
	assign reg_wr_vld = (opcode_out != st_op) && (opcode_out != nop_op);
	assign dmdatain = rslt;
	
	always @ (posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			rslt <= 8'h00;
			dmaddr <= 4'h0;
			opcode_out <= 4'h0;
			dst <= 3'b000;
	  	end else begin
			rslt <= rslt_i;
			dst <= dstin;
			dmaddr <= dmaddrin;
			opcode_out <= opcode;
	  	end
    end
	
	always @ (posedge clk or negedge rst_n) begin
		if (~rst_n)
			dmenbl <= 1'b0;
	 	else if (opcode == st_op || opcode == ld_op)
			dmenbl <= 1'b1;
	 	else
			dmenbl <= 1'b0;
	end

	always @ (opcode) begin
		if ((opcode == sub_op) || (opcode == dec_op))
			adder_mode = sub;
		else
			adder_mode = add;
	end

	//determine the b-input into the adder based on the opcode
	always @ (opcode or oprnd_b) begin
		case (opcode)
				sub_op: adder_in_b = ~oprnd_b;
				inc_op: adder_in_b = 8'h01;
				neg_op: adder_in_b = 8'h01;
				dec_op: adder_in_b = ~(8'h01);
				default: adder_in_b = oprnd_b;
		endcase
	end
	
	// adder overs addition, subtraction, increment, decrement, and negation
    assign adder_in_a = (opcode == neg_op) ? ~oprnd_a : oprnd_a;
    assign ci = adder_mode;
	always @ (adder_in_a or adder_in_b or ci)
	begin
		{co, rslt_sum} = adder_in_a + adder_in_b + ci;
	end
	
	// arithmatic, logical, shift and rotate operations
	//fillout2:  complete the section for the rest
	assign rslt_or = oprnd_a | oprnd_b;
	assign rslt_xor = oprnd_a ^ oprnd_b;
	assign rslt_and = oprnd_a & oprnd_b;
	assign rslt_shr = oprnd_a >> 1;
	assign rslt_shl = oprnd_a << 1;
	assign rslt_ror = rslt_shr | (oprnd_a << 7);
	assign rslt_rol = rslt_shl | (oprnd_a >> 7);
	assign rslt_not = !oprnd_a;
	
	
	always @ (opcode or oprnd_a or oprnd_b or rslt_and or rslt_or 
		or rslt_xor or rslt_shr or rslt_shl or rslt_rol 
		or rslt_ror or rslt_sum ) begin
		case (opcode)
			// arithmetic operations
			add_op,
			sub_op,
			inc_op,
			dec_op,
			neg_op: rslt_i = rslt_sum;

			// Logical operations
			xor_op: rslt_i = rslt_xor;
			or_op: rslt_i = rslt_or;
			and_op: rslt_i = rslt_and;
			not_op: rslt_i = rslt_not;

			// Shift and rotate operations
			shr_op: rslt_i = rslt_shr;
			shl_op: rslt_i = rslt_shl;
			ror_op: rslt_i = rslt_ror;
			rol_op: rslt_i = rslt_rol;

			// Load and store
			ld_op, st_op: rslt_i = oprnd_a;

			// Default / NOP
			default: rslt_i = 8'b0;
		endcase
	end
	
endmodule
  