//twobyonemux.v
//Author(s): Steven Miller
//Date created: December 23 2024
//purpose: 2 input 1 output mux (2 by 1)
/*
	log:
		$ December 23 2024, Steven: initial creation
*/

module twobyonemux
#(parameter n = 8)
(
	input [n-1:0] in_inputone,
	input [n-1:0] in_inputtwo,
	input in_sel,
	output reg [n-1:0] out_output
);

always @ (*)
begin
	if(in_sel == 0)
	begin
		out_output = in_inputone;
	end
	else if(in_sel == 1)
	begin
		out_output = in_inputtwo;
	end
end

endmodule