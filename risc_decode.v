//------------------------------------------------------------------------
//the decode unit will take the instruction from IU and decodes it
// it must extract the information based on the instruction format
// these information are: opcode, operand a and operand b and address in case
// of load and store instructions

 module risc_decode (clk, rst_n, instr, dmaddr, opnda, opndb, dst, opcode);
 // fillout1: define the interface here
 // dmaddr: data memory address (for load and st instruction, must be extracted from the opcode)
 // opnda, opndb: addresses for operand a and operand b
 // dst is the destination register if applicable
	
	
	
	
	
	// internal registers and net
	reg [3:0] opcode;
	wire [3:0] opcode_i;
	reg [3:0] dmaddr_i;
	reg [2:0] opnda_i, opndb_i, dst_i;
	
	parameter ld = 4'b1110, st = 4'b1111;
	
	//fillout2: extract the opcodefrom the instruction and assign it to opcode_i
	assign opcode_i = 

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
	 dmaddr_i = 
	 dst_i = 
	 opnda_i = 
	end
	
	
	
	
	
	
	
	
	
	
	
	
	endcase
end



always @ (posedge clk or negedge rst_n)
 begin
  if (~rst_n)
	begin
	// fillout4:reset all outputs with 0
	
	
	
	end
	else
	begin
	//fillout5:
	// pass the extracted information from the
   // instructions to the next unit, this include opcode,
  // dmaddr, dst, opnda, and opndb
	
	
	
	
	
	
	
	end
end
endmodule