;;;;;;;;
PSUB_82931E: ;82931E
        %Set16bit(!MX)
        %Set16bit(!MX)                             ;829320;      ;
        LDA.W #$0000                         ;829322;      ;
        STA.B !player_action                            ;829325;0000D4;

        RTS                                  ;829327;      ;

;;;;;;;;
PSUB_829328: ;829328
        %Set16bit(!MX)                             ;      ;
        JSR.W SUB_8292A0                    ;82932A;8292A0;
        BNE .CODE_829332                      ;82932D;829332;
        JMP.W .return                    ;82932F;829450;

    .CODE_829332:
        %Set8bit(!M)                             ;829332;      ;
        LDA.L !season                        ;829334;7F1F19;
        CMP.B #$03                           ;829338;      ;
        BNE .CODE_82933F                      ;82933A;82933F;
        JMP.W .return                    ;82933C;829450;

    .CODE_82933F:
        LDA.B !tilemap_to_load                            ;82933F;000022;
        CMP.B #$04                           ;829341;      ;
        BCC .CODE_82935A                      ;829343;82935A;
        %Set16bit(!M)                             ;829345;      ;
        CPX.W #$0035                         ;829347;      ;
        BEQ .CODE_829352                      ;82934A;829352;
        LDA.W #$00DD                         ;82934C;      ;
        JMP.W .CODE_8293C8                    ;82934F;8293C8;

    .CODE_829352:
        %Set16bit(!M)                             ;829352;      ;
        LDA.W #$00DE                         ;829354;      ;
        JMP.W .CODE_8293C8                    ;829357;8293C8;

    .CODE_82935A:
        %Set16bit(!M)                             ;82935A;      ;
        CPX.W #$0003                         ;82935C;      ;
        BEQ .CODE_82936C                      ;82935F;82936C;
        CPX.W #$0079                         ;829361;      ;
        BEQ .CODE_829374                      ;829364;829374;
        LDA.W #$0017                         ;829366;      ;
        JMP.W .CODE_8293C8                    ;829369;8293C8;

    .CODE_82936C:
        %Set16bit(!M)                             ;82936C;      ;
        LDA.W #$000E                         ;82936E;      ;
        JMP.W .CODE_8293C8                    ;829371;8293C8;

    .CODE_829374:
        %Set16bit(!M)                             ;829374;      ;
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
        BRA .CODE_829403                      ;8293C6;829403;

    .CODE_8293C8:
        LDX.W $0985                          ;8293C8;000985;
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

    .CODE_829403:
        %Set8bit(!M)                             ;829403;      ;
        LDA.L !season                        ;829405;7F1F19;
        CMP.B #$01                           ;829409;      ;
        BNE .return                      ;82940B;829450;
        %Set16bit(!M)                             ;82940D;      ;
        LDA.L $7F1F60                        ;82940F;7F1F60;
        AND.W #$0008                         ;829413;      ;
        BNE .return                      ;829416;829450;
        LDA.L $7F1F5A                        ;829418;7F1F5A;
        AND.W #$2000                         ;82941C;      ;
        BNE .return                      ;82941F;829450;
        %Set8bit(!M)                             ;829421;      ;
        LDA.B #$10                           ;829423;      ;
        JSL.L RNGReturn0toA                  ;829425;8089F9;
        BNE .return                      ;829429;829450;
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
    .return:
        %Set16bit(!MX)                             ;829450;      ;
        LDA.W #$0000                         ;829452;      ;
        STA.B !player_action                            ;829455;0000D4;
        %Set8bit(!M)                             ;829457;      ;
        LDA.B #$FE                           ;829459;      ;
        JSL.L ChangeStamina                    ;82945B;81D061;
        RTS                                  ;82945F;      ;
;;;;;;;;
PSUB_829460: ;829460
        %Set16bit(!MX)                             ;829460;      ;
        JSR.W SUB_8292A0                    ;829462;8292A0;
        BNE .CODE_82946A                      ;829465;82946A;
        JMP.W .return                    ;829467;8295B0;


    .CODE_82946A:
        %Set16bit(!M)                             ;82946A;      ;
        LDA.W #$0017                         ;82946C;      ;
        LDX.W $0985                          ;82946F;000985;
        LDY.W $0987                          ;829472;000987;
        JSL.L CODE_81A688                    ;829475;81A688;
        %Set8bit(!M)                             ;829479;      ;
        LDA.L !season                        ;82947B;7F1F19;
        CMP.B #$02                           ;82947F;      ;
        BCS .CODE_8294C5                      ;829481;8294C5;
        %Set16bit(!M)                             ;829483;      ;
        LDA.L $7F1F60                        ;829485;7F1F60;
        AND.W #$0008                         ;829489;      ;
        BNE .CODE_8294C5                      ;82948C;8294C5;
        LDA.L $7F1F5A                        ;82948E;7F1F5A;
        AND.W #$1000                         ;829492;      ;
        BNE .CODE_8294C5                      ;829495;8294C5;
        %Set8bit(!M)                             ;829497;      ;
        LDA.B #$20                           ;829499;      ;
        JSL.L RNGReturn0toA                  ;82949B;8089F9;
        BNE .CODE_8294C5                      ;82949F;8294C5;
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
        JMP.W .return                    ;8294C2;8295B0;

    .CODE_8294C5:
        %Set16bit(!MX)                             ;8294C5;      ;
        LDA.L $7F1F60                        ;8294C7;7F1F60;
        AND.W #$0008                         ;8294CB;      ;
        BNE .CODE_82954A                      ;8294CE;82954A;
        LDA.L $7F1F5C                        ;8294D0;7F1F5C;
        AND.W #$0200                         ;8294D4;      ;
        BNE .CODE_82954A                      ;8294D7;82954A;
        %Set8bit(!M)                             ;8294D9;      ;
        LDA.B #$10                           ;8294DB;      ;
        JSL.L RNGReturn0toA                  ;8294DD;8089F9;
        BNE .CODE_829511                      ;8294E1;829511;
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
        JMP.W .return                    ;82950E;8295B0;

    .CODE_829511:
        %Set8bit(!M)                             ;829511;      ;
        LDA.B #$10                           ;829513;      ;
        JSL.L RNGReturn0toA                  ;829515;8089F9;
        BNE .CODE_82954A                      ;829519;82954A;
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
        BRA .return                      ;829548;8295B0;

    .CODE_82954A:
        %Set8bit(!M)                             ;82954A;      ;
        LDA.B #$40                           ;82954C;      ;
        JSL.L RNGReturn0toA                  ;82954E;8089F9;
        BNE .return                      ;829552;8295B0;
        %Set16bit(!MX)                             ;829554;      ;
        LDA.L $7F1F60                        ;829556;7F1F60;
        AND.W #$0008                         ;82955A;      ;
        BNE .return                      ;82955D;8295B0;
        LDA.L $7F1F5C                        ;82955F;7F1F5C;
        AND.W #$0100                         ;829563;      ;
        BNE .return                      ;829566;8295B0;
        LDA.L $7F1F5C                        ;829568;7F1F5C;
        ORA.W #$0100                         ;82956C;      ;
        STA.L $7F1F5C                        ;82956F;7F1F5C;
        LDA.L $7F1F64                        ;829573;7F1F64;
        AND.W #$0800                         ;829577;      ;
        BNE .CODE_829589                      ;82957A;829589;
        LDA.L $7F1F64                        ;82957C;7F1F64;
        ORA.W #$0800                         ;829580;      ;
        STA.L $7F1F64                        ;829583;7F1F64;
        BRA .CODE_82959F                      ;829587;82959F;

    .CODE_829589:
        %Set16bit(!MX)                             ;829589;      ;
        LDA.L $7F1F64                        ;82958B;7F1F64;
        AND.W #$1000                         ;82958F;      ;
        BNE .return                      ;829592;8295B0;
        LDA.L $7F1F64                        ;829594;7F1F64;
        ORA.W #$1000                         ;829598;      ;
        STA.L $7F1F64                        ;82959B;7F1F64;

    .CODE_82959F:
        %Set16bit(!MX)                             ;82959F;      ;
        LDA.W #$0010                         ;8295A1;      ;
        LDX.W #$0000                         ;8295A4;      ;
        LDY.W #$001F                         ;8295A7;      ;
        JSL.L CODE_8480F8                    ;8295AA;8480F8;
        BRA .return                      ;8295AE;8295B0;

    .return:
        %Set16bit(!MX)                             ;8295B0;      ;
        LDA.W #$0000                         ;8295B2;      ;
        STA.B !player_action                            ;8295B5;0000D4;
        %Set8bit(!M)                             ;8295B7;      ;
        LDA.B #$FE                           ;8295B9;      ;
        JSL.L ChangeStamina                    ;8295BB;81D061;

        RTS                                  ;8295BF;      ;

