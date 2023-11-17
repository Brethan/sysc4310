//---------------------------------------------------
//****************************************************


module risc_regfile (clk, rst_n, rslt, reg_wr_vld, load_op,
    dst, dmdataout,opnda_addr, opndb_addr, oprnd_a, oprnd_b );

  //fillout1: complete the list of interface
  input clk, rst_n, reg_wr_vld, load_op;
	  
	  
	  
	  
	  
	  
	//specify which are wire or reg by width
	//inputs are wire for behavioral
	wire [7:0] rslt, dmdataout;
	wire [2:0] dst;
	wire[7:0] reg_data_in;
	
	// fillout2: define registers for the register file here, call them regfile0,...regfile7
	// remember there are 8 registers in total in the register file
	
	// fillout3: define an enable signal (type wire) for each register, 
	// call them: regfile0_enbl, ...regfile7_enbl
	
	
	
	
	// fillout4: enables for each register file
	// enable signals will be activated if the destination code addresses 
	// that perticular register AND if write valid signal is activated
	// complete this section for the rest of enable signals
	assign regfile0_enbl = (dst == 3'h0) & reg_wr_vld;
	assign regfile1_enbl = 
	assign regfile2_enbl = 
	assign regfile3_enbl = 
	assign regfile4_enbl = 
	assign regfile5_enbl = 
	assign regfile6_enbl = 
	assign regfile7_enbl = 

    //define reg_mux outputs from the eight 2:1 muxs
    // the input data is calculated based on wether the instruction is  a load
	// or other data processing instructions
    assign reg_data_in = load_op ? dmdataout : rslt;
	//define the operation of the regfile
	
	
	// reset all regfiles (registers) when reset is activated
	// otherwise assign the input data (reg_data_in) to a register if its corresponding 
	// enable signal has been activated
	always @ (posedge clk or negedge rst_n)
	begin
	if (~rst_n) begin 
	   //fillout5: reset all registers
		regfile0 <= 8'h00;
		
		
		
		
		
		
	end else begin 
	// fillout6: when enable signal is activated pass in the data to a specific register
         if (regfile0_enbl) regfile0 <= reg_data_in;








    end
	
	// in the following two always blocks we want to check which registers we must pass to
	// the output as operand a and operand b.
	
	
	// fillout7: depending on opnda_addr, you must pass the required register content
	// to the oprnd_a. for example if opnda_addr=0, it mean regfile0 is operand a.
	
	always @ (opnda_addr or regfile0 or regfile1 or regfile2 or
	 regfile3 or regfile4 or regfile5 or regfile6 or
	 regfile7)
	  begin
	   case (opnda_addr)
	    0: oprnd_a = regfile0;
	    
		
		
		
		
		
		
		
		
	  default: oprnd_a = 0;
	 endcase
	end

	// fillout 8: make a simliar always block like above for operand b





	
	
endmodule