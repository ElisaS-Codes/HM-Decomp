ORG $808000

;;;;;;;; Spawns you after you start a game, from load or new game
SpawnAfterLoad:  ;808000
        %Set16bit(!MX)
        %Set8bit(!M)
        LDA.B #$15                           ;House lvl 1
        STA.B !tilemap_to_load
        JSL.L UNK_Audio5
        JSL.L UNK_Audio25
        %Set8bit(!M)
        LDA.B #15
        STA.B !param1
        LDA.B #03
        STA.B !param2
        LDA.B #01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        JSL.L FirstNightReset
        JSL.L UNK_Audio5
        %Set16bit(!M)
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        %Set16bit(!MX)
        LDA.W #$0088                         ;Position of the chair you wake up in
        STA.W !transition_dest_X
        LDA.W #$0078
        STA.W !transition_dest_Y
        %Set8bit(!M)
        LDA.B !map_house_1
        STA.W !transition_dest
        JSL.L FindMostLovedName
        JSL.L UNK_ScreenTransition
        %Set16bit(!M)
        LDA.L $7F1F68
        AND.W #$0001                        ;FLAG68
        BEQ GameLoop
        %Set8bit(!M)
        LDA.B #$03
        JSL.L RNGReturn0toA
        %Set8bit(!M)
        STA.W $0924
        %Set16bit(!MX)
        LDA.B !game_state
        ORA.W #$0004
        STA.B !game_state

;;;;;;;; I think this is the Big Main Loop from the topdown part at least
GameLoop: ;808083
        %Set8bit(!M)
        LDA.B !NMI_Status                    ;Wait for next NMI
        BEQ GameLoop

        %Set16bit(!M)
        LDA.W #$1800
        STA.B $C7
        LDA.W $0196
        AND.W #$2000                         ;FLAG196
        BEQ .enterloop
        JMP.W .skip2

    .enterloop:
        JSL.L SetScreenTransition
        JSL.L SUB_809A64
        JSL.L UpdateTime
        JSL.L ADDDDFFFF
        JSL.L TransitionTimeofDayPalettes
        JSL.L UNK_BigLoop
        JSL.L InputTypeSelector
        JSL.L BAAAA
        JSL.L SUB_81BFB7
        JSL.L AutoMapScrolling
        JSL.L CODE_84816F
        JSL.L CODE_81A600
        JSL.L CODE_8582C7
        JSL.L CODE_858CB2
        JSL.L UNK_BigLoadLoopOAM
        %Set8bit(!M)
        STZ.B !NMI_Status
        JMP.W GameLoop


    .skip2:
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$DFFF
        STA.W $0196
        JML.L Unk_NamesInput

;;;;;;;; Moves the player name from the temp location to the final location
SetPlayerName: ;8080ED
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !temp_name_1
        STA.W !player_name_sort_1
        %Set16bit(!M)
        STA.W !player_name_long_1
        %Set8bit(!M)
        LDA.W !temp_name_2
        STA.W !player_name_sort_2
        %Set16bit(!M)
        STA.W !player_name_long_2
        %Set8bit(!M)
        LDA.W !temp_name_3
        STA.W !player_name_sort_3
        %Set16bit(!M)
        STA.W !player_name_long_3
        %Set8bit(!M)
        LDA.W !temp_name_4
        STA.W !player_name_sort_4
        %Set16bit(!M)
        STA.W !player_name_long_4
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; Moves the Cow name from the temp location to the final location, and creates her
SetCowNameBought: ;80815F
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set16bit(!M)
        LDA.W #$0000
        JSL.L AddNewCow
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$000C
        LDA.W !temp_name_1
        STA.B [$72],Y
        LDY.W #$000D
        LDA.W !temp_name_2
        STA.B [$72],Y
        LDY.W #$000E
        LDA.W !temp_name_3
        STA.B [$72],Y
        LDY.W #$000F
        LDA.W !temp_name_4
        STA.B [$72],Y
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.L $7F1F5A
        AND.W #$FFFD                         ;FLAG5A
        STA.L $7F1F5A
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; Moves the Cow name from the temp location to the final location, and creates her
SetCowNameBorn: ;8081D2
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set16bit(!M)
        LDA.W #$0001
        JSL.L AddNewCow
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$000C
        LDA.W !temp_name_1
        STA.B [$72],Y
        LDY.W #$000D
        LDA.W !temp_name_2
        STA.B [$72],Y
        LDY.W #$000E
        LDA.W !temp_name_3
        STA.B [$72],Y
        LDY.W #$000F
        LDA.W !temp_name_4
        STA.B [$72],Y
        %Set16bit(!M)
        LDA.L $7F1F64
        AND.W #$FFFB
        STA.L $7F1F64
        %Set16bit(!M)
        LDA.L $7F1F64
        AND.W #$FFF7
        STA.L $7F1F64
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; Moves the Dog name from the temp location to the final location
SetDogName: ;808254
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !temp_name_1
        STA.W !dog_name_short_1
        %Set16bit(!M)
        STA.W !dog_name_long_1
        %Set8bit(!M)
        LDA.W !temp_name_2
        STA.W !dog_name_short_2
        %Set16bit(!M)
        STA.W !dog_name_long_2
        %Set8bit(!M)
        LDA.W !temp_name_3
        STA.W !dog_name_short_3
        %Set16bit(!M)
        STA.W !dog_name_long_3
        %Set8bit(!M)
        LDA.W !temp_name_4
        STA.W !dog_name_short_4
        %Set16bit(!M)
        STA.W !dog_name_long_4
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; Moves the Horse name from the temp location to the final location
SetHorseName: ;8082C6
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !temp_name_1
        STA.W !horse_name_short_1
        %Set16bit(!M)
        STA.W !horse_name_long_1
        %Set8bit(!M)
        LDA.W !temp_name_2
        STA.W !horse_name_short_2
        %Set16bit(!M)
        STA.W !horse_name_long_2
        %Set8bit(!M)
        LDA.W !temp_name_3
        STA.W !horse_name_short_3
        %Set16bit(!M)
        STA.W !horse_name_long_3
        %Set8bit(!M)
        LDA.W !temp_name_4
        STA.W !horse_name_short_4
        %Set16bit(!M)
        STA.W !horse_name_long_4
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; Moves the Kid1 name from the temp location to the final location
SetKid1Name: ;808338
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !temp_name_1
        STA.L !kid1_name_sort_1
        %Set16bit(!M)
        STA.W !kid1_name_long_1
        %Set8bit(!M)
        LDA.W !temp_name_2
        STA.L !kid1_name_sort_2
        %Set16bit(!M)
        STA.W !kid1_name_long_2
        %Set8bit(!M)
        LDA.W !temp_name_3
        STA.L !kid1_name_sort_3
        %Set16bit(!M)
        STA.W !kid1_name_long_3
        %Set8bit(!M)
        LDA.W !temp_name_4
        STA.L !kid1_name_sort_4
        %Set16bit(!M)
        STA.W !kid1_name_long_4
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; Moves the Kid2 name from the temp location to the final location
SetKid2Name: ;8083AE
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank
        JSL.L ZeroesVRAM
        JSL.L ZeroesCGRAM
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !temp_name_1
        STA.L !kid2_name_sort_1
        %Set16bit(!M)
        STA.W !kid2_name_long_1
        %Set8bit(!M)
        LDA.W !temp_name_2
        STA.L !kid2_name_sort_2
        %Set16bit(!M)
        STA.W !kid2_name_long_2
        %Set8bit(!M)
        LDA.W !temp_name_3
        STA.L !kid2_name_sort_3
        %Set16bit(!M)
        STA.W !kid2_name_long_3
        %Set8bit(!M)
        LDA.W !temp_name_4
        STA.L !kid2_name_sort_4
        %Set16bit(!M)
        STA.W !kid2_name_long_4
        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$4000                         ;FLAG196
        STA.W $0196
        LDA.W #$0100
        STA.W !BG3_Map_Offset_Y
        %Set8bit(!M)
        LDA.B #$01
        STA.W !inputstate
        JMP.W GameLoop

;;;;;;;; These values are used during the VRAM and OBJRAM Initializers.
Value_0000: dw $0000 ;808424
Value_00F0: dw $00F0 ;808426
;;;;;;;; Reset IRQ location, beguining of the program, basically
;;;;;;;; Sets all hardware registers and blanks some WRAM locations
RESET:   ;808428
        SEI                                  ;Disable IRQ Interrupt
        CLC
        XCE                                  ;Disable Emulation Mode
        %Set16bit(!MX)
        LDX.W #$1F00
        TXS                                  ;Initialize Stack to $1F00
        LDA.W #$0000
        TCD                                  ;Set Page Register to $00

        ;Setting every hardware register to 0 with a few exceptions
        %Set8bit(!MX)
        STZ.W !NMITIMEN
        STZ.W !MDMAEN
        STZ.W !HDMAEN
        LDA.B #$FF
        STA.W !WRIO                          ;not sure why it sets FF here
        STZ.W !WRMPYA
        STZ.W !WRMPYB
        STZ.W !WRDIVL
        STZ.W !WRDIVH
        STZ.W !WRDIVB
        STZ.W !HTIMEL
        STZ.W !HTIMEH
        STZ.W !VTIMEL
        STZ.W !VTIMEH
        STZ.W !MDMAEN
        STZ.W !HDMAEN
        LDA.B #$01                           ;FastRom
        STA.W !MEMSEL
        STZ.W !RDNMI
        STZ.W !TIMEUP
        STZ.W !HVBJOY
        STZ.W !RDIO
        STZ.W !RDDIVL
        STZ.W !RDDIVH
        STZ.W !RDMPYL
        STZ.W !RDMPYH
        STZ.W !JOY1L
        STZ.W !JOY1H
        STZ.W !JOY2L
        STZ.W !JOY2H
        STZ.W !JOY3L
        STZ.W !JOY3H
        STZ.W !JOY4L
        STZ.W !JOY4H
        STZ.W !INIDISP
        STZ.W !OBSEL
        STZ.W !OAMADDL
        STZ.W !OAMADDH
        STZ.W !OAMDATA
        STZ.W !OAMDATA
        STZ.W !BGMODE
        STZ.W !MOSAIC
        STZ.W !BG1SC
        STZ.W !BG2SC
        STZ.W !BG3SC
        STZ.W !BG4SC
        STZ.W !BG12NBA
        STZ.W !BG34NBA
        STZ.W !BG1HOFS
        STZ.W !BG1HOFS
        STZ.W !BG1VOFS
        STZ.W !BG1VOFS
        STZ.W !BG2HOFS
        STZ.W !BG2HOFS
        STZ.W !BG2VOFS
        STZ.W !BG2VOFS
        STZ.W !BG3HOFS
        STZ.W !BG3HOFS
        STZ.W !BG3VOFS
        STZ.W !BG3VOFS
        STZ.W !BG4HOFS
        STZ.W !BG4HOFS
        STZ.W !BG4VOFS
        STZ.W !BG4VOFS
        LDA.B #$80
        STA.W !VMAIN                         ;Increment by 1 after writing 16 bits
        STZ.W !VMADDL
        STZ.W !VMADDH
        STZ.W !VMDATAL
        STZ.W !VMDATAH
        STZ.W !M7SEL                         ;Thank Gog we dont use Mode7, sounds hard
        STZ.W !M7A
        STZ.W !M7A
        STZ.W !M7B
        STZ.W !M7B
        STZ.W !M7C
        STZ.W !M7C
        STZ.W !M7D
        STZ.W !M7D
        STZ.W !M7X
        STZ.W !M7X
        STZ.W !M7Y
        STZ.W !M7Y
        STZ.W !CGADD
        STZ.W !CGDATA
        STZ.W !CGDATA
        STZ.W !W12SEL
        STZ.W !W34SEL
        STZ.W !WOBJSEL
        STZ.W !WH0
        STZ.W !WH1
        STZ.W !WH2
        STZ.W !WH3
        STZ.W !WBGLOG
        STZ.W !WOBJLOG
        STZ.W !TM
        STZ.W !TS
        STZ.W !TMW
        STZ.W !TSW
        LDA.B #$30
        STA.W !CGWSEL                        ;Prevent color math = Always
        STZ.W !CGADSUB
        LDA.B #$E0
        STA.W !COLDATA                       ;Substract half of backdrops
        STZ.W !SETINI
        STZ.W !MPYL
        STZ.W !MPYM
        STZ.W !MPYH
        STZ.W !SLHV
        STZ.W !OAMDATAREAD
        STZ.W !VMDATALREAD
        STZ.W !VMDATAHREAD
        STZ.W !CGDATAREAD
        STZ.W !CGDATAREAD
        STZ.W !OPHCT
        STZ.W !OPVCT
        STZ.W !STAT77
        STZ.W !STAT78
        STZ.W !WMDATA
        STZ.W !WMADDL
        STZ.W !WMADDM
        STZ.W !WMADDH

        ;Zeroes low WRAM
        %Set16bit(!MX)
        LDX.W #$0000
        LDA.W #$0000
      - STA.W $0000,X
        INX
        INX
        CPX.W #$2000
        BNE -

        ;Zeroes rest of bank $7E
        %Set16bit(!MX)
        LDX.W #$0000
        LDA.W #$0000
      - STA.L $7E2000,X
        INX
        INX
        CPX.W #$E000
        BNE -

        ;Zeroes bank $7F0000
        %Set16bit(!MX)
        LDX.W #$0000
        LDA.W #$0000
      - STA.L $7F0000,X
        INX
        INX
        CPX.W #$0000
        BNE -

        ;Zeroes Joypad memory location? that was zeroed already...
        STZ.W !Joy1_Current
        STZ.W !Joy1_New_Input
        STZ.W !Joy1_Last_Frame
        STZ.W !Joy1_New_Unpressed
        STZ.W !Joy2_Current
        STZ.W !Joy2_New_Input
        STZ.W !Joy2_Last_Frame
        STZ.W !Joy2_Unused2

        ;Sets audio processor
        %Set16bit(!MX)
        LDA.W #$8000
        STA.B $0A
        LDA.W #$00AD
        STA.B $0C
        JSL.L UNK_Audio1
        %Set8bit(!M)
        LDA.B #$00
        JSL.L UNK_Audio2
        JSL.L UNK_Audio3
        JSL.L UNK_Audio4

        ; Initializes all graphical memories and registers
        JSL.L InitialzieScreenStatusVar
        JSL.L ZeroesVRAM
        JSL.L ZeroesOAM
        JSL.L ZeroesCGRAM
        JSL.L ClearWRAMGraphicsSpace         ;TODO
        JSL.L InitializeOBJs
        JSL.L CheckSRAMIntegrity
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !INIDISP_FORCE_BLANK
        STA.W !INIDISP
        STZ.W $0148                          ;Is this never used?
        LDA.B !NMITIMEN_ENABLE_NMI_NO_JOY
        STA.W !NMITIMEN
        STZ.W !INIDISP
        CLI

        JML.L IntroScreen


;;;;;;;;; Waits for the next NMI
WaitForNMI: ;808645
        PHP
        %Set16bit(!M)
        PHA
        %Set8bit(!M)
        LDA.B !NMITIMEN_ENABLE_NMI_AND_JOY
        STA.L !NMITIMEN24                    ;Interrupt Enable Register 24bit Address
        CLI                                  ;Clear Interrupt Flag
        STZ.B !NMI_Status

      - LDA.B !NMI_Status                    ;Infinite loop till an NMI changes the value
        BEQ -
        %Set16bit(!M)
        PLA
        PLP
        RTL


;;;;;;;;; Waits for a number of NMIs
;;;;;;;;; Params: A = Number of "frames"
WaitForNMIATimes: ;80865D
        PHP
     -- %Set16bit(!M)
        PHA
        %Set8bit(!M)
        LDA.B !NMITIMEN_ENABLE_NMI_AND_JOY
        STA.L !NMITIMEN24                    ;Interrupt Enable Register 24bit Address
        CLI                                  ;Clear Interrupt Flag
        STZ.B !NMI_Status

      - LDA.B !NMI_Status                    ;Infinite loop till an NMI changes the value
        BEQ -
        %Set16bit(!M)
        PLA
        DEC A
        CMP.W #$0000
        BNE --                               ;Loops back till A is 0
        PLP
        RTL


;;;;;;;; Nothing much happens here, just calls the UpdateGraphics subrutine
NMI_Interrupt: ;80867B
        %Set16bit(!MX)
        PHA
        PHX
        PHY
        PHD
        PHB
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B !NMITIMEN_ENABLE_NMI_AND_JOY
        STA.L !NMITIMEN24
        CLI                                  ;Enable Interrupts
        JSR.W UpdateGraphics
        %Set16bit(!MX)
        PLB
        PLD
        PLY
        PLX
        PLA
        RTI


;;;;;;;; This feels gutted, doesnt do enything, just continues execution
COP_Interrupt: ;808699
        %Set16bit(!MX)
        PHB
        PHA
        PHX
        PHY
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !TIMEUP
        JSR.W COP_Return                     ;emtpy subrutine
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        PLB
        RTI

;;;;;;;; This is the main DMA subrutine
UpdateGraphics: ;8086B1
        PHP
        %Set8bit(!M)
        LDA.B !NMI_Status

        BNE .notwaitingforDMA
        JSL.L StartProgramedDMA
        %Set8bit(!M)
        LDA.B $9A                            ;DMA Channel 4 seems to be special?
        STA.W !MDMAEN
        STZ.B $9A
        STZ.W !MDMAEN
        JSL.L CopiesWRAMtoOBJVGRAM           ;TODO
        STZ.B $9A
        STZ.W !MDMAEN

    .notwaitingforDMA:
        JSR.W ReadJoypad
        JSL.L GetRNG

    ;Update Offsets
        %Set8bit(!M)
        LDA.W !BG1_Map_Offset_X
        STA.W !BG1HOFS
        LDA.W !BG1_Map_Offset_XH
        STA.W !BG1HOFS
        LDA.W !BG1_Map_Offset_Y
        STA.W !BG1VOFS
        LDA.W !BG1_Map_Offset_YH
        STA.W !BG1VOFS
        LDA.W !BG2_Map_Offset_X
        STA.W !BG2HOFS
        LDA.W !BG2_Map_Offset_XH
        STA.W !BG2HOFS
        LDA.W !BG2_Map_Offset_Y
        STA.W !BG2VOFS
        LDA.W !BG2_Map_Offset_YH
        STA.W !BG2VOFS
        LDA.W !BG3_Map_Offset_X
        STA.W !BG3HOFS
        LDA.W !BG3_Map_Offset_XH
        STA.W !BG3HOFS
        LDA.W !BG3_Map_Offset_Y
        STA.W !BG3VOFS
        LDA.W !BG3_Map_Offset_YH
        STA.W !BG3VOFS
        %Set8bit(!M)
        LDA.B #$01
        STA.B !NMI_Status                    ;Update done
        PLP
        RTS


;;;;;;;;; Seems to be an gutted BSOD or debugging menu
COP_Return: ;80872A
        RTS

;;;;;;;; Read joypad, not too much to say, except that its obviously taken
;;;;;;;; from another project/framwork/code example, as it has a ton of unused vars
;;;;;;;; This thing could be 1/3rd its size and operational cost
ReadJoypad: ;80872B;
        PHP

    .waitforready
        %Set8bit(!M)
        LDA.W !HVBJOY
        BIT.B !HVBJOY_Joy_Ready
        BNE .waitforready

    ;Move old imput to last frame's memory location
        %Set16bit(!MX)
        LDA.W !Joy1_Current
        STA.W !Joy1_Last_Frame
        LDA.W !Joy2_Current
        STA.W !Joy2_Last_Frame
        %Set8bit(!M)

        LDA.B $00
        BEQ +

    ;Never run, would read only 8 bit and then use those values as a mask later?
        LDA.W !JOY1L
        STA.W !Joy1_Unused
        LDA.W !JOY2L
        STA.W !Joy2_Current
        BRA ++

    ;read Joypads
      + %Set16bit(!M)
        LDA.W !JOY1L
        ORA.W !Joy1_Unused                   ;always 0, so no changes
        STA.W !Joy1_Current
        LDA.W !JOY2L
        ORA.W !Joy2_Unused                   ;always 0, so no changes
        STA.W !Joy2_Current
        STZ.W !Joy1_Unused
        STZ.W !Joy2_Unused

    ;Get useful variables, some unused variables, and the whole Joy2 is not used
     ++ %Set16bit(!M)
        LDA.W !JOY1L
        EOR.W !Joy1_Last_Frame
        AND.W !Joy1_Current
        STA.W !Joy1_New_Input
        STA.W !Joy1_Autorepeat
        LDA.W !JOY1L
        EOR.W !Joy1_Last_Frame
        AND.W !Joy1_Last_Frame
        STA.W !Joy1_New_Unpressed
        LDA.W !JOY2L
        EOR.W !Joy2_Last_Frame
        AND.W !Joy2_Current
        STA.W !Joy2_New_Input
        STA.W !Joy2_Autorepeat
        LDA.W !JOY1L
        EOR.W !Joy2_Last_Frame
        AND.W !Joy2_Last_Frame
        STA.W !Joy2_Unused2

    ;Key timer code, Keeps how long keys have been pressed, amd updates Autorepeat
        LDA.W !Joy1_Current
        BEQ +                                ;No key pressed
        INC.B !Joy1_Key_Pressed_Timer
        BRA ++                               ;skip reset
      + STZ.B !Joy1_Key_Pressed_Timer
     ++ %Set8bit(!M)

        LDA.B !Joy1_Key_Pressed_Timer
        CMP.B #30                            ;Timer goes till 30
        BEQ +                                ;No need to reset
        BRA ++                               ;Go to end

      + %Set16bit(!M)
        LDA.W !Joy1_Current
        STA.W !Joy1_Autorepeat               ;Updates Autorepeat
        %Set8bit(!M)
        LDA.B #25                            ;resets back to 25
        STA.B !Joy1_Key_Pressed_Timer

     ++ PLP
        RTS

;;;;;;;;; Makes the ScreenFadein effect
;;;;;;;;; Params: $92:Start Brightness $93:Frames per step $94:Target brightness
ScreenFadein: ;8087CE
        !start_brightness = $92
        !frames_per_step = $93
        !target_brightness = $94

        %Set8bit(!MX)
        LDA.B !start_brightness              ;This is probably a special case, I dont think its used
        CMP.B #$FF
        BEQ +

        LDA.B !start_brightness
        STA.B !fade_current_brightness

      + LDA.B !frames_per_step
        STA.B !fade_current_frame

    ;Loops till target Brightness is achived
     -- LDA.B !fade_current_brightness
        JSL.L SetsBrightness
        LDA.B !fade_current_brightness
        CMP.B !target_brightness
        BEQ +                                ;Target Bright Achieved

        INC.B !fade_current_brightness

    ;Loop till enough frames have passed
      - JSL.L WaitForNMI
        DEC.B !fade_current_frame
        LDA.B !fade_current_frame
        BNE -

        LDA.B !frames_per_step
        STA.B !fade_current_frame
        BRA --

      + %Set16bit(!M)
        LDA.L $7F1F5A
        ORA.W #$8000                         ;FLAG5A
        STA.L $7F1F5A
        RTL

;;;;;;;;; Makes the fadeout effect
;;;;;;;;; Params: $92:Start Brightness $93:Frames per step $94:Target brightness
ScreenFadeout: ;80880A
        !start_brightness = $92
        !frames_per_step = $93
        !target_brightness = $94

        %Set8bit(!MX)
        LDA.B !start_brightness
        CMP.B #$FF                           ;This is probably a special case, I dont think its used
        BEQ +

        LDA.B !start_brightness
        STA.B !fade_current_brightness

      + LDA.B !frames_per_step
        STA.B !fade_current_frame

    ;Loops till target Brightness is achived
     -- LDA.B !fade_current_brightness
        JSL.L SetsBrightness
        LDA.B !fade_current_brightness
        CMP.B !target_brightness
        BEQ +                                ;Target Bright Achieved

        DEC.B !fade_current_brightness

    ;Loop till enough frames have passed
      - JSL.L WaitForNMI
        DEC.B !fade_current_frame
        LDA.B !fade_current_frame
        BNE -

        LDA.B !frames_per_step
        STA.B !fade_current_frame
        BRA --

      + %Set16bit(!M)
        LDA.L $7F1F5A
        AND.W #$7FFF                         ;FLAG5A
        STA.L $7F1F5A
        RTL

;;;;;;;; Initializes the VRAM with 0s
ZeroesVRAM: ;808846
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !INIDISP_FORCE_BLANK
        STA.W !INIDISP
        STZ.W !NMITIMEN                      ;Disable Interrupts
        LDA.B !VMAIN_16BIT_MODE              ;Sets up the DMA to VRAM
        STA.W !VMAIN
        %Set16bit(!M)
        STZ.W !VMADDL
        %Set8bit(!M)
        LDA.B !DMAPX_16BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B !BBADX_DMA_VRAMPORT
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8424                         ;src -> $808424 = #$0000
        STA.W !A1T0L
        %Set8bit(!M)
        LDA.B #$80
        STA.W !A1B0
        %Set16bit(!M)
        LDA.W #$0000                         ;Size: A full page
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN
        RTL

;;;;;;;;Clears the OAM VRAM with 0s
ZeroesOAM: ;808887
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !INIDISP_FORCE_BLANK
        STA.W !INIDISP
        STZ.W !NMITIMEN                      ;Disable Interrupts
        %Set16bit(!M)
        STZ.W !OAMADDL                       ;Sets up start of OAM
        %Set8bit(!M)
        LDA.B !DMAPX_16BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B !BBADX_DMA_OAMPORT
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8424                         ;src -> $808424 = #$0000
        STA.W !A1T0L
        %Set8bit(!M)
        LDA.B #$80
        STA.W !A1B0
        %Set16bit(!M)
        LDA.W #$043F                         ;size -> $043F = 1087 bytes, literally twice the OAM
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN
        RTL

;;;;;;;; UNUSED, should prepare OAM, but never triggers
UNUSED1: ;8088C3
        %Set16bit(!MX)
        STZ.W !OAMADDL
        %Set8bit(!M)
        LDA.B !DMAPX_8BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B !BBADX_DMA_OAMPORT
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8426                         ;src -> $808426, $00F0
        STA.W !A1T0L
        %Set8bit(!M)
        LDA.B #$80
        STA.W !A1B0
        %Set16bit(!M)
        LDA.W #$0200
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN
        %Set16bit(!MX)
        LDA.W #$0100
        STA.W !OAMADDL
        %Set8bit(!M)
        LDA.B !DMAPX_8BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B #$04
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8424
        STA.W !A1T0L
        %Set8bit(!M)
        LDA.B #$80
        STA.W !A1B0
        %Set16bit(!M)
        LDA.W #$0020
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.B #$01
        STA.W !MDMAEN
        %Set16bit(!M)
        STZ.W !OAMADDL
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        STX.W !OAMADDL
        STZ.W $4340
        LDA.B #$04
        STA.W $4341
        LDA.B #$00
        STA.W $4342
        LDA.B #$A0
        STA.W $4343
        LDA.B #$7E
        STA.W $4344
        LDX.B $AF
        STX.W $4345
        LDA.B #$10
        STA.W !MDMAEN
        LDX.W #$0100
        STX.W !OAMADDL
        STZ.W $4340
        LDA.B #$04
        STA.W $4341
        LDA.B #$00
        STA.W $4342
        LDA.B #$A0
        CLC
        ADC.B #$02
        STA.W $4343
        LDA.B #$7E
        STA.W $4344
        LDX.W #$0020
        STX.W $4345
        LDA.B #$10
        STA.W !MDMAEN
        RTL

;;;;;;;;Clears the CGRAM VRAM with 0s
ZeroesCGRAM: ;808980
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !NMITIMEN_ENABLE_NMI_NO_JOY
        STA.W !INIDISP
        STZ.W !NMITIMEN                      ;Disable Interrupts
        %Set16bit(!M)
        STZ.W !CGADD                         ;Sets start of CGRAM
        %Set8bit(!M)
        LDA.B !DMAPX_16BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B !BBADX_DMA_CGRAMPORT
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8424                         ;src -> $808424, $0000
        STA.W !A1T0L
        %Set8bit(!M)
        LDA.B #$80
        STA.W !A1B0
        %Set16bit(!M)
        LDA.W #$03FF                         ;size -> $03FF = 1023 bytes
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN
        RTL

;;;;;;;; Clears a chunk of 1000 of the VRAM. Param: A, the starting location
ZeroesPartialVRAM: ;8089BC
        %Set16bit(!MX)
        STA.W !VMADDL
        %Set8bit(!M)
        LDA.B !INIDISP_FORCE_BLANK
        STA.W !INIDISP
        STZ.W !NMITIMEN
        LDA.B !VMAIN_16BIT_MODE
        STA.W !VMAIN
        LDA.B !DMAPX_16BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B !BBADX_DMA_VRAMPORT
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8424                         ;src -> $808424 = #$0000
        STA.W !A1T0L
        %Set8bit(!M)
        LDA.B #$80
        STA.W !A1B0
        %Set16bit(!M)
        LDA.W #$0FFF                         ;size -> $0FFF = 4k
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN
        RTL

;;;;;;;; Returns a number between 0 and a number given in A, max 255, Return in A
;;;;;;;; Its a simple, divides between given number and 255, gets an RNG, and then starts
;;;;;;;; checking if its rng is smaller than X, then X*2, the etc till it finds a match
RNGReturn0toA: ;8089F9
        %Set8bit(!MX)
        STA.B !scratch92
        PHA
        STZ.B !scratch93
        %Set16bit(!M)
        LDA.W #$00FF
        STA.B !scratch7E
        LDA.B !scratch92
        STA.B !scratch80
        JSL.L DivisionUnsigned
        %Set8bit(!M)
        STA.B !scratch93
        JSL.L GetRNG
        %Set8bit(!MX)
        STA.B !scratch94
        PLA
        DEC A
        STA.B !scratch92
        LDX.B #$00
        LDA.B !scratch93

      - CMP.B !scratch94
        BCS +
        INX
        CPX.B !scratch92
        BEQ +
        CLC
        ADC.B !scratch93
        BRA -

      + TXA
        RTL

;;;;;;;; Prepares a DMA channel to later copy during NMI, more info on ram.asm
;;;;;;;; Params A:Control Registers, X:VRAM/CGRAM Dest Addresses, Y(DMA Size), $72 & $74 24b src
AddProgrammedDMA: ;808A33
        !src_address = $72
        !src_bank = $74

        %Set16bit(!MX)
        PHA
        TXA
        PHA
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B !ProgDMA_Channel_Index
        ASL A
        TAX
        %Set16bit(!M)
        PLA
        STA.B !ProgDMA_Destination_Addr_Table,X
        TXA
        LSR A
        TAX
        PLA
        %Set8bit(!M)
        STA.B !ProgDMA_Control_Register_Table,X
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B !ProgDMA_Channel_Index
        ASL A
        ASL A
        ASL A
        ASL A
        %Set16bit(!M)
        TAX
        %Set8bit(!M)
        LDA.B !ProgDMA_Destination_Memory
        CMP.B !BBADX_DMA_VRAMPORT
        BNE .CGRAM
        LDA.B !DMAPX_16BIT
        STA.W !DMAP0,X
        BRA ++

    .CGRAM
        STZ.W !DMAP0,X                       ;1 register write once

     ++ LDA.B !ProgDMA_Destination_Memory
        STA.W !BBAD0,X
        %Set16bit(!M)
        LDA.B !src_address
        STA.W !A1T0L,X
        %Set8bit(!M)
        LDA.B !src_bank
        STA.W !A1B0,X
        %Set16bit(!M)
        TYA
        STA.W !DAS0L,X
        LDA.B $C7                            ;TODO
        SEC
        SBC.W !DAS0L,X
        STA.B $C7
        TXA
        LSR A
        LSR A
        LSR A
        LSR A
        TAX
        %Set8bit(!M)
        LDA.B !ProgDMA_Channel_Flag_to_Copy
        ORA.L DMA_Channels_Flag_Table,X
        STA.B !ProgDMA_Channel_Flag_to_Copy

        RTL

