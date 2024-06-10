ORG $858000

;;;;;;;;Gets called every time a sprite is added?
CODE_858000:
        !temp_component_idx = $75
        !temp_sprite_table_component_address = $78
        !temp_sprite_table_component_address_H = $7A
        !temp = $75
        !temp_unused_H = $77

        %Set16bit(!M)
        LDA.B !gobj_sprite_table_idx
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
        ;if theres space, selects the next unloaded slot, if not, finds an unused one
        %Set16bit(!MX)
        %Set16bit(!MX)
        LDX.W #$0000
        LDY.W #$0000
        LDA.B !gobj_loaded_objs
        CMP.W #$0028
        BEQ .findemptyslot
        INC A
        STA.B !gobj_loaded_objs

    .findemptyslot:
            LDA.W !gobj_struct_initialized,X
            BEQ .slotfound
            TXA
            CLC
            ADC.W #$0024
            TAX
            INY
            CPY.B !gobj_loaded_objs
            BNE .findemptyslot

        ;exits if no unused slot is found
        LDA.W #$FFFF
        STA.B $A7
        BRA return85

    .slotfound:
        ;fills the slot with some pre programed data
        STY.B !gobj_last_gobj_used
        LDA.W #$7777
        STA.W !gobj_struct_initialized,X
        LDA.B !gobj_sprite_table_idx
        STA.W !gobj_struct_sprite_table_idx,X
        LDA.B !gobj_flip_x
        STA.W !gobj_struct_flip,X
        LDA.B $A3
        STA.W !gobj_struct_UNK1,X
        LDA.B !gobj_pos_x
        STA.W !gobj_struct_pos_X,X
        LDA.B !gobj_pos_y
        STA.W !gobj_struct_pos_Y,X
        STX.B !gobj_struct_idx
        LDA.B !gobj_sprite_table_idx
        CMP.W #$0262
        BCS .inbank87
        LDA.W !gobj_struct_sprite_table_idx,X
        ASL A
        TAX
        LDA.L DATA8_868080,X
        STA.B $75
        BRA .setupfinished

    .inbank87:
        LDA.W !gobj_struct_sprite_table_idx,X
        SEC
        SBC.W #$0262
        ASL A
        TAX
        LDA.L DATA8_878080,X
        STA.B $75

    .setupfinished:
        LDX.B !gobj_struct_idx
        LDA.B $75
        STA.W !gobj_struct_UNK2,X
        CLC
        ADC.W #$0003
        STA.W !gobj_struct_UNK3,X
        LDY.W #$0000
        LDA.B [$75],Y
        STA.W !gobj_struct_sprite_table_address,X
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$75],Y
        STA.W !gobj_struct_UNK4,X
        %Set16bit(!M)
        JSR.W CODE_858AE5
        %Set16bit(!M)
        LDA.W #$0000
        STA.B $A7

;;;;;;;; Return of many functions
return85: RTL

;;;;;;;;
CODE_8580B9:
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
        BCS .CODE_8580CC
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .CODE_8580D4

    .CODE_8580CC:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .CODE_8580D4:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L Table_GameOBJIndexes,X
        STA.B $A9
        TAX
        LDA.W #$0001
        STA.B $A7
        LDA.W $019C,X
        BEQ .CODE_8580FF
        LDA.B $9F
        STA.W $01A0,X
        LDA.B $9B
        STA.W $01A4,X
        LDA.B $9D
        STA.W $01A6,X
        LDA.W #$0000
        STA.B $A7

    .CODE_8580FF: RTL

