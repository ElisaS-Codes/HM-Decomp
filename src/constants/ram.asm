;Scratch memory, every thing here is not usually important, also used for
;parameters and function returns. usually used as 16b, but sometimes some
;are used as 8b, specially for banks for long pointers. 72 and 7E are the most used
!scratch70 = $70
!scratch72 = $72
!scratch74 = $74
!scratch7E = $7E
!scratch80 = $80
!scratch82 = $82
!scratch92 = $92
!scratch93 = $93
!scratch94 = $94

!param1 = $92
!param2 = $93
!param3 = $94
!multiplicand = $011A ;8b, they could use scratch memory, weird
!multiplier = $011B ;8b
!dividend = $7E
!divisor = $80
!dision_rest = $7E

!NMI_Status = $00 ;8bit Its used to keeo track if an NMI happens or not.
;NMI reads the value other than 0 to know if it needs to update graphics,
;And sets it as 1 after it finish. NMI Loops waits for it to change to 1.
!tilemap_pointer = $18
!tilemap_to_load = $22 ;8b more data on Maps_Graphics_Table.asm
!copyof_INIDISP = $24 ;8bit Copy of the value in the Screen Display Register

!game_state = $D2 ;16b
;w??? ???? - w:walking to transition
;d??? s?hm - d: carrying dog m: Can Move; h: holding item; s: no stamina; x:

!fade_current_brightness = $25
!fade_current_frame = $26

!current_graphic_preset = $0195

;Internal RNG numbers, used to get a gemerate a mew RNG, but not to be used themself
!RNG_mem_1 = $0100 ;all 8b
!RNG_mem_2 = $0101
!RNG_mem_3 = $0102

;Map Data
!current_map_array = $09B6 ;4096 * 8b
!farm_map_array = $7EA4E6 ;4096 * 8b
!current_map_vram_array = $7E2000 ; * 16b
;01:empty, 02:empty, 03:grass, 04:stone, 05:fence, 06:broken fence, 07:tiled soil, 08:watered soil
;1D:grass seed, 1E: Seed 1, 1F: Seed 1 Watered; 1E: Seed 2

;Joypad Registers, all 16b
!Joy1_Key_Pressed_Timer = $23
!Joy1_Current = $0124          ;Keys current
!Joy1_Last_Frame = $0126       ;Keys last frame
!Joy1_New_Input = $0128        ;Keeps track of new buttons pressed
!Joy1_New_Unpressed = $012A
!Joy1_Autorepeat = $012C       ;Used in menus to avoid too many inputs when hold
!Joy1_Unused = $012E           ;Unused
;All joy2 is unused
!Joy2_Current = $0130
!Joy2_Last_Frame = $0132
!Joy2_New_Input = $0134
!Joy2_Unused2 = $0136
!Joy2_Autorepeat = $0138
!Joy2_Unused = $013A
;
!inputstate = $019A

;BGs Offsets, 16b
!BG1_Map_Offset_X = $013C
!BG1_Map_Offset_Y = $013E
!BG2_Map_Offset_X = $0140
!BG2_Map_Offset_Y = $0142
!BG3_Map_Offset_X = $0144
!BG3_Map_Offset_Y = $0146
!BG_subpixel_offset_X = $20 ;8b
!BG_subpixel_offset_Y = $21 ;8b
;These are the High bits of the offsets, only used during the NMI Update,
;as the BGXYOFS registers are 8bit write twice.
!BG1_Map_Offset_XH = $013D
!BG1_Map_Offset_YH = $013F
!BG2_Map_Offset_XH = $0141
!BG2_Map_Offset_YH = $0143
!BG3_Map_Offset_XH = $0145
!BG3_Map_Offset_YH = $0147

;Palettes data
!palette_change_pointer = $04 ;24b
!palette_change_countdow = $017A ;8b
!palette_to_load = $017B ;8b
!next_hourly_palette = $017C ;8b

;OBJ data
!OBJ_clamp_left = $ED ;16b
!OBJ_clamp_up = $EF ;16b
!OBJ_clamp_right = $F1 ;16b
!OBJ_clamp_down = $F3 ;16b
!OBJ_Offset_X = $F5 ;16b
!OBJ_Offset_Y = $F7 ;16b

