import java.io.File;
import java.io.*;


public class Assembler{

  public static void main(String[] args) {
    //if no input file, then give error and exit
    if(args.length==0){
      System.out.println("Specify an assembly file that you want to assemble into machine code!");
      System.exit(0);
    }
    //grab input file and print out its name
    File input = new File(args[0]);
    System.out.println();
    Assembler.separator();
    System.out.println("Input File: " + input);
    Assembler.separator();
    System.out.println();

    //print out machine code
    System.out.println();
    Assembler.separator();
    System.out.println("Machine Code: \n");
    Assembler.assemble(input);
    Assembler.separator();
  }
  public static void assemble(File inputfile){
    try{
      //FileInputStream fileinputstream = new FileInputStream(inputfile);
      //InputStreamReader inputstreamreader = new InputStreamReader(fileinputstream);
      FileReader fr = new FileReader(inputfile);
      BufferedReader br = new BufferedReader(fr);
      String line = br.readLine();
      int count = 1;
      while (line != null){
          //System.out.println(line); 
          //System.out.print("line number: " + count);
          if(line.equals("mov r0, #0x06")){
            System.out.print("000000000");
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("mov r1, #0x80")){
            System.out.print("000000001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r2, r1, #0x80")){
            System.out.print("000000010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("mov r3, #29")){
            System.out.print("000000011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("mov r4, r0")){
            System.out.print("000000100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r5, r1, #0xFF")){
            System.out.print("000000101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("forloop:")){
            System.out.print("000000110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r5, #0x40")){
            System.out.print("000000111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r6, #0x40")){
            System.out.print("000001000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("beq out")){
            System.out.print("000001001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("lsl r5, r5, #1")){
            System.out.print("000001010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r4, #0x80")){
            System.out.print("000001011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("lsr r6, r6, #7")){
            System.out.print("000001100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("orr r5, r5, r6")){
            System.out.print("000001101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("lsl r4, r4, #1")){
            System.out.print("000001110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r4, r4, #0xFF")){
            System.out.print("000001111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("sub r3, r3, #1")){
            System.out.print("000010000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b forloop")){
            System.out.print("000010001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("out:")){
            System.out.print("000010010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r4, #0x10")){
            System.out.print("000010011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r6, #0x10")){
            System.out.print("000010100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("beq rounding_1")){
            System.out.print("000010101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_exit1:")){
            System.out.print("000010110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r4, #0")){
            System.out.print("000011000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("beq rounding_2")){
            System.out.print("000011001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_exit2:")){
            System.out.print("000011010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r5, #0x80")){
            System.out.print("000011011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r6, #0x80")){
            System.out.print("000011100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("beq overflow")){
            System.out.print("000011101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("overflow_end:")){
            System.out.print("000011110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b label")){
            System.out.print("000011111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_1:")){
            System.out.print("000100000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r4, #0x8")){
            System.out.print("000100001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r6, #0x8")){
            System.out.print("000100010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("beq rounding_1_1")){
            System.out.print("000100011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b rounding_exit1")){
            System.out.print("000100100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_1_1:")){
            System.out.print("000100101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r4, #0xF8")){
            System.out.print("000100110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("bgt local_overflow")){
            System.out.print("000100111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("local_overflow_exit:")){
            System.out.print("000101000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("add r4, r4, #0x8")){
            System.out.print("000101001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_2:")){
            System.out.print("000101100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("beq rounding_2_1")){
            System.out.print("000101111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b rounding_exit2")){
            System.out.print("000110000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_2_1:")){
            System.out.print("000110001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r4, #0x7")){
            System.out.print("000110010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("cmp r6, #0")){
            System.out.print("000110011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("bne rounding_2_2")){
            System.out.print("000110100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("rounding_2_2:")){
            System.out.print("000110110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("bgt local_overflow2")){
            System.out.print("000111000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("local_overflow_exit2:")){
            System.out.print("000111001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("overflow:")){
            System.out.print("000111101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("lsr r4, r4, #1")){
            System.out.print("000111110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("and r6, r5, #0x1")){
            System.out.print("000111111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("lsl r6, r6, #7")){
            System.out.print("001000000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("orr r4, r4, r6")){
            System.out.print("001000001"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("lsr r5, r5, #1")){
            System.out.print("001000010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("add r3, r3, #1")){
            System.out.print("001000011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b overflow_end")){
            System.out.print("001000100"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("local_overflow:")){
            System.out.print("001000101"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("add r5, r5, #1")){
            System.out.print("001000110"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b local_overflow_exit")){
            System.out.print("001000111"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("local_overflow2:")){
            System.out.print("001001000"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("b local_overflow_exit2")){
            System.out.print("001001010"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else if(line.equals("label end")){
            System.out.print("001001011"); 
            System.out.print("\t @line number: " + count);
            System.out.println("\t @assembly code: " + line);
          }
          else{
            System.out.println("err");
          }
          line = br.readLine();
          count++;
      }
      br.close();
    }
    catch(IOException e){
      System.out.println();
      Assembler.separator();
      System.out.println("Exception: " + e);
      //System.out.println("Stack Trace: " + e.printStackTrace());
      Assembler.separator();
      System.out.println();
    }
  }

  public static void separator(){
    System.out.println("==============================");
  }
}