;;;;;;;;
CODE_858100:
        %Set16bit(!MX)
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
        BCS .CODE_858115
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .CODE_85811D

        .CODE_858115:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

        .CODE_85811D:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L Table_GameOBJIndexes,X
        STA.B $A9
        JSR.W CODE_858B7B
        LDA.B $AF
        BNE return85
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDY.B $A5
        LDX.B $A9
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
        BCS .CODE_858168
        LDA.W $019E,X
        ASL A
        TAX
        LDA.L DATA8_868080,X
        STA.B $75
        BRA .CODE_858177

        .CODE_858168:
        LDA.W $019E,X
        SEC
        SBC.W #$0262
        ASL A
        TAX
        LDA.L DATA8_878080,X
        STA.B $75

        .CODE_858177:
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
        LDA.W #$0000
        STA.B $A7

        RTL

;;;;;;;;
        CODE_8581A2:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L Table_GameOBJIndexes,X
        STA.B $A9
        JSR.W CODE_858B7B
        LDA.B $AF
        BEQ .CODE_8581B8
        JMP.W return85

        .CODE_8581B8:
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDX.B $A9
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $019C,X
        LDA.W $01AA,X

        RTL

;;;;;;;;
CODE_8581CB:
        %Set16bit(!MX)
        LDA.B $A5
        ASL A
        TAX
        LDA.L Table_GameOBJIndexes,X
        STA.B $A9
        TAX
        LDA.W $019C,X
        BEQ .CODE_8581F6
        LDA.W $019E,X
        STA.B $A1
        LDA.W $01A0,X
        STA.B $9F
        LDA.W $01A2,X
        STA.B $A3
        LDA.W $01A4,X
        STA.B $9B
        LDA.W $01A6,X
        STA.B $9D

    .CODE_8581F6:
        %Set8bit(!M)
        LDA.W $01AE,X
        %Set8bit(!M)
        CMP.B #$00
        BMI .CODE_858206
        XBA
        LDA.B #$00
        BRA .CODE_858209

    .CODE_858206:
        XBA
        LDA.B #$FF

    .CODE_858209:
        XBA
        %Set16bit(!M)
        STA.B $A7

        RTL

;;;;;;;;
InitializeOBJs: ;85820F
        %Set16bit(!MX)
        %Set16bit(!M)
        LDA.B $A1
        CMP.W #$0262
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
CODE_8582C7:
        %Set16bit(!MX)
        STZ.B $A9
        STZ.B $AB

    .CODE_8582CD:
            LDX.B $A9
            LDA.W $019C,X
            BNE .CODE_8582E7

        .CODE_8582D4:
            LDA.B $A9
            CLC
            ADC.W #$0024
            STA.B $A9
            INC.B $AB
            LDA.B $AB
            CMP.B $DC
            BNE .CODE_8582CD

        JMP.W .CODE_858376

    .CODE_8582E7:
        %Set16bit(!MX)
        LDA.W $019E,X
        CMP.W #$0262
        BCS .CODE_8582FB
        %Set8bit(!M)
        LDA.B #$86
        STA.B $77
        STA.B $7A
        BRA .CODE_858303

    .CODE_8582FB:
        %Set8bit(!M)
        LDA.B #$87
        STA.B $77
        STA.B $7A

    .CODE_858303:
        %Set8bit(!M)
        LDA.W $01AE,X
        BNE .CODE_858349
        %Set16bit(!M)
        JSR.W CODE_858B7B
        LDA.B $AF
        BNE .CODE_8582D4
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDX.B $A9
        LDA.W $01AA,X
        STA.B $75

    .CODE_85831F:
        LDA.B [$75]
        BNE .CODE_85832A
        LDA.W $01A8,X
        STA.B $75
        BRA .CODE_85831F

    .CODE_85832A:
        STA.W $01AC,X
        %Set8bit(!M)
        LDY.W #$0002
        LDA.B [$75],Y
        STA.W $01AE,X
        %Set16bit(!M)
        LDA.B $75
        CLC
        ADC.W #$0003
        STA.W $01AA,X
        JSR.W CODE_858AE5
        %Set16bit(!MX)
        BRA .CODE_858362

    .CODE_858349:
        %Set8bit(!M)
        LDA.W $01AE,X
        CMP.B #$FE
        BNE .CODE_858362
        %Set16bit(!M)
        JSR.W CODE_858B41
        %Set16bit(!MX)
        LDA.W #$0000
        STA.W $019C,X
        JMP.W .CODE_8582D4

    .CODE_858362:
        LDX.B $A9
        %Set8bit(!M)
        LDA.W $01AE,X
        CMP.B #$FF
        BEQ .CODE_858371
        DEC A
        STA.W $01AE,X

    .CODE_858371:
        %Set16bit(!MX)
        JMP.W .CODE_8582D4

    .CODE_858376:
        RTL

