ORG $858000

;;;;;;;;Gets called every time a sprite is added?
CODE_858000:
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
        BCS .onsecondbank
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .bankselected

    .onsecondbank:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .bankselected:
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDX.W #$0000
        LDY.W #$0000
        LDA.B $DC
        CMP.W #$0028
        BEQ .findemptyslot
        INC A
        STA.B $DC

    .findemptyslot:
            LDA.W $019C,X
            BEQ .CODE_858046
            TXA
            CLC
            ADC.W #$0024
            TAX
            INY
            CPY.B $DC
            BNE .findemptyslot

        LDA.W #$FFFF
        STA.B $A7
        BRA return85

    .CODE_858046:
        STY.B $A5
        LDA.W #$7777
        STA.W $019C,X
        LDA.B $A1
        STA.W $019E,X
        LDA.B $9F
        STA.W $01A0,X
        LDA.B $A3
        STA.W $01A2,X
        LDA.B $9B
        STA.W $01A4,X
        LDA.B $9D
        STA.W $01A6,X
        STX.B $A9
        LDA.B $A1
        CMP.W #$0262
        BCS .CODE_85807D
        LDA.W $019E,X
        ASL A
        TAX
        LDA.L DATA8_868080,X
        STA.B $75
        BRA .CODE_85808C

    .CODE_85807D:
        LDA.W $019E,X
        SEC
        SBC.W #$0262
        ASL A
        TAX
        LDA.L UNK_Table15,X
        STA.B $75

    .CODE_85808C:
        LDX.B $A9
        LDA.B $75
        STA.W $01A8,X
        CLC
        ADC.W #$0003
        STA.W $01AA,X
        LDY.W #$0000
        LDA.B [$75],Y
        STA.W $01AC,X
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$75],Y
        STA.W $01AE,X
        %Set16bit(!M)
        JSR.W CODE_858AE5
        %Set16bit(!M)
        LDA.W #$0000
        STA.B $A7

;;;;;;;; Return of many functions
return85: RTL

;;;;;;;;
    CODE_8580B9:
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
        BCS .CODE_8580CC
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .CODE_8580D4

    .CODE_8580CC:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .CODE_8580D4:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L UNK_Table14,X
        STA.B $A9
        TAX
        LDA.W #$0001
        STA.B $A7
        LDA.W $019C,X
        BEQ .CODE_8580FF
        LDA.B $9F
        STA.W $01A0,X
        LDA.B $9B
        STA.W $01A4,X
        LDA.B $9D
        STA.W $01A6,X
        LDA.W #$0000
        STA.B $A7

    .CODE_8580FF: RTL

;;;;;;;;
        CODE_858100:
        %Set16bit(!MX)
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
        BCS .CODE_858115
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .CODE_85811D

        .CODE_858115:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

        .CODE_85811D:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L UNK_Table14,X
        STA.B $A9
        JSR.W CODE_858B7B
        LDA.B $AF
        BNE return85
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDY.B $A5
        LDX.B $A9
        LDA.B $A1
        STA.W $019E,X
        LDA.B $9F
        STA.W $01A0,X
        LDA.B $A3
        STA.W $01A2,X
        LDA.B $9B
        STA.W $01A4,X
        LDA.B $9D
        STA.W $01A6,X
        STX.B $A9
        LDA.B $A1
        CMP.W #$0262
        BCS .CODE_858168
        LDA.W $019E,X
        ASL A
        TAX
        LDA.L DATA8_868080,X
        STA.B $75
        BRA .CODE_858177

        .CODE_858168:
        LDA.W $019E,X
        SEC
        SBC.W #$0262
        ASL A
        TAX
        LDA.L UNK_Table15,X
        STA.B $75

        .CODE_858177:
        LDX.B $A9
        LDA.B $75
        STA.W $01A8,X
        CLC
        ADC.W #$0003
        STA.W $01AA,X
        LDY.W #$0000
        LDA.B [$75],Y
        STA.W $01AC,X
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$75],Y
        STA.W $01AE,X
        %Set16bit(!M)
        JSR.W CODE_858AE5
        LDA.W #$0000
        STA.B $A7

        RTL

;;;;;;;;
        CODE_8581A2:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L UNK_Table14,X
        STA.B $A9
        JSR.W CODE_858B7B
        LDA.B $AF
        BEQ .CODE_8581B8
        JMP.W return85

        .CODE_8581B8:
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDX.B $A9
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $019C,X
        LDA.W $01AA,X

        RTL

;;;;;;;;
CODE_8581CB:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L UNK_Table14,X
        STA.B $A9
        TAX
        LDA.W $019C,X
        BEQ .CODE_8581F6
        LDA.W $019E,X
        STA.B $A1
        LDA.W $01A0,X
        STA.B $9F
        LDA.W $01A2,X
        STA.B $A3
        LDA.W $01A4,X
        STA.B $9B
        LDA.W $01A6,X
        STA.B $9D

    .CODE_8581F6:
        %Set8bit(!M)
        LDA.W $01AE,X
        %Set8bit(!M)
        CMP.B #$00
        BMI .CODE_858206
        XBA
        LDA.B #$00
        BRA .CODE_858209

    .CODE_858206:
        XBA
        LDA.B #$FF

    .CODE_858209:
        XBA
        %Set16bit(!M)
        STA.B $A7

        RTL

