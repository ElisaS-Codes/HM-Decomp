;ORG $80AA7C
;


BackgroundsManagerTable: ;80AA7C
    dw MapFarmSpring                     ;80AA7C;00AB3C;0
    dw MapFarmSummer                     ;80AA7E;00AB5F;1
    dw MapFarmFall                       ;80AA80;00AB82;2
    dw MapFarmWinter                     ;80AA82;00ABA5;3
    dw MapTownSpring                     ;80AA84;00ABC8;4
    dw MapTownSummer                     ;80AA86;00ABEB;5
    dw MapTownFall                       ;80AA88;00AC0E;6
    dw MapTownWinter                     ;80AA8A;00AC31;7
    dw MapFlowerFestival                 ;80AA8C;00AC54;8 FLOWER FESTIVAL
    dw MapHarvestFestival                ;80AA8E;00AC77;9 HARVEST FESTIVAL

    dw UNK_DataReffedA                   ;80AA90;00AC9A;A
    dw UNK_DataReffedB                   ;80AA92;00ACBD;B

    dw MapForkSpring                     ;80AA94;00ACE0;C
    dw MapForkSummer                     ;80AA96;00ACF9;D
    dw MapForkFall                       ;80AA98;00AD12;E
    dw MapForkWinter                     ;80AA9A;00AD2B;F
    dw MapMountainSpring                 ;80AA9C;00AD44;10
    dw MapMountainSummer                 ;80AA9E;00AD67;11
    dw MapMountainFall                   ;80AAA0;00AD8A;12
    dw MapMountainWinter                 ;80AAA2;00ADAD;13

    dw UNK_DataReffed14                  ;80AAA4;00ADD0;14

    dw MapHouselvl1                      ;80AAA6;00ADF3;15
    dw MapHouselvl2                      ;80AAA8;00AE11;16
    dw MapHouselvl3                      ;80AAAA;00AE2F;17
    dw MapMayorHouse                     ;80AAAC;00AE4D;18
    dw MapMayorHouseHall                 ;80AAAE;00AE66;19
    dw MapMariasRoom                     ;80AAB0;00AE7F;1A
    dw MapChurch                         ;80AAB2;00AE98;1B
    dw MapFlowerShop                     ;80AAB4;00AEB1;1C
    dw MapFlowerShopRooms                ;80AAB6;00AECA;1D
    dw MapBar                            ;80AAB8;00AEE3;1E
    dw MapBarRooms                       ;80AABA;00AEFC;1F
    dw MapRestaurant                     ;80AABC;00AF15;20
    dw MapRestaurantRooms                ;80AABE;00AF2E;21
    dw MapGeneralStore                   ;80AAC0;00AF47;22
    dw MapGeneralStoreRooms              ;80AAC2;00AF60;23
    dw MapAnimalShop                     ;80AAC4;00AF79;24
    dw MapWitchHouse                     ;80AAC6;00AF92;25
    dw MapToolShed                       ;80AAC8;00AFAB;26
    dw MapBarn                           ;80AACA;00AFCE;27
    dw MapCoop                           ;80AACC;00AFE7;28
    dw MapMountainCave                   ;80AACE;00B000;29
    dw MapElfTunnel                      ;80AAD0;00B019;2A

    dw UNK_DataReffed2B                  ;80AAD2;00B032;2B
    dw UNK_DataReffed2C                  ;80AAD4;00B04B;2C
    dw UNK_DataReffed2D                  ;80AAD6;00B064;2D
    dw UNK_DataReffed2E                  ;80AAD8;00B087;2E
    dw UNK_DataReffed2F                  ;80AADA;00B0AA;2F
    dw UNK_DataReffed30                  ;80AADC;00B0CD;30 HANGS GAME
    dw MapSummitSpring                   ;80AADE;00B0F0;31
    dw MapSummitSummer                   ;80AAE0;00B113;32
    dw MapSummitFall                     ;80AAE2;00B136;33
    dw MapSummitWinter                   ;80AAE4;00B159;34
    dw UNK_DataReffed35                  ;80AAE6;00B17C;35
    dw UNK_DataReffed36                  ;80AAE8;00B19F;36
    dw UNK_DataReffed37                  ;80AAEA;00B1C2;37
    dw UNK_DataReffed38                  ;80AAEC;00B1E5;38
    dw UNK_DataReffed39                  ;80AAEE;00B208;39
    dw UNK_DataReffed3A                  ;80AAF0;00B22B;3A
    dw UNK_DataReffed3B                  ;80AAF2;00B24E;3B
    dw UNK_DataReffed3C                  ;80AAF4;00B271;3C Intro Scene
    dw UNK_DataReffed3D                  ;80AAF6;00B28A;3D
    dw UNK_DataReffed3E                  ;80AAF8;00B2AD;3E
    dw UNK_DataReffed3F                  ;80AAFA;00B2D0;3F
    dw UNK_DataReffed40                  ;80AAFC;00B2F3;40
    dw UNK_DataReffed41                  ;80AAFE;00B316;41
    dw UNK_DataReffed42                  ;80AB00;00B339;42
    dw UNK_DataReffed43                  ;80AB02;00B35C;43
    dw UNK_DataReffed44                  ;80AB04;00B37F;44
    dw UNK_DataReffed45                  ;80AB06;00B3A2;45
    dw UNK_DataReffed46                  ;80AB08;00B3C5;46
    dw UNK_DataReffed47                  ;80AB0A;00B3E8;47
    dw UNK_DataReffed48                  ;80AB0C;00B40B;48
    dw UNK_DataReffed49                  ;80AB0E;00B42E;49
    dw UNK_DataReffed4A                  ;80AB10;00B451;4A
    dw UNK_DataReffed4B                  ;80AB12;00B474;4B
    dw UNK_DataReffed4C                  ;80AB14;00B49C;4C
    dw UNK_DataReffed4D                  ;80AB16;00B4C4;4D
    dw UNK_DataReffed4E                  ;80AB18;00B4EC;4E
    dw UNK_DataReffed4F                  ;80AB1A;00B514;4F
    dw UNK_DataReffed50                  ;80AB1C;00B537;50
    dw UNK_DataReffed51                  ;80AB1E;00B55F;51
    dw UNK_DataReffed52                  ;80AB20;00B587;52
    dw UNK_DataReffed53                  ;80AB22;00B5AF;53
    dw UNK_DataReffed54                  ;80AB24;00B5D2;54
    dw UNK_DataReffed55                  ;80AB26;00B5F5;55
    dw UNK_DataReffed56                  ;80AB28;00B618;56

    ;Single tilemaps
    dw LayerRain                         ;80AB2A;00B640;57
    dw LayerClouds                       ;80AB2C;00B64E;58
    dw LayerSnow                         ;80AB2E;00B65C;59
    dw LayerHeavySnow                    ;80AB30;00B66A;5A

    ;Splash tilemaps
    dw IntroFarmScroll                   ;80AB32;00B678;5B
    dw HarvestMoonLogo                   ;80AB34;00B69A;5C
    dw NatsumeLogo                       ;80AB36;00B6A3;5D
    dw MenuScreenBackgrounds             ;80AB38;00B6B1;5E
    dw MenuCharacters                    ;80AB3A;00B6D3;5F

