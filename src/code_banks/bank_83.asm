ORG $838000

;;;;;;;; Does some weird things multypling some variables LOWBYTE and HIBYTE and suming the results with another variable????
;;;;;;;; Param in A. Only called from Audio functions
Unk_Audio23: ;838000
        PHP
        %Set16bit(!MX)
        STA.W $011C
        STZ.W $011E
        STZ.W $0120
        STZ.W $0122
        %Set8bit(!M)
        STA.W !multiplicand
        LDA.B $7E
        STA.W !multiplier
        JSR.W MultiplicationUnsigned
        %Set16bit(!M)
        STA.W $011E
        LDA.W $011C
        AND.W #$FF00
        BEQ .sr1
        %Set8bit(!M)
        XBA
        STA.W !multiplicand
        JSR.W MultiplicationUnsigned
        %Set16bit(!M)
        AND.W #$00FF
        XBA
        STA.W $0120

    .sr1:
        LDA.B $7E
        AND.W #$FF00
        BEQ .sr2
        %Set8bit(!M)
        XBA
        STA.W !multiplier
        LDA.W $011C
        STA.W !multiplicand
        JSR.W MultiplicationUnsigned
        %Set16bit(!M)
        AND.W #$00FF
        XBA
        STA.W $0122

    .sr2:
        LDA.W $011E
        CLC
        ADC.W $0120
        CLC
        ADC.W $0122
        PLP
        RTL

;;;;;;;; Multiplication using the RICOH's math coprosessor
;;;;;;;; Multiplicands in $011A $011B, result in A
MultiplicationUnsigned: ;838067
        %Set8bit(!M)
        LDA.W !multiplicand
        STA.L !WRMPYA24
        LDA.W !multiplier
        STA.L !WRMPYB24
        %Set16bit(!M)
        NOP
        NOP
        NOP
        NOP
        LDA.L !RDMPYL24                      ;Result
        RTS

;;;;;;;; Division using the RICOH's math coprosessor
;;;;;;;; Dividend in $7E, Divisor in $80, Result in A, Rest on $7E
;;;;;;;; I find it funny it doesnt even check if you are diving by 0, go ahead, git garbage
DivisionUnsigned: ;838082
        %Set16bit(!MX)
        LDY.W #$0000
        LDA.B !divisor
        CMP.W #$00FF
        BCS .bigDivisor                      ;if divisor is bigger than 255
        LDA.B !dividend
        STA.L !WRDIVL24
        %Set8bit(!M)
        LDA.B !divisor
        STA.L !WRDIVB24
        %Set16bit(!M)
        NOP
        NOP
        NOP
        TYA
        LSR A
        LDA.L !RDMPYL24                      ;Rest
        STA.B !dision_rest
        LDA.L !RDDIVL24                      ;Result

    .return:
        RTL

    .bigDivisor:                             ;manual divide using substraction
        PHY
        LDY.W #$0010
        LDA.W #$0000
        STA.B !scratch82

    .loop:
        ASL.B !scratch82
        ASL.B !dividend
        ROL A
        CMP.B !divisor
        BCC .skip
        SBC.B !divisor
        INC.B !scratch82

    .skip:
        DEY
        BNE .loop

        STA.B !dision_rest                   ;Rest
        PLA
        LSR A
        LDA.B !scratch82                     ;Result
        JMP.W .return


;;;;;;;; Unused division function? its never called, looks like signed division
;;;;;;;; Dividend in $00007E, Divisor in $000080, Result in A, Rest on $00007E
;;;;;;;; Probably
DivisionSigned: ;8380D0
        %Set16bit(!MX)
        LDY.W #$0000
        LDA.B $7E
        BPL .negdividend
        EOR.W #$FFFF
        INC A
        STA.B $7E
        INY

    .negdividend:
        LDA.B $80
        BPL .negdivisor
        EOR.W #$FFFF
        INC A
        STA.B $80
        INY

    .negdivisor:
        CMP.W #$00FF
        BCS .bigDivisor
        LDA.B $7E
        STA.L !WRDIVL24
        %Set8bit(!M)
        LDA.B $80
        STA.L !WRDIVB24
        %Set16bit(!M)
        NOP
        NOP
        NOP
        TYA
        LSR A
        LDA.L !RDMPYL24
        STA.B $7E
        LDA.L !RDDIVL24

    .loop:
        BCC +
        EOR.W #$FFFF
        INC A
      + RTL

    .bigDivisor:
        PHY
        LDY.W #$0010
        LDA.W #$0000
        STA.B $82

    .subloop:
        ASL.B $82
        ASL.B $7E
        ROL A
        CMP.B $80
        BCC +
        SBC.B $80
        INC.B $82

      + DEY
        BNE .subloop
        STA.B $7E
        PLA
        LSR A
        LDA.B $82
        JMP.W .loop

;;;;;;;; I dont get the math, but it does a ton of bit shifting and XORs, and magic happens
;;;;;;;; The RNG ram locations are only there for this function use
;;;;;;;; Returns a number between 0 and 255 (probably) in A
GetRNG: ;838138
        %Set8bit(!M)
        LDA.W !RNG_mem_2
        EOR.W !RNG_mem_1
        AND.B #$02
        CLC

        BEQ +
        SEC

      + ROR.W !RNG_mem_2
        ROR.W !RNG_mem_1
        ROR.W !RNG_mem_3
        CLC
        LDA.W !RNG_mem_2
        ADC.B #$47
        ROR A
        ROR A
        EOR.W !RNG_mem_1
        ADC.W !RNG_mem_3
        STA.W !RNG_mem_1
        %Set16bit(!M)
        AND.W #$00FF
        RTL


;;;;;;;; ;Param in A
UNK_SetDMA1: ;838166
        %Set16bit(!MX)
        ASL A
        ASL A
        ASL A
        ASL A
        STA.B $7E
        %Set8bit(!M)
        LDA.B #$06
        STA.B !ProgDMA_Channel_Index
        LDA.B !BBADX_DMA_VRAMPORT
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!M)
        LDA.W #$0010
        CLC
        ADC.B $7E
        TAY
        %Set16bit(!M)
        LDA.W #$0080
        PHX
        JSL.L AddProgrammedDMA
        %Set8bit(!M)
        LDA.B #$07
        STA.B !ProgDMA_Channel_Index
        LDA.B !BBADX_DMA_VRAMPORT
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!MX)
        PLX
        TXA
        CLC
        ADC.W #$0080
        TAX
        LDA.W #$0010
        CLC
        ADC.B $7E
        TAY
        LDA.B $72
        CLC
        ADC.W #$0100
        STA.B $72
        %Set16bit(!M)
        LDA.W #$0080
        JSL.L AddProgrammedDMA
        RTL

;;;;;;;;
UNK_SetDMA2: ;8381B7
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$06
        STA.B !ProgDMA_Channel_Index
        LDA.B !BBADX_DMA_VRAMPORT
        STA.B !ProgDMA_Destination_Memory
        LDY.W #$0004
        %Set16bit(!M)
        LDA.W #$0080
        PHX
        JSL.L AddProgrammedDMA
        %Set8bit(!M)
        LDA.B #$07
        STA.B !ProgDMA_Channel_Index
        LDA.B !BBADX_DMA_VRAMPORT
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!MX)
        PLX
        TXA
        CLC
        ADC.W #$0020
        TAX
        LDY.W #$0004
        %Set16bit(!M)
        LDA.B $72
        CLC
        ADC.W #$0004
        STA.B $72
        LDA.W #$0080
        JSL.L AddProgrammedDMA
        RTL

;;;;;;;; This is a decompression function, I think that its a cut part of a bigger
;;;;;;;; algorith, as some parts are cut, some data is skipped, might be wrong.
;;;;;;;; better explained in notes
;;;;;;;; Params $72: Compressed info pointer, $75: Destination pointer
DecompressTileMap: ;8381F8
        !datapointer = $72
        !destpointer = $75
        !controlbits = $80
        !currentbit = $82
        !remainingdata = $7E
        !7Findex = $84
        !offset = $86
        !copyN = $88

        PHP
        %Set16bit(!MX)
        LDA.W #$0000
        TAX
        .clearmemory
            STA.L $7F0000,X
            INX
            INX
            CPX.W #$0800
            BCC .clearmemory

        %Set16bit(!M)
        LDA.B [!datapointer]
        STA.B !remainingdata                 ;loads total size of data to copy
        INC.B !datapointer
        INC.B !datapointer
        INC.B !datapointer                   ;skips two bytes? they seem to be always 0?
        INC.B !datapointer

        STZ.B !controlbits
        STZ.B !currentbit
        LDA.W #$07DE                         ;2014
        STA.B !7Findex
        LDA.B !remainingdata
        BNE .getNextAction                   ;useless branch

        .getNextAction
            DEC.B !currentbit                ;first time, it will result negative
            BPL .copySingleByte
            %Set16bit(!M)
            LDA.B [!datapointer]             ;read next Control bit
            INC.B !datapointer
            AND.W #$00FF
            STA.B !controlbits
            LDA.W #$0007                     ;max ammount of control bits
            STA.B !currentbit

        .copySingleByte:
            LSR.B !controlbits               ;Sets the next control bit on the Carry flag
            BCC .specialCase                 ;if its 0, its a special copy

            %Set16bit(!M)                    ;if its 1, just copy a single byte, src to dst
            LDA.B [!datapointer]
            INC.B !datapointer
            AND.W #$00FF
            %Set8bit(!M)
            STA.B [!destpointer]
            %Set16bit(!MX)
            INC.B !destpointer
            DEC.B !remainingdata
            BEQ .return                      ;Finished copying
            LDX.B !7Findex
            %Set8bit(!M)
            STA.L $7F0000,X                  ;Writes a copy on the temp place?
            %Set16bit(!MX)
            TXA
            INC A
            AND.W #$07FF                     ;2047, max size?
            STA.B !7Findex
            BRA .getNextAction

        .specialCase:
            %Set16bit(!M)
            LDA.B [!datapointer]
            INC.B !datapointer
            AND.W #$00FF
            STA.B !offset
            %Set16bit(!M)
            LDA.B [!datapointer]
            INC.B !datapointer
            AND.W #$00FF
            TAX
            AND.W #$001F                     ;separate last 5 bits
            INC A
            INC A
            INC A
            STA.B !copyN                     ;last 5 bits + 3
            TXA
            AND.W #$00E0                     ;first 3 bits
            ASL A
            ASL A
            ASL A
            ORA.B !offset                    ;used as high byte, it give us a max of
            STA.B !offset                    ;2047, the max size.

            .repeatSpecialCopy:
                LDX.B !offset
                LDA.L $7F0000,X
                AND.W #$00FF
                %Set8bit(!M)
                STA.B [!destpointer]
                %Set16bit(!MX)
                INC.B !destpointer
                DEC.B !remainingdata
                BEQ .return
                LDX.B !7Findex
                %Set8bit(!M)
                STA.L $7F0000,X
                %Set16bit(!MX)
                TXA
                INC A
                AND.W #$07FF
                STA.B !7Findex
                LDA.B !offset
                INC A
                AND.W #$07FF
                STA.B !offset
                DEC.B !copyN
                BNE .repeatSpecialCopy

        JMP.W .getNextAction

    .return:
        LDA.B !remainingdata
        PLP
        RTL


;;;;;;;;
UNK_Audio26: ;8382C6
        %Set8bit(!M)
        %Set16bit(!X)
        PHA
        JSL.L UNK_Audio21
        %Set8bit(!M)
        PLA
        STA.W $0110
        JSL.L UNK_Audio20
        JSL.L UNK_Audio22
        %Set8bit(!M)
        LDA.W $0110
        STA.W $0117
        %Set16bit(!MX)
        LDA.W #$00B4
        JSL.L WaitForNMIATimes
        %Set8bit(!M)
        LDA.W !transition_dest
        STA.B !tilemap_to_load
        JSL.L UNK_Audio5
        JSL.L UNK_Audio25
        RTL

;;;;;;;;
UNK_Audio24: ;8382FE
        %Set8bit(!M)
        %Set16bit(!X)
        STA.W $0114
        PHY
        %Set16bit(!M)
        TXA
        %Set8bit(!M)
        STA.W $0115
        LDA.B #$00
        XBA
        LDA.W $0118
        %Set16bit(!M)
        TAX
        %Set8bit(!M)
        LDA.L UNK_AudioTable,X
        INC A
        STA.W $0103
        JSL.L UNK_Audio18
        JSL.L UNK_Audio19
        %Set16bit(!MX)
        PLY
        TYA
        JSL.L WaitForNMIATimes
        RTL

;;;;;;;;
UNK_Audio19: ;838332
        %Set8bit(!M)
        LDA.B #$0A
        STA.W $0116
        JSL.L UNK_Audio15
        RTL

;;;;;;;;
UNK_Audio18: ;83833E
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $0103
        %Set16bit(!M)
        TAX
        %Set8bit(!M)
        LDA.W $0104,X
        BEQ +
        %Set16bit(!M)
        TXA
        INC A
        %Set8bit(!M)
        JSL.L UNK_Audio10
        JSL.L WaitForNMI

      + %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $0114
        %Set16bit(!M)
        TAX
        %Set8bit(!M)
        LDA.L UNK_Audio_Table2,X
        BEQ .return
        JSL.L UNK_Audio12

    .return: RTL

;;;;;;;; Seems to be unused
UNUSED2: ;838376
        %Set8bit(!M)
        LDA.W $0103
        INC A
        STA.W $0103
        RTL

;;;;;;;;
UNK_Audio22: ;838380
        %Set8bit(!M)
        LDA.W $0110
        BEQ .skip
        CMP.W $0117
        BEQ .skip
        CMP.B #$FF
        BEQ .skip
        LDA.B #$01
        STA.W $0111
        LDA.B #$40
        STA.W $0113
        JSL.L UNK_Audio14

    .skip:
        %Set8bit(!M)
        STZ.W $0119
        RTL

;;;;;;;;
UNK_Audio20: ;8383A4
        %Set8bit(!M)
        LDA.W $0110
        CMP.W $0117
        BEQ .skip
        LDA.B #$00
        JSL.L UNK_Audio10
        %Set8bit(!M)
        LDA.W $0110
        BEQ .skip
        CMP.B #$FF
        BEQ .skip
        JSL.L UNK_Audio11
        JSL.L UNK_Audio9
        BRA .skip

        %Set8bit(!M)
        LDA.B #$00
        STA.W $0110

    .skip:
        %Set8bit(!M)
        LDA.B #$06
        STA.W $0115
        LDA.B #$03
        STA.W $0114
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $0110
        STA.W $0118
        CMP.B #$FF
        BNE .skip2
        LDA.B #$00
        STA.W $0118

    .skip2:
        %Set16bit(!M)
        TAX
        %Set8bit(!M)
        LDA.L UNK_AudioTable,X
        STA.W $0103
        JSL.L UNK_Audio18

        RTL

;;;;;;;;
UNK_Audio25: ;838401
        %Set8bit(!M)
        LDA.W $0110
        CMP.W $0117
        BEQ $13
        LDA.W $0117
        BEQ $F0
        LDA.B #$01
        STA.W $0112
        LDA.B #$40
        STA.W $0113
        JSL.L UNK_Audio6

        RTL

;;;;;;;;
UNK_Audio21: ;83841F
        %Set8bit(!M)
        LDA.W $0110
        CMP.W $0117
        BEQ .skip
        LDA.W $0117
        BEQ .skip
        LDA.B #$01
        STA.W $0112
        LDA.B #$10
        STA.W $0113
        JSL.L UNK_Audio6

    .skip: RTL

;;;;;;;;
UNK_Audio1: ;83843D
        PHP
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDY.W #$0000
        LDA.W #$BBAA

    .loop1:
        CMP.W !APUIO0
        BNE .loop1
        %Set8bit(!M)
        %Set8bit(!M)
        LDA.B #$CC
        PHA
        %Set16bit(!M)
        %Set16bit(!M)
        LDA.W #$0FD6
        TAX
        %Set8bit(!M)
        LDA.B #$00
        STA.W !APUIO2
        LDA.B #$05
        STA.W !APUIO3
        %Set8bit(!M)
        CPX.W #$0001
        LDA.B #$00
        ROL A
        STA.W !APUIO1
        ADC.B #$7F
        PLA
        STA.W !APUIO0

    .loop2:
        CMP.W !APUIO0
        BNE .loop2

    .loop9:
        LDA.B [$0A],Y
        INY
        XBA
        LDA.B #$00
        BRA .sub1

    .loop4:
        XBA
        LDA.B [$0A],Y
        INY
        XBA

    .loop3:
        CMP.W !APUIO0
        BNE .loop3
        INC A

    .sub1:
        %Set16bit(!M)
        STA.W !APUIO0
        %Set8bit(!M)
        DEX
        BNE .loop4

    .loop5:
        CMP.W !APUIO0
        BNE .loop5

    .loop6:
        ADC.B #$03
        BEQ .loop6
        PHA
        %Set16bit(!M)
        %Set16bit(!M)
        LDA.W #$0000
        TAX
        %Set8bit(!M)
        LDA.B #$00
        STA.W !APUIO2
        LDA.B #$05
        STA.W !APUIO3
        %Set8bit(!M)
        CPX.W #$0001
        LDA.B #$00
        ROL A
        STA.W !APUIO1
        ADC.B #$7F
        PLA
        STA.W !APUIO0

    .loop8:
        CMP.W !APUIO0
    .loop7:
        BNE .loop8
        BVS .loop9
        PLP
        RTL

;;;;;;;;
UNK_Audio4: ;8384D3
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$01
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        %Set16bit(!M)
        LDA.W #$03F2
        STA.B $7E
        LDA.W #$0003
        STA.B $80
        JSL.L DivisionUnsigned
        STA.B $80
        LDA.B $7E
        BEQ .skip
        INC.B $80

    .skip:
        LDA.B $80
        %Set8bit(!M)
        STA.W !APUIO0
        XBA
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$04
        BNE .loop2
        %Set8bit(!M)
        STZ.W !APUIO3
        LDY.W #$0000
        %Set16bit(!M)
        LDA.W #$D120
        STA.B $0A
        %Set8bit(!M)
        LDA.B #$B2
        STA.B $0C
        %Set16bit(!M)
        LDA.B $80
        TAX

    .loop3:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop3
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop3
        LDA.B [$0A],Y
        STA.W !APUIO0
        INY
        LDA.B [$0A],Y
        STA.W !APUIO1
        INY
        LDA.B [$0A],Y
        STA.W !APUIO2
        INY
        DEX
        LDA.B #$02
        STA.W !APUIO3

    .loop4:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop4
        LDA.B #$00
        CMP.W !APUIO3
        BNE .loop4
        STZ.W !APUIO3
        CPX.W #$0000
        BNE .loop3
        RTL

;;;;;;;;
UNK_Audio3: ;838598
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000

    .mainloop:
        LDA.L UNK_Audio_Table4,X
        STA.B $94
        BNE .sr1
        INX
        CPX.W #$000A
        BNE .mainloop
        JMP.W $878B

    .sr1:
        %Set8bit(!M)
        LDA.B #$02
        STA.B $92
        JSR.W UNK_Audio8

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop2
        PHX
        LDA.B #$00
        XBA
        LDA.B $94
        %Set16bit(!M)
        STA.B $7E
        LDA.W #$000A
        JSL.L Unk_Audio23
        TAX
        %Set8bit(!M)
        LDA.B $94
        STA.W !APUIO0
        %Set16bit(!M)
        LDA.L UNK_Audio_Table3,X
        %Set8bit(!M)
        STA.W !APUIO1
        XBA
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX
        INX

    .loop3:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop3
        LDA.W !APUIO3
        CMP.B #$04
        BEQ .skip
        BRA .loop3

    .skip:
        STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO0
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO1
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX

    .loop4:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop4
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop4

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO0
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX

    .loop5:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop5
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop5

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        %Set16bit(!M)
        LDA.L UNK_Audio_Table3,X
        STA.B $0A
        INX
        INX
        %Set8bit(!M)
        LDA.L UNK_Audio_Table3,X
        STA.B $0C
        LDA.B #$00
        XBA
        LDA.B $94
        ASL A
        %Set16bit(!M)
        TAX
        LDA.L UNK_Audio_Table5,X
        STA.B $7E
        LDA.W #$0003
        STA.B $80
        JSL.L DivisionUnsigned
        STA.B $80
        LDA.B $7E
        BEQ +
        INC.B $80

      + LDA.B $80
        TAX
        %Set8bit(!M)
        STA.W !APUIO0
        XBA
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        LDY.W #$0000

    .loop6:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop6
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop6

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

    .loop7:
        LDA.B [$0A],Y
        STA.W !APUIO0
        INY
        LDA.B [$0A],Y
        STA.W !APUIO1
        INY
        LDA.B [$0A],Y
        STA.W !APUIO2
        INY
        DEX
        LDA.B #$02
        STA.W !APUIO3

    .loop8:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop8
        LDA.B #$00
        CMP.W !APUIO3
        BNE .loop8
        STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -
        CPX.W #$0000
        BNE .loop7
        PLX
        INX
        CPX.W #$000A
        BEQ +
        JMP.W .mainloop

      + RTL

;;;;;;;;
UNK_Audio9: ;83878C
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        STZ.W $0103
        STZ.W $010F

      - STZ.W $0104,X
        INX
        CPX.W #$000B
        BNE -

        LDY.W #$0000
        LDA.B #$00
        XBA
        LDA.W $0110
        %Set16bit(!M)
        STA.B $7E
        LDA.W #$000E
        JSL.L Unk_Audio23
        TAX
        INX
        INX
        INX
        CLC
        ADC.W #$000E
        STA.B $84

    .mainloop:
        %Set8bit(!M)
        LDA.L UNK_Audio_Table6,X
        STA.B $94
        BNE .skip1
        %Set16bit(!M)
        INX
        CPX.B $84
        BNE .mainloop
        %Set8bit(!M)
        LDA.B #$06
        STA.B $94
        DEX
        BRA .skip2

    .skip1:
        %Set8bit(!M)
        LDA.B $94
        STA.W $0104,Y
        INC.W $0103
        INC.W $010F

    .skip2:
        %Set8bit(!M)
        LDA.B #$03
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        PHX
        PHY
        LDA.B #$00
        XBA
        LDA.B $94
        %Set16bit(!M)
        STA.B $7E
        LDA.W #$000A
        JSL.L Unk_Audio23
        TAX
        %Set8bit(!M)
        LDA.B $94
        STA.W !APUIO0
        %Set16bit(!M)
        LDA.L UNK_Audio_Table3,X
        %Set8bit(!M)
        STA.W !APUIO1
        XBA
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX
        INX

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop2

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO0
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO1
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX

    .loop3:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop3
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop3

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO0
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX

    .loop4:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop4
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop4

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        %Set16bit(!M)
        LDA.L UNK_Audio_Table3,X
        STA.B $0A
        INX
        INX
        %Set8bit(!M)
        LDA.L UNK_Audio_Table3,X
        STA.B $0C
        LDA.B #$00
        XBA
        LDA.B $94
        ASL A
        %Set16bit(!M)
        TAX
        LDA.L UNK_Audio_Table5,X
        STA.B $7E
        LDA.W #$0003
        STA.B $80
        JSL.L DivisionUnsigned
        STA.B $80
        LDA.B $7E
        BEQ +
        INC.B $80

      + LDA.B $80
        TAX
        %Set8bit(!M)
        STA.W !APUIO0
        XBA
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        LDY.W #$0000

    .loop5:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop5
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop5

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

    .subloop:
        LDA.B [$0A],Y
        STA.W !APUIO0
        INY
        LDA.B [$0A],Y
        STA.W !APUIO1
        INY
        LDA.B [$0A],Y
        STA.W !APUIO2
        INY
        DEX
        LDA.B #$02
        STA.W !APUIO3

    .loop6:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop6
        LDA.B #$00
        CMP.W !APUIO3
        BNE .loop6
        STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        CPX.W #$0000
        BNE .subloop
        %Set16bit(!M)
        PLY
        PLX
        INX
        INY
        CPX.B $84
        BEQ .return
        JMP.W .mainloop

    .return: RTL

;;;;;;;;
UNK_Audio10: ;8389C7
        %Set8bit(!M)
        PHA
        STA.B $94

      - LDA.B $94
        BNE +
        JSR.W UNK_Audio7
        BNE -

      + %Set16bit(!X)
        LDA.B #$04
        STA.B $92
        JSR.W UNK_Audio8

        .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        LDA.B $94
        STA.W !APUIO0
        STZ.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

      - LDA.W !APUIO3
        CMP.B #$08
        BEQ +
        BRA -

      + STZ.W !APUIO3
        %Set8bit(!M)
        LDA.B #$00
        XBA
        PLA
        %Set16bit(!M)
        TAX
        %Set8bit(!M)

      - LDA.B #$00
        STA.W $0104,X
        INX
        CPX.W #$000B
        BNE -
        RTL

;;;;;;;;
UNK_Audio11:  ;838A26
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$05
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        LDA.B #$00
        XBA
        LDA.W $0110
        ASL A
        %Set16bit(!M)
        TAX
        LDA.L UNK_Audio_Table7,X
        STA.B $7E
        LDA.W #$0003
        STA.B $80
        JSL.L DivisionUnsigned
        STA.B $80
        LDA.B $7E
        BEQ +
        INC.B $80

      + LDA.B $80
        %Set8bit(!M)
        STA.W !APUIO0
        XBA
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

      - LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA -

      + LDY.W #$0000
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W $0110
        %Set16bit(!M)
        STA.B $7E
        LDA.W #$000E
        JSL.L Unk_Audio23
        TAX
        LDA.L UNK_Audio_Table6,X
        STA.B $0A
        INX
        INX
        %Set8bit(!M)
        LDA.L UNK_Audio_Table6,X
        STA.B $0C
        %Set16bit(!M)
        LDA.B $80
        TAX

    .loop2:
        %Set8bit(!M)
        STZ.W !APUIO3

    .loop3:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop3
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop3
        LDA.B [$0A],Y
        STA.W !APUIO0
        INY
        LDA.B [$0A],Y
        STA.W !APUIO1
        INY
        LDA.B [$0A],Y
        STA.W !APUIO2
        INY
        DEX
        LDA.B #$02
        STA.W !APUIO3

    .loop4:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop4
        LDA.B #$00
        CMP.W !APUIO3
        BNE .loop4
        STZ.W !APUIO3
        CPX.W #$0000
        BNE .loop2
        RTL

;;;;;;;;
UNK_Audio12: ;838AFF
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        LDA.B #$03
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        LDA.B #$00
        XBA
        LDA.W $0114
        TAX
        LDA.L UNK_Audio_Table2,X
        STA.B $94
        LDA.W $0103
        TAX
        LDA.B $94
        STA.W $0104,X
        INC.W $0103
        LDA.B #$00
        XBA
        LDA.B $94
        %Set16bit(!M)
        STA.B $7E
        LDA.W #$000A
        JSL.L Unk_Audio23
        TAX
        %Set8bit(!M)
        LDA.B $94
        STA.W !APUIO0
        %Set16bit(!M)
        LDA.L UNK_Audio_Table3,X
        %Set8bit(!M)
        STA.W !APUIO1
        XBA
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX
        INX

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop2

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO0
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO1
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX

    .loop3:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop3
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop3

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO0
        INX
        LDA.L UNK_Audio_Table3,X
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        INX

    .loop4:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop4
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop4

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        %Set16bit(!M)
        LDA.L UNK_Audio_Table3,X
        STA.B $0A
        INX
        INX
        %Set8bit(!M)
        LDA.L UNK_Audio_Table3,X
        STA.B $0C
        LDA.B #$00
        XBA
        LDA.B $94
        ASL A
        %Set16bit(!M)
        TAX
        LDA.L UNK_Audio_Table5,X
        STA.B $7E
        LDA.W #$0003
        STA.B $80
        JSL.L DivisionUnsigned
        STA.B $80
        LDA.B $7E
        BEQ +
        INC.B $80

      + LDA.B $80
        TAX
        %Set8bit(!M)
        STA.W !APUIO0
        XBA
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3
        LDY.W #$0000

    .loop5:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop5
        LDA.W !APUIO3
        CMP.B #$04
        BEQ +
        BRA .loop5

      + STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

    .loop6:
        %Set8bit(!M)
        LDA.B [$0A],Y
        STA.W !APUIO0
        INY
        LDA.B [$0A],Y
        STA.W !APUIO1
        INY
        LDA.B [$0A],Y
        STA.W !APUIO2
        INY
        DEX
        LDA.B #$02
        STA.W !APUIO3

        .loop7: %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop7
        LDA.B #$00
        CMP.W !APUIO3
        BNE .loop7
        STZ.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        CPX.W #$0000
        BNE .loop6
        STZ.W !APUIO3
        RTL

;;;;;;;;
UNK_Audio13: ;838CF3
        %Set8bit(!M)
        %Set16bit(!X)
        STA.B $94
        LDA.B #$07
        STA.B $92

      - LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -

      - LDA.B #$01
        CMP.W !APUIO3
        BNE -

        LDA.B $92
        STA.W !APUIO0
        STZ.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

      - %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE -
        LDA.B #$04
        CMP.W !APUIO3
        BNE -
        STZ.W !APUIO3
        RTL

;;;;;;;
UNK_Audio14: ;838D38
        JSR.W UNK_Audio7
        BNE UNK_Audio14
        %Set8bit(!M)
        LDA.B #$08
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        LDA.W $0111
        STA.W !APUIO0
        LDA.W $0113
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$08
        BEQ .return
        BRA .loop2

    .return:
        STZ.W !APUIO3
        RTL

;;;;;;;;
UNK_Audio6: ;838D8B
        %Set8bit(!M)
        JSR.W UNK_Audio7
        BEQ $4C
        %Set8bit(!M)
        LDA.B #$09
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        LDA.W $0112
        STA.W !APUIO0
        LDA.W $0113
        STA.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$08
        BEQ .return
        BRA .loop2

    .return:
        STZ.W !APUIO3
        RTL

;;;;;;;;
UNK_Audio15: ;838DDF
        JSR.W UNK_Audio17
        BNE .return
        %Set8bit(!M)
        LDA.B #$0A
        STA.B $92
        JSR.W UNK_Audio8

    .loop:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop
        LDA.W $0114
        STA.W !APUIO0
        LDA.W $0115
        STA.W !APUIO1
        LDA.W $0116
        STA.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$08
        BNE .loop2
        STZ.W !APUIO3

    .return: RTL

;;;;;;;;
UNK_Audio2: ;838E32
        %Set8bit(!M)
        STA.B $94
        %Set16bit(!X)
        LDA.B #$0B
        STA.B $92
        JSR.W UNK_Audio8

    .loop1:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop1
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1
        LDA.B $94
        STA.W !APUIO0
        STZ.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

    .loop2:
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2
        LDA.W !APUIO3
        CMP.B #$08
        BEQ .skip
        BRA .loop2

    .skip:
        STZ.W !APUIO3
        RTL

;;;;;;;;
UNK_Audio16: ;838E7F
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$0C
        STA.B $92
        JSR.W UNK_Audio8
        RTL

;;;;;;;;
UNK_Audio8: ;838E8B
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE UNK_Audio8

    .loop1:
        LDA.B #$01
        CMP.W !APUIO3
        BNE .loop1

        LDA.B $92
        STA.W !APUIO0
        STZ.W !APUIO1
        STZ.W !APUIO2
        LDA.B #$02
        STA.W !APUIO3

    .loop2:
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE .loop2

    .loop3:
        LDA.W !APUIO3
        CMP.B #$04
        BEQ .return
        BRA .loop3

    .return:
        STZ.W !APUIO3
        RTS

;;;;;;;;
UNK_Audio7: ;838EC9
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE UNK_Audio7
        LDA.B #$01
        CMP.W !APUIO3
        BNE UNK_Audio7
        LDA.W !APUIO0
        AND.B #$11
        RTS

;;;;;;;;
UNK_Audio17: ;838EE4
        %Set8bit(!M)
        LDA.W !APUIO3
        STA.B $93
        LDA.W !APUIO3
        CMP.B $93
        BNE UNK_Audio17
        LDA.B #$01
        CMP.W !APUIO3
        BNE UNK_Audio17
        LDA.W !APUIO0
        AND.B #$10
        RTS

;;;;;;;;
UNK_Audio_Table5: dw $10C0,$10C0,$2EE0,$0BB0,$0780,$0D10,$0040,$1F30;838EFF
                  dw $1950,$1300,$02D0,$1B80,$0340,$0670,$0DA0,$1240
                  dw $0FA0,$07D0,$1B40,$1F30,$06B0,$1940,$0730,$03E0
                  dw $1380,$04E0,$0C80,$0F90,$0E50,$3E70,$0F90,$0BB0
                  dw $0BB0,$0BB0,$0BB0,$07C0,$1380,$0340,$07C0,$1F30

UNK_Audio_Table7: dw $02EC,$02EC,$0272,$03AB,$02B6,$0443,$0399,$02AD;838F4F
                  dw $01F6,$0260,$019A,$018E,$01D1,$0293,$023D,$02F2
                  dw $0435,$0113,$04B7,$007A,$0080,$00DB,$011E,$00B0
                  dw $005C,$00BC

UNK_Audio_Table6: db $D6,$8F,$AD,$07,$03,$01,$0C,$05,$26,$24,$00,$00,$00,$00,$D6,$8F;838F83
                  db $AD,$07,$03,$01,$0C,$00,$00,$00,$00,$00,$00,$00,$4A,$B4,$AD,$01
                  db $05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$FD,$9F,$AD,$03,$07,$01
                  db $16,$05,$00,$00,$00,$00,$00,$00,$C2,$92,$AD,$03,$07,$01,$00,$00
                  db $00,$00,$00,$00,$00,$00,$A7,$9A,$AD,$05,$01,$07,$00,$00,$00,$00
                  db $00,$00,$00,$00,$0E,$AC,$AD,$03,$07,$01,$00,$00,$00,$00,$00,$00
                  db $00,$00,$A7,$AF,$AD,$01,$04,$0C,$08,$00,$00,$00,$00,$00,$00,$00
                  db $54,$B2,$AD,$01,$07,$16,$00,$00,$00,$00,$00,$00,$00,$00,$AE,$A9
                  db $AD,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$06,$BE,$AD,$05
                  db $07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$A0,$BF,$AD,$05,$01,$07
                  db $00,$00,$00,$00,$00,$00,$00,$00,$A8,$A3,$AD,$05,$07,$01,$00,$00
                  db $00,$00,$00,$00,$00,$00,$BC,$B6,$AD,$05,$01,$08,$00,$00,$00,$00
                  db $00,$00,$00,$00,$6A,$98,$AD,$05,$00,$00,$00,$00,$00,$00,$00,$00
                  db $00,$00,$78,$95,$AD,$05,$0B,$01,$08,$00,$00,$00,$00,$00,$00,$00
                  db $79,$A5,$AD,$05,$01,$0C,$00,$00,$00,$00,$00,$00,$00,$00,$EA,$9E
                  db $AD,$05,$03,$07,$00,$00,$00,$00,$00,$00,$00,$00,$4F,$B9,$AD,$04
                  db $03,$07,$0B,$00,$00,$00,$00,$00,$00,$00,$2E,$C1,$AD,$0D,$00,$00
                  db $00,$00,$00,$00,$00,$00,$00,$00,$A8,$C1,$AD,$0D,$00,$00,$00,$00
                  db $00,$00,$00,$00,$00,$00,$28,$C2,$AD,$15,$0D,$18,$00,$00,$00,$00
                  db $00,$00,$00,$00,$03,$C3,$AD,$10,$00,$00,$00,$00,$00,$00,$00,$00
                  db $00,$00,$21,$C4,$AD,$1D,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
                  db $D1,$C4,$AD,$1D,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$2D,$C5
                  db $AD,$13,$15,$00,$00,$00,$00,$00,$00,$00,$00,$00

UNK_Audio_Table3: db $B0,$01,$FF,$E0,$B8,$05,$20,$E9,$C5,$AD,$B0,$01,$FF,$E0,$B8,$05;8390EF
                  db $20,$E9,$C5,$AD,$76,$02,$FF,$E0,$B8,$06,$B0,$00,$80,$AE,$DF,$05
                  db $FF,$E3,$B8,$01,$E0,$A9,$D6,$AD,$3E,$07,$FF,$EF,$B8,$05,$F0,$59
                  db $E2,$AD,$F2,$07,$FF,$EB,$B8,$03,$E0,$D9,$E9,$AD,$1B,$00,$FF,$E0
                  db $B8,$04,$00,$E9,$F6,$AD,$0C,$06,$FF,$E0,$B8,$05,$A0,$E0,$AE,$AE
                  db $50,$19,$FF,$E0,$B8,$05,$A0,$10,$CE,$AE,$D8,$12,$86,$EB,$B8,$04
                  db $00,$00,$80,$AF,$A3,$02,$FF,$EE,$B8,$03,$F0,$60,$E7,$AE,$B6,$0D
                  db $FF,$E0,$B8,$03,$50,$00,$93,$AF,$01,$02,$FF,$E9,$B8,$01,$E0,$30
                  db $EA,$AE,$1B,$00,$FF,$E0,$B8,$01,$30,$29,$F7,$AD,$9B,$0D,$FF,$E0
                  db $B8,$07,$A0,$70,$ED,$AE,$1B,$00,$FF,$E0,$B8,$00,$D0,$80,$AE,$AF
                  db $D1,$04,$FF,$E0,$B8,$00,$B0,$C0,$C0,$AF,$1B,$00,$FF,$E0,$B8,$00
                  db $50,$60,$D0,$AF,$3F,$1B,$FF,$E0,$B8,$03,$C0,$30,$D8,$AF,$02,$25
                  db $FF,$E0,$B8,$07,$A0,$00,$80,$B0,$1B,$00,$FF,$E0,$B8,$00,$90,$70
                  db $F3,$AF,$3E,$19,$FF,$E9,$B8,$01,$E0,$30,$9F,$B0,$2C,$07,$FF,$E0
                  db $B8,$07,$A0,$70,$B8,$B0,$D5,$03,$FF,$E0,$B8,$04,$20,$A0,$BF,$B0
                  db $71,$13,$FF,$E0,$B8,$05,$20,$80,$C3,$B0,$DA,$04,$FF,$E0,$B8,$07
                  db $A0,$20,$FA,$AF,$72,$0C,$FF,$E0,$B8,$07,$A0,$00,$D7,$B0,$8A,$0F
                  db $FF,$E0,$B8,$01,$50,$80,$E3,$B0,$46,$0E,$FF,$E0,$B8,$07,$A0,$00
                  db $80,$B1,$67,$3E,$FF,$E0,$B8,$05,$40,$50,$8E,$B1,$8A,$0F,$FF,$E0
                  db $B8,$01,$C0,$C0,$CC,$B1,$A3,$0B,$FF,$E0,$B8,$01,$10,$50,$DC,$B1
                  db $A3,$0B,$FF,$E0,$B8,$00,$B0,$00,$E8,$B1,$A3,$0B,$FF,$E0,$B8,$02
                  db $90,$B0,$F3,$B1,$12,$00,$FF,$E0,$B8,$00,$20,$80,$93,$B2,$BC,$07
                  db $FF,$E0,$B8,$01,$10,$30,$9F,$B2,$71,$13,$FF,$E0,$B8,$01,$A0,$00
                  db $80,$B2,$01,$02,$FF,$E9,$B8,$01,$E0,$F0,$A6,$B2,$BC,$07,$FF,$E0
                  db $B8,$01,$00,$30,$AA,$B2,$26,$1F,$FF,$E0,$B8,$01,$E0,$F0,$B1,$B2

UNK_Audio_Table2: db $00,$00,$00,$05,$00,$00,$00,$00,$00,$00,$00,$00,$0D,$13,$1D,$26;83927F
                  db $00,$00,$00,$00,$10,$23,$23,$00,$00,$24,$0D,$00,$25,$1E,$1E,$27
                  db $21,$14,$0E,$14,$14,$1C,$1F,$14,$11,$0F,$12,$10,$11,$11,$11,$07
                  db $26,$06

UNK_Audio_Table4: db $17,$18,$19,$1A,$15,$06,$0A,$00,$00,$00;8392B1

;;;;;;;;
SUB_8392BB: ;8392BB
        %Set16bit(!MX)
        %Set16bit(!M)
        LDA.W #$CB05
        STA.B $72
        LDA.W #$2000
        STA.B $75
        %Set8bit(!M)
        LDA.B #$A5
        STA.B $74
        LDA.B #$7E
        STA.B $77
        JSL.L DecompressTileMap
        %Set8bit(!M)
        LDA.B #$00
        STA.B !ProgDMA_Channel_Index
        LDA.B #$18
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!MX)
        LDY.W #$0400
        LDX.W #$7800
        LDA.W #$2000
        STA.B $72
        %Set8bit(!M)
        LDA.B #$7E
        STA.B $74
        %Set16bit(!M)
        LDA.W #$0080
        JSL.L AddProgrammedDMA
        JSL.L StartLastPreparedDMA

        %Set8bit(!M)
        LDA.B #$00
        STA.B !ProgDMA_Channel_Index
        LDA.B #$18
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!MX)
        LDA.W #$5000
        TAX
        LDY.W #$1000
        LDA.W #$BBA3
        STA.B $72
        %Set8bit(!M)
        LDA.B #$9C
        STA.B $74
        %Set16bit(!M)
        LDA.W #$0080
        JSL.L AddProgrammedDMA
        JSL.L StartLastPreparedDMA

        RTL

;;;;;;;;
SUB_83932D: ;83932D
        %Set8bit(!M)
        LDA.B #$06
        STA.B !ProgDMA_Channel_Index
        LDA.B #$18
        STA.B !ProgDMA_Destination_Memory
        %Set16bit(!MX)
        LDA.W #$5000
        TAX
        LDY.W #$0C00
        LDA.W #$BBA3
        STA.B $72
        %Set8bit(!M)
        LDA.B #$9C
        STA.B $74
        %Set16bit(!M)
        LDA.W #$0080
        JSL.L AddProgrammedDMA
        %Set8bit(!M)
        LDA.B #$07
        STA.B !ProgDMA_Channel_Index
        JSL.L RemoveProgrammedDMA

        RTL

;;;;;;;;
          CODE_83935F: %Set16bit(!MX)                             ;83935F;      ;
                       STX.W $0183                          ;839361;000183;
                       LDA.W #$5000                         ;839364;      ;
                       CLC                                  ;839367;      ;
                       ADC.W #$0010                         ;839368;      ;
                       STA.W $0185                          ;83936B;000185;
                       STZ.W $0187                          ;83936E;000187;
                       %Set8bit(!M)                             ;839371;      ;
                       LDA.W $019B                          ;839373;00019B;
                       ORA.B #$01                           ;839376;      ;
                       STA.W $019B                          ;839378;00019B;
                       STZ.W $0189                          ;83937B;000189;
                       STZ.W $018B                          ;83937E;00018B;
                       STZ.W $018C                          ;839381;00018C;
                       STZ.W $018E                          ;839384;00018E;
                       STZ.W $018F                          ;839387;00018F;
                       STZ.W $0190                          ;83938A;000190;
                       %Set16bit(!M)                             ;83938D;      ;
                       LDA.W $0183                          ;83938F;000183;
                       ASL A                                ;839392;      ;
                       CLC                                  ;839393;      ;
                       ADC.W $0183                          ;839394;000183;
                       TAX                                  ;839397;      ;
                       LDA.L DATA8_839BF6,X                 ;839398;839BF6;
                       STA.B $01                            ;83939C;000001;
                       INX                                  ;83939E;      ;
                       INX                                  ;83939F;      ;
                       %Set8bit(!M)                             ;8393A0;      ;
                       LDA.L DATA8_839BF6,X                 ;8393A2;839BF6;
                       STA.B $03                            ;8393A6;000003;
                       %Set8bit(!M)                             ;8393A8;      ;
                       LDA.W $0191                          ;8393AA;000191;
                       BNE CODE_8393C5                      ;8393AD;8393C5;
                       LDA.B #$01                           ;8393AF;      ;
                       STA.W $0191                          ;8393B1;000191;
                       %Set16bit(!M)                             ;8393B4;      ;
                       LDA.W $090D                          ;8393B6;00090D;
                       CMP.W #$0081                         ;8393B9;      ;
                       BCS CODE_8393C5                      ;8393BC;8393C5;
                       %Set8bit(!M)                             ;8393BE;      ;
                       LDA.B #$02                           ;8393C0;      ;
                       STA.W $0191                          ;8393C2;000191;
                                                            ;      ;      ;
          CODE_8393C5: %Set8bit(!M)                             ;8393C5;      ;
                       LDA.B #$00                           ;8393C7;      ;
                       XBA                                  ;8393C9;      ;
                       LDA.W $0191                          ;8393CA;000191;
                       DEC A                                ;8393CD;      ;
                       %Set16bit(!MX)                             ;8393CE;      ;
                       ASL A                                ;8393D0;      ;
                       ASL A                                ;8393D1;      ;
                       ASL A                                ;8393D2;      ;
                       ASL A                                ;8393D3;      ;
                       ASL A                                ;8393D4;      ;
                       ASL A                                ;8393D5;      ;
                       ASL A                                ;8393D6;      ;
                       STA.B $7E                            ;8393D7;00007E;
                       LDA.W !BG3_Map_Offset_Y                          ;8393D9;000146;
                       SEC                                  ;8393DC;      ;
                       SBC.W #$0100                         ;8393DD;      ;
                       SEC                                  ;8393E0;      ;
                       SBC.B $7E                            ;8393E1;00007E;
                       STA.W !BG3_Map_Offset_Y                          ;8393E3;000146;
                       %Set8bit(!M)                             ;8393E6;      ;
                       STZ.W !time_running                          ;8393E8;000973;
                       %Set16bit(!M)                             ;8393EB;      ;
                       LDA.L $7F1F5A                        ;8393ED;7F1F5A;
                       ORA.W #$4000                         ;FLAG5A
                       STA.L $7F1F5A                        ;8393F4;7F1F5A;
                       RTL                                  ;8393F8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8393F9: %Set8bit(!M)                             ;8393F9;      ;
                       %Set16bit(!X)                             ;8393FB;      ;
                       STZ.W $019B                          ;8393FD;00019B;
                       %Set8bit(!M)                             ;839400;      ;
                       LDA.B #$00                           ;839402;      ;
                       XBA                                  ;839404;      ;
                       LDA.W $0191                          ;839405;000191;
                       DEC A                                ;839408;      ;
                       %Set16bit(!M)                             ;839409;      ;
                       ASL A                                ;83940B;      ;
                       ASL A                                ;83940C;      ;
                       ASL A                                ;83940D;      ;
                       ASL A                                ;83940E;      ;
                       ASL A                                ;83940F;      ;
                       ASL A                                ;839410;      ;
                       ASL A                                ;839411;      ;
                       STA.B $7E                            ;839412;00007E;
                       LDA.W !BG3_Map_Offset_Y                          ;839414;000146;
                       CLC                                  ;839417;      ;
                       ADC.W #$0100                         ;839418;      ;
                       CLC                                  ;83941B;      ;
                       ADC.B $7E                            ;83941C;00007E;
                       STA.W !BG3_Map_Offset_Y                          ;83941E;000146;
                       JSL.L SUB_83932D                    ;839421;83932D;
                       %Set16bit(!M)                             ;839425;      ;
                       LDA.W $0196                          ;839427;000196;
                       AND.W #$0020                         ;83942A;      ;
                       BEQ CODE_839439                      ;83942D;839439;
                       %Set8bit(!M)                             ;83942F;      ;
                       LDA.W !time_running                          ;839431;000973;
                       ORA.B #$01                           ;839434;      ;
                       STA.W !time_running                          ;839436;000973;
                                                            ;      ;      ;
          CODE_839439: %Set16bit(!M)                             ;839439;      ;
                       LDA.L $7F1F5A                        ;83943B;7F1F5A;
                       AND.W #$BFFF                         ;FLAG5A
                       STA.L $7F1F5A                        ;839442;7F1F5A;
                       RTL                                  ;839446;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839447: %Set16bit(!MX)                             ;839447;      ;
                       JSR.W CODE_839495                    ;839449;839495;
                       RTL                                  ;83944C;      ;
                                                            ;      ;      ;
                       db $10,$50,$70,$51,$50,$53,$70,$50,$50,$52,$A0,$21,$A1,$21,$B0,$21;83944D;      ;
                       db $B1,$21,$A2,$21,$A3,$21,$B2,$21,$B3,$21;83945D;      ;
                                                            ;      ;      ;
         DATA8_839467: db $0F,$00,$10,$00,$11,$00,$12,$00,$13,$00,$14,$00,$15,$00,$16,$00;839467;      ;
                       db $17,$00,$18,$00,$19,$00           ;839477;      ;
                                                            ;      ;      ;
         DATA8_83947D: db $88,$70,$C8,$70,$08,$71,$48,$71,$88,$71,$C8,$71,$08,$72,$48,$72;83947D;      ;
                       db $88,$72,$C8,$72,$08,$73,$90,$70   ;83948D;      ;
                                                            ;      ;      ;
          CODE_839495: %Set16bit(!MX)                             ;839495;      ;
                       STA.B $7E                            ;839497;00007E;
                       LDA.W $018B                          ;839499;00018B;
                       AND.W #$007F                         ;83949C;      ;
                       CMP.W #$0014                         ;83949F;      ;
                       BNE CODE_8394B0                      ;8394A2;8394B0;
                       %Set8bit(!M)                             ;8394A4;      ;
                       LDA.W $018B                          ;8394A6;00018B;
                       AND.B #$80                           ;8394A9;      ;
                       EOR.B #$80                           ;8394AB;      ;
                       STA.W $018B                          ;8394AD;00018B;
                                                            ;      ;      ;
          CODE_8394B0: %Set8bit(!M)                             ;8394B0;      ;
                       LDA.W $018B                          ;8394B2;00018B;
                       AND.B #$80                           ;8394B5;      ;
                       BNE CODE_8394C4                      ;8394B7;8394C4;
                       %Set16bit(!M)                             ;8394B9;      ;
                       LDA.W #$0000                         ;8394BB;      ;
                       JSL.L CODE_8394D7                    ;8394BE;8394D7;
                       BRA CODE_8394CD                      ;8394C2;8394CD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8394C4: %Set16bit(!M)                             ;8394C4;      ;
                       LDA.W #$0001                         ;8394C6;      ;
                       JSL.L CODE_8394D7                    ;8394C9;8394D7;
                                                            ;      ;      ;
          CODE_8394CD: %Set8bit(!M)                             ;8394CD;      ;
                       LDA.W $018B                          ;8394CF;00018B;
                       INC A                                ;8394D2;      ;
                       STA.W $018B                          ;8394D3;00018B;
                       RTS                                  ;8394D6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8394D7: %Set16bit(!MX)                             ;8394D7;      ;
                       PHA                                  ;8394D9;      ;
                       %Set8bit(!M)                             ;8394DA;      ;
                       %Set16bit(!X)                             ;8394DC;      ;
                       LDA.B #$00                           ;8394DE;      ;
                       XBA                                  ;8394E0;      ;
                       LDA.W $018A                          ;8394E1;00018A;
                       CMP.B #$0B                           ;8394E4;      ;
                       BCC CODE_8394EA                      ;8394E6;8394EA;
                       LDA.B #$0B                           ;8394E8;      ;
                                                            ;      ;      ;
          CODE_8394EA: %Set16bit(!M)                             ;8394EA;      ;
                       ASL A                                ;8394EC;      ;
                       TAX                                  ;8394ED;      ;
                       LDA.L DATA8_83947D,X                 ;8394EE;83947D;
                       TAX                                  ;8394F2;      ;
                       %Set16bit(!M)                             ;8394F3;      ;
                       PLA                                  ;8394F5;      ;
                       CMP.W #$0001                         ;8394F6;      ;
                       BEQ CODE_83950A                      ;8394F9;83950A;
                       %Set16bit(!M)                             ;8394FB;      ;
                       LDA.W #$9457                         ;8394FD;      ;
                       STA.B $72                            ;839500;000072;
                       %Set8bit(!M)                             ;839502;      ;
                       LDA.B #$83                           ;839504;      ;
                       STA.B $74                            ;839506;000074;
                       BRA CODE_839517                      ;839508;839517;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83950A: %Set16bit(!M)                             ;83950A;      ;
                       LDA.W #$945F                         ;83950C;      ;
                       STA.B $72                            ;83950F;000072;
                       %Set8bit(!M)                             ;839511;      ;
                       LDA.B #$83                           ;839513;      ;
                       STA.B $74                            ;839515;000074;
                                                            ;      ;      ;
          CODE_839517: JSL.L UNK_SetDMA2                    ;839517;8381B7;
                       RTL                                  ;83951B;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
            ADDDDFFFF: %Set8bit(!M)                             ;83951C;      ;
                       %Set16bit(!X)                             ;83951E;      ;
                       LDA.W $019B                          ;839520;00019B;
                       AND.B #$20                           ;839523;      ;
                       BEQ CODE_83952A                      ;839525;83952A;
                       JMP.W CODE_839447                    ;839527;839447;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83952A: LDA.W $019B                          ;83952A;00019B;
                       AND.B #$01                           ;83952D;      ;
                       BNE CODE_839534                      ;83952F;839534;
                       JMP.W $95F0                        ;839531;8395F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839534: %Set8bit(!M)                             ;839534;      ;
                       LDA.W $019B                          ;839536;00019B;
                       AND.B #$FD                           ;839539;      ;
                       STA.W $019B                          ;83953B;00019B;
                       %Set16bit(!M)                             ;83953E;      ;
                       LDA.W $0187                          ;839540;000187;
                       ASL A                                ;839543;      ;
                       TAY                                  ;839544;      ;
                       LDA.B [$01],Y                        ;839545;000001;
                       CMP.W #$00A2                         ;839547;      ;
                       BNE CODE_83954F                      ;83954A;83954F;
                       JMP.W CODE_8395F1                    ;83954C;8395F1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83954F: CMP.W #$00B1                         ;83954F;      ;
                       BNE CODE_839557                      ;839552;839557;
                       JMP.W CODE_83960D                    ;839554;83960D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839557: CMP.W #$FFFC                         ;839557;      ;
                       BNE CODE_83955F                      ;83955A;83955F;
                       JMP.W CODE_839621                    ;83955C;839621;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83955F: CMP.W #$FFFE                         ;83955F;      ;
                       BNE CODE_839567                      ;839562;839567;
                       JMP.W CODE_839719                    ;839564;839719;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839567: CMP.W #$FFFF                         ;839567;      ;
                       BNE CODE_83956F                      ;83956A;83956F;
                       JMP.W CODE_839752                    ;83956C;839752;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83956F: %Set8bit(!M)                             ;83956F;      ;
                       LDA.W $0189                          ;839571;000189;
                       CMP.B #$04                           ;839574;      ;
                       BNE CODE_8395E7                      ;839576;8395E7;
                       STZ.W $0189                          ;839578;000189;
                       %Set16bit(!M)                             ;83957B;      ;
                       LDA.B [$01],Y                        ;83957D;000001;
                       CMP.W #$FFFD                         ;83957F;      ;
                       BNE CODE_839587                      ;839582;839587;
                       JMP.W CODE_8396A1                    ;839584;8396A1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839587: %Set16bit(!MX)                             ;839587;      ;
                       LDA.B [$01],Y                        ;839589;000001;
                       %Set8bit(!X)                             ;83958B;      ;
                       LDX.B #$01                           ;83958D;      ;
                       CMP.W #$00BC                         ;83958F;      ;
                       BCC CODE_83959D                      ;839592;83959D;
                       CMP.W #$00C6                         ;839594;      ;
                       BCS CODE_83959D                      ;839597;83959D;
                       LDX.B #$00                           ;839599;      ;
                       BRA CODE_8395A4                      ;83959B;8395A4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83959D: CMP.W #$0270                         ;83959D;      ;
                       BNE CODE_8395A4                      ;8395A0;8395A4;
                       LDX.B #$00                           ;8395A2;      ;
                                                            ;      ;      ;
          CODE_8395A4: STX.W $0190                          ;8395A4;000190;
                       JSL.L CODE_839823                    ;8395A7;839823;
                       %Set8bit(!M)                             ;8395AB;      ;
                       %Set16bit(!X)                             ;8395AD;      ;
                       LDA.B #$03                           ;8395AF;      ;
                       STA.W $0114                          ;8395B1;000114;
                       LDA.B #$06                           ;8395B4;      ;
                       STA.W $0115                          ;8395B6;000115;
                       JSL.L UNK_Audio19                    ;8395B9;838332;
                       %Set8bit(!M)                             ;8395BD;      ;
                       LDA.W $019B                          ;8395BF;00019B;
                       ORA.B #$02                           ;8395C2;      ;
                       STA.W $019B                          ;8395C4;00019B;
                       %Set16bit(!MX)                             ;8395C7;      ;
                                                            ;      ;      ;
          CODE_8395C9: %Set8bit(!M)                             ;8395C9;      ;
                       LDA.W $018C                          ;8395CB;00018C;
                       BNE CODE_8395D9                      ;8395CE;8395D9;
                       %Set16bit(!M)                             ;8395D0;      ;
                       LDA.W $0187                          ;8395D2;000187;
                       INC A                                ;8395D5;      ;
                       STA.W $0187                          ;8395D6;000187;
                                                            ;      ;      ;
          CODE_8395D9: %Set8bit(!M)                             ;8395D9;      ;
                       LDA.B #$00                           ;8395DB;      ;
                       XBA                                  ;8395DD;      ;
                       LDA.W $0190                          ;8395DE;000190;
                       %Set16bit(!MX)                             ;8395E1;      ;
                       TAX                                  ;8395E3;      ;
                       JSR.W CODE_839838                    ;8395E4;839838;
                                                            ;      ;      ;
          CODE_8395E7: %Set8bit(!M)                             ;8395E7;      ;
                       LDA.W $0189                          ;8395E9;000189;
                       INC A                                ;8395EC;      ;
                       STA.W $0189                          ;8395ED;000189;
                                                            ;      ;      ;
               RTL                                  ;8395F0;      ;END_BCCCC
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8395F1: %Set8bit(!M)                             ;8395F1;      ;
                       LDA.W $019B                          ;8395F3;00019B;
                       ORA.B #$08                           ;8395F6;      ;
                       STA.W $019B                          ;8395F8;00019B;
                       %Set16bit(!M)                             ;8395FB;      ;
                       LDA.W #$5528                         ;8395FD;      ;
                       STA.W $0185                          ;839600;000185;
                       %Set16bit(!M)                             ;839603;      ;
                       LDA.W #$00A2                         ;839605;      ;
                       JSR.W CODE_83975F                    ;839608;83975F;
                       BRA $E3                                 ;      ;      ;
                                                            ;      ;      ;
          CODE_83960D: %Set16bit(!M)                             ;83960D;      ;
                       LDA.W $0187                          ;83960F;000187;
                       INC A                                ;839612;      ;
                       STA.W $0187                          ;839613;000187;
                       %Set16bit(!MX)                             ;839616;      ;
                       LDX.W #$0001                         ;839618;      ;
                       JSR.W CODE_839838                    ;83961B;839838;
                       JMP.W CODE_839534                    ;83961E;839534;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839621: %Set8bit(!M)                             ;839621;      ;
                       LDA.W $018C                          ;839623;00018C;
                       BNE CODE_83967A                      ;839626;83967A;
                       %Set16bit(!M)                             ;839628;      ;
                       LDA.W $0187                          ;83962A;000187;
                       ASL A                                ;83962D;      ;
                       TAY                                  ;83962E;      ;
                       INY                                  ;83962F;      ;
                       INY                                  ;839630;      ;
                       %Set8bit(!M)                             ;839631;      ;
                       LDA.B [$01],Y                        ;839633;000001;
                       STA.W $018C                          ;839635;00018C;
                       %Set16bit(!M)                             ;839638;      ;
                       INY                                  ;83963A;      ;
                       INY                                  ;83963B;      ;
                       LDA.B [$01],Y                        ;83963C;000001;
                       DEC A                                ;83963E;      ;
                       ASL A                                ;83963F;      ;
                       ASL A                                ;839640;      ;
                       TAX                                  ;839641;      ;
                       LDA.L DATA8_8398EE,X                 ;839642;8398EE;
                       STA.B $72                            ;839646;000072;
                       INX                                  ;839648;      ;
                       INX                                  ;839649;      ;
                       %Set8bit(!M)                             ;83964A;      ;
                       LDA.L DATA8_8398EE,X                 ;83964C;8398EE;
                       STA.B $74                            ;839650;000074;
                       STZ.W $0192                          ;839652;000192;
                       STZ.W $0193                          ;839655;000193;
                       STZ.W $0194                          ;839658;000194;
                       LDA.W $019B                          ;83965B;00019B;
                       AND.B #$7F                           ;83965E;      ;
                       STA.W $019B                          ;839660;00019B;
                       INX                                  ;839663;      ;
                       LDA.L DATA8_8398EE,X                 ;839664;8398EE;
                       LDY.W #$0000                         ;839668;      ;
                       LDX.W #$0000                         ;83966B;      ;
                                                            ;      ;      ;
          CODE_83966E: PHA                                  ;83966E;      ;
                       LDA.B [$72],Y                        ;83966F;000072;
                       STA.W $0192,X                        ;839671;000192;
                       INY                                  ;839674;      ;
                       INX                                  ;839675;      ;
                       PLA                                  ;839676;      ;
                       DEC A                                ;839677;      ;
                       BNE CODE_83966E                      ;839678;83966E;
                                                            ;      ;      ;
          CODE_83967A: %Set8bit(!M)                             ;83967A;      ;
                       LDA.W $018C                          ;83967C;00018C;
                       DEC A                                ;83967F;      ;
                       STA.W $018C                          ;839680;00018C;
                       JSL.L CODE_8397A6                    ;839683;8397A6;
                       %Set8bit(!M)                             ;839687;      ;
                       STZ.W $0190                          ;839689;000190;
                       %Set8bit(!M)                             ;83968C;      ;
                       STZ.W $0189                          ;83968E;000189;
                       LDA.W $018C                          ;839691;00018C;
                       BNE CODE_83969E                      ;839694;83969E;
                       LDA.W $0187                          ;839696;000187;
                       INC A                                ;839699;      ;
                       INC A                                ;83969A;      ;
                       STA.W $0187                          ;83969B;000187;
                                                            ;      ;      ;
          CODE_83969E: JMP.W CODE_8395C9                    ;83969E;8395C9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8396A1: %Set8bit(!M)                             ;8396A1;      ;
                       LDA.W $018C                          ;8396A3;00018C;
                       BNE CODE_8396BC                      ;8396A6;8396BC;
                       %Set16bit(!M)                             ;8396A8;      ;
                       LDA.W $0187                          ;8396AA;000187;
                       ASL A                                ;8396AD;      ;
                       TAY                                  ;8396AE;      ;
                       INY                                  ;8396AF;      ;
                       INY                                  ;8396B0;      ;
                       %Set8bit(!M)                             ;8396B1;      ;
                       LDA.B [$01],Y                        ;8396B3;000001;
                       STA.W $018C                          ;8396B5;00018C;
                       DEC A                                ;8396B8;      ;
                       STA.W $018D                          ;8396B9;00018D;
                                                            ;      ;      ;
          CODE_8396BC: %Set16bit(!M)                             ;8396BC;      ;
                       LDA.W $0187                          ;8396BE;000187;
                       ASL A                                ;8396C1;      ;
                       CLC                                  ;8396C2;      ;
                       ADC.W #$0004                         ;8396C3;      ;
                       TAY                                  ;8396C6;      ;
                       LDA.B [$01],Y                        ;8396C7;000001;
                       DEC A                                ;8396C9;      ;
                       ASL A                                ;8396CA;      ;
                       ASL A                                ;8396CB;      ;
                       TAX                                  ;8396CC;      ;
                       LDA.L DATA8_839AAE,X                 ;8396CD;839AAE;
                       STA.B $72                            ;8396D1;000072;
                       INX                                  ;8396D3;      ;
                       INX                                  ;8396D4;      ;
                       %Set8bit(!M)                             ;8396D5;      ;
                       LDA.L DATA8_839AAE,X                 ;8396D7;839AAE;
                       STA.B $74                            ;8396DB;000074;
                       %Set8bit(!M)                             ;8396DD;      ;
                       LDA.W $018C                          ;8396DF;00018C;
                       DEC A                                ;8396E2;      ;
                       STA.W $018C                          ;8396E3;00018C;
                       LDA.B #$00                           ;8396E6;      ;
                       XBA                                  ;8396E8;      ;
                       LDA.W $018D                          ;8396E9;00018D;
                       SEC                                  ;8396EC;      ;
                       SBC.W $018C                          ;8396ED;00018C;
                       %Set16bit(!MX)                             ;8396F0;      ;
                       ASL A                                ;8396F2;      ;
                       TAY                                  ;8396F3;      ;
                       LDA.B [$72],Y                        ;8396F4;000072;
                       LDX.W #$0001                         ;8396F6;      ;
                       JSL.L CODE_839823                    ;8396F9;839823;
                       %Set8bit(!M)                             ;8396FD;      ;
                       LDA.B #$01                           ;8396FF;      ;
                       STA.W $0190                          ;839701;000190;
                       %Set8bit(!M)                             ;839704;      ;
                       STZ.W $0189                          ;839706;000189;
                       LDA.W $018C                          ;839709;00018C;
                       BNE CODE_839716                      ;83970C;839716;
                       LDA.W $0187                          ;83970E;000187;
                       INC A                                ;839711;      ;
                       INC A                                ;839712;      ;
                       STA.W $0187                          ;839713;000187;
                                                            ;      ;      ;
          CODE_839716: JMP.W CODE_8395C9                    ;839716;8395C9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839719: %Set8bit(!M)                             ;839719;      ;
                       LDA.W $019B                          ;83971B;00019B;
                       ORA.B #$10                           ;83971E;      ;
                       STA.W $019B                          ;839720;00019B;
                       %Set16bit(!M)                             ;839723;      ;
                       LDA.W $0187                          ;839725;000187;
                       ASL A                                ;839728;      ;
                       TAY                                  ;839729;      ;
                       INY                                  ;83972A;      ;
                       INY                                  ;83972B;      ;
                       %Set8bit(!M)                             ;83972C;      ;
                       LDA.B [$01],Y                        ;83972E;000001;
                       DEC A                                ;839730;      ;
                       STA.W $018E                          ;839731;00018E;
                       %Set8bit(!M)                             ;839734;      ;
                       LDA.B #$00                           ;839736;      ;
                       XBA                                  ;839738;      ;
                       LDA.W $018F                          ;839739;00018F;
                       ASL A                                ;83973C;      ;
                       TAX                                  ;83973D;      ;
                       %Set16bit(!M)                             ;83973E;      ;
                       LDA.L DATA8_8398CC,X                 ;839740;8398CC;
                       STA.W $0185                          ;839744;000185;
                       %Set16bit(!M)                             ;839747;      ;
                       LDA.W #$0275                         ;839749;      ;
                       JSR.W CODE_83975F                    ;83974C;83975F;
                       JMP.W $95F0                        ;83974F;8395F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839752: %Set8bit(!M)                             ;839752;      ;
                       LDA.W $019B                          ;839754;00019B;
                       ORA.B #$04                           ;839757;      ;
                       STA.W $019B                          ;839759;00019B;
                       JMP.W $95F0                        ;83975C;8395F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83975F: %Set16bit(!M)                             ;83975F;      ;
                       STA.B $7E                            ;839761;00007E;
                       LDA.W $018B                          ;839763;00018B;
                       AND.W #$007F                         ;839766;      ;
                       CMP.W #$0014                         ;839769;      ;
                       BNE CODE_83977A                      ;83976C;83977A;
                       %Set8bit(!M)                             ;83976E;      ;
                       LDA.W $018B                          ;839770;00018B;
                       AND.B #$80                           ;839773;      ;
                       EOR.B #$80                           ;839775;      ;
                       STA.W $018B                          ;839777;00018B;
                                                            ;      ;      ;
          CODE_83977A: %Set8bit(!M)                             ;83977A;      ;
                       LDA.W $018B                          ;83977C;00018B;
                       AND.B #$80                           ;83977F;      ;
                       BNE CODE_839790                      ;839781;839790;
                       %Set16bit(!MX)                             ;839783;      ;
                       LDX.W #$0001                         ;839785;      ;
                       LDA.B $7E                            ;839788;00007E;
                       JSL.L CODE_839823                    ;83978A;839823;
                       BRA CODE_83979C                      ;83978E;83979C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839790: %Set16bit(!MX)                             ;839790;      ;
                       LDX.W #$0001                         ;839792;      ;
                       LDA.W #$00B1                         ;839795;      ;
                       JSL.L CODE_839823                    ;839798;839823;
                                                            ;      ;      ;
          CODE_83979C: %Set8bit(!M)                             ;83979C;      ;
                       LDA.W $018B                          ;83979E;00018B;
                       INC A                                ;8397A1;      ;
                       STA.W $018B                          ;8397A2;00018B;
                       RTS                                  ;8397A5;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8397A6: %Set8bit(!M)                             ;8397A6;      ;
                       %Set16bit(!X)                             ;8397A8;      ;
                       LDA.B #$00                           ;8397AA;      ;
                       XBA                                  ;8397AC;      ;
                       LDA.W $018C                          ;8397AD;00018C;
                       ASL A                                ;8397B0;      ;
                       CLC                                  ;8397B1;      ;
                       ADC.W $018C                          ;8397B2;00018C;
                       %Set16bit(!M)                             ;8397B5;      ;
                       TAX                                  ;8397B7;      ;
                       LDA.L DATA8_8398D6,X                 ;8397B8;8398D6;
                       STA.B $7E                            ;8397BC;00007E;
                       INX                                  ;8397BE;      ;
                       INX                                  ;8397BF;      ;
                       %Set8bit(!M)                             ;8397C0;      ;
                       LDA.L DATA8_8398D6,X                 ;8397C2;8398D6;
                       STA.B $80                            ;8397C6;000080;
                       LDX.W #$0000                         ;8397C8;      ;
                                                            ;      ;      ;
          CODE_8397CB: %Set16bit(!M)                             ;8397CB;      ;
                       LDA.W $0192                          ;8397CD;000192;
                       SEC                                  ;8397D0;      ;
                       SBC.B $7E                            ;8397D1;00007E;
                       STA.W $0192                          ;8397D3;000192;
                       %Set8bit(!M)                             ;8397D6;      ;
                       LDA.W $0194                          ;8397D8;000194;
                       SBC.B $80                            ;8397DB;000080;
                       STA.W $0194                          ;8397DD;000194;
                       BMI CODE_8397E5                      ;8397E0;8397E5;
                       INX                                  ;8397E2;      ;
                       BRA CODE_8397CB                      ;8397E3;8397CB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8397E5: %Set16bit(!M)                             ;8397E5;      ;
                       LDA.W $0192                          ;8397E7;000192;
                       CLC                                  ;8397EA;      ;
                       ADC.B $7E                            ;8397EB;00007E;
                       STA.W $0192                          ;8397ED;000192;
                       %Set8bit(!M)                             ;8397F0;      ;
                       LDA.W $0194                          ;8397F2;000194;
                       ADC.B $80                            ;8397F5;000080;
                       STA.W $0194                          ;8397F7;000194;
                       %Set8bit(!M)                             ;8397FA;      ;
                       LDA.W $019B                          ;8397FC;00019B;
                       AND.B #$80                           ;8397FF;      ;
                       BNE CODE_839810                      ;839801;839810;
                       CPX.W #$0000                         ;839803;      ;
                       BEQ CODE_839822                      ;839806;839822;
                       LDA.W $019B                          ;839808;00019B;
                       ORA.B #$80                           ;83980B;      ;
                       STA.W $019B                          ;83980D;00019B;
                                                            ;      ;      ;
          CODE_839810: %Set16bit(!MX)                             ;839810;      ;
                       TXA                                  ;839812;      ;
                       STA.B $7E                            ;839813;00007E;
                       LDA.W #$00BC                         ;839815;      ;
                       CLC                                  ;839818;      ;
                       ADC.B $7E                            ;839819;00007E;
                       LDX.W #$0000                         ;83981B;      ;
                       JSL.L CODE_839823                    ;83981E;839823;
                                                            ;      ;      ;
          CODE_839822: RTL                                  ;839822;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839823: %Set16bit(!MX)                             ;839823;      ;
                       LDX.W #$0000                         ;839825;      ;
                       PHX                                  ;839828;      ;
                       JSR.W CODE_839862                    ;839829;839862;
                       %Set16bit(!MX)                             ;83982C;      ;
                       PLX                                  ;83982E;      ;
                       TXA                                  ;83982F;      ;
                       LDX.W $0185                          ;839830;000185;
                       JSL.L UNK_SetDMA1                ;839833;838166;
                       RTL                                  ;839837;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839838: %Set16bit(!MX)                             ;839838;      ;
                       LDX.W #$0000                         ;83983A;      ;
                       TXA                                  ;83983D;      ;
                       ASL A                                ;83983E;      ;
                       ASL A                                ;83983F;      ;
                       ASL A                                ;839840;      ;
                       ADC.W #$0008                         ;839841;      ;
                       STA.B $80                            ;839844;000080;
                       LDA.W $0185                          ;839846;000185;
                       CLC                                  ;839849;      ;
                       ADC.B $80                            ;83984A;000080;
                       STA.W $0185                          ;83984C;000185;
                       AND.W #$00FF                         ;83984F;      ;
                       CMP.W #$0080                         ;839852;      ;
                       BNE CODE_839861                      ;839855;839861;
                       LDA.W $0185                          ;839857;000185;
                       CLC                                  ;83985A;      ;
                       ADC.W #$0080                         ;83985B;      ;
                       STA.W $0185                          ;83985E;000185;
                                                            ;      ;      ;
          CODE_839861: RTS                                  ;839861;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_839862: %Set16bit(!MX)                             ;839862;      ;
                       STA.B $7E                            ;839864;00007E;
                       LSR A                                ;839866;      ;
                       LSR A                                ;839867;      ;
                       LSR A                                ;839868;      ;
                       LSR A                                ;839869;      ;
                       LSR A                                ;83986A;      ;
                       LSR A                                ;83986B;      ;
                       STA.B $80                            ;83986C;000080;
                       ASL A                                ;83986E;      ;
                       CLC                                  ;83986F;      ;
                       ADC.B $80                            ;839870;000080;
                       TAX                                  ;839872;      ;
                       LDA.L DATA8_8398AE,X                 ;839873;8398AE;
                       STA.B $72                            ;839877;000072;
                       INX                                  ;839879;      ;
                       INX                                  ;83987A;      ;
                       %Set8bit(!M)                             ;83987B;      ;
                       LDA.L DATA8_8398AE,X                 ;83987D;8398AE;
                       STA.B $74                            ;839881;000074;
                       %Set16bit(!M)                             ;839883;      ;
                       LDA.B $7E                            ;839885;00007E;
                       AND.W #$003F                         ;839887;      ;
                       LSR A                                ;83988A;      ;
                       LSR A                                ;83988B;      ;
                       LSR A                                ;83988C;      ;
                       ASL A                                ;83988D;      ;
                       ASL A                                ;83988E;      ;
                       ASL A                                ;83988F;      ;
                       ASL A                                ;839890;      ;
                       ASL A                                ;839891;      ;
                       ASL A                                ;839892;      ;
                       ASL A                                ;839893;      ;
                       ASL A                                ;839894;      ;
                       ASL A                                ;839895;      ;
                       STA.B $80                            ;839896;000080;
                       LDA.B $7E                            ;839898;00007E;
                       AND.W #$0007                         ;83989A;      ;
                       ASL A                                ;83989D;      ;
                       ASL A                                ;83989E;      ;
                       ASL A                                ;83989F;      ;
                       ASL A                                ;8398A0;      ;
                       ASL A                                ;8398A1;      ;
                       STA.B $7E                            ;8398A2;00007E;
                       LDA.B $72                            ;8398A4;000072;
                       CLC                                  ;8398A6;      ;
                       ADC.B $7E                            ;8398A7;00007E;
                       ADC.B $80                            ;8398A9;000080;
                       STA.B $72                            ;8398AB;000072;
                       RTS                                  ;8398AD;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_8398AE: db $43,$98,$94,$43,$A8,$94,$43,$B8,$94,$43,$C8,$94,$43,$D8,$94,$43;8398AE;      ;
                       db $E8,$94,$00,$80,$95,$00,$90,$95,$00,$A0,$95,$00,$B0,$95;8398BE;      ;
                                                            ;      ;      ;
         DATA8_8398CC: db $10,$50,$70,$51,$50,$53,$08,$51,$68,$52;8398CC;      ;
                                                            ;      ;      ;
         DATA8_8398D6: db $01,$00,$00,$0A,$00,$00,$64,$00,$00,$E8,$03,$00,$10,$27,$00,$A0;8398D6;      ;
                       db $86,$01,$40,$42,$0F,$80,$96,$98   ;8398E6;      ;
                                                            ;      ;      ;
         DATA8_8398EE: db $04,$1F,$7F,$03,$0A,$1F,$7F,$01,$0B,$1F,$7F,$01,$0E,$1F,$7F,$02;8398EE;      ;
                       db $0C,$1F,$7F,$02,$10,$1F,$7F,$02,$12,$1F,$7F,$01,$04,$1F,$7F,$03;8398FE;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$1B,$1F,$7F,$01;83990E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83991E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83992E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83993E;      ;
                       db $04,$1F,$7F,$03,$15,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83994E;      ;
                       db $04,$1F,$7F,$03,$07,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83995E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83996E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83997E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83998E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;83999E;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;8399AE;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;8399BE;      ;
                       db $04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03,$04,$1F,$7F,$03;8399CE;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$0A,$1F,$7F,$01,$0B,$1F,$7F,$01;8399DE;      ;
                       db $17,$09,$80,$01,$B5,$09,$80,$01,$1F,$1F,$7F,$02,$21,$1F,$7F,$02;8399EE;      ;
                       db $23,$1F,$7F,$02,$25,$1F,$7F,$02,$27,$1F,$7F,$02,$4C,$1F,$7F,$02;8399FE;      ;
                       db $4A,$1F,$7F,$02,$50,$1F,$7F,$02,$4E,$1F,$7F,$02,$33,$1F,$7F,$02;839A0E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A1E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A2E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A3E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A4E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A5E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A6E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$1B,$1F,$7F,$01,$04,$1F,$7F,$03;839A7E;      ;
                       db $1B,$1F,$7F,$01,$04,$1F,$7F,$03,$54,$1F,$7F,$02,$54,$1F,$7F,$02;839A8E;      ;
                       db $54,$1F,$7F,$02,$54,$1F,$7F,$02,$54,$1F,$7F,$02,$56,$1F,$7F,$02;839A9E;      ;
                                                            ;      ;      ;
         DATA8_839AAE: db $DD,$08,$80,$08,$E5,$08,$80,$08,$89,$08,$80,$08,$89,$08,$80,$08;839AAE;      ;
                       db $89,$08,$80,$08,$89,$08,$80,$08,$D5,$08,$80,$08,$DD,$08,$80,$08;839ABE;      ;
                       db $D5,$08,$80,$08,$D5,$08,$80,$08,$DD,$08,$80,$08,$BF,$08,$80,$12;839ACE;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$E5,$08,$80,$08,$BF,$08,$80,$12;839ADE;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04;839AEE;      ;
                       db $B3,$08,$80,$0C,$A1,$08,$80,$0A,$DD,$08,$80,$08,$D5,$08,$80,$08;839AFE;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$89,$08,$80,$08,$D5,$08,$80,$08;839B0E;      ;
                       db $D5,$08,$80,$08,$ED,$08,$80,$08,$F5,$08,$80,$08,$DD,$08,$80,$08;839B1E;      ;
                       db $DD,$08,$80,$08,$E5,$08,$80,$08,$E5,$08,$80,$08,$89,$08,$80,$08;839B2E;      ;
                       db $BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12;839B3E;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04;839B4E;      ;
                       db $B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C;839B5E;      ;
                       db $BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12;839B6E;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04;839B7E;      ;
                       db $B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C;839B8E;      ;
                       db $BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12;839B9E;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04;839BAE;      ;
                       db $B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C;839BBE;      ;
                       db $BF,$08,$80,$12,$D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12;839BCE;      ;
                       db $D1,$08,$80,$04,$B3,$08,$80,$0C,$BF,$08,$80,$12,$D1,$08,$80,$04;839BDE;      ;
                       db $B3,$08,$80,$0C,$D5,$08,$80,$08   ;839BEE;      ;
                                                            ;      ;      ;
         DATA8_839BF6: db $00,$80,$B6,$D8,$80,$B6,$6C,$81,$B6,$1E,$82,$B6,$BE,$82,$B6,$B0;839BF6;      ;
                       db $83,$B6,$9A,$84,$B6,$42,$85,$B6,$D6,$85,$B6,$0C,$87,$B6,$02,$88;839C06;      ;
                       db $B6,$A4,$88,$B6,$F0,$88,$B6,$72,$89,$B6,$8A,$89,$B6,$46,$8A,$B6;839C16;      ;
                       db $5E,$8B,$B6,$68,$8C,$B6,$6E,$8D,$B6,$C6,$8E,$B6,$06,$90,$B6,$78;839C26;      ;
                       db $90,$B6,$72,$91,$B6,$48,$92,$B6,$A8,$93,$B6,$3E,$95,$B6,$A4,$95;839C36;      ;
                       db $B6,$38,$96,$B6,$E2,$96,$B6,$8C,$97,$B6,$12,$98,$B6,$60,$98,$B6;839C46;      ;
                       db $78,$98,$B6,$A0,$98,$B6,$DA,$98,$B6,$82,$99,$B6,$F2,$99,$B6,$70;839C56;      ;
                       db $9A,$B6,$DC,$9A,$B6,$46,$9B,$B6,$A4,$9B,$B6,$10,$9C,$B6,$6E,$9C;839C66;      ;
                       db $B6,$DC,$9C,$B6,$94,$9D,$B6,$F4,$9D,$B6,$12,$9E,$B6,$36,$9E,$B6;839C76;      ;
                       db $96,$9E,$B6,$BA,$9E,$B6,$52,$9F,$B6,$A6,$9F,$B6,$E0,$9F,$B6,$3E;839C86;      ;
                       db $A0,$B6,$CE,$A0,$B6,$C8,$A1,$B6,$2C,$A2,$B6,$C0,$A2,$B6,$64,$A3;839C96;      ;
                       db $B6,$FC,$A4,$B6,$04,$A6,$B6,$B2,$A6,$B6,$48,$A7,$B6,$EC,$A7,$B6;839CA6;      ;
                       db $9A,$A9,$B6,$16,$AA,$B6,$C0,$AA,$B6,$2E,$AB,$B6,$F0,$AB,$B6,$1E;839CB6;      ;
                       db $AD,$B6,$86,$AE,$B6,$4C,$AF,$B6,$DA,$AF,$B6,$3C,$B0,$B6,$46,$B0;839CC6;      ;
                       db $B6,$DC,$B0,$B6,$DE,$B1,$B6,$4A,$B2,$B6,$D2,$B2,$B6,$A8,$B3,$B6;839CD6;      ;
                       db $70,$B4,$B6,$12,$B5,$B6,$5C,$B5,$B6,$CE,$B5,$B6,$50,$B6,$B6,$26;839CE6;      ;
                       db $B7,$B6,$CC,$B7,$B6,$66,$B8,$B6,$32,$B9,$B6,$38,$BA,$B6,$48,$BB;839CF6;      ;
                       db $B6,$00,$BC,$B6,$A6,$BC,$B6,$EC,$BD,$B6,$10,$BF,$B6,$BE,$BF,$B6;839D06;      ;
                       db $20,$C1,$B6,$DA,$C1,$B6,$C2,$C2,$B6,$58,$C3,$B6,$56,$C4,$B6,$50;839D16;      ;
                       db $C5,$B6,$C8,$C5,$B6,$C6,$C6,$B6,$20,$C7,$B6,$1E,$C8,$B6,$68,$C8;839D26;      ;
                       db $B6,$32,$C9,$B6,$B2,$C9,$B6,$1C,$CA,$B6,$96,$CA,$B6,$22,$CB,$B6;839D36;      ;
                       db $CE,$CB,$B6,$1A,$CC,$B6,$04,$CD,$B6,$D0,$CD,$B6,$5A,$CE,$B6,$4A;839D46;      ;
                       db $CF,$B6,$E6,$CF,$B6,$7C,$D0,$B6,$44,$D1,$B6,$7A,$D2,$B6,$58,$D3;839D56;      ;
                       db $B6,$4E,$D4,$B6,$F8,$D4,$B6,$9A,$D5,$B6,$04,$D6,$B6,$78,$D6,$B6;839D66;      ;
                       db $D6,$D6,$B6,$5E,$D7,$B6,$7E,$D7,$B6,$B8,$D7,$B6,$16,$D8,$B6,$60;839D76;      ;
                       db $D8,$B6,$96,$D8,$B6,$06,$D9,$B6,$9A,$D9,$B6,$34,$DA,$B6,$BE,$DA;839D86;      ;
                       db $B6,$56,$DB,$B6,$DC,$DB,$B6,$EA,$DB,$B6,$76,$DC,$B6,$0E,$DD,$B6;839D96;      ;
                       db $2E,$DD,$B6,$7E,$DD,$B6,$FE,$DD,$B6,$70,$DE,$B6,$20,$DF,$B6,$84;839DA6;      ;
                       db $DF,$B6,$08,$E0,$B6,$66,$E0,$B6,$50,$E1,$B6,$64,$E1,$B6,$9C,$E1;839DB6;      ;
                       db $B6,$20,$E2,$B6,$AE,$E2,$B6,$DC,$E2,$B6,$9A,$E3,$B6,$60,$E4,$B6;839DC6;      ;
                       db $A2,$E4,$B6,$4A,$E5,$B6,$DA,$E5,$B6,$78,$E6,$B6,$C4,$E6,$B6,$F4;839DD6;      ;
                       db $E6,$B6,$7E,$E7,$B6,$C2,$E7,$B6,$FC,$E7,$B6,$4E,$E8,$B6,$CC,$E8;839DE6;      ;
                       db $B6,$14,$EA,$B6,$9E,$EB,$B6,$DE,$EB,$B6,$A2,$EC,$B6,$0A,$ED,$B6;839DF6;      ;
                       db $94,$ED,$B6,$C8,$ED,$B6,$D6,$ED,$B6,$78,$EE,$B6,$5A,$EF,$B6,$86;839E06;      ;
                       db $EF,$B6,$2A,$F0,$B6,$C6,$F0,$B6,$6E,$F1,$B6,$12,$F2,$B6,$CC,$F2;839E16;      ;
                       db $B6,$32,$F3,$B6,$B4,$F3,$B6,$62,$F4,$B6,$B8,$F4,$B6,$CC,$F4,$B6;839E26;      ;
                       db $58,$F5,$B6,$D6,$F5,$B6,$2E,$F7,$B6,$4E,$F8,$B6,$7C,$F8,$B6,$CA;839E36;      ;
                       db $F8,$B6,$04,$F9,$B6,$8E,$F9,$B6,$10,$FA,$B6,$AE,$FA,$B6,$C4,$FA;839E46;      ;
                       db $B6,$4A,$FB,$B6,$DC,$FB,$B6,$0E,$FC,$B6,$94,$FC,$B6,$32,$FD,$B6;839E56;      ;
                       db $84,$FE,$B6,$34,$FF,$B6,$00,$80,$B7,$AE,$80,$B7,$84,$81,$B7,$D6;839E66;      ;
                       db $81,$B7,$82,$82,$B7,$C4,$82,$B7,$22,$83,$B7,$7C,$83,$B7,$22,$84;839E76;      ;
                       db $B7,$DE,$84,$B7,$62,$85,$B7,$FA,$85,$B7,$10,$86,$B7,$E2,$86,$B7;839E86;      ;
                       db $7A,$87,$B7,$CC,$87,$B7,$FE,$87,$B7,$D2,$88,$B7,$00,$89,$B7,$30;839E96;      ;
                       db $89,$B7,$62,$89,$B7,$1E,$8A,$B7,$7C,$8A,$B7,$FC,$8A,$B7,$42,$8B;839EA6;      ;
                       db $B7,$72,$8B,$B7,$A6,$8B,$B7,$28,$8C,$B7,$EA,$8C,$B7,$94,$8D,$B7;839EB6;      ;
                       db $84,$8E,$B7,$E8,$8F,$B7,$8A,$90,$B7,$38,$91,$B7,$E6,$92,$B7,$6E;839EC6;      ;
                       db $94,$B7,$F8,$95,$B7,$3C,$97,$B7,$2E,$98,$B7,$72,$98,$B7,$1C,$99;839ED6;      ;
                       db $B7,$72,$99,$B7,$AA,$9A,$B7,$C0,$9A,$B7,$02,$9C,$B7,$C2,$9C,$B7;839EE6;      ;
                       db $1E,$9E,$B7,$DE,$9E,$B7,$BA,$9F,$B7,$98,$A0,$B7,$2C,$A1,$B7,$D6;839EF6;      ;
                       db $A1,$B7,$70,$A3,$B7,$DA,$A3,$B7,$FC,$A4,$B7,$7A,$A5,$B7,$FA,$A5;839F06;      ;
                       db $B7,$50,$A6,$B7,$98,$A6,$B7,$78,$A8,$B7,$60,$A9,$B7,$7E,$AA,$B7;839F16;      ;
                       db $B4,$AB,$B7,$52,$AC,$B7,$14,$AE,$B7,$62,$AF,$B7,$16,$B0,$B7,$68;839F26;      ;
                       db $B0,$B7,$48,$B1,$B7,$E4,$B1,$B7,$76,$B2,$B7,$76,$B3,$B7,$BA,$B3;839F36;      ;
                       db $B7,$2C,$B4,$B7,$08,$B5,$B7,$74,$B5,$B7,$B8,$B5,$B7,$7E,$B6,$B7;839F46;      ;
                       db $A8,$B6,$B7,$00,$B7,$B7,$F8,$B7,$B7,$36,$B9,$B7,$CA,$B9,$B7,$E2;839F56;      ;
                       db $B9,$B7,$D2,$BB,$B7,$90,$BC,$B7,$58,$BD,$B7,$F0,$BD,$B7,$F8,$BE;839F66;      ;
                       db $B7,$00,$C0,$B7,$4C,$C1,$B7,$AA,$C1,$B7,$FA,$C1,$B7,$7E,$C2,$B7;839F76;      ;
                       db $16,$C3,$B7,$9E,$C3,$B7,$EA,$C3,$B7,$40,$C4,$B7,$E0,$C4,$B7,$D0;839F86;      ;
                       db $C5,$B7,$1C,$C6,$B7,$60,$C6,$B7,$8E,$C8,$B7,$52,$C9,$B7,$8C,$C9;839F96;      ;
                       db $B7,$EC,$C9,$B7,$DC,$CA,$B7,$28,$CB,$B7,$B0,$CB,$B7,$FA,$CB,$B7;839FA6;      ;
                       db $A6,$CC,$B7,$82,$CD,$B7,$7C,$CE,$B7,$62,$CF,$B7,$94,$CF,$B7,$74;839FB6;      ;
                       db $D0,$B7,$1E,$D1,$B7,$D0,$D1,$B7,$1A,$D2,$B7,$E0,$D3,$B7,$BA,$D5;839FC6;      ;
                       db $B7,$3C,$D6,$B7,$6A,$D7,$B7,$36,$D8,$B7,$28,$DA,$B7,$A6,$DA,$B7;839FD6;      ;
                       db $4C,$DB,$B7,$AA,$DB,$B7,$CA,$DB,$B7,$48,$DC,$B7,$CA,$DC,$B7,$2E;839FE6;      ;
                       db $DD,$B7,$9A,$DD,$B7,$40,$DE,$B7,$EA,$DE,$B7,$72,$DF,$B7,$FE,$DF;839FF6;      ;
                       db $B7,$A0,$E0,$B7,$94,$E1,$B7,$EA,$E1,$B7,$96,$E2,$B7,$30,$E3,$B7;83A006;      ;
                       db $D6,$E3,$B7,$1C,$E4,$B7,$A2,$E4,$B7,$14,$E5,$B7,$4C,$E5,$B7,$7A;83A016;      ;
                       db $E5,$B7,$CA,$E5,$B7,$60,$E6,$B7,$14,$E7,$B7,$62,$E7,$B7,$C2,$E7;83A026;      ;
                       db $B7,$C0,$E8,$B7,$16,$E9,$B7,$E0,$E9,$B7,$CC,$EA,$B7,$62,$EB,$B7;83A036;      ;
                       db $B0,$EB,$B7,$0C,$EC,$B7,$C8,$EC,$B7,$9C,$ED,$B7,$B8,$ED,$B7,$04;83A046;      ;
                       db $EE,$B7,$2E,$EE,$B7,$52,$EE,$B7,$66,$EE,$B7,$A0,$EE,$B7,$C2,$EE;83A056;      ;
                       db $B7,$2C,$EF,$B7,$64,$EF,$B7,$9C,$EF,$B7,$1C,$F0,$B7,$44,$F0,$B7;83A066;      ;
                       db $6A,$F0,$B7,$B4,$F0,$B7,$EC,$F0,$B7,$30,$F1,$B7,$90,$F1,$B7,$20;83A076;      ;
                       db $F2,$B7,$9A,$F2,$B7,$54,$F3,$B7,$16,$F4,$B7,$A2,$F4,$B7,$38,$F5;83A086;      ;
                       db $B7,$C6,$F5,$B7,$84,$F6,$B7,$78,$F7,$B7,$E2,$F7,$B7,$C2,$F8,$B7;83A096;      ;
                       db $F4,$F8,$B7,$C2,$F9,$B7,$70,$FA,$B7,$BA,$FA,$B7,$EC,$FA,$B7,$32;83A0A6;      ;
                       db $FB,$B7,$92,$FB,$B7,$D6,$FB,$B7,$52,$FC,$B7,$A2,$FC,$B7,$F2,$FC;83A0B6;      ;
                       db $B7,$48,$FD,$B7,$9A,$FD,$B7,$F4,$FD,$B7,$1A,$FE,$B7,$7C,$FE,$B7;83A0C6;      ;
                       db $22,$FF,$B7,$A0,$FF,$B7,$00,$80,$B8,$9C,$80,$B8,$E2,$80,$B8,$2E;83A0D6;      ;
                       db $81,$B8,$86,$81,$B8,$D4,$81,$B8,$1E,$82,$B8,$8C,$82,$B8,$C4,$82;83A0E6;      ;
                       db $B8,$74,$83,$B8,$96,$83,$B8,$CE,$83,$B8,$EA,$83,$B8,$32,$84,$B8;83A0F6;      ;
                       db $5C,$84,$B8,$78,$84,$B8,$A8,$84,$B8,$3C,$85,$B8,$56,$85,$B8,$B2;83A106;      ;
                       db $85,$B8,$C0,$85,$B8,$1E,$86,$B8,$9C,$86,$B8,$E8,$86,$B8,$34,$87;83A116;      ;
                       db $B8,$68,$87,$B8,$AE,$87,$B8,$00,$88,$B8,$8A,$88,$B8,$9C,$88,$B8;83A126;      ;
                       db $F4,$88,$B8,$02,$89,$B8,$14,$89,$B8,$2A,$89,$B8,$C4,$8A,$B8,$E2;83A136;      ;
                       db $8A,$B8,$7A,$8B,$B8,$B2,$8B,$B8,$06,$8C,$B8,$2E,$8C,$B8,$82,$8C;83A146;      ;
                       db $B8,$22,$8D,$B8,$78,$8D,$B8,$60,$8F,$B8,$E8,$8F,$B8,$FE,$90,$B8;83A156;      ;
                       db $66,$91,$B8,$0A,$92,$B8,$A6,$92,$B8,$08,$93,$B8,$54,$93,$B8,$D4;83A166;      ;
                       db $93,$B8,$86,$94,$B8,$DC,$94,$B8,$1E,$95,$B8,$20,$96,$B8,$34,$96;83A176;      ;
                       db $B8,$78,$96,$B8,$3E,$98,$B8,$38,$99,$B8,$38,$9A,$B8,$6E,$9A,$B8;83A186;      ;
                       db $24,$9B,$B8,$2E,$9C,$B8,$CC,$9C,$B8,$76,$9D,$B8,$2A,$9E,$B8,$80;83A196;      ;
                       db $9E,$B8,$04,$9F,$B8,$BE,$9F,$B8,$20,$A0,$B8,$64,$A0,$B8,$2E,$A1;83A1A6;      ;
                       db $B8,$AC,$A1,$B8,$34,$A2,$B8,$82,$A2,$B8,$EC,$A2,$B8,$FA,$A2,$B8;83A1B6;      ;
                       db $B8,$A3,$B8,$48,$A4,$B8,$DA,$A5,$B8,$1E,$A6,$B8,$6C,$A6,$B8,$9C;83A1C6;      ;
                       db $A6,$B8,$FC,$A6,$B8,$2C,$A7,$B8,$88,$A7,$B8,$0E,$A8,$B8,$70,$A8;83A1D6;      ;
                       db $B8,$BA,$A8,$B8,$86,$A9,$B8,$4E,$AA,$B8,$BA,$AA,$B8,$14,$AB,$B8;83A1E6;      ;
                       db $E8,$AB,$B8,$FE,$AB,$B8,$42,$AD,$B8,$26,$AF,$B8,$D6,$AF,$B8,$34;83A1F6;      ;
                       db $B0,$B8,$F2,$B0,$B8,$8A,$B1,$B8,$1C,$B2,$B8,$B8,$B2,$B8,$1E,$B3;83A206;      ;
                       db $B8,$84,$B3,$B8,$08,$B4,$B8,$CA,$B4,$B8,$3C,$B6,$B8,$C0,$B7,$B8;83A216;      ;
                       db $2E,$B9,$B8,$C4,$B9,$B8,$18,$BA,$B8,$70,$BA,$B8,$CE,$BA,$B8,$DC;83A226;      ;
                       db $BC,$B8,$76,$BD,$B8,$10,$BE,$B8,$6C,$BE,$B8,$C4,$BE,$B8,$24,$BF;83A236;      ;
                       db $B8,$8A,$BF,$B8,$EA,$BF,$B8,$4C,$C0,$B8,$36,$C1,$B8,$B6,$C1,$B8;83A246;      ;
                       db $38,$C2,$B8,$EC,$C2,$B8,$7E,$C3,$B8,$EA,$C3,$B8,$22,$C4,$B8,$66;83A256;      ;
                       db $C4,$B8,$E8,$C4,$B8,$6A,$C5,$B8,$F6,$C5,$B8,$7C,$C6,$B8,$00,$C7;83A266;      ;
                       db $B8,$D2,$C7,$B8,$14,$C8,$B8,$60,$C8,$B8,$14,$C9,$B8,$98,$C9,$B8;83A276;      ;
                       db $F8,$C9,$B8,$66,$CA,$B8,$52,$CB,$B8,$FA,$CB,$B8,$66,$CC,$B8,$94;83A286;      ;
                       db $CD,$B8,$C8,$CD,$B8,$14,$CE,$B8,$BA,$CF,$B8,$06,$D0,$B8,$D8,$D0;83A296;      ;
                       db $B8,$4A,$D1,$B8,$E2,$D1,$B8,$80,$D2,$B8,$2C,$D3,$B8,$AE,$D3,$B8;83A2A6;      ;
                       db $1E,$D4,$B8,$E6,$D5,$B8,$50,$D6,$B8,$AE,$D6,$B8,$E2,$D6,$B8,$48;83A2B6;      ;
                       db $D7,$B8,$9A,$D7,$B8,$DE,$D8,$B8,$26,$DA,$B8,$A4,$DA,$B8,$BE,$DA;83A2C6;      ;
                       db $B8,$20,$DC,$B8,$D6,$DD,$B8,$2A,$DE,$B8,$94,$DE,$B8,$36,$DF,$B8;83A2D6;      ;
                       db $EE,$DF,$B8,$28,$E0,$B8,$6C,$E0,$B8,$4E,$E1,$B8,$D2,$E1,$B8,$2C;83A2E6;      ;
                       db $E2,$B8,$7E,$E2,$B8,$08,$E3,$B8,$40,$E3,$B8,$4C,$E3,$B8,$F8,$E3;83A2F6;      ;
                       db $B8,$56,$E4,$B8,$C8,$E4,$B8,$94,$E5,$B8,$48,$E6,$B8,$08,$E7,$B8;83A306;      ;
                       db $24,$E7,$B8,$54,$E7,$B8,$84,$E7,$B8,$A2,$E8,$B8,$22,$E9,$B8,$C0;83A316;      ;
                       db $E9,$B8,$52,$EA,$B8,$9C,$EA,$B8,$94,$EB,$B8,$E0,$EB,$B8,$16,$EC;83A326;      ;
                       db $B8,$30,$ED,$B8,$EA,$ED,$B8,$FE,$ED,$B8,$96,$EE,$B8,$96,$EF,$B8;83A336;      ;
                       db $52,$F0,$B8,$98,$F0,$B8,$E8,$F0,$B8,$FA,$F2,$B8,$36,$F4,$B8,$1C;83A346;      ;
                       db $F6,$B8,$D6,$F6,$B8,$1E,$F7,$B8,$F0,$F7,$B8,$36,$F8,$B8,$7E,$F8;83A356;      ;
                       db $B8,$EC,$F8,$B8,$4E,$FA,$B8,$96,$FA,$B8,$34,$FB,$B8,$F2,$FB,$B8;83A366;      ;
                       db $14,$FC,$B8,$66,$FC,$B8,$CC,$FC,$B8,$46,$FD,$B8,$9A,$FD,$B8,$F8;83A376;      ;
                       db $FD,$B8,$22,$FE,$B8,$46,$FE,$B8,$AA,$FE,$B8,$F0,$FE,$B8,$00,$80;83A386;      ;
                       db $B9,$A4,$80,$B9,$38,$81,$B9,$C4,$81,$B9,$C8,$82,$B9,$6C,$84,$B9;83A396;      ;
                       db $2A,$85,$B9,$7A,$85,$B9,$54,$86,$B9,$32,$87,$B9,$7A,$87,$B9,$90;83A3A6;      ;
                       db $87,$B9,$BA,$87,$B9,$AC,$88,$B9,$2E,$89,$B9,$64,$89,$B9,$88,$89;83A3B6;      ;
                       db $B9,$EE,$89,$B9,$3E,$8A,$B9,$84,$8A,$B9,$22,$8B,$B9,$7E,$8B,$B9;83A3C6;      ;
                       db $CC,$8B,$B9,$DA,$8B,$B9,$54,$8C,$B9,$98,$8C,$B9,$1E,$8D,$B9,$6C;83A3D6;      ;
                       db $8D,$B9,$D4,$8D,$B9,$78,$8E,$B9,$BC,$8E,$B9,$04,$8F,$B9,$CA,$8F;83A3E6;      ;
                       db $B9,$14,$90,$B9,$3C,$90,$B9,$48,$91,$B9,$48,$92,$B9,$C6,$92,$B9;83A3F6;      ;
                       db $16,$93,$B9,$7A,$93,$B9,$DA,$93,$B9,$3C,$94,$B9,$9E,$94,$B9,$34;83A406;      ;
                       db $95,$B9,$02,$96,$B9,$EA,$96,$B9,$56,$97,$B9,$3A,$98,$B9,$82,$98;83A416;      ;
                       db $B9,$20,$99,$B9,$9A,$99,$B9,$DE,$99,$B9,$64,$9A,$B9,$06,$9B,$B9;83A426;      ;
                       db $A4,$9C,$B9,$8E,$9D,$B9,$BA,$9D,$B9,$D4,$9D,$B9,$2A,$9E,$B9,$CA;83A436;      ;
                       db $9E,$B9,$26,$9F,$B9,$56,$9F,$B9,$20,$A0,$B9,$D4,$A0,$B9,$28,$A1;83A446;      ;
                       db $B9,$C8,$A1,$B9,$C2,$A2,$B9,$50,$A3,$B9,$06,$A4,$B9,$70,$A4,$B9;83A456;      ;
                       db $38,$A5,$B9,$8E,$A5,$B9,$D4,$A5,$B9,$20,$A6,$B9,$AC,$A6,$B9,$64;83A466;      ;
                       db $A7,$B9,$00,$A8,$B9,$8E,$A8,$B9,$FE,$A8,$B9,$54,$A9,$B9,$A2,$A9;83A476;      ;
                       db $B9,$EC,$A9,$B9,$70,$AA,$B9,$96,$AA,$B9,$36,$AC,$B9,$7A,$AC,$B9;83A486;      ;
                       db $D2,$AC,$B9,$22,$AD,$B9,$4A,$AD,$B9,$A4,$AD,$B9,$DA,$AD,$B9,$28;83A496;      ;
                       db $AE,$B9,$88,$AE,$B9,$EA,$AE,$B9,$6E,$AF,$B9,$16,$B0,$B9,$72,$B0;83A4A6;      ;
                       db $B9,$F4,$B0,$B9,$A2,$B1,$B9,$1E,$B2,$B9,$7E,$B2,$B9,$CC,$B2,$B9;83A4B6;      ;
                       db $2A,$B3,$B9,$6E,$B3,$B9,$84,$B3,$B9,$DC,$B3,$B9,$42,$B4,$B9,$C8;83A4C6;      ;
                       db $B4,$B9,$34,$B5,$B9,$6E,$B6,$B9,$C2,$B6,$B9,$EC,$B6,$B9,$40,$B7;83A4D6;      ;
                       db $B9,$86,$B7,$B9,$24,$B9,$B9,$58,$BA,$B9,$AC,$BA,$B9,$DC,$BA,$B9;83A4E6;      ;
                       db $30,$BB,$B9,$A0,$BC,$B9,$94,$BE,$B9,$D8,$BE,$B9,$E2,$BE,$B9,$8C;83A4F6;      ;
                       db $BF,$B9,$56,$C0,$B9,$B6,$C0,$B9,$A2,$C1,$B9,$DC,$C1,$B9,$56,$C2;83A506;      ;
                       db $B9,$3E,$C3,$B9,$EA,$C3,$B9,$D2,$C4,$B9,$7E,$C5,$B9,$5A,$C6,$B9;83A516;      ;
                       db $8E,$C6,$B9,$DE,$C6,$B9,$E4,$C7,$B9,$FA,$C8,$B9,$3E,$C9,$B9,$B4;83A526;      ;
                       db $CA,$B9,$24,$CB,$B9,$3C,$CC,$B9,$90,$CC,$B9,$E4,$CC,$B9,$1E,$CD;83A536;      ;
                       db $B9,$DC,$CD,$B9,$24,$CE,$B9,$C8,$CE,$B9,$10,$CF,$B9,$8C,$D0,$B9;83A546;      ;
                       db $1E,$D1,$B9,$92,$D2,$B9,$26,$D3,$B9,$8E,$D3,$B9,$D2,$D3,$B9,$A0;83A556;      ;
                       db $D4,$B9,$02,$D5,$B9,$36,$D5,$B9,$14,$D6,$B9,$AC,$D6,$B9,$2C,$D7;83A566;      ;
                       db $B9,$3E,$D7,$B9,$80,$D7,$B9,$D8,$D7,$B9,$08,$D9,$B9,$76,$D9,$B9;83A576;      ;
                       db $DE,$D9,$B9,$B4,$DA,$B9,$AE,$DB,$B9,$DC,$DB,$B9,$CC,$DC,$B9,$46;83A586;      ;
                       db $DD,$B9,$38,$DE,$B9,$78,$DF,$B9,$38,$E0,$B9,$72,$E0,$B9,$78,$E1;83A596;      ;
                       db $B9,$38,$E2,$B9,$08,$E4,$B9,$98,$E5,$B9,$D2,$E6,$B9,$68,$E8,$B9;83A5A6;      ;
                       db $40,$EA,$B9,$AA,$EB,$B9,$36,$ED,$B9,$F8,$EE,$B9,$9A,$F0,$B9,$EC;83A5B6;      ;
                       db $F1,$B9,$38,$F3,$B9,$C8,$F4,$B9,$2C,$F6,$B9,$5A,$F7,$B9,$CA,$F7;83A5C6;      ;
                       db $B9,$22,$F8,$B9,$8A,$F8,$B9,$BA,$F8,$B9,$EA,$F8,$B9,$52,$F9,$B9;83A5D6;      ;
                       db $C4,$F9,$B9,$A6,$FA,$B9,$88,$FB,$B9,$6A,$FC,$B9,$5E,$FD,$B9,$82;83A5E6;      ;
                       db $FE,$B9,$00,$80,$BA,$12,$81,$BA,$18,$82,$BA,$EE,$82,$BA,$46,$84;83A5F6;      ;
                       db $BA,$46,$85,$BA,$6A,$86,$BA,$82,$87,$BA,$D2,$88,$BA,$E4,$89,$BA;83A606;      ;
                       db $F8,$89,$BA,$92,$8B,$BA,$E6,$8B,$BA,$66,$8C,$BA,$D2,$8C,$BA,$54;83A616;      ;
                       db $8D,$BA,$E6,$8D,$BA,$4A,$8E,$BA,$E8,$8E,$BA,$7E,$8F,$BA,$14,$90;83A626;      ;
                       db $BA,$98,$90,$BA,$F2,$90,$BA,$4E,$91,$BA,$92,$91,$BA,$CA,$91,$BA;83A636;      ;
                       db $E6,$91,$BA,$18,$92,$BA,$AA,$92,$BA,$14,$93,$BA,$1E,$94,$BA,$28;83A646;      ;
                       db $95,$BA,$C0,$95,$BA,$3C,$96,$BA,$82,$96,$BA,$BC,$96,$BA,$EE,$96;83A656;      ;
                       db $BA,$52,$97,$BA,$9A,$97,$BA,$2C,$98,$BA,$60,$98,$BA,$A4,$98,$BA;83A666;      ;
                       db $F4,$98,$BA,$38,$99,$BA,$C4,$99,$BA,$F0,$99,$BA,$5A,$9A,$BA,$0E;83A676;      ;
                       db $9B,$BA,$3C,$9B,$BA,$66,$9B,$BA,$00,$9C,$BA,$24,$9C,$BA,$5C,$9C;83A686;      ;
                       db $BA,$1A,$9D,$BA,$B6,$9D,$BA,$5A,$9E,$BA,$6E,$9E,$BA,$9C,$9E,$BA;83A696;      ;
                       db $38,$9F,$BA,$70,$9F,$BA,$BC,$9F,$BA,$E4,$9F,$BA,$DC,$A0,$BA,$B0;83A6A6;      ;
                       db $A1,$BA,$40,$A2,$BA,$C4,$A2,$BA,$38,$A4,$BA,$CC,$A4,$BA,$6E,$A5;83A6B6;      ;
                       db $BA,$CE,$A5,$BA,$76,$A6,$BA,$4C,$A7,$BA,$F2,$A7,$BA,$68,$A9,$BA;83A6C6;      ;
                       db $B2,$A9,$BA,$52,$AA,$BA,$64,$AA,$BA,$0A,$AB,$BA,$56,$AB,$BA,$A0;83A6D6;      ;
                       db $AB,$BA,$0C,$AE,$BA,$12,$AE,$BA,$1A,$AE,$BA,$24,$AE,$BA,$30,$AE;83A6E6;      ;
                       db $BA,$3E,$AE,$BA,$4E,$AE,$BA,$60,$AE,$BA,$74,$AE,$BA,$8A,$AE,$BA;83A6F6;      ;
                       db $A2,$AE,$BA,$CA,$AE,$BA,$3A,$AF,$BA,$88,$AF,$BA,$DC,$AF,$BA,$2E;83A706;      ;
                       db $B0,$BA,$B4,$B0,$BA,$5E,$B1,$BA,$00,$B2,$BA,$22,$B2,$BA,$50,$B2;83A716;      ;
                       db $BA,$6C,$B2,$BA,$B8,$B2,$BA,$F0,$B2,$BA,$44,$B3,$BA,$0A,$B4,$BA;83A726;      ;
                       db $AC,$B4,$BA,$2E,$B5,$BA,$8A,$B5,$BA,$3A,$B6,$BA,$06,$B7,$BA,$B8;83A736;      ;
                       db $B7,$BA,$6A,$B8,$BA,$0E,$B9,$BA,$CE,$B9,$BA,$E8,$BA,$BA,$E0,$BB;83A746;      ;
                       db $BA,$28,$BC,$BA,$56,$BD,$BA,$00,$BE,$BA,$D4,$BE,$BA,$26,$BF,$BA;83A756;      ;
                       db $5A,$C0,$BA,$30,$C1,$BA,$04,$C2,$BA,$E2,$C2,$BA,$72,$C3,$BA,$0A;83A766;      ;
                       db $C4,$BA,$74,$C4,$BA,$C4,$C4,$BA,$4A,$C5,$BA,$2A,$C6,$BA,$4A,$C6;83A776;      ;
                       db $BA,$02,$C7,$BA,$86,$C7,$BA,$4C,$C8,$BA,$DE,$C8,$BA,$82,$C9,$BA;83A786;      ;
                       db $62,$CA,$BA,$A6,$CA,$BA,$24,$CB,$BA,$A8,$CB,$BA,$EC,$CB,$BA,$46;83A796;      ;
                       db $CC,$BA,$7E,$CD,$BA,$88,$CE,$BA,$A8,$CF,$BA,$A4,$D0,$BA,$FC,$D0;83A7A6;      ;
                       db $BA,$50,$D1,$BA,$B0,$D1,$BA,$F6,$D1,$BA,$5E,$D2,$BA,$AC,$D2,$BA;83A7B6;      ;
                       db $44,$D3,$BA,$D4,$D3,$BA,$36,$D4,$BA,$F6,$D4,$BA,$7A,$D5,$BA,$D8;83A7C6;      ;
                       db $D5,$BA,$7C,$D6,$BA,$00,$D7,$BA,$72,$D7,$BA,$44,$D8,$BA,$E6,$D8;83A7D6;      ;
                       db $BA,$84,$D9,$BA,$F2,$D9,$BA,$8E,$DA,$BA,$66,$DB,$BA,$24,$DC,$BA;83A7E6;      ;
                       db $C8,$DC,$BA,$22,$DD,$BA,$8E,$DD,$BA,$08,$DE,$BA,$6A,$DE,$BA,$BC;83A7F6;      ;
                       db $DE,$BA,$26,$DF,$BA,$B2,$DF,$BA,$4C,$E0,$BA,$2A,$E1,$BA,$C0,$E1;83A806;      ;
                       db $BA,$80,$E2,$BA,$D4,$E2,$BA,$9A,$E3,$BA,$00,$E4,$BA,$B6,$E4,$BA;83A816;      ;
                       db $1C,$E5,$BA,$52,$E5,$BA,$36,$E6,$BA,$B6,$E6,$BA,$12,$E7,$BA,$6C;83A826;      ;
                       db $E7,$BA,$3E,$E8,$BA,$A8,$E8,$BA,$48,$E9,$BA,$6E,$E9,$BA,$C8,$E9;83A836;      ;
                       db $BA,$28,$EA,$BA,$88,$EA,$BA,$9A,$EA,$BA,$3A,$EB,$BA,$A2,$EB,$BA;83A846;      ;
                       db $EE,$EB,$BA,$AA,$EC,$BA,$EE,$EC,$BA,$90,$ED,$BA,$F2,$ED,$BA,$50;83A856;      ;
                       db $EE,$BA,$A4,$EE,$BA,$56,$EF,$BA,$C2,$EF,$BA,$5A,$F0,$BA,$88,$F0;83A866;      ;
                       db $BA,$3A,$F1,$BA,$7A,$F2,$BA,$F6,$F2,$BA,$9C,$F3,$BA,$06,$F4,$BA;83A876;      ;
                       db $4A,$F4,$BA,$DC,$F4,$BA,$98,$F5,$BA,$08,$F6,$BA,$C4,$F7,$BA,$32;83A886;      ;
                       db $F8,$BA,$E6,$F8,$BA,$EE,$F9,$BA,$DE,$FA,$BA,$7C,$FB,$BA,$68,$FC;83A896;      ;
                       db $BA,$24,$FD,$BA,$96,$FE,$BA,$06,$FF,$BA,$00,$80,$BB,$2A,$81,$BB;83A8A6;      ;
                       db $60,$82,$BB,$AC,$83,$BB,$48,$85,$BB,$70,$85,$BB,$C6,$85,$BB,$E0;83A8B6;      ;
                       db $85,$BB,$34,$86,$BB,$4E,$86,$BB,$98,$86,$BB,$BC,$86,$BB,$E0,$86;83A8C6;      ;
                       db $BB,$04,$87,$BB,$28,$87,$BB,$4C,$87,$BB,$8E,$87,$BB,$D0,$87,$BB;83A8D6;      ;
                       db $12,$88,$BB,$54,$88,$BB,$6C,$88,$BB,$90,$88,$BB,$E0,$88,$BB,$08;83A8E6;      ;
                       db $89,$BB,$B6,$89,$BB,$F6,$8B,$BB,$D0,$8D,$BB,$0E,$8F,$BB,$B2,$8F;83A8F6;      ;
                       db $BB,$80,$92,$BB,$54,$94,$BB,$BA,$95,$BB,$8C,$97,$BB,$32,$99,$BB;83A906;      ;
                       db $DC,$99,$BB,$FE,$9A,$BB,$82,$9B,$BB,$32,$9D,$BB,$42,$9E,$BB,$A4;83A916;      ;
                       db $9F,$BB,$38,$A1,$BB,$C0,$A2,$BB,$0A,$A3,$BB,$70,$A3,$BB,$F2,$A3;83A926;      ;
                       db $BB,$36,$A4,$BB,$14,$A5,$BB,$90,$A5,$BB,$0C,$A6,$BB,$88,$A6,$BB;83A936;      ;
                       db $04,$A7,$BB,$9A,$A7,$BB,$32,$A8,$BB,$AE,$A8,$BB,$2A,$A9,$BB,$DE;83A946;      ;
                       db $A9,$BB,$86,$AA,$BB,$1A,$AB,$BB,$02,$AC,$BB,$EC,$AC,$BB,$80,$AE;83A956;      ;
                       db $BB,$44,$AF,$BB,$AE,$AF,$BB,$34,$B0,$BB,$A6,$B0,$BB,$4E,$B1,$BB;83A966;      ;
                       db $48,$B2,$BB,$A2,$B2,$BB,$D6,$B2,$BB,$84,$B3,$BB,$EE,$B3,$BB,$6A;83A976;      ;
                       db $B4,$BB,$B6,$B4,$BB,$A4,$B5,$BB,$40,$B6,$BB,$92,$B6,$BB,$00,$B7;83A986;      ;
                       db $BB,$8E,$B7,$BB,$32,$B8,$BB,$6A,$B8,$BB,$D8,$B8,$BB,$58,$B9,$BB;83A996;      ;
                       db $FE,$B9,$BB,$30,$BA,$BB,$B4,$BA,$BB,$44,$BB,$BB,$A2,$BB,$BB,$44;83A9A6;      ;
                       db $BC,$BB,$BC,$BC,$BB,$54,$BD,$BB   ;83A9B6;      ;

;;;;;;;; Presets all the variables
NewGameSetup: ;83A9BE
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B #$00
        STA.L !year
        LDA.B #$00
        STA.L !season
        LDA.B #$01
        STA.L !weekday
        LDA.B #$01
        STA.L !day
        LDA.B #$01
        STA.W !seeds_grass_N
        STZ.W !seeds_corn_N
        STZ.W !seeds_tomato_N
        STZ.W !seeds_potato_N
        STZ.W !seeds_turnip_N
        STZ.W !feed_cow_N
        STZ.W !feed_chicks_N
        LDA.B #$00
        STA.L !cow_N
        LDA.B #$00
        STA.L !chicks_N
        STZ.W !weather_tomorrow
        LDA.B #100
        STA.W !max_stamina
        STZ.W !tool_selected
        STZ.W !watering_can_water
        LDA.B #$00
        STA.L $7F1F12
        LDA.B #$00
        STA.L $7F1F2B
        LDA.B #$00
        STA.L !dog_map
        LDA.B #$00
        STA.L $7F1F31
        LDA.B #$00
        STA.L $7F1F32
        LDA.B #$00
        STA.L !development_rate
        LDA.B #$00
        STA.L !power_berry_N
        LDA.B #$00
        STA.W $09A3
        LDA.B #$00
        STA.W $0937
        STZ.W !tool_backpack
        %Set16bit(!M)
        LDA.W #$0000
        STA.L !stored_wood
        LDA.W #$0000
        STA.L !stored_grass
        STZ.W $0196
        LDA.W #$0000
        STA.L !planted_grass
        LDA.W #$0000
        STA.L !hearts_maria
        LDA.W #$0000
        STA.L !hearts_ann
        LDA.W #$0000
        STA.L !hearts_nina
        LDA.W #$0000
        STA.L !hearts_ellen
        LDA.W #$0000
        STA.L !hearts_eve
        LDA.W #$0000
        STA.L $7F1F64
        LDA.W #$0000
        STA.L $7F1F66
        LDA.W #$0000
        STA.L $7F1F68
        LDA.W #$0000
        STA.L $7F1F6A
        LDA.W #$0000
        STA.L !dog_pos_X
        LDA.W #$0000
        STA.L !dog_pos_Y
        LDA.W #$0000
        STA.L !happiness
        LDA.W #$0000
        STA.L $7F1F45
        LDA.W #$0000
        STA.L $7F1F6C
        LDA.W #$0000
        STA.L $7F1F6E
        LDA.W #$0000
        STA.L $7F1F70
        LDA.W #$0000
        STA.L $7F1F72
        LDA.W #$0000
        STA.L !wife_pregnancy
        LDA.W #$0000
        STA.L !kid1_age
        LDA.W #$0000
        STA.L !kid2_age
        LDA.W #$0000
        STA.L !shipped_corn
        LDA.W #$0000
        STA.L !shipped_tomatoes
        LDA.W #$0000
        STA.L !shipped_turnips
        LDA.W #$0000
        STA.L !shipped_potatoes
        LDA.W #$0000
        STA.L !dog_hugs
        %Set16bit(!M)
        LDA.W #30                            ;Money is stored in x10
        STA.L !moneyL
        %Set8bit(!M)
        LDA.B #$00
        STA.L !moneyH
        %Set8bit(!M)
        LDA.B #$B1
        STA.W !player_name_sort_1
        LDA.B #$B1
        STA.W !player_name_sort_2
        LDA.B #$B1
        STA.W !player_name_sort_3
        LDA.B #$B1
        STA.W !player_name_sort_4
        %Set8bit(!M)
        LDA.B #$0F                           ;all the basic tools
        STA.L !shed_items_row_1
        LDA.B #$88                           ;watering can & grass seeds bags
        STA.L !shed_items_row_2
        LDA.B #$00
        STA.L !shed_items_row_3
        LDA.B #$00
        STA.L !shed_items_row_4
        %Set8bit(!M)                         ;I belive this part sets the child/animal name spaces blank
        LDA.B #$B1
        STA.W !dog_name_short_1
        LDA.B #$B1
        STA.W !dog_name_short_2
        LDA.B #$B1
        STA.W !dog_name_short_3
        LDA.B #$B1
        STA.W !dog_name_short_4
        %Set8bit(!M)
        LDA.B #$B1
        STA.W !horse_name_short_1
        LDA.B #$B1
        STA.W !horse_name_short_2
        LDA.B #$B1
        STA.W !horse_name_short_3
        LDA.B #$B1
        STA.W !horse_name_short_4
        %Set8bit(!M)
        LDA.B #$B1
        STA.W !horse_name_short_1
        LDA.B #$B1
        STA.W !horse_name_short_2
        LDA.B #$B1
        STA.W !horse_name_short_3
        LDA.B #$B1
        STA.W !horse_name_short_4
        %Set8bit(!M)
        LDA.B #$B1
        STA.L !kid1_name_sort_1
        LDA.B #$B1
        STA.L !kid1_name_sort_2
        LDA.B #$B1
        STA.L !kid1_name_sort_3
        LDA.B #$B1
        STA.L !kid1_name_sort_4
        %Set8bit(!M)
        LDA.B #$B1
        STA.L !kid2_name_sort_1
        LDA.B #$B1
        STA.L !kid2_name_sort_2
        LDA.B #$B1
        STA.L !kid2_name_sort_3
        LDA.B #$B1
        STA.L !kid2_name_sort_4
        %Set16bit(!M)
        LDA.W #$00B1
        STA.W !player_name_long_1
        STA.W !player_name_long_2
        STA.W !player_name_long_3
        STA.W !player_name_long_4
        STA.W !dog_name_long_1
        STA.W !dog_name_long_2
        STA.W !dog_name_long_3
        STA.W !dog_name_long_4
        STA.W !horse_name_long_1
        STA.W !horse_name_long_2
        STA.W !horse_name_long_3
        STA.W !horse_name_long_4

        JSL.L LoadDefaultFarmMap
        RTL

;;;;;;;; TODO Sets a TON of things, lots of Vars to check
FirstNightReset: ;83ABF0
        %Set16bit(!MX)
        STZ.W $0183
        STZ.W $0185
        STZ.W $0187
        %Set8bit(!M)
        STZ.W $019B
        STZ.W !inputstate
        STZ.B !ProgDMA_Channel_Flag_to_Copy
        %Set16bit(!M)
        STZ.B $04
        %Set8bit(!M)
        STZ.B $06
        %Set16bit(!M)
        STZ.B $42
        STZ.B $45
        STZ.B $48
        %Set8bit(!M)
        STZ.B $44
        STZ.B $47
        STZ.B $4A
        %Set16bit(!M)
        LDA.W #$0000
        STA.L !shipping_moneyL
        %Set8bit(!M)
        LDA.B #$00
        STA.L !shipping_moneyH
        JSL.L LoadsDateNames        ;TODO
        %Set8bit(!M)
        STZ.W $096D
        %Set16bit(!M)
        STZ.B !game_state
        STZ.B $E9
        STZ.B $EB
        STZ.W $0878
        STZ.W $087A
        STZ.W !time_running
        %Set16bit(!M)
        STZ.B $CF
        %Set8bit(!M)
        STZ.B $D1
        STZ.W $098A
        STZ.W $0972
        %Set16bit(!M)
        STZ.B !player_pos_X
        STZ.B !player_pos_Y
        STZ.W $0907
        STZ.W $0909
        %Set8bit(!M)
        STZ.W $0919
        %Set16bit(!M)
        STZ.W $0991
        %Set8bit(!M)
        STZ.W $0993
        STZ.W !name_entry_index
        STZ.W $018B
        %Set8bit(!M)
        LDA.B #$06
        STA.L !hour
        LDA.B #$00
        STA.L !minutes
        LDA.B #$00
        STA.L !seconds
        %Set16bit(!M)
        LDA.W #$0000
        STA.L $7F1F5A
        LDA.W #$0000
        STA.L $7F1F5C
        LDA.W #$0000
        STA.L $7F1F5E
        LDA.W #$0000
        STA.L $7F1F60
        LDA.W #$0000
        STA.L $7F1F62
        LDA.W #$0000
        STA.L $7F1F74
        LDA.W #$0000
        STA.L $7F1F76
        LDA.W #$0000
        STA.L $7F1F78
        LDA.W #$0000
        STA.L $7F1F7A
        %Set16bit(!M)
        %Set16bit(!MX)
        LDA.B !game_state
        ORA.W #$0001
        STA.B !game_state
        %Set16bit(!MX)
        LDA.W #$0000
        STA.B !player_action
        %Set16bit(!MX)
        LDA.W #$0000
        STA.B !player_direction
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $0911
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $0901
        %Set16bit(!M)
        STZ.W $0915
        %Set8bit(!M)
        LDA.W !max_stamina
        STA.W !current_stamina
        %Set8bit(!M)
        STZ.W !run_step_sound
        STZ.W !counter_tool_sound
        %Set8bit(!M)
        STZ.W !idle_animation_timer
        %Set8bit(!M)
        STZ.W $0990
        %Set8bit(!M)
        STZ.W !item_on_hand
        STZ.W !old_item_on_hand
        STZ.W $091F
        STZ.W $0920
        STZ.W $096B
        %Set8bit(!M)
        STZ.W $098F
        %Set8bit(!M)
        STZ.W !exaustion_level
        STZ.W !tool_used_sound
        %Set8bit(!M)
        STZ.W $0110                          ;audio
        STZ.W $0114                          ;audio
        STZ.W $0117                          ;audio
        STZ.W $0118                          ;audio
        STZ.W $0117                          ;audio
        %Set8bit(!M)
        STZ.W !fed_cows_N
        STZ.W !fed_chicks_N
        %Set16bit(!M)
        STZ.W !fed_cows_flags
        STZ.W !fed_chicks_flags
        %Set16bit(!M)
        STZ.W $084A
        STZ.B $DC
        %Set8bit(!M)
        STZ.W !transition_dest
        %Set16bit(!M)
        STZ.W !map_scrolling_X_speed
        STZ.W !map_scrolling_Y_speed
        %Set8bit(!M)
        STZ.W !map_scrolling_timer
        %Set16bit(!MX)
        LDA.W #250
        STA.L !wood_need_for_upgrade
        LDA.L $7F1F64
        AND.W #$0040                         ;house upgraded 1 once flags
        BEQ +
        LDA.W #500
        STA.L !wood_need_for_upgrade
      + %Set8bit(!M)
        STZ.B !NMI_Status
        STZ.W $0148
        JSL.L WaitForNMI
        RTL

                                                            ;      ;      ;
                CBBBB: %Set16bit(!MX)                             ;83AD91;      ;
                       TAX                                  ;83AD93;      ;
                       LDA.L $7F1F60                        ;83AD94;7F1F60;
                       AND.W #$4000                         ;83AD98;      ;
                       BEQ CODE_83ADA0                      ;83AD9B;83ADA0;
                       JMP.W CODE_83AEA2                    ;83AD9D;83AEA2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ADA0: TXA                                  ;83ADA0;      ;
                       ASL A                                ;83ADA1;      ;
                       TAX                                  ;83ADA2;      ;
                       JMP.W (CODE_83ADA6,X)                ;83ADA3;83ADA6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ADA6: LDX.W $C4AD                          ;This is weird, loads part of an instruction as data
                       LDA.W $ADDB                          ;Maybe the programmer was feeling smart? X:22 A:A5
                       SBC.B ($AD),Y                        ;83ADAC;0000AD;
                       LDA.B $DF                            ;83ADAE;0000DF;
                       CLC                                  ;83ADB0;      ;
                       ADC.W #$000C                         ;83ADB1;      ;
                       STA.B $80                            ;83ADB4;000080;
                       LDA.B $E1                            ;83ADB6;0000E1;
                       CLC                                  ;83ADB8;      ;
                       ADC.B $E7                            ;83ADB9;0000E7;
                       ADC.B $E3                            ;83ADBB;0000E3;
                       ADC.W #$000C                         ;83ADBD;      ;
                       STA.B $82                            ;83ADC0;000082;
                       BRA .skip                            ;83ADC2;83AE08;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83ADC4;0000DF;
                       CLC                                  ;83ADC6;      ;
                       ADC.W #$000C                         ;83ADC7;      ;
                       STA.B $80                            ;83ADCA;000080;
                       LDA.B $E1                            ;83ADCC;0000E1;
                       SEC                                  ;83ADCE;      ;
                       SBC.B $E7                            ;83ADCF;0000E7;
                       SBC.B $E3                            ;83ADD1;0000E3;
                       CLC                                  ;83ADD3;      ;
                       ADC.W #$000C                         ;83ADD4;      ;
                       STA.B $82                            ;83ADD7;000082;
                       BRA .skip                            ;83ADD9;83AE08;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83ADDB;0000DF;
                       CLC                                  ;83ADDD;      ;
                       ADC.B $E5                            ;83ADDE;0000E5;
                       ADC.B $E3                            ;83ADE0;0000E3;
                       ADC.W #$000C                         ;83ADE2;      ;
                       STA.B $80                            ;83ADE5;000080;
                       LDA.B $E1                            ;83ADE7;0000E1;
                       CLC                                  ;83ADE9;      ;
                       ADC.W #$000C                         ;83ADEA;      ;
                       STA.B $82                            ;83ADED;000082;
                       BRA .skip                            ;83ADEF;83AE08;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83ADF1;0000DF;
                       SEC                                  ;83ADF3;      ;
                       SBC.B $E5                            ;83ADF4;0000E5;
                       SBC.B $E3                            ;83ADF6;0000E3;
                       CLC                                  ;83ADF8;      ;
                       ADC.W #$000C                         ;83ADF9;      ;
                       STA.B $80                            ;83ADFC;000080;
                       LDA.B $E1                            ;83ADFE;0000E1;
                       CLC                                  ;83AE00;      ;
                       ADC.W #$000C                         ;83AE01;      ;
                       STA.B $82                            ;83AE04;000082;
                       BRA .skip                            ;83AE06;83AE08;
                                                            ;      ;      ;
                                                            ;      ;      ;
                .skip: %Set16bit(!MX)                             ;83AE08;      ;
                       LDA.B $CC                            ;83AE0A;0000CC;
                       PHA                                  ;83AE0C;      ;
                       %Set8bit(!M)                             ;83AE0D;      ;
                       LDA.B $CE                            ;83AE0F;0000CE;
                       PHA                                  ;83AE11;      ;
                       %Set16bit(!M)                             ;83AE12;      ;
                       LDA.W #$B586                         ;83AE14;      ;
                       STA.B $CC                            ;83AE17;0000CC;
                       %Set8bit(!M)                             ;83AE19;      ;
                       LDA.B #$7E                           ;83AE1B;      ;
                       STA.B $CE                            ;83AE1D;0000CE;
                       %Set16bit(!M)                             ;83AE1F;      ;
                       STZ.B $8C                            ;83AE21;00008C;
                       LDX.W #$0000                         ;83AE23;      ;
                                                            ;      ;      ;
          CODE_83AE26: %Set8bit(!M)                             ;83AE26;      ;
                       %Set16bit(!X)                             ;83AE28;      ;
                       LDY.W #$000C                         ;83AE2A;      ;
                       LDA.B #$00                           ;83AE2D;      ;
                       STA.B [$CC],Y                        ;83AE2F;0000CC;
                       %Set8bit(!M)                             ;83AE31;      ;
                       %Set16bit(!X)                             ;83AE33;      ;
                       LDY.W #$0000                         ;83AE35;      ;
                       LDA.B [$CC],Y                        ;83AE38;0000CC;
                       BNE CODE_83AE3F                      ;83AE3A;83AE3F;
                       JMP.W CODE_83AE81                    ;83AE3C;83AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AE3F: %Set16bit(!M)                             ;83AE3F;      ;
                       LDA.B $80                            ;83AE41;000080;
                       SEC                                  ;83AE43;      ;
                       LDY.W #$001A                         ;83AE44;      ;
                       SBC.B [$CC],Y                        ;83AE47;0000CC;
                       CMP.W #$0019                         ;83AE49;      ;
                       BCS CODE_83AE81                      ;83AE4C;83AE81;
                       LDA.B $82                            ;83AE4E;000082;
                       SEC                                  ;83AE50;      ;
                       LDY.W #$001C                         ;83AE51;      ;
                       SBC.B [$CC],Y                        ;83AE54;0000CC;
                       CMP.W #$0019                         ;83AE56;      ;
                       BCS CODE_83AE81                      ;83AE59;83AE81;
                       LDA.B $8C                            ;83AE5B;00008C;
                       BNE CODE_83AE81                      ;83AE5D;83AE81;
                       %Set8bit(!M)                             ;83AE5F;      ;
                       %Set16bit(!X)                             ;83AE61;      ;
                       LDY.W #$000C                         ;83AE63;      ;
                       LDA.B #$01                           ;83AE66;      ;
                       STA.B [$CC],Y                        ;83AE68;0000CC;
                       %Set8bit(!M)                             ;83AE6A;      ;
                       %Set16bit(!X)                             ;83AE6C;      ;
                       LDY.W #$0000                         ;83AE6E;      ;
                       LDA.B [$CC],Y                        ;83AE71;0000CC;
                       AND.B #$02                           ;83AE73;      ;
                       BEQ CODE_83AE7A                      ;83AE75;83AE7A;
                       JMP.W CODE_83AE81                    ;83AE77;83AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AE7A: %Set16bit(!M)                             ;83AE7A;      ;
                       LDA.W #$0001                         ;83AE7C;      ;
                       STA.B $8C                            ;83AE7F;00008C;
                                                            ;      ;      ;
          CODE_83AE81: %Set16bit(!M)                             ;83AE81;      ;
                       LDA.B $CC                            ;83AE83;0000CC;
                       CLC                                  ;83AE85;      ;
                       ADC.W #$0040                         ;83AE86;      ;
                       STA.B $CC                            ;83AE89;0000CC;
                       INX                                  ;83AE8B;      ;
                       CPX.W #$0031                         ;83AE8C;      ;
                       BEQ CODE_83AE94                      ;83AE8F;83AE94;
                       JMP.W CODE_83AE26                    ;83AE91;83AE26;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AE94: LDA.B $8C                            ;83AE94;00008C;
                       BNE CODE_83AEAD                      ;83AE96;83AEAD;
                       %Set8bit(!M)                             ;83AE98;      ;
                       PLA                                  ;83AE9A;      ;
                       STA.B $CE                            ;83AE9B;0000CE;
                       %Set16bit(!M)                             ;83AE9D;      ;
                       PLA                                  ;83AE9F;      ;
                       STA.B $CC                            ;83AEA0;0000CC;
                                                            ;      ;      ;
          CODE_83AEA2: %Set16bit(!MX)                             ;83AEA2;      ;
                       LDX.B $E5                            ;83AEA4;0000E5;
                       LDY.B $E7                            ;83AEA6;0000E7;
                       LDA.W #$0000                         ;83AEA8;      ;
                       BRA CODE_83AEC2                      ;83AEAB;83AEC2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AEAD: %Set8bit(!M)                             ;83AEAD;      ;
                       PLA                                  ;83AEAF;      ;
                       STA.B $CE                            ;83AEB0;0000CE;
                       %Set16bit(!M)                             ;83AEB2;      ;
                       PLA                                  ;83AEB4;      ;
                       STA.B $CC                            ;83AEB5;0000CC;
                       %Set16bit(!M)                             ;83AEB7;      ;
                       LDX.W #$0000                         ;83AEB9;      ;
                       LDY.W #$0000                         ;83AEBC;      ;
                       LDA.W #$0001                         ;83AEBF;      ;
                                                            ;      ;      ;
          CODE_83AEC2: RTL                                  ;83AEC2;      ;CCCCC
                                                            ;      ;      ;
                                                            ;      ;      ;
                CDDDD: %Set16bit(!MX)                             ;83AEC3;      ;
                       ASL A                                ;83AEC5;      ;
                       TAX                                  ;83AEC6;      ;
                       JMP.W (CODE_83AECA,X)                ;83AEC7;83AECA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AECA: CMP.B ($AE)                          ;83AECA;0000AE;
                       CMP.L UNREACH_AEECAE,X               ;83AECC;AEECAE;
                       SBC.W $A5AE,Y              ;83AED0;00A5AE;
                       CMP.L UNREACH_A58085,X               ;83AED3;A58085;
                       SBC.B ($18,X)                        ;83AED7;000018;
                       ADC.B $E7                            ;83AED9;0000E7;
                       STA.B $82                            ;83AEDB;000082;
                       BRA CODE_83AF06                      ;83AEDD;83AF06;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83AEDF;0000DF;
                       STA.B $80                            ;83AEE1;000080;
                       LDA.B $E1                            ;83AEE3;0000E1;
                       SEC                                  ;83AEE5;      ;
                       SBC.B $E7                            ;83AEE6;0000E7;
                       STA.B $82                            ;83AEE8;000082;
                       BRA CODE_83AF06                      ;83AEEA;83AF06;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AEEC: LDA.B $DF                            ;83AEEC;0000DF;
                       CLC                                  ;83AEEE;      ;
                       ADC.B $E5                            ;83AEEF;0000E5;
                       STA.B $80                            ;83AEF1;000080;
                       LDA.B $E1                            ;83AEF3;0000E1;
                       STA.B $82                            ;83AEF5;000082;
                       BRA CODE_83AF06                      ;83AEF7;83AF06;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83AEF9;0000DF;
                       SEC                                  ;83AEFB;      ;
                       SBC.B $E5                            ;83AEFC;0000E5;
                       STA.B $80                            ;83AEFE;000080;
                       LDA.B $E1                            ;83AF00;0000E1;
                       STA.B $82                            ;83AF02;000082;
                       BRA CODE_83AF06                      ;83AF04;83AF06;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AF06: LDA.B $80                            ;83AF06;000080;
                       SEC                                  ;83AF08;      ;
                       SBC.B !player_pos_X                           ;83AF09;0000D6;
                       CLC                                  ;83AF0B;      ;
                       ADC.W #$000C                         ;83AF0C;      ;
                       CMP.W #$0019                         ;83AF0F;      ;
                       BCS CODE_83AF2D                      ;83AF12;83AF2D;
                       LDA.B $82                            ;83AF14;000082;
                       SEC                                  ;83AF16;      ;
                       SBC.B !player_pos_Y                            ;83AF17;0000D8;
                       CLC                                  ;83AF19;      ;
                       ADC.W #$000C                         ;83AF1A;      ;
                       CMP.W #$0019                         ;83AF1D;      ;
                       BCS CODE_83AF2D                      ;83AF20;83AF2D;
                       LDA.W #$0001                         ;83AF22;      ;
                       LDX.W #$0000                         ;83AF25;      ;
                       LDY.W #$0000                         ;83AF28;      ;
                       BRA $09                          ;83AF2B;83AF36;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AF2D: %Set16bit(!MX)                             ;83AF2D;      ;
                       LDA.W #$0000                         ;83AF2F;      ;
                       LDX.B $E5                            ;83AF32;0000E5;
                       LDY.B $E7                            ;83AF34;0000E7;
                                                            ;      ;      ;
               RTL                                  ;83AF36;      ;END_CDDDD
                                                            ;      ;      ;
                                                            ;      ;      ;
                CEEEE: %Set16bit(!MX)                             ;83AF37;      ;
                       ASL A                                ;83AF39;      ;
                       TAX                                  ;83AF3A;      ;
                       JMP.W (CODE_83AF3E,X)                ;83AF3B;83AF3E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AF3E: LSR.B $AF                            ;83AF3E;0000AF;
                       LDX.W $16AF                          ;83AF40;0016AF;
                       BCS CODE_83AFC1                      ;83AF43;83AFC1;
                       BCS CODE_83AEEC                      ;83AF45;83AEEC;
                       CMP.L $06E938,X                      ;random 0 in $86E938
                       BRK #$AA                             ;83AF4B;      ;
                       LDA.B $E1                            ;83AF4D;0000E1;
                       CLC                                  ;83AF4F;      ;
                       ADC.B $E7                            ;83AF50;0000E7;
                       ADC.W #$0006                         ;83AF52;      ;
                       ADC.B $E3                            ;83AF55;0000E3;
                       PHA                                  ;83AF57;      ;
                       TAY                                  ;83AF58;      ;
                       LDA.W #$0000                         ;83AF59;      ;
                       JSR.W CFFFF                          ;83AF5C;83B0F6;
                       %Set16bit(!M)                             ;83AF5F;      ;
                       PLY                                  ;83AF61;      ;
                       PHA                                  ;83AF62;      ;
                       LDA.B $90                            ;83AF63;000090;
                       PHA                                  ;83AF65;      ;
                       LDA.B $DF                            ;83AF66;0000DF;
                       CLC                                  ;83AF68;      ;
                       ADC.W #$0006                         ;83AF69;      ;
                       TAX                                  ;83AF6C;      ;
                       LDA.W #$0001                         ;83AF6D;      ;
                       JSR.W CFFFF                          ;83AF70;83B0F6;
                       %Set16bit(!M)                             ;83AF73;      ;
                       STA.B $7E                            ;83AF75;00007E;
                       PLY                                  ;83AF77;      ;
                       PLA                                  ;83AF78;      ;
                       ASL A                                ;83AF79;      ;
                       ORA.B $7E                            ;83AF7A;00007E;
                       STA.B $7E                            ;83AF7C;00007E;
                       BNE CODE_83AF88                      ;83AF7E;83AF88;
                       STZ.B $7E                            ;83AF80;00007E;
                       LDY.W #$0000                         ;83AF82;      ;
                       JMP.W CODE_83B0E1                    ;83AF85;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AF88: %Set16bit(!MX)                             ;83AF88;      ;
                       CMP.W #$0003                         ;83AF8A;      ;
                       BEQ CODE_83AFA2                      ;83AF8D;83AFA2;
                       CMP.W #$0002                         ;83AF8F;      ;
                       BNE CODE_83AFA2                      ;83AF92;83AFA2;
                       STY.B $90                            ;83AF94;000090;
                       LDA.B $88                            ;83AF96;000088;
                       SEC                                  ;83AF98;      ;
                       SBC.B $8C                            ;83AF99;00008C;
                       SBC.B $90                            ;83AF9B;000090;
                       INC A                                ;83AF9D;      ;
                       TAY                                  ;83AF9E;      ;
                       JMP.W CODE_83B0E1                    ;83AF9F;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AFA2: LDA.B $88                            ;83AFA2;000088;
                       SEC                                  ;83AFA4;      ;
                       SBC.B $8C                            ;83AFA5;00008C;
                       SBC.B $90                            ;83AFA7;000090;
                       INC A                                ;83AFA9;      ;
                       TAY                                  ;83AFAA;      ;
                       JMP.W CODE_83B0E1                    ;83AFAB;83B0E1;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83AFAE;0000DF;
                       SEC                                  ;83AFB0;      ;
                       SBC.W #$0006                         ;83AFB1;      ;
                       TAX                                  ;83AFB4;      ;
                       LDA.B $E1                            ;83AFB5;0000E1;
                       SEC                                  ;83AFB7;      ;
                       SBC.B $E7                            ;83AFB8;0000E7;
                       SBC.W #$0006                         ;83AFBA;      ;
                       SBC.B $E3                            ;83AFBD;0000E3;
                       PHA                                  ;83AFBF;      ;
                       TAY                                  ;83AFC0;      ;
                                                            ;      ;      ;
          CODE_83AFC1: LDA.W #$0000                         ;83AFC1;      ;
                       JSR.W CFFFF                          ;83AFC4;83B0F6;
                       %Set16bit(!M)                             ;83AFC7;      ;
                       PLY                                  ;83AFC9;      ;
                       PHA                                  ;83AFCA;      ;
                       LDA.B $8E                            ;83AFCB;00008E;
                       PHA                                  ;83AFCD;      ;
                       LDA.B $DF                            ;83AFCE;0000DF;
                       CLC                                  ;83AFD0;      ;
                       ADC.W #$0006                         ;83AFD1;      ;
                       TAX                                  ;83AFD4;      ;
                       LDA.W #$0001                         ;83AFD5;      ;
                       JSR.W CFFFF                          ;83AFD8;83B0F6;
                       %Set16bit(!M)                             ;83AFDB;      ;
                       STA.B $7E                            ;83AFDD;00007E;
                       PLY                                  ;83AFDF;      ;
                       PLA                                  ;83AFE0;      ;
                       ASL A                                ;83AFE1;      ;
                       ORA.B $7E                            ;83AFE2;00007E;
                       STA.B $7E                            ;83AFE4;00007E;
                       BNE CODE_83AFF0                      ;83AFE6;83AFF0;
                       STZ.B $7E                            ;83AFE8;00007E;
                       LDY.W #$0000                         ;83AFEA;      ;
                       JMP.W CODE_83B0E1                    ;83AFED;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83AFF0: %Set16bit(!MX)                             ;83AFF0;      ;
                       CMP.W #$0003                         ;83AFF2;      ;
                       BEQ CODE_83B00A                      ;83AFF5;83B00A;
                       CMP.W #$0002                         ;83AFF7;      ;
                       BNE CODE_83B00A                      ;83AFFA;83B00A;
                       STY.B $8E                            ;83AFFC;00008E;
                       LDA.B $8C                            ;83AFFE;00008C;
                       CLC                                  ;83B000;      ;
                       ADC.B $8E                            ;83B001;00008E;
                       SEC                                  ;83B003;      ;
                       SBC.B $88                            ;83B004;000088;
                       TAY                                  ;83B006;      ;
                       JMP.W CODE_83B0E1                    ;83B007;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B00A: LDA.B $8C                            ;83B00A;00008C;
                       CLC                                  ;83B00C;      ;
                       ADC.B $8E                            ;83B00D;00008E;
                       SEC                                  ;83B00F;      ;
                       SBC.B $88                            ;83B010;000088;
                       TAY                                  ;83B012;      ;
                       JMP.W CODE_83B0E1                    ;83B013;83B0E1;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83B016;0000DF;
                       CLC                                  ;83B018;      ;
                       ADC.B $E5                            ;83B019;0000E5;
                       ADC.W #$0006                         ;83B01B;      ;
                       ADC.B $E3                            ;83B01E;0000E3;
                       PHA                                  ;83B020;      ;
                       TAX                                  ;83B021;      ;
                       LDA.B $E1                            ;83B022;0000E1;
                       SEC                                  ;83B024;      ;
                       SBC.W #$0006                         ;83B025;      ;
                       TAY                                  ;83B028;      ;
                       LDA.W #$0000                         ;83B029;      ;
                       JSR.W CFFFF                          ;83B02C;83B0F6;
                       %Set16bit(!M)                             ;83B02F;      ;
                       PLX                                  ;83B031;      ;
                       PHA                                  ;83B032;      ;
                       LDA.B $90                            ;83B033;000090;
                       PHA                                  ;83B035;      ;
                       LDA.B $E1                            ;83B036;0000E1;
                       CLC                                  ;83B038;      ;
                       ADC.W #$0006                         ;83B039;      ;
                       TAY                                  ;83B03C;      ;
                       LDA.W #$0001                         ;83B03D;      ;
                       JSR.W CFFFF                          ;83B040;83B0F6;
                       %Set16bit(!M)                             ;83B043;      ;
                       STA.B $7E                            ;83B045;00007E;
                       PLX                                  ;83B047;      ;
                       PLA                                  ;83B048;      ;
                       ASL A                                ;83B049;      ;
                       ORA.B $7E                            ;83B04A;00007E;
                       STA.B $7E                            ;83B04C;00007E;
                       BNE CODE_83B058                      ;83B04E;83B058;
                       STZ.B $7E                            ;83B050;00007E;
                       LDX.W #$0000                         ;83B052;      ;
                       JMP.W CODE_83B0E1                    ;83B055;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B058: %Set16bit(!MX)                             ;83B058;      ;
                       CMP.W #$0003                         ;83B05A;      ;
                       BEQ CODE_83B071                      ;83B05D;83B071;
                       CMP.W #$0002                         ;83B05F;      ;
                       BNE CODE_83B071                      ;83B062;83B071;
                       STX.B $90                            ;83B064;000090;
                       LDA.B $86                            ;83B066;000086;
                       SEC                                  ;83B068;      ;
                       SBC.B $8A                            ;83B069;00008A;
                       SBC.B $90                            ;83B06B;000090;
                       INC A                                ;83B06D;      ;
                       TAX                                  ;83B06E;      ;
                       BRA CODE_83B0E1                      ;83B06F;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B071: LDA.B $86                            ;83B071;000086;
                       SEC                                  ;83B073;      ;
                       SBC.B $8A                            ;83B074;00008A;
                       SBC.B $90                            ;83B076;000090;
                       INC A                                ;83B078;      ;
                       TAX                                  ;83B079;      ;
                       BRA CODE_83B0E1                      ;83B07A;83B0E1;
                                                            ;      ;      ;
                       LDA.B $DF                            ;83B07C;0000DF;
                       SEC                                  ;83B07E;      ;
                       SBC.B $E5                            ;83B07F;0000E5;
                       SBC.W #$0006                         ;83B081;      ;
                       SBC.B $E3                            ;83B084;0000E3;
                       PHA                                  ;83B086;      ;
                       TAX                                  ;83B087;      ;
                       LDA.B $E1                            ;83B088;0000E1;
                       SEC                                  ;83B08A;      ;
                       SBC.W #$0006                         ;83B08B;      ;
                       TAY                                  ;83B08E;      ;
                       LDA.W #$0000                         ;83B08F;      ;
                       JSR.W CFFFF                          ;83B092;83B0F6;
                       %Set16bit(!M)                             ;83B095;      ;
                       PLX                                  ;83B097;      ;
                       PHA                                  ;83B098;      ;
                       LDA.B $8E                            ;83B099;00008E;
                       PHA                                  ;83B09B;      ;
                       LDA.B $E1                            ;83B09C;0000E1;
                       CLC                                  ;83B09E;      ;
                       ADC.W #$0006                         ;83B09F;      ;
                       TAY                                  ;83B0A2;      ;
                       LDA.W #$0001                         ;83B0A3;      ;
                       JSR.W CFFFF                          ;83B0A6;83B0F6;
                       %Set16bit(!M)                             ;83B0A9;      ;
                       STA.B $7E                            ;83B0AB;00007E;
                       PLX                                  ;83B0AD;      ;
                       PLA                                  ;83B0AE;      ;
                       ASL A                                ;83B0AF;      ;
                       ORA.B $7E                            ;83B0B0;00007E;
                       STA.B $7E                            ;83B0B2;00007E;
                       BNE CODE_83B0BD                      ;83B0B4;83B0BD;
                       STZ.B $7E                            ;83B0B6;00007E;
                       LDX.W #$0000                         ;83B0B8;      ;
                       BRA CODE_83B0E1                      ;83B0BB;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B0BD: %Set16bit(!MX)                             ;83B0BD;      ;
                       CMP.W #$0003                         ;83B0BF;      ;
                       BEQ CODE_83B0D6                      ;83B0C2;83B0D6;
                       CMP.W #$0002                         ;83B0C4;      ;
                       BNE CODE_83B0D6                      ;83B0C7;83B0D6;
                       STX.B $8E                            ;83B0C9;00008E;
                       LDA.B $8A                            ;83B0CB;00008A;
                       CLC                                  ;83B0CD;      ;
                       ADC.B $8E                            ;83B0CE;00008E;
                       SEC                                  ;83B0D0;      ;
                       SBC.B $86                            ;83B0D1;000086;
                       TAX                                  ;83B0D3;      ;
                       BRA CODE_83B0E1                      ;83B0D4;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B0D6: LDA.B $8A                            ;83B0D6;00008A;
                       CLC                                  ;83B0D8;      ;
                       ADC.B $8E                            ;83B0D9;00008E;
                       SEC                                  ;83B0DB;      ;
                       SBC.B $86                            ;83B0DC;000086;
                       TAX                                  ;83B0DE;      ;
                       BRA CODE_83B0E1                      ;83B0DF;83B0E1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B0E1: %Set16bit(!M)                             ;83B0E1;      ;
                       LDA.B $7E                            ;83B0E3;00007E;
                       RTL                                  ;83B0E5;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83B0E6;      ;
                       LDA.W #$0000                         ;83B0E8;      ;
                       STA.B $EB                            ;83B0EB;0000EB;
                       STA.B $E9                            ;83B0ED;0000E9;
                       LDX.W #$0000                         ;83B0EF;      ;
                       LDA.W #$0000                         ;83B0F2;      ;
                       RTL                                  ;83B0F5;      ;END_CEEEE
                                                            ;      ;      ;
                                                            ;      ;      ;
                CFFFF: %Set16bit(!MX)                             ;83B0F6;      ;
                       PHA                                  ;83B0F8;      ;
                       STX.B $86                            ;83B0F9;000086;
                       STY.B $88                            ;83B0FB;000088;
                       TXA                                  ;83B0FD;      ;
                       AND.W #$FFF0                         ;83B0FE;      ;
                       STA.B $8A                            ;83B101;00008A;
                       TYA                                  ;83B103;      ;
                       AND.W #$FFF0                         ;83B104;      ;
                       STA.B $8C                            ;83B107;00008C;
                       LDA.W #$0010                         ;83B109;      ;
                       STA.B $8E                            ;83B10C;00008E;
                       LDA.W #$0000                         ;83B10E;      ;
                       STA.B $90                            ;83B111;000090;
                       LDA.W #$0002                         ;83B113;      ;
                       JSL.L UNK_CheckTileProperty                          ;83B116;82AC61;
                       %Set8bit(!M)                             ;83B11A;      ;
                       %Set16bit(!X)                             ;83B11C;      ;
                       STA.B $92                            ;83B11E;000092;
                       %Set16bit(!M)                             ;83B120;      ;
                       PLA                                  ;83B122;      ;
                       CMP.W #$0001                         ;83B123;      ;
                       BEQ CODE_83B12C                      ;83B126;83B12C;
                       STX.B $E9                            ;83B128;0000E9;
                       BRA CODE_83B12E                      ;83B12A;83B12E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B12C: STX.B $EB                            ;83B12C;0000EB;
                                                            ;      ;      ;
          CODE_83B12E: %Set8bit(!M)                             ;83B12E;      ;
                       LDA.B $92                            ;83B130;000092;
                       AND.B #$01                           ;83B132;      ;
                       BEQ CODE_83B139                      ;83B134;83B139;
                       JMP.W CODE_83B1BA                    ;83B136;83B1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B139: LDA.B $92                            ;83B139;000092;
                       AND.B #$02                           ;83B13B;      ;
                       BNE CODE_83B16A                      ;83B13D;83B16A;
                       LDA.B $92                            ;83B13F;000092;
                       AND.B #$04                           ;83B141;      ;
                       BNE CODE_83B17E                      ;83B143;83B17E;
                       LDA.B $92                            ;83B145;000092;
                       AND.B #$08                           ;83B147;      ;
                       BNE CODE_83B192                      ;83B149;83B192;
                       LDA.B $92                            ;83B14B;000092;
                       AND.B #$10                           ;83B14D;      ;
                       BNE CODE_83B1A6                      ;83B14F;83B1A6;
                       %Set16bit(!MX)                             ;83B151;      ;
                       LDA.B !game_state                            ;83B153;0000D2;
                       AND.W #$0010                         ;83B155;      ;
                       BNE CODE_83B15D                      ;83B158;83B15D;
                       JMP.W CODE_83B1C1                    ;83B15A;83B1C1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B15D: CPX.W #$00C0                         ;83B15D;      ;
                       BCC CODE_83B1C1                      ;83B160;83B1C1;
                       CPX.W #$00D0                         ;83B162;      ;
                       BCS CODE_83B1C1                      ;83B165;83B1C1;
                       JMP.W CODE_83B1BA                    ;83B167;83B1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B16A: %Set16bit(!MX)                             ;83B16A;      ;
                       LDA.B $E7                            ;83B16C;0000E7;
                       BNE CODE_83B175                      ;83B16E;83B175;
                       LDA.W #$0008                         ;83B170;      ;
                       STA.B $8E                            ;83B173;00008E;
                                                            ;      ;      ;
          CODE_83B175: LDA.B $86                            ;83B175;000086;
                       AND.W #$0008                         ;83B177;      ;
                       BNE CODE_83B1C1                      ;83B17A;83B1C1;
                       BRA CODE_83B1BA                      ;83B17C;83B1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B17E: %Set16bit(!MX)                             ;83B17E;      ;
                       LDA.B $E7                            ;83B180;0000E7;
                       BNE CODE_83B189                      ;83B182;83B189;
                       LDA.W #$0008                         ;83B184;      ;
                       STA.B $90                            ;83B187;000090;
                                                            ;      ;      ;
          CODE_83B189: LDA.B $86                            ;83B189;000086;
                       AND.W #$0008                         ;83B18B;      ;
                       BEQ CODE_83B1C1                      ;83B18E;83B1C1;
                       BRA CODE_83B1BA                      ;83B190;83B1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B192: %Set16bit(!MX)                             ;83B192;      ;
                       LDA.B $E5                            ;83B194;0000E5;
                       BNE CODE_83B19D                      ;83B196;83B19D;
                       LDA.W #$0008                         ;83B198;      ;
                       STA.B $8E                            ;83B19B;00008E;
                                                            ;      ;      ;
          CODE_83B19D: LDA.B $88                            ;83B19D;000088;
                       AND.W #$0008                         ;83B19F;      ;
                       BNE CODE_83B1C1                      ;83B1A2;83B1C1;
                       BRA CODE_83B1BA                      ;83B1A4;83B1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B1A6: %Set16bit(!MX)                             ;83B1A6;      ;
                       LDA.B $E5                            ;83B1A8;0000E5;
                       BNE CODE_83B1B1                      ;83B1AA;83B1B1;
                       LDA.W #$0008                         ;83B1AC;      ;
                       STA.B $90                            ;83B1AF;000090;
                                                            ;      ;      ;
          CODE_83B1B1: LDA.B $88                            ;83B1B1;000088;
                       AND.W #$0008                         ;83B1B3;      ;
                       BEQ CODE_83B1C1                      ;83B1B6;83B1C1;
                       BRA CODE_83B1BA                      ;83B1B8;83B1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B1BA: %Set16bit(!MX)                             ;83B1BA;      ;
                       LDA.W #$0001                         ;83B1BC;      ;
                       BRA CODE_83B1C8                      ;83B1BF;83B1C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B1C1: %Set16bit(!MX)                             ;83B1C1;      ;
                       LDA.W #$0000                         ;83B1C3;      ;
                       BRA CODE_83B1C8                      ;83B1C6;83B1C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83B1C8: RTS                                  ;83B1C8;      ;END_CFFFF

;;;;;;;; Money is actually stored divided by 10 basically
;;;;;;;; Param $72: Ammount low 16b, $74 Ammount low 8b
;;;;;;;; Returns A = 0: ok, 1: fails(result negative)
AddMoney: ;83B1C9
        !changeL = $72
        !changeH = $74
        !tempL = $75
        !tempH = $77

        %Set16bit(!MX)
        LDA.L !moneyL
        CLC
        ADC.B !changeL
        STA.B !tempL
        %Set8bit(!M)
        LDA.L !moneyH
        ADC.B !changeH
        STA.B !tempH
        BMI .negative
        %Set16bit(!M)
        LDA.B !tempL
        CMP.W #$423F
        %Set8bit(!M)
        LDA.B !tempH
        SBC.B #$0F                           ;0F423F = 999999
        BCS .max
        %Set16bit(!M)
        LDA.B !tempL
        STA.L !moneyL
        %Set8bit(!M)
        LDA.B !tempH
        STA.L !moneyH
        %Set16bit(!M)
        LDA.W #$0000
        BRA .return

    .negative:
        %Set16bit(!M)
        LDA.W #$0001
        BRA .return

    .max:
        %Set16bit(!M)
        LDA.W #$423F
        STA.L !moneyL
        %Set8bit(!M)
        LDA.B #$0F                           ;0F423F = 999999
        STA.L !moneyH
        %Set16bit(!M)
        LDA.W #$0000

    .return: RTL

;;;;;;;; Param $7E: Ammount
;;;;;;;; Returns A = 0: ok, 1: fails(result negative)
AddWood: ;83B224
        !change = $7E

        %Set16bit(!MX)
        STA.B !change
        LDA.L !stored_wood
        CLC
        ADC.B !change
        BMI .negative
        CMP.W #999
        BCS .max
        STA.L !stored_wood
        LDA.W #$0000
        BRA .return

    .negative:
        %Set16bit(!M)
        LDA.W #$0001
        BRA .return

    .max:
        %Set16bit(!M)
        LDA.W #999
        STA.L !stored_wood
        LDA.W #$0000

    .return: RTL

;;;;;;;; Param $7E: Ammount
;;;;;;;; Returns A = 0: ok, 1: fails(result negative)
AddGrass: ;83B253
        !change = $7E

        %Set16bit(!MX)
        STA.B !change
        LDA.L !stored_grass
        CLC
        ADC.B !change
        BMI .negative
        CMP.W #999
        BCS .max
        STA.L !stored_grass
        LDA.W #$0000
        BRA .return

    .negative:
        %Set16bit(!M)
        LDA.W #$0001
        BRA .return

    .max:
        %Set16bit(!M)
        LDA.W #999
        STA.L !stored_grass
        LDA.W #$0000

        .return: RTL

;;;;;;;; Params: $7E:amount to add (can be negative)
;;;;;;;; Returns: A = 0 Worked, 1 Fails (would en with negative happiness)
AddPlayerHappiness: ;83B282
        !change = $7E

        %Set16bit(!MX)
        STA.B !change
        LDA.L !happiness
        CLC
        ADC.B !change
        BMI .IfNegative
        CMP.W #999
        BCS .aboveMax
        STA.L !happiness
        LDA.W #$0000
        BRA .return

    .IfNegative:
        %Set16bit(!M)
        LDA.W #$0001
        BRA .return

    .aboveMax:
        %Set16bit(!M)
        LDA.W #999
        STA.L !happiness
        LDA.W #$0000

    .return:
        RTL

;;;;;;;; Load game Mem slot in A
;;;;;;;; Param: A: Save Slot
LoadGameSlot: ;83B2B1
        !savelocation = $72
        !savelocationBank = $74

        %Set16bit(!MX)                       ;sets location depeding on Slot
        PHA
        LDA.W #$0000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank
        %Set16bit(!M)
        PLA
        CMP.W #$0000
        BEQ .start
        LDA.W #$1000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank

    .start:
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B [!savelocation],Y
        STA.L !year
        LDY.W #$0001
        LDA.B [!savelocation],Y
        STA.L !season
        LDY.W #$0002
        LDA.B [!savelocation],Y
        STA.L !weekday
        LDY.W #$0003
        LDA.B [!savelocation],Y
        STA.L !day
        LDY.W #$0004
        LDA.B [!savelocation],Y
        STA.W !seeds_grass_N
        LDY.W #$0005
        LDA.B [!savelocation],Y
        STA.W !seeds_corn_N
        LDY.W #$0006
        LDA.B [!savelocation],Y
        STA.W !seeds_tomato_N
        LDY.W #$0007
        LDA.B [!savelocation],Y
        STA.W !seeds_potato_N
        LDY.W #$0008
        LDA.B [!savelocation],Y
        STA.W !seeds_turnip_N
        LDY.W #$0009
        LDA.B [!savelocation],Y
        STA.W !feed_cow_N
        LDY.W #$000A
        LDA.B [!savelocation],Y
        STA.W !feed_chicks_N
        LDY.W #$000B
        LDA.B [!savelocation],Y
        STA.L !cow_N
        LDY.W #$000C
        LDA.B [!savelocation],Y
        STA.L !chicks_N
        LDY.W #$000D
        LDA.B [!savelocation],Y
        STA.W !weather_tomorrow
        LDY.W #$000E
        LDA.B [!savelocation],Y
        STA.W !max_stamina
        LDY.W #$000F
        LDA.B [!savelocation],Y
        STA.W !tool_selected
        LDY.W #$0010
        LDA.B [!savelocation],Y
        STA.W !watering_can_water
        LDY.W #$0011
        LDA.B [!savelocation],Y
        STA.L $7F1F12
        LDY.W #$0012
        LDA.B [!savelocation],Y
        STA.L $7F1F2B
        LDY.W #$0013
        LDA.B [!savelocation],Y
        STA.L !dog_map
        LDY.W #$0014
        LDA.B [!savelocation],Y
        STA.L $7F1F31
        LDY.W #$0015
        LDA.B [!savelocation],Y
        STA.L $7F1F32
        LDY.W #$0016
        LDA.B [!savelocation],Y
        STA.L !development_rate
        LDY.W #$0017
        LDA.B [!savelocation],Y
        STA.L !power_berry_N
        LDY.W #$0018
        LDA.B [!savelocation],Y
        STA.W $09A3
        LDY.W #$0019
        LDA.B [!savelocation],Y
        STA.W $0937
        LDY.W #$001A
        LDA.B [!savelocation],Y
        STA.W !tool_backpack
        %Set16bit(!M)
        LDY.W #$0040
        LDA.B [!savelocation],Y
        STA.L !stored_wood
        LDY.W #$0042
        LDA.B [!savelocation],Y
        STA.L !stored_grass
        LDY.W #$0044
        LDA.B [!savelocation],Y
        STA.W $0196
        LDY.W #$0046
        LDA.B [!savelocation],Y
        STA.L !planted_grass
        LDY.W #$0048
        LDA.B [!savelocation],Y
        STA.L !hearts_maria
        LDY.W #$004A
        LDA.B [!savelocation],Y
        STA.L !hearts_ann
        LDY.W #$004C
        LDA.B [!savelocation],Y
        STA.L !hearts_nina
        LDY.W #$004E
        LDA.B [!savelocation],Y
        STA.L !hearts_ellen
        LDY.W #$0050
        LDA.B [!savelocation],Y
        STA.L !hearts_eve
        LDY.W #$0060
        LDA.B [!savelocation],Y
        STA.L $7F1F64
        LDY.W #$0062
        LDA.B [!savelocation],Y
        STA.L $7F1F66
        LDY.W #$0064
        LDA.B [!savelocation],Y
        STA.L $7F1F68
        LDY.W #$0066
        LDA.B [!savelocation],Y
        STA.L $7F1F6A
        LDY.W #$0068
        LDA.B [!savelocation],Y
        STA.L !dog_pos_X
        LDY.W #$006A
        LDA.B [!savelocation],Y
        STA.L !dog_pos_Y
        LDY.W #$006C
        LDA.B [!savelocation],Y
        STA.L !happiness
        LDY.W #$006E
        LDA.B [!savelocation],Y
        STA.L $7F1F45
        LDY.W #$0070
        LDA.B [!savelocation],Y
        STA.L $7F1F6C
        LDY.W #$0072
        LDA.B [!savelocation],Y
        STA.L $7F1F6E
        LDY.W #$0074
        LDA.B [!savelocation],Y
        STA.L $7F1F70
        LDY.W #$0076
        LDA.B [!savelocation],Y
        STA.L $7F1F72
        LDY.W #$0078
        LDA.B [!savelocation],Y
        STA.L !wife_pregnancy
        LDY.W #$007A
        LDA.B [!savelocation],Y
        STA.L !kid1_age
        LDY.W #$007C
        LDA.B [!savelocation],Y
        STA.L !kid2_age
        LDY.W #$0031
        LDA.B [!savelocation],Y
        STA.L !shipped_corn
        LDY.W #$0033
        LDA.B [!savelocation],Y
        STA.L !shipped_tomatoes
        LDY.W #$0035
        LDA.B [!savelocation],Y
        STA.L !shipped_turnips
        LDY.W #$0037
        LDA.B [!savelocation],Y
        STA.L !shipped_potatoes
        LDY.W #$007E
        LDA.B [!savelocation],Y
        STA.L !dog_hugs
        %Set16bit(!M)
        LDY.W #$0039
        LDA.B [!savelocation],Y
        STA.L !moneyL
        %Set8bit(!M)
        LDY.W #$003B
        LDA.B [!savelocation],Y
        STA.L !moneyH
        %Set8bit(!M)

        LDA.B #$00                           ;Player Name
        XBA
        LDY.W #$0080
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_1
        %Set16bit(!M)
        STA.W !player_name_long_1
        %Set8bit(!M)
        LDY.W #$0081
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_2
        %Set16bit(!M)
        STA.W !player_name_long_2
        %Set8bit(!M)
        LDY.W #$0082
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_3
        %Set16bit(!M)
        STA.W !player_name_long_3
        %Set8bit(!M)
        LDY.W #$0083
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_4
        %Set16bit(!M)
        STA.W !player_name_long_4

        %Set8bit(!M)
        LDY.W #$0084
        LDA.B [!savelocation],Y
        STA.L !shed_items_row_1
        LDY.W #$0085
        LDA.B [!savelocation],Y
        STA.L !shed_items_row_2
        LDY.W #$0086
        LDA.B [!savelocation],Y
        STA.L !shed_items_row_3
        LDY.W #$0087
        LDA.B [!savelocation],Y
        STA.L !shed_items_row_4

        %Set8bit(!M)                         ;name of Dog
        LDA.B #$00
        XBA
        LDY.W #$0088
        LDA.B [!savelocation],Y
        STA.W !dog_name_short_1
        %Set16bit(!M)
        STA.W !dog_name_long_1
        %Set8bit(!M)
        LDY.W #$0089
        LDA.B [!savelocation],Y
        STA.W !dog_name_short_2
        %Set16bit(!M)
        STA.W !dog_name_long_2
        %Set8bit(!M)
        LDY.W #$008A
        LDA.B [!savelocation],Y
        STA.W !dog_name_short_3
        %Set16bit(!M)
        STA.W !dog_name_long_3
        %Set8bit(!M)
        LDY.W #$008B
        LDA.B [!savelocation],Y
        STA.W !dog_name_short_4
        %Set16bit(!M)
        STA.W !dog_name_long_4

        %Set8bit(!M)                         ;name of Horse
        LDA.B #$00
        XBA
        LDY.W #$008C
        LDA.B [!savelocation],Y
        STA.W !horse_name_short_1
        %Set16bit(!M)
        STA.W !horse_name_long_1
        %Set8bit(!M)
        LDY.W #$008D
        LDA.B [!savelocation],Y
        STA.W !horse_name_short_2
        %Set16bit(!M)
        STA.W !horse_name_long_2
        %Set8bit(!M)
        LDY.W #$008E
        LDA.B [!savelocation],Y
        STA.W !horse_name_short_3
        %Set16bit(!M)
        STA.W !horse_name_long_3
        %Set8bit(!M)
        LDY.W #$008F
        LDA.B [!savelocation],Y
        STA.W !horse_name_short_4
        %Set16bit(!M)
        STA.W !horse_name_long_4

        %Set8bit(!M)                         ;name of Kid 1
        LDA.B #$00
        XBA
        LDY.W #$0090
        LDA.B [!savelocation],Y
        STA.L !kid1_name_sort_1
        %Set16bit(!M)
        STA.W !kid1_name_long_1
        %Set8bit(!M)
        LDY.W #$0091
        LDA.B [!savelocation],Y
        STA.L !kid1_name_sort_2
        %Set16bit(!M)
        STA.W !kid1_name_long_2
        %Set8bit(!M)
        LDY.W #$0092
        LDA.B [!savelocation],Y
        STA.L !kid1_name_sort_3
        %Set16bit(!M)
        STA.W !kid1_name_long_3
        %Set8bit(!M)
        LDY.W #$0093
        LDA.B [!savelocation],Y
        STA.L !kid1_name_sort_4
        %Set16bit(!M)
        STA.W !kid1_name_long_4

        %Set8bit(!M)                         ;name of Kid 2?
        LDA.B #$00
        XBA
        LDY.W #$0094
        LDA.B [!savelocation],Y
        STA.L !kid2_name_sort_1
        %Set16bit(!M)
        STA.W !kid2_name_long_1
        %Set8bit(!M)
        LDY.W #$0095
        LDA.B [!savelocation],Y
        STA.L !kid2_name_sort_2
        %Set16bit(!M)
        STA.W !kid2_name_long_2
        %Set8bit(!M)
        LDY.W #$0096
        LDA.B [!savelocation],Y
        STA.L !kid2_name_sort_3
        %Set16bit(!M)
        STA.W !kid2_name_long_3
        %Set8bit(!M)
        LDY.W #$0097
        LDA.B [!savelocation],Y
        STA.L !kid2_name_sort_4
        %Set16bit(!M)
        STA.W !kid2_name_long_4

        %Set8bit(!M)
        LDY.W #$0098
        LDX.W #$0000
    .chickens:
        LDA.B [!savelocation],Y
        STA.L !chicken_array,X
        INY
        INX
        CPX.W #$0068
        BNE .chickens
        %Set8bit(!M)

        LDY.W #$0100
        LDX.W #$0000
    .cows:
        LDA.B [!savelocation],Y
        STA.L !cow_array,X
        INY
        INX
        CPX.W #$00C0
        BNE .cows

        %Set16bit(!M)                        ;save slot selected
        LDA.B !savelocation
        STA.B $75
        %Set8bit(!M)
        LDA.B !savelocationBank
        STA.B $77

        JSL.L LoadDefaultFarmMap

        %Set8bit(!M)                         ;copy farm data
        LDY.W #$01C0
        LDX.W #$00C0
    .farmData:
        LDA.B [$75],Y
        STA.L !farm_map_array,X
        INY
        INX
        CPX.W #$0F00
        BNE .farmData
        RTL

;;;;;;;; Save game Mem slot in A
;;;;;;;; Param: A: Save Slot
SaveGameSlot: ;83B68E
        !savelocation = $72
        !savelocationBank = $74
        !crcsum = $7E

        %Set16bit(!MX)
        PHA
        LDA.W #$0000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank
        %Set16bit(!M)
        PLA
        PHA
        CMP.W #$0000
        BEQ .start
        LDA.W #$1000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank

    .start:
        %Set8bit(!M)
        LDY.W #$0000
        LDA.L !year
        STA.B [!savelocation],Y
        LDY.W #$0001
        LDA.L !season
        STA.B [!savelocation],Y
        LDY.W #$0002
        LDA.L !weekday
        STA.B [!savelocation],Y
        LDY.W #$0003
        LDA.L !day
        STA.B [!savelocation],Y
        LDY.W #$0004
        LDA.W !seeds_grass_N
        STA.B [!savelocation],Y
        LDY.W #$0005
        LDA.W !seeds_corn_N
        STA.B [!savelocation],Y
        LDY.W #$0006
        LDA.W !seeds_tomato_N
        STA.B [!savelocation],Y
        LDY.W #$0007
        LDA.W !seeds_potato_N
        STA.B [!savelocation],Y
        LDY.W #$0008
        LDA.W !seeds_turnip_N
        STA.B [!savelocation],Y
        LDY.W #$0009
        LDA.W !feed_cow_N
        STA.B [!savelocation],Y
        LDY.W #$000A
        LDA.W !feed_chicks_N
        STA.B [!savelocation],Y
        LDY.W #$000B
        LDA.L !cow_N
        STA.B [!savelocation],Y
        LDY.W #$000C
        LDA.L !chicks_N
        STA.B [!savelocation],Y
        LDY.W #$000D
        LDA.W !weather_tomorrow
        STA.B [!savelocation],Y
        LDY.W #$000E
        LDA.W !max_stamina
        STA.B [!savelocation],Y
        LDY.W #$000F
        LDA.W !tool_selected
        STA.B [!savelocation],Y
        LDY.W #$0010
        LDA.W !watering_can_water
        STA.B [!savelocation],Y
        LDY.W #$0011
        LDA.L $7F1F12
        STA.B [!savelocation],Y
        LDY.W #$0012
        LDA.L $7F1F2B
        STA.B [!savelocation],Y
        LDY.W #$0013
        LDA.L !dog_map
        STA.B [!savelocation],Y
        LDY.W #$0014
        LDA.L $7F1F31
        STA.B [!savelocation],Y
        LDY.W #$0015
        LDA.L $7F1F32
        STA.B [!savelocation],Y
        LDY.W #$0016
        LDA.L !development_rate
        STA.B [!savelocation],Y
        LDY.W #$0017
        LDA.L !power_berry_N
        STA.B [!savelocation],Y
        LDY.W #$0018
        LDA.W $09A3
        STA.B [!savelocation],Y
        LDY.W #$0019
        LDA.W $0937
        STA.B [!savelocation],Y
        LDY.W #$001A
        LDA.W !tool_backpack
        STA.B [!savelocation],Y
        %Set16bit(!M)
        LDY.W #$0040
        LDA.L !stored_wood
        STA.B [!savelocation],Y
        LDY.W #$0042
        LDA.L !stored_grass
        STA.B [!savelocation],Y
        LDY.W #$0044
        LDA.W $0196
        STA.B [!savelocation],Y
        LDY.W #$0046
        LDA.L !planted_grass
        STA.B [!savelocation],Y
        LDY.W #$0048
        LDA.L !hearts_maria
        STA.B [!savelocation],Y
        LDY.W #$004A
        LDA.L !hearts_ann
        STA.B [!savelocation],Y
        LDY.W #$004C
        LDA.L !hearts_nina
        STA.B [!savelocation],Y
        LDY.W #$004E
        LDA.L !hearts_ellen
        STA.B [!savelocation],Y
        LDY.W #$0050
        LDA.L !hearts_eve
        STA.B [!savelocation],Y
        LDY.W #$0060
        LDA.L $7F1F64
        STA.B [!savelocation],Y
        LDY.W #$0062
        LDA.L $7F1F66
        STA.B [!savelocation],Y
        LDY.W #$0064
        LDA.L $7F1F68
        STA.B [!savelocation],Y
        LDY.W #$0066
        LDA.L $7F1F6A
        STA.B [!savelocation],Y
        LDY.W #$0068
        LDA.L !dog_pos_X
        STA.B [!savelocation],Y
        LDY.W #$006A
        LDA.L !dog_pos_Y
        STA.B [!savelocation],Y
        LDY.W #$006C
        LDA.L !happiness
        STA.B [!savelocation],Y
        LDY.W #$006E
        LDA.L $7F1F45
        STA.B [!savelocation],Y
        LDY.W #$0070
        LDA.L $7F1F6C
        STA.B [!savelocation],Y
        LDY.W #$0072
        LDA.L $7F1F6E
        STA.B [!savelocation],Y
        LDY.W #$0074
        LDA.L $7F1F70
        STA.B [!savelocation],Y
        LDY.W #$0076
        LDA.L $7F1F72
        STA.B [!savelocation],Y
        LDY.W #$0078
        LDA.L !wife_pregnancy
        STA.B [!savelocation],Y
        LDY.W #$007A
        LDA.L !kid1_age
        STA.B [!savelocation],Y
        LDY.W #$007C
        LDA.L !kid2_age
        STA.B [!savelocation],Y
        LDY.W #$0031
        LDA.L !shipped_corn
        STA.B [!savelocation],Y
        LDY.W #$0033
        LDA.L !shipped_tomatoes
        STA.B [!savelocation],Y
        LDY.W #$0035
        LDA.L !shipped_turnips
        STA.B [!savelocation],Y
        LDY.W #$0037
        LDA.L !shipped_potatoes
        STA.B [!savelocation],Y
        LDY.W #$007E
        LDA.L !dog_hugs
        STA.B [!savelocation],Y
        %Set16bit(!M)
        LDY.W #$0039
        LDA.L !moneyL
        STA.B [!savelocation],Y
        %Set8bit(!M)
        LDY.W #$003B
        LDA.L !moneyH
        STA.B [!savelocation],Y

        %Set8bit(!M)
        LDY.W #$0080
        LDA.W !player_name_sort_1
        STA.B [!savelocation],Y
        LDY.W #$0081
        LDA.W !player_name_sort_2
        STA.B [!savelocation],Y
        LDY.W #$0082
        LDA.W !player_name_sort_3
        STA.B [!savelocation],Y
        LDY.W #$0083
        LDA.W !player_name_sort_4
        STA.B [!savelocation],Y

        %Set8bit(!M)
        LDY.W #$0084
        LDA.L !shed_items_row_1
        STA.B [!savelocation],Y
        LDY.W #$0085
        LDA.L !shed_items_row_2
        STA.B [!savelocation],Y
        LDY.W #$0086
        LDA.L !shed_items_row_3
        STA.B [!savelocation],Y
        LDY.W #$0087
        LDA.L !shed_items_row_4
        STA.B [!savelocation],Y

        %Set8bit(!M)                         ;Dog Name
        LDY.W #$0088
        LDA.W !dog_name_short_1
        STA.B [!savelocation],Y
        LDY.W #$0089
        LDA.W !dog_name_short_2
        STA.B [!savelocation],Y
        LDY.W #$008A
        LDA.W !dog_name_short_3
        STA.B [!savelocation],Y
        LDY.W #$008B
        LDA.W !dog_name_short_4
        STA.B [!savelocation],Y

        %Set8bit(!M)                         ;Horse Name
        LDY.W #$008C
        LDA.W !horse_name_short_1
        STA.B [!savelocation],Y
        LDY.W #$008D
        LDA.W !horse_name_short_2
        STA.B [!savelocation],Y
        LDY.W #$008E
        LDA.W !horse_name_short_3
        STA.B [!savelocation],Y
        LDY.W #$008F
        LDA.W !horse_name_short_4
        STA.B [!savelocation],Y

        %Set8bit(!M)                         ;Name of Kid 1
        LDY.W #$0090
        LDA.L !kid1_name_sort_1
        STA.B [!savelocation],Y
        LDY.W #$0091
        LDA.L !kid1_name_sort_2
        STA.B [!savelocation],Y
        LDY.W #$0092
        LDA.L !kid1_name_sort_3
        STA.B [!savelocation],Y
        LDY.W #$0093
        LDA.L !kid1_name_sort_4
        STA.B [!savelocation],Y

        %Set8bit(!M)                         ;Name of Kid 2
        LDY.W #$0094
        LDA.L !kid2_name_sort_1
        STA.B [!savelocation],Y
        LDY.W #$0095
        LDA.L !kid2_name_sort_2
        STA.B [!savelocation],Y
        LDY.W #$0096
        LDA.L !kid2_name_sort_3
        STA.B [!savelocation],Y
        LDY.W #$0097
        LDA.L !kid2_name_sort_4
        STA.B [!savelocation],Y

        %Set8bit(!M)                         ;Chikens
        LDY.W #$0098
        LDX.W #$0000
      - LDA.L !chicken_array,X
        STA.B [!savelocation],Y
        INY
        INX
        CPX.W #$0068
        BNE -

        %Set8bit(!M)                         ;Cows
        LDY.W #$0100
        LDX.W #$0000
      - LDA.L !cow_array,X
        STA.B [!savelocation],Y
        INY
        INX
        CPX.W #$00C0
        BNE -

        %Set8bit(!M)                         ;Farm Data
        LDY.W #$01C0
        LDX.W #$00C0
      - LDA.L !farm_map_array,X
        STA.B [!savelocation],Y
        INY
        INX
        CPX.W #$0F00
        BNE -

        %Set8bit(!M)                         ;crc sum
        LDY.W #$002E
        LDA.B #$00
        STA.B [!savelocation],Y
        %Set16bit(!MX)
        LDY.W #$002F
        LDA.W #$0000
        STA.B [!savelocation],Y
        LDY.W #$0000
        STZ.B !crcsum

      - LDA.B [!savelocation],Y
        CLC
        ADC.B !crcsum
        STA.B !crcsum
        INY
        INY
        CPY.W #$1000
        BNE -

        %Set16bit(!MX)
        LDY.W #$002F
        LDA.B !crcsum
        STA.B [!savelocation],Y
        %Set16bit(!M)
        PLA
        STA.B !crcsum
        LDA.W #$0000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank
        %Set16bit(!M)
        LDY.W #$002E
        LDA.B !crcsum
        BEQ .slot1
        %Set8bit(!M)
        LDA.B #$00
        STA.B [!savelocation],Y
        BRA .slot2

    .slot1
        %Set8bit(!M)
        LDA.B #$01
        STA.B [!savelocation],Y

    .slot2
        %Set16bit(!M)
        LDA.W #$1000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank
        %Set16bit(!M)
        LDY.W #$002E
        LDA.B !crcsum
        BEQ +
        %Set8bit(!M)
        LDA.B #$01
        STA.B [!savelocation],Y
        BRA $06

      + %Set8bit(!M)
        LDA.B #$00
        STA.B [!savelocation],Y

        RTL


;;;;;;;; Loads minimun info about the game slot
;;;;;;;; Param: A: Save Slot
LoadGameSlotResume: ;83BA45
        !savelocation = $72
        !savelocationBank = $74

        %Set16bit(!MX)
        PHA
        LDA.W #$0000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank
        %Set16bit(!M)
        PLA
        CMP.W #$0000
        BEQ .start
        LDA.W #$1000
        STA.B !savelocation
        %Set8bit(!M)
        LDA.B #$70
        STA.B !savelocationBank

    .start:
        %Set8bit(!M)
        %Set16bit(!X)
        LDX.W #$0000
        LDY.W #$0000
        LDA.B [!savelocation],Y
        STA.L !year
        LDY.W #$0001
        LDA.B [!savelocation],Y
        STA.L !season
        LDY.W #$0003
        LDA.B [!savelocation],Y
        STA.L !day
        BEQ .return

        LDY.W #$003C                         ;Farm Check
        LDA.B [!savelocation],Y
        CMP.B !ASCII_F
        BNE .return
        LDY.W #$003D
        LDA.B [!savelocation],Y
        CMP.B !ASCII_A
        BNE .return
        LDY.W #$003E
        LDA.B [!savelocation],Y
        CMP.B !ASCII_R
        BNE .return
        LDY.W #$003F
        LDA.B [!savelocation],Y
        CMP.B !ASCII_M
        BNE .return

        %Set8bit(!M)
        LDY.W #$0080
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_1
        LDY.W #$0081
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_2
        LDY.W #$0082
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_3
        LDY.W #$0083
        LDA.B [!savelocation],Y
        STA.W !player_name_sort_4
        LDX.W #$0001

    .return: RTL

;;;;;;;; Saves has between 3C-3F the ascii word FARM as a rudimentary check
;;;;;;;; Theres also a CRC check stored on 2F
;;;;;;;; Each saves is 4k, but seems that only 2k are actually used per save
CheckSRAMIntegrity: ;83BAD4
        !fails = $82
        !pointer = $72
        !pointerBank = $74
        !save_crc = $7E
        !crc_sum = $80

        %Set8bit(!M)
        %Set16bit(!X)
        STZ.W $098E
        %Set16bit(!M)
        LDA.L $7F1F60                        ;Flag $0800 indicates at least one save slot
        AND.W #$F7FF                         ;has been reset. Flag cleared here
        STA.L $7F1F60
        STZ.B !fails                        ;assume memory is fine
        LDA.W #$0000                         ;Starts with save 1
        STA.B !pointer
        %Set8bit(!M)
        LDA.B #$70
        STA.B !pointerBank                   ;Sets pointer to the beguining of the first save slot

    ;FARM check slot 1
        LDY.W #$003C
        LDA.B [!pointer],Y
        CMP.B !ASCII_F
        BNE .integrityFailed
        LDY.W #$003D
        LDA.B [!pointer],Y
        CMP.B !ASCII_A
        BNE .integrityFailed
        LDY.W #$003E
        LDA.B [!pointer],Y
        CMP.B !ASCII_R
        BNE .integrityFailed
        LDY.W #$003F
        LDA.B [!pointer],Y
        CMP.B !ASCII_M
        BNE .integrityFailed

        ;TODO: Unknown value, modifing it doesnt seem to do anything, always one
        %Set8bit(!M)
        LDY.W #$002E
        LDA.B [!pointer],Y
        STA.B $92
        LDA.B #$00
        STA.B [!pointer],Y                   ;Its set to 0 for the CRC

    ;CRC Sum Loop
        %Set16bit(!MX)
        LDY.W #$002F                         ;Stores the save's CRC
        LDA.B [!pointer],Y
        STA.B !save_crc
        LDA.W #$0000                         ;Zeroes values to not alter CRC sum
        STA.B [!pointer],Y
        LDY.W #$0000
        STZ.B !crc_sum

      - LDA.B [!pointer],Y
        CLC
        ADC.B !crc_sum
        STA.B !crc_sum
        INY
        INY
        CPY.W #$1000
        BNE -

        %Set16bit(!MX)
        LDA.B !save_crc
        CMP.B !crc_sum                       ;Checks if old CRC matches
        BNE .integrityFailed
        LDY.W #$002F
        LDA.B !save_crc
        STA.B [!pointer],Y                   ;Restores the save CRC

        %Set8bit(!M)
        LDY.W #$002E
        LDA.B $92
        STA.B [!pointer],Y                    ;Restores unknown value

        BRA .check1Passed

        ;delets the whole memory block, and restores the FARM check
    .integrityFailed:
        %Set16bit(!MX)
        LDY.W #$0000
        LDA.W #$0000

      - STA.B [!pointer],Y                        ;Clears Memory
        INY
        INY
        CPY.W #$0800
        BNE -

        %Set8bit(!M)                             ;Restores FARM check
        LDY.W #$003C
        LDA.B !ASCII_F
        STA.B [!pointer],Y
        LDY.W #$003D
        LDA.B !ASCII_A
        STA.B [!pointer],Y
        LDY.W #$003E
        LDA.B !ASCII_R
        STA.B [!pointer],Y
        LDY.W #$003F
        LDA.B !ASCII_M
        STA.B [!pointer],Y
        %Set16bit(!M)
        LDA.W #$0001
        STA.B !fails

        ;Repeats everything Slot 1 did with 2
    .check1Passed:
        %Set16bit(!MX)
        LDA.W #$1000                         ;Sets pointer to Slot 2
        STA.B !pointer
        %Set8bit(!M)
        LDA.B #$70
        STA.B !pointerBank

    ;FARM check slot 1
        LDY.W #$003C
        LDA.B [!pointer],Y
        CMP.B !ASCII_F
        BNE .integrityFailed2
        LDY.W #$003D
        LDA.B [!pointer],Y
        CMP.B !ASCII_A
        BNE .integrityFailed2
        LDY.W #$003E
        LDA.B [!pointer],Y
        CMP.B !ASCII_R
        BNE .integrityFailed2
        LDY.W #$003F
        LDA.B [!pointer],Y
        CMP.B !ASCII_M
        BNE .integrityFailed2

        ;TODO: Unknown value
        %Set8bit(!M)
        LDY.W #$002E
        LDA.B [!pointer],Y
        STA.B $92
        LDA.B #$00
        STA.B [!pointer],Y

    ;CRC Sum Loop
        %Set16bit(!MX)
        LDY.W #$002F
        LDA.B [!pointer],Y
        STA.B !save_crc
        LDA.W #$0000
        STA.B [!pointer],Y
        LDY.W #$0000
        STZ.B !crc_sum

      - LDA.B [!pointer],Y
        CLC
        ADC.B !crc_sum
        STA.B !crc_sum
        INY
        INY
        CPY.W #$1000
        BNE -

        %Set16bit(!MX)
        LDA.B !save_crc
        CMP.B !crc_sum
        BNE .integrityFailed2
        LDY.W #$002F
        LDA.B !save_crc
        STA.B [!pointer],Y

        %Set8bit(!M)
        LDY.W #$002E
        LDA.B $92
        STA.B [!pointer],Y
        CMP.B #$01                           ;Compares if the value is 1???
        BNE .check2Passed
        LDA.B #$01
        STA.W $098E                          ;??? TODO
        BRA .check2Passed

        ;deletes the whole memory block, and restores the FARM check
    .integrityFailed2:
        %Set16bit(!MX)
        LDY.W #$0000
        LDA.W #$0000

      - STA.B [!pointer],Y
        INY
        INY
        CPY.W #$0800
        BNE -

        %Set8bit(!M)                             ;Restores FARM check
        LDY.W #$003C
        LDA.B !ASCII_F
        STA.B [!pointer],Y
        LDY.W #$003D
        LDA.B !ASCII_A
        STA.B [!pointer],Y
        LDY.W #$003E
        LDA.B !ASCII_R
        STA.B [!pointer],Y
        LDY.W #$003F
        LDA.B !ASCII_M
        STA.B [!pointer],Y
        %Set16bit(!M)
        LDA.B !fails
        BEQ .check2Passed
        LDA.L $7F1F60
        ORA.W #$0800                         ;If at least one save fails, it sets flag $0800
        STA.L $7F1F60

    .check2Passed:
        RTL


;;;loops animals and checks feed, health and age/pregnancy and stuff like that
CowFeedingandStatus: ;83BC5A
        %Set16bit(!MX)
        LDA.L $7F1F60
        AND.W #$0001                         ;TODO
        BEQ +
        JMP.W .altcowfeed

      + LDX.W #$0000

    .cowloop:
        %Set16bit(!MX)
        PHX
        PHX
        TXA
        JSL.L GetsCowPointer
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$01                           ;Exists
        BNE .cowexists
        JMP.W .skipcow

    .cowexists:
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$02                           ;Baby
        BEQ .isbaby
        JMP.W .skipcow

    .isbaby:
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$04                           ;Child
        BEQ .ischild
        JMP.W .babyonfarm

    .ischild:
        LDY.W #$0002
        LDA.B [$72],Y                        ;Map
        CMP.B #$27                           ;Barn
        BNE .notinbarn
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$40                           ;Pregnant
        BNE .ispregnant
        %Set16bit(!M)
        TXA
        ASL A
        TAX
        LDA.L Cow_Feed_Flags,X
        AND.W !fed_cows_flags
        BEQ .cowunfed
        JMP.W .cowfed

    .ispregnant:
        %Set16bit(!MX)
        LDX.W #$0018                         ;Special pregnant cow slot
        LDA.L Cow_Feed_Flags,X
        AND.W !fed_cows_flags
        BEQ .cowunfed
        JMP.W .cowfed

    .notinbarn:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0002
        LDA.B [$72],Y                        ;Map
        CMP.B #$04                           ;Farm
        BCS .cowunfed
        JSL.L Sub_82A9A0                          ;TODO
        %Set16bit(!M)
        LDA.W $092E
        BEQ .cowunfed
        %Set16bit(!M)
        LDA.W $0196
        AND.W #$0002
        BNE .cowunfed
        LDA.W $0196
        AND.W #$0008
        BNE .CODE_83BD20
        LDA.W $0196
        AND.W #$0010
        BNE .CODE_83BD30
        LDA.W $0196
        AND.W #$0200
        BNE .CODE_83BD40
        JMP.W .cowfed

    .cowunfed:
        %Set16bit(!M)
        LDA.W #$FFF8
        JSL.L AddCowHappiness
        %Set16bit(!MX)
        LDY.W #$0004
        BRA .cowgetsick

    .CODE_83BD20:
        %Set16bit(!M)
        LDA.W #$FFF0
        JSL.L AddCowHappiness
        %Set16bit(!MX)
        LDY.W #$0002
        BRA .cowgetsick

    .CODE_83BD30:
        %Set16bit(!M)
        LDA.W #$FFE8
        JSL.L AddCowHappiness
        %Set16bit(!MX)
        LDY.W #$0002
        BRA .cowgetsick

    .CODE_83BD40:
        %Set16bit(!M)                             ;83BD40;      ;
        LDA.W #$FFF8                         ;83BD42;      ;
        JSL.L AddCowHappiness                    ;83BD45;84A5D4;
        %Set16bit(!MX)                             ;83BD49;      ;
        LDY.W #$0008                         ;83BD4B;      ;
        BRA .cowgetsick                      ;83BD4E;83BD50;

    .cowgetsick: ;param in Y
        %Set16bit(!MX)
        TYA
        JSL.L RNGReturn0toA
        BNE .cowfed
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y                        ;status
        AND.B #$40                           ;pregnant
        BNE .cowfed
        LDY.W #$0001
        LDA.B [$72],Y                        ;TODO, milked today?
        AND.B #$80
        BNE .cowfed
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$20                           ;sick
        BNE .cowfed
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        ORA.B #$20
        STA.B [$72],Y                        ;sets Sick
        LDY.W #$0003
        LDA.B #$07
        STA.B [$72],Y                        ;Pregnancy set to 7???
        %Set16bit(!M)
        LDA.W #$FFF4
        JSL.L AddCowHappiness
        %Set16bit(!MX)
        LDA.W #$FFE2
        JSL.L AddPlayerHappiness

    .cowfed:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0005
        LDA.B [$72],Y                        ;TODO
        CMP.B #$0A
        BEQ .cowgetscranky
        %Set16bit(!M)
        LDA.L $7F1F5A                        ;TODO
        AND.W #$1000                         ;FLAG5A
        BEQ .CODE_83BDD6
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$72],Y                        ;Map
        CMP.B #$27                           ;Barn
        BEQ .skipcow
        %Set8bit(!M)
        LDA.B #$10
        JSL.L RNGReturn0toA
        BNE .CODE_83BDD6
        %Set16bit(!M)
        LDA.W #$FFF8
        JSL.L AddCowHappiness
        BRA .cowgetscranky

    .CODE_83BDD6:
        %Set16bit(!M)
        LDA.W $0196                          ;Todo
        AND.W #$0400
        BEQ .skipcow
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$72],Y                        ;Gets back to barn?
        CMP.B #$27
        BEQ .skipcow

    .cowgetscranky:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$40                           ;Pregnant
        BNE .skipcow
        LDY.W #$0001
        LDA.B [$72],Y                        ;TODO
        AND.B #$80
        BNE .skipcow
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$20                           ;Sick
        BNE .skipcow
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        ORA.B #$10                           ;set Cranky
        STA.B [$72],Y
        LDY.W #$0003
        LDA.B #$03                           ;Farm Winter
        STA.B [$72],Y                        ;Map
        LDY.W #$0005                         ;TODO
        LDA.B #$00
        STA.B [$72],Y
        %Set16bit(!M)
        LDA.W #$FFE2
        JSL.L AddCowHappiness
        BRA .skipcow

    .babyonfarm:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0002
        LDA.B [$72],Y                        ;Map
        CMP.B #$04                           ;Farm
        BCS .skipcow
        JSL.L Sub_82A9A0

    .skipcow:
        %Set16bit(!MX)
        PLX
        INX
        CPX.W #$000C
        BEQ .altcowfeed
        JMP.W .cowloop

    .altcowfeed:
        %Set16bit(!MX)
        LDA.L $7F1F6E
        AND.W #$EFBF                         ;TODO
        STA.L $7F1F6E
        LDX.W #$0000

    .cowloop2:
        %Set16bit(!MX)
        PHX
        PHX
        TXA
        JSL.L GetsCowPointer
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$01                           ;Exists
        BNE .cowexists2
        JMP.W .skipcow2

    .cowexists2:
        LDY.W #$0004
        LDA.B [$72],Y                        ;Happines BUG?
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0001
        LDA.B [$72],Y                        ;TODO
        AND.B #$F8
        STA.B [$72],Y
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$02
        BEQ .isbaby2
        LDY.W #$0003
        LDA.B [$72],Y                        ;Pregnancy
        INC A                                ;+1
        STA.B [$72],Y
        CMP.B #14
        BEQ .cowborn
        JMP.W .skipcow2

    .cowborn:
        LDA.B #$00
        STA.B [$72],Y                        ;Pregnancy
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        ORA.B #$04
        AND.B #$FD
        STA.B [$72],Y                        ;Sets as healthy Adult
        JMP.W .skipcow2

    .isbaby2:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$04
        BEQ .itsadult2
        %Set8bit(!M)
        LDY.W #$0003
        LDA.B [$72],Y                        ;Age
        INC A
        STA.B [$72],Y                        ;+1
        CMP.B #21
        BEQ .growstochild
        JMP.W .skipcow2

    .growstochild:
        LDA.B #$00
        STA.B [$72],Y                        ;Status
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        ORA.B #$08
        AND.B #$FB
        STA.B [$72],Y
        LDY.W #$0003
        LDA.B #$00
        STA.B [$72],Y                        ;Sets as healthy Child
        %Set16bit(!M)
        LDA.L $7F1F6E
        ORA.W #$1000                         ;Sets cow "born" flag
        STA.L $7F1F6E
        JMP.W .skipcow2

    .itsadult2:
        %Set16bit(!MX)
        LDA.L $7F1F6E
        ORA.W #$1000
        STA.L $7F1F6E
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$10                           ;Cranky
        BEQ .itsnotcranky2
        LDY.W #$0003                         ;Crankyness
        LDA.B [$72],Y
        DEC A
        STA.B [$72],Y                        ;-1
        BEQ .uncrankyfy2
        JMP.W .skipcow2

    .uncrankyfy2:
        LDY.W #$0000
        LDA.B [$72],Y
        AND.B #$EF
        STA.B [$72],Y
        JMP.W .skipcow2

    .itsnotcranky2:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$20                           ;Sick
        BEQ .healthycow2
        LDY.W #$0003
        LDA.B [$72],Y
        BEQ .specialcheck
        DEC A                                ;83BF3A;      ;
        STA.B [$72],Y                        ;83BF3B;000072;
        BEQ .specialcheck                      ;83BF3D;83BF42;
        JMP.W .skipcow2                    ;83BF3F;83C01A;
                                                            ;      ;      ;
                                                            ;      ;      ;
    .specialcheck:
        %Set16bit(!MX)
        LDA.W $0196                          ;TODO
        AND.W #$001A
        BEQ .notafestival
        JMP.W .skipcow2

    .notafestival:
        %Set8bit(!M)
        LDA.W !weather_tomorrow
        CMP.B #$06                           ;Its not a festival/special
        BCC .cowdied
        JMP.W .skipcow2

    .cowdied:
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B #$00                           ;No cow
        STA.B [$72],Y                        ;Status
        %Set8bit(!M)
        LDA.L !cow_N
        DEC A                                ;one less cow
        STA.L !cow_N
        %Set16bit(!M)
        LDA.L $7F1F6E
        ORA.W #$0040                         ;Cow Funeral flag
        STA.L $7F1F6E
        PLX
        PHX
        TXA
        %Set8bit(!M)
        STA.W $0937                          ;TODO
        JMP.W .skipcow2

    .healthycow2:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0001
        LDA.B [$72],Y                        ;Flags
        AND.B #$80                           ;TODO
        BEQ .specialcheck2
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        ORA.B #$40                           ;Sets Pregnant?
        STA.B [$72],Y
        LDY.W #$0001
        LDA.B [$72],Y                        ;TODO
        AND.B #$7F                           ;Unsets 80
        STA.B [$72],Y
        BRA .skipcow2

    .specialcheck2:
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        AND.B #$40                           ;Pregnant?
        BEQ .skipcow2
        LDY.W #$0003
        LDA.B [$72],Y                        ;Pregnancy
        BEQ .cowbirth2
        DEC A                                ;-1
        STA.B [$72],Y
        LDA.L $7F1F12                        ;TODO
        DEC A
        STA.L $7F1F12
        BNE .skipcow2

    .cowbirth2:
        LDY.W #$0002
        LDA.B [$72],Y                        ;Map
        CMP.B #$27                           ;Barn
        BNE .skipcow2
        %Set16bit(!M)
        LDA.L $7F1F64
        ORA.W #$0008                         ;TODO Cow Pregnat?
        STA.L $7F1F64
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B [$72],Y                        ;Status
        ORA.B #$80
        AND.B #$BF                           ;Not Pregnant
        STA.B [$72],Y
        %Set8bit(!M)
        LDA.B #20                            ;TODO Starting cow Happiness?
        STA.L $7F1F2B
        LDY.W #$0004
        LDA.B [$72],Y                        ;Happyness
        CMP.B #96
        BCC .nextcow2
        CMP.B #192
        BCC .lesscowhappyness
        %Set8bit(!M)
        LDA.B #100
        STA.L $7F1F2B                        ;TODO Starting cow Happiness?
        BRA .nextcow2

    .lesscowhappyness:
        %Set8bit(!M)
        LDA.B #50
        STA.L $7F1F2B                        ;TODO Starting cow Happiness?
        BRA .nextcow2

    .nextcow2:
        BRA .skipcow2

    .skipcow2:
        %Set16bit(!MX)
        PLX
        INX
        CPX.W #12
        BEQ +
        JMP.W .cowloop2                    ;83C023;83BE5B;

          + %Set16bit(!MX)                             ;83C026;      ;
                       LDA.L $7F1F60                        ;83C028;7F1F60;
                       AND.W #$0001                         ;83C02C;      ;
                       BEQ CODE_83C034                      ;83C02F;83C034;
                       JMP.W CODE_83C125                    ;83C031;83C125;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C034: %Set16bit(!MX)                             ;83C034;      ;
                       LDA.L $7F1F6E                        ;83C036;7F1F6E;
                       AND.W #$FFDF                         ;83C03A;      ;
                       STA.L $7F1F6E                        ;83C03D;7F1F6E;
                       LDX.W #$0000                         ;83C041;      ;
                                                            ;      ;      ;
          CODE_83C044: %Set16bit(!MX)                             ;83C044;      ;
                       PHX                                  ;83C046;      ;
                       PHX                                  ;83C047;      ;
                       TXA                                  ;83C048;      ;
                       JSL.L GetChickenPointer          ;83C049;83C995;
                       %Set8bit(!M)                             ;83C04D;      ;
                       %Set16bit(!X)                             ;83C04F;      ;
                       PLX                                  ;83C051;      ;
                       LDY.W #$0000                         ;83C052;      ;
                       LDA.B [$72],Y                        ;83C055;000072;
                       AND.B #$01                           ;83C057;      ;
                       BNE CODE_83C05E                      ;83C059;83C05E;
                       JMP.W CODE_83C119                    ;83C05B;83C119;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C05E: %Set8bit(!M)                             ;83C05E;      ;
                       LDY.W #$0000                         ;83C060;      ;
                       LDA.B [$72],Y                        ;83C063;000072;
                       AND.B #$0E                           ;83C065;      ;
                       BNE CODE_83C084                      ;83C067;83C084;
                       %Set8bit(!M)                             ;83C069;      ;
                       LDY.W #$0000                         ;83C06B;      ;
                       LDA.B #$00                           ;83C06E;      ;
                       STA.B [$72],Y                        ;83C070;000072;
                       LDA.L !chicks_N                        ;83C072;7F1F0B;
                       DEC A                                ;83C076;      ;
                       STA.L !chicks_N                        ;83C077;7F1F0B;
                       %Set16bit(!MX)                             ;83C07B;      ;
                       LDA.W #$FFE2                         ;83C07D;      ;
                       JSL.L AddPlayerHappiness                   ;83C080;83B282;
                                                            ;      ;      ;
          CODE_83C084: %Set8bit(!M)                             ;83C084;      ;
                       LDY.W #$0000                         ;83C086;      ;
                       LDA.B [$72],Y                        ;83C089;000072;
                       AND.B #$08                           ;83C08B;      ;
                       BNE CODE_83C092                      ;83C08D;83C092;
                       JMP.W CODE_83C119                    ;83C08F;83C119;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C092: %Set8bit(!M)                             ;83C092;      ;
                       LDY.W #$0001                         ;83C094;      ;
                       LDA.B [$72],Y                        ;83C097;000072;
                       CMP.B #$28                           ;83C099;      ;
                       BNE CODE_83C0AB                      ;83C09B;83C0AB;
                       %Set8bit(!M)                             ;83C09D;      ;
                       LDA.W !fed_chicks_N                          ;83C09F;000931;
                       BEQ CODE_83C0CF                      ;83C0A2;83C0CF;
                       DEC A                                ;83C0A4;      ;
                       STA.W !fed_chicks_N                          ;83C0A5;000931;
                       JMP.W CODE_83C119                    ;83C0A8;83C119;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C0AB: %Set8bit(!M)                             ;83C0AB;      ;
                       %Set16bit(!X)                             ;83C0AD;      ;
                       LDY.W #$0001                         ;83C0AF;      ;
                       LDA.B [$72],Y                        ;83C0B2;000072;
                       CMP.B #$04                           ;83C0B4;      ;
                       BCS CODE_83C0CF                      ;83C0B6;83C0CF;
                       JSL.L Sub_82A9A0                          ;83C0B8;82A9A0;
                       %Set16bit(!M)                             ;83C0BC;      ;
                       LDA.W $092E                          ;83C0BE;00092E;
                       BEQ CODE_83C0CF                      ;83C0C1;83C0CF;
                       %Set16bit(!M)                             ;83C0C3;      ;
                       LDA.W $0196                          ;83C0C5;000196;
                       AND.W #$020A                         ;83C0C8;      ;
                       BNE CODE_83C0CF                      ;83C0CB;83C0CF;
                       BRA CODE_83C0E5                      ;83C0CD;83C0E5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C0CF: %Set8bit(!M)                             ;83C0CF;      ;
                       %Set16bit(!X)                             ;83C0D1;      ;
                       LDY.W #$0000                         ;83C0D3;      ;
                       LDA.B [$72],Y                        ;83C0D6;000072;
                       ORA.B #$10                           ;83C0D8;      ;
                       STA.B [$72],Y                        ;83C0DA;000072;
                       LDY.W #$0002                         ;83C0DC;      ;
                       LDA.B #$03                           ;83C0DF;      ;
                       STA.B [$72],Y                        ;83C0E1;000072;
                       BRA CODE_83C0E5                      ;83C0E3;83C0E5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C0E5: %Set16bit(!MX)                             ;83C0E5;      ;
                       LDA.W $0196                          ;83C0E7;000196;
                       AND.W #$0410                         ;83C0EA;      ;
                       BEQ CODE_83C119                      ;83C0ED;83C119;
                       LDA.L $7F1F6E                        ;83C0EF;7F1F6E;
                       AND.W #$0020                         ;83C0F3;      ;
                       BNE CODE_83C119                      ;83C0F6;83C119;
                       %Set8bit(!M)                             ;83C0F8;      ;
                       LDY.W #$0001                         ;83C0FA;      ;
                       LDA.B [$72],Y                        ;83C0FD;000072;
                       CMP.B #$04                           ;83C0FF;      ;
                       BCS CODE_83C119                      ;83C101;83C119;
                       LDY.W #$0000                         ;83C103;      ;
                       LDA.B #$01                           ;83C106;      ;
                       STA.B [$72],Y                        ;83C108;000072;
                       %Set16bit(!M)                             ;83C10A;      ;
                       LDA.L $7F1F6E                        ;83C10C;7F1F6E;
                       ORA.W #$0020                         ;83C110;      ;
                       STA.L $7F1F6E                        ;83C113;7F1F6E;
                       BRA CODE_83C119                      ;83C117;83C119;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C119: %Set16bit(!MX)                             ;83C119;      ;
                       PLX                                  ;83C11B;      ;
                       INX                                  ;83C11C;      ;
                       CPX.W #$000D                         ;83C11D;      ;
                       BEQ CODE_83C125                      ;83C120;83C125;
                       JMP.W CODE_83C044                    ;83C122;83C044;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C125: %Set16bit(!MX)                             ;83C125;      ;
                       LDX.W #$0000                         ;83C127;      ;
                                                            ;      ;      ;
          CODE_83C12A: %Set16bit(!MX)                             ;83C12A;      ;
                       PHX                                  ;83C12C;      ;
                       PHX                                  ;83C12D;      ;
                       TXA                                  ;83C12E;      ;
                       JSL.L GetChickenPointer          ;83C12F;83C995;
                       %Set8bit(!M)                             ;83C133;      ;
                       %Set16bit(!X)                             ;83C135;      ;
                       PLX                                  ;83C137;      ;
                       LDY.W #$0000                         ;83C138;      ;
                       LDA.B [$72],Y                        ;83C13B;000072;
                       AND.B #$01                           ;83C13D;      ;
                       BNE CODE_83C144                      ;83C13F;83C144;
                       JMP.W CODE_83C1DC                    ;83C141;83C1DC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C144: %Set8bit(!M)                             ;83C144;      ;
                       LDY.W #$0000                         ;83C146;      ;
                       LDA.B [$72],Y                        ;83C149;000072;
                       AND.B #$02                           ;83C14B;      ;
                       BEQ CODE_83C1AB                      ;83C14D;83C1AB;
                       %Set8bit(!M)                             ;83C14F;      ;
                       %Set16bit(!X)                             ;83C151;      ;
                       LDY.W #$0002                         ;83C153;      ;
                       LDA.B [$72],Y                        ;83C156;000072;
                       CMP.B #$03                           ;83C158;      ;
                       BEQ CODE_83C163                      ;83C15A;83C163;
                       INC A                                ;83C15C;      ;
                       STA.B [$72],Y                        ;83C15D;000072;
                       CMP.B #$03                           ;83C15F;      ;
                       BNE CODE_83C1DC                      ;83C161;83C1DC;
                                                            ;      ;      ;
          CODE_83C163: %Set8bit(!M)                             ;83C163;      ;
                       LDA.L !chicks_N                        ;83C165;7F1F0B;
                       CMP.B #$0C                           ;83C169;      ;
                       BEQ CODE_83C1DC                      ;83C16B;83C1DC;
                       LDY.W #$0002                         ;83C16D;      ;
                       LDA.B #$00                           ;83C170;      ;
                       STA.B [$72],Y                        ;83C172;000072;
                       LDY.W #$0000                         ;83C174;      ;
                       LDA.B [$72],Y                        ;83C177;000072;
                       ORA.B #$04                           ;83C179;      ;
                       AND.B #$BD                           ;83C17B;      ;
                       STA.B [$72],Y                        ;83C17D;000072;
                       %Set16bit(!M)                             ;83C17F;      ;
                       LDY.W #$0004                         ;83C181;      ;
                       LDA.W #$00D8                         ;83C184;      ;
                       STA.B [$72],Y                        ;83C187;000072;
                       LDY.W #$0006                         ;83C189;      ;
                       LDA.W #$00B8                         ;83C18C;      ;
                       STA.B [$72],Y                        ;83C18F;000072;
                       %Set8bit(!M)                             ;83C191;      ;
                       LDA.L !chicks_N                        ;83C193;7F1F0B;
                       INC A                                ;83C197;      ;
                       STA.L !chicks_N                        ;83C198;7F1F0B;
                       %Set16bit(!MX)                             ;83C19C;      ;
                       LDA.L $7F1F6E                        ;83C19E;7F1F6E;
                       AND.W #$DFFF                         ;83C1A2;      ;
                       STA.L $7F1F6E                        ;83C1A5;7F1F6E;
                       BRA CODE_83C1DC                      ;83C1A9;83C1DC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C1AB: %Set8bit(!M)                             ;83C1AB;      ;
                       %Set16bit(!X)                             ;83C1AD;      ;
                       LDY.W #$0000                         ;83C1AF;      ;
                       LDA.B [$72],Y                        ;83C1B2;000072;
                       AND.B #$04                           ;83C1B4;      ;
                       BEQ CODE_83C1DC                      ;83C1B6;83C1DC;
                       LDY.W #$0002                         ;83C1B8;      ;
                       LDA.B [$72],Y                        ;83C1BB;000072;
                       INC A                                ;83C1BD;      ;
                       STA.B [$72],Y                        ;83C1BE;000072;
                       CMP.B #$07                           ;83C1C0;      ;
                       BNE CODE_83C1DC                      ;83C1C2;83C1DC;
                       LDA.B #$00                           ;83C1C4;      ;
                       STA.B [$72],Y                        ;83C1C6;000072;
                       LDY.W #$0000                         ;83C1C8;      ;
                       LDA.B [$72],Y                        ;83C1CB;000072;
                       ORA.B #$08                           ;83C1CD;      ;
                       AND.B #$FB                           ;83C1CF;      ;
                       STA.B [$72],Y                        ;83C1D1;000072;
                       LDY.W #$0002                         ;83C1D3;      ;
                       LDA.B #$00                           ;83C1D6;      ;
                       STA.B [$72],Y                        ;83C1D8;000072;
                       BRA CODE_83C1DC                      ;83C1DA;83C1DC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C1DC: %Set16bit(!MX)                             ;83C1DC;      ;
                       PLX                                  ;83C1DE;      ;
                       INX                                  ;83C1DF;      ;
                       CPX.W #$000D                         ;83C1E0;      ;
                       BEQ CODE_83C1E8                      ;83C1E3;83C1E8;
                       JMP.W CODE_83C12A                    ;83C1E5;83C12A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C1E8: %Set16bit(!MX)                             ;83C1E8;      ;
                       LDA.W #$0000                         ;83C1EA;      ;
                       STA.L $7F1F45                        ;83C1ED;7F1F45;
                       LDA.L $7F1F6E                        ;83C1F1;7F1F6E;
                       AND.W #$FBFF                         ;83C1F5;      ;
                       STA.L $7F1F6E                        ;83C1F8;7F1F6E;
                       LDX.W #$0000                         ;83C1FC;      ;
                                                            ;      ;      ;
          CODE_83C1FF: %Set16bit(!MX)                             ;83C1FF;      ;
                       PHX                                  ;83C201;      ;
                       PHX                                  ;83C202;      ;
                       TXA                                  ;83C203;      ;
                       JSL.L GetChickenPointer          ;83C204;83C995;
                       %Set8bit(!M)                             ;83C208;      ;
                       %Set16bit(!X)                             ;83C20A;      ;
                       PLX                                  ;83C20C;      ;
                       LDY.W #$0000                         ;83C20D;      ;
                       LDA.B [$72],Y                        ;83C210;000072;
                       AND.B #$01                           ;83C212;      ;
                       BNE CODE_83C219                      ;83C214;83C219;
                       JMP.W CODE_83C26F                    ;83C216;83C26F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C219: %Set8bit(!M)                             ;83C219;      ;
                       LDY.W #$0000                         ;83C21B;      ;
                       LDA.B [$72],Y                        ;83C21E;000072;
                       AND.B #$08                           ;83C220;      ;
                       BEQ CODE_83C26F                      ;83C222;83C26F;
                       LDY.W #$0000                         ;83C224;      ;
                       LDA.B [$72],Y                        ;83C227;000072;
                       AND.B #$10                           ;83C229;      ;
                       BNE CODE_83C258                      ;83C22B;83C258;
                       LDY.W #$0001                         ;83C22D;      ;
                       LDA.B [$72],Y                        ;83C230;000072;
                       CMP.B #$28                           ;83C232;      ;
                       BNE CODE_83C26F                      ;83C234;83C26F;
                       %Set16bit(!MX)                             ;83C236;      ;
                       PLX                                  ;83C238;      ;
                       PHX                                  ;83C239;      ;
                       TXA                                  ;83C23A;      ;
                       ASL A                                ;83C23B;      ;
                       TAX                                  ;83C23C;      ;
                       LDA.L DATA8_83CA78,X                 ;83C23D;83CA78;
                       ORA.L $7F1F45                        ;83C241;7F1F45;
                       STA.L $7F1F45                        ;83C245;7F1F45;
                       %Set16bit(!M)                             ;83C249;      ;
                       LDA.L $7F1F6E                        ;83C24B;7F1F6E;
                       ORA.W #$0400                         ;83C24F;      ;
                       STA.L $7F1F6E                        ;83C252;7F1F6E;
                       BRA CODE_83C26F                      ;83C256;83C26F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C258: %Set8bit(!M)                             ;83C258;      ;
                       %Set16bit(!X)                             ;83C25A;      ;
                       LDY.W #$0002                         ;83C25C;      ;
                       LDA.B [$72],Y                        ;83C25F;000072;
                       DEC A                                ;83C261;      ;
                       STA.B [$72],Y                        ;83C262;000072;
                       BNE CODE_83C26F                      ;83C264;83C26F;
                       LDY.W #$0000                         ;83C266;      ;
                       LDA.B [$72],Y                        ;83C269;000072;
                       AND.B #$EF                           ;83C26B;      ;
                       STA.B [$72],Y                        ;83C26D;000072;
                                                            ;      ;      ;
          CODE_83C26F: %Set16bit(!MX)                             ;83C26F;      ;
                       PLX                                  ;83C271;      ;
                       INX                                  ;83C272;      ;
                       CPX.W #$000D                         ;83C273;      ;
                       BEQ CODE_83C27B                      ;83C276;83C27B;
                       JMP.W CODE_83C1FF                    ;83C278;83C1FF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C27B: %Set16bit(!MX)                             ;83C27B;      ;
                       LDA.L $7F1F68                        ;83C27D;7F1F68;
                       AND.W #$0100                         ;83C281;      ;
                       BEQ CODE_83C295                      ;83C284;83C295;
                       %Set8bit(!M)                             ;83C286;      ;
                       LDA.L $7F1F32                        ;83C288;7F1F32;
                       CMP.B #$15                           ;83C28C;      ;
                       BEQ CODE_83C295                      ;83C28E;83C295;
                       INC A                                ;83C290;      ;
                       STA.L $7F1F32                        ;83C291;7F1F32;
                                                            ;      ;      ;
          CODE_83C295: RTL                                  ;83C295;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C296: %Set16bit(!MX)                             ;83C296;      ;
                       LDX.W #$0000                         ;83C298;      ;
                                                            ;      ;      ;
          CODE_83C29B: %Set16bit(!MX)                             ;83C29B;      ;
                       PHX                                  ;83C29D;      ;
                       PHX                                  ;83C29E;      ;
                       TXA                                  ;83C29F;      ;
                       JSL.L GetChickenPointer          ;83C2A0;83C995;
                       %Set8bit(!M)                             ;83C2A4;      ;
                       %Set16bit(!X)                             ;83C2A6;      ;
                       PLX                                  ;83C2A8;      ;
                       LDY.W #$0000                         ;83C2A9;      ;
                       LDA.B [$72],Y                        ;83C2AC;000072;
                       AND.B #$01                           ;83C2AE;      ;
                       BNE CODE_83C2B5                      ;83C2B0;83C2B5;
                       JMP.W CODE_83C401                    ;83C2B2;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2B5: LDY.W #$0000                         ;83C2B5;      ;
                       LDA.B [$72],Y                        ;83C2B8;000072;
                       AND.B #$20                           ;83C2BA;      ;
                       BEQ CODE_83C2C1                      ;83C2BC;83C2C1;
                       JMP.W CODE_83C401                    ;83C2BE;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2C1: %Set8bit(!M)                             ;83C2C1;      ;
                       LDY.W #$0001                         ;83C2C3;      ;
                       LDA.B [$72],Y                        ;83C2C6;000072;
                       CMP.B #$04                           ;83C2C8;      ;
                       BCS CODE_83C2D8                      ;83C2CA;83C2D8;
                       LDA.B !tilemap_to_load                            ;83C2CC;000022;
                       CMP.B #$04                           ;83C2CE;      ;
                       BCC CODE_83C2D5                      ;83C2D0;83C2D5;
                       JMP.W CODE_83C401                    ;83C2D2;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2D5: JMP.W CODE_83C370                    ;83C2D5;83C370;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2D8: %Set8bit(!M)                             ;83C2D8;      ;
                       LDY.W #$0001                         ;83C2DA;      ;
                       LDA.B [$72],Y                        ;83C2DD;000072;
                       CMP.B #$08                           ;83C2DF;      ;
                       BCS CODE_83C2F5                      ;83C2E1;83C2F5;
                       LDA.B !tilemap_to_load                            ;83C2E3;000022;
                       CMP.B #$04                           ;83C2E5;      ;
                       BCS CODE_83C2EC                      ;83C2E7;83C2EC;
                       JMP.W CODE_83C401                    ;83C2E9;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2EC: CMP.B #$08                           ;83C2EC;      ;
                       BCC CODE_83C2F3                      ;83C2EE;83C2F3;
                       JMP.W CODE_83C401                    ;83C2F0;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2F3: BRA CODE_83C370                      ;83C2F3;83C370;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C2F5: %Set8bit(!M)                             ;83C2F5;      ;
                       LDY.W #$0001                         ;83C2F7;      ;
                       LDA.B [$72],Y                        ;83C2FA;000072;
                       CMP.B #$10                           ;83C2FC;      ;
                       BCS CODE_83C312                      ;83C2FE;83C312;
                       LDA.B !tilemap_to_load                            ;83C300;000022;
                       CMP.B #$0C                           ;83C302;      ;
                       BCS CODE_83C309                      ;83C304;83C309;
                       JMP.W CODE_83C401                    ;83C306;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C309: CMP.B #$10                           ;83C309;      ;
                       BCC CODE_83C310                      ;83C30B;83C310;
                       JMP.W CODE_83C401                    ;83C30D;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C310: BRA CODE_83C370                      ;83C310;83C370;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C312: %Set8bit(!M)                             ;83C312;      ;
                       LDY.W #$0001                         ;83C314;      ;
                       LDA.B [$72],Y                        ;83C317;000072;
                       CMP.B #$14                           ;83C319;      ;
                       BCS CODE_83C32F                      ;83C31B;83C32F;
                       LDA.B !tilemap_to_load                            ;83C31D;000022;
                       CMP.B #$10                           ;83C31F;      ;
                       BCS CODE_83C326                      ;83C321;83C326;
                       JMP.W CODE_83C401                    ;83C323;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C326: CMP.B #$14                           ;83C326;      ;
                       BCC CODE_83C32D                      ;83C328;83C32D;
                       JMP.W CODE_83C401                    ;83C32A;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C32D: BRA CODE_83C370                      ;83C32D;83C370;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C32F: %Set8bit(!M)                             ;83C32F;      ;
                       LDY.W #$0001                         ;83C331;      ;
                       LDA.B [$72],Y                        ;83C334;000072;
                       CMP.B #$18                           ;83C336;      ;
                       BCS CODE_83C34C                      ;83C338;83C34C;
                       LDA.B !tilemap_to_load                            ;83C33A;000022;
                       CMP.B #$15                           ;83C33C;      ;
                       BCS CODE_83C343                      ;83C33E;83C343;
                       JMP.W CODE_83C401                    ;83C340;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C343: CMP.B #$18                           ;83C343;      ;
                       BCC CODE_83C34A                      ;83C345;83C34A;
                       JMP.W CODE_83C401                    ;83C347;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C34A: BRA CODE_83C370                      ;83C34A;83C370;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C34C: %Set8bit(!M)                             ;83C34C;      ;
                       LDY.W #$0001                         ;83C34E;      ;
                       LDA.B [$72],Y                        ;83C351;000072;
                       CMP.B #$31                           ;83C353;      ;
                       BCC CODE_83C362                      ;83C355;83C362;
                       LDA.B !tilemap_to_load                            ;83C357;000022;
                       CMP.B #$31                           ;83C359;      ;
                       BCS CODE_83C360                      ;83C35B;83C360;
                       JMP.W CODE_83C401                    ;83C35D;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C360: BRA CODE_83C370                      ;83C360;83C370;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C362: %Set8bit(!M)                             ;83C362;      ;
                       LDY.W #$0001                         ;83C364;      ;
                       LDA.B [$72],Y                        ;83C367;000072;
                       CMP.B !tilemap_to_load                            ;83C369;000022;
                       BEQ CODE_83C370                      ;83C36B;83C370;
                       JMP.W CODE_83C401                    ;83C36D;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C370: %Set16bit(!M)                             ;83C370;      ;
                       LDY.W #$0004                         ;83C372;      ;
                       LDA.B [$72],Y                        ;83C375;000072;
                       STA.W !tile_in_front_X                          ;83C377;000985;
                       LDY.W #$0006                         ;83C37A;      ;
                       LDA.B [$72],Y                        ;83C37D;000072;
                       STA.W !tile_in_front_Y                          ;83C37F;000987;
                       %Set8bit(!M)                             ;83C382;      ;
                       LDY.W #$0000                         ;83C384;      ;
                       LDA.B [$72],Y                        ;83C387;000072;
                       AND.B #$02                           ;83C389;      ;
                       BEQ CODE_83C3AB                      ;83C38B;83C3AB;
                       %Set16bit(!M)                             ;83C38D;      ;
                       TXA                                  ;83C38F;      ;
                       CLC                                  ;83C390;      ;
                       ADC.W #$0024                         ;83C391;      ;
                       LDX.W #$0000                         ;83C394;      ;
                       LDY.W #$0000                         ;83C397;      ;
                       JSL.L CODE_8480F8                    ;83C39A;8480F8;
                       %Set8bit(!M)                             ;83C39E;      ;
                       %Set16bit(!X)                             ;83C3A0;      ;
                       LDY.W #$0000                         ;83C3A2;      ;
                       LDA.B #$03                           ;83C3A5;      ;
                       STA.B [$CC],Y                        ;83C3A7;0000CC;
                       BRA CODE_83C401                      ;83C3A9;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C3AB: %Set8bit(!M)                             ;83C3AB;      ;
                       LDY.W #$0000                         ;83C3AD;      ;
                       LDA.B [$72],Y                        ;83C3B0;000072;
                       AND.B #$04                           ;83C3B2;      ;
                       BEQ CODE_83C3C9                      ;83C3B4;83C3C9;
                       %Set16bit(!M)                             ;83C3B6;      ;
                       TXA                                  ;83C3B8;      ;
                       CLC                                  ;83C3B9;      ;
                       ADC.W #$0024                         ;83C3BA;      ;
                       LDX.W #$0000                         ;83C3BD;      ;
                       LDY.W #$0001                         ;83C3C0;      ;
                       JSL.L CODE_8480F8                    ;83C3C3;8480F8;
                       BRA CODE_83C401                      ;83C3C7;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C3C9: %Set8bit(!M)                             ;83C3C9;      ;
                       LDY.W #$0000                         ;83C3CB;      ;
                       LDA.B [$72],Y                        ;83C3CE;000072;
                       AND.B #$08                           ;83C3D0;      ;
                       BEQ CODE_83C3F0                      ;83C3D2;83C3F0;
                       %Set16bit(!M)                             ;83C3D4;      ;
                       TXA                                  ;83C3D6;      ;
                       CLC                                  ;83C3D7;      ;
                       ADC.W #$0024                         ;83C3D8;      ;
                       LDX.W #$0000                         ;83C3DB;      ;
                       LDY.W #$0002                         ;83C3DE;      ;
                       JSL.L CODE_8480F8                    ;83C3E1;8480F8;
                       %Set16bit(!MX)                             ;83C3E5;      ;
                       PLA                                  ;83C3E7;      ;
                       PHA                                  ;83C3E8;      ;
                       ASL A                                ;83C3E9;      ;
                       TAX                                  ;83C3EA;      ;
                       STZ.W $093B,X                        ;83C3EB;00093B;
                       BRA CODE_83C401                      ;83C3EE;83C401;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C3F0: %Set16bit(!M)                             ;83C3F0;      ;
                       TXA                                  ;83C3F2;      ;
                       CLC                                  ;83C3F3;      ;
                       ADC.W #$0024                         ;83C3F4;      ;
                       LDX.W #$0000                         ;83C3F7;      ;
                       LDY.W #$005F                         ;83C3FA;      ;
                       JSL.L CODE_8480F8                    ;83C3FD;8480F8;
                                                            ;      ;      ;
          CODE_83C401: %Set16bit(!MX)                             ;83C401;      ;
                       PLX                                  ;83C403;      ;
                       INX                                  ;83C404;      ;
                       CPX.W #$000D                         ;83C405;      ;
                       BEQ CODE_83C40D                      ;83C408;83C40D;
                       JMP.W CODE_83C29B                    ;83C40A;83C29B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C40D: LDX.W #$0000                         ;83C40D;      ;
                                                            ;      ;      ;
          CODE_83C410: %Set16bit(!MX)                             ;83C410;      ;
                       PHX                                  ;83C412;      ;
                       PHX                                  ;83C413;      ;
                       TXA                                  ;83C414;      ;
                       JSL.L GetsCowPointer                ;83C415;83C9A7;
                       %Set8bit(!M)                             ;83C419;      ;
                       %Set16bit(!X)                             ;83C41B;      ;
                       PLX                                  ;83C41D;      ;
                       LDY.W #$0000                         ;83C41E;      ;
                       LDA.B [$72],Y                        ;83C421;000072;
                       AND.B #$01                           ;83C423;      ;
                       BNE CODE_83C42A                      ;83C425;83C42A;
                       JMP.W CODE_83C63D                    ;83C427;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C42A: %Set8bit(!M)                             ;83C42A;      ;
                       LDA.B !tilemap_to_load                            ;83C42C;000022;
                       CMP.B #$27                           ;83C42E;      ;
                       BNE CODE_83C46D                      ;83C430;83C46D;
                       LDY.W #$0002                         ;83C432;      ;
                       LDA.B [$72],Y                        ;83C435;000072;
                       CMP.B #$27                           ;83C437;      ;
                       BEQ CODE_83C43E                      ;83C439;83C43E;
                       JMP.W CODE_83C63D                    ;83C43B;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C43E: PHX                                  ;83C43E;      ;
                       %Set8bit(!M)                             ;83C43F;      ;
                       LDY.W #$0000                         ;83C441;      ;
                       LDA.B [$72],Y                        ;83C444;000072;
                       AND.B #$C0                           ;83C446;      ;
                       BEQ CODE_83C44D                      ;83C448;83C44D;
                       LDX.W #$000C                         ;83C44A;      ;
                                                            ;      ;      ;
          CODE_83C44D: %Set16bit(!M)                             ;83C44D;      ;
                       TXA                                  ;83C44F;      ;
                       ASL A                                ;83C450;      ;
                       ASL A                                ;83C451;      ;
                       TAX                                  ;83C452;      ;
                       LDY.W #$0008                         ;83C453;      ;
                       LDA.L Table_CowsSpawnPos,X           ;83C456;83CA44;
                       STA.W !tile_in_front_X                          ;83C45A;000985;
                       INX                                  ;83C45D;      ;
                       INX                                  ;83C45E;      ;
                       LDY.W #$000A                         ;83C45F;      ;
                       LDA.L Table_CowsSpawnPos,X           ;83C462;83CA44;
                       STA.W !tile_in_front_Y                          ;83C466;000987;
                       PLX                                  ;83C469;      ;
                       JMP.W CODE_83C52E                    ;83C46A;83C52E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C46D: %Set8bit(!M)                             ;83C46D;      ;
                       LDY.W #$0002                         ;83C46F;      ;
                       LDA.B [$72],Y                        ;83C472;000072;
                       CMP.B #$04                           ;83C474;      ;
                       BCS CODE_83C484                      ;83C476;83C484;
                       LDA.B !tilemap_to_load                            ;83C478;000022;
                       CMP.B #$04                           ;83C47A;      ;
                       BCC CODE_83C481                      ;83C47C;83C481;
                       JMP.W CODE_83C63D                    ;83C47E;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C481: JMP.W CODE_83C51C                    ;83C481;83C51C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C484: %Set8bit(!M)                             ;83C484;      ;
                       LDY.W #$0002                         ;83C486;      ;
                       LDA.B [$72],Y                        ;83C489;000072;
                       CMP.B #$08                           ;83C48B;      ;
                       BCS CODE_83C4A1                      ;83C48D;83C4A1;
                       LDA.B !tilemap_to_load                            ;83C48F;000022;
                       CMP.B #$04                           ;83C491;      ;
                       BCS CODE_83C498                      ;83C493;83C498;
                       JMP.W CODE_83C63D                    ;83C495;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C498: CMP.B #$08                           ;83C498;      ;
                       BCC CODE_83C49F                      ;83C49A;83C49F;
                       JMP.W CODE_83C63D                    ;83C49C;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C49F: BRA CODE_83C51C                      ;83C49F;83C51C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4A1: %Set8bit(!M)                             ;83C4A1;      ;
                       LDY.W #$0002                         ;83C4A3;      ;
                       LDA.B [$72],Y                        ;83C4A6;000072;
                       CMP.B #$10                           ;83C4A8;      ;
                       BCS CODE_83C4BE                      ;83C4AA;83C4BE;
                       LDA.B !tilemap_to_load                            ;83C4AC;000022;
                       CMP.B #$0C                           ;83C4AE;      ;
                       BCS CODE_83C4B5                      ;83C4B0;83C4B5;
                       JMP.W CODE_83C63D                    ;83C4B2;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4B5: CMP.B #$10                           ;83C4B5;      ;
                       BCC CODE_83C4BC                      ;83C4B7;83C4BC;
                       JMP.W CODE_83C63D                    ;83C4B9;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4BC: BRA CODE_83C51C                      ;83C4BC;83C51C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4BE: %Set8bit(!M)                             ;83C4BE;      ;
                       LDY.W #$0002                         ;83C4C0;      ;
                       LDA.B [$72],Y                        ;83C4C3;000072;
                       CMP.B #$14                           ;83C4C5;      ;
                       BCS CODE_83C4DB                      ;83C4C7;83C4DB;
                       LDA.B !tilemap_to_load                            ;83C4C9;000022;
                       CMP.B #$10                           ;83C4CB;      ;
                       BCS CODE_83C4D2                      ;83C4CD;83C4D2;
                       JMP.W CODE_83C63D                    ;83C4CF;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4D2: CMP.B #$14                           ;83C4D2;      ;
                       BCC CODE_83C4D9                      ;83C4D4;83C4D9;
                       JMP.W CODE_83C63D                    ;83C4D6;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4D9: BRA CODE_83C51C                      ;83C4D9;83C51C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4DB: %Set8bit(!M)                             ;83C4DB;      ;
                       LDY.W #$0002                         ;83C4DD;      ;
                       LDA.B [$72],Y                        ;83C4E0;000072;
                       CMP.B #$18                           ;83C4E2;      ;
                       BCS CODE_83C4F8                      ;83C4E4;83C4F8;
                       LDA.B !tilemap_to_load                            ;83C4E6;000022;
                       CMP.B #$15                           ;83C4E8;      ;
                       BCS CODE_83C4EF                      ;83C4EA;83C4EF;
                       JMP.W CODE_83C63D                    ;83C4EC;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4EF: CMP.B #$18                           ;83C4EF;      ;
                       BCC CODE_83C4F6                      ;83C4F1;83C4F6;
                       JMP.W CODE_83C63D                    ;83C4F3;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4F6: BRA CODE_83C51C                      ;83C4F6;83C51C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C4F8: %Set8bit(!M)                             ;83C4F8;      ;
                       LDY.W #$0002                         ;83C4FA;      ;
                       LDA.B [$72],Y                        ;83C4FD;000072;
                       CMP.B #$31                           ;83C4FF;      ;
                       BCC CODE_83C50E                      ;83C501;83C50E;
                       LDA.B !tilemap_to_load                            ;83C503;000022;
                       CMP.B #$31                           ;83C505;      ;
                       BCS CODE_83C50C                      ;83C507;83C50C;
                       JMP.W CODE_83C63D                    ;83C509;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C50C: BRA CODE_83C51C                      ;83C50C;83C51C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C50E: %Set8bit(!M)                             ;83C50E;      ;
                       LDY.W #$0002                         ;83C510;      ;
                       LDA.B [$72],Y                        ;83C513;000072;
                       CMP.B !tilemap_to_load                            ;83C515;000022;
                       BEQ CODE_83C51C                      ;83C517;83C51C;
                       JMP.W CODE_83C63D                    ;83C519;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C51C: %Set16bit(!M)                             ;83C51C;      ;
                       LDY.W #$0008                         ;83C51E;      ;
                       LDA.B [$72],Y                        ;83C521;000072;
                       STA.W !tile_in_front_X                          ;83C523;000985;
                       LDY.W #$000A                         ;83C526;      ;
                       LDA.B [$72],Y                        ;83C529;000072;
                       STA.W !tile_in_front_Y                          ;83C52B;000987;
                                                            ;      ;      ;
          CODE_83C52E: %Set8bit(!M)                             ;83C52E;      ;
                       LDY.W #$0000                         ;83C530;      ;
                       LDA.B [$72],Y                        ;83C533;000072;
                       AND.B #$02                           ;83C535;      ;
                       BEQ CODE_83C572                      ;83C537;83C572;
                       %Set16bit(!M)                             ;83C539;      ;
                       LDA.W $0196                          ;83C53B;000196;
                       AND.W #$0002                         ;83C53E;      ;
                       BEQ CODE_83C553                      ;83C541;83C553;
                       %Set8bit(!M)                             ;83C543;      ;
                       LDY.W #$0002                         ;83C545;      ;
                       LDA.B [$72],Y                        ;83C548;000072;
                       CMP.B #$27                           ;83C54A;      ;
                       BEQ CODE_83C553                      ;83C54C;83C553;
                       LDY.W #$0017                         ;83C54E;      ;
                       BRA CODE_83C558                      ;83C551;83C558;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C553: %Set16bit(!MX)                             ;83C553;      ;
                       LDY.W #$0003                         ;83C555;      ;
                                                            ;      ;      ;
          CODE_83C558: %Set16bit(!M)                             ;83C558;      ;
                       TXA                                  ;83C55A;      ;
                       CLC                                  ;83C55B;      ;
                       ADC.W #$0018                         ;83C55C;      ;
                       LDX.W #$0000                         ;83C55F;      ;
                       JSL.L CODE_8480F8                    ;83C562;8480F8;
                       %Set16bit(!MX)                             ;83C566;      ;
                       PLA                                  ;83C568;      ;
                       PHA                                  ;83C569;      ;
                       ASL A                                ;83C56A;      ;
                       TAX                                  ;83C56B;      ;
                       STZ.W $0953,X                        ;83C56C;000953;
                       JMP.W CODE_83C63D                    ;83C56F;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C572: %Set8bit(!M)                             ;83C572;      ;
                       LDY.W #$0000                         ;83C574;      ;
                       LDA.B [$72],Y                        ;83C577;000072;
                       AND.B #$04                           ;83C579;      ;
                       BEQ CODE_83C5B6                      ;83C57B;83C5B6;
                       %Set16bit(!M)                             ;83C57D;      ;
                       LDA.W $0196                          ;83C57F;000196;
                       AND.W #$0002                         ;83C582;      ;
                       BEQ CODE_83C597                      ;83C585;83C597;
                       %Set8bit(!M)                             ;83C587;      ;
                       LDY.W #$0002                         ;83C589;      ;
                       LDA.B [$72],Y                        ;83C58C;000072;
                       CMP.B #$27                           ;83C58E;      ;
                       BEQ CODE_83C597                      ;83C590;83C597;
                       LDY.W #$002F                         ;83C592;      ;
                       BRA CODE_83C59C                      ;83C595;83C59C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C597: %Set16bit(!MX)                             ;83C597;      ;
                       LDY.W #$0004                         ;83C599;      ;
                                                            ;      ;      ;
          CODE_83C59C: %Set16bit(!M)                             ;83C59C;      ;
                       TXA                                  ;83C59E;      ;
                       CLC                                  ;83C59F;      ;
                       ADC.W #$0018                         ;83C5A0;      ;
                       LDX.W #$0000                         ;83C5A3;      ;
                       JSL.L CODE_8480F8                    ;83C5A6;8480F8;
                       %Set16bit(!MX)                             ;83C5AA;      ;
                       PLA                                  ;83C5AC;      ;
                       PHA                                  ;83C5AD;      ;
                       ASL A                                ;83C5AE;      ;
                       TAX                                  ;83C5AF;      ;
                       STZ.W $0953,X                        ;83C5B0;000953;
                       JMP.W CODE_83C63D                    ;83C5B3;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C5B6: %Set8bit(!M)                             ;83C5B6;      ;
                       LDY.W #$0000                         ;83C5B8;      ;
                       LDA.B [$72],Y                        ;83C5BB;000072;
                       AND.B #$08                           ;83C5BD;      ;
                       BEQ CODE_83C63D                      ;83C5BF;83C63D;
                       %Set8bit(!M)                             ;83C5C1;      ;
                       LDY.W #$0000                         ;83C5C3;      ;
                       LDA.B [$72],Y                        ;83C5C6;000072;
                       AND.B #$80                           ;83C5C8;      ;
                       BNE CODE_83C616                      ;83C5CA;83C616;
                       %Set8bit(!M)                             ;83C5CC;      ;
                       LDY.W #$0000                         ;83C5CE;      ;
                       LDA.B [$72],Y                        ;83C5D1;000072;
                       AND.B #$40                           ;83C5D3;      ;
                       BEQ CODE_83C5DC                      ;83C5D5;83C5DC;
                       LDY.W #$0008                         ;83C5D7;      ;
                       BRA CODE_83C624                      ;83C5DA;83C624;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C5DC: %Set8bit(!M)                             ;83C5DC;      ;
                       LDY.W #$0000                         ;83C5DE;      ;
                       LDA.B [$72],Y                        ;83C5E1;000072;
                       AND.B #$20                           ;83C5E3;      ;
                       BEQ CODE_83C5EC                      ;83C5E5;83C5EC;
                       LDY.W #$0007                         ;83C5E7;      ;
                       BRA CODE_83C624                      ;83C5EA;83C624;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C5EC: %Set8bit(!M)                             ;83C5EC;      ;
                       LDY.W #$0000                         ;83C5EE;      ;
                       LDA.B [$72],Y                        ;83C5F1;000072;
                       AND.B #$10                           ;83C5F3;      ;
                       BEQ CODE_83C5FC                      ;83C5F5;83C5FC;
                       LDY.W #$0006                         ;83C5F7;      ;
                       BRA CODE_83C624                      ;83C5FA;83C624;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C5FC: %Set16bit(!M)                             ;83C5FC;      ;
                       LDA.W $0196                          ;83C5FE;000196;
                       AND.W #$0002                         ;83C601;      ;
                       BEQ CODE_83C621                      ;83C604;83C621;
                       %Set8bit(!M)                             ;83C606;      ;
                       LDY.W #$0002                         ;83C608;      ;
                       LDA.B [$72],Y                        ;83C60B;000072;
                       CMP.B #$27                           ;83C60D;      ;
                       BEQ CODE_83C621                      ;83C60F;83C621;
                       LDY.W #$0009                         ;83C611;      ;
                       BRA CODE_83C624                      ;83C614;83C624;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C616: %Set8bit(!M)                             ;83C616;      ;
                       LDY.W #$0000                         ;83C618;      ;
                       LDA.B [$72],Y                        ;83C61B;000072;
                       AND.B #$7F                           ;83C61D;      ;
                       STA.B [$72],Y                        ;83C61F;000072;
                                                            ;      ;      ;
          CODE_83C621: LDY.W #$0005                         ;83C621;      ;
                                                            ;      ;      ;
          CODE_83C624: %Set16bit(!M)                             ;83C624;      ;
                       TXA                                  ;83C626;      ;
                       CLC                                  ;83C627;      ;
                       ADC.W #$0018                         ;83C628;      ;
                       LDX.W #$0000                         ;83C62B;      ;
                       JSL.L CODE_8480F8                    ;83C62E;8480F8;
                       %Set16bit(!MX)                             ;83C632;      ;
                       PLA                                  ;83C634;      ;
                       PHA                                  ;83C635;      ;
                       ASL A                                ;83C636;      ;
                       TAX                                  ;83C637;      ;
                       STZ.W $0953,X                        ;83C638;000953;
                       BRA CODE_83C63D                      ;83C63B;83C63D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C63D: %Set16bit(!MX)                             ;83C63D;      ;
                       PLX                                  ;83C63F;      ;
                       INX                                  ;83C640;      ;
                       CPX.W #$000C                         ;83C641;      ;
                       BEQ CODE_83C649                      ;83C644;83C649;
                       JMP.W CODE_83C410                    ;83C646;83C410;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C649: %Set16bit(!MX)                             ;83C649;      ;
                       LDA.L $7F1F68                        ;83C64B;7F1F68;
                       AND.W #$0080                         ;83C64F;      ;
                       BNE CODE_83C657                      ;83C652;83C657;
                       JMP.W CODE_83C734                    ;83C654;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C657: LDA.B !game_state                            ;83C657;0000D2;
                       AND.W #$0800                         ;83C659;      ;
                       BEQ CODE_83C661                      ;83C65C;83C661;
                       JMP.W CODE_83C734                    ;83C65E;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C661: %Set8bit(!M)                             ;83C661;      ;
                       LDA.L !dog_map                        ;83C663;7F1F30;
                       CMP.B #$04                           ;83C667;      ;
                       BCS CODE_83C677                      ;83C669;83C677;
                       LDA.B !tilemap_to_load                            ;83C66B;000022;
                       CMP.B #$04                           ;83C66D;      ;
                       BCC CODE_83C674                      ;83C66F;83C674;
                       JMP.W CODE_83C734                    ;83C671;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C674: JMP.W CODE_83C709                    ;83C674;83C709;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C677: %Set8bit(!M)                             ;83C677;      ;
                       LDA.L !dog_map                        ;83C679;7F1F30;
                       CMP.B #$08                           ;83C67D;      ;
                       BCS CODE_83C693                      ;83C67F;83C693;
                       LDA.B !tilemap_to_load                            ;83C681;000022;
                       CMP.B #$04                           ;83C683;      ;
                       BCS CODE_83C68A                      ;83C685;83C68A;
                       JMP.W CODE_83C734                    ;83C687;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C68A: CMP.B #$08                           ;83C68A;      ;
                       BCC CODE_83C691                      ;83C68C;83C691;
                       JMP.W CODE_83C734                    ;83C68E;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C691: BRA CODE_83C709                      ;83C691;83C709;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C693: %Set8bit(!M)                             ;83C693;      ;
                       LDA.L !dog_map                        ;83C695;7F1F30;
                       CMP.B #$10                           ;83C699;      ;
                       BCS CODE_83C6AF                      ;83C69B;83C6AF;
                       LDA.B !tilemap_to_load                            ;83C69D;000022;
                       CMP.B #$0C                           ;83C69F;      ;
                       BCS CODE_83C6A6                      ;83C6A1;83C6A6;
                       JMP.W CODE_83C734                    ;83C6A3;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6A6: CMP.B #$10                           ;83C6A6;      ;
                       BCC CODE_83C6AD                      ;83C6A8;83C6AD;
                       JMP.W CODE_83C734                    ;83C6AA;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6AD: BRA CODE_83C709                      ;83C6AD;83C709;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6AF: %Set8bit(!M)                             ;83C6AF;      ;
                       LDA.L !dog_map                        ;83C6B1;7F1F30;
                       CMP.B #$14                           ;83C6B5;      ;
                       BCS CODE_83C6CB                      ;83C6B7;83C6CB;
                       LDA.B !tilemap_to_load                            ;83C6B9;000022;
                       CMP.B #$10                           ;83C6BB;      ;
                       BCS CODE_83C6C2                      ;83C6BD;83C6C2;
                       JMP.W CODE_83C734                    ;83C6BF;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6C2: CMP.B #$14                           ;83C6C2;      ;
                       BCC CODE_83C6C9                      ;83C6C4;83C6C9;
                       JMP.W CODE_83C734                    ;83C6C6;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6C9: BRA CODE_83C709                      ;83C6C9;83C709;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6CB: %Set8bit(!M)                             ;83C6CB;      ;
                       LDA.L !dog_map                        ;83C6CD;7F1F30;
                       CMP.B #$18                           ;83C6D1;      ;
                       BCS CODE_83C6E7                      ;83C6D3;83C6E7;
                       LDA.B !tilemap_to_load                            ;83C6D5;000022;
                       CMP.B #$15                           ;83C6D7;      ;
                       BCS CODE_83C6DE                      ;83C6D9;83C6DE;
                       JMP.W CODE_83C734                    ;83C6DB;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6DE: CMP.B #$18                           ;83C6DE;      ;
                       BCC CODE_83C6E5                      ;83C6E0;83C6E5;
                       JMP.W CODE_83C734                    ;83C6E2;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6E5: BRA CODE_83C709                      ;83C6E5;83C709;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6E7: %Set8bit(!M)                             ;83C6E7;      ;
                       LDA.L !dog_map                        ;83C6E9;7F1F30;
                       CMP.B #$31                           ;83C6ED;      ;
                       BCC CODE_83C6FC                      ;83C6EF;83C6FC;
                       LDA.B !tilemap_to_load                            ;83C6F1;000022;
                       CMP.B #$31                           ;83C6F3;      ;
                       BCS CODE_83C6FA                      ;83C6F5;83C6FA;
                       JMP.W CODE_83C734                    ;83C6F7;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6FA: BRA CODE_83C709                      ;83C6FA;83C709;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C6FC: %Set8bit(!M)                             ;83C6FC;      ;
                       LDA.L !dog_map                        ;83C6FE;7F1F30;
                       CMP.B !tilemap_to_load                            ;83C702;000022;
                       BEQ CODE_83C709                      ;83C704;83C709;
                       JMP.W CODE_83C734                    ;83C706;83C734;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C709: %Set16bit(!MX)                             ;83C709;      ;
                       LDA.L !dog_pos_X                        ;83C70B;7F1F2C;
                       STA.W !tile_in_front_X                          ;83C70F;000985;
                       LDA.L !dog_pos_Y                        ;83C712;7F1F2E;
                       STA.W !tile_in_front_Y                          ;83C716;000987;
                       LDA.W #$0016                         ;83C719;      ;
                       LDX.W #$0000                         ;83C71C;      ;
                       LDY.W #$0011                         ;83C71F;      ;
                       JSL.L CODE_8480F8                    ;83C722;8480F8;
                       %Set16bit(!M)                             ;83C726;      ;
                       LDA.W #$0001                         ;83C728;      ;
                       STA.L $7F1F58                        ;83C72B;7F1F58;
                       %Set8bit(!M)                             ;83C72F;      ;
                       STZ.W $0938                          ;83C731;000938;
                                                            ;      ;      ;
          CODE_83C734: %Set16bit(!MX)                             ;83C734;      ;
                       LDA.L $7F1F68                        ;83C736;7F1F68;
                       AND.W #$0100                         ;83C73A;      ;
                       BNE CODE_83C742                      ;83C73D;83C742;
                       JMP.W CODE_83C806                    ;83C73F;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C742: LDA.B !game_state                            ;83C742;0000D2;
                       AND.W #$0010                         ;83C744;      ;
                       BEQ CODE_83C74C                      ;83C747;83C74C;
                       JMP.W CODE_83C806                    ;83C749;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C74C: %Set8bit(!M)                             ;83C74C;      ;
                       LDA.L $7F1F31                        ;83C74E;7F1F31;
                       CMP.B #$04                           ;83C752;      ;
                       BCS CODE_83C761                      ;83C754;83C761;
                       LDA.B !tilemap_to_load                            ;83C756;000022;
                       CMP.B #$04                           ;83C758;      ;
                       BCC CODE_83C75F                      ;83C75A;83C75F;
                       JMP.W CODE_83C806                    ;83C75C;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C75F: BRA CODE_83C7D7                      ;83C75F;83C7D7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C761: %Set8bit(!M)                             ;83C761;      ;
                       LDA.L $7F1F31                        ;83C763;7F1F31;
                       CMP.B #$08                           ;83C767;      ;
                       BCS CODE_83C77D                      ;83C769;83C77D;
                       LDA.B !tilemap_to_load                            ;83C76B;000022;
                       CMP.B #$04                           ;83C76D;      ;
                       BCS CODE_83C774                      ;83C76F;83C774;
                       JMP.W CODE_83C806                    ;83C771;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C774: CMP.B #$08                           ;83C774;      ;
                       BCC CODE_83C77B                      ;83C776;83C77B;
                       JMP.W CODE_83C806                    ;83C778;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C77B: BRA CODE_83C7D7                      ;83C77B;83C7D7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C77D: %Set8bit(!M)                             ;83C77D;      ;
                       LDA.L $7F1F31                        ;83C77F;7F1F31;
                       CMP.B #$10                           ;83C783;      ;
                       BCS CODE_83C799                      ;83C785;83C799;
                       LDA.B !tilemap_to_load                            ;83C787;000022;
                       CMP.B #$0C                           ;83C789;      ;
                       BCS CODE_83C790                      ;83C78B;83C790;
                       JMP.W CODE_83C806                    ;83C78D;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C790: CMP.B #$10                           ;83C790;      ;
                       BCC CODE_83C797                      ;83C792;83C797;
                       JMP.W CODE_83C806                    ;83C794;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C797: BRA CODE_83C7D7                      ;83C797;83C7D7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C799: %Set8bit(!M)                             ;83C799;      ;
                       LDA.L $7F1F31                        ;83C79B;7F1F31;
                       CMP.B #$14                           ;83C79F;      ;
                       BCS CODE_83C7B5                      ;83C7A1;83C7B5;
                       LDA.B !tilemap_to_load                            ;83C7A3;000022;
                       CMP.B #$10                           ;83C7A5;      ;
                       BCS CODE_83C7AC                      ;83C7A7;83C7AC;
                       JMP.W CODE_83C806                    ;83C7A9;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C7AC: CMP.B #$14                           ;83C7AC;      ;
                       BCC CODE_83C7B3                      ;83C7AE;83C7B3;
                       JMP.W CODE_83C806                    ;83C7B0;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C7B3: BRA CODE_83C7D7                      ;83C7B3;83C7D7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C7B5: %Set8bit(!M)                             ;83C7B5;      ;
                       LDA.L $7F1F31                        ;83C7B7;7F1F31;
                       CMP.B #$31                           ;83C7BB;      ;
                       BCC CODE_83C7CA                      ;83C7BD;83C7CA;
                       LDA.B !tilemap_to_load                            ;83C7BF;000022;
                       CMP.B #$31                           ;83C7C1;      ;
                       BCS CODE_83C7C8                      ;83C7C3;83C7C8;
                       JMP.W CODE_83C806                    ;83C7C5;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C7C8: BRA CODE_83C7D7                      ;83C7C8;83C7D7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C7CA: %Set8bit(!M)                             ;83C7CA;      ;
                       LDA.L $7F1F31                        ;83C7CC;7F1F31;
                       CMP.B !tilemap_to_load                            ;83C7D0;000022;
                       BEQ CODE_83C7D7                      ;83C7D2;83C7D7;
                       JMP.W CODE_83C806                    ;83C7D4;83C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83C7D7: %Set16bit(!MX)                             ;83C7D7;      ;
                       LDA.W #$0110                         ;83C7D9;      ;
                       STA.W !tile_in_front_X                          ;83C7DC;000985;
                       LDA.W #$0140                         ;83C7DF;      ;
                       STA.W !tile_in_front_Y                          ;83C7E2;000987;
                       LDY.W #$0013                         ;83C7E5;      ;
                       %Set8bit(!M)                             ;83C7E8;      ;
                       LDA.L $7F1F32                        ;83C7EA;7F1F32;
                       CMP.B #$15                           ;83C7EE;      ;
                       BNE CODE_83C7F5                      ;83C7F0;83C7F5;
                       LDY.W #$0010                         ;83C7F2;      ;
                                                            ;      ;      ;
          CODE_83C7F5: %Set16bit(!MX)                             ;83C7F5;      ;
                       LDA.W #$0017                         ;83C7F7;      ;
                       LDX.W #$0000                         ;83C7FA;      ;
                       JSL.L CODE_8480F8                    ;83C7FD;8480F8;
                       %Set8bit(!M)                             ;83C801;      ;
                       STZ.W $0939                          ;83C803;000939;
                                                            ;      ;      ;
          CODE_83C806: RTL                                  ;83C806;      ;


;;;;;;;; Param in A = 0: hatched; Return in A, 0 = sucess, 1 = coop full
AddNewChicken: ;83C807
        !chicken_pointer = $72
        !chicken_source = $7E

        %Set16bit(!MX)
        STA.B !chicken_source
        LDX.W #$0000

    .findSlot
      - %Set16bit(!MX)
        PHX
        TXA
        JSL.L GetChickenPointer
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        LDY.W #$0000
        LDA.B [!chicken_pointer],Y
        AND.B #$01                           ;exists flag
        BEQ .slotFound
        %Set16bit(!MX)
        INX
        CPX.W #13
        BNE .findSlot

    .slotFound:
        %Set8bit(!M)
        %Set16bit(!X)
        CPX.W #13
        BNE .slotValid
        JMP.W .fail

    .slotValid
        LDY.W #$0000

    .clearSlot
        %Set8bit(!M)
        LDA.B #$00
        STA.B [!chicken_pointer],Y
        INY
        CPY.W #$0008
        BNE .clearSlot

        %Set8bit(!M)
        LDY.W #$0001
        LDA.B #$28
        STA.B [!chicken_pointer],Y
        LDY.W #$0002
        LDA.B #$00
        STA.B [!chicken_pointer],Y
        %Set16bit(!M)
        LDA.B !chicken_source
        CMP.W #$0001
        BEQ .bought
        CMP.W #$0002
        BEQ .hatched
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B #$43
        STA.B [!chicken_pointer],Y
        %Set16bit(!MX)
        LDY.W #$0004
        LDA.W #$00E8
        STA.B [!chicken_pointer],Y           ;Spawn Position X
        LDY.W #$0006
        LDA.W #$00B8
        STA.B [!chicken_pointer],Y           ;Spawn Position Y
        BRA .newChickenSuccess

    .bought:
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B #$09
        STA.B [!chicken_pointer],Y
        BRA .bought_cont

    .hatched:
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B #$09
        STA.B [!chicken_pointer],Y
        LDY.W #$0001
        LDA.L !season
        CLC
        ADC.B #$04
        STA.B [!chicken_pointer],Y
        %Set16bit(!M)
        LDY.W #$0004
        LDA.W #$0238
        STA.B [!chicken_pointer],Y           ;Spawn Position X
        LDY.W #$0006
        LDA.W #$0318
        STA.B [!chicken_pointer],Y           ;Spawn Position Y
        BRA .newChickenSuccess

    .bought_cont:
        %Set16bit(!MX)
        TXA
        ASL A
        ASL A
        TAX
        LDY.W #$0004
        LDA.L Table_ChicketSpawnPos,X
        STA.B [!chicken_pointer],Y
        INX
        INX
        LDY.W #$0006
        LDA.L Table_ChicketSpawnPos,X
        STA.B [!chicken_pointer],Y

    .newChickenSuccess:
        %Set16bit(!M)
        LDA.W #$0000
        RTL

    .fail:
        %Set16bit(!MX)
        LDA.W #$0001
        RTL

;;;;;;;;
;;;;;;;;
;;;;;;;; Param in A, 0:Bought, 1:Born; Return in A, 0:sucess, 1:barn full
AddNewCow: ;83C8DC
        !cow_pointer = $72
        !cow_source = $7E

        %Set16bit(!MX)
        STA.B !cow_source
        LDX.W #$0000

;check for an empty slot
      - %Set16bit(!MX)
        PHX
        TXA
        JSL.L GetsCowPointer
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        LDY.W #$0000
        LDA.B [!cow_pointer],Y
        AND.B #$01                           ;exists flag
        BEQ .slotFound
        %Set16bit(!MX)
        INX
        CPX.W #12
        BNE -

    .slotFound:
        %Set8bit(!M)
        %Set16bit(!X)
        CPX.W #12
        BNE .slotValid
        JMP.W .fail

    .slotValid:
        LDY.W #$0000

    .clearSlot
        LDA.B #$00
        STA.B [!cow_pointer],Y
        INY
        CPY.W #$0010
        BNE .clearSlot

        %Set8bit(!M)
        LDY.W #$0002
        LDA.B #$27
        STA.B [!cow_pointer],Y
        LDY.W #$0003
        LDA.B #$00
        STA.B [!cow_pointer],Y               ;Pregnancy
        LDY.W #$0004
        LDA.B #$00
        STA.B [!cow_pointer],Y               ;Happiness
        LDY.W #$0005
        LDA.B #$00
        STA.B [!cow_pointer],Y
        %Set8bit(!M)
        LDY.W #$0001
        LDA.B #$00
        STA.B [!cow_pointer],Y
        %Set8bit(!M)
        LDY.W #$0000
        LDA.B #$05                           ;Child Cow, exists
        STA.B [!cow_pointer],Y               ;Cow Status
        %Set16bit(!M)

        LDA.B !cow_source
        BEQ .bought

        %Set8bit(!M)
        LDY.W #$0000
        LDA.B #$03                           ;Baby Cow
        STA.B [!cow_pointer],Y               ;Cow Status
        %Set8bit(!M)
        LDY.W #$0004
        LDA.L $7F1F2B                        ;
        STA.B [!cow_pointer],Y               ;Happiness
        %Set16bit(!MX)
        LDA.W #70
        JSL.L AddPlayerHappiness
        %Set16bit(!MX)

    .bought:
        %Set16bit(!MX)
        TXA
        ASL A
        ASL A
        TAX
        LDY.W #$0008
        LDA.L Table_CowsSpawnPos,X
        STA.B [!cow_pointer],Y               ;Barn Position X
        INX
        INX
        LDY.W #$000A
        LDA.L Table_CowsSpawnPos,X
        STA.B [!cow_pointer],Y               ;Barn Position Y

        %Set16bit(!M)
        LDA.W #$0000
        RTL                                  ;Success

        .fail:
        %Set16bit(!MX)
        LDA.W #$0001
        RTL

;;;;;;;; Simple function, returns a pointer to the ram address that holds the data for
;;;;;;;; a chicken slot in A. Each chiken slot is size 8 bits
;;;;;;;; Params: A = Inxed, Return: $72 = long pointer
GetChickenPointer: ;83C995
        %Set16bit(!MX)
        ASL A
        ASL A
        ASL A
        CLC
        ADC.W #$C286                         ;pointer to chicken data
        STA.B $72
        %Set8bit(!M)
        LDA.B #$7E
        STA.B $74
        RTL

;;;;;;;; Simple function, returns a pointer to the ram address that holds the data for
;;;;;;;; a cow slot in A. Each cow slots is size 16 bits
;;;;;;;; Params: A = Inxed, Return: $72 = long pointer
GetsCowPointer: ;83C9A7
        %Set16bit(!MX)
        ASL A
        ASL A
        ASL A
        ASL A
        CLC
        ADC.W #$C1C6                         ;pointer to cow data
        STA.B $72
        %Set8bit(!M)
        LDA.B #$7E
        STA.B $74
        RTL


;;;;;;;; this bunch of code seems to be unused, they just look to see
;;;;;;;; if the barn or coop are filled, code very... "beta"
UnusedBarnCoopCheck: ;83C9BA
        LDX.W #$0000                         ;83C9BA;      ;
        LDY.W #$0000                         ;83C9BD;      ;

    .coopcheck: ;83C9C0
        %Set16bit(!MX)
        PHY
        PHX
        TXA
        JSL.L GetChickenPointer
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        LDY.W #$0000
        LDA.B [$72],Y
        PLY
        AND.B #$01
        BEQ .skip1
        INY

    .skip1:
        %Set16bit(!MX)
        INX
        CPX.W #$000D
        BNE .coopcheck
        %Set16bit(!M)
        TYA
        RTL

        LDX.W #$0000
        LDY.W #$0000

    .barncheck:
        %Set16bit(!MX)
        PHY
        PHX
        TXA
        JSL.L GetsCowPointer
        %Set8bit(!M)
        %Set16bit(!X)
        PLX
        LDY.W #$0000
        LDA.B [$72],Y
        PLY
        AND.B #$01
        BEQ .skip2
        INY

    .skip2:
        %Set16bit(!MX)
        INX
        CPX.W #$000C
        BNE .barncheck
        %Set16bit(!M)
        TYA
        RTL


Table_ChicketSpawnPos: dw $0018,$0048,$0038,$0058,$0048,$0098,$0058,$0078;83CA10;      ;
                       dw $0068,$00A8,$0078,$0088,$0088,$0058,$0098,$0098;83CA20;      ;
                       dw $00A8,$0078,$00B8,$00A8,$00C8,$0068,$00D8,$0088;83CA30;      ;
                       dw $0028,$00A8                       ;83CA40;      ;

   Table_CowsSpawnPos: dw $00A8,$0116,$00A8,$00F6,$00A8,$00D6,$00A8,$0096;83CA44;      ;
                       dw $00A8,$0076,$00A8,$0056,$0038,$0116,$0038,$00F6;83CA54;      ;
                       dw $0038,$00D6,$0038,$0096,$0038,$0076,$0038,$0056;83CA64;      ;
                       db $D8,$00,$58,$01                   ;83CA74;      ;
         DATA8_83CA78: db $01,$00,$02,$00,$04,$00,$08,$00,$10,$00,$20,$00,$40,$00,$80,$00;83CA78;      ;
                       db $00,$01,$00,$02,$00,$04,$00,$08,$00,$10,$00,$20,$00,$40,$00,$80;83CA88;      ;
                                                            ;      ;      ;
  RunsFunctionbyIndex: %Set8bit(!M)                             ;83CA98;      ;Param $22
                       %Set16bit(!X)                             ;83CA9A;      ;
                       LDA.B #$00                           ;83CA9C;      ;
                       XBA                                  ;83CA9E;      ;
                       LDA.B !tilemap_to_load                            ;83CA9F;000022;
                       %Set16bit(!M)                             ;83CAA1;      ;
                       ASL A                                ;83CAA3;      ;
                       TAX                                  ;83CAA4;      ;
                       JSR.W (UNK_TableFunctionSelect,X)    ;83CAA5;83CAA9;
                       RTL                                  ;83CAA8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
UNK_TableFunctionSelect: dw $CB69,$CB69,$CB69,$CB69,$D2E0,$D2E0,$D2E0,$D2E0;83CAA9;      ;
                       dw $E5DF,$E5F1,$E603,$E6B2,$E407,$E407,$E407,$E407;83CAB9;      ;
                       dw $DC4A,$DC4A,$DC4A,$DC4A,$E661,$DED3,$DED3,$DED3;83CAC9;      ;
                       dw $D4D7,$D4D7,$D5E7,$D613,$D74E,$D818,$DB8F,$DC1E;83CAD9;      ;
                       dw $D955,$DA1F,$D844,$D929,$DAED,$DA4B,$E6C4,$DE9B;83CAE9;      ;
                       dw $E5B4,$E4CB,$DE64,$DD95,$E5A2,$E5CD,$E5CD,$E5CD;83CAF9;      ;
                       dw $E5CD,$E586,$E586,$E586,$E586,$E586,$E586,$E586;83CB09;      ;
                       dw $E586,$E632,$E690,$E74C,$E76D,$EBA6,$E74C,$E74C;83CB19;      ;
                       dw $E74C,$E74C,$E74C,$E74C,$E74C,$E74C,$E74C,$E74C;83CB29;      ;
                       dw $E74C,$E74C,$E74C,$EBA6,$E74C,$E74C,$E74C,$E74C;83CB39;      ;
                       dw $E74C,$E74C,$E74C,$E74C,$E74C,$E74C,$E74C,$E74C;83CB49;      ;
                       dw $E74C,$E74C,$E74C,$E74C,$E74C,$E74C,$E74C,$E74C;83CB59;      ;
                                                            ;      ;      ;
      UNK_FuncInTable: %Set16bit(!MX)                             ;83CB69;      ;
                       LDA.L $7F1F6E                        ;83CB6B;7F1F6E;
                       AND.W #$0002                         ;83CB6F;      ;
                       BNE CODE_83CBC4                      ;83CB72;83CBC4;
                       LDA.L $7F1F66                        ;83CB74;7F1F66;
                       AND.W #$0001                         ;83CB78;      ;
                       BNE CODE_83CB91                      ;83CB7B;83CB91;
                       LDA.L $7F1F66                        ;83CB7D;7F1F66;
                       AND.W #$0004                         ;83CB81;      ;
                       BNE CODE_83CBA2                      ;83CB84;83CBA2;
                       LDA.L $7F1F66                        ;83CB86;7F1F66;
                       AND.W #$0008                         ;83CB8A;      ;
                       BNE CODE_83CBB3                      ;83CB8D;83CBB3;
                       BRA CODE_83CBC4                      ;83CB8F;83CBC4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CB91: %Set16bit(!MX)                             ;83CB91;      ;
                       LDA.W #$0013                         ;83CB93;      ;
                       LDX.W #$0044                         ;83CB96;      ;
                       LDY.W #$0000                         ;83CB99;      ;
                       JSL.L VIP                            ;83CB9C;848097;
                       BRA CODE_83CBC4                      ;83CBA0;83CBC4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CBA2: %Set16bit(!MX)                             ;83CBA2;      ;
                       LDA.W #$0013                         ;83CBA4;      ;
                       LDX.W #$0044                         ;83CBA7;      ;
                       LDY.W #$0002                         ;83CBAA;      ;
                       JSL.L VIP                            ;83CBAD;848097;
                       BRA CODE_83CBC4                      ;83CBB1;83CBC4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CBB3: %Set16bit(!MX)                             ;83CBB3;      ;
                       LDA.W #$0013                         ;83CBB5;      ;
                       LDX.W #$0044                         ;83CBB8;      ;
                       LDY.W #$0003                         ;83CBBB;      ;
                       JSL.L VIP                            ;83CBBE;848097;
                       BRA CODE_83CBC4                      ;83CBC2;83CBC4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CBC4: %Set16bit(!MX)                             ;83CBC4;      ;
                       LDA.L $7F1F6E                        ;83CBC6;7F1F6E;
                       AND.W #$0004                         ;83CBCA;      ;
                       BEQ CODE_83CBE7                      ;83CBCD;83CBE7;
                       LDA.L !kid1_age                        ;83CBCF;7F1F37;
                       CMP.W #$003C                         ;83CBD3;      ;
                       BCC CODE_83CBE7                      ;83CBD6;83CBE7;
                       %Set16bit(!MX)                             ;83CBD8;      ;
                       LDA.W #$0014                         ;83CBDA;      ;
                       LDX.W #$0045                         ;83CBDD;      ;
                       LDY.W #$0001                         ;83CBE0;      ;
                       JSL.L VIP                            ;83CBE3;848097;
                                                            ;      ;      ;
          CODE_83CBE7: %Set16bit(!MX)                             ;83CBE7;      ;
                       LDA.L $7F1F6E                        ;83CBE9;7F1F6E;
                       AND.W #$0008                         ;83CBED;      ;
                       BEQ CODE_83CC0A                      ;83CBF0;83CC0A;
                       LDA.L !kid2_age                        ;83CBF2;7F1F39;
                       CMP.W #$003C                         ;83CBF6;      ;
                       BCC CODE_83CC0A                      ;83CBF9;83CC0A;
                       %Set16bit(!MX)                             ;83CBFB;      ;
                       LDA.W #$0015                         ;83CBFD;      ;
                       LDX.W #$0045                         ;83CC00;      ;
                       LDY.W #$0004                         ;83CC03;      ;
                       JSL.L VIP                            ;83CC06;848097;
                                                            ;      ;      ;
          CODE_83CC0A: %Set16bit(!MX)                             ;83CC0A;      ;
                       LDA.W $0196                          ;83CC0C;000196;
                       AND.W #$001A                         ;83CC0F;      ;
                       BEQ CODE_83CC17                      ;83CC12;83CC17;
                       JMP.W CODE_83CE5B                    ;83CC14;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC17: LDA.L $7F1F66                        ;83CC17;7F1F66;
                       AND.W #$0001                         ;83CC1B;      ;
                       BEQ CODE_83CC23                      ;83CC1E;83CC23;
                       JMP.W CODE_83CE5B                    ;83CC20;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC23: LDA.L $7F1F66                        ;83CC23;7F1F66;
                       AND.W #$0002                         ;83CC27;      ;
                       BEQ CODE_83CC2F                      ;83CC2A;83CC2F;
                       JMP.W CODE_83CE5B                    ;83CC2C;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC2F: LDA.L $7F1F66                        ;83CC2F;7F1F66;
                       AND.W #$0004                         ;83CC33;      ;
                       BEQ CODE_83CC3B                      ;83CC36;83CC3B;
                       JMP.W CODE_83CE5B                    ;83CC38;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC3B: LDA.L $7F1F66                        ;83CC3B;7F1F66;
                       AND.W #$0008                         ;83CC3F;      ;
                       BEQ CODE_83CC47                      ;83CC42;83CC47;
                       JMP.W CODE_83CE5B                    ;83CC44;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC47: LDA.L $7F1F66                        ;83CC47;7F1F66;
                       AND.W #$0010                         ;83CC4B;      ;
                       BEQ CODE_83CC53                      ;83CC4E;83CC53;
                       JMP.W CODE_83CE5B                    ;83CC50;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC53: %Set8bit(!M)                             ;83CC53;      ;
                       LDA.L !hour                        ;83CC55;7F1F1C;Hour
                       CMP.B #$06                           ;83CC59;      ;
                       BEQ CODE_83CC60                      ;83CC5B;83CC60;
                       JMP.W CODE_83CE5B                    ;83CC5D;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC60: LDA.L !minutes                        ;83CC60;7F1F1D;Minutes
                       BEQ CODE_83CC69                      ;83CC64;83CC69;
                       JMP.W CODE_83CE5B                    ;83CC66;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC69: LDA.L !seconds                        ;83CC69;7F1F1E;
                       BEQ CODE_83CC72                      ;83CC6D;83CC72;
                       JMP.W CODE_83CE5B                    ;83CC6F;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC72: LDA.L !day                        ;83CC72;7F1F1B;Day Number
                       CMP.B #$01                           ;83CC76;      ;
                       BNE CODE_83CC7D                      ;83CC78;83CC7D;
                       JMP.W CODE_83CE5B                    ;83CC7A;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC7D: CMP.B #$08                           ;83CC7D;      ;
                       BCC CODE_83CC9A                      ;83CC7F;83CC9A;
                       CMP.B #$0D                           ;83CC81;      ;
                       BCS CODE_83CC88                      ;83CC83;83CC88;
                       JMP.W CODE_83CE5B                    ;83CC85;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC88: CMP.B #$12                           ;83CC88;      ;
                       BCC CODE_83CC9A                      ;83CC8A;83CC9A;
                       CMP.B #$19                           ;83CC8C;      ;
                       BCS CODE_83CC93                      ;83CC8E;83CC93;
                       JMP.W CODE_83CE5B                    ;83CC90;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC93: CMP.B #$1D                           ;83CC93;      ;
                       BCC CODE_83CC9A                      ;83CC95;83CC9A;
                       JMP.W CODE_83CE5B                    ;83CC97;83CE5B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CC9A: %Set16bit(!M)                             ;83CC9A;      ;
                       LDA.L $7F1F66                        ;83CC9C;7F1F66;
                       AND.W #$0001                         ;83CCA0;      ;
                       BNE CODE_83CCE9                      ;83CCA3;83CCE9;
                       LDA.L $7F1F66                        ;83CCA5;7F1F66;
                       AND.W #$0080                         ;83CCA9;      ;
                       BNE CODE_83CCE9                      ;83CCAC;83CCE9;
                       LDA.L $7F1F6A                        ;83CCAE;7F1F6A;
                       AND.W #$2000                         ;83CCB2;      ;
                       BNE CODE_83CCE9                      ;83CCB5;83CCE9;
                       LDA.L $7F1F6A                        ;83CCB7;7F1F6A;
                       AND.W #$1000                         ;83CCBB;      ;
                       BNE CODE_83CCE9                      ;83CCBE;83CCE9;
                       LDA.L !hearts_maria                        ;83CCC0;7F1F1F;Hearts for Maria
                       CMP.W #$00C8                         ;83CCC4;      ;
                       BCC CODE_83CCE9                      ;83CCC7;83CCE9;
                       LDA.L $7F1F6A                        ;83CCC9;7F1F6A;
                       ORA.W #$1000                         ;83CCCD;      ;
                       STA.L $7F1F6A                        ;83CCD0;7F1F6A;
                       %Set16bit(!MX)                             ;83CCD4;      ;
                       LDA.W #$0000                         ;83CCD6;      ;
                       LDX.W #$0019                         ;83CCD9;      ;
                       LDY.W #$0000                         ;83CCDC;      ;
                       JSL.L VIP                            ;83CCDF;848097;
                       %Set8bit(!M)                             ;83CCE3;      ;
                       STZ.W $09A3                          ;83CCE5;0009A3;
                       RTS                                  ;83CCE8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CCE9: %Set16bit(!M)                             ;83CCE9;      ;
                       LDA.L $7F1F6A                        ;83CCEB;7F1F6A;
                       AND.W #$1000                         ;83CCEF;      ;
                       BNE CODE_83CD38                      ;83CCF2;83CD38;
                       LDA.L $7F1F66                        ;83CCF4;7F1F66;
                       AND.W #$0002                         ;83CCF8;      ;
                       BNE CODE_83CD38                      ;83CCFB;83CD38;
                       LDA.L $7F1F6A                        ;83CCFD;7F1F6A;
                       AND.W #$8000                         ;83CD01;      ;
                       BNE CODE_83CD38                      ;83CD04;83CD38;
                       LDA.L $7F1F6A                        ;83CD06;7F1F6A;
                       AND.W #$4000                         ;83CD0A;      ;
                       BNE CODE_83CD38                      ;83CD0D;83CD38;
                       LDA.L !hearts_ann                        ;83CD0F;7F1F21;Hearts for Ann
                       CMP.W #$00C8                         ;83CD13;      ;
                       BCC CODE_83CD38                      ;83CD16;83CD38;
                       LDA.L $7F1F6A                        ;83CD18;7F1F6A;
                       ORA.W #$4000                         ;83CD1C;      ;
                       STA.L $7F1F6A                        ;83CD1F;7F1F6A;
                       %Set16bit(!MX)                             ;83CD23;      ;
                       LDA.W #$0000                         ;83CD25;      ;
                       LDX.W #$001A                         ;83CD28;      ;
                       LDY.W #$0000                         ;83CD2B;      ;
                       JSL.L VIP                            ;83CD2E;848097;
                       %Set8bit(!M)                             ;83CD32;      ;
                       STZ.W $09A3                          ;83CD34;0009A3;
                       RTS                                  ;83CD37;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CD38: %Set16bit(!M)                             ;83CD38;      ;
                       LDA.L $7F1F6A                        ;83CD3A;7F1F6A;
                       AND.W #$1000                         ;83CD3E;      ;
                       BNE CODE_83CD90                      ;83CD41;83CD90;
                       LDA.L $7F1F6A                        ;83CD43;7F1F6A;
                       AND.W #$4000                         ;83CD47;      ;
                       BNE CODE_83CD90                      ;83CD4A;83CD90;
                       LDA.L $7F1F66                        ;83CD4C;7F1F66;
                       AND.W #$0004                         ;83CD50;      ;
                       BNE CODE_83CD90                      ;83CD53;83CD90;
                       LDA.L $7F1F6C                        ;83CD55;7F1F6C;
                       AND.W #$0002                         ;83CD59;      ;
                       BNE CODE_83CD90                      ;83CD5C;83CD90;
                       LDA.L $7F1F6C                        ;83CD5E;7F1F6C;
                       AND.W #$0001                         ;83CD62;      ;
                       BNE CODE_83CD90                      ;83CD65;83CD90;
                       LDA.L !hearts_nina                        ;83CD67;7F1F23;Hearts for Nina
                       CMP.W #$00C8                         ;83CD6B;      ;
                       BCC CODE_83CD90                      ;83CD6E;83CD90;
                       LDA.L $7F1F6C                        ;83CD70;7F1F6C;
                       ORA.W #$0001                         ;83CD74;      ;
                       STA.L $7F1F6C                        ;83CD77;7F1F6C;
                       %Set16bit(!MX)                             ;83CD7B;      ;
                       LDA.W #$0000                         ;83CD7D;      ;
                       LDX.W #$001B                         ;83CD80;      ;
                       LDY.W #$0000                         ;83CD83;      ;
                       JSL.L VIP                            ;83CD86;848097;
                       %Set8bit(!M)                             ;83CD8A;      ;
                       STZ.W $09A3                          ;83CD8C;0009A3;
                       RTS                                  ;83CD8F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CD90: %Set16bit(!M)                             ;83CD90;      ;
                       LDA.L $7F1F6A                        ;83CD92;7F1F6A;
                       AND.W #$1000                         ;83CD96;      ;
                       BNE CODE_83CDF1                      ;83CD99;83CDF1;
                       LDA.L $7F1F6A                        ;83CD9B;7F1F6A;
                       AND.W #$4000                         ;83CD9F;      ;
                       BNE CODE_83CDF1                      ;83CDA2;83CDF1;
                       LDA.L $7F1F6C                        ;83CDA4;7F1F6C;
                       AND.W #$0001                         ;83CDA8;      ;
                       BNE CODE_83CDF1                      ;83CDAB;83CDF1;
                       LDA.L $7F1F66                        ;83CDAD;7F1F66;
                       AND.W #$0008                         ;83CDB1;      ;
                       BNE CODE_83CDF1                      ;83CDB4;83CDF1;
                       LDA.L $7F1F6C                        ;83CDB6;7F1F6C;
                       AND.W #$0008                         ;83CDBA;      ;
                       BNE CODE_83CDF1                      ;83CDBD;83CDF1;
                       LDA.L $7F1F6C                        ;83CDBF;7F1F6C;
                       AND.W #$0004                         ;83CDC3;      ;
                       BNE CODE_83CDF1                      ;83CDC6;83CDF1;
                       LDA.L !hearts_ellen                        ;83CDC8;7F1F25;Hearts for Ellen
                       CMP.W #$00C8                         ;83CDCC;      ;
                       BCC CODE_83CDF1                      ;83CDCF;83CDF1;
                       LDA.L $7F1F6C                        ;83CDD1;7F1F6C;
                       ORA.W #$0004                         ;83CDD5;      ;
                       STA.L $7F1F6C                        ;83CDD8;7F1F6C;
                       %Set16bit(!MX)                             ;83CDDC;      ;
                       LDA.W #$0000                         ;83CDDE;      ;
                       LDX.W #$001C                         ;83CDE1;      ;
                       LDY.W #$0000                         ;83CDE4;      ;
                       JSL.L VIP                            ;83CDE7;848097;
                       %Set8bit(!M)                             ;83CDEB;      ;
                       STZ.W $09A3                          ;83CDED;0009A3;
                       RTS                                  ;83CDF0;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CDF1: %Set16bit(!M)                             ;83CDF1;      ;
                       LDA.L $7F1F6A                        ;83CDF3;7F1F6A;
                       AND.W #$1000                         ;83CDF7;      ;
                       BNE CODE_83CE5B                      ;83CDFA;83CE5B;
                       LDA.L $7F1F6A                        ;83CDFC;7F1F6A;
                       AND.W #$4000                         ;83CE00;      ;
                       BNE CODE_83CE5B                      ;83CE03;83CE5B;
                       LDA.L $7F1F6C                        ;83CE05;7F1F6C;
                       AND.W #$0001                         ;83CE09;      ;
                       BNE CODE_83CE5B                      ;83CE0C;83CE5B;
                       LDA.L $7F1F6C                        ;83CE0E;7F1F6C;
                       AND.W #$0004                         ;83CE12;      ;
                       BNE CODE_83CE5B                      ;83CE15;83CE5B;
                       LDA.L $7F1F66                        ;83CE17;7F1F66;
                       AND.W #$0010                         ;83CE1B;      ;
                       BNE CODE_83CE5B                      ;83CE1E;83CE5B;
                       LDA.L $7F1F6C                        ;83CE20;7F1F6C;
                       AND.W #$0020                         ;83CE24;      ;
                       BNE CODE_83CE5B                      ;83CE27;83CE5B;
                       LDA.L $7F1F6C                        ;83CE29;7F1F6C;
                       AND.W #$0010                         ;83CE2D;      ;
                       BNE CODE_83CE5B                      ;83CE30;83CE5B;
                       LDA.L !hearts_eve                        ;83CE32;7F1F27;Hearts for Eve
                       CMP.W #$00C8                         ;83CE36;      ;
                       BCC CODE_83CE5B                      ;83CE39;83CE5B;
                       LDA.L $7F1F6C                        ;83CE3B;7F1F6C;
                       ORA.W #$0010                         ;83CE3F;      ;
                       STA.L $7F1F6C                        ;83CE42;7F1F6C;
                       %Set16bit(!MX)                             ;83CE46;      ;
                       LDA.W #$0000                         ;83CE48;      ;
                       LDX.W #$001D                         ;83CE4B;      ;
                       LDY.W #$0000                         ;83CE4E;      ;
                       JSL.L VIP                            ;83CE51;848097;
                       %Set8bit(!M)                             ;83CE55;      ;
                       STZ.W $09A3                          ;83CE57;0009A3;
                       RTS                                  ;83CE5A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CE5B: %Set16bit(!MX)                             ;83CE5B;      ;
                       LDA.L $7F1F5A                        ;83CE5D;7F1F5A;
                       AND.W #$0002                         ;FLAG5A
                       BEQ CODE_83CE93                      ;83CE64;83CE93;
                       %Set16bit(!M)                             ;83CE66;      ;
                       LDA.W #$0007                         ;83CE68;      ;
                       LDX.W #$0000                         ;83CE6B;      ;
                       LDY.W #$0020                         ;83CE6E;      ;
                       JSL.L VIP                            ;83CE71;848097;
                       %Set8bit(!M)                             ;83CE75;      ;
                       LDA.B #$42                           ;83CE77;      ;
                       STA.W $096E                          ;83CE79;00096E;
                       STZ.W $096F                          ;83CE7C;00096F;
                       STZ.W $0970                          ;83CE7F;000970;
                       %Set16bit(!MX)                             ;83CE82;      ;
                       LDA.B !game_state                            ;83CE84;0000D2;
                       ORA.W #$0040                         ;83CE86;      ;
                       STA.B !game_state                            ;83CE89;0000D2;
                       %Set16bit(!MX)                             ;83CE8B;      ;
                       LDA.W #$0000                         ;83CE8D;      ;
                       STA.B !player_action                            ;83CE90;0000D4;
                       RTS                                  ;83CE92;      ;END_UNK_FuncInTable
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CE93: %Set16bit(!MX)                             ;83CE93;      ;
                       LDA.L $7F1F68                        ;83CE95;7F1F68;
                       AND.W #$0001                         ;83CE99;      ;
                       BNE CODE_83CEAE                      ;83CE9C;83CEAE;
                       %Set16bit(!MX)                             ;83CE9E;      ;
                       LDA.W #$0000                         ;83CEA0;      ;
                       LDX.W #$000A                         ;83CEA3;      ;
                       LDY.W #$0002                         ;83CEA6;      ;
                       JSL.L VIP                            ;83CEA9;848097;
                       RTS                                  ;83CEAD;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CEAE: %Set16bit(!MX)                             ;83CEAE;      ;
                       LDA.L $7F1F68                        ;83CEB0;7F1F68;
                       AND.W #$0020                         ;83CEB4;      ;
                       BNE CODE_83CEDD                      ;83CEB7;83CEDD;
                       %Set16bit(!MX)                             ;83CEB9;      ;
                       LDA.W #$0000                         ;83CEBB;      ;
                       LDX.W #$000C                         ;83CEBE;      ;
                       LDY.W #$0000                         ;83CEC1;      ;
                       JSL.L VIP                            ;83CEC4;848097;
                       %Set16bit(!M)                             ;83CEC8;      ;
                       LDA.L $7F1F68                        ;83CECA;7F1F68;
                       ORA.W #$0020                         ;83CECE;      ;
                       STA.L $7F1F68                        ;83CED1;7F1F68;
                       %Set8bit(!M)                             ;83CED5;      ;
                       LDA.B #$03                           ;83CED7;      ;
                       STA.W $099F                          ;83CED9;00099F;
                       RTS                                  ;83CEDC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CEDD: %Set16bit(!MX)                             ;83CEDD;      ;
                       LDA.L $7F1F68                        ;83CEDF;7F1F68;
                       AND.W #$0080                         ;83CEE3;      ;
                       BNE CODE_83CF10                      ;83CEE6;83CF10;
                       %Set16bit(!MX)                             ;83CEE8;      ;
                       LDA.W #$0000                         ;83CEEA;      ;
                       LDX.W #$000C                         ;83CEED;      ;
                       LDY.W #$0001                         ;83CEF0;      ;
                       JSL.L VIP                            ;83CEF3;848097;
                       %Set16bit(!M)                             ;83CEF7;      ;
                       LDA.W #$0078                         ;83CEF9;      ;
                       STA.L !dog_pos_X                        ;83CEFC;7F1F2C;
                       LDA.W #$01A8                         ;83CF00;      ;
                       STA.L !dog_pos_Y                        ;83CF03;7F1F2E;
                       %Set8bit(!M)                             ;83CF07;      ;
                       LDA.B #$00                           ;83CF09;      ;
                       STA.L !dog_map                        ;83CF0B;7F1F30;
                       RTS                                  ;83CF0F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CF10: %Set8bit(!M)                             ;83CF10;      ;
                       %Set16bit(!X)                             ;83CF12;      ;
                       LDA.W !weather_tomorrow                          ;83CF14;00098C;
                       CMP.B #$06                           ;83CF17;      ;
                       BCC CODE_83CF42                      ;83CF19;83CF42;
                       LDA.L !hour                        ;83CF1B;7F1F1C;
                       CMP.B #$06                           ;83CF1F;      ;
                       BNE CODE_83CF42                      ;83CF21;83CF42;
                       LDA.L !minutes                        ;83CF23;7F1F1D;
                       BNE CODE_83CF42                      ;83CF27;83CF42;
                       LDA.L !seconds                        ;83CF29;7F1F1E;
                       BEQ CODE_83CF32                      ;83CF2D;83CF32;
                       JMP.W CODE_83CFF8                    ;83CF2F;83CFF8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CF32: %Set16bit(!MX)                             ;83CF32;      ;
                       LDA.W #$0006                         ;83CF34;      ;
                       LDX.W #$0024                         ;83CF37;      ;
                       LDY.W #$0000                         ;83CF3A;      ;
                       JSL.L VIP                            ;83CF3D;848097;
                       RTS                                  ;83CF41;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CF42: %Set16bit(!MX)                             ;83CF42;      ;
                       LDA.L $7F1F70                        ;83CF44;7F1F70;
                       AND.W #$0002                         ;83CF48;      ;
                       BEQ CODE_83CF73                      ;83CF4B;83CF73;
                       %Set8bit(!M)                             ;83CF4D;      ;
                       LDA.L !hour                        ;83CF4F;7F1F1C;
                       CMP.B #$06                           ;83CF53;      ;
                       BNE CODE_83CF73                      ;83CF55;83CF73;
                       LDA.L !minutes                        ;83CF57;7F1F1D;
                       BNE CODE_83CF73                      ;83CF5B;83CF73;
                       LDA.L !seconds                        ;83CF5D;7F1F1E;
                       BNE CODE_83CF73                      ;83CF61;83CF73;
                       %Set16bit(!MX)                             ;83CF63;      ;
                       LDA.W #$0006                         ;83CF65;      ;
                       LDX.W #$0024                         ;83CF68;      ;
                       LDY.W #$0002                         ;83CF6B;      ;
                       JSL.L VIP                            ;83CF6E;848097;
                       RTS                                  ;83CF72;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CF73: %Set16bit(!MX)                             ;83CF73;      ;
                       LDA.L $7F1F64                        ;83CF75;7F1F64;
                       AND.W #$0010                         ;83CF79;      ;
                       BEQ CODE_83CFA4                      ;83CF7C;83CFA4;
                       %Set8bit(!M)                             ;83CF7E;      ;
                       LDA.L !hour                        ;83CF80;7F1F1C;
                       CMP.B #$06                           ;83CF84;      ;
                       BNE CODE_83CFA4                      ;83CF86;83CFA4;
                       LDA.L !minutes                        ;83CF88;7F1F1D;
                       BNE CODE_83CFA4                      ;83CF8C;83CFA4;
                       LDA.L !seconds                        ;83CF8E;7F1F1E;
                       BNE CODE_83CFA4                      ;83CF92;83CFA4;
                       %Set16bit(!MX)                             ;83CF94;      ;
                       LDA.W #$0006                         ;83CF96;      ;
                       LDX.W #$0024                         ;83CF99;      ;
                       LDY.W #$0003                         ;83CF9C;      ;
                       JSL.L VIP                            ;83CF9F;848097;
                       RTS                                  ;83CFA3;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CFA4: %Set16bit(!MX)                             ;83CFA4;      ;
                       LDA.L $7F1F70                        ;83CFA6;7F1F70;
                       AND.W #$0001                         ;83CFAA;      ;
                       BNE CODE_83CFF8                      ;83CFAD;83CFF8;
                       %Set8bit(!M)                             ;83CFAF;      ;
                       LDA.L !year                        ;83CFB1;7F1F18;
                       BNE CODE_83CFF8                      ;83CFB5;83CFF8;
                       LDA.L !season                        ;83CFB7;7F1F19;
                       CMP.B #$01                           ;83CFBB;      ;
                       BNE CODE_83CFF8                      ;83CFBD;83CFF8;
                       LDA.L !day                        ;83CFBF;7F1F1B;
                       CMP.B #$14                           ;83CFC3;      ;
                       BCS CODE_83CFF8                      ;83CFC5;83CFF8;
                       LDA.L !hour                        ;83CFC7;7F1F1C;
                       CMP.B #$06                           ;83CFCB;      ;
                       BNE CODE_83CFF8                      ;83CFCD;83CFF8;
                       LDA.L !minutes                        ;83CFCF;7F1F1D;
                       BNE CODE_83CFF8                      ;83CFD3;83CFF8;
                       LDA.L !seconds                        ;83CFD5;7F1F1E;
                       BNE CODE_83CFF8                      ;83CFD9;83CFF8;
                       %Set16bit(!M)                             ;83CFDB;      ;
                       LDA.L $7F1F70                        ;83CFDD;7F1F70;
                       ORA.W #$0001                         ;83CFE1;      ;
                       STA.L $7F1F70                        ;83CFE4;7F1F70;
                       %Set16bit(!MX)                             ;83CFE8;      ;
                       LDA.W #$000B                         ;83CFEA;      ;
                       LDX.W #$0024                         ;83CFED;      ;
                       LDY.W #$0001                         ;83CFF0;      ;
                       JSL.L VIP                            ;83CFF3;848097;
                       RTS                                  ;83CFF7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83CFF8: %Set16bit(!MX)                             ;83CFF8;      ;
                       LDA.L $7F1F66                        ;83CFFA;7F1F66;
                       AND.W #$0040                         ;83CFFE;      ;
                       BEQ CODE_83D03D                      ;83D001;83D03D;
                       %Set16bit(!M)                             ;83D003;      ;
                       LDA.W #$0009                         ;83D005;      ;
                       LDX.W #$0000                         ;83D008;      ;
                       LDY.W #$002C                         ;83D00B;      ;
                       JSL.L VIP                            ;83D00E;848097;
                       %Set8bit(!M)                             ;83D012;      ;
                       LDA.B #$47                           ;83D014;      ;
                       STA.W $096E                          ;83D016;00096E;
                       STZ.W $096F                          ;83D019;00096F;
                       STZ.W $0970                          ;83D01C;000970;
                       %Set16bit(!MX)                             ;83D01F;      ;
                       LDA.B !game_state                            ;83D021;0000D2;
                       ORA.W #$0040                         ;83D023;      ;
                       STA.B !game_state                            ;83D026;0000D2;
                       %Set16bit(!MX)                             ;83D028;      ;
                       LDA.W #$0000                         ;83D02A;      ;
                       STA.B !player_action                            ;83D02D;0000D4;
                       %Set16bit(!M)                             ;83D02F;      ;
                       LDA.L $7F1F66                        ;83D031;7F1F66;
                       AND.W #$FFBF                         ;83D035;      ;
                       STA.L $7F1F66                        ;83D038;7F1F66;
                       RTS                                  ;83D03C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D03D: %Set16bit(!MX)                             ;83D03D;      ;
                       LDA.L $7F1F66                        ;83D03F;7F1F66;
                       AND.W #$0080                         ;83D043;      ;
                       BEQ CODE_83D060                      ;83D046;83D060;
                       %Set8bit(!M)                             ;83D048;      ;
                       LDA.L !development_rate                        ;83D04A;7F1F35;
                       BEQ CODE_83D060                      ;83D04E;83D060;
                       %Set16bit(!MX)                             ;83D050;      ;
                       LDA.W #$0000                         ;83D052;      ;
                       LDX.W #$0000                         ;83D055;      ;
                       LDY.W #$002E                         ;83D058;      ;
                       JSL.L VIP                            ;83D05B;848097;
                       RTS                                  ;83D05F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D060: %Set16bit(!MX)                             ;83D060;      ;
                       LDA.L $7F1F66                        ;83D062;7F1F66;
                       AND.W #$0100                         ;83D066;      ;
                       BEQ CODE_83D0B2                      ;83D069;83D0B2;
                       LDA.L $7F1F66                        ;83D06B;7F1F66;
                       AND.W #$FEFF                         ;83D06F;      ;
                       STA.L $7F1F66                        ;83D072;7F1F66;
                       %Set16bit(!MX)                             ;83D076;      ;
                       LDA.W #$0009                         ;83D078;      ;
                       LDX.W #$0000                         ;83D07B;      ;
                       LDY.W #$0036                         ;83D07E;      ;
                       JSL.L VIP                            ;83D081;848097;
                       %Set16bit(!MX)                             ;83D085;      ;
                       LDA.W #$000A                         ;83D087;      ;
                       LDX.W #$0000                         ;83D08A;      ;
                       LDY.W #$0037                         ;83D08D;      ;
                       JSL.L VIP                            ;83D090;848097;
                       %Set8bit(!M)                             ;83D094;      ;
                       LDA.B #$48                           ;83D096;      ;
                       STA.W $096E                          ;83D098;00096E;
                       STZ.W $096F                          ;83D09B;00096F;
                       STZ.W $0970                          ;83D09E;000970;
                       %Set16bit(!MX)                             ;83D0A1;      ;
                       LDA.B !game_state                            ;83D0A3;0000D2;
                       ORA.W #$0040                         ;83D0A5;      ;
                       STA.B !game_state                            ;83D0A8;0000D2;
                       %Set16bit(!MX)                             ;83D0AA;      ;
                       LDA.W #$0000                         ;83D0AC;      ;
                       STA.B !player_action                            ;83D0AF;0000D4;
                       RTS                                  ;83D0B1;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D0B2: %Set16bit(!MX)                             ;83D0B2;      ;
                       LDA.L $7F1F64                        ;83D0B4;7F1F64;
                       AND.W #$0100                         ;83D0B8;      ;
                       BNE CODE_83D0FF                      ;83D0BB;83D0FF;
                       %Set8bit(!M)                             ;83D0BD;      ;
                       LDA.L $7F1F32                        ;83D0BF;7F1F32;
                       CMP.B #$15                           ;83D0C3;      ;
                       BNE CODE_83D0FF                      ;83D0C5;83D0FF;
                       %Set16bit(!MX)                             ;83D0C7;      ;
                       LDA.L $7F1F64                        ;83D0C9;7F1F64;
                       ORA.W #$0100                         ;83D0CD;      ;
                       STA.L $7F1F64                        ;83D0D0;7F1F64;
                       LDA.W #$000B                         ;83D0D4;      ;
                       LDX.W #$0000                         ;83D0D7;      ;
                       LDY.W #$001D                         ;83D0DA;      ;
                       JSL.L VIP                            ;83D0DD;848097;
                       %Set8bit(!M)                             ;83D0E1;      ;
                       LDA.B #$49                           ;83D0E3;      ;
                       STA.W $096E                          ;83D0E5;00096E;
                       STZ.W $096F                          ;83D0E8;00096F;
                       STZ.W $0970                          ;83D0EB;000970;
                       %Set16bit(!MX)                             ;83D0EE;      ;
                       LDA.B !game_state                            ;83D0F0;0000D2;
                       ORA.W #$0040                         ;83D0F2;      ;
                       STA.B !game_state                            ;83D0F5;0000D2;
                       %Set16bit(!MX)                             ;83D0F7;      ;
                       LDA.W #$0000                         ;83D0F9;      ;
                       STA.B !player_action                            ;83D0FC;0000D4;
                       RTS                                  ;83D0FE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D0FF: %Set8bit(!M)                             ;83D0FF;      ;
                       %Set16bit(!X)                             ;83D101;      ;
                       LDA.L !year                        ;83D103;7F1F18;
                       BEQ CODE_83D163                      ;83D107;83D163;
                       LDA.L !hour                        ;83D109;7F1F1C;
                       CMP.W #$D006                         ;83D10D;      ;
                       EOR.B ($AF)                          ;83D110;0000AF;
                       ORA.W $7F1F,X                        ;83D112;007F1F;
                       BNE CODE_83D163                      ;83D115;83D163;
                       LDA.L !seconds                        ;83D117;7F1F1E;
                       BNE CODE_83D163                      ;83D11B;83D163;
                       %Set16bit(!M)                             ;83D11D;      ;
                       LDA.W $0196                          ;83D11F;000196;
                       AND.W #$001A                         ;83D122;      ;
                       BNE CODE_83D163                      ;83D125;83D163;
                       %Set16bit(!M)                             ;83D127;      ;
                       LDA.L !moneyL                        ;83D129;7F1F04;
                       CLC                                  ;83D12D;      ;
                       ADC.W #$F448                         ;83D12E;      ;
                       %Set8bit(!M)                             ;83D131;      ;
                       LDA.L !moneyH                        ;83D133;7F1F06;
                       ADC.B #$FF                           ;83D137;      ;
                       BMI CODE_83D163                      ;83D139;83D163;
                       %Set16bit(!MX)                             ;83D13B;      ;
                       LDA.L $7F1F68                        ;83D13D;7F1F68;
                       AND.W #$0400                         ;83D141;      ;
                       BNE CODE_83D163                      ;83D144;83D163;
                       %Set16bit(!MX)                             ;83D146;      ;
                       LDA.W #$0000                         ;83D148;      ;
                       LDX.W #$0013                         ;83D14B;      ;
                       LDY.W #$0000                         ;83D14E;      ;
                       JSL.L VIP                            ;83D151;848097;
                       %Set16bit(!M)                             ;83D155;      ;
                       LDA.L $7F1F68                        ;83D157;7F1F68;
                       ORA.W #$0400                         ;83D15B;      ;
                       STA.L $7F1F68                        ;83D15E;7F1F68;
                       RTS                                  ;83D162;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D163: %Set8bit(!M)                             ;83D163;      ;
                       %Set16bit(!X)                             ;83D165;      ;
                       LDA.L !year                        ;83D167;7F1F18;
                       BNE CODE_83D175                      ;83D16B;83D175;
                       LDA.L !season                        ;83D16D;7F1F19;
                       CMP.B #$03                           ;83D171;      ;
                       BNE CODE_83D1CE                      ;83D173;83D1CE;
                                                            ;      ;      ;
          CODE_83D175: %Set8bit(!M)                             ;83D175;      ;
                       LDA.L !hour                        ;83D177;7F1F1C;
                       CMP.B #$06                           ;83D17B;      ;
                       BNE CODE_83D1CE                      ;83D17D;83D1CE;
                       LDA.L !minutes                        ;83D17F;7F1F1D;
                       BNE CODE_83D1CE                      ;83D183;83D1CE;
                       LDA.L !seconds                        ;83D185;7F1F1E;
                       BNE CODE_83D1CE                      ;83D189;83D1CE;
                       LDA.L !weekday                        ;83D18B;7F1F1A;
                       CMP.B #$06                           ;83D18F;      ;
                       BNE CODE_83D1CE                      ;83D191;83D1CE;
                       %Set16bit(!M)                             ;83D193;      ;
                       LDA.W $0196                          ;83D195;000196;
                       AND.W #$001A                         ;83D198;      ;
                       BNE CODE_83D1CE                      ;83D19B;83D1CE;
                       %Set16bit(!MX)                             ;83D19D;      ;
                       LDA.L $7F1F64                        ;83D19F;7F1F64;
                       AND.W #$00C0                         ;83D1A3;      ;
                       BEQ CODE_83D1CE                      ;83D1A6;83D1CE;
                       %Set16bit(!MX)                             ;83D1A8;      ;
                       LDA.L $7F1F68                        ;83D1AA;7F1F68;
                       AND.W #$4000                         ;83D1AE;      ;
                       BNE CODE_83D1CE                      ;83D1B1;83D1CE;
                       LDA.L $7F1F68                        ;83D1B3;7F1F68;
                       ORA.W #$4000                         ;83D1B7;      ;
                       STA.L $7F1F68                        ;83D1BA;7F1F68;
                       %Set16bit(!MX)                             ;83D1BE;      ;
                       LDA.W #$0000                         ;83D1C0;      ;
                       LDX.W #$0016                         ;83D1C3;      ;
                       LDY.W #$0000                         ;83D1C6;      ;
                       JSL.L VIP                            ;83D1C9;848097;
                       RTS                                  ;83D1CD;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D1CE: %Set8bit(!M)                             ;83D1CE;      ;
                       %Set16bit(!X)                             ;83D1D0;      ;
                       LDA.L !season                        ;83D1D2;7F1F19;
                       CMP.B #$02                           ;83D1D6;      ;
                       BNE CODE_83D23E                      ;83D1D8;83D23E;
                       LDA.L !day                        ;83D1DA;7F1F1B;
                       CMP.B #$01                           ;83D1DE;      ;
                       BEQ CODE_83D23E                      ;83D1E0;83D23E;
                       CMP.B #$08                           ;83D1E2;      ;
                       BCC CODE_83D1F8                      ;83D1E4;83D1F8;
                       CMP.B #$0D                           ;83D1E6;      ;
                       BCC CODE_83D23E                      ;83D1E8;83D23E;
                       CMP.B #$12                           ;83D1EA;      ;
                       BCC CODE_83D1F8                      ;83D1EC;83D1F8;
                       CMP.B #$19                           ;83D1EE;      ;
                       BCC CODE_83D23E                      ;83D1F0;83D23E;
                       CMP.B #$1D                           ;83D1F2;      ;
                       BCC CODE_83D1F8                      ;83D1F4;83D1F8;
                       BRA CODE_83D23E                      ;83D1F6;83D23E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D1F8: %Set16bit(!M)                             ;83D1F8;      ;
                       LDA.W $0196                          ;83D1FA;000196;
                       AND.W #$001A                         ;83D1FD;      ;
                       BNE CODE_83D23E                      ;83D200;83D23E;
                       %Set16bit(!MX)                             ;83D202;      ;
                       LDA.L $7F1F64                        ;83D204;7F1F64;
                       AND.W #$00C0                         ;83D208;      ;
                       BEQ CODE_83D23E                      ;83D20B;83D23E;
                       %Set16bit(!MX)                             ;83D20D;      ;
                       LDA.L $7F1F68                        ;83D20F;7F1F68;
                       AND.W #$2000                         ;83D213;      ;
                       BEQ CODE_83D23E                      ;83D216;83D23E;
                       %Set16bit(!MX)                             ;83D218;      ;
                       LDA.L $7F1F6A                        ;83D21A;7F1F6A;
                       AND.W #$0100                         ;83D21E;      ;
                       BNE CODE_83D23E                      ;83D221;83D23E;
                       LDA.L $7F1F6A                        ;83D223;7F1F6A;
                       ORA.W #$0080                         ;83D227;      ;
                       STA.L $7F1F6A                        ;83D22A;7F1F6A;
                       %Set16bit(!MX)                             ;83D22E;      ;
                       LDA.W #$0000                         ;83D230;      ;
                       LDX.W #$0018                         ;83D233;      ;
                       LDY.W #$0000                         ;83D236;      ;
                       JSL.L VIP                            ;83D239;848097;
                       RTS                                  ;83D23D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D23E: %Set16bit(!MX)                             ;83D23E;      ;
                       LDA.L $7F1F6A                        ;83D240;7F1F6A;
                       AND.W #$0800                         ;83D244;      ;
                       BNE CODE_83D29E                      ;83D247;83D29E;
                       LDA.L $7F1F6A                        ;83D249;7F1F6A;
                       AND.W #$0400                         ;83D24D;      ;
                       BNE CODE_83D28E                      ;83D250;83D28E;
                       LDA.W $0196                          ;83D252;000196;
                       AND.W #$001E                         ;83D255;      ;
                       BNE CODE_83D29E                      ;83D258;83D29E;
                       LDA.L $7F1F6E                        ;83D25A;7F1F6E;
                       AND.W #$0400                         ;83D25E;      ;
                       BEQ CODE_83D29E                      ;83D261;83D29E;
                       %Set8bit(!M)                             ;83D263;      ;
                       LDA.L !chicks_N                        ;83D265;7F1F0B;
                       CMP.B #$06                           ;83D269;      ;
                       BCC CODE_83D29E                      ;83D26B;83D29E;
                       LDA.L !hour                        ;83D26D;7F1F1C;
                       CMP.B #$06                           ;83D271;      ;
                       BNE CODE_83D29E                      ;83D273;83D29E;
                       LDA.L !minutes                        ;83D275;7F1F1D;
                       BNE CODE_83D29E                      ;83D279;83D29E;
                       LDA.L !seconds                        ;83D27B;7F1F1E;
                       BNE CODE_83D29E                      ;83D27F;83D29E;
                       %Set16bit(!M)                             ;83D281;      ;
                       LDA.L $7F1F6A                        ;83D283;7F1F6A;
                       ORA.W #$0400                         ;83D287;      ;
                       STA.L $7F1F6A                        ;83D28A;7F1F6A;
                                                            ;      ;      ;
          CODE_83D28E: %Set16bit(!MX)                             ;83D28E;      ;
                       LDA.W #$0000                         ;83D290;      ;
                       LDX.W #$0029                         ;83D293;      ;
                       LDY.W #$0000                         ;83D296;      ;
                       JSL.L VIP                            ;83D299;848097;
                       RTS                                  ;83D29D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D29E: %Set16bit(!MX)                             ;83D29E;      ;
                       LDA.W $0196                          ;83D2A0;000196;
                       AND.W #$001A                         ;83D2A3;      ;
                       BNE CODE_83D2DF                      ;83D2A6;83D2DF;
                       %Set8bit(!M)                             ;83D2A8;      ;
                       LDA.L !hour                        ;83D2AA;7F1F1C;
                       CMP.B #$06                           ;83D2AE;      ;
                       BNE CODE_83D2DF                      ;83D2B0;83D2DF;
                       LDA.L !minutes                        ;83D2B2;7F1F1D;
                       BNE CODE_83D2DF                      ;83D2B6;83D2DF;
                       LDA.L !seconds                        ;83D2B8;7F1F1E;
                       BNE CODE_83D2DF                      ;83D2BC;83D2DF;
                       LDA.B #$08                           ;83D2BE;      ;
                       JSL.L RNGReturn0toA                  ;83D2C0;8089F9;
                       BNE CODE_83D2DF                      ;83D2C4;83D2DF;
                       %Set16bit(!MX)                             ;83D2C6;      ;
                       LDA.W #$0000                         ;83D2C8;      ;
                       LDX.W #$0023                         ;83D2CB;      ;
                       LDY.W #$0000                         ;83D2CE;      ;
                       JSL.L VIP                            ;83D2D1;848097;
                       %Set16bit(!MX)                             ;83D2D5;      ;
                       LDA.W #$0002                         ;83D2D7;      ;
                       JSL.L AddPlayerHappiness                   ;83D2DA;83B282;
                       RTS                                  ;83D2DE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D2DF: RTS                                  ;83D2DF;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D2E0;      ;
                       LDA.L $7F1F60                        ;83D2E2;7F1F60;
                       AND.W #$0400                         ;83D2E6;      ;
                       BEQ CODE_83D304                      ;83D2E9;83D304;
                       LDA.L $7F1F60                        ;83D2EB;7F1F60;
                       AND.W #$FBFF                         ;83D2EF;      ;
                       STA.B $60                            ;83D2F2;000060;
                       %Set16bit(!MX)                             ;83D2F4;      ;
                       LDA.W #$0000                         ;83D2F6;      ;
                       LDX.W #$0014                         ;83D2F9;      ;
                       LDY.W #$0003                         ;83D2FC;      ;
                       JSL.L VIP                            ;83D2FF;848097;
                       RTS                                  ;83D303;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D304: %Set8bit(!M)                             ;83D304;      ;
                       %Set16bit(!X)                             ;83D306;      ;
                       LDA.L !season                        ;83D308;7F1F19;
                       CMP.B #$02                           ;83D30C;      ;
                       BEQ CODE_83D313                      ;83D30E;83D313;
                       JMP.W CODE_83D3B8                    ;83D310;83D3B8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D313: LDA.L !day                        ;83D313;7F1F1B;
                       CMP.B #$14                           ;83D317;      ;
                       BEQ CODE_83D31E                      ;83D319;83D31E;
                       JMP.W CODE_83D3B8                    ;83D31B;83D3B8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D31E: LDA.L !hour                        ;83D31E;7F1F1C;
                       CMP.B #$0F                           ;83D322;      ;
                       BCC CODE_83D329                      ;83D324;83D329;
                       JMP.W CODE_83D3B8                    ;83D326;83D3B8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D329: %Set16bit(!MX)                             ;83D329;      ;
                       LDA.W #$0015                         ;83D32B;      ;
                       LDX.W #$0000                         ;83D32E;      ;
                       LDY.W #$007E                         ;83D331;      ;
                       JSL.L VIP                            ;83D334;848097;
                       %Set16bit(!M)                             ;83D338;      ;
                       STZ.B $7E                            ;83D33A;00007E;
                       %Set8bit(!M)                             ;83D33C;      ;
                       LDA.B #$00                           ;83D33E;      ;
                       STA.W $09A4                          ;83D340;0009A4;
                       LDA.B #$01                           ;83D343;      ;
                       STA.W $09A5                          ;83D345;0009A5;
                       LDA.B #$02                           ;83D348;      ;
                       STA.W $09A6                          ;83D34A;0009A6;
                       LDA.B #$03                           ;83D34D;      ;
                       STA.W $09A7                          ;83D34F;0009A7;
                       LDA.B #$04                           ;83D352;      ;
                       STA.W $09A8                          ;83D354;0009A8;
                       LDA.B #$05                           ;83D357;      ;
                       STA.W $09A9                          ;83D359;0009A9;
                       LDA.B #$00                           ;83D35C;      ;
                       STA.W $09AA                          ;83D35E;0009AA;
                       LDA.B #$00                           ;83D361;      ;
                       STA.W $09AB                          ;83D363;0009AB;
                       LDY.W #$0000                         ;83D366;      ;
                                                            ;      ;      ;
          CODE_83D369: %Set8bit(!M)                             ;83D369;      ;
                       %Set16bit(!X)                             ;83D36B;      ;
                       PHY                                  ;83D36D;      ;
                       TYX                                  ;83D36E;      ;
                       STY.B $84                            ;83D36F;000084;
                       LDA.W $09A4,X                        ;83D371;0009A4;
                       STA.B $95                            ;83D374;000095;
                       %Set8bit(!M)                             ;83D376;      ;
                       LDA.B #$08                           ;83D378;      ;
                       JSL.L RNGReturn0toA                  ;83D37A;8089F9;
                       %Set8bit(!M)                             ;83D37E;      ;
                       %Set16bit(!X)                             ;83D380;      ;
                       XBA                                  ;83D382;      ;
                       LDA.B #$00                           ;83D383;      ;
                       XBA                                  ;83D385;      ;
                       %Set16bit(!M)                             ;83D386;      ;
                       TAX                                  ;83D388;      ;
                       STX.B $86                            ;83D389;000086;
                       %Set8bit(!M)                             ;83D38B;      ;
                       LDA.W $09A4,X                        ;83D38D;0009A4;
                       LDX.B $84                            ;83D390;000084;
                       STA.W $09A4,X                        ;83D392;0009A4;
                       LDA.B $95                            ;83D395;000095;
                       LDX.B $86                            ;83D397;000086;
                       STA.W $09A4,X                        ;83D399;0009A4;
                       PLY                                  ;83D39C;      ;
                       INY                                  ;83D39D;      ;
                       CPY.W #$0007                         ;83D39E;      ;
                       BNE CODE_83D369                      ;83D3A1;83D369;
                       %Set8bit(!M)                             ;83D3A3;      ;
                       STZ.W $09A2                          ;83D3A5;0009A2;
                       %Set16bit(!MX)                             ;83D3A8;      ;
                       LDA.W #$0000                         ;83D3AA;      ;
                       LDX.W #$0028                         ;83D3AD;      ;
                       LDY.W #$0002                         ;83D3B0;      ;
                       JSL.L VIP                            ;83D3B3;848097;
                       RTS                                  ;83D3B7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D3B8: %Set8bit(!M)                             ;83D3B8;      ;
                       %Set16bit(!X)                             ;83D3BA;      ;
                       LDA.L !season                        ;83D3BC;7F1F19;
                       BNE CODE_83D3E2                      ;83D3C0;83D3E2;
                       LDA.L !day                        ;83D3C2;7F1F1B;
                       CMP.B #$17                           ;83D3C6;      ;
                       BNE CODE_83D3E2                      ;83D3C8;83D3E2;
                       LDA.L !hour                        ;83D3CA;7F1F1C;
                       CMP.B #$0F                           ;83D3CE;      ;
                       BCS CODE_83D3E2                      ;83D3D0;83D3E2;
                       %Set16bit(!MX)                             ;83D3D2;      ;
                       LDA.W #$0000                         ;83D3D4;      ;
                       LDX.W #$000E                         ;83D3D7;      ;
                       LDY.W #$0000                         ;83D3DA;      ;
                       JSL.L VIP                            ;83D3DD;848097;
                       RTS                                  ;83D3E1;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D3E2: %Set8bit(!M)                             ;83D3E2;      ;
                       %Set16bit(!X)                             ;83D3E4;      ;
                       LDA.L !season                        ;83D3E6;7F1F19;
                       CMP.B #$02                           ;83D3EA;      ;
                       BNE CODE_83D40E                      ;83D3EC;83D40E;
                       LDA.L !day                        ;83D3EE;7F1F1B;
                       CMP.B #$0C                           ;83D3F2;      ;
                       BNE CODE_83D40E                      ;83D3F4;83D40E;
                       LDA.L !hour                        ;83D3F6;7F1F1C;
                       CMP.B #$0F                           ;83D3FA;      ;
                       BCS CODE_83D40E                      ;83D3FC;83D40E;
                       %Set16bit(!MX)                             ;83D3FE;      ;
                       LDA.W #$0000                         ;83D400;      ;
                       LDX.W #$0026                         ;83D403;      ;
                       LDY.W #$0000                         ;83D406;      ;
                       JSL.L VIP                            ;83D409;848097;
                       RTS                                  ;83D40D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D40E: %Set8bit(!M)                             ;83D40E;      ;
                       %Set16bit(!X)                             ;83D410;      ;
                       LDA.L !season                        ;83D412;7F1F19;
                       CMP.B #$03                           ;83D416;      ;
                       BNE CODE_83D43A                      ;83D418;83D43A;
                       LDA.L !day                        ;83D41A;7F1F1B;
                       CMP.B #$0A                           ;83D41E;      ;
                       BNE CODE_83D43A                      ;83D420;83D43A;
                       LDA.L !hour                        ;83D422;7F1F1C;
                       CMP.B #$11                           ;83D426;      ;
                       BCS CODE_83D43A                      ;83D428;83D43A;
                       %Set16bit(!MX)                             ;83D42A;      ;
                       LDA.W #$0000                         ;83D42C;      ;
                       LDX.W #$0027                         ;83D42F;      ;
                       LDY.W #$0000                         ;83D432;      ;
                       JSL.L VIP                            ;83D435;848097;
                       RTS                                  ;83D439;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D43A: %Set16bit(!MX)                             ;83D43A;      ;
                       LDA.L $7F1F6A                        ;83D43C;7F1F6A;
                       AND.W #$4000                         ;83D440;      ;
                       BNE CODE_83D452                      ;83D443;83D452;
                       LDA.W #$0015                         ;83D445;      ;
                       LDX.W #$0000                         ;83D448;      ;
                       LDY.W #$007E                         ;83D44B;      ;
                       JSL.L VIP                            ;83D44E;848097;
                                                            ;      ;      ;
          CODE_83D452: %Set16bit(!MX)                             ;83D452;      ;
                       LDA.L $7F1F68                        ;83D454;7F1F68;
                       AND.W #$0001                         ;83D458;      ;
                       BNE CODE_83D46D                      ;83D45B;83D46D;
                       %Set16bit(!MX)                             ;83D45D;      ;
                       LDA.W #$0000                         ;83D45F;      ;
                       LDX.W #$000B                         ;83D462;      ;
                       LDY.W #$0000                         ;83D465;      ;
                       JSL.L VIP                            ;83D468;848097;
                       RTS                                  ;83D46C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D46D: %Set16bit(!M)                             ;83D46D;      ;
                       LDA.W $0196                          ;83D46F;000196;
                       AND.W #$0008                         ;83D472;      ;
                       BNE CODE_83D4B6                      ;83D475;83D4B6;
                       %Set8bit(!M)                             ;83D477;      ;
                       LDA.W !weather_tomorrow                          ;83D479;00098C;
                       CMP.B #$03                           ;83D47C;      ;
                       BEQ CODE_83D4B6                      ;83D47E;83D4B6;
                       %Set16bit(!MX)                             ;83D480;      ;
                       LDA.L $7F1F64                        ;83D482;7F1F64;
                       AND.W #$0020                         ;83D486;      ;
                       BNE CODE_83D4B6                      ;83D489;83D4B6;
                       LDA.W $0196                          ;83D48B;000196;
                       AND.W #$0200                         ;83D48E;      ;
                       BNE CODE_83D4B6                      ;83D491;83D4B6;
                       LDA.W $0196                          ;83D493;000196;
                       AND.W #$0002                         ;83D496;      ;
                       BNE CODE_83D4B6                      ;83D499;83D4B6;
                       %Set8bit(!M)                             ;83D49B;      ;
                       LDA.L !weekday                        ;83D49D;7F1F1A;
                       BEQ CODE_83D4B7                      ;83D4A1;83D4B7;
                       CMP.B #$06                           ;83D4A3;      ;
                       BEQ CODE_83D4C7                      ;83D4A5;83D4C7;
                       %Set16bit(!MX)                             ;83D4A7;      ;
                       LDA.W #$0000                         ;83D4A9;      ;
                       LDX.W #$0001                         ;83D4AC;      ;
                       LDY.W #$0000                         ;83D4AF;      ;
                       JSL.L VIP                            ;83D4B2;848097;
                                                            ;      ;      ;
          CODE_83D4B6: RTS                                  ;83D4B6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D4B7: %Set16bit(!MX)                             ;83D4B7;      ;
                       LDA.W #$0000                         ;83D4B9;      ;
                       LDX.W #$0003                         ;83D4BC;      ;
                       LDY.W #$0000                         ;83D4BF;      ;
                       JSL.L VIP                            ;83D4C2;848097;
                       RTS                                  ;83D4C6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D4C7: %Set16bit(!MX)                             ;83D4C7;      ;
                       LDA.W #$0000                         ;83D4C9;      ;
                       LDX.W #$0002                         ;83D4CC;      ;
                       LDY.W #$0000                         ;83D4CF;      ;
                       JSL.L VIP                            ;83D4D2;848097;
                       RTS                                  ;83D4D6;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D4D7;      ;
                       LDA.L $7F1F66                        ;83D4D9;7F1F66;
                       AND.W #$0001                         ;83D4DD;      ;
                       BNE CODE_83D4E4                      ;83D4E0;83D4E4;
                       BRA CODE_83D4FF                      ;83D4E2;83D4FF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D4E4: %Set16bit(!MX)                             ;83D4E4;      ;
                       LDA.L $7F1F6E                        ;83D4E6;7F1F6E;
                       AND.W #$0002                         ;83D4EA;      ;
                       BEQ CODE_83D4FF                      ;83D4ED;83D4FF;
                       %Set16bit(!MX)                             ;83D4EF;      ;
                       LDA.W #$0000                         ;83D4F1;      ;
                       LDX.W #$0022                         ;83D4F4;      ;
                       LDY.W #$0003                         ;83D4F7;      ;
                       JSL.L VIP                            ;83D4FA;848097;
                       RTS                                  ;83D4FE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D4FF: %Set8bit(!M)                             ;83D4FF;      ;
                       %Set16bit(!X)                             ;83D501;      ;
                       LDA.L !season                        ;83D503;7F1F19;
                       CMP.B #$03                           ;83D507;      ;
                       BNE CODE_83D52B                      ;83D509;83D52B;
                       LDA.L !day                        ;83D50B;7F1F1B;
                       CMP.B #$0A                           ;83D50F;      ;
                       BNE CODE_83D52B                      ;83D511;83D52B;
                       LDA.L !hour                        ;83D513;7F1F1C;
                       CMP.B #$11                           ;83D517;      ;
                       BCS CODE_83D52B                      ;83D519;83D52B;
                       %Set16bit(!MX)                             ;83D51B;      ;
                       LDA.W #$0000                         ;83D51D;      ;
                       LDX.W #$0027                         ;83D520;      ;
                       LDY.W #$0003                         ;83D523;      ;
                       JSL.L VIP                            ;83D526;848097;
                       RTS                                  ;83D52A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D52B: %Set16bit(!MX)                             ;83D52B;      ;
                       LDA.L $7F1F68                        ;83D52D;7F1F68;
                       AND.W #$0001                         ;83D531;      ;
                       BNE CODE_83D546                      ;83D534;83D546;
                       %Set16bit(!MX)                             ;83D536;      ;
                       LDA.W #$0000                         ;83D538;      ;
                       LDX.W #$000B                         ;83D53B;      ;
                       LDY.W #$0001                         ;83D53E;      ;
                       JSL.L VIP                            ;83D541;848097;
                       RTS                                  ;83D545;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D546: %Set16bit(!M)                             ;83D546;      ;
                       LDA.W $0196                          ;83D548;000196;
                       AND.W #$0008                         ;83D54B;      ;
                       BNE CODE_83D5B7                      ;83D54E;83D5B7;
                       %Set8bit(!M)                             ;83D550;      ;
                       %Set16bit(!X)                             ;83D552;      ;
                       LDA.W !weather_tomorrow                          ;83D554;00098C;
                       CMP.B #$06                           ;83D557;      ;
                       BCS CODE_83D587                      ;83D559;83D587;
                       LDA.W !weather_tomorrow                          ;83D55B;00098C;
                       CMP.B #$03                           ;83D55E;      ;
                       BEQ CODE_83D5C7                      ;83D560;83D5C7;
                       %Set16bit(!MX)                             ;83D562;      ;
                       LDA.L $7F1F64                        ;83D564;7F1F64;
                       AND.W #$0020                         ;83D568;      ;
                       BNE CODE_83D5C7                      ;83D56B;83D5C7;
                       LDA.W $0196                          ;83D56D;000196;
                       AND.W #$0200                         ;83D570;      ;
                       BNE CODE_83D5D7                      ;83D573;83D5D7;
                       LDA.W $0196                          ;83D575;000196;
                       AND.W #$0002                         ;83D578;      ;
                       BNE CODE_83D5A7                      ;83D57B;83D5A7;
                       %Set8bit(!M)                             ;83D57D;      ;
                       LDA.L !weekday                        ;83D57F;7F1F1A;
                       CMP.B #$06                           ;83D583;      ;
                       BEQ CODE_83D597                      ;83D585;83D597;
                                                            ;      ;      ;
          CODE_83D587: %Set16bit(!MX)                             ;83D587;      ;
                       LDA.W #$0000                         ;83D589;      ;
                       LDX.W #$0001                         ;83D58C;      ;
                       LDY.W #$0001                         ;83D58F;      ;
                       JSL.L VIP                            ;83D592;848097;
                       RTS                                  ;83D596;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D597: %Set16bit(!MX)                             ;83D597;      ;
                       LDA.W #$0000                         ;83D599;      ;
                       LDX.W #$0002                         ;83D59C;      ;
                       LDY.W #$0001                         ;83D59F;      ;
                       JSL.L VIP                            ;83D5A2;848097;
                       RTS                                  ;83D5A6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D5A7: %Set16bit(!MX)                             ;83D5A7;      ;
                       LDA.W #$0000                         ;83D5A9;      ;
                       LDX.W #$0004                         ;83D5AC;      ;
                       LDY.W #$0000                         ;83D5AF;      ;
                       JSL.L VIP                            ;83D5B2;848097;
                       RTS                                  ;83D5B6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D5B7: %Set16bit(!MX)                             ;83D5B7;      ;
                       LDA.W #$0000                         ;83D5B9;      ;
                       LDX.W #$0007                         ;83D5BC;      ;
                       LDY.W #$0000                         ;83D5BF;      ;
                       JSL.L VIP                            ;83D5C2;848097;
                       RTS                                  ;83D5C6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D5C7: %Set16bit(!MX)                             ;83D5C7;      ;
                       LDA.W #$0000                         ;83D5C9;      ;
                       LDX.W #$0006                         ;83D5CC;      ;
                       LDY.W #$0000                         ;83D5CF;      ;
                       JSL.L VIP                            ;83D5D2;848097;
                       RTS                                  ;83D5D6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D5D7: %Set16bit(!MX)                             ;83D5D7;      ;
                       LDA.W #$0000                         ;83D5D9;      ;
                       LDX.W #$0008                         ;83D5DC;      ;
                       LDY.W #$0000                         ;83D5DF;      ;
                       JSL.L VIP                            ;83D5E2;848097;
                       RTS                                  ;83D5E6;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D5E7;      ;
                       LDA.L $7F1F66                        ;83D5E9;7F1F66;
                       AND.W #$0001                         ;83D5ED;      ;
                       BNE CODE_83D5F5                      ;83D5F0;83D5F5;
                       JMP.W CODE_83D4FF                    ;83D5F2;83D4FF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D5F5: %Set16bit(!MX)                             ;83D5F5;      ;
                       LDA.L $7F1F6E                        ;83D5F7;7F1F6E;
                       AND.W #$0002                         ;83D5FB;      ;
                       BNE CODE_83D603                      ;83D5FE;83D603;
                       JMP.W CODE_83D4FF                    ;83D600;83D4FF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D603: %Set16bit(!MX)                             ;83D603;      ;
                       LDA.W #$0000                         ;83D605;      ;
                       LDX.W #$0022                         ;83D608;      ;
                       LDY.W #$0004                         ;83D60B;      ;
                       JSL.L VIP                            ;83D60E;848097;
                       RTS                                  ;83D612;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83D613;      ;
                       %Set16bit(!X)                             ;83D615;      ;
                       LDA.L !season                        ;83D617;7F1F19;
                       CMP.B #$03                           ;83D61B;      ;
                       BNE CODE_83D63F                      ;83D61D;83D63F;
                       LDA.L !day                        ;83D61F;7F1F1B;
                       CMP.B #$0A                           ;83D623;      ;
                       BNE CODE_83D63F                      ;83D625;83D63F;
                       LDA.L !hour                        ;83D627;7F1F1C;
                       CMP.B #$11                           ;83D62B;      ;
                       BCS CODE_83D63F                      ;83D62D;83D63F;
                       %Set16bit(!MX)                             ;83D62F;      ;
                       LDA.W #$0000                         ;83D631;      ;
                       LDX.W #$0027                         ;83D634;      ;
                       LDY.W #$0002                         ;83D637;      ;
                       JSL.L VIP                            ;83D63A;848097;
                       RTS                                  ;83D63E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D63F: %Set8bit(!M)                             ;83D63F;      ;
                       %Set16bit(!X)                             ;83D641;      ;
                       LDA.L !season                        ;83D643;7F1F19;
                       CMP.B #$03                           ;83D647;      ;
                       BNE CODE_83D66E                      ;83D649;83D66E;
                       LDA.L !day                        ;83D64B;7F1F1B;
                       CMP.B #$18                           ;83D64F;      ;
                       BNE CODE_83D66E                      ;83D651;83D66E;
                       %Set16bit(!M)                             ;83D653;      ;
                       LDA.L $7F1F74                        ;83D655;7F1F74;
                       AND.W #$0002                         ;83D659;      ;
                       BEQ CODE_83D66E                      ;83D65C;83D66E;
                       %Set16bit(!MX)                             ;83D65E;      ;
                       LDA.W #$0000                         ;83D660;      ;
                       LDX.W #$000F                         ;83D663;      ;
                       LDY.W #$0002                         ;83D666;      ;
                       JSL.L VIP                            ;83D669;848097;
                       RTS                                  ;83D66D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D66E: %Set16bit(!MX)                             ;83D66E;      ;
                       LDA.L $7F1F68                        ;83D670;7F1F68;
                       AND.W #$0001                         ;83D674;      ;
                       BNE CODE_83D689                      ;83D677;83D689;
                       %Set16bit(!MX)                             ;83D679;      ;
                       LDA.W #$0000                         ;83D67B;      ;
                       LDX.W #$000B                         ;83D67E;      ;
                       LDY.W #$000C                         ;83D681;      ;
                       JSL.L VIP                            ;83D684;848097;
                       RTS                                  ;83D688;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D689: %Set16bit(!M)                             ;83D689;      ;
                       LDA.W $0196                          ;83D68B;000196;
                       AND.W #$0008                         ;83D68E;      ;
                       BEQ CODE_83D696                      ;83D691;83D696;
                       JMP.W CODE_83D71E                    ;83D693;83D71E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D696: %Set8bit(!M)                             ;83D696;      ;
                       %Set16bit(!X)                             ;83D698;      ;
                       LDA.W !weather_tomorrow                          ;83D69A;00098C;
                       CMP.B #$06                           ;83D69D;      ;
                       BCS CODE_83D6DE                      ;83D69F;83D6DE;
                       LDA.W !weather_tomorrow                          ;83D6A1;00098C;
                       CMP.B #$03                           ;83D6A4;      ;
                       BNE CODE_83D6AB                      ;83D6A6;83D6AB;
                       JMP.W CODE_83D72E                    ;83D6A8;83D72E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D6AB: %Set16bit(!MX)                             ;83D6AB;      ;
                       LDA.L $7F1F64                        ;83D6AD;7F1F64;
                       AND.W #$0020                         ;83D6B1;      ;
                       BNE CODE_83D72E                      ;83D6B4;83D72E;
                       LDA.W $0196                          ;83D6B6;000196;
                       AND.W #$0200                         ;83D6B9;      ;
                       BEQ CODE_83D6C1                      ;83D6BC;83D6C1;
                       JMP.W CODE_83D73E                    ;83D6BE;83D73E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D6C1: LDA.L $7F1F68                        ;83D6C1;7F1F68;
                       AND.W #$0001                         ;83D6C5;      ;
                       BEQ CODE_83D6ED                      ;83D6C8;83D6ED;
                       LDA.W $0196                          ;83D6CA;000196;
                       AND.W #$0002                         ;83D6CD;      ;
                       BNE CODE_83D70E                      ;83D6D0;83D70E;
                       %Set8bit(!M)                             ;83D6D2;      ;
                       LDA.L !weekday                        ;83D6D4;7F1F1A;
                       BEQ CODE_83D6EE                      ;83D6D8;83D6EE;
                       CMP.B #$06                           ;83D6DA;      ;
                       BEQ CODE_83D6FE                      ;83D6DC;83D6FE;
                                                            ;      ;      ;
          CODE_83D6DE: %Set16bit(!MX)                             ;83D6DE;      ;
                       LDA.W #$0000                         ;83D6E0;      ;
                       LDX.W #$0001                         ;83D6E3;      ;
                       LDY.W #$0002                         ;83D6E6;      ;
                       JSL.L VIP                            ;83D6E9;848097;
                                                            ;      ;      ;
          CODE_83D6ED: RTS                                  ;83D6ED;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D6EE: %Set16bit(!MX)                             ;83D6EE;      ;
                       LDA.W #$0000                         ;83D6F0;      ;
                       LDX.W #$0003                         ;83D6F3;      ;
                       LDY.W #$0001                         ;83D6F6;      ;
                       JSL.L VIP                            ;83D6F9;848097;
                       RTS                                  ;83D6FD;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D6FE: %Set16bit(!MX)                             ;83D6FE;      ;
                       LDA.W #$0000                         ;83D700;      ;
                       LDX.W #$0002                         ;83D703;      ;
                       LDY.W #$0002                         ;83D706;      ;
                       JSL.L VIP                            ;83D709;848097;
                       RTS                                  ;83D70D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D70E: %Set16bit(!MX)                             ;83D70E;      ;
                       LDA.W #$0000                         ;83D710;      ;
                       LDX.W #$0004                         ;83D713;      ;
                       LDY.W #$0001                         ;83D716;      ;
                       JSL.L VIP                            ;83D719;848097;
                       RTS                                  ;83D71D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D71E: %Set16bit(!MX)                             ;83D71E;      ;
                       LDA.W #$0000                         ;83D720;      ;
                       LDX.W #$0007                         ;83D723;      ;
                       LDY.W #$0001                         ;83D726;      ;
                       JSL.L VIP                            ;83D729;848097;
                       RTS                                  ;83D72D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D72E: %Set16bit(!MX)                             ;83D72E;      ;
                       LDA.W #$0000                         ;83D730;      ;
                       LDX.W #$0006                         ;83D733;      ;
                       LDY.W #$0001                         ;83D736;      ;
                       JSL.L VIP                            ;83D739;848097;
                       RTS                                  ;83D73D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D73E: %Set16bit(!MX)                             ;83D73E;      ;
                       LDA.W #$0000                         ;83D740;      ;
                       LDX.W #$0008                         ;83D743;      ;
                       LDY.W #$0001                         ;83D746;      ;
                       JSL.L VIP                            ;83D749;848097;
                       RTS                                  ;83D74D;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D74E;      ;
                       LDA.L $7F1F66                        ;83D750;7F1F66;
                       AND.W #$0004                         ;83D754;      ;
                       BNE CODE_83D75B                      ;83D757;83D75B;
                       BRA CODE_83D776                      ;83D759;83D776;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D75B: %Set16bit(!MX)                             ;83D75B;      ;
                       LDA.L $7F1F6E                        ;83D75D;7F1F6E;
                       AND.W #$0002                         ;83D761;      ;
                       BEQ CODE_83D776                      ;83D764;83D776;
                       %Set16bit(!MX)                             ;83D766;      ;
                       LDA.W #$0000                         ;83D768;      ;
                       LDX.W #$0022                         ;83D76B;      ;
                       LDY.W #$0007                         ;83D76E;      ;
                       JSL.L VIP                            ;83D771;848097;
                       RTS                                  ;83D775;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D776: %Set16bit(!MX)                             ;83D776;      ;
                       LDA.L $7F1F68                        ;83D778;7F1F68;
                       AND.W #$0001                         ;83D77C;      ;
                       BNE CODE_83D791                      ;83D77F;83D791;
                       %Set16bit(!MX)                             ;83D781;      ;
                       LDA.W #$0000                         ;83D783;      ;
                       LDX.W #$000B                         ;83D786;      ;
                       LDY.W #$0003                         ;83D789;      ;
                       JSL.L VIP                            ;83D78C;848097;
                       RTS                                  ;83D790;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D791: %Set16bit(!M)                             ;83D791;      ;
                       LDA.W $0196                          ;83D793;000196;
                       AND.W #$0008                         ;83D796;      ;
                       BNE CODE_83D7E8                      ;83D799;83D7E8;
                       %Set8bit(!M)                             ;83D79B;      ;
                       %Set16bit(!X)                             ;83D79D;      ;
                       LDA.W !weather_tomorrow                          ;83D79F;00098C;
                       CMP.B #$06                           ;83D7A2;      ;
                       BCS CODE_83D7C8                      ;83D7A4;83D7C8;
                       LDA.W !weather_tomorrow                          ;83D7A6;00098C;
                       CMP.B #$03                           ;83D7A9;      ;
                       BEQ CODE_83D7F8                      ;83D7AB;83D7F8;
                       %Set16bit(!MX)                             ;83D7AD;      ;
                       LDA.L $7F1F64                        ;83D7AF;7F1F64;
                       AND.W #$0020                         ;83D7B3;      ;
                       BNE CODE_83D7F8                      ;83D7B6;83D7F8;
                       LDA.W $0196                          ;83D7B8;000196;
                       AND.W #$0200                         ;83D7BB;      ;
                       BNE CODE_83D808                      ;83D7BE;83D808;
                       LDA.W $0196                          ;83D7C0;000196;
                       AND.W #$0002                         ;83D7C3;      ;
                       BNE CODE_83D7D8                      ;83D7C6;83D7D8;
                                                            ;      ;      ;
          CODE_83D7C8: %Set16bit(!MX)                             ;83D7C8;      ;
                       LDA.W #$0000                         ;83D7CA;      ;
                       LDX.W #$0001                         ;83D7CD;      ;
                       LDY.W #$0003                         ;83D7D0;      ;
                       JSL.L VIP                            ;83D7D3;848097;
                       RTS                                  ;83D7D7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D7D8: %Set16bit(!MX)                             ;83D7D8;      ;
                       LDA.W #$0000                         ;83D7DA;      ;
                       LDX.W #$0004                         ;83D7DD;      ;
                       LDY.W #$0002                         ;83D7E0;      ;
                       JSL.L VIP                            ;83D7E3;848097;
                       RTS                                  ;83D7E7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D7E8: %Set16bit(!MX)                             ;83D7E8;      ;
                       LDA.W #$0000                         ;83D7EA;      ;
                       LDX.W #$0007                         ;83D7ED;      ;
                       LDY.W #$0002                         ;83D7F0;      ;
                       JSL.L VIP                            ;83D7F3;848097;
                       RTS                                  ;83D7F7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D7F8: %Set16bit(!MX)                             ;83D7F8;      ;
                       LDA.W #$0000                         ;83D7FA;      ;
                       LDX.W #$0006                         ;83D7FD;      ;
                       LDY.W #$0002                         ;83D800;      ;
                       JSL.L VIP                            ;83D803;848097;
                       RTS                                  ;83D807;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D808: %Set16bit(!MX)                             ;83D808;      ;
                       LDA.W #$0000                         ;83D80A;      ;
                       LDX.W #$0008                         ;83D80D;      ;
                       LDY.W #$0002                         ;83D810;      ;
                       JSL.L VIP                            ;83D813;848097;
                       RTS                                  ;83D817;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D818;      ;
                       LDA.L $7F1F66                        ;83D81A;7F1F66;
                       AND.W #$0004                         ;83D81E;      ;
                       BNE CODE_83D826                      ;83D821;83D826;
                       JMP.W CODE_83D776                    ;83D823;83D776;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D826: %Set16bit(!MX)                             ;83D826;      ;
                       LDA.L $7F1F6E                        ;83D828;7F1F6E;
                       AND.W #$0002                         ;83D82C;      ;
                       BNE CODE_83D834                      ;83D82F;83D834;
                       JMP.W CODE_83D776                    ;83D831;83D776;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D834: %Set16bit(!MX)                             ;83D834;      ;
                       LDA.W #$0000                         ;83D836;      ;
                       LDX.W #$0022                         ;83D839;      ;
                       LDY.W #$0008                         ;83D83C;      ;
                       JSL.L VIP                            ;83D83F;848097;
                       RTS                                  ;83D843;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D844;      ;
                       LDA.L $7F1F66                        ;83D846;7F1F66;
                       AND.W #$0002                         ;83D84A;      ;
                       BNE CODE_83D851                      ;83D84D;83D851;
                       BRA CODE_83D86C                      ;83D84F;83D86C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D851: %Set16bit(!MX)                             ;83D851;      ;
                       LDA.L $7F1F6E                        ;83D853;7F1F6E;
                       AND.W #$0002                         ;83D857;      ;
                       BEQ CODE_83D86C                      ;83D85A;83D86C;
                       %Set16bit(!MX)                             ;83D85C;      ;
                       LDA.W #$0000                         ;83D85E;      ;
                       LDX.W #$0022                         ;83D861;      ;
                       LDY.W #$0005                         ;83D864;      ;
                       JSL.L VIP                            ;83D867;848097;
                       RTS                                  ;83D86B;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D86C: %Set16bit(!MX)                             ;83D86C;      ;
                       LDA.L $7F1F5E                        ;83D86E;7F1F5E;
                       AND.W #$0010                         ;83D872;      ;
                       BEQ CODE_83D887                      ;83D875;83D887;
                       %Set16bit(!MX)                             ;83D877;      ;
                       LDA.W #$0000                         ;83D879;      ;
                       LDX.W #$001A                         ;83D87C;      ;
                       LDY.W #$0001                         ;83D87F;      ;
                       JSL.L VIP                            ;83D882;848097;
                       RTS                                  ;83D886;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D887: %Set16bit(!MX)                             ;83D887;      ;
                       LDA.L $7F1F68                        ;83D889;7F1F68;
                       AND.W #$0001                         ;83D88D;      ;
                       BNE CODE_83D8A2                      ;83D890;83D8A2;
                       %Set16bit(!MX)                             ;83D892;      ;
                       LDA.W #$0000                         ;83D894;      ;
                       LDX.W #$000B                         ;83D897;      ;
                       LDY.W #$0002                         ;83D89A;      ;
                       JSL.L VIP                            ;83D89D;848097;
                       RTS                                  ;83D8A1;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D8A2: %Set16bit(!M)                             ;83D8A2;      ;
                       LDA.W $0196                          ;83D8A4;000196;
                       AND.W #$0008                         ;83D8A7;      ;
                       BNE CODE_83D8F9                      ;83D8AA;83D8F9;
                       %Set8bit(!M)                             ;83D8AC;      ;
                       %Set16bit(!X)                             ;83D8AE;      ;
                       LDA.W !weather_tomorrow                          ;83D8B0;00098C;
                       CMP.B #$06                           ;83D8B3;      ;
                       BCS CODE_83D8D9                      ;83D8B5;83D8D9;
                       LDA.W !weather_tomorrow                          ;83D8B7;00098C;
                       CMP.B #$03                           ;83D8BA;      ;
                       BEQ CODE_83D909                      ;83D8BC;83D909;
                       %Set16bit(!MX)                             ;83D8BE;      ;
                       LDA.L $7F1F64                        ;83D8C0;7F1F64;
                       AND.W #$0020                         ;83D8C4;      ;
                       BNE CODE_83D909                      ;83D8C7;83D909;
                       LDA.W $0196                          ;83D8C9;000196;
                       AND.W #$0200                         ;83D8CC;      ;
                       BNE CODE_83D919                      ;83D8CF;83D919;
                       LDA.W $0196                          ;83D8D1;000196;
                       AND.W #$0002                         ;83D8D4;      ;
                       BNE CODE_83D8E9                      ;83D8D7;83D8E9;
                                                            ;      ;      ;
          CODE_83D8D9: %Set16bit(!MX)                             ;83D8D9;      ;
                       LDA.W #$0000                         ;83D8DB;      ;
                       LDX.W #$0001                         ;83D8DE;      ;
                       LDY.W #$0004                         ;83D8E1;      ;
                       JSL.L VIP                            ;83D8E4;848097;
                       RTS                                  ;83D8E8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D8E9: %Set16bit(!MX)                             ;83D8E9;      ;
                       LDA.W #$0000                         ;83D8EB;      ;
                       LDX.W #$0004                         ;83D8EE;      ;
                       LDY.W #$0003                         ;83D8F1;      ;
                       JSL.L VIP                            ;83D8F4;848097;
                       RTS                                  ;83D8F8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D8F9: %Set16bit(!MX)                             ;83D8F9;      ;
                       LDA.W #$0000                         ;83D8FB;      ;
                       LDX.W #$0007                         ;83D8FE;      ;
                       LDY.W #$0003                         ;83D901;      ;
                       JSL.L VIP                            ;83D904;848097;
                       RTS                                  ;83D908;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D909: %Set16bit(!MX)                             ;83D909;      ;
                       LDA.W #$0000                         ;83D90B;      ;
                       LDX.W #$0006                         ;83D90E;      ;
                       LDY.W #$0003                         ;83D911;      ;
                       JSL.L VIP                            ;83D914;848097;
                       RTS                                  ;83D918;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D919: %Set16bit(!MX)                             ;83D919;      ;
                       LDA.W #$0000                         ;83D91B;      ;
                       LDX.W #$0008                         ;83D91E;      ;
                       LDY.W #$0003                         ;83D921;      ;
                       JSL.L VIP                            ;83D924;848097;
                       RTS                                  ;83D928;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D929;      ;
                       LDA.L $7F1F66                        ;83D92B;7F1F66;
                       AND.W #$0002                         ;83D92F;      ;
                       BNE CODE_83D937                      ;83D932;83D937;
                       JMP.W CODE_83D86C                    ;83D934;83D86C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D937: %Set16bit(!MX)                             ;83D937;      ;
                       LDA.L $7F1F6E                        ;83D939;7F1F6E;
                       AND.W #$0002                         ;83D93D;      ;
                       BNE CODE_83D945                      ;83D940;83D945;
                       JMP.W CODE_83D86C                    ;83D942;83D86C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D945: %Set16bit(!MX)                             ;83D945;      ;
                       LDA.W #$0000                         ;83D947;      ;
                       LDX.W #$0022                         ;83D94A;      ;
                       LDY.W #$0006                         ;83D94D;      ;
                       JSL.L VIP                            ;83D950;848097;
                       RTS                                  ;83D954;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83D955;      ;
                       LDA.L $7F1F66                        ;83D957;7F1F66;
                       AND.W #$0008                         ;83D95B;      ;
                       BNE CODE_83D962                      ;83D95E;83D962;
                       BRA CODE_83D97D                      ;83D960;83D97D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D962: %Set16bit(!MX)                             ;83D962;      ;
                       LDA.L $7F1F6E                        ;83D964;7F1F6E;
                       AND.W #$0002                         ;83D968;      ;
                       BEQ CODE_83D97D                      ;83D96B;83D97D;
                       %Set16bit(!MX)                             ;83D96D;      ;
                       LDA.W #$0000                         ;83D96F;      ;
                       LDX.W #$0022                         ;83D972;      ;
                       LDY.W #$0009                         ;83D975;      ;
                       JSL.L VIP                            ;83D978;848097;
                       RTS                                  ;83D97C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D97D: %Set16bit(!MX)                             ;83D97D;      ;
                       LDA.L $7F1F68                        ;83D97F;7F1F68;
                       AND.W #$0001                         ;83D983;      ;
                       BNE CODE_83D998                      ;83D986;83D998;
                       %Set16bit(!MX)                             ;83D988;      ;
                       LDA.W #$0000                         ;83D98A;      ;
                       LDX.W #$000B                         ;83D98D;      ;
                       LDY.W #$0004                         ;83D990;      ;
                       JSL.L VIP                            ;83D993;848097;
                       RTS                                  ;83D997;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D998: %Set16bit(!M)                             ;83D998;      ;
                       LDA.W $0196                          ;83D99A;000196;
                       AND.W #$0008                         ;83D99D;      ;
                       BNE CODE_83D9EF                      ;83D9A0;83D9EF;
                       %Set8bit(!M)                             ;83D9A2;      ;
                       %Set16bit(!X)                             ;83D9A4;      ;
                       LDA.W !weather_tomorrow                          ;83D9A6;00098C;
                       CMP.B #$06                           ;83D9A9;      ;
                       BCS CODE_83D9CF                      ;83D9AB;83D9CF;
                       LDA.W !weather_tomorrow                          ;83D9AD;00098C;
                       CMP.B #$03                           ;83D9B0;      ;
                       BEQ CODE_83D9FF                      ;83D9B2;83D9FF;
                       %Set16bit(!MX)                             ;83D9B4;      ;
                       LDA.L $7F1F64                        ;83D9B6;7F1F64;
                       AND.W #$0020                         ;83D9BA;      ;
                       BNE CODE_83D9FF                      ;83D9BD;83D9FF;
                       LDA.W $0196                          ;83D9BF;000196;
                       AND.W #$0200                         ;83D9C2;      ;
                       BNE CODE_83DA0F                      ;83D9C5;83DA0F;
                       LDA.W $0196                          ;83D9C7;000196;
                       AND.W #$0002                         ;83D9CA;      ;
                       BNE CODE_83D9DF                      ;83D9CD;83D9DF;
                                                            ;      ;      ;
          CODE_83D9CF: %Set16bit(!MX)                             ;83D9CF;      ;
                       LDA.W #$0000                         ;83D9D1;      ;
                       LDX.W #$0001                         ;83D9D4;      ;
                       LDY.W #$0005                         ;83D9D7;      ;
                       JSL.L VIP                            ;83D9DA;848097;
                       RTS                                  ;83D9DE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D9DF: %Set16bit(!MX)                             ;83D9DF;      ;
                       LDA.W #$0000                         ;83D9E1;      ;
                       LDX.W #$0004                         ;83D9E4;      ;
                       LDY.W #$0004                         ;83D9E7;      ;
                       JSL.L VIP                            ;83D9EA;848097;
                       RTS                                  ;83D9EE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D9EF: %Set16bit(!MX)                             ;83D9EF;      ;
                       LDA.W #$0000                         ;83D9F1;      ;
                       LDX.W #$0007                         ;83D9F4;      ;
                       LDY.W #$0004                         ;83D9F7;      ;
                       JSL.L VIP                            ;83D9FA;848097;
                       RTS                                  ;83D9FE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83D9FF: %Set16bit(!MX)                             ;83D9FF;      ;
                       LDA.W #$0000                         ;83DA01;      ;
                       LDX.W #$0006                         ;83DA04;      ;
                       LDY.W #$0004                         ;83DA07;      ;
                       JSL.L VIP                            ;83DA0A;848097;
                       RTS                                  ;83DA0E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DA0F: %Set16bit(!MX)                             ;83DA0F;      ;
                       LDA.W #$0000                         ;83DA11;      ;
                       LDX.W #$0008                         ;83DA14;      ;
                       LDY.W #$0004                         ;83DA17;      ;
                       JSL.L VIP                            ;83DA1A;848097;
                       RTS                                  ;83DA1E;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DA1F;      ;
                       LDA.L $7F1F66                        ;83DA21;7F1F66;
                       AND.W #$0008                         ;83DA25;      ;
                       BNE CODE_83DA2D                      ;83DA28;83DA2D;
                       JMP.W CODE_83D97D                    ;83DA2A;83D97D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DA2D: %Set16bit(!MX)                             ;83DA2D;      ;
                       LDA.L $7F1F6E                        ;83DA2F;7F1F6E;
                       AND.W #$0002                         ;83DA33;      ;
                       BNE CODE_83DA3B                      ;83DA36;83DA3B;
                       JMP.W CODE_83D97D                    ;83DA38;83D97D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DA3B: %Set16bit(!MX)                             ;83DA3B;      ;
                       LDA.W #$0000                         ;83DA3D;      ;
                       LDX.W #$0022                         ;83DA40;      ;
                       LDY.W #$000A                         ;83DA43;      ;
                       JSL.L VIP                            ;83DA46;848097;
                       RTS                                  ;83DA4A;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DA4B;      ;
                       LDA.L $7F1F68                        ;83DA4D;7F1F68;
                       AND.W #$0001                         ;83DA51;      ;
                       BNE CODE_83DA66                      ;83DA54;83DA66;
                       %Set16bit(!MX)                             ;83DA56;      ;
                       LDA.W #$0000                         ;83DA58;      ;
                       LDX.W #$000B                         ;83DA5B;      ;
                       LDY.W #$0005                         ;83DA5E;      ;
                       JSL.L VIP                            ;83DA61;848097;
                       RTS                                  ;83DA65;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DA66: %Set16bit(!M)                             ;83DA66;      ;
                       LDA.W $0196                          ;83DA68;000196;
                       AND.W #$0008                         ;83DA6B;      ;
                       BNE CODE_83DABD                      ;83DA6E;83DABD;
                       %Set8bit(!M)                             ;83DA70;      ;
                       %Set16bit(!X)                             ;83DA72;      ;
                       LDA.W !weather_tomorrow                          ;83DA74;00098C;
                       CMP.B #$06                           ;83DA77;      ;
                       BCS CODE_83DA9D                      ;83DA79;83DA9D;
                       LDA.W !weather_tomorrow                          ;83DA7B;00098C;
                       CMP.B #$03                           ;83DA7E;      ;
                       BEQ CODE_83DACD                      ;83DA80;83DACD;
                       %Set16bit(!MX)                             ;83DA82;      ;
                       LDA.L $7F1F64                        ;83DA84;7F1F64;
                       AND.W #$0020                         ;83DA88;      ;
                       BNE CODE_83DACD                      ;83DA8B;83DACD;
                       LDA.W $0196                          ;83DA8D;000196;
                       AND.W #$0200                         ;83DA90;      ;
                       BNE CODE_83DADD                      ;83DA93;83DADD;
                       LDA.W $0196                          ;83DA95;000196;
                       AND.W #$0002                         ;83DA98;      ;
                       BNE CODE_83DAAD                      ;83DA9B;83DAAD;
                                                            ;      ;      ;
          CODE_83DA9D: %Set16bit(!MX)                             ;83DA9D;      ;
                       LDA.W #$0000                         ;83DA9F;      ;
                       LDX.W #$0001                         ;83DAA2;      ;
                       LDY.W #$0006                         ;83DAA5;      ;
                       JSL.L VIP                            ;83DAA8;848097;
                       RTS                                  ;83DAAC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DAAD: %Set16bit(!MX)                             ;83DAAD;      ;
                       LDA.W #$0000                         ;83DAAF;      ;
                       LDX.W #$0004                         ;83DAB2;      ;
                       LDY.W #$0005                         ;83DAB5;      ;
                       JSL.L VIP                            ;83DAB8;848097;
                       RTS                                  ;83DABC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DABD: %Set16bit(!MX)                             ;83DABD;      ;
                       LDA.W #$0000                         ;83DABF;      ;
                       LDX.W #$0007                         ;83DAC2;      ;
                       LDY.W #$0005                         ;83DAC5;      ;
                       JSL.L VIP                            ;83DAC8;848097;
                       RTS                                  ;83DACC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DACD: %Set16bit(!MX)                             ;83DACD;      ;
                       LDA.W #$0000                         ;83DACF;      ;
                       LDX.W #$0006                         ;83DAD2;      ;
                       LDY.W #$0005                         ;83DAD5;      ;
                       JSL.L VIP                            ;83DAD8;848097;
                       RTS                                  ;83DADC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DADD: %Set16bit(!MX)                             ;83DADD;      ;
                       LDA.W #$0000                         ;83DADF;      ;
                       LDX.W #$0008                         ;83DAE2;      ;
                       LDY.W #$0005                         ;83DAE5;      ;
                       JSL.L VIP                            ;83DAE8;848097;
                       RTS                                  ;83DAEC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DAED;      ;
                       LDA.L $7F1F68                        ;83DAEF;7F1F68;
                       AND.W #$0001                         ;83DAF3;      ;
                       BNE CODE_83DB08                      ;83DAF6;83DB08;
                       %Set16bit(!MX)                             ;83DAF8;      ;
                       LDA.W #$0000                         ;83DAFA;      ;
                       LDX.W #$000B                         ;83DAFD;      ;
                       LDY.W #$0006                         ;83DB00;      ;
                       JSL.L VIP                            ;83DB03;848097;
                       RTS                                  ;83DB07;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DB08: %Set16bit(!M)                             ;83DB08;      ;
                       LDA.W $0196                          ;83DB0A;000196;
                       AND.W #$0008                         ;83DB0D;      ;
                       BNE CODE_83DB5F                      ;83DB10;83DB5F;
                       %Set8bit(!M)                             ;83DB12;      ;
                       %Set16bit(!X)                             ;83DB14;      ;
                       LDA.W !weather_tomorrow                          ;83DB16;00098C;
                       CMP.B #$06                           ;83DB19;      ;
                       BCS CODE_83DB3F                      ;83DB1B;83DB3F;
                       LDA.W !weather_tomorrow                          ;83DB1D;00098C;
                       CMP.B #$03                           ;83DB20;      ;
                       BEQ CODE_83DB6F                      ;83DB22;83DB6F;
                       %Set16bit(!MX)                             ;83DB24;      ;
                       LDA.L $7F1F64                        ;83DB26;7F1F64;
                       AND.W #$0020                         ;83DB2A;      ;
                       BNE CODE_83DB6F                      ;83DB2D;83DB6F;
                       LDA.W $0196                          ;83DB2F;000196;
                       AND.W #$0200                         ;83DB32;      ;
                       BNE CODE_83DB7F                      ;83DB35;83DB7F;
                       LDA.W $0196                          ;83DB37;000196;
                       AND.W #$0002                         ;83DB3A;      ;
                       BNE CODE_83DB4F                      ;83DB3D;83DB4F;
                                                            ;      ;      ;
          CODE_83DB3F: %Set16bit(!MX)                             ;83DB3F;      ;
                       LDA.W #$0000                         ;83DB41;      ;
                       LDX.W #$0001                         ;83DB44;      ;
                       LDY.W #$0007                         ;83DB47;      ;
                       JSL.L VIP                            ;83DB4A;848097;
                       RTS                                  ;83DB4E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DB4F: %Set16bit(!MX)                             ;83DB4F;      ;
                       LDA.W #$0000                         ;83DB51;      ;
                       LDX.W #$0004                         ;83DB54;      ;
                       LDY.W #$0006                         ;83DB57;      ;
                       JSL.L VIP                            ;83DB5A;848097;
                       RTS                                  ;83DB5E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DB5F: %Set16bit(!MX)                             ;83DB5F;      ;
                       LDA.W #$0000                         ;83DB61;      ;
                       LDX.W #$0007                         ;83DB64;      ;
                       LDY.W #$0006                         ;83DB67;      ;
                       JSL.L VIP                            ;83DB6A;848097;
                       RTS                                  ;83DB6E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DB6F: %Set16bit(!MX)                             ;83DB6F;      ;
                       LDA.W #$0000                         ;83DB71;      ;
                       LDX.W #$0006                         ;83DB74;      ;
                       LDY.W #$0006                         ;83DB77;      ;
                       JSL.L VIP                            ;83DB7A;848097;
                       RTS                                  ;83DB7E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DB7F: %Set16bit(!MX)                             ;83DB7F;      ;
                       LDA.W #$0000                         ;83DB81;      ;
                       LDX.W #$0008                         ;83DB84;      ;
                       LDY.W #$0006                         ;83DB87;      ;
                       JSL.L VIP                            ;83DB8A;848097;
                       RTS                                  ;83DB8E;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DB8F;      ;
                       LDA.L $7F1F66                        ;83DB91;7F1F66;
                       AND.W #$0010                         ;83DB95;      ;
                       BNE CODE_83DB9C                      ;83DB98;83DB9C;
                       BRA CODE_83DBB7                      ;83DB9A;83DBB7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DB9C: %Set16bit(!MX)                             ;83DB9C;      ;
                       LDA.L $7F1F6E                        ;83DB9E;7F1F6E;
                       AND.W #$0002                         ;83DBA2;      ;
                       BEQ CODE_83DBB7                      ;83DBA5;83DBB7;
                       %Set16bit(!MX)                             ;83DBA7;      ;
                       LDA.W #$0000                         ;83DBA9;      ;
                       LDX.W #$0022                         ;83DBAC;      ;
                       LDY.W #$000B                         ;83DBAF;      ;
                       JSL.L VIP                            ;83DBB2;848097;
                       RTS                                  ;83DBB6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DBB7: %Set8bit(!M)                             ;83DBB7;      ;
                       %Set16bit(!X)                             ;83DBB9;      ;
                       LDA.L !season                        ;83DBBB;7F1F19;
                       CMP.B #$03                           ;83DBBF;      ;
                       BNE CODE_83DBE6                      ;83DBC1;83DBE6;
                       LDA.L !day                        ;83DBC3;7F1F1B;
                       CMP.B #$18                           ;83DBC7;      ;
                       BNE CODE_83DBE6                      ;83DBC9;83DBE6;
                       %Set16bit(!M)                             ;83DBCB;      ;
                       LDA.L $7F1F74                        ;83DBCD;7F1F74;
                       AND.W #$0004                         ;83DBD1;      ;
                       BEQ CODE_83DBE6                      ;83DBD4;83DBE6;
                       %Set16bit(!MX)                             ;83DBD6;      ;
                       LDA.W #$0000                         ;83DBD8;      ;
                       LDX.W #$000F                         ;83DBDB;      ;
                       LDY.W #$0003                         ;83DBDE;      ;
                       JSL.L VIP                            ;83DBE1;848097;
                       RTS                                  ;83DBE5;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DBE6: %Set16bit(!MX)                             ;83DBE6;      ;
                       LDA.L $7F1F68                        ;83DBE8;7F1F68;
                       AND.W #$0002                         ;83DBEC;      ;
                       BNE CODE_83DC0E                      ;83DBEF;83DC0E;
                       %Set16bit(!MX)                             ;83DBF1;      ;
                       LDA.W #$0000                         ;83DBF3;      ;
                       LDX.W #$000B                         ;83DBF6;      ;
                       LDY.W #$0007                         ;83DBF9;      ;
                       JSL.L VIP                            ;83DBFC;848097;
                       %Set16bit(!MX)                             ;83DC00;      ;
                       LDA.L $7F1F68                        ;83DC02;7F1F68;
                       ORA.W #$0002                         ;83DC06;      ;
                       STA.L $7F1F68                        ;83DC09;7F1F68;
                       RTS                                  ;83DC0D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DC0E: %Set16bit(!MX)                             ;83DC0E;      ;
                       LDA.W #$0000                         ;83DC10;      ;
                       LDX.W #$0005                         ;83DC13;      ;
                       LDY.W #$0000                         ;83DC16;      ;
                       JSL.L VIP                            ;83DC19;848097;
                       RTS                                  ;83DC1D;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DC1E;      ;
                       LDA.L $7F1F66                        ;83DC20;7F1F66;
                       AND.W #$0010                         ;83DC24;      ;
                       BNE CODE_83DC2C                      ;83DC27;83DC2C;
                       JMP.W CODE_83DBB7                    ;83DC29;83DBB7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DC2C: %Set16bit(!MX)                             ;83DC2C;      ;
                       LDA.L $7F1F6E                        ;83DC2E;7F1F6E;
                       AND.W #$0002                         ;83DC32;      ;
                       BNE CODE_83DC3A                      ;83DC35;83DC3A;
                       JMP.W CODE_83DBB7                    ;83DC37;83DBB7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DC3A: %Set16bit(!MX)                             ;83DC3A;      ;
                       LDA.W #$0000                         ;83DC3C;      ;
                       LDX.W #$0022                         ;83DC3F;      ;
                       LDY.W #$000C                         ;83DC42;      ;
                       JSL.L VIP                            ;83DC45;848097;
                       RTS                                  ;83DC49;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DC4A;      ;
                       LDA.L $7F1F68                        ;83DC4C;7F1F68;
                       AND.W #$0004                         ;83DC50;      ;
                       BNE CODE_83DC72                      ;83DC53;83DC72;
                       %Set16bit(!MX)                             ;83DC55;      ;
                       LDA.W #$0000                         ;83DC57;      ;
                       LDX.W #$000B                         ;83DC5A;      ;
                       LDY.W #$0009                         ;83DC5D;      ;
                       JSL.L VIP                            ;83DC60;848097;
                       %Set16bit(!M)                             ;83DC64;      ;
                       LDA.L $7F1F68                        ;83DC66;7F1F68;
                       ORA.W #$0004                         ;83DC6A;      ;
                       STA.L $7F1F68                        ;83DC6D;7F1F68;
                       RTS                                  ;83DC71;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DC72: %Set16bit(!MX)                             ;83DC72;      ;
                       LDA.L $7F1F5E                        ;83DC74;7F1F5E;
                       AND.W #$0020                         ;83DC78;      ;
                       BEQ CODE_83DC8D                      ;83DC7B;83DC8D;
                       %Set16bit(!MX)                             ;83DC7D;      ;
                       LDA.W #$0000                         ;83DC7F;      ;
                       LDX.W #$001D                         ;83DC82;      ;
                       LDY.W #$0003                         ;83DC85;      ;
                       JSL.L VIP                            ;83DC88;848097;
                       RTS                                  ;83DC8C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DC8D: %Set16bit(!MX)                             ;83DC8D;      ;
                       LDA.L $7F1F6C                        ;83DC8F;7F1F6C;
                       AND.W #$0010                         ;83DC93;      ;
                       BEQ CODE_83DCA8                      ;83DC96;83DCA8;
                       %Set16bit(!MX)                             ;83DC98;      ;
                       LDA.W #$0000                         ;83DC9A;      ;
                       LDX.W #$001D                         ;83DC9D;      ;
                       LDY.W #$0001                         ;83DCA0;      ;
                       JSL.L VIP                            ;83DCA3;848097;
                       RTS                                  ;83DCA7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DCA8: %Set16bit(!MX)                             ;83DCA8;      ;
                       LDA.L $7F1F6C                        ;83DCAA;7F1F6C;
                       AND.W #$0004                         ;83DCAE;      ;
                       BEQ CODE_83DCDF                      ;83DCB1;83DCDF;
                       LDA.L $7F1F5E                        ;83DCB3;7F1F5E;
                       AND.W #$0008                         ;83DCB7;      ;
                       BNE CODE_83DCCD                      ;83DCBA;83DCCD;
                       %Set16bit(!MX)                             ;83DCBC;      ;
                       LDA.W #$0009                         ;83DCBE;      ;
                       LDX.W #$001C                         ;83DCC1;      ;
                       LDY.W #$0001                         ;83DCC4;      ;
                       JSL.L VIP                            ;83DCC7;848097;
                       BRA CODE_83DD3F                      ;83DCCB;83DD3F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DCCD: %Set16bit(!MX)                             ;83DCCD;      ;
                       LDA.W #$0009                         ;83DCCF;      ;
                       LDX.W #$001C                         ;83DCD2;      ;
                       LDY.W #$0002                         ;83DCD5;      ;
                       JSL.L VIP                            ;83DCD8;848097;
                       JMP.W CODE_83DD74                    ;83DCDC;83DD74;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DCDF: %Set8bit(!M)                             ;83DCDF;      ;
                       %Set16bit(!X)                             ;83DCE1;      ;
                       LDA.L !year                        ;83DCE3;7F1F18;
                       BEQ CODE_83DD3F                      ;83DCE7;83DD3F;
                       LDA.L !season                        ;83DCE9;7F1F19;
                       CMP.B #$02                           ;83DCED;      ;
                       BCC CODE_83DD3F                      ;83DCEF;83DD3F;
                       LDA.L !day                        ;83DCF1;7F1F1B;
                       CMP.B #$01                           ;83DCF5;      ;
                       BEQ CODE_83DD3F                      ;83DCF7;83DD3F;
                       CMP.B #$08                           ;83DCF9;      ;
                       BCC CODE_83DD0F                      ;83DCFB;83DD0F;
                       CMP.B #$0D                           ;83DCFD;      ;
                       BCC CODE_83DD3F                      ;83DCFF;83DD3F;
                       CMP.B #$12                           ;83DD01;      ;
                       BCC CODE_83DD0F                      ;83DD03;83DD0F;
                       CMP.B #$19                           ;83DD05;      ;
                       BCC CODE_83DD3F                      ;83DD07;83DD3F;
                       CMP.B #$1D                           ;83DD09;      ;
                       BCC CODE_83DD0F                      ;83DD0B;83DD0F;
                       BRA CODE_83DD3F                      ;83DD0D;83DD3F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DD0F: %Set16bit(!M)                             ;83DD0F;      ;
                       LDA.W $0196                          ;83DD11;000196;
                       AND.W #$001A                         ;83DD14;      ;
                       BNE CODE_83DD3F                      ;83DD17;83DD3F;
                       LDA.L $7F1F6A                        ;83DD19;7F1F6A;
                       AND.W #$0200                         ;83DD1D;      ;
                       BNE CODE_83DD3F                      ;83DD20;83DD3F;
                       %Set8bit(!M)                             ;83DD22;      ;
                       LDA.L !weekday                        ;83DD24;7F1F1A;
                       BEQ CODE_83DD3F                      ;83DD28;83DD3F;
                       CMP.B #$06                           ;83DD2A;      ;
                       BEQ CODE_83DD3F                      ;83DD2C;83DD3F;
                       %Set16bit(!MX)                             ;83DD2E;      ;
                       LDA.W #$0009                         ;83DD30;      ;
                       LDX.W #$0021                         ;83DD33;      ;
                       LDY.W #$0000                         ;83DD36;      ;
                       JSL.L VIP                            ;83DD39;848097;
                       BRA CODE_83DD3F                      ;83DD3D;83DD3F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DD3F: %Set16bit(!MX)                             ;83DD3F;      ;
                       LDA.W $0196                          ;83DD41;000196;
                       AND.W #$0008                         ;83DD44;      ;
                       BNE CODE_83DD74                      ;83DD47;83DD74;
                       LDA.W $0196                          ;83DD49;000196;
                       AND.W #$0200                         ;83DD4C;      ;
                       BNE CODE_83DD74                      ;83DD4F;83DD74;
                       LDA.W $0196                          ;83DD51;000196;
                       AND.W #$0002                         ;83DD54;      ;
                       BNE CODE_83DD74                      ;83DD57;83DD74;
                       %Set8bit(!M)                             ;83DD59;      ;
                       LDA.L !weekday                        ;83DD5B;7F1F1A;
                       BEQ CODE_83DD75                      ;83DD5F;83DD75;
                       CMP.B #$06                           ;83DD61;      ;
                       BEQ CODE_83DD85                      ;83DD63;83DD85;
                       %Set16bit(!MX)                             ;83DD65;      ;
                       LDA.W #$0000                         ;83DD67;      ;
                       LDX.W #$0001                         ;83DD6A;      ;
                       LDY.W #$0008                         ;83DD6D;      ;
                       JSL.L VIP                            ;83DD70;848097;
                                                            ;      ;      ;
          CODE_83DD74: RTS                                  ;83DD74;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DD75: %Set16bit(!MX)                             ;83DD75;      ;
                       LDA.W #$0000                         ;83DD77;      ;
                       LDX.W #$0003                         ;83DD7A;      ;
                       LDY.W #$0002                         ;83DD7D;      ;
                       JSL.L VIP                            ;83DD80;848097;
                       RTS                                  ;83DD84;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DD85: %Set16bit(!MX)                             ;83DD85;      ;
                       LDA.W #$0000                         ;83DD87;      ;
                       LDX.W #$0002                         ;83DD8A;      ;
                       LDY.W #$0003                         ;83DD8D;      ;
                       JSL.L VIP                            ;83DD90;848097;
                       RTS                                  ;83DD94;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DD95;      ;
                       LDA.L $7F1F6A                        ;83DD97;7F1F6A;
                       AND.W #$2000                         ;83DD9B;      ;
                       BNE CODE_83DDB9                      ;83DD9E;83DDB9;
                       LDA.L $7F1F6A                        ;83DDA0;7F1F6A;
                       AND.W #$1000                         ;83DDA4;      ;
                       BEQ CODE_83DDB9                      ;83DDA7;83DDB9;
                       %Set16bit(!MX)                             ;83DDA9;      ;
                       LDA.W #$0000                         ;83DDAB;      ;
                       LDX.W #$0019                         ;83DDAE;      ;
                       LDY.W #$0001                         ;83DDB1;      ;
                       JSL.L VIP                            ;83DDB4;848097;
                       RTS                                  ;83DDB8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DDB9: %Set16bit(!MX)                             ;83DDB9;      ;
                       LDA.L $7F1F68                        ;83DDBB;7F1F68;
                       AND.W #$0008                         ;83DDBF;      ;
                       BNE CODE_83DE0A                      ;83DDC2;83DE0A;
                       %Set8bit(!M)                             ;83DDC4;      ;
                       LDA.L !year                        ;83DDC6;7F1F18;
                       BNE CODE_83DDFD                      ;83DDCA;83DDFD;
                       LDA.L !season                        ;83DDCC;7F1F19;
                       CMP.B #$02                           ;83DDD0;      ;
                       BCS CODE_83DDFD                      ;83DDD2;83DDFD;
                       CMP.B #$00                           ;83DDD4;      ;
                       BEQ CODE_83DDE0                      ;83DDD6;83DDE0;
                       LDA.L !day                        ;83DDD8;7F1F1B;
                       CMP.B #$1A                           ;83DDDC;      ;
                       BCS CODE_83DDFD                      ;83DDDE;83DDFD;
                                                            ;      ;      ;
          CODE_83DDE0: %Set16bit(!MX)                             ;83DDE0;      ;
                       LDA.W #$0000                         ;83DDE2;      ;
                       LDX.W #$000B                         ;83DDE5;      ;
                       LDY.W #$000A                         ;83DDE8;      ;
                       JSL.L VIP                            ;83DDEB;848097;
                       %Set16bit(!M)                             ;83DDEF;      ;
                       LDA.L $7F1F68                        ;83DDF1;7F1F68;
                       ORA.W #$0008                         ;83DDF5;      ;
                       STA.L $7F1F68                        ;83DDF8;7F1F68;
                       RTS                                  ;83DDFC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DDFD: %Set16bit(!M)                             ;83DDFD;      ;
                       LDA.L $7F1F68                        ;83DDFF;7F1F68;
                       ORA.W #$0008                         ;83DE03;      ;
                       STA.L $7F1F68                        ;83DE06;7F1F68;
                                                            ;      ;      ;
          CODE_83DE0A: %Set16bit(!MX)                             ;83DE0A;      ;
                       LDA.W $0196                          ;83DE0C;000196;
                       AND.W #$0008                         ;83DE0F;      ;
                       BNE CODE_83DE44                      ;83DE12;83DE44;
                       LDA.W $0196                          ;83DE14;000196;
                       AND.W #$0200                         ;83DE17;      ;
                       BNE CODE_83DE54                      ;83DE1A;83DE54;
                       LDA.W $0196                          ;83DE1C;000196;
                       AND.W #$0002                         ;83DE1F;      ;
                       BNE CODE_83DE34                      ;83DE22;83DE34;
                       %Set16bit(!MX)                             ;83DE24;      ;
                       LDA.W #$0000                         ;83DE26;      ;
                       LDX.W #$0001                         ;83DE29;      ;
                       LDY.W #$0009                         ;83DE2C;      ;
                       JSL.L VIP                            ;83DE2F;848097;
                       RTS                                  ;83DE33;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DE34: %Set16bit(!MX)                             ;83DE34;      ;
                       LDA.W #$0000                         ;83DE36;      ;
                       LDX.W #$0004                         ;83DE39;      ;
                       LDY.W #$0007                         ;83DE3C;      ;
                       JSL.L VIP                            ;83DE3F;848097;
                       RTS                                  ;83DE43;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DE44: %Set16bit(!MX)                             ;83DE44;      ;
                       LDA.W #$0000                         ;83DE46;      ;
                       LDX.W #$0007                         ;83DE49;      ;
                       LDY.W #$0007                         ;83DE4C;      ;
                       JSL.L VIP                            ;83DE4F;848097;
                       RTS                                  ;83DE53;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DE54: %Set16bit(!MX)                             ;83DE54;      ;
                       LDA.W #$0000                         ;83DE56;      ;
                       LDX.W #$0008                         ;83DE59;      ;
                       LDY.W #$0007                         ;83DE5C;      ;
                       JSL.L VIP                            ;83DE5F;848097;
                       RTS                                  ;83DE63;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83DE64;      ;
                       LDA.L $7F1F68                        ;83DE66;7F1F68;
                       AND.W #$2000                         ;83DE6A;      ;
                       BNE CODE_83DE7F                      ;83DE6D;83DE7F;
                       %Set16bit(!MX)                             ;83DE6F;      ;
                       LDA.W #$0000                         ;83DE71;      ;
                       LDX.W #$0015                         ;83DE74;      ;
                       LDY.W #$0000                         ;83DE77;      ;
                       JSL.L VIP                            ;83DE7A;848097;
                       RTS                                  ;83DE7E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DE7F: %Set16bit(!MX)                             ;83DE7F;      ;
                       LDA.L $7F1F64                        ;83DE81;7F1F64;
                       AND.W #$0002                         ;83DE85;      ;
                       BEQ CODE_83DE9A                      ;83DE88;83DE9A;
                       %Set16bit(!MX)                             ;83DE8A;      ;
                       LDA.W #$0000                         ;83DE8C;      ;
                       LDX.W #$0001                         ;83DE8F;      ;
                       LDY.W #$000A                         ;83DE92;      ;
                       JSL.L VIP                            ;83DE95;848097;
                       RTS                                  ;83DE99;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DE9A: RTS                                  ;83DE9A;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;83DE9B;      ;
                       LDA.L $7F1F64                        ;83DE9D;7F1F64;
                       AND.W #$0008                         ;83DEA1;      ;
                       BEQ CODE_83DED2                      ;83DEA4;83DED2;
                       %Set16bit(!M)                             ;83DEA6;      ;
                       LDA.W #$0015                         ;83DEA8;      ;
                       LDX.W #$0000                         ;83DEAB;      ;
                       LDY.W #$0025                         ;83DEAE;      ;
                       JSL.L VIP                            ;83DEB1;848097;
                       %Set8bit(!M)                             ;83DEB5;      ;
                       LDA.B #$45                           ;83DEB7;      ;
                       STA.W $096E                          ;83DEB9;00096E;
                       STZ.W $096F                          ;83DEBC;00096F;
                       STZ.W $0970                          ;83DEBF;000970;
                       %Set16bit(!MX)                             ;83DEC2;      ;
                       LDA.B !game_state                            ;83DEC4;0000D2;
                       ORA.W #$0040                         ;83DEC6;      ;
                       STA.B !game_state                            ;83DEC9;0000D2;
                       %Set16bit(!MX)                             ;83DECB;      ;
                       LDA.W #$0000                         ;83DECD;      ;
                       STA.B !player_action                            ;83DED0;0000D4;
                                                            ;      ;      ;
          CODE_83DED2: RTS                                  ;83DED2;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83DED3;      ;
                       %Set16bit(!X)                             ;83DED5;      ;
                       LDA.L !year                        ;83DED7;7F1F18;
                       CMP.B #$02                           ;83DEDB;      ;
                       BNE CODE_83DEF2                      ;83DEDD;83DEF2;
                       LDA.L !season                        ;83DEDF;7F1F19;
                       CMP.B #$01                           ;83DEE3;      ;
                       BNE CODE_83DEF2                      ;83DEE5;83DEF2;
                       LDA.L !day                        ;83DEE7;7F1F1B;
                       CMP.B #$1E                           ;83DEEB;      ;
                       BNE CODE_83DEF2                      ;83DEED;83DEF2;
                       JMP.W CODE_83F4D8                    ;83DEEF;83F4D8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DEF2: %Set16bit(!MX)                             ;83DEF2;      ;
                       LDA.L $7F1F64                        ;83DEF4;7F1F64;
                       AND.W #$0080                         ;83DEF8;      ;
                       BEQ CODE_83DF06                      ;83DEFB;83DF06;
                       %Set8bit(!M)                             ;83DEFD;      ;
                       LDA.B #$17                           ;83DEFF;      ;
                       STA.W !transition_dest                          ;83DF01;00098B;
                       BRA CODE_83DF1A                      ;83DF04;83DF1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DF06: %Set16bit(!MX)                             ;83DF06;      ;
                       LDA.L $7F1F64                        ;83DF08;7F1F64;
                       AND.W #$0040                         ;83DF0C;      ;
                       BEQ CODE_83DF1A                      ;83DF0F;83DF1A;
                       %Set8bit(!M)                             ;83DF11;      ;
                       LDA.B #$16                           ;83DF13;      ;
                       STA.W !transition_dest                          ;83DF15;00098B;
                       BRA CODE_83DF1A                      ;83DF18;83DF1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DF1A: %Set16bit(!MX)                             ;83DF1A;      ;
                       LDA.L $7F1F6C                        ;83DF1C;7F1F6C;
                       AND.W #$2000                         ;83DF20;      ;
                       BEQ CODE_83DF47                      ;83DF23;83DF47;
                       LDA.L $7F1F6C                        ;83DF25;7F1F6C;
                       AND.W #$4000                         ;83DF29;      ;
                       BNE CODE_83DF47                      ;83DF2C;83DF47;
                       LDA.W #$009C                         ;83DF2E;      ;
                       STA.W !tile_in_front_X                          ;83DF31;000985;
                       LDA.W #$0090                         ;83DF34;      ;
                       STA.W !tile_in_front_Y                          ;83DF37;000987;
                       LDA.W #$0010                         ;83DF3A;      ;
                       LDX.W #$0000                         ;83DF3D;      ;
                       LDY.W #$001F                         ;83DF40;      ;
                       JSL.L CODE_8480F8                    ;83DF43;8480F8;
                                                            ;      ;      ;
          CODE_83DF47: %Set16bit(!MX)                             ;83DF47;      ;
                       LDA.L $7F1F6E                        ;83DF49;7F1F6E;
                       AND.W #$0080                         ;83DF4D;      ;
                       BNE CODE_83DF55                      ;83DF50;83DF55;
                       JMP.W CODE_83DFF8                    ;83DF52;83DFF8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83DF55: LDA.L $7F1F6E                        ;83DF55;7F1F6E;
                       AND.W #$FF7F                         ;83DF59;      ;
                       STA.L $7F1F6E                        ;83DF5C;7F1F6E;
                       %Set8bit(!M)                             ;83DF60;      ;
                       LDA.B #$19                           ;83DF62;      ;
                       JSL.L UNK_Audio26                          ;83DF64;8382C6;
                       %Set8bit(!M)                             ;83DF68;      ;
                       %Set16bit(!X)                             ;83DF6A;      ;
                       LDA.B #$02                           ;83DF6C;      ;
                       LDX.W #$0240                         ;83DF6E;      ;
                       LDY.W #$02C0                         ;83DF71;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DF74;82B049;
                       %Set8bit(!M)                             ;83DF78;      ;
                       %Set16bit(!X)                             ;83DF7A;      ;
                       LDA.B #$02                           ;83DF7C;      ;
                       LDX.W #$0250                         ;83DF7E;      ;
                       LDY.W #$02C0                         ;83DF81;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DF84;82B049;
                       %Set8bit(!M)                             ;83DF88;      ;
                       %Set16bit(!X)                             ;83DF8A;      ;
                       LDA.B #$02                           ;83DF8C;      ;
                       LDX.W #$0260                         ;83DF8E;      ;
                       LDY.W #$02C0                         ;83DF91;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DF94;82B049;
                       %Set8bit(!M)                             ;83DF98;      ;
                       %Set16bit(!X)                             ;83DF9A;      ;
                       LDA.B #$02                           ;83DF9C;      ;
                       LDX.W #$0240                         ;83DF9E;      ;
                       LDY.W #$02D0                         ;83DFA1;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DFA4;82B049;
                       %Set8bit(!M)                             ;83DFA8;      ;
                       %Set16bit(!X)                             ;83DFAA;      ;
                       LDA.B #$02                           ;83DFAC;      ;
                       LDX.W #$0250                         ;83DFAE;      ;
                       LDY.W #$02D0                         ;83DFB1;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DFB4;82B049;
                       %Set8bit(!M)                             ;83DFB8;      ;
                       %Set16bit(!X)                             ;83DFBA;      ;
                       LDA.B #$02                           ;83DFBC;      ;
                       LDX.W #$0260                         ;83DFBE;      ;
                       LDY.W #$02D0                         ;83DFC1;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DFC4;82B049;
                       %Set8bit(!M)                             ;83DFC8;      ;
                       %Set16bit(!X)                             ;83DFCA;      ;
                       LDA.B #$02                           ;83DFCC;      ;
                       LDX.W #$0240                         ;83DFCE;      ;
                       LDY.W #$02E0                         ;83DFD1;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DFD4;82B049;
                       %Set8bit(!M)                             ;83DFD8;      ;
                       %Set16bit(!X)                             ;83DFDA;      ;
                       LDA.B #$02                           ;83DFDC;      ;
                       LDX.W #$0250                         ;83DFDE;      ;
                       LDY.W #$02E0                         ;83DFE1;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DFE4;82B049;
                       %Set8bit(!M)                             ;83DFE8;      ;
                       %Set16bit(!X)                             ;83DFEA;      ;
                       LDA.B #$02                           ;83DFEC;      ;
                       LDX.W #$0260                         ;83DFEE;      ;
                       LDY.W #$02E0                         ;83DFF1;      ;
                       JSL.L EditTileonMapandsets0181                    ;83DFF4;82B049;
                                                            ;      ;      ;
          CODE_83DFF8: %Set16bit(!MX)                             ;83DFF8;      ;
                       LDA.L $7F1F6E                        ;83DFFA;7F1F6E;
                       AND.W #$0100                         ;83DFFE;      ;
                       BEQ CODE_83E016                      ;83E001;83E016;
                       LDA.L $7F1F6E                        ;83E003;7F1F6E;
                       AND.W #$FEFF                         ;83E007;      ;
                       STA.L $7F1F6E                        ;83E00A;7F1F6E;
                       %Set8bit(!M)                             ;83E00E;      ;
                       LDA.B #$15                           ;83E010;      ;
                       JSL.L UNK_Audio26                          ;83E012;8382C6;
                                                            ;      ;      ;
          CODE_83E016: %Set16bit(!MX)                             ;83E016;      ;
                       LDA.L $7F1F6E                        ;83E018;7F1F6E;
                       AND.W #$0200                         ;83E01C;      ;
                       BEQ CODE_83E04C                      ;83E01F;83E04C;
                       LDA.L $7F1F6E                        ;83E021;7F1F6E;
                       AND.W #$FDFF                         ;83E025;      ;
                       STA.L $7F1F6E                        ;83E028;7F1F6E;
                       %Set8bit(!M)                             ;83E02C;      ;
                       %Set16bit(!X)                             ;83E02E;      ;
                       LDA.B #$22                           ;83E030;      ;
                       LDX.W #$0007                         ;83E032;      ;
                       LDY.W #$0014                         ;83E035;      ;
                       JSL.L UNK_Audio24                          ;83E038;8382FE;
                       %Set8bit(!M)                             ;83E03C;      ;
                       %Set16bit(!X)                             ;83E03E;      ;
                       LDA.B #$22                           ;83E040;      ;
                       LDX.W #$0007                         ;83E042;      ;
                       LDY.W #$001E                         ;83E045;      ;
                       JSL.L UNK_Audio24                          ;83E048;8382FE;
                                                            ;      ;      ;
          CODE_83E04C: %Set16bit(!MX)                             ;83E04C;      ;
                       LDA.L $7F1F6E                        ;83E04E;7F1F6E;
                       AND.W #$0020                         ;83E052;      ;
                       BEQ CODE_83E074                      ;83E055;83E074;
                       %Set8bit(!M)                             ;83E057;      ;
                       %Set16bit(!X)                             ;83E059;      ;
                       LDA.B #$20                           ;83E05B;      ;
                       LDX.W #$0007                         ;83E05D;      ;
                       LDY.W #$003C                         ;83E060;      ;
                       JSL.L UNK_Audio24                          ;83E063;8382FE;
                       %Set16bit(!MX)                             ;83E067;      ;
                       LDA.L $7F1F6E                        ;83E069;7F1F6E;
                       AND.W #$FFDF                         ;83E06D;      ;
                       STA.L $7F1F6E                        ;83E070;7F1F6E;
                                                            ;      ;      ;
          CODE_83E074: %Set16bit(!MX)                             ;83E074;      ;
                       LDA.L $7F1F6E                        ;83E076;7F1F6E;
                       AND.W #$0010                         ;83E07A;      ;
                       BEQ CODE_83E0DB                      ;83E07D;83E0DB;
                       LDA.L $7F1F5E                        ;83E07F;7F1F5E;
                       AND.W #$4000                         ;83E083;      ;
                       BNE CODE_83E0CB                      ;83E086;83E0CB;
                       LDA.L $7F1F5E                        ;83E088;7F1F5E;
                       AND.W #$2000                         ;83E08C;      ;
                       BNE CODE_83E0A1                      ;83E08F;83E0A1;
                       %Set16bit(!MX)                             ;83E091;      ;
                       LDA.W #$0000                         ;83E093;      ;
                       LDX.W #$001F                         ;83E096;      ;
                       LDY.W #$0000                         ;83E099;      ;
                       JSL.L VIP                            ;83E09C;848097;
                       RTS                                  ;83E0A0;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E0A1: %Set16bit(!MX)                             ;83E0A1;      ;
                       LDA.W #$0000                         ;83E0A3;      ;
                       LDX.W #$001F                         ;83E0A6;      ;
                       LDY.W #$0001                         ;83E0A9;      ;
                       JSL.L VIP                            ;83E0AC;848097;
                       %Set16bit(!M)                             ;83E0B0;      ;
                       LDA.L !kid1_age                        ;83E0B2;7F1F37;
                       CMP.W #$003C                         ;83E0B6;      ;
                       BNE CODE_83E0C3                      ;83E0B9;83E0C3;
                       %Set8bit(!M)                             ;83E0BB;      ;
                       LDA.B #$05                           ;83E0BD;      ;
                       STA.W $099F                          ;83E0BF;00099F;
                       RTS                                  ;83E0C2;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E0C3: %Set8bit(!M)                             ;83E0C3;      ;
                       LDA.B #$06                           ;83E0C5;      ;
                       STA.W $099F                          ;83E0C7;00099F;
                       RTS                                  ;83E0CA;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E0CB: %Set16bit(!MX)                             ;83E0CB;      ;
                       LDA.W #$0000                         ;83E0CD;      ;
                       LDX.W #$001F                         ;83E0D0;      ;
                       LDY.W #$0002                         ;83E0D3;      ;
                       JSL.L VIP                            ;83E0D6;848097;
                       RTS                                  ;83E0DA;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E0DB: %Set16bit(!MX)                             ;83E0DB;      ;
                       LDA.L $7F1F6E                        ;83E0DD;7F1F6E;
                       AND.W #$0040                         ;83E0E1;      ;
                       BEQ CODE_83E144                      ;83E0E4;83E144;
                       %Set16bit(!MX)                             ;83E0E6;      ;
                       LDA.L $7F1F6E                        ;83E0E8;7F1F6E;
                       AND.W #$FFBF                         ;83E0EC;      ;
                       STA.L $7F1F6E                        ;83E0EF;7F1F6E;
                       %Set8bit(!M)                             ;83E0F3;      ;
                       LDA.B #$00                           ;83E0F5;      ;
                       XBA                                  ;83E0F7;      ;
                       LDA.W $0937                          ;83E0F8;000937;
                       %Set16bit(!M)                             ;83E0FB;      ;
                       JSL.L GetsCowPointer                ;83E0FD;83C9A7;
                       %Set8bit(!M)                             ;83E101;      ;
                       %Set16bit(!X)                             ;83E103;      ;
                       LDA.B #$00                           ;83E105;      ;
                       XBA                                  ;83E107;      ;
                       LDY.W #$000C                         ;83E108;      ;
                       LDA.B [$72],Y                        ;83E10B;000072;
                       %Set16bit(!M)                             ;83E10D;      ;
                       STA.W $0889                          ;83E10F;000889;
                       %Set8bit(!M)                             ;83E112;      ;
                       LDY.W #$000D                         ;83E114;      ;
                       LDA.B [$72],Y                        ;83E117;000072;
                       %Set16bit(!M)                             ;83E119;      ;
                       STA.W $088B                          ;83E11B;00088B;
                       %Set8bit(!M)                             ;83E11E;      ;
                       LDY.W #$000E                         ;83E120;      ;
                       LDA.B [$72],Y                        ;83E123;000072;
                       %Set16bit(!M)                             ;83E125;      ;
                       STA.W $088D                          ;83E127;00088D;
                       %Set8bit(!M)                             ;83E12A;      ;
                       LDY.W #$000F                         ;83E12C;      ;
                       LDA.B [$72],Y                        ;83E12F;000072;
                       STA.W $088F                          ;83E131;00088F;
                       %Set16bit(!MX)                             ;83E134;      ;
                       LDA.W #$0000                         ;83E136;      ;
                       LDX.W #$0020                         ;83E139;      ;
                       LDY.W #$0000                         ;83E13C;      ;
                       JSL.L VIP                            ;83E13F;848097;
                       RTS                                  ;83E143;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E144: %Set16bit(!MX)                             ;83E144;      ;
                       LDA.L $7F1F66                        ;83E146;7F1F66;
                       AND.W #$0001                         ;83E14A;      ;
                       BNE CODE_83E176                      ;83E14D;83E176;
                       LDA.L $7F1F66                        ;83E14F;7F1F66;
                       AND.W #$0002                         ;83E153;      ;
                       BNE CODE_83E186                      ;83E156;83E186;
                       LDA.L $7F1F66                        ;83E158;7F1F66;
                       AND.W #$0004                         ;83E15C;      ;
                       BNE CODE_83E193                      ;83E15F;83E193;
                       LDA.L $7F1F66                        ;83E161;7F1F66;
                       AND.W #$0008                         ;83E165;      ;
                       BNE CODE_83E1A0                      ;83E168;83E1A0;
                       LDA.L $7F1F66                        ;83E16A;7F1F66;
                       AND.W #$0010                         ;83E16E;      ;
                       BNE CODE_83E1AD                      ;83E171;83E1AD;
                       JMP.W CODE_83E2C6                    ;83E173;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E176: %Set16bit(!MX)                             ;83E176;      ;
                       LDA.L !hearts_maria                        ;83E178;7F1F1F;
                       CMP.W #$00C8                         ;83E17C;      ;
                       BCC CODE_83E184                      ;83E17F;83E184;
                       JMP.W CODE_83E210                    ;83E181;83E210;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E184: BRA CODE_83E1BA                      ;83E184;83E1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E186: %Set16bit(!MX)                             ;83E186;      ;
                       LDA.L !hearts_ann                        ;83E188;7F1F21;
                       CMP.W #$00C8                         ;83E18C;      ;
                       BCS CODE_83E210                      ;83E18F;83E210;
                       BRA CODE_83E1BA                      ;83E191;83E1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E193: %Set16bit(!MX)                             ;83E193;      ;
                       LDA.L !hearts_nina                        ;83E195;7F1F23;
                       CMP.W #$00C8                         ;83E199;      ;
                       BCS CODE_83E210                      ;83E19C;83E210;
                       BRA CODE_83E1BA                      ;83E19E;83E1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E1A0: %Set16bit(!MX)                             ;83E1A0;      ;
                       LDA.L !hearts_ellen                        ;83E1A2;7F1F25;
                       CMP.W #$00C8                         ;83E1A6;      ;
                       BCS CODE_83E210                      ;83E1A9;83E210;
                       BRA CODE_83E1BA                      ;83E1AB;83E1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E1AD: %Set16bit(!MX)                             ;83E1AD;      ;
                       LDA.L !hearts_eve                        ;83E1AF;7F1F27;
                       CMP.W #$00C8                         ;83E1B3;      ;
                       BCS CODE_83E210                      ;83E1B6;83E210;
                       BRA CODE_83E1BA                      ;83E1B8;83E1BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E1BA: %Set8bit(!M)                             ;83E1BA;      ;
                       %Set16bit(!X)                             ;83E1BC;      ;
                       LDA.L !hour                        ;83E1BE;7F1F1C;
                       CMP.B #$06                           ;83E1C2;      ;
                       BNE CODE_83E210                      ;83E1C4;83E210;
                       LDA.L !minutes                        ;83E1C6;7F1F1D;
                       BNE CODE_83E210                      ;83E1CA;83E210;
                       LDA.L !seconds                        ;83E1CC;7F1F1E;
                       BNE CODE_83E210                      ;83E1D0;83E210;
                       %Set16bit(!M)                             ;83E1D2;      ;
                       LDA.L $7F1F6E                        ;83E1D4;7F1F6E;
                       AND.W #$000C                         ;83E1D8;      ;
                       BNE CODE_83E210                      ;83E1DB;83E210;
                       LDA.L $7F1F6E                        ;83E1DD;7F1F6E;
                       AND.W #$0001                         ;83E1E1;      ;
                       BNE CODE_83E210                      ;83E1E4;83E210;
                       %Set16bit(!MX)                             ;83E1E6;      ;
                       LDA.W #$0000                         ;83E1E8;      ;
                       LDX.W #$0022                         ;83E1EB;      ;
                       LDY.W #$0000                         ;83E1EE;      ;
                       JSL.L VIP                            ;83E1F1;848097;
                       %Set16bit(!MX)                             ;83E1F5;      ;
                       LDA.L $7F1F6E                        ;83E1F7;7F1F6E;
                       ORA.W #$0003                         ;83E1FB;      ;
                       STA.L $7F1F6E                        ;83E1FE;7F1F6E;
                       LDA.L $7F1F5E                        ;83E202;7F1F5E;
                       ORA.W #$1000                         ;83E206;      ;
                       STA.L $7F1F5E                        ;83E209;7F1F5E;
                       JMP.W CODE_83E2C6                    ;83E20D;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E210: %Set16bit(!MX)                             ;83E210;      ;
                       LDA.L $7F1F5E                        ;83E212;7F1F5E;
                       AND.W #$EFFF                         ;83E216;      ;
                       STA.L $7F1F5E                        ;83E219;7F1F5E;
                       LDA.L $7F1F6E                        ;83E21D;7F1F6E;
                       AND.W #$0002                         ;83E221;      ;
                       BNE CODE_83E262                      ;83E224;83E262;
                       LDA.L $7F1F66                        ;83E226;7F1F66;
                       AND.W #$0001                         ;83E22A;      ;
                       BNE CODE_83E271                      ;83E22D;83E271;
                       LDA.L $7F1F66                        ;83E22F;7F1F66;
                       AND.W #$0002                         ;83E233;      ;
                       BEQ CODE_83E23B                      ;83E236;83E23B;
                       JMP.W CODE_83E282                    ;83E238;83E282;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E23B: LDA.L $7F1F66                        ;83E23B;7F1F66;
                       AND.W #$0004                         ;83E23F;      ;
                       BEQ CODE_83E247                      ;83E242;83E247;
                       JMP.W CODE_83E293                    ;83E244;83E293;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E247: LDA.L $7F1F66                        ;83E247;7F1F66;
                       AND.W #$0008                         ;83E24B;      ;
                       BEQ CODE_83E253                      ;83E24E;83E253;
                       JMP.W CODE_83E2A4                    ;83E250;83E2A4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E253: LDA.L $7F1F66                        ;83E253;7F1F66;
                       AND.W #$0010                         ;83E257;      ;
                       BEQ CODE_83E25F                      ;83E25A;83E25F;
                       JMP.W CODE_83E2B5                    ;83E25C;83E2B5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E25F: JMP.W CODE_83E2C6                    ;83E25F;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E262: %Set16bit(!MX)                             ;83E262;      ;
                       LDA.L $7F1F5E                        ;83E264;7F1F5E;
                       ORA.W #$1000                         ;83E268;      ;
                       STA.L $7F1F5E                        ;83E26B;7F1F5E;
                       BRA CODE_83E2C6                      ;83E26F;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E271: %Set16bit(!MX)                             ;83E271;      ;
                       LDA.W #$0013                         ;83E273;      ;
                       LDX.W #$0043                         ;83E276;      ;
                       LDY.W #$0000                         ;83E279;      ;
                       JSL.L VIP                            ;83E27C;848097;
                       BRA CODE_83E2C6                      ;83E280;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E282: %Set16bit(!MX)                             ;83E282;      ;
                       LDA.W #$0013                         ;83E284;      ;
                       LDX.W #$0043                         ;83E287;      ;
                       LDY.W #$0001                         ;83E28A;      ;
                       JSL.L VIP                            ;83E28D;848097;
                       BRA CODE_83E2C6                      ;83E291;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E293: %Set16bit(!MX)                             ;83E293;      ;
                       LDA.W #$0013                         ;83E295;      ;
                       LDX.W #$0043                         ;83E298;      ;
                       LDY.W #$0002                         ;83E29B;      ;
                       JSL.L VIP                            ;83E29E;848097;
                       BRA CODE_83E2C6                      ;83E2A2;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E2A4: %Set16bit(!MX)                             ;83E2A4;      ;
                       LDA.W #$0013                         ;83E2A6;      ;
                       LDX.W #$0043                         ;83E2A9;      ;
                       LDY.W #$0003                         ;83E2AC;      ;
                       JSL.L VIP                            ;83E2AF;848097;
                       BRA CODE_83E2C6                      ;83E2B3;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E2B5: %Set16bit(!MX)                             ;83E2B5;      ;
                       LDA.W #$0013                         ;83E2B7;      ;
                       LDX.W #$0043                         ;83E2BA;      ;
                       LDY.W #$0004                         ;83E2BD;      ;
                       JSL.L VIP                            ;83E2C0;848097;
                       BRA CODE_83E2C6                      ;83E2C4;83E2C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E2C6: %Set16bit(!MX)                             ;83E2C6;      ;
                       LDA.L $7F1F6E                        ;83E2C8;7F1F6E;
                       AND.W #$0004                         ;83E2CC;      ;
                       BEQ CODE_83E2E9                      ;83E2CF;83E2E9;
                       LDA.L !kid1_age                        ;83E2D1;7F1F37;
                       CMP.W #$003C                         ;83E2D5;      ;
                       BCC CODE_83E2E9                      ;83E2D8;83E2E9;
                       %Set16bit(!MX)                             ;83E2DA;      ;
                       LDA.W #$0014                         ;83E2DC;      ;
                       LDX.W #$0045                         ;83E2DF;      ;
                       LDY.W #$0000                         ;83E2E2;      ;
                       JSL.L VIP                            ;83E2E5;848097;
                                                            ;      ;      ;
          CODE_83E2E9: %Set16bit(!MX)                             ;83E2E9;      ;
                       LDA.L $7F1F6E                        ;83E2EB;7F1F6E;
                       AND.W #$0008                         ;83E2EF;      ;
                       BEQ CODE_83E30C                      ;83E2F2;83E30C;
                       LDA.L !kid2_age                        ;83E2F4;7F1F39;
                       CMP.W #$003C                         ;83E2F8;      ;
                       BCC CODE_83E30C                      ;83E2FB;83E30C;
                       %Set16bit(!MX)                             ;83E2FD;      ;
                       LDA.W #$0015                         ;83E2FF;      ;
                       LDX.W #$0045                         ;83E302;      ;
                       LDY.W #$0003                         ;83E305;      ;
                       JSL.L VIP                            ;83E308;848097;
                                                            ;      ;      ;
          CODE_83E30C: %Set16bit(!MX)                             ;83E30C;      ;
                       LDA.L $7F1F60                        ;83E30E;7F1F60;
                       AND.W #$0020                         ;83E312;      ;
                       BNE CODE_83E330                      ;83E315;83E330;
                       LDA.L $7F1F68                        ;83E317;7F1F68;
                       AND.W #$0001                         ;83E31B;      ;
                       BNE CODE_83E340                      ;83E31E;83E340;
                       %Set16bit(!MX)                             ;83E320;      ;
                       LDA.W #$0000                         ;83E322;      ;
                       LDX.W #$000A                         ;83E325;      ;
                       LDY.W #$0000                         ;83E328;      ;
                       JSL.L VIP                            ;83E32B;848097;
                       RTS                                  ;83E32F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E330: %Set16bit(!MX)                             ;83E330;      ;
                       LDA.W #$0000                         ;83E332;      ;
                       LDX.W #$000A                         ;83E335;      ;
                       LDY.W #$0003                         ;83E338;      ;
                       JSL.L VIP                            ;83E33B;848097;
                       RTS                                  ;83E33F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E340: %Set8bit(!M)                             ;83E340;      ;
                       %Set16bit(!X)                             ;83E342;      ;
                       LDA.L !year                        ;83E344;7F1F18;
                       CMP.B #$01                           ;83E348;      ;
                       BNE CODE_83E380                      ;83E34A;83E380;
                       LDA.L !season                        ;83E34C;7F1F19;
                       CMP.B #$01                           ;83E350;      ;
                       BNE CODE_83E380                      ;83E352;83E380;
                       LDA.L !day                        ;83E354;7F1F1B;
                       CMP.B #$01                           ;83E358;      ;
                       BNE CODE_83E380                      ;83E35A;83E380;
                       LDA.L !hour                        ;83E35C;7F1F1C;
                       CMP.B #$06                           ;83E360;      ;
                       BNE CODE_83E380                      ;83E362;83E380;
                       LDA.L !minutes                        ;83E364;7F1F1D;
                       BNE CODE_83E380                      ;83E368;83E380;
                       LDA.L !seconds                        ;83E36A;7F1F1E;
                       BNE CODE_83E380                      ;83E36E;83E380;
                       %Set16bit(!MX)                             ;83E370;      ;
                       LDA.W #$0000                         ;83E372;      ;
                       LDX.W #$000A                         ;83E375;      ;
                       LDY.W #$0004                         ;83E378;      ;
                       JSL.L VIP                            ;83E37B;848097;
                       RTS                                  ;83E37F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E380: %Set8bit(!M)                             ;83E380;      ;
                       %Set16bit(!X)                             ;83E382;      ;
                       LDA.L !year                        ;83E384;7F1F18;
                       CMP.B #$02                           ;83E388;      ;
                       BNE CODE_83E3C0                      ;83E38A;83E3C0;
                       LDA.L !season                        ;83E38C;7F1F19;
                       CMP.B #$01                           ;83E390;      ;
                       BNE CODE_83E3C0                      ;83E392;83E3C0;
                       LDA.L !day                        ;83E394;7F1F1B;
                       CMP.B #$1D                           ;83E398;      ;
                       BNE CODE_83E3C0                      ;83E39A;83E3C0;
                       LDA.L !hour                        ;83E39C;7F1F1C;
                       CMP.B #$06                           ;83E3A0;      ;
                       BNE CODE_83E3C0                      ;83E3A2;83E3C0;
                       LDA.L !minutes                        ;83E3A4;7F1F1D;
                       BNE CODE_83E3C0                      ;83E3A8;83E3C0;
                       LDA.L !seconds                        ;83E3AA;7F1F1E;
                       BNE CODE_83E3C0                      ;83E3AE;83E3C0;
                       %Set16bit(!MX)                             ;83E3B0;      ;
                       LDA.W #$0000                         ;83E3B2;      ;
                       LDX.W #$000A                         ;83E3B5;      ;
                       LDY.W #$0005                         ;83E3B8;      ;
                       JSL.L VIP                            ;83E3BB;848097;
                       RTS                                  ;83E3BF;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E3C0: %Set8bit(!M)                             ;83E3C0;      ;
                       %Set16bit(!X)                             ;83E3C2;      ;
                       LDA.L !season                        ;83E3C4;7F1F19;
                       BNE CODE_83E3E2                      ;83E3C8;83E3E2;
                       LDA.L !day                        ;83E3CA;7F1F1B;
                       CMP.B #$01                           ;83E3CE;      ;
                       BNE CODE_83E3E2                      ;83E3D0;83E3E2;
                       %Set16bit(!MX)                             ;83E3D2;      ;
                       LDA.W #$0000                         ;83E3D4;      ;
                       LDX.W #$0028                         ;83E3D7;      ;
                       LDY.W #$0000                         ;83E3DA;      ;
                       JSL.L VIP                            ;83E3DD;848097;
                       RTS                                  ;83E3E1;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E3E2: %Set8bit(!M)                             ;83E3E2;      ;
                       %Set16bit(!X)                             ;83E3E4;      ;
                       LDA.L !season                        ;83E3E6;7F1F19;
                       CMP.B #$03                           ;83E3EA;      ;
                       BNE CODE_83E406                      ;83E3EC;83E406;
                       LDA.L !day                        ;83E3EE;7F1F1B;
                       CMP.B #$18                           ;83E3F2;      ;
                       BNE CODE_83E406                      ;83E3F4;83E406;
                       %Set16bit(!MX)                             ;83E3F6;      ;
                       LDA.W #$0000                         ;83E3F8;      ;
                       LDX.W #$000F                         ;83E3FB;      ;
                       LDY.W #$0000                         ;83E3FE;      ;
                       JSL.L VIP                            ;83E401;848097;
                       RTS                                  ;83E405;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E406: RTS                                  ;83E406;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E407;      ;
                       LDA.L $7F1F5C                        ;83E409;7F1F5C;
                       AND.W #$FF7F                         ;83E40D;      ;
                       STA.L $7F1F5C                        ;83E410;7F1F5C;
                       %Set16bit(!MX)                             ;83E414;      ;
                       LDA.W #$0015                         ;83E416;      ;
                       LDX.W #$0000                         ;83E419;      ;
                       LDY.W #$0015                         ;83E41C;      ;
                       JSL.L VIP                            ;83E41F;848097;
                       %Set16bit(!M)                             ;83E423;      ;
                       LDA.L $7F1F68                        ;83E425;7F1F68;
                       AND.W #$0001                         ;83E429;      ;
                       BNE CODE_83E464                      ;83E42C;83E464;
                       LDA.L $7F1F68                        ;83E42E;7F1F68;
                       AND.W #$0010                         ;83E432;      ;
                       BNE CODE_83E454                      ;83E435;83E454;
                       %Set16bit(!MX)                             ;83E437;      ;
                       LDA.W #$0000                         ;83E439;      ;
                       LDX.W #$000A                         ;83E43C;      ;
                       LDY.W #$0001                         ;83E43F;      ;
                       JSL.L VIP                            ;83E442;848097;
                       %Set16bit(!M)                             ;83E446;      ;
                       LDA.L $7F1F68                        ;83E448;7F1F68;
                       ORA.W #$0010                         ;83E44C;      ;
                       STA.L $7F1F68                        ;83E44F;7F1F68;
                       RTS                                  ;83E453;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E454: %Set16bit(!MX)                             ;83E454;      ;
                       LDA.W #$0000                         ;83E456;      ;
                       LDX.W #$000B                         ;83E459;      ;
                       LDY.W #$000B                         ;83E45C;      ;
                       JSL.L VIP                            ;83E45F;848097;
                       RTS                                  ;83E463;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E464: %Set8bit(!M)                             ;83E464;      ;
                       %Set16bit(!X)                             ;83E466;      ;
                       LDA.L !year                        ;83E468;7F1F18;
                       BNE CODE_83E478                      ;83E46C;83E478;
                       %Set8bit(!M)                             ;83E46E;      ;
                       LDA.L !season                        ;83E470;7F1F19;
                       CMP.B #$03                           ;83E474;      ;
                       BNE CODE_83E4CA                      ;83E476;83E4CA;
                                                            ;      ;      ;
          CODE_83E478: %Set16bit(!M)                             ;83E478;      ;
                       LDA.L $7F1F68                        ;83E47A;7F1F68;
                       AND.W #$0040                         ;83E47E;      ;
                       BNE CODE_83E4A7                      ;83E481;83E4A7;
                       %Set16bit(!MX)                             ;83E483;      ;
                       LDA.W #$0000                         ;83E485;      ;
                       LDX.W #$000D                         ;83E488;      ;
                       LDY.W #$0000                         ;83E48B;      ;
                       JSL.L VIP                            ;83E48E;848097;
                       %Set16bit(!M)                             ;83E492;      ;
                       LDA.L $7F1F68                        ;83E494;7F1F68;
                       ORA.W #$0040                         ;83E498;      ;
                       STA.L $7F1F68                        ;83E49B;7F1F68;
                       %Set8bit(!M)                             ;83E49F;      ;
                       LDA.B #$04                           ;83E4A1;      ;
                       STA.W $099F                          ;83E4A3;00099F;
                       RTS                                  ;83E4A6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E4A7: %Set16bit(!MX)                             ;83E4A7;      ;
                       LDA.L $7F1F68                        ;83E4A9;7F1F68;
                       AND.W #$0100                         ;83E4AD;      ;
                       BNE CODE_83E4CA                      ;83E4B0;83E4CA;
                       %Set16bit(!MX)                             ;83E4B2;      ;
                       LDA.W #$0000                         ;83E4B4;      ;
                       LDX.W #$000D                         ;83E4B7;      ;
                       LDY.W #$0001                         ;83E4BA;      ;
                       JSL.L VIP                            ;83E4BD;848097;
                       %Set8bit(!M)                             ;83E4C1;      ;
                       LDA.B #$00                           ;83E4C3;      ;
                       STA.L $7F1F31                        ;83E4C5;7F1F31;
                       RTS                                  ;83E4C9;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E4CA: RTS                                  ;83E4CA;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E4CB;      ;
                       LDA.L $7F1F6A                        ;83E4CD;7F1F6A;
                       AND.W #$0040                         ;83E4D1;      ;
                       BNE CODE_83E4EF                      ;83E4D4;83E4EF;
                       LDA.W #$00E0                         ;83E4D6;      ;
                       STA.W !tile_in_front_X                          ;83E4D9;000985;
                       LDA.W #$0180                         ;83E4DC;      ;
                       STA.W !tile_in_front_Y                          ;83E4DF;000987;
                       LDA.W #$0010                         ;83E4E2;      ;
                       LDX.W #$0000                         ;83E4E5;      ;
                       LDY.W #$001F                         ;83E4E8;      ;
                       JSL.L CODE_8480F8                    ;83E4EB;8480F8;
                                                            ;      ;      ;
          CODE_83E4EF: %Set16bit(!MX)                             ;83E4EF;      ;
                       LDA.B !player_pos_Y                            ;83E4F1;0000D8;
                       CMP.W #$0200                         ;83E4F3;      ;
                       BCC CODE_83E535                      ;83E4F6;83E535;
                       %Set16bit(!MX)                             ;83E4F8;      ;
                       LDA.B !game_state                            ;83E4FA;0000D2;
                       AND.W #$0800                         ;83E4FC;      ;
                       BNE CODE_83E504                      ;83E4FF;83E504;
                       JMP.W CODE_83E535                    ;83E501;83E535;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E504: %Set16bit(!MX)                             ;83E504;      ;
                       LDA.W #$0800                         ;83E506;      ;
                       EOR.W #$FFFF                         ;83E509;      ;
                       AND.B !game_state                            ;83E50C;0000D2;
                       STA.B !game_state                            ;83E50E;0000D2;
                       %Set8bit(!M)                             ;83E510;      ;
                       LDA.L !season                        ;83E512;7F1F19;
                       STA.L !dog_map                        ;83E516;7F1F30;
                       %Set16bit(!MX)                             ;83E51A;      ;
                       LDA.W #$0078                         ;83E51C;      ;
                       STA.L !dog_pos_X                        ;83E51F;7F1F2C;
                       LDA.W #$01A8                         ;83E523;      ;
                       STA.L !dog_pos_Y                        ;83E526;7F1F2E;
                       %Set16bit(!MX)                             ;83E52A;      ;
                       LDA.W #$0000                         ;83E52C;      ;
                       CLC                                  ;83E52F;      ;
                       ADC.B !player_direction                            ;83E530;0000DA;
                       STA.W $0901                          ;83E532;000901;
                                                            ;      ;      ;
          CODE_83E535: %Set16bit(!MX)                             ;83E535;      ;
                       LDA.L $7F1F6C                        ;83E537;7F1F6C;
                       AND.W #$0010                         ;83E53B;      ;
                       BEQ CODE_83E550                      ;83E53E;83E550;
                       %Set16bit(!MX)                             ;83E540;      ;
                       LDA.W #$0000                         ;83E542;      ;
                       LDX.W #$001D                         ;83E545;      ;
                       LDY.W #$0002                         ;83E548;      ;
                       JSL.L VIP                            ;83E54B;848097;
                       RTS                                  ;83E54F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E550: %Set16bit(!MX)                             ;83E550;      ;
                       LDA.L $7F1F6C                        ;83E552;7F1F6C;
                       AND.W #$0001                         ;83E556;      ;
                       BEQ CODE_83E56B                      ;83E559;83E56B;
                       %Set16bit(!MX)                             ;83E55B;      ;
                       LDA.W #$0000                         ;83E55D;      ;
                       LDX.W #$001B                         ;83E560;      ;
                       LDY.W #$0001                         ;83E563;      ;
                       JSL.L VIP                            ;83E566;848097;
                       RTS                                  ;83E56A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E56B: %Set8bit(!M)                             ;83E56B;      ;
                       LDA.L !weekday                        ;83E56D;7F1F1A;
                       CMP.B #$06                           ;83E571;      ;
                       BNE CODE_83E585                      ;83E573;83E585;
                       %Set16bit(!MX)                             ;83E575;      ;
                       LDA.W #$0000                         ;83E577;      ;
                       LDX.W #$0002                         ;83E57A;      ;
                       LDY.W #$0004                         ;83E57D;      ;
                       JSL.L VIP                            ;83E580;848097;
                       RTS                                  ;83E584;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E585: RTS                                  ;83E585;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E586;      ;
                       LDA.L $7F1F68                        ;83E588;7F1F68;
                       AND.W #$0200                         ;83E58C;      ;
                       BEQ CODE_83E5A1                      ;83E58F;83E5A1;
                       %Set16bit(!MX)                             ;83E591;      ;
                       LDA.W #$0000                         ;83E593;      ;
                       LDX.W #$0014                         ;83E596;      ;
                       LDY.W #$0001                         ;83E599;      ;
                       JSL.L VIP                            ;83E59C;848097;
                       RTS                                  ;83E5A0;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E5A1: RTS                                  ;83E5A1;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E5A2;      ;
                       %Set16bit(!MX)                             ;83E5A4;      ;
                       LDA.W #$0000                         ;83E5A6;      ;
                       LDX.W #$0014                         ;83E5A9;      ;
                       LDY.W #$0002                         ;83E5AC;      ;
                       JSL.L VIP                            ;83E5AF;848097;
                       RTS                                  ;83E5B3;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E5B4;      ;
                       LDA.L $7F1F6A                        ;83E5B6;7F1F6A;
                       AND.W #$4000                         ;83E5BA;      ;
                       BEQ CODE_83E5CC                      ;83E5BD;83E5CC;
                       LDA.W #$0015                         ;83E5BF;      ;
                       LDX.W #$0000                         ;83E5C2;      ;
                       LDY.W #$007F                         ;83E5C5;      ;
                       JSL.L VIP                            ;83E5C8;848097;
                                                            ;      ;      ;
          CODE_83E5CC: RTS                                  ;83E5CC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E5CD;      ;
                       %Set16bit(!MX)                             ;83E5CF;      ;
                       LDA.W #$0000                         ;83E5D1;      ;
                       LDX.W #$001E                         ;83E5D4;      ;
                       LDY.W #$0000                         ;83E5D7;      ;
                       JSL.L VIP                            ;83E5DA;848097;
                       RTS                                  ;83E5DE;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E5DF;      ;
                       %Set16bit(!MX)                             ;83E5E1;      ;
                       LDA.W #$0000                         ;83E5E3;      ;
                       LDX.W #$000E                         ;83E5E6;      ;
                       LDY.W #$0001                         ;83E5E9;      ;
                       JSL.L VIP                            ;83E5EC;848097;
                       RTS                                  ;83E5F0;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E5F1;      ;
                       %Set16bit(!MX)                             ;83E5F3;      ;
                       LDA.W #$0000                         ;83E5F5;      ;
                       LDX.W #$0026                         ;83E5F8;      ;
                       LDY.W #$0001                         ;83E5FB;      ;
                       JSL.L VIP                            ;83E5FE;848097;
                       RTS                                  ;83E602;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83E603;      ;
                       %Set16bit(!X)                             ;83E605;      ;
                       LDA.L !season                        ;83E607;7F1F19;
                       CMP.B #$03                           ;83E60B;      ;
                       BNE CODE_83E631                      ;83E60D;83E631;
                       LDA.L !day                        ;83E60F;7F1F1B;
                       CMP.B #$18                           ;83E613;      ;
                       BNE CODE_83E631                      ;83E615;83E631;
                       %Set16bit(!M)                             ;83E617;      ;
                       LDA.L $7F1F74                        ;83E619;7F1F74;
                       AND.W #$0001                         ;83E61D;      ;
                       BEQ CODE_83E631                      ;83E620;83E631;
                       %Set16bit(!MX)                             ;83E622;      ;
                       LDA.W #$0000                         ;83E624;      ;
                       LDX.W #$000F                         ;83E627;      ;
                       LDY.W #$0001                         ;83E62A;      ;
                       JSL.L VIP                            ;83E62D;848097;
                                                            ;      ;      ;
          CODE_83E631: RTS                                  ;83E631;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83E632;      ;
                       %Set16bit(!X)                             ;83E634;      ;
                       LDA.L !season                        ;83E636;7F1F19;
                       CMP.B #$03                           ;83E63A;      ;
                       BNE CODE_83E660                      ;83E63C;83E660;
                       LDA.L !day                        ;83E63E;7F1F1B;
                       CMP.B #$18                           ;83E642;      ;
                       BNE CODE_83E660                      ;83E644;83E660;
                       %Set16bit(!M)                             ;83E646;      ;
                       LDA.L $7F1F74                        ;83E648;7F1F74;
                       AND.W #$0008                         ;83E64C;      ;
                       BEQ CODE_83E660                      ;83E64F;83E660;
                       %Set16bit(!MX)                             ;83E651;      ;
                       LDA.W #$0000                         ;83E653;      ;
                       LDX.W #$000F                         ;83E656;      ;
                       LDY.W #$0004                         ;83E659;      ;
                       JSL.L VIP                            ;83E65C;848097;
                                                            ;      ;      ;
          CODE_83E660: RTS                                  ;83E660;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83E661;      ;
                       %Set16bit(!X)                             ;83E663;      ;
                       LDA.L !season                        ;83E665;7F1F19;
                       CMP.B #$03                           ;83E669;      ;
                       BNE CODE_83E68F                      ;83E66B;83E68F;
                       LDA.L !day                        ;83E66D;7F1F1B;
                       CMP.B #$18                           ;83E671;      ;
                       BNE CODE_83E68F                      ;83E673;83E68F;
                       %Set16bit(!M)                             ;83E675;      ;
                       LDA.L $7F1F74                        ;83E677;7F1F74;
                       AND.W #$0010                         ;83E67B;      ;
                       BEQ CODE_83E68F                      ;83E67E;83E68F;
                       %Set16bit(!MX)                             ;83E680;      ;
                       LDA.W #$0000                         ;83E682;      ;
                       LDX.W #$000F                         ;83E685;      ;
                       LDY.W #$0005                         ;83E688;      ;
                       JSL.L VIP                            ;83E68B;848097;
                                                            ;      ;      ;
          CODE_83E68F: RTS                                  ;83E68F;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83E690;      ;
                       %Set16bit(!X)                             ;83E692;      ;
                       LDA.L !season                        ;83E694;7F1F19;
                       BNE CODE_83E6B1                      ;83E698;83E6B1;
                       LDA.L !day                        ;83E69A;7F1F1B;
                       CMP.B #$01                           ;83E69E;      ;
                       BNE CODE_83E6B1                      ;83E6A0;83E6B1;
                       %Set16bit(!MX)                             ;83E6A2;      ;
                       LDA.W #$0000                         ;83E6A4;      ;
                       LDX.W #$0028                         ;83E6A7;      ;
                       LDY.W #$0001                         ;83E6AA;      ;
                       JSL.L VIP                            ;83E6AD;848097;
                                                            ;      ;      ;
          CODE_83E6B1: RTS                                  ;83E6B1;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E6B2;      ;
                       %Set16bit(!MX)                             ;83E6B4;      ;
                       LDA.W #$0000                         ;83E6B6;      ;
                       LDX.W #$0028                         ;83E6B9;      ;
                       LDY.W #$0003                         ;83E6BC;      ;
                       JSL.L VIP                            ;83E6BF;848097;
                       RTS                                  ;83E6C3;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E6C4;      ;
                       LDA.L $7F1F6E                        ;83E6C6;7F1F6E;
                       AND.W #$0002                         ;83E6CA;      ;
                       BNE CODE_83E705                      ;83E6CD;83E705;
                       LDA.L $7F1F66                        ;83E6CF;7F1F66;
                       AND.W #$0002                         ;83E6D3;      ;
                       BNE CODE_83E6E3                      ;83E6D6;83E6E3;
                       LDA.L $7F1F66                        ;83E6D8;7F1F66;
                       AND.W #$0010                         ;83E6DC;      ;
                       BNE CODE_83E6F4                      ;83E6DF;83E6F4;
                       BRA CODE_83E705                      ;83E6E1;83E705;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E6E3: %Set16bit(!MX)                             ;83E6E3;      ;
                       LDA.W #$0013                         ;83E6E5;      ;
                       LDX.W #$0044                         ;83E6E8;      ;
                       LDY.W #$0001                         ;83E6EB;      ;
                       JSL.L VIP                            ;83E6EE;848097;
                       BRA CODE_83E705                      ;83E6F2;83E705;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E6F4: %Set16bit(!MX)                             ;83E6F4;      ;
                       LDA.W #$0013                         ;83E6F6;      ;
                       LDX.W #$0044                         ;83E6F9;      ;
                       LDY.W #$0004                         ;83E6FC;      ;
                       JSL.L VIP                            ;83E6FF;848097;
                       BRA CODE_83E705                      ;83E703;83E705;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83E705: %Set16bit(!MX)                             ;83E705;      ;
                       LDA.L $7F1F6E                        ;83E707;7F1F6E;
                       AND.W #$0004                         ;83E70B;      ;
                       BEQ CODE_83E728                      ;83E70E;83E728;
                       LDA.L !kid1_age                        ;83E710;7F1F37;
                       CMP.W #$003C                         ;83E714;      ;
                       BCC CODE_83E728                      ;83E717;83E728;
                       %Set16bit(!MX)                             ;83E719;      ;
                       LDA.W #$0014                         ;83E71B;      ;
                       LDX.W #$0045                         ;83E71E;      ;
                       LDY.W #$0002                         ;83E721;      ;
                       JSL.L VIP                            ;83E724;848097;
                                                            ;      ;      ;
          CODE_83E728: %Set16bit(!MX)                             ;83E728;      ;
                       LDA.L $7F1F6E                        ;83E72A;7F1F6E;
                       AND.W #$0008                         ;83E72E;      ;
                       BEQ CODE_83E74B                      ;83E731;83E74B;
                       LDA.L !kid2_age                        ;83E733;7F1F39;
                       CMP.W #$003C                         ;83E737;      ;
                       BCC CODE_83E74B                      ;83E73A;83E74B;
                       %Set16bit(!MX)                             ;83E73C;      ;
                       LDA.W #$0015                         ;83E73E;      ;
                       LDX.W #$0045                         ;83E741;      ;
                       LDY.W #$0005                         ;83E744;      ;
                       JSL.L VIP                            ;83E747;848097;
                                                            ;      ;      ;
          CODE_83E74B: RTS                                  ;83E74B;      ;
                                                            ;      ;      ;
                       RTS                                  ;83E74C;      ;
                                                            ;      ;      ;
                       db $01,$00,$02,$00,$04,$00,$08,$00,$10,$00,$20,$00,$40,$00,$80,$00;83E74D;      ;
                       db $00,$01,$00,$02,$00,$04,$00,$08,$00,$10,$00,$20,$00,$40,$00,$80;83E75D;      ;
                       db $E2,$20,$C2,$10,$E2,$20,$A9,$07,$8F,$1C,$1F,$7F,$A9,$00,$8F,$1D;83E76D;      ;
                       db $1F,$7F,$A9,$00,$8F,$1E,$1F,$7F,$C2,$20,$9C,$15,$09,$64,$D2,$64;83E77D;      ;
                       db $D4,$E2,$20,$AD,$17,$09,$8D,$18,$09,$9C,$25,$09,$C2,$30,$A5,$D2;83E78D;      ;
                       db $09,$01,$00,$85,$D2,$C2,$30,$A9,$00,$00,$85,$D4,$C2,$30,$A9,$00;83E79D;      ;
                       db $00,$85,$DA,$C2,$30,$A9,$00,$00,$8D,$11,$09,$C2,$30,$A9,$00,$00;83E7AD;      ;
                       db $8D,$01,$09,$E2,$20,$9C,$73,$09,$E2,$20,$9C,$1D,$09,$C2,$30,$A9;83E7BD;      ;
                       db $02,$00,$49,$FF,$FF,$25,$D2,$85,$D2,$E2,$20,$AF,$49,$1F,$7F,$D0;83E7CD;      ;
                       db $03,$4C,$AD,$E8,$C9,$01,$D0,$03,$4C,$C5,$E8,$C9,$02,$D0,$03,$4C;83E7DD;      ;
                       db $DD,$E8,$C9,$03,$D0,$03,$4C,$F5,$E8,$C9,$04,$D0,$03,$4C,$0D,$E9;83E7ED;      ;
                       db $C9,$05,$D0,$03,$4C,$25,$E9,$C9,$06,$D0,$03,$4C,$3D,$E9,$C9,$07;83E7FD;      ;
                       db $D0,$03,$4C,$55,$E9,$C9,$08,$D0,$03,$4C,$8D,$E9,$C9,$09,$D0,$03;83E80D;      ;
                       db $4C,$A5,$E9,$C9,$0A,$D0,$03,$4C,$BD,$E9,$C9,$0B,$D0,$03,$4C,$D5;83E81D;      ;
                       db $E9,$C9,$0C,$D0,$03,$4C,$ED,$E9,$C9,$0D,$D0,$03,$4C,$05,$EA,$C9;83E82D;      ;
                       db $0E,$D0,$03,$4C,$3D,$EA,$C9,$0F,$D0,$03,$4C,$55,$EA,$C9,$10,$D0;83E83D;      ;
                       db $03,$4C,$6D,$EA,$C9,$11,$D0,$03,$4C,$85,$EA,$C9,$12,$D0,$03,$4C;83E84D;      ;
                       db $9D,$EA,$C9,$13,$D0,$03,$4C,$B5,$EA,$C9,$14,$D0,$03,$4C,$CD,$EA;83E85D;      ;
                       db $C9,$15,$D0,$03,$4C,$E5,$EA,$C9,$16,$D0,$03,$4C,$FD,$EA,$C9,$17;83E86D;      ;
                       db $D0,$03,$4C,$15,$EB,$C9,$18,$D0,$03,$4C,$2D,$EB,$C9,$19,$D0,$03;83E87D;      ;
                       db $4C,$45,$EB,$C9,$1A,$D0,$03,$4C,$5D,$EB,$C9,$1B,$D0,$03,$4C,$75;83E88D;      ;
                                                            ;      ;      ;
                       db $EB,$C9,$1C,$D0,$03,$4C,$8D,$EB,$C9,$1D,$D0,$03,$4C,$A5,$EB,$60;83E89D;      ;
                       %Set16bit(!MX)                             ;83E8AD;      ;
                       LDA.W #$0000                         ;83E8AF;      ;
                       LDX.W #$0047                         ;83E8B2;      ;
                       LDY.W #$0001                         ;83E8B5;      ;
                       JSL.L VIP                            ;83E8B8;848097;
                       %Set8bit(!M)                             ;83E8BC;      ;
                       LDA.B #$01                           ;83E8BE;      ;
                       STA.L $7F1F49                        ;83E8C0;7F1F49;
                       RTS                                  ;83E8C4;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E8C5;      ;
                       LDA.W #$0000                         ;83E8C7;      ;
                       LDX.W #$0047                         ;83E8CA;      ;
                       LDY.W #$0002                         ;83E8CD;      ;
                       JSL.L VIP                            ;83E8D0;848097;
                       %Set8bit(!M)                             ;83E8D4;      ;
                       LDA.B #$02                           ;83E8D6;      ;
                       STA.L $7F1F49                        ;83E8D8;7F1F49;
                       RTS                                  ;83E8DC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E8DD;      ;
                       LDA.W #$0000                         ;83E8DF;      ;
                       LDX.W #$0047                         ;83E8E2;      ;
                       LDY.W #$0003                         ;83E8E5;      ;
                       JSL.L VIP                            ;83E8E8;848097;
                       %Set8bit(!M)                             ;83E8EC;      ;
                       LDA.B #$03                           ;83E8EE;      ;
                       STA.L $7F1F49                        ;83E8F0;7F1F49;
                       RTS                                  ;83E8F4;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E8F5;      ;
                       LDA.W #$0000                         ;83E8F7;      ;
                       LDX.W #$0047                         ;83E8FA;      ;
                       LDY.W #$0004                         ;83E8FD;      ;
                       JSL.L VIP                            ;83E900;848097;
                       %Set8bit(!M)                             ;83E904;      ;
                       LDA.B #$04                           ;83E906;      ;
                       STA.L $7F1F49                        ;83E908;7F1F49;
                       RTS                                  ;83E90C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E90D;      ;
                       LDA.W #$0000                         ;83E90F;      ;
                       LDX.W #$0047                         ;83E912;      ;
                       LDY.W #$0005                         ;83E915;      ;
                       JSL.L VIP                            ;83E918;848097;
                       %Set8bit(!M)                             ;83E91C;      ;
                       LDA.B #$05                           ;83E91E;      ;
                       STA.L $7F1F49                        ;83E920;7F1F49;
                       RTS                                  ;83E924;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E925;      ;
                       LDA.W #$0000                         ;83E927;      ;
                       LDX.W #$0047                         ;83E92A;      ;
                       LDY.W #$0006                         ;83E92D;      ;
                       JSL.L VIP                            ;83E930;848097;
                       %Set8bit(!M)                             ;83E934;      ;
                       LDA.B #$06                           ;83E936;      ;
                       STA.L $7F1F49                        ;83E938;7F1F49;
                       RTS                                  ;83E93C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E93D;      ;
                       LDA.W #$0000                         ;83E93F;      ;
                       LDX.W #$0047                         ;83E942;      ;
                       LDY.W #$0007                         ;83E945;      ;
                       JSL.L VIP                            ;83E948;848097;
                       %Set8bit(!M)                             ;83E94C;      ;
                       LDA.B #$07                           ;83E94E;      ;
                       STA.L $7F1F49                        ;83E950;7F1F49;
                       RTS                                  ;83E954;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83E955;      ;
                       LDA.B #$3D                           ;83E957;      ;
                       STA.L !shed_items_row_1                        ;83E959;7F1F00;
                       LDA.B #$00                           ;83E95D;      ;
                       STA.L !shed_items_row_2                        ;83E95F;7F1F01;
                       LDA.B #$12                           ;83E963;      ;
                       STA.L !shed_items_row_3                        ;83E965;7F1F02;
                       LDA.B #$00                           ;83E969;      ;
                       STA.L !shed_items_row_4                        ;83E96B;7F1F03;
                       STZ.W !tool_selected                          ;83E96F;000921;
                       STZ.W !tool_backpack                          ;83E972;000923;
                       %Set16bit(!MX)                             ;83E975;      ;
                       LDA.W #$0000                         ;83E977;      ;
                       LDX.W #$0047                         ;83E97A;      ;
                       LDY.W #$0008                         ;83E97D;      ;
                       JSL.L VIP                            ;83E980;848097;
                       %Set8bit(!M)                             ;83E984;      ;
                       LDA.B #$08                           ;83E986;      ;
                       STA.L $7F1F49                        ;83E988;7F1F49;
                       RTS                                  ;83E98C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E98D;      ;
                       LDA.W #$0000                         ;83E98F;      ;
                       LDX.W #$0047                         ;83E992;      ;
                       LDY.W #$0009                         ;83E995;      ;
                       JSL.L VIP                            ;83E998;848097;
                       %Set8bit(!M)                             ;83E99C;      ;
                       LDA.B #$09                           ;83E99E;      ;
                       STA.L $7F1F49                        ;83E9A0;7F1F49;
                       RTS                                  ;83E9A4;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E9A5;      ;
                       LDA.W #$0000                         ;83E9A7;      ;
                       LDX.W #$0047                         ;83E9AA;      ;
                       LDY.W #$000A                         ;83E9AD;      ;
                       JSL.L VIP                            ;83E9B0;848097;
                       %Set8bit(!M)                             ;83E9B4;      ;
                       LDA.B #$0A                           ;83E9B6;      ;
                       STA.L $7F1F49                        ;83E9B8;7F1F49;
                       RTS                                  ;83E9BC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E9BD;      ;
                       LDA.W #$0000                         ;83E9BF;      ;
                       LDX.W #$0047                         ;83E9C2;      ;
                       LDY.W #$000B                         ;83E9C5;      ;
                       JSL.L VIP                            ;83E9C8;848097;
                       %Set8bit(!M)                             ;83E9CC;      ;
                       LDA.B #$0B                           ;83E9CE;      ;
                       STA.L $7F1F49                        ;83E9D0;7F1F49;
                       RTS                                  ;83E9D4;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E9D5;      ;
                       LDA.W #$0000                         ;83E9D7;      ;
                       LDX.W #$0047                         ;83E9DA;      ;
                       LDY.W #$000C                         ;83E9DD;      ;
                       JSL.L VIP                            ;83E9E0;848097;
                       %Set8bit(!M)                             ;83E9E4;      ;
                       LDA.B #$0C                           ;83E9E6;      ;
                       STA.L $7F1F49                        ;83E9E8;7F1F49;
                       RTS                                  ;83E9EC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83E9ED;      ;
                       LDA.W #$0000                         ;83E9EF;      ;
                       LDX.W #$0047                         ;83E9F2;      ;
                       LDY.W #$000D                         ;83E9F5;      ;
                       JSL.L VIP                            ;83E9F8;848097;
                       %Set8bit(!M)                             ;83E9FC;      ;
                       LDA.B #$0D                           ;83E9FE;      ;
                       STA.L $7F1F49                        ;83EA00;7F1F49;
                       RTS                                  ;83EA04;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83EA05;      ;
                       LDA.B #$0D                           ;83EA07;      ;
                       STA.L !shed_items_row_1                        ;83EA09;7F1F00;
                       LDA.B #$64                           ;83EA0D;      ;
                       STA.L !shed_items_row_2                        ;83EA0F;7F1F01;
                       LDA.B #$12                           ;83EA13;      ;
                       STA.L !shed_items_row_3                        ;83EA15;7F1F02;
                       LDA.B #$00                           ;83EA19;      ;
                       STA.L !shed_items_row_4                        ;83EA1B;7F1F03;
                       STZ.W !tool_selected                          ;83EA1F;000921;
                       STZ.W !tool_backpack                          ;83EA22;000923;
                       %Set16bit(!MX)                             ;83EA25;      ;
                       LDA.W #$0000                         ;83EA27;      ;
                       LDX.W #$0047                         ;83EA2A;      ;
                       LDY.W #$000E                         ;83EA2D;      ;
                       JSL.L VIP                            ;83EA30;848097;
                       %Set8bit(!M)                             ;83EA34;      ;
                       LDA.B #$0E                           ;83EA36;      ;
                       STA.L $7F1F49                        ;83EA38;7F1F49;
                       RTS                                  ;83EA3C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EA3D;      ;
                       LDA.W #$0000                         ;83EA3F;      ;
                       LDX.W #$0047                         ;83EA42;      ;
                       LDY.W #$000F                         ;83EA45;      ;
                       JSL.L VIP                            ;83EA48;848097;
                       %Set8bit(!M)                             ;83EA4C;      ;
                       LDA.B #$0F                           ;83EA4E;      ;
                       STA.L $7F1F49                        ;83EA50;7F1F49;
                       RTS                                  ;83EA54;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EA55;      ;
                       LDA.W #$0000                         ;83EA57;      ;
                       LDX.W #$0047                         ;83EA5A;      ;
                       LDY.W #$0010                         ;83EA5D;      ;
                       JSL.L VIP                            ;83EA60;848097;
                       %Set8bit(!M)                             ;83EA64;      ;
                       LDA.B #$10                           ;83EA66;      ;
                       STA.L $7F1F49                        ;83EA68;7F1F49;
                       RTS                                  ;83EA6C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EA6D;      ;
                       LDA.W #$0000                         ;83EA6F;      ;
                       LDX.W #$0047                         ;83EA72;      ;
                       LDY.W #$0011                         ;83EA75;      ;
                       JSL.L VIP                            ;83EA78;848097;
                       %Set8bit(!M)                             ;83EA7C;      ;
                       LDA.B #$11                           ;83EA7E;      ;
                       STA.L $7F1F49                        ;83EA80;7F1F49;
                       RTS                                  ;83EA84;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EA85;      ;
                       LDA.W #$0000                         ;83EA87;      ;
                       LDX.W #$0047                         ;83EA8A;      ;
                       LDY.W #$0012                         ;83EA8D;      ;
                       JSL.L VIP                            ;83EA90;848097;
                       %Set8bit(!M)                             ;83EA94;      ;
                       LDA.B #$12                           ;83EA96;      ;
                       STA.L $7F1F49                        ;83EA98;7F1F49;
                       RTS                                  ;83EA9C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EA9D;      ;
                       LDA.W #$0000                         ;83EA9F;      ;
                       LDX.W #$0047                         ;83EAA2;      ;
                       LDY.W #$0013                         ;83EAA5;      ;
                       JSL.L VIP                            ;83EAA8;848097;
                       %Set8bit(!M)                             ;83EAAC;      ;
                       LDA.B #$13                           ;83EAAE;      ;
                       STA.L $7F1F49                        ;83EAB0;7F1F49;
                       RTS                                  ;83EAB4;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EAB5;      ;
                       LDA.W #$0000                         ;83EAB7;      ;
                       LDX.W #$0047                         ;83EABA;      ;
                       LDY.W #$0014                         ;83EABD;      ;
                       JSL.L VIP                            ;83EAC0;848097;
                       %Set8bit(!M)                             ;83EAC4;      ;
                       LDA.B #$14                           ;83EAC6;      ;
                       STA.L $7F1F49                        ;83EAC8;7F1F49;
                       RTS                                  ;83EACC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EACD;      ;
                       LDA.W #$0000                         ;83EACF;      ;
                       LDX.W #$0047                         ;83EAD2;      ;
                       LDY.W #$0015                         ;83EAD5;      ;
                       JSL.L VIP                            ;83EAD8;848097;
                       %Set8bit(!M)                             ;83EADC;      ;
                       LDA.B #$15                           ;83EADE;      ;
                       STA.L $7F1F49                        ;83EAE0;7F1F49;
                       RTS                                  ;83EAE4;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EAE5;      ;
                       LDA.W #$0000                         ;83EAE7;      ;
                       LDX.W #$0047                         ;83EAEA;      ;
                       LDY.W #$0016                         ;83EAED;      ;
                       JSL.L VIP                            ;83EAF0;848097;
                       %Set8bit(!M)                             ;83EAF4;      ;
                       LDA.B #$16                           ;83EAF6;      ;
                       STA.L $7F1F49                        ;83EAF8;7F1F49;
                       RTS                                  ;83EAFC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EAFD;      ;
                       LDA.W #$0000                         ;83EAFF;      ;
                       LDX.W #$0047                         ;83EB02;      ;
                       LDY.W #$0017                         ;83EB05;      ;
                       JSL.L VIP                            ;83EB08;848097;
                       %Set8bit(!M)                             ;83EB0C;      ;
                       LDA.B #$17                           ;83EB0E;      ;
                       STA.L $7F1F49                        ;83EB10;7F1F49;
                       RTS                                  ;83EB14;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EB15;      ;
                       LDA.W #$0000                         ;83EB17;      ;
                       LDX.W #$0047                         ;83EB1A;      ;
                       LDY.W #$0018                         ;83EB1D;      ;
                       JSL.L VIP                            ;83EB20;848097;
                       %Set8bit(!M)                             ;83EB24;      ;
                       LDA.B #$18                           ;83EB26;      ;
                       STA.L $7F1F49                        ;83EB28;7F1F49;
                       RTS                                  ;83EB2C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EB2D;      ;
                       LDA.W #$0000                         ;83EB2F;      ;
                       LDX.W #$0047                         ;83EB32;      ;
                       LDY.W #$0019                         ;83EB35;      ;
                       JSL.L VIP                            ;83EB38;848097;
                       %Set8bit(!M)                             ;83EB3C;      ;
                       LDA.B #$19                           ;83EB3E;      ;
                       STA.L $7F1F49                        ;83EB40;7F1F49;
                       RTS                                  ;83EB44;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EB45;      ;
                       LDA.W #$0000                         ;83EB47;      ;
                       LDX.W #$0047                         ;83EB4A;      ;
                       LDY.W #$001A                         ;83EB4D;      ;
                       JSL.L VIP                            ;83EB50;848097;
                       %Set8bit(!M)                             ;83EB54;      ;
                       LDA.B #$1A                           ;83EB56;      ;
                       STA.L $7F1F49                        ;83EB58;7F1F49;
                       RTS                                  ;83EB5C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EB5D;      ;
                       LDA.W #$0000                         ;83EB5F;      ;
                       LDX.W #$0047                         ;83EB62;      ;
                       LDY.W #$001B                         ;83EB65;      ;
                       JSL.L VIP                            ;83EB68;848097;
                       %Set8bit(!M)                             ;83EB6C;      ;
                       LDA.B #$1B                           ;83EB6E;      ;
                       STA.L $7F1F49                        ;83EB70;7F1F49;
                       RTS                                  ;83EB74;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EB75;      ;
                       LDA.W #$0000                         ;83EB77;      ;
                       LDX.W #$0047                         ;83EB7A;      ;
                       LDY.W #$001C                         ;83EB7D;      ;
                       JSL.L VIP                            ;83EB80;848097;
                       %Set8bit(!M)                             ;83EB84;      ;
                       LDA.B #$1C                           ;83EB86;      ;
                       STA.L $7F1F49                        ;83EB88;7F1F49;
                       RTS                                  ;83EB8C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;83EB8D;      ;
                       LDA.W #$0000                         ;83EB8F;      ;
                       LDX.W #$0047                         ;83EB92;      ;
                       LDY.W #$001D                         ;83EB95;      ;
                       JSL.L VIP                            ;83EB98;848097;
                       %Set8bit(!M)                             ;83EB9C;      ;
                       LDA.B #$1D                           ;83EB9E;      ;
                       STA.L $7F1F49                        ;83EBA0;7F1F49;
                       RTS                                  ;83EBA4;      ;
                                                            ;      ;      ;
                       RTS                                  ;83EBA5;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;83EBA6;      ;
                       %Set16bit(!X)                             ;83EBA8;      ;
                       %Set8bit(!M)                             ;83EBAA;      ;
                       LDA.B #$06                           ;83EBAC;      ;
                       STA.L !hour                        ;83EBAE;7F1F1C;
                       LDA.B #$00                           ;83EBB2;      ;
                       STA.L !minutes                        ;83EBB4;7F1F1D;
                       LDA.B #$00                           ;83EBB8;      ;
                       STA.L !seconds                        ;83EBBA;7F1F1E;
                       %Set16bit(!M)                             ;83EBBE;      ;
                       STZ.W $0915                          ;83EBC0;000915;
                       STZ.B !game_state                            ;83EBC3;0000D2;
                       STZ.B !player_action                            ;83EBC5;0000D4;
                       %Set8bit(!M)                             ;83EBC7;      ;
                       LDA.W !max_stamina                          ;83EBC9;000917;
                       STA.W !current_stamina                          ;83EBCC;000918;
                       STZ.W !idle_animation_timer                          ;83EBCF;000925;
                       %Set16bit(!MX)                             ;83EBD2;      ;
                       LDA.B !game_state                            ;83EBD4;0000D2;
                       ORA.W #$0001                         ;83EBD6;      ;
                       STA.B !game_state                            ;83EBD9;0000D2;
                       %Set16bit(!MX)                             ;83EBDB;      ;
                       LDA.W #$0000                         ;83EBDD;      ;
                       STA.B !player_action                            ;83EBE0;0000D4;
                       %Set16bit(!MX)                             ;83EBE2;      ;
                       LDA.W #$0000                         ;83EBE4;      ;
                       STA.B !player_direction                            ;83EBE7;0000DA;
                       %Set16bit(!MX)                             ;83EBE9;      ;
                       LDA.W #$0000                         ;83EBEB;      ;
                       STA.W $0911                          ;83EBEE;000911;
                       %Set16bit(!MX)                             ;83EBF1;      ;
                       LDA.W #$0000                         ;83EBF3;      ;
                       STA.W $0901                          ;83EBF6;000901;
                       %Set8bit(!M)                             ;83EBF9;      ;
                       STZ.W !time_running                          ;83EBFB;000973;
                       %Set8bit(!M)                             ;83EBFE;      ;
                       STZ.W !item_on_hand                          ;83EC00;00091D;
                       %Set16bit(!MX)                             ;83EC03;      ;
                       LDA.W #$0002                         ;83EC05;      ;
                       EOR.W #$FFFF                         ;83EC08;      ;
                       AND.B !game_state                            ;83EC0B;0000D2;
                       STA.B !game_state                            ;83EC0D;0000D2;
                       %Set8bit(!M)                             ;83EC0F;      ;
                       LDA.L $7F1F47                        ;83EC11;7F1F47;
                       BNE CODE_83EC1A                      ;83EC15;83EC1A;
                       JMP.W CODE_83ED1E                    ;83EC17;83ED1E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC1A: CMP.B #$01                           ;83EC1A;      ;
                       BNE CODE_83EC21                      ;83EC1C;83EC21;
                       JMP.W CODE_83ED5A                    ;83EC1E;83ED5A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC21: CMP.B #$02                           ;83EC21;      ;
                       BNE CODE_83EC28                      ;83EC23;83EC28;
                       JMP.W CODE_83ED8B                    ;83EC25;83ED8B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC28: CMP.B #$03                           ;83EC28;      ;
                       BNE CODE_83EC2F                      ;83EC2A;83EC2F;
                       JMP.W CODE_83EDB1                    ;83EC2C;83EDB1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC2F: CMP.B #$04                           ;83EC2F;      ;
                       BNE CODE_83EC36                      ;83EC31;83EC36;
                       JMP.W CODE_83EDD3                    ;83EC33;83EDD3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC36: CMP.B #$05                           ;83EC36;      ;
                       BNE CODE_83EC3D                      ;83EC38;83EC3D;
                       JMP.W CODE_83EDF6                    ;83EC3A;83EDF6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC3D: CMP.B #$06                           ;83EC3D;      ;
                       BNE CODE_83EC44                      ;83EC3F;83EC44;
                       JMP.W CODE_83EE19                    ;83EC41;83EE19;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC44: CMP.B #$07                           ;83EC44;      ;
                       BNE CODE_83EC4B                      ;83EC46;83EC4B;
                       JMP.W CODE_83EE3C                    ;83EC48;83EE3C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC4B: CMP.B #$08                           ;83EC4B;      ;
                       BNE CODE_83EC52                      ;83EC4D;83EC52;
                       JMP.W CODE_83EE5F                    ;83EC4F;83EE5F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC52: CMP.B #$09                           ;83EC52;      ;
                       BNE CODE_83EC59                      ;83EC54;83EC59;
                       JMP.W CODE_83EE82                    ;83EC56;83EE82;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC59: CMP.B #$0A                           ;83EC59;      ;
                       BNE CODE_83EC60                      ;83EC5B;83EC60;
                       JMP.W CODE_83EEAE                    ;83EC5D;83EEAE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC60: CMP.B #$0B                           ;83EC60;      ;
                       BNE CODE_83EC67                      ;83EC62;83EC67;
                       JMP.W CODE_83EEDA                    ;83EC64;83EEDA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC67: CMP.B #$0C                           ;83EC67;      ;
                       BNE CODE_83EC6E                      ;83EC69;83EC6E;
                       JMP.W CODE_83EF15                    ;83EC6B;83EF15;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC6E: CMP.B #$0D                           ;83EC6E;      ;
                       BNE CODE_83EC75                      ;83EC70;83EC75;
                       JMP.W CODE_83EF50                    ;83EC72;83EF50;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC75: CMP.B #$0E                           ;83EC75;      ;
                       BNE CODE_83EC7C                      ;83EC77;83EC7C;
                       JMP.W CODE_83EF8B                    ;83EC79;83EF8B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC7C: CMP.B #$0F                           ;83EC7C;      ;
                       BNE CODE_83EC83                      ;83EC7E;83EC83;
                       JMP.W CODE_83EFC6                    ;83EC80;83EFC6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC83: CMP.B #$10                           ;83EC83;      ;
                       BNE CODE_83EC8A                      ;83EC85;83EC8A;
                       JMP.W CODE_83EFE9                    ;83EC87;83EFE9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC8A: CMP.B #$11                           ;83EC8A;      ;
                       BNE CODE_83EC91                      ;83EC8C;83EC91;
                       JMP.W CODE_83F02F                    ;83EC8E;83F02F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC91: CMP.B #$12                           ;83EC91;      ;
                       BNE CODE_83EC98                      ;83EC93;83EC98;
                       JMP.W CODE_83F052                    ;83EC95;83F052;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC98: CMP.B #$13                           ;83EC98;      ;
                       BNE CODE_83EC9F                      ;83EC9A;83EC9F;
                       JMP.W CODE_83F075                    ;83EC9C;83F075;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EC9F: CMP.B #$14                           ;83EC9F;      ;
                       BNE CODE_83ECA6                      ;83ECA1;83ECA6;
                       JMP.W CODE_83F0E3                    ;83ECA3;83F0E3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECA6: CMP.B #$15                           ;83ECA6;      ;
                       BNE CODE_83ECAD                      ;83ECA8;83ECAD;
                       JMP.W CODE_83F14B                    ;83ECAA;83F14B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECAD: CMP.B #$16                           ;83ECAD;      ;
                       BNE CODE_83ECB4                      ;83ECAF;83ECB4;
                       JMP.W CODE_83F163                    ;83ECB1;83F163;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECB4: CMP.B #$17                           ;83ECB4;      ;
                       BNE CODE_83ECBB                      ;83ECB6;83ECBB;
                       JMP.W CODE_83F17B                    ;83ECB8;83F17B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECBB: CMP.B #$18                           ;83ECBB;      ;
                       BNE CODE_83ECC2                      ;83ECBD;83ECC2;
                       JMP.W CODE_83F193                    ;83ECBF;83F193;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECC2: CMP.B #$19                           ;83ECC2;      ;
                       BNE CODE_83ECC9                      ;83ECC4;83ECC9;
                       JMP.W CODE_83F1AB                    ;83ECC6;83F1AB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECC9: CMP.B #$1A                           ;83ECC9;      ;
                       BNE CODE_83ECD0                      ;83ECCB;83ECD0;
                       JMP.W CODE_83F1C3                    ;83ECCD;83F1C3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECD0: CMP.B #$1B                           ;83ECD0;      ;
                       BNE CODE_83ECD7                      ;83ECD2;83ECD7;
                       JMP.W CODE_83F1DB                    ;83ECD4;83F1DB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECD7: CMP.B #$1C                           ;83ECD7;      ;
                       BNE CODE_83ECDE                      ;83ECD9;83ECDE;
                       JMP.W CODE_83F200                    ;83ECDB;83F200;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECDE: CMP.B #$1D                           ;83ECDE;      ;
                       BNE CODE_83ECE5                      ;83ECE0;83ECE5;
                       JMP.W CODE_83F218                    ;83ECE2;83F218;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECE5: CMP.B #$1E                           ;83ECE5;      ;
                       BNE CODE_83ECEC                      ;83ECE7;83ECEC;
                       JMP.W CODE_83F230                    ;83ECE9;83F230;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECEC: CMP.B #$1F                           ;83ECEC;      ;
                       BNE CODE_83ECF3                      ;83ECEE;83ECF3;
                       JMP.W CODE_83F248                    ;83ECF0;83F248;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECF3: CMP.B #$20                           ;83ECF3;      ;
                       BNE CODE_83ECFA                      ;83ECF5;83ECFA;
                       JMP.W RanchMasteryCalculator                    ;83ECF7;83F26D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ECFA: CMP.B #$21                           ;83ECFA;      ;
                       BNE CODE_83ED01                      ;83ECFC;83ED01;
                       JMP.W CODE_83EEFD                    ;83ECFE;83EEFD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED01: CMP.B #$22                           ;83ED01;      ;
                       BNE CODE_83ED08                      ;83ED03;83ED08;
                       JMP.W CODE_83EF38                    ;83ED05;83EF38;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED08: CMP.B #$23                           ;83ED08;      ;
                       BNE CODE_83ED0F                      ;83ED0A;83ED0F;
                       JMP.W CODE_83EF73                    ;83ED0C;83EF73;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED0F: CMP.B #$24                           ;83ED0F;      ;
                       BNE CODE_83ED16                      ;83ED11;83ED16;
                       JMP.W CODE_83EFAE                    ;83ED13;83EFAE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED16: CMP.B #$25                           ;83ED16;      ;
                       BNE CODE_83ED1D                      ;83ED18;83ED1D;
                       JMP.W CODE_83F4D7                    ;83ED1A;83F4D7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED1D: RTS                                  ;83ED1D;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED1E: %Set16bit(!MX)                             ;83ED1E;      ;
                       LDA.L $7F1F66                        ;83ED20;7F1F66;
                       AND.W #$001F                         ;83ED24;      ;
                       BNE CODE_83ED5A                      ;83ED27;83ED5A;
                       LDA.L !happiness                        ;83ED29;7F1F33;
                       CMP.W #$0064                         ;83ED2D;      ;
                       BCS CODE_83ED5A                      ;83ED30;83ED5A;
                       %Set8bit(!M)                             ;83ED32;      ;
                       LDA.L !cow_N                        ;83ED34;7F1F0A;
                       BNE CODE_83ED5A                      ;83ED38;83ED5A;
                       %Set8bit(!M)                             ;83ED3A;      ;
                       LDA.L !chicks_N                        ;83ED3C;7F1F0B;
                       BNE CODE_83ED5A                      ;83ED40;83ED5A;
                       %Set16bit(!MX)                             ;83ED42;      ;
                       LDA.W #$0000                         ;83ED44;      ;
                       LDX.W #$002F                         ;83ED47;      ;
                       LDY.W #$0000                         ;83ED4A;      ;
                       JSL.L VIP                            ;83ED4D;848097;
                       %Set8bit(!M)                             ;83ED51;      ;
                       LDA.B #$14                           ;83ED53;      ;
                       STA.L $7F1F47                        ;83ED55;7F1F47;
                       RTS                                  ;83ED59;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED5A: %Set16bit(!M)                             ;83ED5A;      ;
                       LDA.L $7F1F5E                        ;83ED5C;7F1F5E;
                       ORA.W #$8000                         ;83ED60;      ;
                       STA.L $7F1F5E                        ;83ED63;7F1F5E;
                       %Set8bit(!M)                             ;83ED67;      ;
                       %Set16bit(!X)                             ;83ED69;      ;
                       LDA.L !cow_N                        ;83ED6B;7F1F0A;
                       CMP.B #$07                           ;83ED6F;      ;
                       BCC CODE_83ED8B                      ;83ED71;83ED8B;
                       %Set16bit(!MX)                             ;83ED73;      ;
                       LDA.W #$0000                         ;83ED75;      ;
                       LDX.W #$0030                         ;83ED78;      ;
                       LDY.W #$0000                         ;83ED7B;      ;
                       JSL.L VIP                            ;83ED7E;848097;
                       %Set8bit(!M)                             ;83ED82;      ;
                       LDA.B #$02                           ;83ED84;      ;
                       STA.L $7F1F47                        ;83ED86;7F1F47;
                       RTS                                  ;83ED8A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83ED8B: %Set8bit(!M)                             ;83ED8B;      ;
                       %Set16bit(!X)                             ;83ED8D;      ;
                       LDA.L !cow_N                        ;83ED8F;7F1F0A;
                       BEQ CODE_83EDB1                      ;83ED93;83EDB1;
                       CMP.B #$07                           ;83ED95;      ;
                       BCS CODE_83EDB1                      ;83ED97;83EDB1;
                       %Set16bit(!MX)                             ;83ED99;      ;
                       LDA.W #$0000                         ;83ED9B;      ;
                       LDX.W #$0031                         ;83ED9E;      ;
                       LDY.W #$0000                         ;83EDA1;      ;
                       JSL.L VIP                            ;83EDA4;848097;
                       %Set8bit(!M)                             ;83EDA8;      ;
                       LDA.B #$03                           ;83EDAA;      ;
                       STA.L $7F1F47                        ;83EDAC;7F1F47;
                       RTS                                  ;83EDB0;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EDB1: %Set8bit(!M)                             ;83EDB1;      ;
                       %Set16bit(!X)                             ;83EDB3;      ;
                       LDA.L !chicks_N                        ;83EDB5;7F1F0B;
                       BEQ CODE_83EDD3                      ;83EDB9;83EDD3;
                       %Set16bit(!MX)                             ;83EDBB;      ;
                       LDA.W #$0000                         ;83EDBD;      ;
                       LDX.W #$0032                         ;83EDC0;      ;
                       LDY.W #$0000                         ;83EDC3;      ;
                       JSL.L VIP                            ;83EDC6;848097;
                       %Set8bit(!M)                             ;83EDCA;      ;
                       LDA.B #$04                           ;83EDCC;      ;
                       STA.L $7F1F47                        ;83EDCE;7F1F47;
                       RTS                                  ;83EDD2;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EDD3: %Set8bit(!M)                             ;83EDD3;      ;
                       %Set16bit(!X)                             ;83EDD5;      ;
                       LDA.W $09B5                          ;83EDD7;0009B5;
                       CMP.B #$C0                           ;83EDDA;      ;
                       BCC CODE_83EDF6                      ;83EDDC;83EDF6;
                       %Set16bit(!MX)                             ;83EDDE;      ;
                       LDA.W #$0000                         ;83EDE0;      ;
                       LDX.W #$0033                         ;83EDE3;      ;
                       LDY.W #$0000                         ;83EDE6;      ;
                       JSL.L VIP                            ;83EDE9;848097;
                       %Set8bit(!M)                             ;83EDED;      ;
                       LDA.B #$05                           ;83EDEF;      ;
                       STA.L $7F1F47                        ;83EDF1;7F1F47;
                       RTS                                  ;83EDF5;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EDF6: %Set16bit(!MX)                             ;83EDF6;      ;
                       LDA.L !shipped_corn                        ;83EDF8;7F1F4A;
                       CMP.W #$00C8                         ;83EDFC;      ;
                       BCC CODE_83EE19                      ;83EDFF;83EE19;
                       %Set16bit(!MX)                             ;83EE01;      ;
                       LDA.W #$0000                         ;83EE03;      ;
                       LDX.W #$0034                         ;83EE06;      ;
                       LDY.W #$0000                         ;83EE09;      ;
                       JSL.L VIP                            ;83EE0C;848097;
                       %Set8bit(!M)                             ;83EE10;      ;
                       LDA.B #$06                           ;83EE12;      ;
                       STA.L $7F1F47                        ;83EE14;7F1F47;
                       RTS                                  ;83EE18;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EE19: %Set16bit(!MX)                             ;83EE19;      ;
                       LDA.L !shipped_tomatoes                        ;83EE1B;7F1F4C;
                       CMP.W #$00C8                         ;83EE1F;      ;
                       BCC CODE_83EE3C                      ;83EE22;83EE3C;
                       %Set16bit(!MX)                             ;83EE24;      ;
                       LDA.W #$0000                         ;83EE26;      ;
                       LDX.W #$0035                         ;83EE29;      ;
                       LDY.W #$0000                         ;83EE2C;      ;
                       JSL.L VIP                            ;83EE2F;848097;
                       %Set8bit(!M)                             ;83EE33;      ;
                       LDA.B #$07                           ;83EE35;      ;
                       STA.L $7F1F47                        ;83EE37;7F1F47;
                       RTS                                  ;83EE3B;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EE3C: %Set16bit(!MX)                             ;83EE3C;      ;
                       LDA.L !shipped_turnips                        ;83EE3E;7F1F4E;
                       CMP.W #$00C8                         ;83EE42;      ;
                       BCC CODE_83EE5F                      ;83EE45;83EE5F;
                       %Set16bit(!MX)                             ;83EE47;      ;
                       LDA.W #$0000                         ;83EE49;      ;
                       LDX.W #$0037                         ;83EE4C;      ;
                       LDY.W #$0000                         ;83EE4F;      ;
                       JSL.L VIP                            ;83EE52;848097;
                       %Set8bit(!M)                             ;83EE56;      ;
                       LDA.B #$08                           ;83EE58;      ;
                       STA.L $7F1F47                        ;83EE5A;7F1F47;
                       RTS                                  ;83EE5E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EE5F: %Set16bit(!MX)                             ;83EE5F;      ;
                       LDA.L !shipped_potatoes                        ;83EE61;7F1F50;
                       CMP.W #$00C8                         ;83EE65;      ;
                       BCC CODE_83EE82                      ;83EE68;83EE82;
                       %Set16bit(!MX)                             ;83EE6A;      ;
                       LDA.W #$0000                         ;83EE6C;      ;
                       LDX.W #$0036                         ;83EE6F;      ;
                       LDY.W #$0000                         ;83EE72;      ;
                       JSL.L VIP                            ;83EE75;848097;
                       %Set8bit(!M)                             ;83EE79;      ;
                       LDA.B #$09                           ;83EE7B;      ;
                       STA.L $7F1F47                        ;83EE7D;7F1F47;
                       RTS                                  ;83EE81;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EE82: %Set16bit(!MX)                             ;83EE82;      ;
                       LDA.L $7F1F66                        ;83EE84;7F1F66;
                       AND.W #$001F                         ;83EE88;      ;
                       BNE CODE_83EEAE                      ;83EE8B;83EEAE;
                       LDA.L !happiness                        ;83EE8D;7F1F33;
                       CMP.W #$0064                         ;83EE91;      ;
                       BCC CODE_83EEAE                      ;83EE94;83EEAE;
                       %Set16bit(!MX)                             ;83EE96;      ;
                       LDA.W #$0000                         ;83EE98;      ;
                       LDX.W #$0038                         ;83EE9B;      ;
                       LDY.W #$0000                         ;83EE9E;      ;
                       JSL.L VIP                            ;83EEA1;848097;
                       %Set8bit(!M)                             ;83EEA5;      ;
                       LDA.B #$0A                           ;83EEA7;      ;
                       STA.L $7F1F47                        ;83EEA9;7F1F47;
                       RTS                                  ;83EEAD;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EEAE: %Set16bit(!MX)                             ;83EEAE;      ;
                       LDA.L $7F1F66                        ;83EEB0;7F1F66;
                       AND.W #$001F                         ;83EEB4;      ;
                       BNE CODE_83EEDA                      ;83EEB7;83EEDA;
                       LDA.L !happiness                        ;83EEB9;7F1F33;
                       CMP.W #$0320                         ;83EEBD;      ;
                       BCC CODE_83EEDA                      ;83EEC0;83EEDA;
                       %Set16bit(!MX)                             ;83EEC2;      ;
                       LDA.W #$0000                         ;83EEC4;      ;
                       LDX.W #$0039                         ;83EEC7;      ;
                       LDY.W #$0000                         ;83EECA;      ;
                       JSL.L VIP                            ;83EECD;848097;
                       %Set8bit(!M)                             ;83EED1;      ;
                       LDA.B #$0B                           ;83EED3;      ;
                       STA.L $7F1F47                        ;83EED5;7F1F47;
                       RTS                                  ;83EED9;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EEDA: %Set16bit(!MX)                             ;83EEDA;      ;
                       LDA.L $7F1F66                        ;83EEDC;7F1F66;
                       AND.W #$0001                         ;83EEE0;      ;
                       BEQ CODE_83EF15                      ;83EEE3;83EF15;
                       %Set16bit(!MX)                             ;83EEE5;      ;
                       LDA.W #$0000                         ;83EEE7;      ;
                       LDX.W #$003A                         ;83EEEA;      ;
                       LDY.W #$0000                         ;83EEED;      ;
                       JSL.L VIP                            ;83EEF0;848097;
                       %Set8bit(!M)                             ;83EEF4;      ;
                       LDA.B #$21                           ;83EEF6;      ;
                       STA.L $7F1F47                        ;83EEF8;7F1F47;
                       RTS                                  ;83EEFC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EEFD: %Set16bit(!MX)                             ;83EEFD;      ;
                       LDA.W #$0000                         ;83EEFF;      ;
                       LDX.W #$003A                         ;83EF02;      ;
                       LDY.W #$0001                         ;83EF05;      ;
                       JSL.L VIP                            ;83EF08;848097;
                       %Set8bit(!M)                             ;83EF0C;      ;
                       LDA.B #$0C                           ;83EF0E;      ;
                       STA.L $7F1F47                        ;83EF10;7F1F47;
                       RTS                                  ;83EF14;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EF15: %Set16bit(!MX)                             ;83EF15;      ;
                       LDA.L $7F1F66                        ;83EF17;7F1F66;
                       AND.W #$0002                         ;83EF1B;      ;
                       BEQ CODE_83EF50                      ;83EF1E;83EF50;
                       %Set16bit(!MX)                             ;83EF20;      ;
                       LDA.W #$0000                         ;83EF22;      ;
                       LDX.W #$003B                         ;83EF25;      ;
                       LDY.W #$0000                         ;83EF28;      ;
                       JSL.L VIP                            ;83EF2B;848097;
                       %Set8bit(!M)                             ;83EF2F;      ;
                       LDA.B #$22                           ;83EF31;      ;
                       STA.L $7F1F47                        ;83EF33;7F1F47;
                       RTS                                  ;83EF37;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EF38: %Set16bit(!MX)                             ;83EF38;      ;
                       LDA.W #$0000                         ;83EF3A;      ;
                       LDX.W #$003B                         ;83EF3D;      ;
                       LDY.W #$0001                         ;83EF40;      ;
                       JSL.L VIP                            ;83EF43;848097;
                       %Set8bit(!M)                             ;83EF47;      ;
                       LDA.B #$0D                           ;83EF49;      ;
                       STA.L $7F1F47                        ;83EF4B;7F1F47;
                       RTS                                  ;83EF4F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EF50: %Set16bit(!MX)                             ;83EF50;      ;
                       LDA.L $7F1F66                        ;83EF52;7F1F66;
                       AND.W #$0004                         ;83EF56;      ;
                       BEQ CODE_83EF8B                      ;83EF59;83EF8B;
                       %Set16bit(!MX)                             ;83EF5B;      ;
                       LDA.W #$0000                         ;83EF5D;      ;
                       LDX.W #$003C                         ;83EF60;      ;
                       LDY.W #$0000                         ;83EF63;      ;
                       JSL.L VIP                            ;83EF66;848097;
                       %Set8bit(!M)                             ;83EF6A;      ;
                       LDA.B #$23                           ;83EF6C;      ;
                       STA.L $7F1F47                        ;83EF6E;7F1F47;
                       RTS                                  ;83EF72;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EF73: %Set16bit(!MX)                             ;83EF73;      ;
                       LDA.W #$0000                         ;83EF75;      ;
                       LDX.W #$003C                         ;83EF78;      ;
                       LDY.W #$0001                         ;83EF7B;      ;
                       JSL.L VIP                            ;83EF7E;848097;
                       %Set8bit(!M)                             ;83EF82;      ;
                       LDA.B #$0E                           ;83EF84;      ;
                       STA.L $7F1F47                        ;83EF86;7F1F47;
                       RTS                                  ;83EF8A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EF8B: %Set16bit(!MX)                             ;83EF8B;      ;
                       LDA.L $7F1F66                        ;83EF8D;7F1F66;
                       AND.W #$0008                         ;83EF91;      ;
                       BEQ CODE_83EFC6                      ;83EF94;83EFC6;
                       %Set16bit(!MX)                             ;83EF96;      ;
                       LDA.W #$0000                         ;83EF98;      ;
                       LDX.W #$003D                         ;83EF9B;      ;
                       LDY.W #$0000                         ;83EF9E;      ;
                       JSL.L VIP                            ;83EFA1;848097;
                       %Set8bit(!M)                             ;83EFA5;      ;
                       LDA.B #$24                           ;83EFA7;      ;
                       STA.L $7F1F47                        ;83EFA9;7F1F47;
                       RTS                                  ;83EFAD;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EFAE: %Set16bit(!MX)                             ;83EFAE;      ;
                       LDA.W #$0000                         ;83EFB0;      ;
                       LDX.W #$003D                         ;83EFB3;      ;
                       LDY.W #$0001                         ;83EFB6;      ;
                       JSL.L VIP                            ;83EFB9;848097;
                       %Set8bit(!M)                             ;83EFBD;      ;
                       LDA.B #$0F                           ;83EFBF;      ;
                       STA.L $7F1F47                        ;83EFC1;7F1F47;
                       RTS                                  ;83EFC5;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EFC6: %Set16bit(!MX)                             ;83EFC6;      ;
                       LDA.L $7F1F66                        ;83EFC8;7F1F66;
                       AND.W #$0010                         ;83EFCC;      ;
                       BEQ CODE_83EFE9                      ;83EFCF;83EFE9;
                       %Set16bit(!MX)                             ;83EFD1;      ;
                       LDA.W #$0000                         ;83EFD3;      ;
                       LDX.W #$003E                         ;83EFD6;      ;
                       LDY.W #$0000                         ;83EFD9;      ;
                       JSL.L VIP                            ;83EFDC;848097;
                       %Set8bit(!M)                             ;83EFE0;      ;
                       LDA.B #$10                           ;83EFE2;      ;
                       STA.L $7F1F47                        ;83EFE4;7F1F47;
                       RTS                                  ;83EFE8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83EFE9: %Set16bit(!MX)                             ;83EFE9;      ;
                       LDA.L $7F1F66                        ;83EFEB;7F1F66;
                       AND.W #$001F                         ;83EFEF;      ;
                       BNE CODE_83F02F                      ;83EFF2;83F02F;
                       LDA.L !happiness                        ;83EFF4;7F1F33;
                       CMP.W #$00C8                         ;83EFF8;      ;
                       BCC CODE_83F02F                      ;83EFFB;83F02F;
                       LDA.L !hearts_maria                        ;83EFFD;7F1F1F;
                       CLC                                  ;83F001;      ;
                       ADC.L !hearts_ann                        ;83F002;7F1F21;
                       ADC.L !hearts_nina                        ;83F006;7F1F23;
                       ADC.L !hearts_ellen                        ;83F00A;7F1F25;
                       ADC.L !hearts_eve                        ;83F00E;7F1F27;
                       CMP.W #$05DC                         ;83F012;      ;
                       BCC CODE_83F02F                      ;83F015;83F02F;
                       %Set16bit(!MX)                             ;83F017;      ;
                       LDA.W #$0000                         ;83F019;      ;
                       LDX.W #$003F                         ;83F01C;      ;
                       LDY.W #$0000                         ;83F01F;      ;
                       JSL.L VIP                            ;83F022;848097;
                       %Set8bit(!M)                             ;83F026;      ;
                       LDA.B #$11                           ;83F028;      ;
                       STA.L $7F1F47                        ;83F02A;7F1F47;
                       RTS                                  ;83F02E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F02F: %Set16bit(!MX)                             ;83F02F;      ;
                       LDA.L $7F1F6E                        ;83F031;7F1F6E;
                       AND.W #$000C                         ;83F035;      ;
                       BEQ CODE_83F052                      ;83F038;83F052;
                       %Set16bit(!MX)                             ;83F03A;      ;
                       LDA.W #$0000                         ;83F03C;      ;
                       LDX.W #$0040                         ;83F03F;      ;
                       LDY.W #$0000                         ;83F042;      ;
                       JSL.L VIP                            ;83F045;848097;
                       %Set8bit(!M)                             ;83F049;      ;
                       LDA.B #$12                           ;83F04B;      ;
                       STA.L $7F1F47                        ;83F04D;7F1F47;
                       RTS                                  ;83F051;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F052: %Set16bit(!MX)                             ;83F052;      ;
                       LDA.L $7F1F6E                        ;83F054;7F1F6E;
                       AND.W #$0008                         ;83F058;      ;
                       BEQ CODE_83F075                      ;83F05B;83F075;
                       %Set16bit(!MX)                             ;83F05D;      ;
                       LDA.W #$0000                         ;83F05F;      ;
                       LDX.W #$0041                         ;83F062;      ;
                       LDY.W #$0000                         ;83F065;      ;
                       JSL.L VIP                            ;83F068;848097;
                       %Set8bit(!M)                             ;83F06C;      ;
                       LDA.B #$13                           ;83F06E;      ;
                       STA.L $7F1F47                        ;83F070;7F1F47;
                       RTS                                  ;83F074;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F075: %Set16bit(!MX)                             ;83F075;      ;
                       LDA.L $7F1F6E                        ;83F077;7F1F6E;
                       AND.W #$0008                         ;83F07B;      ;
                       BEQ CODE_83F0E3                      ;83F07E;83F0E3;
                       LDA.L !happiness                        ;83F080;7F1F33;
                       CMP.W #$0384                         ;83F084;      ;
                       BCC CODE_83F0E3                      ;83F087;83F0E3;
                       %Set8bit(!M)                             ;83F089;      ;
                       LDA.L !cow_N                        ;83F08B;7F1F0A;
                       BEQ CODE_83F0E3                      ;83F08F;83F0E3;
                       LDA.L !chicks_N                        ;83F091;7F1F0B;
                       BEQ CODE_83F0E3                      ;83F095;83F0E3;
                       LDA.L !power_berry_N                        ;83F097;7F1F36;
                       CMP.B #$0A                           ;83F09B;      ;
                       BNE CODE_83F0E3                      ;83F09D;83F0E3;
                       %Set16bit(!M)                             ;83F09F;      ;
                       LDA.L !moneyL                        ;83F0A1;7F1F04;
                       CLC                                  ;83F0A5;      ;
                       ADC.W #$FC18                         ;83F0A6;      ;
                       %Set8bit(!M)                             ;83F0A9;      ;
                       LDA.L !moneyH                        ;83F0AB;7F1F06;
                       ADC.B #$FF                           ;83F0AF;      ;
                       BMI CODE_83F0E3                      ;83F0B1;83F0E3;
                       %Set16bit(!M)                             ;83F0B3;      ;
                       LDA.L !dog_hugs                        ;83F0B5;7F1F52;
                       CMP.W #$0064                         ;83F0B9;      ;
                       BCC CODE_83F0E3                      ;83F0BC;83F0E3;
                       %Set16bit(!MX)                             ;83F0BE;      ;
                       LDA.W #$0000                         ;83F0C0;      ;
                       LDX.W #$0042                         ;83F0C3;      ;
                       LDY.W #$0000                         ;83F0C6;      ;
                       JSL.L VIP                            ;83F0C9;848097;
                       %Set8bit(!M)                             ;83F0CD;      ;
                       LDA.B #$14                           ;83F0CF;      ;
                       STA.L $7F1F47                        ;83F0D1;7F1F47;
                       %Set16bit(!M)                             ;83F0D5;      ;
                       LDA.L $7F1F5E                        ;83F0D7;7F1F5E;
                       AND.W #$7FFF                         ;83F0DB;      ;
                       STA.L $7F1F5E                        ;83F0DE;7F1F5E;
                       RTS                                  ;83F0E2;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F0E3: %Set16bit(!MX)                             ;83F0E3;      ;
                       LDA.L !hearts_maria                        ;83F0E5;7F1F1F;
                       STA.W $09B3                          ;83F0E9;0009B3;
                       CMP.L !hearts_ann                        ;83F0EC;7F1F21;
                       BCS CODE_83F0F9                      ;83F0F0;83F0F9;
                       LDA.L !hearts_ann                        ;83F0F2;7F1F21;
                       STA.W $09B3                          ;83F0F6;0009B3;
                                                            ;      ;      ;
          CODE_83F0F9: %Set16bit(!MX)                             ;83F0F9;      ;
                       CMP.L !hearts_nina                        ;83F0FB;7F1F23;
                       BCS CODE_83F108                      ;83F0FF;83F108;
                       LDA.L !hearts_nina                        ;83F101;7F1F23;
                       STA.W $09B3                          ;83F105;0009B3;
                                                            ;      ;      ;
          CODE_83F108: %Set16bit(!MX)                             ;83F108;      ;
                       CMP.L !hearts_ellen                        ;83F10A;7F1F25;
                       BCS CODE_83F117                      ;83F10E;83F117;
                       LDA.L !hearts_ellen                        ;83F110;7F1F25;
                       STA.W $09B3                          ;83F114;0009B3;
                                                            ;      ;      ;
          CODE_83F117: %Set16bit(!MX)                             ;83F117;      ;
                       CMP.L !hearts_eve                        ;83F119;7F1F27;
                       BCS CODE_83F126                      ;83F11D;83F126;
                       LDA.L !hearts_eve                        ;83F11F;7F1F27;
                       STA.W $09B3                          ;83F123;0009B3;
                                                            ;      ;      ;
          CODE_83F126: %Set16bit(!MX)                             ;83F126;      ;
                       LDA.W #$0000                         ;83F128;      ;
                       LDX.W #$0046                         ;83F12B;      ;
                       LDY.W #$0000                         ;83F12E;      ;
                       JSL.L VIP                            ;83F131;848097;
                       %Set8bit(!M)                             ;83F135;      ;
                       LDA.B #$15                           ;83F137;      ;
                       STA.L $7F1F47                        ;83F139;7F1F47;
                       %Set16bit(!M)                             ;83F13D;      ;
                       LDA.L $7F1F5E                        ;83F13F;7F1F5E;
                       ORA.W #$8000                         ;83F143;      ;
                       STA.L $7F1F5E                        ;83F146;7F1F5E;
                       RTS                                  ;83F14A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F14B: %Set16bit(!MX)                             ;83F14B;      ;
                       LDA.W #$0000                         ;83F14D;      ;
                       LDX.W #$0046                         ;83F150;      ;
                       LDY.W #$0001                         ;83F153;      ;
                       JSL.L VIP                            ;83F156;848097;
                       %Set8bit(!M)                             ;83F15A;      ;
                       LDA.B #$16                           ;83F15C;      ;
                       STA.L $7F1F47                        ;83F15E;7F1F47;
                       RTS                                  ;83F162;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F163: %Set16bit(!MX)                             ;83F163;      ;
                       LDA.W #$0000                         ;83F165;      ;
                       LDX.W #$0046                         ;83F168;      ;
                       LDY.W #$0002                         ;83F16B;      ;
                       JSL.L VIP                            ;83F16E;848097;
                       %Set8bit(!M)                             ;83F172;      ;
                       LDA.B #$17                           ;83F174;      ;
                       STA.L $7F1F47                        ;83F176;7F1F47;
                       RTS                                  ;83F17A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F17B: %Set16bit(!MX)                             ;83F17B;      ;
                       LDA.W #$0000                         ;83F17D;      ;
                       LDX.W #$0046                         ;83F180;      ;
                       LDY.W #$0003                         ;83F183;      ;
                       JSL.L VIP                            ;83F186;848097;
                       %Set8bit(!M)                             ;83F18A;      ;
                       LDA.B #$18                           ;83F18C;      ;
                       STA.L $7F1F47                        ;83F18E;7F1F47;
                       RTS                                  ;83F192;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F193: %Set16bit(!MX)                             ;83F193;      ;
                       LDA.W #$0000                         ;83F195;      ;
                       LDX.W #$0046                         ;83F198;      ;
                       LDY.W #$0004                         ;83F19B;      ;
                       JSL.L VIP                            ;83F19E;848097;
                       %Set8bit(!M)                             ;83F1A2;      ;
                       LDA.B #$19                           ;83F1A4;      ;
                       STA.L $7F1F47                        ;83F1A6;7F1F47;
                       RTS                                  ;83F1AA;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F1AB: %Set16bit(!MX)                             ;83F1AB;      ;
                       LDA.W #$0000                         ;83F1AD;      ;
                       LDX.W #$0046                         ;83F1B0;      ;
                       LDY.W #$0005                         ;83F1B3;      ;
                       JSL.L VIP                            ;83F1B6;848097;
                       %Set8bit(!M)                             ;83F1BA;      ;
                       LDA.B #$1A                           ;83F1BC;      ;
                       STA.L $7F1F47                        ;83F1BE;7F1F47;
                       RTS                                  ;83F1C2;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F1C3: %Set16bit(!MX)                             ;83F1C3;      ;
                       LDA.W #$0000                         ;83F1C5;      ;
                       LDX.W #$0046                         ;83F1C8;      ;
                       LDY.W #$0006                         ;83F1CB;      ;
                       JSL.L VIP                            ;83F1CE;848097;
                       %Set8bit(!M)                             ;83F1D2;      ;
                       LDA.B #$1B                           ;83F1D4;      ;
                       STA.L $7F1F47                        ;83F1D6;7F1F47;
                       RTS                                  ;83F1DA;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F1DB: %Set16bit(!MX)                             ;83F1DB;      ;
                       LDA.W #$0000                         ;83F1DD;      ;
                       LDX.W #$0046                         ;83F1E0;      ;
                       LDY.W #$0007                         ;83F1E3;      ;
                       JSL.L VIP                            ;83F1E6;848097;
                       %Set8bit(!M)                             ;83F1EA;      ;
                       LDA.B #$20                           ;83F1EC;      ;
                       STA.L $7F1F47                        ;83F1EE;7F1F47;
                       %Set16bit(!M)                             ;83F1F2;      ;
                       LDA.L $7F1F5E                        ;83F1F4;7F1F5E;
                       AND.W #$7FFF                         ;83F1F8;      ;
                       STA.L $7F1F5E                        ;83F1FB;7F1F5E;
                       RTS                                  ;83F1FF;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F200: %Set16bit(!MX)                             ;83F200;      ;
                       LDA.W #$0000                         ;83F202;      ;
                       LDX.W #$0046                         ;83F205;      ;
                       LDY.W #$0008                         ;83F208;      ;
                       JSL.L VIP                            ;83F20B;848097;
                       %Set8bit(!M)                             ;83F20F;      ;
                       LDA.B #$1D                           ;83F211;      ;
                       STA.L $7F1F47                        ;83F213;7F1F47;
                       RTS                                  ;83F217;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F218: %Set16bit(!MX)                             ;83F218;      ;
                       LDA.W #$0000                         ;83F21A;      ;
                       LDX.W #$0046                         ;83F21D;      ;
                       LDY.W #$0009                         ;83F220;      ;
                       JSL.L VIP                            ;83F223;848097;
                       %Set8bit(!M)                             ;83F227;      ;
                       LDA.B #$1E                           ;83F229;      ;
                       STA.L $7F1F47                        ;83F22B;7F1F47;
                       RTS                                  ;83F22F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F230: %Set16bit(!MX)                             ;83F230;      ;
                       LDA.W #$0000                         ;83F232;      ;
                       LDX.W #$0046                         ;83F235;      ;
                       LDY.W #$000A                         ;83F238;      ;
                       JSL.L VIP                            ;83F23B;848097;
                       %Set8bit(!M)                             ;83F23F;      ;
                       LDA.B #$1F                           ;83F241;      ;
                       STA.L $7F1F47                        ;83F243;7F1F47;
                       RTS                                  ;83F247;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_83F248: %Set16bit(!MX)                             ;83F248;      ;
                       LDA.W #$0000                         ;83F24A;      ;
                       LDX.W #$0046                         ;83F24D;      ;
                       LDY.W #$000B                         ;83F250;      ;
                       JSL.L VIP                            ;83F253;848097;
                       %Set8bit(!M)                             ;83F257;      ;
                       LDA.B #$20                           ;83F259;      ;
                       STA.L $7F1F47                        ;83F25B;7F1F47;
                       %Set16bit(!M)                             ;83F25F;      ;
                       LDA.L $7F1F5E                        ;83F261;7F1F5E;
                       AND.W #$7FFF                         ;83F265;      ;
                       STA.L $7F1F5E                        ;83F268;7F1F5E;
                       RTS                                  ;83F26C;      ;


;;;;;;;; Ranch mastery calculator
;;;;;;;; This function is notoriously bugged, Ill add corrections to it in
;;;;;;;; comments of Maria, but I dont want to change the code... yet at least.
;;;;;;;; Repeat the fix on every other place I add BUG
RanchMasteryCalculator:
        %Set16bit(!M)
        LDA.W #$0000
        STA.L !ranch_mastery
        LDA.L !moneyL
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        CMP.W #78                            ;aka > 99840G
        BCC +
        LDA.W #78

      + STA.L !ranch_mastery
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.L !cow_N
        ASL A
        CLC
        ADC.L !cow_N                         ;Number of cows * 3
        %Set16bit(!M)
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.L !chicks_N
        ASL A
        CLC
        ADC.L !chicks_N                      ;chinks * 3 too
        %Set16bit(!M)
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !max_stamina
        SEC
        SBC.B #$64                           ;Max stamina - 100, it starts at 100
        LSR A
        %Set16bit(!M)
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !hearts_maria                  ;BUG
        AND.W #$01FF                         ;replace with CMP
        ;BIM +
        ;STA #31
        ;BRA ++
        LSR A                                ;add a + in this line
        LSR A
        LSR A
        LSR A
        CLC                                  ;add ++ here
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !hearts_ann                    ;BUG
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !hearts_nina                   ;BUG
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !hearts_ellen                  ;BUG
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !hearts_eve                    ;BUG
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !shipped_tomatoes              ;Bug
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !shipped_corn                  ;Bug
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !shipped_potatoes              ;Bug
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !shipped_turnips               ;Bug
        AND.W #$01FF
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L !happiness
        LSR A
        LSR A
        LSR A
        LSR A
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery
        %Set16bit(!M)
        LDA.L $7F1F64
        AND.W #$0080                         ;House Upgrade Max
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #16
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L $7F1F64
        AND.W #$0040                         ;House First Upgrade
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #16
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L $7F1F6E
        AND.W #$0008                         ;Child 1
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #16
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L $7F1F6E
        AND.W #$0004                         ;Child 2
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #16
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L $7F1F66
        AND.W #$001F
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #32
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L $7F1F6E
        AND.W #$4000                         ;Clock Owned
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #22
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L $7F1F6C
        AND.W #$1000                         ;Turtle Shell
        BEQ +
        LDA.L !ranch_mastery
        CLC
        ADC.W #21
        STA.L !ranch_mastery

      + %Set16bit(!M)
        LDA.L !ranch_development
        LSR A
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery

        %Set16bit(!M)
        LDX.W #$0000

      - %Set16bit(!MX)                       ;Cow Happiness Loop
        PHX
        TXA
        JSL.L GetsCowPointer
        %Set8bit(!M)
        %Set16bit(!X)
        LDY.W #$0000
        LDA.B [$72],Y
        AND.B #$01                           ;cow exists
        BEQ ++
        LDY.W #$0004                         ;cow happiness var
        LDA.B #$00
        XBA
        LDA.B [$72],Y
        LSR A
        LSR A
        LSR A
        CMP.B #$19                           ;at least half max happyness
        BCC +
        LDA.B #25

      + %Set16bit(!M)
        CLC
        ADC.L !ranch_mastery
        STA.L !ranch_mastery

     ++ %Set16bit(!MX)
        PLX
        INX
        CPX.W #12
        BNE -

        %Set16bit(!M)
        LDA.L !ranch_mastery
        CMP.W #999
        BCC +
        LDA.W #999
        STA.L !ranch_mastery

      + %Set16bit(!MX)                       ;TODO
        LDA.W #$0000
        LDX.W #$0046
        LDY.W #$000C
        JSL.L VIP
        %Set8bit(!M)
        LDA.B #$25
        STA.L $7F1F47
        %Set16bit(!M)
        LDA.L $7F1F5E
        ORA.W #$8000
        STA.L $7F1F5E

        RTS

;;;;;;;; empty
CODE_83F4D7: RTS

;;;;;;;;
CODE_83F4D8:
        %Set16bit(!MX)
        LDA.W #$0000
        LDX.W #$002E                         ;56
        LDY.W #$0000
        JSL.L VIP                            ;TODO
        %Set16bit(!MX)
        STZ.W $0196
        LDA.L $7F1F5E
        ORA.W #$0002                         ;FLAG5E
        STA.L $7F1F5E
        %Set8bit(!M)
        LDA.B #$00
        STA.L $7F1F47
        %Set8bit(!M)
        %Set16bit(!X)
        STZ.W $09B5
        %Set16bit(!M)
        LDA.W #$00B1
        STA.W $0889
        STA.W $088B
        STA.W $088D
        STA.W $088F
        LDX.W #$0000

    .cowloop:
        %Set16bit(!MX)                             ;83F51A;      ;
        PHX                                  ;83F51C;      ;
        TXA                                  ;83F51D;      ;
        JSL.L GetsCowPointer                ;83F51E;83C9A7;
        %Set8bit(!M)                             ;83F522;      ;
        %Set16bit(!X)                             ;83F524;      ;
        LDY.W #$0000                         ;83F526;      ;
        LDA.B [$72],Y                        ;83F529;000072;
        AND.B #$01                           ;83F52B;      ;
        BEQ .CODE_83F573                      ;83F52D;83F573;
        LDY.W #$0004                         ;83F52F;      ;
        LDA.B [$72],Y                        ;83F532;000072;
        CMP.W $09B5                          ;83F534;0009B5;
        BCS .CODE_83F53B                      ;83F537;83F53B;
        BRA .CODE_83F573                      ;83F539;83F573;
                                            ;      ;      ;
                                            ;      ;      ;
    .CODE_83F53B:
        %Set8bit(!M)                             ;83F53B;      ;
        STA.W $09B5                          ;83F53D;0009B5;
        %Set8bit(!M)                             ;83F540;      ;
        LDA.B #$00                           ;83F542;      ;
        XBA                                  ;83F544;      ;
        LDY.W #$000C                         ;83F545;      ;
        LDA.B [$72],Y                        ;83F548;000072;
        %Set16bit(!M)                             ;83F54A;      ;
        STA.W $0889                          ;83F54C;000889;
        %Set8bit(!M)                             ;83F54F;      ;
        LDY.W #$000D                         ;83F551;      ;
        LDA.B [$72],Y                        ;83F554;000072;
        %Set16bit(!M)                             ;83F556;      ;
        STA.W $088B                          ;83F558;00088B;
        %Set8bit(!M)                             ;83F55B;      ;
        LDY.W #$000E                         ;83F55D;      ;
        LDA.B [$72],Y                        ;83F560;000072;
        %Set16bit(!M)                             ;83F562;      ;
        STA.W $088D                          ;83F564;00088D;
        %Set8bit(!M)                             ;83F567;      ;
        LDY.W #$000F                         ;83F569;      ;
        LDA.B [$72],Y                        ;83F56C;000072;
        %Set16bit(!M)                             ;83F56E;      ;
        STA.W $088F                          ;83F570;00088F;

    .CODE_83F573:
        %Set16bit(!MX)                             ;83F573;      ;
        PLX                                  ;83F575;      ;
        INX                                  ;83F576;      ;
        CPX.W #$000C                         ;83F577;      ;
        BNE .cowloop                      ;83F57A;83F51A;
        JSL.L CalculateFarmDevelopment                          ;83F57C;82AA0C;
        %Set16bit(!MX)                             ;83F580;      ;
        LDA.L !ranch_development                        ;83F582;7F1F56;
        STA.B $7E                            ;83F586;00007E;
        LDA.W #$000A                         ;83F588;      ;
        JSL.L Unk_Audio23                   ;83F58B;838000;
        %Set16bit(!MX)                             ;83F58F;      ;
        STA.B $7E                            ;83F591;00007E;
        LDA.W #$0127                         ;83F593;      ;
        STA.B $80                            ;83F596;000080;
        JSL.L DivisionUnsigned               ;83F598;838082;
        %Set16bit(!MX)                             ;83F59C;      ;
        STA.L !ranch_development                        ;83F59E;7F1F56;
        CMP.W #$0064                         ;83F5A2;      ;
        BCC .CODE_83F5AE                      ;83F5A5;83F5AE;
        LDA.W #$0064                         ;83F5A7;      ;
        STA.L !ranch_development                        ;83F5AA;7F1F56;
                                            ;      ;      ;
        .CODE_83F5AE: RTS                                  ;83F5AE;      ;
