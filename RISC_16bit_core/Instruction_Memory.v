// Verilog code for RISC Processor 
// Verilog code for Instruction Memory

`include "Parameter.v"

module Instruction_Memory(
 input[15:0] pc,
 output[15:0] instruction
);

 reg [0:`col - 1] memory [0:`row_i - 1];
 wire [3 : 0] rom_addr = pc[4 : 1];
 initial
 begin
  $readmemb("test.prog", memory,0,14);
 end
 assign instruction =  memory[rom_addr]; 

endmodule