/*********************************************
 *  Brianna Yamanaka                         *   
 *  Jeffrey Trang                            *   
 *  Goo Gu                                   *   
 *  Byung Lim                                *   
 *                                           *   
 *  CSE141L Lab3                             *   
 *                                           *   
 *  Data memory module                       *   
 *                                           *   
 *********************************************/

// holds data to be processed or stored into computer storage
// this is exactly like starter code

module data_mem(
	input CLK,
	input [7:0] DataAddress,
	input ReadMem,
	input WriteMem,
	input [7:0] DataIn,
	output logic [7:0] DataOut
	);

	logic[7:0] mymemory[2**AW]; //idk what mymemory is yet, TODO

	always_comb
		if(ReadMem)begin
			DataOut = mymemory[DataAddress]
		end
		else
			DataOut = 16'bZ;
			
	always_ff @ (posedge CLK)	             // writes are clocked / sequential
    if(WriteMem) begin
      my_memory[DataAddress] = DataIn;
	  $display("Memory write M[%d] = %d",DataAddress,DataIn);
    end
endmodule