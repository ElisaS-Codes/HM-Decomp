;;;; PPU/Audio registers

;TODO: Add info from https://wiki.superfamicom.org/registers
;Default is Single Write


;Screen Display Register
!INIDISP = $2100 ;x---bbbb
; x = Force blank on when set.
; bbbb = Screen brightness, F=max, 0="off".

;Object Size and Character Size Register
!OBSEL = $2101 ;sssnnbbb
; sss = Object size:
;     000 =  8x8  and 16x16 sprites
;     001 =  8x8  and 32x32 sprites
;     010 =  8x8  and 64x64 sprites
;     011 = 16x16 and 32x32 sprites
;     100 = 16x16 and 64x64 sprites
;     101 = 32x32 and 64x64 sprites
;     110 = 16x32 and 32x64 sprites ('undocumented')
;     111 = 16x32 and 32x32 sprites ('undocumented')
; nn = Name Select
;     bbb  = Name Base Select (Addr>>14)

;OAM Address Registers
!OAMADDL = $2102 ;
!OAMADDH = $2103 ;

;OAM Data Write Register
!OAMDATA = $2104 ;

;BG Mode and Character Size Register
!BGMODE = $2105 ;DCBAemmm
; A/B/C/D = BG character size for BG1/BG2/BG3/BG4
; mmm  = BG Mode
; e = Mode 1 BG3 priority bit
;            Mode     BG depth  OPT  Priorities
;                     1 2 3 4        Front -> Back
;            -=-------=-=-=-=----=---============---
;             0       2 2 2 2    n    3AB2ab1CD0cd
;             1       4 4 2      n    3AB2ab1C 0c
;                        * if e set: C3AB2ab1  0c
;             2       4 4        y    3A 2B 1a 0b
;             3       8 4        n    3A 2B 1a 0b
;             4       8 2        y    3A 2B 1a 0b
;             5       4 2        n    3A 2B 1a 0b
;             6       4          y    3A 2  1a 0
;             7       8          n    3  2  1a 0
;             7+EXTBG 8 7        n    3  2B 1a 0b
;
; 9 = Mode one, bg3 priority

;Mosaic Register
!MOSAIC = $2106 ;

;BG Tilemap Address Registers
!BG1SC = $2107 ;
!BG2SC = $2108 ;
!BG3SC = $2109 ;
!BG4SC = $210A ;

;BG Character Address Registers
!BG12NBA = $210B ;
!BG34NBA = $210C ;

;BG Scroll registers, all are dual write
!BG1HOFS = $210D ;
!BG1VOFS = $210E ;
!BG2HOFS = $210F ;
!BG2VOFS = $2110 ;
!BG3HOFS = $2111 ;
!BG3VOFS = $2112 ;
!BG4HOFS = $2113 ;
!BG4VOFS = $2114 ;

;Video Port Control Register
!VMAIN = $2115 ;i---mmjj
; i = Address increment mode^:
;     0 => increment after writing $2118/reading $2139
;     1 => increment after writing $2119/reading $213A
; jj = Address increment amount
;     00 = Normal increment by 1
;     01 = Increment by 32
;     1- = Increment by 128
; mm = Address remapping
;     00 = No remapping
;     01 = Remap addressing aaaaaaaaBBBccccc => aaaaaaaacccccBBB
;     10 = Remap addressing aaaaaaaBBBcccccc => aaaaaaaccccccBBB
;     11 = Remap addressing aaaaaaBBBccccccc => aaaaaacccccccBBB

;VRAM Address Registers (Low)
!VMADDL = $2116 ;
!VMADDH = $2117 ;

;VRAM Data Write Registers (Low)
!VMDATAL = $2118 ;
!VMDATAH = $2119 ;

;Mode 7 Settings Registers, they are never used but blanked on RESET
!M7SEL = $211A
!M7A = $211B
!M7B = $211C
!M7C = $211D
!M7D = $211E
!M7X = $211F
!M7Y = $2120

;CGRAM Address Register
!CGADD = $2121 ;
!CGDATA = $2122 ; dual 	write

;Window Mask Settings Registers
!W12SEL = $2123 ;
!W34SEL = $2124 ;
!WOBJSEL = $2125 ;

