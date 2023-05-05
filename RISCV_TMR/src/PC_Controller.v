// PC Controller

// `include "src/PC_buffer.v"

module PC_Controller(
    clk,
    Voter_state,
    PC_voter_output,
    PC_Top,
    Recovery_Data_MemWrite_sel,
    Data_Recovery_sel
);

    input clk;
    input [2:0] Voter_state;
    input [31:0] PC_voter_output;
    output [31:0] PC_Top;
    output Recovery_Data_MemWrite_sel;
    output Data_Recovery_sel;

    wire [31:0] PC_Top_rollback;
    wire [31:0] Rollback_instr;
    wire [1:0] Recovery_stage;

    PC_buffer PC_buffer(
                .clk(clk),
                .PC_Top(PC_voter_output),
                .PC_Top_rollback(PC_Top_rollback)
    );


    assign Rollback_instr = {12'b0,PC_Top_rollback[11:7],3'b010,PC_Top_rollback[11:7],7'b0000011};
    // assign Rollback_instr = {12'b0,PC_Top_rollback[19:15],3'b010,PC_Top_rollback[19:15],7'b0000011};

    // 00000000000000000010000010000011
    assign PC_Top = Voter_state=={3'b000}?Rollback_instr:PC_voter_output;
    assign Recovery_Data_MemWrite_sel = Voter_state=={3'b000}?1'b1:1'b0;
    assign Data_Recovery_sel = Voter_state=={3'b000}?1'b1:1'b0;

    // assign PC_Top = PC_Mux_out;

endmodule