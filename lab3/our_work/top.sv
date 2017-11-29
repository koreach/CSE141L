/*********************************************
 *  Brianna Yamanaka                         *   
 *  Jeffrey Trang                            *   
 *  Goo Gu                                   *   
 *  Byung Lim                                *   
 *                                           *   
 *  CSE141L Lab3                             *   
 *                                           *   
 *  TOP module					             *   
 *                                           *   
 *********************************************/

//Refer to LECTURE 7
//STILL TODO 

module top(
	input reset,
	input clk,
	output done //done and halt are same
	);

	wire[8:0] instruction9bit; // wire for 9 bit code that corresponds to look up. this is initial starting point I think
	wire[7:0] result_output; //wire that holds the output of current value
	wire[7:0] decoder_output;
	wire[7:0] datamem_output;
	wire[7:0] alu_output;
	wire[7:0] lookup_val;
	wire[7:0] reg_output;

	wire ov_o;
 	wire alu_z_o;
  	logic wen_i;                      // reg file write enable
  	logic carry_en = 1'b1;
  	logic carry_clr;
  	assign carry_clr = reset;
  	logic ov_i;


	//logic[7:0] DataAddress; this was how it was done in starter code


	//these are our wires to connect to our modules as inputs and outputs
	wire WriteRegister;
	wire ReadRegister;

	ALU alu1(
		.opcode_instruction(instruction9bit[8:0]),
		.result_alu(result_output),
		.reg_input(lookup_val),  //does this work? TODO
		.out(alu_output)
	);

	lookup look(
  		.code(instruction9bit[8:0]), //or .code(alu_output)  
  		.out(lookup_val)
	);

	data_mem dm(
		.CLK(clk),
		.DataAddress(alu_output), //.DataAddress(DataAddress)
		.ReadMem(),
		.WriteMem(),
		.DataIn(result_output),
		.DataOut(datamem_output)
	);

	fetch_unit fetch1(
		.reset,
		.CLK(clk),
		.done
	);

	reg_file rf(
		.CLK(clk),
		.WriteRegister,
		.ReadRegister,
		.result_output,
		.reg_output
	);

	always_ff @(posedge clk)   // one-bit carry/shift
  		if(carry_clr==1'b1)
    		ov_i <= 1'b0;
  		else if(carry_en==1'b1)
    		ov_i <= ov_o;

//You need a program counter

//InstructionROM lookup and how wide is its output. So the lookup table.

//Register file

//ALU


endmodule
