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
import definitions::*;

module alu (input  [7:0]       rs_i ,	     // operand s
            input  [7:0]       rt_i	,	     // operand t
    		input              ov_i ,	     // shift-in 
    		input			   imm  ,		 // the immediate
    		input			   mem_w ,		 // memory write
            input  [5:0]       alu_op ,	 	 // instruction / opcode
            output logic [7:0] result_o,	 // rslt
			output logic       ov_o,
			output logic       mem_w,
			output logic 	   jump);

//This is what we have right now but we will definetely cut down on
//The number of instructions for lab 4.
always_comb								  	  // no registers, no clocks
  begin
    result_o   = 'b0;                     	  // default or NOP result
    ov_o       = 'b0;
    mem_w	   = 'b0;
    jump 	   = 'b0;
    case (alu_op)   						  // using the 
    	LSL: result_o = {rs_i[6:0], 1'b0};	  // pad a 0 to the empty space
    	LSR: result_o = {1'b0, rs_i[7:1]};	  // opposite of SLL
      	//HALT: // handled in top level / decode -- not needed in ALU
     	STR:  begin                           // store word 
    		   result_o = rs_i;				  // pass rs_i to output	(a+0)
    		   ov_o = ov_i;
    		  end
    	LDR:  begin
    		   result_o = rt_i;				  // load word 
    		   ov_o = ov_i;
    		  end
     	EMK: result_o = 8'b01111100 & rs_i;	  // exponent mask
      	ADD: {ov_o, result_o} = rs_i + rt_i + ov_i;
    	SUB: {ov_o, result_o} = rs_i - rt_i + !ov_i;
        AND: result_o = rs_i & rt_i;
        ANDI: result_o = rs_i & imm;
        ORR: result_o = rs_i | rt_i;
        ORRI: result_o = rs_i | imm;
        MOV: result_o = rs_i;
        MOVI: result_o = imm;
        BEQ: begin
        		assign val = rs_i - rt_i;
        		if (val == 0) begin
        			
        		end
        		jump = 'b1;
        	 end

    endcase
  end

endmodule 
