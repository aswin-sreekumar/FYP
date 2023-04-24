module encoder (input [3:0] data, output [6:0] enc_data);
    wire [2:0] parity;
    assign parity[0] = data[3]^data[1]^data[0];
    assign parity[1] = data[3]^data[2]^data[0];
    assign parity[2] = data[3]^data[2]^data[1];
    assign enc_data = {data[3:1], parity[2], data[0], parity[1:0]};
endmodule