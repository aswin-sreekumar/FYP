// Trial testbench for D-flipflop
`timescale 1ns / 1ps

module testbench();
reg D;
reg clk;
wire Q;

d_flipflop dut(D,clk,Q);

initial begin
  clk=0;
     forever #10 clk = ~clk;  
end 
initial begin 
 D <= 0;
 #100;
 D <= 1;
 #100;
 D <= 0;
 #100;
 D <= 1;
end 
endmodule 
