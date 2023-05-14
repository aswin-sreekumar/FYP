module encoder_32 (
  input reg [31:0] data [0:31],
  output reg [37:0] enc_data [0:31]
);

  reg [5:0] parity;
  integer pptr, mptr, i, j, n;

  always @(*) begin
    for(n=0; n<32; n=n+1) begin
      mptr=0;
      pptr=0;
      for(i=0; i<38; i=i+1) begin
        if(i==(2**(pptr)-1)  || i==0) begin 
          enc_data[n][i] = 1'b0; // initially allocating 0 for parity
          pptr=pptr+1;
        end
        else begin
          enc_data[n][i] = data[n][mptr];
          mptr=mptr+1;
        end
      end
      for(i=0; i<6; i=i+1) begin
        for(j=1; j<=38; j=j+1) begin
          if(j & 2**(i)) begin
            enc_data[n][2**(i)-1]=enc_data[n][2**(i)-1]^enc_data[n][j-1];
          end
        end
      end
    end
  end

endmodule
