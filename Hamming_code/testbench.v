`include "top_level_module.v"

module testbench;
reg [31:0] data;
reg inject_error;

wire [31:0] dec_data;

top_level_module UUT(
    .data(data),
    .inject_error(inject_error),
    .dec_data(dec_data)
);

initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, testbench);
end

initial begin
    // data=32'd8456;
    // inject_error=0; #20;
    // inject_error=1; #20;
    data=32'd12; #20;
    // inject_error=0; #20;
    // inject_error=1; #20;
    // inject_error=0; #20;
    // inject_error=1; #20;
    // inject_error=0; #20;
    // inject_error=1; #20;
    $finish;
end

endmodule
