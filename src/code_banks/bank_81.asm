ORG $818000                          ;      ;      ;

;;;;;;;;
SUB_818000:
        %Set8bit(!M)                             ;818000;      ;
        %Set16bit(!X)                             ;818002;      ;
        LDA.B #$01                           ;818004;      ;
        STA.W $0974                          ;818006;000974;
        LDA.B #$01                           ;818009;      ;
        STA.W $0975                          ;81800B;000975;
        LDA.B #$00                           ;81800E;      ;
        STA.W $0976                          ;818010;000976;
        LDA.W !item_on_hand                          ;818013;00091D;
        STA.W $0984                          ;818016;000984;
        %Set16bit(!M)                             ;818019;      ;
        LDA.W #$0002                         ;81801B;      ;
        CLC                                  ;81801E;      ;
        ADC.B !player_direction                            ;81801F;0000DA;
        TAY                                  ;818021;      ;
        JSL.L SUB_8180B7                          ;818022;8180B7;
        %Set16bit(!M)                             ;818026;      ;
        LDA.B !player_pos_X                           ;818028;0000D6;
        STA.W $0980                          ;81802A;000980;
        LDA.B !player_pos_Y                            ;81802D;0000D8;
        INC A                                ;81802F;      ;
        INC A                                ;818030;      ;
        STA.W $0982                          ;818031;000982;
        JSL.L CODE_81A500                    ;818034;81A500;
        %Set16bit(!MX)                             ;818038;      ;
        LDA.W #$0001                         ;81803A;      ;
        LDX.W #$0000                         ;81803D;      ;
        LDY.W #$0000                         ;818040;      ;
        JSL.L CalculateTileinFront                    ;818043;81D14E;
        %Set8bit(!M)                             ;818047;      ;
        %Set16bit(!X)                             ;818049;      ;
        LDA.B #$00                           ;81804B;      ;
        XBA                                  ;81804D;      ;
        LDA.W $0984                          ;81804E;000984;
        %Set16bit(!M)                             ;818051;      ;
        TAX                                  ;818053;      ;
        %Set8bit(!M)                             ;818054;      ;
        LDA.L DATA8_81A2AD,X                 ;818056;81A2AD;
        BEQ .CODE_818072                      ;81805A;818072;
        %Set16bit(!M)                             ;81805C;      ;
        ASL A                                ;81805E;      ;
        ASL A                                ;81805F;      ;
        TAY                                  ;818060;      ;
        %Set8bit(!M)                             ;818061;      ;
        LDA.B #$00                           ;818063;      ;
        XBA                                  ;818065;      ;
        LDA.B [$0D],Y                        ;818066;00000D;
        LDX.W !tile_in_front_X                          ;818068;000985;
        LDY.W !tile_in_front_Y                          ;81806B;000987;
        JSL.L CODE_81A688                    ;81806E;81A688;

    .CODE_818072:
        %Set8bit(!M)                             ;818072;      ;
        %Set16bit(!X)                             ;818074;      ;
        LDA.B #$00                           ;818076;      ;
        XBA                                  ;818078;      ;
        LDA.W $0984                          ;818079;000984;
        %Set16bit(!M)                             ;81807C;      ;
        TAX                                  ;81807E;      ;
        %Set8bit(!M)                             ;81807F;      ;
        LDA.L DATA8_81A308,X                 ;818081;81A308;
        BEQ .CODE_818099                      ;818085;818099;
        %Set8bit(!M)                             ;818087;      ;
        %Set16bit(!X)                             ;818089;      ;
        LDA.B #$08                           ;81808B;      ;
        STA.W $0114                          ;81808D;000114;
        LDA.B #$06                           ;818090;      ;
        STA.W $0115                          ;818092;000115;
        JSL.L UNK_Audio19                    ;818095;838332;

    .CODE_818099: RTL                                  ;818099;      ;

;;;;;;;; UNUSED?
SUB_81809A:
        %Set8bit(!M)                             ;81809A;      ;
        %Set16bit(!X)                             ;81809C;      ;
        LDA.B #$00                           ;81809E;      ;
        XBA                                  ;8180A0;      ;
        LDA.W $0984                          ;8180A1;000984;
        ASL A                                ;8180A4;      ;
        TAX                                  ;8180A5;      ;
        JSR.W (DATA8_8197C0,X)               ;8180A6;8197C0;
        %Set16bit(!MX)                             ;8180A9;      ;
        LDA.L $7F1F5E                        ;8180AB;7F1F5E;
        AND.W #$FFFE                         ;8180AF;      ;
        STA.L $7F1F5E                        ;8180B2;7F1F5E;
        RTS                                  ;8180B6;      ;

;;;;;;;;
SUB_8180B7:
        %Set8bit(!M)                             ;8180B7;      ;
        %Set16bit(!X)                             ;8180B9;      ;
        LDA.B #$00                           ;8180BB;      ;
        XBA                                  ;8180BD;      ;
        LDA.W $0984                          ;8180BE;000984;
        %Set16bit(!M)                             ;8180C1;      ;
        STA.B $7E                            ;8180C3;00007E;
        ASL A                                ;8180C5;      ;
        CLC                                  ;8180C6;      ;
        ADC.B $7E                            ;8180C7;00007E;
        TAX                                  ;8180C9;      ;
        LDA.L DATA8_8196AF,X                 ;8180CA;8196AF;
        STA.B $72                            ;8180CE;000072;
        INX                                  ;8180D0;      ;
        INX                                  ;8180D1;      ;
        %Set8bit(!M)                             ;8180D2;      ;
        LDA.L DATA8_8196AF,X                 ;8180D4;8196AF;
        STA.B $74                            ;8180D8;000074;
        %Set16bit(!MX)                             ;8180DA;      ;
        TYA                                  ;8180DC;      ;
        STA.B $7E                            ;8180DD;00007E;
        ASL A                                ;8180DF;      ;
        CLC                                  ;8180E0;      ;
        ADC.B $7E                            ;8180E1;00007E;
        TAY                                  ;8180E3;      ;
        LDA.B [$72],Y                        ;8180E4;000072;
        STA.W $097A                          ;8180E6;00097A;
        INY                                  ;8180E9;      ;
        INY                                  ;8180EA;      ;
        %Set8bit(!M)                             ;8180EB;      ;
        LDA.B #$00                           ;8180ED;      ;
        XBA                                  ;8180EF;      ;
        LDA.B [$72],Y                        ;8180F0;000072;
        %Set16bit(!M)                             ;8180F2;      ;
        ASL A                                ;8180F4;      ;
        ASL A                                ;8180F5;      ;
        ASL A                                ;8180F6;      ;
        ASL A                                ;8180F7;      ;
        ASL A                                ;8180F8;      ;
        ASL A                                ;8180F9;      ;
        STA.W $097E                          ;8180FA;00097E;
        RTL                                  ;8180FD;      ;END_SUB_8180B7

        JSR.W CODE_818855                    ;8180FE;818855;
        RTS                                  ;818101;      ;

        JSR.W CODE_818855                    ;818102;818855;
        RTS                                  ;818105;      ;

        JSR.W CODE_818855                    ;818106;818855;
        RTS                                  ;818109;      ;

        JSR.W CODE_818855                    ;81810A;818855;
        RTS                                  ;81810D;      ;

        JSR.W CODE_818855                    ;81810E;818855;
        RTS                                  ;818111;      ;

        JSR.W CODE_818855                    ;818112;818855;
        RTS                                  ;818115;      ;

        JSR.W CODE_818855                    ;818116;818855;
        RTS                                  ;818119;      ;

        JSR.W CODE_818855                    ;81811A;818855;
        RTS                                  ;81811D;      ;

        JSR.W CODE_8188E5                    ;81811E;8188E5;
        RTS                                  ;818121;      ;

        JSR.W CODE_8188E5                    ;818122;8188E5;
        RTS                                  ;818125;      ;

        JSR.W CODE_81889A                    ;818126;81889A;
        RTS                                  ;818129;      ;

        JSR.W CODE_81889A                    ;81812A;81889A;
        RTS                                  ;81812D;      ;

        JSR.W CODE_81889A                    ;81812E;81889A;
        RTS                                  ;818131;      ;

        JSR.W CODE_8188E5                    ;818132;8188E5;
        %Set16bit(!MX)                             ;818135;      ;
        LDA.L $7F1F5E                        ;818137;7F1F5E;
        AND.W #$0001                         ;81813B;      ;
        BEQ CODE_818149                      ;81813E;818149;
        LDA.L !shipped_corn                        ;818140;7F1F4A;
        INC A                                ;818144;      ;
        STA.L !shipped_corn                        ;818145;7F1F4A;
                                                            ;      ;      ;
          CODE_818149: RTS                                  ;818149;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;81814A;8188E5;
                       %Set16bit(!MX)                             ;81814D;      ;
                       LDA.L $7F1F5E                        ;81814F;7F1F5E;
                       AND.W #$0001                         ;818153;      ;
                       BEQ CODE_818161                      ;818156;818161;
                       LDA.L !shipped_tomatoes                        ;818158;7F1F4C;
                       INC A                                ;81815C;      ;
                       STA.L !shipped_tomatoes                        ;81815D;7F1F4C;
                                                            ;      ;      ;
          CODE_818161: RTS                                  ;818161;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;818162;8188E5;
                       %Set16bit(!MX)                             ;818165;      ;
                       LDA.L $7F1F5E                        ;818167;7F1F5E;
                       AND.W #$0001                         ;81816B;      ;
                       BEQ CODE_818179                      ;81816E;818179;
                       LDA.L !shipped_potatoes                        ;818170;7F1F50;
                       INC A                                ;818174;      ;
                       STA.L !shipped_potatoes                        ;818175;7F1F50;
                                                            ;      ;      ;
          CODE_818179: RTS                                  ;818179;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;81817A;8188E5;
                       %Set16bit(!MX)                             ;81817D;      ;
                       LDA.L $7F1F5E                        ;81817F;7F1F5E;
                       AND.W #$0001                         ;818183;      ;
                       BEQ CODE_818191                      ;818186;818191;
                       LDA.L !shipped_turnips                        ;818188;7F1F4E;
                       INC A                                ;81818C;      ;
                       STA.L !shipped_turnips                        ;81818D;7F1F4E;
                                                            ;      ;      ;
          CODE_818191: RTS                                  ;818191;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;818192;8188E5;
                       RTS                                  ;818195;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;818196;8188E5;
                       RTS                                  ;818199;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;81819A;8188E5;
                       RTS                                  ;81819D;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;81819E;8188E5;
                       RTS                                  ;8181A1;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;8181A2;8188E5;
                       RTS                                  ;8181A5;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;8181A6;8188E5;
                       RTS                                  ;8181A9;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188BC                    ;8181AA;8188BC;
                       RTS                                  ;8181AD;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8181AE;818923;
                       %Set8bit(!M)                             ;8181B1;      ;
                       LDA.W $0976                          ;8181B3;000976;
                       CMP.B #$FF                           ;8181B6;      ;
                       BNE CODE_8181C7                      ;8181B8;8181C7;
                       %Set8bit(!M)                             ;8181BA;      ;
                       STZ.W $0976                          ;8181BC;000976;
                       LDA.B #$58                           ;8181BF;      ;
                       STA.W $0984                          ;8181C1;000984;
                       STA.W !item_on_hand                          ;8181C4;00091D;
                                                            ;      ;      ;
          CODE_8181C7: RTS                                  ;8181C7;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8181C8;818923;
                       %Set8bit(!M)                             ;8181CB;      ;
                       LDA.W $0976                          ;8181CD;000976;
                       CMP.B #$FF                           ;8181D0;      ;
                       BNE CODE_8181E1                      ;8181D2;8181E1;
                       %Set8bit(!M)                             ;8181D4;      ;
                       STZ.W $0976                          ;8181D6;000976;
                       LDA.B #$59                           ;8181D9;      ;
                       STA.W $0984                          ;8181DB;000984;
                       STA.W !item_on_hand                          ;8181DE;00091D;
                                                            ;      ;      ;
          CODE_8181E1: RTS                                  ;8181E1;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8181E2;818923;
                       %Set8bit(!M)                             ;8181E5;      ;
                       LDA.W $0976                          ;8181E7;000976;
                       CMP.B #$FF                           ;8181EA;      ;
                       BNE CODE_8181FB                      ;8181EC;8181FB;
                       %Set8bit(!M)                             ;8181EE;      ;
                       STZ.W $0976                          ;8181F0;000976;
                       LDA.B #$5A                           ;8181F3;      ;
                       STA.W $0984                          ;8181F5;000984;
                       STA.W !item_on_hand                          ;8181F8;00091D;
                                                            ;      ;      ;
          CODE_8181FB: RTS                                  ;8181FB;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8181FC;      ;
                       LDA.L $7F1F74                        ;8181FE;7F1F74;
                       AND.W #$0020                         ;818202;      ;
                       BEQ CODE_81820A                      ;818205;81820A;
                       JMP.W CODE_818337                    ;818207;818337;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81820A: %Set8bit(!M)                             ;81820A;      ;
                       %Set16bit(!X)                             ;81820C;      ;
                       LDA.W $0976                          ;81820E;000976;
                       BNE CODE_81822C                      ;818211;81822C;
                       LDA.W $09AC                          ;818213;0009AC;
                       CMP.B #$01                           ;818216;      ;
                       BEQ CODE_81821D                      ;818218;81821D;
                       JMP.W CODE_81836C                    ;81821A;81836C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81821D: %Set16bit(!MX)                             ;81821D;      ;
                       LDA.W #$00A1                         ;81821F;      ;
                       LDX.W $09AD                          ;818222;0009AD;
                       LDY.W $09AF                          ;818225;0009AF;
                       JSL.L EditTileonMap                    ;818228;82B03A;
                                                            ;      ;      ;
          CODE_81822C: JSR.W CODE_8188E5                    ;81822C;8188E5;
                       %Set8bit(!M)                             ;81822F;      ;
                       %Set16bit(!X)                             ;818231;      ;
                       LDA.W $0976                          ;818233;000976;
                       CMP.B #$03                           ;818236;      ;
                       BNE CODE_81823D                      ;818238;81823D;
                       JMP.W CODE_81835E                    ;81823A;81835E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81823D: RTS                                  ;81823D;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81823E;      ;
                       LDA.L $7F1F74                        ;818240;7F1F74;
                       AND.W #$0020                         ;818244;      ;
                       BEQ CODE_81824C                      ;818247;81824C;
                       JMP.W CODE_818337                    ;818249;818337;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81824C: %Set8bit(!M)                             ;81824C;      ;
                       %Set16bit(!X)                             ;81824E;      ;
                       LDA.W $0976                          ;818250;000976;
                       BNE CODE_81826E                      ;818253;81826E;
                       LDA.W $09AC                          ;818255;0009AC;
                       CMP.B #$02                           ;818258;      ;
                       BEQ CODE_81825F                      ;81825A;81825F;
                       JMP.W CODE_81836C                    ;81825C;81836C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81825F: %Set16bit(!MX)                             ;81825F;      ;
                       LDA.W #$00A1                         ;818261;      ;
                       LDX.W $09AD                          ;818264;0009AD;
                       LDY.W $09AF                          ;818267;0009AF;
                       JSL.L EditTileonMap                    ;81826A;82B03A;
                                                            ;      ;      ;
          CODE_81826E: JSR.W CODE_8188E5                    ;81826E;8188E5;
                       %Set8bit(!M)                             ;818271;      ;
                       %Set16bit(!X)                             ;818273;      ;
                       LDA.W $0976                          ;818275;000976;
                       CMP.B #$03                           ;818278;      ;
                       BNE CODE_81827F                      ;81827A;81827F;
                       JMP.W CODE_81835E                    ;81827C;81835E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81827F: RTS                                  ;81827F;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;818280;      ;
                       LDA.L $7F1F74                        ;818282;7F1F74;
                       AND.W #$0020                         ;818286;      ;
                       BEQ CODE_81828E                      ;818289;81828E;
                       JMP.W CODE_818337                    ;81828B;818337;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81828E: %Set8bit(!M)                             ;81828E;      ;
                       %Set16bit(!X)                             ;818290;      ;
                       LDA.W $0976                          ;818292;000976;
                       BNE CODE_8182B0                      ;818295;8182B0;
                       LDA.W $09AC                          ;818297;0009AC;
                       CMP.B #$03                           ;81829A;      ;
                       BEQ CODE_8182A1                      ;81829C;8182A1;
                       JMP.W CODE_81836C                    ;81829E;81836C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8182A1: %Set16bit(!MX)                             ;8182A1;      ;
                       LDA.W #$00A1                         ;8182A3;      ;
                       LDX.W $09AD                          ;8182A6;0009AD;
                       LDY.W $09AF                          ;8182A9;0009AF;
                       JSL.L EditTileonMap                    ;8182AC;82B03A;
                                                            ;      ;      ;
          CODE_8182B0: JSR.W CODE_8188E5                    ;8182B0;8188E5;
                       %Set8bit(!M)                             ;8182B3;      ;
                       %Set16bit(!X)                             ;8182B5;      ;
                       LDA.W $0976                          ;8182B7;000976;
                       CMP.B #$03                           ;8182BA;      ;
                       BNE CODE_8182C1                      ;8182BC;8182C1;
                       JMP.W CODE_81835E                    ;8182BE;81835E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8182C1: RTS                                  ;8182C1;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8182C2;      ;
                       LDA.L $7F1F74                        ;8182C4;7F1F74;
                       AND.W #$0020                         ;8182C8;      ;
                       BNE CODE_818337                      ;8182CB;818337;
                       %Set8bit(!M)                             ;8182CD;      ;
                       %Set16bit(!X)                             ;8182CF;      ;
                       LDA.W $0976                          ;8182D1;000976;
                       BNE CODE_8182EF                      ;8182D4;8182EF;
                       LDA.W $09AC                          ;8182D6;0009AC;
                       CMP.B #$04                           ;8182D9;      ;
                       BEQ CODE_8182E0                      ;8182DB;8182E0;
                       JMP.W CODE_81836C                    ;8182DD;81836C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8182E0: %Set16bit(!MX)                             ;8182E0;      ;
                       LDA.W #$00A1                         ;8182E2;      ;
                       LDX.W $09AD                          ;8182E5;0009AD;
                       LDY.W $09AF                          ;8182E8;0009AF;
                       JSL.L EditTileonMap                    ;8182EB;82B03A;
                                                            ;      ;      ;
          CODE_8182EF: JSR.W CODE_8188E5                    ;8182EF;8188E5;
                       %Set8bit(!M)                             ;8182F2;      ;
                       %Set16bit(!X)                             ;8182F4;      ;
                       LDA.W $0976                          ;8182F6;000976;
                       CMP.B #$03                           ;8182F9;      ;
                       BEQ CODE_81835E                      ;8182FB;81835E;
                       RTS                                  ;8182FD;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;8182FE;      ;
                       LDA.L $7F1F74                        ;818300;7F1F74;
                       AND.W #$0020                         ;818304;      ;
                       BNE CODE_818337                      ;818307;818337;
                       %Set8bit(!M)                             ;818309;      ;
                       %Set16bit(!X)                             ;81830B;      ;
                       LDA.W $0976                          ;81830D;000976;
                       BNE CODE_818328                      ;818310;818328;
                       LDA.W $09AC                          ;818312;0009AC;
                       CMP.B #$05                           ;818315;      ;
                       BNE CODE_81836C                      ;818317;81836C;
                       %Set16bit(!MX)                             ;818319;      ;
                       LDA.W #$00A1                         ;81831B;      ;
                       LDX.W $09AD                          ;81831E;0009AD;
                       LDY.W $09AF                          ;818321;0009AF;
                       JSL.L EditTileonMap                    ;818324;82B03A;
                                                            ;      ;      ;
          CODE_818328: JSR.W CODE_8188E5                    ;818328;8188E5;
                       %Set8bit(!M)                             ;81832B;      ;
                       %Set16bit(!X)                             ;81832D;      ;
                       LDA.W $0976                          ;81832F;000976;
                       CMP.B #$03                           ;818332;      ;
                       BEQ CODE_81835E                      ;818334;81835E;
                       RTS                                  ;818336;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818337: %Set16bit(!MX)                             ;818337;      ;
                       LDA.W $0978                          ;818339;000978;
                       STA.B $A5                            ;81833C;0000A5;
                       JSL.L CODE_8581A2                    ;81833E;8581A2;
                       JSL.L CODE_81A4F1                    ;818342;81A4F1;
                       %Set8bit(!M)                             ;818346;      ;
                       STZ.W !item_on_hand                          ;818348;00091D;
                       %Set16bit(!MX)                             ;81834B;      ;
                       LDA.W #$0000                         ;81834D;      ;
                       STA.B !player_action                            ;818350;0000D4;
                       %Set16bit(!MX)                             ;818352;      ;
                       LDA.W #$0002                         ;818354;      ;
                       EOR.W #$FFFF                         ;818357;      ;
                       AND.B !game_state                            ;81835A;0000D2;
                       STA.B !game_state                            ;81835C;0000D2;
                                                            ;      ;      ;
          CODE_81835E: %Set16bit(!MX)                             ;81835E;      ;
                       LDA.L $7F1F74                        ;818360;7F1F74;
                       ORA.W #$0040                         ;818364;      ;
                       STA.L $7F1F74                        ;818367;7F1F74;
                       RTS                                  ;81836B;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81836C: %Set16bit(!MX)                             ;81836C;      ;
                       LDA.W #$00FC                         ;81836E;      ;
                       LDX.W $09AD                          ;818371;0009AD;
                       LDY.W $09AF                          ;818374;0009AF;
                       JSL.L CODE_81A688                    ;818377;81A688;
                       %Set16bit(!MX)                             ;81837B;      ;
                       LDA.W $0978                          ;81837D;000978;
                       STA.B $A5                            ;818380;0000A5;
                       JSL.L CODE_8581A2                    ;818382;8581A2;
                       JSL.L CODE_81A4F1                    ;818386;81A4F1;
                       %Set8bit(!M)                             ;81838A;      ;
                       STZ.W !item_on_hand                          ;81838C;00091D;
                       %Set16bit(!MX)                             ;81838F;      ;
                       LDA.W #$0000                         ;818391;      ;
                       STA.B !player_action                            ;818394;0000D4;
                       %Set16bit(!MX)                             ;818396;      ;
                       LDA.W #$0002                         ;818398;      ;
                       EOR.W #$FFFF                         ;81839B;      ;
                       AND.B !game_state                            ;81839E;0000D2;
                       STA.B !game_state                            ;8183A0;0000D2;
                       %Set8bit(!M)                             ;8183A2;      ;
                       LDA.B #$02                           ;8183A4;      ;
                       STA.W !inputstate                          ;8183A6;00019A;
                       LDX.W #$038D                         ;8183A9;      ;
                       LDA.B #$00                           ;8183AC;      ;
                       STA.W $0191                          ;8183AE;000191;
                       JSL.L StartTextBox                    ;8183B1;83935F;
                       RTS                                  ;8183B5;      ;
                                                            ;      ;      ;
                       RTS                                  ;8183B6;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;8183B7;8188E5;
                       RTS                                  ;8183BA;      ;
                                                            ;      ;      ;
                       JSR.W CODE_81883A                    ;8183BB;81883A;
                       RTS                                  ;8183BE;      ;
                                                            ;      ;      ;
                       JSR.W CODE_81883A                    ;8183BF;81883A;
                       RTS                                  ;8183C2;      ;
                                                            ;      ;      ;
                       RTS                                  ;8183C3;      ;
                                                            ;      ;      ;
                       RTS                                  ;8183C4;      ;
                                                            ;      ;      ;
                       JSR.W CODE_81883A                    ;8183C5;81883A;
                       RTS                                  ;8183C8;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183C9;81A94A;
                       JSR.W CODE_8187C3                    ;8183CD;8187C3;
                       RTS                                  ;8183D0;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183D1;81A94A;
                       JSR.W CODE_8187C3                    ;8183D5;8187C3;
                       RTS                                  ;8183D8;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183D9;81A94A;
                       JSR.W CODE_8187C3                    ;8183DD;8187C3;
                       RTS                                  ;8183E0;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183E1;81A94A;
                       JSR.W CODE_8187C3                    ;8183E5;8187C3;
                       RTS                                  ;8183E8;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183E9;81A94A;
                       JSR.W CODE_8187C3                    ;8183ED;8187C3;
                       RTS                                  ;8183F0;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183F1;81A94A;
                       JSR.W CODE_8187C3                    ;8183F5;8187C3;
                       RTS                                  ;8183F8;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;8183F9;81A94A;
                       JSR.W CODE_8187C3                    ;8183FD;8187C3;
                       RTS                                  ;818400;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818401;81A94A;
                       JSR.W CODE_8187C3                    ;818405;8187C3;
                       RTS                                  ;818408;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818409;81A94A;
                       JSR.W CODE_8187C3                    ;81840D;8187C3;
                       RTS                                  ;818410;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818411;81A94A;
                       JSR.W CODE_8187C3                    ;818415;8187C3;
                       RTS                                  ;818418;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818419;81A94A;
                       JSR.W CODE_8187C3                    ;81841D;8187C3;
                       RTS                                  ;818420;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818421;81A94A;
                       JSR.W CODE_8187C3                    ;818425;8187C3;
                       RTS                                  ;818428;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818429;81A94A;
                       JSR.W CODE_8187C3                    ;81842D;8187C3;
                       RTS                                  ;818430;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818431;81A94A;
                       JSR.W CODE_8187C3                    ;818435;8187C3;
                       RTS                                  ;818438;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818439;81A94A;
                       JSR.W CODE_8187C3                    ;81843D;8187C3;
                       RTS                                  ;818440;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818441;81A94A;
                       JSR.W CODE_8187C3                    ;818445;8187C3;
                       RTS                                  ;818448;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818449;81A94A;
                       JSR.W CODE_8187C3                    ;81844D;8187C3;
                       RTS                                  ;818450;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818451;81A94A;
                       JSR.W CODE_8187C3                    ;818455;8187C3;
                       RTS                                  ;818458;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818459;81A94A;
                       JSR.W CODE_8187C3                    ;81845D;8187C3;
                       RTS                                  ;818460;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818461;81A94A;
                       JSR.W CODE_8187C3                    ;818465;8187C3;
                       RTS                                  ;818468;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818469;81A94A;
                       JSR.W CODE_8187C3                    ;81846D;8187C3;
                       RTS                                  ;818470;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818471;81A94A;
                       JSR.W CODE_8187C3                    ;818475;8187C3;
                       RTS                                  ;818478;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818479;81A94A;
                       JSR.W CODE_8187C3                    ;81847D;8187C3;
                       RTS                                  ;818480;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818481;81A94A;
                       JSR.W CODE_8187C3                    ;818485;8187C3;
                       RTS                                  ;818488;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818489;81A94A;
                       JSR.W CODE_8187C3                    ;81848D;8187C3;
                       RTS                                  ;818490;      ;
                                                            ;      ;      ;
                       JSL.L CODE_81A94A                    ;818491;81A94A;
                       JSR.W CODE_8187C3                    ;818495;8187C3;
                       RTS                                  ;818498;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818499;818923;
                       %Set8bit(!M)                             ;81849C;      ;
                       LDA.W $0976                          ;81849E;000976;
                       CMP.B #$FF                           ;8184A1;      ;
                       BNE CODE_8184D4                      ;8184A3;8184D4;
                       LDA.L !shed_items_row_2                        ;8184A5;7F1F01;
                       ORA.B #$08                           ;8184A9;      ;
                       STA.L !shed_items_row_2                        ;8184AB;7F1F01;
                       %Set8bit(!M)                             ;8184AF;      ;
                       LDA.W !tool_selected                          ;8184B1;000921;
                       CMP.B #$0C                           ;8184B4;      ;
                       BNE CODE_8184BB                      ;8184B6;8184BB;
                       STZ.W !tool_selected                          ;8184B8;000921;
                                                            ;      ;      ;
          CODE_8184BB: %Set8bit(!M)                             ;8184BB;      ;
                       LDA.W !tool_backpack                          ;8184BD;000923;
                       CMP.B #$0C                           ;8184C0;      ;
                       BNE CODE_8184C7                      ;8184C2;8184C7;
                       STZ.W !tool_backpack                          ;8184C4;000923;
                                                            ;      ;      ;
          CODE_8184C7: %Set8bit(!M)                             ;8184C7;      ;
                       LDA.W !seeds_grass_N                          ;8184C9;000927;
                       CMP.B #$FF                           ;8184CC;      ;
                       BEQ CODE_8184D4                      ;8184CE;8184D4;
                       INC A                                ;8184D0;      ;
                       STA.W !seeds_grass_N                          ;8184D1;000927;
                                                            ;      ;      ;
          CODE_8184D4: RTS                                  ;8184D4;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8184D5;818923;
                       %Set8bit(!M)                             ;8184D8;      ;
                       LDA.W $0976                          ;8184DA;000976;
                       CMP.B #$FF                           ;8184DD;      ;
                       BNE CODE_818510                      ;8184DF;818510;
                       LDA.L !shed_items_row_1                        ;8184E1;7F1F00;
                       ORA.B #$10                           ;8184E5;      ;
                       STA.L !shed_items_row_1                        ;8184E7;7F1F00;
                       %Set8bit(!M)                             ;8184EB;      ;
                       LDA.W !tool_selected                          ;8184ED;000921;
                       CMP.B #$05                           ;8184F0;      ;
                       BNE CODE_8184F7                      ;8184F2;8184F7;
                       STZ.W !tool_selected                          ;8184F4;000921;
                                                            ;      ;      ;
          CODE_8184F7: %Set8bit(!M)                             ;8184F7;      ;
                       LDA.W !tool_backpack                          ;8184F9;000923;
                       CMP.B #$05                           ;8184FC;      ;
                       BNE CODE_818503                      ;8184FE;818503;
                       STZ.W !tool_backpack                          ;818500;000923;
                                                            ;      ;      ;
          CODE_818503: %Set8bit(!M)                             ;818503;      ;
                       LDA.W !seeds_corn_N                          ;818505;000928;
                       CMP.B #$FF                           ;818508;      ;
                       BEQ CODE_818510                      ;81850A;818510;
                       INC A                                ;81850C;      ;
                       STA.W !seeds_corn_N                          ;81850D;000928;
                                                            ;      ;      ;
          CODE_818510: RTS                                  ;818510;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818511;818923;
                       %Set8bit(!M)                             ;818514;      ;
                       LDA.W $0976                          ;818516;000976;
                       CMP.B #$FF                           ;818519;      ;
                       BNE CODE_81854C                      ;81851B;81854C;
                       LDA.L !shed_items_row_1                        ;81851D;7F1F00;
                       ORA.B #$20                           ;818521;      ;
                       STA.L !shed_items_row_1                        ;818523;7F1F00;
                       %Set8bit(!M)                             ;818527;      ;
                       LDA.W !tool_selected                          ;818529;000921;
                       CMP.B #$06                           ;81852C;      ;
                       BNE CODE_818533                      ;81852E;818533;
                       STZ.W !tool_selected                          ;818530;000921;
                                                            ;      ;      ;
          CODE_818533: %Set8bit(!M)                             ;818533;      ;
                       LDA.W !tool_backpack                          ;818535;000923;
                       CMP.B #$06                           ;818538;      ;
                       BNE CODE_81853F                      ;81853A;81853F;
                       STZ.W !tool_backpack                          ;81853C;000923;
                                                            ;      ;      ;
          CODE_81853F: %Set8bit(!M)                             ;81853F;      ;
                       LDA.W !seeds_tomato_N                          ;818541;000929;
                       CMP.B #$FF                           ;818544;      ;
                       BEQ CODE_81854C                      ;818546;81854C;
                       INC A                                ;818548;      ;
                       STA.W !seeds_tomato_N                          ;818549;000929;
                                                            ;      ;      ;
          CODE_81854C: RTS                                  ;81854C;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;81854D;818923;
                       %Set8bit(!M)                             ;818550;      ;
                       LDA.W $0976                          ;818552;000976;
                       CMP.B #$FF                           ;818555;      ;
                       BNE CODE_818588                      ;818557;818588;
                       LDA.L !shed_items_row_1                        ;818559;7F1F00;
                       ORA.B #$40                           ;81855D;      ;
                       STA.L !shed_items_row_1                        ;81855F;7F1F00;
                       %Set8bit(!M)                             ;818563;      ;
                       LDA.W !tool_selected                          ;818565;000921;
                       CMP.B #$07                           ;818568;      ;
                       BNE CODE_81856F                      ;81856A;81856F;
                       STZ.W !tool_selected                          ;81856C;000921;
                                                            ;      ;      ;
          CODE_81856F: %Set8bit(!M)                             ;81856F;      ;
                       LDA.W !tool_backpack                          ;818571;000923;
                       CMP.B #$07                           ;818574;      ;
                       BNE CODE_81857B                      ;818576;81857B;
                       STZ.W !tool_backpack                          ;818578;000923;
                                                            ;      ;      ;
          CODE_81857B: %Set8bit(!M)                             ;81857B;      ;
                       LDA.W !seeds_potato_N                          ;81857D;00092A;
                       CMP.B #$FF                           ;818580;      ;
                       BEQ CODE_818588                      ;818582;818588;
                       INC A                                ;818584;      ;
                       STA.W !seeds_potato_N                          ;818585;00092A;
                                                            ;      ;      ;
          CODE_818588: RTS                                  ;818588;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818589;818923;
                       %Set8bit(!M)                             ;81858C;      ;
                       LDA.W $0976                          ;81858E;000976;
                       CMP.B #$FF                           ;818591;      ;
                       BNE CODE_8185C4                      ;818593;8185C4;
                       LDA.L !shed_items_row_1                        ;818595;7F1F00;
                       ORA.B #$80                           ;818599;      ;
                       STA.L !shed_items_row_1                        ;81859B;7F1F00;
                       %Set8bit(!M)                             ;81859F;      ;
                       LDA.W !tool_selected                          ;8185A1;000921;
                       CMP.B #$08                           ;8185A4;      ;
                       BNE CODE_8185AB                      ;8185A6;8185AB;
                       STZ.W !tool_selected                          ;8185A8;000921;
                                                            ;      ;      ;
          CODE_8185AB: %Set8bit(!M)                             ;8185AB;      ;
                       LDA.W !tool_backpack                          ;8185AD;000923;
                       CMP.B #$08                           ;8185B0;      ;
                       BNE CODE_8185B7                      ;8185B2;8185B7;
                       STZ.W !tool_backpack                          ;8185B4;000923;
                                                            ;      ;      ;
          CODE_8185B7: %Set8bit(!M)                             ;8185B7;      ;
                       LDA.W !seeds_turnip_N                          ;8185B9;00092B;
                       CMP.B #$FF                           ;8185BC;      ;
                       BEQ CODE_8185C4                      ;8185BE;8185C4;
                       INC A                                ;8185C0;      ;
                       STA.W !seeds_turnip_N                          ;8185C1;00092B;
                                                            ;      ;      ;
          CODE_8185C4: RTS                                  ;8185C4;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8185C5;818923;
                       %Set8bit(!M)                             ;8185C8;      ;
                       LDA.W $0976                          ;8185CA;000976;
                       CMP.B #$FF                           ;8185CD;      ;
                       BNE CODE_8185DE                      ;8185CF;8185DE;
                       %Set8bit(!M)                             ;8185D1;      ;
                       STZ.W $0976                          ;8185D3;000976;
                       LDA.B #$19                           ;8185D6;      ;
                       STA.W $0984                          ;8185D8;000984;
                       STA.W !item_on_hand                          ;8185DB;00091D;
                                                            ;      ;      ;
          CODE_8185DE: RTS                                  ;8185DE;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8185DF;818923;
                       %Set8bit(!M)                             ;8185E2;      ;
                       LDA.W $0976                          ;8185E4;000976;
                       CMP.B #$FF                           ;8185E7;      ;
                       BNE CODE_8185F5                      ;8185E9;8185F5;
                       LDA.L !shed_items_row_2                        ;8185EB;7F1F01;
                       ORA.B #$10                           ;8185EF;      ;
                       STA.L !shed_items_row_2                        ;8185F1;7F1F01;
                                                            ;      ;      ;
          CODE_8185F5: RTS                                  ;8185F5;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8185F6;818923;
                       %Set8bit(!M)                             ;8185F9;      ;
                       LDA.W $0976                          ;8185FB;000976;
                       CMP.B #$FF                           ;8185FE;      ;
                       BNE CODE_81860C                      ;818600;81860C;
                       LDA.L !shed_items_row_2                        ;818602;7F1F01;
                       ORA.B #$20                           ;818606;      ;
                       STA.L !shed_items_row_2                        ;818608;7F1F01;
                                                            ;      ;      ;
          CODE_81860C: RTS                                  ;81860C;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;81860D;818923;
                       %Set8bit(!M)                             ;818610;      ;
                       LDA.W $0976                          ;818612;000976;
                       CMP.B #$FF                           ;818615;      ;
                       BNE CODE_818623                      ;818617;818623;
                       LDA.L !shed_items_row_2                        ;818619;7F1F01;
                       ORA.B #$40                           ;81861D;      ;
                       STA.L !shed_items_row_2                        ;81861F;7F1F01;
                                                            ;      ;      ;
          CODE_818623: RTS                                  ;818623;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818624;818923;
                       %Set8bit(!M)                             ;818627;      ;
                       LDA.W $0976                          ;818629;000976;
                       CMP.B #$FF                           ;81862C;      ;
                       BNE CODE_81865A                      ;81862E;81865A;
                       LDA.L !shed_items_row_3                        ;818630;7F1F02;
                       ORA.B #$01                           ;818634;      ;
                       STA.L !shed_items_row_3                        ;818636;7F1F02;
                       LDA.L !shed_items_row_1                        ;81863A;7F1F00;
                       AND.B #$FE                           ;81863E;      ;
                       STA.L !shed_items_row_1                        ;818640;7F1F00;
                       LDA.W !tool_selected                          ;818644;000921;
                       CMP.B #$01                           ;818647;      ;
                       BNE CODE_81864E                      ;818649;81864E;
                       STZ.W !tool_selected                          ;81864B;000921;
                                                            ;      ;      ;
          CODE_81864E: %Set8bit(!M)                             ;81864E;      ;
                       LDA.W !tool_backpack                          ;818650;000923;
                       CMP.B #$01                           ;818653;      ;
                       BNE CODE_81865A                      ;818655;81865A;
                       STZ.W !tool_backpack                          ;818657;000923;
                                                            ;      ;      ;
          CODE_81865A: RTS                                  ;81865A;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;81865B;818923;
                       %Set8bit(!M)                             ;81865E;      ;
                       LDA.W $0976                          ;818660;000976;
                       CMP.B #$FF                           ;818663;      ;
                       BNE CODE_818691                      ;818665;818691;
                       LDA.L !shed_items_row_3                        ;818667;7F1F02;
                       ORA.B #$02                           ;81866B;      ;
                       STA.L !shed_items_row_3                        ;81866D;7F1F02;
                       LDA.L !shed_items_row_1                        ;818671;7F1F00;
                       AND.B #$FD                           ;818675;      ;
                       STA.L !shed_items_row_1                        ;818677;7F1F00;
                       LDA.W !tool_selected                          ;81867B;000921;
                       CMP.B #$02                           ;81867E;      ;
                       BNE CODE_818685                      ;818680;818685;
                       STZ.W !tool_selected                          ;818682;000921;
                                                            ;      ;      ;
          CODE_818685: %Set8bit(!M)                             ;818685;      ;
                       LDA.W !tool_backpack                          ;818687;000923;
                       CMP.B #$02                           ;81868A;      ;
                       BNE CODE_818691                      ;81868C;818691;
                       STZ.W !tool_backpack                          ;81868E;000923;
                                                            ;      ;      ;
          CODE_818691: RTS                                  ;818691;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818692;818923;
                       %Set8bit(!M)                             ;818695;      ;
                       LDA.W $0976                          ;818697;000976;
                       CMP.B #$FF                           ;81869A;      ;
                       BNE CODE_8186C8                      ;81869C;8186C8;
                       LDA.L !shed_items_row_3                        ;81869E;7F1F02;
                       ORA.B #$04                           ;8186A2;      ;
                       STA.L !shed_items_row_3                        ;8186A4;7F1F02;
                       LDA.L !shed_items_row_1                        ;8186A8;7F1F00;
                       AND.B #$FB                           ;8186AC;      ;
                       STA.L !shed_items_row_1                        ;8186AE;7F1F00;
                       LDA.W !tool_selected                          ;8186B2;000921;
                       CMP.B #$03                           ;8186B5;      ;
                       BNE CODE_8186BC                      ;8186B7;8186BC;
                       STZ.W !tool_selected                          ;8186B9;000921;
                                                            ;      ;      ;
          CODE_8186BC: %Set8bit(!M)                             ;8186BC;      ;
                       LDA.W !tool_backpack                          ;8186BE;000923;
                       CMP.B #$03                           ;8186C1;      ;
                       BNE CODE_8186C8                      ;8186C3;8186C8;
                       STZ.W !tool_backpack                          ;8186C5;000923;
                                                            ;      ;      ;
          CODE_8186C8: RTS                                  ;8186C8;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;8186C9;818923;
                       %Set8bit(!M)                             ;8186CC;      ;
                       LDA.W $0976                          ;8186CE;000976;
                       CMP.B #$FF                           ;8186D1;      ;
                       BNE CODE_8186FF                      ;8186D3;8186FF;
                       LDA.L !shed_items_row_3                        ;8186D5;7F1F02;
                       ORA.B #$08                           ;8186D9;      ;
                       STA.L !shed_items_row_3                        ;8186DB;7F1F02;
                       LDA.L !shed_items_row_1                        ;8186DF;7F1F00;
                       AND.B #!OBJ_Offset_Y                          ;8186E3;      ;
                       STA.L !shed_items_row_1                        ;8186E5;7F1F00;
                       LDA.W !tool_selected                          ;8186E9;000921;
                       CMP.B #$04                           ;8186EC;      ;
                       BNE CODE_8186F3                      ;8186EE;8186F3;
                       STZ.W !tool_selected                          ;8186F0;000921;
                                                            ;      ;      ;
          CODE_8186F3: %Set8bit(!M)                             ;8186F3;      ;
                       LDA.W !tool_backpack                          ;8186F5;000923;
                       CMP.B #$04                           ;8186F8;      ;
                       BNE CODE_8186FF                      ;8186FA;8186FF;
                       STZ.W !tool_backpack                          ;8186FC;000923;
                                                            ;      ;      ;
          CODE_8186FF: RTS                                  ;8186FF;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818700;818923;
                       %Set8bit(!M)                             ;818703;      ;
                       LDA.W $0976                          ;818705;000976;
                       CMP.B #$FF                           ;818708;      ;
                       BNE CODE_818736                      ;81870A;818736;
                       LDA.L !shed_items_row_3                        ;81870C;7F1F02;
                       ORA.B #$10                           ;818710;      ;
                       STA.L !shed_items_row_3                        ;818712;7F1F02;
                       LDA.L !shed_items_row_2                        ;818716;7F1F01;
                       AND.B #$7F                           ;81871A;      ;
                       STA.L !shed_items_row_2                        ;81871C;7F1F01;
                       LDA.W !tool_selected                          ;818720;000921;
                       CMP.B #$10                           ;818723;      ;
                       BNE CODE_81872A                      ;818725;81872A;
                       STZ.W !tool_selected                          ;818727;000921;
                                                            ;      ;      ;
          CODE_81872A: %Set8bit(!M)                             ;81872A;      ;
                       LDA.W !tool_backpack                          ;81872C;000923;
                       CMP.B #$10                           ;81872F;      ;
                       BNE CODE_818736                      ;818731;818736;
                       STZ.W !tool_backpack                          ;818733;000923;
                                                            ;      ;      ;
          CODE_818736: RTS                                  ;818736;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818737;818923;
                       %Set8bit(!M)                             ;81873A;      ;
                       LDA.W $0976                          ;81873C;000976;
                       CMP.B #$FF                           ;81873F;      ;
                       BNE CODE_81874D                      ;818741;81874D;
                       LDA.L !shed_items_row_2                        ;818743;7F1F01;
                       ORA.B #$01                           ;818747;      ;
                       STA.L !shed_items_row_2                        ;818749;7F1F01;
                                                            ;      ;      ;
          CODE_81874D: RTS                                  ;81874D;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;81874E;818923;
                       %Set8bit(!M)                             ;818751;      ;
                       LDA.W $0976                          ;818753;000976;
                       CMP.B #$FF                           ;818756;      ;
                       BNE CODE_818764                      ;818758;818764;
                       LDA.L !shed_items_row_2                        ;81875A;7F1F01;
                       ORA.B #$02                           ;81875E;      ;
                       STA.L !shed_items_row_2                        ;818760;7F1F01;
                                                            ;      ;      ;
          CODE_818764: RTS                                  ;818764;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818765;818923;
                       %Set8bit(!M)                             ;818768;      ;
                       LDA.W $0976                          ;81876A;000976;
                       CMP.B #$FF                           ;81876D;      ;
                       BNE CODE_818780                      ;81876F;818780;
                       LDA.L !shed_items_row_4                        ;818771;7F1F03;
                       ORA.B #$01                           ;818775;      ;
                       STA.L !shed_items_row_4                        ;818777;7F1F03;
                       LDA.B #$0C                           ;81877B;      ;
                       STA.W !feed_chicks_N                          ;81877D;00092D;
                                                            ;      ;      ;
          CODE_818780: RTS                                  ;818780;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;818781;818923;
                       %Set8bit(!M)                             ;818784;      ;
                       LDA.W $0976                          ;818786;000976;
                       CMP.B #$FF                           ;818789;      ;
                       BNE CODE_81879C                      ;81878B;81879C;
                       LDA.L !shed_items_row_4                        ;81878D;7F1F03;
                       ORA.B #$02                           ;818791;      ;
                       STA.L !shed_items_row_4                        ;818793;7F1F03;
                       LDA.B #$0C                           ;818797;      ;
                       STA.W !feed_cow_N                          ;818799;00092C;
                                                            ;      ;      ;
          CODE_81879C: RTS                                  ;81879C;      ;
                                                            ;      ;      ;
                       JSR.W CODE_818923                    ;81879D;818923;
                       %Set8bit(!M)                             ;8187A0;      ;
                       LDA.W $0976                          ;8187A2;000976;
                       CMP.B #$FF                           ;8187A5;      ;
                       BNE CODE_8187B6                      ;8187A7;8187B6;
                       %Set8bit(!M)                             ;8187A9;      ;
                       STZ.W $0976                          ;8187AB;000976;
                       LDA.B #$06                           ;8187AE;      ;
                       STA.W $0984                          ;8187B0;000984;
                       STA.W !item_on_hand                          ;8187B3;00091D;
                                                            ;      ;      ;
          CODE_8187B6: RTS                                  ;8187B6;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;8187B7;8188E5;
                       RTS                                  ;8187BA;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;8187BB;8188E5;
                       RTS                                  ;8187BE;      ;
                                                            ;      ;      ;
                       JSR.W CODE_8188E5                    ;8187BF;8188E5;
                       RTS                                  ;8187C2;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8187C3: %Set8bit(!M)                             ;8187C3;      ;
                       %Set16bit(!X)                             ;8187C5;      ;
                       LDA.W !tool_backpack                          ;8187C7;000923;
                       BNE CODE_8187D2                      ;8187CA;8187D2;
                       LDA.W !tool_selected                          ;8187CC;000921;
                       STA.W !tool_backpack                          ;8187CF;000923;
                                                            ;      ;      ;
          CODE_8187D2: %Set8bit(!M)                             ;8187D2;      ;
                       LDA.B #$00                           ;8187D4;      ;
                       XBA                                  ;8187D6;      ;
                       LDA.W $0984                          ;8187D7;000984;
                       SEC                                  ;8187DA;      ;
                       SBC.B #$29                           ;8187DB;      ;
                       STA.W !tool_selected                          ;8187DD;000921;
                       %Set16bit(!M)                             ;8187E0;      ;
                       ASL A                                ;8187E2;      ;
                       ASL A                                ;8187E3;      ;
                       ASL A                                ;8187E4;      ;
                       CLC                                  ;8187E5;      ;
                       ADC.W #$0006                         ;8187E6;      ;
                       TAX                                  ;8187E9;      ;
                       %Set8bit(!M)                             ;8187EA;      ;
                       LDA.L DATA16_81BE0F,X                ;8187EC;81BE0F;
                       PHA                                  ;8187F0;      ;
                       INX                                  ;8187F1;      ;
                       LDA.L DATA16_81BE0F,X                ;8187F2;81BE0F;
                       EOR.B #$FF                           ;8187F6;      ;
                       STA.B $92                            ;8187F8;000092;
                       PLA                                  ;8187FA;      ;
                       XBA                                  ;8187FB;      ;
                       LDA.B #$00                           ;8187FC;      ;
                       XBA                                  ;8187FE;      ;
                       %Set16bit(!M)                             ;8187FF;      ;
                       TAX                                  ;818801;      ;
                       %Set8bit(!M)                             ;818802;      ;
                       LDA.L !shed_items_row_1,X                      ;818804;7F1F00;
                       AND.B $92                            ;818808;000092;
                       STA.L !shed_items_row_1,X                      ;81880A;7F1F00;
                       %Set16bit(!MX)                             ;81880E;      ;
                       LDA.W #$0000                         ;818810;      ;
                       STA.B !player_action                            ;818813;0000D4;
                       %Set16bit(!MX)                             ;818815;      ;
                       LDA.W #$0002                         ;818817;      ;
                       EOR.W #$FFFF                         ;81881A;      ;
                       AND.B !game_state                            ;81881D;0000D2;
                       STA.B !game_state                            ;81881F;0000D2;
                       %Set16bit(!M)                             ;818821;      ;
                       LDA.W $0978                          ;818823;000978;
                       STA.B $A5                            ;818826;0000A5;
                       JSL.L CODE_8581A2                    ;818828;8581A2;
                       JSL.L CODE_81A4F1                    ;81882C;81A4F1;
                       %Set8bit(!M)                             ;818830;      ;
                       STZ.W !item_on_hand                          ;818832;00091D;
                       JSL.L ToolUsedSound2                          ;818835;828FF3;
                       RTS                                  ;818839;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81883A: %Set8bit(!M)                             ;81883A;      ;
                       %Set16bit(!X)                             ;81883C;      ;
                       LDA.W $0976                          ;81883E;000976;
                       BNE CODE_818846                      ;818841;818846;
                       JMP.W CODE_819010                    ;818843;819010;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818846: CMP.B #$02                           ;818846;      ;
                       BNE CODE_81884D                      ;818848;81884D;
                       JMP.W CODE_819228                    ;81884A;819228;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81884D: CMP.B #$03                           ;81884D;      ;
                       BNE CODE_818854                      ;81884F;818854;
                       JMP.W CODE_818E1B                    ;818851;818E1B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818854: RTS                                  ;818854;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818855: %Set8bit(!M)                             ;818855;      ;
                       %Set16bit(!X)                             ;818857;      ;
                       LDA.W $0976                          ;818859;000976;
                       BNE CODE_818861                      ;81885C;818861;
                       JMP.W CODE_818B6B                    ;81885E;818B6B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818861: CMP.B #$01                           ;818861;      ;
                       BNE CODE_818868                      ;818863;818868;
                       JMP.W CODE_818BA5                    ;818865;818BA5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818868: CMP.B #$02                           ;818868;      ;
                       BNE CODE_81886F                      ;81886A;81886F;
                       JMP.W CODE_819049                    ;81886C;819049;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81886F: CMP.B #$03                           ;81886F;      ;
                       BNE CODE_818876                      ;818871;818876;
                       JMP.W CODE_819379                    ;818873;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818876: CMP.B #$04                           ;818876;      ;
                       BNE CODE_81887D                      ;818878;81887D;
                       JMP.W CODE_81968F                    ;81887A;81968F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81887D: CMP.B #$05                           ;81887D;      ;
                       BNE CODE_818884                      ;81887F;818884;
                       JMP.W CODE_818F2A                    ;818881;818F2A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818884: CMP.B #$06                           ;818884;      ;
                       BNE CODE_81888B                      ;818886;81888B;
                       JMP.W CODE_818F5A                    ;818888;818F5A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81888B: CMP.B #$07                           ;81888B;      ;
                       BNE CODE_818892                      ;81888D;818892;
                       JMP.W CODE_819695                    ;81888F;819695;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818892: CMP.B #$08                           ;818892;      ;
                       BNE CODE_818899                      ;818894;818899;
                       JMP.W CODE_819021                    ;818896;819021;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818899: RTS                                  ;818899;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81889A: %Set8bit(!M)                             ;81889A;      ;
                       %Set16bit(!X)                             ;81889C;      ;
                       LDA.W $0976                          ;81889E;000976;
                       BNE CODE_8188A6                      ;8188A1;8188A6;
                       JMP.W CODE_819010                    ;8188A3;819010;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188A6: CMP.B #$02                           ;8188A6;      ;
                       BNE CODE_8188AD                      ;8188A8;8188AD;
                       JMP.W CODE_818C24                    ;8188AA;818C24;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188AD: CMP.B #$03                           ;8188AD;      ;
                       BNE CODE_8188B4                      ;8188AF;8188B4;
                       JMP.W CODE_818D38                    ;8188B1;818D38;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188B4: CMP.B #$04                           ;8188B4;      ;
                       BNE CODE_8188BB                      ;8188B6;8188BB;
                       JMP.W CODE_818E16                    ;8188B8;818E16;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188BB: RTS                                  ;8188BB;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188BC: %Set8bit(!M)                             ;8188BC;      ;
                       %Set16bit(!X)                             ;8188BE;      ;
                       LDA.W $0976                          ;8188C0;000976;
                       BNE CODE_8188C8                      ;8188C3;8188C8;
                       JMP.W CODE_819010                    ;8188C5;819010;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188C8: CMP.B #$02                           ;8188C8;      ;
                       BNE CODE_8188CF                      ;8188CA;8188CF;
                       JMP.W CODE_819049                    ;8188CC;819049;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188CF: CMP.B #$03                           ;8188CF;      ;
                       BNE CODE_8188D6                      ;8188D1;8188D6;
                       JMP.W CODE_818E98                    ;8188D3;818E98;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188D6: CMP.B #$04                           ;8188D6;      ;
                       BNE CODE_8188DD                      ;8188D8;8188DD;
                       JMP.W CODE_81968F                    ;8188DA;81968F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188DD: CMP.B #$08                           ;8188DD;      ;
                       BNE CODE_8188E4                      ;8188DF;8188E4;
                       JMP.W CODE_819021                    ;8188E1;819021;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188E4: RTS                                  ;8188E4;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188E5: %Set8bit(!M)                             ;8188E5;      ;
                       %Set16bit(!X)                             ;8188E7;      ;
                       LDA.W $0976                          ;8188E9;000976;
                       BNE CODE_8188F1                      ;8188EC;8188F1;
                       JMP.W CODE_819010                    ;8188EE;819010;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188F1: CMP.B #$02                           ;8188F1;      ;
                       BNE CODE_8188F8                      ;8188F3;8188F8;
                       JMP.W CODE_819049                    ;8188F5;819049;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188F8: CMP.B #$03                           ;8188F8;      ;
                       BNE CODE_8188FF                      ;8188FA;8188FF;
                       JMP.W CODE_819379                    ;8188FC;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8188FF: CMP.B #$04                           ;8188FF;      ;
                       BNE CODE_818906                      ;818901;818906;
                       JMP.W CODE_81968F                    ;818903;81968F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818906: CMP.B #$05                           ;818906;      ;
                       BNE CODE_81890D                      ;818908;81890D;
                       JMP.W CODE_818F2A                    ;81890A;818F2A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81890D: CMP.B #$06                           ;81890D;      ;
                       BNE CODE_818914                      ;81890F;818914;
                       JMP.W CODE_818F5A                    ;818911;818F5A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818914: CMP.B #$07                           ;818914;      ;
                       BNE CODE_81891B                      ;818916;81891B;
                       JMP.W CODE_819695                    ;818918;819695;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81891B: CMP.B #$08                           ;81891B;      ;
                       BNE CODE_818922                      ;81891D;818922;
                       JMP.W CODE_819021                    ;81891F;819021;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818922: RTS                                  ;818922;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818923: %Set8bit(!M)                             ;818923;      ;
                       %Set16bit(!X)                             ;818925;      ;
                       LDA.W $0976                          ;818927;000976;
                       BEQ CODE_81893F                      ;81892A;81893F;
                       CMP.B #$01                           ;81892C;      ;
                       BEQ CODE_818989                      ;81892E;818989;
                       CMP.B #$02                           ;818930;      ;
                       BNE CODE_818937                      ;818932;818937;
                       JMP.W CODE_818A94                    ;818934;818A94;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818937: CMP.B #$03                           ;818937;      ;
                       BNE CODE_81893E                      ;818939;81893E;
                       JMP.W CODE_818B19                    ;81893B;818B19;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81893E: RTS                                  ;81893E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81893F: %Set8bit(!M)                             ;81893F;      ;
                       LDA.B #$02                           ;818941;      ;
                       STA.W !inputstate                          ;818943;00019A;
                       %Set8bit(!M)                             ;818946;      ;
                       LDA.W $0984                          ;818948;000984;
                       CMP.B #$44                           ;81894B;      ;
                       BCS CODE_818957                      ;81894D;818957;
                       SEC                                  ;81894F;      ;
                       SBC.B #$1B                           ;818950;      ;
                       CLC                                  ;818952;      ;
                       ADC.B #$13                           ;818953;      ;
                       BRA CODE_818964                      ;818955;818964;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818957: %Set8bit(!M)                             ;818957;      ;
                       %Set16bit(!X)                             ;818959;      ;
                       LDA.B #$00                           ;81895B;      ;
                       XBA                                  ;81895D;      ;
                       LDA.W $0984                          ;81895E;000984;
                       SEC                                  ;818961;      ;
                       SBC.B #$44                           ;818962;      ;
                                                            ;      ;      ;
          CODE_818964: %Set16bit(!M)                             ;818964;      ;
                       STA.B $7E                            ;818966;00007E;
                       ASL A                                ;818968;      ;
                       CLC                                  ;818969;      ;
                       ADC.B $7E                            ;81896A;00007E;
                       ASL A                                ;81896C;      ;
                       ASL A                                ;81896D;      ;
                       TAX                                  ;81896E;      ;
                       LDA.L DATA8_81A1A5,X                 ;81896F;81A1A5;
                       TAX                                  ;818973;      ;
                       %Set8bit(!M)                             ;818974;      ;
                       LDA.B #$00                           ;818976;      ;
                       STA.W $0191                          ;818978;000191;
                       JSL.L StartTextBox                    ;81897B;83935F;
                       %Set8bit(!M)                             ;81897F;      ;
                       LDA.B #$01                           ;818981;      ;
                       STA.W $0976                          ;818983;000976;
                       JMP.W CODE_818B6A                    ;818986;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818989: %Set8bit(!M)                             ;818989;      ;
                       LDA.W !inputstate                          ;81898B;00019A;
                       CMP.B #$02                           ;81898E;      ;
                       BNE CODE_818995                      ;818990;818995;
                       JMP.W CODE_818B6A                    ;818992;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818995: LDA.W $018F                          ;818995;00018F;
                       BEQ CODE_81899D                      ;818998;81899D;
                       JMP.W CODE_818A4E                    ;81899A;818A4E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81899D: %Set8bit(!M)                             ;81899D;      ;
                       LDA.W $0984                          ;81899F;000984;
                       CMP.B #$44                           ;8189A2;      ;
                       BCS CODE_8189AE                      ;8189A4;8189AE;
                       SEC                                  ;8189A6;      ;
                       SBC.B #$1B                           ;8189A7;      ;
                       CLC                                  ;8189A9;      ;
                       ADC.B #$13                           ;8189AA;      ;
                       BRA CODE_8189BB                      ;8189AC;8189BB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8189AE: %Set8bit(!M)                             ;8189AE;      ;
                       %Set16bit(!X)                             ;8189B0;      ;
                       LDA.B #$00                           ;8189B2;      ;
                       XBA                                  ;8189B4;      ;
                       LDA.W $0984                          ;8189B5;000984;
                       SEC                                  ;8189B8;      ;
                       SBC.B #$44                           ;8189B9;      ;
                                                            ;      ;      ;
          CODE_8189BB: %Set16bit(!M)                             ;8189BB;      ;
                       STA.B $7E                            ;8189BD;00007E;
                       ASL A                                ;8189BF;      ;
                       CLC                                  ;8189C0;      ;
                       ADC.B $7E                            ;8189C1;00007E;
                       ASL A                                ;8189C3;      ;
                       ASL A                                ;8189C4;      ;
                       CLC                                  ;8189C5;      ;
                       ADC.W #$0009                         ;8189C6;      ;
                       TAX                                  ;8189C9;      ;
                       LDA.L DATA8_81A1A5,X                 ;8189CA;81A1A5;
                       STA.B $72                            ;8189CE;000072;
                       INX                                  ;8189D0;      ;
                       INX                                  ;8189D1;      ;
                       %Set8bit(!M)                             ;8189D2;      ;
                       LDA.L DATA8_81A1A5,X                 ;8189D4;81A1A5;
                       STA.B $74                            ;8189D8;000074;
                       JSL.L AddMoney                       ;8189DA;83B1C9;
                       %Set16bit(!M)                             ;8189DE;      ;
                       BEQ CODE_8189E9                      ;8189E0;8189E9;
                       LDA.W #$0004                         ;8189E2;      ;
                       STA.B $80                            ;8189E5;000080;
                       BRA CODE_8189EB                      ;8189E7;8189EB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8189E9: STZ.B $80                            ;8189E9;000080;
                                                            ;      ;      ;
          CODE_8189EB: %Set8bit(!M)                             ;8189EB;      ;
                       LDA.B #$02                           ;8189ED;      ;
                       STA.W !inputstate                          ;8189EF;00019A;
                       %Set8bit(!M)                             ;8189F2;      ;
                       LDA.W $0984                          ;8189F4;000984;
                       CMP.B #$44                           ;8189F7;      ;
                       BCS CODE_818A03                      ;8189F9;818A03;
                       SEC                                  ;8189FB;      ;
                       SBC.B #$1B                           ;8189FC;      ;
                       CLC                                  ;8189FE;      ;
                       ADC.B #$13                           ;8189FF;      ;
                       BRA CODE_818A10                      ;818A01;818A10;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818A03: %Set8bit(!M)                             ;818A03;      ;
                       %Set16bit(!X)                             ;818A05;      ;
                       LDA.B #$00                           ;818A07;      ;
                       XBA                                  ;818A09;      ;
                       LDA.W $0984                          ;818A0A;000984;
                       SEC                                  ;818A0D;      ;
                       SBC.B #$44                           ;818A0E;      ;
                                                            ;      ;      ;
          CODE_818A10: %Set16bit(!M)                             ;818A10;      ;
                       STA.B $7E                            ;818A12;00007E;
                       ASL A                                ;818A14;      ;
                       CLC                                  ;818A15;      ;
                       ADC.B $7E                            ;818A16;00007E;
                       ASL A                                ;818A18;      ;
                       ASL A                                ;818A19;      ;
                       CLC                                  ;818A1A;      ;
                       ADC.W #$0002                         ;818A1B;      ;
                       ADC.B $80                            ;818A1E;000080;
                       TAX                                  ;818A20;      ;
                       LDA.L DATA8_81A1A5,X                 ;818A21;81A1A5;
                       TAX                                  ;818A25;      ;
                       %Set8bit(!M)                             ;818A26;      ;
                       LDA.B #$00                           ;818A28;      ;
                       STA.W $0191                          ;818A2A;000191;
                       JSL.L StartTextBox                    ;818A2D;83935F;
                       %Set16bit(!M)                             ;818A31;      ;
                       LDA.B $80                            ;818A33;000080;
                       BEQ CODE_818A3A                      ;818A35;818A3A;
                       JMP.W CODE_818A44                    ;818A37;818A44;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818A3A: %Set8bit(!M)                             ;818A3A;      ;
                       LDA.B #$03                           ;818A3C;      ;
                       STA.W $0976                          ;818A3E;000976;
                       JMP.W CODE_818B6A                    ;818A41;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818A44: %Set8bit(!M)                             ;818A44;      ;
                       LDA.B #$02                           ;818A46;      ;
                       STA.W $0976                          ;818A48;000976;
                       JMP.W CODE_818B6A                    ;818A4B;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818A4E: %Set8bit(!M)                             ;818A4E;      ;
                       LDA.B #$02                           ;818A50;      ;
                       STA.W !inputstate                          ;818A52;00019A;
                       %Set8bit(!M)                             ;818A55;      ;
                       LDA.W $0984                          ;818A57;000984;
                       CMP.B #$44                           ;818A5A;      ;
                       BCS CODE_818A66                      ;818A5C;818A66;
                       SEC                                  ;818A5E;      ;
                       SBC.B #$1B                           ;818A5F;      ;
                       CLC                                  ;818A61;      ;
                       ADC.B #$13                           ;818A62;      ;
                       BRA CODE_818A73                      ;818A64;818A73;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818A66: %Set8bit(!M)                             ;818A66;      ;
                       %Set16bit(!X)                             ;818A68;      ;
                       LDA.B #$00                           ;818A6A;      ;
                       XBA                                  ;818A6C;      ;
                       LDA.W $0984                          ;818A6D;000984;
                       SEC                                  ;818A70;      ;
                       SBC.B #$44                           ;818A71;      ;
                                                            ;      ;      ;
          CODE_818A73: %Set16bit(!M)                             ;818A73;      ;
                       STA.B $7E                            ;818A75;00007E;
                       ASL A                                ;818A77;      ;
                       CLC                                  ;818A78;      ;
                       ADC.B $7E                            ;818A79;00007E;
                       ASL A                                ;818A7B;      ;
                       ASL A                                ;818A7C;      ;
                       CLC                                  ;818A7D;      ;
                       ADC.W #$0004                         ;818A7E;      ;
                       TAX                                  ;818A81;      ;
                       LDA.L DATA8_81A1A5,X                 ;818A82;81A1A5;
                       TAX                                  ;818A86;      ;
                       %Set8bit(!M)                             ;818A87;      ;
                       LDA.B #$00                           ;818A89;      ;
                       STA.W $0191                          ;818A8B;000191;
                       JSL.L StartTextBox                    ;818A8E;83935F;
                       BRA CODE_818AA0                      ;818A92;818AA0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818A94: %Set8bit(!M)                             ;818A94;      ;
                       LDA.W !inputstate                          ;818A96;00019A;
                       CMP.B #$02                           ;818A99;      ;
                       BNE CODE_818AA0                      ;818A9B;818AA0;
                       JMP.W CODE_818B6A                    ;818A9D;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818AA0: %Set16bit(!M)                             ;818AA0;      ;
                       LDA.W $0978                          ;818AA2;000978;
                       STA.B $A5                            ;818AA5;0000A5;
                       JSL.L CODE_8581A2                    ;818AA7;8581A2;
                       %Set16bit(!MX)                             ;818AAB;      ;
                       LDA.W #$0000                         ;818AAD;      ;
                       STA.B !player_action                            ;818AB0;0000D4;
                       %Set16bit(!MX)                             ;818AB2;      ;
                       LDA.W #$0002                         ;818AB4;      ;
                       EOR.W #$FFFF                         ;818AB7;      ;
                       AND.B !game_state                            ;818ABA;0000D2;
                       STA.B !game_state                            ;818ABC;0000D2;
                       JSL.L CODE_81A4F1                    ;818ABE;81A4F1;
                       %Set8bit(!M)                             ;818AC2;      ;
                       STZ.W !item_on_hand                          ;818AC4;00091D;
                       %Set16bit(!M)                             ;818AC7;      ;
                       LDA.W #$0001                         ;818AC9;      ;
                       LDX.W #$0006                         ;818ACC;      ;
                       LDY.W #$0006                         ;818ACF;      ;
                       JSL.L CalculateTileinFront                    ;818AD2;81D14E;
                       %Set8bit(!M)                             ;818AD6;      ;
                       LDA.W $0984                          ;818AD8;000984;
                       CMP.B #$44                           ;818ADB;      ;
                       BCS CODE_818AE7                      ;818ADD;818AE7;
                       SEC                                  ;818ADF;      ;
                       SBC.B #$1B                           ;818AE0;      ;
                       CLC                                  ;818AE2;      ;
                       ADC.B #$13                           ;818AE3;      ;
                       BRA CODE_818AF4                      ;818AE5;818AF4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818AE7: %Set8bit(!M)                             ;818AE7;      ;
                       %Set16bit(!X)                             ;818AE9;      ;
                       LDA.B #$00                           ;818AEB;      ;
                       XBA                                  ;818AED;      ;
                       LDA.W $0984                          ;818AEE;000984;
                       SEC                                  ;818AF1;      ;
                       SBC.B #$44                           ;818AF2;      ;
                                                            ;      ;      ;
          CODE_818AF4: %Set16bit(!M)                             ;818AF4;      ;
                       STA.B $7E                            ;818AF6;00007E;
                       ASL A                                ;818AF8;      ;
                       CLC                                  ;818AF9;      ;
                       ADC.B $7E                            ;818AFA;00007E;
                       ASL A                                ;818AFC;      ;
                       ASL A                                ;818AFD;      ;
                       CLC                                  ;818AFE;      ;
                       ADC.W #$0008                         ;818AFF;      ;
                       TAX                                  ;818B02;      ;
                       %Set8bit(!M)                             ;818B03;      ;
                       LDA.L DATA8_81A1A5,X                 ;818B05;81A1A5;
                       XBA                                  ;818B09;      ;
                       LDA.B #$00                           ;818B0A;      ;
                       XBA                                  ;818B0C;      ;
                       LDX.W !tile_in_front_X                          ;818B0D;000985;
                       LDY.W !tile_in_front_Y                          ;818B10;000987;
                       JSL.L CODE_81A688                    ;818B13;81A688;
                       BRA CODE_818B6A                      ;818B17;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818B19: %Set8bit(!M)                             ;818B19;      ;
                       LDA.W !inputstate                          ;818B1B;00019A;
                       CMP.B #$02                           ;818B1E;      ;
                       BNE CODE_818B25                      ;818B20;818B25;
                       JMP.W CODE_818B6A                    ;818B22;818B6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818B25: LDA.W $0984                          ;818B25;000984;
                       CMP.B #$49                           ;818B28;      ;
                       BEQ CODE_818B63                      ;818B2A;818B63;
                       CMP.B #$56                           ;818B2C;      ;
                       BEQ CODE_818B63                      ;818B2E;818B63;
                       CMP.B #$1B                           ;818B30;      ;
                       BEQ CODE_818B63                      ;818B32;818B63;
                       CMP.B #$1C                           ;818B34;      ;
                       BEQ CODE_818B63                      ;818B36;818B63;
                       CMP.B #$1D                           ;818B38;      ;
                       BEQ CODE_818B63                      ;818B3A;818B63;
                       %Set16bit(!M)                             ;818B3C;      ;
                       LDA.W $0978                          ;818B3E;000978;
                       STA.B $A5                            ;818B41;0000A5;
                       JSL.L CODE_8581A2                    ;818B43;8581A2;
                       %Set16bit(!MX)                             ;818B47;      ;
                       LDA.W #$0000                         ;818B49;      ;
                       STA.B !player_action                            ;818B4C;0000D4;
                       %Set16bit(!MX)                             ;818B4E;      ;
                       LDA.W #$0002                         ;818B50;      ;
                       EOR.W #$FFFF                         ;818B53;      ;
                       AND.B !game_state                            ;818B56;0000D2;
                       STA.B !game_state                            ;818B58;0000D2;
                       JSL.L CODE_81A4F1                    ;818B5A;81A4F1;
                       %Set8bit(!M)                             ;818B5E;      ;
                       STZ.W !item_on_hand                          ;818B60;00091D;
                                                            ;      ;      ;
          CODE_818B63: %Set8bit(!M)                             ;818B63;      ;
                       LDA.B #$FF                           ;818B65;      ;
                       STA.W $0976                          ;818B67;000976;
                                                            ;      ;      ;
          CODE_818B6A: RTS                                  ;818B6A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818B6B: %Set16bit(!MX)                             ;818B6B;      ;
                       LDY.W #$0001                         ;818B6D;      ;
                       JSL.L SUB_8180B7                          ;818B70;8180B7;
                       %Set8bit(!M)                             ;818B74;      ;
                       LDA.B #$00                           ;818B76;      ;
                       XBA                                  ;818B78;      ;
                       LDA.W $0984                          ;818B79;000984;
                       DEC A                                ;818B7C;      ;
                       %Set16bit(!M)                             ;818B7D;      ;
                       STA.B $7E                            ;818B7F;00007E;
                       ASL A                                ;818B81;      ;
                       CLC                                  ;818B82;      ;
                       ADC.B $7E                            ;818B83;00007E;
                       TAX                                  ;818B85;      ;
                       LDA.L DATA8_819FC6,X                 ;818B86;819FC6;
                       TAX                                  ;818B8A;      ;
                       %Set8bit(!M)                             ;818B8B;      ;
                       LDA.B #$02                           ;818B8D;      ;
                       STA.W !inputstate                          ;818B8F;00019A;
                       LDA.B #$00                           ;818B92;      ;
                       STA.W $0191                          ;818B94;000191;
                       JSL.L StartTextBox                    ;818B97;83935F;
                       %Set8bit(!M)                             ;818B9B;      ;
                       LDA.B #$01                           ;818B9D;      ;
                       STA.W $0976                          ;818B9F;000976;
                       JMP.W CODE_818C23                    ;818BA2;818C23;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818BA5: %Set8bit(!M)                             ;818BA5;      ;
                       LDA.W !inputstate                          ;818BA7;00019A;
                       CMP.B #$02                           ;818BAA;      ;
                       BNE CODE_818BB1                      ;818BAC;818BB1;
                       JMP.W CODE_818C23                    ;818BAE;818C23;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818BB1: LDA.W $018F                          ;818BB1;00018F;
                       BEQ CODE_818BB9                      ;818BB4;818BB9;
                       JMP.W CODE_818C0C                    ;818BB6;818C0C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818BB9: %Set16bit(!MX)                             ;818BB9;      ;
                       LDA.W #$0008                         ;818BBB;      ;
                       STA.B !player_action                            ;818BBE;0000D4;
                       %Set16bit(!MX)                             ;818BC0;      ;
                       LDA.W #$8000                         ;818BC2;      ;
                       EOR.W #$FFFF                         ;818BC5;      ;
                       AND.B !game_state                            ;818BC8;0000D2;
                       STA.B !game_state                            ;818BCA;0000D2;
                       %Set16bit(!M)                             ;818BCC;      ;
                       LDA.W $0978                          ;818BCE;000978;
                       STA.B $A5                            ;818BD1;0000A5;
                       JSL.L CODE_8581A2                    ;818BD3;8581A2;
                       JSL.L CODE_81A4F1                    ;818BD7;81A4F1;
                       %Set8bit(!M)                             ;818BDB;      ;
                       STZ.W !item_on_hand                          ;818BDD;00091D;
                       %Set8bit(!M)                             ;818BE0;      ;
                       LDA.B #$00                           ;818BE2;      ;
                       XBA                                  ;818BE4;      ;
                       LDA.W $0984                          ;818BE5;000984;
                       DEC A                                ;818BE8;      ;
                       %Set16bit(!M)                             ;818BE9;      ;
                       STA.B $7E                            ;818BEB;00007E;
                       ASL A                                ;818BED;      ;
                       CLC                                  ;818BEE;      ;
                       ADC.B $7E                            ;818BEF;00007E;
                       TAX                                  ;818BF1;      ;
                       INX                                  ;818BF2;      ;
                       INX                                  ;818BF3;      ;
                       %Set8bit(!M)                             ;818BF4;      ;
                       LDA.L DATA8_819FC6,X                 ;818BF6;819FC6;
                       JSL.L ChangeStamina                    ;818BFA;81D061;
                       %Set16bit(!MX)                             ;818BFE;      ;
                       LDA.W #$0002                         ;818C00;      ;
                       EOR.W #$FFFF                         ;818C03;      ;
                       AND.B !game_state                            ;818C06;0000D2;
                       STA.B !game_state                            ;818C08;0000D2;
                       BRA CODE_818C23                      ;818C0A;818C23;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818C0C: %Set16bit(!MX)                             ;818C0C;      ;
                       LDA.W #$0000                         ;818C0E;      ;
                       STA.B !player_action                            ;818C11;0000D4;
                       %Set16bit(!MX)                             ;818C13;      ;
                       LDA.B !game_state                            ;818C15;0000D2;
                       ORA.W #$0002                         ;818C17;      ;
                       STA.B !game_state                            ;818C1A;0000D2;
                       %Set8bit(!M)                             ;818C1C;      ;
                       LDA.B #$02                           ;818C1E;      ;
                       STA.W $0976                          ;818C20;000976;
                                                            ;      ;      ;
          CODE_818C23: RTS                                  ;818C23;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818C24: %Set16bit(!M)                             ;818C24;      ;
                       LDA.B !player_pos_X                           ;818C26;0000D6;
                       STA.W $0980                          ;818C28;000980;
                       LDA.B !player_pos_Y                            ;818C2B;0000D8;
                       INC A                                ;818C2D;      ;
                       INC A                                ;818C2E;      ;
                       STA.W $0982                          ;818C2F;000982;
                       %Set16bit(!MX)                             ;818C32;      ;
                       LDA.B !player_action                            ;818C34;0000D4;
                       CMP.W #$0003                         ;818C36;      ;
                       BNE CODE_818C3E                      ;818C39;818C3E;
                       JMP.W CODE_818C53                    ;818C3B;818C53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818C3E: %Set16bit(!MX)                             ;818C3E;      ;
                       LDY.W #$0001                         ;818C40;      ;
                       JSL.L SUB_8180B7                          ;818C43;8180B7;
                       %Set8bit(!M)                             ;818C47;      ;
                       LDA.W $0974                          ;818C49;000974;
                       AND.B #$FB                           ;818C4C;      ;
                       STA.W $0974                          ;818C4E;000974;
                       BRA CODE_818C85                      ;818C51;818C85;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818C53: %Set8bit(!M)                             ;818C53;      ;
                       %Set16bit(!X)                             ;818C55;      ;
                       LDA.W $0974                          ;818C57;000974;
                       AND.B #$04                           ;818C5A;      ;
                       BNE CODE_818C71                      ;818C5C;818C71;
                       LDY.W #$000B                         ;818C5E;      ;
                       JSL.L SUB_8180B7                          ;818C61;8180B7;
                       %Set8bit(!M)                             ;818C65;      ;
                       LDA.W $0974                          ;818C67;000974;
                       ORA.B #$04                           ;818C6A;      ;
                       STA.W $0974                          ;818C6C;000974;
                       BRA CODE_818C85                      ;818C6F;818C85;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818C71: %Set16bit(!M)                             ;818C71;      ;
                       LDA.W $0978                          ;818C73;000978;
                       STA.B $A5                            ;818C76;0000A5;
                       JSL.L CODE_8581CB                    ;818C78;8581CB;
                       %Set16bit(!M)                             ;818C7C;      ;
                       LDA.B $A7                            ;818C7E;0000A7;
                       CMP.W #$FFFF                         ;818C80;      ;
                       BEQ CODE_818C3E                      ;818C83;818C3E;
                                                            ;      ;      ;
          CODE_818C85: %Set16bit(!MX)                             ;818C85;      ;
                       LDA.B !player_action                            ;818C87;0000D4;
                       CMP.W #$0005                         ;818C89;      ;
                       BEQ CODE_818C91                      ;818C8C;818C91;
                       JMP.W $8E1A                       ;818C8E;818E1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818C91: %Set16bit(!M)                             ;818C91;      ;
                       LDA.W #$0001                         ;818C93;      ;
                       LDX.W #$0006                         ;818C96;      ;
                       LDY.W #$0006                         ;818C99;      ;
                       JSL.L CalculateTileinFront                    ;818C9C;81D14E;
                       %Set16bit(!MX)                             ;818CA0;      ;
                       LDX.W !tile_in_front_X                          ;818CA2;000985;
                       LDY.W !tile_in_front_Y                          ;818CA5;000987;
                       LDA.W #$0002                         ;818CA8;      ;
                       JSL.L UNK_CheckTileProperty                          ;818CAB;82AC61;
                       %Set16bit(!MX)                             ;818CAF;      ;
                       CPX.W #$0001                         ;818CB1;      ;
                       BEQ CODE_818CF9                      ;818CB4;818CF9;
                       CPX.W #$0002                         ;818CB6;      ;
                       BEQ CODE_818CF9                      ;818CB9;818CF9;
                       CPX.W #$0007                         ;818CBB;      ;
                       BEQ CODE_818CF9                      ;818CBE;818CF9;
                       CPX.W #$0008                         ;818CC0;      ;
                       BEQ CODE_818CF9                      ;818CC3;818CF9;
                       %Set16bit(!M)                             ;818CC5;      ;
                       LDA.W #$0000                         ;818CC7;      ;
                       CPX.W #$00F0                         ;818CCA;      ;
                       BEQ CODE_818CF9                      ;818CCD;818CF9;
                       LDA.W #$0001                         ;818CCF;      ;
                       CPX.W #$00F9                         ;818CD2;      ;
                       BEQ CODE_818CF9                      ;818CD5;818CF9;
                       LDA.W #$0002                         ;818CD7;      ;
                       CPX.W #$00FA                         ;818CDA;      ;
                       BEQ CODE_818CF9                      ;818CDD;818CF9;
                       LDA.W #$0003                         ;818CDF;      ;
                       CPX.W #$00FB                         ;818CE2;      ;
                       BEQ CODE_818CF9                      ;818CE5;818CF9;
                       LDA.W #$0004                         ;818CE7;      ;
                       CPX.W #$00FC                         ;818CEA;      ;
                       BEQ CODE_818CF9                      ;818CED;818CF9;
                       LDA.W #$0005                         ;818CEF;      ;
                       CPX.W #$00FD                         ;818CF2;      ;
                       BEQ CODE_818CF9                      ;818CF5;818CF9;
                       BRA CODE_818D2E                      ;818CF7;818D2E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818CF9: %Set16bit(!MX)                             ;818CF9;      ;
                       LDA.B !player_pos_X                           ;818CFB;0000D6;
                       STA.B $DF                            ;818CFD;0000DF;
                       LDA.B !player_pos_Y                            ;818CFF;0000D8;
                       STA.B $E1                            ;818D01;0000E1;
                       STZ.B $E5                            ;818D03;0000E5;
                       STZ.B $E7                            ;818D05;0000E7;
                       LDA.W #$0010                         ;818D07;      ;
                       STA.B $E3                            ;818D0A;0000E3;
                       LDA.B !player_direction                            ;818D0C;0000DA;
                       JSL.L CBBBB                          ;818D0E;83AD91;
                       CMP.W #$0000                         ;818D12;      ;
                       BNE CODE_818D2E                      ;818D15;818D2E;
                       %Set16bit(!MX)                             ;818D17;      ;
                       LDA.W #$0006                         ;818D19;      ;
                       CLC                                  ;818D1C;      ;
                       ADC.B !player_direction                            ;818D1D;0000DA;
                       TAY                                  ;818D1F;      ;
                       JSL.L SUB_8180B7                          ;818D20;8180B7;
                       %Set8bit(!M)                             ;818D24;      ;
                       LDA.B #$03                           ;818D26;      ;
                       STA.W $0976                          ;818D28;000976;
                       JMP.W $8E1A                        ;818D2B;818E1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818D2E: %Set16bit(!MX)                             ;818D2E;      ;
                       LDA.W #$0000                         ;818D30;      ;
                       STA.B !player_action                            ;818D33;0000D4;
                       JMP.W $8E1A                        ;818D35;818E1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818D38: %Set16bit(!M)                             ;818D38;      ;
                       LDA.W #$0001                         ;818D3A;      ;
                       LDX.W #$0006                         ;818D3D;      ;
                       LDY.W #$0006                         ;818D40;      ;
                       JSL.L CalculateTileinFront                    ;818D43;81D14E;
                       %Set16bit(!MX)                             ;818D47;      ;
                       LDX.W !tile_in_front_X                          ;818D49;000985;
                       LDY.W !tile_in_front_Y                          ;818D4C;000987;
                       LDA.W #$0002                         ;818D4F;      ;
                       JSL.L UNK_CheckTileProperty                          ;818D52;82AC61;
                       %Set16bit(!MX)                             ;818D56;      ;
                       CPX.W #$0001                         ;818D58;      ;
                       BEQ CODE_818DAB                      ;818D5B;818DAB;
                       CPX.W #$0002                         ;818D5D;      ;
                       BEQ CODE_818DAB                      ;818D60;818DAB;
                       CPX.W #$0007                         ;818D62;      ;
                       BEQ CODE_818DAB                      ;818D65;818DAB;
                       CPX.W #$0008                         ;818D67;      ;
                       BEQ CODE_818DAB                      ;818D6A;818DAB;
                       %Set16bit(!M)                             ;818D6C;      ;
                       LDA.W #$0000                         ;818D6E;      ;
                       CPX.W #$00F0                         ;818D71;      ;
                       BNE CODE_818D79                      ;818D74;818D79;
                       JMP.W CODE_818DEC                    ;818D76;818DEC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818D79: LDA.W #$0001                         ;818D79;      ;
                       CPX.W #$00F9                         ;818D7C;      ;
                       BEQ CODE_818DEC                      ;818D7F;818DEC;
                       LDA.W #$0002                         ;818D81;      ;
                       CPX.W #$00FA                         ;818D84;      ;
                       BEQ CODE_818DEC                      ;818D87;818DEC;
                       LDA.W #$0003                         ;818D89;      ;
                       CPX.W #$00FB                         ;818D8C;      ;
                       BEQ CODE_818DEC                      ;818D8F;818DEC;
                       LDA.W #$0004                         ;818D91;      ;
                       CPX.W #$00FC                         ;818D94;      ;
                       BEQ CODE_818DEC                      ;818D97;818DEC;
                       LDA.W #$0005                         ;818D99;      ;
                       CPX.W #$00FD                         ;818D9C;      ;
                       BEQ CODE_818DEC                      ;818D9F;818DEC;
                       %Set16bit(!MX)                             ;818DA1;      ;
                       LDA.W #$0000                         ;818DA3;      ;
                       STA.B !player_action                            ;818DA6;0000D4;
                       JMP.W $8E1A                        ;818DA8;818E1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818DAB: %Set16bit(!M)                             ;818DAB;      ;
                       LDA.W #$0001                         ;818DAD;      ;
                       LDX.W #$0006                         ;818DB0;      ;
                       LDY.W #$0006                         ;818DB3;      ;
                       JSL.L CalculateTileinFront                    ;818DB6;81D14E;
                       %Set8bit(!M)                             ;818DBA;      ;
                       LDA.B #$00                           ;818DBC;      ;
                       XBA                                  ;818DBE;      ;
                       LDA.W $0984                          ;818DBF;000984;
                       %Set16bit(!M)                             ;818DC2;      ;
                       ASL A                                ;818DC4;      ;
                       TAX                                  ;818DC5;      ;
                       %Set8bit(!M)                             ;818DC6;      ;
                       LDA.L Items_Price_Table,X                 ;818DC8;819FDE;
                       LDX.W !tile_in_front_X                          ;818DCC;000985;
                       LDY.W !tile_in_front_Y                          ;818DCF;000987;
                       JSL.L CODE_81A688                    ;818DD2;81A688;
                       %Set16bit(!M)                             ;818DD6;      ;
                       LDA.W $0978                          ;818DD8;000978;
                       STA.B $A5                            ;818DDB;0000A5;
                       JSL.L CODE_8581A2                    ;818DDD;8581A2;
                       JSL.L CODE_81A4F1                    ;818DE1;81A4F1;
                       %Set8bit(!M)                             ;818DE5;      ;
                       STZ.W !item_on_hand                          ;818DE7;00091D;
                       BRA $2E                          ;818DEA;818E1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818DEC: %Set16bit(!M)                             ;818DEC;      ;
                       ASL A                                ;818DEE;      ;
                       ASL A                                ;818DEF;      ;
                       TAX                                  ;818DF0;      ;
                       LDA.L DATA8_81A363,X                 ;818DF1;81A363;
                       STA.W $0980                          ;818DF5;000980;
                       INX                                  ;818DF8;      ;
                       INX                                  ;818DF9;      ;
                       LDA.L DATA8_81A363,X                 ;818DFA;81A363;
                       STA.W $0982                          ;818DFE;000982;
                       LDA.W #$00CA                         ;818E01;      ;
                       STA.W $097A                          ;818E04;00097A;
                       %Set8bit(!M)                             ;818E07;      ;
                       STZ.W !item_on_hand                          ;818E09;00091D;
                       %Set8bit(!M)                             ;818E0C;      ;
                       LDA.B #$04                           ;818E0E;      ;
                       STA.W $0976                          ;818E10;000976;
                       JMP.W $8E1A                        ;818E13;818E1A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818E16: JSL.L CODE_81A4F1                    ;818E16;81A4F1;
                                                            ;      ;      ;
               RTS                                  ;818E1A;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818E1B: %Set8bit(!M)                             ;818E1B;      ;
                       LDA.W !item_on_hand                          ;818E1D;00091D;
                       CMP.B #$29                           ;818E20;      ;
                       BEQ CODE_818E57                      ;818E22;818E57;
                       %Set8bit(!M)                             ;818E24;      ;
                       LDA.B #$00                           ;818E26;      ;
                       XBA                                  ;818E28;      ;
                       LDA.W $0920                          ;818E29;000920;
                       SEC                                  ;818E2C;      ;
                       SBC.B #$24                           ;818E2D;      ;
                       JSL.L GetChickenPointer          ;818E2F;83C995;
                       %Set8bit(!M)                             ;818E33;      ;
                       LDY.W #$0001                         ;818E35;      ;
                       LDA.B !tilemap_to_load                            ;818E38;000022;
                       STA.B [$72],Y                        ;818E3A;000072;
                       LDY.W #$0000                         ;818E3C;      ;
                       LDA.B [$72],Y                        ;818E3F;000072;
                       AND.B #$DF                           ;818E41;      ;
                       STA.B [$72],Y                        ;818E43;000072;
                       %Set16bit(!M)                             ;818E45;      ;
                       LDY.W #$0004                         ;818E47;      ;
                       LDA.W !tile_in_front_X                          ;818E4A;000985;
                       STA.B [$72],Y                        ;818E4D;000072;
                       LDY.W #$0006                         ;818E4F;      ;
                       LDA.W !tile_in_front_Y                          ;818E52;000987;
                       STA.B [$72],Y                        ;818E55;000072;
                                                            ;      ;      ;
          CODE_818E57: %Set16bit(!MX)                             ;818E57;      ;
                       LDY.W #$0001                         ;818E59;      ;
                       %Set8bit(!M)                             ;818E5C;      ;
                       LDA.W !item_on_hand                          ;818E5E;00091D;
                       CMP.B #$26                           ;818E61;      ;
                       BEQ CODE_818E72                      ;818E63;818E72;
                       LDY.W #$0002                         ;818E65;      ;
                       LDA.W !item_on_hand                          ;818E68;00091D;
                       CMP.B #$25                           ;818E6B;      ;
                       BEQ CODE_818E72                      ;818E6D;818E72;
                       LDY.W #$0031                         ;818E6F;      ;
                                                            ;      ;      ;
          CODE_818E72: %Set8bit(!M)                             ;818E72;      ;
                       LDA.B #$00                           ;818E74;      ;
                       XBA                                  ;818E76;      ;
                       LDA.W $0920                          ;818E77;000920;
                       LDX.W #$0000                         ;818E7A;      ;
                       JSL.L SUB_8480F8                    ;818E7D;8480F8;
                       %Set16bit(!MX)                             ;818E81;      ;
                       LDA.W $0978                          ;818E83;000978;
                       STA.B $A5                            ;818E86;0000A5;
                       JSL.L CODE_8581A2                    ;818E88;8581A2;
                       JSL.L CODE_81A4F1                    ;818E8C;81A4F1;
                       %Set8bit(!M)                             ;818E90;      ;
                       STZ.W !item_on_hand                          ;818E92;00091D;
                       JMP.W returnSellFunction                    ;818E95;8196AE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818E98: %Set8bit(!M)                             ;818E98;      ;
                       STZ.W !item_on_hand                          ;818E9A;00091D;
                       %Set16bit(!M)                             ;818E9D;      ;
                       LDA.W #$0001                         ;818E9F;      ;
                       LDX.W #$0006                         ;818EA2;      ;
                       LDY.W #$0006                         ;818EA5;      ;
                       JSL.L CalculateTileinFront                    ;818EA8;81D14E;
                       %Set16bit(!MX)                             ;818EAC;      ;
                       LDX.W !tile_in_front_X                          ;818EAE;000985;
                       LDY.W !tile_in_front_Y                          ;818EB1;000987;
                       LDA.W #$0000                         ;818EB4;      ;
                       JSL.L UNK_CheckTileProperty                          ;818EB7;82AC61;
                       %Set8bit(!M)                             ;818EBB;      ;
                       %Set16bit(!X)                             ;818EBD;      ;
                       LDA.B !tilemap_to_load                            ;818EBF;000022;
                       CMP.B #$27                           ;818EC1;      ;
                       BEQ CODE_818ECC                      ;818EC3;818ECC;
                       CMP.B #$28                           ;818EC5;      ;
                       BEQ CODE_818EFB                      ;818EC7;818EFB;
                       JMP.W CODE_819379                    ;818EC9;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818ECC: CPX.W #$00E2                         ;818ECC;      ;
                       BCS CODE_818ED4                      ;818ECF;818ED4;
                       JMP.W CODE_819379                    ;818ED1;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818ED4: CPX.W #$00EF                         ;818ED4;      ;
                       BCC CODE_818EDC                      ;818ED7;818EDC;
                       JMP.W CODE_819379                    ;818ED9;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818EDC: %Set16bit(!M)                             ;818EDC;      ;
                       TXA                                  ;818EDE;      ;
                       SEC                                  ;818EDF;      ;
                       SBC.W #$00E2                         ;818EE0;      ;
                       ASL A                                ;818EE3;      ;
                       TAX                                  ;818EE4;      ;
                       LDA.L Cow_Feed_Flags,X                ;818EE5;82A571;
                       ORA.W !fed_cows_flags                          ;818EE9;000932;
                       STA.W !fed_cows_flags                          ;818EEC;000932;
                       %Set8bit(!M)                             ;818EEF;      ;
                       LDA.W !fed_cows_N                          ;818EF1;000930;
                       INC A                                ;818EF4;      ;
                       STA.W !fed_cows_N                          ;818EF5;000930;
                       JMP.W CODE_818DAB                    ;818EF8;818DAB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818EFB: CPX.W #$00E2                         ;818EFB;      ;
                       BCS CODE_818F03                      ;818EFE;818F03;
                       JMP.W CODE_819379                    ;818F00;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818F03: CPX.W #$00EF                         ;818F03;      ;
                       BCC CODE_818F0B                      ;818F06;818F0B;
                       JMP.W CODE_819379                    ;818F08;819379;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818F0B: %Set16bit(!M)                             ;818F0B;      ;
                       TXA                                  ;818F0D;      ;
                       SEC                                  ;818F0E;      ;
                       SBC.W #$00E2                         ;818F0F;      ;
                       ASL A                                ;818F12;      ;
                       TAX                                  ;818F13;      ;
                       LDA.L Cow_Feed_Flags,X                ;818F14;82A571;
                       ORA.W !fed_chicks_flags                          ;818F18;000934;
                       STA.W !fed_chicks_flags                          ;818F1B;000934;
                       %Set8bit(!M)                             ;818F1E;      ;
                       LDA.W !fed_chicks_N                          ;818F20;000931;
                       INC A                                ;818F23;      ;
                       STA.W !fed_chicks_N                          ;818F24;000931;
                       JMP.W CODE_818DAB                    ;818F27;818DAB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818F2A: %Set8bit(!M)                             ;818F2A;      ;
                       LDA.B #$02                           ;818F2C;      ;
                       STA.W !inputstate                          ;818F2E;00019A;
                       LDA.B #$00                           ;818F31;      ;
                       XBA                                  ;818F33;      ;
                       LDA.W $0984                          ;818F34;000984;
                       %Set16bit(!M)                             ;818F37;      ;
                       STA.B $7E                            ;818F39;00007E;
                       ASL A                                ;818F3B;      ;
                       CLC                                  ;818F3C;      ;
                       ADC.B $7E                            ;818F3D;00007E;
                       TAX                                  ;818F3F;      ;
                       LDA.L DATA8_81A094,X                 ;818F40;81A094;
                       TAX                                  ;818F44;      ;
                       %Set8bit(!M)                             ;818F45;      ;
                       LDA.B #$00                           ;818F47;      ;
                       STA.W $0191                          ;818F49;000191;
                       JSL.L StartTextBox                    ;818F4C;83935F;
                       %Set8bit(!M)                             ;818F50;      ;
                       LDA.B #$06                           ;818F52;      ;
                       STA.W $0976                          ;818F54;000976;
                       JMP.W CODE_81900F                    ;818F57;81900F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818F5A: %Set8bit(!M)                             ;818F5A;      ;
                       LDA.W !inputstate                          ;818F5C;00019A;
                       CMP.B #$02                           ;818F5F;      ;
                       BNE CODE_818F66                      ;818F61;818F66;
                       JMP.W CODE_81900F                    ;818F63;81900F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818F66: LDA.W $018F                          ;818F66;00018F;
                       BEQ CODE_818F6E                      ;818F69;818F6E;
                       JMP.W CODE_818FD7                    ;818F6B;818FD7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818F6E: LDA.B #$00                           ;818F6E;      ;
                       XBA                                  ;818F70;      ;
                       LDA.W $0984                          ;818F71;000984;
                       %Set16bit(!M)                             ;818F74;      ;
                       STA.B $7E                            ;818F76;00007E;
                       ASL A                                ;818F78;      ;
                       CLC                                  ;818F79;      ;
                       ADC.B $7E                            ;818F7A;00007E;
                       TAX                                  ;818F7C;      ;
                       LDA.L DATA8_81A094,X                 ;818F7D;81A094;
                       CMP.W #$0313                         ;818F81;      ;
                       BEQ CODE_818FEA                      ;818F84;818FEA;
                       %Set8bit(!M)                             ;818F86;      ;
                       LDA.B #$02                           ;818F88;      ;
                       STA.W !inputstate                          ;818F8A;00019A;
                       LDX.W #$02FA                         ;818F8D;      ;
                       LDA.B #$00                           ;818F90;      ;
                       STA.W $0191                          ;818F92;000191;
                       JSL.L StartTextBox                    ;818F95;83935F;
                       %Set16bit(!M)                             ;818F99;      ;
                       LDA.W $0978                          ;818F9B;000978;
                       STA.B $A5                            ;818F9E;0000A5;
                       JSL.L CODE_8581A2                    ;818FA0;8581A2;
                       JSL.L CODE_81A4F1                    ;818FA4;81A4F1;
                       %Set8bit(!M)                             ;818FA8;      ;
                       LDA.B #$00                           ;818FAA;      ;
                       XBA                                  ;818FAC;      ;
                       LDA.W $0984                          ;818FAD;000984;
                       %Set16bit(!M)                             ;818FB0;      ;
                       STA.B $7E                            ;818FB2;00007E;
                       ASL A                                ;818FB4;      ;
                       CLC                                  ;818FB5;      ;
                       ADC.B $7E                            ;818FB6;00007E;
                       TAX                                  ;818FB8;      ;
                       INX                                  ;818FB9;      ;
                       INX                                  ;818FBA;      ;
                       %Set8bit(!M)                             ;818FBB;      ;
                       LDA.B #$00                           ;818FBD;      ;
                       XBA                                  ;818FBF;      ;
                       LDA.L DATA8_81A094,X                 ;818FC0;81A094;
                       %Set16bit(!M)                             ;818FC4;      ;
                       STA.B $72                            ;818FC6;000072;
                       %Set8bit(!M)                             ;818FC8;      ;
                       STZ.B $74                            ;818FCA;000074;
                       JSL.L AddMoney                       ;818FCC;83B1C9;
                       %Set8bit(!M)                             ;818FD0;      ;
                       STZ.W !item_on_hand                          ;818FD2;00091D;
                       BRA CODE_81900F                      ;818FD5;81900F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_818FD7: %Set8bit(!M)                             ;818FD7;      ;
                       LDA.B #$02                           ;818FD9;      ;
                       STA.W !inputstate                          ;818FDB;00019A;
                       LDX.W #$0303                         ;818FDE;      ;
                       LDA.B #$00                           ;818FE1;      ;
                       STA.W $0191                          ;818FE3;000191;
                       JSL.L StartTextBox                    ;818FE6;83935F;
                                                            ;      ;      ;
          CODE_818FEA: %Set16bit(!M)                             ;818FEA;      ;
                       LDY.W #$0001                         ;818FEC;      ;
                       JSL.L SUB_8180B7                          ;818FEF;8180B7;
                       LDA.W $090B                          ;818FF3;00090B;
                       STA.W $0980                          ;818FF6;000980;
                       LDA.W $090D                          ;818FF9;00090D;
                       STA.W $0982                          ;818FFC;000982;
                       %Set8bit(!M)                             ;818FFF;      ;
                       LDA.B #$02                           ;819001;      ;
                       STA.W $0976                          ;819003;000976;
                       %Set16bit(!MX)                             ;819006;      ;
                       LDA.B !game_state                            ;819008;0000D2;
                       ORA.W #$0002                         ;81900A;      ;
                       STA.B !game_state                            ;81900D;0000D2;
                                                            ;      ;      ;
          CODE_81900F: RTS                                  ;81900F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819010: %Set16bit(!MX)                             ;819010;      ;
                       LDY.W #$0001                         ;819012;      ;
                       JSL.L SUB_8180B7                          ;819015;8180B7;
                       %Set8bit(!M)                             ;819019;      ;
                       LDA.B #$02                           ;81901B;      ;
                       STA.W $0976                          ;81901D;000976;
                       RTS                                  ;819020;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819021: %Set16bit(!MX)                             ;819021;      ;
                       LDA.W $0978                          ;819023;000978;
                       STA.B $A5                            ;819026;0000A5;
                       JSL.L CODE_8581A2                    ;819028;8581A2;
                       JSL.L CODE_81A4F1                    ;81902C;81A4F1;
                       %Set8bit(!M)                             ;819030;      ;
                       STZ.W !item_on_hand                          ;819032;00091D;
                       %Set16bit(!MX)                             ;819035;      ;
                       LDA.W #$0000                         ;819037;      ;
                       STA.B !player_action                            ;81903A;0000D4;
                       %Set16bit(!MX)                             ;81903C;      ;
                       LDA.W #$0002                         ;81903E;      ;
                       EOR.W #$FFFF                         ;819041;      ;
                       AND.B !game_state                            ;819044;0000D2;
                       STA.B !game_state                            ;819046;0000D2;
                       RTS                                  ;819048;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819049: %Set16bit(!M)                             ;819049;      ;
                       LDA.B !player_pos_X                           ;81904B;0000D6;
                       STA.W $0980                          ;81904D;000980;
                       LDA.B !player_pos_Y                            ;819050;0000D8;
                       INC A                                ;819052;      ;
                       INC A                                ;819053;      ;
                       STA.W $0982                          ;819054;000982;
                       %Set16bit(!MX)                             ;819057;      ;
                       LDA.B !player_action                            ;819059;0000D4;
                       CMP.W #$0003                         ;81905B;      ;
                       BNE CODE_819063                      ;81905E;819063;
                       JMP.W CODE_819078                    ;819060;819078;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819063: %Set16bit(!MX)                             ;819063;      ;
                       LDY.W #$0001                         ;819065;      ;
                       JSL.L SUB_8180B7                          ;819068;8180B7;
                       %Set8bit(!M)                             ;81906C;      ;
                       LDA.W $0974                          ;81906E;000974;
                       AND.B #$FB                           ;819071;      ;
                       STA.W $0974                          ;819073;000974;
                       BRA CODE_8190AA                      ;819076;8190AA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819078: %Set8bit(!M)                             ;819078;      ;
                       %Set16bit(!X)                             ;81907A;      ;
                       LDA.W $0974                          ;81907C;000974;
                       AND.B #$04                           ;81907F;      ;
                       BNE CODE_819096                      ;819081;819096;
                       LDY.W #$000B                         ;819083;      ;
                       JSL.L SUB_8180B7                          ;819086;8180B7;
                       %Set8bit(!M)                             ;81908A;      ;
                       LDA.W $0974                          ;81908C;000974;
                       ORA.B #$04                           ;81908F;      ;
                       STA.W $0974                          ;819091;000974;
                       BRA CODE_8190AA                      ;819094;8190AA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819096: %Set16bit(!M)                             ;819096;      ;
                       LDA.W $0978                          ;819098;000978;
                       STA.B $A5                            ;81909B;0000A5;
                       JSL.L CODE_8581CB                    ;81909D;8581CB;
                       %Set16bit(!M)                             ;8190A1;      ;
                       LDA.B $A7                            ;8190A3;0000A7;
                       CMP.W #$FFFF                         ;8190A5;      ;
                       BEQ CODE_819063                      ;8190A8;819063;
                                                            ;      ;      ;
          CODE_8190AA: %Set16bit(!MX)                             ;8190AA;      ;
                       LDA.B !player_action                            ;8190AC;0000D4;
                       CMP.W #$0005                         ;8190AE;      ;
                       BEQ CODE_8190B6                      ;8190B1;8190B6;
                       JMP.W CODE_819227                    ;8190B3;819227;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8190B6: %Set16bit(!MX)                             ;8190B6;      ;
                       LDA.B !player_pos_X                           ;8190B8;0000D6;
                       STA.B $DF                            ;8190BA;0000DF;
                       LDA.B !player_pos_Y                            ;8190BC;0000D8;
                       STA.B $E1                            ;8190BE;0000E1;
                       STZ.B $E5                            ;8190C0;0000E5;
                       STZ.B $E7                            ;8190C2;0000E7;
                       LDA.W #$0010                         ;8190C4;      ;
                       STA.B $E3                            ;8190C7;0000E3;
                       LDA.B !player_direction                            ;8190C9;0000DA;
                       JSL.L CBBBB                          ;8190CB;83AD91;
                       %Set16bit(!MX)                             ;8190CF;      ;
                       CMP.W #$0000                         ;8190D1;      ;
                       BEQ CODE_8190D9                      ;8190D4;8190D9;
                       JMP.W CODE_819195                    ;8190D6;819195;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8190D9: %Set8bit(!M)                             ;8190D9;      ;
                       LDA.B !tilemap_to_load                            ;8190DB;000022;
                       CMP.B #$04                           ;8190DD;      ;
                       BCS CODE_8190E4                      ;8190DF;8190E4;
                       JMP.W CODE_81917E                    ;8190E1;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8190E4: CMP.B #$08                           ;8190E4;      ;
                       BCC CODE_8190EB                      ;8190E6;8190EB;
                       JMP.W CODE_81917E                    ;8190E8;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8190EB: LDA.L !weekday                        ;8190EB;7F1F1A;
                       BEQ CODE_8190F4                      ;8190EF;8190F4;
                       JMP.W CODE_81917E                    ;8190F1;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8190F4: LDA.L !hour                        ;8190F4;7F1F1C;
                       CMP.B #$11                           ;8190F8;      ;
                       BCC CODE_8190FF                      ;8190FA;8190FF;
                       JMP.W CODE_81917E                    ;8190FC;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8190FF: %Set16bit(!M)                             ;8190FF;      ;
                       LDA.W $0196                          ;819101;000196;
                       AND.W #$0002                         ;819104;      ;
                       BEQ CODE_81910C                      ;819107;81910C;
                       JMP.W CODE_81917E                    ;819109;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81910C: %Set16bit(!M)                             ;81910C;      ;
                       LDA.W #$0001                         ;81910E;      ;
                       LDX.W #$0000                         ;819111;      ;
                       LDY.W #$0000                         ;819114;      ;
                       JSL.L CalculateTileinFront                    ;819117;81D14E;
                       %Set16bit(!M)                             ;81911B;      ;
                       LDA.W #$0000                         ;81911D;      ;
                       LDX.W !tile_in_front_X                          ;819120;000985;
                       LDY.W !tile_in_front_Y                          ;819123;000987;
                       JSL.L UNK_CheckTileProperty                          ;819126;82AC61;
                       CPX.W #$00F0                         ;81912A;      ;
                       BEQ CODE_819132                      ;81912D;819132;
                       JMP.W CODE_81917E                    ;81912F;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819132: %Set8bit(!M)                             ;819132;      ;
                       LDA.B #$00                           ;819134;      ;
                       XBA                                  ;819136;      ;
                       LDA.W $0984                          ;819137;000984;
                       %Set16bit(!M)                             ;81913A;      ;
                       STA.B $7E                            ;81913C;00007E;
                       ASL A                                ;81913E;      ;
                       CLC                                  ;81913F;      ;
                       ADC.B $7E                            ;819140;00007E;
                       TAX                                  ;819142;      ;
                       LDA.L DATA8_81A094,X                 ;819143;81A094;
                       BNE CODE_81914C                      ;819147;81914C;
                       JMP.W CODE_81917E                    ;819149;81917E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81914C: %Set16bit(!M)                             ;81914C;      ;
                       LDA.W !tile_in_front_X                          ;81914E;000985;
                       STA.W $0980                          ;819151;000980;
                       LDA.W !tile_in_front_Y                          ;819154;000987;
                       STA.W $0982                          ;819157;000982;
                       LDY.W #$0000                         ;81915A;      ;
                       JSL.L SUB_8180B7                          ;81915D;8180B7;
                       %Set8bit(!M)                             ;819161;      ;
                       LDA.B #$05                           ;819163;      ;
                       STA.W $0976                          ;819165;000976;
                       %Set16bit(!MX)                             ;819168;      ;
                       LDA.W #$0000                         ;81916A;      ;
                       STA.B !player_action                            ;81916D;0000D4;
                       %Set16bit(!MX)                             ;81916F;      ;
                       LDA.W #$0002                         ;819171;      ;
                       EOR.W #$FFFF                         ;819174;      ;
                       AND.B !game_state                            ;819177;0000D2;
                       STA.B !game_state                            ;819179;0000D2;
                       JMP.W CODE_819227                    ;81917B;819227;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81917E: %Set16bit(!MX)                             ;81917E;      ;
                       LDA.W #$0006                         ;819180;      ;
                       CLC                                  ;819183;      ;
                       ADC.B !player_direction                            ;819184;0000DA;
                       TAY                                  ;819186;      ;
                       JSL.L SUB_8180B7                          ;819187;8180B7;
                       %Set8bit(!M)                             ;81918B;      ;
                       LDA.B #$03                           ;81918D;      ;
                       STA.W $0976                          ;81918F;000976;
                       JMP.W CODE_819227                    ;819192;819227;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819195: %Set16bit(!M)                             ;819195;      ;
                       LDA.W #$0001                         ;819197;      ;
                       LDX.W #$0000                         ;81919A;      ;
                       LDY.W #$0000                         ;81919D;      ;
                       JSL.L CalculateTileinFront                    ;8191A0;81D14E;
                       %Set16bit(!M)                             ;8191A4;      ;
                       LDA.W !tile_in_front_X                          ;8191A6;000985;
                       STA.W $0980                          ;8191A9;000980;
                       LDA.W !tile_in_front_Y                          ;8191AC;000987;
                       STA.W $0982                          ;8191AF;000982;
                       LDY.W #$0000                         ;8191B2;      ;
                       JSL.L SUB_8180B7                          ;8191B5;8180B7;
                       %Set16bit(!MX)                             ;8191B9;      ;
                       LDA.L $7F1F5C                        ;8191BB;7F1F5C;
                       AND.W #$0010                         ;8191BF;      ;
                       BEQ CODE_819220                      ;8191C2;819220;
                       %Set8bit(!M)                             ;8191C4;      ;
                       %Set16bit(!X)                             ;8191C6;      ;
                       LDA.B #$00                           ;8191C8;      ;
                       XBA                                  ;8191CA;      ;
                       LDA.W $0984                          ;8191CB;000984;
                       %Set16bit(!M)                             ;8191CE;      ;
                       ASL A                                ;8191D0;      ;
                       TAX                                  ;8191D1;      ;
                       INX                                  ;8191D2;      ;
                       %Set8bit(!M)                             ;8191D3;      ;
                       LDA.L Items_Price_Table,X                 ;8191D5;819FDE;
                       BNE CODE_8191DE                      ;8191D9;8191DE;
                       JMP.W CODE_819220                    ;8191DB;819220;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8191DE: LDA.L !hour                        ;8191DE;7F1F1C;
                       CMP.B #$11                           ;8191E2;      ;
                       BCS CODE_819220                      ;8191E4;819220;
                       %Set8bit(!M)                             ;8191E6;      ;
                       LDA.B #$00                           ;8191E8;      ;
                       XBA                                  ;8191EA;      ;
                       LDA.L Items_Price_Table,X                 ;8191EB;819FDE;
                       %Set16bit(!M)                             ;8191EF;      ;
                       CLC                                  ;8191F1;      ;
                       ADC.L !shipping_moneyL                        ;8191F2;7F1F07;
                       STA.L !shipping_moneyL                        ;8191F6;7F1F07;
                       %Set8bit(!M)                             ;8191FA;      ;
                       LDA.L !shipping_moneyH                        ;8191FC;7F1F09;
                       ADC.B #$00                           ;819200;      ;
                       STA.L !shipping_moneyH                        ;819202;7F1F09;
                       %Set16bit(!MX)                             ;819206;      ;
                       LDA.L $7F1F5E                        ;819208;7F1F5E;
                       ORA.W #$0001                         ;81920C;      ;
                       STA.L $7F1F5E                        ;81920F;7F1F5E;
                       %Set16bit(!M)                             ;819213;      ;
                       LDA.L $7F1F5C                        ;819215;7F1F5C;
                       ORA.W #$0040                         ;819219;      ;
                       STA.L $7F1F5C                        ;81921C;7F1F5C;
                                                            ;      ;      ;
          CODE_819220: %Set8bit(!M)                             ;819220;      ;
                       LDA.B #$08                           ;819222;      ;
                       STA.W $0976                          ;819224;000976;
                                                            ;      ;      ;
          CODE_819227: RTS                                  ;819227;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819228: %Set16bit(!M)                             ;819228;      ;
                       LDA.B !player_pos_X                           ;81922A;0000D6;
                       STA.W $0980                          ;81922C;000980;
                       LDA.B !player_pos_Y                            ;81922F;0000D8;
                       INC A                                ;819231;      ;
                       INC A                                ;819232;      ;
                       STA.W $0982                          ;819233;000982;
                       %Set16bit(!MX)                             ;819236;      ;
                       LDA.B !player_action                            ;819238;0000D4;
                       CMP.W #$0003                         ;81923A;      ;
                       BNE CODE_819242                      ;81923D;819242;
                       JMP.W CODE_819257                    ;81923F;819257;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819242: %Set16bit(!MX)                             ;819242;      ;
                       LDY.W #$0001                         ;819244;      ;
                       JSL.L SUB_8180B7                          ;819247;8180B7;
                       %Set8bit(!M)                             ;81924B;      ;
                       LDA.W $0974                          ;81924D;000974;
                       AND.B #$FB                           ;819250;      ;
                       STA.W $0974                          ;819252;000974;
                       BRA CODE_819289                      ;819255;819289;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819257: %Set8bit(!M)                             ;819257;      ;
                       %Set16bit(!X)                             ;819259;      ;
                       LDA.W $0974                          ;81925B;000974;
                       AND.B #$04                           ;81925E;      ;
                       BNE CODE_819275                      ;819260;819275;
                       LDY.W #$000B                         ;819262;      ;
                       JSL.L SUB_8180B7                          ;819265;8180B7;
                       %Set8bit(!M)                             ;819269;      ;
                       LDA.W $0974                          ;81926B;000974;
                       ORA.B #$04                           ;81926E;      ;
                       STA.W $0974                          ;819270;000974;
                       BRA CODE_819289                      ;819273;819289;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819275: %Set16bit(!M)                             ;819275;      ;
                       LDA.W $0978                          ;819277;000978;
                       STA.B $A5                            ;81927A;0000A5;
                       JSL.L CODE_8581CB                    ;81927C;8581CB;
                       %Set16bit(!M)                             ;819280;      ;
                       LDA.B $A7                            ;819282;0000A7;
                       CMP.W #$FFFF                         ;819284;      ;
                       BEQ CODE_819242                      ;819287;819242;
                                                            ;      ;      ;
          CODE_819289: %Set16bit(!MX)                             ;819289;      ;
                       LDA.B !player_action                            ;81928B;0000D4;
                       CMP.W #$0005                         ;81928D;      ;
                       BEQ CODE_819295                      ;819290;819295;
                       JMP.W CODE_819378                    ;819292;819378;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819295: %Set16bit(!MX)                             ;819295;      ;
                       LDA.B !player_pos_X                           ;819297;0000D6;
                       STA.B $DF                            ;819299;0000DF;
                       LDA.B !player_pos_Y                            ;81929B;0000D8;
                       STA.B $E1                            ;81929D;0000E1;
                       STZ.B $E5                            ;81929F;0000E5;
                       STZ.B $E7                            ;8192A1;0000E7;
                       LDA.W #$0010                         ;8192A3;      ;
                       STA.B $E3                            ;8192A6;0000E3;
                       LDA.B !player_direction                            ;8192A8;0000DA;
                       JSL.L CBBBB                          ;8192AA;83AD91;
                       %Set16bit(!MX)                             ;8192AE;      ;
                       CMP.W #$0000                         ;8192B0;      ;
                       BEQ CODE_8192B8                      ;8192B3;8192B8;
                       JMP.W CODE_81936F                    ;8192B5;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8192B8: %Set16bit(!M)                             ;8192B8;      ;
                       LDA.W #$0000                         ;8192BA;      ;
                       LDX.W #$0007                         ;8192BD;      ;
                       LDY.W #$0007                         ;8192C0;      ;
                       JSL.L CalculateTileinFront                    ;8192C3;81D14E;
                       %Set16bit(!M)                             ;8192C7;      ;
                       LDA.W #$0002                         ;8192C9;      ;
                       LDX.W !tile_in_front_X                          ;8192CC;000985;
                       LDY.W !tile_in_front_Y                          ;8192CF;000987;
                       JSL.L UNK_CheckTileProperty                          ;8192D2;82AC61;
                       %Set8bit(!M)                             ;8192D6;      ;
                       AND.B #$1F                           ;8192D8;      ;
                       BEQ CODE_8192DF                      ;8192DA;8192DF;
                       JMP.W CODE_81936F                    ;8192DC;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8192DF: CPX.W #$00FF                         ;8192DF;      ;
                       BNE CODE_8192E7                      ;8192E2;8192E7;
                       JMP.W CODE_81936F                    ;8192E4;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8192E7: %Set16bit(!M)                             ;8192E7;      ;
                       LDA.W #$0001                         ;8192E9;      ;
                       LDX.W #$000A                         ;8192EC;      ;
                       LDY.W #$000A                         ;8192EF;      ;
                       JSL.L CalculateTileinFront                    ;8192F2;81D14E;
                       %Set16bit(!M)                             ;8192F6;      ;
                       LDA.W #$0002                         ;8192F8;      ;
                       LDX.W !tile_in_front_X                          ;8192FB;000985;
                       LDY.W !tile_in_front_Y                          ;8192FE;000987;
                       JSL.L UNK_CheckTileProperty                          ;819301;82AC61;
                       %Set8bit(!M)                             ;819305;      ;
                       AND.B #$1F                           ;819307;      ;
                       BEQ CODE_81930E                      ;819309;81930E;
                       JMP.W CODE_81936F                    ;81930B;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81930E: CPX.W #$00FF                         ;81930E;      ;
                       BNE CODE_819316                      ;819311;819316;
                       JMP.W CODE_81936F                    ;819313;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819316: %Set16bit(!M)                             ;819316;      ;
                       LDA.W #$0001                         ;819318;      ;
                       LDX.W #$0000                         ;81931B;      ;
                       LDY.W #$0000                         ;81931E;      ;
                       JSL.L CalculateTileinFront                    ;819321;81D14E;
                       %Set16bit(!M)                             ;819325;      ;
                       LDA.W #$0002                         ;819327;      ;
                       LDX.W !tile_in_front_X                          ;81932A;000985;
                       LDY.W !tile_in_front_Y                          ;81932D;000987;
                       JSL.L UNK_CheckTileProperty                          ;819330;82AC61;
                       %Set8bit(!M)                             ;819334;      ;
                       AND.B #$1F                           ;819336;      ;
                       BEQ CODE_81933D                      ;819338;81933D;
                       JMP.W CODE_81936F                    ;81933A;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81933D: CPX.W #$00FF                         ;81933D;      ;
                       BNE CODE_819345                      ;819340;819345;
                       JMP.W CODE_81936F                    ;819342;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819345: CPX.W #$00E1                         ;819345;      ;
                       BNE CODE_81934D                      ;819348;81934D;
                       JMP.W CODE_81936F                    ;81934A;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81934D: CPX.W #$00C0                         ;81934D;      ;
                       BCC CODE_819359                      ;819350;819359;
                       CPX.W #$00D0                         ;819352;      ;
                       BCS CODE_819359                      ;819355;819359;
                       BRA CODE_81936F                      ;819357;81936F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819359: %Set16bit(!MX)                             ;819359;      ;
                       LDA.W #$0006                         ;81935B;      ;
                       CLC                                  ;81935E;      ;
                       ADC.B !player_direction                            ;81935F;0000DA;
                       TAY                                  ;819361;      ;
                       JSL.L SUB_8180B7                          ;819362;8180B7;
                       %Set8bit(!M)                             ;819366;      ;
                       LDA.B #$03                           ;819368;      ;
                       STA.W $0976                          ;81936A;000976;
                       BRA CODE_819378                      ;81936D;819378;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81936F: %Set16bit(!MX)                             ;81936F;      ;
                       LDA.W #$0000                         ;819371;      ;
                       STA.B !player_action                            ;819374;0000D4;
                       BRA CODE_819378                      ;819376;819378;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819378: RTS                                  ;819378;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819379: %Set8bit(!M)                             ;819379;      ;
                       %Set16bit(!X)                             ;81937B;      ;
                       LDA.B !tilemap_to_load                            ;81937D;000022;
                       CMP.B #$04                           ;81937F;      ;
                       BCS CODE_819386                      ;819381;819386;
                       JMP.W CODE_819397                    ;819383;819397;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819386: CMP.B #$27                           ;819386;      ;
                       BNE CODE_81938D                      ;819388;81938D;
                       JMP.W CODE_819397                    ;81938A;819397;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81938D: CMP.B #$28                           ;81938D;      ;
                       BNE CODE_819394                      ;81938F;819394;
                       JMP.W CODE_819397                    ;819391;819397;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819394: JMP.W Droped_on_special_place                    ;819394;819497;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_819397: %Set16bit(!M)                             ;819397;      ;
                       LDA.W #$0002                         ;819399;      ;
                       LDX.W #$0000                         ;81939C;      ;
                       LDY.W #$0000                         ;81939F;      ;
                       JSL.L CalculateTileinFront                    ;8193A2;81D14E;
                       %Set16bit(!M)                             ;8193A6;      ;
                       LDA.W #$0000                         ;8193A8;      ;
                       LDX.W !tile_in_front_X                          ;8193AB;000985;
                       LDY.W !tile_in_front_Y                          ;8193AE;000987;
                       JSL.L UNK_CheckTileProperty                          ;8193B1;82AC61;
                       CPX.W #$00F2                         ;8193B5;      ;
                       BEQ CODE_8193BD                      ;8193B8;8193BD;
                       JMP.W Droped_on_special_place                    ;8193BA;819497;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_8193BD: BRA Dropedonsaleplace                      ;8193BD;8193BF;
                                                            ;      ;      ;
;;;;;; This controlls if its get sold or it gets incubated or what happens.
Dropedonsaleplace:
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.B #$00
      XBA
      LDA.W $0984                            ;Correlates with item on hand
      %Set16bit(!M)
      ASL A
      TAX
      INX
      %Set8bit(!M)
      LDA.L Items_Price_Table,X
      BNE +                                  ;if its worth something
      JMP.W Droped_on_special_place

    + LDA.L !hour
      CMP.B #17                              ;Before 5
      BCS .toolate
      %Set8bit(!M)
      LDA.B #$00
      XBA                                    ;get price
      LDA.L Items_Price_Table,X
      %Set16bit(!M)
      CLC
      ADC.L !shipping_moneyL
      STA.L !shipping_moneyL
      %Set8bit(!M)
      LDA.L !shipping_moneyH
      ADC.B #$00
      STA.L !shipping_moneyH
      %Set16bit(!MX)
      LDA.L $7F1F5E
      ORA.W #$0001                           ;Things in the shipping bin
      STA.L $7F1F5E

    .toolate:
      %Set16bit(!M)
      LDA.W $0978
      STA.B $A5
      JSL.L CODE_8581A2                      ;TODO
      %Set8bit(!M)
      LDA.B !tilemap_to_load
      CMP.B !map_barn
      BNE .notbarn
      JMP.W .barnbin

    .notbarn:
      CMP.B !map_coop
      BNE .notcoop
      JMP.W .coopbin

    .notcoop:
      %Set16bit(!M)
      LDA.W #$0024                           ;36
      JSL.L CODE_81A5E1                      ;TODO
      %Set8bit(!M)
      LDA.B #$07
      STA.W $0976
      %Set16bit(!MX)
      LDA.W #$0001
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state
      %Set8bit(!M)
      STZ.W !item_on_hand
      JMP.W returnSellFunction

    .barnbin:
      %Set16bit(!M)
      LDA.W #$0025                           ;37
      JSL.L CODE_81A5E1                      ;TODO
      %Set8bit(!M)
      LDA.B #$07
      STA.W $0976                            ;TODO
      %Set16bit(!MX)
      LDA.W #$0001
      EOR.W #$FFFF                           ;$0001
      AND.B !game_state
      STA.B !game_state                              ;Allows walking
      %Set8bit(!M)
      STZ.W !item_on_hand
      JMP.W returnSellFunction

    .coopbin:
      %Set16bit(!M)
      LDA.W #$0026
      JSL.L CODE_81A5E1                      ;TODO
      %Set8bit(!M)
      LDA.B #$07
      STA.W $0976                            ;TODO
      %Set16bit(!MX)
      LDA.W #$0001
      EOR.W #$FFFF                           ;$0001
      AND.B !game_state
      STA.B !game_state                              ;Allows walking
      %Set8bit(!M)
      STZ.W !item_on_hand
      JMP.W returnSellFunction

    Droped_on_special_place:
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.W !item_on_hand
      CMP.B !item_egg                        ;Egg
      BEQ .itsanegg
      JMP.W .nothatchableegg

   .itsanegg:
      LDA.B !tilemap_to_load
      CMP.B !map_coop
      BEQ .itsonthecoop
      JMP.W .nothatchableegg

   .itsonthecoop:
      %Set16bit(!M)
      LDA.W #$0001
      LDX.W #$0000
      LDY.W #$0000
      JSL.L CalculateTileinFront                      ;TODO
      %Set16bit(!M)
      LDA.W #$0000
      LDX.W !tile_in_front_X
      LDY.W !tile_in_front_Y
      JSL.L UNK_CheckTileProperty                            ;TODO
      CPX.W #$00F7
      BEQ +
      JMP.W .nothatchableegg

    + %Set16bit(!MX)
      LDA.L $7F1F6E
      AND.W #$2000                           ;hatching egg flag
      BEQ .alreadyhatchingegg
      JMP.W .nothatchableegg

  .alreadyhatchingegg:
      %Set16bit(!MX)
      LDA.W #$0014
      LDX.W #$0000
      LDY.W #$0000
      JSL.L SUB_8480F8                      ;TODO
      %Set8bit(!M)
      %Set16bit(!X)
      LDY.W #$0000
      LDA.B #$03
      STA.B [$CC],Y                          ;TODO
      %Set16bit(!M)
      LDA.W #$0000
      JSL.L AddNewChicken
      %Set16bit(!MX)
      LDA.L $7F1F6E
      ORA.W #$2000                           ;hatching egg flag
      STA.L $7F1F6E
      LDA.W #$00A1
      LDX.W #$00E0
      LDY.W #$00B0
      JSL.L EditTileonMap
      %Set16bit(!MX)
      LDA.W $0978
      STA.B $A5
      JSL.L CODE_8581A2
      JSL.L CODE_81A4F1
      %Set8bit(!M)
      STZ.W !item_on_hand
      %Set16bit(!MX)
      LDA.W #$0005                           ;Incubating gives you 5 happiness
      JSL.L AddPlayerHappiness
      JMP.W returnSellFunction

  .nothatchableegg:
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.B !tilemap_to_load
      CMP.B !map_farm_winter                 ;Farm
      BCC .onthefarm
      CMP.B !map_mountain_spring
      BCS .onmountain
      JMP.W CODE_81965B

  .onmountain:
      CMP.B !map_house_1
      BCC .beforehouse
      JMP.W CODE_81965B

  .beforehouse:
      %Set16bit(!M)
      LDA.W #$0001
      LDX.W #$0006
      LDY.W #$0006
      JSL.L CalculateTileinFront
      %Set16bit(!MX)
      LDX.W !tile_in_front_X
      LDY.W !tile_in_front_Y
      LDA.W #$0002                         ;81956E;      ;
      JSL.L UNK_CheckTileProperty                          ;819571;82AC61;
      %Set16bit(!MX)                             ;819575;      ;
      LDA.W #$0006                         ;819577;      ;
      CPX.W #$00F0                         ;81957A;      ;
      BNE +                      ;81957D;819582;
      JMP.W CODE_8195F4                    ;81957F;8195F4;
                                          ;      ;      ;
                                          ;      ;      ;
    + LDA.W #$0007                         ;819582;      ;
      CPX.W #$00F4                         ;819585;      ;
      BNE +                      ;819588;81958D;
      JMP.W CODE_819631                    ;81958A;819631;
                                          ;      ;      ;
                                          ;      ;      ;
    + JMP.W CODE_81965B                    ;81958D;81965B;
                                          ;      ;      ;
                                          ;      ;      ;
  .onthefarm:
      %Set16bit(!M)                             ;819590;      ;
      LDA.W #$0001                         ;819592;      ;
      LDX.W #$0006                         ;819595;      ;
      LDY.W #$0006                         ;819598;      ;
      JSL.L CalculateTileinFront                    ;81959B;81D14E;
      %Set16bit(!MX)                             ;81959F;      ;
      LDX.W !tile_in_front_X                          ;8195A1;000985;
      LDY.W !tile_in_front_Y                          ;8195A4;000987;
      LDA.W #$0002                         ;8195A7;      ;
      JSL.L UNK_CheckTileProperty                          ;8195AA;82AC61;
      %Set16bit(!MX)                             ;8195AE;      ;
      LDA.W #$0000                         ;8195B0;      ;
      CPX.W #$00F0                         ;8195B3;      ;
      BNE CODE_8195BB                      ;8195B6;8195BB;
      JMP.W CODE_819631                    ;8195B8;819631;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195BB: LDA.W #$0001                         ;8195BB;      ;
      CPX.W #$00F9                         ;8195BE;      ;
      BNE CODE_8195C6                      ;8195C1;8195C6;
      JMP.W CODE_819631                    ;8195C3;819631;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195C6: LDA.W #$0002                         ;8195C6;      ;
      CPX.W #$00FA                         ;8195C9;      ;
      BNE CODE_8195D1                      ;8195CC;8195D1;
      JMP.W CODE_819631                    ;8195CE;819631;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195D1: LDA.W #$0003                         ;8195D1;      ;
      CPX.W #$00FB                         ;8195D4;      ;
      BNE CODE_8195DC                      ;8195D7;8195DC;
      JMP.W CODE_819631                    ;8195D9;819631;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195DC: LDA.W #$0004                         ;8195DC;      ;
      CPX.W #$00FC                         ;8195DF;      ;
      BNE CODE_8195E7                      ;8195E2;8195E7;
      JMP.W CODE_819631                    ;8195E4;819631;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195E7: LDA.W #$0005                         ;8195E7;      ;
      CPX.W #$00FD                         ;8195EA;      ;
      BNE CODE_8195F2                      ;8195ED;8195F2;
      JMP.W CODE_819631                    ;8195EF;819631;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195F2: BRA CODE_81965B                      ;8195F2;81965B;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_8195F4: %Set8bit(!M)                             ;8195F4;      ;
      LDA.W !item_on_hand                          ;8195F6;00091D;
      CMP.B #$07                           ;8195F9;      ;
      BNE CODE_81962C                      ;8195FB;81962C;
      LDA.L !hour                        ;8195FD;7F1F1C;
      CMP.B #$11                           ;819601;      ;
      BCS CODE_81962C                      ;819603;81962C;
      %Set16bit(!MX)                             ;819605;      ;
      LDA.L $7F1F66                        ;819607;7F1F66;
      AND.W #$2000                         ;81960B;      ;
      BNE CODE_81962C                      ;81960E;81962C;
      %Set16bit(!MX)                             ;819610;      ;
      LDA.W #$0000                         ;819612;      ;
      LDX.W #$0010                         ;819615;      ;
      LDY.W #$0000                         ;819618;      ;
      JSL.L UNK_LoadCCDataLong                            ;81961B;848097;
      %Set16bit(!MX)                             ;81961F;      ;
      LDA.L $7F1F66                        ;819621;7F1F66;
      ORA.W #$2000                         ;819625;      ;
      STA.L $7F1F66                        ;819628;7F1F66;
                                          ;      ;      ;
      CODE_81962C: %Set16bit(!MX)                             ;81962C;      ;
      LDA.W #$0006                         ;81962E;      ;
                                          ;      ;      ;
      CODE_819631: %Set16bit(!M)                             ;819631;      ;
      ASL A                                ;819633;      ;
      ASL A                                ;819634;      ;
      TAX                                  ;819635;      ;
      LDA.L DATA8_81A363,X                 ;819636;81A363;
      STA.W $0980                          ;81963A;000980;
      INX                                  ;81963D;      ;
      INX                                  ;81963E;      ;
      LDA.L DATA8_81A363,X                 ;81963F;81A363;
      STA.W $0982                          ;819643;000982;
      LDA.W #$00CA                         ;819646;      ;
      STA.W $097A                          ;819649;00097A;
      %Set8bit(!M)                             ;81964C;      ;
      STZ.W !item_on_hand                          ;81964E;00091D;
      %Set8bit(!M)                             ;819651;      ;
      LDA.B #$04                           ;819653;      ;
      STA.W $0976                          ;819655;000976;
      JMP.W returnSellFunction                    ;819658;8196AE;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_81965B: %Set8bit(!M)                             ;81965B;      ;
      %Set16bit(!X)                             ;81965D;      ;
      STZ.W !item_on_hand                          ;81965F;00091D;
      %Set16bit(!M)                             ;819662;      ;
      LDY.W #$000A                         ;819664;      ;
      JSL.L SUB_8180B7                          ;819667;8180B7;
      %Set16bit(!M)                             ;81966B;      ;
      LDA.W #$0002                         ;81966D;      ;
      LDX.W #$0000                         ;819670;      ;
      LDY.W #$0000                         ;819673;      ;
      JSL.L CalculateTileinFront                    ;819676;81D14E;
      LDA.W !tile_in_front_X                          ;81967A;000985;
      STA.W $0980                          ;81967D;000980;
      LDA.W !tile_in_front_Y                          ;819680;000987;
      STA.W $0982                          ;819683;000982;
      %Set8bit(!M)                             ;819686;      ;
      LDA.B #$04                           ;819688;      ;
      STA.W $0976                          ;81968A;000976;
      BRA returnSellFunction                      ;81968D;8196AE;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_81968F: JSL.L CODE_81A4F1                    ;81968F;81A4F1;
      BRA returnSellFunction                      ;819693;8196AE;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_819695: %Set16bit(!MX)                             ;819695;      ;
      LDA.B $CF                            ;819697;0000CF;
      BNE returnSellFunction                      ;819699;8196AE;
      %Set8bit(!M)                             ;81969B;      ;
      LDA.B $D1                            ;81969D;0000D1;
      BNE returnSellFunction                      ;81969F;8196AE;
      JSL.L CODE_81A4F1                    ;8196A1;81A4F1;
      %Set16bit(!MX)                             ;8196A5;      ;
      LDA.B !game_state                            ;8196A7;0000D2;
      ORA.W #$0001                         ;8196A9;      ;
      STA.B !game_state                            ;8196AC;0000D2;
                                          ;      ;      ;
      returnSellFunction: RTS                                  ;8196AE;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_8196AF: db $FF,$FF,$FF,$76,$98,$81,$9A,$98,$81,$BE,$98,$81,$E2,$98,$81,$06;8196AF;      ;
                       db $99,$81,$2A,$99,$81,$4E,$99,$81,$72,$99,$81,$96,$99,$81,$BA,$99;8196BF;      ;
                       db $81,$96,$99,$81,$96,$99,$81,$DE,$99,$81,$02,$9A,$81,$26,$9A,$81;8196CF;      ;
                       db $4A,$9A,$81,$6E,$9A,$81,$92,$9A,$81,$B6,$9A,$81,$DA,$9A,$81,$FE;8196DF;      ;
                       db $9A,$81,$22,$9B,$81,$46,$9B,$81,$6A,$9B,$81,$A2,$9F,$81,$8E,$9B;8196EF;      ;
                       db $81,$B2,$9B,$81,$D6,$9B,$81,$FA,$9B,$81,$1E,$9C,$81,$42,$9C,$81;8196FF;      ;
                       db $66,$9C,$81,$8A,$9C,$81,$AE,$9C,$81,$D2,$9C,$81,$F6,$9C,$81,$1A;81970F;      ;
                       db $9D,$81,$3E,$9D,$81,$62,$9D,$81,$86,$9D,$81,$AA,$9D,$81,$CE,$9D;81971F;      ;
                       db $81,$E0,$9D,$81,$F2,$9D,$81,$04,$9E,$81,$16,$9E,$81,$28,$9E,$81;81972F;      ;
                       db $3A,$9E,$81,$4C,$9E,$81,$5E,$9E,$81,$70,$9E,$81,$82,$9E,$81,$94;81973F;      ;
                       db $9E,$81,$A6,$9E,$81,$B8,$9E,$81,$CA,$9E,$81,$DC,$9E,$81,$EE,$9E;81974F;      ;
                       db $81,$00,$9F,$81,$12,$9F,$81,$24,$9F,$81,$36,$9F,$81,$48,$9F,$81;81975F;      ;
                       db $5A,$9F,$81,$6C,$9F,$81,$7E,$9F,$81,$90,$9F,$81,$94,$9E,$81,$16;81976F;      ;
                       db $9E,$81,$28,$9E,$81,$3A,$9E,$81,$4C,$9E,$81,$A2,$9F,$81,$A6,$9E;81977F;      ;
                       db $81,$B8,$9E,$81,$CA,$9E,$81,$EE,$9E,$81,$00,$9F,$81,$12,$9F,$81;81978F;      ;
                       db $24,$9F,$81,$36,$9F,$81,$5E,$9E,$81,$70,$9E,$81,$7E,$9F,$81,$90;81979F;      ;
                       db $9F,$81,$2A,$99,$81,$26,$9A,$81,$B2,$9B,$81,$D6,$9B,$81,$FA,$9B;8197AF;      ;
                       db $81                               ;8197BF;      ;
                                                            ;      ;      ;
         DATA8_8197C0: db $FF,$FF,$FE,$80,$02,$81,$06,$81,$0A,$81,$0E,$81,$12,$81,$16,$81;8197C0;      ;
                       db $1A,$81,$1E,$81,$22,$81,$1E,$81,$1E,$81,$26,$81,$2A,$81,$2E,$81;8197D0;      ;
                       db $32,$81,$4A,$81,$62,$81,$7A,$81,$92,$81,$96,$81,$9A,$81,$9E,$81;8197E0;      ;
                       db $A2,$81,$A6,$81,$AA,$81,$AE,$81,$C8,$81,$E2,$81,$FC,$81,$3E,$82;8197F0;      ;
                       db $80,$82,$C2,$82,$FE,$82,$B6,$83,$B7,$83,$BB,$83,$BF,$83,$C3,$83;819800;      ;
                       db $C4,$83,$C5,$83,$C9,$83,$D1,$83,$D9,$83,$E1,$83,$E9,$83,$F1,$83;819810;      ;
                       db $F9,$83,$01,$84,$09,$84,$11,$84,$19,$84,$21,$84,$29,$84,$31,$84;819820;      ;
                       db $39,$84,$41,$84,$49,$84,$51,$84,$59,$84,$61,$84,$69,$84,$71,$84;819830;      ;
                       db $79,$84,$81,$84,$89,$84,$91,$84,$99,$84,$D5,$84,$11,$85,$4D,$85;819840;      ;
                       db $89,$85,$C5,$85,$DF,$85,$F6,$85,$0D,$86,$24,$86,$5B,$86,$92,$86;819850;      ;
                       db $C9,$86,$00,$87,$37,$87,$4E,$87,$65,$87,$81,$87,$9D,$87,$2E,$81;819860;      ;
                       db $B7,$87,$BB,$87,$BF,$87,$F6,$00,$00,$A2,$03,$00,$9C,$03,$00,$9D;819870;      ;
                       db $03,$00,$9E,$03,$01,$9E,$03,$00,$9F,$03,$00,$A0,$03,$00,$A1,$03;819880;      ;
                       db $01,$A1,$03,$00,$06,$01,$00,$A3,$03,$00,$F7,$00,$00,$AA,$03,$00;819890;      ;
                       db $A4,$03,$00,$A5,$03,$00,$A6,$03,$01,$A6,$03,$00,$A7,$03,$00,$A8;8198A0;      ;
                       db $03,$00,$A9,$03,$01,$A9,$03,$00,$07,$01,$00,$AB,$03,$00,$F4,$00;8198B0;      ;
                       db $00,$92,$03,$00,$8C,$03,$00,$8D,$03,$00,$8E,$03,$01,$8E,$03,$00;8198C0;      ;
                       db $8F,$03,$00,$90,$03,$00,$91,$03,$01,$91,$03,$00,$04,$01,$00,$93;8198D0;      ;
                       db $03,$00,$F5,$00,$00,$9A,$03,$00,$94,$03,$00,$95,$03,$00,$96,$03;8198E0;      ;
                       db $01,$96,$03,$00,$97,$03,$00,$98,$03,$00,$99,$03,$01,$99,$03,$00;8198F0;      ;
                       db $05,$01,$00,$9B,$03,$00,$F8,$00,$00,$B2,$03,$00,$AC,$03,$00,$AD;819900;      ;
                       db $03,$00,$AE,$03,$01,$AE,$03,$00,$AF,$03,$00,$B0,$03,$00,$B1,$03;819910;      ;
                       db $01,$B1,$03,$00,$08,$01,$00,$B3,$03,$00,$F9,$00,$00,$BA,$03,$00;819920;      ;
                       db $B4,$03,$00,$B5,$03,$00,$B6,$03,$01,$B6,$03,$00,$B7,$03,$00,$B8;819930;      ;
                       db $03,$00,$B9,$03,$01,$B9,$03,$00,$09,$01,$00,$BB,$03,$00,$BB,$00;819940;      ;
                       db $00,$2C,$04,$00,$26,$04,$00,$27,$04,$00,$28,$04,$01,$28,$04,$00;819950;      ;
                       db $29,$04,$00,$2A,$04,$00,$2B,$04,$01,$2B,$04,$00,$BA,$00,$00,$2D;819960;      ;
                       db $04,$00,$00,$00,$00,$0C,$04,$00,$09,$04,$00,$0A,$04,$00,$0B,$04;819970;      ;
                       db $01,$0B,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00;819980;      ;
                       db $0D,$04,$00,$00,$00,$00,$E8,$00,$00,$29,$01,$00,$23,$01,$00,$24;819990;      ;
                       db $01,$00,$25,$01,$01,$25,$01,$00,$26,$01,$00,$27,$01,$00,$28,$01;8199A0;      ;
                       db $01,$28,$01,$00,$B7,$00,$00,$2A,$01,$00,$E9,$00,$00,$31,$01,$00;8199B0;      ;
                       db $2B,$01,$00,$2C,$01,$00,$2D,$01,$01,$2D,$01,$00,$2E,$01,$00,$2F;8199C0;      ;
                       db $01,$00,$30,$01,$01,$30,$01,$00,$B7,$00,$00,$32,$01,$00,$EA,$00;8199D0;      ;
                       db $00,$21,$01,$00,$1B,$01,$00,$1C,$01,$00,$1D,$01,$01,$1D,$01,$00;8199E0;      ;
                       db $1E,$01,$00,$1F,$01,$00,$20,$01,$01,$20,$01,$00,$C8,$00,$00,$22;8199F0;      ;
                       db $01,$00,$EB,$00,$00,$39,$01,$00,$33,$01,$00,$34,$01,$00,$35,$01;819A00;      ;
                       db $01,$35,$01,$00,$36,$01,$00,$37,$01,$00,$38,$01,$01,$38,$01,$00;819A10;      ;
                       db $C8,$00,$00,$3A,$01,$00,$E7,$00,$00,$41,$01,$00,$3B,$01,$00,$3C;819A20;      ;
                       db $01,$00,$3D,$01,$01,$3D,$01,$00,$3E,$01,$00,$3F,$01,$00,$40,$01;819A30;      ;
                       db $01,$40,$01,$00,$00,$00,$00,$42,$01,$00,$EC,$00,$00,$58,$03,$00;819A40;      ;
                       db $52,$03,$00,$53,$03,$00,$54,$03,$01,$54,$03,$00,$55,$03,$00,$56;819A50;      ;
                       db $03,$00,$57,$03,$01,$57,$03,$00,$FC,$00,$00,$59,$03,$00,$ED,$00;819A60;      ;
                       db $00,$60,$03,$00,$5A,$03,$00,$5B,$03,$00,$5C,$03,$01,$5C,$03,$00;819A70;      ;
                       db $5D,$03,$00,$5E,$03,$00,$5F,$03,$01,$5F,$03,$00,$FD,$00,$00,$61;819A80;      ;
                       db $03,$00,$EF,$00,$00,$70,$03,$00,$6A,$03,$00,$6B,$03,$00,$6C,$03;819A90;      ;
                       db $01,$6C,$03,$00,$6D,$03,$00,$6E,$03,$00,$6F,$03,$01,$6F,$03,$00;819AA0;      ;
                       db $FF,$00,$00,$71,$03,$00,$EE,$00,$00,$68,$03,$00,$62,$03,$00,$63;819AB0;      ;
                       db $03,$00,$64,$03,$01,$64,$03,$00,$65,$03,$00,$66,$03,$00,$67,$03;819AC0;      ;
                       db $01,$67,$03,$00,$FE,$00,$00,$69,$03,$00,$F3,$00,$00,$8A,$03,$00;819AD0;      ;
                       db $84,$03,$00,$85,$03,$00,$86,$03,$01,$86,$03,$00,$87,$03,$00,$88;819AE0;      ;
                       db $03,$00,$89,$03,$01,$89,$03,$00,$03,$01,$00,$8B,$03,$00,$F2,$00;819AF0;      ;
                       db $00,$82,$03,$00,$7E,$03,$00,$7E,$03,$00,$7E,$03,$01,$7E,$03,$00;819B00;      ;
                       db $7F,$03,$00,$80,$03,$00,$81,$03,$01,$81,$03,$00,$02,$01,$00,$83;819B10;      ;
                       db $03,$00,$F1,$00,$00,$7C,$03,$00,$78,$03,$00,$78,$03,$00,$78,$03;819B20;      ;
                       db $01,$78,$03,$00,$79,$03,$00,$7A,$03,$00,$7B,$03,$01,$7B,$03,$00;819B30;      ;
                       db $01,$01,$00,$7D,$03,$00,$F0,$00,$00,$76,$03,$00,$72,$03,$00,$72;819B40;      ;
                       db $03,$00,$72,$03,$01,$72,$03,$00,$73,$03,$00,$74,$03,$00,$75,$03;819B50;      ;
                       db $01,$75,$03,$00,$00,$01,$00,$77,$03,$00,$FA,$00,$00,$C2,$03,$00;819B60;      ;
                       db $BC,$03,$00,$BD,$03,$00,$BE,$03,$01,$BE,$03,$00,$BF,$03,$00,$C0;819B70;      ;
                       db $03,$00,$C1,$03,$01,$C1,$03,$00,$0A,$01,$00,$C3,$03,$00,$C3,$00;819B80;      ;
                       db $00,$34,$04,$00,$2E,$04,$00,$2F,$04,$00,$30,$04,$01,$30,$04,$00;819B90;      ;
                       db $31,$04,$00,$32,$04,$00,$33,$04,$01,$33,$04,$00,$C4,$00,$00,$35;819BA0;      ;
                       db $04,$00,$0B,$01,$00,$D0,$03,$00,$CC,$03,$00,$CC,$03,$00,$CC,$03;819BB0;      ;
                       db $01,$CC,$03,$00,$CD,$03,$00,$CE,$03,$00,$CF,$03,$01,$CF,$03,$00;819BC0;      ;
                       db $13,$01,$00,$00,$00,$00,$0C,$01,$00,$D8,$03,$00,$D4,$03,$00,$D4;819BD0;      ;
                       db $03,$00,$D4,$03,$01,$D4,$03,$00,$D5,$03,$00,$D6,$03,$00,$D7,$03;819BE0;      ;
                       db $01,$D7,$03,$00,$14,$01,$00,$00,$00,$00,$0D,$01,$00,$E0,$03,$00;819BF0;      ;
                       db $DC,$03,$00,$DC,$03,$00,$DC,$03,$01,$DC,$03,$00,$DD,$03,$00,$DE;819C00;      ;
                       db $03,$00,$DF,$03,$01,$DF,$03,$00,$15,$01,$00,$00,$00,$00,$0E,$01;819C10;      ;
                       db $00,$E7,$03,$00,$E1,$03,$00,$E2,$03,$00,$E3,$03,$01,$E3,$03,$00;819C20;      ;
                       db $E4,$03,$00,$E5,$03,$00,$E6,$03,$01,$E6,$03,$00,$03,$01,$00,$E8;819C30;      ;
                       db $03,$00,$0F,$01,$00,$EF,$03,$00,$E9,$03,$00,$EA,$03,$00,$EB,$03;819C40;      ;
                       db $01,$EB,$03,$00,$EC,$03,$00,$ED,$03,$00,$EE,$03,$01,$EE,$03,$00;819C50;      ;
                       db $03,$01,$00,$F0,$03,$00,$10,$01,$00,$F7,$03,$00,$F1,$03,$00,$F2;819C60;      ;
                       db $03,$00,$F3,$03,$01,$F3,$03,$00,$F4,$03,$00,$F5,$03,$00,$F6,$03;819C70;      ;
                       db $01,$F6,$03,$00,$03,$01,$00,$F8,$03,$00,$11,$01,$00,$FF,$03,$00;819C80;      ;
                       db $F9,$03,$00,$FA,$03,$00,$FB,$03,$01,$FB,$03,$00,$FC,$03,$00,$FD;819C90;      ;
                       db $03,$00,$FE,$03,$01,$FE,$03,$00,$03,$01,$00,$00,$04,$00,$12,$01;819CA0;      ;
                       db $00,$07,$04,$00,$01,$04,$00,$02,$04,$00,$03,$04,$01,$03,$04,$00;819CB0;      ;
                       db $04,$04,$00,$05,$04,$00,$06,$04,$01,$06,$04,$00,$03,$01,$00,$08;819CC0;      ;
                       db $04,$00,$D3,$03,$00,$D2,$03,$00,$D1,$03,$00,$D1,$03,$00,$D1,$03;819CD0;      ;
                       db $01,$D1,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00;819CE0;      ;
                       db $00,$00,$00,$00,$00,$00,$17,$01,$00,$BD,$00,$00,$00,$00,$00,$00;819CF0;      ;
                       db $00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$BC,$00,$00,$00,$00;819D00;      ;
                       db $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$12,$02,$00,$14,$04,$00;819D10;      ;
                       db $0E,$04,$00,$0F,$04,$00,$10,$04,$01,$10,$04,$00,$11,$04,$00,$12;819D20;      ;
                       db $04,$00,$13,$04,$01,$13,$04,$00,$00,$00,$00,$15,$04,$00,$17,$02;819D30;      ;
                       db $00,$1C,$04,$00,$16,$04,$00,$17,$04,$00,$18,$04,$01,$18,$04,$00;819D40;      ;
                       db $19,$04,$00,$1A,$04,$00,$1B,$04,$01,$1B,$04,$00,$00,$00,$00,$1D;819D50;      ;
                       db $04,$00,$D9,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;819D60;      ;
                       db $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00;819D70;      ;
                       db $00,$00,$00,$00,$00,$00,$E5,$00,$00,$26,$01,$00,$20,$01,$00,$21;819D80;      ;
                       db $01,$00,$22,$01,$01,$22,$01,$00,$23,$01,$00,$24,$01,$00,$25,$01;819D90;      ;
                       db $01,$25,$01,$00,$B4,$00,$00,$27,$01,$00,$26,$03,$00,$24,$04,$00;819DA0;      ;
                       db $1E,$04,$00,$1F,$04,$00,$20,$04,$01,$20,$04,$00,$21,$04,$00,$22;819DB0;      ;
                       db $04,$00,$23,$04,$01,$23,$04,$00,$00,$00,$00,$25,$04,$00,$D8,$00;819DC0;      ;
                       db $00,$D8,$00,$00,$67,$01,$00,$68,$01,$00,$69,$01,$01,$69,$01,$00;819DD0;      ;
                       db $D9,$00,$00,$D9,$00,$00,$6A,$01,$00,$6B,$01,$00,$6C,$01,$01,$6C;819DE0;      ;
                       db $01,$00,$DA,$00,$00,$DA,$00,$00,$6D,$01,$00,$6E,$01,$00,$6F,$01;819DF0;      ;
                       db $01,$6F,$01,$00,$DB,$00,$00,$DB,$00,$00,$70,$01,$00,$71,$01,$00;819E00;      ;
                       db $72,$01,$01,$72,$01,$00,$D0,$00,$00,$D0,$00,$00,$4F,$01,$00,$50;819E10;      ;
                       db $01,$00,$51,$01,$01,$51,$01,$00,$D1,$00,$00,$D1,$00,$00,$52,$01;819E20;      ;
                       db $00,$53,$01,$00,$54,$01,$01,$54,$01,$00,$D2,$00,$00,$D2,$00,$00;819E30;      ;
                       db $55,$01,$00,$56,$01,$00,$57,$01,$01,$57,$01,$00,$D3,$00,$00,$D3;819E40;      ;
                       db $00,$00,$58,$01,$00,$59,$01,$00,$5A,$01,$01,$5A,$01,$00,$CC,$00;819E50;      ;
                       db $00,$CC,$00,$00,$43,$01,$00,$44,$01,$00,$45,$01,$01,$45,$01,$00;819E60;      ;
                       db $CD,$00,$00,$CD,$00,$00,$46,$01,$00,$47,$01,$00,$48,$01,$01,$48;819E70;      ;
                       db $01,$00,$CE,$00,$00,$CE,$00,$00,$49,$01,$00,$4A,$01,$00,$4B,$01;819E80;      ;
                       db $01,$4B,$01,$00,$CF,$00,$00,$CF,$00,$00,$4C,$01,$00,$4D,$01,$00;819E90;      ;
                       db $4E,$01,$01,$4E,$01,$00,$D4,$00,$00,$D4,$00,$00,$5B,$01,$00,$5C;819EA0;      ;
                       db $01,$00,$5D,$01,$01,$5D,$01,$00,$D5,$00,$00,$D5,$00,$00,$5E,$01;819EB0;      ;
                       db $00,$5F,$01,$00,$60,$01,$01,$60,$01,$00,$D6,$00,$00,$D6,$00,$00;819EC0;      ;
                       db $61,$01,$00,$62,$01,$00,$63,$01,$01,$63,$01,$00,$D7,$00,$00,$D7;819ED0;      ;
                       db $00,$00,$64,$01,$00,$65,$01,$00,$66,$01,$01,$66,$01,$00,$E0,$00;819EE0;      ;
                       db $00,$E0,$00,$00,$7C,$01,$00,$7D,$01,$00,$7E,$01,$01,$7E,$01,$00;819EF0;      ;
                       db $E1,$00,$00,$E1,$00,$00,$7F,$01,$00,$80,$01,$00,$81,$01,$01,$81;819F00;      ;
                       db $01,$00,$E3,$00,$00,$E3,$00,$00,$85,$01,$00,$86,$01,$00,$87,$01;819F10;      ;
                       db $01,$87,$01,$00,$E2,$00,$00,$E2,$00,$00,$82,$01,$00,$83,$01,$00;819F20;      ;
                       db $84,$01,$01,$84,$01,$00,$DF,$00,$00,$DF,$00,$00,$79,$01,$00,$7A;819F30;      ;
                       db $01,$00,$7B,$01,$01,$7B,$01,$00,$E4,$00,$00,$E4,$00,$00,$89,$01;819F40;      ;
                       db $00,$89,$01,$00,$89,$01,$01,$89,$01,$00,$E5,$00,$00,$E5,$00,$00;819F50;      ;
                       db $8A,$01,$00,$8A,$01,$00,$8A,$01,$01,$8A,$01,$00,$DC,$00,$00,$DC;819F60;      ;
                       db $00,$00,$88,$01,$00,$88,$01,$00,$88,$01,$01,$88,$01,$00,$DE,$00;819F70;      ;
                       db $00,$DE,$00,$00,$76,$01,$00,$77,$01,$00,$78,$01,$01,$78,$01,$00;819F80;      ;
                       db $DD,$00,$00,$DD,$00,$00,$73,$01,$00,$74,$01,$00,$75,$01,$01,$75;819F90;      ;
                       db $01,$00,$FB,$00,$00,$CA,$03,$00,$C4,$03,$00,$C5,$03,$00,$C6,$03;819FA0;      ;
                       db $01,$C6,$03,$00,$C7,$03,$00,$C8,$03,$00,$C9,$03,$01,$C9,$03,$00;819FB0;      ;
                       db $0A,$01,$00,$CB,$03,$00           ;819FC0;      ;
                                                            ;      ;      ;
         DATA8_819FC6: db $66,$03,$0A,$67,$03,$F6,$68,$03,$0A,$69,$03,$0A,$6A,$03,$32,$6B;819FC6;      ;
                       db $03,$32,$6C,$03,$0A,$6D,$03,$0A   ;819FD6;      ;
                                                            ;      ;      ;
Items_Price_Table:     db $00,$00,$00,$0F,$00,$14,$00,$0F,$00,$14,$00,$3C,$00,$00,$00,$1E;819FDE;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$10,$00,$14,$00;819FEE;      ;
                       db $00,$0C,$00,$0A,$00,$08,$00,$06,$00,$05,$00,$0F,$00,$19,$00,$23;819FFE;      ;
                       db $00,$14,$00,$00,$99,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A00E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A01E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A02E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A03E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A04E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A05E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A06E;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$14,$00;81A07E;      ;
                       db $00,$00,$00,$00,$00,$00           ;81A08E;      ;
                                                            ;      ;      ;
         DATA8_81A094: db $00,$00,$00,$58,$03,$14,$59,$03,$1E,$5B,$03,$14,$5C,$03,$1E,$5D;81A094;      ;
                       db $03,$3C,$13,$03,$00,$5E,$03,$1E,$00,$00,$00,$00,$00,$00,$00,$00;81A0A4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A0B4;      ;
                       db $53,$03,$18,$54,$03,$14,$55,$03,$10,$56,$03,$0C,$57,$03,$0A,$50;81A0C4;      ;
                       db $03,$14,$51,$03,$1E,$52,$03,$28,$5A,$03,$14,$13,$03,$00,$00,$00;81A0D4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A0E4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$13;81A0F4;      ;
                       db $03,$00,$13,$03,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A104;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A114;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A124;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A134;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A144;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A154;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A164;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A174;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A184;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A194;      ;
                       db $00                               ;81A1A4;      ;
                                                            ;      ;      ;
         DATA8_81A1A5: db $F6,$02,$F7,$02,$11,$02,$F9,$02,$BB,$CE,$FF,$FF,$3F,$03,$F7,$02;81A1A5;      ;
                       db $11,$02,$F9,$02,$B7,$E2,$FF,$FF,$3C,$03,$F7,$02,$11,$02,$F9,$02;81A1B5;      ;
                       db $B8,$E2,$FF,$FF,$3D,$03,$F7,$02,$11,$02,$F9,$02,$B9,$EC,$FF,$FF;81A1C5;      ;
                       db $3E,$03,$F7,$02,$11,$02,$F9,$02,$BA,$EC,$FF,$FF,$40,$03,$F8,$02;81A1D5;      ;
                       db $11,$02,$F9,$02,$BC,$E2,$FF,$FF,$FC,$02,$FD,$02,$FE,$02,$FF,$02;81A1E5;      ;
                       db $D1,$6A,$FF,$FF,$12,$03,$FD,$02,$FE,$02,$FF,$02,$D0,$4C,$FF,$FF;81A1F5;      ;
                       db $14,$03,$FD,$02,$FE,$02,$FF,$02,$CF,$B0,$FF,$FF,$44,$03,$FD,$02;81A205;      ;
                       db $FE,$02,$FF,$02,$CA,$38,$FF,$FF,$45,$03,$FD,$02,$FE,$02,$FF,$02;81A215;      ;
                       db $CB,$38,$FF,$FF,$46,$03,$FD,$02,$FE,$02,$FF,$02,$CC,$38,$FF,$FF;81A225;      ;
                       db $47,$03,$FD,$02,$FE,$02,$FF,$02,$CD,$38,$FF,$FF,$43,$03,$FD,$02;81A235;      ;
                       db $FE,$02,$FF,$02,$CE,$38,$FF,$FF,$01,$03,$02,$03,$03,$03,$04,$03;81A245;      ;
                       db $D7,$9C,$FF,$FF,$3B,$03,$02,$03,$03,$03,$04,$03,$D6,$70,$FE,$FF;81A255;      ;
                       db $42,$03,$08,$03,$03,$03,$04,$03,$D9,$E2,$FF,$FF,$41,$03,$08,$03;81A265;      ;
                       db $03,$03,$04,$03,$D8,$C4,$FF,$FF,$48,$03,$49,$03,$4A,$03,$FF,$02;81A275;      ;
                       db $C5,$CE,$FF,$FF,$0E,$02,$10,$02,$11,$02,$F9,$02,$F8,$9C,$FF,$FF;81A285;      ;
                       db $0D,$02,$10,$02,$11,$02,$F9,$02,$F7,$9C,$FF,$FF,$0F,$02,$10,$02;81A295;      ;
                       db $11,$02,$F9,$02,$F9,$9C,$FF,$FF   ;81A2A5;      ;
                                                            ;      ;      ;
         DATA8_81A2AD: db $00,$01,$01,$01,$01,$03,$00,$00,$00,$02,$02,$02,$01,$02,$02,$02;81A2AD;      ;
                       db $4C,$32,$07,$07,$2E,$00,$00,$00,$20,$01,$00,$12,$12,$12,$00,$00;81A2BD;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$2A,$2B,$2B,$2D,$2A,$2B;81A2CD;      ;
                       db $2B,$2D,$2A,$2B,$2B,$2C,$2A,$2B,$2B,$2C,$2A,$2B,$2B,$2D,$2C,$2B;81A2DD;      ;
                       db $2A,$2B,$2E,$2E,$00,$00,$00,$00,$00,$21,$21,$21,$21,$20,$20,$20;81A2ED;      ;
                       db $20,$20,$22,$22,$22,$22,$22,$00,$12,$12,$12;81A2FD;      ;
                                                            ;      ;      ;
         DATA8_81A308: db $00,$01,$01,$01,$01,$01,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01;81A308;      ;
                       db $01,$01,$01,$01,$00,$00,$00,$00,$01,$01,$01,$00,$00,$00,$00,$00;81A318;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A328;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A338;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81A348;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00;81A358;      ;
                                                            ;      ;      ;
         DATA8_81A363: dw $0218,$0208,$01A8,$00D2,$02E8,$00F2,$0318,$0252;81A363;      ;
                       dw $00E8,$0322,$0298,$0372,$02B0,$0170,$0068,$0250;81A373;      ;
                                                            ;      ;      ;
BAAAA: ;81A383
        %Set16bit(!MX)
        LDA.W #$B4E6
        STA.B $07
        %Set8bit(!M)
        LDA.B #$7E
        STA.B $09                            ;Sets 09 pointer
        LDX.W #$0000

    .start:
        PHX
        %Set8bit(!M)
        LDA.B [$07]
        AND.B #$01
        BNE +
        JMP.W .increasePointer

        + %Set8bit(!M)
        LDY.W #$0000
        LDA.B [$07],Y
        STA.W $0974
        LDY.W #$0001
        LDA.B [$07],Y
        STA.W $0975                          ;save location?
        LDY.W #$0002
        LDA.B [$07],Y
        STA.W $0976
        LDY.W #$0003
        LDA.B [$07],Y
        STA.W $0984
        %Set16bit(!M)
        LDY.W #$0004
        LDA.B [$07],Y
        STA.W $0978
        STA.B $A5
        LDY.W #$0006
        LDA.B [$07],Y
        STA.W $097A
        LDY.W #$0008
        LDA.B [$07],Y
        STA.W $097C
        LDY.W #$000A
        LDA.B [$07],Y
        STA.W $097E
        LDY.W #$000C
        LDA.B [$07],Y
        STA.W $0980
        LDY.W #$000E
        LDA.B [$07],Y
        STA.W $0982
        JSL.L CODE_8581CB
        %Set16bit(!M)
        LDA.B $A7
        CMP.W #$FFFD
        BNE +
        JMP.W .skip1

        + CMP.W #$FFFF
        BEQ .skip2
        %Set8bit(!M)
        LDA.W $0974
        AND.B #$04
        BNE +
        JML.L .increasePointer

        + BRA .skip2                      ;81A417;81A431;

        .skip1: %Set16bit(!M)                             ;81A419;      ;
        LDA.W $0978                          ;81A41B;000978;
        STA.B $A5                            ;81A41E;0000A5;
        JSL.L CODE_8581A2                    ;81A420;8581A2;
        %Set8bit(!M)                             ;81A424;      ;
        LDA.W $0974                          ;81A426;000974;
        AND.B #$02                           ;81A429;      ;
        BEQ .skip2                      ;81A42B;81A431;
        JSL.L CODE_81A4F1                    ;81A42D;81A4F1;

        .skip2: %Set8bit(!M)                             ;81A431;      ;
        LDA.B #$00                           ;81A433;      ;
        XBA                                  ;81A435;      ;
        LDY.W #$0001                         ;81A436;      ;
        LDA.B [$07],Y                        ;81A439;000007;
        %Set16bit(!M)                             ;81A43B;      ;
        ASL A                                ;81A43D;      ;
        TAX                                  ;81A43E;      ;
        CPX.W #$0000                         ;81A43F;      ;
        BEQ .increasePointer                 ;81A442;81A4B2;
        JSR.W (DATA8_81A58B,X)                ;81A444;81A58B;
        %Set8bit(!M)                             ;81A447;      ;
        LDY.W #$0000                         ;81A449;      ;
        LDA.W $0974                          ;81A44C;000974;
        STA.B [$07],Y                        ;81A44F;000007;
        LDY.W #$0002                         ;81A451;      ;
        LDA.W $0976                          ;81A454;000976;
        STA.B [$07],Y                        ;81A457;000007;
        LDY.W #$0003                         ;81A459;      ;
        LDA.W $0984                          ;81A45C;000984;
        STA.B [$07],Y                        ;81A45F;000007;
        %Set16bit(!M)                             ;81A461;      ;
        LDY.W #$0004                         ;81A463;      ;
        LDA.W $0978                          ;81A466;000978;
        STA.B [$07],Y                        ;81A469;000007;
        STA.B $A5                            ;81A46B;0000A5;
        LDY.W #$0006                         ;81A46D;      ;
        LDA.W $097A                          ;81A470;00097A;
        STA.B [$07],Y                        ;81A473;000007;
        LDY.W #$0008                         ;81A475;      ;
        LDA.W $097C                          ;81A478;00097C;
        STA.B [$07],Y                        ;81A47B;000007;
        LDY.W #$000A                         ;81A47D;      ;
        LDA.W $097E                          ;81A480;00097E;
        STA.B [$07],Y                        ;81A483;000007;
        STA.B $9F                            ;81A485;00009F;
        LDY.W #$000C                         ;81A487;      ;
        LDA.W $0980                          ;81A48A;000980;
        STA.B [$07],Y                        ;81A48D;000007;
        STA.B $9B                            ;81A48F;00009B;
        LDY.W #$000E                         ;81A491;      ;
        LDA.W $0982                          ;81A494;000982;
        STA.B [$07],Y                        ;81A497;000007;
        STA.B $9D                            ;81A499;00009D;
        JSL.L CODE_8580B9                    ;81A49B;8580B9;
        LDA.W $097A                          ;81A49F;00097A;
        CMP.W $097C                          ;81A4A2;00097C;
        BEQ .increasePointer                 ;81A4A5;81A4B2;
        STA.B $A1                            ;81A4A7;0000A1;
        LDY.W #$0008                         ;81A4A9;      ;
        STA.B [$07],Y                        ;81A4AC;000007;
        JSL.L CODE_858100                    ;81A4AE;858100;

        .increasePointer: %Set16bit(!MX)                             ;81A4B2;      ;
        PLX                                  ;81A4B4;      ;
        LDA.B $07                            ;81A4B5;000007;
        CLC                                  ;81A4B7;      ;
        ADC.W #$0010                         ;81A4B8;      ;
        STA.B $07                            ;81A4BB;000007;
        INX                                  ;81A4BD;      ;
        CPX.W #$000A                         ;81A4BE;      ;
        BEQ .return                          ;81A4C1;81A4C6;
        JMP.W .start                    ;81A4C3;81A393;

    .return: RTL                                  ;81A4C6;      ;END_BAAAA

;;;;;;;;
UNK_PresetsMemory3: ;81A4C7
        %Set16bit(!MX)
        LDA.W #$B4E6
        STA.B $07
        %Set8bit(!M)
        LDA.B #$7E
        STA.B $09
        LDX.W #$0000

    .loop:
            %Set8bit(!M)
            LDY.W #$0000
            LDA.B #$00
            STA.B [$07],Y
            %Set16bit(!M)
            LDA.B $07
            CLC
            ADC.W #$0010
            STA.B $07
            INX
            CPX.W #$000A
            BNE .loop

        RTL

;;;;;;;;
CODE_81A4F1:
        %Set8bit(!M)                             ;81A4F1;      ;
        %Set16bit(!X)                             ;81A4F3;      ;
        LDY.W #$0000                         ;81A4F5;      ;
        LDA.B #$00                           ;81A4F8;      ;
        STA.B [$07],Y                        ;81A4FA;000007;
        STZ.W $0974                          ;81A4FC;000974;

        RTL                                  ;81A4FF;      ;

;;;;;;;;
CODE_81A500:
        %Set16bit(!MX)                             ;81A500;      ;
        LDA.W #$B4E6                         ;81A502;      ;
        STA.B $07                            ;81A505;000007;
        %Set8bit(!M)                             ;81A507;      ;
        LDA.B #$7E                           ;81A509;      ;
        STA.B $09                            ;81A50B;000009;
        LDX.W #$0000                         ;81A50D;      ;
                                            ;      ;      ;
        CODE_81A510:
        %Set8bit(!M)                             ;81A510;      ;
        LDA.B [$07]                          ;81A512;000007;
        AND.B #$01                           ;81A514;      ;
        BEQ CODE_81A52A                      ;81A516;81A52A;
        %Set16bit(!M)                             ;81A518;      ;
        LDA.B $07                            ;81A51A;000007;
        CLC                                  ;81A51C;      ;
        ADC.W #$0010                         ;81A51D;      ;
        STA.B $07                            ;81A520;000007;
        INX                                  ;81A522;      ;
        CPX.W #$000A                         ;81A523;      ;
        BNE CODE_81A510                      ;81A526;81A510;
                                            ;      ;      ;
        CODE_81A528:
        BRA CODE_81A528                      ;81A528;81A528;
                                            ;      ;      ;
                                            ;      ;      ;
        CODE_81A52A:
        %Set8bit(!M)                             ;81A52A;      ;
        LDY.W #$0000                         ;81A52C;      ;
        LDA.W $0974                          ;81A52F;000974;
        STA.B [$07],Y                        ;81A532;000007;
        LDY.W #$0001                         ;81A534;      ;
        LDA.W $0975                          ;81A537;000975;
        STA.B [$07],Y                        ;81A53A;000007;
        LDY.W #$0002                         ;81A53C;      ;
        LDA.W $0976                          ;81A53F;000976;
        STA.B [$07],Y                        ;81A542;000007;
        LDY.W #$0003                         ;81A544;      ;
        LDA.W $0984                          ;81A547;000984;
        STA.B [$07],Y                        ;81A54A;000007;
        %Set16bit(!M)                             ;81A54C;      ;
        LDY.W #$0006                         ;81A54E;      ;
        LDA.W $097A                          ;81A551;00097A;
        STA.B [$07],Y                        ;81A554;000007;
        LDY.W #$0008                         ;81A556;      ;
        STA.B [$07],Y                        ;81A559;000007;
        STA.B $A1                            ;81A55B;0000A1;
        LDY.W #$000A                         ;81A55D;      ;
        LDA.W $097E                          ;81A560;00097E;
        STA.B [$07],Y                        ;81A563;000007;
        STA.B $9F                            ;81A565;00009F;
        LDY.W #$000C                         ;81A567;      ;
        LDA.W $0980                          ;81A56A;000980;
        STA.B [$07],Y                        ;81A56D;000007;
        STA.B $9B                            ;81A56F;00009B;
        LDY.W #$000E                         ;81A571;      ;
        LDA.W $0982                          ;81A574;000982;
        STA.B [$07],Y                        ;81A577;000007;
        STA.B $9D                            ;81A579;00009D;
        STZ.B $A3                            ;81A57B;0000A3;
        JSL.L CODE_858000                    ;81A57D;858000;
        %Set16bit(!MX)                             ;81A581;      ;
        LDY.W #$0004                         ;81A583;      ;
        LDA.B $A5                            ;81A586;0000A5;
        STA.B [$07],Y                        ;81A588;000007;

        RTL                                  ;81A58A;      ;

DATA8_81A58B: db $FF,$FF,$9A,$80                   ;81A58B;      ;
                                                            ;      ;      ;
          CODE_81A58F: %Set8bit(!M)                             ;81A58F;      ;
                       %Set16bit(!X)                             ;81A591;      ;
                       LDA.L !season                        ;81A593;7F1F19;
                       CMP.B #$03                           ;81A597;      ;
                       BNE CODE_81A5E0                      ;81A599;81A5E0;
                       LDA.B !tilemap_to_load                            ;81A59B;000022;
                       CMP.B #$04                           ;81A59D;      ;
                       BCC CODE_81A5A9                      ;81A59F;81A5A9;
                       CMP.B #$10                           ;81A5A1;      ;
                       BCC CODE_81A5E0                      ;81A5A3;81A5E0;
                       CMP.B #$15                           ;81A5A5;      ;
                       BCS CODE_81A5E0                      ;81A5A7;81A5E0;
                                                            ;      ;      ;
          CODE_81A5A9: %Set16bit(!MX)                             ;81A5A9;      ;
                       LDA.W #$0000                         ;81A5AB;      ;
                       LDX.W $0907                          ;81A5AE;000907;
                       LDY.W $0909                          ;81A5B1;000909;
                       JSL.L UNK_CheckTileProperty                          ;81A5B4;82AC61;
                       %Set16bit(!MX)                             ;81A5B8;      ;
                       TXA                                  ;81A5BA;      ;
                       CMP.W #$0001                         ;81A5BB;      ;
                       BEQ CODE_81A5D1                      ;81A5BE;81A5D1;
                       CMP.W #$0002                         ;81A5C0;      ;
                       BEQ CODE_81A5D1                      ;81A5C3;81A5D1;
                       CMP.W #$00A8                         ;81A5C5;      ;
                       BEQ CODE_81A5D1                      ;81A5C8;81A5D1;
                       CMP.W #$00F6                         ;81A5CA;      ;
                       BEQ CODE_81A5D1                      ;81A5CD;81A5D1;
                       BRA CODE_81A5E0                      ;81A5CF;81A5E0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A5D1: %Set16bit(!MX)                             ;81A5D1;      ;
                       LDA.W #$0011                         ;81A5D3;      ;
                       LDX.W $0907                          ;81A5D6;000907;
                       LDY.W $0909                          ;81A5D9;000909;
                       JSL.L CODE_81A6C1                    ;81A5DC;81A6C1;
                                                            ;      ;      ;
          CODE_81A5E0: RTL                                  ;81A5E0;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A5E1: %Set16bit(!MX)                             ;81A5E1;      ;
                       STA.B $7E                            ;81A5E3;00007E;
                       ASL A                                ;81A5E5;      ;
                       CLC                                  ;81A5E6;      ;
                       ADC.B $7E                            ;81A5E7;00007E;
                       TAX                                  ;81A5E9;      ;
                       LDA.L DATA16_81B963,X                ;81A5EA;81B963;
                       STA.B $CF                            ;81A5EE;0000CF;
                       INX                                  ;81A5F0;      ;
                       INX                                  ;81A5F1;      ;
                       %Set8bit(!M)                             ;81A5F2;      ;
                       LDA.L DATA16_81B963,X                ;81A5F4;81B963;
                       STA.B $D1                            ;81A5F8;0000D1;
                       %Set8bit(!M)                             ;81A5FA;      ;
                       STZ.W $0989                          ;81A5FC;000989;
                       RTL                                  ;81A5FF;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A600: %Set16bit(!MX)                             ;81A600;      ;
                       LDA.B $CF                            ;81A602;0000CF;
                       BNE CODE_81A60E                      ;81A604;81A60E;
                       %Set8bit(!M)                             ;81A606;      ;
                       LDA.B $D1                            ;81A608;0000D1;
                       BNE CODE_81A60E                      ;81A60A;81A60E;
                       BRA CODE_81A65C                      ;81A60C;81A65C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A60E: %Set8bit(!M)                             ;81A60E;      ;
                       LDA.W $0989                          ;81A610;000989;
                       BNE CODE_81A659                      ;81A613;81A659;
                       %Set16bit(!M)                             ;81A615;      ;
                       LDA.B [$CF]                          ;81A617;0000CF;
                       CMP.W #$FFFF                         ;81A619;      ;
                       BNE CODE_81A621                      ;81A61C;81A621;
                       JMP.W CODE_81A65D                    ;81A61E;81A65D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A621: CMP.W #$FFFE                         ;81A621;      ;
                       BNE CODE_81A629                      ;81A624;81A629;
                       JMP.W CODE_81A667                    ;81A626;81A667;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A629: %Set16bit(!M)                             ;81A629;      ;
                       LDY.W #$0000                         ;81A62B;      ;
                       LDA.B [$CF],Y                        ;81A62E;0000CF;
                       PHA                                  ;81A630;      ;
                       INY                                  ;81A631;      ;
                       INY                                  ;81A632;      ;
                       LDA.B [$CF],Y                        ;81A633;0000CF;
                       PHA                                  ;81A635;      ;
                       INY                                  ;81A636;      ;
                       INY                                  ;81A637;      ;
                       LDA.B [$CF],Y                        ;81A638;0000CF;
                       PHA                                  ;81A63A;      ;
                       %Set8bit(!M)                             ;81A63B;      ;
                       INY                                  ;81A63D;      ;
                       INY                                  ;81A63E;      ;
                       LDA.B [$CF],Y                        ;81A63F;0000CF;
                       STA.W $0989                          ;81A641;000989;
                       %Set16bit(!M)                             ;81A644;      ;
                       PLY                                  ;81A646;      ;
                       PLX                                  ;81A647;      ;
                       PLA                                  ;81A648;      ;
                       JSL.L CODE_81A688                    ;81A649;81A688;
                       %Set16bit(!MX)                             ;81A64D;      ;
                       LDA.B $CF                            ;81A64F;0000CF;
                       CLC                                  ;81A651;      ;
                       ADC.W #$0007                         ;81A652;      ;
                       STA.B $CF                            ;81A655;0000CF;
                       BRA CODE_81A65C                      ;81A657;81A65C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A659: DEC.W $0989                          ;81A659;000989;
                                                            ;      ;      ;
          CODE_81A65C: RTL                                  ;81A65C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A65D: %Set16bit(!MX)                             ;81A65D;      ;
                       STZ.B $CF                            ;81A65F;0000CF;
                       %Set8bit(!M)                             ;81A661;      ;
                       STZ.B $D1                            ;81A663;0000D1;
                       BRA CODE_81A65C                      ;81A665;81A65C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A667: %Set16bit(!MX)                             ;81A667;      ;
                       LDY.W #$0000                         ;81A669;      ;
                       INY                                  ;81A66C;      ;
                       INY                                  ;81A66D;      ;
                       LDA.B [$CF],Y                        ;81A66E;0000CF;
                       STA.B $72                            ;81A670;000072;
                       INY                                  ;81A672;      ;
                       INY                                  ;81A673;      ;
                       %Set8bit(!M)                             ;81A674;      ;
                       LDA.B [$CF],Y                        ;81A676;0000CF;
                       STA.B $74                            ;81A678;000074;
                       %Set16bit(!M)                             ;81A67A;      ;
                       LDA.B $72                            ;81A67C;000072;
                       STA.B $CF                            ;81A67E;0000CF;
                       %Set8bit(!M)                             ;81A680;      ;
                       LDA.B $74                            ;81A682;000074;
                       STA.B $D1                            ;81A684;0000D1;
                       BRA CODE_81A629                      ;81A686;81A629;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A688: %Set16bit(!MX)                             ;81A688;      ;
                       CMP.W #$0000                         ;81A68A;      ;
                       BNE CODE_81A692                      ;81A68D;81A692;
                       JMP.W CODE_81A6C0                    ;81A68F;81A6C0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A692: PHY                                  ;81A692;      ;
                       PHX                                  ;81A693;      ;
                       PHA                                  ;81A694;      ;
                       JSL.L CODE_81A6C1                    ;81A695;81A6C1;
                       %Set16bit(!MX)                             ;81A699;      ;
                       PLA                                  ;81A69B;      ;
                       PLX                                  ;81A69C;      ;
                       PLY                                  ;81A69D;      ;
                       PHY                                  ;81A69E;      ;
                       PHX                                  ;81A69F;      ;
                       PHA                                  ;81A6A0;      ;
                       JSL.L SUB_81A83A                           ;81A6A1;81A83A;
                       %Set16bit(!MX)                             ;81A6A5;      ;
                       PLA                                  ;81A6A7;      ;
                       JSL.L SUB_81A801                    ;81A6A8;81A801;
                       %Set16bit(!MX)                             ;81A6AC;      ;
                       PLX                                  ;81A6AE;      ;
                       PLY                                  ;81A6AF;      ;
                       LDA.B $80                            ;81A6B0;000080;
                       STA.B $86                            ;81A6B2;000086;
                       LDA.B $82                            ;81A6B4;000082;
                       STA.B $88                            ;81A6B6;000088;
                       LDA.B $84                            ;81A6B8;000084;
                       BEQ CODE_81A6C0                      ;81A6BA;81A6C0;
                       JSL.L SUB_82B060                    ;81A6BC;82B060;
                                                            ;      ;      ;
          CODE_81A6C0: RTL                                  ;81A6C0;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A6C1: %Set16bit(!MX)                             ;81A6C1;      ;
                       PHA                                  ;81A6C3;      ;
                       TXA                                  ;81A6C4;      ;
                       LSR A                                ;81A6C5;      ;
                       LSR A                                ;81A6C6;      ;
                       LSR A                                ;81A6C7;      ;
                       LSR A                                ;81A6C8;      ;
                       STA.B $7E                            ;81A6C9;00007E;
                       TYA                                  ;81A6CB;      ;
                       LSR A                                ;81A6CC;      ;
                       LSR A                                ;81A6CD;      ;
                       LSR A                                ;81A6CE;      ;
                       LSR A                                ;81A6CF;      ;
                       STA.B $80                            ;81A6D0;000080;
                       LDA.W #$6000                         ;81A6D2;      ;
                       STA.B $86                            ;81A6D5;000086;
                       LDA.B $7E                            ;81A6D7;00007E;
                       CMP.W #$0020                         ;81A6D9;      ;
                       BCC CODE_81A6E2                      ;81A6DC;81A6E2;
                       SEC                                  ;81A6DE;      ;
                       SBC.W #$0020                         ;81A6DF;      ;
                                                            ;      ;      ;
          CODE_81A6E2: ASL A                                ;81A6E2;      ;
                       CLC                                  ;81A6E3;      ;
                       ADC.B $86                            ;81A6E4;000086;
                       STA.B $86                            ;81A6E6;000086;
                       LDA.B $7E                            ;81A6E8;00007E;
                       CMP.W #$0010                         ;81A6EA;      ;
                       BCC CODE_81A701                      ;81A6ED;81A701;
                       CMP.W #$0020                         ;81A6EF;      ;
                       BCC CODE_81A6F9                      ;81A6F2;81A6F9;
                       CMP.W #$0030                         ;81A6F4;      ;
                       BCC CODE_81A701                      ;81A6F7;81A701;
                                                            ;      ;      ;
          CODE_81A6F9: LDA.B $86                            ;81A6F9;000086;
                       CLC                                  ;81A6FB;      ;
                       ADC.W #$03E0                         ;81A6FC;      ;
                       STA.B $86                            ;81A6FF;000086;
                                                            ;      ;      ;
          CODE_81A701: LDA.B $80                            ;81A701;000080;
                       CMP.W #$0020                         ;81A703;      ;
                       BCC CODE_81A70C                      ;81A706;81A70C;
                       SEC                                  ;81A708;      ;
                       SBC.W #$0020                         ;81A709;      ;
                                                            ;      ;      ;
          CODE_81A70C: ASL A                                ;81A70C;      ;
                       ASL A                                ;81A70D;      ;
                       ASL A                                ;81A70E;      ;
                       ASL A                                ;81A70F;      ;
                       ASL A                                ;81A710;      ;
                       ASL A                                ;81A711;      ;
                       CLC                                  ;81A712;      ;
                       ADC.B $86                            ;81A713;000086;
                       STA.B $86                            ;81A715;000086;
                       LDA.B $80                            ;81A717;000080;
                       CMP.W #$0010                         ;81A719;      ;
                       BCC CODE_81A730                      ;81A71C;81A730;
                       CMP.W #$0020                         ;81A71E;      ;
                       BCC CODE_81A728                      ;81A721;81A728;
                       CMP.W #$0030                         ;81A723;      ;
                       BCC CODE_81A730                      ;81A726;81A730;
                                                            ;      ;      ;
          CODE_81A728: LDA.B $86                            ;81A728;000086;
                       CLC                                  ;81A72A;      ;
                       ADC.W #$0400                         ;81A72B;      ;
                       STA.B $86                            ;81A72E;000086;
                                                            ;      ;      ;
          CODE_81A730: %Set16bit(!M)                             ;81A730;      ;
                       LDA.W #$A096                         ;81A732;      ;
                       STA.B $72                            ;81A735;000072;
                       STA.B $75                            ;81A737;000075;
                       %Set8bit(!M)                             ;81A739;      ;
                       LDA.B #$A6                           ;81A73B;      ;
                       STA.B $74                            ;81A73D;000074;
                       STA.B $77                            ;81A73F;000077;
                       %Set16bit(!M)                             ;81A741;      ;
                       PLA                                  ;81A743;      ;
                       JSL.L SUB_81A801                    ;81A744;81A801;
                       %Set16bit(!M)                             ;81A748;      ;
                       LDA.B $80                            ;81A74A;000080;
                       ASL A                                ;81A74C;      ;
                       ASL A                                ;81A74D;      ;
                       STA.B $80                            ;81A74E;000080;
                       LDA.B $82                            ;81A750;000082;
                       ASL A                                ;81A752;      ;
                       STA.B $82                            ;81A753;000082;
                       LDA.B $72                            ;81A755;000072;
                       CLC                                  ;81A757;      ;
                       ADC.B $7E                            ;81A758;00007E;
                       STA.B $72                            ;81A75A;000072;
                       STA.B $75                            ;81A75C;000075;
                       %Set8bit(!M)                             ;81A75E;      ;
                       LDA.B #$02                           ;81A760;      ;
                       STA.B $92                            ;81A762;000092;
                       LDX.W #$0000                         ;81A764;      ;
                                                            ;      ;      ;
          CODE_81A767: PHX                                  ;81A767;      ;
                       %Set8bit(!M)                             ;81A768;      ;
                       LDA.B $92                            ;81A76A;000092;
                       STA.B !ProgDMA_Channel_Index                            ;81A76C;000027;
                       LDA.B #$18                           ;81A76E;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;81A770;000029;
                       %Set16bit(!M)                             ;81A772;      ;
                       LDY.B $80                            ;81A774;000080;
                       TXA                                  ;81A776;      ;
                       ASL A                                ;81A777;      ;
                       ASL A                                ;81A778;      ;
                       ASL A                                ;81A779;      ;
                       ASL A                                ;81A77A;      ;
                       ASL A                                ;81A77B;      ;
                       CLC                                  ;81A77C;      ;
                       ADC.B $86                            ;81A77D;000086;
                       TAX                                  ;81A77F;      ;
                       %Set16bit(!M)                             ;81A780;      ;
                       LDA.W #$0080                         ;81A782;      ;
                       JSL.L AddProgrammedDMA                ;81A785;808A33;
                       %Set16bit(!M)                             ;81A789;      ;
                       LDA.B $72                            ;81A78B;000072;
                       CLC                                  ;81A78D;      ;
                       ADC.W #$0040                         ;81A78E;      ;
                       STA.B $72                            ;81A791;000072;
                       PLX                                  ;81A793;      ;
                       INX                                  ;81A794;      ;
                       PHX                                  ;81A795;      ;
                       %Set8bit(!M)                             ;81A796;      ;
                       LDA.B $92                            ;81A798;000092;
                       INC A                                ;81A79A;      ;
                       STA.B !ProgDMA_Channel_Index                            ;81A79B;000027;
                       LDA.B #$18                           ;81A79D;      ;
                       STA.B !ProgDMA_Destination_Memory                            ;81A79F;000029;
                       %Set16bit(!M)                             ;81A7A1;      ;
                       LDY.B $80                            ;81A7A3;000080;
                       TXA                                  ;81A7A5;      ;
                       ASL A                                ;81A7A6;      ;
                       ASL A                                ;81A7A7;      ;
                       ASL A                                ;81A7A8;      ;
                       ASL A                                ;81A7A9;      ;
                       ASL A                                ;81A7AA;      ;
                       CLC                                  ;81A7AB;      ;
                       ADC.B $86                            ;81A7AC;000086;
                       TAX                                  ;81A7AE;      ;
                       %Set16bit(!M)                             ;81A7AF;      ;
                       LDA.W #$0080                         ;81A7B1;      ;
                       JSL.L AddProgrammedDMA                ;81A7B4;808A33;
                       %Set16bit(!M)                             ;81A7B8;      ;
                       LDA.B $75                            ;81A7BA;000075;
                       CLC                                  ;81A7BC;      ;
                       ADC.B $80                            ;81A7BD;000080;
                       STA.B $75                            ;81A7BF;000075;
                       STA.B $72                            ;81A7C1;000072;
                       %Set8bit(!M)                             ;81A7C3;      ;
                       STZ.B $92                            ;81A7C5;000092;
                       PLX                                  ;81A7C7;      ;
                       INX                                  ;81A7C8;      ;
                       CPX.B $82                            ;81A7C9;000082;
                       BNE CODE_81A767                      ;81A7CB;81A767;
                       RTL                                  ;81A7CD;      ;

;;;;;;;;
SUB_81A7CE:
        %Set16bit(!MX)                             ;81A7CE;      ;
        PHY                                  ;81A7D0;      ;
        PHX                                  ;81A7D1;      ;
        PHA                                  ;81A7D2;      ;
        JSL.L SUB_81A801                    ;81A7D3;81A801;
        %Set16bit(!MX)                             ;81A7D7;      ;
        PLA                                  ;81A7D9;      ;
        PLX                                  ;81A7DA;      ;
        PLY                                  ;81A7DB;      ;
        PHY                                  ;81A7DC;      ;
        PHX                                  ;81A7DD;      ;
        PHA                                  ;81A7DE;      ;
        JSL.L SUB_81A83A                           ;81A7DF;81A83A;
        %Set16bit(!MX)                             ;81A7E3;      ;
        PLA                                  ;81A7E5;      ;
        JSL.L SUB_81A801                    ;81A7E6;81A801;
        %Set16bit(!MX)                             ;81A7EA;      ;
        PLX                                  ;81A7EC;      ;
        PLY                                  ;81A7ED;      ;
        LDA.B $80                            ;81A7EE;000080;
        STA.B $86                            ;81A7F0;000086;
        LDA.B $82                            ;81A7F2;000082;
        STA.B $88                            ;81A7F4;000088;
        LDA.B $84                            ;81A7F6;000084;
        BEQ .return                      ;81A7F8;81A800;
        %Set8bit(!M)                             ;81A7FA;      ;
        JSL.L SUB_82B060                    ;81A7FC;82B060;

        .return: RTL                                  ;81A800;      ;

;;;;;;;; Params in A, returns in $80, $82, $84, $7E of data from the table
;;;;;;;; Theory, this is the "change x for this many tiles" data, need to check
SUB_81A801:
        %Set16bit(!MX)
        STA.B $7E
        ASL A
        ASL A
        CLC
        ADC.B $7E                            ;*3
        ADC.B $7E
        TAX
        LDA.L DATA8_81B363,X
        STA.B $7E
        INX
        INX
        %Set8bit(!M)
        LDA.L DATA8_81B363,X
        XBA
        LDA.B #$00
        XBA
        %Set16bit(!M)
        STA.B $82
        INX
        %Set8bit(!M)
        LDA.L DATA8_81B363,X
        XBA
        LDA.B #$00
        XBA
        %Set16bit(!M)
        STA.B $80
        INX
        LDA.L DATA8_81B363,X
        STA.B $84
        RTL

;;;;;;;; Param in A, X and Y
;;;;;;;; Replaces tiles in the graphics map
SUB_81A83A:
        %Set16bit(!MX)
        PHA
        TXA
        LSR A
        LSR A
        LSR A
        LSR A
        ASL A
        ASL A
        STA.B $7E
        TYA
        LSR A
        LSR A
        LSR A
        LSR A
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        STA.B $80
        LDA.W #$0040
        STA.B $88
        %Set8bit(!M)
        LDA.W $0181
        CMP.B #$01
        BEQ .skip
        %Set16bit(!M)
        LDA.B $80
        ASL A
        STA.B $80
        ASL.B $88
        %Set8bit(!M)
        LDA.W $0181
        CMP.B #$02
        BEQ .skip
        %Set16bit(!M)
        LDA.B $80
        ASL A
        STA.B $80
        ASL.B $88

    .skip:
        %Set16bit(!MX)
        LDA.B $7E
        CLC
        ADC.B $80
        STA.B $86
        PLA
        JSL.L SUB_81A801
        %Set16bit(!M)                             ;81A88B;      ;
        LDA.B $80                            ;81A88D;000080;
        ASL A                                ;81A88F;      ;
        ASL A                                ;81A890;      ;
        STA.B $80                            ;81A891;000080;
        %Set16bit(!M)                             ;81A893;      ;
        LDA.W #$A096                         ;81A895;      ;
        CLC                                  ;81A898;      ;
        ADC.B $7E                            ;81A899;00007E;
        STA.B $72                            ;81A89B;000072;
        STA.B $78                            ;81A89D;000078;
        %Set8bit(!M)                             ;81A89F;      ;
        LDA.B #$A6                           ;81A8A1;      ;
        STA.B $74                            ;81A8A3;000074;
        STA.B $7A                            ;81A8A5;00007A;
        %Set16bit(!M)                             ;81A8A7;      ;
        LDA.W #$2000                         ;81A8A9;      ;
        CLC                                  ;81A8AC;      ;
        ADC.B $86                            ;81A8AD;000086;
        STA.B $75                            ;81A8AF;000075;
        %Set8bit(!M)                             ;81A8B1;      ;
        LDA.B #$7E                           ;81A8B3;      ;
        STA.B $77                            ;81A8B5;000077;
        %Set16bit(!MX)                             ;81A8B7;      ;
        STZ.B $8E                            ;81A8B9;00008E;
        STZ.B $90                            ;81A8BB;000090;
        LDY.W #$0000                         ;81A8BD;      ;

    .CODE_81A8C0:
            PHY                                  ;81A8C0;      ;
            LDA.W #$0000                         ;81A8C1;      ;

        .CODE_81A8C4:
            PHA                                  ;81A8C4;      ;
            LDY.W #$0000                         ;81A8C5;      ;
            LDX.W #$0000                         ;81A8C8;      ;
            STZ.B $90                            ;81A8CB;000090;

        .CODE_81A8CD:
            LDA.B [$72],Y                        ;81A8CD;000072;
            PHY                                  ;81A8CF;      ;
            TXY                                  ;81A8D0;      ;
            STA.B [$75],Y                        ;81A8D1;000075;
            PLY                                  ;81A8D3;      ;
            INY                                  ;81A8D4;      ;
            INY                                  ;81A8D5;      ;
            INX                                  ;81A8D6;      ;
            INX                                  ;81A8D7;      ;
            PLA                                  ;81A8D8;      ;
            PHA                                  ;81A8D9;      ;
            CMP.W #$0000                         ;81A8DA;      ;
            BNE .CODE_81A8EF                      ;81A8DD;81A8EF;
            INC.B $90                            ;81A8DF;000090;
            INC.B $90                            ;81A8E1;000090;
            LDA.B $7E                            ;81A8E3;00007E;
            CLC                                  ;81A8E5;      ;
            ADC.B $90                            ;81A8E6;000090;
            AND.W #$0040                         ;81A8E8;      ;
            BEQ .CODE_81A910                      ;81A8EB;81A910;
            BRA .CODE_81A8FD                      ;81A8ED;81A8FD;

        .CODE_81A8EF:
            INC.B $90                            ;81A8EF;000090;
            INC.B $90                            ;81A8F1;000090;
            LDA.B $7E                            ;81A8F3;00007E;
            CLC                                  ;81A8F5;      ;
            ADC.B $90                            ;81A8F6;000090;
            AND.W #$0040                         ;81A8F8;      ;
            BEQ .CODE_81A910                      ;81A8FB;81A910;

        .CODE_81A8FD:
            LDA.W #$0040                         ;81A8FD;      ;
            STA.B $8E                            ;81A900;00008E;
            LDA.B $90                            ;81A902;000090;
            CLC                                  ;81A904;      ;
            ADC.W #$0040                         ;81A905;      ;
            STA.B $90                            ;81A908;000090;
            TYA                                  ;81A90A;      ;
            CLC                                  ;81A90B;      ;
            ADC.W #$0040                         ;81A90C;      ;
            TAY                                  ;81A90F;      ;

        .CODE_81A910:
            CPX.B $80                            ;81A910;000080;
            BNE .CODE_81A8CD                      ;81A912;81A8CD;
            LDA.B $72                            ;81A914;000072;
            CLC                                  ;81A916;      ;
            ADC.W #$0040                         ;81A917;      ;
            STA.B $72                            ;81A91A;000072;
            LDA.B $75                            ;81A91C;000075;
            CLC                                  ;81A91E;      ;
            ADC.B $88                            ;81A91F;000088;
            STA.B $75                            ;81A921;000075;
            PLA                                  ;81A923;      ;
            INC A                                ;81A924;      ;
            CMP.W #$0002                         ;81A925;      ;
            BNE .CODE_81A8C4                      ;81A928;81A8C4;
            %Set16bit(!M)                             ;81A92A;      ;
            LDA.B $78                            ;81A92C;000078;
            CLC                                  ;81A92E;      ;
            ADC.B $80                            ;81A92F;000080;
            ADC.B $8E                            ;81A931;00008E;
            STA.B $78                            ;81A933;000078;
            STA.B $72                            ;81A935;000072;
            STZ.B $8E                            ;81A937;00008E;
            LDA.B $7E                            ;81A939;00007E;
            CLC                                  ;81A93B;      ;
            ADC.B $90                            ;81A93C;000090;
            STA.B $7E                            ;81A93E;00007E;
            PLY                                  ;81A940;      ;
            INY                                  ;81A941;      ;
            CPY.B $82                            ;81A942;000082;
            BEQ .return                          ;81A944;81A949;
            JMP.W .CODE_81A8C0                    ;81A946;81A8C0;

    .return: RTL                                  ;81A949;      ;END_SUB_81A83A


          CODE_81A94A: %Set8bit(!M)                             ;81A94A;      ;
                       %Set16bit(!X)                             ;81A94C;      ;
                       LDA.W !tool_backpack                          ;81A94E;000923;
                       BNE CODE_81A956                      ;81A951;81A956;
                       JMP.W CODE_81A9E4                    ;81A953;81A9E4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A956: LDA.W !tool_selected                          ;81A956;000921;
                       BEQ CODE_81A9AE                      ;81A959;81A9AE;
                       CMP.B #$19                           ;81A95B;      ;
                       BCC CODE_81A979                      ;81A95D;81A979;
                       CMP.B #$19                           ;81A95F;      ;
                       BEQ CODE_81A96E                      ;81A961;81A96E;
                       %Set8bit(!M)                             ;81A963;      ;
                       LDA.W $0022                          ;81A965;000022;
                       CMP.B #$27                           ;81A968;      ;
                       BNE CODE_81A9AE                      ;81A96A;81A9AE;
                       BRA CODE_81A982                      ;81A96C;81A982;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A96E: %Set8bit(!M)                             ;81A96E;      ;
                       LDA.W $0022                          ;81A970;000022;
                       CMP.B #$28                           ;81A973;      ;
                       BNE CODE_81A9AE                      ;81A975;81A9AE;
                       BRA CODE_81A982                      ;81A977;81A982;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81A979: %Set8bit(!M)                             ;81A979;      ;
                       LDA.W $0022                          ;81A97B;000022;
                       CMP.B #$26                           ;81A97E;      ;
                       BNE CODE_81A9AE                      ;81A980;81A9AE;
                                                            ;      ;      ;
          CODE_81A982: %Set8bit(!M)                             ;81A982;      ;
                       %Set16bit(!X)                             ;81A984;      ;
                       LDA.B #$00                           ;81A986;      ;
                       XBA                                  ;81A988;      ;
                       LDA.W !tool_selected                          ;81A989;000921;
                       %Set16bit(!M)                             ;81A98C;      ;
                       ASL A                                ;81A98E;      ;
                       ASL A                                ;81A98F;      ;
                       ASL A                                ;81A990;      ;
                       TAX                                  ;81A991;      ;
                       LDA.L DATA16_81BE0F,X                ;81A992;81BE0F;
                       PHA                                  ;81A996;      ;
                       INX                                  ;81A997;      ;
                       INX                                  ;81A998;      ;
                       LDA.L DATA16_81BE0F,X                ;81A999;81BE0F;
                       PHA                                  ;81A99D;      ;
                       INX                                  ;81A99E;      ;
                       INX                                  ;81A99F;      ;
                       LDA.L DATA16_81BE0F,X                ;81A9A0;81BE0F;
                       PLY                                  ;81A9A4;      ;
                       PLX                                  ;81A9A5;      ;
                       JSL.L CODE_81A688                    ;81A9A6;81A688;
                       JSL.L StartProgramedDMA           ;81A9AA;808AF0;
                                                            ;      ;      ;
          CODE_81A9AE: %Set8bit(!M)                             ;81A9AE;      ;
                       %Set16bit(!X)                             ;81A9B0;      ;
                       LDA.B #$00                           ;81A9B2;      ;
                       XBA                                  ;81A9B4;      ;
                       LDA.W !tool_selected                          ;81A9B5;000921;
                       %Set16bit(!M)                             ;81A9B8;      ;
                       ASL A                                ;81A9BA;      ;
                       ASL A                                ;81A9BB;      ;
                       ASL A                                ;81A9BC;      ;
                       TAX                                  ;81A9BD;      ;
                       INX                                  ;81A9BE;      ;
                       INX                                  ;81A9BF;      ;
                       INX                                  ;81A9C0;      ;
                       INX                                  ;81A9C1;      ;
                       INX                                  ;81A9C2;      ;
                       INX                                  ;81A9C3;      ;
                       %Set8bit(!M)                             ;81A9C4;      ;
                       LDA.B #$00                           ;81A9C6;      ;
                       XBA                                  ;81A9C8;      ;
                       LDA.L DATA16_81BE0F,X                ;81A9C9;81BE0F;
                       %Set16bit(!M)                             ;81A9CD;      ;
                       TAY                                  ;81A9CF;      ;
                       INX                                  ;81A9D0;      ;
                       %Set8bit(!M)                             ;81A9D1;      ;
                       LDA.L DATA16_81BE0F,X                ;81A9D3;81BE0F;
                       STA.B $92                            ;81A9D7;000092;
                       TYX                                  ;81A9D9;      ;
                       LDA.L !shed_items_row_1,X                      ;81A9DA;7F1F00;
                       ORA.B $92                            ;81A9DE;000092;
                       STA.L !shed_items_row_1,X                      ;81A9E0;7F1F00;
                                                            ;      ;      ;
          CODE_81A9E4: RTL                                  ;81A9E4;      ;
                                                            ;      ;      ;
;;;;;;replaces tiles on maps, like tools in the workshop.
UNK_ExecuteFromPointers: ;81A9E5
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.B #$00
      XBA
      LDA.B !tilemap_to_load
      %Set16bit(!M)
      ASL A
      TAX
      JSR.W (PTR16_81A9F6,X)
      RTL

         PTR16_81A9F6: dw ReplaceTilesFarm                      ;81A9F6;00AAB6;0
                       dw ReplaceTilesFarm                      ;81A9F8;00AAB6;1
                       dw ReplaceTilesFarm                      ;81A9FA;00AAB6;2
                       dw ReplaceTilesFarm                      ;81A9FC;00AAB6;3
                       dw ReplaceTilesTown                      ;81A9FE;00AC71;4
                       dw ReplaceTilesTown                      ;81AA00;00AC71;5
                       dw ReplaceTilesTown                      ;81AA02;00AC71;6
                       dw ReplaceTilesTown                      ;81AA04;00AC71;7
                       dw ReplaceTilesFlowerFestival                      ;81AA06;00AC78;8
                       dw ReplaceTilesHarvestFestival                      ;81AA08;00AC79;9
                       dw DATA8_00AC7A                      ;81AA0A;00AC7A;A
                       dw DATA8_00AC7B                      ;81AA0C;00AC7B;B
                       dw ReplaceTilesForkSpring                      ;81AA0E;00AC7C;C
                       dw ReplaceTilesForkSummer                      ;81AA10;00AC7D;D
                       dw ReplaceTilesForkFall                      ;81AA12;00AC7E;E
                       dw ReplaceTilesForkWinter                      ;81AA14;00AC7F;F
                       dw ReplaceTilesMoutain                      ;81AA16;00AC80;10
                       dw ReplaceTilesMoutain                      ;81AA18;00AC80;11
                       dw ReplaceTilesMoutain                      ;81AA1A;00AC80;12
                       dw ReplaceTilesMoutain                      ;81AA1C;00AC80;13
                       dw DATA8_00ACCB                      ;81AA1E;00ACCB;14
                       dw ReplaceTilesHouse1                      ;81AA20;00ACCC;15
                       dw ReplaceTilesHouse2                      ;81AA22;00AD23;16
                       dw ReplaceTilesHouse3                      ;81AA24;00AD7A;17
                       dw ReplaceTilesMayorHouse                      ;81AA26;00ADD1;18
                       dw ReplaceTilesMayorHouseHall                      ;81AA28;00ADD2;19
                       dw ReplaceTilesMariasRoom                      ;81AA2A;00ADD3;1A
                       dw ReplaceTilesChurch                      ;81AA2C;00ADD4;1B
                       dw ReplaceTilesFlowerShop                      ;81AA2E;00ADD5;1C
                       dw ReplaceTilesFlowerShopRooms                      ;81AA30;00AE6A;1D
                       dw ReplaceTilesBar                      ;81AA32;00AE6B;1E
                       dw ReplaceTilesBarRooms                      ;81AA34;00AE6C;1F
                       dw ReplaceTilesRestaurant                      ;81AA36;00AE6D;20
                       dw ReplaceTilesRestaurantRooms                      ;81AA38;00AE6E;21
                       dw ReplaceTilesGeneralStore                      ;81AA3A;00AE6F;22
                       dw ReplaceTilesGeneralStoreRooms                      ;81AA3C;00AFBF;23
                       dw ReplaceTilesAnimalShop                      ;81AA3E;00AFC0;24
                       dw ReplaceTilesWitchHouse                      ;81AA40;00B063;25
                       dw ReplaceTilesToolshed                      ;81AA42;00B064;26
                       dw ReplaceTilesBarn                      ;81AA44;00B0A8;27
                       dw DATA8_00B121                      ;81AA46;00B121;28
                       dw DATA8_00B1CF                      ;81AA48;00B1CF;29
                       dw DATA8_00B21E                      ;81AA4A;00B21E;2A
                       dw DATA8_00B261                      ;81AA4C;00B261;2B
                       dw DATA8_00B262                      ;81AA4E;00B262;2C
                       dw DATA8_00B263                      ;81AA50;00B263;2D
                       dw DATA8_00B264                      ;81AA52;00B264;2E
                       dw DATA8_00B265                      ;81AA54;00B265;2F
                       dw DATA8_00B266                      ;81AA56;00B266;30
                       dw DATA8_00B267                      ;81AA58;00B267;31
                       dw DATA8_00B268                      ;81AA5A;00B268;32
                       dw DATA8_00B269                      ;81AA5C;00B269;33
                       dw DATA8_00B26A                      ;81AA5E;00B26A;34
                       dw DATA8_00B26B                      ;81AA60;00B26B;35
                       dw DATA8_00B26C                      ;81AA62;00B26C;36
                       dw DATA8_00B26D                      ;81AA64;00B26D;37
                       dw DATA8_00B293                      ;81AA66;00B293;38
                       dw DATA8_00B294                      ;81AA68;00B294;39
                       dw DATA8_00B295                      ;81AA6A;00B295;3A
                       dw DATA8_00B296                      ;81AA6C;00B296;3B
                       dw DATA8_00B297                      ;81AA6E;00B297;3C
                       dw DATA8_00B298                      ;81AA70;00B298;3D
                       dw DATA8_00B299                      ;81AA72;00B299;3E
                       dw DATA8_00B29A                      ;81AA74;00B29A;3F
                       dw DATA8_00B29B                      ;81AA76;00B29B;40
                       dw DATA8_00B29C                      ;81AA78;00B29C;
                       dw DATA8_00B29D                      ;81AA7A;00B29D;
                       dw DATA8_00B29E                      ;81AA7C;00B29E;
                       dw DATA8_00B29F                      ;81AA7E;00B29F;
                       dw DATA8_00B2A0                      ;81AA80;00B2A0;
                       dw DATA8_00B2A1                      ;81AA82;00B2A1;
                       dw DATA8_00B2A2                      ;81AA84;00B2A2;
                       dw DATA8_00B2A3                      ;81AA86;00B2A3;
                       dw DATA8_00B2A4                      ;81AA88;00B2A4;
                       dw DATA8_00B2A5                      ;81AA8A;00B2A5;
                       dw DATA8_00B2A6                      ;81AA8C;00B2A6;
                       dw DATA8_00B2A7                      ;81AA8E;00B2A7;
                       dw DATA8_00B2A8                      ;81AA90;00B2A8;
                       dw DATA8_00B2A9                      ;81AA92;00B2A9;
                       dw DATA8_00B2AA                      ;81AA94;00B2AA;
                       dw DATA8_00B2AB                      ;81AA96;00B2AB;
                       dw DATA8_00B2AC                      ;81AA98;00B2AC;
                       dw DATA8_00B2AD                      ;81AA9A;00B2AD;
                       dw DATA8_00B2AE                      ;81AA9C;00B2AE;
                       dw DATA8_00B2AF                      ;81AA9E;00B2AF;
                       dw DATA8_00B2B0                      ;81AAA0;00B2B0;
                       dw DATA8_00B2B1                      ;81AAA2;00B2B1;
                       dw DATA8_00B2B2                      ;81AAA4;00B2B2;
                       dw DATA8_00B2B3                      ;81AAA6;00B2B3;
                       dw DATA8_00B2B4                      ;81AAA8;00B2B4;
                       dw DATA8_00B2B5                      ;81AAAA;00B2B5;
                       dw DATA8_00B2B6                      ;81AAAC;00B2B6;
                       dw DATA8_00B2B7                      ;81AAAE;00B2B7;
                       dw DATA8_00B2B8                      ;81AAB0;00B2B8;
                       dw DATA8_00B2B9                      ;81AAB2;00B2B9;
                       dw DATA8_00B2BA                      ;81AAB4;00B2BA;

;;;;;;;;
ReplaceTilesFarm: ;81AAB6
        %Set16bit(!MX)
        LDA.L $7F1F64
        AND.W #$0002                         ;FLAG64
        BEQ .skip1
        LDA.W #$0060
        LDX.W #$0310
        LDY.W #$0360
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .skip1:
        %Set16bit(!MX)
        LDA.L $7F1F64
        AND.W #$0001                         ;FLAG64
        BEQ .skip2
        LDA.W #$005F
        LDX.W #$0240
        LDY.W #$02F0
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .skip2:
        %Set16bit(!MX)
        LDA.L $7F1F64
        AND.W #$0080                         ;FLAG64
        BEQ .housenotlvl2
        %Set16bit(!MX)
        LDA.W #$0054
        LDX.W #$0060
        LDY.W #$0100
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7
        BRA .housenotlvl1

    .housenotlvl2:
        %Set16bit(!MX)
        LDA.L $7F1F64
        AND.W #$0040                         ;FLAG64
        BEQ .housenotlvl1
        %Set16bit(!MX)
        LDA.W #$0053
        LDX.W #$0060
        LDY.W #$0100
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .housenotlvl1:
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.L !power_berry_N
        BEQ .paintedhouse1
        LDA.B #$00

    .powerberryloop:
            %Set8bit(!M)
            %Set16bit(!X)
            PHA
            XBA
            LDA.B #$00
            XBA
            %Set16bit(!M)
            ASL A
            ASL A
            TAX
            LDA.L Power_Flowers_Location_Table,X
            PHA
            INX
            INX
            LDA.L Power_Flowers_Location_Table,X
            TAY
            PLX
            LDA.W #$0016
            PHA
            PHX
            PHY
            JSL.L SUB_81A7CE
            %Set16bit(!MX)
            PLY
            PLX
            PLA
            JSL.L SUB_82B0A7
            %Set8bit(!M)
            %Set16bit(!X)
            PLA
            CLC
            ADC.B #$01
            CMP.L !power_berry_N
            BNE .powerberryloop

    .paintedhouse1:
        %Set16bit(!MX)
        LDA.L $7F1F66
        AND.W #$0200                         ;FLAG66
        BEQ .paintedhouse2
        LDA.W #$0059
        LDX.W #$0080
        LDY.W #$0130
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .paintedhouse2:
        %Set16bit(!MX)
        LDA.L $7F1F66
        AND.W #$0400                         ;FLAG66
        BEQ .paintedhouse3
        LDA.W #$0058
        LDX.W #$0060
        LDY.W #$0130
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .paintedhouse3:
        %Set16bit(!MX)
        LDA.L $7F1F66
        AND.W #$0800                         ;FLAG66
        BEQ .paintedhouse4
        LDA.W #$005A
        LDX.W #$0090
        LDY.W #$0130
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .paintedhouse4:
        %Set16bit(!MX)
        LDA.L $7F1F66
        AND.W #$1000                         ;FLAG66
        BEQ .CODE_81AC24
        LDA.W #$005C
        LDX.W #$00B0
        LDY.W #$0130
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .CODE_81AC24:
        %Set16bit(!MX)
        LDA.L $7F1F68
        AND.W #$1000                         ;FLAG68
        BEQ .CODE_81AC48
        LDA.W #$00F5
        LDX.W #$0120
        LDY.W #$0140
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

    .CODE_81AC48: RTS                                  ;81AC48;      ;

;;;;;;;;
Power_Flowers_Location_Table:   db $80,$01,$50,$00,$90,$01,$50,$00,$A0,$01,$50,$00,$B0,$01,$50,$00;81AC49;      ;
                                db $C0,$01,$50,$00,$80,$01,$60,$00,$90,$01,$60,$00,$A0,$01,$60,$00;81AC59;      ;
                                db $B0,$01,$60,$00,$C0,$01,$60,$00   ;81AC69;      ;

;;;;;;;;
ReplaceTilesTown:
        RTS                                  ;81AC71;      ;
        RTS                                  ;81AC72;      ;
        RTS                                  ;81AC73;      ;
        RTS                                  ;81AC74;      ;
        RTS                                  ;81AC75;      ;
        RTS                                  ;81AC76;      ;
        RTS                                  ;81AC77;      ;
;;;;;;;;
ReplaceTilesFlowerFestival:
        RTS                                  ;81AC78;      ;
;;;;;;;;
ReplaceTilesHarvestFestival:
        RTS                                  ;81AC79;      ;
;;;;;;;;
DATA8_00AC7A:
        RTS                                  ;81AC7A;      ;
;;;;;;;;
DATA8_00AC7B:
        RTS                                  ;81AC7B;      ;
;;;;;;;;
ReplaceTilesForkSpring:
        RTS                                  ;81AC7C;      ;
;;;;;;;;
ReplaceTilesForkSummer:
        RTS                                  ;81AC7D;      ;
;;;;;;;;
ReplaceTilesForkFall:
        RTS                                  ;81AC7E;      ;
;;;;;;;;
ReplaceTilesForkWinter:
        RTS                                  ;81AC7F;      ;

;;;;;;;;
ReplaceTilesMoutain: ;81AC7F
        %Set16bit(!MX)
        LDA.W $0196                          ;rain
        AND.W #$0002                         ;FLAG169
        BNE .CODE_81ACB7
        LDA.W $0196                          ;snowing
        AND.W #$0008                         ;FLAG169
        BNE .CODE_81ACB7

    .CODE_81AC92:
            %Set16bit(!MX)
            LDA.L $7F1F64
            AND.W #$0002                     ;FLAG64
            BEQ .return
            LDA.W #$00E1
            LDX.W #$0170
            LDY.W #$0270
            PHA
            PHX
            PHY
            JSL.L SUB_81A7CE
            %Set16bit(!MX)
            PLY
            PLX
            PLA
            JSL.L SUB_82B0A7

        .return: RTS

        .CODE_81ACB7:
            %Set16bit(!MX)
            LDA.W #$00E2
            LDX.W #$0180
            LDY.W #$0020
            JSL.L SUB_81A7CE
            BRA .CODE_81AC92


RTS                                  ;81ACC8;      ;
RTS                                  ;81ACC9;      ;
RTS                                  ;81ACCA;      ;

;;;;;;;;
DATA8_00ACCB:
        RTS                                  ;81ACCB;      ;

;;;;;;;;
ReplaceTilesHouse1: ;81ACCC
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$0010                         ;FLAG169
        BEQ .CODE_81ACE3
        LDA.W #$00EE
        LDX.W #$0070
        LDY.W #$00C0
        JSL.L SUB_81A7CE

    .CODE_81ACE3:
        %Set16bit(!MX)
        LDA.L $7F1F6C
        AND.W #$1000                         ;FLAG6C
        BEQ .CODE_81AD0A
        LDA.W #$00FD
        LDX.W #$0090
        LDY.W #$0040
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        LDA.W #$00D7
        LDX.W #$0090
        LDY.W #$0050
        JSL.L EditTileonMap

    .CODE_81AD0A:
        %Set16bit(!MX)
        LDA.L $7F1F6E                        ;clock
        AND.W #$4000                         ;FLAG6E
        BEQ .return
        LDA.W #$00FE
        LDX.W #$00A0
        LDY.W #$0030
        JSL.L SUB_81A7CE

    .return: RTS

;;;;;;;;
ReplaceTilesHouse2: ;81AD23
        %Set16bit(!MX)
        LDA.W $0196                          ;hurracaine?
        AND.W #$0010                         ;FLAG196
        BEQ .CODE_81AD3A
        LDA.W #$00EE
        LDX.W #$0070
        LDY.W #$00C0
        JSL.L SUB_81A7CE

    .CODE_81AD3A:
        %Set16bit(!MX)
        LDA.L $7F1F6C
        AND.W #$1000                         ;FLAG6C
        BEQ .CODE_81AD61
        LDA.W #$00FD
        LDX.W #$0090
        LDY.W #$0040
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        LDA.W #$00D7
        LDX.W #$0090
        LDY.W #$0050
        JSL.L EditTileonMap

    .CODE_81AD61:
        %Set16bit(!MX)
        LDA.L $7F1F6E                        ;clock
        AND.W #$4000                         ;FLAG6E
        BEQ .return
        LDA.W #$00FE
        LDX.W #$00A0
        LDY.W #$0030
        JSL.L SUB_81A7CE

    .return: RTS

;;;;;;;;
ReplaceTilesHouse3: ;81AD7A
        %Set16bit(!MX)
        LDA.W $0196
        AND.W #$0010                         ;FLAG196
        BEQ .turtleshellcheck
        LDA.W #$00EE
        LDX.W #$0070
        LDY.W #$00C0
        JSL.L SUB_81A7CE

    .turtleshellcheck:
        %Set16bit(!MX)
        LDA.L $7F1F6C
        AND.W #$1000                         ;FLAG6C
        BEQ .clockcheck
        LDA.W #$00FD
        LDX.W #$0140
        LDY.W #$0050
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        LDA.W #$00D7
        LDX.W #$0140
        LDY.W #$0060
        JSL.L EditTileonMap

    .clockcheck:
        %Set16bit(!MX)
        LDA.L $7F1F6E                        ;clock
        AND.W #$4000                         ;FLAG6E
        BEQ .return
        LDA.W #$00FE
        LDX.W #$0150
        LDY.W #$0040
        JSL.L SUB_81A7CE

    .return: RTS                                  ;81ADD0;      ;

;;;;;;;;
ReplaceTilesMayorHouse:
        RTS                                  ;81ADD1;      ;

;;;;;;;;
ReplaceTilesMayorHouseHall:
        RTS                                  ;81ADD2;      ;

;;;;;;;;
ReplaceTilesMariasRoom:
        RTS                                  ;81ADD3;      ;

;;;;;;;;
ReplaceTilesChurch:
        RTS                                  ;81ADD4;      ;

;;;;;;;;
ReplaceTilesFlowerShop: ;81ADD5
        %Set16bit(!MX)
        LDA.L $7F1F68
        AND.W #$0001                         ;FLAG68
        BNE .CODE_81ADE3
        JMP.W .return

    .CODE_81ADE3:
        %Set8bit(!M)
        LDA.L !season
        CMP.B #$01
        BNE .notsummer
        LDY.W #$0000

    .CODE_81ADF0:
            PHY
            %Set16bit(!M)
            TYA
            CLC
            ADC.W #$0005
            TYA
            INC A
            LDX.W #$0001
            LDY.W #$0002
            JSR.W SUB_81B2BB
            %Set16bit(!MX)
            PLY
            INY
            CPY.W #$0002
            BNE .CODE_81ADF0

    .notsummer:
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.L !season
        BNE .notspring
        LDY.W #$0002

    .CODE_81AE19:
            PHY
            %Set16bit(!M)
            TYA
            CLC
            ADC.W #$0005
            TYA
            INC A
            LDX.W #$0001
            LDY.W #$0002
            JSR.W SUB_81B2BB
            %Set16bit(!MX)
            PLY
            INY
            CPY.W #$0004
            BNE .CODE_81AE19

    .notspring:
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.L !season
        CMP.B #$02
        BCS .notfall
        %Set16bit(!M)
        LDA.W #$0005
        LDX.W #$0001
        LDY.W #$0002
        JSR.W SUB_81B2BB

    .notfall:
        %Set8bit(!M)
        LDA.L !season
        CMP.B #$02
        BCC .fall
        BRA .return

    .fall:
        %Set16bit(!MX)
        LDA.W #$0006
        LDX.W #$0001
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .return: RTS

;;;;;;;;
ReplaceTilesFlowerShopRooms:
        RTS                                  ;81AE6A;      ;
;;;;;;;;
ReplaceTilesBar:
        RTS                                  ;81AE6B;      ;

;;;;;;;;
ReplaceTilesBarRooms:
        RTS                                  ;81AE6C;      ;

;;;;;;;;
ReplaceTilesRestaurant:
        RTS                                  ;81AE6D;      ;

;;;;;;;;
ReplaceTilesRestaurantRooms:
        RTS                                  ;81AE6E;      ;

;;;;;;;;
ReplaceTilesGeneralStore: ;81AE6F
        %Set16bit(!MX)
        LDA.L $7F1F68
        AND.W #$0001                         ;FLAG68
        BNE .paintcheck
        JMP.W .return

    .paintcheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$0D                           ;paint
        BEQ .milkercheck
        LDA.W !tool_backpack
        CMP.B #$0D
        BEQ .milkercheck
        %Set16bit(!MX)
        LDA.L $7F1F64                        ;house lvl 2
        AND.W #$0080                         ;FLAG64
        BEQ .milkercheck
        %Set16bit(!M)
        LDA.W #$0001
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .milkercheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$0E                           ;Milker
        BEQ .brushcheck
        LDA.W !tool_backpack
        CMP.B #$0E
        BEQ .brushcheck
        %Set16bit(!M)
        LDA.W #$0002
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .brushcheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$0F                           ;Brush
        BEQ .goldsicklecheck
        LDA.W !tool_backpack
        CMP.B #$0F
        BEQ .goldsicklecheck
        %Set16bit(!M)
        LDA.W #$0003
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .goldsicklecheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$11                           ;Gold Scickle
        BEQ .goldhoecheck
        LDA.W !tool_backpack
        CMP.B #$11
        BEQ .goldhoecheck
        %Set16bit(!MX)
        LDA.L $7F1F6A
        AND.W #$0001                         ;FLAG6A
        BEQ .goldhoecheck
        %Set16bit(!M)
        LDA.W #$0004
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .goldhoecheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$12                           ;Gold Hoe
        BEQ .goldhammercheck
        LDA.W !tool_backpack
        CMP.B #$12
        BEQ .goldhammercheck
        %Set16bit(!MX)
        LDA.L $7F1F6A
        AND.W #$0002                         ;FLAG6A
        BEQ .goldhammercheck
        %Set16bit(!M)
        LDA.W #$0005
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .goldhammercheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$13                           ;Gold Hammer
        BEQ .goldaxecheck
        LDA.W !tool_backpack
        CMP.B #$13
        BEQ .goldaxecheck
        %Set16bit(!MX)
        LDA.L $7F1F6A
        AND.W #$0004                         ;FLAG6A
        BEQ .goldaxecheck
        %Set16bit(!M)
        LDA.W #$0006
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .goldaxecheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$14                           ;Gold Axe
        BEQ .sprinklercheck
        LDA.W !tool_backpack
        CMP.B #$14
        BEQ .sprinklercheck
        %Set16bit(!MX)
        LDA.L $7F1F6A
        AND.W #$0008                         ;FLAG6A
        BEQ .sprinklercheck
        %Set16bit(!M)
        LDA.W #$0007
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .sprinklercheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$15                       ;Sprinkler
        BEQ .return
        LDA.W !tool_backpack
        CMP.B #$15
        BEQ .return
        LDA.L !year
        CMP.B #$01
        BCS .sprinklerunlocked
        LDA.L !season
        BEQ .return
        CMP.B #$02
        BCS .sprinklerunlocked
        LDA.L !day
        CMP.B #$14
        BCC .return

    .sprinklerunlocked:
        %Set16bit(!M)
        LDA.W #$0008
        LDX.W #$0002
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .return: RTS

;;;;;;;;
ReplaceTilesGeneralStoreRooms:
        RTS                                  ;81AFBF;      ;

;;;;;;;;
ReplaceTilesAnimalShop: ;81AFC0
        %Set16bit(!MX)
        LDA.L $7F1F68
        AND.W #$0001                         ;FLAG68
        BNE .miraclepotioncheck
        JMP.W .return

    .miraclepotioncheck:
        %Set16bit(!M)
        LDA.L $7F1F64                        ;cow pregnant?
        AND.W #$0004                         ;FLAG64
        BNE .medicinecheck
        LDA.L $7F1F6E
        AND.W #$1000                         ;FLAG6E
        BEQ .medicinecheck
        %Set8bit(!M)
        LDA.L !cow_N
        CMP.B #$0C
        BEQ .medicinecheck
        LDA.W !tool_selected
        CMP.B #$0A                           ;miracle potion
        BEQ .medicinecheck
        LDA.W !tool_backpack
        CMP.B #$0A
        BEQ .medicinecheck
        %Set16bit(!MX)
        LDA.W #$0001
        LDX.W #$0003
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .medicinecheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$09                           ;Medicine
        BEQ .chickenfeedcheck
        LDA.W !tool_backpack
        CMP.B #$09
        BEQ .chickenfeedcheck
        %Set16bit(!MX)
        LDA.W #$0002
        LDX.W #$0003
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .chickenfeedcheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$19
        BEQ .cowfeedcheck
        LDA.W !tool_backpack
        CMP.B #$19
        BEQ .cowfeedcheck
        %Set16bit(!MX)
        LDA.W #$0003
        LDX.W #$0003
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .cowfeedcheck:
        %Set8bit(!M)
        LDA.W !tool_selected
        CMP.B #$1A
        BEQ .return
        LDA.W !tool_backpack
        CMP.B #$1A
        BEQ .return
        %Set16bit(!MX)
        LDA.W #$0004
        LDX.W #$0003
        LDY.W #$0000
        JSR.W SUB_81B2BB

    .return: RTS

;;;;;;;;
ReplaceTilesWitchHouse:
        RTS                                  ;81B063;      ;

;;;;;;;;
ReplaceTilesToolshed: ;81B064
        %Set16bit(!MX)
        LDY.W #$0000

    .loop:
        %Set16bit(!MX)
        PHY
        TYA
        INC A
        LDX.W #$0000
        LDY.W #$0001
        JSR.W SUB_81B2BB
        %Set16bit(!MX)
        PLY
        INY
        CPY.W #$0018
        BNE .loop

        %Set16bit(!MX)
        LDA.L $7F1F68
        AND.W #$2000                       ;FLAG68
        BNE .exitloop
        JMP.W .return

    .exitloop:
        LDA.W #$00F0
        LDX.W #$0070
        LDY.W #$0020
        PHA
        PHX
        PHY
        JSL.L SUB_81A7CE
        %Set16bit(!MX)
        PLY
        PLX
        PLA
        JSL.L SUB_82B0A7

        .return: RTS

ReplaceTilesBarn: ;81B0A8
        %Set16bit(!MX)
        LDA.W #$001A
        LDX.W #$0000
        LDY.W #$0001
        JSR.W SUB_81B2BB
        %Set16bit(!MX)
        LDY.W #$0000

    .loop:
            %Set16bit(!MX)
            PHY
            TYA
            ASL A
            TAX
            LDA.L Cow_Feed_Flags,X
            AND.W !fed_cows_flags
            BEQ .nofeed
            TYA
            ASL A
            ASL A
            TAX
            LDA.L DATA16_81B0ED,X
            PHA
            INX
            INX
            LDA.L DATA16_81B0ED,X
            PHA
            LDA.W #$0099
            PLY
            PLX
            JSL.L SUB_81A7CE

        .nofeed:
            %Set16bit(!MX)
            PLY
            INY
            CPY.W #$000D
            BNE .loop

        RTS

;;;;;;;;
        DATA16_81B0ED: dw $0088,$0118,$0088,$00F8,$0088,$00D8,$0088,$0098;81B0ED;      ;
                       dw $0088,$0078,$0088,$0058,$0058,$0118,$0058,$00F8;81B0FD;      ;
                       dw $0058,$00D8,$0058,$0098,$0058,$0078,$0058,$0058;81B10D;      ;
                       dw $00C8,$0168,$30C2,$19A9,$A200,$0000,$01A0,$2000;81B11D;      ;
                       dw $B2BB,$30C2,$30C2,$00A0,$C200,$5A30,$0A98,$BFAA;81B12D;      ;
                       dw $A571,$2D82,$0934,$19F0,$0A98,$AA0A,$9FBF,$81B1;81B13D;      ;
                       dw $E848,$BFE8,$B19F,$4881,$99A9,$7A00,$22FA,$A7CE;81B14D;      ;
                       dw $C281,$7A30,$C0C8,$000C,$CFD0,$30C2,$00A0,$C200;81B15D;      ;
                       dw $5A30,$0A98,$BFAA,$BF97,$2F81,$1F45,$F07F,$9819;81B16D;      ;
                       dw $0A0A,$BFAA,$CA10,$4883,$E8E8,$10BF,$83CA,$A948;81B17D;      ;
                       dw $00F1,$FA7A,$CE22,$81A7,$30C2,$C87A,$0DC0,$D000;81B18D;      ;
                       dw $60CE,$0020,$0020,$0030,$0020,$0040,$0020,$0050;81B19D;      ;
                       dw $0020,$0060,$0020,$0070,$0020,$0080,$0020,$0090;81B1AD;      ;
                       dw $0020,$00A0,$0020,$00B0,$0020,$00C0,$0020,$00D0;81B1BD;      ;
                       dw $0020,$30C2,$6CAF,$7F1F,$1129,$F000,$A943,$00E4;81B1CD;      ;
                       dw $70A2,$A000,$0160,$DA48,$225A,$A7CE,$C281,$7A30;81B1DD;      ;
                       dw $68FA,$30C2,$E4A9,$A200,$0070,$30A0,$4801,$5ADA;81B1ED;      ;
                       dw $CE22,$81A7,$30C2,$FA7A,$C268,$A930,$00E4,$60A2;81B1FD;      ;
                       dw $A000,$0170,$DA48,$225A,$A7CE,$C281,$7A30,$68FA;81B20D;      ;
                       dw $C260,$AF30,$1F64,$297F,$0002,$03D0,$604C,$A9B2;81B21D;      ;
                       dw $00EF,$30A2,$A000,$0180,$DA48,$225A,$A7CE,$C281;81B22D;      ;
                       dw $7A30,$68FA,$A722,$82B0,$30C2,$EFA9,$A200,$0020;81B23D;      ;
                       dw $B0A0,$4801,$5ADA,$CE22,$81A7,$30C2,$FA7A,$2268;81B24D;      ;
                       dw $B0A7,$6082,$6060,$6060,$6060,$6060,$6060,$6060;81B25D;      ;

         DATA8_00B26D: %Set16bit(!MX)                             ;81B26D;      ;
                       LDA.L $7F1F5A                        ;81B26F;7F1F5A;
                       AND.W #$0001                         ;FLAG5A
                       BNE CODE_81B292                      ;81B276;81B292;
                       LDA.L $7F1F5A                        ;81B278;7F1F5A;
                       ORA.W #$0001                         ;FLAG5A
                       STA.L $7F1F5A                        ;81B27F;7F1F5A;
                       %Set16bit(!M)                             ;81B283;      ;
                       LDA.W #$009B                         ;81B285;      ;
                       LDX.W #$0080                         ;81B288;      ;
                       LDY.W #$0110                         ;81B28B;      ;
                       JSL.L SUB_81A7CE                    ;81B28E;81A7CE;
                                                            ;      ;      ;
          CODE_81B292: RTS                                  ;81B292;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B293;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B294;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B295;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B296;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B297;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B298;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B299;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B29A;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B29B;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B29C;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B29D;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B29E;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B29F;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A0;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A1;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A2;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A3;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A4;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A5;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A6;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A7;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A8;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2A9;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2AA;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2AB;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2AC;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2AD;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2AE;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2AF;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B0;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B1;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B2;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B3;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B4;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B5;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B6;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B7;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B8;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2B9;      ;
                                                            ;      ;      ;
                       RTS                                  ;81B2BA;      ;
                                                            ;      ;      ;
;;;;;;;;
SUB_81B2BB:
        %Set16bit(!MX)                             ;81B2BB;      ;
        PHY                                  ;81B2BD;      ;
        PHA                                  ;81B2BE;      ;
        CPX.W #$0000                         ;81B2BF;      ;
        BEQ .CODE_81B2D3                      ;81B2C2;81B2D3;
        CPX.W #$0001                         ;81B2C4;      ;
        BEQ .CODE_81B2E2                      ;81B2C7;81B2E2;
        CPX.W #$0002                         ;81B2C9;      ;
        BEQ .CODE_81B2F1                      ;81B2CC;81B2F1;
        CPX.W #$0003                         ;81B2CE;      ;
        BEQ .CODE_81B300                      ;81B2D1;81B300;

    .CODE_81B2D3:
        %Set16bit(!M)                             ;81B2D3;      ;
        LDA.W #$BE0F                         ;81B2D5;      ;
        STA.B $72                            ;81B2D8;000072;
        %Set8bit(!M)                             ;81B2DA;      ;
        LDA.B #$81                           ;81B2DC;      ;
        STA.B $74                            ;81B2DE;000074;
        BRA .CODE_81B30F                      ;81B2E0;81B30F;

    .CODE_81B2E2:
        %Set16bit(!M)                             ;81B2E2;      ;
        LDA.W #$BEEF                         ;81B2E4;      ;
        STA.B $72                            ;81B2E7;000072;
        %Set8bit(!M)                             ;81B2E9;      ;
        LDA.B #$81                           ;81B2EB;      ;
        STA.B $74                            ;81B2ED;000074;
        BRA .CODE_81B30F                      ;81B2EF;81B30F;

    .CODE_81B2F1:
        %Set16bit(!M)                             ;81B2F1;      ;
        LDA.W #$BF27                         ;81B2F3;      ;
        STA.B $72                            ;81B2F6;000072;
        %Set8bit(!M)                             ;81B2F8;      ;
        LDA.B #$81                           ;81B2FA;      ;
        STA.B $74                            ;81B2FC;000074;
        BRA .CODE_81B30F                      ;81B2FE;81B30F;

    .CODE_81B300:
        %Set16bit(!M)                             ;81B300;      ;
        LDA.W #$BF6F                         ;81B302;      ;
        STA.B $72                            ;81B305;000072;
        %Set8bit(!M)                             ;81B307;      ;
        LDA.B #$81                           ;81B309;      ;
        STA.B $74                            ;81B30B;000074;
        BRA .CODE_81B30F                      ;81B30D;81B30F;

    .CODE_81B30F:
        %Set16bit(!M)                             ;81B30F;      ;
        PLA                                  ;81B311;      ;
        ASL A                                ;81B312;      ;
        ASL A                                ;81B313;      ;
        ASL A                                ;81B314;      ;
        TAY                                  ;81B315;      ;
        PHY                                  ;81B316;      ;
        INY                                  ;81B317;      ;
        INY                                  ;81B318;      ;
        INY                                  ;81B319;      ;
        INY                                  ;81B31A;      ;
        INY                                  ;81B31B;      ;
        INY                                  ;81B31C;      ;
        %Set8bit(!M)                             ;81B31D;      ;
        LDA.B #$00                           ;81B31F;      ;
        XBA                                  ;81B321;      ;
        LDA.B [$72],Y                        ;81B322;000072;
        TAX                                  ;81B324;      ;
        INY                                  ;81B325;      ;
        LDA.B [$72],Y                        ;81B326;000072;
        STA.B $92                            ;81B328;000092;
        PLY                                  ;81B32A;      ;
        %Set16bit(!M)                             ;81B32B;      ;
        PLA                                  ;81B32D;      ;
        CMP.W #$0002                         ;81B32E;      ;
        BEQ .CODE_81B34E                      ;81B331;81B34E;
        CMP.W #$0001                         ;81B333;      ;
        BEQ .CODE_81B344                      ;81B336;81B344;
        %Set8bit(!M)                             ;81B338;      ;
        LDA.L !shed_items_row_1,X                      ;81B33A;7F1F00;
        AND.B $92                            ;81B33E;000092;
        BNE .return                      ;81B340;81B362;
        BRA .CODE_81B34E                      ;81B342;81B34E;

    .CODE_81B344:
        %Set8bit(!M)                             ;81B344;      ;
        LDA.L !shed_items_row_1,X                      ;81B346;7F1F00;
        AND.B $92                            ;81B34A;000092;
        BEQ .return                      ;81B34C;81B362;

    .CODE_81B34E:
        %Set16bit(!M)                             ;81B34E;      ;
        LDA.B [$72],Y                        ;81B350;000072;
        PHA                                  ;81B352;      ;
        INY                                  ;81B353;      ;
        INY                                  ;81B354;      ;
        LDA.B [$72],Y                        ;81B355;000072;
        PHA                                  ;81B357;      ;
        INY                                  ;81B358;      ;
        INY                                  ;81B359;      ;
        LDA.B [$72],Y                        ;81B35A;000072;
        PLY                                  ;81B35C;      ;
        PLX                                  ;81B35D;      ;
        JSL.L SUB_81A7CE                    ;81B35E;81A7CE;

    .return: RTS                                  ;81B362;      ;

         DATA8_81B363: db $00,$00,$00,$00,$00,$00,$00,$00,$02,$01,$00,$00,$08,$00,$02,$01;81B363;      ;
                       db $00,$00,$10,$00,$02,$01,$00,$00,$18,$00,$02,$01,$00,$00,$20,$00;81B373;      ;
                       db $02,$01,$00,$00,$28,$00,$02,$01,$00,$00,$30,$00,$02,$01,$00,$00;81B383;      ;
                       db $38,$00,$02,$01,$00,$00,$80,$00,$01,$02,$00,$00,$88,$00,$01,$02;81B393;      ;
                       db $00,$00,$90,$00,$02,$02,$00,$00,$A0,$00,$02,$02,$00,$00,$B0,$00;81B3A3;      ;
                       db $02,$02,$02,$00,$00,$01,$01,$01,$02,$00,$04,$01,$01,$01,$03,$00;81B3B3;      ;
                       db $08,$01,$01,$01,$04,$00,$0C,$01,$01,$01,$00,$00,$10,$01,$01,$01;81B3C3;      ;
                       db $00,$00,$14,$01,$01,$01,$00,$00,$18,$01,$01,$01,$05,$00,$1C,$01;81B3D3;      ;
                       db $01,$01,$06,$00,$20,$01,$01,$01,$00,$00,$24,$01,$01,$01,$07,$00;81B3E3;      ;
                       db $28,$01,$01,$01,$08,$00,$2C,$01,$01,$01,$3A,$00,$2C,$01,$01,$01;81B3F3;      ;
                       db $26,$00,$2C,$01,$01,$01,$54,$00,$2C,$01,$01,$01,$66,$00,$30,$01;81B403;      ;
                       db $01,$01,$00,$00,$34,$01,$01,$01,$70,$00,$38,$01,$01,$01,$00,$00;81B413;      ;
                       db $3C,$01,$01,$01,$00,$00,$80,$01,$01,$01,$00,$00,$84,$01,$01,$01;81B423;      ;
                       db $00,$00,$88,$01,$01,$01,$32,$00,$8C,$01,$01,$01,$00,$00,$90,$01;81B433;      ;
                       db $01,$01,$00,$00,$94,$01,$01,$01,$00,$00,$98,$01,$01,$01,$00,$00;81B443;      ;
                       db $9C,$01,$01,$01,$00,$00,$A0,$01,$01,$01,$00,$00,$A4,$01,$01,$01;81B453;      ;
                       db $00,$00,$A8,$01,$01,$01,$4C,$00,$AC,$01,$01,$01,$00,$00,$B0,$01;81B463;      ;
                       db $01,$01,$00,$00,$B4,$01,$01,$01,$00,$00,$B8,$01,$01,$01,$00,$00;81B473;      ;
                       db $BC,$01,$01,$01,$00,$00,$00,$02,$01,$01,$00,$00,$04,$02,$01,$01;81B483;      ;
                       db $00,$00,$08,$02,$01,$01,$00,$00,$0C,$02,$01,$01,$00,$00,$10,$02;81B493;      ;
                       db $01,$01,$00,$00,$14,$02,$01,$01,$00,$00,$18,$02,$01,$01,$00,$00;81B4A3;      ;
                       db $1C,$02,$01,$01,$00,$00,$20,$02,$01,$01,$00,$00,$24,$02,$01,$01;81B4B3;      ;
                       db $00,$00,$28,$02,$01,$01,$00,$00,$2C,$02,$01,$01,$00,$00,$30,$02;81B4C3;      ;
                       db $01,$01,$00,$00,$34,$02,$01,$01,$00,$00,$38,$02,$01,$01,$00,$00;81B4D3;      ;
                       db $3C,$02,$01,$01,$00,$00,$80,$02,$01,$01,$00,$00,$84,$02,$01,$01;81B4E3;      ;
                       db $00,$00,$88,$02,$01,$01,$00,$00,$8C,$02,$01,$01,$00,$00,$90,$02;81B4F3;      ;
                       db $01,$01,$00,$00,$94,$02,$01,$01,$00,$00,$98,$02,$01,$01,$00,$00;81B503;      ;
                       db $9C,$02,$01,$01,$00,$00,$A0,$02,$01,$01,$00,$00,$A4,$02,$01,$01;81B513;      ;
                       db $00,$00,$A8,$02,$01,$01,$00,$00,$AC,$02,$01,$01,$00,$00,$B0,$02;81B523;      ;
                       db $01,$01,$00,$00,$B4,$02,$01,$01,$00,$00,$B8,$02,$01,$01,$00,$00;81B533;      ;
                       db $BC,$02,$01,$01,$00,$00,$00,$03,$01,$01,$00,$00,$04,$03,$01,$01;81B543;      ;
                       db $7A,$00,$08,$03,$07,$07,$00,$00,$8C,$04,$07,$07,$00,$00,$10,$06;81B553;      ;
                       db $02,$02,$00,$00,$20,$06,$02,$02,$00,$00,$30,$06,$02,$02,$00,$00;81B563;      ;
                       db $80,$06,$02,$02,$00,$00,$90,$06,$02,$01,$00,$00,$98,$06,$02,$02;81B573;      ;
                       db $00,$00,$A0,$06,$03,$01,$00,$00,$AC,$06,$02,$02,$00,$00,$B4,$06;81B583;      ;
                       db $02,$01,$00,$00,$BC,$06,$02,$01,$00,$00,$28,$07,$02,$03,$00,$00;81B593;      ;
                       db $80,$07,$03,$03,$00,$00,$A4,$07,$01,$02,$00,$00,$AC,$07,$01,$02;81B5A3;      ;
                       db $00,$00,$B4,$07,$01,$02,$00,$00,$00,$08,$01,$02,$00,$00,$08,$08;81B5B3;      ;
                       db $01,$02,$00,$00,$10,$08,$01,$02,$00,$00,$18,$08,$01,$02,$00,$00;81B5C3;      ;
                       db $20,$08,$01,$02,$00,$00,$28,$08,$01,$02,$00,$00,$30,$08,$01,$02;81B5D3;      ;
                       db $00,$00,$38,$08,$01,$02,$00,$00,$80,$08,$01,$02,$00,$00,$88,$08;81B5E3;      ;
                       db $01,$02,$00,$00,$90,$08,$01,$02,$00,$00,$98,$08,$01,$02,$00,$00;81B5F3;      ;
                       db $A0,$08,$01,$02,$00,$00,$A8,$08,$01,$02,$00,$00,$B0,$08,$01,$02;81B603;      ;
                       db $00,$00,$B8,$08,$01,$02,$00,$00,$00,$09,$01,$02,$00,$00,$B0,$0E;81B613;      ;
                       db $01,$02,$00,$00,$0C,$09,$02,$01,$00,$00,$14,$09,$02,$01,$00,$00;81B623;      ;
                       db $1C,$09,$01,$01,$10,$00,$20,$09,$01,$01,$11,$00,$24,$09,$01,$01;81B633;      ;
                       db $12,$00,$28,$09,$01,$01,$13,$00,$2C,$09,$01,$01,$14,$00,$30,$09;81B643;      ;
                       db $01,$01,$15,$00,$34,$09,$01,$01,$16,$00,$38,$09,$01,$01,$17,$00;81B653;      ;
                       db $3C,$09,$01,$01,$18,$00,$80,$09,$01,$01,$19,$00,$84,$09,$01,$01;81B663;      ;
                       db $1A,$00,$88,$09,$01,$01,$1B,$00,$8C,$09,$01,$01,$1C,$00,$90,$09;81B673;      ;
                       db $01,$01,$1D,$00,$94,$09,$01,$01,$1E,$00,$98,$09,$01,$01,$1F,$00;81B683;      ;
                       db $9C,$09,$01,$01,$20,$00,$A0,$09,$01,$01,$21,$00,$A4,$09,$01,$01;81B693;      ;
                       db $22,$00,$A8,$09,$01,$01,$23,$00,$AC,$09,$01,$01,$24,$00,$B0,$09;81B6A3;      ;
                       db $01,$01,$25,$00,$B4,$09,$01,$01,$26,$00,$B8,$09,$01,$01,$27,$00;81B6B3;      ;
                       db $BC,$09,$01,$01,$2A,$00,$00,$0A,$01,$01,$2B,$00,$04,$0A,$01,$01;81B6C3;      ;
                       db $2C,$00,$08,$0A,$01,$01,$2D,$00,$0C,$0A,$01,$01,$29,$00,$10,$0A;81B6D3;      ;
                       db $01,$01,$00,$00,$14,$0A,$01,$01,$00,$00,$18,$0A,$01,$01,$00,$00;81B6E3;      ;
                       db $1C,$0A,$01,$01,$00,$00,$20,$0A,$01,$01,$2F,$00,$24,$0A,$01,$01;81B6F3;      ;
                       db $00,$00,$28,$0A,$01,$01,$37,$00,$2C,$0A,$01,$01,$03,$00,$30,$0A;81B703;      ;
                       db $01,$01,$28,$00,$34,$0A,$01,$01,$00,$00,$38,$0A,$01,$01,$00,$00;81B713;      ;
                       db $3C,$0A,$01,$01,$00,$00,$80,$0A,$02,$02,$00,$00,$90,$0A,$02,$02;81B723;      ;
                       db $00,$00,$A0,$0A,$02,$01,$00,$00,$A8,$0A,$02,$01,$00,$00,$B0,$0A;81B733;      ;
                       db $02,$01,$00,$00,$B8,$0A,$02,$01,$00,$00,$00,$0B,$02,$01,$00,$00;81B743;      ;
                       db $08,$0B,$02,$01,$00,$00,$10,$0B,$02,$01,$00,$00,$18,$0B,$02,$01;81B753;      ;
                       db $00,$00,$20,$0B,$02,$02,$00,$00,$30,$0B,$02,$02,$00,$00,$80,$0B;81B763;      ;
                       db $02,$02,$00,$00,$90,$0B,$02,$01,$00,$00,$98,$0B,$02,$01,$00,$00;81B773;      ;
                       db $A0,$0B,$02,$01,$00,$00,$A8,$0B,$02,$01,$00,$00,$B0,$0B,$02,$01;81B783;      ;
                       db $00,$00,$B8,$0B,$02,$01,$00,$00,$00,$0C,$02,$01,$00,$00,$08,$0C;81B793;      ;
                       db $02,$01,$00,$00,$10,$0C,$02,$01,$00,$00,$18,$0C,$01,$01,$F2,$00;81B7A3;      ;
                       db $1C,$0C,$01,$01,$F3,$00,$20,$0C,$01,$01,$F4,$00,$24,$0C,$01,$01;81B7B3;      ;
                       db $F5,$00,$28,$0C,$01,$01,$F1,$00,$2C,$0C,$01,$01,$F6,$00,$30,$0C;81B7C3;      ;
                       db $01,$01,$20,$00,$34,$0C,$01,$01,$00,$00,$38,$0C,$01,$01,$21,$00;81B7D3;      ;
                       db $3C,$0C,$01,$01,$00,$00,$80,$0C,$02,$01,$00,$00,$88,$0C,$02,$01;81B7E3;      ;
                       db $00,$00,$90,$0C,$02,$01,$00,$00,$98,$0C,$02,$01,$00,$00,$A0,$0C;81B7F3;      ;
                       db $01,$01,$F1,$00,$A4,$0C,$01,$01,$22,$00,$A8,$0C,$01,$01,$00,$00;81B803;      ;
                       db $AC,$0C,$02,$01,$00,$00,$B4,$0C,$02,$01,$00,$00,$BC,$0C,$01,$01;81B813;      ;
                       db $F8,$00,$00,$0D,$01,$01,$F9,$00,$04,$0D,$01,$01,$FA,$00,$08,$0D;81B823;      ;
                       db $01,$01,$FB,$00,$0C,$0D,$01,$01,$F7,$00,$10,$0D,$01,$01,$F6,$00;81B833;      ;
                       db $14,$0D,$01,$01,$F4,$00,$18,$0D,$01,$01,$F5,$00,$1C,$0D,$01,$01;81B843;      ;
                       db $20,$00,$20,$0D,$01,$01,$21,$00,$24,$0D,$02,$01,$00,$00,$2C,$0D;81B853;      ;
                       db $02,$01,$00,$00,$34,$0D,$01,$01,$FA,$00,$38,$0D,$01,$01,$F9,$00;81B863;      ;
                       db $3C,$0D,$01,$01,$FC,$00,$80,$0D,$01,$01,$FB,$00,$84,$0D,$01,$01;81B873;      ;
                       db $22,$00,$88,$0D,$02,$01,$00,$00,$90,$0D,$02,$01,$00,$00,$98,$0D;81B883;      ;
                       db $01,$01,$02,$00,$9C,$0D,$01,$01,$01,$00,$A0,$0D,$02,$02,$02,$00;81B893;      ;
                       db $B0,$0D,$02,$02,$C3,$00,$00,$0E,$05,$02,$00,$00,$28,$0E,$01,$01;81B8A3;      ;
                       db $D5,$00,$2C,$0E,$01,$01,$20,$00,$30,$0E,$01,$01,$04,$00,$88,$0E;81B8B3;      ;
                       db $02,$03,$00,$00,$A0,$0E,$01,$01,$00,$00,$A4,$0E,$01,$01,$00,$00;81B8C3;      ;
                       db $A8,$0E,$01,$01,$00,$00,$AC,$0E,$01,$01,$00,$00,$B8,$0E,$01,$01;81B8D3;      ;
                       db $2E,$00,$2C,$01,$01,$01,$1E,$00,$30,$01,$01,$01,$00,$00,$34,$01;81B8E3;      ;
                       db $01,$01,$1D,$00,$80,$0E,$02,$02,$00,$00,$90,$0E,$02,$02,$00,$00;81B8F3;      ;
                       db $00,$0F,$02,$01,$00,$00,$0C,$0F,$01,$01,$F9,$00,$10,$0F,$01,$01;81B903;      ;
                       db $00,$00,$08,$0F,$01,$01,$00,$00,$18,$0F,$02,$01,$C3,$00,$20,$0F;81B913;      ;
                       db $03,$02,$00,$00,$BC,$0E,$01,$01,$12,$00,$38,$0F,$01,$01,$62,$00;81B923;      ;
                       db $3C,$0F,$01,$01,$63,$00,$80,$0F,$01,$01,$64,$00,$84,$0F,$01,$01;81B933;      ;
                       db $A1,$00,$88,$0F,$01,$01,$00,$00,$8C,$0F,$01,$01,$00,$00,$90,$0F;81B943;      ;
                       db $01,$01,$00,$00,$94,$0F,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00;81B953;      ;
                                                            ;      ;      ;
        DATA16_81B963: dw $BA3E,$5C81,$81BA,$BA6F,$8281,$81BA,$BA8B,$9E81;81B963;      ;
                       dw $81BA,$BAB1,$BA81,$81BA,$BAC3,$CC81,$81BA,$BADF;81B973;      ;
                       dw $E881,$81BA,$BAF1,$0481,$81BB,$BB0D,$1681,$81BB;81B983;      ;
                       dw $BB1F,$2881,$81BB,$BB31,$3A81,$81BB,$BB43,$4C81;81B993;      ;
                       dw $81BB,$BB63,$6C81,$81BB,$BB75,$7E81,$81BB,$BB87;81B9A3;      ;
                       dw $9081,$81BB,$BB99,$A281,$81BB,$BBAB,$B481,$81BB;81B9B3;      ;
                       dw $BBBD,$C681,$81BB,$BBCF,$D881,$81BB,$BBE1,$F181;81B9C3;      ;
                       dw $81BB,$BC01,$1181,$81BC,$BC2F,$4281,$81BC,$BC55;81B9D3;      ;
                       dw $5E81,$81BC,$BC71,$8481,$81BC,$BC8D,$9681,$81BC;81B9E3;      ;
                       dw $BC9F,$B281,$81BC,$BCBB,$C481,$81BC,$BCD7,$F581;81B9F3;      ;
                       dw $81BC,$BD08,$1B81,$81BD,$BD24,$3781,$81BD,$BD4A;81BA03;      ;
                       dw $5381,$81BD,$BD5C,$6581,$81BD,$BD78,$8181,$81BD;81BA13;      ;
                       dw $BD8A,$9D81,$81BD,$BDBB,$C481,$81BD,$BDCD,$EB81;81BA23;      ;
                       dw $81BD,$BDF4,$FD81,$81BD,$BE06,$6181,$B000,$4000;81BA33;      ;
                       dw $2000,$0062,$00B0,$0040,$6110,$B000,$4000,$2000;81BA43;      ;
                       dw $0063,$00B0,$0040,$FF30,$64FF,$B000,$4000,$0600;81BA53;      ;
                       dw $0065,$00B0,$0040,$FE06,$5CFF,$81BA,$0066,$00B0;81BA63;      ;
                       dw $0040,$6706,$B000,$4000,$0600,$FFFE,$BA6F,$6881;81BA73;      ;
                       dw $B000,$4000,$0400,$FFFF,$0069,$00B0,$0040,$6A06;81BA83;      ;
                       dw $B000,$4000,$0600,$FFFE,$BA8B,$6B81,$B000,$4000;81BA93;      ;
                       dw $0600,$006C,$00B0,$0040,$FE06,$9EFF,$81BA,$006D;81BAA3;      ;
                       dw $00B0,$0040,$FF04,$6EFF,$B000,$4000,$0400,$FFFF;81BAB3;      ;
                       dw $006F,$00B0,$0040,$FF04,$70FF,$B000,$4000,$0600;81BAC3;      ;
                       dw $0071,$00B0,$0040,$FE06,$CCFF,$81BA,$0072,$00B0;81BAD3;      ;
                       dw $0040,$FF04,$6EFF,$B000,$4000,$0400,$FFFF,$0073;81BAE3;      ;
                       dw $00B0,$0040,$7406,$B000,$4000,$0600,$FFFE,$BAF1;81BAF3;      ;
                       dw $0281,$8000,$3000,$0001,$FFFF,$0004,$0140,$0140;81BB03;      ;
                       dw $FF00,$06FF,$C000,$4001,$0001,$FFFF,$0008,$01A0;81BB13;      ;
                       dw $01C0,$FF00,$0AFF,$7000,$9000,$0001,$FFFF,$0009;81BB23;      ;
                       dw $0070,$0190,$FF00,$DCFF,$0000,$0002,$0002,$FFFF;81BB33;      ;
                       dw $00A4,$0090,$0070,$FF00,$ABFF,$6000,$7001,$0800;81BB43;      ;
                       dw $00AC,$0160,$0070,$AD08,$6000,$7001,$0800,$FFFF;81BB53;      ;
                       dw $00A6,$0250,$00C0,$FF00,$A6FF,$9000,$4000,$0003;81BB63;      ;
                       dw $FFFF,$00A6,$0110,$0340,$FF00,$A6FF,$9000,$4001;81BB73;      ;
                       dw $0003,$FFFF,$00AF,$0250,$0350,$FF00,$B1FF,$4000;81BB83;      ;
                       dw $4002,$0002,$FFFF,$00B3,$0090,$0020,$FF00,$B4FF;81BB93;      ;
                       dw $9000,$3000,$0001,$FFFF,$00B6,$0060,$0120,$FF00;81BBA3;      ;
                       dw $D5FF,$5000,$2000,$0000,$FFFF,$00C4,$0060,$0120;81BBB3;      ;
                       dw $FF00,$C9FF,$6000,$2000,$0001,$FFFF,$00C2,$0080;81BBC3;      ;
                       dw $0120,$FF00,$77FF,$7000,$2000,$0000,$FFFF,$000B;81BBD3;      ;
                       dw $0080,$01D0,$0C08,$8000,$D000,$0801,$FFFF,$00A1;81BBE3;      ;
                       dw $0000,$0150,$A208,$0000,$5000,$0801,$FFFF,$00A1;81BBF3;      ;
                       dw $0000,$00B0,$A208,$0000,$B000,$0800,$FFFF,$0061;81BC03;      ;
                       dw $00B0,$0040,$6220,$B000,$4000,$1000,$0061,$00B0;81BC13;      ;
                       dw $0040,$6320,$B000,$4000,$3000,$FFFF,$0064,$00B0;81BC23;      ;
                       dw $0040,$6506,$B000,$4000,$0600,$FFFE,$BC2F,$6681;81BC33;      ;
                       dw $B000,$4000,$0600,$0067,$00B0,$0040,$FE06,$42FF;81BC43;      ;
                       dw $81BC,$0068,$00B0,$0040,$FF04,$69FF,$B000,$4000;81BC53;      ;
                       dw $0600,$006A,$00B0,$0040,$FE06,$5EFF,$81BC,$006B;81BC63;      ;
                       dw $00B0,$0040,$6C06,$B000,$4000,$0600,$FFFE,$BC71;81BC73;      ;
                       dw $6D81,$B000,$4000,$0400,$FFFF,$006E,$00B0,$0040;81BC83;      ;
                       dw $FF04,$6FFF,$B000,$4000,$0400,$FFFF,$0070,$00B0;81BC93;      ;
                       dw $0040,$7106,$B000,$4000,$0600,$FFFE,$BC9F,$7281;81BCA3;      ;
                       dw $B000,$4000,$0400,$FFFF,$006E,$00B0,$0040,$FF04;81BCB3;      ;
                       dw $73FF,$B000,$4000,$0600,$0074,$00B0,$0040,$FE06;81BCC3;      ;
                       dw $C4FF,$81BC,$0061,$00C0,$0040,$6220,$C000,$4000;81BCD3;      ;
                       dw $1000,$0061,$00C0,$0040,$6320,$C000,$4000,$3000;81BCE3;      ;
                       dw $FFFF,$0064,$00C0,$0040,$6506,$C000,$4000,$0600;81BCF3;      ;
                       dw $FFFE,$BCF5,$6681,$C000,$4000,$0600,$0067,$00C0;81BD03;      ;
                       dw $0040,$FE06,$08FF,$81BD,$0068,$00C0,$0040,$FF04;81BD13;      ;
                       dw $69FF,$C000,$4000,$0600,$006A,$00C0,$0040,$FE06;81BD23;      ;
                       dw $24FF,$81BD,$006B,$00C0,$0040,$6C06,$C000,$4000;81BD33;      ;
                       dw $0600,$FFFE,$BD37,$6D81,$C000,$4000,$0400,$FFFF;81BD43;      ;
                       dw $006E,$00C0,$0040,$FF04,$6FFF,$C000,$4000,$0400;81BD53;      ;
                       dw $FFFF,$0070,$00C0,$0040,$7106,$C000,$4000,$0600;81BD63;      ;
                       dw $FFFE,$BD65,$7281,$C000,$4000,$0400,$FFFF,$006E;81BD73;      ;
                       dw $00C0,$0040,$FF04,$73FF,$C000,$4000,$0600,$0074;81BD83;      ;
                       dw $00C0,$0040,$FE06,$8AFF,$81BD,$00E6,$0080,$0110;81BD93;      ;
                       dw $E706,$8000,$1000,$0601,$00E8,$0080,$0110,$E906;81BDA3;      ;
                       dw $8000,$1000,$0601,$FFFF,$00F3,$0080,$0110,$FF06;81BDB3;      ;
                       dw $F4FF,$4000,$7000,$0000,$FFFF,$0056,$0120,$0140;81BDC3;      ;
                       dw $5508,$2000,$4001,$0801,$0057,$0120,$0140,$5508;81BDD3;      ;
                       dw $2000,$4001,$0801,$FFFF,$00FA,$0110,$00F0,$FF08;81BDE3;      ;
                       dw $75FF,$B000,$4000,$0400,$FFFF,$0075,$00B0,$0040;81BDF3;      ;
                       dw $FF04,$75FF,$C000,$4000,$0400,$FFFF;81BE03;      ;
                                                            ;      ;      ;
        DATA16_81BE0F: dw $0000,$0000,$0000,$0000,$0090,$0090,$0078,$0100;81BE0F;      ;
                       dw $00A0,$0090,$0079,$0200,$00B0,$0090,$007A,$0400;81BE1F;      ;
                       dw $00C0,$0090,$007B,$0800,$0090,$0060,$007C,$1000;81BE2F;      ;
                       dw $00A0,$0060,$007D,$2000,$00B0,$0060,$007E,$4000;81BE3F;      ;
                       dw $00C0,$0060,$007F,$8000,$0030,$0060,$0080,$0101;81BE4F;      ;
                       dw $0040,$0060,$0081,$0201,$0050,$0060,$0082,$0401;81BE5F;      ;
                       dw $0060,$0060,$0083,$0801,$0030,$0090,$0084,$1001;81BE6F;      ;
                       dw $0040,$0090,$0085,$2001,$0050,$0090,$0086,$4001;81BE7F;      ;
                       dw $0060,$0090,$0087,$8001,$0090,$0090,$0088,$0102;81BE8F;      ;
                       dw $00A0,$0090,$0089,$0202,$00B0,$0090,$008A,$0402;81BE9F;      ;
                       dw $00C0,$0090,$008B,$0802,$0060,$0090,$008C,$1002;81BEAF;      ;
                       dw $0040,$00C0,$008D,$2002,$0030,$00C0,$008E,$4002;81BEBF;      ;
                       dw $00B0,$00C0,$008F,$8002,$0040,$00C0,$009D,$0103;81BECF;      ;
                       dw $0040,$0160,$0094,$0203,$0000,$0000,$0000,$0403;81BEDF;      ;
                       dw $0000,$0000,$0000,$0000,$0090,$0140,$00B7,$1000;81BEEF;      ;
                       dw $00A0,$0140,$00B8,$2000,$00B0,$0140,$00B9,$4000;81BEFF;      ;
                       dw $00C0,$0140,$00BA,$8000,$00D0,$0140,$00BB,$0801;81BF0F;      ;
                       dw $00E0,$0150,$00BC,$0000,$0000,$0000,$0000,$0000;81BF1F;      ;
                       dw $00E0,$0170,$00D1,$1001,$00E0,$0150,$00D0,$2001;81BF2F;      ;
                       dw $00E0,$0160,$00CF,$4001,$0090,$0140,$00CA,$0102;81BF3F;      ;
                       dw $00A0,$0140,$00CB,$0202,$00B0,$0140,$00CC,$0402;81BF4F;      ;
                       dw $00C0,$0140,$00CD,$0802,$00D0,$0140,$00CE,$1002;81BF5F;      ;
                       dw $0000,$0000,$0000,$0000,$0020,$0070,$00D6,$0201;81BF6F;      ;
                       dw $0030,$0070,$00D7,$0101,$0030,$00A0,$00D9,$0103;81BF7F;      ;
                       dw $0020,$00A0,$00D8,$0203,$0001,$0002,$0004,$0008;81BF8F;      ;
                       dw $0010,$0020,$0040,$0080,$0100,$0200,$0400,$0800;81BF9F;      ;
                       dw $1000,$2000,$4000,$8000           ;81BFAF;      ;

;;;;;;
SUB_81BFB7: ;81BFB7
      %Set8bit(!M)                             ;      ;
      %Set16bit(!X)                             ;81BFB9;      ;
      %Set16bit(!MX)                             ;81BFBB;      ;
      LDA.B !game_state                            ;81BFBD;0000D2;
      AND.W #$0001                         ;81BFBF;      ;
      BNE +                                ;81BFC2;81BFC7;
      JMP.W ResetIdleAnimatioTimer

    + %Set16bit(!MX)
      LDA.B !game_state
      AND.W #$0040
      BEQ CODE_81BFD3                      ;81BFCE;81BFD3;
      JMP.W PlayerInteractionSelector                    ;81BFD0;81D570;
                                          ;      ;      ;
                                          ;      ;      ;
    CODE_81BFD3: %Set16bit(!MX)                             ;81BFD3;      ;
      LDA.B !player_action                            ;81BFD5;0000D4;
      ASL A                                ;81BFD7;      ;
      TAX                                  ;81BFD8;      ;
      JMP.W (DATA16_81C027,X)              ;81BFD9;81C027;
                                          ;      ;      ;
      %Set16bit(!MX)                             ;81BFDC;      ;
      LDA.B !game_state                            ;81BFDE;0000D2;
      AND.W #$0004                         ;81BFE0;      ;
      BEQ CODE_81BFE8                      ;81BFE3;81BFE8;
      JMP.W CODE_81CB14                    ;81BFE5;81CB14;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_81BFE8: LDA.B !player_action                            ;81BFE8;0000D4;
      CMP.W #$0002                         ;81BFEA;      ;
      BNE CODE_81BFF2                      ;81BFED;81BFF2;
      JMP.W CODE_81C736                    ;81BFEF;81C736;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_81BFF2: CMP.W #$0001                         ;81BFF2;      ;
      BNE CODE_81BFFA                      ;81BFF5;81BFFA;
      JMP.W CODE_81C66E                    ;81BFF7;81C66E;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_81BFFA: CMP.W #$000E                         ;81BFFA;      ;
      BNE ResetIdleAnimatioTimer                      ;81BFFD;81C002;
      JMP.W CODE_81C83B                    ;81BFFF;81C83B;
                                          ;      ;      ;
                                          ;      ;      ;
      ResetIdleAnimatioTimer:
      %Set16bit(!MX)                             ;81C002;      ;
      LDA.B !player_action                            ;81C004;0000D4;
      CMP.W #$0000                         ;81C006;      ;
      BNE CODE_81C00E                      ;81C009;81C00E;
      JMP.W CODE_81C556                    ;81C00B;81C556;
                                          ;      ;      ;
                                          ;      ;      ;
      CODE_81C00E: %Set8bit(!M)                             ;81C00E;      ;
      STZ.W !idle_animation_timer                          ;81C010;000925;
                                          ;      ;      ;
      CODE_81C013: JSL.L SUB_809F61                          ;81C013;809F61;
      %Set16bit(!M)                             ;81C017;      ;
      LDA.W #$0000                         ;81C019;      ;
      STA.B $1E                            ;81C01C;00001E;
      LDA.W $0911                          ;81C01E;000911;
      STA.B !player_direction                            ;81C021;0000DA;
      STA.W $0913                          ;81C023;000913;
      RTL                                  ;81C026;      ;END_SUB_81BFB7


        DATA16_81C027: dw $BFDC,$BFDC,$BFDC,$C86B,$C991,$C9DF,$BFDC,$BFDC;81C027;      ;
                       dw $CA36,$CB5E,$C51A,$C4EC,$C395,$C364,$BFDC,$C232;81C037;      ;
                       dw $C242,$C263,$C28E,$C2AF,$C211,$C1F0,$C1A1,$C111;81C047;      ;
                       dw $C153,$C00E,$C0B5,$C333,$C061     ;81C057;      ;
                       %Set16bit(!MX)                             ;81C061;      ;
                       %Set16bit(!MX)                             ;81C063;      ;
                       LDA.B !game_state                            ;81C065;0000D2;
                       AND.W #$8000                         ;81C067;      ;
                       BEQ CODE_81C06F                      ;81C06A;81C06F;
                       JMP.W CODE_81C08A                    ;81C06C;81C08A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C06F: %Set16bit(!MX)                             ;81C06F;      ;
                       LDA.B !game_state                            ;81C071;0000D2;
                       ORA.W #$8000                         ;81C073;      ;
                       STA.B !game_state                            ;81C076;0000D2;
                       %Set8bit(!M)                             ;81C078;      ;
                       %Set16bit(!X)                             ;81C07A;      ;
                       LDA.B #$00                           ;81C07C;      ;
                       XBA                                  ;81C07E;      ;
                       LDA.W !tool_backpack                          ;81C07F;000923;
                       CLC                                  ;81C082;      ;
                       ADC.B #$90                           ;81C083;      ;
                       %Set16bit(!M)                             ;81C085;      ;
                       STA.W $0901                          ;81C087;000901;
                                                            ;      ;      ;
          CODE_81C08A: JSR.W CODE_81CFE6                    ;81C08A;81CFE6;
                       %Set16bit(!MX)                             ;81C08D;      ;
                       LDA.W $0915                          ;81C08F;000915;
                       CMP.W #$FFFF                         ;81C092;      ;
                       BNE CODE_81C0B2                      ;81C095;81C0B2;
                       %Set16bit(!MX)                             ;81C097;      ;
                       LDA.W #$0000                         ;81C099;      ;
                       STA.B !player_action                            ;81C09C;0000D4;
                       %Set8bit(!M)                             ;81C09E;      ;
                       LDA.W !tool_selected                          ;81C0A0;000921;
                       PHA                                  ;81C0A3;      ;
                       LDA.W !tool_backpack                          ;81C0A4;000923;
                       STA.W !tool_selected                          ;81C0A7;000921;
                       PLA                                  ;81C0AA;      ;
                       STA.W !tool_backpack                          ;81C0AB;000923;
                       JSL.L ToolUsedSound2                          ;81C0AE;828FF3;
                                                            ;      ;      ;
          CODE_81C0B2: JMP.W ResetIdleAnimatioTimer                    ;81C0B2;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C0B5;      ;
                       %Set16bit(!MX)                             ;81C0B7;      ;
                       LDA.W #$00F2                         ;81C0B9;      ;
                       CLC                                  ;81C0BC;      ;
                       ADC.B !player_direction                            ;81C0BD;0000DA;
                       STA.W $0901                          ;81C0BF;000901;
                       JSR.W CODE_81CFE6                    ;81C0C2;81CFE6;
                       %Set16bit(!M)                             ;81C0C5;      ;
                       LDA.W $0915                          ;81C0C7;000915;
                       CMP.W #$FFFF                         ;81C0CA;      ;
                       BNE CODE_81C10E                      ;81C0CD;81C10E;
                       %Set16bit(!MX)                             ;81C0CF;      ;
                       LDA.W #$0000                         ;81C0D1;      ;
                       STA.B !player_action                            ;81C0D4;0000D4;
                       %Set16bit(!MX)                             ;81C0D6;      ;
                       LDA.L $7F1F60                        ;81C0D8;7F1F60;
                       AND.W #$0004                         ;81C0DC;      ;
                       BNE CODE_81C0F2                      ;81C0DF;81C0F2;
                       %Set16bit(!MX)                             ;81C0E1;      ;
                       LDA.W #$0014                         ;81C0E3;      ;
                       LDX.W #$0045                         ;81C0E6;      ;
                       LDY.W #$0000                         ;81C0E9;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81C0EC;848097;
                       BRA CODE_81C101                      ;81C0F0;81C101;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C0F2: %Set16bit(!MX)                             ;81C0F2;      ;
                       LDA.W #$0015                         ;81C0F4;      ;
                       LDX.W #$0045                         ;81C0F7;      ;
                       LDY.W #$0003                         ;81C0FA;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81C0FD;848097;
                                                            ;      ;      ;
          CODE_81C101: %Set16bit(!MX)                             ;81C101;      ;
                       LDA.L $7F1F60                        ;81C103;7F1F60;
                       AND.W #$FFF9                         ;81C107;      ;
                       STA.L $7F1F60                        ;81C10A;7F1F60;
                                                            ;      ;      ;
          CODE_81C10E: JMP.W ResetIdleAnimatioTimer                    ;81C10E;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C111;      ;
                       LDA.W $0913                          ;81C113;000913;
                       STA.B !player_direction                            ;81C116;0000DA;
                       STA.W $0911                          ;81C118;000911;
                       %Set16bit(!MX)                             ;81C11B;      ;
                       LDA.W #$00DC                         ;81C11D;      ;
                       CLC                                  ;81C120;      ;
                       ADC.B !player_direction                            ;81C121;0000DA;
                       STA.W $0901                          ;81C123;000901;
                       %Set8bit(!M)                             ;81C126;      ;
                       LDA.B #$01                           ;81C128;      ;
                       STA.B $1E                            ;81C12A;00001E;
                       JSR.W CODE_81CB77                    ;81C12C;81CB77;
                       JSR.W CODE_81CFE6                    ;81C12F;81CFE6;
                       %Set16bit(!M)                             ;81C132;      ;
                       LDA.W $0915                          ;81C134;000915;
                       CMP.W #$FFFF                         ;81C137;      ;
                       BNE CODE_81C150                      ;81C13A;81C150;
                       %Set16bit(!MX)                             ;81C13C;      ;
                       LDA.W #$0000                         ;81C13E;      ;
                       STA.B !player_action                            ;81C141;0000D4;
                       %Set16bit(!M)                             ;81C143;      ;
                       LDA.L $7F1F5C                        ;81C145;7F1F5C;
                       ORA.W #$0020                         ;81C149;      ;
                       STA.L $7F1F5C                        ;81C14C;7F1F5C;
                                                            ;      ;      ;
          CODE_81C150: JMP.W ResetIdleAnimatioTimer                    ;81C150;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C153;      ;
                       %Set16bit(!MX)                             ;81C155;      ;
                       LDA.W #$00E0                         ;81C157;      ;
                       CLC                                  ;81C15A;      ;
                       ADC.W $0911                          ;81C15B;000911;
                       STA.W $0901                          ;81C15E;000901;
                       %Set16bit(!M)                             ;81C161;      ;
                       LDA.W $0911                          ;81C163;000911;
                       STA.B !player_direction                            ;81C166;0000DA;
                       %Set8bit(!M)                             ;81C168;      ;
                       LDA.B #$01                           ;81C16A;      ;
                       STA.B $1E                            ;81C16C;00001E;
                       JSR.W CODE_81CB77                    ;81C16E;81CB77;
                       JSR.W CODE_81CFE6                    ;81C171;81CFE6;
                       %Set16bit(!M)                             ;81C174;      ;
                       LDA.W $0915                          ;81C176;000915;
                       CMP.W #$FFFF                         ;81C179;      ;
                       BNE CODE_81C19E                      ;81C17C;81C19E;
                       %Set16bit(!MX)                             ;81C17E;      ;
                       LDA.W #$0000                         ;81C180;      ;
                       STA.B !player_action                            ;81C183;0000D4;
                       %Set16bit(!MX)                             ;81C185;      ;
                       LDA.W #$0010                         ;81C187;      ;
                       EOR.W #$FFFF                         ;81C18A;      ;
                       AND.B !game_state                            ;81C18D;0000D2;
                       STA.B !game_state                            ;81C18F;0000D2;
                       %Set16bit(!M)                             ;81C191;      ;
                       LDA.L $7F1F5C                        ;81C193;7F1F5C;
                       ORA.W #$0800                         ;81C197;      ;
                       STA.L $7F1F5C                        ;81C19A;7F1F5C;
                                                            ;      ;      ;
          CODE_81C19E: JMP.W ResetIdleAnimatioTimer                    ;81C19E;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C1A1;      ;
                       %Set16bit(!MX)                             ;81C1A3;      ;
                       LDA.W #$00D8                         ;81C1A5;      ;
                       CLC                                  ;81C1A8;      ;
                       ADC.B !player_direction                            ;81C1A9;0000DA;
                       STA.W $0901                          ;81C1AB;000901;
                       JSR.W CODE_81CFE6                    ;81C1AE;81CFE6;
                       %Set16bit(!M)                             ;81C1B1;      ;
                       LDA.W $0915                          ;81C1B3;000915;
                       CMP.W #$FFFF                         ;81C1B6;      ;
                       BNE CODE_81C1ED                      ;81C1B9;81C1ED;
                       %Set16bit(!MX)                             ;81C1BB;      ;
                       LDA.W #$0000                         ;81C1BD;      ;
                       STA.B !player_action                            ;81C1C0;0000D4;
                       %Set16bit(!MX)                             ;81C1C2;      ;
                       LDA.L !dog_pos_X                        ;81C1C4;7F1F2C;
                       STA.W !tile_in_front_X                          ;81C1C8;000985;
                       LDA.L !dog_pos_Y                        ;81C1CB;7F1F2E;
                       STA.W !tile_in_front_Y                          ;81C1CF;000987;
                       LDA.W #$0016                         ;81C1D2;      ;
                       LDX.W #$0000                         ;81C1D5;      ;
                       LDY.W #$0012                         ;81C1D8;      ;
                       JSL.L SUB_8480F8                    ;81C1DB;8480F8;
                       %Set16bit(!M)                             ;81C1DF;      ;
                       LDA.W #$0001                         ;81C1E1;      ;
                       STA.L $7F1F58                        ;81C1E4;7F1F58;
                       %Set8bit(!M)                             ;81C1E8;      ;
                       STZ.W $0938                          ;81C1EA;000938;
                                                            ;      ;      ;
          CODE_81C1ED: JMP.W ResetIdleAnimatioTimer                    ;81C1ED;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C1F0;      ;
                       %Set16bit(!MX)                             ;81C1F2;      ;
                       LDA.W #$00CC                         ;81C1F4;      ;
                       STA.W $0901                          ;81C1F7;000901;
                       JSR.W CODE_81CFE6                    ;81C1FA;81CFE6;
                       %Set16bit(!M)                             ;81C1FD;      ;
                       LDA.W $0915                          ;81C1FF;000915;
                       CMP.W #$FFFF                         ;81C202;      ;
                       BNE CODE_81C20E                      ;81C205;81C20E;
                       %Set16bit(!MX)                             ;81C207;      ;
                       LDA.W #$0014                         ;81C209;      ;
                       STA.B !player_action                            ;81C20C;0000D4;
                                                            ;      ;      ;
          CODE_81C20E: JMP.W ResetIdleAnimatioTimer                    ;81C20E;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C211;      ;
                       %Set16bit(!MX)                             ;81C213;      ;
                       LDA.W #$008F                         ;81C215;      ;
                       STA.W $0901                          ;81C218;000901;
                       JSR.W CODE_81CFE6                    ;81C21B;81CFE6;
                       %Set16bit(!M)                             ;81C21E;      ;
                       LDA.W $0915                          ;81C220;000915;
                       CMP.W #$FFFF                         ;81C223;      ;
                       BNE CODE_81C22F                      ;81C226;81C22F;
                       %Set16bit(!MX)                             ;81C228;      ;
                       LDA.W #$0000                         ;81C22A;      ;
                       STA.B !player_action                            ;81C22D;0000D4;
                                                            ;      ;      ;
          CODE_81C22F: JMP.W ResetIdleAnimatioTimer                    ;81C22F;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C232;      ;
                       %Set16bit(!MX)                             ;81C234;      ;
                       LDA.W #$0088                         ;81C236;      ;
                       STA.W $0901                          ;81C239;000901;
                       JSR.W CODE_81CFE6                    ;81C23C;81CFE6;
                       JMP.W ResetIdleAnimatioTimer                    ;81C23F;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C242;      ;
                       %Set16bit(!MX)                             ;81C244;      ;
                       LDA.W #$0089                         ;81C246;      ;
                       STA.W $0901                          ;81C249;000901;
                       JSR.W CODE_81CFE6                    ;81C24C;81CFE6;
                       %Set16bit(!M)                             ;81C24F;      ;
                       LDA.W $0915                          ;81C251;000915;
                       CMP.W #$FFFF                         ;81C254;      ;
                       BNE CODE_81C260                      ;81C257;81C260;
                       %Set16bit(!MX)                             ;81C259;      ;
                       LDA.W #$0011                         ;81C25B;      ;
                       STA.B !player_action                            ;81C25E;0000D4;
                                                            ;      ;      ;
          CODE_81C260: JMP.W ResetIdleAnimatioTimer                    ;81C260;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C263;      ;
                       %Set8bit(!M)                             ;81C265;      ;
                       LDA.B #$FF                           ;81C267;      ;
                       JSL.L RNGReturn0toA                  ;81C269;8089F9;
                       BNE CODE_81C280                      ;81C26D;81C280;
                       %Set8bit(!M)                             ;81C26F;      ;
                       LDA.B #$04                           ;81C271;      ;
                       JSL.L RNGReturn0toA                  ;81C273;8089F9;
                       BNE CODE_81C280                      ;81C277;81C280;
                       %Set16bit(!MX)                             ;81C279;      ;
                       LDA.W #$0012                         ;81C27B;      ;
                       STA.B !player_action                            ;81C27E;0000D4;
                                                            ;      ;      ;
          CODE_81C280: %Set16bit(!MX)                             ;81C280;      ;
                       LDA.W #$008E                         ;81C282;      ;
                       STA.W $0901                          ;81C285;000901;
                       JSR.W CODE_81CFE6                    ;81C288;81CFE6;
                       JMP.W ResetIdleAnimatioTimer                    ;81C28B;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C28E;      ;
                       %Set16bit(!MX)                             ;81C290;      ;
                       LDA.W #$008A                         ;81C292;      ;
                       STA.W $0901                          ;81C295;000901;
                       JSR.W CODE_81CFE6                    ;81C298;81CFE6;
                       %Set16bit(!M)                             ;81C29B;      ;
                       LDA.W $0915                          ;81C29D;000915;
                       CMP.W #$FFFF                         ;81C2A0;      ;
                       BNE CODE_81C2AC                      ;81C2A3;81C2AC;
                       %Set16bit(!MX)                             ;81C2A5;      ;
                       LDA.W #$0011                         ;81C2A7;      ;
                       STA.B !player_action                            ;81C2AA;0000D4;
                                                            ;      ;      ;
          CODE_81C2AC: JMP.W ResetIdleAnimatioTimer                    ;81C2AC;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C2AF;      ;
                       JSR.W CODE_81CFE6                    ;81C2B1;81CFE6;
                       %Set16bit(!M)                             ;81C2B4;      ;
                       LDA.W $0915                          ;81C2B6;000915;
                       CMP.W #$FFFF                         ;81C2B9;      ;
                       BNE CODE_81C330                      ;81C2BC;81C330;
                       %Set16bit(!MX)                             ;81C2BE;      ;
                       LDA.W #$000F                         ;81C2C0;      ;
                       STA.B !player_action                            ;81C2C3;0000D4;
                       %Set16bit(!M)                             ;81C2C5;      ;
                       LDA.W #$0014                         ;81C2C7;      ;
                       JSL.L SetCCPoiner                   ;81C2CA;84887C;
                       %Set8bit(!M)                             ;81C2CE;      ;
                       %Set16bit(!X)                             ;81C2D0;      ;
                       LDY.W #$0000                         ;81C2D2;      ;
                       LDA.B [$CC],Y                        ;81C2D5;0000CC;
                       BEQ CODE_81C2E2                      ;81C2D7;81C2E2;
                       %Set16bit(!MX)                             ;81C2D9;      ;
                       LDA.W #$0014                         ;81C2DB;      ;
                       JSL.L SUB_848020                    ;81C2DE;848020;
                                                            ;      ;      ;
          CODE_81C2E2: %Set16bit(!MX)                             ;81C2E2;      ;
                       LDA.W $0901                          ;81C2E4;000901;
                       CMP.W #$008B                         ;81C2E7;      ;
                       BEQ CODE_81C303                      ;81C2EA;81C303;
                       CMP.W #$008C                         ;81C2EC;      ;
                       BEQ CODE_81C31E                      ;81C2EF;81C31E;
                       %Set16bit(!MX)                             ;81C2F1;      ;
                       LDA.W #$0014                         ;81C2F3;      ;
                       LDX.W #$0000                         ;81C2F6;      ;
                       LDY.W #$0033                         ;81C2F9;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81C2FC;848097;
                       JMP.W CODE_81C330                    ;81C300;81C330;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C303: %Set16bit(!MX)                             ;81C303;      ;
                       LDA.W #$0014                         ;81C305;      ;
                       LDX.W #$0000                         ;81C308;      ;
                       LDY.W #$0035                         ;81C30B;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81C30E;848097;
                       %Set16bit(!M)                             ;81C312;      ;
                       LDA.W #$0002                         ;81C314;      ;
                       JSL.L AddPlayerHappiness                   ;81C317;83B282;
                       JMP.W CODE_81C330                    ;81C31B;81C330;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C31E: %Set16bit(!MX)                             ;81C31E;      ;
                       LDA.W #$0014                         ;81C320;      ;
                       LDX.W #$0000                         ;81C323;      ;
                       LDY.W #$0034                         ;81C326;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81C329;848097;
                       JMP.W CODE_81C330                    ;81C32D;81C330;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C330: JMP.W ResetIdleAnimatioTimer                    ;81C330;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C333;      ;
                       LDA.L $7F1F60                        ;81C335;7F1F60;
                       ORA.W #$0010                         ;81C339;      ;
                       STA.L $7F1F60                        ;81C33C;7F1F60;
                       %Set16bit(!MX)                             ;81C340;      ;
                       %Set16bit(!MX)                             ;81C342;      ;
                       LDA.W #$00BC                         ;81C344;      ;
                       CLC                                  ;81C347;      ;
                       ADC.B !player_direction                            ;81C348;0000DA;
                       STA.W $0901                          ;81C34A;000901;
                       JSR.W CODE_81CFE6                    ;81C34D;81CFE6;
                       %Set16bit(!M)                             ;81C350;      ;
                       LDA.W $0915                          ;81C352;000915;
                       CMP.W #$FFFF                         ;81C355;      ;
                       BNE CODE_81C361                      ;81C358;81C361;
                       %Set16bit(!MX)                             ;81C35A;      ;
                       LDA.W #$0000                         ;81C35C;      ;
                       STA.B !player_action                            ;81C35F;0000D4;
                                                            ;      ;      ;
          CODE_81C361: JMP.W ResetIdleAnimatioTimer                    ;81C361;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C364;      ;
                       LDA.L $7F1F5C                        ;81C366;7F1F5C;
                       ORA.W #$0400                         ;81C36A;      ;
                       STA.L $7F1F5C                        ;81C36D;7F1F5C;
                       %Set16bit(!MX)                             ;81C371;      ;
                       %Set16bit(!MX)                             ;81C373;      ;
                       LDA.W #$00BC                         ;81C375;      ;
                       CLC                                  ;81C378;      ;
                       ADC.B !player_direction                            ;81C379;0000DA;
                       STA.W $0901                          ;81C37B;000901;
                       JSR.W CODE_81CFE6                    ;81C37E;81CFE6;
                       %Set16bit(!M)                             ;81C381;      ;
                       LDA.W $0915                          ;81C383;000915;
                       CMP.W #$FFFF                         ;81C386;      ;
                       BNE CODE_81C392                      ;81C389;81C392;
                       %Set16bit(!MX)                             ;81C38B;      ;
                       LDA.W #$0000                         ;81C38D;      ;
                       STA.B !player_action                            ;81C390;0000D4;
                                                            ;      ;      ;
          CODE_81C392: JMP.W ResetIdleAnimatioTimer                    ;81C392;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C395;      ;
                       %Set16bit(!MX)                             ;81C397;      ;
                       LDA.B !game_state                            ;81C399;0000D2;
                       AND.W #$8000                         ;81C39B;      ;
                       BEQ CODE_81C3A3                      ;81C39E;81C3A3;
                       JMP.W CODE_81C4CA                    ;81C3A0;81C4CA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C3A3: %Set16bit(!MX)                             ;81C3A3;      ;
                       LDA.B !game_state                            ;81C3A5;0000D2;
                       ORA.W #$8000                         ;81C3A7;      ;
                       STA.B !game_state                            ;81C3AA;0000D2;
                       %Set8bit(!M)                             ;81C3AC;      ;
                       %Set16bit(!X)                             ;81C3AE;      ;
                       LDA.B #$00                           ;81C3B0;      ;
                       XBA                                  ;81C3B2;      ;
                       LDA.W !tool_selected                          ;81C3B3;000921;
                       CLC                                  ;81C3B6;      ;
                       ADC.B #$90                           ;81C3B7;      ;
                       %Set16bit(!M)                             ;81C3B9;      ;
                       STA.W $0901                          ;81C3BB;000901;
                       %Set16bit(!MX)                             ;81C3BE;      ;
                       LDA.L $7F1F6E                        ;81C3C0;7F1F6E;
                       AND.W #$4000                         ;81C3C4;      ;
                       BNE CODE_81C3CC                      ;81C3C7;81C3CC;
                       JMP.W CODE_81C4B2                    ;81C3C9;81C4B2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C3CC: LDA.L $7F1F60                        ;81C3CC;7F1F60;
                       AND.W #$0200                         ;81C3D0;      ;
                       BEQ CODE_81C3D8                      ;81C3D3;81C3D8;
                       JMP.W CODE_81C4B2                    ;81C3D5;81C4B2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C3D8: %Set8bit(!M)                             ;81C3D8;      ;
                       LDA.L !hour                        ;81C3DA;7F1F1C;
                       CMP.B #$06                           ;81C3DE;      ;
                       BEQ CODE_81C415                      ;81C3E0;81C415;
                       CMP.B #$07                           ;81C3E2;      ;
                       BEQ CODE_81C41D                      ;81C3E4;81C41D;
                       CMP.B #$08                           ;81C3E6;      ;
                       BEQ CODE_81C425                      ;81C3E8;81C425;
                       CMP.B #$09                           ;81C3EA;      ;
                       BEQ CODE_81C42D                      ;81C3EC;81C42D;
                       CMP.B #$0A                           ;81C3EE;      ;
                       BEQ CODE_81C435                      ;81C3F0;81C435;
                       CMP.B #$0B                           ;81C3F2;      ;
                       BEQ CODE_81C43D                      ;81C3F4;81C43D;
                       CMP.B #$0C                           ;81C3F6;      ;
                       BEQ CODE_81C445                      ;81C3F8;81C445;
                       CMP.B #$0D                           ;81C3FA;      ;
                       BEQ CODE_81C44D                      ;81C3FC;81C44D;
                       CMP.B #$0E                           ;81C3FE;      ;
                       BEQ CODE_81C455                      ;81C400;81C455;
                       CMP.B #$0F                           ;81C402;      ;
                       BEQ CODE_81C45D                      ;81C404;81C45D;
                       CMP.B #$10                           ;81C406;      ;
                       BEQ CODE_81C465                      ;81C408;81C465;
                       CMP.B #$11                           ;81C40A;      ;
                       BEQ CODE_81C46D                      ;81C40C;81C46D;
                       CMP.B #$12                           ;81C40E;      ;
                       BNE CODE_81C415                      ;81C410;81C415;
                       JMP.W CODE_81C4AA                    ;81C412;81C4AA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C415: %Set16bit(!MX)                             ;81C415;      ;
                       LDX.W #$046B                         ;81C417;      ;
                       JMP.W CODE_81C4BA                    ;81C41A;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C41D: %Set16bit(!MX)                             ;81C41D;      ;
                       LDX.W #$046C                         ;81C41F;      ;
                       JMP.W CODE_81C4BA                    ;81C422;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C425: %Set16bit(!MX)                             ;81C425;      ;
                       LDX.W #$046D                         ;81C427;      ;
                       JMP.W CODE_81C4BA                    ;81C42A;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C42D: %Set16bit(!MX)                             ;81C42D;      ;
                       LDX.W #$046E                         ;81C42F;      ;
                       JMP.W CODE_81C4BA                    ;81C432;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C435: %Set16bit(!MX)                             ;81C435;      ;
                       LDX.W #$046F                         ;81C437;      ;
                       JMP.W CODE_81C4BA                    ;81C43A;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C43D: %Set16bit(!MX)                             ;81C43D;      ;
                       LDX.W #$0470                         ;81C43F;      ;
                       JMP.W CODE_81C4BA                    ;81C442;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C445: %Set16bit(!MX)                             ;81C445;      ;
                       LDX.W #$0471                         ;81C447;      ;
                       JMP.W CODE_81C4BA                    ;81C44A;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C44D: %Set16bit(!MX)                             ;81C44D;      ;
                       LDX.W #$0472                         ;81C44F;      ;
                       JMP.W CODE_81C4BA                    ;81C452;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C455: %Set16bit(!MX)                             ;81C455;      ;
                       LDX.W #$0473                         ;81C457;      ;
                       JMP.W CODE_81C4BA                    ;81C45A;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C45D: %Set16bit(!MX)                             ;81C45D;      ;
                       LDX.W #$0474                         ;81C45F;      ;
                       JMP.W CODE_81C4BA                    ;81C462;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C465: %Set16bit(!MX)                             ;81C465;      ;
                       LDX.W #$0475                         ;81C467;      ;
                       JMP.W CODE_81C4BA                    ;81C46A;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C46D: %Set16bit(!MX)                             ;81C46D;      ;
                       LDA.L $7F1F66                        ;81C46F;7F1F66;
                       AND.W #$0001                         ;81C473;      ;
                       BNE CODE_81C4A2                      ;81C476;81C4A2;
                       LDA.L $7F1F66                        ;81C478;7F1F66;
                       AND.W #$0002                         ;81C47C;      ;
                       BNE CODE_81C4A2                      ;81C47F;81C4A2;
                       LDA.L $7F1F66                        ;81C481;7F1F66;
                       AND.W #$0004                         ;81C485;      ;
                       BNE CODE_81C4A2                      ;81C488;81C4A2;
                       LDA.L $7F1F66                        ;81C48A;7F1F66;
                       AND.W #$0008                         ;81C48E;      ;
                       BNE CODE_81C4A2                      ;81C491;81C4A2;
                       LDA.L $7F1F66                        ;81C493;7F1F66;
                       AND.W #$0010                         ;81C497;      ;
                       BNE CODE_81C4A2                      ;81C49A;81C4A2;
                       LDX.W #$0476                         ;81C49C;      ;
                       JMP.W CODE_81C4BA                    ;81C49F;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C4A2: %Set16bit(!MX)                             ;81C4A2;      ;
                       LDX.W #$0478                         ;81C4A4;      ;
                       JMP.W CODE_81C4BA                    ;81C4A7;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C4AA: %Set16bit(!MX)                             ;81C4AA;      ;
                       LDX.W #$0477                         ;81C4AC;      ;
                       JMP.W CODE_81C4BA                    ;81C4AF;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C4B2: %Set16bit(!MX)                             ;81C4B2;      ;
                       LDX.W #$046A                         ;81C4B4;      ;
                       JMP.W CODE_81C4BA                    ;81C4B7;81C4BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C4BA: %Set8bit(!M)                             ;81C4BA;      ;
                       LDA.B #$02                           ;81C4BC;      ;
                       STA.W !inputstate                          ;81C4BE;00019A;
                       LDA.B #$00                           ;81C4C1;      ;
                       STA.W $0191                          ;81C4C3;000191;
                       JSL.L StartTextBox                    ;81C4C6;83935F;
                                                            ;      ;      ;
          CODE_81C4CA: JSR.W CODE_81CFE6                    ;81C4CA;81CFE6;
                       %Set16bit(!MX)                             ;81C4CD;      ;
                       LDA.W $0915                          ;81C4CF;000915;
                       CMP.W #$FFFF                         ;81C4D2;      ;
                       BNE CODE_81C4E9                      ;81C4D5;81C4E9;
                       %Set16bit(!M)                             ;81C4D7;      ;
                       LDA.L $7F1F5A                        ;81C4D9;7F1F5A;
                       AND.W #$4000                         ;FLAG5A
                       BNE CODE_81C4E9                      ;81C4E0;81C4E9;
                       %Set16bit(!MX)                             ;81C4E2;      ;
                       LDA.W #$0000                         ;81C4E4;      ;
                       STA.B !player_action                            ;81C4E7;0000D4;
                                                            ;      ;      ;
          CODE_81C4E9: JMP.W ResetIdleAnimatioTimer                    ;81C4E9;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C4EC;      ;
                       %Set16bit(!MX)                             ;81C4EE;      ;
                       LDA.B !game_state                            ;81C4F0;0000D2;
                       AND.W #$8000                         ;81C4F2;      ;
                       BEQ CODE_81C4FA                      ;81C4F5;81C4FA;
                       JMP.W CODE_81C503                    ;81C4F7;81C503;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C4FA: %Set16bit(!MX)                             ;81C4FA;      ;
                       LDA.B !game_state                            ;81C4FC;0000D2;
                       ORA.W #$8000                         ;81C4FE;      ;
                       STA.B !game_state                            ;81C501;0000D2;
                                                            ;      ;      ;
          CODE_81C503: JSR.W CODE_81CFE6                    ;81C503;81CFE6;
                       %Set16bit(!M)                             ;81C506;      ;
                       LDA.W $0915                          ;81C508;000915;
                       CMP.W #$FFFF                         ;81C50B;      ;
                       BNE CODE_81C517                      ;81C50E;81C517;
                       %Set16bit(!MX)                             ;81C510;      ;
                       LDA.W #$0000                         ;81C512;      ;
                       STA.B !player_action                            ;81C515;0000D4;
                                                            ;      ;      ;
          CODE_81C517: JMP.W ResetIdleAnimatioTimer                    ;81C517;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C51A;      ;
                       %Set16bit(!MX)                             ;81C51C;      ;
                       LDA.B !game_state                            ;81C51E;0000D2;
                       AND.W #$8000                         ;81C520;      ;
                       BEQ CODE_81C528                      ;81C523;81C528;
                       JMP.W CODE_81C531                    ;81C525;81C531;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C528: %Set16bit(!MX)                             ;81C528;      ;
                       LDA.B !game_state                            ;81C52A;0000D2;
                       ORA.W #$8000                         ;81C52C;      ;
                       STA.B !game_state                            ;81C52F;0000D2;
                                                            ;      ;      ;
          CODE_81C531: JSR.W CODE_81CFE6                    ;81C531;81CFE6;
                       %Set16bit(!M)                             ;81C534;      ;
                       LDA.W $0915                          ;81C536;000915;
                       CMP.W #$FFFF                         ;81C539;      ;
                       BNE CODE_81C542                      ;81C53C;81C542;
                       JSL.L SUB_829260                    ;81C53E;829260;
                                                            ;      ;      ;
          CODE_81C542: %Set8bit(!M)                             ;81C542;      ;
                       LDA.W !counter_tool_sound                          ;81C544;00091B;
                       INC A                                ;81C547;      ;
                       STA.W !counter_tool_sound                          ;81C548;00091B;
                       CMP.B #$18                           ;81C54B;      ;
                       BNE CODE_81C553                      ;81C54D;81C553;
                       JSL.L ToolUsedSound1                          ;81C54F;828FB1;
                                                            ;      ;      ;
          CODE_81C553: JMP.W ResetIdleAnimatioTimer                    ;81C553;81C002;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C556: %Set16bit(!MX)                             ;81C556;      ;
                       %Set16bit(!MX)                             ;81C558;      ;
                       LDA.W #$8000                         ;81C55A;      ;
                       EOR.W #$FFFF                         ;81C55D;      ;
                       AND.B !game_state                            ;81C560;0000D2;
                       STA.B !game_state                            ;81C562;0000D2;
                       %Set16bit(!MX)                             ;81C564;      ;
                       LDA.B !game_state                            ;81C566;0000D2;
                       AND.W #$2000                         ;81C568;      ;
                       BEQ CODE_81C570                      ;81C56B;81C570;
                       JMP.W CODE_81C668                    ;81C56D;81C668;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C570: %Set16bit(!MX)                             ;81C570;      ;
                       LDA.B !game_state                            ;81C572;0000D2;
                       AND.W #$4000                         ;81C574;      ;
                       BNE CODE_81C57C                      ;81C577;81C57C;
                       JMP.W CODE_81C5BD                    ;81C579;81C5BD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C57C: %Set8bit(!M)                             ;81C57C;      ;
                       LDA.W !idle_animation_timer                          ;81C57E;000925;
                       CMP.B #$F0                           ;81C581;      ;
                       BNE CODE_81C5B5                      ;81C583;81C5B5;
                       LDA.B #$78                           ;81C585;      ;
                       STA.W !idle_animation_timer                          ;81C587;000925;
                       %Set16bit(!MX)                             ;81C58A;      ;
                       LDA.W #$0009                         ;81C58C;      ;
                       STA.B !player_action                            ;81C58F;0000D4;
                       LDA.B !player_direction                            ;81C591;0000DA;
                       ASL A                                ;81C593;      ;
                       CLC                                  ;81C594;      ;
                       ADC.W #$003C                         ;81C595;      ;
                       STA.W $0901                          ;81C598;000901;
                       %Set8bit(!M)                             ;81C59B;      ;
                       LDA.B #$02                           ;81C59D;      ;
                       JSL.L RNGReturn0toA                  ;81C59F;8089F9;
                       %Set8bit(!M)                             ;81C5A3;      ;
                       XBA                                  ;81C5A5;      ;
                       LDA.B #$00                           ;81C5A6;      ;
                       XBA                                  ;81C5A8;      ;
                       %Set16bit(!M)                             ;81C5A9;      ;
                       CLC                                  ;81C5AB;      ;
                       ADC.W $0901                          ;81C5AC;000901;
                       STA.W $0901                          ;81C5AF;000901;
                       JMP.W CODE_81CB5E                    ;81C5B2;81CB5E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C5B5: %Set8bit(!M)                             ;81C5B5;      ;
                       %Set16bit(!X)                             ;81C5B7;      ;
                       INC A                                ;81C5B9;      ;
                       STA.W !idle_animation_timer                          ;81C5BA;000925;
                                                            ;      ;      ;
          CODE_81C5BD: %Set16bit(!MX)                             ;81C5BD;      ;
                       LDA.B !game_state                            ;81C5BF;0000D2;
                       AND.W #$0002                         ;81C5C1;      ;
                       BEQ CODE_81C5C9                      ;81C5C4;81C5C9;
                       JMP.W CODE_81C611                    ;81C5C6;81C611;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C5C9: %Set16bit(!MX)                             ;81C5C9;      ;
                       LDA.B !game_state                            ;81C5CB;0000D2;
                       AND.W #$0010                         ;81C5CD;      ;
                       BEQ CODE_81C5D5                      ;81C5D0;81C5D5;
                       JMP.W CODE_81C61E                    ;81C5D2;81C61E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C5D5: %Set16bit(!MX)                             ;81C5D5;      ;
                       LDA.B !game_state                            ;81C5D7;0000D2;
                       AND.W #$0020                         ;81C5D9;      ;
                       BEQ CODE_81C5E1                      ;81C5DC;81C5E1;
                       JMP.W CODE_81C62B                    ;81C5DE;81C62B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C5E1: %Set16bit(!MX)                             ;81C5E1;      ;
                       LDA.B !game_state                            ;81C5E3;0000D2;
                       AND.W #$0100                         ;81C5E5;      ;
                       BEQ CODE_81C5ED                      ;81C5E8;81C5ED;
                       JMP.W CODE_81C638                    ;81C5EA;81C638;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C5ED: %Set16bit(!MX)                             ;81C5ED;      ;
                       LDA.B !game_state                            ;81C5EF;0000D2;
                       AND.W #$0800                         ;81C5F1;      ;
                       BEQ CODE_81C5F9                      ;81C5F4;81C5F9;
                       JMP.W CODE_81C642                    ;81C5F6;81C642;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C5F9: %Set16bit(!M)                             ;81C5F9;      ;
                       LDA.L $7F1F60                        ;81C5FB;7F1F60;
                       AND.W #$0006                         ;81C5FF;      ;
                       BNE CODE_81C64F                      ;81C602;81C64F;
                       %Set16bit(!MX)                             ;81C604;      ;
                       LDA.W #$0000                         ;81C606;      ;
                       CLC                                  ;81C609;      ;
                       ADC.B !player_direction                            ;81C60A;0000DA;
                       STA.W $0901                          ;81C60C;000901;
                       BRA CODE_81C65C                      ;81C60F;81C65C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C611: %Set16bit(!MX)                             ;81C611;      ;
                       LDA.W #$0014                         ;81C613;      ;
                       CLC                                  ;81C616;      ;
                       ADC.B !player_direction                            ;81C617;0000DA;
                       STA.W $0901                          ;81C619;000901;
                       BRA CODE_81C662                      ;81C61C;81C662;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C61E: %Set16bit(!MX)                             ;81C61E;      ;
                       LDA.W #$00B0                         ;81C620;      ;
                       CLC                                  ;81C623;      ;
                       ADC.B !player_direction                            ;81C624;0000DA;
                       STA.W $0901                          ;81C626;000901;
                       BRA CODE_81C662                      ;81C629;81C662;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C62B: %Set16bit(!MX)                             ;81C62B;      ;
                       LDA.W #$00C0                         ;81C62D;      ;
                       CLC                                  ;81C630;      ;
                       ADC.B !player_direction                            ;81C631;0000DA;
                       STA.W $0901                          ;81C633;000901;
                       BRA CODE_81C662                      ;81C636;81C662;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C638: %Set16bit(!MX)                             ;81C638;      ;
                       LDA.W #$004F                         ;81C63A;      ;
                       STA.W $0901                          ;81C63D;000901;
                       BRA CODE_81C662                      ;81C640;81C662;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C642: %Set16bit(!MX)                             ;81C642;      ;
                       LDA.W #$00D0                         ;81C644;      ;
                       CLC                                  ;81C647;      ;
                       ADC.B !player_direction                            ;81C648;0000DA;
                       STA.W $0901                          ;81C64A;000901;
                       BRA CODE_81C662                      ;81C64D;81C662;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C64F: %Set16bit(!MX)                             ;81C64F;      ;
                       LDA.W #$00EA                         ;81C651;      ;
                       CLC                                  ;81C654;      ;
                       ADC.B !player_direction                            ;81C655;0000DA;
                       STA.W $0901                          ;81C657;000901;
                       BRA CODE_81C662                      ;81C65A;81C662;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C65C: JSR.W CODE_81CFE6                    ;81C65C;81CFE6;
                       JMP.W CODE_81C013                    ;81C65F;81C013;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C662: JSR.W CODE_81CFE6                    ;81C662;81CFE6;
                       JMP.W CODE_81C00E                    ;81C665;81C00E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C668: JSR.W CODE_81CFE6                    ;81C668;81CFE6;
                       JMP.W CODE_81C00E                    ;81C66B;81C00E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C66E: %Set16bit(!MX)                             ;81C66E;      ;
                       %Set16bit(!MX)                             ;81C670;      ;
                       LDA.W #$8000                         ;81C672;      ;
                       EOR.W #$FFFF                         ;81C675;      ;
                       AND.B !game_state                            ;81C678;0000D2;
                       STA.B !game_state                            ;81C67A;0000D2;
                       %Set16bit(!M)                             ;81C67C;      ;
                       LDA.B !game_state                            ;81C67E;0000D2;
                       AND.W #$0002                         ;81C680;      ;
                       BEQ CODE_81C688                      ;81C683;81C688;
                       JMP.W CODE_81C6C2                    ;81C685;81C6C2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C688: LDA.B !game_state                            ;81C688;0000D2;
                       AND.W #$0010                         ;81C68A;      ;
                       BEQ CODE_81C692                      ;81C68D;81C692;
                       JMP.W CODE_81C6D5                    ;81C68F;81C6D5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C692: LDA.B !game_state                            ;81C692;0000D2;
                       AND.W #$0020                         ;81C694;      ;
                       BEQ CODE_81C69C                      ;81C697;81C69C;
                       JMP.W CODE_81C6E9                    ;81C699;81C6E9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C69C: LDA.B !game_state                            ;81C69C;0000D2;
                       AND.W #$0800                         ;81C69E;      ;
                       BEQ CODE_81C6A6                      ;81C6A1;81C6A6;
                       JMP.W CODE_81C6FC                    ;81C6A3;81C6FC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C6A6: LDA.L $7F1F60                        ;81C6A6;7F1F60;
                       AND.W #$0006                         ;81C6AA;      ;
                       BNE CODE_81C70F                      ;81C6AD;81C70F;
                       %Set16bit(!MX)                             ;81C6AF;      ;
                       LDA.W #$0004                         ;81C6B1;      ;
                       CLC                                  ;81C6B4;      ;
                       ADC.B !player_direction                            ;81C6B5;0000DA;
                       STA.W $0901                          ;81C6B7;000901;
                       %Set8bit(!M)                             ;81C6BA;      ;
                       LDA.B #$01                           ;81C6BC;      ;
                       STA.B $1E                            ;81C6BE;00001E;
                       BRA CODE_81C722                      ;81C6C0;81C722;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C6C2: %Set16bit(!MX)                             ;81C6C2;      ;
                       LDA.W #$0028                         ;81C6C4;      ;
                       CLC                                  ;81C6C7;      ;
                       ADC.B !player_direction                            ;81C6C8;0000DA;
                       STA.W $0901                          ;81C6CA;000901;
                       %Set8bit(!M)                             ;81C6CD;      ;
                       LDA.B #$01                           ;81C6CF;      ;
                       STA.B $1E                            ;81C6D1;00001E;
                       BRA CODE_81C722                      ;81C6D3;81C722;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C6D5: %Set16bit(!MX)                             ;81C6D5;      ;
                       LDA.W #$00B4                         ;81C6D7;      ;
                       CLC                                  ;81C6DA;      ;
                       ADC.B !player_direction                            ;81C6DB;0000DA;
                       STA.W $0901                          ;81C6DD;000901;
                       %Set8bit(!M)                             ;81C6E0;      ;
                       LDA.B #$03                           ;81C6E2;      ;
                       STA.B $1E                            ;81C6E4;00001E;
                       JMP.W CODE_81C806                    ;81C6E6;81C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C6E9: %Set16bit(!MX)                             ;81C6E9;      ;
                       LDA.W #$00C4                         ;81C6EB;      ;
                       CLC                                  ;81C6EE;      ;
                       ADC.B !player_direction                            ;81C6EF;0000DA;
                       STA.W $0901                          ;81C6F1;000901;
                       %Set8bit(!M)                             ;81C6F4;      ;
                       LDA.B #$01                           ;81C6F6;      ;
                       STA.B $1E                            ;81C6F8;00001E;
                       BRA CODE_81C722                      ;81C6FA;81C722;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C6FC: %Set16bit(!MX)                             ;81C6FC;      ;
                       LDA.W #$00D4                         ;81C6FE;      ;
                       CLC                                  ;81C701;      ;
                       ADC.B !player_direction                            ;81C702;0000DA;
                       STA.W $0901                          ;81C704;000901;
                       %Set8bit(!M)                             ;81C707;      ;
                       LDA.B #$01                           ;81C709;      ;
                       STA.B $1E                            ;81C70B;00001E;
                       BRA CODE_81C722                      ;81C70D;81C722;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C70F: %Set16bit(!MX)                             ;81C70F;      ;
                       LDA.W #$00EE                         ;81C711;      ;
                       CLC                                  ;81C714;      ;
                       ADC.B !player_direction                            ;81C715;0000DA;
                       STA.W $0901                          ;81C717;000901;
                       %Set8bit(!M)                             ;81C71A;      ;
                       LDA.B #$01                           ;81C71C;      ;
                       STA.B $1E                            ;81C71E;00001E;
                       BRA CODE_81C722                      ;81C720;81C722;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C722: JSR.W CODE_81CB77                    ;81C722;81CB77;
                       %Set16bit(!MX)                             ;81C725;      ;
                       LDA.W #$0000                         ;81C727;      ;
                       STA.B !player_action                            ;81C72A;0000D4;
                       %Set8bit(!M)                             ;81C72C;      ;
                       %Set16bit(!X)                             ;81C72E;      ;
                       STZ.W $096D                          ;81C730;00096D;
                       JMP.W CODE_81C00E                    ;81C733;81C00E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C736: %Set16bit(!MX)                             ;81C736;      ;
                       %Set16bit(!MX)                             ;81C738;      ;
                       LDA.W #$8000                         ;81C73A;      ;
                       EOR.W #$FFFF                         ;81C73D;      ;
                       AND.B !game_state                            ;81C740;0000D2;
                       STA.B !game_state                            ;81C742;0000D2;
                       %Set16bit(!M)                             ;81C744;      ;
                       LDA.B !game_state                            ;81C746;0000D2;
                       AND.W #$1000                         ;81C748;      ;
                       BNE CODE_81C761                      ;81C74B;81C761;
                       LDA.B !game_state                            ;81C74D;0000D2;
                       AND.W #$2000                         ;81C74F;      ;
                       BEQ CODE_81C757                      ;81C752;81C757;
                       JMP.W CODE_81C82A                    ;81C754;81C82A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C757: LDA.B !game_state                            ;81C757;0000D2;
                       AND.W #$4000                         ;81C759;      ;
                       BNE CODE_81C761                      ;81C75C;81C761;
                       JMP.W CODE_81C82A                    ;81C75E;81C82A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C761: %Set16bit(!M)                             ;81C761;      ;
                       LDA.B !game_state                            ;81C763;0000D2;
                       AND.W #$0002                         ;81C765;      ;
                       BEQ CODE_81C76D                      ;81C768;81C76D;
                       JMP.W CODE_81C7A7                    ;81C76A;81C7A7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C76D: LDA.B !game_state                            ;81C76D;0000D2;
                       AND.W #$0010                         ;81C76F;      ;
                       BEQ CODE_81C777                      ;81C772;81C777;
                       JMP.W CODE_81C7BA                    ;81C774;81C7BA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C777: LDA.B !game_state                            ;81C777;0000D2;
                       AND.W #$0020                         ;81C779;      ;
                       BEQ CODE_81C781                      ;81C77C;81C781;
                       JMP.W CODE_81C7CD                    ;81C77E;81C7CD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C781: LDA.B !game_state                            ;81C781;0000D2;
                       AND.W #$0800                         ;81C783;      ;
                       BEQ CODE_81C78B                      ;81C786;81C78B;
                       JMP.W CODE_81C7E0                    ;81C788;81C7E0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C78B: LDA.L $7F1F60                        ;81C78B;7F1F60;
                       AND.W #$0006                         ;81C78F;      ;
                       BNE CODE_81C7F3                      ;81C792;81C7F3;
                       %Set16bit(!MX)                             ;81C794;      ;
                       LDA.W #$0008                         ;81C796;      ;
                       CLC                                  ;81C799;      ;
                       ADC.B !player_direction                            ;81C79A;0000DA;
                       STA.W $0901                          ;81C79C;000901;
                       %Set8bit(!M)                             ;81C79F;      ;
                       LDA.B #$02                           ;81C7A1;      ;
                       STA.B $1E                            ;81C7A3;00001E;
                       BRA CODE_81C806                      ;81C7A5;81C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C7A7: %Set16bit(!MX)                             ;81C7A7;      ;
                       LDA.W #$002C                         ;81C7A9;      ;
                       CLC                                  ;81C7AC;      ;
                       ADC.B !player_direction                            ;81C7AD;0000DA;
                       STA.W $0901                          ;81C7AF;000901;
                       %Set8bit(!M)                             ;81C7B2;      ;
                       LDA.B #$02                           ;81C7B4;      ;
                       STA.B $1E                            ;81C7B6;00001E;
                       BRA CODE_81C806                      ;81C7B8;81C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C7BA: %Set16bit(!MX)                             ;81C7BA;      ;
                       LDA.W #$00B4                         ;81C7BC;      ;
                       CLC                                  ;81C7BF;      ;
                       ADC.B !player_direction                            ;81C7C0;0000DA;
                       STA.W $0901                          ;81C7C2;000901;
                       %Set8bit(!M)                             ;81C7C5;      ;
                       LDA.B #$03                           ;81C7C7;      ;
                       STA.B $1E                            ;81C7C9;00001E;
                       BRA CODE_81C806                      ;81C7CB;81C806;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C7CD: %Set16bit(!MX)                             ;81C7CD;      ;
                       LDA.W #$00C4                         ;81C7CF;      ;
                       CLC                                  ;81C7D2;      ;
                       ADC.B !player_direction                            ;81C7D3;0000DA;
                       STA.W $0901                          ;81C7D5;000901;
                       %Set8bit(!M)                             ;81C7D8;      ;
                       LDA.B #$01                           ;81C7DA;      ;
                       STA.B $1E                            ;81C7DC;00001E;
                       BRA CODE_81C827                      ;81C7DE;81C827;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C7E0: %Set16bit(!MX)                             ;81C7E0;      ;
                       LDA.W #$00D4                         ;81C7E2;      ;
                       CLC                                  ;81C7E5;      ;
                       ADC.B !player_direction                            ;81C7E6;0000DA;
                       STA.W $0901                          ;81C7E8;000901;
                       %Set8bit(!M)                             ;81C7EB;      ;
                       LDA.B #$01                           ;81C7ED;      ;
                       STA.B $1E                            ;81C7EF;00001E;
                       BRA CODE_81C827                      ;81C7F1;81C827;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C7F3: %Set16bit(!MX)                             ;81C7F3;      ;
                       LDA.W #$00EE                         ;81C7F5;      ;
                       CLC                                  ;81C7F8;      ;
                       ADC.B !player_direction                            ;81C7F9;0000DA;
                       STA.W $0901                          ;81C7FB;000901;
                       %Set8bit(!M)                             ;81C7FE;      ;
                       LDA.B #$01                           ;81C800;      ;
                       STA.B $1E                            ;81C802;00001E;
                       BRA CODE_81C827                      ;81C804;81C827;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C806: %Set8bit(!M)                             ;81C806;      ;
                       %Set16bit(!X)                             ;81C808;      ;
                       LDA.W !run_step_sound                          ;81C80A;00091A;
                       INC A                                ;81C80D;      ;
                       AND.B #$0F                           ;81C80E;      ;
                       STA.W !run_step_sound                          ;81C810;00091A;
                       BNE CODE_81C827                      ;81C813;81C827;
                       %Set8bit(!M)                             ;81C815;      ;
                       %Set16bit(!X)                             ;81C817;      ;
                       LDA.B #$05                           ;81C819;      ;
                       STA.W $0114                          ;81C81B;000114;
                       LDA.B #$06                           ;81C81E;      ;
                       STA.W $0115                          ;81C820;000115;
                       JSL.L UNK_Audio19                    ;81C823;838332;
                                                            ;      ;      ;
          CODE_81C827: JSR.W CODE_81CB77                    ;81C827;81CB77;
                                                            ;      ;      ;
          CODE_81C82A: %Set16bit(!MX)                             ;81C82A;      ;
                       LDA.W #$0000                         ;81C82C;      ;
                       STA.B !player_action                            ;81C82F;0000D4;
                       %Set8bit(!M)                             ;81C831;      ;
                       %Set16bit(!X)                             ;81C833;      ;
                       STZ.W $096D                          ;81C835;00096D;
                       JMP.W CODE_81C00E                    ;81C838;81C00E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C83B: %Set16bit(!MX)                             ;81C83B;      ;
                       %Set16bit(!MX)                             ;81C83D;      ;
                       LDA.W #$8000                         ;81C83F;      ;
                       EOR.W #$FFFF                         ;81C842;      ;
                       AND.B !game_state                            ;81C845;0000D2;
                       STA.B !game_state                            ;81C847;0000D2;
                       %Set16bit(!MX)                             ;81C849;      ;
                       LDA.W #$0045                         ;81C84B;      ;
                       STA.W $0901                          ;81C84E;000901;
                       %Set8bit(!M)                             ;81C851;      ;
                       LDA.B #$01                           ;81C853;      ;
                       STA.B $1E                            ;81C855;00001E;
                       JSR.W CODE_81CB77                    ;81C857;81CB77;
                       %Set16bit(!MX)                             ;81C85A;      ;
                       LDA.W #$0000                         ;81C85C;      ;
                       STA.B !player_action                            ;81C85F;0000D4;
                       %Set8bit(!M)                             ;81C861;      ;
                       %Set16bit(!X)                             ;81C863;      ;
                       STZ.W $096D                          ;81C865;00096D;
                       JMP.W CODE_81C00E                    ;81C868;81C00E;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C86B;      ;
                       %Set16bit(!MX)                             ;81C86D;      ;
                       LDA.B !game_state                            ;81C86F;0000D2;
                       AND.W #$8000                         ;81C871;      ;
                       BEQ CODE_81C879                      ;81C874;81C879;
                       JMP.W CODE_81C923                    ;81C876;81C923;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C879: %Set16bit(!MX)                             ;81C879;      ;
                       LDA.B !game_state                            ;81C87B;0000D2;
                       ORA.W #$8000                         ;81C87D;      ;
                       STA.B !game_state                            ;81C880;0000D2;
                       %Set16bit(!M)                             ;81C882;      ;
                       LDA.B !game_state                            ;81C884;0000D2;
                       AND.W #$0002                         ;81C886;      ;
                       BEQ CODE_81C88E                      ;81C889;81C88E;
                       JMP.W CODE_81C8C6                    ;81C88B;81C8C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C88E: LDA.B !game_state                            ;81C88E;0000D2;
                       AND.W #$0010                         ;81C890;      ;
                       BEQ CODE_81C898                      ;81C893;81C898;
                       JMP.W CODE_81C8E5                    ;81C895;81C8E5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C898: LDA.B !game_state                            ;81C898;0000D2;
                       AND.W #$0020                         ;81C89A;      ;
                       BEQ CODE_81C8A2                      ;81C89D;81C8A2;
                       JMP.W CODE_81C904                    ;81C89F;81C904;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C8A2: %Set16bit(!MX)                             ;81C8A2;      ;
                       LDA.W #$000C                         ;81C8A4;      ;
                       CLC                                  ;81C8A7;      ;
                       ADC.B !player_direction                            ;81C8A8;0000DA;
                       STA.W $0901                          ;81C8AA;000901;
                       %Set8bit(!M)                             ;81C8AD;      ;
                       %Set16bit(!X)                             ;81C8AF;      ;
                       LDA.B #$06                           ;81C8B1;      ;
                       STA.W $0114                          ;81C8B3;000114;
                       LDA.B #$06                           ;81C8B6;      ;
                       STA.W $0115                          ;81C8B8;000115;
                       JSL.L UNK_Audio19                    ;81C8BB;838332;
                       %Set8bit(!M)                             ;81C8BF;      ;
                       STZ.W $0971                          ;81C8C1;000971;
                       BRA CODE_81C923                      ;81C8C4;81C923;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C8C6: %Set16bit(!MX)                             ;81C8C6;      ;
                       LDA.W #$0020                         ;81C8C8;      ;
                       CLC                                  ;81C8CB;      ;
                       ADC.B !player_direction                            ;81C8CC;0000DA;
                       STA.W $0901                          ;81C8CE;000901;
                       %Set8bit(!M)                             ;81C8D1;      ;
                       %Set16bit(!X)                             ;81C8D3;      ;
                       LDA.B #$06                           ;81C8D5;      ;
                       STA.W $0114                          ;81C8D7;000114;
                       LDA.B #$06                           ;81C8DA;      ;
                       STA.W $0115                          ;81C8DC;000115;
                       JSL.L UNK_Audio19                    ;81C8DF;838332;
                       BRA CODE_81C923                      ;81C8E3;81C923;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C8E5: %Set16bit(!MX)                             ;81C8E5;      ;
                       LDA.W #$00B8                         ;81C8E7;      ;
                       CLC                                  ;81C8EA;      ;
                       ADC.B !player_direction                            ;81C8EB;0000DA;
                       STA.W $0901                          ;81C8ED;000901;
                       %Set8bit(!M)                             ;81C8F0;      ;
                       %Set16bit(!X)                             ;81C8F2;      ;
                       LDA.B #$06                           ;81C8F4;      ;
                       STA.W $0114                          ;81C8F6;000114;
                       LDA.B #$06                           ;81C8F9;      ;
                       STA.W $0115                          ;81C8FB;000115;
                       JSL.L UNK_Audio19                    ;81C8FE;838332;
                       BRA CODE_81C923                      ;81C902;81C923;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C904: %Set16bit(!MX)                             ;81C904;      ;
                       LDA.W #$00C8                         ;81C906;      ;
                       CLC                                  ;81C909;      ;
                       ADC.B !player_direction                            ;81C90A;0000DA;
                       STA.W $0901                          ;81C90C;000901;
                       %Set8bit(!M)                             ;81C90F;      ;
                       %Set16bit(!X)                             ;81C911;      ;
                       LDA.B #$06                           ;81C913;      ;
                       STA.W $0114                          ;81C915;000114;
                       LDA.B #$06                           ;81C918;      ;
                       STA.W $0115                          ;81C91A;000115;
                       JSL.L UNK_Audio19                    ;81C91D;838332;
                       BRA CODE_81C949                      ;81C921;81C949;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C923: %Set8bit(!M)                             ;81C923;      ;
                       %Set16bit(!X)                             ;81C925;      ;
                       LDA.B #$01                           ;81C927;      ;
                       STA.B $1E                            ;81C929;00001E;
                       %Set16bit(!MX)                             ;81C92B;      ;
                       LDA.B !game_state                            ;81C92D;0000D2;
                       AND.W #$0200                         ;81C92F;      ;
                       BNE CODE_81C937                      ;81C932;81C937;
                       JMP.W CODE_81C951                    ;81C934;81C951;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C937: %Set8bit(!M)                             ;81C937;      ;
                       LDA.W $0971                          ;81C939;000971;
                       EOR.B #$01                           ;81C93C;      ;
                       STA.W $0971                          ;81C93E;000971;
                       BEQ CODE_81C951                      ;81C941;81C951;
                       LDA.B #$02                           ;81C943;      ;
                       STA.B $1E                            ;81C945;00001E;
                       BRA CODE_81C951                      ;81C947;81C951;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C949: %Set8bit(!M)                             ;81C949;      ;
                       %Set16bit(!X)                             ;81C94B;      ;
                       LDA.B #$02                           ;81C94D;      ;
                       STA.B $1E                            ;81C94F;00001E;
                                                            ;      ;      ;
          CODE_81C951: JSR.W CODE_81CB77                    ;81C951;81CB77;
                       JSR.W CODE_81CFE6                    ;81C954;81CFE6;
                       %Set16bit(!MX)                             ;81C957;      ;
                       LDA.W $0915                          ;81C959;000915;
                       CMP.W #$FFFF                         ;81C95C;      ;
                       BNE CODE_81C98E                      ;81C95F;81C98E;
                       %Set16bit(!MX)                             ;81C961;      ;
                       LDA.W #$0000                         ;81C963;      ;
                       STA.B !player_action                            ;81C966;0000D4;
                       %Set16bit(!MX)                             ;81C968;      ;
                       LDA.W #$0200                         ;81C96A;      ;
                       EOR.W #$FFFF                         ;81C96D;      ;
                       AND.B !game_state                            ;81C970;0000D2;
                       STA.B !game_state                            ;81C972;0000D2;
                       %Set16bit(!MX)                             ;81C974;      ;
                       LDA.B !player_direction                            ;81C976;0000DA;
                       CMP.W #$0003                         ;81C978;      ;
                       BNE CODE_81C980                      ;81C97B;81C980;
                       JMP.W CODE_81C982                    ;81C97D;81C982;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C980: BRA CODE_81C98E                      ;81C980;81C98E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C982: %Set16bit(!MX)                             ;81C982;      ;
                       LDA.W #$0020                         ;81C984;      ;
                       EOR.W #$FFFF                         ;81C987;      ;
                       AND.B !game_state                            ;81C98A;0000D2;
                       STA.B !game_state                            ;81C98C;0000D2;
                                                            ;      ;      ;
          CODE_81C98E: JMP.W ResetIdleAnimatioTimer                    ;81C98E;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C991;      ;
                       %Set16bit(!MX)                             ;81C993;      ;
                       LDA.B !game_state                            ;81C995;0000D2;
                       AND.W #$8000                         ;81C997;      ;
                       BEQ CODE_81C99F                      ;81C99A;81C99F;
                       JMP.W CODE_81C9B7                    ;81C99C;81C9B7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C99F: %Set16bit(!MX)                             ;81C99F;      ;
                       LDA.B !game_state                            ;81C9A1;0000D2;
                       ORA.W #$8000                         ;81C9A3;      ;
                       STA.B !game_state                            ;81C9A6;0000D2;
                       %Set16bit(!MX)                             ;81C9A8;      ;
                       LDA.W #$0010                         ;81C9AA;      ;
                       CLC                                  ;81C9AD;      ;
                       ADC.B !player_direction                            ;81C9AE;0000DA;
                       STA.W $0901                          ;81C9B0;000901;
                       JSL.L SUB_818000                    ;81C9B3;818000;
                                                            ;      ;      ;
          CODE_81C9B7: JSR.W CODE_81CFE6                    ;81C9B7;81CFE6;
                       %Set16bit(!M)                             ;81C9BA;      ;
                       LDA.W $0915                          ;81C9BC;000915;
                       CMP.W #$FFFF                         ;81C9BF;      ;
                       BNE CODE_81C9DC                      ;81C9C2;81C9DC;
                       %Set16bit(!MX)                             ;81C9C4;      ;
                       LDA.W #$0000                         ;81C9C6;      ;
                       STA.B !player_action                            ;81C9C9;0000D4;
                       %Set16bit(!MX)                             ;81C9CB;      ;
                       LDA.B !game_state                            ;81C9CD;0000D2;
                       ORA.W #$0002                         ;81C9CF;      ;
                       STA.B !game_state                            ;81C9D2;0000D2;
                       %Set8bit(!M)                             ;81C9D4;      ;
                       LDA.W !item_on_hand                          ;81C9D6;00091D;
                       STA.W !old_item_on_hand                          ;81C9D9;00091E;
                                                            ;      ;      ;
          CODE_81C9DC: JMP.W ResetIdleAnimatioTimer                    ;81C9DC;81C002;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81C9DF;      ;
                       %Set16bit(!MX)                             ;81C9E1;      ;
                       LDA.B !game_state                            ;81C9E3;0000D2;
                       AND.W #$8000                         ;81C9E5;      ;
                       BEQ CODE_81C9ED                      ;81C9E8;81C9ED;
                       JMP.W CODE_81CA13                    ;81C9EA;81CA13;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81C9ED: %Set16bit(!MX)                             ;81C9ED;      ;
                       LDA.B !game_state                            ;81C9EF;0000D2;
                       ORA.W #$8000                         ;81C9F1;      ;
                       STA.B !game_state                            ;81C9F4;0000D2;
                       %Set16bit(!MX)                             ;81C9F6;      ;
                       LDA.W #$001C                         ;81C9F8;      ;
                       CLC                                  ;81C9FB;      ;
                       ADC.B !player_direction                            ;81C9FC;0000DA;
                       STA.W $0901                          ;81C9FE;000901;
                       %Set8bit(!M)                             ;81CA01;      ;
                       %Set16bit(!X)                             ;81CA03;      ;
                       LDA.B #$07                           ;81CA05;      ;
                       STA.W $0114                          ;81CA07;000114;
                       LDA.B #$06                           ;81CA0A;      ;
                       STA.W $0115                          ;81CA0C;000115;
                       JSL.L UNK_Audio19                    ;81CA0F;838332;
                                                            ;      ;      ;
          CODE_81CA13: JSR.W CODE_81CFE6                    ;81CA13;81CFE6;
                       %Set16bit(!M)                             ;81CA16;      ;
                       LDA.W $0915                          ;81CA18;000915;
                       CMP.W #$FFFF                         ;81CA1B;      ;
                       BNE CODE_81CA33                      ;81CA1E;81CA33;
                       %Set16bit(!MX)                             ;81CA20;      ;
                       LDA.W #$0000                         ;81CA22;      ;
                       STA.B !player_action                            ;81CA25;0000D4;
                       %Set16bit(!MX)                             ;81CA27;      ;
                       LDA.W #$0002                         ;81CA29;      ;
                       EOR.W #$FFFF                         ;81CA2C;      ;
                       AND.B !game_state                            ;81CA2F;0000D2;
                       STA.B !game_state                            ;81CA31;0000D2;
                                                            ;      ;      ;
          CODE_81CA33: JMP.W ResetIdleAnimatioTimer                    ;81CA33;81C002;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81CA36;      ;
                       %Set16bit(!X)                             ;81CA38;      ;
                       %Set16bit(!MX)                             ;81CA3A;      ;
                       LDA.B !game_state                            ;81CA3C;0000D2;
                       AND.W #$8000                         ;81CA3E;      ;
                       BEQ CODE_81CA46                      ;81CA41;81CA46;
                       JMP.W CODE_81CA60                    ;81CA43;81CA60;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CA46: %Set16bit(!MX)                             ;81CA46;      ;
                       LDA.B !game_state                            ;81CA48;0000D2;
                       ORA.W #$8000                         ;81CA4A;      ;
                       STA.B !game_state                            ;81CA4D;0000D2;
                       %Set8bit(!M)                             ;81CA4F;      ;
                       LDA.B #$00                           ;81CA51;      ;
                       XBA                                  ;81CA53;      ;
                       LDA.W $0984                          ;81CA54;000984;
                       %Set16bit(!M)                             ;81CA57;      ;
                       CLC                                  ;81CA59;      ;
                       ADC.W #$0033                         ;81CA5A;      ;
                       STA.W $0901                          ;81CA5D;000901;
                                                            ;      ;      ;
          CODE_81CA60: JSR.W CODE_81CFE6                    ;81CA60;81CFE6;
                       %Set16bit(!M)                             ;81CA63;      ;
                       LDA.W $0915                          ;81CA65;000915;
                       CMP.W #$FFFF                         ;81CA68;      ;
                       BEQ CODE_81CA70                      ;81CA6B;81CA70;
                       JMP.W CODE_81CB11                    ;81CA6D;81CB11;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CA70: %Set8bit(!M)                             ;81CA70;      ;
                       LDA.W $0984                          ;81CA72;000984;
                       CMP.B #$02                           ;81CA75;      ;
                       BEQ CODE_81CA96                      ;81CA77;81CA96;
                       LDA.W $0984                          ;81CA79;000984;
                       CMP.B #$08                           ;81CA7C;      ;
                       BEQ CODE_81CAAB                      ;81CA7E;81CAAB;
                       %Set16bit(!MX)                             ;81CA80;      ;
                       LDA.W #$0000                         ;81CA82;      ;
                       STA.B !player_action                            ;81CA85;0000D4;
                       %Set16bit(!MX)                             ;81CA87;      ;
                       LDA.W #$0002                         ;81CA89;      ;
                       EOR.W #$FFFF                         ;81CA8C;      ;
                       AND.B !game_state                            ;81CA8F;0000D2;
                       STA.B !game_state                            ;81CA91;0000D2;
                       JMP.W CODE_81CB11                    ;81CA93;81CB11;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CA96: %Set16bit(!MX)                             ;81CA96;      ;
                       LDA.W #$0014                         ;81CA98;      ;
                       STA.B !player_action                            ;81CA9B;0000D4;
                       %Set16bit(!MX)                             ;81CA9D;      ;
                       LDA.W #$0002                         ;81CA9F;      ;
                       EOR.W #$FFFF                         ;81CAA2;      ;
                       AND.B !game_state                            ;81CAA5;0000D2;
                       STA.B !game_state                            ;81CAA7;0000D2;
                       BRA CODE_81CB11                      ;81CAA9;81CB11;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CAAB: %Set8bit(!M)                             ;81CAAB;      ;
                       LDA.L !power_berry_N                        ;81CAAD;7F1F36;
                       INC A                                ;81CAB1;      ;
                       STA.L !power_berry_N                        ;81CAB2;7F1F36;
                       %Set16bit(!M)                             ;81CAB6;      ;
                       LDA.W #$000A                         ;81CAB8;      ;
                       JSL.L AddPlayerHappiness                   ;81CABB;83B282;
                       %Set8bit(!M)                             ;81CABF;      ;
                       LDA.W !max_stamina                          ;81CAC1;000917;
                       CLC                                  ;81CAC4;      ;
                       ADC.B #$0A                           ;81CAC5;      ;
                       STA.W !max_stamina                          ;81CAC7;000917;
                       %Set16bit(!MX)                             ;81CACA;      ;
                       LDA.W #$0000                         ;81CACC;      ;
                       STA.B !player_action                            ;81CACF;0000D4;
                       %Set16bit(!MX)                             ;81CAD1;      ;
                       LDA.W #$0002                         ;81CAD3;      ;
                       EOR.W #$FFFF                         ;81CAD6;      ;
                       AND.B !game_state                            ;81CAD9;0000D2;
                       STA.B !game_state                            ;81CADB;0000D2;
                       %Set8bit(!M)                             ;81CADD;      ;
                       LDA.B !tilemap_to_load                            ;81CADF;000022;
                       CMP.B #$15                           ;81CAE1;      ;
                       BEQ CODE_81CB02                      ;81CAE3;81CB02;
                       CMP.B #$16                           ;81CAE5;      ;
                       BEQ CODE_81CB02                      ;81CAE7;81CB02;
                       CMP.B #$17                           ;81CAE9;      ;
                       BEQ CODE_81CB02                      ;81CAEB;81CB02;
                       LDA.B !tilemap_to_load                            ;81CAED;000022;
                       CMP.B #$29                           ;81CAEF;      ;
                       BNE CODE_81CB11                      ;81CAF1;81CB11;
                       %Set16bit(!MX)                             ;81CAF3;      ;
                       LDA.L $7F1F6A                        ;81CAF5;7F1F6A;
                       ORA.W #$0040                         ;81CAF9;      ;
                       STA.L $7F1F6A                        ;81CAFC;7F1F6A;
                       BRA CODE_81CB11                      ;81CB00;81CB11;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB02: %Set16bit(!MX)                             ;81CB02;      ;
                       LDA.L $7F1F6C                        ;81CB04;7F1F6C;
                       ORA.W #$4000                         ;81CB08;      ;
                       STA.L $7F1F6C                        ;81CB0B;7F1F6C;
                       BRA CODE_81CB11                      ;81CB0F;81CB11;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB11: JMP.W ResetIdleAnimatioTimer                    ;81CB11;81C002;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB14: %Set8bit(!M)                             ;81CB14;      ;
                       %Set16bit(!X)                             ;81CB16;      ;
                       %Set16bit(!MX)                             ;81CB18;      ;
                       LDA.B !game_state                            ;81CB1A;0000D2;
                       AND.W #$8000                         ;81CB1C;      ;
                       BEQ CODE_81CB24                      ;81CB1F;81CB24;
                       JMP.W CODE_81CB38                    ;81CB21;81CB38;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB24: %Set16bit(!MX)                             ;81CB24;      ;
                       LDA.B !game_state                            ;81CB26;0000D2;
                       ORA.W #$8000                         ;81CB28;      ;
                       STA.B !game_state                            ;81CB2B;0000D2;
                       %Set8bit(!M)                             ;81CB2D;      ;
                       LDA.W !what_to_eat                          ;81CB2F;000924;
                       CLC                                  ;81CB32;      ;
                       ADC.B #$30                           ;81CB33;      ;
                       STA.W $0901                          ;81CB35;000901;
                                                            ;      ;      ;
          CODE_81CB38: JSR.W CODE_81CFE6                    ;81CB38;81CFE6;
                       %Set16bit(!M)                             ;81CB3B;      ;
                       LDA.W $0915                          ;81CB3D;000915;
                       CMP.W #$FFFF                         ;81CB40;      ;
                       BNE CODE_81CB5B                      ;81CB43;81CB5B;
                       %Set16bit(!MX)                             ;81CB45;      ;
                       LDA.W #$0000                         ;81CB47;      ;
                       STA.B !player_action                            ;81CB4A;0000D4;
                       %Set16bit(!MX)                             ;81CB4C;      ;
                       LDA.W #$0004                         ;81CB4E;      ;
                       EOR.W #$FFFF                         ;81CB51;      ;
                       AND.B !game_state                            ;81CB54;0000D2;
                       STA.B !game_state                            ;81CB56;0000D2;
                       JMP.W ResetIdleAnimatioTimer                    ;81CB58;81C002;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB5B: JMP.W CODE_81C00E                    ;81CB5B;81C00E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB5E: %Set16bit(!MX)                             ;81CB5E;      ;
                       JSR.W CODE_81CFE6                    ;81CB60;81CFE6;
                       %Set16bit(!M)                             ;81CB63;      ;
                       LDA.W $0915                          ;81CB65;000915;
                       CMP.W #$FFFF                         ;81CB68;      ;
                       BNE CODE_81CB74                      ;81CB6B;81CB74;
                       %Set16bit(!MX)                             ;81CB6D;      ;
                       LDA.W #$0000                         ;81CB6F;      ;
                       STA.B !player_action                            ;81CB72;0000D4;
                                                            ;      ;      ;
          CODE_81CB74: JMP.W CODE_81C013                    ;81CB74;81C013;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB77: JSR.W CODE_81CFE6                    ;81CB77;81CFE6;
                       %Set16bit(!M)                             ;81CB7A;      ;
                       LDA.B !player_direction                            ;81CB7C;0000DA;
                       CMP.W #$0000                         ;81CB7E;      ;
                       BNE CODE_81CB86                      ;81CB81;81CB86;
                       JMP.W CODE_81CB9E                    ;81CB83;81CB9E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB86: CMP.W #$0001                         ;81CB86;      ;
                       BNE CODE_81CB8E                      ;81CB89;81CB8E;
                       JMP.W CODE_81CC42                    ;81CB8B;81CC42;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB8E: CMP.W #$0002                         ;81CB8E;      ;
                       BNE CODE_81CB96                      ;81CB91;81CB96;
                       JMP.W CODE_81CCE6                    ;81CB93;81CCE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB96: CMP.W #$0003                         ;81CB96;      ;
                       BNE CODE_81CB9E                      ;81CB99;81CB9E;
                       JMP.W CODE_81CD8A                    ;81CB9B;81CD8A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CB9E: %Set16bit(!MX)                             ;81CB9E;      ;
                       %Set16bit(!MX)                             ;81CBA0;      ;
                       LDA.B !player_action                            ;81CBA2;0000D4;
                       CMP.W #$0003                         ;81CBA4;      ;
                       BNE CODE_81CBAC                      ;81CBA7;81CBAC;
                       JMP.W CODE_81CC30                    ;81CBA9;81CC30;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CBAC: %Set16bit(!MX)                             ;81CBAC;      ;
                       LDA.B !player_action                            ;81CBAE;0000D4;
                       CMP.W #$0017                         ;81CBB0;      ;
                       BNE CODE_81CBB8                      ;81CBB3;81CBB8;
                       JMP.W CODE_81CC30                    ;81CBB5;81CC30;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CBB8: %Set16bit(!MX)                             ;81CBB8;      ;
                       LDA.B !player_action                            ;81CBBA;0000D4;
                       CMP.W #$0018                         ;81CBBC;      ;
                       BNE CODE_81CBC4                      ;81CBBF;81CBC4;
                       JMP.W CODE_81CC30                    ;81CBC1;81CC30;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CBC4: %Set16bit(!MX)                             ;81CBC4;      ;
                       LDA.B !game_state                            ;81CBC6;0000D2;
                       AND.W #$0080                         ;81CBC8;      ;
                       BEQ CODE_81CBD0                      ;81CBCB;81CBD0;
                       JMP.W CODE_81CC30                    ;81CBCD;81CC30;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CBD0: LDA.B !player_pos_X                           ;81CBD0;0000D6;
                       STA.B $DF                            ;81CBD2;0000DF;
                       LDA.B !player_pos_Y                            ;81CBD4;0000D8;
                       STA.B $E1                            ;81CBD6;0000E1;
                       LDA.W #$0000                         ;81CBD8;      ;
                       STA.B $E5                            ;81CBDB;0000E5;
                       LDA.B $1E                            ;81CBDD;00001E;
                       STA.B $E7                            ;81CBDF;0000E7;
                       STZ.B $E3                            ;81CBE1;0000E3;
                       %Set16bit(!M)                             ;81CBE3;      ;
                       LDA.B !player_direction                            ;81CBE5;0000DA;
                       JSL.L CBBBB                          ;81CBE7;83AD91;
                       CMP.W #$0000                         ;81CBEB;      ;
                       BEQ CODE_81CBF3                      ;81CBEE;81CBF3;
                       JMP.W CODE_81CE53                    ;81CBF0;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CBF3: %Set16bit(!M)                             ;81CBF3;      ;
                       LDA.B !player_direction                            ;81CBF5;0000DA;
                       JSL.L CEEEE                          ;81CBF7;83AF37;
                       %Set16bit(!MX)                             ;81CBFB;      ;
                       STY.B $7E                            ;81CBFD;00007E;
                       CMP.W #$0001                         ;81CBFF;      ;
                       BNE CODE_81CC07                      ;81CC02;81CC07;
                       JMP.W CODE_81CE58                    ;81CC04;81CE58;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC07: CMP.W #$0002                         ;81CC07;      ;
                       BNE CODE_81CC0F                      ;81CC0A;81CC0F;
                       JMP.W CODE_81CE81                    ;81CC0C;81CE81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC0F: %Set16bit(!M)                             ;81CC0F;      ;
                       LDA.B $EB                            ;81CC11;0000EB;
                       STA.W $087A                          ;81CC13;00087A;
                       LDA.B $E9                            ;81CC16;0000E9;
                       STA.W $0878                          ;81CC18;000878;
                       SEC                                  ;81CC1B;      ;
                       SBC.W #$00C0                         ;81CC1C;      ;
                       CMP.W #$0010                         ;81CC1F;      ;
                       BCS CODE_81CC27                      ;81CC22;81CC27;
                       JMP.W CODE_81CE53                    ;81CC24;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC27: STY.B $7E                            ;81CC27;00007E;
                       LDA.B $1E                            ;81CC29;00001E;
                       SEC                                  ;81CC2B;      ;
                       SBC.B $7E                            ;81CC2C;00007E;
                       STA.B $1E                            ;81CC2E;00001E;
                                                            ;      ;      ;
          CODE_81CC30: LDA.B !player_pos_Y                            ;81CC30;0000D8;
                       CLC                                  ;81CC32;      ;
                       ADC.B $1E                            ;81CC33;00001E;
                       STA.B !player_pos_Y                            ;81CC35;0000D8;
                       JSL.L SUB_809EBC                           ;81CC37;809EBC;
                       JSL.L UpdateBGOffset                          ;81CC3B;80A0AB;
                       JMP.W CODE_81CE2B                    ;81CC3F;81CE2B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC42: %Set16bit(!MX)                             ;81CC42;      ;
                       %Set16bit(!MX)                             ;81CC44;      ;
                       LDA.B !player_action                            ;81CC46;0000D4;
                       CMP.W #$0003                         ;81CC48;      ;
                       BNE CODE_81CC50                      ;81CC4B;81CC50;
                       JMP.W CODE_81CCD4                    ;81CC4D;81CCD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC50: %Set16bit(!MX)                             ;81CC50;      ;
                       LDA.B !player_action                            ;81CC52;0000D4;
                       CMP.W #$0017                         ;81CC54;      ;
                       BNE CODE_81CC5C                      ;81CC57;81CC5C;
                       JMP.W CODE_81CCD4                    ;81CC59;81CCD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC5C: %Set16bit(!MX)                             ;81CC5C;      ;
                       LDA.B !player_action                            ;81CC5E;0000D4;
                       CMP.W #$0018                         ;81CC60;      ;
                       BNE CODE_81CC68                      ;81CC63;81CC68;
                       JMP.W CODE_81CCD4                    ;81CC65;81CCD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC68: %Set16bit(!MX)                             ;81CC68;      ;
                       LDA.B !game_state                            ;81CC6A;0000D2;
                       AND.W #$0080                         ;81CC6C;      ;
                       BEQ CODE_81CC74                      ;81CC6F;81CC74;
                       JMP.W CODE_81CCD4                    ;81CC71;81CCD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC74: LDA.B !player_pos_X                           ;81CC74;0000D6;
                       STA.B $DF                            ;81CC76;0000DF;
                       LDA.B !player_pos_Y                            ;81CC78;0000D8;
                       STA.B $E1                            ;81CC7A;0000E1;
                       LDA.W #$0000                         ;81CC7C;      ;
                       STA.B $E5                            ;81CC7F;0000E5;
                       LDA.B $1E                            ;81CC81;00001E;
                       STA.B $E7                            ;81CC83;0000E7;
                       STZ.B $E3                            ;81CC85;0000E3;
                       %Set16bit(!M)                             ;81CC87;      ;
                       LDA.B !player_direction                            ;81CC89;0000DA;
                       JSL.L CBBBB                          ;81CC8B;83AD91;
                       CMP.W #$0000                         ;81CC8F;      ;
                       BEQ CODE_81CC97                      ;81CC92;81CC97;
                       JMP.W CODE_81CE53                    ;81CC94;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CC97: %Set16bit(!M)                             ;81CC97;      ;
                       LDA.B !player_direction                            ;81CC99;0000DA;
                       JSL.L CEEEE                          ;81CC9B;83AF37;
                       %Set16bit(!MX)                             ;81CC9F;      ;
                       STY.B $7E                            ;81CCA1;00007E;
                       CMP.W #$0001                         ;81CCA3;      ;
                       BNE CODE_81CCAB                      ;81CCA6;81CCAB;
                       JMP.W CODE_81CEAA                    ;81CCA8;81CEAA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CCAB: CMP.W #$0002                         ;81CCAB;      ;
                       BNE CODE_81CCB3                      ;81CCAE;81CCB3;
                       JMP.W CODE_81CED3                    ;81CCB0;81CED3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CCB3: %Set16bit(!M)                             ;81CCB3;      ;
                       LDA.B $EB                            ;81CCB5;0000EB;
                       STA.W $087A                          ;81CCB7;00087A;
                       LDA.B $E9                            ;81CCBA;0000E9;
                       STA.W $0878                          ;81CCBC;000878;
                       SEC                                  ;81CCBF;      ;
                       SBC.W #$00C0                         ;81CCC0;      ;
                       CMP.W #$0010                         ;81CCC3;      ;
                       BCS CODE_81CCCB                      ;81CCC6;81CCCB;
                       JMP.W CODE_81CE53                    ;81CCC8;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CCCB: STY.B $7E                            ;81CCCB;00007E;
                       LDA.B $1E                            ;81CCCD;00001E;
                       SEC                                  ;81CCCF;      ;
                       SBC.B $7E                            ;81CCD0;00007E;
                       STA.B $1E                            ;81CCD2;00001E;
                                                            ;      ;      ;
          CODE_81CCD4: LDA.B !player_pos_Y                            ;81CCD4;0000D8;
                       SEC                                  ;81CCD6;      ;
                       SBC.B $1E                            ;81CCD7;00001E;
                       STA.B !player_pos_Y                            ;81CCD9;0000D8;
                       JSL.L SUB_809EBC                           ;81CCDB;809EBC;
                       JSL.L SUB_80A0E1                          ;81CCDF;80A0E1;
                       JMP.W CODE_81CE2B                    ;81CCE3;81CE2B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CCE6: %Set16bit(!MX)                             ;81CCE6;      ;
                       %Set16bit(!MX)                             ;81CCE8;      ;
                       LDA.B !player_action                            ;81CCEA;0000D4;
                       CMP.W #$0003                         ;81CCEC;      ;
                       BNE CODE_81CCF4                      ;81CCEF;81CCF4;
                       JMP.W CODE_81CD78                    ;81CCF1;81CD78;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CCF4: %Set16bit(!MX)                             ;81CCF4;      ;
                       LDA.B !player_action                            ;81CCF6;0000D4;
                       CMP.W #$0017                         ;81CCF8;      ;
                       BNE CODE_81CD00                      ;81CCFB;81CD00;
                       JMP.W CODE_81CD78                    ;81CCFD;81CD78;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD00: %Set16bit(!MX)                             ;81CD00;      ;
                       LDA.B !player_action                            ;81CD02;0000D4;
                       CMP.W #$0018                         ;81CD04;      ;
                       BNE CODE_81CD0C                      ;81CD07;81CD0C;
                       JMP.W CODE_81CD78                    ;81CD09;81CD78;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD0C: %Set16bit(!MX)                             ;81CD0C;      ;
                       LDA.B !game_state                            ;81CD0E;0000D2;
                       AND.W #$0080                         ;81CD10;      ;
                       BEQ CODE_81CD18                      ;81CD13;81CD18;
                       JMP.W CODE_81CD78                    ;81CD15;81CD78;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD18: LDA.B !player_pos_X                           ;81CD18;0000D6;
                       STA.B $DF                            ;81CD1A;0000DF;
                       LDA.B !player_pos_Y                            ;81CD1C;0000D8;
                       STA.B $E1                            ;81CD1E;0000E1;
                       LDA.B $1E                            ;81CD20;00001E;
                       STA.B $E5                            ;81CD22;0000E5;
                       LDA.W #$0000                         ;81CD24;      ;
                       STA.B $E7                            ;81CD27;0000E7;
                       STZ.B $E3                            ;81CD29;0000E3;
                       %Set16bit(!M)                             ;81CD2B;      ;
                       LDA.B !player_direction                            ;81CD2D;0000DA;
                       JSL.L CBBBB                          ;81CD2F;83AD91;
                       CMP.W #$0000                         ;81CD33;      ;
                       BEQ CODE_81CD3B                      ;81CD36;81CD3B;
                       JMP.W CODE_81CE53                    ;81CD38;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD3B: %Set16bit(!M)                             ;81CD3B;      ;
                       LDA.B !player_direction                            ;81CD3D;0000DA;
                       JSL.L CEEEE                          ;81CD3F;83AF37;
                       %Set16bit(!MX)                             ;81CD43;      ;
                       STX.B $7E                            ;81CD45;00007E;
                       CMP.W #$0001                         ;81CD47;      ;
                       BNE CODE_81CD4F                      ;81CD4A;81CD4F;
                       JMP.W CODE_81CEFC                    ;81CD4C;81CEFC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD4F: CMP.W #$0002                         ;81CD4F;      ;
                       BNE CODE_81CD57                      ;81CD52;81CD57;
                       JMP.W CODE_81CF25                    ;81CD54;81CF25;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD57: %Set16bit(!M)                             ;81CD57;      ;
                       LDA.B $EB                            ;81CD59;0000EB;
                       STA.W $087A                          ;81CD5B;00087A;
                       LDA.B $E9                            ;81CD5E;0000E9;
                       STA.W $0878                          ;81CD60;000878;
                       SEC                                  ;81CD63;      ;
                       SBC.W #$00C0                         ;81CD64;      ;
                       CMP.W #$0010                         ;81CD67;      ;
                       BCS CODE_81CD6F                      ;81CD6A;81CD6F;
                       JMP.W CODE_81CE53                    ;81CD6C;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD6F: STX.B $7E                            ;81CD6F;00007E;
                       LDA.B $1E                            ;81CD71;00001E;
                       SEC                                  ;81CD73;      ;
                       SBC.B $7E                            ;81CD74;00007E;
                       STA.B $1E                            ;81CD76;00001E;
                                                            ;      ;      ;
          CODE_81CD78: LDA.B !player_pos_X                           ;81CD78;0000D6;
                       CLC                                  ;81CD7A;      ;
                       ADC.B $1E                            ;81CD7B;00001E;
                       STA.B !player_pos_X                           ;81CD7D;0000D6;
                       JSL.L SUB_809EBC                           ;81CD7F;809EBC;
                       JSL.L UNK_StaticMapScroling         ;81CD83;80A11C;
                       JMP.W CODE_81CE2B                    ;81CD87;81CE2B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD8A: %Set16bit(!MX)                             ;81CD8A;      ;
                       %Set16bit(!MX)                             ;81CD8C;      ;
                       LDA.B !player_action                            ;81CD8E;0000D4;
                       CMP.W #$0003                         ;81CD90;      ;
                       BNE CODE_81CD98                      ;81CD93;81CD98;
                       JMP.W CODE_81CE1C                    ;81CD95;81CE1C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CD98: %Set16bit(!MX)                             ;81CD98;      ;
                       LDA.B !player_action                            ;81CD9A;0000D4;
                       CMP.W #$0017                         ;81CD9C;      ;
                       BNE CODE_81CDA4                      ;81CD9F;81CDA4;
                       JMP.W CODE_81CE1C                    ;81CDA1;81CE1C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CDA4: %Set16bit(!MX)                             ;81CDA4;      ;
                       LDA.B !player_action                            ;81CDA6;0000D4;
                       CMP.W #$0018                         ;81CDA8;      ;
                       BNE CODE_81CDB0                      ;81CDAB;81CDB0;
                       JMP.W CODE_81CE1C                    ;81CDAD;81CE1C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CDB0: %Set16bit(!MX)                             ;81CDB0;      ;
                       LDA.B !game_state                            ;81CDB2;0000D2;
                       AND.W #$0080                         ;81CDB4;      ;
                       BEQ CODE_81CDBC                      ;81CDB7;81CDBC;
                       JMP.W CODE_81CE1C                    ;81CDB9;81CE1C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CDBC: LDA.B !player_pos_X                           ;81CDBC;0000D6;
                       STA.B $DF                            ;81CDBE;0000DF;
                       LDA.B !player_pos_Y                            ;81CDC0;0000D8;
                       STA.B $E1                            ;81CDC2;0000E1;
                       LDA.B $1E                            ;81CDC4;00001E;
                       STA.B $E5                            ;81CDC6;0000E5;
                       LDA.W #$0000                         ;81CDC8;      ;
                       STA.B $E7                            ;81CDCB;0000E7;
                       STZ.B $E3                            ;81CDCD;0000E3;
                       %Set16bit(!M)                             ;81CDCF;      ;
                       LDA.B !player_direction                            ;81CDD1;0000DA;
                       JSL.L CBBBB                          ;81CDD3;83AD91;
                       CMP.W #$0000                         ;81CDD7;      ;
                       BEQ CODE_81CDDF                      ;81CDDA;81CDDF;
                       JMP.W CODE_81CE53                    ;81CDDC;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CDDF: %Set16bit(!M)                             ;81CDDF;      ;
                       LDA.B !player_direction                            ;81CDE1;0000DA;
                       JSL.L CEEEE                          ;81CDE3;83AF37;
                       %Set16bit(!MX)                             ;81CDE7;      ;
                       STX.B $7E                            ;81CDE9;00007E;
                       CMP.W #$0001                         ;81CDEB;      ;
                       BNE CODE_81CDF3                      ;81CDEE;81CDF3;
                       JMP.W CODE_81CF4E                    ;81CDF0;81CF4E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CDF3: CMP.W #$0002                         ;81CDF3;      ;
                       BNE CODE_81CDFB                      ;81CDF6;81CDFB;
                       JMP.W CODE_81CF77                    ;81CDF8;81CF77;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CDFB: %Set16bit(!M)                             ;81CDFB;      ;
                       LDA.B $EB                            ;81CDFD;0000EB;
                       STA.W $087A                          ;81CDFF;00087A;
                       LDA.B $E9                            ;81CE02;0000E9;
                       STA.W $0878                          ;81CE04;000878;
                       SEC                                  ;81CE07;      ;
                       SBC.W #$00C0                         ;81CE08;      ;
                       CMP.W #$0010                         ;81CE0B;      ;
                       BCS CODE_81CE13                      ;81CE0E;81CE13;
                       JMP.W CODE_81CE53                    ;81CE10;81CE53;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CE13: STX.B $7E                            ;81CE13;00007E;
                       LDA.B $1E                            ;81CE15;00001E;
                       SEC                                  ;81CE17;      ;
                       SBC.B $7E                            ;81CE18;00007E;
                       STA.B $1E                            ;81CE1A;00001E;
                                                            ;      ;      ;
          CODE_81CE1C: LDA.B !player_pos_X                           ;81CE1C;0000D6;
                       SEC                                  ;81CE1E;      ;
                       SBC.B $1E                            ;81CE1F;00001E;
                       STA.B !player_pos_X                           ;81CE21;0000D6;
                       JSL.L SUB_809EBC                           ;81CE23;809EBC;
                       JSL.L SUB_80A152                          ;81CE27;80A152;
                                                            ;      ;      ;
          CODE_81CE2B: %Set8bit(!M)                             ;81CE2B;      ;
                       %Set16bit(!X)                             ;81CE2D;      ;
                       LDA.W $0919                          ;81CE2F;000919;
                       INC A                                ;81CE32;      ;
                       STA.W $0919                          ;81CE33;000919;
                       LDA.W $0919                          ;81CE36;000919;
                       CMP.B #$08                           ;81CE39;      ;
                       BNE CODE_81CE52                      ;81CE3B;81CE52;
                       JSL.L CODE_81A58F                    ;81CE3D;81A58F;
                       %Set16bit(!M)                             ;81CE41;      ;
                       LDA.B !player_pos_X                           ;81CE43;0000D6;
                       STA.W $0907                          ;81CE45;000907;
                       LDA.B !player_pos_Y                            ;81CE48;0000D8;
                       STA.W $0909                          ;81CE4A;000909;
                       %Set8bit(!M)                             ;81CE4D;      ;
                       STZ.W $0919                          ;81CE4F;000919;
                                                            ;      ;      ;
          CODE_81CE52: RTS                                  ;81CE52;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CE53: %Set16bit(!M)                             ;81CE53;      ;
                       STZ.B $1E                            ;81CE55;00001E;
                       RTS                                  ;81CE57;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CE58: %Set16bit(!MX)                             ;81CE58;      ;
                       LDA.B $EB                            ;81CE5A;0000EB;
                       BEQ CODE_81CE72                      ;81CE5C;81CE72;
                       CMP.W #$00A0                         ;81CE5E;      ;
                       BCC CODE_81CE68                      ;81CE61;81CE68;
                       CMP.W #$00B0                         ;81CE63;      ;
                       BCC CODE_81CE72                      ;81CE66;81CE72;
                                                            ;      ;      ;
          CODE_81CE68: LDA.B !player_pos_X                           ;81CE68;0000D6;
                       AND.W #$0008                         ;81CE6A;      ;
                       BNE CODE_81CE72                      ;81CE6D;81CE72;
                       JMP.W CODE_81CC0F                    ;81CE6F;81CC0F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CE72: LDA.W #$0001                         ;81CE72;      ;
                       STA.B $1E                            ;81CE75;00001E;
                       %Set16bit(!MX)                             ;81CE77;      ;
                       LDA.W #$0003                         ;81CE79;      ;
                       STA.B !player_direction                            ;81CE7C;0000DA;
                       JMP.W CODE_81CD8A                    ;81CE7E;81CD8A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CE81: %Set16bit(!MX)                             ;81CE81;      ;
                       LDA.B $E9                            ;81CE83;0000E9;
                       BEQ CODE_81CE9B                      ;81CE85;81CE9B;
                       CMP.W #$00A0                         ;81CE87;      ;
                       BCC CODE_81CE91                      ;81CE8A;81CE91;
                       CMP.W #$00B0                         ;81CE8C;      ;
                       BCC CODE_81CE9B                      ;81CE8F;81CE9B;
                                                            ;      ;      ;
          CODE_81CE91: LDA.B !player_pos_X                           ;81CE91;0000D6;
                       AND.W #$0008                         ;81CE93;      ;
                       BEQ CODE_81CE9B                      ;81CE96;81CE9B;
                       JMP.W CODE_81CC0F                    ;81CE98;81CC0F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CE9B: LDA.W #$0001                         ;81CE9B;      ;
                       STA.B $1E                            ;81CE9E;00001E;
                       %Set16bit(!MX)                             ;81CEA0;      ;
                       LDA.W #$0002                         ;81CEA2;      ;
                       STA.B !player_direction                            ;81CEA5;0000DA;
                       JMP.W CODE_81CCE6                    ;81CEA7;81CCE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CEAA: %Set16bit(!MX)                             ;81CEAA;      ;
                       LDA.B $EB                            ;81CEAC;0000EB;
                       BEQ CODE_81CEC4                      ;81CEAE;81CEC4;
                       CMP.W #$00A0                         ;81CEB0;      ;
                       BCC CODE_81CEBA                      ;81CEB3;81CEBA;
                       CMP.W #$00B0                         ;81CEB5;      ;
                       BCC CODE_81CEC4                      ;81CEB8;81CEC4;
                                                            ;      ;      ;
          CODE_81CEBA: LDA.B !player_pos_X                           ;81CEBA;0000D6;
                       AND.W #$0008                         ;81CEBC;      ;
                       BNE CODE_81CEC4                      ;81CEBF;81CEC4;
                       JMP.W CODE_81CCB3                    ;81CEC1;81CCB3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CEC4: LDA.W #$0001                         ;81CEC4;      ;
                       STA.B $1E                            ;81CEC7;00001E;
                       %Set16bit(!MX)                             ;81CEC9;      ;
                       LDA.W #$0003                         ;81CECB;      ;
                       STA.B !player_direction                            ;81CECE;0000DA;
                       JMP.W CODE_81CD8A                    ;81CED0;81CD8A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CED3: %Set16bit(!MX)                             ;81CED3;      ;
                       LDA.B $E9                            ;81CED5;0000E9;
                       BEQ CODE_81CEED                      ;81CED7;81CEED;
                       CMP.W #$00A0                         ;81CED9;      ;
                       BCC CODE_81CEE3                      ;81CEDC;81CEE3;
                       CMP.W #$00B0                         ;81CEDE;      ;
                       BCC CODE_81CEED                      ;81CEE1;81CEED;
                                                            ;      ;      ;
          CODE_81CEE3: LDA.B !player_pos_X                           ;81CEE3;0000D6;
                       AND.W #$0008                         ;81CEE5;      ;
                       BEQ CODE_81CEED                      ;81CEE8;81CEED;
                       JMP.W CODE_81CCB3                    ;81CEEA;81CCB3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CEED: LDA.W #$0001                         ;81CEED;      ;
                       STA.B $1E                            ;81CEF0;00001E;
                       %Set16bit(!MX)                             ;81CEF2;      ;
                       LDA.W #$0002                         ;81CEF4;      ;
                       STA.B !player_direction                            ;81CEF7;0000DA;
                       JMP.W CODE_81CCE6                    ;81CEF9;81CCE6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CEFC: %Set16bit(!MX)                             ;81CEFC;      ;
                       LDA.B $EB                            ;81CEFE;0000EB;
                       BEQ CODE_81CF16                      ;81CF00;81CF16;
                       CMP.W #$00A0                         ;81CF02;      ;
                       BCC CODE_81CF0C                      ;81CF05;81CF0C;
                       CMP.W #$00B0                         ;81CF07;      ;
                       BCC CODE_81CF16                      ;81CF0A;81CF16;
                                                            ;      ;      ;
          CODE_81CF0C: LDA.B !player_pos_Y                            ;81CF0C;0000D8;
                       AND.W #$0008                         ;81CF0E;      ;
                       BNE CODE_81CF16                      ;81CF11;81CF16;
                       JMP.W CODE_81CD57                    ;81CF13;81CD57;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF16: LDA.W #$0001                         ;81CF16;      ;
                       STA.B $1E                            ;81CF19;00001E;
                       %Set16bit(!MX)                             ;81CF1B;      ;
                       LDA.W #$0001                         ;81CF1D;      ;
                       STA.B !player_direction                            ;81CF20;0000DA;
                       JMP.W CODE_81CC42                    ;81CF22;81CC42;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF25: %Set16bit(!MX)                             ;81CF25;      ;
                       LDA.B $E9                            ;81CF27;0000E9;
                       BEQ CODE_81CF3F                      ;81CF29;81CF3F;
                       CMP.W #$00A0                         ;81CF2B;      ;
                       BCC CODE_81CF35                      ;81CF2E;81CF35;
                       CMP.W #$00B0                         ;81CF30;      ;
                       BCC CODE_81CF3F                      ;81CF33;81CF3F;
                                                            ;      ;      ;
          CODE_81CF35: LDA.B !player_pos_Y                            ;81CF35;0000D8;
                       AND.W #$0008                         ;81CF37;      ;
                       BEQ CODE_81CF3F                      ;81CF3A;81CF3F;
                       JMP.W CODE_81CD57                    ;81CF3C;81CD57;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF3F: LDA.W #$0001                         ;81CF3F;      ;
                       STA.B $1E                            ;81CF42;00001E;
                       %Set16bit(!MX)                             ;81CF44;      ;
                       LDA.W #$0000                         ;81CF46;      ;
                       STA.B !player_direction                            ;81CF49;0000DA;
                       JMP.W CODE_81CB9E                    ;81CF4B;81CB9E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF4E: %Set16bit(!MX)                             ;81CF4E;      ;
                       LDA.B $EB                            ;81CF50;0000EB;
                       BEQ CODE_81CF68                      ;81CF52;81CF68;
                       CMP.W #$00A0                         ;81CF54;      ;
                       BCC CODE_81CF5E                      ;81CF57;81CF5E;
                       CMP.W #$00B0                         ;81CF59;      ;
                       BCC CODE_81CF68                      ;81CF5C;81CF68;
                                                            ;      ;      ;
          CODE_81CF5E: LDA.B !player_pos_Y                            ;81CF5E;0000D8;
                       AND.W #$0008                         ;81CF60;      ;
                       BNE CODE_81CF68                      ;81CF63;81CF68;
                       JMP.W CODE_81CDFB                    ;81CF65;81CDFB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF68: LDA.W #$0001                         ;81CF68;      ;
                       STA.B $1E                            ;81CF6B;00001E;
                       %Set16bit(!MX)                             ;81CF6D;      ;
                       LDA.W #$0001                         ;81CF6F;      ;
                       STA.B !player_direction                            ;81CF72;0000DA;
                       JMP.W CODE_81CC42                    ;81CF74;81CC42;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF77: %Set16bit(!MX)                             ;81CF77;      ;
                       LDA.B $E9                            ;81CF79;0000E9;
                       BEQ CODE_81CF91                      ;81CF7B;81CF91;
                       CMP.W #$00A0                         ;81CF7D;      ;
                       BCC CODE_81CF87                      ;81CF80;81CF87;
                       CMP.W #$00B0                         ;81CF82;      ;
                       BCC CODE_81CF91                      ;81CF85;81CF91;
                                                            ;      ;      ;
          CODE_81CF87: LDA.B !player_pos_Y                            ;81CF87;0000D8;
                       AND.W #$0008                         ;81CF89;      ;
                       BEQ CODE_81CF91                      ;81CF8C;81CF91;
                       JMP.W CODE_81CDFB                    ;81CF8E;81CDFB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81CF91: LDA.W #$0001                         ;81CF91;      ;
                       STA.B $1E                            ;81CF94;00001E;
                       %Set16bit(!MX)                             ;81CF96;      ;
                       LDA.W #$0000                         ;81CF98;      ;
                       STA.B !player_direction                            ;81CF9B;0000DA;
                       JMP.W CODE_81CB9E                    ;81CF9D;81CB9E;

;;;;;;;;
CODE_81CFA0: ;81CFA0
        %Set16bit(!MX)
        LDA.W $0901                          ;Related to animation
        STA.W $0903
        STA.B $7E
        ASL A
        CLC
        ADC.B $7E
        TAX
        LDA.L DATA8_81D210,X
        STA.B $A1
        INX
        INX
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.L DATA8_81D210,X
        %Set16bit(!M)
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A
        ASL A                                ;*64???
        STA.W $090F
        STA.B $9F
        LDA.W #$0000
        STA.B $A3
        LDA.B !player_pos_X
        STA.B $9B
        LDA.B !player_pos_Y
        STA.B $9D
        JSL.L CODE_858000
        %Set16bit(!M)
        LDA.B $A5
        STA.W $0905

        RTL

;;;;;;;;
          CODE_81CFE6: %Set16bit(!MX)                             ;81CFE6;      ;
                       LDA.W $0905                          ;81CFE8;000905;
                       STA.B $A5                            ;81CFEB;0000A5;
                       LDA.B !player_pos_X                           ;81CFED;0000D6;
                       STA.B $9B                            ;81CFEF;00009B;
                       LDA.B !player_pos_Y                            ;81CFF1;0000D8;
                       STA.B $9D                            ;81CFF3;00009D;
                       LDA.W $090F                          ;81CFF5;00090F;
                       STA.B $9F                            ;81CFF8;00009F;
                       JSL.L CODE_8580B9                    ;81CFFA;8580B9;
                       %Set16bit(!M)                             ;81CFFE;      ;
                       LDA.W $0901                          ;81D000;000901;
                       CMP.W $0903                          ;81D003;000903;
                       BEQ CODE_81D039                      ;81D006;81D039;
                       STA.W $0903                          ;81D008;000903;
                       STA.B $7E                            ;81D00B;00007E;
                       ASL A                                ;81D00D;      ;
                       CLC                                  ;81D00E;      ;
                       ADC.B $7E                            ;81D00F;00007E;
                       TAX                                  ;81D011;      ;
                       LDA.L DATA8_81D210,X                 ;81D012;81D210;
                       STA.B $A1                            ;81D016;0000A1;
                       INX                                  ;81D018;      ;
                       INX                                  ;81D019;      ;
                       %Set8bit(!M)                             ;81D01A;      ;
                       LDA.B #$00                           ;81D01C;      ;
                       XBA                                  ;81D01E;      ;
                       LDA.L DATA8_81D210,X                 ;81D01F;81D210;
                       %Set16bit(!M)                             ;81D023;      ;
                       ASL A                                ;81D025;      ;
                       ASL A                                ;81D026;      ;
                       ASL A                                ;81D027;      ;
                       ASL A                                ;81D028;      ;
                       ASL A                                ;81D029;      ;
                       ASL A                                ;81D02A;      ;
                       STA.W $090F                          ;81D02B;00090F;
                       STA.B $9F                            ;81D02E;00009F;
                       LDA.W $0905                          ;81D030;000905;
                       STA.B $A5                            ;81D033;0000A5;
                       JSL.L CODE_858100                    ;81D035;858100;
                                                            ;      ;      ;
          CODE_81D039: JSR.W CODE_81D03D                    ;81D039;81D03D;
                       RTS                                  ;81D03C;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D03D: %Set16bit(!MX)                             ;81D03D;      ;
                       LDA.W $0905                          ;81D03F;000905;
                       STA.B $A5                            ;81D042;0000A5;
                       JSL.L CODE_8581CB                    ;81D044;8581CB;
                       %Set16bit(!M)                             ;81D048;      ;
                       LDA.B $A7                            ;81D04A;0000A7;
                       STA.W $0915                          ;81D04C;000915;
                       CMP.W #$FFFF                         ;81D04F;      ;
                       BNE CODE_81D060                      ;81D052;81D060;
                       %Set16bit(!MX)                             ;81D054;      ;
                       LDA.W #$2000                         ;81D056;      ;
                       EOR.W #$FFFF                         ;81D059;      ;
                       AND.B !game_state                            ;81D05C;0000D2;
                       STA.B !game_state                            ;81D05E;0000D2;
                                                            ;      ;      ;
          CODE_81D060: RTS                                  ;81D060;      ;

;;;;;;; Param in A: stamina change
ChangeStamina: ;81D061
       !stamina_change = $92
       !stamina_change2 = $82
       !temp_max_stamina = $7E
       !temp_stamina = $80
       !unused = $83

       %Set8bit(!M)
       %Set16bit(!X)
       STA.B !stamina_change
       STA.B !stamina_change2
       STZ.B !unused
       BMI .negativechange
       BRA .positivechange

    .negativechange:
       %Set8bit(!M)
       LDA.B #$FF
       STA.B !unused

    .positivechange:
       %Set16bit(!M)
       LDA.L $7F1F60
       AND.W #$0008
       BEQ +                                 ;Checks flag 8, removes stamina calculation?
       JMP.W .return

     + %Set8bit(!M)
       LDA.B #$00
       XBA
       LDA.W !max_stamina
       %Set16bit(!M)
       STA.B !temp_max_stamina
       %Set8bit(!M)
       LDA.W !current_stamina
       %Set16bit(!M)
       CLC
       ADC.B !stamina_change2
       STA.B !temp_stamina
       LDA.B !temp_stamina
       BEQ .negativeorzero
       BMI .negativeorzero
       CMP.B !temp_max_stamina
       BCS .max
       %Set16bit(!MX)
       LDA.W #$0008
       EOR.W #$FFFF
       AND.B !game_state
       STA.B !game_state                             ;clears flag 8
       BRA .midstamina

    .negativeorzero:
       %Set8bit(!M)
       STZ.W !current_stamina
       %Set16bit(!MX)
       LDA.B !game_state
       ORA.W #$0008
       STA.B !game_state                             ;sets flag 8
       %Set16bit(!M)
       LDA.W #$004D
       STA.W $0901
       %Set16bit(!MX)
       LDA.W #$000B
       STA.B !player_action
       BRA .aftercalculation                       ;81D0D0;81D0F3;
                                          ;      ;      ;
                                          ;      ;      ;
    .max:
       %Set8bit(!M)
       LDA.W !max_stamina
       STA.W !current_stamina
       %Set16bit(!MX)
       LDA.W #$0008
       EOR.W #$FFFF
       AND.B !game_state
       STA.B !game_state                             ;clears flag 8
       BRA .aftercalculation

    .midstamina:
       %Set8bit(!M)
       LDA.W !current_stamina
       CLC
       ADC.B !stamina_change
       STA.W !current_stamina

    .aftercalculation:
       %Set8bit(!MX)
       LDA.B !stamina_change
       BMI .reducedstamina
       LDY.B #$00
       LDA.W !max_stamina

     - LSR A
       CMP.W !current_stamina
       BEQ +
       BCC +
       INY
       BRA -

     + TYA
       STA.W !exaustion_level
       BRA .return

    .reducedstamina:
       %Set8bit(!MX)
       LDA.W !exaustion_level
       CMP.B #$03
       BEQ .return
       LDY.B #$00
       LDA.W !max_stamina

     - LSR A
       CPY.W !exaustion_level
       BEQ +
       INY
       BRA -

     + CMP.W !current_stamina
       BCS .reducedstaminastage
       BRA .return

    .reducedstaminastage:
       LDA.B #$00
       XBA
       LDA.W !exaustion_level
       CLC
       ADC.B #$4A
       %Set16bit(!M)
       STA.W $0901
       %Set8bit(!M)
       LDA.W !exaustion_level
       INC A
       STA.W !exaustion_level
       %Set16bit(!MX)
       LDA.W #$000B
       STA.B !player_action

    .return:
       %Set16bit(!MX)
       RTL

;;;;;;;; Calculates tile in front?
;;;;;;;; Params in A, X, Y. A is ammount of tiles, X and Y are offsets
CalculateTileinFront: ;81D14E
        %Set16bit(!MX)
        ASL A
        ASL A
        ASL A
        ASL A
        STA.B $7E
        STX.B $80
        STY.B $82
        LDA.B !player_pos_X
        STA.W !tile_in_front_X
        LDA.B !player_pos_Y
        STA.W !tile_in_front_Y
        LDA.B !player_direction
        CMP.W #$0000
        BNE .notlookingdown

        LDA.B !player_pos_Y                  ;Looking down
        CLC
        ADC.B $7E
        ADC.B $82
        STA.W !tile_in_front_Y
        BRA .return

    .notlookingdown:
        CMP.W #$0001
        BNE .notlookingup

        LDA.B !player_pos_Y                  ;Looking up
        SEC
        SBC.B $7E
        SBC.B $82
        STA.W !tile_in_front_Y
        BRA .return

    .notlookingup:
        CMP.W #$0002
        BNE .notlookingleft

        LDA.B !player_pos_X                  ;Looking left
        CLC
        ADC.B $7E
        ADC.B $80
        STA.W !tile_in_front_X
        BRA .return

    .notlookingleft:
        LDA.B !player_pos_X                  ;Looking right
        SEC
        SBC.B $7E
        SBC.B $80
        STA.W !tile_in_front_X

    .return: RTL

;;;;;;;;
          CODE_81D1A4: %Set16bit(!MX)                             ;81D1A4;      ;
                       TXA                                  ;81D1A6;      ;
                       ASL A                                ;81D1A7;      ;
                       ASL A                                ;81D1A8;      ;
                       ASL A                                ;81D1A9;      ;
                       ASL A                                ;81D1AA;      ;
                       STA.B $7E                            ;81D1AB;00007E;
                       TYA                                  ;81D1AD;      ;
                       ASL A                                ;81D1AE;      ;
                       ASL A                                ;81D1AF;      ;
                       ASL A                                ;81D1B0;      ;
                       ASL A                                ;81D1B1;      ;
                       STA.B $80                            ;81D1B2;000080;
                       LDA.B !player_pos_X                           ;81D1B4;0000D6;
                       CLC                                  ;81D1B6;      ;
                       ADC.B $7E                            ;81D1B7;00007E;
                       STA.W !tile_in_front_X                          ;81D1B9;000985;
                       LDA.B !player_pos_Y                            ;81D1BC;0000D8;
                       CLC                                  ;81D1BE;      ;
                       ADC.B $80                            ;81D1BF;000080;
                       STA.W !tile_in_front_Y                          ;81D1C1;000987;
                       RTL                                  ;81D1C4;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D1C5: %Set16bit(!MX)                             ;81D1C5;      ;
                       STA.B $7E                            ;81D1C7;00007E;
                       LDY.W #$0000                         ;81D1C9;      ;
                                                            ;      ;      ;
          CODE_81D1CC: TYA                                  ;81D1CC;      ;
                       ASL A                                ;81D1CD;      ;
                       ASL A                                ;81D1CE;      ;
                       INC A                                ;81D1CF;      ;
                       INC A                                ;81D1D0;      ;
                       TAX                                  ;81D1D1;      ;
                       LDA.L DATA8_81D1E8,X                 ;81D1D2;81D1E8;
                       CMP.B $7E                            ;81D1D6;00007E;
                       BCC CODE_81D1DC                      ;81D1D8;81D1DC;
                       BRA CODE_81D1E4                      ;81D1DA;81D1E4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D1DC: %Set16bit(!MX)                             ;81D1DC;      ;
                       INY                                  ;81D1DE;      ;
                       CPY.W #$000A                         ;81D1DF;      ;
                       BNE CODE_81D1CC                      ;81D1E2;81D1CC;
                                                            ;      ;      ;
          CODE_81D1E4: %Set16bit(!MX)                             ;81D1E4;      ;
                       TYA                                  ;81D1E6;      ;
                       RTS                                  ;81D1E7;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
         DATA8_81D1E8: db $00,$00,$31,$00,$32,$00,$77,$00,$78,$00,$C7,$00,$C8,$00,$F9,$00;81D1E8;      ;
                       db $FA,$00,$2B,$01,$2C,$01,$8F,$01,$90,$01,$F3,$01,$F4,$01,$57,$02;81D1F8;      ;
                       db $58,$02,$1F,$03,$20,$03,$E7,$03   ;81D208;      ;
                                                            ;      ;      ;
         DATA8_81D210: db $05,$00,$00,$06,$00,$00,$07,$00,$01,$07,$00,$00,$00,$00,$00,$01;81D210;      ;
                       db $00,$00,$02,$00,$01,$02,$00,$00,$03,$00,$00,$04,$00,$00,$0E,$00;81D220;      ;
                       db $01,$0E,$00,$00,$15,$00,$00,$1B,$00,$00,$21,$00,$01,$21,$00,$00;81D230;      ;
                       db $08,$00,$00,$0A,$00,$00,$0C,$00,$01,$0C,$00,$00,$12,$00,$00,$13;81D240;      ;
                       db $00,$00,$14,$00,$01,$14,$00,$00,$09,$00,$00,$0B,$00,$00,$0D,$00;81D250;      ;
                       db $01,$0D,$00,$00,$0F,$00,$00,$10,$00,$00,$11,$00,$01,$11,$00,$00;81D260;      ;
                       db $16,$00,$00,$1C,$00,$00,$22,$00,$01,$22,$00,$00,$17,$00,$00,$1D;81D270;      ;
                       db $00,$00,$23,$00,$01,$23,$00,$00,$34,$00,$00,$35,$00,$00,$36,$00;81D280;      ;
                       db $01,$36,$00,$00,$37,$00,$00,$3F,$00,$00,$38,$00,$01,$38,$00,$00;81D290;      ;
                       db $27,$00,$00,$28,$00,$00,$32,$00,$00,$31,$00,$00,$2B,$00,$00,$2C;81D2A0;      ;
                       db $00,$00,$29,$00,$00,$2A,$00,$00,$2D,$00,$00,$2E,$00,$00,$2F,$00;81D2B0;      ;
                       db $00,$30,$00,$00,$87,$00,$00,$88,$00,$00,$89,$00,$00,$8A,$00,$00;81D2C0;      ;
                       db $8D,$00,$00,$8E,$00,$00,$8B,$00,$00,$8C,$00,$00,$56,$00,$00,$63;81D2D0;      ;
                       db $00,$00,$67,$00,$00,$B6,$00,$00,$71,$00,$00,$00,$00,$00,$79,$00;81D2E0;      ;
                       db $00,$7A,$00,$00,$7B,$00,$00,$7C,$00,$00,$40,$00,$00,$1A,$00,$00;81D2F0;      ;
                       db $44,$00,$00,$45,$00,$00,$46,$00,$01,$46,$00,$00,$47,$00,$00,$48;81D300;      ;
                       db $00,$00,$49,$00,$01,$49,$00,$00,$4A,$00,$00,$4B,$00,$00,$4C,$00;81D310;      ;
                       db $01,$4C,$00,$00,$4D,$00,$00,$4E,$00,$00,$4F,$00,$01,$4F,$00,$00;81D320;      ;
                       db $50,$00,$00,$51,$00,$00,$52,$00,$01,$52,$00,$00,$53,$00,$00,$54;81D330;      ;
                       db $00,$00,$55,$00,$01,$55,$00,$00,$57,$00,$00,$5A,$00,$00,$5B,$00;81D340;      ;
                       db $01,$5B,$00,$00,$58,$00,$00,$5C,$00,$00,$5D,$00,$01,$5D,$00,$00;81D350;      ;
                       db $59,$00,$00,$5E,$00,$00,$5F,$00,$01,$5F,$00,$00,$60,$00,$00,$61;81D360;      ;
                       db $00,$00,$62,$00,$01,$62,$00,$00,$64,$00,$00,$65,$00,$00,$66,$00;81D370;      ;
                       db $01,$66,$00,$00,$68,$00,$00,$69,$00,$00,$6A,$00,$01,$6A,$00,$00;81D380;      ;
                       db $6B,$00,$00,$6C,$00,$00,$6D,$00,$01,$6D,$00,$00,$6E,$00,$00,$6F;81D390;      ;
                       db $00,$00,$70,$00,$01,$70,$00,$00,$72,$00,$00,$73,$00,$00,$74,$00;81D3A0;      ;
                       db $00,$75,$00,$00,$76,$00,$00,$77,$00,$00,$78,$00,$00,$7E,$00,$00;81D3B0;      ;
                       db $9A,$00,$00,$A6,$00,$00,$A5,$00,$00,$A4,$00,$00,$A3,$00,$00,$9F;81D3C0;      ;
                       db $00,$00,$A0,$00,$00,$A1,$00,$00,$A2,$00,$00,$9B,$00,$00,$9C,$00;81D3D0;      ;
                       db $00,$9D,$00,$00,$9E,$00,$00,$AA,$00,$00,$A9,$00,$00,$A8,$00,$00;81D3E0;      ;
                       db $A7,$00,$00,$AF,$00,$00,$B0,$00,$00,$B2,$00,$00,$B1,$00,$00,$AE;81D3F0;      ;
                       db $00,$00,$B3,$00,$00,$B4,$00,$00,$AB,$00,$00,$AD,$00,$00,$AC,$00;81D400;      ;
                       db $00,$00,$00,$00,$B5,$00,$00,$20,$00,$00,$26,$00,$01,$26,$00,$00;81D410;      ;
                       db $93,$00,$00,$94,$00,$00,$97,$00,$01,$97,$00,$00,$8F,$00,$00,$90;81D420;      ;
                       db $00,$00,$95,$00,$01,$95,$00,$00,$91,$00,$00,$92,$00,$00,$96,$00;81D430;      ;
                       db $01,$96,$00,$00,$99,$00,$00,$99,$00,$00,$98,$00,$01,$98,$00,$00;81D440;      ;
                       db $82,$00,$00,$83,$00,$00,$85,$00,$01,$85,$00,$00,$7F,$00,$00,$80;81D450;      ;
                       db $00,$00,$81,$00,$01,$81,$00,$00,$00,$00,$00,$00,$00,$00,$84,$00;81D460;      ;
                       db $00,$86,$00,$00,$7D,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81D470;      ;
                       db $41,$00,$00,$42,$00,$00,$43,$00,$01,$43,$00,$00,$39,$00,$00,$3A;81D480;      ;
                       db $00,$00,$3B,$00,$01,$3B,$00,$00,$3C,$00,$00,$3D,$00,$00,$3E,$00;81D490;      ;
                       db $01,$3E,$00,$00,$18,$00,$00,$1E,$00,$00,$24,$00,$01,$24,$00,$00;81D4A0;      ;
                       db $19,$00,$00,$1F,$00,$00,$25,$00,$01,$25,$00,$00,$2C,$03,$00,$2D;81D4B0;      ;
                       db $03,$00,$2E,$03,$00,$2F,$03,$00,$BC,$00,$00,$44,$03,$00,$39,$04;81D4C0;      ;
                       db $00,$3A,$04,$00,$3B,$04,$01,$3B,$04,$00,$36,$04,$00,$37,$04,$00;81D4D0;      ;
                       db $38,$04,$01,$38,$04,$00,$3D,$04,$00,$3E,$04,$00,$3F,$04,$01,$3F;81D4E0;      ;
                       db $04,$00,$40,$04,$00,$41,$04,$00,$42,$04,$00,$43,$04,$00,$44,$04;81D4F0;      ;
                       db $00,$45,$04,$00,$46,$04,$00,$47,$04,$00,$00,$00,$00,$00,$00,$00;81D500;      ;
                                                            ;      ;      ;
         DATA8_81D510: db $00,$00,$01,$00,$02,$00,$03,$00,$04,$00,$05,$00,$06,$00,$FF,$FF;81D510;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$07,$00,$FF,$FF,$08,$00,$FF,$FF,$FF,$FF;81D520;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$67,$01,$01,$02,$FF,$FF,$FF,$FF,$FF,$FF;81D530;      ;
                       db $FF,$FF,$FF,$FF,$37,$02,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$8D,$02;81D540;      ;
                       db $FF,$FF,$FF,$FF,$FF,$FF,$AC,$02,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00;81D550;      ;
                       db $FF,$FF,$FF,$FF,$73,$02,$FF,$FF,$FF,$FF,$49,$00,$FF,$FF,$FF,$FF;81D560;      ;

;;;;;; This directs what the player is doing
PlayerInteractionSelector: ;81D570
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.B #$00
      XBA
      LDA.W $096E
      ASL A
      %Set16bit(!M)
      TAX
      JSR.W (PlayerActionPointerTable,X)
      %Set8bit(!M)
      STZ.W !idle_animation_timer
      LDA.W !time_running
      AND.B #$02
      BEQ .return
      JMP.W CODE_81C00E

   .return: JMP.W CODE_81BFD3

PlayerActionPointerTable: ;81D593
      dw Unused01                          ;1
      dw GetFenceFromStack                  ;2
      dw Unused02                          ;3
      dw CODE_81D670                       ;4
      dw Unused03                          ;5
      dw CODE_81D6E2                       ;6
      dw CODE_81D6F8                       ;7
      dw Unused04                          ;8
      dw Unused05                          ;9
      dw Unused06                          ;A
      dw Unused07                          ;B
      dw Unused08                          ;C
      dw Unused09                          ;D
      dw Unused10                          ;E
      dw Unused11                          ;F
      dw CODE_81D716                       ;10

      dw LOOSE_OP_00D7C5                   ;81D5B3;00D7C5;
      dw LOOSE_OP_00D979                   ;81D5B5;00D979;
      dw CODE_00D9CC                       ;81D5B7;00D9CC;
      dw LOOSE_OP_00DA82                   ;81D5B9;00DA82;
      dw CODE_00DB38                       ;81D5BB;00DB38;
      dw LOOSE_OP_00DBA1                   ;81D5BD;00DBA1;
      dw CODE_00DBCC                       ;81D5BF;00DBCC;
      dw LOOSE_OP_00DBCD                   ;81D5C1;00DBCD;
      dw CODE_00DBCE                       ;81D5C3;00DBCE;
      dw LOOSE_OP_00DBCF                   ;81D5C5;00DBCF;
      dw CODE_00DBD0                       ;81D5C7;00DBD0;
      dw LOOSE_OP_00DBD1                   ;81D5C9;00DBD1;
      dw CODE_00DBD2                       ;81D5CB;00DBD2;
      dw LOOSE_OP_00DBD3                   ;81D5CD;00DBD3;
      dw LOOSE_OP_00DBF0                   ;81D5CF;00DBF0;
      dw LOOSE_OP_00DC57                   ;81D5D1;00DC57;
      dw CODE_00DC58                       ;81D5D3;00DC58;
      dw LOOSE_OP_00DC59                   ;81D5D5;00DC59;
      dw CODE_00DC5A                       ;81D5D7;00DC5A;
      dw LOOSE_OP_00DC5B                   ;81D5D9;00DC5B;
      dw CODE_00DC5C                       ;81D5DB;00DC5C;
      dw LOOSE_OP_00DC5D                   ;81D5DD;00DC5D;
      dw CODE_00DC5E                       ;81D5DF;00DC5E;
      dw CODE_00DCCE                       ;81D5E1;00DCCE;
      dw LOOSE_OP_00DCF3                   ;81D5E3;00DCF3;
      dw CODE_00DD18                       ;81D5E5;00DD18;
      dw LOOSE_OP_00DD3D                   ;81D5E7;00DD3D;
      dw DATA8_00DD62                      ;81D5E9;00DD62;
      dw DATA8_00DD87                      ;81D5EB;00DD87;
      dw DATA8_00DDAC                      ;81D5ED;00DDAC;
      dw DATA8_00DE1C                      ;81D5EF;00DE1C;
      dw DATA8_00E245                      ;81D5F1;00E245;
      dw DATA8_00E26A                      ;81D5F3;00E26A;
      dw DATA8_00E28F                      ;81D5F5;00E28F;
      dw DATA8_00E2B4                      ;81D5F7;00E2B4;
      dw DATA8_00E2D9                      ;81D5F9;00E2D9;
      dw DATA8_00E349                      ;81D5FB;00E349;
      dw DATA8_00E36E                      ;81D5FD;00E36E;
      dw DATA8_00E394                      ;81D5FF;00E394;
      dw DATA8_00E404                      ;81D601;00E404;
      dw DATA8_00E429                      ;81D603;00E429;
      dw DATA8_00E44E                      ;81D605;00E44E;
      dw DATA8_00E473                      ;81D607;00E473;
      dw DATA8_00E498                      ;81D609;00E498;
      dw DATA8_00E4BD                      ;81D60B;00E4BD;
      dw DATA8_00E4E2                      ;81D60D;00E4E2;
      dw DATA8_00E507                      ;81D60F;00E507;
      dw DATA8_00E52C                      ;81D611;00E52C;
      dw DATA8_00E59C                      ;81D613;00E59C;
      dw DATA8_00E6C3                      ;81D615;00E6C3;
      dw DATA8_00E6EA                      ;81D617;00E6EA;
      dw DATA8_00E79E                      ;81D619;00E79E;
      dw DATA8_00EBD5                      ;81D61B;00EBD5;
      dw EMPTY_00EFAD                      ;81D61D;00EFAD;
      dw EMPTY_00F061                      ;81D61F;00F061;
      dw EMPTY_00F121                      ;81D621;00F121;
      dw EMPTY_00F2DA                      ;81D623;00F2DA;
      dw EMPTY_00F40E                      ;81D625;00F40E;
      dw EMPTY_00F490                      ;81D627;00F490;
      dw EMPTY_00F4AD                      ;81D629;00F4AD;
      dw EMPTY_00F4CA                      ;81D62B;00F4CA;
      dw EMPTY_00F4E6                      ;81D62D;00F4E6;
      dw EMPTY_00F502                      ;81D62F;00F502;
      dw EMPTY_00F51E                      ;81D631;00F51E;
      dw EMPTY_00F53A                      ;81D633;00F53A;
      dw EMPTY_00F5B0                      ;81D635;00F5B0;
      dw EMPTY_00F6D7                      ;81D637;00F6D7;
      dw EMPTY_00F7FF                      ;81D639;00F7FF;
      dw EMPTY_00F86A                      ;81D63B;00F86A;
      dw EMPTY_00F942                      ;81D63D;00F942;
      dw EMPTY_00FA69                      ;81D63F;00FA69;
      dw EMPTY_00FA84                      ;81D641;00FA84;

;;;;;;
Unused01: ;81D643
      RTS

;;;;;;
GetFenceFromStack: ;81D644
      %Set16bit(!M)
      LDA.W #$FFFE
      JSL.L AddWood
      %Set16bit(!M)
      CMP.W #$0001                         ;Fail check
      BEQ .noWood
      %Set8bit(!M)
      LDA.B #$57
      STA.W !item_on_hand
      %Set16bit(!MX)
      LDA.W #$0004
      STA.B !player_action

   .noWood:
      %Set16bit(!MX)
      LDA.W #$0040
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state
      RTS

;;;;;;
Unused02: ;81D66F
      RTS

;;;;;;
CODE_81D670: ;81D670
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.W $096F
      CMP.B #$01
      BEQ .skip
      %Set8bit(!M)
      LDA.B #$19
      STA.W $0114
      LDA.B #$06
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
      %Set16bit(!M)
      LDA.L $7F1F5A
      ORA.W #$0010                           ;FLAG5A
      STA.L $7F1F5A
      %Set16bit(!M)
      LDA.W #$0044
      JSL.L CODE_81A5E1
      %Set8bit(!M)
      INC.W $096F
      BRA .return

   .skip:
      %Set8bit(!M)
      INC.W $0970
      LDA.W $0970
      CMP.B #$20
      BNE .return
      %Set16bit(!MX)
      LDA.W #$0040
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state
      %Set8bit(!M)
      STZ.W $0119
      JSL.L ToolUsedSound2

   .return: RTS

;;;;;;
Unused03: ;81D6E1
      RTS

;;;;;;
CODE_81D6E2: ;81D6E2
      %Set16bit(!M)
      LDA.W #$0011
      JSL.L CODE_81A5E1
      %Set16bit(!MX)
      LDA.W #$0040
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state
      RTS

CODE_81D6F8: ;81D6F8
      %Set16bit(!M)
      LDA.W #$0012
      JSL.L CODE_81A5E1
      %Set16bit(!MX)
      LDA.W #$0040
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state
      RTS

;;;;;;
Unused04: ;81D70E
      RTS
Unused05: ;81D70F
      RTS
Unused06: ;81D710
      RTS
Unused07: ;81D711
      RTS
Unused08: ;81D712
      RTS
Unused09: ;81D713
      RTS
Unused10: ;81D714
      RTS
Unused11: ;81D715
      RTS

;;;;;;;
CODE_81D716: ;81D716
      %Set8bit(!M)
      %Set16bit(!X)
      LDA.W $096F
      CMP.B #$01
      BEQ .skip1
      CMP.B #$02
      BEQ .skip2
      %Set16bit(!MX)
      LDA.B !game_state
      ORA.W #$0100
      STA.B !game_state
      %Set16bit(!M)
      LDA.W $0196
      AND.W #$0010
      BNE +
      LDA.W #$0000
      JSL.L CODE_81A5E1

    + %Set8bit(!M)
      INC.W $096F
      JMP.W .return

   .skip1:
      %Set16bit(!M)
      LDA.W $00CF
      BNE .return
      JSL.L SUB_8281C0
      %Set8bit(!M)
      LDA.B #$00
      XBA
      LDA.W $0990
      ASL A
      ASL A
      ASL A
      STA.B $92
      LDA.L !season
      ASL A
      CLC
      ADC.B $92
      %Set16bit(!M)
      TAX
      LDA.L DATA8_81D510,X
      CMP.W #$FFFF
      BEQ +
      TAX
      %Set8bit(!M)
      LDA.B #$02
      STA.W !inputstate
      LDA.B #$00
      STA.W $0191
      JSL.L StartTextBox

    + %Set8bit(!M)
      LDA.B #$00
      XBA
      LDA.W $0990
      INC A
      %Set16bit(!M)
      JSL.L CODE_81A5E1
      %Set8bit(!M)
      INC.W $096F
      BRA .return

      .skip2: %Set8bit(!M)
      LDA.W !inputstate
      CMP.B #$02
      BEQ .return
      %Set16bit(!M)
      LDA.W #$0046
      JSL.L CODE_81A5E1
      %Set16bit(!MX)
      LDA.W #$0040
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state
      %Set16bit(!MX)
      LDA.W #$0100
      EOR.W #$FFFF
      AND.B !game_state
      STA.B !game_state

   .return: RTS



                       %Set16bit(!MX)                             ;81D7C5;      ;
                       LDA.L $7F1F6E                        ;81D7C7;7F1F6E;
                       AND.W #$0010                         ;81D7CB;      ;
                       BEQ CODE_81D7D3                      ;81D7CE;81D7D3;
                       JMP.W CODE_81D96C                    ;81D7D0;81D96C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D7D3: %Set8bit(!M)                             ;81D7D3;      ;
                       %Set16bit(!X)                             ;81D7D5;      ;
                       LDA.W $096F                          ;81D7D7;00096F;
                       CMP.B #$01                           ;81D7DA;      ;
                       BEQ CODE_81D81A                      ;81D7DC;81D81A;
                       CMP.B #$02                           ;81D7DE;      ;
                       BEQ CODE_81D859                      ;81D7E0;81D859;
                       CMP.B #$03                           ;81D7E2;      ;
                       BNE CODE_81D7E9                      ;81D7E4;81D7E9;
                       JMP.W CODE_81D87F                    ;81D7E6;81D87F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D7E9: CMP.B #$04                           ;81D7E9;      ;
                       BNE CODE_81D7F0                      ;81D7EB;81D7F0;
                       JMP.W CODE_81D954                    ;81D7ED;81D954;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D7F0: %Set16bit(!M)                             ;81D7F0;      ;
                       LDA.W $0878                          ;81D7F2;000878;
                       CMP.W $087A                          ;81D7F5;00087A;
                       BEQ CODE_81D7FD                      ;81D7F8;81D7FD;
                       JMP.W CODE_81D96C                    ;81D7FA;81D96C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D7FD: %Set8bit(!M)                             ;81D7FD;      ;
                       LDA.B #$02                           ;81D7FF;      ;
                       STA.W !inputstate                          ;81D801;00019A;
                       LDX.W #$000A                         ;81D804;      ;
                       %Set8bit(!M)                             ;81D807;      ;
                       LDA.B #$00                           ;81D809;      ;
                       STA.W $0191                          ;81D80B;000191;
                       JSL.L StartTextBox                    ;81D80E;83935F;
                       %Set8bit(!M)                             ;81D812;      ;
                       INC.W $096F                          ;81D814;00096F;
                       JMP.W CODE_81D96B                    ;81D817;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D81A: LDA.W !inputstate                          ;81D81A;00019A;
                       CMP.B #$02                           ;81D81D;      ;
                       BNE CODE_81D824                      ;81D81F;81D824;
                       JMP.W CODE_81D96B                    ;81D821;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D824: %Set8bit(!M)                             ;81D824;      ;
                       LDA.W $018F                          ;81D826;00018F;
                       BNE CODE_81D83E                      ;81D829;81D83E;
                       INC.W $096F                          ;81D82B;00096F;
                       INC.W $096F                          ;81D82E;00096F;
                       %Set8bit(!M)                             ;81D831;      ;
                       LDA.W !time_running                          ;81D833;000973;
                       ORA.B #$04                           ;81D836;      ;
                       STA.W !time_running                          ;81D838;000973;
                       JMP.W CODE_81D96B                    ;81D83B;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D83E: LDA.B #$02                           ;81D83E;      ;
                       STA.W !inputstate                          ;81D840;00019A;
                       LDX.W #$000C                         ;81D843;      ;
                       %Set8bit(!M)                             ;81D846;      ;
                       LDA.B #$00                           ;81D848;      ;
                       STA.W $0191                          ;81D84A;000191;
                       JSL.L StartTextBox                    ;81D84D;83935F;
                       %Set8bit(!M)                             ;81D851;      ;
                       INC.W $096F                          ;81D853;00096F;
                       JMP.W CODE_81D96B                    ;81D856;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D859: LDA.W !inputstate                          ;81D859;00019A;
                       CMP.B #$02                           ;81D85C;      ;
                       BNE CODE_81D863                      ;81D85E;81D863;
                       JMP.W CODE_81D96B                    ;81D860;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D863: %Set8bit(!M)                             ;81D863;      ;
                       LDA.W $018F                          ;81D865;00018F;
                       BNE CODE_81D870                      ;81D868;81D870;
                       INC.W $096F                          ;81D86A;00096F;
                       JMP.W CODE_81D96B                    ;81D86D;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D870: %Set16bit(!MX)                             ;81D870;      ;
                       LDA.W #$0040                         ;81D872;      ;
                       EOR.W #$FFFF                         ;81D875;      ;
                       AND.B !game_state                            ;81D878;0000D2;
                       STA.B !game_state                            ;81D87A;0000D2;
                       JMP.W CODE_81D96B                    ;81D87C;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D87F: %Set16bit(!MX)                             ;81D87F;      ;
                       LDA.L $7F1F66                        ;81D881;7F1F66;
                       AND.W #$0001                         ;81D885;      ;
                       BNE CODE_81D8FD                      ;81D888;81D8FD;
                       LDA.L $7F1F66                        ;81D88A;7F1F66;
                       AND.W #$0002                         ;81D88E;      ;
                       BNE CODE_81D8FD                      ;81D891;81D8FD;
                       LDA.L $7F1F66                        ;81D893;7F1F66;
                       AND.W #$0004                         ;81D897;      ;
                       BNE CODE_81D8FD                      ;81D89A;81D8FD;
                       LDA.L $7F1F66                        ;81D89C;7F1F66;
                       AND.W #$0008                         ;81D8A0;      ;
                       BNE CODE_81D8FD                      ;81D8A3;81D8FD;
                       LDA.L $7F1F66                        ;81D8A5;7F1F66;
                       AND.W #$0010                         ;81D8A9;      ;
                       BNE CODE_81D8FD                      ;81D8AC;81D8FD;
                       %Set16bit(!MX)                             ;81D8AE;      ;
                       LDA.B !game_state                            ;81D8B0;0000D2;
                       ORA.W #$0080                         ;81D8B2;      ;
                       STA.B !game_state                            ;81D8B5;0000D2;
                       %Set16bit(!MX)                             ;81D8B7;      ;
                       LDA.W #$0001                         ;81D8B9;      ;
                       STA.B !player_action                            ;81D8BC;0000D4;
                       %Set16bit(!MX)                             ;81D8BE;      ;
                       LDA.W #$0003                         ;81D8C0;      ;
                       STA.B !player_direction                            ;81D8C3;0000DA;
                       %Set16bit(!MX)                             ;81D8C5;      ;
                       LDA.W #$0003                         ;81D8C7;      ;
                       STA.W $0911                          ;81D8CA;000911;
                       %Set8bit(!M)                             ;81D8CD;      ;
                       INC.W $0970                          ;81D8CF;000970;
                       LDA.W $0970                          ;81D8D2;000970;
                       CMP.B #$16                           ;81D8D5;      ;
                       BEQ CODE_81D8DC                      ;81D8D7;81D8DC;
                       JMP.W CODE_81D96B                    ;81D8D9;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D8DC: %Set16bit(!M)                             ;81D8DC;      ;
                       %Set16bit(!MX)                             ;81D8DE;      ;
                       LDA.W #$0019                         ;81D8E0;      ;
                       STA.B !player_action                            ;81D8E3;0000D4;
                       %Set16bit(!MX)                             ;81D8E5;      ;
                       LDA.W #$004E                         ;81D8E7;      ;
                       STA.W $0901                          ;81D8EA;000901;
                       JSR.W CODE_81CFE6                    ;81D8ED;81CFE6;
                       %Set8bit(!M)                             ;81D8F0;      ;
                       LDA.W !time_running                          ;81D8F2;000973;
                       ORA.B #$02                           ;81D8F5;      ;
                       STA.W !time_running                          ;81D8F7;000973;
                       JMP.W CODE_81D96B                    ;81D8FA;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D8FD: %Set16bit(!MX)                             ;81D8FD;      ;
                       LDA.L $7F1F5E                        ;81D8FF;7F1F5E;
                       ORA.W #$0800                         ;81D903;      ;
                       STA.L $7F1F5E                        ;81D906;7F1F5E;
                       %Set16bit(!MX)                             ;81D90A;      ;
                       LDA.B !game_state                            ;81D90C;0000D2;
                       ORA.W #$0080                         ;81D90E;      ;
                       STA.B !game_state                            ;81D911;0000D2;
                       %Set16bit(!MX)                             ;81D913;      ;
                       LDA.W #$0001                         ;81D915;      ;
                       STA.B !player_action                            ;81D918;0000D4;
                       %Set16bit(!MX)                             ;81D91A;      ;
                       LDA.W #$0003                         ;81D91C;      ;
                       STA.B !player_direction                            ;81D91F;0000DA;
                       %Set16bit(!MX)                             ;81D921;      ;
                       LDA.W #$0003                         ;81D923;      ;
                       STA.W $0911                          ;81D926;000911;
                       %Set8bit(!M)                             ;81D929;      ;
                       INC.W $0970                          ;81D92B;000970;
                       LDA.W $0970                          ;81D92E;000970;
                       CMP.B #$1E                           ;81D931;      ;
                       BEQ CODE_81D938                      ;81D933;81D938;
                       JMP.W CODE_81D96B                    ;81D935;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D938: %Set8bit(!M)                             ;81D938;      ;
                       INC.W $096F                          ;81D93A;00096F;
                       %Set16bit(!M)                             ;81D93D;      ;
                       %Set16bit(!MX)                             ;81D93F;      ;
                       LDA.W #$0019                         ;81D941;      ;
                       STA.B !player_action                            ;81D944;0000D4;
                       %Set16bit(!MX)                             ;81D946;      ;
                       LDA.W #$004E                         ;81D948;      ;
                       STA.W $0901                          ;81D94B;000901;
                       JSR.W CODE_81CFE6                    ;81D94E;81CFE6;
                       JMP.W CODE_81D96B                    ;81D951;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D954: %Set16bit(!MX)                             ;81D954;      ;
                       LDA.L $7F1F5E                        ;81D956;7F1F5E;
                       AND.W #$1000                         ;81D95A;      ;
                       BEQ CODE_81D96B                      ;81D95D;81D96B;
                       %Set8bit(!M)                             ;81D95F;      ;
                       LDA.W !time_running                          ;81D961;000973;
                       ORA.B #$02                           ;81D964;      ;
                       STA.W !time_running                          ;81D966;000973;
                       BRA CODE_81D96B                      ;81D969;81D96B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D96B: RTS                                  ;81D96B;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D96C: %Set16bit(!MX)                             ;81D96C;      ;
                       LDA.W #$0040                         ;81D96E;      ;
                       EOR.W #$FFFF                         ;81D971;      ;
                       AND.B !game_state                            ;81D974;0000D2;
                       STA.B !game_state                            ;81D976;0000D2;
                       RTS                                  ;81D978;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81D979;      ;
                       %Set16bit(!X)                             ;81D97B;      ;
                       LDA.W $096F                          ;81D97D;00096F;
                       CMP.B #$01                           ;81D980;      ;
                       BEQ CODE_81D9B4                      ;81D982;81D9B4;
                       %Set16bit(!MX)                             ;81D984;      ;
                       LDA.B !game_state                            ;81D986;0000D2;
                       ORA.W #$0080                         ;81D988;      ;
                       STA.B !game_state                            ;81D98B;0000D2;
                       %Set16bit(!MX)                             ;81D98D;      ;
                       LDA.W #$000E                         ;81D98F;      ;
                       STA.B !player_action                            ;81D992;0000D4;
                       %Set16bit(!MX)                             ;81D994;      ;
                       LDA.W #$0001                         ;81D996;      ;
                       STA.B !player_direction                            ;81D999;0000DA;
                       %Set16bit(!MX)                             ;81D99B;      ;
                       LDA.W #$0001                         ;81D99D;      ;
                       STA.W $0911                          ;81D9A0;000911;
                       %Set8bit(!M)                             ;81D9A3;      ;
                       INC.W $0970                          ;81D9A5;000970;
                       LDA.W $0970                          ;81D9A8;000970;
                       CMP.B #$20                           ;81D9AB;      ;
                       BNE CODE_81D9CB                      ;81D9AD;81D9CB;
                       INC.W $096F                          ;81D9AF;00096F;
                       BRA CODE_81D9CB                      ;81D9B2;81D9CB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D9B4: %Set16bit(!M)                             ;81D9B4;      ;
                       LDA.W #$00C2                         ;81D9B6;      ;
                       STA.W $0878                          ;81D9B9;000878;
                       STA.W $087A                          ;81D9BC;00087A;
                       %Set16bit(!MX)                             ;81D9BF;      ;
                       LDA.W #$0040                         ;81D9C1;      ;
                       EOR.W #$FFFF                         ;81D9C4;      ;
                       AND.B !game_state                            ;81D9C7;0000D2;
                       STA.B !game_state                            ;81D9C9;0000D2;
                                                            ;      ;      ;
          CODE_81D9CB: RTS                                  ;81D9CB;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81D9CC;      ;
                       %Set16bit(!X)                             ;81D9CE;      ;
                       LDA.W $096F                          ;81D9D0;00096F;
                       CMP.B #$01                           ;81D9D3;      ;
                       BEQ CODE_81D9FD                      ;81D9D5;81D9FD;
                       CMP.B #$02                           ;81D9D7;      ;
                       BEQ CODE_81DA57                      ;81D9D9;81DA57;
                       %Set16bit(!MX)                             ;81D9DB;      ;
                       LDA.B !game_state                            ;81D9DD;0000D2;
                       ORA.W #$0100                         ;81D9DF;      ;
                       STA.B !game_state                            ;81D9E2;0000D2;
                       %Set16bit(!M)                             ;81D9E4;      ;
                       LDA.W $0196                          ;81D9E6;000196;
                       AND.W #$0010                         ;81D9E9;      ;
                       BNE CODE_81D9F5                      ;81D9EC;81D9F5;
                       LDA.W #$0027                         ;81D9EE;      ;
                       JSL.L CODE_81A5E1                    ;81D9F1;81A5E1;
                                                            ;      ;      ;
          CODE_81D9F5: %Set8bit(!M)                             ;81D9F5;      ;
                       INC.W $096F                          ;81D9F7;00096F;
                       JMP.W CODE_81DA81                    ;81D9FA;81DA81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81D9FD: %Set16bit(!M)                             ;81D9FD;      ;
                       LDA.W $00CF                          ;81D9FF;0000CF;
                       BEQ CODE_81DA07                      ;81DA02;81DA07;
                       JMP.W CODE_81DA81                    ;81DA04;81DA81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DA07: JSL.L SUB_8281C0                          ;81DA07;8281C0;
                       %Set8bit(!M)                             ;81DA0B;      ;
                       LDA.B #$00                           ;81DA0D;      ;
                       XBA                                  ;81DA0F;      ;
                       LDA.W $0990                          ;81DA10;000990;
                       ASL A                                ;81DA13;      ;
                       ASL A                                ;81DA14;      ;
                       ASL A                                ;81DA15;      ;
                       STA.B $92                            ;81DA16;000092;
                       LDA.L !season                        ;81DA18;7F1F19;
                       ASL A                                ;81DA1C;      ;
                       CLC                                  ;81DA1D;      ;
                       ADC.B $92                            ;81DA1E;000092;
                       %Set16bit(!M)                             ;81DA20;      ;
                       TAX                                  ;81DA22;      ;
                       LDA.L DATA8_81D510,X                 ;81DA23;81D510;
                       CMP.W #$FFFF                         ;81DA27;      ;
                       BEQ CODE_81DA3D                      ;81DA2A;81DA3D;
                       TAX                                  ;81DA2C;      ;
                       %Set8bit(!M)                             ;81DA2D;      ;
                       LDA.B #$02                           ;81DA2F;      ;
                       STA.W !inputstate                          ;81DA31;00019A;
                       LDA.B #$00                           ;81DA34;      ;
                       STA.W $0191                          ;81DA36;000191;
                       JSL.L StartTextBox                    ;81DA39;83935F;
                                                            ;      ;      ;
          CODE_81DA3D: %Set8bit(!M)                             ;81DA3D;      ;
                       LDA.B #$00                           ;81DA3F;      ;
                       XBA                                  ;81DA41;      ;
                       LDA.W $0990                          ;81DA42;000990;
                       INC A                                ;81DA45;      ;
                       %Set16bit(!M)                             ;81DA46;      ;
                       CLC                                  ;81DA48;      ;
                       ADC.W #$0027                         ;81DA49;      ;
                       JSL.L CODE_81A5E1                    ;81DA4C;81A5E1;
                       %Set8bit(!M)                             ;81DA50;      ;
                       INC.W $096F                          ;81DA52;00096F;
                       BRA CODE_81DA81                      ;81DA55;81DA81;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DA57: %Set8bit(!M)                             ;81DA57;      ;
                       LDA.W !inputstate                          ;81DA59;00019A;
                       CMP.B #$02                           ;81DA5C;      ;
                       BEQ CODE_81DA81                      ;81DA5E;81DA81;
                       %Set16bit(!M)                             ;81DA60;      ;
                       LDA.W #$0047                         ;81DA62;      ;
                       JSL.L CODE_81A5E1                    ;81DA65;81A5E1;
                       %Set16bit(!MX)                             ;81DA69;      ;
                       LDA.W #$0040                         ;81DA6B;      ;
                       EOR.W #$FFFF                         ;81DA6E;      ;
                       AND.B !game_state                            ;81DA71;0000D2;
                       STA.B !game_state                            ;81DA73;0000D2;
                       %Set16bit(!MX)                             ;81DA75;      ;
                       LDA.W #$0100                         ;81DA77;      ;
                       EOR.W #$FFFF                         ;81DA7A;      ;
                       AND.B !game_state                            ;81DA7D;0000D2;
                       STA.B !game_state                            ;81DA7F;0000D2;
                                                            ;      ;      ;
          CODE_81DA81: RTS                                  ;81DA81;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81DA82;      ;
                       %Set16bit(!X)                             ;81DA84;      ;
                       LDA.W $096F                          ;81DA86;00096F;
                       CMP.B #$01                           ;81DA89;      ;
                       BEQ CODE_81DAB3                      ;81DA8B;81DAB3;
                       CMP.B #$02                           ;81DA8D;      ;
                       BEQ CODE_81DB0D                      ;81DA8F;81DB0D;
                       %Set16bit(!MX)                             ;81DA91;      ;
                       LDA.B !game_state                            ;81DA93;0000D2;
                       ORA.W #$0100                         ;81DA95;      ;
                       STA.B !game_state                            ;81DA98;0000D2;
                       %Set16bit(!M)                             ;81DA9A;      ;
                       LDA.W $0196                          ;81DA9C;000196;
                       AND.W #$0010                         ;81DA9F;      ;
                       BNE CODE_81DAAB                      ;81DAA2;81DAAB;
                       LDA.W #$0034                         ;81DAA4;      ;
                       JSL.L CODE_81A5E1                    ;81DAA7;81A5E1;
                                                            ;      ;      ;
          CODE_81DAAB: %Set8bit(!M)                             ;81DAAB;      ;
                       INC.W $096F                          ;81DAAD;00096F;
                       JMP.W CODE_81DB37                    ;81DAB0;81DB37;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DAB3: %Set16bit(!M)                             ;81DAB3;      ;
                       LDA.W $00CF                          ;81DAB5;0000CF;
                       BEQ CODE_81DABD                      ;81DAB8;81DABD;
                       JMP.W CODE_81DB37                    ;81DABA;81DB37;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DABD: JSL.L SUB_8281C0                          ;81DABD;8281C0;
                       %Set8bit(!M)                             ;81DAC1;      ;
                       LDA.B #$00                           ;81DAC3;      ;
                       XBA                                  ;81DAC5;      ;
                       LDA.W $0990                          ;81DAC6;000990;
                       ASL A                                ;81DAC9;      ;
                       ASL A                                ;81DACA;      ;
                       ASL A                                ;81DACB;      ;
                       STA.B $92                            ;81DACC;000092;
                       LDA.L !season                        ;81DACE;7F1F19;
                       ASL A                                ;81DAD2;      ;
                       CLC                                  ;81DAD3;      ;
                       ADC.B $92                            ;81DAD4;000092;
                       %Set16bit(!M)                             ;81DAD6;      ;
                       TAX                                  ;81DAD8;      ;
                       LDA.L DATA8_81D510,X                 ;81DAD9;81D510;
                       CMP.W #$FFFF                         ;81DADD;      ;
                       BEQ CODE_81DAF3                      ;81DAE0;81DAF3;
                       TAX                                  ;81DAE2;      ;
                       %Set8bit(!M)                             ;81DAE3;      ;
                       LDA.B #$02                           ;81DAE5;      ;
                       STA.W !inputstate                          ;81DAE7;00019A;
                       LDA.B #$00                           ;81DAEA;      ;
                       STA.W $0191                          ;81DAEC;000191;
                       JSL.L StartTextBox                    ;81DAEF;83935F;
                                                            ;      ;      ;
          CODE_81DAF3: %Set8bit(!M)                             ;81DAF3;      ;
                       LDA.B #$00                           ;81DAF5;      ;
                       XBA                                  ;81DAF7;      ;
                       LDA.W $0990                          ;81DAF8;000990;
                       INC A                                ;81DAFB;      ;
                       %Set16bit(!M)                             ;81DAFC;      ;
                       CLC                                  ;81DAFE;      ;
                       ADC.W #$0034                         ;81DAFF;      ;
                       JSL.L CODE_81A5E1                    ;81DB02;81A5E1;
                       %Set8bit(!M)                             ;81DB06;      ;
                       INC.W $096F                          ;81DB08;00096F;
                       BRA CODE_81DB37                      ;81DB0B;81DB37;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DB0D: %Set8bit(!M)                             ;81DB0D;      ;
                       LDA.W !inputstate                          ;81DB0F;00019A;
                       CMP.B #$02                           ;81DB12;      ;
                       BEQ CODE_81DB37                      ;81DB14;81DB37;
                       %Set16bit(!M)                             ;81DB16;      ;
                       LDA.W #$0048                         ;81DB18;      ;
                       JSL.L CODE_81A5E1                    ;81DB1B;81A5E1;
                       %Set16bit(!MX)                             ;81DB1F;      ;
                       LDA.W #$0040                         ;81DB21;      ;
                       EOR.W #$FFFF                         ;81DB24;      ;
                       AND.B !game_state                            ;81DB27;0000D2;
                       STA.B !game_state                            ;81DB29;0000D2;
                       %Set16bit(!MX)                             ;81DB2B;      ;
                       LDA.W #$0100                         ;81DB2D;      ;
                       EOR.W #$FFFF                         ;81DB30;      ;
                       AND.B !game_state                            ;81DB33;0000D2;
                       STA.B !game_state                            ;81DB35;0000D2;
                                                            ;      ;      ;
          CODE_81DB37: RTS                                  ;81DB37;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81DB38;      ;
                       %Set16bit(!X)                             ;81DB3A;      ;
                       LDA.W $096F                          ;81DB3C;00096F;
                       CMP.B #$01                           ;81DB3F;      ;
                       BEQ CODE_81DB53                      ;81DB41;81DB53;
                       CMP.B #$02                           ;81DB43;      ;
                       BEQ CODE_81DB6F                      ;81DB45;81DB6F;
                       CMP.B #$03                           ;81DB47;      ;
                       BEQ CODE_81DB92                      ;81DB49;81DB92;
                       %Set8bit(!M)                             ;81DB4B;      ;
                       STZ.W $018A                          ;81DB4D;00018A;
                       INC.W $096F                          ;81DB50;00096F;
                                                            ;      ;      ;
          CODE_81DB53: %Set16bit(!M)                             ;81DB53;      ;
                       STZ.W !BG2_Map_Offset_Y                          ;81DB55;000142;
                       %Set8bit(!M)                             ;81DB58;      ;
                       LDA.B #$03                           ;81DB5A;      ;
                       STA.W !inputstate                          ;81DB5C;00019A;
                       LDA.W $019B                          ;81DB5F;00019B;
                       ORA.B #$20                           ;81DB62;      ;
                       STA.W $019B                          ;81DB64;00019B;
                       INC.W $096F                          ;81DB67;00096F;
                       STZ.W $018B                          ;81DB6A;00018B;
                       BRA CODE_81DBA0                      ;81DB6D;81DBA0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DB6F: %Set8bit(!M)                             ;81DB6F;      ;
                       LDA.W !inputstate                          ;81DB71;00019A;
                       CMP.B #$03                           ;81DB74;      ;
                       BEQ CODE_81DBA0                      ;81DB76;81DBA0;
                       LDA.W !inputstate                          ;81DB78;00019A;
                       CMP.B #$02                           ;81DB7B;      ;
                       BNE CODE_81DB84                      ;81DB7D;81DB84;
                       INC.W $096F                          ;81DB7F;00096F;
                       BRA CODE_81DBA0                      ;81DB82;81DBA0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DB84: %Set16bit(!MX)                             ;81DB84;      ;
                       LDA.W #$0040                         ;81DB86;      ;
                       EOR.W #$FFFF                         ;81DB89;      ;
                       AND.B !game_state                            ;81DB8C;0000D2;
                       STA.B !game_state                            ;81DB8E;0000D2;
                       BRA CODE_81DBA0                      ;81DB90;81DBA0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DB92: %Set8bit(!M)                             ;81DB92;      ;
                       LDA.W !inputstate                          ;81DB94;00019A;
                       CMP.B #$02                           ;81DB97;      ;
                       BEQ CODE_81DBA0                      ;81DB99;81DBA0;
                       LDA.B #$01                           ;81DB9B;      ;
                       STA.W $096F                          ;81DB9D;00096F;
                                                            ;      ;      ;
          CODE_81DBA0: RTS                                  ;81DBA0;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DBA1;      ;
                       LDA.W #$FFFF                         ;81DBA3;      ;
                       JSL.L AddGrass                       ;81DBA6;83B253;
                       %Set16bit(!M)                             ;81DBAA;      ;
                       CMP.W #$0001                         ;81DBAC;      ;
                       BEQ CODE_81DBBF                      ;81DBAF;81DBBF;
                       %Set8bit(!M)                             ;81DBB1;      ;
                       LDA.B #$1A                           ;81DBB3;      ;
                       STA.W !item_on_hand                          ;81DBB5;00091D;
                       %Set16bit(!MX)                             ;81DBB8;      ;
                       LDA.W #$0004                         ;81DBBA;      ;
                       STA.B !player_action                            ;81DBBD;0000D4;
                                                            ;      ;      ;
          CODE_81DBBF: %Set16bit(!MX)                             ;81DBBF;      ;
                       LDA.W #$0040                         ;81DBC1;      ;
                       EOR.W #$FFFF                         ;81DBC4;      ;
                       AND.B !game_state                            ;81DBC7;0000D2;
                       STA.B !game_state                            ;81DBC9;0000D2;
                       RTS                                  ;81DBCB;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBCC;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBCD;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBCE;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBCF;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBD0;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBD1;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DBD2;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81DBD3;      ;
                       LDA.W #$00FB                         ;81DBD5;      ;
                       LDX.W #$02E0                         ;81DBD8;      ;
                       STX.W $09AD                          ;81DBDB;0009AD;
                       LDY.W #$01A0                         ;81DBDE;      ;
                       STY.W $09AF                          ;81DBE1;0009AF;
                       JSL.L CODE_81A688                    ;81DBE4;81A688;
                       %Set16bit(!MX)                             ;81DBE8;      ;
                       LDA.W #$0000                         ;81DBEA;      ;
                       JMP.W CODE_81F556                    ;81DBED;81F556;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81DBF0;      ;
                       %Set16bit(!X)                             ;81DBF2;      ;
                       LDA.W $096F                          ;81DBF4;00096F;
                       CMP.B #$01                           ;81DBF7;      ;
                       BEQ CODE_81DC16                      ;81DBF9;81DC16;
                       %Set8bit(!M)                             ;81DBFB;      ;
                       LDA.B #$02                           ;81DBFD;      ;
                       STA.W !inputstate                          ;81DBFF;00019A;
                       LDX.W #$0371                         ;81DC02;      ;
                       LDA.B #$00                           ;81DC05;      ;
                       STA.W $0191                          ;81DC07;000191;
                       JSL.L StartTextBox                    ;81DC0A;83935F;
                       %Set8bit(!M)                             ;81DC0E;      ;
                       INC.W $096F                          ;81DC10;00096F;
                       JMP.W CODE_81DC56                    ;81DC13;81DC56;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DC16: %Set8bit(!M)                             ;81DC16;      ;
                       LDA.W !inputstate                          ;81DC18;00019A;
                       CMP.B #$02                           ;81DC1B;      ;
                       BNE CODE_81DC22                      ;81DC1D;81DC22;
                       JMP.W CODE_81DC56                    ;81DC1F;81DC56;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DC22: LDA.W $018F                          ;81DC22;00018F;
                       BEQ CODE_81DC2A                      ;81DC25;81DC2A;
                       JMP.W CODE_81DC4A                    ;81DC27;81DC4A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DC2A: %Set8bit(!M)                             ;81DC2A;      ;
                       LDA.B #$00                           ;81DC2C;      ;
                       XBA                                  ;81DC2E;      ;
                       LDA.L !season                        ;81DC2F;7F1F19;
                       %Set16bit(!M)                             ;81DC33;      ;
                       CLC                                  ;81DC35;      ;
                       ADC.W #$0372                         ;81DC36;      ;
                       TAX                                  ;81DC39;      ;
                       %Set8bit(!M)                             ;81DC3A;      ;
                       LDA.B #$02                           ;81DC3C;      ;
                       STA.W !inputstate                          ;81DC3E;00019A;
                       LDA.B #$00                           ;81DC41;      ;
                       STA.W $0191                          ;81DC43;000191;
                       JSL.L StartTextBox                    ;81DC46;83935F;
                                                            ;      ;      ;
          CODE_81DC4A: %Set16bit(!MX)                             ;81DC4A;      ;
                       LDA.W #$0040                         ;81DC4C;      ;
                       EOR.W #$FFFF                         ;81DC4F;      ;
                       AND.B !game_state                            ;81DC52;0000D2;
                       STA.B !game_state                            ;81DC54;0000D2;
                                                            ;      ;      ;
          CODE_81DC56: RTS                                  ;81DC56;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC57;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC58;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC59;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC5A;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC5B;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC5C;      ;
                                                            ;      ;      ;
                       RTS                                  ;81DC5D;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81DC5E;      ;
                       %Set16bit(!X)                             ;81DC60;      ;
                       LDA.W $096F                          ;81DC62;00096F;
                       CMP.B #$01                           ;81DC65;      ;
                       BEQ CODE_81DC84                      ;81DC67;81DC84;
                       %Set8bit(!M)                             ;81DC69;      ;
                       LDA.B #$02                           ;81DC6B;      ;
                       STA.W !inputstate                          ;81DC6D;00019A;
                       LDX.W #$0023                         ;81DC70;      ;
                       LDA.B #$00                           ;81DC73;      ;
                       STA.W $0191                          ;81DC75;000191;
                       JSL.L StartTextBox                    ;81DC78;83935F;
                       %Set8bit(!M)                             ;81DC7C;      ;
                       INC.W $096F                          ;81DC7E;00096F;
                       JMP.W CODE_81DCCD                    ;81DC81;81DCCD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DC84: %Set8bit(!M)                             ;81DC84;      ;
                       LDA.W !inputstate                          ;81DC86;00019A;
                       CMP.B #$02                           ;81DC89;      ;
                       BNE CODE_81DC90                      ;81DC8B;81DC90;
                       JMP.W CODE_81DCCD                    ;81DC8D;81DCCD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DC90: LDA.W $018F                          ;81DC90;00018F;
                       BEQ CODE_81DC98                      ;81DC93;81DC98;
                       JMP.W CODE_81DCC1                    ;81DC95;81DCC1;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DC98: %Set16bit(!M)                             ;81DC98;      ;
                       LDA.L !hearts_maria                        ;81DC9A;7F1F1F;
                       JSR.W CODE_81D1C5                    ;81DC9E;81D1C5;
                       %Set16bit(!MX)                             ;81DCA1;      ;
                       CLC                                  ;81DCA3;      ;
                       ADC.W #$03A6                         ;81DCA4;      ;
                       TAX                                  ;81DCA7;      ;
                       %Set8bit(!M)                             ;81DCA8;      ;
                       LDA.B #$02                           ;81DCAA;      ;
                       STA.W !inputstate                          ;81DCAC;00019A;
                       LDA.B #$00                           ;81DCAF;      ;
                       STA.W $0191                          ;81DCB1;000191;
                       JSL.L StartTextBox                    ;81DCB4;83935F;
                       %Set16bit(!M)                             ;81DCB8;      ;
                       LDA.W #$FFFF                         ;81DCBA;      ;
                       JSL.L AddPlayerHappiness                   ;81DCBD;83B282;
                                                            ;      ;      ;
          CODE_81DCC1: %Set16bit(!MX)                             ;81DCC1;      ;
                       LDA.W #$0040                         ;81DCC3;      ;
                       EOR.W #$FFFF                         ;81DCC6;      ;
                       AND.B !game_state                            ;81DCC9;0000D2;
                       STA.B !game_state                            ;81DCCB;0000D2;
                                                            ;      ;      ;
          CODE_81DCCD: RTS                                  ;81DCCD;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DCCE;      ;
                       LDA.W #$0070                         ;81DCD0;      ;
                       ASL A                                ;81DCD3;      ;
                       ASL A                                ;81DCD4;      ;
                       TAX                                  ;81DCD5;      ;
                       %Set8bit(!M)                             ;81DCD6;      ;
                       LDA.L DATA8_82CFB4,X                 ;81DCD8;82CFB4;
                       STA.W !item_on_hand                          ;81DCDC;00091D;
                       %Set16bit(!MX)                             ;81DCDF;      ;
                       LDA.W #$0004                         ;81DCE1;      ;
                       STA.B !player_action                            ;81DCE4;0000D4;
                       %Set16bit(!MX)                             ;81DCE6;      ;
                       LDA.W #$0040                         ;81DCE8;      ;
                       EOR.W #$FFFF                         ;81DCEB;      ;
                       AND.B !game_state                            ;81DCEE;0000D2;
                       STA.B !game_state                            ;81DCF0;0000D2;
                       RTS                                  ;81DCF2;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DCF3;      ;
                       LDA.W #$0071                         ;81DCF5;      ;
                       ASL A                                ;81DCF8;      ;
                       ASL A                                ;81DCF9;      ;
                       TAX                                  ;81DCFA;      ;
                       %Set8bit(!M)                             ;81DCFB;      ;
                       LDA.L DATA8_82CFB4,X                 ;81DCFD;82CFB4;
                       STA.W !item_on_hand                          ;81DD01;00091D;
                       %Set16bit(!MX)                             ;81DD04;      ;
                       LDA.W #$0004                         ;81DD06;      ;
                       STA.B !player_action                            ;81DD09;0000D4;
                       %Set16bit(!MX)                             ;81DD0B;      ;
                       LDA.W #$0040                         ;81DD0D;      ;
                       EOR.W #$FFFF                         ;81DD10;      ;
                       AND.B !game_state                            ;81DD13;0000D2;
                       STA.B !game_state                            ;81DD15;0000D2;
                       RTS                                  ;81DD17;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DD18;      ;
                       LDA.W #$0072                         ;81DD1A;      ;
                       ASL A                                ;81DD1D;      ;
                       ASL A                                ;81DD1E;      ;
                       TAX                                  ;81DD1F;      ;
                       %Set8bit(!M)                             ;81DD20;      ;
                       LDA.L DATA8_82CFB4,X                 ;81DD22;82CFB4;
                       STA.W !item_on_hand                          ;81DD26;00091D;
                       %Set16bit(!MX)                             ;81DD29;      ;
                       LDA.W #$0004                         ;81DD2B;      ;
                       STA.B !player_action                            ;81DD2E;0000D4;
                       %Set16bit(!MX)                             ;81DD30;      ;
                       LDA.W #$0040                         ;81DD32;      ;
                       EOR.W #$FFFF                         ;81DD35;      ;
                       AND.B !game_state                            ;81DD38;0000D2;
                       STA.B !game_state                            ;81DD3A;0000D2;
                       RTS                                  ;81DD3C;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DD3D;      ;
                       LDA.W #$0073                         ;81DD3F;      ;
                       ASL A                                ;81DD42;      ;
                       ASL A                                ;81DD43;      ;
                       TAX                                  ;81DD44;      ;
                       %Set8bit(!M)                             ;81DD45;      ;
                       LDA.L DATA8_82CFB4,X                 ;81DD47;82CFB4;
                       STA.W !item_on_hand                          ;81DD4B;00091D;
                       %Set16bit(!MX)                             ;81DD4E;      ;
                       LDA.W #$0004                         ;81DD50;      ;
                       STA.B !player_action                            ;81DD53;0000D4;
                       %Set16bit(!MX)                             ;81DD55;      ;
                       LDA.W #$0040                         ;81DD57;      ;
                       EOR.W #$FFFF                         ;81DD5A;      ;
                       AND.B !game_state                            ;81DD5D;0000D2;
                       STA.B !game_state                            ;81DD5F;0000D2;
                       RTS                                  ;81DD61;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DD62;      ;
                       LDA.W #$0074                         ;81DD64;      ;
                       ASL A                                ;81DD67;      ;
                       ASL A                                ;81DD68;      ;
                       TAX                                  ;81DD69;      ;
                       %Set8bit(!M)                             ;81DD6A;      ;
                       LDA.L DATA8_82CFB4,X                 ;81DD6C;82CFB4;
                       STA.W !item_on_hand                          ;81DD70;00091D;
                       %Set16bit(!MX)                             ;81DD73;      ;
                       LDA.W #$0004                         ;81DD75;      ;
                       STA.B !player_action                            ;81DD78;0000D4;
                       %Set16bit(!MX)                             ;81DD7A;      ;
                       LDA.W #$0040                         ;81DD7C;      ;
                       EOR.W #$FFFF                         ;81DD7F;      ;
                       AND.B !game_state                            ;81DD82;0000D2;
                       STA.B !game_state                            ;81DD84;0000D2;
                       RTS                                  ;81DD86;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81DD87;      ;
                       LDA.W #$0075                         ;81DD89;      ;
                       ASL A                                ;81DD8C;      ;
                       ASL A                                ;81DD8D;      ;
                       TAX                                  ;81DD8E;      ;
                       %Set8bit(!M)                             ;81DD8F;      ;
                       LDA.L DATA8_82CFB4,X                 ;81DD91;82CFB4;
                       STA.W !item_on_hand                          ;81DD95;00091D;
                       %Set16bit(!MX)                             ;81DD98;      ;
                       LDA.W #$0004                         ;81DD9A;      ;
                       STA.B !player_action                            ;81DD9D;0000D4;
                       %Set16bit(!MX)                             ;81DD9F;      ;
                       LDA.W #$0040                         ;81DDA1;      ;
                       EOR.W #$FFFF                         ;81DDA4;      ;
                       AND.B !game_state                            ;81DDA7;0000D2;
                       STA.B !game_state                            ;81DDA9;0000D2;
                       RTS                                  ;81DDAB;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81DDAC;      ;
                       %Set16bit(!X)                             ;81DDAE;      ;
                       LDA.W $096F                          ;81DDB0;00096F;
                       CMP.B #$01                           ;81DDB3;      ;
                       BEQ CODE_81DDD2                      ;81DDB5;81DDD2;
                       %Set8bit(!M)                             ;81DDB7;      ;
                       LDA.B #$02                           ;81DDB9;      ;
                       STA.W !inputstate                          ;81DDBB;00019A;
                       LDX.W #$0023                         ;81DDBE;      ;
                       LDA.B #$00                           ;81DDC1;      ;
                       STA.W $0191                          ;81DDC3;000191;
                       JSL.L StartTextBox                    ;81DDC6;83935F;
                       %Set8bit(!M)                             ;81DDCA;      ;
                       INC.W $096F                          ;81DDCC;00096F;
                       JMP.W CODE_81DE1B                    ;81DDCF;81DE1B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DDD2: %Set8bit(!M)                             ;81DDD2;      ;
                       LDA.W !inputstate                          ;81DDD4;00019A;
                       CMP.B #$02                           ;81DDD7;      ;
                       BNE CODE_81DDDE                      ;81DDD9;81DDDE;
                       JMP.W CODE_81DE1B                    ;81DDDB;81DE1B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DDDE: LDA.W $018F                          ;81DDDE;00018F;
                       BEQ CODE_81DDE6                      ;81DDE1;81DDE6;
                       JMP.W CODE_81DE0F                    ;81DDE3;81DE0F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DDE6: %Set16bit(!M)                             ;81DDE6;      ;
                       LDA.L !hearts_nina                        ;81DDE8;7F1F23;
                       JSR.W CODE_81D1C5                    ;81DDEC;81D1C5;
                       %Set16bit(!MX)                             ;81DDEF;      ;
                       CLC                                  ;81DDF1;      ;
                       ADC.W #$03A6                         ;81DDF2;      ;
                       TAX                                  ;81DDF5;      ;
                       %Set8bit(!M)                             ;81DDF6;      ;
                       LDA.B #$02                           ;81DDF8;      ;
                       STA.W !inputstate                          ;81DDFA;00019A;
                       LDA.B #$00                           ;81DDFD;      ;
                       STA.W $0191                          ;81DDFF;000191;
                       JSL.L StartTextBox                    ;81DE02;83935F;
                       %Set16bit(!M)                             ;81DE06;      ;
                       LDA.W #$FFFF                         ;81DE08;      ;
                       JSL.L AddPlayerHappiness                   ;81DE0B;83B282;
                                                            ;      ;      ;
          CODE_81DE0F: %Set16bit(!MX)                             ;81DE0F;      ;
                       LDA.W #$0040                         ;81DE11;      ;
                       EOR.W #$FFFF                         ;81DE14;      ;
                       AND.B !game_state                            ;81DE17;0000D2;
                       STA.B !game_state                            ;81DE19;0000D2;
                                                            ;      ;      ;
          CODE_81DE1B: RTS                                  ;81DE1B;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81DE1C;      ;
                       %Set16bit(!X)                             ;81DE1E;      ;
                       LDA.W $096F                          ;81DE20;00096F;
                       CMP.B #$01                           ;81DE23;      ;
                       BEQ CODE_81DE8A                      ;81DE25;81DE8A;
                       CMP.B #$02                           ;81DE27;      ;
                       BNE CODE_81DE2E                      ;81DE29;81DE2E;
                       JMP.W CODE_81DFC8                    ;81DE2B;81DFC8;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DE2E: CMP.B #$03                           ;81DE2E;      ;
                       BNE CODE_81DE35                      ;81DE30;81DE35;
                       JMP.W CODE_81E0EF                    ;81DE32;81E0EF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DE35: %Set16bit(!MX)                             ;81DE35;      ;
                       LDA.L $7F1F68                        ;81DE37;7F1F68;
                       AND.W #$0001                         ;81DE3B;      ;
                       BNE CODE_81DE43                      ;81DE3E;81DE43;
                       JMP.W CODE_81E213                    ;81DE40;81E213;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DE43: %Set16bit(!M)                             ;81DE43;      ;
                       LDA.W $0196                          ;81DE45;000196;
                       AND.W #$000A                         ;81DE48;      ;
                       BNE CODE_81DE68                      ;81DE4B;81DE68;
                       %Set8bit(!M)                             ;81DE4D;      ;
                       LDA.B #$02                           ;81DE4F;      ;
                       STA.W !inputstate                          ;81DE51;00019A;
                       LDX.W #$0305                         ;81DE54;      ;
                       LDA.B #$00                           ;81DE57;      ;
                       STA.W $0191                          ;81DE59;000191;
                       JSL.L StartTextBox                    ;81DE5C;83935F;
                       %Set8bit(!M)                             ;81DE60;      ;
                       INC.W $096F                          ;81DE62;00096F;
                       JMP.W CODE_81E221                    ;81DE65;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DE68: %Set8bit(!M)                             ;81DE68;      ;
                       LDA.B #$02                           ;81DE6A;      ;
                       STA.W !inputstate                          ;81DE6C;00019A;
                       LDX.W #$03D0                         ;81DE6F;      ;
                       LDA.B #$00                           ;81DE72;      ;
                       STA.W $0191                          ;81DE74;000191;
                       JSL.L StartTextBox                    ;81DE77;83935F;
                       %Set16bit(!MX)                             ;81DE7B;      ;
                       LDA.W #$0040                         ;81DE7D;      ;
                       EOR.W #$FFFF                         ;81DE80;      ;
                       AND.B !game_state                            ;81DE83;0000D2;
                       STA.B !game_state                            ;81DE85;0000D2;
                       JMP.W CODE_81E221                    ;81DE87;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DE8A: %Set16bit(!MX)                             ;81DE8A;      ;
                       LDA.W !Joy1_Current                          ;81DE8C;000124;
                       BIT.W #$8000                         ;81DE8F;      ;
                       BEQ CODE_81DE97                      ;81DE92;81DE97;
                       JMP.W CODE_81E222                    ;81DE94;81E222;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DE97: %Set8bit(!M)                             ;81DE97;      ;
                       LDA.W !inputstate                          ;81DE99;00019A;
                       CMP.B #$02                           ;81DE9C;      ;
                       BNE CODE_81DEA3                      ;81DE9E;81DEA3;
                       JMP.W CODE_81E221                    ;81DEA0;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DEA3: LDA.W $018F                          ;81DEA3;00018F;
                       CMP.B #$00                           ;81DEA6;      ;
                       BEQ CODE_81DEBC                      ;81DEA8;81DEBC;
                       CMP.B #$01                           ;81DEAA;      ;
                       BEQ CODE_81DF13                      ;81DEAC;81DF13;
                       CMP.B #$02                           ;81DEAE;      ;
                       BNE CODE_81DEB5                      ;81DEB0;81DEB5;
                       JMP.W CODE_81DF6A                    ;81DEB2;81DF6A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DEB5: CMP.B #$03                           ;81DEB5;      ;
                       BNE CODE_81DEBC                      ;81DEB7;81DEBC;
                       JMP.W CODE_81DF99                    ;81DEB9;81DF99;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DEBC: %Set16bit(!M)                             ;81DEBC;      ;
                       LDA.L $7F1F5A                        ;81DEBE;7F1F5A;
                       AND.W #$0020                         ;FLAG5A
                       BNE CODE_81DEF1                      ;81DEC5;81DEF1;
                       %Set8bit(!M)                             ;81DEC7;      ;
                       LDA.L !cow_N                        ;81DEC9;7F1F0A;
                       CMP.B #$0C                           ;81DECD;      ;
                       BNE CODE_81DED4                      ;81DECF;81DED4;
                       JMP.W CODE_81E02E                    ;81DED1;81E02E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DED4: %Set8bit(!M)                             ;81DED4;      ;
                       LDA.B #$02                           ;81DED6;      ;
                       STA.W !inputstate                          ;81DED8;00019A;
                       LDX.W #$0307                         ;81DEDB;      ;
                       LDA.B #$00                           ;81DEDE;      ;
                       STA.W $0191                          ;81DEE0;000191;
                       JSL.L StartTextBox                    ;81DEE3;83935F;
                       %Set8bit(!M)                             ;81DEE7;      ;
                       LDA.B #$02                           ;81DEE9;      ;
                       STA.W $096F                          ;81DEEB;00096F;
                       JMP.W CODE_81E221                    ;81DEEE;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DEF1: %Set8bit(!M)                             ;81DEF1;      ;
                       LDA.B #$02                           ;81DEF3;      ;
                       STA.W !inputstate                          ;81DEF5;00019A;
                       LDX.W #$03B6                         ;81DEF8;      ;
                       LDA.B #$00                           ;81DEFB;      ;
                       STA.W $0191                          ;81DEFD;000191;
                       JSL.L StartTextBox                    ;81DF00;83935F;
                       %Set16bit(!MX)                             ;81DF04;      ;
                       LDA.W #$0040                         ;81DF06;      ;
                       EOR.W #$FFFF                         ;81DF09;      ;
                       AND.B !game_state                            ;81DF0C;0000D2;
                       STA.B !game_state                            ;81DF0E;0000D2;
                       JMP.W CODE_81E221                    ;81DF10;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DF13: %Set16bit(!M)                             ;81DF13;      ;
                       LDA.L $7F1F5A                        ;81DF15;7F1F5A;
                       AND.W #$0020                         ;FLAG5A
                       BNE CODE_81DF48                      ;81DF1C;81DF48;
                       %Set8bit(!M)                             ;81DF1E;      ;
                       LDA.L !chicks_N                        ;81DF20;7F1F0B;
                       CMP.B #$0C                           ;81DF24;      ;
                       BNE CODE_81DF2B                      ;81DF26;81DF2B;
                       JMP.W CODE_81E15A                    ;81DF28;81E15A;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DF2B: %Set8bit(!M)                             ;81DF2B;      ;
                       LDA.B #$02                           ;81DF2D;      ;
                       STA.W !inputstate                          ;81DF2F;00019A;
                       LDX.W #$030A                         ;81DF32;      ;
                       LDA.B #$00                           ;81DF35;      ;
                       STA.W $0191                          ;81DF37;000191;
                       JSL.L StartTextBox                    ;81DF3A;83935F;
                       %Set8bit(!M)                             ;81DF3E;      ;
                       LDA.B #$03                           ;81DF40;      ;
                       STA.W $096F                          ;81DF42;00096F;
                       JMP.W CODE_81E221                    ;81DF45;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DF48: %Set8bit(!M)                             ;81DF48;      ;
                       LDA.B #$02                           ;81DF4A;      ;
                       STA.W !inputstate                          ;81DF4C;00019A;
                       LDX.W #$03B6                         ;81DF4F;      ;
                       LDA.B #$00                           ;81DF52;      ;
                       STA.W $0191                          ;81DF54;000191;
                       JSL.L StartTextBox                    ;81DF57;83935F;
                       %Set16bit(!MX)                             ;81DF5B;      ;
                       LDA.W #$0040                         ;81DF5D;      ;
                       EOR.W #$FFFF                         ;81DF60;      ;
                       AND.B !game_state                            ;81DF63;0000D2;
                       STA.B !game_state                            ;81DF65;0000D2;
                       JMP.W CODE_81E221                    ;81DF67;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DF6A: %Set8bit(!M)                             ;81DF6A;      ;
                       LDA.B #$02                           ;81DF6C;      ;
                       STA.W !inputstate                          ;81DF6E;00019A;
                       LDX.W #$030B                         ;81DF71;      ;
                       LDA.B #$00                           ;81DF74;      ;
                       STA.W $0191                          ;81DF76;000191;
                       JSL.L StartTextBox                    ;81DF79;83935F;
                       %Set16bit(!MX)                             ;81DF7D;      ;
                       LDA.W #$0040                         ;81DF7F;      ;
                       EOR.W #$FFFF                         ;81DF82;      ;
                       AND.B !game_state                            ;81DF85;0000D2;
                       STA.B !game_state                            ;81DF87;0000D2;
                       %Set16bit(!M)                             ;81DF89;      ;
                       LDA.L $7F1F5A                        ;81DF8B;7F1F5A;
                       ORA.W #$0008                         ;FLAG5A
                       STA.L $7F1F5A                        ;81DF92;7F1F5A;
                       JMP.W CODE_81E221                    ;81DF96;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DF99: %Set8bit(!M)                             ;81DF99;      ;
                       LDA.B #$02                           ;81DF9B;      ;
                       STA.W !inputstate                          ;81DF9D;00019A;
                       LDX.W #$030B                         ;81DFA0;      ;
                       LDA.B #$00                           ;81DFA3;      ;
                       STA.W $0191                          ;81DFA5;000191;
                       JSL.L StartTextBox                    ;81DFA8;83935F;
                       %Set16bit(!MX)                             ;81DFAC;      ;
                       LDA.W #$0040                         ;81DFAE;      ;
                       EOR.W #$FFFF                         ;81DFB1;      ;
                       AND.B !game_state                            ;81DFB4;0000D2;
                       STA.B !game_state                            ;81DFB6;0000D2;
                       %Set16bit(!M)                             ;81DFB8;      ;
                       LDA.L $7F1F5A                        ;81DFBA;7F1F5A;
                       ORA.W #$0004                         ;FLAG5A
                       STA.L $7F1F5A                        ;81DFC1;7F1F5A;
                       JMP.W CODE_81E221                    ;81DFC5;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DFC8: %Set8bit(!M)                             ;81DFC8;      ;
                       LDA.W !inputstate                          ;81DFCA;00019A;
                       CMP.B #$02                           ;81DFCD;      ;
                       BNE CODE_81DFD4                      ;81DFCF;81DFD4;
                       JMP.W CODE_81E221                    ;81DFD1;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DFD4: LDA.W $018F                          ;81DFD4;00018F;
                       BEQ CODE_81DFDC                      ;81DFD7;81DFDC;
                       JMP.W CODE_81E0CD                    ;81DFD9;81E0CD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81DFDC: %Set8bit(!M)                             ;81DFDC;      ;
                       LDA.B #$00                           ;81DFDE;      ;
                       XBA                                  ;81DFE0;      ;
                       LDA.L !chicks_N                        ;81DFE1;7F1F0B;
                       %Set16bit(!M)                             ;81DFE5;      ;
                       ASL A                                ;81DFE7;      ;
                       ASL A                                ;81DFE8;      ;
                       ASL A                                ;81DFE9;      ;
                       ASL A                                ;81DFEA;      ;
                       STA.B $7E                            ;81DFEB;00007E;
                       %Set8bit(!M)                             ;81DFED;      ;
                       LDA.B #$00                           ;81DFEF;      ;
                       XBA                                  ;81DFF1;      ;
                       LDA.L !cow_N                        ;81DFF2;7F1F0A;
                       %Set16bit(!M)                             ;81DFF6;      ;
                       INC A                                ;81DFF8;      ;
                       ASL A                                ;81DFF9;      ;
                       ASL A                                ;81DFFA;      ;
                       ASL A                                ;81DFFB;      ;
                       ASL A                                ;81DFFC;      ;
                       STA.B $80                            ;81DFFD;000080;
                       CLC                                  ;81DFFF;      ;
                       ADC.B $7E                            ;81E000;00007E;
                       STA.B $7E                            ;81E002;00007E;
                       LDA.L !planted_grass                        ;81E004;7F1F29;
                       CMP.B $7E                            ;81E008;00007E;
                       BCS CODE_81E050                      ;81E00A;81E050;
                       %Set8bit(!M)                             ;81E00C;      ;
                       LDA.B #$02                           ;81E00E;      ;
                       STA.W !inputstate                          ;81E010;00019A;
                       LDX.W #$0306                         ;81E013;      ;
                       LDA.B #$00                           ;81E016;      ;
                       STA.W $0191                          ;81E018;000191;
                       JSL.L StartTextBox                    ;81E01B;83935F;
                       %Set16bit(!MX)                             ;81E01F;      ;
                       LDA.W #$0040                         ;81E021;      ;
                       EOR.W #$FFFF                         ;81E024;      ;
                       AND.B !game_state                            ;81E027;0000D2;
                       STA.B !game_state                            ;81E029;0000D2;
                       JMP.W CODE_81E221                    ;81E02B;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E02E: %Set8bit(!M)                             ;81E02E;      ;
                       LDA.B #$02                           ;81E030;      ;
                       STA.W !inputstate                          ;81E032;00019A;
                       LDX.W #$03B7                         ;81E035;      ;
                       LDA.B #$00                           ;81E038;      ;
                       STA.W $0191                          ;81E03A;000191;
                       JSL.L StartTextBox                    ;81E03D;83935F;
                       %Set16bit(!MX)                             ;81E041;      ;
                       LDA.W #$0040                         ;81E043;      ;
                       EOR.W #$FFFF                         ;81E046;      ;
                       AND.B !game_state                            ;81E049;0000D2;
                       STA.B !game_state                            ;81E04B;0000D2;
                       JMP.W CODE_81E221                    ;81E04D;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E050: %Set16bit(!M)                             ;81E050;      ;
                       LDA.W #$FE0C                         ;81E052;      ;
                       STA.B $72                            ;81E055;000072;
                       %Set8bit(!M)                             ;81E057;      ;
                       LDA.B #$FF                           ;81E059;      ;
                       STA.B $74                            ;81E05B;000074;
                       JSL.L AddMoney                       ;81E05D;83B1C9;
                       %Set16bit(!M)                             ;81E061;      ;
                       CMP.W #$0000                         ;81E063;      ;
                       BEQ CODE_81E08A                      ;81E066;81E08A;
                       %Set8bit(!M)                             ;81E068;      ;
                       LDA.B #$02                           ;81E06A;      ;
                       STA.W !inputstate                          ;81E06C;00019A;
                       LDX.W #$0304                         ;81E06F;      ;
                       LDA.B #$00                           ;81E072;      ;
                       STA.W $0191                          ;81E074;000191;
                       JSL.L StartTextBox                    ;81E077;83935F;
                       %Set16bit(!MX)                             ;81E07B;      ;
                       LDA.W #$0040                         ;81E07D;      ;
                       EOR.W #$FFFF                         ;81E080;      ;
                       AND.B !game_state                            ;81E083;0000D2;
                       STA.B !game_state                            ;81E085;0000D2;
                       JMP.W CODE_81E221                    ;81E087;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E08A: %Set8bit(!M)                             ;81E08A;      ;
                       LDA.B #$02                           ;81E08C;      ;
                       STA.W !inputstate                          ;81E08E;00019A;
                       LDX.W #$0308                         ;81E091;      ;
                       LDA.B #$00                           ;81E094;      ;
                       STA.W $0191                          ;81E096;000191;
                       JSL.L StartTextBox                    ;81E099;83935F;
                       %Set16bit(!MX)                             ;81E09D;      ;
                       LDA.W #$0040                         ;81E09F;      ;
                       EOR.W #$FFFF                         ;81E0A2;      ;
                       AND.B !game_state                            ;81E0A5;0000D2;
                       STA.B !game_state                            ;81E0A7;0000D2;
                       %Set16bit(!M)                             ;81E0A9;      ;
                       LDA.L $7F1F5A                        ;81E0AB;7F1F5A;
                       ORA.W #$0022                         ;FLAG5A
                       STA.L $7F1F5A                        ;81E0B2;7F1F5A;
                       %Set8bit(!M)                             ;81E0B6;      ;
                       LDA.L !cow_N                        ;81E0B8;7F1F0A;
                       INC A                                ;81E0BC;      ;
                       STA.L !cow_N                        ;81E0BD;7F1F0A;
                       %Set16bit(!M)                             ;81E0C1;      ;
                       LDA.W #$0014                         ;81E0C3;      ;
                       JSL.L AddPlayerHappiness                   ;81E0C6;83B282;
                       JMP.W CODE_81E221                    ;81E0CA;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E0CD: %Set8bit(!M)                             ;81E0CD;      ;
                       LDA.B #$02                           ;81E0CF;      ;
                       STA.W !inputstate                          ;81E0D1;00019A;
                       LDX.W #$0303                         ;81E0D4;      ;
                       LDA.B #$00                           ;81E0D7;      ;
                       STA.W $0191                          ;81E0D9;000191;
                       JSL.L StartTextBox                    ;81E0DC;83935F;
                       %Set16bit(!MX)                             ;81E0E0;      ;
                       LDA.W #$0040                         ;81E0E2;      ;
                       EOR.W #$FFFF                         ;81E0E5;      ;
                       AND.B !game_state                            ;81E0E8;0000D2;
                       STA.B !game_state                            ;81E0EA;0000D2;
                       JMP.W CODE_81E221                    ;81E0EC;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E0EF: %Set8bit(!M)                             ;81E0EF;      ;
                       LDA.W !inputstate                          ;81E0F1;00019A;
                       CMP.B #$02                           ;81E0F4;      ;
                       BNE CODE_81E0FB                      ;81E0F6;81E0FB;
                       JMP.W CODE_81E221                    ;81E0F8;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E0FB: LDA.W $018F                          ;81E0FB;00018F;
                       BEQ CODE_81E103                      ;81E0FE;81E103;
                       JMP.W CODE_81E200                    ;81E100;81E200;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E103: %Set8bit(!M)                             ;81E103;      ;
                       LDA.B #$00                           ;81E105;      ;
                       XBA                                  ;81E107;      ;
                       LDA.L !chicks_N                        ;81E108;7F1F0B;
                       %Set16bit(!M)                             ;81E10C;      ;
                       INC A                                ;81E10E;      ;
                       ASL A                                ;81E10F;      ;
                       ASL A                                ;81E110;      ;
                       ASL A                                ;81E111;      ;
                       ASL A                                ;81E112;      ;
                       STA.B $7E                            ;81E113;00007E;
                       %Set8bit(!M)                             ;81E115;      ;
                       LDA.B #$00                           ;81E117;      ;
                       XBA                                  ;81E119;      ;
                       LDA.L !cow_N                        ;81E11A;7F1F0A;
                       %Set16bit(!M)                             ;81E11E;      ;
                       ASL A                                ;81E120;      ;
                       ASL A                                ;81E121;      ;
                       ASL A                                ;81E122;      ;
                       ASL A                                ;81E123;      ;
                       STA.B $80                            ;81E124;000080;
                       CLC                                  ;81E126;      ;
                       ADC.B $7E                            ;81E127;00007E;
                       STA.B $7E                            ;81E129;00007E;
                       LDA.L !planted_grass                        ;81E12B;7F1F29;
                       CMP.B $7E                            ;81E12F;00007E;
                       BCC CODE_81E136                      ;81E131;81E136;
                       JMP.W CODE_81E17C                    ;81E133;81E17C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E136: %Set8bit(!M)                             ;81E136;      ;
                       LDA.B #$02                           ;81E138;      ;
                       STA.W !inputstate                          ;81E13A;00019A;
                       LDX.W #$0306                         ;81E13D;      ;
                       LDA.B #$00                           ;81E140;      ;
                       STA.W $0191                          ;81E142;000191;
                       JSL.L StartTextBox                    ;81E145;83935F;
                       %Set16bit(!M)                             ;81E149;      ;
                       %Set16bit(!MX)                             ;81E14B;      ;
                       LDA.W #$0040                         ;81E14D;      ;
                       EOR.W #$FFFF                         ;81E150;      ;
                       AND.B !game_state                            ;81E153;0000D2;
                       STA.B !game_state                            ;81E155;0000D2;
                       JMP.W CODE_81E221                    ;81E157;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E15A: %Set8bit(!M)                             ;81E15A;      ;
                       LDA.B #$02                           ;81E15C;      ;
                       STA.W !inputstate                          ;81E15E;00019A;
                       LDX.W #$03B7                         ;81E161;      ;
                       LDA.B #$00                           ;81E164;      ;
                       STA.W $0191                          ;81E166;000191;
                       JSL.L StartTextBox                    ;81E169;83935F;
                       %Set16bit(!MX)                             ;81E16D;      ;
                       LDA.W #$0040                         ;81E16F;      ;
                       EOR.W #$FFFF                         ;81E172;      ;
                       AND.B !game_state                            ;81E175;0000D2;
                       STA.B !game_state                            ;81E177;0000D2;
                       JMP.W CODE_81E221                    ;81E179;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E17C: %Set16bit(!M)                             ;81E17C;      ;
                       LDA.W #$FF9C                         ;81E17E;      ;
                       STA.B $72                            ;81E181;000072;
                       %Set8bit(!M)                             ;81E183;      ;
                       LDA.B #$FF                           ;81E185;      ;
                       STA.B $74                            ;81E187;000074;
                       JSL.L AddMoney                       ;81E189;83B1C9;
                       %Set16bit(!M)                             ;81E18D;      ;
                       CMP.W #$0000                         ;81E18F;      ;
                       BEQ CODE_81E1B5                      ;81E192;81E1B5;
                       %Set8bit(!M)                             ;81E194;      ;
                       LDA.B #$02                           ;81E196;      ;
                       STA.W !inputstate                          ;81E198;00019A;
                       LDX.W #$0304                         ;81E19B;      ;
                       LDA.B #$00                           ;81E19E;      ;
                       STA.W $0191                          ;81E1A0;000191;
                       JSL.L StartTextBox                    ;81E1A3;83935F;
                       %Set16bit(!MX)                             ;81E1A7;      ;
                       LDA.W #$0040                         ;81E1A9;      ;
                       EOR.W #$FFFF                         ;81E1AC;      ;
                       AND.B !game_state                            ;81E1AF;0000D2;
                       STA.B !game_state                            ;81E1B1;0000D2;
                       BRA CODE_81E221                      ;81E1B3;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E1B5: %Set8bit(!M)                             ;81E1B5;      ;
                       LDA.B #$02                           ;81E1B7;      ;
                       STA.W !inputstate                          ;81E1B9;00019A;
                       LDX.W #$0311                         ;81E1BC;      ;
                       LDA.B #$00                           ;81E1BF;      ;
                       STA.W $0191                          ;81E1C1;000191;
                       JSL.L StartTextBox                    ;81E1C4;83935F;
                       %Set16bit(!MX)                             ;81E1C8;      ;
                       LDA.W #$0040                         ;81E1CA;      ;
                       EOR.W #$FFFF                         ;81E1CD;      ;
                       AND.B !game_state                            ;81E1D0;0000D2;
                       STA.B !game_state                            ;81E1D2;0000D2;
                       %Set16bit(!M)                             ;81E1D4;      ;
                       LDA.W #$0002                         ;81E1D6;      ;
                       JSL.L AddNewChicken                  ;81E1D9;83C807;
                       %Set16bit(!M)                             ;81E1DD;      ;
                       LDA.L $7F1F5A                        ;81E1DF;7F1F5A;
                       ORA.W #$0020                         ;FLAG5A
                       STA.L $7F1F5A                        ;81E1E6;7F1F5A;
                       %Set8bit(!M)                             ;81E1EA;      ;
                       LDA.L !chicks_N                        ;81E1EC;7F1F0B;
                       INC A                                ;81E1F0;      ;
                       STA.L !chicks_N                        ;81E1F1;7F1F0B;
                       %Set16bit(!M)                             ;81E1F5;      ;
                       LDA.W #$000A                         ;81E1F7;      ;
                       JSL.L AddPlayerHappiness                   ;81E1FA;83B282;
                       BRA CODE_81E221                      ;81E1FE;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E200: %Set8bit(!M)                             ;81E200;      ;
                       LDA.B #$02                           ;81E202;      ;
                       STA.W !inputstate                          ;81E204;00019A;
                       LDX.W #$0303                         ;81E207;      ;
                       LDA.B #$00                           ;81E20A;      ;
                       STA.W $0191                          ;81E20C;000191;
                       JSL.L StartTextBox                    ;81E20F;83935F;
                                                            ;      ;      ;
          CODE_81E213: %Set16bit(!MX)                             ;81E213;      ;
                       LDA.W #$0040                         ;81E215;      ;
                       EOR.W #$FFFF                         ;81E218;      ;
                       AND.B !game_state                            ;81E21B;0000D2;
                       STA.B !game_state                            ;81E21D;0000D2;
                       BRA CODE_81E221                      ;81E21F;81E221;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E221: RTS                                  ;81E221;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E222: JSL.L CODE_8393F9                    ;81E222;8393F9;
                       %Set8bit(!M)                             ;81E226;      ;
                       LDA.B #$01                           ;81E228;      ;
                       STA.W !inputstate                          ;81E22A;00019A;
                       %Set16bit(!M)                             ;81E22D;      ;
                       LDA.W !Joy1_New_Input                          ;81E22F;000128;
                       AND.W #$FF7F                         ;81E232;      ;
                       STA.W !Joy1_New_Input                          ;81E235;000128;
                       %Set16bit(!MX)                             ;81E238;      ;
                       LDA.W #$0040                         ;81E23A;      ;
                       EOR.W #$FFFF                         ;81E23D;      ;
                       AND.B !game_state                            ;81E240;0000D2;
                       STA.B !game_state                            ;81E242;0000D2;
                       RTS                                  ;81E244;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E245;      ;
                       LDA.W #$007E                         ;81E247;      ;
                       ASL A                                ;81E24A;      ;
                       ASL A                                ;81E24B;      ;
                       TAX                                  ;81E24C;      ;
                       %Set8bit(!M)                             ;81E24D;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E24F;82CFB4;
                       STA.W !item_on_hand                          ;81E253;00091D;
                       %Set16bit(!MX)                             ;81E256;      ;
                       LDA.W #$0004                         ;81E258;      ;
                       STA.B !player_action                            ;81E25B;0000D4;
                       %Set16bit(!MX)                             ;81E25D;      ;
                       LDA.W #$0040                         ;81E25F;      ;
                       EOR.W #$FFFF                         ;81E262;      ;
                       AND.B !game_state                            ;81E265;0000D2;
                       STA.B !game_state                            ;81E267;0000D2;
                       RTS                                  ;81E269;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E26A;      ;
                       LDA.W #$007F                         ;81E26C;      ;
                       ASL A                                ;81E26F;      ;
                       ASL A                                ;81E270;      ;
                       TAX                                  ;81E271;      ;
                       %Set8bit(!M)                             ;81E272;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E274;82CFB4;
                       STA.W !item_on_hand                          ;81E278;00091D;
                       %Set16bit(!MX)                             ;81E27B;      ;
                       LDA.W #$0004                         ;81E27D;      ;
                       STA.B !player_action                            ;81E280;0000D4;
                       %Set16bit(!MX)                             ;81E282;      ;
                       LDA.W #$0040                         ;81E284;      ;
                       EOR.W #$FFFF                         ;81E287;      ;
                       AND.B !game_state                            ;81E28A;0000D2;
                       STA.B !game_state                            ;81E28C;0000D2;
                       RTS                                  ;81E28E;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E28F;      ;
                       LDA.W #$0080                         ;81E291;      ;
                       ASL A                                ;81E294;      ;
                       ASL A                                ;81E295;      ;
                       TAX                                  ;81E296;      ;
                       %Set8bit(!M)                             ;81E297;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E299;82CFB4;
                       STA.W !item_on_hand                          ;81E29D;00091D;
                       %Set16bit(!MX)                             ;81E2A0;      ;
                       LDA.W #$0004                         ;81E2A2;      ;
                       STA.B !player_action                            ;81E2A5;0000D4;
                       %Set16bit(!MX)                             ;81E2A7;      ;
                       LDA.W #$0040                         ;81E2A9;      ;
                       EOR.W #$FFFF                         ;81E2AC;      ;
                       AND.B !game_state                            ;81E2AF;0000D2;
                       STA.B !game_state                            ;81E2B1;0000D2;
                       RTS                                  ;81E2B3;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E2B4;      ;
                       LDA.W #$0081                         ;81E2B6;      ;
                       ASL A                                ;81E2B9;      ;
                       ASL A                                ;81E2BA;      ;
                       TAX                                  ;81E2BB;      ;
                       %Set8bit(!M)                             ;81E2BC;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E2BE;82CFB4;
                       STA.W !item_on_hand                          ;81E2C2;00091D;
                       %Set16bit(!MX)                             ;81E2C5;      ;
                       LDA.W #$0004                         ;81E2C7;      ;
                       STA.B !player_action                            ;81E2CA;0000D4;
                       %Set16bit(!MX)                             ;81E2CC;      ;
                       LDA.W #$0040                         ;81E2CE;      ;
                       EOR.W #$FFFF                         ;81E2D1;      ;
                       AND.B !game_state                            ;81E2D4;0000D2;
                       STA.B !game_state                            ;81E2D6;0000D2;
                       RTS                                  ;81E2D8;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E2D9;      ;
                       %Set16bit(!X)                             ;81E2DB;      ;
                       LDA.W $096F                          ;81E2DD;00096F;
                       CMP.B #$01                           ;81E2E0;      ;
                       BEQ CODE_81E2FF                      ;81E2E2;81E2FF;
                       %Set8bit(!M)                             ;81E2E4;      ;
                       LDA.B #$02                           ;81E2E6;      ;
                       STA.W !inputstate                          ;81E2E8;00019A;
                       LDX.W #$0023                         ;81E2EB;      ;
                       LDA.B #$00                           ;81E2EE;      ;
                       STA.W $0191                          ;81E2F0;000191;
                       JSL.L StartTextBox                    ;81E2F3;83935F;
                       %Set8bit(!M)                             ;81E2F7;      ;
                       INC.W $096F                          ;81E2F9;00096F;
                       JMP.W CODE_81E348                    ;81E2FC;81E348;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E2FF: %Set8bit(!M)                             ;81E2FF;      ;
                       LDA.W !inputstate                          ;81E301;00019A;
                       CMP.B #$02                           ;81E304;      ;
                       BNE CODE_81E30B                      ;81E306;81E30B;
                       JMP.W CODE_81E348                    ;81E308;81E348;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E30B: LDA.W $018F                          ;81E30B;00018F;
                       BEQ CODE_81E313                      ;81E30E;81E313;
                       JMP.W CODE_81E33C                    ;81E310;81E33C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E313: %Set16bit(!M)                             ;81E313;      ;
                       LDA.L !hearts_ellen                        ;81E315;7F1F25;
                       JSR.W CODE_81D1C5                    ;81E319;81D1C5;
                       %Set16bit(!MX)                             ;81E31C;      ;
                       CLC                                  ;81E31E;      ;
                       ADC.W #$03A6                         ;81E31F;      ;
                       TAX                                  ;81E322;      ;
                       %Set8bit(!M)                             ;81E323;      ;
                       LDA.B #$02                           ;81E325;      ;
                       STA.W !inputstate                          ;81E327;00019A;
                       LDA.B #$00                           ;81E32A;      ;
                       STA.W $0191                          ;81E32C;000191;
                       JSL.L StartTextBox                    ;81E32F;83935F;
                       %Set16bit(!M)                             ;81E333;      ;
                       LDA.W #$FFFF                         ;81E335;      ;
                       JSL.L AddPlayerHappiness                   ;81E338;83B282;
                                                            ;      ;      ;
          CODE_81E33C: %Set16bit(!MX)                             ;81E33C;      ;
                       LDA.W #$0040                         ;81E33E;      ;
                       EOR.W #$FFFF                         ;81E341;      ;
                       AND.B !game_state                            ;81E344;0000D2;
                       STA.B !game_state                            ;81E346;0000D2;
                                                            ;      ;      ;
          CODE_81E348: RTS                                  ;81E348;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E349;      ;
                       LDA.W #$0082                         ;81E34B;      ;
                       ASL A                                ;81E34E;      ;
                       ASL A                                ;81E34F;      ;
                       TAX                                  ;81E350;      ;
                       %Set8bit(!M)                             ;81E351;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E353;82CFB4;
                       STA.W !item_on_hand                          ;81E357;00091D;
                       %Set16bit(!MX)                             ;81E35A;      ;
                       LDA.W #$0004                         ;81E35C;      ;
                       STA.B !player_action                            ;81E35F;0000D4;
                       %Set16bit(!MX)                             ;81E361;      ;
                       LDA.W #$0040                         ;81E363;      ;
                       EOR.W #$FFFF                         ;81E366;      ;
                       AND.B !game_state                            ;81E369;0000D2;
                       STA.B !game_state                            ;81E36B;0000D2;
                       RTS                                  ;81E36D;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E36E;      ;
                       %Set16bit(!X)                             ;81E370;      ;
                       LDA.B #$24                           ;81E372;      ;
                       LDX.W #$0007                         ;81E374;      ;
                       LDY.W #$0078                         ;81E377;      ;
                       JSL.L UNK_Audio24                          ;81E37A;8382FE;
                       %Set8bit(!M)                             ;81E37E;      ;
                       STZ.W $0119                          ;81E380;000119;
                       JSL.L ToolUsedSound2                          ;81E383;828FF3;
                       %Set16bit(!MX)                             ;81E387;      ;
                       LDA.W #$0040                         ;81E389;      ;
                       EOR.W #$FFFF                         ;81E38C;      ;
                       AND.B !game_state                            ;81E38F;0000D2;
                       STA.B !game_state                            ;81E391;0000D2;
                       RTS                                  ;81E393;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E394;      ;
                       %Set16bit(!X)                             ;81E396;      ;
                       LDA.W $096F                          ;81E398;00096F;
                       CMP.B #$01                           ;81E39B;      ;
                       BEQ CODE_81E3BA                      ;81E39D;81E3BA;
                       %Set8bit(!M)                             ;81E39F;      ;
                       LDA.B #$02                           ;81E3A1;      ;
                       STA.W !inputstate                          ;81E3A3;00019A;
                       LDX.W #$0023                         ;81E3A6;      ;
                       LDA.B #$00                           ;81E3A9;      ;
                       STA.W $0191                          ;81E3AB;000191;
                       JSL.L StartTextBox                    ;81E3AE;83935F;
                       %Set8bit(!M)                             ;81E3B2;      ;
                       INC.W $096F                          ;81E3B4;00096F;
                       JMP.W CODE_81E403                    ;81E3B7;81E403;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E3BA: %Set8bit(!M)                             ;81E3BA;      ;
                       LDA.W !inputstate                          ;81E3BC;00019A;
                       CMP.B #$02                           ;81E3BF;      ;
                       BNE CODE_81E3C6                      ;81E3C1;81E3C6;
                       JMP.W CODE_81E403                    ;81E3C3;81E403;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E3C6: LDA.W $018F                          ;81E3C6;00018F;
                       BEQ CODE_81E3CE                      ;81E3C9;81E3CE;
                       JMP.W CODE_81E3F7                    ;81E3CB;81E3F7;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E3CE: %Set16bit(!M)                             ;81E3CE;      ;
                       LDA.L !hearts_ann                        ;81E3D0;7F1F21;
                       JSR.W CODE_81D1C5                    ;81E3D4;81D1C5;
                       %Set16bit(!MX)                             ;81E3D7;      ;
                       CLC                                  ;81E3D9;      ;
                       ADC.W #$03A6                         ;81E3DA;      ;
                       TAX                                  ;81E3DD;      ;
                       %Set8bit(!M)                             ;81E3DE;      ;
                       LDA.B #$02                           ;81E3E0;      ;
                       STA.W !inputstate                          ;81E3E2;00019A;
                       LDA.B #$00                           ;81E3E5;      ;
                       STA.W $0191                          ;81E3E7;000191;
                       JSL.L StartTextBox                    ;81E3EA;83935F;
                       %Set16bit(!M)                             ;81E3EE;      ;
                       LDA.W #$FFFF                         ;81E3F0;      ;
                       JSL.L AddPlayerHappiness                   ;81E3F3;83B282;
                                                            ;      ;      ;
          CODE_81E3F7: %Set16bit(!MX)                             ;81E3F7;      ;
                       LDA.W #$0040                         ;81E3F9;      ;
                       EOR.W #$FFFF                         ;81E3FC;      ;
                       AND.B !game_state                            ;81E3FF;0000D2;
                       STA.B !game_state                            ;81E401;0000D2;
                                                            ;      ;      ;
          CODE_81E403: RTS                                  ;81E403;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E404;      ;
                       LDA.W #$0077                         ;81E406;      ;
                       ASL A                                ;81E409;      ;
                       ASL A                                ;81E40A;      ;
                       TAX                                  ;81E40B;      ;
                       %Set8bit(!M)                             ;81E40C;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E40E;82CFB4;
                       STA.W !item_on_hand                          ;81E412;00091D;
                       %Set16bit(!MX)                             ;81E415;      ;
                       LDA.W #$0004                         ;81E417;      ;
                       STA.B !player_action                            ;81E41A;0000D4;
                       %Set16bit(!MX)                             ;81E41C;      ;
                       LDA.W #$0040                         ;81E41E;      ;
                       EOR.W #$FFFF                         ;81E421;      ;
                       AND.B !game_state                            ;81E424;0000D2;
                       STA.B !game_state                            ;81E426;0000D2;
                       RTS                                  ;81E428;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E429;      ;
                       LDA.W #$0076                         ;81E42B;      ;
                       ASL A                                ;81E42E;      ;
                       ASL A                                ;81E42F;      ;
                       TAX                                  ;81E430;      ;
                       %Set8bit(!M)                             ;81E431;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E433;82CFB4;
                       STA.W !item_on_hand                          ;81E437;00091D;
                       %Set16bit(!MX)                             ;81E43A;      ;
                       LDA.W #$0004                         ;81E43C;      ;
                       STA.B !player_action                            ;81E43F;0000D4;
                       %Set16bit(!MX)                             ;81E441;      ;
                       LDA.W #$0040                         ;81E443;      ;
                       EOR.W #$FFFF                         ;81E446;      ;
                       AND.B !game_state                            ;81E449;0000D2;
                       STA.B !game_state                            ;81E44B;0000D2;
                       RTS                                  ;81E44D;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E44E;      ;
                       LDA.W #$0078                         ;81E450;      ;
                       ASL A                                ;81E453;      ;
                       ASL A                                ;81E454;      ;
                       TAX                                  ;81E455;      ;
                       %Set8bit(!M)                             ;81E456;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E458;82CFB4;
                       STA.W !item_on_hand                          ;81E45C;00091D;
                       %Set16bit(!MX)                             ;81E45F;      ;
                       LDA.W #$0004                         ;81E461;      ;
                       STA.B !player_action                            ;81E464;0000D4;
                       %Set16bit(!MX)                             ;81E466;      ;
                       LDA.W #$0040                         ;81E468;      ;
                       EOR.W #$FFFF                         ;81E46B;      ;
                       AND.B !game_state                            ;81E46E;0000D2;
                       STA.B !game_state                            ;81E470;0000D2;
                       RTS                                  ;81E472;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E473;      ;
                       LDA.W #$007D                         ;81E475;      ;
                       ASL A                                ;81E478;      ;
                       ASL A                                ;81E479;      ;
                       TAX                                  ;81E47A;      ;
                       %Set8bit(!M)                             ;81E47B;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E47D;82CFB4;
                       STA.W !item_on_hand                          ;81E481;00091D;
                       %Set16bit(!MX)                             ;81E484;      ;
                       LDA.W #$0004                         ;81E486;      ;
                       STA.B !player_action                            ;81E489;0000D4;
                       %Set16bit(!MX)                             ;81E48B;      ;
                       LDA.W #$0040                         ;81E48D;      ;
                       EOR.W #$FFFF                         ;81E490;      ;
                       AND.B !game_state                            ;81E493;0000D2;
                       STA.B !game_state                            ;81E495;0000D2;
                       RTS                                  ;81E497;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E498;      ;
                       LDA.W #$0079                         ;81E49A;      ;
                       ASL A                                ;81E49D;      ;
                       ASL A                                ;81E49E;      ;
                       TAX                                  ;81E49F;      ;
                       %Set8bit(!M)                             ;81E4A0;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E4A2;82CFB4;
                       STA.W !item_on_hand                          ;81E4A6;00091D;
                       %Set16bit(!MX)                             ;81E4A9;      ;
                       LDA.W #$0004                         ;81E4AB;      ;
                       STA.B !player_action                            ;81E4AE;0000D4;
                       %Set16bit(!MX)                             ;81E4B0;      ;
                       LDA.W #$0040                         ;81E4B2;      ;
                       EOR.W #$FFFF                         ;81E4B5;      ;
                       AND.B !game_state                            ;81E4B8;0000D2;
                       STA.B !game_state                            ;81E4BA;0000D2;
                       RTS                                  ;81E4BC;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E4BD;      ;
                       LDA.W #$007A                         ;81E4BF;      ;
                       ASL A                                ;81E4C2;      ;
                       ASL A                                ;81E4C3;      ;
                       TAX                                  ;81E4C4;      ;
                       %Set8bit(!M)                             ;81E4C5;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E4C7;82CFB4;
                       STA.W !item_on_hand                          ;81E4CB;00091D;
                       %Set16bit(!MX)                             ;81E4CE;      ;
                       LDA.W #$0004                         ;81E4D0;      ;
                       STA.B !player_action                            ;81E4D3;0000D4;
                       %Set16bit(!MX)                             ;81E4D5;      ;
                       LDA.W #$0040                         ;81E4D7;      ;
                       EOR.W #$FFFF                         ;81E4DA;      ;
                       AND.B !game_state                            ;81E4DD;0000D2;
                       STA.B !game_state                            ;81E4DF;0000D2;
                       RTS                                  ;81E4E1;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E4E2;      ;
                       LDA.W #$007B                         ;81E4E4;      ;
                       ASL A                                ;81E4E7;      ;
                       ASL A                                ;81E4E8;      ;
                       TAX                                  ;81E4E9;      ;
                       %Set8bit(!M)                             ;81E4EA;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E4EC;82CFB4;
                       STA.W !item_on_hand                          ;81E4F0;00091D;
                       %Set16bit(!MX)                             ;81E4F3;      ;
                       LDA.W #$0004                         ;81E4F5;      ;
                       STA.B !player_action                            ;81E4F8;0000D4;
                       %Set16bit(!MX)                             ;81E4FA;      ;
                       LDA.W #$0040                         ;81E4FC;      ;
                       EOR.W #$FFFF                         ;81E4FF;      ;
                       AND.B !game_state                            ;81E502;0000D2;
                       STA.B !game_state                            ;81E504;0000D2;
                       RTS                                  ;81E506;      ;
                                                            ;      ;      ;
                       %Set16bit(!M)                             ;81E507;      ;
                       LDA.W #$007C                         ;81E509;      ;
                       ASL A                                ;81E50C;      ;
                       ASL A                                ;81E50D;      ;
                       TAX                                  ;81E50E;      ;
                       %Set8bit(!M)                             ;81E50F;      ;
                       LDA.L DATA8_82CFB4,X                 ;81E511;82CFB4;
                       STA.W !item_on_hand                          ;81E515;00091D;
                       %Set16bit(!MX)                             ;81E518;      ;
                       LDA.W #$0004                         ;81E51A;      ;
                       STA.B !player_action                            ;81E51D;0000D4;
                       %Set16bit(!MX)                             ;81E51F;      ;
                       LDA.W #$0040                         ;81E521;      ;
                       EOR.W #$FFFF                         ;81E524;      ;
                       AND.B !game_state                            ;81E527;0000D2;
                       STA.B !game_state                            ;81E529;0000D2;
                       RTS                                  ;81E52B;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E52C;      ;
                       %Set16bit(!X)                             ;81E52E;      ;
                       LDA.W $096F                          ;81E530;00096F;
                       CMP.B #$01                           ;81E533;      ;
                       BEQ CODE_81E552                      ;81E535;81E552;
                       %Set8bit(!M)                             ;81E537;      ;
                       LDA.B #$02                           ;81E539;      ;
                       STA.W !inputstate                          ;81E53B;00019A;
                       LDX.W #$0023                         ;81E53E;      ;
                       LDA.B #$00                           ;81E541;      ;
                       STA.W $0191                          ;81E543;000191;
                       JSL.L StartTextBox                    ;81E546;83935F;
                       %Set8bit(!M)                             ;81E54A;      ;
                       INC.W $096F                          ;81E54C;00096F;
                       JMP.W CODE_81E59B                    ;81E54F;81E59B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E552: %Set8bit(!M)                             ;81E552;      ;
                       LDA.W !inputstate                          ;81E554;00019A;
                       CMP.B #$02                           ;81E557;      ;
                       BNE CODE_81E55E                      ;81E559;81E55E;
                       JMP.W CODE_81E59B                    ;81E55B;81E59B;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E55E: LDA.W $018F                          ;81E55E;00018F;
                       BEQ CODE_81E566                      ;81E561;81E566;
                       JMP.W CODE_81E58F                    ;81E563;81E58F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E566: %Set16bit(!M)                             ;81E566;      ;
                       LDA.L !hearts_eve                        ;81E568;7F1F27;
                       JSR.W CODE_81D1C5                    ;81E56C;81D1C5;
                       %Set16bit(!MX)                             ;81E56F;      ;
                       CLC                                  ;81E571;      ;
                       ADC.W #$03A6                         ;81E572;      ;
                       TAX                                  ;81E575;      ;
                       %Set8bit(!M)                             ;81E576;      ;
                       LDA.B #$02                           ;81E578;      ;
                       STA.W !inputstate                          ;81E57A;00019A;
                       LDA.B #$00                           ;81E57D;      ;
                       STA.W $0191                          ;81E57F;000191;
                       JSL.L StartTextBox                    ;81E582;83935F;
                       %Set16bit(!M)                             ;81E586;      ;
                       LDA.W #$FFFF                         ;81E588;      ;
                       JSL.L AddPlayerHappiness                   ;81E58B;83B282;
                                                            ;      ;      ;
          CODE_81E58F: %Set16bit(!MX)                             ;81E58F;      ;
                       LDA.W #$0040                         ;81E591;      ;
                       EOR.W #$FFFF                         ;81E594;      ;
                       AND.B !game_state                            ;81E597;0000D2;
                       STA.B !game_state                            ;81E599;0000D2;
                                                            ;      ;      ;
          CODE_81E59B: RTS                                  ;81E59B;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E59C;      ;
                       %Set16bit(!X)                             ;81E59E;      ;
                       LDA.W $096F                          ;81E5A0;00096F;
                       CMP.B #$01                           ;81E5A3;      ;
                       BEQ CODE_81E5C2                      ;81E5A5;81E5C2;
                       %Set8bit(!M)                             ;81E5A7;      ;
                       LDA.B #$02                           ;81E5A9;      ;
                       STA.W !inputstate                          ;81E5AB;00019A;
                       LDX.W #$045F                         ;81E5AE;      ;
                       LDA.B #$00                           ;81E5B1;      ;
                       STA.W $0191                          ;81E5B3;000191;
                       JSL.L StartTextBox                    ;81E5B6;83935F;
                       %Set8bit(!M)                             ;81E5BA;      ;
                       INC.W $096F                          ;81E5BC;00096F;
                       JMP.W CODE_81E69F                    ;81E5BF;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E5C2: %Set16bit(!MX)                             ;81E5C2;      ;
                       LDA.W !Joy1_Current                          ;81E5C4;000124;
                       BIT.W #$8000                         ;81E5C7;      ;
                       BEQ CODE_81E5CF                      ;81E5CA;81E5CF;
                       JMP.W CODE_81E6A0                    ;81E5CC;81E6A0;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E5CF: %Set8bit(!M)                             ;81E5CF;      ;
                       LDA.W !inputstate                          ;81E5D1;00019A;
                       CMP.B #$02                           ;81E5D4;      ;
                       BNE CODE_81E5DB                      ;81E5D6;81E5DB;
                       JMP.W CODE_81E69F                    ;81E5D8;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E5DB: LDA.W $018F                          ;81E5DB;00018F;
                       CMP.B #$00                           ;81E5DE;      ;
                       BEQ CODE_81E5F5                      ;81E5E0;81E5F5;
                       CMP.B #$01                           ;81E5E2;      ;
                       BEQ CODE_81E617                      ;81E5E4;81E617;
                       CMP.B #$02                           ;81E5E6;      ;
                       BEQ CODE_81E639                      ;81E5E8;81E639;
                       CMP.B #$03                           ;81E5EA;      ;
                       BEQ CODE_81E65B                      ;81E5EC;81E65B;
                       CMP.B #$04                           ;81E5EE;      ;
                       BNE CODE_81E5F5                      ;81E5F0;81E5F5;
                       JMP.W CODE_81E67D                    ;81E5F2;81E67D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E5F5: %Set8bit(!M)                             ;81E5F5;      ;
                       LDA.B #$02                           ;81E5F7;      ;
                       STA.W !inputstate                          ;81E5F9;00019A;
                       LDX.W #$0460                         ;81E5FC;      ;
                       LDA.B #$00                           ;81E5FF;      ;
                       STA.W $0191                          ;81E601;000191;
                       JSL.L StartTextBox                    ;81E604;83935F;
                       %Set16bit(!MX)                             ;81E608;      ;
                       LDA.W #$0040                         ;81E60A;      ;
                       EOR.W #$FFFF                         ;81E60D;      ;
                       AND.B !game_state                            ;81E610;0000D2;
                       STA.B !game_state                            ;81E612;0000D2;
                       JMP.W CODE_81E69F                    ;81E614;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E617: %Set8bit(!M)                             ;81E617;      ;
                       LDA.B #$02                           ;81E619;      ;
                       STA.W !inputstate                          ;81E61B;00019A;
                       LDX.W #$0462                         ;81E61E;      ;
                       LDA.B #$00                           ;81E621;      ;
                       STA.W $0191                          ;81E623;000191;
                       JSL.L StartTextBox                    ;81E626;83935F;
                       %Set16bit(!MX)                             ;81E62A;      ;
                       LDA.W #$0040                         ;81E62C;      ;
                       EOR.W #$FFFF                         ;81E62F;      ;
                       AND.B !game_state                            ;81E632;0000D2;
                       STA.B !game_state                            ;81E634;0000D2;
                       JMP.W CODE_81E69F                    ;81E636;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E639: %Set8bit(!M)                             ;81E639;      ;
                       LDA.B #$02                           ;81E63B;      ;
                       STA.W !inputstate                          ;81E63D;00019A;
                       LDX.W #$0464                         ;81E640;      ;
                       LDA.B #$00                           ;81E643;      ;
                       STA.W $0191                          ;81E645;000191;
                       JSL.L StartTextBox                    ;81E648;83935F;
                       %Set16bit(!MX)                             ;81E64C;      ;
                       LDA.W #$0040                         ;81E64E;      ;
                       EOR.W #$FFFF                         ;81E651;      ;
                       AND.B !game_state                            ;81E654;0000D2;
                       STA.B !game_state                            ;81E656;0000D2;
                       JMP.W CODE_81E69F                    ;81E658;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E65B: %Set8bit(!M)                             ;81E65B;      ;
                       LDA.B #$02                           ;81E65D;      ;
                       STA.W !inputstate                          ;81E65F;00019A;
                       LDX.W #$0461                         ;81E662;      ;
                       LDA.B #$00                           ;81E665;      ;
                       STA.W $0191                          ;81E667;000191;
                       JSL.L StartTextBox                    ;81E66A;83935F;
                       %Set16bit(!MX)                             ;81E66E;      ;
                       LDA.W #$0040                         ;81E670;      ;
                       EOR.W #$FFFF                         ;81E673;      ;
                       AND.B !game_state                            ;81E676;0000D2;
                       STA.B !game_state                            ;81E678;0000D2;
                       JMP.W CODE_81E69F                    ;81E67A;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E67D: %Set8bit(!M)                             ;81E67D;      ;
                       LDA.B #$02                           ;81E67F;      ;
                       STA.W !inputstate                          ;81E681;00019A;
                       LDX.W #$0463                         ;81E684;      ;
                       LDA.B #$00                           ;81E687;      ;
                       STA.W $0191                          ;81E689;000191;
                       JSL.L StartTextBox                    ;81E68C;83935F;
                       %Set16bit(!MX)                             ;81E690;      ;
                       LDA.W #$0040                         ;81E692;      ;
                       EOR.W #$FFFF                         ;81E695;      ;
                       AND.B !game_state                            ;81E698;0000D2;
                       STA.B !game_state                            ;81E69A;0000D2;
                       JMP.W CODE_81E69F                    ;81E69C;81E69F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E69F: RTS                                  ;81E69F;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E6A0: JSL.L CODE_8393F9                    ;81E6A0;8393F9;
                       %Set8bit(!M)                             ;81E6A4;      ;
                       LDA.B #$01                           ;81E6A6;      ;
                       STA.W !inputstate                          ;81E6A8;00019A;
                       %Set16bit(!M)                             ;81E6AB;      ;
                       LDA.W !Joy1_New_Input                          ;81E6AD;000128;
                       AND.W #$FF7F                         ;81E6B0;      ;
                       STA.W !Joy1_New_Input                          ;81E6B3;000128;
                       %Set16bit(!MX)                             ;81E6B6;      ;
                       LDA.W #$0040                         ;81E6B8;      ;
                       EOR.W #$FFFF                         ;81E6BB;      ;
                       AND.B !game_state                            ;81E6BE;0000D2;
                       STA.B !game_state                            ;81E6C0;0000D2;
                       RTS                                  ;81E6C2;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81E6C3;      ;
                       %Set16bit(!MX)                             ;81E6C5;      ;
                       LDA.B !game_state                            ;81E6C7;0000D2;
                       ORA.W #$0020                         ;81E6C9;      ;
                       STA.B !game_state                            ;81E6CC;0000D2;
                       %Set16bit(!MX)                             ;81E6CE;      ;
                       LDA.W #$0003                         ;81E6D0;      ;
                       STA.B !player_action                            ;81E6D3;0000D4;
                       %Set16bit(!MX)                             ;81E6D5;      ;
                       LDA.W #$0040                         ;81E6D7;      ;
                       EOR.W #$FFFF                         ;81E6DA;      ;
                       AND.B !game_state                            ;81E6DD;0000D2;
                       STA.B !game_state                            ;81E6DF;0000D2;
                       %Set8bit(!M)                             ;81E6E1;      ;
                       LDA.B #$0C                           ;81E6E3;      ;
                       JSL.L ChangeStamina                    ;81E6E5;81D061;
                       RTS                                  ;81E6E9;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E6EA;      ;
                       %Set16bit(!X)                             ;81E6EC;      ;
                       LDA.W $096F                          ;81E6EE;00096F;
                       CMP.B #$01                           ;81E6F1;      ;
                       BEQ CODE_81E732                      ;81E6F3;81E732;
                       CMP.B #$02                           ;81E6F5;      ;
                       BEQ CODE_81E762                      ;81E6F7;81E762;
                       CMP.B #$03                           ;81E6F9;      ;
                       BNE CODE_81E700                      ;81E6FB;81E700;
                       JMP.W CODE_81E791                    ;81E6FD;81E791;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E700: %Set16bit(!MX)                             ;81E700;      ;
                       LDA.B !game_state                            ;81E702;0000D2;
                       ORA.W #$0080                         ;81E704;      ;
                       STA.B !game_state                            ;81E707;0000D2;
                       %Set16bit(!MX)                             ;81E709;      ;
                       LDA.W #$0001                         ;81E70B;      ;
                       STA.B !player_action                            ;81E70E;0000D4;
                       %Set16bit(!MX)                             ;81E710;      ;
                       LDA.W #$0002                         ;81E712;      ;
                       STA.B !player_direction                            ;81E715;0000DA;
                       %Set16bit(!MX)                             ;81E717;      ;
                       LDA.W #$0002                         ;81E719;      ;
                       STA.W $0911                          ;81E71C;000911;
                       %Set8bit(!M)                             ;81E71F;      ;
                       INC.W $0970                          ;81E721;000970;
                       LDA.W $0970                          ;81E724;000970;
                       CMP.B #$20                           ;81E727;      ;
                       BNE CODE_81E79D                      ;81E729;81E79D;
                       LDA.B #$01                           ;81E72B;      ;
                       STA.W $096F                          ;81E72D;00096F;
                       BRA CODE_81E79D                      ;81E730;81E79D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E732: %Set8bit(!M)                             ;81E732;      ;
                       LDX.W #$030C                         ;81E734;      ;
                       LDA.L !shed_items_row_2                        ;81E737;7F1F01;
                       AND.B #$04                           ;81E73B;      ;
                       BNE CODE_81E749                      ;81E73D;81E749;
                       LDA.W !tool_selected                          ;81E73F;000921;
                       CMP.B #$0B                           ;81E742;      ;
                       BEQ CODE_81E749                      ;81E744;81E749;
                       LDX.W #$010E                         ;81E746;      ;
                                                            ;      ;      ;
          CODE_81E749: %Set8bit(!M)                             ;81E749;      ;
                       LDA.B #$02                           ;81E74B;      ;
                       STA.W !inputstate                          ;81E74D;00019A;
                       LDA.B #$00                           ;81E750;      ;
                       STA.W $0191                          ;81E752;000191;
                       JSL.L StartTextBox                    ;81E755;83935F;
                       %Set8bit(!M)                             ;81E759;      ;
                       LDA.B #$02                           ;81E75B;      ;
                       STA.W $096F                          ;81E75D;00096F;
                       BRA CODE_81E79D                      ;81E760;81E79D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E762: %Set8bit(!M)                             ;81E762;      ;
                       LDA.W !inputstate                          ;81E764;00019A;
                       CMP.B #$02                           ;81E767;      ;
                       BNE CODE_81E76E                      ;81E769;81E76E;
                       JMP.W CODE_81E79D                    ;81E76B;81E79D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E76E: %Set8bit(!M)                             ;81E76E;      ;
                       LDA.B #$03                           ;81E770;      ;
                       STA.W $096F                          ;81E772;00096F;
                       LDA.B #$01                           ;81E775;      ;
                       STA.W $099F                          ;81E777;00099F;
                       LDA.L !shed_items_row_2                        ;81E77A;7F1F01;
                       ORA.B #$04                           ;81E77E;      ;
                       STA.L !shed_items_row_2                        ;81E780;7F1F01;
                       %Set16bit(!M)                             ;81E784;      ;
                       LDA.W $0196                          ;81E786;000196;
                       ORA.W #$2000                         ;81E789;      ;
                       STA.W $0196                          ;81E78C;000196;
                       BRA CODE_81E79D                      ;81E78F;81E79D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E791: %Set16bit(!MX)                             ;81E791;      ;
                       LDA.W #$0040                         ;81E793;      ;
                       EOR.W #$FFFF                         ;81E796;      ;
                       AND.B !game_state                            ;81E799;0000D2;
                       STA.B !game_state                            ;81E79B;0000D2;
                                                            ;      ;      ;
          CODE_81E79D: RTS                                  ;81E79D;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81E79E;      ;
                       %Set16bit(!X)                             ;81E7A0;      ;
                       LDA.W $096F                          ;81E7A2;00096F;
                       CMP.B #$01                           ;81E7A5;      ;
                       BNE CODE_81E7AC                      ;81E7A7;81E7AC;
                       JMP.W CODE_81E866                    ;81E7A9;81E866;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7AC: CMP.B #$02                           ;81E7AC;      ;
                       BNE CODE_81E7B3                      ;81E7AE;81E7B3;
                       JMP.W CODE_81E910                    ;81E7B0;81E910;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7B3: CMP.B #$03                           ;81E7B3;      ;
                       BNE CODE_81E7BA                      ;81E7B5;81E7BA;
                       JMP.W CODE_81E95D                    ;81E7B7;81E95D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7BA: CMP.B #$04                           ;81E7BA;      ;
                       BNE CODE_81E7C1                      ;81E7BC;81E7C1;
                       JMP.W CODE_81E9E2                    ;81E7BE;81E9E2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7C1: CMP.B #$05                           ;81E7C1;      ;
                       BNE CODE_81E7C8                      ;81E7C3;81E7C8;
                       JMP.W CODE_81EA11                    ;81E7C5;81EA11;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7C8: CMP.B #$06                           ;81E7C8;      ;
                       BNE CODE_81E7CF                      ;81E7CA;81E7CF;
                       JMP.W CODE_81EA42                    ;81E7CC;81EA42;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7CF: CMP.B #$07                           ;81E7CF;      ;
                       BNE CODE_81E7D6                      ;81E7D1;81E7D6;
                       JMP.W CODE_81EA8E                    ;81E7D3;81EA8E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7D6: CMP.B #$08                           ;81E7D6;      ;
                       BNE CODE_81E7DD                      ;81E7D8;81E7DD;
                       JMP.W CODE_81EABA                    ;81E7DA;81EABA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7DD: CMP.B #$09                           ;81E7DD;      ;
                       BNE CODE_81E7E4                      ;81E7DF;81E7E4;
                       JMP.W CODE_81EB07                    ;81E7E1;81EB07;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7E4: CMP.B #$0A                           ;81E7E4;      ;
                       BNE CODE_81E7EB                      ;81E7E6;81E7EB;
                       JMP.W CODE_81EB8F                    ;81E7E8;81EB8F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7EB: CMP.B #$0B                           ;81E7EB;      ;
                       BNE CODE_81E7F2                      ;81E7ED;81E7F2;
                       JMP.W CODE_81EBBF                    ;81E7EF;81EBBF;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E7F2: %Set8bit(!M)                             ;81E7F2;      ;
                       LDA.B #$00                           ;81E7F4;      ;
                       XBA                                  ;81E7F6;      ;
                       LDA.W $09A0                          ;81E7F7;0009A0;
                       SEC                                  ;81E7FA;      ;
                       SBC.B #$18                           ;81E7FB;      ;
                       %Set16bit(!M)                             ;81E7FD;      ;
                       JSL.L GetsCowPointer                ;81E7FF;83C9A7;
                       %Set8bit(!M)                             ;81E803;      ;
                       LDY.W #$0000                         ;81E805;      ;
                       LDA.B [$72],Y                        ;81E808;000072;
                       AND.B #$06                           ;81E80A;      ;
                       BNE CODE_81E84D                      ;81E80C;81E84D;
                       LDA.B [$72],Y                        ;81E80E;000072;
                       AND.B #$70                           ;81E810;      ;
                       BNE CODE_81E84D                      ;81E812;81E84D;
                       %Set8bit(!M)                             ;81E814;      ;
                       LDA.L !year                        ;81E816;7F1F18;
                       BEQ CODE_81E84D                      ;81E81A;81E84D;
                       %Set16bit(!MX)                             ;81E81C;      ;
                       LDA.L $7F1F66                        ;81E81E;7F1F66;
                       AND.W #$8000                         ;81E822;      ;
                       BNE CODE_81E84D                      ;81E825;81E84D;
                       %Set16bit(!M)                             ;81E827;      ;
                       LDA.L $7F1F66                        ;81E829;7F1F66;
                       ORA.W #$8000                         ;81E82D;      ;
                       STA.L $7F1F66                        ;81E830;7F1F66;
                       %Set16bit(!M)                             ;81E834;      ;
                       LDA.W #$0008                         ;81E836;      ;
                       LDX.W #$0000                         ;81E839;      ;
                       LDY.W #$007C                         ;81E83C;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81E83F;848097;
                       %Set8bit(!M)                             ;81E843;      ;
                       LDA.B #$07                           ;81E845;      ;
                       STA.W $096F                          ;81E847;00096F;
                       JMP.W CODE_81EBD4                    ;81E84A;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E84D: %Set16bit(!M)                             ;81E84D;      ;
                       LDA.W #$0007                         ;81E84F;      ;
                       LDX.W #$0000                         ;81E852;      ;
                       LDY.W #$0021                         ;81E855;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81E858;848097;
                       %Set8bit(!M)                             ;81E85C;      ;
                       LDA.B #$01                           ;81E85E;      ;
                       STA.W $096F                          ;81E860;00096F;
                       JMP.W CODE_81EBD4                    ;81E863;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E866: %Set8bit(!M)                             ;81E866;      ;
                       INC.W $0970                          ;81E868;000970;
                       LDA.W $0970                          ;81E86B;000970;
                       CMP.B #$40                           ;81E86E;      ;
                       BEQ CODE_81E875                      ;81E870;81E875;
                       JMP.W CODE_81EBD4                    ;81E872;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E875: %Set16bit(!M)                             ;81E875;      ;
                       LDA.L $7F1F60                        ;81E877;7F1F60;
                       AND.W #$2000                         ;81E87B;      ;
                       BNE CODE_81E8F1                      ;81E87E;81E8F1;
                       %Set8bit(!M)                             ;81E880;      ;
                       LDA.B #$02                           ;81E882;      ;
                       STA.W !inputstate                          ;81E884;00019A;
                       %Set8bit(!M)                             ;81E887;      ;
                       LDA.B #$00                           ;81E889;      ;
                       XBA                                  ;81E88B;      ;
                       LDA.W $09A0                          ;81E88C;0009A0;
                       SEC                                  ;81E88F;      ;
                       SBC.B #$18                           ;81E890;      ;
                       %Set16bit(!M)                             ;81E892;      ;
                       JSL.L GetsCowPointer                ;81E894;83C9A7;
                       %Set8bit(!M)                             ;81E898;      ;
                       LDY.W #$0000                         ;81E89A;      ;
                       LDA.B [$72],Y                        ;81E89D;000072;
                       AND.B #$06                           ;81E89F;      ;
                       BNE CODE_81E8C1                      ;81E8A1;81E8C1;
                       LDA.B [$72],Y                        ;81E8A3;000072;
                       AND.B #$70                           ;81E8A5;      ;
                       BNE CODE_81E8D9                      ;81E8A7;81E8D9;
                       LDX.W #$030E                         ;81E8A9;      ;
                       %Set8bit(!M)                             ;81E8AC;      ;
                       LDA.B #$00                           ;81E8AE;      ;
                       STA.W $0191                          ;81E8B0;000191;
                       JSL.L StartTextBox                    ;81E8B3;83935F;
                       %Set8bit(!M)                             ;81E8B7;      ;
                       LDA.B #$02                           ;81E8B9;      ;
                       STA.W $096F                          ;81E8BB;00096F;
                       JMP.W CODE_81EBD4                    ;81E8BE;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E8C1: LDX.W #$0310                         ;81E8C1;      ;
                       %Set8bit(!M)                             ;81E8C4;      ;
                       LDA.B #$00                           ;81E8C6;      ;
                       STA.W $0191                          ;81E8C8;000191;
                       JSL.L StartTextBox                    ;81E8CB;83935F;
                       %Set8bit(!M)                             ;81E8CF;      ;
                       LDA.B #$05                           ;81E8D1;      ;
                       STA.W $096F                          ;81E8D3;00096F;
                       JMP.W CODE_81EBD4                    ;81E8D6;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E8D9: LDX.W #$030D                         ;81E8D9;      ;
                       %Set8bit(!M)                             ;81E8DC;      ;
                       LDA.B #$00                           ;81E8DE;      ;
                       STA.W $0191                          ;81E8E0;000191;
                       JSL.L StartTextBox                    ;81E8E3;83935F;
                       %Set8bit(!M)                             ;81E8E7;      ;
                       LDA.B #$05                           ;81E8E9;      ;
                       STA.W $096F                          ;81E8EB;00096F;
                       JMP.W CODE_81EBD4                    ;81E8EE;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E8F1: %Set16bit(!MX)                             ;81E8F1;      ;
                       LDX.W #$0487                         ;81E8F3;      ;
                       %Set8bit(!M)                             ;81E8F6;      ;
                       LDA.B #$02                           ;81E8F8;      ;
                       STA.W !inputstate                          ;81E8FA;00019A;
                       LDA.B #$00                           ;81E8FD;      ;
                       STA.W $0191                          ;81E8FF;000191;
                       JSL.L StartTextBox                    ;81E902;83935F;
                       %Set8bit(!M)                             ;81E906;      ;
                       LDA.B #$05                           ;81E908;      ;
                       STA.W $096F                          ;81E90A;00096F;
                       JMP.W CODE_81EBD4                    ;81E90D;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E910: %Set8bit(!M)                             ;81E910;      ;
                       LDA.W !inputstate                          ;81E912;00019A;
                       CMP.B #$02                           ;81E915;      ;
                       BNE CODE_81E91C                      ;81E917;81E91C;
                       JMP.W CODE_81EBD4                    ;81E919;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E91C: %Set8bit(!M)                             ;81E91C;      ;
                       LDA.W $018F                          ;81E91E;00018F;
                       BNE CODE_81E940                      ;81E921;81E940;
                       %Set8bit(!M)                             ;81E923;      ;
                       LDA.B #$02                           ;81E925;      ;
                       STA.W !inputstate                          ;81E927;00019A;
                       LDX.W #$030F                         ;81E92A;      ;
                       LDA.B #$00                           ;81E92D;      ;
                       STA.W $0191                          ;81E92F;000191;
                       JSL.L StartTextBox                    ;81E932;83935F;
                       %Set8bit(!M)                             ;81E936;      ;
                       LDA.B #$03                           ;81E938;      ;
                       STA.W $096F                          ;81E93A;00096F;
                       JMP.W CODE_81EBD4                    ;81E93D;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E940: %Set8bit(!M)                             ;81E940;      ;
                       LDA.B #$02                           ;81E942;      ;
                       STA.W !inputstate                          ;81E944;00019A;
                       LDX.W #$0309                         ;81E947;      ;
                       LDA.B #$00                           ;81E94A;      ;
                       STA.W $0191                          ;81E94C;000191;
                       JSL.L StartTextBox                    ;81E94F;83935F;
                       %Set8bit(!M)                             ;81E953;      ;
                       LDA.B #$05                           ;81E955;      ;
                       STA.W $096F                          ;81E957;00096F;
                       JMP.W CODE_81EBD4                    ;81E95A;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E95D: %Set8bit(!M)                             ;81E95D;      ;
                       LDA.W !inputstate                          ;81E95F;00019A;
                       CMP.B #$02                           ;81E962;      ;
                       BNE CODE_81E969                      ;81E964;81E969;
                       JMP.W CODE_81EBD4                    ;81E966;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E969: %Set16bit(!M)                             ;81E969;      ;
                       LDA.L $7F1F15                        ;81E96B;7F1F15;
                       STA.B $72                            ;81E96F;000072;
                       %Set8bit(!M)                             ;81E971;      ;
                       LDA.L $7F1F17                        ;81E973;7F1F17;
                       STA.B $74                            ;81E977;000074;
                       JSL.L AddMoney                       ;81E979;83B1C9;
                       %Set16bit(!M)                             ;81E97D;      ;
                       LDA.W #$0007                         ;81E97F;      ;
                       JSL.L SUB_848020                    ;81E982;848020;
                       %Set16bit(!M)                             ;81E986;      ;
                       LDA.W #$0007                         ;81E988;      ;
                       LDX.W #$0000                         ;81E98B;      ;
                       LDY.W #$0023                         ;81E98E;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81E991;848097;
                       %Set8bit(!M)                             ;81E995;      ;
                       LDA.B #$00                           ;81E997;      ;
                       XBA                                  ;81E999;      ;
                       LDA.W $09A0                          ;81E99A;0009A0;
                       LDX.W #$0000                         ;81E99D;      ;
                       LDY.W #$0022                         ;81E9A0;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81E9A3;84803F;
                       %Set8bit(!M)                             ;81E9A7;      ;
                       LDA.B #$00                           ;81E9A9;      ;
                       XBA                                  ;81E9AB;      ;
                       LDA.W $09A0                          ;81E9AC;0009A0;
                       SEC                                  ;81E9AF;      ;
                       SBC.B #$18                           ;81E9B0;      ;
                       %Set16bit(!M)                             ;81E9B2;      ;
                       JSL.L GetsCowPointer                ;81E9B4;83C9A7;
                       %Set8bit(!M)                             ;81E9B8;      ;
                       LDY.W #$0000                         ;81E9BA;      ;
                       LDA.B #$00                           ;81E9BD;      ;
                       STA.B [$72],Y                        ;81E9BF;000072;
                       %Set8bit(!M)                             ;81E9C1;      ;
                       LDA.L !cow_N                        ;81E9C3;7F1F0A;
                       DEC A                                ;81E9C7;      ;
                       STA.L !cow_N                        ;81E9C8;7F1F0A;
                       %Set8bit(!M)                             ;81E9CC;      ;
                       LDA.B #$04                           ;81E9CE;      ;
                       STA.W $096F                          ;81E9D0;00096F;
                       STZ.W $0970                          ;81E9D3;000970;
                       %Set16bit(!M)                             ;81E9D6;      ;
                       LDA.W #$FFCE                         ;81E9D8;      ;
                       JSL.L AddPlayerHappiness                   ;81E9DB;83B282;
                       JMP.W CODE_81EBD4                    ;81E9DF;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E9E2: %Set8bit(!M)                             ;81E9E2;      ;
                       INC.W $0970                          ;81E9E4;000970;
                       LDA.W $0970                          ;81E9E7;000970;
                       CMP.B #$42                           ;81E9EA;      ;
                       BEQ CODE_81E9F1                      ;81E9EC;81E9F1;
                       JMP.W CODE_81EBD4                    ;81E9EE;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81E9F1: STZ.W $0970                          ;81E9F1;000970;
                       %Set16bit(!M)                             ;81E9F4;      ;
                       LDA.L $7F1F60                        ;81E9F6;7F1F60;
                       AND.W #$2000                         ;81E9FA;      ;
                       BEQ CODE_81EA02                      ;81E9FD;81EA02;
                       JMP.W CODE_81E84D                    ;81E9FF;81E84D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA02: %Set16bit(!MX)                             ;81EA02;      ;
                       LDA.W #$0040                         ;81EA04;      ;
                       EOR.W #$FFFF                         ;81EA07;      ;
                       AND.B !game_state                            ;81EA0A;0000D2;
                       STA.B !game_state                            ;81EA0C;0000D2;
                       JMP.W CODE_81EBD4                    ;81EA0E;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA11: %Set8bit(!M)                             ;81EA11;      ;
                       LDA.W !inputstate                          ;81EA13;00019A;
                       CMP.B #$02                           ;81EA16;      ;
                       BNE CODE_81EA1D                      ;81EA18;81EA1D;
                       JMP.W CODE_81EBD4                    ;81EA1A;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA1D: %Set16bit(!M)                             ;81EA1D;      ;
                       LDA.W #$0007                         ;81EA1F;      ;
                       JSL.L SUB_848020                    ;81EA22;848020;
                       %Set16bit(!M)                             ;81EA26;      ;
                       LDA.W #$0007                         ;81EA28;      ;
                       LDX.W #$0000                         ;81EA2B;      ;
                       LDY.W #$0023                         ;81EA2E;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EA31;848097;
                       %Set8bit(!M)                             ;81EA35;      ;
                       LDA.B #$06                           ;81EA37;      ;
                       STA.W $096F                          ;81EA39;00096F;
                       STZ.W $0970                          ;81EA3C;000970;
                       JMP.W CODE_81EBD4                    ;81EA3F;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA42: %Set8bit(!M)                             ;81EA42;      ;
                       INC.W $0970                          ;81EA44;000970;
                       LDA.W $0970                          ;81EA47;000970;
                       CMP.B #$40                           ;81EA4A;      ;
                       BEQ CODE_81EA51                      ;81EA4C;81EA51;
                       JMP.W CODE_81EBD4                    ;81EA4E;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA51: %Set16bit(!MX)                             ;81EA51;      ;
                       LDA.W #$0040                         ;81EA53;      ;
                       EOR.W #$FFFF                         ;81EA56;      ;
                       AND.B !game_state                            ;81EA59;0000D2;
                       STA.B !game_state                            ;81EA5B;0000D2;
                       %Set16bit(!M)                             ;81EA5D;      ;
                       LDA.L $7F1F60                        ;81EA5F;7F1F60;
                       AND.W #$2000                         ;81EA63;      ;
                       BEQ CODE_81EA6B                      ;81EA66;81EA6B;
                       JMP.W CODE_81EBD4                    ;81EA68;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA6B: %Set8bit(!M)                             ;81EA6B;      ;
                       LDA.B #$00                           ;81EA6D;      ;
                       XBA                                  ;81EA6F;      ;
                       LDA.W $09A0                          ;81EA70;0009A0;
                       JSL.L SetCCPoiner                   ;81EA73;84887C;
                       %Set8bit(!M)                             ;81EA77;      ;
                       %Set16bit(!X)                             ;81EA79;      ;
                       LDY.W #$0001                         ;81EA7B;      ;
                       LDA.B [$CC],Y                        ;81EA7E;0000CC;
                       ORA.B #$A8                           ;81EA80;      ;
                       %Set8bit(!M)                             ;81EA82;      ;
                       %Set16bit(!X)                             ;81EA84;      ;
                       LDY.W #$0001                         ;81EA86;      ;
                       STA.B [$CC],Y                        ;81EA89;0000CC;
                       JMP.W CODE_81EBD4                    ;81EA8B;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA8E: %Set8bit(!M)                             ;81EA8E;      ;
                       INC.W $0970                          ;81EA90;000970;
                       LDA.W $0970                          ;81EA93;000970;
                       CMP.B #$42                           ;81EA96;      ;
                       BEQ CODE_81EA9D                      ;81EA98;81EA9D;
                       JMP.W CODE_81EBD4                    ;81EA9A;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EA9D: LDX.W #$0149                         ;81EA9D;      ;
                       %Set8bit(!M)                             ;81EAA0;      ;
                       LDA.B #$02                           ;81EAA2;      ;
                       STA.W !inputstate                          ;81EAA4;00019A;
                       LDA.B #$00                           ;81EAA7;      ;
                       STA.W $0191                          ;81EAA9;000191;
                       JSL.L StartTextBox                    ;81EAAC;83935F;
                       %Set8bit(!M)                             ;81EAB0;      ;
                       LDA.B #$08                           ;81EAB2;      ;
                       STA.W $096F                          ;81EAB4;00096F;
                       JMP.W CODE_81EBD4                    ;81EAB7;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EABA: %Set8bit(!M)                             ;81EABA;      ;
                       LDA.W !inputstate                          ;81EABC;00019A;
                       CMP.B #$02                           ;81EABF;      ;
                       BNE CODE_81EAC6                      ;81EAC1;81EAC6;
                       JMP.W CODE_81EBD4                    ;81EAC3;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EAC6: %Set8bit(!M)                             ;81EAC6;      ;
                       LDA.W $018F                          ;81EAC8;00018F;
                       BNE CODE_81EAEA                      ;81EACB;81EAEA;
                       %Set8bit(!M)                             ;81EACD;      ;
                       LDA.B #$02                           ;81EACF;      ;
                       STA.W !inputstate                          ;81EAD1;00019A;
                       LDX.W #$014B                         ;81EAD4;      ;
                       LDA.B #$00                           ;81EAD7;      ;
                       STA.W $0191                          ;81EAD9;000191;
                       JSL.L StartTextBox                    ;81EADC;83935F;
                       %Set8bit(!M)                             ;81EAE0;      ;
                       LDA.B #$09                           ;81EAE2;      ;
                       STA.W $096F                          ;81EAE4;00096F;
                       JMP.W CODE_81EBD4                    ;81EAE7;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EAEA: %Set8bit(!M)                             ;81EAEA;      ;
                       LDA.B #$02                           ;81EAEC;      ;
                       STA.W !inputstate                          ;81EAEE;00019A;
                       LDX.W #$014C                         ;81EAF1;      ;
                       LDA.B #$00                           ;81EAF4;      ;
                       STA.W $0191                          ;81EAF6;000191;
                       JSL.L StartTextBox                    ;81EAF9;83935F;
                       %Set8bit(!M)                             ;81EAFD;      ;
                       LDA.B #$0A                           ;81EAFF;      ;
                       STA.W $096F                          ;81EB01;00096F;
                       JMP.W CODE_81EBD4                    ;81EB04;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EB07: %Set8bit(!M)                             ;81EB07;      ;
                       LDA.W !inputstate                          ;81EB09;00019A;
                       CMP.B #$02                           ;81EB0C;      ;
                       BNE CODE_81EB13                      ;81EB0E;81EB13;
                       JMP.W CODE_81EBD4                    ;81EB10;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EB13: %Set16bit(!M)                             ;81EB13;      ;
                       LDA.W #$0008                         ;81EB15;      ;
                       JSL.L SUB_848020                    ;81EB18;848020;
                       %Set16bit(!M)                             ;81EB1C;      ;
                       LDA.W #$0008                         ;81EB1E;      ;
                       LDX.W #$0000                         ;81EB21;      ;
                       LDY.W #$007D                         ;81EB24;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EB27;848097;
                       %Set8bit(!M)                             ;81EB2B;      ;
                       LDA.B #$00                           ;81EB2D;      ;
                       XBA                                  ;81EB2F;      ;
                       LDA.W $09A0                          ;81EB30;0009A0;
                       LDX.W #$0000                         ;81EB33;      ;
                       LDY.W #$0022                         ;81EB36;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81EB39;84803F;
                       %Set8bit(!M)                             ;81EB3D;      ;
                       LDA.B #$00                           ;81EB3F;      ;
                       XBA                                  ;81EB41;      ;
                       LDA.W $09A0                          ;81EB42;0009A0;
                       SEC                                  ;81EB45;      ;
                       SBC.B #$18                           ;81EB46;      ;
                       %Set16bit(!M)                             ;81EB48;      ;
                       JSL.L GetsCowPointer                ;81EB4A;83C9A7;
                       %Set8bit(!M)                             ;81EB4E;      ;
                       LDY.W #$0000                         ;81EB50;      ;
                       LDA.B #$00                           ;81EB53;      ;
                       STA.B [$72],Y                        ;81EB55;000072;
                       %Set8bit(!M)                             ;81EB57;      ;
                       LDA.L !cow_N                        ;81EB59;7F1F0A;
                       DEC A                                ;81EB5D;      ;
                       STA.L !cow_N                        ;81EB5E;7F1F0A;
                       %Set8bit(!M)                             ;81EB62;      ;
                       LDA.B #$04                           ;81EB64;      ;
                       STA.W $096F                          ;81EB66;00096F;
                       STZ.W $0970                          ;81EB69;000970;
                       LDA.L !shed_items_row_3                        ;81EB6C;7F1F02;
                       ORA.B #$20                           ;81EB70;      ;
                       STA.L !shed_items_row_3                        ;81EB72;7F1F02;
                       %Set16bit(!M)                             ;81EB76;      ;
                       LDA.W #$FFCE                         ;81EB78;      ;
                       JSL.L AddPlayerHappiness                   ;81EB7B;83B282;
                       %Set16bit(!M)                             ;81EB7F;      ;
                       LDA.L $7F1F60                        ;81EB81;7F1F60;
                       ORA.W #$2000                         ;81EB85;      ;
                       STA.L $7F1F60                        ;81EB88;7F1F60;
                       JMP.W CODE_81EBD4                    ;81EB8C;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EB8F: %Set8bit(!M)                             ;81EB8F;      ;
                       LDA.W !inputstate                          ;81EB91;00019A;
                       CMP.B #$02                           ;81EB94;      ;
                       BNE CODE_81EB9B                      ;81EB96;81EB9B;
                       JMP.W CODE_81EBD4                    ;81EB98;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EB9B: %Set16bit(!M)                             ;81EB9B;      ;
                       LDA.W #$0008                         ;81EB9D;      ;
                       JSL.L SUB_848020                    ;81EBA0;848020;
                       %Set16bit(!M)                             ;81EBA4;      ;
                       LDA.W #$0008                         ;81EBA6;      ;
                       LDX.W #$0000                         ;81EBA9;      ;
                       LDY.W #$007D                         ;81EBAC;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EBAF;848097;
                       %Set8bit(!M)                             ;81EBB3;      ;
                       LDA.B #$0B                           ;81EBB5;      ;
                       STA.W $096F                          ;81EBB7;00096F;
                       STZ.W $0970                          ;81EBBA;000970;
                       BRA CODE_81EBD4                      ;81EBBD;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBBF: %Set8bit(!M)                             ;81EBBF;      ;
                       INC.W $0970                          ;81EBC1;000970;
                       LDA.W $0970                          ;81EBC4;000970;
                       CMP.B #$42                           ;81EBC7;      ;
                       BEQ CODE_81EBCE                      ;81EBC9;81EBCE;
                       JMP.W CODE_81EBD4                    ;81EBCB;81EBD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBCE: STZ.W $0970                          ;81EBCE;000970;
                       JMP.W CODE_81E84D                    ;81EBD1;81E84D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBD4: RTS                                  ;81EBD4;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81EBD5;      ;
                       %Set16bit(!X)                             ;81EBD7;      ;
                       LDA.W $096F                          ;81EBD9;00096F;
                       CMP.B #$01                           ;81EBDC;      ;
                       BNE CODE_81EBE3                      ;81EBDE;81EBE3;
                       JMP.W CODE_81EC7D                    ;81EBE0;81EC7D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBE3: CMP.B #$02                           ;81EBE3;      ;
                       BNE CODE_81EBEA                      ;81EBE5;81EBEA;
                       JMP.W CODE_81ECD3                    ;81EBE7;81ECD3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBEA: CMP.B #$03                           ;81EBEA;      ;
                       BNE CODE_81EBF1                      ;81EBEC;81EBF1;
                       JMP.W CODE_81ED20                    ;81EBEE;81ED20;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBF1: CMP.B #$04                           ;81EBF1;      ;
                       BNE CODE_81EBF8                      ;81EBF3;81EBF8;
                       JMP.W CODE_81EDA5                    ;81EBF5;81EDA5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBF8: CMP.B #$05                           ;81EBF8;      ;
                       BNE CODE_81EBFF                      ;81EBFA;81EBFF;
                       JMP.W CODE_81EDD4                    ;81EBFC;81EDD4;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EBFF: CMP.B #$06                           ;81EBFF;      ;
                       BNE CODE_81EC06                      ;81EC01;81EC06;
                       JMP.W CODE_81EE05                    ;81EC03;81EE05;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC06: CMP.B #$07                           ;81EC06;      ;
                       BNE CODE_81EC0D                      ;81EC08;81EC0D;
                       JMP.W CODE_81EE51                    ;81EC0A;81EE51;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC0D: CMP.B #$08                           ;81EC0D;      ;
                       BNE CODE_81EC14                      ;81EC0F;81EC14;
                       JMP.W CODE_81EE7D                    ;81EC11;81EE7D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC14: CMP.B #$09                           ;81EC14;      ;
                       BNE CODE_81EC1B                      ;81EC16;81EC1B;
                       JMP.W CODE_81EECA                    ;81EC18;81EECA;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC1B: CMP.B #$0A                           ;81EC1B;      ;
                       BNE CODE_81EC22                      ;81EC1D;81EC22;
                       JMP.W CODE_81EF67                    ;81EC1F;81EF67;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC22: CMP.B #$0B                           ;81EC22;      ;
                       BNE CODE_81EC29                      ;81EC24;81EC29;
                       JMP.W CODE_81EF97                    ;81EC26;81EF97;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC29: %Set8bit(!M)                             ;81EC29;      ;
                       LDA.L !season                        ;81EC2B;7F1F19;
                       CMP.B #$02                           ;81EC2F;      ;
                       BNE CODE_81EC64                      ;81EC31;81EC64;
                       %Set16bit(!MX)                             ;81EC33;      ;
                       LDA.L $7F1F66                        ;81EC35;7F1F66;
                       AND.W #$4000                         ;81EC39;      ;
                       BNE CODE_81EC64                      ;81EC3C;81EC64;
                       %Set16bit(!M)                             ;81EC3E;      ;
                       LDA.L $7F1F66                        ;81EC40;7F1F66;
                       ORA.W #$4000                         ;81EC44;      ;
                       STA.L $7F1F66                        ;81EC47;7F1F66;
                       %Set16bit(!M)                             ;81EC4B;      ;
                       LDA.W #$0008                         ;81EC4D;      ;
                       LDX.W #$0000                         ;81EC50;      ;
                       LDY.W #$007C                         ;81EC53;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EC56;848097;
                       %Set8bit(!M)                             ;81EC5A;      ;
                       LDA.B #$07                           ;81EC5C;      ;
                       STA.W $096F                          ;81EC5E;00096F;
                       JMP.W CODE_81EFAC                    ;81EC61;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC64: %Set16bit(!M)                             ;81EC64;      ;
                       LDA.W #$0007                         ;81EC66;      ;
                       LDX.W #$0000                         ;81EC69;      ;
                       LDY.W #$0021                         ;81EC6C;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EC6F;848097;
                       %Set8bit(!M)                             ;81EC73;      ;
                       LDA.B #$01                           ;81EC75;      ;
                       STA.W $096F                          ;81EC77;00096F;
                       JMP.W CODE_81EFAC                    ;81EC7A;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC7D: %Set8bit(!M)                             ;81EC7D;      ;
                       INC.W $0970                          ;81EC7F;000970;
                       LDA.W $0970                          ;81EC82;000970;
                       CMP.B #$42                           ;81EC85;      ;
                       BEQ CODE_81EC8C                      ;81EC87;81EC8C;
                       JMP.W CODE_81EFAC                    ;81EC89;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EC8C: %Set16bit(!M)                             ;81EC8C;      ;
                       LDA.L $7F1F60                        ;81EC8E;7F1F60;
                       AND.W #$1000                         ;81EC92;      ;
                       BNE CODE_81ECB4                      ;81EC95;81ECB4;
                       LDX.W #$030E                         ;81EC97;      ;
                       %Set8bit(!M)                             ;81EC9A;      ;
                       LDA.B #$02                           ;81EC9C;      ;
                       STA.W !inputstate                          ;81EC9E;00019A;
                       LDA.B #$00                           ;81ECA1;      ;
                       STA.W $0191                          ;81ECA3;000191;
                       JSL.L StartTextBox                    ;81ECA6;83935F;
                       %Set8bit(!M)                             ;81ECAA;      ;
                       LDA.B #$02                           ;81ECAC;      ;
                       STA.W $096F                          ;81ECAE;00096F;
                       JMP.W CODE_81EFAC                    ;81ECB1;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81ECB4: %Set16bit(!MX)                             ;81ECB4;      ;
                       LDX.W #$0487                         ;81ECB6;      ;
                       %Set8bit(!M)                             ;81ECB9;      ;
                       LDA.B #$02                           ;81ECBB;      ;
                       STA.W !inputstate                          ;81ECBD;00019A;
                       LDA.B #$00                           ;81ECC0;      ;
                       STA.W $0191                          ;81ECC2;000191;
                       JSL.L StartTextBox                    ;81ECC5;83935F;
                       %Set8bit(!M)                             ;81ECC9;      ;
                       LDA.B #$05                           ;81ECCB;      ;
                       STA.W $096F                          ;81ECCD;00096F;
                       JMP.W CODE_81EFAC                    ;81ECD0;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81ECD3: %Set8bit(!M)                             ;81ECD3;      ;
                       LDA.W !inputstate                          ;81ECD5;00019A;
                       CMP.B #$02                           ;81ECD8;      ;
                       BNE CODE_81ECDF                      ;81ECDA;81ECDF;
                       JMP.W CODE_81EFAC                    ;81ECDC;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81ECDF: %Set8bit(!M)                             ;81ECDF;      ;
                       LDA.W $018F                          ;81ECE1;00018F;
                       BNE CODE_81ED03                      ;81ECE4;81ED03;
                       %Set8bit(!M)                             ;81ECE6;      ;
                       LDA.B #$02                           ;81ECE8;      ;
                       STA.W !inputstate                          ;81ECEA;00019A;
                       LDX.W #$030F                         ;81ECED;      ;
                       LDA.B #$00                           ;81ECF0;      ;
                       STA.W $0191                          ;81ECF2;000191;
                       JSL.L StartTextBox                    ;81ECF5;83935F;
                       %Set8bit(!M)                             ;81ECF9;      ;
                       LDA.B #$03                           ;81ECFB;      ;
                       STA.W $096F                          ;81ECFD;00096F;
                       JMP.W CODE_81EFAC                    ;81ED00;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81ED03: %Set8bit(!M)                             ;81ED03;      ;
                       LDA.B #$02                           ;81ED05;      ;
                       STA.W !inputstate                          ;81ED07;00019A;
                       LDX.W #$0309                         ;81ED0A;      ;
                       LDA.B #$00                           ;81ED0D;      ;
                       STA.W $0191                          ;81ED0F;000191;
                       JSL.L StartTextBox                    ;81ED12;83935F;
                       %Set8bit(!M)                             ;81ED16;      ;
                       LDA.B #$05                           ;81ED18;      ;
                       STA.W $096F                          ;81ED1A;00096F;
                       JMP.W CODE_81EFAC                    ;81ED1D;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81ED20: %Set8bit(!M)                             ;81ED20;      ;
                       LDA.W !inputstate                          ;81ED22;00019A;
                       CMP.B #$02                           ;81ED25;      ;
                       BNE CODE_81ED2C                      ;81ED27;81ED2C;
                       JMP.W CODE_81EFAC                    ;81ED29;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81ED2C: %Set16bit(!M)                             ;81ED2C;      ;
                       LDA.L $7F1F15                        ;81ED2E;7F1F15;
                       STA.B $72                            ;81ED32;000072;
                       %Set8bit(!M)                             ;81ED34;      ;
                       LDA.L $7F1F17                        ;81ED36;7F1F17;
                       STA.B $74                            ;81ED3A;000074;
                       JSL.L AddMoney                       ;81ED3C;83B1C9;
                       %Set16bit(!M)                             ;81ED40;      ;
                       LDA.W #$0007                         ;81ED42;      ;
                       JSL.L SUB_848020                    ;81ED45;848020;
                       %Set16bit(!M)                             ;81ED49;      ;
                       LDA.W #$0007                         ;81ED4B;      ;
                       LDX.W #$0000                         ;81ED4E;      ;
                       LDY.W #$0023                         ;81ED51;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81ED54;848097;
                       %Set8bit(!M)                             ;81ED58;      ;
                       LDA.B #$00                           ;81ED5A;      ;
                       XBA                                  ;81ED5C;      ;
                       LDA.W $09A1                          ;81ED5D;0009A1;
                       LDX.W #$0000                         ;81ED60;      ;
                       LDY.W #$0024                         ;81ED63;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81ED66;84803F;
                       %Set8bit(!M)                             ;81ED6A;      ;
                       LDA.B #$00                           ;81ED6C;      ;
                       XBA                                  ;81ED6E;      ;
                       LDA.W $09A1                          ;81ED6F;0009A1;
                       SEC                                  ;81ED72;      ;
                       SBC.B #$24                           ;81ED73;      ;
                       %Set16bit(!M)                             ;81ED75;      ;
                       JSL.L GetChickenPointer          ;81ED77;83C995;
                       %Set8bit(!M)                             ;81ED7B;      ;
                       LDY.W #$0000                         ;81ED7D;      ;
                       LDA.B #$00                           ;81ED80;      ;
                       STA.B [$72],Y                        ;81ED82;000072;
                       %Set8bit(!M)                             ;81ED84;      ;
                       LDA.L !chicks_N                        ;81ED86;7F1F0B;
                       DEC A                                ;81ED8A;      ;
                       STA.L !chicks_N                        ;81ED8B;7F1F0B;
                       %Set8bit(!M)                             ;81ED8F;      ;
                       LDA.B #$04                           ;81ED91;      ;
                       STA.W $096F                          ;81ED93;00096F;
                       STZ.W $0970                          ;81ED96;000970;
                       %Set16bit(!M)                             ;81ED99;      ;
                       LDA.W #$FFEC                         ;81ED9B;      ;
                       JSL.L AddPlayerHappiness                   ;81ED9E;83B282;
                       JMP.W CODE_81EFAC                    ;81EDA2;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EDA5: %Set8bit(!M)                             ;81EDA5;      ;
                       INC.W $0970                          ;81EDA7;000970;
                       LDA.W $0970                          ;81EDAA;000970;
                       CMP.B #$42                           ;81EDAD;      ;
                       BEQ CODE_81EDB4                      ;81EDAF;81EDB4;
                       JMP.W CODE_81EFAC                    ;81EDB1;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EDB4: STZ.W $0970                          ;81EDB4;000970;
                       %Set16bit(!M)                             ;81EDB7;      ;
                       LDA.L $7F1F60                        ;81EDB9;7F1F60;
                       AND.W #$1000                         ;81EDBD;      ;
                       BEQ CODE_81EDC5                      ;81EDC0;81EDC5;
                       JMP.W CODE_81EC64                    ;81EDC2;81EC64;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EDC5: %Set16bit(!MX)                             ;81EDC5;      ;
                       LDA.W #$0040                         ;81EDC7;      ;
                       EOR.W #$FFFF                         ;81EDCA;      ;
                       AND.B !game_state                            ;81EDCD;0000D2;
                       STA.B !game_state                            ;81EDCF;0000D2;
                       JMP.W CODE_81EFAC                    ;81EDD1;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EDD4: %Set8bit(!M)                             ;81EDD4;      ;
                       LDA.W !inputstate                          ;81EDD6;00019A;
                       CMP.B #$02                           ;81EDD9;      ;
                       BNE CODE_81EDE0                      ;81EDDB;81EDE0;
                       JMP.W CODE_81EFAC                    ;81EDDD;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EDE0: %Set16bit(!M)                             ;81EDE0;      ;
                       LDA.W #$0007                         ;81EDE2;      ;
                       JSL.L SUB_848020                    ;81EDE5;848020;
                       %Set16bit(!M)                             ;81EDE9;      ;
                       LDA.W #$0007                         ;81EDEB;      ;
                       LDX.W #$0000                         ;81EDEE;      ;
                       LDY.W #$0023                         ;81EDF1;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EDF4;848097;
                       %Set8bit(!M)                             ;81EDF8;      ;
                       LDA.B #$06                           ;81EDFA;      ;
                       STA.W $096F                          ;81EDFC;00096F;
                       STZ.W $0970                          ;81EDFF;000970;
                       JMP.W CODE_81EFAC                    ;81EE02;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE05: %Set8bit(!M)                             ;81EE05;      ;
                       INC.W $0970                          ;81EE07;000970;
                       LDA.W $0970                          ;81EE0A;000970;
                       CMP.B #$42                           ;81EE0D;      ;
                       BEQ CODE_81EE14                      ;81EE0F;81EE14;
                       JMP.W CODE_81EFAC                    ;81EE11;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE14: %Set16bit(!MX)                             ;81EE14;      ;
                       LDA.W #$0040                         ;81EE16;      ;
                       EOR.W #$FFFF                         ;81EE19;      ;
                       AND.B !game_state                            ;81EE1C;0000D2;
                       STA.B !game_state                            ;81EE1E;0000D2;
                       %Set16bit(!M)                             ;81EE20;      ;
                       LDA.L $7F1F60                        ;81EE22;7F1F60;
                       AND.W #$1000                         ;81EE26;      ;
                       BEQ CODE_81EE2E                      ;81EE29;81EE2E;
                       JMP.W CODE_81EFAC                    ;81EE2B;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE2E: %Set8bit(!M)                             ;81EE2E;      ;
                       LDA.B #$00                           ;81EE30;      ;
                       XBA                                  ;81EE32;      ;
                       LDA.W $09A1                          ;81EE33;0009A1;
                       JSL.L SetCCPoiner                   ;81EE36;84887C;
                       %Set8bit(!M)                             ;81EE3A;      ;
                       %Set16bit(!X)                             ;81EE3C;      ;
                       LDY.W #$0001                         ;81EE3E;      ;
                       LDA.B [$CC],Y                        ;81EE41;0000CC;
                       ORA.B #$A8                           ;81EE43;      ;
                       %Set8bit(!M)                             ;81EE45;      ;
                       %Set16bit(!X)                             ;81EE47;      ;
                       LDY.W #$0001                         ;81EE49;      ;
                       STA.B [$CC],Y                        ;81EE4C;0000CC;
                       JMP.W CODE_81EFAC                    ;81EE4E;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE51: %Set8bit(!M)                             ;81EE51;      ;
                       INC.W $0970                          ;81EE53;000970;
                       LDA.W $0970                          ;81EE56;000970;
                       CMP.B #$42                           ;81EE59;      ;
                       BEQ CODE_81EE60                      ;81EE5B;81EE60;
                       JMP.W CODE_81EFAC                    ;81EE5D;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE60: LDX.W #$0148                         ;81EE60;      ;
                       %Set8bit(!M)                             ;81EE63;      ;
                       LDA.B #$02                           ;81EE65;      ;
                       STA.W !inputstate                          ;81EE67;00019A;
                       LDA.B #$00                           ;81EE6A;      ;
                       STA.W $0191                          ;81EE6C;000191;
                       JSL.L StartTextBox                    ;81EE6F;83935F;
                       %Set8bit(!M)                             ;81EE73;      ;
                       LDA.B #$08                           ;81EE75;      ;
                       STA.W $096F                          ;81EE77;00096F;
                       JMP.W CODE_81EFAC                    ;81EE7A;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE7D: %Set8bit(!M)                             ;81EE7D;      ;
                       LDA.W !inputstate                          ;81EE7F;00019A;
                       CMP.B #$02                           ;81EE82;      ;
                       BNE CODE_81EE89                      ;81EE84;81EE89;
                       JMP.W CODE_81EFAC                    ;81EE86;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EE89: %Set8bit(!M)                             ;81EE89;      ;
                       LDA.W $018F                          ;81EE8B;00018F;
                       BNE CODE_81EEAD                      ;81EE8E;81EEAD;
                       %Set8bit(!M)                             ;81EE90;      ;
                       LDA.B #$02                           ;81EE92;      ;
                       STA.W !inputstate                          ;81EE94;00019A;
                       LDX.W #$014A                         ;81EE97;      ;
                       LDA.B #$00                           ;81EE9A;      ;
                       STA.W $0191                          ;81EE9C;000191;
                       JSL.L StartTextBox                    ;81EE9F;83935F;
                       %Set8bit(!M)                             ;81EEA3;      ;
                       LDA.B #$09                           ;81EEA5;      ;
                       STA.W $096F                          ;81EEA7;00096F;
                       JMP.W CODE_81EFAC                    ;81EEAA;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EEAD: %Set8bit(!M)                             ;81EEAD;      ;
                       LDA.B #$02                           ;81EEAF;      ;
                       STA.W !inputstate                          ;81EEB1;00019A;
                       LDX.W #$014C                         ;81EEB4;      ;
                       LDA.B #$00                           ;81EEB7;      ;
                       STA.W $0191                          ;81EEB9;000191;
                       JSL.L StartTextBox                    ;81EEBC;83935F;
                       %Set8bit(!M)                             ;81EEC0;      ;
                       LDA.B #$0A                           ;81EEC2;      ;
                       STA.W $096F                          ;81EEC4;00096F;
                       JMP.W CODE_81EFAC                    ;81EEC7;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EECA: %Set8bit(!M)                             ;81EECA;      ;
                       LDA.W !inputstate                          ;81EECC;00019A;
                       CMP.B #$02                           ;81EECF;      ;
                       BNE CODE_81EED6                      ;81EED1;81EED6;
                       JMP.W CODE_81EFAC                    ;81EED3;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EED6: %Set16bit(!M)                             ;81EED6;      ;
                       LDA.W #$0008                         ;81EED8;      ;
                       JSL.L SUB_848020                    ;81EEDB;848020;
                       %Set16bit(!M)                             ;81EEDF;      ;
                       LDA.W #$0008                         ;81EEE1;      ;
                       LDX.W #$0000                         ;81EEE4;      ;
                       LDY.W #$007D                         ;81EEE7;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EEEA;848097;
                       %Set8bit(!M)                             ;81EEEE;      ;
                       LDA.B #$00                           ;81EEF0;      ;
                       XBA                                  ;81EEF2;      ;
                       LDA.W $09A1                          ;81EEF3;0009A1;
                       LDX.W #$0000                         ;81EEF6;      ;
                       LDY.W #$0024                         ;81EEF9;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81EEFC;84803F;
                       %Set8bit(!M)                             ;81EF00;      ;
                       LDA.B #$00                           ;81EF02;      ;
                       XBA                                  ;81EF04;      ;
                       LDA.W $09A1                          ;81EF05;0009A1;
                       SEC                                  ;81EF08;      ;
                       SBC.B #$24                           ;81EF09;      ;
                       %Set16bit(!M)                             ;81EF0B;      ;
                       JSL.L GetChickenPointer          ;81EF0D;83C995;
                       %Set8bit(!M)                             ;81EF11;      ;
                       LDY.W #$0000                         ;81EF13;      ;
                       LDA.B #$00                           ;81EF16;      ;
                       STA.B [$72],Y                        ;81EF18;000072;
                       %Set8bit(!M)                             ;81EF1A;      ;
                       LDA.L !chicks_N                        ;81EF1C;7F1F0B;
                       DEC A                                ;81EF20;      ;
                       STA.L !chicks_N                        ;81EF21;7F1F0B;
                       %Set8bit(!M)                             ;81EF25;      ;
                       LDA.B #$04                           ;81EF27;      ;
                       STA.W $096F                          ;81EF29;00096F;
                       STZ.W $0970                          ;81EF2C;000970;
                       %Set16bit(!MX)                             ;81EF2F;      ;
                       LDY.W #$0004                         ;81EF31;      ;
                       LDA.B [$72],Y                        ;81EF34;000072;
                       STA.W !tile_in_front_X                          ;81EF36;000985;
                       LDY.W #$0006                         ;81EF39;      ;
                       LDA.B [$72],Y                        ;81EF3C;000072;
                       STA.W !tile_in_front_Y                          ;81EF3E;000987;
                       LDA.W #$0010                         ;81EF41;      ;
                       LDX.W #$0000                         ;81EF44;      ;
                       LDY.W #$001F                         ;81EF47;      ;
                       JSL.L SUB_8480F8                    ;81EF4A;8480F8;
                       %Set16bit(!MX)                             ;81EF4E;      ;
                       LDA.W #$FFEC                         ;81EF50;      ;
                       JSL.L AddPlayerHappiness                   ;81EF53;83B282;
                       %Set16bit(!M)                             ;81EF57;      ;
                       LDA.L $7F1F60                        ;81EF59;7F1F60;
                       ORA.W #$1000                         ;81EF5D;      ;
                       STA.L $7F1F60                        ;81EF60;7F1F60;
                       JMP.W CODE_81EFAC                    ;81EF64;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EF67: %Set8bit(!M)                             ;81EF67;      ;
                       LDA.W !inputstate                          ;81EF69;00019A;
                       CMP.B #$02                           ;81EF6C;      ;
                       BNE CODE_81EF73                      ;81EF6E;81EF73;
                       JMP.W CODE_81EFAC                    ;81EF70;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EF73: %Set16bit(!M)                             ;81EF73;      ;
                       LDA.W #$0008                         ;81EF75;      ;
                       JSL.L SUB_848020                    ;81EF78;848020;
                       %Set16bit(!M)                             ;81EF7C;      ;
                       LDA.W #$0008                         ;81EF7E;      ;
                       LDX.W #$0000                         ;81EF81;      ;
                       LDY.W #$007D                         ;81EF84;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81EF87;848097;
                       %Set8bit(!M)                             ;81EF8B;      ;
                       LDA.B #$0B                           ;81EF8D;      ;
                       STA.W $096F                          ;81EF8F;00096F;
                       STZ.W $0970                          ;81EF92;000970;
                       BRA CODE_81EFAC                      ;81EF95;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EF97: %Set8bit(!M)                             ;81EF97;      ;
                       INC.W $0970                          ;81EF99;000970;
                       LDA.W $0970                          ;81EF9C;000970;
                       CMP.B #$42                           ;81EF9F;      ;
                       BEQ CODE_81EFA6                      ;81EFA1;81EFA6;
                       JMP.W CODE_81EFAC                    ;81EFA3;81EFAC;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EFA6: STZ.W $0970                          ;81EFA6;000970;
                       JMP.W CODE_81EC64                    ;81EFA9;81EC64;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EFAC: RTS                                  ;81EFAC;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81EFAD;      ;
                       %Set16bit(!X)                             ;81EFAF;      ;
                       LDA.W $096F                          ;81EFB1;00096F;
                       CMP.B #$01                           ;81EFB4;      ;
                       BEQ CODE_81EFE1                      ;81EFB6;81EFE1;
                       CMP.B #$02                           ;81EFB8;      ;
                       BEQ CODE_81F013                      ;81EFBA;81F013;
                       CMP.B #$03                           ;81EFBC;      ;
                       BEQ CODE_81F02F                      ;81EFBE;81F02F;
                       CMP.B #$04                           ;81EFC0;      ;
                       BNE CODE_81EFC7                      ;81EFC2;81EFC7;
                       JMP.W CODE_81F054                    ;81EFC4;81F054;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EFC7: %Set8bit(!M)                             ;81EFC7;      ;
                       INC.W $0970                          ;81EFC9;000970;
                       LDA.W $0970                          ;81EFCC;000970;
                       CMP.B #$08                           ;81EFCF;      ;
                       BEQ CODE_81EFD6                      ;81EFD1;81EFD6;
                       JMP.W CODE_81F060                    ;81EFD3;81F060;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EFD6: LDA.B #$01                           ;81EFD6;      ;
                       STA.W $096F                          ;81EFD8;00096F;
                       STZ.W $0970                          ;81EFDB;000970;
                       JMP.W CODE_81F060                    ;81EFDE;81F060;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81EFE1: %Set16bit(!MX)                             ;81EFE1;      ;
                       LDA.B !game_state                            ;81EFE3;0000D2;
                       ORA.W #$0080                         ;81EFE5;      ;
                       STA.B !game_state                            ;81EFE8;0000D2;
                       %Set16bit(!MX)                             ;81EFEA;      ;
                       LDA.W #$0001                         ;81EFEC;      ;
                       STA.B !player_action                            ;81EFEF;0000D4;
                       %Set16bit(!MX)                             ;81EFF1;      ;
                       LDA.W #$0002                         ;81EFF3;      ;
                       STA.B !player_direction                            ;81EFF6;0000DA;
                       %Set16bit(!MX)                             ;81EFF8;      ;
                       LDA.W #$0002                         ;81EFFA;      ;
                       STA.W $0911                          ;81EFFD;000911;
                       %Set8bit(!M)                             ;81F000;      ;
                       INC.W $0970                          ;81F002;000970;
                       LDA.W $0970                          ;81F005;000970;
                       CMP.B #$20                           ;81F008;      ;
                       BNE CODE_81F060                      ;81F00A;81F060;
                       LDA.B #$02                           ;81F00C;      ;
                       STA.W $096F                          ;81F00E;00096F;
                       BRA CODE_81F060                      ;81F011;81F060;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F013: %Set8bit(!M)                             ;81F013;      ;
                       LDX.W #$0317                         ;81F015;      ;
                       LDA.B #$02                           ;81F018;      ;
                       STA.W !inputstate                          ;81F01A;00019A;
                       LDA.B #$00                           ;81F01D;      ;
                       STA.W $0191                          ;81F01F;000191;
                       JSL.L StartTextBox                    ;81F022;83935F;
                       %Set8bit(!M)                             ;81F026;      ;
                       LDA.B #$03                           ;81F028;      ;
                       STA.W $096F                          ;81F02A;00096F;
                       BRA CODE_81F060                      ;81F02D;81F060;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F02F: %Set8bit(!M)                             ;81F02F;      ;
                       LDA.W !inputstate                          ;81F031;00019A;
                       CMP.B #$02                           ;81F034;      ;
                       BNE CODE_81F03B                      ;81F036;81F03B;
                       JMP.W CODE_81F060                    ;81F038;81F060;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F03B: %Set8bit(!M)                             ;81F03B;      ;
                       LDA.B #$04                           ;81F03D;      ;
                       STA.W $096F                          ;81F03F;00096F;
                       LDA.B #$02                           ;81F042;      ;
                       STA.W $099F                          ;81F044;00099F;
                       %Set16bit(!M)                             ;81F047;      ;
                       LDA.W $0196                          ;81F049;000196;
                       ORA.W #$2000                         ;81F04C;      ;
                       STA.W $0196                          ;81F04F;000196;
                       BRA CODE_81F060                      ;81F052;81F060;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F054: %Set16bit(!MX)                             ;81F054;      ;
                       LDA.W #$0040                         ;81F056;      ;
                       EOR.W #$FFFF                         ;81F059;      ;
                       AND.B !game_state                            ;81F05C;0000D2;
                       STA.B !game_state                            ;81F05E;0000D2;
                                                            ;      ;      ;
          CODE_81F060: RTS                                  ;81F060;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F061;      ;
                       %Set16bit(!X)                             ;81F063;      ;
                       LDA.W $096F                          ;81F065;00096F;
                       CMP.B #$01                           ;81F068;      ;
                       BEQ CODE_81F093                      ;81F06A;81F093;
                       CMP.B #$02                           ;81F06C;      ;
                       BNE CODE_81F073                      ;81F06E;81F073;
                       JMP.W CODE_81F0D2                    ;81F070;81F0D2;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F073: CMP.B #$03                           ;81F073;      ;
                       BNE CODE_81F07A                      ;81F075;81F07A;
                       JMP.W CODE_81F103                    ;81F077;81F103;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F07A: %Set16bit(!M)                             ;81F07A;      ;
                       LDA.W #$0006                         ;81F07C;      ;
                       LDX.W #$0000                         ;81F07F;      ;
                       LDY.W #$0026                         ;81F082;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81F085;848097;
                       %Set8bit(!M)                             ;81F089;      ;
                       LDA.B #$01                           ;81F08B;      ;
                       STA.W $096F                          ;81F08D;00096F;
                       JMP.W CODE_81F120                    ;81F090;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F093: %Set8bit(!M)                             ;81F093;      ;
                       INC.W $0970                          ;81F095;000970;
                       LDA.W $0970                          ;81F098;000970;
                       CMP.B #$42                           ;81F09B;      ;
                       BEQ CODE_81F0A2                      ;81F09D;81F0A2;
                       JMP.W CODE_81F120                    ;81F09F;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F0A2: %Set8bit(!M)                             ;81F0A2;      ;
                       LDA.B #$02                           ;81F0A4;      ;
                       STA.W !inputstate                          ;81F0A6;00019A;
                       LDX.W #$031A                         ;81F0A9;      ;
                       %Set16bit(!M)                             ;81F0AC;      ;
                       LDA.L !shipping_moneyL                        ;81F0AE;7F1F07;
                       BNE CODE_81F0BF                      ;81F0B2;81F0BF;
                       %Set8bit(!M)                             ;81F0B4;      ;
                       LDA.L !shipping_moneyH                        ;81F0B6;7F1F09;
                       BNE CODE_81F0BF                      ;81F0BA;81F0BF;
                       LDX.W #$031B                         ;81F0BC;      ;
                                                            ;      ;      ;
          CODE_81F0BF: LDA.B #$00                           ;81F0BF;      ;
                       STA.W $0191                          ;81F0C1;000191;
                       JSL.L StartTextBox                    ;81F0C4;83935F;
                       %Set8bit(!M)                             ;81F0C8;      ;
                       LDA.B #$02                           ;81F0CA;      ;
                       STA.W $096F                          ;81F0CC;00096F;
                       JMP.W CODE_81F120                    ;81F0CF;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F0D2: %Set8bit(!M)                             ;81F0D2;      ;
                       LDA.W !inputstate                          ;81F0D4;00019A;
                       CMP.B #$02                           ;81F0D7;      ;
                       BNE CODE_81F0DE                      ;81F0D9;81F0DE;
                       JMP.W CODE_81F120                    ;81F0DB;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F0DE: %Set16bit(!M)                             ;81F0DE;      ;
                       LDA.W #$0006                         ;81F0E0;      ;
                       JSL.L SUB_848020                    ;81F0E3;848020;
                       %Set16bit(!M)                             ;81F0E7;      ;
                       LDA.W #$0006                         ;81F0E9;      ;
                       LDX.W #$0000                         ;81F0EC;      ;
                       LDY.W #$0027                         ;81F0EF;      ;
                       JSL.L UNK_LoadCCDataLong                            ;81F0F2;848097;
                       %Set8bit(!M)                             ;81F0F6;      ;
                       LDA.B #$03                           ;81F0F8;      ;
                       STA.W $096F                          ;81F0FA;00096F;
                       STZ.W $0970                          ;81F0FD;000970;
                       JMP.W CODE_81F120                    ;81F100;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F103: %Set8bit(!M)                             ;81F103;      ;
                       INC.W $0970                          ;81F105;000970;
                       LDA.W $0970                          ;81F108;000970;
                       CMP.B #$42                           ;81F10B;      ;
                       BEQ CODE_81F112                      ;81F10D;81F112;
                       JMP.W CODE_81F120                    ;81F10F;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F112: %Set16bit(!MX)                             ;81F112;      ;
                       LDA.W #$0040                         ;81F114;      ;
                       EOR.W #$FFFF                         ;81F117;      ;
                       AND.B !game_state                            ;81F11A;0000D2;
                       STA.B !game_state                            ;81F11C;0000D2;
                       BRA CODE_81F120                      ;81F11E;81F120;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F120: RTS                                  ;81F120;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F121;      ;
                       %Set16bit(!X)                             ;81F123;      ;
                       LDA.W $096F                          ;81F125;00096F;
                       CMP.B #$01                           ;81F128;      ;
                       BNE CODE_81F12F                      ;81F12A;81F12F;
                       JMP.W CODE_81F1CE                    ;81F12C;81F1CE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F12F: CMP.B #$02                           ;81F12F;      ;
                       BNE CODE_81F136                      ;81F131;81F136;
                       JMP.W CODE_81F1F3                    ;81F133;81F1F3;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F136: CMP.B #$03                           ;81F136;      ;
                       BNE CODE_81F13D                      ;81F138;81F13D;
                       JMP.W CODE_81F211                    ;81F13A;81F211;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F13D: %Set8bit(!M)                             ;81F13D;      ;
                       INC.W $0970                          ;81F13F;000970;
                       LDA.W $0970                          ;81F142;000970;
                       CMP.B #$20                           ;81F145;      ;
                       BEQ CODE_81F14C                      ;81F147;81F14C;
                       JMP.W CODE_81F2D9                    ;81F149;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F14C: %Set8bit(!M)                             ;81F14C;      ;
                       LDA.L !year                        ;81F14E;7F1F18;
                       BNE CODE_81F169                      ;81F152;81F169;
                       LDA.L !season                        ;81F154;7F1F19;
                       CMP.B #$02                           ;81F158;      ;
                       BCS CODE_81F169                      ;81F15A;81F169;
                       %Set16bit(!M)                             ;81F15C;      ;
                       LDA.L $7F1F70                        ;81F15E;7F1F70;
                       ORA.W #$0004                         ;81F162;      ;
                       STA.L $7F1F70                        ;81F165;7F1F70;
                                                            ;      ;      ;
          CODE_81F169: %Set8bit(!M)                             ;81F169;      ;
                       STZ.W $0970                          ;81F16B;000970;
                       %Set16bit(!M)                             ;81F16E;      ;
                       LDA.L !wood_need_for_upgrade                        ;81F170;7F1F0E;
                       CMP.W #$00FA                         ;81F174;      ;
                       BEQ CODE_81F189                      ;81F177;81F189;
                       %Set16bit(!M)                             ;81F179;      ;
                       LDA.L !stored_wood                        ;81F17B;7F1F0C;
                       CMP.W #$01F4                         ;81F17F;      ;
                       BCC CODE_81F1B1                      ;81F182;81F1B1;
                       LDX.W #$013B                         ;81F184;      ;
                       BRA CODE_81F197                      ;81F187;81F197;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F189: %Set16bit(!M)                             ;81F189;      ;
                       LDA.L !stored_wood                        ;81F18B;7F1F0C;
                       CMP.W #$00FA                         ;81F18F;      ;
                       BCC CODE_81F1B1                      ;81F192;81F1B1;
                       LDX.W #$0134                         ;81F194;      ;
                                                            ;      ;      ;
          CODE_81F197: %Set8bit(!M)                             ;81F197;      ;
                       LDA.B #$02                           ;81F199;      ;
                       STA.W !inputstate                          ;81F19B;00019A;
                       LDA.B #$00                           ;81F19E;      ;
                       STA.W $0191                          ;81F1A0;000191;
                       JSL.L StartTextBox                    ;81F1A3;83935F;
                       %Set8bit(!M)                             ;81F1A7;      ;
                       LDA.B #$03                           ;81F1A9;      ;
                       STA.W $096F                          ;81F1AB;00096F;
                       JMP.W CODE_81F2D9                    ;81F1AE;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F1B1: %Set8bit(!M)                             ;81F1B1;      ;
                       LDA.B #$02                           ;81F1B3;      ;
                       STA.W !inputstate                          ;81F1B5;00019A;
                       LDX.W #$0137                         ;81F1B8;      ;
                       LDA.B #$00                           ;81F1BB;      ;
                       STA.W $0191                          ;81F1BD;000191;
                       JSL.L StartTextBox                    ;81F1C0;83935F;
                       %Set8bit(!M)                             ;81F1C4;      ;
                       LDA.B #$01                           ;81F1C6;      ;
                       STA.W $096F                          ;81F1C8;00096F;
                       JMP.W CODE_81F2D9                    ;81F1CB;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F1CE: %Set8bit(!M)                             ;81F1CE;      ;
                       LDA.W !inputstate                          ;81F1D0;00019A;
                       CMP.B #$02                           ;81F1D3;      ;
                       BNE CODE_81F1DA                      ;81F1D5;81F1DA;
                       JMP.W CODE_81F2D9                    ;81F1D7;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F1DA: %Set16bit(!M)                             ;81F1DA;      ;
                       LDA.W #$0009                         ;81F1DC;      ;
                       LDX.W #$0000                         ;81F1DF;      ;
                       LDY.W #$002D                         ;81F1E2;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81F1E5;84803F;
                       %Set8bit(!M)                             ;81F1E9;      ;
                       LDA.B #$02                           ;81F1EB;      ;
                       STA.W $096F                          ;81F1ED;00096F;
                       JMP.W CODE_81F2D9                    ;81F1F0;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F1F3: %Set8bit(!M)                             ;81F1F3;      ;
                       INC.W $0970                          ;81F1F5;000970;
                       LDA.W $0970                          ;81F1F8;000970;
                       CMP.B #$C6                           ;81F1FB;      ;
                       BEQ CODE_81F202                      ;81F1FD;81F202;
                       JMP.W CODE_81F2D9                    ;81F1FF;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F202: %Set16bit(!MX)                             ;81F202;      ;
                       LDA.W #$0040                         ;81F204;      ;
                       EOR.W #$FFFF                         ;81F207;      ;
                       AND.B !game_state                            ;81F20A;0000D2;
                       STA.B !game_state                            ;81F20C;0000D2;
                       JMP.W CODE_81F2D9                    ;81F20E;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F211: %Set8bit(!M)                             ;81F211;      ;
                       LDA.W !inputstate                          ;81F213;00019A;
                       CMP.B #$02                           ;81F216;      ;
                       BNE CODE_81F21D                      ;81F218;81F21D;
                       JMP.W CODE_81F2D9                    ;81F21A;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F21D: %Set8bit(!M)                             ;81F21D;      ;
                       LDA.W $018F                          ;81F21F;00018F;
                       BEQ CODE_81F227                      ;81F222;81F227;
                       JMP.W CODE_81F2BD                    ;81F224;81F2BD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F227: %Set16bit(!MX)                             ;81F227;      ;
                       LDA.L !wood_need_for_upgrade                        ;81F229;7F1F0E;
                       CMP.W #$00FA                         ;81F22D;      ;
                       BEQ CODE_81F24C                      ;81F230;81F24C;
                       %Set16bit(!M)                             ;81F232;      ;
                       LDA.W #$FC18                         ;81F234;      ;
                       STA.B $72                            ;81F237;000072;
                       %Set8bit(!M)                             ;81F239;      ;
                       LDA.B #$FF                           ;81F23B;      ;
                       STA.B $74                            ;81F23D;000074;
                       JSL.L AddMoney                       ;81F23F;83B1C9;
                       %Set16bit(!M)                             ;81F243;      ;
                       CMP.W #$0000                         ;81F245;      ;
                       BNE CODE_81F2A1                      ;81F248;81F2A1;
                       BRA CODE_81F264                      ;81F24A;81F264;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F24C: %Set16bit(!M)                             ;81F24C;      ;
                       LDA.W #$FE0C                         ;81F24E;      ;
                       STA.B $72                            ;81F251;000072;
                       %Set8bit(!M)                             ;81F253;      ;
                       LDA.B #$FF                           ;81F255;      ;
                       STA.B $74                            ;81F257;000074;
                       JSL.L AddMoney                       ;81F259;83B1C9;
                       %Set16bit(!M)                             ;81F25D;      ;
                       CMP.W #$0000                         ;81F25F;      ;
                       BNE CODE_81F2A1                      ;81F262;81F2A1;
                                                            ;      ;      ;
          CODE_81F264: %Set16bit(!MX)                             ;81F264;      ;
                       LDA.L !wood_need_for_upgrade                        ;81F266;7F1F0E;
                       EOR.W #$FFFF                         ;81F26A;      ;
                       INC A                                ;81F26D;      ;
                       JSL.L AddWood                        ;81F26E;83B224;
                       %Set8bit(!M)                             ;81F272;      ;
                       LDA.B #$02                           ;81F274;      ;
                       STA.W !inputstate                          ;81F276;00019A;
                       LDX.W #$0135                         ;81F279;      ;
                       LDA.B #$00                           ;81F27C;      ;
                       STA.W $0191                          ;81F27E;000191;
                       JSL.L StartTextBox                    ;81F281;83935F;
                       %Set8bit(!M)                             ;81F285;      ;
                       LDA.B #$01                           ;81F287;      ;
                       STA.W $096F                          ;81F289;00096F;
                       LDA.B #$00                           ;81F28C;      ;
                       STA.L !development_rate                        ;81F28E;7F1F35;
                       %Set16bit(!M)                             ;81F292;      ;
                       LDA.L $7F1F66                        ;81F294;7F1F66;
                       ORA.W #$0080                         ;81F298;      ;
                       STA.L $7F1F66                        ;81F29B;7F1F66;
                       BRA CODE_81F2D9                      ;81F29F;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F2A1: %Set8bit(!M)                             ;81F2A1;      ;
                       LDA.B #$02                           ;81F2A3;      ;
                       STA.W !inputstate                          ;81F2A5;00019A;
                       LDX.W #$0304                         ;81F2A8;      ;
                       LDA.B #$00                           ;81F2AB;      ;
                       STA.W $0191                          ;81F2AD;000191;
                       JSL.L StartTextBox                    ;81F2B0;83935F;
                       %Set8bit(!M)                             ;81F2B4;      ;
                       LDA.B #$01                           ;81F2B6;      ;
                       STA.W $096F                          ;81F2B8;00096F;
                       BRA CODE_81F2D9                      ;81F2BB;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F2BD: %Set8bit(!M)                             ;81F2BD;      ;
                       LDA.B #$02                           ;81F2BF;      ;
                       STA.W !inputstate                          ;81F2C1;00019A;
                       LDX.W #$0136                         ;81F2C4;      ;
                       LDA.B #$00                           ;81F2C7;      ;
                       STA.W $0191                          ;81F2C9;000191;
                       JSL.L StartTextBox                    ;81F2CC;83935F;
                       %Set8bit(!M)                             ;81F2D0;      ;
                       LDA.B #$01                           ;81F2D2;      ;
                       STA.W $096F                          ;81F2D4;00096F;
                       BRA CODE_81F2D9                      ;81F2D7;81F2D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F2D9: RTS                                  ;81F2D9;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F2DA;      ;
                       %Set16bit(!X)                             ;81F2DC;      ;
                       LDA.W $096F                          ;81F2DE;00096F;
                       CMP.B #$01                           ;81F2E1;      ;
                       BEQ CODE_81F348                      ;81F2E3;81F348;
                       CMP.B #$02                           ;81F2E5;      ;
                       BNE CODE_81F2EC                      ;81F2E7;81F2EC;
                       JMP.W CODE_81F3BB                    ;81F2E9;81F3BB;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F2EC: CMP.B #$03                           ;81F2EC;      ;
                       BNE CODE_81F2F3                      ;81F2EE;81F2F3;
                       JMP.W CODE_81F3D9                    ;81F2F0;81F3D9;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F2F3: %Set8bit(!M)                             ;81F2F3;      ;
                       INC.W $0970                          ;81F2F5;000970;
                       LDA.W $0970                          ;81F2F8;000970;
                       CMP.B #$20                           ;81F2FB;      ;
                       BEQ CODE_81F302                      ;81F2FD;81F302;
                       JMP.W CODE_81F40D                    ;81F2FF;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F302: STZ.W $0970                          ;81F302;000970;
                       %Set16bit(!M)                             ;81F305;      ;
                       LDA.L $7F1F64                        ;81F307;7F1F64;
                       AND.W #$0080                         ;81F30B;      ;
                       BNE CODE_81F320                      ;81F30E;81F320;
                       %Set16bit(!MX)                             ;81F310;      ;
                       LDA.W #$0032                         ;81F312;      ;
                       JSL.L AddPlayerHappiness                   ;81F315;83B282;
                       %Set16bit(!MX)                             ;81F319;      ;
                       LDX.W #$013D                         ;81F31B;      ;
                       BRA CODE_81F32E                      ;81F31E;81F32E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F320: %Set16bit(!MX)                             ;81F320;      ;
                       LDA.W #$0064                         ;81F322;      ;
                       JSL.L AddPlayerHappiness                   ;81F325;83B282;
                       %Set16bit(!MX)                             ;81F329;      ;
                       LDX.W #$0140                         ;81F32B;      ;
                                                            ;      ;      ;
          CODE_81F32E: %Set8bit(!M)                             ;81F32E;      ;
                       LDA.B #$02                           ;81F330;      ;
                       STA.W !inputstate                          ;81F332;00019A;
                       LDA.B #$00                           ;81F335;      ;
                       STA.W $0191                          ;81F337;000191;
                       JSL.L StartTextBox                    ;81F33A;83935F;
                       %Set8bit(!M)                             ;81F33E;      ;
                       LDA.B #$01                           ;81F340;      ;
                       STA.W $096F                          ;81F342;00096F;
                       JMP.W CODE_81F40D                    ;81F345;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F348: %Set8bit(!M)                             ;81F348;      ;
                       LDA.W !inputstate                          ;81F34A;00019A;
                       CMP.B #$02                           ;81F34D;      ;
                       BNE CODE_81F354                      ;81F34F;81F354;
                       JMP.W CODE_81F40D                    ;81F351;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F354: %Set16bit(!M)                             ;81F354;      ;
                       LDA.L $7F1F64                        ;81F356;7F1F64;
                       AND.W #$0080                         ;81F35A;      ;
                       BNE CODE_81F393                      ;81F35D;81F393;
                       %Set8bit(!M)                             ;81F35F;      ;
                       %Set16bit(!M)                             ;81F361;      ;
                       LDA.L $7F1F70                        ;81F363;7F1F70;
                       AND.W #$0004                         ;81F367;      ;
                       BEQ CODE_81F393                      ;81F36A;81F393;
                       LDA.L $7F1F6E                        ;81F36C;7F1F6E;
                       ORA.W #$4000                         ;81F370;      ;
                       STA.L $7F1F6E                        ;81F373;7F1F6E;
                       %Set8bit(!M)                             ;81F377;      ;
                       LDA.B #$02                           ;81F379;      ;
                       STA.W !inputstate                          ;81F37B;00019A;
                       LDX.W #$025C                         ;81F37E;      ;
                       LDA.B #$00                           ;81F381;      ;
                       STA.W $0191                          ;81F383;000191;
                       JSL.L StartTextBox                    ;81F386;83935F;
                       %Set8bit(!M)                             ;81F38A;      ;
                       LDA.B #$03                           ;81F38C;      ;
                       STA.W $096F                          ;81F38E;00096F;
                       BRA CODE_81F40D                      ;81F391;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F393: %Set16bit(!M)                             ;81F393;      ;
                       LDA.W #$0009                         ;81F395;      ;
                       LDX.W #$0000                         ;81F398;      ;
                       LDY.W #$0038                         ;81F39B;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81F39E;84803F;
                       %Set16bit(!M)                             ;81F3A2;      ;
                       LDA.W #$000A                         ;81F3A4;      ;
                       LDX.W #$0000                         ;81F3A7;      ;
                       LDY.W #$0039                         ;81F3AA;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81F3AD;84803F;
                       %Set8bit(!M)                             ;81F3B1;      ;
                       LDA.B #$02                           ;81F3B3;      ;
                       STA.W $096F                          ;81F3B5;00096F;
                       JMP.W CODE_81F40D                    ;81F3B8;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F3BB: %Set8bit(!M)                             ;81F3BB;      ;
                       INC.W $0970                          ;81F3BD;000970;
                       LDA.W $0970                          ;81F3C0;000970;
                       CMP.B #$C6                           ;81F3C3;      ;
                       BEQ CODE_81F3CA                      ;81F3C5;81F3CA;
                       JMP.W CODE_81F40D                    ;81F3C7;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F3CA: %Set16bit(!MX)                             ;81F3CA;      ;
                       LDA.W #$0040                         ;81F3CC;      ;
                       EOR.W #$FFFF                         ;81F3CF;      ;
                       AND.B !game_state                            ;81F3D2;0000D2;
                       STA.B !game_state                            ;81F3D4;0000D2;
                       JMP.W CODE_81F40D                    ;81F3D6;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F3D9: %Set8bit(!M)                             ;81F3D9;      ;
                       LDA.W !inputstate                          ;81F3DB;00019A;
                       CMP.B #$02                           ;81F3DE;      ;
                       BNE CODE_81F3E5                      ;81F3E0;81F3E5;
                       JMP.W CODE_81F40D                    ;81F3E2;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F3E5: %Set16bit(!M)                             ;81F3E5;      ;
                       LDA.W #$0009                         ;81F3E7;      ;
                       LDX.W #$0000                         ;81F3EA;      ;
                       LDY.W #$0038                         ;81F3ED;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81F3F0;84803F;
                       %Set16bit(!M)                             ;81F3F4;      ;
                       LDA.W #$000A                         ;81F3F6;      ;
                       LDX.W #$0000                         ;81F3F9;      ;
                       LDY.W #$0039                         ;81F3FC;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81F3FF;84803F;
                       %Set8bit(!M)                             ;81F403;      ;
                       LDA.B #$02                           ;81F405;      ;
                       STA.W $096F                          ;81F407;00096F;
                       JMP.W CODE_81F40D                    ;81F40A;81F40D;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F40D: RTS                                  ;81F40D;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F40E;      ;
                       %Set16bit(!X)                             ;81F410;      ;
                       LDA.W $096F                          ;81F412;00096F;
                       CMP.B #$01                           ;81F415;      ;
                       BEQ CODE_81F44C                      ;81F417;81F44C;
                       CMP.B #$02                           ;81F419;      ;
                       BEQ CODE_81F471                      ;81F41B;81F471;
                       %Set8bit(!M)                             ;81F41D;      ;
                       INC.W $0970                          ;81F41F;000970;
                       LDA.W $0970                          ;81F422;000970;
                       CMP.B #$20                           ;81F425;      ;
                       BEQ CODE_81F42C                      ;81F427;81F42C;
                       JMP.W CODE_81F48F                    ;81F429;81F48F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F42C: STZ.W $0970                          ;81F42C;000970;
                       %Set8bit(!M)                             ;81F42F;      ;
                       LDA.B #$02                           ;81F431;      ;
                       STA.W !inputstate                          ;81F433;00019A;
                       LDX.W #$0300                         ;81F436;      ;
                       LDA.B #$00                           ;81F439;      ;
                       STA.W $0191                          ;81F43B;000191;
                       JSL.L StartTextBox                    ;81F43E;83935F;
                       %Set8bit(!M)                             ;81F442;      ;
                       LDA.B #$01                           ;81F444;      ;
                       STA.W $096F                          ;81F446;00096F;
                       JMP.W CODE_81F48F                    ;81F449;81F48F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F44C: %Set8bit(!M)                             ;81F44C;      ;
                       LDA.W !inputstate                          ;81F44E;00019A;
                       CMP.B #$02                           ;81F451;      ;
                       BNE CODE_81F458                      ;81F453;81F458;
                       JMP.W CODE_81F48F                    ;81F455;81F48F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F458: %Set16bit(!M)                             ;81F458;      ;
                       LDA.W #$000B                         ;81F45A;      ;
                       LDX.W #$0000                         ;81F45D;      ;
                       LDY.W #$001E                         ;81F460;      ;
                       JSL.L UNK_LoadCCDataShort                    ;81F463;84803F;
                       %Set8bit(!M)                             ;81F467;      ;
                       LDA.B #$02                           ;81F469;      ;
                       STA.W $096F                          ;81F46B;00096F;
                       JMP.W CODE_81F48F                    ;81F46E;81F48F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F471: %Set8bit(!M)                             ;81F471;      ;
                       INC.W $0970                          ;81F473;000970;
                       LDA.W $0970                          ;81F476;000970;
                       CMP.B #$C6                           ;81F479;      ;
                       BEQ CODE_81F480                      ;81F47B;81F480;
                       JMP.W CODE_81F48F                    ;81F47D;81F48F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F480: %Set16bit(!MX)                             ;81F480;      ;
                       LDA.W #$0040                         ;81F482;      ;
                       EOR.W #$FFFF                         ;81F485;      ;
                       AND.B !game_state                            ;81F488;0000D2;
                       STA.B !game_state                            ;81F48A;0000D2;
                       JMP.W CODE_81F48F                    ;81F48C;81F48F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F48F: RTS                                  ;81F48F;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F490;      ;
                       LDA.W #$00FB                         ;81F492;      ;
                       LDX.W #$0010                         ;81F495;      ;
                       STX.W $09AD                          ;81F498;0009AD;
                       LDY.W #$0030                         ;81F49B;      ;
                       STY.W $09AF                          ;81F49E;0009AF;
                       JSL.L CODE_81A688                    ;81F4A1;81A688;
                       %Set16bit(!MX)                             ;81F4A5;      ;
                       LDA.W #$0001                         ;81F4A7;      ;
                       JMP.W CODE_81F556                    ;81F4AA;81F556;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F4AD;      ;
                       LDA.W #$00FB                         ;81F4AF;      ;
                       LDX.W #$00B0                         ;81F4B2;      ;
                       STX.W $09AD                          ;81F4B5;0009AD;
                       LDY.W #$0090                         ;81F4B8;      ;
                       STY.W $09AF                          ;81F4BB;0009AF;
                       JSL.L CODE_81A688                    ;81F4BE;81A688;
                       %Set16bit(!MX)                             ;81F4C2;      ;
                       LDA.W #$0002                         ;81F4C4;      ;
                       JMP.W CODE_81F556                    ;81F4C7;81F556;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F4CA;      ;
                       LDA.W #$00FB                         ;81F4CC;      ;
                       LDX.W #$01C0                         ;81F4CF;      ;
                       STX.W $09AD                          ;81F4D2;0009AD;
                       LDY.W #$0050                         ;81F4D5;      ;
                       STY.W $09AF                          ;81F4D8;0009AF;
                       JSL.L CODE_81A688                    ;81F4DB;81A688;
                       %Set16bit(!MX)                             ;81F4DF;      ;
                       LDA.W #$0003                         ;81F4E1;      ;
                       BRA CODE_81F556                      ;81F4E4;81F556;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F4E6;      ;
                       LDA.W #$00FB                         ;81F4E8;      ;
                       LDX.W #$02A0                         ;81F4EB;      ;
                       STX.W $09AD                          ;81F4EE;0009AD;
                       LDY.W #$0030                         ;81F4F1;      ;
                       STY.W $09AF                          ;81F4F4;0009AF;
                       JSL.L CODE_81A688                    ;81F4F7;81A688;
                       %Set16bit(!MX)                             ;81F4FB;      ;
                       LDA.W #$0004                         ;81F4FD;      ;
                       BRA CODE_81F556                      ;81F500;81F556;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F502;      ;
                       LDA.W #$00FB                         ;81F504;      ;
                       LDX.W #$0050                         ;81F507;      ;
                       STX.W $09AD                          ;81F50A;0009AD;
                       LDY.W #$02C0                         ;81F50D;      ;
                       STY.W $09AF                          ;81F510;0009AF;
                       JSL.L CODE_81A688                    ;81F513;81A688;
                       %Set16bit(!MX)                             ;81F517;      ;
                       LDA.W #$0005                         ;81F519;      ;
                       BRA CODE_81F556                      ;81F51C;81F556;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F51E;      ;
                       LDA.W #$00FB                         ;81F520;      ;
                       LDX.W #$0210                         ;81F523;      ;
                       STX.W $09AD                          ;81F526;0009AD;
                       LDY.W #$0250                         ;81F529;      ;
                       STY.W $09AF                          ;81F52C;0009AF;
                       JSL.L CODE_81A688                    ;81F52F;81A688;
                       %Set16bit(!MX)                             ;81F533;      ;
                       LDA.W #$0006                         ;81F535;      ;
                       BRA CODE_81F556                      ;81F538;81F556;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81F53A;      ;
                       LDA.W #$00FB                         ;81F53C;      ;
                       LDX.W #$0210                         ;81F53F;      ;
                       STX.W $09AD                          ;81F542;0009AD;
                       LDY.W #$0330                         ;81F545;      ;
                       STY.W $09AF                          ;81F548;0009AF;
                       JSL.L CODE_81A688                    ;81F54B;81A688;
                       %Set16bit(!MX)                             ;81F54F;      ;
                       LDA.W #$0007                         ;81F551;      ;
                       BRA CODE_81F556                      ;81F554;81F556;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F556: %Set16bit(!MX)                             ;81F556;      ;
                       TAX                                  ;81F558;      ;
                       %Set8bit(!M)                             ;81F559;      ;
                       LDA.W $09A4,X                        ;81F55B;0009A4;
                       BEQ CODE_81F594                      ;81F55E;81F594;
                       TXY                                  ;81F560;      ;
                       XBA                                  ;81F561;      ;
                       LDA.B #$00                           ;81F562;      ;
                       XBA                                  ;81F564;      ;
                       %Set16bit(!M)                             ;81F565;      ;
                       DEC A                                ;81F567;      ;
                       ASL A                                ;81F568;      ;
                       TAX                                  ;81F569;      ;
                       LDA.L DATA16_81FAB4,X                ;81F56A;81FAB4;
                       AND.L $7F1F78                        ;81F56E;7F1F78;
                       BNE CODE_81F594                      ;81F572;81F594;
                       TYX                                  ;81F574;      ;
                       %Set8bit(!M)                             ;81F575;      ;
                       LDA.W $09A4,X                        ;81F577;0009A4;
                       CLC                                  ;81F57A;      ;
                       ADC.B #$1D                           ;81F57B;      ;
                       STA.W !item_on_hand                          ;81F57D;00091D;
                       %Set16bit(!MX)                             ;81F580;      ;
                       LDA.W #$0004                         ;81F582;      ;
                       STA.B !player_action                            ;81F585;0000D4;
                       %Set16bit(!MX)                             ;81F587;      ;
                       LDA.W #$0040                         ;81F589;      ;
                       EOR.W #$FFFF                         ;81F58C;      ;
                       AND.B !game_state                            ;81F58F;0000D2;
                       STA.B !game_state                            ;81F591;0000D2;
                       RTS                                  ;81F593;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F594: %Set16bit(!MX)                             ;81F594;      ;
                       LDA.W #$00A1                         ;81F596;      ;
                       LDX.W $09AD                          ;81F599;0009AD;
                       LDY.W $09AF                          ;81F59C;0009AF;
                       JSL.L EditTileonMap                    ;81F59F;82B03A;
                       %Set16bit(!MX)                             ;81F5A3;      ;
                       LDA.W #$0040                         ;81F5A5;      ;
                       EOR.W #$FFFF                         ;81F5A8;      ;
                       AND.B !game_state                            ;81F5AB;0000D2;
                       STA.B !game_state                            ;81F5AD;0000D2;
                       RTS                                  ;81F5AF;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F5B0;      ;
                       %Set16bit(!X)                             ;81F5B2;      ;
                       LDA.W $096F                          ;81F5B4;00096F;
                       CMP.B #$01                           ;81F5B7;      ;
                       BEQ CODE_81F5EB                      ;81F5B9;81F5EB;
                       CMP.B #$02                           ;81F5BB;      ;
                       BNE CODE_81F5C2                      ;81F5BD;81F5C2;
                       JMP.W CODE_81F66C                    ;81F5BF;81F66C;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F5C2: CMP.B #$03                           ;81F5C2;      ;
                       BNE CODE_81F5C9                      ;81F5C4;81F5C9;
                       JMP.W CODE_81F69E                    ;81F5C6;81F69E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F5C9: CMP.B #$04                           ;81F5C9;      ;
                       BNE CODE_81F5D0                      ;81F5CB;81F5D0;
                       JMP.W CODE_81F6B5                    ;81F5CD;81F6B5;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F5D0: %Set8bit(!M)                             ;81F5D0;      ;
                       LDA.B #$02                           ;81F5D2;      ;
                       STA.W !inputstate                          ;81F5D4;00019A;
                       LDX.W #$024B                         ;81F5D7;      ;
                       LDA.B #$00                           ;81F5DA;      ;
                       STA.W $0191                          ;81F5DC;000191;
                       JSL.L StartTextBox                    ;81F5DF;83935F;
                       %Set8bit(!M)                             ;81F5E3;      ;
                       INC.W $096F                          ;81F5E5;00096F;
                       JMP.W CODE_81F6D6                    ;81F5E8;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F5EB: %Set8bit(!M)                             ;81F5EB;      ;
                       LDA.W !inputstate                          ;81F5ED;00019A;
                       CMP.B #$02                           ;81F5F0;      ;
                       BNE CODE_81F5F7                      ;81F5F2;81F5F7;
                       JMP.W CODE_81F6D6                    ;81F5F4;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F5F7: %Set8bit(!M)                             ;81F5F7;      ;
                       LDA.W $018F                          ;81F5F9;00018F;
                       BNE CODE_81F633                      ;81F5FC;81F633;
                       %Set16bit(!M)                             ;81F5FE;      ;
                       LDA.W #$FFEC                         ;81F600;      ;
                       STA.B $72                            ;81F603;000072;
                       %Set8bit(!M)                             ;81F605;      ;
                       LDA.B #$FF                           ;81F607;      ;
                       STA.B $74                            ;81F609;000074;
                       JSL.L AddMoney                       ;81F60B;83B1C9;
                       %Set16bit(!M)                             ;81F60F;      ;
                       CMP.W #$0000                         ;81F611;      ;
                       BNE CODE_81F650                      ;81F614;81F650;
                       %Set8bit(!M)                             ;81F616;      ;
                       LDA.B #$02                           ;81F618;      ;
                       STA.W !inputstate                          ;81F61A;00019A;
                       LDX.W #$024C                         ;81F61D;      ;
                       LDA.B #$00                           ;81F620;      ;
                       STA.W $0191                          ;81F622;000191;
                       JSL.L StartTextBox                    ;81F625;83935F;
                       %Set8bit(!M)                             ;81F629;      ;
                       LDA.B #$02                           ;81F62B;      ;
                       STA.W $096F                          ;81F62D;00096F;
                       JMP.W CODE_81F6D6                    ;81F630;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F633: %Set8bit(!M)                             ;81F633;      ;
                       LDA.B #$02                           ;81F635;      ;
                       STA.W !inputstate                          ;81F637;00019A;
                       LDX.W #$024D                         ;81F63A;      ;
                       LDA.B #$00                           ;81F63D;      ;
                       STA.W $0191                          ;81F63F;000191;
                       JSL.L StartTextBox                    ;81F642;83935F;
                       %Set8bit(!M)                             ;81F646;      ;
                       LDA.B #$03                           ;81F648;      ;
                       STA.W $096F                          ;81F64A;00096F;
                       JMP.W CODE_81F6D6                    ;81F64D;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F650: %Set8bit(!M)                             ;81F650;      ;
                       LDA.B #$02                           ;81F652;      ;
                       STA.W !inputstate                          ;81F654;00019A;
                       LDX.W #$0213                         ;81F657;      ;
                       LDA.B #$00                           ;81F65A;      ;
                       STA.W $0191                          ;81F65C;000191;
                       JSL.L StartTextBox                    ;81F65F;83935F;
                       %Set8bit(!M)                             ;81F663;      ;
                       LDA.B #$03                           ;81F665;      ;
                       STA.W $096F                          ;81F667;00096F;
                       BRA CODE_81F6D6                      ;81F66A;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F66C: %Set8bit(!M)                             ;81F66C;      ;
                       LDA.W !inputstate                          ;81F66E;00019A;
                       CMP.B #$02                           ;81F671;      ;
                       BEQ CODE_81F6D6                      ;81F673;81F6D6;
                       %Set16bit(!M)                             ;81F675;      ;
                       %Set16bit(!MX)                             ;81F677;      ;
                       LDA.W #$0019                         ;81F679;      ;
                       STA.B !player_action                            ;81F67C;0000D4;
                       %Set16bit(!MX)                             ;81F67E;      ;
                       LDA.W #$0030                         ;81F680;      ;
                       STA.W $0901                          ;81F683;000901;
                       JSR.W CODE_81CFE6                    ;81F686;81CFE6;
                       %Set16bit(!MX)                             ;81F689;      ;
                       LDA.W #$0001                         ;81F68B;      ;
                       JSL.L AddPlayerHappiness                   ;81F68E;83B282;
                       %Set8bit(!M)                             ;81F692;      ;
                       STZ.W $0970                          ;81F694;000970;
                       LDA.B #$04                           ;81F697;      ;
                       STA.W $096F                          ;81F699;00096F;
                       BRA CODE_81F6D6                      ;81F69C;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F69E: %Set8bit(!M)                             ;81F69E;      ;
                       LDA.W !inputstate                          ;81F6A0;00019A;
                       CMP.B #$02                           ;81F6A3;      ;
                       BEQ CODE_81F6D6                      ;81F6A5;81F6D6;
                       %Set16bit(!MX)                             ;81F6A7;      ;
                       LDA.W #$0040                         ;81F6A9;      ;
                       EOR.W #$FFFF                         ;81F6AC;      ;
                       AND.B !game_state                            ;81F6AF;0000D2;
                       STA.B !game_state                            ;81F6B1;0000D2;
                       BRA CODE_81F6D6                      ;81F6B3;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F6B5: %Set8bit(!M)                             ;81F6B5;      ;
                       INC.W $0970                          ;81F6B7;000970;
                       LDA.W $0970                          ;81F6BA;000970;
                       CMP.B #$64                           ;81F6BD;      ;
                       BNE CODE_81F6D6                      ;81F6BF;81F6D6;
                       %Set16bit(!MX)                             ;81F6C1;      ;
                       LDA.W #$0040                         ;81F6C3;      ;
                       EOR.W #$FFFF                         ;81F6C6;      ;
                       AND.B !game_state                            ;81F6C9;0000D2;
                       STA.B !game_state                            ;81F6CB;0000D2;
                       %Set16bit(!MX)                             ;81F6CD;      ;
                       LDA.W #$0000                         ;81F6CF;      ;
                       STA.B !player_action                            ;81F6D2;0000D4;
                       BRA CODE_81F6D6                      ;81F6D4;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F6D6: RTS                                  ;81F6D6;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F6D7;      ;
                       %Set16bit(!X)                             ;81F6D9;      ;
                       LDA.W $096F                          ;81F6DB;00096F;
                       CMP.B #$01                           ;81F6DE;      ;
                       BEQ CODE_81F712                      ;81F6E0;81F712;
                       CMP.B #$02                           ;81F6E2;      ;
                       BNE CODE_81F6E9                      ;81F6E4;81F6E9;
                       JMP.W CODE_81F794                    ;81F6E6;81F794;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F6E9: CMP.B #$03                           ;81F6E9;      ;
                       BNE CODE_81F6F0                      ;81F6EB;81F6F0;
                       JMP.W CODE_81F7C6                    ;81F6ED;81F7C6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F6F0: CMP.B #$04                           ;81F6F0;      ;
                       BNE CODE_81F6F7                      ;81F6F2;81F6F7;
                       JMP.W CODE_81F7DD                    ;81F6F4;81F7DD;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F6F7: %Set8bit(!M)                             ;81F6F7;      ;
                       LDA.B #$02                           ;81F6F9;      ;
                       STA.W !inputstate                          ;81F6FB;00019A;
                       LDX.W #$024A                         ;81F6FE;      ;
                       LDA.B #$00                           ;81F701;      ;
                       STA.W $0191                          ;81F703;000191;
                       JSL.L StartTextBox                    ;81F706;83935F;
                       %Set8bit(!M)                             ;81F70A;      ;
                       INC.W $096F                          ;81F70C;00096F;
                       JMP.W CODE_81F7FE                    ;81F70F;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F712: %Set8bit(!M)                             ;81F712;      ;
                       LDA.W !inputstate                          ;81F714;00019A;
                       CMP.B #$02                           ;81F717;      ;
                       BNE CODE_81F71E                      ;81F719;81F71E;
                       JMP.W CODE_81F7FE                    ;81F71B;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F71E: %Set8bit(!M)                             ;81F71E;      ;
                       LDA.W $018F                          ;81F720;00018F;
                       BNE CODE_81F75A                      ;81F723;81F75A;
                       %Set16bit(!M)                             ;81F725;      ;
                       LDA.W #$FFE2                         ;81F727;      ;
                       STA.B $72                            ;81F72A;000072;
                       %Set8bit(!M)                             ;81F72C;      ;
                       LDA.B #$FF                           ;81F72E;      ;
                       STA.B $74                            ;81F730;000074;
                       JSL.L AddMoney                       ;81F732;83B1C9;
                       %Set16bit(!M)                             ;81F736;      ;
                       CMP.W #$0000                         ;81F738;      ;
                       BNE CODE_81F777                      ;81F73B;81F777;
                       %Set8bit(!M)                             ;81F73D;      ;
                       LDA.B #$02                           ;81F73F;      ;
                       STA.W !inputstate                          ;81F741;00019A;
                       LDX.W #$024C                         ;81F744;      ;
                       LDA.B #$00                           ;81F747;      ;
                       STA.W $0191                          ;81F749;000191;
                       JSL.L StartTextBox                    ;81F74C;83935F;
                       %Set8bit(!M)                             ;81F750;      ;
                       LDA.B #$02                           ;81F752;      ;
                       STA.W $096F                          ;81F754;00096F;
                       JMP.W CODE_81F7FE                    ;81F757;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F75A: %Set8bit(!M)                             ;81F75A;      ;
                       LDA.B #$02                           ;81F75C;      ;
                       STA.W !inputstate                          ;81F75E;00019A;
                       LDX.W #$024D                         ;81F761;      ;
                       LDA.B #$00                           ;81F764;      ;
                       STA.W $0191                          ;81F766;000191;
                       JSL.L StartTextBox                    ;81F769;83935F;
                       %Set8bit(!M)                             ;81F76D;      ;
                       LDA.B #$03                           ;81F76F;      ;
                       STA.W $096F                          ;81F771;00096F;
                       JMP.W CODE_81F7FE                    ;81F774;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F777: %Set8bit(!M)                             ;81F777;      ;
                       LDA.B #$02                           ;81F779;      ;
                       STA.W !inputstate                          ;81F77B;00019A;
                       LDX.W #$0213                         ;81F77E;      ;
                       LDA.B #$00                           ;81F781;      ;
                       STA.W $0191                          ;81F783;000191;
                       JSL.L StartTextBox                    ;81F786;83935F;
                       %Set8bit(!M)                             ;81F78A;      ;
                       LDA.B #$03                           ;81F78C;      ;
                       STA.W $096F                          ;81F78E;00096F;
                       JMP.W CODE_81F6D6                    ;81F791;81F6D6;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F794: %Set8bit(!M)                             ;81F794;      ;
                       LDA.W !inputstate                          ;81F796;00019A;
                       CMP.B #$02                           ;81F799;      ;
                       BEQ CODE_81F7FE                      ;81F79B;81F7FE;
                       %Set16bit(!M)                             ;81F79D;      ;
                       %Set16bit(!MX)                             ;81F79F;      ;
                       LDA.W #$0019                         ;81F7A1;      ;
                       STA.B !player_action                            ;81F7A4;0000D4;
                       %Set16bit(!MX)                             ;81F7A6;      ;
                       LDA.W #$00FB                         ;81F7A8;      ;
                       STA.W $0901                          ;81F7AB;000901;
                       JSR.W CODE_81CFE6                    ;81F7AE;81CFE6;
                       %Set16bit(!MX)                             ;81F7B1;      ;
                       LDA.W #$0003                         ;81F7B3;      ;
                       JSL.L AddPlayerHappiness                   ;81F7B6;83B282;
                       %Set8bit(!M)                             ;81F7BA;      ;
                       STZ.W $0970                          ;81F7BC;000970;
                       LDA.B #$04                           ;81F7BF;      ;
                       STA.W $096F                          ;81F7C1;00096F;
                       BRA CODE_81F7FE                      ;81F7C4;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F7C6: %Set8bit(!M)                             ;81F7C6;      ;
                       LDA.W !inputstate                          ;81F7C8;00019A;
                       CMP.B #$02                           ;81F7CB;      ;
                       BEQ CODE_81F7FE                      ;81F7CD;81F7FE;
                       %Set16bit(!MX)                             ;81F7CF;      ;
                       LDA.W #$0040                         ;81F7D1;      ;
                       EOR.W #$FFFF                         ;81F7D4;      ;
                       AND.B !game_state                            ;81F7D7;0000D2;
                       STA.B !game_state                            ;81F7D9;0000D2;
                       BRA CODE_81F7FE                      ;81F7DB;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F7DD: %Set8bit(!M)                             ;81F7DD;      ;
                       INC.W $0970                          ;81F7DF;000970;
                       LDA.W $0970                          ;81F7E2;000970;
                       CMP.B #$64                           ;81F7E5;      ;
                       BNE CODE_81F7FE                      ;81F7E7;81F7FE;
                       %Set16bit(!MX)                             ;81F7E9;      ;
                       LDA.W #$0040                         ;81F7EB;      ;
                       EOR.W #$FFFF                         ;81F7EE;      ;
                       AND.B !game_state                            ;81F7F1;0000D2;
                       STA.B !game_state                            ;81F7F3;0000D2;
                       %Set16bit(!MX)                             ;81F7F5;      ;
                       LDA.W #$0000                         ;81F7F7;      ;
                       STA.B !player_action                            ;81F7FA;0000D4;
                       BRA CODE_81F7FE                      ;81F7FC;81F7FE;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F7FE: RTS                                  ;81F7FE;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F7FF;      ;
                       %Set16bit(!X)                             ;81F801;      ;
                       %Set16bit(!MX)                             ;81F803;      ;
                       LDA.W #$0001                         ;81F805;      ;
                       LDX.W #$0000                         ;81F808;      ;
                       LDY.W #$0000                         ;81F80B;      ;
                       JSL.L CalculateTileinFront                    ;81F80E;81D14E;
                       %Set8bit(!M)                             ;81F812;      ;
                       LDA.B #$14                           ;81F814;      ;
                       STA.W !item_on_hand                          ;81F816;00091D;
                       %Set16bit(!MX)                             ;81F819;      ;
                       LDA.W #$0004                         ;81F81B;      ;
                       STA.B !player_action                            ;81F81E;0000D4;
                       %Set16bit(!MX)                             ;81F820;      ;
                       LDA.W #$0040                         ;81F822;      ;
                       EOR.W #$FFFF                         ;81F825;      ;
                       AND.B !game_state                            ;81F828;0000D2;
                       STA.B !game_state                            ;81F82A;0000D2;
                       %Set16bit(!MX)                             ;81F82C;      ;
                       LDA.W !tile_in_front_X                          ;81F82E;000985;
                       LSR A                                ;81F831;      ;
                       LSR A                                ;81F832;      ;
                       LSR A                                ;81F833;      ;
                       LSR A                                ;81F834;      ;
                       ASL A                                ;81F835;      ;
                       ASL A                                ;81F836;      ;
                       ASL A                                ;81F837;      ;
                       ASL A                                ;81F838;      ;
                       STA.B $7E                            ;81F839;00007E;
                       LDY.W #$0000                         ;81F83B;      ;
                                                            ;      ;      ;
          CODE_81F83E: %Set16bit(!MX)                             ;81F83E;      ;
                       TYA                                  ;81F840;      ;
                       ASL A                                ;81F841;      ;
                       ASL A                                ;81F842;      ;
                       TAX                                  ;81F843;      ;
                       LDA.L $83CA10,X                      ;81F844;83CA10;
                       SEC                                  ;81F848;      ;
                       SBC.W #$0008                         ;81F849;      ;
                       CMP.B $7E                            ;81F84C;00007E;
                       BEQ CODE_81F858                      ;81F84E;81F858;
                       INY                                  ;81F850;      ;
                       CPY.W #$000D                         ;81F851;      ;
                       BNE CODE_81F83E                      ;81F854;81F83E;
                                                            ;      ;      ;
          CODE_81F856: BRA CODE_81F856                      ;81F856;81F856;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F858: TYA                                  ;81F858;      ;
                       ASL A                                ;81F859;      ;
                       TAX                                  ;81F85A;      ;
                       LDA.L DATA16_81FAD4,X                ;81F85B;81FAD4;
                       AND.L $7F1F45                        ;81F85F;7F1F45;
                       STA.L $7F1F45                        ;81F863;7F1F45;
                       BRA CODE_81F869                      ;81F867;81F869;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F869: RTS                                  ;81F869;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F86A;      ;
                       %Set16bit(!X)                             ;81F86C;      ;
                       LDA.W $096F                          ;81F86E;00096F;
                       CMP.B #$01                           ;81F871;      ;
                       BEQ CODE_81F890                      ;81F873;81F890;
                       %Set8bit(!M)                             ;81F875;      ;
                       LDA.B #$02                           ;81F877;      ;
                       STA.W !inputstate                          ;81F879;00019A;
                       LDX.W #$0455                         ;81F87C;      ;
                       LDA.B #$00                           ;81F87F;      ;
                       STA.W $0191                          ;81F881;000191;
                       JSL.L StartTextBox                    ;81F884;83935F;
                       %Set8bit(!M)                             ;81F888;      ;
                       INC.W $096F                          ;81F88A;00096F;
                       JMP.W CODE_81F91E                    ;81F88D;81F91E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F890: %Set16bit(!MX)                             ;81F890;      ;
                       LDA.W !Joy1_Current                          ;81F892;000124;
                       BIT.W #$8000                         ;81F895;      ;
                       BEQ CODE_81F89D                      ;81F898;81F89D;
                       JMP.W CODE_81F91F                    ;81F89A;81F91F;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F89D: %Set8bit(!M)                             ;81F89D;      ;
                       LDA.W !inputstate                          ;81F89F;00019A;
                       CMP.B #$02                           ;81F8A2;      ;
                       BNE CODE_81F8A9                      ;81F8A4;81F8A9;
                       JMP.W CODE_81F91E                    ;81F8A6;81F91E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F8A9: LDA.W $018F                          ;81F8A9;00018F;
                       CMP.B #$00                           ;81F8AC;      ;
                       BEQ CODE_81F8B8                      ;81F8AE;81F8B8;
                       CMP.B #$01                           ;81F8B0;      ;
                       BEQ CODE_81F8DA                      ;81F8B2;81F8DA;
                       CMP.B #$02                           ;81F8B4;      ;
                       BEQ CODE_81F8FC                      ;81F8B6;81F8FC;
                                                            ;      ;      ;
          CODE_81F8B8: %Set8bit(!M)                             ;81F8B8;      ;
                       LDA.B #$02                           ;81F8BA;      ;
                       STA.W !inputstate                          ;81F8BC;00019A;
                       LDX.W #$0456                         ;81F8BF;      ;
                       LDA.B #$00                           ;81F8C2;      ;
                       STA.W $0191                          ;81F8C4;000191;
                       JSL.L StartTextBox                    ;81F8C7;83935F;
                       %Set16bit(!MX)                             ;81F8CB;      ;
                       LDA.W #$0040                         ;81F8CD;      ;
                       EOR.W #$FFFF                         ;81F8D0;      ;
                       AND.B !game_state                            ;81F8D3;0000D2;
                       STA.B !game_state                            ;81F8D5;0000D2;
                       JMP.W CODE_81F91E                    ;81F8D7;81F91E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F8DA: %Set8bit(!M)                             ;81F8DA;      ;
                       LDA.B #$02                           ;81F8DC;      ;
                       STA.W !inputstate                          ;81F8DE;00019A;
                       LDX.W #$0457                         ;81F8E1;      ;
                       LDA.B #$00                           ;81F8E4;      ;
                       STA.W $0191                          ;81F8E6;000191;
                       JSL.L StartTextBox                    ;81F8E9;83935F;
                       %Set16bit(!MX)                             ;81F8ED;      ;
                       LDA.W #$0040                         ;81F8EF;      ;
                       EOR.W #$FFFF                         ;81F8F2;      ;
                       AND.B !game_state                            ;81F8F5;0000D2;
                       STA.B !game_state                            ;81F8F7;0000D2;
                       JMP.W CODE_81F91E                    ;81F8F9;81F91E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F8FC: %Set8bit(!M)                             ;81F8FC;      ;
                       LDA.B #$02                           ;81F8FE;      ;
                       STA.W !inputstate                          ;81F900;00019A;
                       LDX.W #$0458                         ;81F903;      ;
                       LDA.B #$00                           ;81F906;      ;
                       STA.W $0191                          ;81F908;000191;
                       JSL.L StartTextBox                    ;81F90B;83935F;
                       %Set16bit(!MX)                             ;81F90F;      ;
                       LDA.W #$0040                         ;81F911;      ;
                       EOR.W #$FFFF                         ;81F914;      ;
                       AND.B !game_state                            ;81F917;0000D2;
                       STA.B !game_state                            ;81F919;0000D2;
                       JMP.W CODE_81F91E                    ;81F91B;81F91E;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F91E: RTS                                  ;81F91E;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F91F: JSL.L CODE_8393F9                    ;81F91F;8393F9;
                       %Set8bit(!M)                             ;81F923;      ;
                       LDA.B #$01                           ;81F925;      ;
                       STA.W !inputstate                          ;81F927;00019A;
                       %Set16bit(!M)                             ;81F92A;      ;
                       LDA.W !Joy1_New_Input                          ;81F92C;000128;
                       AND.W #$FF7F                         ;81F92F;      ;
                       STA.W !Joy1_New_Input                          ;81F932;000128;
                       %Set16bit(!MX)                             ;81F935;      ;
                       LDA.W #$0040                         ;81F937;      ;
                       EOR.W #$FFFF                         ;81F93A;      ;
                       AND.B !game_state                            ;81F93D;0000D2;
                       STA.B !game_state                            ;81F93F;0000D2;
                       RTS                                  ;81F941;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81F942;      ;
                       %Set16bit(!X)                             ;81F944;      ;
                       LDA.W $096F                          ;81F946;00096F;
                       CMP.B #$01                           ;81F949;      ;
                       BEQ CODE_81F968                      ;81F94B;81F968;
                       %Set8bit(!M)                             ;81F94D;      ;
                       LDA.B #$02                           ;81F94F;      ;
                       STA.W !inputstate                          ;81F951;00019A;
                       LDX.W #$0459                         ;81F954;      ;
                       LDA.B #$00                           ;81F957;      ;
                       STA.W $0191                          ;81F959;000191;
                       JSL.L StartTextBox                    ;81F95C;83935F;
                       %Set8bit(!M)                             ;81F960;      ;
                       INC.W $096F                          ;81F962;00096F;
                       JMP.W CODE_81FA45                    ;81F965;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F968: %Set16bit(!MX)                             ;81F968;      ;
                       LDA.W !Joy1_Current                          ;81F96A;000124;
                       BIT.W #$8000                         ;81F96D;      ;
                       BEQ CODE_81F975                      ;81F970;81F975;
                       JMP.W CODE_81FA46                    ;81F972;81FA46;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F975: %Set8bit(!M)                             ;81F975;      ;
                       LDA.W !inputstate                          ;81F977;00019A;
                       CMP.B #$02                           ;81F97A;      ;
                       BNE CODE_81F981                      ;81F97C;81F981;
                       JMP.W CODE_81FA45                    ;81F97E;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F981: LDA.W $018F                          ;81F981;00018F;
                       CMP.B #$00                           ;81F984;      ;
                       BEQ CODE_81F99B                      ;81F986;81F99B;
                       CMP.B #$01                           ;81F988;      ;
                       BEQ CODE_81F9BD                      ;81F98A;81F9BD;
                       CMP.B #$02                           ;81F98C;      ;
                       BEQ CODE_81F9DF                      ;81F98E;81F9DF;
                       CMP.B #$03                           ;81F990;      ;
                       BEQ CODE_81FA01                      ;81F992;81FA01;
                       CMP.B #$04                           ;81F994;      ;
                       BNE CODE_81F99B                      ;81F996;81F99B;
                       JMP.W CODE_81FA23                    ;81F998;81FA23;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F99B: %Set8bit(!M)                             ;81F99B;      ;
                       LDA.B #$02                           ;81F99D;      ;
                       STA.W !inputstate                          ;81F99F;00019A;
                       LDX.W #$045A                         ;81F9A2;      ;
                       LDA.B #$00                           ;81F9A5;      ;
                       STA.W $0191                          ;81F9A7;000191;
                       JSL.L StartTextBox                    ;81F9AA;83935F;
                       %Set16bit(!MX)                             ;81F9AE;      ;
                       LDA.W #$0040                         ;81F9B0;      ;
                       EOR.W #$FFFF                         ;81F9B3;      ;
                       AND.B !game_state                            ;81F9B6;0000D2;
                       STA.B !game_state                            ;81F9B8;0000D2;
                       JMP.W CODE_81FA45                    ;81F9BA;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F9BD: %Set8bit(!M)                             ;81F9BD;      ;
                       LDA.B #$02                           ;81F9BF;      ;
                       STA.W !inputstate                          ;81F9C1;00019A;
                       LDX.W #$045B                         ;81F9C4;      ;
                       LDA.B #$00                           ;81F9C7;      ;
                       STA.W $0191                          ;81F9C9;000191;
                       JSL.L StartTextBox                    ;81F9CC;83935F;
                       %Set16bit(!MX)                             ;81F9D0;      ;
                       LDA.W #$0040                         ;81F9D2;      ;
                       EOR.W #$FFFF                         ;81F9D5;      ;
                       AND.B !game_state                            ;81F9D8;0000D2;
                       STA.B !game_state                            ;81F9DA;0000D2;
                       JMP.W CODE_81FA45                    ;81F9DC;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81F9DF: %Set8bit(!M)                             ;81F9DF;      ;
                       LDA.B #$02                           ;81F9E1;      ;
                       STA.W !inputstate                          ;81F9E3;00019A;
                       LDX.W #$045C                         ;81F9E6;      ;
                       LDA.B #$00                           ;81F9E9;      ;
                       STA.W $0191                          ;81F9EB;000191;
                       JSL.L StartTextBox                    ;81F9EE;83935F;
                       %Set16bit(!MX)                             ;81F9F2;      ;
                       LDA.W #$0040                         ;81F9F4;      ;
                       EOR.W #$FFFF                         ;81F9F7;      ;
                       AND.B !game_state                            ;81F9FA;0000D2;
                       STA.B !game_state                            ;81F9FC;0000D2;
                       JMP.W CODE_81FA45                    ;81F9FE;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81FA01: %Set8bit(!M)                             ;81FA01;      ;
                       LDA.B #$02                           ;81FA03;      ;
                       STA.W !inputstate                          ;81FA05;00019A;
                       LDX.W #$045D                         ;81FA08;      ;
                       LDA.B #$00                           ;81FA0B;      ;
                       STA.W $0191                          ;81FA0D;000191;
                       JSL.L StartTextBox                    ;81FA10;83935F;
                       %Set16bit(!MX)                             ;81FA14;      ;
                       LDA.W #$0040                         ;81FA16;      ;
                       EOR.W #$FFFF                         ;81FA19;      ;
                       AND.B !game_state                            ;81FA1C;0000D2;
                       STA.B !game_state                            ;81FA1E;0000D2;
                       JMP.W CODE_81FA45                    ;81FA20;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81FA23: %Set8bit(!M)                             ;81FA23;      ;
                       LDA.B #$02                           ;81FA25;      ;
                       STA.W !inputstate                          ;81FA27;00019A;
                       LDX.W #$045E                         ;81FA2A;      ;
                       LDA.B #$00                           ;81FA2D;      ;
                       STA.W $0191                          ;81FA2F;000191;
                       JSL.L StartTextBox                    ;81FA32;83935F;
                       %Set16bit(!MX)                             ;81FA36;      ;
                       LDA.W #$0040                         ;81FA38;      ;
                       EOR.W #$FFFF                         ;81FA3B;      ;
                       AND.B !game_state                            ;81FA3E;0000D2;
                       STA.B !game_state                            ;81FA40;0000D2;
                       JMP.W CODE_81FA45                    ;81FA42;81FA45;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81FA45: RTS                                  ;81FA45;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
          CODE_81FA46: JSL.L CODE_8393F9                    ;81FA46;8393F9;
                       %Set8bit(!M)                             ;81FA4A;      ;
                       LDA.B #$01                           ;81FA4C;      ;
                       STA.W !inputstate                          ;81FA4E;00019A;
                       %Set16bit(!M)                             ;81FA51;      ;
                       LDA.W !Joy1_New_Input                          ;81FA53;000128;
                       AND.W #$FF7F                         ;81FA56;      ;
                       STA.W !Joy1_New_Input                          ;81FA59;000128;
                       %Set16bit(!MX)                             ;81FA5C;      ;
                       LDA.W #$0040                         ;81FA5E;      ;
                       EOR.W #$FFFF                         ;81FA61;      ;
                       AND.B !game_state                            ;81FA64;0000D2;
                       STA.B !game_state                            ;81FA66;0000D2;
                       RTS                                  ;81FA68;      ;
                                                            ;      ;      ;
                       %Set8bit(!M)                             ;81FA69;      ;
                       %Set16bit(!X)                             ;81FA6B;      ;
                       INC.W $0970                          ;81FA6D;000970;
                       LDA.W $0970                          ;81FA70;000970;
                       CMP.B #$02                           ;81FA73;      ;
                       BNE CODE_81FA83                      ;81FA75;81FA83;
                       %Set16bit(!MX)                             ;81FA77;      ;
                       LDA.W #$0040                         ;81FA79;      ;
                       EOR.W #$FFFF                         ;81FA7C;      ;
                       AND.B !game_state                            ;81FA7F;0000D2;
                       STA.B !game_state                            ;81FA81;0000D2;
                                                            ;      ;      ;
          CODE_81FA83: RTS                                  ;81FA83;      ;
                                                            ;      ;      ;
                       %Set16bit(!MX)                             ;81FA84;      ;
                       LDX.W #$0491                         ;81FA86;      ;
                       LDA.L $7F1F66                        ;81FA89;7F1F66;
                       AND.W #$0002                         ;81FA8D;      ;
                       BNE CODE_81FA95                      ;81FA90;81FA95;
                       LDX.W #$0246                         ;81FA92;      ;
                                                            ;      ;      ;
          CODE_81FA95: %Set8bit(!M)                             ;81FA95;      ;
                       %Set16bit(!X)                             ;81FA97;      ;
                       LDA.B #$02                           ;81FA99;      ;
                       STA.W !inputstate                          ;81FA9B;00019A;
                       LDA.B #$00                           ;81FA9E;      ;
                       STA.W $0191                          ;81FAA0;000191;
                       JSL.L StartTextBox                    ;81FAA3;83935F;
                       %Set16bit(!MX)                             ;81FAA7;      ;
                       LDA.W #$0040                         ;81FAA9;      ;
                       EOR.W #$FFFF                         ;81FAAC;      ;
                       AND.B !game_state                            ;81FAAF;0000D2;
                       STA.B !game_state                            ;81FAB1;0000D2;
                       RTS                                  ;81FAB3;      ;
                                                            ;      ;      ;
                                                            ;      ;      ;
        DATA16_81FAB4: dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080;81FAB4;      ;
                       dw $0100,$0200,$0400,$0800,$1000,$2000,$4000,$8000;81FAC4;      ;
                                                            ;      ;      ;
        DATA16_81FAD4: dw $FFFE,$FFFD,$FFFB,$FFF7,$FFEF,$FFDF,$FFBF,$FF7F;81FAD4;      ;
                       dw $FEFF,$FDFF,$FBFF,$F7FF,$EFFF,$DFFF,$BFFF,$7FFF;81FAE4;      ;
                       db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;81FAF4;      ;