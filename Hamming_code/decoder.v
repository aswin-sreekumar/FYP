module decoder(input [37:0] rcvd_data, output reg [31:0] dec_data);
    integer i, pptr, mptr;
    always@(*) begin
        mptr=0;
        pptr=0;
        for(i=0; i<38; i=i+1) begin
            if(i==(2**(pptr)-1)) begin
                pptr=pptr+1;
            end
            else begin
                dec_data[mptr]=rcvd_data[i];
                mptr=mptr+1;
            end
        end
    end
endmodule