;;;;;;;; Removes a DMA channel
RemoveProgrammedDMA: ;808AA0
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !ProgDMA_Channel_Index
        TAX
        LDA.L DMA_Channels_Flag_Table,X
        EOR.B #$FF
        AND.B !ProgDMA_Channel_Flag_to_Copy
        STA.B !ProgDMA_Channel_Flag_to_Copy
        RTL

;;;;;;;; Only copies the last Programmed DMA, and kinda ditches the rest by zeroing ProgDMA_Channel_Flag_to_Copy
;;;;;;;; But doesnt reset the channel index, so the Programmed DMA states is in a dirty state?
;;;;;;;; I guess its only used during vblank and when you only are copying one thing at a time
;;;;;;;; still, a STZ !ProgDMA_Channel_Index at the end would make this so much pretty
StartLastPreparedDMA: ;808AB2
        %Set8bit(!MX)
        LDA.B !ProgDMA_Channel_Index
        PHA
        ASL A
        ASL A
        ASL A
        ASL A
        TAX
        LDA.W !BBAD0,X
        CMP.B !BBADX_DMA_VRAMPORT
        BNE .CGRAM
        PLX
        LDA.B !ProgDMA_Control_Register_Table,X
        STA.W !VMAIN
        %Set16bit(!M)
        TXA
        ASL A
        TAX
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !VMADDL
        BRA .write

    .CGRAM:
        PLX
        TXA
        ASL A
        TAX
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !CGADD

    .write:
        %Set8bit(!M)
        TXA
        LSR A
        TAX
        LDA.L DMA_Channels_Flag_Table,X
        STA.W !MDMAEN
        STZ.B !ProgDMA_Channel_Flag_to_Copy
        STZ.W !MDMAEN
        RTL

;;;;;;;; Start the prepared DMA changes
StartProgramedDMA: ;808AF0
        %Set8bit(!MX)
        LDX.B #$00

    .nextPort:
        LDA.L DMA_Channels_Flag_Table,X
        AND.B !ProgDMA_Channel_Flag_to_Copy
        BEQ .skipChannel
        PHX                                  ;saves current Channel
        TXA
        ASL A
        ASL A
        ASL A
        ASL A
        TAX                                  ;Mult X by 8, as thats the separation between channels
        LDA.W !BBAD0,X                       ;Reads current destination of the DMA
        CMP.B !BBADX_DMA_VRAMPORT
        BNE .copyCGRAM                       ;checks what memory has to update

    ;copyVRAM
        PLX                                  ;Retrieves current Channel
        LDA.B !ProgDMA_Control_Register_Table,X
        STA.W !VMAIN
        %Set16bit(!M)
        TXA
        ASL A
        TAX                                  ;Doubles X as next value is 16bit
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !VMADDL
        BRA .write

    .copyCGRAM:
        PLX                                  ;Retrieves current Channel
        TXA
        ASL A
        TAX                                  ;Doubles X as next value is 16bit
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !CGADD

    .write:
        %Set8bit(!M)
        TXA
        LSR A
        TAX                                  ;Halves X, to restore last doubling
        LDA.L DMA_Channels_Flag_Table,X
        STA.W !MDMAEN                        ;Copies that Channel

    .skipChannel:
        INX
        CPX.B #$08                           ;if last channel just happened
        BNE .nextPort
        STZ.B !ProgDMA_Channel_Flag_to_Copy
        STZ.W !MDMAEN
        RTL

;;;;;;;; Each channels flag
DMA_Channels_Flag_Table: db $01,$02,$04,$08,$10,$20,$40,$80 ;808B3C
;The game can be in 11 different "Graphic presets", those set most PPU function Registers
;Unknown if all are used, some are repeated.
;The current graphic mode is stored in $8019B6 (remap of $7E19B6)
Table_OBSEL_Presets:      db $60,$60,$60,$60,$60,$60,$03,$03,$03,$03,$63;808B44;Table Object Size and Character Size Register
Table_BGMODE_Presets:     db $09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09;808B4F;Table BG Mode and Character Size Register
Table_BG1SC_Presets:      db $63,$63,$63,$63,$13,$13,$51,$51,$51,$51,$51;808B5A;Table BG Tilemap Address Registers (BG1)
Table_BG2SC_Presets:      db $72,$72,$72,$73,$63,$63,$59,$59,$59,$59,$59;808B65;Table BG Tilemap Address Registers (BG2)
Table_BG3SC_Presets:      db $7A,$7A,$7A,$7A,$7A,$7A,$09,$09,$0A,$0A,$09;808B70;Table BG Tilemap Address Registers (BG3)
Table_BG4SC_Presets:      db $7C,$7C,$7C,$7C,$7C,$7C,$70,$70,$70,$70,$70;808B7B;Table BG Tilemap Address Registers (BG4)
Table_BG12NBA_Presets:    db $22,$22,$22,$22,$22,$22,$11,$11,$11,$11,$11;808B86;Table BG Character Address Registers (BG1&2)
Table_BG34NBA_Presets:    db $55,$55,$55,$55,$55,$22,$00,$00,$00,$00,$00;808B91;Table BG Character Address Registers (BG3&4)
Table_TM_Presets:         db $15,$17,$17,$17,$17,$17,$13,$13,$13,$13,$15;808B9C;Table Main Screen Designation
Table_TS_Presets:         db $02,$00,$00,$00,$00,$00,$04,$04,$04,$04,$00;808BA7;Table Subscreen Designation
Table_TMW_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BB2;Table Window Mask Designation for the Main Screen
Table_TSW_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BBD;Table Window Mask Designation for the Sub Screen
Table_CGWSEL_Presets:     db $02,$02,$02,$02,$02,$02,$00,$02,$02,$02,$00;808BC8;Table Color Math Registers1
Table_CGADSUB_Presets:    db $73,$73,$73,$73,$73,$73,$00,$53,$13,$53,$00;808BD3;Table Color Math Registers2
Table_SETINI_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BDE;Table Screen Mode Select Register
Table_W12SEL_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BE9;Table Window Mask Settings (BG1&BG2)
Table_W34SEL_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BF4;Table Window Mask Settings (BG1&BG2)
Table_WOBJSEL_Presets:    db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BFF;Table Window Mask Settings (OBJ)
Table_WH0_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C0A;Table Window Position Registers (WH0)
Table_WH1_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C15;Table Window Position Registers (WH1)
Table_WH2_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C20;Table Window Position Registers (WH2)
Table_WH3_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C2B;Table Window Position Registers (WH3)
Table_WBGLOG_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C36;Table Window Mask Logic registers (BG)
Table_WOBJLOG_Presets:    db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C41;Table Window Mask Logic registers (OBJ)

;;;;;;;; like... why? this is longer than the calling stz $24 and then JSR Force blank...
InitialzieScreenStatusVar:      ;808C4C
        PHP
        %Set16bit(!X)
        %Set8bit(!M)
        STZ.B !copyof_INIDISP
        %Set16bit(!M)
        PLP
        JMP.W ForceBlank

;;;;;;;; The game has a 11 of preprogramed graphic modes, they dictate the PPU status. This
;;;;;;;; function sets the PPU Register dictated by the value of A and a bunch of tables above
;;;;;;;; This OBVIOUSLY something they copypasted from either an early SNES coding documentation
;;;;;;;; or some old projects where they didnt even underestand the architecture. It access
;;;;;;;; evertythig the SLOWEST way posible, and sets a CRAB TON of memory values THAT ARE NEVER
;;;;;;;; READ ANYWHERE ELSE, NOT EVEN IN THIS FUNCTION. This needs a full rewrite. Or fire.
;;;;;;;; Params: A=New Graphic Mode
ManageGraphicPresets: ;808C59
        PHP
        %Set8bit(!MX)
        STA.L !graphic_preset
        TAX
        LDA.L Table_OBSEL_Presets,X
        STA.L !OBSEL_preset
        STA.L !OBSEL24
        XBA
        %Set16bit(!M)
        AND.W #$0700
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        STA.L !graphic_preset_unknown
        %Set8bit(!M)
        LDA.L Table_BGMODE_Presets,X
        STA.L !BGMODE_preset
        STA.L !BGMODE24

        STZ.W !graphic_preset_unused01
        STZ.W !graphic_preset_unused02
        STZ.W !graphic_preset_unused03
        STZ.W !graphic_preset_unused04

        LDA.L Table_BG1SC_Presets,X
        STA.L !BG1SC_preset
        STA.L !BG1SC24
        AND.B #$FC                           ;removes flip flags
        STA.L !BG1SC_noflip_preset
        LDA.L Table_BG2SC_Presets,X
        STA.L !BG2SC_preset
        STA.L !BG2SC24
        AND.B #$FC                           ;removes flip flags
        STA.L !BG2SC_noflip_preset
        LDA.L Table_BG3SC_Presets,X
        STA.L !BG3SC_preset
        STA.L !BG3SC24
        AND.B #$FC                           ;removes flip flags
        STA.L !BG3SC_noflip_preset
        LDA.L Table_BG4SC_Presets,X
        STA.L !BG4SC_preset
        STA.L !BG4SC24
        AND.B #$FC                           ;removes flip flags
        STA.L !BG4SC_noflip_preset
        LDA.L Table_BG12NBA_Presets,X
        STA.L !BG12NBA_preset
        STA.L !BG12NBA24
        LDA.L Table_BG34NBA_Presets,X
        STA.L !BG34NBA_preset
        STA.L !BG34NBA24

        %Set16bit(!M)
        LDA.W #$0000
        STA.L !graphic_preset_unused05
        STA.L !graphic_preset_unused06
        STA.L !graphic_preset_unused07
        STA.L !graphic_preset_unused08
        STA.L !graphic_preset_unused09
        STA.L !graphic_preset_unused10
        STA.L !graphic_preset_unused11
        STA.L !graphic_preset_unused12
        %Set8bit(!M)
        BIT.B !copyof_INIDISP
        BPL .skip                            ;Always false?

        PHX
        LDX.B #$00

      - STA.L !BG1HOFS24,X                   ;Sets all BG Scroll register to 0
        STA.L !BG1HOFS24,X
        STA.L !BG1VOFS24,X
        STA.L !BG1VOFS24,X
        INX
        INX
        CPX.B #$08
        BNE -
        PLX

    .skip:
        STA.L !M7SEL_preset
        STA.L !M7SEL24
        LDA.L Table_W12SEL_Presets,X
        STA.L !W12SEL_preset
        STA.L !W12SEL24
        LDA.L Table_W34SEL_Presets,X
        STA.L !W34SEL_preset
        STA.L !W34SEL24
        LDA.L Table_WOBJSEL_Presets,X
        STA.L !WOBJSEL_preset
        STA.L !WOBJSEL24
        LDA.L Table_WBGLOG_Presets,X
        STA.L !WBGLOG_preset
        STA.L !WBGLOG24
        LDA.L Table_WOBJLOG_Presets,X
        STA.L !WOBJLOG_preset
        STA.L !WOBJLOG24
        LDA.L Table_WH0_Presets,X
        STA.L !WH0_preset
        STA.L !WH024
        LDA.L Table_WH1_Presets,X
        STA.L !WH1_preset
        STA.L !WH124
        LDA.L Table_WH2_Presets,X
        STA.L !WH2_preset
        STA.L !WH224
        LDA.L Table_WH3_Presets,X
        STA.L !WH3_preset
        STA.L !WH324
        LDA.L Table_TM_Presets,X
        STA.L !TM_preset
        STA.L !TM24
        LDA.L Table_TS_Presets,X
        STA.L !TS_preset
        STA.L !TS24
        LDA.L Table_TMW_Presets,X
        STA.L !TMW_preset
        STA.L !TMW24
        LDA.L Table_TSW_Presets,X
        STA.L !TSW_preset
        STA.L !TSW24
        LDA.L Table_CGWSEL_Presets,X
        STA.L !CGWSEL_preset
        STA.L !CGWSEL24
        LDA.L Table_CGADSUB_Presets,X
        STA.L !CGADSUB_preset
        STA.L !CGADSUB24
        LDA.B #$E0
        STA.L !COLDATA_preset
        STA.L !COLDATA24
        LDA.L Table_SETINI_Presets,X
        STA.L !SETINI_preset
        STA.L !SETINI24
        PLP
        RTL

;;;;;;;; sets the Forces Blank flag
ForceBlank: ;808E0F
        PHP
        %Set8bit(!M)
        LDA.B !copyof_INIDISP
        ORA.B #$80                           ;modify only the blank bit
        STA.B !copyof_INIDISP
        STA.L !INIDISP24                     ;24bit direction of INIDISP
        PLP
        RTL

;;;;;;;; resets the Forces Blank flag
ResetForceBlank: ;808E1E
        PHP
        %Set8bit(!M)
        LDA.B !copyof_INIDISP
        AND.B #$0F                           ;conserves Brightness
        STA.B !copyof_INIDISP
        STA.L !INIDISP24
        PLP
        RTL

;;;;;;;; Param Desired Brightness in A. It forces blank if bright = 0
SetsBrightness: ;808E2D
        PHP
        %Set8bit(!M)
        AND.B #$0F                           ;keeps what would be only brightness
        BNE +                                ;if 0, just force blank
        LDA.B !INIDISP_FORCE_BLANK

      + STA.L $80007E                        ;A scratch memory, but accesed as 24bit???
        LDA.B !copyof_INIDISP
        AND.B #$80                           ;keeps current force blank
        ORA.B $7E                            ;same scratch memory, retrives bright from there
        STA.B !copyof_INIDISP
        STA.L !INIDISP24
        PLP
        RTL

;;;;;;;; Sets a number of values and a pointer, indexed by X
;;;;;;;; Params in A, Y, X, 72: pointer to UNK_Pointer42_Table
UNK_SetPointer42: ;808E48
        %Set8bit(!MX)
        STA.W $015A,X
        TYA
        STA.W $016A,X
        STZ.W $014A,X
        %Set16bit(!M)
        TXA
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        LDA.B $72
        STA.B $42,X
        %Set8bit(!M)
        LDA.B $74
        STA.B $44,X

        RTL

;;;;;;;;
UNK_BigLoop: ;808E69
        %Set16bit(!MX)
        %Set8bit(!M)
        STZ.B $92
        STZ.B $93
        LDY.W #$0000
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$000A                         ;FLAG196 snowy or raining
        BNE .snowyorrainy
        LDY.W #$0004

    .snowyorrainy:
        %Set16bit(!M)
        TYA
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E                            ;mult by 3, either 0 or 4
        TAX
        LDA.B $42,X
        BNE .pointerset
        %Set8bit(!M)
        LDA.B $44,X
        BNE .pointerset
        CPY.W #$0004
        BCC .smallloop
        JMP.W .CODE_808F2C

    .pointerset:
        %Set8bit(!M)
        LDA.B #$01
        STA.B $93
        %Set16bit(!M)
        PHY
        LDA.B $42,X
        STA.B $72
        %Set8bit(!M)
        LDA.B $44,X
        STA.B $74
        %Set16bit(!M)
        LDA.B [$72]
        CMP.W #$FFFF
        BNE .CODE_808EBC
        JMP.W .CODE_808F57

    .CODE_808EBC:
        CMP.W #$FFFE
        BNE .bigloop
        JMP.W .CODE_808F62

    .bigloop:
        PLY
        TYX
        %Set8bit(!M)
        LDA.W $014A,X
        BEQ .CODE_808ED0
        JMP.W .CODE_808F52

    .CODE_808ED0:
        PHY
        TYX
        LDA.B #$00
        XBA
        LDA.W $016A,X
        %Set16bit(!M)
        PHA
        TYX
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $015A,X
        %Set16bit(!M)
        PHA
        LDA.B [$72]
        PLX
        PLY
        JSL.L SUB_80916F
        %Set16bit(!MX)
        PLY
        PHY
        TYX
        LDY.W #$0002
        %Set8bit(!M)
        LDA.B [$72],Y
        STA.W $014A,X
        %Set16bit(!M)
        PLY
        TYA
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        LDA.B $42,X
        CLC
        ADC.W #$0003
        STA.B $42,X
        %Set8bit(!M)
        LDA.B $44,X
        ADC.B #$00
        STA.B $44,X

    .smallloop:
        %Set16bit(!M)
        TYA
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        INY
        CPY.W #$0010
        BEQ .CODE_808F2C
        JMP.W $8E81

    .CODE_808F2C:
        %Set8bit(!M)
        LDA.B $93
        BEQ .return
        LDA.B #$05
        STA.B !ProgDMA_Channel_Index
        LDA.B #$22
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!M)
        LDY.W #$0100
        LDX.W #$0000
        LDA.W #$0900
        STA.B $72
        %Set8bit(!M)
        LDA.B #$7F
        STA.B $74
        JSL.L AddProgrammedDMA

    .return: RTL

    .CODE_808F52:
        DEC.W $014A,X
        BRA .smallloop

    .CODE_808F57:
        %Set16bit(!M)
        STZ.B $42,X
        %Set8bit(!M)
        STZ.B $44,X
        JMP.W .bigloop

    .CODE_808F62:
        %Set16bit(!M)
        LDY.W #$0002
        LDA.B [$72],Y
        STA.B $42,X
        INY
        INY
        %Set8bit(!M)
        LDA.B [$72],Y
        STA.B $44,X
        %Set16bit(!M)
        LDA.B $42,X
        STA.B $72
        %Set8bit(!M)
        LDA.B $44,X
        STA.B $74
        JMP.W .bigloop

;;;;;;;; Param A
ZeroesOne42Pointer: ;808F82
        %Set16bit(!MX)
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        STZ.B $42,X
        %Set8bit(!M)
        STZ.B $44,X

        RTL

;;;;;;; clears partially, Param in Y
ZeroesPartial42Pointers: ;808F92
        %Set16bit(!MX)

    .loop:
        %Set16bit(!M)
        TYA
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        STZ.B $42,X
        %Set8bit(!M)
        STZ.B $44,X
        INY
        CPY.W #$0010
        BNE .loop

        RTL

;;;;;;;;
Zeroes42Pointers: ;808FAB
        %Set16bit(!MX)
        LDY.W #$0000

    .loop:
        %Set16bit(!M)
        TYA
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        STZ.B $42,X
        %Set8bit(!M)
        STZ.B $44,X
        INY
        CPY.W #$0010
        BNE .loop

        RTL

;;;;;;;; Sets the next time of day pallete for it to slowly transition
;;;;;;;; Param in A: next hourly palette
SetTimeofDayPalette: ;808FC7
        %Set8bit(!M)
        %Set16bit(!X)
        STA.W $017C
        STZ.W !palette_change_countdow
        XBA
        LDA.B #$00
        XBA
        %Set16bit(!M)
        STA.B $7E
        %Set8bit(!M)
        LDA.L !hour
        CMP.B #$12
        BCC .before6PM
        %Set16bit(!M)
        LDA.W #$0B00
        STA.B !palette_change_pointer
        %Set8bit(!M)
        LDA.B #$7F
        STA.B $06
        BRA .return

    .before6PM:
        %Set16bit(!M)
        LDA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        LDA.L PalettePointerTable,X
        STA.B !palette_change_pointer
        INX
        INX
        %Set8bit(!M)
        LDA.L PalettePointerTable,X
        STA.B $06

    .return: RTL

;;;;;;;; This function changes the colors of the current palette till its the same as the destination
;;;;;;;; palette for that hour
TransitionTimeofDayPalettes: ;80900C
        !howmuchtocopy = $84
        !palettechanged = $92

        %Set8bit(!M)
        %Set16bit(!X)
        LDA.W !time_running
        AND.B #$01                           ;time is running
        BNE .timenotrunning
        JMP.W .return

    .timenotrunning:
        %Set16bit(!M)
        LDA.B !palette_change_pointer
        BNE .pointerset
        %Set8bit(!M)
        LDA.B $06
        BNE .pointerset
        JMP.W .return

    .pointerset:
        %Set8bit(!M)
        LDA.W !palette_change_countdow
        INC A
        STA.W !palette_change_countdow
        CMP.B #$20
        BEQ .changepalette
        JMP.W .return

    .changepalette:
        STZ.W !palette_change_countdow
        %Set16bit(!M)
        LDA.W #$0100
        STA.B !howmuchtocopy
        %Set8bit(!M)
        LDA.L !hour
        CMP.B #18
        BCC .notnight
        %Set16bit(!M)
        LDA.W #$0200
        STA.B !howmuchtocopy

    .notnight:
        %Set8bit(!M)
        STZ.B !palettechanged
        LDY.W #$0000

    .loop:
        %Set8bit(!M)
        %Set16bit(!X)
        CPY.W #$0002
        BNE .dontchangey
        LDY.W #$0018
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$0004                         ;FLAG196 Sunny
        BNE .dontchangey
        LDY.W #$0020

    .dontchangey:
        TYX
        %Set16bit(!M)
        LDA.L $7F0D00,X
        AND.W #$001F                         ;separate red
        STA.B $7E
        LDA.B [!palette_change_pointer],Y
        AND.W #$001F
        CMP.B $7E
        BEQ .comparegreen                    ;color achieved
        BCS .getredbrighter
        DEC.B $7E
        BRA .getreddarker

    .getredbrighter:
        INC.B $7E

    .getreddarker:
        %Set8bit(!M)
        LDA.B #$01
        STA.B !palettechanged

    .comparegreen:
        %Set16bit(!M)
        LDA.L $7F0D00,X
        AND.W #$03E0                         ;separate green
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        STA.B $80
        LDA.B [!palette_change_pointer],Y
        AND.W #$03E0
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        CMP.B $80
        BEQ .compareblue
        BCS .getgreenbrighter
        DEC.B $80
        BRA .getgreendarker

    .getgreenbrighter:
        INC.B $80

    .getgreendarker:
        %Set8bit(!M)
        LDA.B #$01
        STA.B !palettechanged

    .compareblue:
        %Set16bit(!M)
        LDA.L $7F0D00,X
        AND.W #$7C00                         ;separate blue
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        STA.B $82
        LDA.B [!palette_change_pointer],Y
        AND.W #$7C00
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        CMP.B $82
        BEQ .joincolors
        BCS .getbluebrighter
        DEC.B $82
        BRA .getbluedarker

    .getbluebrighter:
        INC.B $82

    .getbluedarker:
        %Set8bit(!M)
        LDA.B #$01
        STA.B !palettechanged

    .joincolors:
        %Set16bit(!M)
        ASL.B $80
        ASL.B $80
        ASL.B $80
        ASL.B $80
        ASL.B $80
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        ASL.B $82
        LDA.B $7E
        ORA.B $80
        ORA.B $82
        STA.L $7F0900,X
        STA.L $7F0D00,X
        INY
        INY
        CPY.B !howmuchtocopy
        BEQ .exitloop
        JMP.W .loop

    .exitloop:
        %Set8bit(!M)
        LDA.B !palettechanged                            ;If nothing to change, you are done!
        BEQ ClearsTimeofDayPaletteIndexandSetsNext
        %Set8bit(!M)
        LDA.B #$06
        STA.B !ProgDMA_Channel_Index
        LDA.B #$22
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!M)
        LDY.B !howmuchtocopy
        LDX.W #$0000
        LDA.W #$0900
        STA.B $72
        %Set8bit(!M)
        LDA.B #$7F
        STA.B $74
        JSL.L AddProgrammedDMA

        .return: RTL

;;;;;;;; Resets !palette_change_pointer and moves the next hour's palettes index
ClearsTimeofDayPaletteIndexandSetsNext: ;809157
        %Set16bit(!M)
        STZ.B !palette_change_pointer
        %Set8bit(!M)
        STZ.B $06
        LDA.W $017C
        STA.W !palette_to_load

        RTL

;;;;;;;; Resets !palette_change_pointer
ClearsTimeofDayPalette: ;809166
        %Set16bit(!MX)
        STZ.B !palette_change_pointer
        %Set8bit(!M)
        STZ.B $06

        RTL

;;;;;;;;
;;;;;;;; Params in A, Y, X and $92
SUB_80916F: ;80916F
        %Set16bit(!MX)
        STA.B $82
        STY.B $7E
        TXA
        ASL A
        STA.B $80
        LDA.B $7E
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        CLC
        ADC.B $80
        TAX
        %Set8bit(!M)
        LDA.B $92
        BNE .CODE_809194
        %Set16bit(!M)
        LDA.B $82
        STA.L $7F0900,X
        BRA .return

    .CODE_809194:
        %Set16bit(!M)
        LDA.B $82
        STA.L $7F0B00,X

    .return: RTL

;;;;;;;;
;;;;;;;; Params in A, Y, X and $92:update only B00 copy of cgram
SUB_80919D: ;80919D
        %Set16bit(!MX)
        STA.B $82
        STY.B $7E
        TXA
        ASL A
        STA.B $80
        LDA.B $7E
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        CLC
        ADC.B $80
        TAX
        %Set8bit(!M)
        LDA.B $92
        BNE .CODE_8091C6
        %Set16bit(!M)
        LDA.B $82
        STA.L $7F0900,X
        STA.L $7F0D00,X
        BRA .return

    .CODE_8091C6:
        %Set16bit(!M)
        LDA.B $82
        STA.L $7F0B00,X

    .return: RTL

;;;;;;;; Loads first half of a pallete to spaces 7F0900 and 7F0D00
;;;;;;;; param in A, index to pointer to palette
LoadFirstHalfPaletteToWRAM: ;8091CF
        %Set16bit(!MX)
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E                            ;*3
        TAX
        LDA.L PalettePointerTable,X
        STA.B $72
        INX
        INX
        %Set8bit(!M)
        LDA.L PalettePointerTable,X
        STA.B $74
        %Set16bit(!M)
        LDA.W #$0100
        STA.B $7E
        LDX.W #$0000
        LDY.W #$0000

      - LDA.B [$72],Y
        STA.L $7F0900,X
        STA.L $7F0D00,X
        INY
        INY
        INX
        INX
        CPY.B $7E
        BNE -

        RTL

;;;;;;;; Loads first half of a pallete to spaces 7F0900 and 7F0D00
;;;;;;;; Params in A:
LoadSecondHalfPaletteToWRAM: ;809208
        %Set16bit(!MX)
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E                            ; * 3
        TAX
        LDA.L PalettePointerTable,X
        STA.B $72
        INX
        INX
        %Set8bit(!M)
        LDA.L PalettePointerTable,X
        STA.B $74
        %Set16bit(!M)
        LDA.W #$0100                         ;a whole row
        STA.B $7E
        LDX.W #$0100
        LDY.W #$0000

    .fillcolorloop: ;80922E
        LDA.B [$72],Y
        STA.L $7F0900,X
        STA.L $7F0D00,X
        INY
        INY
        INX
        INX
        CPY.B $7E
        BNE .fillcolorloop

        RTL

;;;;;;;;
SUB_809241: ;809241
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        %Set16bit(!M)
        STA.B $80
        ASL A
        ASL A
        CLC
        ADC.B $80
        ADC.B $80
        ADC.W #$0004                         ; * 6 + 4
        TAX
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.L Time_Palette_Table,X
        %Set16bit(!M)
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E                            ; * 3
        TAX
        LDA.L PalettePointerTable,X
        STA.B $72
        INX
        INX
        %Set8bit(!M)
        LDA.L PalettePointerTable,X
        STA.B $74
        %Set16bit(!M)
        LDA.W #$0100
        STA.B $7E
        LDX.W #$0000
        LDY.W #$0000

        CODE_809288:
        LDA.B [$72],Y                        ;809288;000072;
        STA.L $7F0B00,X                      ;80928A;7F0B00;
        INY                                  ;80928E;      ;
        INY                                  ;80928F;      ;
        INX                                  ;809290;      ;
        INX                                  ;809291;      ;
        CPY.B $7E                            ;809292;00007E;
        BNE CODE_809288                      ;809294;809288;

        %Set8bit(!M)                             ;809296;      ;
        LDA.B #$00                           ;809298;      ;
        XBA                                  ;80929A;      ;
        LDA.B !tilemap_to_load                            ;80929B;000022;
        ASL A                                ;80929D;      ;
        TAX                                  ;80929E;      ;
        INX                                  ;80929F;      ;
        LDA.W UNK_Table11,X                 ;8092A0;00BE44;
        %Set16bit(!M)                             ;8092A3;      ;
        STA.B $7E                            ;8092A5;00007E;
        ASL A                                ;8092A7;      ;
        CLC                                  ;8092A8;      ;
        ADC.B $7E                            ;8092A9;00007E;
        TAX                                  ;8092AB;      ;
        LDA.L PalettePointerTable,X          ;8092AC;80B9FD;
        STA.B $72                            ;8092B0;000072;
        INX                                  ;8092B2;      ;
        INX                                  ;8092B3;      ;
        %Set8bit(!M)                             ;8092B4;      ;
        LDA.L PalettePointerTable,X          ;8092B6;80B9FD;
        STA.B $74                            ;8092BA;000074;
        %Set16bit(!M)                             ;8092BC;      ;
        LDA.W #$0100                         ;8092BE;      ;
        STA.B $7E                            ;8092C1;00007E;
        LDX.W #$0100                         ;8092C3;      ;
        LDY.W #$0000                         ;8092C6;      ;

        CODE_8092C9:
        LDA.B [$72],Y                        ;8092C9;000072;
        STA.L $7F0B00,X                      ;8092CB;7F0B00;
        INY                                  ;8092CF;      ;
        INY                                  ;8092D0;      ;
        INX                                  ;8092D1;      ;
        INX                                  ;8092D2;      ;
        CPY.B $7E                            ;8092D3;00007E;
        BNE CODE_8092C9                      ;8092D5;8092C9;
        %Set8bit(!M)                             ;8092D7;      ;
        LDA.B #$01                           ;8092D9;      ;
        STA.B $92                            ;8092DB;000092;
        JSL.L SUB_8093A3                           ;8092DD;8093A4;

        RTL                                  ;8092E1;      ;END_GGGG

;;;;;;;;
ChangePalettebyTime: ;8092E2
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        LDA.L !hour
        CMP.B #$07
        BCC .timeFound
        INX
        CMP.B #$0F
        BCC .timeFound
        INX
        CMP.B #$11
        BCC .timeFound
        INX
        CMP.B #$12
        BCC .timeFound
        INX

    .timeFound:
        STX.B $7E
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        %Set16bit(!M)
        STA.B $80                            ;Map
        ASL A
        ASL A
        CLC
        ADC.B $80
        ADC.B $80                            ;*6, as theres 6 values
        ADC.B $7E                            ;+ current seleceted
        TAX
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.L Time_Palette_Table,X
        STA.W !palette_to_load
        %Set16bit(!M)
        JSL.L LoadFirstHalfPaletteToWRAM

        RTL

;;;;;;;;
SUB_809329: ;809329
        %Set16bit(!MX)
        LDA.L $7F1F5E
        AND.W #$0080                         ;Flag5E
        BNE SUB_80936E
        LDA.L $7F1F5E
        AND.W #$0100                         ;Flag5E
        BNE SUB_809380
        LDA.L $7F1F5E
        AND.W #$0200                         ;Flag5E
        BNE SUB_809392
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        ASL A
        TAX
        LDA.L !hour
        CMP.B #$12                           ;18
        BCC CODE_809358
        INX

        CODE_809358:
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.W UNK_Table11,X
        %Set16bit(!M)
        JSL.L LoadSecondHalfPaletteToWRAM
        %Set8bit(!M)
        STZ.B $92
        JSL.L SUB_8093A3

        RTL

