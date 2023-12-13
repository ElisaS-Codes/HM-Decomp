### Harvest Moon SNES TileBank Decompressor
### 0.1 - 2023

# -c: compress TODO

# This program compresses or uncompresses a whole bank of tilemap info into or
# from png files. For now, it only decompresses

import sys, getopt, png

palette=[(0x0,0x0,0x0), (0x10,0x10,0x10),(0x20,0x20,0x20), (0x30,0x30,0x30),(0x40,0x40,0x40), (0x50,0x50,0x50),(0x60,0x60,0x60), (0x70,0x70,0x70),(0x80,0x80,0x80), (0x90,0x90,0x90),(0xA0,0xA0,0xA0), (0xB0,0xB0,0xB0),(0xC0,0xC0,0xC0), (0xD0,0xD0,0xD0),(0xE0,0xE0,0xE0), (0xf0,0xf0,0xf0)]

def getControlArray(byte):
    flags = f'{byte:08b}'
    flags = [*flags]
    for i in range(8):
        if flags[i] == "1":
            flags[i] = True
        else:
            flags[i] = False
    return flags

def get8x8(data):

    #format as binary string so we can iterate
    binary = []
    for i in range(len(data)):
        binary.append(f'{data[i]:08b}')

    tile = []
    for i in range(0,int(len(data)/2),2):
        bits1 = [*binary[i]]
        bits2 = [*binary[i+1]]
        bits3 = [*binary[i+16]]
        bits4 = [*binary[i+17]]
        pixel = [0]*8

        for j in range(8):
            pixel[j] = (int(bits4[j],2) <<3) + (int(bits3[j],2) <<2) + (int(bits2[j],2) <<1) + int(bits1[j],2)

        tile.append(pixel)

    return tile

def decompressor(data , blockoffset):
    data_i = 4 + blockoffset #the first two numbers are the size, the second two are skiped
    output = []
    output7F = []
    output_i = 0
    output7F_i = 2014
    target_size = 0
    flags_i = -1
    flags = []
    size_reached = False

    #Get size of data:
    target_size = (data[blockoffset + 1] << 8) + data[blockoffset]
    output = [0] * target_size
    output7F = [0] * target_size

    #main loop
    while True:

        if flags_i < 0:
            flags = getControlArray(data[data_i])
            data_i += 1
            flags_i = 7
            continue

        if flags[flags_i]:
            output[output_i] = data[data_i]
            output7F[output7F_i] = data[data_i]
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

    #Make PNG string

    height = 1
    width = 16

    #height calculation
    height = int(len(output) / (8 * 16 * 4))

    #loop
    result = []
    for h in range(height):
        line0 = []
        line1 = []
        line2 = []
        line3 = []
        line4 = []
        line5 = []
        line6 = []
        line7 = []
        for w in range(width):
            tile = get8x8(output[32*w+512*h : 32*(w+1)+512*h])
            line0 += tile[0]
            line1 += tile[1]
            line2 += tile[2]
            line3 += tile[3]
            line4 += tile[4]
            line5 += tile[5]
            line6 += tile[6]
            line7 += tile[7]
        result += [line0]+[line1]+[line2]+[line3]+[line4]+[line5]+[line6]+[line7]

    #Output

    print(blockoffset, data_i, (data[blockoffset + 1] << 8) + data[blockoffset])

    return data_i, result, height

def openasm(dinput):
    data = []
    offsetadjust = 0
    offset = 0

    #Sanitazion and formatting
    with open(dinput,'r') as file:
        for line in file:
            if "ORG" in line:
                line = line.replace("ORG $", "")
                line = line.replace(";", "")
                line = line.strip(" ")
                offsetadjust = int(line,16)
                continue
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

    while True:

        #end of data check
        if (data[offset+0] + data[offset+1] + data[offset+2] + data[offset+3]) == 0:
            break

        offset, result, height = decompressor(data, offset)

        writer = png.Writer(width=128,height=height*8,palette=palette,bitdepth=4)
        f = open ("Tilemap" + str(hex(offsetadjust + offset)) + ".png", 'wb')
        writer.write(f, result)
        f.close()


def compressor(dinput, doutput):
    print ('TODO')
    sys.exit()

def main(argv):
    dinput = ""
    doutput = ""
    decomp = True
    debug = False

    try:
        opts, args = getopt.getopt(argv,"hci:",["input="])
    except:
        print ("test.py [-c] -i input_file -o output_file")
        sys.exit()

    for opt, arg in opts:
        if opt == "-h":
            print ("test.py [-c: compress] -i <input_file> -o <output_file>")
            sys.exit()
        elif opt == "-c":
            decomp = False
        elif opt in ("-i", "--input"):
            dinput = arg
        elif opt in ("-o", "--output"):
            doutput = arg
    if decomp:
        openasm(dinput)
    else:
        compressor

if __name__ == "__main__":
    main(sys.argv[1:])