;;;;;;;;
PSUB_8295C0: ;8295C0
        %Set16bit(!MX)                             ;8295C0;      ;
        JSR.W SUB_8292A0                    ;8295C2;8292A0;
        BNE .CODE_8295CA                      ;8295C5;8295CA;
        JMP.W .CODE_82973F                    ;8295C7;82973F;

    .CODE_8295CA:
        CPX.W #$0006                         ;8295CA;      ;
        BEQ .CODE_829633                      ;8295CD;829633;
        CPX.W #$0004                         ;8295CF;      ;
        BNE .CODE_829645                      ;8295D2;829645;
        %Set8bit(!M)                             ;8295D4;      ;
        LDA.B !tilemap_to_load                            ;8295D6;000022;
        CMP.B #$04                           ;8295D8;      ;
        BCC .CODE_8295F0                      ;8295DA;8295F0;
        LDA.B !tilemap_to_load                            ;8295DC;000022;
        CMP.B #$29                           ;8295DE;      ;
        BCS .CODE_8295E9                      ;8295E0;8295E9;
        %Set16bit(!M)                             ;8295E2;      ;
        LDA.W #$00DD                         ;8295E4;      ;
        BRA .CODE_8295F5                      ;8295E7;8295F5;

    .CODE_8295E9:
        %Set16bit(!M)                             ;8295E9;      ;
        LDA.W #$00E3                         ;8295EB;      ;
        BRA .CODE_8295F5                      ;8295EE;8295F5;

    .CODE_8295F0:
        %Set16bit(!M)                             ;8295F0;      ;
        LDA.W #$000E                         ;8295F2;      ;

    .CODE_8295F5:
        LDX.W $0985                          ;8295F5;000985;
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
        JMP.W .loop                    ;829630;82972F;

    .CODE_829633:
        %Set16bit(!M)                             ;829633;      ;
        LDA.W #$000E                         ;829635;      ;
        LDX.W $0985                          ;829638;000985;
        LDY.W $0987                          ;82963B;000987;
        JSL.L CODE_81A688                    ;82963E;81A688;
        JMP.W .loop                    ;829642;82972F;

    .CODE_829645:
        %Set8bit(!M)                             ;829645;      ;
        LDA.W $096D                          ;829647;00096D;
        INC A                                ;82964A;      ;
        STA.W $096D                          ;82964B;00096D;
        CMP.B #$06                           ;82964E;      ;
        BEQ .CODE_829655                      ;829650;829655;
        JMP.W .CODE_8296FE                    ;829652;8296FE;

    .CODE_829655:
        STZ.W $096D                          ;829655;00096D;
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
        BEQ .CODE_8296A5                      ;829671;8296A5;
        LDA.W $0985                          ;829673;000985;
        CLC                                  ;829676;      ;
        ADC.W #$0010                         ;829677;      ;
        STA.W $0985                          ;82967A;000985;
        CPX.W #$000F                         ;82967D;      ;
        BEQ .CODE_8296A5                      ;829680;8296A5;
        LDA.W $0985                          ;829682;000985;
        SEC                                  ;829685;      ;
        SBC.W #$0010                         ;829686;      ;
        STA.W $0985                          ;829689;000985;
        LDA.W $0987                          ;82968C;000987;
        CLC                                  ;82968F;      ;
        ADC.W #$0010                         ;829690;      ;
        STA.W $0987                          ;829693;000987;
        CPX.W #$000E                         ;829696;      ;
        BEQ .CODE_8296A5                      ;829699;8296A5;
        LDA.W $0985                          ;82969B;000985;
        CLC                                  ;82969E;      ;
        ADC.W #$0010                         ;82969F;      ;
        STA.W $0985                          ;8296A2;000985;

    .CODE_8296A5:
        %Set8bit(!M)                             ;8296A5;      ;
        LDA.B !tilemap_to_load                            ;8296A7;000022;
        CMP.B #$04                           ;8296A9;      ;
        BCC .CODE_8296B4                      ;8296AB;8296B4;
        %Set16bit(!M)                             ;8296AD;      ;
        LDA.W #$00DF                         ;8296AF;      ;
        BRA .CODE_8296B9                      ;8296B2;8296B9;

    .CODE_8296B4:
        %Set16bit(!M)                             ;8296B4;      ;
        LDA.W #$000D                         ;8296B6;      ;

    .CODE_8296B9:
        LDX.W $0985                          ;8296B9;000985;
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
        BRA .loop                      ;8296FC;82972F;

    .CODE_8296FE:
        %Set16bit(!M)                             ;8296FE;      ;
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

    .loop:
        %Set16bit(!MX)                             ;82972F;      ;
        LDA.W #$0000                         ;829731;      ;
        STA.B !player_action                            ;829734;0000D4;
        %Set8bit(!M)                             ;829736;      ;
        LDA.B #$FE                           ;829738;      ;
        JSL.L ChangeStamina                    ;82973A;81D061;

        RTS                                  ;82973E;      ;

    .CODE_82973F:
        %Set8bit(!M)                             ;82973F;      ;
        %Set16bit(!X)                             ;829741;      ;
        LDA.B !tilemap_to_load                            ;829743;000022;
        CMP.B #$0C                           ;829745;      ;
        BCC .loop                      ;829747;82972F;
        CMP.B #$10                           ;829749;      ;
        BCS .loop                      ;82974B;82972F;
        CPX.W #$00F8                         ;82974D;      ;
        BNE .loop                      ;829750;82972F;
        %Set16bit(!MX)                             ;829752;      ;
        LDA.L $7F1F5C                        ;829754;7F1F5C;
        AND.W #$0080                         ;829758;      ;
        BNE .loop                      ;82975B;82972F;
        %Set16bit(!M)                             ;82975D;      ;
        LDA.W #$0015                         ;82975F;      ;
        LDX.W #$0000                         ;829762;      ;
        LDY.W #$0016                         ;829765;      ;
        JSL.L CODE_84803F                    ;829768;84803F;
        %Set8bit(!M)                             ;82976C;      ;
        LDA.B #$04                           ;82976E;      ;
        JSL.L RNGReturn0toA                  ;829770;8089F9;
        BNE .loop                      ;829774;82972F;
        %Set16bit(!MX)                             ;829776;      ;
        LDA.L $7F1F64                        ;829778;7F1F64;
        AND.W #$0200                         ;82977C;      ;
        BNE .loop                      ;82977F;82972F;
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
        JMP.W .loop                    ;8297BA;82972F;