;;;;;;;;
InitializeOBJs: ;85820F
        %Set16bit(!MX)
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262                         ;TODO
        BCS .bank87
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .setadress

    .bank87:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .setadress:
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $0086
        LDY.W #$0000

    .loop:
        LDX.W $0086
        LDA.W #$0000
        STA.W $019C,X
        LDA.W #$0000
        STA.W $019E,X
        LDA.W #$0000
        STA.W $01A0,X
        LDA.W #$0000
        STA.W $01A2,X
        LDA.W #$0000
        STA.W $01A4,X
        LDA.W #$0000
        STA.W $01A6,X
        LDA.W #$0000
        STA.W $01A8,X
        LDA.W #$0000
        STA.W $01AA,X
        LDA.W #$0000
        STA.W $01AC,X
        LDA.W #$0000
        STA.W $01AE,X
        %Set8bit(!M)
        LDA.B #$FF
        STA.W $01B0,X
        STA.W $01B1,X
        STA.W $01B2,X
        STA.W $01B3,X
        STA.W $01B4,X
        STA.W $01B5,X
        STA.W $01B6,X
        STA.W $01B7,X
        STA.W $01B8,X
        STA.W $01B9,X
        STA.W $01BA,X
        STA.W $01BB,X
        STA.W $01BC,X
        STA.W $01BD,X
        STA.W $01BE,X
        STA.W $01BF,X
        %Set16bit(!M)
        LDA.W $0086
        CLC
        ADC.W #$0024
        STA.W $0086
        INY
        CPY.W #$0028
        BEQ .skip
        JMP.W .loop

    .skip:
        %Set16bit(!M)
        STZ.B $DC
        JSR.W PresetsWRAMCopyofOAM

        RTL

;;;;;;;;
CODE_8582C7:
        %Set16bit(!MX)
        STZ.B $A9
        STZ.B $AB

    .CODE_8582CD:
            LDX.B $A9
            LDA.W $019C,X
            BNE .CODE_8582E7

        .CODE_8582D4:
            LDA.B $A9
            CLC
            ADC.W #$0024
            STA.B $A9
            INC.B $AB
            LDA.B $AB
            CMP.B $DC
            BNE .CODE_8582CD

        JMP.W .CODE_858376

    .CODE_8582E7:
        %Set16bit(!MX)
        LDA.W $019E,X
        CMP.W #$0262
        BCS .CODE_8582FB
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .CODE_858303

    .CODE_8582FB:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .CODE_858303:
        %Set8bit(!M)
        LDA.W $01AE,X
        BNE .CODE_858349
        %Set16bit(!M)
        JSR.W CODE_858B7B
        LDA.B $AF
        BNE .CODE_8582D4
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDX.B $A9
        LDA.W $01AA,X
        STA.B $75

    .CODE_85831F:
        LDA.B [$75]
        BNE .CODE_85832A
        LDA.W $01A8,X
        STA.B $75
        BRA .CODE_85831F

    .CODE_85832A:
        STA.W $01AC,X
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$75],Y
        STA.W $01AE,X
        %Set16bit(!M)
        LDA.B $75
        CLC
        ADC.W #$0003
        STA.W $01AA,X
        JSR.W CODE_858AE5
        %Set16bit(!MX)
        BRA .CODE_858362

    .CODE_858349:
        %Set8bit(!M)
        LDA.W $01AE,X
        CMP.B #$FE
        BNE .CODE_858362
        %Set16bit(!M)
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $019C,X
        JMP.W .CODE_8582D4

    .CODE_858362:
        LDX.B $A9
        %Set8bit(!M)
        LDA.W $01AE,X
        CMP.B #$FF
        BEQ .CODE_858371
        DEC A
        STA.W $01AE,X

    .CODE_858371:
        %Set16bit(!MX)
        JMP.W .CODE_8582D4

    .CODE_858376:
        RTL

;;;;;;;;
UNK_TableReading: ;858377
        %Set16bit(!MX)
        LDA.W $0905
        ASL A
        TAX
        LDA.L UNK_Table14,X
        TAX
        LDA.W $01A6,X
        STA.B $A9
        LDA.W #$0000
        STA.B $AD
        LDA.B $DC
        DEC A
        STA.B $AF
        LDA.W #$FFFF
        STA.B $7E
        LDY.W #$0000
        LDX.W #$0000

    .loop:
            %Set16bit(!M)
            PHX
            CPY.W $0905
            BEQ .CODE_8583C8
            LDA.W $01A6,X
            CMP.B $A9
            BCC .CODE_8583BA
            LDX.B $AD
            TYA
            %Set8bit(!M)
            STA.W $084C,X
            %Set16bit(!M)
            INC.B $AD
            BRA .CODE_8583C8

        .CODE_8583BA:
            %Set16bit(!M)
            LDX.B $AF
            TYA
            %Set8bit(!M)
            STA.W $084C,X
            %Set16bit(!M)
            DEC.B $AF

        .CODE_8583C8:
            %Set16bit(!M)
            PLA
            CLC
            ADC.W #$0024
            TAX
            INY
            CPY.B $DC
            BNE .loop

        LDX.B $AD
        LDA.W $0905
        %Set8bit(!M)
        STA.W $084C,X

        RTS

