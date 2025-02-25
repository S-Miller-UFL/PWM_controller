//n_bit_counter.v
//Author(s): Steven Miller
//Date created: December 23 2024
//purpose: n bit counter
/*
	log:
		$ December 23 2024, Steven: initial creation
*/

module n_bit_counter
#(parameter n = 8)
(
	input[n-1:0] in_input,
	input in_count_direction,
	input in_nres,
	input in_clk,
	input in_latch,
	output reg[n-1:0] out_output,
	output reg out_done
);



twobyonemux counter_mux
(
	
	.in_inputone(),
	.in_inputtwo(),
	.in_sel(in_count_direction),
	.out_output(out_output)
);


endmodule