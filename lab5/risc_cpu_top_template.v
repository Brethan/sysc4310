module risc_cpu_top1 (clk, rst_n, instruction, pc, dmenbl,
dmaddr, dcdatain, dmdataout, rdwr);
input clk, rst_n;
input [12:0] instruction;
output [4:0] pc;
output dmenbl, rdwr;
output [3:0] dmaddr;
output [7:0] dcdatain, dmdataout;


//fillout 1: define all wires you may need here
// to connect the modules you need to use wires, 
// for example if one module's output is an input to another 
// module you must define use a wire to make this connection. 
// review the modules block diagram to find this information.








// fillout2: instantiate iunit
risc_iunit inst1 (



);

// fillout3: instantiate decode unit
risc_decode inst2 (




);

//fillout4
risc_eunit inst3 (





);

// fillout5
risc_regfile inst4 (






);
endmodule