;Backgrounds
MapFarmSpring: ;80AB3C
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0300    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A18000  ;Compressed Location

MapFarmSummer: ;80AB5F
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0300    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A18000  ;Compressed Location

MapFarmFall: ;80AB82
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0300    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9282CB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $929D10  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $92BB03  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A18000  ;Compressed Location

MapFarmWinter: ;80ABA5
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0300    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $93B736  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $93D049  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $93E12B  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A18000  ;Compressed Location

MapTownSpring: ;80ABC8
        db $00      ;Graphic Preset
        dw $8060    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $97B45F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $998000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $999A74  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A38000  ;Compressed Location

MapTownSummer: ;80ABEB
        db $00      ;Graphic Preset
        dw $8060    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $97B45F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $97CD20  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $97E7A2  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A38000  ;Compressed Location

MapTownFall: ;80AC0E
        db $00      ;Graphic Preset
        dw $8060    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $97B45F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $988000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $989A52  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A38000  ;Compressed Location

MapTownWinter: ;80AC31
        db $00      ;Graphic Preset
        dw $8060    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0300    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $99DCBD  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9A8000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9A9921  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A38000  ;Compressed Location

MapFlowerFestival:      db $00,$60,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80AC54;      ;
                        db $20,$5F,$B4,$97,$00,$30,$00,$80,$99,$00,$40,$C3,$AE,$99,$00,$60;80AC64;      ;
                        db $79,$D3,$A4                       ;80AC74;      ;

