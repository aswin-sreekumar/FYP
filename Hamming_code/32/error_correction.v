`timescale 1ns / 1ps
module error_correction(input [37:0] received_data, output reg [37:0] corrected_data);
reg [5:0] synd;
integer i, j;
initial begin
	corrected_data=received_data;
	synd=6'd0;
	for(i=0; i<6; i=i+1) begin
		for(j=1; j<=38; j=j+1) begin
			if(j & 2**(i)) begin
				synd[i]=synd[i]^received_data[j-1];
			end
		end
	end
	corrected_data=corrected_data^(1<<(synd-1));
end
endmodule