;;;;;;;;
UNK_BigLoadLoopOAM: ;8583E0
        %Set16bit(!MX)
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
        BCS .sethighbank
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .continue

    .sethighbank:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .continue:
        %Set16bit(!MX)
        JSR.W PresetsWRAMCopyOAMCopy        ;clear the OAM
        JSR.W UNK_TableReading
        %Set16bit(!MX)
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $084C
        %Set16bit(!M)
        ASL A
        TAX
        LDA.L UNK_Table14,X
        STA.B $A9
        LDA.W #$0000
        STA.B $AB
        STA.B $AF
        LDY.B $AB

    ;MOBIUS TRIPLE REACHAROUND, this loop is a bit of a mess
    .loopstart:
            LDX.B $A9
            LDA.W $019C,X
            BNE .CODE_858444

        .CODE_858429:
            INY
            TYX
            %Set8bit(!M)
            LDA.B #$00
            XBA
            LDA.W $084C,X
            %Set16bit(!M)
            ASL A
            TAX
            LDA.L UNK_Table14,X
            STA.B $A9
            CPY.B $DC
            BNE .loopstart
            JMP.W .prepareDMA

        .CODE_858444:
            STY.B $AB
            LDX.B $A9
            LDA.W $019E,X
            CMP.W #$0262
            BCS .CODE_85845A
            %Set8bit(!M)
            LDA.B #$86
            STA.B $77
            STA.B $7A
            BRA .CODE_858462

        .CODE_85845A:
            %Set8bit(!M)
            LDA.B #$87
            STA.B $77
            STA.B $7A

        .CODE_858462:
            %Set16bit(!M)
            LDA.W $01AC,X
            STA.B $78
            LDA.W $01A0,X
            STA.B $9F
            LDA.W $01A4,X
            STA.B $9B
            LDA.W $01A6,X
            STA.B $9D
            %Set8bit(!M)
            LDA.W $01AF,X
            STA.B $AD
            STZ.B $AE
            %Set16bit(!M)
            INC.B $78
            LDA.B $AD
            DEC A
            STA.B $7E
            ASL A
            STA.B $80
            CLC
            ADC.B $7E
            ADC.B $80
            ADC.B $78
            STA.B $78
            LDA.B $A9
            STA.B $75
            CLC
            ADC.B $AD
            SEC
            SBC.W #$0001
            STA.B $75

        .CODE_8584A3:
            LDY.B $AB
            LDA.B $AD
            BNE .CODE_8584AC
            JMP.W .CODE_858429


        .CODE_8584AC:
            LDX.B $75
            %Set8bit(!M)
            LDA.W $01B0,X
            CMP.B #$FF
            BNE .CODE_8584BA
            JMP.W .CODE_8585E3

        .CODE_8584BA:
            %Set16bit(!M)
            LDY.W #$0002
            %Set8bit(!M)
            LDA.B [$78],Y
            %Set8bit(!M)
            CMP.B #$00
            BMI .CODE_8584CE
            XBA
            LDA.B #$00
            BRA .CODE_8584D1

        .CODE_8584CE:
            XBA
            LDA.B #$FF

        .CODE_8584D1:
            XBA
            %Set16bit(!M)
            JSR.W CODE_858BB0
            CLC
            ADC.B $9B
            SEC
            SBC.B !OBJ_Offset_X
            STA.B $BF
            INY
            %Set8bit(!M)
            LDA.B [$78],Y
            %Set8bit(!M)
            CMP.B #$00
            BMI .CODE_8584EF
            XBA
            LDA.B #$00
            BRA .CODE_8584F2

        .CODE_8584EF:
            XBA
            LDA.B #$FF

        .CODE_8584F2:
            XBA
            %Set16bit(!M)
            JSR.W CODE_858BBC
            CLC
            ADC.B $9D
            SEC
            SBC.B !OBJ_Offset_Y
            STA.B $C1
            STY.B $C5
            %Set16bit(!MX)
            LDA.B $AF
            AND.W #$FFE0
            STA.B $7E
            LSR A
            LSR A
            LSR A
            LSR A
            STA.B $80
            LDA.B $AF
            SEC
            SBC.B $7E
            STA.B $7E
            LDA.B $80
            TAX
            LDA.L $7EA200,X
            STA.B $C3
            LDA.B $BF
            CMP.W #$0100
            BCC .posXcalculation
            LDA.B $7E
            AND.W #$FFFC
            LSR A
            TAX
            LDA.L DATA8_858BD0,X
            ORA.B $C3
            STA.B $C3

        .posXcalculation:
            %Set16bit(!M)
            LDA.B $BF
            CMP.W #$0100
            BCC .posYcalculation
            CMP.W #$FFF0
            BCS .posYcalculation
            JMP.W .spritenotonscreen

        .posYcalculation:
            %Set16bit(!M)
            LDA.B $C1
            CMP.W #$00F0
            BCC .storingOAMcopy
            CMP.W #$FFF0
            BCS .storingOAMcopy
            JMP.W .spritenotonscreen

        .storingOAMcopy:
            %Set16bit(!MX)
            LDX.B $AF
            LDA.B $BF
            %Set8bit(!M)
            STA.L $7EA000,X
            %Set16bit(!M)
            LDA.B $C1
            %Set8bit(!M)
            STA.L $7EA001,X
            %Set16bit(!M)
            LDX.B $80
            LDA.B $C3
            STA.L $7EA200,X
            %Set16bit(!MX)
            LDX.B $AF
            LDY.B $C5
            INY
            %Set8bit(!M)
            LDA.B [$78],Y
            STA.B $B2
            ASL A
            AND.B #$0E
            STA.B $B1                        ;Palette?
            LDA.B $B2
            ASL A
            ASL A
            AND.B #$C0                       ;Flip flags?
            LSR A
            STA.B $B2
            ASL A
            ASL A
            ORA.B $B2
            AND.B #$C0
            ORA.B $B1
            ORA.B #$20
            EOR.B $9F
            STA.L $7EA003,X
            LDA.W !current_graphic_preset
            ASL A
            ASL A
            ASL A
            ASL A
            ORA.L $7EA003,X
            STA.L $7EA003,X
            %Set16bit(!M)
            LDA.W #$0000
            LDX.B $75
            %Set8bit(!M)
            LDA.W $01B0,X
            %Set16bit(!M)
            ASL A
            TAX
            LDA.L DATA8_868000,X
            %Set8bit(!M)
            LDX.B $AF
            STA.L $7EA002,X
            %Set16bit(!M)
            LDA.B $AF
            CLC
            ADC.W #$0004
            STA.B $AF

        .spritenotonscreen:
            LDA.B $78
            SEC
            SBC.W #$0005
            STA.B $78
            BRA .jmpsetDMAforOAMcopy

        .CODE_8585E3:
            %Set16bit(!M)
            LDA.B $78
            SEC
            SBC.W #$0005
            STA.B $78

        .jmpsetDMAforOAMcopy:
            DEC.B $75
            DEC.B $AD
            JMP.W .CODE_8584A3

    .prepareDMA:
        %Set16bit(!MX)
        LDA.B $AF
        STA.W $084A
        %Set8bit(!M)
        LDX.W #$0000
        STX.W !OAMADDL                       ;OAM Address Registers
        STZ.W $4340                          ;DMA PortX Control Register
        LDA.B #$04                           ;OAM Data Write Register
        STA.W $4341                          ;DMA PortX Destination Register
        LDA.B #$00
        STA.W $4342                          ;DMA PortX Source Address Registers
        LDA.B #$A0
        STA.W $4343
        LDA.B #$7E
        STA.W $4344
        LDX.W #$0220
        STX.W $4345
        LDA.B $9A
        ORA.B #$10
        STA.B $9A

        RTL