;;;;;;;;
SUB_80936E: ;80936E
        %Set16bit(!MX)
        LDA.W #$0071
        JSL.L LoadSecondHalfPaletteToWRAM
        %Set8bit(!M)
        STZ.B $92
        JSL.L SUB_8093A3

        RTL

;;;;;;;;
SUB_809380: ;809380
        %Set16bit(!MX)
        LDA.W #$0072
        JSL.L LoadSecondHalfPaletteToWRAM
        %Set8bit(!M)
        STZ.B $92
        JSL.L SUB_8093A3

        RTL

;;;;;;;;
SUB_809392: ;809392
        %Set16bit(!MX)
        LDA.W #$0073
        JSL.L LoadSecondHalfPaletteToWRAM
        %Set8bit(!M)
        STZ.B $92
        JSL.L SUB_8093A3

        RTL

;;;;;;;;
SUB_8093A3: ;8093A3
        %Set16bit(!MX)
        STZ.B $7E
        %Set8bit(!M)
        LDA.B $92                            ;TODO
        BNE .skip
        LDA.L !hour
        CMP.B #18
        BCC .before6PM
        LDA.B !tilemap_to_load
        CMP.B #$31                           ;Map summit spring
        BCS .skip                            ;most maps
        CMP.B #$15                           ;seasonal maps
        BCS .before6PM

    .skip:
        %Set16bit(!M)
        LDA.W #$0004
        STA.B $7E

    .before6PM:
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $0022                          ;tilemap_to_load
        CMP.B #$04                           ;farm
        BCS .notfarm

    .seasonloop:
        %Set8bit(!M)
        LDA.L !season
        %Set16bit(!M)
        STA.B $82
        BRA .continue

    .notfarm:
        %Set8bit(!M)
        CMP.B #$10
        BCC .seasonloop                      ;Check Fork
        CMP.B #$14
        BCS .seasonloop                      ;Check Mountain
        %Set16bit(!M)
        SEC
        SBC.W #$0008
        STA.B $82

    .continue:
        %Set8bit(!M)                             ;8093F1;      ;
        LDA.B #$00                           ;8093F3;      ;
        XBA                                  ;8093F5;      ;
        LDA.B $82                            ;8093F6;000082;
        CLC                                  ;8093F8;      ;
        ADC.B $7E                            ;8093F9;00007E;
        STA.B $80                            ;8093FB;000080;
        %Set16bit(!M)                             ;8093FD;      ;
        ASL A                                ;8093FF;      ;
        CLC                                  ;809400;      ;
        ADC.B $80                            ;809401;000080;
        ASL A                                ;809403;      ;
        TAX                                  ;809404;      ;
        PHX                                  ;809405;      ;
        LDA.L UNK_Table9,X                   ;809406;80BD9C;
        LDX.W #$000A                         ;80940A;      ;
        LDY.W #$000F                         ;80940D;      ;
        JSL.L SUB_80919D                    ;809410;80919D;
        %Set16bit(!MX)                             ;809414;      ;
        PLX                                  ;809416;      ;
        INX                                  ;809417;      ;
        INX                                  ;809418;      ;
        PHX                                  ;809419;      ;
        LDA.L UNK_Table9,X                   ;80941A;80BD9C;
        LDX.W #$000B                         ;80941E;      ;
        LDY.W #$000F                         ;809421;      ;
        JSL.L SUB_80919D                    ;809424;80919D;
        %Set16bit(!MX)                             ;809428;      ;
        PLX                                  ;80942A;      ;
        INX                                  ;80942B;      ;
        INX                                  ;80942C;      ;
        LDA.L UNK_Table9,X                   ;80942D;80BD9C;
        LDX.W #$000C                         ;809431;      ;
        LDY.W #$000F                         ;809434;      ;
        JSL.L SUB_80919D                    ;809437;80919D;
        %Set16bit(!MX)                             ;80943B;      ;
        STZ.B $7E                            ;80943D;00007E;
        %Set8bit(!M)                             ;80943F;      ;
        LDA.B $92                            ;809441;000092;
        BNE CODE_809457                      ;809443;809457;
        LDA.L !hour                        ;809445;7F1F1C;Hour
        CMP.B #$12                           ;809449;      ;
        BCC CODE_809460                      ;80944B;809460;
        LDA.B !tilemap_to_load                            ;80944D;000022;
        CMP.B #$31                           ;80944F;      ;
        BCS CODE_809457                      ;809451;809457;
        CMP.B #$15                           ;809453;      ;
        BCS CODE_809460                      ;809455;809460;

        CODE_809457: %Set16bit(!M)                             ;809457;      ;
        LDA.W #$0006                         ;809459;      ;
        STA.B $7E                            ;80945C;00007E;
        BRA CODE_809460                      ;80945E;809460;

        CODE_809460: %Set16bit(!MX)                             ;809460;      ;
        LDA.L !wife_pregnancy                        ;809462;7F1F3B;Wife Pregnancy
        BNE CODE_80946B                      ;809466;80946B;
        JMP.W returnAAAA                        ;809468;809500;

        CODE_80946B: LDA.L $7F1F66                        ;80946B;7F1F66;Which Wife Flag
        AND.W #$0001                         ;80946F;      ;
        BNE CODE_80949A                      ;809472;80949A;
        LDA.L $7F1F66                        ;809474;7F1F66;Which Wife Flag
        AND.W #$0002                         ;809478;      ;
        BNE CODE_8094A1                      ;80947B;8094A1;
        LDA.L $7F1F66                        ;80947D;7F1F66;Which Wife Flag
        AND.W #$0004                         ;809481;      ;
        BNE CODE_8094A8                      ;809484;8094A8;
        LDA.L $7F1F66                        ;809486;7F1F66;Which Wife Flag
        AND.W #$0008                         ;80948A;      ;
        BNE CODE_8094AF                      ;80948D;8094AF;
        LDA.L $7F1F66                        ;80948F;7F1F66;Which Wife Flag
        AND.W #$0010                         ;809493;      ;
        BNE CODE_8094B6                      ;809496;8094B6;
        BRA returnAAAA                          ;809498;809500;

        CODE_80949A: %Set16bit(!MX)                             ;80949A;      ;
        LDA.W #$0001                         ;80949C;      ;
        BRA CODE_8094BD                      ;80949F;8094BD;

        CODE_8094A1: %Set16bit(!MX)                             ;8094A1;      ;
        LDA.W #$0002                         ;8094A3;      ;
        BRA CODE_8094BD                      ;8094A6;8094BD;

        CODE_8094A8: %Set16bit(!MX)                             ;8094A8;      ;
        LDA.W #$0003                         ;8094AA;      ;
        BRA CODE_8094BD                      ;8094AD;8094BD;

        CODE_8094AF: %Set16bit(!MX)                             ;8094AF;      ;
        LDA.W #$0004                         ;8094B1;      ;
        BRA CODE_8094BD                      ;8094B4;8094BD;

        CODE_8094B6: %Set16bit(!MX)                             ;8094B6;      ;
        LDA.W #$0005                         ;8094B8;      ;
        BRA CODE_8094BD                      ;8094BB;8094BD;

        CODE_8094BD: %Set16bit(!MX)                             ;8094BD;      ;
        CLC                                  ;8094BF;      ;
        ADC.B $7E                            ;8094C0;00007E;
        STA.B $80                            ;8094C2;000080;
        ASL A                                ;8094C4;      ;
        CLC                                  ;8094C5;      ;
        ADC.B $80                            ;8094C6;000080;
        ASL A                                ;8094C8;      ;
        TAX                                  ;8094C9;      ;
        PHX                                  ;8094CA;      ;
        LDA.L UNK_Table10,X                  ;8094CB;80BDFC;
        LDX.W #$0008                         ;8094CF;      ;
        LDY.W #$000B                         ;8094D2;      ;
        JSL.L SUB_80919D                    ;8094D5;80919D;
        %Set16bit(!MX)                             ;8094D9;      ;
        PLX                                  ;8094DB;      ;
        INX                                  ;8094DC;      ;
        INX                                  ;8094DD;      ;
        PHX                                  ;8094DE;      ;
        LDA.L UNK_Table10,X                  ;8094DF;80BDFC;
        LDX.W #$0009                         ;8094E3;      ;
        LDY.W #$000B                         ;8094E6;      ;
        JSL.L SUB_80919D                    ;8094E9;80919D;
        %Set16bit(!MX)                             ;8094ED;      ;
        PLX                                  ;8094EF;      ;
        INX                                  ;8094F0;      ;
        INX                                  ;8094F1;      ;
        LDA.L UNK_Table10,X                  ;8094F2;80BDFC;
        LDX.W #$000A                         ;8094F6;      ;
        LDY.W #$000B                         ;8094F9;      ;
        JSL.L SUB_80919D                    ;8094FC;80919D;

        returnAAAA: RTL                                  ;809500;      ;END_AAAA

;;;;;;;;
SetPaletteToLoad: ;809501
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        LDA.L !hour
        CMP.B #7
        BCC .hourfound
        INX
        CMP.B #15
        BCC .hourfound
        INX
        CMP.B #17
        BCC .hourfound
        INX
        CMP.B #18
        BCC .hourfound
        INX

    .hourfound:
        STX.B $7E
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        %Set16bit(!M)
        STA.B $80
        ASL A
        ASL A
        CLC
        ADC.B $80
        ADC.B $80                           ;tilemap_to_load * 6
        ADC.B $7E                           ; + hour found index
        TAX
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.L Time_Palette_Table,X
        CMP.W !palette_to_load
        BEQ .return
        CMP.B #$FF
        BEQ .return
        PHA
        JSL.L SetTimeofDayPalette
        %Set8bit(!M)
        PLA
        STA.W !palette_to_load

        .return: RTL

;;;;;;;;
CallIndexedSubrutines: ;809553
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        LDA.L !hour
        CMP.B #07
        BCC .timeFound
        INX
        CMP.B #15
        BCC .timeFound
        INX
        CMP.B #17
        BCC .timeFound
        INX
        CMP.B #18
        BCC .timeFound
        INX

    .timeFound:
        STX.B $7E
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        %Set16bit(!M)
        STA.B $80
        ASL A
        ASL A
        CLC
        ADC.B $80
        ADC.B $80
        STA.B $80                           ; * 6
        ASL A
        CLC
        ADC.W #$000A                        ; + #10
        TAX
        LDA.W Subrutines_Table,X
        CMP.W #$FFFF
        BEQ .skipSeasonCheck
        %Set8bit(!M)
        LDA.L !season
        CMP.B #$02
        BCC .return                         ;Spring or Summer

    .skipSeasonCheck:
        %Set16bit(!M)
        LDA.B $80
        CLC
        ADC.B $7E
        ASL A
        TAX
        LDA.W Subrutines_Table,X
        CMP.W #$FFFF
        BEQ .return
        JSR.W (Subrutines_Table,X)

        .return: RTL

;;;;;;;;
AutoMapScrolling: ;8095B3
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.W !map_scrolling_timer
        BEQ .return
        DEC A
        STA.W !map_scrolling_timer
        %Set16bit(!M)
        LDA.B !OBJ_Offset_X
        CLC
        ADC.W !map_scrolling_X_speed
        STA.B !OBJ_Offset_X
        STA.W !BG1_Map_Offset_X
        LDA.B !OBJ_Offset_Y
        CLC
        ADC.W !map_scrolling_Y_speed
        STA.B !OBJ_Offset_Y
        STA.W !BG1_Map_Offset_Y
        BPL .return
        STZ.W !BG1_Map_Offset_Y

    .return RTL

;;;;;;;; sets audio flags
UNK_Audio5: ;8095DE
        %Set8bit(!M)                             ;;      ;
        %Set16bit(!X)                             ;8095E0;      ;
        LDA.B !tilemap_to_load                            ;8095E2;000022;
        CMP.B #$1E                           ;8095E4;      ;
        BEQ $0D                              ;8095E6;8095F5;chek if !tilemap_to_load = $1E
        %Set8bit(!M)                             ;8095E8;      ;
        LDA.L !hour                        ;8095EA;7F1F1C;Hour
        CMP.B #$12                           ;8095EE;      ;
        BCC $03                              ;8095F0;8095F5;Before 12PM
        JMP.W Max7E0110                      ;8095F2;809669;Exit Point
                                                ;      ;      ;
        %Set8bit(!M)                             ;8095F5;      ;
        %Set16bit(!X)                             ;8095F7;      ;
        STZ.W $0110                          ;8095F9;000110;$7E0110
        %Set16bit(!M)                             ;8095FC;      ;
        LDA.W $0196                          ;8095FE;000196;$7E0196
        AND.W #$0010                         ;809601;      ;
        BNE .flag10                          ;809604;80965F;
        LDA.W $0196                          ;809606;000196;$7E0196
        AND.W #$0002                         ;809609;      ;
        BNE .flag02                          ;80960C;809639;
                                                ;      ;      ;
        .loop1: %Set8bit(!M)                             ;80960E;      ;
        LDA.B #$00                           ;809610;      ;
        XBA                                  ;809612;      ;
        LDA.B !tilemap_to_load                            ;809613;000022;$7E0022
        %Set16bit(!M)                             ;809615;      ;
        ASL A                                ;809617;      ;A*2
        TAX                                  ;809618;      ;
        LDA.L Mayby_Table_AudioTracksbySeason,X;809619;80B8E7;
        CMP.W #$FFFF                         ;80961D;      ;
        BEQ .return                          ;809620;809668;not terminator
        STA.B $7E                            ;809622;00007E;$7E007E
        %Set8bit(!M)                             ;809624;      ;
        LDA.B #$00                           ;809626;      ;
        XBA                                  ;809628;      ;
        LDA.L !season                        ;809629;7F1F19;Season
        %Set16bit(!M)                             ;80962D;      ;
        TAY                                  ;80962F;      ;
        %Set8bit(!M)                             ;809630;      ;
        LDA.B ($7E),Y                        ;809632;00007E;
        STA.W $0110                          ;809634;000110;$7E0110
        BRA .return                          ;809637;809668;
                                                ;      ;      ;
                                                ;      ;      ;
        .flag02: %Set8bit(!M)                             ;809639;      ;
        LDA.B !tilemap_to_load                            ;80963B;000022;$7E0022
        CMP.B #$5B                           ;80963D;      ;more than 91
        BCS .loop1                           ;80963F;80960E;
        CMP.B #$57                           ;809641;      ;more than 57
        BCS .return                          ;809643;809668;
        CMP.B #$31                           ;809645;      ;more than 49
        BCS .skip1                           ;809647;80964D;
        CMP.B #$15                           ;809649;      ;more than 15
        BCS .skip2                           ;80964B;809656;
                                                ;      ;      ;
        .skip1: %Set8bit(!M)                             ;80964D;      ;
        LDA.B #$13                           ;80964F;      ;
        STA.W $0110                          ;809651;000110;
        BRA .return                          ;809654;809668;
                                                ;      ;      ;
                                                ;      ;      ;
        .skip2: %Set8bit(!M)                             ;809656;      ;
        LDA.B #$14                           ;809658;      ;
        STA.W $0110                          ;80965A;000110;
        BRA .return                          ;80965D;809668;
                                                ;      ;      ;
                                                ;      ;      ;
        .flag10: %Set8bit(!M)                             ;80965F;      ;
        LDA.B #$16                           ;809661;      ;
        STA.W $0110                          ;809663;000110;$7E0110
        BRA .return                          ;809666;809668;
                                                ;      ;      ;
                                                ;      ;      ;
        .return: RTL                                  ;809668;      ;
                                                ;      ;      ;
                                                ;      ;      ;
        Max7E0110: %Set8bit(!M)                             ;809669;      ;
        LDA.B #$FF                           ;80966B;      ;
        STA.W $0110                          ;80966D;000110;
        RTL                                  ;809670;      ;Max7E0110

;;;;;;;; Wrong name TODO
SetScreenTransition: ;809671
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$4000                         ;FLAG196
        BNE .transitioning

        JMP.W ScreenTransitionReturn

    .transitioning:
        LDA.L $7F1F5E
        AND.W #$8000                         ;FLAG5E
        BNE .skip1

        LDA.L $7F1F60
        AND.W #$0100                         ;FLAG60

        BNE .loop
        LDA.L $7F1F60
        AND.W #$0040                         ;FLAG60
        BEQ .loop
        JMP.W ScreenTransitionReturn

    .loop:
        %Set8bit(!M)
        LDA.W !transition_dest
        STA.B !tilemap_to_load
        JSL.L UNK_Audio5
        JSL.L UNK_Audio25

    .skip1:
        %Set16bit(!M)
        LDA.L $7F1F60
        AND.W #$0008                         ;FLAG60
        BEQ .skip2
        %Set8bit(!M)
        LDA.B #$3C                           ;TODO
        STA.W !transition_dest

    .skip2:
        %Set8bit(!M)
        LDA.B #$0F
        STA.B !param1
        LDA.B #$03
        STA.B !param2
        LDA.B #$01
        STA.B !param3
        JSL.L ScreenFadeout
        JSL.L ForceBlank

;;;;;;;;
UNK_ScreenTransition: ;8096D3
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$3FDE                         ;FLAG196 resets many flags, keeping others
        STA.W $0196
        LDA.L $7F1F5C
        AND.W #$FFF0                         ;FLAG5C resets a nibble
        STA.L $7F1F5C
        %Set16bit(!MX)
        LDA.B !game_state
        ORA.W #$4000                         ;sets a flag
        STA.B !game_state
        %Set16bit(!M)
        LDA.W #$7000
        JSL.L ZeroesPartialVRAM
        JSL.L Zeroes42Pointers
        JSL.L ClearsTimeofDayPalette
        JSL.L ClearWRAMGraphicsSpace
        JSL.L InitializeOBJs
        JSL.L PresetsMemory3
        JSL.L PresetsMemory4
        %Set8bit(!M)
        LDA.W !transition_dest
        STA.B !tilemap_to_load
        JSL.L RunsFunctionbyIndex
        JSL.L CODE_84816F
        %Set8bit(!M)
        LDA.W !transition_dest
        JSL.L SUB_80972C

;;;;;;;;
ScreenTransitionReturn: ;80972B
        RTL                                  ;Used by this and previous Subrutine

;;;;;;;;
SUB_80972C: ;80972C
        %Set8bit(!M)                             ;      ;
        %Set16bit(!X)                             ;80972E;      ;
        STA.B !tilemap_to_load                            ;809730;000022;
        PHA                                  ;809732;      ;
        %Set8bit(!M)                             ;809733;      ;
        STZ.W !time_running                          ;809735;000973;
        %Set16bit(!MX)                             ;809738;      ;
        LDY.W #$0001                         ;80973A;      ;
        JSL.L SUB_80A7AE                          ;80973D;80A7AE;
        %Set8bit(!M)                             ;809741;      ;
        PHA                                  ;809743;      ;
        AND.B #$20                           ;809744;      ;
        BEQ CODE_80975A                      ;809746;80975A;
        %Set16bit(!M)                             ;809748;      ;
        LDA.L $7F1F5C                        ;80974A;7F1F5C;
        AND.W #$0001                         ;80974E;      ;
        BNE CODE_80975A                      ;809751;80975A;
        %Set8bit(!M)                             ;809753;      ;
        LDA.B #$01                           ;809755;      ;
        STA.W !time_running                          ;809757;000973;
                                            ;      ;      ;
        CODE_80975A:
        %Set8bit(!M)                             ;80975A;      ;
        PLA                                  ;80975C;      ;
        AND.B #$C0                           ;80975D;      ;
        BNE CODE_809764                      ;80975F;809764;
        JMP.W CODE_8098A8                    ;809761;8098A8;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809764:
        AND.B #$80                           ;809764;      ;
        BNE CODE_809775                      ;809766;809775;
        %Set16bit(!M)                             ;809768;      ;
        LDA.W $0196                          ;80976A;000196;
        AND.W #$0004                         ;80976D;      ;
        BEQ CODE_809775                      ;809770;809775;
        JMP.W CODE_8098A8                    ;809772;8098A8;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809775:
        %Set16bit(!M)                             ;809775;      ;
        LDA.L $7F1F5C                        ;809777;7F1F5C;
        AND.W #$0002                         ;80977B;      ;
        BEQ CODE_809783                      ;80977E;809783;
        JMP.W CODE_8098A8                    ;809780;8098A8;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809783:
        %Set16bit(!M)                             ;809783;      ;
        LDA.W $0196                          ;809785;000196;
        AND.W #$0002                         ;809788;      ;
        BEQ CODE_809806                      ;80978B;809806;
        %Set8bit(!M)                             ;80978D;      ;
        LDA.B #$57                           ;80978F;      ;
        STA.B !tilemap_to_load                            ;809791;000022;
        JSL.L BackgroundsManager           ;809793;80A7C6;
        %Set16bit(!M)                             ;809797;      ;
        %Set8bit(!X)                             ;809799;      ;
        LDA.W #$B9D7                         ;80979B;      ;
        STA.B $72                            ;80979E;000072;
        %Set8bit(!M)                             ;8097A0;      ;
        LDA.B #$80                           ;8097A2;      ;
        STA.B $74                            ;8097A4;000074;
        %Set8bit(!M)                             ;8097A6;      ;
        LDA.B #$0C                           ;8097A8;      ;
        LDX.B #$00                           ;8097AA;      ;
        LDY.B #$00                           ;8097AC;      ;
        JSL.L UNK_SetPointer42            ;8097AE;808E48;
        %Set16bit(!M)                             ;8097B2;      ;
        %Set8bit(!X)                             ;8097B4;      ;
        LDA.W #$B9DC                         ;8097B6;      ;
        STA.B $72                            ;8097B9;000072;
        %Set8bit(!M)                             ;8097BB;      ;
        LDA.B #$80                           ;8097BD;      ;
        STA.B $74                            ;8097BF;000074;
        %Set8bit(!M)                             ;8097C1;      ;
        LDA.B #$0D                           ;8097C3;      ;
        LDX.B #$01                           ;8097C5;      ;
        LDY.B #$00                           ;8097C7;      ;
        JSL.L UNK_SetPointer42            ;8097C9;808E48;
        %Set16bit(!M)                             ;8097CD;      ;
        %Set8bit(!X)                             ;8097CF;      ;
        LDA.W #$B9E2                         ;8097D1;      ;
        STA.B $72                            ;8097D4;000072;
        %Set8bit(!M)                             ;8097D6;      ;
        LDA.B #$80                           ;8097D8;      ;
        STA.B $74                            ;8097DA;000074;
        %Set8bit(!M)                             ;8097DC;      ;
        LDA.B #$0E                           ;8097DE;      ;
        LDX.B #$02                           ;8097E0;      ;
        LDY.B #$00                           ;8097E2;      ;
        JSL.L UNK_SetPointer42            ;8097E4;808E48;
        %Set16bit(!M)                             ;8097E8;      ;
        %Set8bit(!X)                             ;8097EA;      ;
        LDA.W #$B9DF                         ;8097EC;      ;
        STA.B $72                            ;8097EF;000072;
        %Set8bit(!M)                             ;8097F1;      ;
        LDA.B #$80                           ;8097F3;      ;
        STA.B $74                            ;8097F5;000074;
        %Set8bit(!M)                             ;8097F7;      ;
        LDA.B #$0F                           ;8097F9;      ;
        LDX.B #$03                           ;8097FB;      ;
        LDY.B #$00                           ;8097FD;      ;
        JSL.L UNK_SetPointer42            ;8097FF;808E48;
        JMP.W CODE_8098A8                    ;809803;8098A8;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809806:
        %Set16bit(!M)                             ;809806;      ;
        LDA.W $0196                          ;809808;000196;
        AND.W #$0004                         ;80980B;      ;
        BEQ CODE_809828                      ;80980E;809828;
        %Set8bit(!M)                             ;809810;      ;
        LDA.L !hour                        ;809812;7F1F1C;
        CMP.B #$11                           ;809816;      ;
        BCC CODE_80981D                      ;809818;80981D;
        JMP.W CODE_8098A8                    ;80981A;8098A8;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80981D:
        LDA.B #$58                           ;80981D;      ;
        STA.B !tilemap_to_load                            ;80981F;000022;
        JSL.L BackgroundsManager           ;809821;80A7C6;
        JMP.W CODE_8098A8                    ;809825;8098A8;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809828:
        %Set16bit(!M)                             ;809828;      ;
        LDA.W $0196                          ;80982A;000196;
        AND.W #$0008                         ;80982D;      ;
        BEQ CODE_8098A8                      ;809830;8098A8;
        %Set8bit(!M)                             ;809832;      ;
        LDA.B #$59                           ;809834;      ;
        STA.B !tilemap_to_load                            ;809836;000022;
        JSL.L BackgroundsManager           ;809838;80A7C6;
        %Set16bit(!M)                             ;80983C;      ;
        %Set8bit(!X)                             ;80983E;      ;
        LDA.W #$B9EA                         ;809840;      ;
        STA.B $72                            ;809843;000072;
        %Set8bit(!M)                             ;809845;      ;
        LDA.B #$80                           ;809847;      ;
        STA.B $74                            ;809849;000074;
        %Set8bit(!M)                             ;80984B;      ;
        LDA.B #$0C                           ;80984D;      ;
        LDX.B #$00                           ;80984F;      ;
        LDY.B #$00                           ;809851;      ;
        JSL.L UNK_SetPointer42            ;809853;808E48;
        %Set16bit(!M)                             ;809857;      ;
        %Set8bit(!X)                             ;809859;      ;
        LDA.W #$B9EF                         ;80985B;      ;
        STA.B $72                            ;80985E;000072;
        %Set8bit(!M)                             ;809860;      ;
        LDA.B #$80                           ;809862;      ;
        STA.B $74                            ;809864;000074;
        %Set8bit(!M)                             ;809866;      ;
        LDA.B #$0D                           ;809868;      ;
        LDX.B #$01                           ;80986A;      ;
        LDY.B #$00                           ;80986C;      ;
        JSL.L UNK_SetPointer42            ;80986E;808E48;
        %Set16bit(!M)                             ;809872;      ;
        %Set8bit(!X)                             ;809874;      ;
        LDA.W #$B9F2                         ;809876;      ;
        STA.B $72                            ;809879;000072;
        %Set8bit(!M)                             ;80987B;      ;
        LDA.B #$80                           ;80987D;      ;
        STA.B $74                            ;80987F;000074;
        %Set8bit(!M)                             ;809881;      ;
        LDA.B #$0E                           ;809883;      ;
        LDX.B #$02                           ;809885;      ;
        LDY.B #$00                           ;809887;      ;
        JSL.L UNK_SetPointer42            ;809889;808E48;
        %Set16bit(!M)                             ;80988D;      ;
        %Set8bit(!X)                             ;80988F;      ;
        LDA.W #$B9F5                         ;809891;      ;
        STA.B $72                            ;809894;000072;
        %Set8bit(!M)                             ;809896;      ;
        LDA.B #$80                           ;809898;      ;
        STA.B $74                            ;80989A;000074;
        %Set8bit(!M)                             ;80989C;      ;
        LDA.B #$0F                           ;80989E;      ;
        LDX.B #$03                           ;8098A0;      ;
        LDY.B #$00                           ;8098A2;      ;
        JSL.L UNK_SetPointer42            ;8098A4;808E48;
                                            ;      ;      ;
        CODE_8098A8:
        JSL.L SUB_8392BB                    ;8098A8;8392BB;
        %Set8bit(!M)                             ;8098AC;      ;
        PLA                                  ;8098AE;      ;
        STA.B !tilemap_to_load                            ;8098AF;000022;
        JSL.L LoadMap                          ;8098B1;82A5FB;
        JSL.L BackgroundsManager           ;8098B5;80A7C6;
        JSL.L ChangePalettebyTime                           ;8098B9;8092E2;
        JSL.L SUB_809329                           ;8098BD;809329;
        JSL.L CallIndexedSubrutines                           ;8098C1;809553;
        JSL.L SUB_809241                           ;8098C5;809241;
        JSL.L UNK_BigLoop                    ;8098C9;808E69;
        %Set8bit(!M)                             ;8098CD;      ;
        %Set16bit(!X)                             ;8098CF;      ;
        LDA.B #$00                           ;8098D1;      ;
        STA.B !ProgDMA_Channel_Index                            ;8098D3;000027;
        LDA.B #$22                           ;8098D5;      ;
        STA.B !ProgDMA_Destination_Memory                            ;8098D7;000029;
        %Set16bit(!M)                             ;8098D9;      ;
        LDY.W #$0200                         ;8098DB;      ;
        LDX.W #$0000                         ;8098DE;      ;
        LDA.W #$0900                         ;8098E1;      ;
        STA.B $72                            ;8098E4;000072;
        %Set8bit(!M)                             ;8098E6;      ;
        LDA.B #$7F                           ;8098E8;      ;
        STA.B $74                            ;8098EA;000074;
        JSL.L AddProgrammedDMA                ;8098EC;808A33;
        JSL.L StartLastPreparedDMA               ;8098F0;808AB2;
        %Set16bit(!MX)                             ;8098F4;      ;
        STZ.B $1E                            ;8098F6;00001E;
        LDA.B !OBJ_Offset_X                            ;8098F8;0000F5;
        STA.W !BG2_Map_Offset_X                          ;8098FA;000140;
        LDA.B !OBJ_Offset_Y                           ;8098FD;0000F7;
        STA.W !BG2_Map_Offset_Y                          ;8098FF;000142;
        %Set8bit(!M)                             ;809902;      ;
        LDA.B !tilemap_to_load                            ;809904;000022;
        CMP.B #$26                           ;809906;      ;
        BNE CODE_809912                      ;809908;809912;
        %Set16bit(!M)                             ;80990A;      ;
        LDA.W #$0100                         ;80990C;      ;
        STA.W !BG2_Map_Offset_Y                          ;80990F;000142;
                                            ;      ;      ;
        CODE_809912:
        %Set8bit(!M)                             ;809912;      ;
        STZ.W $091C                          ;809914;00091C;
        %Set16bit(!M)                             ;809917;      ;
        LDA.L $7F1F5A                        ;809919;7F1F5A;
        AND.W #$FDFF                         ;FLAG5A
        STA.L $7F1F5A                        ;809920;7F1F5A;
        LDA.W #$0000                         ;809924;      ;
        STA.L $7F1F7A                        ;809927;7F1F7A;
        STZ.W $0878                          ;80992B;000878;
        LDA.B !player_pos_X                           ;80992E;0000D6;
        STA.W $0907                          ;809930;000907;
        LDA.B !player_pos_Y                            ;809933;0000D8;
        STA.W $0909                          ;809935;000909;
        %Set8bit(!M)                             ;809938;      ;
        STZ.W $098A                          ;80993A;00098A;
        STZ.W $0919                          ;80993D;000919;
        %Set16bit(!MX)                             ;809940;      ;
        LDA.W #$0080                         ;809942;      ;
        EOR.W #$FFFF                         ;809945;      ;
        AND.B !game_state                            ;809948;0000D2;
        STA.B !game_state                            ;80994A;0000D2;
        %Set16bit(!M)                             ;80994C;      ;
        STZ.W $08FD                          ;80994E;0008FD;
        STZ.W $08FF                          ;809951;0008FF;
        %Set16bit(!MX)                             ;809954;      ;
        LDA.W #$1000                         ;809956;      ;
        EOR.W #$FFFF                         ;809959;      ;
        AND.B !game_state                            ;80995C;0000D2;
        STA.B !game_state                            ;80995E;0000D2;
        %Set8bit(!M)                             ;809960;      ;
        LDA.W !item_on_hand                          ;809962;00091D;
        BEQ CODE_8099BC                      ;809965;8099BC;
        CMP.B #$0D                           ;809967;      ;
        BEQ CODE_8099B1                      ;809969;8099B1;
        CMP.B #$0E                           ;80996B;      ;
        BEQ CODE_8099B1                      ;80996D;8099B1;
        CMP.B #$0F                           ;80996F;      ;
        BEQ CODE_8099B1                      ;809971;8099B1;
        CMP.B #$57                           ;809973;      ;
        BEQ CODE_8099B1                      ;809975;8099B1;
        STA.W $0984                          ;809977;000984;
        %Set16bit(!M)                             ;80997A;      ;
        LDY.W #$0001                         ;80997C;      ;
        JSL.L SUB_8180B7                          ;80997F;8180B7;
        LDA.W $090B                          ;809983;00090B;
        STA.W $0980                          ;809986;000980;
        LDA.W $090D                          ;809989;00090D;
        STA.W $0982                          ;80998C;000982;
        %Set8bit(!M)                             ;80998F;      ;
        LDA.B #$01                           ;809991;      ;
        STA.W $0974                          ;809993;000974;
        LDA.B #$01                           ;809996;      ;
        STA.W $0975                          ;809998;000975;
        LDA.B #$02                           ;80999B;      ;
        STA.W $0976                          ;80999D;000976;
        JSL.L CODE_81A500                    ;8099A0;81A500;
        %Set16bit(!MX)                             ;8099A4;      ;
        LDA.W #$0014                         ;8099A6;      ;
        CLC                                  ;8099A9;      ;
        ADC.B !player_direction                            ;8099AA;0000DA;
        STA.W $0901                          ;8099AC;000901;
        BRA CODE_8099CD                      ;8099AF;8099CD;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_8099B1:
        %Set16bit(!MX)                             ;8099B1;      ;
        LDA.W #$0000                         ;8099B3;      ;
        CLC                                  ;8099B6;      ;
        ADC.B !player_direction                            ;8099B7;0000DA;
        STA.W $0901                          ;8099B9;000901;
                                            ;      ;      ;
        CODE_8099BC:
        %Set8bit(!M)                             ;8099BC;      ;
        STZ.W !item_on_hand                          ;8099BE;00091D;
        %Set16bit(!MX)                             ;8099C1;      ;
        LDA.W #$0002                         ;8099C3;      ;
        EOR.W #$FFFF                         ;8099C6;      ;
        AND.B !game_state                            ;8099C9;0000D2;
        STA.B !game_state                            ;8099CB;0000D2;
                                            ;      ;      ;
        CODE_8099CD:
        JSL.L CODE_81CFA0                    ;8099CD;81CFA0;
        JSL.L SUB_81BFB7                          ;8099D1;81BFB7;
        %Set16bit(!MX)                             ;8099D5;      ;
        LDA.L $7F1F5E                        ;8099D7;7F1F5E;
        AND.W #$0002                         ;8099DB;      ;
        BNE CODE_8099E4                      ;8099DE;8099E4;
        JSL.L CODE_83C296                    ;8099E0;83C296;
                                            ;      ;      ;
        CODE_8099E4:
        %Set16bit(!MX)                             ;8099E4;      ;
        LDA.W #$0000                         ;8099E6;      ;
        STA.B !player_action                            ;8099E9;0000D4;
        JSL.L UNK_Audio21                    ;8099EB;83841F;
        JSL.L UNK_Audio20                    ;8099EF;8383A4;
        JSL.L UNK_Audio22                    ;8099F3;838380;
        JSL.L SUB_828FF3                          ;8099F7;828FF3;
        %Set8bit(!M)                             ;8099FB;      ;
        LDA.W $0110                          ;8099FD;000110;
        STA.W $0117                          ;809A00;000117;
        JSL.L WaitForNMI               ;809A03;808645;
        %Set16bit(!M)                             ;809A07;      ;
        LDA.W #$1800                         ;809A09;      ;
        STA.B $C7                            ;809A0C;0000C7;
        JSL.L BAAAA                          ;809A0E;81A383;
        JSL.L CODE_84816F                    ;809A12;84816F;
        JSL.L CODE_8582C7                    ;809A16;8582C7;
        JSL.L CODE_858CB2                    ;809A1A;858CB2;
        JSL.L UNK_BigLoadLoopOAM             ;809A1E;8583E0;
        %Set8bit(!M)                             ;809A22;      ;
        STZ.B !NMI_Status                            ;809A24;000000;
        JSL.L WaitForNMI               ;809A26;808645;
        %Set16bit(!M)                             ;809A2A;      ;
        LDA.W #$1800                         ;809A2C;      ;
        STA.B $C7                            ;809A2F;0000C7;
        JSL.L BAAAA                          ;809A31;81A383;
        JSL.L CODE_84816F                    ;809A35;84816F;
        JSL.L CODE_8582C7                    ;809A39;8582C7;
        JSL.L CODE_858CB2                    ;809A3D;858CB2;
        JSL.L UNK_BigLoadLoopOAM             ;809A41;8583E0;
        %Set8bit(!M)                             ;809A45;      ;
        STZ.B !NMI_Status                            ;809A47;000000;
        JSL.L WaitForNMI               ;809A49;808645;
        JSL.L ResetForceBlank                ;809A4D;808E1E;
        %Set8bit(!M)                             ;809A51;      ;
        LDA.B #$03                           ;809A53;      ;
        STA.B $92                            ;809A55;000092;
        LDA.B #$03                           ;809A57;      ;
        STA.B $93                            ;809A59;000093;
        LDA.B #$0F                           ;809A5B;      ;
        STA.B $94                            ;809A5D;000094;
        JSL.L ScreenFadein                         ;809A5F;8087CE;
        RTL                                  ;809A63;      ;END_SUB_80972C

