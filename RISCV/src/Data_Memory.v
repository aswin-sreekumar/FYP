// 32 bit Data memory block

module Data_Memory(clk,rst,WE,WD,A,RD);

    input clk,rst,WE;
    input [31:0]A,WD;
    output [31:0]RD;

    reg [31:0] mem [31:0];

    always @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~rst) ? 32'd0 : mem[A];

    initial begin
        // mem[0] = 32'b10101010101010101010101010101010;
        // mem[1] = 32'b00000000000000000000000000000000;
        // mem[2] = 32'b00000000000000000000000000001000;
        $readmemh(`DATA_FILE,mem);
        // $monitor("\ntime = %d\n", $time, 
        // "\tMemory[0] = %h\n", mem[0],   
        // "\tMemory[2] = %h\n", mem[2],
        // "\tMemory[1] = %h\n", mem[1],
        // "\tMemory[3] = %h\n", mem[3],
        // "\tMemory[4] = %h\n", mem[4],
        // "\tMemory[5] = %h\n", mem[5],
        // "\tMemory[6] = %h\n", mem[6],
        // "\tMemory[7] = %h\n", mem[7],
        // "\tMemory[8] = %h\n", mem[8],
        // "\tMemory[9] = %h\n", mem[9]);
    end

endmodule