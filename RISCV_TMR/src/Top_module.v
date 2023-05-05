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
`include "src/Main_core.v"
`include "src/Voter.v"
`include "src/Lockstep.v"
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

    // Recovery module
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
                .PC_Top(PC_Top),
                .MemWrite(MemWrite),
                .ALUResult(ALUResult),
                .RD2_Top(RD2_Top),
                .Voter_state(Voter_state),
                .Recovery_mode(Recovery_mode)
    );

    Lockstep Lockstep(
                    .Recovery_mode(Recovery_mode),
                    .Voter_state(Voter_state),
                    .core_hold(core_hold)
    );

    // Mux Mux_Recovery_to_Register(
    //                         .a(),
    //                         .b(),
    //                         .c(),
    //                         .s()
    // );

    // Recovery_Register Recovery_Register(
    //                     .clk(clk),
    //                     .rst_in(rst_in),
    //                     .WE(),
    //                     .WD(),
    //                     .RD(),
    //                     .A()
    // );

    Data_Memory Data_Memory(
                        .clk(clk),
                        .rst_in(rst_in),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData)
    );

endmodule