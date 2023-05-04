// Reset controller

module Rst_Controller(
            main_rst,
            rst_in
);
    input main_rst;
    output rst_in;

    assign rst_in = main_rst;

endmodule