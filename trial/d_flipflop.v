// Trial code for checking Vivado
`timescale 1ns / 1ps

module d_flipflop(D, clk, Q);
    input D; // Data input 
    input clk; // clock input 
    output reg Q; // output Q 
    always @(posedge clk) 
    begin
     Q <= D; 
    end 
endmodule
