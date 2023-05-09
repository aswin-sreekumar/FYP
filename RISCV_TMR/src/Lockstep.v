// Lockstep module

module Lockstep(
    clk,
    rst_in,
    Voter_state,
    RD_Instr,
    core_hold,
    Recovery_mode,
    Mux_Instr_sel,
    Mux_Data_sel,
    Rollback_instr
);

    input [2:0] Voter_state;
    input clk, rst_in;
    output core_hold;
    output Recovery_mode;
    output [31:0] RD_Instr;

    reg [31:0] RD_Instr_buffer;

    reg [3:0] Recovery_stage;
    reg [31:0] Rollback_instr_buffer;

    output [31:0] Rollback_instr;
    assign Rollback_instr = Rollback_instr_buffer;
    reg Mux_Instr_sel_buffer;
    reg Mux_Data_sel_buffer;

    output Mux_Instr_sel,Mux_Data_sel;
    // assign Mux_Data_sel = Mux_Data_sel_buffer;
    assign Mux_Instr_sel = Mux_Instr_sel_buffer;
    assign Mux_Data_sel = Mux_Data_sel_buffer;
    assign core_hold = Voter_state=={3'b000}?1'b0:1'b0;
    assign Recovery_mode = (Voter_state=={3'b000})?1'b1:1'b0;
    
    initial begin
        Rollback_instr_buffer = 32'b0;
        Recovery_stage = 4'b0000;
        Mux_Instr_sel_buffer = 1'b0;
        Mux_Data_sel_buffer = 1'b0;
    end

    always @(posedge Recovery_mode) begin
        Recovery_stage = 4'b1111;
        RD_Instr_buffer = RD_Instr;
    end

    always @(posedge clk) begin
        if(Recovery_stage==4'b1111)
            begin
                Recovery_stage = Recovery_stage>>1'b1;
                RD_Instr_buffer = RD_Instr;
                Rollback_instr_buffer = {7'b0,RD_Instr[11:7],5'b0,3'b011,RD_Instr[11:7],7'b0000011};
                Mux_Instr_sel_buffer = 1'b1;
                Mux_Data_sel_buffer = 1'b1;
            end
        else if(Recovery_stage==4'b0111)
            begin
                Rollback_instr_buffer = {7'b0,RD_Instr_buffer[19:15],5'b0,3'b011,RD_Instr_buffer[19:15],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
                Mux_Instr_sel_buffer = 1'b1;
                Mux_Data_sel_buffer = 1'b1;
            end
        else if(Recovery_stage==4'b0011)
            begin
                Rollback_instr_buffer = {7'b0,RD_Instr_buffer[24:20],5'b0,3'b011,RD_Instr_buffer[24:20],7'b0000011};
                Recovery_stage = Recovery_stage>>1'b1;
                Mux_Instr_sel_buffer = 1'b1;
                Mux_Data_sel_buffer = 1'b1;
            end
        else if(Recovery_stage==4'b0001)
            begin
                Rollback_instr_buffer = RD_Instr_buffer;
                Recovery_stage = Recovery_stage>>1'b1;
                Mux_Instr_sel_buffer = 1'b1;
                Mux_Data_sel_buffer = 1'b1;
            end
        
        else if(Recovery_stage==4'b0000)
            begin
                Mux_Instr_sel_buffer = 1'b0;
                Mux_Data_sel_buffer = 1'b0;
            end
    end

endmodule