db $01,$00,$04,$00,$10,$00,$40,$00,$00,$01,$00,$04,$00,$10,$00,$40;858627;      ;
db $FC,$FF,$F3,$FF,$CF,$FF,$3F,$FF,$FF,$FC,$FF,$F3,$FF,$CF,$FF,$3F;858637;      ;

;;;;;;;; Loops, ever heard of them?
PresetsWRAMCopyofOAM: ;858647
        %Set16bit(!MX)
        LDA.W #$F0F0
        STA.L $7EA000
        STA.L $7EA004
        STA.L $7EA008
        STA.L $7EA00C
        STA.L $7EA010
        STA.L $7EA014
        STA.L $7EA018
        STA.L $7EA01C
        STA.L $7EA020
        STA.L $7EA024
        STA.L $7EA028
        STA.L $7EA02C
        STA.L $7EA030
        STA.L $7EA034
        STA.L $7EA038
        STA.L $7EA03C
        STA.L $7EA040
        STA.L $7EA044
        STA.L $7EA048
        STA.L $7EA04C
        STA.L $7EA050
        STA.L $7EA054
        STA.L $7EA058
        STA.L $7EA05C
        STA.L $7EA060
        STA.L $7EA064
        STA.L $7EA068
        STA.L $7EA06C
        STA.L $7EA070
        STA.L $7EA074
        STA.L $7EA078
        STA.L $7EA07C
        STA.L $7EA080
        STA.L $7EA084
        STA.L $7EA088
        STA.L $7EA08C
        STA.L $7EA090
        STA.L $7EA094
        STA.L $7EA098
        STA.L $7EA09C
        STA.L $7EA0A0
        STA.L $7EA0A4
        STA.L $7EA0A8
        STA.L $7EA0AC
        STA.L $7EA0B0
        STA.L $7EA0B4
        STA.L $7EA0B8
        STA.L $7EA0BC
        STA.L $7EA0C0
        STA.L $7EA0C4
        STA.L $7EA0C8
        STA.L $7EA0CC
        STA.L $7EA0D0
        STA.L $7EA0D4
        STA.L $7EA0D8
        STA.L $7EA0DC
        STA.L $7EA0E0
        STA.L $7EA0E4
        STA.L $7EA0E8
        STA.L $7EA0EC
        STA.L $7EA0F0
        STA.L $7EA0F4
        STA.L $7EA0F8
        STA.L $7EA0FC
        STA.L $7EA100
        STA.L $7EA104
        STA.L $7EA108
        STA.L $7EA10C
        STA.L $7EA110
        STA.L $7EA114
        STA.L $7EA118
        STA.L $7EA11C
        STA.L $7EA120
        STA.L $7EA124
        STA.L $7EA128
        STA.L $7EA12C
        STA.L $7EA130
        STA.L $7EA134
        STA.L $7EA138
        STA.L $7EA13C
        STA.L $7EA140
        STA.L $7EA144
        STA.L $7EA148
        STA.L $7EA14C
        STA.L $7EA150
        STA.L $7EA154
        STA.L $7EA158
        STA.L $7EA15C
        STA.L $7EA160
        STA.L $7EA164
        STA.L $7EA168
        STA.L $7EA16C
        STA.L $7EA170
        STA.L $7EA174
        STA.L $7EA178
        STA.L $7EA17C
        STA.L $7EA180
        STA.L $7EA184
        STA.L $7EA188
        STA.L $7EA18C
        STA.L $7EA190
        STA.L $7EA194
        STA.L $7EA198
        STA.L $7EA19C
        STA.L $7EA1A0
        STA.L $7EA1A4
        STA.L $7EA1A8
        STA.L $7EA1AC
        STA.L $7EA1B0
        STA.L $7EA1B4
        STA.L $7EA1B8
        STA.L $7EA1BC
        STA.L $7EA1C0
        STA.L $7EA1C4
        STA.L $7EA1C8
        STA.L $7EA1CC
        STA.L $7EA1D0
        STA.L $7EA1D4
        STA.L $7EA1D8
        STA.L $7EA1DC
        STA.L $7EA1E0
        STA.L $7EA1E4
        STA.L $7EA1E8
        STA.L $7EA1EC
        STA.L $7EA1F0
        STA.L $7EA1F4
        STA.L $7EA1F8
        STA.L $7EA1FC
        LDA.W #$0000
        STA.L $7EA200
        STA.L $7EA202
        STA.L $7EA204
        STA.L $7EA206
        STA.L $7EA208
        STA.L $7EA20A
        STA.L $7EA20C
        STA.L $7EA20E
        STA.L $7EA210
        STA.L $7EA212
        STA.L $7EA214
        STA.L $7EA216
        STA.L $7EA218
        STA.L $7EA21A
        STA.L $7EA21C
        STA.L $7EA21E
        LDA.W #$0001
        STA.W $00B7

        RTS

