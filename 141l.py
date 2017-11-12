import sys
from bitstring import Bits
#pip install bitstring to get Bits

#creation opcode dictionary with corresponding opcode numbers, use ordered dictionary to matin order if needed
opcode = {"add": 0, "and": 1, "b": 2, "beq": 3, "bge": 4, 
"blt": 5, "bne": 6, "halt": 7, "ldr": 8, "lsl": 9, "lsr": 10, 
"mov": 11, "rsb": 12, "str": 13, "orr": 14, "cmp": 15, "sub": 16}

#account for registers in assembly file
registers = {"r0": 0, "r1": 1, "r2": 2, "r3": 3, "r4": 4, "r5": 5, "r6": 6, "r7": 7}

lookup = {"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "11": 11, "12": 12, "13": 13, "14": 14, "15": 15}

labels_results ={}

#get initial arguments
def getArguments():
	args = sys.argv
	print("Enter your files as arguments i.e .py assembly machine")
	if(len(args) != 3):
		print("error")
		sys.exit(0)
	return args

#convert decimal number into binary
def int2bin(i):
    if(i == 0): 
    	return "0"
    s = ''
    while i:
        if(i & 1 == 1):
            s = "1" + s
        else:
            s = "0" + s
        i /= 2
    return s

#main function
if __name__ == "__main__":
	args = getArguments()
	assemblyFile = open(args[1], 'r').read().split('\n')
	#print opcode
	lineNumber = 1
	label = ""
	instruction = ""
	

	#first loop to find all labels and their corressponding line number
	for currentLine in assemblyFile:

		if(',' in currentLine):
			#print("has comma")
			instruction = currentLine.split(' ')
			print(instruction)
			first = instruction[1]
			first = first.strip(',')
			print instruction[0]
			print first
		else:
			label = currentLine
			print(label)
			labels_results[label] = lineNumber

		lineNumber = lineNumber + 1
	print labels_results
		# print(currentLine)
		# if(currentLine in opcode):
		# 	value = opcode[currentLine]
		# 	print int2bin(value)
		# 	print bin(value)

	#second loop to write out to file after we get labels
	assemblyFile = open(args[1], 'r')
	outputFile = open(args[2], 'w')
	for currentLine in assemblyFile:
		if(',' in currentLine):
			instruction = currentLine.split(' ')
			return_value = ""
			for element in instruction:
				print element
				element = element.strip(',')
				element = element.strip('#')
				element = element.strip('\n')
				if(element in opcode):
					value = opcode[element]
		 			check4bits = int2bin(value)
		 			while(len(check4bits)!= 5):
		 				check4bits = check4bits.zfill(5)
		 			return_value += check4bits + "_"
		 			

		 		elif(element in registers):
		 			value = registers[element]
		 			check3bits = int2bin(value)
		 			while(len(check3bits)!= 3):
		 				check3bits = check3bits.zfill(3)
		 			return_value += check3bits

		 		elif('x' in element):
		 			result = int(element, 16)
		 			
		 			result = int2bin(result)
		 			return_value += result

		 		else:
		 			print("this is bin")
		 			return_value += int2bin(int(element))

		 	outputFile.write(return_value + "\n")
	outputFile.close()
