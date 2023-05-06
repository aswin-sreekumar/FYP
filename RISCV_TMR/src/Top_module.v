// Top level module for RISC-V core

`include "src/Rst_Controller.v"
`include "src/PC.v"
`include "src/Instruction_Memory.v"
`include "src/Register_File.v"
`include "src/Sign_Extend.v"
`include "src/ALU.v"
`include "src/Control_Unit_Top.v"
`include "src/Data_Memory.v"
`include "src/PC_Adder.v"
`include "src/Mux.v"
`include "src/Demux.v"
`include "src/Main_core.v"
`include "src/Voter.v"
`include "src/PC_Controller.v"
`include "src/Recovery_Register.v"

module Top_module(clk,main_rst);

    input clk,main_rst;

    wire rst_in,core_hold;
    
    // Top level wires
    wire [31:0] PC_Top,RD_Instr;
    wire [31:0] RD2_Top, ALUResult, ReadData;
    wire MemWrite;

    // Core A wires
    wire [31:0] PC_Top_A;
    wire [31:0] RD2_Top_A, ALUResult_A;
    wire MemWrite_A;

    // Core B wires
    wire [31:0] PC_Top_B;
    wire [31:0] RD2_Top_B, ALUResult_B;
    wire MemWrite_B;

    // Core C wires
    wire [31:0] PC_Top_C;
    wire [31:0] RD2_Top_C, ALUResult_C;
    wire MemWrite_C;

    // Voter output
    wire [2:0] Voter_state;
    wire [31:0] PC_voter_output;

    // Recovery muxes
    wire MemWrite_data;
    wire MemWrite_recovery;
    wire Recovery_Data_MemWrite_sel;
    wire Data_Recovery_sel;
    wire [31:0] ReadData_Data;
    wire [31:0] ReadData_Recovery;
    wire Recovery_mode;

    Rst_Controller Rst_Controller(
                            .main_rst(main_rst),
                            .core_hold(core_hold),
                            .rst_in(rst_in)

    );
 
    Instruction_Memory Instruction_Memory(
                            .rst_in(rst_in),
                            .A(PC_Top),
                            .RD(RD_Instr)
    );

    Main_core Main_core_A(
                        .clk(clk),
                        .rst_in(rst_in),
                        // .core_hold(core_hold),
                        .RD_Instr(RD_Instr),
                        .PC_Top(PC_Top_A),
                        .MemWrite(MemWrite_A),
                        .ALUResult(ALUResult_A),
                        .RD2_Top(RD2_Top_A),
                        .ReadData(ReadData)
    ); 

    Main_core Main_core_B(
                        .clk(clk),
                        .rst_in(rst_in),
                        .RD_Instr(RD_Instr),
                        .PC_Top(PC_Top_B),
                        .MemWrite(MemWrite_B),
                        .ALUResult(ALUResult_B),
                        .RD2_Top(RD2_Top_B),
                        .ReadData(ReadData)
    ); 

    Main_core Main_core_C(
                        .clk(clk),
                        .rst_in(rst_in),
                        .RD_Instr(RD_Instr),
                        .PC_Top(PC_Top_C),
                        .MemWrite(MemWrite_C),
                        .ALUResult(ALUResult_C),
                        .RD2_Top(RD2_Top_C),
                        .ReadData(ReadData)
    );                  

    Voter Voter(
                .rst_in(rst_in),
                .clk(clk),
                .PC_Top_A(PC_Top_A),
                .MemWrite_A(MemWrite_A),
                .ALUResult_A(ALUResult_A),
                .RD2_Top_A(RD2_Top_A),
                .PC_Top_B(PC_Top_B),
                .MemWrite_B(MemWrite_B),
                .ALUResult_B(ALUResult_B),
                .RD2_Top_B(RD2_Top_B),
                .PC_Top_C(PC_Top_C),
                .MemWrite_C(MemWrite_C),
                .ALUResult_C(ALUResult_C),
                .RD2_Top_C(RD2_Top_C),
                .PC_Top(PC_voter_output),
                .MemWrite(MemWrite),
                .ALUResult(ALUResult),
                .RD2_Top(RD2_Top),
                .Voter_state(Voter_state)
    );

    PC_Controller PC_Controller(
                .clk(clk),
                .Voter_state(Voter_state),
                .PC_voter_output(PC_voter_output),
                .PC_Top(PC_Top),
                .core_hold(core_hold),
                .Recovery_mode(Recovery_mode),
                .Recovery_Data_MemWrite_sel(Recovery_Data_MemWrite_sel),
                .Data_Recovery_sel(Data_Recovery_sel)
    );

    Demux Demux_Recovery_Data_Memwrite(
                .c(MemWrite),
                .s(Recovery_Data_MemWrite_sel),
                .a(MemWrite_data),
                .b(MemWrite_recovery)
    );

    Mux Mux_Data_Recovery(
                .a(ReadData_Data),
                .b(ReadData_Recovery),
                .s(Data_Recovery_sel),
                .c(ReadData)
    );

    Recovery_Register Recovery_Register(
                        .clk(clk),
                        .rst_in(rst_in),
                        .WE(MemWrite_recovery),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData_Recovery)
    );

    Data_Memory Data_Memory(
                        .clk(clk),
                        .rst_in(rst_in),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData_Data)
    );

endmodule