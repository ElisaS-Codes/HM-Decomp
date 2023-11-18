;;; Some predefined values for some common values for registers, to make
;code easier to read, not having to remember all of this things.

;;Register Sizes, some stats for fun
macro Set16bit(reg)
    REP <reg>
endmacro

macro Set8bit(reg)
    SEP <reg>
endmacro

!MX = #$30 ;2466 Resets,   11 Sets
!M = #$20  ;1626 Resets, 3010 Sets
!X = #$10  ; 692 Resets,   96 Sets

;;INIDISP
!INIDISP_FORCE_BLANK = #$80

;;NMITIMEN
!NMITIMEN_ENABLE_NMI_NO_JOY = #$80
!NMITIMEN_ENABLE_NMI_AND_JOY = #$A1

;;VMAIN
!VMAIN_16BIT_MODE = #$80

;;MDMAEN
!MDMAEN_Enable_Channel_1 = #$01

;;DMAPX
!DMAPX_8BIT_FIXED_SOURCE = #$08
!DMAPX_16BIT_FIXED_SOURCE = #$09
!DMAPX_16BIT = #$01
!BBADX_DMA_CGRAMPORT = #$22
!BBADX_DMA_VRAMPORT = #$18
!BBADX_DMA_OAMPORT = #$04

;;HVBJOY
!HVBJOY_Joy_Ready = #$01

;;SRAM Check
!ASCII_F = #$46
!ASCII_A = #$41
!ASCII_R = #$52
!ASCII_M = #$4D

!CHAR_EMPTY = #$B1

;;Joy Keys flags
!key_Down = #$0400
!key_Up = #$0800
!key_Left = #$0100
!key_Right = #$0200
!key_B = #$8000
!key_A = #$0080
!key_X = #$0040
!key_Y = #$4000
!key_R = #$0010
!key_L = #$0020
!key_Select = #$2000
!key_Start = #$1000

;;Items
!item_egg = #$14

;;Maps
!map_farm_winter = #04
!map_mountain_spring = #$10
!map_house_1 = #$15
!map_barn = #$27
!map_coop = #$28
!NATSUME_LOGO = #$5D