MapHarvestFestival:     db $00,$60,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80AC77;      ;
                        db $20,$5F,$B4,$97,$00,$30,$00,$80,$98,$00,$40,$DB,$AE,$98,$00,$60;80AC87;      ;
                        db $DE,$C5,$A4                       ;80AC97;      ;

UNK_DataReffedA:        db $00,$60,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80AC9A;      ;
                        db $20,$BD,$DC,$99,$00,$30,$00,$80,$9A,$00,$40,$AB,$AE,$9A,$00,$60;80ACAA;      ;
                        db $27,$83,$A5                       ;80ACBA;      ;

UNK_DataReffedB:        db $00,$60,$00,$04,$04,$03,$01,$00,$00,$00,$02,$00,$00,$00,$03,$00;80ACBD;      ;
                        db $20,$5F,$B4,$97,$00,$30,$00,$80,$98,$00,$40,$F2,$C3,$99,$00,$60;80ACCD;      ;
                        db $7E,$DC,$A4                       ;80ACDD;      ;

MapForkSpring:          db $00,$60,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80ACE0;      ;
                        db $20,$6B,$CC,$98,$00,$60,$AB,$CF,$A4;80ACF0;      ;

MapForkSummer:          db $00,$60,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80ACF9;      ;
                        db $20,$6B,$CC,$98,$00,$60,$AB,$CF,$A4;80AD09;      ;

MapForkFall:            db $00,$60,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AD12;      ;
                        db $20,$6B,$CC,$98,$00,$60,$AB,$CF,$A4;80AD22;      ;

MapForkWinter:          db $00,$60,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AD2B;      ;
                        db $20,$1D,$E4,$98,$00,$60,$AB,$CF,$A4;80AD3B;      ;

MapMountainSpring:      db $00,$E0,$80,$04,$04,$03,$01,$00,$00,$00,$02,$00,$00,$00,$02,$00;80AD44;      ;
                        db $20,$CE,$E7,$9D,$00,$30,$00,$80,$9E,$00,$40,$00,$80,$9D,$00,$60;80AD54;      ;
                        db $00,$80,$A2                       ;80AD64;      ;

MapMountainSummer:      db $00,$E0,$80,$04,$04,$03,$01,$00,$00,$00,$02,$00,$00,$00,$02,$00;80AD67;      ;
                        db $20,$A3,$CB,$9C,$00,$30,$7D,$E3,$9C,$00,$40,$00,$80,$9D,$00,$60;80AD77;      ;
                        db $00,$80,$A2                       ;80AD87;      ;

MapMountainFall:        db $00,$E0,$80,$04,$04,$03,$01,$00,$00,$00,$02,$00,$00,$00,$02,$00;80AD8A;      ;
                        db $20,$1C,$99,$9D,$00,$30,$5E,$B1,$9D,$00,$40,$31,$CE,$9D,$00,$60;80AD9A;      ;
                        db $00,$80,$A2                       ;80ADAA;      ;

