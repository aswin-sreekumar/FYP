// Recovery register

module Recovery_Register(clk,rst_in,WE,WD,A,RD);

    input clk,rst_in,WE;
    input [31:0]A,WD;
    output [31:0]RD;

    reg [31:0] Register [0:31];

    integer i;
    
    always @ (posedge clk)
    begin
        if(WE)
            Register[A] <= WD;
    end

    assign RD = (~rst_in) ? 32'd0 : Register[A];

    initial begin
        for(i=0;i<32;i++)
            Register[i] = {32{1'b0}};
        Register[1] = 1;
        Register[2] = 5;
        Register[3] = {32{1'b1}};
    end

endmodule