/*********************************************
 *  Brianna Yamanaka                         *   
 *  Jeffrey Trang                            *   
 *  Goo Gu                                   *   
 *  Byunggwan Lim                            *   
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
            input  [7:0]       alu_in,       // 8 bit immediate for ALU
    		input              ov_i ,	     // shift-in 
            input  [4:0]       alu_op ,	 	 // instruction / opcode
            output logic [7:0] result_o,	 // rslt
			output logic       ov_o,
			output logic 	   jump);

//This is what we have right now but we will definetely cut down on
//The number of instructions for lab 4.
always_comb								  	  // no registers, no clocks
    begin
        result_o   = 'b0;                     	  // default or NOP result
        ov_o       = 'b0;
        jump 	   = 'b0;
        case (alu_op)   						   
        	//00000 - LSL
            5'b00000: result_o = rs_i<<rt_i;	  
        	//00001 - LSR
            5'b00001: result_o = rs_i>>(8-rt_i);	  // opposite of SLL
          	//HALT: // handled in top level / decode -- not needed in ALU
            //00010 - STR
            5'b00010:  begin                           // store word 
                		   result_o = rs_i;				  // pass rs_i to output	(a+0)
                		   ov_o = ov_i;
        		        end
        	//00011 - LDR
            5'b00011:  begin
                		   result_o = rt_i;				  // load word 
                		   ov_o = ov_i;
        		       end
            //00100 - EMK - Exponent mask
         	5'b00100: result_o = 8'b01111100 & rs_i;	  // exponent mask
            //00101 - ADD
            5'b00101: {ov_o, result_o} = rs_i + rt_i + ov_i;
            //00110 - SUB
        	5'b00110: {ov_o, result_o} = rs_i - rt_i + !ov_i;
            //00111 - AND
            5'b00111: result_o = rs_i & rt_i;
            //01000 - ANDI
            5'b01000: result_o = rs_i & alu_in;
            //01001 - ORR
            5'b01001: result_o = rs_i | rt_i;
            //01010 - ORRI
            5'b01010: result_o = rs_i | alu_in;
            //01011 - MOV
            5'b01011: result_o = rs_i;
            //01100 - MOVI
            5'b01100: result_o = alu_in;
            //01101 - BEQ
            5'b01101: begin
                		assign val = rs_i - rt_i;
                		if (val == 0) begin
                            jump = 'b1;
                		end
            	    end
            //01101 - BGE
            5'b01110: begin
                        assign val = rs_i - rt_i;
                        if (val >= 0) begin
                            jump = 'b1;
                        end
                    end
            //01101 - BGT
            5'b01111: begin
                        assign val = rs_i - rt_i;
                        if (val > 0) begin
                            jump = 'b1;
                        end
                    end
            //01101 - BLE
            5'b10000: begin
                        assign val = rs_i - rt_i;
                        if (val <= 0) begin
                            jump = 'b1;
                        end
                    end
            //01101 - BLT
            5'b10001: begin
                        assign val = rs_i - rt_i;
                        if (val <= 0) begin
                            jump = 'b1;
                        end
                    end
        endcase
    end
endmodule 
