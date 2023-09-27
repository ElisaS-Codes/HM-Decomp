ORG $808000

;;;;;;;; Run right after RESET
     UNK_RealMainLoop:  ;808000
        %Set16bit(!MX)
        %Set8bit(!M)
        LDA.B #$15                           
        STA.B !tilemap_to_load                            
        JSL.L UNK_Audio5                     
        JSL.L UNK_Audio25                    
        %Set8bit(!M)                         
        LDA.B #15
        STA.B !param1                        
        LDA.B #03                           
        STA.B !param2                        
        LDA.B #01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        JSL.L NightReset                     
        JSL.L UNK_Audio5                     
        %Set16bit(!M)                        
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        %Set16bit(!MX)                       
        LDA.W #$0088                         
        STA.W !transition_dest_X             
        LDA.W #$0078                         
        STA.W !transition_dest_Y             
        %Set8bit(!M)                         
        LDA.B !map_house_1                     
        STA.W !transition_dest               
        JSL.L FindMostLovedandFillVariables  
        JSL.L UNK_ScreenTransition           
        %Set16bit(!M)                       
        LDA.L $7F1F68                       
        AND.W #$0001                        ;if climate is set tomorrow? festival?
        BEQ fromNightEvents                 
        %Set8bit(!M)                        
        LDA.B #$03                          
        JSL.L RNGReturn0toA                 
        %Set8bit(!M)                        
        STA.W $0924                         
        %Set16bit(!MX)                      
        LDA.B $D2                           
        ORA.W #$0004                        
        STA.B $D2                           

;;;;;;;;
fromNightEvents: ;808083
        %Set8bit(!M)                         
        LDA.B !NMI_Status                    
        BEQ fromNightEvents                  

        %Set16bit(!M)                        
        LDA.W #$1800                         
        STA.B $C7                            
        LDA.W $0196                          
        AND.W #$2000                         
        BEQ .skip1                           
        JMP.W .skip2                         

    .skip1:
        JSL.L UNK_PrepareScreenTransition    
        JSL.L A4444                          
        JSL.L UpdateTime                     
        JSL.L ADDDDFFFF                      
        JSL.L Unk_MemoryWork7E0D00           
        JSL.L UNK_BigLoop                    
        JSL.L InputTypeSelector                          
        JSL.L BAAAA                          
        JSL.L BEEEE                          
        JSL.L AutoMapScrolling               
        JSL.L CODE_84816F                    
        JSL.L CODE_81A600                    
        JSL.L CODE_8582C7                    
        JSL.L CODE_858CB2                    
        JSL.L UNK_BigLoadLoopOAM             
        %Set8bit(!M)                         
        STZ.B !NMI_Status                    
        JMP.W fromNightEvents                


    .skip2:
        %Set16bit(!MX)                       
        LDA.W $0196                          
        AND.W #$DFFF                         
        STA.W $0196                          
        JML.L CODE_82E80C                    

;;;;;;;;
SetPlayerName:
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.W !temp_name_1                   
        STA.W !player_name_sort_1                 
        %Set16bit(!M)                        
        STA.W !player_name_long_1            
        %Set8bit(!M)                         
        LDA.W !temp_name_2                   
        STA.W !player_name_sort_2                 
        %Set16bit(!M)                        
        STA.W !player_name_long_2            
        %Set8bit(!M)                         
        LDA.W !temp_name_3                   
        STA.W !player_name_sort_3                 
        %Set16bit(!M)                        
        STA.W !player_name_long_3            
        %Set8bit(!M)                         
        LDA.W !temp_name_4                   
        STA.W !player_name_sort_4                 
        %Set16bit(!M)                        
        STA.W !player_name_long_4            
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;;
SetCowName:
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set16bit(!M)                        
        LDA.W #$0000                         
        JSL.L AddNewCow                      
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDY.W #$000C                         
        LDA.W !temp_name_1                   
        STA.B [$72],Y                        
        LDY.W #$000D                         
        LDA.W !temp_name_2                   
        STA.B [$72],Y                        
        LDY.W #$000E                         
        LDA.W !temp_name_3                   
        STA.B [$72],Y                        
        LDY.W #$000F                         
        LDA.W !temp_name_4                   
        STA.B [$72],Y                        
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.L $7F1F5A                        
        AND.W #$FFFD                         
        STA.L $7F1F5A                        
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;;
SetCowName2: ;8081D2
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set16bit(!M)                        
        LDA.W #$0001                         
        JSL.L AddNewCow                      
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDY.W #$000C                         
        LDA.W !temp_name_1                   
        STA.B [$72],Y                        
        LDY.W #$000D                         
        LDA.W !temp_name_2                   
        STA.B [$72],Y                        
        LDY.W #$000E                         
        LDA.W !temp_name_3                   
        STA.B [$72],Y                        
        LDY.W #$000F                         
        LDA.W !temp_name_4                   
        STA.B [$72],Y                        
        %Set16bit(!M)                        
        LDA.L $7F1F64                        
        AND.W #$FFFB                         
        STA.L $7F1F64                        
        %Set16bit(!M)                        
        LDA.L $7F1F64                        
        AND.W #$FFF7                         
        STA.L $7F1F64                        
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;;
SetDogName: ;808254
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.W !temp_name_1                   
        STA.W !dog_name_short_1                    
        %Set16bit(!M)                        
        STA.W !dog_name_long_1               
        %Set8bit(!M)                         
        LDA.W !temp_name_2                   
        STA.W !dog_name_short_2                    
        %Set16bit(!M)                        
        STA.W !dog_name_long_2               
        %Set8bit(!M)                         
        LDA.W !temp_name_3                   
        STA.W !dog_name_short_3                    
        %Set16bit(!M)                        
        STA.W !dog_name_long_3               
        %Set8bit(!M)                         
        LDA.W !temp_name_4                   
        STA.W !dog_name_short_4                    
        %Set16bit(!M)                        
        STA.W !dog_name_long_4               
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;;
SetHorseName: ;8082C6
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.W !temp_name_1                   
        STA.W !horse_name_short_1                  
        %Set16bit(!M)                        
        STA.W !horse_name_long_1             
        %Set8bit(!M)                         
        LDA.W !temp_name_2                   
        STA.W !horse_name_short_2                  
        %Set16bit(!M)                        
        STA.W !horse_name_long_2             
        %Set8bit(!M)                         
        LDA.W !temp_name_3                   
        STA.W !horse_name_short_3                  
        %Set16bit(!M)                        
        STA.W !horse_name_long_3             
        %Set8bit(!M)                         
        LDA.W !temp_name_4                   
        STA.W !horse_name_short_4                  
        %Set16bit(!M)                        
        STA.W !horse_name_long_4             
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;;
SetKid1Name: ;808338
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.W !temp_name_1                   
        STA.L !kid1_name_sort_1                   
        %Set16bit(!M)                        
        STA.W !kid1_name_long_1            
        %Set8bit(!M)                         
        LDA.W !temp_name_2                   
        STA.L !kid1_name_sort_2                   
        %Set16bit(!M)                        
        STA.W !kid1_name_long_2            
        %Set8bit(!M)                         
        LDA.W !temp_name_3                   
        STA.L !kid1_name_sort_3                   
        %Set16bit(!M)                        
        STA.W !kid1_name_long_3            
        %Set8bit(!M)                         
        LDA.W !temp_name_4                   
        STA.L !kid1_name_sort_4                   
        %Set16bit(!M)                        
        STA.W !kid1_name_long_4            
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;;
SetKid2Name: ;8083AE
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     
        JSL.L ZeroesVRAM                     
        JSL.L ZeroesCGRAM                    
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.W !temp_name_1                   
        STA.L !kid2_name_sort_1                   
        %Set16bit(!M)                        
        STA.W !kid2_name_long_1            
        %Set8bit(!M)                         
        LDA.W !temp_name_2                   
        STA.L !kid2_name_sort_2                   
        %Set16bit(!M)                        
        STA.W !kid2_name_long_2            
        %Set8bit(!M)                         
        LDA.W !temp_name_3                   
        STA.L !kid2_name_sort_3                   
        %Set16bit(!M)                        
        STA.W !kid2_name_long_3            
        %Set8bit(!M)                         
        LDA.W !temp_name_4                   
        STA.L !kid2_name_sort_4                   
        %Set16bit(!M)                        
        STA.W !kid2_name_long_4            
        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$4000                         
        STA.W $0196                          
        LDA.W #$0100                         
        STA.W !BG3_Map_Offset_Y              
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !inputstate                          
        JMP.W fromNightEvents                

;;;;;;;; These values are used during the VRAM and OBJRAM Initializers.
Value_0000: dw $0000 ;808424
Value_00F0: dw $00F0 ;808426

;;;;;;;; Reset IRQ location, beguining of the program, basically
;;;;;;;; Sets all hardware registers and blanks some WRAM locations
RESET:   ;808428
        SEI                                  ;Disable IRQ Interrupt
        CLC                                     
        XCE                                  ;Disable Emulation Mode
        %Set16bit(!MX)
        LDX.W #$1F00
        TXS                                  ;Initialize Stack to $1F00
        LDA.W #$0000
        TCD                                  ;Set Page Register to $00

        ;Setting every hardware register to 0 with a few exceptions
        %Set8bit(!MX)
        STZ.W !NMITIMEN
        STZ.W !MDMAEN
        STZ.W !HDMAEN
        LDA.B #$FF
        STA.W !WRIO                          ;not sure why it sets FF here
        STZ.W !WRMPYA
        STZ.W !WRMPYB                          
        STZ.W !WRDIVL
        STZ.W !WRDIVH                             
        STZ.W !WRDIVB
        STZ.W !HTIMEL
        STZ.W !HTIMEH                          
        STZ.W !VTIMEL
        STZ.W !VTIMEH                             
        STZ.W !MDMAEN
        STZ.W !HDMAEN
        LDA.B #$01                           ;FastRom
        STA.W !MEMSEL
        STZ.W !RDNMI
        STZ.W !TIMEUP
        STZ.W !HVBJOY
        STZ.W !RDIO
        STZ.W !RDDIVL
        STZ.W !RDDIVH
        STZ.W !RDMPYL
        STZ.W !RDMPYH
        STZ.W !JOY1L
        STZ.W !JOY1H
        STZ.W !JOY2L
        STZ.W !JOY2H
        STZ.W !JOY3L
        STZ.W !JOY3H
        STZ.W !JOY4L
        STZ.W !JOY4H
        STZ.W !INIDISP
        STZ.W !OBSEL
        STZ.W !OAMADDL
        STZ.W !OAMADDH
        STZ.W !OAMDATA
        STZ.W !OAMDATA
        STZ.W !BGMODE
        STZ.W !MOSAIC
        STZ.W !BG1SC
        STZ.W !BG2SC
        STZ.W !BG3SC
        STZ.W !BG4SC
        STZ.W !BG12NBA
        STZ.W !BG34NBA
        STZ.W !BG1HOFS
        STZ.W !BG1HOFS
        STZ.W !BG1VOFS
        STZ.W !BG1VOFS
        STZ.W !BG2HOFS
        STZ.W !BG2HOFS
        STZ.W !BG2VOFS
        STZ.W !BG2VOFS
        STZ.W !BG3HOFS
        STZ.W !BG3HOFS
        STZ.W !BG3VOFS
        STZ.W !BG3VOFS
        STZ.W !BG4HOFS
        STZ.W !BG4HOFS
        STZ.W !BG4VOFS
        STZ.W !BG4VOFS
        LDA.B #$80
        STA.W !VMAIN                         ;Increment by 1 after writing 16 bits
        STZ.W !VMADDL
        STZ.W !VMADDH
        STZ.W !VMDATAL
        STZ.W !VMDATAH
        STZ.W !M7SEL                         ;Thank Gog we dont use Mode7, sounds hard
        STZ.W !M7A
        STZ.W !M7A
        STZ.W !M7B
        STZ.W !M7B
        STZ.W !M7C
        STZ.W !M7C
        STZ.W !M7D
        STZ.W !M7D
        STZ.W !M7X
        STZ.W !M7X
        STZ.W !M7Y
        STZ.W !M7Y
        STZ.W !CGADD
        STZ.W !CGDATA
        STZ.W !CGDATA
        STZ.W !W12SEL
        STZ.W !W34SEL
        STZ.W !WOBJSEL
        STZ.W !WH0
        STZ.W !WH1
        STZ.W !WH2
        STZ.W !WH3
        STZ.W !WBGLOG
        STZ.W !WOBJLOG
        STZ.W !TM
        STZ.W !TS
        STZ.W !TMW
        STZ.W !TSW
        LDA.B #$30                           
        STA.W !CGWSEL                        ;Prevent color math = Always
        STZ.W !CGADSUB
        LDA.B #$E0                           
        STA.W !COLDATA                       ;Substract half of backdrops
        STZ.W !SETINI
        STZ.W !MPYL
        STZ.W !MPYM
        STZ.W !MPYH
        STZ.W !SLHV
        STZ.W !OAMDATAREAD
        STZ.W !VMDATALREAD
        STZ.W !VMDATAHREAD
        STZ.W !CGDATAREAD
        STZ.W !CGDATAREAD
        STZ.W !OPHCT
        STZ.W !OPVCT
        STZ.W !STAT77
        STZ.W !STAT78
        STZ.W !WMDATA
        STZ.W !WMADDL
        STZ.W !WMADDM
        STZ.W !WMADDH

        ;Zeroes low WRAM
        %Set16bit(!MX)
        LDX.W #$0000
        LDA.W #$0000
      - STA.W $0000,X                        
        INX                                  
        INX                                  
        CPX.W #$2000                         
        BNE -                                

        ;Zeroes rest of bank $7E
        %Set16bit(!MX)
        LDX.W #$0000                         
        LDA.W #$0000                         
      - STA.L $7E2000,X                      
        INX                                  
        INX                                  
        CPX.W #$E000                         
        BNE -                           

        ;Zeroes bank $7F0000
        %Set16bit(!MX)
        LDX.W #$0000                         
        LDA.W #$0000                         
      - STA.L $7F0000,X                      
        INX                                  
        INX                                  
        CPX.W #$0000                         
        BNE -                           

        ;Zeroes Joypad memory location? that was zeroed already...
        STZ.W !Joy1_Current
        STZ.W !Joy1_New_Input
        STZ.W !Joy1_Last_Frame
        STZ.W !Joy1_New_Unpressed
        STZ.W !Joy2_Current
        STZ.W !Joy2_New_Input
        STZ.W !Joy2_Last_Frame
        STZ.W !Joy2_Unused2

        ;Sets audio processor
        %Set16bit(!MX)                             
        LDA.W #$8000                         
        STA.B $0A
        LDA.W #$00AD                         
        STA.B $0C                            
        JSL.L UNK_Audio1                     
        %Set8bit(!M)                             
        LDA.B #$00                           
        JSL.L UNK_Audio2                     
        JSL.L UNK_Audio3                     
        JSL.L UNK_Audio4                     

        ; Initializes all graphical memories and registers
        JSL.L InitialzieScreenStatusVar      
        JSL.L ZeroesVRAM                      
        JSL.L ZeroesOAM                       
        JSL.L ZeroesCGRAM                     
        JSL.L ClearWRAMGraphicsSpace         ;TODO
        JSL.L InitializeOBJs                 ;TODO
        JSL.L CheckSRAMIntegrity             
        %Set8bit(!M)                             
        %Set16bit(!X)                             
        LDA.B !INIDISP_FORCE_BLANK                           
        STA.W !INIDISP                       
        STZ.W $0148                          ;TODO
        LDA.B !NMITIMEN_ENABLE_NMI_NO_JOY                           
        STA.W !NMITIMEN                      
        STZ.W !INIDISP                       
        CLI                                  

        JML.L IntroScreen                   


;;;;;;;;; Waits for the next NMI
WaitForNMI: ;808645
        PHP                                  
        %Set16bit(!M)                             
        PHA                                  
        %Set8bit(!M)                             
        LDA.B !NMITIMEN_ENABLE_NMI_AND_JOY
        STA.L !NMITIMEN24                    ;Interrupt Enable Register 24bit Address
        CLI                                  ;Clear Interrupt Flag
        STZ.B !NMI_Status

      - LDA.B !NMI_Status                    ;Infinite loop till an NMI changes the value
        BEQ -
        %Set16bit(!M)                             
        PLA                                  
        PLP                                  
        RTL                                  


;;;;;;;;; Waits for a number of NMIs
;;;;;;;;; Params: A = Number of "frames"
WaitForNMIATimes: ;80865D
        PHP                                  
     -- %Set16bit(!M)                             
        PHA                                  
        %Set8bit(!M)                             
        LDA.B !NMITIMEN_ENABLE_NMI_AND_JOY
        STA.L !NMITIMEN24                    ;Interrupt Enable Register 24bit Address
        CLI                                  ;Clear Interrupt Flag
        STZ.B !NMI_Status

      - LDA.B !NMI_Status                    ;Infinite loop till an NMI changes the value
        BEQ -                            
        %Set16bit(!M)                             
        PLA                                  
        DEC A                                
        CMP.W #$0000                         
        BNE --                               ;Loops back till A is 0
        PLP                                  
        RTL                                  


;;;;;;;; Nothing much happens here, just calls the UpdateGraphics subrutine
NMI_Interrupt: ;80867B
        %Set16bit(!MX)                             
        PHA                                  
        PHX                                  
        PHY                                  
        PHD                                  
        PHB                                  
        %Set8bit(!M)                             
        LDA.B #$00                           
        XBA                                  
        LDA.B !NMITIMEN_ENABLE_NMI_AND_JOY
        STA.L !NMITIMEN24                    
        CLI                                  ;Enable Interrupts
        JSR.W UpdateGraphics                 
        %Set16bit(!MX)                             
        PLB                                  
        PLD                                  
        PLY                                  
        PLX                                  
        PLA                                  
        RTI                                  


;;;;;;;; This feels gutted, doesnt do enything, just continues execution
COP_Interrupt: ;808699
        %Set16bit(!MX)                             
        PHB                                  
        PHA                                  
        PHX                                  
        PHY                                  
        %Set8bit(!M)                             
        LDA.B #$00                           
        XBA                                  
        LDA.W !TIMEUP                        
        JSR.W COP_Return                     ;emtpy subrutine
        %Set16bit(!MX)                             
        PLY                                  
        PLX                                  
        PLA                                  
        PLB                                  
        RTI                                  


UpdateGraphics: ;8086B1
        PHP                                  
        %Set8bit(!M)                             
        LDA.B !NMI_Status                    

        BNE +                                ;skip if not expecting a programed DMA
        JSL.L StartProgramedDMA           
        %Set8bit(!M)                             
        LDA.B $9A                            ;DMA Channel 5 seems to be special, is set in Bank 85
        STA.W !MDMAEN
        STZ.B $9A                            
        STZ.W !MDMAEN
        JSL.L CopiesWRAMtoVGRAM              ;TODO
        STZ.B $9A                            
        STZ.W !MDMAEN

      + JSR.W ReadJoypad                     
        JSL.L GetRNG                         

    ;Update Offsets
        %Set8bit(!M)                             
        LDA.W !BG1_Map_Offset_X              
        STA.W !BG1HOFS                       
        LDA.W !BG1_Map_Offset_XH             
        STA.W !BG1HOFS                       
        LDA.W !BG1_Map_Offset_Y              
        STA.W !BG1VOFS                       
        LDA.W !BG1_Map_Offset_YH             
        STA.W !BG1VOFS                       
        LDA.W !BG2_Map_Offset_X              
        STA.W !BG2HOFS                       
        LDA.W !BG2_Map_Offset_XH             
        STA.W !BG2HOFS                       
        LDA.W !BG2_Map_Offset_Y              
        STA.W !BG2VOFS                       
        LDA.W !BG2_Map_Offset_YH             
        STA.W !BG2VOFS                       
        LDA.W !BG3_Map_Offset_X              
        STA.W !BG3HOFS                       
        LDA.W !BG3_Map_Offset_XH             
        STA.W !BG3HOFS                       
        LDA.W !BG3_Map_Offset_Y              
        STA.W !BG3VOFS                       
        LDA.W !BG3_Map_Offset_YH             
        STA.W !BG3VOFS                       
        %Set8bit(!M)                             
        LDA.B #$01                           
        STA.B !NMI_Status                    ;Update done
        PLP                                  
        RTS                                  


;;;;;;;;; Seems to be an gutted BSOD or debugging menu
COP_Return: ;80872A
        RTS

;;;;;;;; Read joypad, not too much to say, except that its obviously taken
;;;;;;;; from another project/framwork/code example, as it has a ton of unused vars
;;;;;;;; This thing could be 1/3rd its size and operational cost
ReadJoypad: ;80872B;
        PHP

    ;wait for Joypad register to be available
      - %Set8bit(!M)                             
        LDA.W !HVBJOY                        
        BIT.B !HVBJOY_Joy_Ready              
        BNE -                   
        
    ;Move old imput to last frame's memory location
        %Set16bit(!MX)                             
        LDA.W !Joy1_Current                          
        STA.W !Joy1_Last_Frame                          
        LDA.W !Joy2_Current                          
        STA.W !Joy2_Last_Frame                          
        %Set8bit(!M)                             

        LDA.B $00                            
        BEQ +                    
                                             
    ;Never run, would read only 8 bit and then use those values as a mask later?
        LDA.W !JOY1L                         
        STA.W !Joy1_Unused                          
        LDA.W !JOY2L                         
        STA.W !Joy2_Current                          
        BRA ++                        

    ;read Joypads
      + %Set16bit(!M)                        
        LDA.W !JOY1L                         
        ORA.W !Joy1_Unused                   ;always 0, so no changes
        STA.W !Joy1_Current                          
        LDA.W !JOY2L                         
        ORA.W !Joy2_Unused                   ;always 0, so no changes
        STA.W !Joy2_Current                          
        STZ.W !Joy1_Unused                   
        STZ.W !Joy2_Unused                   

    ;Get useful variables, some unused variables, and the whole Joy2 is not used
     ++ %Set16bit(!M)                        
        LDA.W !JOY1L                         
        EOR.W !Joy1_Last_Frame               
        AND.W !Joy1_Current                  
        STA.W !Joy1_New_Input                
        STA.W !Joy1_Autorepeat                          
        LDA.W !JOY1L                         
        EOR.W !Joy1_Last_Frame               
        AND.W !Joy1_Last_Frame               
        STA.W !Joy1_New_Unpressed                  
        LDA.W !JOY2L                         
        EOR.W !Joy2_Last_Frame               
        AND.W !Joy2_Current                  
        STA.W !Joy2_New_Input                
        STA.W !Joy2_Autorepeat               
        LDA.W !JOY1L                         
        EOR.W !Joy2_Last_Frame               
        AND.W !Joy2_Last_Frame               
        STA.W !Joy2_Unused2                  

    ;Key timer code, Keeps how long keys have been pressed, amd updates Autorepeat
        LDA.W !Joy1_Current                  
        BEQ +                                ;No key pressed
        INC.B !Joy1_Key_Pressed_Timer        
        BRA ++                               ;skip reset
      + STZ.B !Joy1_Key_Pressed_Timer        
     ++ %Set8bit(!M)                         

        LDA.B !Joy1_Key_Pressed_Timer        
        CMP.B #30                            ;Timer goes till 30
        BEQ +                                ;No need to reset
        BRA ++                               ;Go to end

      + %Set16bit(!M)                        
        LDA.W !Joy1_Current                  
        STA.W !Joy1_Autorepeat               ;Updates Autorepeat
        %Set8bit(!M)                         
        LDA.B #25                            ;resets back to 25
        STA.B !Joy1_Key_Pressed_Timer        

     ++ PLP                                  
        RTS                                  

;;;;;;;;; Makes the ScreenFadein effect
;;;;;;;;; Params: $92:Start Brightness $93:Frames per step $94:Target brightness
ScreenFadein: ;8087CE
        !start_brightness = $92
        !frames_per_step = $93
        !target_brightness = $94

        %Set8bit(!MX)                        
        LDA.B !start_brightness              ;This is probably a special case, I dont think its used
        CMP.B #$FF                           
        BEQ +

        LDA.B !start_brightness              
        STA.B !fade_current_brightness       

      + LDA.B !frames_per_step               
        STA.B !fade_current_frame            

    ;Loops till target Brightness is achived
     -- LDA.B !fade_current_brightness       
        JSL.L SetsBrightness                 
        LDA.B !fade_current_brightness       
        CMP.B !target_brightness             
        BEQ +                                ;Target Bright Achieved

        INC.B !fade_current_brightness       

    ;Loop till enough frames have passed
      - JSL.L WaitForNMI                     
        DEC.B !fade_current_frame            
        LDA.B !fade_current_frame            
        BNE -

        LDA.B !frames_per_step               
        STA.B !fade_current_frame            
        BRA --                               

      + %Set16bit(!M)                        
        LDA.L $7F1F5A                        ;Flags, related to time
        ORA.W #$8000                         
        STA.L $7F1F5A                        
        RTL                                  

;;;;;;;;; Makes the fadeout effect
;;;;;;;;; Params: $92:Start Brightness $93:Frames per step $94:Target brightness
ScreenFadeout: ;80880A
        !start_brightness = $92
        !frames_per_step = $93
        !target_brightness = $94

        %Set8bit(!MX)                        
        LDA.B !start_brightness              
        CMP.B #$FF                           ;This is probably a special case, I dont think its used
        BEQ +                                

        LDA.B !start_brightness              
        STA.B !fade_current_brightness       

      + LDA.B !frames_per_step                            
        STA.B !fade_current_frame            

    ;Loops till target Brightness is achived
     -- LDA.B !fade_current_brightness       
        JSL.L SetsBrightness                 
        LDA.B !fade_current_brightness       
        CMP.B !target_brightness             
        BEQ +                                ;Target Bright Achieved

        DEC.B !fade_current_brightness       

    ;Loop till enough frames have passed
      - JSL.L WaitForNMI                     
        DEC.B !fade_current_frame            
        LDA.B !fade_current_frame            
        BNE -

        LDA.B !frames_per_step               
        STA.B !fade_current_frame            
        BRA --                                

      + %Set16bit(!M)                        
        LDA.L $7F1F5A                        ;Flags, related to time
        AND.W #$7FFF                         
        STA.L $7F1F5A                        
        RTL                                  

;;;;;;;; Initializes the VRAM with 0s
ZeroesVRAM: ;808846
        %Set8bit(!M)
        %Set16bit(!X)
        LDA.B !INIDISP_FORCE_BLANK
        STA.W !INIDISP
        STZ.W !NMITIMEN                      ;Disable Interrupts
        LDA.B !VMAIN_16BIT_MODE              ;Sets up the DMA to VRAM
        STA.W !VMAIN
        %Set16bit(!M)
        STZ.W !VMADDL
        %Set8bit(!M)     
        LDA.B !DMAPX_16BIT_FIXED_SOURCE
        STA.W !DMAP0
        LDA.B !BBADX_DMA_VRAMPORT            
        STA.W !BBAD0                         
        %Set16bit(!M)                             
        LDA.W #$8424                         ;src -> $808424 = #$0000
        STA.W !A1T0L                         
        %Set8bit(!M)                             
        LDA.B #$80                           
        STA.W !A1B0                         
        %Set16bit(!M)                             
        LDA.W #$0000                         ;Size: A full page
        STA.W !DAS0L                         
        %Set8bit(!M)                             
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN
        RTL

;;;;;;;;Clears the OAM VRAM with 0s
ZeroesOAM: ;808887
        %Set8bit(!M)                             
        %Set16bit(!X)                             
        LDA.B !INIDISP_FORCE_BLANK
        STA.W !INIDISP                       
        STZ.W !NMITIMEN                      ;Disable Interrupts
        %Set16bit(!M)                             
        STZ.W !OAMADDL                       ;Sets up start of OAM
        %Set8bit(!M)                             
        LDA.B !DMAPX_16BIT_FIXED_SOURCE                           
        STA.W !DMAP0            
        LDA.B !BBADX_DMA_OAMPORT
        STA.W !BBAD0
        %Set16bit(!M)
        LDA.W #$8424                         ;src -> $808424 = #$0000
        STA.W !A1T0L                         
        %Set8bit(!M)                             
        LDA.B #$80                           
        STA.W !A1B0                          
        %Set16bit(!M)                             
        LDA.W #$043F                         ;size -> $043F = 1087 bytes
        STA.W !DAS0L                         
        %Set8bit(!M)                             
        LDA.B !MDMAEN_Enable_Channel_1
        STA.W !MDMAEN                 
        RTL                           

;;;;;;;; UNUSED, should prepare OAM, but never triggers
UNUSED1: ;8088C3
        %Set16bit(!MX)                       
        STZ.W !OAMADDL                       
        %Set8bit(!M)                         
        LDA.B !DMAPX_8BIT_FIXED_SOURCE                           
        STA.W !DMAP0                         
        LDA.B !BBADX_DMA_OAMPORT                           
        STA.W !BBAD0                         
        %Set16bit(!M)                        
        LDA.W #$8426                         ;src -> $808426, $00F0
        STA.W !A1T0L                         
        %Set8bit(!M)                         
        LDA.B #$80                           
        STA.W !A1B0                          
        %Set16bit(!M)                        
        LDA.W #$0200                         
        STA.W !DAS0L                         
        %Set8bit(!M)                         
        LDA.B !MDMAEN_Enable_Channel_1       
        STA.W !MDMAEN                        
        %Set16bit(!MX)                       
        LDA.W #$0100                         
        STA.W !OAMADDL                       
        %Set8bit(!M)                         
        LDA.B !DMAPX_8BIT_FIXED_SOURCE       
        STA.W !DMAP0                         
        LDA.B #$04                           
        STA.W !BBAD0                         
        %Set16bit(!M)                        
        LDA.W #$8424                         
        STA.W !A1T0L                         
        %Set8bit(!M)                         
        LDA.B #$80                           
        STA.W !A1B0                          
        %Set16bit(!M)                        
        LDA.W #$0020                         
        STA.W !DAS0L                         
        %Set8bit(!M)                         
        LDA.B #$01                           
        STA.W !MDMAEN                        
        %Set16bit(!M)                        
        STZ.W !OAMADDL                       
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDX.W #$0000                         
        STX.W !OAMADDL                       
        STZ.W $4340                          
        LDA.B #$04                           
        STA.W $4341                          
        LDA.B #$00                           
        STA.W $4342                          
        LDA.B #$A0                           
        STA.W $4343                          
        LDA.B #$7E                           
        STA.W $4344                          
        LDX.B $AF                            
        STX.W $4345                          
        LDA.B #$10                           
        STA.W !MDMAEN                        
        LDX.W #$0100                         
        STX.W !OAMADDL                       
        STZ.W $4340                          
        LDA.B #$04                           
        STA.W $4341                          
        LDA.B #$00                           
        STA.W $4342                          
        LDA.B #$A0                           
        CLC                                  
        ADC.B #$02                           
        STA.W $4343                          
        LDA.B #$7E                           
        STA.W $4344                          
        LDX.W #$0020                         
        STX.W $4345                          
        LDA.B #$10                           
        STA.W !MDMAEN                        
        RTL                                  

;;;;;;;;Clears the CGRAM VRAM with 0s
ZeroesCGRAM: ;808980
        %Set8bit(!M)                             
        %Set16bit(!X)                             
        LDA.B !NMITIMEN_ENABLE_NMI_NO_JOY                           
        STA.W !INIDISP                       
        STZ.W !NMITIMEN                      ;Disable Interrupts
        %Set16bit(!M)                            
        STZ.W !CGADD                         ;Sets start of CGRAM
        %Set8bit(!M)                             
        LDA.B !DMAPX_16BIT_FIXED_SOURCE
        STA.W !DMAP0              
        LDA.B !BBADX_DMA_CGRAMPORT
        STA.W !BBAD0                         
        %Set16bit(!M)                             
        LDA.W #$8424                         ;src -> $808424, $0000
        STA.W !A1T0L                         
        %Set8bit(!M)                             
        LDA.B #$80                           
        STA.W !A1B0                          
        %Set16bit(!M)                             
        LDA.W #$03FF                         ;size -> $03FF = 1023 bytes
        STA.W !DAS0L                         
        %Set8bit(!M)                             
        LDA.B !MDMAEN_Enable_Channel_1                           
        STA.W !MDMAEN                        
        RTL                                  

;;;;;;;; Clears a chunk of 0FFF of the VRAM. Param: A, the starting location
ZeroesPartialVRAM: ;8089BC
        %Set16bit(!MX)                               
        STA.W !VMADDL                        
        %Set8bit(!M)                         
        LDA.B !INIDISP_FORCE_BLANK                           
        STA.W !INIDISP                       
        STZ.W !NMITIMEN                      
        LDA.B !VMAIN_16BIT_MODE              
        STA.W !VMAIN                         
        LDA.B !DMAPX_16BIT_FIXED_SOURCE       
        STA.W !DMAP0                         
        LDA.B !BBADX_DMA_VRAMPORT             
        STA.W !BBAD0                         
        %Set16bit(!M)                        
        LDA.W #$8424                         ;src -> $808424 = #$0000
        STA.W !A1T0L                         
        %Set8bit(!M)                         
        LDA.B #$80                           
        STA.W !A1B0                          
        %Set16bit(!M)                        
        LDA.W #$0FFF                         ;size -> $0FFF = 4k
        STA.W !DAS0L                         
        %Set8bit(!M)                         
        LDA.B !MDMAEN_Enable_Channel_1       
        STA.W !MDMAEN                        
        RTL                                  

;;;;;;;; Returns a number between 0 and a number given in A, max 255, Return in A
;;;;;;;; Its a simple, divides between given number and 255, gets an RNG, and then starts
;;;;;;;; checking if its rng is smaller than X, then X*2, the etc till it finds a match
RNGReturn0toA: ;8089F9
        %Set8bit(!MX)                        
        STA.B !scratch92                            
        PHA                                  
        STZ.B !scratch93                            
        %Set16bit(!M)                        
        LDA.W #$00FF                         
        STA.B !scratch7E                     
        LDA.B !scratch92                     
        STA.B !scratch80                     
        JSL.L DivisionUnsigned               
        %Set8bit(!M)                         
        STA.B !scratch93                            
        JSL.L GetRNG                         
        %Set8bit(!MX)                        
        STA.B !scratch94                     
        PLA                                  
        DEC A                                
        STA.B !scratch92                     
        LDX.B #$00                           
        LDA.B !scratch93                     
                                             
      - CMP.B !scratch94                     
        BCS +                                
        INX                                  
        CPX.B !scratch92                     
        BEQ +                                
        CLC                                  
        ADC.B !scratch93                     
        BRA -                                

      + TXA                                  
        RTL                                  

;;;;;;;; Prepares a DMA channel to later copy during NMI, more info on ram.asm
;;;;;;;; Params A:Control Registers, X:VRAM/CGRAM Dest Addresses, Y(DMA Size), $72 & $74 24b src
;;;;;;;; TODO $C7
AddProgrammedDMA: ;808A33
        !src_address = $72
        !src_bank = $74

        %Set16bit(!MX)                       
        PHA                                  
        TXA                                  
        PHA                                  
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.B !ProgDMA_Channel_Index         
        ASL A                                
        TAX                                  
        %Set16bit(!M)                        
        PLA                                  
        STA.B !ProgDMA_Destination_Addr_Table,X                          
        TXA                                  
        LSR A                                
        TAX                                  
        PLA                                  
        %Set8bit(!M)                         
        STA.B !ProgDMA_Control_Register_Table,X
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.B !ProgDMA_Channel_Index         
        ASL A                                
        ASL A                                
        ASL A                                
        ASL A                                
        %Set16bit(!M)                        
        TAX                                  
        %Set8bit(!M)                         
        LDA.B !ProgDMA_Destination_Memory                            
        CMP.B !BBADX_DMA_VRAMPORT                          
        BNE .CGRAM
        LDA.B !DMAPX_16BIT                           
        STA.W !DMAP0,X                       
        BRA ++

    .CGRAM
        STZ.W !DMAP0,X                       ;1 register write once

     ++ LDA.B !ProgDMA_Destination_Memory     
        STA.W !BBAD0,X                       
        %Set16bit(!M)                        
        LDA.B !src_address                   
        STA.W !A1T0L,X                       
        %Set8bit(!M)                         
        LDA.B !src_bank                     
        STA.W !A1B0,X                        
        %Set16bit(!M)                        
        TYA                                  
        STA.W !DAS0L,X                       
        LDA.B $C7                            ;
        SEC                                  
        SBC.W !DAS0L,X                       
        STA.B $C7                            
        TXA                                  
        LSR A                                
        LSR A                                
        LSR A                                
        LSR A                                
        TAX                                  
        %Set8bit(!M)                         
        LDA.B !ProgDMA_Channel_Flag_to_Copy  
        ORA.L DMA_Channels_Flag_Table,X     
        STA.B !ProgDMA_Channel_Flag_to_Copy  

        RTL                                  

;;;;;;;;
RemoveProgrammedDMA: ;808AA0
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B !ProgDMA_Channel_Index         
        TAX                                  
        LDA.L DMA_Channels_Flag_Table,X      
        EOR.B #$FF                           
        AND.B !ProgDMA_Channel_Flag_to_Copy  
        STA.B !ProgDMA_Channel_Flag_to_Copy  
        RTL                                  

;;;;;;;; Only copies the last Programmed DMA, and kinda ditches the rest by zeroing ProgDMA_Channel_Flag_to_Copy
;;;;;;;; But doesnt reset the channel index, so the Programmed DMA states is in a dirty state?
;;;;;;;; I guess its only used during vblank and when you only are copying one thing at a time
;;;;;;;; still, a STZ !ProgDMA_Channel_Index at the end would make this so much pretty 
StartLastPreparedDMA: ;808AB2
        %Set8bit(!MX)                        
        LDA.B !ProgDMA_Channel_Index         
        PHA                                  
        ASL A                                
        ASL A                                
        ASL A                                
        ASL A                                
        TAX                                  
        LDA.W !BBAD0,X                       
        CMP.B !BBADX_DMA_VRAMPORT            
        BNE .CGRAM                           
        PLX                                  
        LDA.B !ProgDMA_Control_Register_Table,X
        STA.W !VMAIN                         
        %Set16bit(!M)                        
        TXA                                  
        ASL A                                
        TAX                                  
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !VMADDL                        
        BRA .write                           

    .CGRAM:
        PLX                                  
        TXA                                  
        ASL A                                
        TAX                                  
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !CGADD                         

    .write:
        %Set8bit(!M)                         
        TXA                                  
        LSR A                                
        TAX                                  
        LDA.L DMA_Channels_Flag_Table,X      
        STA.W !MDMAEN                        
        STZ.B !ProgDMA_Channel_Flag_to_Copy  
        STZ.W !MDMAEN                        
        RTL                                  

;;;;;;;; Start the prepared DMA changes
StartProgramedDMA: ;808AF0
        %Set8bit(!MX)                             
        LDX.B #$00                           

    .nextPort:
        LDA.L DMA_Channels_Flag_Table,X               
        AND.B !ProgDMA_Channel_Flag_to_Copy
        BEQ .skipChannel                     
        PHX                                  ;saves current Channel
        TXA                                  
        ASL A                                
        ASL A                                
        ASL A                                
        ASL A                                
        TAX                                  ;Mult X by 8, as thats the separation between channels
        LDA.W !BBAD0,X                       ;Reads current destination of the DMA
        CMP.B !BBADX_DMA_VRAMPORT                           
        BNE .copyCGRAM                       ;checks what memory has to update

    ;copyVRAM                                
        PLX                                  ;Retrieves current Channel
        LDA.B !ProgDMA_Control_Register_Table,X                          
        STA.W !VMAIN                         
        %Set16bit(!M)                             
        TXA                                  
        ASL A                                
        TAX                                  ;Doubles X as next value is 16bit
        LDA.B !ProgDMA_Destination_Addr_Table,X                          
        STA.W !VMADDL                        
        BRA .write                           

    .copyCGRAM:
        PLX                                  ;Retrieves current Channel
        TXA                                  
        ASL A                                
        TAX                                  ;Doubles X as next value is 16bit
        LDA.B !ProgDMA_Destination_Addr_Table,X
        STA.W !CGADD                        

    .write:
        %Set8bit(!M)                             
        TXA                                  
        LSR A                                
        TAX                                  ;Halves X, to restore last doubling
        LDA.L DMA_Channels_Flag_Table,X               
        STA.W !MDMAEN                        ;Copies that Channel

    .skipChannel:
        INX                                  
        CPX.B #$08                           ;if last channel just happened
        BNE .nextPort                        
        STZ.B !ProgDMA_Channel_Flag_to_Copy
        STZ.W !MDMAEN                        
        RTL                                  

DMA_Channels_Flag_Table: db $01,$02,$04,$08,$10,$20,$40,$80 ;808B3C

;The game can be in 11 different "Graphic presets", those set most PPU function Registers
;Unknown if all are used, some are repeated. 
;The current graphic mode is stored in $8019B6 (remap of $7E19B6)
Table_OBSEL_Presets:      db $60,$60,$60,$60,$60,$60,$03,$03,$03,$03,$63;808B44;Table Object Size and Character Size Register
Table_BGMODE_Presets:     db $09,$09,$09,$09,$09,$09,$09,$09,$09,$09,$09;808B4F;Table BG Mode and Character Size Register
Table_BG1SC_Presets:      db $63,$63,$63,$63,$13,$13,$51,$51,$51,$51,$51;808B5A;Table BG Tilemap Address Registers (BG1)
Table_BG2SC_Presets:      db $72,$72,$72,$73,$63,$63,$59,$59,$59,$59,$59;808B65;Table BG Tilemap Address Registers (BG2)
Table_BG3SC_Presets:      db $7A,$7A,$7A,$7A,$7A,$7A,$09,$09,$0A,$0A,$09;808B70;Table BG Tilemap Address Registers (BG3)
Table_BG4SC_Presets:      db $7C,$7C,$7C,$7C,$7C,$7C,$70,$70,$70,$70,$70;808B7B;Table BG Tilemap Address Registers (BG4)
Table_BG12NBA_Presets:    db $22,$22,$22,$22,$22,$22,$11,$11,$11,$11,$11;808B86;Table BG Character Address Registers (BG1&2)
Table_BG34NBA_Presets:    db $55,$55,$55,$55,$55,$22,$00,$00,$00,$00,$00;808B91;Table BG Character Address Registers (BG3&4)
Table_TM_Presets:         db $15,$17,$17,$17,$17,$17,$13,$13,$13,$13,$15;808B9C;Table Main Screen Designation
Table_TS_Presets:         db $02,$00,$00,$00,$00,$00,$04,$04,$04,$04,$00;808BA7;Table Subscreen Designation
Table_TMW_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BB2;Table Window Mask Designation for the Main Screen
Table_TSW_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BBD;Table Window Mask Designation for the Sub Screen
Table_CGWSEL_Presets:     db $02,$02,$02,$02,$02,$02,$00,$02,$02,$02,$00;808BC8;Table Color Math Registers1
Table_CGADSUB_Presets:    db $73,$73,$73,$73,$73,$73,$00,$53,$13,$53,$00;808BD3;Table Color Math Registers2
Table_SETINI_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BDE;Table Screen Mode Select Register
Table_W12SEL_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BE9;Table Window Mask Settings (BG1&BG2)
Table_W34SEL_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BF4;Table Window Mask Settings (BG1&BG2)
Table_WOBJSEL_Presets:    db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808BFF;Table Window Mask Settings (OBJ)
Table_WH0_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C0A;Table Window Position Registers (WH0)
Table_WH1_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C15;Table Window Position Registers (WH1)
Table_WH2_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C20;Table Window Position Registers (WH2)
Table_WH3_Presets:        db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C2B;Table Window Position Registers (WH3)
Table_WBGLOG_Presets:     db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C36;Table Window Mask Logic registers (BG)
Table_WOBJLOG_Presets:    db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00;808C41;Table Window Mask Logic registers (OBJ)

;;;;;;;; like... why? this is longer than the calling stz $24 and then JSR Force blank...
InitialzieScreenStatusVar:      ;808C4C
        PHP                                  
        %Set16bit(!X)                             
        %Set8bit(!M)                             
        STZ.B !copyof_INIDISP
        %Set16bit(!M)                             
        PLP                                  
        JMP.W ForceBlank

;;;;;;;; The game has a 11 of preprogramed graphic modes, they dictate the PPU status. This
;;;;;;;; function sets the PPU Register dictated by the value of A and a bunch of tables above
;;;;;;;; This OBVIOUSLY something they copypasted from either an early SNES coding documentation
;;;;;;;; or some old projects where they didnt even underestand the architecture. It access
;;;;;;;; evertythig the SLOWEST way posible, and sets a CRAB TON of memory values THAT ARE NEVER
;;;;;;;; READ ANYWHERE ELSE, NOT EVEN IN THIS FUNCTION. This needs a full rewrite. Or fire.
;;;;;;;; Params: A=New Graphic Mode
ManageGraphicPresets: ;808C59
        PHP                                  
        %Set8bit(!MX)                        
        STA.L !graphic_preset                
        TAX                                  
        LDA.L Table_OBSEL_Presets,X            
        STA.L !OBSEL_preset                  
        STA.L !OBSEL24                       
        XBA                                  
        %Set16bit(!M)                        
        AND.W #$0700                         
        ASL A                                
        ASL A                                
        ASL A                                
        ASL A                                
        ASL A                                
        STA.L !graphic_preset_unknown        
        %Set8bit(!M)                         
        LDA.L Table_BGMODE_Presets,X          
        STA.L !BGMODE_preset                 
        STA.L !BGMODE24                      

        STZ.W !graphic_preset_unused01
        STZ.W !graphic_preset_unused02
        STZ.W !graphic_preset_unused03
        STZ.W !graphic_preset_unused04

        LDA.L Table_BG1SC_Presets,X        
        STA.L !BG1SC_preset                  
        STA.L !BG1SC24                       
        AND.B #$FC                           ;removes flip flags
        STA.L !BG1SC_noflip_preset           
        LDA.L Table_BG2SC_Presets,X          
        STA.L !BG2SC_preset                  
        STA.L !BG2SC24                       
        AND.B #$FC                           ;removes flip flags
        STA.L !BG2SC_noflip_preset           
        LDA.L Table_BG3SC_Presets,X          
        STA.L !BG3SC_preset                  
        STA.L !BG3SC24                       
        AND.B #$FC                           ;removes flip flags
        STA.L !BG3SC_noflip_preset           
        LDA.L Table_BG4SC_Presets,X          
        STA.L !BG4SC_preset                  
        STA.L !BG4SC24                       
        AND.B #$FC                           ;removes flip flags
        STA.L !BG4SC_noflip_preset           
        LDA.L Table_BG12NBA_Presets,X     
        STA.L !BG12NBA_preset                 
        STA.L !BG12NBA24                     
        LDA.L Table_BG34NBA_Presets,X     
        STA.L !BG34NBA_preset                
        STA.L !BG34NBA24                     

        %Set16bit(!M)                        
        LDA.W #$0000                         
        STA.L !graphic_preset_unused05                        
        STA.L !graphic_preset_unused06                        
        STA.L !graphic_preset_unused07                        
        STA.L !graphic_preset_unused08                        
        STA.L !graphic_preset_unused09                        
        STA.L !graphic_preset_unused10                       
        STA.L !graphic_preset_unused11                        
        STA.L !graphic_preset_unused12                        
        %Set8bit(!M)                         
        BIT.B !copyof_INIDISP                
        BPL .skip                            ;Always false?

        PHX                                  
        LDX.B #$00                           

      - STA.L !BG1HOFS24,X                   ;Sets all BG Scroll register to 0
        STA.L !BG1HOFS24,X                   
        STA.L !BG1VOFS24,X                   
        STA.L !BG1VOFS24,X                   
        INX                                  
        INX                                  
        CPX.B #$08                           
        BNE -                           
        PLX                                  

    .skip:
        STA.L !M7SEL_preset                        
        STA.L !M7SEL24                       
        LDA.L Table_W12SEL_Presets,X         
        STA.L !W12SEL_preset                       
        STA.L !W12SEL24                      
        LDA.L Table_W34SEL_Presets,X         
        STA.L !W34SEL_preset                       
        STA.L !W34SEL24                      
        LDA.L Table_WOBJSEL_Presets,X           
        STA.L !WOBJSEL_preset                        
        STA.L !WOBJSEL24                     
        LDA.L Table_WBGLOG_Presets,X          
        STA.L !WBGLOG_preset                        
        STA.L !WBGLOG24                      
        LDA.L Table_WOBJLOG_Presets,X         
        STA.L !WOBJLOG_preset                        
        STA.L !WOBJLOG24                     
        LDA.L Table_WH0_Presets,X           
        STA.L !WH0_preset                    
        STA.L !WH024                         
        LDA.L Table_WH1_Presets,X           
        STA.L !WH1_preset                    
        STA.L !WH124                         
        LDA.L Table_WH2_Presets,X           
        STA.L !WH2_preset                    
        STA.L !WH224                         
        LDA.L Table_WH3_Presets,X            
        STA.L !WH3_preset                    
        STA.L !WH324                         
        LDA.L Table_TM_Presets,X             
        STA.L !TM_preset                     
        STA.L !TM24                          
        LDA.L Table_TS_Presets,X             
        STA.L !TS_preset                     
        STA.L !TS24                          
        LDA.L Table_TMW_Presets,X            
        STA.L !TMW_preset                    
        STA.L !TMW24                         
        LDA.L Table_TSW_Presets,X            
        STA.L !TSW_preset                    
        STA.L !TSW24                         
        LDA.L Table_CGWSEL_Presets,X         
        STA.L !CGWSEL_preset                 
        STA.L !CGWSEL24                      
        LDA.L Table_CGADSUB_Presets,X        
        STA.L !CGADSUB_preset                
        STA.L !CGADSUB24                     
        LDA.B #$E0                           
        STA.L !COLDATA_preset                
        STA.L !COLDATA24                     
        LDA.L Table_SETINI_Presets,X         
        STA.L !SETINI_preset                 
        STA.L !SETINI24                      
        PLP                                  
        RTL                                  

;;;;;;;; 
ForceBlank: ;808E0F
        PHP                                  
        %Set8bit(!M)                             
        LDA.B !copyof_INIDISP        
        ORA.B #$80                           ;modify only the blank bit
        STA.B !copyof_INIDISP                            
        STA.L !INIDISP24                     ;24bit direction of INIDISP???
        PLP                                  
        RTL                         

;;;;;;;;
ResetForceBlank: ;808E1E
        PHP                                  
        %Set8bit(!M)                         
        LDA.B !copyof_INIDISP                
        AND.B #$0F                           ;conserves Brightness
        STA.B !copyof_INIDISP                
        STA.L !INIDISP24                     
        PLP                                  
        RTL                                  

;;;;;;;; Param Desired Brightness in A. It forces blank if bright = 0
SetsBrightness: ;808E2D
        PHP                                  
        %Set8bit(!M)                         
        AND.B #$0F                           ;keeps what would be only brightness
        BNE +                                ;if 0, just force blank
        LDA.B !INIDISP_FORCE_BLANK

      + STA.L $80007E                        ;A scratch memory, but accesed as 24bit???
        LDA.B !copyof_INIDISP                
        AND.B #$80                           ;keeps current force blank
        ORA.B $7E                            ;same scratch memory, retrives bright from there
        STA.B !copyof_INIDISP                
        STA.L !INIDISP24                     
        PLP                                  
        RTL                                  

;;;;;;;;
  UNK_MemoryWork42_44: %Set8bit(!MX)                             ;808E48;      ;ParamAY
                       STA.W $015A,X                        ;808E4A;00015A; 
                       TYA                                  ;808E4D;      ; 
                       STA.W $016A,X                        ;808E4E;00016A; 
                       STZ.W $014A,X                        ;808E51;00014A; 
                       %Set16bit(!M)                             ;808E54;      ; 
                       TXA                                  ;808E56;      ; 
                       STA.B $7E                            ;808E57;00007E; 
                       ASL A                                ;808E59;      ; 
                       CLC                                  ;808E5A;      ; 
                       ADC.B $7E                            ;808E5B;00007E; 
                       TAX                                  ;808E5D;      ; 
                       LDA.B $72                            ;808E5E;000072; 
                       STA.B $42,X                          ;808E60;000042; 
                       %Set8bit(!M)                             ;808E62;      ; 
                       LDA.B $74                            ;808E64;000074; 
                       STA.B $44,X                          ;808E66;000044; 
                       RTL                                  ;808E68;      ;END_QQQQ

;;;;;;;;I think this is Rain/Snow related
UNK_BigLoop:
        %Set16bit(!MX)                       
        %Set8bit(!M)                         
        STZ.B $92                            
        STZ.B $93                            
        LDY.W #$0000                         
        %Set16bit(!M)                        
        LDA.W $0196                          ;if its raining    
        AND.W #$000A                         
        BNE +                              
        LDY.W #$0004                         

      + %Set16bit(!M)                        
        TYA                                  
        STA.B $7E                            
        ASL A                                
        CLC                                  
        ADC.B $7E                            ;mult by 3, either 0 or 4
        TAX                                  
        LDA.B $42,X                          
        BNE CODE_808E9D                      ;808E8D;808E9D; 
        %Set8bit(!M)                             ;808E8F;      ; 
        LDA.B $44,X                          ;808E91;000044; 
        BNE CODE_808E9D                      ;808E93;808E9D; 
        CPY.W #$0004                         ;808E95;      ; 
        BCC CODE_808F19                      ;808E98;808F19; 
        JMP.W CODE_808F2C                    ;808E9A;808F2C; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        CODE_808E9D: %Set8bit(!M)                             ;808E9D;      ; 
        LDA.B #$01                           ;808E9F;      ; 
        STA.B $93                            ;808EA1;000093; 
        %Set16bit(!M)                             ;808EA3;      ; 
        PHY                                  ;808EA5;      ; 
        LDA.B $42,X                          ;808EA6;000042; 
        STA.B $72                            ;808EA8;000072; 
        %Set8bit(!M)                             ;808EAA;      ; 
        LDA.B $44,X                          ;808EAC;000044; 
        STA.B $74                            ;808EAE;000074; 
        %Set16bit(!M)                             ;808EB0;      ; 
        LDA.B [$72]                          ;808EB2;000072; 
        CMP.W #$FFFF                         ;808EB4;      ; 
        BNE CODE_808EBC                      ;808EB7;808EBC; 
        JMP.W CODE_808F57                    ;808EB9;808F57; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        CODE_808EBC: CMP.W #$FFFE                         ;808EBC;      ; 
        BNE CODE_808EC4                      ;808EBF;808EC4; 
        JMP.W CODE_808F62                    ;808EC1;808F62; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        CODE_808EC4: PLY                                  ;808EC4;      ; 
        TYX                                  ;808EC5;      ; 
        %Set8bit(!M)                             ;808EC6;      ; 
        LDA.W $014A,X                        ;808EC8;00014A; 
        BEQ CODE_808ED0                      ;808ECB;808ED0; 
        JMP.W CODE_808F52                    ;808ECD;808F52; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        CODE_808ED0: PHY                                  ;808ED0;      ; 
        TYX                                  ;808ED1;      ; 
        LDA.B #$00                           ;808ED2;      ; 
        XBA                                  ;808ED4;      ; 
        LDA.W $016A,X                        ;808ED5;00016A; 
        %Set16bit(!M)                             ;808ED8;      ; 
        PHA                                  ;808EDA;      ; 
        TYX                                  ;808EDB;      ; 
        %Set8bit(!M)                             ;808EDC;      ; 
        LDA.B #$00                           ;808EDE;      ; 
        XBA                                  ;808EE0;      ; 
        LDA.W $015A,X                        ;808EE1;00015A; 
        %Set16bit(!M)                             ;808EE4;      ; 
        PHA                                  ;808EE6;      ; 
        LDA.B [$72]                          ;808EE7;000072; 
        PLX                                  ;808EE9;      ; 
        PLY                                  ;808EEA;      ; 
        JSL.L IIII                           ;808EEB;80916F; 
        %Set16bit(!MX)                             ;808EEF;      ; 
        PLY                                  ;808EF1;      ; 
        PHY                                  ;808EF2;      ; 
        TYX                                  ;808EF3;      ; 
        LDY.W #$0002                         ;808EF4;      ; 
        %Set8bit(!M)                             ;808EF7;      ; 
        LDA.B [$72],Y                        ;808EF9;000072; 
        STA.W $014A,X                        ;808EFB;00014A; 
        %Set16bit(!M)                             ;808EFE;      ; 
        PLY                                  ;808F00;      ; 
        TYA                                  ;808F01;      ; 
        STA.B $7E                            ;808F02;00007E; 
        ASL A                                ;808F04;      ; 
        CLC                                  ;808F05;      ; 
        ADC.B $7E                            ;808F06;00007E; 
        TAX                                  ;808F08;      ; 
        LDA.B $42,X                          ;808F09;000042; 
        CLC                                  ;808F0B;      ; 
        ADC.W #$0003                         ;808F0C;      ; 
        STA.B $42,X                          ;808F0F;000042; 
        %Set8bit(!M)                             ;808F11;      ; 
        LDA.B $44,X                          ;808F13;000044; 
        ADC.B #$00                           ;808F15;      ; 
        STA.B $44,X                          ;808F17;000044; 
                                                ;      ;      ; 
        CODE_808F19: %Set16bit(!M)                             ;808F19;      ; 
        TYA                                  ;808F1B;      ; 
        STA.B $7E                            ;808F1C;00007E; 
        ASL A                                ;808F1E;      ; 
        CLC                                  ;808F1F;      ; 
        ADC.B $7E                            ;808F20;00007E; 
        TAX                                  ;808F22;      ; 
        INY                                  ;808F23;      ; 
        CPY.W #$0010                         ;808F24;      ; 
        BEQ CODE_808F2C                      ;808F27;808F2C; 
        JMP.W $8E81                          ;808F29;808E81; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        CODE_808F2C: %Set8bit(!M)                             ;808F2C;      ; 
        LDA.B $93                            ;808F2E;000093; 
        BEQ CODE_808F51                      ;808F30;808F51; 
        LDA.B #$05                           ;808F32;      ; 
        STA.B !ProgDMA_Channel_Index                            ;808F34;000027; 
        LDA.B #$22                           ;808F36;      ; 
        STA.B !ProgDMA_Destination_Memory                            ;808F38;000029; 
        %Set16bit(!M)                             ;808F3A;      ; 
        LDY.W #$0100                         ;808F3C;      ; 
        LDX.W #$0000                         ;808F3F;      ; 
        LDA.W #$0900                         ;808F42;      ; 
        STA.B $72                            ;808F45;000072; 
        %Set8bit(!M)                             ;808F47;      ; 
        LDA.B #$7F                           ;808F49;      ; 
        STA.B $74                            ;808F4B;000074; 
        JSL.L AddProgrammedDMA                ;808F4D;808A33; 
                                                ;      ;      ; 
        CODE_808F51: RTL                                  ;808F51;      ; 
                                        ;      ;      ; 
                                        ;      ;      ; 
        CODE_808F52: DEC.W $014A,X                        ;808F52;00014A; 
        BRA CODE_808F19                      ;808F55;808F19; 
                                        ;      ;      ; 
                                        ;      ;      ; 
        CODE_808F57: %Set16bit(!M)                             ;808F57;      ; 
        STZ.B $42,X                          ;808F59;000042; 
        %Set8bit(!M)                             ;808F5B;      ; 
        STZ.B $44,X                          ;808F5D;000044; 
        JMP.W CODE_808EC4                    ;808F5F;808EC4; 
                                        ;      ;      ; 
                                        ;      ;      ; 
        CODE_808F62: %Set16bit(!M)                             ;808F62;      ; 
        LDY.W #$0002                         ;808F64;      ; 
        LDA.B [$72],Y                        ;808F67;000072; 
        STA.B $42,X                          ;808F69;000042; 
        INY                                  ;808F6B;      ; 
        INY                                  ;808F6C;      ; 
        %Set8bit(!M)                             ;808F6D;      ; 
        LDA.B [$72],Y                        ;808F6F;000072; 
        STA.B $44,X                          ;808F71;000044; 
        %Set16bit(!M)                             ;808F73;      ; 
        LDA.B $42,X                          ;808F75;000042; 
        STA.B $72                            ;808F77;000072; 
        %Set8bit(!M)                             ;808F79;      ; 
        LDA.B $44,X                          ;808F7B;000044; 
        STA.B $74                            ;808F7D;000074; 
        JMP.W CODE_808EC4                    ;808F7F;808EC4;END_UNK_BigLoop
                                                            ;      ;      ; 
                                                            ;      ;      ; 
     NullsPointersbyA: %Set16bit(!MX)                             ;808F82;      ;Param A
                       STA.B $7E                            ;808F84;00007E; 
                       ASL A                                ;808F86;      ; 
                       CLC                                  ;808F87;      ; 
                       ADC.B $7E                            ;808F88;00007E; 
                       TAX                                  ;808F8A;      ; 
                       STZ.B $42,X                          ;808F8B;000042; 
                       %Set8bit(!M)                             ;808F8D;      ; 
                       STZ.B $44,X                          ;808F8F;000044; 
                       RTL                                  ;808F91;      ;END_PPPP
                                                            ;      ;      ; 
                                                            ;      ;      ; 
 ClearMemoryPointers1: %Set16bit(!MX)                             ;808F92;      ; 
                       %Set16bit(!M)                             ;808F94;      ; 
                       TYA                                  ;808F96;      ; 
                       STA.B $7E                            ;808F97;00007E; 
                       ASL A                                ;808F99;      ; 
                       CLC                                  ;808F9A;      ; 
                       ADC.B $7E                            ;808F9B;00007E; 
                       TAX                                  ;808F9D;      ; 
                       STZ.B $42,X                          ;808F9E;000042; 
                       %Set8bit(!M)                             ;808FA0;      ; 
                       STZ.B $44,X                          ;808FA2;000044; 
                       INY                                  ;808FA4;      ; 
                       CPY.W #$0010                         ;808FA5;      ; 
                       BNE $EA                              ;808FA8;808F94; 
                       RTL                                  ;808FAA;      ;END_OOOO
                                                            ;      ;      ; 
                                                            ;      ;      ; 
 ClearMemoryPointers2: %Set16bit(!MX)                             ;808FAB;      ; 
                       LDY.W #$0000                         ;808FAD;      ; 
                                                            ;      ;      ; 
                .loop: %Set16bit(!M)                             ;808FB0;      ; 
                       TYA                                  ;808FB2;      ; 
                       STA.B $7E                            ;808FB3;00007E; 
                       ASL A                                ;808FB5;      ; 
                       CLC                                  ;808FB6;      ; 
                       ADC.B $7E                            ;808FB7;00007E; 
                       TAX                                  ;808FB9;      ; 
                       STZ.B $42,X                          ;808FBA;000042; 
                       %Set8bit(!M)                             ;808FBC;      ; 
                       STZ.B $44,X                          ;808FBE;000044; 
                       INY                                  ;808FC0;      ; 
                       CPY.W #$0010                         ;808FC1;      ; 
                       BNE .loop                            ;808FC4;808FB0; 
                       RTL                                  ;808FC6;      ;END_ClearMemoryPointers
                                                            ;      ;      ; 
                                                            ;      ;      ; 
Sets04withPointerDependingonHour: %Set8bit(!M)                             ;808FC7;      ;Param in A
                       %Set16bit(!X)                             ;808FC9;      ; 
                       STA.W $017C                          ;808FCB;00017C; 
                       STZ.W $017A                          ;808FCE;00017A; 
                       XBA                                  ;808FD1;      ; 
                       LDA.B #$00                           ;808FD2;      ; 
                       XBA                                  ;808FD4;      ; 
                       %Set16bit(!M)                             ;808FD5;      ; 
                       STA.B $7E                            ;808FD7;00007E; 
                       %Set8bit(!M)                             ;808FD9;      ; 
                       LDA.L !hour                        ;808FDB;7F1F1C;Hour
                       CMP.B #$12                           ;808FDF;      ; 
                       BCC .after6PM                        ;808FE1;808FF2; 
                       %Set16bit(!M)                             ;808FE3;      ;loads a pointer
                       LDA.W #$0B00                         ;808FE5;      ; 
                       STA.B $04                            ;808FE8;000004; 
                       %Set8bit(!M)                             ;808FEA;      ; 
                       LDA.B #$7F                           ;808FEC;      ; 
                       STA.B $06                            ;808FEE;000006; 
                       BRA CODE_80900B                      ;808FF0;80900B; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
            .after6PM: %Set16bit(!M)                             ;808FF2;      ; 
                       LDA.B $7E                            ;808FF4;00007E; 
                       ASL A                                ;808FF6;      ; 
                       CLC                                  ;808FF7;      ; 
                       ADC.B $7E                            ;808FF8;00007E; 
                       TAX                                  ;808FFA;      ; 
                       LDA.L PalettePointerTable,X          ;808FFB;80B9FD; 
                       STA.B $04                            ;808FFF;000004; 
                       INX                                  ;809001;      ; 
                       INX                                  ;809002;      ; 
                       %Set8bit(!M)                             ;809003;      ; 
                       LDA.L PalettePointerTable,X          ;809005;80B9FD; 
                       STA.B $06                            ;809009;000006; 
                                                            ;      ;      ; 
          CODE_80900B: RTL                                  ;80900B;      ;Sets04withPointerDependingonHour
                                                            ;      ;      ; 
                                                            ;      ;      ; 
 Unk_MemoryWork7E0D00: %Set8bit(!M)                             ;80900C;      ; 
                       %Set16bit(!X)                             ;80900E;      ; 
                       LDA.W !time_running                          ;809010;000973; 
                       AND.B #$01                           ;809013;      ; 
                       BNE CODE_80901A                      ;809015;80901A; 
                       JMP.W Unk_MemoryWork7E0D00_RET                        ;809017;809156; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80901A: %Set16bit(!M)                             ;80901A;      ; 
                       LDA.B $04                            ;80901C;000004; 
                       BNE CODE_809029                      ;80901E;809029; 
                       %Set8bit(!M)                             ;809020;      ; 
                       LDA.B $06                            ;809022;000006; 
                       BNE CODE_809029                      ;809024;809029; 
                       JMP.W Unk_MemoryWork7E0D00_RET                        ;809026;809156; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809029: %Set8bit(!M)                             ;809029;      ; 
                       LDA.W $017A                          ;80902B;00017A; 
                       INC A                                ;80902E;      ; 
                       STA.W $017A                          ;80902F;00017A; 
                       CMP.B #$20                           ;809032;      ; 
                       BEQ CODE_809039                      ;809034;809039; 
                       JMP.W Unk_MemoryWork7E0D00_RET                        ;809036;809156; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809039: STZ.W $017A                          ;809039;00017A; 
                       %Set16bit(!M)                             ;80903C;      ; 
                       LDA.W #$0100                         ;80903E;      ; 
                       STA.B $84                            ;809041;000084; 
                       %Set8bit(!M)                             ;809043;      ; 
                       LDA.L !hour                        ;809045;7F1F1C;Hour
                       CMP.B #$12                           ;809049;      ; 
                       BCC CODE_809054                      ;80904B;809054; 
                       %Set16bit(!M)                             ;80904D;      ; 
                       LDA.W #$0200                         ;80904F;      ; 
                       STA.B $84                            ;809052;000084; 
                                                            ;      ;      ; 
          CODE_809054: %Set8bit(!M)                             ;809054;      ; 
                       STZ.B $92                            ;809056;000092; 
                       LDY.W #$0000                         ;809058;      ; 
                                                            ;      ;      ; 
          CODE_80905B: %Set8bit(!M)                             ;80905B;      ; 
                       %Set16bit(!X)                             ;80905D;      ; 
                       CPY.W #$0002                         ;80905F;      ; 
                       BNE CODE_809074                      ;809062;809074; 
                       LDY.W #$0018                         ;809064;      ; 
                       %Set16bit(!M)                             ;809067;      ; 
                       LDA.W $0196                          ;809069;000196; 
                       AND.W #$0004                         ;80906C;      ; 
                       BNE CODE_809074                      ;80906F;809074; 
                       LDY.W #$0020                         ;809071;      ; 
                                                            ;      ;      ; 
          CODE_809074: TYX                                  ;809074;      ; 
                       %Set16bit(!M)                             ;809075;      ; 
                       LDA.L $7F0D00,X                      ;809077;7F0D00; 
                       AND.W #$001F                         ;80907B;      ; 
                       STA.B $7E                            ;80907E;00007E; 
                       LDA.B [$04],Y                        ;809080;000004; 
                       AND.W #$001F                         ;809082;      ; 
                       CMP.B $7E                            ;809085;00007E; 
                       BEQ CODE_809097                      ;809087;809097; 
                       BCS CODE_80908F                      ;809089;80908F; 
                       DEC.B $7E                            ;80908B;00007E; 
                       BRA CODE_809091                      ;80908D;809091; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80908F: INC.B $7E                            ;80908F;00007E; 
                                                            ;      ;      ; 
          CODE_809091: %Set8bit(!M)                             ;809091;      ; 
                       LDA.B #$01                           ;809093;      ; 
                       STA.B $92                            ;809095;000092; 
                                                            ;      ;      ; 
          CODE_809097: %Set16bit(!M)                             ;809097;      ; 
                       LDA.L $7F0D00,X                      ;809099;7F0D00; 
                       AND.W #$03E0                         ;80909D;      ; 
                       LSR A                                ;8090A0;      ; 
                       LSR A                                ;8090A1;      ; 
                       LSR A                                ;8090A2;      ; 
                       LSR A                                ;8090A3;      ; 
                       LSR A                                ;8090A4;      ; 
                       STA.B $80                            ;8090A5;000080; 
                       LDA.B [$04],Y                        ;8090A7;000004; 
                       AND.W #$03E0                         ;8090A9;      ; 
                       LSR A                                ;8090AC;      ; 
                       LSR A                                ;8090AD;      ; 
                       LSR A                                ;8090AE;      ; 
                       LSR A                                ;8090AF;      ; 
                       LSR A                                ;8090B0;      ; 
                       CMP.B $80                            ;8090B1;000080; 
                       BEQ CODE_8090C3                      ;8090B3;8090C3; 
                       BCS CODE_8090BB                      ;8090B5;8090BB; 
                       DEC.B $80                            ;8090B7;000080; 
                       BRA CODE_8090BD                      ;8090B9;8090BD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8090BB: INC.B $80                            ;8090BB;000080; 
                                                            ;      ;      ; 
          CODE_8090BD: %Set8bit(!M)                             ;8090BD;      ; 
                       LDA.B #$01                           ;8090BF;      ; 
                       STA.B $92                            ;8090C1;000092; 
                                                            ;      ;      ; 
          CODE_8090C3: %Set16bit(!M)                             ;8090C3;      ; 
                       LDA.L $7F0D00,X                      ;8090C5;7F0D00; 
                       AND.W #$7C00                         ;8090C9;      ; 
                       LSR A                                ;8090CC;      ; 
                       LSR A                                ;8090CD;      ; 
                       LSR A                                ;8090CE;      ; 
                       LSR A                                ;8090CF;      ; 
                       LSR A                                ;8090D0;      ; 
                       LSR A                                ;8090D1;      ; 
                       LSR A                                ;8090D2;      ; 
                       LSR A                                ;8090D3;      ; 
                       LSR A                                ;8090D4;      ; 
                       LSR A                                ;8090D5;      ; 
                       STA.B $82                            ;8090D6;000082; 
                       LDA.B [$04],Y                        ;8090D8;000004; 
                       AND.W #$7C00                         ;8090DA;      ; 
                       LSR A                                ;8090DD;      ; 
                       LSR A                                ;8090DE;      ; 
                       LSR A                                ;8090DF;      ; 
                       LSR A                                ;8090E0;      ; 
                       LSR A                                ;8090E1;      ; 
                       LSR A                                ;8090E2;      ; 
                       LSR A                                ;8090E3;      ; 
                       LSR A                                ;8090E4;      ; 
                       LSR A                                ;8090E5;      ; 
                       LSR A                                ;8090E6;      ; 
                       CMP.B $82                            ;8090E7;000082; 
                       BEQ CODE_8090F9                      ;8090E9;8090F9; 
                       BCS CODE_8090F1                      ;8090EB;8090F1; 
                       DEC.B $82                            ;8090ED;000082; 
                       BRA CODE_8090F3                      ;8090EF;8090F3; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8090F1: INC.B $82                            ;8090F1;000082; 
                                                            ;      ;      ; 
          CODE_8090F3: %Set8bit(!M)                             ;8090F3;      ; 
                       LDA.B #$01                           ;8090F5;      ; 
                       STA.B $92                            ;8090F7;000092; 
                                                            ;      ;      ; 
          CODE_8090F9: %Set16bit(!M)                             ;8090F9;      ; 
                       ASL.B $80                            ;8090FB;000080; 
                       ASL.B $80                            ;8090FD;000080; 
                       ASL.B $80                            ;8090FF;000080; 
                       ASL.B $80                            ;809101;000080; 
                       ASL.B $80                            ;809103;000080; 
                       ASL.B $82                            ;809105;000082; 
                       ASL.B $82                            ;809107;000082; 
                       ASL.B $82                            ;809109;000082; 
                       ASL.B $82                            ;80910B;000082; 
                       ASL.B $82                            ;80910D;000082; 
                       ASL.B $82                            ;80910F;000082; 
                       ASL.B $82                            ;809111;000082; 
                       ASL.B $82                            ;809113;000082; 
                       ASL.B $82                            ;809115;000082; 
                       ASL.B $82                            ;809117;000082; 
                       LDA.B $7E                            ;809119;00007E; 
                       ORA.B $80                            ;80911B;000080; 
                       ORA.B $82                            ;80911D;000082; 
                       STA.L $7F0900,X                      ;80911F;7F0900; 
                       STA.L $7F0D00,X                      ;809123;7F0D00; 
                       INY                                  ;809127;      ; 
                       INY                                  ;809128;      ; 
                       CPY.B $84                            ;809129;000084; 
                       BEQ CODE_809130                      ;80912B;809130; 
                       JMP.W CODE_80905B                    ;80912D;80905B; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809130: %Set8bit(!M)                             ;809130;      ; 
                       LDA.B $92                            ;809132;000092; 
                       BEQ Clears04PointerandSets017B       ;809134;809157; 
                       %Set8bit(!M)                             ;809136;      ; 
                       LDA.B #$06                           ;809138;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80913A;000027; 
                       LDA.B #$22                           ;80913C;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80913E;000029; 
                       %Set16bit(!M)                             ;809140;      ; 
                       LDY.B $84                            ;809142;000084; 
                       LDX.W #$0000                         ;809144;      ; 
                       LDA.W #$0900                         ;809147;      ; 
                       STA.B $72                            ;80914A;000072; 
                       %Set8bit(!M)                             ;80914C;      ; 
                       LDA.B #$7F                           ;80914E;      ; 
                       STA.B $74                            ;809150;000074; 
                       JSL.L AddProgrammedDMA                ;809152;808A33; 
                                                            ;      ;      ; 
              Unk_MemoryWork7E0D00_RET: RTL                                  ;809156;      ;END_MMMM
                                                            ;      ;      ; 
                                                            ;      ;      ; 
Clears04PointerandSets017B: %Set16bit(!M)                             ;809157;      ; 
                       STZ.B $04                            ;809159;000004; 
                       %Set8bit(!M)                             ;80915B;      ; 
                       STZ.B $06                            ;80915D;000006; 
                       LDA.W $017C                          ;80915F;00017C; 
                       STA.W $017B                          ;809162;00017B; 
                       RTL                                  ;809165;      ;END_Clears04PointerandSets017B
                                                            ;      ;      ; 
                                                            ;      ;      ; 
      Clears04Pointer: %Set16bit(!MX)                             ;809166;      ; 
                       STZ.B $04                            ;809168;000004; 
                       %Set8bit(!M)                             ;80916A;      ; 
                       STZ.B $06                            ;80916C;000006; 
                       RTL                                  ;80916E;      ;END_Clears04and06
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 IIII: %Set16bit(!MX)                             ;80916F;      ; 
                       STA.B $82                            ;809171;000082; 
                       STY.B $7E                            ;809173;00007E; 
                       TXA                                  ;809175;      ; 
                       ASL A                                ;809176;      ; 
                       STA.B $80                            ;809177;000080; 
                       LDA.B $7E                            ;809179;00007E; 
                       ASL A                                ;80917B;      ; 
                       ASL A                                ;80917C;      ; 
                       ASL A                                ;80917D;      ; 
                       ASL A                                ;80917E;      ; 
                       ASL A                                ;80917F;      ; 
                       CLC                                  ;809180;      ; 
                       ADC.B $80                            ;809181;000080; 
                       TAX                                  ;809183;      ; 
                       %Set8bit(!M)                             ;809184;      ; 
                       LDA.B $92                            ;809186;000092; 
                       BNE CODE_809194                      ;809188;809194; 
                       %Set16bit(!M)                             ;80918A;      ; 
                       LDA.B $82                            ;80918C;000082; 
                       STA.L $7F0900,X                      ;80918E;7F0900; 
                       BRA CODE_80919C                      ;809192;80919C; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809194: %Set16bit(!M)                             ;809194;      ; 
                       LDA.B $82                            ;809196;000082; 
                       STA.L $7F0B00,X                      ;809198;7F0B00; 
                                                            ;      ;      ; 
          CODE_80919C: RTL                                  ;80919C;      ;END_IIII
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80919D: %Set16bit(!MX)                             ;80919D;      ; 
                       STA.B $82                            ;80919F;000082; 
                       STY.B $7E                            ;8091A1;00007E; 
                       TXA                                  ;8091A3;      ; 
                       ASL A                                ;8091A4;      ; 
                       STA.B $80                            ;8091A5;000080; 
                       LDA.B $7E                            ;8091A7;00007E; 
                       ASL A                                ;8091A9;      ; 
                       ASL A                                ;8091AA;      ; 
                       ASL A                                ;8091AB;      ; 
                       ASL A                                ;8091AC;      ; 
                       ASL A                                ;8091AD;      ; 
                       CLC                                  ;8091AE;      ; 
                       ADC.B $80                            ;8091AF;000080; 
                       TAX                                  ;8091B1;      ; 
                       %Set8bit(!M)                             ;8091B2;      ; 
                       LDA.B $92                            ;8091B4;000092; 
                       BNE CODE_8091C6                      ;8091B6;8091C6; 
                       %Set16bit(!M)                             ;8091B8;      ; 
                       LDA.B $82                            ;8091BA;000082; 
                       STA.L $7F0900,X                      ;8091BC;7F0900; 
                       STA.L $7F0D00,X                      ;8091C0;7F0D00; 
                       BRA CODE_8091CE                      ;8091C4;8091CE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8091C6: %Set16bit(!M)                             ;8091C6;      ; 
                       LDA.B $82                            ;8091C8;000082; 
                       STA.L $7F0B00,X                      ;8091CA;7F0B00; 
                                                            ;      ;      ; 
          CODE_8091CE: RTL                                  ;8091CE;      ;END_IIII
                                                            ;      ;      ; 

;;;;;;;; param in A, index to pointer to palette
LoadCGRAM: ;8091CF
        %Set16bit(!MX)                       
        STA.B $7E                            
        ASL A                                
        CLC                                  
        ADC.B $7E                            
        TAX                                  
        LDA.L PalettePointerTable,X          
        STA.B $72                            
        INX                                  
        INX                                  
        %Set8bit(!M)                         
        LDA.L PalettePointerTable,X          
        STA.B $74                            
        %Set16bit(!M)                        
        LDA.W #$0100                         
        STA.B $7E                            
        LDX.W #$0000                         
        LDY.W #$0000                         

      - LDA.B [$72],Y                        
        STA.L $7F0900,X                      
        STA.L $7F0D00,X                      
        INY                                  
        INY                                  
        INX                                  
        INX                                  
        CPY.B $7E                            
        BNE -                                

        RTL                                  
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 HHHH: %Set16bit(!MX)                             ;809208;      ;Param in A
                       STA.B $7E                            ;80920A;00007E; 
                       ASL A                                ;80920C;      ; 
                       CLC                                  ;80920D;      ; 
                       ADC.B $7E                            ;80920E;00007E; 
                       TAX                                  ;809210;      ; 
                       LDA.L PalettePointerTable,X          ;809211;80B9FD; 
                       STA.B $72                            ;809215;000072; 
                       INX                                  ;809217;      ; 
                       INX                                  ;809218;      ; 
                       %Set8bit(!M)                             ;809219;      ; 
                       LDA.L PalettePointerTable,X          ;80921B;80B9FD; 
                       STA.B $74                            ;80921F;000074; 
                       %Set16bit(!M)                             ;809221;      ; 
                       LDA.W #$0100                         ;809223;      ; 
                       STA.B $7E                            ;809226;00007E; 
                       LDX.W #$0100                         ;809228;      ; 
                       LDY.W #$0000                         ;80922B;      ; 
                                                            ;      ;      ; 
          CODE_80922E: LDA.B [$72],Y                        ;80922E;000072; 
                       STA.L $7F0900,X                      ;809230;7F0900; 
                       STA.L $7F0D00,X                      ;809234;7F0D00; 
                       INY                                  ;809238;      ; 
                       INY                                  ;809239;      ; 
                       INX                                  ;80923A;      ; 
                       INX                                  ;80923B;      ; 
                       CPY.B $7E                            ;80923C;00007E; 
                       BNE CODE_80922E                      ;80923E;80922E; 
                       RTL                                  ;809240;      ;END_HHHH
                                                            ;      ;      ; 
;;;;;;;;
GGGG:
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$00                           
        XBA                                  
        LDA.B !tilemap_to_load               
        %Set16bit(!M)                        
        STA.B $80                            
        ASL A                                
        ASL A                                
        CLC                                  
        ADC.B $80                            
        ADC.B $80                            
        ADC.W #$0004                         ; * 6 + 4?
        TAX                                  
        %Set8bit(!M)                         
        LDA.B #$00                           
        XBA                                  
        LDA.L DATA8_80BB5C,X                 
        %Set16bit(!M)                        
        STA.B $7E                            
        ASL A                                
        CLC                                  
        ADC.B $7E                            ; * 3
        TAX                                  
        LDA.L PalettePointerTable,X          
        STA.B $72                            ;80926F;000072; 
        INX                                  ;809271;      ; 
        INX                                  ;809272;      ; 
        %Set8bit(!M)                             ;809273;      ; 
        LDA.L PalettePointerTable,X          ;809275;80B9FD; 
        STA.B $74                            ;809279;000074; 
        %Set16bit(!M)                             ;80927B;      ; 
        LDA.W #$0100                         ;80927D;      ; 
        STA.B $7E                            ;809280;00007E; 
        LDX.W #$0000                         ;809282;      ; 
        LDY.W #$0000                         ;809285;      ; 
                                        ;      ;      ; 
        CODE_809288: LDA.B [$72],Y                        ;809288;000072; 
        STA.L $7F0B00,X                      ;80928A;7F0B00; 
        INY                                  ;80928E;      ; 
        INY                                  ;80928F;      ; 
        INX                                  ;809290;      ; 
        INX                                  ;809291;      ; 
        CPY.B $7E                            ;809292;00007E; 
        BNE CODE_809288                      ;809294;809288; 
        %Set8bit(!M)                             ;809296;      ; 
        LDA.B #$00                           ;809298;      ; 
        XBA                                  ;80929A;      ; 
        LDA.B !tilemap_to_load                            ;80929B;000022; 
        ASL A                                ;80929D;      ; 
        TAX                                  ;80929E;      ; 
        INX                                  ;80929F;      ; 
        LDA.W UNK_Table11,X                 ;8092A0;00BE44; 
        %Set16bit(!M)                             ;8092A3;      ; 
        STA.B $7E                            ;8092A5;00007E; 
        ASL A                                ;8092A7;      ; 
        CLC                                  ;8092A8;      ; 
        ADC.B $7E                            ;8092A9;00007E; 
        TAX                                  ;8092AB;      ; 
        LDA.L PalettePointerTable,X          ;8092AC;80B9FD; 
        STA.B $72                            ;8092B0;000072; 
        INX                                  ;8092B2;      ; 
        INX                                  ;8092B3;      ; 
        %Set8bit(!M)                             ;8092B4;      ; 
        LDA.L PalettePointerTable,X          ;8092B6;80B9FD; 
        STA.B $74                            ;8092BA;000074; 
        %Set16bit(!M)                             ;8092BC;      ; 
        LDA.W #$0100                         ;8092BE;      ; 
        STA.B $7E                            ;8092C1;00007E; 
        LDX.W #$0100                         ;8092C3;      ; 
        LDY.W #$0000                         ;8092C6;      ; 
                                        ;      ;      ; 
        CODE_8092C9: LDA.B [$72],Y                        ;8092C9;000072; 
        STA.L $7F0B00,X                      ;8092CB;7F0B00; 
        INY                                  ;8092CF;      ; 
        INY                                  ;8092D0;      ; 
        INX                                  ;8092D1;      ; 
        INX                                  ;8092D2;      ; 
        CPY.B $7E                            ;8092D3;00007E; 
        BNE CODE_8092C9                      ;8092D5;8092C9; 
        %Set8bit(!M)                             ;8092D7;      ; 
        LDA.B #$01                           ;8092D9;      ; 
        STA.B $92                            ;8092DB;000092; 
        JSL.L AAAA                           ;8092DD;8093A4; 
        RTL                                  ;8092E1;      ;END_GGGG
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 FFFF: %Set8bit(!M)                             ;8092E2;      ; 
                       %Set16bit(!X)                             ;8092E4;      ; 
                       LDX.W #$0000                         ;8092E6;      ; 
                       LDA.L !hour                        ;8092E9;7F1F1C; 
                       CMP.B #$07                           ;8092ED;      ; 
                       BCC .timeSet                         ;8092EF;809301; 
                       INX                                  ;8092F1;      ; 
                       CMP.B #$0F                           ;8092F2;      ; 
                       BCC .timeSet                         ;8092F4;809301; 
                       INX                                  ;8092F6;      ; 
                       CMP.B #$11                           ;8092F7;      ; 
                       BCC .timeSet                         ;8092F9;809301; 
                       INX                                  ;8092FB;      ; 
                       CMP.B #$12                           ;8092FC;      ; 
                       BCC .timeSet                         ;8092FE;809301; 
                       INX                                  ;809300;      ; 
                                                            ;      ;      ; 
             .timeSet: STX.B $7E                            ;809301;00007E; 
                       LDA.B #$00                           ;809303;      ; 
                       XBA                                  ;809305;      ; 
                       LDA.B !tilemap_to_load                            ;809306;000022; 
                       %Set16bit(!M)                             ;809308;      ; 
                       STA.B $80                            ;80930A;000080; 
                       ASL A                                ;80930C;      ; 
                       ASL A                                ;80930D;      ; 
                       CLC                                  ;80930E;      ; 
                       ADC.B $80                            ;80930F;000080; 
                       ADC.B $80                            ;809311;000080; 
                       ADC.B $7E                            ;809313;00007E; 
                       TAX                                  ;809315;      ; 
                       %Set8bit(!M)                             ;809316;      ; 
                       LDA.B #$00                           ;809318;      ; 
                       XBA                                  ;80931A;      ; 
                       LDA.L DATA8_80BB5C,X                 ;80931B;80BB5C; 
                       STA.W $017B                          ;80931F;00017B; 
                       %Set16bit(!M)                             ;809322;      ; 
                       JSL.L LoadCGRAM                ;809324;8091CF; 
                       RTL                                  ;809328;      ;END_FFFF
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 EEEE: %Set16bit(!MX)                             ;809329;      ; 
                       LDA.L $7F1F5E                        ;80932B;7F1F5E; 
                       AND.W #$0080                         ;80932F;      ; 
                       BNE DDDD                             ;809332;80936E; 
                       LDA.L $7F1F5E                        ;809334;7F1F5E; 
                       AND.W #$0100                         ;809338;      ; 
                       BNE CCCC                             ;80933B;809380; 
                       LDA.L $7F1F5E                        ;80933D;7F1F5E; 
                       AND.W #$0200                         ;809341;      ; 
                       BNE BBBB                             ;809344;809392; 
                       %Set8bit(!M)                             ;809346;      ; 
                       LDA.B #$00                           ;809348;      ; 
                       XBA                                  ;80934A;      ; 
                       LDA.B !tilemap_to_load                            ;80934B;000022; 
                       ASL A                                ;80934D;      ; 
                       TAX                                  ;80934E;      ; 
                       LDA.L !hour                        ;80934F;7F1F1C; 
                       CMP.B #$12                           ;809353;      ; 
                       BCC CODE_809358                      ;809355;809358; 
                       INX                                  ;809357;      ; 
                                                            ;      ;      ; 
          CODE_809358: %Set8bit(!M)                             ;809358;      ; 
                       %Set16bit(!X)                             ;80935A;      ; 
                       LDA.W UNK_Table11,X                 ;80935C;00BE44; 
                       %Set16bit(!M)                             ;80935F;      ; 
                       JSL.L HHHH                           ;809361;809208; 
                       %Set8bit(!M)                             ;809365;      ; 
                       STZ.B $92                            ;809367;000092; 
                       JSL.L AAAA                           ;809369;8093A4; 
                       RTL                                  ;80936D;      ;END_EEEE
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 DDDD: %Set16bit(!MX)                             ;80936E;      ; 
                       LDA.W #$0071                         ;809370;      ; 
                       JSL.L HHHH                           ;809373;809208; 
                       %Set8bit(!M)                             ;809377;      ; 
                       STZ.B $92                            ;809379;000092; 
                       JSL.L AAAA                           ;80937B;8093A4; 
                       RTL                                  ;80937F;      ;END_DDDD
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 CCCC: %Set16bit(!MX)                             ;809380;      ; 
                       LDA.W #$0072                         ;809382;      ; 
                       JSL.L HHHH                           ;809385;809208; 
                       %Set8bit(!M)                             ;809389;      ; 
                       STZ.B $92                            ;80938B;000092; 
                       JSL.L AAAA                           ;80938D;8093A4; 
                       RTL                                  ;809391;      ;END_CCCC
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 BBBB: %Set16bit(!MX)                             ;809392;      ; 
                       LDA.W #$0073                         ;809394;      ; 
                       JSL.L HHHH                           ;809397;809208; 
                       %Set8bit(!M)                             ;80939B;      ; 
                       STZ.B $92                            ;80939D;000092; 
                       JSL.L AAAA                           ;80939F;8093A4; 
                       RTL                                  ;8093A3;      ;END_BBBB
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 AAAA: %Set16bit(!MX)                             ;8093A4;      ; 
                       STZ.B $7E                            ;8093A6;00007E; 
                       %Set8bit(!M)                             ;8093A8;      ; 
                       LDA.B $92                            ;8093AA;000092; 
                       BNE .skip                            ;8093AC;8093C0; 
                       LDA.L !hour                        ;8093AE;7F1F1C;Hour
                       CMP.B #$12                           ;8093B2;      ; 
                       BCC .before6PM                       ;8093B4;8093C7; 
                       LDA.B !tilemap_to_load                            ;8093B6;000022; 
                       CMP.B #$31                           ;8093B8;      ; 
                       BCS .skip                            ;8093BA;8093C0; 
                       CMP.B #$15                           ;8093BC;      ; 
                       BCS .before6PM                       ;8093BE;8093C7; 
                                                            ;      ;      ; 
                .skip: %Set16bit(!M)                             ;8093C0;      ; 
                       LDA.W #$0004                         ;8093C2;      ; 
                       STA.B $7E                            ;8093C5;00007E; 
                                                            ;      ;      ; 
           .before6PM: %Set8bit(!M)                             ;8093C7;      ; 
                       LDA.B #$00                           ;8093C9;      ; 
                       XBA                                  ;8093CB;      ; 
                       LDA.W $0022                          ;8093CC;000022; 
                       CMP.B #$04                           ;8093CF;      ; 
                       BCS .not4                            ;8093D1;8093DF; 
                                                            ;      ;      ; 
   .butBetween10and14: %Set8bit(!M)                             ;8093D3;      ; 
                       LDA.L !season                        ;8093D5;7F1F19;Season
                       %Set16bit(!M)                             ;8093D9;      ; 
                       STA.B $82                            ;8093DB;000082; 
                       BRA .continue                        ;8093DD;8093F1; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                .not4: %Set8bit(!M)                             ;8093DF;      ; 
                       CMP.B #$10                           ;8093E1;      ; 
                       BCC .butBetween10and14               ;8093E3;8093D3; 
                       CMP.B #$14                           ;8093E5;      ; 
                       BCS .butBetween10and14               ;8093E7;8093D3; 
                       %Set16bit(!M)                             ;8093E9;      ; 
                       SEC                                  ;8093EB;      ; 
                       SBC.W #$0008                         ;8093EC;      ; 
                       STA.B $82                            ;8093EF;000082; 
                                                            ;      ;      ; 
            .continue: %Set8bit(!M)                             ;8093F1;      ; 
                       LDA.B #$00                           ;8093F3;      ; 
                       XBA                                  ;8093F5;      ; 
                       LDA.B $82                            ;8093F6;000082; 
                       CLC                                  ;8093F8;      ; 
                       ADC.B $7E                            ;8093F9;00007E; 
                       STA.B $80                            ;8093FB;000080; 
                       %Set16bit(!M)                             ;8093FD;      ; 
                       ASL A                                ;8093FF;      ; 
                       CLC                                  ;809400;      ; 
                       ADC.B $80                            ;809401;000080; 
                       ASL A                                ;809403;      ; 
                       TAX                                  ;809404;      ; 
                       PHX                                  ;809405;      ; 
                       LDA.L UNK_Table9,X                   ;809406;80BD9C; 
                       LDX.W #$000A                         ;80940A;      ; 
                       LDY.W #$000F                         ;80940D;      ; 
                       JSL.L CODE_80919D                    ;809410;80919D; 
                       %Set16bit(!MX)                             ;809414;      ; 
                       PLX                                  ;809416;      ; 
                       INX                                  ;809417;      ; 
                       INX                                  ;809418;      ; 
                       PHX                                  ;809419;      ; 
                       LDA.L UNK_Table9,X                   ;80941A;80BD9C; 
                       LDX.W #$000B                         ;80941E;      ; 
                       LDY.W #$000F                         ;809421;      ; 
                       JSL.L CODE_80919D                    ;809424;80919D; 
                       %Set16bit(!MX)                             ;809428;      ; 
                       PLX                                  ;80942A;      ; 
                       INX                                  ;80942B;      ; 
                       INX                                  ;80942C;      ; 
                       LDA.L UNK_Table9,X                   ;80942D;80BD9C; 
                       LDX.W #$000C                         ;809431;      ; 
                       LDY.W #$000F                         ;809434;      ; 
                       JSL.L CODE_80919D                    ;809437;80919D; 
                       %Set16bit(!MX)                             ;80943B;      ; 
                       STZ.B $7E                            ;80943D;00007E; 
                       %Set8bit(!M)                             ;80943F;      ; 
                       LDA.B $92                            ;809441;000092; 
                       BNE CODE_809457                      ;809443;809457; 
                       LDA.L !hour                        ;809445;7F1F1C;Hour
                       CMP.B #$12                           ;809449;      ; 
                       BCC CODE_809460                      ;80944B;809460; 
                       LDA.B !tilemap_to_load                            ;80944D;000022; 
                       CMP.B #$31                           ;80944F;      ; 
                       BCS CODE_809457                      ;809451;809457; 
                       CMP.B #$15                           ;809453;      ; 
                       BCS CODE_809460                      ;809455;809460; 
                                                            ;      ;      ; 
          CODE_809457: %Set16bit(!M)                             ;809457;      ; 
                       LDA.W #$0006                         ;809459;      ; 
                       STA.B $7E                            ;80945C;00007E; 
                       BRA CODE_809460                      ;80945E;809460; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809460: %Set16bit(!MX)                             ;809460;      ; 
                       LDA.L !wife_pregnancy                        ;809462;7F1F3B;Wife Pregnancy
                       BNE CODE_80946B                      ;809466;80946B; 
                       JMP.W returnAAAA                        ;809468;809500; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80946B: LDA.L $7F1F66                        ;80946B;7F1F66;Which Wife Flag
                       AND.W #$0001                         ;80946F;      ; 
                       BNE CODE_80949A                      ;809472;80949A; 
                       LDA.L $7F1F66                        ;809474;7F1F66;Which Wife Flag
                       AND.W #$0002                         ;809478;      ; 
                       BNE CODE_8094A1                      ;80947B;8094A1; 
                       LDA.L $7F1F66                        ;80947D;7F1F66;Which Wife Flag
                       AND.W #$0004                         ;809481;      ; 
                       BNE CODE_8094A8                      ;809484;8094A8; 
                       LDA.L $7F1F66                        ;809486;7F1F66;Which Wife Flag
                       AND.W #$0008                         ;80948A;      ; 
                       BNE CODE_8094AF                      ;80948D;8094AF; 
                       LDA.L $7F1F66                        ;80948F;7F1F66;Which Wife Flag
                       AND.W #$0010                         ;809493;      ; 
                       BNE CODE_8094B6                      ;809496;8094B6; 
                       BRA returnAAAA                          ;809498;809500; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80949A: %Set16bit(!MX)                             ;80949A;      ; 
                       LDA.W #$0001                         ;80949C;      ; 
                       BRA CODE_8094BD                      ;80949F;8094BD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8094A1: %Set16bit(!MX)                             ;8094A1;      ; 
                       LDA.W #$0002                         ;8094A3;      ; 
                       BRA CODE_8094BD                      ;8094A6;8094BD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8094A8: %Set16bit(!MX)                             ;8094A8;      ; 
                       LDA.W #$0003                         ;8094AA;      ; 
                       BRA CODE_8094BD                      ;8094AD;8094BD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8094AF: %Set16bit(!MX)                             ;8094AF;      ; 
                       LDA.W #$0004                         ;8094B1;      ; 
                       BRA CODE_8094BD                      ;8094B4;8094BD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8094B6: %Set16bit(!MX)                             ;8094B6;      ; 
                       LDA.W #$0005                         ;8094B8;      ; 
                       BRA CODE_8094BD                      ;8094BB;8094BD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8094BD: %Set16bit(!MX)                             ;8094BD;      ; 
                       CLC                                  ;8094BF;      ; 
                       ADC.B $7E                            ;8094C0;00007E; 
                       STA.B $80                            ;8094C2;000080; 
                       ASL A                                ;8094C4;      ; 
                       CLC                                  ;8094C5;      ; 
                       ADC.B $80                            ;8094C6;000080; 
                       ASL A                                ;8094C8;      ; 
                       TAX                                  ;8094C9;      ; 
                       PHX                                  ;8094CA;      ; 
                       LDA.L UNK_Table10,X                  ;8094CB;80BDFC; 
                       LDX.W #$0008                         ;8094CF;      ; 
                       LDY.W #$000B                         ;8094D2;      ; 
                       JSL.L CODE_80919D                    ;8094D5;80919D; 
                       %Set16bit(!MX)                             ;8094D9;      ; 
                       PLX                                  ;8094DB;      ; 
                       INX                                  ;8094DC;      ; 
                       INX                                  ;8094DD;      ; 
                       PHX                                  ;8094DE;      ; 
                       LDA.L UNK_Table10,X                  ;8094DF;80BDFC; 
                       LDX.W #$0009                         ;8094E3;      ; 
                       LDY.W #$000B                         ;8094E6;      ; 
                       JSL.L CODE_80919D                    ;8094E9;80919D; 
                       %Set16bit(!MX)                             ;8094ED;      ; 
                       PLX                                  ;8094EF;      ; 
                       INX                                  ;8094F0;      ; 
                       INX                                  ;8094F1;      ; 
                       LDA.L UNK_Table10,X                  ;8094F2;80BDFC; 
                       LDX.W #$000A                         ;8094F6;      ; 
                       LDY.W #$000B                         ;8094F9;      ; 
                       JSL.L CODE_80919D                    ;8094FC;80919D; 
                                                            ;      ;      ; 
              returnAAAA: RTL                                  ;809500;      ;END_AAAA
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 AA9999: %Set8bit(!M)                             ;809501;      ; 
                       %Set16bit(!X)                             ;809503;      ; 
                       LDX.W #$0000                         ;809505;      ; 
                       LDA.L !hour                        ;809508;7F1F1C; 
                       CMP.B #$07                           ;80950C;      ; 
                       BCC CODE_809520                      ;80950E;809520; 
                       INX                                  ;809510;      ; 
                       CMP.B #$0F                           ;809511;      ; 
                       BCC CODE_809520                      ;809513;809520; 
                       INX                                  ;809515;      ; 
                       CMP.B #$11                           ;809516;      ; 
                       BCC CODE_809520                      ;809518;809520; 
                       INX                                  ;80951A;      ; 
                       CMP.B #$12                           ;80951B;      ; 
                       BCC CODE_809520                      ;80951D;809520; 
                       INX                                  ;80951F;      ; 
                                                            ;      ;      ; 
          CODE_809520: STX.B $7E                            ;809520;00007E; 
                       LDA.B #$00                           ;809522;      ; 
                       XBA                                  ;809524;      ; 
                       LDA.B !tilemap_to_load                            ;809525;000022; 
                       %Set16bit(!M)                             ;809527;      ; 
                       STA.B $80                            ;809529;000080; 
                       ASL A                                ;80952B;      ; 
                       ASL A                                ;80952C;      ; 
                       CLC                                  ;80952D;      ; 
                       ADC.B $80                            ;80952E;000080; 
                       ADC.B $80                            ;809530;000080; 
                       ADC.B $7E                            ;809532;00007E; 
                       TAX                                  ;809534;      ; 
                       %Set8bit(!M)                             ;809535;      ; 
                       LDA.B #$00                           ;809537;      ; 
                       XBA                                  ;809539;      ; 
                       LDA.L DATA8_80BB5C,X                 ;80953A;80BB5C; 
                       CMP.W $017B                          ;80953E;00017B; 
                       BEQ CODE_809552                      ;809541;809552; 
                       CMP.B #$FF                           ;809543;      ; 
                       BEQ CODE_809552                      ;809545;809552; 
                       PHA                                  ;809547;      ; 
                       JSL.L Sets04withPointerDependingonHour;809548;808FC7; 
                       %Set8bit(!M)                             ;80954C;      ; 
                       PLA                                  ;80954E;      ; 
                       STA.W $017B                          ;80954F;00017B; 
                                                            ;      ;      ; 
          CODE_809552: RTL                                  ;809552;      ;END_AA9999
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 A8888: %Set8bit(!M)                             ;809553;      ; 
                       %Set16bit(!X)                             ;809555;      ; 
                       LDX.W #$0000                         ;809557;      ; 
                       LDA.L !hour                        ;80955A;7F1F1C;Hour
                       CMP.B #$07                           ;80955E;      ; 
                       BCC .timeFound                       ;809560;809572;Before 7AM
                       INX                                  ;809562;      ; 
                       CMP.B #$0F                           ;809563;      ; 
                       BCC .timeFound                       ;809565;809572;Before 3PM
                       INX                                  ;809567;      ; 
                       CMP.B #$11                           ;809568;      ; 
                       BCC .timeFound                       ;80956A;809572;Before 5PM
                       INX                                  ;80956C;      ; 
                       CMP.B #$12                           ;80956D;      ; 
                       BCC .timeFound                       ;80956F;809572;Before 6PM
                       INX                                  ;809571;      ; 
                                                            ;      ;      ; 
           .timeFound: STX.B $7E                            ;809572;00007E; 
                       LDA.B #$00                           ;809574;      ; 
                       XBA                                  ;809576;      ; 
                       LDA.B !tilemap_to_load                            ;809577;000022; 
                       %Set16bit(!M)                             ;809579;      ; 
                       STA.B $80                            ;80957B;000080; 
                       ASL A                                ;80957D;      ; 
                       ASL A                                ;80957E;      ; 
                       CLC                                  ;80957F;      ; 
                       ADC.B $80                            ;809580;000080; 
                       ADC.B $80                            ;809582;000080; 
                       STA.B $80                            ;809584;000080; 
                       ASL A                                ;809586;      ; 
                       CLC                                  ;809587;      ; 
                       ADC.W #$000A                         ;809588;      ; 
                       TAX                                  ;80958B;      ; 
                       LDA.W UNK_Table12,X                 ;80958C;00BEEC; 
                       CMP.W #$FFFF                         ;80958F;      ; 
                       BEQ .skipSeasonCheck                 ;809592;80959E; 
                       %Set8bit(!M)                             ;809594;      ; 
                       LDA.L !season                        ;809596;7F1F19;Season
                       CMP.B #$02                           ;80959A;      ; 
                       BCC .return                          ;80959C;8095B2; 
                                                            ;      ;      ; 
     .skipSeasonCheck: %Set16bit(!M)                             ;80959E;      ; 
                       LDA.B $80                            ;8095A0;000080; 
                       CLC                                  ;8095A2;      ; 
                       ADC.B $7E                            ;8095A3;00007E; 
                       ASL A                                ;8095A5;      ; 
                       TAX                                  ;8095A6;      ; 
                       LDA.W UNK_Table12,X                 ;8095A7;00BEEC; 
                       CMP.W #$FFFF                         ;8095AA;      ; 
                       BEQ .return                          ;8095AD;8095B2; 
                       JSR.W (UNK_Table12,X)                ;8095AF;80BEEC; 
                                                            ;      ;      ; 
              .return: RTL                                  ;8095B2;      ;END_A8888

;;;;;;;;
AutoMapScrolling: ;8095B3
        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.W !map_scrolling_timer           
        BEQ .return                          
        DEC A                                
        STA.W !map_scrolling_timer           
        %Set16bit(!M)                        
        LDA.B !OBJ_Offset_X                  
        CLC                                  
        ADC.W !map_scrolling_X_speed         
        STA.B !OBJ_Offset_X                  
        STA.W !BG1_Map_Offset_X              
        LDA.B !OBJ_Offset_Y                  
        CLC                                  
        ADC.W !map_scrolling_Y_speed         
        STA.B !OBJ_Offset_Y                  
        STA.W !BG1_Map_Offset_Y              
        BPL .return                          
        STZ.W !BG1_Map_Offset_Y              

    .return RTL                              

;;;;;;;; sets audio flags
UNK_Audio5: ;8095DE
        %Set8bit(!M)                             ;;      ; 
        %Set16bit(!X)                             ;8095E0;      ; 
        LDA.B !tilemap_to_load                            ;8095E2;000022; 
        CMP.B #$1E                           ;8095E4;      ; 
        BEQ $0D                              ;8095E6;8095F5;chek if !tilemap_to_load = $1E
        %Set8bit(!M)                             ;8095E8;      ; 
        LDA.L !hour                        ;8095EA;7F1F1C;Hour
        CMP.B #$12                           ;8095EE;      ; 
        BCC $03                              ;8095F0;8095F5;Before 12PM
        JMP.W Max7E0110                      ;8095F2;809669;Exit Point
                                                ;      ;      ; 
        %Set8bit(!M)                             ;8095F5;      ; 
        %Set16bit(!X)                             ;8095F7;      ; 
        STZ.W $0110                          ;8095F9;000110;$7E0110
        %Set16bit(!M)                             ;8095FC;      ; 
        LDA.W $0196                          ;8095FE;000196;$7E0196
        AND.W #$0010                         ;809601;      ; 
        BNE .flag10                          ;809604;80965F; 
        LDA.W $0196                          ;809606;000196;$7E0196
        AND.W #$0002                         ;809609;      ; 
        BNE .flag02                          ;80960C;809639; 
                                                ;      ;      ; 
        .loop1: %Set8bit(!M)                             ;80960E;      ; 
        LDA.B #$00                           ;809610;      ; 
        XBA                                  ;809612;      ; 
        LDA.B !tilemap_to_load                            ;809613;000022;$7E0022
        %Set16bit(!M)                             ;809615;      ; 
        ASL A                                ;809617;      ;A*2
        TAX                                  ;809618;      ; 
        LDA.L Mayby_Table_AudioTracksbySeason,X;809619;80B8E7; 
        CMP.W #$FFFF                         ;80961D;      ; 
        BEQ .return                          ;809620;809668;not terminator
        STA.B $7E                            ;809622;00007E;$7E007E
        %Set8bit(!M)                             ;809624;      ; 
        LDA.B #$00                           ;809626;      ; 
        XBA                                  ;809628;      ; 
        LDA.L !season                        ;809629;7F1F19;Season
        %Set16bit(!M)                             ;80962D;      ; 
        TAY                                  ;80962F;      ; 
        %Set8bit(!M)                             ;809630;      ; 
        LDA.B ($7E),Y                        ;809632;00007E; 
        STA.W $0110                          ;809634;000110;$7E0110
        BRA .return                          ;809637;809668; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        .flag02: %Set8bit(!M)                             ;809639;      ; 
        LDA.B !tilemap_to_load                            ;80963B;000022;$7E0022
        CMP.B #$5B                           ;80963D;      ;more than 91
        BCS .loop1                           ;80963F;80960E; 
        CMP.B #$57                           ;809641;      ;more than 57
        BCS .return                          ;809643;809668; 
        CMP.B #$31                           ;809645;      ;more than 49
        BCS .skip1                           ;809647;80964D; 
        CMP.B #$15                           ;809649;      ;more than 15
        BCS .skip2                           ;80964B;809656; 
                                                ;      ;      ; 
        .skip1: %Set8bit(!M)                             ;80964D;      ; 
        LDA.B #$13                           ;80964F;      ; 
        STA.W $0110                          ;809651;000110; 
        BRA .return                          ;809654;809668; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        .skip2: %Set8bit(!M)                             ;809656;      ; 
        LDA.B #$14                           ;809658;      ; 
        STA.W $0110                          ;80965A;000110; 
        BRA .return                          ;80965D;809668; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        .flag10: %Set8bit(!M)                             ;80965F;      ; 
        LDA.B #$16                           ;809661;      ; 
        STA.W $0110                          ;809663;000110;$7E0110
        BRA .return                          ;809666;809668; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        .return: RTL                                  ;809668;      ; 
                                                ;      ;      ; 
                                                ;      ;      ; 
        Max7E0110: %Set8bit(!M)                             ;809669;      ; 
        LDA.B #$FF                           ;80966B;      ; 
        STA.W $0110                          ;80966D;000110; 
        RTL                                  ;809670;      ;Max7E0110

;;;;;;;; Wrong name TODO
UNK_PrepareScreenTransition: ;809671
        %Set16bit(!MX)                       
        LDA.W $0196                          
        AND.W #$4000                         ;checks flag, if not set, abort
        BNE +                       
        
        JMP.W ScreenTransitionReturn  

      + LDA.L $7F1F5E                        
        AND.W #$8000                         ;checks flag, if set, transition with no audio change
        BNE +                                

        LDA.L $7F1F60                        
        AND.W #$0100                         ;checks flag, if set, transition with audio change

        BNE ++                                
        LDA.L $7F1F60                        
        AND.W #$0040                         ;checks flag, if not set, abort
        BEQ ++                       
        JMP.W ScreenTransitionReturn  

     ++ %Set8bit(!M)                         
        LDA.W !transition_dest               
        STA.B !tilemap_to_load                            
        JSL.L UNK_Audio5
        JSL.L UNK_Audio25                    

      + %Set16bit(!M)                        
        LDA.L $7F1F60                        
        AND.W #$0008                         ;checks flag, if not set,  
        BEQ +                           
        %Set8bit(!M)                         
        LDA.B #$3C                           
        STA.W !transition_dest               

      + %Set8bit(!M)                         ;sets a Screen Fadeout
        LDA.B #$0F                           
        STA.B !param1                        
        LDA.B #$03                           
        STA.B !param2                        
        LDA.B #$01                           
        STA.B !param3                        
        JSL.L ScreenFadeout                  
        JSL.L ForceBlank                     

UNK_ScreenTransition: ;8096D3
        %Set16bit(!MX)                       
        LDA.W $0196                          
        AND.W #$3FDE                         ;resets many flags, keeping others
        STA.W $0196                          
        LDA.L $7F1F5C                        
        AND.W #$FFF0                         ;resets a nibble
        STA.L $7F1F5C                        
        %Set16bit(!MX)                       
        LDA.B $D2                            
        ORA.W #$4000                         ;sets a flag
        STA.B $D2                            
        %Set16bit(!M)                        
        LDA.W #$7000                         
        JSL.L ZeroesPartialVRAM               
        JSL.L ClearMemoryPointers2           
        JSL.L Clears04Pointer                
        JSL.L ClearWRAMGraphicsSpace         
        JSL.L InitializeOBJs                 
        JSL.L PresetsMemory3                 
        JSL.L PresetsMemory4                 
        %Set8bit(!M)                         
        LDA.W !transition_dest               
        STA.B !tilemap_to_load                            
        JSL.L RunsFunctionbyIndex            
        JSL.L CODE_84816F                    
        %Set8bit(!M)                         
        LDA.W !transition_dest               
        JSL.L A5555                          

ScreenTransitionReturn: ;80972B
        RTL                                  ;Used by this and previous Subrutine


                 A5555: %Set8bit(!M)                             ;80972C;      ; 
                       %Set16bit(!X)                             ;80972E;      ; 
                       STA.B !tilemap_to_load                            ;809730;000022; 
                       PHA                                  ;809732;      ; 
                       %Set8bit(!M)                             ;809733;      ; 
                       STZ.W !time_running                          ;809735;000973; 
                       %Set16bit(!MX)                             ;809738;      ; 
                       LDY.W #$0001                         ;80973A;      ; 
                       JSL.L ANNNN                          ;80973D;80A7AE; 
                       %Set8bit(!M)                             ;809741;      ; 
                       PHA                                  ;809743;      ; 
                       AND.B #$20                           ;809744;      ; 
                       BEQ CODE_80975A                      ;809746;80975A; 
                       %Set16bit(!M)                             ;809748;      ; 
                       LDA.L $7F1F5C                        ;80974A;7F1F5C; 
                       AND.W #$0001                         ;80974E;      ; 
                       BNE CODE_80975A                      ;809751;80975A; 
                       %Set8bit(!M)                             ;809753;      ; 
                       LDA.B #$01                           ;809755;      ; 
                       STA.W !time_running                          ;809757;000973; 
                                                            ;      ;      ; 
          CODE_80975A: %Set8bit(!M)                             ;80975A;      ; 
                       PLA                                  ;80975C;      ; 
                       AND.B #$C0                           ;80975D;      ; 
                       BNE CODE_809764                      ;80975F;809764; 
                       JMP.W CODE_8098A8                    ;809761;8098A8; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809764: AND.B #$80                           ;809764;      ; 
                       BNE CODE_809775                      ;809766;809775; 
                       %Set16bit(!M)                             ;809768;      ; 
                       LDA.W $0196                          ;80976A;000196; 
                       AND.W #$0004                         ;80976D;      ; 
                       BEQ CODE_809775                      ;809770;809775; 
                       JMP.W CODE_8098A8                    ;809772;8098A8; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809775: %Set16bit(!M)                             ;809775;      ; 
                       LDA.L $7F1F5C                        ;809777;7F1F5C; 
                       AND.W #$0002                         ;80977B;      ; 
                       BEQ CODE_809783                      ;80977E;809783; 
                       JMP.W CODE_8098A8                    ;809780;8098A8; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809783: %Set16bit(!M)                             ;809783;      ; 
                       LDA.W $0196                          ;809785;000196; 
                       AND.W #$0002                         ;809788;      ; 
                       BEQ CODE_809806                      ;80978B;809806; 
                       %Set8bit(!M)                             ;80978D;      ; 
                       LDA.B #$57                           ;80978F;      ; 
                       STA.B !tilemap_to_load                            ;809791;000022; 
                       JSL.L TilemapManager           ;809793;80A7C6; 
                       %Set16bit(!M)                             ;809797;      ; 
                       %Set8bit(!X)                             ;809799;      ; 
                       LDA.W #$B9D7                         ;80979B;      ; 
                       STA.B $72                            ;80979E;000072; 
                       %Set8bit(!M)                             ;8097A0;      ; 
                       LDA.B #$80                           ;8097A2;      ; 
                       STA.B $74                            ;8097A4;000074; 
                       %Set8bit(!M)                             ;8097A6;      ; 
                       LDA.B #$0C                           ;8097A8;      ; 
                       LDX.B #$00                           ;8097AA;      ; 
                       LDY.B #$00                           ;8097AC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;8097AE;808E48; 
                       %Set16bit(!M)                             ;8097B2;      ; 
                       %Set8bit(!X)                             ;8097B4;      ; 
                       LDA.W #$B9DC                         ;8097B6;      ; 
                       STA.B $72                            ;8097B9;000072; 
                       %Set8bit(!M)                             ;8097BB;      ; 
                       LDA.B #$80                           ;8097BD;      ; 
                       STA.B $74                            ;8097BF;000074; 
                       %Set8bit(!M)                             ;8097C1;      ; 
                       LDA.B #$0D                           ;8097C3;      ; 
                       LDX.B #$01                           ;8097C5;      ; 
                       LDY.B #$00                           ;8097C7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;8097C9;808E48; 
                       %Set16bit(!M)                             ;8097CD;      ; 
                       %Set8bit(!X)                             ;8097CF;      ; 
                       LDA.W #$B9E2                         ;8097D1;      ; 
                       STA.B $72                            ;8097D4;000072; 
                       %Set8bit(!M)                             ;8097D6;      ; 
                       LDA.B #$80                           ;8097D8;      ; 
                       STA.B $74                            ;8097DA;000074; 
                       %Set8bit(!M)                             ;8097DC;      ; 
                       LDA.B #$0E                           ;8097DE;      ; 
                       LDX.B #$02                           ;8097E0;      ; 
                       LDY.B #$00                           ;8097E2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;8097E4;808E48; 
                       %Set16bit(!M)                             ;8097E8;      ; 
                       %Set8bit(!X)                             ;8097EA;      ; 
                       LDA.W #$B9DF                         ;8097EC;      ; 
                       STA.B $72                            ;8097EF;000072; 
                       %Set8bit(!M)                             ;8097F1;      ; 
                       LDA.B #$80                           ;8097F3;      ; 
                       STA.B $74                            ;8097F5;000074; 
                       %Set8bit(!M)                             ;8097F7;      ; 
                       LDA.B #$0F                           ;8097F9;      ; 
                       LDX.B #$03                           ;8097FB;      ; 
                       LDY.B #$00                           ;8097FD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;8097FF;808E48; 
                       JMP.W CODE_8098A8                    ;809803;8098A8; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809806: %Set16bit(!M)                             ;809806;      ; 
                       LDA.W $0196                          ;809808;000196; 
                       AND.W #$0004                         ;80980B;      ; 
                       BEQ CODE_809828                      ;80980E;809828; 
                       %Set8bit(!M)                             ;809810;      ; 
                       LDA.L !hour                        ;809812;7F1F1C; 
                       CMP.B #$11                           ;809816;      ; 
                       BCC CODE_80981D                      ;809818;80981D; 
                       JMP.W CODE_8098A8                    ;80981A;8098A8; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80981D: LDA.B #$58                           ;80981D;      ; 
                       STA.B !tilemap_to_load                            ;80981F;000022; 
                       JSL.L TilemapManager           ;809821;80A7C6; 
                       JMP.W CODE_8098A8                    ;809825;8098A8; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809828: %Set16bit(!M)                             ;809828;      ; 
                       LDA.W $0196                          ;80982A;000196; 
                       AND.W #$0008                         ;80982D;      ; 
                       BEQ CODE_8098A8                      ;809830;8098A8; 
                       %Set8bit(!M)                             ;809832;      ; 
                       LDA.B #$59                           ;809834;      ; 
                       STA.B !tilemap_to_load                            ;809836;000022; 
                       JSL.L TilemapManager           ;809838;80A7C6; 
                       %Set16bit(!M)                             ;80983C;      ; 
                       %Set8bit(!X)                             ;80983E;      ; 
                       LDA.W #$B9EA                         ;809840;      ; 
                       STA.B $72                            ;809843;000072; 
                       %Set8bit(!M)                             ;809845;      ; 
                       LDA.B #$80                           ;809847;      ; 
                       STA.B $74                            ;809849;000074; 
                       %Set8bit(!M)                             ;80984B;      ; 
                       LDA.B #$0C                           ;80984D;      ; 
                       LDX.B #$00                           ;80984F;      ; 
                       LDY.B #$00                           ;809851;      ; 
                       JSL.L UNK_MemoryWork42_44            ;809853;808E48; 
                       %Set16bit(!M)                             ;809857;      ; 
                       %Set8bit(!X)                             ;809859;      ; 
                       LDA.W #$B9EF                         ;80985B;      ; 
                       STA.B $72                            ;80985E;000072; 
                       %Set8bit(!M)                             ;809860;      ; 
                       LDA.B #$80                           ;809862;      ; 
                       STA.B $74                            ;809864;000074; 
                       %Set8bit(!M)                             ;809866;      ; 
                       LDA.B #$0D                           ;809868;      ; 
                       LDX.B #$01                           ;80986A;      ; 
                       LDY.B #$00                           ;80986C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80986E;808E48; 
                       %Set16bit(!M)                             ;809872;      ; 
                       %Set8bit(!X)                             ;809874;      ; 
                       LDA.W #$B9F2                         ;809876;      ; 
                       STA.B $72                            ;809879;000072; 
                       %Set8bit(!M)                             ;80987B;      ; 
                       LDA.B #$80                           ;80987D;      ; 
                       STA.B $74                            ;80987F;000074; 
                       %Set8bit(!M)                             ;809881;      ; 
                       LDA.B #$0E                           ;809883;      ; 
                       LDX.B #$02                           ;809885;      ; 
                       LDY.B #$00                           ;809887;      ; 
                       JSL.L UNK_MemoryWork42_44            ;809889;808E48; 
                       %Set16bit(!M)                             ;80988D;      ; 
                       %Set8bit(!X)                             ;80988F;      ; 
                       LDA.W #$B9F5                         ;809891;      ; 
                       STA.B $72                            ;809894;000072; 
                       %Set8bit(!M)                             ;809896;      ; 
                       LDA.B #$80                           ;809898;      ; 
                       STA.B $74                            ;80989A;000074; 
                       %Set8bit(!M)                             ;80989C;      ; 
                       LDA.B #$0F                           ;80989E;      ; 
                       LDX.B #$03                           ;8098A0;      ; 
                       LDY.B #$00                           ;8098A2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;8098A4;808E48; 
                                                            ;      ;      ; 
          CODE_8098A8: JSL.L CODE_8392BB                    ;8098A8;8392BB; 
                       %Set8bit(!M)                             ;8098AC;      ; 
                       PLA                                  ;8098AE;      ; 
                       STA.B !tilemap_to_load                            ;8098AF;000022; 
                       JSL.L BSSSS                          ;8098B1;82A5FB; 
                       JSL.L TilemapManager           ;8098B5;80A7C6; 
                       JSL.L FFFF                           ;8098B9;8092E2; 
                       JSL.L EEEE                           ;8098BD;809329; 
                       JSL.L A8888                           ;8098C1;809553; 
                       JSL.L GGGG                           ;8098C5;809241; 
                       JSL.L UNK_BigLoop                    ;8098C9;808E69; 
                       %Set8bit(!M)                             ;8098CD;      ; 
                       %Set16bit(!X)                             ;8098CF;      ; 
                       LDA.B #$00                           ;8098D1;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;8098D3;000027; 
                       LDA.B #$22                           ;8098D5;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;8098D7;000029; 
                       %Set16bit(!M)                             ;8098D9;      ; 
                       LDY.W #$0200                         ;8098DB;      ; 
                       LDX.W #$0000                         ;8098DE;      ; 
                       LDA.W #$0900                         ;8098E1;      ; 
                       STA.B $72                            ;8098E4;000072; 
                       %Set8bit(!M)                             ;8098E6;      ; 
                       LDA.B #$7F                           ;8098E8;      ; 
                       STA.B $74                            ;8098EA;000074; 
                       JSL.L AddProgrammedDMA                ;8098EC;808A33; 
                       JSL.L StartLastPreparedDMA               ;8098F0;808AB2; 
                       %Set16bit(!MX)                             ;8098F4;      ; 
                       STZ.B $1E                            ;8098F6;00001E; 
                       LDA.B !OBJ_Offset_X                            ;8098F8;0000F5; 
                       STA.W !BG2_Map_Offset_X                          ;8098FA;000140; 
                       LDA.B !OBJ_Offset_Y                           ;8098FD;0000F7; 
                       STA.W !BG2_Map_Offset_Y                          ;8098FF;000142; 
                       %Set8bit(!M)                             ;809902;      ; 
                       LDA.B !tilemap_to_load                            ;809904;000022; 
                       CMP.B #$26                           ;809906;      ; 
                       BNE CODE_809912                      ;809908;809912; 
                       %Set16bit(!M)                             ;80990A;      ; 
                       LDA.W #$0100                         ;80990C;      ; 
                       STA.W !BG2_Map_Offset_Y                          ;80990F;000142; 
                                                            ;      ;      ; 
          CODE_809912: %Set8bit(!M)                             ;809912;      ; 
                       STZ.W $091C                          ;809914;00091C; 
                       %Set16bit(!M)                             ;809917;      ; 
                       LDA.L $7F1F5A                        ;809919;7F1F5A; 
                       AND.W #$FDFF                         ;80991D;      ; 
                       STA.L $7F1F5A                        ;809920;7F1F5A; 
                       LDA.W #$0000                         ;809924;      ; 
                       STA.L $7F1F7A                        ;809927;7F1F7A; 
                       STZ.W $0878                          ;80992B;000878; 
                       LDA.B !player_pos_X                           ;80992E;0000D6; 
                       STA.W $0907                          ;809930;000907; 
                       LDA.B !player_pos_Y                            ;809933;0000D8; 
                       STA.W $0909                          ;809935;000909; 
                       %Set8bit(!M)                             ;809938;      ; 
                       STZ.W $098A                          ;80993A;00098A; 
                       STZ.W $0919                          ;80993D;000919; 
                       %Set16bit(!MX)                             ;809940;      ; 
                       LDA.W #$0080                         ;809942;      ; 
                       EOR.W #$FFFF                         ;809945;      ; 
                       AND.B $D2                            ;809948;0000D2; 
                       STA.B $D2                            ;80994A;0000D2; 
                       %Set16bit(!M)                             ;80994C;      ; 
                       STZ.W $08FD                          ;80994E;0008FD; 
                       STZ.W $08FF                          ;809951;0008FF; 
                       %Set16bit(!MX)                             ;809954;      ; 
                       LDA.W #$1000                         ;809956;      ; 
                       EOR.W #$FFFF                         ;809959;      ; 
                       AND.B $D2                            ;80995C;0000D2; 
                       STA.B $D2                            ;80995E;0000D2; 
                       %Set8bit(!M)                             ;809960;      ; 
                       LDA.W !item_on_hand                          ;809962;00091D; 
                       BEQ CODE_8099BC                      ;809965;8099BC; 
                       CMP.B #$0D                           ;809967;      ; 
                       BEQ CODE_8099B1                      ;809969;8099B1; 
                       CMP.B #$0E                           ;80996B;      ; 
                       BEQ CODE_8099B1                      ;80996D;8099B1; 
                       CMP.B #$0F                           ;80996F;      ; 
                       BEQ CODE_8099B1                      ;809971;8099B1; 
                       CMP.B #$57                           ;809973;      ; 
                       BEQ CODE_8099B1                      ;809975;8099B1; 
                       STA.W $0984                          ;809977;000984; 
                       %Set16bit(!M)                             ;80997A;      ; 
                       LDY.W #$0001                         ;80997C;      ; 
                       JSL.L ALLLL                          ;80997F;8180B7; 
                       LDA.W $090B                          ;809983;00090B; 
                       STA.W $0980                          ;809986;000980; 
                       LDA.W $090D                          ;809989;00090D; 
                       STA.W $0982                          ;80998C;000982; 
                       %Set8bit(!M)                             ;80998F;      ; 
                       LDA.B #$01                           ;809991;      ; 
                       STA.W $0974                          ;809993;000974; 
                       LDA.B #$01                           ;809996;      ; 
                       STA.W $0975                          ;809998;000975; 
                       LDA.B #$02                           ;80999B;      ; 
                       STA.W $0976                          ;80999D;000976; 
                       JSL.L CODE_81A500                    ;8099A0;81A500; 
                       %Set16bit(!MX)                             ;8099A4;      ; 
                       LDA.W #$0014                         ;8099A6;      ; 
                       CLC                                  ;8099A9;      ; 
                       ADC.B $DA                            ;8099AA;0000DA; 
                       STA.W $0901                          ;8099AC;000901; 
                       BRA CODE_8099CD                      ;8099AF;8099CD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_8099B1: %Set16bit(!MX)                             ;8099B1;      ; 
                       LDA.W #$0000                         ;8099B3;      ; 
                       CLC                                  ;8099B6;      ; 
                       ADC.B $DA                            ;8099B7;0000DA; 
                       STA.W $0901                          ;8099B9;000901; 
                                                            ;      ;      ; 
          CODE_8099BC: %Set8bit(!M)                             ;8099BC;      ; 
                       STZ.W !item_on_hand                          ;8099BE;00091D; 
                       %Set16bit(!MX)                             ;8099C1;      ; 
                       LDA.W #$0002                         ;8099C3;      ; 
                       EOR.W #$FFFF                         ;8099C6;      ; 
                       AND.B $D2                            ;8099C9;0000D2; 
                       STA.B $D2                            ;8099CB;0000D2; 
                                                            ;      ;      ; 
          CODE_8099CD: JSL.L CODE_81CFA0                    ;8099CD;81CFA0; 
                       JSL.L BEEEE                          ;8099D1;81BFB7; 
                       %Set16bit(!MX)                             ;8099D5;      ; 
                       LDA.L $7F1F5E                        ;8099D7;7F1F5E; 
                       AND.W #$0002                         ;8099DB;      ; 
                       BNE CODE_8099E4                      ;8099DE;8099E4; 
                       JSL.L CODE_83C296                    ;8099E0;83C296; 
                                                            ;      ;      ; 
          CODE_8099E4: %Set16bit(!MX)                             ;8099E4;      ; 
                       LDA.W #$0000                         ;8099E6;      ; 
                       STA.B !player_action                            ;8099E9;0000D4; 
                       JSL.L UNK_Audio21                    ;8099EB;83841F; 
                       JSL.L UNK_Audio20                    ;8099EF;8383A4; 
                       JSL.L UNK_Audio22                    ;8099F3;838380; 
                       JSL.L AEEEE                          ;8099F7;828FF3; 
                       %Set8bit(!M)                             ;8099FB;      ; 
                       LDA.W $0110                          ;8099FD;000110; 
                       STA.W $0117                          ;809A00;000117; 
                       JSL.L WaitForNMI               ;809A03;808645; 
                       %Set16bit(!M)                             ;809A07;      ; 
                       LDA.W #$1800                         ;809A09;      ; 
                       STA.B $C7                            ;809A0C;0000C7; 
                       JSL.L BAAAA                          ;809A0E;81A383; 
                       JSL.L CODE_84816F                    ;809A12;84816F; 
                       JSL.L CODE_8582C7                    ;809A16;8582C7; 
                       JSL.L CODE_858CB2                    ;809A1A;858CB2; 
                       JSL.L UNK_BigLoadLoopOAM             ;809A1E;8583E0; 
                       %Set8bit(!M)                             ;809A22;      ; 
                       STZ.B !NMI_Status                            ;809A24;000000; 
                       JSL.L WaitForNMI               ;809A26;808645; 
                       %Set16bit(!M)                             ;809A2A;      ; 
                       LDA.W #$1800                         ;809A2C;      ; 
                       STA.B $C7                            ;809A2F;0000C7; 
                       JSL.L BAAAA                          ;809A31;81A383; 
                       JSL.L CODE_84816F                    ;809A35;84816F; 
                       JSL.L CODE_8582C7                    ;809A39;8582C7; 
                       JSL.L CODE_858CB2                    ;809A3D;858CB2; 
                       JSL.L UNK_BigLoadLoopOAM             ;809A41;8583E0; 
                       %Set8bit(!M)                             ;809A45;      ; 
                       STZ.B !NMI_Status                            ;809A47;000000; 
                       JSL.L WaitForNMI               ;809A49;808645; 
                       JSL.L ResetForceBlank                ;809A4D;808E1E; 
                       %Set8bit(!M)                             ;809A51;      ; 
                       LDA.B #$03                           ;809A53;      ; 
                       STA.B $92                            ;809A55;000092; 
                       LDA.B #$03                           ;809A57;      ; 
                       STA.B $93                            ;809A59;000093; 
                       LDA.B #$0F                           ;809A5B;      ; 
                       STA.B $94                            ;809A5D;000094; 
                       JSL.L ScreenFadein                         ;809A5F;8087CE; 
                       RTL                                  ;809A63;      ;END_A5555
                                                            ;      ;      ; 
                                                            ;      ;      ; 
A4444:
%Set16bit(!MX)                             ;809A64;      ;Gigant Switch
LDA.W $0878                          ;809A66;000878; 
CMP.W #$00C0                         ;809A69;      ; 
BCS .continue1                       ;809A6C;809A71;less than C0
JMP.W $9D0A                        ;809A6E;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
.continue1: CMP.W #$00D0                         ;809A71;      ; 
BCC .continue2                       ;809A74;809A79;bigger than D0
JMP.W A3333                           ;809A76;809D0B; 
                                ;      ;      ; 
                                ;      ;      ; 
.continue2: LDA.W $087A                          ;809A79;00087A; 
CMP.W #$00C0                         ;809A7C;      ; 
BCS .continue3                       ;809A7F;809A84;less than C0
JMP.W $9D0A                        ;809A81;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
.continue3: CMP.W #$00D0                         ;809A84;      ; 
BCC .continue4                       ;809A87;809A8C;bigger than D0
JMP.W A3333                           ;809A89;809D0B; 
                                ;      ;      ; 
                                ;      ;      ; 
.continue4: %Set16bit(!MX)                             ;809A8C;      ; 
LDA.B $D2                            ;809A8E;0000D2; 
AND.W #$0010                         ;809A90;      ; 
BEQ .continue5                       ;809A93;809A98; 
JMP.W $9D0A                        ;809A95;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
.continue5: %Set16bit(!M)                             ;809A98;      ; 
LDA.L $7F1F60                        ;809A9A;7F1F60; 
AND.W #$0006                         ;809A9E;      ; 
BEQ .continue6                       ;809AA1;809AA6; 
JMP.W $9D0A                        ;809AA3;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
.continue6: %Set16bit(!M)                             ;809AA6;      ; 
LDA.L $7F1F6C                        ;809AA8;7F1F6C; 
AND.W #$0001                         ;809AAC;      ; 
BEQ .skip1                           ;809AAF;809AD3; 
%Set16bit(!M)                             ;809AB1;      ; 
LDA.W $0878                          ;809AB3;000878; 
ASL A                                ;809AB6;      ; 
ASL A                                ;809AB7;      ; 
TAY                                  ;809AB8;      ; 
%Set8bit(!M)                             ;809AB9;      ; 
LDA.B #$00                           ;809ABB;      ; 
XBA                                  ;809ABD;      ; 
LDA.B [$0D],Y                        ;809ABE;00000D; 
%Set16bit(!M)                             ;809AC0;      ; 
ASL A                                ;809AC2;      ; 
ASL A                                ;809AC3;      ; 
ASL A                                ;809AC4;      ; 
TAX                                  ;809AC5;      ; 
%Set8bit(!M)                             ;809AC6;      ; 
LDA.L Unk_Table13,X                  ;809AC8;80B6F5; 
CMP.B #$1C                           ;809ACC;      ; 
BNE .skip1                           ;809ACE;809AD3; 
JMP.W $9D0A                        ;809AD0;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
.skip1: %Set16bit(!MX)                             ;809AD3;      ; 
LDA.W #$0000                         ;809AD5;      ; 
STA.B !player_action                            ;809AD8;0000D4; 
%Set16bit(!MX)                             ;809ADA;      ; 
LDA.B $D2                            ;809ADC;0000D2; 
ORA.W #$0080                         ;809ADE;      ; 
STA.B $D2                            ;809AE1;0000D2; 
%Set8bit(!M)                             ;809AE3;      ; 
LDA.W $098A                          ;809AE5;00098A; 
CMP.B #$01                           ;809AE8;      ; 
BNE CODE_809AEF                      ;809AEA;809AEF; 
JMP.W CODE_809C5D                    ;809AEC;809C5D; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809AEF: CMP.B #$02                           ;809AEF;      ; 
BCC CODE_809AF6                      ;809AF1;809AF6; 
JMP.W CODE_809C67                    ;809AF3;809C67; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809AF6: INC A                                ;809AF6;      ; 
STA.W $098A                          ;809AF7;00098A; 
%Set16bit(!M)                             ;809AFA;      ; 
LDA.W $0878                          ;809AFC;000878; 
                                ;      ;      ; 
CODE_809AFF: ASL A                                ;809AFF;      ; 
ASL A                                ;809B00;      ; 
TAY                                  ;809B01;      ; 
%Set8bit(!M)                             ;809B02;      ; 
LDA.B #$00                           ;809B04;      ; 
XBA                                  ;809B06;      ; 
LDA.B [$0D],Y                        ;809B07;00000D; 
%Set16bit(!M)                             ;809B09;      ; 
ASL A                                ;809B0B;      ; 
ASL A                                ;809B0C;      ; 
ASL A                                ;809B0D;      ; 
TAX                                  ;809B0E;      ; 
%Set8bit(!M)                             ;809B0F;      ; 
LDA.L Unk_Table13,X                  ;809B11;80B6F5; 
STA.W !transition_dest                          ;809B15;00098B; 
INX                                  ;809B18;      ; 
INX                                  ;809B19;      ; 
%Set8bit(!M)                             ;809B1A;      ; 
LDA.L Unk_Table13,X                  ;809B1C;80B6F5; 
STA.B $92                            ;809B20;000092; 
INX                                  ;809B22;      ; 
LDA.L Unk_Table13,X                  ;809B23;80B6F5; 
AND.B #$01                           ;809B27;      ; 
BEQ CODE_809B36                      ;809B29;809B36; 
LDA.W !transition_dest                          ;809B2B;00098B; 
CLC                                  ;809B2E;      ; 
ADC.L !season                        ;809B2F;7F1F19; 
STA.W !transition_dest                          ;809B33;00098B; 
                                ;      ;      ; 
CODE_809B36: %Set8bit(!M)                             ;809B36;      ; 
LDA.L Unk_Table13,X                  ;809B38;80B6F5; 
AND.B #$40                           ;809B3C;      ; 
BEQ CODE_809B7D                      ;809B3E;809B7D; 
LDA.L !day                        ;809B40;7F1F1B; 
CMP.B #$01                           ;809B44;      ; 
BEQ CODE_809B5F                      ;809B46;809B5F; 
CMP.B #$18                           ;809B48;      ; 
BEQ CODE_809B6E                      ;809B4A;809B6E; 
CMP.B #$0A                           ;809B4C;      ; 
BCC CODE_809B7D                      ;809B4E;809B7D; 
CMP.B #$0D                           ;809B50;      ; 
BCS CODE_809B7D                      ;809B52;809B7D; 
LDA.W !transition_dest                          ;809B54;00098B; 
CLC                                  ;809B57;      ; 
ADC.B #$04                           ;809B58;      ; 
STA.W !transition_dest                          ;809B5A;00098B; 
BRA CODE_809B7D                      ;809B5D;809B7D; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809B5F: %Set8bit(!M)                             ;809B5F;      ; 
LDA.L !season                        ;809B61;7F1F19; 
BNE CODE_809B7D                      ;809B65;809B7D; 
LDA.B #$3A                           ;809B67;      ; 
STA.W !transition_dest                          ;809B69;00098B; 
BRA CODE_809B7D                      ;809B6C;809B7D; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809B6E: %Set8bit(!M)                             ;809B6E;      ; 
LDA.L !season                        ;809B70;7F1F19; 
CMP.B #$03                           ;809B74;      ; 
BNE CODE_809B7D                      ;809B76;809B7D; 
LDA.B #$39                           ;809B78;      ; 
STA.W !transition_dest                          ;809B7A;00098B; 
                                ;      ;      ; 
CODE_809B7D: %Set8bit(!M)                             ;809B7D;      ; 
LDA.B !tilemap_to_load                            ;809B7F;000022; 
CMP.B #$0B                           ;809B81;      ; 
BNE CODE_809B88                      ;809B83;809B88; 
JMP.W CODE_809C14                    ;809B85;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809B88: LDA.L Unk_Table13,X                  ;809B88;80B6F5; 
AND.B #$02                           ;809B8C;      ; 
BEQ CODE_809B9A                      ;809B8E;809B9A; 
LDA.L !hour                        ;809B90;7F1F1C; 
CMP.B #$11                           ;809B94;      ; 
BCC CODE_809B9A                      ;809B96;809B9A; 
BRA CODE_809C14                      ;809B98;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809B9A: %Set8bit(!M)                             ;809B9A;      ; 
LDA.L Unk_Table13,X                  ;809B9C;80B6F5; 
AND.B #$04                           ;809BA0;      ; 
BEQ CODE_809BAE                      ;809BA2;809BAE; 
LDA.L !hour                        ;809BA4;7F1F1C; 
CMP.B #$11                           ;809BA8;      ; 
BCS CODE_809BAE                      ;809BAA;809BAE; 
BRA CODE_809C14                      ;809BAC;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809BAE: %Set8bit(!M)                             ;809BAE;      ; 
LDA.L Unk_Table13,X                  ;809BB0;80B6F5; 
AND.B #$08                           ;809BB4;      ; 
BEQ CODE_809BC4                      ;809BB6;809BC4; 
LDA.L !weekday                        ;809BB8;7F1F1A; 
BEQ CODE_809BC4                      ;809BBC;809BC4; 
CMP.B #$06                           ;809BBE;      ; 
BEQ CODE_809BC4                      ;809BC0;809BC4; 
BRA CODE_809C14                      ;809BC2;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809BC4: %Set8bit(!M)                             ;809BC4;      ; 
LDA.L Unk_Table13,X                  ;809BC6;80B6F5; 
AND.B #$10                           ;809BCA;      ; 
BEQ CODE_809BEC                      ;809BCC;809BEC; 
LDA.L !season                        ;809BCE;7F1F19; 
CMP.B #$03                           ;809BD2;      ; 
BNE CODE_809BE0                      ;809BD4;809BE0; 
LDA.L !day                        ;809BD6;7F1F1B; 
CMP.B #$0A                           ;809BDA;      ; 
BNE CODE_809BE0                      ;809BDC;809BE0; 
BRA CODE_809C14                      ;809BDE;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809BE0: %Set8bit(!M)                             ;809BE0;      ; 
LDA.L !weekday                        ;809BE2;7F1F1A; 
CMP.B #$06                           ;809BE6;      ; 
BNE CODE_809BEC                      ;809BE8;809BEC; 
BRA CODE_809C14                      ;809BEA;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809BEC: %Set8bit(!M)                             ;809BEC;      ; 
LDA.L Unk_Table13,X                  ;809BEE;80B6F5; 
AND.B #$20                           ;809BF2;      ; 
BEQ CODE_809BFE                      ;809BF4;809BFE; 
LDA.L !weekday                        ;809BF6;7F1F1A; 
BNE CODE_809BFE                      ;809BFA;809BFE; 
BRA CODE_809C14                      ;809BFC;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809BFE: %Set8bit(!M)                             ;809BFE;      ; 
LDA.L Unk_Table13,X                  ;809C00;80B6F5; 
AND.B #$80                           ;809C04;      ; 
BEQ CODE_809C30                      ;809C06;809C30; 
%Set16bit(!M)                             ;809C08;      ; 
LDA.W $0196                          ;809C0A;000196; 
AND.W #$0010                         ;809C0D;      ; 
BEQ CODE_809C30                      ;809C10;809C30; 
BRA CODE_809C14                      ;809C12;809C14; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809C14: %Set16bit(!MX)                             ;809C14;      ; 
LDA.W #$0080                         ;809C16;      ; 
EOR.W #$FFFF                         ;809C19;      ; 
AND.B $D2                            ;809C1C;0000D2; 
STA.B $D2                            ;809C1E;0000D2; 
%Set16bit(!M)                             ;809C20;      ; 
STZ.W $0878                          ;809C22;000878; 
STZ.W $087A                          ;809C25;00087A; 
%Set8bit(!M)                             ;809C28;      ; 
STZ.W $098A                          ;809C2A;00098A; 
JMP.W $9D0A                        ;809C2D;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809C30: %Set8bit(!M)                             ;809C30;      ; 
STZ.W !time_running                          ;809C32;000973; 
INX                                  ;809C35;      ; 
%Set16bit(!M)                             ;809C36;      ; 
LDA.L Unk_Table13,X                  ;809C38;80B6F5; 
STA.W !transition_dest_X                          ;809C3C;00017D; 
INX                                  ;809C3F;      ; 
INX                                  ;809C40;      ; 
LDA.L Unk_Table13,X                  ;809C41;80B6F5; 
STA.W !transition_dest_Y                          ;809C45;00017F; 
%Set8bit(!M)                             ;809C48;      ; 
LDA.B #$00                           ;809C4A;      ; 
XBA                                  ;809C4C;      ; 
LDA.B $92                            ;809C4D;000092; 
CMP.B #$00                           ;809C4F;      ; 
BNE CODE_809C56                      ;809C51;809C56; 
JMP.W $9D0A                        ;809C53;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809C56: JSL.L CODE_81A5E1                    ;809C56;81A5E1; 
JMP.W $9D0A                        ;809C5A;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809C5D: %Set16bit(!M)                             ;809C5D;      ; 
LDA.W $00CF                          ;809C5F;0000CF; 
BEQ CODE_809C67                      ;809C62;809C67; 
JMP.W $9D0A                        ;809C64;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809C67: %Set8bit(!M)                             ;809C67;      ; 
LDA.W $098A                          ;809C69;00098A; 
CMP.B #$0D                           ;809C6C;      ; 
BEQ CODE_809CD3                      ;809C6E;809CD3; 
INC A                                ;809C70;      ; 
STA.W $098A                          ;809C71;00098A; 
%Set16bit(!MX)                             ;809C74;      ; 
LDA.W #$0001                         ;809C76;      ; 
STA.B !player_action                            ;809C79;0000D4; 
%Set16bit(!M)                             ;809C7B;      ; 
LDA.B $DA                            ;809C7D;0000DA; 
CMP.W #$0000                         ;809C7F;      ; 
BEQ CODE_809CA0                      ;809C82;809CA0; 
CMP.W #$0001                         ;809C84;      ; 
BEQ CODE_809CB1                      ;809C87;809CB1; 
CMP.W #$0002                         ;809C89;      ; 
BEQ CODE_809CC2                      ;809C8C;809CC2; 
%Set16bit(!MX)                             ;809C8E;      ; 
LDA.W #$0003                         ;809C90;      ; 
STA.B $DA                            ;809C93;0000DA; 
%Set16bit(!MX)                             ;809C95;      ; 
LDA.W #$0003                         ;809C97;      ; 
STA.W $0911                          ;809C9A;000911; 
JMP.W $9D0A                        ;809C9D;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809CA0: %Set16bit(!MX)                             ;809CA0;      ; 
LDA.W #$0000                         ;809CA2;      ; 
STA.B $DA                            ;809CA5;0000DA; 
%Set16bit(!MX)                             ;809CA7;      ; 
LDA.W #$0000                         ;809CA9;      ; 
STA.W $0911                          ;809CAC;000911; 
BRA $59                          ;809CAF;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809CB1: %Set16bit(!MX)                             ;809CB1;      ; 
LDA.W #$0001                         ;809CB3;      ; 
STA.B $DA                            ;809CB6;0000DA; 
%Set16bit(!MX)                             ;809CB8;      ; 
LDA.W #$0001                         ;809CBA;      ; 
STA.W $0911                          ;809CBD;000911; 
BRA $48                          ;809CC0;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809CC2: %Set16bit(!MX)                             ;809CC2;      ; 
LDA.W #$0002                         ;809CC4;      ; 
STA.B $DA                            ;809CC7;0000DA; 
%Set16bit(!MX)                             ;809CC9;      ; 
LDA.W #$0002                         ;809CCB;      ; 
STA.W $0911                          ;809CCE;000911; 
BRA $37                          ;809CD1;809D0A; 
                                ;      ;      ; 
                                ;      ;      ; 
CODE_809CD3: %Set8bit(!M)                             ;809CD3;      ; 
LDA.W $0022                          ;809CD5;000022; 
CMP.B #$04                           ;809CD8;      ; 
BCS CODE_809CE0                      ;809CDA;809CE0; 
JSL.L CIIII                          ;809CDC;82A682; 
                                ;      ;      ; 
CODE_809CE0: %Set8bit(!M)                             ;809CE0;      ; 
LDA.B !tilemap_to_load                            ;809CE2;000022; 
CMP.B #$0C                           ;809CE4;      ; 
BCC CODE_809CFF                      ;809CE6;809CFF; 
LDA.B !tilemap_to_load                            ;809CE8;000022; 
CMP.B #$10                           ;809CEA;      ; 
BCS CODE_809CFF                      ;809CEC;809CFF; 
LDA.L !hour                        ;809CEE;7F1F1C; 
CMP.B #$12                           ;809CF2;      ; 
BEQ CODE_809CFF                      ;809CF4;809CFF; 
INC A                                ;809CF6;      ; 
STA.L !hour                        ;809CF7;7F1F1C; 
JSL.L BHHHH                          ;809CFB;8280AA; 
                                ;      ;      ; 
CODE_809CFF: %Set16bit(!MX)                             ;809CFF;      ; 
LDA.W $0196                          ;809D01;000196; 
ORA.W #$4000                         ;809D04;      ; 
STA.W $0196                          ;809D07;000196;Stores to 196
                                ;      ;      ; 
RTL                                  ;809D0A;      ;END_A4444
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 A3333: %Set8bit(!M)                             ;809D0B;      ; 
                       %Set16bit(!X)                             ;809D0D;      ; 
                       LDA.B !tilemap_to_load                            ;809D0F;000022; 
                       CMP.B #$04                           ;809D11;      ; 
                       BCS CODE_809D18                      ;809D13;809D18; 
                       JMP.W $9EBB                          ;809D15;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D18: %Set8bit(!M)                             ;809D18;      ; 
                       LDA.B !tilemap_to_load                            ;809D1A;000022; 
                       CMP.B #$10                           ;809D1C;      ; 
                       BCS CODE_809D23                      ;809D1E;809D23; 
                       JMP.W $9EBB                          ;809D20;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D23: CMP.B #$14                           ;809D23;      ; 
                       BCC CODE_809D2A                      ;809D25;809D2A; 
                       JMP.W $9EBB                          ;809D27;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D2A: %Set16bit(!MX)                             ;809D2A;      ; 
                       LDA.W $0196                          ;809D2C;000196; 
                       AND.W #$001A                         ;809D2F;      ; 
                       BEQ CODE_809D37                      ;809D32;809D37; 
                       JMP.W $9EBB                          ;809D34;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D37: LDA.W $0878                          ;809D37;000878; 
                       CMP.W #$00F9                         ;809D3A;      ; 
                       BNE CODE_809D42                      ;809D3D;809D42; 
                       JMP.W CODE_809DFD                    ;809D3F;809DFD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D42: LDA.W $087A                          ;809D42;00087A; 
                       CMP.W #$00F9                         ;809D45;      ; 
                       BNE CODE_809D4D                      ;809D48;809D4D; 
                       JMP.W CODE_809DFD                    ;809D4A;809DFD; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D4D: LDA.W $0878                          ;809D4D;000878; 
                       CMP.W #$00FA                         ;809D50;      ; 
                       BNE CODE_809D58                      ;809D53;809D58; 
                       JMP.W CODE_809E3F                    ;809D55;809E3F; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D58: LDA.W $087A                          ;809D58;00087A; 
                       CMP.W #$00FA                         ;809D5B;      ; 
                       BNE CODE_809D63                      ;809D5E;809D63; 
                       JMP.W CODE_809E3F                    ;809D60;809E3F; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D63: LDA.W $0878                          ;809D63;000878; 
                       CMP.W #$00FB                         ;809D66;      ; 
                       BNE CODE_809D6E                      ;809D69;809D6E; 
                       JMP.W CODE_809E7D                    ;809D6B;809E7D; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D6E: LDA.W $087A                          ;809D6E;00087A; 
                       CMP.W #$00FB                         ;809D71;      ; 
                       BNE CODE_809D79                      ;809D74;809D79; 
                       JMP.W CODE_809E7D                    ;809D76;809E7D; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D79: %Set16bit(!M)                             ;809D79;      ; 
                       LDA.L $7F1F5A                        ;809D7B;7F1F5A; 
                       AND.W #$0200                         ;809D7F;      ; 
                       BNE CODE_809D87                      ;809D82;809D87; 
                       JMP.W $9EBB                          ;809D84;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D87: %Set16bit(!MX)                             ;809D87;      ; 
                       LDA.B $D2                            ;809D89;0000D2; 
                       AND.W #$0002                         ;809D8B;      ; 
                       BEQ CODE_809D93                      ;809D8E;809D93; 
                       JMP.W $9EBB                          ;809D90;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D93: %Set16bit(!MX)                             ;809D93;      ; 
                       LDA.B $D2                            ;809D95;0000D2; 
                       AND.W #$0010                         ;809D97;      ; 
                       BEQ CODE_809D9F                      ;809D9A;809D9F; 
                       JMP.W $9EBB                          ;809D9C;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809D9F: %Set16bit(!MX)                             ;809D9F;      ; 
                       LDA.B $D2                            ;809DA1;0000D2; 
                       AND.W #$0800                         ;809DA3;      ; 
                       BEQ CODE_809DAB                      ;809DA6;809DAB; 
                       JMP.W $9EBB                          ;809DA8;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DAB: %Set16bit(!M)                             ;809DAB;      ; 
                       LDA.W $0878                          ;809DAD;000878; 
                       CMP.W #$00F8                         ;809DB0;      ; 
                       BEQ CODE_809DB8                      ;809DB3;809DB8; 
                       JMP.W $9EBB                          ;809DB5;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DB8: LDA.W $087A                          ;809DB8;00087A; 
                       CMP.W #$00F8                         ;809DBB;      ; 
                       BEQ CODE_809DC3                      ;809DBE;809DC3; 
                       JMP.W $9EBB                          ;809DC0;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DC3: %Set16bit(!MX)                             ;809DC3;      ; 
                       LDA.B !player_action                            ;809DC5;0000D4; 
                       CMP.W #$0010                         ;809DC7;      ; 
                       BNE CODE_809DCF                      ;809DCA;809DCF; 
                       JMP.W $9EBB                          ;809DCC;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DCF: %Set16bit(!MX)                             ;809DCF;      ; 
                       LDA.B !player_action                            ;809DD1;0000D4; 
                       CMP.W #$0011                         ;809DD3;      ; 
                       BNE CODE_809DDB                      ;809DD6;809DDB; 
                       JMP.W $9EBB                          ;809DD8;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DDB: %Set16bit(!MX)                             ;809DDB;      ; 
                       LDA.B !player_action                            ;809DDD;0000D4; 
                       CMP.W #$0012                         ;809DDF;      ; 
                       BNE CODE_809DE7                      ;809DE2;809DE7; 
                       JMP.W $9EBB                          ;809DE4;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DE7: %Set16bit(!MX)                             ;809DE7;      ; 
                       LDA.B !player_action                            ;809DE9;0000D4; 
                       CMP.W #$0013                         ;809DEB;      ; 
                       BNE CODE_809DF3                      ;809DEE;809DF3; 
                       JMP.W $9EBB                          ;809DF0;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DF3: %Set16bit(!MX)                             ;809DF3;      ; 
                       LDA.W #$000F                         ;809DF5;      ; 
                       STA.B !player_action                            ;809DF8;0000D4; 
                       JMP.W $9EBB                          ;809DFA;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809DFD: %Set8bit(!M)                             ;809DFD;      ; 
                       %Set16bit(!X)                             ;809DFF;      ; 
                       LDA.L !season                        ;809E01;7F1F19; 
                       BEQ CODE_809E0A                      ;809E05;809E0A; 
                       JMP.W $9EBB                          ;809E07;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E0A: LDA.B #$10                           ;809E0A;      ; 
                       JSL.L RNGReturn0toA                  ;809E0C;8089F9; 
                       BEQ CODE_809E15                      ;809E10;809E15; 
                       JMP.W $9EBB                          ;809E12;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E15: %Set16bit(!M)                             ;809E15;      ; 
                       LDA.L $7F1F5C                        ;809E17;7F1F5C; 
                       AND.W #$2000                         ;809E1B;      ; 
                       BEQ CODE_809E23                      ;809E1E;809E23; 
                       JMP.W $9EBB                          ;809E20;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E23: LDA.L $7F1F5C                        ;809E23;7F1F5C; 
                       ORA.W #$2000                         ;809E27;      ; 
                       STA.L $7F1F5C                        ;809E2A;7F1F5C; 
                       %Set16bit(!MX)                             ;809E2E;      ; 
                       LDA.W #$0011                         ;809E30;      ; 
                       LDX.W #$002C                         ;809E33;      ; 
                       LDY.W #$0000                         ;809E36;      ; 
                       JSL.L VIP                            ;809E39;848097; 
                       BRA $7C                              ;809E3D;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E3F: %Set8bit(!M)                             ;809E3F;      ; 
                       %Set16bit(!X)                             ;809E41;      ; 
                       LDA.L !season                        ;809E43;7F1F19; 
                       CMP.B #$02                           ;809E47;      ; 
                       BNE $70                              ;809E49;809EBB; 
                       LDA.B #$10                           ;809E4B;      ; 
                       JSL.L RNGReturn0toA                  ;809E4D;8089F9; 
                       BEQ CODE_809E56                      ;809E51;809E56; 
                       JMP.W $9EBB                          ;809E53;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E56: %Set16bit(!M)                             ;809E56;      ; 
                       LDA.L $7F1F5C                        ;809E58;7F1F5C; 
                       AND.W #$4000                         ;809E5C;      ; 
                       BNE $5A                              ;809E5F;809EBB; 
                       LDA.L $7F1F5C                        ;809E61;7F1F5C; 
                       ORA.W #$4000                         ;809E65;      ; 
                       STA.L $7F1F5C                        ;809E68;7F1F5C; 
                       %Set16bit(!MX)                             ;809E6C;      ; 
                       LDA.W #$0013                         ;809E6E;      ; 
                       LDX.W #$002B                         ;809E71;      ; 
                       LDY.W #$0000                         ;809E74;      ; 
                       JSL.L VIP                            ;809E77;848097; 
                       BRA $3E                              ;809E7B;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E7D: %Set8bit(!M)                             ;809E7D;      ; 
                       %Set16bit(!X)                             ;809E7F;      ; 
                       LDA.L !season                        ;809E81;7F1F19; 
                       CMP.B #$03                           ;809E85;      ; 
                       BNE !ProgDMA_Destination_Addr_Table                               ;809E87;809EBB; 
                       LDA.B #$10                           ;809E89;      ; 
                       JSL.L RNGReturn0toA                  ;809E8B;8089F9; 
                       BEQ CODE_809E94                      ;809E8F;809E94; 
                       JMP.W $9EBB                          ;809E91;809EBB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809E94: %Set16bit(!M)                             ;809E94;      ; 
                       LDA.L $7F1F5C                        ;809E96;7F1F5C; 
                       AND.W #$8000                         ;809E9A;      ; 
                       BNE $1C                              ;809E9D;809EBB; 
                       LDA.L $7F1F5C                        ;809E9F;7F1F5C; 
                       ORA.W #$8000                         ;809EA3;      ; 
                       STA.L $7F1F5C                        ;809EA6;7F1F5C; 
                       %Set16bit(!MX)                             ;809EAA;      ; 
                       LDA.W #$0012                         ;809EAC;      ; 
                       LDX.W #$002A                         ;809EAF;      ; 
                       LDY.W #$0000                         ;809EB2;      ; 
                       JSL.L VIP                            ;809EB5;848097; 
                       BRA !NMI_Status                              ;809EB9;809EBB; 
                                                            ;      ;      ; 
                       RTL                                  ;809EBB;      ;END_A3333
                                                            ;      ;      ; 
                                                            ;      ;      ; 
A2222: ;809EBC
        %Set16bit(!MX)                       
        LDA.B !player_pos_X                  
        SEC                                  
        SBC.W #$0080                         ;128
        CMP.B $ED                            
        BMI CODE_809ECC                      ;809EC6;809ECC; 
        BEQ CODE_809ECC                      ;809EC8;809ECC; 
        BCS CODE_809EE6                      ;809ECA;809EE6; 
                                ;      ;      ; 
        CODE_809ECC: %Set16bit(!M)                             ;809ECC;      ; 
        CLC                                  ;809ECE;      ; 
        ADC.W #$0080                         ;809ECF;      ; 
        SEC                                  ;809ED2;      ; 
        SBC.B $ED                            ;809ED3;0000ED; 
        STA.W $090B                          ;809ED5;00090B; 
        %Set8bit(!M)                             ;809ED8;      ; 
        LDA.B #$00                           ;809EDA;      ; 
        STA.B !BG_subpixel_offset_X                            ;809EDC;000020; 
        %Set16bit(!M)                             ;809EDE;      ; 
        LDA.B $ED                            ;809EE0;0000ED; 
        STA.B !OBJ_Offset_X                            ;809EE2;0000F5; 
        BRA CODE_809F0E                      ;809EE4;809F0E; 
                                ;      ;      ; 
                                ;      ;      ; 
        CODE_809EE6: %Set16bit(!M)                             ;809EE6;      ; 
        CMP.B $F1                            ;809EE8;0000F1; 
        BCS CODE_809EF6                      ;809EEA;809EF6; 
        STA.B !OBJ_Offset_X                            ;809EEC;0000F5; 
        LDA.W #$0080                         ;809EEE;      ; 
        STA.W $090B                          ;809EF1;00090B; 
        BRA CODE_809F0E                      ;809EF4;809F0E; 
                                ;      ;      ; 
                                ;      ;      ; 
        CODE_809EF6: %Set16bit(!M)                             ;809EF6;      ; 
        CLC                                  ;809EF8;      ; 
        ADC.W #$0080                         ;809EF9;      ; 
        SEC                                  ;809EFC;      ; 
        SBC.B $F1                            ;809EFD;0000F1; 
        STA.W $090B                          ;809EFF;00090B; 
        %Set8bit(!M)                             ;809F02;      ; 
        LDA.B #$08                           ;809F04;      ; 
        STA.B !BG_subpixel_offset_X                            ;809F06;000020; 
        %Set16bit(!M)                             ;809F08;      ; 
        LDA.B $F1                            ;809F0A;0000F1; 
        STA.B !OBJ_Offset_X                            ;809F0C;0000F5; 
                                ;      ;      ; 
        CODE_809F0E: %Set16bit(!M)                             ;809F0E;      ; 
        LDA.B !player_pos_Y                            ;809F10;0000D8; 
        SEC                                  ;809F12;      ; 
        SBC.W #$0080                         ;809F13;      ; 
        CMP.B $EF                            ;809F16;0000EF; 
        BMI .CODE_809F1E                      ;809F18;809F1E; 
        BEQ .CODE_809F1E                      ;809F1A;809F1E; 
        BCS .CODE_809F38                      ;809F1C;809F38; 
                                ;      ;      ; 
        .CODE_809F1E: %Set16bit(!M)                             ;809F1E;      ; 
        CLC                                  ;809F20;      ; 
        ADC.W #$0080                         ;809F21;      ; 
        SEC                                  ;809F24;      ; 
        SBC.B $EF                            ;809F25;0000EF; 
        STA.W $090D                          ;809F27;00090D; 
        %Set8bit(!M)                             ;809F2A;      ; 
        LDA.B #$00                           ;809F2C;      ; 
        STA.B !BG_subpixel_offset_Y                            ;809F2E;000021; 
        %Set16bit(!M)                             ;809F30;      ; 
        LDA.B $EF                            ;809F32;0000EF; 
        STA.B !OBJ_Offset_Y                           ;809F34;0000F7; 
        BRA .return                      ;809F36;809F60; 
                                ;      ;      ; 
                                ;      ;      ; 
        .CODE_809F38: %Set16bit(!M)                             ;809F38;      ; 
        CMP.B $F3                            ;809F3A;0000F3; 
        BCS .CODE_809F48                      ;809F3C;809F48; 
        STA.B !OBJ_Offset_Y                           ;809F3E;0000F7; 
        LDA.W #$0080                         ;809F40;      ; 
        STA.W $090D                          ;809F43;00090D; 
        BRA .return                      ;809F46;809F60; 
                                ;      ;      ; 
                                ;      ;      ; 
        .CODE_809F48: %Set16bit(!M)                             ;809F48;      ; 
        CLC                                  ;809F4A;      ; 
        ADC.W #$0080                         ;809F4B;      ; 
        SEC                                  ;809F4E;      ; 
        SBC.B $F3                            ;809F4F;0000F3; 
        STA.W $090D                          ;809F51;00090D; 
        %Set8bit(!M)                             ;809F54;      ; 
        LDA.B #$08                           ;809F56;      ; 
        STA.B !BG_subpixel_offset_Y                            ;809F58;000021; 
        %Set16bit(!M)                             ;809F5A;      ; 
        LDA.B $F3                            ;809F5C;0000F3; 
        STA.B !OBJ_Offset_Y                           ;809F5E;0000F7; 
                                ;      ;      ; 
        .return: RTL                                  ;809F60;      ;END_A2222
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                 A1111: %Set8bit(!M)                             ;809F61;      ; 
                       %Set16bit(!X)                             ;809F63;      ; 
                       LDA.B !tilemap_to_load                            ;809F65;000022; 
                       CMP.B #$26                           ;809F67;      ; 
                       BNE CODE_809F6E                      ;809F69;809F6E; 
                       JMP.W A1111return                        ;809F6B;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809F6E: CMP.B #$31                           ;809F6E;      ; 
                       BCC CODE_809FB3                      ;809F70;809FB3; 
                       %Set16bit(!M)                             ;809F72;      ; 
                       LDA.B !OBJ_Offset_Y                           ;809F74;0000F7; 
                       CMP.B $EF                            ;809F76;0000EF; 
                       BNE CODE_809F7D                      ;809F78;809F7D; 
                       JMP.W A1111return                        ;809F7A;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809F7D: CMP.B $F3                            ;809F7D;0000F3; 
                       BNE CODE_809F84                      ;809F7F;809F84; 
                       JMP.W A1111return                        ;809F81;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809F84: LDA.B !OBJ_Offset_X                            ;809F84;0000F5; 
                       STA.W !BG2_Map_Offset_X                          ;809F86;000140; 
                       LDA.B $1E                            ;809F89;00001E; 
                       ASL A                                ;809F8B;      ; 
                       STA.B $1E                            ;809F8C;00001E; 
                       %Set16bit(!MX)                             ;809F8E;      ; 
                       LDA.B $DA                            ;809F90;0000DA; 
                       CMP.W #$0002                         ;809F92;      ; 
                       BNE CODE_809F9A                      ;809F95;809F9A; 
                       JMP.W A1111return                        ;809F97;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809F9A: %Set16bit(!MX)                             ;809F9A;      ; 
                       LDA.B $DA                            ;809F9C;0000DA; 
                       CMP.W #$0003                         ;809F9E;      ; 
                       BNE CODE_809FA6                      ;809FA1;809FA6; 
                       JMP.W A1111return                        ;809FA3;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FA6: LDA.B !OBJ_Offset_Y                           ;809FA6;0000F7; 
                       LSR A                                ;809FA8;      ; 
                       CLC                                  ;809FA9;      ; 
                       ADC.W #$0080                         ;809FAA;      ; 
                       STA.W !BG2_Map_Offset_Y                          ;809FAD;000142; 
                       JMP.W A1111return                        ;809FB0;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FB3: %Set16bit(!MX)                             ;809FB3;      ; 
                       LDA.W $0196                          ;809FB5;000196; 
                       AND.W #$0002                         ;809FB8;      ; 
                       BEQ CODE_809FCA                      ;809FBB;809FCA; 
                       LDA.B !OBJ_Offset_X                            ;809FBD;0000F5; 
                       STA.W !BG2_Map_Offset_X                          ;809FBF;000140; 
                       LDA.B !OBJ_Offset_Y                           ;809FC2;0000F7; 
                       STA.W !BG2_Map_Offset_Y                          ;809FC4;000142; 
                       JMP.W A1111return                        ;809FC7;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FCA: %Set16bit(!MX)                             ;809FCA;      ; 
                       LDA.W $0196                          ;809FCC;000196; 
                       AND.W #$0004                         ;809FCF;      ; 
                       BNE CODE_809FD7                      ;809FD2;809FD7; 
                       JMP.W CODE_80A096                    ;809FD4;80A096; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FD7: %Set16bit(!MX)                             ;809FD7;      ; 
                       LDA.B $DA                            ;809FD9;0000DA; 
                       CMP.W #$0000                         ;809FDB;      ; 
                       BNE CODE_809FE3                      ;809FDE;809FE3; 
                       JMP.W CODE_80A033                    ;809FE0;80A033; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FE3: %Set16bit(!MX)                             ;809FE3;      ; 
                       LDA.B $DA                            ;809FE5;0000DA; 
                       CMP.W #$0001                         ;809FE7;      ; 
                       BNE CODE_809FEF                      ;809FEA;809FEF; 
                       JMP.W CODE_80A04A                    ;809FEC;80A04A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FEF: %Set16bit(!MX)                             ;809FEF;      ; 
                       LDA.B $DA                            ;809FF1;0000DA; 
                       CMP.W #$0002                         ;809FF3;      ; 
                       BNE CODE_809FFB                      ;809FF6;809FFB; 
                       JMP.W CODE_80A061                    ;809FF8;80A061; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_809FFB: %Set16bit(!MX)                             ;809FFB;      ; 
                       LDA.B $DA                            ;809FFD;0000DA; 
                       CMP.W #$0003                         ;809FFF;      ; 
                       BNE CODE_80A007                      ;80A002;80A007; 
                       JMP.W CODE_80A078                    ;80A004;80A078; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A007: %Set8bit(!M)                             ;80A007;      ; 
                       LDA.W $091C                          ;80A009;00091C; 
                       INC A                                ;80A00C;      ; 
                       STA.W $091C                          ;80A00D;00091C; 
                       CMP.B #$0A                           ;80A010;      ; 
                       BEQ CODE_80A017                      ;80A012;80A017; 
                       JMP.W A1111return                        ;80A014;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A017: STZ.W $091C                          ;80A017;00091C; 
                       %Set16bit(!M)                             ;80A01A;      ; 
                       LDA.W !BG2_Map_Offset_X                          ;80A01C;000140; 
                       CLC                                  ;80A01F;      ; 
                       ADC.W #$0001                         ;80A020;      ; 
                       STA.W !BG2_Map_Offset_X                          ;80A023;000140; 
                       LDA.W !BG2_Map_Offset_Y                          ;80A026;000142; 
                       SEC                                  ;80A029;      ; 
                       SBC.W #$0001                         ;80A02A;      ; 
                       STA.W !BG2_Map_Offset_Y                          ;80A02D;000142; 
                       JMP.W A1111return                        ;80A030;80A0AA; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A033: %Set16bit(!MX)                             ;80A033;      ; 
                       LDA.B !OBJ_Offset_Y                           ;80A035;0000F7; 
                       CMP.B $EF                            ;80A037;0000EF; 
                       BEQ CODE_80A007                      ;80A039;80A007; 
                       CMP.B $F3                            ;80A03B;0000F3; 
                       BEQ CODE_80A007                      ;80A03D;80A007; 
                       LDA.W !BG2_Map_Offset_Y                          ;80A03F;000142; 
                       CLC                                  ;80A042;      ; 
                       ADC.B $1E                            ;80A043;00001E; 
                       STA.W !BG2_Map_Offset_Y                          ;80A045;000142; 
                       BRA CODE_80A007                      ;80A048;80A007; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A04A: %Set16bit(!MX)                             ;80A04A;      ; 
                       LDA.B !OBJ_Offset_Y                           ;80A04C;0000F7; 
                       CMP.B $EF                            ;80A04E;0000EF; 
                       BEQ CODE_80A007                      ;80A050;80A007; 
                       CMP.B $F3                            ;80A052;0000F3; 
                       BEQ CODE_80A007                      ;80A054;80A007; 
                       LDA.W !BG2_Map_Offset_Y                          ;80A056;000142; 
                       SEC                                  ;80A059;      ; 
                       SBC.B $1E                            ;80A05A;00001E; 
                       STA.W !BG2_Map_Offset_Y                          ;80A05C;000142; 
                       BRA CODE_80A007                      ;80A05F;80A007; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A061: %Set16bit(!MX)                             ;80A061;      ; 
                       LDA.B !OBJ_Offset_X                            ;80A063;0000F5; 
                       CMP.B $ED                            ;80A065;0000ED; 
                       BEQ CODE_80A007                      ;80A067;80A007; 
                       CMP.B $F1                            ;80A069;0000F1; 
                       BEQ CODE_80A007                      ;80A06B;80A007; 
                       LDA.W !BG2_Map_Offset_X                          ;80A06D;000140; 
                       CLC                                  ;80A070;      ; 
                       ADC.B $1E                            ;80A071;00001E; 
                       STA.W !BG2_Map_Offset_X                          ;80A073;000140; 
                       BRA CODE_80A007                      ;80A076;80A007; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A078: %Set16bit(!MX)                             ;80A078;      ; 
                       LDA.B !OBJ_Offset_X                            ;80A07A;0000F5; 
                       CMP.B $ED                            ;80A07C;0000ED; 
                       BNE CODE_80A083                      ;80A07E;80A083; 
                       JMP.W CODE_80A007                    ;80A080;80A007; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A083: CMP.B $F1                            ;80A083;0000F1; 
                       BNE CODE_80A08A                      ;80A085;80A08A; 
                       JMP.W CODE_80A007                    ;80A087;80A007; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A08A: LDA.W !BG2_Map_Offset_X                          ;80A08A;000140; 
                       SEC                                  ;80A08D;      ; 
                       SBC.B $1E                            ;80A08E;00001E; 
                       STA.W !BG2_Map_Offset_X                          ;80A090;000140; 
                       JMP.W CODE_80A007                    ;80A093;80A007; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A096: %Set16bit(!MX)                             ;80A096;      ; 
                       LDA.W $0196                          ;80A098;000196; 
                       AND.W #$0008                         ;80A09B;      ; 
                       BEQ A1111return                          ;80A09E;80A0AA; 
                       LDA.B !OBJ_Offset_X                            ;80A0A0;0000F5; 
                       STA.W !BG2_Map_Offset_X                          ;80A0A2;000140; 
                       LDA.B !OBJ_Offset_Y                           ;80A0A5;0000F7; 
                       STA.W !BG2_Map_Offset_Y                          ;80A0A7;000142; 
                                                            ;      ;      ; 
              A1111return: RTL                                  ;80A0AA;      ;END_1111
                                                            ;      ;      ; 
                                                            ;      ;      ; 
UpdateBGOffset: ;80A0AB
        %Set16bit(!MX)                       
        LDA.B !OBJ_Offset_Y                  
        STA.W !BG1_Map_Offset_Y              
        CMP.B $EF                            
        BEQ .return                          
        CMP.B $F3                            
        BEQ .return                          
        CMP.B $1E                            
        BCS .bigger                          
        STA.B $1E                            

    .bigger:
        %Set16bit(!M)                        
        LDA.W $0196                          
        AND.W #$0001                         
        BEQ .return                          
        %Set8bit(!M)                         
        LDA.B !BG_subpixel_offset_Y          
        CLC                                  
        ADC.B $1E                            
        STA.B !BG_subpixel_offset_Y          
        CMP.B #$08                           
        BCC .return                          
        SEC                                  
        SBC.B #$08                           
        STA.B !BG_subpixel_offset_Y          
        JSL.L AQQQQ                          

    .return: RTL

                ATTTT: %Set16bit(!MX)                             ;80A0E1;      ; 
                       LDA.B !OBJ_Offset_Y                           ;80A0E3;0000F7; 
                       STA.W !BG1_Map_Offset_Y                          ;80A0E5;00013E; 
                       CMP.B $EF                            ;80A0E8;0000EF; 
                       BEQ $2F                              ;80A0EA;80A11B; 
                       CMP.B $F3                            ;80A0EC;0000F3; 
                       BEQ $2B                              ;80A0EE;80A11B; 
                       LDA.B $F3                            ;80A0F0;0000F3; 
                       SEC                                  ;80A0F2;      ; 
                       SBC.B !OBJ_Offset_Y                           ;80A0F3;0000F7; 
                       CMP.B $1E                            ;80A0F5;00001E; 
                       BCS CODE_80A0FB                      ;80A0F7;80A0FB; 
                       STA.B $1E                            ;80A0F9;00001E; 
                                                            ;      ;      ; 
          CODE_80A0FB: %Set16bit(!M)                             ;80A0FB;      ; 
                       LDA.W $0196                          ;80A0FD;000196; 
                       AND.W #$0001                         ;80A100;      ; 
                       BEQ $16                              ;80A103;80A11B; 
                       %Set8bit(!M)                             ;80A105;      ; 
                       LDA.B !BG_subpixel_offset_Y                            ;80A107;000021; 
                       SEC                                  ;80A109;      ; 
                       SBC.B $1E                            ;80A10A;00001E; 
                       STA.B !BG_subpixel_offset_Y                            ;80A10C;000021; 
                       BPL $0B                              ;80A10E;80A11B; 
                       LDA.B #$08                           ;80A110;      ; 
                       CLC                                  ;80A112;      ; 
                       ADC.B !BG_subpixel_offset_Y                            ;80A113;000021; 
                       STA.B !BG_subpixel_offset_Y                            ;80A115;000021; 
                       JSL.L APPPP                          ;80A117;80A308; 
                       RTL                                  ;80A11B;      ;END_ATTTT
                                                            ;      ;      ; 
                                                            ;      ;      ; 
UNK_StaticMapScroling: %Set16bit(!MX)                             ;80A11C;      ; 
                       LDA.B !OBJ_Offset_X                            ;80A11E;0000F5; 
                       STA.W !BG1_Map_Offset_X                          ;80A120;00013C; 
                       CMP.B $ED                            ;80A123;0000ED; 
                       BEQ CODE_80A151                      ;80A125;80A151; 
                       CMP.B $F1                            ;80A127;0000F1; 
                       BEQ CODE_80A151                      ;80A129;80A151; 
                       CMP.B $1E                            ;80A12B;00001E; 
                       BCS CODE_80A131                      ;80A12D;80A131; 
                       STA.B $1E                            ;80A12F;00001E; 
                                                            ;      ;      ; 
          CODE_80A131: %Set16bit(!M)                             ;80A131;      ; 
                       LDA.W $0196                          ;80A133;000196; 
                       AND.W #$0001                         ;80A136;      ; 
                       BEQ CODE_80A151                      ;80A139;80A151; 
                       %Set8bit(!M)                             ;80A13B;      ; 
                       LDA.B !BG_subpixel_offset_X                            ;80A13D;000020; 
                       CLC                                  ;80A13F;      ; 
                       ADC.B $1E                            ;80A140;00001E; 
                       STA.B !BG_subpixel_offset_X                            ;80A142;000020; 
                       CMP.B #$08                           ;80A144;      ; 
                       BCC CODE_80A151                      ;80A146;80A151; 
                       SEC                                  ;80A148;      ; 
                       SBC.B #$08                           ;80A149;      ; 
                       STA.B !BG_subpixel_offset_X                            ;80A14B;000020; 
                       JSL.L AOOOO                          ;80A14D;80A481; 
                                                            ;      ;      ; 
          CODE_80A151: RTL                                  ;80A151;      ;END_ASSSS
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                ARRRR: %Set16bit(!MX)                             ;80A152;      ; 
                       LDA.B !OBJ_Offset_X                            ;80A154;0000F5; 
                       STA.W !BG1_Map_Offset_X                          ;80A156;00013C; 
                       CMP.B $ED                            ;80A159;0000ED; 
                       BEQ CODE_80A18C                      ;80A15B;80A18C; 
                       CMP.B $F1                            ;80A15D;0000F1; 
                       BEQ CODE_80A18C                      ;80A15F;80A18C; 
                       LDA.B $F1                            ;80A161;0000F1; 
                       SEC                                  ;80A163;      ; 
                       SBC.B !OBJ_Offset_X                            ;80A164;0000F5; 
                       CMP.B $1E                            ;80A166;00001E; 
                       BCS CODE_80A16C                      ;80A168;80A16C; 
                       STA.B $1E                            ;80A16A;00001E; 
                                                            ;      ;      ; 
          CODE_80A16C: %Set16bit(!M)                             ;80A16C;      ; 
                       LDA.W $0196                          ;80A16E;000196; 
                       AND.W #$0001                         ;80A171;      ; 
                       BEQ CODE_80A18C                      ;80A174;80A18C; 
                       %Set8bit(!M)                             ;80A176;      ; 
                       LDA.B !BG_subpixel_offset_X                            ;80A178;000020; 
                       SEC                                  ;80A17A;      ; 
                       SBC.B $1E                            ;80A17B;00001E; 
                       STA.B !BG_subpixel_offset_X                            ;80A17D;000020; 
                       BPL CODE_80A18C                      ;80A17F;80A18C; 
                       LDA.B #$08                           ;80A181;      ; 
                       CLC                                  ;80A183;      ; 
                       ADC.B !BG_subpixel_offset_X                            ;80A184;000020; 
                       STA.B !BG_subpixel_offset_X                            ;80A186;000020; 
                       JSL.L CODE_80A617                    ;80A188;80A617; 
                                                            ;      ;      ; 
          CODE_80A18C: RTL                                  ;80A18C;      ;END_ARRRR
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                AQQQQ: %Set16bit(!MX)                             ;80A18D;      ;Some data copying?
                       LDA.B $12                            ;80A18F;000012; 
                       CMP.W #$0020                         ;80A191;      ; 
                       BCC CODE_80A1B1                      ;80A194;80A1B1; 
                       CMP.W #$0040                         ;80A196;      ; 
                       BCC CODE_80A1BB                      ;80A199;80A1BB; 
                       CMP.W #$0060                         ;80A19B;      ; 
                       BCC CODE_80A1CB                      ;80A19E;80A1CB; 
                       CMP.W #$0080                         ;80A1A0;      ; 
                       BCC CODE_80A1DB                      ;80A1A3;80A1DB; 
                       CMP.W #$00A0                         ;80A1A5;      ; 
                       BCC CODE_80A1EE                      ;80A1A8;80A1EE; 
                       CMP.W #$00C0                         ;80A1AA;      ; 
                       BCC CODE_80A201                      ;80A1AD;80A201; 
                       BRA CODE_80A21A                      ;80A1AF;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A1B1: STZ.B $7E                            ;80A1B1;00007E; 
                       STZ.B $80                            ;80A1B3;000080; 
                       STZ.B $82                            ;80A1B5;000082; 
                       STZ.B $84                            ;80A1B7;000084; 
                       BRA CODE_80A21A                      ;80A1B9;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A1BB: LDA.B $12                            ;80A1BB;000012; 
                       SEC                                  ;80A1BD;      ; 
                       SBC.W #$0020                         ;80A1BE;      ; 
                       STA.B $7E                            ;80A1C1;00007E; 
                       STA.B $80                            ;80A1C3;000080; 
                       STZ.B $82                            ;80A1C5;000082; 
                       STZ.B $84                            ;80A1C7;000084; 
                       BRA CODE_80A21A                      ;80A1C9;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A1CB: LDA.B $12                            ;80A1CB;000012; 
                       SEC                                  ;80A1CD;      ; 
                       SBC.W #$0020                         ;80A1CE;      ; 
                       STA.B $7E                            ;80A1D1;00007E; 
                       STA.B $80                            ;80A1D3;000080; 
                       STZ.B $82                            ;80A1D5;000082; 
                       STZ.B $84                            ;80A1D7;000084; 
                       BRA CODE_80A21A                      ;80A1D9;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A1DB: LDA.W #$0080                         ;80A1DB;      ; 
                       STA.B $7E                            ;80A1DE;00007E; 
                       STZ.B $80                            ;80A1E0;000080; 
                       LDA.B $12                            ;80A1E2;000012; 
                       SEC                                  ;80A1E4;      ; 
                       SBC.W #$0060                         ;80A1E5;      ; 
                       STA.B $82                            ;80A1E8;000082; 
                       STA.B $84                            ;80A1EA;000084; 
                       BRA CODE_80A21A                      ;80A1EC;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A1EE: LDA.W #$0080                         ;80A1EE;      ; 
                       STA.B $7E                            ;80A1F1;00007E; 
                       STZ.B $80                            ;80A1F3;000080; 
                       LDA.B $12                            ;80A1F5;000012; 
                       SEC                                  ;80A1F7;      ; 
                       SBC.W #$0060                         ;80A1F8;      ; 
                       STA.B $82                            ;80A1FB;000082; 
                       STA.B $84                            ;80A1FD;000084; 
                       BRA CODE_80A21A                      ;80A1FF;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A201: LDA.B $12                            ;80A201;000012; 
                       SEC                                  ;80A203;      ; 
                       SBC.W #$0020                         ;80A204;      ; 
                       STA.B $7E                            ;80A207;00007E; 
                       LDA.B $12                            ;80A209;000012; 
                       SEC                                  ;80A20B;      ; 
                       SBC.W #$00A0                         ;80A20C;      ; 
                       STA.B $80                            ;80A20F;000080; 
                       LDA.W #$0080                         ;80A211;      ; 
                       STA.B $82                            ;80A214;000082; 
                       STZ.B $84                            ;80A216;000084; 
                       BRA CODE_80A21A                      ;80A218;80A21A; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A21A: LDA.B $1C                            ;80A21A;00001C; 
                       LSR A                                ;80A21C;      ; 
                       LSR A                                ;80A21D;      ; 
                       STA.B $86                            ;80A21E;000086; 
                       LDA.W #$2000                         ;80A220;      ; 
                       CLC                                  ;80A223;      ; 
                       ADC.B $16                            ;80A224;000016; 
                       ADC.B $1C                            ;80A226;00001C; 
                       SEC                                  ;80A228;      ; 
                       SBC.B $86                            ;80A229;000086; 
                       STA.B $72                            ;80A22B;000072; 
                       CLC                                  ;80A22D;      ; 
                       ADC.W #$0040                         ;80A22E;      ; 
                       STA.B $75                            ;80A231;000075; 
                       %Set8bit(!M)                             ;80A233;      ; 
                       LDA.B #$7E                           ;80A235;      ; 
                       STA.B $74                            ;80A237;000074; 
                       STA.B $77                            ;80A239;000077; 
                       %Set16bit(!M)                             ;80A23B;      ; 
                       LDX.W #$0000                         ;80A23D;      ; 
                                                            ;      ;      ; 
          CODE_80A240: PHX                                  ;80A240;      ; 
                       LDA.B $80                            ;80A241;000080; 
                       CMP.W #$0040                         ;80A243;      ; 
                       BNE CODE_80A252                      ;80A246;80A252; 
                       STZ.B $80                            ;80A248;000080; 
                       LDA.B $7E                            ;80A24A;00007E; 
                       CLC                                  ;80A24C;      ; 
                       ADC.W #$0040                         ;80A24D;      ; 
                       STA.B $7E                            ;80A250;00007E; 
                                                            ;      ;      ; 
          CODE_80A252: LDA.B $84                            ;80A252;000084; 
                       CMP.W #$0040                         ;80A254;      ; 
                       BNE CODE_80A263                      ;80A257;80A263; 
                       STZ.B $84                            ;80A259;000084; 
                       LDA.B $82                            ;80A25B;000082; 
                       CLC                                  ;80A25D;      ; 
                       ADC.W #$0040                         ;80A25E;      ; 
                       STA.B $82                            ;80A261;000082; 
                                                            ;      ;      ; 
          CODE_80A263: LDY.B $7E                            ;80A263;00007E; 
                       LDX.B $80                            ;80A265;000080; 
                       LDA.B [$72],Y                        ;80A267;000072; 
                       STA.W $0746,X                        ;80A269;000746; 
                       LDY.B $82                            ;80A26C;000082; 
                       LDX.B $84                            ;80A26E;000084; 
                       LDA.B [$75],Y                        ;80A270;000075; 
                       STA.W $07C6,X                        ;80A272;0007C6; 
                       INC.B $7E                            ;80A275;00007E; 
                       INC.B $7E                            ;80A277;00007E; 
                       INC.B $80                            ;80A279;000080; 
                       INC.B $80                            ;80A27B;000080; 
                       INC.B $82                            ;80A27D;000082; 
                       INC.B $82                            ;80A27F;000082; 
                       INC.B $84                            ;80A281;000084; 
                       INC.B $84                            ;80A283;000084; 
                       PLX                                  ;80A285;      ; 
                       INX                                  ;80A286;      ; 
                       INX                                  ;80A287;      ; 
                       CPX.W #$0040                         ;80A288;      ; 
                       BNE CODE_80A240                      ;80A28B;80A240; 
                       %Set8bit(!M)                             ;80A28D;      ; 
                       LDA.B #$00                           ;80A28F;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A291;000027; 
                       LDA.B #$18                           ;80A293;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A295;000029; 
                       %Set16bit(!M)                             ;80A297;      ; 
                       LDY.W #$0040                         ;80A299;      ; 
                       LDA.B $14                            ;80A29C;000014; 
                       CLC                                  ;80A29E;      ; 
                       ADC.W #$6000                         ;80A29F;      ; 
                       TAX                                  ;80A2A2;      ; 
                       LDA.W #$0746                         ;80A2A3;      ; 
                       STA.B $72                            ;80A2A6;000072; 
                       %Set8bit(!M)                             ;80A2A8;      ; 
                       LDA.B #$80                           ;80A2AA;      ; 
                       STA.B $74                            ;80A2AC;000074; 
                       %Set16bit(!M)                             ;80A2AE;      ; 
                       LDA.W #$0080                         ;80A2B0;      ; 
                       JSL.L AddProgrammedDMA                ;80A2B3;808A33; 
                       %Set8bit(!M)                             ;80A2B7;      ; 
                       LDA.B #$01                           ;80A2B9;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A2BB;000027; 
                       LDA.B #$18                           ;80A2BD;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A2BF;000029; 
                       %Set16bit(!M)                             ;80A2C1;      ; 
                       LDY.W #$0040                         ;80A2C3;      ; 
                       LDA.B $14                            ;80A2C6;000014; 
                       CLC                                  ;80A2C8;      ; 
                       ADC.W #$6000                         ;80A2C9;      ; 
                       ADC.W #$0400                         ;80A2CC;      ; 
                       TAX                                  ;80A2CF;      ; 
                       LDA.W #$07C6                         ;80A2D0;      ; 
                       STA.B $72                            ;80A2D3;000072; 
                       %Set8bit(!M)                             ;80A2D5;      ; 
                       LDA.B #$80                           ;80A2D7;      ; 
                       STA.B $74                            ;80A2D9;000074; 
                       %Set16bit(!M)                             ;80A2DB;      ; 
                       LDA.W #$0080                         ;80A2DD;      ; 
                       JSL.L AddProgrammedDMA                ;80A2E0;808A33; 
                       %Set16bit(!MX)                             ;80A2E4;      ; 
                       LDA.B $16                            ;80A2E6;000016; 
                       CLC                                  ;80A2E8;      ; 
                       ADC.B $1A                            ;80A2E9;00001A; 
                       STA.B $16                            ;80A2EB;000016; 
                       LDA.B $14                            ;80A2ED;000014; 
                       CLC                                  ;80A2EF;      ; 
                       ADC.W #$0020                         ;80A2F0;      ; 
                       CMP.W #$0400                         ;80A2F3;      ; 
                       BNE CODE_80A2FD                      ;80A2F6;80A2FD; 
                       LDA.W #$0800                         ;80A2F8;      ; 
                       BRA CODE_80A305                      ;80A2FB;80A305; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A2FD: CMP.W #$0C00                         ;80A2FD;      ; 
                       BNE CODE_80A305                      ;80A300;80A305; 
                       LDA.W #$0000                         ;80A302;      ; 
                                                            ;      ;      ; 
          CODE_80A305: STA.B $14                            ;80A305;000014; 
                       RTL                                  ;80A307;      ;END_AQQQQ
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                APPPP: %Set16bit(!MX)                             ;80A308;      ; 
                       LDA.B $12                            ;80A30A;000012; 
                       CMP.W #$0020                         ;80A30C;      ; 
                       BCC CODE_80A32C                      ;80A30F;80A32C; 
                       CMP.W #$0040                         ;80A311;      ; 
                       BCC CODE_80A336                      ;80A314;80A336; 
                       CMP.W #$0060                         ;80A316;      ; 
                       BCC CODE_80A346                      ;80A319;80A346; 
                       CMP.W #$0080                         ;80A31B;      ; 
                       BCC CODE_80A356                      ;80A31E;80A356; 
                       CMP.W #$00A0                         ;80A320;      ; 
                       BCC CODE_80A369                      ;80A323;80A369; 
                       CMP.W #$00C0                         ;80A325;      ; 
                       BCC CODE_80A37C                      ;80A328;80A37C; 
                       BRA CODE_80A395                      ;80A32A;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A32C: STZ.B $7E                            ;80A32C;00007E; 
                       STZ.B $80                            ;80A32E;000080; 
                       STZ.B $82                            ;80A330;000082; 
                       STZ.B $84                            ;80A332;000084; 
                       BRA CODE_80A395                      ;80A334;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A336: LDA.B $12                            ;80A336;000012; 
                       SEC                                  ;80A338;      ; 
                       SBC.W #$0020                         ;80A339;      ; 
                       STA.B $7E                            ;80A33C;00007E; 
                       STA.B $80                            ;80A33E;000080; 
                       STZ.B $82                            ;80A340;000082; 
                       STZ.B $84                            ;80A342;000084; 
                       BRA CODE_80A395                      ;80A344;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A346: LDA.B $12                            ;80A346;000012; 
                       SEC                                  ;80A348;      ; 
                       SBC.W #$0020                         ;80A349;      ; 
                       STA.B $7E                            ;80A34C;00007E; 
                       STA.B $80                            ;80A34E;000080; 
                       STZ.B $82                            ;80A350;000082; 
                       STZ.B $84                            ;80A352;000084; 
                       BRA CODE_80A395                      ;80A354;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A356: LDA.W #$0080                         ;80A356;      ; 
                       STA.B $7E                            ;80A359;00007E; 
                       STZ.B $80                            ;80A35B;000080; 
                       LDA.B $12                            ;80A35D;000012; 
                       SEC                                  ;80A35F;      ; 
                       SBC.W #$0060                         ;80A360;      ; 
                       STA.B $82                            ;80A363;000082; 
                       STA.B $84                            ;80A365;000084; 
                       BRA CODE_80A395                      ;80A367;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A369: LDA.W #$0080                         ;80A369;      ; 
                       STA.B $7E                            ;80A36C;00007E; 
                       STZ.B $80                            ;80A36E;000080; 
                       LDA.B $12                            ;80A370;000012; 
                       SEC                                  ;80A372;      ; 
                       SBC.W #$0060                         ;80A373;      ; 
                       STA.B $82                            ;80A376;000082; 
                       STA.B $84                            ;80A378;000084; 
                       BRA CODE_80A395                      ;80A37A;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A37C: LDA.B $12                            ;80A37C;000012; 
                       SEC                                  ;80A37E;      ; 
                       SBC.W #$0020                         ;80A37F;      ; 
                       STA.B $7E                            ;80A382;00007E; 
                       LDA.B $12                            ;80A384;000012; 
                       SEC                                  ;80A386;      ; 
                       SBC.W #$00A0                         ;80A387;      ; 
                       STA.B $80                            ;80A38A;000080; 
                       LDA.W #$0080                         ;80A38C;      ; 
                       STA.B $82                            ;80A38F;000082; 
                       STZ.B $84                            ;80A391;000084; 
                       BRA CODE_80A395                      ;80A393;80A395; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A395: LDA.B $1C                            ;80A395;00001C; 
                       LSR A                                ;80A397;      ; 
                       LSR A                                ;80A398;      ; 
                       STA.B $86                            ;80A399;000086; 
                       LDA.W #$2000                         ;80A39B;      ; 
                       CLC                                  ;80A39E;      ; 
                       ADC.B $16                            ;80A39F;000016; 
                       SEC                                  ;80A3A1;      ; 
                       SBC.B $86                            ;80A3A2;000086; 
                       STA.B $72                            ;80A3A4;000072; 
                       CLC                                  ;80A3A6;      ; 
                       ADC.W #$0040                         ;80A3A7;      ; 
                       STA.B $75                            ;80A3AA;000075; 
                       %Set8bit(!M)                             ;80A3AC;      ; 
                       LDA.B #$7E                           ;80A3AE;      ; 
                       STA.B $74                            ;80A3B0;000074; 
                       STA.B $77                            ;80A3B2;000077; 
                       %Set16bit(!M)                             ;80A3B4;      ; 
                       LDX.W #$0000                         ;80A3B6;      ; 
                                                            ;      ;      ; 
          CODE_80A3B9: PHX                                  ;80A3B9;      ; 
                       LDA.B $80                            ;80A3BA;000080; 
                       CMP.W #$0040                         ;80A3BC;      ; 
                       BNE CODE_80A3CB                      ;80A3BF;80A3CB; 
                       STZ.B $80                            ;80A3C1;000080; 
                       LDA.B $7E                            ;80A3C3;00007E; 
                       CLC                                  ;80A3C5;      ; 
                       ADC.W #$0040                         ;80A3C6;      ; 
                       STA.B $7E                            ;80A3C9;00007E; 
                                                            ;      ;      ; 
          CODE_80A3CB: LDA.B $84                            ;80A3CB;000084; 
                       CMP.W #$0040                         ;80A3CD;      ; 
                       BNE CODE_80A3DC                      ;80A3D0;80A3DC; 
                       STZ.B $84                            ;80A3D2;000084; 
                       LDA.B $82                            ;80A3D4;000082; 
                       CLC                                  ;80A3D6;      ; 
                       ADC.W #$0040                         ;80A3D7;      ; 
                       STA.B $82                            ;80A3DA;000082; 
                                                            ;      ;      ; 
          CODE_80A3DC: LDY.B $7E                            ;80A3DC;00007E; 
                       LDX.B $80                            ;80A3DE;000080; 
                       LDA.B [$72],Y                        ;80A3E0;000072; 
                       STA.W $0746,X                        ;80A3E2;000746; 
                       LDY.B $82                            ;80A3E5;000082; 
                       LDX.B $84                            ;80A3E7;000084; 
                       LDA.B [$75],Y                        ;80A3E9;000075; 
                       STA.W $07C6,X                        ;80A3EB;0007C6; 
                       INC.B $7E                            ;80A3EE;00007E; 
                       INC.B $7E                            ;80A3F0;00007E; 
                       INC.B $80                            ;80A3F2;000080; 
                       INC.B $80                            ;80A3F4;000080; 
                       INC.B $82                            ;80A3F6;000082; 
                       INC.B $82                            ;80A3F8;000082; 
                       INC.B $84                            ;80A3FA;000084; 
                       INC.B $84                            ;80A3FC;000084; 
                       PLX                                  ;80A3FE;      ; 
                       INX                                  ;80A3FF;      ; 
                       INX                                  ;80A400;      ; 
                       CPX.W #$0040                         ;80A401;      ; 
                       BNE CODE_80A3B9                      ;80A404;80A3B9; 
                       %Set8bit(!M)                             ;80A406;      ; 
                       LDA.B #$00                           ;80A408;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A40A;000027; 
                       LDA.B #$18                           ;80A40C;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A40E;000029; 
                       %Set16bit(!M)                             ;80A410;      ; 
                       LDY.W #$0040                         ;80A412;      ; 
                       LDA.B $14                            ;80A415;000014; 
                       CLC                                  ;80A417;      ; 
                       ADC.W #$6000                         ;80A418;      ; 
                       TAX                                  ;80A41B;      ; 
                       LDA.W #$0746                         ;80A41C;      ; 
                       STA.B $72                            ;80A41F;000072; 
                       %Set8bit(!M)                             ;80A421;      ; 
                       LDA.B #$80                           ;80A423;      ; 
                       STA.B $74                            ;80A425;000074; 
                       %Set16bit(!M)                             ;80A427;      ; 
                       LDA.W #$0080                         ;80A429;      ; 
                       JSL.L AddProgrammedDMA                ;80A42C;808A33; 
                       %Set8bit(!M)                             ;80A430;      ; 
                       LDA.B #$01                           ;80A432;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A434;000027; 
                       LDA.B #$18                           ;80A436;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A438;000029; 
                       %Set16bit(!M)                             ;80A43A;      ; 
                       LDY.W #$0040                         ;80A43C;      ; 
                       LDA.B $14                            ;80A43F;000014; 
                       CLC                                  ;80A441;      ; 
                       ADC.W #$6000                         ;80A442;      ; 
                       ADC.W #$0400                         ;80A445;      ; 
                       TAX                                  ;80A448;      ; 
                       LDA.W #$07C6                         ;80A449;      ; 
                       STA.B $72                            ;80A44C;000072; 
                       %Set8bit(!M)                             ;80A44E;      ; 
                       LDA.B #$80                           ;80A450;      ; 
                       STA.B $74                            ;80A452;000074; 
                       %Set16bit(!M)                             ;80A454;      ; 
                       LDA.W #$0080                         ;80A456;      ; 
                       JSL.L AddProgrammedDMA                ;80A459;808A33; 
                       %Set16bit(!MX)                             ;80A45D;      ; 
                       LDA.B $16                            ;80A45F;000016; 
                       SEC                                  ;80A461;      ; 
                       SBC.B $1A                            ;80A462;00001A; 
                       STA.B $16                            ;80A464;000016; 
                       LDA.B $14                            ;80A466;000014; 
                       SEC                                  ;80A468;      ; 
                       SBC.W #$0020                         ;80A469;      ; 
                       CMP.W #$FFE0                         ;80A46C;      ; 
                       BNE CODE_80A476                      ;80A46F;80A476; 
                       LDA.W #$0BE0                         ;80A471;      ; 
                       BRA CODE_80A47E                      ;80A474;80A47E; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A476: CMP.W #$07E0                         ;80A476;      ; 
                       BNE CODE_80A47E                      ;80A479;80A47E; 
                       LDA.W #$03E0                         ;80A47B;      ; 
                                                            ;      ;      ; 
          CODE_80A47E: STA.B $14                            ;80A47E;000014; 
                       RTL                                  ;80A480;      ;END_APPPP
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                AOOOO: %Set16bit(!MX)                             ;80A481;      ; 
                       LDA.B $16                            ;80A483;000016; 
                       CMP.W #$1000                         ;80A485;      ; 
                       BCC CODE_80A4A6                      ;80A488;80A4A6; 
                       CMP.W #$2000                         ;80A48A;      ; 
                       BCC CODE_80A4B1                      ;80A48D;80A4B1; 
                       CMP.W #$3000                         ;80A48F;      ; 
                       BCC CODE_80A4C6                      ;80A492;80A4C6; 
                       CMP.W #$4000                         ;80A494;      ; 
                       BCC CODE_80A4DB                      ;80A497;80A4DB; 
                       CMP.W #$5000                         ;80A499;      ; 
                       BCC CODE_80A4F3                      ;80A49C;80A4F3; 
                       CMP.W #$6000                         ;80A49E;      ; 
                       BCC CODE_80A50B                      ;80A4A1;80A50B; 
                       JMP.W CODE_80A529                    ;80A4A3;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A4A6: STZ.B $7E                            ;80A4A6;00007E; 
                       STZ.B $80                            ;80A4A8;000080; 
                       STZ.B $82                            ;80A4AA;000082; 
                       STZ.B $84                            ;80A4AC;000084; 
                       JMP.W CODE_80A529                    ;80A4AE;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A4B1: LDA.B $16                            ;80A4B1;000016; 
                       SEC                                  ;80A4B3;      ; 
                       SBC.W #$1000                         ;80A4B4;      ; 
                       STA.B $7E                            ;80A4B7;00007E; 
                       XBA                                  ;80A4B9;      ; 
                       AND.W #$001F                         ;80A4BA;      ; 
                       ASL A                                ;80A4BD;      ; 
                       STA.B $80                            ;80A4BE;000080; 
                       STZ.B $82                            ;80A4C0;000082; 
                       STZ.B $84                            ;80A4C2;000084; 
                       BRA CODE_80A529                      ;80A4C4;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A4C6: LDA.B $16                            ;80A4C6;000016; 
                       SEC                                  ;80A4C8;      ; 
                       SBC.W #$1000                         ;80A4C9;      ; 
                       STA.B $7E                            ;80A4CC;00007E; 
                       XBA                                  ;80A4CE;      ; 
                       AND.W #$001F                         ;80A4CF;      ; 
                       ASL A                                ;80A4D2;      ; 
                       STA.B $80                            ;80A4D3;000080; 
                       STZ.B $82                            ;80A4D5;000082; 
                       STZ.B $84                            ;80A4D7;000084; 
                       BRA CODE_80A529                      ;80A4D9;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A4DB: LDA.W #$4000                         ;80A4DB;      ; 
                       STA.B $7E                            ;80A4DE;00007E; 
                       STZ.B $80                            ;80A4E0;000080; 
                       LDA.B $16                            ;80A4E2;000016; 
                       SEC                                  ;80A4E4;      ; 
                       SBC.W #$3000                         ;80A4E5;      ; 
                       STA.B $82                            ;80A4E8;000082; 
                       XBA                                  ;80A4EA;      ; 
                       AND.W #$001F                         ;80A4EB;      ; 
                       ASL A                                ;80A4EE;      ; 
                       STA.B $84                            ;80A4EF;000084; 
                       BRA CODE_80A529                      ;80A4F1;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A4F3: LDA.W #$4000                         ;80A4F3;      ; 
                       STA.B $7E                            ;80A4F6;00007E; 
                       STZ.B $80                            ;80A4F8;000080; 
                       LDA.B $16                            ;80A4FA;000016; 
                       SEC                                  ;80A4FC;      ; 
                       SBC.W #$3000                         ;80A4FD;      ; 
                       STA.B $82                            ;80A500;000082; 
                       XBA                                  ;80A502;      ; 
                       AND.W #$001F                         ;80A503;      ; 
                       ASL A                                ;80A506;      ; 
                       STA.B $84                            ;80A507;000084; 
                       BRA CODE_80A529                      ;80A509;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A50B: LDA.B $16                            ;80A50B;000016; 
                       SEC                                  ;80A50D;      ; 
                       SBC.W #$1000                         ;80A50E;      ; 
                       STA.B $7E                            ;80A511;00007E; 
                       LDA.B $16                            ;80A513;000016; 
                       SEC                                  ;80A515;      ; 
                       SBC.W #$5000                         ;80A516;      ; 
                       XBA                                  ;80A519;      ; 
                       AND.W #$000F                         ;80A51A;      ; 
                       ASL A                                ;80A51D;      ; 
                       STA.B $80                            ;80A51E;000080; 
                       LDA.W #$4000                         ;80A520;      ; 
                       STA.B $82                            ;80A523;000082; 
                       STZ.B $84                            ;80A525;000084; 
                       BRA CODE_80A529                      ;80A527;80A529; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A529: LDA.W #$2000                         ;80A529;      ; 
                       CLC                                  ;80A52C;      ; 
                       ADC.B $12                            ;80A52D;000012; 
                       ADC.W #$0060                         ;80A52F;      ; 
                       STA.B $72                            ;80A532;000072; 
                       ADC.W #$2000                         ;80A534;      ; 
                       STA.B $75                            ;80A537;000075; 
                       %Set8bit(!M)                             ;80A539;      ; 
                       LDA.B #$7E                           ;80A53B;      ; 
                       STA.B $74                            ;80A53D;000074; 
                       STA.B $77                            ;80A53F;000077; 
                       %Set16bit(!M)                             ;80A541;      ; 
                       LDX.W #$0000                         ;80A543;      ; 
                                                            ;      ;      ; 
          CODE_80A546: PHX                                  ;80A546;      ; 
                       LDA.B $80                            ;80A547;000080; 
                       CMP.W #$0040                         ;80A549;      ; 
                       BNE CODE_80A558                      ;80A54C;80A558; 
                       STZ.B $80                            ;80A54E;000080; 
                       LDA.B $7E                            ;80A550;00007E; 
                       CLC                                  ;80A552;      ; 
                       ADC.W #$2000                         ;80A553;      ; 
                       STA.B $7E                            ;80A556;00007E; 
                                                            ;      ;      ; 
          CODE_80A558: LDA.B $84                            ;80A558;000084; 
                       CMP.W #$0040                         ;80A55A;      ; 
                       BNE CODE_80A569                      ;80A55D;80A569; 
                       STZ.B $84                            ;80A55F;000084; 
                       LDA.B $82                            ;80A561;000082; 
                       CLC                                  ;80A563;      ; 
                       ADC.W #$2000                         ;80A564;      ; 
                       STA.B $82                            ;80A567;000082; 
                                                            ;      ;      ; 
          CODE_80A569: LDY.B $7E                            ;80A569;00007E; 
                       LDX.B $80                            ;80A56B;000080; 
                       LDA.B [$72],Y                        ;80A56D;000072; 
                       STA.W $0746,X                        ;80A56F;000746; 
                       LDY.B $82                            ;80A572;000082; 
                       LDX.B $84                            ;80A574;000084; 
                       LDA.B [$75],Y                        ;80A576;000075; 
                       STA.W $07C6,X                        ;80A578;0007C6; 
                       LDA.B $7E                            ;80A57B;00007E; 
                       CLC                                  ;80A57D;      ; 
                       ADC.W #$0100                         ;80A57E;      ; 
                       STA.B $7E                            ;80A581;00007E; 
                       INC.B $80                            ;80A583;000080; 
                       INC.B $80                            ;80A585;000080; 
                       LDA.B $82                            ;80A587;000082; 
                       CLC                                  ;80A589;      ; 
                       ADC.W #$0100                         ;80A58A;      ; 
                       STA.B $82                            ;80A58D;000082; 
                       INC.B $84                            ;80A58F;000084; 
                       INC.B $84                            ;80A591;000084; 
                       PLX                                  ;80A593;      ; 
                       INX                                  ;80A594;      ; 
                       INX                                  ;80A595;      ; 
                       CPX.W #$0040                         ;80A596;      ; 
                       BNE CODE_80A546                      ;80A599;80A546; 
                       %Set8bit(!M)                             ;80A59B;      ; 
                       LDA.B #$00                           ;80A59D;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A59F;000027; 
                       LDA.B #$18                           ;80A5A1;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A5A3;000029; 
                       %Set16bit(!M)                             ;80A5A5;      ; 
                       LDY.W #$0040                         ;80A5A7;      ; 
                       LDA.B $10                            ;80A5AA;000010; 
                       CLC                                  ;80A5AC;      ; 
                       ADC.W #$6000                         ;80A5AD;      ; 
                       TAX                                  ;80A5B0;      ; 
                       LDA.W #$0746                         ;80A5B1;      ; 
                       STA.B $72                            ;80A5B4;000072; 
                       %Set8bit(!M)                             ;80A5B6;      ; 
                       LDA.B #$80                           ;80A5B8;      ; 
                       STA.B $74                            ;80A5BA;000074; 
                       %Set16bit(!M)                             ;80A5BC;      ; 
                       LDA.W #$0081                         ;80A5BE;      ; 
                       JSL.L AddProgrammedDMA                ;80A5C1;808A33; 
                       %Set8bit(!M)                             ;80A5C5;      ; 
                       LDA.B #$01                           ;80A5C7;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A5C9;000027; 
                       LDA.B #$18                           ;80A5CB;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A5CD;000029; 
                       %Set16bit(!M)                             ;80A5CF;      ; 
                       LDY.W #$0040                         ;80A5D1;      ; 
                       LDA.B $10                            ;80A5D4;000010; 
                       CLC                                  ;80A5D6;      ; 
                       ADC.W #$6000                         ;80A5D7;      ; 
                       ADC.W #$0800                         ;80A5DA;      ; 
                       TAX                                  ;80A5DD;      ; 
                       LDA.W #$07C6                         ;80A5DE;      ; 
                       STA.B $72                            ;80A5E1;000072; 
                       %Set8bit(!M)                             ;80A5E3;      ; 
                       LDA.B #$80                           ;80A5E5;      ; 
                       STA.B $74                            ;80A5E7;000074; 
                       %Set16bit(!M)                             ;80A5E9;      ; 
                       LDA.W #$0081                         ;80A5EB;      ; 
                       JSL.L AddProgrammedDMA                ;80A5EE;808A33; 
                       %Set16bit(!MX)                             ;80A5F2;      ; 
                       LDA.B $12                            ;80A5F4;000012; 
                       CLC                                  ;80A5F6;      ; 
                       ADC.W #$0002                         ;80A5F7;      ; 
                       STA.B $12                            ;80A5FA;000012; 
                       LDA.B $10                            ;80A5FC;000010; 
                       CLC                                  ;80A5FE;      ; 
                       ADC.W #$0001                         ;80A5FF;      ; 
                       CMP.W #$0020                         ;80A602;      ; 
                       BNE CODE_80A60C                      ;80A605;80A60C; 
                       LDA.W #$0400                         ;80A607;      ; 
                       BRA CODE_80A614                      ;80A60A;80A614; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A60C: CMP.W #$0420                         ;80A60C;      ; 
                       BNE CODE_80A614                      ;80A60F;80A614; 
                       LDA.W #$0000                         ;80A611;      ; 
                                                            ;      ;      ; 
          CODE_80A614: STA.B $10                            ;80A614;000010; 
                       RTL                                  ;80A616;      ; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A617: %Set16bit(!MX)                             ;80A617;      ; 
                       LDA.B $16                            ;80A619;000016; 
                       CMP.W #$1000                         ;80A61B;      ; 
                       BCC CODE_80A63C                      ;80A61E;80A63C; 
                       CMP.W #$2000                         ;80A620;      ; 
                       BCC CODE_80A646                      ;80A623;80A646; 
                       CMP.W #$3000                         ;80A625;      ; 
                       BCC CODE_80A65B                      ;80A628;80A65B; 
                       CMP.W #$4000                         ;80A62A;      ; 
                       BCC CODE_80A670                      ;80A62D;80A670; 
                       CMP.W #$5000                         ;80A62F;      ; 
                       BCC CODE_80A688                      ;80A632;80A688; 
                       CMP.W #$6000                         ;80A634;      ; 
                       BCC CODE_80A6A0                      ;80A637;80A6A0; 
                       JMP.W CODE_80A6BE                    ;80A639;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A63C: STZ.B $7E                            ;80A63C;00007E; 
                       STZ.B $80                            ;80A63E;000080; 
                       STZ.B $82                            ;80A640;000082; 
                       STZ.B $84                            ;80A642;000084; 
                       BRA CODE_80A6BE                      ;80A644;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A646: LDA.B $16                            ;80A646;000016; 
                       SEC                                  ;80A648;      ; 
                       SBC.W #$1000                         ;80A649;      ; 
                       STA.B $7E                            ;80A64C;00007E; 
                       XBA                                  ;80A64E;      ; 
                       AND.W #$001F                         ;80A64F;      ; 
                       ASL A                                ;80A652;      ; 
                       STA.B $80                            ;80A653;000080; 
                       STZ.B $82                            ;80A655;000082; 
                       STZ.B $84                            ;80A657;000084; 
                       BRA CODE_80A6BE                      ;80A659;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A65B: LDA.B $16                            ;80A65B;000016; 
                       SEC                                  ;80A65D;      ; 
                       SBC.W #$1000                         ;80A65E;      ; 
                       STA.B $7E                            ;80A661;00007E; 
                       XBA                                  ;80A663;      ; 
                       AND.W #$001F                         ;80A664;      ; 
                       ASL A                                ;80A667;      ; 
                       STA.B $80                            ;80A668;000080; 
                       STZ.B $82                            ;80A66A;000082; 
                       STZ.B $84                            ;80A66C;000084; 
                       BRA CODE_80A6BE                      ;80A66E;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A670: LDA.W #$4000                         ;80A670;      ; 
                       STA.B $7E                            ;80A673;00007E; 
                       STZ.B $80                            ;80A675;000080; 
                       LDA.B $16                            ;80A677;000016; 
                       SEC                                  ;80A679;      ; 
                       SBC.W #$3000                         ;80A67A;      ; 
                       STA.B $82                            ;80A67D;000082; 
                       XBA                                  ;80A67F;      ; 
                       AND.W #$001F                         ;80A680;      ; 
                       ASL A                                ;80A683;      ; 
                       STA.B $84                            ;80A684;000084; 
                       BRA CODE_80A6BE                      ;80A686;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A688: LDA.W #$4000                         ;80A688;      ; 
                       STA.B $7E                            ;80A68B;00007E; 
                       STZ.B $80                            ;80A68D;000080; 
                       LDA.B $16                            ;80A68F;000016; 
                       SEC                                  ;80A691;      ; 
                       SBC.W #$3000                         ;80A692;      ; 
                       STA.B $82                            ;80A695;000082; 
                       XBA                                  ;80A697;      ; 
                       AND.W #$001F                         ;80A698;      ; 
                       ASL A                                ;80A69B;      ; 
                       STA.B $84                            ;80A69C;000084; 
                       BRA CODE_80A6BE                      ;80A69E;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A6A0: LDA.B $16                            ;80A6A0;000016; 
                       SEC                                  ;80A6A2;      ; 
                       SBC.W #$1000                         ;80A6A3;      ; 
                       STA.B $7E                            ;80A6A6;00007E; 
                       LDA.B $16                            ;80A6A8;000016; 
                       SEC                                  ;80A6AA;      ; 
                       SBC.W #$5000                         ;80A6AB;      ; 
                       XBA                                  ;80A6AE;      ; 
                       AND.W #$001F                         ;80A6AF;      ; 
                       ASL A                                ;80A6B2;      ; 
                       STA.B $80                            ;80A6B3;000080; 
                       LDA.W #$4000                         ;80A6B5;      ; 
                       STA.B $82                            ;80A6B8;000082; 
                       STZ.B $84                            ;80A6BA;000084; 
                       BRA CODE_80A6BE                      ;80A6BC;80A6BE; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A6BE: LDA.W #$2000                         ;80A6BE;      ; 
                       CLC                                  ;80A6C1;      ; 
                       ADC.B $12                            ;80A6C2;000012; 
                       SEC                                  ;80A6C4;      ; 
                       SBC.W #$0020                         ;80A6C5;      ; 
                       STA.B $72                            ;80A6C8;000072; 
                       CLC                                  ;80A6CA;      ; 
                       ADC.W #$2000                         ;80A6CB;      ; 
                       STA.B $75                            ;80A6CE;000075; 
                       %Set8bit(!M)                             ;80A6D0;      ; 
                       LDA.B #$7E                           ;80A6D2;      ; 
                       STA.B $74                            ;80A6D4;000074; 
                       STA.B $77                            ;80A6D6;000077; 
                       %Set16bit(!M)                             ;80A6D8;      ; 
                       LDX.W #$0000                         ;80A6DA;      ; 
                                                            ;      ;      ; 
          CODE_80A6DD: PHX                                  ;80A6DD;      ; 
                       LDA.B $80                            ;80A6DE;000080; 
                       CMP.W #$0040                         ;80A6E0;      ; 
                       BNE CODE_80A6EF                      ;80A6E3;80A6EF; 
                       STZ.B $80                            ;80A6E5;000080; 
                       LDA.B $7E                            ;80A6E7;00007E; 
                       CLC                                  ;80A6E9;      ; 
                       ADC.W #$2000                         ;80A6EA;      ; 
                       STA.B $7E                            ;80A6ED;00007E; 
                                                            ;      ;      ; 
          CODE_80A6EF: LDA.B $84                            ;80A6EF;000084; 
                       CMP.W #$0040                         ;80A6F1;      ; 
                       BNE CODE_80A700                      ;80A6F4;80A700; 
                       STZ.B $84                            ;80A6F6;000084; 
                       LDA.B $82                            ;80A6F8;000082; 
                       CLC                                  ;80A6FA;      ; 
                       ADC.W #$2000                         ;80A6FB;      ; 
                       STA.B $82                            ;80A6FE;000082; 
                                                            ;      ;      ; 
          CODE_80A700: LDY.B $7E                            ;80A700;00007E; 
                       LDX.B $80                            ;80A702;000080; 
                       LDA.B [$72],Y                        ;80A704;000072; 
                       STA.W $0746,X                        ;80A706;000746; 
                       LDY.B $82                            ;80A709;000082; 
                       LDX.B $84                            ;80A70B;000084; 
                       LDA.B [$75],Y                        ;80A70D;000075; 
                       STA.W $07C6,X                        ;80A70F;0007C6; 
                       LDA.B $7E                            ;80A712;00007E; 
                       CLC                                  ;80A714;      ; 
                       ADC.W #$0100                         ;80A715;      ; 
                       STA.B $7E                            ;80A718;00007E; 
                       INC.B $80                            ;80A71A;000080; 
                       INC.B $80                            ;80A71C;000080; 
                       LDA.B $82                            ;80A71E;000082; 
                       CLC                                  ;80A720;      ; 
                       ADC.W #$0100                         ;80A721;      ; 
                       STA.B $82                            ;80A724;000082; 
                       INC.B $84                            ;80A726;000084; 
                       INC.B $84                            ;80A728;000084; 
                       PLX                                  ;80A72A;      ; 
                       INX                                  ;80A72B;      ; 
                       INX                                  ;80A72C;      ; 
                       CPX.W #$0040                         ;80A72D;      ; 
                       BNE CODE_80A6DD                      ;80A730;80A6DD; 
                       %Set8bit(!M)                             ;80A732;      ; 
                       LDA.B #$00                           ;80A734;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A736;000027; 
                       LDA.B #$18                           ;80A738;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A73A;000029; 
                       %Set16bit(!M)                             ;80A73C;      ; 
                       LDY.W #$0040                         ;80A73E;      ; 
                       LDA.B $10                            ;80A741;000010; 
                       CLC                                  ;80A743;      ; 
                       ADC.W #$6000                         ;80A744;      ; 
                       TAX                                  ;80A747;      ; 
                       LDA.W #$0746                         ;80A748;      ; 
                       STA.B $72                            ;80A74B;000072; 
                       %Set8bit(!M)                             ;80A74D;      ; 
                       LDA.B #$80                           ;80A74F;      ; 
                       STA.B $74                            ;80A751;000074; 
                       %Set16bit(!M)                             ;80A753;      ; 
                       LDA.W #$0081                         ;80A755;      ; 
                       JSL.L AddProgrammedDMA                ;80A758;808A33; 
                       %Set8bit(!M)                             ;80A75C;      ; 
                       LDA.B #$01                           ;80A75E;      ; 
                       STA.B !ProgDMA_Channel_Index                            ;80A760;000027; 
                       LDA.B #$18                           ;80A762;      ; 
                       STA.B !ProgDMA_Destination_Memory                            ;80A764;000029; 
                       %Set16bit(!M)                             ;80A766;      ; 
                       LDY.W #$0040                         ;80A768;      ; 
                       LDA.B $10                            ;80A76B;000010; 
                       CLC                                  ;80A76D;      ; 
                       ADC.W #$6000                         ;80A76E;      ; 
                       ADC.W #$0800                         ;80A771;      ; 
                       TAX                                  ;80A774;      ; 
                       LDA.W #$07C6                         ;80A775;      ; 
                       STA.B $72                            ;80A778;000072; 
                       %Set8bit(!M)                             ;80A77A;      ; 
                       LDA.B #$80                           ;80A77C;      ; 
                       STA.B $74                            ;80A77E;000074; 
                       %Set16bit(!M)                             ;80A780;      ; 
                       LDA.W #$0081                         ;80A782;      ; 
                       JSL.L AddProgrammedDMA                ;80A785;808A33; 
                       %Set16bit(!MX)                             ;80A789;      ; 
                       LDA.B $12                            ;80A78B;000012; 
                       SEC                                  ;80A78D;      ; 
                       SBC.W #$0002                         ;80A78E;      ; 
                       STA.B $12                            ;80A791;000012; 
                       LDA.B $10                            ;80A793;000010; 
                       SEC                                  ;80A795;      ; 
                       SBC.W #$0001                         ;80A796;      ; 
                       CMP.W #$FFFF                         ;80A799;      ; 
                       BNE CODE_80A7A3                      ;80A79C;80A7A3; 
                       LDA.W #$041F                         ;80A79E;      ; 
                       BRA CODE_80A7AB                      ;80A7A1;80A7AB; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
          CODE_80A7A3: CMP.W #$03FF                         ;80A7A3;      ; 
                       BNE CODE_80A7AB                      ;80A7A6;80A7AB; 
                       LDA.W #$001F                         ;80A7A8;      ; 
                                                            ;      ;      ; 
          CODE_80A7AB: STA.B $10                            ;80A7AB;000010; 
                       RTL                                  ;80A7AD;      ;END_AOOOO
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                ANNNN: %Set8bit(!M)                             ;80A7AE;      ; 
                       %Set16bit(!X)                             ;80A7B0;      ; 
                       LDA.B #$00                           ;80A7B2;      ; 
                       XBA                                  ;80A7B4;      ; 
                       LDA.B !tilemap_to_load                            ;80A7B5;000022; 
                       %Set16bit(!M)                             ;80A7B7;      ; 
                       ASL A                                ;80A7B9;      ; 
                       TAX                                  ;80A7BA;      ; 
                       LDA.L TilemapManagerTable,X                   ;80A7BB;80AA7C; 
                       STA.B !tilemap_pointer                            ;80A7BF;000018; 
                       %Set8bit(!M)                             ;80A7C1;      ; 
                       LDA.B (!tilemap_pointer),Y                        ;80A7C3;000018; 
                       RTL                                  ;80A7C5;      ;END_ANNN


;;;;;;;; TODO Does copy stuff to VG graphics, but no idea what
;;;;;;;; "param" in $22, used as index on data table
;;;;;;;; Maybe it selects the palletes?
TilemapManager: ;80A7C6
        !number_of_tilemaps = $92

        %Set8bit(!M)                         
        %Set16bit(!X)                        
        LDA.B #$00                           
        XBA                                  
        LDA.B !tilemap_to_load                            
        %Set16bit(!M)                        
        ASL A                                
        TAX                                  
        LDA.L TilemapManagerTable,X          
        STA.B !tilemap_pointer                            
        %Set8bit(!M)                         
        LDY.W #$0000                         
        LDA.B !tilemap_to_load                            
        CMP.B #$57                           ;after that value, theres splash screens
        BCS .notsplashscreen                           

        LDA.B (!tilemap_pointer),Y           
        STA.W !current_graphic_preset        
        JSL.L ManageGraphicPresets           
        %Set16bit(!MX)                       
        INY                                  
        LDA.B (!tilemap_pointer),Y                        
        ORA.W $0196                          ;flags
        STA.W $0196                          
        %Set16bit(!M)                        
        LDA.L $7F1F5C                        
        AND.W #$0001                         
        BEQ .skip1                           

        %Set16bit(!MX)                       
        LDA.W $0196                          
        AND.W #$FFDF                         ;resets a flag
        STA.W $0196                          

    .skip1: %Set16bit(!MX)               
        INY                                  
        INY                                  

    .notsplashscreen:
        %Set8bit(!M)                 
        LDA.B (!tilemap_pointer),Y           
        STA.W $0181                          
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.W $0182                          ;lower than 3?
        CMP.B #$03                           
        BCC .skip2                      

        %Set16bit(!M)                        
        LDA.W $0196                          
        ORA.W #$0001                         
        STA.W $0196                          

    .skip2:
        %Set8bit(!M)                         
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B !number_of_tilemaps            
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B $93                            
        INY                                  
        LDA.B !tilemap_to_load               
        CMP.B #$57                           
        BCS .notsplashscreen2                

        %Set16bit(!M)                        
        LDA.B (!tilemap_pointer),Y           
        STA.B $ED                            
        INY                                  
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B $F1                            
        INY                                  
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B $EF                            
        INY                                  
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B $F3                            
        INY                                  
        INY                                  

    .notsplashscreen2:
        %Set8bit(!M)                         
        LDA.B !number_of_tilemaps            
        BEQ .noTilemap                      

    .tilemaploop:
        %Set16bit(!M)                        
        LDA.B (!tilemap_pointer),Y           
        PHA                                  
        INY                                  
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B $72                            
        INY                                  
        INY                                  
        %Set8bit(!M)                         
        LDA.B (!tilemap_pointer),Y           
        STA.B $74                            
        %Set16bit(!M)                        
        INY                                  
        PHY                                  
        LDA.W #$2000                         
        STA.B $75                            
        %Set8bit(!M)                         
        LDA.B #$7E                           
        STA.B $77                            ;Vram
        JSL.L DecompressTileMap              
        %Set8bit(!M)                         
        LDA.B #$00                           
        STA.B !ProgDMA_Channel_Index         
        LDA.B !BBADX_DMA_VRAMPORT            
        STA.B !ProgDMA_Destination_Memory    
        %Set16bit(!MX)                       
        PLY                                  
        PLA                                  
        PHY                                  
        TAX                                  
        LDY.W #$2000                         
        LDA.W #$2000                         
        STA.B $72                            
        %Set8bit(!M)                         
        LDA.B #$7E                           
        STA.B $74                            
        %Set16bit(!M)                        
        LDA.W #$0080                         
        JSL.L AddProgrammedDMA               
        JSL.L StartLastPreparedDMA           
        %Set16bit(!MX)                       
        PLY                                  
        %Set8bit(!M)                         
        LDA.B !number_of_tilemaps            
        DEC A                                
        STA.B !number_of_tilemaps            
        BNE .tilemaploop                           

    .noTilemap:
        %Set16bit(!MX)                       
        LDA.B (!tilemap_pointer),Y           
        STA.B $8A                            
        INY                                  
        INY                                  
        LDA.B (!tilemap_pointer),Y           
        STA.B $72                            
        INY                                  
        INY                                  
        %Set8bit(!M)                         
        LDA.B (!tilemap_pointer),Y           
        STA.B $74                            
        %Set16bit(!M)                        
        INY                                  
        PHY                                  
        LDA.W #$2000                         
        STA.B $75                            
        %Set8bit(!M)                         
        LDA.B #$7E                           
        STA.B $77                            
        %Set16bit(!M)                        
        LDA.W $0196                          
        AND.W #$8000                         ;TODO
        BNE .skip5                           
        JSL.L DecompressTileMap              
        BRA .skip6                      

    .skip5: %Set16bit(!MX)               
        LDY.W #$0000                         

    .extradatareadloop:
        LDA.B [$72],Y                        ;TODO Why?
        STA.B [$75],Y                        
        INY                                  
        INY                                  
        CPY.W #$8000                         
        BNE .extradatareadloop               

    .skip6:
        %Set8bit(!M)                         
        LDA.B !tilemap_to_load               
        CMP.B #$04                           
        BCS .skip7                           ;Farms by season
        JSL.L UNK_PartialMap                           

    .skip7:
        %Set8bit(!M)                         
        LDA.B $93                            
        CMP.B #$01                           
        BNE .skip8                           
        %Set16bit(!MX)                             ;80A915;      ; 
        LDA.L $7F1F5E                        ;80A917;7F1F5E;$7F1F5E
        AND.W #$0002                         ;80A91B;      ; 
        BNE .skip8                           ;80A91E;80A924; 
        JSL.L UNK_ExecuteFromPointers                    ;80A920;81A9E5; 
                                        ;      ;      ; 
        .skip8: %Set16bit(!M)                             ;80A924;      ; 
        STZ.B !OBJ_Offset_X                            ;80A926;0000F5;$0000F5
        STZ.B !OBJ_Offset_Y                           ;80A928;0000F7;$0000F7
        LDA.W #$0410                         ;80A92A;      ; 
        STA.B $10                            ;80A92D;000010;$000010
        LDA.W #$0A00                         ;80A92F;      ; 
        STA.B $14                            ;80A932;000014;$000014
        STZ.B $12                            ;80A934;000012;$000012
        STZ.B $16                            ;80A936;000016;$000016
        %Set8bit(!M)                             ;80A938;      ; 
        STZ.B !BG_subpixel_offset_X                            ;80A93A;000020;$000020
        STZ.B !BG_subpixel_offset_Y                            ;80A93C;000021;$000021
        %Set16bit(!M)                             ;80A93E;      ; 
        STZ.B !player_pos_X                           ;80A940;0000D6;$0000D6
        STZ.B !player_pos_Y                           ;80A942;0000D8;$0000D8
        %Set8bit(!M)                             ;80A944;      ; 
        LDA.B #$00                           ;80A946;      ; 
        XBA                                  ;80A948;      ; 
        LDA.W $0181                          ;80A949;000181;$000181
        %Set16bit(!M)                             ;80A94C;      ; 
        ASL A                                ;80A94E;      ; 
        TAX                                  ;80A94F;      ; 
        LDA.L UNK_Table2,X                   ;80A950;80AA68; 
        STA.B $1A                            ;80A954;00001A;$00001A
        SEC                                  ;80A956;      ; 
        SBC.W #$0040                         ;80A957;      ; 
        STA.B $80                            ;80A95A;000080;$000080
        LDA.L UNK_Table3,X                   ;80A95C;80AA72; 
        STA.B $1C                            ;80A960;00001C;$00001C
        %Set16bit(!M)                             ;80A962;      ; 
        LDA.W #$0000                         ;80A964;      ; 
        STA.B $7E                            ;80A967;00007E;$00007E
        LDX.B $8A                            ;80A969;00008A;$00008A
        LDY.W #$0040                         ;80A96B;      ; 
        LDA.W #$0000                         ;80A96E;      ; 
                                        ;      ;      ; 
        .loop34: %Set16bit(!M)                             ;80A971;      ; 
        PHA                                  ;80A973;      ; 
        LDA.W #$0000                         ;80A974;      ; 
                                        ;      ;      ; 
        .loop2: %Set16bit(!MX)                             ;80A977;      ; 
        PHA                                  ;80A979;      ; 
        JSR.W LoadsFromVRAMwithOffset                          ;80A97A;80AA38; 
        %Set16bit(!MX)                             ;80A97D;      ; 
        LDA.B $7E                            ;80A97F;00007E;$00007E
        CLC                                  ;80A981;      ; 
        ADC.W #$0040                         ;80A982;      ; 
        STA.B $7E                            ;80A985;00007E;$00007E
        TXA                                  ;80A987;      ; 
        CLC                                  ;80A988;      ; 
        ADC.W #$0400                         ;80A989;      ; 
        TAX                                  ;80A98C;      ; 
        %Set8bit(!M)                             ;80A98D;      ; 
        LDA.B !tilemap_to_load                            ;80A98F;000022;$000022
        CMP.B #$5B                           ;80A991;      ; 
        BCS .skip9                           ;80A993;80A99C; 
        LDY.B $8A                            ;80A995;00008A;$00008A
        CPY.W #$7000                         ;80A997;      ; 
        BEQ .skip10                          ;80A99A;80A9A2; 
                                        ;      ;      ; 
        .skip9: LDY.W #$0040                         ;80A99C;      ; 
        JSR.W LoadsFromVRAMwithOffset                          ;80A99F;80AA38; 
                                        ;      ;      ; 
        .skip10: %Set16bit(!MX)                             ;80A9A2;      ; 
        LDA.B $7E                            ;80A9A4;00007E;$00007E
        CLC                                  ;80A9A6;      ; 
        ADC.B $80                            ;80A9A7;000080;$000080
        STA.B $7E                            ;80A9A9;00007E;$00007E
        TXA                                  ;80A9AB;      ; 
        SEC                                  ;80A9AC;      ; 
        SBC.W #$03E0                         ;80A9AD;      ; 
        TAX                                  ;80A9B0;      ; 
        LDY.W #$0040                         ;80A9B1;      ; 
        PLA                                  ;80A9B4;      ; 
        INC A                                ;80A9B5;      ; 
        CMP.W #$0020                         ;80A9B6;      ; 
        BNE .loop2                           ;80A9B9;80A977; 
        %Set8bit(!M)                             ;80A9BB;      ; 
        LDA.B !tilemap_to_load                            ;80A9BD;000022;$000022
        CMP.B #$5B                           ;80A9BF;      ; 
        BCS .skip11                          ;80A9C1;80A9CA; 
        LDY.B $8A                            ;80A9C3;00008A;$00008A
        CPY.W #$7000                         ;80A9C5;      ; 
        BEQ .skip12                          ;80A9C8;80A9D2; 
                                        ;      ;      ; 
        .skip11: %Set16bit(!M)                             ;80A9CA;      ; 
        TXA                                  ;80A9CC;      ; 
        CLC                                  ;80A9CD;      ; 
        ADC.W #$0400                         ;80A9CE;      ; 
        TAX                                  ;80A9D1;      ; 
                                        ;      ;      ; 
        .skip12: %Set16bit(!MX)                             ;80A9D2;      ; 
        LDY.W #$0040                         ;80A9D4;      ; 
        PLA                                  ;80A9D7;      ; 
        INC A                                ;80A9D8;      ; 
        CMP.W #$0002                         ;80A9D9;      ; 
        BNE .loop34                          ;80A9DC;80A971; 
        %Set16bit(!MX)                             ;80A9DE;      ; 
        PLY                                  ;80A9E0;      ; 
        %Set8bit(!M)                             ;80A9E1;      ; 
        LDA.B $93                            ;80A9E3;000093;$000093
        DEC A                                ;80A9E5;      ; 
        STA.B $93                            ;80A9E6;000093;$000093
        BEQ .skip13                          ;80A9E8;80A9ED; 
        JMP.W .noTilemap                    ;80A9EA;80A8BE; 
                                        ;      ;      ; 
                                        ;      ;      ; 
        .skip13: %Set8bit(!M)                             ;80A9ED;      ; 
        LDA.B !tilemap_to_load                            ;80A9EF;000022;$000022
        CMP.B #$57                           ;80A9F1;      ; 
        BCS .return                          ;80A9F3;80AA37; 
        %Set8bit(!M)                             ;80A9F5;      ; 
        LDA.B #$08                           ;80A9F7;      ; 
        STA.B $1E                            ;80A9F9;00001E;$00001E
                                        ;      ;      ; 
        .loop33: %Set16bit(!M)                             ;80A9FB;      ; 
        LDA.B !player_pos_X                           ;80A9FD;0000D6;$0000D6
        CMP.W !transition_dest_X                          ;80A9FF;00017D;$00017D
        BEQ .skip14                          ;80AA02;80AA19; 
        LDA.B !player_pos_X                           ;80AA04;0000D6;$0000D6
        CLC                                  ;80AA06;      ; 
        ADC.B $1E                            ;80AA07;00001E;$00001E
        STA.B !player_pos_X                           ;80AA09;0000D6;$0000D6
        JSL.L A2222                          ;80AA0B;809EBC; 
        JSL.L UNK_StaticMapScroling          ;80AA0F;80A11C; 
        JSL.L StartProgramedDMA           ;80AA13;808AF0; 
        BRA .loop33                          ;80AA17;80A9FB; 
                                        ;      ;      ; 
                                        ;      ;      ; 
        .skip14: %Set16bit(!M)                             ;80AA19;      ; 
        LDA.B !player_pos_Y                           ;80AA1B;0000D8;$0000D8
        CMP.W !transition_dest_Y                          ;80AA1D;00017F;$00017F
        BEQ .return                          ;80AA20;80AA37; 
        LDA.B !player_pos_Y                           ;80AA22;0000D8;$0000D8
        CLC                                  ;80AA24;      ; 
        ADC.B $1E                            ;80AA25;00001E;$00001E
        STA.B !player_pos_Y                           ;80AA27;0000D8;$0000D8
        JSL.L A2222                          ;80AA29;809EBC; 
        JSL.L UpdateBGOffset                          ;80AA2D;80A0AB; 
        JSL.L StartProgramedDMA           ;80AA31;808AF0; 
        BRA .skip14                          ;80AA35;80AA19; 
                                        ;      ;      ; 
                                        ;      ;      ; 
        .return: RTL                                  ;80AA37;      ;END_UNK_MemoryShuffling

;;;;;;; Params $7E: offset to add, X: VRAM/CGRAM Dest Addresses and Y:DMA Size
LoadsFromVRAMwithOffset: ;80AA38
        !offset = $7E

        %Set16bit(!MX)                       
        PHX                                  
        PHY                                  
        %Set8bit(!M)                         
        LDA.B #$00                           
        STA.B !ProgDMA_Channel_Index         
        LDA.B !BBADX_DMA_VRAMPORT            
        STA.B !ProgDMA_Destination_Memory    
        %Set16bit(!M)                        
        LDA.W #$2000                         
        CLC                                  
        ADC.B !offset                            
        STA.B $72                            
        %Set8bit(!M)                         
        LDA.B #$7E                           
        STA.B $74                            ;sets $72 as pointer to $7E2000+offset
        %Set16bit(!M)                        
        LDA.W #$0080                         ;reverse Direction???
        JSL.L AddProgrammedDMA               
        JSL.L StartLastPreparedDMA           
        %Set16bit(!MX)                       
        PLY                                  
        PLX                                  
        RTS                                  
                                                            ;      ;      ; 
        ;Related to 0181, stored in A1
UNK_Table2: dw $0000,$0040,$0080,$0100,$0100;80AA68;      ; 
UNK_Table3: dw $0000,$1000,$2000,$4000,$4000;80AA72;      ;used on TilemapManager
                                                            ;      ;      ; 
incsrc "../tilesets/tilemapManagerTable.asm"
                                                            ;      ;      ; 
          Unk_Table13: db $0C,$00,$00,$01,$E8,$00,$80,$00,$15,$01,$0D,$00,$80,$00,$C8,$00;80B6F5;      ; 
                       db $16,$01,$0D,$00,$80,$00,$C8,$00,$17,$01,$0D,$00,$80,$00,$C8,$00;80B705;      ; 
                       db $27,$01,$0E,$00,$80,$00,$68,$01,$28,$01,$0F,$00,$80,$00,$C8,$00;80B715;      ; 
                       db $26,$01,$10,$00,$80,$00,$C8,$00,$2A,$00,$00,$00,$90,$00,$90,$02;80B725;      ; 
                       db $2A,$00,$00,$00,$B0,$00,$60,$01,$00,$00,$00,$81,$88,$00,$58,$01;80B735;      ; 
                       db $00,$00,$00,$01,$A8,$01,$E8,$01,$2A,$00,$23,$00,$60,$00,$98,$00;80B745;      ; 
                       db $00,$00,$00,$01,$48,$01,$68,$01,$00,$00,$00,$01,$C8,$01,$68,$01;80B755;      ; 
                       db $00,$02,$00,$01,$18,$00,$C0,$01,$04,$03,$00,$01,$E8,$02,$A8,$01;80B765;      ; 
                       db $10,$01,$00,$01,$48,$01,$D8,$02,$0C,$02,$00,$01,$18,$00,$80,$00;80B775;      ; 
                       db $18,$01,$14,$22,$80,$00,$A8,$00,$1B,$01,$15,$02,$80,$00,$C8,$01;80B785;      ; 
                       db $1C,$01,$16,$32,$90,$00,$C8,$01,$1E,$01,$17,$24,$90,$00,$C8,$01;80B795;      ; 
                       db $20,$01,$18,$32,$90,$00,$C8,$01,$22,$01,$19,$32,$90,$00,$C8,$01;80B7A5;      ; 
                       db $24,$01,$1A,$32,$80,$00,$C8,$00,$24,$00,$00,$32,$58,$00,$48,$00;80B7B5;      ; 
                       db $25,$01,$1B,$32,$80,$00,$C8,$00,$0C,$00,$00,$01,$80,$00,$18,$00;80B7C5;      ; 
                       db $2B,$01,$13,$32,$80,$00,$C8,$00,$29,$01,$00,$00,$78,$01,$80,$00;80B7D5;      ; 
                       db $29,$05,$00,$00,$C8,$00,$88,$01,$31,$01,$00,$41,$80,$00,$C8,$01;80B7E5;      ; 
                       db $10,$00,$00,$01,$A8,$00,$A8,$01,$10,$00,$00,$01,$88,$01,$18,$00;80B7F5;      ; 
                       db $10,$00,$00,$01,$08,$02,$28,$02,$04,$00,$00,$01,$98,$00,$98,$00;80B805;      ; 
                       db $19,$01,$1C,$00,$B0,$01,$98,$01,$18,$00,$00,$00,$98,$00,$48,$00;80B815;      ; 
                       db $1A,$00,$00,$00,$98,$00,$58,$01,$19,$01,$1D,$00,$50,$01,$98,$01;80B825;      ; 
                       db $04,$00,$00,$01,$70,$01,$98,$00,$04,$00,$00,$01,$58,$02,$E8,$00;80B835;      ; 
                       db $1D,$01,$1E,$00,$68,$00,$B8,$00,$1C,$00,$00,$00,$68,$00,$48,$01;80B845;      ; 
                       db $04,$00,$00,$01,$58,$02,$78,$03,$04,$01,$1F,$01,$48,$02,$28,$03;80B855;      ; 
                       db $04,$00,$00,$01,$18,$01,$68,$03,$21,$01,$20,$00,$68,$00,$C8,$00;80B865;      ; 
                       db $20,$00,$00,$00,$68,$00,$48,$01,$04,$00,$00,$01,$98,$01,$68,$03;80B875;      ; 
                       db $23,$01,$21,$00,$68,$00,$B8,$00,$22,$00,$00,$00,$68,$00,$48,$01;80B885;      ; 
                       db $04,$00,$00,$01,$98,$00,$68,$03,$1F,$01,$22,$00,$88,$00,$C8,$00;80B895;      ; 
                       db $1E,$00,$00,$00,$88,$00,$48,$01,$04,$00,$00,$01,$48,$02,$68,$02;80B8A5;      ; 
                       db $26,$00,$00,$00,$78,$00,$48,$00,$00,$00,$00,$01,$28,$03,$58,$03;80B8B5;      ; 
                       db $04,$03,$00,$01,$68,$02,$68,$01   ;80B8C5;      ; 
                                                            ;      ;      ; 
       UNK_AudioTable: db $00,$04,$02,$05,$03,$03,$03,$04,$03,$01,$02,$03,$03,$03,$01,$04;80B8CD;      ; 
                       db $03,$03,$04,$01,$01,$03,$01,$01,$01,$02;80B8DD;      ; 
                                                            ;      ;      ; 
Mayby_Table_AudioTracksbySeason: db $A7,$B9,$A7,$B9,$A7,$B9,$A7,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9;80B8E7;      ; 
                       db $B3,$B9,$B3,$B9,$B7,$B9,$BB,$B9,$A7,$B9,$A7,$B9,$A7,$B9,$A7,$B9;80B8F7;      ; 
                       db $AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$A7,$B9,$A7,$B9,$A7,$B9;80B907;      ; 
                       db $AB,$B9,$AB,$B9,$AB,$B9,$BF,$B9,$AB,$B9,$AB,$B9,$D3,$B9,$AB,$B9;80B917;      ; 
                       db $AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$AB,$B9,$A7,$B9,$A7,$B9;80B927;      ; 
                       db $A7,$B9,$FF,$FF,$C3,$B9,$AF,$B9,$C7,$B9,$A7,$B9,$A7,$B9,$A7,$B9;80B937;      ; 
                       db $A7,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9;80B947;      ; 
                       db $AF,$B9,$AF,$B9,$AF,$B9,$AF,$B9,$CF,$B9,$FF,$FF,$FF,$FF,$FF,$FF;80B957;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80B967;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80B977;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80B987;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$CF,$B9,$CB,$B9,$FF,$FF,$C7,$B9,$C7,$B9;80B997;      ; 
                                                            ;      ;      ; 
Table_AudioTrackbySeasonIndex: db $01,$02,$07,$04,$05,$05,$05,$05,$06,$06,$06,$06,$03,$03,$03,$03;80B9A7;      ; 
                       db $0E,$0E,$0E,$0E,$0D,$0D,$0D,$0D,$09,$09,$09,$09,$0F,$0F,$0F,$0F;80B9B7;      ; 
                       db $0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$12,$12,$12,$12,$08,$08,$08,$08;80B9C7;      ; 
                       db $68,$49,$08,$FF,$FF,$68,$49,$08,$17,$7F,$08,$71,$72,$08,$FE,$FF;80B9D7;      ; 
                       db $DC,$B9,$80,$10,$52,$28,$FF,$FF,$10,$52,$28,$10,$52,$28,$BD,$7F;80B9E7;      ; 
                       db $28,$FE,$FF,$EF,$B9,$80           ;80B9F7;      ; 
                                                            ;      ;      ; 
  PalettePointerTable: db $00,$94,$A8,$00,$96,$A8,$00,$98,$A8,$00,$8A,$A8,$00,$8C,$A8,$00;80B9FD
                       db $8E,$A8,$00,$90,$A8,$00,$92,$A8,$00,$80,$A8,$00,$82,$A8,$00,$84;80BA0D;      ; 
                       db $A8,$00,$86,$A8,$00,$88,$A8,$00,$9A,$A8,$00,$9C,$A8,$00,$9E,$A8;80BA1D;      ; 
                       db $00,$A0,$A8,$00,$A2,$A8,$00,$F4,$A8,$00,$F8,$A8,$00,$FA,$A8,$00;80BA2D;      ; 
                       db $FC,$A8,$00,$BA,$A8,$00,$BC,$A8,$00,$BE,$A8,$00,$C0,$A8,$00,$C2;80BA3D;      ; 
                       db $A8,$00,$C6,$A8,$00,$C8,$A8,$00,$CA,$A8,$00,$80,$A9,$00,$82,$A9;80BA4D;      ; 
                       db $00,$84,$A9,$00,$86,$A9,$00,$F6,$A8,$00,$C4,$A8,$00,$8A,$A9,$00;80BA5D;      ; 
                       db $88,$A9,$00,$FE,$A8,$00,$CC,$A8,$00,$CE,$A8,$00,$D0,$A8,$00,$D2;80BA6D;      ; 
                       db $A8,$00,$D4,$A8,$00,$EA,$A8,$00,$EC,$A8,$00,$EE,$A8,$00,$F0,$A8;80BA7D;      ; 
                       db $00,$F2,$A8,$00,$D6,$A8,$00,$D8,$A8,$00,$DA,$A8,$00,$DC,$A8,$00;80BA8D;      ; 
                       db $DE,$A8,$00,$E0,$A8,$00,$E2,$A8,$00,$E4,$A8,$00,$E6,$A8,$00,$E8;80BA9D;      ; 
                       db $A8,$00,$C8,$A9,$00,$CA,$A9,$00,$CC,$A9,$00,$CE,$A9,$00,$B8,$A9;80BAAD;      ; 
                       db $00,$BA,$A9,$00,$BC,$A9,$00,$BE,$A9,$00,$C0,$A9,$00,$C2,$A9,$00;80BABD;      ; 
                       db $C4,$A9,$00,$C6,$A9,$00,$D0,$A9,$00,$D2,$A9,$00,$D4,$A9,$00,$D6;80BACD;      ; 
                       db $A9,$00,$A6,$A8,$00,$A8,$A8,$00,$AA,$A8,$00,$AC,$A8,$00,$AE,$A8;80BADD;      ; 
                       db $00,$B0,$A8,$00,$B2,$A8,$00,$B4,$A8,$00,$B6,$A8,$00,$B8,$A8,$00;80BAED;      ; 
                       db $8E,$A9,$00,$B6,$A9,$00,$A4,$A8,$00,$92,$A9,$00,$90,$A9,$00,$A6;80BAFD;      ; 
                       db $A9,$00,$A8,$A9,$00,$AA,$A9,$00,$AC,$A9,$00,$9C,$A9,$00,$9E,$A9;80BB0D;      ; 
                       db $00,$A0,$A9,$00,$A2,$A9,$00,$94,$A9,$00,$96,$A9,$00,$98,$A9,$00;80BB1D;      ; 
                       db $9A,$A9,$00,$AE,$A9,$00,$B0,$A9,$00,$B2,$A9,$00,$B4,$A9,$00,$A4;80BB2D;      ; 
                       db $A9,$00,$DE,$A9,$00,$E0,$A9,$00,$D8,$A9,$00,$DA,$A9,$00,$8C,$A9;80BB3D;      ; 
                       db $00,$DC,$A9,$00,$E2,$A9,$00,$E4,$A9,$00,$E6,$A9,$00,$E8,$A9;80BB4D;      ; 
                                                            ;      ;      ; 
         DATA8_80BB5C: db $00,$01,$02,$06,$07,$FF,$03,$04,$05,$06,$07,$FF,$08,$09,$0A,$0B;80BB5C;      ; 
                       db $0C,$FF,$0D,$0E,$0F,$10,$11,$FF,$FF,$12,$13,$14,$15,$FF,$FF,$16;80BB6C;      ; 
                       db $17,$18,$19,$FF,$FF,$1A,$1B,$1C,$1D,$FF,$FF,$1E,$1F,$20,$21,$FF;80BB7C;      ; 
                       db $FF,$22,$22,$FF,$FF,$FF,$FF,$23,$23,$FF,$FF,$FF,$FF,$FF,$FF,$24;80BB8C;      ; 
                       db $25,$FF,$FF,$26,$FF,$FF,$FF,$FF,$27,$28,$29,$2A,$2B,$FF,$2C,$2D;80BB9C;      ; 
                       db $2E,$2F,$30,$FF,$31,$32,$33,$34,$35,$FF,$36,$37,$38,$39,$3A,$FF;80BBAC;      ; 
                       db $FF,$3B,$3C,$3D,$3E,$FF,$FF,$3F,$40,$41,$42,$FF,$FF,$43,$44,$45;80BBBC;      ; 
                       db $46,$FF,$FF,$47,$48,$49,$4A,$FF,$FF,$FF,$FF,$FF,$4A,$FF,$4B,$4B;80BBCC;      ; 
                       db $4B,$4B,$4B,$4C,$4B,$4B,$4B,$4B,$4B,$4C,$4B,$4B,$4B,$4B,$4B,$4C;80BBDC;      ; 
                       db $FF,$4D,$4D,$FF,$FF,$FF,$FF,$4D,$4D,$FF,$FF,$FF,$FF,$4D,$4D,$FF;80BBEC;      ; 
                       db $FF,$FF,$FF,$4E,$4E,$FF,$FF,$FF,$FF,$4F,$4F,$FF,$FF,$FF,$FF,$4F;80BBFC;      ; 
                       db $4F,$FF,$FF,$FF,$FF,$FF,$FF,$50,$50,$FF,$FF,$FF,$FF,$50,$50,$FF;80BC0C;      ; 
                       db $FF,$51,$51,$FF,$FF,$FF,$FF,$51,$51,$FF,$FF,$FF,$FF,$52,$52,$FF;80BC1C;      ; 
                       db $FF,$FF,$FF,$52,$52,$FF,$FF,$FF,$FF,$53,$53,$FF,$FF,$FF,$FF,$54;80BC2C;      ; 
                       db $54,$FF,$FF,$FF,$55,$55,$55,$55,$55,$FF,$56,$56,$56,$56,$56,$FF;80BC3C;      ; 
                       db $56,$56,$56,$56,$56,$FF,$FF,$57,$57,$57,$57,$FF,$57,$57,$57,$57;80BC4C;      ; 
                       db $57,$FF,$FF,$58,$58,$FF,$FF,$FF,$FF,$59,$FF,$FF,$FF,$FF,$FF,$12;80BC5C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$16,$FF,$FF,$FF,$FF,$FF,$1A,$FF,$FF,$FF,$FF;80BC6C;      ; 
                       db $FF,$1E,$FF,$FF,$FF,$FF,$FF,$5A,$5B,$5C,$5D,$FF,$FF,$5E,$5F,$60;80BC7C;      ; 
                       db $61,$FF,$FF,$62,$63,$64,$65,$FF,$FF,$66,$67,$68,$69,$FF,$FF,$5A;80BC8C;      ; 
                       db $5B,$5C,$5D,$FF,$FF,$5E,$5F,$60,$61,$FF,$FF,$62,$63,$64,$65,$FF;80BC9C;      ; 
                       db $FF,$66,$67,$68,$69,$FF,$FF,$FF,$FF,$FF,$69,$FF,$69,$6A,$6A,$6A;80BCAC;      ; 
                       db $6A,$FF,$FF,$5A,$5B,$5C,$5D,$FF,$28,$FF,$FF,$FF,$FF,$FF,$04,$FF;80BCBC;      ; 
                       db $FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF;80BCCC;      ; 
                       db $04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$16,$FF,$FF,$FF;80BCDC;      ; 
                       db $FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF;80BCEC;      ; 
                       db $FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF;80BCFC;      ; 
                       db $3F,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF,$FF,$FF,$04,$FF,$FF,$FF;80BD0C;      ; 
                       db $FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF;80BD1C;      ; 
                       db $FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF;80BD2C;      ; 
                       db $70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF;80BD3C;      ; 
                       db $FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$70,$FF;80BD4C;      ; 
                       db $FF,$FF,$FF,$FF,$70,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD5C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD6C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD7C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BD8C;      ; 
                                                            ;      ;      ; 
           UNK_Table9: db $F8,$3B,$D0,$26,$46,$09,$8C,$23,$48,$16,$24,$01,$D7,$22,$71,$01;80BD9C;      ; 
                       db $A9,$0C,$8C,$23,$EF,$3D,$7B,$7F,$A8,$15,$07,$15,$A2,$00,$A8,$15;80BDAC;      ; 
                       db $07,$15,$A2,$00,$4C,$01,$E8,$00,$66,$00,$A8,$15,$EF,$3D,$73,$56;80BDBC;      ; 
                       db $76,$3B,$92,$2A,$07,$11,$8C,$23,$48,$16,$24,$01,$7C,$0A,$54,$01;80BDCC;      ; 
                       db $A8,$08,$76,$3B,$92,$2A,$07,$11,$CE,$19,$2A,$11,$85,$08,$CF,$1D;80BDDC;      ; 
                       db $2B,$0D,$66,$00,$70,$01,$CC,$04,$24,$00,$CE,$19,$2A,$11,$85,$08;80BDEC;      ; 
                                                            ;      ;      ; 
          UNK_Table10: db $00,$00,$00,$00,$00,$00,$29,$7A,$A0,$5D,$00,$41,$1F,$03,$DF,$01;80BDFC;      ; 
                       db $F8,$00,$1F,$73,$5E,$62,$B9,$41,$56,$1A,$B0,$0D,$2D,$1D,$FF,$53;80BE0C;      ; 
                       db $FE,$02,$16,$02,$00,$00,$00,$00,$00,$00,$EA,$61,$80,$51,$20,$45;80BE1C;      ; 
                       db $DB,$1D,$78,$01,$B5,$00,$7D,$6A,$F9,$55,$14,$31,$8F,$09,$2B,$1D;80BE2C;      ; 
                       db $09,$15,$FC,$0A,$7B,$02,$92,$01   ;80BE3C;      ; 
                                                            ;      ;      ; 
          UNK_Table11: db $6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BE44;      ; 
                       db $6B,$6B,$6B,$6B,$6B,$6C,$6B,$6B,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BE54;      ; 
                       db $6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE64;      ; 
                       db $6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE74;      ; 
                       db $6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE84;      ; 
                       db $6B,$6B,$6C,$6C,$6C,$6C,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B,$6B;80BE94;      ; 
                       db $6B,$6B,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BEA4;      ; 
                       db $6B,$6C,$6B,$6C,$6B,$6B,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BEB4;      ; 
                       db $6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C,$6B,$6C;80BEC4;      ; 
                       db $6B,$6C,$6B,$6C,$6B,$6C,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BED4;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF   ;80BEE4;      ; 
                                                            ;      ;      ; 
          UNK_Table12: db $6C,$C3,$6C,$C3,$D9,$C3,$46,$C4,$B3,$C4,$FF,$FF,$6C,$C3,$6C,$C3;80BEEC;      ; 
                       db $D9,$C3,$46,$C4,$B3,$C4,$FF,$FF,$20,$C5,$20,$C5,$8D,$C5,$FA,$C5;80BEFC;      ; 
                       db $67,$C6,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BF0C;      ; 
                       db $FF,$FF,$DE,$CA,$30,$CB,$82,$CB,$D4,$CB,$FF,$FF,$FF,$FF,$92,$CC;80BF1C;      ; 
                       db $E4,$CC,$36,$CD,$88,$CD,$FF,$FF,$FF,$FF,$46,$CE,$98,$CE,$EA,$CE;80BF2C;      ; 
                       db $3C,$CF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FA,$CF,$FF,$FF;80BF3C;      ; 
                       db $FF,$FF,$DE,$CA,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$30,$DC;80BF4C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$46,$CE,$FF,$FF,$FF,$FF;80BF5C;      ; 
                       db $B4,$DA,$FF,$FF,$FF,$FF,$DE,$CA,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BF6C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BF7C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BF8C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80BF9C;      ; 
                       db $FF,$FF,$67,$D0,$25,$D1,$E3,$D1,$A1,$D2,$FF,$FF,$FF,$FF,$44,$D3;80BFAC;      ; 
                       db $02,$D4,$C0,$D4,$63,$D5,$FF,$FF,$FF,$FF,$06,$D6,$FA,$D6,$EE,$D7;80BFBC;      ; 
                       db $91,$D8,$FF,$FF,$FF,$FF,$34,$D9,$6B,$D9,$A2,$D9,$D9,$D9,$FF,$FF;80BFCC;      ; 
                       db $FF,$FF,$34,$D9,$6B,$D9,$A2,$D9,$D9,$D9,$FF,$FF,$92,$C7,$92,$C7;80BFDC;      ; 
                       db $92,$C7,$92,$C7,$92,$C7,$01,$00,$92,$C7,$92,$C7,$92,$C7,$92,$C7;80BFEC;      ; 
                       db $92,$C7,$01,$00,$92,$C7,$92,$C7,$92,$C7,$92,$C7,$92,$C7,$01,$00;80BFFC;      ; 
                       db $FF,$FF,$FF,$C7,$FF,$C7,$FF,$C7,$FF,$C7,$01,$00,$FF,$FF,$FF,$FF;80C00C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$01,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C01C;      ; 
                       db $FF,$FF,$01,$00,$FF,$FF,$6C,$C8,$6C,$C8,$6C,$C8,$6C,$C8,$FF,$FF;80C02C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01,$00,$FF,$FF,$45,$C9;80C03C;      ; 
                       db $45,$C9,$45,$C9,$45,$C9,$01,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C04C;      ; 
                       db $FF,$FF,$01,$00,$FF,$FF,$B2,$C9,$B2,$C9,$B2,$C9,$B2,$C9,$01,$00;80C05C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$01,$00,$FF,$FF,$09,$DD;80C06C;      ; 
                       db $09,$DD,$09,$DD,$09,$DD,$01,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C07C;      ; 
                       db $FF,$FF,$01,$00,$FF,$FF,$1F,$CA,$1F,$CA,$1F,$CA,$1F,$CA,$01,$00;80C08C;      ; 
                       db $FF,$FF,$8C,$CA,$8C,$CA,$8C,$CA,$8C,$CA,$01,$00,$FF,$FF,$06,$DB;80C09C;      ; 
                       db $06,$DB,$06,$DB,$06,$DB,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C0AC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C0BC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C0CC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$D4,$C6,$D4,$C6,$D4,$C6,$D4,$C6;80C0DC;      ; 
                       db $D4,$C6,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C0EC;      ; 
                       db $47,$DA,$47,$DA,$47,$DA,$47,$DA,$47,$DA,$FF,$FF,$FF,$FF,$FF,$FF;80C0FC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C10C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C11C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C12C;      ; 
                       db $FF,$FF,$FF,$FF,$10,$DA,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C13C;      ; 
                       db $10,$DA,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$DA,$FF,$FF;80C14C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$DA,$FF,$FF,$FF,$FF,$FF,$FF;80C15C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C16C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C17C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C18C;      ; 
                       db $FF,$FF,$FF,$FF,$10,$DA,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C19C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C1AC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C1BC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C1CC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C1DC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C1EC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C1FC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C20C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C21C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C22C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C23C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C24C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C25C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C26C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C27C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C28C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C29C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C2AC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C2BC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C2CC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C2DC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C2EC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C2FC;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C30C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C31C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C32C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C33C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C34C;      ; 
                       db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF;80C35C;      ; 
                       REP #$20                             ;80C36C;      ; 
                       SEP #$10                             ;80C36E;      ; 
                       LDA.W #$DD5B                         ;80C370;      ; 
                       STA.B $72                            ;80C373;000072; 
                       SEP #$20                             ;80C375;      ; 
                       LDA.B #$80                           ;80C377;      ; 
                       STA.B $74                            ;80C379;000074; 
                       SEP #$20                             ;80C37B;      ; 
                       LDA.B #$09                           ;80C37D;      ; 
                       LDX.B #$04                           ;80C37F;      ; 
                       LDY.B #$04                           ;80C381;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C383;808E48; 
                       REP #$20                             ;80C387;      ; 
                       SEP #$10                             ;80C389;      ; 
                       LDA.W #$DD78                         ;80C38B;      ; 
                       STA.B $72                            ;80C38E;000072; 
                       SEP #$20                             ;80C390;      ; 
                       LDA.B #$80                           ;80C392;      ; 
                       STA.B $74                            ;80C394;000074; 
                       SEP #$20                             ;80C396;      ; 
                       LDA.B #$0A                           ;80C398;      ; 
                       LDX.B #$05                           ;80C39A;      ; 
                       LDY.B #$04                           ;80C39C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C39E;808E48; 
                       REP #$20                             ;80C3A2;      ; 
                       SEP #$10                             ;80C3A4;      ; 
                       LDA.W #$DD95                         ;80C3A6;      ; 
                       STA.B $72                            ;80C3A9;000072; 
                       SEP #$20                             ;80C3AB;      ; 
                       LDA.B #$80                           ;80C3AD;      ; 
                       STA.B $74                            ;80C3AF;000074; 
                       SEP #$20                             ;80C3B1;      ; 
                       LDA.B #$0B                           ;80C3B3;      ; 
                       LDX.B #$06                           ;80C3B5;      ; 
                       LDY.B #$04                           ;80C3B7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C3B9;808E48; 
                       REP #$20                             ;80C3BD;      ; 
                       SEP #$10                             ;80C3BF;      ; 
                       LDA.W #$DDB2                         ;80C3C1;      ; 
                       STA.B $72                            ;80C3C4;000072; 
                       SEP #$20                             ;80C3C6;      ; 
                       LDA.B #$80                           ;80C3C8;      ; 
                       STA.B $74                            ;80C3CA;000074; 
                       SEP #$20                             ;80C3CC;      ; 
                       LDA.B #$0C                           ;80C3CE;      ; 
                       LDX.B #$07                           ;80C3D0;      ; 
                       LDY.B #$04                           ;80C3D2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C3D4;808E48; 
                       RTS                                  ;80C3D8;      ; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C3D9;      ; 
                       SEP #$10                             ;80C3DB;      ; 
                       LDA.W #$DDCF                         ;80C3DD;      ; 
                       STA.B $72                            ;80C3E0;000072; 
                       SEP #$20                             ;80C3E2;      ; 
                       LDA.B #$80                           ;80C3E4;      ; 
                       STA.B $74                            ;80C3E6;000074; 
                       SEP #$20                             ;80C3E8;      ; 
                       LDA.B #$09                           ;80C3EA;      ; 
                       LDX.B #$04                           ;80C3EC;      ; 
                       LDY.B #$04                           ;80C3EE;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C3F0;808E48; 
                       REP #$20                             ;80C3F4;      ; 
                       SEP #$10                             ;80C3F6;      ; 
                       LDA.W #$DDEC                         ;80C3F8;      ; 
                       STA.B $72                            ;80C3FB;000072; 
                       SEP #$20                             ;80C3FD;      ; 
                       LDA.B #$80                           ;80C3FF;      ; 
                       STA.B $74                            ;80C401;000074; 
                       SEP #$20                             ;80C403;      ; 
                       LDA.B #$0A                           ;80C405;      ; 
                       LDX.B #$05                           ;80C407;      ; 
                       LDY.B #$04                           ;80C409;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C40B;808E48; 
                       REP #$20                             ;80C40F;      ; 
                       SEP #$10                             ;80C411;      ; 
                       LDA.W #$DE09                         ;80C413;      ; 
                       STA.B $72                            ;80C416;000072; 
                       SEP #$20                             ;80C418;      ; 
                       LDA.B #$80                           ;80C41A;      ; 
                       STA.B $74                            ;80C41C;000074; 
                       SEP #$20                             ;80C41E;      ; 
                       LDA.B #$0B                           ;80C420;      ; 
                       LDX.B #$06                           ;80C422;      ; 
                       LDY.B #$04                           ;80C424;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C426;808E48; 
                       REP #$20                             ;80C42A;      ; 
                       SEP #$10                             ;80C42C;      ; 
                       LDA.W #$DE26                         ;80C42E;      ; 
                       STA.B $72                            ;80C431;000072; 
                       SEP #$20                             ;80C433;      ; 
                       LDA.B #$80                           ;80C435;      ; 
                       STA.B $74                            ;80C437;000074; 
                       SEP #$20                             ;80C439;      ; 
                       LDA.B #$0C                           ;80C43B;      ; 
                       LDX.B #$07                           ;80C43D;      ; 
                       LDY.B #$04                           ;80C43F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C441;808E48; 
                       RTS                                  ;80C445;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C446;      ; 
                       SEP #$10                             ;80C448;      ; 
                       LDA.W #$DE43                         ;80C44A;      ; 
                       STA.B $72                            ;80C44D;000072; 
                       SEP #$20                             ;80C44F;      ; 
                       LDA.B #$80                           ;80C451;      ; 
                       STA.B $74                            ;80C453;000074; 
                       SEP #$20                             ;80C455;      ; 
                       LDA.B #$09                           ;80C457;      ; 
                       LDX.B #$04                           ;80C459;      ; 
                       LDY.B #$04                           ;80C45B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C45D;808E48; 
                       REP #$20                             ;80C461;      ; 
                       SEP #$10                             ;80C463;      ; 
                       LDA.W #$DE60                         ;80C465;      ; 
                       STA.B $72                            ;80C468;000072; 
                       SEP #$20                             ;80C46A;      ; 
                       LDA.B #$80                           ;80C46C;      ; 
                       STA.B $74                            ;80C46E;000074; 
                       SEP #$20                             ;80C470;      ; 
                       LDA.B #$0A                           ;80C472;      ; 
                       LDX.B #$05                           ;80C474;      ; 
                       LDY.B #$04                           ;80C476;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C478;808E48; 
                       REP #$20                             ;80C47C;      ; 
                       SEP #$10                             ;80C47E;      ; 
                       LDA.W #$DE7D                         ;80C480;      ; 
                       STA.B $72                            ;80C483;000072; 
                       SEP #$20                             ;80C485;      ; 
                       LDA.B #$80                           ;80C487;      ; 
                       STA.B $74                            ;80C489;000074; 
                       SEP #$20                             ;80C48B;      ; 
                       LDA.B #$0B                           ;80C48D;      ; 
                       LDX.B #$06                           ;80C48F;      ; 
                       LDY.B #$04                           ;80C491;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C493;808E48; 
                       REP #$20                             ;80C497;      ; 
                       SEP #$10                             ;80C499;      ; 
                       LDA.W #$DE9A                         ;80C49B;      ; 
                       STA.B $72                            ;80C49E;000072; 
                       SEP #$20                             ;80C4A0;      ; 
                       LDA.B #$80                           ;80C4A2;      ; 
                       STA.B $74                            ;80C4A4;000074; 
                       SEP #$20                             ;80C4A6;      ; 
                       LDA.B #$0C                           ;80C4A8;      ; 
                       LDX.B #$07                           ;80C4AA;      ; 
                       LDY.B #$04                           ;80C4AC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C4AE;808E48; 
                       RTS                                  ;80C4B2;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C4B3;      ; 
                       SEP #$10                             ;80C4B5;      ; 
                       LDA.W #$DEB7                         ;80C4B7;      ; 
                       STA.B $72                            ;80C4BA;000072; 
                       SEP #$20                             ;80C4BC;      ; 
                       LDA.B #$80                           ;80C4BE;      ; 
                       STA.B $74                            ;80C4C0;000074; 
                       SEP #$20                             ;80C4C2;      ; 
                       LDA.B #$09                           ;80C4C4;      ; 
                       LDX.B #$04                           ;80C4C6;      ; 
                       LDY.B #$04                           ;80C4C8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C4CA;808E48; 
                       REP #$20                             ;80C4CE;      ; 
                       SEP #$10                             ;80C4D0;      ; 
                       LDA.W #$DED4                         ;80C4D2;      ; 
                       STA.B $72                            ;80C4D5;000072; 
                       SEP #$20                             ;80C4D7;      ; 
                       LDA.B #$80                           ;80C4D9;      ; 
                       STA.B $74                            ;80C4DB;000074; 
                       SEP #$20                             ;80C4DD;      ; 
                       LDA.B #$0A                           ;80C4DF;      ; 
                       LDX.B #$05                           ;80C4E1;      ; 
                       LDY.B #$04                           ;80C4E3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C4E5;808E48; 
                       REP #$20                             ;80C4E9;      ; 
                       SEP #$10                             ;80C4EB;      ; 
                       LDA.W #$DEF1                         ;80C4ED;      ; 
                       STA.B $72                            ;80C4F0;000072; 
                       SEP #$20                             ;80C4F2;      ; 
                       LDA.B #$80                           ;80C4F4;      ; 
                       STA.B $74                            ;80C4F6;000074; 
                       SEP #$20                             ;80C4F8;      ; 
                       LDA.B #$0B                           ;80C4FA;      ; 
                       LDX.B #$06                           ;80C4FC;      ; 
                       LDY.B #$04                           ;80C4FE;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C500;808E48; 
                       REP #$20                             ;80C504;      ; 
                       SEP #$10                             ;80C506;      ; 
                       LDA.W #$DF0E                         ;80C508;      ; 
                       STA.B $72                            ;80C50B;000072; 
                       SEP #$20                             ;80C50D;      ; 
                       LDA.B #$80                           ;80C50F;      ; 
                       STA.B $74                            ;80C511;000074; 
                       SEP #$20                             ;80C513;      ; 
                       LDA.B #$0C                           ;80C515;      ; 
                       LDX.B #$07                           ;80C517;      ; 
                       LDY.B #$04                           ;80C519;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C51B;808E48; 
                       RTS                                  ;80C51F;      ; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C520;      ; 
                       SEP #$10                             ;80C522;      ; 
                       LDA.W #$DF2B                         ;80C524;      ; 
                       STA.B $72                            ;80C527;000072; 
                       SEP #$20                             ;80C529;      ; 
                       LDA.B #$80                           ;80C52B;      ; 
                       STA.B $74                            ;80C52D;000074; 
                       SEP #$20                             ;80C52F;      ; 
                       LDA.B #$09                           ;80C531;      ; 
                       LDX.B #$04                           ;80C533;      ; 
                       LDY.B #$04                           ;80C535;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C537;808E48; 
                       REP #$20                             ;80C53B;      ; 
                       SEP #$10                             ;80C53D;      ; 
                       LDA.W #$DF48                         ;80C53F;      ; 
                       STA.B $72                            ;80C542;000072; 
                       SEP #$20                             ;80C544;      ; 
                       LDA.B #$80                           ;80C546;      ; 
                       STA.B $74                            ;80C548;000074; 
                       SEP #$20                             ;80C54A;      ; 
                       LDA.B #$0A                           ;80C54C;      ; 
                       LDX.B #$05                           ;80C54E;      ; 
                       LDY.B #$04                           ;80C550;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C552;808E48; 
                       REP #$20                             ;80C556;      ; 
                       SEP #$10                             ;80C558;      ; 
                       LDA.W #$DF65                         ;80C55A;      ; 
                       STA.B $72                            ;80C55D;000072; 
                       SEP #$20                             ;80C55F;      ; 
                       LDA.B #$80                           ;80C561;      ; 
                       STA.B $74                            ;80C563;000074; 
                       SEP #$20                             ;80C565;      ; 
                       LDA.B #$0B                           ;80C567;      ; 
                       LDX.B #$06                           ;80C569;      ; 
                       LDY.B #$04                           ;80C56B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C56D;808E48; 
                       REP #$20                             ;80C571;      ; 
                       SEP #$10                             ;80C573;      ; 
                       LDA.W #$DF82                         ;80C575;      ; 
                       STA.B $72                            ;80C578;000072; 
                       SEP #$20                             ;80C57A;      ; 
                       LDA.B #$80                           ;80C57C;      ; 
                       STA.B $74                            ;80C57E;000074; 
                       SEP #$20                             ;80C580;      ; 
                       LDA.B #$0C                           ;80C582;      ; 
                       LDX.B #$07                           ;80C584;      ; 
                       LDY.B #$04                           ;80C586;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C588;808E48; 
                       RTS                                  ;80C58C;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C58D;      ; 
                       SEP #$10                             ;80C58F;      ; 
                       LDA.W #$DF9F                         ;80C591;      ; 
                       STA.B $72                            ;80C594;000072; 
                       SEP #$20                             ;80C596;      ; 
                       LDA.B #$80                           ;80C598;      ; 
                       STA.B $74                            ;80C59A;000074; 
                       SEP #$20                             ;80C59C;      ; 
                       LDA.B #$09                           ;80C59E;      ; 
                       LDX.B #$04                           ;80C5A0;      ; 
                       LDY.B #$04                           ;80C5A2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C5A4;808E48; 
                       REP #$20                             ;80C5A8;      ; 
                       SEP #$10                             ;80C5AA;      ; 
                       LDA.W #$DFBC                         ;80C5AC;      ; 
                       STA.B $72                            ;80C5AF;000072; 
                       SEP #$20                             ;80C5B1;      ; 
                       LDA.B #$80                           ;80C5B3;      ; 
                       STA.B $74                            ;80C5B5;000074; 
                       SEP #$20                             ;80C5B7;      ; 
                       LDA.B #$0A                           ;80C5B9;      ; 
                       LDX.B #$05                           ;80C5BB;      ; 
                       LDY.B #$04                           ;80C5BD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C5BF;808E48; 
                       REP #$20                             ;80C5C3;      ; 
                       SEP #$10                             ;80C5C5;      ; 
                       LDA.W #$DFD9                         ;80C5C7;      ; 
                       STA.B $72                            ;80C5CA;000072; 
                       SEP #$20                             ;80C5CC;      ; 
                       LDA.B #$80                           ;80C5CE;      ; 
                       STA.B $74                            ;80C5D0;000074; 
                       SEP #$20                             ;80C5D2;      ; 
                       LDA.B #$0B                           ;80C5D4;      ; 
                       LDX.B #$06                           ;80C5D6;      ; 
                       LDY.B #$04                           ;80C5D8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C5DA;808E48; 
                       REP #$20                             ;80C5DE;      ; 
                       SEP #$10                             ;80C5E0;      ; 
                       LDA.W #$DFF6                         ;80C5E2;      ; 
                       STA.B $72                            ;80C5E5;000072; 
                       SEP #$20                             ;80C5E7;      ; 
                       LDA.B #$80                           ;80C5E9;      ; 
                       STA.B $74                            ;80C5EB;000074; 
                       SEP #$20                             ;80C5ED;      ; 
                       LDA.B #$0C                           ;80C5EF;      ; 
                       LDX.B #$07                           ;80C5F1;      ; 
                       LDY.B #$04                           ;80C5F3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C5F5;808E48; 
                       RTS                                  ;80C5F9;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C5FA;      ; 
                       SEP #$10                             ;80C5FC;      ; 
                       LDA.W #$E013                         ;80C5FE;      ; 
                       STA.B $72                            ;80C601;000072; 
                       SEP #$20                             ;80C603;      ; 
                       LDA.B #$80                           ;80C605;      ; 
                       STA.B $74                            ;80C607;000074; 
                       SEP #$20                             ;80C609;      ; 
                       LDA.B #$09                           ;80C60B;      ; 
                       LDX.B #$04                           ;80C60D;      ; 
                       LDY.B #$04                           ;80C60F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C611;808E48; 
                       REP #$20                             ;80C615;      ; 
                       SEP #$10                             ;80C617;      ; 
                       LDA.W #$E030                         ;80C619;      ; 
                       STA.B $72                            ;80C61C;000072; 
                       SEP #$20                             ;80C61E;      ; 
                       LDA.B #$80                           ;80C620;      ; 
                       STA.B $74                            ;80C622;000074; 
                       SEP #$20                             ;80C624;      ; 
                       LDA.B #$0A                           ;80C626;      ; 
                       LDX.B #$05                           ;80C628;      ; 
                       LDY.B #$04                           ;80C62A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C62C;808E48; 
                       REP #$20                             ;80C630;      ; 
                       SEP #$10                             ;80C632;      ; 
                       LDA.W #$E04D                         ;80C634;      ; 
                       STA.B $72                            ;80C637;000072; 
                       SEP #$20                             ;80C639;      ; 
                       LDA.B #$80                           ;80C63B;      ; 
                       STA.B $74                            ;80C63D;000074; 
                       SEP #$20                             ;80C63F;      ; 
                       LDA.B #$0B                           ;80C641;      ; 
                       LDX.B #$06                           ;80C643;      ; 
                       LDY.B #$04                           ;80C645;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C647;808E48; 
                       REP #$20                             ;80C64B;      ; 
                       SEP #$10                             ;80C64D;      ; 
                       LDA.W #$E06A                         ;80C64F;      ; 
                       STA.B $72                            ;80C652;000072; 
                       SEP #$20                             ;80C654;      ; 
                       LDA.B #$80                           ;80C656;      ; 
                       STA.B $74                            ;80C658;000074; 
                       SEP #$20                             ;80C65A;      ; 
                       LDA.B #$0C                           ;80C65C;      ; 
                       LDX.B #$07                           ;80C65E;      ; 
                       LDY.B #$04                           ;80C660;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C662;808E48; 
                       RTS                                  ;80C666;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C667;      ; 
                       SEP #$10                             ;80C669;      ; 
                       LDA.W #$E087                         ;80C66B;      ; 
                       STA.B $72                            ;80C66E;000072; 
                       SEP #$20                             ;80C670;      ; 
                       LDA.B #$80                           ;80C672;      ; 
                       STA.B $74                            ;80C674;000074; 
                       SEP #$20                             ;80C676;      ; 
                       LDA.B #$09                           ;80C678;      ; 
                       LDX.B #$04                           ;80C67A;      ; 
                       LDY.B #$04                           ;80C67C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C67E;808E48; 
                       REP #$20                             ;80C682;      ; 
                       SEP #$10                             ;80C684;      ; 
                       LDA.W #$E0A4                         ;80C686;      ; 
                       STA.B $72                            ;80C689;000072; 
                       SEP #$20                             ;80C68B;      ; 
                       LDA.B #$80                           ;80C68D;      ; 
                       STA.B $74                            ;80C68F;000074; 
                       SEP #$20                             ;80C691;      ; 
                       LDA.B #$0A                           ;80C693;      ; 
                       LDX.B #$05                           ;80C695;      ; 
                       LDY.B #$04                           ;80C697;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C699;808E48; 
                       REP #$20                             ;80C69D;      ; 
                       SEP #$10                             ;80C69F;      ; 
                       LDA.W #$E0C1                         ;80C6A1;      ; 
                       STA.B $72                            ;80C6A4;000072; 
                       SEP #$20                             ;80C6A6;      ; 
                       LDA.B #$80                           ;80C6A8;      ; 
                       STA.B $74                            ;80C6AA;000074; 
                       SEP #$20                             ;80C6AC;      ; 
                       LDA.B #$0B                           ;80C6AE;      ; 
                       LDX.B #$06                           ;80C6B0;      ; 
                       LDY.B #$04                           ;80C6B2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C6B4;808E48; 
                       REP #$20                             ;80C6B8;      ; 
                       SEP #$10                             ;80C6BA;      ; 
                       LDA.W #$E0DE                         ;80C6BC;      ; 
                       STA.B $72                            ;80C6BF;000072; 
                       SEP #$20                             ;80C6C1;      ; 
                       LDA.B #$80                           ;80C6C3;      ; 
                       STA.B $74                            ;80C6C5;000074; 
                       SEP #$20                             ;80C6C7;      ; 
                       LDA.B #$0C                           ;80C6C9;      ; 
                       LDX.B #$07                           ;80C6CB;      ; 
                       LDY.B #$04                           ;80C6CD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C6CF;808E48; 
                       RTS                                  ;80C6D3;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C6D4;      ; 
                       SEP #$10                             ;80C6D6;      ; 
                       LDA.W #$E0FB                         ;80C6D8;      ; 
                       STA.B $72                            ;80C6DB;000072; 
                       SEP #$20                             ;80C6DD;      ; 
                       LDA.B #$80                           ;80C6DF;      ; 
                       STA.B $74                            ;80C6E1;000074; 
                       SEP #$20                             ;80C6E3;      ; 
                       LDA.B #$06                           ;80C6E5;      ; 
                       LDX.B #$04                           ;80C6E7;      ; 
                       LDY.B #$02                           ;80C6E9;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C6EB;808E48; 
                       REP #$20                             ;80C6EF;      ; 
                       SEP #$10                             ;80C6F1;      ; 
                       LDA.W #$E10C                         ;80C6F3;      ; 
                       STA.B $72                            ;80C6F6;000072; 
                       SEP #$20                             ;80C6F8;      ; 
                       LDA.B #$80                           ;80C6FA;      ; 
                       STA.B $74                            ;80C6FC;000074; 
                       SEP #$20                             ;80C6FE;      ; 
                       LDA.B #$07                           ;80C700;      ; 
                       LDX.B #$05                           ;80C702;      ; 
                       LDY.B #$02                           ;80C704;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C706;808E48; 
                       REP #$20                             ;80C70A;      ; 
                       SEP #$10                             ;80C70C;      ; 
                       LDA.W #$E11D                         ;80C70E;      ; 
                       STA.B $72                            ;80C711;000072; 
                       SEP #$20                             ;80C713;      ; 
                       LDA.B #$80                           ;80C715;      ; 
                       STA.B $74                            ;80C717;000074; 
                       SEP #$20                             ;80C719;      ; 
                       LDA.B #$0B                           ;80C71B;      ; 
                       LDX.B #$06                           ;80C71D;      ; 
                       LDY.B #$02                           ;80C71F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C721;808E48; 
                       REP #$20                             ;80C725;      ; 
                       SEP #$10                             ;80C727;      ; 
                       LDA.W #$E12E                         ;80C729;      ; 
                       STA.B $72                            ;80C72C;000072; 
                       SEP #$20                             ;80C72E;      ; 
                       LDA.B #$80                           ;80C730;      ; 
                       STA.B $74                            ;80C732;000074; 
                       SEP #$20                             ;80C734;      ; 
                       LDA.B #$0C                           ;80C736;      ; 
                       LDX.B #$07                           ;80C738;      ; 
                       LDY.B #$02                           ;80C73A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C73C;808E48; 
                       REP #$20                             ;80C740;      ; 
                       SEP #$10                             ;80C742;      ; 
                       LDA.W #$E13F                         ;80C744;      ; 
                       STA.B $72                            ;80C747;000072; 
                       SEP #$20                             ;80C749;      ; 
                       LDA.B #$80                           ;80C74B;      ; 
                       STA.B $74                            ;80C74D;000074; 
                       SEP #$20                             ;80C74F;      ; 
                       LDA.B #$0D                           ;80C751;      ; 
                       LDX.B #$08                           ;80C753;      ; 
                       LDY.B #$02                           ;80C755;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C757;808E48; 
                       REP #$20                             ;80C75B;      ; 
                       SEP #$10                             ;80C75D;      ; 
                       LDA.W #$E150                         ;80C75F;      ; 
                       STA.B $72                            ;80C762;000072; 
                       SEP #$20                             ;80C764;      ; 
                       LDA.B #$80                           ;80C766;      ; 
                       STA.B $74                            ;80C768;000074; 
                       SEP #$20                             ;80C76A;      ; 
                       LDA.B #$0E                           ;80C76C;      ; 
                       LDX.B #$09                           ;80C76E;      ; 
                       LDY.B #$02                           ;80C770;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C772;808E48; 
                       REP #$20                             ;80C776;      ; 
                       SEP #$10                             ;80C778;      ; 
                       LDA.W #$E161                         ;80C77A;      ; 
                       STA.B $72                            ;80C77D;000072; 
                       SEP #$20                             ;80C77F;      ; 
                       LDA.B #$80                           ;80C781;      ; 
                       STA.B $74                            ;80C783;000074; 
                       SEP #$20                             ;80C785;      ; 
                       LDA.B #$0F                           ;80C787;      ; 
                       LDX.B #$0A                           ;80C789;      ; 
                       LDY.B #$02                           ;80C78B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C78D;808E48; 
                       RTS                                  ;80C791;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C792;      ; 
                       SEP #$10                             ;80C794;      ; 
                       LDA.W #$E172                         ;80C796;      ; 
                       STA.B $72                            ;80C799;000072; 
                       SEP #$20                             ;80C79B;      ; 
                       LDA.B #$80                           ;80C79D;      ; 
                       STA.B $74                            ;80C79F;000074; 
                       SEP #$20                             ;80C7A1;      ; 
                       LDA.B #$02                           ;80C7A3;      ; 
                       LDX.B #$04                           ;80C7A5;      ; 
                       LDY.B #$03                           ;80C7A7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C7A9;808E48; 
                       REP #$20                             ;80C7AD;      ; 
                       SEP #$10                             ;80C7AF;      ; 
                       LDA.W #$E17D                         ;80C7B1;      ; 
                       STA.B $72                            ;80C7B4;000072; 
                       SEP #$20                             ;80C7B6;      ; 
                       LDA.B #$80                           ;80C7B8;      ; 
                       STA.B $74                            ;80C7BA;000074; 
                       SEP #$20                             ;80C7BC;      ; 
                       LDA.B #$0D                           ;80C7BE;      ; 
                       LDX.B #$05                           ;80C7C0;      ; 
                       LDY.B #$03                           ;80C7C2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C7C4;808E48; 
                       REP #$20                             ;80C7C8;      ; 
                       SEP #$10                             ;80C7CA;      ; 
                       LDA.W #$E188                         ;80C7CC;      ; 
                       STA.B $72                            ;80C7CF;000072; 
                       SEP #$20                             ;80C7D1;      ; 
                       LDA.B #$80                           ;80C7D3;      ; 
                       STA.B $74                            ;80C7D5;000074; 
                       SEP #$20                             ;80C7D7;      ; 
                       LDA.B #$0E                           ;80C7D9;      ; 
                       LDX.B #$06                           ;80C7DB;      ; 
                       LDY.B #$03                           ;80C7DD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C7DF;808E48; 
                       REP #$20                             ;80C7E3;      ; 
                       SEP #$10                             ;80C7E5;      ; 
                       LDA.W #$E193                         ;80C7E7;      ; 
                       STA.B $72                            ;80C7EA;000072; 
                       SEP #$20                             ;80C7EC;      ; 
                       LDA.B #$80                           ;80C7EE;      ; 
                       STA.B $74                            ;80C7F0;000074; 
                       SEP #$20                             ;80C7F2;      ; 
                       LDA.B #$0F                           ;80C7F4;      ; 
                       LDX.B #$07                           ;80C7F6;      ; 
                       LDY.B #$03                           ;80C7F8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C7FA;808E48; 
                       RTS                                  ;80C7FE;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C7FF;      ; 
                       SEP #$10                             ;80C801;      ; 
                       LDA.W #$E19E                         ;80C803;      ; 
                       STA.B $72                            ;80C806;000072; 
                       SEP #$20                             ;80C808;      ; 
                       LDA.B #$80                           ;80C80A;      ; 
                       STA.B $74                            ;80C80C;000074; 
                       SEP #$20                             ;80C80E;      ; 
                       LDA.B #$07                           ;80C810;      ; 
                       LDX.B #$04                           ;80C812;      ; 
                       LDY.B #$01                           ;80C814;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C816;808E48; 
                       REP #$20                             ;80C81A;      ; 
                       SEP #$10                             ;80C81C;      ; 
                       LDA.W #$E1A9                         ;80C81E;      ; 
                       STA.B $72                            ;80C821;000072; 
                       SEP #$20                             ;80C823;      ; 
                       LDA.B #$80                           ;80C825;      ; 
                       STA.B $74                            ;80C827;000074; 
                       SEP #$20                             ;80C829;      ; 
                       LDA.B #$08                           ;80C82B;      ; 
                       LDX.B #$05                           ;80C82D;      ; 
                       LDY.B #$01                           ;80C82F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C831;808E48; 
                       REP #$20                             ;80C835;      ; 
                       SEP #$10                             ;80C837;      ; 
                       LDA.W #$E1B4                         ;80C839;      ; 
                       STA.B $72                            ;80C83C;000072; 
                       SEP #$20                             ;80C83E;      ; 
                       LDA.B #$80                           ;80C840;      ; 
                       STA.B $74                            ;80C842;000074; 
                       SEP #$20                             ;80C844;      ; 
                       LDA.B #$09                           ;80C846;      ; 
                       LDX.B #$06                           ;80C848;      ; 
                       LDY.B #$01                           ;80C84A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C84C;808E48; 
                       REP #$20                             ;80C850;      ; 
                       SEP #$10                             ;80C852;      ; 
                       LDA.W #$E1BF                         ;80C854;      ; 
                       STA.B $72                            ;80C857;000072; 
                       SEP #$20                             ;80C859;      ; 
                       LDA.B #$80                           ;80C85B;      ; 
                       STA.B $74                            ;80C85D;000074; 
                       SEP #$20                             ;80C85F;      ; 
                       LDA.B #$09                           ;80C861;      ; 
                       LDX.B #$07                           ;80C863;      ; 
                       LDY.B #$02                           ;80C865;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C867;808E48; 
                       RTS                                  ;80C86B;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C86C;      ; 
                       SEP #$10                             ;80C86E;      ; 
                       LDA.W #$E1CA                         ;80C870;      ; 
                       STA.B $72                            ;80C873;000072; 
                       SEP #$20                             ;80C875;      ; 
                       LDA.B #$80                           ;80C877;      ; 
                       STA.B $74                            ;80C879;000074; 
                       SEP #$20                             ;80C87B;      ; 
                       LDA.B #$01                           ;80C87D;      ; 
                       LDX.B #$04                           ;80C87F;      ; 
                       LDY.B #$05                           ;80C881;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C883;808E48; 
                       REP #$20                             ;80C887;      ; 
                       SEP #$10                             ;80C889;      ; 
                       LDA.W #$E1DB                         ;80C88B;      ; 
                       STA.B $72                            ;80C88E;000072; 
                       SEP #$20                             ;80C890;      ; 
                       LDA.B #$80                           ;80C892;      ; 
                       STA.B $74                            ;80C894;000074; 
                       SEP #$20                             ;80C896;      ; 
                       LDA.B #$04                           ;80C898;      ; 
                       LDX.B #$05                           ;80C89A;      ; 
                       LDY.B #$05                           ;80C89C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C89E;808E48; 
                       REP #$20                             ;80C8A2;      ; 
                       SEP #$10                             ;80C8A4;      ; 
                       LDA.W #$E1EC                         ;80C8A6;      ; 
                       STA.B $72                            ;80C8A9;000072; 
                       SEP #$20                             ;80C8AB;      ; 
                       LDA.B #$80                           ;80C8AD;      ; 
                       STA.B $74                            ;80C8AF;000074; 
                       SEP #$20                             ;80C8B1;      ; 
                       LDA.B #$07                           ;80C8B3;      ; 
                       LDX.B #$06                           ;80C8B5;      ; 
                       LDY.B #$05                           ;80C8B7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C8B9;808E48; 
                       REP #$20                             ;80C8BD;      ; 
                       SEP #$10                             ;80C8BF;      ; 
                       LDA.W #$E1FD                         ;80C8C1;      ; 
                       STA.B $72                            ;80C8C4;000072; 
                       SEP #$20                             ;80C8C6;      ; 
                       LDA.B #$80                           ;80C8C8;      ; 
                       STA.B $74                            ;80C8CA;000074; 
                       SEP #$20                             ;80C8CC;      ; 
                       LDA.B #$08                           ;80C8CE;      ; 
                       LDX.B #$07                           ;80C8D0;      ; 
                       LDY.B #$05                           ;80C8D2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C8D4;808E48; 
                       REP #$20                             ;80C8D8;      ; 
                       SEP #$10                             ;80C8DA;      ; 
                       LDA.W #$E20E                         ;80C8DC;      ; 
                       STA.B $72                            ;80C8DF;000072; 
                       SEP #$20                             ;80C8E1;      ; 
                       LDA.B #$80                           ;80C8E3;      ; 
                       STA.B $74                            ;80C8E5;000074; 
                       SEP #$20                             ;80C8E7;      ; 
                       LDA.B #$09                           ;80C8E9;      ; 
                       LDX.B #$08                           ;80C8EB;      ; 
                       LDY.B #$05                           ;80C8ED;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C8EF;808E48; 
                       REP #$20                             ;80C8F3;      ; 
                       SEP #$10                             ;80C8F5;      ; 
                       LDA.W #$E21F                         ;80C8F7;      ; 
                       STA.B $72                            ;80C8FA;000072; 
                       SEP #$20                             ;80C8FC;      ; 
                       LDA.B #$80                           ;80C8FE;      ; 
                       STA.B $74                            ;80C900;000074; 
                       SEP #$20                             ;80C902;      ; 
                       LDA.B #$0B                           ;80C904;      ; 
                       LDX.B #$09                           ;80C906;      ; 
                       LDY.B #$05                           ;80C908;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C90A;808E48; 
                       REP #$20                             ;80C90E;      ; 
                       SEP #$10                             ;80C910;      ; 
                       LDA.W #$E230                         ;80C912;      ; 
                       STA.B $72                            ;80C915;000072; 
                       SEP #$20                             ;80C917;      ; 
                       LDA.B #$80                           ;80C919;      ; 
                       STA.B $74                            ;80C91B;000074; 
                       SEP #$20                             ;80C91D;      ; 
                       LDA.B #$0D                           ;80C91F;      ; 
                       LDX.B #$0A                           ;80C921;      ; 
                       LDY.B #$05                           ;80C923;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C925;808E48; 
                       REP #$20                             ;80C929;      ; 
                       SEP #$10                             ;80C92B;      ; 
                       LDA.W #$E241                         ;80C92D;      ; 
                       STA.B $72                            ;80C930;000072; 
                       SEP #$20                             ;80C932;      ; 
                       LDA.B #$80                           ;80C934;      ; 
                       STA.B $74                            ;80C936;000074; 
                       SEP #$20                             ;80C938;      ; 
                       LDA.B #$0E                           ;80C93A;      ; 
                       LDX.B #$0B                           ;80C93C;      ; 
                       LDY.B #$05                           ;80C93E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C940;808E48; 
                       RTS                                  ;80C944;      ; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C945;      ; 
                       SEP #$10                             ;80C947;      ; 
                       LDA.W #$E252                         ;80C949;      ; 
                       STA.B $72                            ;80C94C;000072; 
                       SEP #$20                             ;80C94E;      ; 
                       LDA.B #$80                           ;80C950;      ; 
                       STA.B $74                            ;80C952;000074; 
                       SEP #$20                             ;80C954;      ; 
                       LDA.B #$08                           ;80C956;      ; 
                       LDX.B #$04                           ;80C958;      ; 
                       LDY.B #$01                           ;80C95A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C95C;808E48; 
                       REP #$20                             ;80C960;      ; 
                       SEP #$10                             ;80C962;      ; 
                       LDA.W #$E25D                         ;80C964;      ; 
                       STA.B $72                            ;80C967;000072; 
                       SEP #$20                             ;80C969;      ; 
                       LDA.B #$80                           ;80C96B;      ; 
                       STA.B $74                            ;80C96D;000074; 
                       SEP #$20                             ;80C96F;      ; 
                       LDA.B #$0B                           ;80C971;      ; 
                       LDX.B #$05                           ;80C973;      ; 
                       LDY.B #$01                           ;80C975;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C977;808E48; 
                       REP #$20                             ;80C97B;      ; 
                       SEP #$10                             ;80C97D;      ; 
                       LDA.W #$E268                         ;80C97F;      ; 
                       STA.B $72                            ;80C982;000072; 
                       SEP #$20                             ;80C984;      ; 
                       LDA.B #$80                           ;80C986;      ; 
                       STA.B $74                            ;80C988;000074; 
                       SEP #$20                             ;80C98A;      ; 
                       LDA.B #$0C                           ;80C98C;      ; 
                       LDX.B #$06                           ;80C98E;      ; 
                       LDY.B #$01                           ;80C990;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C992;808E48; 
                       REP #$20                             ;80C996;      ; 
                       SEP #$10                             ;80C998;      ; 
                       LDA.W #$E273                         ;80C99A;      ; 
                       STA.B $72                            ;80C99D;000072; 
                       SEP #$20                             ;80C99F;      ; 
                       LDA.B #$80                           ;80C9A1;      ; 
                       STA.B $74                            ;80C9A3;000074; 
                       SEP #$20                             ;80C9A5;      ; 
                       LDA.B #$0D                           ;80C9A7;      ; 
                       LDX.B #$07                           ;80C9A9;      ; 
                       LDY.B #$01                           ;80C9AB;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C9AD;808E48; 
                       RTS                                  ;80C9B1;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80C9B2;      ; 
                       SEP #$10                             ;80C9B4;      ; 
                       LDA.W #$E27E                         ;80C9B6;      ; 
                       STA.B $72                            ;80C9B9;000072; 
                       SEP #$20                             ;80C9BB;      ; 
                       LDA.B #$80                           ;80C9BD;      ; 
                       STA.B $74                            ;80C9BF;000074; 
                       SEP #$20                             ;80C9C1;      ; 
                       LDA.B #$07                           ;80C9C3;      ; 
                       LDX.B #$04                           ;80C9C5;      ; 
                       LDY.B #$02                           ;80C9C7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C9C9;808E48; 
                       REP #$20                             ;80C9CD;      ; 
                       SEP #$10                             ;80C9CF;      ; 
                       LDA.W #$E289                         ;80C9D1;      ; 
                       STA.B $72                            ;80C9D4;000072; 
                       SEP #$20                             ;80C9D6;      ; 
                       LDA.B #$80                           ;80C9D8;      ; 
                       STA.B $74                            ;80C9DA;000074; 
                       SEP #$20                             ;80C9DC;      ; 
                       LDA.B #$08                           ;80C9DE;      ; 
                       LDX.B #$05                           ;80C9E0;      ; 
                       LDY.B #$02                           ;80C9E2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C9E4;808E48; 
                       REP #$20                             ;80C9E8;      ; 
                       SEP #$10                             ;80C9EA;      ; 
                       LDA.W #$E294                         ;80C9EC;      ; 
                       STA.B $72                            ;80C9EF;000072; 
                       SEP #$20                             ;80C9F1;      ; 
                       LDA.B #$80                           ;80C9F3;      ; 
                       STA.B $74                            ;80C9F5;000074; 
                       SEP #$20                             ;80C9F7;      ; 
                       LDA.B #$0D                           ;80C9F9;      ; 
                       LDX.B #$06                           ;80C9FB;      ; 
                       LDY.B #$02                           ;80C9FD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80C9FF;808E48; 
                       REP #$20                             ;80CA03;      ; 
                       SEP #$10                             ;80CA05;      ; 
                       LDA.W #$E29F                         ;80CA07;      ; 
                       STA.B $72                            ;80CA0A;000072; 
                       SEP #$20                             ;80CA0C;      ; 
                       LDA.B #$80                           ;80CA0E;      ; 
                       STA.B $74                            ;80CA10;000074; 
                       SEP #$20                             ;80CA12;      ; 
                       LDA.B #$0E                           ;80CA14;      ; 
                       LDX.B #$07                           ;80CA16;      ; 
                       LDY.B #$02                           ;80CA18;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CA1A;808E48; 
                       RTS                                  ;80CA1E;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CA1F;      ; 
                       SEP #$10                             ;80CA21;      ; 
                       LDA.W #$E2AA                         ;80CA23;      ; 
                       STA.B $72                            ;80CA26;000072; 
                       SEP #$20                             ;80CA28;      ; 
                       LDA.B #$80                           ;80CA2A;      ; 
                       STA.B $74                            ;80CA2C;000074; 
                       SEP #$20                             ;80CA2E;      ; 
                       LDA.B #$0A                           ;80CA30;      ; 
                       LDX.B #$04                           ;80CA32;      ; 
                       LDY.B #$01                           ;80CA34;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CA36;808E48; 
                       REP #$20                             ;80CA3A;      ; 
                       SEP #$10                             ;80CA3C;      ; 
                       LDA.W #$E2B5                         ;80CA3E;      ; 
                       STA.B $72                            ;80CA41;000072; 
                       SEP #$20                             ;80CA43;      ; 
                       LDA.B #$80                           ;80CA45;      ; 
                       STA.B $74                            ;80CA47;000074; 
                       SEP #$20                             ;80CA49;      ; 
                       LDA.B #$0B                           ;80CA4B;      ; 
                       LDX.B #$05                           ;80CA4D;      ; 
                       LDY.B #$01                           ;80CA4F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CA51;808E48; 
                       REP #$20                             ;80CA55;      ; 
                       SEP #$10                             ;80CA57;      ; 
                       LDA.W #$E2C0                         ;80CA59;      ; 
                       STA.B $72                            ;80CA5C;000072; 
                       SEP #$20                             ;80CA5E;      ; 
                       LDA.B #$80                           ;80CA60;      ; 
                       STA.B $74                            ;80CA62;000074; 
                       SEP #$20                             ;80CA64;      ; 
                       LDA.B #$0C                           ;80CA66;      ; 
                       LDX.B #$06                           ;80CA68;      ; 
                       LDY.B #$01                           ;80CA6A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CA6C;808E48; 
                       REP #$20                             ;80CA70;      ; 
                       SEP #$10                             ;80CA72;      ; 
                       LDA.W #$E2CB                         ;80CA74;      ; 
                       STA.B $72                            ;80CA77;000072; 
                       SEP #$20                             ;80CA79;      ; 
                       LDA.B #$80                           ;80CA7B;      ; 
                       STA.B $74                            ;80CA7D;000074; 
                       SEP #$20                             ;80CA7F;      ; 
                       LDA.B #$0D                           ;80CA81;      ; 
                       LDX.B #$07                           ;80CA83;      ; 
                       LDY.B #$01                           ;80CA85;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CA87;808E48; 
                       RTS                                  ;80CA8B;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CA8C;      ; 
                       SEP #$10                             ;80CA8E;      ; 
                       LDA.W #$E2D6                         ;80CA90;      ; 
                       STA.B $72                            ;80CA93;000072; 
                       SEP #$20                             ;80CA95;      ; 
                       LDA.B #$80                           ;80CA97;      ; 
                       STA.B $74                            ;80CA99;000074; 
                       SEP #$20                             ;80CA9B;      ; 
                       LDA.B #$0D                           ;80CA9D;      ; 
                       LDX.B #$04                           ;80CA9F;      ; 
                       LDY.B #$02                           ;80CAA1;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CAA3;808E48; 
                       REP #$20                             ;80CAA7;      ; 
                       SEP #$10                             ;80CAA9;      ; 
                       LDA.W #$E2E1                         ;80CAAB;      ; 
                       STA.B $72                            ;80CAAE;000072; 
                       SEP #$20                             ;80CAB0;      ; 
                       LDA.B #$80                           ;80CAB2;      ; 
                       STA.B $74                            ;80CAB4;000074; 
                       SEP #$20                             ;80CAB6;      ; 
                       LDA.B #$0E                           ;80CAB8;      ; 
                       LDX.B #$05                           ;80CABA;      ; 
                       LDY.B #$02                           ;80CABC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CABE;808E48; 
                       REP #$20                             ;80CAC2;      ; 
                       SEP #$10                             ;80CAC4;      ; 
                       LDA.W #$E2EC                         ;80CAC6;      ; 
                       STA.B $72                            ;80CAC9;000072; 
                       SEP #$20                             ;80CACB;      ; 
                       LDA.B #$80                           ;80CACD;      ; 
                       STA.B $74                            ;80CACF;000074; 
                       SEP #$20                             ;80CAD1;      ; 
                       LDA.B #$0F                           ;80CAD3;      ; 
                       LDX.B #$06                           ;80CAD5;      ; 
                       LDY.B #$02                           ;80CAD7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CAD9;808E48; 
                       RTS                                  ;80CADD;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CADE;      ; 
                       SEP #$10                             ;80CAE0;      ; 
                       LDA.W #$E2F7                         ;80CAE2;      ; 
                       STA.B $72                            ;80CAE5;000072; 
                       SEP #$20                             ;80CAE7;      ; 
                       LDA.B #$80                           ;80CAE9;      ; 
                       STA.B $74                            ;80CAEB;000074; 
                       SEP #$20                             ;80CAED;      ; 
                       LDA.B #$06                           ;80CAEF;      ; 
                       LDX.B #$04                           ;80CAF1;      ; 
                       LDY.B #$02                           ;80CAF3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CAF5;808E48; 
                       REP #$20                             ;80CAF9;      ; 
                       SEP #$10                             ;80CAFB;      ; 
                       LDA.W #$E305                         ;80CAFD;      ; 
                       STA.B $72                            ;80CB00;000072; 
                       SEP #$20                             ;80CB02;      ; 
                       LDA.B #$80                           ;80CB04;      ; 
                       STA.B $74                            ;80CB06;000074; 
                       SEP #$20                             ;80CB08;      ; 
                       LDA.B #$0E                           ;80CB0A;      ; 
                       LDX.B #$05                           ;80CB0C;      ; 
                       LDY.B #$02                           ;80CB0E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CB10;808E48; 
                       REP #$20                             ;80CB14;      ; 
                       SEP #$10                             ;80CB16;      ; 
                       LDA.W #$E313                         ;80CB18;      ; 
                       STA.B $72                            ;80CB1B;000072; 
                       SEP #$20                             ;80CB1D;      ; 
                       LDA.B #$80                           ;80CB1F;      ; 
                       STA.B $74                            ;80CB21;000074; 
                       SEP #$20                             ;80CB23;      ; 
                       LDA.B #$0F                           ;80CB25;      ; 
                       LDX.B #$06                           ;80CB27;      ; 
                       LDY.B #$02                           ;80CB29;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CB2B;808E48; 
                       RTS                                  ;80CB2F;      ; 
                                                            ;      ;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CB30;      ; 
                       SEP #$10                             ;80CB32;      ; 
                       LDA.W #$E321                         ;80CB34;      ; 
                       STA.B $72                            ;80CB37;000072; 
                       SEP #$20                             ;80CB39;      ; 
                       LDA.B #$80                           ;80CB3B;      ; 
                       STA.B $74                            ;80CB3D;000074; 
                       SEP #$20                             ;80CB3F;      ; 
                       LDA.B #$06                           ;80CB41;      ; 
                       LDX.B #$04                           ;80CB43;      ; 
                       LDY.B #$02                           ;80CB45;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CB47;808E48; 
                       REP #$20                             ;80CB4B;      ; 
                       SEP #$10                             ;80CB4D;      ; 
                       LDA.W #$E32F                         ;80CB4F;      ; 
                       STA.B $72                            ;80CB52;000072; 
                       SEP #$20                             ;80CB54;      ; 
                       LDA.B #$80                           ;80CB56;      ; 
                       STA.B $74                            ;80CB58;000074; 
                       SEP #$20                             ;80CB5A;      ; 
                       LDA.B #$0E                           ;80CB5C;      ; 
                       LDX.B #$05                           ;80CB5E;      ; 
                       LDY.B #$02                           ;80CB60;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CB62;808E48; 
                       REP #$20                             ;80CB66;      ; 
                       SEP #$10                             ;80CB68;      ; 
                       LDA.W #$E33D                         ;80CB6A;      ; 
                       STA.B $72                            ;80CB6D;000072; 
                       SEP #$20                             ;80CB6F;      ; 
                       LDA.B #$80                           ;80CB71;      ; 
                       STA.B $74                            ;80CB73;000074; 
                       SEP #$20                             ;80CB75;      ; 
                       LDA.B #$0F                           ;80CB77;      ; 
                       LDX.B #$06                           ;80CB79;      ; 
                       LDY.B #$02                           ;80CB7B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CB7D;808E48; 
                       RTS                                  ;80CB81;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CB82;      ; 
                       SEP #$10                             ;80CB84;      ; 
                       LDA.W #$E34B                         ;80CB86;      ; 
                       STA.B $72                            ;80CB89;000072; 
                       SEP #$20                             ;80CB8B;      ; 
                       LDA.B #$80                           ;80CB8D;      ; 
                       STA.B $74                            ;80CB8F;000074; 
                       SEP #$20                             ;80CB91;      ; 
                       LDA.B #$06                           ;80CB93;      ; 
                       LDX.B #$04                           ;80CB95;      ; 
                       LDY.B #$02                           ;80CB97;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CB99;808E48; 
                       REP #$20                             ;80CB9D;      ; 
                       SEP #$10                             ;80CB9F;      ; 
                       LDA.W #$E359                         ;80CBA1;      ; 
                       STA.B $72                            ;80CBA4;000072; 
                       SEP #$20                             ;80CBA6;      ; 
                       LDA.B #$80                           ;80CBA8;      ; 
                       STA.B $74                            ;80CBAA;000074; 
                       SEP #$20                             ;80CBAC;      ; 
                       LDA.B #$0E                           ;80CBAE;      ; 
                       LDX.B #$05                           ;80CBB0;      ; 
                       LDY.B #$02                           ;80CBB2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CBB4;808E48; 
                       REP #$20                             ;80CBB8;      ; 
                       SEP #$10                             ;80CBBA;      ; 
                       LDA.W #$E367                         ;80CBBC;      ; 
                       STA.B $72                            ;80CBBF;000072; 
                       SEP #$20                             ;80CBC1;      ; 
                       LDA.B #$80                           ;80CBC3;      ; 
                       STA.B $74                            ;80CBC5;000074; 
                       SEP #$20                             ;80CBC7;      ; 
                       LDA.B #$0F                           ;80CBC9;      ; 
                       LDX.B #$06                           ;80CBCB;      ; 
                       LDY.B #$02                           ;80CBCD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CBCF;808E48; 
                       RTS                                  ;80CBD3;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CBD4;      ; 
                       SEP #$10                             ;80CBD6;      ; 
                       LDA.W #$E375                         ;80CBD8;      ; 
                       STA.B $72                            ;80CBDB;000072; 
                       SEP #$20                             ;80CBDD;      ; 
                       LDA.B #$80                           ;80CBDF;      ; 
                       STA.B $74                            ;80CBE1;000074; 
                       SEP #$20                             ;80CBE3;      ; 
                       LDA.B #$06                           ;80CBE5;      ; 
                       LDX.B #$04                           ;80CBE7;      ; 
                       LDY.B #$02                           ;80CBE9;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CBEB;808E48; 
                       REP #$20                             ;80CBEF;      ; 
                       SEP #$10                             ;80CBF1;      ; 
                       LDA.W #$E383                         ;80CBF3;      ; 
                       STA.B $72                            ;80CBF6;000072; 
                       SEP #$20                             ;80CBF8;      ; 
                       LDA.B #$80                           ;80CBFA;      ; 
                       STA.B $74                            ;80CBFC;000074; 
                       SEP #$20                             ;80CBFE;      ; 
                       LDA.B #$0E                           ;80CC00;      ; 
                       LDX.B #$05                           ;80CC02;      ; 
                       LDY.B #$02                           ;80CC04;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CC06;808E48; 
                       REP #$20                             ;80CC0A;      ; 
                       SEP #$10                             ;80CC0C;      ; 
                       LDA.W #$E391                         ;80CC0E;      ; 
                       STA.B $72                            ;80CC11;000072; 
                       SEP #$20                             ;80CC13;      ; 
                       LDA.B #$80                           ;80CC15;      ; 
                       STA.B $74                            ;80CC17;000074; 
                       SEP #$20                             ;80CC19;      ; 
                       LDA.B #$0F                           ;80CC1B;      ; 
                       LDX.B #$06                           ;80CC1D;      ; 
                       LDY.B #$02                           ;80CC1F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CC21;808E48; 
                       REP #$20                             ;80CC25;      ; 
                       SEP #$10                             ;80CC27;      ; 
                       LDA.W #$E4EF                         ;80CC29;      ; 
                       STA.B $72                            ;80CC2C;000072; 
                       SEP #$20                             ;80CC2E;      ; 
                       LDA.B #$80                           ;80CC30;      ; 
                       STA.B $74                            ;80CC32;000074; 
                       SEP #$20                             ;80CC34;      ; 
                       LDA.B #$03                           ;80CC36;      ; 
                       LDX.B #$07                           ;80CC38;      ; 
                       LDY.B #$02                           ;80CC3A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CC3C;808E48; 
                       REP #$20                             ;80CC40;      ; 
                       SEP #$10                             ;80CC42;      ; 
                       LDA.W #$E500                         ;80CC44;      ; 
                       STA.B $72                            ;80CC47;000072; 
                       SEP #$20                             ;80CC49;      ; 
                       LDA.B #$80                           ;80CC4B;      ; 
                       STA.B $74                            ;80CC4D;000074; 
                       SEP #$20                             ;80CC4F;      ; 
                       LDA.B #$04                           ;80CC51;      ; 
                       LDX.B #$08                           ;80CC53;      ; 
                       LDY.B #$02                           ;80CC55;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CC57;808E48; 
                       REP #$20                             ;80CC5B;      ; 
                       SEP #$10                             ;80CC5D;      ; 
                       LDA.W #$E511                         ;80CC5F;      ; 
                       STA.B $72                            ;80CC62;000072; 
                       SEP #$20                             ;80CC64;      ; 
                       LDA.B #$80                           ;80CC66;      ; 
                       STA.B $74                            ;80CC68;000074; 
                       SEP #$20                             ;80CC6A;      ; 
                       LDA.B #$05                           ;80CC6C;      ; 
                       LDX.B #$09                           ;80CC6E;      ; 
                       LDY.B #$02                           ;80CC70;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CC72;808E48; 
                       REP #$20                             ;80CC76;      ; 
                       SEP #$10                             ;80CC78;      ; 
                       LDA.W #$E522                         ;80CC7A;      ; 
                       STA.B $72                            ;80CC7D;000072; 
                       SEP #$20                             ;80CC7F;      ; 
                       LDA.B #$80                           ;80CC81;      ; 
                       STA.B $74                            ;80CC83;000074; 
                       SEP #$20                             ;80CC85;      ; 
                       LDA.B #$07                           ;80CC87;      ; 
                       LDX.B #$0A                           ;80CC89;      ; 
                       LDY.B #$02                           ;80CC8B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CC8D;808E48; 
                       RTS                                  ;80CC91;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CC92;      ; 
                       SEP #$10                             ;80CC94;      ; 
                       LDA.W #$E39F                         ;80CC96;      ; 
                       STA.B $72                            ;80CC99;000072; 
                       SEP #$20                             ;80CC9B;      ; 
                       LDA.B #$80                           ;80CC9D;      ; 
                       STA.B $74                            ;80CC9F;000074; 
                       SEP #$20                             ;80CCA1;      ; 
                       LDA.B #$06                           ;80CCA3;      ; 
                       LDX.B #$04                           ;80CCA5;      ; 
                       LDY.B #$02                           ;80CCA7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CCA9;808E48; 
                       REP #$20                             ;80CCAD;      ; 
                       SEP #$10                             ;80CCAF;      ; 
                       LDA.W #$E3AD                         ;80CCB1;      ; 
                       STA.B $72                            ;80CCB4;000072; 
                       SEP #$20                             ;80CCB6;      ; 
                       LDA.B #$80                           ;80CCB8;      ; 
                       STA.B $74                            ;80CCBA;000074; 
                       SEP #$20                             ;80CCBC;      ; 
                       LDA.B #$0E                           ;80CCBE;      ; 
                       LDX.B #$05                           ;80CCC0;      ; 
                       LDY.B #$02                           ;80CCC2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CCC4;808E48; 
                       REP #$20                             ;80CCC8;      ; 
                       SEP #$10                             ;80CCCA;      ; 
                       LDA.W #$E3BB                         ;80CCCC;      ; 
                       STA.B $72                            ;80CCCF;000072; 
                       SEP #$20                             ;80CCD1;      ; 
                       LDA.B #$80                           ;80CCD3;      ; 
                       STA.B $74                            ;80CCD5;000074; 
                       SEP #$20                             ;80CCD7;      ; 
                       LDA.B #$0F                           ;80CCD9;      ; 
                       LDX.B #$06                           ;80CCDB;      ; 
                       LDY.B #$02                           ;80CCDD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CCDF;808E48; 
                       RTS                                  ;80CCE3;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CCE4;      ; 
                       SEP #$10                             ;80CCE6;      ; 
                       LDA.W #$E3C9                         ;80CCE8;      ; 
                       STA.B $72                            ;80CCEB;000072; 
                       SEP #$20                             ;80CCED;      ; 
                       LDA.B #$80                           ;80CCEF;      ; 
                       STA.B $74                            ;80CCF1;000074; 
                       SEP #$20                             ;80CCF3;      ; 
                       LDA.B #$06                           ;80CCF5;      ; 
                       LDX.B #$04                           ;80CCF7;      ; 
                       LDY.B #$02                           ;80CCF9;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CCFB;808E48; 
                       REP #$20                             ;80CCFF;      ; 
                       SEP #$10                             ;80CD01;      ; 
                       LDA.W #$E3D7                         ;80CD03;      ; 
                       STA.B $72                            ;80CD06;000072; 
                       SEP #$20                             ;80CD08;      ; 
                       LDA.B #$80                           ;80CD0A;      ; 
                       STA.B $74                            ;80CD0C;000074; 
                       SEP #$20                             ;80CD0E;      ; 
                       LDA.B #$0E                           ;80CD10;      ; 
                       LDX.B #$05                           ;80CD12;      ; 
                       LDY.B #$02                           ;80CD14;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CD16;808E48; 
                       REP #$20                             ;80CD1A;      ; 
                       SEP #$10                             ;80CD1C;      ; 
                       LDA.W #$E3E5                         ;80CD1E;      ; 
                       STA.B $72                            ;80CD21;000072; 
                       SEP #$20                             ;80CD23;      ; 
                       LDA.B #$80                           ;80CD25;      ; 
                       STA.B $74                            ;80CD27;000074; 
                       SEP #$20                             ;80CD29;      ; 
                       LDA.B #$0F                           ;80CD2B;      ; 
                       LDX.B #$06                           ;80CD2D;      ; 
                       LDY.B #$02                           ;80CD2F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CD31;808E48; 
                       RTS                                  ;80CD35;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CD36;      ; 
                       SEP #$10                             ;80CD38;      ; 
                       LDA.W #$E3F3                         ;80CD3A;      ; 
                       STA.B $72                            ;80CD3D;000072; 
                       SEP #$20                             ;80CD3F;      ; 
                       LDA.B #$80                           ;80CD41;      ; 
                       STA.B $74                            ;80CD43;000074; 
                       SEP #$20                             ;80CD45;      ; 
                       LDA.B #$06                           ;80CD47;      ; 
                       LDX.B #$04                           ;80CD49;      ; 
                       LDY.B #$02                           ;80CD4B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CD4D;808E48; 
                       REP #$20                             ;80CD51;      ; 
                       SEP #$10                             ;80CD53;      ; 
                       LDA.W #$E401                         ;80CD55;      ; 
                       STA.B $72                            ;80CD58;000072; 
                       SEP #$20                             ;80CD5A;      ; 
                       LDA.B #$80                           ;80CD5C;      ; 
                       STA.B $74                            ;80CD5E;000074; 
                       SEP #$20                             ;80CD60;      ; 
                       LDA.B #$0E                           ;80CD62;      ; 
                       LDX.B #$05                           ;80CD64;      ; 
                       LDY.B #$02                           ;80CD66;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CD68;808E48; 
                       REP #$20                             ;80CD6C;      ; 
                       SEP #$10                             ;80CD6E;      ; 
                       LDA.W #$E40F                         ;80CD70;      ; 
                       STA.B $72                            ;80CD73;000072; 
                       SEP #$20                             ;80CD75;      ; 
                       LDA.B #$80                           ;80CD77;      ; 
                       STA.B $74                            ;80CD79;000074; 
                       SEP #$20                             ;80CD7B;      ; 
                       LDA.B #$0F                           ;80CD7D;      ; 
                       LDX.B #$06                           ;80CD7F;      ; 
                       LDY.B #$02                           ;80CD81;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CD83;808E48; 
                       RTS                                  ;80CD87;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CD88;      ; 
                       SEP #$10                             ;80CD8A;      ; 
                       LDA.W #$E41D                         ;80CD8C;      ; 
                       STA.B $72                            ;80CD8F;000072; 
                       SEP #$20                             ;80CD91;      ; 
                       LDA.B #$80                           ;80CD93;      ; 
                       STA.B $74                            ;80CD95;000074; 
                       SEP #$20                             ;80CD97;      ; 
                       LDA.B #$06                           ;80CD99;      ; 
                       LDX.B #$04                           ;80CD9B;      ; 
                       LDY.B #$02                           ;80CD9D;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CD9F;808E48; 
                       REP #$20                             ;80CDA3;      ; 
                       SEP #$10                             ;80CDA5;      ; 
                       LDA.W #$E42B                         ;80CDA7;      ; 
                       STA.B $72                            ;80CDAA;000072; 
                       SEP #$20                             ;80CDAC;      ; 
                       LDA.B #$80                           ;80CDAE;      ; 
                       STA.B $74                            ;80CDB0;000074; 
                       SEP #$20                             ;80CDB2;      ; 
                       LDA.B #$0E                           ;80CDB4;      ; 
                       LDX.B #$05                           ;80CDB6;      ; 
                       LDY.B #$02                           ;80CDB8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CDBA;808E48; 
                       REP #$20                             ;80CDBE;      ; 
                       SEP #$10                             ;80CDC0;      ; 
                       LDA.W #$E439                         ;80CDC2;      ; 
                       STA.B $72                            ;80CDC5;000072; 
                       SEP #$20                             ;80CDC7;      ; 
                       LDA.B #$80                           ;80CDC9;      ; 
                       STA.B $74                            ;80CDCB;000074; 
                       SEP #$20                             ;80CDCD;      ; 
                       LDA.B #$0F                           ;80CDCF;      ; 
                       LDX.B #$06                           ;80CDD1;      ; 
                       LDY.B #$02                           ;80CDD3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CDD5;808E48; 
                       REP #$20                             ;80CDD9;      ; 
                       SEP #$10                             ;80CDDB;      ; 
                       LDA.W #$E533                         ;80CDDD;      ; 
                       STA.B $72                            ;80CDE0;000072; 
                       SEP #$20                             ;80CDE2;      ; 
                       LDA.B #$80                           ;80CDE4;      ; 
                       STA.B $74                            ;80CDE6;000074; 
                       SEP #$20                             ;80CDE8;      ; 
                       LDA.B #$03                           ;80CDEA;      ; 
                       LDX.B #$07                           ;80CDEC;      ; 
                       LDY.B #$02                           ;80CDEE;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CDF0;808E48; 
                       REP #$20                             ;80CDF4;      ; 
                       SEP #$10                             ;80CDF6;      ; 
                       LDA.W #$E544                         ;80CDF8;      ; 
                       STA.B $72                            ;80CDFB;000072; 
                       SEP #$20                             ;80CDFD;      ; 
                       LDA.B #$80                           ;80CDFF;      ; 
                       STA.B $74                            ;80CE01;000074; 
                       SEP #$20                             ;80CE03;      ; 
                       LDA.B #$04                           ;80CE05;      ; 
                       LDX.B #$08                           ;80CE07;      ; 
                       LDY.B #$02                           ;80CE09;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CE0B;808E48; 
                       REP #$20                             ;80CE0F;      ; 
                       SEP #$10                             ;80CE11;      ; 
                       LDA.W #$E555                         ;80CE13;      ; 
                       STA.B $72                            ;80CE16;000072; 
                       SEP #$20                             ;80CE18;      ; 
                       LDA.B #$80                           ;80CE1A;      ; 
                       STA.B $74                            ;80CE1C;000074; 
                       SEP #$20                             ;80CE1E;      ; 
                       LDA.B #$05                           ;80CE20;      ; 
                       LDX.B #$09                           ;80CE22;      ; 
                       LDY.B #$02                           ;80CE24;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CE26;808E48; 
                       REP #$20                             ;80CE2A;      ; 
                       SEP #$10                             ;80CE2C;      ; 
                       LDA.W #$E566                         ;80CE2E;      ; 
                       STA.B $72                            ;80CE31;000072; 
                       SEP #$20                             ;80CE33;      ; 
                       LDA.B #$80                           ;80CE35;      ; 
                       STA.B $74                            ;80CE37;000074; 
                       SEP #$20                             ;80CE39;      ; 
                       LDA.B #$07                           ;80CE3B;      ; 
                       LDX.B #$0A                           ;80CE3D;      ; 
                       LDY.B #$02                           ;80CE3F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CE41;808E48; 
                       RTS                                  ;80CE45;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CE46;      ; 
                       SEP #$10                             ;80CE48;      ; 
                       LDA.W #$E447                         ;80CE4A;      ; 
                       STA.B $72                            ;80CE4D;000072; 
                       SEP #$20                             ;80CE4F;      ; 
                       LDA.B #$80                           ;80CE51;      ; 
                       STA.B $74                            ;80CE53;000074; 
                       SEP #$20                             ;80CE55;      ; 
                       LDA.B #$06                           ;80CE57;      ; 
                       LDX.B #$04                           ;80CE59;      ; 
                       LDY.B #$02                           ;80CE5B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CE5D;808E48; 
                       REP #$20                             ;80CE61;      ; 
                       SEP #$10                             ;80CE63;      ; 
                       LDA.W #$E455                         ;80CE65;      ; 
                       STA.B $72                            ;80CE68;000072; 
                       SEP #$20                             ;80CE6A;      ; 
                       LDA.B #$80                           ;80CE6C;      ; 
                       STA.B $74                            ;80CE6E;000074; 
                       SEP #$20                             ;80CE70;      ; 
                       LDA.B #$0E                           ;80CE72;      ; 
                       LDX.B #$05                           ;80CE74;      ; 
                       LDY.B #$02                           ;80CE76;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CE78;808E48; 
                       REP #$20                             ;80CE7C;      ; 
                       SEP #$10                             ;80CE7E;      ; 
                       LDA.W #$E463                         ;80CE80;      ; 
                       STA.B $72                            ;80CE83;000072; 
                       SEP #$20                             ;80CE85;      ; 
                       LDA.B #$80                           ;80CE87;      ; 
                       STA.B $74                            ;80CE89;000074; 
                       SEP #$20                             ;80CE8B;      ; 
                       LDA.B #$0F                           ;80CE8D;      ; 
                       LDX.B #$06                           ;80CE8F;      ; 
                       LDY.B #$02                           ;80CE91;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CE93;808E48; 
                       RTS                                  ;80CE97;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CE98;      ; 
                       SEP #$10                             ;80CE9A;      ; 
                       LDA.W #$E471                         ;80CE9C;      ; 
                       STA.B $72                            ;80CE9F;000072; 
                       SEP #$20                             ;80CEA1;      ; 
                       LDA.B #$80                           ;80CEA3;      ; 
                       STA.B $74                            ;80CEA5;000074; 
                       SEP #$20                             ;80CEA7;      ; 
                       LDA.B #$06                           ;80CEA9;      ; 
                       LDX.B #$04                           ;80CEAB;      ; 
                       LDY.B #$02                           ;80CEAD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CEAF;808E48; 
                       REP #$20                             ;80CEB3;      ; 
                       SEP #$10                             ;80CEB5;      ; 
                       LDA.W #$E47F                         ;80CEB7;      ; 
                       STA.B $72                            ;80CEBA;000072; 
                       SEP #$20                             ;80CEBC;      ; 
                       LDA.B #$80                           ;80CEBE;      ; 
                       STA.B $74                            ;80CEC0;000074; 
                       SEP #$20                             ;80CEC2;      ; 
                       LDA.B #$0E                           ;80CEC4;      ; 
                       LDX.B #$05                           ;80CEC6;      ; 
                       LDY.B #$02                           ;80CEC8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CECA;808E48; 
                       REP #$20                             ;80CECE;      ; 
                       SEP #$10                             ;80CED0;      ; 
                       LDA.W #$E48D                         ;80CED2;      ; 
                       STA.B $72                            ;80CED5;000072; 
                       SEP #$20                             ;80CED7;      ; 
                       LDA.B #$80                           ;80CED9;      ; 
                       STA.B $74                            ;80CEDB;000074; 
                       SEP #$20                             ;80CEDD;      ; 
                       LDA.B #$0F                           ;80CEDF;      ; 
                       LDX.B #$06                           ;80CEE1;      ; 
                       LDY.B #$02                           ;80CEE3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CEE5;808E48; 
                       RTS                                  ;80CEE9;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CEEA;      ; 
                       SEP #$10                             ;80CEEC;      ; 
                       LDA.W #$E49B                         ;80CEEE;      ; 
                       STA.B $72                            ;80CEF1;000072; 
                       SEP #$20                             ;80CEF3;      ; 
                       LDA.B #$80                           ;80CEF5;      ; 
                       STA.B $74                            ;80CEF7;000074; 
                       SEP #$20                             ;80CEF9;      ; 
                       LDA.B #$06                           ;80CEFB;      ; 
                       LDX.B #$04                           ;80CEFD;      ; 
                       LDY.B #$02                           ;80CEFF;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CF01;808E48; 
                       REP #$20                             ;80CF05;      ; 
                       SEP #$10                             ;80CF07;      ; 
                       LDA.W #$E4A9                         ;80CF09;      ; 
                       STA.B $72                            ;80CF0C;000072; 
                       SEP #$20                             ;80CF0E;      ; 
                       LDA.B #$80                           ;80CF10;      ; 
                       STA.B $74                            ;80CF12;000074; 
                       SEP #$20                             ;80CF14;      ; 
                       LDA.B #$0E                           ;80CF16;      ; 
                       LDX.B #$05                           ;80CF18;      ; 
                       LDY.B #$02                           ;80CF1A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CF1C;808E48; 
                       REP #$20                             ;80CF20;      ; 
                       SEP #$10                             ;80CF22;      ; 
                       LDA.W #$E4B7                         ;80CF24;      ; 
                       STA.B $72                            ;80CF27;000072; 
                       SEP #$20                             ;80CF29;      ; 
                       LDA.B #$80                           ;80CF2B;      ; 
                       STA.B $74                            ;80CF2D;000074; 
                       SEP #$20                             ;80CF2F;      ; 
                       LDA.B #$0F                           ;80CF31;      ; 
                       LDX.B #$06                           ;80CF33;      ; 
                       LDY.B #$02                           ;80CF35;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CF37;808E48; 
                       RTS                                  ;80CF3B;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CF3C;      ; 
                       SEP #$10                             ;80CF3E;      ; 
                       LDA.W #$E4C5                         ;80CF40;      ; 
                       STA.B $72                            ;80CF43;000072; 
                       SEP #$20                             ;80CF45;      ; 
                       LDA.B #$80                           ;80CF47;      ; 
                       STA.B $74                            ;80CF49;000074; 
                       SEP #$20                             ;80CF4B;      ; 
                       LDA.B #$06                           ;80CF4D;      ; 
                       LDX.B #$04                           ;80CF4F;      ; 
                       LDY.B #$02                           ;80CF51;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CF53;808E48; 
                       REP #$20                             ;80CF57;      ; 
                       SEP #$10                             ;80CF59;      ; 
                       LDA.W #$E4D3                         ;80CF5B;      ; 
                       STA.B $72                            ;80CF5E;000072; 
                       SEP #$20                             ;80CF60;      ; 
                       LDA.B #$80                           ;80CF62;      ; 
                       STA.B $74                            ;80CF64;000074; 
                       SEP #$20                             ;80CF66;      ; 
                       LDA.B #$0E                           ;80CF68;      ; 
                       LDX.B #$05                           ;80CF6A;      ; 
                       LDY.B #$02                           ;80CF6C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CF6E;808E48; 
                       REP #$20                             ;80CF72;      ; 
                       SEP #$10                             ;80CF74;      ; 
                       LDA.W #$E4E1                         ;80CF76;      ; 
                       STA.B $72                            ;80CF79;000072; 
                       SEP #$20                             ;80CF7B;      ; 
                       LDA.B #$80                           ;80CF7D;      ; 
                       STA.B $74                            ;80CF7F;000074; 
                       SEP #$20                             ;80CF81;      ; 
                       LDA.B #$0F                           ;80CF83;      ; 
                       LDX.B #$06                           ;80CF85;      ; 
                       LDY.B #$02                           ;80CF87;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CF89;808E48; 
                       REP #$20                             ;80CF8D;      ; 
                       SEP #$10                             ;80CF8F;      ; 
                       LDA.W #$E577                         ;80CF91;      ; 
                       STA.B $72                            ;80CF94;000072; 
                       SEP #$20                             ;80CF96;      ; 
                       LDA.B #$80                           ;80CF98;      ; 
                       STA.B $74                            ;80CF9A;000074; 
                       SEP #$20                             ;80CF9C;      ; 
                       LDA.B #$03                           ;80CF9E;      ; 
                       LDX.B #$07                           ;80CFA0;      ; 
                       LDY.B #$02                           ;80CFA2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CFA4;808E48; 
                       REP #$20                             ;80CFA8;      ; 
                       SEP #$10                             ;80CFAA;      ; 
                       LDA.W #$E588                         ;80CFAC;      ; 
                       STA.B $72                            ;80CFAF;000072; 
                       SEP #$20                             ;80CFB1;      ; 
                       LDA.B #$80                           ;80CFB3;      ; 
                       STA.B $74                            ;80CFB5;000074; 
                       SEP #$20                             ;80CFB7;      ; 
                       LDA.B #$04                           ;80CFB9;      ; 
                       LDX.B #$08                           ;80CFBB;      ; 
                       LDY.B #$02                           ;80CFBD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CFBF;808E48; 
                       REP #$20                             ;80CFC3;      ; 
                       SEP #$10                             ;80CFC5;      ; 
                       LDA.W #$E599                         ;80CFC7;      ; 
                       STA.B $72                            ;80CFCA;000072; 
                       SEP #$20                             ;80CFCC;      ; 
                       LDA.B #$80                           ;80CFCE;      ; 
                       STA.B $74                            ;80CFD0;000074; 
                       SEP #$20                             ;80CFD2;      ; 
                       LDA.B #$05                           ;80CFD4;      ; 
                       LDX.B #$09                           ;80CFD6;      ; 
                       LDY.B #$02                           ;80CFD8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CFDA;808E48; 
                       REP #$20                             ;80CFDE;      ; 
                       SEP #$10                             ;80CFE0;      ; 
                       LDA.W #$E5AA                         ;80CFE2;      ; 
                       STA.B $72                            ;80CFE5;000072; 
                       SEP #$20                             ;80CFE7;      ; 
                       LDA.B #$80                           ;80CFE9;      ; 
                       STA.B $74                            ;80CFEB;000074; 
                       SEP #$20                             ;80CFED;      ; 
                       LDA.B #$07                           ;80CFEF;      ; 
                       LDX.B #$0A                           ;80CFF1;      ; 
                       LDY.B #$02                           ;80CFF3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80CFF5;808E48; 
                       RTS                                  ;80CFF9;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80CFFA;      ; 
                       SEP #$10                             ;80CFFC;      ; 
                       LDA.W #$E5BB                         ;80CFFE;      ; 
                       STA.B $72                            ;80D001;000072; 
                       SEP #$20                             ;80D003;      ; 
                       LDA.B #$80                           ;80D005;      ; 
                       STA.B $74                            ;80D007;000074; 
                       SEP #$20                             ;80D009;      ; 
                       LDA.B #$03                           ;80D00B;      ; 
                       LDX.B #$04                           ;80D00D;      ; 
                       LDY.B #$02                           ;80D00F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D011;808E48; 
                       REP #$20                             ;80D015;      ; 
                       SEP #$10                             ;80D017;      ; 
                       LDA.W #$E5CC                         ;80D019;      ; 
                       STA.B $72                            ;80D01C;000072; 
                       SEP #$20                             ;80D01E;      ; 
                       LDA.B #$80                           ;80D020;      ; 
                       STA.B $74                            ;80D022;000074; 
                       SEP #$20                             ;80D024;      ; 
                       LDA.B #$04                           ;80D026;      ; 
                       LDX.B #$05                           ;80D028;      ; 
                       LDY.B #$02                           ;80D02A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D02C;808E48; 
                       REP #$20                             ;80D030;      ; 
                       SEP #$10                             ;80D032;      ; 
                       LDA.W #$E5DD                         ;80D034;      ; 
                       STA.B $72                            ;80D037;000072; 
                       SEP #$20                             ;80D039;      ; 
                       LDA.B #$80                           ;80D03B;      ; 
                       STA.B $74                            ;80D03D;000074; 
                       SEP #$20                             ;80D03F;      ; 
                       LDA.B #$05                           ;80D041;      ; 
                       LDX.B #$06                           ;80D043;      ; 
                       LDY.B #$02                           ;80D045;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D047;808E48; 
                       REP #$20                             ;80D04B;      ; 
                       SEP #$10                             ;80D04D;      ; 
                       LDA.W #$E5EE                         ;80D04F;      ; 
                       STA.B $72                            ;80D052;000072; 
                       SEP #$20                             ;80D054;      ; 
                       LDA.B #$80                           ;80D056;      ; 
                       STA.B $74                            ;80D058;000074; 
                       SEP #$20                             ;80D05A;      ; 
                       LDA.B #$07                           ;80D05C;      ; 
                       LDX.B #$07                           ;80D05E;      ; 
                       LDY.B #$02                           ;80D060;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D062;808E48; 
                       RTS                                  ;80D066;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D067;      ; 
                       SEP #$10                             ;80D069;      ; 
                       LDA.W #$E5FF                         ;80D06B;      ; 
                       STA.B $72                            ;80D06E;000072; 
                       SEP #$20                             ;80D070;      ; 
                       LDA.B #$80                           ;80D072;      ; 
                       STA.B $74                            ;80D074;000074; 
                       SEP #$20                             ;80D076;      ; 
                       LDA.B #$08                           ;80D078;      ; 
                       LDX.B #$04                           ;80D07A;      ; 
                       LDY.B #$03                           ;80D07C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D07E;808E48; 
                       REP #$20                             ;80D082;      ; 
                       SEP #$10                             ;80D084;      ; 
                       LDA.W #$E616                         ;80D086;      ; 
                       STA.B $72                            ;80D089;000072; 
                       SEP #$20                             ;80D08B;      ; 
                       LDA.B #$80                           ;80D08D;      ; 
                       STA.B $74                            ;80D08F;000074; 
                       SEP #$20                             ;80D091;      ; 
                       LDA.B #$09                           ;80D093;      ; 
                       LDX.B #$05                           ;80D095;      ; 
                       LDY.B #$03                           ;80D097;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D099;808E48; 
                       REP #$20                             ;80D09D;      ; 
                       SEP #$10                             ;80D09F;      ; 
                       LDA.W #$E62D                         ;80D0A1;      ; 
                       STA.B $72                            ;80D0A4;000072; 
                       SEP #$20                             ;80D0A6;      ; 
                       LDA.B #$80                           ;80D0A8;      ; 
                       STA.B $74                            ;80D0AA;000074; 
                       SEP #$20                             ;80D0AC;      ; 
                       LDA.B #$0A                           ;80D0AE;      ; 
                       LDX.B #$06                           ;80D0B0;      ; 
                       LDY.B #$03                           ;80D0B2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D0B4;808E48; 
                       REP #$20                             ;80D0B8;      ; 
                       SEP #$10                             ;80D0BA;      ; 
                       LDA.W #$E644                         ;80D0BC;      ; 
                       STA.B $72                            ;80D0BF;000072; 
                       SEP #$20                             ;80D0C1;      ; 
                       LDA.B #$80                           ;80D0C3;      ; 
                       STA.B $74                            ;80D0C5;000074; 
                       SEP #$20                             ;80D0C7;      ; 
                       LDA.B #$0B                           ;80D0C9;      ; 
                       LDX.B #$07                           ;80D0CB;      ; 
                       LDY.B #$03                           ;80D0CD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D0CF;808E48; 
                       REP #$20                             ;80D0D3;      ; 
                       SEP #$10                             ;80D0D5;      ; 
                       LDA.W #$E65B                         ;80D0D7;      ; 
                       STA.B $72                            ;80D0DA;000072; 
                       SEP #$20                             ;80D0DC;      ; 
                       LDA.B #$80                           ;80D0DE;      ; 
                       STA.B $74                            ;80D0E0;000074; 
                       SEP #$20                             ;80D0E2;      ; 
                       LDA.B #$0C                           ;80D0E4;      ; 
                       LDX.B #$08                           ;80D0E6;      ; 
                       LDY.B #$03                           ;80D0E8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D0EA;808E48; 
                       REP #$20                             ;80D0EE;      ; 
                       SEP #$10                             ;80D0F0;      ; 
                       LDA.W #$EB4C                         ;80D0F2;      ; 
                       STA.B $72                            ;80D0F5;000072; 
                       SEP #$20                             ;80D0F7;      ; 
                       LDA.B #$80                           ;80D0F9;      ; 
                       STA.B $74                            ;80D0FB;000074; 
                       SEP #$20                             ;80D0FD;      ; 
                       LDA.B #$0A                           ;80D0FF;      ; 
                       LDX.B #$09                           ;80D101;      ; 
                       LDY.B #$04                           ;80D103;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D105;808E48; 
                       REP #$20                             ;80D109;      ; 
                       SEP #$10                             ;80D10B;      ; 
                       LDA.W #$EB5D                         ;80D10D;      ; 
                       STA.B $72                            ;80D110;000072; 
                       SEP #$20                             ;80D112;      ; 
                       LDA.B #$80                           ;80D114;      ; 
                       STA.B $74                            ;80D116;000074; 
                       SEP #$20                             ;80D118;      ; 
                       LDA.B #$0B                           ;80D11A;      ; 
                       LDX.B #$0A                           ;80D11C;      ; 
                       LDY.B #$04                           ;80D11E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D120;808E48; 
                       RTS                                  ;80D124;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D125;      ; 
                       SEP #$10                             ;80D127;      ; 
                       LDA.W #$E672                         ;80D129;      ; 
                       STA.B $72                            ;80D12C;000072; 
                       SEP #$20                             ;80D12E;      ; 
                       LDA.B #$80                           ;80D130;      ; 
                       STA.B $74                            ;80D132;000074; 
                       SEP #$20                             ;80D134;      ; 
                       LDA.B #$08                           ;80D136;      ; 
                       LDX.B #$04                           ;80D138;      ; 
                       LDY.B #$03                           ;80D13A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D13C;808E48; 
                       REP #$20                             ;80D140;      ; 
                       SEP #$10                             ;80D142;      ; 
                       LDA.W #$E689                         ;80D144;      ; 
                       STA.B $72                            ;80D147;000072; 
                       SEP #$20                             ;80D149;      ; 
                       LDA.B #$80                           ;80D14B;      ; 
                       STA.B $74                            ;80D14D;000074; 
                       SEP #$20                             ;80D14F;      ; 
                       LDA.B #$09                           ;80D151;      ; 
                       LDX.B #$05                           ;80D153;      ; 
                       LDY.B #$03                           ;80D155;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D157;808E48; 
                       REP #$20                             ;80D15B;      ; 
                       SEP #$10                             ;80D15D;      ; 
                       LDA.W #$E6A0                         ;80D15F;      ; 
                       STA.B $72                            ;80D162;000072; 
                       SEP #$20                             ;80D164;      ; 
                       LDA.B #$80                           ;80D166;      ; 
                       STA.B $74                            ;80D168;000074; 
                       SEP #$20                             ;80D16A;      ; 
                       LDA.B #$0A                           ;80D16C;      ; 
                       LDX.B #$06                           ;80D16E;      ; 
                       LDY.B #$03                           ;80D170;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D172;808E48; 
                       REP #$20                             ;80D176;      ; 
                       SEP #$10                             ;80D178;      ; 
                       LDA.W #$E6B7                         ;80D17A;      ; 
                       STA.B $72                            ;80D17D;000072; 
                       SEP #$20                             ;80D17F;      ; 
                       LDA.B #$80                           ;80D181;      ; 
                       STA.B $74                            ;80D183;000074; 
                       SEP #$20                             ;80D185;      ; 
                       LDA.B #$0B                           ;80D187;      ; 
                       LDX.B #$07                           ;80D189;      ; 
                       LDY.B #$03                           ;80D18B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D18D;808E48; 
                       REP #$20                             ;80D191;      ; 
                       SEP #$10                             ;80D193;      ; 
                       LDA.W #$E6CE                         ;80D195;      ; 
                       STA.B $72                            ;80D198;000072; 
                       SEP #$20                             ;80D19A;      ; 
                       LDA.B #$80                           ;80D19C;      ; 
                       STA.B $74                            ;80D19E;000074; 
                       SEP #$20                             ;80D1A0;      ; 
                       LDA.B #$0C                           ;80D1A2;      ; 
                       LDX.B #$08                           ;80D1A4;      ; 
                       LDY.B #$03                           ;80D1A6;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D1A8;808E48; 
                       REP #$20                             ;80D1AC;      ; 
                       SEP #$10                             ;80D1AE;      ; 
                       LDA.W #$EB6E                         ;80D1B0;      ; 
                       STA.B $72                            ;80D1B3;000072; 
                       SEP #$20                             ;80D1B5;      ; 
                       LDA.B #$80                           ;80D1B7;      ; 
                       STA.B $74                            ;80D1B9;000074; 
                       SEP #$20                             ;80D1BB;      ; 
                       LDA.B #$0A                           ;80D1BD;      ; 
                       LDX.B #$09                           ;80D1BF;      ; 
                       LDY.B #$04                           ;80D1C1;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D1C3;808E48; 
                       REP #$20                             ;80D1C7;      ; 
                       SEP #$10                             ;80D1C9;      ; 
                       LDA.W #$EB7F                         ;80D1CB;      ; 
                       STA.B $72                            ;80D1CE;000072; 
                       SEP #$20                             ;80D1D0;      ; 
                       LDA.B #$80                           ;80D1D2;      ; 
                       STA.B $74                            ;80D1D4;000074; 
                       SEP #$20                             ;80D1D6;      ; 
                       LDA.B #$0B                           ;80D1D8;      ; 
                       LDX.B #$0A                           ;80D1DA;      ; 
                       LDY.B #$04                           ;80D1DC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D1DE;808E48; 
                       RTS                                  ;80D1E2;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D1E3;      ; 
                       SEP #$10                             ;80D1E5;      ; 
                       LDA.W #$E6E5                         ;80D1E7;      ; 
                       STA.B $72                            ;80D1EA;000072; 
                       SEP #$20                             ;80D1EC;      ; 
                       LDA.B #$80                           ;80D1EE;      ; 
                       STA.B $74                            ;80D1F0;000074; 
                       SEP #$20                             ;80D1F2;      ; 
                       LDA.B #$08                           ;80D1F4;      ; 
                       LDX.B #$04                           ;80D1F6;      ; 
                       LDY.B #$03                           ;80D1F8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D1FA;808E48; 
                       REP #$20                             ;80D1FE;      ; 
                       SEP #$10                             ;80D200;      ; 
                       LDA.W #$E6FC                         ;80D202;      ; 
                       STA.B $72                            ;80D205;000072; 
                       SEP #$20                             ;80D207;      ; 
                       LDA.B #$80                           ;80D209;      ; 
                       STA.B $74                            ;80D20B;000074; 
                       SEP #$20                             ;80D20D;      ; 
                       LDA.B #$09                           ;80D20F;      ; 
                       LDX.B #$05                           ;80D211;      ; 
                       LDY.B #$03                           ;80D213;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D215;808E48; 
                       REP #$20                             ;80D219;      ; 
                       SEP #$10                             ;80D21B;      ; 
                       LDA.W #$E713                         ;80D21D;      ; 
                       STA.B $72                            ;80D220;000072; 
                       SEP #$20                             ;80D222;      ; 
                       LDA.B #$80                           ;80D224;      ; 
                       STA.B $74                            ;80D226;000074; 
                       SEP #$20                             ;80D228;      ; 
                       LDA.B #$0A                           ;80D22A;      ; 
                       LDX.B #$06                           ;80D22C;      ; 
                       LDY.B #$03                           ;80D22E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D230;808E48; 
                       REP #$20                             ;80D234;      ; 
                       SEP #$10                             ;80D236;      ; 
                       LDA.W #$E72A                         ;80D238;      ; 
                       STA.B $72                            ;80D23B;000072; 
                       SEP #$20                             ;80D23D;      ; 
                       LDA.B #$80                           ;80D23F;      ; 
                       STA.B $74                            ;80D241;000074; 
                       SEP #$20                             ;80D243;      ; 
                       LDA.B #$0B                           ;80D245;      ; 
                       LDX.B #$07                           ;80D247;      ; 
                       LDY.B #$03                           ;80D249;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D24B;808E48; 
                       REP #$20                             ;80D24F;      ; 
                       SEP #$10                             ;80D251;      ; 
                       LDA.W #$E741                         ;80D253;      ; 
                       STA.B $72                            ;80D256;000072; 
                       SEP #$20                             ;80D258;      ; 
                       LDA.B #$80                           ;80D25A;      ; 
                       STA.B $74                            ;80D25C;000074; 
                       SEP #$20                             ;80D25E;      ; 
                       LDA.B #$0C                           ;80D260;      ; 
                       LDX.B #$08                           ;80D262;      ; 
                       LDY.B #$03                           ;80D264;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D266;808E48; 
                       REP #$20                             ;80D26A;      ; 
                       SEP #$10                             ;80D26C;      ; 
                       LDA.W #$EB90                         ;80D26E;      ; 
                       STA.B $72                            ;80D271;000072; 
                       SEP #$20                             ;80D273;      ; 
                       LDA.B #$80                           ;80D275;      ; 
                       STA.B $74                            ;80D277;000074; 
                       SEP #$20                             ;80D279;      ; 
                       LDA.B #$0A                           ;80D27B;      ; 
                       LDX.B #$09                           ;80D27D;      ; 
                       LDY.B #$04                           ;80D27F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D281;808E48; 
                       REP #$20                             ;80D285;      ; 
                       SEP #$10                             ;80D287;      ; 
                       LDA.W #$EBA1                         ;80D289;      ; 
                       STA.B $72                            ;80D28C;000072; 
                       SEP #$20                             ;80D28E;      ; 
                       LDA.B #$80                           ;80D290;      ; 
                       STA.B $74                            ;80D292;000074; 
                       SEP #$20                             ;80D294;      ; 
                       LDA.B #$0B                           ;80D296;      ; 
                       LDX.B #$0A                           ;80D298;      ; 
                       LDY.B #$04                           ;80D29A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D29C;808E48; 
                       RTS                                  ;80D2A0;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D2A1;      ; 
                       SEP #$10                             ;80D2A3;      ; 
                       LDA.W #$E758                         ;80D2A5;      ; 
                       STA.B $72                            ;80D2A8;000072; 
                       SEP #$20                             ;80D2AA;      ; 
                       LDA.B #$80                           ;80D2AC;      ; 
                       STA.B $74                            ;80D2AE;000074; 
                       SEP #$20                             ;80D2B0;      ; 
                       LDA.B #$08                           ;80D2B2;      ; 
                       LDX.B #$04                           ;80D2B4;      ; 
                       LDY.B #$03                           ;80D2B6;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D2B8;808E48; 
                       REP #$20                             ;80D2BC;      ; 
                       SEP #$10                             ;80D2BE;      ; 
                       LDA.W #$E76F                         ;80D2C0;      ; 
                       STA.B $72                            ;80D2C3;000072; 
                       SEP #$20                             ;80D2C5;      ; 
                       LDA.B #$80                           ;80D2C7;      ; 
                       STA.B $74                            ;80D2C9;000074; 
                       SEP #$20                             ;80D2CB;      ; 
                       LDA.B #$09                           ;80D2CD;      ; 
                       LDX.B #$05                           ;80D2CF;      ; 
                       LDY.B #$03                           ;80D2D1;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D2D3;808E48; 
                       REP #$20                             ;80D2D7;      ; 
                       SEP #$10                             ;80D2D9;      ; 
                       LDA.W #$E786                         ;80D2DB;      ; 
                       STA.B $72                            ;80D2DE;000072; 
                       SEP #$20                             ;80D2E0;      ; 
                       LDA.B #$80                           ;80D2E2;      ; 
                       STA.B $74                            ;80D2E4;000074; 
                       SEP #$20                             ;80D2E6;      ; 
                       LDA.B #$0A                           ;80D2E8;      ; 
                       LDX.B #$06                           ;80D2EA;      ; 
                       LDY.B #$03                           ;80D2EC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D2EE;808E48; 
                       REP #$20                             ;80D2F2;      ; 
                       SEP #$10                             ;80D2F4;      ; 
                       LDA.W #$E79D                         ;80D2F6;      ; 
                       STA.B $72                            ;80D2F9;000072; 
                       SEP #$20                             ;80D2FB;      ; 
                       LDA.B #$80                           ;80D2FD;      ; 
                       STA.B $74                            ;80D2FF;000074; 
                       SEP #$20                             ;80D301;      ; 
                       LDA.B #$0B                           ;80D303;      ; 
                       LDX.B #$07                           ;80D305;      ; 
                       LDY.B #$03                           ;80D307;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D309;808E48; 
                       REP #$20                             ;80D30D;      ; 
                       SEP #$10                             ;80D30F;      ; 
                       LDA.W #$EBB2                         ;80D311;      ; 
                       STA.B $72                            ;80D314;000072; 
                       SEP #$20                             ;80D316;      ; 
                       LDA.B #$80                           ;80D318;      ; 
                       STA.B $74                            ;80D31A;000074; 
                       SEP #$20                             ;80D31C;      ; 
                       LDA.B #$0A                           ;80D31E;      ; 
                       LDX.B #$08                           ;80D320;      ; 
                       LDY.B #$04                           ;80D322;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D324;808E48; 
                       REP #$20                             ;80D328;      ; 
                       SEP #$10                             ;80D32A;      ; 
                       LDA.W #$EBC3                         ;80D32C;      ; 
                       STA.B $72                            ;80D32F;000072; 
                       SEP #$20                             ;80D331;      ; 
                       LDA.B #$80                           ;80D333;      ; 
                       STA.B $74                            ;80D335;000074; 
                       SEP #$20                             ;80D337;      ; 
                       LDA.B #$0B                           ;80D339;      ; 
                       LDX.B #$09                           ;80D33B;      ; 
                       LDY.B #$04                           ;80D33D;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D33F;808E48; 
                       RTS                                  ;80D343;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D344;      ; 
                       SEP #$10                             ;80D346;      ; 
                       LDA.W #$E7B4                         ;80D348;      ; 
                       STA.B $72                            ;80D34B;000072; 
                       SEP #$20                             ;80D34D;      ; 
                       LDA.B #$80                           ;80D34F;      ; 
                       STA.B $74                            ;80D351;000074; 
                       SEP #$20                             ;80D353;      ; 
                       LDA.B #$08                           ;80D355;      ; 
                       LDX.B #$04                           ;80D357;      ; 
                       LDY.B #$03                           ;80D359;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D35B;808E48; 
                       REP #$20                             ;80D35F;      ; 
                       SEP #$10                             ;80D361;      ; 
                       LDA.W #$E7CB                         ;80D363;      ; 
                       STA.B $72                            ;80D366;000072; 
                       SEP #$20                             ;80D368;      ; 
                       LDA.B #$80                           ;80D36A;      ; 
                       STA.B $74                            ;80D36C;000074; 
                       SEP #$20                             ;80D36E;      ; 
                       LDA.B #$09                           ;80D370;      ; 
                       LDX.B #$05                           ;80D372;      ; 
                       LDY.B #$03                           ;80D374;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D376;808E48; 
                       REP #$20                             ;80D37A;      ; 
                       SEP #$10                             ;80D37C;      ; 
                       LDA.W #$E7E2                         ;80D37E;      ; 
                       STA.B $72                            ;80D381;000072; 
                       SEP #$20                             ;80D383;      ; 
                       LDA.B #$80                           ;80D385;      ; 
                       STA.B $74                            ;80D387;000074; 
                       SEP #$20                             ;80D389;      ; 
                       LDA.B #$0A                           ;80D38B;      ; 
                       LDX.B #$06                           ;80D38D;      ; 
                       LDY.B #$03                           ;80D38F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D391;808E48; 
                       REP #$20                             ;80D395;      ; 
                       SEP #$10                             ;80D397;      ; 
                       LDA.W #$E7F9                         ;80D399;      ; 
                       STA.B $72                            ;80D39C;000072; 
                       SEP #$20                             ;80D39E;      ; 
                       LDA.B #$80                           ;80D3A0;      ; 
                       STA.B $74                            ;80D3A2;000074; 
                       SEP #$20                             ;80D3A4;      ; 
                       LDA.B #$0B                           ;80D3A6;      ; 
                       LDX.B #$07                           ;80D3A8;      ; 
                       LDY.B #$03                           ;80D3AA;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D3AC;808E48; 
                       REP #$20                             ;80D3B0;      ; 
                       SEP #$10                             ;80D3B2;      ; 
                       LDA.W #$E810                         ;80D3B4;      ; 
                       STA.B $72                            ;80D3B7;000072; 
                       SEP #$20                             ;80D3B9;      ; 
                       LDA.B #$80                           ;80D3BB;      ; 
                       STA.B $74                            ;80D3BD;000074; 
                       SEP #$20                             ;80D3BF;      ; 
                       LDA.B #$0C                           ;80D3C1;      ; 
                       LDX.B #$08                           ;80D3C3;      ; 
                       LDY.B #$03                           ;80D3C5;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D3C7;808E48; 
                       REP #$20                             ;80D3CB;      ; 
                       SEP #$10                             ;80D3CD;      ; 
                       LDA.W #$EBD4                         ;80D3CF;      ; 
                       STA.B $72                            ;80D3D2;000072; 
                       SEP #$20                             ;80D3D4;      ; 
                       LDA.B #$80                           ;80D3D6;      ; 
                       STA.B $74                            ;80D3D8;000074; 
                       SEP #$20                             ;80D3DA;      ; 
                       LDA.B #$0A                           ;80D3DC;      ; 
                       LDX.B #$09                           ;80D3DE;      ; 
                       LDY.B #$04                           ;80D3E0;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D3E2;808E48; 
                       REP #$20                             ;80D3E6;      ; 
                       SEP #$10                             ;80D3E8;      ; 
                       LDA.W #$EBE5                         ;80D3EA;      ; 
                       STA.B $72                            ;80D3ED;000072; 
                       SEP #$20                             ;80D3EF;      ; 
                       LDA.B #$80                           ;80D3F1;      ; 
                       STA.B $74                            ;80D3F3;000074; 
                       SEP #$20                             ;80D3F5;      ; 
                       LDA.B #$0B                           ;80D3F7;      ; 
                       LDX.B #$0A                           ;80D3F9;      ; 
                       LDY.B #$04                           ;80D3FB;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D3FD;808E48; 
                       RTS                                  ;80D401;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D402;      ; 
                       SEP #$10                             ;80D404;      ; 
                       LDA.W #$E827                         ;80D406;      ; 
                       STA.B $72                            ;80D409;000072; 
                       SEP #$20                             ;80D40B;      ; 
                       LDA.B #$80                           ;80D40D;      ; 
                       STA.B $74                            ;80D40F;000074; 
                       SEP #$20                             ;80D411;      ; 
                       LDA.B #$08                           ;80D413;      ; 
                       LDX.B #$04                           ;80D415;      ; 
                       LDY.B #$03                           ;80D417;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D419;808E48; 
                       REP #$20                             ;80D41D;      ; 
                       SEP #$10                             ;80D41F;      ; 
                       LDA.W #$E83E                         ;80D421;      ; 
                       STA.B $72                            ;80D424;000072; 
                       SEP #$20                             ;80D426;      ; 
                       LDA.B #$80                           ;80D428;      ; 
                       STA.B $74                            ;80D42A;000074; 
                       SEP #$20                             ;80D42C;      ; 
                       LDA.B #$09                           ;80D42E;      ; 
                       LDX.B #$05                           ;80D430;      ; 
                       LDY.B #$03                           ;80D432;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D434;808E48; 
                       REP #$20                             ;80D438;      ; 
                       SEP #$10                             ;80D43A;      ; 
                       LDA.W #$E855                         ;80D43C;      ; 
                       STA.B $72                            ;80D43F;000072; 
                       SEP #$20                             ;80D441;      ; 
                       LDA.B #$80                           ;80D443;      ; 
                       STA.B $74                            ;80D445;000074; 
                       SEP #$20                             ;80D447;      ; 
                       LDA.B #$0A                           ;80D449;      ; 
                       LDX.B #$06                           ;80D44B;      ; 
                       LDY.B #$03                           ;80D44D;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D44F;808E48; 
                       REP #$20                             ;80D453;      ; 
                       SEP #$10                             ;80D455;      ; 
                       LDA.W #$E86C                         ;80D457;      ; 
                       STA.B $72                            ;80D45A;000072; 
                       SEP #$20                             ;80D45C;      ; 
                       LDA.B #$80                           ;80D45E;      ; 
                       STA.B $74                            ;80D460;000074; 
                       SEP #$20                             ;80D462;      ; 
                       LDA.B #$0B                           ;80D464;      ; 
                       LDX.B #$07                           ;80D466;      ; 
                       LDY.B #$03                           ;80D468;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D46A;808E48; 
                       REP #$20                             ;80D46E;      ; 
                       SEP #$10                             ;80D470;      ; 
                       LDA.W #$E883                         ;80D472;      ; 
                       STA.B $72                            ;80D475;000072; 
                       SEP #$20                             ;80D477;      ; 
                       LDA.B #$80                           ;80D479;      ; 
                       STA.B $74                            ;80D47B;000074; 
                       SEP #$20                             ;80D47D;      ; 
                       LDA.B #$0C                           ;80D47F;      ; 
                       LDX.B #$08                           ;80D481;      ; 
                       LDY.B #$03                           ;80D483;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D485;808E48; 
                       REP #$20                             ;80D489;      ; 
                       SEP #$10                             ;80D48B;      ; 
                       LDA.W #$EBF6                         ;80D48D;      ; 
                       STA.B $72                            ;80D490;000072; 
                       SEP #$20                             ;80D492;      ; 
                       LDA.B #$80                           ;80D494;      ; 
                       STA.B $74                            ;80D496;000074; 
                       SEP #$20                             ;80D498;      ; 
                       LDA.B #$0A                           ;80D49A;      ; 
                       LDX.B #$09                           ;80D49C;      ; 
                       LDY.B #$04                           ;80D49E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D4A0;808E48; 
                       REP #$20                             ;80D4A4;      ; 
                       SEP #$10                             ;80D4A6;      ; 
                       LDA.W #$EC07                         ;80D4A8;      ; 
                       STA.B $72                            ;80D4AB;000072; 
                       SEP #$20                             ;80D4AD;      ; 
                       LDA.B #$80                           ;80D4AF;      ; 
                       STA.B $74                            ;80D4B1;000074; 
                       SEP #$20                             ;80D4B3;      ; 
                       LDA.B #$0B                           ;80D4B5;      ; 
                       LDX.B #$0A                           ;80D4B7;      ; 
                       LDY.B #$04                           ;80D4B9;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D4BB;808E48; 
                       RTS                                  ;80D4BF;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D4C0;      ; 
                       SEP #$10                             ;80D4C2;      ; 
                       LDA.W #$E89A                         ;80D4C4;      ; 
                       STA.B $72                            ;80D4C7;000072; 
                       SEP #$20                             ;80D4C9;      ; 
                       LDA.B #$80                           ;80D4CB;      ; 
                       STA.B $74                            ;80D4CD;000074; 
                       SEP #$20                             ;80D4CF;      ; 
                       LDA.B #$08                           ;80D4D1;      ; 
                       LDX.B #$04                           ;80D4D3;      ; 
                       LDY.B #$03                           ;80D4D5;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D4D7;808E48; 
                       REP #$20                             ;80D4DB;      ; 
                       SEP #$10                             ;80D4DD;      ; 
                       LDA.W #$E8B1                         ;80D4DF;      ; 
                       STA.B $72                            ;80D4E2;000072; 
                       SEP #$20                             ;80D4E4;      ; 
                       LDA.B #$80                           ;80D4E6;      ; 
                       STA.B $74                            ;80D4E8;000074; 
                       SEP #$20                             ;80D4EA;      ; 
                       LDA.B #$09                           ;80D4EC;      ; 
                       LDX.B #$05                           ;80D4EE;      ; 
                       LDY.B #$03                           ;80D4F0;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D4F2;808E48; 
                       REP #$20                             ;80D4F6;      ; 
                       SEP #$10                             ;80D4F8;      ; 
                       LDA.W #$E8C8                         ;80D4FA;      ; 
                       STA.B $72                            ;80D4FD;000072; 
                       SEP #$20                             ;80D4FF;      ; 
                       LDA.B #$80                           ;80D501;      ; 
                       STA.B $74                            ;80D503;000074; 
                       SEP #$20                             ;80D505;      ; 
                       LDA.B #$0A                           ;80D507;      ; 
                       LDX.B #$06                           ;80D509;      ; 
                       LDY.B #$03                           ;80D50B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D50D;808E48; 
                       REP #$20                             ;80D511;      ; 
                       SEP #$10                             ;80D513;      ; 
                       LDA.W #$E8DF                         ;80D515;      ; 
                       STA.B $72                            ;80D518;000072; 
                       SEP #$20                             ;80D51A;      ; 
                       LDA.B #$80                           ;80D51C;      ; 
                       STA.B $74                            ;80D51E;000074; 
                       SEP #$20                             ;80D520;      ; 
                       LDA.B #$0B                           ;80D522;      ; 
                       LDX.B #$07                           ;80D524;      ; 
                       LDY.B #$03                           ;80D526;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D528;808E48; 
                       REP #$20                             ;80D52C;      ; 
                       SEP #$10                             ;80D52E;      ; 
                       LDA.W #$EC18                         ;80D530;      ; 
                       STA.B $72                            ;80D533;000072; 
                       SEP #$20                             ;80D535;      ; 
                       LDA.B #$80                           ;80D537;      ; 
                       STA.B $74                            ;80D539;000074; 
                       SEP #$20                             ;80D53B;      ; 
                       LDA.B #$0A                           ;80D53D;      ; 
                       LDX.B #$08                           ;80D53F;      ; 
                       LDY.B #$04                           ;80D541;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D543;808E48; 
                       REP #$20                             ;80D547;      ; 
                       SEP #$10                             ;80D549;      ; 
                       LDA.W #$EC29                         ;80D54B;      ; 
                       STA.B $72                            ;80D54E;000072; 
                       SEP #$20                             ;80D550;      ; 
                       LDA.B #$80                           ;80D552;      ; 
                       STA.B $74                            ;80D554;000074; 
                       SEP #$20                             ;80D556;      ; 
                       LDA.B #$0B                           ;80D558;      ; 
                       LDX.B #$09                           ;80D55A;      ; 
                       LDY.B #$04                           ;80D55C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D55E;808E48; 
                       RTS                                  ;80D562;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D563;      ; 
                       SEP #$10                             ;80D565;      ; 
                       LDA.W #$E8F6                         ;80D567;      ; 
                       STA.B $72                            ;80D56A;000072; 
                       SEP #$20                             ;80D56C;      ; 
                       LDA.B #$80                           ;80D56E;      ; 
                       STA.B $74                            ;80D570;000074; 
                       SEP #$20                             ;80D572;      ; 
                       LDA.B #$08                           ;80D574;      ; 
                       LDX.B #$04                           ;80D576;      ; 
                       LDY.B #$03                           ;80D578;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D57A;808E48; 
                       REP #$20                             ;80D57E;      ; 
                       SEP #$10                             ;80D580;      ; 
                       LDA.W #$E90D                         ;80D582;      ; 
                       STA.B $72                            ;80D585;000072; 
                       SEP #$20                             ;80D587;      ; 
                       LDA.B #$80                           ;80D589;      ; 
                       STA.B $74                            ;80D58B;000074; 
                       SEP #$20                             ;80D58D;      ; 
                       LDA.B #$09                           ;80D58F;      ; 
                       LDX.B #$05                           ;80D591;      ; 
                       LDY.B #$03                           ;80D593;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D595;808E48; 
                       REP #$20                             ;80D599;      ; 
                       SEP #$10                             ;80D59B;      ; 
                       LDA.W #$E924                         ;80D59D;      ; 
                       STA.B $72                            ;80D5A0;000072; 
                       SEP #$20                             ;80D5A2;      ; 
                       LDA.B #$80                           ;80D5A4;      ; 
                       STA.B $74                            ;80D5A6;000074; 
                       SEP #$20                             ;80D5A8;      ; 
                       LDA.B #$0A                           ;80D5AA;      ; 
                       LDX.B #$06                           ;80D5AC;      ; 
                       LDY.B #$03                           ;80D5AE;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D5B0;808E48; 
                       REP #$20                             ;80D5B4;      ; 
                       SEP #$10                             ;80D5B6;      ; 
                       LDA.W #$E93B                         ;80D5B8;      ; 
                       STA.B $72                            ;80D5BB;000072; 
                       SEP #$20                             ;80D5BD;      ; 
                       LDA.B #$80                           ;80D5BF;      ; 
                       STA.B $74                            ;80D5C1;000074; 
                       SEP #$20                             ;80D5C3;      ; 
                       LDA.B #$0B                           ;80D5C5;      ; 
                       LDX.B #$07                           ;80D5C7;      ; 
                       LDY.B #$03                           ;80D5C9;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D5CB;808E48; 
                       REP #$20                             ;80D5CF;      ; 
                       SEP #$10                             ;80D5D1;      ; 
                       LDA.W #$EC3A                         ;80D5D3;      ; 
                       STA.B $72                            ;80D5D6;000072; 
                       SEP #$20                             ;80D5D8;      ; 
                       LDA.B #$80                           ;80D5DA;      ; 
                       STA.B $74                            ;80D5DC;000074; 
                       SEP #$20                             ;80D5DE;      ; 
                       LDA.B #$0A                           ;80D5E0;      ; 
                       LDX.B #$08                           ;80D5E2;      ; 
                       LDY.B #$04                           ;80D5E4;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D5E6;808E48; 
                       REP #$20                             ;80D5EA;      ; 
                       SEP #$10                             ;80D5EC;      ; 
                       LDA.W #$EC4B                         ;80D5EE;      ; 
                       STA.B $72                            ;80D5F1;000072; 
                       SEP #$20                             ;80D5F3;      ; 
                       LDA.B #$80                           ;80D5F5;      ; 
                       STA.B $74                            ;80D5F7;000074; 
                       SEP #$20                             ;80D5F9;      ; 
                       LDA.B #$0B                           ;80D5FB;      ; 
                       LDX.B #$09                           ;80D5FD;      ; 
                       LDY.B #$04                           ;80D5FF;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D601;808E48; 
                       RTS                                  ;80D605;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D606;      ; 
                       SEP #$10                             ;80D608;      ; 
                       LDA.W #$E952                         ;80D60A;      ; 
                       STA.B $72                            ;80D60D;000072; 
                       SEP #$20                             ;80D60F;      ; 
                       LDA.B #$80                           ;80D611;      ; 
                       STA.B $74                            ;80D613;000074; 
                       SEP #$20                             ;80D615;      ; 
                       LDA.B #$06                           ;80D617;      ; 
                       LDX.B #$04                           ;80D619;      ; 
                       LDY.B #$03                           ;80D61B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D61D;808E48; 
                       REP #$20                             ;80D621;      ; 
                       SEP #$10                             ;80D623;      ; 
                       LDA.W #$E969                         ;80D625;      ; 
                       STA.B $72                            ;80D628;000072; 
                       SEP #$20                             ;80D62A;      ; 
                       LDA.B #$80                           ;80D62C;      ; 
                       STA.B $74                            ;80D62E;000074; 
                       SEP #$20                             ;80D630;      ; 
                       LDA.B #$07                           ;80D632;      ; 
                       LDX.B #$05                           ;80D634;      ; 
                       LDY.B #$03                           ;80D636;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D638;808E48; 
                       REP #$20                             ;80D63C;      ; 
                       SEP #$10                             ;80D63E;      ; 
                       LDA.W #$E980                         ;80D640;      ; 
                       STA.B $72                            ;80D643;000072; 
                       SEP #$20                             ;80D645;      ; 
                       LDA.B #$80                           ;80D647;      ; 
                       STA.B $74                            ;80D649;000074; 
                       SEP #$20                             ;80D64B;      ; 
                       LDA.B #$08                           ;80D64D;      ; 
                       LDX.B #$06                           ;80D64F;      ; 
                       LDY.B #$03                           ;80D651;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D653;808E48; 
                       REP #$20                             ;80D657;      ; 
                       SEP #$10                             ;80D659;      ; 
                       LDA.W #$E997                         ;80D65B;      ; 
                       STA.B $72                            ;80D65E;000072; 
                       SEP #$20                             ;80D660;      ; 
                       LDA.B #$80                           ;80D662;      ; 
                       STA.B $74                            ;80D664;000074; 
                       SEP #$20                             ;80D666;      ; 
                       LDA.B #$09                           ;80D668;      ; 
                       LDX.B #$07                           ;80D66A;      ; 
                       LDY.B #$03                           ;80D66C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D66E;808E48; 
                       REP #$20                             ;80D672;      ; 
                       SEP #$10                             ;80D674;      ; 
                       LDA.W #$E9AE                         ;80D676;      ; 
                       STA.B $72                            ;80D679;000072; 
                       SEP #$20                             ;80D67B;      ; 
                       LDA.B #$80                           ;80D67D;      ; 
                       STA.B $74                            ;80D67F;000074; 
                       SEP #$20                             ;80D681;      ; 
                       LDA.B #$0A                           ;80D683;      ; 
                       LDX.B #$08                           ;80D685;      ; 
                       LDY.B #$03                           ;80D687;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D689;808E48; 
                       REP #$20                             ;80D68D;      ; 
                       SEP #$10                             ;80D68F;      ; 
                       LDA.W #$E9C5                         ;80D691;      ; 
                       STA.B $72                            ;80D694;000072; 
                       SEP #$20                             ;80D696;      ; 
                       LDA.B #$80                           ;80D698;      ; 
                       STA.B $74                            ;80D69A;000074; 
                       SEP #$20                             ;80D69C;      ; 
                       LDA.B #$0B                           ;80D69E;      ; 
                       LDX.B #$09                           ;80D6A0;      ; 
                       LDY.B #$03                           ;80D6A2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D6A4;808E48; 
                       REP #$20                             ;80D6A8;      ; 
                       SEP #$10                             ;80D6AA;      ; 
                       LDA.W #$E9DC                         ;80D6AC;      ; 
                       STA.B $72                            ;80D6AF;000072; 
                       SEP #$20                             ;80D6B1;      ; 
                       LDA.B #$80                           ;80D6B3;      ; 
                       STA.B $74                            ;80D6B5;000074; 
                       SEP #$20                             ;80D6B7;      ; 
                       LDA.B #$0C                           ;80D6B9;      ; 
                       LDX.B #$0A                           ;80D6BB;      ; 
                       LDY.B #$03                           ;80D6BD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D6BF;808E48; 
                       REP #$20                             ;80D6C3;      ; 
                       SEP #$10                             ;80D6C5;      ; 
                       LDA.W #$EC5C                         ;80D6C7;      ; 
                       STA.B $72                            ;80D6CA;000072; 
                       SEP #$20                             ;80D6CC;      ; 
                       LDA.B #$80                           ;80D6CE;      ; 
                       STA.B $74                            ;80D6D0;000074; 
                       SEP #$20                             ;80D6D2;      ; 
                       LDA.B #$0A                           ;80D6D4;      ; 
                       LDX.B #$0B                           ;80D6D6;      ; 
                       LDY.B #$04                           ;80D6D8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D6DA;808E48; 
                       REP #$20                             ;80D6DE;      ; 
                       SEP #$10                             ;80D6E0;      ; 
                       LDA.W #$EC6D                         ;80D6E2;      ; 
                       STA.B $72                            ;80D6E5;000072; 
                       SEP #$20                             ;80D6E7;      ; 
                       LDA.B #$80                           ;80D6E9;      ; 
                       STA.B $74                            ;80D6EB;000074; 
                       SEP #$20                             ;80D6ED;      ; 
                       LDA.B #$0B                           ;80D6EF;      ; 
                       LDX.B #$0C                           ;80D6F1;      ; 
                       LDY.B #$04                           ;80D6F3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D6F5;808E48; 
                       RTS                                  ;80D6F9;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D6FA;      ; 
                       SEP #$10                             ;80D6FC;      ; 
                       LDA.W #$E9F3                         ;80D6FE;      ; 
                       STA.B $72                            ;80D701;000072; 
                       SEP #$20                             ;80D703;      ; 
                       LDA.B #$80                           ;80D705;      ; 
                       STA.B $74                            ;80D707;000074; 
                       SEP #$20                             ;80D709;      ; 
                       LDA.B #$06                           ;80D70B;      ; 
                       LDX.B #$04                           ;80D70D;      ; 
                       LDY.B #$03                           ;80D70F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D711;808E48; 
                       REP #$20                             ;80D715;      ; 
                       SEP #$10                             ;80D717;      ; 
                       LDA.W #$EA0A                         ;80D719;      ; 
                       STA.B $72                            ;80D71C;000072; 
                       SEP #$20                             ;80D71E;      ; 
                       LDA.B #$80                           ;80D720;      ; 
                       STA.B $74                            ;80D722;000074; 
                       SEP #$20                             ;80D724;      ; 
                       LDA.B #$07                           ;80D726;      ; 
                       LDX.B #$05                           ;80D728;      ; 
                       LDY.B #$03                           ;80D72A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D72C;808E48; 
                       REP #$20                             ;80D730;      ; 
                       SEP #$10                             ;80D732;      ; 
                       LDA.W #$EA21                         ;80D734;      ; 
                       STA.B $72                            ;80D737;000072; 
                       SEP #$20                             ;80D739;      ; 
                       LDA.B #$80                           ;80D73B;      ; 
                       STA.B $74                            ;80D73D;000074; 
                       SEP #$20                             ;80D73F;      ; 
                       LDA.B #$08                           ;80D741;      ; 
                       LDX.B #$06                           ;80D743;      ; 
                       LDY.B #$03                           ;80D745;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D747;808E48; 
                       REP #$20                             ;80D74B;      ; 
                       SEP #$10                             ;80D74D;      ; 
                       LDA.W #$EA38                         ;80D74F;      ; 
                       STA.B $72                            ;80D752;000072; 
                       SEP #$20                             ;80D754;      ; 
                       LDA.B #$80                           ;80D756;      ; 
                       STA.B $74                            ;80D758;000074; 
                       SEP #$20                             ;80D75A;      ; 
                       LDA.B #$09                           ;80D75C;      ; 
                       LDX.B #$07                           ;80D75E;      ; 
                       LDY.B #$03                           ;80D760;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D762;808E48; 
                       REP #$20                             ;80D766;      ; 
                       SEP #$10                             ;80D768;      ; 
                       LDA.W #$EA4F                         ;80D76A;      ; 
                       STA.B $72                            ;80D76D;000072; 
                       SEP #$20                             ;80D76F;      ; 
                       LDA.B #$80                           ;80D771;      ; 
                       STA.B $74                            ;80D773;000074; 
                       SEP #$20                             ;80D775;      ; 
                       LDA.B #$0A                           ;80D777;      ; 
                       LDX.B #$08                           ;80D779;      ; 
                       LDY.B #$03                           ;80D77B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D77D;808E48; 
                       REP #$20                             ;80D781;      ; 
                       SEP #$10                             ;80D783;      ; 
                       LDA.W #$EA66                         ;80D785;      ; 
                       STA.B $72                            ;80D788;000072; 
                       SEP #$20                             ;80D78A;      ; 
                       LDA.B #$80                           ;80D78C;      ; 
                       STA.B $74                            ;80D78E;000074; 
                       SEP #$20                             ;80D790;      ; 
                       LDA.B #$0B                           ;80D792;      ; 
                       LDX.B #$09                           ;80D794;      ; 
                       LDY.B #$03                           ;80D796;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D798;808E48; 
                       REP #$20                             ;80D79C;      ; 
                       SEP #$10                             ;80D79E;      ; 
                       LDA.W #$EA7D                         ;80D7A0;      ; 
                       STA.B $72                            ;80D7A3;000072; 
                       SEP #$20                             ;80D7A5;      ; 
                       LDA.B #$80                           ;80D7A7;      ; 
                       STA.B $74                            ;80D7A9;000074; 
                       SEP #$20                             ;80D7AB;      ; 
                       LDA.B #$0C                           ;80D7AD;      ; 
                       LDX.B #$0A                           ;80D7AF;      ; 
                       LDY.B #$03                           ;80D7B1;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D7B3;808E48; 
                       REP #$20                             ;80D7B7;      ; 
                       SEP #$10                             ;80D7B9;      ; 
                       LDA.W #$EC7E                         ;80D7BB;      ; 
                       STA.B $72                            ;80D7BE;000072; 
                       SEP #$20                             ;80D7C0;      ; 
                       LDA.B #$80                           ;80D7C2;      ; 
                       STA.B $74                            ;80D7C4;000074; 
                       SEP #$20                             ;80D7C6;      ; 
                       LDA.B #$0A                           ;80D7C8;      ; 
                       LDX.B #$0B                           ;80D7CA;      ; 
                       LDY.B #$04                           ;80D7CC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D7CE;808E48; 
                       REP #$20                             ;80D7D2;      ; 
                       SEP #$10                             ;80D7D4;      ; 
                       LDA.W #$EC8F                         ;80D7D6;      ; 
                       STA.B $72                            ;80D7D9;000072; 
                       SEP #$20                             ;80D7DB;      ; 
                       LDA.B #$80                           ;80D7DD;      ; 
                       STA.B $74                            ;80D7DF;000074; 
                       SEP #$20                             ;80D7E1;      ; 
                       LDA.B #$0B                           ;80D7E3;      ; 
                       LDX.B #$0C                           ;80D7E5;      ; 
                       LDY.B #$04                           ;80D7E7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D7E9;808E48; 
                       RTS                                  ;80D7ED;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D7EE;      ; 
                       SEP #$10                             ;80D7F0;      ; 
                       LDA.W #$EA94                         ;80D7F2;      ; 
                       STA.B $72                            ;80D7F5;000072; 
                       SEP #$20                             ;80D7F7;      ; 
                       LDA.B #$80                           ;80D7F9;      ; 
                       STA.B $74                            ;80D7FB;000074; 
                       SEP #$20                             ;80D7FD;      ; 
                       LDA.B #$08                           ;80D7FF;      ; 
                       LDX.B #$04                           ;80D801;      ; 
                       LDY.B #$03                           ;80D803;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D805;808E48; 
                       REP #$20                             ;80D809;      ; 
                       SEP #$10                             ;80D80B;      ; 
                       LDA.W #$EAAB                         ;80D80D;      ; 
                       STA.B $72                            ;80D810;000072; 
                       SEP #$20                             ;80D812;      ; 
                       LDA.B #$80                           ;80D814;      ; 
                       STA.B $74                            ;80D816;000074; 
                       SEP #$20                             ;80D818;      ; 
                       LDA.B #$09                           ;80D81A;      ; 
                       LDX.B #$05                           ;80D81C;      ; 
                       LDY.B #$03                           ;80D81E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D820;808E48; 
                       REP #$20                             ;80D824;      ; 
                       SEP #$10                             ;80D826;      ; 
                       LDA.W #$EAC2                         ;80D828;      ; 
                       STA.B $72                            ;80D82B;000072; 
                       SEP #$20                             ;80D82D;      ; 
                       LDA.B #$80                           ;80D82F;      ; 
                       STA.B $74                            ;80D831;000074; 
                       SEP #$20                             ;80D833;      ; 
                       LDA.B #$0A                           ;80D835;      ; 
                       LDX.B #$06                           ;80D837;      ; 
                       LDY.B #$03                           ;80D839;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D83B;808E48; 
                       REP #$20                             ;80D83F;      ; 
                       SEP #$10                             ;80D841;      ; 
                       LDA.W #$EAD9                         ;80D843;      ; 
                       STA.B $72                            ;80D846;000072; 
                       SEP #$20                             ;80D848;      ; 
                       LDA.B #$80                           ;80D84A;      ; 
                       STA.B $74                            ;80D84C;000074; 
                       SEP #$20                             ;80D84E;      ; 
                       LDA.B #$0B                           ;80D850;      ; 
                       LDX.B #$07                           ;80D852;      ; 
                       LDY.B #$03                           ;80D854;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D856;808E48; 
                       REP #$20                             ;80D85A;      ; 
                       SEP #$10                             ;80D85C;      ; 
                       LDA.W #$ECA0                         ;80D85E;      ; 
                       STA.B $72                            ;80D861;000072; 
                       SEP #$20                             ;80D863;      ; 
                       LDA.B #$80                           ;80D865;      ; 
                       STA.B $74                            ;80D867;000074; 
                       SEP #$20                             ;80D869;      ; 
                       LDA.B #$0A                           ;80D86B;      ; 
                       LDX.B #$08                           ;80D86D;      ; 
                       LDY.B #$04                           ;80D86F;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D871;808E48; 
                       REP #$20                             ;80D875;      ; 
                       SEP #$10                             ;80D877;      ; 
                       LDA.W #$ECB1                         ;80D879;      ; 
                       STA.B $72                            ;80D87C;000072; 
                       SEP #$20                             ;80D87E;      ; 
                       LDA.B #$80                           ;80D880;      ; 
                       STA.B $74                            ;80D882;000074; 
                       SEP #$20                             ;80D884;      ; 
                       LDA.B #$0B                           ;80D886;      ; 
                       LDX.B #$09                           ;80D888;      ; 
                       LDY.B #$04                           ;80D88A;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D88C;808E48; 
                       RTS                                  ;80D890;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D891;      ; 
                       SEP #$10                             ;80D893;      ; 
                       LDA.W #$EAF0                         ;80D895;      ; 
                       STA.B $72                            ;80D898;000072; 
                       SEP #$20                             ;80D89A;      ; 
                       LDA.B #$80                           ;80D89C;      ; 
                       STA.B $74                            ;80D89E;000074; 
                       SEP #$20                             ;80D8A0;      ; 
                       LDA.B #$08                           ;80D8A2;      ; 
                       LDX.B #$04                           ;80D8A4;      ; 
                       LDY.B #$03                           ;80D8A6;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D8A8;808E48; 
                       REP #$20                             ;80D8AC;      ; 
                       SEP #$10                             ;80D8AE;      ; 
                       LDA.W #$EB07                         ;80D8B0;      ; 
                       STA.B $72                            ;80D8B3;000072; 
                       SEP #$20                             ;80D8B5;      ; 
                       LDA.B #$80                           ;80D8B7;      ; 
                       STA.B $74                            ;80D8B9;000074; 
                       SEP #$20                             ;80D8BB;      ; 
                       LDA.B #$09                           ;80D8BD;      ; 
                       LDX.B #$05                           ;80D8BF;      ; 
                       LDY.B #$03                           ;80D8C1;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D8C3;808E48; 
                       REP #$20                             ;80D8C7;      ; 
                       SEP #$10                             ;80D8C9;      ; 
                       LDA.W #$EB1E                         ;80D8CB;      ; 
                       STA.B $72                            ;80D8CE;000072; 
                       SEP #$20                             ;80D8D0;      ; 
                       LDA.B #$80                           ;80D8D2;      ; 
                       STA.B $74                            ;80D8D4;000074; 
                       SEP #$20                             ;80D8D6;      ; 
                       LDA.B #$0A                           ;80D8D8;      ; 
                       LDX.B #$06                           ;80D8DA;      ; 
                       LDY.B #$03                           ;80D8DC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D8DE;808E48; 
                       REP #$20                             ;80D8E2;      ; 
                       SEP #$10                             ;80D8E4;      ; 
                       LDA.W #$EB35                         ;80D8E6;      ; 
                       STA.B $72                            ;80D8E9;000072; 
                       SEP #$20                             ;80D8EB;      ; 
                       LDA.B #$80                           ;80D8ED;      ; 
                       STA.B $74                            ;80D8EF;000074; 
                       SEP #$20                             ;80D8F1;      ; 
                       LDA.B #$0B                           ;80D8F3;      ; 
                       LDX.B #$07                           ;80D8F5;      ; 
                       LDY.B #$03                           ;80D8F7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D8F9;808E48; 
                       REP #$20                             ;80D8FD;      ; 
                       SEP #$10                             ;80D8FF;      ; 
                       LDA.W #$ECC2                         ;80D901;      ; 
                       STA.B $72                            ;80D904;000072; 
                       SEP #$20                             ;80D906;      ; 
                       LDA.B #$80                           ;80D908;      ; 
                       STA.B $74                            ;80D90A;000074; 
                       SEP #$20                             ;80D90C;      ; 
                       LDA.B #$0A                           ;80D90E;      ; 
                       LDX.B #$08                           ;80D910;      ; 
                       LDY.B #$04                           ;80D912;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D914;808E48; 
                       REP #$20                             ;80D918;      ; 
                       SEP #$10                             ;80D91A;      ; 
                       LDA.W #$ECD3                         ;80D91C;      ; 
                       STA.B $72                            ;80D91F;000072; 
                       SEP #$20                             ;80D921;      ; 
                       LDA.B #$80                           ;80D923;      ; 
                       STA.B $74                            ;80D925;000074; 
                       SEP #$20                             ;80D927;      ; 
                       LDA.B #$0B                           ;80D929;      ; 
                       LDX.B #$09                           ;80D92B;      ; 
                       LDY.B #$04                           ;80D92D;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D92F;808E48; 
                       RTS                                  ;80D933;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D934;      ; 
                       SEP #$10                             ;80D936;      ; 
                       LDA.W #$ECE4                         ;80D938;      ; 
                       STA.B $72                            ;80D93B;000072; 
                       SEP #$20                             ;80D93D;      ; 
                       LDA.B #$80                           ;80D93F;      ; 
                       STA.B $74                            ;80D941;000074; 
                       SEP #$20                             ;80D943;      ; 
                       LDA.B #$0A                           ;80D945;      ; 
                       LDX.B #$04                           ;80D947;      ; 
                       LDY.B #$04                           ;80D949;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D94B;808E48; 
                       REP #$20                             ;80D94F;      ; 
                       SEP #$10                             ;80D951;      ; 
                       LDA.W #$ECF5                         ;80D953;      ; 
                       STA.B $72                            ;80D956;000072; 
                       SEP #$20                             ;80D958;      ; 
                       LDA.B #$80                           ;80D95A;      ; 
                       STA.B $74                            ;80D95C;000074; 
                       SEP #$20                             ;80D95E;      ; 
                       LDA.B #$0B                           ;80D960;      ; 
                       LDX.B #$05                           ;80D962;      ; 
                       LDY.B #$04                           ;80D964;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D966;808E48; 
                       RTS                                  ;80D96A;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D96B;      ; 
                       SEP #$10                             ;80D96D;      ; 
                       LDA.W #$ED06                         ;80D96F;      ; 
                       STA.B $72                            ;80D972;000072; 
                       SEP #$20                             ;80D974;      ; 
                       LDA.B #$80                           ;80D976;      ; 
                       STA.B $74                            ;80D978;000074; 
                       SEP #$20                             ;80D97A;      ; 
                       LDA.B #$0A                           ;80D97C;      ; 
                       LDX.B #$04                           ;80D97E;      ; 
                       LDY.B #$04                           ;80D980;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D982;808E48; 
                       REP #$20                             ;80D986;      ; 
                       SEP #$10                             ;80D988;      ; 
                       LDA.W #$ED17                         ;80D98A;      ; 
                       STA.B $72                            ;80D98D;000072; 
                       SEP #$20                             ;80D98F;      ; 
                       LDA.B #$80                           ;80D991;      ; 
                       STA.B $74                            ;80D993;000074; 
                       SEP #$20                             ;80D995;      ; 
                       LDA.B #$0B                           ;80D997;      ; 
                       LDX.B #$05                           ;80D999;      ; 
                       LDY.B #$04                           ;80D99B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D99D;808E48; 
                       RTS                                  ;80D9A1;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D9A2;      ; 
                       SEP #$10                             ;80D9A4;      ; 
                       LDA.W #$ED28                         ;80D9A6;      ; 
                       STA.B $72                            ;80D9A9;000072; 
                       SEP #$20                             ;80D9AB;      ; 
                       LDA.B #$80                           ;80D9AD;      ; 
                       STA.B $74                            ;80D9AF;000074; 
                       SEP #$20                             ;80D9B1;      ; 
                       LDA.B #$0A                           ;80D9B3;      ; 
                       LDX.B #$04                           ;80D9B5;      ; 
                       LDY.B #$04                           ;80D9B7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D9B9;808E48; 
                       REP #$20                             ;80D9BD;      ; 
                       SEP #$10                             ;80D9BF;      ; 
                       LDA.W #$ED39                         ;80D9C1;      ; 
                       STA.B $72                            ;80D9C4;000072; 
                       SEP #$20                             ;80D9C6;      ; 
                       LDA.B #$80                           ;80D9C8;      ; 
                       STA.B $74                            ;80D9CA;000074; 
                       SEP #$20                             ;80D9CC;      ; 
                       LDA.B #$0B                           ;80D9CE;      ; 
                       LDX.B #$05                           ;80D9D0;      ; 
                       LDY.B #$04                           ;80D9D2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D9D4;808E48; 
                       RTS                                  ;80D9D8;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80D9D9;      ; 
                       SEP #$10                             ;80D9DB;      ; 
                       LDA.W #$ED4A                         ;80D9DD;      ; 
                       STA.B $72                            ;80D9E0;000072; 
                       SEP #$20                             ;80D9E2;      ; 
                       LDA.B #$80                           ;80D9E4;      ; 
                       STA.B $74                            ;80D9E6;000074; 
                       SEP #$20                             ;80D9E8;      ; 
                       LDA.B #$0A                           ;80D9EA;      ; 
                       LDX.B #$04                           ;80D9EC;      ; 
                       LDY.B #$04                           ;80D9EE;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80D9F0;808E48; 
                       REP #$20                             ;80D9F4;      ; 
                       SEP #$10                             ;80D9F6;      ; 
                       LDA.W #$ED5B                         ;80D9F8;      ; 
                       STA.B $72                            ;80D9FB;000072; 
                       SEP #$20                             ;80D9FD;      ; 
                       LDA.B #$80                           ;80D9FF;      ; 
                       STA.B $74                            ;80DA01;000074; 
                       SEP #$20                             ;80DA03;      ; 
                       LDA.B #$0B                           ;80DA05;      ; 
                       LDX.B #$05                           ;80DA07;      ; 
                       LDY.B #$04                           ;80DA09;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DA0B;808E48; 
                       RTS                                  ;80DA0F;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80DA10;      ; 
                       SEP #$10                             ;80DA12;      ; 
                       LDA.W #$ED6C                         ;80DA14;      ; 
                       STA.B $72                            ;80DA17;000072; 
                       SEP #$20                             ;80DA19;      ; 
                       LDA.B #$80                           ;80DA1B;      ; 
                       STA.B $74                            ;80DA1D;000074; 
                       SEP #$20                             ;80DA1F;      ; 
                       LDA.B #$03                           ;80DA21;      ; 
                       LDX.B #$04                           ;80DA23;      ; 
                       LDY.B #$04                           ;80DA25;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DA27;808E48; 
                       REP #$20                             ;80DA2B;      ; 
                       SEP #$10                             ;80DA2D;      ; 
                       LDA.W #$ED83                         ;80DA2F;      ; 
                       STA.B $72                            ;80DA32;000072; 
                       SEP #$20                             ;80DA34;      ; 
                       LDA.B #$80                           ;80DA36;      ; 
                       STA.B $74                            ;80DA38;000074; 
                       SEP #$20                             ;80DA3A;      ; 
                       LDA.B #$05                           ;80DA3C;      ; 
                       LDX.B #$05                           ;80DA3E;      ; 
                       LDY.B #$04                           ;80DA40;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DA42;808E48; 
                       RTS                                  ;80DA46;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80DA47;      ; 
                       SEP #$10                             ;80DA49;      ; 
                       LDA.W #$ED9A                         ;80DA4B;      ; 
                       STA.B $72                            ;80DA4E;000072; 
                       SEP #$20                             ;80DA50;      ; 
                       LDA.B #$80                           ;80DA52;      ; 
                       STA.B $74                            ;80DA54;000074; 
                       SEP #$20                             ;80DA56;      ; 
                       LDA.B #$0B                           ;80DA58;      ; 
                       LDX.B #$04                           ;80DA5A;      ; 
                       LDY.B #$04                           ;80DA5C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DA5E;808E48; 
                       REP #$20                             ;80DA62;      ; 
                       SEP #$10                             ;80DA64;      ; 
                       LDA.W #$EDAB                         ;80DA66;      ; 
                       STA.B $72                            ;80DA69;000072; 
                       SEP #$20                             ;80DA6B;      ; 
                       LDA.B #$80                           ;80DA6D;      ; 
                       STA.B $74                            ;80DA6F;000074; 
                       SEP #$20                             ;80DA71;      ; 
                       LDA.B #$0C                           ;80DA73;      ; 
                       LDX.B #$05                           ;80DA75;      ; 
                       LDY.B #$04                           ;80DA77;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DA79;808E48; 
                       REP #$20                             ;80DA7D;      ; 
                       SEP #$10                             ;80DA7F;      ; 
                       LDA.W #$EDBC                         ;80DA81;      ; 
                       STA.B $72                            ;80DA84;000072; 
                       SEP #$20                             ;80DA86;      ; 
                       LDA.B #$80                           ;80DA88;      ; 
                       STA.B $74                            ;80DA8A;000074; 
                       SEP #$20                             ;80DA8C;      ; 
                       LDA.B #$0D                           ;80DA8E;      ; 
                       LDX.B #$06                           ;80DA90;      ; 
                       LDY.B #$04                           ;80DA92;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DA94;808E48; 
                       REP #$20                             ;80DA98;      ; 
                       SEP #$10                             ;80DA9A;      ; 
                       LDA.W #$EDCD                         ;80DA9C;      ; 
                       STA.B $72                            ;80DA9F;000072; 
                       SEP #$20                             ;80DAA1;      ; 
                       LDA.B #$80                           ;80DAA3;      ; 
                       STA.B $74                            ;80DAA5;000074; 
                       SEP #$20                             ;80DAA7;      ; 
                       LDA.B #$0E                           ;80DAA9;      ; 
                       LDX.B #$07                           ;80DAAB;      ; 
                       LDY.B #$04                           ;80DAAD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DAAF;808E48; 
                       RTS                                  ;80DAB3;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80DAB4;      ; 
                       SEP #$10                             ;80DAB6;      ; 
                       LDA.W #$EDDE                         ;80DAB8;      ; 
                       STA.B $72                            ;80DABB;000072; 
                       SEP #$20                             ;80DABD;      ; 
                       LDA.B #$80                           ;80DABF;      ; 
                       STA.B $74                            ;80DAC1;000074; 
                       SEP #$20                             ;80DAC3;      ; 
                       LDA.B #$0C                           ;80DAC5;      ; 
                       LDX.B #$04                           ;80DAC7;      ; 
                       LDY.B #$04                           ;80DAC9;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DACB;808E48; 
                       REP #$20                             ;80DACF;      ; 
                       SEP #$10                             ;80DAD1;      ; 
                       LDA.W #$EDEC                         ;80DAD3;      ; 
                       STA.B $72                            ;80DAD6;000072; 
                       SEP #$20                             ;80DAD8;      ; 
                       LDA.B #$80                           ;80DADA;      ; 
                       STA.B $74                            ;80DADC;000074; 
                       SEP #$20                             ;80DADE;      ; 
                       LDA.B #$0D                           ;80DAE0;      ; 
                       LDX.B #$05                           ;80DAE2;      ; 
                       LDY.B #$04                           ;80DAE4;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DAE6;808E48; 
                       REP #$20                             ;80DAEA;      ; 
                       SEP #$10                             ;80DAEC;      ; 
                       LDA.W #$EDFA                         ;80DAEE;      ; 
                       STA.B $72                            ;80DAF1;000072; 
                       SEP #$20                             ;80DAF3;      ; 
                       LDA.B #$80                           ;80DAF5;      ; 
                       STA.B $74                            ;80DAF7;000074; 
                       SEP #$20                             ;80DAF9;      ; 
                       LDA.B #$0E                           ;80DAFB;      ; 
                       LDX.B #$06                           ;80DAFD;      ; 
                       LDY.B #$04                           ;80DAFF;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DB01;808E48; 
                       RTS                                  ;80DB05;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80DB06;      ; 
                       SEP #$10                             ;80DB08;      ; 
                       LDA.W #$EE08                         ;80DB0A;      ; 
                       STA.B $72                            ;80DB0D;000072; 
                       SEP #$20                             ;80DB0F;      ; 
                       LDA.B #$80                           ;80DB11;      ; 
                       STA.B $74                            ;80DB13;000074; 
                       SEP #$20                             ;80DB15;      ; 
                       LDA.B #$07                           ;80DB17;      ; 
                       LDX.B #$04                           ;80DB19;      ; 
                       LDY.B #$01                           ;80DB1B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DB1D;808E48; 
                       REP #$20                             ;80DB21;      ; 
                       SEP #$10                             ;80DB23;      ; 
                       LDA.W #$EE16                         ;80DB25;      ; 
                       STA.B $72                            ;80DB28;000072; 
                       SEP #$20                             ;80DB2A;      ; 
                       LDA.B #$80                           ;80DB2C;      ; 
                       STA.B $74                            ;80DB2E;000074; 
                       SEP #$20                             ;80DB30;      ; 
                       LDA.B #$08                           ;80DB32;      ; 
                       LDX.B #$05                           ;80DB34;      ; 
                       LDY.B #$01                           ;80DB36;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DB38;808E48; 
                       REP #$20                             ;80DB3C;      ; 
                       SEP #$10                             ;80DB3E;      ; 
                       LDA.W #$EE24                         ;80DB40;      ; 
                       STA.B $72                            ;80DB43;000072; 
                       SEP #$20                             ;80DB45;      ; 
                       LDA.B #$80                           ;80DB47;      ; 
                       STA.B $74                            ;80DB49;000074; 
                       SEP #$20                             ;80DB4B;      ; 
                       LDA.B #$0D                           ;80DB4D;      ; 
                       LDX.B #$06                           ;80DB4F;      ; 
                       LDY.B #$01                           ;80DB51;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DB53;808E48; 
                       REP #$20                             ;80DB57;      ; 
                       SEP #$10                             ;80DB59;      ; 
                       LDA.W #$EE32                         ;80DB5B;      ; 
                       STA.B $72                            ;80DB5E;000072; 
                       SEP #$20                             ;80DB60;      ; 
                       LDA.B #$80                           ;80DB62;      ; 
                       STA.B $74                            ;80DB64;000074; 
                       SEP #$20                             ;80DB66;      ; 
                       LDA.B #$0E                           ;80DB68;      ; 
                       LDX.B #$07                           ;80DB6A;      ; 
                       LDY.B #$01                           ;80DB6C;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DB6E;808E48; 
                       REP #$20                             ;80DB72;      ; 
                       SEP #$10                             ;80DB74;      ; 
                       LDA.W #$EE40                         ;80DB76;      ; 
                       STA.B $72                            ;80DB79;000072; 
                       SEP #$20                             ;80DB7B;      ; 
                       LDA.B #$80                           ;80DB7D;      ; 
                       STA.B $74                            ;80DB7F;000074; 
                       SEP #$20                             ;80DB81;      ; 
                       LDA.B #$06                           ;80DB83;      ; 
                       LDX.B #$08                           ;80DB85;      ; 
                       LDY.B #$03                           ;80DB87;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DB89;808E48; 
                       REP #$20                             ;80DB8D;      ; 
                       SEP #$10                             ;80DB8F;      ; 
                       LDA.W #$EE4E                         ;80DB91;      ; 
                       STA.B $72                            ;80DB94;000072; 
                       SEP #$20                             ;80DB96;      ; 
                       LDA.B #$80                           ;80DB98;      ; 
                       STA.B $74                            ;80DB9A;000074; 
                       SEP #$20                             ;80DB9C;      ; 
                       LDA.B #$09                           ;80DB9E;      ; 
                       LDX.B #$09                           ;80DBA0;      ; 
                       LDY.B #$03                           ;80DBA2;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DBA4;808E48; 
                       REP #$20                             ;80DBA8;      ; 
                       SEP #$10                             ;80DBAA;      ; 
                       LDA.W #$EE5C                         ;80DBAC;      ; 
                       STA.B $72                            ;80DBAF;000072; 
                       SEP #$20                             ;80DBB1;      ; 
                       LDA.B #$80                           ;80DBB3;      ; 
                       STA.B $74                            ;80DBB5;000074; 
                       SEP #$20                             ;80DBB7;      ; 
                       LDA.B #$0A                           ;80DBB9;      ; 
                       LDX.B #$0A                           ;80DBBB;      ; 
                       LDY.B #$03                           ;80DBBD;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DBBF;808E48; 
                       REP #$20                             ;80DBC3;      ; 
                       SEP #$10                             ;80DBC5;      ; 
                       LDA.W #$EE6A                         ;80DBC7;      ; 
                       STA.B $72                            ;80DBCA;000072; 
                       SEP #$20                             ;80DBCC;      ; 
                       LDA.B #$80                           ;80DBCE;      ; 
                       STA.B $74                            ;80DBD0;000074; 
                       SEP #$20                             ;80DBD2;      ; 
                       LDA.B #$0B                           ;80DBD4;      ; 
                       LDX.B #$0B                           ;80DBD6;      ; 
                       LDY.B #$03                           ;80DBD8;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DBDA;808E48; 
                       REP #$20                             ;80DBDE;      ; 
                       SEP #$10                             ;80DBE0;      ; 
                       LDA.W #$EE78                         ;80DBE2;      ; 
                       STA.B $72                            ;80DBE5;000072; 
                       SEP #$20                             ;80DBE7;      ; 
                       LDA.B #$80                           ;80DBE9;      ; 
                       STA.B $74                            ;80DBEB;000074; 
                       SEP #$20                             ;80DBED;      ; 
                       LDA.B #$0C                           ;80DBEF;      ; 
                       LDX.B #$0C                           ;80DBF1;      ; 
                       LDY.B #$03                           ;80DBF3;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DBF5;808E48; 
                       REP #$20                             ;80DBF9;      ; 
                       SEP #$10                             ;80DBFB;      ; 
                       LDA.W #$EE86                         ;80DBFD;      ; 
                       STA.B $72                            ;80DC00;000072; 
                       SEP #$20                             ;80DC02;      ; 
                       LDA.B #$80                           ;80DC04;      ; 
                       STA.B $74                            ;80DC06;000074; 
                       SEP #$20                             ;80DC08;      ; 
                       LDA.B #$0D                           ;80DC0A;      ; 
                       LDX.B #$0D                           ;80DC0C;      ; 
                       LDY.B #$03                           ;80DC0E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DC10;808E48; 
                       REP #$20                             ;80DC14;      ; 
                       SEP #$10                             ;80DC16;      ; 
                       LDA.W #$EE94                         ;80DC18;      ; 
                       STA.B $72                            ;80DC1B;000072; 
                       SEP #$20                             ;80DC1D;      ; 
                       LDA.B #$80                           ;80DC1F;      ; 
                       STA.B $74                            ;80DC21;000074; 
                       SEP #$20                             ;80DC23;      ; 
                       LDA.B #$0E                           ;80DC25;      ; 
                       LDX.B #$0E                           ;80DC27;      ; 
                       LDY.B #$03                           ;80DC29;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DC2B;808E48; 
                       RTS                                  ;80DC2F;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80DC30;      ; 
                       SEP #$10                             ;80DC32;      ; 
                       LDA.W #$E447                         ;80DC34;      ; 
                       STA.B $72                            ;80DC37;000072; 
                       SEP #$20                             ;80DC39;      ; 
                       LDA.B #$80                           ;80DC3B;      ; 
                       STA.B $74                            ;80DC3D;000074; 
                       SEP #$20                             ;80DC3F;      ; 
                       LDA.B #$06                           ;80DC41;      ; 
                       LDX.B #$04                           ;80DC43;      ; 
                       LDY.B #$02                           ;80DC45;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DC47;808E48; 
                       REP #$20                             ;80DC4B;      ; 
                       SEP #$10                             ;80DC4D;      ; 
                       LDA.W #$E455                         ;80DC4F;      ; 
                       STA.B $72                            ;80DC52;000072; 
                       SEP #$20                             ;80DC54;      ; 
                       LDA.B #$80                           ;80DC56;      ; 
                       STA.B $74                            ;80DC58;000074; 
                       SEP #$20                             ;80DC5A;      ; 
                       LDA.B #$0E                           ;80DC5C;      ; 
                       LDX.B #$05                           ;80DC5E;      ; 
                       LDY.B #$02                           ;80DC60;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DC62;808E48; 
                       REP #$20                             ;80DC66;      ; 
                       SEP #$10                             ;80DC68;      ; 
                       LDA.W #$E463                         ;80DC6A;      ; 
                       STA.B $72                            ;80DC6D;000072; 
                       SEP #$20                             ;80DC6F;      ; 
                       LDA.B #$80                           ;80DC71;      ; 
                       STA.B $74                            ;80DC73;000074; 
                       SEP #$20                             ;80DC75;      ; 
                       LDA.B #$0F                           ;80DC77;      ; 
                       LDX.B #$06                           ;80DC79;      ; 
                       LDY.B #$02                           ;80DC7B;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DC7D;808E48; 
                       REP #$20                             ;80DC81;      ; 
                       SEP #$10                             ;80DC83;      ; 
                       LDA.W #$EEA2                         ;80DC85;      ; 
                       STA.B $72                            ;80DC88;000072; 
                       SEP #$20                             ;80DC8A;      ; 
                       LDA.B #$80                           ;80DC8C;      ; 
                       STA.B $74                            ;80DC8E;000074; 
                       SEP #$20                             ;80DC90;      ; 
                       LDA.B #$0C                           ;80DC92;      ; 
                       LDX.B #$07                           ;80DC94;      ; 
                       LDY.B #$06                           ;80DC96;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DC98;808E48; 
                       REP #$20                             ;80DC9C;      ; 
                       SEP #$10                             ;80DC9E;      ; 
                       LDA.W #$EEB3                         ;80DCA0;      ; 
                       STA.B $72                            ;80DCA3;000072; 
                       SEP #$20                             ;80DCA5;      ; 
                       LDA.B #$80                           ;80DCA7;      ; 
                       STA.B $74                            ;80DCA9;000074; 
                       SEP #$20                             ;80DCAB;      ; 
                       LDA.B #$0D                           ;80DCAD;      ; 
                       LDX.B #$08                           ;80DCAF;      ; 
                       LDY.B #$06                           ;80DCB1;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DCB3;808E48; 
                       REP #$20                             ;80DCB7;      ; 
                       SEP #$10                             ;80DCB9;      ; 
                       LDA.W #$EEC4                         ;80DCBB;      ; 
                       STA.B $72                            ;80DCBE;000072; 
                       SEP #$20                             ;80DCC0;      ; 
                       LDA.B #$80                           ;80DCC2;      ; 
                       STA.B $74                            ;80DCC4;000074; 
                       SEP #$20                             ;80DCC6;      ; 
                       LDA.B #$0F                           ;80DCC8;      ; 
                       LDX.B #$09                           ;80DCCA;      ; 
                       LDY.B #$06                           ;80DCCC;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DCCE;808E48; 
                       REP #$20                             ;80DCD2;      ; 
                       SEP #$10                             ;80DCD4;      ; 
                       LDA.W #$EED5                         ;80DCD6;      ; 
                       STA.B $72                            ;80DCD9;000072; 
                       SEP #$20                             ;80DCDB;      ; 
                       LDA.B #$80                           ;80DCDD;      ; 
                       STA.B $74                            ;80DCDF;000074; 
                       SEP #$20                             ;80DCE1;      ; 
                       LDA.B #$05                           ;80DCE3;      ; 
                       LDX.B #$0A                           ;80DCE5;      ; 
                       LDY.B #$06                           ;80DCE7;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DCE9;808E48; 
                       REP #$20                             ;80DCED;      ; 
                       SEP #$10                             ;80DCEF;      ; 
                       LDA.W #$EEEC                         ;80DCF1;      ; 
                       STA.B $72                            ;80DCF4;000072; 
                       SEP #$20                             ;80DCF6;      ; 
                       LDA.B #$80                           ;80DCF8;      ; 
                       STA.B $74                            ;80DCFA;000074; 
                       SEP #$20                             ;80DCFC;      ; 
                       LDA.B #$0E                           ;80DCFE;      ; 
                       LDX.B #$0B                           ;80DD00;      ; 
                       LDY.B #$06                           ;80DD02;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DD04;808E48; 
                       RTS                                  ;80DD08;      ; 
                                                            ;      ;      ; 
                       REP #$20                             ;80DD09;      ; 
                       SEP #$10                             ;80DD0B;      ; 
                       LDA.W #$EF06                         ;80DD0D;      ; 
                       STA.B $72                            ;80DD10;000072; 
                       SEP #$20                             ;80DD12;      ; 
                       LDA.B #$80                           ;80DD14;      ; 
                       STA.B $74                            ;80DD16;000074; 
                       SEP #$20                             ;80DD18;      ; 
                       LDA.B #$07                           ;80DD1A;      ; 
                       LDX.B #$04                           ;80DD1C;      ; 
                       LDY.B #$02                           ;80DD1E;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DD20;808E48; 
                       REP #$20                             ;80DD24;      ; 
                       SEP #$10                             ;80DD26;      ; 
                       LDA.W #$EF11                         ;80DD28;      ; 
                       STA.B $72                            ;80DD2B;000072; 
                       SEP #$20                             ;80DD2D;      ; 
                       LDA.B #$80                           ;80DD2F;      ; 
                       STA.B $74                            ;80DD31;000074; 
                       SEP #$20                             ;80DD33;      ; 
                       LDA.B #$0D                           ;80DD35;      ; 
                       LDX.B #$05                           ;80DD37;      ; 
                       LDY.B #$02                           ;80DD39;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DD3B;808E48; 
                       REP #$20                             ;80DD3F;      ; 
                       SEP #$10                             ;80DD41;      ; 
                       LDA.W #$EF1C                         ;80DD43;      ; 
                       STA.B $72                            ;80DD46;000072; 
                       SEP #$20                             ;80DD48;      ; 
                       LDA.B #$80                           ;80DD4A;      ; 
                       STA.B $74                            ;80DD4C;000074; 
                       SEP #$20                             ;80DD4E;      ; 
                       LDA.B #$0E                           ;80DD50;      ; 
                       LDX.B #$06                           ;80DD52;      ; 
                       LDY.B #$02                           ;80DD54;      ; 
                       JSL.L UNK_MemoryWork42_44            ;80DD56;808E48; 
                       RTS                                  ;80DD5A;      ; 


        UNK_RainTable: db $79,$7F,$10,$11,$3A,$10,$8E,$6A,$10,$0D,$5E,$10,$D2,$6A,$10,$0D;80DD5B;      ; 
                       db $5E,$10,$8E,$6A,$10,$11,$3A,$10,$FE,$FF,$5B,$DD,$80,$D2,$6A,$10;80DD6B;      ; 
                       db $8E,$6A,$10,$0D,$5E,$10,$D2,$6A,$10,$11,$3A,$10,$D2,$6A,$10,$0D;80DD7B;      ; 
                       db $5E,$10,$8E,$6A,$10,$FE,$FF,$78,$DD,$80,$8E,$6A,$10,$0D,$5E,$10;80DD8B;      ; 
                       db $D2,$6A,$10,$11,$3A,$10,$0D,$5E,$10,$11,$3A,$10,$D2,$6A,$10,$0D;80DD9B;      ; 
                       db $5E,$10,$FE,$FF,$95,$DD,$80,$0D,$5E,$10,$D2,$6A,$10,$53,$42,$10;80DDAB;      ; 
                       db $0D,$5E,$10,$8E,$6A,$10,$0D,$5E,$10,$53,$42,$10,$D2,$6A,$10,$FE;80DDBB;      ; 
                       db $FF,$B2,$DD,$80,$9D,$53,$10,$12,$2E,$10,$FB,$1D,$10,$94,$1D,$10;80DDCB;      ; 
                       db $FE,$2E,$10,$94,$1D,$10,$FB,$1D,$10,$12,$2E,$10,$FE,$FF,$CF,$DD;80DDDB;      ; 
                       db $80,$FE,$2E,$10,$FB,$1D,$10,$94,$1D,$10,$FE,$2E,$10,$12,$2E,$10;80DDEB;      ; 
                       db $FE,$2E,$10,$94,$1D,$10,$FB,$1D,$10,$FE,$FF,$EC,$DD,$80,$FB,$1D;80DDFB;      ; 
                       db $10,$94,$1D,$10,$FE,$2E,$10,$12,$2E,$10,$94,$1D,$10,$12,$2E,$10;80DE0B;      ; 
                       db $FE,$2E,$10,$94,$1D,$10,$FE,$FF,$09,$DE,$80,$94,$1D,$10,$FE,$2E;80DE1B;      ; 
                       db $10,$74,$2E,$10,$FB,$1D,$10,$FB,$1D,$10,$FB,$1D,$10,$74,$2E,$10;80DE2B;      ; 
                       db $FE,$2E,$10,$FE,$FF,$26,$DE,$80,$52,$5A,$10,$4C,$31,$10,$6B,$35;80DE3B;      ; 
                       db $10,$08,$29,$10,$52,$5A,$10,$08,$29,$10,$6B,$35,$10,$4C,$31,$10;80DE4B;      ; 
                       db $FE,$FF,$43,$DE,$80,$EF,$45,$10,$EF,$49,$10,$08,$29,$10,$52,$5A;80DE5B;      ; 
                       db $10,$4C,$31,$10,$52,$5A,$10,$08,$29,$10,$EF,$49,$10,$FE,$FF,$60;80DE6B;      ; 
                       db $DE,$80,$6B,$35,$10,$4A,$39,$10,$52,$5A,$10,$4C,$31,$10,$08,$29;80DE7B;      ; 
                       db $10,$4C,$31,$10,$52,$5A,$10,$4A,$39,$10,$FE,$FF,$7D,$DE,$80,$08;80DE8B;      ; 
                       db $29,$10,$52,$5A,$10,$4C,$31,$10,$6B,$35,$10,$6B,$35,$10,$6B,$35;80DE9B;      ; 
                       db $10,$4C,$31,$10,$52,$5A,$10,$FE,$FF,$9A,$DE,$80,$6B,$45,$10,$E7;80DEAB;      ; 
                       db $1C,$10,$E7,$28,$10,$08,$29,$10,$6B,$45,$10,$08,$29,$10,$E7,$28;80DEBB;      ; 
                       db $10,$E7,$1C,$10,$FE,$FF,$B7,$DE,$80,$08,$35,$10,$08,$35,$10,$E7;80DECB;      ; 
                       db $28,$10,$08,$29,$10,$6B,$45,$10,$08,$29,$10,$E7,$28,$10,$08,$35;80DEDB;      ; 
                       db $10,$FE,$FF,$D4,$DE,$80,$E7,$28,$10,$E7,$28,$10,$6B,$45,$10,$E7;80DEEB;      ; 
                       db $1C,$10,$0B,$29,$10,$E7,$1C,$10,$6B,$45,$10,$E7,$28,$10,$FE,$FF;80DEFB;      ; 
                       db $F1,$DE,$80,$C5,$28,$10,$6B,$45,$10,$08,$35,$10,$E7,$28,$10,$E7;80DF0B;      ; 
                       db $1C,$10,$E7,$28,$10,$08,$35,$10,$6B,$45,$10,$FE,$FF,$0E,$DF,$80;80DF1B;      ; 
                       db $99,$7F,$10,$0F,$32,$10,$8E,$5A,$10,$4D,$52,$10,$D2,$62,$10,$4D;80DF2B;      ; 
                       db $52,$10,$8E,$5A,$10,$0F,$32,$10,$FE,$FF,$2B,$DF,$80,$D2,$62,$10;80DF3B;      ; 
                       db $8E,$5A,$10,$4D,$52,$10,$D2,$62,$10,$0F,$32,$10,$D2,$62,$10,$4D;80DF4B;      ; 
                       db $52,$10,$8E,$5A,$10,$FE,$FF,$48,$DF,$80,$8E,$5A,$10,$4D,$52,$10;80DF5B;      ; 
                       db $D2,$62,$10,$0F,$32,$10,$8E,$5A,$10,$0F,$32,$10,$D2,$62,$10,$4D;80DF6B;      ; 
                       db $52,$10,$FE,$FF,$65,$DF,$80,$4D,$52,$10,$D2,$62,$10,$0F,$32,$10;80DF7B;      ; 
                       db $8E,$5A,$10,$4D,$52,$10,$8E,$5A,$10,$0F,$32,$10,$D2,$62,$10,$FE;80DF8B;      ; 
                       db $FF,$82,$DF,$80,$FE,$23,$10,$98,$22,$10,$DB,$11,$10,$9B,$02,$10;80DF9B;      ; 
                       db $1F,$03,$10,$9B,$02,$10,$DB,$11,$10,$98,$22,$10,$FE,$FF,$9F,$DF;80DFAB;      ; 
                       db $80,$1F,$03,$10,$DC,$11,$10,$B6,$01,$10,$1F,$03,$10,$76,$22,$10;80DFBB;      ; 
                       db $1F,$03,$10,$B6,$01,$10,$DC,$11,$10,$FE,$FF,$BC,$DF,$80,$DB,$11;80DFCB;      ; 
                       db $10,$B6,$01,$10,$1F,$03,$10,$76,$22,$10,$5F,$12,$10,$76,$22,$10;80DFDB;      ; 
                       db $1F,$03,$10,$B6,$01,$10,$FE,$FF,$D9,$DF,$80,$B6,$01,$10,$1F,$03;80DFEB;      ; 
                       db $10,$76,$22,$10,$DB,$11,$10,$B6,$01,$10,$DB,$11,$10,$76,$22,$10;80DFFB;      ; 
                       db $1F,$03,$10,$FE,$FF,$F6,$DF,$80,$CD,$51,$10,$6B,$21,$10,$6B,$49;80E00B;      ; 
                       db $10,$87,$45,$10,$CD,$51,$10,$87,$45,$10,$6B,$49,$10,$6B,$21,$10;80E01B;      ; 
                       db $FE,$FF,$13,$E0,$80,$6B,$49,$10,$6B,$49,$10,$87,$45,$10,$CD,$51;80E02B;      ; 
                       db $10,$6B,$21,$10,$CD,$51,$10,$87,$45,$10,$6B,$49,$10,$FE,$FF,$30;80E03B;      ; 
                       db $E0,$80,$DB,$11,$10,$B6,$01,$10,$1F,$03,$10,$76,$22,$10,$5F,$12;80E04B;      ; 
                       db $10,$76,$22,$10,$1F,$03,$10,$B6,$01,$10,$FE,$FF,$4D,$E0,$80,$07;80E05B;      ; 
                       db $35,$10,$CD,$51,$10,$6B,$21,$10,$6B,$69,$10,$87,$45,$10,$6B,$49;80E06B;      ; 
                       db $10,$6B,$21,$10,$CD,$51,$10,$FE,$FF,$6A,$E0,$80,$40,$61,$10,$C6;80E07B;      ; 
                       db $20,$10,$04,$41,$10,$C0,$30,$10,$64,$45,$10,$C0,$30,$10,$04,$41;80E08B;      ; 
                       db $10,$C6,$20,$10,$FE,$FF,$87,$E0,$80,$64,$45,$10,$04,$41,$10,$C0;80E09B;      ; 
                       db $30,$10,$64,$45,$10,$C6,$20,$10,$64,$45,$10,$C0,$30,$10,$04,$41;80E0AB;      ; 
                       db $10,$FE,$FF,$A4,$E0,$80,$04,$41,$10,$C0,$30,$10,$64,$45,$10,$C6;80E0BB;      ; 
                       db $20,$10,$04,$41,$10,$C6,$20,$10,$64,$45,$10,$C0,$30,$10,$FE,$FF;80E0CB;      ; 
                       db $C1,$E0,$80,$C0,$30,$10,$64,$45,$10,$C6,$20,$10,$04,$41,$10,$C0;80E0DB;      ; 
                       db $30,$10,$04,$41,$10,$C6,$20,$10,$64,$45,$10,$FE,$FF,$DE,$E0,$80;80E0EB;      ; 
                       db $50,$01,$08,$53,$01,$08,$50,$01,$08,$53,$01,$08,$FE,$FF,$FB,$E0;80E0FB;      ; 
                       db $80,$D7,$09,$08,$D9,$09,$08,$D7,$09,$08,$D9,$09,$08,$FE,$FF,$0C;80E10B;      ; 
                       db $E1,$80,$9F,$02,$08,$9F,$03,$08,$9F,$02,$08,$9F,$03,$08,$FE,$FF;80E11B;      ; 
                       db $1D,$E1,$80,$9C,$01,$08,$9F,$02,$08,$9C,$01,$08,$9F,$02,$08,$FE;80E12B;      ; 
                       db $FF,$2E,$E1,$80,$38,$01,$08,$9C,$01,$08,$38,$01,$08,$9C,$01,$08;80E13B;      ; 
                       db $FE,$FF,$3F,$E1,$80,$EA,$00,$08,$1C,$01,$08,$EA,$00,$08,$EA,$00;80E14B;      ; 
                       db $08,$FE,$FF,$50,$E1,$80,$2D,$01,$08,$2D,$01,$08,$2D,$01,$08,$3B;80E15B;      ; 
                       db $01,$08,$FE,$FF,$61,$E1,$80,$48,$00,$08,$0C,$00,$08,$FE,$FF,$72;80E16B;      ; 
                       db $E1,$80,$17,$00,$08,$1A,$00,$08,$FE,$FF,$7D,$E1,$80,$1F,$00,$08;80E17B;      ; 
                       db $7F,$01,$08,$FE,$FF,$88,$E1,$80,$B4,$01,$08,$19,$02,$08,$FE,$FF;80E18B;      ; 
                       db $93,$E1,$80,$4C,$00,$08,$52,$00,$08,$FE,$FF,$9E,$E1,$80,$BF,$02;80E19B;      ; 
                       db $08,$7F,$01,$08,$FE,$FF,$A9,$E1,$80,$9F,$00,$08,$5F,$03,$08,$FE;80E1AB;      ; 
                       db $FF,$B4,$E1,$80,$9F,$02,$08,$9F,$03,$08,$FE,$FF,$BF,$E1,$80,$8D;80E1BB;      ; 
                       db $21,$08,$10,$2E,$08,$10,$2E,$08,$10,$2E,$08,$FE,$FF,$CA,$E1,$80;80E1CB;      ; 
                       db $9C,$5F,$08,$7B,$5F,$08,$F9,$4A,$08,$7B,$5F,$08,$FE,$FF,$DB,$E1;80E1DB;      ; 
                       db $80,$F9,$4A,$08,$F9,$4A,$08,$1F,$26,$08,$F9,$4A,$08,$FE,$FF,$EC;80E1EB;      ; 
                       db $E1,$80,$1F,$26,$08,$1F,$26,$08,$3E,$05,$08,$1F,$26,$08,$FE,$FF;80E1FB;      ; 
                       db $FD,$E1,$80,$3E,$05,$08,$1F,$26,$08,$F9,$4A,$08,$1F,$26,$08,$FE;80E20B;      ; 
                       db $FF,$0E,$E2,$80,$1F,$26,$08,$F9,$4A,$08,$F9,$4A,$08,$F9,$4A,$08;80E21B;      ; 
                       db $FE,$FF,$1F,$E2,$80,$BF,$03,$08,$1F,$26,$08,$BF,$03,$08,$1F,$26;80E22B;      ; 
                       db $08,$FE,$FF,$30,$E2,$80,$BF,$03,$08,$1F,$26,$08,$3E,$05,$08,$1F;80E23B;      ; 
                       db $26,$08,$FE,$FF,$41,$E2,$80,$3F,$12,$08,$BF,$06,$08,$FE,$FF,$52;80E24B;      ; 
                       db $E2,$80,$48,$00,$08,$4D,$00,$08,$FE,$FF,$5D,$E2,$80,$1F,$02,$08;80E25B;      ; 
                       db $3A,$01,$08,$FE,$FF,$68,$E2,$80,$FA,$00,$08,$3F,$03,$08,$FE,$FF;80E26B;      ; 
                       db $73,$E2,$80,$48,$00,$08,$4F,$00,$08,$FE,$FF,$7E,$E2,$80,$9A,$1E;80E27B;      ; 
                       db $08,$1F,$1F,$08,$FE,$FF,$89,$E2,$80,$1F,$02,$08,$37,$00,$08,$FE;80E28B;      ; 
                       db $FF,$94,$E2,$80,$19,$00,$08,$25,$00,$08,$FE,$FF,$9F,$E2,$80,$7F;80E29B;      ; 
                       db $2E,$08,$3F,$23,$08,$FE,$FF,$AA,$E2,$80,$88,$00,$08,$8C,$00,$08;80E2AB;      ; 
                       db $FE,$FF,$B5,$E2,$80,$9D,$00,$08,$9F,$02,$08,$FE,$FF,$C0,$E2,$80;80E2BB;      ; 
                       db $1F,$02,$08,$1F,$01,$08,$FE,$FF,$CB,$E2,$80,$90,$00,$08,$9C,$00;80E2CB;      ; 
                       db $08,$FE,$FF,$D6,$E2,$80,$DE,$01,$08,$BF,$02,$08,$FE,$FF,$E1,$E2;80E2DB;      ; 
                       db $80,$4F,$00,$08,$D0,$00,$08,$FE,$FF,$EC,$E2,$80,$0F,$5E,$10,$54;80E2EB;      ; 
                       db $4A,$10,$17,$7F,$10,$FE,$FF,$F7,$E2,$80,$54,$4A,$10,$17,$7F,$10;80E2FB;      ; 
                       db $0F,$5E,$10,$FE,$FF,$05,$E3,$80,$17,$7F,$10,$0F,$5E,$10,$54,$4A;80E30B;      ; 
                       db $10,$FE,$FF,$13,$E3,$80,$13,$42,$10,$57,$42,$10,$FC,$56,$10,$FE;80E31B;      ; 
                       db $FF,$21,$E3,$80,$57,$42,$10,$FC,$56,$10,$13,$42,$10,$FE,$FF,$2F;80E32B;      ; 
                       db $E3,$80,$FC,$56,$10,$13,$42,$10,$57,$42,$10,$FE,$FF,$3D,$E3,$80;80E33B;      ; 
                       db $4A,$3D,$10,$4A,$3D,$10,$8C,$45,$10,$FE,$FF,$4B,$E3,$80,$4A,$3D;80E34B;      ; 
                       db $10,$8C,$45,$10,$4A,$3D,$10,$FE,$FF,$59,$E3,$80,$8C,$45,$10,$4A;80E35B;      ; 
                       db $3D,$10,$4A,$3D,$10,$FE,$FF,$67,$E3,$80,$29,$31,$10,$08,$29,$10;80E36B;      ; 
                       db $6B,$31,$10,$FE,$FF,$75,$E3,$80,$08,$29,$10,$6B,$31,$10,$29,$31;80E37B;      ; 
                       db $10,$FE,$FF,$83,$E3,$80,$6B,$31,$10,$29,$31,$10,$08,$29,$10,$FE;80E38B;      ; 
                       db $FF,$91,$E3,$80,$50,$62,$10,$71,$72,$10,$79,$7F,$10,$FE,$FF,$9F;80E39B;      ; 
                       db $E3,$80,$71,$72,$10,$79,$7F,$10,$50,$62,$10,$FE,$FF,$AD,$E3,$80;80E3AB;      ; 
                       db $79,$7F,$10,$50,$62,$10,$71,$72,$10,$FE,$FF,$BB,$E3,$80,$78,$5E;80E3BB;      ; 
                       db $10,$54,$56,$10,$19,$7F,$10,$FE,$FF,$C9,$E3,$80,$54,$56,$10,$19;80E3CB;      ; 
                       db $7F,$10,$78,$5E,$10,$FE,$FF,$D7,$E3,$80,$19,$7F,$10,$78,$5E,$10;80E3DB;      ; 
                       db $54,$56,$10,$FE,$FF,$E5,$E3,$80,$4A,$3D,$10,$4A,$3D,$10,$8C,$45;80E3EB;      ; 
                       db $10,$FE,$FF,$F3,$E3,$80,$4A,$3D,$10,$8C,$45,$10,$4A,$3D,$10,$FE;80E3FB;      ; 
                       db $FF,$01,$E4,$80,$8C,$45,$10,$4A,$3D,$10,$4A,$3D,$10,$FE,$FF,$0F;80E40B;      ; 
                       db $E4,$80,$E7,$30,$10,$E7,$30,$10,$29,$35,$10,$FE,$FF,$1D,$E4,$80;80E41B;      ; 
                       db $E7,$30,$10,$29,$35,$10,$E7,$30,$10,$FE,$FF,$2B,$E4,$80,$29,$35;80E42B;      ; 
                       db $10,$E7,$30,$10,$E7,$30,$10,$FE,$FF,$39,$E4,$80,$91,$4A,$10,$CE;80E43B;      ; 
                       db $62,$10,$74,$63,$10,$FE,$FF,$47,$E4,$80,$CE,$62,$10,$74,$63,$10;80E44B;      ; 
                       db $91,$4A,$10,$FE,$FF,$55,$E4,$80,$74,$63,$10,$91,$4A,$10,$CE,$62;80E45B;      ; 
                       db $10,$FE,$FF,$63,$E4,$80,$94,$36,$10,$54,$32,$10,$FC,$3A,$10,$FE;80E46B;      ; 
                       db $FF,$71,$E4,$80,$54,$32,$10,$FC,$3A,$10,$94,$36,$10,$FE,$FF,$7F;80E47B;      ; 
                       db $E4,$80,$EC,$3A,$10,$94,$36,$10,$54,$32,$10,$FE,$FF,$8D,$E4,$80;80E48B;      ; 
                       db $CB,$2D,$10,$CB,$2D,$10,$0E,$36,$10,$FE,$FF,$9B,$E4,$80,$CB,$2D;80E49B;      ; 
                       db $10,$0E,$36,$10,$CB,$2D,$10,$FE,$FF,$A9,$E4,$80,$0E,$36,$10,$CB;80E4AB;      ; 
                       db $2D,$10,$CB,$2D,$10,$FE,$FF,$B7,$E4,$80,$E7,$30,$10,$27,$31,$10;80E4BB;      ; 
                       db $6A,$35,$10,$FE,$FF,$C5,$E4,$80,$27,$31,$10,$6A,$35,$10,$E7,$30;80E4CB;      ; 
                       db $10,$FE,$FF,$D3,$E4,$80,$6A,$35,$10,$E7,$30,$10,$27,$31,$10,$FE;80E4DB;      ; 
                       db $FF,$E1,$E4,$80,$62,$21,$0A,$90,$21,$0A,$D2,$25,$10,$90,$21,$0A;80E4EB;      ; 
                       db $FE,$FF,$EF,$E4,$80,$58,$0E,$0A,$9A,$12,$0A,$DC,$16,$10,$9A,$12;80E4FB;      ; 
                       db $0A,$FE,$FF,$00,$E5,$80,$7D,$37,$0A,$9F,$47,$0A,$DF,$53,$10,$9F;80E50B;      ; 
                       db $47,$0A,$FE,$FF,$11,$E5,$80,$2C,$09,$0A,$6F,$11,$0A,$B1,$11,$10;80E51B;      ; 
                       db $6F,$11,$0A,$FE,$FF,$22,$E5,$80,$8E,$0D,$0A,$B1,$0D,$0A,$B4,$0D;80E52B;      ; 
                       db $10,$B1,$0D,$0A,$FE,$FF,$33,$E5,$80,$D7,$36,$0A,$19,$37,$0A,$7F;80E53B;      ; 
                       db $37,$10,$19,$37,$0A,$FE,$FF,$44,$E5,$80,$DE,$27,$0A,$FF,$3F,$0A;80E54B;      ; 
                       db $FF,$53,$10,$FF,$3F,$0A,$FE,$FF,$55,$E5,$80,$6E,$19,$0A,$70,$19;80E55B;      ; 
                       db $0A,$92,$19,$10,$70,$19,$0A,$FE,$FF,$66,$E5,$80,$0A,$15,$0A,$4F;80E56B;      ; 
                       db $1D,$0A,$90,$1D,$10,$4F,$1D,$0A,$FE,$FF,$77,$E5,$80,$18,$0A,$0A;80E57B;      ; 
                       db $1C,$0A,$0A,$9F,$0A,$10,$1C,$0A,$0A,$FE,$FF,$88,$E5,$80,$7C,$2F;80E58B;      ; 
                       db $0A,$BE,$2F,$0A,$DF,$4B,$10,$BE,$2F,$0A,$FE,$FF,$99,$E5,$80,$0C;80E59B;      ; 
                       db $09,$0A,$6E,$11,$0A,$90,$11,$10,$6E,$11,$0A,$FE,$FF,$AA,$E5,$80;80E5AB;      ; 
                       db $E8,$1C,$0A,$0A,$21,$0A,$6F,$21,$10,$0A,$21,$0A,$FE,$FF,$BB,$E5;80E5BB;      ; 
                       db $80,$F3,$29,$0A,$19,$2A,$0A,$7B,$32,$10,$19,$2A,$0A,$FE,$FF,$CC;80E5CB;      ; 
                       db $E5,$80,$B8,$3E,$0A,$3D,$3F,$0A,$7F,$43,$10,$3D,$3F,$0A,$FE,$FF;80E5DB;      ; 
                       db $DD,$E5,$80,$6C,$1D,$0A,$8E,$21,$0A,$AF,$25,$10,$8E,$21,$0A,$FE;80E5EB;      ; 
                       db $FF,$EE,$E5,$80,$3B,$7F,$10,$B5,$6E,$10,$2E,$5E,$0F,$F0,$51,$10;80E5FB;      ; 
                       db $33,$52,$0C,$B7,$6E,$10,$FE,$FF,$FF,$E5,$80,$B7,$6E,$10,$2E,$5E;80E60B;      ; 
                       db $10,$F0,$51,$0F,$39,$7F,$10,$F0,$51,$0C,$33,$52,$10,$FE,$FF,$16;80E61B;      ; 
                       db $E6,$80,$2E,$5E,$10,$F0,$51,$10,$3B,$7F,$0F,$B7,$6E,$10,$39,$7F;80E62B;      ; 
                       db $0C,$D1,$4D,$10,$FE,$FF,$2D,$E6,$80,$F0,$51,$10,$39,$7F,$10,$B7;80E63B;      ; 
                       db $6E,$0F,$2E,$5E,$10,$B7,$6E,$0C,$39,$7F,$10,$FE,$FF,$44,$E6,$80;80E64B;      ; 
                       db $F0,$41,$10,$F1,$3D,$10,$11,$42,$0F,$F1,$41,$10,$11,$42,$0C,$F1;80E65B;      ; 
                       db $3D,$10,$FE,$FF,$5B,$E6,$80,$7B,$53,$10,$BB,$42,$10,$34,$32,$0F;80E66B;      ; 
                       db $33,$32,$10,$34,$32,$0C,$BB,$42,$10,$FE,$FF,$72,$E6,$80,$B8,$42;80E67B;      ; 
                       db $10,$34,$32,$10,$33,$32,$0F,$DB,$42,$10,$33,$32,$0C,$34,$32,$10;80E68B;      ; 
                       db $FE,$FF,$89,$E6,$80,$34,$32,$10,$33,$32,$10,$DB,$42,$0F,$B8,$32;80E69B;      ; 
                       db $10,$DB,$42,$0C,$33,$32,$10,$FE,$FF,$A0,$E6,$80,$33,$32,$10,$DB;80E6AB;      ; 
                       db $42,$10,$B8,$32,$0F,$34,$32,$10,$B8,$32,$0C,$DB,$42,$10,$FE,$FF;80E6BB;      ; 
                       db $B7,$E6,$80,$B1,$21,$10,$D1,$25,$10,$D1,$29,$0F,$34,$32,$10,$D1;80E6CB;      ; 
                       db $29,$0C,$D1,$25,$10,$FE,$FF,$CE,$E6,$80,$13,$32,$10,$8C,$1D,$10;80E6DB;      ; 
                       db $CF,$29,$0F,$11,$2E,$10,$CF,$29,$0C,$8C,$1D,$10,$FE,$FF,$E5,$E6;80E6EB;      ; 
                       db $80,$F1,$2D,$10,$33,$32,$10,$8C,$1D,$0F,$CF,$29,$10,$8C,$1D,$0C;80E6FB;      ; 
                       db $33,$32,$10,$FE,$FF,$FC,$E6,$80,$AF,$21,$10,$11,$2E,$10,$33,$32;80E70B;      ; 
                       db $0F,$8C,$1D,$10,$33,$32,$0C,$11,$2E,$10,$FE,$FF,$13,$E7,$80,$6C;80E71B;      ; 
                       db $1D,$10,$CF,$29,$10,$11,$2E,$0F,$33,$32,$10,$11,$2E,$0C,$CF,$29;80E72B;      ; 
                       db $10,$FE,$FF,$2A,$E7,$80,$4C,$1D,$10,$4C,$1D,$10,$4C,$21,$0F,$4C;80E73B;      ; 
                       db $21,$10,$4C,$21,$0C,$4C,$1D,$10,$FE,$FF,$41,$E7,$80,$8B,$21,$10;80E74B;      ; 
                       db $2A,$19,$10,$4B,$1D,$0F,$4B,$1D,$10,$4B,$1D,$0C,$2A,$19,$10,$FE;80E75B;      ; 
                       db $FF,$58,$E7,$80,$4B,$1D,$10,$6B,$21,$10,$2A,$19,$0F,$4B,$1D,$10;80E76B;      ; 
                       db $2A,$19,$0C,$6B,$21,$10,$FE,$FF,$6F,$E7,$80,$2A,$1D,$10,$48,$1D;80E77B;      ; 
                       db $10,$4B,$21,$0F,$2A,$19,$10,$4B,$21,$0C,$48,$1D,$10,$FE,$FF,$86;80E78B;      ; 
                       db $E7,$80,$28,$19,$10,$4B,$1D,$10,$4B,$1D,$0F,$6B,$1D,$10,$4B,$1D;80E79B;      ; 
                       db $0C,$4B,$1D,$10,$FE,$FF,$9D,$E7,$80,$52,$7F,$10,$66,$5D,$10,$86;80E7AB;      ; 
                       db $7D,$0F,$4B,$7E,$10,$86,$7D,$0C,$66,$5D,$10,$FE,$FF,$B4,$E7,$80;80E7BB;      ; 
                       db $4B,$7E,$10,$32,$4F,$10,$66,$5D,$0F,$86,$7D,$10,$66,$5D,$0C,$32;80E7CB;      ; 
                       db $7F,$10,$FE,$FF,$CB,$E7,$80,$86,$7D,$10,$4B,$7E,$10,$32,$7F,$0F;80E7DB;      ; 
                       db $66,$5D,$10,$32,$7F,$0C,$4B,$7E,$10,$FE,$FF,$E2,$E7,$80,$66,$5D;80E7EB;      ; 
                       db $10,$86,$7D,$10,$4B,$7E,$0F,$32,$7F,$10,$4B,$7E,$0C,$86,$7D,$10;80E7FB;      ; 
                       db $FE,$FF,$F9,$E7,$80,$66,$5D,$10,$86,$61,$10,$86,$65,$0F,$A6,$69;80E80B;      ; 
                       db $10,$86,$65,$0C,$86,$61,$10,$FE,$FF,$10,$E8,$80,$9E,$3F,$10,$9E;80E81B;      ; 
                       db $16,$10,$18,$12,$0F,$74,$11,$10,$18,$12,$0C,$9E,$16,$10,$FE,$FF;80E82B;      ; 
                       db $27,$E8,$80,$9E,$16,$10,$18,$12,$10,$74,$11,$0F,$FA,$2A,$10,$74;80E83B;      ; 
                       db $11,$0C,$18,$12,$10,$FE,$FF,$3E,$E8,$80,$18,$12,$10,$74,$11,$10;80E84B;      ; 
                       db $9E,$3F,$0F,$9E,$16,$10,$9E,$3F,$0C,$74,$11,$10,$FE,$FF,$55,$E8;80E85B;      ; 
                       db $80,$74,$11,$10,$7B,$26,$10,$9E,$16,$0F,$18,$12,$10,$9E,$16,$0C;80E86B;      ; 
                       db $7B,$26,$10,$FE,$FF,$6C,$E8,$80,$B1,$1D,$10,$B2,$1D,$10,$B3,$1D;80E87B;      ; 
                       db $0F,$B3,$1D,$10,$B3,$1D,$0C,$B2,$1D,$10,$FE,$FF,$83,$E8,$80,$B3;80E88B;      ; 
                       db $0D,$10,$B3,$09,$10,$91,$09,$0F,$72,$01,$10,$91,$09,$0C,$B3,$09;80E89B;      ; 
                       db $10,$FE,$FF,$9A,$E8,$80,$B3,$09,$10,$91,$09,$10,$72,$01,$0F,$B3;80E8AB;      ; 
                       db $0D,$10,$72,$01,$0C,$91,$09,$10,$FE,$FF,$B1,$E8,$80,$91,$09,$10;80E8BB;      ; 
                       db $72,$01,$10,$B3,$0D,$0F,$B3,$09,$10,$B3,$0D,$0C,$72,$01,$10,$FE;80E8CB;      ; 
                       db $FF,$C8,$E8,$80,$72,$01,$10,$B3,$0D,$10,$B3,$09,$0F,$91,$09,$10;80E8DB;      ; 
                       db $B3,$09,$0C,$B3,$0D,$10,$FE,$FF,$DF,$E8,$80,$4E,$19,$10,$0C,$11;80E8EB;      ; 
                       db $10,$0B,$11,$0F,$0B,$11,$10,$0B,$11,$0C,$0C,$11,$10,$FE,$FF,$F6;80E8FB;      ; 
                       db $E8,$80,$0C,$11,$10,$0B,$11,$10,$0B,$11,$0F,$4E,$19,$10,$0B,$11;80E90B;      ; 
                       db $0C,$0B,$11,$10,$FE,$FF,$0D,$E9,$80,$0B,$11,$10,$0B,$11,$10,$4E;80E91B;      ; 
                       db $19,$0F,$0C,$11,$10,$4E,$19,$0C,$0B,$11,$10,$FE,$FF,$24,$E9,$80;80E92B;      ; 
                       db $0B,$11,$10,$4E,$19,$10,$0C,$11,$0F,$0B,$11,$10,$0C,$11,$0C,$4E;80E93B;      ; 
                       db $19,$10,$FE,$FF,$3B,$E9,$80,$AC,$21,$10,$8B,$1D,$10,$2B,$0D,$0F;80E94B;      ; 
                       db $2B,$0D,$10,$2B,$0D,$0C,$8B,$1D,$10,$FE,$FF,$52,$E9,$80,$2B,$0D;80E95B;      ; 
                       db $10,$2B,$0D,$10,$8B,$1D,$0F,$AC,$21,$10,$8B,$1D,$0C,$2B,$0D,$10;80E96B;      ; 
                       db $FE,$FF,$69,$E9,$80,$FE,$32,$10,$EE,$21,$10,$D1,$29,$0F,$14,$22;80E97B;      ; 
                       db $10,$D1,$29,$0C,$EE,$21,$10,$FE,$FF,$80,$E9,$80,$F5,$29,$10,$76;80E98B;      ; 
                       db $2E,$10,$EE,$21,$0F,$D1,$29,$10,$EE,$21,$0C,$76,$2E,$10,$FE,$FF;80E99B;      ; 
                       db $97,$E9,$80,$F4,$15,$10,$14,$32,$10,$33,$2E,$0F,$EE,$21,$10,$33;80E9AB;      ; 
                       db $2E,$0C,$14,$32,$10,$FE,$FF,$AE,$E9,$80,$D3,$1D,$10,$D1,$29,$10;80E9BB;      ; 
                       db $34,$2E,$0F,$D1,$1D,$10,$34,$2E,$0C,$D1,$29,$10,$FE,$FF,$C5,$E9;80E9CB;      ; 
                       db $80,$EF,$25,$10,$CE,$25,$10,$AE,$25,$0F,$AD,$25,$10,$AE,$25,$0C;80E9DB;      ; 
                       db $CE,$25,$10,$FE,$FF,$DC,$E9,$80,$4E,$21,$10,$4F,$1D,$10,$B4,$1D;80E9EB;      ; 
                       db $0F,$B4,$1D,$10,$B4,$1D,$0C,$4F,$1D,$10,$FE,$FF,$F3,$E9,$80,$B4;80E9FB;      ; 
                       db $1D,$10,$72,$1D,$10,$72,$1D,$0F,$4F,$1D,$10,$72,$1D,$0C,$72,$1D;80EA0B;      ; 
                       db $10,$FE,$FF,$0A,$EA,$80,$7F,$37,$10,$B0,$21,$10,$1C,$16,$0F,$59;80EA1B;      ; 
                       db $1A,$10,$1C,$16,$0C,$B0,$21,$10,$FE,$FF,$21,$EA,$80,$59,$1A,$10;80EA2B;      ; 
                       db $9B,$1A,$10,$B0,$21,$0F,$1C,$16,$10,$B0,$21,$0C,$9B,$1A,$10,$FE;80EA3B;      ; 
                       db $FF,$38,$EA,$80,$1C,$16,$10,$59,$1A,$10,$1F,$1B,$0F,$B0,$21,$10;80EA4B;      ; 
                       db $1F,$1B,$0C,$59,$1A,$10,$FE,$FF,$4F,$EA,$80,$94,$09,$10,$1C,$16;80EA5B;      ; 
                       db $10,$59,$1A,$0F,$9B,$1A,$10,$59,$1A,$0C,$1C,$16,$10,$FE,$FF,$66;80EA6B;      ; 
                       db $EA,$80,$90,$21,$10,$B0,$21,$10,$91,$21,$0F,$B1,$21,$10,$91,$21;80EA7B;      ; 
                       db $0C,$B0,$21,$10,$FE,$FF,$7D,$EA,$80,$4C,$1D,$10,$8E,$21,$10,$B0;80EA8B;      ; 
                       db $21,$0F,$B2,$21,$10,$B0,$21,$0C,$8E,$21,$10,$FE,$FF,$94,$EA,$80;80EA9B;      ; 
                       db $B2,$21,$10,$4C,$1D,$10,$8E,$21,$0F,$B0,$21,$10,$8E,$21,$0C,$4C;80EAAB;      ; 
                       db $1D,$10,$FE,$FF,$AB,$EA,$80,$B0,$21,$10,$B2,$21,$10,$4C,$1D,$0F;80EABB;      ; 
                       db $8E,$21,$10,$4C,$1D,$0C,$B2,$21,$10,$FE,$FF,$C2,$EA,$80,$8E,$21;80EACB;      ; 
                       db $10,$B0,$21,$10,$B2,$21,$0F,$4C,$1D,$10,$B2,$21,$0C,$B0,$21,$10;80EADB;      ; 
                       db $FE,$FF,$D9,$EA,$80,$6C,$1D,$10,$09,$15,$10,$2C,$1D,$0F,$4C,$1D;80EAEB;      ; 
                       db $10,$2C,$1D,$0C,$09,$15,$10,$FE,$FF,$F0,$EA,$80,$4C,$1D,$10,$6C;80EAFB;      ; 
                       db $1D,$10,$09,$15,$0F,$2C,$1D,$10,$09,$15,$0C,$6C,$1D,$10,$FE,$FF;80EB0B;      ; 
                       db $07,$EB,$80,$2C,$1D,$10,$4C,$1D,$10,$6C,$1D,$0F,$09,$15,$10,$6C;80EB1B;      ; 
                       db $1D,$0C,$4C,$1D,$10,$FE,$FF,$1E,$EB,$80,$09,$15,$10,$2C,$1D,$10;80EB2B;      ; 
                       db $4C,$1D,$0F,$6C,$1D,$10,$4C,$1D,$0C,$2C,$1D,$10,$FE,$FF,$35,$EB;80EB3B;      ; 
                       db $80,$DB,$77,$10,$98,$73,$10,$98,$73,$10,$98,$73,$10,$FE,$FF,$4C;80EB4B;      ; 
                       db $EB,$80,$98,$73,$10,$98,$73,$10,$DB,$77,$10,$98,$73,$10,$FE,$FF;80EB5B;      ; 
                       db $5D,$EB,$80,$7D,$5F,$10,$3B,$4B,$10,$3B,$4B,$10,$3B,$4B,$10,$FE;80EB6B;      ; 
                       db $FF,$6E,$EB,$80,$3B,$4B,$10,$3B,$4B,$10,$7D,$5F,$10,$3B,$4B,$10;80EB7B;      ; 
                       db $FE,$FF,$7F,$EB,$80,$95,$32,$10,$52,$2E,$10,$52,$2E,$10,$52,$2E;80EB8B;      ; 
                       db $10,$FE,$FF,$90,$EB,$80,$52,$2E,$10,$52,$2E,$10,$95,$32,$10,$52;80EB9B;      ; 
                       db $2E,$10,$FE,$FF,$A1,$EB,$80,$4A,$31,$10,$29,$2D,$10,$29,$2D,$10;80EBAB;      ; 
                       db $29,$2D,$10,$FE,$FF,$B2,$EB,$80,$29,$2D,$10,$29,$2D,$10,$4A,$31;80EBBB;      ; 
                       db $10,$29,$2D,$10,$FE,$FF,$C3,$EB,$80,$99,$77,$10,$34,$63,$10,$34;80EBCB;      ; 
                       db $63,$10,$34,$63,$10,$FE,$FF,$D4,$EB,$80,$34,$63,$10,$34,$63,$10;80EBDB;      ; 
                       db $DB,$77,$10,$34,$63,$10,$FE,$FF,$E5,$EB,$80,$7E,$67,$10,$1C,$47;80EBEB;      ; 
                       db $10,$1C,$47,$10,$1C,$47,$10,$FE,$FF,$F6,$EB,$80,$1C,$47,$10,$1C;80EBFB;      ; 
                       db $47,$10,$7E,$67,$10,$1C,$47,$10,$FE,$FF,$07,$EC,$80,$94,$56,$10;80EC0B;      ; 
                       db $31,$4E,$10,$31,$4E,$10,$31,$4E,$10,$FE,$FF,$18,$EC,$80,$31,$4E;80EC1B;      ; 
                       db $10,$31,$4E,$10,$94,$56,$10,$31,$4E,$10,$FE,$FF,$29,$EC,$80,$8C;80EC2B;      ; 
                       db $49,$10,$4A,$41,$10,$4A,$41,$10,$4A,$41,$10,$FE,$FF,$3A,$EC,$80;80EC3B;      ; 
                       db $4A,$41,$10,$4A,$41,$10,$8C,$49,$10,$4A,$41,$10,$FE,$FF,$4B,$EC;80EC4B;      ; 
                       db $80,$76,$73,$10,$34,$63,$10,$34,$63,$10,$34,$63,$10,$FE,$FF,$5C;80EC5B;      ; 
                       db $EC,$80,$34,$63,$10,$34,$63,$10,$76,$73,$10,$34,$63,$10,$FE,$FF;80EC6B;      ; 
                       db $6D,$EC,$80,$7F,$53,$10,$FB,$42,$10,$FB,$42,$10,$FB,$42,$10,$FE;80EC7B;      ; 
                       db $FF,$7E,$EC,$80,$FB,$42,$10,$FB,$42,$10,$7F,$53,$10,$FB,$42,$10;80EC8B;      ; 
                       db $FE,$FF,$8F,$EC,$80,$71,$46,$10,$31,$3E,$10,$31,$3E,$10,$31,$3E;80EC9B;      ; 
                       db $10,$FE,$FF,$A0,$EC,$80,$31,$3E,$10,$31,$3E,$10,$71,$46,$10,$31;80ECAB;      ; 
                       db $3E,$10,$FE,$FF,$B1,$EC,$80,$6A,$31,$10,$49,$2D,$10,$49,$2D,$10;80ECBB;      ; 
                       db $49,$2D,$10,$FE,$FF,$C2,$EC,$80,$49,$2D,$10,$49,$2D,$10,$6A,$31;80ECCB;      ; 
                       db $10,$49,$2D,$10,$FE,$FF,$C2,$EC,$80,$9B,$77,$10,$77,$73,$10,$77;80ECDB;      ; 
                       db $73,$10,$77,$73,$10,$FE,$FF,$E4,$EC,$80,$77,$73,$10,$77,$73,$10;80ECEB;      ; 
                       db $9B,$77,$10,$77,$73,$10,$FE,$FF,$F5,$EC,$80,$59,$6F,$10,$37,$6B;80ECFB;      ; 
                       db $10,$37,$6B,$10,$37,$6B,$10,$FE,$FF,$06,$ED,$80,$37,$6B,$10,$37;80ED0B;      ; 
                       db $6B,$10,$59,$6F,$10,$37,$6B,$10,$FE,$FF,$17,$ED,$80,$B5,$5A,$10;80ED1B;      ; 
                       db $73,$52,$10,$73,$52,$10,$73,$52,$10,$FE,$FF,$28,$ED,$80,$73,$52;80ED2B;      ; 
                       db $10,$73,$52,$10,$B5,$5A,$10,$73,$52,$10,$FE,$FF,$39,$ED,$80,$EE;80ED3B;      ; 
                       db $4D,$10,$CE,$45,$10,$CE,$45,$10,$CE,$45,$10,$FE,$FF,$4A,$ED,$80;80ED4B;      ; 
                       db $CE,$45,$10,$CE,$45,$10,$EE,$4D,$10,$CE,$45,$10,$FE,$FF,$5B,$ED;80ED5B;      ; 
                       db $80,$85,$51,$0C,$E8,$61,$0C,$4C,$6E,$0C,$0C,$7F,$0C,$4C,$6E,$0C;80ED6B;      ; 
                       db $E8,$61,$0C,$FE,$FF,$6C,$ED,$80,$E7,$69,$0C,$88,$79,$0C,$E7,$69;80ED7B;      ; 
                       db $0C,$67,$61,$0C,$E7,$69,$0C,$88,$79,$0C,$FE,$FF,$83,$ED,$80,$2C;80ED8B;      ; 
                       db $7E,$0F,$97,$7F,$0F,$53,$7F,$0F,$E7,$7E,$0F,$FE,$FF,$9A,$ED,$80;80ED9B;      ; 
                       db $EF,$7E,$0F,$2C,$7E,$0F,$97,$7F,$0F,$53,$7F,$0F,$FE,$FF,$AB,$ED;80EDAB;      ; 
                       db $80,$53,$7F,$0F,$EF,$7E,$0F,$2C,$7E,$0F,$97,$7F,$0F,$FE,$FF,$BC;80EDBB;      ; 
                       db $ED,$80,$97,$7F,$0F,$53,$7F,$0F,$E7,$7E,$0F,$2C,$7E,$0F,$FE,$FF;80EDCB;      ; 
                       db $CD,$ED,$80,$70,$00,$0F,$5F,$0E,$0F,$FF,$03,$0F,$FE,$FF,$DE,$ED;80EDDB;      ; 
                       db $80,$5F,$0E,$0F,$70,$00,$0F,$FF,$03,$0F,$FE,$FF,$EC,$ED,$80,$FF;80EDEB;      ; 
                       db $03,$0F,$5F,$0E,$0F,$70,$00,$0F,$FE,$FF,$FA,$ED,$80,$0C,$00,$08;80EDFB;      ; 
                       db $0A,$00,$08,$09,$00,$08,$FE,$FF,$08,$EE,$80,$0A,$00,$08,$D8,$00;80EE0B;      ; 
                       db $08,$7E,$02,$08,$FE,$FF,$16,$EE,$80,$7F,$01,$08,$9F,$02,$08,$D2;80EE1B;      ; 
                       db $00,$08,$FE,$FF,$24,$EE,$80,$1F,$03,$08,$5F,$03,$08,$FF,$03,$08;80EE2B;      ; 
                       db $FE,$FF,$32,$EE,$80,$79,$22,$10,$9B,$22,$10,$DC,$22,$10,$FE,$FF;80EE3B;      ; 
                       db $40,$EE,$80,$54,$08,$10,$DE,$08,$10,$DC,$08,$10,$FE,$FF,$4E,$EE;80EE4B;      ; 
                       db $80,$9D,$08,$10,$DE,$08,$10,$1F,$09,$10,$FE,$FF,$5C,$EE,$80,$DF;80EE5B;      ; 
                       db $08,$10,$DF,$08,$10,$1F,$0A,$10,$FE,$FF,$6A,$EE,$80,$DF,$08,$10;80EE6B;      ; 
                       db $3F,$0A,$10,$9F,$0A,$10,$FE,$FF,$78,$EE,$80,$9F,$02,$10,$9F,$02;80EE7B;      ; 
                       db $10,$1F,$03,$10,$FE,$FF,$86,$EE,$80,$5F,$03,$10,$DF,$03,$10,$FF;80EE8B;      ; 
                       db $03,$10,$FE,$FF,$94,$EE,$80,$3C,$0A,$0C,$DB,$00,$0C,$DF,$00,$0C;80EE9B;      ; 
                       db $DF,$00,$0C,$FE,$FF,$A2,$EE,$80,$B3,$09,$0C,$FF,$11,$0C,$5F,$0A;80EEAB;      ; 
                       db $0C,$5F,$12,$0C,$FE,$FF,$B3,$EE,$80,$92,$09,$0C,$15,$0A,$0C,$3A;80EEBB;      ; 
                       db $02,$0C,$3F,$13,$0C,$FE,$FF,$C4,$EE,$80,$98,$2A,$10,$3D,$43,$10;80EECB;      ; 
                       db $98,$2A,$10,$7F,$4F,$10,$5F,$4F,$10,$3D,$43,$10,$FE,$FF,$D5,$EE;80EEDB;      ; 
                       db $80,$FA,$42,$10,$98,$2A,$10,$FA,$42,$10,$DB,$2A,$10,$1C,$37,$10;80EEEB;      ; 
                       db $98,$2A,$10,$DB,$2A,$10,$FE,$FF,$EC,$EE,$80,$49,$00,$08,$4C,$00;80EEFB;      ; 
                       db $08,$FE,$FF,$06,$EF,$80,$37,$00,$08,$3D,$01,$08,$FE,$FF,$11,$EF;80EF0B;      ; 
                       db $80,$5F,$02,$08,$DF,$02,$08,$FE,$FF,$1C,$EF,$80,$00;80EF1B;      ; 