;;;;;;;; Did a diff, this is EXACTLY the same function that the one above
PresetsWRAMCopyOAMCopy:
        %Set16bit(!MX)
        LDA.W #$F0F0
        STA.L $7EA000
        STA.L $7EA004
        STA.L $7EA008
        STA.L $7EA00C
        STA.L $7EA010
        STA.L $7EA014
        STA.L $7EA018
        STA.L $7EA01C
        STA.L $7EA020
        STA.L $7EA024
        STA.L $7EA028
        STA.L $7EA02C
        STA.L $7EA030
        STA.L $7EA034
        STA.L $7EA038
        STA.L $7EA03C
        STA.L $7EA040
        STA.L $7EA044
        STA.L $7EA048
        STA.L $7EA04C
        STA.L $7EA050
        STA.L $7EA054
        STA.L $7EA058
        STA.L $7EA05C
        STA.L $7EA060
        STA.L $7EA064
        STA.L $7EA068
        STA.L $7EA06C
        STA.L $7EA070
        STA.L $7EA074
        STA.L $7EA078
        STA.L $7EA07C
        STA.L $7EA080
        STA.L $7EA084
        STA.L $7EA088
        STA.L $7EA08C
        STA.L $7EA090
        STA.L $7EA094
        STA.L $7EA098
        STA.L $7EA09C
        STA.L $7EA0A0
        STA.L $7EA0A4
        STA.L $7EA0A8
        STA.L $7EA0AC
        STA.L $7EA0B0
        STA.L $7EA0B4
        STA.L $7EA0B8
        STA.L $7EA0BC
        STA.L $7EA0C0
        STA.L $7EA0C4
        STA.L $7EA0C8
        STA.L $7EA0CC
        STA.L $7EA0D0
        STA.L $7EA0D4
        STA.L $7EA0D8
        STA.L $7EA0DC
        STA.L $7EA0E0
        STA.L $7EA0E4
        STA.L $7EA0E8
        STA.L $7EA0EC
        STA.L $7EA0F0
        STA.L $7EA0F4
        STA.L $7EA0F8
        STA.L $7EA0FC
        STA.L $7EA100
        STA.L $7EA104
        STA.L $7EA108
        STA.L $7EA10C
        STA.L $7EA110
        STA.L $7EA114
        STA.L $7EA118
        STA.L $7EA11C
        STA.L $7EA120
        STA.L $7EA124
        STA.L $7EA128
        STA.L $7EA12C
        STA.L $7EA130
        STA.L $7EA134
        STA.L $7EA138
        STA.L $7EA13C
        STA.L $7EA140
        STA.L $7EA144
        STA.L $7EA148
        STA.L $7EA14C
        STA.L $7EA150
        STA.L $7EA154
        STA.L $7EA158
        STA.L $7EA15C
        STA.L $7EA160
        STA.L $7EA164
        STA.L $7EA168
        STA.L $7EA16C
        STA.L $7EA170
        STA.L $7EA174
        STA.L $7EA178
        STA.L $7EA17C
        STA.L $7EA180
        STA.L $7EA184
        STA.L $7EA188
        STA.L $7EA18C
        STA.L $7EA190
        STA.L $7EA194
        STA.L $7EA198
        STA.L $7EA19C
        STA.L $7EA1A0
        STA.L $7EA1A4
        STA.L $7EA1A8
        STA.L $7EA1AC
        STA.L $7EA1B0
        STA.L $7EA1B4
        STA.L $7EA1B8
        STA.L $7EA1BC
        STA.L $7EA1C0
        STA.L $7EA1C4
        STA.L $7EA1C8
        STA.L $7EA1CC
        STA.L $7EA1D0
        STA.L $7EA1D4
        STA.L $7EA1D8
        STA.L $7EA1DC
        STA.L $7EA1E0
        STA.L $7EA1E4
        STA.L $7EA1E8
        STA.L $7EA1EC
        STA.L $7EA1F0
        STA.L $7EA1F4
        STA.L $7EA1F8
        STA.L $7EA1FC
        LDA.W #$0000
        STA.L $7EA200
        STA.L $7EA202
        STA.L $7EA204
        STA.L $7EA206
        STA.L $7EA208
        STA.L $7EA20A
        STA.L $7EA20C
        STA.L $7EA20E
        STA.L $7EA210
        STA.L $7EA212
        STA.L $7EA214
        STA.L $7EA216
        STA.L $7EA218
        STA.L $7EA21A
        STA.L $7EA21C
        STA.L $7EA21E
        LDA.W #$0001
        STA.W $00B7
        RTS

