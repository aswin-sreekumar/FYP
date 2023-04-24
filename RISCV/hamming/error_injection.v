// Verilog block for randomised error injection into encoded data

`timescale 1ns / 1ps
module error_injection(inject_error, transmitting_data, error_injected_data);
input inject_error;
input [37:0] transmitting_data;
output reg [37:0] error_injected_data;
reg [6:0] rnum;
initial begin
	rnum=$random;
	rnum=(rnum>37)?37:rnum;
end
always@(inject_error) begin
	if(inject_error)
	error_injected_data[rnum]=~error_injected_data[rnum];
end
endmodule
