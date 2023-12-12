;ORG $80AA7C
;


BackgroundsManagerTable: ;80AA7C
    dw MapFarmSpring                     ;00
    dw MapFarmSummer                     ;01
    dw MapFarmFall                       ;02
    dw MapFarmWinter                     ;03
    dw MapTownSpring                     ;04
    dw MapTownSummer                     ;05
    dw MapTownFall                       ;06
    dw MapTownWinter                     ;07
    dw MapFlowerFestival                 ;08
    dw MapHarvestFestival                ;09
    dw MapStarNightFestivalSquare        ;0A
    dw MapEggFestival                    ;0B
    dw MapForkSpring                     ;0C
    dw MapForkSummer                     ;0D
    dw MapForkFall                       ;0E
    dw MapForkWinter                     ;0F
    dw MapMountainSpring                 ;10
    dw MapMountainSummer                 ;11
    dw MapMountainFall                   ;12
    dw MapMountainWinter                 ;13
    dw MapStarNightFestivalSpa           ;14
    dw MapHouselvl1                      ;15
    dw MapHouselvl2                      ;16
    dw MapHouselvl3                      ;17
    dw MapMayorHouse                     ;18
    dw MapMayorHouseHall                 ;19
    dw MapMariasRoom                     ;1A
    dw MapChurch                         ;1B
    dw MapFlowerShop                     ;1C
    dw MapFlowerShopRooms                ;1D
    dw MapBar                            ;1E
    dw MapBarRooms                       ;1F
    dw MapRestaurant                     ;20
    dw MapRestaurantRooms                ;21
    dw MapGeneralStore                   ;22
    dw MapGeneralStoreRooms              ;23
    dw MapAnimalShop                     ;24
    dw MapWitchHouse                     ;25
    dw MapToolShed                       ;26
    dw MapBarn                           ;27
    dw MapCoop                           ;28
    dw MapMountainCave                   ;29
    dw MapElfTunnel                      ;2A

    dw UNK_DataReffed2B                  ;2B
    dw UNK_DataReffed2C                  ;2C
    dw UNK_DataReffed2D                  ;2D
    dw UNK_DataReffed2E                  ;2E
    dw UNK_DataReffed2F                  ;2F
    dw UNK_DataReffed30                  ;30 HANGS GAME

    dw MapSummitSpring                   ;31
    dw MapSummitSummer                   ;32
    dw MapSummitFall                     ;33
    dw MapSummitWinter                   ;34

    dw UNK_DataReffed35                  ;35
    dw UNK_DataReffed36                  ;36
    dw UNK_DataReffed37                  ;37
    dw UNK_DataReffed38                  ;38

    dw MapStarNightFestivalMountainTop   ;39
    dw MapNewYearsFestival               ;3A

    dw UNK_DataReffed3B                  ;3B
    dw UNK_DataReffed3C                  ;3C Intro Scene
    dw UNK_DataReffed3D                  ;3D
    dw UNK_DataReffed3E                  ;3E
    dw UNK_DataReffed3F                  ;3F
    dw UNK_DataReffed40                  ;40
    dw UNK_DataReffed41                  ;41
    dw UNK_DataReffed42                  ;42
    dw UNK_DataReffed43                  ;43
    dw UNK_DataReffed44                  ;44
    dw UNK_DataReffed45                  ;45
    dw UNK_DataReffed46                  ;46
    dw UNK_DataReffed47                  ;47
    dw UNK_DataReffed48                  ;48
    dw UNK_DataReffed49                  ;49
    dw UNK_DataReffed4A                  ;4A
    dw UNK_DataReffed4B                  ;4B
    dw UNK_DataReffed4C                  ;4C
    dw UNK_DataReffed4D                  ;4D
    dw UNK_DataReffed4E                  ;4E
    dw UNK_DataReffed4F                  ;4F
    dw UNK_DataReffed50                  ;50
    dw UNK_DataReffed51                  ;51
    dw UNK_DataReffed52                  ;52
    dw UNK_DataReffed53                  ;53
    dw UNK_DataReffed54                  ;54
    dw UNK_DataReffed55                  ;55
    dw UNK_DataReffed56                  ;56

    ;Single tilemaps
    dw LayerRain                         ;57
    dw LayerClouds                       ;58
    dw LayerSnow                         ;59
    dw LayerHeavySnow                    ;5A

    ;Splash tilemaps
    dw IntroFarmScroll                   ;5B
    dw HarvestMoonLogo                   ;5C
    dw NatsumeLogo                       ;5D
    dw MenuScreenBackgrounds             ;5E
    dw MenuCharacters                    ;5F

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