MapMountainWinter:      db $00,$E0,$80,$04,$04,$03,$01,$00,$00,$00,$02,$00,$00,$00,$02,$00;80ADAD;      ;
                        db $20,$DC,$9E,$9E,$00,$30,$5D,$B7,$9E,$00,$40,$08,$D2,$9E,$00,$60;80ADBD;      ;
                        db $00,$80,$A2                       ;80ADCD;      ;

UNK_DataReffed14:       db $00,$E0,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80ADD0;      ;
                        db $20,$DC,$9E,$9E,$00,$30,$5D,$B7,$9E,$00,$40,$08,$D2,$9E,$00,$60;80ADE0;      ;
                        db $0B,$9E,$A5                       ;80ADF0;      ;

MapHouselvl1:           db $00,$00,$00,$01,$01,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80ADF3;      ;
                        db $20,$00,$C0,$95,$00,$30,$E2,$D6,$95,$00,$60,$84,$9B,$A4;80AE03;      ;

MapHouselvl2:           db $00,$00,$00,$01,$01,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AE11;      ;
                        db $20,$00,$C0,$95,$00,$30,$E2,$D6,$95,$00,$60,$5C,$94,$A4;80AE21;      ;

MapHouselvl3:           db $00,$00,$00,$02,$01,$02,$01,$00,$00,$A0,$00,$00,$00,$00,$00,$00;80AE2F;      ;
                        db $20,$00,$C0,$95,$00,$30,$E2,$D6,$95,$00,$60,$45,$97,$A4;80AE3F;      ;

MapMayorHouse:          db $00,$00,$00,$02,$02,$01,$01,$10,$00,$C0,$00,$00,$00,$00,$00,$00;80AE4D;      ;
                        db $20,$A3,$E8,$95,$00,$60,$2E,$9E,$A4;80AE5D;      ;

MapMayorHouseHall:      db $00,$00,$00,$02,$02,$01,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00;80AE66;      ;
                        db $20,$A3,$E8,$95,$00,$60,$2E,$9E,$A4;80AE76;      ;

MapMariasRoom:          db $00,$00,$00,$02,$02,$01,$01,$00,$00,$00,$00,$00,$01,$00,$01,$00;80AE7F;      ;
                        db $20,$A3,$E8,$95,$00,$60,$2E,$9E,$A4;80AE8F;      ;

MapChurch:              db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$00,$00,$01,$00;80AE98;      ;
                        db $20,$00,$80,$96,$00,$60,$97,$A5,$A4;80AEA8;      ;

MapFlowerShop:          db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$01,$00,$01,$00;80AEB1;      ;
                        db $30,$37,$94,$96,$00,$60,$99,$AA,$A4;80AEC1;      ;

MapFlowerShopRooms:     db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AECA;      ;
                        db $30,$37,$94,$96,$00,$60,$99,$AA,$A4;80AEDA;      ;

MapBar:                 db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$01,$00,$01,$00;80AEE3;      ;
                        db $30,$11,$AD,$96,$00,$60,$95,$AE,$A4;80AEF3;      ;

MapBarRooms:            db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AEFC;      ;
                        db $30,$11,$AD,$96,$00,$60,$95,$AE,$A4;80AF0C;      ;

MapRestaurant:          db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$01,$00,$01,$00;80AF15;      ;
                        db $30,$89,$C4,$96,$00,$60,$D1,$B3,$A4;80AF25;      ;

MapRestaurantRooms:     db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AF2E;      ;
                        db $30,$89,$C4,$96,$00,$60,$D1,$B3,$A4;80AF3E;      ;

MapGeneralStore:        db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$01,$00,$01,$00;80AF47;      ;
                        db $30,$6D,$DC,$96,$00,$60,$E0,$B8,$A4;80AF57;      ;

MapGeneralStoreRooms:   db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AF60;      ;
                        db $30,$6D,$DC,$96,$00,$60,$E0,$B8,$A4;80AF70;      ;

MapAnimalShop:          db $00,$00,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AF79;      ;
                        db $30,$00,$80,$97,$00,$60,$C1,$BC,$A4;80AF89;      ;

