// PC Controller

// `include "src/PC_buffer.v"

module PC_Controller(
    clk,
    Voter_state,
    PC_voter_output,
    PC_Top,
    Recovery_Data_MemWrite_sel,
    Data_Recovery_sel,
    core_hold,
    Recovery_mode
);

    input clk;
    input [2:0] Voter_state;
    input [31:0] PC_voter_output;
    output [31:0] PC_Top;
    output Recovery_Data_MemWrite_sel;
    output Data_Recovery_sel;
    output core_hold;
    output Recovery_mode;

    wire [31:0] PC_Top_rollback;
    reg [31:0] Rollback_instr;
    reg [1:0] Recovery_stage;

    PC_buffer PC_buffer(
                .clk(clk),
                .PC_Top(PC_voter_output),
                .PC_Top_rollback(PC_Top_rollback)
    );

    initial begin
        Recovery_stage = 2'b00;
    end
    
    always @(posedge clk) begin
        if(Recovery_stage==2'b11)
            begin
                Rollback_instr = {12'b0,PC_Top_rollback[11:7],3'b010,PC_Top_rollback[11:7],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
            end
        else if(Recovery_stage==2'b01)
            begin
                Rollback_instr = {12'b0,PC_Top_rollback[19:15],3'b010,PC_Top_rollback[19:15],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
            end 
    end

    always @(posedge Recovery_mode) begin
        Recovery_stage = 2'b11;   
    end

    assign core_hold = Voter_state=={3'b000}?1'b1:1'b0;
    assign Recovery_mode = (Voter_state=={3'b000})?1'b1:Recovery_stage?1'b1:1'b0;
    // assign Recovery_mode = core_hold;
    // assign Rollback_instr = {12'b0,PC_Top_rollback[19:15],3'b010,PC_Top_rollback[19:15],7'b0000011};

    // 00000000000000000010000010000011
    assign PC_Top = Recovery_mode?Rollback_instr:PC_voter_output;
    assign Recovery_Data_MemWrite_sel = Recovery_mode?1'b1:1'b0;
    assign Data_Recovery_sel = Recovery_mode?1'b1:1'b0;

    // assign PC_Top = PC_Mux_out;

endmodule