// PC_Top buffer for instruction rollback

module PC_buffer(
    clk,
    PC_Top,
    PC_Top_rollback
);

    input clk;
    input [31:0] PC_Top;
    output [31:0] PC_Top_rollback;

    reg [31:0] PC_Top_buffer [0:2];

    initial begin
        PC_Top_buffer[0] = 32'd0;
        PC_Top_buffer[1] = 32'd0;
        PC_Top_buffer[2] = 32'd0;
    end

    always @(posedge clk) begin
        PC_Top_buffer[2] <= PC_Top_buffer[1];
        PC_Top_buffer[1] <= PC_Top_buffer[0];
        PC_Top_buffer[0] <= PC_Top;    
    end

    assign PC_Top_rollback = PC_Top_buffer[2];

endmodule