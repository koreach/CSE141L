/*********************************************
 *  Brianna Yamanaka                         *   
 *  Jeffrey Trang                            *   
 *  Goo Gu                                   *   
 *  Byunggwan Lim                            *   
 *                                           *   
 *  CSE141L Lab3                             *   
 *                                           *   
 *  Data memory module                       *   
 *                                           *   
 *********************************************/

// holds data to be processed or stored into computer storage
// this is exactly like starter code

/*
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
    	end
endmodule
*/


// Create Date:    2017.05.05
// Latest rev:     2017.10.26
// Created by:     J Eldon
// Design Name:    CSE141L
// Module Name:    Data Mem

// Generic data memory design for CSE141L projects
// width = 8 bits (per assignment spec.)
// depth = 2**W (default value of W = 8, may be changed)
module data_mem #(parameter AW=8)(
  input              CLK,                // clock
  input    [AW-1:0]  DataAddress,		 // pointer
  input              ReadMem,			 // read enable	(may be tied high)
  input              WriteMem,			 // write enable
  input       [7:0]  DataIn,			 // data to store (write into memory)
  output logic[7:0] DataOut);			 //	data to load (read from memory)

  logic [7:0] my_memory [2**AW]; 		 // create array of 2**AW elements (default = 256)

// optional initialization of memory, e.g. seeding with constants
//  initial 
//    $readmemh("dataram_init.list", my_memory);

// read from memory, e.g. on load instruction
  always_comb							 // reads are immediate/combinational
    if(ReadMem) begin
      DataOut = my_memory[DataAddress];
// optional diagnostic print statement:
//	  $display("Memory read M[%d] = %d",DataAddress,DataOut);
    end else 
      DataOut = 16'bZ;			         // z denotes high-impedance/undriven

// write to memory, e.g. on store instruction
  always_ff @ (posedge CLK)	             // writes are clocked / sequential
    if(WriteMem) begin
      my_memory[DataAddress] = DataIn;
	  $display("Memory write M[%d] = %d",DataAddress,DataIn);
    end

endmodule
