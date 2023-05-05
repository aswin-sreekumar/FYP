// Top level module for hamming code block
// Four sub-blocks - Encoder, error injector, corrector, decoder

`include "hamming/hamming_decoder.v"
`include "hamming/hamming_encoder.v"
`include "hamming/error_injection.v"
`include "hamming/error_correction.v"

module Hamming_module(data, inject_error, dec_data);
    input [31:0] data;
    input inject_error;
    output [31:0] dec_data;
    wire [37:0] og_enc_data;
    wire [37:0] error_in_enc_data;
    wire [37:0] corrected_enc_data;

    hamming_encoder hamming_encoder(
        .data(data), 
        .enc_data(og_enc_data)
    );

    error_injection error_injection(
        .enc_data(og_enc_data),
        .inject_error(inject_error), 
        .error_in_enc_data(error_in_enc_data)
    );

    error_correction error_correction(
        .rcvd_error_data(error_in_enc_data),
        .corrected_enc_data(corrected_enc_data)
    );

    hamming_decoder hamming_decoder(
        .rcvd_data(corrected_enc_data), 
        .dec_data(dec_data)
    );
    

endmodule