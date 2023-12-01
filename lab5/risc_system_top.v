//structural system_top
module risc_system_top (clk, rst_n);
input clk, rst_n;
wire clk, rst_n, dmenbl, rdwr;
wire [12:0] instruction;
wire [4:0] pc;
wire [3:0] dmaddr;
wire [7:0] dmdatain, dmdataout;

risc_imemory inst1 (
.pc(pc),
.instruction(instruction)
);

risc_dmemory inst2 ( 
.dmenbl(dmenbl),
.dmaddr(dmaddr),
.dmdatain(dmdatain),
.rdwr(rdwr),
.dmdataout(dmdataout)
);

risc_cpu_top1 risc (
.clk(clk),
.rst_n(rst_n),
.pc(pc),
.instruction(instruction),
.dmenbl(dmenbl),
.dmaddr(dmaddr),
.dmdatain(dmdatain),
.rdwr(rdwr),
.dmdataout(dmdataout)
);
endmodule