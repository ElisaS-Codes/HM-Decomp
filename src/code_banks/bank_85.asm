ORG $858000

;;;;;;;;
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
          CODE_8580B9: %Set16bit(!M)                             ;8580B9;      ;
                       LDA.B $A1                            ;8580BB;0000A1;
                       CMP.W #$0262                         ;8580BD;      ;
                       BCS CODE_8580CC                      ;8580C0;8580CC;
                       %Set8bit(!M)                             ;8580C2;      ;
                       LDA.B #$86                           ;8580C4;      ;
                       STA.B $77                            ;8580C6;000077;
                       STA.B $7A                            ;8580C8;00007A;
                       BRA CODE_8580D4                      ;8580CA;8580D4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8580CC: %Set8bit(!M)                             ;8580CC;      ;
                       LDA.B #$87                           ;8580CE;      ;
                       STA.B $77                            ;8580D0;000077;
                       STA.B $7A                            ;8580D2;00007A;
                                                            ;      ;      ;
          CODE_8580D4: %Set16bit(!MX)                             ;8580D4;      ;
                       LDA.B $A5                            ;8580D6;0000A5;
                       ASL A                                ;8580D8;      ;
                       TAX                                  ;8580D9;      ;
                       LDA.L UNK_Table14,X                  ;8580DA;858BE0;
                       STA.B $A9                            ;8580DE;0000A9;
                       TAX                                  ;8580E0;      ;
                       LDA.W #$0001                         ;8580E1;      ;
                       STA.B $A7                            ;8580E4;0000A7;
                       LDA.W $019C,X                        ;8580E6;00019C;
                       BEQ CODE_8580FF                      ;8580E9;8580FF;
                       LDA.B $9F                            ;8580EB;00009F;
                       STA.W $01A0,X                        ;8580ED;0001A0;
                       LDA.B $9B                            ;8580F0;00009B;
                       STA.W $01A4,X                        ;8580F2;0001A4;
                       LDA.B $9D                            ;8580F5;00009D;
                       STA.W $01A6,X                        ;8580F7;0001A6;
                       LDA.W #$0000                         ;8580FA;      ;
                       STA.B $A7                            ;8580FD;0000A7;
                                                            ;      ;      ;
          CODE_8580FF: RTL                                  ;8580FF;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858100: %Set16bit(!MX)                             ;858100;      ;
                       %Set16bit(!M)                             ;858102;      ;
                       LDA.B $A1                            ;858104;0000A1;
                       CMP.W #$0262                         ;858106;      ;
                       BCS CODE_858115                      ;858109;858115;
                       %Set8bit(!M)                             ;85810B;      ;
                       LDA.B #$86                           ;85810D;      ;
                       STA.B $77                            ;85810F;000077;
                       STA.B $7A                            ;858111;00007A;
                       BRA CODE_85811D                      ;858113;85811D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858115: %Set8bit(!M)                             ;858115;      ;
                       LDA.B #$87                           ;858117;      ;
                       STA.B $77                            ;858119;000077;
                       STA.B $7A                            ;85811B;00007A;
                                                            ;      ;      ;
          CODE_85811D: %Set16bit(!MX)                             ;85811D;      ;
                       LDA.B $A5                            ;85811F;0000A5;
                       ASL A                                ;858121;      ;
                       TAX                                  ;858122;      ;
                       LDA.L UNK_Table14,X                  ;858123;858BE0;
                       STA.B $A9                            ;858127;0000A9;
                       JSR.W CODE_858B7B                    ;858129;858B7B;
                       LDA.B $AF                            ;85812C;0000AF;
                       BNE return85                      ;85812E;8580B8;
                       JSR.W CODE_858B41                    ;858130;858B41;
                       %Set16bit(!MX)                             ;858133;      ;
                       LDY.B $A5                            ;858135;0000A5;
                       LDX.B $A9                            ;858137;0000A9;
                       LDA.B $A1                            ;858139;0000A1;
                       STA.W $019E,X                        ;85813B;00019E;
                       LDA.B $9F                            ;85813E;00009F;
                       STA.W $01A0,X                        ;858140;0001A0;
                       LDA.B $A3                            ;858143;0000A3;
                       STA.W $01A2,X                        ;858145;0001A2;
                       LDA.B $9B                            ;858148;00009B;
                       STA.W $01A4,X                        ;85814A;0001A4;
                       LDA.B $9D                            ;85814D;00009D;
                       STA.W $01A6,X                        ;85814F;0001A6;
                       STX.B $A9                            ;858152;0000A9;
                       LDA.B $A1                            ;858154;0000A1;
                       CMP.W #$0262                         ;858156;      ;
                       BCS CODE_858168                      ;858159;858168;
                       LDA.W $019E,X                        ;85815B;00019E;
                       ASL A                                ;85815E;      ;
                       TAX                                  ;85815F;      ;
                       LDA.L DATA8_868080,X                 ;858160;868080;
                       STA.B $75                            ;858164;000075;
                       BRA CODE_858177                      ;858166;858177;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858168: LDA.W $019E,X                        ;858168;00019E;
                       SEC                                  ;85816B;      ;
                       SBC.W #$0262                         ;85816C;      ;
                       ASL A                                ;85816F;      ;
                       TAX                                  ;858170;      ;
                       LDA.L UNK_Table15,X                  ;858171;878080;
                       STA.B $75                            ;858175;000075;
                                                            ;      ;      ;
          CODE_858177: LDX.B $A9                            ;858177;0000A9;
                       LDA.B $75                            ;858179;000075;
                       STA.W $01A8,X                        ;85817B;0001A8;
                       CLC                                  ;85817E;      ;
                       ADC.W #$0003                         ;85817F;      ;
                       STA.W $01AA,X                        ;858182;0001AA;
                       LDY.W #$0000                         ;858185;      ;
                       LDA.B [$75],Y                        ;858188;000075;
                       STA.W $01AC,X                        ;85818A;0001AC;
                       %Set8bit(!M)                             ;85818D;      ;
                       LDY.W #$0002                         ;85818F;      ;
                       LDA.B [$75],Y                        ;858192;000075;
                       STA.W $01AE,X                        ;858194;0001AE;
                       %Set16bit(!M)                             ;858197;      ;
                       JSR.W CODE_858AE5                    ;858199;858AE5;
                       LDA.W #$0000                         ;85819C;      ;
                       STA.B $A7                            ;85819F;0000A7;
                       RTL                                  ;8581A1;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8581A2: %Set16bit(!MX)                             ;8581A2;      ;
                       LDA.B $A5                            ;8581A4;0000A5;
                       ASL A                                ;8581A6;      ;
                       TAX                                  ;8581A7;      ;
                       LDA.L UNK_Table14,X                  ;8581A8;858BE0;
                       STA.B $A9                            ;8581AC;0000A9;
                       JSR.W CODE_858B7B                    ;8581AE;858B7B;
                       LDA.B $AF                            ;8581B1;0000AF;
                       BEQ CODE_8581B8                      ;8581B3;8581B8;
                       JMP.W return85                    ;8581B5;8580B8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8581B8: JSR.W CODE_858B41                    ;8581B8;858B41;
                       %Set16bit(!MX)                             ;8581BB;      ;
                       LDX.B $A9                            ;8581BD;0000A9;
                       %Set16bit(!MX)                             ;8581BF;      ;
                       LDA.W #$0000                         ;8581C1;      ;
                       STA.W $019C,X                        ;8581C4;00019C;
                       LDA.W $01AA,X                        ;8581C7;0001AA;
                       RTL                                  ;8581CA;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8581CB: %Set16bit(!MX)                             ;8581CB;      ;
                       LDA.B $A5                            ;8581CD;0000A5;
                       ASL A                                ;8581CF;      ;
                       TAX                                  ;8581D0;      ;
                       LDA.L UNK_Table14,X                  ;8581D1;858BE0;
                       STA.B $A9                            ;8581D5;0000A9;
                       TAX                                  ;8581D7;      ;
                       LDA.W $019C,X                        ;8581D8;00019C;
                       BEQ CODE_8581F6                      ;8581DB;8581F6;
                       LDA.W $019E,X                        ;8581DD;00019E;
                       STA.B $A1                            ;8581E0;0000A1;
                       LDA.W $01A0,X                        ;8581E2;0001A0;
                       STA.B $9F                            ;8581E5;00009F;
                       LDA.W $01A2,X                        ;8581E7;0001A2;
                       STA.B $A3                            ;8581EA;0000A3;
                       LDA.W $01A4,X                        ;8581EC;0001A4;
                       STA.B $9B                            ;8581EF;00009B;
                       LDA.W $01A6,X                        ;8581F1;0001A6;
                       STA.B $9D                            ;8581F4;00009D;
                                                            ;      ;      ;
          CODE_8581F6: %Set8bit(!M)                             ;8581F6;      ;
                       LDA.W $01AE,X                        ;8581F8;0001AE;
                       %Set8bit(!M)                             ;8581FB;      ;
                       CMP.B #$00                           ;8581FD;      ;
                       BMI CODE_858206                      ;8581FF;858206;
                       XBA                                  ;858201;      ;
                       LDA.B #$00                           ;858202;      ;
                       BRA CODE_858209                      ;858204;858209;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858206: XBA                                  ;858206;      ;
                       LDA.B #$FF                           ;858207;      ;
                                                            ;      ;      ;
          CODE_858209: XBA                                  ;858209;      ;
                       %Set16bit(!M)                             ;85820A;      ;
                       STA.B $A7                            ;85820C;0000A7;
                       RTL                                  ;85820E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
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
          CODE_8582C7: %Set16bit(!MX)                             ;8582C7;      ;
                       STZ.B $A9                            ;8582C9;0000A9;
                       STZ.B $AB                            ;8582CB;0000AB;
                                                            ;      ;      ;
          CODE_8582CD: LDX.B $A9                            ;8582CD;0000A9;
                       LDA.W $019C,X                        ;8582CF;00019C;
                       BNE CODE_8582E7                      ;8582D2;8582E7;
                                                            ;      ;      ;
          CODE_8582D4: LDA.B $A9                            ;8582D4;0000A9;
                       CLC                                  ;8582D6;      ;
                       ADC.W #$0024                         ;8582D7;      ;
                       STA.B $A9                            ;8582DA;0000A9;
                       INC.B $AB                            ;8582DC;0000AB;
                       LDA.B $AB                            ;8582DE;0000AB;
                       CMP.B $DC                            ;8582E0;0000DC;
                       BNE CODE_8582CD                      ;8582E2;8582CD;
                       JMP.W CODE_858376                    ;8582E4;858376;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8582E7: %Set16bit(!MX)                             ;8582E7;      ;
                       LDA.W $019E,X                        ;8582E9;00019E;
                       CMP.W #$0262                         ;8582EC;      ;
                       BCS CODE_8582FB                      ;8582EF;8582FB;
                       %Set8bit(!M)                             ;8582F1;      ;
                       LDA.B #$86                           ;8582F3;      ;
                       STA.B $77                            ;8582F5;000077;
                       STA.B $7A                            ;8582F7;00007A;
                       BRA CODE_858303                      ;8582F9;858303;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8582FB: %Set8bit(!M)                             ;8582FB;      ;
                       LDA.B #$87                           ;8582FD;      ;
                       STA.B $77                            ;8582FF;000077;
                       STA.B $7A                            ;858301;00007A;
                                                            ;      ;      ;
          CODE_858303: %Set8bit(!M)                             ;858303;      ;
                       LDA.W $01AE,X                        ;858305;0001AE;
                       BNE CODE_858349                      ;858308;858349;
                       %Set16bit(!M)                             ;85830A;      ;
                       JSR.W CODE_858B7B                    ;85830C;858B7B;
                       LDA.B $AF                            ;85830F;0000AF;
                       BNE CODE_8582D4                      ;858311;8582D4;
                       JSR.W CODE_858B41                    ;858313;858B41;
                       %Set16bit(!MX)                             ;858316;      ;
                       LDX.B $A9                            ;858318;0000A9;
                       LDA.W $01AA,X                        ;85831A;0001AA;
                       STA.B $75                            ;85831D;000075;
                                                            ;      ;      ;
          CODE_85831F: LDA.B [$75]                          ;85831F;000075;
                       BNE CODE_85832A                      ;858321;85832A;
                       LDA.W $01A8,X                        ;858323;0001A8;
                       STA.B $75                            ;858326;000075;
                       BRA CODE_85831F                      ;858328;85831F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_85832A: STA.W $01AC,X                        ;85832A;0001AC;
                       %Set8bit(!M)                             ;85832D;      ;
                       LDY.W #$0002                         ;85832F;      ;
                       LDA.B [$75],Y                        ;858332;000075;
                       STA.W $01AE,X                        ;858334;0001AE;
                       %Set16bit(!M)                             ;858337;      ;
                       LDA.B $75                            ;858339;000075;
                       CLC                                  ;85833B;      ;
                       ADC.W #$0003                         ;85833C;      ;
                       STA.W $01AA,X                        ;85833F;0001AA;
                       JSR.W CODE_858AE5                    ;858342;858AE5;
                       %Set16bit(!MX)                             ;858345;      ;
                       BRA CODE_858362                      ;858347;858362;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858349: %Set8bit(!M)                             ;858349;      ;
                       LDA.W $01AE,X                        ;85834B;0001AE;
                       CMP.B #$FE                           ;85834E;      ;
                       BNE CODE_858362                      ;858350;858362;
                       %Set16bit(!M)                             ;858352;      ;
                       JSR.W CODE_858B41                    ;858354;858B41;
                       %Set16bit(!MX)                             ;858357;      ;
                       LDA.W #$0000                         ;858359;      ;
                       STA.W $019C,X                        ;85835C;00019C;
                       JMP.W CODE_8582D4                    ;85835F;8582D4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858362: LDX.B $A9                            ;858362;0000A9;
                       %Set8bit(!M)                             ;858364;      ;
                       LDA.W $01AE,X                        ;858366;0001AE;
                       CMP.B #$FF                           ;858369;      ;
                       BEQ CODE_858371                      ;85836B;858371;
                       DEC A                                ;85836D;      ;
                       STA.W $01AE,X                        ;85836E;0001AE;
                                                            ;      ;      ;
          CODE_858371: %Set16bit(!MX)                             ;858371;      ;
                       JMP.W CODE_8582D4                    ;858373;8582D4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_858376: RTL                                  ;858376;      ;

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
        CMP.W #$0262                        ;TODO
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

        CODE_858422:
        LDX.B $A9                            ;858422;0000A9;
        LDA.W $019C,X                        ;858424;00019C;
        BNE CODE_858444                      ;858427;858444;
                                        ;      ;      ;
        CODE_858429:
        INY                                  ;858429;      ;
        TYX                                  ;85842A;      ;
        %Set8bit(!M)                             ;85842B;      ;
        LDA.B #$00                           ;85842D;      ;
        XBA                                  ;85842F;      ;
        LDA.W $084C,X                        ;858430;00084C;
        %Set16bit(!M)                             ;858433;      ;
        ASL A                                ;858435;      ;
        TAX                                  ;858436;      ;
        LDA.L UNK_Table14,X                  ;858437;858BE0;
        STA.B $A9                            ;85843B;0000A9;
        CPY.B $DC                            ;85843D;0000DC;
        BNE CODE_858422                      ;85843F;858422;
        JMP.W CODE_8585F4                    ;858441;8585F4;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_858444:
        STY.B $AB                            ;858444;0000AB;
        LDX.B $A9                            ;858446;0000A9;
        LDA.W $019E,X                        ;858448;00019E;
        CMP.W #$0262                         ;85844B;      ;
        BCS CODE_85845A                      ;85844E;85845A;
        %Set8bit(!M)                             ;858450;      ;
        LDA.B #$86                           ;858452;      ;
        STA.B $77                            ;858454;000077;
        STA.B $7A                            ;858456;00007A;
        BRA CODE_858462                      ;858458;858462;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_85845A:
        %Set8bit(!M)                             ;85845A;      ;
        LDA.B #$87                           ;85845C;      ;
        STA.B $77                            ;85845E;000077;
        STA.B $7A                            ;858460;00007A;
                                        ;      ;      ;
        CODE_858462:
        %Set16bit(!M)                             ;858462;      ;
        LDA.W $01AC,X                        ;858464;0001AC;
        STA.B $78                            ;858467;000078;
        LDA.W $01A0,X                        ;858469;0001A0;
        STA.B $9F                            ;85846C;00009F;
        LDA.W $01A4,X                        ;85846E;0001A4;
        STA.B $9B                            ;858471;00009B;
        LDA.W $01A6,X                        ;858473;0001A6;
        STA.B $9D                            ;858476;00009D;
        %Set8bit(!M)                             ;858478;      ;
        LDA.W $01AF,X                        ;85847A;0001AF;
        STA.B $AD                            ;85847D;0000AD;
        STZ.B $AE                            ;85847F;0000AE;
        %Set16bit(!M)                             ;858481;      ;
        INC.B $78                            ;858483;000078;
        LDA.B $AD                            ;858485;0000AD;
        DEC A                                ;858487;      ;
        STA.B $7E                            ;858488;00007E;
        ASL A                                ;85848A;      ;
        STA.B $80                            ;85848B;000080;
        CLC                                  ;85848D;      ;
        ADC.B $7E                            ;85848E;00007E;
        ADC.B $80                            ;858490;000080;
        ADC.B $78                            ;858492;000078;
        STA.B $78                            ;858494;000078;
        LDA.B $A9                            ;858496;0000A9;
        STA.B $75                            ;858498;000075;
        CLC                                  ;85849A;      ;
        ADC.B $AD                            ;85849B;0000AD;
        SEC                                  ;85849D;      ;
        SBC.W #$0001                         ;85849E;      ;
        STA.B $75                            ;8584A1;000075;
                                        ;      ;      ;
        CODE_8584A3:
        LDY.B $AB                            ;8584A3;0000AB;
        LDA.B $AD                            ;8584A5;0000AD;
        BNE CODE_8584AC                      ;8584A7;8584AC;
        JMP.W CODE_858429                    ;8584A9;858429;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_8584AC:
        LDX.B $75                            ;8584AC;000075;
        %Set8bit(!M)                             ;8584AE;      ;
        LDA.W $01B0,X                        ;8584B0;0001B0;
        CMP.B #$FF                           ;8584B3;      ;
        BNE CODE_8584BA                      ;8584B5;8584BA;
        JMP.W CODE_8585E3                    ;8584B7;8585E3;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_8584BA:
        %Set16bit(!M)                             ;8584BA;      ;
        LDY.W #$0002                         ;8584BC;      ;
        %Set8bit(!M)                             ;8584BF;      ;
        LDA.B [$78],Y                        ;8584C1;000078;
        %Set8bit(!M)                             ;8584C3;      ;
        CMP.B #$00                           ;8584C5;      ;
        BMI CODE_8584CE                      ;8584C7;8584CE;
        XBA                                  ;8584C9;      ;
        LDA.B #$00                           ;8584CA;      ;
        BRA CODE_8584D1                      ;8584CC;8584D1;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_8584CE:
        XBA                                  ;8584CE;      ;
        LDA.B #$FF                           ;8584CF;      ;
                                        ;      ;      ;
        CODE_8584D1:
        XBA                                  ;8584D1;      ;
        %Set16bit(!M)                             ;8584D2;      ;
        JSR.W CODE_858BB0                    ;8584D4;858BB0;
        CLC                                  ;8584D7;      ;
        ADC.B $9B                            ;8584D8;00009B;
        SEC                                  ;8584DA;      ;
        SBC.B !OBJ_Offset_X                            ;8584DB;0000F5;
        STA.B $BF                            ;8584DD;0000BF;
        INY                                  ;8584DF;      ;
        %Set8bit(!M)                             ;8584E0;      ;
        LDA.B [$78],Y                        ;8584E2;000078;
        %Set8bit(!M)                             ;8584E4;      ;
        CMP.B #$00                           ;8584E6;      ;
        BMI CODE_8584EF                      ;8584E8;8584EF;
        XBA                                  ;8584EA;      ;
        LDA.B #$00                           ;8584EB;      ;
        BRA CODE_8584F2                      ;8584ED;8584F2;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_8584EF:
        XBA                                  ;8584EF;      ;
        LDA.B #$FF                           ;8584F0;      ;
                                        ;      ;      ;
        CODE_8584F2:
        XBA                                  ;8584F2;      ;
        %Set16bit(!M)                             ;8584F3;      ;
        JSR.W CODE_858BBC                    ;8584F5;858BBC;
        CLC                                  ;8584F8;      ;
        ADC.B $9D                            ;8584F9;00009D;
        SEC                                  ;8584FB;      ;
        SBC.B !OBJ_Offset_Y                           ;8584FC;0000F7;
        STA.B $C1                            ;8584FE;0000C1;
        STY.B $C5                            ;858500;0000C5;
        %Set16bit(!MX)                             ;858502;      ;
        LDA.B $AF                            ;858504;0000AF;
        AND.W #$FFE0                         ;858506;      ;
        STA.B $7E                            ;858509;00007E;
        LSR A                                ;85850B;      ;
        LSR A                                ;85850C;      ;
        LSR A                                ;85850D;      ;
        LSR A                                ;85850E;      ;
        STA.B $80                            ;85850F;000080;
        LDA.B $AF                            ;858511;0000AF;
        SEC                                  ;858513;      ;
        SBC.B $7E                            ;858514;00007E;
        STA.B $7E                            ;858516;00007E;
        LDA.B $80                            ;858518;000080;
        TAX                                  ;85851A;      ;
        LDA.L $7EA200,X                      ;85851B;7EA200;
        STA.B $C3                            ;85851F;0000C3;
        LDA.B $BF                            ;858521;0000BF;
        CMP.W #$0100                         ;858523;      ;
        BCC CODE_858537                      ;858526;858537;
        LDA.B $7E                            ;858528;00007E;
        AND.W #$FFFC                         ;85852A;      ;
        LSR A                                ;85852D;      ;
        TAX                                  ;85852E;      ;
        LDA.L DATA8_858BD0,X                 ;85852F;858BD0;
        ORA.B $C3                            ;858533;0000C3;
        STA.B $C3                            ;858535;0000C3;
                                        ;      ;      ;
        CODE_858537:
        %Set16bit(!M)                             ;858537;      ;
        LDA.B $BF                            ;858539;0000BF;
        CMP.W #$0100                         ;85853B;      ;
        BCC CODE_858548                      ;85853E;858548;
        CMP.W #$FFF0                         ;858540;      ;
        BCS CODE_858548                      ;858543;858548;
        JMP.W CODE_8585D9                    ;858545;8585D9;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_858548:
        %Set16bit(!M)                             ;858548;      ;
        LDA.B $C1                            ;85854A;0000C1;
        CMP.W #$00F0                         ;85854C;      ;
        BCC CODE_858559                      ;85854F;858559;
        CMP.W #$FFF0                         ;858551;      ;
        BCS CODE_858559                      ;858554;858559;
        JMP.W CODE_8585D9                    ;858556;8585D9;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_858559:
        %Set16bit(!MX)                             ;858559;      ;
        LDX.B $AF                            ;85855B;0000AF;
        LDA.B $BF                            ;85855D;0000BF;
        %Set8bit(!M)                             ;85855F;      ;
        STA.L $7EA000,X                      ;858561;7EA000;
        %Set16bit(!M)                             ;858565;      ;
        LDA.B $C1                            ;858567;0000C1;
        %Set8bit(!M)                             ;858569;      ;
        STA.L $7EA001,X                      ;85856B;7EA001;
        %Set16bit(!M)                             ;85856F;      ;
        LDX.B $80                            ;858571;000080;
        LDA.B $C3                            ;858573;0000C3;
        STA.L $7EA200,X                      ;858575;7EA200;
        %Set16bit(!MX)                             ;858579;      ;
        LDX.B $AF                            ;85857B;0000AF;
        LDY.B $C5                            ;85857D;0000C5;
        INY                                  ;85857F;      ;
        %Set8bit(!M)                             ;858580;      ;
        LDA.B [$78],Y                        ;858582;000078;
        STA.B $B2                            ;858584;0000B2;
        ASL A                                ;858586;      ;
        AND.B #$0E                           ;858587;      ;
        STA.B $B1                            ;858589;0000B1;
        LDA.B $B2                            ;85858B;0000B2;
        ASL A                                ;85858D;      ;
        ASL A                                ;85858E;      ;
        AND.B #$C0                           ;85858F;      ;
        LSR A                                ;858591;      ;
        STA.B $B2                            ;858592;0000B2;
        ASL A                                ;858594;      ;
        ASL A                                ;858595;      ;
        ORA.B $B2                            ;858596;0000B2;
        AND.B #$C0                           ;858598;      ;
        ORA.B $B1                            ;85859A;0000B1;
        ORA.B #$20                           ;85859C;      ;
        EOR.B $9F                            ;85859E;00009F;
        STA.L $7EA003,X                      ;8585A0;7EA003;
        LDA.W !current_graphic_preset                          ;8585A4;000195;
        ASL A                                ;8585A7;      ;
        ASL A                                ;8585A8;      ;
        ASL A                                ;8585A9;      ;
        ASL A                                ;8585AA;      ;
        ORA.L $7EA003,X                      ;8585AB;7EA003;
        STA.L $7EA003,X                      ;8585AF;7EA003;
        %Set16bit(!M)                             ;8585B3;      ;
        LDA.W #$0000                         ;8585B5;      ;
        LDX.B $75                            ;8585B8;000075;
        %Set8bit(!M)                             ;8585BA;      ;
        LDA.W $01B0,X                        ;8585BC;0001B0;
        %Set16bit(!M)                             ;8585BF;      ;
        ASL A                                ;8585C1;      ;
        TAX                                  ;8585C2;      ;
        LDA.L DATA8_868000,X                 ;8585C3;868000;
        %Set8bit(!M)                             ;8585C7;      ;
        LDX.B $AF                            ;8585C9;0000AF;
        STA.L $7EA002,X                      ;8585CB;7EA002;
        %Set16bit(!M)                             ;8585CF;      ;
        LDA.B $AF                            ;8585D1;0000AF;
        CLC                                  ;8585D3;      ;
        ADC.W #$0004                         ;8585D4;      ;
        STA.B $AF                            ;8585D7;0000AF;
                                        ;      ;      ;
        CODE_8585D9:
        LDA.B $78                            ;8585D9;000078;
        SEC                                  ;8585DB;      ;
        SBC.W #$0005                         ;8585DC;      ;
        STA.B $78                            ;8585DF;000078;
        BRA jmpsetDMAforOAMcopy                ;8585E1;8585ED;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_8585E3:
        %Set16bit(!M)                             ;8585E3;      ;
        LDA.B $78                            ;8585E5;000078;
        SEC                                  ;8585E7;      ;
        SBC.W #$0005                         ;8585E8;      ;
        STA.B $78                            ;8585EB;000078;
                                        ;      ;      ;
        jmpsetDMAforOAMcopy:
        DEC.B $75                            ;8585ED;000075;
        DEC.B $AD                            ;8585EF;0000AD;
        JMP.W CODE_8584A3                    ;8585F1;8584A3;
                                        ;      ;      ;
                                        ;      ;      ;
        CODE_8585F4:
        %Set16bit(!MX)                             ;8585F4;      ;
        LDA.B $AF                            ;8585F6;0000AF;
        STA.W $084A                          ;8585F8;00084A;
        %Set8bit(!M)                             ;8585FB;      ;
        LDX.W #$0000                         ;8585FD;      ;
        STX.W !OAMADDL                          ;858600;002102;OAM Address Registers
        STZ.W $4340                          ;858603;004340;DMA PortX Control Register
        LDA.B #$04                           ;858606;      ;OAM Data Write Register
        STA.W $4341                          ;858608;004341;DMA PortX Destination Register
        LDA.B #$00                           ;85860B;      ;
        STA.W $4342                          ;85860D;004342;DMA PortX Source Address Registers
        LDA.B #$A0                           ;858610;      ;
        STA.W $4343                          ;858612;004343;
        LDA.B #$7E                           ;858615;      ;
        STA.W $4344                          ;858617;004344;
        LDX.W #$0220                         ;85861A;      ;Basically, 0
        STX.W $4345                          ;85861D;004345;
        LDA.B $9A                            ;858620;00009A;
        ORA.B #$10                           ;858622;      ;
        STA.B $9A                            ;858624;00009A;
        RTL                                  ;858626;      ;
                                                            ;      ;      ;
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