;;;;;;;;
PSUB_8297BD: ;8297BD
        %Set16bit(!MX)                             ;8297BD;      ;
        JSR.W SUB_8292A0                    ;8297BF;8292A0;
        BNE .CODE_8297C7                      ;8297C2;8297C7;
        JMP.W .CODE_82994B                    ;8297C4;82994B;
                                        ;      ;      ;
                                        ;      ;      ;
    .CODE_8297C7:
        %Set8bit(!M)                             ;8297C7;      ;
        LDA.W $096D                          ;8297C9;00096D;
        INC A                                ;8297CC;      ;
        STA.W $096D                          ;8297CD;00096D;
        CMP.B #$06                           ;8297D0;      ;
        BEQ .CODE_8297D7                      ;8297D2;8297D7;
        JMP.W .CODE_829918                    ;8297D4;829918;

    .CODE_8297D7:
        STZ.W $096D                          ;8297D7;00096D;
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
        BEQ .CODE_829849                      ;8297F3;829849;
        CPX.W #$0014                         ;8297F5;      ;
        BNE .CODE_8297FD                      ;8297F8;8297FD;
        JMP.W .CODE_8298BC                    ;8297FA;8298BC;

    .CODE_8297FD:
        LDA.W $0985                          ;8297FD;000985;
        CLC                                  ;829800;      ;
        ADC.W #$0010                         ;829801;      ;
        STA.W $0985                          ;829804;000985;
        CPX.W #$000B                         ;829807;      ;
        BEQ .CODE_829849                      ;82980A;829849;
        CPX.W #$0013                         ;82980C;      ;
        BNE .CODE_829814                      ;82980F;829814;
        JMP.W .CODE_8298BC                    ;829811;8298BC;

    .CODE_829814:
        LDA.W $0985                          ;829814;000985;
        SEC                                  ;829817;      ;
        SBC.W #$0010                         ;829818;      ;
        STA.W $0985                          ;82981B;000985;
        LDA.W $0987                          ;82981E;000987;
        CLC                                  ;829821;      ;
        ADC.W #$0010                         ;829822;      ;
        STA.W $0987                          ;829825;000987;
        CPX.W #$000A                         ;829828;      ;
        BEQ .CODE_829849                      ;82982B;829849;
        CPX.W #$0012                         ;82982D;      ;
        BNE .CODE_829835                      ;829830;829835;
        JMP.W .CODE_8298BC                    ;829832;8298BC;

    .CODE_829835:
        LDA.W $0985                          ;829835;000985;
        CLC                                  ;829838;      ;
        ADC.W #$0010                         ;829839;      ;
        STA.W $0985                          ;82983C;000985;
        CPX.W #$0009                         ;82983F;      ;
        BEQ .CODE_829849                      ;829842;829849;
        CPX.W #$0011                         ;829844;      ;
        BEQ .CODE_8298BC                      ;829847;8298BC;

    .CODE_829849:
        %Set8bit(!M)                             ;829849;      ;
        LDA.B !tilemap_to_load                            ;82984B;000022;
        CMP.B #$04                           ;82984D;      ;
        BCC .CODE_8298C3                      ;82984F;8298C3;
        %Set16bit(!M)                             ;829851;      ;
        LDA.L $7F1F60                        ;829853;7F1F60;
        AND.W #$0008                         ;829857;      ;
        BNE .CODE_8298B5                      ;82985A;8298B5;
        %Set8bit(!M)                             ;82985C;      ;
        LDA.B #$10                           ;82985E;      ;
        JSL.L RNGReturn0toA                  ;829860;8089F9;
        BNE .CODE_8298B5                      ;829864;8298B5;
        %Set16bit(!MX)                             ;829866;      ;
        LDA.L $7F1F64                        ;829868;7F1F64;
        AND.W #$0400                         ;82986C;      ;
        BNE .CODE_8298B5                      ;82986F;8298B5;
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

    .CODE_8298B5:
        %Set16bit(!MX)                             ;8298B5;      ;
        LDA.W #$00DF                         ;8298B7;      ;
        BRA .CODE_8298C8                      ;8298BA;8298C8;

    .CODE_8298BC:
        %Set16bit(!MX)                             ;8298BC;      ;
        LDA.W #$00E0                         ;8298BE;      ;
        BRA .CODE_8298C8                      ;8298C1;8298C8;

    .CODE_8298C3:
        %Set16bit(!MX)                             ;8298C3;      ;
        LDA.W #$000D                         ;8298C5;      ;

    .CODE_8298C8:
        %Set16bit(!MX)                             ;8298C8;      ;
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
        BRA .CODE_829989                      ;829916;829989;

    .CODE_829918:
        %Set16bit(!M)                             ;829918;      ;
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
        BRA .CODE_829989                      ;829949;829989;

    .CODE_82994B:
        %Set8bit(!M)                             ;82994B;      ;
        LDA.B !tilemap_to_load                            ;82994D;000022;
        CMP.B #$10                           ;82994F;      ;
        BCC .CODE_829989                      ;829951;829989;
        CMP.B #$14                           ;829953;      ;
        BCS .CODE_829989                      ;829955;829989;
        CPX.W #$00F4                         ;829957;      ;
        BNE .CODE_829989                      ;82995A;829989;
        %Set16bit(!MX)                             ;82995C;      ;
        LDA.W $0196                          ;82995E;000196;
        AND.W #$001A                         ;829961;      ;
        BNE .CODE_829989                      ;829964;829989;
        LDA.L $7F1F6A                        ;829966;7F1F6A;
        AND.W #$0020                         ;82996A;      ;
        BNE .CODE_829989                      ;82996D;829989;
        LDA.L $7F1F6A                        ;82996F;7F1F6A;
        ORA.W #$0020                         ;829973;      ;
        STA.L $7F1F6A                        ;829976;7F1F6A;
        %Set16bit(!MX)                             ;82997A;      ;
        LDA.W #$0000                         ;82997C;      ;
        LDX.W #$0017                         ;82997F;      ;
        LDY.W #$0000                         ;829982;      ;
        JSL.L VIP                            ;829985;848097;
                                        ;      ;      ;
    .CODE_829989:
        %Set16bit(!MX)                             ;829989;      ;
        LDA.W #$0000                         ;82998B;      ;
        STA.B !player_action                            ;82998E;0000D4;
        %Set8bit(!M)                             ;829990;      ;
        LDA.B #$FE                           ;829992;      ;
        JSL.L ChangeStamina                    ;829994;81D061;

        RTS                                  ;829998;      ;

;;;;;;;;
PSUB_82A999: ;82A9999
        %Set8bit(!M)                             ;82A9999;      ;
        %Set16bit(!X)                             ;82999B;      ;
        LDA.B #$00                           ;82999D;      ;
        XBA                                  ;82999F;      ;
        LDA.W $096B                          ;8299A0;00096B;
        JSR.W SUB_8292D6                    ;8299A3;8292D6;
        BNE .CODE_8299AB                      ;8299A6;8299AB;
        JMP.W .CODE_8299CA                    ;8299A8;8299CA;

    .CODE_8299AB:
        %Set16bit(!MX)                             ;8299AB;      ;
        LDX.W #$0019                         ;8299AD;      ;
        %Set8bit(!M)                             ;8299B0;      ;
        LDA.L !season                        ;8299B2;7F1F19;
        CMP.B #$01                           ;8299B6;      ;
        BEQ .CODE_8299BD                      ;8299B8;8299BD;
        LDX.W #$00EB                         ;8299BA;      ;

    .CODE_8299BD:
        %Set16bit(!M)                             ;8299BD;      ;
        TXA                                  ;8299BF;      ;
        LDX.W $0985                          ;8299C0;000985;
        LDY.W $0987                          ;8299C3;000987;
        JSL.L CODE_81A688                    ;8299C6;81A688;

    .CODE_8299CA:
        %Set8bit(!M)                             ;8299CA;      ;
        LDA.W $096B                          ;8299CC;00096B;
        INC A                                ;8299CF;      ;
        STA.W $096B                          ;8299D0;00096B;
        CMP.B #$09                           ;8299D3;      ;
        BNE .return                      ;8299D5;8299F7;
        STZ.W $096B                          ;8299D7;00096B;
        %Set8bit(!M)                             ;8299DA;      ;
        LDA.W !seeds_corn_N                          ;8299DC;000928;
        DEC A                                ;8299DF;      ;
        STA.W !seeds_corn_N                          ;8299E0;000928;
        BNE .CODE_8299E8                      ;8299E3;8299E8;
        STZ.W !tool_selected                          ;8299E5;000921;

        .CODE_8299E8:
        %Set16bit(!MX)                             ;8299E8;      ;
        LDA.W #$0000                         ;8299EA;      ;
        STA.B !player_action                            ;8299ED;0000D4;
        %Set8bit(!M)                             ;8299EF;      ;
        LDA.B #$FF                           ;8299F1;      ;
        JSL.L ChangeStamina                    ;8299F3;81D061;

        .return: RTS                                  ;8299F7;      ;

;;;;;;;;
PSUB_8299F8: ;8299F8
        %Set8bit(!M)                             ;8299F8;      ;
        %Set16bit(!X)                             ;8299FA;      ;
        LDA.B #$00                           ;8299FC;      ;
        XBA                                  ;8299FE;      ;
        LDA.W $096B                          ;8299FF;00096B;
        JSR.W SUB_8292D6                    ;829A02;8292D6;
        BNE .CODE_829A0A                      ;829A05;829A0A;
        JMP.W .CODE_829A29                    ;829A07;829A29;

    .CODE_829A0A:
        %Set16bit(!MX)                             ;829A0A;      ;
        LDX.W #$001A                         ;829A0C;      ;
        %Set8bit(!M)                             ;829A0F;      ;
        LDA.L !season                        ;829A11;7F1F19;
        CMP.B #$01                           ;829A15;      ;
        BEQ .CODE_829A1C                      ;829A17;829A1C;
        LDX.W #$00EB                         ;829A19;      ;

    .CODE_829A1C:
        %Set16bit(!M)                             ;829A1C;      ;
        TXA                                  ;829A1E;      ;
        LDX.W $0985                          ;829A1F;000985;
        LDY.W $0987                          ;829A22;000987;
        JSL.L CODE_81A688                    ;829A25;81A688;

    .CODE_829A29:
        %Set8bit(!M)                             ;829A29;      ;
        LDA.W $096B                          ;829A2B;00096B;
        INC A                                ;829A2E;      ;
        STA.W $096B                          ;829A2F;00096B;
        CMP.B #$09                           ;829A32;      ;
        BNE .CODE_829A56                      ;829A34;829A56;
        STZ.W $096B                          ;829A36;00096B;
        %Set8bit(!M)                             ;829A39;      ;
        LDA.W !seeds_tomato_N                          ;829A3B;000929;
        DEC A                                ;829A3E;      ;
        STA.W !seeds_tomato_N                          ;829A3F;000929;
        BNE .CODE_829A47                      ;829A42;829A47;
        STZ.W !tool_selected                          ;829A44;000921;

    .CODE_829A47:
        %Set16bit(!MX)                             ;829A47;      ;
        LDA.W #$0000                         ;829A49;      ;
        STA.B !player_action                            ;829A4C;0000D4;
        %Set8bit(!M)                             ;829A4E;      ;
        LDA.B #$FF                           ;829A50;      ;
        JSL.L ChangeStamina                    ;829A52;81D061;

    .CODE_829A56: RTS                                  ;829A56;      ;

