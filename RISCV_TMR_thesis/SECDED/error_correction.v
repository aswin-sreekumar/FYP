// Error correction module using SECDED algorithm

module error_correction 
    (
        input [38:0] rcvd_error_data, 
        output reg [38:0] corrected_enc_data,
        output reg [6:0] synd
    );
    integer i, j, m, p;
    initial begin
        m=32;
        p=7;
    end
    always@(*) begin
        corrected_enc_data=rcvd_error_data;
        synd=7'd0;
        for(i=0; i<p-1; i=i+1) begin
            for(j=1; j<=m+p; j=j+1) begin
                if(j & 2**(i)) begin
                    synd[i]=synd[i]^rcvd_error_data[j-1];
                end
            end
        end
        synd[p-1]=^rcvd_error_data;
        corrected_enc_data=corrected_enc_data^(1<<(synd[5:0]-1)); //synd[p-2:0]
    end
endmodule