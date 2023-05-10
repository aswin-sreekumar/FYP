// Reset controller

module Rst_Controller(
            main_rst,
            rst_in,
            core_hold
);
    input main_rst,core_hold;
    output rst_in;
    assign rst_in = main_rst & !core_hold;

endmodule