;;;;;;;;
PSUB_829A57: ;829A57
        %Set8bit(!M)                             ;829A57;      ;
        %Set16bit(!X)                             ;829A59;      ;
        LDA.B #$00                           ;829A5B;      ;
        XBA                                  ;829A5D;      ;
        LDA.W $096B                          ;829A5E;00096B;
        JSR.W SUB_8292D6                    ;829A61;8292D6;
        BNE .CODE_829A69                      ;829A64;829A69;
        JMP.W .CODE_829A86                    ;829A66;829A86;
                                            ;      ;      ;
                                            ;      ;      ;
    .CODE_829A69:
        %Set16bit(!MX)                             ;829A69;      ;
        LDX.W #$001B                         ;829A6B;      ;
        %Set8bit(!M)                             ;829A6E;      ;
        LDA.L !season                        ;829A70;7F1F19;
        BEQ .CODE_829A79                      ;829A74;829A79;
        LDX.W #$00EB                         ;829A76;      ;
                                            ;      ;      ;
    .CODE_829A79:
        %Set16bit(!M)                             ;829A79;      ;
        TXA                                  ;829A7B;      ;
        LDX.W $0985                          ;829A7C;000985;
        LDY.W $0987                          ;829A7F;000987;
        JSL.L CODE_81A688                    ;829A82;81A688;
                                            ;      ;      ;
    .CODE_829A86:
        %Set8bit(!M)                             ;829A86;      ;
        LDA.W $096B                          ;829A88;00096B;
        INC A                                ;829A8B;      ;
        STA.W $096B                          ;829A8C;00096B;
        CMP.B #$09                           ;829A8F;      ;
        BNE .CODE_829AB3                      ;829A91;829AB3;
        STZ.W $096B                          ;829A93;00096B;
        %Set8bit(!M)                             ;829A96;      ;
        LDA.W !seeds_potato_N                          ;829A98;00092A;
        DEC A                                ;829A9B;      ;
        STA.W !seeds_potato_N                          ;829A9C;00092A;
        BNE .CODE_829AA4                      ;829A9F;829AA4;
        STZ.W !tool_selected                          ;829AA1;000921;
                                            ;      ;      ;
    .CODE_829AA4:
        %Set16bit(!MX)                             ;829AA4;      ;
        LDA.W #$0000                         ;829AA6;      ;
        STA.B !player_action                            ;829AA9;0000D4;
        %Set8bit(!M)                             ;829AAB;      ;
        LDA.B #$FF                           ;829AAD;      ;
        JSL.L ChangeStamina                    ;829AAF;81D061;

    .CODE_829AB3: RTS                                  ;829AB3;      ;

;;;;;;;;
PSUB_829AB4: ;829AB4
        %Set8bit(!M)                             ;829AB4;      ;
        %Set16bit(!X)                             ;829AB6;      ;
        LDA.B #$00                           ;829AB8;      ;
        XBA                                  ;829ABA;      ;
        LDA.W $096B                          ;829ABB;00096B;
        JSR.W SUB_8292D6                    ;829ABE;8292D6;
        BNE .CODE_829AC6                      ;829AC1;829AC6;
        JMP.W .CODE_829AE3                    ;829AC3;829AE3;

    .CODE_829AC6:
        %Set16bit(!MX)                             ;829AC6;      ;
        LDX.W #$001C                         ;829AC8;      ;
        %Set8bit(!M)                             ;829ACB;      ;
        LDA.L !season                        ;829ACD;7F1F19;
        BEQ .CODE_829AD6                      ;829AD1;829AD6;
        LDX.W #$00EB                         ;829AD3;      ;

    .CODE_829AD6:
        %Set16bit(!M)                             ;829AD6;      ;
        TXA                                  ;829AD8;      ;
        LDX.W $0985                          ;829AD9;000985;
        LDY.W $0987                          ;829ADC;000987;
        JSL.L CODE_81A688                    ;829ADF;81A688;

    .CODE_829AE3:
        %Set8bit(!M)                             ;829AE3;      ;
        LDA.W $096B                          ;829AE5;00096B;
        INC A                                ;829AE8;      ;
        STA.W $096B                          ;829AE9;00096B;
        CMP.B #$09                           ;829AEC;      ;
        BNE .CODE_829B10                      ;829AEE;829B10;
        STZ.W $096B                          ;829AF0;00096B;
        %Set8bit(!M)                             ;829AF3;      ;
        LDA.W !seeds_turnip_N                          ;829AF5;00092B;
        DEC A                                ;829AF8;      ;
        STA.W !seeds_turnip_N                          ;829AF9;00092B;
        BNE .CODE_829B01                      ;829AFC;829B01;
        STZ.W !tool_selected                          ;829AFE;000921;

    .CODE_829B01:
        %Set16bit(!MX)                             ;829B01;      ;
        LDA.W #$0000                         ;829B03;      ;
        STA.B !player_action                            ;829B06;0000D4;
        %Set8bit(!M)                             ;829B08;      ;
        LDA.B #$FF                           ;829B0A;      ;
        JSL.L ChangeStamina                    ;829B0C;81D061;

    .CODE_829B10: RTS                                  ;829B10;      ;

;;;;;;;;
PSUB_829B11: ;829B11
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

;;;;;;;;
PSUB_829B31: ;829B31
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

;;;;;;;;
PSUB_829B51: ;829B51
        %Set16bit(!MX)                             ;829B51;      ;
        LDA.W #$0000                         ;829B53;      ;
        STA.B !player_action                            ;829B56;0000D4;
        %Set8bit(!M)                             ;829B58;      ;
        LDA.B #$FF                           ;829B5A;      ;
        JSL.L ChangeStamina                    ;829B5C;81D061;

        RTS                                  ;829B60;      ;

;;;;;;;;
PSUB_829B61: ;829B61
        %Set8bit(!M)                             ;829B61;      ;
        %Set16bit(!X)                             ;829B63;      ;
        LDA.B #$00                           ;829B65;      ;
        XBA                                  ;829B67;      ;
        LDA.W $096B                          ;829B68;00096B;
        JSR.W SUB_8292D6                    ;829B6B;8292D6;
        BNE .CODE_829B73                      ;829B6E;829B73;
        JMP.W .CODE_829B9D                   ;829B70;829B9D;

    .CODE_829B73:
        %Set16bit(!MX)                             ;829B73;      ;
        LDX.W #$00ED                         ;829B75;      ;
        %Set8bit(!M)                             ;829B78;      ;
        LDA.L !season                        ;829B7A;7F1F19;
        CMP.B #$02                           ;829B7E;      ;
        BCS .CODE_829B90                      ;829B80;829B90;
        %Set16bit(!M)                             ;829B82;      ;
        LDA.L $7F1F29                        ;829B84;7F1F29;
        INC A                                ;829B88;      ;
        STA.L $7F1F29                        ;829B89;7F1F29;
        LDX.W #$001E                         ;829B8D;      ;

    .CODE_829B90:
        %Set16bit(!M)                             ;829B90;      ;
        TXA                                  ;829B92;      ;
        LDX.W $0985                          ;829B93;000985;
        LDY.W $0987                          ;829B96;000987;
        JSL.L CODE_81A688                    ;829B99;81A688;

    .CODE_829B9D:
        %Set8bit(!M)                             ;829B9D;      ;
        LDA.W $096B                          ;829B9F;00096B;
        INC A                                ;829BA2;      ;
        STA.W $096B                          ;829BA3;00096B;
        CMP.B #$09                           ;829BA6;      ;
        BNE .CODE_829BCA                      ;829BA8;829BCA;
        STZ.W $096B                          ;829BAA;00096B;
        %Set8bit(!M)                             ;829BAD;      ;
        LDA.W !seeds_grass_N                          ;829BAF;000927;
        DEC A                                ;829BB2;      ;
        STA.W !seeds_grass_N                          ;829BB3;000927;
        BNE .CODE_829BBB                      ;829BB6;829BBB;
        STZ.W !tool_selected                          ;829BB8;000921;
                                            ;      ;      ;
    .CODE_829BBB:
        %Set16bit(!MX)                             ;829BBB;      ;
        LDA.W #$0000                         ;829BBD;      ;
        STA.B !player_action                            ;829BC0;0000D4;
        %Set8bit(!M)                             ;829BC2;      ;
        LDA.B #$FF                           ;829BC4;      ;
        JSL.L ChangeStamina                    ;829BC6;81D061;

    .CODE_829BCA: RTS                                  ;829BCA;      ;

