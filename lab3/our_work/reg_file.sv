/*********************************************
 *  Brianna Yamanaka                         *
 *  Jeffrey Trang                            *
 *  Goo Gu                                   *
 *  Byunggwan Lim                            *   
 *                                           *
 *  CSE141L Lab3                             *
 *                                           *
 *  A register file with asynchronus read    *
 *  and synchronous write                    *   
 *                                           *
 *********************************************/

//raw is RF address width and will give us more registers

module reg_file #(parameter raw = 4/* TODO */)
          ( input clk,                           //clock for writes only
            input [raw-1:0] /*TODO*/ rs_in,                //read pointer rs
            input          rt_in,                //read pointer rt
            input          rd_in,                //write pointer rd
            input          wen_in,               //write enable
            input [7:0] /*TODO*/ wrdata_in,            //data to be written/loaded
            output logic [7:0] /*TODO*/ rs_out,        //data read out of reg file
            output logic [7:0] /*TODO*/ rt_out
          );

          /*core*/
          logic [7:0] RF [2**raw]; /* TODO, what are these values and do they work with our implementation */
          
          /*two simultaneous, continuous, combinational reads supported*/
          assign rt_out = RF[rt_in];
          assign rs_out = RF[rs_in];

          /*synchronous (clocked) write to selected RF content 'bin' */
          always_ff @ (posedge clk)
            if (wen_in)
              RF[rd_in] <= wrdata_in;

endmodule