;Window Position Registers
!WH0 = $2126 ;
!WH1 = $2127 ;
!WH2 = $2128 ;
!WH3 = $2129 ;

;Window Mask Logic registers
!WBGLOG = $212A ;
!WOBJLOG = $212B ;

;Screen Destination Registers
!TM = $212C ;
!TS = $212D ;

;Window Mask Destination Registers
!TMW = $212E ;
!TSW = $212F ;

;Color math registers
!CGWSEL = $2130 ;ccmm--sd
; cc = Clip colors to black before math
;     00 => Never
;     01 => Outside Color Window only
;     10 => Inside Color Window only
;     11 => Always
; mm = Prevent color math
;     00 => Never
;     01 => Outside Color Window only
;     10 => Inside Color Window only
;     11 => Always
; s  = Add subscreen (instead of fixed color)
; d = Direct color mode for 256-color BGs
!CGADSUB = $2131 ;shbo4321
; s = Add/subtract select
;     0 => Add the colors
;     1 => Subtract the colors
; h = Half color math.^
;     When set, the result of the color math is divided by 2 (except when $2130
;     bit 1 is set and the fixed color is used, or when color is clipped).
; 4/3/2/1/o/b = Enable color math on BG1/BG2/BG3/BG4/OBJ/Backdrop ^^
;     Note that color math is only applied to objects that use palette entries
;     4-7
!COLDATA = $2132 ;

;Screen Mode Select Register
!SETINI = $2133 ;

;Fast Signed Multiplication, not used but blanked in RESET
!MPYL = $2134
!MPYM = $2135
!MPYH = $2136

;Software Latch Register
!SLHV = $2137 ;

;OAM Data Read Register
!OAMDATAREAD = $2138 ;

;VRAM Data Read Register
!VMDATALREAD = $2139 ;
!VMDATAHREAD = $213A ;

;CGRAM Data Read Register
!CGDATAREAD = $213B ;

;Scanline Location Registers
!OPHCT = $213C ;
!OPVCT = $213D ;

;PPU Status Register
!STAT77 = $213E ;
!STAT78 = $213F ;

;APU IO Registers
!APUIO0 = $2140
!APUIO1 = $2141
!APUIO2 = $2142
!APUIO3 = $2143

;WRAM Data Register
!WMDATA = $2180 ;
!WMADDL = $2181 ;
!WMADDM = $2182 ;
!WMADDH = $2183 ;



;;;; Internal CPU registers

;Interrupt Enable Register
!NMITIMEN = $4200 ;n-yx---a
; n        = Enable NMI.
; x/y    = IRQ enable.
;     0/0 => No IRQ will occur
;     0/1 => An IRQ will occur sometime just after the V Counter reaches the value set in $4209/a.
;     1/0 => An IRQ will occur sometime just after the H Counter reaches the value set in $4207/8.
;     1/1 => An IRQ will occur sometime just after the H Counter reaches the value set in $4207/8 when V Counter equals the value set in $4209/a.
; a = Auto-Joypad Read Enable.

;IO Port Write Register
!WRIO = $4201 ; abxxxxxx
;This is basically just an 8-bit I/O Port. 'b' is connected to pin 6 of Controller
;Port 1. 'a' is connected to pin 6 of Controller Port 2, and to the PPU Latch
;line. Thus, writing a 0 then a 1 to bit 'a' will latch the H and V Counters much
;like reading $2137 (the latch happens on the transition to 0). When bit 'a' is 0,
;no latching can occur. Any other effects of this register are unknown. See $4213
;for the I half of the I/O Port. Note that the IO Port is initialized as if this
;register were written with all 1-bits at power up, unchanged on reset(?).

;Hardware multiplication
!WRMPYA = $4202
!WRMPYB = $4203

;Hardware division
!WRDIVL = $4204 ; Divisor low
!WRDIVH = $4205 ;
!WRDIVB = $4206 ; Dividend

;IRQ Timer Registers
!HTIMEL = $4207 ;
!HTIMEH = $4208 ;
!VTIMEL = $4209 ;
!VTIMEH = $420A ;