;;;;;;;; This populates the $084C array, that is the order each OBJ
;;;;;;;; should be copied to OBJRAM, akind a ZBuffer
GetOBJOrderToDraw: ;858377
        %Set16bit(!MX)
        LDA.W !player_gobj_index
        ASL A
        TAX
        LDA.L Table_GameOBJIndexes,X
        TAX
        LDA.W $01A6,X                        ;Y pos
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
            BEQ .next
            LDA.W $01A6,X
            CMP.B $A9
            BCC .smallerthany
            LDX.B $AD
            TYA
            %Set8bit(!M)
            STA.W $084C,X
            %Set16bit(!M)
            INC.B $AD
            BRA .next

        .smallerthany:
            %Set16bit(!M)
            LDX.B $AF
            TYA
            %Set8bit(!M)
            STA.W $084C,X
            %Set16bit(!M)
            DEC.B $AF

        .next:
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

;;;;;;;; This function reads the different GOBJs and prepares the SOBJ table to be copied
;;;;;;;; into the OBJRAM, and prepares the DMA
PrepareOAMData: ;8583E0
        !temp_component_idx = $75
        !temp_sprite_table_component_address = $78
        !temp_sprite_table_component_address_H = $7A
        !temp_unused_H = $77

        %Set16bit(!MX)
        %Set16bit(!M)
        ;Calculates what bank data should be used for the sprite metadata, but
        ;I dont think this is used before being rewriten in the main loop
        LDA.B !gobj_sprite_table_idx
        CMP.W #$0262
        BCS .sethighbank
        %Set8bit(!M)
        LDA.B #$86
        STA.B !temp_unused_H
        STA.B !temp_sprite_table_component_address_H
        BRA .continue

    .sethighbank:
        %Set8bit(!M)
        LDA.B #$87
        STA.B !temp_unused_H
        STA.B !temp_sprite_table_component_address_H

    .continue:
        ;Prepares the memory to start processing data
        %Set16bit(!MX)
        JSR.W PresetsWRAMCopyOAMCopy
        JSR.W GetOBJOrderToDraw
        %Set16bit(!MX)
        %Set8bit(!M)
        LDA.B #$00
        XBA
        LDA.W !gobj_order_array
        %Set16bit(!M)
        ASL A
        TAX
        LDA.L Table_GameOBJIndexes,X
        STA.B !gobj_struct_idx
        LDA.W #$0000
        STA.B !gobj_current_gobj
        STA.B !gobj_OAM_table_idx
        LDY.B !gobj_current_gobj

    ;MOBIUS TRIPLE REACHAROUND, this loop is a bit of a mess flowwise.
    ;but in essence, it goes GOBJ by GOBJ, component by component of them,
    ;filling the SOBJ high and low tables.
    .gobjloop:
            LDX.B !gobj_struct_idx
            LDA.W !gobj_struct_initialized,X
            BNE .gameobjfound                ;if its initialized

        .setnextgobj:
            INY
            TYX
            %Set8bit(!M)
            LDA.B #$00
            XBA
            LDA.W !gobj_order_array,X
            %Set16bit(!M)
            ASL A
            TAX
            LDA.L Table_GameOBJIndexes,X
            STA.B !gobj_struct_idx
            CPY.B !gobj_loaded_objs
            BNE .gobjloop
            JMP.W .prepareDMA                ;end of the list reached

        .gameobjfound:
            STY.B !gobj_current_gobj
            LDX.B !gobj_struct_idx
            LDA.W !gobj_struct_sprite_table_idx,X
            CMP.W #$0262
            BCS .setgobjhighbank
            %Set8bit(!M)
            LDA.B #$86
            STA.B !temp_unused_H
            STA.B !temp_sprite_table_component_address_H
            BRA .bankset

        .setgobjhighbank:
            %Set8bit(!M)
            LDA.B #$87
            STA.B !temp_unused_H
            STA.B !temp_sprite_table_component_address_H

        .bankset:
            ;loads data from the GOBJ
            %Set16bit(!M)
            LDA.W !gobj_struct_sprite_table_address,X
            STA.B !temp_sprite_table_component_address
            LDA.W !gobj_struct_flip,X
            STA.B !gobj_flip_x
            LDA.W !gobj_struct_pos_X,X
            STA.B !gobj_pos_x
            LDA.W !gobj_struct_pos_Y,X
            STA.B !gobj_pos_y
            %Set8bit(!M)
            LDA.W !gobj_struct_component_total,X
            STA.B !gobj_component_total
            STZ.B !gobj_component_total_high_byte
            ;Sets the location of the X offset in the Sprite Data Table
            %Set16bit(!M)
            INC.B !temp_sprite_table_component_address
            LDA.B !gobj_component_total
            DEC A
            STA.B $7E
            ASL A
            STA.B $80
            CLC
            ADC.B $7E
            ADC.B $80
            ADC.B !temp_sprite_table_component_address
            STA.B !temp_sprite_table_component_address
            ;Sets last components, as they are read last to first
            LDA.B !gobj_struct_idx
            STA.B !temp_component_idx
            CLC
            ADC.B !gobj_component_total
            SEC
            SBC.W #$0001
            STA.B !temp_component_idx

        .setnextcomponent:
                LDY.B !gobj_current_gobj
                LDA.B !gobj_component_total
                BNE .setnextsnesobj
                JMP.W .setnextgobj

            .setnextsnesobj:
                LDX.B !temp_component_idx
                %Set8bit(!M)
                LDA.W !gobj_struct_components,X
                CMP.B #$FF
                BNE .componentfound
                JMP.W .componentnotset

            .componentfound:
                ;calculates final X position of the sprite
                %Set16bit(!M)
                LDY.W #$0002
                %Set8bit(!M)
                LDA.B [!temp_sprite_table_component_address],Y
                %Set8bit(!M)
                CMP.B #$00
                BMI .negativexoffset
                XBA
                LDA.B #$00
                BRA .flipxoffset

            .negativexoffset:
                XBA
                LDA.B #$FF

            .flipxoffset:
                XBA
                %Set16bit(!M)
                JSR.W InvertIfFlipedX
                CLC
                ADC.B !gobj_pos_x
                SEC
                SBC.B !OBJ_Offset_X
                STA.B !gobj_final_pos_x
                INY
                %Set8bit(!M)

                ;calculates final Y position of the sprite
                LDA.B [!temp_sprite_table_component_address],Y
                %Set8bit(!M)
                CMP.B #$00
                BMI .negativeyoffset
                XBA
                LDA.B #$00
                BRA .flipyoffset

            .negativeyoffset:
                XBA
                LDA.B #$FF

            .flipyoffset:
                XBA
                %Set16bit(!M)
                JSR.W InvertIfFlipedY
                CLC
                ADC.B !gobj_pos_y
                SEC
                SBC.B !OBJ_Offset_Y
                STA.B !gobj_final_pos_y

                STY.B !gobj_data_table_idx

                ;calculates OAM High X position Bit
                %Set16bit(!MX)
                LDA.B !gobj_OAM_table_idx
                AND.W #$FFE0                     ;Remove first 5 bits
                STA.B $7E
                LSR A
                LSR A
                LSR A
                LSR A                            ;/16
                STA.B $80
                LDA.B !gobj_OAM_table_idx
                SEC
                SBC.B $7E
                STA.B $7E
                LDA.B $80
                TAX
                LDA.L $7EA200,X
                STA.B !gobj_current_OAM_HT_value
                LDA.B !gobj_final_pos_x
                CMP.W #$0100
                BCC .posXlessthan1byte
                LDA.B $7E
                AND.W #$FFFC
                LSR A
                TAX
                LDA.L Table_HighOAMXbit,X
                ORA.B !gobj_current_OAM_HT_value
                STA.B !gobj_current_OAM_HT_value

            .posXlessthan1byte:
                %Set16bit(!M)
                LDA.B !gobj_final_pos_x
                CMP.W #$0100
                BCC .posYcalculation
                CMP.W #$FFF0
                BCS .posYcalculation
                JMP.W .spritenotonscreen

            .posYcalculation:
                %Set16bit(!M)
                LDA.B !gobj_final_pos_y
                CMP.W #$00F0
                BCC .storingOAMcopy
                CMP.W #$FFF0
                BCS .storingOAMcopy
                JMP.W .spritenotonscreen

            .storingOAMcopy:
                %Set16bit(!MX)
                LDX.B !gobj_OAM_table_idx
                LDA.B !gobj_final_pos_x
                %Set8bit(!M)
                STA.L !sobj_low_table_x,X
                %Set16bit(!M)
                LDA.B !gobj_final_pos_y
                %Set8bit(!M)
                STA.L !sobj_low_table_y,X
                %Set16bit(!M)
                LDX.B $80
                LDA.B !gobj_current_OAM_HT_value
                STA.L !sobj_high_table,X
                %Set16bit(!MX)
                LDX.B !gobj_OAM_table_idx
                LDY.B !gobj_data_table_idx
                INY
                %Set8bit(!M)
                LDA.B [!temp_sprite_table_component_address],Y
                STA.B $B2
                ASL A
                AND.B #$0E
                STA.B !gobj_pallete_data
                LDA.B $B2                    ;TODO: WTF is this bit shuffle?
                ASL A
                ASL A
                AND.B #$C0
                LSR A
                STA.B $B2
                ASL A
                ASL A
                ORA.B $B2
                AND.B #$C0
                ORA.B !gobj_pallete_data
                ORA.B #$20                   ;priority data, all objs are priority 2
                EOR.B !gobj_flip_x
                STA.L !sobj_low_table_attributes,X
                LDA.W !current_graphic_preset   ;TODO pallete relevant?
                ASL A
                ASL A
                ASL A
                ASL A
                ORA.L !sobj_low_table_attributes,X
                STA.L !sobj_low_table_attributes,X
                ;Sets sprite to use from the loaded sprites
                %Set16bit(!M)
                LDA.W #$0000
                LDX.B !temp_component_idx
                %Set8bit(!M)
                LDA.W !gobj_struct_components,X
                %Set16bit(!M)
                ASL A
                TAX
                LDA.L DATA8_868000,X
                %Set8bit(!M)
                LDX.B !gobj_OAM_table_idx
                STA.L !sobj_low_table_sprite,X
                ;prepares for next object
                %Set16bit(!M)
                LDA.B !gobj_OAM_table_idx
                CLC
                ADC.W #$0004
                STA.B !gobj_OAM_table_idx

            .spritenotonscreen:
                LDA.B !temp_sprite_table_component_address
                SEC
                SBC.W #$0005
                STA.B !temp_sprite_table_component_address
                BRA .preparefornextcomponent

            .componentnotset:
                %Set16bit(!M)
                LDA.B !temp_sprite_table_component_address
                SEC
                SBC.W #$0005
                STA.B !temp_sprite_table_component_address

            .preparefornextcomponent:
                DEC.B !temp_component_idx
                DEC.B $AD
                JMP.W .setnextcomponent

    .prepareDMA:
        %Set16bit(!MX)
        LDA.B !gobj_OAM_table_idx
        STA.W $084A                         ;this seems to be unused
        %Set8bit(!M)
        LDX.W #$0000
        STX.W !OAMADDL                       ;OAM Address Registers
        STZ.W $4340                          ;DMA PortX Control Register
        LDA.B #$04                           ;OAM Data Write Register
        STA.W $4341                          ;DMA PortX Destination Register
        LDA.B #$00
        STA.W $4342                          ;DMA PortX Source Address Registers
        LDA.B #$A0
        STA.W $4343
        LDA.B #$7E
        STA.W $4344
        LDX.W #$0220
        STX.W $4345
        LDA.B !ProgDMA_OAM_channel
        ORA.B #$10
        STA.B !ProgDMA_OAM_channel

        RTL

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
CODE_858AE5: ;858AE5
        %Set16bit(!MX)
        LDX.B !gobj_struct_idx
        LDA.W !gobj_struct_sprite_table_address,X
        STA.B $78
        LDY.W #$0000
        %Set8bit(!M)
        LDA.B [$78],Y
        STA.B !gobj_component_total
        STA.W !gobj_struct_component_total,X
        STZ.B !gobj_component_total_high_byte
        %Set16bit(!M)
        INY
        TXA
        CLC
        ADC.W #$019C
        CLC
        ADC.W #$0014                         ;adds $01B0, gobj_struct_components
        STA.B $AF

    .loop:
            LDA.B !gobj_component_total
            BNE .continue
            BRA .exitloop                    ;no components to add

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
            DEC.B !gobj_component_total
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

