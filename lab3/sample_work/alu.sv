// Create Date:     2017.05.05
// Latest rev date: 2017.10.26
// Created by:      J Eldon
// Design Name:     CSE141L
// Module Name:     ALU (Arithmetic Logical Unit)


//This is the ALU module of the core, op_code_e is defined in definitions.v file
// Includes new enum op_mnemonic to make instructions appear literally on waveform.
import definitions::*;

module alu (input  [7:0]       rs_i ,	     // operand s
            input  [7:0]       rt_i	,	     // operand t
    		    input              ov_i ,	     // shift-in
            input  [8:0]       op_i	,	     // instruction / opcode
            output logic [7:0] result_o,	 // rslt
		    	  output logic       ov_o);

always_comb								  // no registers, no clocks
  begin
    result_o   = 'd0;                     // default or NOP result
    ov_o       = 'd0;
    case (op3)   						                  
    	LSL:  begin							                // logical shift left
    	        ov_o     = rs_i[7];			        // generate shift-out bit to left
    	        result_o = {rs_i[6:0],ov_i};	  // accept previous shift-out from right
    	 	    end
    	LSR:  begin							                // logical right shift
    		      ov_o     = rs_i[0];
    		      result_o = {ov_i,rs_i[7:1]};	  // opposite of SLL
    		    end
      //HALT: // handled in top level / decode -- not needed in ALU
      LDR:  begin                            // store word or load word
      		    result_o = rs_i;				  // pass rs_i to output	(a+0)
      		    ov_o = ov_i;
    		    end
      STR:  begin
              result_o = rs_i;
              ov_o = ov_i;
            end
      CLR: result_o = 8'h00;				  // clear (output = 0)
     	EMK: result_o = 8'b01111100 & rs_i;	  // exponent mask
      ADD: {ov_o, result_o} = rs_i + rt_i + ov_i;
    	SUB: {ov_o, result_o} = rs_i - rt_i + !ov_i;
      AND: result_o = rs_i & rt_i;
    endcase
  end

endmodule 