;;;;;;;; Related to Transition?
SUB_809A64: ;809A64
        %Set16bit(!MX)
        LDA.W $0878
        CMP.W #192;C0
        BCS .aboveC0_1
        JMP.W .return

    .aboveC0_1:
        CMP.W #208;D0
        BCC .belowD0_1
        JMP.W SUB_809D0B

    .belowD0_1:
        LDA.W $087A
        CMP.W #192;C0
        BCS .aboveC0_2
        JMP.W .return

    .aboveC0_2:
        CMP.W #208;D0
        BCC .belowD0_2
        JMP.W SUB_809D0B

    .belowD0_2:
        %Set16bit(!MX)
        LDA.B !game_state
        AND.W #$0010                         ;FLAGD2
        BEQ .continue
        JMP.W .return

    .continue:
        %Set16bit(!M)
        LDA.L $7F1F60
        AND.W #$0006                         ;FLAG60
        BEQ .continue6
        JMP.W .return

    .continue6:
        %Set16bit(!M)
        LDA.L $7F1F6C
        AND.W #$0001
        BEQ .skip1
        %Set16bit(!M)
        LDA.W $0878
        ASL A
        ASL A
        TAY                                  ;*4
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B [$0D],Y
        %Set16bit(!M)
        ASL A
        ASL A
        ASL A
        TAX
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        CMP.B #$1C
        BNE .skip1
        JMP.W .return

    .skip1:
        %Set16bit(!MX)
        LDA.W #$0000
        STA.B !player_action
        %Set16bit(!MX)
        LDA.B !game_state
        ORA.W #$0080                         ;FLAGD2 Carring dog
        STA.B !game_state
        %Set8bit(!M)
        LDA.W $098A
        CMP.B #$01
        BNE .CODE_809AEF
        JMP.W .CODE_809C5D

    .CODE_809AEF:
        CMP.B #$02
        BCC .CODE_809AF6
        JMP.W .CODE_809C67

    .CODE_809AF6:
        INC A
        STA.W $098A
        %Set16bit(!M)
        LDA.W $0878
        ASL A
        ASL A
        TAY
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B [$0D],Y
        %Set16bit(!M)
        ASL A
        ASL A
        ASL A
        TAX
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        STA.W !transition_dest
        INX
        INX
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        STA.B $92
        INX
        LDA.L Unk_Table13,X
        AND.B #$01
        BEQ .CODE_809B36
        LDA.W !transition_dest
        CLC
        ADC.L !season
        STA.W !transition_dest

    .CODE_809B36:
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        AND.B #$40
        BEQ .CODE_809B7D
        LDA.L !day
        CMP.B #$01
        BEQ .CODE_809B5F
        CMP.B #$18
        BEQ .CODE_809B6E
        CMP.B #$0A
        BCC .CODE_809B7D
        CMP.B #$0D
        BCS .CODE_809B7D
        LDA.W !transition_dest
        CLC
        ADC.B #$04
        STA.W !transition_dest
        BRA .CODE_809B7D

    .CODE_809B5F:
        %Set8bit(!M)
        LDA.L !season
        BNE .CODE_809B7D
        LDA.B #$3A
        STA.W !transition_dest
        BRA .CODE_809B7D

    .CODE_809B6E:
        %Set8bit(!M)
        LDA.L !season
        CMP.B #$03
        BNE .CODE_809B7D
        LDA.B #$39
        STA.W !transition_dest

    .CODE_809B7D:
        %Set8bit(!M)
        LDA.B !tilemap_to_load
        CMP.B #$0B
        BNE .CODE_809B88
        JMP.W .CODE_809C14

    .CODE_809B88:
        LDA.L Unk_Table13,X
        AND.B #$02
        BEQ .CODE_809B9A
        LDA.L !hour
        CMP.B #$11
        BCC .CODE_809B9A
        BRA .CODE_809C14

    .CODE_809B9A:
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        AND.B #$04
        BEQ .CODE_809BAE
        LDA.L !hour
        CMP.B #$11
        BCS .CODE_809BAE
        BRA .CODE_809C14

    .CODE_809BAE:
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        AND.B #$08
        BEQ .CODE_809BC4
        LDA.L !weekday
        BEQ .CODE_809BC4
        CMP.B #$06
        BEQ .CODE_809BC4
        BRA .CODE_809C14

    .CODE_809BC4:
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        AND.B #$10
        BEQ .CODE_809BEC
        LDA.L !season
        CMP.B #$03
        BNE .CODE_809BE0
        LDA.L !day
        CMP.B #$0A
        BNE .CODE_809BE0
        BRA .CODE_809C14

    .CODE_809BE0:
        %Set8bit(!M)
        LDA.L !weekday
        CMP.B #$06
        BNE .CODE_809BEC
        BRA .CODE_809C14

    .CODE_809BEC:
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        AND.B #$20
        BEQ .CODE_809BFE
        LDA.L !weekday
        BNE .CODE_809BFE
        BRA .CODE_809C14

    .CODE_809BFE:
        %Set8bit(!M)
        LDA.L Unk_Table13,X
        AND.B #$80
        BEQ .CODE_809C30
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$0010
        BEQ .CODE_809C30
        BRA .CODE_809C14

    .CODE_809C14:
        %Set16bit(!MX)
        LDA.W #$0080
        EOR.W #$FFFF
        AND.B !game_state
        STA.B !game_state
        %Set16bit(!M)
        STZ.W $0878
        STZ.W $087A
        %Set8bit(!M)
        STZ.W $098A
        JMP.W .return

    .CODE_809C30:
        %Set8bit(!M)
        STZ.W !time_running
        INX
        %Set16bit(!M)
        LDA.L Unk_Table13,X
        STA.W !transition_dest_X
        INX
        INX
        LDA.L Unk_Table13,X
        STA.W !transition_dest_Y
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.B $92
        CMP.B #$00
        BNE .CODE_809C56
        JMP.W .return

    .CODE_809C56:
        JSL.L CODE_81A5E1
        JMP.W .return

    .CODE_809C5D:
        %Set16bit(!M)
        LDA.W $00CF
        BEQ .CODE_809C67
        JMP.W .return

    .CODE_809C67:
        %Set8bit(!M)
        LDA.W $098A
        CMP.B #$0D
        BEQ .CODE_809CD3
        INC A
        STA.W $098A
        %Set16bit(!MX)
        LDA.W #$0001
        STA.B !player_action
        %Set16bit(!M)
        LDA.B !player_direction
        CMP.W #$0000
        BEQ .CODE_809CA0
        CMP.W #$0001
        BEQ .CODE_809CB1
        CMP.W #$0002
        BEQ .CODE_809CC2
        %Set16bit(!MX)
        LDA.W #$0003
        STA.B !player_direction
        %Set16bit(!MX)
        LDA.W #$0003
        STA.W $0911
        JMP.W .return

    .CODE_809CA0:
        %Set16bit(!MX)
        LDA.W #$0000
        STA.B !player_direction
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $0911
        BRA .return

    .CODE_809CB1:
        %Set16bit(!MX)                             ;809CB1;      ;
        LDA.W #$0001                         ;809CB3;      ;
        STA.B !player_direction                            ;809CB6;0000DA;
        %Set16bit(!MX)                             ;809CB8;      ;
        LDA.W #$0001                         ;809CBA;      ;
        STA.W $0911                          ;809CBD;000911;
        BRA .return                          ;809CC0;809D0A;

    .CODE_809CC2:
        %Set16bit(!MX)                             ;809CC2;      ;
        LDA.W #$0002                         ;809CC4;      ;
        STA.B !player_direction                            ;809CC7;0000DA;
        %Set16bit(!MX)                             ;809CC9;      ;
        LDA.W #$0002                         ;809CCB;      ;
        STA.W $0911                          ;809CCE;000911;
        BRA .return                          ;809CD1;809D0A;

    .CODE_809CD3:
        %Set8bit(!M)                             ;809CD3;      ;
        LDA.W $0022                          ;809CD5;000022;
        CMP.B #$04                           ;809CD8;      ;
        BCS .CODE_809CE0                      ;809CDA;809CE0;
        JSL.L CopyCurrentMaptoFarmMap                          ;809CDC;82A682;

    .CODE_809CE0:
        %Set8bit(!M)                             ;809CE0;      ;
        LDA.B !tilemap_to_load                            ;809CE2;000022;
        CMP.B #$0C                           ;809CE4;      ;
        BCC .CODE_809CFF                      ;809CE6;809CFF;
        LDA.B !tilemap_to_load                            ;809CE8;000022;
        CMP.B #$10                           ;809CEA;      ;
        BCS .CODE_809CFF                      ;809CEC;809CFF;
        LDA.L !hour                        ;809CEE;7F1F1C;
        CMP.B #$12                           ;809CF2;      ;
        BEQ .CODE_809CFF                      ;809CF4;809CFF;
        INC A                                ;809CF6;      ;
        STA.L !hour                        ;809CF7;7F1F1C;
        JSL.L HaveLunch                          ;809CFB;8280AA;

    .CODE_809CFF:
        %Set16bit(!MX)                             ;809CFF;      ;
        LDA.W $0196                          ;809D01;000196;
        ORA.W #$4000                         ;809D04;      ;
        STA.W $0196                          ;809D07;000196;Stores to 196

    .return: RTL                                  ;809D0A;      ;END_SUB_809A64

;;;;;;;;
SUB_809D0B: ;809D0B
        %Set8bit(!M)                             ;      ;
        %Set16bit(!X)                             ;809D0D;      ;
        LDA.B !tilemap_to_load                            ;809D0F;000022;
        CMP.B #$04                           ;809D11;      ;
        BCS CODE_809D18                      ;809D13;809D18;
        JMP.W $9EBB                          ;809D15;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D18: %Set8bit(!M)                             ;809D18;      ;
        LDA.B !tilemap_to_load                            ;809D1A;000022;
        CMP.B #$10                           ;809D1C;      ;
        BCS CODE_809D23                      ;809D1E;809D23;
        JMP.W $9EBB                          ;809D20;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D23:
        CMP.B #$14                           ;809D23;      ;
        BCC CODE_809D2A                      ;809D25;809D2A;
        JMP.W $9EBB                          ;809D27;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D2A:
        %Set16bit(!MX)                             ;809D2A;      ;
        LDA.W $0196                          ;809D2C;000196;
        AND.W #$001A                         ;809D2F;      ;
        BEQ CODE_809D37                      ;809D32;809D37;
        JMP.W $9EBB                          ;809D34;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D37:
        LDA.W $0878                          ;809D37;000878;
        CMP.W #$00F9                         ;809D3A;      ;
        BNE CODE_809D42                      ;809D3D;809D42;
        JMP.W CODE_809DFD                    ;809D3F;809DFD;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D42:
        LDA.W $087A                          ;809D42;00087A;
        CMP.W #$00F9                         ;809D45;      ;
        BNE CODE_809D4D                      ;809D48;809D4D;
        JMP.W CODE_809DFD                    ;809D4A;809DFD;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D4D:
        LDA.W $0878                          ;809D4D;000878;
        CMP.W #$00FA                         ;809D50;      ;
        BNE CODE_809D58                      ;809D53;809D58;
        JMP.W CODE_809E3F                    ;809D55;809E3F;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D58:
        LDA.W $087A                          ;809D58;00087A;
        CMP.W #$00FA                         ;809D5B;      ;
        BNE CODE_809D63                      ;809D5E;809D63;
        JMP.W CODE_809E3F                    ;809D60;809E3F;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D63:
        LDA.W $0878                          ;809D63;000878;
        CMP.W #$00FB                         ;809D66;      ;
        BNE CODE_809D6E                      ;809D69;809D6E;
        JMP.W CODE_809E7D                    ;809D6B;809E7D;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D6E:
        LDA.W $087A                          ;809D6E;00087A;
        CMP.W #$00FB                         ;809D71;      ;
        BNE CODE_809D79                      ;809D74;809D79;
        JMP.W CODE_809E7D                    ;809D76;809E7D;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D79:
        %Set16bit(!M)                             ;809D79;      ;
        LDA.L $7F1F5A                        ;809D7B;7F1F5A;
        AND.W #$0200                         ;FLAG5A
        BNE CODE_809D87                      ;809D82;809D87;
        JMP.W $9EBB                          ;809D84;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D87:
        %Set16bit(!MX)                             ;809D87;      ;
        LDA.B !game_state                            ;809D89;0000D2;
        AND.W #$0002                         ;809D8B;      ;
        BEQ CODE_809D93                      ;809D8E;809D93;
        JMP.W $9EBB                          ;809D90;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D93:
        %Set16bit(!MX)                             ;809D93;      ;
        LDA.B !game_state                            ;809D95;0000D2;
        AND.W #$0010                         ;809D97;      ;
        BEQ CODE_809D9F                      ;809D9A;809D9F;
        JMP.W $9EBB                          ;809D9C;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809D9F:
        %Set16bit(!MX)                             ;809D9F;      ;
        LDA.B !game_state                            ;809DA1;0000D2;
        AND.W #$0800                         ;809DA3;      ;
        BEQ CODE_809DAB                      ;809DA6;809DAB;
        JMP.W $9EBB                          ;809DA8;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DAB:
        %Set16bit(!M)                             ;809DAB;      ;
        LDA.W $0878                          ;809DAD;000878;
        CMP.W #$00F8                         ;809DB0;      ;
        BEQ CODE_809DB8                      ;809DB3;809DB8;
        JMP.W $9EBB                          ;809DB5;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DB8:
        LDA.W $087A                          ;809DB8;00087A;
        CMP.W #$00F8                         ;809DBB;      ;
        BEQ CODE_809DC3                      ;809DBE;809DC3;
        JMP.W $9EBB                          ;809DC0;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DC3:
        %Set16bit(!MX)                             ;809DC3;      ;
        LDA.B !player_action                            ;809DC5;0000D4;
        CMP.W #$0010                         ;809DC7;      ;
        BNE CODE_809DCF                      ;809DCA;809DCF;
        JMP.W $9EBB                          ;809DCC;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DCF:
        %Set16bit(!MX)                             ;809DCF;      ;
        LDA.B !player_action                            ;809DD1;0000D4;
        CMP.W #$0011                         ;809DD3;      ;
        BNE CODE_809DDB                      ;809DD6;809DDB;
        JMP.W $9EBB                          ;809DD8;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DDB:
        %Set16bit(!MX)                             ;809DDB;      ;
        LDA.B !player_action                            ;809DDD;0000D4;
        CMP.W #$0012                         ;809DDF;      ;
        BNE CODE_809DE7                      ;809DE2;809DE7;
        JMP.W $9EBB                          ;809DE4;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DE7:
        %Set16bit(!MX)                             ;809DE7;      ;
        LDA.B !player_action                            ;809DE9;0000D4;
        CMP.W #$0013                         ;809DEB;      ;
        BNE CODE_809DF3                      ;809DEE;809DF3;
        JMP.W $9EBB                          ;809DF0;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DF3:
        %Set16bit(!MX)                             ;809DF3;      ;
        LDA.W #$000F                         ;809DF5;      ;
        STA.B !player_action                            ;809DF8;0000D4;
        JMP.W $9EBB                          ;809DFA;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809DFD:
        %Set8bit(!M)                             ;809DFD;      ;
        %Set16bit(!X)                             ;809DFF;      ;
        LDA.L !season                        ;809E01;7F1F19;
        BEQ CODE_809E0A                      ;809E05;809E0A;
        JMP.W $9EBB                          ;809E07;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E0A:
        LDA.B #$10                           ;809E0A;      ;
        JSL.L RNGReturn0toA                  ;809E0C;8089F9;
        BEQ CODE_809E15                      ;809E10;809E15;
        JMP.W $9EBB                          ;809E12;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E15:
        %Set16bit(!M)                             ;809E15;      ;
        LDA.L $7F1F5C                        ;809E17;7F1F5C;
        AND.W #$2000                         ;809E1B;      ;
        BEQ CODE_809E23                      ;809E1E;809E23;
        JMP.W $9EBB                          ;809E20;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E23:
        LDA.L $7F1F5C                        ;809E23;7F1F5C;
        ORA.W #$2000                         ;809E27;      ;
        STA.L $7F1F5C                        ;809E2A;7F1F5C;
        %Set16bit(!MX)                             ;809E2E;      ;
        LDA.W #$0011                         ;809E30;      ;
        LDX.W #$002C                         ;809E33;      ;
        LDY.W #$0000                         ;809E36;      ;
        JSL.L VIP                            ;809E39;848097;
        BRA $7C                              ;809E3D;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E3F:
        %Set8bit(!M)                             ;809E3F;      ;
        %Set16bit(!X)                             ;809E41;      ;
        LDA.L !season                        ;809E43;7F1F19;
        CMP.B #$02                           ;809E47;      ;
        BNE $70                              ;809E49;809EBB;
        LDA.B #$10                           ;809E4B;      ;
        JSL.L RNGReturn0toA                  ;809E4D;8089F9;
        BEQ CODE_809E56                      ;809E51;809E56;
        JMP.W $9EBB                          ;809E53;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E56:
        %Set16bit(!M)                             ;809E56;      ;
        LDA.L $7F1F5C                        ;809E58;7F1F5C;
        AND.W #$4000                         ;809E5C;      ;
        BNE $5A                              ;809E5F;809EBB;
        LDA.L $7F1F5C                        ;809E61;7F1F5C;
        ORA.W #$4000                         ;809E65;      ;
        STA.L $7F1F5C                        ;809E68;7F1F5C;
        %Set16bit(!MX)                             ;809E6C;      ;
        LDA.W #$0013                         ;809E6E;      ;
        LDX.W #$002B                         ;809E71;      ;
        LDY.W #$0000                         ;809E74;      ;
        JSL.L VIP                            ;809E77;848097;
        BRA $3E                              ;809E7B;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E7D:
        %Set8bit(!M)                             ;809E7D;      ;
        %Set16bit(!X)                             ;809E7F;      ;
        LDA.L !season                        ;809E81;7F1F19;
        CMP.B #$03                           ;809E85;      ;
        BNE !ProgDMA_Destination_Addr_Table                               ;809E87;809EBB;
        LDA.B #$10                           ;809E89;      ;
        JSL.L RNGReturn0toA                  ;809E8B;8089F9;
        BEQ CODE_809E94                      ;809E8F;809E94;
        JMP.W $9EBB                          ;809E91;809EBB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_809E94:
        %Set16bit(!M)                             ;809E94;      ;
        LDA.L $7F1F5C                        ;809E96;7F1F5C;
        AND.W #$8000                         ;809E9A;      ;
        BNE $1C                              ;809E9D;809EBB;
        LDA.L $7F1F5C                        ;809E9F;7F1F5C;
        ORA.W #$8000                         ;809EA3;      ;
        STA.L $7F1F5C                        ;809EA6;7F1F5C;
        %Set16bit(!MX)                             ;809EAA;      ;
        LDA.W #$0012                         ;809EAC;      ;
        LDX.W #$002A                         ;809EAF;      ;
        LDY.W #$0000                         ;809EB2;      ;
        JSL.L VIP                            ;809EB5;848097;
        BRA !NMI_Status                              ;809EB9;809EBB;
                                            ;      ;      ;
        RTL                                  ;809EBB;      ;END_SUB_809D0B

;;;;;;;; I think this moves the BGs and OBJs offsets to the right position when changing screens
SUB_809EBC: ;809EBC
        %Set16bit(!MX)
        LDA.B !player_pos_X
        SEC
        SBC.W #$0080                         ;128
        CMP.B !OBJ_clamp_left
        BMI .movableposx
        BEQ .movableposx
        BCS .fixedposx

    .movableposx:
        %Set16bit(!M)
        CLC
        ADC.W #$0080                         ;restore the 128
        SEC
        SBC.B !OBJ_clamp_left
        STA.W $090B
        %Set8bit(!M)
        LDA.B #$00
        STA.B !BG_subpixel_offset_X
        %Set16bit(!M)
        LDA.B !OBJ_clamp_left
        STA.B !OBJ_Offset_X
        BRA .ycoordinate

    .fixedposx:
        %Set16bit(!M)
        CMP.B !OBJ_clamp_right
        BCS .adjustsubpixelx                 ;Too close to the left wall
        STA.B !OBJ_Offset_X
        LDA.W #$0080
        STA.W $090B
        BRA .ycoordinate

    .adjustsubpixelx:
        %Set16bit(!M)
        CLC
        ADC.W #$0080
        SEC
        SBC.B !OBJ_clamp_right
        STA.W $090B
        %Set8bit(!M)
        LDA.B #$08
        STA.B !BG_subpixel_offset_X
        %Set16bit(!M)
        LDA.B !OBJ_clamp_right
        STA.B !OBJ_Offset_X

    .ycoordinate:
        %Set16bit(!M)
        LDA.B !player_pos_Y
        SEC
        SBC.W #$0080
        CMP.B !OBJ_clamp_up
        BMI .movableposy
        BEQ .movableposy
        BCS .fixedposy

    .movableposy:
        %Set16bit(!M)
        CLC
        ADC.W #$0080
        SEC
        SBC.B !OBJ_clamp_up
        STA.W $090D
        %Set8bit(!M)
        LDA.B #$00
        STA.B !BG_subpixel_offset_Y
        %Set16bit(!M)
        LDA.B !OBJ_clamp_up
        STA.B !OBJ_Offset_Y
        BRA .return

    .fixedposy:
        %Set16bit(!M)
        CMP.B !OBJ_clamp_down
        BCS .adjustsubpixely

        STA.B !OBJ_Offset_Y
        LDA.W #$0080
        STA.W $090D
        BRA .return

    .adjustsubpixely:
        %Set16bit(!M)
        CLC
        ADC.W #$0080
        SEC
        SBC.B !OBJ_clamp_down
        STA.W $090D
        %Set8bit(!M)
        LDA.B #$08
        STA.B !BG_subpixel_offset_Y
        %Set16bit(!M)
        LDA.B !OBJ_clamp_down
        STA.B !OBJ_Offset_Y

    .return: RTL

;;;;;;;; I think this checks for map scrolling in locked places, like tool shed
SUB_809F61: ;809F61
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !tilemap_to_load
        CMP.B #$26                           ;Tool Shed
        BNE +
        JMP.W .return

      + CMP.B #$31
        BCC .CODE_809FB3                     ;MapSummitSpring?

        %Set16bit(!M)
        LDA.B !OBJ_Offset_Y
        CMP.B !OBJ_clamp_up
        BNE .CODE_809F7D
        JMP.W .return

    .CODE_809F7D:
        CMP.B !OBJ_clamp_down
        BNE .CODE_809F84
        JMP.W .return

    .CODE_809F84:
        LDA.B !OBJ_Offset_X
        STA.W !BG2_Map_Offset_X
        LDA.B $1E
        ASL A
        STA.B $1E
        %Set16bit(!MX)
        LDA.B !player_direction
        CMP.W #$0002                         ;left
        BNE .CODE_809F9A
        JMP.W .return

    .CODE_809F9A:
        %Set16bit(!MX)
        LDA.B !player_direction
        CMP.W #$0003                         ;Right
        BNE .CODE_809FA6
        JMP.W .return

    .CODE_809FA6:
        LDA.B !OBJ_Offset_Y
        LSR A
        CLC
        ADC.W #$0080
        STA.W !BG2_Map_Offset_Y
        JMP.W .return

    .CODE_809FB3:
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$0002                         ;FLAG196 not raining???
        BEQ .CODE_809FCA
        LDA.B !OBJ_Offset_X
        STA.W !BG2_Map_Offset_X
        LDA.B !OBJ_Offset_Y
        STA.W !BG2_Map_Offset_Y
        JMP.W .return

    .CODE_809FCA:
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$0004                         ;FLAG196 Sunny
        BNE .CODE_809FD7
        JMP.W .CODE_80A096

    .CODE_809FD7:
        %Set16bit(!MX)
        LDA.B !player_direction
        CMP.W #$0000                         ;down
        BNE .CODE_809FE3
        JMP.W .CODE_80A033

    .CODE_809FE3:
        %Set16bit(!MX)
        LDA.B !player_direction
        CMP.W #$0001                         ;up
        BNE .CODE_809FEF
        JMP.W .CODE_80A04A

    .CODE_809FEF:
        %Set16bit(!MX)
        LDA.B !player_direction
        CMP.W #$0002                         ;left
        BNE .CODE_809FFB
        JMP.W .CODE_80A061

    .CODE_809FFB:
        %Set16bit(!MX)
        LDA.B !player_direction
        CMP.W #$0003                         ;right
        BNE .CODE_80A007
        JMP.W .CODE_80A078

    .CODE_80A007:
        %Set8bit(!M)
        LDA.W $091C
        INC A
        STA.W $091C
        CMP.B #$0A
        BEQ .CODE_80A017
        JMP.W .return

    .CODE_80A017:
        STZ.W $091C
        %Set16bit(!M)
        LDA.W !BG2_Map_Offset_X
        CLC
        ADC.W #$0001
        STA.W !BG2_Map_Offset_X
        LDA.W !BG2_Map_Offset_Y
        SEC
        SBC.W #$0001
        STA.W !BG2_Map_Offset_Y
        JMP.W .return

    .CODE_80A033:
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_Y
        CMP.B !OBJ_clamp_up
        BEQ .CODE_80A007
        CMP.B !OBJ_clamp_down
        BEQ .CODE_80A007
        LDA.W !BG2_Map_Offset_Y
        CLC
        ADC.B $1E
        STA.W !BG2_Map_Offset_Y
        BRA .CODE_80A007

    .CODE_80A04A:
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_Y
        CMP.B !OBJ_clamp_up
        BEQ .CODE_80A007
        CMP.B !OBJ_clamp_down
        BEQ .CODE_80A007
        LDA.W !BG2_Map_Offset_Y
        SEC
        SBC.B $1E
        STA.W !BG2_Map_Offset_Y
        BRA .CODE_80A007

    .CODE_80A061:
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_X
        CMP.B !OBJ_clamp_left
        BEQ .CODE_80A007
        CMP.B !OBJ_clamp_right
        BEQ .CODE_80A007
        LDA.W !BG2_Map_Offset_X
        CLC
        ADC.B $1E
        STA.W !BG2_Map_Offset_X
        BRA .CODE_80A007

    .CODE_80A078:
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_X
        CMP.B !OBJ_clamp_left
        BNE .CODE_80A083
        JMP.W .CODE_80A007

    .CODE_80A083:
        CMP.B !OBJ_clamp_right
        BNE .CODE_80A08A
        JMP.W .CODE_80A007
    .CODE_80A08A:
        LDA.W !BG2_Map_Offset_X
        SEC
        SBC.B $1E
        STA.W !BG2_Map_Offset_X
        JMP.W .CODE_80A007

    .CODE_80A096:
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$0008
        BEQ .return
        LDA.B !OBJ_Offset_X
        STA.W !BG2_Map_Offset_X
        LDA.B !OBJ_Offset_Y
        STA.W !BG2_Map_Offset_Y

    .return: RTL