;;;;;;;;
PSUB_829BCB: ;829BCB
        %Set16bit(!MX)                             ;829BCB;      ;
        JSR.W SUB_8292A0                    ;829BCD;8292A0;
        BNE .CODE_829BD5                      ;829BD0;829BD5;
        JMP.W .CODE_829CB0                    ;829BD2;829CB0;

    .CODE_829BD5:
        %Set16bit(!MX)                             ;829BD5;      ;
        CPX.W #$00E2                         ;829BD7;      ;
        BEQ .CODE_829C1D                      ;829BDA;829C1D;
        CPX.W #$00E3                         ;829BDC;      ;
        BEQ .CODE_829C50                      ;829BDF;829C50;
        CPX.W #$00E4                         ;829BE1;      ;
        BNE .CODE_829BE9                      ;829BE4;829BE9;
        JMP.W .CODE_829C80                    ;829BE6;829C80;

    .CODE_829BE9:
        %Set16bit(!MX)                             ;829BE9;      ;
        LDA.L $7F1F66                        ;829BEB;7F1F66;
        AND.W #$0200                         ;829BEF;      ;
        BEQ .CODE_829BF7                      ;829BF2;829BF7;
        JMP.W .CODE_829CB0                    ;829BF4;829CB0;

    .CODE_829BF7:
        LDA.W #$000A                         ;829BF7;      ;
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
        JMP.W .CODE_829CB0                    ;829C1A;829CB0;

    .CODE_829C1D:
        %Set16bit(!MX)                             ;829C1D;      ;
        LDA.L $7F1F66                        ;829C1F;7F1F66;
        AND.W #$0400                         ;829C23;      ;
        BEQ .CODE_829C2B                      ;829C26;829C2B;
        JMP.W .CODE_829CB0                    ;829C28;829CB0;

    .CODE_829C2B:
        LDA.W #$000A                         ;829C2B;      ;
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
        BRA .CODE_829CB0                      ;829C4E;829CB0;

    .CODE_829C50:
        %Set16bit(!MX)                             ;829C50;      ;
        LDA.L $7F1F66                        ;829C52;7F1F66;
        AND.W #$0800                         ;829C56;      ;
        BNE .CODE_829CB0                      ;829C59;829CB0;
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
        BRA .CODE_829CB0                      ;829C7E;829CB0;

    .CODE_829C80:
        %Set16bit(!MX)                             ;829C80;      ;
        LDA.L $7F1F66                        ;829C82;7F1F66;
        AND.W #$1000                         ;829C86;      ;
        BNE .CODE_829CB0                      ;829C89;829CB0;
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
        BRA .CODE_829CB0                      ;829CAE;829CB0;

    .CODE_829CB0:
        %Set16bit(!MX)                             ;829CB0;      ;
        LDA.W #$0000                         ;829CB2;      ;
        STA.B !player_action                            ;829CB5;0000D4;
        %Set8bit(!M)                             ;829CB7;      ;
        LDA.B #$FE                           ;829CB9;      ;
        JSL.L ChangeStamina                    ;829CBB;81D061;

        RTS                                  ;829CBF;      ;

;;;;;;;;
PSUB_829CC0: ;829CC0
        %Set16bit(!MX)                             ;829CC0;      ;
        LDA.W #$0000                         ;829CC2;      ;
        STA.B !player_action                            ;829CC5;0000D4;

        RTS                                  ;829CC7;      ;

;;;;;;;;
PSUB_829CC8: ;829CC8
        %Set16bit(!MX)                             ;829CC8;      ;
        LDA.W #$0000                         ;829CCA;      ;
        STA.B !player_action                            ;829CCD;0000D4;
        %Set8bit(!M)                             ;829CCF;      ;
        LDA.B #$FF                           ;829CD1;      ;
        JSL.L ChangeStamina                    ;829CD3;81D061;

        RTS                                  ;829CD7;      ;

;;;;;;;;
PSUB_829CD8: ;829CD8
        %Set8bit(!M)                             ;829CD8;      ;
        %Set16bit(!X)                             ;829CDA;      ;
        %Set8bit(!M)                             ;829CDC;      ;
        %Set16bit(!X)                             ;829CDE;      ;
        LDA.B #$00                           ;829CE0;      ;
        STA.W $0114                          ;829CE2;000114;
        LDA.B #$07                           ;829CE5;      ;
        STA.W $0115                          ;829CE7;000115;
        JSL.L UNK_Audio19                    ;829CEA;838332;
        JSR.W SUB_8292A0                    ;829CEE;8292A0;
        %Set8bit(!M)                             ;829CF1;      ;
        CMP.B #$02                           ;829CF3;      ;
        BEQ .CODE_829D32                      ;829CF5;829D32;
        LDA.W !sprinkler_water                          ;829CF7;000926;
        BEQ .CODE_829D32                      ;829CFA;829D32;
        DEC A                                ;829CFC;      ;
        STA.W !sprinkler_water                          ;829CFD;000926;
        JSR.W SUB_8292A0                    ;829D00;8292A0;
        BNE .CODE_829D08                      ;829D03;829D08;
        JMP.W .CODE_829D32                    ;829D05;829D32;

    .CODE_829D08:
        %Set16bit(!MX)                             ;829D08;      ;
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

    .CODE_829D32:
        %Set16bit(!MX)                             ;829D32;      ;
        LDA.W #$0000                         ;829D34;      ;
        STA.B !player_action                            ;829D37;0000D4;
        %Set8bit(!M)                             ;829D39;      ;
        LDA.B #$FE                           ;829D3B;      ;
        JSL.L ChangeStamina                    ;829D3D;81D061;

        RTS                                  ;829D41;      ;

;;;;;;;;
PSUB_829D42: ;829D42
        %Set8bit(!M)                             ;829D42;      ;
        %Set16bit(!X)                             ;829D44;      ;
        LDA.B #$00                           ;829D46;      ;
        XBA                                  ;829D48;      ;
        LDA.W $096B                          ;829D49;00096B;
        JSR.W SUB_8292D6                    ;829D4C;8292D6;
        BNE .CODE_829D54                      ;829D4F;829D54;
        JMP.W .CODE_829E6E                    ;829D51;829E6E;

    .CODE_829D54:
        %Set8bit(!M)                             ;829D54;      ;
        LDA.L !season                        ;829D56;7F1F19;
        CMP.B #$03                           ;829D5A;      ;
        BNE .CODE_829D61                      ;829D5C;829D61;
        JMP.W .CODE_829E8D                    ;829D5E;829E8D;

    .CODE_829D61:
        LDA.B !tilemap_to_load                            ;829D61;000022;
        CMP.B #$04                           ;829D63;      ;
        BCC .CODE_829D7A                      ;829D65;829D7A;
        %Set16bit(!M)                             ;829D67;      ;
        CPX.W #$0035                         ;829D69;      ;
        BEQ .CODE_829D73                      ;829D6C;829D73;
        LDA.W #$00DD                         ;829D6E;      ;
        BRA .CODE_829DE6                      ;829D71;829DE6;

    .CODE_829D73:
        %Set16bit(!M)                             ;829D73;      ;
        LDA.W #$00DE                         ;829D75;      ;
        BRA .CODE_829DE6                      ;829D78;829DE6;

    .CODE_829D7A:
        %Set16bit(!M)                             ;829D7A;      ;
        CPX.W #$0003                         ;829D7C;      ;
        BEQ .CODE_829D8B                      ;829D7F;829D8B;
        CPX.W #$0079                         ;829D81;      ;
        BEQ .CODE_829D92                      ;829D84;829D92;
        LDA.W #$0017                         ;829D86;      ;
        BRA .CODE_829DE6                      ;829D89;829DE6;

    .CODE_829D8B:
        %Set16bit(!M)                             ;829D8B;      ;
        LDA.W #$000E                         ;829D8D;      ;
        BRA .CODE_829DE6                      ;829D90;829DE6;

    .CODE_829D92:
        %Set16bit(!M)                             ;829D92;      ;
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
        BRA .CODE_829E21                      ;829DE4;829E21;

    .CODE_829DE6:
        LDX.W $0985                          ;829DE6;000985;
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

    .CODE_829E21:
        %Set8bit(!M)                             ;829E21;      ;
        LDA.L !season                        ;829E23;7F1F19;
        CMP.B #$01                           ;829E27;      ;
        BNE .CODE_829E6E                      ;829E29;829E6E;
        %Set16bit(!M)                             ;829E2B;      ;
        LDA.L $7F1F60                        ;829E2D;7F1F60;
        AND.W #$0008                         ;829E31;      ;
        BNE .CODE_829E6E                      ;829E34;829E6E;
        LDA.L $7F1F5A                        ;829E36;7F1F5A;
        AND.W #$2000                         ;829E3A;      ;
        BNE .CODE_829E6E                      ;829E3D;829E6E;
        %Set8bit(!M)                             ;829E3F;      ;
        LDA.B #$10                           ;829E41;      ;
        JSL.L RNGReturn0toA                  ;829E43;8089F9;
        BNE .CODE_829E6E                      ;829E47;829E6E;
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

    .CODE_829E6E:
        %Set8bit(!M)                             ;829E6E;      ;
        LDA.W $096B                          ;829E70;00096B;
        INC A                                ;829E73;      ;
        STA.W $096B                          ;829E74;00096B;
        CMP.B #$09                           ;829E77;      ;
        BNE .CODE_829E8D                      ;829E79;829E8D;
        STZ.W $096B                          ;829E7B;00096B;
        %Set16bit(!MX)                             ;829E7E;      ;
        LDA.W #$0000                         ;829E80;      ;
        STA.B !player_action                            ;829E83;0000D4;
        %Set8bit(!M)                             ;829E85;      ;
        LDA.B #$F8                           ;829E87;      ;
        JSL.L ChangeStamina                    ;829E89;81D061;

    .CODE_829E8D: RTS                                  ;829E8D;      ;


