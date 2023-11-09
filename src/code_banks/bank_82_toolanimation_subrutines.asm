ORG $8290DD

ToolAnimationNoAction: ;8290DD
        RTS

ToolAnimationSickle: ;8290DE
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0050
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationHoe: ;8290EC
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0054
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationHammer: ;8290FA
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0058
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationAxe: ;829108
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$005C
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationCornSeeds: ;829116
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

ToolAnimationTomatoSeeds: ;829121
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

ToolAnimationPotatoSeeds: ;82912C
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

ToolAnimationTurnipSeeds: ;829137
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

ToolAnimationCowMedicine: ;829142
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationMiraclePotion: ;829150
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationBell: ;82915E
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

ToolAnimationGrassSeeds: ;829179
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0046
        STA.W $0901
        RTS

ToolAnimationPaint: ;829184
        %Set16bit(!MX)
        LDA.W #$0044
        STA.W $0901
        RTS

ToolAnimationMilker: ;82918D
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0078
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationBrush: ;82919B
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDA.W #$0064
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationWateringCan: ;8291A9
        %Set8bit(!M)
        %Set16bit(!X)
        JSR.W SUB_8292A0
        %Set8bit(!M)
        CMP.B #$02
        BEQ .CODE_8291D5
        LDA.W !watering_can_water
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
        STA.W !watering_can_water

    .CODE_8291E7: RTS

ToolAnimationGoldSickle: ;8291E8
        %Set16bit(!MX)
        LDA.W #$0048
        STA.W $0901
        RTS

ToolAnimationGoldHoe: ;8291F1
        %Set16bit(!MX)
        LDA.W #$007C
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationGoldHammer: ;8291FD
        %Set16bit(!MX)
        LDA.W #$0084
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationGoldAxe: ;829209
        %Set16bit(!MX)
        LDA.W #$0080
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationSprinkler: ;829215
        %Set16bit(!MX)
        LDA.W #$0047
        STA.W $0901
        RTS

ToolAnimationBeans: ;82921E
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationGem: ;82922A
        %Set16bit(!MX)
        LDA.W #$00AC
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationBlueFeather: ;829236
        %Set16bit(!MX)
        LDA.W #$00A8
        STA.W $0901
        RTS

ToolAnimationChickenFeed: ;82923F
        %Set16bit(!MX)
        LDA.W #$0074
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationCowFeed: ;82924B
        %Set16bit(!MX)
        LDA.W #$0074
        CLC
        ADC.B !player_direction
        STA.W $0901
        RTS

ToolAnimationUNK: ;829257
        %Set16bit(!MX)
        LDA.W #$0088
        STA.W $0901
        RTS
