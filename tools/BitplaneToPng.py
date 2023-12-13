### Harvest Moon Text Interpreter
### 031 - 2023
# Requires pypng

#I hate pypng, a ton of weird array things to make it work

import sys, getopt, png

palette=[(0x0,0x0,0x0), (0x10,0x10,0x10),(0x20,0x20,0x20), (0x30,0x30,0x30),(0x40,0x40,0x40), (0x50,0x50,0x50),(0x60,0x60,0x60), (0x70,0x70,0x70),(0x80,0x80,0x80), (0x90,0x90,0x90),(0xA0,0xA0,0xA0), (0xB0,0xB0,0xB0),(0xC0,0xC0,0xC0), (0xD0,0xD0,0xD0),(0xE0,0xE0,0xE0), (0xf0,0xf0,0xf0)]

def get8x8(data):
    tile = []
    for i in range(0,int(len(data)/2),2):
        bits1 = [*data[i]]
        bits2 = [*data[i+1]]
        bits3 = [*data[i+16]]
        bits4 = [*data[i+17]]
        pixel = [0]*8

        for j in range(8):
            pixel[j] = (int(bits4[j],2) <<3) + (int(bits3[j],2) <<2) + (int(bits2[j],2) <<1) + int(bits1[j],2)

        tile.append(pixel)

    return tile

def topng(dinput, doutput):
    data = []
    output = ""
    height = 1
    width = 16

    #Sanitazion and formatting
    with open(dinput,'r') as file:
        for line in file:
            if "ORG" in line:
                continue
            line = line.split(";")[0]
            line = line.replace("db ", "")
            line = line.replace("$", "")
            line = line.replace("\n", "")
            line = line.strip(" ")

            if line == "":
                continue
            else:
                line = line.split(",")
                for byte in line:
                    data.append(f'{int(byte,16):08b}')

    #height calculation
    height = int(len(data) / (8 * 16 * 4))

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
            tile = get8x8(data[32*w+512*h : 32*(w+1)+512*h])
            line0 += tile[0]
            line1 += tile[1]
            line2 += tile[2]
            line3 += tile[3]
            line4 += tile[4]
            line5 += tile[5]
            line6 += tile[6]
            line7 += tile[7]
        result += [line0]+[line1]+[line2]+[line3]+[line4]+[line5]+[line6]+[line7]

    writer = png.Writer(width=width*8,height=height*8,palette=palette,bitdepth=4)
    f = open (doutput, 'wb')
    writer.write(f, result)
    f.close()


    output = ""

def main(argv):
    dinput = ""
    doutput = ""
    decomp = True
    debug = False

    try:
        opts, args = getopt.getopt(argv,"hi:o:",["input=","output="])
    except:
        print ("test.py -i input_file -o output_file")
        sys.exit()

    for opt, arg in opts:
        if opt == "-h":
            print ("test.py input_file output_file")
            sys.exit()
        elif opt in ("-i", "--input"):
            dinput = arg
        elif opt in ("-o", "--output"):
            doutput = arg
    if decomp:
        topng(dinput, doutput)
    else:
        compressor

if __name__ == "__main__":
    main(sys.argv[1:])