;;Graphic Presets vars, for some reason, some are stored using the slower $80s memory remap,
;;maybe for identifability in the code? They are never read, only set in the slowest way
;;posible, only to be forgotten into oblivion. All 8b, maybe, dont care to confirm.
!graphic_preset = $8019B6
!OBSEL_preset = $8019B7
!BGMODE_preset = $8019B8
!BG1SC_preset = $8019BA
!BG2SC_preset = $8019BB
!BG3SC_preset = $8019BC
!BG4SC_preset = $8019BD
!BG12NBA_preset = $8019BE
!BG34NBA_preset = $8019BF
!M7SEL_preset = $8019D0
!W12SEL_preset = $8019D1
!W34SEL_preset = $8019D2
!WOBJSEL_preset = $8019D3
!WH0_preset = $8019D4
!WH1_preset = $8019D5
!WH2_preset = $8019D6
!WH3_preset = $8019D7
!WBGLOG_preset = $8019D8
!WOBJLOG_preset = $8019D9
!TM_preset = $8019DA
!TS_preset = $8019DB
!TMW_preset = $8019DC
!TSW_preset = $8019DD
!CGWSEL_preset = $8019DE
!CGADSUB_preset = $8019DF
!COLDATA_preset = $8019E0
!SETINI_preset = $8019E1
!BG1SC_noflip_preset = $8019E3
!BG2SC_noflip_preset = $8019E5
!BG3SC_noflip_preset = $8019E7
!BG4SC_noflip_preset = $8019E9
!graphic_preset_unknown = $8019EA
!graphic_preset_unused01 = $19E2
!graphic_preset_unused02 = $19E4
!graphic_preset_unused03 = $19E6
!graphic_preset_unused04 = $19E8
!graphic_preset_unused05 = $8019C0
!graphic_preset_unused06 = $8019C2
!graphic_preset_unused07 = $8019C4
!graphic_preset_unused08 = $8019C6
!graphic_preset_unused09 = $8019C8
!graphic_preset_unused10 = $8019CA
!graphic_preset_unused11 = $8019CC
!graphic_preset_unused12 = $8019CE


;;; Programmed DMA
;This variables control a table of changes to do to VRAM or CGRAM.
;The destination register of the channel is set directly on the channel's BBADX
!ProgDMA_Channel_Index = $27 ;8b, index of what channel is free next
!ProgDMA_Channel_Flag_to_Copy = $28 ;8bit each bit is a flag for a DMA Channel
!ProgDMA_Destination_Memory = $29 ;8bit
!ProgDMA_Control_Register_Table = $2A ;8bit up to 31, the 8 channels
!ProgDMA_Destination_Addr_Table = $32 ;16bit up to 41

;$7E009A - DMA ready but only for Channel 5? its only set in one place directly

;; Auto Map Scrolling
!map_scrolling_X_speed = $087C
!map_scrolling_Y_speed = $087E
!map_scrolling_timer = $0880

;;Screen Transitions
!transition_dest = $098B ;8b #$15: House
!transition_dest_X = $017D ;16b
!transition_dest_Y = $017F ;16b

;;Menus
!temp_name_1 = $0885 ;8b
!temp_name_2 = $0886 ;8b
!temp_name_3 = $0887 ;8b
!temp_name_4 = $0888 ;8b
!name_entry_index = $0994
!menu_pos = $0991

;;Player Data
!player_name_sort_1 = $0881 ;8b
!player_name_sort_2 = $0882 ;8b
!player_name_sort_3 = $0883 ;8b
!player_name_sort_4 = $0884 ;8b
!player_name_long_1 = $08D5 ;16b
!player_name_long_2 = $08D7 ;16b
!player_name_long_3 = $08D9 ;16b
!player_name_long_4 = $08DB ;16b
!most_hearts_girl_name_1 = $08A1 ;16b
!most_hearts_girl_name_2 = $08A3 ;16b
!most_hearts_girl_name_3 = $08A5 ;16b
!most_hearts_girl_name_4 = $08A7 ;16b
!most_hearts_girl_name_5 = $08A9 ;16b
!player_direction = $DA ;16
;0:down,1:up, 2:left 3:right
!player_pos_X = $D6 ;16b
!player_pos_Y = $D8 ;16b
!tile_in_front_X = $0985
!tile_in_front_Y = $0987
!max_stamina = $0917 ;8b
!current_stamina = $0918 ;8b
!what_to_eat = $0924 ;8b
;0: Onigiri 1: Croisant 2: Dumpling
!idle_animation_timer = $0925 ;8b
!item_on_hand = $091D ;8b
;at the end of TODO, need to find a place for Items
!tool_selected = $0921 ;8b
;00:nothing, 01:sickle, 02:hoe, 03:hammer, 04:axe, 05:yellow seed, 06:red seed, 07:brown seed, 08:white seed, 09:cow medicine, 0A:miracle potion, 0B:bell, 0C:grass seed, 0D:paint, 0E:milker, 0F:brush, 10:watering, 11:gold sickle, 12:gold hoe, 13:gold hammer, 14:gold axe, 15:sprinkler, 16:bean, 17:gem, 18:blue feather, 19:chicken feed, 1A:cow feed
!tool_used_sound = $0922 ;8b
!tool_backpack = $0923 ;8b
!happiness = $7F1F33 ;16b
!power_berry_N = $7F1F36 ;8b
!player_action = $D4 ;16b TODO
;1 walk, 2 run, 3 jump, 4 item on hand, 05 Drop Item 09 idle, 0A Using Tool, 0B Tired, 0C Show Tool, 0D whistle Horse, 0F about to cast, 10 casting, 11 fishing, 12 fishing with bite, 13 reeling, 14 drunk, 15 drinking, 16, Dropping Dog 1B Whistle Dog, 1C Use Tool
!exaustion_level = $096C

