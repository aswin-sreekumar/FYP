// Verilog code for hamming error correction block

module error_correction (input [37:0] rcvd_error_data, output reg [37:0] corrected_enc_data);
    reg [5:0] synd;
    integer i, j;
    always@(*) begin
        corrected_enc_data=rcvd_error_data;
        synd=6'd0;
        for(i=0; i<6; i=i+1) begin
            for(j=1; j<=38; j=j+1) begin
                if(j & 2**(i)) begin
                    synd[i]=synd[i]^rcvd_error_data[j-1];
                end
            end
        end
        corrected_enc_data=corrected_enc_data^(1<<(synd-1));
    end
endmodule