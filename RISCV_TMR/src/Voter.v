// Verilog code for voter block
// RISC-V

`include "src/PC_buffer.v"
module Voter(
    rst_in,
    clk,
    PC_Top_A,MemWrite_A,ALUResult_A,RD2_Top_A,
    PC_Top_B,MemWrite_B,ALUResult_B,RD2_Top_B,
    PC_Top_C,MemWrite_C,ALUResult_C,RD2_Top_C,
    PC_Top,MemWrite,ALUResult,RD2_Top,
    Voter_state,
    Recovery_mode
    );

    input rst_in,clk;

    input [31:0] PC_Top_A,ALUResult_A,RD2_Top_A;
    input [31:0] PC_Top_B,ALUResult_B,RD2_Top_B;
    input [31:0] PC_Top_C,ALUResult_C,RD2_Top_C;
    input MemWrite_A,MemWrite_B,MemWrite_C;
    output [31:0] PC_Top,ALUResult,RD2_Top;
    output MemWrite;
    output [2:0] Voter_state;
    output Recovery_mode;

    wire [2:0] Comp_table_PC; //AB BC AC
    wire [2:0] Comp_table_Mem; //AB BC AC
    wire [2:0] Comp_table_ALU; //AB BC AC
    wire [2:0] Comp_table_RD2; //AB BC AC

    wire [31:0] PC_top_normal,PC_Top_rollback;

    // Bypassing voter block
    // assign PC_Top = PC_Top_A;
    // assign MemWrite = MemWrite_A;
    // assign ALUResult = ALUResult_A;
    // assign RD2_Top = RD2_Top_A;
    // assign Voter_state = 3'b111;

    assign Comp_table_PC = {PC_Top_A==PC_Top_B,PC_Top_B==PC_Top_C,PC_Top_A==PC_Top_C};
    assign Comp_table_ALU = {ALUResult_A==ALUResult_B,ALUResult_B==ALUResult_C,ALUResult_A==ALUResult_C};
    assign Comp_table_RD2 = {RD2_Top_A==RD2_Top_B,RD2_Top_B==RD2_Top_C,RD2_Top_A==RD2_Top_C};
    assign Comp_table_Mem = {MemWrite_A==MemWrite_B,MemWrite_B==MemWrite_C,MemWrite_A==MemWrite_C};

    assign Voter_state = Comp_table_PC&Comp_table_ALU&Comp_table_Mem&Comp_table_RD2;
    assign PC_top_normal = Voter_state[0]?PC_Top_A:Voter_state[1]?PC_Top_B:Voter_state[2]?PC_Top_C:0;
    assign ALUResult = Voter_state[0]?ALUResult_A:Voter_state[1]?ALUResult_B:Voter_state[2]?ALUResult_C:0;
    assign MemWrite = Voter_state[0]?MemWrite_A:Voter_state[1]?MemWrite_B:0;
    assign RD2_Top = Voter_state[0]?RD2_Top_A:Voter_state[1]?RD2_Top_B:Voter_state[2]?RD2_Top_C:0;

    PC_buffer PC_buffer(
            .clk(clk),
            .PC_Top(PC_top_normal),
            .PC_Top_rollback(PC_Top_rollback)
    );

    assign PC_Top = Voter_state=={3'b000}?PC_Top_rollback:PC_top_normal;
    assign Recovery_mode = Voter_state=={3'b000}?1'b1:1'b0;

endmodule