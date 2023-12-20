### Harvest Moon SNES Text Interpreter
### 0.1 - 2023

# This program decodes the ingame text into ascii

import sys, getopt, codecs

rosseta = {
    "0000": "a","0001": "b","0002": "c","0003": "d","0004": "e","0005": "f","0006": "g",
    "0007": "h","0008": "i","0009": "j","000A": "k","000B": "l","000C": "m","000D": "n",
    "000E": "o","000F": "p","0010": "q","0011": "r","0012": "s","0013": "t","0014": "u",
    "0015": "v","0016": "w","0017": "x","0018": "y","0019": "z",
    "001A": "A","001B": "B","001C": "C","001D": "D","001E": "E","001F": "F","0020": "G",
    "0021": "H","0022": "I","0023": "J","0024": "K","0025": "L","0026": "M","0027": "N",
    "0028": "O","0029": "P","002A": "Q","002B": "R","002C": "S","002D": "T","002E": "U",
    "002F": "V","0030": "W","0031": "X","0032": "Y","0033": "Z","0035": "!",
    "0034":"\'","0036": ".","0037": "?","0038":"\"","0039": "/","003A": ",","003B": "(",
    "003C": ")","003D": "%","003E": "-","0040": "&","0041": ":","0042": "♥","00B1": " ",
    "00B2": "0","00B3": "1","00B4": "2","00B5": "3","00B6": "4","00B7": "5","00B8": "6",
    "00B9": "7","00BA": "8","00BB": "9","00A2": "▼",
}

