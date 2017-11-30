/*********************************************
 *  Brianna Yamanaka                         *   
 *  Jeffrey Trang                            *   
 *  Goo Gu                                   *   
 *  Byunggwan Lim                            *   
 *                                           *   
 *  CSE141L Lab3                             *   
 *                                           *   
 *  Fetch unit comprises program counter     *   
 *  and instruction memory			         *
 *                                           *   
 *********************************************/
module fetch_unit(
	input clk,
	input init,
	input stop,
	input branch,
	input [2:0] PC_target_value,
	input[8:0] instruction
);

IF fetch(
	.clk(clk),
	.init(init),
	.stop(stop),
	.branch(branch)
);

InstRom rom(
	.target(PC_target_value),
	.inst(instruction)
);

endmodule