;;;;;;;;
CODE_858AE5:
        %Set16bit(!MX)
        LDX.B $A9
        LDA.W $01AC,X
        STA.B $78
        LDY.W #$0000
        %Set8bit(!M)
        LDA.B [$78],Y
        STA.B $AD
        STA.W $01AF,X
        STZ.B $AE
        %Set16bit(!M)
        INY
        TXA
        CLC
        ADC.W #$019C
        CLC
        ADC.W #$0014
        STA.B $AF

    .loop:
            LDA.B $AD
            BNE .continue
            BRA .exitloop

        .continue:
            LDA.B [$78],Y
            STA.B $B3
            LDA.B $AF
            STA.B $B5
            %Set16bit(!MX)
            PHX
            PHY
            JSR.W CODE_858C30
            %Set16bit(!MX)
            PLY
            PLX
            LDA.B $B3
            AND.W #$00FF
            %Set8bit(!M)
            STA.W $01B0,X
            %Set16bit(!M)
            INX
            INC.B $AF
            TYA
            CLC
            ADC.W #$0005
            TAY
            DEC.B $AD
            BRA .loop

    .exitloop:
        %Set16bit(!MX)
        LDX.B $A9

        RTS

;;;;;;;;
    CODE_858B41:
        %Set16bit(!MX)
        LDX.B $A9
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $01AF,X
        %Set16bit(!M)
        TAY
        %Set8bit(!M)

    .loop:
        CPY.W #$0000
        BEQ .escapeloop
        LDA.W $01B0,X
        CMP.B #$FF
        BEQ .next
        STA.B $B3
        STZ.B $B4
        LDA.B #$FF
        STA.W $01B0,X
        PHY
        PHX
        JSR.W CODE_858C9F
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        PLY

    .next:
        INX
        DEY
        BRA .loop

    .escapeloop:
        %Set16bit(!MX)
        LDX.B $A9

        RTS

CODE_858B7B:
        %Set16bit(!X)
        LDX.B $A9
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $01AF,X
        %Set16bit(!M)
        TAY
        %Set8bit(!M)

    .loop:
        CPY.W #$0000
        BEQ .skip1
        LDA.W $01B0,X
        CMP.B #$FF
        BEQ .skip2
        INX
        DEY
        BRA .loop

    .skip2:
        %Set16bit(!MX)
        INC.W $0740
        LDA.W #$FFFF
        STA.B $AF
        BRA .return

    .skip1:
        %Set16bit(!MX)
        LDA.W #$0000
        STA.B $AF

    .return: RTS

;;;;;;;; You can enter this subrutine trough one of these 2 functions
CODE_858BB0:
        %Set16bit(!MX)
        PHA
        LDA.B $9F
        AND.W #$0040
        BEQ CODE_858BCE
        BRA CODE_858BC4

CODE_858BBC:
        PHA
        LDA.B $9F
        AND.W #$0080
        BEQ CODE_858BCE

    CODE_858BC4:
            PLA
            EOR.W #$FFFF
            INC A
            CLC
            ADC.W #$FFF0
            RTS

    CODE_858BCE:
            PLA
            RTS

