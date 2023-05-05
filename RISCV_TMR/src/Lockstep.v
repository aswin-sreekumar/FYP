// Recovery unit module

module Lockstep(
        Voter_state,
        core_hold,
        Recovery_mode
);
    input [2:0] Voter_state;
    input Recovery_mode;
    output core_hold;

    assign core_hold = Recovery_mode;
    
    
endmodule