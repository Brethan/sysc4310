
//------------------------------------------------------
//*************************************************************
//test bench for decode unit
module risc_decode_tb;
 // fillout 1: define the signals
 
 
 
 

 //define clock
 initial
 begin
  clk = 1'b0;
  forever
  #10 clk = ~clk;
 end
 
//define reset
initial
 begin
  #0 rst_n = 1'b0;
  #20 rst_n = 1'b1;
 end
 
initial
begin
	
	#20 instr = 13'h0208; //add
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h05f1; //sub
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);
	
	#20 instr = 13'h06aa; //and
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h08e3; //or
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h0b1c; //xor
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h0d45; //inc
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h0f86; //dec
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	//continued on next page
	#20 instr = 13'h11c7; //not
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h1200; //neg
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h1441; //shr
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h1682; //shl
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h18c3; //ror
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h1b04; //rol
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);

	#20 instr = 13'h1e00; //st
	$display ("opcode=%b, opnda=%b, opndb=%b, dst=%b",
	instr[12:9], opnda, opndb, dst);
	#20 $stop;
end
//fillout2: instantiate the behavioral module into the test bench
risc_decode inst1 (
	
	
	
	);
endmodule