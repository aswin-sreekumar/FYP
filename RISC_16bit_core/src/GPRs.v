// Verilog code for RISC Processor 
// Verilog code for register file
`timescale 1ns / 1ps 

module GPRs(
 input    clk,
 // write port
 input    reg_write_en,
 input  [2:0] reg_write_dest,
 input  [15:0] reg_write_data,
 //read port 1
 input  [2:0] reg_read_addr_1,
 output  [15:0] reg_read_data_1,
 //read port 2
 input  [2:0] reg_read_addr_2,
 output  [15:0] reg_read_data_2
);
 reg [15:0] reg_array [7:0];
 integer i;
 // write port
 //reg [2:0] i;
 initial begin
  for(i=0;i<8;i=i+1)
   reg_array[i] <= 16'd0;
   $monitor("\ntime = %d\n", $time, 
  "\treg_array[0] = %b\n", reg_array[0],   
  "\treg_array[1] = %b\n", reg_array[1],
  "\treg_array[2] = %b\n", reg_array[2],
  "\treg_array[3] = %b\n", reg_array[3],
  "\treg_array[4] = %b\n", reg_array[4],
  "\treg_array[5] = %b\n", reg_array[5],
  "\treg_array[6] = %b\n", reg_array[6],
  "\treg_array[7] = %b\n", reg_array[7]);
  `simulation_time;
 end
 always @ (posedge clk ) begin
   if(reg_write_en) begin
    reg_array[reg_write_dest] <= reg_write_data;
   end
 end
 

 assign reg_read_data_1 = reg_array[reg_read_addr_1];
 assign reg_read_data_2 = reg_array[reg_read_addr_2];


endmodule