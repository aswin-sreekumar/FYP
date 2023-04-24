`include "top_level_module.v"

module testbench;
reg [3:0] data;
reg inject_error;

wire [6:0] enc_data, error_in_enc_data;
wire [3:0] dec_data;

top_level_module UUT(
    .data(data),
    .inject_error(inject_error),
    .enc_data(enc_data),
    .error_in_enc_data(error_in_enc_data),
    .dec_data(dec_data)
);

initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, testbench);
end

initial begin
    data=4'b1011;
    inject_error=0; #20;
    inject_error=1; #20;
    data=4'b1111;
    inject_error=0; #20;
    inject_error=1; #20;
    $finish;
end

endmodule
