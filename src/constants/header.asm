ORG $80FFB0

!COP_Interrupt = $008698               ;Some interrupts starts the previus location

db "E9"                                ;ASCII maker code
db "AYWE"                              ;ASCII game code
db $00,$00,$00,$00,$00,$00             ;RESERVED
db $00,$00,$00,$00                     ;Extra Hardware
db "HARVEST MOON         "             ;Title
db $30                                 ;ROM speed and memory map mode (Fast Lowrom)
db $02                                 ;Chipset (ROM + RAM + battery)
db $0B                                 ;ROM size (2048k)
db $03                                 ;RAM size (8k)
db $01                                 ;Country (NTSC)
db $33                                 ;Developer ID (Expanded Header)
db $00                                 ;ROM version
dw $81C3                               ;Checksum 
dw $7E3C                               ;Checksum Compliment

;;;  Interrupt vectors
dw !COP_Interrupt                      ;unused
dw !COP_Interrupt                      ;unused
dw !COP_Interrupt                      ;Native COP
dw !COP_Interrupt                      ;Native BRK
dw !COP_Interrupt                      ;Native ABORT
dw NMI_Interrupt                       ;Native NMI
dw !COP_Interrupt                      ;Native Reset (unused)
dw COP_Interrupt                       ;IRQ
dw !COP_Interrupt                      ;unused
dw !COP_Interrupt                      ;unused
dw !COP_Interrupt                      ;Emulation COP
dw !COP_Interrupt                      ;Emulation BRK (unused)
dw !COP_Interrupt                      ;Emulation ABORT
dw !COP_Interrupt                      ;Emulation NMI 
dw RESET                               ;Emulation RESET
dw !COP_Interrupt                      ;Emulation IRQ/BRK 