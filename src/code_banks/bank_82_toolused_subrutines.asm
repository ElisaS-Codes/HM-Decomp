ORG $8290DD

Tool_NoAction: ;8290DD
        RTS

Tool_Sicle: ;8290DE
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0050
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Hoe: ;8290EC
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0054
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Hammer: ;8290FA
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0058
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Axe: ;829108
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$005C
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_CornSeeds: ;829116
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

Tool_TomatoSeeds: ;829121
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

Tool_PotatoSeeds: ;82912C
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

Tool_TurnipSeeds: ;829137
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

Tool_CowMedicine: ;829142
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_MiraclePotion: ;829150
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Bell: ;82915E
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0060
        CLC
        ADC.B !player_direction
        STA.W $0901
        %Set16bit(!M)
        LDA.L $7F1F5A
        ORA.W #$0010                        ;FLAG5A
        STA.L $7F1F5A
        RTS

Tool_GrassSeeds: ;829179
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

Tool_Paint: ;829184
        %Set16bit(!MX)
        LDA.W #$0044
        STA.W $0901
        RTS

Tool_Milker: ;82918D
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0078
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Brush: ;82919B
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0064
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_WateringCan: ;8291A9
        %Set8bit(!M)
        %Set16bit(!X)
        JSR.W SUB_8292A0
        %Set8bit(!M)
        CMP.B #$02
        BEQ .CODE_8291D5
        LDA.W !sprinkler_water
        BEQ .CODE_8291C8
        %Set16bit(!MX)
        LDA.W #$0068
        CLC
        ADC.B !player_direction
        STA.W $0901
        BRA .CODE_8291E7

    .CODE_8291C8:
        %Set16bit(!MX)
        LDA.W #$006C
        CLC
        ADC.B !player_direction
        STA.W $0901
        BRA .CODE_8291E7

    .CODE_8291D5:
        %Set16bit(!MX)
        LDA.W #$0070
        CLC
        ADC.B !player_direction
        STA.W $0901
        %Set8bit(!M)
        LDA.B #$14
        STA.W !sprinkler_water

    .CODE_8291E7: RTS

Tool_GoldSicle: ;8291E8
        %Set16bit(!MX)
        LDA.W #$0048
        STA.W $0901
        RTS

Tool_GoldHoe: ;8291F1
        %Set16bit(!MX)
        LDA.W #$007C
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_GoldHammer: ;8291FD
        %Set16bit(!MX)
        LDA.W #$0084
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_GoldAxe: ;829209
        %Set16bit(!MX)
        LDA.W #$0080
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Sprinkler: ;829215
        %Set16bit(!MX)
        LDA.W #$0047
        STA.W $0901
        RTS

Tool_Beans: ;82921E
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_Gem: ;82922A
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_BlueFeather: ;829236
        %Set16bit(!MX)
        LDA.W #$00A8
        STA.W $0901
        RTS

Tool_ChickenFeed: ;82923F
        %Set16bit(!MX)
        LDA.W #$0074
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_CowFeed: ;82924B
        %Set16bit(!MX)
        LDA.W #$0074
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

Tool_UNK: ;829257
        %Set16bit(!MX)
        LDA.W #$0088
        STA.W $0901
        RTS
