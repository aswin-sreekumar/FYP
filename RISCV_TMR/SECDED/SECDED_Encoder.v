module SECDED_Encoder (input [31:0] data, output reg [38:0] enc_data);
    integer pptr, mptr, i, j, m, p;
    initial begin
        m=32;
        p=7;
    end
    // for encoding
    always@(*) begin
        mptr=0;
        pptr=0;
        for(i=0; i<m+p; i=i+1) begin
            if(i==(2**(pptr)-1)  || i==0 || i==m+p-1) begin 
                enc_data[i] = 1'b0; // initially allocating 0 for parity
                pptr=pptr+1;
            end
            else begin
                enc_data[i] = data[mptr];
                mptr=mptr+1;
            end
        end
        for(i=0; i<p; i=i+1) begin
            for(j=1; j<=m+p; j=j+1) begin
                if(j & 2**(i)) begin
                    enc_data[2**(i)-1]=enc_data[2**(i)-1]^enc_data[j-1];
                end
            end
        end
        enc_data[m+p-1]=^enc_data;
    end
endmodule