// 32-bit Instruction memory block
`include "src/Parameters.v"
module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [0:31];
  
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:0]];

  initial begin
    // mem [0] = 
    $readmemh(`INSTR_FILE,mem);
    // $display("\n%b",mem[0]);
  end

endmodule