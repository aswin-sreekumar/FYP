module error_injection (enc_data, inject_error, error_in_enc_data);
    input [37:0] enc_data;
    input inject_error;
    output reg [37:0] error_in_enc_data;
    reg [6:0] rnum;
    always @(posedge inject_error or enc_data) begin
        rnum=$random;
        rnum=(rnum>37)?37:rnum;
        error_in_enc_data = enc_data;
        if(inject_error)
            error_in_enc_data[rnum]=~error_in_enc_data[rnum];
    end
endmodule
