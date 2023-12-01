
/*
 * Module: RISC Register File Test Bench
 * Student Name: Ethan Bradley
 * Student Number: 101158848
 */

//------------------------------------------------------
//*************************************************************
//test bench for regfile
module risc_regfile_tb;
	//fillout1: define the required sinals for inputs and outputs here

	reg clk, rst_n = 1'b1, reg_wr_vld, load_op;
	reg [7:0] rslt;
	reg [2:0] dst;
	reg [2:0] opnda_addr;
	reg [2:0] opndb_addr;
	reg [7:0] dmdataout;

	wire [7:0] oprnd_a;
	wire [7:0] oprnd_b;
	
	//fillout 3: instantiate the behavioral module into the test bench
	risc_regfile inst1 (
		.clk(clk), .rst_n(rst_n), .reg_wr_vld(reg_wr_vld),
		.load_op(load_op), .rslt(rslt), .dst(dst), .opnda_addr(opnda_addr),
		.opndb_addr(opndb_addr), .dmdataout(dmdataout), .oprnd_a(oprnd_a),
		.oprnd_b(oprnd_b)
	);

	//define clock
	initial
	begin
	clk = 1'b0;
	forever #10 clk = ~clk;
	end 
	
	//define input vectors
	initial
	begin
	#0 rst_n = 1'b0;
	@ (negedge clk)
	rst_n = 1'b1;
	
	
	//Outputting proper opernads: reg0 and reg1------------------------
	 opnda_addr = 3'b000 ;  // regfile0
	 opndb_addr = 3'b001 ;  // regfile1
	 @ (negedge clk)
	 $display ("oprnd_a = %h, oprnd_b = %h", oprnd_a, oprnd_b);
	 
	 //Outputting proper opernads: reg2 and reg3------------------------
	 opnda_addr = 3'b010 ;  // regfile2
	 opndb_addr = 3'b011 ;  // regfile3
	 @ (negedge clk)
	 $display ("oprnd_a = %h, oprnd_b = %h", oprnd_a, oprnd_b);
	 
	 //Outputting proper opernads: reg4 and reg5------------------------
	 opnda_addr = 3'b100 ;  // regfile4
	 opndb_addr = 3'b101 ;  // regfile5
	 @ (negedge clk)
	 $display ("oprnd_a = %h, oprnd_b = %h", oprnd_a, oprnd_b);
	 
	  //Outputting proper opernads: reg6 and reg7------------------------
	 opnda_addr = 3'b110 ;  // regfile6
	 opndb_addr = 3'b111 ;  // regfile7
	 @ (negedge clk)
	 $display ("oprnd_a = %h, oprnd_b = %h", oprnd_a, oprnd_b);
	
	//regfile0 ---------------------------------------------------
	dst = 3'b000; //regfile0 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b0; //rslt is used
	rslt = 8'h00; //8'h00 ---> regfile0
	dmdataout = 8'h00;
	@ (negedge clk)
	$display ("rslt = %h, regfile0 = %h", rslt, inst1.regfile0);
	
	//regfile2 ---------------------------------------------------
	dst = 3'b010; //regfile2 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b0; //rslt is used
	rslt = 8'h22; //8'h22 ---> regfile2
	dmdataout = 8'h00;
	@ (negedge clk)
	$display ("rslt = %h, regfile2 = %h", rslt, inst1.regfile2);
	
	//regfile4 ---------------------------------------------------
	dst = 3'b100; //regfile4 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b0; //rslt is used
	rslt = 8'h44; //8'h44 ---> regfile4
	dmdataout = 8'h00;
	@ (negedge clk)
	$display ("rslt = %h, regfile4 = %h", rslt, inst1.regfile4);
	
	//regfile6 ---------------------------------------------------
	dst = 3'b110; //regfile6 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b0; //rslt is used
	rslt = 8'h66; //8'h66 ---> regfile6
	dmdataout = 8'h00;
	@ (negedge clk)
	$display ("rslt = %h, regfile6 = %h", rslt, inst1.regfile6);
	
	//regfile1 ---------------------------------------------------
	dst = 3'b001; //regfile1 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b1; //dmdataout is used
	rslt = 8'h00;
	dmdataout = 8'h11; //8'h11 ---> regfile1
	@ (negedge clk)
	$display ("dmdataout = %h, regfile1 = %h",
	dmdataout, inst1.regfile1);
	
	//regfile3 ---------------------------------------------------
	dst = 3'b011; //regfile3 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b1; //dmdataout is used
	rslt = 8'h00;
	dmdataout = 8'h33; //8'h33 ---> regfile3
	@ (negedge clk)
	$display ("dmdataout = %h, regfile3 = %h",
	dmdataout, inst1.regfile3);
	
	//regfile5 ---------------------------------------------------
	dst = 3'b101; //regfile5 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b1; //dmdataout is used
	rslt = 8'h00;
	dmdataout = 8'h55; //8'h55 ---> regfile5
	@ (negedge clk)
	$display ("dmdataout = %h, regfile5 = %h",
	dmdataout, inst1.regfile5);
	
	//regfile7 ---------------------------------------------------
	dst = 3'b111; //regfile7 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b1; //dmdataout is used
	rslt = 8'h00;
	dmdataout = 8'h77; //8'h77 ---> regfile7
	@ (negedge clk)
	$display ("dmdataout = %h, regfile7 = %h",
	dmdataout, inst1.regfile7);
	
	//regfile0 -------------------------------------------------
	dst = 3'b000; //regfile0 is dst
	reg_wr_vld = 1'b1;
	load_op = 1'b1; //dmdataout is used
	rslt = 8'h00; //8'h00 ---> regfile0
	dmdataout = 8'h00;
	@ (negedge clk)
	$display ("rslt = %h, regfile0 = %h", rslt, inst1.regfile0);
	
	
	
	
	//$stop;
	end
	

endmodule