;;;;;;;; You can enter this subrutine trough one of these 2 functions
InvertIfFlipedX:
        %Set16bit(!MX)
        PHA
        LDA.B $9F
        AND.W #$0040
        BEQ InvertIfFliped_NotFliped
        BRA InvertIfFliped_Fliped

InvertIfFlipedY:
        PHA
        LDA.B $9F
        AND.W #$0080
        BEQ InvertIfFliped_NotFliped

    InvertIfFliped_Fliped:
            PLA
            EOR.W #$FFFF
            INC A
            CLC
            ADC.W #$FFF0
            RTS

    InvertIfFliped_NotFliped:
            PLA
            RTS

Table_HighOAMXbit: ;858BD0
        db $01,$00,$04,$00,$10,$00,$40,$00,$00,$01,$00,$04,$00,$10,$00,$40

;;;;;;; sums of 24
Table_GameOBJIndexes:;858BE0
        db $00,$00,$24,$00,$48,$00,$6C,$00,$90,$00,$B4,$00,$D8,$00,$FC,$00
        db $20,$01,$44,$01,$68,$01,$8C,$01,$B0,$01,$D4,$01,$F8,$01,$1C,$02
        db $40,$02,$64,$02,$88,$02,$AC,$02,$D0,$02,$F4,$02,$18,$03,$3C,$03
        db $60,$03,$84,$03,$A8,$03,$CC,$03,$F0,$03,$14,$04,$38,$04,$5C,$04
        db $80,$04,$A4,$04,$C8,$04,$EC,$04,$40,$05,$34,$05,$58,$05,$7C,$05

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

    .loop:                                   ;Posible infinite loop
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
            BNE .continue1
            JMP.W .escapeloop

        .continue1:
            LDA.B $C7
            CMP.W #$0100
            BCS .continue2
            JMP.W .escapeloop

        .continue2:
            LDX.B $BB
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

    .loop320:                                ;searches for a value
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
            BRA .CODE_858D2F                 ;infinite loop again???

        .skip320:
            STX.B $C3
            TXA
            LSR A
            LSR A
            STA.B $C5

        .CODE_858D38:
            LDA.B $C3
            BMI .CODE_858D38                 ;Another psible infinit loop!!!

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
