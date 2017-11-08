import sys
def find_pc(search_word, lines, idx_no):
    print (search_word)
    for idx,line in enumerate(lines):
        line = line.split('//')[0]
        # print (idx != idx_no)
        # print (line.find(search_word) == 0)
        if (line.find(search_word) == 0 and idx != idx_no):
            return idx
file_write = open("binary_program.txt", "w")
def pre_process(lines):
    labels = []
    for idx, line in enumerate(lines):
        line = line.split('//')[0]
        #line_split = line.rstrip().split(' ')
        if len(line.replace(" ", "")) ==0:
            labels.append(idx)
    print (labels)
    for i in sorted(labels, reverse = True):
        del lines[i]
    print (lines)
    return lines
with open(sys.argv[1]) as prog:
    lines = prog.readlines()
    lines = pre_process(lines)
    for idx,line in enumerate(lines):
        line = line.strip()
        line = line.split('//')[0]
        #line_split = line.rstrip().split(' ')
        #if len(line_split) > 0:
        if line.find(":") != -1:
            line = line.split(':')[1].strip()
        line = line.rstrip().split(' ')
        opcode = line[0]
        if opcode == "ADD":
            ad_1 = line[1][1:]
            ad_2 = line[2][1:]
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000000"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";" + " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "SUB":
            ad_1 = line[1][1:]
            ad_2 = line[2][1:]
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000001"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "BITWISE_AND":
            ad_1 = line[1][1:]
            ad_2 = line[2][1:]
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000010"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "BITWISE_OR":
            ad_1 = line[1][1:]
            ad_2 = line[2][1:]
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000011"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "LEFT_SHIFT":
            ad_1 = line[1][1:]
            ad_2 = "0"
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000100"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "RIGHT_SHIFT":
            ad_1 = line[1][1:]
            ad_2 = "0"
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000101"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "LOAD":
            data_load = line[2];
            ad_1 = line[1][1:]
            ad_2 = "0"
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            data_load = bin(int(data_load))[2:].zfill(8)
            opcode = "00000110"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "CMP":
            ad_1 = line[1][1:]
            ad_2 = line[2][1:]
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00000111"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "MOV":
            ad_1 = line[1][1:]
            ad_2 = line[2][1:]
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            opcode = "00001000"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "IF":
            ad_1 = line[1][1:]
            ad_2 = line[3]
            # data_load = str(int(line[5]))
            op1 = bin(int(ad_1))[2:].zfill(3)
            op2 = bin(int(ad_2))[2:].zfill(3)
            search_word = line[5]
            data_load = find_pc(search_word, lines, idx)
            print (data_load)
            data_load = bin(int(data_load))[2:].zfill(8)
            opcode = "00001001"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+" "+opcode+" "+op1+" "+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "HALT":
            opcode = "00001010"
            op_1 = "000"
            op_2 = "000"
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "STRI":
            # To store a value in ram (raw value)
            # STRI 3 5
            opcode = "00001011"
            op1 = bin(int(line[1]))[2:].zfill(3)
            data_load = bin(int(line[2]))[2:].zfill(8)
            op2 = "000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))            
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "LDR":
            # Load from ram to alu register
            # LDR R4 2 // Load from 2 register in ram to alu
            opcode = "00001100"
            ad_1 = int(line[1][1:])
            ad_2 = int(line[2])
            op1 = bin(ad_1)[2:].zfill(3)
            print (op1)
            op2 = bin(ad_2)[2:].zfill(3)
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "STR":
            # Store the value in reg(alu) to ram
            # STR 3 R5 (store the value in r5 to 3 register in ram)
            opcode = "00001101"
            ad_1 = int(line[1])
            ad_2 = int(line[2][1:])
            op2 = bin(ad_1)[2:].zfill(3)
            op1 = bin(ad_2)[2:].zfill(3)
            data_load = "00000000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))            
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)                    
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "INC":
            opcode = "00001110"
            print (line[1][1:])
            ad_1 = int(line[1][1:])
            op1 = bin(ad_1)[2:].zfill(3)
            data_load = "00000000"
            op2 = "000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))            
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        elif opcode == "DEC":
            opcode = "00001111"
            ad_1 = int(line[1][1:])
            op1 = bin(ad_1)[2:].zfill(3)
            data_load = "00000000"
            op2 = "000"
            print ("dm_array[" +str(idx) + "] = " + "22'b"+data_load+opcode+op1+op2+";"+ " // " + str(lines[idx].rstrip()))            
            if (idx == len(lines)-1):
                file_write.write(data_load+opcode+op1+op2)
            else:
                file_write.write(data_load+opcode+op1+op2+"\n")
        else:
            print("No operation %s exists", str(opcode))