MapFlowerFestival: ;80AC54
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $97B45F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $998000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $99AEC3  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4D379  ;Compressed Location

MapHarvestFestival: ;80AC77
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $97B45F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $988000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $98AEDB  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4C5DE  ;Compressed Location

MapStarNightFestivalSquare: ;80AC9A
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $99DCBD  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9A8000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9AAEAB  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A58327  ;Compressed Location

MapEggFestival: ;80ACBD
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
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
        dl $99C3F2  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4DC7E  ;Compressed Location

MapForkSpring: ;80ACE0
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $98CC6B  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4CFAB  ;Compressed Location

MapForkSummer: ;80ACF9
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $98CC6B  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4CFAB  ;Compressed Location

MapForkFall: ;80AD12
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $98CC6B  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4CFAB  ;Compressed Location

MapForkWinter: ;80AD2B
        db $00      ;Graphic Preset
        dw $0060    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $98E41D  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4CFAB  ;Compressed Location

MapMountainSpring: ;80AD44
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0200    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9DE7CE  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9E8000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9D8000  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A28000  ;Compressed Location

MapMountainSummer: ;80AD67
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0200    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9CCBA3  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9CE37D  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9D8000  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A28000  ;Compressed Location

MapMountainFall: ;80AD8A
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0200    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9D991C  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9DB15E  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9DCE31  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A28000  ;Compressed Location

MapMountainWinter: ;80ADAD
        db $00      ;Graphic Preset
        dw $80E0    ;ored with 196
        db $04      ;$0181
        db $04      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0200    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0200    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9E9EDC  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9EB75D  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9ED208  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A28000  ;Compressed Location

MapStarNightFestivalSpa: ;80ADD0
        db $00      ;Graphic Preset
        dw $00E0    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9E9EDC  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9EB75D  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9ED208  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A59E0B  ;Compressed Location

MapHouselvl1: ;80ADF3
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $02      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $95C000  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $95D6E2  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A49B84  ;Compressed Location

MapHouselvl2: ;80AE11
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $02      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $95C000  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $95D6E2  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4945C  ;Compressed Location

MapHouselvl3: ;80AE2F
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $01      ;$0182
        db $02      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $00A0    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $95C000  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $95D6E2  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A49745  ;Compressed Location

MapMayorHouse: ;80AE4D
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0010    ;OBJ_clamp_left
        dw $00C0    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $95E8A3  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A49E2E  ;Compressed Location

MapMayorHouseHall: ;80AE66
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0100    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0100    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $95E8A3  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A49E2E  ;Compressed Location

MapMariasRoom: ;80AE7F
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0100    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $95E8A3  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A49E2E  ;Compressed Location

MapChurch: ;80AE98
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $968000  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4A597  ;Compressed Location

MapFlowerShop: ;80AEB1
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0100    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $3000    ;Destination in VRAM 1
        dl $969437  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4AA99  ;Compressed Location

MapFlowerShopRooms: ;80AECA
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $3000    ;Destination in VRAM 1
        dl $969437  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4AA99  ;Compressed Location

MapBar: ;80AEE3
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0100    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $3000    ;Destination in VRAM 1
        dl $96AD11  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4AE95  ;Compressed Location

MapBarRooms: ;80AEFC
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $3000    ;Destination in VRAM 1
        dl $96AD11  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4AE95  ;Compressed Location

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

MapStarNightFestivalMountainTop:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B208;      ;
                        db $20,$8F,$CF,$9B,$00,$30,$5F,$96,$9C,$00,$60,$43,$B9,$A5,$00,$70;80B218;      ;
                        db $61,$B3,$A5                       ;80B228;      ;

MapNewYearsFestival:       db $01,$20,$00,$01,$02,$02,$02,$00,$00,$00,$00,$00,$00,$00,$01,$00;80B22B;      ;
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