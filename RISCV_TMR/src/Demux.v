// Demux module

module Demux (a,b,s,c);

    input s;
    input c;
    output a,b;

    assign a = (s == 1'b0) ? c : 1'b0;
    assign b = (s == 1'b1) ? c : 1'b0;
    
endmodule