;;Family
!hearts_maria = $7F1F1F ;16b
!hearts_ann = $7F1F21 ;16b
!hearts_nina = $7F1F23 ;16b
!hearts_ellen = $7F1F25 ;16b
!hearts_eve = $7F1F27 ;16b
!kid1_age = $7F1F37
!kid1_name_sort_1 = $7F1F3D ;8b
!kid1_name_sort_2 = $7F1F3E ;8b
!kid1_name_sort_3 = $7F1F3F ;8b
!kid1_name_sort_4 = $7F1F40 ;8b
!kid2_age = $7F1F39
!kid2_name_sort_1 = $7F1F41 ;8b
!kid2_name_sort_2 = $7F1F42 ;8b
!kid2_name_sort_3 = $7F1F43 ;8b
!kid2_name_sort_4 = $7F1F44 ;8b
!wife_pregnancy = $7F1F3B ;16b
!kid1_name_long_1 = $08ED
!kid1_name_long_2 = $08EF
!kid1_name_long_3 = $08F1
!kid1_name_long_4 = $08F3
!kid2_name_long_1 = $08F5
!kid2_name_long_2 = $08F7
!kid2_name_long_3 = $08F9
!kid2_name_long_4 = $08FB

;;Time Data
!time_running = $0973 ;16b 0:stop, 1:run, 2:skip to next day
!year = $7F1F18 ;8b
!season = $7F1F19 ;8b
!weekday = $7F1F1A ;8b
!day = $7F1F1B ;8b
!hour = $7F1F1C ;8b military time in hex
!minutes = $7F1F1D ;8b
!seconds = $7F1F1E ;8b
!season_name = $08B3 ;16 * 6
!weekday_name = $08BF ;16 * 9
!day_ordinal = $08D1 ;16 * 2

;;ITEMDATA
!watering_can_water = $0926 ;8b
!seeds_grass_N = $0927 ;8b
!seeds_corn_N = $0928 ;8b
!seeds_tomato_N = $0929 ;8b
!seeds_potato_N = $092A ;8b
!seeds_turnip_N = $092B ;8b
!feed_cow_N = $092C ;8b
!feed_chicks_N = $092D ;8b

