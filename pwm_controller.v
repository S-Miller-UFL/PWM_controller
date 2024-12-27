//pwm_controller.v
//Author(s): Steven Miller
//Date created: December 23 2024
//purpose: pwm control for motors
/*
	log:
		$ December 23 2024, Steven: initial creation
*/


//8 bit counter

module pwm_controller
#(parameter n = 8)
(
	input[n-1:0] in_input,
	input in_nres,
	input in_clk,
	input in_latch,
	output out_output
);

//reg to hold current value of output reg
reg reg_output;

wire wire_done;
wire wire_sel;
wire wire_clk_buffer;

up_down_counter counter
(
	.in_input(in_input),
	.in_count_direction(0),
	.in_nres(in_nres),
	.in_clk(in_clk),
	.in_latch(in_latch),
	//.out_output(out_output),
	.out_done(wire_done)
);

//verilog will say theres an inferred latch here.
//there is, in fact, not.
twobyonemux output_mux
(
	.in_inputone(1),
	.in_inputtwo(0),
	.in_sel(reg_output),
	.out_output(out_output)
);

//possible timing mismatch with "posedge in_clk"
//to elaborate: 
/*
	all components run on the same exact clock. since the "done" signal rises
	with the pwm_controller clock, its possible that the controller may it.
	
	To prevent this: simply have the "done" signal rise slightly before the clock
	signal for the controller. This way, its ready and waiting at the "done" input" when 
	the clock rises.
	
*/
buf(wire_clk_buffer, in_clk);
always @ (posedge wire_clk_buffer or negedge in_nres)
begin

	//detect reset signal
	if(in_nres == 0)
	begin
		reg_output = 0;
	end
	else
	begin
	//detect done signal
		if(wire_done == 1)
		begin
			reg_output <= ~reg_output;
		end
		else
		begin
			reg_output <= reg_output;
		end
		
	end
end

endmodule