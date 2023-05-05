// Recovery register

module Recovery_Register(clk,rst_in,WE,WD,A,RD);

    input clk,rst_in,WE;
    input [31:0]A,WD;
    output [31:0]RD;

    reg [31:0] mem [0:31];

    integer i;

    always @ (posedge clk)
    begin
        if(WE)
            mem[A] <= WD;
    end

    assign RD = (~rst_in) ? 32'd0 : mem[A];

    initial begin
        for(i=0;i<32;i=i+1)
            mem[i] = 32'b0;
    end

endmodule