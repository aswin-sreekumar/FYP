// Top level module for RISC-V core

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
`include "hamming/hamming_decoder.v"
`include "hamming/hamming_encoder.v"

module Top_module(clk,rst);

    input clk,rst;
    
    // Top level wires
    wire [31:0] PC_Top,RD_Instr;
    wire [31:0] ALUResult, ReadData, RD2_Top;
    wire MemWrite;
    wire [37:0] enc_RD_Instr;

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

    Instruction_Memory Instruction_Memory(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(enc_RD_Instr)
    );

    hamming_decoder decode_instr(
        .rcvd_data(enc_RD_Instr),
        .dec_data(RD_Instr)
    );

    Main_core Main_core_A(
                        .clk(clk),
                        .rst(rst),
                        .RD_Instr(RD_Instr),
                        .PC_Top(PC_Top_A),
                        .MemWrite(MemWrite_A),
                        .ALUResult(ALUResult_A),
                        .RD2_Top(RD2_Top_A),
                        .ReadData(ReadData)
    ); 

    Main_core Main_core_B(
                        .clk(clk),
                        .rst(rst),
                        .RD_Instr(RD_Instr),
                        .PC_Top(PC_Top_B),
                        .MemWrite(MemWrite_B),
                        .ALUResult(ALUResult_B),
                        .RD2_Top(RD2_Top_B),
                        .ReadData(ReadData)
    ); 

    Main_core Main_core_C(
                        .clk(clk),
                        .rst(rst),
                        .RD_Instr(RD_Instr),
                        .PC_Top(PC_Top_C),
                        .MemWrite(MemWrite_C),
                        .ALUResult(ALUResult_C),
                        .RD2_Top(RD2_Top_C),
                        .ReadData(ReadData)
    );                  
    
    Voter Voter(
                .rst(rst),
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
                .Voter_state(Voter_state)
    );

    Data_Memory Data_Memory(
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWrite),
                        .WD(RD2_Top),
                        .A(ALUResult),
                        .RD(ReadData)
    );

    // hamming_encoder enc_WD(
    //     .data(og_wd),
    //     .enc_data(RD2_Top)
    // );

    // hamming_decoder dec_data(
    //     .rcvd_data(ENC_Data),
    //     .dec_data(ReadData)
    // );
    
endmodule