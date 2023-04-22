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

    // initial begin
    //     mem[0] = 32'b00000000000000000000000000000010;
    //     mem[1] = 32'b00000000000000000000000000000100;
    //     mem[2] = 32'b00000000000000000000000000001000;
    // end

endmodule