;;;;;;;;
CODE_858BB0:
        %Set16bit(!MX)
        PHA
        LDA.B $9F
        AND.W #$0040
        BEQ CODE_858BCE
        BRA CODE_858BC4

;;;;;;;;
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

         DATA8_858BD0: db $01,$00,$04,$00,$10,$00,$40,$00,$00,$01,$00,$04,$00,$10,$00,$40;858BD0;      ;
                                                            ;      ;      ;
          UNK_Table14: db $00,$00,$24,$00,$48,$00,$6C,$00,$90,$00,$B4,$00,$D8,$00,$FC,$00;858BE0;      ;
                       db $20,$01,$44,$01,$68,$01,$8C,$01,$B0,$01,$D4,$01,$F8,$01,$1C,$02;858BF0;      ;
                       db $40,$02,$64,$02,$88,$02,$AC,$02,$D0,$02,$F4,$02,$18,$03,$3C,$03;858C00;      ;
                       db $60,$03,$84,$03,$A8,$03,$CC,$03,$F0,$03,$14,$04,$38,$04,$5C,$04;858C10;      ;
                       db $80,$04,$A4,$04,$C8,$04,$EC,$04,$40,$05,$34,$05,$58,$05,$7C,$05;858C20;      ;

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
        BNE +
        JMP.W .escapeloop

      + LDA.B $C7
        CMP.W #$0100
        BCS +
        JMP.W .escapeloop

      + LDX.B $BB
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

    .loop320:
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
        BRA .CODE_858D2F                      ;infinite loop again???

    .skip320:
        STX.B $C3
        TXA
        LSR A
        LSR A
        STA.B $C5

    .CODE_858D38:
        LDA.B $C3
        BMI .CODE_858D38

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
