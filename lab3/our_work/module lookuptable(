//Refer to LECTURE 7
module lut(
	input	[8:0]	op_i, 		//The 9 bit instruction set
	output 	logic 	mem_w
				  	rf_w,
	output	logic[3:0] 	alu_op,	//If you wanted 32 bits, just increase this to 5 bits and imm to 32
					   	rs_addr,
					   	rt_addr,
					   	rd_addr,
	output 	logic[15:0] imm_pc,
	output	logic[ 7:0]	alu_in,
	output	logic		alu_sell
	);

always_comb case(op_i)
	//Have this for each of the combinations of the lookup table
	//No limit to how big you make this thing
	9'h0:	begin
				mem_w 	= 1'b0;		//mem write (not writing to memory)
				rf_w	= 1'b1;		//
				alu_op	= 4'h1;		//telling the alu what to do. You tell ALU to do op 1 here
			 	rs_addr	= 4'h0;		//point to the two operands into the ALU (both pointers)
			    rt_addr = 4'h1;		//comment above applies
			    rd_addr	= 4'h2;		//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
				imm_pc	= 16'h000f;	//If you need an immediate, if you are doing conditional branch or jump, move by f units
				alu_in	= 8'd29;	//The ALU constant
				alu_sell= 1'b0;		//Whether I am selecting the ALU constant
			end
	default:
endcase

endmodule