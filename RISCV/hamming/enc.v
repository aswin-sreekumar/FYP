// Verilog block for hamming encoder
// Asynchronous block

`timescale 1ns / 1ps
module encoder(input [31:0] msg_data, output reg [37:0] encoded_data);
integer pptr=0, mptr=0, i, j;
// for encoding
initial begin
	
	for(i=0; i<38; i=i+1) begin
		if(i==(2**(pptr)-1)  || i==0) begin 
			encoded_data[i] = 1'b0; // initially allocating 0 for parity
			pptr=pptr+1;
		end
		else begin
			encoded_data[i] = msg_data[mptr];
			mptr=mptr+1;
		end
	end
	for(i=0; i<6; i=i+1) begin
		for(j=1; j<=38; j=j+1) begin
			if(j & 2**(i)) begin
				encoded_data[2**(i)-1]=encoded_data[2**(i)-1]^encoded_data[j-1];
			end
		end
	end
end
endmodule