;;;;;;;;
UpdateBGOffset: ;80A0AB
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_Y
        STA.W !BG1_Map_Offset_Y
        CMP.B !OBJ_clamp_up
        BEQ .return
        CMP.B !OBJ_clamp_down
        BEQ .return
        CMP.B $1E
        BCS .bigger
        STA.B $1E

    .bigger:
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$0001
        BEQ .return
        %Set8bit(!M)
        LDA.B !BG_subpixel_offset_Y
        CLC
        ADC.B $1E
        STA.B !BG_subpixel_offset_Y
        CMP.B #$08
        BCC .return
        SEC
        SBC.B #$08
        STA.B !BG_subpixel_offset_Y
        JSL.L SUB_80A18D

    .return: RTL

;;;;;;;;
SUB_80A0E1: ;80A0E1
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_Y
        STA.W !BG1_Map_Offset_Y
        CMP.B !OBJ_clamp_up
        BEQ $2F
        CMP.B !OBJ_clamp_down
        BEQ $2B
        LDA.B !OBJ_clamp_down
        SEC
        SBC.B !OBJ_Offset_Y
        CMP.B $1E
        BCS .CODE_80A0FB
        STA.B $1E

    .CODE_80A0FB:
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$0001
        BEQ $16
        %Set8bit(!M)
        LDA.B !BG_subpixel_offset_Y
        SEC
        SBC.B $1E
        STA.B !BG_subpixel_offset_Y
        BPL $0B
        LDA.B #$08
        CLC
        ADC.B !BG_subpixel_offset_Y
        STA.B !BG_subpixel_offset_Y
        JSL.L SUB_80A308
        RTL

;;;;;;;;
UNK_StaticMapScroling: ;80A11C
        %Set16bit(!MX)
        LDA.B !OBJ_Offset_X
        STA.W !BG1_Map_Offset_X
        CMP.B !OBJ_clamp_left
        BEQ .return
        CMP.B !OBJ_clamp_right
        BEQ .return
        CMP.B $1E
        BCS .CODE_80A131
        STA.B $1E

    .CODE_80A131:
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$0001                         ;FLAG196 Fair climate?
        BEQ .return
        %Set8bit(!M)
        LDA.B !BG_subpixel_offset_X
        CLC
        ADC.B $1E
        STA.B !BG_subpixel_offset_X
        CMP.B #$08
        BCC .return
        SEC
        SBC.B #$08
        STA.B !BG_subpixel_offset_X
        JSL.L SUB_80A481
                                            ;      ;      ;
        .return: RTL                                  ;80A151;      ;END_ASSSS

;;;;;;;;
SUB_80A152: ;80A152
        %Set16bit(!MX)                             ;      ;
        LDA.B !OBJ_Offset_X                            ;80A154;0000F5;
        STA.W !BG1_Map_Offset_X                          ;80A156;00013C;
        CMP.B !OBJ_clamp_left                            ;80A159;0000ED;
        BEQ CODE_80A18C                      ;80A15B;80A18C;
        CMP.B !OBJ_clamp_right                            ;80A15D;0000F1;
        BEQ CODE_80A18C                      ;80A15F;80A18C;
        LDA.B !OBJ_clamp_right                            ;80A161;0000F1;
        SEC                                  ;80A163;      ;
        SBC.B !OBJ_Offset_X                            ;80A164;0000F5;
        CMP.B $1E                            ;80A166;00001E;
        BCS CODE_80A16C                      ;80A168;80A16C;
        STA.B $1E                            ;80A16A;00001E;
                                            ;      ;      ;
        CODE_80A16C: %Set16bit(!M)                             ;80A16C;      ;
        LDA.W $0196                          ;80A16E;000196;
        AND.W #$0001                         ;80A171;      ;
        BEQ CODE_80A18C                      ;80A174;80A18C;
        %Set8bit(!M)                             ;80A176;      ;
        LDA.B !BG_subpixel_offset_X                            ;80A178;000020;
        SEC                                  ;80A17A;      ;
        SBC.B $1E                            ;80A17B;00001E;
        STA.B !BG_subpixel_offset_X                            ;80A17D;000020;
        BPL CODE_80A18C                      ;80A17F;80A18C;
        LDA.B #$08                           ;80A181;      ;
        CLC                                  ;80A183;      ;
        ADC.B !BG_subpixel_offset_X                            ;80A184;000020;
        STA.B !BG_subpixel_offset_X                            ;80A186;000020;
        JSL.L SUB_80A617                    ;80A188;80A617;
                                            ;      ;      ;
        CODE_80A18C: RTL                                  ;80A18C;      ;END_SUB_80A152

;;;;;;;;
SUB_80A18D: ;80A18D
        %Set16bit(!MX)                             ;      ;Some data copying?
        LDA.B $12                            ;80A18F;000012;
        CMP.W #$0020                         ;80A191;      ;
        BCC CODE_80A1B1                      ;80A194;80A1B1;
        CMP.W #$0040                         ;80A196;      ;
        BCC CODE_80A1BB                      ;80A199;80A1BB;
        CMP.W #$0060                         ;80A19B;      ;
        BCC CODE_80A1CB                      ;80A19E;80A1CB;
        CMP.W #$0080                         ;80A1A0;      ;
        BCC CODE_80A1DB                      ;80A1A3;80A1DB;
        CMP.W #$00A0                         ;80A1A5;      ;
        BCC CODE_80A1EE                      ;80A1A8;80A1EE;
        CMP.W #$00C0                         ;80A1AA;      ;
        BCC CODE_80A201                      ;80A1AD;80A201;
        BRA CODE_80A21A                      ;80A1AF;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A1B1:
        STZ.B $7E                            ;80A1B1;00007E;
        STZ.B $80                            ;80A1B3;000080;
        STZ.B $82                            ;80A1B5;000082;
        STZ.B $84                            ;80A1B7;000084;
        BRA CODE_80A21A                      ;80A1B9;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A1BB:
        LDA.B $12                            ;80A1BB;000012;
        SEC                                  ;80A1BD;      ;
        SBC.W #$0020                         ;80A1BE;      ;
        STA.B $7E                            ;80A1C1;00007E;
        STA.B $80                            ;80A1C3;000080;
        STZ.B $82                            ;80A1C5;000082;
        STZ.B $84                            ;80A1C7;000084;
        BRA CODE_80A21A                      ;80A1C9;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A1CB:
        LDA.B $12                            ;80A1CB;000012;
        SEC                                  ;80A1CD;      ;
        SBC.W #$0020                         ;80A1CE;      ;
        STA.B $7E                            ;80A1D1;00007E;
        STA.B $80                            ;80A1D3;000080;
        STZ.B $82                            ;80A1D5;000082;
        STZ.B $84                            ;80A1D7;000084;
        BRA CODE_80A21A                      ;80A1D9;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A1DB:
        LDA.W #$0080                         ;80A1DB;      ;
        STA.B $7E                            ;80A1DE;00007E;
        STZ.B $80                            ;80A1E0;000080;
        LDA.B $12                            ;80A1E2;000012;
        SEC                                  ;80A1E4;      ;
        SBC.W #$0060                         ;80A1E5;      ;
        STA.B $82                            ;80A1E8;000082;
        STA.B $84                            ;80A1EA;000084;
        BRA CODE_80A21A                      ;80A1EC;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A1EE:
        LDA.W #$0080                         ;80A1EE;      ;
        STA.B $7E                            ;80A1F1;00007E;
        STZ.B $80                            ;80A1F3;000080;
        LDA.B $12                            ;80A1F5;000012;
        SEC                                  ;80A1F7;      ;
        SBC.W #$0060                         ;80A1F8;      ;
        STA.B $82                            ;80A1FB;000082;
        STA.B $84                            ;80A1FD;000084;
        BRA CODE_80A21A                      ;80A1FF;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A201:
        LDA.B $12                            ;80A201;000012;
        SEC                                  ;80A203;      ;
        SBC.W #$0020                         ;80A204;      ;
        STA.B $7E                            ;80A207;00007E;
        LDA.B $12                            ;80A209;000012;
        SEC                                  ;80A20B;      ;
        SBC.W #$00A0                         ;80A20C;      ;
        STA.B $80                            ;80A20F;000080;
        LDA.W #$0080                         ;80A211;      ;
        STA.B $82                            ;80A214;000082;
        STZ.B $84                            ;80A216;000084;
        BRA CODE_80A21A                      ;80A218;80A21A;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A21A:
        LDA.B $1C                            ;80A21A;00001C;
        LSR A                                ;80A21C;      ;
        LSR A                                ;80A21D;      ;
        STA.B $86                            ;80A21E;000086;
        LDA.W #$2000                         ;80A220;      ;
        CLC                                  ;80A223;      ;
        ADC.B $16                            ;80A224;000016;
        ADC.B $1C                            ;80A226;00001C;
        SEC                                  ;80A228;      ;
        SBC.B $86                            ;80A229;000086;
        STA.B $72                            ;80A22B;000072;
        CLC                                  ;80A22D;      ;
        ADC.W #$0040                         ;80A22E;      ;
        STA.B $75                            ;80A231;000075;
        %Set8bit(!M)                             ;80A233;      ;
        LDA.B #$7E                           ;80A235;      ;
        STA.B $74                            ;80A237;000074;
        STA.B $77                            ;80A239;000077;
        %Set16bit(!M)                             ;80A23B;      ;
        LDX.W #$0000                         ;80A23D;      ;
                                            ;      ;      ;
    CODE_80A240:
        PHX                                  ;80A240;      ;
        LDA.B $80                            ;80A241;000080;
        CMP.W #$0040                         ;80A243;      ;
        BNE CODE_80A252                      ;80A246;80A252;
        STZ.B $80                            ;80A248;000080;
        LDA.B $7E                            ;80A24A;00007E;
        CLC                                  ;80A24C;      ;
        ADC.W #$0040                         ;80A24D;      ;
        STA.B $7E                            ;80A250;00007E;
                                            ;      ;      ;
    CODE_80A252:
        LDA.B $84                            ;80A252;000084;
        CMP.W #$0040                         ;80A254;      ;
        BNE CODE_80A263                      ;80A257;80A263;
        STZ.B $84                            ;80A259;000084;
        LDA.B $82                            ;80A25B;000082;
        CLC                                  ;80A25D;      ;
        ADC.W #$0040                         ;80A25E;      ;
        STA.B $82                            ;80A261;000082;
                                            ;      ;      ;
    CODE_80A263:
        LDY.B $7E                            ;80A263;00007E;
        LDX.B $80                            ;80A265;000080;
        LDA.B [$72],Y                        ;80A267;000072;
        STA.W $0746,X                        ;80A269;000746;
        LDY.B $82                            ;80A26C;000082;
        LDX.B $84                            ;80A26E;000084;
        LDA.B [$75],Y                        ;80A270;000075;
        STA.W $07C6,X                        ;80A272;0007C6;
        INC.B $7E                            ;80A275;00007E;
        INC.B $7E                            ;80A277;00007E;
        INC.B $80                            ;80A279;000080;
        INC.B $80                            ;80A27B;000080;
        INC.B $82                            ;80A27D;000082;
        INC.B $82                            ;80A27F;000082;
        INC.B $84                            ;80A281;000084;
        INC.B $84                            ;80A283;000084;
        PLX                                  ;80A285;      ;
        INX                                  ;80A286;      ;
        INX                                  ;80A287;      ;
        CPX.W #$0040                         ;80A288;      ;
        BNE CODE_80A240                      ;80A28B;80A240;
        %Set8bit(!M)                             ;80A28D;      ;
        LDA.B #$00                           ;80A28F;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A291;000027;
        LDA.B #$18                           ;80A293;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A295;000029;
        %Set16bit(!M)                             ;80A297;      ;
        LDY.W #$0040                         ;80A299;      ;
        LDA.B $14                            ;80A29C;000014;
        CLC                                  ;80A29E;      ;
        ADC.W #$6000                         ;80A29F;      ;
        TAX                                  ;80A2A2;      ;
        LDA.W #$0746                         ;80A2A3;      ;
        STA.B $72                            ;80A2A6;000072;
        %Set8bit(!M)                             ;80A2A8;      ;
        LDA.B #$80                           ;80A2AA;      ;
        STA.B $74                            ;80A2AC;000074;
        %Set16bit(!M)                             ;80A2AE;      ;
        LDA.W #$0080                         ;80A2B0;      ;
        JSL.L AddProgrammedDMA                ;80A2B3;808A33;
        %Set8bit(!M)                             ;80A2B7;      ;
        LDA.B #$01                           ;80A2B9;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A2BB;000027;
        LDA.B #$18                           ;80A2BD;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A2BF;000029;
        %Set16bit(!M)                             ;80A2C1;      ;
        LDY.W #$0040                         ;80A2C3;      ;
        LDA.B $14                            ;80A2C6;000014;
        CLC                                  ;80A2C8;      ;
        ADC.W #$6000                         ;80A2C9;      ;
        ADC.W #$0400                         ;80A2CC;      ;
        TAX                                  ;80A2CF;      ;
        LDA.W #$07C6                         ;80A2D0;      ;
        STA.B $72                            ;80A2D3;000072;
        %Set8bit(!M)                             ;80A2D5;      ;
        LDA.B #$80                           ;80A2D7;      ;
        STA.B $74                            ;80A2D9;000074;
        %Set16bit(!M)                             ;80A2DB;      ;
        LDA.W #$0080                         ;80A2DD;      ;
        JSL.L AddProgrammedDMA                ;80A2E0;808A33;
        %Set16bit(!MX)                             ;80A2E4;      ;
        LDA.B $16                            ;80A2E6;000016;
        CLC                                  ;80A2E8;      ;
        ADC.B $1A                            ;80A2E9;00001A;
        STA.B $16                            ;80A2EB;000016;
        LDA.B $14                            ;80A2ED;000014;
        CLC                                  ;80A2EF;      ;
        ADC.W #$0020                         ;80A2F0;      ;
        CMP.W #$0400                         ;80A2F3;      ;
        BNE CODE_80A2FD                      ;80A2F6;80A2FD;
        LDA.W #$0800                         ;80A2F8;      ;
        BRA CODE_80A305                      ;80A2FB;80A305;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A2FD:
        CMP.W #$0C00                         ;80A2FD;      ;
        BNE CODE_80A305                      ;80A300;80A305;
        LDA.W #$0000                         ;80A302;      ;
                                            ;      ;      ;
    CODE_80A305:
        STA.B $14                            ;80A305;000014;
        RTL                                  ;80A307;      ;END_SUB_80A18D

;;;;;;;;
SUB_80A308: ;80A308
        %Set16bit(!MX)                             ;      ;
        LDA.B $12                            ;80A30A;000012;
        CMP.W #$0020                         ;80A30C;      ;
        BCC CODE_80A32C                      ;80A30F;80A32C;
        CMP.W #$0040                         ;80A311;      ;
        BCC CODE_80A336                      ;80A314;80A336;
        CMP.W #$0060                         ;80A316;      ;
        BCC CODE_80A346                      ;80A319;80A346;
        CMP.W #$0080                         ;80A31B;      ;
        BCC CODE_80A356                      ;80A31E;80A356;
        CMP.W #$00A0                         ;80A320;      ;
        BCC CODE_80A369                      ;80A323;80A369;
        CMP.W #$00C0                         ;80A325;      ;
        BCC CODE_80A37C                      ;80A328;80A37C;
        BRA CODE_80A395                      ;80A32A;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A32C:
        STZ.B $7E                            ;80A32C;00007E;
        STZ.B $80                            ;80A32E;000080;
        STZ.B $82                            ;80A330;000082;
        STZ.B $84                            ;80A332;000084;
        BRA CODE_80A395                      ;80A334;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A336:
        LDA.B $12                            ;80A336;000012;
        SEC                                  ;80A338;      ;
        SBC.W #$0020                         ;80A339;      ;
        STA.B $7E                            ;80A33C;00007E;
        STA.B $80                            ;80A33E;000080;
        STZ.B $82                            ;80A340;000082;
        STZ.B $84                            ;80A342;000084;
        BRA CODE_80A395                      ;80A344;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A346:
        LDA.B $12                            ;80A346;000012;
        SEC                                  ;80A348;      ;
        SBC.W #$0020                         ;80A349;      ;
        STA.B $7E                            ;80A34C;00007E;
        STA.B $80                            ;80A34E;000080;
        STZ.B $82                            ;80A350;000082;
        STZ.B $84                            ;80A352;000084;
        BRA CODE_80A395                      ;80A354;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A356:
        LDA.W #$0080                         ;80A356;      ;
        STA.B $7E                            ;80A359;00007E;
        STZ.B $80                            ;80A35B;000080;
        LDA.B $12                            ;80A35D;000012;
        SEC                                  ;80A35F;      ;
        SBC.W #$0060                         ;80A360;      ;
        STA.B $82                            ;80A363;000082;
        STA.B $84                            ;80A365;000084;
        BRA CODE_80A395                      ;80A367;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A369:
        LDA.W #$0080                         ;80A369;      ;
        STA.B $7E                            ;80A36C;00007E;
        STZ.B $80                            ;80A36E;000080;
        LDA.B $12                            ;80A370;000012;
        SEC                                  ;80A372;      ;
        SBC.W #$0060                         ;80A373;      ;
        STA.B $82                            ;80A376;000082;
        STA.B $84                            ;80A378;000084;
        BRA CODE_80A395                      ;80A37A;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A37C:
        LDA.B $12                            ;80A37C;000012;
        SEC                                  ;80A37E;      ;
        SBC.W #$0020                         ;80A37F;      ;
        STA.B $7E                            ;80A382;00007E;
        LDA.B $12                            ;80A384;000012;
        SEC                                  ;80A386;      ;
        SBC.W #$00A0                         ;80A387;      ;
        STA.B $80                            ;80A38A;000080;
        LDA.W #$0080                         ;80A38C;      ;
        STA.B $82                            ;80A38F;000082;
        STZ.B $84                            ;80A391;000084;
        BRA CODE_80A395                      ;80A393;80A395;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A395:
        LDA.B $1C                            ;80A395;00001C;
        LSR A                                ;80A397;      ;
        LSR A                                ;80A398;      ;
        STA.B $86                            ;80A399;000086;
        LDA.W #$2000                         ;80A39B;      ;
        CLC                                  ;80A39E;      ;
        ADC.B $16                            ;80A39F;000016;
        SEC                                  ;80A3A1;      ;
        SBC.B $86                            ;80A3A2;000086;
        STA.B $72                            ;80A3A4;000072;
        CLC                                  ;80A3A6;      ;
        ADC.W #$0040                         ;80A3A7;      ;
        STA.B $75                            ;80A3AA;000075;
        %Set8bit(!M)                             ;80A3AC;      ;
        LDA.B #$7E                           ;80A3AE;      ;
        STA.B $74                            ;80A3B0;000074;
        STA.B $77                            ;80A3B2;000077;
        %Set16bit(!M)                             ;80A3B4;      ;
        LDX.W #$0000                         ;80A3B6;      ;
                                            ;      ;      ;
    CODE_80A3B9:
        PHX                                  ;80A3B9;      ;
        LDA.B $80                            ;80A3BA;000080;
        CMP.W #$0040                         ;80A3BC;      ;
        BNE CODE_80A3CB                      ;80A3BF;80A3CB;
        STZ.B $80                            ;80A3C1;000080;
        LDA.B $7E                            ;80A3C3;00007E;
        CLC                                  ;80A3C5;      ;
        ADC.W #$0040                         ;80A3C6;      ;
        STA.B $7E                            ;80A3C9;00007E;
                                            ;      ;      ;
    CODE_80A3CB:
        LDA.B $84                            ;80A3CB;000084;
        CMP.W #$0040                         ;80A3CD;      ;
        BNE CODE_80A3DC                      ;80A3D0;80A3DC;
        STZ.B $84                            ;80A3D2;000084;
        LDA.B $82                            ;80A3D4;000082;
        CLC                                  ;80A3D6;      ;
        ADC.W #$0040                         ;80A3D7;      ;
        STA.B $82                            ;80A3DA;000082;
                                            ;      ;      ;
    CODE_80A3DC:
        LDY.B $7E                            ;80A3DC;00007E;
        LDX.B $80                            ;80A3DE;000080;
        LDA.B [$72],Y                        ;80A3E0;000072;
        STA.W $0746,X                        ;80A3E2;000746;
        LDY.B $82                            ;80A3E5;000082;
        LDX.B $84                            ;80A3E7;000084;
        LDA.B [$75],Y                        ;80A3E9;000075;
        STA.W $07C6,X                        ;80A3EB;0007C6;
        INC.B $7E                            ;80A3EE;00007E;
        INC.B $7E                            ;80A3F0;00007E;
        INC.B $80                            ;80A3F2;000080;
        INC.B $80                            ;80A3F4;000080;
        INC.B $82                            ;80A3F6;000082;
        INC.B $82                            ;80A3F8;000082;
        INC.B $84                            ;80A3FA;000084;
        INC.B $84                            ;80A3FC;000084;
        PLX                                  ;80A3FE;      ;
        INX                                  ;80A3FF;      ;
        INX                                  ;80A400;      ;
        CPX.W #$0040                         ;80A401;      ;
        BNE CODE_80A3B9                      ;80A404;80A3B9;
        %Set8bit(!M)                             ;80A406;      ;
        LDA.B #$00                           ;80A408;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A40A;000027;
        LDA.B #$18                           ;80A40C;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A40E;000029;
        %Set16bit(!M)                             ;80A410;      ;
        LDY.W #$0040                         ;80A412;      ;
        LDA.B $14                            ;80A415;000014;
        CLC                                  ;80A417;      ;
        ADC.W #$6000                         ;80A418;      ;
        TAX                                  ;80A41B;      ;
        LDA.W #$0746                         ;80A41C;      ;
        STA.B $72                            ;80A41F;000072;
        %Set8bit(!M)                             ;80A421;      ;
        LDA.B #$80                           ;80A423;      ;
        STA.B $74                            ;80A425;000074;
        %Set16bit(!M)                             ;80A427;      ;
        LDA.W #$0080                         ;80A429;      ;
        JSL.L AddProgrammedDMA                ;80A42C;808A33;
        %Set8bit(!M)                             ;80A430;      ;
        LDA.B #$01                           ;80A432;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A434;000027;
        LDA.B #$18                           ;80A436;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A438;000029;
        %Set16bit(!M)                             ;80A43A;      ;
        LDY.W #$0040                         ;80A43C;      ;
        LDA.B $14                            ;80A43F;000014;
        CLC                                  ;80A441;      ;
        ADC.W #$6000                         ;80A442;      ;
        ADC.W #$0400                         ;80A445;      ;
        TAX                                  ;80A448;      ;
        LDA.W #$07C6                         ;80A449;      ;
        STA.B $72                            ;80A44C;000072;
        %Set8bit(!M)                             ;80A44E;      ;
        LDA.B #$80                           ;80A450;      ;
        STA.B $74                            ;80A452;000074;
        %Set16bit(!M)                             ;80A454;      ;
        LDA.W #$0080                         ;80A456;      ;
        JSL.L AddProgrammedDMA                ;80A459;808A33;
        %Set16bit(!MX)                             ;80A45D;      ;
        LDA.B $16                            ;80A45F;000016;
        SEC                                  ;80A461;      ;
        SBC.B $1A                            ;80A462;00001A;
        STA.B $16                            ;80A464;000016;
        LDA.B $14                            ;80A466;000014;
        SEC                                  ;80A468;      ;
        SBC.W #$0020                         ;80A469;      ;
        CMP.W #$FFE0                         ;80A46C;      ;
        BNE CODE_80A476                      ;80A46F;80A476;
        LDA.W #$0BE0                         ;80A471;      ;
        BRA CODE_80A47E                      ;80A474;80A47E;
                                            ;      ;      ;
                                            ;      ;      ;
    CODE_80A476:
        CMP.W #$07E0                         ;80A476;      ;
        BNE CODE_80A47E                      ;80A479;80A47E;
        LDA.W #$03E0                         ;80A47B;      ;
                                            ;      ;      ;
    CODE_80A47E:
        STA.B $14                            ;80A47E;000014;
        RTL                                  ;80A480;      ;END_SUB_80A308

;;;;;;;;
SUB_80A481: ;80A481
        %Set16bit(!MX)                             ;80A481;      ;
        LDA.B $16                            ;80A483;000016;
        CMP.W #$1000                         ;80A485;      ;
        BCC CODE_80A4A6                      ;80A488;80A4A6;
        CMP.W #$2000                         ;80A48A;      ;
        BCC CODE_80A4B1                      ;80A48D;80A4B1;
        CMP.W #$3000                         ;80A48F;      ;
        BCC CODE_80A4C6                      ;80A492;80A4C6;
        CMP.W #$4000                         ;80A494;      ;
        BCC CODE_80A4DB                      ;80A497;80A4DB;
        CMP.W #$5000                         ;80A499;      ;
        BCC CODE_80A4F3                      ;80A49C;80A4F3;
        CMP.W #$6000                         ;80A49E;      ;
        BCC CODE_80A50B                      ;80A4A1;80A50B;
        JMP.W CODE_80A529                    ;80A4A3;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A4A6:
        STZ.B $7E                            ;80A4A6;00007E;
        STZ.B $80                            ;80A4A8;000080;
        STZ.B $82                            ;80A4AA;000082;
        STZ.B $84                            ;80A4AC;000084;
        JMP.W CODE_80A529                    ;80A4AE;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A4B1:
        LDA.B $16                            ;80A4B1;000016;
        SEC                                  ;80A4B3;      ;
        SBC.W #$1000                         ;80A4B4;      ;
        STA.B $7E                            ;80A4B7;00007E;
        XBA                                  ;80A4B9;      ;
        AND.W #$001F                         ;80A4BA;      ;
        ASL A                                ;80A4BD;      ;
        STA.B $80                            ;80A4BE;000080;
        STZ.B $82                            ;80A4C0;000082;
        STZ.B $84                            ;80A4C2;000084;
        BRA CODE_80A529                      ;80A4C4;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A4C6:
        LDA.B $16                            ;80A4C6;000016;
        SEC                                  ;80A4C8;      ;
        SBC.W #$1000                         ;80A4C9;      ;
        STA.B $7E                            ;80A4CC;00007E;
        XBA                                  ;80A4CE;      ;
        AND.W #$001F                         ;80A4CF;      ;
        ASL A                                ;80A4D2;      ;
        STA.B $80                            ;80A4D3;000080;
        STZ.B $82                            ;80A4D5;000082;
        STZ.B $84                            ;80A4D7;000084;
        BRA CODE_80A529                      ;80A4D9;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A4DB:
        LDA.W #$4000                         ;80A4DB;      ;
        STA.B $7E                            ;80A4DE;00007E;
        STZ.B $80                            ;80A4E0;000080;
        LDA.B $16                            ;80A4E2;000016;
        SEC                                  ;80A4E4;      ;
        SBC.W #$3000                         ;80A4E5;      ;
        STA.B $82                            ;80A4E8;000082;
        XBA                                  ;80A4EA;      ;
        AND.W #$001F                         ;80A4EB;      ;
        ASL A                                ;80A4EE;      ;
        STA.B $84                            ;80A4EF;000084;
        BRA CODE_80A529                      ;80A4F1;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A4F3:
        LDA.W #$4000                         ;80A4F3;      ;
        STA.B $7E                            ;80A4F6;00007E;
        STZ.B $80                            ;80A4F8;000080;
        LDA.B $16                            ;80A4FA;000016;
        SEC                                  ;80A4FC;      ;
        SBC.W #$3000                         ;80A4FD;      ;
        STA.B $82                            ;80A500;000082;
        XBA                                  ;80A502;      ;
        AND.W #$001F                         ;80A503;      ;
        ASL A                                ;80A506;      ;
        STA.B $84                            ;80A507;000084;
        BRA CODE_80A529                      ;80A509;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A50B:
        LDA.B $16                            ;80A50B;000016;
        SEC                                  ;80A50D;      ;
        SBC.W #$1000                         ;80A50E;      ;
        STA.B $7E                            ;80A511;00007E;
        LDA.B $16                            ;80A513;000016;
        SEC                                  ;80A515;      ;
        SBC.W #$5000                         ;80A516;      ;
        XBA                                  ;80A519;      ;
        AND.W #$000F                         ;80A51A;      ;
        ASL A                                ;80A51D;      ;
        STA.B $80                            ;80A51E;000080;
        LDA.W #$4000                         ;80A520;      ;
        STA.B $82                            ;80A523;000082;
        STZ.B $84                            ;80A525;000084;
        BRA CODE_80A529                      ;80A527;80A529;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A529:
        LDA.W #$2000                         ;80A529;      ;
        CLC                                  ;80A52C;      ;
        ADC.B $12                            ;80A52D;000012;
        ADC.W #$0060                         ;80A52F;      ;
        STA.B $72                            ;80A532;000072;
        ADC.W #$2000                         ;80A534;      ;
        STA.B $75                            ;80A537;000075;
        %Set8bit(!M)                             ;80A539;      ;
        LDA.B #$7E                           ;80A53B;      ;
        STA.B $74                            ;80A53D;000074;
        STA.B $77                            ;80A53F;000077;
        %Set16bit(!M)                             ;80A541;      ;
        LDX.W #$0000                         ;80A543;      ;
                                            ;      ;      ;
        CODE_80A546:
        PHX                                  ;80A546;      ;
        LDA.B $80                            ;80A547;000080;
        CMP.W #$0040                         ;80A549;      ;
        BNE CODE_80A558                      ;80A54C;80A558;
        STZ.B $80                            ;80A54E;000080;
        LDA.B $7E                            ;80A550;00007E;
        CLC                                  ;80A552;      ;
        ADC.W #$2000                         ;80A553;      ;
        STA.B $7E                            ;80A556;00007E;
                                            ;      ;      ;
        CODE_80A558:
        LDA.B $84                            ;80A558;000084;
        CMP.W #$0040                         ;80A55A;      ;
        BNE CODE_80A569                      ;80A55D;80A569;
        STZ.B $84                            ;80A55F;000084;
        LDA.B $82                            ;80A561;000082;
        CLC                                  ;80A563;      ;
        ADC.W #$2000                         ;80A564;      ;
        STA.B $82                            ;80A567;000082;
                                            ;      ;      ;
        CODE_80A569:
        LDY.B $7E                            ;80A569;00007E;
        LDX.B $80                            ;80A56B;000080;
        LDA.B [$72],Y                        ;80A56D;000072;
        STA.W $0746,X                        ;80A56F;000746;
        LDY.B $82                            ;80A572;000082;
        LDX.B $84                            ;80A574;000084;
        LDA.B [$75],Y                        ;80A576;000075;
        STA.W $07C6,X                        ;80A578;0007C6;
        LDA.B $7E                            ;80A57B;00007E;
        CLC                                  ;80A57D;      ;
        ADC.W #$0100                         ;80A57E;      ;
        STA.B $7E                            ;80A581;00007E;
        INC.B $80                            ;80A583;000080;
        INC.B $80                            ;80A585;000080;
        LDA.B $82                            ;80A587;000082;
        CLC                                  ;80A589;      ;
        ADC.W #$0100                         ;80A58A;      ;
        STA.B $82                            ;80A58D;000082;
        INC.B $84                            ;80A58F;000084;
        INC.B $84                            ;80A591;000084;
        PLX                                  ;80A593;      ;
        INX                                  ;80A594;      ;
        INX                                  ;80A595;      ;
        CPX.W #$0040                         ;80A596;      ;
        BNE CODE_80A546                      ;80A599;80A546;
        %Set8bit(!M)                             ;80A59B;      ;
        LDA.B #$00                           ;80A59D;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A59F;000027;
        LDA.B #$18                           ;80A5A1;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A5A3;000029;
        %Set16bit(!M)                             ;80A5A5;      ;
        LDY.W #$0040                         ;80A5A7;      ;
        LDA.B $10                            ;80A5AA;000010;
        CLC                                  ;80A5AC;      ;
        ADC.W #$6000                         ;80A5AD;      ;
        TAX                                  ;80A5B0;      ;
        LDA.W #$0746                         ;80A5B1;      ;
        STA.B $72                            ;80A5B4;000072;
        %Set8bit(!M)                             ;80A5B6;      ;
        LDA.B #$80                           ;80A5B8;      ;
        STA.B $74                            ;80A5BA;000074;
        %Set16bit(!M)                             ;80A5BC;      ;
        LDA.W #$0081                         ;80A5BE;      ;
        JSL.L AddProgrammedDMA                ;80A5C1;808A33;
        %Set8bit(!M)                             ;80A5C5;      ;
        LDA.B #$01                           ;80A5C7;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A5C9;000027;
        LDA.B #$18                           ;80A5CB;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A5CD;000029;
        %Set16bit(!M)                             ;80A5CF;      ;
        LDY.W #$0040                         ;80A5D1;      ;
        LDA.B $10                            ;80A5D4;000010;
        CLC                                  ;80A5D6;      ;
        ADC.W #$6000                         ;80A5D7;      ;
        ADC.W #$0800                         ;80A5DA;      ;
        TAX                                  ;80A5DD;      ;
        LDA.W #$07C6                         ;80A5DE;      ;
        STA.B $72                            ;80A5E1;000072;
        %Set8bit(!M)                             ;80A5E3;      ;
        LDA.B #$80                           ;80A5E5;      ;
        STA.B $74                            ;80A5E7;000074;
        %Set16bit(!M)                             ;80A5E9;      ;
        LDA.W #$0081                         ;80A5EB;      ;
        JSL.L AddProgrammedDMA                ;80A5EE;808A33;
        %Set16bit(!MX)                             ;80A5F2;      ;
        LDA.B $12                            ;80A5F4;000012;
        CLC                                  ;80A5F6;      ;
        ADC.W #$0002                         ;80A5F7;      ;
        STA.B $12                            ;80A5FA;000012;
        LDA.B $10                            ;80A5FC;000010;
        CLC                                  ;80A5FE;      ;
        ADC.W #$0001                         ;80A5FF;      ;
        CMP.W #$0020                         ;80A602;      ;
        BNE CODE_80A60C                      ;80A605;80A60C;
        LDA.W #$0400                         ;80A607;      ;
        BRA CODE_80A614                      ;80A60A;80A614;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A60C:
        CMP.W #$0420                         ;80A60C;      ;
        BNE CODE_80A614                      ;80A60F;80A614;
        LDA.W #$0000                         ;80A611;      ;
                                            ;      ;      ;
        CODE_80A614:
        STA.B $10                            ;80A614;000010;

        RTL                                  ;80A616;      ;

