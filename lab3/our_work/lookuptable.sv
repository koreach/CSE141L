//Refer to LECTURE 7
module lut(
	input	[8:0]	op_i, 			//The 9 bit instruction set
	output 	logic 	mem_w
				  	rf_w,
	output	logic[4:0] 	alu_op,		//5 bit wide for the alu instructions
	output	logic[3:0]  rs_addr,	//Pointers to reg file. 16 bit register with 4 bit wide
					   	rt_addr,	
					   	rd_addr,
	output 	logic[15:0] imm_pc,		//16 bit immediate for branches/jumps
	output	logic[ 7:0]	alu_in,		//8 bit immediate for regular ALU
	output	logic		alu_sell	//Lets me choose what values goes into ALU from where
	);

always_comb 
	case(op_i)
	//Have this for each of the combinations of the lookup table
	//No limit to how big you make this thing
	//PART 1: Int to float
		//Code: mov r0, #0x06
		9'h0:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01100;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h0;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h0;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h06;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
		//Code: mov r1, #0x80
		9'h1:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01100;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h0;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h1;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h80;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
		//Code: and r2, r1, #0x80
		9'h2:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01000;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h1;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h2;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h80;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
		//Code: mov r3, #0xFF
		9'h3:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01100;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h0;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h3;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'hFF;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
		//Code: mov r4, r0
		9'h4:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01100;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h0;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h4;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h0;		//The ALU constant
					alu_sell= 1'b0;			//Whether I am selecting the ALU constant
				end
		//Code: and r2, r1, #0x80
		9'h5:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01000;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h1;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h2;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h80;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
		//Code: forloop 		this is the jump back address but I do not know how will we do this yet... with branching
		9'h6:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01000;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h1;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h2;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h80;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
		//Code: forloop 		this is the jump back address but I do not know how will we do this yet... with branching
		9'h7:	begin
					mem_w 	= 0'b0;			//mem write (for store)
					rf_w	= 0'b0;			//register file write (for load)
					alu_op	= 5'b01000;		//telling the alu what to do. You tell ALU to do op 1 here
				 	rs_addr	= 4'h1;			//point to the two operands into the ALU (both pointers)
				    rt_addr = 4'h0;			//and the content of the two addresses will go into ALU
				    rd_addr	= 4'h2;			//Point to where I'd like my ALU to be writing back to. This is written on the next pos edge clock
					imm_pc	= 16'b0;		//If you need an immediate, if you are doing conditional branch or jump, move by f units
					alu_in	= 8'h80;		//The ALU constant
					alu_sell= 1'b1;			//Whether I am selecting the ALU constant
				end
	endcase
endmodule