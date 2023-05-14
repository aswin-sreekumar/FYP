module decoder(input [38:0] rcvd_data, output reg [31:0] dec_data);
    integer i, pptr, mptr, m, p;
    initial begin
        m=32;
        p=7;
    end
    always@(*) begin
        mptr=0;
        pptr=0;
        for(i=0; i<m+p; i=i+1) begin
            if(i==(2**(pptr)-1) || i==m+p-1) begin
                pptr=pptr+1;
            end
            else begin
                dec_data[mptr]=rcvd_data[i];
                mptr=mptr+1;
            end
        end
    end
endmodule