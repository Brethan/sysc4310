//------------------------------------------------------
//*************************************************************

//test bench for the execution unit
module risc_eunit_tb;

	//fillout1: list all input and output ports



	 
//define clock
initial
 begin
   clk = 1'b0;
   forever
   #10 clk = ~clk;
end


initial //define input vectors
begin
 #0 rst_n = 1'b0;
	//add -------------------------------------------------------
	@ (negedge clk)
	rst_n = 1'b1;
	opcode = 4'b0001; //add
	opnda_addr = 3'b000; //00h + ffh
	opndb_addr = 3'b111; //rslt = ffh, next page
	@ (negedge clk)
	$display ("regfile0 = %h, regfile7 = %h, add, rslt = %h",
	regfile0, regfile7, rslt);
	
	//sub -------------------------------------------------------
	opcode = 4'b0010; //sub
	opnda_addr = 3'b001; //22h - cch
	opndb_addr = 3'b110; //rslt = 56h
	@ (negedge clk)
	$display ("regfile1 = %h, regfile6 = %h, sub, rslt = %h",
	regfile1, regfile6, rslt);
	
	//and -------------------------------------------------------
	opcode = 4'b0011; //and
	opnda_addr = 3'b010; //44h & aah
	opndb_addr = 3'b101; //rslt = 00h
	@ (negedge clk)
	$display ("regfile2 = %h, regfile5 = %h, and, rslt = %h",
	regfile2, regfile5, rslt);
	
	//or --------------------------------------------------------
	opcode = 4'b0100; //or
	opnda_addr = 3'b011; //66h | 88h
	opndb_addr = 3'b100; //rslt = eeh
	@ (negedge clk)
	$display ("regfile3 = %h, regfile4 = %h, or , rslt = %h",
	regfile3, regfile4, rslt);
	
	//xor -------------------------------------------------------
	opcode = 4'b0101; //xor
	opnda_addr = 3'b100; //88h ^ eeh
	opndb_addr = 3'b011; //rslt = 66h
	@ (negedge clk)
	$display ("regfile4 = %h, regfile3 = %h, xor, rslt = %h",
	regfile4, regfile3, rslt);
	
	//inc -------------------------------------------------------
	opcode = 4'b0110; //inc
	opnda_addr = 3'b101; //aah + 1
	opndb_addr = 3'b000; //rslt = abh
	@ (negedge clk)
	$display ("regfile5 = %h, regfile0 = %h, inc, rslt = %h",
	regfile5, regfile0, rslt);
	
	//dec --------------------------------------------------------
	opcode = 4'b0111; //dec
	opnda_addr = 3'b110; //cch - 1
	opndb_addr = 3'b000; //rslt = cbh
	@ (negedge clk)
	$display ("regfile6 = %h, regfile0 = %h, dec, rslt = %h",
	regfile6, regfile0, rslt);
	
	//not --------------------------------------------------------
	opcode = 4'b1000; //not
	opnda_addr = 3'b111; //ffh = 00h
	opndb_addr = 3'b000; //rslt = 00h
	@ (negedge clk)
	$display ("regfile7 = %h, regfile0 = %h, not, rslt = %h",
	regfile7, regfile0, rslt);
	
	//neg --------------------------------------------------------
	opcode = 4'b1001; //neg
	opnda_addr = 3'b000; //00h = 00h
	opndb_addr = 3'b000; //rslt = 00h
	@ (negedge clk)
	$display ("regfile0 = %h, regfile0 = %h, neg, rslt = %h",
	regfile0, regfile0, rslt);
	
	//shr --------------------------------------------------------
	opcode = 4'b1010; //shr
	opnda_addr = 3'b001; //56h = 2bh
	opndb_addr = 3'b000; //rslt = 2bh
	@ (negedge clk)
	$display ("regfile1 = %h, regfile0 = %h, shr, rslt = %h",
	regfile1, regfile0, rslt);
	
	//shl --------------------------------------------------------
	opcode = 4'b1011; //shl
	opnda_addr = 3'b010; //44h = 88h
	opndb_addr = 3'b000; //rslt = 88h
	@ (negedge clk)
	$display ("regfile2 = %h, regfile0 = %h, shl, rslt = %h",
	regfile2, regfile0, rslt);
	
	//ror --------------------------------------------------------
	opcode = 4'b1100; //ror
	opnda_addr = 3'b011; //eeh = 77h
	opndb_addr = 3'b000; //rslt = 77h
	@ (negedge clk)
	$display ("regfile3 = %h, regfile0 = %h, ror, rslt = %h",
	regfile3, regfile0, rslt); //next pag
	
	//rol --------------------------------------------------------
	opcode = 4'b1101; //rol
	opnda_addr = 3'b100; //66h = cch
	opndb_addr = 3'b000; //rslt = cch
	@ (negedge clk)
	$display ("regfile4 = %h, regfile0 = %h, rol, rslt = %h",
	regfile4, regfile0, rslt);
	
	//-----------------------------------------------------------
	//Investigate the effect of the following lines on your circuit, 
	// which signals change as a result of the following three lines
	opcode = 4'b0000; //nop
	#20 opcode = 4'b1111; //st
	#20 opcode = 4'b0000; //nop
	#20 $stop;
end
//fillout 2: instantiate the behavioral model into the test bench
risc_eunit inst1 (
	
);
endmodule
