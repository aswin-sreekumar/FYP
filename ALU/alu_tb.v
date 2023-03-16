// ALU testbench
`timescale 1ns / 1ps  

module alu_tb;
//Inputs
 reg[3:0] A,B;
 reg[3:0] ALU_Sel;
 reg clk;

//Outputs
 wire[7:0] ALU_Out;
 wire CarryOut;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            clk,
            A,B,  // ALU 8-bit Inputs                 
            ALU_Sel,// ALU Selection
            ALU_Out, // ALU 8-bit Output
            CarryOut // Carry Out Flag
     );
initial begin
    clk=0;
    forever #10 clk = ~clk;  
end 
initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0,alu_tb);
// hold reset state for 100 ns.
    A = 4'hA;
    B = 4'h2;
    ALU_Sel = 4'h0;
    
    for (i=0;i<=15;i=i+1)
    begin
    ALU_Sel = ALU_Sel + 4'h01;
    #20;
    end;
    $finish; 
end

endmodule