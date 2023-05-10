// Verilog code for voter block
// RISC-V

module Voter(
    rst_in,
    clk,
    PC_Top_A,MemWrite_A,ALUResult_A,RD2_Top_A,
    PC_Top_B,MemWrite_B,ALUResult_B,RD2_Top_B,
    PC_Top_C,MemWrite_C,ALUResult_C,RD2_Top_C,
    PC_Top,MemWrite,ALUResult,RD2_Top,
    Voter_state
    );

    input rst_in,clk;

    input [31:0] PC_Top_A,ALUResult_A,RD2_Top_A;
    input [31:0] PC_Top_B,ALUResult_B,RD2_Top_B;
    input [31:0] PC_Top_C,ALUResult_C,RD2_Top_C;
    input MemWrite_A,MemWrite_B,MemWrite_C;
    output [31:0] PC_Top,ALUResult,RD2_Top;
    output MemWrite;
    output reg [2:0] Voter_state;

    wire [2:0] Comp_table_PC; //AB BC AC
    wire [2:0] Comp_table_Mem; //AB BC AC
    wire [2:0] Comp_table_ALU; //AB BC AC
    wire [2:0] Comp_table_RD2; //AB BC AC

    wire [31:0] PC_top_normal,PC_Top_rollback;

    integer state=0;

    // Bypassing voter block
    // assign PC_Top = PC_Top_A;
    // assign MemWrite = MemWrite_A;
    // assign ALUResult = ALUResult_A;
    // assign RD2_Top = RD2_Top_A;
    // assign Voter_state = 3'b111;

    // Creating Voter state FSM for debugging
    // always @(posedge clk) begin
    //     if(~rst_in)
    //         Voter_state = 3'b111;
    //     if(rst_in&(state==0)) begin
    //         Voter_state = 3'b111;
    //         state = 1;
    //     end
    //     else if(rst_in&(state==1)) begin
    //         Voter_state = 3'b000;
    //         state = 2;
    //     end
    //     else if(rst_in&(state==2)) begin
    //         Voter_state = 3'b111;
    //         state = 3;
    //     end
    //     else if(rst_in&(state==3)) begin
    //         Voter_state = 3'b111;
    //         state = 4;
    //     end
    //     else if(rst_in&(state==4)) begin
    //         Voter_state = 3'b111;
    //         state = 0;
    //     end
    // end

    assign Comp_table_PC = (~rst_in)?32'b0:{PC_Top_A==PC_Top_B,PC_Top_B==PC_Top_C,PC_Top_A==PC_Top_C};
    assign Comp_table_ALU = (~rst_in)?32'b0:{ALUResult_A==ALUResult_B,ALUResult_B==ALUResult_C,ALUResult_A==ALUResult_C};
    assign Comp_table_RD2 = (~rst_in)?32'b0:{RD2_Top_A==RD2_Top_B,RD2_Top_B==RD2_Top_C,RD2_Top_A==RD2_Top_C};
    assign Comp_table_Mem = (~rst_in)?1'b0:{MemWrite_A==MemWrite_B,MemWrite_B==MemWrite_C,MemWrite_A==MemWrite_C};

    // assign Voter_state = (~rst_in)?3'b111:3'b000;
    assign Voter_state = (~rst_in)?3'b111:Comp_table_PC&Comp_table_ALU&Comp_table_Mem&Comp_table_RD2;
    assign PC_Top = (~rst_in)?32'b0:Voter_state[2]?PC_Top_A:Voter_state[1]?PC_Top_B:Voter_state[0]?PC_Top_C:PC_Top_A;
    assign ALUResult = (~rst_in)?32'b0:Voter_state[2]?ALUResult_A:Voter_state[1]?ALUResult_B:Voter_state[0]?ALUResult_C:ALUResult_A;
    assign MemWrite = (~rst_in)?32'b0:Voter_state[2]?MemWrite_A:Voter_state[1]?MemWrite_B:Voter_state[0]?MemWrite_C:MemWrite_A;
    assign RD2_Top = (~rst_in)?32'b0:Voter_state[2]?RD2_Top_A:Voter_state[1]?RD2_Top_B:Voter_state[0]?RD2_Top_C:RD2_Top_A;

endmodule