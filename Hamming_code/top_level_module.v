`include "decoder.v"
`include "encoder.v"
`include "error_injection.v"
`include "error_correction.v"
module top_level_module(data, inject_error, dec_data);
    input [31:0] data;
    input inject_error;
    output [31:0] dec_data;
    wire [37:0] og_enc_data;
    wire [37:0] error_in_enc_data;
    wire [37:0] corrected_enc_data;

    encoder encoder(
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

    decoder decoder(
        .rcvd_data(corrected_enc_data), 
        .dec_data(dec_data)
    );
    

endmodule