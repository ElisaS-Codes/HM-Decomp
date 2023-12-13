### Harvest Moon SNES Text Interpreter
### 0.1 - 2023

# This program decodes the ingame text into ascii

import sys, getopt, codecs

rosseta = {
    "00": "a","01": "b","02": "c","03": "d","04": "e","05": "f","06": "g",
    "07": "h","08": "i","09": "j","0A": "k","0B": "l","0C": "m","0D": "n",
    "0E": "o","0F": "p","10": "q","11": "r","12": "s","13": "t","14": "u",
    "15": "v","16": "w","17": "x","18": "y","19": "z",
    "1A": "A","1B": "B","1C": "C","1D": "D","1E": "E","1F": "F","20": "G","21": "H","22": "I","23": "J","24": "K","25": "L","26": "M","27": "N","28": "O","29": "P","2A": "Q","2B": "R","2C": "S","2D": "T","2E": "U","2F": "V","30": "W","31": "X","32": "Y","33": "Z",
    "34":"\'","36":".","37": " ","38": "\"","39": "/","3A":"!","3B": "(","3C": ")","3D": "%","40": "&","41": ":","42": "♥","B1": " ",
    "B2": "0","B3": "1","B4": "2","B5": "3","B6": "4","B7": "5","B8": "6","B9": "7","BA": "8","BB": "9",
    "A2": "▼",
}
#$26,$00,$11,$08,$00

def decompressor(dinput, doutput, debug):
    data = []
    output = ""

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
                    data.append(f'{int(byte,16):02X}')

    #main loop
    pad = False
    n = 0
    for i in data:
        if pad:
            pad = False
            continue
        else:
            pad = True

        if i == "FF":
            n = 0
            output += "\n"
            continue
        if n == 0 and i == "B1":
            continue

        if i in rosseta:
            output += rosseta[i]
        else:
            output += i

        if i == "A2":
            n = 0
            output += "\n"

        n +=1

        if n == 28:
            n = 0
            output += "\n"

    #Output
    file = codecs.open(doutput, "w", "utf-8")
    file.write(str(output))
    file.close()


def compressor(dinput, doutput):
    print ('todo comp')
    sys.exit()

def main(argv):
    dinput = ""
    doutput = ""
    decomp = True
    debug = False

    try:
        opts, args = getopt.getopt(argv,"hexi:o:",["input=","output="])
    except:
        print ("test.py [-e: encode] [-f: extra format data] -i input_file -o output_file")
        sys.exit()

    for opt, arg in opts:
        if opt == "-h":
            print ("test.py [-e: encode] [-f: extra format data] -i input_file -o output_file")
            sys.exit()
        elif opt == "-e":
            decomp = False
        elif opt == "-x":
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