def decompressor(dinput, doutput, debug):
    data = []
    output = ""

    #Sanitazion and formatting
    with open(dinput,'r') as file:
        for line in file:
            if "ORG" in line:
                continue
            if ":" in line:
                data.append(line.split(":")[0].strip(" ") + ":\n")
                line = line.split(":")[1]
            line = line.split(";")[0]
            line = line.replace("dw", "")
            line = line.replace("$", "")
            line = line.replace("\n", "")
            line = line.strip(" ")

            if line == "":
                continue
            else:
                line = line.split(",")
                for byte in line:
                    data.append(byte)
                    #data.append(f'{int(byte,16):02X}')

    #main loop
    n = 0
    s = 0
    st = ""
    for i in data:

        if i == "00" or i == "db 00":
            continue

        if i == "FFFC":
            s = 1
            st = "c"
            continue
        elif i == "FFFD":
            s = 1
            st = "d"
            continue
        elif i == "FFFE":
            s = 2
            st = "e"
            continue

        if s == 3:
            s = 0
            if st == "c00070001":
                output += "#Money1"
            elif st == "c00070008":
                output += "#Money2"
            elif st == "c00070009":
                output += "#Money3"
            elif st == "c0007000A":
                output += "#Money4"
            elif st == "c0007000E":
                output += "#Money5"
            elif st == "c0007000F":
                output += "#Money6"
            elif st == "c00070010":
                output += "#Money7"
            elif st == "c00070011":
                output += "#Money8"
            elif st == "c00070012":
                output += "#Money9"
            elif st == "c00070013":
                output += "#Mone10"
            elif st == "c00070014":
                output += "#Mone11"
            elif st == "c00070002":
                output += "#Mone12"
            elif st == "c00070015":
                output += "#Mone13"
            elif st == "c00070016":
                output += "#Mone14"
            elif st == "c00070017":
                output += "#Mone15"
            elif st == "c00070018":
                output += "#Mone16"
            elif st == "c00070019":
                output += "#Mone17"
            elif st == "c0007001B":
                output += "#Mone18"
            elif st == "c0007001C":
                output += "#Mone19"
            elif st == "c0007001D":
                output += "#Mone20"
            elif st == "c0007001E":
                output += "#Mone21"
            elif st == "c00070020":
                output += "#Mone22"
            elif st == "c00070021":
                output += "#Mone23"
            elif st == "c00070022":
                output += "#Mone24"
            elif st == "c00070023":
                output += "#Mone25"
            elif st == "c00070024":
                output += "#Mone25"
            elif st == "c00070025":
                output += "#Mone26"
            elif st == "c00070026":
                output += "#Mone27"
            elif st == "c00070027":
                output += "#Mone28"
            elif st == "c00070028":
                output += "#Mone29"
            elif st == "c00070029":
                output += "#Mone30"
            elif st == "c0007002A":
                output += "#Mone31"
            elif st == "c0007002B":
                output += "#Mone32"
            elif st == "c0007002C":
                output += "#Mone33"
            elif st == "c0007002D":
                output += "#Mone34"
            elif st == "c0007002E":
                output += "#Mone35"
            elif st == "c0007002F":
                output += "#Mone36"
            elif st == "c00070030":
                output += "#Mone37"
            elif st == "c00070031":
                output += "#Mone38"
            elif st == "c00070032":
                output += "#Mone39"
            elif st == "c00070033":
                output += "#Mone40"
            elif st == "c00070034":
                output += "#Mone41"
            elif st == "c00070035":
                output += "#Mone42"
            elif st == "c00070036":
                output += "#Mone43"
            elif st == "c00070037":
                output += "#Mone44"
            elif st == "c00070038":
                output += "#Mone45"
            elif st == "c00070039":
                output += "#Mone46"
            elif st == "c0007003A":
                output += "#Mone47"
            elif st == "c0007003B":
                output += "#Mone48"
            elif st == "c0007003C":
                output += "#Mone49"
            elif st == "c0007003E":
                output += "#Mone50"
            elif st == "c0007004E":
                output += "#Mone51"
            elif st == "c00070050":
                output += "#Mone52"
            elif st == "c00070052":
                output += "#Mone53"
            elif st == "c00070054":
                output += "#Mone54"
            elif st == "c00070056":
                output += "#Mone55"
            elif st == "c00070058":
                output += "#Mone56"
            elif st == "c0007005A":
                output += "#Mone57"
            elif st == "c0007005C":
                output += "#Mone58"
            elif st == "c0007005E":
                output += "#Mone59"
            elif st == "c00070060":
                output += "#Mone60"
            elif st == "c00070062":
                output += "#Mone61"
            elif st == "c00070064":
                output += "#Mone62"
            elif st == "c00070066":
                output += "#Mone63"
            elif st == "c00070068":
                output += "#Mone64"
            elif st == "c0007006A":
                output += "#Mone65"

            elif st == "c0004001A":
                output += "#Pr1"    #peddlers price
                n += 4
            elif st == "c00020002":
                output += "#C"      #cows
                n += 2
            elif st == "c0002003F":
                output += "#1"      #cows
                n += 2
            elif st == "c00020003":
                output += "#c"      #chickens
                n += 2
            elif st == "c00020040":
                output += "#2"      #chickens
                n += 2
            elif st == "c00020007":
                output += "#p"      #cow pregnancy days
                n += 2
            elif st == "d0002000D":
                output += "#Or1"    #date + ordinal
                n += 4
            elif st == "d00020011":
                output += "#Or2"
                n += 4
            elif st == "d00020014":
                output += "#Or3"
                n += 4
            elif st == "d00020019":
                output += "#Or4"
                n += 4
            elif st == "d00020026":
                output += "#Or5"
                n += 4
            elif st == "d00020029":
                output += "#Or6"
                n += 4
            elif st == "d0002002C":
                output += "#Or7"
                n += 4
            elif st == "d0002002F":
                output += "#Or8"
                n += 4
            elif st == "d00020032":
                output += "#Or9"
                n += 4
            elif st == "d00020035":
                output += "#O10"
                n += 4
            elif st == "d00020038":
                output += "#O11"
                n += 4
            elif st == "d0002003B":
                output += "#O12"
                n += 4
            elif st == "d0002003E":
                output += "#O13"
                n += 4
            elif st == "d00020041":
                output += "#O14"
                n += 4
            elif st == "d00020044":
                output += "#O15"
                n += 4
            elif st == "d00020047":
                output += "#O16"
                n += 4
            elif st == "d0002004A":
                output += "#O17"
                n += 4
            elif st == "d0002004D":
                output += "#O18"
                n += 4
            elif st == "d00020050":
                output += "#O19"
                n += 4
            elif st == "c00030004":
                output += "#HW"     #wood for house upgrade
                n += 3
            elif st == "c00030005":
                output += "#WO"     #stored wood
                n += 3
            elif st == "c00030006":
                output += "#FE"     #stored feed
                n += 3
            elif st == "c00030041":
                output += "#ST"     #Max stamina
                n += 3
            elif st == "c00030042":
                output += "#AF"     #Max cows Affection
                n += 3
            elif st == "c00030043":
                output += "#MA"     #Maria Affection
                n += 3
            elif st == "c00030044":
                output += "#AN"     #Ann Affection
                n += 3
            elif st == "c00030045":
                output += "#NI"     #Nina Affection
                n += 3
            elif st == "c00030046":
                output += "#EL"     #Ellene Affection
                n += 3
            elif st == "c00030047":
                output += "#Ev"     #Eves Affection
                n += 3
            elif st == "c00030048":
                output += "#TO"     #tomatoes
                n += 3
            elif st == "c00030049":
                output += "#CO"     #Corn
                n += 3
            elif st == "c0003004A":
                output += "#PO"     #Potato
                n += 3
            elif st == "c0003004B":
                output += "#TU"     #Turnip
                n += 3
            elif st == "c0003004C":
                output += "#HA"     #Happiness
                n += 3
            elif st == "c0003006B":
                output += "#R1"     #Ranch Mastery
                n += 3
            elif st == "c0003006C":
                output += "#R2"
                n += 3
            elif st == "c0003006D":
                output += "#R3"
                n += 3
            elif st == "c0003006E":
                output += "#R4"
                n += 3
            elif st == "c0003006F":
                output += "#R5"
                n += 3
            elif st == "c00030070":
                output += "#R6"
                n += 3
            elif st == "d00040002":
                output += "#Ho1"    #name horse
                n += 4
            elif st == "d00040022":
                output += "#Ho2"
                n += 4
            elif st == "d00040023":
                output += "#Ho3"
                n += 4
            elif st == "d00040003":
                output += "#Co1"    #good girl line
                n += 4
            elif st == "d00040004":
                output += "#Co2"    #Cranky line
                n += 4
            elif st == "d00040005":
                output += "#Co3"    #Sick line
                n += 4
            elif st == "d00040006":
                output += "#Co4"    #Pregnant line
                n += 4
            elif st == "d0004001B":
                output += "#Co5"    #dies line
                n += 4
            elif st == "d00040024":
                output += "#Co6"
                n += 4
            elif st == "d00040007":
                output += "#PN1"
                n += 4
            elif st == "d00040001":
                output += "#Do1"    #name dog
                n += 4
            elif st == "d00040008":
                output += "#Do2"
                n += 4
            elif st == "d0004000F":
                output += "#Do3"
                n += 4
            elif st == "d00040017":
                output += "#Do4"
                n += 4
            elif st == "d00040020":
                output += "#Do5"
                n += 4
            elif st == "d00040021":
                output += "#Do6"
                n += 4
            elif st == "d00040009":
                output += "#PN2"
                n += 4
            elif st == "d0004000A":
                output += "#PN3"
                n += 4
            elif st == "d0004000B":
                output += "#PN4"
                n += 4
            elif st == "d00040018":
                output += "#PN5"
                n += 4
            elif st == "d0004001C":
                output += "#PN6"
                n += 4
            elif st == "d0004001D":
                output += "#PN7"
                n += 4
            elif st == "d0004001E":
                output += "#CH1"        #child 1s birthday
                n += 4
            elif st == "d0004001F":
                output += "#CH2"
                n += 4
            elif st == "d0009000C":
                output += "#Dayname1"
                n += 9
            elif st == "d00090010":
                output += "#Dayname2"
                n += 9
            elif st == "d00090013":
                output += "#Dayname3"
                n += 9
            elif st == "d00090025":
                output += "#Dayname4"
                n += 9
            elif st == "d00090028":
                output += "#Dayname5"
                n += 9
            elif st == "d0009002B":
                output += "#Dayname6"
                n += 9
            elif st == "d0009002E":
                output += "#Dayname7"
                n += 9
            elif st == "d00090031":
                output += "#Dayname8"
                n += 9
            elif st == "d00090034":
                output += "#Dayname9"
                n += 9
            elif st == "d00090037":
                output += "#Daynam10"
                n += 9
            elif st == "d0009003A":
                output += "#Daynam11"
                n += 9
            elif st == "d0009003D":
                output += "#Daynam12"
                n += 9
            elif st == "d00090040":
                output += "#Daynam13"
                n += 9
            elif st == "d00090043":
                output += "#Daynan14"
                n += 9
            elif st == "d00090046":
                output += "#Daynam15"
                n += 9
            elif st == "d00090049":
                output += "#Daynam16"
                n += 9
            elif st == "d0009004C":
                output += "#Daynam17"
                n += 9
            elif st == "d0009004F":
                output += "#Daynam18"
                n += 9
            elif st == "d0006000E":
                output += "#Seas1"
                n += 6
            elif st == "d00060012":
                output += "#Seas2"
                n += 6
            elif st == "d00060015":
                output += "#Seas3"
                n += 6
            elif st == "d0006001A":
                output += "#Seas4"
                n += 6
            elif st == "d00060027":
                output += "#Seas5"
                n += 6
            elif st == "d0006002A":
                output += "#Seas6"
                n += 6
            elif st == "d0006002D":
                output += "#Seas7"
                n += 6
            elif st == "d00060030":
                output += "#Seas8"
                n += 6
            elif st == "d00060033":
                output += "#Seas9"
                n += 6
            elif st == "d00060036":
                output += "#Sea10"
                n += 6
            elif st == "d00060039":
                output += "#Sea11"
                n += 6
            elif st == "d0006003C":
                output += "#Sea12"
                n += 6
            elif st == "d0006003F":
                output += "#Sea13"
                n += 6
            elif st == "d00060042":
                output += "#Sea14"
                n += 6
            elif st == "d00060045":
                output += "#Sea15"
                n += 6
            elif st == "d00060048":
                output += "#Sea16"
                n += 6
            elif st == "d0006004B":
                output += "#Sea17"
                n += 6
            elif st == "d0006004E":
                output += "#Sea18"
                n += 6
            elif st == "d00060051":
                output += "#Sea19"
                n += 6
            elif st == "d00050016":
                output += "#Bac1"   #Bachellorete name
                n += 5
            elif st == "c0006001F":
                output += "#Mon01"
                n += 6
            elif st == "e0002":
                output += "»2\n"
                n = 0
            elif st == "e0003":
                output += "»3\n"
                n = 0
            elif st == "e0004":
                output += "»4\n"
                n = 0
            elif st == "e0005":
                output += "»5\n"
                n = 0
            else:
                output += st
                print(st)

        if ":" in i:
            output += "\n" + i
            continue

        if i == "FFFF":
            n = 0
            output += "¬\n"
            continue

        if s > 0:
            s +=1
            st += i
            continue

        if i == "00A2":
            n = 0
            output += "▼\n"
            continue

        if n >= 28:
            n = 0
            output += "\n"

        n +=1

        if i in rosseta:
            output += rosseta[i]
        else:
            print(i)
            output += i


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
