// Verilog code for Hamming encoder block

module hamming_encoder (input [31:0] data , output reg [37:0] enc_data);
    wire [5:0] parity;
    integer pptr, mptr, i, j;
    // for encoding
    always@(*) begin
        mptr=0;
        pptr=0;
        for(i=0; i<38; i=i+1) begin
            if(i==(2**(pptr)-1)  || i==0) begin 
                enc_data[i] = 1'b0; // initially allocating 0 for parity
                pptr=pptr+1;
            end
            else begin
                enc_data[i] = data[mptr];
                mptr=mptr+1;
            end
        end
        for(i=0; i<6; i=i+1) begin
            for(j=1; j<=38; j=j+1) begin
                if(j & 2**(i)) begin
                    enc_data[2**(i)-1]=enc_data[2**(i)-1]^enc_data[j-1];
                end
            end
        end
    end
endmodule