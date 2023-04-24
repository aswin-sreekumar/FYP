module error_correction (input [6:0] error_in_enc_data, output [6:0] corrected_enc_data);
    wire [2:0] s;
    assign s[0] = error_in_enc_data[6]^error_in_enc_data[4]^error_in_enc_data[2]^error_in_enc_data[0];
    assign s[1] = error_in_enc_data[6]^error_in_enc_data[5]^error_in_enc_data[2]^error_in_enc_data[1];
    assign s[2] = error_in_enc_data[6]^error_in_enc_data[5]^error_in_enc_data[4]^error_in_enc_data[3];
    assign corrected_enc_data = error_in_enc_data;
    wire [2:0] crct;
    assign crct = s[2]&4 + s[1]&2 + s[0]&1;
    assign corrected_enc_data[5] = s ? ~corrected_enc_data[5]:corrected_enc_data[5];
endmodule