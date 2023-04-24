module error_injection (enc_data, inject_error, error_in_enc_data);
    input [6:0] enc_data;
    input inject_error;
    output reg [6:0] error_in_enc_data;
    integer error_pos = 5;
    // rnum=$random;
    always @(posedge inject_error or enc_data) begin
        error_in_enc_data = enc_data;
        error_in_enc_data[5] = ~error_in_enc_data[5];
    end
endmodule
