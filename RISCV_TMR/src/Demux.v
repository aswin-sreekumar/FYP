// Demux module

module Demux (a,b,s,c);

    input s;
    input [31:0]c;
    output [31:0]a,b;

    assign a = (sel == 1'b0) ? c : 1'b0;
    assign b = (sel == 1'b1) ? c : 1'b0;
    
endmodule