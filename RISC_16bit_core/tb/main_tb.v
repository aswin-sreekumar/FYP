// Verilog code for RISC Processor 
// Verilog testbench code to test the processor

`timescale 1ns / 1ps
`include "./src/Parameter.v"

module main_tb;

 // Inputs
 reg clk;

 // Instantiate the Unit Under Test (UUT)
 Risc_16_bit uut (
  .clk(clk)
 );

initial begin
    $dumpfile("main_tb.vcd");
    $dumpvars(0,main_tb);
   clk <=0;
   `simulation_time;
   $finish;
  end

endmodule