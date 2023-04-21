// Verilog code to create RAM block and load data from file

`timescale 1ns/1ps

module memory(clk, en, mem_addr, mem_read_data, mem_write_data, mem_write);

    parameter WIDTH = 8; // RAM word size
    parameter DEPTH = 16; // RAM locations

    input clk, en, mem_write;
    input [WIDTH-1:0] mem_write_data;
    input [DEPTH-1:0] mem_addr;
    output [WIDTH-1:0] mem_read_data;

    integer i;

    reg [WIDTH-1:0] ram_block [0:DEPTH-1];
    reg [7:0] mem_data;
    initial begin
        for(i=0;i<DEPTH;i=i+1) begin
            ram_block[i] = {WIDTH{1'b0}};
        end

        $display("Initialised memory block");

        $readmemb("ram_data.dat",ram_block);
        $display("Memory block loaded");

        for(i=0;i<DEPTH;i=i+1) begin
            $display("%d : %b",i,ram_block[i]); 
        end
    end

    always @(posedge clk) begin
        if(en) begin
            if(mem_write)
                ram_block[mem_addr] <= mem_write_data;
            else mem_data <= ram_block[mem_addr];
        end
    end
    assign mem_read_data = mem_data;

endmodule