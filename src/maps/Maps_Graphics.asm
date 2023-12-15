;ORG $80AA7C
;


Maps_Graphics_Table: ;80AA7C
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
    dw MapUnknown2B                      ;2B
    dw MapUnknown2C                      ;2C
    dw MapUnknown2D                      ;2D
    dw MapUnknown2E                      ;2E
    dw MapUnknown2F                      ;2F
    dw MapUnknown30                      ;30 HANGS GAME
    dw MapSummitSpring                   ;31
    dw MapSummitSummer                   ;32
    dw MapSummitFall                     ;33
    dw MapSummitWinter                   ;34
    dw MapUnknown35                      ;35
    dw MapUnknown36                      ;36
    dw MapUnknown37                      ;37
    dw MapUnknown38                      ;38
    dw MapStarNightFestivalMountainTop   ;39
    dw MapNewYearsFestival               ;3A
    dw MapUnknown3B                      ;3B
    dw MapUnknown3C                      ;3C Intro Scene
    dw MapUnknown3D                      ;3D
    dw MapUnknown3E                      ;3E
    dw MapUnknown3F                      ;3F
    dw MapUnknown40                      ;40
    dw MapUnknown41                      ;41
    dw MapUnknown42                      ;42
    dw MapUnknown43                      ;43
    dw MapUnknown44                      ;44
    dw MapUnknown45                      ;45
    dw MapUnknown46                      ;46
    dw MapUnknown47                      ;47
    dw MapUnknown48                      ;48
    dw MapUnknown49                      ;49
    dw MapUnknown4A                      ;4A
    dw MapUnknown4B                      ;4B
    dw MapUnknown4C                      ;4C
    dw MapUnknown4D                      ;4D
    dw MapUnknown4E                      ;4E
    dw MapUnknown4F                      ;4F
    dw MapUnknown50                      ;50
    dw MapUnknown51                      ;51
    dw MapUnknown52                      ;52
    dw MapUnknown53                      ;53
    dw MapUnknown54                      ;54
    dw MapUnknown55                      ;55
    dw MapUnknown56                      ;56

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

MapRestaurant: ;80AF15
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
        dl $96C489  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4B3D1  ;Compressed Location

MapRestaurantRooms: ;80AF2E
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
        dl $96C489  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4B3D1  ;Compressed Location

MapGeneralStore: ;80AF47
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
        dl $96DC6D  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4B8E0  ;Compressed Location

MapGeneralStoreRooms: ;80AF60
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
        dl $96DC6D  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4B8E0  ;Compressed Location

MapAnimalShop: ;80AF79
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $3000    ;Destination in VRAM 1
        dl $978000  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4BCC1  ;Compressed Location

MapWitchHouse: ;80AF92
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $3000    ;Destination in VRAM 1
        dl $979A88  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A4C065  ;Compressed Location

MapToolShed: ;80AFAB
        db $02      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $01      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0000    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9AE02D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9B8000  ;Compressed Location 2
        ;Character maps
        dw $7000    ;Destination in VRAM 1
        dl $A59C08  ;Compressed Location 1
        dw $6000    ;Destination in VRAM 2
        dl $A58B49  ;Compressed Location 2

MapBarn: ;80AFCE
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $00A0    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9CA40C  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A5C4CD  ;Compressed Location

MapCoop: ;80AFE7
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9CA40C  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A5C258  ;Compressed Location

MapMountainCave: ;80B000
        db $00      ;Graphic Preset
        dw $0020    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $948000  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A48A2D  ;Compressed Location

MapElfTunnel: ;80B019
        db $00      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $03      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0200    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $948000  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A481AE  ;Compressed Location

MapUnknown2B: ;80B032
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9B9F53  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A5B63B  ;Compressed Location

MapUnknown2C: ;80B04B
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $03      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0200    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9B86AD  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM
        dl $A5A6A0  ;Compressed Location

MapUnknown2D: ;80B064
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
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

MapUnknown2E: ;80B087
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
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

MapUnknown2F: ;80B0AA
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
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

MapUnknown30: ;80B0CD
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $03      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
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

MapSummitSpring: ;80B0F0
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5AD17  ;Compressed Location 2

MapSummitSummer: ;80B113
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5AD17  ;Compressed Location 2

MapSummitFall: ;80B136
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5AD17  ;Compressed Location 2

MapSummitWinter: ;80B159
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BCF8F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C965F  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5AD17  ;Compressed Location 2

MapUnknown35: ;80B17C
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5B042  ;Compressed Location 2

MapUnknown36: ;80B19F
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5B042  ;Compressed Location 2

MapUnknown37: ;80B1C2

        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $7000    ;Destination in VRAM 1
        dl $A5B042  ;Compressed Location 1
        dw $6000    ;Destination in VRAM 2
        dl $A5B943  ;Compressed Location 2

MapUnknown38: ;80B1E5
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BCF8F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C965F  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5B042  ;Compressed Location 2

MapStarNightFestivalMountainTop: ;80B208
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BCF8F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C965F  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5B361  ;Compressed Location 2

MapNewYearsFestival: ;80B22B
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5B943  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5AD17  ;Compressed Location 2

MapUnknown3B: ;80B24E
        db $01      ;Graphic Preset
        dw $0020    ;ored with 196
        db $01      ;$0181
        db $02      ;$0182
        db $02      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0000    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9BB76D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9C8000  ;Compressed Location 2
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5BD8A  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5AD17  ;Compressed Location 2

MapUnknown3C: ;80B271
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dw $6000    ;Destination in VRAM 1
        dl $A68DCF  ;Compressed Location 1

MapUnknown3D: ;80B28A
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5E253  ;Compressed Location 1

MapUnknown3E: ;80B2AD
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5E5CE  ;Compressed Location 1

