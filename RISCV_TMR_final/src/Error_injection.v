// Verilog code for randomised error injection block

module Error_injection (enc_data, inject_error, error_in_enc_data);
    input [31:0] enc_data;
    input inject_error;
    output reg [31:0] error_in_enc_data;
    reg [6:0] rnum;
    always @(posedge inject_error or enc_data) begin
        rnum=$random;
        rnum=(rnum>31)?31:rnum;
        error_in_enc_data = enc_data;
        if(inject_error)
            error_in_enc_data[rnum]=~error_in_enc_data[rnum];
    end
endmodule
