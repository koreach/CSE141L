// simple sample instruction counter
module instr_ctr(
  input             clk,
                    init,
                    br4,		   // relative jump forward by 4
                    jp0,		   // absolute jump to 0
  output logic[2:0] PC);		   // goes to instruction_ROM

always_ff @(posedge clk)
  if(init)						   // don't forget this one!
    PC <= 0;
  else if(br4)	                   // relative branch
    PC <= PC + 4;
  else if(jp0)					   // absolute jump
    PC <= 0;
  else 
    PC <= PC + 1;                  // why not PC++ ???

endmodule