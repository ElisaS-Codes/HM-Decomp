### Harvest Moon SNES Tilemap Decompressor
### 0.1 - 2023

# -d: debug result, the same as the data provided
# -c: compress TODO

# This program compresses or uncompresses text files used as tiles or character
# maps on the game Harvest Moon for SNES. Values are separated by comas. End of
# lines might be added or read, when decompressing, but they are ignored, only for
# formatting

# =====================
# Tilemap Decompression
# =====================
#
# Tilemap Decompression structure:
# 2 bytes			Uncompressed data size
# 2 bytes			Unused
# 1 byte			First control byte
#
# Control bytes are 8 control bits, that gets pulled one by one, if the bit is a one,
# 1 byte of data is copied straight from source pointer into destination pointer.
# If a control bit is zero, it means it has to repeat part of the already decompressed
# code. The next bite is special, the first 3 bits are the amount of times to copy,
# this value is added 3, as it wont do this for lest than 3 bytes, so max is 10.
# The next 5 bites are the offset of where to copy them.
#
# Once it reads all control bits from the byte, it will get another control byte.
# Repeat till you arrive to the uncompressed data size.
#
# The function decompress to both a space on bank $7E specified by a pointer, thats the
# copy of the VRAM the game keeps, it also copies the same data to a hardcoded space on
# the $7F bank, to be used for immediate copy.




import sys, getopt


def getControlArray(byte):
    flags = f'{byte:08b}'
    flags = [*flags]
    for i in range(8):
        if flags[i] == "1":
            flags[i] = True
        else:
            flags[i] = False
    return flags

def decompressor(dinput, doutput, debug):
    data = []
    data_i = 4 #the first two numbers are the size, the second two are skiped
    output = []
    output7F = []
    output_i = 0
    output7F_i = 2014
    target_size = 0
    flags_i = -1
    flags = []
    size_reached = False

    debugdata = []

    #Sanitazion and formatting
    with open(dinput,'r') as file:
        for line in file:
            line = line.split(";")[0]
            line = line.replace("db", "")
            line = line.replace("$", "")
            line = line.replace("\n", "")
            line = line.strip(" ")

            if line == "":
                continue
            else:
                line = line.split(",")
                for byte in line:
                    data.append(int(byte, 16))

    #Get size of data:
    target_size = (data[1] << 8) + data[0]
    output = [0] * target_size
    output7F = [0] * target_size

    #main loop
    while True:

        if flags_i < 0:
            flags = getControlArray(data[data_i])
            debugdata.append(data[data_i])
            data_i += 1
            flags_i = 7
            continue

        if flags[flags_i]:
            output[output_i] = data[data_i]
            output7F[output7F_i] = data[data_i]
            debugdata.append(data[data_i])
            data_i += 1
            output_i += 1

            target_size -= 1
            if target_size == 0:
                break

            output7F_i += 1
            if output7F_i > 2047:
                output7F_i = 0

            if output_i == 195:
                f = ""

        else:

            offset = data[data_i]
            special = data[data_i + 1]
            debugdata.append(data[data_i])
            debugdata.append(data[data_i + 1])
            copy_N = (special & 31) + 3
            offsethigh = (special & 224) << 3
            offset = offset | offsethigh
            data_i += 2

            if output7F[offset] == 77:
                f = ""

            for j in range(copy_N):
                output[output_i] = output7F[offset]
                output_i += 1

                target_size -= 1
                if target_size == 0:
                    size_reached = True
                    break

                output7F[output7F_i] = output7F[offset]

                output7F_i += 1
                if output7F_i > 2047:
                    output7F_i = 0

                offset += 1
                if offset > 2047:
                    offset = 0

        if size_reached:
            break

        flags_i -= 1

    #Debug, output source file
    if debug:
        file = open("debug.txt", "w")
        SourceData = ""
        temp = "$" + f'{data[0]:02X}'  + ","
        temp = temp + "$" + f'{data[1]:02X}'  + ","
        temp = temp + "$" + f'{data[2]:02X}'  + ","
        temp = temp + "$" + f'{data[3]:02X}'  + ","
        for i in range(len(debugdata)):
            temp = temp + "$" + f'{debugdata[i]:02X}' + ","
        j=0
        for i in range(int(len(temp)/64)):
            j += 1
            SourceData = SourceData + "db " + temp[i*64:63+i*64] + "\n"
        SourceData = SourceData + "db " + temp[j*64:-1]
        file.write(SourceData)
        file.close()

    #Output
    temp = ""
    n = 0
    for i in output:
        n += 1
        temp += f'{i:02X}' + " "

        if n == 16:
            temp += "\n"
            n = 0

    file = open(doutput, "w")
    file.write(temp)
    file.close()


def compressor(dinput, doutput):
    print ('TODO')
    sys.exit()



def main(argv):
    dinput = ""
    doutput = ""
    decomp = True
    debug = False

    try:
        opts, args = getopt.getopt(argv,"hcdi:o:",["input=","output="])
    except:
        print ("test.py [-c] [-d] -i input_file -o output_file")
        sys.exit()

    for opt, arg in opts:
        if opt == "-h":
            print ("test.py [-c: compress] [-d: debug info] -i <input_file> -o <output_file>")
            sys.exit()
        elif opt == "-c":
            decomp = False
        elif opt == "-d":
            debug = True
        elif opt in ("-i", "--input"):
            dinput = arg
        elif opt in ("-o", "--output"):
            doutput = arg
    if decomp:
        decompressor(dinput, doutput, debug)
    else:
        compressor

if __name__ == "__main__":
    main(sys.argv[1:])
