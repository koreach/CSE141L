/*********************************************
 *  Brianna Yamanaka                         *
 *  Jeffrey Trang                            *
 *  Goo Gu                                   *
 *  Byung Lim                                *
 *                                           *
 *  CSE141L Lab3                             *
 *                                           *
 *  A register file with asynchronus read    *
 *  and synchronous write                    *   
 *                                           *
 *********************************************/

module reg_file #(parameter raw = /* TODO */)
          ( input clk,                           //clock for writes only
            input /*TODO*/ rs_in,                //read pointer rs
            input          rt_in,                //read pointer rt
            input          rd_in,                //write pointer rd
            input          wen_in,               //write enable
            input /*TODO*/ wrdata_in,            //data to be written/loaded
            output logic /*TODO*/ rs_out,        //data read out of reg file
            output logic /*TODO*/ rt_out
          );

          /*core*/
          logic /*TODO*/ RF /*TODO*/;
          
          /*two simultaneous, continuous, combinational reads supported*/
          assign rt_out = RF[rt_in];
          assign rs_out = RF[rs_in];

          /*synchronous (clocked) write to selected RF content 'bin' */
          always_ff @ (posedge clk)
            if (wen_in)
              RF[rd_in] <= wrdata_in;

endmodule
