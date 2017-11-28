// sample instruction ROM
// 10-bit microcode
// 8 elements
// resize as needed for your project
// this is about as simple as it gets
module instr_rom(
  input [2:0] PC,
  output[9:0] instr);

logic[9:0] core[2**3];

assign instr = core[PC];

endmodule