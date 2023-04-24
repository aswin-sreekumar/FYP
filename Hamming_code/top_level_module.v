`include "decoder.v"
`include "encoder.v"
`include "error_injection.v"
`include "error_correction.v"
module top_level_module(data, inject_error, enc_data, error_in_enc_data, dec_data);
    input [3:0] data;
    input inject_error;
    output [6:0] enc_data;
    output [6:0] error_in_enc_data;
    output [3:0] dec_data;

    encoder encoder(
        .data(data), 
        .enc_data(enc_data)
    );

    error_injection error_injection(
        .enc_data(enc_data),
        .inject_error(inject_error), 
        .error_in_enc_data(error_in_enc_data)
    );

    decoder decoder2(
        .rcvd_data(error_in_enc_data), 
        .dec_data(dec_data)
    );
    // error_correction error_correction(
    //     .error_in_enc_data(error_in_enc_data),
    //     .corrected_enc_data(enc_data)
    // );
    

endmodule