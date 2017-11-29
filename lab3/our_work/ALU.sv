/*********************************************
 *  Brianna Yamanaka                         *   
 *  Jeffrey Trang                            *   
 *  Goo Gu                                   *   
 *  Byung Lim                                *   
 *                                           *   
 *  CSE141L Lab3                             *   
 *                                           *   
 *  Arithmethic Logic Unit module of	     *
 *  the core.								 *
 *											 *
 *********************************************/


/* import definition */

module ALU(
	input [8:0] instruction9bit, //what part of the instruction/code is the code? 
	input [7:0] reg_input,

	output logic [7:0] alu_output,
	output logic overflow_o //what is this ? this was in starter code?
	);

always_comb
	begin
		alu_output = 'd0; // or alu_output = 8'b0000_0000 or alu_output = 0
		overflow_o = 'd0; // or alu_output = 8'b0000_0000 or alu_output = 0

		case(instruction9bit)
			'd0: alu_output = 0; //do something with look up table
			'd1: alu_output = 0; //do something with look up table
			'd2: alu_output = 0; //do something with look up table
			'd3: alu_output = 0; //do something with look up table
			//We need more case statements for every outcome

		endcase
	end

endmodule
