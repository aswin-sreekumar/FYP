// Testbench for ALU code
// Randomised testing and waveform generation

module ALU_tb();
    parameter finishtime = 20;
    reg [31:0] A,B;
    reg [2:0] ALUControl;
    wire OverFlow, Carry, Zero, Negative;
    wire [31:0] Result;

    integer i;

    ALU dut(
        .A (A),
        .B (B),
        .ALUControl (ALUControl),
        .Result (Result),
        .Carry (Carry),
        .OverFlow (OverFlow),
        .Zero (Zero),
        .Negative (Negative)
    );

    initial begin
        $dumpfile("dumpfile.vcd");
        $dumpvars(0, ALU_tb);
        $monitor("time=%3d, A=%3d, B=%3d, Result=%3d \n", $time, A, B, Result);

        
    end
    initial begin
        for (i=0;i<10;i=i+1)
            begin
                A = $random;
                B = $random;
                ALUControl = 3'b000;
                #20;
            end
        #finishtime $finish;     
    end

endmodule