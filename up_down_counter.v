//up_down_counter.v
//Author(s): Steven Miller
//Date created: December 23 2024
//purpose: n bit up or down counter
/*
	log:
		$ December 23 2024, Steven: initial creation
*/

module up_down_counter
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

reg [n-1:0] reg_count_value;

reg [n-1:0] reg_reference_value;

always @ (posedge in_clk or negedge in_nres)
begin
	//if resetting counter
	if(in_nres == 0)
	begin
		//if up counting selected
		if(in_count_direction == 1)
		begin
			reg_count_value = 0;
		end
		//if down counting selected
		else if (in_count_direction == 0)
		begin
			reg_count_value = reg_reference_value;
		end
	end
	//if positive edge of clock
	else if (in_clk == 1)
	begin
		//if latching value
		if(in_latch == 1)
		begin
			reg_reference_value = in_input;
		end
		//if counting
		else if(in_latch ==0)
		begin
			//if counting up
			if(in_count_direction == 1)
			begin
				//check if already hit value at previous clock cycle
				if(reg_count_value == reg_reference_value)
				begin
					out_done = 0;
					reg_count_value = 0;
				end
				//if were not at it or if we just hit it this cycle
				else
				begin
					reg_count_value = reg_count_value + 1;
					//if we hit it this cycle
					if(reg_count_value == reg_reference_value)
					begin
						out_done = 1;
					end
				end
				
			end
			//if counting down
			else if(in_count_direction == 0)
			begin
				//check if already hit value at previous clock cycle
				if(reg_count_value == 0)
				begin
					out_done = 0;
					reg_count_value = reg_reference_value;
				end
				//if were not at it or if we just hit it this cycle
				else
				begin
					reg_count_value = reg_count_value - 1;
					//if we hit it this cycle
					if(reg_count_value == 0)
					begin
						out_done = 1;
					end
				end
		end
	end
 end
 out_output = reg_count_value;
end

endmodule