;;FARM DATA
!fed_cows_N = $0930 ;8b
!fed_chicks_N = $0931 ;8b
!fed_cows_flags = $0932 ;16b what stalls have food
!fed_chicks_flags = $0934 ;16b what stalls have food
!shipping_moneyL = $7F1F07 ;24bit value with $7F1F09
!shipping_moneyH = $7F1F09
!cow_N = $7F1F0A ;8b
!chicks_N = $7F1F0B ;8b
!stored_wood = $7F1F0C ;16b
!wood_need_for_upgrade = $7F1F0E ;16b
!stored_grass = $7F1F10 ;16b
!planted_grass = $7F1F29 ;16b
!weather_tomorrow = $098C ;8b
;00:Sunny, 01:Rain, 02 Snow, 03:hurricane, 04:fair, 05:sunny and calm, 06:flower festival, 07:harvest festival, 08:Thanksgiving Festival, 09:Star Night Festival, 0A:festive mood, 0B:annual egg festival, 0C:snow
!development_rate = $7F1F35
;Also used too keep track of house upgrade days
!dog_map = $7F1F30 ;8b
!dog_pos_X = $7F1F2C ;16b
!dog_pos_Y = $7F1F2E ;16b
!dog_hugs = $7F1F52 ;16b
!dog_name_short_1 = $0899 ;8b
!dog_name_short_2 = $089A ;8b
!dog_name_short_3 = $089B ;8b
!dog_name_short_4 = $089C ;8b
!dog_name_long_1 = $08DD ;16b
!dog_name_long_2 = $08DF ;16b
!dog_name_long_3 = $08E1 ;16b
!dog_name_long_4 = $08E3 ;16b
!horse_name_short_1 = $089D ;8b
!horse_name_short_2 = $089E ;8b
!horse_name_short_3 = $089F ;8b
!horse_name_short_4 = $08A0 ;8b
!more_liked_girl_name_1 = $08A1 ;16b
!more_liked_girl_name_1 = $08A3 ;16b
!more_liked_girl_name_1 = $08A5 ;16b
!more_liked_girl_name_1 = $08A7 ;16b
!more_liked_girl_name_1 = $08A9 ;16b
!horse_name_long_1 = $08E5 ;16b
!horse_name_long_2 = $08E7 ;16b
!horse_name_long_3 = $08E9 ;16b
!horse_name_long_4 = $08EB ;16b
!shipped_corn = $7F1F4A  ;16b
!shipped_tomatoes = $7F1F4C ;16b
!shipped_turnips = $7F1F4E ;16b
!shipped_potatoes = $7F1F50 ;16b
!ranch_mastery = $7F1F54 ;16b
!ranch_development = $7F1F56 ;16b
!moneyL = $7F1F04 ;16b Money is actually x10, the last 0 is fake
!moneyH = $7F1F06 ;8b
!shed_items_row_1 = $7F1F00 ;8b tomc ahps
; t turnip seeds bag
; o = potato seeds bag
; m = tomato seeds bag
; c = corn seeds bag
; a = axe
; h = hammer
; p = plow
; s = sickle
!shed_items_row_2 = $7F1F01 ;8b wrip gbmc
; w = watering can
; r = brush
; i = milker
; p = paint
; g = grass seeds bag
; b = bell
; m = miracle Potion
; c = cow Medicine
!shed_items_row_3 = $7F1F02 ;8b fdbr ahps
; f = blue feather
; d = blue diamond
; b = beanstalk
; r = sprinkler
; a = gold axe
; h = gold hammer
; p = gold plow
; s = gold sikle
!shed_items_row_4 = $7F1F03 ;b ? TODO

;;COW DATA
!cow_array = $7EC1C6
;cow data structure
; x6	- Cow 1 Status; -psc aaae
;   p=pregnant,s=sick,c=cranky,a=age(001=baby,010=child,100=adult),e=exists
; x7 - (1? 0?)
; x8 - Map
; x9 - Cow 1 Pregnancy/Age/Crankyness/Sickness
; xA - Cow 1 Happiness
; xB -
; xE - Position X ;16b
; x0 - Position Y ;16b
; x2 - Name 1
; x3 - Name 2
; x4 - Name 3
; x5 - Name 4

;$7EC1C6	- Cow 01
;$7EC1D6	- Cow 02
;$7EC1E6	- Cow 03
;$7EC1F6	- Cow 04
;$7EC206	- Cow 05
;$7EC216	- Cow 06
;$7EC226	- Cow 07
;$7EC236	- Cow 08
;$7EC246	- Cow 09
;$7EC256	- Cow 10
;$7EC266	- Cow 11
;$7EC276	- Cow 12

;;Chicken data
!chicken_array = $7EC286
; x6/xE	- Status? starts as #$43(0100 0011)/#$09(0000 1001)
; ?1?? aaax - a=age(001=egg,010=child,100=adult),e=exists
; x7/xF - Map
; x8/x0 - #0
; x9/x1 -
; xA/x2 - Position X ;16b
; xC/x4 - Position Y ;16b

;$7EC286 - Chicken 01
;$7EC28E - Chicken 02
;$7EC296 - Chicken 03
;$7EC29E - Chicken 04
;$7EC2A6 - Chicken 05
;$7EC2AE - Chicken 06
;$7EC2B6 - Chicken 07
;$7EC2BE - Chicken 08
;$7EC2C6 - Chicken 09
;$7EC2CE - Chicken 10
;$7EC2E6 - Chicken 11
;$7EC2EE - Chicken 12
