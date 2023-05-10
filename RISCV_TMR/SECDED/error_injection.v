module error_injection (enc_data, inject_1_error, inject_2_error, error_in_enc_data);
    input [38:0] enc_data;
    input inject_1_error;
    input inject_2_error;
    output reg [38:0] error_in_enc_data;
    reg [6:0] rnum1, rnum2;
    integer m,p;
    initial begin
        m=32;
        p=7;
    end
    always @(posedge inject_1_error or inject_2_error or enc_data) begin
        rnum1=$random;
        rnum2=$random;
        rnum1=(rnum1>m+p-1)?m+p-1:rnum1;
        rnum2=(rnum2>m+p-1)?m+p-1:rnum2;
        error_in_enc_data = enc_data;
        if(inject_1_error && ~(inject_2_error)) begin
            error_in_enc_data[rnum1]=~error_in_enc_data[rnum1];
        end
        else if(inject_2_error) begin
            error_in_enc_data[rnum1]=~error_in_enc_data[rnum1];
            error_in_enc_data[rnum2]=~error_in_enc_data[rnum2];
        end
    end
endmodule
