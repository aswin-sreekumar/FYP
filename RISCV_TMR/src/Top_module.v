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
`include "SECDED/SECDED_Decoder.v"
`include "SECDED/SECDED_Encoder.v"

module Top_module(clk,rst);

    input clk,rst;
    
    // Top level wires
    wire [31:0] PC_Top,RD_Instr;
    wire [31:0] ALUResult, ReadData, RD2_Top;
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
    //additional wires
    wire [38:0] Encoded_Instruction, Encoded_Write_Data, Encoded_Read_Data;

    Instruction_Memory Instruction_Memory(
                            .rst(rst),
                            .A(PC_Top),
                            .RD(Encoded_Instruction)
    );

    SECDED_Decoder Decoding_Instruction(
        .rcvd_data(Encoded_Instruction[38:0]),
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

    SECDED_Encoder Encoding_Write_Data(
        .data(RD2_Top),
        .enc_data(Encoded_Write_Data)
    );

    Data_Memory Data_Memory(
                        .clk(clk),
                        .rst(rst),
                        .WE(MemWrite),
                        .WD(Encoded_Write_Data),
                        .A(ALUResult),
                        .RD(Encoded_Read_Data)
    );

    SECDED_Decoder Decoding_Read_Data(
        .rcvd_data(Encoded_Read_Data),
        .dec_data(ReadData)
    );
    
endmodule