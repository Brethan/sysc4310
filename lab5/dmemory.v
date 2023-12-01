//behavioral data memory
module risc_dmemory (dmenbl, dmaddr, dmdatain, dmdataout, rdwr);
input [3:0] dmaddr;
input [7:0] dmdatain;
input dmenbl, rdwr;
output [7:0] dmdataout;
wire [3:0] dmaddr;
wire [7:0] dmdatain;
wire dmenbl, rdwr;
reg [7:0] dmdataout;
//define memory size: # of bits per reg; # of regs
//8 bits per reg; 16 regs
reg [7:0] dmemory [0:15];
//define memory contents
initial
begin
dmemory [00] = 8'h00;
dmemory [01] = 8'h22;
dmemory [02] = 8'h44;
dmemory [03] = 8'h66;
dmemory [04] = 8'h88;
dmemory [05] = 8'haa;
dmemory [06] = 8'hcc;
dmemory [07] = 8'hff;
dmemory [08] = 8'h00;
dmemory [09] = 8'h00;
dmemory [10] = 8'h00;
dmemory [11] = 8'h00;
dmemory [12] = 8'h00;
dmemory [13] = 8'h00;
dmemory [14] = 8'h00;
dmemory [15] = 8'h00;
end
always @ (dmenbl or dmaddr or dmdatain or rdwr)
begin
if (rdwr) //if true, read op (ld regfile)
dmdataout = dmemory [dmaddr];
else //if false, write op (st regfile)
dmemory [dmaddr] = dmdatain;
end
endmodule