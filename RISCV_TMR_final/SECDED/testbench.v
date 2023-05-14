`include "top_level_module.v"

module testbench;
reg [31:0] data;
reg inject_1_error;
reg inject_2_error;

wire [31:0] dec_data;
wire [6:0] synd;

top_level_module UUT(
    .data(data),
    .inject_1_error(inject_1_error),
    .inject_2_error(inject_2_error),
    .dec_data(dec_data),
    .synd(synd)
);

initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, testbench);
end

initial begin
    data=32'd5;
    inject_1_error=0;
    inject_2_error=0; 
    #20;
    // inject_1_error=1; #20;
    // inject_1_error=0; #40;
    // inject_2_error=1;
     #40;

    if(synd[6]==0 & synd[0]==1) begin
        $display("Double Errors Detected");
    end
    $finish;
end
endmodule
