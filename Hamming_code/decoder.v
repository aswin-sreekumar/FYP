
module decoder (input [6:0] rcvd_data, output [3:0] dec_data);
    assign dec_data = {rcvd_data[6:4], rcvd_data[2]};
endmodule