//n_bit_register.v
//Author(s): Steven Miller
//Date created: December 23 2024
//purpose: n bit register
/*
	log:
		$ December 23 2024, Steven: initial creation
*/

module n_bit_register
#(parameter n = 8)
(
	input[n-1:0] in_input,
	input in_enable,
	input in_clk,
	input in_nres,
	output reg[n-1:0] out_output
);

//reg[n-1:0] reg_dreg;

always @ (posedge in_clk or negedge in_nres)
begin
	//check if reset is true
	if(in_nres == 0)
	begin
		out_output = 0;
	end
	else if(in_clk == 1)
	begin
		if(in_enable == 1)
		begin
			out_output = in_input;
		end
		else
		begin
			out_output = out_output;
		end
	end
	else
	begin
		out_output = out_output;
	end

end



endmodule