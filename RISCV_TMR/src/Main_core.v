// Core unit of RISC-V processor
// Control unit + Register file + ALU

module Main_core(clk,rst_in,RD_Instr,PC_Top,ReadData,MemWrite,ALUResult,RD2_Top);

    input clk,rst_in;
    input [31:0] RD_Instr;
    output [31:0] PC_Top;

    input [31:0] ReadData;
    output MemWrite;
    output [31:0] ALUResult, RD2_Top;

    wire [31:0] RD1_Top,Imm_Ext_Top,PCPlus4,SrcB,Result;
    wire RegWrite,ALUSrc,ResultSrc;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;

    wire OverFlow,Carry,Zero,Negative;

    PC_Module PC(
        .clk(clk),
        .rst_in(rst_in),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    PC_Adder PC_Adder(
                    .a(PC_Top),
                    .b(32'd4),
                    .c(PCPlus4)
    );

    Register_File Register_File(
                            .clk(clk),
                            .rst_in(rst_in),
                            .WE3(RegWrite),
                            .WD3(Result),
                            .A1(RD_Instr[19:15]),
                            .A2(RD_Instr[24:20]),
                            .A3(RD_Instr[11:7]),
                            .RD1(RD1_Top),
                            .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
                        .In(RD_Instr),
                        .ImmSrc(ImmSrc[0]),
                        .Imm_Ext(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
                            .a(RD2_Top),
                            .b(Imm_Ext_Top),
                            .s(ALUSrc),
                            .c(SrcB)
    );

    ALU ALU(
            .A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .OverFlow(OverFlow),
            .Carry(Carry),
            .Zero(Zero),
            .Negative(Negative)
    );

    Control_Unit_Top Control_Unit_Top(
                            .Op(RD_Instr[6:0]),
                            .RegWrite(RegWrite),
                            .ImmSrc(ImmSrc),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            .Branch(),
                            .funct3(RD_Instr[14:12]),
                            .funct7(RD_Instr[31:25]),
                            .ALUControl(ALUControl_Top)
    );

    Mux Mux_DataMemory_to_Register(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

endmodule