MapUnknown3F: ;80B2D0
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5E977  ;Compressed Location 1

MapUnknown40: ;80B2F3
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5ECFB  ;Compressed Location 1

MapUnknown41: ;80B2F3
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5F671  ;Compressed Location 1

MapUnknown42: ;80B339
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $97B45F  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $97CD20  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $97E7A2  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5F95C  ;Compressed Location 1

MapUnknown43: ;80B35C
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5FBCE  ;Compressed Location 1

MapUnknown44: ;80B37F
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A68000  ;Compressed Location 1

MapUnknown45: ;80B3A2
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A68229  ;Compressed Location 1

MapUnknown46: ;80B3C5
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A68433  ;Compressed Location 1

MapUnknown47: ;80B3E8
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A6867E  ;Compressed Location 1

MapUnknown48: ;80B40B
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9CCBA3  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9CE37D  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9D8000  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A68864  ;Compressed Location 1

MapUnknown49: ;80B42E
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5F059  ;Compressed Location 1

MapUnknown4A: ;80B451
        db $00      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $92D3AB  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $938000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $939E8E  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5F45A  ;Compressed Location 1

MapUnknown4B: ;80B474
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A09232  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A690A6  ;Compressed Location 1

MapUnknown4C: ;80B49C
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A09232  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A690A6  ;Compressed Location 1

MapUnknown4D: ;80B4C4
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A09232  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A690A6  ;Compressed Location 1

MapUnknown4E: ;80B4EC
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A09232  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A690A6  ;Compressed Location 1

MapUnknown4F: ;80B514
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A694EE  ;Compressed Location 1

MapUnknown50: ;80B537
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A0E682  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A694EE  ;Compressed Location 1

MapUnknown51: ;80B55F
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A0AB1E  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A694EE  ;Compressed Location 1

MapUnknown52: ;80B587
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A09232  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A694EE  ;Compressed Location 1

MapUnknown53: ;80B5AF
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A69996  ;Compressed Location 1

MapUnknown54: ;80B5D2
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A69996  ;Compressed Location 1

MapUnknown55: ;80B5F5
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
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
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A69996  ;Compressed Location 1

MapUnknown56: ;80B618
        db $05      ;Graphic Preset
        dw $0000    ;ored with 196
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        dw $0000    ;OBJ_clamp_left
        dw $0100    ;OBJ_clamp_right
        dw $0000    ;OBJ_clamp_up
        dw $0100    ;OBJ_clamp_down
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9EEB3D  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $A08000  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $A088E9  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $A0CAAF  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A69996  ;Compressed Location 1

;Single tilemaps
LayerRain: ;80B640
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        ;Tile maps
        dw $5000    ;Destination in VRAM 1
        dl $928000  ;Compressed Location 1
        ;Character maps
        dw $7000    ;Destination in VRAM 1
        dl $A48000  ;Compressed Location 1

LayerClouds: ;80B64E
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        ;Tile maps
        dw $5000    ;Destination in VRAM 1
        dl $97B11A  ;Compressed Location 1
        ;Character maps
        dw $7000    ;Destination in VRAM 1
        dl $A4C3E2  ;Compressed Location 1

LayerSnow: ;80B65C
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        ;Tile maps
        dw $5000    ;Destination in VRAM 1
        dl $9E9C6D  ;Compressed Location 1
        ;Character maps
        dw $7000    ;Destination in VRAM 1
        dl $A5C955  ;Compressed Location 1

LayerHeavySnow: ;80B66A
        db $01      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        ;Tile maps
        dw $5000    ;Destination in VRAM 1
        dl $9B8441  ;Compressed Location 1
        ;Character maps
        dw $7000    ;Destination in VRAM 1
        dl $A5A3D5  ;Compressed Location 1

;Splash tilemaps
IntroFarmScroll: ;80B678
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9F8000  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9F946C  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9FAA75  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $9FC04C  ;Compressed Location 4
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5CD88  ;Compressed Location 1
        dw $7000    ;Destination in VRAM 2
        dl $A5D44C  ;Compressed Location 2

HarvestMoonLogo: ;80B69A
        db $02      ;$0181
        db $02      ;$0182
        db $00      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5D94A  ;Compressed Location 1

NatsumeLogo: ;80B6A3
        db $02      ;$0181
        db $02      ;$0182
        db $01      ;number_of_tilemaps
        db $01      ;number_of_charactermaps
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9FEF97  ;Compressed Location 1
        ;Character maps
        dw $6000    ;Destination in VRAM 1
        dl $A5DE84  ;Compressed Location 1

MenuScreenBackgrounds: ;80B6B1
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9ABF97  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9AC489  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9ACB41  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $9AD357  ;Compressed Location 4
        ;Character maps
        dw $1000    ;Destination in VRAM 1
        dl $A58000  ;Compressed Location 1
        dw $6000    ;Destination in VRAM 2
        dl $A5970F  ;Compressed Location 2

MenuCharacters: ;80B6D3
        db $02      ;$0181
        db $02      ;$0182
        db $04      ;number_of_tilemaps
        db $02      ;number_of_charactermaps
        ;Tile maps
        dw $2000    ;Destination in VRAM 1
        dl $9ABF97  ;Compressed Location 1
        dw $3000    ;Destination in VRAM 2
        dl $9AC489  ;Compressed Location 2
        dw $4000    ;Destination in VRAM 3
        dl $9ACB41  ;Compressed Location 3
        dw $5000    ;Destination in VRAM 4
        dl $9AD357  ;Compressed Location 4
        ;Character maps
        dw $1000    ;Destination in VRAM 1
        dl $A58D8E  ;Compressed Location 1
        dw $6000    ;Destination in VRAM 2
        dl $A5970F  ;Compressed Location 2