;;;;;;;;
SUB_80A617: ;80A617
        %Set16bit(!MX)                             ;      ;
        LDA.B $16                            ;80A619;000016;
        CMP.W #$1000                         ;80A61B;      ;
        BCC CODE_80A63C                      ;80A61E;80A63C;
        CMP.W #$2000                         ;80A620;      ;
        BCC CODE_80A646                      ;80A623;80A646;
        CMP.W #$3000                         ;80A625;      ;
        BCC CODE_80A65B                      ;80A628;80A65B;
        CMP.W #$4000                         ;80A62A;      ;
        BCC CODE_80A670                      ;80A62D;80A670;
        CMP.W #$5000                         ;80A62F;      ;
        BCC CODE_80A688                      ;80A632;80A688;
        CMP.W #$6000                         ;80A634;      ;
        BCC CODE_80A6A0                      ;80A637;80A6A0;
        JMP.W CODE_80A6BE                    ;80A639;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A63C:
        STZ.B $7E                            ;80A63C;00007E;
        STZ.B $80                            ;80A63E;000080;
        STZ.B $82                            ;80A640;000082;
        STZ.B $84                            ;80A642;000084;
        BRA CODE_80A6BE                      ;80A644;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A646:
        LDA.B $16                            ;80A646;000016;
        SEC                                  ;80A648;      ;
        SBC.W #$1000                         ;80A649;      ;
        STA.B $7E                            ;80A64C;00007E;
        XBA                                  ;80A64E;      ;
        AND.W #$001F                         ;80A64F;      ;
        ASL A                                ;80A652;      ;
        STA.B $80                            ;80A653;000080;
        STZ.B $82                            ;80A655;000082;
        STZ.B $84                            ;80A657;000084;
        BRA CODE_80A6BE                      ;80A659;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A65B:
        LDA.B $16                            ;80A65B;000016;
        SEC                                  ;80A65D;      ;
        SBC.W #$1000                         ;80A65E;      ;
        STA.B $7E                            ;80A661;00007E;
        XBA                                  ;80A663;      ;
        AND.W #$001F                         ;80A664;      ;
        ASL A                                ;80A667;      ;
        STA.B $80                            ;80A668;000080;
        STZ.B $82                            ;80A66A;000082;
        STZ.B $84                            ;80A66C;000084;
        BRA CODE_80A6BE                      ;80A66E;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A670:
        LDA.W #$4000                         ;80A670;      ;
        STA.B $7E                            ;80A673;00007E;
        STZ.B $80                            ;80A675;000080;
        LDA.B $16                            ;80A677;000016;
        SEC                                  ;80A679;      ;
        SBC.W #$3000                         ;80A67A;      ;
        STA.B $82                            ;80A67D;000082;
        XBA                                  ;80A67F;      ;
        AND.W #$001F                         ;80A680;      ;
        ASL A                                ;80A683;      ;
        STA.B $84                            ;80A684;000084;
        BRA CODE_80A6BE                      ;80A686;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A688:
        LDA.W #$4000                         ;80A688;      ;
        STA.B $7E                            ;80A68B;00007E;
        STZ.B $80                            ;80A68D;000080;
        LDA.B $16                            ;80A68F;000016;
        SEC                                  ;80A691;      ;
        SBC.W #$3000                         ;80A692;      ;
        STA.B $82                            ;80A695;000082;
        XBA                                  ;80A697;      ;
        AND.W #$001F                         ;80A698;      ;
        ASL A                                ;80A69B;      ;
        STA.B $84                            ;80A69C;000084;
        BRA CODE_80A6BE                      ;80A69E;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A6A0:
        LDA.B $16                            ;80A6A0;000016;
        SEC                                  ;80A6A2;      ;
        SBC.W #$1000                         ;80A6A3;      ;
        STA.B $7E                            ;80A6A6;00007E;
        LDA.B $16                            ;80A6A8;000016;
        SEC                                  ;80A6AA;      ;
        SBC.W #$5000                         ;80A6AB;      ;
        XBA                                  ;80A6AE;      ;
        AND.W #$001F                         ;80A6AF;      ;
        ASL A                                ;80A6B2;      ;
        STA.B $80                            ;80A6B3;000080;
        LDA.W #$4000                         ;80A6B5;      ;
        STA.B $82                            ;80A6B8;000082;
        STZ.B $84                            ;80A6BA;000084;
        BRA CODE_80A6BE                      ;80A6BC;80A6BE;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A6BE:
        LDA.W #$2000                         ;80A6BE;      ;
        CLC                                  ;80A6C1;      ;
        ADC.B $12                            ;80A6C2;000012;
        SEC                                  ;80A6C4;      ;
        SBC.W #$0020                         ;80A6C5;      ;
        STA.B $72                            ;80A6C8;000072;
        CLC                                  ;80A6CA;      ;
        ADC.W #$2000                         ;80A6CB;      ;
        STA.B $75                            ;80A6CE;000075;
        %Set8bit(!M)                             ;80A6D0;      ;
        LDA.B #$7E                           ;80A6D2;      ;
        STA.B $74                            ;80A6D4;000074;
        STA.B $77                            ;80A6D6;000077;
        %Set16bit(!M)                             ;80A6D8;      ;
        LDX.W #$0000                         ;80A6DA;      ;
                                            ;      ;      ;
        CODE_80A6DD:
        PHX                                  ;80A6DD;      ;
        LDA.B $80                            ;80A6DE;000080;
        CMP.W #$0040                         ;80A6E0;      ;
        BNE CODE_80A6EF                      ;80A6E3;80A6EF;
        STZ.B $80                            ;80A6E5;000080;
        LDA.B $7E                            ;80A6E7;00007E;
        CLC                                  ;80A6E9;      ;
        ADC.W #$2000                         ;80A6EA;      ;
        STA.B $7E                            ;80A6ED;00007E;
                                            ;      ;      ;
        CODE_80A6EF:
        LDA.B $84                            ;80A6EF;000084;
        CMP.W #$0040                         ;80A6F1;      ;
        BNE CODE_80A700                      ;80A6F4;80A700;
        STZ.B $84                            ;80A6F6;000084;
        LDA.B $82                            ;80A6F8;000082;
        CLC                                  ;80A6FA;      ;
        ADC.W #$2000                         ;80A6FB;      ;
        STA.B $82                            ;80A6FE;000082;
                                            ;      ;      ;
        CODE_80A700:
        LDY.B $7E                            ;80A700;00007E;
        LDX.B $80                            ;80A702;000080;
        LDA.B [$72],Y                        ;80A704;000072;
        STA.W $0746,X                        ;80A706;000746;
        LDY.B $82                            ;80A709;000082;
        LDX.B $84                            ;80A70B;000084;
        LDA.B [$75],Y                        ;80A70D;000075;
        STA.W $07C6,X                        ;80A70F;0007C6;
        LDA.B $7E                            ;80A712;00007E;
        CLC                                  ;80A714;      ;
        ADC.W #$0100                         ;80A715;      ;
        STA.B $7E                            ;80A718;00007E;
        INC.B $80                            ;80A71A;000080;
        INC.B $80                            ;80A71C;000080;
        LDA.B $82                            ;80A71E;000082;
        CLC                                  ;80A720;      ;
        ADC.W #$0100                         ;80A721;      ;
        STA.B $82                            ;80A724;000082;
        INC.B $84                            ;80A726;000084;
        INC.B $84                            ;80A728;000084;
        PLX                                  ;80A72A;      ;
        INX                                  ;80A72B;      ;
        INX                                  ;80A72C;      ;
        CPX.W #$0040                         ;80A72D;      ;
        BNE CODE_80A6DD                      ;80A730;80A6DD;
        %Set8bit(!M)                             ;80A732;      ;
        LDA.B #$00                           ;80A734;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A736;000027;
        LDA.B #$18                           ;80A738;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A73A;000029;
        %Set16bit(!M)                             ;80A73C;      ;
        LDY.W #$0040                         ;80A73E;      ;
        LDA.B $10                            ;80A741;000010;
        CLC                                  ;80A743;      ;
        ADC.W #$6000                         ;80A744;      ;
        TAX                                  ;80A747;      ;
        LDA.W #$0746                         ;80A748;      ;
        STA.B $72                            ;80A74B;000072;
        %Set8bit(!M)                             ;80A74D;      ;
        LDA.B #$80                           ;80A74F;      ;
        STA.B $74                            ;80A751;000074;
        %Set16bit(!M)                             ;80A753;      ;
        LDA.W #$0081                         ;80A755;      ;
        JSL.L AddProgrammedDMA                ;80A758;808A33;
        %Set8bit(!M)                             ;80A75C;      ;
        LDA.B #$01                           ;80A75E;      ;
        STA.B !ProgDMA_Channel_Index                            ;80A760;000027;
        LDA.B #$18                           ;80A762;      ;
        STA.B !ProgDMA_Destination_Memory                            ;80A764;000029;
        %Set16bit(!M)                             ;80A766;      ;
        LDY.W #$0040                         ;80A768;      ;
        LDA.B $10                            ;80A76B;000010;
        CLC                                  ;80A76D;      ;
        ADC.W #$6000                         ;80A76E;      ;
        ADC.W #$0800                         ;80A771;      ;
        TAX                                  ;80A774;      ;
        LDA.W #$07C6                         ;80A775;      ;
        STA.B $72                            ;80A778;000072;
        %Set8bit(!M)                             ;80A77A;      ;
        LDA.B #$80                           ;80A77C;      ;
        STA.B $74                            ;80A77E;000074;
        %Set16bit(!M)                             ;80A780;      ;
        LDA.W #$0081                         ;80A782;      ;
        JSL.L AddProgrammedDMA                ;80A785;808A33;
        %Set16bit(!MX)                             ;80A789;      ;
        LDA.B $12                            ;80A78B;000012;
        SEC                                  ;80A78D;      ;
        SBC.W #$0002                         ;80A78E;      ;
        STA.B $12                            ;80A791;000012;
        LDA.B $10                            ;80A793;000010;
        SEC                                  ;80A795;      ;
        SBC.W #$0001                         ;80A796;      ;
        CMP.W #$FFFF                         ;80A799;      ;
        BNE CODE_80A7A3                      ;80A79C;80A7A3;
        LDA.W #$041F                         ;80A79E;      ;
        BRA CODE_80A7AB                      ;80A7A1;80A7AB;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_80A7A3:
        CMP.W #$03FF                         ;80A7A3;      ;
        BNE CODE_80A7AB                      ;80A7A6;80A7AB;
        LDA.W #$001F                         ;80A7A8;      ;
                                            ;      ;      ;
        CODE_80A7AB:
        STA.B $10                            ;80A7AB;000010;
        RTL                                  ;80A7AD;      ;

;;;;;;;;
SUB_80A7AE: ;80A7AE
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        %Set16bit(!M)
        ASL A
        TAX
        LDA.L BackgroundsManagerTable,X
        STA.B !tilemap_pointer
        %Set8bit(!M)
        LDA.B (!tilemap_pointer),Y
        RTL

;;;;;;;; Loads map data, including
BackgroundsManager: ;80A7C6
        !number_of_tilemaps = $92
        !number_of_charactermaps = $93

        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$00
        XBA
        LDA.B !tilemap_to_load
        %Set16bit(!M)
        ASL A
        TAX
        LDA.L BackgroundsManagerTable,X
        STA.B !tilemap_pointer
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B !tilemap_to_load
        CMP.B #$57                           ;after that value, theres splash screens
        BCS .singletilemapskip

        LDA.B (!tilemap_pointer),Y
        STA.W !current_graphic_preset
        JSL.L ManageGraphicPresets
        %Set16bit(!MX)
        INY
        LDA.B (!tilemap_pointer),Y
        ORA.W $0196                          ;FLAG196
        STA.W $0196
        %Set16bit(!M)
        LDA.L $7F1F5C
        AND.W #$0001                         ;FLAG5C
        BEQ .skip1

        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$FFDF                         ;FLAG196
        STA.W $0196

    .skip1: %Set16bit(!MX)
        INY
        INY

    .singletilemapskip:
        %Set8bit(!M)
        LDA.B (!tilemap_pointer),Y
        STA.W $0181                          ;related to tables
        INY
        LDA.B (!tilemap_pointer),Y
        STA.W $0182                          ;never used except here?
        CMP.B #$03                           ;TODO
        BCC .skip2

        %Set16bit(!M)
        LDA.W $0196
        ORA.W #$0001                         ;FLAG196
        STA.W $0196

    .skip2:
        %Set8bit(!M)
        INY
        LDA.B (!tilemap_pointer),Y
        STA.B !number_of_tilemaps
        INY
        LDA.B (!tilemap_pointer),Y
        STA.B !number_of_charactermaps
        INY
        LDA.B !tilemap_to_load
        CMP.B #$57
        BCS .singletilemapskip2

        %Set16bit(!M)
        LDA.B (!tilemap_pointer),Y
        STA.B !OBJ_clamp_left
        INY
        INY
        LDA.B (!tilemap_pointer),Y
        STA.B !OBJ_clamp_right
        INY
        INY
        LDA.B (!tilemap_pointer),Y
        STA.B !OBJ_clamp_up
        INY
        INY
        LDA.B (!tilemap_pointer),Y
        STA.B !OBJ_clamp_down
        INY
        INY

    .singletilemapskip2:
        %Set8bit(!M)
        LDA.B !number_of_tilemaps
        BEQ .charactermaploop

    .tilemaploop:
            %Set16bit(!M)
            LDA.B (!tilemap_pointer),Y       ;loads destination in VRAM
            PHA
            INY
            INY
            LDA.B (!tilemap_pointer),Y       ;loads compressed map location
            STA.B $72
            INY
            INY
            %Set8bit(!M)
            LDA.B (!tilemap_pointer),Y       ;loads compressed map location bank
            STA.B $74
            %Set16bit(!M)
            INY
            PHY
            LDA.W #$2000
            STA.B $75
            %Set8bit(!M)
            LDA.B #$7E                      ;Destination adress, current graphical map
            STA.B $77
            JSL.L DecompressTileMap
            %Set8bit(!M)
            LDA.B #$00
            STA.B !ProgDMA_Channel_Index
            LDA.B !BBADX_DMA_VRAMPORT
            STA.B !ProgDMA_Destination_Memory
            %Set16bit(!MX)
            PLY
            PLA
            PHY
            TAX                              ;destination in VRAM
            LDY.W #$2000                     ;size
            LDA.W #$2000
            STA.B $72
            %Set8bit(!M)
            LDA.B #$7E                       ;source
            STA.B $74
            %Set16bit(!M)
            LDA.W #$0080
            JSL.L AddProgrammedDMA
            JSL.L StartLastPreparedDMA
            %Set16bit(!MX)
            PLY
            %Set8bit(!M)
            LDA.B !number_of_tilemaps
            DEC A
            STA.B !number_of_tilemaps
            BNE .tilemaploop

    .charactermaploop:
            %Set16bit(!MX)
            LDA.B (!tilemap_pointer),Y       ;dest?
            STA.B $8A
            INY
            INY
            LDA.B (!tilemap_pointer),Y
            STA.B $72
            INY
            INY
            %Set8bit(!M)
            LDA.B (!tilemap_pointer),Y       ;source?
            STA.B $74
            %Set16bit(!M)
            INY
            PHY
            LDA.W #$2000
            STA.B $75
            %Set8bit(!M)
            LDA.B #$7E
            STA.B $77
            %Set16bit(!M)
            LDA.W $0196
            AND.W #$8000                         ;FLAG196
            BNE .skip5                           ;TODO
            JSL.L DecompressTileMap
            BRA .farmcheck

        .skip5:
            %Set16bit(!MX)
            LDY.W #$0000

            .extradatareadloop:
                LDA.B [$72],Y                    ;TODO
                STA.B [$75],Y
                INY
                INY
                CPY.W #$8000
                BNE .extradatareadloop

        .farmcheck:
            %Set8bit(!M)
            LDA.B !tilemap_to_load
            CMP.B #$04
            BCS .notfarm                         ;Farms by season
            JSL.L UNK_PartialMap                 ;TODO

        .notfarm:
            %Set8bit(!M)
            LDA.B !number_of_charactermaps
            CMP.B #$01
            BNE .setoffsets
            %Set16bit(!MX)
            LDA.L $7F1F5E
            AND.W #$0002                         ;FLAG5E
            BNE .setoffsets
            JSL.L UNK_ExecuteFromPointers

        .setoffsets:
            %Set16bit(!M)
            STZ.B !OBJ_Offset_X
            STZ.B !OBJ_Offset_Y
            LDA.W #$410
            STA.B $10
            LDA.W #$0A00
            STA.B $14
            STZ.B $12
            STZ.B $16
            %Set8bit(!M)
            STZ.B !BG_subpixel_offset_X
            STZ.B !BG_subpixel_offset_Y
            %Set16bit(!M)
            STZ.B !player_pos_X
            STZ.B !player_pos_Y
            %Set8bit(!M)
            LDA.B #$00
            XBA
            LDA.W $0181
            %Set16bit(!M)
            ASL A
            TAX
            LDA.L UNK_Table2,X
            STA.B $1A
            SEC
            SBC.W #$0040
            STA.B $80
            LDA.L UNK_Table3,X
            STA.B $1C
            %Set16bit(!M)
            LDA.W #$0000
            STA.B $7E
            LDX.B $8A
            LDY.W #$0040
            LDA.W #$0000

            .copycharacters40atatime:
                %Set16bit(!M)
                PHA
                LDA.W #$0000

                .loop2:
                    %Set16bit(!MX)
                    PHA
                    JSR.W LoadsFromVRAMwithOffset
                    %Set16bit(!MX)
                    LDA.B $7E
                    CLC
                    ADC.W #$0040
                    STA.B $7E
                    TXA
                    CLC
                    ADC.W #$0400
                    TAX
                    %Set8bit(!M)
                    LDA.B !tilemap_to_load
                    CMP.B #$5B               ;splash screens
                    BCS .skip9
                    LDY.B $8A
                    CPY.W #$7000
                    BEQ .skip10

                .skip9:
                    LDY.W #$0040
                    JSR.W LoadsFromVRAMwithOffset

                .skip10:
                    %Set16bit(!MX)
                    LDA.B $7E
                    CLC
                    ADC.B $80
                    STA.B $7E
                    TXA
                    SEC
                    SBC.W #$03E0
                    TAX
                    LDY.W #$0040
                    PLA
                    INC A
                    CMP.W #$0020
                    BNE .loop2

                %Set8bit(!M)
                LDA.B !tilemap_to_load
                CMP.B #$5B
                BCS .skip11
                LDY.B $8A
                CPY.W #$7000
                BEQ .skip12

            .skip11:
                %Set16bit(!M)
                TXA
                CLC
                ADC.W #$0400
                TAX

            .skip12:
                %Set16bit(!MX)
                LDY.W #$0040
                PLA
                INC A
                CMP.W #$0002
                BNE .copycharacters40atatime

            %Set16bit(!MX)
            PLY
            %Set8bit(!M)
            LDA.B !number_of_charactermaps
            DEC A
            STA.B !number_of_charactermaps
            BEQ .exitcharactermaploop
            JMP.W .charactermaploop

    .exitcharactermaploop:
        %Set8bit(!M)
        LDA.B !tilemap_to_load
        CMP.B #$57
        BCS .return
        %Set8bit(!M)
        LDA.B #$08
        STA.B $1E

        .loop33:
            %Set16bit(!M)
            LDA.B !player_pos_X
            CMP.W !transition_dest_X
            BEQ .skip14
            LDA.B !player_pos_X
            CLC
            ADC.B $1E
            STA.B !player_pos_X
            JSL.L SUB_809EBC
            JSL.L UNK_StaticMapScroling
            JSL.L StartProgramedDMA
            BRA .loop33

    .skip14:
        %Set16bit(!M)
        LDA.B !player_pos_Y
        CMP.W !transition_dest_Y
        BEQ .return
        LDA.B !player_pos_Y
        CLC
        ADC.B $1E
        STA.B !player_pos_Y
        JSL.L SUB_809EBC
        JSL.L UpdateBGOffset
        JSL.L StartProgramedDMA
        BRA .skip14

    .return: RTL

;;;;;;; Params $7E: offset to add, X: VRAM/CGRAM Dest Addresses and Y:DMA Size
LoadsFromVRAMwithOffset: ;80AA38
        !offset = $7E

        %Set16bit(!MX)
        PHX
        PHY
        %Set8bit(!M)
        LDA.B #$00
        STA.B !ProgDMA_Channel_Index
        LDA.B !BBADX_DMA_VRAMPORT
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!M)
        LDA.W #$2000
        CLC
        ADC.B !offset
        STA.B $72
        %Set8bit(!M)
        LDA.B #$7E
        STA.B $74                            ;sets $72 as pointer to $7E2000+offset
        %Set16bit(!M)
        LDA.W #$0080                         ;reverse Direction???
        JSL.L AddProgrammedDMA
        JSL.L StartLastPreparedDMA
        %Set16bit(!MX)
        PLY
        PLX
        RTS
                                                            ;      ;      ;
        ;Related to 0181, stored in A1, sprite size?
UNK_Table2: dw $0000,$0040,$0080,$0100,$0100;80AA68;      ;
UNK_Table3: dw $0000,$1000,$2000,$4000,$4000;80AA72;      ;used on BackgroundsManager
                                                            ;      ;      ;
incsrc "../tilesets/BackgroundsManagerTable.asm"
                                                            ;      ;      ;
          Unk_Table13: db $0C,$00,$00,$01,$E8,$00,$80,$00,$15,$01,$0D,$00,$80,$00,$C8,$00;80B6F5;      ;
                       db $16,$01,$0D,$00,$80,$00,$C8,$00,$17,$01,$0D,$00,$80,$00,$C8,$00;80B705;      ;
                       db $27,$01,$0E,$00,$80,$00,$68,$01,$28,$01,$0F,$00,$80,$00,$C8,$00;80B715;      ;
                       db $26,$01,$10,$00,$80,$00,$C8,$00,$2A,$00,$00,$00,$90,$00,$90,$02;80B725;      ;
                       db $2A,$00,$00,$00,$B0,$00,$60,$01,$00,$00,$00,$81,$88,$00,$58,$01;80B735;      ;
                       db $00,$00,$00,$01,$A8,$01,$E8,$01,$2A,$00,$23,$00,$60,$00,$98,$00;80B745;      ;
                       db $00,$00,$00,$01,$48,$01,$68,$01,$00,$00,$00,$01,$C8,$01,$68,$01;80B755;      ;
                       db $00,$02,$00,$01,$18,$00,$C0,$01,$04,$03,$00,$01,$E8,$02,$A8,$01;80B765;      ;
                       db $10,$01,$00,$01,$48,$01,$D8,$02,$0C,$02,$00,$01,$18,$00,$80,$00;80B775;      ;
                       db $18,$01,$14,$22,$80,$00,$A8,$00,$1B,$01,$15,$02,$80,$00,$C8,$01;80B785;      ;
                       db $1C,$01,$16,$32,$90,$00,$C8,$01,$1E,$01,$17,$24,$90,$00,$C8,$01;80B795;      ;
                       db $20,$01,$18,$32,$90,$00,$C8,$01,$22,$01,$19,$32,$90,$00,$C8,$01;80B7A5;      ;
                       db $24,$01,$1A,$32,$80,$00,$C8,$00,$24,$00,$00,$32,$58,$00,$48,$00;80B7B5;      ;
                       db $25,$01,$1B,$32,$80,$00,$C8,$00,$0C,$00,$00,$01,$80,$00,$18,$00;80B7C5;      ;
                       db $2B,$01,$13,$32,$80,$00,$C8,$00,$29,$01,$00,$00,$78,$01,$80,$00;80B7D5;      ;
                       db $29,$05,$00,$00,$C8,$00,$88,$01,$31,$01,$00,$41,$80,$00,$C8,$01;80B7E5;      ;
                       db $10,$00,$00,$01,$A8,$00,$A8,$01,$10,$00,$00,$01,$88,$01,$18,$00;80B7F5;      ;
                       db $10,$00,$00,$01,$08,$02,$28,$02,$04,$00,$00,$01,$98,$00,$98,$00;80B805;      ;
                       db $19,$01,$1C,$00,$B0,$01,$98,$01,$18,$00,$00,$00,$98,$00,$48,$00;80B815;      ;
                       db $1A,$00,$00,$00,$98,$00,$58,$01,$19,$01,$1D,$00,$50,$01,$98,$01;80B825;      ;
                       db $04,$00,$00,$01,$70,$01,$98,$00,$04,$00,$00,$01,$58,$02,$E8,$00;80B835;      ;
                       db $1D,$01,$1E,$00,$68,$00,$B8,$00,$1C,$00,$00,$00,$68,$00,$48,$01;80B845;      ;
                       db $04,$00,$00,$01,$58,$02,$78,$03,$04,$01,$1F,$01,$48,$02,$28,$03;80B855;      ;
                       db $04,$00,$00,$01,$18,$01,$68,$03,$21,$01,$20,$00,$68,$00,$C8,$00;80B865;      ;
                       db $20,$00,$00,$00,$68,$00,$48,$01,$04,$00,$00,$01,$98,$01,$68,$03;80B875;      ;
                       db $23,$01,$21,$00,$68,$00,$B8,$00,$22,$00,$00,$00,$68,$00,$48,$01;80B885;      ;
                       db $04,$00,$00,$01,$98,$00,$68,$03,$1F,$01,$22,$00,$88,$00,$C8,$00;80B895;      ;
                       db $1E,$00,$00,$00,$88,$00,$48,$01,$04,$00,$00,$01,$48,$02,$68,$02;80B8A5;      ;
                       db $26,$00,$00,$00,$78,$00,$48,$00,$00,$00,$00,$01,$28,$03,$58,$03;80B8B5;      ;
                       db $04,$03,$00,$01,$68,$02,$68,$01   ;80B8C5;      ;
                                                            ;      ;      ;
       UNK_AudioTable: db $00,$04,$02,$05,$03,$03,$03,$04,$03,$01,$02,$03,$03,$03,$01,$04;80B8CD;      ;
                       db $03,$03,$04,$01,$01,$03,$01,$01,$01,$02;80B8DD;      ;
                                                            ;      ;      ;
Mayby_Table_AudioTracksbySeason: db $A7,$B9,$A7,$B9,$A7,$B9,$A7,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9;80B8E7;      ;
                       db $B3,$B9,$B3,$B9,$B7,$B9,$BB,$B9,$A7,$B9,$A7,$B9,$A7,$B9,$A7,$B9;80B8F7;      ;
                       db $AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$A7,$B9,$A7,$B9,$A7,$B9;80B907;      ;
                       db $AB,$B9,$AB,$B9,$AB,$B9,$BF,$B9,$AB,$B9,$AB,$B9,$D3,$B9,$AB,$B9;80B917;      ;
                       db $AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$A7,$B9,$A7,$B9;80B927;      ;
                       db $A7,$B9,$FF,$FF,$C3,$B9,$AF,$B9,$C7,$B9,$A7,$B9,$A7,$B9,$A7,$B9;80B937;      ;
                       db $A7,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9;80B947;      ;
                       db $AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$CF,$B9,$FF,$FF,$FF,$FF,$FF,$FF;80B957;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80B967;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80B977;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80B987;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$CF,$B9,$CB,$B9,$FF,$FF,$C7,$B9,$C7,$B9;80B997;      ;
                                                            ;      ;      ;
Table_AudioTrackbySeasonIndex: db $01,$02,$07,$04,$05,$05,$05,$05,$06,$06,$06,$06,$03,$03,$03,$03;80B9A7;      ;
                       db $0E,$0E,$0E,$0E,$0D,$0D,$0D,$0D,$09,$09,$09,$09,$0F,$0F,$0F,$0F;80B9B7;      ;
                       db $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$12,$12,$12,$12,$08,$08,$08,$08;80B9C7;      ;
                       db $68,$49,$08,$FF,$FF,$68,$49,$08,$17,$7F,$08,$71,$72,$08,$FE,$FF;80B9D7;      ;
                       db $DC,$B9,$80,$10,$52,$28,$FF,$FF,$10,$52,$28,$10,$52,$28,$BD,$7F;80B9E7;      ;
                       db $28,$FE,$FF,$EF,$B9,$80           ;80B9F7;      ;
                                                            ;      ;      ;
