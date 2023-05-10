// Program counter block

module PC_Module(clk,rst_in,PC,PC_Next,PC_changed);
    input clk,rst_in;
    input [31:0]PC_Next;
    input [31:0] PC_changed;
    output [31:0]PC;
    reg [31:0]PC;

    always @(posedge clk)
    begin
        if(~rst_in)
            PC <= {32{1'b0}};
        // else if(PC_changed)
        //     PC <= PC_changed;
        else
            PC <= PC_Next;
    end
endmodule