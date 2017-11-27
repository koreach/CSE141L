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
      FileInputStream fileinputstream = new FileInputStream(inputfile);
      InputStreamReader inputstreamreader = new InputStreamReader(fileinputstream);
      BufferedReader br = new BufferedReader(inputstreamreader);
      String line = "";
      while ((line = br.readLine()) != ""){
        if(line=="mov r0, #0x06"{
          System.out.println("69000000000"); 
          else{System.out.println("heheboogers");}
        }
          /*
        switch(line){
          //assembly code for int2float

          case "mov r0, #0x06" :
            System.out.println("000000000"); 
          case "mov r1, #0x80":
            System.out.println("000000001"); 
          case "and r2, r1, #0x80":
            System.out.println("000000010"); 
          case "mov r3, #29":
            System.out.println("000000011"); 
          case "mov r4, r0":
            System.out.println("000000100"); 
          case "and r5, r1, #0xFF":
            System.out.println("000000101"); 
          case "forloop:":
            System.out.println("000000110"); 
          case "and r6, r5, #0x40":
            System.out.println("000000111");
          case "cmp r6, #0x40":
            System.out.println("000001000"); 
          case "beq out":
            System.out.println("000001001"); 
          case "lsl r5, r5, #1":
            System.out.println("000001010"); 
          case "and r6, r4, #0x80": //duplicate4
            System.out.println("000001011"); 
          case "lsr r6, r6, #7":
            System.out.println("000001100"); 
          case "orr r5, r5, r6":
            System.out.println("000001101"); 
          case "lsl r4, r4, #1":
            System.out.println("000001110"); 
          case "and r4, r4, #0xFF": //duplicate2
            System.out.println("000001111"); 
          case "sub r3, r3, #1":
            System.out.println("000010000"); 
          case "b forloop":
            System.out.println("000010001"); 
          case "out:":
            System.out.println("000010010"); 
          case "and r6, r4, #0x10": //duplicate1
            System.out.println("000010011"); 
          case "cmp r6, #0x10":
            System.out.println("000010100"); 
          case "beq rounding_1":
            System.out.println("000010101"); 
          case "rounding_exit1:":
            System.out.println("000010110"); 
          case "cmp r4, #0":
            System.out.println("000011000"); 
          case "beq rounding_2":
            System.out.println("000011001"); 
          case "rounding_exit2:":
            System.out.println("000011010"); 
          case "and r6, r5, #0x80":
            System.out.println("000011011"); 
          case "cmp r6, #0x80":
            System.out.println("000011100"); 
          case "beq overflow":
            System.out.println("000011101"); 
          case "overflow_end:":
            System.out.println("000011110"); 
          case "b label":
            System.out.println("000011111"); 
          case "rounding_1:":
            System.out.println("000100000"); 
          case "cmp r6, #0x8": //duplicate5
            System.out.println("000100010"); 
          case "beq rounding_1_1":
            System.out.println("000100011"); 
          case "b rounding_exit1": //duplicate3
            System.out.println("000100100"); 
          case "rounding_1_1:":
            System.out.println("000100101"); 
          case "cmp r4, #0xF8": //duplicate7
            System.out.println("000100110"); 
          case "bgt local_overflow":
            System.out.println("000100111"); 
          case "local_overflow_exit:":
            System.out.println("000101000"); 
          case "add r4, r4, #0x8": //duplicate8
            System.out.println("000101001"); 
          case "rounding_2:":
            System.out.println("000101100"); 
          case "beq rounding_2_1":
            System.out.println("000101111"); 
          case "b rounding_exit2": //duplicate6
            System.out.println("000110000"); 
          case "rounding_2_1:":
            System.out.println("000110001"); 
          case "and r6, r4, #0x7":
            System.out.println("000110010"); 
          case "cmp r6, #0":
            System.out.println("000110011"); 
          case "bne rounding_2_2":
            System.out.println("000110100"); 
          case "rounding_2_2:":
            System.out.println("000110110"); 
          case "bgt local_overflow2":
            System.out.println("000111000"); 
          case "local_overflow_exit2:":
            System.out.println("000111001"); 
          case "overflow:":
            System.out.println("000111101"); 
          case "lsr r4, r4, #1":
            System.out.println("000111110"); 
          case "and r6, r5, #0x1":
            System.out.println("000111111"); 
          case "lsl r6, r6, #7":
            System.out.println("001000000"); 
          case "orr r4, r4, r6":
            System.out.println("001000001"); 
          case "lsr r5, r5, #1":
            System.out.println("001000010"); 
          case "add r3, r3, #1":
            System.out.println("001000011"); 
          case "b overflow_end":
            System.out.println("001000100"); 
          case "local_overflow:":
            System.out.println("001000101"); 
          case "add r5, r5, #1": //duplicate9
            System.out.println("001000110"); 
          case "b local_overflow_exit":
            System.out.println("001000111"); 
          case "local_overflow2:":
            System.out.println("001001000"); 
          case "b local_overflow_exit2":
            System.out.println("001001010"); 
          case "label end":
            System.out.println("001001011"); 
            */
        }
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