PalettePointerTable: dl Palette01                         ;80B9FD;A89400;1
                     dl Palette02                         ;80BA00;A89600;2
                     dl Palette03                         ;80BA03;A89800;3
                     dl Palette04                         ;80BA06;A88A00;4
                     dl GFX_A88C00                        ;80BA09;A88C00;5
                     dl GFX_A88E00                        ;80BA0C;A88E00;6
                     dl GFX_A89000                        ;80BA0F;A89000;7
                     dl GFX_A89200                        ;80BA12;A89200;8
                     dl GFX_A88000                        ;80BA15;A88000;9
                     dl GFX_A88200                        ;80BA18;A88200;A
                     dl GFX_A88400                        ;80BA1B;A88400;B
                     dl GFX_A88600                        ;80BA1E;A88600;C
                     dl GFX_A88800                        ;80BA21;A88800;D
                     dl GFX_A89A00                        ;80BA24;A89A00;E
                     dl GFX_A89C00                        ;80BA27;A89C00;F
                     dl GFX_A89E00                        ;80BA2A;A89E00;10
                     dl GFX_A8A000                        ;80BA2D;A8A000;11
                     dl GFX_A8A200                        ;80BA30;A8A200;12
                     dl GFX_A8F400                        ;80BA33;A8F400;13
                     dl GFX_A8F800                        ;80BA36;A8F800;14
                     dl GFX_A8FA00                        ;80BA39;A8FA00;15
                     dl GFX_A8FC00                        ;80BA3C;A8FC00;16
                     dl GFX_A8BA00                        ;80BA3F;A8BA00;17
                     dl GFX_A8BC00                        ;80BA42;A8BC00;18
                     dl GFX_A8BE00                        ;80BA45;A8BE00;19
                     dl GFX_A8C000                        ;80BA48;A8C000;1A
                     dl GFX_A8C200                        ;80BA4B;A8C200;1B
                     dl GFX_A8C600                        ;80BA4E;A8C600;1C
                     dl GFX_A8C800                        ;80BA51;A8C800;1D
                     dl GFX_A8CA00                        ;80BA54;A8CA00;1F
                     dl GFX_A98000                        ;80BA57;A98000;20
                     dl GFX_A98200                        ;80BA5A;A98200;21
                     dl GFX_A98400                        ;80BA5D;A98400;22
                     dl GFX_A98600                        ;80BA60;A98600;23
                     dl GFX_A8F600                        ;80BA63;A8F600;24
                     dl GFX_A8C400                        ;80BA66;A8C400;25
                     dl GFX_A98A00                        ;80BA69;A98A00;26
                     dl GFX_A98800                        ;80BA6C;A98800;27
                     dl GFX_A8FE00                        ;80BA6F;A8FE00;28
                     dl GFX_A8CC00                        ;80BA72;A8CC00;29
                     dl GFX_A8CE00                        ;80BA75;A8CE00;2A
                     dl GFX_A8D000                        ;80BA78;A8D000;2B
                     dl GFX_A8D200                        ;80BA7B;A8D200;2C
                     dl GFX_A8D400                        ;80BA7E;A8D400;2D
                     dl GFX_A8EA00                        ;80BA81;A8EA00;2E
                     dl GFX_A8EC00                        ;80BA84;A8EC00;2F
                     dl GFX_A8EE00                        ;80BA87;A8EE00;30
                     dl GFX_A8F000                        ;80BA8A;A8F000;31
                     dl GFX_A8F200                        ;80BA8D;A8F200;32
                     dl GFX_A8D600                        ;80BA90;A8D600;33
                     dl GFX_A8D800                        ;80BA93;A8D800;34
                     dl GFX_A8DA00                        ;80BA96;A8DA00;35
                     dl GFX_A8DC00                        ;80BA99;A8DC00;36
                     dl GFX_A8DE00                        ;80BA9C;A8DE00;37
                     dl GFX_A8E000                        ;80BA9F;A8E000;38
                     dl GFX_A8E200                        ;80BAA2;A8E200;39
                     dl GFX_A8E400                        ;80BAA5;A8E400;3A
                     dl GFX_A8E600                        ;80BAA8;A8E600;3B
                     dl GFX_A8E800                        ;80BAAB;A8E800;3C
                     dl GFX_A9C800                        ;80BAAE;A9C800;3D
                     dl GFX_A9CA00                        ;80BAB1;A9CA00;3E
                     dl GFX_A9CC00                        ;80BAB4;A9CC00;3F
                     dl GFX_A9CE00                        ;80BAB7;A9CE00;40
                     dl GFX_A9B800                        ;80BABA;A9B800;41
                     dl GFX_A9BA00                        ;80BABD;A9BA00;42
                     dl GFX_A9BC00                        ;80BAC0;A9BC00;43
                     dl GFX_A9BE00                        ;80BAC3;A9BE00;44
                     dl GFX_A9C000                        ;80BAC6;A9C000;45
                     dl GFX_A9C200                        ;80BAC9;A9C200;46
                     dl GFX_A9C400                        ;80BACC;A9C400;47
                     dl GFX_A9C600                        ;80BACF;A9C600;48
                     dl GFX_A9D000                        ;80BAD2;A9D000;49
                     dl GFX_A9D200                        ;80BAD5;A9D200;4A
                     dl GFX_A9D400                        ;80BAD8;A9D400;4B
                     dl GFX_A9D600                        ;80BADB;A9D600;4C
                     dl GFX_A8A600                        ;80BADE;A8A600;4D
                     dl GFX_A8A800                        ;80BAE1;A8A800;4E
                     dl GFX_A8AA00                        ;80BAE4;A8AA00;4F
                     dl GFX_A8AC00                        ;80BAE7;A8AC00;50
                     dl GFX_A8AE00                        ;80BAEA;A8AE00;51
                     dl GFX_A8B000                        ;80BAED;A8B000;52
                     dl GFX_A8B200                        ;80BAF0;A8B200;53
                     dl GFX_A8B400                        ;80BAF3;A8B400;54
                     dl GFX_A8B600                        ;80BAF6;A8B600;55
                     dl GFX_A8B800                        ;80BAF9;A8B800;56
                     dl GFX_A98E00                        ;80BAFC;A98E00;57
                     dl GFX_A9B600                        ;80BAFF;A9B600;58
                     dl GFX_A8A400                        ;80BB02;A8A400;59
                     dl GFX_A99200                        ;80BB05;A99200;5A
                     dl GFX_A99000                        ;80BB08;A99000;5B
                     dl GFX_A9A600                        ;80BB0B;A9A600;5C
                     dl GFX_A9A800                        ;80BB0E;A9A800;5D
                     dl GFX_A9AA00                        ;80BB11;A9AA00;5E
                     dl GFX_A9AC00                        ;80BB14;A9AC00;5F
                     dl GFX_A99C00                        ;80BB17;A99C00;60
                     dl GFX_A99E00                        ;80BB1A;A99E00;61
                     dl GFX_A9A000                        ;80BB1D;A9A000;62
                     dl GFX_A9A200                        ;80BB20;A9A200;63
                     dl GFX_A99400                        ;80BB23;A99400;64
                     dl GFX_A99600                        ;80BB26;A99600;65
                     dl GFX_A99800                        ;80BB29;A99800;66
                     dl GFX_A99A00                        ;80BB2C;A99A00;67
                     dl GFX_A9AE00                        ;80BB2F;A9AE00;68
                     dl GFX_A9B000                        ;80BB32;A9B000;69
                     dl GFX_A9B200                        ;80BB35;A9B200;6A
                     dl GFX_A9B400                        ;80BB38;A9B400;6B
                     dl GFX_A9A400                        ;80BB3B;A9A400;6C
                     dl GFX_A9DE00                        ;80BB3E;A9DE00;6D
                     dl GFX_A9E000                        ;80BB41;A9E000;6E
                     dl GFX_A9D800                        ;80BB44;A9D800;6F
                     dl CG_Natsume_Title                  ;80BB47;A9DA00;70
                     dl GFX_A98C00                        ;80BB4A;A98C00;71
                     dl GFX_A9DC00                        ;80BB4D;A9DC00;72
                     dl GFX_A9E200                        ;80BB50;A9E200;73
                     dl GFX_A9E400                        ;80BB53;A9E400;74
                     dl GFX_A9E600                        ;80BB56;A9E600;75
                     dl GFX_A9E800                        ;80BB59;A9E800;76
                                                            ;      ;      ;
         Time_Palette_Table: db $00,$01,$02,$06,$07,$FF,$03,$04,$05,$06,$07,$FF,$08,$09,$0A,$0B;80BB5C;      ;
                       db $0C,$FF,$0D,$0E,$0F,$10,$11,$FF,$FF,$12,$13,$14,$15,$FF,$FF,$16;80BB6C;      ;
                       db $17,$18,$19,$FF,$FF,$1A,$1B,$1C,$1D,$FF,$FF,$1E,$1F,$20,$21,$FF;80BB7C;      ;
                       db $FF,$22,$22,$FF,$FF,$FF,$FF,$23,$23,$FF,$FF,$FF,$FF,$FF,$FF,$24;80BB8C;      ;
                       db $25,$FF,$FF,$26,$FF,$FF,$FF,$FF,$27,$28,$29,$2A,$2B,$FF,$2C,$2D;80BB9C;      ;
                       db $2E,$2F,$30,$FF,$31,$32,$33,$34,$35,$FF,$36,$37,$38,$39,$3A,$FF;80BBAC;      ;
                       db $FF,$3B,$3C,$3D,$3E,$FF,$FF,$3F,$40,$41,$42,$FF,$FF,$43,$44,$45;80BBBC;      ;
                       db $46,$FF,$FF,$47,$48,$49,$4A,$FF,$FF,$FF,$FF,$FF,$4A,$FF,$4B,$4B;80BBCC;      ;
                       db $4B,$4B,$4B,$4C,$4B,$4B,$4B,$4B,$4B,$4C,$4B,$4B,$4B,$4B,$4B,$4C;80BBDC;      ;
                       db $FF,$4D,$4D,$FF,$FF,$FF,$FF,$4D,$4D,$FF,$FF,$FF,$FF,$4D,$4D,$FF;80BBEC;      ;
                       db $FF,$FF,$FF,$4E,$4E,$FF,$FF,$FF,$FF,$4F,$4F,$FF,$FF,$FF,$FF,$4F;80BBFC;      ;
                       db $4F,$FF,$FF,$FF,$FF,$FF,$FF,$50,$50,$FF,$FF,$FF,$FF,$50,$50,$FF;80BC0C;      ;
                       db $FF,$51,$51,$FF,$FF,$FF,$FF,$51,$51,$FF,$FF,$FF,$FF,$52,$52,$FF;80BC1C;      ;
                       db $FF,$FF,$FF,$52,$52,$FF,$FF,$FF,$FF,$53,$53,$FF,$FF,$FF,$FF,$54;80BC2C;      ;
                       db $54,$FF,$FF,$FF,$55,$55,$55,$55,$55,$FF,$56,$56,$56,$56,$56,$FF;80BC3C;      ;
                       db $56,$56,$56,$56,$56,$FF,$FF,$57,$57,$57,$57,$FF,$57,$57,$57,$57;80BC4C;      ;
                       db $57,$FF,$FF,$58,$58,$FF,$FF,$FF,$FF,$59,$FF,$FF,$FF,$FF,$FF,$12;80BC5C;      ;
                       db $FF,$FF,$FF,$FF,$FF,$16,$FF,$FF,$FF,$FF,$FF,$1A,$FF,$FF,$FF,$FF;80BC6C;      ;
                       db $FF,$1E,$FF,$FF,$FF,$FF,$FF,$5A,$5B,$5C,$5D,$FF,$FF,$5E,$5F,$60;80BC7C;      ;
                       db $61,$FF,$FF,$62,$63,$64,$65,$FF,$FF,$66,$67,$68,$69,$FF,$FF,$5A;80BC8C;      ;
                       db $5B,$5C,$5D,$FF,$FF,$5E,$5F,$60,$61,$FF,$FF,$62,$63,$64,$65,$FF;80BC9C;      ;
                       db $FF,$66,$67,$68,$69,$FF,$FF,$FF,$FF,$FF,$69,$FF,$69,$6A,$6A,$6A;80BCAC;      ;
                       db $6A,$FF,$FF,$5A,$5B,$5C,$5D,$FF,$28,$FF,$FF,$FF,$FF,$FF,$04,$FF;80BCBC;      ;
                       db $FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF;80BCCC;      ;
                       db $04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$16,$FF,$FF,$FF;80BCDC;      ;
                       db $FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF;80BCEC;      ;
                       db $FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF;80BCFC;      ;
                       db $3F,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF;80BD0C;      ;
                       db $FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF;80BD1C;      ;
                       db $FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF;80BD2C;      ;
                       db $70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF;80BD3C;      ;
                       db $FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF;80BD4C;      ;
                       db $FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD5C;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD6C;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD7C;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD8C;      ;
                                                            ;      ;      ;
           UNK_Table9: db $F8,$3B,$D0,$26,$46,$09,$8C,$23,$48,$16,$24,$01,$D7,$22,$71,$01;80BD9C;      ;
                       db $A9,$0C,$8C,$23,$EF,$3D,$7B,$7F,$A8,$15,$07,$15,$A2,$00,$A8,$15;80BDAC;      ;
                       db $07,$15,$A2,$00,$4C,$01,$E8,$00,$66,$00,$A8,$15,$EF,$3D,$73,$56;80BDBC;      ;
                       db $76,$3B,$92,$2A,$07,$11,$8C,$23,$48,$16,$24,$01,$7C,$0A,$54,$01;80BDCC;      ;
                       db $A8,$08,$76,$3B,$92,$2A,$07,$11,$CE,$19,$2A,$11,$85,$08,$CF,$1D;80BDDC;      ;
                       db $2B,$0D,$66,$00,$70,$01,$CC,$04,$24,$00,$CE,$19,$2A,$11,$85,$08;80BDEC;      ;
                                                            ;      ;      ;
          UNK_Table10: db $00,$00,$00,$00,$00,$00,$29,$7A,$A0,$5D,$00,$41,$1F,$03,$DF,$01;80BDFC;      ;
                       db $F8,$00,$1F,$73,$5E,$62,$B9,$41,$56,$1A,$B0,$0D,$2D,$1D,$FF,$53;80BE0C;      ;
                       db $FE,$02,$16,$02,$00,$00,$00,$00,$00,$00,$EA,$61,$80,$51,$20,$45;80BE1C;      ;
                       db $DB,$1D,$78,$01,$B5,$00,$7D,$6A,$F9,$55,$14,$31,$8F,$09,$2B,$1D;80BE2C;      ;
                       db $09,$15,$FC,$0A,$7B,$02,$92,$01   ;80BE3C;      ;
                                                            ;      ;      ;
          UNK_Table11: db $6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BE44;      ;
                       db $6B,$6B,$6B,$6B,$6B,$6C,$6B,$6B,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BE54;      ;
                       db $6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE64;      ;
                       db $6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE74;      ;
                       db $6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE84;      ;
                       db $6B,$6B,$6C,$6C,$6C,$6C,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE94;      ;
                       db $6B,$6B,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BEA4;      ;
                       db $6B,$6C,$6B,$6C,$6B,$6B,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BEB4;      ;
                       db $6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BEC4;      ;
                       db $6B,$6C,$6B,$6C,$6B,$6C,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BED4;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ;80BEE4;      ;

incsrc "src/code_banks/bank_80_pointersubrutines.asm"