;;;;;;;;
PSUB_829E8E: ;829E8E
        %Set8bit(!M)                             ;829E8E;      ;
        %Set16bit(!X)                             ;829E90;      ;
        LDA.B #$00                           ;829E92;      ;
        XBA                                  ;829E94;      ;
        LDA.W $096B                          ;829E95;00096B;
        JSR.W SUB_8292BC                    ;829E98;8292BC;
        BNE .CODE_829EA0                      ;829E9B;829EA0;
        JMP.W .CODE_829FF0                    ;829E9D;829FF0;

    .CODE_829EA0:
        %Set16bit(!M)                             ;829EA0;      ;
        LDA.W #$0017                         ;829EA2;      ;
        LDX.W $0985                          ;829EA5;000985;
        LDY.W $0987                          ;829EA8;000987;
        JSL.L CODE_81A688                    ;829EAB;81A688;
        %Set8bit(!M)                             ;829EAF;      ;
        LDA.L !season                        ;829EB1;7F1F19;
        CMP.B #$02                           ;829EB5;      ;
        BCS .CODE_829EF8                      ;829EB7;829EF8;
        %Set16bit(!M)                             ;829EB9;      ;
        %Set16bit(!M)                             ;829EBB;      ;
        LDA.L $7F1F60                        ;829EBD;7F1F60;
        AND.W #$0008                         ;829EC1;      ;
        BNE .CODE_829EF8                      ;829EC4;829EF8;
        LDA.L $7F1F5A                        ;829EC6;7F1F5A;
        AND.W #$1000                         ;829ECA;      ;
        BNE .CODE_829EF8                      ;829ECD;829EF8;
        %Set8bit(!M)                             ;829ECF;      ;
        LDA.B #$20                           ;829ED1;      ;
        JSL.L RNGReturn0toA                  ;829ED3;8089F9;
        BNE .CODE_829EF8                      ;829ED7;829EF8;
        %Set16bit(!MX)                             ;829ED9;      ;
        LDA.W #$0011                         ;829EDB;      ;
        LDX.W #$0000                         ;829EDE;      ;
        LDY.W #$0030                         ;829EE1;      ;
        JSL.L CODE_8480F8                    ;829EE4;8480F8;
        %Set16bit(!M)                             ;829EE8;      ;
        LDA.L $7F1F5A                        ;829EEA;7F1F5A;
        ORA.W #$1000                         ;829EEE;      ;
        STA.L $7F1F5A                        ;829EF1;7F1F5A;
        JMP.W .CODE_829FE3                    ;829EF5;829FE3;

    .CODE_829EF8:
        %Set16bit(!MX)                             ;829EF8;      ;
        LDA.L $7F1F60                        ;829EFA;7F1F60;
        AND.W #$0008                         ;829EFE;      ;
        BNE .CODE_829F7D                      ;829F01;829F7D;
        LDA.L $7F1F5C                        ;829F03;7F1F5C;
        AND.W #$0200                         ;829F07;      ;
        BNE .CODE_829F7D                      ;829F0A;829F7D;
        %Set8bit(!M)                             ;829F0C;      ;
        LDA.B #$10                           ;829F0E;      ;
        JSL.L RNGReturn0toA                  ;829F10;8089F9;
        BNE .CODE_829F44                      ;829F14;829F44;
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
        JMP.W .CODE_829FE3                    ;829F41;829FE3;

    .CODE_829F44:
        %Set8bit(!M)                             ;829F44;      ;
        LDA.B #$10                           ;829F46;      ;
        JSL.L RNGReturn0toA                  ;829F48;8089F9;
        BNE .CODE_829F7D                      ;829F4C;829F7D;
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
        BRA .CODE_829FE3                      ;829F7B;829FE3;

    .CODE_829F7D:
        %Set8bit(!M)                             ;829F7D;      ;
        LDA.B #$40                           ;829F7F;      ;
        JSL.L RNGReturn0toA                  ;829F81;8089F9;
        BNE .CODE_829FE3                      ;829F85;829FE3;
        %Set16bit(!MX)                             ;829F87;      ;
        LDA.L $7F1F60                        ;829F89;7F1F60;
        AND.W #$0008                         ;829F8D;      ;
        BNE .CODE_829FE3                      ;829F90;829FE3;
        LDA.L $7F1F5C                        ;829F92;7F1F5C;
        AND.W #$0100                         ;829F96;      ;
        BNE .CODE_829FE3                      ;829F99;829FE3;
        LDA.L $7F1F5C                        ;829F9B;7F1F5C;
        ORA.W #$0100                         ;829F9F;      ;
        STA.L $7F1F5C                        ;829FA2;7F1F5C;
        LDA.L $7F1F64                        ;829FA6;7F1F64;
        AND.W #$0800                         ;829FAA;      ;
        BNE .CODE_829FBC                      ;829FAD;829FBC;
        LDA.L $7F1F64                        ;829FAF;7F1F64;
        ORA.W #$0800                         ;829FB3;      ;
        STA.L $7F1F64                        ;829FB6;7F1F64;
        BRA .CODE_829FD2                      ;829FBA;829FD2;

    .CODE_829FBC:
        %Set16bit(!MX)                             ;829FBC;      ;
        LDA.L $7F1F64                        ;829FBE;7F1F64;
        AND.W #$1000                         ;829FC2;      ;
        BNE .CODE_829FE3                      ;829FC5;829FE3;
        LDA.L $7F1F64                        ;829FC7;7F1F64;
        ORA.W #$1000                         ;829FCB;      ;
        STA.L $7F1F64                        ;829FCE;7F1F64;

    .CODE_829FD2:
        %Set16bit(!MX)                             ;829FD2;      ;
        LDA.W #$0010                         ;829FD4;      ;
        LDX.W #$0000                         ;829FD7;      ;
        LDY.W #$001F                         ;829FDA;      ;
        JSL.L CODE_8480F8                    ;829FDD;8480F8;
        BRA .CODE_829FE3                      ;829FE1;829FE3;

    .CODE_829FE3:
        %Set8bit(!M)                             ;829FE3;      ;
        LDA.W $096B                          ;829FE5;00096B;
        INC A                                ;829FE8;      ;
        STA.W $096B                          ;829FE9;00096B;
        CMP.B #$06                           ;829FEC;      ;
        BNE .CODE_82A004                      ;829FEE;82A004;

    .CODE_829FF0:
        %Set8bit(!M)                             ;829FF0;      ;
        STZ.W $096B                          ;829FF2;00096B;
        %Set16bit(!MX)                             ;829FF5;      ;
        LDA.W #$0000                         ;829FF7;      ;
        STA.B !player_action                            ;829FFA;0000D4;
        %Set8bit(!M)                             ;829FFC;      ;
        LDA.B #$F8                           ;829FFE;      ;
        JSL.L ChangeStamina                    ;82A000;81D061;

    .CODE_82A004: RTS                                  ;82A004;      ;

