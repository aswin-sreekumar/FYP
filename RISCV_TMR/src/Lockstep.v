// Recovery unit module

module Lockstep(
        Voter_state,
        core_hold
);
    input [2:0] Voter_state;
    output core_hold;

    assign core_hold = Voter_state=={3'b000}?1'b1:1'b0;
    
    // Voter_state=={3'b000}?:;
    // assign core_hold = 1'b0;
endmodule