// Verilog code for voter block
// RISC-V

module Voter(
    rst,
    PC_Top_A,MemWrite_A,ALUResult_A,RD2_Top_A,
    PC_Top_B,MemWrite_B,ALUResult_B,RD2_Top_B,
    PC_Top_C,MemWrite_C,ALUResult_C,RD2_Top_C,
    PC_Top,MemWrite,ALUResult,RD2_Top,
    Voter_state
    );

    input rst;

    input [31:0] PC_Top_A,ALUResult_A,RD2_Top_A;
    input [31:0] PC_Top_B,ALUResult_B,RD2_Top_B;
    input [31:0] PC_Top_C,ALUResult_C,RD2_Top_C;
    input MemWrite_A,MemWrite_B,MemWrite_C;
    output [31:0] PC_Top,ALUResult,RD2_Top;
    output MemWrite;
    output [2:0] Voter_state;

    integer state;
    wire [2:0] Comp_table [3:0]; //AB BC AC

    // Bypassing voter block
    // assign PC_Top = PC_Top_A;
    // assign MemWrite = MemWrite_A;
    // assign ALUResult = ALUResult_A;
    // assign RD2_Top = RD2_Top_A;

    assign Comp_table[0] = {PC_Top_A==PC_Top_B,PC_Top_B==PC_Top_C,PC_Top_A==PC_Top_C};
    assign Comp_table[1] = {ALUResult_A==ALUResult_B,ALUResult_B==ALUResult_C,ALUResult_A==ALUResult_C};
    assign Comp_table[2] = {RD2_Top_A==RD2_Top_B,RD2_Top_B==RD2_Top_C,RD2_Top_A==RD2_Top_C};
    assign Comp_table[3] = {MemWrite_A==MemWrite_B,MemWrite_B==MemWrite_C,MemWrite_A==MemWrite_C};

    assign Voter_state = Comp_table[0]&&Comp_table[1]&&Comp_table[2]&&Comp_table[3];
    
    assign PC_Top = Voter_state[0]?PC_Top_A:Voter_state[1]?PC_Top_B:PC_Top_C;
    assign ALUResult = Voter_state[0]?ALUResult_A:Voter_state[1]?ALUResult_B:ALUResult_C;
    assign MemWrite = Voter_state[0]?MemWrite_A:Voter_state[1]?MemWrite_B:MemWrite_C;
    assign RD2_Top = Voter_state[0]?RD2_Top_A:Voter_state[1]?RD2_Top_B:RD2_Top_C;

    
endmodule