MapWitchHouse:          db $00,$00,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AF92;      ;
                        db $30,$88,$9A,$97,$00,$60,$65,$C0,$A4;80AFA2;      ;

MapToolShed:            db $02,$00,$00,$01,$01,$02,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AFAB;      ;
                        db $20,$2D,$E0,$9A,$00,$30,$00,$80,$9B,$00,$70,$08,$9C,$A5,$00,$60;80AFBB;      ;
                        db $49,$8B,$A5                       ;80AFCB;      ;

MapBarn:                db $00,$00,$00,$01,$02,$01,$01,$00,$00,$00,$00,$00,$00,$A0,$00,$00;80AFCE;      ;
                        db $20,$0C,$A4,$9C,$00,$60,$CD,$C4,$A5;80AFDE;      ;

MapCoop:                db $00,$00,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80AFE7;      ;
                        db $20,$0C,$A4,$9C,$00,$60,$58,$C2,$A5;80AFF7;      ;

MapMountainCave:        db $00,$20,$00,$02,$02,$01,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B000;      ;
                        db $20,$00,$80,$94,$00,$60,$2D,$8A,$A4;80B010;      ;

MapElfTunnel:           db $00,$20,$00,$01,$03,$01,$01,$00,$00,$00,$00,$00,$00,$00,$02,$00;80B019;      ;
                        db $20,$00,$80,$94,$00,$60,$AE,$81,$A4;80B029;      ;

UNK_DataReffed2B:       db $00,$00,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B032;      ;
                        db $20,$53,$9F,$9B,$00,$60,$3B,$B6,$A5;80B042;      ;

UNK_DataReffed2C:       db $00,$00,$00,$01,$03,$01,$01,$00,$00,$00,$00,$00,$00,$00,$02,$00;80B04B;      ;
                        db $20,$AD,$86,$9B,$00,$60,$A0,$A6,$A5;80B05B;      ;

UNK_DataReffed2D:       db $00,$00,$00,$01,$02,$03,$01,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B064;      ;
                        db $20,$5F,$B4,$97,$00,$30,$00,$80,$99,$00,$40,$74,$9A,$99,$00,$60;80B074;      ;
                        db $00,$80,$A3                       ;80B084;      ;

UNK_DataReffed2E:       db $00,$00,$00,$01,$02,$03,$01,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B087;      ;
                        db $20,$5F,$B4,$97,$00,$30,$20,$CD,$97,$00,$40,$A2,$E7,$97,$00,$60;80B097;      ;
                        db $00,$80,$A3                       ;80B0A7;      ;

UNK_DataReffed2F:       db $00,$00,$00,$01,$02,$03,$01,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B0AA;      ;
                        db $20,$5F,$B4,$97,$00,$30,$00,$80,$98,$00,$40,$52,$9A,$98,$00,$60;80B0BA;      ;
                        db $00,$80,$A3                       ;80B0CA;      ;

UNK_DataReffed30:       db $00,$00,$00,$01,$02,$03,$01,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B0CD;      ;
                        db $20,$BD,$DC,$99,$00,$30,$00,$80,$9A,$00,$40,$21,$99,$9A,$00,$60;80B0DD;      ;
                        db $00,$80,$A3                       ;80B0ED;      ;

MapSummitSpring:        db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B0F0;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B100;      ;
                        db $17,$AD,$A5                       ;80B110;      ;

MapSummitSummer:        db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B113;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B123;      ;
                        db $17,$AD,$A5                       ;80B133;      ;

MapSummitFall:          db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B136;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B146;      ;
                        db $17,$AD,$A5                       ;80B156;      ;

MapSummitWinter:        db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B159;      ;
                        db $20,$8F,$CF,$9B,$00,$30,$5F,$96,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B169;      ;
                        db $17,$AD,$A5                       ;80B179;      ;

UNK_DataReffed35:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B17C;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B18C;      ;
                        db $42,$B0,$A5                       ;80B19C;      ;