DATA8_858BD0: ;858BD0
        db $01,$00,$04,$00,$10,$00,$40,$00,$00,$01,$00,$04,$00,$10,$00,$40


;;;;;;; sums of 24
UNK_Table14:;858BE0
        db $00,$00,$24,$00,$48,$00,$6C,$00,$90,$00,$B4,$00,$D8,$00,$FC,$00
        db $20,$01,$44,$01,$68,$01,$8C,$01,$B0,$01,$D4,$01,$F8,$01,$1C,$02
        db $40,$02,$64,$02,$88,$02,$AC,$02,$D0,$02,$F4,$02,$18,$03,$3C,$03
        db $60,$03,$84,$03,$A8,$03,$CC,$03,$F0,$03,$14,$04,$38,$04,$5C,$04
        db $80,$04,$A4,$04,$C8,$04,$EC,$04,$40,$05,$34,$05,$58,$05,$7C,$05

;;;;;;;; TODO
CODE_858C30:
        %Set16bit(!MX)
        %Set8bit(!M)
        LDX.B $B3
        LDA.B #$00
        XBA
        LDA.L $7F0F00,X
        %Set16bit(!M)
        TAY
        ASL A
        ASL A
        TAX
        CPY.W #$00FF
        BNE .skip
        %Set16bit(!M)
        LDA.B $BD
        TAX
        CLC
        ADC.W #$0004
        CMP.W #$0100
        BNE .loop
        LDA.W #$0000

    .loop:
            CMP.B $BB
            BEQ .loop

        STA.B $BD
        LDA.B $B3
        STA.L $7EA220,X
        LDA.B $B5
        STA.L $7EA222,X
        LDA.W #$FFFF
        STA.B $B3
        BRA .return

    .skip:
        LDA.L $7EA320,X
        INC A
        STA.L $7EA320,X
        TYA
        STA.B $B3

    .return: RTS

UNUSED_TABLE1: dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080;858C7F
               dw $0100,$0200,$0400,$0800,$1000,$2000,$4000,$8000;858C8F

;;;;;;; TODO
CODE_858C9F: ;858C9F
        %Set16bit(!MX)
        LDA.B $B3
        ASL A
        ASL A
        TAX

    .loop320:
        LDA.L $7EA320,X
        BEQ .loop320                         ;Loop till it finds something that is not 0
        DEC A
        STA.L $7EA320,X

        RTS

;;;;;;;; This functions sets what is gonna be copied to the WRAM OBJ temp. TODO
CODE_858CB2:
        %Set8bit(!M)
        LDA.B #128
        STA.B $7A
        %Set16bit(!MX)
        STZ.B $BF

    .loop:
            LDA.B $BD
            CMP.B $BB
            BNE .continue1
            JMP.W .escapeloop

        .continue1:
            LDA.B $C7
            CMP.W #$0100
            BCS .continue2
            JMP.W .escapeloop

        .continue2:
            LDX.B $BB
            LDA.L $7EA220,X
            STA.B $C1
            LDA.L $7EA222,X
            STA.B $78
            LDA.B $C7
            SEC
            SBC.W #$0100
            STA.B $C7
            LDA.B $BB
            CLC
            ADC.W #$0004
            CMP.W #$0100
            BNE .CODE_858CF3
            LDA.W #$0000

        .CODE_858CF3:
            STA.B $BB
            LDA.W $0848
            AND.W #$003F
            INC A
            STA.W $0848
            LDA.W $0846
            CMP.W #$0040
            BEQ .CODE_858D12
            STA.B $C5
            ASL A
            ASL A
            STA.B $C3
            INC.W $0846
            BRA .CODE_858D38

        .CODE_858D12:
            LDY.W #$0000
            LDA.W $0848
            ASL A
            ASL A

    .loop320:                                ;searches for a value
            TAX
            LDA.L $7EA320,X
            BEQ .skip320
            TXA
            CLC
            ADC.W #$0004
            AND.W #$00FF
            INY
            CPY.W #$0040
            BNE .loop320

        .CODE_858D2F:
            BRA .CODE_858D2F                 ;infinite loop again???

        .skip320:
            STX.B $C3
            TXA
            LSR A
            LSR A
            STA.B $C5

        .CODE_858D38:
            LDA.B $C3
            BMI .CODE_858D38                 ;Another psible infinit loop!!!

            LDA.B $C5
            %Set8bit(!M)
            STA.B [$78]
            STA.B $75
            STZ.B $76
            %Set16bit(!M)
            LDX.B $C3
            LDA.W #$0001
            STA.L $7EA320,X
            LDA.L $7EA322,X
            CMP.W #$FFFF
            BEQ .CODE_858D65
            PHX
            TAX
            %Set8bit(!M)
            LDA.B #$FF
            STA.L $7F0F00,X
            PLX

        .CODE_858D65:
            %Set16bit(!M)
            LDA.B $C1
            STA.L $7EA322,X
            LDA.B $C3
            LSR A
            LSR A
            %Set8bit(!M)
            LDX.B $C1
            STA.L $7F0F00,X
            %Set16bit(!M)
            LDA.B $C1
            AND.W #$FFC0
            STA.B $7E
            LSR A
            LSR A
            LSR A
            LSR A
            LSR A
            LSR A
            STA.B $C3
            LDA.B $C1
            SEC
            SBC.B $7E
            STA.B $C1
            LDA.B $C3
            LSR A
            LSR A
            STA.B $7E
            CLC
            ADC.W #$0088
            STA.B $C5
            LDA.B $7E
            ASL A
            ASL A
            STA.B $7E
            LDA.B $C3
            SEC
            SBC.B $7E
            STA.B $C3
            LDA.B $C3
            ASL A
            TAX
            LDA.L Table_of_Multof2000,X
            STA.B $C3
            LDA.B $C1
            ASL A
            TAX
            LDA.L DATA8_868000,X
            %Set8bit(!M)
            STA.W !WRMPYA
            LDA.B #$20
            STA.W !WRMPYB
            %Set16bit(!M)
            NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            LDA.W !RDMPYL
            STA.B $C1
            CLC
            ADC.B $C3
            CLC
            ADC.W #$8000
            STA.B $C3
            LDA.B $75
            ASL A
            TAX
            LDA.L DATA8_868000,X
            %Set8bit(!M)
            STA.W !WRMPYA
            LDA.B #$10
            STA.W !WRMPYB
            %Set16bit(!M)
            NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            NOP
            LDA.W !RDMPYL
            STA.B $75
            LDX.B $BF
            LDA.B $C3
            STA.L $7EA420,X
            LDA.B $C5
            STA.L $7EA422,X
            LDA.B $75
            STA.L $7EA424,X
            LDA.W #$FFFF
            STA.L $7EA426,X
            LDA.B $BF
            CLC
            ADC.W #$0006

        .infiniteloop:
            CMP.W #$00C0
            BEQ .infiniteloop

            STA.B $BF
            JMP.W .loop

    .escapeloop:
        %Set8bit(!M)
        LDA.B $BB
        CMP.B $BD
        BCS .CODE_858E37
        LDA.B $BD
        SEC
        SBC.B $BB
        BRA .CODE_858E3C

    .CODE_858E37:
        LDA.B $BB
        SEC
        SBC.B $BD

    .CODE_858E3C:
        LSR A
        LSR A
        STA.W $0742
        STZ.W $0743
        %Set16bit(!M)

        RTL

