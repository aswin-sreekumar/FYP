// PC Controller

module PC_Controller(
    clk,
    rst_in,
    Voter_state,
    PC_voter_output,
    PC_Top,
    RD_Instr,
    Recovery_Data_MemWrite_sel,
    Data_Recovery_sel,
    core_hold,
    Recovery_mode,
    RD_Instr_Mux_sel,
    RD_Instr_recovery
);

    input clk;
    input rst_in;
    input [2:0] Voter_state;
    input [31:0] PC_voter_output;
    input [31:0] RD_Instr;
    output [31:0] PC_Top;
    output [31:0] RD_Instr_recovery;
    output RD_Instr_Mux_sel;
    output Recovery_Data_MemWrite_sel;
    output Data_Recovery_sel;
    output core_hold;
    output Recovery_mode;

    reg [31:0] PC_Top_buffer [0:1];
    reg [31:0] RD_Instr_buffer [0:1];
    reg [31:0] Rollback_instr;
    reg [2:0] Recovery_stage;

    initial begin
        PC_Top_buffer[0] = 32'd0;
        PC_Top_buffer[1] = 32'd0;
        Recovery_stage = 3'b000;
    end

    always @(posedge clk & !Recovery_mode) begin
        PC_Top_buffer[1] = PC_Top_buffer[0];
        PC_Top_buffer[0] = PC_Top;  
        RD_Instr_buffer[1] = RD_Instr_buffer[0];
        RD_Instr_buffer[0] = RD_Instr; 
    end

    always @(posedge clk) begin
        if(Recovery_stage==3'b111)
            begin
                Rollback_instr = {12'b0,RD_Instr_buffer[1][11:7],3'b010,RD_Instr_buffer[1][11:7],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
            end
        else if(Recovery_stage==3'b011)
            begin
                Rollback_instr = {12'b0,RD_Instr[19:15],3'b010,RD_Instr[19:15],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
            end
        else if(Recovery_stage==3'b001)
            begin
                Rollback_instr = {12'b0,RD_Instr[24:20],3'b010,RD_Instr[24:20],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
            end 
    end

    always @(posedge Recovery_mode) begin
        Recovery_stage = 3'b111;   
    end
    
    assign core_hold = Voter_state=={3'b000}?1'b0:1'b0;
    assign Recovery_mode = (Voter_state=={3'b000})?1'b1:1'b0;
    // assign Recovery_mode = core_hold;
    // assign Rollback_instr = {12'b0,PC_Top_rollback[19:15],3'b010,PC_Top_rollback[19:15],7'b0000011};

    // 00000000000000000010000010000011
    assign PC_Top = PC_Top_buffer[1];
    assign RD_Instr_recovery = Rollback_instr;
    assign Recovery_Data_MemWrite_sel = Recovery_mode?1'b1:1'b0;
    assign Data_Recovery_sel = Recovery_mode?1'b1:1'b0;
    assign RD_Instr_Mux_sel = Recovery_mode?1'b1:1'b0;
    // assign PC_Top = PC_Mux_out;

endmodule