;;;;;;;;
PSUB_82A005: ;82A005
        %Set16bit(!MX)                             ;82A005;      ;
        JSR.W SUB_8292A0                    ;82A007;8292A0;
        BNE .CODE_82A00F                      ;82A00A;82A00F;
        JMP.W .CODE_82A141                    ;82A00C;82A141;

    .CODE_82A00F:
        CPX.W #$0006                         ;82A00F;      ;
        BEQ .CODE_82A07B                      ;82A012;82A07B;
        CPX.W #$0004                         ;82A014;      ;
        BEQ .CODE_82A01C                      ;82A017;82A01C;
        JMP.W .CODE_82A08D                    ;82A019;82A08D;

    .CODE_82A01C:
        %Set8bit(!M)                             ;82A01C;      ;
        LDA.B !tilemap_to_load                            ;82A01E;000022;
        CMP.B #$04                           ;82A020;      ;
        BCC .CODE_82A038                      ;82A022;82A038;
        LDA.B !tilemap_to_load                            ;82A024;000022;
        CMP.B #$29                           ;82A026;      ;
        BCS .CODE_82A031                      ;82A028;82A031;
        %Set16bit(!M)                             ;82A02A;      ;
        LDA.W #$00DD                         ;82A02C;      ;
        BRA .CODE_82A03D                      ;82A02F;82A03D;

    .CODE_82A031:
        %Set16bit(!M)                             ;82A031;      ;
        LDA.W #$00E3                         ;82A033;      ;
        BRA .CODE_82A03D                      ;82A036;82A03D;

    .CODE_82A038:
        %Set16bit(!M)                             ;82A038;      ;
        LDA.W #$000E                         ;82A03A;      ;

    .CODE_82A03D:
        LDX.W $0985                          ;82A03D;000985;
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
        JMP.W .CODE_82A131                    ;82A078;82A131;

    .CODE_82A07B:
        %Set16bit(!M)                             ;82A07B;      ;
        LDA.W #$000E                         ;82A07D;      ;
        LDX.W $0985                          ;82A080;000985;
        LDY.W $0987                          ;82A083;000987;
        JSL.L CODE_81A688                    ;82A086;81A688;
        JMP.W .CODE_82A131                    ;82A08A;82A131;

    .CODE_82A08D:
        %Set16bit(!M)                             ;82A08D;      ;
        LDA.W $0985                          ;82A08F;000985;
        SEC                                  ;82A092;      ;
        SBC.W #$0010                         ;82A093;      ;
        STA.W $0985                          ;82A096;000985;
        LDA.W $0987                          ;82A099;000987;
        SEC                                  ;82A09C;      ;
        SBC.W #$0010                         ;82A09D;      ;
        STA.W $0987                          ;82A0A0;000987;
        CPX.W #$0010                         ;82A0A3;      ;
        BEQ .CODE_82A0DA                      ;82A0A6;82A0DA;
        LDA.W $0985                          ;82A0A8;000985;
        CLC                                  ;82A0AB;      ;
        ADC.W #$0010                         ;82A0AC;      ;
        STA.W $0985                          ;82A0AF;000985;
        CPX.W #$000F                         ;82A0B2;      ;
        BEQ .CODE_82A0DA                      ;82A0B5;82A0DA;
        LDA.W $0985                          ;82A0B7;000985;
        SEC                                  ;82A0BA;      ;
        SBC.W #$0010                         ;82A0BB;      ;
        STA.W $0985                          ;82A0BE;000985;
        LDA.W $0987                          ;82A0C1;000987;
        CLC                                  ;82A0C4;      ;
        ADC.W #$0010                         ;82A0C5;      ;
        STA.W $0987                          ;82A0C8;000987;
        CPX.W #$000E                         ;82A0CB;      ;
        BEQ .CODE_82A0DA                      ;82A0CE;82A0DA;
        LDA.W $0985                          ;82A0D0;000985;
        CLC                                  ;82A0D3;      ;
        ADC.W #$0010                         ;82A0D4;      ;
        STA.W $0985                          ;82A0D7;000985;

    .CODE_82A0DA:
        %Set8bit(!M)                             ;82A0DA;      ;
        LDA.B !tilemap_to_load                            ;82A0DC;000022;
        CMP.B #$04                           ;82A0DE;      ;
        BCC .CODE_82A0E9                      ;82A0E0;82A0E9;
        %Set16bit(!M)                             ;82A0E2;      ;
        LDA.W #$00DF                         ;82A0E4;      ;
        BRA .CODE_82A0EE                      ;82A0E7;82A0EE;

    .CODE_82A0E9:
        %Set16bit(!M)                             ;82A0E9;      ;
        LDA.W #$000D                         ;82A0EB;      ;

    .CODE_82A0EE:
        LDX.W $0985                          ;82A0EE;000985;
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

    .CODE_82A131:
        %Set16bit(!MX)                             ;82A131;      ;
        LDA.W #$0000                         ;82A133;      ;
        STA.B !player_action                            ;82A136;0000D4;
        %Set8bit(!M)                             ;82A138;      ;
        LDA.B #$FC                           ;82A13A;      ;
        JSL.L ChangeStamina                    ;82A13C;81D061;

        RTS                                  ;82A140;      ;

    .CODE_82A141:
        %Set8bit(!M)                             ;82A141;      ;
        %Set16bit(!X)                             ;82A143;      ;
        LDA.B !tilemap_to_load                            ;82A145;000022;
        CMP.B #$0C                           ;82A147;      ;
        BCC .CODE_82A131                      ;82A149;82A131;
        CMP.B #$10                           ;82A14B;      ;
        BCS .CODE_82A131                      ;82A14D;82A131;
        CPX.W #$00F8                         ;82A14F;      ;
        BNE .CODE_82A131                      ;82A152;82A131;
        %Set16bit(!MX)                             ;82A154;      ;
        LDA.L $7F1F5C                        ;82A156;7F1F5C;
        AND.W #$0080                         ;82A15A;      ;
        BNE .CODE_82A131                      ;82A15D;82A131;
        %Set16bit(!M)                             ;82A15F;      ;
        LDA.W #$0015                         ;82A161;      ;
        LDX.W #$0000                         ;82A164;      ;
        LDY.W #$0016                         ;82A167;      ;
        JSL.L CODE_84803F                    ;82A16A;84803F;
        %Set8bit(!M)                             ;82A16E;      ;
        LDA.B #$04                           ;82A170;      ;
        JSL.L RNGReturn0toA                  ;82A172;8089F9;
        BNE .CODE_82A131                      ;82A176;82A131;
        %Set16bit(!MX)                             ;82A178;      ;
        LDA.L $7F1F64                        ;82A17A;7F1F64;
        AND.W #$0200                         ;82A17E;      ;
        BNE .CODE_82A131                      ;82A181;82A131;
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
        JMP.W .CODE_82A131                    ;82A1BC;82A131;

;;;;;;;;
PSUB_82A1BF: ;82A1BF
        %Set16bit(!MX)                             ;82A1BF;      ;
        JSR.W SUB_8292A0                    ;82A1C1;8292A0;
        BNE .CODE_82A1C9                      ;82A1C4;82A1C9;
        JMP.W .CODE_82A2F7                    ;82A1C6;82A2F7;

    .CODE_82A1C9:
        %Set16bit(!M)                             ;82A1C9;      ;
        LDA.W $0985                          ;82A1CB;000985;
        SEC                                  ;82A1CE;      ;
        SBC.W #$0010                         ;82A1CF;      ;
        STA.W $0985                          ;82A1D2;000985;
        LDA.W $0987                          ;82A1D5;000987;
        SEC                                  ;82A1D8;      ;
        SBC.W #$0010                         ;82A1D9;      ;
        STA.W $0987                          ;82A1DC;000987;
        CPX.W #$000C                         ;82A1DF;      ;
        BEQ .CODE_82A235                      ;82A1E2;82A235;
        CPX.W #$0014                         ;82A1E4;      ;
        BNE .CODE_82A1EC                      ;82A1E7;82A1EC;
        JMP.W .CODE_82A29D                    ;82A1E9;82A29D;

    .CODE_82A1EC:
        LDA.W $0985                          ;82A1EC;000985;
        CLC                                  ;82A1EF;      ;
        ADC.W #$0010                         ;82A1F0;      ;
        STA.W $0985                          ;82A1F3;000985;
        CPX.W #$000B                         ;82A1F6;      ;
        BEQ .CODE_82A235                      ;82A1F9;82A235;
        CPX.W #$0013                         ;82A1FB;      ;
        BNE .CODE_82A203                      ;82A1FE;82A203;
        JMP.W .CODE_82A29D                    ;82A200;82A29D;

    .CODE_82A203:
        LDA.W $0985                          ;82A203;000985;
        SEC                                  ;82A206;      ;
        SBC.W #$0010                         ;82A207;      ;
        STA.W $0985                          ;82A20A;000985;
        LDA.W $0987                          ;82A20D;000987;
        CLC                                  ;82A210;      ;
        ADC.W #$0010                         ;82A211;      ;
        STA.W $0987                          ;82A214;000987;
        CPX.W #$000A                         ;82A217;      ;
        BEQ .CODE_82A235                      ;82A21A;82A235;
        CPX.W #$0012                         ;82A21C;      ;
        BEQ .CODE_82A29D                      ;82A21F;82A29D;
        LDA.W $0985                          ;82A221;000985;
        CLC                                  ;82A224;      ;
        ADC.W #$0010                         ;82A225;      ;
        STA.W $0985                          ;82A228;000985;
        CPX.W #$0009                         ;82A22B;      ;
        BEQ .CODE_82A235                      ;82A22E;82A235;
        CPX.W #$0011                         ;82A230;      ;
        BEQ .CODE_82A29D                      ;82A233;82A29D;

    .CODE_82A235:
        %Set8bit(!M)                             ;82A235;      ;
        LDA.B !tilemap_to_load                            ;82A237;000022;
        CMP.B #$04                           ;82A239;      ;
        BCC .CODE_82A2A4                      ;82A23B;82A2A4;
        %Set8bit(!M)                             ;82A23D;      ;
        LDA.B #$10                           ;82A23F;      ;
        JSL.L RNGReturn0toA                  ;82A241;8089F9;
        BNE .CODE_82A296                      ;82A245;82A296;
        %Set16bit(!MX)                             ;82A247;      ;
        LDA.L $7F1F64                        ;82A249;7F1F64;
        AND.W #$0400                         ;82A24D;      ;
        BNE .CODE_82A296                      ;82A250;82A296;
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

    .CODE_82A296:
        %Set16bit(!MX)                             ;82A296;      ;
        LDA.W #$00DF                         ;82A298;      ;
        BRA .CODE_82A2A9                      ;82A29B;82A2A9;

    .CODE_82A29D:
        %Set16bit(!MX)                             ;82A29D;      ;
        LDA.W #$00E0                         ;82A29F;      ;
        BRA .CODE_82A2A9                      ;82A2A2;82A2A9;

    .CODE_82A2A4:
        %Set16bit(!MX)                             ;82A2A4;      ;
        LDA.W #$000D                         ;82A2A6;      ;

    .CODE_82A2A9:
        %Set16bit(!MX)                             ;82A2A9;      ;
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

    .CODE_82A2F7:
        %Set16bit(!MX)                             ;82A2F7;      ;
        LDA.W #$0000                         ;82A2F9;      ;
        STA.B !player_action                            ;82A2FC;0000D4;
        %Set8bit(!M)                             ;82A2FE;      ;
        LDA.B #$F8                           ;82A300;      ;
        JSL.L ChangeStamina                    ;82A302;81D061;

        RTS                                  ;82A306;      ;