Table_of_Multof2000: dw $0000,$2000,$4000,$6000,$8000,$A000,$C000,$E000;858E47;      ;

;;;;;;;; This copies a sprite to the VRAM used for OBJs
CopiesWRAMtoOBJVGRAM:
        %Set8bit(!M)                         ;prepares the copy
        LDA.B !VMAIN_16BIT_MODE
        STA.W !VMAIN
        LDA.B !DMAPX_16BIT
        STA.W !DMAP0
        LDA.B !BBADX_DMA_VRAMPORT
        STA.W !BBAD0
        %Set16bit(!MX)
        LDX.W #$0000
        STX.B $BF

    .loop:
        LDX.B $BF
        LDA.L $7EA420,X
        CMP.W #$FFFF                         ;No sprite check
        BEQ .return

        LDA.L $7EA424,X                      ;Copies the first row of 2 8x8 sprites
        STA.W !VMADDL
        LDA.L $7EA420,X
        STA.W !A1T0L
        LDA.W #$0040                         ;Size 64, a sprite 2 8x8 sprites
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.L $7EA422,X
        STA.W !A1B0
        LDA.B #$01
        STA.W !MDMAEN

        %Set16bit(!MX)                       ;Copies the second row of 2 8x8 sprites
        LDX.B $BF
        LDA.L $7EA424,X
        CLC
        ADC.W #$0100
        STA.W !VMADDL
        LDA.L $7EA420,X
        CLC
        ADC.W #$0200
        STA.W !A1T0L
        LDA.W #$0040
        STA.W !DAS0L
        %Set8bit(!M)
        LDA.L $7EA422,X
        STA.W !A1B0
        LDA.B #$01
        STA.W !MDMAEN

        %Set16bit(!MX)
        LDA.B $BF
        CLC
        ADC.W #$0006
        STA.B $BF
        BRA .loop

    .return: RTL

;;;;;;; TODO
ClearSpriteDataTables: ;858ED7
        %Set16bit(!MX)
        LDA.W #$FFFF
        STA.L $7EA420
        STZ.B $BB
        STZ.B $BD
        LDX.W #$0000
        LDY.W #$0000

    .loop1:
            LDA.W #$0000
            STA.L $7EA320,X
            LDA.W #$FFFF
            STA.L $7EA322,X
            STA.L $7EA220,X
            INX
            INX
            INX
            INX
            INY
            CPY.W #64                            ;16 adresses in total
            BNE .loop1

        %Set16bit(!MX)
        LDX.W #$0000
        LDA.W #$FFFF

    .loop2:
            STA.L $7F0F00,X
            INX
            INX
            CPX.W #$1000
            BNE .loop2

        STZ.W $0846
        STZ.W $0848

        RTL