UNK_Pointer42_Table: db $79,$7F,$10,$11,$3A,$10,$8E,$6A,$10,$0D,$5E,$10,$D2,$6A,$10,$0D;80DD5B;      ;
                       db $5E,$10,$8E,$6A,$10,$11,$3A,$10,$FE,$FF,$5B,$DD,$80,$D2,$6A,$10;80DD6B;      ;
                       db $8E,$6A,$10,$0D,$5E,$10,$D2,$6A,$10,$11,$3A,$10,$D2,$6A,$10,$0D;80DD7B;      ;
                       db $5E,$10,$8E,$6A,$10,$FE,$FF,$78,$DD,$80,$8E,$6A,$10,$0D,$5E,$10;80DD8B;      ;
                       db $D2,$6A,$10,$11,$3A,$10,$0D,$5E,$10,$11,$3A,$10,$D2,$6A,$10,$0D;80DD9B;      ;
                       db $5E,$10,$FE,$FF,$95,$DD,$80,$0D,$5E,$10,$D2,$6A,$10,$53,$42,$10;80DDAB;      ;
                       db $0D,$5E,$10,$8E,$6A,$10,$0D,$5E,$10,$53,$42,$10,$D2,$6A,$10,$FE;80DDBB;      ;
                       db $FF,$B2,$DD,$80,$9D,$53,$10,$12,$2E,$10,$FB,$1D,$10,$94,$1D,$10;80DDCB;      ;
                       db $FE,$2E,$10,$94,$1D,$10,$FB,$1D,$10,$12,$2E,$10,$FE,$FF,$CF,$DD;80DDDB;      ;
                       db $80,$FE,$2E,$10,$FB,$1D,$10,$94,$1D,$10,$FE,$2E,$10,$12,$2E,$10;80DDEB;      ;
                       db $FE,$2E,$10,$94,$1D,$10,$FB,$1D,$10,$FE,$FF,$EC,$DD,$80,$FB,$1D;80DDFB;      ;
                       db $10,$94,$1D,$10,$FE,$2E,$10,$12,$2E,$10,$94,$1D,$10,$12,$2E,$10;80DE0B;      ;
                       db $FE,$2E,$10,$94,$1D,$10,$FE,$FF,$09,$DE,$80,$94,$1D,$10,$FE,$2E;80DE1B;      ;
                       db $10,$74,$2E,$10,$FB,$1D,$10,$FB,$1D,$10,$FB,$1D,$10,$74,$2E,$10;80DE2B;      ;
                       db $FE,$2E,$10,$FE,$FF,$26,$DE,$80,$52,$5A,$10,$4C,$31,$10,$6B,$35;80DE3B;      ;
                       db $10,$08,$29,$10,$52,$5A,$10,$08,$29,$10,$6B,$35,$10,$4C,$31,$10;80DE4B;      ;
                       db $FE,$FF,$43,$DE,$80,$EF,$45,$10,$EF,$49,$10,$08,$29,$10,$52,$5A;80DE5B;      ;
                       db $10,$4C,$31,$10,$52,$5A,$10,$08,$29,$10,$EF,$49,$10,$FE,$FF,$60;80DE6B;      ;
                       db $DE,$80,$6B,$35,$10,$4A,$39,$10,$52,$5A,$10,$4C,$31,$10,$08,$29;80DE7B;      ;
                       db $10,$4C,$31,$10,$52,$5A,$10,$4A,$39,$10,$FE,$FF,$7D,$DE,$80,$08;80DE8B;      ;
                       db $29,$10,$52,$5A,$10,$4C,$31,$10,$6B,$35,$10,$6B,$35,$10,$6B,$35;80DE9B;      ;
                       db $10,$4C,$31,$10,$52,$5A,$10,$FE,$FF,$9A,$DE,$80,$6B,$45,$10,$E7;80DEAB;      ;
                       db $1C,$10,$E7,$28,$10,$08,$29,$10,$6B,$45,$10,$08,$29,$10,$E7,$28;80DEBB;      ;
                       db $10,$E7,$1C,$10,$FE,$FF,$B7,$DE,$80,$08,$35,$10,$08,$35,$10,$E7;80DECB;      ;
                       db $28,$10,$08,$29,$10,$6B,$45,$10,$08,$29,$10,$E7,$28,$10,$08,$35;80DEDB;      ;
                       db $10,$FE,$FF,$D4,$DE,$80,$E7,$28,$10,$E7,$28,$10,$6B,$45,$10,$E7;80DEEB;      ;
                       db $1C,$10,$0B,$29,$10,$E7,$1C,$10,$6B,$45,$10,$E7,$28,$10,$FE,$FF;80DEFB;      ;
                       db $F1,$DE,$80,$C5,$28,$10,$6B,$45,$10,$08,$35,$10,$E7,$28,$10,$E7;80DF0B;      ;
                       db $1C,$10,$E7,$28,$10,$08,$35,$10,$6B,$45,$10,$FE,$FF,$0E,$DF,$80;80DF1B;      ;
                       db $99,$7F,$10,$0F,$32,$10,$8E,$5A,$10,$4D,$52,$10,$D2,$62,$10,$4D;80DF2B;      ;
                       db $52,$10,$8E,$5A,$10,$0F,$32,$10,$FE,$FF,$2B,$DF,$80,$D2,$62,$10;80DF3B;      ;
                       db $8E,$5A,$10,$4D,$52,$10,$D2,$62,$10,$0F,$32,$10,$D2,$62,$10,$4D;80DF4B;      ;
                       db $52,$10,$8E,$5A,$10,$FE,$FF,$48,$DF,$80,$8E,$5A,$10,$4D,$52,$10;80DF5B;      ;
                       db $D2,$62,$10,$0F,$32,$10,$8E,$5A,$10,$0F,$32,$10,$D2,$62,$10,$4D;80DF6B;      ;
                       db $52,$10,$FE,$FF,$65,$DF,$80,$4D,$52,$10,$D2,$62,$10,$0F,$32,$10;80DF7B;      ;
                       db $8E,$5A,$10,$4D,$52,$10,$8E,$5A,$10,$0F,$32,$10,$D2,$62,$10,$FE;80DF8B;      ;
                       db $FF,$82,$DF,$80,$FE,$23,$10,$98,$22,$10,$DB,$11,$10,$9B,$02,$10;80DF9B;      ;
                       db $1F,$03,$10,$9B,$02,$10,$DB,$11,$10,$98,$22,$10,$FE,$FF,$9F,$DF;80DFAB;      ;
                       db $80,$1F,$03,$10,$DC,$11,$10,$B6,$01,$10,$1F,$03,$10,$76,$22,$10;80DFBB;      ;
                       db $1F,$03,$10,$B6,$01,$10,$DC,$11,$10,$FE,$FF,$BC,$DF,$80,$DB,$11;80DFCB;      ;
                       db $10,$B6,$01,$10,$1F,$03,$10,$76,$22,$10,$5F,$12,$10,$76,$22,$10;80DFDB;      ;
                       db $1F,$03,$10,$B6,$01,$10,$FE,$FF,$D9,$DF,$80,$B6,$01,$10,$1F,$03;80DFEB;      ;
                       db $10,$76,$22,$10,$DB,$11,$10,$B6,$01,$10,$DB,$11,$10,$76,$22,$10;80DFFB;      ;
                       db $1F,$03,$10,$FE,$FF,$F6,$DF,$80,$CD,$51,$10,$6B,$21,$10,$6B,$49;80E00B;      ;
                       db $10,$87,$45,$10,$CD,$51,$10,$87,$45,$10,$6B,$49,$10,$6B,$21,$10;80E01B;      ;
                       db $FE,$FF,$13,$E0,$80,$6B,$49,$10,$6B,$49,$10,$87,$45,$10,$CD,$51;80E02B;      ;
                       db $10,$6B,$21,$10,$CD,$51,$10,$87,$45,$10,$6B,$49,$10,$FE,$FF,$30;80E03B;      ;
                       db $E0,$80,$DB,$11,$10,$B6,$01,$10,$1F,$03,$10,$76,$22,$10,$5F,$12;80E04B;      ;
                       db $10,$76,$22,$10,$1F,$03,$10,$B6,$01,$10,$FE,$FF,$4D,$E0,$80,$07;80E05B;      ;
                       db $35,$10,$CD,$51,$10,$6B,$21,$10,$6B,$69,$10,$87,$45,$10,$6B,$49;80E06B;      ;
                       db $10,$6B,$21,$10,$CD,$51,$10,$FE,$FF,$6A,$E0,$80,$40,$61,$10,$C6;80E07B;      ;
                       db $20,$10,$04,$41,$10,$C0,$30,$10,$64,$45,$10,$C0,$30,$10,$04,$41;80E08B;      ;
                       db $10,$C6,$20,$10,$FE,$FF,$87,$E0,$80,$64,$45,$10,$04,$41,$10,$C0;80E09B;      ;
                       db $30,$10,$64,$45,$10,$C6,$20,$10,$64,$45,$10,$C0,$30,$10,$04,$41;80E0AB;      ;
                       db $10,$FE,$FF,$A4,$E0,$80,$04,$41,$10,$C0,$30,$10,$64,$45,$10,$C6;80E0BB;      ;
                       db $20,$10,$04,$41,$10,$C6,$20,$10,$64,$45,$10,$C0,$30,$10,$FE,$FF;80E0CB;      ;
                       db $C1,$E0,$80,$C0,$30,$10,$64,$45,$10,$C6,$20,$10,$04,$41,$10,$C0;80E0DB;      ;
                       db $30,$10,$04,$41,$10,$C6,$20,$10,$64,$45,$10,$FE,$FF,$DE,$E0,$80;80E0EB;      ;
                       db $50,$01,$08,$53,$01,$08,$50,$01,$08,$53,$01,$08,$FE,$FF,$FB,$E0;80E0FB;      ;
                       db $80,$D7,$09,$08,$D9,$09,$08,$D7,$09,$08,$D9,$09,$08,$FE,$FF,$0C;80E10B;      ;
                       db $E1,$80,$9F,$02,$08,$9F,$03,$08,$9F,$02,$08,$9F,$03,$08,$FE,$FF;80E11B;      ;
                       db $1D,$E1,$80,$9C,$01,$08,$9F,$02,$08,$9C,$01,$08,$9F,$02,$08,$FE;80E12B;      ;
                       db $FF,$2E,$E1,$80,$38,$01,$08,$9C,$01,$08,$38,$01,$08,$9C,$01,$08;80E13B;      ;
                       db $FE,$FF,$3F,$E1,$80,$EA,$00,$08,$1C,$01,$08,$EA,$00,$08,$EA,$00;80E14B;      ;
                       db $08,$FE,$FF,$50,$E1,$80,$2D,$01,$08,$2D,$01,$08,$2D,$01,$08,$3B;80E15B;      ;
                       db $01,$08,$FE,$FF,$61,$E1,$80,$48,$00,$08,$0C,$00,$08,$FE,$FF,$72;80E16B;      ;
                       db $E1,$80,$17,$00,$08,$1A,$00,$08,$FE,$FF,$7D,$E1,$80,$1F,$00,$08;80E17B;      ;
                       db $7F,$01,$08,$FE,$FF,$88,$E1,$80,$B4,$01,$08,$19,$02,$08,$FE,$FF;80E18B;      ;
                       db $93,$E1,$80,$4C,$00,$08,$52,$00,$08,$FE,$FF,$9E,$E1,$80,$BF,$02;80E19B;      ;
                       db $08,$7F,$01,$08,$FE,$FF,$A9,$E1,$80,$9F,$00,$08,$5F,$03,$08,$FE;80E1AB;      ;
                       db $FF,$B4,$E1,$80,$9F,$02,$08,$9F,$03,$08,$FE,$FF,$BF,$E1,$80,$8D;80E1BB;      ;
                       db $21,$08,$10,$2E,$08,$10,$2E,$08,$10,$2E,$08,$FE,$FF,$CA,$E1,$80;80E1CB;      ;
                       db $9C,$5F,$08,$7B,$5F,$08,$F9,$4A,$08,$7B,$5F,$08,$FE,$FF,$DB,$E1;80E1DB;      ;
                       db $80,$F9,$4A,$08,$F9,$4A,$08,$1F,$26,$08,$F9,$4A,$08,$FE,$FF,$EC;80E1EB;      ;
                       db $E1,$80,$1F,$26,$08,$1F,$26,$08,$3E,$05,$08,$1F,$26,$08,$FE,$FF;80E1FB;      ;
                       db $FD,$E1,$80,$3E,$05,$08,$1F,$26,$08,$F9,$4A,$08,$1F,$26,$08,$FE;80E20B;      ;
                       db $FF,$0E,$E2,$80,$1F,$26,$08,$F9,$4A,$08,$F9,$4A,$08,$F9,$4A,$08;80E21B;      ;
                       db $FE,$FF,$1F,$E2,$80,$BF,$03,$08,$1F,$26,$08,$BF,$03,$08,$1F,$26;80E22B;      ;
                       db $08,$FE,$FF,$30,$E2,$80,$BF,$03,$08,$1F,$26,$08,$3E,$05,$08,$1F;80E23B;      ;
                       db $26,$08,$FE,$FF,$41,$E2,$80,$3F,$12,$08,$BF,$06,$08,$FE,$FF,$52;80E24B;      ;
                       db $E2,$80,$48,$00,$08,$4D,$00,$08,$FE,$FF,$5D,$E2,$80,$1F,$02,$08;80E25B;      ;
                       db $3A,$01,$08,$FE,$FF,$68,$E2,$80,$FA,$00,$08,$3F,$03,$08,$FE,$FF;80E26B;      ;
                       db $73,$E2,$80,$48,$00,$08,$4F,$00,$08,$FE,$FF,$7E,$E2,$80,$9A,$1E;80E27B;      ;
                       db $08,$1F,$1F,$08,$FE,$FF,$89,$E2,$80,$1F,$02,$08,$37,$00,$08,$FE;80E28B;      ;
                       db $FF,$94,$E2,$80,$19,$00,$08,$25,$00,$08,$FE,$FF,$9F,$E2,$80,$7F;80E29B;      ;
                       db $2E,$08,$3F,$23,$08,$FE,$FF,$AA,$E2,$80,$88,$00,$08,$8C,$00,$08;80E2AB;      ;
                       db $FE,$FF,$B5,$E2,$80,$9D,$00,$08,$9F,$02,$08,$FE,$FF,$C0,$E2,$80;80E2BB;      ;
                       db $1F,$02,$08,$1F,$01,$08,$FE,$FF,$CB,$E2,$80,$90,$00,$08,$9C,$00;80E2CB;      ;
                       db $08,$FE,$FF,$D6,$E2,$80,$DE,$01,$08,$BF,$02,$08,$FE,$FF,$E1,$E2;80E2DB;      ;
                       db $80,$4F,$00,$08,$D0,$00,$08,$FE,$FF,$EC,$E2,$80,$0F,$5E,$10,$54;80E2EB;      ;
                       db $4A,$10,$17,$7F,$10,$FE,$FF,$F7,$E2,$80,$54,$4A,$10,$17,$7F,$10;80E2FB;      ;
                       db $0F,$5E,$10,$FE,$FF,$05,$E3,$80,$17,$7F,$10,$0F,$5E,$10,$54,$4A;80E30B;      ;
                       db $10,$FE,$FF,$13,$E3,$80,$13,$42,$10,$57,$42,$10,$FC,$56,$10,$FE;80E31B;      ;
                       db $FF,$21,$E3,$80,$57,$42,$10,$FC,$56,$10,$13,$42,$10,$FE,$FF,$2F;80E32B;      ;
                       db $E3,$80,$FC,$56,$10,$13,$42,$10,$57,$42,$10,$FE,$FF,$3D,$E3,$80;80E33B;      ;
                       db $4A,$3D,$10,$4A,$3D,$10,$8C,$45,$10,$FE,$FF,$4B,$E3,$80,$4A,$3D;80E34B;      ;
                       db $10,$8C,$45,$10,$4A,$3D,$10,$FE,$FF,$59,$E3,$80,$8C,$45,$10,$4A;80E35B;      ;
                       db $3D,$10,$4A,$3D,$10,$FE,$FF,$67,$E3,$80,$29,$31,$10,$08,$29,$10;80E36B;      ;
                       db $6B,$31,$10,$FE,$FF,$75,$E3,$80,$08,$29,$10,$6B,$31,$10,$29,$31;80E37B;      ;
                       db $10,$FE,$FF,$83,$E3,$80,$6B,$31,$10,$29,$31,$10,$08,$29,$10,$FE;80E38B;      ;
                       db $FF,$91,$E3,$80,$50,$62,$10,$71,$72,$10,$79,$7F,$10,$FE,$FF,$9F;80E39B;      ;
                       db $E3,$80,$71,$72,$10,$79,$7F,$10,$50,$62,$10,$FE,$FF,$AD,$E3,$80;80E3AB;      ;
                       db $79,$7F,$10,$50,$62,$10,$71,$72,$10,$FE,$FF,$BB,$E3,$80,$78,$5E;80E3BB;      ;
                       db $10,$54,$56,$10,$19,$7F,$10,$FE,$FF,$C9,$E3,$80,$54,$56,$10,$19;80E3CB;      ;
                       db $7F,$10,$78,$5E,$10,$FE,$FF,$D7,$E3,$80,$19,$7F,$10,$78,$5E,$10;80E3DB;      ;
                       db $54,$56,$10,$FE,$FF,$E5,$E3,$80,$4A,$3D,$10,$4A,$3D,$10,$8C,$45;80E3EB;      ;
                       db $10,$FE,$FF,$F3,$E3,$80,$4A,$3D,$10,$8C,$45,$10,$4A,$3D,$10,$FE;80E3FB;      ;
                       db $FF,$01,$E4,$80,$8C,$45,$10,$4A,$3D,$10,$4A,$3D,$10,$FE,$FF,$0F;80E40B;      ;
                       db $E4,$80,$E7,$30,$10,$E7,$30,$10,$29,$35,$10,$FE,$FF,$1D,$E4,$80;80E41B;      ;
                       db $E7,$30,$10,$29,$35,$10,$E7,$30,$10,$FE,$FF,$2B,$E4,$80,$29,$35;80E42B;      ;
                       db $10,$E7,$30,$10,$E7,$30,$10,$FE,$FF,$39,$E4,$80,$91,$4A,$10,$CE;80E43B;      ;
                       db $62,$10,$74,$63,$10,$FE,$FF,$47,$E4,$80,$CE,$62,$10,$74,$63,$10;80E44B;      ;
                       db $91,$4A,$10,$FE,$FF,$55,$E4,$80,$74,$63,$10,$91,$4A,$10,$CE,$62;80E45B;      ;
                       db $10,$FE,$FF,$63,$E4,$80,$94,$36,$10,$54,$32,$10,$FC,$3A,$10,$FE;80E46B;      ;
                       db $FF,$71,$E4,$80,$54,$32,$10,$FC,$3A,$10,$94,$36,$10,$FE,$FF,$7F;80E47B;      ;
                       db $E4,$80,$EC,$3A,$10,$94,$36,$10,$54,$32,$10,$FE,$FF,$8D,$E4,$80;80E48B;      ;
                       db $CB,$2D,$10,$CB,$2D,$10,$0E,$36,$10,$FE,$FF,$9B,$E4,$80,$CB,$2D;80E49B;      ;
                       db $10,$0E,$36,$10,$CB,$2D,$10,$FE,$FF,$A9,$E4,$80,$0E,$36,$10,$CB;80E4AB;      ;
                       db $2D,$10,$CB,$2D,$10,$FE,$FF,$B7,$E4,$80,$E7,$30,$10,$27,$31,$10;80E4BB;      ;
                       db $6A,$35,$10,$FE,$FF,$C5,$E4,$80,$27,$31,$10,$6A,$35,$10,$E7,$30;80E4CB;      ;
                       db $10,$FE,$FF,$D3,$E4,$80,$6A,$35,$10,$E7,$30,$10,$27,$31,$10,$FE;80E4DB;      ;
                       db $FF,$E1,$E4,$80,$62,$21,$0A,$90,$21,$0A,$D2,$25,$10,$90,$21,$0A;80E4EB;      ;
                       db $FE,$FF,$EF,$E4,$80,$58,$0E,$0A,$9A,$12,$0A,$DC,$16,$10,$9A,$12;80E4FB;      ;
                       db $0A,$FE,$FF,$00,$E5,$80,$7D,$37,$0A,$9F,$47,$0A,$DF,$53,$10,$9F;80E50B;      ;
                       db $47,$0A,$FE,$FF,$11,$E5,$80,$2C,$09,$0A,$6F,$11,$0A,$B1,$11,$10;80E51B;      ;
                       db $6F,$11,$0A,$FE,$FF,$22,$E5,$80,$8E,$0D,$0A,$B1,$0D,$0A,$B4,$0D;80E52B;      ;
                       db $10,$B1,$0D,$0A,$FE,$FF,$33,$E5,$80,$D7,$36,$0A,$19,$37,$0A,$7F;80E53B;      ;
                       db $37,$10,$19,$37,$0A,$FE,$FF,$44,$E5,$80,$DE,$27,$0A,$FF,$3F,$0A;80E54B;      ;
                       db $FF,$53,$10,$FF,$3F,$0A,$FE,$FF,$55,$E5,$80,$6E,$19,$0A,$70,$19;80E55B;      ;
                       db $0A,$92,$19,$10,$70,$19,$0A,$FE,$FF,$66,$E5,$80,$0A,$15,$0A,$4F;80E56B;      ;
                       db $1D,$0A,$90,$1D,$10,$4F,$1D,$0A,$FE,$FF,$77,$E5,$80,$18,$0A,$0A;80E57B;      ;
                       db $1C,$0A,$0A,$9F,$0A,$10,$1C,$0A,$0A,$FE,$FF,$88,$E5,$80,$7C,$2F;80E58B;      ;
                       db $0A,$BE,$2F,$0A,$DF,$4B,$10,$BE,$2F,$0A,$FE,$FF,$99,$E5,$80,$0C;80E59B;      ;
                       db $09,$0A,$6E,$11,$0A,$90,$11,$10,$6E,$11,$0A,$FE,$FF,$AA,$E5,$80;80E5AB;      ;
                       db $E8,$1C,$0A,$0A,$21,$0A,$6F,$21,$10,$0A,$21,$0A,$FE,$FF,$BB,$E5;80E5BB;      ;
                       db $80,$F3,$29,$0A,$19,$2A,$0A,$7B,$32,$10,$19,$2A,$0A,$FE,$FF,$CC;80E5CB;      ;
                       db $E5,$80,$B8,$3E,$0A,$3D,$3F,$0A,$7F,$43,$10,$3D,$3F,$0A,$FE,$FF;80E5DB;      ;
                       db $DD,$E5,$80,$6C,$1D,$0A,$8E,$21,$0A,$AF,$25,$10,$8E,$21,$0A,$FE;80E5EB;      ;
                       db $FF,$EE,$E5,$80,$3B,$7F,$10,$B5,$6E,$10,$2E,$5E,$0F,$F0,$51,$10;80E5FB;      ;
                       db $33,$52,$0C,$B7,$6E,$10,$FE,$FF,$FF,$E5,$80,$B7,$6E,$10,$2E,$5E;80E60B;      ;
                       db $10,$F0,$51,$0F,$39,$7F,$10,$F0,$51,$0C,$33,$52,$10,$FE,$FF,$16;80E61B;      ;
                       db $E6,$80,$2E,$5E,$10,$F0,$51,$10,$3B,$7F,$0F,$B7,$6E,$10,$39,$7F;80E62B;      ;
                       db $0C,$D1,$4D,$10,$FE,$FF,$2D,$E6,$80,$F0,$51,$10,$39,$7F,$10,$B7;80E63B;      ;
                       db $6E,$0F,$2E,$5E,$10,$B7,$6E,$0C,$39,$7F,$10,$FE,$FF,$44,$E6,$80;80E64B;      ;
                       db $F0,$41,$10,$F1,$3D,$10,$11,$42,$0F,$F1,$41,$10,$11,$42,$0C,$F1;80E65B;      ;
                       db $3D,$10,$FE,$FF,$5B,$E6,$80,$7B,$53,$10,$BB,$42,$10,$34,$32,$0F;80E66B;      ;
                       db $33,$32,$10,$34,$32,$0C,$BB,$42,$10,$FE,$FF,$72,$E6,$80,$B8,$42;80E67B;      ;
                       db $10,$34,$32,$10,$33,$32,$0F,$DB,$42,$10,$33,$32,$0C,$34,$32,$10;80E68B;      ;
                       db $FE,$FF,$89,$E6,$80,$34,$32,$10,$33,$32,$10,$DB,$42,$0F,$B8,$32;80E69B;      ;
                       db $10,$DB,$42,$0C,$33,$32,$10,$FE,$FF,$A0,$E6,$80,$33,$32,$10,$DB;80E6AB;      ;
                       db $42,$10,$B8,$32,$0F,$34,$32,$10,$B8,$32,$0C,$DB,$42,$10,$FE,$FF;80E6BB;      ;
                       db $B7,$E6,$80,$B1,$21,$10,$D1,$25,$10,$D1,$29,$0F,$34,$32,$10,$D1;80E6CB;      ;
                       db $29,$0C,$D1,$25,$10,$FE,$FF,$CE,$E6,$80,$13,$32,$10,$8C,$1D,$10;80E6DB;      ;
                       db $CF,$29,$0F,$11,$2E,$10,$CF,$29,$0C,$8C,$1D,$10,$FE,$FF,$E5,$E6;80E6EB;      ;
                       db $80,$F1,$2D,$10,$33,$32,$10,$8C,$1D,$0F,$CF,$29,$10,$8C,$1D,$0C;80E6FB;      ;
                       db $33,$32,$10,$FE,$FF,$FC,$E6,$80,$AF,$21,$10,$11,$2E,$10,$33,$32;80E70B;      ;
                       db $0F,$8C,$1D,$10,$33,$32,$0C,$11,$2E,$10,$FE,$FF,$13,$E7,$80,$6C;80E71B;      ;
                       db $1D,$10,$CF,$29,$10,$11,$2E,$0F,$33,$32,$10,$11,$2E,$0C,$CF,$29;80E72B;      ;
                       db $10,$FE,$FF,$2A,$E7,$80,$4C,$1D,$10,$4C,$1D,$10,$4C,$21,$0F,$4C;80E73B;      ;
                       db $21,$10,$4C,$21,$0C,$4C,$1D,$10,$FE,$FF,$41,$E7,$80,$8B,$21,$10;80E74B;      ;
                       db $2A,$19,$10,$4B,$1D,$0F,$4B,$1D,$10,$4B,$1D,$0C,$2A,$19,$10,$FE;80E75B;      ;
                       db $FF,$58,$E7,$80,$4B,$1D,$10,$6B,$21,$10,$2A,$19,$0F,$4B,$1D,$10;80E76B;      ;
                       db $2A,$19,$0C,$6B,$21,$10,$FE,$FF,$6F,$E7,$80,$2A,$1D,$10,$48,$1D;80E77B;      ;
                       db $10,$4B,$21,$0F,$2A,$19,$10,$4B,$21,$0C,$48,$1D,$10,$FE,$FF,$86;80E78B;      ;
                       db $E7,$80,$28,$19,$10,$4B,$1D,$10,$4B,$1D,$0F,$6B,$1D,$10,$4B,$1D;80E79B;      ;
                       db $0C,$4B,$1D,$10,$FE,$FF,$9D,$E7,$80,$52,$7F,$10,$66,$5D,$10,$86;80E7AB;      ;
                       db $7D,$0F,$4B,$7E,$10,$86,$7D,$0C,$66,$5D,$10,$FE,$FF,$B4,$E7,$80;80E7BB;      ;
                       db $4B,$7E,$10,$32,$4F,$10,$66,$5D,$0F,$86,$7D,$10,$66,$5D,$0C,$32;80E7CB;      ;
                       db $7F,$10,$FE,$FF,$CB,$E7,$80,$86,$7D,$10,$4B,$7E,$10,$32,$7F,$0F;80E7DB;      ;
                       db $66,$5D,$10,$32,$7F,$0C,$4B,$7E,$10,$FE,$FF,$E2,$E7,$80,$66,$5D;80E7EB;      ;
                       db $10,$86,$7D,$10,$4B,$7E,$0F,$32,$7F,$10,$4B,$7E,$0C,$86,$7D,$10;80E7FB;      ;
                       db $FE,$FF,$F9,$E7,$80,$66,$5D,$10,$86,$61,$10,$86,$65,$0F,$A6,$69;80E80B;      ;
                       db $10,$86,$65,$0C,$86,$61,$10,$FE,$FF,$10,$E8,$80,$9E,$3F,$10,$9E;80E81B;      ;
                       db $16,$10,$18,$12,$0F,$74,$11,$10,$18,$12,$0C,$9E,$16,$10,$FE,$FF;80E82B;      ;
                       db $27,$E8,$80,$9E,$16,$10,$18,$12,$10,$74,$11,$0F,$FA,$2A,$10,$74;80E83B;      ;
                       db $11,$0C,$18,$12,$10,$FE,$FF,$3E,$E8,$80,$18,$12,$10,$74,$11,$10;80E84B;      ;
                       db $9E,$3F,$0F,$9E,$16,$10,$9E,$3F,$0C,$74,$11,$10,$FE,$FF,$55,$E8;80E85B;      ;
                       db $80,$74,$11,$10,$7B,$26,$10,$9E,$16,$0F,$18,$12,$10,$9E,$16,$0C;80E86B;      ;
                       db $7B,$26,$10,$FE,$FF,$6C,$E8,$80,$B1,$1D,$10,$B2,$1D,$10,$B3,$1D;80E87B;      ;
                       db $0F,$B3,$1D,$10,$B3,$1D,$0C,$B2,$1D,$10,$FE,$FF,$83,$E8,$80,$B3;80E88B;      ;
                       db $0D,$10,$B3,$09,$10,$91,$09,$0F,$72,$01,$10,$91,$09,$0C,$B3,$09;80E89B;      ;
                       db $10,$FE,$FF,$9A,$E8,$80,$B3,$09,$10,$91,$09,$10,$72,$01,$0F,$B3;80E8AB;      ;
                       db $0D,$10,$72,$01,$0C,$91,$09,$10,$FE,$FF,$B1,$E8,$80,$91,$09,$10;80E8BB;      ;
                       db $72,$01,$10,$B3,$0D,$0F,$B3,$09,$10,$B3,$0D,$0C,$72,$01,$10,$FE;80E8CB;      ;
                       db $FF,$C8,$E8,$80,$72,$01,$10,$B3,$0D,$10,$B3,$09,$0F,$91,$09,$10;80E8DB;      ;
                       db $B3,$09,$0C,$B3,$0D,$10,$FE,$FF,$DF,$E8,$80,$4E,$19,$10,$0C,$11;80E8EB;      ;
                       db $10,$0B,$11,$0F,$0B,$11,$10,$0B,$11,$0C,$0C,$11,$10,$FE,$FF,$F6;80E8FB;      ;
                       db $E8,$80,$0C,$11,$10,$0B,$11,$10,$0B,$11,$0F,$4E,$19,$10,$0B,$11;80E90B;      ;
                       db $0C,$0B,$11,$10,$FE,$FF,$0D,$E9,$80,$0B,$11,$10,$0B,$11,$10,$4E;80E91B;      ;
                       db $19,$0F,$0C,$11,$10,$4E,$19,$0C,$0B,$11,$10,$FE,$FF,$24,$E9,$80;80E92B;      ;
                       db $0B,$11,$10,$4E,$19,$10,$0C,$11,$0F,$0B,$11,$10,$0C,$11,$0C,$4E;80E93B;      ;
                       db $19,$10,$FE,$FF,$3B,$E9,$80,$AC,$21,$10,$8B,$1D,$10,$2B,$0D,$0F;80E94B;      ;
                       db $2B,$0D,$10,$2B,$0D,$0C,$8B,$1D,$10,$FE,$FF,$52,$E9,$80,$2B,$0D;80E95B;      ;
                       db $10,$2B,$0D,$10,$8B,$1D,$0F,$AC,$21,$10,$8B,$1D,$0C,$2B,$0D,$10;80E96B;      ;
                       db $FE,$FF,$69,$E9,$80,$FE,$32,$10,$EE,$21,$10,$D1,$29,$0F,$14,$22;80E97B;      ;
                       db $10,$D1,$29,$0C,$EE,$21,$10,$FE,$FF,$80,$E9,$80,$F5,$29,$10,$76;80E98B;      ;
                       db $2E,$10,$EE,$21,$0F,$D1,$29,$10,$EE,$21,$0C,$76,$2E,$10,$FE,$FF;80E99B;      ;
                       db $97,$E9,$80,$F4,$15,$10,$14,$32,$10,$33,$2E,$0F,$EE,$21,$10,$33;80E9AB;      ;
                       db $2E,$0C,$14,$32,$10,$FE,$FF,$AE,$E9,$80,$D3,$1D,$10,$D1,$29,$10;80E9BB;      ;
                       db $34,$2E,$0F,$D1,$1D,$10,$34,$2E,$0C,$D1,$29,$10,$FE,$FF,$C5,$E9;80E9CB;      ;
                       db $80,$EF,$25,$10,$CE,$25,$10,$AE,$25,$0F,$AD,$25,$10,$AE,$25,$0C;80E9DB;      ;
                       db $CE,$25,$10,$FE,$FF,$DC,$E9,$80,$4E,$21,$10,$4F,$1D,$10,$B4,$1D;80E9EB;      ;
                       db $0F,$B4,$1D,$10,$B4,$1D,$0C,$4F,$1D,$10,$FE,$FF,$F3,$E9,$80,$B4;80E9FB;      ;
                       db $1D,$10,$72,$1D,$10,$72,$1D,$0F,$4F,$1D,$10,$72,$1D,$0C,$72,$1D;80EA0B;      ;
                       db $10,$FE,$FF,$0A,$EA,$80,$7F,$37,$10,$B0,$21,$10,$1C,$16,$0F,$59;80EA1B;      ;
                       db $1A,$10,$1C,$16,$0C,$B0,$21,$10,$FE,$FF,$21,$EA,$80,$59,$1A,$10;80EA2B;      ;
                       db $9B,$1A,$10,$B0,$21,$0F,$1C,$16,$10,$B0,$21,$0C,$9B,$1A,$10,$FE;80EA3B;      ;
                       db $FF,$38,$EA,$80,$1C,$16,$10,$59,$1A,$10,$1F,$1B,$0F,$B0,$21,$10;80EA4B;      ;
                       db $1F,$1B,$0C,$59,$1A,$10,$FE,$FF,$4F,$EA,$80,$94,$09,$10,$1C,$16;80EA5B;      ;
                       db $10,$59,$1A,$0F,$9B,$1A,$10,$59,$1A,$0C,$1C,$16,$10,$FE,$FF,$66;80EA6B;      ;
                       db $EA,$80,$90,$21,$10,$B0,$21,$10,$91,$21,$0F,$B1,$21,$10,$91,$21;80EA7B;      ;
                       db $0C,$B0,$21,$10,$FE,$FF,$7D,$EA,$80,$4C,$1D,$10,$8E,$21,$10,$B0;80EA8B;      ;
                       db $21,$0F,$B2,$21,$10,$B0,$21,$0C,$8E,$21,$10,$FE,$FF,$94,$EA,$80;80EA9B;      ;
                       db $B2,$21,$10,$4C,$1D,$10,$8E,$21,$0F,$B0,$21,$10,$8E,$21,$0C,$4C;80EAAB;      ;
                       db $1D,$10,$FE,$FF,$AB,$EA,$80,$B0,$21,$10,$B2,$21,$10,$4C,$1D,$0F;80EABB;      ;
                       db $8E,$21,$10,$4C,$1D,$0C,$B2,$21,$10,$FE,$FF,$C2,$EA,$80,$8E,$21;80EACB;      ;
                       db $10,$B0,$21,$10,$B2,$21,$0F,$4C,$1D,$10,$B2,$21,$0C,$B0,$21,$10;80EADB;      ;
                       db $FE,$FF,$D9,$EA,$80,$6C,$1D,$10,$09,$15,$10,$2C,$1D,$0F,$4C,$1D;80EAEB;      ;
                       db $10,$2C,$1D,$0C,$09,$15,$10,$FE,$FF,$F0,$EA,$80,$4C,$1D,$10,$6C;80EAFB;      ;
                       db $1D,$10,$09,$15,$0F,$2C,$1D,$10,$09,$15,$0C,$6C,$1D,$10,$FE,$FF;80EB0B;      ;
                       db $07,$EB,$80,$2C,$1D,$10,$4C,$1D,$10,$6C,$1D,$0F,$09,$15,$10,$6C;80EB1B;      ;
                       db $1D,$0C,$4C,$1D,$10,$FE,$FF,$1E,$EB,$80,$09,$15,$10,$2C,$1D,$10;80EB2B;      ;
                       db $4C,$1D,$0F,$6C,$1D,$10,$4C,$1D,$0C,$2C,$1D,$10,$FE,$FF,$35,$EB;80EB3B;      ;
                       db $80,$DB,$77,$10,$98,$73,$10,$98,$73,$10,$98,$73,$10,$FE,$FF,$4C;80EB4B;      ;
                       db $EB,$80,$98,$73,$10,$98,$73,$10,$DB,$77,$10,$98,$73,$10,$FE,$FF;80EB5B;      ;
                       db $5D,$EB,$80,$7D,$5F,$10,$3B,$4B,$10,$3B,$4B,$10,$3B,$4B,$10,$FE;80EB6B;      ;
                       db $FF,$6E,$EB,$80,$3B,$4B,$10,$3B,$4B,$10,$7D,$5F,$10,$3B,$4B,$10;80EB7B;      ;
                       db $FE,$FF,$7F,$EB,$80,$95,$32,$10,$52,$2E,$10,$52,$2E,$10,$52,$2E;80EB8B;      ;
                       db $10,$FE,$FF,$90,$EB,$80,$52,$2E,$10,$52,$2E,$10,$95,$32,$10,$52;80EB9B;      ;
                       db $2E,$10,$FE,$FF,$A1,$EB,$80,$4A,$31,$10,$29,$2D,$10,$29,$2D,$10;80EBAB;      ;
                       db $29,$2D,$10,$FE,$FF,$B2,$EB,$80,$29,$2D,$10,$29,$2D,$10,$4A,$31;80EBBB;      ;
                       db $10,$29,$2D,$10,$FE,$FF,$C3,$EB,$80,$99,$77,$10,$34,$63,$10,$34;80EBCB;      ;
                       db $63,$10,$34,$63,$10,$FE,$FF,$D4,$EB,$80,$34,$63,$10,$34,$63,$10;80EBDB;      ;
                       db $DB,$77,$10,$34,$63,$10,$FE,$FF,$E5,$EB,$80,$7E,$67,$10,$1C,$47;80EBEB;      ;
                       db $10,$1C,$47,$10,$1C,$47,$10,$FE,$FF,$F6,$EB,$80,$1C,$47,$10,$1C;80EBFB;      ;
                       db $47,$10,$7E,$67,$10,$1C,$47,$10,$FE,$FF,$07,$EC,$80,$94,$56,$10;80EC0B;      ;
                       db $31,$4E,$10,$31,$4E,$10,$31,$4E,$10,$FE,$FF,$18,$EC,$80,$31,$4E;80EC1B;      ;
                       db $10,$31,$4E,$10,$94,$56,$10,$31,$4E,$10,$FE,$FF,$29,$EC,$80,$8C;80EC2B;      ;
                       db $49,$10,$4A,$41,$10,$4A,$41,$10,$4A,$41,$10,$FE,$FF,$3A,$EC,$80;80EC3B;      ;
                       db $4A,$41,$10,$4A,$41,$10,$8C,$49,$10,$4A,$41,$10,$FE,$FF,$4B,$EC;80EC4B;      ;
                       db $80,$76,$73,$10,$34,$63,$10,$34,$63,$10,$34,$63,$10,$FE,$FF,$5C;80EC5B;      ;
                       db $EC,$80,$34,$63,$10,$34,$63,$10,$76,$73,$10,$34,$63,$10,$FE,$FF;80EC6B;      ;
                       db $6D,$EC,$80,$7F,$53,$10,$FB,$42,$10,$FB,$42,$10,$FB,$42,$10,$FE;80EC7B;      ;
                       db $FF,$7E,$EC,$80,$FB,$42,$10,$FB,$42,$10,$7F,$53,$10,$FB,$42,$10;80EC8B;      ;
                       db $FE,$FF,$8F,$EC,$80,$71,$46,$10,$31,$3E,$10,$31,$3E,$10,$31,$3E;80EC9B;      ;
                       db $10,$FE,$FF,$A0,$EC,$80,$31,$3E,$10,$31,$3E,$10,$71,$46,$10,$31;80ECAB;      ;
                       db $3E,$10,$FE,$FF,$B1,$EC,$80,$6A,$31,$10,$49,$2D,$10,$49,$2D,$10;80ECBB;      ;
                       db $49,$2D,$10,$FE,$FF,$C2,$EC,$80,$49,$2D,$10,$49,$2D,$10,$6A,$31;80ECCB;      ;
                       db $10,$49,$2D,$10,$FE,$FF,$C2,$EC,$80,$9B,$77,$10,$77,$73,$10,$77;80ECDB;      ;
                       db $73,$10,$77,$73,$10,$FE,$FF,$E4,$EC,$80,$77,$73,$10,$77,$73,$10;80ECEB;      ;
                       db $9B,$77,$10,$77,$73,$10,$FE,$FF,$F5,$EC,$80,$59,$6F,$10,$37,$6B;80ECFB;      ;
                       db $10,$37,$6B,$10,$37,$6B,$10,$FE,$FF,$06,$ED,$80,$37,$6B,$10,$37;80ED0B;      ;
                       db $6B,$10,$59,$6F,$10,$37,$6B,$10,$FE,$FF,$17,$ED,$80,$B5,$5A,$10;80ED1B;      ;
                       db $73,$52,$10,$73,$52,$10,$73,$52,$10,$FE,$FF,$28,$ED,$80,$73,$52;80ED2B;      ;
                       db $10,$73,$52,$10,$B5,$5A,$10,$73,$52,$10,$FE,$FF,$39,$ED,$80,$EE;80ED3B;      ;
                       db $4D,$10,$CE,$45,$10,$CE,$45,$10,$CE,$45,$10,$FE,$FF,$4A,$ED,$80;80ED4B;      ;
                       db $CE,$45,$10,$CE,$45,$10,$EE,$4D,$10,$CE,$45,$10,$FE,$FF,$5B,$ED;80ED5B;      ;
                       db $80,$85,$51,$0C,$E8,$61,$0C,$4C,$6E,$0C,$0C,$7F,$0C,$4C,$6E,$0C;80ED6B;      ;
                       db $E8,$61,$0C,$FE,$FF,$6C,$ED,$80,$E7,$69,$0C,$88,$79,$0C,$E7,$69;80ED7B;      ;
                       db $0C,$67,$61,$0C,$E7,$69,$0C,$88,$79,$0C,$FE,$FF,$83,$ED,$80,$2C;80ED8B;      ;
                       db $7E,$0F,$97,$7F,$0F,$53,$7F,$0F,$E7,$7E,$0F,$FE,$FF,$9A,$ED,$80;80ED9B;      ;
                       db $EF,$7E,$0F,$2C,$7E,$0F,$97,$7F,$0F,$53,$7F,$0F,$FE,$FF,$AB,$ED;80EDAB;      ;
                       db $80,$53,$7F,$0F,$EF,$7E,$0F,$2C,$7E,$0F,$97,$7F,$0F,$FE,$FF,$BC;80EDBB;      ;
                       db $ED,$80,$97,$7F,$0F,$53,$7F,$0F,$E7,$7E,$0F,$2C,$7E,$0F,$FE,$FF;80EDCB;      ;
                       db $CD,$ED,$80,$70,$00,$0F,$5F,$0E,$0F,$FF,$03,$0F,$FE,$FF,$DE,$ED;80EDDB;      ;
                       db $80,$5F,$0E,$0F,$70,$00,$0F,$FF,$03,$0F,$FE,$FF,$EC,$ED,$80,$FF;80EDEB;      ;
                       db $03,$0F,$5F,$0E,$0F,$70,$00,$0F,$FE,$FF,$FA,$ED,$80,$0C,$00,$08;80EDFB;      ;
                       db $0A,$00,$08,$09,$00,$08,$FE,$FF,$08,$EE,$80,$0A,$00,$08,$D8,$00;80EE0B;      ;
                       db $08,$7E,$02,$08,$FE,$FF,$16,$EE,$80,$7F,$01,$08,$9F,$02,$08,$D2;80EE1B;      ;
                       db $00,$08,$FE,$FF,$24,$EE,$80,$1F,$03,$08,$5F,$03,$08,$FF,$03,$08;80EE2B;      ;
                       db $FE,$FF,$32,$EE,$80,$79,$22,$10,$9B,$22,$10,$DC,$22,$10,$FE,$FF;80EE3B;      ;
                       db $40,$EE,$80,$54,$08,$10,$DE,$08,$10,$DC,$08,$10,$FE,$FF,$4E,$EE;80EE4B;      ;
                       db $80,$9D,$08,$10,$DE,$08,$10,$1F,$09,$10,$FE,$FF,$5C,$EE,$80,$DF;80EE5B;      ;
                       db $08,$10,$DF,$08,$10,$1F,$0A,$10,$FE,$FF,$6A,$EE,$80,$DF,$08,$10;80EE6B;      ;
                       db $3F,$0A,$10,$9F,$0A,$10,$FE,$FF,$78,$EE,$80,$9F,$02,$10,$9F,$02;80EE7B;      ;
                       db $10,$1F,$03,$10,$FE,$FF,$86,$EE,$80,$5F,$03,$10,$DF,$03,$10,$FF;80EE8B;      ;
                       db $03,$10,$FE,$FF,$94,$EE,$80,$3C,$0A,$0C,$DB,$00,$0C,$DF,$00,$0C;80EE9B;      ;
                       db $DF,$00,$0C,$FE,$FF,$A2,$EE,$80,$B3,$09,$0C,$FF,$11,$0C,$5F,$0A;80EEAB;      ;
                       db $0C,$5F,$12,$0C,$FE,$FF,$B3,$EE,$80,$92,$09,$0C,$15,$0A,$0C,$3A;80EEBB;      ;
                       db $02,$0C,$3F,$13,$0C,$FE,$FF,$C4,$EE,$80,$98,$2A,$10,$3D,$43,$10;80EECB;      ;
                       db $98,$2A,$10,$7F,$4F,$10,$5F,$4F,$10,$3D,$43,$10,$FE,$FF,$D5,$EE;80EEDB;      ;
                       db $80,$FA,$42,$10,$98,$2A,$10,$FA,$42,$10,$DB,$2A,$10,$1C,$37,$10;80EEEB;      ;
                       db $98,$2A,$10,$DB,$2A,$10,$FE,$FF,$EC,$EE,$80,$49,$00,$08,$4C,$00;80EEFB;      ;
                       db $08,$FE,$FF,$06,$EF,$80,$37,$00,$08,$3D,$01,$08,$FE,$FF,$11,$EF;80EF0B;      ;
                       db $80,$5F,$02,$08,$DF,$02,$08,$FE,$FF,$1C,$EF,$80,$00;80EF1B;      ;

                       ;these are required for asar or it adds random stuff at the end
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00