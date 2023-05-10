// 32-bit Instruction memory block
`include "src/Parameters.v"
module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0] A;
  output [38:0] RD;
  reg [38:0] mem [0:31];
  
  assign RD = (~rst) ? {39{1'd0}} : mem[A[31:0]][38:0];

  initial begin
      $readmemh(`INSTR_FILE,mem);
  end

endmodule