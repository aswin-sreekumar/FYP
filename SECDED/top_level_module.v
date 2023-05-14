`include "decoder.v"
`include "encoder.v"
`include "error_injection.v"
`include "error_correction.v"
module top_level_module(data, inject_1_error, inject_2_error, dec_data, synd);
    input [31:0] data;
    input inject_1_error;
    input inject_2_error;
    output [31:0] dec_data;
    output [6:0] synd;
    wire [38:0] og_enc_data;
    wire [38:0] error_in_enc_data;
    wire [38:0] corrected_enc_data;

    encoder encoder(
        .data(data), 
        .enc_data(og_enc_data)
    );

    error_injection error_injection(
        .enc_data(og_enc_data),
        .inject_1_error(inject_1_error),
        .inject_2_error(inject_2_error),
        .error_in_enc_data(error_in_enc_data)
    );

    error_correction error_correction(
        .rcvd_error_data(error_in_enc_data),
        .corrected_enc_data(corrected_enc_data),
        .synd(synd)
    );

    decoder decoder(
        .rcvd_data(corrected_enc_data), 
        .dec_data(dec_data)
    );
    

endmodule