UNK_DataReffed36:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B19F;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B1AF;      ;
                        db $42,$B0,$A5                       ;80B1BF;      ;

UNK_DataReffed37:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B1C2;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$70,$42,$B0,$A5,$00,$60;80B1D2;      ;
                        db $43,$B9,$A5                       ;80B1E2;      ;

UNK_DataReffed38:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B1E5;      ;
                        db $20,$8F,$CF,$9B,$00,$30,$5F,$96,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B1F5;      ;
                        db $42,$B0,$A5                       ;80B205;      ;

UNK_DataReffed39:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B208;      ;
                        db $20,$8F,$CF,$9B,$00,$30,$5F,$96,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B218;      ;
                        db $61,$B3,$A5                       ;80B228;      ;

UNK_DataReffed3A:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B22B;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B23B;      ;
                        db $17,$AD,$A5                       ;80B24B;      ;

UNK_DataReffed3B:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B24E;      ;
                        db $20,$6D,$B7,$9B,$00,$30,$00,$80,$9C,$00,$60,$8A,$BD,$A5,$00,$70;80B25E;      ;
                        db $17,$AD,$A5                       ;80B26E;      ;

UNK_DataReffed3C:       db $00,$00,$00,$01,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B271;      ;
                        db $20,$6B,$CC,$98,$00,$60,$CF,$8D,$A6;80B281;      ;

UNK_DataReffed3D:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B28A;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B29A;      ;
                        db $53,$E2,$A5                       ;80B2AA;      ;

UNK_DataReffed3E:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B2AD;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B2BD;      ;
                        db $CE,$E5,$A5                       ;80B2CD;      ;

UNK_DataReffed3F:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B2D0;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B2E0;      ;
                        db $77,$E9,$A5                       ;80B2F0;      ;

UNK_DataReffed40:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B2F3;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B303;      ;
                        db $FB,$EC,$A5                       ;80B313;      ;

UNK_DataReffed41:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B316;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B326;      ;
                        db $71,$F6,$A5                       ;80B336;      ;

UNK_DataReffed42:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B339;      ;
                        db $20,$5F,$B4,$97,$00,$30,$20,$CD,$97,$00,$40,$A2,$E7,$97,$00,$60;80B349;      ;
                        db $5C,$F9,$A5                       ;80B359;      ;

UNK_DataReffed43:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B35C;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B36C;      ;
                        db $CE,$FB,$A5                       ;80B37C;      ;

UNK_DataReffed44:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B37F;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B38F;      ;
                        db $00,$80,$A6                       ;80B39F;      ;

UNK_DataReffed45:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B3A2;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B3B2;      ;
                        db $29,$82,$A6                       ;80B3C2;      ;

UNK_DataReffed46:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B3C5;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B3D5;      ;
                        db $33,$84,$A6                       ;80B3E5;      ;

UNK_DataReffed47:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B3E8;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B3F8;      ;
                        db $7E,$86,$A6                       ;80B408;      ;

UNK_DataReffed48:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B40B;      ;
                        db $20,$A3,$CB,$9C,$00,$30,$7D,$E3,$9C,$00,$40,$00,$80,$9D,$00,$60;80B41B;      ;
                        db $64,$88,$A6                       ;80B42B;      ;

UNK_DataReffed49:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B42E;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B43E;      ;
                        db $59,$F0,$A5                       ;80B44E;      ;

UNK_DataReffed4A:       db $00,$00,$00,$01,$01,$03,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00;80B451;      ;
                        db $20,$AB,$D3,$92,$00,$30,$00,$80,$93,$00,$40,$8E,$9E,$93,$00,$60;80B461;      ;
                        db $5A,$F4,$A5                       ;80B471;      ;

UNK_DataReffed4B:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B474;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B484;      ;
                        db $32,$92,$A0,$00,$60,$A6,$90,$A6   ;80B494;      ;

UNK_DataReffed4C:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B49C;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B4AC;      ;
                        db $32,$92,$A0,$00,$60,$A6,$90,$A6   ;80B4BC;      ;

