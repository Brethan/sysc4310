
/*
 * Module: RISC Register File
 * Student Name: Ethan Bradley
 * Student Number: 101158848
 */
//---------------------------------------------------
//****************************************************


//fillout1: complete the list of interface
module risc_regfile (
	// Control signals
	input wire clk, 
	input wire rst_n, 
	
	// From Execution Unit
	input wire reg_wr_vld, 
	input wire load_op,
	input wire [7:0] rslt,
	input wire [2:0] dst_o,
	
	// From Decode Unit
    input wire [2:0] dst,
	input wire [2:0] opnda_addr, 
	input wire [2:0] opndb_addr, 
	
	// From Data memory
	input wire [7:0] dmdataout,

	// To Execution Unit
	output reg [7:0] oprnd_a, 
	output reg [7:0] oprnd_b 
);

	wire [7:0] reg_data_in;
	
	// fillout2: define registers for the register file here, call them regfile0,...regfile7
	// remember there are 8 registers in total in the register file
	reg [7:0] regfile0;
	reg [7:0] regfile1;
	reg [7:0] regfile2;
	reg [7:0] regfile3;
	reg [7:0] regfile4;
	reg [7:0] regfile5;
	reg [7:0] regfile6;
	reg [7:0] regfile7;

	
	// fillout3: define an enable signal (type wire) for each register, 
	// call them: regfile0_enbl, ...regfile7_enbl
	
	wire regfile0_enbl;
	wire regfile1_enbl;
	wire regfile2_enbl;
	wire regfile3_enbl;
	wire regfile4_enbl;
	wire regfile5_enbl;
	wire regfile6_enbl;
	wire regfile7_enbl;

	wire [2:0] dstin;
	assign dstin = load_op ? dst : dst_o;

	// fillout4: enables for each register file
	// enable signals will be activated if the destination code addresses 
	// that perticular register AND if write valid signal is activated
	// complete this section for the rest of enable signals
	assign regfile0_enbl = (dstin == 3'h0) & reg_wr_vld;
	assign regfile1_enbl = (dstin == 3'h1) & reg_wr_vld;
	assign regfile2_enbl = (dstin == 3'h2) & reg_wr_vld;
	assign regfile3_enbl = (dstin == 3'h3) & reg_wr_vld;
	assign regfile4_enbl = (dstin == 3'h4) & reg_wr_vld;
	assign regfile5_enbl = (dstin == 3'h5) & reg_wr_vld;
	assign regfile6_enbl = (dstin == 3'h6) & reg_wr_vld;
	assign regfile7_enbl = (dstin == 3'h7) & reg_wr_vld;

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
		regfile1 <= 8'h00;
		regfile2 <= 8'h00;
		regfile3 <= 8'h00;
		regfile4 <= 8'h00;
		regfile5 <= 8'h00;
		regfile6 <= 8'h00;
		regfile7 <= 8'h00;
		
	end else begin 
	// fillout6: when enable signal is activated pass in the data to a specific register
        if (regfile0_enbl) regfile0 <= reg_data_in;
        if (regfile1_enbl) regfile1 <= reg_data_in;
        if (regfile2_enbl) regfile2 <= reg_data_in;
        if (regfile3_enbl) regfile3 <= reg_data_in;
        if (regfile4_enbl) regfile4 <= reg_data_in;
        if (regfile5_enbl) regfile5 <= reg_data_in;
        if (regfile6_enbl) regfile6 <= reg_data_in;
        if (regfile7_enbl) regfile7 <= reg_data_in;
    end
	
	// in the following two always blocks we want to check which registers we must pass to
	// the output as operand a and operand b.
	
	
	// fillout7: depending on opnda_addr, you must pass the required register content
	// to the oprnd_a. for example if opnda_addr=0, it mean regfile0 is operand a.
	end 

	always @ (opnda_addr or regfile0 or regfile1 or regfile2 or
	 regfile3 or regfile4 or regfile5 or regfile6 or regfile7) begin
		case (opnda_addr)
			0: oprnd_a <= regfile0;
			1: oprnd_a <= regfile1;
			2: oprnd_a <= regfile2;
			3: oprnd_a <= regfile3;
			4: oprnd_a <= regfile4;
			5: oprnd_a <= regfile5;
			6: oprnd_a <= regfile6;
			7: oprnd_a <= regfile7;
			default: 
				oprnd_a <= 0;
		endcase
	end

	// fillout 8: make a simliar always block like above for operand b
	always @ (opndb_addr or regfile0 or regfile1 or regfile2 or
	 regfile3 or regfile4 or regfile5 or regfile6 or regfile7) begin
		case (opndb_addr)
			0: oprnd_b <= regfile0;
			1: oprnd_b <= regfile1;
			2: oprnd_b <= regfile2;
			3: oprnd_b <= regfile3;
			4: oprnd_b <= regfile4;
			5: oprnd_b <= regfile5;
			6: oprnd_b <= regfile6;
			7: oprnd_b <= regfile7;
			default: oprnd_b <= 0;
		endcase
	end




	
	
endmodule