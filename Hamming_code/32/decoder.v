`timescale 1ns / 1ps
module decoder(input [37:0] received_data, output reg [31:0] msg_data);
integer i, j, pptr=0, mptr=0;
initial begin
	for(i=0; i<39; i=i+1) begin
		if(pptr<6 && i==(2**(pptr)-1)) begin
		   pptr=pptr+1;
		end
		else begin
			msg_data[mptr]=received_data[i];
			mptr=mptr+1;
		end
	end
end
endmodule