;DMA Enable Register
!MDMAEN = $420B ;
!HDMAEN = $420C ;

;ROM Speed Register
!MEMSEL = $420D ;

;Interrupt Flag Registers
!RDNMI = $4210 ;
!TIMEUP = $4211 ;

;PPU Status Register
!HVBJOY = $4212 ; vh-----a
; v = V-Blank Flag.
; h = H-Blank Flag.
; a = Auto-Joypad Status.

;IO Port Read Register
!RDIO = $4213 ; ab-- ----

;Hardware multiplication and division results
!RDDIVL = $4214 ;
!RDDIVH = $4215 ;
!RDMPYL = $4216 ;
!RDMPYH = $4217 ;

;Controller Port Data Registers
!JOY1L = $4218 ;
!JOY1H = $4219 ;
!JOY2L = $421A ;
!JOY2H = $421B ;
!JOY3L = $421C ;
!JOY3H = $421D ;
!JOY4L = $421E ; axlr0000
!JOY4H = $421F ; byetUDLR
; a/b/x/y/l/r/e/t = A/B/X/Y/L/R/Select/Start button status.
; U/D/L/R         = Up/Down/Left/Right control pad status.



;;;; DMA Registers

;Channel 0 - these are mostly indexed by soft, so ill only name the first channel
;I dont think this game uses HDMA, might add those later
!DMAP0 = $4300 ;da-ifttt
; d = Transfer Direction.^
; a = HDMA Addressing Mode.^^
; i = DMA Address Increment.^^^
; f = DMA Fixed Transfer.^^^^
; ttt = Transfer Mode.
;     000 => 1 register write once             (1 byte:  p               )
;     001 => 2 registers write once            (2 bytes: p, p+1          )
;     010 => 1 register write twice            (2 bytes: p, p            )
;     011 => 2 registers write twice each      (4 bytes: p, p,   p+1, p+1)
;     100 => 4 registers write once            (4 bytes: p, p+1, p+2, p+3)
;     101 => 2 registers write twice alternate (4 bytes: p, p+1, p,   p+1)
;     110 => 1 register write twice            (2 bytes: p, p            )
;     111 => 2 registers write twice each      (4 bytes: p, p,   p+1, p+1)
!BBAD0 = $4301 ;This specifies the Bus B address to access.
!A1T0L = $4302 ;DMA Source Address Registers
!A1T0H = $4303
!A1B0 = $4304 ;DMA Source Address Registers Bank
!DAS0L = $4305 ;DMA Size Registers
!DAS0H = $4306


;;;; 24Bit versions
;Some functions, I belived are copied from some test, or are somehow remnants of old code, and
;for some unphatomless reason, access some hardware regsiters with the full and slow 24bit
;adresses. To keep compatibility, I created these ugly 24 address versions of the hardware registers
;Main culprit is ManageGraphicPresets
!INIDISP24 = $002100
!OBSEL24 = $002101
!BGMODE24 = $002105
!BG1SC24 = $002107 ;
!BG2SC24 = $002108 ;
!BG3SC24 = $002109 ;
!BG4SC24 = $00210A ;
!BG12NBA24 = $00210B ;
!BG34NBA24 = $00210C ;
!BG1HOFS24 = $00210D ;
!BG1VOFS24 = $00210E ;
!M7SEL24 = $00211A
!W12SEL24 = $002123 ;
!W34SEL24 = $002124 ;
!WOBJSEL24 = $002125 ;
!WH024 = $002126 ;
!WH124 = $002127 ;
!WH224 = $002128 ;
!WH324 = $002129 ;
!WBGLOG24 = $00212A ;
!WOBJLOG24 = $00212B ;
!TM24 = $00212C ;
!TS24 = $00212D ;
!TMW24 = $00212E ;
!TSW24 = $00212F ;
!CGWSEL24 = $002130
!CGADSUB24 = $002131
!COLDATA24 = $002132 ;
!SETINI24 = $002133 ;
!NMITIMEN24 = $004200
!WRMPYA24 = $004202
!WRMPYB24 = $004203
!WRDIVL24 = $004204
!WRDIVB24 = $004206
!RDDIVL24 = $004214
!RDMPYL24 = $004216