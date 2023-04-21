// Testbench for RISC-V core top level

module Top_module_tb ();
    
    reg clk=1'b1,rst;

    Top_module Top_module(
                                .clk(clk),
                                .rst(rst)
    );

    initial begin
        $dumpfile("output/dumpfile.vcd");
        $dumpvars(0);
    end

    always 
    begin
        clk = ~ clk;
        #50;  
        
    end
    
    initial
    begin
        rst <= 1'b0;
        #150;

        rst <=1'b1;
        #450;
        $finish;
    end
endmodule