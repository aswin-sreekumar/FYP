// Recovery register in case of total collapse

module Recovery_Register(clk,rst_in,WE3,WD3,A1,A3,RD1);

    input clk,rst_in,WE3;
    input [4:0]A1,A3;
    input [31:0]WD3;
    output [31:0]RD1;

    reg [31:0] Register [31:0];
    integer  i;

    always @ (posedge clk)
    begin
        if(WE3)
            Register[A3] <= WD3;
    end

    assign RD1 = (~rst_in) ? 32'd0 : Register[A1];
    assign RD2 = (~rst_in) ? 32'd0 : Register[A2];

    initial begin
        for(i=0;i<32;i++)
            Register[i] <= {32{1'b0}};
    end

endmodule