// Testbench for instantiating RAM block

`timescale 1ns/1ps

module memory_tb();
    parameter finishtime = 500;
    parameter WIDTH = 8;
    parameter DEPTH = 4;

    reg clk, en, mem_write;
    reg [DEPTH-1:0] mem_addr;
    wire [WIDTH-1:0] mem_read_data;
    reg [WIDTH-1:0] mem_write_data;

    integer i;
    memory dut(
        .clk (clk),
        .en (en),
        .mem_write(mem_write),
        .mem_read_data (mem_read_data),
        .mem_addr (mem_addr),
        .mem_write_data (mem_write_data)
    );

    initial begin
        $dumpfile("dumpfile.vcd");
        $dumpvars(0, memory_tb);
        $monitor("WRITE %b : %b",mem_addr,mem_write_data);
        // $monitor("READ %b : %b",mem_addr,mem_read_data);
        #finishtime $finish;
    end

    initial begin
        en = 1'b0;
        mem_write = 1'b0;
        clk = 1'b0;
        mem_addr = {WIDTH{1'b0}};
        mem_write_data = {WIDTH{1'b0}};
        forever #10 clk = ~clk;
    end

    initial begin
        en = 1'b1;
        mem_write = 1'b1;
        for(i=0;i<10;i=i+1) begin
            mem_addr <= $random;
            mem_write_data <= $random;
            #20;
        end
        mem_write = 1'b0;
        for(i=0;i<10;i=i+1) begin
            mem_addr <= $random;
            #20;
        end
    end
endmodule