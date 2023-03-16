`timescale 1ns / 1ps

module blink(
	switch,	// clock signal
	ledpin	// LED pin
    );

	// inputs and outputs
	input switch;

	output ledpin;
	reg ledpin = 0;	

always @(*)
begin
	if(switch)
		ledpin <= 1'b1;
	else
		ledpin <= 1'b0;
end
endmodule