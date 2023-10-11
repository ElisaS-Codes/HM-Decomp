       ORG $828000

;;;;;;;
UpdateTime: ;828000
       %Set8bit(!M)
       %Set16bit(!X)
       LDA.W !time_running
       AND.B #$02                            ;advance to next day
       BEQ +
       JMP.W NightReset

     + LDA.W !time_running
       AND.B #$01                            ;clock stopped
       BNE +
       JMP.W .return

     + %Set16bit(!M)
       LDA.L $7F1F5A
       AND.W #$0400                          ;FLAG5A
       BEQ +
       JMP.W CODE_828165                     ;TODO

     + %Set8bit(!M)
       LDA.L !seconds
       INC A
       STA.L !seconds
       CMP.B #60
       BNE .noTimeUpdate
       LDA.B #$00
       STA.L !seconds
       LDA.L !minutes
       INC A
       STA.L !minutes
       CMP.B #15
       BNE .noTimeUpdate
       LDA.B #$00
       STA.L !minutes
       LDA.L !hour
       CMP.B #18
       BEQ .noTimeUpdate
       INC A
       STA.L !hour
       JSL.L HaveLunch
       JSL.L SaleScene
       %Set8bit(!M)
       LDA.L !hour
       CMP.B #18
       BEQ .hour6PM
       BRA .noTimeUpdate

    .hour6PM:
       %Set16bit(!M)
       LDA.L $7F1F5E
       AND.W #$8000                          ;FLAGS5E
       BNE .noTimeUpdate
       %Set8bit(!M)
       LDA.B #$FF
       STA.W $0117
       JSL.L UNK_Audio25
       %Set8bit(!M)
       LDA.B #$FF
       STA.W $0110

    .noTimeUpdate:
       %Set8bit(!M)
       LDA.W $017B                           ;something to do with text?
       PHA
       JSL.L AA9999
       %Set8bit(!M)
       PLA
       CMP.W $017B
       BEQ .return
       LDY.W #$0004
       JSL.L ClearMemoryPointers1            ;TODO
       JSL.L A8888                           ;TODO

    .return:
       RTL

;;;;;;;;
HaveLunch: ;8280AA
       %Set8bit(!M)
       %Set16bit(!X)
       LDA.L !hour
       CMP.B #12
       BEQ .12pm
       JMP.W .return

    .12pm:
       %Set8bit(!M)
       LDA.B #20
       JSL.L ChangeStamina
       %Set16bit(!M)
       LDA.B !game_state
       AND.W #$0430                          ;FLAGD2
       BEQ .actionchecks
       JMP.W .return

   .actionchecks:
      LDA.B !player_action
      CMP.W #$000F                           ;Fishing pre casting line
      BNE .fishing
      JMP.W .return

   .fishing:
      CMP.W #$0010                           ;Fishing casting
      BNE .fishing2
      JMP.W .return

   .fishing2:
      CMP.W #$0011                           ;Fishing waiting
      BNE .fishing3
      JMP.W .return

   .fishing3:
      CMP.W #$0012                           ;Fishing biting
      BNE .fishing4
      JMP.W .return

   .fishing4:
      CMP.W #$0013                           ;Fishing retracting
      BNE .shorthop
      JMP.W .return

   .shorthop:
      CMP.W #$0017                           ;Short Hop
      BNE .midhop
      JMP.W .return

   .midhop:
      CMP.W #$0018                           ;Mid Hop
      BNE .CODE_8280FF
      JMP.W .return

   .CODE_8280FF:
      LDA.B !game_state
      AND.W #$0800                           ;FLAGD2
      BEQ .CODE_828111
      JMP.W .return

   .CODE_828111:
      %Set8bit(!M)
      LDA.B #$03
      JSL.L RNGReturn0toA
      %Set8bit(!M)
      STA.W $0924
      %Set16bit(!MX)
      LDA.B !game_state
      ORA.W #$0004                           ;FLAGD2
      STA.B !game_state
      %Set16bit(!MX)
      LDA.B !game_state
      ORA.W #$0400                           ;FLAGD2
      STA.B !game_state

    .return: RTL                                  ;828130;      ;END_BHHH

;;;;;;;
SaleScene: ;828131
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.L !hour
      CMP.B #17
      BEQ .salescene
      JMP.W ReturnSales

   .salescene:
      LDA.B !tilemap_to_load
      CMP.B #$04
      BCS ReturnSales                        ;not on farm return next subrutine
      LDA.B #$00
      STA.W !inputstate
      %Set16bit(!M)
      LDA.L $7F1F5A
      ORA.W #$0400                           ;FLAG5A
      STA.L $7F1F5A
      LDA.W #$0006
      LDX.W #$0000
      LDY.W #$0026
      JSL.L VIP

;;;;;;;;
CODE_828165: ;828165
      %Set16bit(!M)
      LDA.L $7F1F5A
      AND.W #$0800                           ;FLAG5A
      BEQ ReturnSales
      %Set16bit(!MX)
      LDA.B !game_state
      AND.W #$0040                           ;FLAGD2
      BEQ .CODE_82817C
      JMP.W ReturnSales

   .CODE_82817C:
      LDA.W #$0002
      STA.W !inputstate
      LDX.W #$031A
      %Set16bit(!M)
      LDA.L !shipping_moneyL
      BNE .CODE_828198
      %Set8bit(!M)
      LDA.L !shipping_moneyH
      BNE .CODE_828198
      LDX.W #$031B

   .CODE_828198:
      %Set8bit(!M)
      LDA.B #$00
      STA.W $0191
      JSL.L CODE_83935F                      ;TODO
      %Set16bit(!M)
      LDA.W #$0006
      LDX.W #$0000
      LDY.W #$0027
      JSL.L CODE_84803F                      ;TODO
      %Set16bit(!M)
      LDA.L $7F1F5A
      AND.W #$FBFF                           ;FLAG5A
      STA.L $7F1F5A

ReturnSales: RTL

;;;;;;;;
                BFFFF: %Set8bit(!M)                             ;8281C0;      ;
                       %Set16bit(!X)                             ;8281C2;      ;
                       LDA.B #$00                           ;8281C4;      ;
                       XBA                                  ;8281C6;      ;
                       LDA.W !weather_tomorrow                          ;8281C7;00098C;
                       %Set16bit(!M)                             ;8281CA;      ;
                       TAX                                  ;8281CC;      ;
                       %Set8bit(!M)                             ;8281CD;      ;
                       LDA.L UNK_Table6,X                   ;8281CF;8281FD;
                       STA.W $0990                          ;8281D3;000990;
                       %Set16bit(!M)                             ;8281D6;      ;
                       LDA.W $0196                          ;8281D8;000196;
                       AND.W #$0010                         ;8281DB;      ;
                       BNE CODE_8281EA                      ;8281DE;8281EA;
                       LDA.W $0196                          ;8281E0;000196;
                       AND.W #$0200                         ;8281E3;      ;
                       BNE CODE_8281F3                      ;8281E6;8281F3;
                       BRA $12                          ;8281E8;8281FC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8281EA: %Set8bit(!M)                             ;8281EA;      ;
                       LDA.B #$0B                           ;8281EC;      ;
                       STA.W $0990                          ;8281EE;000990;
                       BRA $09                          ;8281F1;8281FC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8281F3: %Set8bit(!M)                             ;8281F3;      ;
                       LDA.B #$04                           ;8281F5;      ;
                       STA.W $0990                          ;8281F7;000990;
                       BRA $00                          ;8281FA;8281FC;
                                                            ;      ;      ;
                                                            ;      ;      ;
               RTL                                  ;8281FC;      ;END_BFFFF
                                                            ;      ;      ;
                                                            ;      ;      ;
           UNK_Table6: db $00,$01,$02,$03,$00,$00,$05,$06,$07,$08,$09,$0A;8281FD;      ;
                                                            ;      ;      ;
                BOOOO: %Set16bit(!MX)                             ;828209;      ;
                       LDA.W $0196                          ;82820B;000196;
                       AND.W #$0002                         ;82820E;      ;
                       BNE BMMMM                            ;828211;828234;
                       LDA.W $0196                          ;828213;000196;
                       AND.W #$0008                         ;828216;      ;
                       BNE BLLLL                            ;828219;828242;
                       LDA.W $0196                          ;82821B;000196;
                       AND.W #$0010                         ;82821E;      ;
                       BNE BKKKK                            ;828221;828250;
                       LDA.W $0196                          ;828223;000196;
                       AND.W #$0100                         ;828226;      ;
                       BNE CODE_82825E                      ;828229;82825E;
                       LDA.W $0196                          ;82822B;000196;
                       AND.W #$0200                         ;82822E;      ;
                       BNE BJJJJ                            ;828231;828260;
                                                            ;      ;      ;
               RTL                                  ;828233;      ;END_BOOOO
                                                            ;      ;      ;
                                                            ;      ;      ;
                BMMMM: %Set16bit(!M)                             ;828234;      ;
                       LDA.W #$0000                         ;828236;      ;
                       JSR.W LoadsFromSeasonTable           ;828239;828270;
                       JSL.L CHHHH                          ;82823C;82A713;
                       BRA $F1                          ;828240;828233;END_BMMMM
                                                            ;      ;      ;
                                                            ;      ;      ;
                BLLLL: %Set16bit(!M)                             ;828242;      ;
                       LDA.W #$0001                         ;828244;      ;
                       JSR.W LoadsFromSeasonTable           ;828247;828270;
                       JSL.L CHHHH                          ;82824A;82A713;
                       BRA $E3                          ;82824E;828233;
                                                            ;      ;      ;
                                                            ;      ;      ;
                BKKKK: %Set16bit(!M)                             ;828250;      ;
                       LDA.W #$0002                         ;828252;      ;
                       JSR.W LoadsFromSeasonTable           ;828255;828270;
                       JSL.L CHHHH                          ;828258;82A713;
                       BRA $D5                          ;82825C;828233;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82825E: BRA $D3                          ;82825E;828233;
                                                            ;      ;      ;
                                                            ;      ;      ;
                BJJJJ: %Set16bit(!M)                             ;828260;      ;
                       LDA.W #$0003                         ;828262;      ;
                       JSR.W LoadsFromSeasonTable           ;828265;828270;
                       JSL.L CHHHH                          ;828268;82A713;
                       BRA $C5                          ;82826C;828233;
                                                            ;      ;      ;
                       BRA $C3                          ;82826E;828233;
                                                            ;      ;      ;
                                                            ;      ;      ;
 LoadsFromSeasonTable: %Set16bit(!MX)                             ;828270;      ;Param in A ($04?) Return in A,X,Y
                       ASL A                                ;828272;      ;
                       ASL A                                ;828273;      ;
                       TAX                                  ;828274;      ;
                       %Set8bit(!M)                             ;828275;      ;
                       LDA.B #$00                           ;828277;      ;
                       XBA                                  ;828279;      ;
                       LDA.L UNK_Table5_SeasonRelated,X     ;82827A;828298;loads a bit according to season
                       %Set16bit(!M)                             ;82827E;      ;
                       PHA                                  ;828280;      ;
                       INX                                  ;828281;      ;
                       %Set8bit(!M)                             ;828282;      ;
                       LDA.L UNK_Table5_SeasonRelated,X     ;828284;828298;
                       %Set16bit(!M)                             ;828288;      ;
                       PHA                                  ;82828A;      ;
                       INX                                  ;82828B;      ;
                       %Set8bit(!M)                             ;82828C;      ;
                       LDA.L UNK_Table5_SeasonRelated,X     ;82828E;828298;
                       %Set16bit(!M)                             ;828292;      ;
                       TAY                                  ;828294;      ;
                       PLX                                  ;828295;      ;
                       PLA                                  ;828296;      ;
                       RTS                                  ;828297;      ;End_LoadsFromSeasonTable
                                                            ;      ;      ;
                                                            ;      ;      ;
UNK_Table5_SeasonRelated: db $60,$00,$00,$00,$40,$00,$00,$00,$08,$10,$04,$00,$08,$00,$04,$00;828298;      ;
                       db $00,$40,$20,$00                   ;8282A8;      ;
                                                            ;      ;      ;
;;;;;;
NightReset: ;8282AC
      %Set8bit(!M)
      %Set16bit(!X)
      %Set8bit(!M)
      LDA.L !weekday
      INC A
      CMP.B #$07
      BNE .dontResetWeekDay
      LDA.B #$00

   .dontResetWeekDay:
      %Set8bit(!M)
      STA.L !weekday
      LDA.L !day
      INC A
      CMP.B #$1F
      BNE .dontResetMonth
      LDA.L !season
      INC A
      CMP.B #$04
      BNE .dontResetSeason
      LDA.L !year
      INC A
      STA.L !year
      %Set16bit(!M)
      LDA.W #$0004
      JSR.W LoadsFromSeasonTable
      JSL.L CHHHH
      %Set8bit(!M)
      LDA.B #$00

   .dontResetSeason:
      %Set8bit(!M)
      STA.L !season
      LDA.B #$01

   .dontResetMonth:
      %Set8bit(!M)
      STA.L !day
      LDA.B #$FF
      STA.W $0117
      JSL.L UNK_Audio25
      %Set8bit(!M)
      LDA.B #$0F
      STA.B !param1
      LDA.B #$03
      STA.B !param2
      LDA.B #$01
      STA.B !param3
      JSL.L ScreenFadeout
      JSL.L ForceBlank
      %Set8bit(!M)
      LDA.B #$0F                             ;MapForkWinter???
      STA.B !tilemap_to_load
      %Set16bit(!MX)
      LDA.L $7F1F64
      AND.W #$FFCF                           ;FLAG64
      STA.L $7F1F64
      LDA.L $7F1F70
      AND.W #$FFFD                           ;FLAG70
      STA.L $7F1F70
      %Set16bit(!MX)
      LDA.W $0196
      AND.W #$0010
      BEQ .skipflagset
      LDA.L $7F1F64
      ORA.W #$0020                           ;FLAG64
      STA.L $7F1F64

   .skipflagset:
      JSL.L CODE_828C09                      ;TODO, something related to normal days
      %Set16bit(!MX)
      LDA.W $0196
      AND.W #$0200                           ;FLAG196
      BEQ .CODE_828367
      LDA.L $7F1F64
      ORA.W #$0010                           ;FLAG64
      STA.L $7F1F64

   .CODE_828367:
      %Set16bit(!MX)
      LDA.W $0196
      AND.W #$0100                           ;FLAG196
      BEQ .CODE_82837C
      LDA.L $7F1F70
      ORA.W #$0002                           ;FLAG70
      STA.L $7F1F70

   .CODE_82837C:
      JSL.L $8095F5                          ;TODO
      %Set8bit(!M)
      LDA.B #$06
      STA.L !hour
      LDA.B #$00
      STA.L !minutes
      LDA.B #$00
      STA.L !seconds
      JSL.L LoadsDateNames
      JSL.L Unk_Seasons2
      JSL.L BOOOO
      JSL.L CowFeedingandStatus
      JSL.L WeatherTomorrow
      JSL.L FindMostLovedName
      JSL.L WifePregnanacyandChilds
      %Set16bit(!M)
      STZ.W $0915
      STZ.B !game_state
      STZ.B !player_action
      %Set8bit(!M)
      LDA.W !max_stamina
      STA.W !current_stamina
      STZ.W !idle_animation_timer
      %Set16bit(!MX)
      LDA.B !game_state
      ORA.W #$0001
      STA.B !game_state
      %Set16bit(!MX)
      LDA.W #$0000
      STA.B !player_action
      %Set16bit(!MX)
      LDA.W #$0000
      STA.B !player_direction                ;down
      %Set16bit(!MX)
      LDA.W #$0000
      STA.W $0911
      %Set16bit(!MX)
      LDA.W #$0000
      STA.W $0901
      %Set16bit(!M)
      LDA.L !shipping_moneyL
      STA.B $72
      %Set8bit(!M)
      LDA.L !shipping_moneyH
      STA.B $74
      JSL.L AddMoney
      %Set16bit(!M)
      LDA.W #$0000
      STA.L !shipping_moneyL
      %Set8bit(!M)
      LDA.B #$00
      STA.L !shipping_moneyH
      %Set8bit(!M)
      STZ.W !fed_cows_N
      STZ.W !fed_chicks_N
      %Set16bit(!M)
      STZ.W !fed_cows_flags
      STZ.W !fed_chicks_flags
      %Set16bit(!M)
      LDA.W #$0000
      STA.L $7F1F5A
      LDA.W #$0000                           ;FLAG5A
      STA.L $7F1F5C
      LDA.W #$0000                           ;FLAG5C
      STA.L $7F1F5E
      LDA.W #$0000                           ;FLAG5E
      STA.L $7F1F60
      LDA.W #$0000                           ;FLAG60
      STA.L $7F1F62
      LDA.W #$0000                           ;FLAG62
      STA.L $7F1F74
      STA.L $7F1F76
      STA.L $7F1F78
      %Set16bit(!M)
      LDA.L $7F1F68
      ORA.W #$0001                           ;FLAG68
      STA.L $7F1F68
      LDA.L $7F1F66
      AND.W #$0020
      BEQ .CODE_828482                       ;TODO
      %Set16bit(!M)
      LDA.L $7F1F66
      AND.W #$FFDF                           ;FLAG66
      STA.L $7F1F66
      LDA.L $7F1F66
      ORA.W #$0040                           ;FLAG66
      STA.L $7F1F66

   .CODE_828482:
      %Set16bit(!M)
      LDA.L $7F1F66
      AND.W #$0080                           ;FLAG66
      BEQ .nohouseupgrade
      %Set8bit(!M)
      LDA.L !development_rate
      INC A
      STA.L !development_rate
      CMP.B #$04                             ;this keeps the time workers work?
      BNE .nohouseupgrade
      %Set16bit(!MX)
      LDA.L $7F1F66
      ORA.W #$0100                           ;FLAG66
      STA.L $7F1F66
      %Set16bit(!M)
      LDA.W #500
      STA.L !wood_need_for_upgrade
      LDA.L $7F1F66
      AND.W #$FF7F                           ;FLAG66
      STA.L $7F1F66
      LDA.L $7F1F64
      AND.W #$0040                           ;House Lvl2
      BEQ .houselvl2
      %Set16bit(!MX)
      LDA.L $7F1F64
      ORA.W #$0080                           ;sets House Max Level
      STA.L $7F1F64
      BRA .nohouseupgrade

   .houselvl2:
      %Set16bit(!MX)
      LDA.L $7F1F64
      ORA.W #$0040                           ;sets house to lvl 2
      STA.L $7F1F64

   .nohouseupgrade:
      %Set16bit(!MX)
      LDA.L $7F1F68
      AND.W #$0800                           ;FLAG68
      BEQ .goldhammerdelivery
      LDA.L $7F1F68
      AND.W #$F7FF                           ;FLAG68
      STA.L $7F1F68
      LDA.L $7F1F68
      ORA.W #$1000                           ;FLAG68
      STA.L $7F1F68

   .goldhammerdelivery:
      %Set16bit(!MX)
      LDA.L $7F1F68
      AND.W #$8000                           ;FLAG68
      BEQ .chackhoeevent
      LDA.L $7F1F68
      AND.W #$7FFF                           ;FLAG68
      STA.L $7F1F68
      %Set8bit(!M)
      LDA.L !shed_items_row_3
      ORA.B #$04                             ;Gold Hammer!
      STA.L !shed_items_row_3

   .chackhoeevent:
      %Set16bit(!MX)
      LDA.L $7F1F6A
      AND.W #$0080                           ;FLAG6A
      BEQ .skiphoeevent
      LDA.L $7F1F6A
      AND.W #$FF7F                           ;FLAG6A
      STA.L $7F1F6A
      LDA.L $7F1F6A
      AND.W #$0100                           ;FLAG6A
      BNE .goldenhoeevent
      LDA.L $7F1F6A
      ORA.W #$0102                           ;FLAG6A
      STA.L $7F1F6A
      BRA .skiphoeevent

   .goldenhoeevent:
      %Set8bit(!M)
      LDA.W !tool_selected
      CMP.B #$02                             ;Hoe
      BNE .removehoebackpack
      STZ.W !tool_selected                   ;remove Hoe

   .removehoebackpack:
      %Set8bit(!M)
      LDA.W !tool_backpack
      CMP.B #$02
      BNE .removehoeshed
      STZ.W !tool_backpack

   .removehoeshed:
      %Set8bit(!M)
      LDA.L !shed_items_row_1
      AND.B #$FD
      STA.L !shed_items_row_1
      LDA.L !shed_items_row_3
      ORA.B #$02
      STA.L !shed_items_row_3

   .skiphoeevent:
      %Set16bit(!MX)
      LDA.L $7F1F6A
      AND.W #$0400                           ;Flag6A
      BEQ .CODE_8285A9
      LDA.L $7F1F6A
      AND.W #$0800                           ;Flag6A
      BNE .CODE_8285A9
      LDA.L $7F1F6A
      ORA.W #$0800                           ;Flag6A
      STA.L $7F1F6A                          ;if not set, set it?
      LDA.L $7F1F6A
      AND.W #$FBFF                           ;Flag6A
      STA.L $7F1F6A

   .CODE_8285A9:
      %Set16bit(!MX)
      LDA.L $7F1F6A
      AND.W #$1000                           ;Flag6A
      BEQ .CODE_8285E2
      LDA.L $7F1F6A
      AND.W #$2000                           ;Flag6A
      BNE .CODE_8285E2
      %Set8bit(!M)
      LDA.W $09A3
      INC A
      STA.W $09A3
      CMP.B #$03
      BNE .CODE_8285E2
      %Set16bit(!M)
      LDA.L $7F1F6A
      ORA.W #$2000                           ;Flag6A
      STA.L $7F1F6A
      LDA.L $7F1F6A
      AND.W #$EFFF                           ;Flag6A
      STA.L $7F1F6A

   .CODE_8285E2:
      %Set16bit(!MX)
      LDA.L $7F1F6A
      AND.W #$4000                           ;Flag6A
      BEQ .CODE_82861B
      LDA.L $7F1F6A
      AND.W #$8000                           ;Flag6A
      BNE .CODE_82861B
      %Set8bit(!M)
      LDA.W $09A3
      INC A
      STA.W $09A3
      CMP.B #$03
      BNE .CODE_82861B
      %Set16bit(!M)
      LDA.L $7F1F6A
      ORA.W #$8000                           ;Flag6A
      STA.L $7F1F6A
      LDA.L $7F1F6A
      AND.W #$BFFF                           ;Flag6A
      STA.L $7F1F6A

   .CODE_82861B:
      %Set16bit(!MX)
      LDA.L $7F1F6C
      AND.W #$0001                           ;Flag6C
      BEQ .CODE_828654
      LDA.L $7F1F6C
      AND.W #$0002                           ;Flag6C
      BNE .CODE_828654
      %Set8bit(!M)
      LDA.W $09A3
      INC A
      STA.W $09A3
      CMP.B #$03
      BNE .CODE_828654
      %Set16bit(!M)
      LDA.L $7F1F6C
      ORA.W #$0002                           ;Flag6C
      STA.L $7F1F6C
      LDA.L $7F1F6C
      AND.W #$FFFE                           ;Flag6C
      STA.L $7F1F6C

   .CODE_828654:
      %Set16bit(!MX)
      LDA.L $7F1F6C
      AND.W #$0004                           ;Flag6C
      BEQ .CODE_82868D
      LDA.L $7F1F6C
      AND.W #$0008                           ;Flag6C
      BNE .CODE_82868D
      %Set8bit(!M)
      LDA.W $09A3
      INC A
      STA.W $09A3
      CMP.B #$03
      BNE .CODE_82868D
      %Set16bit(!M)
      LDA.L $7F1F6C
      ORA.W #$0008                           ;Flag6C
      STA.L $7F1F6C
      LDA.L $7F1F6C
      AND.W #$FFFB                           ;Flag6C
      STA.L $7F1F6C

   .CODE_82868D:
      %Set16bit(!MX)
      LDA.L $7F1F6C
      AND.W #$0010                           ;Flag6C
      BEQ .goldhoereturn
      LDA.L $7F1F6C
      AND.W #$0020                           ;Flag6C
      BNE .goldhoereturn
      %Set8bit(!M)
      LDA.W $09A3
      INC A
      STA.W $09A3
      CMP.B #$03
      BNE .goldhoereturn
      %Set16bit(!M)
      LDA.L $7F1F6C
      ORA.W #$0020                           ;Flag6C
      STA.L $7F1F6C
      LDA.L $7F1F6C
      AND.W #$FFEF                           ;Flag6C
      STA.L $7F1F6C

   .goldhoereturn:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$8000                           ;FLAG6E
      BEQ .CODE_8286E8
      LDA.L $7F1F6E
      AND.W #$7FFF                           ;FLAG6E
      STA.L $7F1F6E
      %Set8bit(!M)
      LDA.L !shed_items_row_3
      ORA.B #$01                             ;Add Hoe
      STA.L !shed_items_row_3

   .CODE_8286E8:
      %Set16bit(!MX)
      LDA.W $0196
      AND.W #$0010                           ;FLAG196
      BEQ .checksaveorcheat
      LDA.L $7F1F60
      ORA.W #$0001                           ;FLAG60
      STA.L $7F1F60

   .checksaveorcheat:
      %Set8bit(!M)
      LDA.W !time_running
      AND.B #$04
      BEQ .endgamecheat
      %Set8bit(!M)
      LDA.B #$00
      XBA
      LDA.W $098E
      JSL.L SaveGameSlot

   .endgamecheat:
      %Set16bit(!M)                          ;Check for the end credits ending
      LDA.W !Joy1_Current
      AND.W #$2030
      EOR.W #$2030
      BNE .CODE_828733
      %Set8bit(!M)
      LDA.B #$02
      STA.L !year
      LDA.B #$01
      STA.L !season
      LDA.B #$1E
      STA.L !day

   .CODE_828733:
      %Set8bit(!M)
      STZ.W !time_running
      %Set8bit(!M)
      STZ.W !item_on_hand
      %Set16bit(!MX)
      LDA.W #$0002
      EOR.W #$FFFF                           ;FFFD
      AND.B !game_state
      STA.B !game_state
      %Set16bit(!MX)
      LDA.W #$0088                           ;Chair Location
      STA.W !transition_dest_X
      LDA.W #$0078
      STA.W !transition_dest_Y
      %Set8bit(!M)
      LDA.B #$15                             ;House lvl 1
      STA.W !transition_dest
      JSL.L UNK_ScreenTransition
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.B #20
      JSL.L ChangeStamina
      %Set16bit(!MX)
      LDA.L $7F1F5E
      AND.W #$0004
      BNE .return
      %Set8bit(!M)
      LDA.B #$03
      JSL.L RNGReturn0toA
      %Set8bit(!M)
      STA.W $0924
      %Set16bit(!MX)
      LDA.B !game_state
      ORA.W #$0004
      STA.B !game_state

   .return: RTL

;;;;;;; Infinite Loop???
CODE_82878E: BRA CODE_82878E                 ;BUG

;;;;;;; Wife Pregnancy subrutine TODO second pass
WifePregnanacyandChilds: ;828790
      %Set16bit(!MX)
      LDA.L $7F1F6C
      AND.W #$FC7F
      STA.L $7F1F6C
      LDA.L $7F1F66
      AND.W #$0001                         ;All wifes are the same, probably a dropped
      BNE .wifefound                       ;feature?
      LDA.L $7F1F66
      AND.W #$0002
      BNE .wifefound
      LDA.L $7F1F66
      AND.W #$0004
      BNE .wifefound
      LDA.L $7F1F66
      AND.W #$0008
      BNE .wifefound
      LDA.L $7F1F66
      AND.W #$0010
      BNE .wifefound
      JMP.W .return

   .wifefound:
      %Set16bit(!MX)
      LDA.L !wife_pregnancy
      INC A
      STA.L !wife_pregnancy
      STA.B $7E
      LDA.W #120
      STA.B $80
      JSL.L DivisionUnsigned
      %Set16bit(!MX)
      LDA.B $7E
      BNE .abouttogivebirth
      LDA.L $7F1F6C
      ORA.W #$0080
      STA.L $7F1F6C

   .abouttogivebirth:
      %Set16bit(!MX)
      LDA.L $7F1F66
      AND.W #$0001
      BNE .wifemaria
      LDA.L $7F1F66
      AND.W #$0002
      BNE .wifeann
      LDA.L $7F1F66
      AND.W #$0004
      BNE .wifenina
      LDA.L $7F1F66
      AND.W #$0008
      BEQ +
      JMP.W .wifeellen

    + LDA.L $7F1F66                          ;Eve was totally an aftertough
      AND.W #$0010
      BEQ +
      JMP.W .wifeeve

    + JMP.W .return

   .wifemaria:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0004                           ;has one child
      BNE .maria2ndchild
      LDA.L !hearts_maria
      CMP.W #450
      BCC .marianothappyenough1
      JMP.W .wifepregnant

   .marianothappyenough1:
      JMP.W .skippregnancy

   .maria2ndchild:
      %Set16bit(!MX)
      LDA.L !hearts_maria
      CMP.W #650
      BCC .marianothappyenough2
      JMP.W .wifepregnant

   .marianothappyenough2:
      JMP.W .skippregnancy

   .wifeann:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0004
      BNE .ann2ndchild
      LDA.L !hearts_ann
      CMP.W #$01C2
      BCS .wifepregnant
      JMP.W .skippregnancy

   .ann2ndchild:
      %Set16bit(!MX)
      LDA.L !hearts_ann
      CMP.W #$028A
      BCS .wifepregnant
      JMP.W .skippregnancy

   .wifenina:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0004
      BNE .nina2ndchild
      LDA.L !hearts_nina
      CMP.W #$01C2
      BCS .wifepregnant
      JMP.W .skippregnancy

   .nina2ndchild:
      %Set16bit(!MX)
      LDA.L !hearts_nina
      CMP.W #$028A
      BCS .wifepregnant
      JMP.W .skippregnancy

   .wifeellen:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0004
      BNE .ellen2ndchild
      LDA.L !hearts_ellen
      CMP.W #$01C2
      BCS .wifepregnant
      BRA .skippregnancy

   .ellen2ndchild:
      %Set16bit(!MX)
      LDA.L !hearts_ellen
      CMP.W #$028A
      BCS .wifepregnant
      BRA .skippregnancy

   .wifeeve:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0004
      BNE .eve2ndchild
      LDA.L !hearts_eve
      CMP.W #$01C2
      BCS .wifepregnant
      BRA .skippregnancy

   .eve2ndchild:
      %Set16bit(!MX)
      LDA.L !hearts_eve
      CMP.W #$028A
      BCS .wifepregnant
      BRA .skippregnancy

   .wifepregnant:
      %Set16bit(!MX)
      LDA.L !wife_pregnancy
      CMP.W #20
      BCC .skippregnancy
      LDA.L $7F1F64
      AND.W #$0080                         ;House Level 2
      BEQ .skippregnancy
      LDA.L $7F1F6E
      AND.W #$0004                         ;first child
      BNE .itssecondchild
      LDA.L $7F1F6E
      ORA.W #$0004                         ;Set first child
      STA.L $7F1F6E
      BRA .skippregnancy

   .itssecondchild:
      %Set16bit(!MX)
      LDA.L !kid1_age
      CMP.W #90                              ;Kid 1 is big enough
      BCC .skippregnancy
      LDA.L $7F1F6E
      ORA.W #$0008                           ;Set first child
      STA.L $7F1F6E

   .skippregnancy:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0004                           ;child 1
      BEQ .childonedone
      LDA.L !kid1_age
      INC A
      STA.L !kid1_age
      CMP.W #60
      BCC .childonedone
      BNE .childonegrowing
      LDA.L $7F1F6E
      ORA.W #$0010
      STA.L $7F1F6E
      %Set16bit(!M)
      LDA.W #50                           ;Gets Born???
      JSL.L AddPlayerHappiness
      BRA .return

   .childonegrowing:
      %Set16bit(!MX)
      LDA.L !kid1_age
      SEC
      SBC.W #60
      STA.B $7E
      LDA.W #$0078
      STA.B $80
      JSL.L DivisionUnsigned
      %Set16bit(!MX)
      LDA.B $7E
      BNE .childonedone
      LDA.L $7F1F6C
      ORA.W #$0100                           ;child one age 2
      STA.L $7F1F6C

   .childonedone:
      %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$0008                           ;Child 2
      BEQ .return
      LDA.L !kid2_age
      INC A
      STA.L !kid2_age
      CMP.W #$003C
      BCC .return
      BNE .child2growing
      LDA.L $7F1F6E
      ORA.W #$0010                           ;FLAG6E
      STA.L $7F1F6E
      %Set16bit(!M)
      LDA.W #$0064
      JSL.L AddPlayerHappiness
      BRA .return

      .child2growing:
      %Set16bit(!MX)
      LDA.L !kid2_age
      SEC
      SBC.W #$003C
      STA.B $7E
      LDA.W #$0078
      STA.B $80
      JSL.L DivisionUnsigned
      %Set16bit(!MX)
      LDA.B $7E
      BNE .return
      LDA.L $7F1F6C
      ORA.W #$0200
      STA.L $7F1F6C

   .return: RTL

;;;;;;;
LoadsDateNames: ;8289D6
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.B #$00
      XBA
      LDA.L !season
      %Set16bit(!M)
      ASL A
      ASL A
      ASL A
      ASL A
      TAX
      LDA.L Season_Names_Table,X
      STA.W !season_name
      INX
      INX
      LDA.L Season_Names_Table,X
      STA.W $08B5
      INX
      INX
      LDA.L Season_Names_Table,X
      STA.W $08B7
      INX
      INX
      LDA.L Season_Names_Table,X
      STA.W $08B9
      INX
      INX
      LDA.L Season_Names_Table,X
      STA.W $08BB
      INX
      INX
      LDA.L Season_Names_Table,X
      STA.W $08BD
      %Set8bit(!M)
      LDA.B #$00
      XBA
      LDA.L !weekday
      %Set16bit(!M)
      ASL A
      ASL A
      ASL A
      ASL A
      ASL A
      TAX
      LDA.L Weekday_Names_Table,X
      STA.W !weekday_name
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08C1
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08C3
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08C5
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08C7
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08C9
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08CB
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08CD
      INX
      INX
      LDA.L Weekday_Names_Table,X
      STA.W $08CF
      %Set8bit(!M)
      LDA.B #$00
      XBA
      LDA.L !day
      %Set16bit(!M)
      CMP.W #$0001
      BEQ .day1
      CMP.W #$0002
      BEQ .day2
      CMP.W #$0003
      BEQ .day3
      LDX.W #$000C
      BRA .continue

   .day1:
      %Set16bit(!MX)
      LDX.W #$0000
      BRA .continue

   .day2:
      %Set16bit(!MX)
      LDX.W #$0004
      BRA .continue

   .day3:
      %Set16bit(!MX)
      LDX.W #$0008
      BRA .continue

   .continue:
      %Set16bit(!MX)
      LDA.L Ordinals_Names_Table,X
      STA.W $08D1
      INX
      INX
      LDA.L Ordinals_Names_Table,X
      STA.W $08D3

      RTL


db $69,$01,$CB,$01,$15,$01,$27,$01,$29,$01,$3C,$01,$78,$02,$6C,$01;828AC3;      ;
db $AA,$01,$38,$01,$E4,$00           ;828AD3;      ;

;This is text, it holds the name of the season and spaces
Season_Names_Table: db $2C,$00,$0F,$00,$11,$00,$08,$00,$0D,$00,$06,$00,$00,$00,$00,$00;828AD9
                    db $2C,$00,$14,$00,$0C,$00,$0C,$00,$04,$00,$11,$00,$00,$00,$00,$00;828AE9
                    db $1F,$00,$00,$00,$0B,$00,$0B,$00,$B1,$00,$B1,$00,$00,$00,$00,$00;828AF9
                    db $30,$00,$08,$00,$0D,$00,$13,$00,$04,$00,$11,$00,$00,$00,$00,$00;828B09

;This is text, it holds the name of the season and spaces at the end
Weekday_Names_Table: db $2C,$00,$14,$00,$0D,$00,$03,$00,$00,$00,$18,$00,$B1,$00,$B1,$00;828B19
                     db $B1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828B29
                     db $26,$00,$0E,$00,$0D,$00,$03,$00,$00,$00,$18,$00,$B1,$00,$B1,$00;828B39
                     db $B1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828B49
                     db $2D,$00,$14,$00,$04,$00,$12,$00,$03,$00,$00,$00,$18,$00,$B1,$00;828B59
                     db $B1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828B69
                     db $30,$00,$04,$00,$03,$00,$0D,$00,$04,$00,$12,$00,$03,$00,$00,$00;828B79
                     db $18,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828B89
                     db $2D,$00,$07,$00,$14,$00,$11,$00,$12,$00,$03,$00,$00,$00,$18,$00;828B99
                     db $B1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828BA9
                     db $1F,$00,$11,$00,$08,$00,$03,$00,$00,$00,$18,$00,$B1,$00,$B1,$00;828BB9
                     db $B1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828BC9
                     db $2C,$00,$00,$00,$13,$00,$14,$00,$11,$00,$03,$00,$00,$00,$18,$00;828BD9
                     db $B1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;828BE9

Ordinals_Names_Table: db $12,$00,$13,$00,$0D,$00,$03,$00,$11,$00,$03,$00,$13,$00,$07,$00;828BF9
                                                            ;      ;      ;
          CODE_828C09: %Set16bit(!MX)                             ;828C09;      ;
                       STZ.W $0196                          ;828C0B;000196;
                       %Set8bit(!M)                             ;828C0E;      ;
                       LDA.B #$00                           ;828C10;      ;
                       XBA                                  ;828C12;      ;
                       LDA.W !weather_tomorrow                          ;828C13;00098C;
                       BEQ CODE_828C32                      ;828C16;828C32;
                       CMP.B #$01                           ;828C18;      ;
                       BEQ CODE_828C4B                      ;828C1A;828C4B;
                       CMP.B #$02                           ;828C1C;      ;
                       BEQ CODE_828C72                      ;828C1E;828C72;
                       CMP.B #$03                           ;828C20;      ;
                       BEQ CODE_828C96                      ;828C22;828C96;
                       CMP.B #$04                           ;828C24;      ;
                       BEQ CODE_828CA4                      ;828C26;828CA4;
                       CMP.B #$05                           ;828C28;      ;
                       BNE CODE_828C2F                      ;828C2A;828C2F;
                       JMP.W CODE_828CC8                    ;828C2C;828CC8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_828C2F: JMP.W CODE_828CEC                    ;828C2F;828CEC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_828C32: %Set8bit(!M)                             ;828C32;      ;
                       LDA.L !season                        ;828C34;7F1F19;
                       CMP.B #$01                           ;828C38;      ;
                       BEQ CODE_828C3F                      ;828C3A;828C3F;
                       JMP.W CODE_828CEC                    ;828C3C;828CEC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_828C3F: %Set16bit(!M)                             ;828C3F;      ;
                       LDA.L DATA8_828CED                   ;828C41;828CED;
                       STA.W $0196                          ;828C45;000196;
                       JMP.W CODE_828CEC                    ;828C48;828CEC;
                                                            ;      ;      ;
          CODE_828C4B: %Set8bit(!M)                             ;828C4B;      ;
                       LDA.L !season                        ;828C4D;7F1F19;
                       CMP.B #$03                           ;828C51;      ;
                       BNE CODE_828C64                      ;828C53;828C64;
                       %Set16bit(!M)                             ;828C55;      ;
                       LDX.W #$0004                         ;828C57;      ;
                       LDA.L DATA8_828CED,X                 ;828C5A;828CED;
                       STA.W $0196                          ;828C5E;000196;
                       JMP.W CODE_828CEC                    ;828C61;828CEC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_828C64: %Set16bit(!M)                             ;828C64;      ;
                       LDX.W #$0002                         ;828C66;      ;
                       LDA.L DATA8_828CED,X                 ;828C69;828CED;
                       STA.W $0196                          ;828C6D;000196;
                       BRA CODE_828CEC                      ;828C70;828CEC;
                                                            ;      ;      ;
          CODE_828C72: %Set8bit(!M)                             ;828C72;      ;
                       LDA.L !season                        ;828C74;7F1F19;
                       BNE CODE_828C88                      ;828C78;828C88;
                       LDX.W #$0002                         ;828C7A;      ;
                       %Set16bit(!M)                             ;828C7D;      ;
                       LDA.L DATA8_828CED,X                 ;828C7F;828CED;
                       STA.W $0196                          ;828C83;000196;
                       BRA CODE_828CEC                      ;828C86;828CEC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_828C88: %Set16bit(!M)                             ;828C88;      ;
                       LDX.W #$0004                         ;828C8A;      ;
                       LDA.L DATA8_828CED,X                 ;828C8D;828CED;
                       STA.W $0196                          ;828C91;000196;
                       BRA CODE_828CEC                      ;828C94;828CEC;
                                                            ;      ;      ;
          CODE_828C96: %Set16bit(!M)                             ;828C96;      ;
                       LDX.W #$0006                         ;828C98;      ;
                       LDA.L DATA8_828CED,X                 ;828C9B;828CED;
                       STA.W $0196                          ;828C9F;000196;
                       BRA CODE_828CEC                      ;828CA2;828CEC;
                                                            ;      ;      ;
          CODE_828CA4: %Set16bit(!M)                             ;828CA4;      ;
                       LDX.W #$0008                         ;828CA6;      ;
                       LDA.L DATA8_828CED,X                 ;828CA9;828CED;
                       STA.W $0196                          ;828CAD;000196;
                       LDA.L $7F1F64                        ;828CB0;7F1F64;
                       ORA.W #$0002                         ;828CB4;      ;
                       STA.L $7F1F64                        ;828CB7;7F1F64;
                       LDA.L $7F1F6E                        ;828CBB;7F1F6E;
                       ORA.W #$0100                         ;828CBF;      ;
                       STA.L $7F1F6E                        ;828CC2;7F1F6E;
                       BRA CODE_828CEC                      ;828CC6;828CEC;
                                                            ;      ;      ;
          CODE_828CC8: %Set16bit(!M)                             ;828CC8;      ;
                       LDX.W #$000A                         ;828CCA;      ;
                       LDA.L DATA8_828CED,X                 ;828CCD;828CED;
                       STA.W $0196                          ;828CD1;000196;
                       LDA.L $7F1F64                        ;828CD4;7F1F64;
                       ORA.W #$0001                         ;828CD8;      ;
                       STA.L $7F1F64                        ;828CDB;7F1F64;
                       LDA.L $7F1F6E                        ;828CDF;7F1F6E;
                       ORA.W #$0080                         ;828CE3;      ;
                       STA.L $7F1F6E                        ;828CE6;7F1F6E;
                       BRA CODE_828CEC                      ;828CEA;828CEC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_828CEC: RTL                                  ;828CEC;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_828CED: db $04,$00,$02,$00,$08,$00,$10,$00,$00,$02,$00,$01;828CED;      ;

;;;;;;; Set weather for tomorrow TODO, give it a second pass
WeatherTomorrow: ;828CF9
       %Set8bit(!M)
       %Set16bit(!X)
       LDA.L !season
       BNE .notspring
       LDA.L !day
       CMP.B #22
       BEQ .flowerfestival
       JMP.W .normalday

    .flowerfestival:
       %Set8bit(!M)
       LDA.B #$06                            ;flower festival climate
       STA.W !weather_tomorrow
       JMP.W .return

    .notspring:
       %Set8bit(!M)
       LDA.L !season
       CMP.B #$02
       BNE .notfall
       LDA.L !day
       CMP.B #11
       BNE .notharvestfestival
       %Set8bit(!M)
       LDA.B #$07                            ;harvest festival climate
       STA.W !weather_tomorrow
       JMP.W .return

    .notharvestfestival:
       %Set8bit(!M)
       LDA.L !day
       CMP.B #19
       BEQ .eggfestival
       JMP.W .normalday

     .eggfestival:
       %Set8bit(!M)
       LDA.B #$0B                            ;egg festival
       STA.W !weather_tomorrow
       JMP.W .return

    .notfall:
       %Set8bit(!M)
       LDA.L !season
       CMP.B #$03
       BEQ .iswinter
       JMP.W .thunder

    .iswinter:
       LDA.L !day
       CMP.B #9
       BNE .notthanksgiving
       %Set8bit(!M)
       LDA.B #$08                            ;Thanksgiving Climate
       STA.W !weather_tomorrow
       JMP.W .return

    .notthanksgiving:
       %Set8bit(!M)
       LDA.L !day
       CMP.B #23
       BNE .notstarnight
       %Set8bit(!M)
       LDA.B #$09                            ;Star Night Festival Climate
       STA.W !weather_tomorrow
       JMP.W .return

    .notstarnight:
       %Set8bit(!M)
       LDA.L !day
       CMP.B #30
       BNE .notwinter
       %Set8bit(!M)
       LDA.B #$0A                            ;new years festival climate
       STA.W !weather_tomorrow
       JMP.W .return

    .notwinter:
       %Set8bit(!M)
       LDA.L !year
       BEQ .specialcase                      ;Year 1
       JMP.W .normalday

    .specialcase:
       %Set16bit(!M)
       LDA.L $7F1F64
       AND.W #$0002                          ;FLAG64
       BEQ .specialdays
       JMP.W .normalday

    .specialdays:
       %Set8bit(!M)
       LDA.L !day
       CMP.B #$07
       BEQ .fairclimate
       LDA.B #$00
       XBA
       LDA.L !season
       %Set16bit(!M)
       TAX
       %Set8bit(!M)
       LDA.L Snowstorm_Chance_Table,X
       BNE .snowstorm
       JMP.W .normalday

    .snowstorm:
       JSL.L RNGReturn0toA
       %Set8bit(!M)
       BEQ .fairclimate
       JMP.W .normalday

    .fairclimate:
       %Set8bit(!M)
       LDA.B #$04
       STA.W !weather_tomorrow
       JMP.W .return

    .thunder:
       %Set8bit(!M)
       LDA.L !year
       BNE .nothunder                     ;Year after first
       %Set16bit(!M)
       LDA.L $7F1F64
       AND.W #$0001                       ;FLAG64
       BNE .nothunder
       %Set8bit(!M)
       LDA.L !day
       CMP.B #29
       BEQ .CODE_828E16
       LDA.B #$00
       XBA
       LDA.L !season
       %Set16bit(!M)
       TAX
       %Set8bit(!M)
       LDA.L Thunder_Chance_Table,X
       BEQ .nothunder
       JSL.L RNGReturn0toA
       %Set8bit(!M)
       BNE .nothunder

       .CODE_828E16: %Set8bit(!M)
       LDA.B #$05
       STA.W !weather_tomorrow
       JMP.W .return

       .nothunder:
       %Set8bit(!M)
       LDA.L !day
       CMP.B #30                            ;not last day
       BEQ .normalday
       %Set8bit(!M)
       LDA.B #$00
       XBA
       LDA.L !season
       %Set16bit(!M)
       TAX
       %Set8bit(!M)
       LDA.B #$00
       XBA
       LDA.L Hurricane_Chance_Table,X
       BEQ .normalday
       %Set16bit(!MX)
       TAY
       LDA.L $7F1F6C
       AND.W #$1000                          ;Turtle Shell
       BEQ .ohohhurracane
       TYA
       ASL A                                 ;Transfering Ys carry flag?
       TAY

    .ohohhurracane:
       %Set16bit(!MX)
       TYA
       %Set8bit(!M)
       JSL.L RNGReturn0toA
       %Set8bit(!M)
       BNE .normalday
       LDA.B #$03                            ;Hurracane
       STA.W !weather_tomorrow
       BRA .return

    .normalday:
       %Set8bit(!M)
       LDA.B #$00
       XBA
       LDA.L !season
       %Set16bit(!M)
       TAX
       %Set8bit(!M)
       LDA.L Rain_Chance_Table,X
       BEQ .norain
       JSL.L RNGReturn0toA
       %Set8bit(!M)
       BNE .norain
       LDA.B #$01
       STA.W !weather_tomorrow
       BRA .return

    .norain:
       %Set8bit(!M)
       LDA.B #$00
       XBA
       LDA.L !season
       %Set16bit(!M)
       TAX
       %Set8bit(!M)
       LDA.L Snow_Chance_Table,X
       BEQ .sunnyday
       JSL.L RNGReturn0toA
       %Set8bit(!M)
       BNE .sunnyday
       LDA.B #$02
       STA.W !weather_tomorrow
       BRA .return

       .sunnyday: %Set8bit(!M)
       LDA.B #$00
       STA.W !weather_tomorrow

       .return: RTL

Hurricane_Chance_Table: db $00,$1E,$00,$00 ;828EB2
Rain_Chance_Table:      db $06,$0A,$0A,$00 ;828EB6
Snow_Chance_Table:      db $00,$00,$00,$03 ;828EBA
Thunder_Chance_Table:   db $00,$1E,$00,$00 ;828EBE
Snowstorm_Chance_Table: db $00,$00,$00,$08 ;828EC2


;;;;;;; This is called a couple of times, but data is not read?
FindMostLovedName: ;828EC6
       %Set16bit(!MX)
       LDY.W #$0000
       LDA.L !hearts_maria
       STA.B $7E
       LDX.W #$0002

    .loop:
       %Set16bit(!MX)
       LDA.L !hearts_maria,X
       CMP.B $7E
       BCS .morelove
       BRA .findnext

    .morelove:
       %Set16bit(!MX)
       STA.B $7E
       TXA
       LSR A
       TAY

    .findnext:
       %Set16bit(!MX)
       INX
       INX
       CPX.W #$000A
       BNE .loop
       CPY.W #$0000
       BEQ .ifMaria
       CPY.W #$0001
       BEQ .ifNina
       CPY.W #$0002
       BEQ .ifAnn
       CPY.W #$0003
       BEQ .ifEllen
       CPY.W #$0004
       BNE .ifMaria                         ;BUG, Maria works like an else
       JMP.W .ifEve

    .ifMaria:
       %Set16bit(!MX)                        ;Writes her name
       LDA.W #$0026
       STA.W !most_hearts_girl_name_1
       LDA.W #$0000
       STA.W !most_hearts_girl_name_2
       LDA.W #$0011
       STA.W !most_hearts_girl_name_3
       LDA.W #$0008
       STA.W !most_hearts_girl_name_4
       LDA.W #$0000
       STA.W !most_hearts_girl_name_5
       RTL

    .ifNina:
       %Set16bit(!MX)
       LDA.W #$001A
       STA.W !most_hearts_girl_name_1
       LDA.W #$000D
       STA.W !most_hearts_girl_name_2
       LDA.W #$000D
       STA.W !most_hearts_girl_name_3
       LDA.W #$00B1
       STA.W !most_hearts_girl_name_4
       LDA.W #$00B1
       STA.W !most_hearts_girl_name_5
       RTL

    .ifAnn:
       %Set16bit(!MX)
       LDA.W #$0027
       STA.W !most_hearts_girl_name_1
       LDA.W #$0008
       STA.W !most_hearts_girl_name_2
       LDA.W #$000D
       STA.W !most_hearts_girl_name_3
       LDA.W #$0000
       STA.W !most_hearts_girl_name_4
       LDA.W #$00B1
       STA.W !most_hearts_girl_name_5
       RTL

    .ifEllen:
       %Set16bit(!MX)
       LDA.W #$001E
       STA.W !most_hearts_girl_name_1
       LDA.W #$000B
       STA.W !most_hearts_girl_name_2
       LDA.W #$000B
       STA.W !most_hearts_girl_name_3
       LDA.W #$0004
       STA.W !most_hearts_girl_name_4
       LDA.W #$000D
       STA.W !most_hearts_girl_name_5
       RTL

    .ifEve:
       %Set16bit(!MX)
       LDA.W #$001E
       STA.W !most_hearts_girl_name_1
       LDA.W #$0015
       STA.W !most_hearts_girl_name_2
       LDA.W #$0004
       STA.W !most_hearts_girl_name_3
       LDA.W #$00B1
       STA.W !most_hearts_girl_name_4
       LDA.W #$00B1
       STA.W !most_hearts_girl_name_5
       RTL

;;;;;;;
                AFFFF: %Set8bit(!M)                             ;828FB1;      ;
                       LDA.B #$00                           ;828FB3;      ;
                       XBA                                  ;828FB5;      ;
                       LDA.W $0922                          ;828FB6;000922;
                       CMP.B #$02                           ;828FB9;      ;
                       BEQ CODE_828FF2                      ;828FBB;828FF2;
                       %Set16bit(!M)                             ;828FBD;      ;
                       STA.B $80                            ;828FBF;000080;
                       %Set8bit(!M)                             ;828FC1;      ;
                       LDA.B #$00                           ;828FC3;      ;
                       XBA                                  ;828FC5;      ;
                       LDA.W !tool_selected                          ;828FC6;000921;
                       %Set16bit(!M)                             ;828FC9;      ;
                       STA.B $7E                            ;828FCB;00007E;
                       ASL A                                ;828FCD;      ;
                       CLC                                  ;828FCE;      ;
                       ADC.B $7E                            ;828FCF;00007E;
                       TAX                                  ;828FD1;      ;
                       %Set8bit(!M)                             ;828FD2;      ;
                       LDA.L DATA8_829054,X                 ;828FD4;829054;
                       STA.W $0115                          ;828FD8;000115;
                       INX                                  ;828FDB;      ;
                       %Set16bit(!M)                             ;828FDC;      ;
                       TXA                                  ;828FDE;      ;
                       CLC                                  ;828FDF;      ;
                       ADC.B $80                            ;828FE0;000080;
                       TAX                                  ;828FE2;      ;
                       %Set8bit(!M)                             ;828FE3;      ;
                       LDA.L DATA8_829054,X                 ;828FE5;829054;
                       BEQ CODE_828FF2                      ;828FE9;828FF2;
                       STA.W $0114                          ;828FEB;000114;
                       JSL.L UNK_Audio19                    ;828FEE;838332;
                                                            ;      ;      ;
          CODE_828FF2: RTL                                  ;828FF2;      ;END_AFFFF
                                                            ;      ;      ;
                                                            ;      ;      ;
                AEEEE: %Set8bit(!M)                             ;828FF3;      ;
                       LDA.B #$00                           ;828FF5;      ;
                       XBA                                  ;828FF7;      ;
                       LDA.W !tool_selected                          ;828FF8;000921;
                       CMP.W $0119                          ;828FFB;000119;
                       BEQ CODE_82904B                      ;828FFE;82904B;
                       %Set16bit(!M)                             ;829000;      ;
                       STA.B $7E                            ;829002;00007E;
                       ASL A                                ;829004;      ;
                       CLC                                  ;829005;      ;
                       ADC.B $7E                            ;829006;00007E;
                       TAX                                  ;829008;      ;
                       %Set8bit(!M)                             ;829009;      ;
                       LDA.L DATA8_829054,X                 ;82900B;829054;
                       BEQ CODE_82904B                      ;82900F;82904B;
                       STA.W $0115                          ;829011;000115;
                       INX                                  ;829014;      ;
                       PHX                                  ;829015;      ;
                       LDA.L DATA8_829054,X                 ;829016;829054;
                       BEQ CODE_829038                      ;82901A;829038;
                       STA.W $0114                          ;82901C;000114;
                       %Set8bit(!M)                             ;82901F;      ;
                       LDA.B #$00                           ;829021;      ;
                       XBA                                  ;829023;      ;
                       LDA.W $0118                          ;829024;000118;
                       %Set16bit(!M)                             ;829027;      ;
                       TAX                                  ;829029;      ;
                       %Set8bit(!M)                             ;82902A;      ;
                       LDA.L UNK_AudioTable,X               ;82902C;80B8CD;
                       INC A                                ;829030;      ;
                       STA.W $0103                          ;829031;000103;
                       JSL.L UNK_Audio18                    ;829034;83833E;
                                                            ;      ;      ;
          CODE_829038: %Set8bit(!M)                             ;829038;      ;
                       %Set16bit(!X)                             ;82903A;      ;
                       PLX                                  ;82903C;      ;
                       INX                                  ;82903D;      ;
                       LDA.L DATA8_829054,X                 ;82903E;829054;
                       BEQ CODE_82904B                      ;829042;82904B;
                       STA.W $0114                          ;829044;000114;
                       JSL.L UNK_Audio18                    ;829047;83833E;
                                                            ;      ;      ;
          CODE_82904B: %Set8bit(!M)                             ;82904B;      ;
                       LDA.W !tool_selected                          ;82904D;000921;
                       STA.W $0119                          ;829050;000119;
                       RTL                                  ;829053;      ;END_AEEEE
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_829054: db $00,$00,$00,$06,$14,$12,$06,$11,$0F,$06,$17,$17,$06,$11,$15,$06;829054;      ;
                       db $1B,$1B,$06,$1B,$1B,$06,$1B,$1B,$06,$1B,$1B,$06,$00,$00,$06,$00;829064;      ;
                       db $00,$06,$00,$19,$06,$1B,$1B,$06,$00,$00,$06,$00,$00,$06,$00,$00;829074;      ;
                       db $07,$28,$28,$06,$14,$13,$06,$11,$10,$06,$18,$18,$06,$11,$16,$07;829084;      ;
                       db $28,$28,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;829094;      ;
                       db $00,$00,$00,$00                   ;8290A4;      ;
                                                            ;      ;      ;
          ToolUsed: %Set8bit(!M)                             ;8290A8;      ;
                       %Set16bit(!X)                             ;8290AA;      ;
                       %Set16bit(!MX)                             ;8290AC;      ;
                       LDA.B !game_state                            ;8290AE;0000D2;
                       AND.W #$0008                         ;8290B0;      ;
                       BEQ CODE_8290B8                      ;8290B3;8290B8;
                       JMP.W CODE_8290CD                    ;8290B5;8290CD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8290B8: JSR.W CODE_82927D                    ;8290B8;82927D;
                       %Set8bit(!M)                             ;8290BB;      ;
                       STZ.W $091B                          ;8290BD;00091B;
                       LDA.B #$00                           ;8290C0;      ;
                       XBA                                  ;8290C2;      ;
                       LDA.W !tool_selected                          ;8290C3;000921;
                       ASL A                                ;8290C6;      ;
                       TAX                                  ;8290C7;      ;
                       JSR.W (DATA16_82A58B,X)              ;8290C8;82A58B;
                       BRA CODE_8290DC                      ;8290CB;8290DC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8290CD: %Set16bit(!M)                             ;8290CD;      ;
                       LDA.W #$004D                         ;8290CF;      ;
                       STA.W $0901                          ;8290D2;000901;
                       %Set16bit(!MX)                             ;8290D5;      ;
                       LDA.W #$000B                         ;8290D7;      ;
                       STA.B !player_action                            ;8290DA;0000D4;
                                                            ;      ;      ;
          CODE_8290DC: RTL                                  ;8290DC;      ;
                                                            ;      ;      ;
                       RTS                                  ;8290DD;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8290DE;      ;
                       %Set16bit(!MX)                             ;8290E0;      ;
                       LDA.W #$0050                         ;8290E2;      ;
                       CLC                                  ;8290E5;      ;
                       ADC.B !player_direction                            ;8290E6;0000DA;
                       STA.W $0901                          ;8290E8;000901;
                       RTS                                  ;8290EB;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8290EC;      ;
                       %Set16bit(!MX)                             ;8290EE;      ;
                       LDA.W #$0054                         ;8290F0;      ;
                       CLC                                  ;8290F3;      ;
                       ADC.B !player_direction                            ;8290F4;0000DA;
                       STA.W $0901                          ;8290F6;000901;
                       RTS                                  ;8290F9;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8290FA;      ;
                       %Set16bit(!MX)                             ;8290FC;      ;
                       LDA.W #$0058                         ;8290FE;      ;
                       CLC                                  ;829101;      ;
                       ADC.B !player_direction                            ;829102;0000DA;
                       STA.W $0901                          ;829104;000901;
                       RTS                                  ;829107;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829108;      ;
                       %Set16bit(!MX)                             ;82910A;      ;
                       LDA.W #$005C                         ;82910C;      ;
                       CLC                                  ;82910F;      ;
                       ADC.B !player_direction                            ;829110;0000DA;
                       STA.W $0901                          ;829112;000901;
                       RTS                                  ;829115;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829116;      ;
                       %Set16bit(!MX)                             ;829118;      ;
                       LDA.W #$0046                         ;82911A;      ;
                       STA.W $0901                          ;82911D;000901;
                       RTS                                  ;829120;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829121;      ;
                       %Set16bit(!MX)                             ;829123;      ;
                       LDA.W #$0046                         ;829125;      ;
                       STA.W $0901                          ;829128;000901;
                       RTS                                  ;82912B;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82912C;      ;
                       %Set16bit(!MX)                             ;82912E;      ;
                       LDA.W #$0046                         ;829130;      ;
                       STA.W $0901                          ;829133;000901;
                       RTS                                  ;829136;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829137;      ;
                       %Set16bit(!MX)                             ;829139;      ;
                       LDA.W #$0046                         ;82913B;      ;
                       STA.W $0901                          ;82913E;000901;
                       RTS                                  ;829141;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829142;      ;
                       %Set16bit(!MX)                             ;829144;      ;
                       LDA.W #$00AC                         ;829146;      ;
                       CLC                                  ;829149;      ;
                       ADC.B !player_direction                            ;82914A;0000DA;
                       STA.W $0901                          ;82914C;000901;
                       RTS                                  ;82914F;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829150;      ;
                       %Set16bit(!MX)                             ;829152;      ;
                       LDA.W #$00AC                         ;829154;      ;
                       CLC                                  ;829157;      ;
                       ADC.B !player_direction                            ;829158;0000DA;
                       STA.W $0901                          ;82915A;000901;
                       RTS                                  ;82915D;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82915E;      ;
                       %Set16bit(!MX)                             ;829160;      ;
                       LDA.W #$0060                         ;829162;      ;
                       CLC                                  ;829165;      ;
                       ADC.B !player_direction                            ;829166;0000DA;
                       STA.W $0901                          ;829168;000901;
                       %Set16bit(!M)                             ;82916B;      ;
                       LDA.L $7F1F5A                        ;82916D;7F1F5A;
                       ORA.W #$0010                         ;829171;      ;
                       STA.L $7F1F5A                        ;829174;7F1F5A;
                       RTS                                  ;829178;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829179;      ;
                       %Set16bit(!MX)                             ;82917B;      ;
                       LDA.W #$0046                         ;82917D;      ;
                       STA.W $0901                          ;829180;000901;
                       RTS                                  ;829183;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829184;      ;
                       LDA.W #$0044                         ;829186;      ;
                       STA.W $0901                          ;829189;000901;
                       RTS                                  ;82918C;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82918D;      ;
                       %Set16bit(!MX)                             ;82918F;      ;
                       LDA.W #$0078                         ;829191;      ;
                       CLC                                  ;829194;      ;
                       ADC.B !player_direction                            ;829195;0000DA;
                       STA.W $0901                          ;829197;000901;
                       RTS                                  ;82919A;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82919B;      ;
                       %Set16bit(!MX)                             ;82919D;      ;
                       LDA.W #$0064                         ;82919F;      ;
                       CLC                                  ;8291A2;      ;
                       ADC.B !player_direction                            ;8291A3;0000DA;
                       STA.W $0901                          ;8291A5;000901;
                       RTS                                  ;8291A8;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;8291A9;      ;
                       %Set16bit(!X)                             ;8291AB;      ;
                       JSR.W CODE_8292A0                    ;8291AD;8292A0;
                       %Set8bit(!M)                             ;8291B0;      ;
                       CMP.B #$02                           ;8291B2;      ;
                       BEQ CODE_8291D5                      ;8291B4;8291D5;
                       LDA.W !sprinkler_water                          ;8291B6;000926;
                       BEQ CODE_8291C8                      ;8291B9;8291C8;
                       %Set16bit(!MX)                             ;8291BB;      ;
                       LDA.W #$0068                         ;8291BD;      ;
                       CLC                                  ;8291C0;      ;
                       ADC.B !player_direction                            ;8291C1;0000DA;
                       STA.W $0901                          ;8291C3;000901;
                       BRA CODE_8291E7                      ;8291C6;8291E7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8291C8: %Set16bit(!MX)                             ;8291C8;      ;
                       LDA.W #$006C                         ;8291CA;      ;
                       CLC                                  ;8291CD;      ;
                       ADC.B !player_direction                            ;8291CE;0000DA;
                       STA.W $0901                          ;8291D0;000901;
                       BRA CODE_8291E7                      ;8291D3;8291E7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8291D5: %Set16bit(!MX)                             ;8291D5;      ;
                       LDA.W #$0070                         ;8291D7;      ;
                       CLC                                  ;8291DA;      ;
                       ADC.B !player_direction                            ;8291DB;0000DA;
                       STA.W $0901                          ;8291DD;000901;
                       %Set8bit(!M)                             ;8291E0;      ;
                       LDA.B #$14                           ;8291E2;      ;
                       STA.W !sprinkler_water                          ;8291E4;000926;
                                                            ;      ;      ;
          CODE_8291E7: RTS                                  ;8291E7;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8291E8;      ;
                       LDA.W #$0048                         ;8291EA;      ;
                       STA.W $0901                          ;8291ED;000901;
                       RTS                                  ;8291F0;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8291F1;      ;
                       LDA.W #$007C                         ;8291F3;      ;
                       CLC                                  ;8291F6;      ;
                       ADC.B !player_direction                            ;8291F7;0000DA;
                       STA.W $0901                          ;8291F9;000901;
                       RTS                                  ;8291FC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8291FD;      ;
                       LDA.W #$0084                         ;8291FF;      ;
                       CLC                                  ;829202;      ;
                       ADC.B !player_direction                            ;829203;0000DA;
                       STA.W $0901                          ;829205;000901;
                       RTS                                  ;829208;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829209;      ;
                       LDA.W #$0080                         ;82920B;      ;
                       CLC                                  ;82920E;      ;
                       ADC.B !player_direction                            ;82920F;0000DA;
                       STA.W $0901                          ;829211;000901;
                       RTS                                  ;829214;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829215;      ;
                       LDA.W #$0047                         ;829217;      ;
                       STA.W $0901                          ;82921A;000901;
                       RTS                                  ;82921D;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82921E;      ;
                       LDA.W #$00AC                         ;829220;      ;
                       CLC                                  ;829223;      ;
                       ADC.B !player_direction                            ;829224;0000DA;
                       STA.W $0901                          ;829226;000901;
                       RTS                                  ;829229;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82922A;      ;
                       LDA.W #$00AC                         ;82922C;      ;
                       CLC                                  ;82922F;      ;
                       ADC.B !player_direction                            ;829230;0000DA;
                       STA.W $0901                          ;829232;000901;
                       RTS                                  ;829235;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829236;      ;
                       LDA.W #$00A8                         ;829238;      ;
                       STA.W $0901                          ;82923B;000901;
                       RTS                                  ;82923E;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82923F;      ;
                       LDA.W #$0074                         ;829241;      ;
                       CLC                                  ;829244;      ;
                       ADC.B !player_direction                            ;829245;0000DA;
                       STA.W $0901                          ;829247;000901;
                       RTS                                  ;82924A;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82924B;      ;
                       LDA.W #$0074                         ;82924D;      ;
                       CLC                                  ;829250;      ;
                       ADC.B !player_direction                            ;829251;0000DA;
                       STA.W $0901                          ;829253;000901;
                       RTS                                  ;829256;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829257;      ;
                       LDA.W #$0088                         ;829259;      ;
                       STA.W $0901                          ;82925C;000901;
                       RTS                                  ;82925F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829260: %Set8bit(!M)                             ;829260;      ;
                       %Set16bit(!X)                             ;829262;      ;
                       LDA.B #$00                           ;829264;      ;
                       XBA                                  ;829266;      ;
                       LDA.W !tool_selected                          ;829267;000921;
                       ASL A                                ;82926A;      ;
                       TAX                                  ;82926B;      ;
                       JSR.W (DATA16_82A5C3,X)              ;82926C;82A5C3;
                       %Set16bit(!M)                             ;82926F;      ;
                       LDA.L $7F1F5A                        ;829271;7F1F5A;
                       ORA.W #$0040                         ;829275;      ;
                       STA.L $7F1F5A                        ;829278;7F1F5A;
                       RTL                                  ;82927C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82927D: %Set16bit(!MX)                             ;82927D;      ;
                       LDA.W #$0001                         ;82927F;      ;
                       LDX.W #$0000                         ;829282;      ;
                       LDY.W #$0000                         ;829285;      ;
                       JSL.L CODE_81D14E                    ;829288;81D14E;
                       %Set16bit(!M)                             ;82928C;      ;
                       LDX.W $0985                          ;82928E;000985;
                       LDY.W $0987                          ;829291;000987;
                       JSL.L CMMMM                          ;829294;82AA71;
                       %Set8bit(!M)                             ;829298;      ;
                       %Set16bit(!X)                             ;82929A;      ;
                       STA.W $0922                          ;82929C;000922;
                       RTS                                  ;82929F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8292A0: %Set16bit(!MX)                             ;8292A0;      ;
                       LDA.W #$0001                         ;8292A2;      ;
                       LDX.W #$0000                         ;8292A5;      ;
                       LDY.W #$0000                         ;8292A8;      ;
                       JSL.L CODE_81D14E                    ;8292AB;81D14E;
                       %Set16bit(!M)                             ;8292AF;      ;
                       LDX.W $0985                          ;8292B1;000985;
                       LDY.W $0987                          ;8292B4;000987;
                       JSL.L CMMMM                          ;8292B7;82AA71;
                       RTS                                  ;8292BB;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8292BC: %Set16bit(!MX)                             ;8292BC;      ;
                       INC A                                ;8292BE;      ;
                       LDX.W #$0000                         ;8292BF;      ;
                       LDY.W #$0000                         ;8292C2;      ;
                       JSL.L CODE_81D14E                    ;8292C5;81D14E;
                       %Set16bit(!M)                             ;8292C9;      ;
                       LDX.W $0985                          ;8292CB;000985;
                       LDY.W $0987                          ;8292CE;000987;
                       JSL.L CMMMM                          ;8292D1;82AA71;
                       RTS                                  ;8292D5;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8292D6: %Set16bit(!MX)                             ;8292D6;      ;
                       ASL A                                ;8292D8;      ;
                       ASL A                                ;8292D9;      ;
                       TAX                                  ;8292DA;      ;
                       LDA.L DATA8_8292FA,X                 ;8292DB;8292FA;
                       PHA                                  ;8292DF;      ;
                       INX                                  ;8292E0;      ;
                       INX                                  ;8292E1;      ;
                       LDA.L DATA8_8292FA,X                 ;8292E2;8292FA;
                       TAY                                  ;8292E6;      ;
                       PLA                                  ;8292E7;      ;
                       TAX                                  ;8292E8;      ;
                       JSL.L CODE_81D1A4                    ;8292E9;81D1A4;
                       %Set16bit(!M)                             ;8292ED;      ;
                       LDX.W $0985                          ;8292EF;000985;
                       LDY.W $0987                          ;8292F2;000987;
                       JSL.L CMMMM                          ;8292F5;82AA71;
                       RTS                                  ;8292F9;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_8292FA: db $00,$00,$00,$00,$00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$00,$00;8292FA;      ;
                       db $01,$00,$FF,$FF,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00,$00;82930A;      ;
                       db $FF,$FF,$01,$00,$C2,$30           ;82931A;      ;
                       %Set16bit(!MX)                             ;829320;      ;
                       LDA.W #$0000                         ;829322;      ;
                       STA.B !player_action                            ;829325;0000D4;
                       RTS                                  ;829327;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829328;      ;
                       JSR.W CODE_8292A0                    ;82932A;8292A0;
                       BNE CODE_829332                      ;82932D;829332;
                       JMP.W CODE_829450                    ;82932F;829450;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829332: %Set8bit(!M)                             ;829332;      ;
                       LDA.L !season                        ;829334;7F1F19;
                       CMP.B #$03                           ;829338;      ;
                       BNE CODE_82933F                      ;82933A;82933F;
                       JMP.W CODE_829450                    ;82933C;829450;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82933F: LDA.B !tilemap_to_load                            ;82933F;000022;
                       CMP.B #$04                           ;829341;      ;
                       BCC CODE_82935A                      ;829343;82935A;
                       %Set16bit(!M)                             ;829345;      ;
                       CPX.W #$0035                         ;829347;      ;
                       BEQ CODE_829352                      ;82934A;829352;
                       LDA.W #$00DD                         ;82934C;      ;
                       JMP.W CODE_8293C8                    ;82934F;8293C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829352: %Set16bit(!M)                             ;829352;      ;
                       LDA.W #$00DE                         ;829354;      ;
                       JMP.W CODE_8293C8                    ;829357;8293C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82935A: %Set16bit(!M)                             ;82935A;      ;
                       CPX.W #$0003                         ;82935C;      ;
                       BEQ CODE_82936C                      ;82935F;82936C;
                       CPX.W #$0079                         ;829361;      ;
                       BEQ CODE_829374                      ;829364;829374;
                       LDA.W #$0017                         ;829366;      ;
                       JMP.W CODE_8293C8                    ;829369;8293C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82936C: %Set16bit(!M)                             ;82936C;      ;
                       LDA.W #$000E                         ;82936E;      ;
                       JMP.W CODE_8293C8                    ;829371;8293C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829374: %Set16bit(!M)                             ;829374;      ;
                       LDA.W #$0001                         ;829376;      ;
                       JSL.L AddGrass                       ;829379;83B253;
                       %Set16bit(!M)                             ;82937D;      ;
                       LDA.W $092E                          ;82937F;00092E;
                       DEC A                                ;829382;      ;
                       STA.W $092E                          ;829383;00092E;
                       %Set16bit(!M)                             ;829386;      ;
                       LDA.W #$0052                         ;829388;      ;
                       LDX.W $0985                          ;82938B;000985;
                       LDY.W $0987                          ;82938E;000987;
                       JSL.L CODE_81A688                    ;829391;81A688;
                       %Set16bit(!M)                             ;829395;      ;
                       LDA.W $0985                          ;829397;000985;
                       STA.W $0980                          ;82939A;000980;
                       LDA.W $0987                          ;82939D;000987;
                       STA.W $0982                          ;8293A0;000982;
                       %Set16bit(!MX)                             ;8293A3;      ;
                       LDA.W #$00C1                         ;8293A5;      ;
                       STA.W $097A                          ;8293A8;00097A;
                       LDA.W #$0000                         ;8293AB;      ;
                       STA.W $097E                          ;8293AE;00097E;
                       %Set8bit(!M)                             ;8293B1;      ;
                       LDA.B #$03                           ;8293B3;      ;
                       STA.W $0974                          ;8293B5;000974;
                       LDA.B #$00                           ;8293B8;      ;
                       STA.W $0975                          ;8293BA;000975;
                       LDA.B #$00                           ;8293BD;      ;
                       STA.W $0976                          ;8293BF;000976;
                       JSL.L CODE_81A500                    ;8293C2;81A500;
                       BRA CODE_829403                      ;8293C6;829403;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8293C8: LDX.W $0985                          ;8293C8;000985;
                       LDY.W $0987                          ;8293CB;000987;
                       JSL.L CODE_81A688                    ;8293CE;81A688;
                       %Set16bit(!M)                             ;8293D2;      ;
                       LDA.W $0985                          ;8293D4;000985;
                       STA.W $0980                          ;8293D7;000980;
                       LDA.W $0987                          ;8293DA;000987;
                       STA.W $0982                          ;8293DD;000982;
                       %Set16bit(!MX)                             ;8293E0;      ;
                       LDA.W #$00B7                         ;8293E2;      ;
                       STA.W $097A                          ;8293E5;00097A;
                       LDA.W #$0000                         ;8293E8;      ;
                       STA.W $097E                          ;8293EB;00097E;
                       %Set8bit(!M)                             ;8293EE;      ;
                       LDA.B #$03                           ;8293F0;      ;
                       STA.W $0974                          ;8293F2;000974;
                       LDA.B #$00                           ;8293F5;      ;
                       STA.W $0975                          ;8293F7;000975;
                       LDA.B #$00                           ;8293FA;      ;
                       STA.W $0976                          ;8293FC;000976;
                       JSL.L CODE_81A500                    ;8293FF;81A500;
                                                            ;      ;      ;
          CODE_829403: %Set8bit(!M)                             ;829403;      ;
                       LDA.L !season                        ;829405;7F1F19;
                       CMP.B #$01                           ;829409;      ;
                       BNE CODE_829450                      ;82940B;829450;
                       %Set16bit(!M)                             ;82940D;      ;
                       LDA.L $7F1F60                        ;82940F;7F1F60;
                       AND.W #$0008                         ;829413;      ;
                       BNE CODE_829450                      ;829416;829450;
                       LDA.L $7F1F5A                        ;829418;7F1F5A;
                       AND.W #$2000                         ;82941C;      ;
                       BNE CODE_829450                      ;82941F;829450;
                       %Set8bit(!M)                             ;829421;      ;
                       LDA.B #$10                           ;829423;      ;
                       JSL.L RNGReturn0toA                  ;829425;8089F9;
                       BNE CODE_829450                      ;829429;829450;
                       %Set16bit(!MX)                             ;82942B;      ;
                       LDA.W #$0012                         ;82942D;      ;
                       LDX.W #$0000                         ;829430;      ;
                       LDY.W #$0032                         ;829433;      ;
                       JSL.L CODE_8480F8                    ;829436;8480F8;
                       %Set16bit(!MX)                             ;82943A;      ;
                       LDA.W #$0002                         ;82943C;      ;
                       JSL.L AddPlayerHappiness                   ;82943F;83B282;
                       %Set16bit(!M)                             ;829443;      ;
                       LDA.L $7F1F5A                        ;829445;7F1F5A;
                       ORA.W #$2000                         ;829449;      ;
                       STA.L $7F1F5A                        ;82944C;7F1F5A;
                                                            ;      ;      ;
          CODE_829450: %Set16bit(!MX)                             ;829450;      ;
                       LDA.W #$0000                         ;829452;      ;
                       STA.B !player_action                            ;829455;0000D4;
                       %Set8bit(!M)                             ;829457;      ;
                       LDA.B #$FE                           ;829459;      ;
                       JSL.L ChangeStamina                    ;82945B;81D061;
                       RTS                                  ;82945F;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829460;      ;
                       JSR.W CODE_8292A0                    ;829462;8292A0;
                       BNE CODE_82946A                      ;829465;82946A;
                       JMP.W CODE_8295B0                    ;829467;8295B0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82946A: %Set16bit(!M)                             ;82946A;      ;
                       LDA.W #$0017                         ;82946C;      ;
                       LDX.W $0985                          ;82946F;000985;
                       LDY.W $0987                          ;829472;000987;
                       JSL.L CODE_81A688                    ;829475;81A688;
                       %Set8bit(!M)                             ;829479;      ;
                       LDA.L !season                        ;82947B;7F1F19;
                       CMP.B #$02                           ;82947F;      ;
                       BCS CODE_8294C5                      ;829481;8294C5;
                       %Set16bit(!M)                             ;829483;      ;
                       LDA.L $7F1F60                        ;829485;7F1F60;
                       AND.W #$0008                         ;829489;      ;
                       BNE CODE_8294C5                      ;82948C;8294C5;
                       LDA.L $7F1F5A                        ;82948E;7F1F5A;
                       AND.W #$1000                         ;829492;      ;
                       BNE CODE_8294C5                      ;829495;8294C5;
                       %Set8bit(!M)                             ;829497;      ;
                       LDA.B #$20                           ;829499;      ;
                       JSL.L RNGReturn0toA                  ;82949B;8089F9;
                       BNE CODE_8294C5                      ;82949F;8294C5;
                       %Set16bit(!MX)                             ;8294A1;      ;
                       LDA.W #$0011                         ;8294A3;      ;
                       LDX.W #$0000                         ;8294A6;      ;
                       LDY.W #$0030                         ;8294A9;      ;
                       JSL.L CODE_8480F8                    ;8294AC;8480F8;
                       %Set8bit(!M)                             ;8294B0;      ;
                       STZ.W $093A                          ;8294B2;00093A;
                       %Set16bit(!M)                             ;8294B5;      ;
                       LDA.L $7F1F5A                        ;8294B7;7F1F5A;
                       ORA.W #$1000                         ;8294BB;      ;
                       STA.L $7F1F5A                        ;8294BE;7F1F5A;
                       JMP.W CODE_8295B0                    ;8294C2;8295B0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8294C5: %Set16bit(!MX)                             ;8294C5;      ;
                       LDA.L $7F1F60                        ;8294C7;7F1F60;
                       AND.W #$0008                         ;8294CB;      ;
                       BNE CODE_82954A                      ;8294CE;82954A;
                       LDA.L $7F1F5C                        ;8294D0;7F1F5C;
                       AND.W #$0200                         ;8294D4;      ;
                       BNE CODE_82954A                      ;8294D7;82954A;
                       %Set8bit(!M)                             ;8294D9;      ;
                       LDA.B #$10                           ;8294DB;      ;
                       JSL.L RNGReturn0toA                  ;8294DD;8089F9;
                       BNE CODE_829511                      ;8294E1;829511;
                       %Set16bit(!MX)                             ;8294E3;      ;
                       LDA.L $7F1F5C                        ;8294E5;7F1F5C;
                       ORA.W #$0200                         ;8294E9;      ;
                       STA.L $7F1F5C                        ;8294EC;7F1F5C;
                       LDA.W #$000F                         ;8294F0;      ;
                       LDX.W #$0000                         ;8294F3;      ;
                       LDY.W #$003A                         ;8294F6;      ;
                       JSL.L CODE_8480F8                    ;8294F9;8480F8;
                       %Set16bit(!M)                             ;8294FD;      ;
                       LDA.W #$0001                         ;8294FF;      ;
                       STA.B $72                            ;829502;000072;
                       %Set8bit(!M)                             ;829504;      ;
                       LDA.B #$00                           ;829506;      ;
                       STA.B $74                            ;829508;000074;
                       JSL.L AddMoney                       ;82950A;83B1C9;
                       JMP.W CODE_8295B0                    ;82950E;8295B0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829511: %Set8bit(!M)                             ;829511;      ;
                       LDA.B #$10                           ;829513;      ;
                       JSL.L RNGReturn0toA                  ;829515;8089F9;
                       BNE CODE_82954A                      ;829519;82954A;
                       %Set16bit(!MX)                             ;82951B;      ;
                       LDA.L $7F1F5C                        ;82951D;7F1F5C;
                       ORA.W #$0200                         ;829521;      ;
                       STA.L $7F1F5C                        ;829524;7F1F5C;
                       %Set16bit(!MX)                             ;829528;      ;
                       LDA.W #$000F                         ;82952A;      ;
                       LDX.W #$0000                         ;82952D;      ;
                       LDY.W #$003B                         ;829530;      ;
                       JSL.L CODE_8480F8                    ;829533;8480F8;
                       %Set16bit(!M)                             ;829537;      ;
                       LDA.W #$0005                         ;829539;      ;
                       STA.B $72                            ;82953C;000072;
                       %Set8bit(!M)                             ;82953E;      ;
                       LDA.B #$00                           ;829540;      ;
                       STA.B $74                            ;829542;000074;
                       JSL.L AddMoney                       ;829544;83B1C9;
                       BRA CODE_8295B0                      ;829548;8295B0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82954A: %Set8bit(!M)                             ;82954A;      ;
                       LDA.B #$40                           ;82954C;      ;
                       JSL.L RNGReturn0toA                  ;82954E;8089F9;
                       BNE CODE_8295B0                      ;829552;8295B0;
                       %Set16bit(!MX)                             ;829554;      ;
                       LDA.L $7F1F60                        ;829556;7F1F60;
                       AND.W #$0008                         ;82955A;      ;
                       BNE CODE_8295B0                      ;82955D;8295B0;
                       LDA.L $7F1F5C                        ;82955F;7F1F5C;
                       AND.W #$0100                         ;829563;      ;
                       BNE CODE_8295B0                      ;829566;8295B0;
                       LDA.L $7F1F5C                        ;829568;7F1F5C;
                       ORA.W #$0100                         ;82956C;      ;
                       STA.L $7F1F5C                        ;82956F;7F1F5C;
                       LDA.L $7F1F64                        ;829573;7F1F64;
                       AND.W #$0800                         ;829577;      ;
                       BNE CODE_829589                      ;82957A;829589;
                       LDA.L $7F1F64                        ;82957C;7F1F64;
                       ORA.W #$0800                         ;829580;      ;
                       STA.L $7F1F64                        ;829583;7F1F64;
                       BRA CODE_82959F                      ;829587;82959F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829589: %Set16bit(!MX)                             ;829589;      ;
                       LDA.L $7F1F64                        ;82958B;7F1F64;
                       AND.W #$1000                         ;82958F;      ;
                       BNE CODE_8295B0                      ;829592;8295B0;
                       LDA.L $7F1F64                        ;829594;7F1F64;
                       ORA.W #$1000                         ;829598;      ;
                       STA.L $7F1F64                        ;82959B;7F1F64;
                                                            ;      ;      ;
          CODE_82959F: %Set16bit(!MX)                             ;82959F;      ;
                       LDA.W #$0010                         ;8295A1;      ;
                       LDX.W #$0000                         ;8295A4;      ;
                       LDY.W #$001F                         ;8295A7;      ;
                       JSL.L CODE_8480F8                    ;8295AA;8480F8;
                       BRA CODE_8295B0                      ;8295AE;8295B0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8295B0: %Set16bit(!MX)                             ;8295B0;      ;
                       LDA.W #$0000                         ;8295B2;      ;
                       STA.B !player_action                            ;8295B5;0000D4;
                       %Set8bit(!M)                             ;8295B7;      ;
                       LDA.B #$FE                           ;8295B9;      ;
                       JSL.L ChangeStamina                    ;8295BB;81D061;
                       RTS                                  ;8295BF;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8295C0;      ;
                       JSR.W CODE_8292A0                    ;8295C2;8292A0;
                       BNE CODE_8295CA                      ;8295C5;8295CA;
                       JMP.W CODE_82973F                    ;8295C7;82973F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8295CA: CPX.W #$0006                         ;8295CA;      ;
                       BEQ CODE_829633                      ;8295CD;829633;
                       CPX.W #$0004                         ;8295CF;      ;
                       BNE CODE_829645                      ;8295D2;829645;
                       %Set8bit(!M)                             ;8295D4;      ;
                       LDA.B !tilemap_to_load                            ;8295D6;000022;
                       CMP.B #$04                           ;8295D8;      ;
                       BCC CODE_8295F0                      ;8295DA;8295F0;
                       LDA.B !tilemap_to_load                            ;8295DC;000022;
                       CMP.B #$29                           ;8295DE;      ;
                       BCS CODE_8295E9                      ;8295E0;8295E9;
                       %Set16bit(!M)                             ;8295E2;      ;
                       LDA.W #$00DD                         ;8295E4;      ;
                       BRA CODE_8295F5                      ;8295E7;8295F5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8295E9: %Set16bit(!M)                             ;8295E9;      ;
                       LDA.W #$00E3                         ;8295EB;      ;
                       BRA CODE_8295F5                      ;8295EE;8295F5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8295F0: %Set16bit(!M)                             ;8295F0;      ;
                       LDA.W #$000E                         ;8295F2;      ;
                                                            ;      ;      ;
          CODE_8295F5: LDX.W $0985                          ;8295F5;000985;
                       LDY.W $0987                          ;8295F8;000987;
                       JSL.L CODE_81A688                    ;8295FB;81A688;
                       %Set16bit(!M)                             ;8295FF;      ;
                       LDA.W $0985                          ;829601;000985;
                       STA.W $0980                          ;829604;000980;
                       LDA.W $0987                          ;829607;000987;
                       STA.W $0982                          ;82960A;000982;
                       %Set16bit(!MX)                             ;82960D;      ;
                       LDA.W #$00C8                         ;82960F;      ;
                       STA.W $097A                          ;829612;00097A;
                       LDA.W #$0000                         ;829615;      ;
                       STA.W $097E                          ;829618;00097E;
                       %Set8bit(!M)                             ;82961B;      ;
                       LDA.B #$03                           ;82961D;      ;
                       STA.W $0974                          ;82961F;000974;
                       LDA.B #$00                           ;829622;      ;
                       STA.W $0975                          ;829624;000975;
                       LDA.B #$00                           ;829627;      ;
                       STA.W $0976                          ;829629;000976;
                       JSL.L CODE_81A500                    ;82962C;81A500;
                       JMP.W CODE_82972F                    ;829630;82972F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829633: %Set16bit(!M)                             ;829633;      ;
                       LDA.W #$000E                         ;829635;      ;
                       LDX.W $0985                          ;829638;000985;
                       LDY.W $0987                          ;82963B;000987;
                       JSL.L CODE_81A688                    ;82963E;81A688;
                       JMP.W CODE_82972F                    ;829642;82972F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829645: %Set8bit(!M)                             ;829645;      ;
                       LDA.W $096D                          ;829647;00096D;
                       INC A                                ;82964A;      ;
                       STA.W $096D                          ;82964B;00096D;
                       CMP.B #$06                           ;82964E;      ;
                       BEQ CODE_829655                      ;829650;829655;
                       JMP.W CODE_8296FE                    ;829652;8296FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829655: STZ.W $096D                          ;829655;00096D;
                       %Set16bit(!M)                             ;829658;      ;
                       LDA.W $0985                          ;82965A;000985;
                       SEC                                  ;82965D;      ;
                       SBC.W #$0010                         ;82965E;      ;
                       STA.W $0985                          ;829661;000985;
                       LDA.W $0987                          ;829664;000987;
                       SEC                                  ;829667;      ;
                       SBC.W #$0010                         ;829668;      ;
                       STA.W $0987                          ;82966B;000987;
                       CPX.W #$0010                         ;82966E;      ;
                       BEQ CODE_8296A5                      ;829671;8296A5;
                       LDA.W $0985                          ;829673;000985;
                       CLC                                  ;829676;      ;
                       ADC.W #$0010                         ;829677;      ;
                       STA.W $0985                          ;82967A;000985;
                       CPX.W #$000F                         ;82967D;      ;
                       BEQ CODE_8296A5                      ;829680;8296A5;
                       LDA.W $0985                          ;829682;000985;
                       SEC                                  ;829685;      ;
                       SBC.W #$0010                         ;829686;      ;
                       STA.W $0985                          ;829689;000985;
                       LDA.W $0987                          ;82968C;000987;
                       CLC                                  ;82968F;      ;
                       ADC.W #$0010                         ;829690;      ;
                       STA.W $0987                          ;829693;000987;
                       CPX.W #$000E                         ;829696;      ;
                       BEQ CODE_8296A5                      ;829699;8296A5;
                       LDA.W $0985                          ;82969B;000985;
                       CLC                                  ;82969E;      ;
                       ADC.W #$0010                         ;82969F;      ;
                       STA.W $0985                          ;8296A2;000985;
                                                            ;      ;      ;
          CODE_8296A5: %Set8bit(!M)                             ;8296A5;      ;
                       LDA.B !tilemap_to_load                            ;8296A7;000022;
                       CMP.B #$04                           ;8296A9;      ;
                       BCC CODE_8296B4                      ;8296AB;8296B4;
                       %Set16bit(!M)                             ;8296AD;      ;
                       LDA.W #$00DF                         ;8296AF;      ;
                       BRA CODE_8296B9                      ;8296B2;8296B9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8296B4: %Set16bit(!M)                             ;8296B4;      ;
                       LDA.W #$000D                         ;8296B6;      ;
                                                            ;      ;      ;
          CODE_8296B9: LDX.W $0985                          ;8296B9;000985;
                       LDY.W $0987                          ;8296BC;000987;
                       JSL.L CODE_81A688                    ;8296BF;81A688;
                       %Set16bit(!M)                             ;8296C3;      ;
                       LDA.W $0985                          ;8296C5;000985;
                       CLC                                  ;8296C8;      ;
                       ADC.W #$0008                         ;8296C9;      ;
                       STA.W $0980                          ;8296CC;000980;
                       LDA.W $0987                          ;8296CF;000987;
                       CLC                                  ;8296D2;      ;
                       ADC.W #$0008                         ;8296D3;      ;
                       STA.W $0982                          ;8296D6;000982;
                       %Set16bit(!MX)                             ;8296D9;      ;
                       LDA.W #$00C9                         ;8296DB;      ;
                       STA.W $097A                          ;8296DE;00097A;
                       LDA.W #$0000                         ;8296E1;      ;
                       STA.W $097E                          ;8296E4;00097E;
                       %Set8bit(!M)                             ;8296E7;      ;
                       LDA.B #$03                           ;8296E9;      ;
                       STA.W $0974                          ;8296EB;000974;
                       LDA.B #$00                           ;8296EE;      ;
                       STA.W $0975                          ;8296F0;000975;
                       LDA.B #$00                           ;8296F3;      ;
                       STA.W $0976                          ;8296F5;000976;
                       JSL.L CODE_81A500                    ;8296F8;81A500;
                       BRA CODE_82972F                      ;8296FC;82972F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8296FE: %Set16bit(!M)                             ;8296FE;      ;
                       LDA.W $0985                          ;829700;000985;
                       STA.W $0980                          ;829703;000980;
                       LDA.W $0987                          ;829706;000987;
                       STA.W $0982                          ;829709;000982;
                       %Set16bit(!MX)                             ;82970C;      ;
                       LDA.W #$00CB                         ;82970E;      ;
                       STA.W $097A                          ;829711;00097A;
                       LDA.W #$0000                         ;829714;      ;
                       STA.W $097E                          ;829717;00097E;
                       %Set8bit(!M)                             ;82971A;      ;
                       LDA.B #$03                           ;82971C;      ;
                       STA.W $0974                          ;82971E;000974;
                       LDA.B #$00                           ;829721;      ;
                       STA.W $0975                          ;829723;000975;
                       LDA.B #$00                           ;829726;      ;
                       STA.W $0976                          ;829728;000976;
                       JSL.L CODE_81A500                    ;82972B;81A500;
                                                            ;      ;      ;
          CODE_82972F: %Set16bit(!MX)                             ;82972F;      ;
                       LDA.W #$0000                         ;829731;      ;
                       STA.B !player_action                            ;829734;0000D4;
                       %Set8bit(!M)                             ;829736;      ;
                       LDA.B #$FE                           ;829738;      ;
                       JSL.L ChangeStamina                    ;82973A;81D061;
                       RTS                                  ;82973E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82973F: %Set8bit(!M)                             ;82973F;      ;
                       %Set16bit(!X)                             ;829741;      ;
                       LDA.B !tilemap_to_load                            ;829743;000022;
                       CMP.B #$0C                           ;829745;      ;
                       BCC CODE_82972F                      ;829747;82972F;
                       CMP.B #$10                           ;829749;      ;
                       BCS CODE_82972F                      ;82974B;82972F;
                       CPX.W #$00F8                         ;82974D;      ;
                       BNE CODE_82972F                      ;829750;82972F;
                       %Set16bit(!MX)                             ;829752;      ;
                       LDA.L $7F1F5C                        ;829754;7F1F5C;
                       AND.W #$0080                         ;829758;      ;
                       BNE CODE_82972F                      ;82975B;82972F;
                       %Set16bit(!M)                             ;82975D;      ;
                       LDA.W #$0015                         ;82975F;      ;
                       LDX.W #$0000                         ;829762;      ;
                       LDY.W #$0016                         ;829765;      ;
                       JSL.L CODE_84803F                    ;829768;84803F;
                       %Set8bit(!M)                             ;82976C;      ;
                       LDA.B #$04                           ;82976E;      ;
                       JSL.L RNGReturn0toA                  ;829770;8089F9;
                       BNE CODE_82972F                      ;829774;82972F;
                       %Set16bit(!MX)                             ;829776;      ;
                       LDA.L $7F1F64                        ;829778;7F1F64;
                       AND.W #$0200                         ;82977C;      ;
                       BNE CODE_82972F                      ;82977F;82972F;
                       LDA.L $7F1F64                        ;829781;7F1F64;
                       ORA.W #$0200                         ;829785;      ;
                       STA.L $7F1F64                        ;829788;7F1F64;
                       %Set16bit(!MX)                             ;82978C;      ;
                       LDA.B !player_pos_X                           ;82978E;0000D6;
                       CLC                                  ;829790;      ;
                       ADC.W #$0010                         ;829791;      ;
                       STA.W $0985                          ;829794;000985;
                       LDA.B !player_pos_Y                            ;829797;0000D8;
                       SEC                                  ;829799;      ;
                       SBC.W #$0010                         ;82979A;      ;
                       STA.W $0987                          ;82979D;000987;
                       LDA.W #$0010                         ;8297A0;      ;
                       LDX.W #$0000                         ;8297A3;      ;
                       LDY.W #$001F                         ;8297A6;      ;
                       JSL.L CODE_8480F8                    ;8297A9;8480F8;
                       %Set16bit(!MX)                             ;8297AD;      ;
                       LDA.L $7F1F5C                        ;8297AF;7F1F5C;
                       ORA.W #$0080                         ;8297B3;      ;
                       STA.L $7F1F5C                        ;8297B6;7F1F5C;
                       JMP.W CODE_82972F                    ;8297BA;82972F;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8297BD;      ;
                       JSR.W CODE_8292A0                    ;8297BF;8292A0;
                       BNE CODE_8297C7                      ;8297C2;8297C7;
                       JMP.W CODE_82994B                    ;8297C4;82994B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8297C7: %Set8bit(!M)                             ;8297C7;      ;
                       LDA.W $096D                          ;8297C9;00096D;
                       INC A                                ;8297CC;      ;
                       STA.W $096D                          ;8297CD;00096D;
                       CMP.B #$06                           ;8297D0;      ;
                       BEQ CODE_8297D7                      ;8297D2;8297D7;
                       JMP.W CODE_829918                    ;8297D4;829918;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8297D7: STZ.W $096D                          ;8297D7;00096D;
                       %Set16bit(!M)                             ;8297DA;      ;
                       LDA.W $0985                          ;8297DC;000985;
                       SEC                                  ;8297DF;      ;
                       SBC.W #$0010                         ;8297E0;      ;
                       STA.W $0985                          ;8297E3;000985;
                       LDA.W $0987                          ;8297E6;000987;
                       SEC                                  ;8297E9;      ;
                       SBC.W #$0010                         ;8297EA;      ;
                       STA.W $0987                          ;8297ED;000987;
                       CPX.W #$000C                         ;8297F0;      ;
                       BEQ CODE_829849                      ;8297F3;829849;
                       CPX.W #$0014                         ;8297F5;      ;
                       BNE CODE_8297FD                      ;8297F8;8297FD;
                       JMP.W CODE_8298BC                    ;8297FA;8298BC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8297FD: LDA.W $0985                          ;8297FD;000985;
                       CLC                                  ;829800;      ;
                       ADC.W #$0010                         ;829801;      ;
                       STA.W $0985                          ;829804;000985;
                       CPX.W #$000B                         ;829807;      ;
                       BEQ CODE_829849                      ;82980A;829849;
                       CPX.W #$0013                         ;82980C;      ;
                       BNE CODE_829814                      ;82980F;829814;
                       JMP.W CODE_8298BC                    ;829811;8298BC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829814: LDA.W $0985                          ;829814;000985;
                       SEC                                  ;829817;      ;
                       SBC.W #$0010                         ;829818;      ;
                       STA.W $0985                          ;82981B;000985;
                       LDA.W $0987                          ;82981E;000987;
                       CLC                                  ;829821;      ;
                       ADC.W #$0010                         ;829822;      ;
                       STA.W $0987                          ;829825;000987;
                       CPX.W #$000A                         ;829828;      ;
                       BEQ CODE_829849                      ;82982B;829849;
                       CPX.W #$0012                         ;82982D;      ;
                       BNE CODE_829835                      ;829830;829835;
                       JMP.W CODE_8298BC                    ;829832;8298BC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829835: LDA.W $0985                          ;829835;000985;
                       CLC                                  ;829838;      ;
                       ADC.W #$0010                         ;829839;      ;
                       STA.W $0985                          ;82983C;000985;
                       CPX.W #$0009                         ;82983F;      ;
                       BEQ CODE_829849                      ;829842;829849;
                       CPX.W #$0011                         ;829844;      ;
                       BEQ CODE_8298BC                      ;829847;8298BC;
                                                            ;      ;      ;
          CODE_829849: %Set8bit(!M)                             ;829849;      ;
                       LDA.B !tilemap_to_load                            ;82984B;000022;
                       CMP.B #$04                           ;82984D;      ;
                       BCC CODE_8298C3                      ;82984F;8298C3;
                       %Set16bit(!M)                             ;829851;      ;
                       LDA.L $7F1F60                        ;829853;7F1F60;
                       AND.W #$0008                         ;829857;      ;
                       BNE CODE_8298B5                      ;82985A;8298B5;
                       %Set8bit(!M)                             ;82985C;      ;
                       LDA.B #$10                           ;82985E;      ;
                       JSL.L RNGReturn0toA                  ;829860;8089F9;
                       BNE CODE_8298B5                      ;829864;8298B5;
                       %Set16bit(!MX)                             ;829866;      ;
                       LDA.L $7F1F64                        ;829868;7F1F64;
                       AND.W #$0400                         ;82986C;      ;
                       BNE CODE_8298B5                      ;82986F;8298B5;
                       LDA.L $7F1F64                        ;829871;7F1F64;
                       ORA.W #$0400                         ;829875;      ;
                       STA.L $7F1F64                        ;829878;7F1F64;
                       %Set16bit(!MX)                             ;82987C;      ;
                       LDA.W $0985                          ;82987E;000985;
                       CLC                                  ;829881;      ;
                       ADC.W #$0008                         ;829882;      ;
                       STA.W $0985                          ;829885;000985;
                       LDA.W $0987                          ;829888;000987;
                       CLC                                  ;82988B;      ;
                       ADC.W #$0008                         ;82988C;      ;
                       STA.W $0987                          ;82988F;000987;
                       LDA.W #$0010                         ;829892;      ;
                       LDX.W #$0000                         ;829895;      ;
                       LDY.W #$001F                         ;829898;      ;
                       JSL.L CODE_8480F8                    ;82989B;8480F8;
                       %Set16bit(!MX)                             ;82989F;      ;
                       LDA.W $0985                          ;8298A1;000985;
                       SEC                                  ;8298A4;      ;
                       SBC.W #$0008                         ;8298A5;      ;
                       STA.W $0985                          ;8298A8;000985;
                       LDA.W $0987                          ;8298AB;000987;
                       SEC                                  ;8298AE;      ;
                       SBC.W #$0008                         ;8298AF;      ;
                       STA.W $0987                          ;8298B2;000987;
                                                            ;      ;      ;
          CODE_8298B5: %Set16bit(!MX)                             ;8298B5;      ;
                       LDA.W #$00DF                         ;8298B7;      ;
                       BRA CODE_8298C8                      ;8298BA;8298C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8298BC: %Set16bit(!MX)                             ;8298BC;      ;
                       LDA.W #$00E0                         ;8298BE;      ;
                       BRA CODE_8298C8                      ;8298C1;8298C8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8298C3: %Set16bit(!MX)                             ;8298C3;      ;
                       LDA.W #$000D                         ;8298C5;      ;
                                                            ;      ;      ;
          CODE_8298C8: %Set16bit(!MX)                             ;8298C8;      ;
                       LDX.W $0985                          ;8298CA;000985;
                       LDY.W $0987                          ;8298CD;000987;
                       JSL.L CODE_81A688                    ;8298D0;81A688;
                       %Set16bit(!M)                             ;8298D4;      ;
                       LDA.W $0985                          ;8298D6;000985;
                       CLC                                  ;8298D9;      ;
                       ADC.W #$0008                         ;8298DA;      ;
                       STA.W $0980                          ;8298DD;000980;
                       LDA.W $0987                          ;8298E0;000987;
                       CLC                                  ;8298E3;      ;
                       ADC.W #$0008                         ;8298E4;      ;
                       STA.W $0982                          ;8298E7;000982;
                       %Set16bit(!MX)                             ;8298EA;      ;
                       LDA.W #$00B8                         ;8298EC;      ;
                       STA.W $097A                          ;8298EF;00097A;
                       LDA.W #$0000                         ;8298F2;      ;
                       STA.W $097E                          ;8298F5;00097E;
                       %Set8bit(!M)                             ;8298F8;      ;
                       LDA.B #$03                           ;8298FA;      ;
                       STA.W $0974                          ;8298FC;000974;
                       LDA.B #$00                           ;8298FF;      ;
                       STA.W $0975                          ;829901;000975;
                       LDA.B #$00                           ;829904;      ;
                       STA.W $0976                          ;829906;000976;
                       JSL.L CODE_81A500                    ;829909;81A500;
                       %Set16bit(!M)                             ;82990D;      ;
                       LDA.W #$0006                         ;82990F;      ;
                       JSL.L AddWood                        ;829912;83B224;
                       BRA CODE_829989                      ;829916;829989;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829918: %Set16bit(!M)                             ;829918;      ;
                       LDA.W $0985                          ;82991A;000985;
                       STA.W $0980                          ;82991D;000980;
                       LDA.W $0987                          ;829920;000987;
                       STA.W $0982                          ;829923;000982;
                       %Set16bit(!MX)                             ;829926;      ;
                       LDA.W #$00CB                         ;829928;      ;
                       STA.W $097A                          ;82992B;00097A;
                       LDA.W #$0000                         ;82992E;      ;
                       STA.W $097E                          ;829931;00097E;
                       %Set8bit(!M)                             ;829934;      ;
                       LDA.B #$03                           ;829936;      ;
                       STA.W $0974                          ;829938;000974;
                       LDA.B #$00                           ;82993B;      ;
                       STA.W $0975                          ;82993D;000975;
                       LDA.B #$00                           ;829940;      ;
                       STA.W $0976                          ;829942;000976;
                       JSL.L CODE_81A500                    ;829945;81A500;
                       BRA CODE_829989                      ;829949;829989;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82994B: %Set8bit(!M)                             ;82994B;      ;
                       LDA.B !tilemap_to_load                            ;82994D;000022;
                       CMP.B #$10                           ;82994F;      ;
                       BCC CODE_829989                      ;829951;829989;
                       CMP.B #$14                           ;829953;      ;
                       BCS CODE_829989                      ;829955;829989;
                       CPX.W #$00F4                         ;829957;      ;
                       BNE CODE_829989                      ;82995A;829989;
                       %Set16bit(!MX)                             ;82995C;      ;
                       LDA.W $0196                          ;82995E;000196;
                       AND.W #$001A                         ;829961;      ;
                       BNE CODE_829989                      ;829964;829989;
                       LDA.L $7F1F6A                        ;829966;7F1F6A;
                       AND.W #$0020                         ;82996A;      ;
                       BNE CODE_829989                      ;82996D;829989;
                       LDA.L $7F1F6A                        ;82996F;7F1F6A;
                       ORA.W #$0020                         ;829973;      ;
                       STA.L $7F1F6A                        ;829976;7F1F6A;
                       %Set16bit(!MX)                             ;82997A;      ;
                       LDA.W #$0000                         ;82997C;      ;
                       LDX.W #$0017                         ;82997F;      ;
                       LDY.W #$0000                         ;829982;      ;
                       JSL.L VIP                            ;829985;848097;
                                                            ;      ;      ;
          CODE_829989: %Set16bit(!MX)                             ;829989;      ;
                       LDA.W #$0000                         ;82998B;      ;
                       STA.B !player_action                            ;82998E;0000D4;
                       %Set8bit(!M)                             ;829990;      ;
                       LDA.B #$FE                           ;829992;      ;
                       JSL.L ChangeStamina                    ;829994;81D061;
                       RTS                                  ;829998;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82A9999;      ;
                       %Set16bit(!X)                             ;82999B;      ;
                       LDA.B #$00                           ;82999D;      ;
                       XBA                                  ;82999F;      ;
                       LDA.W $096B                          ;8299A0;00096B;
                       JSR.W CODE_8292D6                    ;8299A3;8292D6;
                       BNE CODE_8299AB                      ;8299A6;8299AB;
                       JMP.W CODE_8299CA                    ;8299A8;8299CA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8299AB: %Set16bit(!MX)                             ;8299AB;      ;
                       LDX.W #$0019                         ;8299AD;      ;
                       %Set8bit(!M)                             ;8299B0;      ;
                       LDA.L !season                        ;8299B2;7F1F19;
                       CMP.B #$01                           ;8299B6;      ;
                       BEQ CODE_8299BD                      ;8299B8;8299BD;
                       LDX.W #$00EB                         ;8299BA;      ;
                                                            ;      ;      ;
          CODE_8299BD: %Set16bit(!M)                             ;8299BD;      ;
                       TXA                                  ;8299BF;      ;
                       LDX.W $0985                          ;8299C0;000985;
                       LDY.W $0987                          ;8299C3;000987;
                       JSL.L CODE_81A688                    ;8299C6;81A688;
                                                            ;      ;      ;
          CODE_8299CA: %Set8bit(!M)                             ;8299CA;      ;
                       LDA.W $096B                          ;8299CC;00096B;
                       INC A                                ;8299CF;      ;
                       STA.W $096B                          ;8299D0;00096B;
                       CMP.B #$09                           ;8299D3;      ;
                       BNE CODE_8299F7                      ;8299D5;8299F7;
                       STZ.W $096B                          ;8299D7;00096B;
                       %Set8bit(!M)                             ;8299DA;      ;
                       LDA.W !seeds_corn_N                          ;8299DC;000928;
                       DEC A                                ;8299DF;      ;
                       STA.W !seeds_corn_N                          ;8299E0;000928;
                       BNE CODE_8299E8                      ;8299E3;8299E8;
                       STZ.W !tool_selected                          ;8299E5;000921;
                                                            ;      ;      ;
          CODE_8299E8: %Set16bit(!MX)                             ;8299E8;      ;
                       LDA.W #$0000                         ;8299EA;      ;
                       STA.B !player_action                            ;8299ED;0000D4;
                       %Set8bit(!M)                             ;8299EF;      ;
                       LDA.B #$FF                           ;8299F1;      ;
                       JSL.L ChangeStamina                    ;8299F3;81D061;
                                                            ;      ;      ;
          CODE_8299F7: RTS                                  ;8299F7;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;8299F8;      ;
                       %Set16bit(!X)                             ;8299FA;      ;
                       LDA.B #$00                           ;8299FC;      ;
                       XBA                                  ;8299FE;      ;
                       LDA.W $096B                          ;8299FF;00096B;
                       JSR.W CODE_8292D6                    ;829A02;8292D6;
                       BNE CODE_829A0A                      ;829A05;829A0A;
                       JMP.W CODE_829A29                    ;829A07;829A29;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829A0A: %Set16bit(!MX)                             ;829A0A;      ;
                       LDX.W #$001A                         ;829A0C;      ;
                       %Set8bit(!M)                             ;829A0F;      ;
                       LDA.L !season                        ;829A11;7F1F19;
                       CMP.B #$01                           ;829A15;      ;
                       BEQ CODE_829A1C                      ;829A17;829A1C;
                       LDX.W #$00EB                         ;829A19;      ;
                                                            ;      ;      ;
          CODE_829A1C: %Set16bit(!M)                             ;829A1C;      ;
                       TXA                                  ;829A1E;      ;
                       LDX.W $0985                          ;829A1F;000985;
                       LDY.W $0987                          ;829A22;000987;
                       JSL.L CODE_81A688                    ;829A25;81A688;
                                                            ;      ;      ;
          CODE_829A29: %Set8bit(!M)                             ;829A29;      ;
                       LDA.W $096B                          ;829A2B;00096B;
                       INC A                                ;829A2E;      ;
                       STA.W $096B                          ;829A2F;00096B;
                       CMP.B #$09                           ;829A32;      ;
                       BNE CODE_829A56                      ;829A34;829A56;
                       STZ.W $096B                          ;829A36;00096B;
                       %Set8bit(!M)                             ;829A39;      ;
                       LDA.W !seeds_tomato_N                          ;829A3B;000929;
                       DEC A                                ;829A3E;      ;
                       STA.W !seeds_tomato_N                          ;829A3F;000929;
                       BNE CODE_829A47                      ;829A42;829A47;
                       STZ.W !tool_selected                          ;829A44;000921;
                                                            ;      ;      ;
          CODE_829A47: %Set16bit(!MX)                             ;829A47;      ;
                       LDA.W #$0000                         ;829A49;      ;
                       STA.B !player_action                            ;829A4C;0000D4;
                       %Set8bit(!M)                             ;829A4E;      ;
                       LDA.B #$FF                           ;829A50;      ;
                       JSL.L ChangeStamina                    ;829A52;81D061;
                                                            ;      ;      ;
          CODE_829A56: RTS                                  ;829A56;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;829A57;      ;
                       %Set16bit(!X)                             ;829A59;      ;
                       LDA.B #$00                           ;829A5B;      ;
                       XBA                                  ;829A5D;      ;
                       LDA.W $096B                          ;829A5E;00096B;
                       JSR.W CODE_8292D6                    ;829A61;8292D6;
                       BNE CODE_829A69                      ;829A64;829A69;
                       JMP.W CODE_829A86                    ;829A66;829A86;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829A69: %Set16bit(!MX)                             ;829A69;      ;
                       LDX.W #$001B                         ;829A6B;      ;
                       %Set8bit(!M)                             ;829A6E;      ;
                       LDA.L !season                        ;829A70;7F1F19;
                       BEQ CODE_829A79                      ;829A74;829A79;
                       LDX.W #$00EB                         ;829A76;      ;
                                                            ;      ;      ;
          CODE_829A79: %Set16bit(!M)                             ;829A79;      ;
                       TXA                                  ;829A7B;      ;
                       LDX.W $0985                          ;829A7C;000985;
                       LDY.W $0987                          ;829A7F;000987;
                       JSL.L CODE_81A688                    ;829A82;81A688;
                                                            ;      ;      ;
          CODE_829A86: %Set8bit(!M)                             ;829A86;      ;
                       LDA.W $096B                          ;829A88;00096B;
                       INC A                                ;829A8B;      ;
                       STA.W $096B                          ;829A8C;00096B;
                       CMP.B #$09                           ;829A8F;      ;
                       BNE CODE_829AB3                      ;829A91;829AB3;
                       STZ.W $096B                          ;829A93;00096B;
                       %Set8bit(!M)                             ;829A96;      ;
                       LDA.W !seeds_potato_N                          ;829A98;00092A;
                       DEC A                                ;829A9B;      ;
                       STA.W !seeds_potato_N                          ;829A9C;00092A;
                       BNE CODE_829AA4                      ;829A9F;829AA4;
                       STZ.W !tool_selected                          ;829AA1;000921;
                                                            ;      ;      ;
          CODE_829AA4: %Set16bit(!MX)                             ;829AA4;      ;
                       LDA.W #$0000                         ;829AA6;      ;
                       STA.B !player_action                            ;829AA9;0000D4;
                       %Set8bit(!M)                             ;829AAB;      ;
                       LDA.B #$FF                           ;829AAD;      ;
                       JSL.L ChangeStamina                    ;829AAF;81D061;
                                                            ;      ;      ;
          CODE_829AB3: RTS                                  ;829AB3;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;829AB4;      ;
                       %Set16bit(!X)                             ;829AB6;      ;
                       LDA.B #$00                           ;829AB8;      ;
                       XBA                                  ;829ABA;      ;
                       LDA.W $096B                          ;829ABB;00096B;
                       JSR.W CODE_8292D6                    ;829ABE;8292D6;
                       BNE CODE_829AC6                      ;829AC1;829AC6;
                       JMP.W CODE_829AE3                    ;829AC3;829AE3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829AC6: %Set16bit(!MX)                             ;829AC6;      ;
                       LDX.W #$001C                         ;829AC8;      ;
                       %Set8bit(!M)                             ;829ACB;      ;
                       LDA.L !season                        ;829ACD;7F1F19;
                       BEQ CODE_829AD6                      ;829AD1;829AD6;
                       LDX.W #$00EB                         ;829AD3;      ;
                                                            ;      ;      ;
          CODE_829AD6: %Set16bit(!M)                             ;829AD6;      ;
                       TXA                                  ;829AD8;      ;
                       LDX.W $0985                          ;829AD9;000985;
                       LDY.W $0987                          ;829ADC;000987;
                       JSL.L CODE_81A688                    ;829ADF;81A688;
                                                            ;      ;      ;
          CODE_829AE3: %Set8bit(!M)                             ;829AE3;      ;
                       LDA.W $096B                          ;829AE5;00096B;
                       INC A                                ;829AE8;      ;
                       STA.W $096B                          ;829AE9;00096B;
                       CMP.B #$09                           ;829AEC;      ;
                       BNE CODE_829B10                      ;829AEE;829B10;
                       STZ.W $096B                          ;829AF0;00096B;
                       %Set8bit(!M)                             ;829AF3;      ;
                       LDA.W !seeds_turnip_N                          ;829AF5;00092B;
                       DEC A                                ;829AF8;      ;
                       STA.W !seeds_turnip_N                          ;829AF9;00092B;
                       BNE CODE_829B01                      ;829AFC;829B01;
                       STZ.W !tool_selected                          ;829AFE;000921;
                                                            ;      ;      ;
          CODE_829B01: %Set16bit(!MX)                             ;829B01;      ;
                       LDA.W #$0000                         ;829B03;      ;
                       STA.B !player_action                            ;829B06;0000D4;
                       %Set8bit(!M)                             ;829B08;      ;
                       LDA.B #$FF                           ;829B0A;      ;
                       JSL.L ChangeStamina                    ;829B0C;81D061;
                                                            ;      ;      ;
          CODE_829B10: RTS                                  ;829B10;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829B11;      ;
                       LDA.W #$0000                         ;829B13;      ;
                       STA.B !player_action                            ;829B16;0000D4;
                       %Set8bit(!M)                             ;829B18;      ;
                       STZ.W !tool_selected                          ;829B1A;000921;
                       LDA.B #$FF                           ;829B1D;      ;
                       JSL.L ChangeStamina                    ;829B1F;81D061;
                       %Set16bit(!M)                             ;829B23;      ;
                       LDA.L $7F1F5A                        ;829B25;7F1F5A;
                       ORA.W #$0080                         ;829B29;      ;
                       STA.L $7F1F5A                        ;829B2C;7F1F5A;
                       RTS                                  ;829B30;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829B31;      ;
                       LDA.W #$0000                         ;829B33;      ;
                       STA.B !player_action                            ;829B36;0000D4;
                       %Set8bit(!M)                             ;829B38;      ;
                       STZ.W !tool_selected                          ;829B3A;000921;
                       LDA.B #$FF                           ;829B3D;      ;
                       JSL.L ChangeStamina                    ;829B3F;81D061;
                       %Set16bit(!M)                             ;829B43;      ;
                       LDA.L $7F1F5A                        ;829B45;7F1F5A;
                       ORA.W #$0100                         ;829B49;      ;
                       STA.L $7F1F5A                        ;829B4C;7F1F5A;
                       RTS                                  ;829B50;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829B51;      ;
                       LDA.W #$0000                         ;829B53;      ;
                       STA.B !player_action                            ;829B56;0000D4;
                       %Set8bit(!M)                             ;829B58;      ;
                       LDA.B #$FF                           ;829B5A;      ;
                       JSL.L ChangeStamina                    ;829B5C;81D061;
                       RTS                                  ;829B60;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
UNK_SomethingAboutSeasonsandGrassSeeds: %Set8bit(!M)                             ;829B61;      ;
                       %Set16bit(!X)                             ;829B63;      ;
                       LDA.B #$00                           ;829B65;      ;
                       XBA                                  ;829B67;      ;
                       LDA.W $096B                          ;829B68;00096B;
                       JSR.W CODE_8292D6                    ;829B6B;8292D6;
                       BNE CODE_829B73                      ;829B6E;829B73;
                       JMP.W UNK_SomethingGrassSeeds        ;829B70;829B9D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829B73: %Set16bit(!MX)                             ;829B73;      ;
                       LDX.W #$00ED                         ;829B75;      ;
                       %Set8bit(!M)                             ;829B78;      ;
                       LDA.L !season                        ;829B7A;7F1F19;
                       CMP.B #$02                           ;829B7E;      ;
                       BCS CODE_829B90                      ;829B80;829B90;
                       %Set16bit(!M)                             ;829B82;      ;
                       LDA.L $7F1F29                        ;829B84;7F1F29;
                       INC A                                ;829B88;      ;
                       STA.L $7F1F29                        ;829B89;7F1F29;
                       LDX.W #$001E                         ;829B8D;      ;
                                                            ;      ;      ;
          CODE_829B90: %Set16bit(!M)                             ;829B90;      ;
                       TXA                                  ;829B92;      ;
                       LDX.W $0985                          ;829B93;000985;
                       LDY.W $0987                          ;829B96;000987;
                       JSL.L CODE_81A688                    ;829B99;81A688;
                                                            ;      ;      ;
UNK_SomethingGrassSeeds: %Set8bit(!M)                             ;829B9D;      ;
                       LDA.W $096B                          ;829B9F;00096B;
                       INC A                                ;829BA2;      ;
                       STA.W $096B                          ;829BA3;00096B;
                       CMP.B #$09                           ;829BA6;      ;
                       BNE CODE_829BCA                      ;829BA8;829BCA;
                       STZ.W $096B                          ;829BAA;00096B;
                       %Set8bit(!M)                             ;829BAD;      ;
                       LDA.W !seeds_grass_N                          ;829BAF;000927;
                       DEC A                                ;829BB2;      ;
                       STA.W !seeds_grass_N                          ;829BB3;000927;
                       BNE CODE_829BBB                      ;829BB6;829BBB;
                       STZ.W !tool_selected                          ;829BB8;000921;
                                                            ;      ;      ;
          CODE_829BBB: %Set16bit(!MX)                             ;829BBB;      ;
                       LDA.W #$0000                         ;829BBD;      ;
                       STA.B !player_action                            ;829BC0;0000D4;
                       %Set8bit(!M)                             ;829BC2;      ;
                       LDA.B #$FF                           ;829BC4;      ;
                       JSL.L ChangeStamina                    ;829BC6;81D061;
                                                            ;      ;      ;
          CODE_829BCA: RTS                                  ;829BCA;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829BCB;      ;
                       JSR.W CODE_8292A0                    ;829BCD;8292A0;
                       BNE CODE_829BD5                      ;829BD0;829BD5;
                       JMP.W CODE_829CB0                    ;829BD2;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829BD5: %Set16bit(!MX)                             ;829BD5;      ;
                       CPX.W #$00E2                         ;829BD7;      ;
                       BEQ CODE_829C1D                      ;829BDA;829C1D;
                       CPX.W #$00E3                         ;829BDC;      ;
                       BEQ CODE_829C50                      ;829BDF;829C50;
                       CPX.W #$00E4                         ;829BE1;      ;
                       BNE CODE_829BE9                      ;829BE4;829BE9;
                       JMP.W CODE_829C80                    ;829BE6;829C80;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829BE9: %Set16bit(!MX)                             ;829BE9;      ;
                       LDA.L $7F1F66                        ;829BEB;7F1F66;
                       AND.W #$0200                         ;829BEF;      ;
                       BEQ CODE_829BF7                      ;829BF2;829BF7;
                       JMP.W CODE_829CB0                    ;829BF4;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829BF7: LDA.W #$000A                         ;829BF7;      ;
                       JSL.L AddPlayerHappiness                   ;829BFA;83B282;
                       %Set16bit(!M)                             ;829BFE;      ;
                       LDA.W #$0059                         ;829C00;      ;
                       LDX.W #$0080                         ;829C03;      ;
                       LDY.W #$0130                         ;829C06;      ;
                       JSL.L CODE_81A688                    ;829C09;81A688;
                       %Set16bit(!MX)                             ;829C0D;      ;
                       LDA.L $7F1F66                        ;829C0F;7F1F66;
                       ORA.W #$0200                         ;829C13;      ;
                       STA.L $7F1F66                        ;829C16;7F1F66;
                       JMP.W CODE_829CB0                    ;829C1A;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829C1D: %Set16bit(!MX)                             ;829C1D;      ;
                       LDA.L $7F1F66                        ;829C1F;7F1F66;
                       AND.W #$0400                         ;829C23;      ;
                       BEQ CODE_829C2B                      ;829C26;829C2B;
                       JMP.W CODE_829CB0                    ;829C28;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829C2B: LDA.W #$000A                         ;829C2B;      ;
                       JSL.L AddPlayerHappiness                   ;829C2E;83B282;
                       %Set16bit(!M)                             ;829C32;      ;
                       LDA.W #$0058                         ;829C34;      ;
                       LDX.W #$0060                         ;829C37;      ;
                       LDY.W #$0130                         ;829C3A;      ;
                       JSL.L CODE_81A688                    ;829C3D;81A688;
                       %Set16bit(!MX)                             ;829C41;      ;
                       LDA.L $7F1F66                        ;829C43;7F1F66;
                       ORA.W #$0400                         ;829C47;      ;
                       STA.L $7F1F66                        ;829C4A;7F1F66;
                       BRA CODE_829CB0                      ;829C4E;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829C50: %Set16bit(!MX)                             ;829C50;      ;
                       LDA.L $7F1F66                        ;829C52;7F1F66;
                       AND.W #$0800                         ;829C56;      ;
                       BNE CODE_829CB0                      ;829C59;829CB0;
                       LDA.W #$000A                         ;829C5B;      ;
                       JSL.L AddPlayerHappiness                   ;829C5E;83B282;
                       %Set16bit(!M)                             ;829C62;      ;
                       LDA.W #$005A                         ;829C64;      ;
                       LDX.W #$0090                         ;829C67;      ;
                       LDY.W #$0130                         ;829C6A;      ;
                       JSL.L CODE_81A688                    ;829C6D;81A688;
                       %Set16bit(!MX)                             ;829C71;      ;
                       LDA.L $7F1F66                        ;829C73;7F1F66;
                       ORA.W #$0800                         ;829C77;      ;
                       STA.L $7F1F66                        ;829C7A;7F1F66;
                       BRA CODE_829CB0                      ;829C7E;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829C80: %Set16bit(!MX)                             ;829C80;      ;
                       LDA.L $7F1F66                        ;829C82;7F1F66;
                       AND.W #$1000                         ;829C86;      ;
                       BNE CODE_829CB0                      ;829C89;829CB0;
                       LDA.W #$000A                         ;829C8B;      ;
                       JSL.L AddPlayerHappiness                   ;829C8E;83B282;
                       %Set16bit(!M)                             ;829C92;      ;
                       LDA.W #$005C                         ;829C94;      ;
                       LDX.W #$00B0                         ;829C97;      ;
                       LDY.W #$0130                         ;829C9A;      ;
                       JSL.L CODE_81A688                    ;829C9D;81A688;
                       %Set16bit(!MX)                             ;829CA1;      ;
                       LDA.L $7F1F66                        ;829CA3;7F1F66;
                       ORA.W #$1000                         ;829CA7;      ;
                       STA.L $7F1F66                        ;829CAA;7F1F66;
                       BRA CODE_829CB0                      ;829CAE;829CB0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829CB0: %Set16bit(!MX)                             ;829CB0;      ;
                       LDA.W #$0000                         ;829CB2;      ;
                       STA.B !player_action                            ;829CB5;0000D4;
                       %Set8bit(!M)                             ;829CB7;      ;
                       LDA.B #$FE                           ;829CB9;      ;
                       JSL.L ChangeStamina                    ;829CBB;81D061;
                       RTS                                  ;829CBF;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829CC0;      ;
                       LDA.W #$0000                         ;829CC2;      ;
                       STA.B !player_action                            ;829CC5;0000D4;
                       RTS                                  ;829CC7;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;829CC8;      ;
                       LDA.W #$0000                         ;829CCA;      ;
                       STA.B !player_action                            ;829CCD;0000D4;
                       %Set8bit(!M)                             ;829CCF;      ;
                       LDA.B #$FF                           ;829CD1;      ;
                       JSL.L ChangeStamina                    ;829CD3;81D061;
                       RTS                                  ;829CD7;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;829CD8;      ;
                       %Set16bit(!X)                             ;829CDA;      ;
                       %Set8bit(!M)                             ;829CDC;      ;
                       %Set16bit(!X)                             ;829CDE;      ;
                       LDA.B #$00                           ;829CE0;      ;
                       STA.W $0114                          ;829CE2;000114;
                       LDA.B #$07                           ;829CE5;      ;
                       STA.W $0115                          ;829CE7;000115;
                       JSL.L UNK_Audio19                    ;829CEA;838332;
                       JSR.W CODE_8292A0                    ;829CEE;8292A0;
                       %Set8bit(!M)                             ;829CF1;      ;
                       CMP.B #$02                           ;829CF3;      ;
                       BEQ CODE_829D32                      ;829CF5;829D32;
                       LDA.W !sprinkler_water                          ;829CF7;000926;
                       BEQ CODE_829D32                      ;829CFA;829D32;
                       DEC A                                ;829CFC;      ;
                       STA.W !sprinkler_water                          ;829CFD;000926;
                       JSR.W CODE_8292A0                    ;829D00;8292A0;
                       BNE CODE_829D08                      ;829D03;829D08;
                       JMP.W CODE_829D32                    ;829D05;829D32;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D08: %Set16bit(!MX)                             ;829D08;      ;
                       TXA                                  ;829D0A;      ;
                       INC A                                ;829D0B;      ;
                       PHA                                  ;829D0C;      ;
                       %Set8bit(!M)                             ;829D0D;      ;
                       LDX.W $0985                          ;829D0F;000985;
                       LDY.W $0987                          ;829D12;000987;
                       JSL.L UNK_MOVE_FROM_SEASON_TO_09B6                    ;829D15;82B03A;
                       %Set16bit(!M)                             ;829D19;      ;
                       PLA                                  ;829D1B;      ;
                       ASL A                                ;829D1C;      ;
                       ASL A                                ;829D1D;      ;
                       TAY                                  ;829D1E;      ;
                       %Set8bit(!M)                             ;829D1F;      ;
                       LDA.B #$00                           ;829D21;      ;
                       XBA                                  ;829D23;      ;
                       LDA.B [$0D],Y                        ;829D24;00000D;
                       %Set16bit(!M)                             ;829D26;      ;
                       LDX.W $0985                          ;829D28;000985;
                       LDY.W $0987                          ;829D2B;000987;
                       JSL.L CODE_81A688                    ;829D2E;81A688;
                                                            ;      ;      ;
          CODE_829D32: %Set16bit(!MX)                             ;829D32;      ;
                       LDA.W #$0000                         ;829D34;      ;
                       STA.B !player_action                            ;829D37;0000D4;
                       %Set8bit(!M)                             ;829D39;      ;
                       LDA.B #$FE                           ;829D3B;      ;
                       JSL.L ChangeStamina                    ;829D3D;81D061;
                       RTS                                  ;829D41;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;829D42;      ;
                       %Set16bit(!X)                             ;829D44;      ;
                       LDA.B #$00                           ;829D46;      ;
                       XBA                                  ;829D48;      ;
                       LDA.W $096B                          ;829D49;00096B;
                       JSR.W CODE_8292D6                    ;829D4C;8292D6;
                       BNE CODE_829D54                      ;829D4F;829D54;
                       JMP.W CODE_829E6E                    ;829D51;829E6E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D54: %Set8bit(!M)                             ;829D54;      ;
                       LDA.L !season                        ;829D56;7F1F19;
                       CMP.B #$03                           ;829D5A;      ;
                       BNE CODE_829D61                      ;829D5C;829D61;
                       JMP.W CODE_829E8D                    ;829D5E;829E8D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D61: LDA.B !tilemap_to_load                            ;829D61;000022;
                       CMP.B #$04                           ;829D63;      ;
                       BCC CODE_829D7A                      ;829D65;829D7A;
                       %Set16bit(!M)                             ;829D67;      ;
                       CPX.W #$0035                         ;829D69;      ;
                       BEQ CODE_829D73                      ;829D6C;829D73;
                       LDA.W #$00DD                         ;829D6E;      ;
                       BRA CODE_829DE6                      ;829D71;829DE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D73: %Set16bit(!M)                             ;829D73;      ;
                       LDA.W #$00DE                         ;829D75;      ;
                       BRA CODE_829DE6                      ;829D78;829DE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D7A: %Set16bit(!M)                             ;829D7A;      ;
                       CPX.W #$0003                         ;829D7C;      ;
                       BEQ CODE_829D8B                      ;829D7F;829D8B;
                       CPX.W #$0079                         ;829D81;      ;
                       BEQ CODE_829D92                      ;829D84;829D92;
                       LDA.W #$0017                         ;829D86;      ;
                       BRA CODE_829DE6                      ;829D89;829DE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D8B: %Set16bit(!M)                             ;829D8B;      ;
                       LDA.W #$000E                         ;829D8D;      ;
                       BRA CODE_829DE6                      ;829D90;829DE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829D92: %Set16bit(!M)                             ;829D92;      ;
                       LDA.W #$0001                         ;829D94;      ;
                       JSL.L AddGrass                       ;829D97;83B253;
                       %Set16bit(!M)                             ;829D9B;      ;
                       LDA.W $092E                          ;829D9D;00092E;
                       DEC A                                ;829DA0;      ;
                       STA.W $092E                          ;829DA1;00092E;
                       %Set16bit(!M)                             ;829DA4;      ;
                       LDA.W #$0052                         ;829DA6;      ;
                       LDX.W $0985                          ;829DA9;000985;
                       LDY.W $0987                          ;829DAC;000987;
                       JSL.L CODE_81A688                    ;829DAF;81A688;
                       %Set16bit(!M)                             ;829DB3;      ;
                       LDA.W $0985                          ;829DB5;000985;
                       STA.W $0980                          ;829DB8;000980;
                       LDA.W $0987                          ;829DBB;000987;
                       STA.W $0982                          ;829DBE;000982;
                       %Set16bit(!MX)                             ;829DC1;      ;
                       LDA.W #$00C1                         ;829DC3;      ;
                       STA.W $097A                          ;829DC6;00097A;
                       LDA.W #$0000                         ;829DC9;      ;
                       STA.W $097E                          ;829DCC;00097E;
                       %Set8bit(!M)                             ;829DCF;      ;
                       LDA.B #$03                           ;829DD1;      ;
                       STA.W $0974                          ;829DD3;000974;
                       LDA.B #$00                           ;829DD6;      ;
                       STA.W $0975                          ;829DD8;000975;
                       LDA.B #$00                           ;829DDB;      ;
                       STA.W $0976                          ;829DDD;000976;
                       JSL.L CODE_81A500                    ;829DE0;81A500;
                       BRA CODE_829E21                      ;829DE4;829E21;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829DE6: LDX.W $0985                          ;829DE6;000985;
                       LDY.W $0987                          ;829DE9;000987;
                       JSL.L CODE_81A688                    ;829DEC;81A688;
                       %Set16bit(!M)                             ;829DF0;      ;
                       LDA.W $0985                          ;829DF2;000985;
                       STA.W $0980                          ;829DF5;000980;
                       LDA.W $0987                          ;829DF8;000987;
                       STA.W $0982                          ;829DFB;000982;
                       %Set16bit(!MX)                             ;829DFE;      ;
                       LDA.W #$00B7                         ;829E00;      ;
                       STA.W $097A                          ;829E03;00097A;
                       LDA.W #$0000                         ;829E06;      ;
                       STA.W $097E                          ;829E09;00097E;
                       %Set8bit(!M)                             ;829E0C;      ;
                       LDA.B #$03                           ;829E0E;      ;
                       STA.W $0974                          ;829E10;000974;
                       LDA.B #$00                           ;829E13;      ;
                       STA.W $0975                          ;829E15;000975;
                       LDA.B #$00                           ;829E18;      ;
                       STA.W $0976                          ;829E1A;000976;
                       JSL.L CODE_81A500                    ;829E1D;81A500;
                                                            ;      ;      ;
          CODE_829E21: %Set8bit(!M)                             ;829E21;      ;
                       LDA.L !season                        ;829E23;7F1F19;
                       CMP.B #$01                           ;829E27;      ;
                       BNE CODE_829E6E                      ;829E29;829E6E;
                       %Set16bit(!M)                             ;829E2B;      ;
                       LDA.L $7F1F60                        ;829E2D;7F1F60;
                       AND.W #$0008                         ;829E31;      ;
                       BNE CODE_829E6E                      ;829E34;829E6E;
                       LDA.L $7F1F5A                        ;829E36;7F1F5A;
                       AND.W #$2000                         ;829E3A;      ;
                       BNE CODE_829E6E                      ;829E3D;829E6E;
                       %Set8bit(!M)                             ;829E3F;      ;
                       LDA.B #$10                           ;829E41;      ;
                       JSL.L RNGReturn0toA                  ;829E43;8089F9;
                       BNE CODE_829E6E                      ;829E47;829E6E;
                       %Set16bit(!MX)                             ;829E49;      ;
                       LDA.W #$0012                         ;829E4B;      ;
                       LDX.W #$0000                         ;829E4E;      ;
                       LDY.W #$0032                         ;829E51;      ;
                       JSL.L CODE_8480F8                    ;829E54;8480F8;
                       %Set16bit(!MX)                             ;829E58;      ;
                       LDA.W #$0002                         ;829E5A;      ;
                       JSL.L AddPlayerHappiness                   ;829E5D;83B282;
                       %Set16bit(!M)                             ;829E61;      ;
                       LDA.L $7F1F5A                        ;829E63;7F1F5A;
                       ORA.W #$2000                         ;829E67;      ;
                       STA.L $7F1F5A                        ;829E6A;7F1F5A;
                                                            ;      ;      ;
          CODE_829E6E: %Set8bit(!M)                             ;829E6E;      ;
                       LDA.W $096B                          ;829E70;00096B;
                       INC A                                ;829E73;      ;
                       STA.W $096B                          ;829E74;00096B;
                       CMP.B #$09                           ;829E77;      ;
                       BNE CODE_829E8D                      ;829E79;829E8D;
                       STZ.W $096B                          ;829E7B;00096B;
                       %Set16bit(!MX)                             ;829E7E;      ;
                       LDA.W #$0000                         ;829E80;      ;
                       STA.B !player_action                            ;829E83;0000D4;
                       %Set8bit(!M)                             ;829E85;      ;
                       LDA.B #$F8                           ;829E87;      ;
                       JSL.L ChangeStamina                    ;829E89;81D061;
                                                            ;      ;      ;
          CODE_829E8D: RTS                                  ;829E8D;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;829E8E;      ;
                       %Set16bit(!X)                             ;829E90;      ;
                       LDA.B #$00                           ;829E92;      ;
                       XBA                                  ;829E94;      ;
                       LDA.W $096B                          ;829E95;00096B;
                       JSR.W CODE_8292BC                    ;829E98;8292BC;
                       BNE CODE_829EA0                      ;829E9B;829EA0;
                       JMP.W CODE_829FF0                    ;829E9D;829FF0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829EA0: %Set16bit(!M)                             ;829EA0;      ;
                       LDA.W #$0017                         ;829EA2;      ;
                       LDX.W $0985                          ;829EA5;000985;
                       LDY.W $0987                          ;829EA8;000987;
                       JSL.L CODE_81A688                    ;829EAB;81A688;
                       %Set8bit(!M)                             ;829EAF;      ;
                       LDA.L !season                        ;829EB1;7F1F19;
                       CMP.B #$02                           ;829EB5;      ;
                       BCS CODE_829EF8                      ;829EB7;829EF8;
                       %Set16bit(!M)                             ;829EB9;      ;
                       %Set16bit(!M)                             ;829EBB;      ;
                       LDA.L $7F1F60                        ;829EBD;7F1F60;
                       AND.W #$0008                         ;829EC1;      ;
                       BNE CODE_829EF8                      ;829EC4;829EF8;
                       LDA.L $7F1F5A                        ;829EC6;7F1F5A;
                       AND.W #$1000                         ;829ECA;      ;
                       BNE CODE_829EF8                      ;829ECD;829EF8;
                       %Set8bit(!M)                             ;829ECF;      ;
                       LDA.B #$20                           ;829ED1;      ;
                       JSL.L RNGReturn0toA                  ;829ED3;8089F9;
                       BNE CODE_829EF8                      ;829ED7;829EF8;
                       %Set16bit(!MX)                             ;829ED9;      ;
                       LDA.W #$0011                         ;829EDB;      ;
                       LDX.W #$0000                         ;829EDE;      ;
                       LDY.W #$0030                         ;829EE1;      ;
                       JSL.L CODE_8480F8                    ;829EE4;8480F8;
                       %Set16bit(!M)                             ;829EE8;      ;
                       LDA.L $7F1F5A                        ;829EEA;7F1F5A;
                       ORA.W #$1000                         ;829EEE;      ;
                       STA.L $7F1F5A                        ;829EF1;7F1F5A;
                       JMP.W CODE_829FE3                    ;829EF5;829FE3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829EF8: %Set16bit(!MX)                             ;829EF8;      ;
                       LDA.L $7F1F60                        ;829EFA;7F1F60;
                       AND.W #$0008                         ;829EFE;      ;
                       BNE CODE_829F7D                      ;829F01;829F7D;
                       LDA.L $7F1F5C                        ;829F03;7F1F5C;
                       AND.W #$0200                         ;829F07;      ;
                       BNE CODE_829F7D                      ;829F0A;829F7D;
                       %Set8bit(!M)                             ;829F0C;      ;
                       LDA.B #$10                           ;829F0E;      ;
                       JSL.L RNGReturn0toA                  ;829F10;8089F9;
                       BNE CODE_829F44                      ;829F14;829F44;
                       %Set16bit(!MX)                             ;829F16;      ;
                       LDA.L $7F1F5C                        ;829F18;7F1F5C;
                       ORA.W #$0200                         ;829F1C;      ;
                       STA.L $7F1F5C                        ;829F1F;7F1F5C;
                       LDA.W #$000F                         ;829F23;      ;
                       LDX.W #$0000                         ;829F26;      ;
                       LDY.W #$003A                         ;829F29;      ;
                       JSL.L CODE_8480F8                    ;829F2C;8480F8;
                       %Set16bit(!M)                             ;829F30;      ;
                       LDA.W #$0001                         ;829F32;      ;
                       STA.B $72                            ;829F35;000072;
                       %Set8bit(!M)                             ;829F37;      ;
                       LDA.B #$00                           ;829F39;      ;
                       STA.B $74                            ;829F3B;000074;
                       JSL.L AddMoney                       ;829F3D;83B1C9;
                       JMP.W CODE_829FE3                    ;829F41;829FE3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829F44: %Set8bit(!M)                             ;829F44;      ;
                       LDA.B #$10                           ;829F46;      ;
                       JSL.L RNGReturn0toA                  ;829F48;8089F9;
                       BNE CODE_829F7D                      ;829F4C;829F7D;
                       %Set16bit(!MX)                             ;829F4E;      ;
                       LDA.L $7F1F5C                        ;829F50;7F1F5C;
                       ORA.W #$0200                         ;829F54;      ;
                       STA.L $7F1F5C                        ;829F57;7F1F5C;
                       %Set16bit(!MX)                             ;829F5B;      ;
                       LDA.W #$000F                         ;829F5D;      ;
                       LDX.W #$0000                         ;829F60;      ;
                       LDY.W #$003B                         ;829F63;      ;
                       JSL.L CODE_8480F8                    ;829F66;8480F8;
                       %Set16bit(!M)                             ;829F6A;      ;
                       LDA.W #$0005                         ;829F6C;      ;
                       STA.B $72                            ;829F6F;000072;
                       %Set8bit(!M)                             ;829F71;      ;
                       LDA.B #$00                           ;829F73;      ;
                       STA.B $74                            ;829F75;000074;
                       JSL.L AddMoney                       ;829F77;83B1C9;
                       BRA CODE_829FE3                      ;829F7B;829FE3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829F7D: %Set8bit(!M)                             ;829F7D;      ;
                       LDA.B #$40                           ;829F7F;      ;
                       JSL.L RNGReturn0toA                  ;829F81;8089F9;
                       BNE CODE_829FE3                      ;829F85;829FE3;
                       %Set16bit(!MX)                             ;829F87;      ;
                       LDA.L $7F1F60                        ;829F89;7F1F60;
                       AND.W #$0008                         ;829F8D;      ;
                       BNE CODE_829FE3                      ;829F90;829FE3;
                       LDA.L $7F1F5C                        ;829F92;7F1F5C;
                       AND.W #$0100                         ;829F96;      ;
                       BNE CODE_829FE3                      ;829F99;829FE3;
                       LDA.L $7F1F5C                        ;829F9B;7F1F5C;
                       ORA.W #$0100                         ;829F9F;      ;
                       STA.L $7F1F5C                        ;829FA2;7F1F5C;
                       LDA.L $7F1F64                        ;829FA6;7F1F64;
                       AND.W #$0800                         ;829FAA;      ;
                       BNE CODE_829FBC                      ;829FAD;829FBC;
                       LDA.L $7F1F64                        ;829FAF;7F1F64;
                       ORA.W #$0800                         ;829FB3;      ;
                       STA.L $7F1F64                        ;829FB6;7F1F64;
                       BRA CODE_829FD2                      ;829FBA;829FD2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829FBC: %Set16bit(!MX)                             ;829FBC;      ;
                       LDA.L $7F1F64                        ;829FBE;7F1F64;
                       AND.W #$1000                         ;829FC2;      ;
                       BNE CODE_829FE3                      ;829FC5;829FE3;
                       LDA.L $7F1F64                        ;829FC7;7F1F64;
                       ORA.W #$1000                         ;829FCB;      ;
                       STA.L $7F1F64                        ;829FCE;7F1F64;
                                                            ;      ;      ;
          CODE_829FD2: %Set16bit(!MX)                             ;829FD2;      ;
                       LDA.W #$0010                         ;829FD4;      ;
                       LDX.W #$0000                         ;829FD7;      ;
                       LDY.W #$001F                         ;829FDA;      ;
                       JSL.L CODE_8480F8                    ;829FDD;8480F8;
                       BRA CODE_829FE3                      ;829FE1;829FE3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_829FE3: %Set8bit(!M)                             ;829FE3;      ;
                       LDA.W $096B                          ;829FE5;00096B;
                       INC A                                ;829FE8;      ;
                       STA.W $096B                          ;829FE9;00096B;
                       CMP.B #$06                           ;829FEC;      ;
                       BNE CODE_82A004                      ;829FEE;82A004;
                                                            ;      ;      ;
          CODE_829FF0: %Set8bit(!M)                             ;829FF0;      ;
                       STZ.W $096B                          ;829FF2;00096B;
                       %Set16bit(!MX)                             ;829FF5;      ;
                       LDA.W #$0000                         ;829FF7;      ;
                       STA.B !player_action                            ;829FFA;0000D4;
                       %Set8bit(!M)                             ;829FFC;      ;
                       LDA.B #$F8                           ;829FFE;      ;
                       JSL.L ChangeStamina                    ;82A000;81D061;
                                                            ;      ;      ;
          CODE_82A004: RTS                                  ;82A004;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82A005;      ;
                       JSR.W CODE_8292A0                    ;82A007;8292A0;
                       BNE CODE_82A00F                      ;82A00A;82A00F;
                       JMP.W CODE_82A141                    ;82A00C;82A141;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A00F: CPX.W #$0006                         ;82A00F;      ;
                       BEQ CODE_82A07B                      ;82A012;82A07B;
                       CPX.W #$0004                         ;82A014;      ;
                       BEQ CODE_82A01C                      ;82A017;82A01C;
                       JMP.W CODE_82A08D                    ;82A019;82A08D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A01C: %Set8bit(!M)                             ;82A01C;      ;
                       LDA.B !tilemap_to_load                            ;82A01E;000022;
                       CMP.B #$04                           ;82A020;      ;
                       BCC CODE_82A038                      ;82A022;82A038;
                       LDA.B !tilemap_to_load                            ;82A024;000022;
                       CMP.B #$29                           ;82A026;      ;
                       BCS CODE_82A031                      ;82A028;82A031;
                       %Set16bit(!M)                             ;82A02A;      ;
                       LDA.W #$00DD                         ;82A02C;      ;
                       BRA CODE_82A03D                      ;82A02F;82A03D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A031: %Set16bit(!M)                             ;82A031;      ;
                       LDA.W #$00E3                         ;82A033;      ;
                       BRA CODE_82A03D                      ;82A036;82A03D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A038: %Set16bit(!M)                             ;82A038;      ;
                       LDA.W #$000E                         ;82A03A;      ;
                                                            ;      ;      ;
          CODE_82A03D: LDX.W $0985                          ;82A03D;000985;
                       LDY.W $0987                          ;82A040;000987;
                       JSL.L CODE_81A688                    ;82A043;81A688;
                       %Set16bit(!M)                             ;82A047;      ;
                       LDA.W $0985                          ;82A049;000985;
                       STA.W $0980                          ;82A04C;000980;
                       LDA.W $0987                          ;82A04F;000987;
                       STA.W $0982                          ;82A052;000982;
                       %Set16bit(!MX)                             ;82A055;      ;
                       LDA.W #$00C8                         ;82A057;      ;
                       STA.W $097A                          ;82A05A;00097A;
                       LDA.W #$0000                         ;82A05D;      ;
                       STA.W $097E                          ;82A060;00097E;
                       %Set8bit(!M)                             ;82A063;      ;
                       LDA.B #$03                           ;82A065;      ;
                       STA.W $0974                          ;82A067;000974;
                       LDA.B #$00                           ;82A06A;      ;
                       STA.W $0975                          ;82A06C;000975;
                       LDA.B #$00                           ;82A06F;      ;
                       STA.W $0976                          ;82A071;000976;
                       JSL.L CODE_81A500                    ;82A074;81A500;
                       JMP.W CODE_82A131                    ;82A078;82A131;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A07B: %Set16bit(!M)                             ;82A07B;      ;
                       LDA.W #$000E                         ;82A07D;      ;
                       LDX.W $0985                          ;82A080;000985;
                       LDY.W $0987                          ;82A083;000987;
                       JSL.L CODE_81A688                    ;82A086;81A688;
                       JMP.W CODE_82A131                    ;82A08A;82A131;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A08D: %Set16bit(!M)                             ;82A08D;      ;
                       LDA.W $0985                          ;82A08F;000985;
                       SEC                                  ;82A092;      ;
                       SBC.W #$0010                         ;82A093;      ;
                       STA.W $0985                          ;82A096;000985;
                       LDA.W $0987                          ;82A099;000987;
                       SEC                                  ;82A09C;      ;
                       SBC.W #$0010                         ;82A09D;      ;
                       STA.W $0987                          ;82A0A0;000987;
                       CPX.W #$0010                         ;82A0A3;      ;
                       BEQ CODE_82A0DA                      ;82A0A6;82A0DA;
                       LDA.W $0985                          ;82A0A8;000985;
                       CLC                                  ;82A0AB;      ;
                       ADC.W #$0010                         ;82A0AC;      ;
                       STA.W $0985                          ;82A0AF;000985;
                       CPX.W #$000F                         ;82A0B2;      ;
                       BEQ CODE_82A0DA                      ;82A0B5;82A0DA;
                       LDA.W $0985                          ;82A0B7;000985;
                       SEC                                  ;82A0BA;      ;
                       SBC.W #$0010                         ;82A0BB;      ;
                       STA.W $0985                          ;82A0BE;000985;
                       LDA.W $0987                          ;82A0C1;000987;
                       CLC                                  ;82A0C4;      ;
                       ADC.W #$0010                         ;82A0C5;      ;
                       STA.W $0987                          ;82A0C8;000987;
                       CPX.W #$000E                         ;82A0CB;      ;
                       BEQ CODE_82A0DA                      ;82A0CE;82A0DA;
                       LDA.W $0985                          ;82A0D0;000985;
                       CLC                                  ;82A0D3;      ;
                       ADC.W #$0010                         ;82A0D4;      ;
                       STA.W $0985                          ;82A0D7;000985;
                                                            ;      ;      ;
          CODE_82A0DA: %Set8bit(!M)                             ;82A0DA;      ;
                       LDA.B !tilemap_to_load                            ;82A0DC;000022;
                       CMP.B #$04                           ;82A0DE;      ;
                       BCC CODE_82A0E9                      ;82A0E0;82A0E9;
                       %Set16bit(!M)                             ;82A0E2;      ;
                       LDA.W #$00DF                         ;82A0E4;      ;
                       BRA CODE_82A0EE                      ;82A0E7;82A0EE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A0E9: %Set16bit(!M)                             ;82A0E9;      ;
                       LDA.W #$000D                         ;82A0EB;      ;
                                                            ;      ;      ;
          CODE_82A0EE: LDX.W $0985                          ;82A0EE;000985;
                       LDY.W $0987                          ;82A0F1;000987;
                       JSL.L CODE_81A688                    ;82A0F4;81A688;
                       %Set16bit(!M)                             ;82A0F8;      ;
                       LDA.W $0985                          ;82A0FA;000985;
                       CLC                                  ;82A0FD;      ;
                       ADC.W #$0008                         ;82A0FE;      ;
                       STA.W $0980                          ;82A101;000980;
                       LDA.W $0987                          ;82A104;000987;
                       CLC                                  ;82A107;      ;
                       ADC.W #$0008                         ;82A108;      ;
                       STA.W $0982                          ;82A10B;000982;
                       %Set16bit(!MX)                             ;82A10E;      ;
                       LDA.W #$00C9                         ;82A110;      ;
                       STA.W $097A                          ;82A113;00097A;
                       LDA.W #$0000                         ;82A116;      ;
                       STA.W $097E                          ;82A119;00097E;
                       %Set8bit(!M)                             ;82A11C;      ;
                       LDA.B #$03                           ;82A11E;      ;
                       STA.W $0974                          ;82A120;000974;
                       LDA.B #$00                           ;82A123;      ;
                       STA.W $0975                          ;82A125;000975;
                       LDA.B #$00                           ;82A128;      ;
                       STA.W $0976                          ;82A12A;000976;
                       JSL.L CODE_81A500                    ;82A12D;81A500;
                                                            ;      ;      ;
          CODE_82A131: %Set16bit(!MX)                             ;82A131;      ;
                       LDA.W #$0000                         ;82A133;      ;
                       STA.B !player_action                            ;82A136;0000D4;
                       %Set8bit(!M)                             ;82A138;      ;
                       LDA.B #$FC                           ;82A13A;      ;
                       JSL.L ChangeStamina                    ;82A13C;81D061;
                       RTS                                  ;82A140;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A141: %Set8bit(!M)                             ;82A141;      ;
                       %Set16bit(!X)                             ;82A143;      ;
                       LDA.B !tilemap_to_load                            ;82A145;000022;
                       CMP.B #$0C                           ;82A147;      ;
                       BCC CODE_82A131                      ;82A149;82A131;
                       CMP.B #$10                           ;82A14B;      ;
                       BCS CODE_82A131                      ;82A14D;82A131;
                       CPX.W #$00F8                         ;82A14F;      ;
                       BNE CODE_82A131                      ;82A152;82A131;
                       %Set16bit(!MX)                             ;82A154;      ;
                       LDA.L $7F1F5C                        ;82A156;7F1F5C;
                       AND.W #$0080                         ;82A15A;      ;
                       BNE CODE_82A131                      ;82A15D;82A131;
                       %Set16bit(!M)                             ;82A15F;      ;
                       LDA.W #$0015                         ;82A161;      ;
                       LDX.W #$0000                         ;82A164;      ;
                       LDY.W #$0016                         ;82A167;      ;
                       JSL.L CODE_84803F                    ;82A16A;84803F;
                       %Set8bit(!M)                             ;82A16E;      ;
                       LDA.B #$04                           ;82A170;      ;
                       JSL.L RNGReturn0toA                  ;82A172;8089F9;
                       BNE CODE_82A131                      ;82A176;82A131;
                       %Set16bit(!MX)                             ;82A178;      ;
                       LDA.L $7F1F64                        ;82A17A;7F1F64;
                       AND.W #$0200                         ;82A17E;      ;
                       BNE CODE_82A131                      ;82A181;82A131;
                       LDA.L $7F1F64                        ;82A183;7F1F64;
                       ORA.W #$0200                         ;82A187;      ;
                       STA.L $7F1F64                        ;82A18A;7F1F64;
                       %Set16bit(!MX)                             ;82A18E;      ;
                       LDA.B !player_pos_X                           ;82A190;0000D6;
                       CLC                                  ;82A192;      ;
                       ADC.W #$0010                         ;82A193;      ;
                       STA.W $0985                          ;82A196;000985;
                       LDA.B !player_pos_Y                            ;82A199;0000D8;
                       SEC                                  ;82A19B;      ;
                       SBC.W #$0010                         ;82A19C;      ;
                       STA.W $0987                          ;82A19F;000987;
                       LDA.W #$0010                         ;82A1A2;      ;
                       LDX.W #$0000                         ;82A1A5;      ;
                       LDY.W #$001F                         ;82A1A8;      ;
                       JSL.L CODE_8480F8                    ;82A1AB;8480F8;
                       %Set16bit(!MX)                             ;82A1AF;      ;
                       LDA.L $7F1F5C                        ;82A1B1;7F1F5C;
                       ORA.W #$0080                         ;82A1B5;      ;
                       STA.L $7F1F5C                        ;82A1B8;7F1F5C;
                       JMP.W CODE_82A131                    ;82A1BC;82A131;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82A1BF;      ;
                       JSR.W CODE_8292A0                    ;82A1C1;8292A0;
                       BNE CODE_82A1C9                      ;82A1C4;82A1C9;
                       JMP.W CODE_82A2F7                    ;82A1C6;82A2F7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A1C9: %Set16bit(!M)                             ;82A1C9;      ;
                       LDA.W $0985                          ;82A1CB;000985;
                       SEC                                  ;82A1CE;      ;
                       SBC.W #$0010                         ;82A1CF;      ;
                       STA.W $0985                          ;82A1D2;000985;
                       LDA.W $0987                          ;82A1D5;000987;
                       SEC                                  ;82A1D8;      ;
                       SBC.W #$0010                         ;82A1D9;      ;
                       STA.W $0987                          ;82A1DC;000987;
                       CPX.W #$000C                         ;82A1DF;      ;
                       BEQ CODE_82A235                      ;82A1E2;82A235;
                       CPX.W #$0014                         ;82A1E4;      ;
                       BNE CODE_82A1EC                      ;82A1E7;82A1EC;
                       JMP.W CODE_82A29D                    ;82A1E9;82A29D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A1EC: LDA.W $0985                          ;82A1EC;000985;
                       CLC                                  ;82A1EF;      ;
                       ADC.W #$0010                         ;82A1F0;      ;
                       STA.W $0985                          ;82A1F3;000985;
                       CPX.W #$000B                         ;82A1F6;      ;
                       BEQ CODE_82A235                      ;82A1F9;82A235;
                       CPX.W #$0013                         ;82A1FB;      ;
                       BNE CODE_82A203                      ;82A1FE;82A203;
                       JMP.W CODE_82A29D                    ;82A200;82A29D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A203: LDA.W $0985                          ;82A203;000985;
                       SEC                                  ;82A206;      ;
                       SBC.W #$0010                         ;82A207;      ;
                       STA.W $0985                          ;82A20A;000985;
                       LDA.W $0987                          ;82A20D;000987;
                       CLC                                  ;82A210;      ;
                       ADC.W #$0010                         ;82A211;      ;
                       STA.W $0987                          ;82A214;000987;
                       CPX.W #$000A                         ;82A217;      ;
                       BEQ CODE_82A235                      ;82A21A;82A235;
                       CPX.W #$0012                         ;82A21C;      ;
                       BEQ CODE_82A29D                      ;82A21F;82A29D;
                       LDA.W $0985                          ;82A221;000985;
                       CLC                                  ;82A224;      ;
                       ADC.W #$0010                         ;82A225;      ;
                       STA.W $0985                          ;82A228;000985;
                       CPX.W #$0009                         ;82A22B;      ;
                       BEQ CODE_82A235                      ;82A22E;82A235;
                       CPX.W #$0011                         ;82A230;      ;
                       BEQ CODE_82A29D                      ;82A233;82A29D;
                                                            ;      ;      ;
          CODE_82A235: %Set8bit(!M)                             ;82A235;      ;
                       LDA.B !tilemap_to_load                            ;82A237;000022;
                       CMP.B #$04                           ;82A239;      ;
                       BCC CODE_82A2A4                      ;82A23B;82A2A4;
                       %Set8bit(!M)                             ;82A23D;      ;
                       LDA.B #$10                           ;82A23F;      ;
                       JSL.L RNGReturn0toA                  ;82A241;8089F9;
                       BNE CODE_82A296                      ;82A245;82A296;
                       %Set16bit(!MX)                             ;82A247;      ;
                       LDA.L $7F1F64                        ;82A249;7F1F64;
                       AND.W #$0400                         ;82A24D;      ;
                       BNE CODE_82A296                      ;82A250;82A296;
                       LDA.L $7F1F64                        ;82A252;7F1F64;
                       ORA.W #$0400                         ;82A256;      ;
                       STA.L $7F1F64                        ;82A259;7F1F64;
                       %Set16bit(!MX)                             ;82A25D;      ;
                       LDA.W $0985                          ;82A25F;000985;
                       CLC                                  ;82A262;      ;
                       ADC.W #$0008                         ;82A263;      ;
                       STA.W $0985                          ;82A266;000985;
                       LDA.W $0987                          ;82A269;000987;
                       CLC                                  ;82A26C;      ;
                       ADC.W #$0008                         ;82A26D;      ;
                       STA.W $0987                          ;82A270;000987;
                       LDA.W #$0010                         ;82A273;      ;
                       LDX.W #$0000                         ;82A276;      ;
                       LDY.W #$001F                         ;82A279;      ;
                       JSL.L CODE_8480F8                    ;82A27C;8480F8;
                       %Set16bit(!MX)                             ;82A280;      ;
                       LDA.W $0985                          ;82A282;000985;
                       SEC                                  ;82A285;      ;
                       SBC.W #$0008                         ;82A286;      ;
                       STA.W $0985                          ;82A289;000985;
                       LDA.W $0987                          ;82A28C;000987;
                       SEC                                  ;82A28F;      ;
                       SBC.W #$0008                         ;82A290;      ;
                       STA.W $0987                          ;82A293;000987;
                                                            ;      ;      ;
          CODE_82A296: %Set16bit(!MX)                             ;82A296;      ;
                       LDA.W #$00DF                         ;82A298;      ;
                       BRA CODE_82A2A9                      ;82A29B;82A2A9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A29D: %Set16bit(!MX)                             ;82A29D;      ;
                       LDA.W #$00E0                         ;82A29F;      ;
                       BRA CODE_82A2A9                      ;82A2A2;82A2A9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A2A4: %Set16bit(!MX)                             ;82A2A4;      ;
                       LDA.W #$000D                         ;82A2A6;      ;
                                                            ;      ;      ;
          CODE_82A2A9: %Set16bit(!MX)                             ;82A2A9;      ;
                       LDX.W $0985                          ;82A2AB;000985;
                       LDY.W $0987                          ;82A2AE;000987;
                       JSL.L CODE_81A688                    ;82A2B1;81A688;
                       %Set16bit(!M)                             ;82A2B5;      ;
                       LDA.W $0985                          ;82A2B7;000985;
                       CLC                                  ;82A2BA;      ;
                       ADC.W #$0008                         ;82A2BB;      ;
                       STA.W $0980                          ;82A2BE;000980;
                       LDA.W $0987                          ;82A2C1;000987;
                       CLC                                  ;82A2C4;      ;
                       ADC.W #$0008                         ;82A2C5;      ;
                       STA.W $0982                          ;82A2C8;000982;
                       %Set16bit(!MX)                             ;82A2CB;      ;
                       LDA.W #$00B8                         ;82A2CD;      ;
                       STA.W $097A                          ;82A2D0;00097A;
                       LDA.W #$0000                         ;82A2D3;      ;
                       STA.W $097E                          ;82A2D6;00097E;
                       %Set8bit(!M)                             ;82A2D9;      ;
                       LDA.B #$03                           ;82A2DB;      ;
                       STA.W $0974                          ;82A2DD;000974;
                       LDA.B #$00                           ;82A2E0;      ;
                       STA.W $0975                          ;82A2E2;000975;
                       LDA.B #$00                           ;82A2E5;      ;
                       STA.W $0976                          ;82A2E7;000976;
                       JSL.L CODE_81A500                    ;82A2EA;81A500;
                       %Set16bit(!M)                             ;82A2EE;      ;
                       LDA.W #$0006                         ;82A2F0;      ;
                       JSL.L AddWood                        ;82A2F3;83B224;
                                                            ;      ;      ;
          CODE_82A2F7: %Set16bit(!MX)                             ;82A2F7;      ;
                       LDA.W #$0000                         ;82A2F9;      ;
                       STA.B !player_action                            ;82A2FC;0000D4;
                       %Set8bit(!M)                             ;82A2FE;      ;
                       LDA.B #$F8                           ;82A300;      ;
                       JSL.L ChangeStamina                    ;82A302;81D061;
                       RTS                                  ;82A306;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82A307;      ;
                       %Set16bit(!X)                             ;82A309;      ;
                       %Set8bit(!M)                             ;82A30B;      ;
                       %Set16bit(!X)                             ;82A30D;      ;
                       LDA.B #$00                           ;82A30F;      ;
                       STA.W $0114                          ;82A311;000114;
                       LDA.B #$07                           ;82A314;      ;
                       STA.W $0115                          ;82A316;000115;
                       JSL.L UNK_Audio19                    ;82A319;838332;
                       %Set8bit(!M)                             ;82A31D;      ;
                       LDA.B #$00                           ;82A31F;      ;
                       XBA                                  ;82A321;      ;
                       LDA.W $096B                          ;82A322;00096B;
                       JSR.W CODE_8292D6                    ;82A325;8292D6;
                       BNE CODE_82A32D                      ;82A328;82A32D;
                       JMP.W CODE_82A357                    ;82A32A;82A357;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A32D: %Set16bit(!MX)                             ;82A32D;      ;
                       TXA                                  ;82A32F;      ;
                       INC A                                ;82A330;      ;
                       PHA                                  ;82A331;      ;
                       %Set8bit(!M)                             ;82A332;      ;
                       LDX.W $0985                          ;82A334;000985;
                       LDY.W $0987                          ;82A337;000987;
                       JSL.L UNK_MOVE_FROM_SEASON_TO_09B6                    ;82A33A;82B03A;
                       %Set16bit(!M)                             ;82A33E;      ;
                       PLA                                  ;82A340;      ;
                       ASL A                                ;82A341;      ;
                       ASL A                                ;82A342;      ;
                       TAY                                  ;82A343;      ;
                       %Set8bit(!M)                             ;82A344;      ;
                       LDA.B #$00                           ;82A346;      ;
                       XBA                                  ;82A348;      ;
                       LDA.B [$0D],Y                        ;82A349;00000D;
                       %Set16bit(!M)                             ;82A34B;      ;
                       LDX.W $0985                          ;82A34D;000985;
                       LDY.W $0987                          ;82A350;000987;
                       JSL.L CODE_81A688                    ;82A353;81A688;
                                                            ;      ;      ;
          CODE_82A357: %Set8bit(!M)                             ;82A357;      ;
                       LDA.W $096B                          ;82A359;00096B;
                       INC A                                ;82A35C;      ;
                       STA.W $096B                          ;82A35D;00096B;
                       CMP.B #$09                           ;82A360;      ;
                       BNE CODE_82A376                      ;82A362;82A376;
                       STZ.W $096B                          ;82A364;00096B;
                       %Set16bit(!MX)                             ;82A367;      ;
                       LDA.W #$0000                         ;82A369;      ;
                       STA.B !player_action                            ;82A36C;0000D4;
                       %Set8bit(!M)                             ;82A36E;      ;
                       LDA.B #$F8                           ;82A370;      ;
                       JSL.L ChangeStamina                    ;82A372;81D061;
                                                            ;      ;      ;
          CODE_82A376: RTS                                  ;82A376;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82A377;      ;
                       %Set16bit(!X)                             ;82A379;      ;
                       LDA.L !hour                        ;82A37B;7F1F1C;
                       CMP.B #$11                           ;82A37F;      ;
                       BCS CODE_82A3A2                      ;82A381;82A3A2;
                       LDA.B !tilemap_to_load                            ;82A383;000022;
                       CMP.B #$31                           ;82A385;      ;
                       BNE CODE_82A3A2                      ;82A387;82A3A2;
                       %Set16bit(!MX)                             ;82A389;      ;
                       LDA.L $7F1F68                        ;82A38B;7F1F68;
                       ORA.W #$0200                         ;82A38F;      ;
                       STA.L $7F1F68                        ;82A392;7F1F68;
                       LDA.W #$0042                         ;82A396;      ;
                       JSL.L CODE_81A5E1                    ;82A399;81A5E1;
                       %Set8bit(!M)                             ;82A39D;      ;
                       STZ.W !tool_selected                          ;82A39F;000921;
                                                            ;      ;      ;
          CODE_82A3A2: %Set16bit(!MX)                             ;82A3A2;      ;
                       LDA.W #$0000                         ;82A3A4;      ;
                       STA.B !player_action                            ;82A3A7;0000D4;
                       RTS                                  ;82A3A9;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82A3AA;      ;
                       %Set16bit(!X)                             ;82A3AC;      ;
                       LDA.L !hour                        ;82A3AE;7F1F1C;
                       CMP.B #$11                           ;82A3B2;      ;
                       BCS CODE_82A3F5                      ;82A3B4;82A3F5;
                       LDA.B !tilemap_to_load                            ;82A3B6;000022;
                       CMP.B #$34                           ;82A3B8;      ;
                       BNE CODE_82A3F5                      ;82A3BA;82A3F5;
                       %Set16bit(!MX)                             ;82A3BC;      ;
                       LDA.W #$0001                         ;82A3BE;      ;
                       LDX.W #$0000                         ;82A3C1;      ;
                       LDY.W #$0000                         ;82A3C4;      ;
                       JSL.L CODE_81D14E                    ;82A3C7;81D14E;
                       %Set16bit(!MX)                             ;82A3CB;      ;
                       LDX.W $0985                          ;82A3CD;000985;
                       LDY.W $0987                          ;82A3D0;000987;
                       LDA.W #$0000                         ;82A3D3;      ;
                       JSL.L CGGGG                          ;82A3D6;82AC61;
                       %Set16bit(!MX)                             ;82A3DA;      ;
                       CPX.W #$00F6                         ;82A3DC;      ;
                       BNE CODE_82A3F5                      ;82A3DF;82A3F5;
                       %Set16bit(!MX)                             ;82A3E1;      ;
                       LDA.W #$0000                         ;82A3E3;      ;
                       LDX.W #$0012                         ;82A3E6;      ;
                       LDY.W #$0000                         ;82A3E9;      ;
                       JSL.L VIP                            ;82A3EC;848097;
                       %Set8bit(!M)                             ;82A3F0;      ;
                       STZ.W !tool_selected                          ;82A3F2;000921;
                                                            ;      ;      ;
          CODE_82A3F5: %Set16bit(!MX)                             ;82A3F5;      ;
                       LDA.W #$0000                         ;82A3F7;      ;
                       STA.B !player_action                            ;82A3FA;0000D4;
                       RTS                                  ;82A3FC;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;82A3FD;      ;
                       %Set16bit(!MX)                             ;82A3FF;      ;
                       LDA.W #$0000                         ;82A401;      ;
                       STA.B !player_action                            ;82A404;0000D4;
                       %Set16bit(!M)                             ;82A406;      ;
                       LDA.L $7F1F5E                        ;82A408;7F1F5E;
                       ORA.W #$0040                         ;82A40C;      ;
                       STA.L $7F1F5E                        ;82A40F;7F1F5E;
                       RTS                                  ;82A413;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82A414;      ;
                       %Set16bit(!X)                             ;82A416;      ;
                       LDA.B !tilemap_to_load                            ;82A418;000022;
                       CMP.B #$28                           ;82A41A;      ;
                       BNE CODE_82A473                      ;82A41C;82A473;
                       %Set16bit(!M)                             ;82A41E;      ;
                       LDA.W #$0001                         ;82A420;      ;
                       LDX.W #$0006                         ;82A423;      ;
                       LDY.W #$0006                         ;82A426;      ;
                       JSL.L CODE_81D14E                    ;82A429;81D14E;
                       %Set16bit(!MX)                             ;82A42D;      ;
                       LDX.W $0985                          ;82A42F;000985;
                       LDY.W $0987                          ;82A432;000987;
                       LDA.W #$0000                         ;82A435;      ;
                       JSL.L CGGGG                          ;82A438;82AC61;
                       CPX.W #$00E2                         ;82A43C;      ;
                       BCC CODE_82A473                      ;82A43F;82A473;
                       CPX.W #$00EF                         ;82A441;      ;
                       BCS CODE_82A473                      ;82A444;82A473;
                       %Set16bit(!M)                             ;82A446;      ;
                       TXA                                  ;82A448;      ;
                       SEC                                  ;82A449;      ;
                       SBC.W #$00E2                         ;82A44A;      ;
                       ASL A                                ;82A44D;      ;
                       TAX                                  ;82A44E;      ;
                       LDA.L Cow_Feed_Flags,X                ;82A44F;82A571;
                       ORA.W !fed_chicks_flags                          ;82A453;000934;
                       STA.W !fed_chicks_flags                          ;82A456;000934;
                       %Set8bit(!M)                             ;82A459;      ;
                       LDA.W !fed_chicks_N                          ;82A45B;000931;
                       INC A                                ;82A45E;      ;
                       STA.W !fed_chicks_N                          ;82A45F;000931;
                       %Set16bit(!M)                             ;82A462;      ;
                       LDA.W #$0099                         ;82A464;      ;
                       LDX.W $0985                          ;82A467;000985;
                       LDY.W $0987                          ;82A46A;000987;
                       JSL.L CODE_81A688                    ;82A46D;81A688;
                       BRA CODE_82A4A4                      ;82A471;82A4A4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A473: %Set16bit(!M)                             ;82A473;      ;
                       LDA.W $0985                          ;82A475;000985;
                       STA.W $0980                          ;82A478;000980;
                       LDA.W $0987                          ;82A47B;000987;
                       STA.W $0982                          ;82A47E;000982;
                       %Set16bit(!MX)                             ;82A481;      ;
                       LDA.W #$00C4                         ;82A483;      ;
                       STA.W $097A                          ;82A486;00097A;
                       LDA.W #$0000                         ;82A489;      ;
                       STA.W $097E                          ;82A48C;00097E;
                       %Set8bit(!M)                             ;82A48F;      ;
                       LDA.B #$03                           ;82A491;      ;
                       STA.W $0974                          ;82A493;000974;
                       LDA.B #$00                           ;82A496;      ;
                       STA.W $0975                          ;82A498;000975;
                       LDA.B #$00                           ;82A49B;      ;
                       STA.W $0976                          ;82A49D;000976;
                       JSL.L CODE_81A500                    ;82A4A0;81A500;
                                                            ;      ;      ;
          CODE_82A4A4: %Set8bit(!M)                             ;82A4A4;      ;
                       LDA.W !feed_chicks_N                          ;82A4A6;00092D;
                       DEC A                                ;82A4A9;      ;
                       STA.W !feed_chicks_N                          ;82A4AA;00092D;
                       BNE CODE_82A4B2                      ;82A4AD;82A4B2;
                       STZ.W !tool_selected                          ;82A4AF;000921;
                                                            ;      ;      ;
          CODE_82A4B2: %Set8bit(!M)                             ;82A4B2;      ;
                       LDA.B #$FE                           ;82A4B4;      ;
                       JSL.L ChangeStamina                    ;82A4B6;81D061;
                       %Set16bit(!MX)                             ;82A4BA;      ;
                       LDA.W #$0000                         ;82A4BC;      ;
                       STA.B !player_action                            ;82A4BF;0000D4;
                       RTS                                  ;82A4C1;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82A4C2;      ;
                       %Set16bit(!X)                             ;82A4C4;      ;
                       LDA.B !tilemap_to_load                            ;82A4C6;000022;
                       CMP.B #$27                           ;82A4C8;      ;
                       BNE CODE_82A521                      ;82A4CA;82A521;
                       %Set16bit(!M)                             ;82A4CC;      ;
                       LDA.W #$0001                         ;82A4CE;      ;
                       LDX.W #$0006                         ;82A4D1;      ;
                       LDY.W #$0006                         ;82A4D4;      ;
                       JSL.L CODE_81D14E                    ;82A4D7;81D14E;
                       %Set16bit(!MX)                             ;82A4DB;      ;
                       LDX.W $0985                          ;82A4DD;000985;
                       LDY.W $0987                          ;82A4E0;000987;
                       LDA.W #$0000                         ;82A4E3;      ;
                       JSL.L CGGGG                          ;82A4E6;82AC61;
                       CPX.W #$00E2                         ;82A4EA;      ;
                       BCC CODE_82A521                      ;82A4ED;82A521;
                       CPX.W #$00EF                         ;82A4EF;      ;
                       BCS CODE_82A521                      ;82A4F2;82A521;
                       %Set16bit(!M)                             ;82A4F4;      ;
                       TXA                                  ;82A4F6;      ;
                       SEC                                  ;82A4F7;      ;
                       SBC.W #$00E2                         ;82A4F8;      ;
                       ASL A                                ;82A4FB;      ;
                       TAX                                  ;82A4FC;      ;
                       LDA.L Cow_Feed_Flags,X                ;82A4FD;82A571;
                       ORA.W !fed_cows_flags                          ;82A501;000932;
                       STA.W !fed_cows_flags                          ;82A504;000932;
                       %Set8bit(!M)                             ;82A507;      ;
                       LDA.W !fed_cows_N                          ;82A509;000930;
                       INC A                                ;82A50C;      ;
                       STA.W !fed_cows_N                          ;82A50D;000930;
                       %Set16bit(!M)                             ;82A510;      ;
                       LDA.W #$0099                         ;82A512;      ;
                       LDX.W $0985                          ;82A515;000985;
                       LDY.W $0987                          ;82A518;000987;
                       JSL.L CODE_81A688                    ;82A51B;81A688;
                       BRA CODE_82A552                      ;82A51F;82A552;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A521: %Set16bit(!M)                             ;82A521;      ;
                       LDA.W $0985                          ;82A523;000985;
                       STA.W $0980                          ;82A526;000980;
                       LDA.W $0987                          ;82A529;000987;
                       STA.W $0982                          ;82A52C;000982;
                       %Set16bit(!MX)                             ;82A52F;      ;
                       LDA.W #$00C4                         ;82A531;      ;
                       STA.W $097A                          ;82A534;00097A;
                       LDA.W #$0000                         ;82A537;      ;
                       STA.W $097E                          ;82A53A;00097E;
                       %Set8bit(!M)                             ;82A53D;      ;
                       LDA.B #$03                           ;82A53F;      ;
                       STA.W $0974                          ;82A541;000974;
                       LDA.B #$00                           ;82A544;      ;
                       STA.W $0975                          ;82A546;000975;
                       LDA.B #$00                           ;82A549;      ;
                       STA.W $0976                          ;82A54B;000976;
                       JSL.L CODE_81A500                    ;82A54E;81A500;
                                                            ;      ;      ;
          CODE_82A552: %Set8bit(!M)                             ;82A552;      ;
                       LDA.W !feed_cow_N                          ;82A554;00092C;
                       DEC A                                ;82A557;      ;
                       STA.W !feed_cow_N                          ;82A558;00092C;
                       BNE CODE_82A560                      ;82A55B;82A560;
                       STZ.W !tool_selected                          ;82A55D;000921;
                                                            ;      ;      ;
          CODE_82A560: %Set16bit(!MX)                             ;82A560;      ;
                       LDA.W #$0000                         ;82A562;      ;
                       STA.B !player_action                            ;82A565;0000D4;
                       %Set8bit(!M)                             ;82A567;      ;
                       LDA.B #$FE                           ;82A569;      ;
                       JSL.L ChangeStamina                    ;82A56B;81D061;
                       RTS                                  ;82A56F;      ;
                                                            ;      ;      ;
                       RTS                                  ;82A570;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
        Cow_Feed_Flags: dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080;82A571;      ;
                       dw $0100,$0200,$0400,$0800,$1000     ;82A581;      ;
                                                            ;      ;      ;
        DATA16_82A58B: dw $90DD,$90DE,$90EC,$90FA,$9108,$9116,$9121,$912C;82A58B;      ;
                       dw $9137,$9142,$9150,$915E,$9179,$9184,$918D,$919B;82A59B;      ;
                       dw $91A9,$91E8,$91F1,$91FD,$9209,$9215,$921E,$922A;82A5AB;      ;
                       dw $9236,$923F,$924B,$9257           ;82A5BB;      ;
                                                            ;      ;      ;
        DATA16_82A5C3: dw $931E,$9328,$9460,$95C0,$97BD,$9999,$99F8,$9A57;82A5C3;      ;
                       dw $9AB4,$9B11,$9B31,$9B51,$9B61,$9BCB,$9CC0,$9CC8;82A5D3;      ;
                       dw $9CD8,$9D42,$9E8E,$A005,$A1BF,$A307,$A377,$A3AA;82A5E3;      ;
                       dw $A3FD,$A414,$A4C2,$A570           ;82A5F3;      ;
                                                            ;      ;      ;
                BSSSS: %Set8bit(!M)                             ;82A5FB;      ;
                       %Set16bit(!X)                             ;82A5FD;      ;
                       LDA.B #$00                           ;82A5FF;      ;
                       XBA                                  ;82A601;      ;
                       LDA.B !tilemap_to_load                            ;82A602;000022;
                       CMP.B #$04                           ;82A604;      ;
                       BCS CODE_82A61B                      ;82A606;82A61B;
                       %Set16bit(!M)                             ;82A608;      ;
                       LDA.W #$A4E6                         ;82A60A;      ;
                       STA.B $72                            ;82A60D;000072;
                       %Set8bit(!M)                             ;82A60F;      ;
                       LDA.B #$7E                           ;82A611;      ;
                       STA.B $74                            ;82A613;000074;
                       LDX.W #$0000                         ;82A615;      ;
                       PHX                                  ;82A618;      ;
                       BRA CODE_82A635                      ;82A619;82A635;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A61B: %Set8bit(!M)                             ;82A61B;      ;
                       ASL A                                ;82A61D;      ;
                       CLC                                  ;82A61E;      ;
                       ADC.B !tilemap_to_load                            ;82A61F;000022;
                       %Set16bit(!M)                             ;82A621;      ;
                       TAX                                  ;82A623;      ;
                       PHX                                  ;82A624;      ;
                       LDA.L FarmMapPointerTable,X            ;82A625;82B174;
                       STA.B $72                            ;82A629;000072;
                       %Set8bit(!M)                             ;82A62B;      ;
                       INX                                  ;82A62D;      ;
                       INX                                  ;82A62E;      ;
                       LDA.L FarmMapPointerTable,X            ;82A62F;82B174;
                       STA.B $74                            ;82A633;000074;
                                                            ;      ;      ;
          CODE_82A635: %Set16bit(!MX)                             ;82A635;      ;
                       PLX                                  ;82A637;      ;
                       LDA.L DATA8_82B294,X                 ;82A638;82B294;
                       STA.B $0D                            ;82A63C;00000D;
                       INX                                  ;82A63E;      ;
                       INX                                  ;82A63F;      ;
                       %Set8bit(!M)                             ;82A640;      ;
                       LDA.L DATA8_82B294,X                 ;82A642;82B294;
                       STA.B $0F                            ;82A646;00000F;
                       %Set8bit(!M)                             ;82A648;      ;
                       LDY.W #$0000                         ;82A64A;      ;
                                                            ;      ;      ;
          CODE_82A64D: TYX                                  ;82A64D;      ;
                       LDA.B [$72],Y                        ;82A64E;000072;
                       STA.W $09B6,X                        ;82A650;0009B6;
                       INY                                  ;82A653;      ;
                       CPY.W #$1000                         ;82A654;      ;
                       BNE CODE_82A64D                      ;82A657;82A64D;
                       RTL                                  ;82A659;      ;END_BSSSS

;;;;;;;
LoadFarmMap: ;82A65A
       !src = $72
       !srcB = $74

       %Set16bit(!MX)
       LDX.W #$0000
       LDA.L FarmMapPointerTable,X
       STA.B !src
       INX
       INX
       %Set8bit(!M)
       LDA.L FarmMapPointerTable,X
       STA.B !srcB
       %Set8bit(!M)
       LDY.W #$0000

    ;data load
     - TYX
       LDA.B [!src],Y
       STA.L $7EA4E6,X
       INY
       CPY.W #$1000
       BNE -

       RTL


                CIIII: %Set16bit(!MX)                             ;82A682;      ;
                       LDA.W #$09B6                         ;82A684;      ;
                       STA.B $72                            ;82A687;000072;
                       %Set8bit(!M)                             ;82A689;      ;
                       LDA.B #$80                           ;82A68B;      ;
                       STA.B $74                            ;82A68D;000074;
                       %Set8bit(!M)                             ;82A68F;      ;
                       LDY.W #$0000                         ;82A691;      ;
                                                            ;      ;      ;
          CODE_82A694: TYX                                  ;82A694;      ;
                       LDA.B [$72],Y                        ;82A695;000072;
                       STA.L $7EA4E6,X                      ;82A697;7EA4E6;
                       INY                                  ;82A69B;      ;
                       CPY.W #$1000                         ;82A69C;      ;
                       BNE CODE_82A694                      ;82A69F;82A694;
                       RTL                                  ;82A6A1;      ;END_CIIII
                                                            ;      ;      ;
                                                            ;      ;      ;
                CJJJJ: %Set8bit(!M)                             ;82A6A2;      ;Something with fall?
                       %Set16bit(!X)                             ;82A6A4;      ;
                       LDA.L !season                        ;82A6A6;7F1F19;Season
                       CMP.B #$03                           ;82A6AA;      ;
                       BNE $64                          ;82A6AC;82A712;
                       LDA.B #$04                           ;82A6AE;      ;
                       STA.W $0181                          ;82A6B0;000181;
                       %Set16bit(!M)                             ;82A6B3;      ;
                       LDY.W #$0000                         ;82A6B5;      ;
                                                            ;      ;      ;
          CODE_82A6B8: LDX.W #$0000                         ;82A6B8;      ;
                                                            ;      ;      ;
          CODE_82A6BB: PHY                                  ;82A6BB;      ;
                       PHX                                  ;82A6BC;      ;
                       STX.B $82                            ;82A6BD;000082;
                       STY.B $84                            ;82A6BF;000084;
                       JSR.W UNK_OperatesOnSeasonTable      ;82A6C1;82B13C;
                       %Set8bit(!M)                             ;82A6C4;      ;
                       LDA.L $7EA4E6,X                      ;82A6C6;7EA4E6;
                       BNE CODE_82A6CF                      ;82A6CA;82A6CF;
                       JMP.W CODE_82A6F2                    ;82A6CC;82A6F2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A6CF: CMP.B #$A0                           ;82A6CF;      ;
                       BCC CODE_82A6D6                      ;82A6D1;82A6D6;
                       JMP.W CODE_82A6F2                    ;82A6D3;82A6F2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A6D6: CMP.B #$70                           ;82A6D6;      ;
                       BCS CODE_82A6E0                      ;82A6D8;82A6E0;
                       CMP.B #$1D                           ;82A6DA;      ;
                       BCS CODE_82A6EA                      ;82A6DC;82A6EA;
                       BRA CODE_82A6F2                      ;82A6DE;82A6F2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A6E0: %Set8bit(!M)                             ;82A6E0;      ;
                       LDA.B #$7A                           ;82A6E2;      ;
                       STA.L $7EA4E6,X                      ;82A6E4;7EA4E6;
                       BRA CODE_82A6F2                      ;82A6E8;82A6F2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A6EA: %Set8bit(!M)                             ;82A6EA;      ;
                       LDA.B #$07                           ;82A6EC;      ;
                       STA.L $7EA4E6,X                      ;82A6EE;7EA4E6;
                                                            ;      ;      ;
          CODE_82A6F2: %Set16bit(!MX)                             ;82A6F2;      ;
                       PLX                                  ;82A6F4;      ;
                       PLY                                  ;82A6F5;      ;
                       TXA                                  ;82A6F6;      ;
                       CLC                                  ;82A6F7;      ;
                       ADC.W #$0010                         ;82A6F8;      ;
                       TAX                                  ;82A6FB;      ;
                       CPX.W #$0400                         ;82A6FC;      ;
                       BEQ CODE_82A704                      ;82A6FF;82A704;
                       JMP.W CODE_82A6BB                    ;82A701;82A6BB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A704: TYA                                  ;82A704;      ;
                       CLC                                  ;82A705;      ;
                       ADC.W #$0010                         ;82A706;      ;
                       TAY                                  ;82A709;      ;
                       CPY.W #$0400                         ;82A70A;      ;
                       BEQ $03                          ;82A70D;82A712;
                       JMP.W CODE_82A6B8                    ;82A70F;82A6B8;
                                                            ;      ;      ;
                                                            ;      ;      ;
               RTL                                  ;82A712;      ;CJJJJ
                                                            ;      ;      ;
                                                            ;      ;      ;
                CHHHH: %Set16bit(!MX)                             ;82A713;      ;Params in A,X,Y
                       STA.B $86                            ;82A715;000086;
                       STX.B $88                            ;82A717;000088;
                       STY.B $8A                            ;82A719;00008A;
                       %Set8bit(!M)                             ;82A71B;      ;
                       LDA.B #$04                           ;82A71D;      ;
                       STA.W $0181                          ;82A71F;000181;
                       %Set16bit(!M)                             ;82A722;      ;
                       LDY.W #$0000                         ;82A724;      ;
                                                            ;      ;      ;
          CODE_82A727: LDX.W #$0000                         ;82A727;      ;
                                                            ;      ;      ;
          CODE_82A72A: PHY                                  ;82A72A;      ;
                       PHX                                  ;82A72B;      ;
                       STX.B $82                            ;82A72C;000082;
                       STY.B $84                            ;82A72E;000084;
                       JSR.W UNK_OperatesOnSeasonTable      ;82A730;82B13C;
                       %Set8bit(!M)                             ;82A733;      ;
                       LDA.L $7EA4E6,X                      ;82A735;7EA4E6;
                       CMP.B #$A0                           ;82A739;      ;
                       BCC CODE_82A740                      ;82A73B;82A740;
                       JMP.W CODE_82A7F0                    ;82A73D;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A740: CMP.B #$05                           ;82A740;      ;
                       BEQ CODE_82A75E                      ;82A742;82A75E;
                       CMP.B #$1D                           ;82A744;      ;
                       BEQ CODE_82A7B8                      ;82A746;82A7B8;
                       CMP.B #$70                           ;82A748;      ;
                       BCS CODE_82A77D                      ;82A74A;82A77D;
                       CMP.B #$07                           ;82A74C;      ;
                       BNE CODE_82A753                      ;82A74E;82A753;
                       JMP.W CODE_82A7D4                    ;82A750;82A7D4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A753: CMP.B #$08                           ;82A753;      ;
                       BEQ CODE_82A7D4                      ;82A755;82A7D4;
                       CMP.B #$1E                           ;82A757;      ;
                       BCS CODE_82A7D4                      ;82A759;82A7D4;
                       JMP.W CODE_82A7F0                    ;82A75B;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A75E: %Set16bit(!MX)                             ;82A75E;      ;
                       LDA.B $86                            ;82A760;000086;
                       BNE CODE_82A767                      ;82A762;82A767;
                       JMP.W CODE_82A7F0                    ;82A764;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A767: PHX                                  ;82A767;      ;
                       JSL.L RNGReturn0toA                  ;82A768;8089F9;
                       %Set8bit(!M)                             ;82A76C;      ;
                       %Set16bit(!X)                             ;82A76E;      ;
                       PLX                                  ;82A770;      ;
                       CMP.B #$00                           ;82A771;      ;
                       BNE CODE_82A7F0                      ;82A773;82A7F0;
                       LDA.B #$06                           ;82A775;      ;
                       STA.L $7EA4E6,X                      ;82A777;7EA4E6;
                       BRA CODE_82A7F0                      ;82A77B;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A77D: %Set16bit(!MX)                             ;82A77D;      ;
                       CMP.W #$0079                         ;82A77F;      ;
                       BEQ CODE_82A7AD                      ;82A782;82A7AD;
                                                            ;      ;      ;
          CODE_82A784: %Set16bit(!MX)                             ;82A784;      ;
                       LDA.B $88                            ;82A786;000088;
                       BEQ CODE_82A7F0                      ;82A788;82A7F0;
                       PHX                                  ;82A78A;      ;
                       JSL.L RNGReturn0toA                  ;82A78B;8089F9;
                       %Set8bit(!M)                             ;82A78F;      ;
                       %Set16bit(!X)                             ;82A791;      ;
                       PLX                                  ;82A793;      ;
                       CMP.B #$00                           ;82A794;      ;
                       BNE CODE_82A7F0                      ;82A796;82A7F0;
                       LDA.B #$02                           ;82A798;      ;
                       STA.L $7EA4E6,X                      ;82A79A;7EA4E6;
                       %Set16bit(!M)                             ;82A79E;      ;
                       LDA.L $7F1F29                        ;82A7A0;7F1F29;
                       BEQ CODE_82A7F0                      ;82A7A4;82A7F0;
                       DEC A                                ;82A7A6;      ;
                       STA.L $7F1F29                        ;82A7A7;7F1F29;
                       BRA CODE_82A7F0                      ;82A7AB;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A7AD: %Set16bit(!MX)                             ;82A7AD;      ;
                       LDA.W $092E                          ;82A7AF;00092E;
                       DEC A                                ;82A7B2;      ;
                       STA.W $092E                          ;82A7B3;00092E;
                       BRA CODE_82A784                      ;82A7B6;82A784;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A7B8: %Set16bit(!MX)                             ;82A7B8;      ;
                       LDA.B $88                            ;82A7BA;000088;
                       BEQ CODE_82A7F0                      ;82A7BC;82A7F0;
                       PHX                                  ;82A7BE;      ;
                       JSL.L RNGReturn0toA                  ;82A7BF;8089F9;
                       %Set8bit(!M)                             ;82A7C3;      ;
                       %Set16bit(!X)                             ;82A7C5;      ;
                       PLX                                  ;82A7C7;      ;
                       CMP.B #$00                           ;82A7C8;      ;
                       BNE CODE_82A7F0                      ;82A7CA;82A7F0;
                       LDA.B #$02                           ;82A7CC;      ;
                       STA.L $7EA4E6,X                      ;82A7CE;7EA4E6;
                       BRA CODE_82A7F0                      ;82A7D2;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A7D4: %Set16bit(!MX)                             ;82A7D4;      ;
                       LDA.B $8A                            ;82A7D6;00008A;
                       BEQ CODE_82A7F0                      ;82A7D8;82A7F0;
                       PHX                                  ;82A7DA;      ;
                       JSL.L RNGReturn0toA                  ;82A7DB;8089F9;
                       %Set8bit(!M)                             ;82A7DF;      ;
                       %Set16bit(!X)                             ;82A7E1;      ;
                       PLX                                  ;82A7E3;      ;
                       CMP.B #$00                           ;82A7E4;      ;
                       BNE CODE_82A7F0                      ;82A7E6;82A7F0;
                       LDA.B #$02                           ;82A7E8;      ;
                       STA.L $7EA4E6,X                      ;82A7EA;7EA4E6;
                       BRA CODE_82A7F0                      ;82A7EE;82A7F0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A7F0: %Set16bit(!MX)                             ;82A7F0;      ;
                       PLX                                  ;82A7F2;      ;
                       PLY                                  ;82A7F3;      ;
                       TXA                                  ;82A7F4;      ;
                       CLC                                  ;82A7F5;      ;
                       ADC.W #$0010                         ;82A7F6;      ;
                       TAX                                  ;82A7F9;      ;
                       CPX.W #$0400                         ;82A7FA;      ;
                       BEQ CODE_82A802                      ;82A7FD;82A802;
                       JMP.W CODE_82A72A                    ;82A7FF;82A72A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A802: TYA                                  ;82A802;      ;
                       CLC                                  ;82A803;      ;
                       ADC.W #$0010                         ;82A804;      ;
                       TAY                                  ;82A807;      ;
                       CPY.W #$0400                         ;82A808;      ;
                       BEQ CODE_82A810                      ;82A80B;82A810;
                       JMP.W CODE_82A727                    ;82A80D;82A727;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A810: RTL                                  ;82A810;      ;CHHHH
                                                            ;      ;      ;
                                                            ;      ;      ;
         Unk_Seasons2: %Set8bit(!M)                             ;82A811;      ;
                       %Set16bit(!X)                             ;82A813;      ;
                       LDA.B #$04                           ;82A815;      ;
                       STA.W $0181                          ;82A817;000181;
                       %Set16bit(!M)                             ;82A81A;      ;
                       LDY.W #$0000                         ;82A81C;      ;
                                                            ;      ;      ;
          CODE_82A81F: LDX.W #$0000                         ;82A81F;      ;
                                                            ;      ;      ;
          CODE_82A822: PHY                                  ;82A822;      ;
                       PHX                                  ;82A823;      ;
                       STX.B $82                            ;82A824;000082;
                       STY.B $84                            ;82A826;000084;
                       JSR.W UNK_OperatesOnSeasonTable      ;82A828;82B13C;
                       %Set8bit(!M)                             ;82A82B;      ;
                       LDA.L $7EA4E6,X                      ;82A82D;7EA4E6;
                       BNE CODE_82A836                      ;82A831;82A836;
                       JMP.W CODE_82A969                    ;82A833;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A836: CMP.B #$03                           ;82A836;      ;
                       BCS CODE_82A83D                      ;82A838;82A83D;
                       JMP.W CODE_82A91B                    ;82A83A;82A91B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A83D: CMP.B #$A0                           ;82A83D;      ;
                       BCC CODE_82A844                      ;82A83F;82A844;
                       JMP.W CODE_82A969                    ;82A841;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A844: CMP.B #$06                           ;82A844;      ;
                       BNE CODE_82A84B                      ;82A846;82A84B;
                       JMP.W CODE_82A949                    ;82A848;82A949;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A84B: CMP.B #$07                           ;82A84B;      ;
                       BEQ CODE_82A8A4                      ;82A84D;82A8A4;
                       CMP.B #$08                           ;82A84F;      ;
                       BNE CODE_82A856                      ;82A851;82A856;
                       JMP.W CODE_82A8B4                    ;82A853;82A8B4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A856: CMP.B #$1E                           ;82A856;      ;
                       BEQ CODE_82A8A4                      ;82A858;82A8A4;
                       CMP.B #$1F                           ;82A85A;      ;
                       BNE CODE_82A861                      ;82A85C;82A861;
                       JMP.W CODE_82A8B4                    ;82A85E;82A8B4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A861: CMP.B #$1D                           ;82A861;      ;
                       BNE CODE_82A868                      ;82A863;82A868;
                       JMP.W CODE_82A969                    ;82A865;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A868: CMP.B #$20                           ;82A868;      ;
                       BCS CODE_82A86F                      ;82A86A;82A86F;
                       JMP.W CODE_82A969                    ;82A86C;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A86F: CMP.B #$39                           ;82A86F;      ;
                       BNE CODE_82A876                      ;82A871;82A876;
                       JMP.W CODE_82A8B4                    ;82A873;82A8B4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A876: CMP.B #$53                           ;82A876;      ;
                       BNE CODE_82A87D                      ;82A878;82A87D;
                       JMP.W CODE_82A8B4                    ;82A87A;82A8B4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A87D: CMP.B #$61                           ;82A87D;      ;
                       BNE CODE_82A884                      ;82A87F;82A884;
                       JMP.W CODE_82A8B4                    ;82A881;82A8B4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A884: CMP.B #$6F                           ;82A884;      ;
                       BNE CODE_82A88B                      ;82A886;82A88B;
                       JMP.W CODE_82A8B4                    ;82A888;82A8B4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A88B: CMP.B #$79                           ;82A88B;      ;
                       BNE CODE_82A892                      ;82A88D;82A892;
                       JMP.W CODE_82A969                    ;82A88F;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A892: CMP.B #$7C                           ;82A892;      ;
                       BNE CODE_82A899                      ;82A894;82A899;
                       JMP.W CODE_82A8CF                    ;82A896;82A8CF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A899: CMP.B #$70                           ;82A899;      ;
                       BCS CODE_82A906                      ;82A89B;82A906;
                       AND.B #$01                           ;82A89D;      ;
                       BEQ CODE_82A8A4                      ;82A89F;82A8A4;
                       JMP.W CODE_82A8DA                    ;82A8A1;82A8DA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8A4: %Set16bit(!M)                             ;82A8A4;      ;
                       LDA.W $0196                          ;82A8A6;000196;
                       AND.W #$0002                         ;82A8A9;      ;
                       BEQ CODE_82A8B1                      ;82A8AC;82A8B1;
                       JMP.W CODE_82A906                    ;82A8AE;82A906;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8B1: JMP.W CODE_82A969                    ;82A8B1;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8B4: %Set16bit(!M)                             ;82A8B4;      ;
                       LDA.W $0196                          ;82A8B6;000196;
                       AND.W #$0002                         ;82A8B9;      ;
                       BEQ CODE_82A8C1                      ;82A8BC;82A8C1;
                       JMP.W CODE_82A969                    ;82A8BE;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8C1: %Set8bit(!M)                             ;82A8C1;      ;
                       LDA.L $7EA4E6,X                      ;82A8C3;7EA4E6;
                       DEC A                                ;82A8C7;      ;
                       STA.L $7EA4E6,X                      ;82A8C8;7EA4E6;
                       JMP.W CODE_82A969                    ;82A8CC;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8CF: %Set8bit(!M)                             ;82A8CF;      ;
                       LDA.B #$73                           ;82A8D1;      ;
                       STA.L $7EA4E6,X                      ;82A8D3;7EA4E6;
                       JMP.W CODE_82A969                    ;82A8D7;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8DA: %Set8bit(!M)                             ;82A8DA;      ;
                       LDA.L !season                        ;82A8DC;7F1F19;
                       CMP.B #$02                           ;82A8E0;      ;
                       BNE CODE_82A8F0                      ;82A8E2;82A8F0;
                       LDA.L $7EA4E6,X                      ;82A8E4;7EA4E6;
                       DEC A                                ;82A8E8;      ;
                       STA.L $7EA4E6,X                      ;82A8E9;7EA4E6;
                       JMP.W CODE_82A969                    ;82A8ED;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A8F0: %Set8bit(!M)                             ;82A8F0;      ;
                       LDA.L !season                        ;82A8F2;7F1F19;
                       CMP.B #$03                           ;82A8F6;      ;
                       BEQ CODE_82A969                      ;82A8F8;82A969;
                       LDA.L $7EA4E6,X                      ;82A8FA;7EA4E6;
                       INC A                                ;82A8FE;      ;
                       STA.L $7EA4E6,X                      ;82A8FF;7EA4E6;
                       JMP.W CODE_82A8A4                    ;82A903;82A8A4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A906: %Set8bit(!M)                             ;82A906;      ;
                       LDA.L !season                        ;82A908;7F1F19;
                       CMP.B #$03                           ;82A90C;      ;
                       BEQ CODE_82A969                      ;82A90E;82A969;
                       LDA.L $7EA4E6,X                      ;82A910;7EA4E6;
                       INC A                                ;82A914;      ;
                       STA.L $7EA4E6,X                      ;82A915;7EA4E6;
                       BRA CODE_82A969                      ;82A919;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A91B: %Set8bit(!M)                             ;82A91B;      ;
                       LDA.L !season                        ;82A91D;7F1F19;
                       CMP.B #$02                           ;82A921;      ;
                       BEQ CODE_82A969                      ;82A923;82A969;
                       CMP.B #$03                           ;82A925;      ;
                       BEQ CODE_82A969                      ;82A927;82A969;
                       LDA.L !day                        ;82A929;7F1F1B;
                       AND.B #$03                           ;82A92D;      ;
                       BNE CODE_82A969                      ;82A92F;82A969;
                       %Set16bit(!X)                             ;82A931;      ;
                       PHX                                  ;82A933;      ;
                       JSL.L GetRNG                         ;82A934;838138;
                       %Set8bit(!M)                             ;82A938;      ;
                       %Set16bit(!X)                             ;82A93A;      ;
                       PLX                                  ;82A93C;      ;
                       CMP.B #$00                           ;82A93D;      ;
                       BNE CODE_82A969                      ;82A93F;82A969;
                       LDA.B #$03                           ;82A941;      ;
                       STA.L $7EA4E6,X                      ;82A943;7EA4E6;
                       BRA CODE_82A969                      ;82A947;82A969;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A949: %Set8bit(!M)                             ;82A949;      ;
                       LDA.B #$08                           ;82A94B;      ;
                       JSL.L RNGReturn0toA                  ;82A94D;8089F9;
                       BNE CODE_82A969                      ;82A951;82A969;
                       %Set16bit(!M)                             ;82A953;      ;
                       LDA.W $0196                          ;82A955;000196;
                       ORA.W #$0400                         ;82A958;      ;
                       STA.W $0196                          ;82A95B;000196;
                       LDA.L $7F1F6E                        ;82A95E;7F1F6E;
                       ORA.W #$0200                         ;82A962;      ;
                       STA.L $7F1F6E                        ;82A965;7F1F6E;
                                                            ;      ;      ;
          CODE_82A969: %Set16bit(!MX)                             ;82A969;      ;
                       PLX                                  ;82A96B;      ;
                       PLY                                  ;82A96C;      ;
                       TXA                                  ;82A96D;      ;
                       CLC                                  ;82A96E;      ;
                       ADC.W #$0010                         ;82A96F;      ;
                       TAX                                  ;82A972;      ;
                       CPX.W #$0400                         ;82A973;      ;
                       BEQ CODE_82A97B                      ;82A976;82A97B;
                       JMP.W CODE_82A822                    ;82A978;82A822;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A97B: TYA                                  ;82A97B;      ;
                       CLC                                  ;82A97C;      ;
                       ADC.W #$0010                         ;82A97D;      ;
                       TAY                                  ;82A980;      ;
                       CPY.W #$0400                         ;82A981;      ;
                       BEQ CODE_82A989                      ;82A984;82A989;
                       JMP.W CODE_82A81F                    ;82A986;82A81F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82A989: %Set8bit(!M)                             ;82A989;      ;
                       LDA.L !season                        ;82A98B;7F1F19;
                       CMP.B #$03                           ;82A98F;      ;
                       BNE .return                          ;82A991;82A99F;
                       LDA.L !day                        ;82A993;7F1F1B;
                       CMP.B #$01                           ;82A997;      ;
                       BNE .return                          ;82A999;82A99F;
                       JSL.L CJJJJ                          ;82A99B;82A6A2;
                                                            ;      ;      ;
              .return: RTL                                  ;82A99F;      ;Unk_Seasons2
                                                            ;      ;      ;
                                                            ;      ;      ;
CKKKK:
       %Set8bit(!M)
       %Set16bit(!X)
       LDA.B #$04
       STA.W $0181
       %Set16bit(!M)
       STZ.W $092E
       LDY.W #$0000

    .loop:
       LDX.W #$0000

    .loop2:
       PHY
       PHX
       STX.B $82
       STY.B $84
       JSR.W UNK_OperatesOnSeasonTable
       %Set8bit(!M)
       LDA.L $7EA4E6,X                       ;Farm data?
       CMP.B #$76
       BEQ .found
       CMP.B #$77
       BEQ .found
       CMP.B #$78
       BEQ .found
       CMP.B #$79
       BEQ .found
       BRA .notfound

    .found:
       %Set8bit(!M)
       LDA.B #$7A
       STA.L $7EA4E6,X
       %Set16bit(!M)
       LDA.W $092E
       INC A
       STA.W $092E

    .notfound:
       %Set16bit(!MX)
       PLX
       PLY
       LDA.W $092E
       BNE .return
       TXA
       CLC
       ADC.W #$0010
       TAX
       CPX.W #$0400                          ;1024
       BEQ +
       JMP.W .loop2

     + TYA
       CLC
       ADC.W #$0010
       TAY
       CPY.W #$0400
       BEQ .return
       JMP.W .loop

       .return: RTL

                CLLLL: %Set8bit(!M)                             ;82AA0C;      ;
                       %Set16bit(!X)                             ;82AA0E;      ;
                       LDA.B #$04                           ;82AA10;      ;
                       STA.W $0181                          ;82AA12;000181;
                       %Set16bit(!M)                             ;82AA15;      ;
                       LDA.W #$0000                         ;82AA17;      ;
                       STA.L !ranch_development                        ;82AA1A;7F1F56;
                       LDY.W #$0000                         ;82AA1E;      ;
                                                            ;      ;      ;
          CODE_82AA21: LDX.W #$0000                         ;82AA21;      ;
                                                            ;      ;      ;
          CODE_82AA24: PHY                                  ;82AA24;      ;
                       PHX                                  ;82AA25;      ;
                       STX.B $82                            ;82AA26;000082;
                       STY.B $84                            ;82AA28;000084;
                       JSR.W UNK_OperatesOnSeasonTable      ;82AA2A;82B13C;
                       %Set8bit(!M)                             ;82AA2D;      ;
                       LDA.L $7EA4E6,X                      ;82AA2F;7EA4E6;
                       CMP.B #$A0                           ;82AA33;      ;
                       BCS CODE_82AA50                      ;82AA35;82AA50;
                       CMP.B #$05                           ;82AA37;      ;
                       BEQ CODE_82AA45                      ;82AA39;82AA45;
                       CMP.B #$06                           ;82AA3B;      ;
                       BEQ CODE_82AA45                      ;82AA3D;82AA45;
                       CMP.B #$1D                           ;82AA3F;      ;
                       BCS CODE_82AA45                      ;82AA41;82AA45;
                       BRA CODE_82AA50                      ;82AA43;82AA50;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AA45: %Set16bit(!M)                             ;82AA45;      ;
                       LDA.L !ranch_development                        ;82AA47;7F1F56;
                       INC A                                ;82AA4B;      ;
                       STA.L !ranch_development                        ;82AA4C;7F1F56;
                                                            ;      ;      ;
          CODE_82AA50: %Set16bit(!MX)                             ;82AA50;      ;
                       PLX                                  ;82AA52;      ;
                       PLY                                  ;82AA53;      ;
                       TXA                                  ;82AA54;      ;
                       CLC                                  ;82AA55;      ;
                       ADC.W #$0010                         ;82AA56;      ;
                       TAX                                  ;82AA59;      ;
                       CPX.W #$0400                         ;82AA5A;      ;
                       BEQ CODE_82AA62                      ;82AA5D;82AA62;
                       JMP.W CODE_82AA24                    ;82AA5F;82AA24;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AA62: TYA                                  ;82AA62;      ;
                       CLC                                  ;82AA63;      ;
                       ADC.W #$0010                         ;82AA64;      ;
                       TAY                                  ;82AA67;      ;
                       CPY.W #$0400                         ;82AA68;      ;
                       BEQ CODE_82AA70                      ;82AA6B;82AA70;
                       JMP.W CODE_82AA21                    ;82AA6D;82AA21;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AA70: RTL                                  ;82AA70;      ;END_CLLLL
                                                            ;      ;      ;
                                                            ;      ;      ;
                CMMMM: %Set8bit(!M)                             ;82AA71;      ;BEEEG BRANCH
                       %Set16bit(!X)                             ;82AA73;      ;
                       LDA.W !tool_selected                          ;82AA75;000921;
                       CMP.B #$01                           ;82AA78;      ;
                       BEQ CNNNN                            ;82AA7A;82AAE5;
                       CMP.B #$11                           ;82AA7C;      ;
                       BEQ CNNNN                            ;82AA7E;82AAE5;
                       CMP.B #$02                           ;82AA80;      ;
                       BNE CODE_82AA87                      ;82AA82;82AA87;
                       JMP.W COOOO                          ;82AA84;82AB0A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AA87: CMP.B #$12                           ;82AA87;      ;
                       BEQ COOOO                            ;82AA89;82AB0A;
                       CMP.B #$03                           ;82AA8B;      ;
                       BNE CODE_82AA92                      ;82AA8D;82AA92;
                       JMP.W CQQQQ                          ;82AA8F;82AB2F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AA92: CMP.B #$13                           ;82AA92;      ;
                       BNE CODE_82AA99                      ;82AA94;82AA99;
                       JMP.W CQQQQ                          ;82AA96;82AB2F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AA99: CMP.B #$04                           ;82AA99;      ;
                       BNE CODE_82AAA0                      ;82AA9B;82AAA0;
                       JMP.W CSSSS                          ;82AA9D;82AB54;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAA0: CMP.B #$14                           ;82AAA0;      ;
                       BNE CODE_82AAA7                      ;82AAA2;82AAA7;
                       JMP.W CSSSS                          ;82AAA4;82AB54;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAA7: CMP.B #$10                           ;82AAA7;      ;
                       BNE CODE_82AAAE                      ;82AAA9;82AAAE;
                       JMP.W CTTTT                          ;82AAAB;82AB79;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAAE: CMP.B #$15                           ;82AAAE;      ;
                       BNE CODE_82AAB5                      ;82AAB0;82AAB5;
                       JMP.W CWWWW                          ;82AAB2;82ABEB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAB5: CMP.B #$0C                           ;82AAB5;      ;
                       BNE CODE_82AABC                      ;82AAB7;82AABC;
                       JMP.W CYYYY                          ;82AAB9;82AC10;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AABC: CMP.B #$05                           ;82AABC;      ;
                       BNE CODE_82AAC3                      ;82AABE;82AAC3;
                       JMP.W CYYYY                          ;82AAC0;82AC10;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAC3: CMP.B #$06                           ;82AAC3;      ;
                       BNE CODE_82AACA                      ;82AAC5;82AACA;
                       JMP.W CYYYY                          ;82AAC7;82AC10;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AACA: CMP.B #$07                           ;82AACA;      ;
                       BNE CODE_82AAD1                      ;82AACC;82AAD1;
                       JMP.W CYYYY                          ;82AACE;82AC10;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAD1: CMP.B #$08                           ;82AAD1;      ;
                       BNE CODE_82AAD8                      ;82AAD3;82AAD8;
                       JMP.W CYYYY                          ;82AAD5;82AC10;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AAD8: CMP.B #$0D                           ;82AAD8;      ;
                       BNE CODE_82AADF                      ;82AADA;82AADF;
                       JMP.W CZZZZ                          ;82AADC;82AC35;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AADF: %Set16bit(!M)                             ;82AADF;      ;
                       LDA.W #$0001                         ;82AAE1;      ;
                       RTL                                  ;82AAE4;      ;END_CMMMM
                                                            ;      ;      ;
                                                            ;      ;      ;
                CNNNN: %Set16bit(!MX)                             ;82AAE5;      ;
                       LDA.W #$0001                         ;82AAE7;      ;
                       JSL.L CGGGG                          ;82AAEA;82AC61;
                       CPX.W #$00A0                         ;82AAEE;      ;
                       BCS CODE_82AB04                      ;82AAF1;82AB04;
                       CPX.W #$0000                         ;82AAF3;      ;
                       BEQ CODE_82AB04                      ;82AAF6;82AB04;
                       %Set8bit(!M)                             ;82AAF8;      ;
                       AND.B #$01                           ;82AAFA;      ;
                       BEQ CODE_82AB04                      ;82AAFC;82AB04;
                       %Set16bit(!M)                             ;82AAFE;      ;
                       LDA.W #$0001                         ;82AB00;      ;
                       RTL                                  ;82AB03;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AB04: %Set16bit(!M)                             ;82AB04;      ;
                       LDA.W #$0000                         ;82AB06;      ;
                       RTL                                  ;82AB09;      ;END_CNNNN
                                                            ;      ;      ;
                                                            ;      ;      ;
                COOOO: %Set16bit(!MX)                             ;82AB0A;      ;
                       LDA.W #$0001                         ;82AB0C;      ;
                       JSL.L CGGGG                          ;82AB0F;82AC61;
                       CPX.W #$00A0                         ;82AB13;      ;
                       BCS CPPPP                            ;82AB16;82AB29;
                       CPX.W #$0000                         ;82AB18;      ;
                       BEQ CPPPP                            ;82AB1B;82AB29;
                       %Set8bit(!M)                             ;82AB1D;      ;
                       AND.B #$02                           ;82AB1F;      ;
                       BEQ CPPPP                            ;82AB21;82AB29;
                       %Set16bit(!M)                             ;82AB23;      ;
                       LDA.W #$0001                         ;82AB25;      ;
                       RTL                                  ;82AB28;      ;END_COOO
                                                            ;      ;      ;
                                                            ;      ;      ;
                CPPPP: %Set16bit(!M)                             ;82AB29;      ;
                       LDA.W #$0000                         ;82AB2B;      ;
                       RTL                                  ;82AB2E;      ;END_CPPPP
                                                            ;      ;      ;
                                                            ;      ;      ;
                CQQQQ: %Set16bit(!MX)                             ;82AB2F;      ;
                       LDA.W #$0001                         ;82AB31;      ;
                       JSL.L CGGGG                          ;82AB34;82AC61;
                       CPX.W #$00A0                         ;82AB38;      ;
                       BCS CRRRR                            ;82AB3B;82AB4E;
                       CPX.W #$0000                         ;82AB3D;      ;
                       BEQ CRRRR                            ;82AB40;82AB4E;
                       %Set8bit(!M)                             ;82AB42;      ;
                       AND.B #$04                           ;82AB44;      ;
                       BEQ CRRRR                            ;82AB46;82AB4E;
                       %Set16bit(!M)                             ;82AB48;      ;
                       LDA.W #$0001                         ;82AB4A;      ;
                       RTL                                  ;82AB4D;      ;END_CQQQQ
                                                            ;      ;      ;
                                                            ;      ;      ;
                CRRRR: %Set16bit(!M)                             ;82AB4E;      ;
                       LDA.W #$0000                         ;82AB50;      ;
                       RTL                                  ;82AB53;      ;END_CRRRR
                                                            ;      ;      ;
                                                            ;      ;      ;
                CSSSS: %Set16bit(!MX)                             ;82AB54;      ;
                       LDA.W #$0001                         ;82AB56;      ;
                       JSL.L CGGGG                          ;82AB59;82AC61;
                       CPX.W #$00A0                         ;82AB5D;      ;
                       BCS CODE_82AB73                      ;82AB60;82AB73;
                       CPX.W #$0000                         ;82AB62;      ;
                       BEQ CODE_82AB73                      ;82AB65;82AB73;
                       %Set8bit(!M)                             ;82AB67;      ;
                       AND.B #$08                           ;82AB69;      ;
                       BEQ CODE_82AB73                      ;82AB6B;82AB73;
                       %Set16bit(!M)                             ;82AB6D;      ;
                       LDA.W #$0001                         ;82AB6F;      ;
                       RTL                                  ;82AB72;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AB73: %Set16bit(!M)                             ;82AB73;      ;
                       LDA.W #$0000                         ;82AB75;      ;
                       RTL                                  ;82AB78;      ;END_CSSSS
                                                            ;      ;      ;
                                                            ;      ;      ;
                CTTTT: %Set8bit(!M)                             ;82AB79;      ;
                       LDA.B !tilemap_to_load                            ;82AB7B;000022;
                       CMP.B #$04                           ;82AB7D;      ;
                       BCC CODE_82ABA2                      ;82AB7F;82ABA2;
                       CMP.B #$10                           ;82AB81;      ;
                       BCC CVVVV                            ;82AB83;82ABE5;
                       CMP.B #$3D                           ;82AB85;      ;
                       BCS CODE_82ABA2                      ;82AB87;82ABA2;
                       CMP.B #$14                           ;82AB89;      ;
                       BCS CVVVV                            ;82AB8B;82ABE5;
                       %Set16bit(!MX)                             ;82AB8D;      ;
                       LDA.W #$0001                         ;82AB8F;      ;
                       JSL.L CGGGG                          ;82AB92;82AC61;
                       CPX.W #$00F0                         ;82AB96;      ;
                       BEQ CUUUU                            ;82AB99;82ABDF;
                       CPX.W #$00F4                         ;82AB9B;      ;
                       BEQ CUUUU                            ;82AB9E;82ABDF;
                       BRA CVVVV                            ;82ABA0;82ABE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82ABA2: %Set16bit(!MX)                             ;82ABA2;      ;
                       LDA.W #$0001                         ;82ABA4;      ;
                       JSL.L CGGGG                          ;82ABA7;82AC61;
                       CPX.W #$00F0                         ;82ABAB;      ;
                       BEQ CUUUU                            ;82ABAE;82ABDF;
                       CPX.W #$00F9                         ;82ABB0;      ;
                       BEQ CUUUU                            ;82ABB3;82ABDF;
                       CPX.W #$00FA                         ;82ABB5;      ;
                       BEQ CUUUU                            ;82ABB8;82ABDF;
                       CPX.W #$00FB                         ;82ABBA;      ;
                       BEQ CUUUU                            ;82ABBD;82ABDF;
                       CPX.W #$00FC                         ;82ABBF;      ;
                       BEQ CUUUU                            ;82ABC2;82ABDF;
                       CPX.W #$00FD                         ;82ABC4;      ;
                       BEQ CUUUU                            ;82ABC7;82ABDF;
                       CPX.W #$00A0                         ;82ABC9;      ;
                       BCS CVVVV                            ;82ABCC;82ABE5;
                       CPX.W #$0000                         ;82ABCE;      ;
                       BEQ CVVVV                            ;82ABD1;82ABE5;
                       %Set8bit(!M)                             ;82ABD3;      ;
                       AND.B #$10                           ;82ABD5;      ;
                       BEQ CVVVV                            ;82ABD7;82ABE5;
                       %Set16bit(!M)                             ;82ABD9;      ;
                       LDA.W #$0001                         ;82ABDB;      ;
                       RTL                                  ;82ABDE;      ;END_CTTTT
                                                            ;      ;      ;
                                                            ;      ;      ;
                CUUUU: %Set16bit(!M)                             ;82ABDF;      ;
                       LDA.W #$0002                         ;82ABE1;      ;
                       RTL                                  ;82ABE4;      ;END_CUUUU
                                                            ;      ;      ;
                                                            ;      ;      ;
                CVVVV: %Set16bit(!M)                             ;82ABE5;      ;
                       LDA.W #$0000                         ;82ABE7;      ;
                       RTL                                  ;82ABEA;      ;END_CVVVV
                                                            ;      ;      ;
                                                            ;      ;      ;
                CWWWW: %Set16bit(!MX)                             ;82ABEB;      ;
                       LDA.W #$0001                         ;82ABED;      ;
                       JSL.L CGGGG                          ;82ABF0;82AC61;
                       CPX.W #$00A0                         ;82ABF4;      ;
                       BCS CXXXX                            ;82ABF7;82AC0A;
                       CPX.W #$0000                         ;82ABF9;      ;
                       BEQ CXXXX                            ;82ABFC;82AC0A;
                       %Set8bit(!M)                             ;82ABFE;      ;
                       AND.B #$10                           ;82AC00;      ;
                       BEQ CXXXX                            ;82AC02;82AC0A;
                       %Set16bit(!M)                             ;82AC04;      ;
                       LDA.W #$0001                         ;82AC06;      ;
                       RTL                                  ;82AC09;      ;END_CWWWW
                                                            ;      ;      ;
                                                            ;      ;      ;
                CXXXX: %Set16bit(!M)                             ;82AC0A;      ;
                       LDA.W #$0000                         ;82AC0C;      ;
                       RTL                                  ;82AC0F;      ;END_CXXXX
                                                            ;      ;      ;
                                                            ;      ;      ;
                CYYYY: %Set16bit(!MX)                             ;82AC10;      ;
                       LDA.W #$0001                         ;82AC12;      ;
                       JSL.L CGGGG                          ;82AC15;82AC61;
                       CPX.W #$00A0                         ;82AC19;      ;
                       BCS DYYYY                            ;82AC1C;82AC2F;
                       CPX.W #$0000                         ;82AC1E;      ;
                       BEQ DYYYY                            ;82AC21;82AC2F;
                       %Set8bit(!M)                             ;82AC23;      ;
                       AND.B #$20                           ;82AC25;      ;
                       BEQ DYYYY                            ;82AC27;82AC2F;
                       %Set16bit(!M)                             ;82AC29;      ;
                       LDA.W #$0001                         ;82AC2B;      ;
                       RTL                                  ;82AC2E;      ;END_CXXXX
                                                            ;      ;      ;
                                                            ;      ;      ;
                DYYYY: %Set16bit(!M)                             ;82AC2F;      ;
                       LDA.W #$0000                         ;82AC31;      ;
                       RTL                                  ;82AC34;      ;END_CYYYY
                                                            ;      ;      ;
                                                            ;      ;      ;
                CZZZZ: %Set8bit(!M)                             ;82AC35;      ;
                       LDA.B !tilemap_to_load                            ;82AC37;000022;
                       CMP.B #$04                           ;82AC39;      ;
                       BCS DAAAA                            ;82AC3B;82AC5B;
                       %Set16bit(!MX)                             ;82AC3D;      ;
                       LDA.W #$0001                         ;82AC3F;      ;
                       JSL.L CGGGG                          ;82AC42;82AC61;
                       CPX.W #$00C3                         ;82AC46;      ;
                       BEQ CODE_82AC55                      ;82AC49;82AC55;
                       CPX.W #$00E2                         ;82AC4B;      ;
                       BCC DAAAA                            ;82AC4E;82AC5B;
                       CPX.W #$00E5                         ;82AC50;      ;
                       BCS DAAAA                            ;82AC53;82AC5B;
                                                            ;      ;      ;
          CODE_82AC55: %Set16bit(!M)                             ;82AC55;      ;
                       LDA.W #$0001                         ;82AC57;      ;
                       RTL                                  ;82AC5A;      ;END_CZZZZ
                                                            ;      ;      ;
                                                            ;      ;      ;
                DAAAA: %Set16bit(!M)                             ;82AC5B;      ;
                       LDA.W #$0000                         ;82AC5D;      ;
                       RTL                                  ;82AC60;      ;END_DAAAA

;;;;;;;; Params in A, return in X, Y TODO
CGGGG: ;82AC61
      %Set16bit(!MX)
      STA.B $82
      %Set16bit(!M)
      LDA.L $7F1F5C
      AND.W #$0008                           ;FLAG5C
      BEQ .skip
      JMP.W .default

   .skip:
      JSL.L CODE_82B124                    ;82AC73;82B124;
      %Set8bit(!M)                             ;82AC77;      ;
      XBA                                  ;82AC79;      ;
      LDA.B #$00                           ;82AC7A;      ;
      XBA                                  ;82AC7C;      ;
      TAX                                  ;82AC7D;      ;
      %Set16bit(!M)                             ;82AC7E;      ;
      PHX                                  ;82AC80;      ;
      PHA                                  ;82AC81;      ;
      ASL A                                ;82AC82;      ;
      ASL A                                ;82AC83;      ;
      INC A                                ;82AC84;      ;
      INC A                                ;82AC85;      ;
      INC A                                ;82AC86;      ;
      TAY                                  ;82AC87;      ;
      LDA.B !player_direction                            ;82AC88;0000DA;
      ASL A                                ;82AC8A;      ;
      TAX                                  ;82AC8B;      ;
      LDA.L UNK_Table7,X                   ;82AC8C;82ACFE;
      STA.B $84                            ;82AC90;000084;
      %Set8bit(!M)                             ;82AC92;      ;
      LDA.B #$00                           ;82AC94;      ;
      XBA                                  ;82AC96;      ;
      LDA.B [$0D],Y                        ;82AC97;00000D;
      %Set16bit(!M)                             ;82AC99;      ;
      AND.B $84                            ;82AC9B;000084;
      BEQ .CODE_82ACCC                      ;82AC9D;82ACCC;
      %Set8bit(!M)                             ;82AC9F;      ;
      LDA.B #$00                           ;82ACA1;      ;
      XBA                                  ;82ACA3;      ;
      LDA.L !season                        ;82ACA4;7F1F19;
      %Set16bit(!M)                             ;82ACA8;      ;
      ASL A                                ;82ACAA;      ;
      TAX                                  ;82ACAB;      ;
      LDA.L UNK_Table8,X                   ;82ACAC;82AD06;
      STA.B $84                            ;82ACB0;000084;
      %Set8bit(!M)                             ;82ACB2;      ;
      LDA.B #$00                           ;82ACB4;      ;
      XBA                                  ;82ACB6;      ;
      LDA.B [$0D],Y                        ;82ACB7;00000D;
      %Set16bit(!M)                             ;82ACB9;      ;
      AND.B $84                            ;82ACBB;000084;
      BEQ .CODE_82ACCC                      ;82ACBD;82ACCC;
      %Set16bit(!MX)                             ;82ACBF;      ;
      PLA                                  ;82ACC1;      ;
      PLX                                  ;82ACC2;      ;
      ASL A                                ;82ACC3;      ;
      ASL A                                ;82ACC4;      ;
      ADC.B $82                            ;82ACC5;000082;
      TAY                                  ;82ACC7;      ;
      LDA.B [$0D],Y                        ;82ACC8;00000D;
      BRA .return                      ;82ACCA;82ACFD;
                                          ;      ;      ;
                                          ;      ;      ;
   .CODE_82ACCC:
      %Set16bit(!MX)                             ;82ACCC;      ;
      TYA                                  ;82ACCE;      ;
      DEC A                                ;82ACCF;      ;
      TAY                                  ;82ACD0;      ;
      %Set8bit(!M)                             ;82ACD1;      ;
      LDA.B [$0D],Y                        ;82ACD3;00000D;
      AND.B #$80                           ;82ACD5;      ;
      BNE .CODE_82ACE9                      ;82ACD7;82ACE9;
      %Set16bit(!M)                             ;82ACD9;      ;
      PLA                                  ;82ACDB;      ;
      PLX                                  ;82ACDC;      ;
      ASL A                                ;82ACDD;      ;
      ASL A                                ;82ACDE;      ;
      ADC.B $82                            ;82ACDF;000082;
      TAY                                  ;82ACE1;      ;
      LDA.B [$0D],Y                        ;82ACE2;00000D;
      LDX.W #$0000                         ;82ACE4;      ;
      BRA .return                      ;82ACE7;82ACFD;
                                          ;      ;      ;
                                          ;      ;      ;
   .CODE_82ACE9:
      %Set16bit(!MX)                             ;82ACE9;      ;
      PLA                                  ;82ACEB;      ;
      PLX                                  ;82ACEC;      ;
      LDA.W #$0000                         ;82ACED;      ;
      LDX.W #$0000                         ;82ACF0;      ;
      BRA .return                      ;82ACF3;82ACFD;
                                          ;      ;      ;
                                          ;      ;      ;
      .default:
      %Set16bit(!MX)                             ;82ACF5;      ;
      LDA.W #$0000                         ;82ACF7;      ;
      LDX.W #$0000                         ;82ACFA;      ;
                                          ;      ;      ;
      .return: RTL                                  ;82ACFD;      ;END_CGGGG
                                                            ;      ;      ;
                                                            ;      ;      ;
           UNK_Table7: db $01,$00,$02,$00,$04,$00,$08,$00   ;82ACFE;      ;
                                                            ;      ;      ;
           UNK_Table8: db $10,$00,$20,$00,$40,$00,$80,$00   ;82AD06;      ;
                                                            ;      ;      ;
          CODE_82AD0E: %Set8bit(!M)                             ;82AD0E;      ;
                       %Set16bit(!X)                             ;82AD10;      ;
                       CPX.W #$00F0                         ;82AD12;      ;
                       BCC CODE_82AD1A                      ;82AD15;82AD1A;
                       JMP.W CODE_82AEBA                    ;82AD17;82AEBA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD1A: CPX.W #$00E0                         ;82AD1A;      ;
                       BCC CODE_82AD22                      ;82AD1D;82AD22;
                       JMP.W CODE_82AEB8                    ;82AD1F;82AEB8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD22: CPX.W #$00D0                         ;82AD22;      ;
                       BCC CODE_82AD2A                      ;82AD25;82AD2A;
                       JMP.W CODE_82AE9B                    ;82AD27;82AE9B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD2A: CPX.W #$00C0                         ;82AD2A;      ;
                       BCC CODE_82AD32                      ;82AD2D;82AD32;
                       JMP.W CODE_82ADE0                    ;82AD2F;82ADE0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD32: %Set8bit(!M)                             ;82AD32;      ;
                       LDA.L !season                        ;82AD34;7F1F19;
                       CMP.B #$02                           ;82AD38;      ;
                       BEQ CODE_82AD42                      ;82AD3A;82AD42;
                       CMP.B #$03                           ;82AD3C;      ;
                       BEQ CODE_82AD42                      ;82AD3E;82AD42;
                       BRA CODE_82AD84                      ;82AD40;82AD84;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD42: %Set16bit(!MX)                             ;82AD42;      ;
                       CPX.W #$0038                         ;82AD44;      ;
                       BNE CODE_82AD4C                      ;82AD47;82AD4C;
                       JMP.W CODE_82AEE5                    ;82AD49;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD4C: CPX.W #$0039                         ;82AD4C;      ;
                       BNE CODE_82AD54                      ;82AD4F;82AD54;
                       JMP.W CODE_82AEE5                    ;82AD51;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD54: CPX.W #$0052                         ;82AD54;      ;
                       BNE CODE_82AD5C                      ;82AD57;82AD5C;
                       JMP.W CODE_82AEE5                    ;82AD59;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD5C: CPX.W #$0053                         ;82AD5C;      ;
                       BNE CODE_82AD64                      ;82AD5F;82AD64;
                       JMP.W CODE_82AEE5                    ;82AD61;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD64: CPX.W #$0060                         ;82AD64;      ;
                       BNE CODE_82AD6C                      ;82AD67;82AD6C;
                       JMP.W CODE_82AEE5                    ;82AD69;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD6C: CPX.W #$0061                         ;82AD6C;      ;
                       BNE CODE_82AD74                      ;82AD6F;82AD74;
                       JMP.W CODE_82AEE5                    ;82AD71;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD74: CPX.W #$006E                         ;82AD74;      ;
                       BNE CODE_82AD7C                      ;82AD77;82AD7C;
                       JMP.W CODE_82AEE5                    ;82AD79;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD7C: CPX.W #$006F                         ;82AD7C;      ;
                       BNE CODE_82AD84                      ;82AD7F;82AD84;
                       JMP.W CODE_82AEE5                    ;82AD81;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD84: %Set16bit(!M)                             ;82AD84;      ;
                       TXA                                  ;82AD86;      ;
                       ASL A                                ;82AD87;      ;
                       ASL A                                ;82AD88;      ;
                       TAY                                  ;82AD89;      ;
                       INY                                  ;82AD8A;      ;
                       %Set8bit(!M)                             ;82AD8B;      ;
                       LDA.B [$0D],Y                        ;82AD8D;00000D;
                       AND.B #$80                           ;82AD8F;      ;
                       BNE CODE_82AD96                      ;82AD91;82AD96;
                       JMP.W CODE_82ADC5                    ;82AD93;82ADC5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AD96: DEY                                  ;82AD96;      ;
                       LDA.B [$0D],Y                        ;82AD97;00000D;
                       STA.W $091F                          ;82AD99;00091F;
                       %Set16bit(!M)                             ;82AD9C;      ;
                       TXA                                  ;82AD9E;      ;
                       ASL A                                ;82AD9F;      ;
                       ASL A                                ;82ADA0;      ;
                       STA.B $7E                            ;82ADA1;00007E;
                       %Set8bit(!M)                             ;82ADA3;      ;
                       LDA.B #$00                           ;82ADA5;      ;
                       XBA                                  ;82ADA7;      ;
                       LDA.L !season                        ;82ADA8;7F1F19;
                       %Set16bit(!M)                             ;82ADAC;      ;
                       CLC                                  ;82ADAE;      ;
                       ADC.B $7E                            ;82ADAF;00007E;
                       TAX                                  ;82ADB1;      ;
                       %Set8bit(!M)                             ;82ADB2;      ;
                       LDA.L DATA8_82CFB4,X                 ;82ADB4;82CFB4;
                       STA.W !item_on_hand                          ;82ADB8;00091D;
                       %Set16bit(!MX)                             ;82ADBB;      ;
                       LDA.W #$0004                         ;82ADBD;      ;
                       STA.B !player_action                            ;82ADC0;0000D4;
                       JMP.W CODE_82AEE5                    ;82ADC2;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82ADC5: %Set8bit(!M)                             ;82ADC5;      ;
                       INY                                  ;82ADC7;      ;
                       LDA.B [$0D],Y                        ;82ADC8;00000D;
                       AND.B #$01                           ;82ADCA;      ;
                       BNE CODE_82ADD1                      ;82ADCC;82ADD1;
                       JMP.W CODE_82AEE6                    ;82ADCE;82AEE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82ADD1: %Set16bit(!MX)                             ;82ADD1;      ;
                       LDA.B !game_state                            ;82ADD3;0000D2;
                       AND.W #$0020                         ;82ADD5;      ;
                       BEQ CODE_82ADDD                      ;82ADD8;82ADDD;
                       JMP.W CODE_82AEE5                    ;82ADDA;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82ADDD: JMP.W CODE_82AEE5                    ;82ADDD;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82ADE0: %Set16bit(!M)                             ;82ADE0;      ;
                       TXA                                  ;82ADE2;      ;
                       ASL A                                ;82ADE3;      ;
                       ASL A                                ;82ADE4;      ;
                       TAY                                  ;82ADE5;      ;
                       %Set8bit(!M)                             ;82ADE6;      ;
                       LDA.B #$00                           ;82ADE8;      ;
                       XBA                                  ;82ADEA;      ;
                       LDA.B [$0D],Y                        ;82ADEB;00000D;
                       STA.B $92                            ;82ADED;000092;
                       INY                                  ;82ADEF;      ;
                       LDA.B [$0D],Y                        ;82ADF0;00000D;
                       STA.B $93                            ;82ADF2;000093;
                       BNE CODE_82ADF9                      ;82ADF4;82ADF9;
                       JMP.W CODE_82AEE5                    ;82ADF6;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82ADF9: LDA.B #$00                           ;82ADF9;      ;
                       XBA                                  ;82ADFB;      ;
                       LDA.B $92                            ;82ADFC;000092;
                       %Set16bit(!M)                             ;82ADFE;      ;
                       ASL A                                ;82AE00;      ;
                       ASL A                                ;82AE01;      ;
                       ASL A                                ;82AE02;      ;
                       INC A                                ;82AE03;      ;
                       INC A                                ;82AE04;      ;
                       INC A                                ;82AE05;      ;
                       TAX                                  ;82AE06;      ;
                       %Set8bit(!M)                             ;82AE07;      ;
                       LDA.L Unk_Table13,X                  ;82AE09;80B6F5;
                       AND.B #$02                           ;82AE0D;      ;
                       BEQ CODE_82AE1B                      ;82AE0F;82AE1B;
                       LDA.L !hour                        ;82AE11;7F1F1C;
                       CMP.B #$11                           ;82AE15;      ;
                       BCC CODE_82AE1B                      ;82AE17;82AE1B;
                       BRA CODE_82AE81                      ;82AE19;82AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE1B: %Set8bit(!M)                             ;82AE1B;      ;
                       LDA.L Unk_Table13,X                  ;82AE1D;80B6F5;
                       AND.B #$04                           ;82AE21;      ;
                       BEQ CODE_82AE2F                      ;82AE23;82AE2F;
                       LDA.L !hour                        ;82AE25;7F1F1C;
                       CMP.B #$11                           ;82AE29;      ;
                       BCS CODE_82AE2F                      ;82AE2B;82AE2F;
                       BRA CODE_82AE81                      ;82AE2D;82AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE2F: %Set8bit(!M)                             ;82AE2F;      ;
                       LDA.L Unk_Table13,X                  ;82AE31;80B6F5;
                       AND.B #$08                           ;82AE35;      ;
                       BEQ CODE_82AE45                      ;82AE37;82AE45;
                       LDA.L !weekday                        ;82AE39;7F1F1A;
                       BEQ CODE_82AE45                      ;82AE3D;82AE45;
                       CMP.B #$06                           ;82AE3F;      ;
                       BEQ CODE_82AE45                      ;82AE41;82AE45;
                       BRA CODE_82AE81                      ;82AE43;82AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE45: %Set8bit(!M)                             ;82AE45;      ;
                       LDA.L Unk_Table13,X                  ;82AE47;80B6F5;
                       AND.B #$10                           ;82AE4B;      ;
                       BEQ CODE_82AE59                      ;82AE4D;82AE59;
                       LDA.L !weekday                        ;82AE4F;7F1F1A;
                       CMP.B #$06                           ;82AE53;      ;
                       BNE CODE_82AE59                      ;82AE55;82AE59;
                       BRA CODE_82AE81                      ;82AE57;82AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE59: %Set8bit(!M)                             ;82AE59;      ;
                       LDA.L Unk_Table13,X                  ;82AE5B;80B6F5;
                       AND.B #$20                           ;82AE5F;      ;
                       BEQ CODE_82AE6B                      ;82AE61;82AE6B;
                       LDA.L !weekday                        ;82AE63;7F1F1A;
                       BNE CODE_82AE6B                      ;82AE67;82AE6B;
                       BRA CODE_82AE81                      ;82AE69;82AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE6B: %Set8bit(!M)                             ;82AE6B;      ;
                       LDA.L Unk_Table13,X                  ;82AE6D;80B6F5;
                       AND.B #$80                           ;82AE71;      ;
                       BEQ CODE_82AEE5                      ;82AE73;82AEE5;
                       %Set16bit(!M)                             ;82AE75;      ;
                       LDA.W $0196                          ;82AE77;000196;
                       AND.W #$0010                         ;82AE7A;      ;
                       BEQ CODE_82AEE5                      ;82AE7D;82AEE5;
                       BRA CODE_82AE81                      ;82AE7F;82AE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE81: %Set8bit(!M)                             ;82AE81;      ;
                       LDA.B #$02                           ;82AE83;      ;
                       STA.W !inputstate                          ;82AE85;00019A;
                       LDA.B #$00                           ;82AE88;      ;
                       STA.W $0191                          ;82AE8A;000191;
                       LDA.B #$00                           ;82AE8D;      ;
                       XBA                                  ;82AE8F;      ;
                       LDA.B $93                            ;82AE90;000093;
                       %Set16bit(!M)                             ;82AE92;      ;
                       TAX                                  ;82AE94;      ;
                       JSL.L CODE_83935F                    ;82AE95;83935F;
                       BRA CODE_82AEE5                      ;82AE99;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AE9B: %Set16bit(!M)                             ;82AE9B;      ;
                       TXA                                  ;82AE9D;      ;
                       ASL A                                ;82AE9E;      ;
                       ASL A                                ;82AE9F;      ;
                       TAY                                  ;82AEA0;      ;
                       LDA.B [$0D],Y                        ;82AEA1;00000D;
                       TAX                                  ;82AEA3;      ;
                       %Set8bit(!M)                             ;82AEA4;      ;
                       %Set16bit(!X)                             ;82AEA6;      ;
                       LDA.B #$02                           ;82AEA8;      ;
                       STA.W !inputstate                          ;82AEAA;00019A;
                       LDA.B #$00                           ;82AEAD;      ;
                       STA.W $0191                          ;82AEAF;000191;
                       JSL.L CODE_83935F                    ;82AEB2;83935F;
                       BRA CODE_82AEE5                      ;82AEB6;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AEB8: BRA CODE_82AEE5                      ;82AEB8;82AEE5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AEBA: %Set16bit(!M)                             ;82AEBA;      ;
                       TXA                                  ;82AEBC;      ;
                       ASL A                                ;82AEBD;      ;
                       ASL A                                ;82AEBE;      ;
                       TAY                                  ;82AEBF;      ;
                       INY                                  ;82AEC0;      ;
                       %Set8bit(!M)                             ;82AEC1;      ;
                       LDA.B [$0D],Y                        ;82AEC3;00000D;
                       AND.B #$01                           ;82AEC5;      ;
                       BEQ CODE_82AEE5                      ;82AEC7;82AEE5;
                       DEY                                  ;82AEC9;      ;
                       LDA.B [$0D],Y                        ;82AECA;00000D;
                       STA.W $096E                          ;82AECC;00096E;
                       STZ.W $096F                          ;82AECF;00096F;
                       STZ.W $0970                          ;82AED2;000970;
                       %Set16bit(!MX)                             ;82AED5;      ;
                       LDA.B !game_state                            ;82AED7;0000D2;
                       ORA.W #$0040                         ;82AED9;      ;
                       STA.B !game_state                            ;82AEDC;0000D2;
                       %Set16bit(!MX)                             ;82AEDE;      ;
                       LDA.W #$0000                         ;82AEE0;      ;
                       STA.B !player_action                            ;82AEE3;0000D4;
                                                            ;      ;      ;
          CODE_82AEE5: RTL                                  ;82AEE5;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82AEE6: %Set16bit(!M)                             ;82AEE6;      ;
                       LDA.B !player_pos_X                           ;82AEE8;0000D6;
                       STA.B $DF                            ;82AEEA;0000DF;
                       LDA.B !player_pos_Y                            ;82AEEC;0000D8;
                       STA.B $E1                            ;82AEEE;0000E1;
                       STZ.B $E5                            ;82AEF0;0000E5;
                       STZ.B $E7                            ;82AEF2;0000E7;
                       LDA.W #$0010                         ;82AEF4;      ;
                       STA.B $E3                            ;82AEF7;0000E3;
                       LDA.B !player_direction                            ;82AEF9;0000DA;
                       JSL.L CBBBB                          ;82AEFB;83AD91;
                       RTL                                  ;82AEFF;      ;
                                                            ;      ;      ;
;;;;;;;
UNK_PartialMap: ;82AF00
       %Set16bit(!MX)
       LDY.W #$0000

    .bigloop:
       LDX.W #$0000

    .loop1:
       PHY
       PHX
       STX.B $82
       STY.B $84
       JSR.W UNK_OperatesOnSeasonTable
       %Set8bit(!M)
       %Set16bit(!X)
       LDA.W $09B6,X
       BNE +
       JMP.W .jump2

     + CMP.B #$A0
       BCC .skip2
       JMP.W .jump2

    .skip2:
       CMP.B #$73                           ;82AF24;      ;
       BCS .skip3                           ;82AF26;82AF2B;
       JMP.W .jump3                         ;82AF28;82AFE5;
                                          ;      ;      ;
                                          ;      ;      ;
       .skip3: CMP.B #$7A                           ;82AF2B;      ;
       BCC .skip4                           ;82AF2D;82AF32;
       JMP.W .jump3                         ;82AF2F;82AFE5;
                                          ;      ;      ;
                                          ;      ;      ;
       .skip4: %Set16bit(!M)                             ;82AF32;      ;
       STZ.B $86                            ;82AF34;000086;
       PHX                                  ;82AF36;      ;
       TXA                                  ;82AF37;      ;
       SEC                                  ;82AF38;      ;
       SBC.W #$0001                         ;82AF39;      ;
       TAX                                  ;82AF3C;      ;
       %Set8bit(!M)                             ;82AF3D;      ;
       %Set16bit(!X)                             ;82AF3F;      ;
       LDA.W $09B6,X                        ;82AF41;0009B6;
       PLX                                  ;82AF44;      ;
       CMP.B #$73                           ;82AF45;      ;
       BCC .skip5                           ;82AF47;82AF56;
       CMP.B #$7A                           ;82AF49;      ;
       BCS .skip5                           ;82AF4B;82AF56;
       %Set16bit(!M)                             ;82AF4D;      ;
       LDA.B $86                            ;82AF4F;000086;
       ORA.W #$0008                         ;82AF51;      ;
       STA.B $86                            ;82AF54;000086;
                                          ;      ;      ;
       .skip5: %Set16bit(!MX)                             ;82AF56;      ;
       PHX                                  ;82AF58;      ;
       TXA                                  ;82AF59;      ;
       CLC                                  ;82AF5A;      ;
       ADC.W #$0001                         ;82AF5B;      ;
       TAX                                  ;82AF5E;      ;
       %Set8bit(!M)                             ;82AF5F;      ;
       %Set16bit(!X)                             ;82AF61;      ;
       LDA.W $09B6,X                        ;82AF63;0009B6;
       PLX                                  ;82AF66;      ;
       CMP.B #$73                           ;82AF67;      ;
       BCC .skip6                           ;82AF69;82AF78;
       CMP.B #$7A                           ;82AF6B;      ;
       BCS .skip6                           ;82AF6D;82AF78;
       %Set16bit(!M)                             ;82AF6F;      ;
       LDA.B $86                            ;82AF71;000086;
       ORA.W #$0002                         ;82AF73;      ;
       STA.B $86                            ;82AF76;000086;
                                          ;      ;      ;
       .skip6: %Set16bit(!MX)                             ;82AF78;      ;
       PHX                                  ;82AF7A;      ;
       TXA                                  ;82AF7B;      ;
       SEC                                  ;82AF7C;      ;
       SBC.W #$0040                         ;82AF7D;      ;
       TAX                                  ;82AF80;      ;
       %Set8bit(!M)                             ;82AF81;      ;
       %Set16bit(!X)                             ;82AF83;      ;
       LDA.W $09B6,X                        ;82AF85;0009B6;
       PLX                                  ;82AF88;      ;
       CMP.B #$73                           ;82AF89;      ;
       BCC .skip7                           ;82AF8B;82AF9A;
       CMP.B #$7A                           ;82AF8D;      ;
       BCS .skip7                           ;82AF8F;82AF9A;
       %Set16bit(!M)                             ;82AF91;      ;
       LDA.B $86                            ;82AF93;000086;
       ORA.W #$0004                         ;82AF95;      ;
       STA.B $86                            ;82AF98;000086;
                                          ;      ;      ;
       .skip7: %Set16bit(!MX)                             ;82AF9A;      ;
       PHX                                  ;82AF9C;      ;
       TXA                                  ;82AF9D;      ;
       CLC                                  ;82AF9E;      ;
       ADC.W #$0040                         ;82AF9F;      ;
       TAX                                  ;82AFA2;      ;
       %Set8bit(!M)                             ;82AFA3;      ;
       %Set16bit(!X)                             ;82AFA5;      ;
       LDA.W $09B6,X                        ;82AFA7;0009B6;
       PLX                                  ;82AFAA;      ;
       CMP.B #$73                           ;82AFAB;      ;
       BCC .skip8                           ;82AFAD;82AFBC;
       CMP.B #$7A                           ;82AFAF;      ;
       BCS .skip8                           ;82AFB1;82AFBC;
       %Set16bit(!M)                             ;82AFB3;      ;
       LDA.B $86                            ;82AFB5;000086;
       ORA.W #$0001                         ;82AFB7;      ;
       STA.B $86                            ;82AFBA;000086;
                                          ;      ;      ;
       .skip8: %Set16bit(!MX)                             ;82AFBC;      ;
       PHX                                  ;82AFBE;      ;
       LDA.B $86                            ;82AFBF;000086;
       TAX                                  ;82AFC1;      ;
       %Set8bit(!M)                             ;82AFC2;      ;
       LDA.L DATA8_82B02A,X                 ;82AFC4;82B02A;
       DEC A                                ;82AFC8;      ;
       STA.B $94                            ;82AFC9;000094;
       PLX                                  ;82AFCB;      ;
       %Set8bit(!M)                             ;82AFCC;      ;
       LDA.B #$00                           ;82AFCE;      ;
       XBA                                  ;82AFD0;      ;
       LDA.W $09B6,X                        ;82AFD1;0009B6;
       %Set16bit(!M)                             ;82AFD4;      ;
       ASL A                                ;82AFD6;      ;
       ASL A                                ;82AFD7;      ;
       TAY                                  ;82AFD8;      ;
       %Set8bit(!M)                             ;82AFD9;      ;
       LDA.B #$00                           ;82AFDB;      ;
       XBA                                  ;82AFDD;      ;
       LDA.B [$0D],Y                        ;82AFDE;00000D;
       CLC                                  ;82AFE0;      ;
       ADC.B $94                            ;82AFE1;000094;
       BRA .skip9                           ;82AFE3;82AFFF;
                                          ;      ;      ;
                                          ;      ;      ;
       .jump3: %Set8bit(!M)                             ;82AFE5;      ;
       %Set16bit(!X)                             ;82AFE7;      ;
       LDA.B #$00                           ;82AFE9;      ;
       XBA                                  ;82AFEB;      ;
       LDA.W $09B6,X                        ;82AFEC;0009B6;
       %Set16bit(!M)                             ;82AFEF;      ;
       ASL A                                ;82AFF1;      ;
       ASL A                                ;82AFF2;      ;
       TAY                                  ;82AFF3;      ;
       %Set8bit(!M)                             ;82AFF4;      ;
       LDA.B #$00                           ;82AFF6;      ;
       XBA                                  ;82AFF8;      ;
       LDA.B [$0D],Y                        ;82AFF9;00000D;
       BEQ .jump2                           ;82AFFB;82B009;
       %Set16bit(!M)                             ;82AFFD;      ;
                                          ;      ;      ;
       .skip9: %Set16bit(!MX)                             ;82AFFF;      ;
       LDX.B $82                            ;82B001;000082;
       LDY.B $84                            ;82B003;000084;
       JSL.L UUUU                           ;82B005;81A83A;
                                          ;      ;      ;
       .jump2: %Set16bit(!MX)                             ;82B009;      ;
       PLX                                  ;82B00B;      ;
       PLY                                  ;82B00C;      ;
       TXA                                  ;82B00D;      ;
       CLC                                  ;82B00E;      ;
       ADC.W #$0010                         ;82B00F;      ;
       TAX                                  ;82B012;      ;
       CPX.W #$0400                         ;82B013;      ;
       BEQ .skip10                          ;82B016;82B01B;
       JMP.W .loop1                         ;82B018;82AF08;

    .skip10:
       TYA                                  ;82B01B;      ;
       CLC                                  ;82B01C;      ;
       ADC.W #$0010                         ;82B01D;      ;
       TAY                                  ;82B020;      ;
       CPY.W #$0400                         ;82B021;      ;
       BEQ .return                          ;82B024;82B029;
       JMP.W .bigloop                         ;82B026;82AF05;

    .return: RTL
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_82B02A: db $09,$02,$07,$01,$07,$04,$07,$04,$09,$03,$08,$02,$09,$06,$08,$05;82B02A;      ;
                                                            ;      ;      ;
          UNK_MOVE_FROM_SEASON_TO_09B6: %Set8bit(!M)                             ;82B03A;      ;
                       %Set16bit(!X)                             ;82B03C;      ;
                       PHA                                  ;82B03E;      ;
                       JSR.W UNK_OperatesOnSeasonTable      ;82B03F;82B13C;
                       %Set8bit(!M)                             ;82B042;      ;
                       PLA                                  ;82B044;      ;
                       STA.W $09B6,X                        ;82B045;0009B6;
                       RTL                                  ;82B048;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82B049: %Set8bit(!M)                             ;82B049;      ;
                       %Set16bit(!X)                             ;82B04B;      ;
                       PHA                                  ;82B04D;      ;
                       LDA.B #$04                           ;82B04E;      ;
                       STA.W $0181                          ;82B050;000181;
                       PLA                                  ;82B053;      ;
                       PHA                                  ;82B054;      ;
                       JSR.W UNK_OperatesOnSeasonTable      ;82B055;82B13C;
                       %Set8bit(!M)                             ;82B058;      ;
                       PLA                                  ;82B05A;      ;
                       STA.L $7EA4E6,X                      ;82B05B;7EA4E6;
                       RTL                                  ;82B05F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82B060: %Set8bit(!M)                             ;82B060;      ;
                       %Set16bit(!X)                             ;82B062;      ;
                       STA.B $99                            ;82B064;000099;
                       STX.B $82                            ;82B066;000082;
                       STY.B $84                            ;82B068;000084;
                       LDY.W #$0000                         ;82B06A;      ;
                                                            ;      ;      ;
          CODE_82B06D: PHY                                  ;82B06D;      ;
                       TYA                                  ;82B06E;      ;
                       ASL A                                ;82B06F;      ;
                       ASL A                                ;82B070;      ;
                       ASL A                                ;82B071;      ;
                       ASL A                                ;82B072;      ;
                       STA.B $8E                            ;82B073;00008E;
                       LDX.W #$0000                         ;82B075;      ;
                                                            ;      ;      ;
          CODE_82B078: PHX                                  ;82B078;      ;
                       TXA                                  ;82B079;      ;
                       ASL A                                ;82B07A;      ;
                       ASL A                                ;82B07B;      ;
                       ASL A                                ;82B07C;      ;
                       ASL A                                ;82B07D;      ;
                       STA.B $90                            ;82B07E;000090;
                       %Set16bit(!MX)                             ;82B080;      ;
                       LDA.B $82                            ;82B082;000082;
                       CLC                                  ;82B084;      ;
                       ADC.B $8E                            ;82B085;00008E;
                       TAX                                  ;82B087;      ;
                       LDA.B $84                            ;82B088;000084;
                       CLC                                  ;82B08A;      ;
                       ADC.B $90                            ;82B08B;000090;
                       TAY                                  ;82B08D;      ;
                       JSR.W UNK_OperatesOnSeasonTable      ;82B08E;82B13C;
                       %Set8bit(!M)                             ;82B091;      ;
                       %Set16bit(!X)                             ;82B093;      ;
                       LDA.B $99                            ;82B095;000099;
                       STA.W $09B6,X                        ;82B097;0009B6;
                       PLX                                  ;82B09A;      ;
                       INX                                  ;82B09B;      ;
                       CPX.B $86                            ;82B09C;000086;
                       BNE CODE_82B078                      ;82B09E;82B078;
                       PLY                                  ;82B0A0;      ;
                       INY                                  ;82B0A1;      ;
                       CPY.B $88                            ;82B0A2;000088;
                       BNE CODE_82B06D                      ;82B0A4;82B06D;
                       RTL                                  ;82B0A6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82B0A7: %Set16bit(!MX)                             ;82B0A7;      ;
                       STX.B $8E                            ;82B0A9;00008E;
                       STY.B $90                            ;82B0AB;000090;
                       JSL.L CODE_81A801                    ;82B0AD;81A801;
                       %Set16bit(!MX)                             ;82B0B1;      ;
                       LDA.W #$F500                         ;82B0B3;      ;
                       STA.B $72                            ;82B0B6;000072;
                       %Set8bit(!M)                             ;82B0B8;      ;
                       LDA.B #$A7                           ;82B0BA;      ;
                       STA.B $74                            ;82B0BC;000074;
                       %Set16bit(!M)                             ;82B0BE;      ;
                       LDA.B $7E                            ;82B0C0;00007E;
                       AND.W #$007F                         ;82B0C2;      ;
                       LSR A                                ;82B0C5;      ;
                       LSR A                                ;82B0C6;      ;
                       STA.B $86                            ;82B0C7;000086;
                       LDA.B $7E                            ;82B0C9;00007E;
                       LSR A                                ;82B0CB;      ;
                       LSR A                                ;82B0CC;      ;
                       LSR A                                ;82B0CD;      ;
                       LSR A                                ;82B0CE;      ;
                       LSR A                                ;82B0CF;      ;
                       LSR A                                ;82B0D0;      ;
                       LSR A                                ;82B0D1;      ;
                       ASL A                                ;82B0D2;      ;
                       ASL A                                ;82B0D3;      ;
                       ASL A                                ;82B0D4;      ;
                       ASL A                                ;82B0D5;      ;
                       CLC                                  ;82B0D6;      ;
                       ADC.B $86                            ;82B0D7;000086;
                       STA.B $86                            ;82B0D9;000086;
                       LDA.B $82                            ;82B0DB;000082;
                       STA.B $84                            ;82B0DD;000084;
                       LDA.B $80                            ;82B0DF;000080;
                       STA.B $82                            ;82B0E1;000082;
                       LDY.W #$0000                         ;82B0E3;      ;
                                                            ;      ;      ;
          CODE_82B0E6: PHY                                  ;82B0E6;      ;
                       LDX.W #$0000                         ;82B0E7;      ;
                                                            ;      ;      ;
          CODE_82B0EA: %Set16bit(!MX)                             ;82B0EA;      ;
                       PHX                                  ;82B0EC;      ;
                       PHY                                  ;82B0ED;      ;
                       LDY.B $86                            ;82B0EE;000086;
                       INC.B $86                            ;82B0F0;000086;
                       %Set8bit(!M)                             ;82B0F2;      ;
                       LDA.B [$72],Y                        ;82B0F4;000072;
                       PLY                                  ;82B0F6;      ;
                       PHY                                  ;82B0F7;      ;
                       PHA                                  ;82B0F8;      ;
                       %Set16bit(!M)                             ;82B0F9;      ;
                       TXA                                  ;82B0FB;      ;
                       ASL A                                ;82B0FC;      ;
                       ASL A                                ;82B0FD;      ;
                       ASL A                                ;82B0FE;      ;
                       ASL A                                ;82B0FF;      ;
                       CLC                                  ;82B100;      ;
                       ADC.B $8E                            ;82B101;00008E;
                       TAX                                  ;82B103;      ;
                       TYA                                  ;82B104;      ;
                       ASL A                                ;82B105;      ;
                       ASL A                                ;82B106;      ;
                       ASL A                                ;82B107;      ;
                       ASL A                                ;82B108;      ;
                       CLC                                  ;82B109;      ;
                       ADC.B $90                            ;82B10A;000090;
                       TAY                                  ;82B10C;      ;
                       %Set8bit(!M)                             ;82B10D;      ;
                       PLA                                  ;82B10F;      ;
                       JSL.L UNK_MOVE_FROM_SEASON_TO_09B6                    ;82B110;82B03A;
                       %Set16bit(!MX)                             ;82B114;      ;
                       PLY                                  ;82B116;      ;
                       PLX                                  ;82B117;      ;
                       INX                                  ;82B118;      ;
                       CPX.B $82                            ;82B119;000082;
                       BNE CODE_82B0EA                      ;82B11B;82B0EA;
                       PLY                                  ;82B11D;      ;
                       INY                                  ;82B11E;      ;
                       CPY.B $84                            ;82B11F;000084;
                       BNE CODE_82B0E6                      ;82B121;82B0E6;
                       RTL                                  ;82B123;      ;

;;;;;;; TODO
CODE_82B124: ;82B124
      %Set16bit(!MX)
      JSR.W UNK_OperatesOnSeasonTable
      %Set8bit(!M)
      LDA.W $09B6,X
      RTL

      %Set16bit(!MX)
      TXA
      AND.W #$FFF0
      TAX
      TYA
      AND.W #$FFF0
      TAY

      RTL

;;;;;;; Takes X and Y as parameter
UNK_OperatesOnSeasonTable: ;82B13C
       %Set16bit(!MX)
       TXA
       LSR A
       LSR A
       LSR A
       LSR A                                 ; / 4
       STA.B $7E
       TYA
       AND.W #$FFF0                          ;4 bits from Y
       STA.B $80
       %Set8bit(!M)
       LDA.W $0181
       CMP.B #$01
       BEQ .skip1
       %Set16bit(!M)
       LDA.B $80
       ASL A
       STA.B $80
       %Set8bit(!M)
       LDA.W $0181
       CMP.B #$02
       BEQ .skip1
       %Set16bit(!M)
       LDA.B $80
       ASL A
       STA.B $80

    .skip1:
       %Set16bit(!M)
       LDA.B $7E
       CLC
       ADC.B $80
       TAX

       RTS

FarmMapPointerTable: dl $A78000,$A78000,$A78000,$A78000,$A79600,$A79600,$A79600,$A79600,$A7F000;82B173
                     dl $A7DC00,$A7D800,$A7E000,$A79400,$A79400,$A79400,$A79400,$A7A600,$A7A600
                     dl $A7A600,$A7A600,$A7F400,$A79000,$A79100,$A79200,$A7C300,$A7C300,$A7C300
                     dl $A7C700,$A7C900,$A7C900,$A7CB00,$A7CB00,$A7CD00,$A7CD00,$A7CF00,$A7CF00
                     dl $A7D100,$A7D200,$A79500,$A7B600,$A7B800,$A7BC00,$A7B900,$A7C000,$A7D300
                     dl $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$A7C100,$A7C100,$A7C100,$A7C100,$A7C100
                     dl $A7C100,$A7C100,$A7C100,$A7C100,$A7C100,$A7C100,$FFFFFF,$FFFFFF,$FFFFFF
                     dl $FFFFFF,$A7F700,$FFFFFF,$FFFFFF,$FFFFFF,$A7F800,$A7F900,$A7FA00,$A7FB00
                     dl $FFFFFF,$A7FC00,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF
                     dl $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF
                     dl $FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF,$FFFFFF

         DATA8_82B294: db $B4,$B3,$82,$B4,$B3,$82,$B4,$B3,$82,$B4,$B3,$82,$B4,$BF,$82,$B4;82B294;      ;
                       db $BF,$82,$B4,$BF,$82,$B4,$BF,$82,$B4,$BF,$82,$B4,$BF,$82,$B4,$BF;82B2A4;      ;
                       db $82,$B4,$BF,$82,$B4,$BB,$82,$B4,$BB,$82,$B4,$BB,$82,$B4,$BB,$82;82B2B4;      ;
                       db $B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4;82B2C4;      ;
                       db $B7,$82,$B4,$B7,$82,$B4,$B7,$82,$B4,$C7,$82,$B4,$C7,$82,$B4,$C7;82B2D4;      ;
                       db $82,$B4,$C7,$82,$B4,$C7,$82,$B4,$C7,$82,$B4,$CB,$82,$B4,$CB,$82;82B2E4;      ;
                       db $B4,$CB,$82,$B4,$CB,$82,$B4,$CB,$82,$B4,$CB,$82,$B4,$C7,$82,$B4;82B2F4;      ;
                       db $CB,$82,$B4,$BB,$82,$B4,$BB,$82,$B4,$BB,$82,$B4,$C3,$82,$B4,$B7;82B304;      ;
                       db $82,$B4,$C3,$82,$B4,$B7,$82,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;82B314;      ;
                       db $FF,$FF,$FF,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4;82B324;      ;
                       db $C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3,$82,$B4,$C3;82B334;      ;
                       db $82,$B4,$C3,$82,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;82B344;      ;
                       db $B4,$B3,$82,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$B4,$B3,$82,$B4;82B354;      ;
                       db $B3,$82,$B4,$B3,$82,$B4,$B3,$82,$FF,$FF,$FF,$B4,$B3,$82,$FF,$FF;82B364;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;82B374;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;82B384;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;82B394;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;82B3A4;      ;
                       db $00,$00,$00,$FF,$00,$02,$00,$FF,$0E,$02,$00,$FF,$0F,$81,$01,$7F;82B3B4;      ;
                       db $10,$84,$01,$FF,$14,$80,$21,$FF,$15,$04,$01,$FF,$17,$32,$00,$FF;82B3C4;      ;
                       db $18,$22,$00,$FF,$00,$08,$01,$FF,$00,$08,$01,$FF,$00,$08,$01,$FF;82B3D4;      ;
                       db $00,$08,$01,$FF,$00,$04,$01,$FF,$00,$04,$01,$FF,$00,$04,$01,$FF;82B3E4;      ;
                       db $00,$04,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B3F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B404;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B414;      ;
                       db $00,$00,$00,$FF,$ED,$00,$00,$FF,$EB,$10,$00,$FF,$EC,$00,$00,$FF;82B424;      ;
                       db $1A,$10,$00,$FF,$1D,$00,$00,$FF,$1F,$11,$01,$FF,$20,$01,$01,$FF;82B434;      ;
                       db $21,$11,$01,$FF,$22,$01,$01,$FF,$1A,$10,$00,$FF,$1D,$00,$00,$FF;82B444;      ;
                       db $1A,$10,$00,$FF,$1D,$00,$00,$FF,$1F,$11,$01,$FF,$20,$01,$01,$FF;82B454;      ;
                       db $1F,$11,$01,$FF,$20,$01,$01,$FF,$21,$11,$01,$FF,$22,$01,$01,$FF;82B464;      ;
                       db $21,$11,$01,$FF,$22,$01,$01,$FF,$23,$11,$01,$FF,$24,$01,$01,$FF;82B474;      ;
                       db $23,$11,$01,$FF,$24,$01,$01,$FF,$23,$11,$01,$FF,$24,$01,$01,$FF;82B484;      ;
                       db $25,$91,$01,$7F,$26,$81,$01,$7F,$19,$10,$00,$FF,$1D,$00,$00,$FF;82B494;      ;
                       db $19,$10,$00,$FF,$1D,$00,$00,$FF,$19,$10,$00,$FF,$1D,$00,$00,$FF;82B4A4;      ;
                       db $27,$11,$01,$FF,$28,$01,$01,$FF,$27,$11,$01,$FF,$28,$01,$01,$FF;82B4B4;      ;
                       db $27,$11,$01,$FF,$28,$01,$01,$FF,$29,$11,$01,$FF,$2A,$01,$01,$FF;82B4C4;      ;
                       db $29,$11,$01,$FF,$2A,$01,$01,$FF,$29,$11,$01,$FF,$2A,$01,$01,$FF;82B4D4;      ;
                       db $2B,$11,$01,$FF,$2C,$01,$01,$FF,$2B,$11,$01,$FF,$2C,$01,$01,$FF;82B4E4;      ;
                       db $2B,$11,$01,$FF,$2C,$01,$01,$FF,$2D,$91,$01,$7F,$2E,$81,$01,$7F;82B4F4;      ;
                       db $1B,$10,$00,$FF,$1D,$00,$00,$FF,$1B,$10,$00,$FF,$1D,$00,$00,$FF;82B504;      ;
                       db $1B,$10,$00,$FF,$1D,$00,$00,$FF,$2F,$11,$01,$FF,$30,$01,$01,$FF;82B514;      ;
                       db $2F,$11,$01,$FF,$30,$01,$01,$FF,$2F,$11,$01,$FF,$30,$01,$01,$FF;82B524;      ;
                       db $31,$91,$01,$7F,$32,$81,$01,$7F,$1C,$10,$00,$FF,$1D,$00,$00,$FF;82B534;      ;
                       db $33,$11,$01,$FF,$34,$01,$01,$FF,$1C,$10,$00,$FF,$1D,$00,$00,$FF;82B544;      ;
                       db $1C,$10,$00,$FF,$1D,$00,$00,$FF,$33,$11,$01,$FF,$34,$01,$01,$FF;82B554;      ;
                       db $33,$11,$01,$FF,$34,$01,$01,$FF,$35,$91,$01,$7F,$36,$81,$01,$7F;82B564;      ;
                       db $1E,$00,$00,$FF,$1E,$00,$00,$FF,$1E,$00,$00,$FF,$37,$00,$00,$FF;82B574;      ;
                       db $37,$00,$00,$FF,$37,$00,$00,$FF,$40,$00,$00,$FF,$40,$00,$00,$FF;82B584;      ;
                       db $40,$00,$00,$FF,$49,$01,$00,$FF,$52,$00,$80,$7F,$52,$00,$80,$7F;82B594;      ;
                       db $52,$00,$80,$7F,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B5A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B5B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B5C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B5D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B5E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B5F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B604;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B614;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B624;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82B634;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82B644;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B654;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B664;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B674;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B684;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B694;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B6A4;      ;
                       db $00,$00,$00,$FF,$01,$00,$00,$FF,$02,$00,$00,$FF,$03,$00,$00,$FF;82B6B4;      ;
                       db $04,$00,$00,$FF,$05,$00,$00,$FF,$06,$00,$00,$FF,$07,$00,$00,$FF;82B6C4;      ;
                       db $08,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B6D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B6E4;      ;
                       db $A2,$03,$01,$F3,$1B,$00,$01,$F3,$1C,$00,$01,$F3,$A4,$03,$01,$F3;82B6F4;      ;
                       db $83,$03,$01,$F2,$A3,$03,$01,$FF,$0E,$00,$01,$F3,$00,$01,$01,$F3;82B704;      ;
                       db $1C,$04,$01,$F3,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B714;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B724;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF;82B734;      ;
                       db $00,$00,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B744;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B754;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B764;      ;
                       db $00,$00,$01,$7F,$01,$01,$01,$FF,$02,$00,$01,$FF,$03,$01,$01,$FF;82B774;      ;
                       db $04,$00,$00,$FF,$05,$00,$00,$FF,$06,$00,$00,$FF,$07,$00,$00,$FF;82B784;      ;
                       db $08,$00,$00,$FF,$09,$00,$01,$7F,$0A,$00,$01,$7F,$0B,$00,$01,$7F;82B794;      ;
                       db $0C,$00,$01,$7F,$0D,$00,$01,$7F,$0E,$00,$00,$FF,$00,$00,$00,$FF;82B7A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B7B4;      ;
                       db $00,$04,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B7C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B7D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B7E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B7F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B804;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B814;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B824;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B834;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B844;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B854;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B864;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B874;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B884;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B894;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B8A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B8B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B8C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B8D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B8E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B8F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B904;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B914;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B924;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B934;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B944;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B954;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B964;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B974;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B984;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B994;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B9A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B9B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B9C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B9D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B9E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82B9F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA24;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82BA34;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82BA44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BA94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BAA4;      ;
                       db $09,$1D,$00,$FF,$38,$00,$00,$FF,$39,$00,$00,$FF,$3A,$00,$00,$FF;82BAB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BAC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BAD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BAE4;      ;
                       db $7E,$01,$01,$F2,$89,$03,$10,$F1,$6E,$03,$10,$F1,$79,$03,$10,$F1;82BAF4;      ;
                       db $79,$03,$01,$F2,$9F,$03,$01,$F2,$09,$00,$08,$F2,$84,$03,$08,$FF;82BB04;      ;
                       db $6F,$03,$01,$C2,$52,$01,$01,$F3,$7E,$04,$01,$F3,$8F,$04,$01,$F3;82BB14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB24;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB34;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB64;      ;
                       db $0F,$01,$08,$F2,$10,$01,$01,$F2,$11,$01,$01,$FF,$12,$01,$08,$F2;82BB74;      ;
                       db $13,$01,$08,$F2,$00,$00,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BB94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BBA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BBB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BBC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BBD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BBE4;      ;
                       db $78,$80,$01,$FF,$79,$80,$01,$FF,$7A,$80,$01,$FF,$7B,$80,$01,$FF;82BBF4;      ;
                       db $7C,$80,$01,$FF,$7D,$80,$01,$FF,$7E,$80,$01,$FF,$7F,$80,$01,$FF;82BC04;      ;
                       db $80,$80,$01,$FF,$81,$80,$01,$FF,$82,$80,$01,$FF,$83,$80,$01,$FF;82BC14;      ;
                       db $84,$80,$01,$FF,$85,$80,$01,$FF,$86,$80,$01,$FF,$87,$80,$01,$FF;82BC24;      ;
                       db $88,$80,$01,$FF,$89,$80,$01,$FF,$8A,$80,$01,$FF,$8B,$80,$01,$FF;82BC34;      ;
                       db $8C,$80,$01,$FF,$8D,$80,$01,$FF,$8E,$80,$01,$FF,$8F,$80,$01,$FF;82BC44;      ;
                       db $9D,$80,$01,$FF,$94,$80,$01,$FF,$90,$00,$01,$FF,$91,$00,$01,$FF;82BC54;      ;
                       db $92,$00,$01,$FF,$93,$00,$01,$FF,$EA,$00,$00,$FF,$00,$00,$01,$FF;82BC64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BC74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BC84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BC94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BCA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BCB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BCC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BCD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BCE4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BCF4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD24;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD34;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BD94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BDA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BDB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BDC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BDD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BDE4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BDF4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE24;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82BE34;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82BE44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BE94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BEA4;      ;
                       db $0A,$00,$00,$FF,$0B,$00,$00,$FF,$0C,$00,$00,$FF,$0D,$00,$00,$FF;82BEB4;      ;
                       db $0E,$00,$00,$FF,$0F,$00,$00,$FF,$10,$00,$00,$FF,$00,$00,$00,$FF;82BEC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BED4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BEE4;      ;
                       db $88,$03,$01,$FF,$34,$00,$01,$F2,$4D,$03,$01,$F3,$4E,$03,$01,$F3;82BEF4;      ;
                       db $4F,$03,$01,$F3,$4C,$03,$01,$F3,$4B,$03,$01,$F3,$4F,$03,$01,$F3;82BF04;      ;
                       db $1E,$00,$01,$F3,$7C,$03,$08,$F2,$00,$00,$00,$FF,$00,$00,$00,$FF;82BF14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BF24;      ;
                       db $00,$01,$00,$FF,$00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF;82BF34;      ;
                       db $00,$00,$01,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF;82BF44;      ;
                       db $00,$00,$01,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF;82BF54;      ;
                       db $00,$00,$01,$FF,$00,$00,$01,$FF,$00,$00,$01,$FF,$00,$00,$00,$FF;82BF64;      ;
                       db $14,$01,$01,$FF,$15,$01,$01,$FF,$16,$00,$01,$FF,$17,$00,$00,$FF;82BF74;      ;
                       db $18,$00,$00,$FF,$19,$00,$01,$FF,$1A,$00,$00,$FF,$1B,$00,$01,$FF;82BF84;      ;
                       db $00,$00,$00,$FF,$53,$01,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BF94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BFA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BFB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BFC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BFD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82BFE4;      ;
                       db $00,$01,$00,$FF,$00,$01,$00,$FF,$F6,$00,$01,$FF,$00,$00,$00,$FF;82BFF4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C004;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C014;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C024;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C034;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C044;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C054;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C064;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C074;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C084;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C094;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C0A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C0B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C0C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C0D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C0E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C0F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C104;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C114;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C124;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$F7,$80,$01,$FF,$F8,$80,$01,$FF;82C134;      ;
                       db $F9,$80,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C144;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C154;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C164;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C174;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C184;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C194;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C1A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C1B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C1C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C1D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C1E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C1F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C204;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C214;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C224;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82C234;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82C244;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C254;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C264;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C274;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C284;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C294;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C2A4;      ;
                       db $11,$00,$00,$FF,$12,$33,$00,$FF,$13,$33,$00,$FF,$14,$2D,$00,$FF;82C2B4;      ;
                       db $15,$2E,$00,$FF,$16,$2D,$00,$FF,$17,$2D,$00,$FF,$18,$2D,$00,$FF;82C2C4;      ;
                       db $19,$33,$00,$FF,$1A,$2D,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C2D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C2E4;      ;
                       db $33,$00,$01,$F2,$2D,$00,$01,$F2,$2D,$00,$01,$F2,$88,$03,$01,$FF;82C2F4;      ;
                       db $1C,$03,$01,$F2,$70,$03,$01,$3F,$46,$02,$01,$FF,$7E,$02,$01,$FF;82C304;      ;
                       db $8B,$02,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C314;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C324;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C334;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C344;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C354;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C364;      ;
                       db $1C,$00,$01,$FF,$1D,$01,$01,$FF,$1E,$01,$01,$FF,$51,$01,$08,$F2;82C374;      ;
                       db $52,$01,$08,$F2,$4A,$01,$01,$FF,$4B,$01,$01,$FF,$4C,$01,$01,$FF;82C384;      ;
                       db $4D,$01,$01,$FF,$4E,$01,$01,$FF,$4F,$01,$01,$FF,$50,$01,$01,$FF;82C394;      ;
                       db $57,$01,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C3A4;      ;
                       db $00,$00,$00,$FF,$DE,$00,$00,$FF,$DD,$00,$00,$FF,$9C,$00,$00,$FF;82C3B4;      ;
                       db $00,$04,$01,$FF,$00,$00,$00,$FF,$00,$81,$01,$7F,$00,$00,$00,$FF;82C3C4;      ;
                       db $00,$00,$00,$FF,$00,$08,$01,$FF,$00,$08,$01,$FF,$00,$08,$01,$FF;82C3D4;      ;
                       db $00,$08,$01,$FF,$00,$04,$01,$FF,$00,$04,$01,$FF,$00,$04,$01,$FF;82C3E4;      ;
                       db $00,$04,$01,$FF,$00,$08,$01,$FF,$00,$08,$01,$FF,$00,$08,$01,$FF;82C3F4;      ;
                       db $00,$08,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C404;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C414;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C424;      ;
                       db $E3,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C434;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C444;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C454;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C464;      ;
                       db $00,$80,$81,$1F,$00,$80,$81,$3F,$00,$80,$81,$2F,$00,$80,$81,$4F;82C474;      ;
                       db $00,$80,$81,$4F,$00,$81,$01,$7F,$00,$80,$01,$FF,$00,$80,$01,$FF;82C484;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C494;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C4A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C4B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C4C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C4D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C4E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C4F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C504;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C514;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C524;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C534;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C544;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C554;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C564;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C574;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C584;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C594;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C5A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C5B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C5C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C5D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C5E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C5F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C604;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C614;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C624;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82C634;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82C644;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C654;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C664;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C674;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C684;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C694;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C6A4;      ;
                       db $1B,$00,$00,$FF,$1C,$33,$01,$FF,$1D,$00,$00,$FF,$1E,$00,$00,$FF;82C6B4;      ;
                       db $1F,$00,$00,$FF,$20,$00,$00,$FF,$21,$00,$00,$FF,$22,$00,$00,$FF;82C6C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C6D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C6E4;      ;
                       db $20,$00,$01,$F3,$22,$00,$01,$F3,$33,$00,$01,$F2,$1D,$03,$01,$F3;82C6F4;      ;
                       db $1F,$00,$01,$F3,$8C,$03,$01,$F3,$87,$03,$01,$F3,$21,$00,$01,$F3;82C704;      ;
                       db $2C,$00,$08,$F2,$81,$03,$01,$F2,$7F,$03,$08,$F2,$90,$04,$01,$FF;82C714;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C724;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C734;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C744;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C754;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C764;      ;
                       db $1F,$02,$01,$FF,$20,$00,$01,$FF,$21,$00,$10,$FF,$22,$00,$10,$F1;82C774;      ;
                       db $23,$02,$01,$F2,$24,$00,$01,$FF,$25,$00,$01,$FF,$41,$01,$01,$FF;82C784;      ;
                       db $00,$00,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C794;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C7A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C7B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C7C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C7D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C7E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C7F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C804;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C814;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C824;      ;
                       db $BD,$00,$01,$FF,$BF,$00,$01,$FF,$DA,$00,$01,$FF,$00,$00,$00,$FF;82C834;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C844;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C854;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C864;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C874;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C884;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C894;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C8A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C8B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C8C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C8D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C8E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C8F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C904;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C914;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C924;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C934;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C944;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C954;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C964;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C974;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C984;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C994;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C9A4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C9B4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C9C4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C9D4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C9E4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82C9F4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA24;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82CA34;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82CA44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CA94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CAA4;      ;
                       db $23,$00,$00,$FF,$24,$00,$00,$FF,$25,$00,$00,$FF,$26,$00,$00,$FF;82CAB4;      ;
                       db $27,$00,$00,$FF,$28,$00,$00,$FF,$29,$00,$00,$FF,$2A,$00,$00,$FF;82CAC4;      ;
                       db $2B,$00,$00,$FF,$2C,$00,$00,$FF,$2D,$00,$00,$FF,$00,$00,$00,$FF;82CAD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CAE4;      ;
                       db $24,$00,$08,$F2,$25,$00,$08,$F2,$26,$00,$08,$F2,$82,$03,$01,$F2;82CAF4;      ;
                       db $7D,$03,$01,$F2,$6F,$03,$01,$C2,$86,$03,$08,$F2,$85,$03,$08,$F2;82CB04;      ;
                       db $A5,$03,$01,$F3,$A1,$03,$01,$FF,$27,$00,$08,$F2,$7B,$03,$01,$FF;82CB14;      ;
                       db $79,$03,$01,$FF,$7F,$03,$01,$F2,$00,$00,$00,$FF,$00,$00,$00,$FF;82CB24;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CB34;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CB44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CB54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CB64;      ;
                       db $26,$01,$01,$F2,$27,$01,$01,$32,$28,$01,$01,$22,$29,$01,$01,$22;82CB74;      ;
                       db $2A,$01,$01,$12,$2B,$01,$01,$12,$2C,$01,$01,$3F,$2D,$01,$08,$F2;82CB84;      ;
                       db $2E,$01,$01,$FF,$2F,$01,$01,$FF,$30,$01,$01,$FF,$31,$01,$01,$FF;82CB94;      ;
                       db $32,$01,$01,$FF,$54,$01,$01,$FF,$55,$01,$10,$FF,$00,$00,$00,$FF;82CBA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CBB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CBC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CBD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CBE4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CBF4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC24;      ;
                       db $D2,$00,$01,$FF,$D3,$00,$01,$FF,$C6,$00,$01,$FF,$00,$00,$00,$FF;82CC34;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CC94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CCA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CCB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CCC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CCD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CCE4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CCF4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD24;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD34;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CD94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CDA4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CDB4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CDC4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CDD4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CDE4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CDF4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE04;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE14;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE24;      ;
                       db $00,$00,$00,$FF,$00,$00,$01,$FF,$00,$00,$02,$FF,$00,$00,$04,$FF;82CE34;      ;
                       db $00,$00,$08,$FF,$00,$00,$10,$FF,$00,$00,$21,$FF,$00,$00,$41,$FF;82CE44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE64;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE74;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE84;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CE94;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CEA4;      ;
                       db $2E,$00,$00,$FF,$2F,$00,$00,$FF,$30,$00,$00,$FF,$31,$00,$00,$FF;82CEB4;      ;
                       db $32,$00,$00,$FF,$33,$00,$00,$FF,$34,$00,$00,$FF,$35,$00,$00,$FF;82CEC4;      ;
                       db $36,$00,$00,$FF,$37,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CED4;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CEE4;      ;
                       db $A1,$03,$01,$FF,$29,$00,$08,$F2,$76,$03,$08,$FF,$70,$03,$08,$FF;82CEF4;      ;
                       db $78,$03,$08,$F2,$6F,$03,$01,$C2,$88,$03,$01,$FF,$2A,$00,$08,$F2;82CF04;      ;
                       db $7E,$03,$08,$F2,$28,$00,$08,$F2,$77,$03,$08,$FF,$7F,$03,$08,$F2;82CF14;      ;
                       db $2B,$00,$08,$F2,$80,$03,$01,$FF,$82,$03,$01,$F2,$8B,$03,$01,$F2;82CF24;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CF34;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CF44;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CF54;      ;
                       db $00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CF64;      ;
                       db $33,$01,$01,$F2,$34,$01,$01,$FF,$35,$01,$01,$FF,$36,$01,$08,$F2;82CF74;      ;
                       db $37,$01,$01,$F4,$38,$01,$01,$F4,$39,$01,$01,$F4,$3A,$01,$01,$F2;82CF84;      ;
                       db $3B,$01,$01,$F2,$3C,$01,$01,$F2,$3D,$01,$01,$F2,$3E,$01,$01,$F2;82CF94;      ;
                       db $3F,$01,$01,$F2,$40,$01,$01,$FF,$00,$00,$00,$FF,$00,$00,$00,$FF;82CFA4;      ;
                                                            ;      ;      ;
         DATA8_82CFB4: db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$09,$09,$0A,$00;82CFB4;      ;
                       db $0D,$0D,$0D,$0E,$0F,$0F,$0F,$0F,$0B,$0B,$0B,$00,$00,$00,$00,$00;82CFC4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82CFD4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82CFE4;      ;
                       db $2A,$2A,$2A,$2A,$2B,$2B,$2B,$2B,$2C,$2C,$2C,$2C,$2D,$2D,$2D,$2D;82CFF4;      ;
                       db $2E,$2E,$2E,$2E,$2F,$2F,$2F,$2F,$30,$30,$30,$30,$31,$31,$31,$31;82D004;      ;
                       db $32,$32,$32,$32,$33,$33,$33,$33,$34,$34,$34,$34,$35,$35,$35,$35;82D014;      ;
                       db $36,$36,$36,$36,$37,$37,$37,$37,$38,$38,$38,$38,$39,$39,$39,$39;82D024;      ;
                       db $3A,$3A,$3A,$3A,$3B,$3B,$3B,$3B,$3C,$3C,$3C,$3C,$3D,$3D,$3D,$3D;82D034;      ;
                       db $3E,$3E,$3E,$3E,$3F,$3F,$3F,$3F,$40,$40,$40,$40,$41,$41,$41,$41;82D044;      ;
                       db $42,$42,$42,$42,$43,$43,$43,$43,$00,$00,$00,$00,$00,$00,$00,$00;82D054;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D064;      ;
                       db $03,$00,$00,$00,$19,$19,$00,$00,$00,$04,$00,$00,$00,$00,$01,$00;82D074;      ;
                       db $00,$00,$02,$00,$0C,$0C,$0C,$00,$18,$18,$18,$18,$00,$00,$05,$00;82D084;      ;
                       db $11,$11,$11,$11,$11,$11,$11,$11,$00,$00,$00,$00,$00,$00,$00,$00;82D094;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D0A4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D0B4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D0C4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D0D4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D0E4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$10,$10,$10,$10;82D0F4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D104;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D114;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D124;      ;
                       db $12,$12,$12,$12,$12,$12,$12,$12,$1C,$1C,$1C,$1C,$1B,$1B,$1B,$1B;82D134;      ;
                       db $1D,$1D,$1D,$1D,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D144;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82D154;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$13,$13,$13,$13,$13,$13,$13,$13;82D164;      ;
                       db $44,$44,$44,$44,$45,$45,$45,$45,$46,$46,$46,$46,$47,$47,$47,$47;82D174;      ;
                       db $48,$48,$48,$48,$49,$49,$49,$49,$4A,$4A,$4A,$4A,$4B,$4B,$4B,$4B;82D184;      ;
                       db $4C,$4C,$4C,$4C,$4D,$4D,$4D,$4D,$4E,$4E,$4E,$4E,$4F,$4F,$4F,$4F;82D194;      ;
                       db $50,$50,$50,$50,$51,$51,$51,$51,$52,$52,$52,$52,$53,$53,$53,$53;82D1A4;      ;
                       db $54,$54,$54,$54,$55,$55,$55,$55,$56,$56,$56,$56;82D1B4;      ;
                                                            ;      ;      ;
          CODE_82D1C0: %Set8bit(!M)                             ;82D1C0;      ;
                       %Set16bit(!X)                             ;82D1C2;      ;
                       LDA.B #$0F                           ;82D1C4;      ;
                       STA.B $92                            ;82D1C6;000092;
                       LDA.B #$03                           ;82D1C8;      ;
                       STA.B $93                            ;82D1CA;000093;
                       LDA.B #$01                           ;82D1CC;      ;
                       STA.B $94                            ;82D1CE;000094;
                       JSL.L ScreenFadeout                  ;82D1D0;80880A;
                       %Set8bit(!M)                             ;82D1D4;      ;
                       LDA.B #$06                           ;82D1D6;      ;
                       STA.L !hour                        ;82D1D8;7F1F1C;
                       LDA.B #$00                           ;82D1DC;      ;
                       STA.L !minutes                        ;82D1DE;7F1F1D;
                       LDA.B #$00                           ;82D1E2;      ;
                       STA.L !seconds                        ;82D1E4;7F1F1E;
                       LDA.B #$01                           ;82D1E8;      ;
                       STA.B $95                            ;82D1EA;000095;
                       STZ.B $94                            ;82D1EC;000094;
                       %Set16bit(!M)                             ;82D1EE;      ;
                       LDA.W #$0000                         ;82D1F0;      ;
                       STA.L $7F1F5A                        ;82D1F3;7F1F5A;
                       LDA.W #$0000                         ;82D1F7;      ;
                       STA.L $7F1F5C                        ;82D1FA;7F1F5C;
                       LDA.W #$0000                         ;82D1FE;      ;
                       STA.L $7F1F5E                        ;82D201;7F1F5E;
                       LDA.W #$0000                         ;82D205;      ;
                       STA.L $7F1F60                        ;82D208;7F1F60;
                       LDA.W #$0000                         ;82D20C;      ;
                       STA.L $7F1F74                        ;82D20F;7F1F74;
                       STA.L $7F1F76                        ;82D213;7F1F76;
                       STA.L $7F1F78                        ;82D217;7F1F78;
                       LDA.W #$0108                         ;82D21B;      ;
                       STA.L $7F1F60                        ;82D21E;7F1F60;
                       %Set16bit(!M)                             ;82D222;      ;
                       LDA.W #$0000                         ;82D224;      ;
                       STA.L $7F1F64                        ;82D227;7F1F64;
                       LDA.W #$0000                         ;82D22B;      ;
                       STA.L $7F1F66                        ;82D22E;7F1F66;
                       LDA.W #$0000                         ;82D232;      ;
                       STA.L $7F1F68                        ;82D235;7F1F68;
                       LDA.W #$0000                         ;82D239;      ;
                       STA.L $7F1F6A                        ;82D23C;7F1F6A;
                       LDA.W #$0000                         ;82D240;      ;
                       STA.L $7F1F6C                        ;82D243;7F1F6C;
                       LDA.W #$0000                         ;82D247;      ;
                       STA.L $7F1F6E                        ;82D24A;7F1F6E;
                       LDA.W #$0000                         ;82D24E;      ;
                       STA.L $7F1F70                        ;82D251;7F1F70;
                       LDA.W #$0000                         ;82D255;      ;
                       STA.L $7F1F72                        ;82D258;7F1F72;
                       %Set8bit(!M)                             ;82D25C;      ;
                       LDA.B #$00                           ;82D25E;      ;
                       STA.L $7F1F49                        ;82D260;7F1F49;
                       %Set8bit(!M)                             ;82D264;      ;
                       LDA.B #$8F                           ;82D266;      ;
                       STA.L !shed_items_row_1                        ;82D268;7F1F00;
                       LDA.B #$88                           ;82D26C;      ;
                       STA.L !shed_items_row_2                        ;82D26E;7F1F01;
                       LDA.B #$00                           ;82D272;      ;
                       STA.L !shed_items_row_3                        ;82D274;7F1F02;
                       LDA.B #$00                           ;82D278;      ;
                       STA.L !shed_items_row_4                        ;82D27A;7F1F03;
                       STZ.W !tool_selected                          ;82D27E;000921;
                       STZ.W !tool_backpack                          ;82D281;000923;
                       LDA.B #$01                           ;82D284;      ;
                       STA.W !seeds_grass_N                          ;82D286;000927;
                       STA.W !seeds_turnip_N                          ;82D289;00092B;
                       STA.W !seeds_corn_N                          ;82D28C;000928;
                       STA.W !seeds_tomato_N                          ;82D28F;000929;
                       %Set16bit(!M)                             ;82D292;      ;
                       STZ.W $0915                          ;82D294;000915;
                       STZ.B !game_state                            ;82D297;0000D2;
                       STZ.B !player_action                            ;82D299;0000D4;
                       %Set8bit(!M)                             ;82D29B;      ;
                       %Set16bit(!MX)                             ;82D29D;      ;
                       LDA.B !game_state                            ;82D29F;0000D2;
                       ORA.W #$0001                         ;82D2A1;      ;
                       STA.B !game_state                            ;82D2A4;0000D2;
                       %Set16bit(!MX)                             ;82D2A6;      ;
                       LDA.W #$0000                         ;82D2A8;      ;
                       STA.B !player_action                            ;82D2AB;0000D4;
                       %Set16bit(!MX)                             ;82D2AD;      ;
                       LDA.W #$0000                         ;82D2AF;      ;
                       STA.B !player_direction                            ;82D2B2;0000DA;
                       %Set16bit(!MX)                             ;82D2B4;      ;
                       LDA.W #$0000                         ;82D2B6;      ;
                       STA.W $0911                          ;82D2B9;000911;
                       %Set16bit(!MX)                             ;82D2BC;      ;
                       LDA.W #$0000                         ;82D2BE;      ;
                       STA.W $0901                          ;82D2C1;000901;
                       %Set8bit(!M)                             ;82D2C4;      ;
                       STZ.W !time_running                          ;82D2C6;000973;
                       LDA.B #$00                           ;82D2C9;      ;
                       STA.L !season                        ;82D2CB;7F1F19;
                       %Set8bit(!M)                             ;82D2CF;      ;
                       STZ.W !item_on_hand                          ;82D2D1;00091D;
                       %Set16bit(!MX)                             ;82D2D4;      ;
                       LDA.W #$0002                         ;82D2D6;      ;
                       EOR.W #$FFFF                         ;82D2D9;      ;
                       AND.B !game_state                            ;82D2DC;0000D2;
                       STA.B !game_state                            ;82D2DE;0000D2;
                       %Set16bit(!MX)                             ;82D2E0;      ;
                       STZ.W !fed_cows_flags                          ;82D2E2;000932;
                       STZ.W !fed_chicks_flags                          ;82D2E5;000934;
                       LDA.L $7F1F5C                        ;82D2E8;7F1F5C;
                       AND.W #$FFFB                         ;82D2EC;      ;
                       STA.L $7F1F5C                        ;82D2EF;7F1F5C;
                       JSL.L ZeroesVRAM                      ;82D2F3;808846;
                       JSL.L ZeroesCGRAM                     ;82D2F7;808980;
                       JSL.L ClearMemoryPointers2           ;82D2FB;808FAB;
                       JSL.L ClearWRAMGraphicsSpace         ;82D2FF;858ED7;
                       JSL.L InitializeOBJs         ;82D303;85820F;
                       JSL.L PresetsMemory3                 ;82D307;81A4C7;
                       JSL.L PresetsMemory4                 ;82D30B;848000;
                       JSL.L LoadFarmMap                ;82D30F;82A65A;
                       %Set16bit(!M)                             ;82D313;      ;
                       LDA.W #$0100                         ;82D315;      ;
                       STA.W !BG3_Map_Offset_Y                          ;82D318;000146;
                       %Set16bit(!MX)                             ;82D31B;      ;
                       LDA.W #$0000                         ;82D31D;      ;
                       LDX.W #$0047                         ;82D320;      ;
                       LDY.W #$0000                         ;82D323;      ;
                       JSL.L VIP                            ;82D326;848097;
                       JSL.L CODE_84816F                    ;82D32A;84816F;
                       %Set8bit(!M)                             ;82D32E;      ;
                       LDA.W !transition_dest                          ;82D330;00098B;
                       STA.B !tilemap_to_load                            ;82D333;000022;
                       JSL.L UNK_Audio5;82D335;8095DE;
                       %Set8bit(!M)                             ;82D339;      ;
                       LDA.W !transition_dest                          ;82D33B;00098B;
                       JSL.L A5555                           ;82D33E;80972C;
                       %Set16bit(!MX)                             ;82D342;      ;
                       LDY.W #$0000                         ;82D344;      ;
                                                            ;      ;      ;
          CODE_82D347: %Set16bit(!M)                             ;82D347;      ;
                       STZ.B $90                            ;82D349;000090;
                       %Set8bit(!M)                             ;82D34B;      ;
                       LDA.B !NMI_Status                            ;82D34D;000000;
                       BEQ CODE_82D347                      ;82D34F;82D347;
                       %Set16bit(!M)                             ;82D351;      ;
                       LDA.W #$1800                         ;82D353;      ;
                       STA.B $C7                            ;82D356;0000C7;
                       JSL.L UNK_PrepareScreenTransition         ;82D358;809671;
                       JSL.L A4444                           ;82D35C;809A64;
                       JSL.L UpdateTime                     ;82D360;828000;
                       JSL.L ADDDDFFFF                      ;82D364;83951C;
                       JSL.L Unk_MemoryWork7E0D00           ;82D368;80900C;
                       JSL.L UNK_BigLoop                    ;82D36C;808E69;
                       JSL.L InputTypeSelector                          ;82D370;84C034;
                       JSL.L BAAAA                          ;82D374;81A383;
                       JSL.L BEEEE                          ;82D378;81BFB7;
                       JSL.L AutoMapScrolling               ;82D37C;8095B3;
                       JSL.L CODE_84816F                    ;82D380;84816F;
                       JSL.L CODE_81A600                    ;82D384;81A600;
                       JSL.L CODE_8582C7                    ;82D388;8582C7;
                       JSL.L CODE_858CB2                    ;82D38C;858CB2;
                       JSL.L UNK_BigLoadLoopOAM             ;82D390;8583E0;
                       %Set16bit(!M)                             ;82D394;      ;
                       LDA.L $7F1F5C                        ;82D396;7F1F5C;
                       AND.W #$0004                         ;82D39A;      ;
                       BNE CODE_82D3A6                      ;82D39D;82D3A6;
                       %Set8bit(!M)                             ;82D39F;      ;
                       STZ.B !NMI_Status                            ;82D3A1;000000;
                       JMP.W CODE_82D347                    ;82D3A3;82D347;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D3A6: %Set16bit(!MX)                             ;82D3A6;      ;
                       LDX.W #$0000                         ;82D3A8;      ;
                                                            ;      ;      ;
          CODE_82D3AB: %Set8bit(!M)                             ;82D3AB;      ;
                       LDA.B #$00                           ;82D3AD;      ;
                       STA.L !chicken_array,X                      ;82D3AF;7EC286;
                       INX                                  ;82D3B3;      ;
                       CPX.W #$0008                         ;82D3B4;      ;
                       BNE CODE_82D3AB                      ;82D3B7;82D3AB;
                       %Set8bit(!M)                             ;82D3B9;      ;
                       LDA.B #$09                           ;82D3BB;      ;
                       STA.B $95                            ;82D3BD;000095;
                       %Set16bit(!M)                             ;82D3BF;      ;
                       STZ.B $90                            ;82D3C1;000090;
                       JML.L CODE_82D871                    ;82D3C3;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D3C7: %Set8bit(!M)                             ;82D3C7;      ;
                       %Set16bit(!X)                             ;82D3C9;      ;
                       LDA.B #$0F                           ;82D3CB;      ;
                       STA.B $92                            ;82D3CD;000092;
                       LDA.B #$03                           ;82D3CF;      ;
                       STA.B $93                            ;82D3D1;000093;
                       LDA.B #$01                           ;82D3D3;      ;
                       STA.B $94                            ;82D3D5;000094;
                       JSL.L ScreenFadeout                  ;82D3D7;80880A;
                       %Set8bit(!M)                             ;82D3DB;      ;
                       LDA.B #$06                           ;82D3DD;      ;
                       STA.L !hour                        ;82D3DF;7F1F1C;
                       LDA.B #$00                           ;82D3E3;      ;
                       STA.L !minutes                        ;82D3E5;7F1F1D;
                       LDA.B #$00                           ;82D3E9;      ;
                       STA.L !seconds                        ;82D3EB;7F1F1E;
                       LDA.B #$01                           ;82D3EF;      ;
                       STA.B $95                            ;82D3F1;000095;
                       STZ.B $94                            ;82D3F3;000094;
                       %Set16bit(!M)                             ;82D3F5;      ;
                       LDA.W #$0000                         ;82D3F7;      ;
                       STA.L $7F1F5A                        ;82D3FA;7F1F5A;
                       LDA.W #$0000                         ;82D3FE;      ;
                       STA.L $7F1F5C                        ;82D401;7F1F5C;
                       LDA.W #$0000                         ;82D405;      ;
                       STA.L $7F1F5E                        ;82D408;7F1F5E;
                       LDA.W #$0000                         ;82D40C;      ;
                       STA.L $7F1F60                        ;82D40F;7F1F60;
                       LDA.W #$0000                         ;82D413;      ;
                       STA.L $7F1F74                        ;82D416;7F1F74;
                       STA.L $7F1F76                        ;82D41A;7F1F76;
                       STA.L $7F1F78                        ;82D41E;7F1F78;
                       LDA.W #$0008                         ;82D422;      ;
                       STA.L $7F1F60                        ;82D425;7F1F60;
                       %Set16bit(!M)                             ;82D429;      ;
                       LDA.W #$0000                         ;82D42B;      ;
                       STA.L $7F1F64                        ;82D42E;7F1F64;
                       LDA.W #$0000                         ;82D432;      ;
                       STA.L $7F1F66                        ;82D435;7F1F66;
                       LDA.W #$0000                         ;82D439;      ;
                       STA.L $7F1F68                        ;82D43C;7F1F68;
                       LDA.W #$0000                         ;82D440;      ;
                       STA.L $7F1F6A                        ;82D443;7F1F6A;
                       LDA.W #$0000                         ;82D447;      ;
                       STA.L $7F1F6C                        ;82D44A;7F1F6C;
                       LDA.W #$0000                         ;82D44E;      ;
                       STA.L $7F1F6E                        ;82D451;7F1F6E;
                       LDA.W #$0000                         ;82D455;      ;
                       STA.L $7F1F70                        ;82D458;7F1F70;
                       LDA.W #$0000                         ;82D45C;      ;
                       STA.L $7F1F72                        ;82D45F;7F1F72;
                       %Set8bit(!M)                             ;82D463;      ;
                       LDA.B #$8F                           ;82D465;      ;
                       STA.L !shed_items_row_1                        ;82D467;7F1F00;
                       LDA.B #$EC                           ;82D46B;      ;
                       STA.L !shed_items_row_2                        ;82D46D;7F1F01;
                       LDA.B #$00                           ;82D471;      ;
                       STA.L !shed_items_row_3                        ;82D473;7F1F02;
                       LDA.B #$00                           ;82D477;      ;
                       STA.L !shed_items_row_4                        ;82D479;7F1F03;
                       STZ.W !tool_selected                          ;82D47D;000921;
                       STZ.W !tool_backpack                          ;82D480;000923;
                       LDA.B #$01                           ;82D483;      ;
                       STA.W !seeds_grass_N                          ;82D485;000927;
                       STA.W !seeds_turnip_N                          ;82D488;00092B;
                       %Set16bit(!M)                             ;82D48B;      ;
                       STZ.W $08FD                          ;82D48D;0008FD;
                       STZ.W $08FF                          ;82D490;0008FF;
                       %Set16bit(!M)                             ;82D493;      ;
                       STZ.W $0915                          ;82D495;000915;
                       STZ.B !game_state                            ;82D498;0000D2;
                       STZ.B !player_action                            ;82D49A;0000D4;
                       %Set8bit(!M)                             ;82D49C;      ;
                       %Set16bit(!MX)                             ;82D49E;      ;
                       LDA.B !game_state                            ;82D4A0;0000D2;
                       ORA.W #$0001                         ;82D4A2;      ;
                       STA.B !game_state                            ;82D4A5;0000D2;
                       %Set16bit(!MX)                             ;82D4A7;      ;
                       LDA.W #$0000                         ;82D4A9;      ;
                       STA.B !player_action                            ;82D4AC;0000D4;
                       %Set16bit(!MX)                             ;82D4AE;      ;
                       LDA.W #$0000                         ;82D4B0;      ;
                       STA.B !player_direction                            ;82D4B3;0000DA;
                       %Set16bit(!MX)                             ;82D4B5;      ;
                       LDA.W #$0000                         ;82D4B7;      ;
                       STA.W $0911                          ;82D4BA;000911;
                       %Set16bit(!MX)                             ;82D4BD;      ;
                       LDA.W #$0000                         ;82D4BF;      ;
                       STA.W $0901                          ;82D4C2;000901;
                       %Set8bit(!M)                             ;82D4C5;      ;
                       STZ.W !time_running                          ;82D4C7;000973;
                       LDA.B #$00                           ;82D4CA;      ;
                       STA.L !season                        ;82D4CC;7F1F19;
                       %Set8bit(!M)                             ;82D4D0;      ;
                       STZ.W !item_on_hand                          ;82D4D2;00091D;
                       %Set16bit(!MX)                             ;82D4D5;      ;
                       LDA.W #$0002                         ;82D4D7;      ;
                       EOR.W #$FFFF                         ;82D4DA;      ;
                       AND.B !game_state                            ;82D4DD;0000D2;
                       STA.B !game_state                            ;82D4DF;0000D2;
                       %Set16bit(!MX)                             ;82D4E1;      ;
                       STZ.W !fed_cows_flags                          ;82D4E3;000932;
                       STZ.W !fed_chicks_flags                          ;82D4E6;000934;
                       LDA.L $7F1F5C                        ;82D4E9;7F1F5C;
                       AND.W #$FFFB                         ;82D4ED;      ;
                       STA.L $7F1F5C                        ;82D4F0;7F1F5C;
                       JSL.L ZeroesVRAM                      ;82D4F4;808846;
                       JSL.L ZeroesCGRAM                     ;82D4F8;808980;
                       JSL.L ClearMemoryPointers2           ;82D4FC;808FAB;
                       JSL.L ClearWRAMGraphicsSpace         ;82D500;858ED7;
                       JSL.L InitializeOBJs         ;82D504;85820F;
                       JSL.L PresetsMemory3                 ;82D508;81A4C7;
                       JSL.L PresetsMemory4                 ;82D50C;848000;
                       JSL.L LoadFarmMap                ;82D510;82A65A;
                       %Set16bit(!M)                             ;82D514;      ;
                       LDA.W #$0100                         ;82D516;      ;
                       STA.W !BG3_Map_Offset_Y                          ;82D519;000146;
                       %Set8bit(!M)                             ;82D51C;      ;
                       LDA.L $7F1F48                        ;82D51E;7F1F48;
                       BNE CODE_82D527                      ;82D522;82D527;
                       JMP.W CODE_82D574                    ;82D524;82D574;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D527: CMP.B #$01                           ;82D527;      ;
                       BNE CODE_82D52E                      ;82D529;82D52E;
                       JMP.W CODE_82D58E                    ;82D52B;82D58E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D52E: CMP.B #$02                           ;82D52E;      ;
                       BNE CODE_82D535                      ;82D530;82D535;
                       JMP.W CODE_82D5A8                    ;82D532;82D5A8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D535: CMP.B #$03                           ;82D535;      ;
                       BNE CODE_82D53C                      ;82D537;82D53C;
                       JMP.W CODE_82D5C2                    ;82D539;82D5C2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D53C: CMP.B #$04                           ;82D53C;      ;
                       BNE CODE_82D543                      ;82D53E;82D543;
                       JMP.W CODE_82D5DC                    ;82D540;82D5DC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D543: CMP.B #$05                           ;82D543;      ;
                       BNE CODE_82D54A                      ;82D545;82D54A;
                       JMP.W CODE_82D5F6                    ;82D547;82D5F6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D54A: CMP.B #$06                           ;82D54A;      ;
                       BNE CODE_82D551                      ;82D54C;82D551;
                       JMP.W CODE_82D610                    ;82D54E;82D610;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D551: CMP.B #$07                           ;82D551;      ;
                       BNE CODE_82D558                      ;82D553;82D558;
                       JMP.W CODE_82D62A                    ;82D555;82D62A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D558: CMP.B #$08                           ;82D558;      ;
                       BNE CODE_82D55F                      ;82D55A;82D55F;
                       JMP.W CODE_82D644                    ;82D55C;82D644;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D55F: CMP.B #$09                           ;82D55F;      ;
                       BNE CODE_82D566                      ;82D561;82D566;
                       JMP.W CODE_82D65E                    ;82D563;82D65E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D566: CMP.B #$0A                           ;82D566;      ;
                       BNE CODE_82D56D                      ;82D568;82D56D;
                       JMP.W CODE_82D678                    ;82D56A;82D678;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D56D: CMP.B #$0B                           ;82D56D;      ;
                       BNE CODE_82D574                      ;82D56F;82D574;
                       JMP.W CODE_82D692                    ;82D571;82D692;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D574: %Set16bit(!MX)                             ;82D574;      ;
                       LDA.W #$0000                         ;82D576;      ;
                       LDX.W #$0047                         ;82D579;      ;
                       LDY.W #$0002                         ;82D57C;      ;
                       JSL.L VIP                            ;82D57F;848097;
                       %Set8bit(!M)                             ;82D583;      ;
                       LDA.B #$01                           ;82D585;      ;
                       STA.L $7F1F48                        ;82D587;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D58B;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D58E: %Set16bit(!MX)                             ;82D58E;      ;
                       LDA.W #$0000                         ;82D590;      ;
                       LDX.W #$0047                         ;82D593;      ;
                       LDY.W #$0004                         ;82D596;      ;
                       JSL.L VIP                            ;82D599;848097;
                       %Set8bit(!M)                             ;82D59D;      ;
                       LDA.B #$02                           ;82D59F;      ;
                       STA.L $7F1F48                        ;82D5A1;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D5A5;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D5A8: %Set16bit(!MX)                             ;82D5A8;      ;
                       LDA.W #$0000                         ;82D5AA;      ;
                       LDX.W #$0047                         ;82D5AD;      ;
                       LDY.W #$0006                         ;82D5B0;      ;
                       JSL.L VIP                            ;82D5B3;848097;
                       %Set8bit(!M)                             ;82D5B7;      ;
                       LDA.B #$03                           ;82D5B9;      ;
                       STA.L $7F1F48                        ;82D5BB;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D5BF;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D5C2: %Set16bit(!MX)                             ;82D5C2;      ;
                       LDA.W #$0000                         ;82D5C4;      ;
                       LDX.W #$0047                         ;82D5C7;      ;
                       LDY.W #$0007                         ;82D5CA;      ;
                       JSL.L VIP                            ;82D5CD;848097;
                       %Set8bit(!M)                             ;82D5D1;      ;
                       LDA.B #$04                           ;82D5D3;      ;
                       STA.L $7F1F48                        ;82D5D5;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D5D9;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D5DC: %Set16bit(!MX)                             ;82D5DC;      ;
                       LDA.W #$0000                         ;82D5DE;      ;
                       LDX.W #$0047                         ;82D5E1;      ;
                       LDY.W #$0009                         ;82D5E4;      ;
                       JSL.L VIP                            ;82D5E7;848097;
                       %Set8bit(!M)                             ;82D5EB;      ;
                       LDA.B #$05                           ;82D5ED;      ;
                       STA.L $7F1F48                        ;82D5EF;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D5F3;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D5F6: %Set16bit(!MX)                             ;82D5F6;      ;
                       LDA.W #$0000                         ;82D5F8;      ;
                       LDX.W #$0047                         ;82D5FB;      ;
                       LDY.W #$000B                         ;82D5FE;      ;
                       JSL.L VIP                            ;82D601;848097;
                       %Set8bit(!M)                             ;82D605;      ;
                       LDA.B #$06                           ;82D607;      ;
                       STA.L $7F1F48                        ;82D609;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D60D;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D610: %Set16bit(!MX)                             ;82D610;      ;
                       LDA.W #$0000                         ;82D612;      ;
                       LDX.W #$0047                         ;82D615;      ;
                       LDY.W #$000D                         ;82D618;      ;
                       JSL.L VIP                            ;82D61B;848097;
                       %Set8bit(!M)                             ;82D61F;      ;
                       LDA.B #$07                           ;82D621;      ;
                       STA.L $7F1F48                        ;82D623;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D627;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D62A: %Set16bit(!MX)                             ;82D62A;      ;
                       LDA.W #$0000                         ;82D62C;      ;
                       LDX.W #$0047                         ;82D62F;      ;
                       LDY.W #$0011                         ;82D632;      ;
                       JSL.L VIP                            ;82D635;848097;
                       %Set8bit(!M)                             ;82D639;      ;
                       LDA.B #$08                           ;82D63B;      ;
                       STA.L $7F1F48                        ;82D63D;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D641;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D644: %Set16bit(!MX)                             ;82D644;      ;
                       LDA.W #$0000                         ;82D646;      ;
                       LDX.W #$0047                         ;82D649;      ;
                       LDY.W #$0015                         ;82D64C;      ;
                       JSL.L VIP                            ;82D64F;848097;
                       %Set8bit(!M)                             ;82D653;      ;
                       LDA.B #$09                           ;82D655;      ;
                       STA.L $7F1F48                        ;82D657;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D65B;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D65E: %Set16bit(!MX)                             ;82D65E;      ;
                       LDA.W #$0000                         ;82D660;      ;
                       LDX.W #$0047                         ;82D663;      ;
                       LDY.W #$0017                         ;82D666;      ;
                       JSL.L VIP                            ;82D669;848097;
                       %Set8bit(!M)                             ;82D66D;      ;
                       LDA.B #$0A                           ;82D66F;      ;
                       STA.L $7F1F48                        ;82D671;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D675;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D678: %Set16bit(!MX)                             ;82D678;      ;
                       LDA.W #$0000                         ;82D67A;      ;
                       LDX.W #$0047                         ;82D67D;      ;
                       LDY.W #$0019                         ;82D680;      ;
                       JSL.L VIP                            ;82D683;848097;
                       %Set8bit(!M)                             ;82D687;      ;
                       LDA.B #$0B                           ;82D689;      ;
                       STA.L $7F1F48                        ;82D68B;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D68F;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D692: %Set16bit(!MX)                             ;82D692;      ;
                       LDA.W #$0000                         ;82D694;      ;
                       LDX.W #$0047                         ;82D697;      ;
                       LDY.W #$001B                         ;82D69A;      ;
                       JSL.L VIP                            ;82D69D;848097;
                       %Set8bit(!M)                             ;82D6A1;      ;
                       LDA.B #$00                           ;82D6A3;      ;
                       STA.L $7F1F48                        ;82D6A5;7F1F48;
                       JMP.W CODE_82D6AC                    ;82D6A9;82D6AC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D6AC: JSL.L CODE_84816F                    ;82D6AC;84816F;
                       %Set8bit(!M)                             ;82D6B0;      ;
                       LDA.W !transition_dest                          ;82D6B2;00098B;
                       STA.B !tilemap_to_load                            ;82D6B5;000022;
                       JSL.L UNK_Audio5;82D6B7;8095DE;
                       %Set8bit(!M)                             ;82D6BB;      ;
                       LDA.W !transition_dest                          ;82D6BD;00098B;
                       JSL.L A5555                           ;82D6C0;80972C;
                       %Set16bit(!MX)                             ;82D6C4;      ;
                       LDY.W #$0000                         ;82D6C6;      ;
                                                            ;      ;      ;
          CODE_82D6C9: %Set16bit(!M)                             ;82D6C9;      ;
                       STZ.B $90                            ;82D6CB;000090;
                       %Set8bit(!M)                             ;82D6CD;      ;
                       LDA.B !NMI_Status                            ;82D6CF;000000;
                       BEQ CODE_82D6C9                      ;82D6D1;82D6C9;
                       %Set16bit(!M)                             ;82D6D3;      ;
                       LDA.W #$1800                         ;82D6D5;      ;
                       STA.B $C7                            ;82D6D8;0000C7;
                       JSL.L UNK_PrepareScreenTransition         ;82D6DA;809671;
                       JSL.L A4444                           ;82D6DE;809A64;
                       JSL.L UpdateTime                     ;82D6E2;828000;
                       JSL.L ADDDDFFFF                      ;82D6E6;83951C;
                       JSL.L Unk_MemoryWork7E0D00           ;82D6EA;80900C;
                       JSL.L UNK_BigLoop                    ;82D6EE;808E69;
                       JSL.L InputTypeSelector                          ;82D6F2;84C034;
                       JSL.L BAAAA                          ;82D6F6;81A383;
                       JSL.L BEEEE                          ;82D6FA;81BFB7;
                       JSL.L AutoMapScrolling               ;82D6FE;8095B3;
                       JSL.L CODE_84816F                    ;82D702;84816F;
                       JSL.L CODE_81A600                    ;82D706;81A600;
                       JSL.L CODE_8582C7                    ;82D70A;8582C7;
                       JSL.L CODE_858CB2                    ;82D70E;858CB2;
                       JSL.L UNK_BigLoadLoopOAM             ;82D712;8583E0;
                       %Set16bit(!M)                             ;82D716;      ;
                       LDA.L $7F1F5C                        ;82D718;7F1F5C;
                       AND.W #$0004                         ;82D71C;      ;
                       BNE CODE_82D731                      ;82D71F;82D731;
                       LDA.L $7F1F60                        ;82D721;7F1F60;
                       AND.W #$0080                         ;82D725;      ;
                       BNE CODE_82D731                      ;82D728;82D731;
                       %Set8bit(!M)                             ;82D72A;      ;
                       STZ.B !NMI_Status                            ;82D72C;000000;
                       JMP.W CODE_82D6C9                    ;82D72E;82D6C9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D731: %Set16bit(!MX)                             ;82D731;      ;
                       LDX.W #$0000                         ;82D733;      ;
                                                            ;      ;      ;
          CODE_82D736: %Set8bit(!M)                             ;82D736;      ;
                       LDA.B #$00                           ;82D738;      ;
                       STA.L !chicken_array,X                      ;82D73A;7EC286;
                       INX                                  ;82D73E;      ;
                       CPX.W #$0008                         ;82D73F;      ;
                       BNE CODE_82D736                      ;82D742;82D736;
                       %Set8bit(!M)                             ;82D744;      ;
                       LDA.B !tilemap_to_load                            ;82D746;000022;
                       CMP.B #$04                           ;82D748;      ;
                       BCS CODE_82D750                      ;82D74A;82D750;
                       JSL.L CIIII                          ;82D74C;82A682;
                                                            ;      ;      ;
          CODE_82D750: %Set8bit(!M)                             ;82D750;      ;
                       LDA.B #$09                           ;82D752;      ;
                       STA.B $95                            ;82D754;000095;
                       %Set16bit(!M)                             ;82D756;      ;
                       STZ.B $90                            ;82D758;000090;
                       JML.L CODE_82D871                    ;82D75A;82D871;
                                                            ;      ;      ;

;;;;;;;TODO
IntroScreen: ;82D75E
       %Set16bit(!MX)
       %Set8bit(!M)
       LDA.B #$04
       STA.W !inputstate
       %Set8bit(!M)
       STZ.W $098D
       %Set16bit(!M)
       LDA.L $7F1F60
       AND.W #$0800                          ;FLAG60 Checks for save failed CRC flag
       BEQ .savefine

       %Set8bit(!M)
       LDA.B #$02
       STA.W $098D

    .savefine:
       %Set8bit(!M)
       LDA.B #$00
       STA.L $7F1F48
       STA.L $7F1F49
       JSL.L LoadFarmMap
       %Set8bit(!M)
       LDA.B #$03
       JSL.L ManageGraphicPresets
       JSL.L ForceBlank
       JSL.L ZeroesVRAM

       %Set8bit(!M)
       LDA.B !natsume_logo
       STA.B !tilemap_to_load
       JSL.L TilemapManager
       %Set16bit(!M)
       LDA.W #$006E
       JSL.L LoadCGRAM
       %Set8bit(!M)
       %Set16bit(!X)
       LDA.B #$00
       STA.B !ProgDMA_Channel_Index
       LDA.B !BBADX_DMA_CGRAMPORT
       STA.B !ProgDMA_Destination_Memory
       %Set16bit(!M)
       LDY.W #$0200
       LDX.W #$0000
       LDA.W #$DA00
       STA.B $72
       %Set8bit(!M)
       LDA.B #$A9
       STA.B $74
       JSL.L AddProgrammedDMA
       JSL.L StartLastPreparedDMA
       %Set16bit(!M)
       STZ.W !BG1_Map_Offset_X
       STZ.W !BG1_Map_Offset_Y
       STZ.W !BG2_Map_Offset_X
       STZ.W !BG2_Map_Offset_Y
       JSL.L ResetForceBlank
       JSL.L WaitForNMI
       %Set8bit(!M)
       LDA.B #$03
       STA.B !param1
       LDA.B #$03
       STA.B !param2
       LDA.B #$0F
       STA.B !param3
       JSL.L ScreenFadein
       %Set8bit(!M)
       STZ.B $97
       %Set16bit(!M)
       STZ.B $90
       LDA.W #$0001
       STA.B $AF

    WaitNMI:
       %Set8bit(!M)
       LDA.B $00
       BEQ WaitNMI

       JSL.L UNK_BigLoop
       JSL.L InputTypeSelector
       %Set8bit(!M)
       LDA.B $95
       BEQ CODE_82D883
       CMP.B #$01
       BNE CODE_82D829
       JML.L CODE_82D8B0

       CODE_82D829:
       CMP.B #$02                           ;82D829;      ;
       BNE CODE_82D831                      ;82D82B;82D831;
       JML.L CODE_82DA8C                    ;82D82D;82DA8C;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D831: CMP.B #$03                           ;82D831;      ;
       BNE CODE_82D839                      ;82D833;82D839;
       JML.L CODE_82DAC9                    ;82D835;82DAC9;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D839: CMP.B #$04                           ;82D839;      ;
       BNE CODE_82D841                      ;82D83B;82D841;
       JML.L CODE_82DC0D                    ;82D83D;82DC0D;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D841: CMP.B #$05                           ;82D841;      ;
       BNE CODE_82D849                      ;82D843;82D849;
       JML.L CODE_82DD8C                    ;82D845;82DD8C;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D849: CMP.B #$06                           ;82D849;      ;
       BNE CODE_82D851                      ;82D84B;82D851;
       JML.L CODE_82DB8E                    ;82D84D;82DB8E;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D851: CMP.B #$07                           ;82D851;      ;
       BNE CODE_82D859                      ;82D853;82D859;
       JML.L CODE_82DF92                    ;82D855;82DF92;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D859: CMP.B #$08                           ;82D859;      ;
       BNE CODE_82D861                      ;82D85B;82D861;
       JML.L CODE_82E1F1                    ;82D85D;82E1F1;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D861: CMP.B #$09                           ;82D861;      ;
       BNE CODE_82D869                      ;82D863;82D869;
       JML.L CODE_82DAF5                    ;82D865;82DAF5;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D869: CMP.B #$0A                           ;82D869;      ;
       BNE CODE_82D871                      ;82D86B;82D871;
       JML.L CODE_82D1C0                    ;82D86D;82D1C0;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D871: %Set8bit(!M)                             ;82D871;      ;
       STZ.B $00                            ;82D873;000000;
       %Set16bit(!M)                             ;82D875;      ;
       LDA.B $90                            ;82D877;000090;
       CMP.W #$0258                         ;82D879;      ;
       BNE CODE_82D881                      ;82D87C;82D881;
       JMP.W CODE_82D3C7                    ;82D87E;82D3C7;
                                          ;      ;      ;
                                          ;      ;      ;
       CODE_82D881: BRA WaitNMI                      ;82D881;82D80D;END_MainLoop?
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D883: LDY.W #$0000                         ;82D883;      ;
                                                            ;      ;      ;
          CODE_82D886: PHY                                  ;82D886;      ;
                       JSL.L WaitForNMI               ;82D887;808645;
                       %Set16bit(!MX)                             ;82D88B;      ;
                       PLY                                  ;82D88D;      ;
                       INY                                  ;82D88E;      ;
                       CPY.W #$0078                         ;82D88F;      ;
                       BNE CODE_82D886                      ;82D892;82D886;
                       %Set8bit(!M)                             ;82D894;      ;
                       LDA.B #$0F                           ;82D896;      ;
                       STA.B $92                            ;82D898;000092;
                       LDA.B #$03                           ;82D89A;      ;
                       STA.B $93                            ;82D89C;000093;
                       LDA.B #$01                           ;82D89E;      ;
                       STA.B $94                            ;82D8A0;000094;
                       JSL.L ScreenFadeout                  ;82D8A2;80880A;
                       %Set8bit(!M)                             ;82D8A6;      ;
                       LDA.B #$01                           ;82D8A8;      ;
                       STA.B $95                            ;82D8AA;000095;
                       STZ.B $94                            ;82D8AC;000094;
                       BRA CODE_82D871                      ;82D8AE;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D8B0: %Set16bit(!MX)                             ;82D8B0;      ;
                       JSL.L ZeroesVRAM                      ;82D8B2;808846;
                       JSL.L ZeroesCGRAM                     ;82D8B6;808980;
                       JSL.L ClearMemoryPointers2           ;82D8BA;808FAB;
                       JSL.L ClearWRAMGraphicsSpace         ;82D8BE;858ED7;
                       JSL.L InitializeOBJs         ;82D8C2;85820F;
                       JSL.L PresetsMemory3                 ;82D8C6;81A4C7;
                       JSL.L PresetsMemory4                 ;82D8CA;848000;
                       %Set16bit(!M)                             ;82D8CE;      ;
                       %Set16bit(!MX)                             ;82D8D0;      ;
                       LDA.B !game_state                            ;82D8D2;0000D2;
                       ORA.W #$0001                         ;82D8D4;      ;
                       STA.B !game_state                            ;82D8D7;0000D2;
                       %Set16bit(!MX)                             ;82D8D9;      ;
                       LDA.W #$0000                         ;82D8DB;      ;
                       STA.B !player_action                            ;82D8DE;0000D4;
                       %Set16bit(!MX)                             ;82D8E0;      ;
                       LDA.W #$0000                         ;82D8E2;      ;
                       STA.B !player_direction                            ;82D8E5;0000DA;
                       %Set16bit(!MX)                             ;82D8E7;      ;
                       LDA.W #$0000                         ;82D8E9;      ;
                       STA.W $0911                          ;82D8EC;000911;
                       %Set16bit(!MX)                             ;82D8EF;      ;
                       LDA.W #$0000                         ;82D8F1;      ;
                       STA.W $0901                          ;82D8F4;000901;
                       %Set16bit(!M)                             ;82D8F7;      ;
                       LDA.W #$0100                         ;82D8F9;      ;
                       STA.W !BG3_Map_Offset_Y                          ;82D8FC;000146;
                       %Set16bit(!MX)                             ;82D8FF;      ;
                       LDA.W #$0000                         ;82D901;      ;
                       LDX.W #$0009                         ;82D904;      ;
                       LDY.W #$0000                         ;82D907;      ;
                       JSL.L VIP                            ;82D90A;848097;
                       JSL.L CODE_84816F                    ;82D90E;84816F;
                       %Set8bit(!M)                             ;82D912;      ;
                       LDA.W !transition_dest                          ;82D914;00098B;
                       STA.B !tilemap_to_load                            ;82D917;000022;
                       JSL.L UNK_Audio5;82D919;8095DE;
                       JSL.L UNK_Audio21                    ;82D91D;83841F;
                       JSL.L UNK_Audio20                    ;82D921;8383A4;
                       JSL.L UNK_Audio22                    ;82D925;838380;
                       %Set8bit(!M)                             ;82D929;      ;
                       LDA.W $0110                          ;82D92B;000110;
                       STA.W $0117                          ;82D92E;000117;
                       %Set8bit(!M)                             ;82D931;      ;
                       LDA.W !transition_dest                          ;82D933;00098B;
                       JSL.L A5555                           ;82D936;80972C;
                       %Set16bit(!MX)                             ;82D93A;      ;
                       LDY.W #$0000                         ;82D93C;      ;
                                                            ;      ;      ;
          CODE_82D93F: %Set8bit(!M)                             ;82D93F;      ;
                       LDA.B !NMI_Status                            ;82D941;000000;
                       BEQ CODE_82D93F                      ;82D943;82D93F;
                       %Set16bit(!M)                             ;82D945;      ;
                       LDA.W #$1800                         ;82D947;      ;
                       STA.B $C7                            ;82D94A;0000C7;
                       JSL.L UNK_PrepareScreenTransition         ;82D94C;809671;
                       JSL.L A4444                           ;82D950;809A64;
                       JSL.L UpdateTime                     ;82D954;828000;
                       JSL.L ADDDDFFFF                      ;82D958;83951C;
                       JSL.L Unk_MemoryWork7E0D00           ;82D95C;80900C;
                       JSL.L UNK_BigLoop                    ;82D960;808E69;
                       JSL.L InputTypeSelector                          ;82D964;84C034;
                       JSL.L BAAAA                          ;82D968;81A383;
                       JSL.L BEEEE                          ;82D96C;81BFB7;
                       JSL.L AutoMapScrolling               ;82D970;8095B3;
                       JSL.L CODE_84816F                    ;82D974;84816F;
                       JSL.L CODE_81A600                    ;82D978;81A600;
                       JSL.L CODE_8582C7                    ;82D97C;8582C7;
                       JSL.L CODE_858CB2                    ;82D980;858CB2;
                       JSL.L UNK_BigLoadLoopOAM             ;82D984;8583E0;
                       %Set16bit(!M)                             ;82D988;      ;
                       LDA.L $7F1F5C                        ;82D98A;7F1F5C;
                       AND.W #$0004                         ;82D98E;      ;
                       BNE CODE_82D9B3                      ;82D991;82D9B3;
                       %Set8bit(!M)                             ;82D993;      ;
                       STZ.B !NMI_Status                            ;82D995;000000;
                       JMP.W CODE_82D93F                    ;82D997;82D93F;
                                                            ;      ;      ;
                       PLY                                  ;82D99A;      ;
                       INY                                  ;82D99B;      ;
                       CPY.W #$0168                         ;82D99C;      ;
                       BNE CODE_82D93F                      ;82D99F;82D93F;
                       %Set8bit(!M)                             ;82D9A1;      ;
                       LDA.B #$0F                           ;82D9A3;      ;
                       STA.B $92                            ;82D9A5;000092;
                       LDA.B #$03                           ;82D9A7;      ;
                       STA.B $93                            ;82D9A9;000093;
                       LDA.B #$01                           ;82D9AB;      ;
                       STA.B $94                            ;82D9AD;000094;
                       JSL.L ScreenFadeout                  ;82D9AF;80880A;
                                                            ;      ;      ;
          CODE_82D9B3: %Set8bit(!M)                             ;82D9B3;      ;
                       LDA.B $95                            ;82D9B5;000095;
                       CMP.B #$09                           ;82D9B7;      ;
                       BNE CODE_82D9BE                      ;82D9B9;82D9BE;
                       JMP.W CODE_82D871                    ;82D9BB;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82D9BE: %Set8bit(!M)                             ;82D9BE;      ;
                       LDA.B #$0F                           ;82D9C0;      ;
                       STA.B $92                            ;82D9C2;000092;
                       LDA.B #$03                           ;82D9C4;      ;
                       STA.B $93                            ;82D9C6;000093;
                       LDA.B #$01                           ;82D9C8;      ;
                       STA.B $94                            ;82D9CA;000094;
                       JSL.L ScreenFadeout                  ;82D9CC;80880A;
                       JSL.L ForceBlank                     ;82D9D0;808E0F;
                       %Set8bit(!M)                             ;82D9D4;      ;
                       LDA.B #$03                           ;82D9D6;      ;
                       JSL.L ManageGraphicPresets             ;82D9D8;808C59;
                       JSL.L ZeroesVRAM                      ;82D9DC;808846;
                       JSL.L ZeroesCGRAM                     ;82D9E0;808980;
                       JSL.L ClearMemoryPointers2           ;82D9E4;808FAB;
                       JSL.L ClearWRAMGraphicsSpace         ;82D9E8;858ED7;
                       JSL.L InitializeOBJs         ;82D9EC;85820F;
                       JSL.L PresetsMemory3                 ;82D9F0;81A4C7;
                       JSL.L PresetsMemory4                 ;82D9F4;848000;
                       %Set8bit(!M)                             ;82D9F8;      ;
                       LDA.B #$5B                           ;82D9FA;      ;
                       STA.B !tilemap_to_load                            ;82D9FC;000022;
                       JSL.L TilemapManager           ;82D9FE;80A7C6;
                       %Set16bit(!M)                             ;82DA02;      ;
                       LDA.W #$006D                         ;82DA04;      ;
                       JSL.L LoadCGRAM                      ;82DA07;8091CF;
                       %Set8bit(!M)                             ;82DA0B;      ;
                       %Set16bit(!X)                             ;82DA0D;      ;
                       LDA.B #$00                           ;82DA0F;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82DA11;000027;
                       LDA.B #$22                           ;82DA13;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82DA15;000029;
                       %Set16bit(!M)                             ;82DA17;      ;
                       LDY.W #$0200                         ;82DA19;      ;
                       LDX.W #$0000                         ;82DA1C;      ;
                       LDA.W #$D800                         ;82DA1F;      ;
                       STA.B $72                            ;82DA22;000072;
                       %Set8bit(!M)                             ;82DA24;      ;
                       LDA.B #$A9                           ;82DA26;      ;
                       STA.B $74                            ;82DA28;000074;
                       JSL.L AddProgrammedDMA                ;82DA2A;808A33;
                       JSL.L StartLastPreparedDMA               ;82DA2E;808AB2;
                       %Set16bit(!M)                             ;82DA32;      ;
                       LDA.W #$0100                         ;82DA34;      ;
                       STA.W !BG1_Map_Offset_X                          ;82DA37;00013C;
                       LDA.W #$0100                         ;82DA3A;      ;
                       STA.W !BG2_Map_Offset_X                          ;82DA3D;000140;
                       LDA.W #$0100                         ;82DA40;      ;
                       STA.W !BG1_Map_Offset_Y                          ;82DA43;00013E;
                       LDA.W #$0100                         ;82DA46;      ;
                       STA.W !BG2_Map_Offset_Y                          ;82DA49;000142;
                       JSL.L UNK_Audio5;82DA4C;8095DE;
                       JSL.L UNK_Audio21                    ;82DA50;83841F;
                       JSL.L UNK_Audio20                    ;82DA54;8383A4;
                       JSL.L UNK_Audio22                    ;82DA58;838380;
                       %Set8bit(!M)                             ;82DA5C;      ;
                       LDA.W $0110                          ;82DA5E;000110;
                       STA.W $0117                          ;82DA61;000117;
                       JSL.L ResetForceBlank                ;82DA64;808E1E;
                       JSL.L WaitForNMI               ;82DA68;808645;
                       %Set8bit(!M)                             ;82DA6C;      ;
                       LDA.B #$01                           ;82DA6E;      ;
                       STA.B $92                            ;82DA70;000092;
                       LDA.B #$06                           ;82DA72;      ;
                       STA.B $93                            ;82DA74;000093;
                       LDA.B #$0F                           ;82DA76;      ;
                       STA.B $94                            ;82DA78;000094;
                       JSL.L ScreenFadein                         ;82DA7A;8087CE;
                       %Set8bit(!M)                             ;82DA7E;      ;
                       LDA.B #$02                           ;82DA80;      ;
                       STA.B $95                            ;82DA82;000095;
                       STZ.B $94                            ;82DA84;000094;
                       STZ.B $96                            ;82DA86;000096;
                       JML.L CODE_82D871                    ;82DA88;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DA8C: %Set8bit(!M)                             ;82DA8C;      ;
                       LDA.B $94                            ;82DA8E;000094;
                       AND.B #$01                           ;82DA90;      ;
                       BNE CODE_82DAA6                      ;82DA92;82DAA6;
                       %Set16bit(!M)                             ;82DA94;      ;
                       LDA.W !BG2_Map_Offset_X                          ;82DA96;000140;
                       INC A                                ;82DA99;      ;
                       STA.W !BG2_Map_Offset_X                          ;82DA9A;000140;
                       LDA.W !BG1_Map_Offset_X                          ;82DA9D;00013C;
                       BEQ CODE_82DAAE                      ;82DAA0;82DAAE;
                       DEC A                                ;82DAA2;      ;
                       STA.W !BG1_Map_Offset_X                          ;82DAA3;00013C;
                                                            ;      ;      ;
          CODE_82DAA6: %Set8bit(!M)                             ;82DAA6;      ;
                       INC.B $94                            ;82DAA8;000094;
                       JML.L CODE_82D871                    ;82DAAA;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DAAE: %Set8bit(!M)                             ;82DAAE;      ;
                       LDA.B $96                            ;82DAB0;000096;
                       INC A                                ;82DAB2;      ;
                       STA.B $96                            ;82DAB3;000096;
                       CMP.B #$3C                           ;82DAB5;      ;
                       BEQ CODE_82DABD                      ;82DAB7;82DABD;
                       JML.L CODE_82DAA6                    ;82DAB9;82DAA6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DABD: %Set8bit(!M)                             ;82DABD;      ;
                       LDA.B #$03                           ;82DABF;      ;
                       STA.B $95                            ;82DAC1;000095;
                       STZ.B $94                            ;82DAC3;000094;
                       JML.L CODE_82D871                    ;82DAC5;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DAC9: %Set8bit(!M)                             ;82DAC9;      ;
                       LDA.B $94                            ;82DACB;000094;
                       AND.B #$01                           ;82DACD;      ;
                       BNE CODE_82DAED                      ;82DACF;82DAED;
                       %Set16bit(!M)                             ;82DAD1;      ;
                       LDA.W !BG2_Map_Offset_X                          ;82DAD3;000140;
                       INC A                                ;82DAD6;      ;
                       STA.W !BG2_Map_Offset_X                          ;82DAD7;000140;
                       LDA.W !BG1_Map_Offset_Y                          ;82DADA;00013E;
                       BNE CODE_82DAE2                      ;82DADD;82DAE2;
                       JMP.W CODE_82DB8E                    ;82DADF;82DB8E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DAE2: DEC A                                ;82DAE2;      ;
                       STA.W !BG1_Map_Offset_Y                          ;82DAE3;00013E;
                       LDA.W !BG2_Map_Offset_Y                          ;82DAE6;000142;
                       DEC A                                ;82DAE9;      ;
                       STA.W !BG2_Map_Offset_Y                          ;82DAEA;000142;
                                                            ;      ;      ;
          CODE_82DAED: %Set8bit(!M)                             ;82DAED;      ;
                       INC.B $94                            ;82DAEF;000094;
                       JML.L CODE_82D871                    ;82DAF1;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DAF5: %Set8bit(!M)                             ;82DAF5;      ;
                       LDA.B #$5C                           ;82DAF7;      ;
                       STA.B !tilemap_to_load                            ;82DAF9;000022;
                       JSL.L UNK_Audio5;82DAFB;8095DE;
                       JSL.L UNK_Audio25                    ;82DAFF;838401;
                       %Set8bit(!M)                             ;82DB03;      ;
                       LDA.B #$0F                           ;82DB05;      ;
                       STA.B $92                            ;82DB07;000092;
                       LDA.B #$01                           ;82DB09;      ;
                       STA.B $93                            ;82DB0B;000093;
                       LDA.B #$01                           ;82DB0D;      ;
                       STA.B $94                            ;82DB0F;000094;
                       JSL.L ScreenFadeout                  ;82DB11;80880A;
                       JSL.L ForceBlank                     ;82DB15;808E0F;
                       %Set8bit(!M)                             ;82DB19;      ;
                       LDA.B #$03                           ;82DB1B;      ;
                       JSL.L ManageGraphicPresets             ;82DB1D;808C59;
                       JSL.L ZeroesVRAM                      ;82DB21;808846;
                       JSL.L ZeroesCGRAM                     ;82DB25;808980;
                       JSL.L ClearMemoryPointers2           ;82DB29;808FAB;
                       JSL.L ClearWRAMGraphicsSpace         ;82DB2D;858ED7;
                       JSL.L InitializeOBJs         ;82DB31;85820F;
                       JSL.L PresetsMemory3                 ;82DB35;81A4C7;
                       JSL.L PresetsMemory4                 ;82DB39;848000;
                       %Set16bit(!M)                             ;82DB3D;      ;
                       STZ.B !player_pos_X                           ;82DB3F;0000D6;
                       STZ.B !player_pos_Y                            ;82DB41;0000D8;
                       STZ.W !transition_dest_X                          ;82DB43;00017D;
                       STZ.W !transition_dest_Y                          ;82DB46;00017F;
                       STZ.W $0196                          ;82DB49;000196;
                       %Set8bit(!M)                             ;82DB4C;      ;
                       LDA.B #$5B                           ;82DB4E;      ;
                       STA.B !tilemap_to_load                            ;82DB50;000022;
                       JSL.L TilemapManager           ;82DB52;80A7C6;
                       %Set16bit(!M)                             ;82DB56;      ;
                       LDA.W #$006D                         ;82DB58;      ;
                       JSL.L LoadCGRAM                ;82DB5B;8091CF;
                       %Set8bit(!M)                             ;82DB5F;      ;
                       %Set16bit(!X)                             ;82DB61;      ;
                       LDA.B #$00                           ;82DB63;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82DB65;000027;
                       LDA.B #$22                           ;82DB67;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82DB69;000029;
                       %Set16bit(!M)                             ;82DB6B;      ;
                       LDY.W #$0200                         ;82DB6D;      ;
                       LDX.W #$0000                         ;82DB70;      ;
                       LDA.W #$D800                         ;82DB73;      ;
                       STA.B $72                            ;82DB76;000072;
                       %Set8bit(!M)                             ;82DB78;      ;
                       LDA.B #$A9                           ;82DB7A;      ;
                       STA.B $74                            ;82DB7C;000074;
                       JSL.L AddProgrammedDMA                ;82DB7E;808A33;
                       JSL.L StartLastPreparedDMA               ;82DB82;808AB2;
                       %Set8bit(!M)                             ;82DB86;      ;
                       LDA.B #$5C                           ;82DB88;      ;
                       STA.B !tilemap_to_load                            ;82DB8A;000022;
                       BRA CODE_82DBB2                      ;82DB8C;82DBB2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DB8E: %Set8bit(!M)                             ;82DB8E;      ;
                       LDA.B #$5C                           ;82DB90;      ;
                       STA.B !tilemap_to_load                            ;82DB92;000022;
                       JSL.L UNK_Audio5;82DB94;8095DE;
                       JSL.L UNK_Audio25                    ;82DB98;838401;
                       %Set8bit(!M)                             ;82DB9C;      ;
                       LDA.B #$0F                           ;82DB9E;      ;
                       STA.B $92                            ;82DBA0;000092;
                       LDA.B #$01                           ;82DBA2;      ;
                       STA.B $93                            ;82DBA4;000093;
                       LDA.B #$01                           ;82DBA6;      ;
                       STA.B $94                            ;82DBA8;000094;
                       JSL.L ScreenFadeout                  ;82DBAA;80880A;
                       JSL.L ForceBlank                     ;82DBAE;808E0F;
                                                            ;      ;      ;
          CODE_82DBB2: %Set16bit(!M)                             ;82DBB2;      ;
                       STZ.B $90                            ;82DBB4;000090;
                       STZ.W !BG1_Map_Offset_X                          ;82DBB6;00013C;
                       STZ.W !BG1_Map_Offset_Y                          ;82DBB9;00013E;
                       STZ.W !BG2_Map_Offset_X                          ;82DBBC;000140;
                       STZ.W !BG2_Map_Offset_Y                          ;82DBBF;000142;
                       STZ.B !player_pos_X                           ;82DBC2;0000D6;
                       STZ.B !player_pos_Y                            ;82DBC4;0000D8;
                       STZ.W !transition_dest_X                          ;82DBC6;00017D;
                       STZ.W !transition_dest_Y                          ;82DBC9;00017F;
                       STZ.W $0196                          ;82DBCC;000196;
                       JSL.L TilemapManager           ;82DBCF;80A7C6;
                       JSL.L UNK_Audio21                    ;82DBD3;83841F;
                       JSL.L UNK_Audio20                    ;82DBD7;8383A4;
                       JSL.L UNK_Audio22                    ;82DBDB;838380;
                       %Set8bit(!M)                             ;82DBDF;      ;
                       LDA.W $0110                          ;82DBE1;000110;
                       STA.W $0117                          ;82DBE4;000117;
                       JSL.L ResetForceBlank                ;82DBE7;808E1E;
                       JSL.L WaitForNMI               ;82DBEB;808645;
                       %Set8bit(!M)                             ;82DBEF;      ;
                       LDA.B #$01                           ;82DBF1;      ;
                       STA.B $92                            ;82DBF3;000092;
                       LDA.B #$01                           ;82DBF5;      ;
                       STA.B $93                            ;82DBF7;000093;
                       LDA.B #$0F                           ;82DBF9;      ;
                       STA.B $94                            ;82DBFB;000094;
                       JSL.L ScreenFadein                         ;82DBFD;8087CE;
                       %Set8bit(!M)                             ;82DC01;      ;
                       LDA.B #$04                           ;82DC03;      ;
                       STA.B $95                            ;82DC05;000095;
                       STZ.B $94                            ;82DC07;000094;
                       JML.L CODE_82D871                    ;82DC09;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DC0D: %Set8bit(!M)                             ;82DC0D;      ;
                       LDA.B $94                            ;82DC0F;000094;
                       AND.B #$01                           ;82DC11;      ;
                       BEQ CODE_82DC19                      ;82DC13;82DC19;
                       JML.L CODE_82DC22                    ;82DC15;82DC22;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DC19: %Set16bit(!M)                             ;82DC19;      ;
                       LDA.W !BG2_Map_Offset_X                          ;82DC1B;000140;
                       INC A                                ;82DC1E;      ;
                       STA.W !BG2_Map_Offset_X                          ;82DC1F;000140;
                                                            ;      ;      ;
          CODE_82DC22: %Set8bit(!M)                             ;82DC22;      ;
                       LDA.B $94                            ;82DC24;000094;
                       CMP.B #$3C                           ;82DC26;      ;
                       BEQ CODE_82DC32                      ;82DC28;82DC32;
                       %Set8bit(!M)                             ;82DC2A;      ;
                       INC.B $94                            ;82DC2C;000094;
                       JML.L CODE_82D871                    ;82DC2E;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DC32: JSL.L ClearMemoryPointers2           ;82DC32;808FAB;
                       %Set16bit(!M)                             ;82DC36;      ;
                       %Set8bit(!X)                             ;82DC38;      ;
                       LDA.W #$F2A4                         ;82DC3A;      ;
                       STA.B $72                            ;82DC3D;000072;
                       %Set8bit(!M)                             ;82DC3F;      ;
                       LDA.B #$82                           ;82DC41;      ;
                       STA.B $74                            ;82DC43;000074;
                       %Set8bit(!M)                             ;82DC45;      ;
                       LDA.B #$0A                           ;82DC47;      ;
                       LDX.B #$04                           ;82DC49;      ;
                       LDY.B #$07                           ;82DC4B;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DC4D;808E48;
                       %Set16bit(!M)                             ;82DC51;      ;
                       %Set8bit(!X)                             ;82DC53;      ;
                       LDA.W #$F2B5                         ;82DC55;      ;
                       STA.B $72                            ;82DC58;000072;
                       %Set8bit(!M)                             ;82DC5A;      ;
                       LDA.B #$82                           ;82DC5C;      ;
                       STA.B $74                            ;82DC5E;000074;
                       %Set8bit(!M)                             ;82DC60;      ;
                       LDA.B #$0B                           ;82DC62;      ;
                       LDX.B #$05                           ;82DC64;      ;
                       LDY.B #$07                           ;82DC66;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DC68;808E48;
                       %Set8bit(!M)                             ;82DC6C;      ;
                       LDA.W $098D                          ;82DC6E;00098D;
                       CMP.B #$01                           ;82DC71;      ;
                       BNE CODE_82DC79                      ;82DC73;82DC79;
                       JML.L CODE_82DCD6                    ;82DC75;82DCD6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DC79: CMP.B #$02                           ;82DC79;      ;
                       BNE CODE_82DC81                      ;82DC7B;82DC81;
                       JML.L CODE_82DD2B                    ;82DC7D;82DD2B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DC81: %Set16bit(!M)                             ;82DC81;      ;
                       %Set8bit(!X)                             ;82DC83;      ;
                       LDA.W #$F2C9                         ;82DC85;      ;
                       STA.B $72                            ;82DC88;000072;
                       %Set8bit(!M)                             ;82DC8A;      ;
                       LDA.B #$82                           ;82DC8C;      ;
                       STA.B $74                            ;82DC8E;000074;
                       %Set8bit(!M)                             ;82DC90;      ;
                       LDA.B #$0D                           ;82DC92;      ;
                       LDX.B #$06                           ;82DC94;      ;
                       LDY.B #$07                           ;82DC96;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DC98;808E48;
                       %Set16bit(!M)                             ;82DC9C;      ;
                       %Set8bit(!X)                             ;82DC9E;      ;
                       LDA.W #$F2DA                         ;82DCA0;      ;
                       STA.B $72                            ;82DCA3;000072;
                       %Set8bit(!M)                             ;82DCA5;      ;
                       LDA.B #$82                           ;82DCA7;      ;
                       STA.B $74                            ;82DCA9;000074;
                       %Set8bit(!M)                             ;82DCAB;      ;
                       LDA.B #$0F                           ;82DCAD;      ;
                       LDX.B #$07                           ;82DCAF;      ;
                       LDY.B #$07                           ;82DCB1;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DCB3;808E48;
                       %Set16bit(!M)                             ;82DCB7;      ;
                       %Set8bit(!X)                             ;82DCB9;      ;
                       LDA.W #$F2DA                         ;82DCBB;      ;
                       STA.B $72                            ;82DCBE;000072;
                       %Set8bit(!M)                             ;82DCC0;      ;
                       LDA.B #$82                           ;82DCC2;      ;
                       STA.B $74                            ;82DCC4;000074;
                       %Set8bit(!M)                             ;82DCC6;      ;
                       LDA.B #$09                           ;82DCC8;      ;
                       LDX.B #$08                           ;82DCCA;      ;
                       LDY.B #$02                           ;82DCCC;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DCCE;808E48;
                       JML.L CODE_82DD80                    ;82DCD2;82DD80;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DCD6: %Set16bit(!M)                             ;82DCD6;      ;
                       %Set8bit(!X)                             ;82DCD8;      ;
                       LDA.W #$F2DA                         ;82DCDA;      ;
                       STA.B $72                            ;82DCDD;000072;
                       %Set8bit(!M)                             ;82DCDF;      ;
                       LDA.B #$82                           ;82DCE1;      ;
                       STA.B $74                            ;82DCE3;000074;
                       %Set8bit(!M)                             ;82DCE5;      ;
                       LDA.B #$0D                           ;82DCE7;      ;
                       LDX.B #$06                           ;82DCE9;      ;
                       LDY.B #$07                           ;82DCEB;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DCED;808E48;
                       %Set16bit(!M)                             ;82DCF1;      ;
                       %Set8bit(!X)                             ;82DCF3;      ;
                       LDA.W #$F2C9                         ;82DCF5;      ;
                       STA.B $72                            ;82DCF8;000072;
                       %Set8bit(!M)                             ;82DCFA;      ;
                       LDA.B #$82                           ;82DCFC;      ;
                       STA.B $74                            ;82DCFE;000074;
                       %Set8bit(!M)                             ;82DD00;      ;
                       LDA.B #$0F                           ;82DD02;      ;
                       LDX.B #$07                           ;82DD04;      ;
                       LDY.B #$07                           ;82DD06;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DD08;808E48;
                       %Set16bit(!M)                             ;82DD0C;      ;
                       %Set8bit(!X)                             ;82DD0E;      ;
                       LDA.W #$F2DA                         ;82DD10;      ;
                       STA.B $72                            ;82DD13;000072;
                       %Set8bit(!M)                             ;82DD15;      ;
                       LDA.B #$82                           ;82DD17;      ;
                       STA.B $74                            ;82DD19;000074;
                       %Set8bit(!M)                             ;82DD1B;      ;
                       LDA.B #$09                           ;82DD1D;      ;
                       LDX.B #$08                           ;82DD1F;      ;
                       LDY.B #$02                           ;82DD21;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DD23;808E48;
                       JML.L CODE_82DD80                    ;82DD27;82DD80;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DD2B: %Set16bit(!M)                             ;82DD2B;      ;
                       %Set8bit(!X)                             ;82DD2D;      ;
                       LDA.W #$F2DA                         ;82DD2F;      ;
                       STA.B $72                            ;82DD32;000072;
                       %Set8bit(!M)                             ;82DD34;      ;
                       LDA.B #$82                           ;82DD36;      ;
                       STA.B $74                            ;82DD38;000074;
                       %Set8bit(!M)                             ;82DD3A;      ;
                       LDA.B #$0D                           ;82DD3C;      ;
                       LDX.B #$06                           ;82DD3E;      ;
                       LDY.B #$07                           ;82DD40;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DD42;808E48;
                       %Set16bit(!M)                             ;82DD46;      ;
                       %Set8bit(!X)                             ;82DD48;      ;
                       LDA.W #$F2DA                         ;82DD4A;      ;
                       STA.B $72                            ;82DD4D;000072;
                       %Set8bit(!M)                             ;82DD4F;      ;
                       LDA.B #$82                           ;82DD51;      ;
                       STA.B $74                            ;82DD53;000074;
                       %Set8bit(!M)                             ;82DD55;      ;
                       LDA.B #$0F                           ;82DD57;      ;
                       LDX.B #$07                           ;82DD59;      ;
                       LDY.B #$07                           ;82DD5B;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DD5D;808E48;
                       %Set16bit(!M)                             ;82DD61;      ;
                       %Set8bit(!X)                             ;82DD63;      ;
                       LDA.W #$F2C9                         ;82DD65;      ;
                       STA.B $72                            ;82DD68;000072;
                       %Set8bit(!M)                             ;82DD6A;      ;
                       LDA.B #$82                           ;82DD6C;      ;
                       STA.B $74                            ;82DD6E;000074;
                       %Set8bit(!M)                             ;82DD70;      ;
                       LDA.B #$09                           ;82DD72;      ;
                       LDX.B #$08                           ;82DD74;      ;
                       LDY.B #$02                           ;82DD76;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DD78;808E48;
                       JML.L CODE_82DD80                    ;82DD7C;82DD80;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DD80: %Set8bit(!M)                             ;82DD80;      ;
                       LDA.B #$05                           ;82DD82;      ;
                       STA.B $95                            ;82DD84;000095;
                       STZ.B $94                            ;82DD86;000094;
                       JML.L CODE_82D871                    ;82DD88;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DD8C: %Set8bit(!M)                             ;82DD8C;      ;
                       LDA.B $94                            ;82DD8E;000094;
                       AND.B #$01                           ;82DD90;      ;
                       BNE CODE_82DD9D                      ;82DD92;82DD9D;
                       %Set16bit(!M)                             ;82DD94;      ;
                       LDA.W !BG2_Map_Offset_X                          ;82DD96;000140;
                       INC A                                ;82DD99;      ;
                       STA.W !BG2_Map_Offset_X                          ;82DD9A;000140;
                                                            ;      ;      ;
          CODE_82DD9D: %Set8bit(!M)                             ;82DD9D;      ;
                       INC.B $94                            ;82DD9F;000094;
                       LDA.B $97                            ;82DDA1;000097;
                       BNE CODE_82DDA9                      ;82DDA3;82DDA9;
                       JML.L CODE_82DEBD                    ;82DDA5;82DEBD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DDA9: STZ.B $97                            ;82DDA9;000097;
                       LDA.W $098D                          ;82DDAB;00098D;
                       CMP.B #$01                           ;82DDAE;      ;
                       BNE CODE_82DDB6                      ;82DDB0;82DDB6;
                       JML.L CODE_82DE13                    ;82DDB2;82DE13;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DDB6: CMP.B #$02                           ;82DDB6;      ;
                       BNE CODE_82DDBE                      ;82DDB8;82DDBE;
                       JML.L CODE_82DE68                    ;82DDBA;82DE68;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DDBE: %Set16bit(!M)                             ;82DDBE;      ;
                       %Set8bit(!X)                             ;82DDC0;      ;
                       LDA.W #$F2C9                         ;82DDC2;      ;
                       STA.B $72                            ;82DDC5;000072;
                       %Set8bit(!M)                             ;82DDC7;      ;
                       LDA.B #$82                           ;82DDC9;      ;
                       STA.B $74                            ;82DDCB;000074;
                       %Set8bit(!M)                             ;82DDCD;      ;
                       LDA.B #$0D                           ;82DDCF;      ;
                       LDX.B #$06                           ;82DDD1;      ;
                       LDY.B #$07                           ;82DDD3;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DDD5;808E48;
                       %Set16bit(!M)                             ;82DDD9;      ;
                       %Set8bit(!X)                             ;82DDDB;      ;
                       LDA.W #$F2DA                         ;82DDDD;      ;
                       STA.B $72                            ;82DDE0;000072;
                       %Set8bit(!M)                             ;82DDE2;      ;
                       LDA.B #$82                           ;82DDE4;      ;
                       STA.B $74                            ;82DDE6;000074;
                       %Set8bit(!M)                             ;82DDE8;      ;
                       LDA.B #$0F                           ;82DDEA;      ;
                       LDX.B #$07                           ;82DDEC;      ;
                       LDY.B #$07                           ;82DDEE;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DDF0;808E48;
                       %Set16bit(!M)                             ;82DDF4;      ;
                       %Set8bit(!X)                             ;82DDF6;      ;
                       LDA.W #$F2DA                         ;82DDF8;      ;
                       STA.B $72                            ;82DDFB;000072;
                       %Set8bit(!M)                             ;82DDFD;      ;
                       LDA.B #$82                           ;82DDFF;      ;
                       STA.B $74                            ;82DE01;000074;
                       %Set8bit(!M)                             ;82DE03;      ;
                       LDA.B #$09                           ;82DE05;      ;
                       LDX.B #$08                           ;82DE07;      ;
                       LDY.B #$02                           ;82DE09;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DE0B;808E48;
                       JML.L CODE_82DEBD                    ;82DE0F;82DEBD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DE13: %Set16bit(!M)                             ;82DE13;      ;
                       %Set8bit(!X)                             ;82DE15;      ;
                       LDA.W #$F2DA                         ;82DE17;      ;
                       STA.B $72                            ;82DE1A;000072;
                       %Set8bit(!M)                             ;82DE1C;      ;
                       LDA.B #$82                           ;82DE1E;      ;
                       STA.B $74                            ;82DE20;000074;
                       %Set8bit(!M)                             ;82DE22;      ;
                       LDA.B #$0D                           ;82DE24;      ;
                       LDX.B #$06                           ;82DE26;      ;
                       LDY.B #$07                           ;82DE28;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DE2A;808E48;
                       %Set16bit(!M)                             ;82DE2E;      ;
                       %Set8bit(!X)                             ;82DE30;      ;
                       LDA.W #$F2C9                         ;82DE32;      ;
                       STA.B $72                            ;82DE35;000072;
                       %Set8bit(!M)                             ;82DE37;      ;
                       LDA.B #$82                           ;82DE39;      ;
                       STA.B $74                            ;82DE3B;000074;
                       %Set8bit(!M)                             ;82DE3D;      ;
                       LDA.B #$0F                           ;82DE3F;      ;
                       LDX.B #$07                           ;82DE41;      ;
                       LDY.B #$07                           ;82DE43;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DE45;808E48;
                       %Set16bit(!M)                             ;82DE49;      ;
                       %Set8bit(!X)                             ;82DE4B;      ;
                       LDA.W #$F2DA                         ;82DE4D;      ;
                       STA.B $72                            ;82DE50;000072;
                       %Set8bit(!M)                             ;82DE52;      ;
                       LDA.B #$82                           ;82DE54;      ;
                       STA.B $74                            ;82DE56;000074;
                       %Set8bit(!M)                             ;82DE58;      ;
                       LDA.B #$09                           ;82DE5A;      ;
                       LDX.B #$08                           ;82DE5C;      ;
                       LDY.B #$02                           ;82DE5E;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DE60;808E48;
                       JML.L CODE_82DEBD                    ;82DE64;82DEBD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DE68: %Set16bit(!M)                             ;82DE68;      ;
                       %Set8bit(!X)                             ;82DE6A;      ;
                       LDA.W #$F2DA                         ;82DE6C;      ;
                       STA.B $72                            ;82DE6F;000072;
                       %Set8bit(!M)                             ;82DE71;      ;
                       LDA.B #$82                           ;82DE73;      ;
                       STA.B $74                            ;82DE75;000074;
                       %Set8bit(!M)                             ;82DE77;      ;
                       LDA.B #$0D                           ;82DE79;      ;
                       LDX.B #$06                           ;82DE7B;      ;
                       LDY.B #$07                           ;82DE7D;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DE7F;808E48;
                       %Set16bit(!M)                             ;82DE83;      ;
                       %Set8bit(!X)                             ;82DE85;      ;
                       LDA.W #$F2DA                         ;82DE87;      ;
                       STA.B $72                            ;82DE8A;000072;
                       %Set8bit(!M)                             ;82DE8C;      ;
                       LDA.B #$82                           ;82DE8E;      ;
                       STA.B $74                            ;82DE90;000074;
                       %Set8bit(!M)                             ;82DE92;      ;
                       LDA.B #$0F                           ;82DE94;      ;
                       LDX.B #$07                           ;82DE96;      ;
                       LDY.B #$07                           ;82DE98;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DE9A;808E48;
                       %Set16bit(!M)                             ;82DE9E;      ;
                       %Set8bit(!X)                             ;82DEA0;      ;
                       LDA.W #$F2C9                         ;82DEA2;      ;
                       STA.B $72                            ;82DEA5;000072;
                       %Set8bit(!M)                             ;82DEA7;      ;
                       LDA.B #$82                           ;82DEA9;      ;
                       STA.B $74                            ;82DEAB;000074;
                       %Set8bit(!M)                             ;82DEAD;      ;
                       LDA.B #$09                           ;82DEAF;      ;
                       LDX.B #$08                           ;82DEB1;      ;
                       LDY.B #$02                           ;82DEB3;      ;
                       JSL.L UNK_MemoryWork42_44            ;82DEB5;808E48;
                       JML.L CODE_82DEBD                    ;82DEB9;82DEBD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DEBD: %Set16bit(!MX)                             ;82DEBD;      ;
                       INC.B $90                            ;82DEBF;000090;
                       JML.L CODE_82D871                    ;82DEC1;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DEC5: %Set8bit(!M)                             ;82DEC5;      ;
                       LDA.B #$5C                           ;82DEC7;      ;
                       STA.B !tilemap_to_load                            ;82DEC9;000022;
                       JSL.L UNK_Audio5;82DECB;8095DE;
                       JSL.L UNK_Audio25                    ;82DECF;838401;
                       %Set8bit(!M)                             ;82DED3;      ;
                       LDA.B #$0F                           ;82DED5;      ;
                       STA.B $92                            ;82DED7;000092;
                       LDA.B #$01                           ;82DED9;      ;
                       STA.B $93                            ;82DEDB;000093;
                       LDA.B #$01                           ;82DEDD;      ;
                       STA.B $94                            ;82DEDF;000094;
                       JSL.L ScreenFadeout                  ;82DEE1;80880A;
                       JSL.L ForceBlank                     ;82DEE5;808E0F;
                       JSL.L ZeroesVRAM                      ;82DEE9;808846;
                       %Set8bit(!M)                             ;82DEED;      ;
                       LDA.B #$03                           ;82DEEF;      ;
                       JSL.L ManageGraphicPresets             ;82DEF1;808C59;
                       %Set16bit(!M)                             ;82DEF5;      ;
                       STZ.W !BG1_Map_Offset_X                          ;82DEF7;00013C;
                       STZ.W !BG1_Map_Offset_Y                          ;82DEFA;00013E;
                       STZ.W !BG2_Map_Offset_X                          ;82DEFD;000140;
                       STZ.W !BG2_Map_Offset_Y                          ;82DF00;000142;
                       STZ.B !player_pos_X                           ;82DF03;0000D6;
                       STZ.B !player_pos_Y                            ;82DF05;0000D8;
                       STZ.W !transition_dest_X                          ;82DF07;00017D;
                       STZ.W !transition_dest_Y                          ;82DF0A;00017F;
                       STZ.W $0196                          ;82DF0D;000196;
                       %Set8bit(!M)                             ;82DF10;      ;
                       LDA.B #$5B                           ;82DF12;      ;
                       STA.B !tilemap_to_load                            ;82DF14;000022;
                       JSL.L TilemapManager           ;82DF16;80A7C6;
                       %Set8bit(!M)                             ;82DF1A;      ;
                       LDA.B #$5C                           ;82DF1C;      ;
                       STA.B !tilemap_to_load                            ;82DF1E;000022;
                       JSL.L TilemapManager           ;82DF20;80A7C6;
                       %Set16bit(!M)                             ;82DF24;      ;
                       LDA.W #$006D                         ;82DF26;      ;
                       JSL.L LoadCGRAM                ;82DF29;8091CF;
                       %Set8bit(!M)                             ;82DF2D;      ;
                       %Set16bit(!X)                             ;82DF2F;      ;
                       LDA.B #$00                           ;82DF31;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82DF33;000027;
                       LDA.B #$22                           ;82DF35;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82DF37;000029;
                       %Set16bit(!M)                             ;82DF39;      ;
                       LDY.W #$0200                         ;82DF3B;      ;
                       LDX.W #$0000                         ;82DF3E;      ;
                       LDA.W #$D800                         ;82DF41;      ;
                       STA.B $72                            ;82DF44;000072;
                       %Set8bit(!M)                             ;82DF46;      ;
                       LDA.B #$A9                           ;82DF48;      ;
                       STA.B $74                            ;82DF4A;000074;
                       JSL.L AddProgrammedDMA                ;82DF4C;808A33;
                       JSL.L StartLastPreparedDMA               ;82DF50;808AB2;
                       JSL.L UNK_Audio21                    ;82DF54;83841F;
                       JSL.L UNK_Audio20                    ;82DF58;8383A4;
                       JSL.L UNK_Audio22                    ;82DF5C;838380;
                       %Set8bit(!M)                             ;82DF60;      ;
                       LDA.W $0110                          ;82DF62;000110;
                       STA.W $0117                          ;82DF65;000117;
                       JSL.L ResetForceBlank                ;82DF68;808E1E;
                       JSL.L WaitForNMI               ;82DF6C;808645;
                       %Set8bit(!M)                             ;82DF70;      ;
                       LDA.B #$01                           ;82DF72;      ;
                       STA.B $92                            ;82DF74;000092;
                       LDA.B #$01                           ;82DF76;      ;
                       STA.B $93                            ;82DF78;000093;
                       LDA.B #$0F                           ;82DF7A;      ;
                       STA.B $94                            ;82DF7C;000094;
                       JSL.L ScreenFadein                         ;82DF7E;8087CE;
                       %Set8bit(!M)                             ;82DF82;      ;
                       LDA.B #$04                           ;82DF84;      ;
                       STA.B $95                            ;82DF86;000095;
                       STZ.B $94                            ;82DF88;000094;
                       %Set16bit(!M)                             ;82DF8A;      ;
                       STZ.B $90                            ;82DF8C;000090;
                       JML.L CODE_82D871                    ;82DF8E;82D871;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82DF92: %Set8bit(!M)                             ;82DF92;      ;
                       LDA.B #$5E                           ;82DF94;      ;
                       STA.B !tilemap_to_load                            ;82DF96;000022;
                       JSL.L UNK_Audio5;82DF98;8095DE;
                       JSL.L UNK_Audio25                    ;82DF9C;838401;
                       %Set8bit(!M)                             ;82DFA0;      ;
                       LDA.B #$0F                           ;82DFA2;      ;
                       STA.B $92                            ;82DFA4;000092;
                       LDA.B #$03                           ;82DFA6;      ;
                       STA.B $93                            ;82DFA8;000093;
                       LDA.B #$01                           ;82DFAA;      ;
                       STA.B $94                            ;82DFAC;000094;
                       JSL.L ScreenFadeout                  ;82DFAE;80880A;
                       JSL.L ForceBlank                     ;82DFB2;808E0F;
                       JSL.L ZeroesVRAM                      ;82DFB6;808846;
                       %Set8bit(!M)                             ;82DFBA;      ;
                       LDA.B #$04                           ;82DFBC;      ;
                       JSL.L ManageGraphicPresets             ;82DFBE;808C59;
                       JSL.L TilemapManager           ;82DFC2;80A7C6;
                       %Set16bit(!M)                             ;82DFC6;      ;
                       LDA.W #$006F                         ;82DFC8;      ;
                       JSL.L LoadCGRAM                ;82DFCB;8091CF;
                       %Set8bit(!M)                             ;82DFCF;      ;
                       %Set16bit(!X)                             ;82DFD1;      ;
                       LDA.B #$00                           ;82DFD3;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82DFD5;000027;
                       LDA.B #$22                           ;82DFD7;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82DFD9;000029;
                       %Set16bit(!M)                             ;82DFDB;      ;
                       LDY.W #$0200                         ;82DFDD;      ;
                       LDX.W #$0000                         ;82DFE0;      ;
                       LDA.W #$8C00                         ;82DFE3;      ;
                       STA.B $72                            ;82DFE6;000072;
                       %Set8bit(!M)                             ;82DFE8;      ;
                       LDA.B #$A9                           ;82DFEA;      ;
                       STA.B $74                            ;82DFEC;000074;
                       JSL.L AddProgrammedDMA                ;82DFEE;808A33;
                       JSL.L StartLastPreparedDMA               ;82DFF2;808AB2;
                       JSR.W CODE_82E742                    ;82DFF6;82E742;
                       %Set16bit(!MX)                             ;82DFF9;      ;
                       LDA.W #$0000                         ;82DFFB;      ;
                       LDY.W #$0000                         ;82DFFE;      ;
                       JSR.W CODE_82E405                    ;82E001;82E405;
                       %Set16bit(!MX)                             ;82E004;      ;
                       LDA.W #$0001                         ;82E006;      ;
                       LDY.W #$0000                         ;82E009;      ;
                       JSR.W CODE_82E405                    ;82E00C;82E405;
                       JSL.L ClearMemoryPointers2           ;82E00F;808FAB;
                       %Set16bit(!M)                             ;82E013;      ;
                       STZ.W !BG1_Map_Offset_X                          ;82E015;00013C;
                       STZ.W !BG1_Map_Offset_Y                          ;82E018;00013E;
                       STZ.W !BG2_Map_Offset_X                          ;82E01B;000140;
                       STZ.W !BG2_Map_Offset_Y                          ;82E01E;000142;
                       STZ.W !BG3_Map_Offset_X                          ;82E021;000144;
                       STZ.W !BG3_Map_Offset_Y                          ;82E024;000146;
                       %Set8bit(!M)                             ;82E027;      ;
                       LDA.B #$00                           ;82E029;      ;
                       XBA                                  ;82E02B;      ;
                       LDA.W $098E                          ;82E02C;00098E;
                       JSL.L LoadGameSlotResume                      ;82E02F;83BA45;
                       %Set16bit(!MX)                             ;82E033;      ;
                       CPX.W #$0000                         ;82E035;      ;
                       BEQ CODE_82E03A                      ;82E038;82E03A;
                                                            ;      ;      ;
          CODE_82E03A: %Set8bit(!M)                             ;82E03A;      ;
                       LDA.W $098E                          ;82E03C;00098E;
                       BEQ CODE_82E045                      ;82E03F;82E045;
                       JML.L CODE_82E07F                    ;82E041;82E07F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E045: %Set16bit(!M)                             ;82E045;      ;
                       %Set8bit(!X)                             ;82E047;      ;
                       LDA.W #$F2E2                         ;82E049;      ;
                       STA.B $72                            ;82E04C;000072;
                       %Set8bit(!M)                             ;82E04E;      ;
                       LDA.B #$82                           ;82E050;      ;
                       STA.B $74                            ;82E052;000074;
                       %Set8bit(!M)                             ;82E054;      ;
                       LDA.B #$06                           ;82E056;      ;
                       LDX.B #$04                           ;82E058;      ;
                       LDY.B #$00                           ;82E05A;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E05C;808E48;
                       %Set16bit(!M)                             ;82E060;      ;
                       %Set8bit(!X)                             ;82E062;      ;
                       LDA.W #$F2F9                         ;82E064;      ;
                       STA.B $72                            ;82E067;000072;
                       %Set8bit(!M)                             ;82E069;      ;
                       LDA.B #$82                           ;82E06B;      ;
                       STA.B $74                            ;82E06D;000074;
                       %Set8bit(!M)                             ;82E06F;      ;
                       LDA.B #$06                           ;82E071;      ;
                       LDX.B #$05                           ;82E073;      ;
                       LDY.B #$01                           ;82E075;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E077;808E48;
                       JML.L CODE_82E0B5                    ;82E07B;82E0B5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E07F: %Set16bit(!M)                             ;82E07F;      ;
                       %Set8bit(!X)                             ;82E081;      ;
                       LDA.W #$F2F9                         ;82E083;      ;
                       STA.B $72                            ;82E086;000072;
                       %Set8bit(!M)                             ;82E088;      ;
                       LDA.B #$82                           ;82E08A;      ;
                       STA.B $74                            ;82E08C;000074;
                       %Set8bit(!M)                             ;82E08E;      ;
                       LDA.B #$06                           ;82E090;      ;
                       LDX.B #$04                           ;82E092;      ;
                       LDY.B #$00                           ;82E094;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E096;808E48;
                       %Set16bit(!M)                             ;82E09A;      ;
                       %Set8bit(!X)                             ;82E09C;      ;
                       LDA.W #$F2E2                         ;82E09E;      ;
                       STA.B $72                            ;82E0A1;000072;
                       %Set8bit(!M)                             ;82E0A3;      ;
                       LDA.B #$82                           ;82E0A5;      ;
                       STA.B $74                            ;82E0A7;000074;
                       %Set8bit(!M)                             ;82E0A9;      ;
                       LDA.B #$06                           ;82E0AB;      ;
                       LDX.B #$05                           ;82E0AD;      ;
                       LDY.B #$01                           ;82E0AF;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E0B1;808E48;
                                                            ;      ;      ;
          CODE_82E0B5: JSL.L UNK_Audio21                    ;82E0B5;83841F;
                       JSL.L UNK_Audio20                    ;82E0B9;8383A4;
                       JSL.L UNK_Audio22                    ;82E0BD;838380;
                       %Set8bit(!M)                             ;82E0C1;      ;
                       LDA.W $0110                          ;82E0C3;000110;
                       STA.W $0117                          ;82E0C6;000117;
                       JSL.L ResetForceBlank                ;82E0C9;808E1E;
                       JSL.L WaitForNMI               ;82E0CD;808645;
                       %Set8bit(!M)                             ;82E0D1;      ;
                       LDA.B #$03                           ;82E0D3;      ;
                       STA.B $92                            ;82E0D5;000092;
                       LDA.B #$03                           ;82E0D7;      ;
                       STA.B $93                            ;82E0D9;000093;
                       LDA.B #$0F                           ;82E0DB;      ;
                       STA.B $94                            ;82E0DD;000094;
                       JSL.L ScreenFadein                         ;82E0DF;8087CE;
                       %Set8bit(!M)                             ;82E0E3;      ;
                       STZ.B $94                            ;82E0E5;000094;
                       STZ.B $96                            ;82E0E7;000096;
                       STZ.B $97                            ;82E0E9;000097;
                                                            ;      ;      ;
          CODE_82E0EB: %Set8bit(!M)                             ;82E0EB;      ;
                       LDA.B !NMI_Status                            ;82E0ED;000000;
                       BEQ CODE_82E0EB                      ;82E0EF;82E0EB;
                       %Set16bit(!M)                             ;82E0F1;      ;
                       LDA.W #$1800                         ;82E0F3;      ;
                       STA.B $C7                            ;82E0F6;0000C7;
                       JSL.L UNK_BigLoop                    ;82E0F8;808E69;
                       JSL.L InputTypeSelector                          ;82E0FC;84C034;
                       %Set8bit(!M)                             ;82E100;      ;
                       LDA.B $97                            ;82E102;000097;
                       BNE CODE_82E10A                      ;82E104;82E10A;
                       JML.L CODE_82E1BD                    ;82E106;82E1BD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E10A: STZ.B $97                            ;82E10A;000097;
                       LDA.W $098E                          ;82E10C;00098E;
                       BEQ CODE_82E115                      ;82E10F;82E115;
                       JML.L CODE_82E16B                    ;82E111;82E16B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E115: %Set16bit(!M)                             ;82E115;      ;
                       LDA.W #$0000                         ;82E117;      ;
                       JSL.L LoadGameSlotResume                      ;82E11A;83BA45;
                       %Set16bit(!MX)                             ;82E11E;      ;
                       CPX.W #$0000                         ;82E120;      ;
                       BEQ CODE_82E127                      ;82E123;82E127;
                       BRA CODE_82E131                      ;82E125;82E131;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E127: %Set16bit(!MX)                             ;82E127;      ;
                       LDA.W #$0000                         ;82E129;      ;
                       STA.W !BG1_Map_Offset_X                          ;82E12C;00013C;
                       BRA CODE_82E131                      ;82E12F;82E131;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E131: %Set16bit(!M)                             ;82E131;      ;
                       %Set8bit(!X)                             ;82E133;      ;
                       LDA.W #$F2E2                         ;82E135;      ;
                       STA.B $72                            ;82E138;000072;
                       %Set8bit(!M)                             ;82E13A;      ;
                       LDA.B #$82                           ;82E13C;      ;
                       STA.B $74                            ;82E13E;000074;
                       %Set8bit(!M)                             ;82E140;      ;
                       LDA.B #$06                           ;82E142;      ;
                       LDX.B #$04                           ;82E144;      ;
                       LDY.B #$00                           ;82E146;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E148;808E48;
                       %Set16bit(!M)                             ;82E14C;      ;
                       %Set8bit(!X)                             ;82E14E;      ;
                       LDA.W #$F2F9                         ;82E150;      ;
                       STA.B $72                            ;82E153;000072;
                       %Set8bit(!M)                             ;82E155;      ;
                       LDA.B #$82                           ;82E157;      ;
                       STA.B $74                            ;82E159;000074;
                       %Set8bit(!M)                             ;82E15B;      ;
                       LDA.B #$06                           ;82E15D;      ;
                       LDX.B #$05                           ;82E15F;      ;
                       LDY.B #$01                           ;82E161;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E163;808E48;
                       JML.L CODE_82E1BD                    ;82E167;82E1BD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E16B: %Set16bit(!M)                             ;82E16B;      ;
                       LDA.W #$0001                         ;82E16D;      ;
                       JSL.L LoadGameSlotResume                      ;82E170;83BA45;
                       %Set16bit(!MX)                             ;82E174;      ;
                       CPX.W #$0000                         ;82E176;      ;
                       BEQ CODE_82E17D                      ;82E179;82E17D;
                       BRA CODE_82E187                      ;82E17B;82E187;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E17D: %Set16bit(!MX)                             ;82E17D;      ;
                       LDA.W #$0000                         ;82E17F;      ;
                       STA.W !BG1_Map_Offset_X                          ;82E182;00013C;
                       BRA CODE_82E187                      ;82E185;82E187;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E187: %Set16bit(!M)                             ;82E187;      ;
                       %Set8bit(!X)                             ;82E189;      ;
                       LDA.W #$F2F9                         ;82E18B;      ;
                       STA.B $72                            ;82E18E;000072;
                       %Set8bit(!M)                             ;82E190;      ;
                       LDA.B #$82                           ;82E192;      ;
                       STA.B $74                            ;82E194;000074;
                       %Set8bit(!M)                             ;82E196;      ;
                       LDA.B #$06                           ;82E198;      ;
                       LDX.B #$04                           ;82E19A;      ;
                       LDY.B #$00                           ;82E19C;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E19E;808E48;
                       %Set16bit(!M)                             ;82E1A2;      ;
                       %Set8bit(!X)                             ;82E1A4;      ;
                       LDA.W #$F2E2                         ;82E1A6;      ;
                       STA.B $72                            ;82E1A9;000072;
                       %Set8bit(!M)                             ;82E1AB;      ;
                       LDA.B #$82                           ;82E1AD;      ;
                       STA.B $74                            ;82E1AF;000074;
                       %Set8bit(!M)                             ;82E1B1;      ;
                       LDA.B #$06                           ;82E1B3;      ;
                       LDX.B #$05                           ;82E1B5;      ;
                       LDY.B #$01                           ;82E1B7;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E1B9;808E48;
                                                            ;      ;      ;
          CODE_82E1BD: %Set8bit(!M)                             ;82E1BD;      ;
                       LDA.B $96                            ;82E1BF;000096;
                       CMP.B #$01                           ;82E1C1;      ;
                       BNE CODE_82E1D1                      ;82E1C3;82E1D1;
                       STZ.B $96                            ;82E1C5;000096;
                       %Set16bit(!M)                             ;82E1C7;      ;
                       INC.W !BG2_Map_Offset_X                          ;82E1C9;000140;
                       DEC.W !BG2_Map_Offset_Y                          ;82E1CC;000142;
                       BRA CODE_82E1D5                      ;82E1CF;82E1D5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E1D1: %Set8bit(!M)                             ;82E1D1;      ;
                       INC.B $96                            ;82E1D3;000096;
                                                            ;      ;      ;
          CODE_82E1D5: %Set8bit(!M)                             ;82E1D5;      ;
                       LDA.B $94                            ;82E1D7;000094;
                       CMP.B #$01                           ;82E1D9;      ;
                       BNE CODE_82E1E1                      ;82E1DB;82E1E1;
                       JML.L CODE_82DEC5                    ;82E1DD;82DEC5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E1E1: CMP.B #$02                           ;82E1E1;      ;
                       BNE CODE_82E1E9                      ;82E1E3;82E1E9;
                       JML.L CODE_82E7F9                    ;82E1E5;82E7F9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E1E9: %Set8bit(!M)                             ;82E1E9;      ;
                       STZ.B !NMI_Status                            ;82E1EB;000000;
                       JML.L CODE_82E0EB                    ;82E1ED;82E0EB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E1F1: %Set8bit(!M)                             ;82E1F1;      ;
                       LDA.B #$5E                           ;82E1F3;      ;
                       STA.B !tilemap_to_load                            ;82E1F5;000022;
                       JSL.L UNK_Audio5;82E1F7;8095DE;
                       JSL.L UNK_Audio25                    ;82E1FB;838401;
                       %Set8bit(!M)                             ;82E1FF;      ;
                       LDA.B #$0F                           ;82E201;      ;
                       STA.B $92                            ;82E203;000092;
                       LDA.B #$03                           ;82E205;      ;
                       STA.B $93                            ;82E207;000093;
                       LDA.B #$01                           ;82E209;      ;
                       STA.B $94                            ;82E20B;000094;
                       JSL.L ScreenFadeout                  ;82E20D;80880A;
                       JSL.L ForceBlank                     ;82E211;808E0F;
                       JSL.L ZeroesVRAM                      ;82E215;808846;
                       %Set8bit(!M)                             ;82E219;      ;
                       LDA.B #$04                           ;82E21B;      ;
                       JSL.L ManageGraphicPresets             ;82E21D;808C59;
                       JSL.L TilemapManager           ;82E221;80A7C6;
                       %Set16bit(!M)                             ;82E225;      ;
                       LDA.W #$006F                         ;82E227;      ;
                       JSL.L LoadCGRAM                ;82E22A;8091CF;
                       %Set8bit(!M)                             ;82E22E;      ;
                       %Set16bit(!X)                             ;82E230;      ;
                       LDA.B #$00                           ;82E232;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82E234;000027;
                       LDA.B #$22                           ;82E236;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82E238;000029;
                       %Set16bit(!M)                             ;82E23A;      ;
                       LDY.W #$0200                         ;82E23C;      ;
                       LDX.W #$0000                         ;82E23F;      ;
                       LDA.W #$8C00                         ;82E242;      ;
                       STA.B $72                            ;82E245;000072;
                       %Set8bit(!M)                             ;82E247;      ;
                       LDA.B #$A9                           ;82E249;      ;
                       STA.B $74                            ;82E24B;000074;
                       JSL.L AddProgrammedDMA                ;82E24D;808A33;
                       JSL.L StartLastPreparedDMA               ;82E251;808AB2;
                       JSR.W CODE_82E742                    ;82E255;82E742;
                       %Set16bit(!MX)                             ;82E258;      ;
                       LDA.W #$0000                         ;82E25A;      ;
                       LDY.W #$0001                         ;82E25D;      ;
                       JSR.W CODE_82E405                    ;82E260;82E405;
                       %Set16bit(!MX)                             ;82E263;      ;
                       LDA.W #$0001                         ;82E265;      ;
                       LDY.W #$0001                         ;82E268;      ;
                       JSR.W CODE_82E405                    ;82E26B;82E405;
                       JSL.L ClearMemoryPointers2           ;82E26E;808FAB;
                       %Set8bit(!M)                             ;82E272;      ;
                       LDA.W $098E                          ;82E274;00098E;
                       BEQ CODE_82E27D                      ;82E277;82E27D;
                       JML.L CODE_82E2B7                    ;82E279;82E2B7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E27D: %Set16bit(!M)                             ;82E27D;      ;
                       %Set8bit(!X)                             ;82E27F;      ;
                       LDA.W #$F2E2                         ;82E281;      ;
                       STA.B $72                            ;82E284;000072;
                       %Set8bit(!M)                             ;82E286;      ;
                       LDA.B #$82                           ;82E288;      ;
                       STA.B $74                            ;82E28A;000074;
                       %Set8bit(!M)                             ;82E28C;      ;
                       LDA.B #$06                           ;82E28E;      ;
                       LDX.B #$04                           ;82E290;      ;
                       LDY.B #$00                           ;82E292;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E294;808E48;
                       %Set16bit(!M)                             ;82E298;      ;
                       %Set8bit(!X)                             ;82E29A;      ;
                       LDA.W #$F2F9                         ;82E29C;      ;
                       STA.B $72                            ;82E29F;000072;
                       %Set8bit(!M)                             ;82E2A1;      ;
                       LDA.B #$82                           ;82E2A3;      ;
                       STA.B $74                            ;82E2A5;000074;
                       %Set8bit(!M)                             ;82E2A7;      ;
                       LDA.B #$06                           ;82E2A9;      ;
                       LDX.B #$05                           ;82E2AB;      ;
                       LDY.B #$01                           ;82E2AD;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E2AF;808E48;
                       JML.L CODE_82E2ED                    ;82E2B3;82E2ED;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E2B7: %Set16bit(!M)                             ;82E2B7;      ;
                       %Set8bit(!X)                             ;82E2B9;      ;
                       LDA.W #$F2F9                         ;82E2BB;      ;
                       STA.B $72                            ;82E2BE;000072;
                       %Set8bit(!M)                             ;82E2C0;      ;
                       LDA.B #$82                           ;82E2C2;      ;
                       STA.B $74                            ;82E2C4;000074;
                       %Set8bit(!M)                             ;82E2C6;      ;
                       LDA.B #$06                           ;82E2C8;      ;
                       LDX.B #$04                           ;82E2CA;      ;
                       LDY.B #$00                           ;82E2CC;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E2CE;808E48;
                       %Set16bit(!M)                             ;82E2D2;      ;
                       %Set8bit(!X)                             ;82E2D4;      ;
                       LDA.W #$F2E2                         ;82E2D6;      ;
                       STA.B $72                            ;82E2D9;000072;
                       %Set8bit(!M)                             ;82E2DB;      ;
                       LDA.B #$82                           ;82E2DD;      ;
                       STA.B $74                            ;82E2DF;000074;
                       %Set8bit(!M)                             ;82E2E1;      ;
                       LDA.B #$06                           ;82E2E3;      ;
                       LDX.B #$05                           ;82E2E5;      ;
                       LDY.B #$01                           ;82E2E7;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E2E9;808E48;
                                                            ;      ;      ;
          CODE_82E2ED: %Set16bit(!M)                             ;82E2ED;      ;
                       STZ.W !BG1_Map_Offset_X                          ;82E2EF;00013C;
                       STZ.W !BG1_Map_Offset_Y                          ;82E2F2;00013E;
                       STZ.W !BG2_Map_Offset_X                          ;82E2F5;000140;
                       STZ.W !BG2_Map_Offset_Y                          ;82E2F8;000142;
                       STZ.W !BG3_Map_Offset_X                          ;82E2FB;000144;
                       STZ.W !BG3_Map_Offset_Y                          ;82E2FE;000146;
                       JSL.L UNK_Audio21                    ;82E301;83841F;
                       JSL.L UNK_Audio20                    ;82E305;8383A4;
                       JSL.L UNK_Audio22                    ;82E309;838380;
                       %Set8bit(!M)                             ;82E30D;      ;
                       LDA.W $0110                          ;82E30F;000110;
                       STA.W $0117                          ;82E312;000117;
                       JSL.L ResetForceBlank                ;82E315;808E1E;
                       JSL.L WaitForNMI               ;82E319;808645;
                       %Set8bit(!M)                             ;82E31D;      ;
                       LDA.B #$03                           ;82E31F;      ;
                       STA.B $92                            ;82E321;000092;
                       LDA.B #$03                           ;82E323;      ;
                       STA.B $93                            ;82E325;000093;
                       LDA.B #$0F                           ;82E327;      ;
                       STA.B $94                            ;82E329;000094;
                       JSL.L ScreenFadein                         ;82E32B;8087CE;
                       %Set8bit(!M)                             ;82E32F;      ;
                       STZ.B $94                            ;82E331;000094;
                       STZ.B $96                            ;82E333;000096;
                       STZ.B $97                            ;82E335;000097;
                                                            ;      ;      ;
          CODE_82E337: %Set8bit(!M)                             ;82E337;      ;
                       LDA.B !NMI_Status                            ;82E339;000000;
                       BEQ CODE_82E337                      ;82E33B;82E337;
                       %Set16bit(!M)                             ;82E33D;      ;
                       LDA.W #$1800                         ;82E33F;      ;
                       STA.B $C7                            ;82E342;0000C7;
                       JSL.L UNK_BigLoop                    ;82E344;808E69;
                       JSL.L InputTypeSelector                          ;82E348;84C034;
                       %Set8bit(!M)                             ;82E34C;      ;
                       LDA.B $97                            ;82E34E;000097;
                       BNE CODE_82E356                      ;82E350;82E356;
                       JML.L CODE_82E3D1                    ;82E352;82E3D1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E356: STZ.B $97                            ;82E356;000097;
                       LDA.W $098E                          ;82E358;00098E;
                       BEQ CODE_82E361                      ;82E35B;82E361;
                       JML.L CODE_82E39B                    ;82E35D;82E39B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E361: %Set16bit(!M)                             ;82E361;      ;
                       %Set8bit(!X)                             ;82E363;      ;
                       LDA.W #$F2E2                         ;82E365;      ;
                       STA.B $72                            ;82E368;000072;
                       %Set8bit(!M)                             ;82E36A;      ;
                       LDA.B #$82                           ;82E36C;      ;
                       STA.B $74                            ;82E36E;000074;
                       %Set8bit(!M)                             ;82E370;      ;
                       LDA.B #$06                           ;82E372;      ;
                       LDX.B #$04                           ;82E374;      ;
                       LDY.B #$00                           ;82E376;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E378;808E48;
                       %Set16bit(!M)                             ;82E37C;      ;
                       %Set8bit(!X)                             ;82E37E;      ;
                       LDA.W #$F2F9                         ;82E380;      ;
                       STA.B $72                            ;82E383;000072;
                       %Set8bit(!M)                             ;82E385;      ;
                       LDA.B #$82                           ;82E387;      ;
                       STA.B $74                            ;82E389;000074;
                       %Set8bit(!M)                             ;82E38B;      ;
                       LDA.B #$06                           ;82E38D;      ;
                       LDX.B #$05                           ;82E38F;      ;
                       LDY.B #$01                           ;82E391;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E393;808E48;
                       JML.L CODE_82E3D1                    ;82E397;82E3D1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E39B: %Set16bit(!M)                             ;82E39B;      ;
                       %Set8bit(!X)                             ;82E39D;      ;
                       LDA.W #$F2F9                         ;82E39F;      ;
                       STA.B $72                            ;82E3A2;000072;
                       %Set8bit(!M)                             ;82E3A4;      ;
                       LDA.B #$82                           ;82E3A6;      ;
                       STA.B $74                            ;82E3A8;000074;
                       %Set8bit(!M)                             ;82E3AA;      ;
                       LDA.B #$06                           ;82E3AC;      ;
                       LDX.B #$04                           ;82E3AE;      ;
                       LDY.B #$00                           ;82E3B0;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E3B2;808E48;
                       %Set16bit(!M)                             ;82E3B6;      ;
                       %Set8bit(!X)                             ;82E3B8;      ;
                       LDA.W #$F2E2                         ;82E3BA;      ;
                       STA.B $72                            ;82E3BD;000072;
                       %Set8bit(!M)                             ;82E3BF;      ;
                       LDA.B #$82                           ;82E3C1;      ;
                       STA.B $74                            ;82E3C3;000074;
                       %Set8bit(!M)                             ;82E3C5;      ;
                       LDA.B #$06                           ;82E3C7;      ;
                       LDX.B #$05                           ;82E3C9;      ;
                       LDY.B #$01                           ;82E3CB;      ;
                       JSL.L UNK_MemoryWork42_44            ;82E3CD;808E48;
                                                            ;      ;      ;
          CODE_82E3D1: %Set8bit(!M)                             ;82E3D1;      ;
                       LDA.B $96                            ;82E3D3;000096;
                       CMP.B #$01                           ;82E3D5;      ;
                       BNE CODE_82E3E5                      ;82E3D7;82E3E5;
                       STZ.B $96                            ;82E3D9;000096;
                       %Set16bit(!M)                             ;82E3DB;      ;
                       INC.W !BG2_Map_Offset_X                          ;82E3DD;000140;
                       DEC.W !BG2_Map_Offset_Y                          ;82E3E0;000142;
                       BRA CODE_82E3E9                      ;82E3E3;82E3E9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E3E5: %Set8bit(!M)                             ;82E3E5;      ;
                       INC.B $96                            ;82E3E7;000096;
                                                            ;      ;      ;
          CODE_82E3E9: %Set8bit(!M)                             ;82E3E9;      ;
                       LDA.B $94                            ;82E3EB;000094;
                       CMP.B #$01                           ;82E3ED;      ;
                       BNE CODE_82E3F5                      ;82E3EF;82E3F5;
                       JML.L CODE_82DEC5                    ;82E3F1;82DEC5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E3F5: CMP.B #$02                           ;82E3F5;      ;
                       BNE CODE_82E3FD                      ;82E3F7;82E3FD;
                       JML.L CODE_82E7E9                    ;82E3F9;82E7E9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E3FD: %Set8bit(!M)                             ;82E3FD;      ;
                       STZ.B !NMI_Status                            ;82E3FF;000000;
                       JML.L CODE_82E337                    ;82E401;82E337;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E405: %Set16bit(!MX)                             ;82E405;      ;
                       PHA                                  ;82E407;      ;
                       PHY                                  ;82E408;      ;
                       JSL.L LoadGameSlotResume                      ;82E409;83BA45;
                       %Set16bit(!MX)                             ;82E40D;      ;
                       PLY                                  ;82E40F;      ;
                       PLA                                  ;82E410;      ;
                       CPX.W #$0000                         ;82E411;      ;
                       BNE CODE_82E41A                      ;82E414;82E41A;
                       JML.L CODE_82E5E7                    ;82E416;82E5E7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E41A: ASL A                                ;82E41A;      ;
                       ASL A                                ;82E41B;      ;
                       ASL A                                ;82E41C;      ;
                       TAX                                  ;82E41D;      ;
                       LDA.L DATA16_82F278,X                ;82E41E;82F278;
                       PHX                                  ;82E422;      ;
                       STA.B $82                            ;82E423;000082;
                       LDX.W #$0000                         ;82E425;      ;
                                                            ;      ;      ;
          CODE_82E428: %Set16bit(!M)                             ;82E428;      ;
                       PHX                                  ;82E42A;      ;
                       LDA.B $82                            ;82E42B;000082;
                       STA.L $800185                        ;82E42D;800185;
                       %Set8bit(!M)                             ;82E431;      ;
                       LDA.B #$00                           ;82E433;      ;
                       XBA                                  ;82E435;      ;
                       LDA.W !player_name_sort_1,X                        ;82E436;000881;
                       LDX.W #$0000                         ;82E439;      ;
                       JSL.L CODE_839823                    ;82E43C;839823;
                       JSL.L StartProgramedDMA           ;82E440;808AF0;
                       %Set16bit(!MX)                             ;82E444;      ;
                       LDA.B $82                            ;82E446;000082;
                       CLC                                  ;82E448;      ;
                       ADC.W #$0008                         ;82E449;      ;
                       STA.B $82                            ;82E44C;000082;
                       PLX                                  ;82E44E;      ;
                       INX                                  ;82E44F;      ;
                       CPX.W #$0004                         ;82E450;      ;
                       BNE CODE_82E428                      ;82E453;82E428;
                       %Set16bit(!MX)                             ;82E455;      ;
                       PLX                                  ;82E457;      ;
                       INX                                  ;82E458;      ;
                       INX                                  ;82E459;      ;
                       LDA.L DATA16_82F278,X                ;82E45A;82F278;
                       PHX                                  ;82E45E;      ;
                       STA.L $800185                        ;82E45F;800185;
                       %Set8bit(!M)                             ;82E463;      ;
                       LDA.L !year                        ;82E465;7F1F18;
                       INC A                                ;82E469;      ;
                       STA.W $0192                          ;82E46A;000192;
                       %Set16bit(!M)                             ;82E46D;      ;
                       STZ.W $0193                          ;82E46F;000193;
                       %Set8bit(!M)                             ;82E472;      ;
                       LDA.B #$00                           ;82E474;      ;
                       STA.W $018C                          ;82E476;00018C;
                       LDA.W $019B                          ;82E479;00019B;
                       AND.B #$7F                           ;82E47C;      ;
                       STA.W $019B                          ;82E47E;00019B;
                       JSL.L CODE_8397A6                    ;82E481;8397A6;
                       JSL.L StartProgramedDMA           ;82E485;808AF0;
                       %Set16bit(!MX)                             ;82E489;      ;
                       LDA.L $800185                        ;82E48B;800185;
                       CLC                                  ;82E48F;      ;
                       ADC.W #$0008                         ;82E490;      ;
                       STA.L $800185                        ;82E493;800185;
                       %Set16bit(!M)                             ;82E497;      ;
                       LDA.W #$0000                         ;82E499;      ;
                       %Set8bit(!M)                             ;82E49C;      ;
                       LDA.L !year                        ;82E49E;7F1F18;
                       %Set16bit(!M)                             ;82E4A2;      ;
                       ASL A                                ;82E4A4;      ;
                       ASL A                                ;82E4A5;      ;
                       TAX                                  ;82E4A6;      ;
                       LDA.L DATA16_82F298,X                ;82E4A7;82F298;
                       LDX.W #$0000                         ;82E4AB;      ;
                       JSL.L CODE_839823                    ;82E4AE;839823;
                       JSL.L StartProgramedDMA           ;82E4B2;808AF0;
                       %Set16bit(!MX)                             ;82E4B6;      ;
                       LDA.L $800185                        ;82E4B8;800185;
                       CLC                                  ;82E4BC;      ;
                       ADC.W #$0008                         ;82E4BD;      ;
                       STA.L $800185                        ;82E4C0;800185;
                       %Set16bit(!M)                             ;82E4C4;      ;
                       LDA.W #$0000                         ;82E4C6;      ;
                       %Set8bit(!M)                             ;82E4C9;      ;
                       LDA.L !year                        ;82E4CB;7F1F18;
                       %Set16bit(!M)                             ;82E4CF;      ;
                       ASL A                                ;82E4D1;      ;
                       ASL A                                ;82E4D2;      ;
                       CLC                                  ;82E4D3;      ;
                       ADC.W #$0002                         ;82E4D4;      ;
                       TAX                                  ;82E4D7;      ;
                       LDA.L DATA16_82F298,X                ;82E4D8;82F298;
                       LDX.W #$0000                         ;82E4DC;      ;
                       JSL.L CODE_839823                    ;82E4DF;839823;
                       JSL.L StartProgramedDMA           ;82E4E3;808AF0;
                       %Set16bit(!MX)                             ;82E4E7;      ;
                       PLX                                  ;82E4E9;      ;
                       INX                                  ;82E4EA;      ;
                       INX                                  ;82E4EB;      ;
                       LDA.L DATA16_82F278,X                ;82E4EC;82F278;
                       PHX                                  ;82E4F0;      ;
                       STA.L $800185                        ;82E4F1;800185;
                       %Set8bit(!M)                             ;82E4F5;      ;
                       LDA.L !day                        ;82E4F7;7F1F1B;
                       STA.W $0192                          ;82E4FB;000192;
                       %Set16bit(!M)                             ;82E4FE;      ;
                       STZ.W $0193                          ;82E500;000193;
                       %Set8bit(!M)                             ;82E503;      ;
                       LDA.B #$01                           ;82E505;      ;
                       STA.W $018C                          ;82E507;00018C;
                       LDA.W $019B                          ;82E50A;00019B;
                       AND.B #$7F                           ;82E50D;      ;
                       STA.W $019B                          ;82E50F;00019B;
                       JSL.L CODE_8397A6                    ;82E512;8397A6;
                       JSL.L StartProgramedDMA           ;82E516;808AF0;
                       %Set16bit(!MX)                             ;82E51A;      ;
                       PLX                                  ;82E51C;      ;
                       LDA.L DATA16_82F278,X                ;82E51D;82F278;
                       PHX                                  ;82E521;      ;
                       CLC                                  ;82E522;      ;
                       ADC.W #$0008                         ;82E523;      ;
                       STA.L $800185                        ;82E526;800185;
                       %Set8bit(!M)                             ;82E52A;      ;
                       LDA.B #$00                           ;82E52C;      ;
                       STA.W $018C                          ;82E52E;00018C;
                       JSL.L CODE_8397A6                    ;82E531;8397A6;
                       JSL.L StartProgramedDMA           ;82E535;808AF0;
                       %Set16bit(!MX)                             ;82E539;      ;
                       JSL.L LoadsDateNames        ;82E53B;8289D6;
                       %Set16bit(!M)                             ;82E53F;      ;
                       PLX                                  ;82E541;      ;
                       INX                                  ;82E542;      ;
                       INX                                  ;82E543;      ;
                       LDA.L DATA16_82F278,X                ;82E544;82F278;
                       STA.L $800185                        ;82E548;800185;
                       LDA.W $08B3                          ;82E54C;0008B3;
                       LDX.W #$0000                         ;82E54F;      ;
                       JSL.L CODE_839823                    ;82E552;839823;
                       JSL.L StartProgramedDMA           ;82E556;808AF0;
                       %Set16bit(!MX)                             ;82E55A;      ;
                       LDA.L $800185                        ;82E55C;800185;
                       CLC                                  ;82E560;      ;
                       ADC.W #$0008                         ;82E561;      ;
                       STA.L $800185                        ;82E564;800185;
                       LDA.W $08B5                          ;82E568;0008B5;
                       LDX.W #$0000                         ;82E56B;      ;
                       JSL.L CODE_839823                    ;82E56E;839823;
                       JSL.L StartProgramedDMA           ;82E572;808AF0;
                       %Set16bit(!MX)                             ;82E576;      ;
                       LDA.L $800185                        ;82E578;800185;
                       CLC                                  ;82E57C;      ;
                       ADC.W #$0008                         ;82E57D;      ;
                       STA.L $800185                        ;82E580;800185;
                       LDA.W $08B7                          ;82E584;0008B7;
                       LDX.W #$0000                         ;82E587;      ;
                       JSL.L CODE_839823                    ;82E58A;839823;
                       JSL.L StartProgramedDMA           ;82E58E;808AF0;
                       %Set16bit(!MX)                             ;82E592;      ;
                       LDA.L $800185                        ;82E594;800185;
                       CLC                                  ;82E598;      ;
                       ADC.W #$0008                         ;82E599;      ;
                       STA.L $800185                        ;82E59C;800185;
                       LDA.W $08B9                          ;82E5A0;0008B9;
                       LDX.W #$0000                         ;82E5A3;      ;
                       JSL.L CODE_839823                    ;82E5A6;839823;
                       JSL.L StartProgramedDMA           ;82E5AA;808AF0;
                       %Set16bit(!MX)                             ;82E5AE;      ;
                       LDA.L $800185                        ;82E5B0;800185;
                       CLC                                  ;82E5B4;      ;
                       ADC.W #$0008                         ;82E5B5;      ;
                       STA.L $800185                        ;82E5B8;800185;
                       LDA.W $08BB                          ;82E5BC;0008BB;
                       LDX.W #$0000                         ;82E5BF;      ;
                       JSL.L CODE_839823                    ;82E5C2;839823;
                       JSL.L StartProgramedDMA           ;82E5C6;808AF0;
                       %Set16bit(!MX)                             ;82E5CA;      ;
                       LDA.L $800185                        ;82E5CC;800185;
                       CLC                                  ;82E5D0;      ;
                       ADC.W #$0008                         ;82E5D1;      ;
                       STA.L $800185                        ;82E5D4;800185;
                       LDA.W $08BD                          ;82E5D8;0008BD;
                       LDX.W #$0000                         ;82E5DB;      ;
                       JSL.L CODE_839823                    ;82E5DE;839823;
                       JSL.L StartProgramedDMA           ;82E5E2;808AF0;
                       RTS                                  ;82E5E6;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E5E7: %Set16bit(!MX)                             ;82E5E7;      ;
                       ASL A                                ;82E5E9;      ;
                       TAX                                  ;82E5EA;      ;
                       LDA.L DATA8_82E73E,X                 ;82E5EB;82E73E;
                       STA.B $80                            ;82E5EF;000080;
                       STZ.B $82                            ;82E5F1;000082;
                       STY.B $84                            ;82E5F3;000084;
                                                            ;      ;      ;
          CODE_82E5F5: %Set16bit(!MX)                             ;82E5F5;      ;
                       LDA.B $80                            ;82E5F7;000080;
                       TAX                                  ;82E5F9;      ;
                       LDY.W #$0024                         ;82E5FA;      ;
                       STZ.B $7E                            ;82E5FD;00007E;
                       LDA.B $84                            ;82E5FF;000084;
                       BEQ CODE_82E608                      ;82E601;82E608;
                       LDA.W #$006C                         ;82E603;      ;
                       STA.B $7E                            ;82E606;00007E;
                                                            ;      ;      ;
          CODE_82E608: %Set16bit(!MX)                             ;82E608;      ;
                       LDA.W #$0000                         ;82E60A;      ;
                                                            ;      ;      ;
          CODE_82E60D: %Set16bit(!M)                             ;82E60D;      ;
                       PHA                                  ;82E60F;      ;
                       %Set8bit(!M)                             ;82E610;      ;
                       %Set16bit(!X)                             ;82E612;      ;
                       LDA.B #$00                           ;82E614;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82E616;000027;
                       LDA.B #$18                           ;82E618;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82E61A;000029;
                       %Set16bit(!M)                             ;82E61C;      ;
                       LDA.W #$E666                         ;82E61E;      ;
                       CLC                                  ;82E621;      ;
                       ADC.B $7E                            ;82E622;00007E;
                       STA.B $72                            ;82E624;000072;
                       %Set8bit(!M)                             ;82E626;      ;
                       LDA.B #$82                           ;82E628;      ;
                       STA.B $74                            ;82E62A;000074;
                       LDA.B #$80                           ;82E62C;      ;
                       PHY                                  ;82E62E;      ;
                       PHX                                  ;82E62F;      ;
                       JSL.L AddProgrammedDMA                ;82E630;808A33;
                       JSL.L StartLastPreparedDMA               ;82E634;808AB2;
                       %Set16bit(!MX)                             ;82E638;      ;
                       PLX                                  ;82E63A;      ;
                       PLY                                  ;82E63B;      ;
                       TXA                                  ;82E63C;      ;
                       CLC                                  ;82E63D;      ;
                       ADC.W #$0020                         ;82E63E;      ;
                       TAX                                  ;82E641;      ;
                       LDA.B $7E                            ;82E642;00007E;
                       CLC                                  ;82E644;      ;
                       ADC.W #$0024                         ;82E645;      ;
                       STA.B $7E                            ;82E648;00007E;
                       PLA                                  ;82E64A;      ;
                       INC A                                ;82E64B;      ;
                       CMP.W #$0003                         ;82E64C;      ;
                       BNE CODE_82E60D                      ;82E64F;82E60D;
                       %Set16bit(!M)                             ;82E651;      ;
                       LDA.B $80                            ;82E653;000080;
                       CLC                                  ;82E655;      ;
                       ADC.W #$0400                         ;82E656;      ;
                       STA.B $80                            ;82E659;000080;
                       LDA.B $82                            ;82E65B;000082;
                       INC A                                ;82E65D;      ;
                       STA.B $82                            ;82E65E;000082;
                       CMP.W #$0002                         ;82E660;      ;
                       BNE CODE_82E5F5                      ;82E663;82E5F5;
                       RTS                                  ;82E665;      ;
                                                            ;      ;      ;
                       dw $02FF,$02FF,$002C,$006E,$00C2,$02FF,$0008,$0086;82E666;      ;
                       dw $0066,$00A8,$00C6,$02FF,$02FF,$02FF,$02FF,$02FF;82E676;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$003C,$007E,$00D2,$02FF;82E686;      ;
                       dw $0018,$0096,$0076,$00B8,$00D6,$02FF,$02FF,$02FF;82E696;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E6A6;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E6B6;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E6C6;      ;
                       dw $002C,$00A2,$02FF,$0008,$0086,$0066,$00A8,$00C6;82E6D6;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E6E6;      ;
                       dw $02FF,$02FF,$003C,$00B2,$02FF,$0018,$0096,$0076;82E6F6;      ;
                       dw $00B8,$00D6,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E706;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E716;      ;
                       dw $02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF,$02FF;82E726;      ;
                       dw $02FF,$02FF,$02FF,$02FF           ;82E736;      ;
                                                            ;      ;      ;
         DATA8_82E73E: db $E8,$10,$28,$12                   ;82E73E;      ;
                                                            ;      ;      ;
          CODE_82E742: %Set16bit(!MX)                             ;82E742;      ;
                       LDX.W #$0000                         ;82E744;      ;
                                                            ;      ;      ;
          CODE_82E747: %Set16bit(!M)                             ;82E747;      ;
                       LDA.L DATA16_82F268,X                ;82E749;82F268;
                       STA.B $7E                            ;82E74D;00007E;
                       INC A                                ;82E74F;      ;
                       STA.B $80                            ;82E750;000080;
                       CLC                                  ;82E752;      ;
                       ADC.W #$000F                         ;82E753;      ;
                       STA.B $82                            ;82E756;000082;
                       INC A                                ;82E758;      ;
                       STA.B $84                            ;82E759;000084;
                       LDA.L DATA16_82F258,X                ;82E75B;82F258;
                       STA.B $86                            ;82E75F;000086;
                       LDY.W #$0000                         ;82E761;      ;
                                                            ;      ;      ;
          CODE_82E764: PHY                                  ;82E764;      ;
                       PHX                                  ;82E765;      ;
                       %Set8bit(!M)                             ;82E766;      ;
                       LDA.B #$00                           ;82E768;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82E76A;000027;
                       LDA.B #$18                           ;82E76C;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82E76E;000029;
                       %Set16bit(!MX)                             ;82E770;      ;
                       LDY.W #$0004                         ;82E772;      ;
                       LDX.B $86                            ;82E775;000086;
                       LDA.W #$007E                         ;82E777;      ;
                       STA.B $72                            ;82E77A;000072;
                       %Set8bit(!M)                             ;82E77C;      ;
                       LDA.B #$80                           ;82E77E;      ;
                       STA.B $74                            ;82E780;000074;
                       %Set16bit(!M)                             ;82E782;      ;
                       LDA.W #$0080                         ;82E784;      ;
                       JSL.L AddProgrammedDMA                ;82E787;808A33;
                       %Set8bit(!M)                             ;82E78B;      ;
                       LDA.B #$01                           ;82E78D;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82E78F;000027;
                       LDA.B #$18                           ;82E791;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82E793;000029;
                       %Set16bit(!MX)                             ;82E795;      ;
                       LDY.W #$0004                         ;82E797;      ;
                       LDX.B $86                            ;82E79A;000086;
                       TXA                                  ;82E79C;      ;
                       CLC                                  ;82E79D;      ;
                       ADC.W #$0020                         ;82E79E;      ;
                       TAX                                  ;82E7A1;      ;
                       LDA.W #$0082                         ;82E7A2;      ;
                       STA.B $72                            ;82E7A5;000072;
                       %Set8bit(!M)                             ;82E7A7;      ;
                       LDA.B #$80                           ;82E7A9;      ;
                       STA.B $74                            ;82E7AB;000074;
                       %Set16bit(!M)                             ;82E7AD;      ;
                       LDA.W #$0080                         ;82E7AF;      ;
                       JSL.L AddProgrammedDMA                ;82E7B2;808A33;
                       JSL.L StartProgramedDMA           ;82E7B6;808AF0;
                       %Set16bit(!MX)                             ;82E7BA;      ;
                       INC.B $7E                            ;82E7BC;00007E;
                       INC.B $7E                            ;82E7BE;00007E;
                       INC.B $80                            ;82E7C0;000080;
                       INC.B $80                            ;82E7C2;000080;
                       INC.B $82                            ;82E7C4;000082;
                       INC.B $82                            ;82E7C6;000082;
                       INC.B $84                            ;82E7C8;000084;
                       INC.B $84                            ;82E7CA;000084;
                       INC.B $86                            ;82E7CC;000086;
                       INC.B $86                            ;82E7CE;000086;
                       PLX                                  ;82E7D0;      ;
                       PLY                                  ;82E7D1;      ;
                       INY                                  ;82E7D2;      ;
                       LDA.L DATA16_82F288,X                ;82E7D3;82F288;
                       STA.B $88                            ;82E7D7;000088;
                       CPY.B $88                            ;82E7D9;000088;
                       BNE CODE_82E764                      ;82E7DB;82E764;
                       INX                                  ;82E7DD;      ;
                       INX                                  ;82E7DE;      ;
                       CPX.W #$0010                         ;82E7DF;      ;
                       BEQ CODE_82E7E8                      ;82E7E2;82E7E8;
                       JML.L CODE_82E747                    ;82E7E4;82E747;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E7E8: RTS                                  ;82E7E8;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E7E9: %Set8bit(!M)                             ;82E7E9;      ;
                       LDA.B #$00                           ;82E7EB;      ;
                       XBA                                  ;82E7ED;      ;
                       LDA.W $098E                          ;82E7EE;00098E;
                       JSL.L LoadGameSlot                    ;82E7F1;83B2B1;
                       JML.L UNK_RealMainLoop                  ;82E7F5;808000;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E7F9: JSL.L NewGameSetup             ;82E7F9;83A9BE;
                       JML.L UNK_RealMainLoop                  ;82E7FD;808000;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;82E801;      ;
                       LDA.B #$00                           ;82E803;      ;
                       STA.W $099F                          ;82E805;00099F;
                       JML.L CODE_82E80C                    ;82E808;82E80C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E80C: %Set8bit(!M)                             ;82E80C;      ;
                       LDA.B #$5F                           ;82E80E;      ;
                       STA.B !tilemap_to_load                            ;82E810;000022;
                       JSL.L UNK_Audio5;82E812;8095DE;
                       JSL.L UNK_Audio25                    ;82E816;838401;
                       %Set8bit(!M)                             ;82E81A;      ;
                       LDA.B #$0F                           ;82E81C;      ;
                       STA.B $92                            ;82E81E;000092;
                       LDA.B #$03                           ;82E820;      ;
                       STA.B $93                            ;82E822;000093;
                       LDA.B #$01                           ;82E824;      ;
                       STA.B $94                            ;82E826;000094;
                       JSL.L ScreenFadeout                  ;82E828;80880A;
                       JSL.L ForceBlank                     ;82E82C;808E0F;
                       JSL.L ZeroesVRAM                      ;82E830;808846;
                       JSL.L ClearMemoryPointers2           ;82E834;808FAB;
                       JSL.L ClearWRAMGraphicsSpace         ;82E838;858ED7;
                       JSL.L InitializeOBJs         ;82E83C;85820F;
                       %Set16bit(!M)                             ;82E840;      ;
                       LDA.W $0196                          ;82E842;000196;
                       STA.W $0198                          ;82E845;000198;
                       STZ.W $0196                          ;82E848;000196;
                       STZ.W $0905                          ;82E84B;000905;
                       %Set8bit(!M)                             ;82E84E;      ;
                       LDA.B #$05                           ;82E850;      ;
                       STA.W !inputstate                          ;82E852;00019A;
                       %Set8bit(!M)                             ;82E855;      ;
                       LDA.B #$04                           ;82E857;      ;
                       JSL.L ManageGraphicPresets             ;82E859;808C59;
                       JSL.L TilemapManager           ;82E85D;80A7C6;
                       %Set16bit(!M)                             ;82E861;      ;
                       LDA.W #$006F                         ;82E863;      ;
                       JSL.L LoadCGRAM                ;82E866;8091CF;
                       %Set8bit(!M)                             ;82E86A;      ;
                       %Set16bit(!X)                             ;82E86C;      ;
                       LDA.B #$00                           ;82E86E;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82E870;000027;
                       LDA.B #$22                           ;82E872;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82E874;000029;
                       %Set16bit(!M)                             ;82E876;      ;
                       LDY.W #$0100                         ;82E878;      ;
                       LDX.W #$0000                         ;82E87B;      ;
                       LDA.W #$8C00                         ;82E87E;      ;
                       STA.B $72                            ;82E881;000072;
                       %Set8bit(!M)                             ;82E883;      ;
                       LDA.B #$A9                           ;82E885;      ;
                       STA.B $74                            ;82E887;000074;
                       JSL.L AddProgrammedDMA                ;82E889;808A33;
                       %Set8bit(!M)                             ;82E88D;      ;
                       %Set16bit(!X)                             ;82E88F;      ;
                       LDA.B #$01                           ;82E891;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82E893;000027;
                       LDA.B #$22                           ;82E895;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82E897;000029;
                       %Set16bit(!M)                             ;82E899;      ;
                       LDY.W #$0100                         ;82E89B;      ;
                       LDX.W #$0080                         ;82E89E;      ;
                       LDA.W #$DE00                         ;82E8A1;      ;
                       STA.B $72                            ;82E8A4;000072;
                       %Set8bit(!M)                             ;82E8A6;      ;
                       LDA.B #$A9                           ;82E8A8;      ;
                       STA.B $74                            ;82E8AA;000074;
                       JSL.L AddProgrammedDMA                ;82E8AC;808A33;
                       JSL.L StartProgramedDMA           ;82E8B0;808AF0;
                       JSL.L PresetsMemory3                 ;82E8B4;81A4C7;
                       %Set16bit(!M)                             ;82E8B8;      ;
                       LDA.W #$0219                         ;82E8BA;      ;
                       STA.B $A1                            ;82E8BD;0000A1;
                       STA.W $0997                          ;82E8BF;000997;
                       LDA.W #$0000                         ;82E8C2;      ;
                       STA.B $9F                            ;82E8C5;00009F;
                       STA.W $0999                          ;82E8C7;000999;
                       LDA.W #$0028                         ;82E8CA;      ;
                       STA.B $9B                            ;82E8CD;00009B;
                       STA.W $099B                          ;82E8CF;00099B;
                       LDA.W #$0044                         ;82E8D2;      ;
                       STA.B $9D                            ;82E8D5;00009D;
                       STA.W $099D                          ;82E8D7;00099D;
                       STZ.B $A3                            ;82E8DA;0000A3;
                       JSL.L CODE_858000                    ;82E8DC;858000;
                       %Set16bit(!M)                             ;82E8E0;      ;
                       LDA.B $A5                            ;82E8E2;0000A5;
                       STA.W $0995                          ;82E8E4;000995;
                       JSL.L CODE_82EAB4                    ;82E8E7;82EAB4;
                       JSL.L CODE_82EA80                    ;82E8EB;82EA80;
                       %Set16bit(!M)                             ;82E8EF;      ;
                       STZ.W !BG1_Map_Offset_X                          ;82E8F1;00013C;
                       STZ.W !BG1_Map_Offset_Y                          ;82E8F4;00013E;
                       STZ.W !BG2_Map_Offset_X                          ;82E8F7;000140;
                       STZ.W !BG2_Map_Offset_Y                          ;82E8FA;000142;
                       STZ.W !BG3_Map_Offset_X                          ;82E8FD;000144;
                       STZ.W !BG3_Map_Offset_Y                          ;82E900;000146;
                       JSL.L UNK_Audio21                    ;82E903;83841F;
                       JSL.L UNK_Audio20                    ;82E907;8383A4;
                       JSL.L UNK_Audio22                    ;82E90B;838380;
                       %Set8bit(!M)                             ;82E90F;      ;
                       LDA.W $0110                          ;82E911;000110;
                       STA.W $0117                          ;82E914;000117;
                       JSL.L ResetForceBlank                ;82E917;808E1E;
                       JSL.L WaitForNMI               ;82E91B;808645;
                       %Set8bit(!M)                             ;82E91F;      ;
                       LDA.B #$03                           ;82E921;      ;
                       STA.B $92                            ;82E923;000092;
                       LDA.B #$03                           ;82E925;      ;
                       STA.B $93                            ;82E927;000093;
                       LDA.B #$0F                           ;82E929;      ;
                       STA.B $94                            ;82E92B;000094;
                       JSL.L ScreenFadein                         ;82E92D;8087CE;
                       %Set16bit(!M)                             ;82E931;      ;
                       STZ.W !menu_pos                          ;82E933;000991;
                       %Set8bit(!M)                             ;82E936;      ;
                       LDA.B #$00                           ;82E938;      ;
                       STA.W $0993                          ;82E93A;000993;
                       STZ.W !name_entry_index                          ;82E93D;000994;
                       STZ.W $018B                          ;82E940;00018B;
                       %Set8bit(!M)                             ;82E943;      ;
                       LDA.B #$B1                           ;82E945;      ;
                       STA.W !temp_name_1                           ;82E947;000885;
                       LDA.B #$B1                           ;82E94A;      ;
                       STA.W !temp_name_2                          ;82E94C;000886;
                       LDA.B #$B1                           ;82E94F;      ;
                       STA.W !temp_name_3                          ;82E951;000887;
                       LDA.B #$B1                           ;82E954;      ;
                       STA.W !temp_name_4                          ;82E956;000888;
                       STZ.B $94                            ;82E959;000094;
                       STZ.B $96                            ;82E95B;000096;
                       STZ.B $97                            ;82E95D;000097;
                                                            ;      ;      ;
          CODE_82E95F: %Set8bit(!M)                             ;82E95F;      ;
                       LDA.B !NMI_Status                            ;82E961;000000;
                       BEQ CODE_82E95F                      ;82E963;82E95F;
                       %Set16bit(!M)                             ;82E965;      ;
                       LDA.W #$1800                         ;82E967;      ;
                       STA.B $C7                            ;82E96A;0000C7;
                       JSR.W CODE_82EA15                    ;82E96C;82EA15;
                       JSL.L InputTypeSelector                          ;82E96F;84C034;
                       %Set8bit(!M)                             ;82E973;      ;
                       LDA.W $0993                          ;82E975;000993;
                       CMP.B #$03                           ;82E978;      ;
                       BNE CODE_82E97F                      ;82E97A;82E97F;
                       JMP.W CODE_82E9CE                    ;82E97C;82E9CE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E97F: JSL.L CODE_82EB57                    ;82E97F;82EB57;
                       %Set8bit(!M)                             ;82E983;      ;
                       LDA.B $96                            ;82E985;000096;
                       CMP.B #$01                           ;82E987;      ;
                       BNE CODE_82E997                      ;82E989;82E997;
                       STZ.B $96                            ;82E98B;000096;
                       %Set16bit(!M)                             ;82E98D;      ;
                       INC.W !BG2_Map_Offset_X                          ;82E98F;000140;
                       DEC.W !BG2_Map_Offset_Y                          ;82E992;000142;
                       BRA CODE_82E99B                      ;82E995;82E99B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E997: %Set8bit(!M)                             ;82E997;      ;
                       INC.B $96                            ;82E999;000096;
                                                            ;      ;      ;
          CODE_82E99B: %Set16bit(!M)                             ;82E99B;      ;
                       LDA.W $0997                          ;82E99D;000997;
                       STA.B $A1                            ;82E9A0;0000A1;
                       LDA.W $0999                          ;82E9A2;000999;
                       STA.B $9F                            ;82E9A5;00009F;
                       LDA.W $099B                          ;82E9A7;00099B;
                       STA.B $9B                            ;82E9AA;00009B;
                       LDA.W $099D                          ;82E9AC;00099D;
                       STA.B $9D                            ;82E9AF;00009D;
                       LDA.W $0995                          ;82E9B1;000995;
                       STA.B $A5                            ;82E9B4;0000A5;
                       JSL.L CODE_8580B9                    ;82E9B6;8580B9;
                       JSL.L CODE_8582C7                    ;82E9BA;8582C7;
                       JSL.L CODE_858CB2                    ;82E9BE;858CB2;
                       JSL.L UNK_BigLoadLoopOAM             ;82E9C2;8583E0;
                       %Set8bit(!M)                             ;82E9C6;      ;
                       STZ.B !NMI_Status                            ;82E9C8;000000;
                       JML.L CODE_82E95F                    ;82E9CA;82E95F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E9CE: %Set16bit(!M)                             ;82E9CE;      ;
                       LDA.W $0198                          ;82E9D0;000198;
                       STA.W $0196                          ;82E9D3;000196;
                       %Set8bit(!M)                             ;82E9D6;      ;
                       LDA.W $099F                          ;82E9D8;00099F;
                       CMP.B #$00                           ;82E9DB;      ;
                       BNE CODE_82E9E3                      ;82E9DD;82E9E3;
                       JML.L SetPlayerName                    ;82E9DF;8080ED;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E9E3: CMP.B #$01                           ;82E9E3;      ;
                       BNE CODE_82E9EB                      ;82E9E5;82E9EB;
                       JML.L SetCowName                    ;82E9E7;80815F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E9EB: CMP.B #$02                           ;82E9EB;      ;
                       BNE CODE_82E9F3                      ;82E9ED;82E9F3;
                       JML.L SetCowName2               ;82E9EF;8081D2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E9F3: CMP.B #$03                           ;82E9F3;      ;
                       BNE CODE_82E9FB                      ;82E9F5;82E9FB;
                       JML.L SetDogName            ;82E9F7;808254;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82E9FB: CMP.B #$04                           ;82E9FB;      ;
                       BNE CODE_82EA03                      ;82E9FD;82EA03;
                       JML.L SetHorseName           ;82E9FF;8082C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EA03: CMP.B #$05                           ;82EA03;      ;
                       BNE CODE_82EA0B                      ;82EA05;82EA0B;
                       JML.L SetKid1Name                  ;82EA07;808338;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EA0B: CMP.B #$06                           ;82EA0B;      ;
                       BNE CODE_82EA13                      ;82EA0D;82EA13;
                       JML.L SetKid2Name                  ;82EA0F;8083AE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EA13: BRA CODE_82E9CE                      ;82EA13;82E9CE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EA15: %Set8bit(!M)                             ;82EA15;      ;
                       %Set16bit(!X)                             ;82EA17;      ;
                       LDA.W !name_entry_index                          ;82EA19;000994;
                       CMP.B #$04                           ;82EA1C;      ;
                       BEQ CODE_82EA5F                      ;82EA1E;82EA5F;
                       %Set16bit(!M)                             ;82EA20;      ;
                       LDA.W $018B                          ;82EA22;00018B;
                       AND.W #$007F                         ;82EA25;      ;
                       CMP.W #$0014                         ;82EA28;      ;
                       BNE CODE_82EA39                      ;82EA2B;82EA39;
                       %Set8bit(!M)                             ;82EA2D;      ;
                       LDA.W $018B                          ;82EA2F;00018B;
                       AND.B #$80                           ;82EA32;      ;
                       EOR.B #$80                           ;82EA34;      ;
                       STA.W $018B                          ;82EA36;00018B;
                                                            ;      ;      ;
          CODE_82EA39: %Set8bit(!M)                             ;82EA39;      ;
                       LDA.W $018B                          ;82EA3B;00018B;
                       AND.B #$80                           ;82EA3E;      ;
                       BNE CODE_82EA4D                      ;82EA40;82EA4D;
                       %Set16bit(!M)                             ;82EA42;      ;
                       LDA.W #$00A8                         ;82EA44;      ;
                       JSL.L Unk_OutOfMenu                    ;82EA47;82EA60;
                       BRA CODE_82EA56                      ;82EA4B;82EA56;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EA4D: %Set16bit(!M)                             ;82EA4D;      ;
                       LDA.W #$00B1                         ;82EA4F;      ;
                       JSL.L Unk_OutOfMenu                    ;82EA52;82EA60;
                                                            ;      ;      ;
          CODE_82EA56: %Set8bit(!M)                             ;82EA56;      ;
                       LDA.W $018B                          ;82EA58;00018B;
                       INC A                                ;82EA5B;      ;
                       STA.W $018B                          ;82EA5C;00018B;
                                                            ;      ;      ;
          CODE_82EA5F: RTS                                  ;82EA5F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          Unk_OutOfMenu: %Set16bit(!M)                             ;82EA60;      ;
                       PHA                                  ;82EA62;      ;
                       %Set8bit(!M)                             ;82EA63;      ;
                       LDA.B #$00                           ;82EA65;      ;
                       XBA                                  ;82EA67;      ;
                       LDA.W !name_entry_index                          ;82EA68;000994;
                       %Set16bit(!M)                             ;82EA6B;      ;
                       ASL A                                ;82EA6D;      ;
                       TAX                                  ;82EA6E;      ;
                       LDA.L DATA16_82EB4D,X                ;82EA6F;82EB4D;
                       STA.L $800185                        ;82EA73;800185;
                       PLA                                  ;82EA77;      ;
                       LDX.W #$0001                         ;82EA78;      ;
                       JSL.L CODE_839823                    ;82EA7B;839823;
                       RTL                                  ;82EA7F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EA80: %Set16bit(!M)                             ;82EA80;      ;
                       LDA.L DATA16_82EB4D                  ;82EA82;82EB4D;
                       STA.B $82                            ;82EA86;000082;
                       LDX.W #$0000                         ;82EA88;      ;
                                                            ;      ;      ;
          CODE_82EA8B: %Set16bit(!M)                             ;82EA8B;      ;
                       PHX                                  ;82EA8D;      ;
                       LDA.B $82                            ;82EA8E;000082;
                       STA.L $800185                        ;82EA90;800185;
                       LDA.W #$00A8                         ;82EA94;      ;
                       LDX.W #$0001                         ;82EA97;      ;
                       JSL.L CODE_839823                    ;82EA9A;839823;
                       JSL.L StartProgramedDMA           ;82EA9E;808AF0;
                       %Set16bit(!MX)                             ;82EAA2;      ;
                       LDA.B $82                            ;82EAA4;000082;
                       CLC                                  ;82EAA6;      ;
                       ADC.W #$0010                         ;82EAA7;      ;
                       STA.B $82                            ;82EAAA;000082;
                       PLX                                  ;82EAAC;      ;
                       INX                                  ;82EAAD;      ;
                       CPX.W #$0004                         ;82EAAE;      ;
                       BNE CODE_82EA8B                      ;82EAB1;82EA8B;
                       RTL                                  ;82EAB3;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EAB4: %Set16bit(!MX)                             ;82EAB4;      ;
                       LDA.L DATA16_82EB4B                  ;82EAB6;82EB4B;
                       STA.B $7E                            ;82EABA;00007E;
                       INC A                                ;82EABC;      ;
                       STA.B $80                            ;82EABD;000080;
                       CLC                                  ;82EABF;      ;
                       ADC.W #$000F                         ;82EAC0;      ;
                       STA.B $82                            ;82EAC3;000082;
                       INC A                                ;82EAC5;      ;
                       STA.B $84                            ;82EAC6;000084;
                       LDA.L DATA16_82EB49                  ;82EAC8;82EB49;
                       STA.B $86                            ;82EACC;000086;
                       LDY.W #$0000                         ;82EACE;      ;
                                                            ;      ;      ;
          CODE_82EAD1: PHY                                  ;82EAD1;      ;
                       %Set8bit(!M)                             ;82EAD2;      ;
                       LDA.B #$00                           ;82EAD4;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82EAD6;000027;
                       LDA.B #$18                           ;82EAD8;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82EADA;000029;
                       %Set16bit(!MX)                             ;82EADC;      ;
                       LDY.W #$0004                         ;82EADE;      ;
                       LDX.B $86                            ;82EAE1;000086;
                       LDA.W #$007E                         ;82EAE3;      ;
                       STA.B $72                            ;82EAE6;000072;
                       %Set8bit(!M)                             ;82EAE8;      ;
                       LDA.B #$80                           ;82EAEA;      ;
                       STA.B $74                            ;82EAEC;000074;
                       %Set16bit(!M)                             ;82EAEE;      ;
                       LDA.W #$0080                         ;82EAF0;      ;
                       JSL.L AddProgrammedDMA                ;82EAF3;808A33;
                       %Set8bit(!M)                             ;82EAF7;      ;
                       LDA.B #$01                           ;82EAF9;      ;
                       STA.B !ProgDMA_Channel_Index                            ;82EAFB;000027;
                       LDA.B #$18                           ;82EAFD;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;82EAFF;000029;
                       %Set16bit(!MX)                             ;82EB01;      ;
                       LDY.W #$0004                         ;82EB03;      ;
                       LDX.B $86                            ;82EB06;000086;
                       TXA                                  ;82EB08;      ;
                       CLC                                  ;82EB09;      ;
                       ADC.W #$0020                         ;82EB0A;      ;
                       TAX                                  ;82EB0D;      ;
                       LDA.W #$0082                         ;82EB0E;      ;
                       STA.B $72                            ;82EB11;000072;
                       %Set8bit(!M)                             ;82EB13;      ;
                       LDA.B #$80                           ;82EB15;      ;
                       STA.B $74                            ;82EB17;000074;
                       %Set16bit(!M)                             ;82EB19;      ;
                       LDA.W #$0080                         ;82EB1B;      ;
                       JSL.L AddProgrammedDMA                ;82EB1E;808A33;
                       JSL.L StartProgramedDMA           ;82EB22;808AF0;
                       %Set16bit(!MX)                             ;82EB26;      ;
                       INC.B $7E                            ;82EB28;00007E;
                       INC.B $7E                            ;82EB2A;00007E;
                       INC.B $80                            ;82EB2C;000080;
                       INC.B $80                            ;82EB2E;000080;
                       INC.B $82                            ;82EB30;000082;
                       INC.B $82                            ;82EB32;000082;
                       INC.B $84                            ;82EB34;000084;
                       INC.B $84                            ;82EB36;000084;
                       INC.B $86                            ;82EB38;000086;
                       INC.B $86                            ;82EB3A;000086;
                       PLY                                  ;82EB3C;      ;
                       INY                                  ;82EB3D;      ;
                       LDA.L DATA16_82EB55                  ;82EB3E;82EB55;
                       STA.B $88                            ;82EB42;000088;
                       CPY.B $88                            ;82EB44;000088;
                       BNE CODE_82EAD1                      ;82EB46;82EAD1;
                       RTS                                  ;82EB48;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
        DATA16_82EB49: dw $788C                             ;82EB49;      ;
                                                            ;      ;      ;
        DATA16_82EB4B: dw $2002                             ;82EB4B;      ;
                                                            ;      ;      ;
        DATA16_82EB4D: dw $5010,$5020,$5030,$5040           ;82EB4D;      ;
                                                            ;      ;      ;
        DATA16_82EB55: dw $0004                             ;82EB55;      ;
                                                            ;      ;      ;
          CODE_82EB57: %Set16bit(!MX)                             ;82EB57;      ;
                       LDA.W #$EBF8                         ;82EB59;      ;
                       STA.B $72                            ;82EB5C;000072;
                       %Set8bit(!M)                             ;82EB5E;      ;
                       LDA.B #$82                           ;82EB60;      ;
                       STA.B $74                            ;82EB62;000074;
                       LDA.W $0993                          ;82EB64;000993;
                       BEQ CODE_82EB89                      ;82EB67;82EB89;
                       CMP.B #$01                           ;82EB69;      ;
                       BEQ CODE_82EB7C                      ;82EB6B;82EB7C;
                       %Set16bit(!M)                             ;82EB6D;      ;
                       LDA.W #$F0D0                         ;82EB6F;      ;
                       STA.B $72                            ;82EB72;000072;
                       %Set8bit(!M)                             ;82EB74;      ;
                       LDA.B #$82                           ;82EB76;      ;
                       STA.B $74                            ;82EB78;000074;
                       BRA CODE_82EB89                      ;82EB7A;82EB89;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_82EB7C: %Set16bit(!M)                             ;82EB7C;      ;
                       LDA.W #$EE30                         ;82EB7E;      ;
                       STA.B $72                            ;82EB81;000072;
                       %Set8bit(!M)                             ;82EB83;      ;
                       LDA.B #$82                           ;82EB85;      ;
                       STA.B $74                            ;82EB87;000074;
                                                            ;      ;      ;
          CODE_82EB89: %Set16bit(!M)                             ;82EB89;      ;
                       LDA.W !menu_pos                          ;82EB8B;000991;
                       ASL A                                ;82EB8E;      ;
                       ASL A                                ;82EB8F;      ;
                       ASL A                                ;82EB90;      ;
                       TAY                                  ;82EB91;      ;
                       %Set8bit(!M)                             ;82EB92;      ;
                       LDA.B #$00                           ;82EB94;      ;
                       XBA                                  ;82EB96;      ;
                       LDA.B [$72],Y                        ;82EB97;000072;
                       %Set16bit(!M)                             ;82EB99;      ;
                       STA.W $099B                          ;82EB9B;00099B;
                       INY                                  ;82EB9E;      ;
                       %Set8bit(!M)                             ;82EB9F;      ;
                       LDA.B #$00                           ;82EBA1;      ;
                       XBA                                  ;82EBA3;      ;
                       LDA.B [$72],Y                        ;82EBA4;000072;
                       %Set16bit(!M)                             ;82EBA6;      ;
                       STA.W $099D                          ;82EBA8;00099D;
                       RTL                                  ;82EBAB;      ;

;;;;;;;Param in A, what key was pressed
UNK_CursorPharse: ;82EBAC
       %Set16bit(!MX)
       PHA
       LDA.W #$EBF8
       STA.B $72
       %Set8bit(!M)
       LDA.B #$82
       STA.B $74                            ;prepares a pointer???
       LDA.W $0993
       BEQ .skip1                      ;82EBBD;82EBDF;

       CMP.B #$01                           ;82EBBF;      ;
       BEQ .skip2                      ;82EBC1;82EBD2;
       %Set16bit(!M)                             ;82EBC3;      ;
       LDA.W #$F0D0                         ;82EBC5;      ;
       STA.B $72                            ;82EBC8;000072;
       %Set8bit(!M)                             ;82EBCA;      ;
       LDA.B #$82                           ;82EBCC;      ;
       STA.B $74                            ;82EBCE;000074;
       BRA .skip1                      ;82EBD0;82EBDF;
                                          ;      ;      ;
                                          ;      ;      ;
    .skip2:
       %Set16bit(!M)                             ;82EBD2;      ;
       LDA.W #$EE30                         ;82EBD4;      ;
       STA.B $72                            ;82EBD7;000072;
       %Set8bit(!M)                             ;82EBD9;      ;
       LDA.B #$82                           ;82EBDB;      ;
       STA.B $74                            ;82EBDD;000074;
                                          ;      ;      ;
    .skip1:
       %Set16bit(!M)                             ;82EBDF;      ;
       PLA                                  ;82EBE1;      ;
       INC A                                ;82EBE2;      ;
       INC A                                ;82EBE3;      ;
       STA.B $7E                            ;82EBE4;00007E;
       LDA.W !menu_pos                          ;82EBE6;000991;
       ASL A                                ;82EBE9;      ;
       ASL A                                ;82EBEA;      ;
       ASL A                                ;82EBEB;      ;
       CLC                                  ;82EBEC;      ;
       ADC.B $7E                            ;82EBED;00007E;
       TAY                                  ;82EBEF;      ;
       %Set8bit(!M)                             ;82EBF0;      ;
       LDA.B #$00                           ;82EBF2;      ;
       XBA                                  ;82EBF4;      ;
       LDA.B [$72],Y                        ;82EBF5;000072;
       RTL                                  ;82EBF7;      ;

NameGridPositions:     db $28,$44,$05,$1F,$01,$28,$1A,$00,$38,$44,$06,$20,$02,$00,$1B,$00;82EBF8;      ;
                       db $48,$44,$07,$21,$03,$01,$1C,$00,$58,$44,$08,$22,$04,$02,$1D,$00;82EC08;      ;
                       db $68,$44,$09,$23,$24,$03,$1E,$00,$28,$54,$0A,$00,$06,$2D,$1F,$00;82EC18;      ;
                       db $38,$54,$0B,$01,$07,$05,$20,$00,$48,$54,$0C,$02,$08,$06,$21,$00;82EC28;      ;
                       db $58,$54,$0D,$03,$09,$07,$22,$00,$68,$54,$0E,$04,$29,$08,$23,$00;82EC38;      ;
                       db $28,$64,$0F,$05,$0B,$32,$24,$00,$38,$64,$10,$06,$0C,$0A,$25,$00;82EC48;      ;
                       db $48,$64,$11,$07,$0D,$0B,$26,$00,$58,$64,$12,$08,$0E,$0C,$27,$00;82EC58;      ;
                       db $68,$64,$13,$09,$2E,$0D,$28,$00,$28,$74,$14,$0A,$10,$37,$29,$00;82EC68;      ;
                       db $38,$74,$15,$0B,$11,$0F,$2A,$00,$48,$74,$16,$0C,$12,$10,$2B,$00;82EC78;      ;
                       db $58,$74,$17,$0D,$13,$11,$2C,$00,$68,$74,$18,$0E,$33,$12,$2D,$00;82EC88;      ;
                       db $28,$84,$19,$0F,$15,$3C,$2E,$00,$38,$84,$19,$10,$16,$14,$2F,$00;82EC98;      ;
                       db $48,$84,$19,$11,$17,$15,$30,$00,$58,$84,$19,$12,$18,$16,$31,$00;82ECA8;      ;
                       db $68,$84,$19,$13,$38,$17,$32,$00,$28,$94,$1A,$14,$3D,$3D,$33,$00;82ECB8;      ;
                       db $28,$A4,$1F,$19,$1B,$42,$B2,$00,$38,$A4,$20,$19,$1C,$1A,$B3,$00;82ECC8;      ;
                       db $48,$A4,$21,$19,$1D,$1B,$B4,$00,$58,$A4,$22,$19,$1E,$1C,$B5,$00;82ECD8;      ;
                       db $68,$A4,$23,$19,$3E,$1D,$B6,$00,$28,$B4,$00,$1A,$20,$45,$B7,$00;82ECE8;      ;
                       db $38,$B4,$01,$1B,$21,$1F,$B8,$00,$48,$B4,$02,$1C,$22,$20,$B9,$00;82ECF8;      ;
                       db $58,$B4,$03,$1D,$23,$21,$BA,$00,$68,$B4,$04,$1E,$43,$22,$BB,$00;82ED08;      ;
                       db $88,$44,$29,$46,$25,$04,$00,$00,$98,$44,$2A,$46,$26,$24,$01,$00;82ED18;      ;
                       db $A8,$44,$2B,$46,$27,$25,$02,$00,$B8,$44,$2C,$46,$28,$26,$03,$00;82ED28;      ;
                       db $C8,$44,$2D,$46,$00,$27,$04,$00,$88,$54,$2E,$24,$2A,$09,$05,$00;82ED38;      ;
                       db $98,$54,$2F,$25,$2B,$29,$06,$00,$A8,$54,$30,$26,$2C,$2A,$07,$00;82ED48;      ;
                       db $B8,$54,$31,$27,$2D,$2B,$08,$00,$C8,$54,$32,$28,$05,$2C,$09,$00;82ED58;      ;
                       db $88,$64,$33,$29,$2F,$0E,$0A,$00,$98,$64,$34,$2A,$30,$2E,$0B,$00;82ED68;      ;
                       db $A8,$64,$35,$2B,$31,$2F,$0C,$00,$B8,$64,$36,$2C,$32,$30,$0D,$00;82ED78;      ;
                       db $C8,$64,$37,$2D,$0A,$31,$0E,$00,$88,$74,$38,$2E,$34,$13,$0F,$00;82ED88;      ;
                       db $98,$74,$39,$2F,$35,$33,$10,$00,$A8,$74,$3A,$30,$36,$34,$11,$00;82ED98;      ;
                       db $B8,$74,$3B,$31,$37,$35,$12,$00,$C8,$74,$3C,$32,$0F,$36,$13,$00;82EDA8;      ;
                       db $88,$84,$3D,$33,$39,$18,$14,$00,$98,$84,$3D,$34,$3A,$38,$15,$00;82EDB8;      ;
                       db $A8,$84,$3D,$35,$3B,$39,$16,$00,$B8,$84,$3D,$36,$3C,$3A,$17,$00;82EDC8;      ;
                       db $C8,$84,$3D,$37,$14,$3B,$18,$00,$88,$94,$3E,$38,$19,$19,$19,$00;82EDD8;      ;
                       db $88,$A4,$43,$3D,$3F,$1E,$38,$00,$98,$A4,$44,$3D,$40,$3E,$39,$00;82EDE8;      ;
                       db $A8,$A4,$45,$3D,$41,$3F,$3B,$00,$B8,$A4,$45,$3D,$42,$40,$3C,$00;82EDF8;      ;
                       db $C8,$A4,$45,$3D,$1A,$41,$3D,$00,$88,$B4,$24,$3E,$44,$23,$40,$00;82EE08;      ;
                       db $98,$B4,$25,$3F,$45,$43,$41,$00,$A8,$B4,$46,$40,$1F,$44,$42,$00;82EE18;      ;
                       db $C0,$C4,$28,$45,$45,$45,$00,$04,$28,$44,$05,$28,$01,$31,$50,$00;82EE28;      ;
                       db $38,$44,$06,$29,$02,$00,$51,$00,$48,$44,$07,$2A,$03,$01,$52,$00;82EE38;      ;
                       db $58,$44,$08,$2B,$04,$02,$53,$00,$68,$44,$09,$2C,$2D,$03,$54,$00;82EE48;      ;
                       db $28,$54,$0A,$00,$06,$36,$55,$00,$38,$54,$0B,$01,$07,$05,$56,$00;82EE58;      ;
                       db $48,$54,$0C,$02,$08,$06,$57,$00,$58,$54,$0D,$03,$09,$07,$58,$00;82EE68;      ;
                       db $68,$54,$0E,$04,$32,$08,$59,$00,$28,$64,$0F,$05,$0B,$3B,$5A,$00;82EE78;      ;
                       db $38,$64,$10,$06,$0C,$0A,$5B,$00,$48,$64,$11,$07,$0D,$0B,$5C,$00;82EE88;      ;
                       db $58,$64,$12,$08,$0E,$0C,$5D,$00,$68,$64,$13,$09,$37,$0D,$5E,$00;82EE98;      ;
                       db $28,$74,$14,$0A,$10,$40,$5F,$00,$38,$74,$15,$0B,$11,$0F,$60,$00;82EEA8;      ;
                       db $48,$74,$16,$0C,$12,$10,$61,$00,$58,$74,$17,$0D,$13,$11,$62,$00;82EEB8;      ;
                       db $68,$74,$18,$0E,$3C,$12,$63,$00,$28,$84,$19,$0F,$15,$45,$64,$00;82EEC8;      ;
                       db $38,$84,$1A,$10,$16,$14,$65,$00,$48,$84,$1B,$11,$17,$15,$66,$00;82EED8;      ;
                       db $58,$84,$1C,$12,$18,$16,$67,$00,$68,$84,$1D,$13,$41,$17,$68,$00;82EEE8;      ;
                       db $28,$94,$1E,$14,$1A,$4A,$69,$00,$38,$94,$1F,$15,$1B,$19,$6A,$00;82EEF8;      ;
                       db $48,$94,$20,$16,$1C,$1A,$6B,$00,$58,$94,$21,$17,$1D,$1B,$6C,$00;82EF08;      ;
                       db $68,$94,$22,$18,$46,$1C,$6D,$00,$28,$A4,$23,$19,$1F,$4F,$6E,$00;82EF18;      ;
                       db $38,$A4,$24,$1A,$20,$1E,$6F,$00,$48,$A4,$25,$1B,$21,$1F,$70,$00;82EF28;      ;
                       db $58,$A4,$26,$1C,$22,$20,$71,$00,$68,$A4,$27,$1D,$4B,$21,$72,$00;82EF38;      ;
                       db $28,$B4,$28,$1E,$24,$52,$73,$00,$38,$B4,$29,$1F,$25,$23,$74,$00;82EF48;      ;
                       db $48,$B4,$2A,$20,$26,$24,$75,$00,$58,$B4,$2B,$21,$27,$25,$7B,$00;82EF58;      ;
                       db $68,$B4,$2C,$22,$50,$26,$7C,$00,$28,$C4,$00,$23,$29,$53,$76,$00;82EF68;      ;
                       db $38,$C4,$01,$24,$2A,$28,$77,$00,$48,$C4,$02,$25,$2B,$29,$78,$00;82EF78;      ;
                       db $58,$C4,$03,$26,$2C,$2A,$79,$00,$68,$C4,$04,$27,$53,$2B,$7A,$00;82EF88;      ;
                       db $88,$44,$32,$50,$2E,$04,$87,$00,$98,$44,$33,$4C,$2F,$2D,$88,$00;82EF98;      ;
                       db $A8,$44,$34,$51,$30,$2E,$89,$00,$B8,$44,$35,$53,$31,$2F,$8A,$00;82EFA8;      ;
                       db $C8,$44,$36,$53,$00,$30,$8B,$00,$88,$54,$37,$2D,$33,$09,$8C,$00;82EFB8;      ;
                       db $98,$54,$38,$2E,$34,$32,$8D,$00,$A8,$54,$39,$2F,$35,$33,$8E,$00;82EFC8;      ;
                       db $B8,$54,$3A,$30,$36,$34,$8F,$00,$C8,$54,$3B,$31,$05,$35,$90,$00;82EFD8;      ;
                       db $88,$64,$3C,$32,$38,$0E,$91,$00,$98,$64,$3D,$33,$39,$37,$92,$00;82EFE8;      ;
                       db $A8,$64,$3E,$34,$3A,$38,$93,$00,$B8,$64,$3F,$35,$3B,$39,$94,$00;82EFF8;      ;
                       db $C8,$64,$40,$36,$0A,$3A,$95,$00,$88,$74,$41,$37,$3D,$13,$96,$00;82F008;      ;
                       db $98,$74,$42,$38,$3E,$3C,$97,$00,$A8,$74,$43,$39,$3F,$3D,$98,$00;82F018;      ;
                       db $B8,$74,$44,$3A,$40,$3E,$99,$00,$C8,$74,$45,$3B,$0F,$3F,$9A,$00;82F028;      ;
                       db $88,$84,$46,$3C,$42,$18,$9B,$00,$98,$84,$47,$3D,$43,$41,$9C,$00;82F038;      ;
                       db $A8,$84,$48,$3E,$44,$42,$9D,$00,$B8,$84,$49,$3F,$45,$43,$9E,$00;82F048;      ;
                       db $C8,$84,$4A,$40,$14,$44,$9F,$00,$88,$94,$4B,$41,$47,$1D,$7E,$00;82F058;      ;
                       db $98,$94,$4C,$42,$48,$46,$7F,$00,$A8,$94,$4D,$43,$49,$47,$80,$00;82F068;      ;
                       db $B8,$94,$4E,$44,$4A,$48,$81,$00,$C8,$94,$4F,$45,$19,$49,$82,$00;82F078;      ;
                       db $88,$A4,$50,$46,$4C,$22,$84,$00,$98,$A4,$2E,$47,$4D,$4B,$85,$00;82F088;      ;
                       db $A8,$A4,$51,$48,$4E,$4C,$86,$00,$B8,$A4,$53,$49,$4F,$4D,$83,$00;82F098;      ;
                       db $C8,$A4,$52,$4A,$1E,$4E,$7D,$00,$88,$B4,$2D,$4B,$51,$27,$A0,$00;82F0A8;      ;
                       db $A8,$B4,$2F,$4D,$52,$50,$00,$01,$C8,$B4,$53,$4F,$23,$51,$00,$03;82F0B8;      ;
                       db $C0,$C4,$31,$52,$28,$2C,$00,$04,$28,$44,$05,$23,$01,$04,$C6,$00;82F0C8;      ;
                       db $38,$44,$06,$24,$02,$00,$C7,$00,$48,$44,$07,$25,$03,$01,$C8,$00;82F0D8;      ;
                       db $58,$44,$08,$26,$04,$02,$C9,$00,$68,$44,$09,$27,$00,$03,$CA,$00;82F0E8;      ;
                       db $28,$54,$0A,$00,$06,$09,$CB,$00,$38,$54,$0B,$01,$07,$05,$CC,$00;82F0F8;      ;
                       db $48,$54,$0C,$02,$08,$06,$CD,$00,$58,$54,$0D,$03,$09,$07,$CE,$00;82F108;      ;
                       db $68,$54,$0E,$04,$05,$08,$CF,$00,$28,$64,$0F,$05,$0B,$0E,$D0,$00;82F118;      ;
                       db $38,$64,$10,$06,$0C,$0A,$D1,$00,$48,$64,$11,$07,$0D,$0B,$D2,$00;82F128;      ;
                       db $58,$64,$12,$08,$0E,$0C,$D3,$00,$68,$64,$13,$09,$0A,$0D,$D4,$00;82F138;      ;
                       db $28,$74,$14,$0A,$10,$13,$D5,$00,$38,$74,$15,$0B,$11,$0F,$D6,$00;82F148;      ;
                       db $48,$74,$16,$0C,$12,$10,$D7,$00,$58,$74,$17,$0D,$13,$11,$D8,$00;82F158;      ;
                       db $68,$74,$18,$0E,$0F,$12,$D9,$00,$28,$84,$19,$0F,$15,$18,$DA,$00;82F168;      ;
                       db $38,$84,$1A,$10,$16,$14,$DB,$00,$48,$84,$1B,$11,$17,$15,$DC,$00;82F178;      ;
                       db $58,$84,$1C,$12,$18,$16,$DD,$00,$68,$84,$1D,$13,$14,$17,$DE,$00;82F188;      ;
                       db $28,$94,$1E,$14,$1A,$2C,$DF,$00,$38,$94,$1F,$15,$1B,$19,$B2,$00;82F198;      ;
                       db $48,$94,$20,$16,$1C,$1A,$B3,$00,$58,$94,$21,$17,$1D,$1B,$B4,$00;82F1A8;      ;
                       db $68,$94,$22,$18,$28,$1C,$B5,$00,$28,$A4,$23,$19,$1F,$30,$B6,$00;82F1B8;      ;
                       db $38,$A4,$24,$1A,$20,$1E,$B7,$00,$48,$A4,$25,$1B,$21,$1F,$B8,$00;82F1C8;      ;
                       db $58,$A4,$26,$1C,$22,$20,$B9,$00,$68,$A4,$27,$1D,$2D,$21,$BA,$00;82F1D8;      ;
                       db $28,$B4,$00,$1E,$24,$30,$BB,$00,$38,$B4,$01,$1F,$25,$23,$A5,$00;82F1E8;      ;
                       db $48,$B4,$02,$20,$26,$24,$A6,$00,$58,$B4,$03,$21,$27,$25,$A7,$00;82F1F8;      ;
                       db $68,$B4,$04,$22,$30,$26,$A8,$00,$88,$94,$2D,$2D,$29,$1D,$AB,$00;82F208;      ;
                       db $98,$94,$29,$29,$2A,$28,$AC,$00,$A8,$94,$2E,$2E,$2B,$29,$AD,$00;82F218;      ;
                       db $B8,$94,$2B,$2B,$2C,$2A,$AE,$00,$C8,$94,$2F,$30,$19,$2B,$A9,$00;82F228;      ;
                       db $88,$A4,$28,$28,$2E,$22,$AA,$00,$A8,$A4,$2A,$2A,$2F,$2D,$00,$01;82F238;      ;
                       db $C8,$A4,$30,$2C,$1E,$2E,$00,$02,$C0,$B4,$2C,$2F,$23,$27,$00,$04;82F248;      ;
                                                            ;      ;      ;
        DATA16_82F258: dw $78C6,$78D0,$7908,$7910,$7A06,$7A10,$7A48,$7A50;82F258;      ;
                                                            ;      ;      ;
        DATA16_82F268: dw $2002,$2006,$200A,$200C,$2022,$2026,$202A,$202C;82F268;      ;
                                                            ;      ;      ;
        DATA16_82F278: dw $5010,$5030,$5050,$5060,$5110,$5130,$5150,$5160;82F278;      ;
                                                            ;      ;      ;
        DATA16_82F288: dw $0002,$0002,$0001,$0003,$0002,$0002,$0001,$0003;82F288;      ;
                                                            ;      ;      ;
        DATA16_82F298: dw $0012,$0013,$000D,$0003,$0011,$0003,$7F10,$F020;82F298;      ;
                       dw $107E,$7E8E,$0A10,$1072,$FFFE,$F2AD,$8A82,$107A;82F2A8;      ;
                       dw $724A,$E510,$106D,$65A3,$C310,$1058,$FFFE,$F2C1;82F2B8;      ;
                       dw $9F82,$0862,$5E1F,$DF08,$1059,$5E1F,$FE08,$C9FF;82F2C8;      ;
                       dw $82F2,$7F3F,$FE08,$DAFF,$82F2,$1D4D,$5D04,$0403;82F2D8;      ;
                       dw $03FF,$FF04,$0437,$03FF,$5D04,$0403,$FFFE,$F2E2;82F2E8;      ;
                       dw $4D82,$041D,$FFFE,$F2F9           ;82F2F8;      ;
                       db $82,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;82F300;      ;
