// Program counter block

module PC_Module(clk,rst_in,PC,PC_Next);
    input clk,rst_in;
    input [31:0]PC_Next;
    output [31:0]PC;
    reg [31:0]PC;

    always @(posedge clk)
    begin
        if(~rst_in)
            PC <= {32{1'b0}};
        else
            PC <= PC_Next;
    end
endmodule