;;;;;;;;
PSUB_82A307: ;82A307
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
        JSR.W SUB_8292D6                    ;82A325;8292D6;
        BNE .CODE_82A32D                      ;82A328;82A32D;
        JMP.W .CODE_82A357                    ;82A32A;82A357;

    .CODE_82A32D:
        %Set16bit(!MX)                             ;82A32D;      ;
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

    .CODE_82A357:
        %Set8bit(!M)                             ;82A357;      ;
        LDA.W $096B                          ;82A359;00096B;
        INC A                                ;82A35C;      ;
        STA.W $096B                          ;82A35D;00096B;
        CMP.B #$09                           ;82A360;      ;
        BNE .CODE_82A376                      ;82A362;82A376;
        STZ.W $096B                          ;82A364;00096B;
        %Set16bit(!MX)                             ;82A367;      ;
        LDA.W #$0000                         ;82A369;      ;
        STA.B !player_action                            ;82A36C;0000D4;
        %Set8bit(!M)                             ;82A36E;      ;
        LDA.B #$F8                           ;82A370;      ;
        JSL.L ChangeStamina                    ;82A372;81D061;

    .CODE_82A376: RTS                                  ;82A376;      ;

;;;;;;;;
PSUB_82A377: ;82A377
        %Set8bit(!M)                             ;82A377;      ;
        %Set16bit(!X)                             ;82A379;      ;
        LDA.L !hour                        ;82A37B;7F1F1C;
        CMP.B #$11                           ;82A37F;      ;
        BCS .CODE_82A3A2                      ;82A381;82A3A2;
        LDA.B !tilemap_to_load                            ;82A383;000022;
        CMP.B #$31                           ;82A385;      ;
        BNE .CODE_82A3A2                      ;82A387;82A3A2;
        %Set16bit(!MX)                             ;82A389;      ;
        LDA.L $7F1F68                        ;82A38B;7F1F68;
        ORA.W #$0200                         ;82A38F;      ;
        STA.L $7F1F68                        ;82A392;7F1F68;
        LDA.W #$0042                         ;82A396;      ;
        JSL.L CODE_81A5E1                    ;82A399;81A5E1;
        %Set8bit(!M)                             ;82A39D;      ;
        STZ.W !tool_selected                          ;82A39F;000921;

    .CODE_82A3A2:
        %Set16bit(!MX)                             ;82A3A2;      ;
        LDA.W #$0000                         ;82A3A4;      ;
        STA.B !player_action                            ;82A3A7;0000D4;

        RTS                                  ;82A3A9;      ;

;;;;;;;;
PSUB_82A3AA: ;82A3AA
        %Set8bit(!M)                             ;82A3AA;      ;
        %Set16bit(!X)                             ;82A3AC;      ;
        LDA.L !hour                        ;82A3AE;7F1F1C;
        CMP.B #$11                           ;82A3B2;      ;
        BCS .CODE_82A3F5                      ;82A3B4;82A3F5;
        LDA.B !tilemap_to_load                            ;82A3B6;000022;
        CMP.B #$34                           ;82A3B8;      ;
        BNE .CODE_82A3F5                      ;82A3BA;82A3F5;
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
        BNE .CODE_82A3F5                      ;82A3DF;82A3F5;
        %Set16bit(!MX)                             ;82A3E1;      ;
        LDA.W #$0000                         ;82A3E3;      ;
        LDX.W #$0012                         ;82A3E6;      ;
        LDY.W #$0000                         ;82A3E9;      ;
        JSL.L VIP                            ;82A3EC;848097;
        %Set8bit(!M)                             ;82A3F0;      ;
        STZ.W !tool_selected                          ;82A3F2;000921;

    .CODE_82A3F5:
        %Set16bit(!MX)                             ;82A3F5;      ;
        LDA.W #$0000                         ;82A3F7;      ;
        STA.B !player_action                            ;82A3FA;0000D4;

        RTS                                  ;82A3FC;      ;

;;;;;;;;
PSUB_82A3FD: ;82A3FD
        %Set16bit(!MX)                             ;82A3FD;      ;
        %Set16bit(!MX)                             ;82A3FF;      ;
        LDA.W #$0000                         ;82A401;      ;
        STA.B !player_action                            ;82A404;0000D4;
        %Set16bit(!M)                             ;82A406;      ;
        LDA.L $7F1F5E                        ;82A408;7F1F5E;
        ORA.W #$0040                         ;82A40C;      ;
        STA.L $7F1F5E                        ;82A40F;7F1F5E;

        RTS                                  ;82A413;      ;

;;;;;;;;
PSUB_82A414: ;82A414
        %Set8bit(!M)                             ;82A414;      ;
        %Set16bit(!X)                             ;82A416;      ;
        LDA.B !tilemap_to_load                            ;82A418;000022;
        CMP.B #$28                           ;82A41A;      ;
        BNE .CODE_82A473                      ;82A41C;82A473;
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
        BCC .CODE_82A473                      ;82A43F;82A473;
        CPX.W #$00EF                         ;82A441;      ;
        BCS .CODE_82A473                      ;82A444;82A473;
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
        BRA .CODE_82A4A4                      ;82A471;82A4A4;

    .CODE_82A473:
        %Set16bit(!M)                             ;82A473;      ;
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

    .CODE_82A4A4:
        %Set8bit(!M)                             ;82A4A4;      ;
        LDA.W !feed_chicks_N                          ;82A4A6;00092D;
        DEC A                                ;82A4A9;      ;
        STA.W !feed_chicks_N                          ;82A4AA;00092D;
        BNE .CODE_82A4B2                      ;82A4AD;82A4B2;
        STZ.W !tool_selected                          ;82A4AF;000921;

    .CODE_82A4B2:
        %Set8bit(!M)                             ;82A4B2;      ;
        LDA.B #$FE                           ;82A4B4;      ;
        JSL.L ChangeStamina                    ;82A4B6;81D061;
        %Set16bit(!MX)                             ;82A4BA;      ;
        LDA.W #$0000                         ;82A4BC;      ;
        STA.B !player_action                            ;82A4BF;0000D4;

        RTS                                  ;82A4C1;      ;

;;;;;;;;
PSUB_82A4C2: ;82A4C2
        %Set8bit(!M)                             ;82A4C2;      ;
        %Set16bit(!X)                             ;82A4C4;      ;
        LDA.B !tilemap_to_load                            ;82A4C6;000022;
        CMP.B #$27                           ;82A4C8;      ;
        BNE .CODE_82A521                      ;82A4CA;82A521;
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
        BCC .CODE_82A521                      ;82A4ED;82A521;
        CPX.W #$00EF                         ;82A4EF;      ;
        BCS .CODE_82A521                      ;82A4F2;82A521;
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
        BRA .CODE_82A552                      ;82A51F;82A552;

    .CODE_82A521:
        %Set16bit(!M)                             ;82A521;      ;
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

    .CODE_82A552:
        %Set8bit(!M)                             ;82A552;      ;
        LDA.W !feed_cow_N                          ;82A554;00092C;
        DEC A                                ;82A557;      ;
        STA.W !feed_cow_N                          ;82A558;00092C;
        BNE .CODE_82A560                      ;82A55B;82A560;
        STZ.W !tool_selected                          ;82A55D;000921;

    .CODE_82A560:
        %Set16bit(!MX)                             ;82A560;      ;
        LDA.W #$0000                         ;82A562;      ;
        STA.B !player_action                            ;82A565;0000D4;
        %Set8bit(!M)                             ;82A567;      ;
        LDA.B #$FE                           ;82A569;      ;
        JSL.L ChangeStamina                    ;82A56B;81D061;
        RTS                                  ;82A56F;      ;

;;;;;;;;
PSUB_82A570: ;82A570
        RTS                                  ;82A570;      ;