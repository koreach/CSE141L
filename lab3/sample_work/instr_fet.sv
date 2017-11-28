// fetch encapsulates program counter and instruction ROM
module instr_fet(
  input       clk,
              init,
	     	  br4,
		      jp0,
  output[2:0] PC,		 	   // in case we need this elsewhere
  output[9:0] instr);		   // microcode from instruction ROM

instr_ctr ic1(.*);
instr_rom ir1(.*);

endmodule