UNK_DataReffed4D:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B4C4;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B4D4;      ;
                        db $32,$92,$A0,$00,$60,$A6,$90,$A6   ;80B4E4;      ;

UNK_DataReffed4E:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B4EC;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B4FC;      ;
                        db $32,$92,$A0,$00,$60,$A6,$90,$A6   ;80B50C;      ;

UNK_DataReffed4F:       db $05,$00,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B514;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$60;80B524;      ;
                        db $EE,$94,$A6                       ;80B534;      ;

UNK_DataReffed50:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B537;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B547;      ;
                        db $82,$E6,$A0,$00,$60,$EE,$94,$A6   ;80B557;      ;

UNK_DataReffed51:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B55F;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B56F;      ;
                        db $1E,$AB,$A0,$00,$60,$EE,$94,$A6   ;80B57F;      ;

UNK_DataReffed52:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B587;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B597;      ;
                        db $32,$92,$A0,$00,$60,$EE,$94,$A6   ;80B5A7;      ;

UNK_DataReffed53:       db $05,$00,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B5AF;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$60;80B5BF;      ;
                        db $96,$99,$A6                       ;80B5CF;      ;

UNK_DataReffed54:       db $05,$00,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B5D2;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$60;80B5E2;      ;
                        db $96,$99,$A6                       ;80B5F2;      ;

UNK_DataReffed55:       db $05,$00,$00,$02,$02,$03,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B5F5;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$60;80B605;      ;
                        db $96,$99,$A6                       ;80B615;      ;

UNK_DataReffed56:       db $05,$00,$00,$02,$02,$04,$01,$00,$00,$00,$01,$00,$00,$00,$01,$00;80B618;      ;
                        db $20,$3D,$EB,$9E,$00,$30,$00,$80,$A0,$00,$40,$E9,$88,$A0,$00,$50;80B628;      ;
                        db $AF,$CA,$A0,$00,$60,$96,$99,$A6   ;80B638;      ;

;Single tilemaps
LayerRain:              db $01,$02,$01,$01,$00,$50,$00,$80,$92,$00,$70,$00,$80,$A4;80B640

LayerClouds:            db $01,$02,$01,$01,$00,$50,$1A,$B1,$97,$00,$70,$E2,$C3,$A4;80B64E

LayerSnow:              db $01,$02,$01,$01,$00,$50,$6D,$9C,$9E,$00,$70,$55,$C9,$A5;80B65C

LayerHeavySnow:         db $01,$02,$01,$01,$00,$50,$41,$84,$9B,$00,$70,$D5,$A3,$A5;80B66A

;Splash tilemaps
IntroFarmScroll:        db $02,$02, $04,$02, $00,$20, $00,$80,$9F,$00,$30,$6C,$94,$9F,$00,$40;80B678
                        db $75,$AA,$9F,$00,$50,$4C,$C0,$9F,$00,$60,$88,$CD,$A5,$00,$70,$4C
                        db $D4,$A5

HarvestMoonLogo:        db $02,$02, $00,$01, $00,$60, $4A,$D9,$A5;80B69A

NatsumeLogo:            db $02,$02, $01,$01, $00,$20, $97,$EF,$9F, $00,$60, $84,$DE,$A5;80B6A3

MenuScreenBackgrounds:  db $02,$02, $04,$02, $00,$20, $97,$BF,$9A, $00,$30,$89,$C4,$9A,$00,$40;80B6B1
                        db $41,$CB,$9A,$00,$50,$57,$D3,$9A,$00,$10,$00,$80,$A5,$00,$60,$0F
                        db $97,$A5

MenuCharacters:         db $02,$02,$04,$02,$00,$20,$97,$BF,$9A,$00,$30,$89,$C4,$9A,$00,$40;80B6D3
                        db $41,$CB,$9A,$00,$50,$57,$D3,$9A,$00,$10,$8E,$8D,$A5,$00,$60,$0F
                        db $97,$A5