;;; General notes ;;;
{
; Loading the game:
;     $8A1E - load enemies - at $80:A0CA (start gameplay)
;     $8CD7 - initialise enemies and transfer tiles to VRAM - at $82:80C9/80F9/814C (game state 6/1Fh/28h), executed 6 times for 6 frames

; Main gameplay (game state 8):
;     $8EB6 - determine which enemies to process
;     $9785 - Samus / projectile interaction handler
;     $8FD4 - main enemy routine
;         $9758 - enemy collision handling
;         $C26A - process enemy instructions
;         $9423 - add enemy to drawing queue
;     $A8F0 - Samus / solid enemy collision detection, executed at least twice
;     $9894 - enemy projectile / Samus collision detection
;     $996C - enemy projectile / projectile collision detection
;     $A306 - process enemy power bomb interaction
;     $884D - draw Samus, projectiles, enemies and enemy projectiles
;         $944A - write enemy OAM
;         $88C4 - execute enemy graphics drawn hook
;     $9726 - handle queuing enemy BG2 tilemap VRAM transfer
;     $8687 - handle room shaking
;     $9169 - decrement Samus hurt timers and clear active enemy indices

; Door transition whilst screen is fading out (game state Ah/Bh):
;     $8EB6 - determine which enemies to process
;     $8FD4 - main enemy routine
;     $884D - draw Samus, enemies and enemy projectiles

; Door transition whilst screen is scrolling (game state Bh):
;     Enemy tiles are processed via enemy set data by $82:DFD1 during door transition function $E4A9
;     $8A1E - load enemies - at $82:E4A9
;         $896F - load enemy set data (just mirrors enemy set into RAM ($7E:D559), debug/pointless)
;         $8A6D - clear enemy data and process enemy set
;             $8D64 - process enemy set (from ROM directly) (loads enemy palettes and allocates space for tiles ($0E5A, $7E:EF5C))
;         $8C6C - load enemy tile data (loads enemy tiles into $7E:7000 from enemy loading data ($0E5A), this data is then DMA'd by $8CD7 (but not $8A9E))
;     $8A9E - initialise enemies - at $82:E4A9 (clear enemy tiles ($7E:7000), load enemy population data into enemy data)
;         $8BF3 - load enemy GFX indices (determines enemy VRAM tiles index and palette index ($0F98/96 / $7E:7006/08) from enemy set (again, from ROM directly))
;         $88D0 - record enemy spawn data (mirrors enemy population data to $7E:701E..39)
;         $8BE9 - execute enemy initialisation AI

; Door transition whilst screen is fading in (game state Bh):
;     $8EB6 - determine which enemies to process
;     $8FD4 - main enemy routine
;     $884D - draw Samus, enemies and enemy projectiles
;     $9726 - handle queuing enemy BG2 tilemap VRAM transfer
}


;;; $8000..8686: Common to all enemy banks ;;;
{
;;; $8000..4A: Common enemy AI ;;;
{
;;; $8000: Grapple AI - no interaction. Also unfreezes enemies(!) ;;;
{
; Used by skultera, Draygon body, fire arc, Phantoon, etecoon, dachora and WS ghost
$A0:8000 22 6D 9F A0 JSL $A09F6D[$A0:9F6D]  ; Switch enemy AI to main AI
$A0:8004 6B          RTL
}


;;; $8005: Grapple AI - Samus latches on ;;;
{
; Used by gripper and Crocomire
$A0:8005 22 7D 9F A0 JSL $A09F7D[$A0:9F7D]  ; Samus latches on with grapple
$A0:8009 6B          RTL
}


;;; $800A: Grapple AI - kill enemy ;;;
{
; Common
$A0:800A 22 C4 9F A0 JSL $A09FC4[$A0:9FC4]  ; Enemy grapple death
$A0:800E 6B          RTL
}


;;; $800F: Grapple AI - cancel grapple beam ;;;
{
; Common
$A0:800F 22 DF 9F A0 JSL $A09FDF[$A0:9FDF]  ; Switch to frozen AI
$A0:8013 6B          RTL
}


;;; $8014: Grapple AI - Samus latches on - no invincibility ;;;
{
; Used by powamp
$A0:8014 22 E9 9F A0 JSL $A09FE9[$A0:9FE9]  ; Samus latches on with grapple - no invincibility
$A0:8018 6B          RTL
}


;;; $8019: Unused. Grapple AI - Samus latches on - paralyse enemy ;;;
{
$A0:8019 22 3E A0 A0 JSL $A0A03E[$A0:A03E]  ; Samus latches on with grapple - paralyse enemy
$A0:801D 6B          RTL
}


;;; $801E: Grapple AI - hurt Samus ;;;
{
; Used by WS spark
; Hurt reaction happens in $9B:B932
$A0:801E 22 70 A0 A0 JSL $A0A070[$A0:A070]  ; Switch to frozen AI
$A0:8022 6B          RTL
}


;;; $8023: Normal enemy touch AI ;;;
{
$A0:8023 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A0:8027 6B          RTL
}


;;; $8028: Normal enemy touch AI - no death check ;;;
{
$A0:8028 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal enemy touch AI - no death check
$A0:802C 6B          RTL
}


;;; $802D: Normal enemy shot AI ;;;
{
$A0:802D 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A0:8031 6B          RTL
}


;;; $8032: Normal enemy shot AI - no death check, no enemy shot graphic ;;;
{
$A0:8032 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A0:8036 6B          RTL
}


;;; $8037: Normal enemy power bomb AI ;;;
{
$A0:8037 22 97 A5 A0 JSL $A0A597[$A0:A597]  ; Normal enemy power bomb AI
$A0:803B 6B          RTL
}


;;; $803C: Normal enemy power bomb AI - no death check ;;;
{
; Kraid's power bomb AI
$A0:803C 22 B7 A5 A0 JSL $A0A5B7[$A0:A5B7]  ; Normal enemy power bomb AI - no death check
$A0:8040 6B          RTL
}


;;; $8041: Normal enemy frozen AI ;;;
{
$A0:8041 22 7E 95 A0 JSL $A0957E[$A0:957E]  ; Normal enemy frozen AI
$A0:8045 6B          RTL
}


;;; $8046: Shot AI - dud shot ;;;
{
; Used only by Draygon and Spore Spawn
$A0:8046 22 BC A8 A0 JSL $A0A8BC[$A0:A8BC]
$A0:804A 6B          RTL
}
}


;;; $804B: RTS ;;;
{
$A0:804B 60          RTS
}


;;; $804C: RTL ;;;
{
$A0:804C 6B          RTL
}


;;; $804D: Spritemap - nothing ;;;
{
$A0:804D             dw 0000
}


;;; $804F: Extended spritemap - nothing ;;;
{
$A0:804F             dw 0001, 0000,0000,804D,8059
}


;;; $8059: Hitbox - nothing ;;;
{
; [n entries] [[left offset] [top offset] [right offset] [bottom offset] [p touch] [p shot]]...
$A0:8059             dw 0001, 0000,0000,0000,0000,8023,802D
}


;;; $8067: Unused. Instruction list - delete enemy ;;;
{
$A0:8067             dw 807C
}


;;; $8069: Two NOPs ;;;
{
; Used as palette by respawning enemy placeholder and Draygon's eye o_O
$A0:8069 EA          NOP
$A0:806A EA          NOP
}


;;; $806B..8186: Instructions ;;;
{
;;; $806B: Instruction - enemy $0FB2 = [[Y]] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction

; Used only by torizos (for enemy movement function), chozo statues and escape etecoon (for enemy function)
$A0:806B B9 00 00    LDA $0000,y
$A0:806E 9D B2 0F    STA $0FB2,x
$A0:8071 C8          INY
$A0:8072 C8          INY
$A0:8073 6B          RTL
}


;;; $8074: Instruction - enemy $0FB2 = RTS ;;;
{
;; Parameters:
;;     X: Enemy index

; Used only by chozo statues (for enemy function)
$A0:8074 A9 7B 80    LDA #$807B
$A0:8077 9D B2 0F    STA $0FB2,x
$A0:807A 6B          RTL

$A0:807B 60          RTS
}


;;; $807C: Instruction - delete enemy ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:807C BD 86 0F    LDA $0F86,x            ;\
$A0:807F 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$A0:8082 9D 86 0F    STA $0F86,x            ;/
$A0:8085 68          PLA                    ;\
$A0:8086 F4 AE C2    PEA $C2AE              ;} Terminate enemy instruction processing
$A0:8089 6B          RTL
}


;;; $808A: Instruction - call function [[Y]] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction

; Used only by Phantoon
$A0:808A B9 00 00    LDA $0000,y
$A0:808D 85 12       STA $12    [$7E:0012]
$A0:808F 5A          PHY
$A0:8090 DA          PHX
$A0:8091 F4 96 80    PEA $8096
$A0:8094 6C 12 00    JMP ($0012)

$A0:8097 FA          PLX
$A0:8098 7A          PLY
$A0:8099 C8          INY
$A0:809A C8          INY
$A0:809B 6B          RTL
}


;;; $809C: Unused. Instruction - call function [[Y]] with A = [[Y] + 2] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:809C B9 00 00    LDA $0000,y
$A0:809F 85 12       STA $12    [$7E:0012]
$A0:80A1 B9 02 00    LDA $0002,y
$A0:80A4 5A          PHY
$A0:80A5 DA          PHX
$A0:80A6 F4 AB 80    PEA $80AB
$A0:80A9 6C 12 00    JMP ($0012)

$A0:80AC FA          PLX
$A0:80AD 7A          PLY
$A0:80AE 98          TYA
$A0:80AF 18          CLC
$A0:80B0 69 04 00    ADC #$0004
$A0:80B3 A8          TAY
$A0:80B4 6B          RTL
}


;;; $80B5: Unused. Instruction - call external function [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:80B5 B9 00 00    LDA $0000,y
$A0:80B8 85 12       STA $12    [$7E:0012]
$A0:80BA B9 01 00    LDA $0001,y
$A0:80BD 85 13       STA $13    [$7E:0013]
$A0:80BF DA          PHX
$A0:80C0 5A          PHY
$A0:80C1 22 CB 80 A0 JSL $A080CB[$A0:80CB]
$A0:80C5 7A          PLY
$A0:80C6 FA          PLX
$A0:80C7 C8          INY
$A0:80C8 C8          INY
$A0:80C9 C8          INY
$A0:80CA 6B          RTL

$A0:80CB DC 12 00    JML [$0012]
}


;;; $80CE: Unused. Instruction - call external function [[Y]] with A = [[Y] + 3] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:80CE B9 00 00    LDA $0000,y
$A0:80D1 85 12       STA $12    [$7E:0012]
$A0:80D3 B9 01 00    LDA $0001,y
$A0:80D6 85 13       STA $13    [$7E:0013]
$A0:80D8 B9 03 00    LDA $0003,y
$A0:80DB DA          PHX
$A0:80DC 5A          PHY
$A0:80DD 22 EA 80 A0 JSL $A080EA[$A0:80EA]
$A0:80E1 7A          PLY
$A0:80E2 FA          PLX
$A0:80E3 98          TYA
$A0:80E4 18          CLC
$A0:80E5 69 05 00    ADC #$0005
$A0:80E8 A8          TAY
$A0:80E9 6B          RTL

$A0:80EA DC 12 00    JML [$0012]
}


;;; $80ED: Instruction - go to [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:80ED B9 00 00    LDA $0000,y
$A0:80F0 A8          TAY
$A0:80F1 6B          RTL
}


;;; $80F2: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:80F2 84 12       STY $12    [$7E:0012]
$A0:80F4 88          DEY
$A0:80F5 B9 00 00    LDA $0000,y
$A0:80F8 EB          XBA
$A0:80F9 30 05       BMI $05    [$8100]
$A0:80FB 29 FF 00    AND #$00FF
$A0:80FE 80 03       BRA $03    [$8103]

$A0:8100 09 00 FF    ORA #$FF00

$A0:8103 18          CLC
$A0:8104 65 12       ADC $12    [$7E:0012]
$A0:8106 A8          TAY
$A0:8107 6B          RTL
}


;;; $8108: Unused. Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:8108 DE 90 0F    DEC $0F90,x
$A0:810B D0 E0       BNE $E0    [$80ED]
$A0:810D C8          INY
$A0:810E C8          INY
$A0:810F 6B          RTL
}


;;; $8110: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:8110 DE 90 0F    DEC $0F90,x
$A0:8113 D0 D8       BNE $D8    [$80ED]
$A0:8115 C8          INY
$A0:8116 C8          INY
$A0:8117 6B          RTL
}


;;; $8118: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:8118 E2 20       SEP #$20
$A0:811A DE 90 0F    DEC $0F90,x
$A0:811D C2 20       REP #$20
$A0:811F D0 D1       BNE $D1    [$80F2]
$A0:8121 C8          INY
$A0:8122 6B          RTL
}


;;; $8123: Instruction - timer = [[Y]] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:8123 B9 00 00    LDA $0000,y
$A0:8126 9D 90 0F    STA $0F90,x
$A0:8129 C8          INY
$A0:812A C8          INY
$A0:812B 6B          RTL
}


;;; $812C: Unused. Instruction - skip next instruction ;;;
{
;; Parameters:
;;     Y: Pointer to after this instruction
;; Returns:
;;     Y: Pointer to next instruction
$A0:812C C8          INY
$A0:812D C8          INY
$A0:812E 6B          RTL
}


;;; $812F: Instruction - sleep ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to after this instruction
$A0:812F 88          DEY                    ;\
$A0:8130 88          DEY                    ;|
$A0:8131 98          TYA                    ;} Enemy instruction list pointer = [Y] - 2
$A0:8132 9D 92 0F    STA $0F92,x            ;/
$A0:8135 68          PLA                    ;\
$A0:8136 F4 AE C2    PEA $C2AE              ;} Terminate enemy instruction processing
$A0:8139 6B          RTL
}


;;; $813A: Instruction - wait [[Y]] frames ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments

; Set instruction timer and terminate processing enemy instructions
; Used for running a delay that doesn't update graphics,
; useful for e.g. GT eye beam attack ($AA:D10D), implemented by an instruction list that has no graphical instructions,
; which allows it to be called from multiple different poses
$A0:813A B9 00 00    LDA $0000,y            ;\
$A0:813D 9D 94 0F    STA $0F94,x            ;} Enemy instruction list timer = [[Y]]
$A0:8140 C8          INY                    ;\
$A0:8141 C8          INY                    ;|
$A0:8142 98          TYA                    ;} Enemy instruction list pointer = [Y] + 2
$A0:8143 9D 92 0F    STA $0F92,x            ;/
$A0:8146 68          PLA                    ;\
$A0:8147 F4 AE C2    PEA $C2AE              ;} Terminate enemy instruction processing
$A0:814A 6B          RTL
}


;;; $814B: Instruction - transfer [[Y]] bytes from [[Y] + 2] to VRAM [[Y] + 5] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$A0:814B DA          PHX
$A0:814C AE 30 03    LDX $0330  [$7E:0330]
$A0:814F B9 00 00    LDA $0000,y
$A0:8152 95 D0       STA $D0,x
$A0:8154 B9 02 00    LDA $0002,y
$A0:8157 95 D2       STA $D2,x
$A0:8159 B9 03 00    LDA $0003,y
$A0:815C 95 D3       STA $D3,x
$A0:815E B9 05 00    LDA $0005,y
$A0:8161 95 D5       STA $D5,x
$A0:8163 8A          TXA
$A0:8164 18          CLC
$A0:8165 69 07 00    ADC #$0007
$A0:8168 8D 30 03    STA $0330  [$7E:0330]
$A0:816B 98          TYA
$A0:816C 18          CLC
$A0:816D 69 07 00    ADC #$0007
$A0:8170 A8          TAY
$A0:8171 FA          PLX
$A0:8172 6B          RTL
}


;;; $8173: Instruction - enable off-screen processing ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:8173 BD 86 0F    LDA $0F86,x
$A0:8176 09 00 08    ORA #$0800
$A0:8179 9D 86 0F    STA $0F86,x
$A0:817C 6B          RTL
}


;;; $817D: Instruction - disable off-screen processing ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:817D BD 86 0F    LDA $0F86,x
$A0:8180 29 FF F7    AND #$F7FF
$A0:8183 9D 86 0F    STA $0F86,x
$A0:8186 6B          RTL
}
}


;;; $8187: Common enemy speeds - linearly increasing ;;;
{
; Speed, subspeed, negated speed, negated subspeed
$A0:8187             dw 0000,0000,0000,0000, 0000,1000,FFFF,F000, 0000,2000,FFFF,E000, 0000,3000,FFFF,D000,
                        0000,4000,FFFF,C000, 0000,5000,FFFF,B000, 0000,6000,FFFF,A000, 0000,7000,FFFF,9000,
                        0000,8000,FFFF,8000, 0000,9000,FFFF,7000, 0000,A000,FFFF,6000, 0000,B000,FFFF,5000,
                        0000,C000,FFFF,4000, 0000,D000,FFFF,3000, 0000,E000,FFFF,2000, 0000,F000,FFFF,1000,
                        0001,0000,FFFF,0000, 0001,1000,FFFE,F000, 0001,2000,FFFE,E000, 0001,3000,FFFE,D000,
                        0001,4000,FFFE,C000, 0001,5000,FFFE,B000, 0001,6000,FFFE,A000, 0001,7000,FFFE,9000,
                        0001,8000,FFFE,8000, 0001,9000,FFFE,7000, 0001,A000,FFFE,6000, 0001,B000,FFFE,5000,
                        0001,C000,FFFE,4000, 0001,D000,FFFE,3000, 0001,E000,FFFE,2000, 0001,F000,FFFE,1000,
                        0002,0000,FFFE,0000, 0002,1000,FFFD,F000, 0002,2000,FFFD,E000, 0002,3000,FFFD,D000,
                        0002,4000,FFFD,C000, 0002,5000,FFFD,B000, 0002,6000,FFFD,A000, 0002,7000,FFFD,9000,
                        0002,8000,FFFD,8000, 0002,9000,FFFD,7000, 0002,A000,FFFD,6000, 0002,B000,FFFD,5000,
                        0002,C000,FFFD,4000, 0002,D000,FFFD,3000, 0002,E000,FFFD,2000, 0002,F000,FFFD,1000,
                        0003,0000,FFFD,0000, 0003,1000,FFFC,F000, 0003,2000,FFFC,E000, 0003,3000,FFFC,D000,
                        0003,4000,FFFC,C000, 0003,5000,FFFC,B000, 0003,6000,FFFC,A000, 0003,7000,FFFC,9000,
                        0003,8000,FFFC,8000, 0003,9000,FFFC,7000, 0003,A000,FFFC,6000, 0003,B000,FFFC,5000,
                        0003,C000,FFFC,4000, 0003,D000,FFFC,3000, 0003,E000,FFFC,2000, 0003,F000,FFFC,1000,
                        0004,0000,FFFC,0000
}


;;; $838F: Common enemy speeds - quadratically increasing ;;;
{
; I.e. gravity
; Used by e.g. Botwoon when dying and falling to the floor

; Subspeed, speed, negated subspeed, negated speed
$A0:838F             dw 0000,0000,0000,0000, 0109,0000,FEF7,FFFF, 031B,0000,FCE5,FFFF, 0636,0000,F9CA,FFFF,
                        0A5A,0000,F5A6,FFFF, 0F87,0000,F079,FFFF, 15BD,0000,EA43,FFFF, 1CFC,0000,E304,FFFF,
                        2544,0000,DABC,FFFF, 2E95,0000,D16B,FFFF, 38EF,0000,C711,FFFF, 4452,0000,BBAE,FFFF,
                        50BE,0000,AF42,FFFF, 5E33,0000,A1CD,FFFF, 6CB1,0000,934F,FFFF, 7C38,0000,83C8,FFFF,
                        8CC8,0000,7338,FFFF, 9E61,0000,619F,FFFF, B103,0000,4EFD,FFFF, C4AE,0000,3B52,FFFF,
                        D962,0000,269E,FFFF, EF1F,0000,10E1,FFFF, 05E5,0000,FA1B,FFFF, 14B4,0001,EB4C,FFFE,
                        2D8C,0001,D274,FFFE, 476D,0001,B893,FFFE, 6257,0001,9DA9,FFFE, 7E4A,0001,81B6,FFFE,
                        9B46,0001,64BA,FFFE, B94B,0001,46B5,FFFE, D859,0001,27A7,FFFE, F870,0001,0790,FFFE,
                        1090,0002,EF70,FFFD, 32B9,0002,CD47,FFFD, 55EB,0002,AA15,FFFD, 7A26,0002,85DA,FFFD,
                        9F6A,0002,6096,FFFD, C5B7,0002,3A49,FFFD, ED0D,0002,12F3,FFFD, 0C6C,0003,F394,FFFC,
                        35D4,0003,CA2C,FFFC, 6045,0003,9FBB,FFFC, 8BBF,0003,7441,FFFC, B842,0003,47BE,FFFC,
                        E5CE,0003,1A32,FFFC, 0B63,0004,F49D,FFFB, 3B01,0004,C4FF,FFFB, 6BA8,0004,9458,FFFB,
                        9D58,0004,62A8,FFFB, D011,0004,2FEF,FFFB, 03D3,0004,FC2D,FFFB, 2F9E,0005,D062,FFFA,
                        6572,0005,9A8E,FFFA, 9C4F,0005,63B1,FFFA, D435,0005,2BCB,FFFA, 0424,0006,FBDC,FFF9,
                        3E1C,0006,C1E4,FFF9, 791D,0006,86E3,FFF9, B527,0006,4AD9,FFF9, F23A,0006,0DC6,FFF9,
                        2756,0007,D8AA,FFF8, 667B,0007,9985,FFF8, A6A9,0007,5957,FFF8, E7E0,0007,1820,FFF8,
                        2120,0008,DEE0,FFF7, 6469,0008,9B97,FFF7, A8BB,0008,5745,FFF7, EE16,0008,11EA,FFF7,
                        2B7A,0009,D486,FFF6, 72E7,0009,8D19,FFF6, BB5D,0009,44A3,FFF6, 04DC,0009,FB24,FFF6,
                        4664,000A,B99C,FFF5, 91F5,000A,6E0B,FFF5, DE8F,000A,2171,FFF5, 2332,000B,DCCE,FFF4,
                        71DE,000B,8E22,FFF4, C193,000B,3E6D,FFF4, 0951,000C,F6AF,FFF3, 5B18,000C,A4E8,FFF3,
                        ADE8,000C,5218,FFF3, 01C1,000C,FE3F,FFF3, 4DA3,000D,B25D,FFF2, A38E,000D,5C72,FFF2,
                        FA82,000D,057E,FFF2, 497F,000E,B681,FFF1, A285,000E,5D7B,FFF1, FC94,000E,036C,FFF1,
                        4EAC,000F,B154,FFF0, AACD,000F,5533,FFF0, 07F7,000F,F809,FFF0, 5D2A,0010,A2D6,FFEF,
                        BC66,0010,439A,FFEF, 13AB,0011,EC55,FFEE, 74F9,0011,8B07,FFEE
}
}


;;; $8687..884C: Room shaking ;;;
{
;;; $8687: Handle room shaking ;;;
{
; Enemy projectile shaking is handled by $86:8427
$A0:8687 8B          PHB
$A0:8688 F4 00 A0    PEA $A000              ;\
$A0:868B AB          PLB                    ;} DB = $A0
$A0:868C AB          PLB                    ;/
$A0:868D C2 30       REP #$30
$A0:868F AD 40 18    LDA $1840  [$7E:1840]  ;\
$A0:8692 F0 79       BEQ $79    [$870D]     ;} If [earthquake timer] = 0: go to BRANCH_RETURN
$A0:8694 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A0:8697 D0 74       BNE $74    [$870D]     ;} If time is frozen: go to BRANCH_RETURN
$A0:8699 AD 3E 18    LDA $183E  [$7E:183E]  ;\
$A0:869C C9 24 00    CMP #$0024             ;} If [earthquake type] >= 24h: go to BRANCH_RETURN
$A0:869F 10 6C       BPL $6C    [$870D]     ;/
$A0:86A1 0A          ASL A                  ;\
$A0:86A2 0A          ASL A                  ;|
$A0:86A3 0A          ASL A                  ;} X = [earthquake type] * 8
$A0:86A4 AA          TAX                    ;/
$A0:86A5 AD 40 18    LDA $1840  [$7E:1840]  ;\
$A0:86A8 89 02 00    BIT #$0002             ;} If [earthquake timer] / 2 % 2 != 0:
$A0:86AB F0 32       BEQ $32    [$86DF]     ;/
$A0:86AD BD 2D 87    LDA $872D,x[$A0:8845]  ;\
$A0:86B0 49 FF FF    EOR #$FFFF             ;|
$A0:86B3 1A          INC A                  ;|
$A0:86B4 18          CLC                    ;} BG1 X scroll -= [$872D + [X]]
$A0:86B5 65 B1       ADC $B1    [$7E:00B1]  ;|
$A0:86B7 85 B1       STA $B1    [$7E:00B1]  ;/
$A0:86B9 BD 2F 87    LDA $872F,x[$A0:8847]  ;\
$A0:86BC 49 FF FF    EOR #$FFFF             ;|
$A0:86BF 1A          INC A                  ;|
$A0:86C0 18          CLC                    ;} BG1 Y scroll -= [$872D + [X] + 2]
$A0:86C1 65 B3       ADC $B3    [$7E:00B3]  ;|
$A0:86C3 85 B3       STA $B3    [$7E:00B3]  ;/
$A0:86C5 BD 31 87    LDA $8731,x[$A0:8849]  ;\
$A0:86C8 49 FF FF    EOR #$FFFF             ;|
$A0:86CB 1A          INC A                  ;|
$A0:86CC 18          CLC                    ;} BG2 X scroll -= [$872D + [X] + 4]
$A0:86CD 65 B5       ADC $B5    [$7E:00B5]  ;|
$A0:86CF 85 B5       STA $B5    [$7E:00B5]  ;/
$A0:86D1 BD 33 87    LDA $8733,x[$A0:884B]  ;\
$A0:86D4 49 FF FF    EOR #$FFFF             ;|
$A0:86D7 1A          INC A                  ;|
$A0:86D8 18          CLC                    ;} BG2 Y scroll -= [$872D + [X] + 6]
$A0:86D9 65 B7       ADC $B7    [$7E:00B7]  ;|
$A0:86DB 85 B7       STA $B7    [$7E:00B7]  ;/
$A0:86DD 80 20       BRA $20    [$86FF]

$A0:86DF A5 B1       LDA $B1    [$7E:00B1]  ;\ Else ([earthquake timer] / 2 % 2 = 0):
$A0:86E1 18          CLC                    ;|
$A0:86E2 7D 2D 87    ADC $872D,x[$A0:8845]  ;} BG1 X scroll += [$872D + [X]]
$A0:86E5 85 B1       STA $B1    [$7E:00B1]  ;/
$A0:86E7 A5 B3       LDA $B3    [$7E:00B3]  ;\
$A0:86E9 18          CLC                    ;|
$A0:86EA 7D 2F 87    ADC $872F,x[$A0:8847]  ;} BG1 Y scroll += [$872D + [X] + 2]
$A0:86ED 85 B3       STA $B3    [$7E:00B3]  ;/
$A0:86EF A5 B5       LDA $B5    [$7E:00B5]  ;\
$A0:86F1 18          CLC                    ;|
$A0:86F2 7D 31 87    ADC $8731,x[$A0:8849]  ;} BG2 X scroll += [$872D + [X] + 4]
$A0:86F5 85 B5       STA $B5    [$7E:00B5]  ;/
$A0:86F7 A5 B7       LDA $B7    [$7E:00B7]  ;\
$A0:86F9 18          CLC                    ;|
$A0:86FA 7D 33 87    ADC $8733,x[$A0:884B]  ;} BG2 Y scroll += [$872D + [X] + 6]
$A0:86FD 85 B7       STA $B7    [$7E:00B7]  ;/

$A0:86FF CE 40 18    DEC $1840  [$7E:1840]  ; Decrement earthquake timer
$A0:8702 AD 3E 18    LDA $183E  [$7E:183E]  ;\
$A0:8705 C9 12 00    CMP #$0012             ;} If [earthquake type] >= 12h:
$A0:8708 30 03       BMI $03    [$870D]     ;/
$A0:870A 20 12 87    JSR $8712  [$A0:8712]  ; Set all active enemies to shake horizontally for two frames

; BRANCH_RETURN
$A0:870D EE 42 18    INC $1842  [$7E:1842]  ; Increment $1842 (never read)
$A0:8710 AB          PLB
$A0:8711 6B          RTL
}


;;; $8712: Set all active enemies to shake horizontally for two frames ;;;
{
$A0:8712 5A          PHY
$A0:8713 DA          PHX
$A0:8714 A0 00 00    LDY #$0000             ; Y = 0 (active enemy indices index)

; LOOP
$A0:8717 B9 AC 17    LDA $17AC,y[$7E:17AC]  ;\
$A0:871A C9 FF FF    CMP #$FFFF             ;} If [active enemy index] != FFFFh:
$A0:871D F0 0B       BEQ $0B    [$872A]     ;/
$A0:871F AA          TAX                    ; X = [active enemy index] (enemy index)
$A0:8720 A9 02 00    LDA #$0002             ;\
$A0:8723 9D A2 0F    STA $0FA2,x[$7E:0FA2]  ;} Enemy shake timer = 2
$A0:8726 C8          INY                    ;\
$A0:8727 C8          INY                    ;} Y += 2
$A0:8728 80 ED       BRA $ED    [$8717]     ; Go to LOOP

$A0:872A FA          PLX
$A0:872B 7A          PLY
$A0:872C 60          RTS
}


;;; $872D: BG shake displacements ;;;
{
; Enemy projectile shaking displacements are at $86:846B

;                       /----horizontal---\  /-----vertical----\  /-----diagonal----\
;                       BG1X BG1Y BG2X BG2Y
$A0:872D             dw 0001,0000,0000,0000, 0000,0001,0000,0000, 0001,0001,0000,0000, ;\
                        0002,0000,0000,0000, 0000,0002,0000,0000, 0002,0002,0000,0000, ;} BG1 only
                        0003,0000,0000,0000, 0000,0003,0000,0000, 0003,0003,0000,0000, ;/
                        0001,0000,0001,0000, 0000,0001,0000,0001, 0001,0001,0001,0001, ;\
                        0002,0000,0002,0000, 0000,0002,0000,0002, 0002,0002,0002,0002, ;} BG1 and BG2
                        0003,0000,0003,0000, 0000,0003,0000,0003, 0003,0003,0003,0003, ;/
                        0001,0000,0001,0000, 0000,0001,0000,0001, 0001,0001,0001,0001, ;\
                        0002,0000,0002,0000, 0000,0002,0000,0002, 0002,0002,0002,0002, ;} BG1 and BG2 and enemies
                        0003,0000,0003,0000, 0000,0003,0000,0003, 0003,0003,0003,0003, ;/
                        0000,0000,0001,0000, 0000,0000,0000,0001, 0000,0000,0001,0001, ;\
                        0000,0000,0002,0000, 0000,0000,0000,0002, 0000,0000,0002,0002, ;} BG2 only and enemies
                        0000,0000,0003,0000, 0000,0000,0000,0003, 0000,0000,0003,0003  ;/
}
}


;;; $884D: Draw Samus, projectiles, enemies and enemy projectiles ;;;
{
$A0:884D 8B          PHB
$A0:884E F4 00 A0    PEA $A000              ;\
$A0:8851 AB          PLB                    ;} DB = $A0
$A0:8852 AB          PLB                    ;/
$A0:8853 C2 30       REP #$30
$A0:8855 22 32 BD B4 JSL $B4BD32[$B4:BD32]  ; Draw sprite objects
$A0:8859 22 4D 83 93 JSL $93834D[$93:834D]  ; Draw bombs and projectile explosions
$A0:885D 22 90 83 86 JSL $868390[$86:8390]  ; Draw high priority enemy projectiles
$A0:8861 9C 32 0E    STZ $0E32  [$7E:0E32]  ; Enemy layer = 0

; LOOP_MAIN
$A0:8864 AD 32 0E    LDA $0E32  [$7E:0E32]  ;\
$A0:8867 C9 08 00    CMP #$0008             ;} If [enemy layer] = 8: go to BRANCH_FINISH
$A0:886A F0 50       BEQ $50    [$88BC]     ;/
$A0:886C C9 03 00    CMP #$0003             ;\
$A0:886F D0 06       BNE $06    [$8877]     ;} If [enemy layer] = 3:
$A0:8871 22 35 EB 90 JSL $90EB35[$90:EB35]  ; Draw Samus and projectiles
$A0:8875 80 09       BRA $09    [$8880]

$A0:8877 C9 06 00    CMP #$0006             ;\ Else ([enemy layer] != 3):
$A0:887A D0 04       BNE $04    [$8880]     ;} If [enemy layer] = 6:
$A0:887C 22 B2 83 86 JSL $8683B2[$86:83B2]  ; Draw low priority enemy projectiles

$A0:8880 AD 32 0E    LDA $0E32  [$7E:0E32]  ;\
$A0:8883 0A          ASL A                  ;} Y = [enemy layer] * 2
$A0:8884 A8          TAY                    ;/
$A0:8885 B9 68 0F    LDA $0F68,y[$7E:0F68]  ; A = [enemy drawing queue size]
$A0:8888 F0 2D       BEQ $2D    [$88B7]     ; If [enemy drawing queue size] = 0: go to BRANCH_NEXT
$A0:888A 8D 36 0E    STA $0E36  [$7E:0E36]  ; Enemy drawing queue size backup = [enemy drawing queue size]
$A0:888D B9 33 B1    LDA $B133,y[$A0:B137]  ;\
$A0:8890 8D 3A 0E    STA $0E3A  [$7E:0E3A]  ;} Enemy drawing queue address = [$B133 + [enemy layer] * 2]
$A0:8893 A9 00 00    LDA #$0000             ; A = 0
$A0:8896 99 68 0F    STA $0F68,y[$7E:0F6C]  ; Enemy drawing queue size = 0

; LOOP_OAM
$A0:8899 8D 38 0E    STA $0E38  [$7E:0E38]  ; Enemy drawing queue index = [A]
$A0:889C 18          CLC                    ;\
$A0:889D 6D 3A 0E    ADC $0E3A  [$7E:0E3A]  ;} X = [enemy drawing queue address] + [enemy drawing queue index]
$A0:88A0 AA          TAX                    ;/
$A0:88A1 BD 00 00    LDA $0000,x[$7E:0EA6]  ;\
$A0:88A4 9E 00 00    STZ $0000,x[$7E:0EA6]  ;} Enemy index = [[X]], [X] = 0
$A0:88A7 8D 54 0E    STA $0E54  [$7E:0E54]  ;/
$A0:88AA 20 4A 94    JSR $944A  [$A0:944A]  ; Write enemy OAM
$A0:88AD AD 38 0E    LDA $0E38  [$7E:0E38]  ;\
$A0:88B0 1A          INC A                  ;} A = [enemy drawing queue index] + 2
$A0:88B1 1A          INC A                  ;/
$A0:88B2 CD 36 0E    CMP $0E36  [$7E:0E36]  ;\
$A0:88B5 D0 E2       BNE $E2    [$8899]     ;} If [A] != [enemy drawing queue size]: go to LOOP_OAM

; BRANCH_NEXT
$A0:88B7 EE 32 0E    INC $0E32  [$7E:0E32]  ; Increment enemy layer
$A0:88BA 80 A8       BRA $A8    [$8864]     ; Go to LOOP_MAIN

; BRANCH_FINISH
$A0:88BC 8B          PHB
$A0:88BD 22 C4 88 A0 JSL $A088C4[$A0:88C4]  ; Execute enemy graphics drawn hook
$A0:88C1 AB          PLB
$A0:88C2 80 0A       BRA $0A    [$88CE]     ; Return

$A0:88C4 AD 8E 17    LDA $178E  [$7E:178E]
$A0:88C7 EB          XBA
$A0:88C8 48          PHA
$A0:88C9 AB          PLB
$A0:88CA AB          PLB
$A0:88CB DC 8C 17    JML [$178C][$A0:804C]

$A0:88CE AB          PLB
$A0:88CF 6B          RTL
}


;;; $88D0..8EB5: Enemy loading ;;;
{
;;; $88D0: Record enemy spawn data ;;;
{
;; Parameters:
;;     Y: Enemy index

; Used almost exclusively by debug enemy spawner. Rinka uses X/Y position
$A0:88D0 DA          PHX
$A0:88D1 5A          PHY
$A0:88D2 BB          TYX
$A0:88D3 BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:88D6 9F 1E 70 7E STA $7E701E,x[$7E:701E];} $7E:701E + [Y] = [enemy ID]
$A0:88DA BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A0:88DD 9F 20 70 7E STA $7E7020,x[$7E:7020];} $7E:7020 + [Y] = [enemy X position]
$A0:88E1 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A0:88E4 9F 22 70 7E STA $7E7022,x[$7E:7022];} $7E:7022 + [Y] = [enemy Y position]
$A0:88E8 BD 92 0F    LDA $0F92,x[$7E:0F92]  ;\
$A0:88EB 9F 24 70 7E STA $7E7024,x[$7E:7024];} $7E:7024 + [Y] = [enemy initialisation parameter]
$A0:88EF BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:88F2 9F 26 70 7E STA $7E7026,x[$7E:7026];} $7E:7026 + [Y] = [enemy properties]
$A0:88F6 BD 88 0F    LDA $0F88,x[$7E:0F88]  ;\
$A0:88F9 9F 28 70 7E STA $7E7028,x[$7E:7028];} $7E:7028 + [Y] = [enemy extra properties]
$A0:88FD BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A0:8900 9F 2A 70 7E STA $7E702A,x[$7E:702A];} $7E:702A + [Y] = [enemy parameter 1]
$A0:8904 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A0:8907 9F 2C 70 7E STA $7E702C,x[$7E:702C];} $7E:702C + [Y] = [enemy parameter 2]
$A0:890B 64 12       STZ $12    [$7E:0012]  ;\
$A0:890D 64 14       STZ $14    [$7E:0014]  ;|
$A0:890F 64 16       STZ $16    [$7E:0016]  ;|
$A0:8911 64 18       STZ $18    [$7E:0018]  ;|
$A0:8913 64 1A       STZ $1A    [$7E:001A]  ;|
$A0:8915 64 1C       STZ $1C    [$7E:001C]  ;|
$A0:8917 DA          PHX                    ;|
$A0:8918 BD 78 0F    LDA $0F78,x[$7E:0F78]  ;|
$A0:891B AA          TAX                    ;|
$A0:891C BF 3E 00 A0 LDA $A0003E,x[$A0:E27D];|
$A0:8920 F0 25       BEQ $25    [$8947]     ;|
$A0:8922 AA          TAX                    ;|
$A0:8923 BF 00 00 B4 LDA $B40000,x[$B4:E0D1];|
$A0:8927 85 12       STA $12    [$7E:0012]  ;|
$A0:8929 BF 02 00 B4 LDA $B40002,x[$B4:E0D3];|
$A0:892D 85 14       STA $14    [$7E:0014]  ;|
$A0:892F BF 04 00 B4 LDA $B40004,x[$B4:E0D5];|
$A0:8933 85 16       STA $16    [$7E:0016]  ;|
$A0:8935 BF 06 00 B4 LDA $B40006,x[$B4:E0D7];|
$A0:8939 85 18       STA $18    [$7E:0018]  ;} Copy Ch bytes from (enemy name) to $7E:702E + [Y]
$A0:893B BF 08 00 B4 LDA $B40008,x[$B4:E0D9];|
$A0:893F 85 1A       STA $1A    [$7E:001A]  ;|
$A0:8941 BF 0C 00 B4 LDA $B4000C,x[$B4:E0DD];|
$A0:8945 85 1C       STA $1C    [$7E:001C]  ;|
                                            ;|
$A0:8947 FA          PLX                    ;|
$A0:8948 A5 12       LDA $12    [$7E:0012]  ;|
$A0:894A 9F 2E 70 7E STA $7E702E,x[$7E:702E];|
$A0:894E A5 14       LDA $14    [$7E:0014]  ;|
$A0:8950 9F 30 70 7E STA $7E7030,x[$7E:7030];|
$A0:8954 A5 16       LDA $16    [$7E:0016]  ;|
$A0:8956 9F 32 70 7E STA $7E7032,x[$7E:7032];|
$A0:895A A5 18       LDA $18    [$7E:0018]  ;|
$A0:895C 9F 34 70 7E STA $7E7034,x[$7E:7034];|
$A0:8960 A5 1A       LDA $1A    [$7E:001A]  ;|
$A0:8962 9F 36 70 7E STA $7E7036,x[$7E:7036];|
$A0:8966 A5 1C       LDA $1C    [$7E:001C]  ;|
$A0:8968 9F 38 70 7E STA $7E7038,x[$7E:7038];/
$A0:896C 7A          PLY
$A0:896D FA          PLX
$A0:896E 6B          RTL
}


;;; $896F: Debug. Load enemy set data ;;;
{
; This enemy set data is never used, not even by the enemy debugger. This routine serves no purpose
$A0:896F A9 00 00    LDA #$0000             ;\
$A0:8972 A2 00 00    LDX #$0000             ;|
$A0:8975 A0 A0 00    LDY #$00A0             ;|
                                            ;|
$A0:8978 9F 52 D5 7E STA $7ED552,x[$7E:D552];|
$A0:897C E8          INX                    ;} $7E:D552..F1 = 0
$A0:897D E8          INX                    ;|
$A0:897E 88          DEY                    ;|
$A0:897F 88          DEY                    ;|
$A0:8980 D0 F6       BNE $F6    [$8978]     ;/
$A0:8982 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$A0:8985 38          SEC                    ;|
$A0:8986 E9 07 00    SBC #$0007             ;} X = [enemies allowed pointer] - 7
$A0:8989 AA          TAX                    ;/
$A0:898A BF 00 00 B4 LDA $B40000,x[$B4:9211];\
$A0:898E 8F 52 D5 7E STA $7ED552[$7E:D552]  ;|
$A0:8992 BF 02 00 B4 LDA $B40002,x[$B4:9213];|
$A0:8996 8F 54 D5 7E STA $7ED554[$7E:D554]  ;|
$A0:899A BF 04 00 B4 LDA $B40004,x[$B4:9215];} Enemy set name = 8 bytes from $B4:0000 + [X] (harmless one byte overflow)
$A0:899E 8F 56 D5 7E STA $7ED556[$7E:D556]  ;|
$A0:89A2 BF 06 00 B4 LDA $B40006,x[$B4:9217];|
$A0:89A6 8F 58 D5 7E STA $7ED558[$7E:D558]  ;/
$A0:89AA A0 07 00    LDY #$0007             ; Y = 7 (working enemy set data index)
$A0:89AD AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$A0:89B0 AA          TAX                    ;} X = [enemies set pointer] (enemies set entry)

; LOOP
$A0:89B1 BF 00 00 B4 LDA $B40000,x[$B4:9218]; A = [$B4:0000 + [X]] (enemy ID)
$A0:89B5 C9 FF FF    CMP #$FFFF             ;\
$A0:89B8 F0 63       BEQ $63    [$8A1D]     ;} If enemy ID = FFFFh: return
$A0:89BA DA          PHX
$A0:89BB AA          TAX                    ;\
$A0:89BC BF 3E 00 A0 LDA $A0003E,x[$A0:E27D];} A = [$A0:003E + [A]] (enemy set entry name)
$A0:89C0 D0 03       BNE $03    [$89C5]     ; If enemy set entry name = 0:
$A0:89C2 A9 89 DD    LDA #$DD89             ; Enemy set entry name = $DD89 ("NODATA    ")

$A0:89C5 AA          TAX                    ;\
$A0:89C6 BF 00 00 B4 LDA $B40000,x[$B4:DD89];|
$A0:89CA 85 12       STA $12    [$7E:0012]  ;|
$A0:89CC BF 02 00 B4 LDA $B40002,x[$B4:DD8B];|
$A0:89D0 85 14       STA $14    [$7E:0014]  ;|
$A0:89D2 BF 04 00 B4 LDA $B40004,x[$B4:DD8D];|
$A0:89D6 85 16       STA $16    [$7E:0016]  ;|
$A0:89D8 BF 06 00 B4 LDA $B40006,x[$B4:DD8F];|
$A0:89DC 85 18       STA $18    [$7E:0018]  ;|
$A0:89DE BF 08 00 B4 LDA $B40008,x[$B4:DD91];|
$A0:89E2 85 1A       STA $1A    [$7E:001A]  ;|
$A0:89E4 BB          TYX                    ;} Enemy name = [enemy set entry name] (Ah bytes)
$A0:89E5 A5 12       LDA $12    [$7E:0012]  ;|
$A0:89E7 9F 52 D5 7E STA $7ED552,x[$7E:D559];|
$A0:89EB A5 14       LDA $14    [$7E:0014]  ;|
$A0:89ED 9F 54 D5 7E STA $7ED554,x[$7E:D55B];|
$A0:89F1 A5 16       LDA $16    [$7E:0016]  ;|
$A0:89F3 9F 56 D5 7E STA $7ED556,x[$7E:D55D];|
$A0:89F7 A5 18       LDA $18    [$7E:0018]  ;|
$A0:89F9 9F 58 D5 7E STA $7ED558,x[$7E:D55F];|
$A0:89FD A5 1A       LDA $1A    [$7E:001A]  ;|
$A0:89FF 9F 5A D5 7E STA $7ED55A,x[$7E:D561];/
$A0:8A03 FA          PLX
$A0:8A04 DA          PHX
$A0:8A05 BF 02 00 B4 LDA $B40002,x[$B4:921A];\
$A0:8A09 BB          TYX                    ;} Enemy palette index = [enemy set entry palette index]
$A0:8A0A 9F 5C D5 7E STA $7ED55C,x[$7E:D563];/
$A0:8A0E FA          PLX
$A0:8A0F 98          TYA                    ;\
$A0:8A10 18          CLC                    ;|
$A0:8A11 69 0C 00    ADC #$000C             ;} Y += Ch (next working enemy set entry)
$A0:8A14 A8          TAY                    ;/
$A0:8A15 8A          TXA                    ;\
$A0:8A16 18          CLC                    ;|
$A0:8A17 69 04 00    ADC #$0004             ;} X += 4 (next enemies set entry)
$A0:8A1A AA          TAX                    ;/
$A0:8A1B 80 94       BRA $94    [$89B1]     ; Go to LOOP

$A0:8A1D 6B          RTL
}


;;; $8A1E: Load enemies (load and process enemy set, clear enemy data, load enemy tile data) ;;;
{
; Called when loading the game, and during door transition
; This routine loads enemy tile data, which during door transition has already loaded by $82:DFD1, making the call to $8C6C a fairly hefty waste of time
; Aside from loading tile data, this routine also loads palette data, and the enemy GFX data needed for respawn
$A0:8A1E 08          PHP
$A0:8A1F 8B          PHB
$A0:8A20 F4 00 A0    PEA $A000              ;\
$A0:8A23 AB          PLB                    ;} DB = $A0
$A0:8A24 AB          PLB                    ;/
$A0:8A25 C2 30       REP #$30
$A0:8A27 22 6F 89 A0 JSL $A0896F[$A0:896F]  ; Debug. Load enemy set data
$A0:8A2B 9C 5E 18    STZ $185E  [$7E:185E]  ; Enemy time is frozen flag = 0
$A0:8A2E 9C 9C 17    STZ $179C  [$7E:179C]  ; Boss number = 0
$A0:8A31 A9 A0 00    LDA #$00A0             ;\
$A0:8A34 8D 8E 17    STA $178E  [$7E:178E]  ;|
$A0:8A37 A9 4C 80    LDA #$804C             ;} Enemy graphics drawn hook = RTL
$A0:8A3A 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A0:8A3D A9 A0 00    LDA #$00A0             ;\
$A0:8A40 8D 92 17    STA $1792  [$7E:1792]  ;|
$A0:8A43 A9 4C 80    LDA #$804C             ;} $1790 = RTL (never read)
$A0:8A46 8D 90 17    STA $1790  [$7E:1790]  ;/
$A0:8A49 A9 00 08    LDA #$0800             ;\
$A0:8A4C 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 800h
$A0:8A4F 9C 9E 17    STZ $179E  [$7E:179E]  ; $179E = 0 (never read)
$A0:8A52 9C A0 17    STZ $17A0  [$7E:17A0]  ; $17A0 = 0 (never read)
$A0:8A55 9C 9C 17    STZ $179C  [$7E:179C]  ; Boss number = 0 (again)
$A0:8A58 22 6D 8A A0 JSL $A08A6D[$A0:8A6D]  ; Clear enemy data and process enemy set
$A0:8A5C 22 6C 8C A0 JSL $A08C6C[$A0:8C6C]  ; Load enemy tile data
$A0:8A60 9C 7C 0E    STZ $0E7C  [$7E:0E7C]  ; Enemy tiles VRAM update source address = 0
$A0:8A63 9C AE 18    STZ $18AE  [$7E:18AE]  ; Enable Samus / projectile interaction
$A0:8A66 22 97 BD B4 JSL $B4BD97[$B4:BD97]  ; Clear sprite objects
$A0:8A6A AB          PLB
$A0:8A6B 28          PLP
$A0:8A6C 6B          RTL
}


;;; $8A6D: Clear enemy data and process enemy set ;;;
{
$A0:8A6D 08          PHP
$A0:8A6E 8B          PHB
$A0:8A6F F4 00 A0    PEA $A000              ;\
$A0:8A72 AB          PLB                    ;} DB = $A0
$A0:8A73 AB          PLB                    ;/
$A0:8A74 C2 30       REP #$30
$A0:8A76 A9 00 00    LDA #$0000             ;\
$A0:8A79 A0 00 08    LDY #$0800             ;|
$A0:8A7C A2 00 00    LDX #$0000             ;|
                                            ;|
$A0:8A7F 9F 78 0F 00 STA $000F78,x[$7E:0F78];|
$A0:8A83 E8          INX                    ;} Clear enemy data
$A0:8A84 88          DEY                    ;|
$A0:8A85 E8          INX                    ;|
$A0:8A86 88          DEY                    ;|
$A0:8A87 D0 F6       BNE $F6    [$8A7F]     ;/
$A0:8A89 AE CF 07    LDX $07CF  [$7E:07CF]  ;\
$A0:8A8C BF 00 00 A1 LDA $A10000,x[$A1:E88A];|
$A0:8A90 C9 FF FF    CMP #$FFFF             ;} If no enemy population data:
$A0:8A93 D0 03       BNE $03    [$8A98]     ;/
$A0:8A95 4C 9B 8A    JMP $8A9B  [$A0:8A9B]  ; Return

$A0:8A98 20 64 8D    JSR $8D64  [$A0:8D64]  ; Process enemy set

$A0:8A9B AB          PLB
$A0:8A9C 28          PLP
$A0:8A9D 6B          RTL
}


;;; $8A9E: Initialise enemies ;;;
{
$A0:8A9E 08          PHP
$A0:8A9F 8B          PHB
$A0:8AA0 A0 00 14    LDY #$1400             ;\
$A0:8AA3 A2 00 00    LDX #$0000             ;|
$A0:8AA6 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:8AA9 9F 00 70 7E STA $7E7000,x[$7E:7000];} $7E:7000..97FF = 0 (mostly extra enemy RAM)
$A0:8AAD E8          INX                    ;|
$A0:8AAE E8          INX                    ;|
$A0:8AAF 88          DEY                    ;|
$A0:8AB0 D0 F7       BNE $F7    [$8AA9]     ;/
$A0:8AB2 F4 00 A0    PEA $A000              ;\
$A0:8AB5 AB          PLB                    ;} DB = $A0
$A0:8AB6 AB          PLB                    ;/
$A0:8AB7 C2 30       REP #$30
$A0:8AB9 9C 4E 0E    STZ $0E4E  [$7E:0E4E]  ; Number of enemies = 0
$A0:8ABC 9C 50 0E    STZ $0E50  [$7E:0E50]  ; Number of enemies killed = 0
$A0:8ABF 9C 3C 18    STZ $183C  [$7E:183C]  ; Disable global off-screen enemy processing
$A0:8AC2 A2 1E 01    LDX #$011E             ;\
$A0:8AC5 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:8AC8 9F 80 F3 7E STA $7EF380,x[$7E:F49E];} $7E:F380..F49F = 0 (extra enemy projectile RAM)
$A0:8ACC CA          DEX                    ;|
$A0:8ACD CA          DEX                    ;|
$A0:8ACE 10 F8       BPL $F8    [$8AC8]     ;/
$A0:8AD0 A2 22 00    LDX #$0022             ;\
$A0:8AD3 A9 FF FF    LDA #$FFFF             ;|
                                            ;|
$A0:8AD6 9F 10 F4 7E STA $7EF410,x[$7E:F432];} $7E:F410..33 = FFFFh (enemy projectile killed enemy indices, for respawning enemies)
$A0:8ADA CA          DEX                    ;|
$A0:8ADB CA          DEX                    ;|
$A0:8ADC 10 F8       BPL $F8    [$8AD6]     ;/
$A0:8ADE AE CF 07    LDX $07CF  [$7E:07CF]  ; X = [enemy population pointer] (enemy population entry address)
$A0:8AE1 BF 00 00 A1 LDA $A10000,x[$A1:E88A];\
$A0:8AE5 C9 FF FF    CMP #$FFFF             ;} If [$A1:0000 + [X]] = FFFFh:
$A0:8AE8 D0 03       BNE $03    [$8AED]     ;/
$A0:8AEA 4C E6 8B    JMP $8BE6  [$A0:8BE6]  ; Return

$A0:8AED 9C 48 0E    STZ $0E48  [$7E:0E48]  ; $0E48 = 0
$A0:8AF0 A0 00 00    LDY #$0000             ; Y = 0 (enemy index)

; LOOP
$A0:8AF3 20 F3 8B    JSR $8BF3  [$A0:8BF3]  ; Load enemy GFX indices
$A0:8AF6 DA          PHX
$A0:8AF7 BF 00 00 A1 LDA $A10000,x[$A1:E88A]; A = [$A1:0000 + [X]] (enemy ID)
$A0:8AFB AA          TAX
$A0:8AFC BD 08 00    LDA $0008,x[$A0:E247]  ;\
$A0:8AFF 99 82 0F    STA $0F82,y[$7E:0F82]  ;} Enemy width = [[A] + 8]
$A0:8B02 BD 0A 00    LDA $000A,x[$A0:E249]  ;\
$A0:8B05 99 84 0F    STA $0F84,y[$7E:0F84]  ;} Enemy height = [[A] + Ah]
$A0:8B08 BD 04 00    LDA $0004,x[$A0:E243]  ;\
$A0:8B0B 99 8C 0F    STA $0F8C,y[$7E:0F8C]  ;} Enemy health = [[A] + 4]
$A0:8B0E BD 39 00    LDA $0039,x[$A0:E278]  ;\
$A0:8B11 29 FF 00    AND #$00FF             ;} Enemy layer = [[A] + 39h] & FFh
$A0:8B14 99 9A 0F    STA $0F9A,y[$7E:0F9A]  ;/
$A0:8B17 BD 0C 00    LDA $000C,x[$A0:E24B]  ;\
$A0:8B1A 99 A6 0F    STA $0FA6,y[$7E:0FA6]  ;} Enemy bank = [[A] + Ch]
$A0:8B1D BD 10 00    LDA $0010,x[$A0:E24F]  ;\
$A0:8B20 F0 03       BEQ $03    [$8B25]     ;} If [[A] + 10h] != 0:
$A0:8B22 8D 9C 17    STA $179C  [$7E:179C]  ; Boss ID = [[A] + 10h]

$A0:8B25 FA          PLX
$A0:8B26 BF 00 00 A1 LDA $A10000,x[$A1:E88A];\
$A0:8B2A 99 78 0F    STA $0F78,y[$7E:0F78]  ;} Enemy ID = [$A1:0000 + [X]]
$A0:8B2D BF 02 00 A1 LDA $A10002,x[$A1:E88C];\
$A0:8B31 99 7A 0F    STA $0F7A,y[$7E:0F7A]  ;} Enemy X position = [$A1:0002 + [X]]
$A0:8B34 BF 04 00 A1 LDA $A10004,x[$A1:E88E];\
$A0:8B38 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;} Enemy Y position = [$A1:0004 + [X]]
$A0:8B3B BF 06 00 A1 LDA $A10006,x[$A1:E890];\
$A0:8B3F 99 92 0F    STA $0F92,y[$7E:0F92]  ;} Enemy initialisation parameter = [$A1:0006 + [X]]
$A0:8B42 BF 08 00 A1 LDA $A10008,x[$A1:E892];\
$A0:8B46 99 86 0F    STA $0F86,y[$7E:0F86]  ;} Enemy properties = [$A1:0008 + [X]]
$A0:8B49 BF 0A 00 A1 LDA $A1000A,x[$A1:E894];\
$A0:8B4D 99 88 0F    STA $0F88,y[$7E:0F88]  ;} Enemy extra properties = [$A1:000A + [X]]
$A0:8B50 BF 0C 00 A1 LDA $A1000C,x[$A1:E896];\
$A0:8B54 99 B4 0F    STA $0FB4,y[$7E:0FB4]  ;} Enemy parameter 1 = [$A1:000C + [X]]
$A0:8B57 BF 0E 00 A1 LDA $A1000E,x[$A1:E898];\
$A0:8B5B 99 B6 0F    STA $0FB6,y[$7E:0FB6]  ;} Enemy parameter 2 = [$A1:000E + [X]]
$A0:8B5E A9 00 00    LDA #$0000             ;\
$A0:8B61 99 A4 0F    STA $0FA4,y[$7E:0FA4]  ;} Enemy frame counter = 0
$A0:8B64 99 90 0F    STA $0F90,y[$7E:0F90]  ; Enemy timer = 0
$A0:8B67 A9 01 00    LDA #$0001             ;\
$A0:8B6A 99 94 0F    STA $0F94,y[$7E:0F94]  ;} Enemy instruction timer = 0
$A0:8B6D A9 00 00    LDA #$0000             ;\
$A0:8B70 99 A4 0F    STA $0FA4,y[$7E:0FA4]  ;} Enemy frame counter = 0 (just to make sure >_>)
$A0:8B73 22 D0 88 A0 JSL $A088D0[$A0:88D0]  ; Record enemy spawn data
$A0:8B77 DA          PHX
$A0:8B78 5A          PHY
$A0:8B79 8C 54 0E    STY $0E54  [$7E:0E54]  ; Enemy index = [Y]
$A0:8B7C BE 78 0F    LDX $0F78,y[$7E:0F78]  ;\
$A0:8B7F BD 12 00    LDA $0012,x[$A0:E251]  ;|
$A0:8B82 8D 84 17    STA $1784  [$7E:1784]  ;} Enemy initialisation AI pointer = [(enemy ID) + Ch] << 16 | [(enemy ID) + 12h]
$A0:8B85 BD 0C 00    LDA $000C,x[$A0:E24B]  ;|
$A0:8B88 8D 86 17    STA $1786  [$7E:1786]  ;/
$A0:8B8B 8B          PHB
$A0:8B8C 22 E9 8B A0 JSL $A08BE9[$A0:8BE9]  ; Execute enemy initialisation AI
$A0:8B90 AB          PLB
$A0:8B91 7A          PLY
$A0:8B92 FA          PLX
$A0:8B93 A9 00 00    LDA #$0000             ;\
$A0:8B96 99 8E 0F    STA $0F8E,y[$7E:0F8E]  ;} Enemy spritemap pointer = 0
$A0:8B99 B9 86 0F    LDA $0F86,y[$7E:0F86]  ;\
$A0:8B9C 89 00 20    BIT #$2000             ;} If enemy doesn't process instructions: go to BRANCH_NO_INSTRUCTIONS
$A0:8B9F F0 16       BEQ $16    [$8BB7]     ;/
$A0:8BA1 DA          PHX
$A0:8BA2 5A          PHY
$A0:8BA3 A2 4D 80    LDX #$804D             ; Enemy spritemap pointer = $804D
$A0:8BA6 B9 88 0F    LDA $0F88,y[$7E:0F88]  ;\
$A0:8BA9 89 04 00    BIT #$0004             ;} If enemy uses extended spritemap format:
$A0:8BAC F0 03       BEQ $03    [$8BB1]     ;/
$A0:8BAE A2 4F 80    LDX #$804F             ; Enemy spritemap pointer = $804F

$A0:8BB1 8A          TXA
$A0:8BB2 99 8E 0F    STA $0F8E,y[$7E:0F8E]
$A0:8BB5 7A          PLY
$A0:8BB6 FA          PLX

; BRANCH_NO_INSTRUCTIONS
$A0:8BB7 98          TYA                    ;\
$A0:8BB8 18          CLC                    ;|
$A0:8BB9 69 40 00    ADC #$0040             ;} Y += 40h (next enemy index)
$A0:8BBC A8          TAY                    ;/
$A0:8BBD 8A          TXA                    ;\
$A0:8BBE 18          CLC                    ;|
$A0:8BBF 69 10 00    ADC #$0010             ;} X += 10h (next enemy population entry)
$A0:8BC2 AA          TAX                    ;/
$A0:8BC3 BF 00 00 A1 LDA $A10000,x[$A1:E89A];\
$A0:8BC7 C9 FF FF    CMP #$FFFF             ;} If [$A1:0000 + [X]] != FFFFh:
$A0:8BCA F0 03       BEQ $03    [$8BCF]     ;/
$A0:8BCC 4C F3 8A    JMP $8AF3  [$A0:8AF3]  ; Go to LOOP

$A0:8BCF 8C 4C 0E    STY $0E4C  [$7E:0E4C]  ; First unused enemy index = [Y]
$A0:8BD2 98          TYA                    ;\
$A0:8BD3 4A          LSR A                  ;|
$A0:8BD4 4A          LSR A                  ;|
$A0:8BD5 4A          LSR A                  ;|
$A0:8BD6 4A          LSR A                  ;} Number of enemies = [Y] / 40h
$A0:8BD7 4A          LSR A                  ;|
$A0:8BD8 4A          LSR A                  ;|
$A0:8BD9 8D 4E 0E    STA $0E4E  [$7E:0E4E]  ;/
$A0:8BDC BF 02 00 A1 LDA $A10002,x[$A1:E8AC];\
$A0:8BE0 29 FF 00    AND #$00FF             ;} Number of enemy deaths needed to clear room = [$A1:0002 + [X]]
$A0:8BE3 8D 52 0E    STA $0E52  [$7E:0E52]  ;/

$A0:8BE6 AB          PLB
$A0:8BE7 28          PLP
$A0:8BE8 6B          RTL                    ; Return

; Execute enemy initialisation AI
$A0:8BE9 B9 A6 0F    LDA $0FA6,y[$7E:0FA6]
$A0:8BEC EB          XBA
$A0:8BED 48          PHA
$A0:8BEE AB          PLB
$A0:8BEF AB          PLB
$A0:8BF0 DC 84 17    JML [$1784][$A6:F6C5]
}


;;; $8BF3: Load enemy GFX indices ;;;
{
;; Parameters:
;;     X: Enemy population index
;;     Y: Enemy data index
$A0:8BF3 DA          PHX
$A0:8BF4 5A          PHY
$A0:8BF5 86 12       STX $12    [$7E:0012]  ; $12 = [X]
$A0:8BF7 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$A0:8BF9 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$A0:8BFC 85 1C       STA $1C    [$7E:001C]  ;} $1C = [enemy set pointer] (enemy set entry address)
$A0:8BFE 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0

; LOOP
$A0:8C00 A6 12       LDX $12    [$7E:0012]  ;\
$A0:8C02 BF 00 00 A1 LDA $A10000,x[$A1:E88A];|
$A0:8C06 A6 1C       LDX $1C    [$7E:001C]  ;} If [$A1:0000 + [$12]] = [$B4:0000 + [$1C]]: go to BRANCH_FOUND
$A0:8C08 DF 00 00 B4 CMP $B40000,x[$B4:9218];|
$A0:8C0C F0 3E       BEQ $3E    [$8C4C]     ;/
$A0:8C0E BF 00 00 B4 LDA $B40000,x[$B4:925E];\
$A0:8C12 C9 FF FF    CMP #$FFFF             ;} If [$B4:0000 + [$1C]] = FFFFh: go to BRANCH_NOT_FOUND
$A0:8C15 F0 1C       BEQ $1C    [$8C33]     ;/
$A0:8C17 BF 00 00 B4 LDA $B40000,x[$B4:925E];\
$A0:8C1B AA          TAX                    ;|
$A0:8C1C BD 00 00    LDA $0000,x[$A0:E13F]  ;|
$A0:8C1F 4A          LSR A                  ;|
$A0:8C20 4A          LSR A                  ;|
$A0:8C21 4A          LSR A                  ;} $1E += [[$B4:0000 + [$1C]]] / 20h (number of enemy tiles)
$A0:8C22 4A          LSR A                  ;|
$A0:8C23 4A          LSR A                  ;|
$A0:8C24 18          CLC                    ;|
$A0:8C25 65 1E       ADC $1E    [$7E:001E]  ;|
$A0:8C27 85 1E       STA $1E    [$7E:001E]  ;/
$A0:8C29 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:8C2B 18          CLC                    ;|
$A0:8C2C 69 04 00    ADC #$0004             ;} $1C += 4 (next entry in enemy set)
$A0:8C2F 85 1C       STA $1C    [$7E:001C]  ;/
$A0:8C31 80 CD       BRA $CD    [$8C00]     ; Go to LOOP

; BRANCH_NOT_FOUND
$A0:8C33 A6 14       LDX $14    [$7E:0014]  ;\
$A0:8C35 9E 98 0F    STZ $0F98,x[$7E:1018]  ;|
$A0:8C38 A9 00 00    LDA #$0000             ;} Enemy [$14] index to graphics in VRAM = $7E:7006 + [$14] = 0
$A0:8C3B 9F 06 70 7E STA $7E7006,x[$7E:7086];/
$A0:8C3F A9 00 0A    LDA #$0A00             ;\
$A0:8C42 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy [$14] palette index = $7E:7008 + [$14] = A00h
$A0:8C45 9F 08 70 7E STA $7E7008,x[$7E:7088];/
$A0:8C49 7A          PLY
$A0:8C4A FA          PLX
$A0:8C4B 60          RTS                    ; Return

; BRANCH_FOUND
$A0:8C4C A6 1C       LDX $1C    [$7E:001C]  ;\
$A0:8C4E BF 02 00 B4 LDA $B40002,x[$B4:921A];|
$A0:8C52 29 0F 00    AND #$000F             ;|
$A0:8C55 EB          XBA                    ;|
$A0:8C56 0A          ASL A                  ;} Enemy [$14] palette index = $7E:7008 + [$14] = ([$B4:0002 + [$1C]] & Fh) * 200h
$A0:8C57 A6 14       LDX $14    [$7E:0014]  ;|
$A0:8C59 9D 96 0F    STA $0F96,x[$7E:0F96]  ;|
$A0:8C5C 9F 08 70 7E STA $7E7008,x[$7E:7008];/
$A0:8C60 A5 1E       LDA $1E    [$7E:001E]  ;\
$A0:8C62 9D 98 0F    STA $0F98,x[$7E:0F98]  ;} Enemy [$14] index to graphics in VRAM = $7E:7006 + [$14] = [$1E]
$A0:8C65 9F 06 70 7E STA $7E7006,x[$7E:7006];/
$A0:8C69 7A          PLY
$A0:8C6A FA          PLX
$A0:8C6B 60          RTS
}


;;; $8C6C: Load enemy tile data ;;;
{
; Loads enemy tile data to $7E:7000+, this is then transferred to VRAM when loading the game, but ignored and cleared during door transition >_>
; Note how this routine can't load enemy graphics from hirom banks due to setting the DB to the tile data bank (which kills short address accesses to WRAM)
; The $7E:7000..71FF part looks like it could be omitted from the VRAM update entirely...
$A0:8C6C C2 30       REP #$30
$A0:8C6E A2 FE 01    LDX #$01FE             ;\
                                            ;|
$A0:8C71 BF 00 EA 9A LDA $9AEA00,x[$9A:EBFE];|
$A0:8C75 9F 00 70 7E STA $7E7000,x[$7E:71FE];} $7E:7000..71FF = [$9A:EA00..EBFF] (last 10h non-X standard sprite tiles)
$A0:8C79 CA          DEX                    ;|
$A0:8C7A CA          DEX                    ;|
$A0:8C7B 10 F4       BPL $F4    [$8C71]     ;/
$A0:8C7D AD 7A 0E    LDA $0E7A  [$7E:0E7A]  ;\
$A0:8C80 F0 54       BEQ $54    [$8CD6]     ;} If [enemy loading data stack pointer] = 0: return
$A0:8C82 A2 00 00    LDX #$0000             ; X = 0 (enemy loading data index)
$A0:8C85 8B          PHB

; LOOP_ENEMIES
$A0:8C86 BD 5C 0E    LDA $0E5C,x[$7E:0E5C]  ;\
$A0:8C89 A8          TAY                    ;} Y = [enemy loading tile data pointer]
$A0:8C8A 18          CLC                    ;\
$A0:8C8B 7D 5A 0E    ADC $0E5A,x[$7E:0E5A]  ;} $12 = [enemy loading tile data pointer] + [enemy loading tile data size]
$A0:8C8E 85 12       STA $12    [$7E:0012]  ;/
$A0:8C90 BD 5D 0E    LDA $0E5D,x[$7E:0E5D]  ;\
$A0:8C93 48          PHA                    ;|
$A0:8C94 AB          PLB                    ;} DB = [enemy loading tile data bank]
$A0:8C95 AB          PLB                    ;/
$A0:8C96 8A          TXA                    ;\
$A0:8C97 18          CLC                    ;|
$A0:8C98 69 07 00    ADC #$0007             ;} (Enemy loading data index) += 7
$A0:8C9B 48          PHA                    ;/
$A0:8C9C BD 5F 0E    LDA $0E5F,x[$7E:0E5F]  ;\
$A0:8C9F AA          TAX                    ;} X = [enemy loading tile data offset]

; LOOP_TILES
$A0:8CA0 B9 00 00    LDA $0000,y[$B0:BA00]  ;\
$A0:8CA3 9F 00 70 7E STA $7E7000,x[$7E:7200];|
$A0:8CA7 B9 02 00    LDA $0002,y[$B0:BA02]  ;|
$A0:8CAA 9F 02 70 7E STA $7E7002,x[$7E:7202];|
$A0:8CAE B9 04 00    LDA $0004,y[$B0:BA04]  ;} Copy 8 bytes from [Y] to $7E:7000 + [X]
$A0:8CB1 9F 04 70 7E STA $7E7004,x[$7E:7204];|
$A0:8CB5 B9 06 00    LDA $0006,y[$B0:BA06]  ;|
$A0:8CB8 9F 06 70 7E STA $7E7006,x[$7E:7206];/
$A0:8CBC 8A          TXA                    ;\
$A0:8CBD 18          CLC                    ;|
$A0:8CBE 69 08 00    ADC #$0008             ;} X += 8
$A0:8CC1 AA          TAX                    ;/
$A0:8CC2 98          TYA                    ;\
$A0:8CC3 18          CLC                    ;|
$A0:8CC4 69 08 00    ADC #$0008             ;} Y += 8
$A0:8CC7 A8          TAY                    ;/
$A0:8CC8 C4 12       CPY $12    [$7E:0012]  ;\
$A0:8CCA D0 D4       BNE $D4    [$8CA0]     ;} If [Y] != [$12]: go to LOOP_TILES
$A0:8CCC FA          PLX                    ;\
$A0:8CCD EC 7A 0E    CPX $0E7A  [$7E:0E7A]  ;} If (enemy loading data index) != [enemy loading data stack pointer]: go to LOOP_ENEMIES
$A0:8CD0 D0 B4       BNE $B4    [$8C86]     ;/
$A0:8CD2 9C 7A 0E    STZ $0E7A  [$7E:0E7A]  ; Enemy loading data stack pointer = 0
$A0:8CD5 AB          PLB

$A0:8CD6 6B          RTL
}


;;; $8CD7: Transfer enemy tiles to VRAM and initialise enemies ;;;
{
; To be executed 6 times
$A0:8CD7 C2 30       REP #$30
$A0:8CD9 AD 7C 0E    LDA $0E7C  [$7E:0E7C]  ;\
$A0:8CDC D0 0C       BNE $0C    [$8CEA]     ;} If [enemy tiles VRAM update source address] = 0:
$A0:8CDE A9 00 70    LDA #$7000             ;\
$A0:8CE1 8D 7C 0E    STA $0E7C  [$7E:0E7C]  ;} Enemy tiles VRAM update source address = $7000
$A0:8CE4 A2 00 6C    LDX #$6C00             ;\
$A0:8CE7 8E 7E 0E    STX $0E7E  [$7E:0E7E]  ;} Enemy tiles VRAM update destination address = $6C00

$A0:8CEA C9 FF FF    CMP #$FFFF             ;\
$A0:8CED D0 01       BNE $01    [$8CF0]     ;} If [enemy tiles VRAM update source address] = FFFFh:
$A0:8CEF 6B          RTL                    ; Return

$A0:8CF0 C9 FE FF    CMP #$FFFE             ;\
$A0:8CF3 D0 0B       BNE $0B    [$8D00]     ;} If [enemy tiles VRAM update source address] = FFFEh:
$A0:8CF5 22 9E 8A A0 JSL $A08A9E[$A0:8A9E]  ; Initialise enemies
$A0:8CF9 A9 FF FF    LDA #$FFFF             ;\
$A0:8CFC 8D 7C 0E    STA $0E7C  [$7E:0E7C]  ;} Enemy tiles VRAM update source address = FFFFh
$A0:8CFF 6B          RTL                    ; Return

$A0:8D00 C9 00 98    CMP #$9800             ;\
$A0:8D03 F0 2E       BEQ $2E    [$8D33]     ;} If [enemy tiles VRAM update source address] != $9800:
$A0:8D05 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A0:8D08 A9 00 08    LDA #$0800             ;|
$A0:8D0B 95 D0       STA $D0,x  [$7E:00D7]  ;|
$A0:8D0D AD 7C 0E    LDA $0E7C  [$7E:0E7C]  ;|
$A0:8D10 95 D2       STA $D2,x  [$7E:00D9]  ;|
$A0:8D12 18          CLC                    ;|
$A0:8D13 69 00 08    ADC #$0800             ;|
$A0:8D16 8D 7C 0E    STA $0E7C  [$7E:0E7C]  ;|
$A0:8D19 A9 7E 00    LDA #$007E             ;} Queue transfer of 800h bytes from $7E:0000 + [enemy tiles VRAM update source address] to VRAM [enemy tiles VRAM update destination address]
$A0:8D1C 95 D4       STA $D4,x  [$7E:00DB]  ;} Enemy tiles VRAM update source address += 800h
$A0:8D1E AD 7E 0E    LDA $0E7E  [$7E:0E7E]  ;} Enemy tiles VRAM update destination address += 400h
$A0:8D21 95 D5       STA $D5,x  [$7E:00DC]  ;|
$A0:8D23 18          CLC                    ;|
$A0:8D24 69 00 04    ADC #$0400             ;|
$A0:8D27 8D 7E 0E    STA $0E7E  [$7E:0E7E]  ;|
$A0:8D2A 8A          TXA                    ;|
$A0:8D2B 18          CLC                    ;|
$A0:8D2C 69 07 00    ADC #$0007             ;|
$A0:8D2F 8D 30 03    STA $0330  [$7E:0330]  ;/
$A0:8D32 6B          RTL                    ; Return

$A0:8D33 A9 FE FF    LDA #$FFFE             ;\
$A0:8D36 8D 7C 0E    STA $0E7C  [$7E:0E7C]  ;} Enemy tiles VRAM update source address = FFFEh
$A0:8D39 6B          RTL
}


;;; $8D3A: Unused. Load enemy width, height, health, layer and bank ;;;
{
;; Parameters:
;;     X: Pointer to enemy ID
;;     Y: Enemy index

; DB must be $A0
$A0:8D3A DA          PHX
$A0:8D3B 5A          PHY
$A0:8D3C BD 00 00    LDA $0000,x    ;\
$A0:8D3F AA          TAX            ;|
$A0:8D40 BD 08 00    LDA $0008,x    ;} Enemy [Y] width = [[X] + 8]
$A0:8D43 99 82 0F    STA $0F82,y    ;/
$A0:8D46 BD 0A 00    LDA $000A,x    ;\
$A0:8D49 99 84 0F    STA $0F84,y    ;} Enemy [Y] height = [[X] + Ah]
$A0:8D4C BD 04 00    LDA $0004,x    ;\
$A0:8D4F 99 8C 0F    STA $0F8C,y    ;} Enemy [Y] health = [[X] + 4]
$A0:8D52 BD 39 00    LDA $0039,x    ;\
$A0:8D55 29 FF 00    AND #$00FF     ;} Enemy [Y] layer = [[X] + 39h]
$A0:8D58 99 9A 0F    STA $0F9A,y    ;/
$A0:8D5B BD 0C 00    LDA $000C,x    ;\
$A0:8D5E 99 A6 0F    STA $0FA6,y    ;} Enemy [Y] bank = [[X] + Ch]
$A0:8D61 7A          PLY
$A0:8D62 FA          PLX
$A0:8D63 6B          RTL
}


;;; $8D64: Process enemy set (load palettes and enemy loading data) ;;;
{
$A0:8D64 DA          PHX
$A0:8D65 5A          PHY
$A0:8D66 9C 7A 0E    STZ $0E7A  [$7E:0E7A]  ; Enemy loading data stack pointer = 0
$A0:8D69 A9 00 08    LDA #$0800             ;\
$A0:8D6C 85 1E       STA $1E    [$7E:001E]  ;} $1E = 800h (next enemy loading tile data destination offset)
$A0:8D6E A9 00 00    LDA #$0000             ;\
$A0:8D71 8F 5C EF 7E STA $7EEF5C[$7E:EF5C]  ;|
$A0:8D75 8F 5E EF 7E STA $7EEF5E[$7E:EF5E]  ;|
$A0:8D79 8F 60 EF 7E STA $7EEF60[$7E:EF60]  ;|
$A0:8D7D 8F 62 EF 7E STA $7EEF62[$7E:EF62]  ;|
$A0:8D81 8F 64 EF 7E STA $7EEF64[$7E:EF64]  ;|
$A0:8D85 8F 66 EF 7E STA $7EEF66[$7E:EF66]  ;|
$A0:8D89 8F 68 EF 7E STA $7EEF68[$7E:EF68]  ;} $7E:EF5C..EF77 = 0 (enemy GFX data RAM)
$A0:8D8D 8F 6A EF 7E STA $7EEF6A[$7E:EF6A]  ;|
$A0:8D91 8F 6C EF 7E STA $7EEF6C[$7E:EF6C]  ;|
$A0:8D95 8F 6E EF 7E STA $7EEF6E[$7E:EF6E]  ;|
$A0:8D99 8F 70 EF 7E STA $7EEF70[$7E:EF70]  ;|
$A0:8D9D 8F 72 EF 7E STA $7EEF72[$7E:EF72]  ;|
$A0:8DA1 8F 74 EF 7E STA $7EEF74[$7E:EF74]  ;|
$A0:8DA5 8F 76 EF 7E STA $7EEF76[$7E:EF76]  ;/
$A0:8DA9 AD D1 07    LDA $07D1  [$7E:07D1]  ;\
$A0:8DAC 85 1C       STA $1C    [$7E:001C]  ;} $1C = [enemy set pointer] (enemy set entry address)

; LOOP
$A0:8DAE AA          TAX                    ;\
$A0:8DAF BF 00 00 B4 LDA $B40000,x[$B4:9218];|
$A0:8DB3 C9 FF FF    CMP #$FFFF             ;} If [$B4:0000 + (enemy set entry address)] = FFFFh: return
$A0:8DB6 D0 03       BNE $03    [$8DBB]     ;|
$A0:8DB8 4C B3 8E    JMP $8EB3  [$A0:8EB3]  ;/

$A0:8DBB AA          TAX                    ; X = [$B4:0000 + (enemy set entry address)] (enemy ID)
$A0:8DBC BD 00 00    LDA $0000,x[$A0:E23F]  ;\
$A0:8DBF 85 12       STA $12    [$7E:0012]  ;} $12 = [[X]] (enemy tile data size)
$A0:8DC1 BD 02 00    LDA $0002,x[$A0:E241]  ;\
$A0:8DC4 85 14       STA $14    [$7E:0014]  ;} $14 = [[X] + 2] (enemy palette)
$A0:8DC6 BD 0C 00    LDA $000C,x[$A0:E24B]  ;\
$A0:8DC9 8D 20 0E    STA $0E20  [$7E:0E20]  ;} $0E20 = [[X] + Ch] (enemy bank)
$A0:8DCC A6 1C       LDX $1C    [$7E:001C]  ;\
$A0:8DCE BF 02 00 B4 LDA $B40002,x[$B4:921A];} A = [$B4:0002 + (enemy set entry address)] & FFh (enemy palette index)
$A0:8DD2 29 FF 00    AND #$00FF             ;/
$A0:8DD5 18          CLC                    ;\
$A0:8DD6 69 08 00    ADC #$0008             ;|
$A0:8DD9 22 02 B0 A0 JSL $A0B002[$A0:B002]  ;|
$A0:8DDD 18          CLC                    ;} $16 = $C300 + (enemy palette index) * 20h (target enemy palette address)
$A0:8DDE 69 00 C2    ADC #$C200             ;|
$A0:8DE1 85 16       STA $16    [$7E:0016]  ;/
$A0:8DE3 8B          PHB                    ;\
$A0:8DE4 AD 20 0E    LDA $0E20  [$7E:0E20]  ;|
$A0:8DE7 EB          XBA                    ;|
$A0:8DE8 48          PHA                    ;|
$A0:8DE9 AB          PLB                    ;|
$A0:8DEA AB          PLB                    ;|
$A0:8DEB A9 10 00    LDA #$0010             ;|
$A0:8DEE 8D 2E 0E    STA $0E2E  [$7E:0E2E]  ;|
$A0:8DF1 A6 16       LDX $16    [$7E:0016]  ;|
$A0:8DF3 A4 14       LDY $14    [$7E:0014]  ;|
                                            ;} Target enemy palette = 20h bytes from [$0E20]:[$14]
$A0:8DF5 B9 00 00    LDA $0000,y[$A6:F4EC]  ;|
$A0:8DF8 9F 00 00 7E STA $7E0000,x[$7E:C340];|
$A0:8DFC E8          INX                    ;|
$A0:8DFD E8          INX                    ;|
$A0:8DFE C8          INY                    ;|
$A0:8DFF C8          INY                    ;|
$A0:8E00 CE 2E 0E    DEC $0E2E  [$7E:0E2E]  ;|
$A0:8E03 D0 F0       BNE $F0    [$8DF5]     ;|
$A0:8E05 AB          PLB                    ;/
$A0:8E06 A6 1C       LDX $1C    [$7E:001C]  ;\
$A0:8E08 BF 00 00 B4 LDA $B40000,x[$B4:9218];} X = (enemy ID)
$A0:8E0C AA          TAX                    ;/
$A0:8E0D BD 36 00    LDA $0036,x[$A0:E275]  ;\
$A0:8E10 85 16       STA $16    [$7E:0016]  ;} $16 = [(enemy ID) + 36h] (enemy tile data pointer)
$A0:8E12 BD 38 00    LDA $0038,x[$A0:E277]  ;\
$A0:8E15 29 FF 00    AND #$00FF             ;} $1A = [(enemy ID) + 38h] (enemy tile data bank)
$A0:8E18 85 1A       STA $1A    [$7E:001A]  ;/
$A0:8E1A AE 7A 0E    LDX $0E7A  [$7E:0E7A]  ; X = [enemy loading data stack pointer]
$A0:8E1D A5 12       LDA $12    [$7E:0012]  ;\
$A0:8E1F 29 FF 7F    AND #$7FFF             ;} Enemy loading tile data size = (enemy tile data size) & 7FFFh
$A0:8E22 9D 5A 0E    STA $0E5A,x[$7E:0E5A]  ;/
$A0:8E25 A5 16       LDA $16    [$7E:0016]  ;\
$A0:8E27 9D 5C 0E    STA $0E5C,x[$7E:0E5C]  ;} Enemy loading tile data pointer = (enemy tile data pointer)
$A0:8E2A A5 1E       LDA $1E    [$7E:001E]  ; A = [$1E]
$A0:8E2C 24 12       BIT $12    [$7E:0012]  ;\
$A0:8E2E 10 0E       BPL $0E    [$8E3E]     ;} If (enemy tile data size) & 8000h != 0:
$A0:8E30 DA          PHX                    ;\
$A0:8E31 A6 1C       LDX $1C    [$7E:001C]  ;|
$A0:8E33 BF 02 00 B4 LDA $B40002,x[$B4:921A];|
$A0:8E37 29 00 30    AND #$3000             ;|
$A0:8E3A 4A          LSR A                  ;} A = (enemy palette index) >> 3 & 600h (so these enemies load to reserved space somewhere in $7E:7000..77FF, as opposed to normal enemies that load to $7E:7800..7FFF)
$A0:8E3B 4A          LSR A                  ;|
$A0:8E3C 4A          LSR A                  ;|
$A0:8E3D FA          PLX                    ;/

$A0:8E3E 9D 5F 0E    STA $0E5F,x[$7E:0E5F]  ; Enemy loading tile data destination offset = [A]
$A0:8E41 E2 20       SEP #$20               ;\
$A0:8E43 A5 1A       LDA $1A    [$7E:001A]  ;|
$A0:8E45 9D 5E 0E    STA $0E5E,x[$7E:0E5E]  ;} Enemy loading tile data = (enemy tile data bank)
$A0:8E48 C2 20       REP #$20               ;/
$A0:8E4A AD 7A 0E    LDA $0E7A  [$7E:0E7A]  ;\
$A0:8E4D 18          CLC                    ;|
$A0:8E4E 69 07 00    ADC #$0007             ;} Enemy loading data stack pointer += 7
$A0:8E51 8D 7A 0E    STA $0E7A  [$7E:0E7A]  ;/
$A0:8E54 DA          PHX
$A0:8E55 5A          PHY
$A0:8E56 AF 74 EF 7E LDA $7EEF74[$7E:EF74]  ;\
$A0:8E5A AA          TAX                    ;|
$A0:8E5B AF 76 EF 7E LDA $7EEF76[$7E:EF76]  ;} Enemy GFX tiles index = [next enemy GFX tiles index]
$A0:8E5F 9F 64 EF 7E STA $7EEF64,x[$7E:EF64];/
$A0:8E63 DA          PHX                    ;\
$A0:8E64 A6 1C       LDX $1C    [$7E:001C]  ;|
$A0:8E66 BF 00 00 B4 LDA $B40000,x[$B4:9218];} Enemy GFX enemy ID = (enemy ID)
$A0:8E6A FA          PLX                    ;|
$A0:8E6B 9F 5C EF 7E STA $7EEF5C,x[$7E:EF5C];/
$A0:8E6F DA          PHX                    ;\
$A0:8E70 A6 1C       LDX $1C    [$7E:001C]  ;|
$A0:8E72 BF 02 00 B4 LDA $B40002,x[$B4:921A];} Enemy GFX palette index = (enemy palette index)
$A0:8E76 FA          PLX                    ;|
$A0:8E77 9F 6C EF 7E STA $7EEF6C,x[$7E:EF6C];/
$A0:8E7B AF 74 EF 7E LDA $7EEF74[$7E:EF74]  ;\
$A0:8E7F 18          CLC                    ;|
$A0:8E80 69 02 00    ADC #$0002             ;} Enemy GFX data stack pointer += 2
$A0:8E83 8F 74 EF 7E STA $7EEF74[$7E:EF74]  ;/
$A0:8E87 7A          PLY
$A0:8E88 FA          PLX
$A0:8E89 A5 12       LDA $12    [$7E:0012]  ;\
$A0:8E8B 4A          LSR A                  ;|
$A0:8E8C 4A          LSR A                  ;|
$A0:8E8D 4A          LSR A                  ;|
$A0:8E8E 4A          LSR A                  ;} Next enemy tiles index += (enemy tile data size) / 20h (number of tiles)
$A0:8E8F 4A          LSR A                  ;|
$A0:8E90 18          CLC                    ;|
$A0:8E91 6F 76 EF 7E ADC $7EEF76[$7E:EF76]  ;|
$A0:8E95 8F 76 EF 7E STA $7EEF76[$7E:EF76]  ;/
$A0:8E99 A6 1C       LDX $1C    [$7E:001C]  ;\
$A0:8E9B BF 00 00 B4 LDA $B40000,x[$B4:9218];|
$A0:8E9F AA          TAX                    ;|
$A0:8EA0 BD 00 00    LDA $0000,x[$A0:E23F]  ;} $1E += (enemy tile data size) (even the negative ones, thus those enemies need to be last in the enemy set)
$A0:8EA3 18          CLC                    ;|
$A0:8EA4 65 1E       ADC $1E    [$7E:001E]  ;|
$A0:8EA6 85 1E       STA $1E    [$7E:001E]  ;/
$A0:8EA8 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:8EAA 18          CLC                    ;|
$A0:8EAB 69 04 00    ADC #$0004             ;} $1C += 4 (next entry in enemy set)
$A0:8EAE 85 1C       STA $1C    [$7E:001C]  ;/
$A0:8EB0 4C AE 8D    JMP $8DAE  [$A0:8DAE]  ; Go to LOOP

$A0:8EB3 7A          PLY
$A0:8EB4 FA          PLX
$A0:8EB5 60          RTS
}
}


;;; $8EB6: Determine which enemies to process ;;;
{
$A0:8EB6 8B          PHB
$A0:8EB7 F4 00 A0    PEA $A000              ;\
$A0:8EBA AB          PLB                    ;} DB = $A0
$A0:8EBB AB          PLB                    ;/
$A0:8EBC C2 30       REP #$30
$A0:8EBE EE 46 0E    INC $0E46  [$7E:0E46]  ; Increment $0E46 (never read)
$A0:8EC1 9C 54 0E    STZ $0E54  [$7E:0E54]  ; Enemy index = 0
$A0:8EC4 9C A4 17    STZ $17A4  [$7E:17A4]  ; Active enemy indices stack pointer = 0
$A0:8EC7 9C A6 17    STZ $17A6  [$7E:17A6]  ; Interactive enemy indices stack pointer = 0
$A0:8ECA AD 3C 18    LDA $183C  [$7E:183C]  ;\
$A0:8ECD F0 03       BEQ $03    [$8ED2]     ;} If global off-screen enemy processing enabled: go to LOOP_PROCESS_OFFSCREEN
$A0:8ECF 4C 77 8F    JMP $8F77  [$A0:8F77]  ;/

$A0:8ED2 A2 00 00    LDX #$0000             ; >_<;
$A0:8ED5 A0 00 00    LDY #$0000             ; >_<;

; LOOP
$A0:8ED8 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A0:8EDB BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:8EDE F0 74       BEQ $74    [$8F54]     ;} If [enemy ID] = 0: go to BRANCH_NEXT
$A0:8EE0 C9 FF DA    CMP #$DAFF             ;\
$A0:8EE3 F0 6F       BEQ $6F    [$8F54]     ;} If respawning enemy placeholder: go to BRANCH_NEXT
$A0:8EE5 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:8EE8 89 00 02    BIT #$0200             ;} If enemy is deleted:
$A0:8EEB F0 06       BEQ $06    [$8EF3]     ;/
$A0:8EED 9E 78 0F    STZ $0F78,x[$7E:0FF8]  ; Enemy ID = 0
$A0:8EF0 4C 54 8F    JMP $8F54  [$A0:8F54]  ; Go to BRANCH_NEXT

$A0:8EF3 89 00 08    BIT #$0800             ;\
$A0:8EF6 D0 3C       BNE $3C    [$8F34]     ;} If enemy is not processed off-screen:
$A0:8EF8 BD 8A 0F    LDA $0F8A,x[$7E:100A]  ;\
$A0:8EFB 89 04 00    BIT #$0004             ;} If enemy is not frozen:
$A0:8EFE D0 34       BNE $34    [$8F34]     ;/
$A0:8F00 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A0:8F03 18          CLC                    ;|
$A0:8F04 7D 82 0F    ADC $0F82,x[$7E:1002]  ;} If (enemy right boundary) + 1 < [layer 1 X position]: go to BRANCH_NEXT
$A0:8F07 CD 11 09    CMP $0911  [$7E:0911]  ;|
$A0:8F0A 30 48       BMI $48    [$8F54]     ;/
$A0:8F0C AD 11 09    LDA $0911  [$7E:0911]  ;\
$A0:8F0F 18          CLC                    ;|
$A0:8F10 69 00 01    ADC #$0100             ;|
$A0:8F13 18          CLC                    ;} If [layer 1 X position] + 100h < (enemy left boundary): go to BRANCH_NEXT
$A0:8F14 7D 82 0F    ADC $0F82,x[$7E:1002]  ;|
$A0:8F17 DD 7A 0F    CMP $0F7A,x[$7E:0FFA]  ;|
$A0:8F1A 30 38       BMI $38    [$8F54]     ;/
$A0:8F1C BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A0:8F1F 18          CLC                    ;|
$A0:8F20 69 08 00    ADC #$0008             ;|
$A0:8F23 CD 15 09    CMP $0915  [$7E:0915]  ;|
$A0:8F26 30 2C       BMI $2C    [$8F54]     ;|
$A0:8F28 AD 15 09    LDA $0915  [$7E:0915]  ;} If not [layer 1 Y position] - 8 <= [enemy Y position] <= [layer 1 Y position] + F8h: go to BRANCH_NEXT
$A0:8F2B 18          CLC                    ;|
$A0:8F2C 69 F8 00    ADC #$00F8             ;|
$A0:8F2F DD 7E 0F    CMP $0F7E,x[$7E:107E]  ;|
$A0:8F32 30 20       BMI $20    [$8F54]     ;/

$A0:8F34 8A          TXA                    ;\
$A0:8F35 AC A4 17    LDY $17A4  [$7E:17A4]  ;|
$A0:8F38 99 AC 17    STA $17AC,y[$7E:17AC]  ;|
$A0:8F3B C8          INY                    ;} Add enemy index to active enemies
$A0:8F3C C8          INY                    ;|
$A0:8F3D 8C A4 17    STY $17A4  [$7E:17A4]  ;/
$A0:8F40 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:8F43 89 00 04    BIT #$0400             ;} If enemy ignores Samus/projectiles: go to BRANCH_NEXT
$A0:8F46 D0 0C       BNE $0C    [$8F54]     ;/
$A0:8F48 8A          TXA                    ;\
$A0:8F49 AC A6 17    LDY $17A6  [$7E:17A6]  ;|
$A0:8F4C 99 EC 17    STA $17EC,y[$7E:17EC]  ;|
$A0:8F4F C8          INY                    ;} Add enemy index to interactive enemies
$A0:8F50 C8          INY                    ;|
$A0:8F51 8C A6 17    STY $17A6  [$7E:17A6]  ;/

; BRANCH_NEXT
$A0:8F54 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:8F57 18          CLC                    ;|
$A0:8F58 69 40 00    ADC #$0040             ;} Enemy index += 40h
$A0:8F5B 8D 54 0E    STA $0E54  [$7E:0E54]  ;/
$A0:8F5E C9 00 08    CMP #$0800             ;\
$A0:8F61 10 03       BPL $03    [$8F66]     ;} If [enemy index] < 800h: go to LOOP
$A0:8F63 4C D8 8E    JMP $8ED8  [$A0:8ED8]  ;/

$A0:8F66 A9 FF FF    LDA #$FFFF             ;\
$A0:8F69 AC A4 17    LDY $17A4  [$7E:17A4]  ;} Terminate active enemy indices list
$A0:8F6C 99 AC 17    STA $17AC,y[$7E:17B0]  ;/
$A0:8F6F AC A6 17    LDY $17A6  [$7E:17A6]  ;\
$A0:8F72 99 EC 17    STA $17EC,y[$7E:17F0]  ;} Terminate interactive enemy indices list
$A0:8F75 AB          PLB
$A0:8F76 6B          RTL                    ; Return

; LOOP_PROCESS_OFFSCREEN
$A0:8F77 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A0:8F7A BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:8F7D F0 35       BEQ $35    [$8FB4]     ;} If [enemy ID] = 0: go to BRANCH_NEXT_PROCESS_OFFSCREEN
$A0:8F7F C9 FF DA    CMP #$DAFF             ;\
$A0:8F82 F0 30       BEQ $30    [$8FB4]     ;} If respawning enemy placeholder: go to BRANCH_NEXT_PROCESS_OFFSCREEN
$A0:8F84 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:8F87 89 00 02    BIT #$0200             ;} If enemy is deleted:
$A0:8F8A F0 05       BEQ $05    [$8F91]     ;/
$A0:8F8C 9E 78 0F    STZ $0F78,x[$7E:0FF8]  ; Enemy ID = 0
$A0:8F8F 80 23       BRA $23    [$8FB4]     ; Go to BRANCH_NEXT_PROCESS_OFFSCREEN

$A0:8F91 8A          TXA                    ;\
$A0:8F92 AC A4 17    LDY $17A4  [$7E:17A4]  ;|
$A0:8F95 99 AC 17    STA $17AC,y[$7E:17AC]  ;|
$A0:8F98 99 EC 17    STA $17EC,y[$7E:17EC]  ;} Add enemy index to active enemies (adds to interactive enemies using active enemies indices stack pointer, harmless bug)
$A0:8F9B C8          INY                    ;|
$A0:8F9C C8          INY                    ;|
$A0:8F9D 8C A4 17    STY $17A4  [$7E:17A4]  ;/
$A0:8FA0 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:8FA3 89 00 04    BIT #$0400             ;} If enemy ignores Samus/projectiles: go to BRANCH_NEXT_PROCESS_OFFSCREEN
$A0:8FA6 D0 0C       BNE $0C    [$8FB4]     ;/
$A0:8FA8 8A          TXA                    ;\
$A0:8FA9 AC A6 17    LDY $17A6  [$7E:17A6]  ;|
$A0:8FAC 99 EC 17    STA $17EC,y[$7E:17EC]  ;|
$A0:8FAF C8          INY                    ;} Add enemy index to interactive enemies
$A0:8FB0 C8          INY                    ;|
$A0:8FB1 8C A6 17    STY $17A6  [$7E:17A6]  ;/

; BRANCH_NEXT_PROCESS_OFFSCREEN
$A0:8FB4 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:8FB7 18          CLC                    ;|
$A0:8FB8 69 40 00    ADC #$0040             ;} Enemy index += 40h
$A0:8FBB 8D 54 0E    STA $0E54  [$7E:0E54]  ;/
$A0:8FBE C9 00 08    CMP #$0800             ;\
$A0:8FC1 30 B4       BMI $B4    [$8F77]     ;} If [enemy index] < 800h: go to LOOP_PROCESS_OFFSCREEN
$A0:8FC3 A9 FF FF    LDA #$FFFF             ;\
$A0:8FC6 AC A4 17    LDY $17A4  [$7E:17A4]  ;} Terminate active enemy indices list
$A0:8FC9 99 AC 17    STA $17AC,y[$7E:17B4]  ;/
$A0:8FCC AC A6 17    LDY $17A6  [$7E:17A6]  ;\
$A0:8FCF 99 EC 17    STA $17EC,y[$7E:17EE]  ;} Terminate interactive enemy indices list
$A0:8FD2 AB          PLB
$A0:8FD3 6B          RTL
}


;;; $8FD4: Main enemy routine ;;;
{
{
; If [first unused enemy index] != 0:
; {
;     If [enemy index to shake] != FFFFh:
;         Enemy [enemy index to shake] shake timer = 40h
;         Enemy index to shake = FFFFh
;
;     Interactive enemy indices index = 0 (used for some collision routines)
;
;     Active enemy indices index = 0
;     While [active enemy index] != FFFFh:
;     {
;         Enemy index = [active enemy index]
;         Enemy data pointer = $0F78 + [enemy index]
;         Enemy AI bank = [enemy bank]
;
;         If enemy is tangible:
;         {
;             If [enemy invincibility timer] != 0:
;                 Decrement enemy invincibility timer
;             Else if sprite interactions enabled:
;             {
;                 If time is not frozen and enemy time is not frozen:
;                     Enemy collision handling
;                     If [enemy ID] = 0: (enemy was killed?)
;                         Go to BRANCH_DRAW_ENEMY_END
;
;                 If enemy is paralysed:
;                     Go to BRANCH_PROCESS_AI_END
;             }
;         }
;
;         Enable enemy drawing
;         If time is frozen or enemy time is frozen:
;         {
;             If [enemy time is frozen AI pointer] != 0:
;                 Enemy AI pointer = [enemy time is frozen AI pointer]
;                 Execute enemy AI pointer in enemy bank
;         }
;         Else:
;         {
;             X = 0
;             If [enemy AI handler] != 0:
;                 X = bit index of lowest set bit of enemy AI handler
;
;             Enemy AI pointer = [[enemy ID] + 18h + [X] * 2]
;             Execute enemy AI pointer in enemy bank
;             Increment enemy frame counter
;             If enemy processes instructions:
;                 Enemy processing stage = 2
;                 Process enemy instructions
;         }
;
;         BRANCH_PROCESS_AI_END:
;         If enemy is paralysed:
;             If [enemy flash timer] = 1 or [enemy frozen timer] = 1:
;                 Enemy death
;
;         If (enemy is on-screen or enemy uses extended spritemap format) and enemy is not deleted and enemy is not invisible and enemy drawing is enabled:
;             Add enemy to drawing queue
;
;         BRANCH_DRAW_ENEMY_END:
;         If [enemy flash timer] != 0 and time is not frozen and enemy time is not frozen:
;             Decrement enemy flash timer
;             If [enemy flash timer] < 8:
;                 Unset enemy hurt AI
;
;         Active enemy indices index += 2
;     }
;
;     Handle sprite objects
;     Increment number of times main enemy routine has been executed
;     Enemy indices when Samus collides with solid enemy = FFFFh
;     Distances between Samus and enemy when Samus collides with solid enemy = 0
; }
}

$A0:8FD4 8B          PHB
$A0:8FD5 F4 00 A0    PEA $A000              ;\
$A0:8FD8 AB          PLB                    ;} DB = $A0
$A0:8FD9 AB          PLB                    ;/
$A0:8FDA C2 30       REP #$30
$A0:8FDC AD 4C 0E    LDA $0E4C  [$7E:0E4C]  ;\
$A0:8FDF D0 03       BNE $03    [$8FE4]     ;} If [first unused enemy index] = 0:
$A0:8FE1 4C 45 91    JMP $9145  [$A0:9145]  ; Go to BRANCH_RETURN

$A0:8FE4 AD 1C 0E    LDA $0E1C  [$7E:0E1C]  ;\
$A0:8FE7 C9 FF FF    CMP #$FFFF             ;} If [enemy index to shake] != FFFFh:
$A0:8FEA F0 0D       BEQ $0D    [$8FF9]     ;/
$A0:8FEC AA          TAX                    ; X = [enemy index to shake]
$A0:8FED A9 40 00    LDA #$0040             ;\
$A0:8FF0 9D A2 0F    STA $0FA2,x[$7E:0FA2]  ;} Enemy [X] shake timer = 40h
$A0:8FF3 A9 FF FF    LDA #$FFFF             ;\
$A0:8FF6 8D 1C 0E    STA $0E1C  [$7E:0E1C]  ;} Enemy index to shake = FFFFh

$A0:8FF9 9C AA 17    STZ $17AA  [$7E:17AA]  ; Interactive enemy indices index = 0
$A0:8FFC 9C A8 17    STZ $17A8  [$7E:17A8]  ; Active enemy indices index = 0

; LOOP
$A0:8FFF AC A8 17    LDY $17A8  [$7E:17A8]  ;\
$A0:9002 B9 AC 17    LDA $17AC,y[$7E:17AC]  ;|
$A0:9005 C9 FF FF    CMP #$FFFF             ;} If [active enemy index] = FFFFh:
$A0:9008 D0 03       BNE $03    [$900D]     ;/
$A0:900A 4C 45 91    JMP $9145  [$A0:9145]  ; Go to BRANCH_RETURN

$A0:900D 8D 54 0E    STA $0E54  [$7E:0E54]  ; Enemy index = [active enemy index]
$A0:9010 AA          TAX
$A0:9011 18          CLC                    ;\
$A0:9012 69 78 0F    ADC #$0F78             ;} Enemy data pointer = $0F78 + [enemy index]
$A0:9015 8D 58 0E    STA $0E58  [$7E:0E58]  ;/
$A0:9018 BD A6 0F    LDA $0FA6,x[$7E:0FA6]  ;\
$A0:901B 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:901E BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:9021 89 00 04    BIT #$0400             ;} If enemy is intangible: go to BRANCH_INTERACT_END
$A0:9024 D0 31       BNE $31    [$9057]     ;/
$A0:9026 BD A0 0F    LDA $0FA0,x[$7E:0FA0]  ;\
$A0:9029 F0 06       BEQ $06    [$9031]     ;} If [enemy invincibility timer] != 0:
$A0:902B DE A0 0F    DEC $0FA0,x[$7E:1020]  ; Decrement enemy invincibility timer
$A0:902E 4C 57 90    JMP $9057  [$A0:9057]  ; Go to BRANCH_INTERACT_END

$A0:9031 AD 12 0E    LDA $0E12  [$7E:0E12]  ;\
$A0:9034 D0 21       BNE $21    [$9057]     ;} If sprite interactions disabled: go to BRANCH_INTERACT_END
$A0:9036 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A0:9039 0D 5E 18    ORA $185E  [$7E:185E]  ;} If time is not frozen and enemy time is not frozen:
$A0:903C D0 0E       BNE $0E    [$904C]     ;/
$A0:903E 20 58 97    JSR $9758  [$A0:9758]  ; Enemy collision handling
$A0:9041 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9044 BD 78 0F    LDA $0F78,x[$7E:0F78]  ;} If [enemy ID] = 0: (enemy was killed?)
$A0:9047 D0 03       BNE $03    [$904C]     ;/
$A0:9049 4C 18 91    JMP $9118  [$A0:9118]  ; Go to BRANCH_DRAW_ENEMY_END

$A0:904C AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:904F BD 88 0F    LDA $0F88,x[$7E:0F88]  ;|
$A0:9052 89 01 00    BIT #$0001             ;} If enemy is paralysed: go to BRANCH_PROCESS_AI_END
$A0:9055 D0 6F       BNE $6F    [$90C6]     ;/

; BRANCH_INTERACT_END
$A0:9057 9C A2 17    STZ $17A2  [$7E:17A2]  ; Enable enemy drawing
$A0:905A AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A0:905D 0D 5E 18    ORA $185E  [$7E:185E]  ;} If time is frozen or enemy time is frozen:
$A0:9060 F0 0E       BEQ $0E    [$9070]     ;/
$A0:9062 BD 78 0F    LDA $0F78,x[$7E:1078]  ;\
$A0:9065 A8          TAY                    ;|
$A0:9066 B9 20 00    LDA $0020,y[$A0:D29F]  ;} If [enemy time is frozen AI pointer] = 0: go to BRANCH_PROCESS_AI_END
$A0:9069 F0 5B       BEQ $5B    [$90C6]     ;/
$A0:906B 8D 84 17    STA $1784  [$7E:1784]  ; Enemy AI pointer = [enemy time is frozen AI pointer]
$A0:906E 80 1E       BRA $1E    [$A0:908E]  ; Go to BRANCH_DETERMINE_AI_END

$A0:9070 A2 00 00    LDX #$0000             ; X = 0
$A0:9073 AC 54 0E    LDY $0E54  [$7E:0E54]  ;\
$A0:9076 B9 8A 0F    LDA $0F8A,y[$7E:0F8A]  ;} If [enemy AI handler] != 0:
$A0:9079 F0 06       BEQ $06    [$9081]     ;/

$A0:907B E8          INX                    ;\
$A0:907C 4A          LSR A                  ;|
$A0:907D B0 02       BCS $02    [$9081]     ;} X = bit index of lowest set bit of enemy AI handler
$A0:907F 80 FA       BRA $FA    [$907B]     ;/

$A0:9081 8A          TXA                    ;\
$A0:9082 0A          ASL A                  ;|
$A0:9083 18          CLC                    ;|
$A0:9084 79 78 0F    ADC $0F78,y[$7E:0F78]  ;} Enemy AI pointer = [[enemy ID] + 18h + [X] * 2]
$A0:9087 AA          TAX                    ;|
$A0:9088 BD 18 00    LDA $0018,x[$A0:E257]  ;|
$A0:908B 8D 84 17    STA $1784  [$7E:1784]  ;/

; BRANCH_DETERMINE_AI_END
$A0:908E 8B          PHB
$A0:908F 22 96 90 A0 JSL $A09096[$A0:9096]  ; Execute enemy AI pointer in enemy bank
$A0:9093 AB          PLB
$A0:9094 80 10       BRA $10    [$90A6]

$A0:9096 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9099 BD A6 0F    LDA $0FA6,x[$7E:0FA6]
$A0:909C 8D 86 17    STA $1786  [$7E:1786]
$A0:909F EB          XBA
$A0:90A0 48          PHA
$A0:90A1 AB          PLB
$A0:90A2 AB          PLB
$A0:90A3 DC 84 17    JML [$1784][$A6:F765]

$A0:90A6 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A0:90A9 0D 5E 18    ORA $185E  [$7E:185E]  ;} If time is not frozen and enemy time is not frozen:
$A0:90AC D0 18       BNE $18    [$90C6]     ;/
$A0:90AE AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:90B1 FE A4 0F    INC $0FA4,x[$7E:0FA4]  ;} Increment enemy frame counter
$A0:90B4 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:90B7 89 00 20    BIT #$2000             ;} If enemy processes instructions:
$A0:90BA F0 0A       BEQ $0A    [$90C6]     ;/
$A0:90BC A9 02 00    LDA #$0002             ;\
$A0:90BF 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 2
$A0:90C3 20 6A C2    JSR $C26A  [$A0:C26A]  ; Process enemy instructions

; BRANCH_PROCESS_AI_END
$A0:90C6 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:90C9 BD 88 0F    LDA $0F88,x[$7E:0F88]  ;|
$A0:90CC 89 01 00    BIT #$0001             ;} If enemy is not paralysed: go to BRANCH_PARALYSED_END
$A0:90CF F0 1E       BEQ $1E    [$90EF]     ;/
$A0:90D1 BD 9C 0F    LDA $0F9C,x[$7E:0F9C]  ;\
$A0:90D4 C9 01 00    CMP #$0001             ;} If [enemy flash timer] != 1:
$A0:90D7 F0 08       BEQ $08    [$90E1]     ;/
$A0:90D9 BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A0:90DC C9 01 00    CMP #$0001             ;} If [enemy frozen timer] != 1: go to BRANCH_PARALYSED_END
$A0:90DF D0 0E       BNE $0E    [$90EF]     ;/

$A0:90E1 A9 00 00    LDA #$0000             ;\
$A0:90E4 9F 02 70 7E STA $7E7002,x[$7E:7002];} Enemy cause of death = 0 (grapple paralysis)
$A0:90E8 A9 00 00    LDA #$0000             ; A = 0 (small explosion)
$A0:90EB 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death

; BRANCH_PARALYSED_END
$A0:90EF AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:90F2 BD 88 0F    LDA $0F88,x[$7E:0F88]  ;|
$A0:90F5 89 04 00    BIT #$0004             ;} If enemy doesn't use extended spritemap format:
$A0:90F8 D0 08       BNE $08    [$9102]     ;/
$A0:90FA 22 E7 AD A0 JSL $A0ADE7[$A0:ADE7]  ;\
$A0:90FE F0 02       BEQ $02    [$9102]     ;} If enemy is off-screen:
$A0:9100 80 16       BRA $16    [$9118]     ; Go to BRANCH_DRAW_ENEMY_END

$A0:9102 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9105 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;|
$A0:9108 89 00 03    BIT #$0300             ;} If enemy is not deleted and not invisible:
$A0:910B D0 0B       BNE $0B    [$9118]     ;/
$A0:910D AD A2 17    LDA $17A2  [$7E:17A2]  ;\
$A0:9110 89 01 00    BIT #$0001             ;} If enemy drawing is enabled:
$A0:9113 D0 03       BNE $03    [$9118]     ;/
$A0:9115 20 23 94    JSR $9423  [$A0:9423]  ; Add enemy to drawing queue

; BRANCH_DRAW_ENEMY_END
$A0:9118 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:911B BD 9C 0F    LDA $0F9C,x[$7E:0F9C]  ;} If [enemy flash timer] != 0:
$A0:911E F0 1C       BEQ $1C    [$913C]     ;/
$A0:9120 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A0:9123 0D 5E 18    ORA $185E  [$7E:185E]  ;} If time is not frozen and enemy time is not frozen:
$A0:9126 D0 14       BNE $14    [$913C]     ;/
$A0:9128 DE 9C 0F    DEC $0F9C,x[$7E:109C]  ; Decrement enemy flash timer
$A0:912B BD 9C 0F    LDA $0F9C,x[$7E:109C]  ;\
$A0:912E C9 08 00    CMP #$0008             ;} If [enemy flash timer] < 8:
$A0:9131 10 09       BPL $09    [$913C]     ;/
$A0:9133 BD 8A 0F    LDA $0F8A,x[$7E:108A]  ;\
$A0:9136 29 FD FF    AND #$FFFD             ;} Unset enemy hurt AI
$A0:9139 9D 8A 0F    STA $0F8A,x[$7E:108A]  ;/

$A0:913C EE A8 17    INC $17A8  [$7E:17A8]  ;\
$A0:913F EE A8 17    INC $17A8  [$7E:17A8]  ;} Active enemy indices index += 2
$A0:9142 4C FF 8F    JMP $8FFF  [$A0:8FFF]  ; Go to LOOP

; BRANCH_RETURN
$A0:9145 22 82 BC B4 JSL $B4BC82[$B4:BC82]  ; Handle sprite objects
$A0:9149 EE 44 0E    INC $0E44  [$7E:0E44]  ; Increment number of times main enemy routine has been executed
$A0:914C A9 FF FF    LDA #$FFFF             ;\
$A0:914F 8D 2C 18    STA $182C  [$7E:182C]  ;} Enemy index when Samus moving left collides with solid enemy = FFFFh
$A0:9152 8D 2E 18    STA $182E  [$7E:182E]  ; Enemy index when Samus moving right collides with solid enemy = FFFFh
$A0:9155 8D 30 18    STA $1830  [$7E:1830]  ; Enemy index when Samus moving up collides with solid enemy = FFFFh
$A0:9158 8D 32 18    STA $1832  [$7E:1832]  ; Enemy index when Samus moving down collides with solid enemy = FFFFh
$A0:915B 9C 34 18    STZ $1834  [$7E:1834]  ; Distance between Samus and enemy when Samus moving left collides with solid enemy = 0
$A0:915E 9C 36 18    STZ $1836  [$7E:1836]  ; Distance between Samus and enemy when Samus moving right collides with solid enemy = 0
$A0:9161 9C 38 18    STZ $1838  [$7E:1838]  ; Distance between Samus and enemy when Samus moving up collides with solid enemy = 0
$A0:9164 9C 3A 18    STZ $183A  [$7E:183A]  ; Distance between Samus and enemy when Samus moving down collides with solid enemy = 0
$A0:9167 AB          PLB
$A0:9168 6B          RTL
}


;;; $9169: Decrement Samus hurt timers and clear active enemy indices lists ;;;
{
$A0:9169 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A0:916C F0 03       BEQ $03    [$9171]     ;} Samus invincibility timer = max(0, [Samus invincibility timer] - 1])
$A0:916E CE A8 18    DEC $18A8  [$7E:18A8]  ;/

$A0:9171 AD AA 18    LDA $18AA  [$7E:18AA]  ;\
$A0:9174 F0 03       BEQ $03    [$9179]     ;} Samus knockback timer = max(0, [Samus knockback timer] - 1])
$A0:9176 CE AA 18    DEC $18AA  [$7E:18AA]  ;/

$A0:9179 AD AC 18    LDA $18AC  [$7E:18AC]  ;\
$A0:917C F0 03       BEQ $03    [$9181]     ;} Projectile invincibility timer = max(0, [Projectile invincibility timer] - 1])
$A0:917E CE AC 18    DEC $18AC  [$7E:18AC]  ;/

$A0:9181 A9 FF FF    LDA #$FFFF             ;\
$A0:9184 8D EC 17    STA $17EC  [$7E:17EC]  ;} Terminate interactive enemy indices list
$A0:9187 8D AC 17    STA $17AC  [$7E:17AC]  ; Terminate active enemy indices list
$A0:918A 6B          RTL
}


;;; $918B: Unused. Logging routine for a specific vertical enemy reaction ;;;
{
$A0:918B 8B          PHB
$A0:918C AD 48 18    LDA $1848  [$7E:1848]  ; A = [debug enemy log index]
$A0:918F D0 03       BNE $03    [$9194]     ; If [A] = 0:
$A0:9191 A9 00 90    LDA #$9000             ; A = $9000

$A0:9194 AA          TAX                    ;\
$A0:9195 AD 44 0E    LDA $0E44  [$7E:0E44]  ;} $7E:0000 + [A] = [number of times main enemy routine has been executed]
$A0:9198 9F 00 00 7E STA $7E0000,x          ;/
$A0:919C AD FE 0F    LDA $0FFE  [$7E:0FFE]  ;\
$A0:919F 9F 02 00 7E STA $7E0002,x          ;} $7E:0002 + [A] = [enemy 2 Y position]
$A0:91A3 AD 00 10    LDA $1000  [$7E:1000]  ;\
$A0:91A6 9F 04 00 7E STA $7E0004,x          ;} $7E:0004 + [A] = [enemy 2 Y subposition]
$A0:91AA AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;\
$A0:91AD 9F 06 00 7E STA $7E0006,x          ;} $7E:0006 + [A] = [extra Samus Y displacement]
$A0:91B1 AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;\
$A0:91B4 9F 08 00 7E STA $7E0008,x          ;} $7E:0008 + [A] = [extra Samus Y subdisplacement]
$A0:91B8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:91BB 9F 0A 00 7E STA $7E000A,x          ;} $7E:000A + [A] = [Samus Y position]
$A0:91BF AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A0:91C2 9F 0C 00 7E STA $7E000C,x          ;} $7E:000C + [A] = [Samus Y subposition]
$A0:91C6 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$A0:91C9 9F 0E 00 7E STA $7E000E,x          ;} $7E:000E + [A] = [Samus Y speed]
$A0:91CD AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$A0:91D0 9F 10 00 7E STA $7E0010,x          ;} $7E:0010 + [A] = [Samus Y subspeed]
$A0:91D4 AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$A0:91D7 9F 12 00 7E STA $7E0012,x          ;} $7E:0012 + [A] = [Samus Y radius]
$A0:91DB AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$A0:91DE 9F 14 00 7E STA $7E0014,x          ;} $7E:0014 + [A] = [Samus pose]
$A0:91E2 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$A0:91E5 9F 16 00 7E STA $7E0016,x          ;} $7E:0016 + [A] = [Samus movement type and pose X direction]
$A0:91E9 A9 00 00    LDA #$0000             ;\
$A0:91EC 9F 18 00 7E STA $7E0018,x          ;} $7E:0018 + [A] = 0
$A0:91F0 9F 1A 00 7E STA $7E001A,x          ; $7E:001A + [A] = 0
$A0:91F4 9F 1C 00 7E STA $7E001C,x          ; $7E:001C + [A] = 0
$A0:91F8 9F 1E 00 7E STA $7E001E,x          ; $7E:001E + [A] = 0
$A0:91FC 8A          TXA                    ;\
$A0:91FD 18          CLC                    ;} A += 20h
$A0:91FE 69 20 00    ADC #$0020             ;/
$A0:9201 C9 00 98    CMP #$9800             ;\
$A0:9204 30 03       BMI $03    [$9209]     ;} If [A] >= $9800:
$A0:9206 A9 00 00    LDA #$0000             ; A = 0

$A0:9209 8D 48 18    STA $1848  [$7E:1848]  ; Debug enemy log index = [A]
$A0:920C AB          PLB
$A0:920D 60          RTS
}


;;; $920E: Spawn enemy drops ;;;
{
;; Parameters:
;;     A: Enemy header pointer (to check drop rates)
;;     X: Enemy index
;;     $12: X position
;;     $14: Y position

; Used for boss deaths and enemy projectiles, but not normal enemy death
$A0:920E 08          PHP
$A0:920F 8B          PHB
$A0:9210 DA          PHX
$A0:9211 5A          PHY
$A0:9212 8D 24 0E    STA $0E24  [$7E:0E24]  ; $0E24 = [A] (enemy header pointer)
$A0:9215 F4 00 A0    PEA $A000              ;\
$A0:9218 AB          PLB                    ;} DB = $A0
$A0:9219 AB          PLB                    ;/
$A0:921A C2 30       REP #$30
$A0:921C A0 37 F3    LDY #$F337             ;\
$A0:921F AD 20 0E    LDA $0E20  [$7E:0E20]  ;} Spawn pickup enemy projectile
$A0:9222 22 27 80 86 JSL $868027[$86:8027]  ;/
$A0:9226 FA          PLX
$A0:9227 7A          PLY
$A0:9228 AB          PLB
$A0:9229 28          PLP
$A0:922A 6B          RTL
}


;;; $922B: Delete enemy and any connected enemies ;;;
{
; This is called only by rinkas in Mother Brain's room when deleted due to Mother Brain first form defeat
; Rinka has 1 part >_>;
$A0:922B 8B          PHB
$A0:922C AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A0:922F DA          PHX                    ;\
$A0:9230 BD 78 0F    LDA $0F78,x            ;|
$A0:9233 AA          TAX                    ;|
$A0:9234 BF 14 00 A0 LDA $A00014,x          ;|
$A0:9238 D0 01       BNE $01    [$923B]     ;} Y = max((number of enemy parts), 1)
$A0:923A 1A          INC A                  ;|
                                            ;|
$A0:923B A8          TAY                    ;|
$A0:923C FA          PLX                    ;/

; LOOP
$A0:923D 9E 78 0F    STZ $0F78,x            ; Enemy ID = 0
$A0:9240 8A          TXA                    ;\
$A0:9241 18          CLC                    ;|
$A0:9242 69 40 00    ADC #$0040             ;} X += 40h (next enemy)
$A0:9245 AA          TAX                    ;/
$A0:9246 88          DEY                    ; Decrement Y
$A0:9247 D0 F4       BNE $F4    [$923D]     ; If [Y] != 0: go to LOOP
$A0:9249 AB          PLB
$A0:924A 6B          RTL
}


;;; $924B: Debug. Spawn enemy to enemy index [Y] ;;;
{
;; Parameters:
;;     X: New enemy population data
;;     Y: New enemy index

; Returned A and X is ignored by callers
$A0:924B 8B          PHB
$A0:924C 8E 20 0E    STX $0E20  [$7E:0E20]  ; $0E20 = [X]
$A0:924F 8C 4A 0E    STY $0E4A  [$7E:0E4A]  ; New enemy index = [Y]
$A0:9252 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:9255 8D 56 0E    STA $0E56  [$7E:0E56]  ;} Enemy index backup = [enemy index]
$A0:9258 AD 84 17    LDA $1784  [$7E:1784]  ;\
$A0:925B 8D 88 17    STA $1788  [$7E:1788]  ;|
$A0:925E AD 86 17    LDA $1786  [$7E:1786]  ;} Enemy AI pointer backup = [enemy AI pointer]
$A0:9261 8D 8A 17    STA $178A  [$7E:178A]  ;/
$A0:9264 BD 00 00    LDA $0000,x            ;\
$A0:9267 AA          TAX                    ;|
$A0:9268 BF 14 00 A0 LDA $A00014,x          ;} $0E26 = [$A0:0014 + [X]] & FFh (number of enemy parts)
$A0:926C 29 FF 00    AND #$00FF             ;|
$A0:926F 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$A0:9272 4C DB 92    JMP $92DB  [$A0:92DB]  ; Go to spawn enemy
}


;;; $9275: Spawn enemy ;;;
{
;; Parameters:
;;     X: New enemy population data
;; Returns:
;;     X: New enemy index (or 800h if failed to spawn)

; Returned A is ignored by callers

; This routine attempts to find (number of enemy parts) consecutive free enemy slots, and calls $92DB if it succeeds
; It has a couple problems for multi-part enemies
; Looking forward at $92DB, $0E26 is supposed to be the number of enemy parts (non-decremented). Further evidenced by the debug spawn routine above
; $0E22 should be reset back to [number of enemy parts] - 1 as part of LOOP_FIRST_ENEMY,
; otherwise after finding one free slot and then finding one occupied slot,
; the loop will try to find one fewer consecutive slots
$A0:9275 8B          PHB
$A0:9276 8E 20 0E    STX $0E20  [$7E:0E20]  ; $0E20 = [X]
$A0:9279 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:927C 8D 56 0E    STA $0E56  [$7E:0E56]  ;} Enemy index backup = [enemy index]
$A0:927F AD 84 17    LDA $1784  [$7E:1784]  ;\
$A0:9282 8D 88 17    STA $1788  [$7E:1788]  ;|
$A0:9285 AD 86 17    LDA $1786  [$7E:1786]  ;} Enemy AI pointer backup = [enemy AI pointer]
$A0:9288 8D 8A 17    STA $178A  [$7E:178A]  ;/
$A0:928B BD 00 00    LDA $0000,x[$A6:AA2F]  ;\
$A0:928E A8          TAY                    ;} Y = [[X]] (enemy ID)
$A0:928F DA          PHX                    ;\
$A0:9290 AA          TAX                    ;|
$A0:9291 BF 14 00 A0 LDA $A00014,x[$A0:E253];|
$A0:9295 FA          PLX                    ;|
$A0:9296 3A          DEC A                  ;|
$A0:9297 10 03       BPL $03    [$929C]     ;} $0E22 (loop counter) = $0E26 = max(0, (number of enemy parts) - 1)
$A0:9299 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:929C 8D 22 0E    STA $0E22  [$7E:0E22]  ;|
$A0:929F 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$A0:92A2 9C 4A 0E    STZ $0E4A  [$7E:0E4A]  ; New enemy index = 0

; LOOP_FIRST_ENEMY
$A0:92A5 AE 4A 0E    LDX $0E4A  [$7E:0E4A]  ; X = [new enemy index]
$A0:92A8 BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:92AB D0 1A       BNE $1A    [$92C7]     ;} If [new enemy ID] != 0: go to BRANCH_NEXT

; LOOP_OTHER_ENEMIES
$A0:92AD BD 78 0F    LDA $0F78,x[$7E:0FF8]  ;\
$A0:92B0 D0 15       BNE $15    [$92C7]     ;} If [enemy [X] ID] != 0: go to BRANCH_NEXT
$A0:92B2 AD 22 0E    LDA $0E22  [$7E:0E22]  ;\
$A0:92B5 F0 24       BEQ $24    [$92DB]     ;} If [$0E22] = 0: go to spawn enemy
$A0:92B7 CE 22 0E    DEC $0E22  [$7E:0E22]  ; Decrement $0E22
$A0:92BA 8A          TXA                    ;\
$A0:92BB 18          CLC                    ;|
$A0:92BC 69 40 00    ADC #$0040             ;} X += 40h (next enemy)
$A0:92BF AA          TAX                    ;/
$A0:92C0 E0 00 08    CPX #$0800             ;\
$A0:92C3 30 E8       BMI $E8    [$92AD]     ;} If [X] < 800h: go to LOOP_OTHER_ENEMIES
$A0:92C5 80 0F       BRA $0F    [$92D6]     ; Go to BRANCH_NOT_FOUND

; BRANCH_NEXT
$A0:92C7 AD 4A 0E    LDA $0E4A  [$7E:0E4A]  ;\
$A0:92CA 18          CLC                    ;|
$A0:92CB 69 40 00    ADC #$0040             ;} New enemy index += 40h
$A0:92CE 8D 4A 0E    STA $0E4A  [$7E:0E4A]  ;/
$A0:92D1 C9 00 08    CMP #$0800             ;\
$A0:92D4 30 CF       BMI $CF    [$92A5]     ;} If [new enemy index] < 800h: go to LOOP_FIRST_ENEMY

; BRANCH_NOT_FOUND
$A0:92D6 A9 FF FF    LDA #$FFFF             ; A = FFFFh
$A0:92D9 AB          PLB
$A0:92DA 6B          RTL
}


;;; $92DB: Spawn enemy ;;;
{
;; Parameters:
;;     DB:$0E20: New enemy population data
;;     $0E26: Number of enemy parts to spawn. 0 acts like 1 (thanks to the BEQ at $93E2)
;; Returns:
;;     X: New enemy index

; Returned A is ignored by callers, though even if it did,
; this routine doesn't check if it's overwriting an enemy or not and has no bounds checking, so it always succeeds

$A0:92DB AC 4A 0E    LDY $0E4A  [$7E:0E4A]  ; Y = [$0E4A] (new enemy index)
$A0:92DE AE 20 0E    LDX $0E20  [$7E:0E20]  ;\
$A0:92E1 BD 00 00    LDA $0000,x[$A6:AA2F]  ;} A = [[$0E20]] (new enemy ID)
$A0:92E4 A2 00 00    LDX #$0000             ; X = 0 (enemy GFX data index)
$A0:92E7 CF 5C EF 7E CMP $7EEF5C[$7E:EF5C]  ;\
$A0:92EB F0 26       BEQ $26    [$9313]     ;} If (new enemy ID) != [enemy GFX data 0 enemy ID]:
$A0:92ED A2 02 00    LDX #$0002             ; X = 2
$A0:92F0 CF 5E EF 7E CMP $7EEF5E[$7E:EF5E]  ;\
$A0:92F4 F0 1D       BEQ $1D    [$9313]     ;} If (new enemy ID) != [enemy GFX data 1 enemy ID]:
$A0:92F6 A2 04 00    LDX #$0004             ; X = 4
$A0:92F9 CF 60 EF 7E CMP $7EEF60[$7E:EF60]  ;\
$A0:92FD F0 14       BEQ $14    [$9313]     ;} If (new enemy ID) != [enemy GFX data 2 enemy ID]:
$A0:92FF A2 06 00    LDX #$0006             ; X = 6
$A0:9302 CF 62 EF 7E CMP $7EEF62[$7E:EF62]  ;\
$A0:9306 F0 0B       BEQ $0B    [$9313]     ;} If (new enemy ID) != [enemy GFX data 3 enemy ID]:
$A0:9308 A9 00 00    LDA #$0000             ;\
$A0:930B 99 98 0F    STA $0F98,y[$7E:1018]  ;} New enemy VRAM tiles index = 0
$A0:930E 99 96 0F    STA $0F96,y[$7E:1016]  ; New enemy palette index = 0
$A0:9311 80 10       BRA $10    [$9323]

$A0:9313 BF 64 EF 7E LDA $7EEF64,x[$7E:EF66];\ Else:
$A0:9317 99 98 0F    STA $0F98,y[$7E:1018]  ;} New enemy VRAM tiles index = [enemy GFX data enemy tiles index]
$A0:931A BF 6C EF 7E LDA $7EEF6C,x[$7E:EF6E];\
$A0:931E EB          XBA                    ;|
$A0:931F 0A          ASL A                  ;} New enemy palette index = [enemy GFX data enemy palette index] * 200h
$A0:9320 99 96 0F    STA $0F96,y[$7E:1016]  ;/

$A0:9323 AE 20 0E    LDX $0E20  [$7E:0E20]  ;\
$A0:9326 BD 00 00    LDA $0000,x[$A6:AA2F]  ;} X = [[$0E20]] (new enemy ID)
$A0:9329 AA          TAX                    ;/
$A0:932A BF 08 00 A0 LDA $A00008,x[$A0:E247];\
$A0:932E 99 82 0F    STA $0F82,y[$7E:1002]  ;} New enemy width = [$A0:0008 + [X]]
$A0:9331 BF 0A 00 A0 LDA $A0000A,x[$A0:E249];\
$A0:9335 99 84 0F    STA $0F84,y[$7E:1004]  ;} New enemy height = [$A0:000A + [X]]
$A0:9338 BF 04 00 A0 LDA $A00004,x[$A0:E243];\
$A0:933C 99 8C 0F    STA $0F8C,y[$7E:100C]  ;} New enemy health = [$A0:0004 + [X]]
$A0:933F BF 39 00 A0 LDA $A00039,x[$A0:E278];\
$A0:9343 29 FF 00    AND #$00FF             ;} New enemy layer = [$A0:0039 + [X]] & FFh
$A0:9346 99 9A 0F    STA $0F9A,y[$7E:101A]  ;/
$A0:9349 BF 0C 00 A0 LDA $A0000C,x[$A0:E24B];\
$A0:934D 99 A6 0F    STA $0FA6,y[$7E:1026]  ;} New enemy bank = [$A0:000C + [X]]
$A0:9350 AE 20 0E    LDX $0E20  [$7E:0E20]  ; X = [$0E20] (enemy population data pointer)
$A0:9353 BD 00 00    LDA $0000,x[$A6:AA2F]  ;\
$A0:9356 99 78 0F    STA $0F78,y[$7E:0FF8]  ;} New enemy ID = [[X]]
$A0:9359 BD 02 00    LDA $0002,x[$A6:AA31]  ;\
$A0:935C 99 7A 0F    STA $0F7A,y[$7E:0FFA]  ;} New enemy X position = [[X] + 2]
$A0:935F BD 04 00    LDA $0004,x[$A6:AA33]  ;\
$A0:9362 99 7E 0F    STA $0F7E,y[$7E:0FFE]  ;} New enemy Y position = [[X] + 4]
$A0:9365 BD 06 00    LDA $0006,x[$A6:AA35]  ;\
$A0:9368 99 92 0F    STA $0F92,y[$7E:1012]  ;} New enemy initialisation parameter = [[X] + 6]
$A0:936B BD 08 00    LDA $0008,x[$A6:AA37]  ;\
$A0:936E 99 86 0F    STA $0F86,y[$7E:1006]  ;} New enemy properties = [[X] + 8]
$A0:9371 BD 0A 00    LDA $000A,x[$A6:AA39]  ;\
$A0:9374 99 88 0F    STA $0F88,y[$7E:1008]  ;} New enemy extra properties = [[X] + Ah]
$A0:9377 BD 0C 00    LDA $000C,x[$A6:AA3B]  ;\
$A0:937A 99 B4 0F    STA $0FB4,y[$7E:1034]  ;} New enemy parameter 1 = [[X] + Ch]
$A0:937D BD 0E 00    LDA $000E,x[$A6:AA3D]  ;\
$A0:9380 99 B6 0F    STA $0FB6,y[$7E:1036]  ;} New enemy parameter 2 = [[X] + Eh]
$A0:9383 A9 00 00    LDA #$0000             ;\
$A0:9386 99 A4 0F    STA $0FA4,y[$7E:1024]  ;} New enemy frame counter = 0
$A0:9389 99 90 0F    STA $0F90,y[$7E:1010]  ; New enemy instruction timer = 0
$A0:938C 99 A8 0F    STA $0FA8,y[$7E:1028]  ;\
$A0:938F 99 AA 0F    STA $0FAA,y[$7E:102A]  ;|
$A0:9392 99 AC 0F    STA $0FAC,y[$7E:102C]  ;|
$A0:9395 99 AE 0F    STA $0FAE,y[$7E:102E]  ;} New enemy $0FA8..B3 = 0
$A0:9398 99 B0 0F    STA $0FB0,y[$7E:1030]  ;|
$A0:939B 99 B2 0F    STA $0FB2,y[$7E:1032]  ;/
$A0:939E A9 01 00    LDA #$0001             ;\
$A0:93A1 99 94 0F    STA $0F94,y[$7E:1014]  ;} New enemy instruction delay = 1
$A0:93A4 A9 00 00    LDA #$0000             ;\
$A0:93A7 99 A4 0F    STA $0FA4,y[$7E:1024]  ;} >_<
$A0:93AA 22 D0 88 A0 JSL $A088D0[$A0:88D0]  ; Record enemy spawn data
$A0:93AE DA          PHX
$A0:93AF 5A          PHY
$A0:93B0 8C 54 0E    STY $0E54  [$7E:0E54]  ; Enemy index = [new enemy index]
$A0:93B3 BE 78 0F    LDX $0F78,y[$7E:0FF8]  ;\
$A0:93B6 BF 12 00 A0 LDA $A00012,x[$A0:E251];|
$A0:93BA C9 00 80    CMP #$8000             ;} If (new enemy initialisation AI) >= 8000h:
$A0:93BD 30 10       BMI $10    [$93CF]     ;/
$A0:93BF 8D 84 17    STA $1784  [$7E:1784]  ;\
$A0:93C2 BF 0C 00 A0 LDA $A0000C,x[$A0:E24B];|
$A0:93C6 8D 86 17    STA $1786  [$7E:1786]  ;|
$A0:93C9 8B          PHB                    ;} Execute (new enemy initialisation AI)
$A0:93CA 22 1A 94 A0 JSL $A0941A[$A0:941A]  ;|
$A0:93CE AB          PLB                    ;/

$A0:93CF 7A          PLY
$A0:93D0 FA          PLX
$A0:93D1 B9 86 0F    LDA $0F86,y[$7E:1006]  ;\
$A0:93D4 89 00 20    BIT #$2000             ;} If new enemy processes instructions:
$A0:93D7 F0 06       BEQ $06    [$93DF]     ;/
$A0:93D9 A9 4D 80    LDA #$804D             ;\
$A0:93DC 99 8E 0F    STA $0F8E,y[$7E:100E]  ;} New enemy spritemap pointer = $804D (kinda rude to do this *after* executing the enemy init AI)

$A0:93DF AD 26 0E    LDA $0E26  [$7E:0E26]  ;\
$A0:93E2 F0 1C       BEQ $1C    [$9400]     ;} If [$0E26] != 0:
$A0:93E4 CE 26 0E    DEC $0E26  [$7E:0E26]  ; Decrement $0E26
$A0:93E7 F0 17       BEQ $17    [$9400]     ; If [$0E26] != 0:
$A0:93E9 AD 4A 0E    LDA $0E4A  [$7E:0E4A]  ;\
$A0:93EC 18          CLC                    ;|
$A0:93ED 69 40 00    ADC #$0040             ;} New enemy index += 40h
$A0:93F0 8D 4A 0E    STA $0E4A  [$7E:0E4A]  ;/
$A0:93F3 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$A0:93F6 18          CLC                    ;|
$A0:93F7 69 10 00    ADC #$0010             ;} $0E20 += 10h (next enemy population entry)
$A0:93FA 8D 20 0E    STA $0E20  [$7E:0E20]  ;/
$A0:93FD 4C DB 92    JMP $92DB  [$A0:92DB]  ; Go to spawn enemy parts

$A0:9400 AD 88 17    LDA $1788  [$7E:1788]  ;\
$A0:9403 8D 84 17    STA $1784  [$7E:1784]  ;|
$A0:9406 AD 8A 17    LDA $178A  [$7E:178A]  ;} Enemy AI pointer = [enemy AI pointer backup]
$A0:9409 8D 86 17    STA $1786  [$7E:1786]  ;/
$A0:940C AD 56 0E    LDA $0E56  [$7E:0E56]  ;\
$A0:940F 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy index = [enemy index backup]
$A0:9412 AE 4A 0E    LDX $0E4A  [$7E:0E4A]  ; X = [new enemy index]
$A0:9415 A9 00 00    LDA #$0000             ; A = 0
$A0:9418 AB          PLB
$A0:9419 6B          RTL                    ; Return

; Execute enemy AI pointer
$A0:941A B9 A5 0F    LDA $0FA5,y[$7E:1025]
$A0:941D 48          PHA
$A0:941E AB          PLB
$A0:941F AB          PLB
$A0:9420 DC 84 17    JML [$1784][$A6:F6C5]
}


;;; $9423: Add enemy to drawing queue ;;;
{
$A0:9423 DA          PHX
$A0:9424 5A          PHY
$A0:9425 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9428 BD 9A 0F    LDA $0F9A,x[$7E:0F9A]  ;|
$A0:942B 0A          ASL A                  ;} Enemy drawing queue index = [enemy layer] * 2
$A0:942C 8D 34 0E    STA $0E34  [$7E:0E34]  ;/
$A0:942F A8          TAY                    ;\
$A0:9430 B9 33 B1    LDA $B133,y[$A0:B137]  ;|
$A0:9433 18          CLC                    ;|
$A0:9434 79 68 0F    ADC $0F68,y[$7E:0F6C]  ;} [Address of enemy drawing queue] + [size of enemy drawing queue] = [enemy index]
$A0:9437 A8          TAY                    ;|
$A0:9438 AD 54 0E    LDA $0E54  [$7E:0E54]  ;|
$A0:943B 99 00 00    STA $0000,y[$7E:0EA6]  ;/
$A0:943E AE 34 0E    LDX $0E34  [$7E:0E34]  ;\
$A0:9441 FE 68 0F    INC $0F68,x[$7E:0F6C]  ;} Size of enemy drawing queue += 2
$A0:9444 FE 68 0F    INC $0F68,x[$7E:0F6C]  ;/
$A0:9447 7A          PLY
$A0:9448 FA          PLX
$A0:9449 60          RTS
}


;;; $944A: Write enemy OAM (if not on frozen or invincible frame) ;;;
{
$A0:944A 8B          PHB
$A0:944B AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:944E BD A5 0F    LDA $0FA5,x[$7E:0FA5]  ;\
$A0:9451 48          PHA                    ;|
$A0:9452 AB          PLB                    ;} DB = [enemy bank]
$A0:9453 AB          PLB                    ;/
$A0:9454 C2 30       REP #$30
$A0:9456 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9459 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A0:945C 38          SEC                    ;|
$A0:945D ED 11 09    SBC $0911  [$7E:0911]  ;|
$A0:9460 18          CLC                    ;} $0E22 = [enemy X position] - [layer 1 X position] + [enemy graphical X offset] (enemy X position on screen)
$A0:9461 7F 10 70 7E ADC $7E7010,x[$7E:7010];|
$A0:9465 8D 22 0E    STA $0E22  [$7E:0E22]  ;/
$A0:9468 85 14       STA $14    [$7E:0014]  ; $14 = (enemy X position on screen) (spritemap X origin)
$A0:946A BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A0:946D 38          SEC                    ;|
$A0:946E ED 15 09    SBC $0915  [$7E:0915]  ;|
$A0:9471 18          CLC                    ;} $0E20 = [enemy Y position] - [layer 1 Y position] + [enemy graphical Y offset] (enemy Y position on screen)
$A0:9472 7F 12 70 7E ADC $7E7012,x[$7E:7012];|
$A0:9476 8D 20 0E    STA $0E20  [$7E:0E20]  ;/
$A0:9479 85 12       STA $12    [$7E:0012]  ; $12 = (enemy Y position on screen) (spritemap Y origin)
$A0:947B BD A2 0F    LDA $0FA2,x[$7E:0FA2]  ;\
$A0:947E F0 17       BEQ $17    [$9497]     ;} If [enemy shake timer] = 0: BRANCH_NO_SHAKE
$A0:9480 BD A4 0F    LDA $0FA4,x[$7E:1024]  ;\
$A0:9483 29 02 00    AND #$0002             ;} If [enemy frame counter] & 2 != 0:
$A0:9486 F0 07       BEQ $07    [$948F]     ;/
$A0:9488 C6 14       DEC $14    [$7E:0014]  ; Decrement (sprite X position)
$A0:948A CE 22 0E    DEC $0E22  [$7E:0E22]  ; Decrement (enemy X position on screen)
$A0:948D 80 05       BRA $05    [$9494]
                                            ; Else ([enemy frame counter] & 2 = 0):
$A0:948F E6 14       INC $14    [$7E:0014]  ; Increment (sprite X position)
$A0:9491 EE 22 0E    INC $0E22  [$7E:0E22]  ; Increment (enemy X position on screen)

$A0:9494 DE A2 0F    DEC $0FA2,x[$7E:1022]  ; Decrement enemy shake timer

; BRANCH_NO_SHAKE
$A0:9497 BD 9C 0F    LDA $0F9C,x[$7E:0F9C]  ;\
$A0:949A F0 0D       BEQ $0D    [$94A9]     ;} If [enemy flash timer] != 0:
$A0:949C AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A0:949F 29 02 00    AND #$0002             ;} If [number of times main enemy routine has been executed] & 2 != 0:
$A0:94A2 F0 05       BEQ $05    [$94A9]     ;/
$A0:94A4 A9 00 00    LDA #$0000             ; $03 = 0 (palette 0)
$A0:94A7 80 17       BRA $17    [$94C0]     ; Go to BRANCH_DETERMINED_PALETTE

$A0:94A9 BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A0:94AC F0 0F       BEQ $0F    [$94BD]     ;} If [enemy frozen timer] = 0: go to BRANCH_USE_ENEMY_PALETTE
$A0:94AE C9 5A 00    CMP #$005A             ;\
$A0:94B1 B0 05       BCS $05    [$94B8]     ;} If [enemy frozen timer] < 90:
$A0:94B3 89 02 00    BIT #$0002             ;\
$A0:94B6 F0 05       BEQ $05    [$94BD]     ;} Or [enemy frozen timer] & 2 = 0: go to BRANCH_USE_ENEMY_PALETTE

$A0:94B8 A9 00 0C    LDA #$0C00             ; $03 = C00h (palette 6)
$A0:94BB 80 03       BRA $03    [$94C0]     ; Go to BRANCH_DETERMINED_PALETTE

; BRANCH_USE_ENEMY_PALETTE
$A0:94BD BD 96 0F    LDA $0F96,x[$7E:0F96]  ; $03 = [enemy palette index]

; BRANCH_DETERMINED_PALETTE
$A0:94C0 85 03       STA $03    [$7E:0003]
$A0:94C2 BD 98 0F    LDA $0F98,x[$7E:0F98]  ;\
$A0:94C5 85 00       STA $00    [$7E:0000]  ;} $00 = [enemy VRAM tiles index]
$A0:94C7 BD 88 0F    LDA $0F88,x[$7E:0F88]  ;\
$A0:94CA 89 04 00    BIT #$0004             ;} If enemy doesn't use extended spritemap format:
$A0:94CD D0 25       BNE $25    [$94F4]     ;/
$A0:94CF BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:94D2 8F 7E F3 7E STA $7EF37E[$7E:F37E]  ;} $7E:F37E = [enemy ID] (never read)
$A0:94D6 BD 92 0F    LDA $0F92,x[$7E:0F92]  ;\
$A0:94D9 8F 7A F3 7E STA $7EF37A[$7E:F37A]  ;} $7E:F37A = [enemy instruction list pointer] (never read)
$A0:94DD AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:94E0 8F 7C F3 7E STA $7EF37C[$7E:F37C]  ;} $7E:F37C = [enemy index] (never read)
$A0:94E4 A9 01 00    LDA #$0001             ;\
$A0:94E7 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 1
$A0:94EB BC 8E 0F    LDY $0F8E,x[$7E:0F8E]  ; Y = [enemy spritemap pointer]
$A0:94EE 22 B8 8A 81 JSL $818AB8[$81:8AB8]  ; Add spritemap to OAM with base tile number - no off-screen handling
$A0:94F2 AB          PLB
$A0:94F3 60          RTS                    ; Return

$A0:94F4 BD 8E 0F    LDA $0F8E,x[$7E:0F8E]  ;\
$A0:94F7 C9 00 80    CMP #$8000             ;|
                                            ;} If [enemy spritemap pointer] < 8000h: crash
$A0:94FA 30 FE       BMI $FE    [$94FA]     ;/
$A0:94FC A8          TAY                    ; Y = [enemy spritemap pointer]
$A0:94FD B9 00 00    LDA $0000,y[$A6:E983]  ;\
$A0:9500 29 FF 00    AND #$00FF             ;} Number of remaining enemy spritemap entries = [[Y]]
$A0:9503 8D 0B 06    STA $060B  [$7E:060B]  ;/
$A0:9506 C8          INY                    ;\
$A0:9507 C8          INY                    ;} Y += 2 (extended spritemap entry index)

; LOOP
$A0:9508 B9 04 00    LDA $0004,y[$A6:E989]  ;\
$A0:950B 85 16       STA $16    [$7E:0016]  ;} $16 = (entry spritemap pointer)
$A0:950D AA          TAX                    ;\
$A0:950E BD 00 00    LDA $0000,x[$A6:ED29]  ;|
$A0:9511 C9 FE FF    CMP #$FFFE             ;} If [(entry spritemap pointer)] = FFFEh: (extended tilemap)
$A0:9514 D0 22       BNE $22    [$9538]     ;/
$A0:9516 B9 00 00    LDA $0000,y[$A4:C30E]  ;\
$A0:9519 18          CLC                    ;|
$A0:951A 6D 22 0E    ADC $0E22  [$7E:0E22]  ;} $14 = (enemy X position on screen) + (entry X offset) (never read)
$A0:951D 85 14       STA $14    [$7E:0014]  ;/
$A0:951F B9 02 00    LDA $0002,y[$A4:C310]  ;\
$A0:9522 18          CLC                    ;|
$A0:9523 6D 20 0E    ADC $0E20  [$7E:0E20]  ;} $12 = (enemy Y position on screen) + (entry Y offset) (never read)
$A0:9526 85 12       STA $12    [$7E:0012]  ;/
$A0:9528 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:952B BD 88 0F    LDA $0F88,x[$7E:0F88]  ;\
$A0:952E 29 00 80    AND #$8000             ;} If not processed a new enemy instruction: go to BRANCH_NEXT
$A0:9531 F0 3E       BEQ $3E    [$9571]     ;/
$A0:9533 20 CA 96    JSR $96CA  [$A0:96CA]  ; Process extended tilemap
$A0:9536 80 39       BRA $39    [$9571]     ; Go to BRANCH_NEXT

$A0:9538 B9 00 00    LDA $0000,y[$A6:E985]  ;\
$A0:953B 18          CLC                    ;|
$A0:953C 6D 22 0E    ADC $0E22  [$7E:0E22]  ;} $14 = (enemy X position on screen) + (entry X offset) (spritemap X origin)
$A0:953F 85 14       STA $14    [$7E:0014]  ;/
$A0:9541 69 80 00    ADC #$0080             ;\
$A0:9544 89 00 FE    BIT #$FE00             ;} If not -80h <= (sprite X position) < 180h: go to BRANCH_NEXT
$A0:9547 D0 28       BNE $28    [$9571]     ;/
$A0:9549 B9 02 00    LDA $0002,y[$A6:E987]  ;\
$A0:954C 18          CLC                    ;|
$A0:954D 6D 20 0E    ADC $0E20  [$7E:0E20]  ;} $12 = (enemy Y position on screen) + (entry Y offset) (spritemap Y origin)
$A0:9550 85 12       STA $12    [$7E:0012]  ;/
$A0:9552 69 80 00    ADC #$0080             ;\
$A0:9555 89 00 FE    BIT #$FE00             ;} If not -80h <= (sprite Y position) < 180h: go to BRANCH_NEXT
$A0:9558 D0 17       BNE $17    [$9571]     ;/
$A0:955A 5A          PHY
$A0:955B A5 12       LDA $12    [$7E:0012]  ;\
$A0:955D 89 00 FF    BIT #$FF00             ;} If 0 <= (sprite Y origin) < 100h:
$A0:9560 D0 08       BNE $08    [$956A]     ;/
$A0:9562 A4 16       LDY $16    [$7E:0016]  ; Y = [$16]
$A0:9564 22 22 8B 81 JSL $818B22[$81:8B22]  ; Add spritemap to OAM with base tile number - Y origin on-screen
$A0:9568 80 06       BRA $06    [$9570]
                                            ; Else (not 0 <= (sprite Y origin) < 100h):
$A0:956A A4 16       LDY $16    [$7E:0016]  ; Y = [$16]
$A0:956C 22 96 8B 81 JSL $818B96[$81:8B96]  ; Add spritemap to OAM with base tile number - Y origin off-screen

$A0:9570 7A          PLY

; BRANCH_NEXT
$A0:9571 98          TYA                    ;\
$A0:9572 18          CLC                    ;|
$A0:9573 69 08 00    ADC #$0008             ;} Y += 8 (next extended spritemap entry)
$A0:9576 A8          TAY                    ;/
$A0:9577 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement number of remaining enemy spritemap entries
$A0:957A D0 8C       BNE $8C    [$9508]     ; If [number of remaining enemy spritemap entries] != 0: go to LOOP
$A0:957C AB          PLB
$A0:957D 60          RTS
}


;;; $957E: Normal enemy frozen AI ;;;
{
; Returned A is ignored by callers
$A0:957E DA          PHX
$A0:957F 5A          PHY
$A0:9580 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9583 9E 9C 0F    STZ $0F9C,x[$7E:0FDC]  ; Enemy flash timer = 0
$A0:9586 BD 9E 0F    LDA $0F9E,x[$7E:0FDE]  ;\
$A0:9589 F0 10       BEQ $10    [$959B]     ;} If [enemy frozen timer] != 0:
$A0:958B DE 9E 0F    DEC $0F9E,x[$7E:0FDE]  ; Decrement enemy frozen timer
$A0:958E AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$A0:9591 29 02 00    AND #$0002             ;} If ice beam is equipped:
$A0:9594 F0 05       BEQ $05    [$959B]     ;/
$A0:9596 A9 01 00    LDA #$0001
$A0:9599 80 0F       BRA $0F    [$95AA]     ; Return

$A0:959B BD 8A 0F    LDA $0F8A,x[$7E:104A]  ;\
$A0:959E 29 FB FF    AND #$FFFB             ;} Unset frozen AI
$A0:95A1 9D 8A 0F    STA $0F8A,x[$7E:104A]  ;/
$A0:95A4 9D 9E 0F    STA $0F9E,x[$7E:105E]  ; Set frozen timer to zero (hopefully, depending on if other AI bits were set)
$A0:95A7 A9 00 00    LDA #$0000

$A0:95AA 7A          PLY
$A0:95AB FA          PLX
$A0:95AC 6B          RTL
}


;;; $95AD: Unused. Execute enemy AI ;;;
{
$A0:95AD 8B          PHB
$A0:95AE 08          PHP
$A0:95AF F4 00 A0    PEA $A000              ;\
$A0:95B2 AB          PLB                    ;} DB = $A0
$A0:95B3 AB          PLB                    ;/
$A0:95B4 C2 30       REP #$30
$A0:95B6 A2 00 00    LDX #$0000             ; X = 0
$A0:95B9 AC 54 0E    LDY $0E54  [$7E:0E54]  ;\
$A0:95BC B9 8A 0F    LDA $0F8A,y            ;} If [enemy AI handler] != 0:
$A0:95BF F0 06       BEQ $06    [$95C7]     ;/

$A0:95C1 E8          INX                    ;\
$A0:95C2 4A          LSR A                  ;|
$A0:95C3 B0 02       BCS $02    [$95C7]     ;} X = index of lowest set bit in [enemy AI handler]
$A0:95C5 80 FA       BRA $FA    [$95C1]     ;/

$A0:95C7 8A          TXA                    ;\
$A0:95C8 0A          ASL A                  ;|
$A0:95C9 18          CLC                    ;|
$A0:95CA 79 78 0F    ADC $0F78,y            ;} Enemy AI pointer = [[enemy ID] + 18h + [X] * 2] (AI pointer given by the lowest bit set in the AI handler)
$A0:95CD AA          TAX                    ;|
$A0:95CE BD 18 00    LDA $0018,x            ;|
$A0:95D1 8D 84 17    STA $1784  [$7E:1784]  ;/
$A0:95D4 B9 A6 0F    LDA $0FA6,y            ;\
$A0:95D7 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:95DA 22 E1 95 A0 JSL $A095E1[$A0:95E1]  ; Execute enemy AI pointer
$A0:95DE 28          PLP
$A0:95DF AB          PLB
$A0:95E0 6B          RTL                    ; Return

; Execute enemy AI pointer
$A0:95E1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:95E4 BD A6 0F    LDA $0FA6,x
$A0:95E7 8D 86 17    STA $1786  [$7E:1786]
$A0:95EA EB          XBA
$A0:95EB 48          PHA
$A0:95EC AB          PLB
$A0:95ED AB          PLB
$A0:95EE DC 84 17    JML [$1784]
}


;;; $95F1: Unused. Respawn enemy ;;;
{
; See $86:F264 for the used routine
$A0:95F1 8B          PHB
$A0:95F2 F4 00 A0    PEA $A000              ;\
$A0:95F5 AB          PLB                    ;} DB = $A0
$A0:95F6 AB          PLB                    ;/
$A0:95F7 C2 30       REP #$30
$A0:95F9 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:95FC 4A          LSR A                  ;|
$A0:95FD 4A          LSR A                  ;|
$A0:95FE 85 12       STA $12    [$7E:0012]  ;|
$A0:9600 AD CF 07    LDA $07CF  [$7E:07CF]  ;} X = [enemy population pointer] + [enemy index] / 4
$A0:9603 18          CLC                    ;|
$A0:9604 65 12       ADC $12    [$7E:0012]  ;|
$A0:9606 AA          TAX                    ;/
$A0:9607 AC 54 0E    LDY $0E54  [$7E:0E54]  ; Y = [enemy index]
$A0:960A BF 00 00 A1 LDA $A10000,x          ;\
$A0:960E 99 78 0F    STA $0F78,y            ;} Enemy ID = [$A1:0000 + [X]]
$A0:9611 BF 02 00 A1 LDA $A10002,x          ;\
$A0:9615 99 7A 0F    STA $0F7A,y            ;} Enemy X position = [$A1:0000 + [X] + 2]
$A0:9618 BF 04 00 A1 LDA $A10004,x          ;\
$A0:961C 99 7E 0F    STA $0F7E,y            ;} Enemy Y position = [$A1:0000 + [X] + 4]
$A0:961F BF 06 00 A1 LDA $A10006,x          ;\
$A0:9623 99 92 0F    STA $0F92,y            ;} Enemy initialisation parameter = [$A1:0000 + [X] + 6]
$A0:9626 BF 08 00 A1 LDA $A10008,x          ;\
$A0:962A 99 86 0F    STA $0F86,y            ;} Enemy properties = [$A1:0000 + [X] + 8]
$A0:962D BF 0A 00 A1 LDA $A1000A,x          ;\
$A0:9631 99 88 0F    STA $0F88,y            ;} Enemy extra properties = [$A1:0000 + [X] + Ah]
$A0:9634 BF 0C 00 A1 LDA $A1000C,x          ;\
$A0:9638 99 B4 0F    STA $0FB4,y            ;} Enemy parameter 1 = [$A1:0000 + [X] + Ch]
$A0:963B BF 0E 00 A1 LDA $A1000E,x          ;\
$A0:963F 99 B6 0F    STA $0FB6,y            ;} Enemy parameter 2 = [$A1:0000 + [X] + Eh]
$A0:9642 DA          PHX
$A0:9643 BB          TYX                    ;\
$A0:9644 BF 06 70 7E LDA $7E7006,x          ;|
$A0:9648 29 00 0E    AND #$0E00             ;} Enemy palette index = [enemy spawn palette index] & E00h
$A0:964B 9D 96 0F    STA $0F96,x            ;/
$A0:964E BF 06 70 7E LDA $7E7006,x          ;\
$A0:9652 29 FF 01    AND #$01FF             ;} Enemy VRAM tiles index = [enemy spawn palette index] & 1FFh (bug)
$A0:9655 9D 98 0F    STA $0F98,x            ;/
$A0:9658 FA          PLX
$A0:9659 A9 00 00    LDA #$0000             ;\
$A0:965C 99 9E 0F    STA $0F9E,y            ;} Enemy frozen timer = 0
$A0:965F 99 9C 0F    STA $0F9C,y            ; Enemy flash timer = 0
$A0:9662 99 A0 0F    STA $0FA0,y            ; Enemy invincibility timer = 0
$A0:9665 99 90 0F    STA $0F90,y            ; Enemy instruction timer = 0
$A0:9668 99 A4 0F    STA $0FA4,y            ; Enemy frame counter = 0
$A0:966B 99 A8 0F    STA $0FA8,y            ;\
$A0:966E 99 AA 0F    STA $0FAA,y            ;|
$A0:9671 99 AC 0F    STA $0FAC,y            ;|
$A0:9674 99 AE 0F    STA $0FAE,y            ;} Enemy AI variables = 0
$A0:9677 99 B0 0F    STA $0FB0,y            ;|
$A0:967A 99 B2 0F    STA $0FB2,y            ;/
$A0:967D A9 01 00    LDA #$0001             ;\
$A0:9680 99 94 0F    STA $0F94,y            ;} Enemy instruction timer = 1
$A0:9683 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9686 BD 78 0F    LDA $0F78,x            ;} X = [enemy ID]
$A0:9689 AA          TAX                    ;/
$A0:968A BD 12 00    LDA $0012,x            ;\
$A0:968D 8D 84 17    STA $1784  [$7E:1784]  ;} Enemy AI pointer = [[X] + 12h] (enemy initialisation AI)
$A0:9690 BD 08 00    LDA $0008,x            ;\
$A0:9693 99 82 0F    STA $0F82,y            ;} Enemy X radius = [[X] + 8]
$A0:9696 BD 0A 00    LDA $000A,x            ;\
$A0:9699 99 84 0F    STA $0F84,y            ;} Enemy Y radius = [[X] + Ah]
$A0:969C BD 04 00    LDA $0004,x            ;\
$A0:969F 99 8C 0F    STA $0F8C,y            ;} Enemy health = [[X] + 4]
$A0:96A2 BD 39 00    LDA $0039,x            ;\
$A0:96A5 29 FF 00    AND #$00FF             ;} Enemy layer = [[X] + 39h]
$A0:96A8 99 9A 0F    STA $0F9A,y            ;/
$A0:96AB BD 0C 00    LDA $000C,x            ;\
$A0:96AE 99 A6 0F    STA $0FA6,y            ;} Enemy bank = [[X] + Ch]
$A0:96B1 8D 86 17    STA $1786  [$7E:1786]  ; Enemy AI bank = [enemy bank]
$A0:96B4 22 BA 96 A0 JSL $A096BA[$A0:96BA]  ; Execute enemy AI
$A0:96B8 AB          PLB
$A0:96B9 6B          RTL                    ; Return

$A0:96BA AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:96BD BD A6 0F    LDA $0FA6,x
$A0:96C0 8D 86 17    STA $1786  [$7E:1786]
$A0:96C3 EB          XBA
$A0:96C4 48          PHA
$A0:96C5 AB          PLB
$A0:96C6 AB          PLB
$A0:96C7 DC 84 17    JML [$1784]
}


;;; $96CA: Process extended tilemap ;;;
{
;; Parameters:
;;     $16: Pointer to extended tilemap

; Crashes if writing >= 2800h bytes

; Extended tilemap format:
;     FFFE                      ; Enables extended tilemap
;     dddd nnnn xxxx xxxx [...] ; First entry
;     dddd nnnn xxxx xxxx [...] ; Second entry
;     [...]                     ; Other entries
;     FFFF                      ; Terminator
; where
;     d: Destination address (in bank $7E)
;     n: Number of tiles (size of tilemap / 2)
;     x: Tilemap
$A0:96CA 5A          PHY
$A0:96CB A4 16       LDY $16    [$7E:0016]  ;\
$A0:96CD C8          INY                    ;} Y = [$16] + 2
$A0:96CE C8          INY                    ;/

; LOOP
$A0:96CF B9 00 00    LDA $0000,y[$A4:D6DC]  ;\
$A0:96D2 C9 FF FF    CMP #$FFFF             ;} If [[Y]] = FFFFh: go to BRANCH_RETURN
$A0:96D5 F0 4A       BEQ $4A    [$9721]     ;/
$A0:96D7 AA          TAX                    ; X = [[Y]] (destination address)
$A0:96D8 B9 02 00    LDA $0002,y[$A4:D6DE]  ;\
$A0:96DB 8D 0D 06    STA $060D  [$7E:060D]  ;} Number of tiles = [[Y] + 2]
$A0:96DE C8          INY                    ;\
$A0:96DF C8          INY                    ;|
$A0:96E0 C8          INY                    ;} Y += 4 (tilemap address)
$A0:96E1 C8          INY                    ;/
$A0:96E2 4A          LSR A                  ;\
$A0:96E3 90 13       BCC $13    [$96F8]     ;} If [number of tiles] % 2 = 0: go to BRANCH_UNROLLED

$A0:96E5 B9 00 00    LDA $0000,y[$A4:D6F4]  ;\
$A0:96E8 9F 00 00 7E STA $7E0000,x[$7E:2040];|
$A0:96EC E8          INX                    ;|
$A0:96ED E8          INX                    ;} Copy [number of tiles] words from [Y] to $7E:0000 + [X]
$A0:96EE C8          INY                    ;} Y += [number of tiles] * 2
$A0:96EF C8          INY                    ;|
$A0:96F0 CE 0D 06    DEC $060D  [$7E:060D]  ;|
$A0:96F3 D0 F0       BNE $F0    [$96E5]     ;/
$A0:96F5 4C CF 96    JMP $96CF  [$A0:96CF]  ; Go to LOOP

; BRANCH_UNROLLED
$A0:96F8 B9 00 00    LDA $0000,y[$A4:D6E0]  ;\
$A0:96FB 9F 00 00 7E STA $7E0000,x[$7E:2000];|
$A0:96FF B9 02 00    LDA $0002,y[$A4:D6E2]  ;|
$A0:9702 9F 02 00 7E STA $7E0002,x[$7E:2002];|
$A0:9706 E8          INX                    ;|
$A0:9707 E8          INX                    ;|
$A0:9708 E8          INX                    ;|
$A0:9709 E8          INX                    ;|
$A0:970A C8          INY                    ;|
$A0:970B C8          INY                    ;} Copy [number of tiles] words from [Y] to $7E:0000 + [X]
$A0:970C C8          INY                    ;} Y += [number of tiles] * 2
$A0:970D C8          INY                    ;|
$A0:970E E0 00 28    CPX #$2800             ;|
                                            ;|
$A0:9711 10 FE       BPL $FE    [$9711]     ;|
$A0:9713 CE 0D 06    DEC $060D  [$7E:060D]  ;|
$A0:9716 CE 0D 06    DEC $060D  [$7E:060D]  ;|
$A0:9719 AD 0D 06    LDA $060D  [$7E:060D]  ;|
$A0:971C D0 DA       BNE $DA    [$96F8]     ;/
$A0:971E 4C CF 96    JMP $96CF  [$A0:96CF]  ; Go to LOOP

; BRANCH_RETURN
$A0:9721 EE 1E 0E    INC $0E1E  [$7E:0E1E]  ; Request enemy BG2 tilemap VRAM transfer
$A0:9724 7A          PLY
$A0:9725 60          RTS
}


;;; $9726: Handle queuing enemy BG2 tilemap VRAM transfer ;;;
{
; Used by Phantoon, Draygon, Crocomire and Mother Brain
$A0:9726 AD 1E 0E    LDA $0E1E  [$7E:0E1E]  ;\
$A0:9729 F0 29       BEQ $29    [$9754]     ;} If enemy BG2 tilemap VRAM transfer requested:
$A0:972B AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$A0:972E 0D 5E 18    ORA $185E  [$7E:185E]  ;} If time is not frozen and enemy time is not frozen:
$A0:9731 D0 21       BNE $21    [$9754]     ;/
$A0:9733 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A0:9736 AD 9A 17    LDA $179A  [$7E:179A]  ;|
$A0:9739 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A0:973B A9 00 20    LDA #$2000             ;|
$A0:973E 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A0:9740 A9 7E 00    LDA #$007E             ;|
$A0:9743 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of [enemy BG2 tilemap size] bytes from $7E:2000 to VRAM $4800 (BG2 tilemap)
$A0:9745 A9 00 48    LDA #$4800             ;|
$A0:9748 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A0:974A AD 30 03    LDA $0330  [$7E:0330]  ;|
$A0:974D 18          CLC                    ;|
$A0:974E 69 07 00    ADC #$0007             ;|
$A0:9751 8D 30 03    STA $0330  [$7E:0330]  ;/

$A0:9754 9C 1E 0E    STZ $0E1E  [$7E:0E1E]  ; Clear enemy BG2 tilemap VRAM transfer flag
$A0:9757 6B          RTL
}


;;; $9758..A3AE: Enemy collision handling ;;;
{
;;; $9758: Enemy collision handling ;;;
{
$A0:9758 08          PHP
$A0:9759 8B          PHB
$A0:975A F4 00 A0    PEA $A000              ;\
$A0:975D AB          PLB                    ;} DB = $A0
$A0:975E AB          PLB                    ;/
$A0:975F C2 30       REP #$30
$A0:9761 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9764 BD 88 0F    LDA $0F88,x[$7E:0F88]  ;|
$A0:9767 89 04 00    BIT #$0004             ;} If enemy uses extended spritemap format:
$A0:976A F0 0C       BEQ $0C    [$9778]     ;/
$A0:976C 20 7F 9B    JSR $9B7F  [$A0:9B7F]  ; Enemy / projectile collision handling - extended spritemap
$A0:976F 20 23 9D    JSR $9D23  [$A0:9D23]  ; Enemy / bomb collision handling - extended spritemap
$A0:9772 20 5A 9A    JSR $9A5A  [$A0:9A5A]  ; Enemy / Samus collision handling - extended spritemap
$A0:9775 AB          PLB
$A0:9776 28          PLP
$A0:9777 60          RTS                    ; Return

$A0:9778 20 43 A1    JSR $A143  [$A0:A143]  ; Enemy / projectile collision handling
$A0:977B 20 36 A2    JSR $A236  [$A0:A236]  ; Enemy / bomb collision handling
$A0:977E 20 7A A0    JSR $A07A  [$A0:A07A]  ; Enemy / Samus collision handling
$A0:9781 AB          PLB
$A0:9782 28          PLP
$A0:9783 60          RTS
}


;;; $9784: RTL ;;;
{
$A0:9784 6B          RTL
}


;;; $9785: Samus / projectile interaction handling ;;;
{
; Handles bomb jumps and damage due to reflected projectiles
$A0:9785 8B          PHB
$A0:9786 F4 00 A0    PEA $A000              ;\
$A0:9789 AB          PLB                    ;} DB = $A0
$A0:978A AB          PLB                    ;/
$A0:978B C2 30       REP #$30
$A0:978D A9 0A 00    LDA #$000A             ;\
$A0:9790 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = Ah
$A0:9794 AD AE 18    LDA $18AE  [$7E:18AE]  ;\
$A0:9797 D0 10       BNE $10    [$97A9]     ;} If Samus / projectile interaction disabled (never true): return
$A0:9799 A9 05 00    LDA #$0005             ;\
$A0:979C 8D 7C 18    STA $187C  [$7E:187C]  ;} Number of projectiles to check = 5
$A0:979F AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$A0:97A2 D0 07       BNE $07    [$97AB]     ;} If [bomb counter] != 0: go to BRANCH_BOMB_IS_ACTIVE
$A0:97A4 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$A0:97A7 D0 08       BNE $08    [$97B1]     ;} If [projectile counter] != 0: go to BRANCH_PROJECTILE_IS_ACTIVE

$A0:97A9 AB          PLB
$A0:97AA 6B          RTL                    ; Return

; BRANCH_BOMB_IS_ACTIVE
$A0:97AB A9 0A 00    LDA #$000A             ;\
$A0:97AE 8D 7C 18    STA $187C  [$7E:187C]  ;} Number of projectiles to check = Ah

; BRANCH_PROJECTILE_IS_ACTIVE
$A0:97B1 AD AC 18    LDA $18AC  [$7E:18AC]  ;\
$A0:97B4 F0 02       BEQ $02    [$97B8]     ;} If [projectile invincibility timer] != 0:
$A0:97B6 AB          PLB
$A0:97B7 6B          RTL                    ; Return

$A0:97B8 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A0:97BB F0 02       BEQ $02    [$97BF]     ;} If [Samus contact damage index] != normal:
$A0:97BD AB          PLB
$A0:97BE 6B          RTL                    ; Return

$A0:97BF 9C A6 18    STZ $18A6  [$7E:18A6]  ; Projectile index = 0

; LOOP
$A0:97C2 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:97C5 0A          ASL A                  ;|
$A0:97C6 A8          TAY                    ;} If [projectile damage] = 0:
$A0:97C7 B9 2C 0C    LDA $0C2C,y[$7E:0C2C]  ;|
$A0:97CA D0 03       BNE $03    [$97CF]     ;/
$A0:97CC 4C 84 98    JMP $9884  [$A0:9884]  ; Go to BRANCH_NEXT

$A0:97CF B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:97D2 89 00 80    BIT #$8000             ;} If projectile interacts with Samus:
$A0:97D5 D0 08       BNE $08    [$97DF]     ;/
$A0:97D7 29 00 0F    AND #$0F00             ;\
$A0:97DA C9 00 07    CMP #$0700             ;} If projectile isn't dead: go to BRANCH_INTERACTIVE
$A0:97DD 30 03       BMI $03    [$97E2]     ;/

$A0:97DF 4C 84 98    JMP $9884  [$A0:9884]  ; Go to BRANCH_NEXT

; BRANCH_INTERACTIVE
$A0:97E2 B9 04 0C    LDA $0C04,y[$7E:0C0E]  ;\
$A0:97E5 29 10 00    AND #$0010             ;} If projectile is flagged for deletion: go to BRANCH_NEXT
$A0:97E8 D0 F5       BNE $F5    [$97DF]     ;/
$A0:97EA B9 64 0B    LDA $0B64,y[$7E:0B6E]  ;\
$A0:97ED 38          SEC                    ;|
$A0:97EE ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A0:97F1 10 04       BPL $04    [$97F7]     ;|
$A0:97F3 49 FF FF    EOR #$FFFF             ;|
$A0:97F6 1A          INC A                  ;|
                                            ;} If |[projectile X position] - [Samus X position]| >= [projectile X radius] + [Samus X radius]: go to BRANCH_NEXT
$A0:97F7 38          SEC                    ;|
$A0:97F8 F9 B4 0B    SBC $0BB4,y[$7E:0BBE]  ;|
$A0:97FB 90 05       BCC $05    [$9802]     ;|
$A0:97FD CD FE 0A    CMP $0AFE  [$7E:0AFE]  ;|
$A0:9800 B0 DD       BCS $DD    [$97DF]     ;/

$A0:9802 B9 78 0B    LDA $0B78,y[$7E:0B82]  ;\
$A0:9805 38          SEC                    ;|
$A0:9806 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$A0:9809 10 04       BPL $04    [$980F]     ;|
$A0:980B 49 FF FF    EOR #$FFFF             ;|
$A0:980E 1A          INC A                  ;|
                                            ;} If |[projectile Y position] - [Samus Y position]| >= [projectile Y radius] + [Samus Y radius]:
$A0:980F 38          SEC                    ;|
$A0:9810 F9 C8 0B    SBC $0BC8,y[$7E:0BD2]  ;|
$A0:9813 90 07       BCC $07    [$981C]     ;|
$A0:9815 CD 00 0B    CMP $0B00  [$7E:0B00]  ;|
$A0:9818 90 02       BCC $02    [$981C]     ;/
$A0:981A 80 68       BRA $68    [$9884]     ; Go to BRANCH_NEXT

$A0:981C B9 18 0C    LDA $0C18,y[$7E:0C22]  ;\
$A0:981F 29 00 FF    AND #$FF00             ;|
$A0:9822 C9 00 03    CMP #$0300             ;} If projectile is not a power bomb:
$A0:9825 F0 05       BEQ $05    [$982C]     ;/
$A0:9827 C9 00 05    CMP #$0500             ;\
$A0:982A D0 24       BNE $24    [$9850]     ;} If projectile is not a bomb: go to BRANCH_NOT_A_BOMB

$A0:982C B9 7C 0C    LDA $0C7C,y[$7E:0C86]  ;\
$A0:982F C9 08 00    CMP #$0008             ;} If [bomb timer] != 8: go to BRANCH_NEXT
$A0:9832 D0 50       BNE $50    [$9884]     ;/
$A0:9834 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:9837 D9 64 0B    CMP $0B64,y[$7E:0B6E]  ;} If [Samus X position] = [bomb X position]: go to BRANCH_STRAIGHT
$A0:983A F0 0C       BEQ $0C    [$9848]     ;/
$A0:983C 30 05       BMI $05    [$9843]     ; If [Samus X position] > [bomb X position]:
$A0:983E A9 03 00    LDA #$0003             ; Bomb jump direction = right
$A0:9841 80 08       BRA $08    [$984B]
                                            ; Else ([Samus X position] < [bomb X position]):
$A0:9843 A9 01 00    LDA #$0001             ; Bomb jump direction = left
$A0:9846 80 03       BRA $03    [$984B]

; BRANCH_STRAIGHT
$A0:9848 A9 02 00    LDA #$0002             ; Bomb jump direction = straight

$A0:984B 8D 56 0A    STA $0A56  [$7E:0A56]
$A0:984E 80 34       BRA $34    [$9884]     ; Go to BRANCH_NEXT

; BRANCH_NOT_A_BOMB
$A0:9850 B9 04 0C    LDA $0C04,y            ;\
$A0:9853 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:9856 99 04 0C    STA $0C04,y            ;/
$A0:9859 B9 2C 0C    LDA $0C2C,y            ;\
$A0:985C 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;} Deal suit-adjusted projectile damage to Samus
$A0:9860 22 51 DF 91 JSL $91DF51[$91:DF51]  ;/
$A0:9864 A9 60 00    LDA #$0060             ;\
$A0:9867 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60h
$A0:986A A9 05 00    LDA #$0005             ;\
$A0:986D 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 5
$A0:9870 A0 00 00    LDY #$0000             ; Knockback X direction = left
$A0:9873 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:9876 38          SEC                    ;|
$A0:9877 FD 4B 1A    SBC $1A4B,x            ;} If [Samus X position] >= [enemy projectile [X] X position]: <-- BUG: should be projectile [Y] X position
$A0:987A 30 03       BMI $03    [$987F]     ;/
$A0:987C A0 01 00    LDY #$0001             ; Knockback X direction = right

$A0:987F 8C 54 0A    STY $0A54  [$7E:0A54]
$A0:9882 80 0E       BRA $0E    [$9892]     ; Return

; BRANCH_NEXT
$A0:9884 EE A6 18    INC $18A6  [$7E:18A6]  ; Increment projectile index
$A0:9887 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:988A CD 7C 18    CMP $187C  [$7E:187C]  ;} If [projectile index] != [number of projectiles to check]:
$A0:988D F0 03       BEQ $03    [$9892]     ;/
$A0:988F 4C C2 97    JMP $97C2  [$A0:97C2]  ; Go to LOOP

$A0:9892 AB          PLB
$A0:9893 6B          RTL
}


;;; $9894: Enemy projectile / Samus collision handling ;;;
{
$A0:9894 08          PHP
$A0:9895 8B          PHB
$A0:9896 F4 00 A0    PEA $A000              ;\
$A0:9899 AB          PLB                    ;} DB = $A0
$A0:989A AB          PLB                    ;/
$A0:989B C2 30       REP #$30
$A0:989D A9 0B 00    LDA #$000B             ;\
$A0:98A0 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = Bh
$A0:98A4 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A0:98A7 F0 03       BEQ $03    [$98AC]     ;} If [Samus invincibility timer] != 0:
$A0:98A9 AB          PLB
$A0:98AA 28          PLP
$A0:98AB 6B          RTL                    ; Return

$A0:98AC AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A0:98AF D0 6F       BNE $6F    [$9920]     ;} If [Samus contact damage index] != normal: return
$A0:98B1 A9 22 00    LDA #$0022             ;\
$A0:98B4 8D A6 18    STA $18A6  [$7E:18A6]  ;} Enemy projectile index = 22h

; LOOP
$A0:98B7 AE A6 18    LDX $18A6  [$7E:18A6]  ;\
$A0:98BA BD 97 19    LDA $1997,x[$7E:19B9]  ;} If [enemy projectile ID] = 0: go to BRANCH_NEXT
$A0:98BD F0 56       BEQ $56    [$9915]     ;/
$A0:98BF BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$A0:98C2 89 00 20    BIT #$2000             ;} If enemy projectile has disabled collisions with Samus: go to BRANCH_NEXT
$A0:98C5 D0 4E       BNE $4E    [$9915]     ;/
$A0:98C7 BD B3 1B    LDA $1BB3,x[$7E:1BD5]  ;\
$A0:98CA 29 FF 00    AND #$00FF             ;} If [enemy projectile X radius] = 0:
$A0:98CD D0 03       BNE $03    [$98D2]     ;/
$A0:98CF 4C 15 99    JMP $9915  [$A0:9915]  ; Go to BRANCH_NEXT

$A0:98D2 8D 20 0E    STA $0E20  [$7E:0E20]  ; $0E20 = [enemy projectile X radius]
$A0:98D5 BD B4 1B    LDA $1BB4,x[$7E:1BD6]  ;\
$A0:98D8 29 FF 00    AND #$00FF             ;} If [enemy projectile Y radius] = 0: go to BRANCH_NEXT
$A0:98DB F0 38       BEQ $38    [$9915]     ;/
$A0:98DD 8D 22 0E    STA $0E22  [$7E:0E22]  ; $0E22 = [enemy projectile Y radius]
$A0:98E0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:98E3 38          SEC                    ;|
$A0:98E4 FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$A0:98E7 10 04       BPL $04    [$98ED]     ;|
$A0:98E9 49 FF FF    EOR #$FFFF             ;|
$A0:98EC 1A          INC A                  ;|
                                            ;} If |[Samus X position] - [enemy projectile X position]| >= [Samus X radius] + [enemy projectile X radius]: go to BRANCH_NEXT
$A0:98ED 38          SEC                    ;|
$A0:98EE ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A0:98F1 90 05       BCC $05    [$98F8]     ;|
$A0:98F3 CD 20 0E    CMP $0E20  [$7E:0E20]  ;|
$A0:98F6 B0 1D       BCS $1D    [$9915]     ;/

$A0:98F8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:98FB 38          SEC                    ;|
$A0:98FC FD 93 1A    SBC $1A93,x[$7E:1AB5]  ;|
$A0:98FF 10 04       BPL $04    [$9905]     ;|
$A0:9901 49 FF FF    EOR #$FFFF             ;|
$A0:9904 1A          INC A                  ;|
                                            ;} If |[Samus Y position] - [enemy projectile Y position]| >= [Samus Y radius] + [enemy projectile Y radius]: go to BRANCH_NEXT
$A0:9905 38          SEC                    ;|
$A0:9906 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A0:9909 90 07       BCC $07    [$9912]     ;|
$A0:990B CD 22 0E    CMP $0E22  [$7E:0E22]  ;|
$A0:990E 90 02       BCC $02    [$9912]     ;|
$A0:9910 80 03       BRA $03    [$9915]     ;/

$A0:9912 20 23 99    JSR $9923  [$A0:9923]  ; Handle enemy projectile collision with Samus

; BRANCH_NEXT
$A0:9915 CE A6 18    DEC $18A6  [$7E:18A6]  ;\
$A0:9918 CE A6 18    DEC $18A6  [$7E:18A6]  ;} Enemy projectile index -= 2
$A0:991B AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:991E 10 97       BPL $97    [$98B7]     ;} If [enemy projectile index] >= 0: go to LOOP

$A0:9920 AB          PLB
$A0:9921 28          PLP
$A0:9922 6B          RTL
}


;;; $9923: Handle enemy projectile collision with Samus ;;;
{
;; Parameters:
;;     X: Enemy projectile index
$A0:9923 A9 60 00    LDA #$0060             ;\
$A0:9926 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60h
$A0:9929 A9 05 00    LDA #$0005             ;\
$A0:992C 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 5
$A0:992F 9B          TXY                    ;\
$A0:9930 BE 97 19    LDX $1997,y[$7E:19B9]  ;|
$A0:9933 BF 0A 00 86 LDA $86000A,x[$86:973E];} If (enemy projectile touch instruction list) != 0:
$A0:9937 F0 09       BEQ $09    [$9942]     ;/
$A0:9939 99 47 1B    STA $1B47,y[$7E:1B69]  ; Enemy projectile instruction pointer = (enemy projectile touch instruction list)
$A0:993C A9 01 00    LDA #$0001             ;\
$A0:993F 99 8F 1B    STA $1B8F,y[$7E:1BB1]  ;} Enemy projectile instruction delay = 1

$A0:9942 BB          TYX                    ;\
$A0:9943 3C D7 1B    BIT $1BD7,x[$7E:1BF9]  ;} If enemy projectile dies on contact:
$A0:9946 70 03       BVS $03    [$994B]     ;/
$A0:9948 9E 97 19    STZ $1997,x[$7E:19B7]  ; Delete enemy projectile

$A0:994B BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$A0:994E 29 FF 0F    AND #$0FFF             ;|
$A0:9951 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;} Deal suit-adjusted enemy projectile damage to Samus
$A0:9955 22 51 DF 91 JSL $91DF51[$91:DF51]  ;/
$A0:9959 A0 00 00    LDY #$0000             ; Knockback X direction = left
$A0:995C AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:995F 38          SEC                    ;|
$A0:9960 FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;} If [enemy projectile X position] <= [Samus X position]:
$A0:9963 30 03       BMI $03    [$9968]     ;/
$A0:9965 A0 01 00    LDY #$0001             ; Knockback X direction = right

$A0:9968 8C 54 0A    STY $0A54  [$7E:0A54]
$A0:996B 60          RTS
}


;;; $996C: Enemy projectile / projectile collision handling ;;;
{
$A0:996C 08          PHP
$A0:996D 8B          PHB
$A0:996E F4 00 A0    PEA $A000              ;\
$A0:9971 AB          PLB                    ;} DB = $A0
$A0:9972 AB          PLB                    ;/
$A0:9973 C2 30       REP #$30
$A0:9975 A9 0C 00    LDA #$000C             ;\
$A0:9978 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = Ch
$A0:997C AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$A0:997F D0 03       BNE $03    [$9984]     ;} If [projectile counter] = 0:
$A0:9981 AB          PLB
$A0:9982 28          PLP
$A0:9983 6B          RTL                    ; Return

$A0:9984 A9 22 00    LDA #$0022             ;\
$A0:9987 8D A6 18    STA $18A6  [$7E:18A6]  ;} Enemy projectile index = 22h

; LOOP_ENEMY_PROJECTILE
$A0:998A AE A6 18    LDX $18A6  [$7E:18A6]  ;\
$A0:998D BD 97 19    LDA $1997,x[$7E:19B9]  ;} If [enemy projectile ID] = 0: go to BRANCH_NEXT_ENEMY_PROJECTILE
$A0:9990 F0 56       BEQ $56    [$99E8]     ;/
$A0:9992 BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$A0:9995 10 51       BPL $51    [$99E8]     ;} If enemy projectile has disabled collisions with projectiles: go to BRANCH_NEXT_ENEMY_PROJECTILE
$A0:9997 A0 00 00    LDY #$0000             ; Y = 0 (projectile index)

; LOOP_PROJECTILE
$A0:999A BF 80 F3 7E LDA $7EF380,x[$7E:F3A2];\
$A0:999E C9 02 00    CMP #$0002             ;} If enemy projectile interaction with projectiles is disabled: go to BRANCH_NEXT_ENEMY_PROJECTILE
$A0:99A1 F0 45       BEQ $45    [$99E8]     ;/
$A0:99A3 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:99A6 F0 39       BEQ $39    [$99E1]     ;} If [projectile type] = 0: go to BRANCH_NEXT_PROJECTILE
$A0:99A8 29 00 0F    AND #$0F00             ;\
$A0:99AB C9 00 03    CMP #$0300             ;} If projectile is power bomb: go to BRANCH_NEXT_PROJECTILE
$A0:99AE F0 31       BEQ $31    [$99E1]     ;/
$A0:99B0 C9 00 05    CMP #$0500             ;\
$A0:99B3 F0 2C       BEQ $2C    [$99E1]     ;} If projectile is bomb: go to BRANCH_NEXT_PROJECTILE
$A0:99B5 C9 00 07    CMP #$0700             ;\
$A0:99B8 10 27       BPL $27    [$99E1]     ;} If projectile is projectile explosion: go to BRANCH_NEXT_PROJECTILE
$A0:99BA B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$A0:99BD 29 E0 FF    AND #$FFE0             ;|
$A0:99C0 85 12       STA $12    [$7E:0012]  ;|
$A0:99C2 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;} If [projectile X position] / 20h != [enemy projectile X position] / 20h: go to BRANCH_NEXT_PROJECTILE
$A0:99C5 29 E0 FF    AND #$FFE0             ;|
$A0:99C8 C5 12       CMP $12    [$7E:0012]  ;|
$A0:99CA D0 15       BNE $15    [$99E1]     ;/
$A0:99CC B9 78 0B    LDA $0B78,y[$7E:0B7A]  ;\
$A0:99CF 29 E0 FF    AND #$FFE0             ;|
$A0:99D2 85 12       STA $12    [$7E:0012]  ;|
$A0:99D4 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;} If [projectile Y position] / 20h != [enemy projectile Y position] / 20h: go to BRANCH_NEXT_PROJECTILE
$A0:99D7 29 E0 FF    AND #$FFE0             ;|
$A0:99DA C5 12       CMP $12    [$7E:0012]  ;|
$A0:99DC D0 03       BNE $03    [$99E1]     ;/
$A0:99DE 20 F9 99    JSR $99F9  [$A0:99F9]  ; Handle enemy projectile collision with projectile

; BRANCH_NEXT_PROJECTILE
$A0:99E1 C8          INY                    ;\
$A0:99E2 C8          INY                    ;} Y += 2 (next projectile)
$A0:99E3 C0 0A 00    CPY #$000A             ;\
$A0:99E6 30 B2       BMI $B2    [$999A]     ;} If [Y] < Ah: go to LOOP_PROJECTILE

; BRANCH_NEXT_ENEMY_PROJECTILE
$A0:99E8 CE A6 18    DEC $18A6  [$7E:18A6]  ;\
$A0:99EB CE A6 18    DEC $18A6  [$7E:18A6]  ;} Enemy projectile index -= 2
$A0:99EE AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:99F1 30 03       BMI $03    [$99F6]     ;} If [enemy projectile index] >= 0:
$A0:99F3 4C 8A 99    JMP $998A  [$A0:998A]  ; Go to LOOP_ENEMY_PROJECTILE

$A0:99F6 AB          PLB
$A0:99F7 28          PLP
$A0:99F8 6B          RTL
}


;;; $99F9: Handle enemy projectile collision with projectile ;;;
{
;; Parameters:
;;     X: Enemy projectile index
;;     Y: Projectile index

; Caller assumes X and Y are unmodified by this routine

; Code at $9A3D for creating the dud shot graphics uses the wrong index register for the projectile position,
; meaning the sprite object usually doesn't appear (used for fire arc and Botwoon)

; Why does getting shot mask off all the property bits?
; The first ASM instructions of the shot instruction list *are* executed in time to disable Samus collision before the next check,
; but the low priority is applied for drawing this frame

$A0:99F9 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:99FC 89 08 00    BIT #$0008             ;} If projectile is not plasma beam:
$A0:99FF D0 09       BNE $09    [$9A0A]     ;/
$A0:9A01 B9 04 0C    LDA $0C04,y[$7E:0C04]  ;\
$A0:9A04 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:9A07 99 04 0C    STA $0C04,y[$7E:0C04]  ;/

$A0:9A0A BF 80 F3 7E LDA $7EF380,x[$7E:F396];\
$A0:9A0E C9 01 00    CMP #$0001             ;} If enemy projectile buggy dud shot enabled: go to BRANCH_BUGGY_DUD_SHOT
$A0:9A11 F0 2A       BEQ $2A    [$9A3D]     ;/
$A0:9A13 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:9A16 5A          PHY                    ;|
$A0:9A17 9B          TXY                    ;} Enemy projectile collided projectile type = [projectile type]
$A0:9A18 99 FB 1B    STA $1BFB,y[$7E:1C11]  ;/
$A0:9A1B BE 97 19    LDX $1997,y[$7E:19AD]  ;\
$A0:9A1E BF 0C 00 86 LDA $86000C,x[$86:AD6A];} Enemy projectile instruction list pointer = (enemy projectile shot instruction list)
$A0:9A22 99 47 1B    STA $1B47,y[$7E:1B5D]  ;/
$A0:9A25 A9 01 00    LDA #$0001             ;\
$A0:9A28 99 8F 1B    STA $1B8F,y[$7E:1BA5]  ;} Enemy projectile instruction timer = 1
$A0:9A2B A9 FB 84    LDA #$84FB             ;\
$A0:9A2E 99 03 1A    STA $1A03,y[$7E:1A19]  ;} Enemy projectile pre-instruction = RTS
$A0:9A31 B9 D7 1B    LDA $1BD7,y[$7E:1BED]  ;\
$A0:9A34 29 FF 0F    AND #$0FFF             ;} Enemy projectile properties &= FFFh (don't detect collision with projectiles, die on contact, enable collisions with Samus, low priority)
$A0:9A37 99 D7 1B    STA $1BD7,y[$7E:1BED]  ;/
$A0:9A3A BB          TYX
$A0:9A3B 7A          PLY
$A0:9A3C 60          RTS                    ; Return

; BRANCH_BUGGY_DUD_SHOT
$A0:9A3D BD 64 0B    LDA $0B64,x[$7E:0B86]  ;\
$A0:9A40 85 12       STA $12    [$7E:0012]  ;|
$A0:9A42 BD 78 0B    LDA $0B78,x[$7E:0B9A]  ;|
$A0:9A45 85 14       STA $14    [$7E:0014]  ;|
$A0:9A47 A9 06 00    LDA #$0006             ;} Create sprite object 6 (dud shot) at projectile [enemy projectile index] position >_<;
$A0:9A4A 85 16       STA $16    [$7E:0016]  ;|
$A0:9A4C 64 18       STZ $18    [$7E:0018]  ;|
$A0:9A4E 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A0:9A52 A9 3D 00    LDA #$003D             ;\
$A0:9A55 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Dh, sound library 1, max queued sounds allowed = 6 (dud shot)
$A0:9A59 60          RTS
}


;;; $9A5A: Enemy / Samus collision handling - extended spritemap ;;;
{
; This routine disables Samus' invincibility if she is using blue suit or screw attack (unless there are no tangible enemies)
$A0:9A5A 8B          PHB
$A0:9A5B AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9A5E BD A6 0F    LDA $0FA6,x[$7E:0FA6]  ;\
$A0:9A61 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:9A64 EB          XBA                    ;\
$A0:9A65 48          PHA                    ;|
$A0:9A66 AB          PLB                    ;} DB = [enemy bank]
$A0:9A67 AB          PLB                    ;/
$A0:9A68 A9 06 00    LDA #$0006             ;\
$A0:9A6B 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 6
$A0:9A6F AC 54 0E    LDY $0E54  [$7E:0E54]  ;\
$A0:9A72 B9 8E 0F    LDA $0F8E,y[$7E:0F8E]  ;} If [enemy spritemap pointer] = 0: return
$A0:9A75 F0 12       BEQ $12    [$9A89]     ;/
$A0:9A77 BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:9A7A AA          TAX                    ;|
$A0:9A7B BF 30 00 A0 LDA $A00030,x[$A0:E16F];|
$A0:9A7F C9 4C 80    CMP #$804C             ;} If (enemy touch) = $804B/$804C:
$A0:9A82 F0 05       BEQ $05    [$9A89]     ;|
$A0:9A84 C9 4B 80    CMP #$804B             ;|
$A0:9A87 D0 02       BNE $02    [$9A8B]     ;/
$A0:9A89 AB          PLB
$A0:9A8A 60          RTS                    ; Return

$A0:9A8B AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A0:9A8E F0 05       BEQ $05    [$9A95]     ;} If [Samus contact damage index] != normal:
$A0:9A90 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$A0:9A93 80 05       BRA $05    [$9A9A]

$A0:9A95 AD A8 18    LDA $18A8  [$7E:18A8]  ;\ Else ([Samus contact damage index] = normal):
$A0:9A98 D0 EF       BNE $EF    [$9A89]     ;} If [Samus invincibility timer] != 0: return

$A0:9A9A AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9A9D BD 8E 0F    LDA $0F8E,x[$7E:0F8E]  ;|
$A0:9AA0 C9 00 80    CMP #$8000             ;} If [enemy spritemap pointer] < $8000: return
$A0:9AA3 30 E4       BMI $E4    [$9A89]     ;/
$A0:9AA5 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:9AA8 18          CLC                    ;|
$A0:9AA9 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;} Samus right boundary = [Samus X position] + [Samus X radius]
$A0:9AAC 8D 7E 18    STA $187E  [$7E:187E]  ;/
$A0:9AAF AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:9AB2 38          SEC                    ;|
$A0:9AB3 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;} Samus left boundary = [Samus X position] - [Samus X radius]
$A0:9AB6 8D 80 18    STA $1880  [$7E:1880]  ;/
$A0:9AB9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:9ABC 18          CLC                    ;|
$A0:9ABD 6D 00 0B    ADC $0B00  [$7E:0B00]  ;} Samus bottom boundary = [Samus Y position] + [Samus Y radius]
$A0:9AC0 8D 82 18    STA $1882  [$7E:1882]  ;/
$A0:9AC3 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:9AC6 38          SEC                    ;|
$A0:9AC7 ED 00 0B    SBC $0B00  [$7E:0B00]  ;} Samus top boundary = [Samus Y position] - [Samus Y radius]
$A0:9ACA 8D 84 18    STA $1884  [$7E:1884]  ;/
$A0:9ACD BD 8E 0F    LDA $0F8E,x[$7E:0F8E]  ;\
$A0:9AD0 AA          TAX                    ;|
$A0:9AD1 BD 00 00    LDA $0000,x[$A6:E983]  ;} Number of remaining enemy spritemap entries = [[enemy spritemap pointer]]
$A0:9AD4 29 FF 00    AND #$00FF             ;|
$A0:9AD7 8D 0B 06    STA $060B  [$7E:060B]  ;/
$A0:9ADA E8          INX                    ;\
$A0:9ADB E8          INX                    ;} Enemy spritemap entry pointer = [enemy spritemap pointer] + 2
$A0:9ADC 8E 6E 18    STX $186E  [$7E:186E]  ;/

; LOOP_SPRITEMAP_ENTRIES
$A0:9ADF AE 6E 18    LDX $186E  [$7E:186E]  ;\
$A0:9AE2 AC 54 0E    LDY $0E54  [$7E:0E54]  ;|
$A0:9AE5 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;|
$A0:9AE8 18          CLC                    ;} Enemy spritemap entry X position = [enemy X position] + [enemy spritemap entry X offset]
$A0:9AE9 7D 00 00    ADC $0000,x[$A6:E985]  ;|
$A0:9AEC 8D 7A 18    STA $187A  [$7E:187A]  ;/
$A0:9AEF B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;\
$A0:9AF2 18          CLC                    ;|
$A0:9AF3 7D 02 00    ADC $0002,x[$A6:E987]  ;} Enemy spritemap entry Y position = [enemy Y position] + [enemy spritemap entry Y offset]
$A0:9AF6 8D 7C 18    STA $187C  [$7E:187C]  ;/
$A0:9AF9 BD 06 00    LDA $0006,x[$A6:E98B]  ;\
$A0:9AFC AA          TAX                    ;|
$A0:9AFD BD 00 00    LDA $0000,x[$A6:EB2F]  ;} If [number of enemy spritemap entry hitbox entries] = 0: go to BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9B00 F0 64       BEQ $64    [$9B66]     ;/
$A0:9B02 8D 0D 06    STA $060D  [$7E:060D]  ; Number of remaining enemy hitbox entries = [number of enemy spritemap entry hitbox entries]
$A0:9B05 E8          INX                    ;\
$A0:9B06 E8          INX                    ;} Enemy hitbox entry pointer = [enemy spritemap entry hitbox pointer] + 2
$A0:9B07 8E 78 18    STX $1878  [$7E:1878]  ;/

; LOOP_HITBOXES
$A0:9B0A AE 78 18    LDX $1878  [$7E:1878]  ;\
$A0:9B0D AD 7A 18    LDA $187A  [$7E:187A]  ;|
$A0:9B10 18          CLC                    ;|
$A0:9B11 7D 00 00    ADC $0000,x[$A6:EB31]  ;} If [enemy spritemap entry X position] + [enemy hitbox entry left offset] >= [Samus right boundary]: go to BRANCH_NEXT_HITBOX_ENTRY
$A0:9B14 CD 7E 18    CMP $187E  [$7E:187E]  ;|
$A0:9B17 10 36       BPL $36    [$9B4F]     ;/
$A0:9B19 AD 7A 18    LDA $187A  [$7E:187A]  ;\
$A0:9B1C 18          CLC                    ;|
$A0:9B1D 7D 04 00    ADC $0004,x[$A6:EB35]  ;} If [enemy spritemap entry X position] + [enemy hitbox entry right offset] < [Samus left boundary]: go to BRANCH_NEXT_HITBOX_ENTRY
$A0:9B20 CD 80 18    CMP $1880  [$7E:1880]  ;|
$A0:9B23 30 2A       BMI $2A    [$9B4F]     ;/
$A0:9B25 AD 7C 18    LDA $187C  [$7E:187C]  ;\
$A0:9B28 18          CLC                    ;|
$A0:9B29 7D 02 00    ADC $0002,x[$A6:F298]  ;} If [enemy spritemap entry Y position] + [enemy hitbox entry top offset] >= [Samus bottom boundary]: go to BRANCH_NEXT_HITBOX_ENTRY
$A0:9B2C CD 82 18    CMP $1882  [$7E:1882]  ;|
$A0:9B2F 10 1E       BPL $1E    [$9B4F]     ;/
$A0:9B31 AD 7C 18    LDA $187C  [$7E:187C]  ;\
$A0:9B34 18          CLC                    ;|
$A0:9B35 7D 06 00    ADC $0006,x[$A6:F29C]  ;} If [enemy spritemap entry Y position] + [enemy hitbox entry bottom offset] < [Samus top boundary]: go to BRANCH_NEXT_HITBOX_ENTRY
$A0:9B38 CD 84 18    CMP $1884  [$7E:1884]  ;|
$A0:9B3B 30 12       BMI $12    [$9B4F]     ;/
$A0:9B3D 22 43 9B A0 JSL $A09B43[$A0:9B43]  ; Execute [enemy hitbox entry Samus collision pointer]
$A0:9B41 80 3A       BRA $3A    [$9B7D]     ; Return

$A0:9B43 AE 78 18    LDX $1878  [$7E:1878]
$A0:9B46 BD 08 00    LDA $0008,x[$A6:F29E]
$A0:9B49 8D 84 17    STA $1784  [$7E:1784]
$A0:9B4C DC 84 17    JML [$1784][$A6:F03F]

; BRANCH_NEXT_HITBOX_ENTRY
$A0:9B4F AD 78 18    LDA $1878  [$7E:1878]  ;\
$A0:9B52 18          CLC                    ;|
$A0:9B53 69 0C 00    ADC #$000C             ;} Enemy hitbox entry pointer += Ch
$A0:9B56 8D 78 18    STA $1878  [$7E:1878]  ;/
$A0:9B59 CE 0D 06    DEC $060D  [$7E:060D]  ; Decrement number of remaining enemy hitbox entries
$A0:9B5C AD 0D 06    LDA $060D  [$7E:060D]  ;\
$A0:9B5F F0 05       BEQ $05    [$9B66]     ;} If [number of remaining enemy hitbox entries] <= 0: go to BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9B61 30 03       BMI $03    [$9B66]     ;/
$A0:9B63 4C 0A 9B    JMP $9B0A  [$A0:9B0A]  ; Go to LOOP_HITBOXES

; BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9B66 AD 6E 18    LDA $186E  [$7E:186E]  ;\
$A0:9B69 18          CLC                    ;|
$A0:9B6A 69 08 00    ADC #$0008             ;} Enemy spritemap entry pointer += 8
$A0:9B6D 8D 6E 18    STA $186E  [$7E:186E]  ;/
$A0:9B70 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement number of remaining enemy spritemap entries
$A0:9B73 AD 0B 06    LDA $060B  [$7E:060B]  ;\
$A0:9B76 F0 05       BEQ $05    [$9B7D]     ;} If [number of remaining enemy spritemap entries] <= 0: return
$A0:9B78 30 03       BMI $03    [$9B7D]     ;/
$A0:9B7A 4C DF 9A    JMP $9ADF  [$A0:9ADF]  ; Go to LOOP_SPRITEMAP_ENTRIES

$A0:9B7D AB          PLB
$A0:9B7E 60          RTS
}


;;; $9B7F: Enemy / projectile collision handling - extended spritemap ;;;
{
$A0:9B7F 8B          PHB
$A0:9B80 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9B83 BD A6 0F    LDA $0FA6,x[$7E:0FA6]  ;\
$A0:9B86 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:9B89 EB          XBA                    ;\
$A0:9B8A 48          PHA                    ;|
$A0:9B8B AB          PLB                    ;} DB = [enemy bank]
$A0:9B8C AB          PLB                    ;/
$A0:9B8D A9 03 00    LDA #$0003             ;\
$A0:9B90 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 3
$A0:9B94 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$A0:9B97 D0 02       BNE $02    [$9B9B]     ;} If [projectile counter] = 0:
$A0:9B99 AB          PLB
$A0:9B9A 60          RTS                    ; Return

$A0:9B9B 8D 0F 06    STA $060F  [$7E:060F]  ; $060F = [projectile counter] (never read)
$A0:9B9E AC 54 0E    LDY $0E54  [$7E:0E54]  ;\
$A0:9BA1 B9 8E 0F    LDA $0F8E,y[$7E:0F8E]  ;} If [enemy spritemap pointer] = 0: return
$A0:9BA4 F0 16       BEQ $16    [$9BBC]     ;/
$A0:9BA6 C9 4F 80    CMP #$804F             ;\
$A0:9BA9 F0 11       BEQ $11    [$9BBC]     ;} If [enemy spritemap pointer] = $804F: return
$A0:9BAB BE 78 0F    LDX $0F78,y[$7E:0F78]  ;\
$A0:9BAE BF 32 00 A0 LDA $A00032,x[$A0:F685];|
$A0:9BB2 C9 4C 80    CMP #$804C             ;|
$A0:9BB5 F0 05       BEQ $05    [$9BBC]     ;} If (enemy shot) = $804B/$804C:
$A0:9BB7 C9 4B 80    CMP #$804B             ;|
$A0:9BBA D0 02       BNE $02    [$9BBE]     ;/

$A0:9BBC AB          PLB
$A0:9BBD 60          RTS                    ; Return

$A0:9BBE AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9BC1 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;|
$A0:9BC4 89 00 04    BIT #$0400             ;} If enemy is intangible: return
$A0:9BC7 D0 F3       BNE $F3    [$9BBC]     ;/
$A0:9BC9 BD A0 0F    LDA $0FA0,x[$7E:0FA0]  ;\
$A0:9BCC D0 EE       BNE $EE    [$9BBC]     ;} If [enemy invincibility timer] != 0: return
$A0:9BCE BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:9BD1 C9 FF DA    CMP #$DAFF             ;} If respawning enemy placeholder: return
$A0:9BD4 F0 E6       BEQ $E6    [$9BBC]     ;/
$A0:9BD6 9C A6 18    STZ $18A6  [$7E:18A6]  ; Projectile index = 0

; LOOP_PROJECTILES
$A0:9BD9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9BDC AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:9BDF 0A          ASL A                  ;|
$A0:9BE0 A8          TAY                    ;} If [projectile type] = 0: go to BRANCH_NEXT_PROJECTILE
$A0:9BE1 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;|
$A0:9BE4 F0 12       BEQ $12    [$9BF8]     ;/
$A0:9BE6 29 00 0F    AND #$0F00             ;\
$A0:9BE9 C9 00 03    CMP #$0300             ;} If projectile is not power bomb:
$A0:9BEC F0 0A       BEQ $0A    [$9BF8]     ;/
$A0:9BEE C9 00 05    CMP #$0500             ;\
$A0:9BF1 F0 05       BEQ $05    [$9BF8]     ;} If projectile is not bomb:
$A0:9BF3 C9 00 07    CMP #$0700             ;\
$A0:9BF6 30 03       BMI $03    [$9BFB]     ;} If projectile is not projectile explosion: go to BRANCH_VALID_PROJECTILE

$A0:9BF8 4C 07 9D    JMP $9D07  [$A0:9D07]  ; Go to BRANCH_NEXT_PROJECTILE

; BRANCH_VALID_PROJECTILE
$A0:9BFB AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9BFE BD 8E 0F    LDA $0F8E,x[$7E:0F8E]  ;\
$A0:9C01 C9 00 80    CMP #$8000             ;|
                                            ;} If [enemy spritemap pointer] < $8000: crash
$A0:9C04 30 FE       BMI $FE    [$9C04]     ;/
$A0:9C06 AA          TAX                    ;\
$A0:9C07 BD 00 00    LDA $0000,x[$B2:8B1A]  ;|
$A0:9C0A 29 FF 00    AND #$00FF             ;} Number of remaining enemy spritemap entries = [[enemy spritemap pointer]]
$A0:9C0D 8D 0B 06    STA $060B  [$7E:060B]  ;/
$A0:9C10 E8          INX                    ;\
$A0:9C11 E8          INX                    ;} Enemy spritemap entry pointer = [enemy spritemap pointer] + 2
$A0:9C12 8E 6E 18    STX $186E  [$7E:186E]  ;/

; LOOP_SPRITEMAP_ENTRIES
$A0:9C15 AE 6E 18    LDX $186E  [$7E:186E]  ;\
$A0:9C18 AC 54 0E    LDY $0E54  [$7E:0E54]  ;|
$A0:9C1B B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;|
$A0:9C1E 18          CLC                    ;} Enemy spritemap entry X position = [enemy X position] + [enemy spritemap entry X offset]
$A0:9C1F 7D 00 00    ADC $0000,x[$B2:8B1C]  ;|
$A0:9C22 8D 7A 18    STA $187A  [$7E:187A]  ;/
$A0:9C25 B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;\
$A0:9C28 18          CLC                    ;|
$A0:9C29 7D 02 00    ADC $0002,x[$B2:8B1E]  ;} Enemy spritemap entry Y position = [enemy Y position] + [enemy spritemap entry Y offset]
$A0:9C2C 8D 7C 18    STA $187C  [$7E:187C]  ;/
$A0:9C2F BD 06 00    LDA $0006,x[$B2:8B22]  ;\
$A0:9C32 AA          TAX                    ;|
$A0:9C33 BD 00 00    LDA $0000,x[$B2:9D88]  ;} If [number of enemy spritemap entry hitbox entries] = 0:
$A0:9C36 D0 03       BNE $03    [$9C3B]     ;/
$A0:9C38 4C F3 9C    JMP $9CF3  [$A0:9CF3]  ; Go to BRANCH_NEXT_SPRITEMAP_ENTRY

$A0:9C3B 8D 0D 06    STA $060D  [$7E:060D]  ; Number of remaining enemy hitbox entries = [number of enemy spritemap entry hitbox entries]
$A0:9C3E E8          INX                    ;\
$A0:9C3F E8          INX                    ;} Enemy hitbox entry pointer = [enemy spritemap entry hitbox pointer] + 2
$A0:9C40 8E 78 18    STX $1878  [$7E:1878]  ;/

; LOOP_HITBOXES
$A0:9C43 AE 78 18    LDX $1878  [$7E:1878]  ; X = [enemy hitbox entry pointer]
$A0:9C46 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:9C49 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:9C4A A8          TAY                    ;/
$A0:9C4B BD 00 00    LDA $0000,x[$B2:9D8A]  ;\
$A0:9C4E 18          CLC                    ;|
$A0:9C4F 6D 7A 18    ADC $187A  [$7E:187A]  ;} Enemy left boundary = [enemy spritemap entry X position] + [enemy hitbox entry left offset]
$A0:9C52 8D 70 18    STA $1870  [$7E:1870]  ;/
$A0:9C55 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$A0:9C58 18          CLC                    ;|
$A0:9C59 79 B4 0B    ADC $0BB4,y[$7E:0BB4]  ;} If [projectile X position] + [projectile X radius] < [enemy left boundary]:
$A0:9C5C CD 70 18    CMP $1870  [$7E:1870]  ;|
$A0:9C5F 10 03       BPL $03    [$9C64]     ;/
$A0:9C61 4C DF 9C    JMP $9CDF  [$A0:9CDF]  ; Go to BRANCH_NEXT_HITBOX

$A0:9C64 BD 04 00    LDA $0004,x[$B2:9D8E]  ;\
$A0:9C67 18          CLC                    ;|
$A0:9C68 6D 7A 18    ADC $187A  [$7E:187A]  ;} Enemy right boundary = [enemy spritemap entry X position] + [enemy hitbox entry right offset]
$A0:9C6B 8D 74 18    STA $1874  [$7E:1874]  ;/
$A0:9C6E B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$A0:9C71 38          SEC                    ;|
$A0:9C72 F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;} If [projectile X position] - [projectile X radius] >= [enemy right boundary]:
$A0:9C75 CD 74 18    CMP $1874  [$7E:1874]  ;|
$A0:9C78 10 65       BPL $65    [$9CDF]     ;/
$A0:9C7A BD 02 00    LDA $0002,x[$B2:97C8]  ;\
$A0:9C7D 18          CLC                    ;|
$A0:9C7E 6D 7C 18    ADC $187C  [$7E:187C]  ;} Enemy bottom boundary = [enemy spritemap entry Y position] + [enemy hitbox entry bottom offset]
$A0:9C81 8D 72 18    STA $1872  [$7E:1872]  ;/
$A0:9C84 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$A0:9C87 18          CLC                    ;|
$A0:9C88 79 C8 0B    ADC $0BC8,y[$7E:0BC8]  ;} If [projectile Y position] + [projectile Y radius] < [enemy bottom boundary]:
$A0:9C8B CD 72 18    CMP $1872  [$7E:1872]  ;|
$A0:9C8E 30 4F       BMI $4F    [$9CDF]     ;/
$A0:9C90 BD 06 00    LDA $0006,x[$B2:97CC]  ;\
$A0:9C93 18          CLC                    ;|
$A0:9C94 6D 7C 18    ADC $187C  [$7E:187C]  ;} Enemy top boundary = [enemy spritemap entry Y position] + [enemy hitbox entry top offset]
$A0:9C97 8D 76 18    STA $1876  [$7E:1876]  ;/
$A0:9C9A B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$A0:9C9D 38          SEC                    ;|
$A0:9C9E F9 C8 0B    SBC $0BC8,y[$7E:0BC8]  ;} If [projectile Y position] - [projectile Y radius] < [enemy top boundary]:
$A0:9CA1 CD 76 18    CMP $1876  [$7E:1876]  ;|
$A0:9CA4 10 39       BPL $39    [$9CDF]     ;/
$A0:9CA6 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:9CA9 29 00 0F    AND #$0F00             ;|
$A0:9CAC C9 00 02    CMP #$0200             ;} If projectile is super missile:
$A0:9CAF D0 0C       BNE $0C    [$9CBD]     ;/
$A0:9CB1 A9 1E 00    LDA #$001E             ;\
$A0:9CB4 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 30
$A0:9CB7 A9 12 00    LDA #$0012             ;\
$A0:9CBA 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 1 pixel displacement, horizontal

$A0:9CBD AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9CC0 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;|
$A0:9CC3 89 00 10    BIT #$1000             ;} If enemy doesn't block plasma beam:
$A0:9CC6 D0 08       BNE $08    [$9CD0]     ;/
$A0:9CC8 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:9CCB 29 08 00    AND #$0008             ;} If projectile is plasma beam: go to BRANCH_NO_DELETE
$A0:9CCE D0 09       BNE $09    [$9CD9]     ;/

$A0:9CD0 B9 04 0C    LDA $0C04,y[$7E:0C04]  ;\
$A0:9CD3 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:9CD6 99 04 0C    STA $0C04,y[$7E:0C04]  ;/

; BRANCH_NO_DELETE
$A0:9CD9 22 17 9D A0 JSL $A09D17[$A0:9D17]  ; Execute [enemy hitbox entry projectile collision pointer]
$A0:9CDD 80 36       BRA $36    [$9D15]     ; Return

; BRANCH_NEXT_HITBOX
$A0:9CDF AD 78 18    LDA $1878  [$7E:1878]  ;\
$A0:9CE2 18          CLC                    ;|
$A0:9CE3 69 0C 00    ADC #$000C             ;} Enemy hitbox entry pointer += Ch
$A0:9CE6 8D 78 18    STA $1878  [$7E:1878]  ;/
$A0:9CE9 CE 0D 06    DEC $060D  [$7E:060D]  ; Decrement number of remaining enemy hitbox entries
$A0:9CEC F0 05       BEQ $05    [$9CF3]     ;\
$A0:9CEE 30 03       BMI $03    [$9CF3]     ;} If [number of remaining enemy hitbox entries] <= 0: go to BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9CF0 4C 43 9C    JMP $9C43  [$A0:9C43]  ; Go to LOOP_HITBOXES

; BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9CF3 AD 6E 18    LDA $186E  [$7E:186E]  ;\
$A0:9CF6 18          CLC                    ;|
$A0:9CF7 69 08 00    ADC #$0008             ;} Enemy spritemap entry pointer += 8
$A0:9CFA 8D 6E 18    STA $186E  [$7E:186E]  ;/
$A0:9CFD CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement number of remaining enemy spritemap entries
$A0:9D00 F0 05       BEQ $05    [$9D07]     ;\
$A0:9D02 30 03       BMI $03    [$9D07]     ;} If [number of remaining enemy spritemap entries] <= 0: return
$A0:9D04 4C 15 9C    JMP $9C15  [$A0:9C15]  ; Go to LOOP_SPRITEMAP_ENTRIES

; BRANCH_NEXT_PROJECTILE
$A0:9D07 EE A6 18    INC $18A6  [$7E:18A6]  ; Increment projectile index
$A0:9D0A AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:9D0D C9 05 00    CMP #$0005             ;} If [projectile index] >= 5: return
$A0:9D10 10 03       BPL $03    [$9D15]     ;/
$A0:9D12 4C D9 9B    JMP $9BD9  [$A0:9BD9]  ; Go to LOOP_PROJECTILES

$A0:9D15 AB          PLB
$A0:9D16 60          RTS

$A0:9D17 AE 78 18    LDX $1878  [$7E:1878]
$A0:9D1A BD 0A 00    LDA $000A,x[$B2:97C2]
$A0:9D1D 8D 84 17    STA $1784  [$7E:1784]
$A0:9D20 DC 84 17    JML [$1784][$B2:8779]
}


;;; $9D23: Enemy / bomb collision handling - extended spritemap ;;;
{
; I don't really see any reason why this routine should be separate from $9B7F
$A0:9D23 8B          PHB
$A0:9D24 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9D27 BD A6 0F    LDA $0FA6,x[$7E:0FA6]  ;\
$A0:9D2A 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:9D2D EB          XBA                    ;\
$A0:9D2E 48          PHA                    ;|
$A0:9D2F AB          PLB                    ;} DB = [enemy bank]
$A0:9D30 AB          PLB                    ;/
$A0:9D31 A9 04 00    LDA #$0004             ;\
$A0:9D34 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 4
$A0:9D38 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:9D3B B9 8E 0F    LDA $0F8E,y[$7E:0F8E]  ;\
$A0:9D3E F0 24       BEQ $24    [$9D64]     ;} If [enemy spritemap pointer] = 0: return
$A0:9D40 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9D43 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A0:9D46 89 00 04    BIT #$0400             ;} If enemy is intangible: return
$A0:9D49 D0 19       BNE $19    [$9D64]     ;/
$A0:9D4B BD A0 0F    LDA $0FA0,x[$7E:0FA0]  ;\
$A0:9D4E D0 14       BNE $14    [$9D64]     ;} If [enemy invincibility timer] != 0: return
$A0:9D50 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:9D53 BE 78 0F    LDX $0F78,y[$7E:0F78]  ;\
$A0:9D56 BF 32 00 A0 LDA $A00032,x[$A0:E171];|
$A0:9D5A C9 4C 80    CMP #$804C             ;|
$A0:9D5D F0 05       BEQ $05    [$9D64]     ;} If [enemy shot] = $804B/$804C:
$A0:9D5F C9 4B 80    CMP #$804B             ;|
$A0:9D62 D0 02       BNE $02    [$9D66]     ;/

$A0:9D64 AB          PLB
$A0:9D65 60          RTS                    ; Return

$A0:9D66 AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$A0:9D69 F0 F9       BEQ $F9    [$9D64]     ;} If [bomb counter] = 0: return
$A0:9D6B A9 05 00    LDA #$0005             ;\
$A0:9D6E 8D A6 18    STA $18A6  [$7E:18A6]  ;} Projectile index = 5

; LOOP_PROJECTILES
$A0:9D71 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9D74 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:9D77 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:9D78 A8          TAY                    ;/
$A0:9D79 B9 64 0B    LDA $0B64,y[$7E:0B6E]  ;\
$A0:9D7C D0 03       BNE $03    [$9D81]     ;} If [projectile X position] = 0:
$A0:9D7E 4C 7E 9E    JMP $9E7E  [$A0:9E7E]  ; Go to BRANCH_NEXT_PROJECTILE

$A0:9D81 B9 18 0C    LDA $0C18,y[$7E:0C22]  ;\
$A0:9D84 F0 08       BEQ $08    [$9D8E]     ;} If [projectile type] = 0: go to BRANCH_NEXT_PROJECTILE
$A0:9D86 29 00 0F    AND #$0F00             ;\
$A0:9D89 C9 00 05    CMP #$0500             ;} If a bomb: go to BRANCH_BOMB
$A0:9D8C F0 03       BEQ $03    [$9D91]     ;/

$A0:9D8E 4C 7E 9E    JMP $9E7E  [$A0:9E7E]  ; Go to BRANCH_NEXT_PROJECTILE

; BRANCH_BOMB
$A0:9D91 B9 7C 0C    LDA $0C7C,y[$7E:0C86]  ;\
$A0:9D94 F0 03       BEQ $03    [$9D99]     ;} If [bomb timer] != 0:
$A0:9D96 4C 7E 9E    JMP $9E7E  [$A0:9E7E]  ; Go to BRANCH_NEXT_PROJECTILE

$A0:9D99 BD 8E 0F    LDA $0F8E,x[$7E:114E]  ;\
$A0:9D9C C9 00 80    CMP #$8000             ;|
                                            ;} If [enemy spritemap pointer] < $8000: crash
$A0:9D9F 30 FE       BMI $FE    [$9D9F]     ;/
$A0:9DA1 AA          TAX                    ;\
$A0:9DA2 BD 00 00    LDA $0000,x[$B2:88D6]  ;|
$A0:9DA5 29 FF 00    AND #$00FF             ;} Number of remaining enemy spritemap entries = [[enemy spritemap pointer]]
$A0:9DA8 8D 0B 06    STA $060B  [$7E:060B]  ;/
$A0:9DAB E8          INX                    ;\
$A0:9DAC E8          INX                    ;} Enemy spritemap entry pointer = [enemy spritemap pointer] + 2
$A0:9DAD 8E 6E 18    STX $186E  [$7E:186E]  ;/

; LOOP_SPRITEMAP_ENTRIES
$A0:9DB0 AE 6E 18    LDX $186E  [$7E:186E]  ;\
$A0:9DB3 AC 54 0E    LDY $0E54  [$7E:0E54]  ;|
$A0:9DB6 B9 7A 0F    LDA $0F7A,y[$7E:113A]  ;|
$A0:9DB9 18          CLC                    ;} Enemy spritemap entry X position = [enemy X position] + [enemy spritemap entry X offset]
$A0:9DBA 7D 00 00    ADC $0000,x[$B2:88D8]  ;|
$A0:9DBD 8D 7A 18    STA $187A  [$7E:187A]  ;/
$A0:9DC0 B9 7E 0F    LDA $0F7E,y[$7E:113E]  ;\
$A0:9DC3 18          CLC                    ;|
$A0:9DC4 7D 02 00    ADC $0002,x[$B2:88DA]  ;} Enemy spritemap entry Y position = [enemy Y position] + [enemy spritemap entry Y offset]
$A0:9DC7 8D 7C 18    STA $187C  [$7E:187C]  ;/
$A0:9DCA BD 06 00    LDA $0006,x[$B2:88DE]  ;\
$A0:9DCD AA          TAX                    ;|
$A0:9DCE BD 00 00    LDA $0000,x[$B2:96BA]  ;} If [number of enemy spritemap entry hitbox entries] = 0:
$A0:9DD1 D0 03       BNE $03    [$9DD6]     ;/
$A0:9DD3 4C 67 9E    JMP $9E67  [$A0:9E67]  ; Go to BRANCH_NEXT_SPRITEMAP_ENTRY

$A0:9DD6 8D 0D 06    STA $060D  [$7E:060D]  ; Number of remaining enemy hitbox entries = [number of enemy spritemap entry hitbox entries]
$A0:9DD9 E8          INX                    ;\
$A0:9DDA E8          INX                    ;} Enemy hitbox entry pointer = [enemy spritemap entry hitbox pointer] + 2
$A0:9DDB 8E 78 18    STX $1878  [$7E:1878]  ;/

; LOOP_HITBOXES
$A0:9DDE AE 78 18    LDX $1878  [$7E:1878]  ; X = [enemy hitbox entry pointer]
$A0:9DE1 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:9DE4 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:9DE5 A8          TAY                    ;/
$A0:9DE6 BD 00 00    LDA $0000,x[$B2:96BC]  ;\
$A0:9DE9 18          CLC                    ;|
$A0:9DEA 6D 7A 18    ADC $187A  [$7E:187A]  ;} Enemy left boundary = [enemy spritemap entry X position] + [enemy hitbox entry left offset]
$A0:9DED 8D 70 18    STA $1870  [$7E:1870]  ;/
$A0:9DF0 B9 64 0B    LDA $0B64,y[$7E:0B6E]  ;\
$A0:9DF3 18          CLC                    ;|
$A0:9DF4 79 B4 0B    ADC $0BB4,y[$7E:0BBE]  ;} If [projectile X position] + [projectile X radius] < [enemy left boundary]:
$A0:9DF7 CD 70 18    CMP $1870  [$7E:1870]  ;|
$A0:9DFA 10 03       BPL $03    [$9DFF]     ;/
$A0:9DFC 4C 50 9E    JMP $9E50  [$A0:9E50]  ; Go to BRANCH_NEXT_HITBOX

$A0:9DFF BD 04 00    LDA $0004,x[$B2:96C0]  ;\
$A0:9E02 18          CLC                    ;|
$A0:9E03 6D 7A 18    ADC $187A  [$7E:187A]  ;} Enemy right boundary = [enemy spritemap entry X position] + [enemy hitbox entry right offset]
$A0:9E06 8D 74 18    STA $1874  [$7E:1874]  ;/
$A0:9E09 B9 64 0B    LDA $0B64,y[$7E:0B6E]  ;\
$A0:9E0C 38          SEC                    ;|
$A0:9E0D F9 B4 0B    SBC $0BB4,y[$7E:0BBE]  ;} If [projectile X position] - [projectile X radius] >= [enemy right boundary]:
$A0:9E10 CD 74 18    CMP $1874  [$7E:1874]  ;|
$A0:9E13 10 3B       BPL $3B    [$9E50]     ;/
$A0:9E15 BD 02 00    LDA $0002,x            ;\
$A0:9E18 18          CLC                    ;|
$A0:9E19 6D 7C 18    ADC $187C  [$7E:187C]  ;} Enemy bottom boundary = [enemy spritemap entry Y position] + [enemy hitbox entry bottom offset]
$A0:9E1C 8D 72 18    STA $1872  [$7E:1872]  ;/
$A0:9E1F B9 78 0B    LDA $0B78,y            ;\
$A0:9E22 18          CLC                    ;|
$A0:9E23 79 C8 0B    ADC $0BC8,y            ;} If [projectile Y position] + [projectile Y radius] < [enemy bottom boundary]:
$A0:9E26 CD 72 18    CMP $1872  [$7E:1872]  ;|
$A0:9E29 30 25       BMI $25    [$9E50]     ;/
$A0:9E2B BD 06 00    LDA $0006,x            ;\
$A0:9E2E 18          CLC                    ;|
$A0:9E2F 6D 7C 18    ADC $187C  [$7E:187C]  ;} Enemy top boundary = [enemy spritemap entry Y position] + [enemy hitbox entry top offset]
$A0:9E32 8D 76 18    STA $1876  [$7E:1876]  ;/
$A0:9E35 B9 78 0B    LDA $0B78,y            ;\
$A0:9E38 38          SEC                    ;|
$A0:9E39 F9 C8 0B    SBC $0BC8,y            ;} If [projectile Y position] - [projectile Y radius] < [enemy top boundary]:
$A0:9E3C CD 76 18    CMP $1876  [$7E:1876]  ;|
$A0:9E3F 10 0F       BPL $0F    [$9E50]     ;/
$A0:9E41 B9 04 0C    LDA $0C04,y            ;\
$A0:9E44 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:9E47 99 04 0C    STA $0C04,y            ;/
$A0:9E4A 22 8E 9E A0 JSL $A09E8E[$A0:9E8E]  ; Execute [enemy hitbox entry projectile collision pointer]
$A0:9E4E 80 3C       BRA $3C    [$9E8C]     ; Return

; BRANCH_NEXT_HITBOX
$A0:9E50 AD 78 18    LDA $1878  [$7E:1878]  ;\
$A0:9E53 18          CLC                    ;|
$A0:9E54 69 0C 00    ADC #$000C             ;} Enemy hitbox entry pointer += Ch
$A0:9E57 8D 78 18    STA $1878  [$7E:1878]  ;/
$A0:9E5A CE 0D 06    DEC $060D  [$7E:060D]  ; Decrement number of remaining enemy hitbox entries
$A0:9E5D AD 0D 06    LDA $060D  [$7E:060D]  ;\
$A0:9E60 F0 05       BEQ $05    [$9E67]     ;} If [number of remaining enemy hitbox entries] <= 0: go to BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9E62 30 03       BMI $03    [$9E67]     ;/
$A0:9E64 4C DE 9D    JMP $9DDE  [$A0:9DDE]  ; Go to LOOP_HITBOXES

; BRANCH_NEXT_SPRITEMAP_ENTRY
$A0:9E67 AD 6E 18    LDA $186E  [$7E:186E]  ;\
$A0:9E6A 18          CLC                    ;|
$A0:9E6B 69 08 00    ADC #$0008             ;} Enemy spritemap entry pointer += 8
$A0:9E6E 8D 6E 18    STA $186E  [$7E:186E]  ;/
$A0:9E71 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement number of remaining enemy spritemap entries
$A0:9E74 AD 0B 06    LDA $060B  [$7E:060B]  ;\
$A0:9E77 F0 05       BEQ $05    [$9E7E]     ;} If [number of remaining enemy spritemap entries] <= 0: go to BRANCH_NEXT_PROJECTILE
$A0:9E79 30 03       BMI $03    [$9E7E]     ;/
$A0:9E7B 4C B0 9D    JMP $9DB0  [$A0:9DB0]  ; Go to LOOP_SPRITEMAP_ENTRIES

; BRANCH_NEXT_PROJECTILE
$A0:9E7E EE A6 18    INC $18A6  [$7E:18A6]  ; Increment projectile index
$A0:9E81 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:9E84 C9 0A 00    CMP #$000A             ;} If [projectile index] = Ah: return
$A0:9E87 F0 03       BEQ $03    [$9E8C]     ;/
$A0:9E89 4C 71 9D    JMP $9D71  [$A0:9D71]  ; Go to LOOP_PROJECTILES

$A0:9E8C AB          PLB
$A0:9E8D 60          RTS

$A0:9E8E AE 78 18    LDX $1878  [$7E:1878]
$A0:9E91 BD 0A 00    LDA $000A,x
$A0:9E94 8D 84 17    STA $1784  [$7E:1784]
$A0:9E97 DC 84 17    JML [$1784]
}


;;; $9E9A: Enemy / grapple beam collision detection ;;;
{
;; Returns:
;;     A: Grapple reaction index
;;     {
;;         0: Otherwise
;;         1: Enemy grapple AI = $8005 - Samus latches on
;;         2: Enemy grapple AI = $800A - kill enemy
;;         3: Enemy grapple AI = $800F - cancel grapple beam
;;         4: Enemy grapple AI = $8014 - Samus latches on - no invincibility
;;         5: Enemy grapple AI = $8019 - Samus latches on - paralyse enemy
;;         6: Enemy grapple AI = $801E - hurt Samus
;;     }
;;     $12: Collided enemy ID if collision, otherwise 0

; Grapple reaction indices 1/4/5 set the grapple beam's end position to the enemy's position.
; Collision detection ignores the extended hitbox format

$A0:9E9A 8B          PHB
$A0:9E9B DA          PHX
$A0:9E9C 5A          PHY
$A0:9E9D A9 0D 00    LDA #$000D             ;\
$A0:9EA0 22 84 F0 90 JSL $90F084[$90:F084]  ;} If grapple beam is inactive:
$A0:9EA4 D0 03       BNE $03    [$9EA9]     ;/
$A0:9EA6 4C 44 9F    JMP $9F44  [$A0:9F44]  ; Go to BRANCH_GRAPPLE_INDEX_DETERMINED (fortunately this branch is never taken)

$A0:9EA9 9C A6 18    STZ $18A6  [$7E:18A6]  ; Collision index = 0 (never read)
$A0:9EAC 9C AA 17    STZ $17AA  [$7E:17AA]  ; Interactive enemy indices index = 0

; LOOP
$A0:9EAF AC AA 17    LDY $17AA  [$7E:17AA]  ;\
$A0:9EB2 B9 EC 17    LDA $17EC,y[$7E:17EC]  ;} Enemy index = [interactive enemy index]
$A0:9EB5 8D 54 0E    STA $0E54  [$7E:0E54]  ;/
$A0:9EB8 C9 FF FF    CMP #$FFFF             ;\
$A0:9EBB D0 09       BNE $09    [$9EC6]     ;} If [enemy index] = FFFFh:
$A0:9EBD 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A0:9EBF A9 00 00    LDA #$0000             ; A = 0
$A0:9EC2 7A          PLY
$A0:9EC3 FA          PLX
$A0:9EC4 AB          PLB
$A0:9EC5 6B          RTL                    ; Return

$A0:9EC6 AA          TAX                    ;\
$A0:9EC7 BD A0 0F    LDA $0FA0,x[$7E:0FA0]  ;} If [enemy invincibility timer] != 0: go to BRANCH_NEXT
$A0:9ECA D0 30       BNE $30    [$9EFC]     ;/
$A0:9ECC BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A0:9ECF 38          SEC                    ;|
$A0:9ED0 ED 08 0D    SBC $0D08  [$7E:0D08]  ;|
$A0:9ED3 10 04       BPL $04    [$9ED9]     ;|
$A0:9ED5 49 FF FF    EOR #$FFFF             ;|
$A0:9ED8 1A          INC A                  ;|
                                            ;} If |[enemy X position] - [grapple beam end X position]| - [enemy X radius] >= 8: go to BRANCH_NEXT
$A0:9ED9 38          SEC                    ;|
$A0:9EDA FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A0:9EDD 90 05       BCC $05    [$9EE4]     ;|
$A0:9EDF C9 08 00    CMP #$0008             ;|
$A0:9EE2 B0 18       BCS $18    [$9EFC]     ;/

$A0:9EE4 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A0:9EE7 38          SEC                    ;|
$A0:9EE8 ED 0C 0D    SBC $0D0C  [$7E:0D0C]  ;|
$A0:9EEB 10 04       BPL $04    [$9EF1]     ;|
$A0:9EED 49 FF FF    EOR #$FFFF             ;|
$A0:9EF0 1A          INC A                  ;|
                                            ;} If |[enemy Y position] - [grapple beam end Y position]| - [enemy Y radius] < 8: go to BRANCH_HIT
$A0:9EF1 38          SEC                    ;|
$A0:9EF2 FD 84 0F    SBC $0F84,x[$7E:0F84]  ;|
$A0:9EF5 90 0E       BCC $0E    [$9F05]     ;|
$A0:9EF7 C9 08 00    CMP #$0008             ;|
$A0:9EFA 90 09       BCC $09    [$9F05]     ;/

; BRANCH_NEXT
$A0:9EFC EE AA 17    INC $17AA  [$7E:17AA]  ;\
$A0:9EFF EE AA 17    INC $17AA  [$7E:17AA]  ;} Interactive enemy indices index += 2
$A0:9F02 4C AF 9E    JMP $9EAF  [$A0:9EAF]  ; Go to LOOP

; BRANCH_HIT
$A0:9F05 A9 01 00    LDA #$0001             ;\
$A0:9F08 9D 8A 0F    STA $0F8A,x[$7E:10CA]  ;} Enemy AI handler = grapple
$A0:9F0B A0 00 00    LDY #$0000             ; Y = 0
$A0:9F0E BD 78 0F    LDA $0F78,x[$7E:10B8]  ;\
$A0:9F11 AA          TAX                    ;|
$A0:9F12 BF 1A 00 A0 LDA $A0001A,x[$A0:D659];} If (enemy grapple AI) != $8000:
$A0:9F16 C9 00 80    CMP #$8000             ;|
$A0:9F19 F0 29       BEQ $29    [$9F44]     ;/
$A0:9F1B A0 01 00    LDY #$0001             ; Y = 1
$A0:9F1E C9 05 80    CMP #$8005             ;\
$A0:9F21 F0 21       BEQ $21    [$9F44]     ;} If (enemy grapple AI) = $8005: go to BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F23 C8          INY                    ; Y = 2
$A0:9F24 C9 0A 80    CMP #$800A             ;\
$A0:9F27 F0 1B       BEQ $1B    [$9F44]     ;} If (enemy grapple AI) = $800A: go to BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F29 C8          INY                    ; Y = 3
$A0:9F2A C9 0F 80    CMP #$800F             ;\
$A0:9F2D F0 15       BEQ $15    [$9F44]     ;} If (enemy grapple AI) = $800F: go to BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F2F C8          INY                    ; Y = 4
$A0:9F30 C9 14 80    CMP #$8014             ;\
$A0:9F33 F0 0F       BEQ $0F    [$9F44]     ;} If (enemy grapple AI) = $8014: go to BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F35 C8          INY                    ; Y = 5
$A0:9F36 C9 19 80    CMP #$8019             ;\
$A0:9F39 F0 09       BEQ $09    [$9F44]     ;} If (enemy grapple AI) = $8019: go to BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F3B C8          INY                    ; Y = 6
$A0:9F3C C9 1E 80    CMP #$801E             ;\
$A0:9F3F F0 03       BEQ $03    [$9F44]     ;} If (enemy grapple AI) = $801E: go to BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F41 A0 00 00    LDY #$0000             ; Y = 0

; BRANCH_GRAPPLE_INDEX_DETERMINED
$A0:9F44 86 12       STX $12    [$7E:0012]  ; $12 = [enemy ID]
$A0:9F46 98          TYA                    ; A = [Y]
$A0:9F47 C9 01 00    CMP #$0001             ;\
$A0:9F4A F0 0E       BEQ $0E    [$9F5A]     ;} If [A] = 1: go to BRANCH_ATTACH_GRAPPLE
$A0:9F4C C9 04 00    CMP #$0004             ;\
$A0:9F4F F0 09       BEQ $09    [$9F5A]     ;} If [A] = 4: go to BRANCH_ATTACH_GRAPPLE
$A0:9F51 C9 05 00    CMP #$0005             ;\
$A0:9F54 F0 04       BEQ $04    [$9F5A]     ;} If [A] = 5: go to BRANCH_ATTACH_GRAPPLE

$A0:9F56 7A          PLY
$A0:9F57 FA          PLX
$A0:9F58 AB          PLB
$A0:9F59 6B          RTL                    ; Return

; BRANCH_ATTACH_GRAPPLE
$A0:9F5A 48          PHA
$A0:9F5B AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9F5E BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;} Grapple beam end X position = [enemy X position]
$A0:9F61 8D 08 0D    STA $0D08  [$7E:0D08]  ;/
$A0:9F64 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A0:9F67 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;} Grapple beam end Y position = [enemy Y position]
$A0:9F6A 68          PLA
$A0:9F6B 80 E9       BRA $E9    [$9F56]     ; Return
}


;;; $9F6D..A079: Enemy grapple AIs ;;;
{
;;; $9F6D: Switch enemy AI to main AI ;;;
{
$A0:9F6D AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9F70 9E 8A 0F    STZ $0F8A,x[$7E:0F8A]  ; Enemy AI handler = main AI
$A0:9F73 9E A0 0F    STZ $0FA0,x[$7E:0FA0]  ; Enemy invincibility timer = 0
$A0:9F76 9E 9E 0F    STZ $0F9E,x[$7E:0F9E]  ; Enemy frozen timer = 0
$A0:9F79 9E A2 0F    STZ $0FA2,x[$7E:0FA2]  ; Enemy shake timer = 0
$A0:9F7C 6B          RTL
}


;;; $9F7D: Samus latches on with grapple ;;;
{
$A0:9F7D AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9F80 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} >_<;;
$A0:9F83 BD 7A 0F    LDA $0F7A,x            ;\
$A0:9F86 8D 08 0D    STA $0D08  [$7E:0D08]  ;} Grapple beam end X position = [enemy X position]
$A0:9F89 BD 7E 0F    LDA $0F7E,x            ;\
$A0:9F8C 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;} Grapple beam end Y position = [enemy Y position]
$A0:9F8F AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9F92 BD 9E 0F    LDA $0F9E,x            ;\
$A0:9F95 D0 23       BNE $23    [$9FBA]     ;} If [enemy frozen timer] = 0:
$A0:9F97 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9F9A BD 78 0F    LDA $0F78,x            ;\
$A0:9F9D AA          TAX                    ;|
$A0:9F9E BF 0D 00 A0 LDA $A0000D,x          ;|
$A0:9FA2 29 FF 00    AND #$00FF             ;|
$A0:9FA5 D0 03       BNE $03    [$9FAA]     ;} Enemy flash timer = (enemy hurt AI time)
$A0:9FA7 A9 04 00    LDA #$0004             ;|
                                            ;|
$A0:9FAA AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A0:9FAD 9D 9C 0F    STA $0F9C,x            ;/
$A0:9FB0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FB3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FB6 9E 8A 0F    STZ $0F8A,x            ; Enemy AI handler = main AI
$A0:9FB9 6B          RTL                    ; Return

$A0:9FBA AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FBD A9 04 00    LDA #$0004             ;\
$A0:9FC0 9D 8A 0F    STA $0F8A,x            ;} Enemy AI handler = frozen AI
$A0:9FC3 6B          RTL
}


;;; $9FC4: Enemy grapple death ;;;
{
$A0:9FC4 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:9FC7 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} >_<;
$A0:9FCA A9 04 00    LDA #$0004             ;\
$A0:9FCD 9F 02 70 7E STA $7E7002,x[$7E:7142];} Enemy cause of death = 4 (grapple killed)
$A0:9FD1 A9 00 00    LDA #$0000             ; A = 0 (small explosion)
$A0:9FD4 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death
$A0:9FD8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FDB 9E 8A 0F    STZ $0F8A,x[$7E:10CA]  ; Enemy AI handler = main AI
$A0:9FDE 6B          RTL
}


;;; $9FDF: Switch to frozen AI ;;;
{
$A0:9FDF AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FE2 A9 04 00    LDA #$0004             ;\
$A0:9FE5 9D 8A 0F    STA $0F8A,x[$7E:0F8A]  ;} Enemy AI handler = frozen AI
$A0:9FE8 6B          RTL
}


;;; $9FE9: Samus latches on with grapple - no invincibility ;;;
{
$A0:9FE9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FEC BD 9E 0F    LDA $0F9E,x[$7E:105E]  ;\
$A0:9FEF D0 37       BNE $37    [$A028]     ;} If [enemy frozen timer] != 0: go to BRANCH_FROZEN
$A0:9FF1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:9FF4 BD 78 0F    LDA $0F78,x[$7E:1038]  ;\
$A0:9FF7 AA          TAX                    ;|
$A0:9FF8 BF 18 00 A0 LDA $A00018,x[$A0:E8D7];|
$A0:9FFC 8D 84 17    STA $1784  [$7E:1784]  ;} Execute (enemy main AI)
$A0:9FFF 8B          PHB                    ;|
$A0:A000 22 18 A0 A0 JSL $A0A018[$A0:A018]  ;|
$A0:A004 AB          PLB                    ;/
$A0:A005 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A008 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$A0:A00B 8D 08 0D    STA $0D08  [$7E:0D08]  ;} Grapple beam end X position = [enemy X position]
$A0:A00E BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A0:A011 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;} Grapple beam end Y position = [enemy Y position]
$A0:A014 9E 8A 0F    STZ $0F8A,x[$7E:104A]  ; Enemy AI handler = main AI
$A0:A017 6B          RTL                    ; Return

; Execute enemy AI pointer
$A0:A018 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A01B BD A6 0F    LDA $0FA6,x[$7E:1066]
$A0:A01E 8D 86 17    STA $1786  [$7E:1786]
$A0:A021 EB          XBA
$A0:A022 48          PHA
$A0:A023 AB          PLB
$A0:A024 AB          PLB
$A0:A025 DC 84 17    JML [$1784][$A8:C21C]

; BRANCH_FROZEN
$A0:A028 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A02B BD 7A 0F    LDA $0F7A,x            ;\
$A0:A02E 8D 08 0D    STA $0D08  [$7E:0D08]  ;} Grapple beam end X position = [enemy X position]
$A0:A031 BD 7E 0F    LDA $0F7E,x            ;\
$A0:A034 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;} Grapple beam end Y position = [enemy Y position]
$A0:A037 A9 04 00    LDA #$0004             ;\
$A0:A03A 9D 8A 0F    STA $0F8A,x            ;} Enemy AI handler = frozen AI
$A0:A03D 6B          RTL
}


;;; $A03E: Samus latches on with grapple - paralyse enemy ;;;
{
$A0:A03E AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A041 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A044 BD 78 0F    LDA $0F78,x            ;\
$A0:A047 AA          TAX                    ;|
$A0:A048 BF 0D 00 A0 LDA $A0000D,x          ;|
$A0:A04C 29 FF 00    AND #$00FF             ;|
$A0:A04F D0 03       BNE $03    [$A054]     ;} Enemy flash timer = (enemy hurt AI time)
$A0:A051 A9 04 00    LDA #$0004             ;|
                                            ;|
$A0:A054 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A0:A057 9D 9C 0F    STA $0F9C,x            ;/
$A0:A05A AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A05D AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A060 9E 8A 0F    STZ $0F8A,x            ; Enemy AI handler = main AI
$A0:A063 AE 54 0E    LDX $0E54  [$7E:0E54]  ; >_<;;;
$A0:A066 BD 88 0F    LDA $0F88,x            ;\
$A0:A069 09 01 00    ORA #$0001             ;} Set enemy as paralysed
$A0:A06C 9D 88 0F    STA $0F88,x            ;/
$A0:A06F 6B          RTL
}


;;; $A070: Switch to frozen AI ;;;
{
; Clone of $9FDF
$A0:A070 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A073 A9 04 00    LDA #$0004
$A0:A076 9D 8A 0F    STA $0F8A,x
$A0:A079 6B          RTL
}
}


;;; $A07A: Enemy / Samus collision handling ;;;
{
; $A091 is the cause of screw attack cancelling invincibility (need to check $9A8B too)
; Not the cause of crystal flash insta-death, that would be $90:D6D6
$A0:A07A 8B          PHB
$A0:A07B C2 30       REP #$30
$A0:A07D F4 00 A0    PEA $A000              ;\
$A0:A080 AB          PLB                    ;} DB = $A0
$A0:A081 AB          PLB                    ;/
$A0:A082 A9 09 00    LDA #$0009             ;\
$A0:A085 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 9
$A0:A089 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A08C B9 8E 0F    LDA $0F8E,y[$7E:0F8E]  ;\
$A0:A08F F0 25       BEQ $25    [$A0B6]     ;} If [enemy spritemap pointer] = 0: return
$A0:A091 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A0:A094 F0 05       BEQ $05    [$A09B]     ;} If [Samus contact damage index] != normal:
$A0:A096 9C A8 18    STZ $18A8  [$7E:18A8]  ;} Samus invincibility timer = 0
$A0:A099 80 1D       BRA $1D    [$A0B8]     ; Go to BRANCH_TANGIBLE

$A0:A09B AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$A0:A09E F0 18       BEQ $18    [$A0B8]     ;} If [Samus invincibility timer] = 0: go to BRANCH_TANGIBLE
$A0:A0A0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A0A3 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\
$A0:A0A6 C9 FF DA    CMP #$DAFF             ;} If [enemy ID] = respawning enemy placeholder:
$A0:A0A9 D0 0B       BNE $0B    [$A0B6]     ;/
$A0:A0AB BF 00 70 7E LDA $7E7000,x          ;\
$A0:A0AF F0 05       BEQ $05    [$A0B6]     ;} If [enemy $7E:7000] != 0 (never true):
$A0:A0B1 C9 08 00    CMP #$0008             ;\
$A0:A0B4 D0 02       BNE $02    [$A0B8]     ;} If [enemy $7E:7000] != 8: go to BRANCH_TANGIBLE

$A0:A0B6 AB          PLB
$A0:A0B7 60          RTS                    ; Return

; BRANCH_TANGIBLE
$A0:A0B8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A0BB BC 78 0F    LDY $0F78,x[$7E:0F78]  ;\
$A0:A0BE B9 30 00    LDA $0030,y[$A0:E26F]  ;|
$A0:A0C1 C9 4C 80    CMP #$804C             ;|
$A0:A0C4 F0 05       BEQ $05    [$A0CB]     ;} If (enemy touch) = $804B/$804C:
$A0:A0C6 C9 4B 80    CMP #$804B             ;|
$A0:A0C9 D0 02       BNE $02    [$A0CD]     ;/
$A0:A0CB AB          PLB
$A0:A0CC 60          RTS                    ; Return

$A0:A0CD AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A0D0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:A0D3 38          SEC                    ;|
$A0:A0D4 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A0:A0D7 10 04       BPL $04    [$A0DD]     ;|
$A0:A0D9 49 FF FF    EOR #$FFFF             ;|
$A0:A0DC 1A          INC A                  ;|
                                            ;} If |[Samus X position] - [enemy X position]| >= [Samus X radius] + [enemy X radius]: return
$A0:A0DD 38          SEC                    ;|
$A0:A0DE ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A0:A0E1 90 05       BCC $05    [$A0E8]     ;|
$A0:A0E3 DD 82 0F    CMP $0F82,x[$7E:0F82]  ;|
$A0:A0E6 B0 18       BCS $18    [$A100]     ;/

$A0:A0E8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:A0EB 38          SEC                    ;|
$A0:A0EC FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$A0:A0EF 10 04       BPL $04    [$A0F5]     ;|
$A0:A0F1 49 FF FF    EOR #$FFFF             ;|
$A0:A0F4 1A          INC A                  ;|
                                            ;} If |[Samus Y position] - [enemy Y position]| >= [Samus Y radius] + [enemy Y radius]:
$A0:A0F5 38          SEC                    ;|
$A0:A0F6 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A0:A0F9 90 07       BCC $07    [$A102]     ;|
$A0:A0FB DD 84 0F    CMP $0F84,x[$7E:0FC4]  ;|
$A0:A0FE 90 02       BCC $02    [$A102]     ;/
$A0:A100 AB          PLB
$A0:A101 60          RTS                    ; Return

$A0:A102 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A105 BD 8E 0F    LDA $0F8E,x[$7E:0F8E]  ;\
$A0:A108 0A          ASL A                  ;} $14 = [enemy spritemap pointer] * 2 (???)
$A0:A109 85 14       STA $14    [$7E:0014]  ;/
$A0:A10B AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A10E BD 78 0F    LDA $0F78,x[$7E:0F78]  ;\
$A0:A111 C9 FF DA    CMP #$DAFF             ;} If [enemy ID] != respawning enemy placeholder: (always true)
$A0:A114 F0 0A       BEQ $0A    [$A120]     ;/
$A0:A116 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A119 B9 9E 0F    LDA $0F9E,y[$7E:0F9E]  ;\
$A0:A11C F0 02       BEQ $02    [$A120]     ;} If [enemy frozen timer] != 0:
$A0:A11E AB          PLB
$A0:A11F 60          RTS                    ; Return

$A0:A120 22 26 A1 A0 JSL $A0A126[$A0:A126]  ; Execute enemy touch
$A0:A124 AB          PLB
$A0:A125 60          RTS                    ; Return

; Execute enemy touch
$A0:A126 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A129 B9 A6 0F    LDA $0FA6,y[$7E:0FA6]  ;\
$A0:A12C EB          XBA                    ;|
$A0:A12D 48          PHA                    ;} DB = [enemy bank]
$A0:A12E AB          PLB                    ;|
$A0:A12F AB          PLB                    ;/
$A0:A130 BE 78 0F    LDX $0F78,y[$7E:0F78]  ;\
$A0:A133 BF 30 00 A0 LDA $A00030,x[$A0:E26F];|
$A0:A137 8D 84 17    STA $1784  [$7E:1784]  ;} $1784 = [enemy bank] << 10h | (enemy touch)
$A0:A13A B9 A6 0F    LDA $0FA6,y[$7E:0FA6]  ;|
$A0:A13D 8D 86 17    STA $1786  [$7E:1786]  ;/
$A0:A140 DC 84 17    JML [$1784][$A6:F920]  ; Go to [$1784]
}


;;; $A143: Enemy / projectile collision handling ;;;
{
$A0:A143 8B          PHB
$A0:A144 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A147 BD A6 0F    LDA $0FA6,x[$7E:0FA6]  ;\
$A0:A14A 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:A14D EB          XBA                    ;\
$A0:A14E 48          PHA                    ;|
$A0:A14F AB          PLB                    ;} DB = [enemy bank]
$A0:A150 AB          PLB                    ;/
$A0:A151 A9 07 00    LDA #$0007             ;\
$A0:A154 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 7
$A0:A158 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$A0:A15B D0 02       BNE $02    [$A15F]     ;} If [projectile counter] = 0:
$A0:A15D AB          PLB
$A0:A15E 60          RTS                    ; Return

$A0:A15F AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A162 B9 8E 0F    LDA $0F8E,y[$7E:10CE]  ;\
$A0:A165 F0 F6       BEQ $F6    [$A15D]     ;} If [enemy spritemap pointer] = 0: return
$A0:A167 C9 4D 80    CMP #$804D             ;\
$A0:A16A F0 F1       BEQ $F1    [$A15D]     ;} If [enemy spritemap pointer] = $804D: return
$A0:A16C B9 86 0F    LDA $0F86,y[$7E:10C6]  ;\
$A0:A16F 89 00 04    BIT #$0400             ;} If enemy is intangible: return
$A0:A172 D0 E9       BNE $E9    [$A15D]     ;/
$A0:A174 B9 78 0F    LDA $0F78,y[$7E:10B8]  ;\
$A0:A177 C9 FF DA    CMP #$DAFF             ;} If [enemy ID] = respawning enemy placeholder: return
$A0:A17A F0 E1       BEQ $E1    [$A15D]     ;/
$A0:A17C B9 A0 0F    LDA $0FA0,y[$7E:10E0]  ;\
$A0:A17F D0 DC       BNE $DC    [$A15D]     ;} If [enemy invincibility timer] != 0: return
$A0:A181 9C A6 18    STZ $18A6  [$7E:18A6]  ; Projectile index = 0

; LOOP
$A0:A184 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A187 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A18A 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:A18B A8          TAY                    ;/
$A0:A18C B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:A18F F0 12       BEQ $12    [$A1A3]     ;} If [projectile type] = 0: go to BRANCH_NEXT_PROJECTILE
$A0:A191 29 00 0F    AND #$0F00             ;\
$A0:A194 C9 00 03    CMP #$0300             ;} If projectile is not power bomb:
$A0:A197 F0 0A       BEQ $0A    [$A1A3]     ;/
$A0:A199 C9 00 05    CMP #$0500             ;\
$A0:A19C F0 05       BEQ $05    [$A1A3]     ;} If projectile is not bomb:
$A0:A19E C9 00 07    CMP #$0700             ;\
$A0:A1A1 30 03       BMI $03    [$A1A6]     ;} If projectile is not projectile explosion: go to BRANCH_VALID_PROJECTILE

$A0:A1A3 4C 16 A2    JMP $A216  [$A0:A216]  ; Go to BRANCH_NEXT_PROJECTILE

; BRANCH_VALID_PROJECTILE
$A0:A1A6 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$A0:A1A9 38          SEC                    ;|
$A0:A1AA FD 7A 0F    SBC $0F7A,x[$7E:11FA]  ;|
$A0:A1AD 10 04       BPL $04    [$A1B3]     ;|
$A0:A1AF 49 FF FF    EOR #$FFFF             ;|
$A0:A1B2 1A          INC A                  ;|
                                            ;} If |[projectile X position] - [enemy X position]| >= [projectile X radius] + [enemy X radius]: go to BRANCH_NEXT_PROJECTILE
$A0:A1B3 38          SEC                    ;|
$A0:A1B4 F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;|
$A0:A1B7 90 05       BCC $05    [$A1BE]     ;|
$A0:A1B9 DD 82 0F    CMP $0F82,x[$7E:1202]  ;|
$A0:A1BC B0 58       BCS $58    [$A216]     ;/

$A0:A1BE B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$A0:A1C1 38          SEC                    ;|
$A0:A1C2 FD 7E 0F    SBC $0F7E,x[$7E:11FE]  ;|
$A0:A1C5 10 04       BPL $04    [$A1CB]     ;|
$A0:A1C7 49 FF FF    EOR #$FFFF             ;|
$A0:A1CA 1A          INC A                  ;|
                                            ;} If |[projectile Y position] - [enemy Y position]| >= [projectile Y radius] + [enemy Y radius]:
$A0:A1CB 38          SEC                    ;|
$A0:A1CC F9 C8 0B    SBC $0BC8,y[$7E:0BC8]  ;|
$A0:A1CF 90 07       BCC $07    [$A1D8]     ;|
$A0:A1D1 DD 84 0F    CMP $0F84,x[$7E:1204]  ;|
$A0:A1D4 90 02       BCC $02    [$A1D8]     ;/
$A0:A1D6 80 3E       BRA $3E    [$A216]     ; Go to BRANCH_NEXT_PROJECTILE

$A0:A1D8 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:A1DB 29 00 0F    AND #$0F00             ;|
$A0:A1DE C9 00 02    CMP #$0200             ;} If projectile is super missile:
$A0:A1E1 D0 0C       BNE $0C    [$A1EF]     ;/
$A0:A1E3 A9 1E 00    LDA #$001E             ;\
$A0:A1E6 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 30
$A0:A1E9 A9 12 00    LDA #$0012             ;\
$A0:A1EC 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1, BG2 and enemies, 1 pixel displacement, horizontal

$A0:A1EF AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A1F2 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:A1F3 A8          TAY                    ;/
$A0:A1F4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A1F7 BD 86 0F    LDA $0F86,x[$7E:1246]  ;\
$A0:A1FA 89 00 10    BIT #$1000             ;} If enemy doesn't block plasma beam:
$A0:A1FD D0 08       BNE $08    [$A207]     ;/
$A0:A1FF B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:A202 89 08 00    BIT #$0008             ;} If projectile is plasma beam: go to BRANCH_NO_DELETE
$A0:A205 D0 09       BNE $09    [$A210]     ;/

$A0:A207 B9 04 0C    LDA $0C04,y[$7E:0C04]  ;\
$A0:A20A 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:A20D 99 04 0C    STA $0C04,y[$7E:0C04]  ;/

; BRANCH_NO_DELETE
$A0:A210 22 26 A2 A0 JSL $A0A226[$A0:A226]  ; Execute enemy shot
$A0:A214 80 0E       BRA $0E    [$A224]     ; Return

; BRANCH_NEXT_PROJECTILE
$A0:A216 EE A6 18    INC $18A6  [$7E:18A6]  ; Increment projectile index
$A0:A219 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A21C C9 05 00    CMP #$0005             ;} If [projectile index] = 5: return
$A0:A21F F0 03       BEQ $03    [$A224]     ;/
$A0:A221 4C 84 A1    JMP $A184  [$A0:A184]  ; Go to LOOP

$A0:A224 AB          PLB
$A0:A225 60          RTS

; Execute enemy shot
$A0:A226 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A229 BE 78 0F    LDX $0F78,y[$7E:1238]
$A0:A22C BF 32 00 A0 LDA $A00032,x[$A0:EAB1]
$A0:A230 8D 84 17    STA $1784  [$7E:1784]
$A0:A233 DC 84 17    JML [$1784][$A8:E91D]
}


;;; $A236: Enemy / bomb collision handling ;;;
{
$A0:A236 8B          PHB
$A0:A237 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A23A BD A6 0F    LDA $0FA6,x[$7E:0FA6]  ;\
$A0:A23D 8D 86 17    STA $1786  [$7E:1786]  ;} Enemy AI bank = [enemy bank]
$A0:A240 EB          XBA                    ;\
$A0:A241 48          PHA                    ;|
$A0:A242 AB          PLB                    ;} DB = [enemy bank]
$A0:A243 AB          PLB                    ;/
$A0:A244 A9 08 00    LDA #$0008             ;\
$A0:A247 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Enemy processing stage = 8
$A0:A24B AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$A0:A24E D0 02       BNE $02    [$A252]     ;} If [projectile counter] = 0:
$A0:A250 AB          PLB
$A0:A251 60          RTS                    ; Return

$A0:A252 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A255 B9 8E 0F    LDA $0F8E,y[$7E:0F8E]  ;\
$A0:A258 F0 F6       BEQ $F6    [$A250]     ;} If [enemy spritemap pointer] = 0: return
$A0:A25A AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A25D B9 A0 0F    LDA $0FA0,y[$7E:0FA0]  ;\
$A0:A260 D0 EE       BNE $EE    [$A250]     ;} If [enemy invincibility timer] != 0: return
$A0:A262 B9 78 0F    LDA $0F78,y[$7E:0F78]  ;\
$A0:A265 C9 FF DA    CMP #$DAFF             ;} If [enemy ID] = respawning enemy placeholder: return
$A0:A268 F0 E6       BEQ $E6    [$A250]     ;/
$A0:A26A A9 05 00    LDA #$0005             ;\
$A0:A26D 8D A6 18    STA $18A6  [$7E:18A6]  ;} Projectile index = 5

; LOOP
$A0:A270 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A273 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A276 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:A277 A8          TAY                    ;/
$A0:A278 B9 18 0C    LDA $0C18,y[$7E:0C22]  ;\
$A0:A27B D0 03       BNE $03    [$A280]     ;} If [projectile type] = 0:
$A0:A27D 4C E6 A2    JMP $A2E6  [$A0:A2E6]  ; Go to BRANCH_NEXT

$A0:A280 B9 7C 0C    LDA $0C7C,y[$7E:0C86]  ;\
$A0:A283 D0 61       BNE $61    [$A2E6]     ;} If [bomb timer] != 0: go to BRANCH_NEXT
$A0:A285 B9 18 0C    LDA $0C18,y[$7E:0C22]  ;\
$A0:A288 29 00 0F    AND #$0F00             ;|
$A0:A28B C9 00 05    CMP #$0500             ;} If projectile is not bomb:
$A0:A28E F0 0B       BEQ $0B    [$A29B]     ;/
$A0:A290 B9 18 0C    LDA $0C18,y[$7E:0C22]  ;\
$A0:A293 89 00 80    BIT #$8000             ;} If projectile interacts with Samus:
$A0:A296 D0 03       BNE $03    [$A29B]     ;/
$A0:A298 4C E6 A2    JMP $A2E6  [$A0:A2E6]  ; Go to BRANCH_NEXT

$A0:A29B B9 64 0B    LDA $0B64,y[$7E:0B6E]  ;\
$A0:A29E 38          SEC                    ;|
$A0:A29F FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A0:A2A2 10 04       BPL $04    [$A2A8]     ;|
$A0:A2A4 49 FF FF    EOR #$FFFF             ;|
$A0:A2A7 1A          INC A                  ;|
                                            ;} If |[projectile X position] - [enemy X position]| >= [projectile X radius] + [enemy X radius]: go to BRANCH_NEXT
$A0:A2A8 38          SEC                    ;|
$A0:A2A9 F9 B4 0B    SBC $0BB4,y[$7E:0BBE]  ;|
$A0:A2AC 90 05       BCC $05    [$A2B3]     ;|
$A0:A2AE DD 82 0F    CMP $0F82,x[$7E:0F82]  ;|
$A0:A2B1 B0 33       BCS $33    [$A2E6]     ;/

$A0:A2B3 B9 78 0B    LDA $0B78,y[$7E:0B82]  ;\
$A0:A2B6 38          SEC                    ;|
$A0:A2B7 FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$A0:A2BA 10 04       BPL $04    [$A2C0]     ;|
$A0:A2BC 49 FF FF    EOR #$FFFF             ;|
$A0:A2BF 1A          INC A                  ;|
                                            ;} If |[projectile Y position] - [enemy Y position]| >= [projectile Y radius] + [enemy Y radius]:
$A0:A2C0 38          SEC                    ;|
$A0:A2C1 F9 C8 0B    SBC $0BC8,y[$7E:0BD2]  ;|
$A0:A2C4 90 07       BCC $07    [$A2CD]     ;|
$A0:A2C6 DD 84 0F    CMP $0F84,x[$7E:0F84]  ;|
$A0:A2C9 90 02       BCC $02    [$A2CD]     ;/
$A0:A2CB 80 19       BRA $19    [$A2E6]     ; Go to BRANCH_NEXT

$A0:A2CD AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A2D0 0A          ASL A                  ;} Y = [projectile index] * 2
$A0:A2D1 A8          TAY                    ;/
$A0:A2D2 B9 7C 0C    LDA $0C7C,y[$7E:0C86]  ;\
$A0:A2D5 D0 0F       BNE $0F    [$A2E6]     ;} If [bomb timer] != 0: go to BRANCH_NEXT (never true)
$A0:A2D7 B9 04 0C    LDA $0C04,y[$7E:0C0E]  ;\
$A0:A2DA 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:A2DD 99 04 0C    STA $0C04,y[$7E:0C0E]  ;/
$A0:A2E0 22 F6 A2 A0 JSL $A0A2F6[$A0:A2F6]  ; Execute enemy shot
$A0:A2E4 80 0E       BRA $0E    [$A2F4]     ; Return

; BRANCH_NEXT
$A0:A2E6 EE A6 18    INC $18A6  [$7E:18A6]  ; Increment projectile index
$A0:A2E9 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A2EC C9 0A 00    CMP #$000A             ;} If [projectile index] = Ah: return
$A0:A2EF F0 03       BEQ $03    [$A2F4]     ;/
$A0:A2F1 4C 70 A2    JMP $A270  [$A0:A270]  ; Go to LOOP

$A0:A2F4 AB          PLB
$A0:A2F5 60          RTS

; Execute enemy shot
$A0:A2F6 AC 54 0E    LDY $0E54  [$7E:0E54]
$A0:A2F9 BE 78 0F    LDX $0F78,y[$7E:0F78]
$A0:A2FC BF 32 00 A0 LDA $A00032,x[$A0:D571]
$A0:A300 8D 84 17    STA $1784  [$7E:1784]
$A0:A303 DC 84 17    JML [$1784][$A2:F0A2]
}


;;; $A306: Process enemy power bomb interaction ;;;
{
; This routine is relying on $12 and $14 (the calculated power bomb explosion radius) not being modified over the course of the loop(!)
; This doesn't hold true if an enemy is killed by the power bomb (see e.g. $A3E6) >_>;
; For respawning enemies, $12 = 4000h in their enemy death, making power bombs effectively infinite wide for the remaining enemies that frame
; For non-respawning enemies, $12 = 0 in their enemy death, making power bombs effectively zero sized for the remaining enemies that frame
$A0:A306 8B          PHB
$A0:A307 A9 05 00    LDA #$0005             ;\
$A0:A30A 8F 78 F3 7E STA $7EF378[$7E:F378]  ;} Stage of enemy processing = 5
$A0:A30E AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$A0:A311 29 FF 00    AND #$00FF             ;} $12 = [power bomb explosion radius] / 100h (power bomb X radius)
$A0:A314 85 12       STA $12    [$7E:0012]  ;/
$A0:A316 D0 02       BNE $02    [$A31A]     ; If (power bomb X radius) = 0:
$A0:A318 AB          PLB
$A0:A319 6B          RTL                    ; Return

$A0:A31A 4A          LSR A                  ;\
$A0:A31B 65 12       ADC $12    [$7E:0012]  ;|
$A0:A31D 4A          LSR A                  ;} $14 = (power bomb X radius) * 3/4 (power bomb Y radius)
$A0:A31E 85 14       STA $14    [$7E:0014]  ;/
$A0:A320 A9 C0 07    LDA #$07C0             ;\
$A0:A323 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy index = 7C0h (last slot)

; LOOP
$A0:A326 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A0:A329 BD A0 0F    LDA $0FA0,x[$7E:1760]  ;\
$A0:A32C D0 63       BNE $63    [$A391]     ;} If [enemy invincibility timer] != 0: go to BRANCH_NEXT
$A0:A32E BD 78 0F    LDA $0F78,x[$7E:1738]  ;\
$A0:A331 F0 5E       BEQ $5E    [$A391]     ;} If [enemy ID] = 0: go to BRANCH_NEXT
$A0:A333 C9 FF DA    CMP #$DAFF             ;\
$A0:A336 F0 59       BEQ $59    [$A391]     ;} If [enemy ID] = $DAFF (respawning enemy placeholder): go to BRANCH_NEXT
$A0:A338 AA          TAX                    ;\
$A0:A339 BF 3C 00 A0 LDA $A0003C,x[$A0:CEFB];|
$A0:A33D D0 03       BNE $03    [$A342]     ;|
$A0:A33F A9 1C EC    LDA #$EC1C             ;|
                                            ;} If not vulnerable to power bombs: go to BRANCH_NEXT
$A0:A342 AA          TAX                    ;|
$A0:A343 BF 0F 00 B4 LDA $B4000F,x[$B4:EDB7];|
$A0:A347 29 7F 00    AND #$007F             ;|
$A0:A34A F0 45       BEQ $45    [$A391]     ;/
$A0:A34C AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A34F AD E2 0C    LDA $0CE2  [$7E:0CE2]  ;\
$A0:A352 38          SEC                    ;|
$A0:A353 FD 7A 0F    SBC $0F7A,x[$7E:103A]  ;|
$A0:A356 10 04       BPL $04    [$A35C]     ;|
$A0:A358 49 FF FF    EOR #$FFFF             ;} If |[power bomb explosion X position] - [enemy X position]| >= (power bomb X radius): go to BRANCH_NEXT
$A0:A35B 1A          INC A                  ;|
                                            ;|
$A0:A35C C5 12       CMP $12    [$7E:0012]  ;|
$A0:A35E B0 31       BCS $31    [$A391]     ;/
$A0:A360 AD E4 0C    LDA $0CE4  [$7E:0CE4]  ;\
$A0:A363 38          SEC                    ;|
$A0:A364 FD 7E 0F    SBC $0F7E,x[$7E:0FFE]  ;|
$A0:A367 10 04       BPL $04    [$A36D]     ;|
$A0:A369 49 FF FF    EOR #$FFFF             ;} If |[power bomb explosion Y position] - [enemy Y position]| >= (power bomb Y radius): go to BRANCH_NEXT
$A0:A36C 1A          INC A                  ;|
                                            ;|
$A0:A36D C5 14       CMP $14    [$7E:0014]  ;|
$A0:A36F B0 20       BCS $20    [$A391]     ;/
$A0:A371 BD 78 0F    LDA $0F78,x[$7E:0FF8]  ;\
$A0:A374 AA          TAX                    ;} A = (enemy power bomb reaction)
$A0:A375 BF 28 00 A0 LDA $A00028,x[$A0:CEE7];/
$A0:A379 D0 03       BNE $03    [$A37E]     ; If [A] = 0:
$A0:A37B A9 37 80    LDA #$8037             ; A = $8037 (normal enemy power bomb AI)

$A0:A37E 8D 84 17    STA $1784  [$7E:1784]  ; Enemy AI pointer = [A]
$A0:A381 22 9F A3 A0 JSL $A0A39F[$A0:A39F]  ; Execute enemy AI
$A0:A385 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A388 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A0:A38B 09 00 08    ORA #$0800             ;} Set enemy to process whilst off-screen
$A0:A38E 9D 86 0F    STA $0F86,x[$7E:1006]  ;/

; BRANCH_NEXT
$A0:A391 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A0:A394 38          SEC                    ;|
$A0:A395 E9 40 00    SBC #$0040             ;} Enemy index -= 40h (previous enemy slot)
$A0:A398 8D 54 0E    STA $0E54  [$7E:0E54]  ;/
$A0:A39B 10 89       BPL $89    [$A326]     ; If [enemy index] >= 0: go to LOOP
$A0:A39D AB          PLB
$A0:A39E 6B          RTL                    ; Return

; Execute enemy AI
$A0:A39F AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A3A2 BD A6 0F    LDA $0FA6,x[$7E:1026]
$A0:A3A5 8D 86 17    STA $1786  [$7E:1786]
$A0:A3A8 EB          XBA
$A0:A3A9 48          PHA
$A0:A3AA AB          PLB
$A0:A3AB AB          PLB
$A0:A3AC DC 84 17    JML [$1784][$A2:8037]
}
}


;;; $A3AF: Enemy death ;;;
{
;; Parameter:
;;     A: Death animation. Range 0..4
;;         0: Small explosion. Used by grapple killed, power bomb killed, refill candy, fire pillar, boulder, creepy crawlies, skree, Norfair fireball, fireflea, waver, rinka, polyp, fly, owtch, puyo, boyon, zebetite, bang
;;         1: Killed by Samus contact. Also used by bang
;;         2: Normal explosion. Used by super missile killed default, atomic / robot / ghost, bull / floater / oum / yard / fish, fune, sidehopper, desgeega, mochtroid, slug, sciser, metaree, chute, rio, squeept, rio, cacatac
;;         3: Fake Kraid explosion
;;         4: Big explosion. Used by space pirates, Shaktool, ki-hunter, dragon, kago, yapping maw, evir, metroid, super-sidehopper/desgeega, tatori
;;     X: Enemy index
$A0:A3AF 08          PHP
$A0:A3B0 8B          PHB
$A0:A3B1 F4 00 A0    PEA $A000              ;\
$A0:A3B4 AB          PLB                    ;} DB = $A0
$A0:A3B5 AB          PLB                    ;/
$A0:A3B6 C2 30       REP #$30
$A0:A3B8 48          PHA
$A0:A3B9 BD 8A 0F    LDA $0F8A,x[$7E:02DD]  ;\
$A0:A3BC C9 01 00    CMP #$0001             ;} If [enemy AI handler] = grapple:
$A0:A3BF D0 06       BNE $06    [$A3C7]     ;/
$A0:A3C1 A9 C5 C8    LDA #$C8C5             ;\
$A0:A3C4 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = $C8C5 (released from swing)

$A0:A3C7 68          PLA
$A0:A3C8 C9 05 00    CMP #$0005             ;\
$A0:A3CB 30 03       BMI $03    [$A3D0]     ;} If [A] >= 5:
$A0:A3CD A9 00 00    LDA #$0000             ; A = 0

$A0:A3D0 8D 20 0E    STA $0E20  [$7E:0E20]  ; $0E20 = [A]
$A0:A3D3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A3D6 A0 45 F3    LDY #$F345             ;\
$A0:A3D9 AD 20 0E    LDA $0E20  [$7E:0E20]  ;} Spawn enemy death explosion enemy projectile
$A0:A3DC 22 27 80 86 JSL $868027[$86:8027]  ;/
$A0:A3E0 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A0:A3E3 29 00 40    AND #$4000             ;} $12 = (enemy respawn flag)
$A0:A3E6 85 12       STA $12    [$7E:0012]  ;/
$A0:A3E8 A0 3E 00    LDY #$003E             ;\
$A0:A3EB AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
                                            ;|
$A0:A3EE 9E 78 0F    STZ $0F78,x[$7E:0FB8]  ;|
$A0:A3F1 E8          INX                    ;} Clear enemy slot
$A0:A3F2 E8          INX                    ;|
$A0:A3F3 88          DEY                    ;|
$A0:A3F4 88          DEY                    ;|
$A0:A3F5 10 F7       BPL $F7    [$A3EE]     ;/
$A0:A3F7 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A3F9 F0 0F       BEQ $0F    [$A40A]     ;} If enemy respawns:
$A0:A3FB AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A3FE A9 FF DA    LDA #$DAFF             ;\
$A0:A401 9D 78 0F    STA $0F78,x[$7E:11B8]  ;} Enemy ID = $DAFF (respawning enemy placeholder)
$A0:A404 A9 A3 00    LDA #$00A3             ;\
$A0:A407 9D A6 0F    STA $0FA6,x[$7E:11E6]  ;} Enemy bank = $A3

$A0:A40A EE 50 0E    INC $0E50  [$7E:0E50]  ; Increment number of enemies killed
$A0:A40D AB          PLB
$A0:A40E 28          PLP
$A0:A40F 6B          RTL
}


;;; $A410: Rinka death ;;;
{
;; Parameter:
;;     A: Death animation. Range 0..4
;;         0/3/4: Small explosion
;;         1: Killed by Samus contact
;;         2: Normal explosion
$A0:A410 08          PHP
$A0:A411 8B          PHB
$A0:A412 F4 00 A0    PEA $A000              ;\
$A0:A415 AB          PLB                    ;} DB = $A0
$A0:A416 AB          PLB                    ;/
$A0:A417 C2 30       REP #$30
$A0:A419 C9 03 00    CMP #$0003             ;\
$A0:A41C 30 03       BMI $03    [$A421]     ;} If [A] >= 3:
$A0:A41E A9 00 00    LDA #$0000             ; A = 0

$A0:A421 8D 20 0E    STA $0E20  [$7E:0E20]  ; $0E20 = [A]
$A0:A424 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A427 A0 45 F3    LDY #$F345             ;\
$A0:A42A AD 20 0E    LDA $0E20  [$7E:0E20]  ;} Spawn enemy death explosion enemy projectile
$A0:A42D 22 27 80 86 JSL $868027[$86:8027]  ;/
$A0:A431 BD 86 0F    LDA $0F86,x[$7E:10C6]  ;\
$A0:A434 29 00 40    AND #$4000             ;} $12 = (enemy respawn flag)
$A0:A437 85 12       STA $12    [$7E:0012]  ;/
$A0:A439 A0 3E 00    LDY #$003E             ;\
$A0:A43C AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
                                            ;|
$A0:A43F 9E 78 0F    STZ $0F78,x[$7E:10B8]  ;|
$A0:A442 E8          INX                    ;} Clear enemy slot
$A0:A443 E8          INX                    ;|
$A0:A444 88          DEY                    ;|
$A0:A445 88          DEY                    ;|
$A0:A446 10 F7       BPL $F7    [$A43F]     ;/
$A0:A448 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A44A F0 0F       BEQ $0F    [$A45B]     ;} If enemy respawns:
$A0:A44C AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A44F A9 FF DA    LDA #$DAFF             ;\
$A0:A452 9D 78 0F    STA $0F78,x[$7E:10B8]  ;} Enemy ID = $DAFF (respawning enemy placeholder)
$A0:A455 A9 A3 00    LDA #$00A3             ;\
$A0:A458 9D A6 0F    STA $0FA6,x[$7E:10E6]  ;} Enemy bank = $A3

$A0:A45B AB          PLB
$A0:A45C 28          PLP
$A0:A45D 6B          RTL
}


;;; $A45E: Suit damage division ;;;
{
;; Parameter:
;;     A: Damage
;; Returns:
;;     A/$12: Damage divided by 1/2/4 if power/varia/gravity suit equipped
$A0:A45E 85 12       STA $12    [$7E:0012]  ; $12 = [A]
$A0:A460 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$A0:A463 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_GRAVITY_SUIT
$A0:A466 D0 08       BNE $08    [$A470]     ;/
$A0:A468 4A          LSR A                  ;\
$A0:A469 90 02       BCC $02    [$A46D]     ;} If varia suit equipped:
$A0:A46B 46 12       LSR $12    [$7E:0012]  ; $12 /= 2

$A0:A46D A5 12       LDA $12    [$7E:0012]  ;\
$A0:A46F 6B          RTL                    ;} Return A = [$12]

; BRANCH_GRAVITY_SUIT
$A0:A470 46 12       LSR $12    [$7E:0012]  ;\
$A0:A472 46 12       LSR $12    [$7E:0012]  ;} $12 /= 4
$A0:A474 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A476 6B          RTL                    ;} Return A = [$12]
}


;;; $A477..A596: Normal enemy touch AI ;;;
{
;;; $A477: Normal enemy touch AI ;;;
{
$A0:A477 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A47A 20 A1 A4    JSR $A4A1  [$A0:A4A1]  ; Normal touch AI - no death check
$A0:A47D AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A480 BD 8C 0F    LDA $0F8C,x[$7E:108C]  ;\
$A0:A483 D0 0E       BNE $0E    [$A493]     ;} If [enemy health] = 0:
$A0:A485 A9 06 00    LDA #$0006             ;\
$A0:A488 9F 02 70 7E STA $7E7002,x[$7E:7142];} Enemy cause of death = 6 (Samus contact killed)
$A0:A48C A9 01 00    LDA #$0001             ; A = 1 (killed by Samus contact)
$A0:A48F 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death

$A0:A493 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A496 6B          RTL
}


;;; $A497: Normal enemy touch AI - no death check (external) ;;;
{
$A0:A497 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A49A 20 A1 A4    JSR $A4A1  [$A0:A4A1]  ; Normal touch AI - no death check
$A0:A49D AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A4A0 6B          RTL
}


;;; $A4A1: Normal enemy touch AI - no death check ;;;
{
; Damage values:
;     Speed boosting:      $A4AF
;     Shinesparking:       $A4BA
;     Screw attack:        $A4C2
;     Pseudo screw attack: $A4CC

$A0:A4A1 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A0:A4A4 D0 03       BNE $03    [$A4A9]     ;} If [Samus contact damage index] = normal:
$A0:A4A6 4C 62 A5    JMP $A562  [$A0:A562]  ; Go to BRANCH_NORMAL_SAMUS

$A0:A4A9 18          CLC                    ;\
$A0:A4AA 69 0F 00    ADC #$000F             ;} $14 = 10h + [Samus contact damage index] - 1 (vulnerabilities index)
$A0:A4AD 85 14       STA $14    [$7E:0014]  ;/
$A0:A4AF A0 F4 01    LDY #$01F4             ; $16 = 500 (damage)
$A0:A4B2 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A0:A4B5 C9 01 00    CMP #$0001             ;} If [Samus contact damage index] = speed boosting: go to BRANCH_DAMAGE_CALCULATED
$A0:A4B8 F0 26       BEQ $26    [$A4E0]     ;/
$A0:A4BA A0 2C 01    LDY #$012C             ; $16 = 300 (damage)
$A0:A4BD C9 02 00    CMP #$0002             ;\
$A0:A4C0 F0 1E       BEQ $1E    [$A4E0]     ;} If [Samus contact damage index] = shinesparking: go to BRANCH_DAMAGE_CALCULATED
$A0:A4C2 A0 D0 07    LDY #$07D0             ; $16 = 2000 (damage)
$A0:A4C5 C9 03 00    CMP #$0003             ;\
$A0:A4C8 F0 16       BEQ $16    [$A4E0]     ;} If [Samus contact damage index] = screw attacking: go to BRANCH_DAMAGE_CALCULATED
$A0:A4CA E6 14       INC $14    [$7E:0014]  ;
$A0:A4CC A0 C8 00    LDY #$00C8             ; $16 = 200 (damage)
$A0:A4CF C9 04 00    CMP #$0004             ;\
$A0:A4D2 D0 09       BNE $09    [$A4DD]     ;} If [Samus contact damage index] = pseudo screw attacking:
$A0:A4D4 A9 04 00    LDA #$0004             ;\
$A0:A4D7 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - end charge beam
$A0:A4DB 80 03       BRA $03    [$A4E0]     ; Go to BRANCH_DAMAGE_CALCULATED

$A0:A4DD A0 C8 00    LDY #$00C8             ; $16 = 200 <-- a default damage value(!) Never used in vanilla

; BRANCH_DAMAGE_CALCULATED
$A0:A4E0 84 16       STY $16    [$7E:0016]
$A0:A4E2 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A4E5 BD 78 0F    LDA $0F78,x[$7E:10B8]  ;|
$A0:A4E8 AA          TAX                    ;} A = (enemy vulnerabilities)
$A0:A4E9 BF 3C 00 A0 LDA $A0003C,x[$A0:E8BB];/
$A0:A4ED D0 03       BNE $03    [$A4F2]     ; If [A] = 0:
$A0:A4EF A9 1C EC    LDA #$EC1C             ; A = $EC1C

$A0:A4F2 18          CLC                    ;\
$A0:A4F3 65 14       ADC $14    [$7E:0014]  ;|
$A0:A4F5 AA          TAX                    ;} Enemy contact vulnerability = [$B4:0000 + [A] + 10h + [Samus contact damage index] - 1]
$A0:A4F6 BF 00 00 B4 LDA $B40000,x[$B4:EF9C];|
$A0:A4FA 8D 40 0E    STA $0E40  [$7E:0E40]  ;/
$A0:A4FD 29 7F 00    AND #$007F             ;\
$A0:A500 8D 32 0E    STA $0E32  [$7E:0E32]  ;} Enemy damage multiplier = [enemy contact vulnerability] & 7Fh
$A0:A503 F0 1B       BEQ $1B    [$A520]     ; If [enemy damage multiplier] = 0: return
$A0:A505 C9 FF 00    CMP #$00FF             ;\
$A0:A508 F0 16       BEQ $16    [$A520]     ;} >_<;
$A0:A50A AD 32 0E    LDA $0E32  [$7E:0E32]  ;/
$A0:A50D 85 28       STA $28    [$7E:0028]  ;\
$A0:A50F A5 16       LDA $16    [$7E:0016]  ;|
$A0:A511 4A          LSR A                  ;|
$A0:A512 85 26       STA $26    [$7E:0026]  ;} If (damage) * [enemy damage multiplier] / 2 = 0: return
$A0:A514 22 FF B6 A0 JSL $A0B6FF[$A0:B6FF]  ;|
$A0:A518 A5 2A       LDA $2A    [$7E:002A]  ;|
$A0:A51A F0 04       BEQ $04    [$A520]     ;/
$A0:A51C 85 12       STA $12    [$7E:0012]  ; $12 = (damage) * [enemy damage multiplier] / 2
$A0:A51E 80 01       BRA $01    [$A521]     ; Go to BRANCH_DAMAGE

$A0:A520 60          RTS

; BRANCH_DAMAGE
$A0:A521 AE 54 0E    LDX $0E54  [$7E:0E54]  ; Argh >_<;
$A0:A524 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A527 BD 78 0F    LDA $0F78,x[$7E:10B8]  ;|
$A0:A52A AA          TAX                    ;} Enemy flash timer = [enemy hurt AI time]
$A0:A52B BF 0D 00 A0 LDA $A0000D,x[$A0:E88C];|
$A0:A52F 29 FF 00    AND #$00FF             ;/
$A0:A532 D0 03       BNE $03    [$A537]     ; If [enemy hurt AI time] = 0:
$A0:A534 A9 04 00    LDA #$0004             ; Enemy flash timer = 4

$A0:A537 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A53A 9D 9C 0F    STA $0F9C,x[$7E:10DC]
$A0:A53D BD 8A 0F    LDA $0F8A,x[$7E:10CA]  ;\
$A0:A540 09 02 00    ORA #$0002             ;} Enemy AI handler = hurt AI
$A0:A543 9D 8A 0F    STA $0F8A,x[$7E:10CA]  ;/
$A0:A546 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$A0:A549 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0
$A0:A54C BD 8C 0F    LDA $0F8C,x[$7E:10CC]  ;\
$A0:A54F 38          SEC                    ;|
$A0:A550 E5 12       SBC $12    [$7E:0012]  ;|
$A0:A552 10 03       BPL $03    [$A557]     ;} Enemy health = max(0, [enemy health] - [$12])
$A0:A554 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:A557 9D 8C 0F    STA $0F8C,x[$7E:10CC]  ;/
$A0:A55A A9 0B 00    LDA #$000B             ;\
$A0:A55D 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound Bh, sound library 2, max queued sounds allowed = 1 (enemy killed by contact damage)
$A0:A561 60          RTS                    ; Return

; BRANCH_NORMAL_SAMUS
$A0:A562 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A565 BD 78 0F    LDA $0F78,x[$7E:1078]  ;\
$A0:A568 AA          TAX                    ;|
$A0:A569 BF 06 00 A0 LDA $A00006,x[$A0:E205];} Deal suit-adjusted enemy damage to Samus
$A0:A56D 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;|
$A0:A571 22 51 DF 91 JSL $91DF51[$91:DF51]  ;/
$A0:A575 A9 60 00    LDA #$0060             ;\
$A0:A578 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60h
$A0:A57B A9 05 00    LDA #$0005             ;\
$A0:A57E 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 5
$A0:A581 A0 00 00    LDY #$0000             ; Knockback X direction = left
$A0:A584 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A587 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A0:A58A 38          SEC                    ;} If [enemy X position] <= [Samus X position]:
$A0:A58B FD 7A 0F    SBC $0F7A,x[$7E:107A]  ;|
$A0:A58E 30 03       BMI $03    [$A593]     ;/
$A0:A590 A0 01 00    LDY #$0001             ; Knockback X direction = right

$A0:A593 8C 54 0A    STY $0A54  [$7E:0A54]
$A0:A596 60          RTS
}
}


;;; $A597..A63C: Normal enemy power bomb AI ;;;
{
;;; $A597: Normal enemy power bomb AI ;;;
{
$A0:A597 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A59A 20 C1 A5    JSR $A5C1  [$A0:A5C1]  ; Normal enemy power bomb AI - no death check
$A0:A59D AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A5A0 BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A0:A5A3 D0 0E       BNE $0E    [$A5B3]     ;} If [enemy health] = 0:
$A0:A5A5 A9 03 00    LDA #$0003             ;\
$A0:A5A8 9F 02 70 7E STA $7E7002,x[$7E:7142];} Enemy cause of death = 3 (power bomb killed)
$A0:A5AC A9 00 00    LDA #$0000             ; A = 0 (small explosion)
$A0:A5AF 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death

$A0:A5B3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A5B6 6B          RTL
}


;;; $A5B7: Normal enemy power bomb AI - no death check (external) ;;;
{
; Called by rinka, fake Kraid, Kraid, Draygon, Ridley, Mother Brain
$A0:A5B7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A5BA 20 C1 A5    JSR $A5C1  [$A0:A5C1]  ; Normal enemy power bomb AI - no death check
$A0:A5BD AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A5C0 6B          RTL
}


;;; $A5C1: Normal enemy power bomb AI - no death check ;;;
{
$A0:A5C1 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A5C4 BD 78 0F    LDA $0F78,x[$7E:0FF8]  ;|
$A0:A5C7 AA          TAX                    ;} X = (enemy vulnerabilities)
$A0:A5C8 BF 3C 00 A0 LDA $A0003C,x[$A0:CEFB];/
$A0:A5CC D0 03       BNE $03    [$A5D1]     ; If [X] = 0:
$A0:A5CE A9 1C EC    LDA #$EC1C             ; X = $EC1C

$A0:A5D1 AA          TAX
$A0:A5D2 BF 0F 00 B4 LDA $B4000F,x[$B4:EDB7];\
$A0:A5D6 29 FF 00    AND #$00FF             ;|
$A0:A5D9 C9 FF 00    CMP #$00FF             ;} If [$B4:0000 + [X] + Fh] (enemy power bomb vulnerability)
$A0:A5DC F0 5E       BEQ $5E    [$A63C]     ;/
$A0:A5DE 29 7F 00    AND #$007F             ;\
$A0:A5E1 8D 32 0E    STA $0E32  [$7E:0E32]  ;} Enemy damage multiplier = (enemy power bomb vulnerability) & 7Fh
$A0:A5E4 F0 56       BEQ $56    [$A63C]     ; If [enemy damage multiplier] = 0: return
$A0:A5E6 A9 C8 00    LDA #$00C8             ;\
$A0:A5E9 4A          LSR A                  ;|
$A0:A5EA 85 26       STA $26    [$7E:0026]  ;|
$A0:A5EC AD 32 0E    LDA $0E32  [$7E:0E32]  ;|
$A0:A5EF 85 28       STA $28    [$7E:0028]  ;} $187A = 200 * [enemy damage multiplier] / 2 (damage)
$A0:A5F1 22 FF B6 A0 JSL $A0B6FF[$A0:B6FF]  ;|
$A0:A5F5 A5 2A       LDA $2A    [$7E:002A]  ;|
$A0:A5F7 8D 7A 18    STA $187A  [$7E:187A]  ;/
$A0:A5FA F0 40       BEQ $40    [$A63C]     ; >_<;
$A0:A5FC AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A5FF A9 30 00    LDA #$0030             ;\
$A0:A602 9D A0 0F    STA $0FA0,x[$7E:1020]  ;} Enemy invincibility timer = 30h
$A0:A605 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A608 BD 78 0F    LDA $0F78,x[$7E:0FF8]  ;\
$A0:A60B AA          TAX                    ;|
$A0:A60C BF 0D 00 A0 LDA $A0000D,x[$A0:CECC];} A = [enemy hurt AI time]
$A0:A610 29 FF 00    AND #$00FF             ;/
$A0:A613 D0 03       BNE $03    [$A618]     ; If [A] = 0:
$A0:A615 A9 04 00    LDA #$0004             ; A = 4

$A0:A618 18          CLC                    ;\
$A0:A619 69 08 00    ADC #$0008             ;|
$A0:A61C AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy flash timer = [A] + 8
$A0:A61F 9D 9C 0F    STA $0F9C,x[$7E:101C]  ;/
$A0:A622 BD 8A 0F    LDA $0F8A,x[$7E:100A]  ;\
$A0:A625 09 02 00    ORA #$0002             ;} Enemy AI handler = hurt AI
$A0:A628 9D 8A 0F    STA $0F8A,x[$7E:100A]  ;/
$A0:A62B BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A0:A62E 38          SEC                    ;|
$A0:A62F ED 7A 18    SBC $187A  [$7E:187A]  ;|
$A0:A632 F0 02       BEQ $02    [$A636]     ;|
$A0:A634 B0 03       BCS $03    [$A639]     ;} Enemy health = max(0, [enemy health] - (damage))
                                            ;|
$A0:A636 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:A639 9D 8C 0F    STA $0F8C,x[$7E:100C]  ;/

$A0:A63C 60          RTS
}
}


;;; $A63D..A8BB: Normal enemy shot AI ;;;
{
;;; $A63D: Normal enemy shot AI ;;;
{
$A0:A63D 9C 2E 0E    STZ $0E2E  [$7E:0E2E]  ; Clear enemy hit flag
$A0:A640 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A643 20 DE A6    JSR $A6DE  [$A0:A6DE]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A0:A646 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A649 AD 2E 0E    LDA $0E2E  [$7E:0E2E]  ;\
$A0:A64C F0 18       BEQ $18    [$A666]     ;} If enemy hit:
$A0:A64E AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A651 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A0:A654 85 12       STA $12    [$7E:0012]  ;|
$A0:A656 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;|
$A0:A659 85 14       STA $14    [$7E:0014]  ;|
$A0:A65B A9 37 00    LDA #$0037             ;} Create sprite object 37h (enemy shot) at enemy position
$A0:A65E 85 16       STA $16    [$7E:0016]  ;|
$A0:A660 64 18       STZ $18    [$7E:0018]  ;|
$A0:A662 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

$A0:A666 BD 8C 0F    LDA $0F8C,x[$7E:0FCC]  ;\
$A0:A669 D0 38       BNE $38    [$A6A3]     ;} If [enemy health] != 0: return
$A0:A66B AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A66E 0A          ASL A                  ;} Y = [collided projectile index] * 2
$A0:A66F A8          TAY                    ;/
$A0:A670 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:A673 EB          XBA                    ;|
$A0:A674 29 0F 00    AND #$000F             ;} Enemy cause of death = (projectile type)
$A0:A677 9F 02 70 7E STA $7E7002,x[$7E:7042];/
$A0:A67B A0 02 00    LDY #$0002             ; Y = 2 (normal explosion)
$A0:A67E C9 02 00    CMP #$0002             ;\
$A0:A681 F0 0D       BEQ $0D    [$A690]     ;} If projectile is not super missile:
$A0:A683 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\
$A0:A686 AA          TAX                    ;|
$A0:A687 BF 22 00 A0 LDA $A00022,x[$A0:F375];|
$A0:A68B F0 00       BEQ $00    [$A68D]     ;} Y = (enemy death animation)
                                            ;|
$A0:A68D A8          TAY                    ;/
$A0:A68E 80 0E       BRA $0E    [$A69E]

$A0:A690 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\ Else (projectile is super missile):
$A0:A693 AA          TAX                    ;|
$A0:A694 BF 22 00 A0 LDA $A00022,x[$A0:D061];} If (enemy death animation) >= 3:
$A0:A698 C9 03 00    CMP #$0003             ;|
$A0:A69B 30 01       BMI $01    [$A69E]     ;/
$A0:A69D A8          TAY                    ; Y = (enemy death animation)

$A0:A69E 98          TYA                    ; A = [Y]
$A0:A69F 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death

$A0:A6A3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A6A6 6B          RTL
}


;;; $A6A7: Normal enemy shot AI - no death check, no enemy shot graphic (external) ;;;
{
$A0:A6A7 9C 2E 0E    STZ $0E2E  [$7E:0E2E]  ; Clear enemy hit flag
$A0:A6AA AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A6AD 20 DE A6    JSR $A6DE  [$A0:A6DE]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A0:A6B0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A6B3 6B          RTL
}


;;; $A6B4: Normal enemy shot AI - no death check ;;;
{
; Used by Spore Spawn
; Shame it's not used by $A63D
$A0:A6B4 9C 2E 0E    STZ $0E2E  [$7E:0E2E]  ; Clear enemy hit flag
$A0:A6B7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A6BA 20 DE A6    JSR $A6DE  [$A0:A6DE]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A0:A6BD AD 2E 0E    LDA $0E2E  [$7E:0E2E]  ;\
$A0:A6C0 F0 18       BEQ $18    [$A6DA]     ;} If enemy hit:
$A0:A6C2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A6C5 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A0:A6C8 85 12       STA $12    [$7E:0012]  ;|
$A0:A6CA BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A0:A6CD 85 14       STA $14    [$7E:0014]  ;|
$A0:A6CF A9 37 00    LDA #$0037             ;} Create sprite object 37h (enemy shot) at enemy position
$A0:A6D2 85 16       STA $16    [$7E:0016]  ;|
$A0:A6D4 64 18       STZ $18    [$7E:0018]  ;|
$A0:A6D6 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

$A0:A6DA AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A6DD 6B          RTL
}


;;; $A6DE: Normal enemy shot AI - no death check, no enemy shot graphic ;;;
{
; Vulnerability format:
;     v = f000dddd
;     If v = FFh:
;         Freeze, no damage
;     Else:
;         d: Damage multiplier * 2
;         f: Does not freeze
$A0:A6DE 8B          PHB
$A0:A6DF AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A6E2 0A          ASL A                  ;} X = [collided projectile index] * 2
$A0:A6E3 AA          TAX                    ;/
$A0:A6E4 BD 2C 0C    LDA $0C2C,x[$7E:0C2C]  ;\
$A0:A6E7 8D 7A 18    STA $187A  [$7E:187A]  ;} $187A = [projectile damage]
$A0:A6EA BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$A0:A6ED 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile type]
$A0:A6EF DA          PHX                    ; <-- This is never meaningfully pulled >_<
$A0:A6F0 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A6F3 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;|
$A0:A6F6 AA          TAX                    ;} $14 = (enemy vulnerabilities)
$A0:A6F7 BF 3C 00 A0 LDA $A0003C,x[$A0:F38F];/
$A0:A6FB D0 03       BNE $03    [$A700]     ; If [$14] = 0:
$A0:A6FD A9 1C EC    LDA #$EC1C             ; $14 = $EC1C

$A0:A700 85 14       STA $14    [$7E:0014]
$A0:A702 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A704 89 00 0F    BIT #$0F00             ;} If not beam: go to BRANCH_NOT_BEAM
$A0:A707 D0 5A       BNE $5A    [$A763]     ;/
$A0:A709 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A70B 29 0F 00    AND #$000F             ;|
$A0:A70E 18          CLC                    ;|
$A0:A70F 65 14       ADC $14    [$7E:0014]  ;|
$A0:A711 AA          TAX                    ;} Enemy beam vulnerability = [$B4:0000 + [$14] + (beam type)]
$A0:A712 BF 00 00 B4 LDA $B40000,x[$B4:ECCC];|
$A0:A716 29 FF 00    AND #$00FF             ;|
$A0:A719 8D 40 0E    STA $0E40  [$7E:0E40]  ;/
$A0:A71C 29 7F 00    AND #$007F             ;\
$A0:A71F 8D 32 0E    STA $0E32  [$7E:0E32]  ;} Enemy damage multiplier = [enemy beam vulnerability] & 7Fh
$A0:A722 AD 40 0E    LDA $0E40  [$7E:0E40]  ;\
$A0:A725 C9 FF 00    CMP #$00FF             ;} If [enemy beam vulnerability] = FFh:
$A0:A728 D0 03       BNE $03    [$A72D]     ;/
$A0:A72A 4C D5 A7    JMP $A7D5  [$A0:A7D5]  ; Go to BRANCH_FREEZE

$A0:A72D A5 12       LDA $12    [$7E:0012]  ;\
$A0:A72F 89 10 00    BIT #$0010             ;} If beam is charged:
$A0:A732 F0 16       BEQ $16    [$A74A]     ;/
$A0:A734 A6 14       LDX $14    [$7E:0014]  ;\
$A0:A736 BF 13 00 B4 LDA $B40013,x[$B4:ED79];} A = [$B4:0000 + [$14] + 13h] (charged beam vulnerability)
$A0:A73A 29 FF 00    AND #$00FF             ;/
$A0:A73D C9 FF 00    CMP #$00FF             ;\
$A0:A740 F0 66       BEQ $66    [$A7A8]     ;} If (charged beam vulnerability) = FFh: go to BRANCH_NO_DAMAGE
$A0:A742 29 0F 00    AND #$000F             ;\
$A0:A745 F0 61       BEQ $61    [$A7A8]     ;} If (charged beam vulnerability) & Fh = 0: go to BRANCH_NO_DAMAGE
$A0:A747 8D 32 0E    STA $0E32  [$7E:0E32]  ; Enemy damage multiplier = (charged beam vulnerability) & Fh

; BRANCH_CALCULATE_DAMAGE
$A0:A74A AD 7A 18    LDA $187A  [$7E:187A]  ;\
$A0:A74D 4A          LSR A                  ;|
$A0:A74E 85 26       STA $26    [$7E:0026]  ;|
$A0:A750 AD 32 0E    LDA $0E32  [$7E:0E32]  ;|
$A0:A753 85 28       STA $28    [$7E:0028]  ;} If [projectile damage] * [enemy damage multiplier] / 2 = 0: go to BRANCH_NO_DAMAGE
$A0:A755 22 FF B6 A0 JSL $A0B6FF[$A0:B6FF]  ;|
$A0:A759 A5 2A       LDA $2A    [$7E:002A]  ;|
$A0:A75B F0 4B       BEQ $4B    [$A7A8]     ;/
$A0:A75D 8D 7A 18    STA $187A  [$7E:187A]  ; $187A = [projectile damage] * [enemy damage multiplier] / 2
$A0:A760 4C 08 A8    JMP $A808  [$A0:A808]  ; Go to BRANCH_DAMAGE

; BRANCH_NOT_BEAM
$A0:A763 29 00 0F    AND #$0F00             ;\
$A0:A766 C9 00 01    CMP #$0100             ;|
$A0:A769 F0 05       BEQ $05    [$A770]     ;} If not (super) missile: go to BRANCH_NOT_MISSILE
$A0:A76B C9 00 02    CMP #$0200             ;|
$A0:A76E D0 11       BNE $11    [$A781]     ;/

$A0:A770 EB          XBA                    ;\
$A0:A771 18          CLC                    ;|
$A0:A772 65 14       ADC $14    [$7E:0014]  ;|
$A0:A774 AA          TAX                    ;} Enemy damage multiplier = [$B4:0000 + [$14] + Bh + (missile type)] & 7Fh
$A0:A775 BF 0B 00 B4 LDA $B4000B,x[$B4:F0CC];|
$A0:A779 29 7F 00    AND #$007F             ;|
$A0:A77C 8D 32 0E    STA $0E32  [$7E:0E32]  ;/
$A0:A77F 80 C9       BRA $C9    [$A74A]     ; Go to BRANCH_CALCULATE_DAMAGE

; BRANCH_NOT_MISSILE
$A0:A781 C9 00 05    CMP #$0500             ;\
$A0:A784 D0 0E       BNE $0E    [$A794]     ;} If bomb:
$A0:A786 A6 14       LDX $14    [$7E:0014]  ;\
$A0:A788 BF 0E 00 B4 LDA $B4000E,x[$B4:EF84];|
$A0:A78C 29 7F 00    AND #$007F             ;} Enemy damage multiplier = [$B4:0000 + [$14] + Eh] & 7Fh
$A0:A78F 8D 32 0E    STA $0E32  [$7E:0E32]  ;/
$A0:A792 80 B6       BRA $B6    [$A74A]     ; Go to BRANCH_CALCULATE_DAMAGE

$A0:A794 C9 00 03    CMP #$0300             ;\
$A0:A797 D0 0F       BNE $0F    [$A7A8]     ;} If power bomb:
$A0:A799 A6 14       LDX $14    [$7E:0014]  ;\
$A0:A79B BF 0F 00 B4 LDA $B4000F,x          ;|
$A0:A79F 29 7F 00    AND #$007F             ;} Enemy damage multiplier = [$B4:0000 + [$14] + Fh] & 7Fh
$A0:A7A2 8D 32 0E    STA $0E32  [$7E:0E32]  ;/
$A0:A7A5 4C 4A A7    JMP $A74A  [$A0:A74A]  ; Go to BRANCH_CALCULATE_DAMAGE

; BRANCH_NO_DAMAGE
$A0:A7A8 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A7AB 0A          ASL A                  ;} X = [collided projectile index] * 2
$A0:A7AC AA          TAX                    ;/
$A0:A7AD BD 04 0C    LDA $0C04,x[$7E:0C06]  ;\
$A0:A7B0 09 10 00    ORA #$0010             ;} Flag projectile for deletion
$A0:A7B3 9D 04 0C    STA $0C04,x[$7E:0C06]  ;/
$A0:A7B6 BD 64 0B    LDA $0B64,x[$7E:0B66]  ;\
$A0:A7B9 85 12       STA $12    [$7E:0012]  ;|
$A0:A7BB BD 78 0B    LDA $0B78,x[$7E:0B7A]  ;|
$A0:A7BE 85 14       STA $14    [$7E:0014]  ;|
$A0:A7C0 A9 06 00    LDA #$0006             ;} Create sprite object 6 (dud shot) at projectile position
$A0:A7C3 85 16       STA $16    [$7E:0016]  ;|
$A0:A7C5 64 18       STZ $18    [$7E:0018]  ;|
$A0:A7C7 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A0:A7CB A9 3D 00    LDA #$003D             ;\
$A0:A7CE 22 35 90 80 JSL $809035[$80:9035]  ;} Queue sound 3Dh, sound library 1, max queued sounds allowed = 3 (dud shot)
$A0:A7D2 FA          PLX
$A0:A7D3 AB          PLB
$A0:A7D4 60          RTS                    ; Return

; BRANCH_FREEZE
$A0:A7D5 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A7D8 BD 9E 0F    LDA $0F9E,x[$7E:105E]  ;} If [enemy frozen timer] = 0:
$A0:A7DB D0 07       BNE $07    [$A7E4]     ;/
$A0:A7DD A9 0A 00    LDA #$000A             ;\
$A0:A7E0 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound Ah, sound library 3, max queued sounds allowed = 3 (enemy frozen)

$A0:A7E4 A0 90 01    LDY #$0190             ; Enemy freeze timer = 400
$A0:A7E7 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$A0:A7EA C9 02 00    CMP #$0002             ;} If [area index] = Norfair:
$A0:A7ED D0 03       BNE $03    [$A7F2]     ;/
$A0:A7EF A0 2C 01    LDY #$012C             ; Enemy freeze timer = 300

$A0:A7F2 98          TYA
$A0:A7F3 9D 9E 0F    STA $0F9E,x[$7E:105E]
$A0:A7F6 BD 8A 0F    LDA $0F8A,x[$7E:104A]  ;\
$A0:A7F9 09 04 00    ORA #$0004             ;} Enemy AI handler = frozen AI
$A0:A7FC 9D 8A 0F    STA $0F8A,x[$7E:104A]  ;/
$A0:A7FF A9 0A 00    LDA #$000A             ;\
$A0:A802 9D A0 0F    STA $0FA0,x[$7E:1060]  ;} Enemy invincibility timer = Ah
$A0:A805 FA          PLX
$A0:A806 AB          PLB
$A0:A807 60          RTS                    ; Return

; BRANCH_DAMAGE
$A0:A808 FA          PLX                    ;\
$A0:A809 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} >_<;
$A0:A80C AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A0:A80F BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;|
$A0:A812 AA          TAX                    ;} A = [enemy hurt AI time]
$A0:A813 BF 0D 00 A0 LDA $A0000D,x[$A0:F360];|
$A0:A817 29 FF 00    AND #$00FF             ;/
$A0:A81A D0 03       BNE $03    [$A81F]     ; If [A] = 0:
$A0:A81C A9 04 00    LDA #$0004             ; A = 4

$A0:A81F 18          CLC                    ;\
$A0:A820 69 08 00    ADC #$0008             ;|
$A0:A823 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy flash timer = [A] + 8
$A0:A826 9D 9C 0F    STA $0F9C,x[$7E:0FDC]  ;/
$A0:A829 BD 8A 0F    LDA $0F8A,x[$7E:0FCA]  ;\
$A0:A82C 09 02 00    ORA #$0002             ;} Enemy AI handler = hurt AI
$A0:A82F 9D 8A 0F    STA $0F8A,x[$7E:0FCA]  ;/
$A0:A832 BD 9E 0F    LDA $0F9E,x[$7E:0FDE]  ;\
$A0:A835 D0 15       BNE $15    [$A84C]     ;} If [enemy frozen timer] != 0: go to BRANCH_NO_FLASH_NO_CRY
$A0:A837 DA          PHX
$A0:A838 5A          PHY
$A0:A839 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\
$A0:A83C AA          TAX                    ;|
$A0:A83D BF 0E 00 A0 LDA $A0000E,x[$A0:F361];} If (enemy cry) != 0:
$A0:A841 F0 04       BEQ $04    [$A847]     ;/
$A0:A843 22 B7 90 80 JSL $8090B7[$80:90B7]  ; Queue (enemy cry), sound library 2, max queued sounds allowed = 3

$A0:A847 7A          PLY                    ;\
$A0:A848 FA          PLX                    ;} Yeah great, glad these were pushed...
$A0:A849 EE 2E 0E    INC $0E2E  [$7E:0E2E]  ; Set enemy hit flag

; BRANCH_NO_FLASH_NO_CRY
$A0:A84C AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:A84F AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A852 0A          ASL A                  ;} Y = [collided projectile index] * 2
$A0:A853 A8          TAY                    ;/
$A0:A854 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:A857 89 08 00    BIT #$0008             ;} If projectile is a plasma beam:
$A0:A85A F0 06       BEQ $06    [$A862]     ;/
$A0:A85C A9 10 00    LDA #$0010             ;\
$A0:A85F 9D A0 0F    STA $0FA0,x[$7E:0FA0]  ;} Enemy invincibility timer = 10h

$A0:A862 BD 8C 0F    LDA $0F8C,x[$7E:0FCC]  ;\
$A0:A865 38          SEC                    ;} A = [enemy health] - [projectile damage] * [enemy damage multiplier] / 2
$A0:A866 ED 7A 18    SBC $187A  [$7E:187A]  ;/
$A0:A869 F0 02       BEQ $02    [$A86D]     ;\
$A0:A86B B0 4A       BCS $4A    [$A8B7]     ;} If [A] > 0: go to BRANCH_RETURN

$A0:A86D AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A870 0A          ASL A                  ;} Y = [collided projectile index] * 2
$A0:A871 A8          TAY                    ;/
$A0:A872 B9 18 0C    LDA $0C18,y[$7E:0C18]  ;\
$A0:A875 29 02 00    AND #$0002             ;} If projectile is not ice beam: go to BRANCH_ENEMY_HEALTH_ZERO
$A0:A878 F0 3A       BEQ $3A    [$A8B4]     ;/
$A0:A87A AD 40 0E    LDA $0E40  [$7E:0E40]  ;\
$A0:A87D 29 F0 00    AND #$00F0             ;|
$A0:A880 C9 80 00    CMP #$0080             ;} If [enemy beam vulnerability] & F0h = 80h: go to BRANCH_ENEMY_HEALTH_ZERO
$A0:A883 F0 2F       BEQ $2F    [$A8B4]     ;/
$A0:A885 BD 9E 0F    LDA $0F9E,x[$7E:0FDE]  ;\
$A0:A888 D0 2A       BNE $2A    [$A8B4]     ;} If [enemy frozen timer] != 0: go to BRANCH_ENEMY_HEALTH_ZERO
$A0:A88A A0 90 01    LDY #$0190             ; Enemy freeze timer = 400
$A0:A88D AD 9F 07    LDA $079F  [$7E:079F]  ;\
$A0:A890 C9 02 00    CMP #$0002             ;} If [area index] = Norfair:
$A0:A893 D0 03       BNE $03    [$A898]     ;/
$A0:A895 A0 2C 01    LDY #$012C             ; Enemy freeze timer = 300

$A0:A898 98          TYA
$A0:A899 9D 9E 0F    STA $0F9E,x[$7E:0FDE]
$A0:A89C BD 8A 0F    LDA $0F8A,x[$7E:0FCA]  ;\
$A0:A89F 09 04 00    ORA #$0004             ;} Enemy AI handler = frozen AI
$A0:A8A2 9D 8A 0F    STA $0F8A,x[$7E:0FCA]  ;/
$A0:A8A5 A9 0A 00    LDA #$000A             ;\
$A0:A8A8 9D A0 0F    STA $0FA0,x[$7E:0FE0]  ;} Enemy invincibility timer = Ah
$A0:A8AB A9 0A 00    LDA #$000A             ;\
$A0:A8AE 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound Ah, sound library 3, max queued sounds allowed = 3 (enemy frozen)
$A0:A8B2 AB          PLB
$A0:A8B3 60          RTS                    ; Return

; BRANCH_ENEMY_HEALTH_ZERO
$A0:A8B4 A9 00 00    LDA #$0000             ; A = 0

; BRANCH_RETURN
$A0:A8B7 9D 8C 0F    STA $0F8C,x[$7E:0FCC]  ; Enemy health = [A]
$A0:A8BA AB          PLB
$A0:A8BB 60          RTS
}
}


;;; $A8BC: Creates a dud shot ;;;
{
$A0:A8BC DA          PHX
$A0:A8BD 5A          PHY
$A0:A8BE AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A8C1 0A          ASL A                  ;} X = [collided projectile index] * 2
$A0:A8C2 AA          TAX                    ;/
$A0:A8C3 BD 64 0B    LDA $0B64,x[$7E:0B66]  ;\
$A0:A8C6 85 12       STA $12    [$7E:0012]  ;|
$A0:A8C8 BD 78 0B    LDA $0B78,x[$7E:0B7A]  ;|
$A0:A8CB 85 14       STA $14    [$7E:0014]  ;|
$A0:A8CD A9 06 00    LDA #$0006             ;} Create sprite object 6 (dud shot) at projectile position
$A0:A8D0 85 16       STA $16    [$7E:0016]  ;|
$A0:A8D2 64 18       STZ $18    [$7E:0018]  ;|
$A0:A8D4 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A0:A8D8 A9 3D 00    LDA #$003D             ;\
$A0:A8DB 22 35 90 80 JSL $809035[$80:9035]  ;} Queue sound 3Dh, sound library 1, max queued sounds allowed = 3 (dud shot)
$A0:A8DF AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:A8E2 0A          ASL A                  ;|
$A0:A8E3 AA          TAX                    ;|
$A0:A8E4 BD 04 0C    LDA $0C04,x[$7E:0C06]  ;} Flag projectile for deletion
$A0:A8E7 09 10 00    ORA #$0010             ;|
$A0:A8EA 9D 04 0C    STA $0C04,x[$7E:0C06]  ;/
$A0:A8ED 7A          PLY
$A0:A8EE FA          PLX
$A0:A8EF 6B          RTL
}


;;; $A8F0: Samus / solid enemy collision detection ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     A: FFFFh if collision detected, 0 otherwise
;;     $12: If collision detected: distance to collision
;;     $14: If collision detected: 0
;;     $16: If collision detected: index of colliding enemy

; Solid enemy means an interactive enemy ($17EC) that is either frozen or whose hitbox is solid to Samus ([enemy properties] & 8000h != 0)
; If Samus is already partly within a solid enemy, that doesn't count as a collision

; Amazingly, there are no subroutine calls in here

; This routine considers it a collision if Samus' front boundary is one pixel in front of an enemy's front boundary,
; which seems to be important for moving solid enemies
; (otherwise if this routine were called with [$12].[$14] = 0.0, no collision would be detected even if the enemy is moving towards Samus)
; If you NOP'd out the INC at $A9A9 for example, you can do a short hop on one of the rising platform enemies and fall straight through

; The BEQs at $A931/A959/A980/A9A7 I can't make sense of based on the above logic. Seems like the increments/decrements should be unconditional
; Perhaps it affects the logic for choosing between BRANCH_TOUCHING and BRANCH_NOT_TOUCHING(?) Didn't notice any jank when NOP'ing the BEQs

; On the zebetite skip:
; The way this behaviour is implemented is effectively just incrementing the $12 parameter (unfortunately not written so straight forwardly)
; Consequently, Samus can collide with enemies one pixel further than she should be able to reach (i.e. one pixel further than in block collision),
; which explains why Samus collides with the frozen rinka in the zebetite skip, even though it's 2 pixels deep into the wall
; Because a collision is reported in this case, no Samus block collision detection is done, meaning Samus doesn't collide with the wall,
; and because the zebetite's right boundary is aligned with the wall (one pixel further right than the rinka's),
; Samus is now horizontally inside the zebetite, and so no horizontal collision will be detected due to the zebetite

$A0:A8F0 08          PHP
$A0:A8F1 8B          PHB
$A0:A8F2 F4 00 A0    PEA $A000              ;\
$A0:A8F5 AB          PLB                    ;} DB = $A0
$A0:A8F6 AB          PLB                    ;/
$A0:A8F7 C2 30       REP #$30
$A0:A8F9 AD A6 17    LDA $17A6  [$7E:17A6]  ;\
$A0:A8FC F0 02       BEQ $02    [$A900]     ;} If [interactive enemy indices stack pointer] = 0:
$A0:A8FE 80 06       BRA $06    [$A906]     ;/
$A0:A900 A9 00 00    LDA #$0000             ; Return A = 0
$A0:A903 AB          PLB
$A0:A904 28          PLP
$A0:A905 6B          RTL                    ; Return

$A0:A906 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$A0:A909 29 03 00    AND #$0003             ;|
$A0:A90C 0A          ASL A                  ;} Go to [$A911 + [collision direction] * 2]
$A0:A90D AA          TAX                    ;|
$A0:A90E 7C 11 A9    JMP ($A911,x)[$A0:A945];/

$A0:A911             dw A919, A945, A96C, A993

{
; Condition for $A933
;     [Samus X subposition] - [$14] >= 0 and [Samus X subposition] - [$14] != 0 or [Samus X subposition] - [$14] < 0 and [Samus target X position] != 0
; Lets just assume [Samus target X position] != 0
;     [Samus X subposition] - [$14] >= 0 and [Samus X subposition] - [$14] != 0 or [Samus X subposition] - [$14] < 0
;     [Samus X subposition] - [$14] > 0 or [Samus X subposition] - [$14] < 0
;     [Samus X subposition] - [$14] != 0
;     [Samus target X subposition] != 0

; Condition for $A95B
;     [Samus X subposition] + [$14] < 10000h and [Samus X subposition] + [$14] != 0 or [Samus X subposition] + [$14] >= 10000h and [Samus target X position] != 0
; Lets just assume [Samus target X position] != 0
;     [Samus X subposition] + [$14] < 10000h and [Samus X subposition] + [$14] != 0 or [Samus X subposition] + [$14] >= 10000h
;     [Samus X subposition] + [$14] != 0
;     [Samus X subposition] != 0 or [$14] != 0

; One might speculate that it wasn't realised that the `INC/DEC $189A` would affect the following `BEQ $03`,
; in which case the intended condition for $A933/$A95B was [Samus target X subposition] != 0

; Collision direction = left
$A0:A919 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A91B 49 FF FF    EOR #$FFFF             ;|
$A0:A91E 1A          INC A                  ;|
$A0:A91F 18          CLC                    ;|
$A0:A920 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;|
$A0:A923 8D 9A 18    STA $189A  [$7E:189A]  ;} Samus target X position = [Samus X position] - [$12].[$14]
$A0:A926 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;|
$A0:A929 38          SEC                    ;|
$A0:A92A E5 14       SBC $14    [$7E:0014]  ;|
$A0:A92C B0 03       BCS $03    [$A931]     ;|
$A0:A92E CE 9A 18    DEC $189A  [$7E:189A]  ;/

$A0:A931 F0 03       BEQ $03    [$A936]     ; If [Samus target X subposition] != 0:
$A0:A933 CE 9A 18    DEC $189A  [$7E:189A]  ; Decrement Samus target X position

$A0:A936 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:A939 8D 9E 18    STA $189E  [$7E:189E]  ;} Samus target Y position = [Samus Y position]
$A0:A93C AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A0:A93F 8D A0 18    STA $18A0  [$7E:18A0]  ;} Samus target Y subposition = [Samus Y subposition]
$A0:A942 4C B8 A9    JMP $A9B8  [$A0:A9B8]  ; Go to BRANCH_TARGET_POSITION_SET

; Collision direction = right
$A0:A945 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A947 18          CLC                    ;|
$A0:A948 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;|
$A0:A94B 8D 9A 18    STA $189A  [$7E:189A]  ;|
$A0:A94E A5 14       LDA $14    [$7E:0014]  ;} Samus target X position = [Samus X position] + [$12].[$14]
$A0:A950 18          CLC                    ;|
$A0:A951 6D F8 0A    ADC $0AF8  [$7E:0AF8]  ;|
$A0:A954 90 03       BCC $03    [$A959]     ;|
$A0:A956 EE 9A 18    INC $189A  [$7E:189A]  ;/

$A0:A959 F0 03       BEQ $03    [$A95E]     ; If [Samus X subposition] != 0 or [$14] != 0:
$A0:A95B EE 9A 18    INC $189A  [$7E:189A]  ; Increment Samus target X position

$A0:A95E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:A961 8D 9E 18    STA $189E  [$7E:189E]  ;} Samus target Y position = [Samus Y position]
$A0:A964 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A0:A967 8D A0 18    STA $18A0  [$7E:18A0]  ;} Samus target Y subposition = [Samus Y subposition]
$A0:A96A 80 4C       BRA $4C    [$A9B8]     ; Go to BRANCH_TARGET_POSITION_SET

; Collision direction = up
$A0:A96C AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:A96F 38          SEC                    ;|
$A0:A970 E5 12       SBC $12    [$7E:0012]  ;|
$A0:A972 8D 9E 18    STA $189E  [$7E:189E]  ;|
$A0:A975 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;} Samus target Y position = [Samus Y position] - [$12].[$14]
$A0:A978 38          SEC                    ;|
$A0:A979 E5 14       SBC $14    [$7E:0014]  ;|
$A0:A97B B0 03       BCS $03    [$A980]     ;|
$A0:A97D CE 9E 18    DEC $189E  [$7E:189E]  ;/

$A0:A980 F0 03       BEQ $03    [$A985]     ; If [Samus target Y subposition] != 0:
$A0:A982 CE 9E 18    DEC $189E  [$7E:189E]  ; Decrement Samus target Y position

$A0:A985 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:A988 8D 9A 18    STA $189A  [$7E:189A]  ;} Samus target X position = [Samus X position]
$A0:A98B AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$A0:A98E 8D 9C 18    STA $189C  [$7E:189C]  ;} Samus target X subposition = [Samus X subposition]
$A0:A991 80 25       BRA $25    [$A9B8]     ; Go to BRANCH_TARGET_POSITION_SET

; Collision direction = down
$A0:A993 A5 12       LDA $12    [$7E:0012]  ;\
$A0:A995 18          CLC                    ;|
$A0:A996 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$A0:A999 8D 9E 18    STA $189E  [$7E:189E]  ;|
$A0:A99C A5 14       LDA $14    [$7E:0014]  ;} Samus target Y position = [Samus Y position] + [$12].[$14]
$A0:A99E 18          CLC                    ;|
$A0:A99F 6D FC 0A    ADC $0AFC  [$7E:0AFC]  ;|
$A0:A9A2 90 03       BCC $03    [$A9A7]     ;|
$A0:A9A4 EE 9E 18    INC $189E  [$7E:189E]  ;/

$A0:A9A7 F0 03       BEQ $03    [$A9AC]     ; If [Samus Y subposition] != 0 or [$14] != 0:
$A0:A9A9 EE 9E 18    INC $189E  [$7E:189E]  ; Increment Samus target Y position

$A0:A9AC AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:A9AF 8D 9A 18    STA $189A  [$7E:189A]  ;} Samus target X position = [Samus X position]
$A0:A9B2 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$A0:A9B5 8D 9C 18    STA $189C  [$7E:189C]  ;} Samus target X subposition = [Samus X subposition]
}

; BRANCH_TARGET_POSITION_SET
$A0:A9B8 AD FE 0A    LDA $0AFE  [$7E:0AFE]  ;\
$A0:A9BB 8D A2 18    STA $18A2  [$7E:18A2]  ;} $18A2 = [Samus X radius]
$A0:A9BE AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$A0:A9C1 8D A4 18    STA $18A4  [$7E:18A4]  ;} $18A4 = [Samus Y radius]
$A0:A9C4 9C A6 18    STZ $18A6  [$7E:18A6]  ; Enemy index = 0
$A0:A9C7 9C AA 17    STZ $17AA  [$7E:17AA]  ; Interactive enemy indices index = 0

; LOOP
$A0:A9CA AC AA 17    LDY $17AA  [$7E:17AA]  ;\
$A0:A9CD B9 EC 17    LDA $17EC,y[$7E:17EC]  ;|
$A0:A9D0 C9 FF FF    CMP #$FFFF             ;} If [interactive enemy index] = FFFFh:
$A0:A9D3 D0 03       BNE $03    [$A9D8]     ;/
$A0:A9D5 4C 7B AB    JMP $AB7B  [$A0:AB7B]  ; Return A = 0

$A0:A9D8 8D A6 18    STA $18A6  [$7E:18A6]  ;\
$A0:A9DB AA          TAX                    ;} X = enemy index = [interactive enemy index]
$A0:A9DC BD 9E 0F    LDA $0F9E,x[$7E:0FDE]  ;\
$A0:A9DF D0 0B       BNE $0B    [$A9EC]     ;} If [enemy frozen timer] = 0:
$A0:A9E1 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A0:A9E4 89 00 80    BIT #$8000             ;} If enemy hitbox is not solid to Samus:
$A0:A9E7 D0 03       BNE $03    [$A9EC]     ;/
$A0:A9E9 4C BF AA    JMP $AABF  [$A0:AABF]  ; Go to BRANCH_NEXT

$A0:A9EC 8A          TXA                    ;\
$A0:A9ED 18          CLC                    ;|
$A0:A9EE 69 7A 0F    ADC #$0F7A             ;} X = enemy X position
$A0:A9F1 AA          TAX                    ;/
$A0:A9F2 A0 9A 18    LDY #$189A             ; Y = Samus target X position
$A0:A9F5 B5 00       LDA $00,x  [$7E:0FBA]  ;\
$A0:A9F7 38          SEC                    ;|
$A0:A9F8 F9 00 00    SBC $0000,y[$7E:189A]  ;|
$A0:A9FB 10 04       BPL $04    [$AA01]     ;|
$A0:A9FD 49 FF FF    EOR #$FFFF             ;|
$A0:AA00 1A          INC A                  ;|
                                            ;} If |[enemy X position] - [Samus target X position]| >= [enemy X radius] + [Samus X radius]: go to BRANCH_NEXT
$A0:AA01 38          SEC                    ;|
$A0:AA02 F5 08       SBC $08,x  [$7E:0FC2]  ;|
$A0:AA04 90 05       BCC $05    [$AA0B]     ;|
$A0:AA06 D9 08 00    CMP $0008,y[$7E:18A2]  ;|
$A0:AA09 B0 16       BCS $16    [$AA21]     ;/

$A0:AA0B B5 04       LDA $04,x  [$7E:0FBE]  ;\
$A0:AA0D 38          SEC                    ;|
$A0:AA0E F9 04 00    SBC $0004,y[$7E:189E]  ;|
$A0:AA11 10 04       BPL $04    [$AA17]     ;|
$A0:AA13 49 FF FF    EOR #$FFFF             ;|
$A0:AA16 1A          INC A                  ;|
                                            ;} If |[enemy Y position] - [Samus target Y position]| < [enemy Y radius] + [Samus Y radius]: go to BRANCH_COLLISION
$A0:AA17 38          SEC                    ;|
$A0:AA18 F5 0A       SBC $0A,x  [$7E:0FC4]  ;|
$A0:AA1A 90 08       BCC $08    [$AA24]     ;|
$A0:AA1C D9 0A 00    CMP $000A,y[$7E:18A4]  ;|
$A0:AA1F 90 03       BCC $03    [$AA24]     ;/

$A0:AA21 4C BF AA    JMP $AABF  [$A0:AABF]  ; Go to BRANCH_NEXT

; BRANCH_COLLISION
$A0:AA24 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$A0:AA27 29 03 00    AND #$0003             ;|
$A0:AA2A 0A          ASL A                  ;} Go to [$AA2F + [collision direction] * 2]
$A0:AA2B AA          TAX                    ;|
$A0:AA2C 7C 2F AA    JMP ($AA2F,x)[$A0:AA5C];/

$A0:AA2F             dw AA37, AA5C, AA7E, AAA0

{
; Collision direction = left
$A0:AA37 AE A6 18    LDX $18A6  [$7E:18A6]  ;\
$A0:AA3A BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A0:AA3D 18          CLC                    ;|
$A0:AA3E 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A0:AA41 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:AA44 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} A = (Samus left boundary position) - (enemy right boundary position) - 1
$A0:AA47 38          SEC                    ;|
$A0:AA48 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A0:AA4B 38          SEC                    ;|
$A0:AA4C ED 32 0E    SBC $0E32  [$7E:0E32]  ;/
$A0:AA4F F0 08       BEQ $08    [$AA59]     ; If (Samus left boundary position) = (enemy right boundary position) + 1: go to BRANCH_TOUCHING
$A0:AA51 10 03       BPL $03    [$AA56]     ; If (Samus left boundary position) > (enemy right boundary position) + 1: go to BRANCH_NOT_TOUCHING
$A0:AA53 4C 81 AB    JMP $AB81  [$A0:AB81]  ; Go to BRANCH_NEXT

$A0:AA56 4C 22 AB    JMP $AB22  [$A0:AB22]

$A0:AA59 4C C8 AA    JMP $AAC8  [$A0:AAC8]

; Collision direction = right
$A0:AA5C AE A6 18    LDX $18A6  [$7E:18A6]  ;\
$A0:AA5F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A0:AA62 18          CLC                    ;|
$A0:AA63 6D FE 0A    ADC $0AFE  [$7E:0AFE]  ;|
$A0:AA66 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:AA69 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;} A = (enemy left boundary position) - (Samus right boundary position) - 1
$A0:AA6C 38          SEC                    ;|
$A0:AA6D FD 82 0F    SBC $0F82,x[$7E:0FC2]  ;|
$A0:AA70 38          SEC                    ;|
$A0:AA71 ED 32 0E    SBC $0E32  [$7E:0E32]  ;/
$A0:AA74 F0 52       BEQ $52    [$AAC8]     ; If (Samus right boundary position) + 1 = (enemy left boundary position): go to BRANCH_TOUCHING
$A0:AA76 10 03       BPL $03    [$AA7B]     ; If (Samus right boundary position) + 1 < (enemy left boundary position): go to BRANCH_NOT_TOUCHING
$A0:AA78 4C 81 AB    JMP $AB81  [$A0:AB81]  ; Go to BRANCH_NEXT

$A0:AA7B 4C 22 AB    JMP $AB22  [$A0:AB22]

; Collision direction = up
$A0:AA7E AE A6 18    LDX $18A6  [$7E:18A6]  ;\
$A0:AA81 BD 7E 0F    LDA $0F7E,x[$7E:123E]  ;|
$A0:AA84 18          CLC                    ;|
$A0:AA85 7D 84 0F    ADC $0F84,x[$7E:1244]  ;|
$A0:AA88 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:AA8B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} A = (Samus top boundary position) - (enemy bottom boundary position) - 1
$A0:AA8E 38          SEC                    ;|
$A0:AA8F ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A0:AA92 38          SEC                    ;|
$A0:AA93 ED 32 0E    SBC $0E32  [$7E:0E32]  ;/
$A0:AA96 F0 30       BEQ $30    [$AAC8]     ; If (Samus top boundary position) = (enemy bottom boundary position) + 1: go to BRANCH_TOUCHING
$A0:AA98 10 03       BPL $03    [$AA9D]     ; If (Samus top boundary position) > (enemy bottom boundary position) + 1: go to BRANCH_NOT_TOUCHING
$A0:AA9A 4C 81 AB    JMP $AB81  [$A0:AB81]  ; Go to BRANCH_NEXT

$A0:AA9D 4C 22 AB    JMP $AB22  [$A0:AB22]

; Collision direction = down
$A0:AAA0 AE A6 18    LDX $18A6  [$7E:18A6]  ;\
$A0:AAA3 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A0:AAA6 18          CLC                    ;|
$A0:AAA7 6D 00 0B    ADC $0B00  [$7E:0B00]  ;|
$A0:AAAA 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:AAAD BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;} A = (enemy top boundary position) - (Samus bottom boundary position) - 1
$A0:AAB0 38          SEC                    ;|
$A0:AAB1 FD 84 0F    SBC $0F84,x[$7E:0FC4]  ;|
$A0:AAB4 38          SEC                    ;|
$A0:AAB5 ED 32 0E    SBC $0E32  [$7E:0E32]  ;/
$A0:AAB8 F0 0E       BEQ $0E    [$AAC8]     ; If (Samus bottom boundary position) + 1 = (enemy top boundary position): go to BRANCH_TOUCHING
$A0:AABA 10 66       BPL $66    [$AB22]     ; If (Samus bottom boundary position) + 1 < (enemy top boundary position): go to BRANCH_NOT_TOUCHING
$A0:AABC 4C 81 AB    JMP $AB81  [$A0:AB81]  ; Go to BRANCH_NEXT
}

; BRANCH_NEXT
$A0:AABF EE AA 17    INC $17AA  [$7E:17AA]  ;\
$A0:AAC2 EE AA 17    INC $17AA  [$7E:17AA]  ;} Interactive enemies indices index += 2
$A0:AAC5 4C CA A9    JMP $A9CA  [$A0:A9CA]  ; Go to LOOP

; BRANCH_TOUCHING
$A0:AAC8 9C FC 0A    STZ $0AFC  [$7E:0AFC]  ; Samus Y subposition = 0
$A0:AACB AE A6 18    LDX $18A6  [$7E:18A6]
$A0:AACE AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:AAD1 8D 4A 18    STA $184A  [$7E:184A]  ;} $184A = [Samus X position]
$A0:AAD4 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$A0:AAD7 8D 4C 18    STA $184C  [$7E:184C]  ;} $184C = [Samus X subposition]
$A0:AADA BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A0:AADD 8D 4E 18    STA $184E  [$7E:184E]  ;} $184E = [enemy X position]
$A0:AAE0 BD 7C 0F    LDA $0F7C,x[$7E:0FBC]  ;\
$A0:AAE3 8D 50 18    STA $1850  [$7E:1850]  ;} $1850 = [enemy X subposition]
$A0:AAE6 A5 12       LDA $12    [$7E:0012]  ;\
$A0:AAE8 8D 52 18    STA $1852  [$7E:1852]  ;} $1852 = [$12]
$A0:AAEB A5 14       LDA $14    [$7E:0014]  ;\
$A0:AAED 8D 54 18    STA $1854  [$7E:1854]  ;} $1854 = [$14]
$A0:AAF0 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:AAF3 8D 56 18    STA $1856  [$7E:1856]  ;} $1856 = [Samus Y position]
$A0:AAF6 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A0:AAF9 8D 58 18    STA $1858  [$7E:1858]  ;} $1858 = [Samus Y subposition]
$A0:AAFC A9 01 00    LDA #$0001             ;\
$A0:AAFF 8D 5A 18    STA $185A  [$7E:185A]  ;} $185A = 1
$A0:AB02 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (distance to collision)
$A0:AB04 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$A0:AB06 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:AB09 85 16       STA $16    [$7E:0016]  ;} $16 = [enemy index]
$A0:AB0B AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$A0:AB0E 29 03 00    AND #$0003             ;|
$A0:AB11 0A          ASL A                  ;|
$A0:AB12 AA          TAX                    ;} $182C + [collision direction] * 2 = [enemy index]
$A0:AB13 AD A6 18    LDA $18A6  [$7E:18A6]  ;|
$A0:AB16 9D 2C 18    STA $182C,x[$7E:182E]  ;/
$A0:AB19 9E 34 18    STZ $1834,x[$7E:1836]  ; $1834 + [collision direction] * 2 = 0
$A0:AB1C A9 FF FF    LDA #$FFFF             ; A = FFFFh
$A0:AB1F AB          PLB
$A0:AB20 28          PLP
$A0:AB21 6B          RTL                    ; Return

; BRANCH_NOT_TOUCHING
$A0:AB22 48          PHA
$A0:AB23 AE A6 18    LDX $18A6  [$7E:18A6]
$A0:AB26 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:AB29 8D 4A 18    STA $184A  [$7E:184A]  ;} $184A = [Samus X position]
$A0:AB2C AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$A0:AB2F 8D 4C 18    STA $184C  [$7E:184C]  ;} $184C = [Samus X subposition]
$A0:AB32 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A0:AB35 8D 4E 18    STA $184E  [$7E:184E]  ;} $184E = [enemy X position]
$A0:AB38 BD 7C 0F    LDA $0F7C,x[$7E:0FBC]  ;\
$A0:AB3B 8D 50 18    STA $1850  [$7E:1850]  ;} $1850 = [enemy X subposition]
$A0:AB3E A5 12       LDA $12    [$7E:0012]  ;\
$A0:AB40 8D 52 18    STA $1852  [$7E:1852]  ;} $1852 = [$12]
$A0:AB43 A5 14       LDA $14    [$7E:0014]  ;\
$A0:AB45 8D 54 18    STA $1854  [$7E:1854]  ;} $1854 = [$14]
$A0:AB48 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:AB4B 8D 56 18    STA $1856  [$7E:1856]  ;} $1856 = [Samus Y position]
$A0:AB4E AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A0:AB51 8D 58 18    STA $1858  [$7E:1858]  ;} $1858 = [Samus Y subposition]
$A0:AB54 A9 02 00    LDA #$0002             ;\
$A0:AB57 8D 5A 18    STA $185A  [$7E:185A]  ;} $185A = 2
$A0:AB5A AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$A0:AB5D 29 03 00    AND #$0003             ;|
$A0:AB60 0A          ASL A                  ;} X = [collision direction] * 2
$A0:AB61 AA          TAX                    ;/
$A0:AB62 68          PLA                    ;\
$A0:AB63 85 12       STA $12    [$7E:0012]  ;} $12 = $1834 + [collision direction] * 2 = [A] (distance to collision)
$A0:AB65 9D 34 18    STA $1834,x[$7E:1836]  ;/
$A0:AB68 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$A0:AB6A AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:AB6D 85 16       STA $16    [$7E:0016]  ;} $16 = [enemy index]
$A0:AB6F AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:AB72 9D 2C 18    STA $182C,x[$7E:182E]  ;} $182C + [collision direction] * 2 = [enemy index]
$A0:AB75 A9 FF FF    LDA #$FFFF             ; A = FFFFh
$A0:AB78 AB          PLB
$A0:AB79 28          PLP
$A0:AB7A 6B          RTL                    ; Return

$A0:AB7B A9 00 00    LDA #$0000
$A0:AB7E AB          PLB
$A0:AB7F 28          PLP
$A0:AB80 6B          RTL

$A0:AB81 4C BF AA    JMP $AABF  [$A0:AABF]

; Unused
$A0:AB84 48          PHA
$A0:AB85 AE A6 18    LDX $18A6  [$7E:18A6]
$A0:AB88 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:AB8B 8D 4A 18    STA $184A  [$7E:184A]  ;} $184A = [Samus X position]
$A0:AB8E AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$A0:AB91 8D 4C 18    STA $184C  [$7E:184C]  ;} $184C = [Samus X subposition]
$A0:AB94 BD 7A 0F    LDA $0F7A,x            ;\
$A0:AB97 8D 4E 18    STA $184E  [$7E:184E]  ;} $184E = [enemy X position]
$A0:AB9A BD 7C 0F    LDA $0F7C,x            ;\
$A0:AB9D 8D 50 18    STA $1850  [$7E:1850]  ;} $1850 = [enemy X subposition]
$A0:ABA0 A5 12       LDA $12    [$7E:0012]  ;\
$A0:ABA2 8D 52 18    STA $1852  [$7E:1852]  ;} $1852 = [$12]
$A0:ABA5 A5 14       LDA $14    [$7E:0014]  ;\
$A0:ABA7 8D 54 18    STA $1854  [$7E:1854]  ;} $1854 = [$14]
$A0:ABAA AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:ABAD 8D 56 18    STA $1856  [$7E:1856]  ;} $1856 = [Samus Y position]
$A0:ABB0 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$A0:ABB3 8D 58 18    STA $1858  [$7E:1858]  ;} $1858 = [Samus Y subposition]
$A0:ABB6 A9 03 00    LDA #$0003             ;\
$A0:ABB9 8D 5A 18    STA $185A  [$7E:185A]  ;} $185A = 3
$A0:ABBC AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$A0:ABBF 29 03 00    AND #$0003             ;|
$A0:ABC2 0A          ASL A                  ;} X = [collision direction] * 2
$A0:ABC3 AA          TAX                    ;/
$A0:ABC4 68          PLA                    ;\
$A0:ABC5 49 FF FF    EOR #$FFFF             ;|
$A0:ABC8 1A          INC A                  ;} $12 = -[A] (distance to collision)
$A0:ABC9 85 12       STA $12    [$7E:0012]  ;/
$A0:ABCB 9D 34 18    STA $1834,x            ; $1834 + [collision direction] * 2 = [$12]
$A0:ABCE 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$A0:ABD0 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:ABD3 85 16       STA $16    [$7E:0016]  ;} $16 = [enemy index]
$A0:ABD5 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A0:ABD8 9D 2C 18    STA $182C,x            ;} $182C + [collision direction] * 2 = [enemy index]
$A0:ABDB A9 FF FF    LDA #$FFFF             ; A = FFFFh
$A0:ABDE AB          PLB
$A0:ABDF 28          PLP
$A0:ABE0 6B          RTL                    ; Return

; Unused
$A0:ABE1 A9 00 00    LDA #$0000
$A0:ABE4 AB          PLB
$A0:ABE5 28          PLP
$A0:ABE6 6B          RTL
}


;;; $ABE7..C269: Utility functions ;;;
{
;;; $ABE7: Check if enemy is touching Samus from below - 4px margin ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     A: FFFFh if touching Samus, otherwise 0

; The (vertical) condition for touching here is:
;     Samus' midpoint is at least 4px higher than the enemy midpoint (this is the rough "from below" condition)
;     Samus' bottom boundary is at most 4px higher than the enemy top boundary (this is the rough "touching" condition)
$A0:ABE7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:ABEA 38          SEC                    ;|
$A0:ABEB FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A0:ABEE 10 04       BPL $04    [$ABF4]     ;|
$A0:ABF0 49 FF FF    EOR #$FFFF             ;|
$A0:ABF3 1A          INC A                  ;|
                                            ;} If |[Samus X position] - [enemy X position]| >= [Samus X radius] + [enemy X radius]:
$A0:ABF4 38          SEC                    ;|
$A0:ABF5 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A0:ABF8 90 09       BCC $09    [$AC03]     ;|
$A0:ABFA DD 82 0F    CMP $0F82,x[$7E:0F82]  ;|
$A0:ABFD 90 04       BCC $04    [$AC03]     ;/
$A0:ABFF A9 00 00    LDA #$0000             ;\
$A0:AC02 6B          RTL                    ;} Return A = 0

$A0:AC03 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:AC06 18          CLC                    ;|
$A0:AC07 69 03 00    ADC #$0003             ;|
$A0:AC0A 38          SEC                    ;} If [enemy Y position] - 4 < [Samus Y position]: return A = 0
$A0:AC0B FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$A0:AC0E 10 11       BPL $11    [$AC21]     ;/
$A0:AC10 49 FF FF    EOR #$FFFF             ;\
$A0:AC13 1A          INC A                  ;|
$A0:AC14 38          SEC                    ;|
$A0:AC15 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A0:AC18 90 0B       BCC $0B    [$AC25]     ;} If (enemy top boundary) - 4 <= (Samus bottom boundary): return A = FFFFh
$A0:AC1A DD 84 0F    CMP $0F84,x[$7E:0F84]  ;|
$A0:AC1D F0 06       BEQ $06    [$AC25]     ;|
$A0:AC1F 90 04       BCC $04    [$AC25]     ;/

$A0:AC21 A9 00 00    LDA #$0000             ;\
$A0:AC24 6B          RTL                    ;} Return A = 0

$A0:AC25 A9 FF FF    LDA #$FFFF
$A0:AC28 6B          RTL
}


;;; $AC29: Unused. Check if enemy is touching Samus from below - 1px margin ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     A: FFFFh if touching Samus, otherwise 0
$A0:AC29 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:AC2C 38          SEC                    ;|
$A0:AC2D FD 7A 0F    SBC $0F7A,x            ;|
$A0:AC30 10 04       BPL $04    [$AC36]     ;|
$A0:AC32 49 FF FF    EOR #$FFFF             ;|
$A0:AC35 1A          INC A                  ;|
                                            ;} If |[Samus X position] - [enemy X position]| >= [Samus X radius] + [enemy X radius]:
$A0:AC36 38          SEC                    ;|
$A0:AC37 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A0:AC3A 90 09       BCC $09    [$AC45]     ;|
$A0:AC3C DD 82 0F    CMP $0F82,x            ;|
$A0:AC3F 90 04       BCC $04    [$AC45]     ;/
$A0:AC41 A9 00 00    LDA #$0000             ;\
$A0:AC44 6B          RTL                    ;} Return A = 0

$A0:AC45 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:AC48 38          SEC                    ;|
$A0:AC49 FD 7E 0F    SBC $0F7E,x            ;} If [enemy Y position] <= [Samus Y position]: return A = 0
$A0:AC4C 10 11       BPL $11    [$AC5F]     ;/
$A0:AC4E 49 FF FF    EOR #$FFFF             ;\
$A0:AC51 1A          INC A                  ;|
$A0:AC52 38          SEC                    ;|
$A0:AC53 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A0:AC56 90 0B       BCC $0B    [$AC63]     ;} If (enemy top boundary) <= (Samus bottom boundary) + 1: return A = FFFFh
$A0:AC58 DD 84 0F    CMP $0F84,x            ;|
$A0:AC5B F0 06       BEQ $06    [$AC63]     ;|
$A0:AC5D 90 04       BCC $04    [$AC63]     ;/

$A0:AC5F A9 00 00    LDA #$0000             ;\
$A0:AC62 6B          RTL                    ;} Return A = 0

$A0:AC63 A9 FF FF    LDA #$FFFF
$A0:AC66 6B          RTL
}


;;; $AC67: Check if enemy is touching Samus ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     A: FFFFh if touching Samus, otherwise 0
$A0:AC67 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:AC6A 38          SEC                    ;|
$A0:AC6B FD 7A 0F    SBC $0F7A,x            ;|
$A0:AC6E 10 04       BPL $04    [$AC74]     ;|
$A0:AC70 49 FF FF    EOR #$FFFF             ;|
$A0:AC73 1A          INC A                  ;|
                                            ;|
$A0:AC74 38          SEC                    ;} If |[Samus X position] - [enemy X position]| >= [Samus X radius] + max(8, [enemy X radius]):
$A0:AC75 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A0:AC78 90 0E       BCC $0E    [$AC88]     ;|
$A0:AC7A DD 82 0F    CMP $0F82,x            ;|
$A0:AC7D 90 09       BCC $09    [$AC88]     ;|
$A0:AC7F C9 08 00    CMP #$0008             ;|
$A0:AC82 90 04       BCC $04    [$AC88]     ;/
$A0:AC84 A9 00 00    LDA #$0000             ;\
$A0:AC87 6B          RTL                    ;} Return A = 0

$A0:AC88 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:AC8B 38          SEC                    ;|
$A0:AC8C FD 7E 0F    SBC $0F7E,x            ;|
$A0:AC8F 10 04       BPL $04    [$AC95]     ;|
$A0:AC91 49 FF FF    EOR #$FFFF             ;|
$A0:AC94 1A          INC A                  ;|
                                            ;} If |[Samus Y position] - [enemy Y position]| >= [Samus Y radius] + [enemy Y radius]:
$A0:AC95 38          SEC                    ;|
$A0:AC96 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$A0:AC99 90 09       BCC $09    [$ACA4]     ;|
$A0:AC9B DD 84 0F    CMP $0F84,x            ;|
$A0:AC9E 90 04       BCC $04    [$ACA4]     ;/
$A0:ACA0 A9 00 00    LDA #$0000             ;\
$A0:ACA3 6B          RTL                    ;} Return A = 0

$A0:ACA4 A9 FF FF    LDA #$FFFF             ;\
$A0:ACA7 6B          RTL                    ;} Return A = FFFFh
}


;;; $ACA8: Calculate distance and angle of Samus from enemy ;;;
{
;; Parameters:
;;     $0E32: Enemy X position
;;     $0E34: Enemy Y position
;;     $0E36: Samus X position
;;     $0E38: Samus Y position
;; Returns:
;;     Carry: Set if error, clear otherwise
;;     A: If carry clear, distance from enemy to Samus
;;     $0E3A: If carry clear, angle from enemy to Samus

; Called by yapping maw only
; Avoids sqrt and division operations with the identity
;     sqrt(x² + y²) = x cos(arctan(x, y)) + y sin(arctan(x, y))
; (tweaked to account for SM's angle convention)
; Slightly unfortunate second call to $C0AE, would have been sufficient to call it once to get $0E3A and normalise the quadrant with
;     LDA $0E3A : AND #$007F : CMP #$0040 : BCS + : EOR #$007F : INC : + : STA $0E24

$A0:ACA8 DA          PHX
$A0:ACA9 5A          PHY
$A0:ACAA AD 36 0E    LDA $0E36  [$7E:0E36]  ;\
$A0:ACAD 38          SEC                    ;|
$A0:ACAE ED 32 0E    SBC $0E32  [$7E:0E32]  ;} $0E3C = [Samus X position] - [enemy X position]
$A0:ACB1 8D 3C 0E    STA $0E3C  [$7E:0E3C]  ;/
$A0:ACB4 10 04       BPL $04    [$ACBA]     ;\
$A0:ACB6 49 FF FF    EOR #$FFFF             ;} A = |[Samus X position] - [enemy X position]|
$A0:ACB9 1A          INC A                  ;/

$A0:ACBA C9 FF 00    CMP #$00FF             ;\
$A0:ACBD 10 70       BPL $70    [$AD2F]     ;} If [A] >= FFh: return carry set
$A0:ACBF 85 12       STA $12    [$7E:0012]  ;\
$A0:ACC1 8D 20 0E    STA $0E20  [$7E:0E20]  ;} $12 = $0E20 = |[Samus X position] - [enemy X position]|
$A0:ACC4 AD 38 0E    LDA $0E38  [$7E:0E38]  ;\
$A0:ACC7 38          SEC                    ;|
$A0:ACC8 ED 34 0E    SBC $0E34  [$7E:0E34]  ;} $0E3E = [Samus Y position] - [enemy Y position]
$A0:ACCB 8D 3E 0E    STA $0E3E  [$7E:0E3E]  ;/
$A0:ACCE 10 04       BPL $04    [$ACD4]     ;\
$A0:ACD0 49 FF FF    EOR #$FFFF             ;} A = |[Samus Y position] - [enemy Y position]|
$A0:ACD3 1A          INC A                  ;/

$A0:ACD4 C9 FF 00    CMP #$00FF             ;\
$A0:ACD7 10 56       BPL $56    [$AD2F]     ;} If [A] >= FFh: return carry set
$A0:ACD9 85 14       STA $14    [$7E:0014]  ;\
$A0:ACDB 8D 22 0E    STA $0E22  [$7E:0E22]  ;} $14 = $0E22 = |[Samus Y position] - [enemy Y position]|
$A0:ACDE 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;\
$A0:ACE2 8D 24 0E    STA $0E24  [$7E:0E24]  ;} $0E24 = angle of ([$12], [$14]) offset (angle from enemy to Samus reflected to down-right quadrant)
$A0:ACE5 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$A0:ACE8 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:ACEB AD 24 0E    LDA $0E24  [$7E:0E24]  ;|
$A0:ACEE 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A0:ACF2 89 00 80    BIT #$8000             ;|
$A0:ACF5 F0 04       BEQ $04    [$ACFB]     ;} $0E26 = |[$0E20] * -sin([$0E24] * pi / 80h)|
$A0:ACF7 49 FF FF    EOR #$FFFF             ;|
$A0:ACFA 1A          INC A                  ;|
                                            ;|
$A0:ACFB 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$A0:ACFE AD 22 0E    LDA $0E22  [$7E:0E22]  ;\
$A0:AD01 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:AD04 AD 24 0E    LDA $0E24  [$7E:0E24]  ;|
$A0:AD07 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;|
$A0:AD0B 89 00 80    BIT #$8000             ;|
$A0:AD0E F0 04       BEQ $04    [$AD14]     ;} A = [$0E26] + |[$0E22] * cos([$0E24] * pi / 80h)|
$A0:AD10 49 FF FF    EOR #$FFFF             ;|
$A0:AD13 1A          INC A                  ;|
                                            ;|
$A0:AD14 18          CLC                    ;|
$A0:AD15 6D 26 0E    ADC $0E26  [$7E:0E26]  ;/
$A0:AD18 48          PHA                    ;\
$A0:AD19 AD 3C 0E    LDA $0E3C  [$7E:0E3C]  ;|
$A0:AD1C 85 12       STA $12    [$7E:0012]  ;|
$A0:AD1E AD 3E 0E    LDA $0E3E  [$7E:0E3E]  ;|
$A0:AD21 85 14       STA $14    [$7E:0014]  ;} $0E3A = angle from enemy to Samus
$A0:AD23 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;|
$A0:AD27 8D 3A 0E    STA $0E3A  [$7E:0E3A]  ;|
$A0:AD2A 68          PLA                    ;/
$A0:AD2B 7A          PLY
$A0:AD2C FA          PLX
$A0:AD2D 18          CLC                    ;\
$A0:AD2E 6B          RTL                    ;} Return carry clear

$A0:AD2F 7A          PLY
$A0:AD30 FA          PLX
$A0:AD31 38          SEC                    ;\
$A0:AD32 6B          RTL                    ;} Return carry set
}


;;; $AD33: Unused. Enemy $0FB0 = max(0, [enemy $0FB0] - 1). If [enemy $0FB0] = 0, A = 1, else A = 0 ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AD33 8B          PHB
$A0:AD34 E2 20       SEP #$20
$A0:AD36 A9 A0       LDA #$A0               ;\
$A0:AD38 48          PHA                    ;} DB = $A0
$A0:AD39 AB          PLB                    ;/
$A0:AD3A C2 30       REP #$30
$A0:AD3C BD B0 0F    LDA $0FB0,x            ;\
$A0:AD3F F0 09       BEQ $09    [$AD4A]     ;} If [enemy $0FB0] != 0:
$A0:AD41 DE B0 0F    DEC $0FB0,x            ; Decrement enemy $0FB0
$A0:AD44 F0 04       BEQ $04    [$AD4A]     ; If [enemy $0FB0] != 0:
$A0:AD46 A9 00 00    LDA #$0000             ;\
$A0:AD49 6B          RTL                    ;} Return A = 0 (bug, doesn't pull DB, will crash)

$A0:AD4A A9 01 00    LDA #$0001             ;\
$A0:AD4D AB          PLB                    ;} Return A = 1
$A0:AD4E 6B          RTL                    ;/
}


;;; $AD4F: Unused. A = sgn([A]) (zero is special case) ;;;
{
; It's assumed that the zero flag corresponds to A
$A0:AD4F D0 04       BNE $04    [$AD55] ; If [A] = 0:
$A0:AD51 A9 00 00    LDA #$0000         ;\
$A0:AD54 6B          RTL                ;} Return A = 0

$A0:AD55 C9 00 80    CMP #$8000         ;\
$A0:AD58 30 04       BMI $04    [$AD5E] ;} If [A] < 0:
$A0:AD5A A9 FF FF    LDA #$FFFF         ;\
$A0:AD5D 6B          RTL                ;} Return A = -1

$A0:AD5E A9 01 00    LDA #$0001         ;\
$A0:AD61 6B          RTL                ;} Return A = 1
}


;;; $AD62: Unused. A = |[A]| ;;;
{
$A0:AD62 A8          TAY                ;\
$A0:AD63 29 00 80    AND #$8000         ;|
$A0:AD66 D0 02       BNE $02    [$AD6A] ;} If [A] >= 0:
$A0:AD68 98          TYA                ;/
$A0:AD69 6B          RTL                ; Return

$A0:AD6A 98          TYA
$A0:AD6B 49 FF FF    EOR #$FFFF         ;\
$A0:AD6E 1A          INC A              ;} Negate A
$A0:AD6F 6B          RTL                ; Return
}


;;; $AD70: Check if enemy centre is on screen or not ;;;
{
;; Returns:
;;     A/zero: 0/set if enemy centre is on screen, 1/clear otherwise
$A0:AD70 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:AD73 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A0:AD76 CD 11 09    CMP $0911  [$7E:0911]  ;|
$A0:AD79 30 24       BMI $24    [$AD9F]     ;|
$A0:AD7B AD 11 09    LDA $0911  [$7E:0911]  ;|
$A0:AD7E 18          CLC                    ;} If [layer 1 X position] <= [enemy X position] <= [layer 1 X position] + 100h:
$A0:AD7F 69 00 01    ADC #$0100             ;|
$A0:AD82 DD 7A 0F    CMP $0F7A,x[$7E:107A]  ;|
$A0:AD85 30 18       BMI $18    [$AD9F]     ;/
$A0:AD87 BD 7E 0F    LDA $0F7E,x[$7E:107E]  ;\
$A0:AD8A CD 15 09    CMP $0915  [$7E:0915]  ;|
$A0:AD8D 30 10       BMI $10    [$AD9F]     ;|
$A0:AD8F AD 15 09    LDA $0915  [$7E:0915]  ;|
$A0:AD92 18          CLC                    ;} If [layer 1 Y position] <= [enemy Y position] <= [layer 1 Y position] + 100h:
$A0:AD93 69 00 01    ADC #$0100             ;|
$A0:AD96 DD 7E 0F    CMP $0F7E,x[$7E:107E]  ;|
$A0:AD99 30 04       BMI $04    [$AD9F]     ;/
$A0:AD9B A9 00 00    LDA #$0000             ;\
$A0:AD9E 6B          RTL                    ;} Return A = 0

$A0:AD9F A9 01 00    LDA #$0001             ;\
$A0:ADA2 6B          RTL                    ;} Return A = 1
}


;;; $ADA3: Check if enemy centre is over [A] pixels off-screen ;;;
{
;; Parameters:
;;     A: Target off-screen distance
;; Returns:
;;     Zero: Clear if enemy centre is over [A] pixels off-screen, set otherwise

; Called by evir only
$A0:ADA3 DA          PHX
$A0:ADA4 85 12       STA $12    [$7E:0012]  ; $12 = [A]
$A0:ADA6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:ADA9 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A0:ADAC 18          CLC                    ;|
$A0:ADAD 65 12       ADC $12    [$7E:0012]  ;|
$A0:ADAF CD 11 09    CMP $0911  [$7E:0911]  ;|
$A0:ADB2 30 2E       BMI $2E    [$ADE2]     ;|
$A0:ADB4 AD 11 09    LDA $0911  [$7E:0911]  ;|
$A0:ADB7 18          CLC                    ;} If [layer 1 X position] - [$12] <= [enemy X position] <= [layer 1 X position] + 100h + [$12]:
$A0:ADB8 69 00 01    ADC #$0100             ;|
$A0:ADBB 18          CLC                    ;|
$A0:ADBC 65 12       ADC $12    [$7E:0012]  ;|
$A0:ADBE DD 7A 0F    CMP $0F7A,x[$7E:0FFA]  ;|
$A0:ADC1 30 1F       BMI $1F    [$ADE2]     ;/
$A0:ADC3 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A0:ADC6 18          CLC                    ;|
$A0:ADC7 65 12       ADC $12    [$7E:0012]  ;|
$A0:ADC9 CD 15 09    CMP $0915  [$7E:0915]  ;|
$A0:ADCC 30 14       BMI $14    [$ADE2]     ;|
$A0:ADCE AD 15 09    LDA $0915  [$7E:0915]  ;|
$A0:ADD1 18          CLC                    ;} If [layer 1 Y position] - [$12] <= [enemy Y position] <= [layer 1 Y position] + 100h + [$12]:
$A0:ADD2 69 00 01    ADC #$0100             ;|
$A0:ADD5 18          CLC                    ;|
$A0:ADD6 65 12       ADC $12    [$7E:0012]  ;|
$A0:ADD8 DD 7E 0F    CMP $0F7E,x[$7E:0FFE]  ;|
$A0:ADDB 30 05       BMI $05    [$ADE2]     ;/
$A0:ADDD FA          PLX
$A0:ADDE A9 00 00    LDA #$0000             ;\
$A0:ADE1 6B          RTL                    ;} Return zero set

$A0:ADE2 FA          PLX
$A0:ADE3 A9 01 00    LDA #$0001             ;\
$A0:ADE6 6B          RTL                    ;} Return zero clear
}


;;; $ADE7: Check if enemy is on screen or not off screen ;;;
{
;; Returns:
;;     A/zero: 0/set if enemy centre is on screen, 1/clear otherwise
$A0:ADE7 DA          PHX
$A0:ADE8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:ADEB BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A0:ADEE 18          CLC                    ;|
$A0:ADEF 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A0:ADF2 CD 11 09    CMP $0911  [$7E:0911]  ;|
$A0:ADF5 30 2D       BMI $2D    [$AE24]     ;|
$A0:ADF7 AD 11 09    LDA $0911  [$7E:0911]  ;|
$A0:ADFA 18          CLC                    ;} If [layer 1 X position] - [enemy X radius] <= [enemy X position] <= [layer 1 X position] + 100h + [enemy X radius]:
$A0:ADFB 69 00 01    ADC #$0100             ;|
$A0:ADFE 18          CLC                    ;|
$A0:ADFF 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A0:AE02 DD 7A 0F    CMP $0F7A,x[$7E:0F7A]  ;|
$A0:AE05 30 1D       BMI $1D    [$AE24]     ;/
$A0:AE07 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A0:AE0A 18          CLC                    ;|
$A0:AE0B 69 08 00    ADC #$0008             ;|
$A0:AE0E CD 15 09    CMP $0915  [$7E:0915]  ;|
$A0:AE11 30 11       BMI $11    [$AE24]     ;|
$A0:AE13 AD 15 09    LDA $0915  [$7E:0915]  ;} If [layer 1 Y position] - 8 <= [enemy X position] <= [layer 1 X position] + F8h:
$A0:AE16 18          CLC                    ;|
$A0:AE17 69 F8 00    ADC #$00F8             ;|
$A0:AE1A DD 7E 0F    CMP $0F7E,x[$7E:0F7E]  ;|
$A0:AE1D 30 05       BMI $05    [$AE24]     ;/
$A0:AE1F FA          PLX
$A0:AE20 A9 00 00    LDA #$0000             ;\
$A0:AE23 6B          RTL                    ;} Return zero set

$A0:AE24 FA          PLX
$A0:AE25 A9 01 00    LDA #$0001             ;\
$A0:AE28 6B          RTL                    ;} Return zero clear
}


;;; $AE29: Determine direction of Samus from enemy ;;;
{
;; Returns:
;;     A: Direction
;;         0: Up         - Samus is not within 2 block rows of enemy, is within 2 block columns of enemy, and Samus is above enemy
;;         1: Up-right   - Samus is not within 2 blocks of enemy, Samus is right of enemy, and Samus is above enemy
;;         2: Right      - Samus is within 2 block rows of enemy and Samus is right of enemy
;;         3: Down-right - Samus is not within 2 blocks of enemy, Samus is right of enemy, and Samus is below enemy
;;         4: Down       - Samus is not within 2 block rows of enemy, is within 2 block columns of enemy, and Samus is below enemy
;;         6: Down-left  - Samus is not within 2 blocks of enemy, Samus is left of enemy, and Samus is below enemy
;;         7: Left       - Samus is within 2 block rows of enemy and Samus is left of enemy
;;         8: Up-left    - Samus is not within 2 blocks of enemy, Samus is left of enemy, and Samus is above enemy

; Graphically, return values are as follows where # is the enemy and each numeral is a block
; 8888 0000 1111
; 8888 0000 1111
; 8888 0000 1111
; 7777 7722 2222
; 7777 7722 2222
; 7777 77#2 2222
; 7777 7722 2222
; 6666 4444 3333
; 6666 4444 3333
; 6666 4444 3333

; Note that 5 and 9 cannot be returned, but otherwise these values match up with the projectile directions ($0C04)

$A0:AE29 AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:AE2C A9 20 00    LDA #$0020             ;\
$A0:AE2F 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} If Samus is not within 20h pixels rows of enemy: go to BRANCH_NOT_LEFT_NOR_RIGHT
$A0:AE33 F0 0E       BEQ $0E    [$AE43]     ;/
$A0:AE35 A0 02 00    LDY #$0002             ; Y = 2
$A0:AE38 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A0:AE3C 10 03       BPL $03    [$AE41]     ;} If Samus is left of enemy:
$A0:AE3E A0 07 00    LDY #$0007             ; Y = 7

$A0:AE41 98          TYA                    ; A = [Y]
$A0:AE42 6B          RTL                    ; Return

; BRANCH_NOT_LEFT_NOR_RIGHT
$A0:AE43 A9 20 00    LDA #$0020             ;\
$A0:AE46 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;} If Samus is not within 20h pixels columns of enemy: go to BRANCH_NOT_ABOVE_OR_BELOW
$A0:AE4A F0 0E       BEQ $0E    [$AE5A]     ;/
$A0:AE4C A0 04 00    LDY #$0004             ; Y = 4
$A0:AE4F 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A0:AE53 10 03       BPL $03    [$AE58]     ;} If Samus is above enemy:
$A0:AE55 A0 00 00    LDY #$0000             ; Y = 0

$A0:AE58 98          TYA                    ; A = [Y]
$A0:AE59 6B          RTL                    ; Return

; BRANCH_NOT_ABOVE_OR_BELOW
$A0:AE5A 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A0:AE5E 30 0E       BMI $0E    [$AE6E]     ;} If Samus is left of enemy: go to BRANCH_NOT_DIAGONALLY_RIGHT
$A0:AE60 A0 03 00    LDY #$0003             ; Y = 3
$A0:AE63 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A0:AE67 10 03       BPL $03    [$AE6C]     ;} If Samus is above enemy:
$A0:AE69 A0 01 00    LDY #$0001             ; Y = 1

$A0:AE6C 98          TYA                    ; A = [Y]
$A0:AE6D 6B          RTL                    ; Return

; BRANCH_NOT_DIAGONALLY_RIGHT
$A0:AE6E A0 06 00    LDY #$0006             ; Y = 6
$A0:AE71 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A0:AE75 10 03       BPL $03    [$AE7A]     ;} If Samus is above enemy:
$A0:AE77 A0 08 00    LDY #$0008             ; Y = 8


$A0:AE7A 98          TYA                    ; A = [Y]
$A0:AE7B 6B          RTL
}


;;; $AE7C: Unused. Proto instruction list handler ;;;
{
; Uses $A0:002A(!) as pointer to instruction list pointer table, indexed by [enemy $0F92] * 2
; Enemy $0F90 is the instruction list pointer, and these instruction lists terminate with FFFFh and loop with FFFEh
; No support for ASM commands
$A0:AE7C AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:AE7F BD 78 0F    LDA $0F78,x            ;\
$A0:AE82 AA          TAX                    ;|
$A0:AE83 BF 2A 00 A0 LDA $A0002A,x          ;} $0E20 = [$A0:002A + [enemy ID]]
$A0:AE87 8D 20 0E    STA $0E20  [$7E:0E20]  ;/
$A0:AE8A AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:AE8D BD 92 0F    LDA $0F92,x            ;\
$A0:AE90 0A          ASL A                  ;|
$A0:AE91 18          CLC                    ;|
$A0:AE92 6D 20 0E    ADC $0E20  [$7E:0E20]  ;} Y = [[$0E20] + [enemy $0F92] * 2]
$A0:AE95 A8          TAY                    ;|
$A0:AE96 BE 00 00    LDX $0000,y            ;|
$A0:AE99 9B          TXY                    ;/
$A0:AE9A AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:AE9D BD 94 0F    LDA $0F94,x            ;\
$A0:AEA0 F0 0C       BEQ $0C    [$AEAE]     ;} If [enemy instruction timer] != 0:
$A0:AEA2 C9 01 00    CMP #$0001             ;\
$A0:AEA5 F0 07       BEQ $07    [$AEAE]     ;} If [enemy instruction timer] != 1:
$A0:AEA7 DE 94 0F    DEC $0F94,x            ; Decrement enemy instruction timer
$A0:AEAA A9 00 00    LDA #$0000             ;\
$A0:AEAD 6B          RTL                    ;} Return 0

$A0:AEAE 84 00       STY $00    [$7E:0000]  ; $00 = [Y]
$A0:AEB0 BC 90 0F    LDY $0F90,x            ; Y = [enemy $0F90]

; LOOP
$A0:AEB3 B1 00       LDA ($00),y            ;\
$A0:AEB5 C9 FF FF    CMP #$FFFF             ;} If [[$00] + [Y]] = FFFFh: return 1
$A0:AEB8 F0 1F       BEQ $1F    [$AED9]     ;/
$A0:AEBA C9 FE FF    CMP #$FFFE             ;\
$A0:AEBD D0 06       BNE $06    [$AEC5]     ;} If [[$00] + [Y]] = FFFEh:
$A0:AEBF A0 00 00    LDY #$0000             ; Y = 0
$A0:AEC2 4C B3 AE    JMP $AEB3  [$A0:AEB3]  ; Go to LOOP

$A0:AEC5 9D 8E 0F    STA $0F8E,x            ; Enemy spritemap pointer = [[$00] + [Y]]
$A0:AEC8 C8          INY                    ;\
$A0:AEC9 C8          INY                    ;|
$A0:AECA B1 00       LDA ($00),y            ;} Enemy instruction timer = [[$00] + [Y] + 2]
$A0:AECC 9D 94 0F    STA $0F94,x            ;/
$A0:AECF C8          INY                    ;\
$A0:AED0 C8          INY                    ;|
$A0:AED1 98          TYA                    ;} Enemy $0F90 = [Y] + 4
$A0:AED2 9D 90 0F    STA $0F90,x            ;/
$A0:AED5 A9 00 00    LDA #$0000             ;\
$A0:AED8 6B          RTL                    ;} Return 0

$A0:AED9 A9 01 00    LDA #$0001
$A0:AEDC 6B          RTL
}


;;; $AEDD: A = [Samus Y position] - [enemy Y position] ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AEDD AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A0:AEE0 38          SEC
$A0:AEE1 FD 7E 0F    SBC $0F7E,x[$7E:10BE]
$A0:AEE4 6B          RTL
}


;;; $AEE5: A = [Samus X position] - [enemy X position] ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AEE5 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A0:AEE8 38          SEC
$A0:AEE9 FD 7A 0F    SBC $0F7A,x[$7E:10BA]
$A0:AEEC 6B          RTL
}


;;; $AEED: Is Samus within [A] pixel rows of enemy ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AEED 8D 20 0E    STA $0E20  [$7E:0E20]  ;\
$A0:AEF0 AC FA 0A    LDY $0AFA  [$7E:0AFA]  ;|
$A0:AEF3 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A0:AEF6 AA          TAX                    ;|
$A0:AEF7 22 7D B0 A0 JSL $A0B07D[$A0:B07D]  ;} If |[Samus Y position] - [enemy Y position]| < [A]:
$A0:AEFB AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A0:AEFE CD 20 0E    CMP $0E20  [$7E:0E20]  ;|
$A0:AF01 10 04       BPL $04    [$AF07]     ;/
$A0:AF03 A9 01 00    LDA #$0001             ; A = 1
$A0:AF06 6B          RTL                    ; Return

$A0:AF07 A9 00 00    LDA #$0000             ; A = 0
$A0:AF0A 6B          RTL
}


;;; $AF0B: Is Samus within [A] pixel columns of enemy ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AF0B 8D 20 0E    STA $0E20  [$7E:0E20]  ;\
$A0:AF0E AC F6 0A    LDY $0AF6  [$7E:0AF6]  ;|
$A0:AF11 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A0:AF14 AA          TAX                    ;|
$A0:AF15 22 7D B0 A0 JSL $A0B07D[$A0:B07D]  ;} If |[Samus X position] - [enemy X position]| < [A]:
$A0:AF19 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A0:AF1C CD 20 0E    CMP $0E20  [$7E:0E20]  ;|
$A0:AF1F 10 04       BPL $04    [$AF25]     ;/
$A0:AF21 A9 01 00    LDA #$0001             ; A = 1
$A0:AF24 6B          RTL                    ; Return

$A0:AF25 A9 00 00    LDA #$0000             ; A = 0
$A0:AF28 6B          RTL
}


;;; $AF29..A1: Move enemy (no collision) ;;;
{
;;; $AF29: Unused. Enemy X += [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index

; Unused. Clone of $A0:AF6C
$A0:AF29 BD 7C 0F    LDA $0F7C,x
$A0:AF2C 18          CLC
$A0:AF2D 65 12       ADC $12    [$7E:0012]
$A0:AF2F 9D 7C 0F    STA $0F7C,x
$A0:AF32 BD 7A 0F    LDA $0F7A,x
$A0:AF35 65 14       ADC $14    [$7E:0014]
$A0:AF37 9D 7A 0F    STA $0F7A,x
$A0:AF3A 6B          RTL
}


;;; $AF3B: Unused. Enemy Y += [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index

; Unused. Clone of $A0:AF90
$A0:AF3B BD 80 0F    LDA $0F80,x
$A0:AF3E 18          CLC
$A0:AF3F 65 12       ADC $12    [$7E:0012]
$A0:AF41 9D 80 0F    STA $0F80,x
$A0:AF44 BD 7E 0F    LDA $0F7E,x
$A0:AF47 65 14       ADC $14    [$7E:0014]
$A0:AF49 9D 7E 0F    STA $0F7E,x
$A0:AF4C 6B          RTL
}


;;; $AF4D: Unused. Move enemy left/right/up/down by [$14].[$12] ;;;
{
;; Parameters:
;;     A: Direction
;;         0: Left
;;         1: Right
;;         2: Up
;;         3: Down

; Broken. Uses X for jump table index, but is needed for enemy index
$A0:AF4D 0A          ASL A
$A0:AF4E AA          TAX
$A0:AF4F 7C 52 AF    JMP ($AF52,x)

$A0:AF52             dw AF5A, AF6C, AF7E, AF90
}


;;; $AF5A: Enemy X -= [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AF5A BD 7C 0F    LDA $0F7C,x[$7E:0FBC]
$A0:AF5D 38          SEC
$A0:AF5E E5 12       SBC $12    [$7E:0012]
$A0:AF60 9D 7C 0F    STA $0F7C,x[$7E:0FBC]
$A0:AF63 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A0:AF66 E5 14       SBC $14    [$7E:0014]
$A0:AF68 9D 7A 0F    STA $0F7A,x[$7E:0FBA]
$A0:AF6B 6B          RTL
}


;;; $AF6C: Enemy X += [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AF6C BD 7C 0F    LDA $0F7C,x[$7E:0FBC]
$A0:AF6F 18          CLC
$A0:AF70 65 12       ADC $12    [$7E:0012]
$A0:AF72 9D 7C 0F    STA $0F7C,x[$7E:0FBC]
$A0:AF75 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A0:AF78 65 14       ADC $14    [$7E:0014]
$A0:AF7A 9D 7A 0F    STA $0F7A,x[$7E:0FBA]
$A0:AF7D 6B          RTL
}


;;; $AF7E: Enemy Y -= [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AF7E BD 80 0F    LDA $0F80,x[$7E:12C0]
$A0:AF81 38          SEC
$A0:AF82 E5 12       SBC $12    [$7E:0012]
$A0:AF84 9D 80 0F    STA $0F80,x[$7E:12C0]
$A0:AF87 BD 7E 0F    LDA $0F7E,x[$7E:12BE]
$A0:AF8A E5 14       SBC $14    [$7E:0014]
$A0:AF8C 9D 7E 0F    STA $0F7E,x[$7E:12BE]
$A0:AF8F 6B          RTL
}


;;; $AF90: Enemy Y += [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:AF90 BD 80 0F    LDA $0F80,x[$7E:1240]
$A0:AF93 18          CLC
$A0:AF94 65 12       ADC $12    [$7E:0012]
$A0:AF96 9D 80 0F    STA $0F80,x[$7E:1240]
$A0:AF99 BD 7E 0F    LDA $0F7E,x[$7E:123E]
$A0:AF9C 65 14       ADC $14    [$7E:0014]
$A0:AF9E 9D 7E 0F    STA $0F7E,x[$7E:123E]
$A0:AFA1 6B          RTL
}
}


;;; $AFA2..E9: Unused. Move Samus ;;;
{
;;; $AFA2: Unused. Extra Samus X displacement = [Samus X position] - [$14].[$12] ;;;
{
$A0:AFA2 AD F8 0A    LDA $0AF8  [$7E:0AF8]
$A0:AFA5 38          SEC
$A0:AFA6 E5 12       SBC $12    [$7E:0012]
$A0:AFA8 8D 56 0B    STA $0B56  [$7E:0B56]
$A0:AFAB AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A0:AFAE E5 14       SBC $14    [$7E:0014]
$A0:AFB0 8D 58 0B    STA $0B58  [$7E:0B58]
$A0:AFB3 6B          RTL
}


;;; $AFB4: Unused. Extra Samus X displacement = [Samus X position] + [$14].[$12] ;;;
{
$A0:AFB4 AD F8 0A    LDA $0AF8  [$7E:0AF8]
$A0:AFB7 18          CLC
$A0:AFB8 65 12       ADC $12    [$7E:0012]
$A0:AFBA 8D 56 0B    STA $0B56  [$7E:0B56]
$A0:AFBD AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A0:AFC0 65 14       ADC $14    [$7E:0014]
$A0:AFC2 8D 58 0B    STA $0B58  [$7E:0B58]
$A0:AFC5 6B          RTL
}


;;; $AFC6: Unused. Extra Samus Y displacement = [Samus Y position] - [$14].[$12] ;;;
{
$A0:AFC6 AD FC 0A    LDA $0AFC  [$7E:0AFC]
$A0:AFC9 38          SEC
$A0:AFCA E5 12       SBC $12    [$7E:0012]
$A0:AFCC 8D 5A 0B    STA $0B5A  [$7E:0B5A]
$A0:AFCF AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A0:AFD2 E5 14       SBC $14    [$7E:0014]
$A0:AFD4 8D 5C 0B    STA $0B5C  [$7E:0B5C]
$A0:AFD7 6B          RTL
}


;;; $AFD8: Unused. Extra Samus Y displacement = [Samus Y position] + [$14].[$12] ;;;
{
$A0:AFD8 AD FC 0A    LDA $0AFC  [$7E:0AFC]
$A0:AFDB 18          CLC
$A0:AFDC 65 12       ADC $12    [$7E:0012]
$A0:AFDE 8D 5A 0B    STA $0B5A  [$7E:0B5A]
$A0:AFE1 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A0:AFE4 65 14       ADC $14    [$7E:0014]
$A0:AFE6 8D 5C 0B    STA $0B5C  [$7E:0B5C]
$A0:AFE9 6B          RTL
}
}


;;; $AFEA..B0B1: Trivial maths ;;;
{
;;; $AFEA: Sign extend A ;;;
{
$A0:AFEA 8D 32 0E    STA $0E32  [$7E:0E32]
$A0:AFED 29 80 00    AND #$0080
$A0:AFF0 F0 07       BEQ $07    [$AFF9]
$A0:AFF2 AD 32 0E    LDA $0E32  [$7E:0E32]
$A0:AFF5 09 00 FF    ORA #$FF00
$A0:AFF8 6B          RTL

$A0:AFF9 AD 32 0E    LDA $0E32  [$7E:0E32]
$A0:AFFC 6B          RTL
}


;;; $AFFD: Unused. A *= 10h ;;;
{
$A0:AFFD 0A          ASL A
$A0:AFFE 0A          ASL A
$A0:AFFF 0A          ASL A
$A0:B000 0A          ASL A
$A0:B001 6B          RTL
}


;;; $B002: A *= 20h ;;;
{
; Used by $8D64 (process enemy set) to convert palette index to palette bits
$A0:B002 0A          ASL A
$A0:B003 0A          ASL A
$A0:B004 0A          ASL A
$A0:B005 0A          ASL A
$A0:B006 0A          ASL A
$A0:B007 6B          RTL
}


;;; $B008: Unused. A *= 30h ;;;
{
$A0:B008 0A          ASL A
$A0:B009 0A          ASL A
$A0:B00A 0A          ASL A
$A0:B00B 0A          ASL A
$A0:B00C 8D 32 0E    STA $0E32  [$7E:0E32]
$A0:B00F 18          CLC
$A0:B010 6D 32 0E    ADC $0E32  [$7E:0E32]
$A0:B013 18          CLC
$A0:B014 6D 32 0E    ADC $0E32  [$7E:0E32]
$A0:B017 6B          RTL
}


;;; $B018: Unused. A *= 40h ;;;
{
$A0:B018 0A          ASL A
$A0:B019 0A          ASL A
$A0:B01A 0A          ASL A
$A0:B01B 0A          ASL A
$A0:B01C 0A          ASL A
$A0:B01D 0A          ASL A
$A0:B01E 6B          RTL
}


;;; $B01F: Unused. A = xxyz -> A = xxzy ;;;
{
$A0:B01F 48          PHA
$A0:B020 29 00 FF    AND #$FF00
$A0:B023 8D 34 0E    STA $0E34  [$7E:0E34]
$A0:B026 68          PLA
$A0:B027 29 FF 00    AND #$00FF
$A0:B02A 8D 32 0E    STA $0E32  [$7E:0E32]
$A0:B02D E2 20       SEP #$20
$A0:B02F EB          XBA
$A0:B030 C2 20       REP #$20
$A0:B032 0D 32 0E    ORA $0E32  [$7E:0E32]
$A0:B035 4A          LSR A
$A0:B036 4A          LSR A
$A0:B037 4A          LSR A
$A0:B038 4A          LSR A
$A0:B039 29 FF 00    AND #$00FF
$A0:B03C 0D 34 0E    ORA $0E34  [$7E:0E34]
$A0:B03F 6B          RTL
}


;;; $B040: Unused. A = xyzz -> A = yxzz ;;;
{
$A0:B040 48          PHA
$A0:B041 29 FF 00    AND #$00FF
$A0:B044 8D 34 0E    STA $0E34  [$7E:0E34]
$A0:B047 68          PLA
$A0:B048 29 00 FF    AND #$FF00
$A0:B04B 8D 32 0E    STA $0E32  [$7E:0E32]
$A0:B04E E2 20       SEP #$20
$A0:B050 EB          XBA
$A0:B051 C2 20       REP #$20
$A0:B053 0D 32 0E    ORA $0E32  [$7E:0E32]
$A0:B056 0A          ASL A
$A0:B057 0A          ASL A
$A0:B058 0A          ASL A
$A0:B059 0A          ASL A
$A0:B05A 29 00 FF    AND #$FF00
$A0:B05D 0D 34 0E    ORA $0E34  [$7E:0E34]
$A0:B060 6B          RTL
}


;;; $B061: Unused. A = xxyy -> A = yyxx ;;;
{
; Whoever wrote these three nybble swapping routines must've thought XBA had to be done in 8-bit mode
$A0:B061 E2 20       SEP #$20
$A0:B063 EB          XBA
$A0:B064 C2 20       REP #$20
$A0:B066 6B          RTL
}


;;; $B067: A = |[A]| ;;;
{
$A0:B067 8D 32 0E    STA $0E32  [$7E:0E32]  ;\
$A0:B06A 29 00 80    AND #$8000             ;|
$A0:B06D F0 0A       BEQ $0A    [$B079]     ;} If [A] < 0:
$A0:B06F AD 32 0E    LDA $0E32  [$7E:0E32]  ;/
$A0:B072 49 FF FF    EOR #$FFFF             ;\
$A0:B075 1A          INC A                  ;} Negate A
$A0:B076 8D 32 0E    STA $0E32  [$7E:0E32]

$A0:B079 AD 32 0E    LDA $0E32  [$7E:0E32]
$A0:B07C 6B          RTL
}


;;; $B07D: A = |[Y] - [X]| ;;;
{
$A0:B07D DA          PHX
$A0:B07E 5A          PHY
$A0:B07F 8A          TXA                    ;\
$A0:B080 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A0:B083 98          TYA                    ;} A = [Y] - [X]
$A0:B084 38          SEC                    ;|
$A0:B085 ED 32 0E    SBC $0E32  [$7E:0E32]  ;/
$A0:B088 8D 34 0E    STA $0E34  [$7E:0E34]  ;\
$A0:B08B 29 00 80    AND #$8000             ;|
$A0:B08E F0 0A       BEQ $0A    [$B09A]     ;} If [A] < 0:
$A0:B090 AD 34 0E    LDA $0E34  [$7E:0E34]  ;/
$A0:B093 49 FF FF    EOR #$FFFF             ;\
$A0:B096 1A          INC A                  ;} Negate A
$A0:B097 8D 34 0E    STA $0E34  [$7E:0E34]

$A0:B09A AD 34 0E    LDA $0E34  [$7E:0E34]
$A0:B09D 7A          PLY
$A0:B09E FA          PLX
$A0:B09F 6B          RTL
}


;;; $B0A0: Unused. A = -[A] ;;;
{
$A0:B0A0 49 FF FF    EOR #$FFFF
$A0:B0A3 1A          INC A
$A0:B0A4 6B          RTL
}


;;; $B0A5: Unused. A = sgn([A]) (zero counts as positive) ;;;
{
$A0:B0A5 29 00 80    AND #$8000
$A0:B0A8 F0 04       BEQ $04    [$B0AE]
$A0:B0AA A9 FF FF    LDA #$FFFF
$A0:B0AD 6B          RTL

$A0:B0AE A9 01 00    LDA #$0001
$A0:B0B1 6B          RTL
}
}


;;; $B0B2: 8-bit cosine multiplication ;;;
{
;; Parameters:
;;     A: Angle
;;     $0E32: Radius
;; Returns:
;;     $0E36.$0E38: cos([A] * pi / 80h) * [$0E32]

; Bug. Only accurate for angles in the range C0h..3Fh (see $B0DA)

$A0:B0B2 18          CLC                    ;\
$A0:B0B3 69 40 00    ADC #$0040             ;|
$A0:B0B6 29 FF 00    AND #$00FF             ;} $0E34 = ([A] + 40h) % 100h
$A0:B0B9 8D 34 0E    STA $0E34  [$7E:0E34]  ;/
$A0:B0BC DA          PHX
$A0:B0BD 5A          PHY
$A0:B0BE 8B          PHB
$A0:B0BF 20 DA B0    JSR $B0DA  [$A0:B0DA]  ; 8-bit sine multiplication
$A0:B0C2 AB          PLB
$A0:B0C3 7A          PLY
$A0:B0C4 FA          PLX
$A0:B0C5 6B          RTL
}


;;; $B0C6: 8-bit negative sine multiplication ;;;
{
;; Parameters:
;;     A: Angle
;;     $0E32: Radius
;; Returns:
;;     $0E36.$0E38: -sin([A] * pi / 80h) * [$0E32]

; Bug. Only accurate for angles in the range 80h..FFh (see $B0DA)

$A0:B0C6 18          CLC                    ;\
$A0:B0C7 69 80 00    ADC #$0080             ;|
$A0:B0CA 29 FF 00    AND #$00FF             ;} $0E34 = ([A] + 80h) % 100h
$A0:B0CD 8D 34 0E    STA $0E34  [$7E:0E34]  ;/
$A0:B0D0 DA          PHX
$A0:B0D1 5A          PHY
$A0:B0D2 8B          PHB
$A0:B0D3 20 DA B0    JSR $B0DA  [$A0:B0DA]  ; 8-bit sine multiplication
$A0:B0D6 AB          PLB
$A0:B0D7 7A          PLY
$A0:B0D8 FA          PLX
$A0:B0D9 6B          RTL
}


;;; $B0DA: 8-bit sine multiplication ;;;
{
;; Parameters:
;;     $0E34: Angle
;;     $0E32: Radius
;; Returns:
;;     $0E36.$0E38: sin([$0E34] * pi / 80h) * [$0E32]

; Bug. Only accurate for angles in the range 0..7Fh because the negation code of $B11B..2E does not do a correct multi-word increment
; Accurate code would be more like:
;     LDA $0E38 : EOR #$FFFF : CLC : ADC #$0001 : STA $0E38
;     LDA $0E36 : EOR #$FFFF : ADC #$0000 : STA $0E36

; Results for negative angles with this bug are almost always 1.0 greater than they should be

$A0:B0DA E2 20       SEP #$20
$A0:B0DC A9 A0       LDA #$A0               ;\
$A0:B0DE 48          PHA                    ;} DB = $A0
$A0:B0DF AB          PLB                    ;/
$A0:B0E0 C2 30       REP #$30
$A0:B0E2 AD 34 0E    LDA $0E34  [$7E:0E34]  ;\
$A0:B0E5 29 7F 00    AND #$007F             ;|
$A0:B0E8 A8          TAY                    ;|
$A0:B0E9 B9 43 B1    LDA $B143,y[$A0:B18D]  ;|
$A0:B0EC 29 FF 00    AND #$00FF             ;|
$A0:B0EF E2 20       SEP #$20               ;|
$A0:B0F1 8D 02 42    STA $4202              ;|
$A0:B0F4 AD 32 0E    LDA $0E32  [$7E:0E32]  ;|
$A0:B0F7 8D 03 42    STA $4203              ;} A = [$B143 + |[$0E34]|] * [$0E32]
$A0:B0FA EA          NOP                    ;|
$A0:B0FB EA          NOP                    ;|
$A0:B0FC EA          NOP                    ;|
$A0:B0FD EA          NOP                    ;|
$A0:B0FE EA          NOP                    ;|
$A0:B0FF C2 20       REP #$20               ;|
$A0:B101 AD 16 42    LDA $4216              ;/
$A0:B104 EB          XBA                    ;\
$A0:B105 48          PHA                    ;|
$A0:B106 29 FF 00    AND #$00FF             ;|
$A0:B109 8D 36 0E    STA $0E36  [$7E:0E36]  ;} $0E36.$0E38 = [A] / 100h
$A0:B10C 68          PLA                    ;|
$A0:B10D 29 00 FF    AND #$FF00             ;|
$A0:B110 8D 38 0E    STA $0E38  [$7E:0E38]  ;/
$A0:B113 AD 34 0E    LDA $0E34  [$7E:0E34]  ;\
$A0:B116 29 80 00    AND #$0080             ;} If [$0E34] is negative:
$A0:B119 F0 14       BEQ $14    [$B12F]     ;/
$A0:B11B AD 36 0E    LDA $0E36  [$7E:0E36]  ;\
$A0:B11E 49 FF FF    EOR #$FFFF             ;|
$A0:B121 1A          INC A                  ;} Negate $0E36
$A0:B122 8D 36 0E    STA $0E36  [$7E:0E36]  ;/
$A0:B125 AD 38 0E    LDA $0E38  [$7E:0E38]  ;\
$A0:B128 49 FF FF    EOR #$FFFF             ;|
$A0:B12B 1A          INC A                  ;} Negate $0E38
$A0:B12C 8D 38 0E    STA $0E38  [$7E:0E38]  ;/

$A0:B12F AD 36 0E    LDA $0E36  [$7E:0E36]  ; A = [$0E36]
$A0:B132 60          RTS
}


;;; $B133: Addresses for enemy drawing queues ;;;
{
; Indexed by [enemy layer] * 2
$A0:B133             dw 0E84, 0EA4, 0EA6, 0EC6, 0EC8, 0EE8, 0F28, 0F48
}


;;; $B143: Sine/cosine tables ;;;
{
; Generate 16-bit tables with
;     [int((0x7FFF+0.5) * math.sin(i * math.pi / 0x80)) for i in range(0x40 * n_quadrants)]

; Generate sign-extended 8-bit tables with
;     [0x100 * math.sin(i * math.pi / 0x80) for i in range(0x40 * n_quadrants)]

; 8-bit table is the same as the 8-bit signed-extended first half, except cos(0) is capped at FFh

; "8-bit" table range = 0..FFh, positive values only (i.e. the first two quadrants only)
; "16-bit" table range = -7FFFh..7FFFh
; "16-bit sign-extended" table range = -100h..100h

; 8-bit sine
$A0:B143             db 00, 06, 0C, 12, 19, 1F, 25, 2B, 31, 38, 3E, 44, 4A, 50, 56, 5C, 61, 67, 6D, 73, 78, 7E, 83, 88, 8E, 93, 98, 9D, A2, A7, AB, B0, B5, B9, BD, C1, C5, C9, CD, D1, D4, D8, DB, DE, E1, E4, E7, EA, EC, EE, F1, F3, F4, F6, F8, F9, FB, FC, FD, FE, FE, FF, FF, FF

; 8-bit cosine
$A0:B183             db FF, FF, FF, FF, FE, FE, FD, FC, FB, F9, F8, F6, F4, F3, F1, EE, EC, EA, E7, E4, E1, DE, DB, D8, D4, D1, CD, C9, C5, C1, BD, B9, B5, B0, AB, A7, A2, 9D, 98, 93, 8E, 88, 83, 7E, 78, 73, 6D, 67, 61, 5C, 56, 50, 4A, 44, 3E, 38, 31, 2B, 25, 1F, 19, 12, 0C, 06

; 16-bit sine
$A0:B1C3             dw 0000, 0324, 0647, 096A, 0C8B, 0FAB, 12C7, 15E1, 18F8, 1C0B, 1F19, 2223, 2527, 2826, 2B1F, 2E10, 30FB, 33DE, 36B9, 398C, 3C56, 3F17, 41CD, 447A, 471C, 49B3, 4C3F, 4EBF, 5133, 539A, 55F5, 5842, 5A82, 5CB3, 5ED7, 60EB, 62F1, 64E8, 66CF, 68A6, 6A6D, 6C23, 6DC9, 6F5E, 70E2, 7254, 73B5, 7504, 7641, 776B, 7884, 7989, 7A7C, 7B5C, 7C29, 7CE3, 7D89, 7E1D, 7E9C, 7F09, 7F61, 7FA6, 7FD8, 7FF5

; 16-bit cosine
$A0:B243             dw 7FFF, 7FF5, 7FD8, 7FA6, 7F61, 7F09, 7E9C, 7E1D, 7D89, 7CE3, 7C29, 7B5C, 7A7C, 7989, 7884, 776B, 7641, 7504, 73B5, 7254, 70E2, 6F5E, 6DC9, 6C23, 6A6D, 68A6, 66CF, 64E8, 62F1, 60EB, 5ED7, 5CB3, 5A82, 5842, 55F5, 539A, 5133, 4EBF, 4C3F, 49B3, 471C, 447A, 41CD, 3F17, 3C56, 398C, 36B9, 33DE, 30FB, 2E10, 2B1F, 2826, 2527, 2223, 1F19, 1C0B, 18F8, 15E1, 12C7, 0FAB, 0C8B, 096A, 0647, 0324

; 16-bit negative sine
$A0:B2C3             dw 0000, FCDC, F9B9, F696, F375, F055, ED39, EA1F, E708, E3F5, E0E7, DDDD, DAD9, D7DA, D4E1, D1F0, CF05, CC22, C947, C674, C3AA, C0E9, BE33, BB86, B8E4, B64D, B3C1, B141, AECD, AC66, AA0B, A7BE, A57E, A34D, A129, 9F15, 9D0F, 9B18, 9931, 975A, 9593, 93DD, 9237, 90A2, 8F1E, 8DAC, 8C4B, 8AFC, 89BF, 8895, 877C, 8677, 8584, 84A4, 83D7, 831D, 8277, 81E3, 8164, 80F7, 809F, 805A, 8028, 800B

; 16-bit negative cosine
$A0:B343             dw 8001, 800B, 8028, 805A, 809F, 80F7, 8164, 81E3, 8277, 831D, 83D7, 84A4, 8584, 8677, 877C, 8895, 89BF, 8AFC, 8C4B, 8DAC, 8F1E, 90A2, 9237, 93DD, 9593, 975A, 9931, 9B18, 9D0F, 9F15, A129, A34D, A57E, A7BE, AA0B, AC66, AECD, B141, B3C1, B64D, B8E4, BB86, BE33, C0E9, C3AA, C674, C947, CC22, CF05, D1F0, D4E1, D7DA, DAD9, DDDD, E0E7, E3F5, E708, EA1F, ED39, F055, F375, F696, F9B9, FCDC

; 8-bit negative cosine, sign-extended
$A0:B3C3             dw FF00, FF01, FF01, FF01, FF02, FF02, FF03, FF04, FF05, FF07, FF08, FF0A, FF0C, FF0D, FF0F, FF12, FF14, FF16, FF19, FF1C, FF1F, FF22, FF25, FF28, FF2C, FF2F, FF33, FF37, FF3B, FF3F, FF43, FF47, FF4B, FF50, FF55, FF59, FF5E, FF63, FF68, FF6D, FF72, FF78, FF7D, FF82, FF88, FF8D, FF93, FF99, FF9F, FFA4, FFAA, FFB0, FFB6, FFBC, FFC2, FFC8, FFCF, FFD5, FFDB, FFE1, FFE7, FFEE, FFF4, FFFA

; 8-bit sine, sign-extended
$A0:B443             dw 0000, 0006, 000C, 0012, 0019, 001F, 0025, 002B, 0031, 0038, 003E, 0044, 004A, 0050, 0056, 005C, 0061, 0067, 006D, 0073, 0078, 007E, 0083, 0088, 008E, 0093, 0098, 009D, 00A2, 00A7, 00AB, 00B0, 00B5, 00B9, 00BD, 00C1, 00C5, 00C9, 00CD, 00D1, 00D4, 00D8, 00DB, 00DE, 00E1, 00E4, 00E7, 00EA, 00EC, 00EE, 00F1, 00F3, 00F4, 00F6, 00F8, 00F9, 00FB, 00FC, 00FD, 00FE, 00FE, 00FF, 00FF, 00FF

; 8-bit cosine, sign-extended
$A0:B4C3             dw 0100, 00FF, 00FF, 00FF, 00FE, 00FE, 00FD, 00FC, 00FB, 00F9, 00F8, 00F6, 00F4, 00F3, 00F1, 00EE, 00EC, 00EA, 00E7, 00E4, 00E1, 00DE, 00DB, 00D8, 00D4, 00D1, 00CD, 00C9, 00C5, 00C1, 00BD, 00B9, 00B5, 00B0, 00AB, 00A7, 00A2, 009D, 0098, 0093, 008E, 0088, 0083, 007E, 0078, 0073, 006D, 0067, 0061, 005C, 0056, 0050, 004A, 0044, 003E, 0038, 0031, 002B, 0025, 001F, 0019, 0012, 000C, 0006

; 8-bit negative sine, sign-extended
$A0:B543             dw 0000, FFFA, FFF4, FFEE, FFE7, FFE1, FFDB, FFD5, FFCF, FFC8, FFC2, FFBC, FFB6, FFB0, FFAA, FFA4, FF9F, FF99, FF93, FF8D, FF88, FF82, FF7D, FF78, FF72, FF6D, FF68, FF63, FF5E, FF59, FF55, FF50, FF4B, FF47, FF43, FF3F, FF3B, FF37, FF33, FF2F, FF2C, FF28, FF25, FF22, FF1F, FF1C, FF19, FF16, FF14, FF12, FF0F, FF0D, FF0C, FF0A, FF08, FF07, FF05, FF04, FF03, FF02, FF02, FF01, FF01, FF01

; 8-bit negative cosine, sign-extended
$A0:B5C3             dw FF00, FF01, FF01, FF01, FF02, FF02, FF03, FF04, FF05, FF07, FF08, FF0A, FF0C, FF0D, FF0F, FF12, FF14, FF16, FF19, FF1C, FF1F, FF22, FF25, FF28, FF2C, FF2F, FF33, FF37, FF3B, FF3F, FF43, FF47, FF4B, FF50, FF55, FF59, FF5E, FF63, FF68, FF6D, FF72, FF78, FF7D, FF82, FF88, FF8D, FF93, FF99, FF9F, FFA4, FFAA, FFB0, FFB6, FFBC, FFC2, FFC8, FFCF, FFD5, FFDB, FFE1, FFE7, FFEE, FFF4, FFFA
}


;;; $B643: ($16.$18, $1A.$1C) = ([$14] * |cos([$12] * pi / 80h)|, [$14] * |sin([$12] * pi / 80h)|) ;;;
{
; All arithmetic done here is unsigned, so [$14] should be positive
; Uses the standard maths convention for angle(!)

; Standard maths angle convention:
;          40h
;           |
;     80h   #    0
;
;          C0h
;
; Where # is the origin and | is the negative y axis
$A0:B643 8B          PHB
$A0:B644 DA          PHX
$A0:B645 F4 00 A0    PEA $A000              ;\
$A0:B648 AB          PLB                    ;} DB = $A0
$A0:B649 AB          PLB                    ;/
$A0:B64A C2 30       REP #$30
$A0:B64C A5 12       LDA $12    [$7E:0012]  ;\
$A0:B64E 18          CLC                    ;|
$A0:B64F 69 80 00    ADC #$0080             ;|
$A0:B652 29 7F 00    AND #$007F             ;|
$A0:B655 0A          ASL A                  ;|
$A0:B656 AA          TAX                    ;} $2A = [$B7EE + [$12] % 80h] * [$14]
$A0:B657 BF EE B7 A0 LDA $A0B7EE,x[$A0:B842];|
$A0:B65B 85 26       STA $26    [$7E:0026]  ;|
$A0:B65D A5 14       LDA $14    [$7E:0014]  ;|
$A0:B65F 85 28       STA $28    [$7E:0028]  ;|
$A0:B661 22 FF B6 A0 JSL $A0B6FF[$A0:B6FF]  ;/
$A0:B665 A5 2C       LDA $2C    [$7E:002C]  ;\
$A0:B667 85 1A       STA $1A    [$7E:001A]  ;} $1A = [$2A] / 10000h
$A0:B669 A5 2A       LDA $2A    [$7E:002A]  ;\
$A0:B66B 85 1C       STA $1C    [$7E:001C]  ;} $1C = [$2A] & FFFFh
$A0:B66D A5 12       LDA $12    [$7E:0012]  ;\
$A0:B66F 18          CLC                    ;|
$A0:B670 69 40 00    ADC #$0040             ;|
$A0:B673 29 7F 00    AND #$007F             ;|
$A0:B676 0A          ASL A                  ;|
$A0:B677 AA          TAX                    ;} $2A = [$B7EE + ([$12] + 40h) % 80h] * [$14]
$A0:B678 BF EE B7 A0 LDA $A0B7EE,x[$A0:B8C2];|
$A0:B67C 85 26       STA $26    [$7E:0026]  ;|
$A0:B67E A5 14       LDA $14    [$7E:0014]  ;|
$A0:B680 85 28       STA $28    [$7E:0028]  ;|
$A0:B682 22 FF B6 A0 JSL $A0B6FF[$A0:B6FF]  ;/
$A0:B686 A5 2C       LDA $2C    [$7E:002C]  ;\
$A0:B688 85 16       STA $16    [$7E:0016]  ;} $16 = [$2A] / 10000h
$A0:B68A A5 2A       LDA $2A    [$7E:002A]  ;\
$A0:B68C 85 18       STA $18    [$7E:0018]  ;} $18 = [$2A] & FFFFh
$A0:B68E FA          PLX
$A0:B68F AB          PLB
$A0:B690 6B          RTL
}


;;; $B691: Move enemy according to angle and X/Y speeds ;;;
{
;; Parameters:
;;     $0E20: Angle. Standard maths angle convention
;;     $0E24.$0E26: X speed
;;     $0E28.$0E2A: Y speed

; Standard maths angle convention:
;          40h
;           |
;     80h   #    0
;
;          C0h
;
; Where # is the origin and | is the negative y axis
$A0:B691 DA          PHX
$A0:B692 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A0:B695 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$A0:B698 18          CLC                    ;|
$A0:B699 69 40 00    ADC #$0040             ;} If ([$0E20] + 40h) % 100h < 80h:
$A0:B69C 89 80 00    BIT #$0080             ;|
$A0:B69F D0 15       BNE $15    [$B6B6]     ;/
$A0:B6A1 BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;\
$A0:B6A4 18          CLC                    ;|
$A0:B6A5 6D 26 0E    ADC $0E26  [$7E:0E26]  ;|
$A0:B6A8 9D 7C 0F    STA $0F7C,x[$7E:0FFC]  ;} Enemy X position += [$0E24].[$0E26]
$A0:B6AB BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$A0:B6AE 6D 24 0E    ADC $0E24  [$7E:0E24]  ;|
$A0:B6B1 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A0:B6B4 80 13       BRA $13    [$B6C9]

$A0:B6B6 BD 7C 0F    LDA $0F7C,x[$7E:0F7C]  ;\ Else (([$0E20] + 40h) % 100h >= 80h):
$A0:B6B9 38          SEC                    ;|
$A0:B6BA ED 26 0E    SBC $0E26  [$7E:0E26]  ;|
$A0:B6BD 9D 7C 0F    STA $0F7C,x[$7E:0F7C]  ;} Enemy X position -= [$0E24].[$0E26]
$A0:B6C0 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A0:B6C3 ED 24 0E    SBC $0E24  [$7E:0E24]  ;|
$A0:B6C6 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/

$A0:B6C9 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$A0:B6CC 18          CLC                    ;|
$A0:B6CD 69 80 00    ADC #$0080             ;} If [$0E20] % 100h >= 80h:
$A0:B6D0 89 80 00    BIT #$0080             ;|
$A0:B6D3 D0 15       BNE $15    [$B6EA]     ;/
$A0:B6D5 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A0:B6D8 18          CLC                    ;|
$A0:B6D9 6D 2A 0E    ADC $0E2A  [$7E:0E2A]  ;|
$A0:B6DC 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y position += [$0E28].[$0E2A]
$A0:B6DF BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A0:B6E2 6D 28 0E    ADC $0E28  [$7E:0E28]  ;|
$A0:B6E5 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A0:B6E8 80 13       BRA $13    [$B6FD]

$A0:B6EA BD 80 0F    LDA $0F80,x[$7E:1040]  ;\ Else ([$0E20] % 100h < 80h):
$A0:B6ED 38          SEC                    ;|
$A0:B6EE ED 2A 0E    SBC $0E2A  [$7E:0E2A]  ;|
$A0:B6F1 9D 80 0F    STA $0F80,x[$7E:1040]  ;} Enemy Y position -= [$0E28].[$0E2A]
$A0:B6F4 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;|
$A0:B6F7 ED 28 0E    SBC $0E28  [$7E:0E28]  ;|
$A0:B6FA 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;/

$A0:B6FD FA          PLX
$A0:B6FE 6B          RTL
}


;;; $B6FF: 16bit ($26) * 16bit ($28) = 32bit ($2A) ;;;
{
;; Parameters:
;;     $26: Multiplicand. Let $26 = a + b * 100h
;;     $28: Multiplicand. Let $28 = c + d * 100h
;; Returns:
;;     $2A..2D: 32-bit result

$A0:B6FF DA          PHX
$A0:B700 5A          PHY
$A0:B701 08          PHP
$A0:B702 C2 20       REP #$20
$A0:B704 E2 10       SEP #$10
$A0:B706 A6 26       LDX $26    [$7E:0026]  ;\
$A0:B708 8E 02 42    STX $4202              ;|
$A0:B70B A6 28       LDX $28    [$7E:0028]  ;|
$A0:B70D 8E 03 42    STX $4203              ;|
$A0:B710 EA          NOP                    ;} Result = ac
$A0:B711 EA          NOP                    ;|
$A0:B712 EA          NOP                    ;|
$A0:B713 AD 16 42    LDA $4216              ;|
$A0:B716 85 2A       STA $2A    [$7E:002A]  ;/
$A0:B718 A6 27       LDX $27    [$7E:0027]  ;\
$A0:B71A 8E 02 42    STX $4202              ;|
$A0:B71D A6 29       LDX $29    [$7E:0029]  ;|
$A0:B71F 8E 03 42    STX $4203              ;|
$A0:B722 EA          NOP                    ;} Result += bd % 100h * 10000h
$A0:B723 EA          NOP                    ;|
$A0:B724 EA          NOP                    ;|
$A0:B725 AE 16 42    LDX $4216              ;|
$A0:B728 86 2C       STX $2C    [$7E:002C]  ;/
$A0:B72A AC 17 42    LDY $4217              ; Y = bd / 100h
$A0:B72D A6 27       LDX $27    [$7E:0027]  ;\
$A0:B72F 8E 02 42    STX $4202              ;|
$A0:B732 A6 28       LDX $28    [$7E:0028]  ;|
$A0:B734 8E 03 42    STX $4203              ;|
$A0:B737 EA          NOP                    ;|
$A0:B738 EA          NOP                    ;} Result += bc * 100h
$A0:B739 A5 2B       LDA $2B    [$7E:002B]  ;|
$A0:B73B 18          CLC                    ;|
$A0:B73C 6D 16 42    ADC $4216              ;|
$A0:B73F 85 2B       STA $2B    [$7E:002B]  ;/
$A0:B741 90 01       BCC $01    [$B744]     ; If carry set:
$A0:B743 C8          INY                    ; Y += 1

$A0:B744 A6 26       LDX $26    [$7E:0026]  ;\
$A0:B746 8E 02 42    STX $4202              ;|
$A0:B749 A6 29       LDX $29    [$7E:0029]  ;|
$A0:B74B 8E 03 42    STX $4203              ;|
$A0:B74E EA          NOP                    ;|
$A0:B74F EA          NOP                    ;} Result += ad * 100h
$A0:B750 A5 2B       LDA $2B    [$7E:002B]  ;|
$A0:B752 18          CLC                    ;|
$A0:B753 6D 16 42    ADC $4216              ;|
$A0:B756 85 2B       STA $2B    [$7E:002B]  ;/
$A0:B758 90 01       BCC $01    [$B75B]     ; If carry set:
$A0:B75A C8          INY                    ; Y += 1

$A0:B75B 84 2D       STY $2D    [$7E:002D]  ; Result += [Y] * 1000000h
$A0:B75D 28          PLP
$A0:B75E 7A          PLY
$A0:B75F FA          PLX
$A0:B760 6B          RTL
}


;;; $B761: 32-bit unsigned division ;;;
{
;; Parameters:
;;     $2A..2D: Dividend
;;     $2E..31: Divisor
;; Returns:
;;     $26..29: Remainder
;;     $2A..2D: Quotient

; Called by Draygon
; Very slow. When profiled on a Draygon fight, I got:
;     Minimum: ~14.5k master cycles (10.6 scanlines)
;     Average: ~16.2k master cycles (11.9 scanlines)
;     Maximum: ~17.3k master cycles (12.7 scanlines)

$A0:B761 08          PHP
$A0:B762 8B          PHB
$A0:B763 4B          PHK                    ;\
$A0:B764 AB          PLB                    ;} DB = $A0
$A0:B765 C2 30       REP #$30
$A0:B767 64 28       STZ $28    [$7E:0028]  ;\
$A0:B769 64 26       STZ $26    [$7E:0026]  ;} $26 = 0 (remainder)
$A0:B76B A5 30       LDA $30    [$7E:0030]  ;\
$A0:B76D 05 2E       ORA $2E    [$7E:002E]  ;} If [$2E] = 0:
$A0:B76F D0 06       BNE $06    [$B777]     ;/
$A0:B771 64 2C       STZ $2C    [$7E:002C]  ;\
$A0:B773 64 2A       STZ $2A    [$7E:002A]  ;} $2A = 0 (quotient)
$A0:B775 80 27       BRA $27    [$B79E]     ; Return

$A0:B777 A2 21 00    LDX #$0021             ; X = 21h (loop counter)
$A0:B77A 18          CLC                    ; Clear carry

; LOOP
$A0:B77B 26 2A       ROL $2A    [$7E:002A]  ;\
$A0:B77D 26 2C       ROL $2C    [$7E:002C]  ;} $2A = [$2A] * 2 + carry
$A0:B77F CA          DEX                    ; Decrement X
$A0:B780 F0 1C       BEQ $1C    [$B79E]     ; If [X] = 0: return
$A0:B782 26 26       ROL $26    [$7E:0026]  ;\
$A0:B784 26 28       ROL $28    [$7E:0028]  ;} $26 *= 2
$A0:B786 A5 28       LDA $28    [$7E:0028]  ;\
$A0:B788 05 26       ORA $26    [$7E:0026]  ;} If [$26] = 0: go to LOOP
$A0:B78A F0 EF       BEQ $EF    [$B77B]     ;/
$A0:B78C A5 26       LDA $26    [$7E:0026]  ;\
$A0:B78E 38          SEC                    ;|
$A0:B78F E5 2E       SBC $2E    [$7E:002E]  ;} YA = [$26] - [$2E]
$A0:B791 A8          TAY                    ;} Carry = [YA] >= 0
$A0:B792 A5 28       LDA $28    [$7E:0028]  ;|
$A0:B794 E5 30       SBC $30    [$7E:0030]  ;/
$A0:B796 90 E3       BCC $E3    [$B77B]     ; If [YA] < 0: go to LOOP
$A0:B798 85 28       STA $28    [$7E:0028]  ;\
$A0:B79A 84 26       STY $26    [$7E:0026]  ;} $26 = [YA]
$A0:B79C 80 DD       BRA $DD    [$B77B]     ; Go to LOOP

$A0:B79E AB          PLB
$A0:B79F 28          PLP
$A0:B7A0 6B          RTL
}


;;; $B7A1: Cap scrolling speed ;;;
{
; Called by Draygon and yapping maw
$A0:B7A1 DA          PHX
$A0:B7A2 5A          PHY
$A0:B7A3 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A0:B7A6 38          SEC                    ;|
$A0:B7A7 ED 14 0B    SBC $0B14  [$7E:0B14]  ;} $12 = [Samus Y position] - [Samus previous Y position]
$A0:B7AA 85 12       STA $12    [$7E:0012]  ;/
$A0:B7AC 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;\
$A0:B7B0 C9 0C 00    CMP #$000C             ;} If |[$12]| < Ch: go to BRANCH_Y_POSITION_END
$A0:B7B3 30 12       BMI $12    [$B7C7]     ;/
$A0:B7B5 A0 F4 FF    LDY #$FFF4             ; Y = -Ch
$A0:B7B8 A5 12       LDA $12    [$7E:0012]  ;\
$A0:B7BA 30 03       BMI $03    [$B7BF]     ;} If [$12] >= 0:
$A0:B7BC A0 0C 00    LDY #$000C             ; Y = Ch

$A0:B7BF 98          TYA                    ;\
$A0:B7C0 18          CLC                    ;|
$A0:B7C1 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Samus previous Y position = [Samus Y position] + [Y]
$A0:B7C4 8D 14 0B    STA $0B14  [$7E:0B14]  ;/

; BRANCH_Y_POSITION_END
$A0:B7C7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A0:B7CA 38          SEC                    ;|
$A0:B7CB ED 10 0B    SBC $0B10  [$7E:0B10]  ;} $12 = [Samus X position] - [Samus previous X position]
$A0:B7CE 85 12       STA $12    [$7E:0012]  ;/
$A0:B7D0 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;\
$A0:B7D4 C9 0C 00    CMP #$000C             ;} If |[$12]| < Ch: return
$A0:B7D7 30 12       BMI $12    [$B7EB]     ;/
$A0:B7D9 A0 F4 FF    LDY #$FFF4             ; Y = -Ch
$A0:B7DC A5 12       LDA $12    [$7E:0012]  ;\
$A0:B7DE 30 03       BMI $03    [$B7E3]     ;} If [$12] >= 0:
$A0:B7E0 A0 0C 00    LDY #$000C             ; Y = Ch

$A0:B7E3 98          TYA                    ;\
$A0:B7E4 18          CLC                    ;|
$A0:B7E5 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Samus previous X position = [Samus X position] + [Y]
$A0:B7E8 8D 10 0B    STA $0B10  [$7E:0B10]  ;/

$A0:B7EB 7A          PLY
$A0:B7EC FA          PLX
$A0:B7ED 6B          RTL
}


;;; $B7EE: Unsigned sine table ;;;
{
; sin(t * pi / 80h) * FFFFh
$A0:B7EE             dw 0000, 0648, 0C8F, 12D5, 1917, 1F56, 258F, 2BC3, 31F1, 3816, 3E33, 4447, 4A4F, 504D, 563E, 5C21,
                        61F7, 67BD, 6D73, 7319, 78AC, 7E2E, 839B, 88F5, 8E39, 9367, 987F, 9D7F, A266, A735, ABEA, B085,
                        B504, B967, BDAE, C1D7, C5E3, C9D0, CD9E, D14C, D4DA, D847, DB93, DEBD, E1C4, E4A9, E76A, EA08,
                        EC82, EED7, F108, F313, F4F9, F6B9, F852, F9C6, FB13, FC3A, FD39, FE12, FEC3, FF4D, FFB0, FFEB,
                        FFFF, FFEB, FFB0, FF4D, FEC3, FE12, FD39, FC3A, FB13, F9C6, F852, F6B9, F4F9, F313, F108, EED7,
                        EC82, EA08, E76A, E4A9, E1C4, DEBD, DB93, D847, D4DA, D14C, CD9E, C9D0, C5E3, C1D7, BDAE, B967,
                        B504, B085, ABEA, A735, A266, 9D7F, 987F, 9367, 8E39, 88F5, 839B, 7E2E, 78AC, 7319, 6D73, 67BD,
                        61F7, 5C21, 563E, 504D, 4A4F, 4447, 3E33, 3816, 31F1, 2BC3, 258F, 1F56, 1917, 12D5, 0C8F, 0648
}


;;; $B8EE..BB6F: Enemy death item drop routines ;;;
{
;;; $B8EE: Fake Kraid death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:B8EE DA          PHX
$A0:B8EF 5A          PHY
$A0:B8F0 08          PHP
$A0:B8F1 A9 04 00    LDA #$0004             ;\
$A0:B8F4 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 4 (number of drops)

; LOOP
$A0:B8F7 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:B8FB 29 1F 00    AND #$001F             ;\
$A0:B8FE 38          SEC                    ;|
$A0:B8FF E9 10 00    SBC #$0010             ;|
$A0:B902 18          CLC                    ;} $12 = [special death item drop X origin position] + [random number] % 20h - 10h
$A0:B903 6F 34 F4 7E ADC $7EF434[$7E:F434]  ;|
$A0:B907 85 12       STA $12    [$7E:0012]  ;/
$A0:B909 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:B90C 29 00 1F    AND #$1F00             ;|
$A0:B90F EB          XBA                    ;|
$A0:B910 38          SEC                    ;|
$A0:B911 E9 10 00    SBC #$0010             ;} $14 = [special death item drop Y origin position] + ([random number] >> 8) % 20h - 10h
$A0:B914 18          CLC                    ;|
$A0:B915 6F 36 F4 7E ADC $7EF436[$7E:F436]  ;|
$A0:B919 85 14       STA $14    [$7E:0014]  ;/
$A0:B91B A9 FF E0    LDA #$E0FF             ;\
$A0:B91E 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with fake Kraid's drop chances
$A0:B922 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:B925 D0 D0       BNE $D0    [$B8F7]     ; If [$060B] != 0: go to LOOP
$A0:B927 28          PLP
$A0:B928 7A          PLY
$A0:B929 FA          PLX
$A0:B92A 6B          RTL
}


;;; $B92B: Gold ninja space pirate death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:B92B DA          PHX
$A0:B92C 5A          PHY
$A0:B92D 08          PHP
$A0:B92E A9 05 00    LDA #$0005             ;\
$A0:B931 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 5 (number of drops)

; LOOP
$A0:B934 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:B938 29 1F 00    AND #$001F             ;\
$A0:B93B 38          SEC                    ;|
$A0:B93C E9 10 00    SBC #$0010             ;|
$A0:B93F 18          CLC                    ;} $12 = [special death item drop X origin position] + [random number] % 20h - 10h
$A0:B940 6F 34 F4 7E ADC $7EF434[$7E:F434]  ;|
$A0:B944 85 12       STA $12    [$7E:0012]  ;/
$A0:B946 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:B949 29 00 1F    AND #$1F00             ;|
$A0:B94C EB          XBA                    ;|
$A0:B94D 38          SEC                    ;|
$A0:B94E E9 10 00    SBC #$0010             ;} $14 = [special death item drop Y origin position] + ([random number] >> 8) % 20h - 10h
$A0:B951 18          CLC                    ;|
$A0:B952 6F 36 F4 7E ADC $7EF436[$7E:F436]  ;|
$A0:B956 85 14       STA $14    [$7E:0014]  ;/
$A0:B958 A9 93 F5    LDA #$F593             ;\
$A0:B95B 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with gold ninja space pirate's drop chances
$A0:B95F CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:B962 D0 D0       BNE $D0    [$B934]     ; If [$060B] != 0: go to LOOP
$A0:B964 28          PLP
$A0:B965 7A          PLY
$A0:B966 FA          PLX
$A0:B967 6B          RTL
}


;;; $B968: Metroid death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:B968 DA          PHX
$A0:B969 5A          PHY
$A0:B96A 08          PHP
$A0:B96B A9 05 00    LDA #$0005             ;\
$A0:B96E 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 5 (number of drops)

; LOOP
$A0:B971 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:B975 29 1F 00    AND #$001F             ;\
$A0:B978 38          SEC                    ;|
$A0:B979 E9 10 00    SBC #$0010             ;|
$A0:B97C 18          CLC                    ;} $12 = [special death item drop X origin position] + [random number] % 20h - 10h
$A0:B97D 6F 34 F4 7E ADC $7EF434[$7E:F434]  ;|
$A0:B981 85 12       STA $12    [$7E:0012]  ;/
$A0:B983 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:B986 29 00 1F    AND #$1F00             ;|
$A0:B989 EB          XBA                    ;|
$A0:B98A 38          SEC                    ;|
$A0:B98B E9 10 00    SBC #$0010             ;} $14 = [special death item drop Y origin position] + ([random number] >> 8) % 20h - 10h
$A0:B98E 18          CLC                    ;|
$A0:B98F 6F 36 F4 7E ADC $7EF436[$7E:F436]  ;|
$A0:B993 85 14       STA $14    [$7E:0014]  ;/
$A0:B995 A9 7F DD    LDA #$DD7F             ;\
$A0:B998 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with metroid's drop chances
$A0:B99C CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:B99F D0 D0       BNE $D0    [$B971]     ; If [$060B] != 0: go to LOOP
$A0:B9A1 28          PLP
$A0:B9A2 7A          PLY
$A0:B9A3 FA          PLX
$A0:B9A4 6B          RTL
}


;;; $B9A5: Ridley death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:B9A5 DA          PHX
$A0:B9A6 5A          PHY
$A0:B9A7 08          PHP
$A0:B9A8 A9 10 00    LDA #$0010             ;\
$A0:B9AB 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:B9AE 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:B9B2 29 7F 00    AND #$007F             ;\
$A0:B9B5 18          CLC                    ;|
$A0:B9B6 69 40 00    ADC #$0040             ;} $12 = 40h + [random number] % 80h (X position)
$A0:B9B9 85 12       STA $12    [$7E:0012]  ;/
$A0:B9BB AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:B9BE 29 00 3F    AND #$3F00             ;|
$A0:B9C1 EB          XBA                    ;|
$A0:B9C2 18          CLC                    ;} $14 = 140h + ([random number] >> 8) % 40h (Y position)
$A0:B9C3 69 40 01    ADC #$0140             ;|
$A0:B9C6 85 14       STA $14    [$7E:0014]  ;/
$A0:B9C8 A9 7F E1    LDA #$E17F             ;\
$A0:B9CB 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Ridley's drop chances
$A0:B9CF CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:B9D2 D0 DA       BNE $DA    [$B9AE]     ; If [$060B] != 0: go to LOOP
$A0:B9D4 28          PLP
$A0:B9D5 7A          PLY
$A0:B9D6 FA          PLX
$A0:B9D7 6B          RTL
}


;;; $B9D8: Crocomire death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:B9D8 DA          PHX
$A0:B9D9 5A          PHY
$A0:B9DA 08          PHP
$A0:B9DB A9 10 00    LDA #$0010             ;\
$A0:B9DE 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:B9E1 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:B9E5 29 7F 00    AND #$007F             ;\
$A0:B9E8 18          CLC                    ;|
$A0:B9E9 69 40 02    ADC #$0240             ;} $12 = 240h + [random number] % 80h (X position)
$A0:B9EC 85 12       STA $12    [$7E:0012]  ;/
$A0:B9EE AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:B9F1 29 00 3F    AND #$3F00             ;|
$A0:B9F4 EB          XBA                    ;|
$A0:B9F5 18          CLC                    ;} $14 = 60h + ([random number] >> 8) % 40h (Y position)
$A0:B9F6 69 60 00    ADC #$0060             ;|
$A0:B9F9 85 14       STA $14    [$7E:0014]  ;/
$A0:B9FB A9 BF DD    LDA #$DDBF             ;\
$A0:B9FE 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Crocomire's drop chances
$A0:BA02 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BA05 D0 DA       BNE $DA    [$B9E1]     ; If [$060B] != 0: go to LOOP
$A0:BA07 28          PLP
$A0:BA08 7A          PLY
$A0:BA09 FA          PLX
$A0:BA0A 6B          RTL
}


;;; $BA0B: Phantoon death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BA0B DA          PHX
$A0:BA0C 5A          PHY
$A0:BA0D 08          PHP
$A0:BA0E A9 10 00    LDA #$0010             ;\
$A0:BA11 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BA14 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BA18 29 7F 00    AND #$007F             ;\
$A0:BA1B 18          CLC                    ;|
$A0:BA1C 69 40 00    ADC #$0040             ;} $12 = 40h + [random number] % 80h (X position)
$A0:BA1F 85 12       STA $12    [$7E:0012]  ;/
$A0:BA21 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BA24 29 00 3F    AND #$3F00             ;|
$A0:BA27 EB          XBA                    ;|
$A0:BA28 18          CLC                    ;} $14 = 60h + ([random number] >> 8) % 40h (Y position)
$A0:BA29 69 60 00    ADC #$0060             ;|
$A0:BA2C 85 14       STA $14    [$7E:0014]  ;/
$A0:BA2E A9 BF E4    LDA #$E4BF             ;\
$A0:BA31 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Phantoon body's drop chances
$A0:BA35 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BA38 D0 DA       BNE $DA    [$BA14]     ; If [$060B] != 0: go to LOOP
$A0:BA3A 28          PLP
$A0:BA3B 7A          PLY
$A0:BA3C FA          PLX
$A0:BA3D 6B          RTL
}


;;; $BA3E: Botwoon death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BA3E DA          PHX
$A0:BA3F 5A          PHY
$A0:BA40 08          PHP
$A0:BA41 A9 10 00    LDA #$0010             ;\
$A0:BA44 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BA47 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BA4B 29 7F 00    AND #$007F             ;\
$A0:BA4E 18          CLC                    ;|
$A0:BA4F 69 40 00    ADC #$0040             ;} $12 = 40h + [random number] % 80h (X position)
$A0:BA52 85 12       STA $12    [$7E:0012]  ;/
$A0:BA54 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BA57 29 00 3F    AND #$3F00             ;|
$A0:BA5A EB          XBA                    ;|
$A0:BA5B 18          CLC                    ;} $14 = 80h + ([random number] >> 8) % 40h (Y position)
$A0:BA5C 69 80 00    ADC #$0080             ;|
$A0:BA5F 85 14       STA $14    [$7E:0014]  ;/
$A0:BA61 A9 93 F2    LDA #$F293             ;\
$A0:BA64 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Botwoon's drop chances
$A0:BA68 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BA6B D0 DA       BNE $DA    [$BA47]     ; If [$060B] != 0: go to LOOP
$A0:BA6D 28          PLP
$A0:BA6E 7A          PLY
$A0:BA6F FA          PLX
$A0:BA70 6B          RTL
}


;;; $BA71: Kraid death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BA71 DA          PHX
$A0:BA72 5A          PHY
$A0:BA73 08          PHP
$A0:BA74 A9 10 00    LDA #$0010             ;\
$A0:BA77 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BA7A 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BA7E 29 FF 00    AND #$00FF             ;\
$A0:BA81 18          CLC                    ;|
$A0:BA82 69 80 00    ADC #$0080             ;} $12 = 80h + [random number] % 100h (X position)
$A0:BA85 85 12       STA $12    [$7E:0012]  ;/
$A0:BA87 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BA8A 29 00 3F    AND #$3F00             ;|
$A0:BA8D EB          XBA                    ;|
$A0:BA8E 18          CLC                    ;} $14 = 160h + ([random number] >> 8) % 40h (Y position)
$A0:BA8F 69 60 01    ADC #$0160             ;|
$A0:BA92 85 14       STA $14    [$7E:0014]  ;/
$A0:BA94 A9 BF E2    LDA #$E2BF             ;\
$A0:BA97 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Kraid's drop chances
$A0:BA9B CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BA9E D0 DA       BNE $DA    [$BA7A]     ; If [$060B] != 0: go to LOOP
$A0:BAA0 28          PLP
$A0:BAA1 7A          PLY
$A0:BAA2 FA          PLX
$A0:BAA3 6B          RTL
}


;;; $BAA4: Bomb Torizo death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BAA4 DA          PHX
$A0:BAA5 5A          PHY
$A0:BAA6 08          PHP
$A0:BAA7 A9 10 00    LDA #$0010             ;\
$A0:BAAA 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BAAD 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BAB1 29 7F 00    AND #$007F             ;\
$A0:BAB4 18          CLC                    ;|
$A0:BAB5 69 40 00    ADC #$0040             ;} $12 = 40h + [random number] % 80h (X position)
$A0:BAB8 85 12       STA $12    [$7E:0012]  ;/
$A0:BABA AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BABD 29 00 3F    AND #$3F00             ;|
$A0:BAC0 EB          XBA                    ;|
$A0:BAC1 18          CLC                    ;} $14 = 60h + ([random number] >> 8) % 40h (Y position)
$A0:BAC2 69 60 00    ADC #$0060             ;|
$A0:BAC5 85 14       STA $14    [$7E:0014]  ;/
$A0:BAC7 A9 FF EE    LDA #$EEFF             ;\
$A0:BACA 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Bomb Torizo's drop chances
$A0:BACE CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BAD1 D0 DA       BNE $DA    [$BAAD]     ; If [$060B] != 0: go to LOOP
$A0:BAD3 28          PLP
$A0:BAD4 7A          PLY
$A0:BAD5 FA          PLX
$A0:BAD6 6B          RTL
}


;;; $BAD7: Golden Torizo death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BAD7 DA          PHX
$A0:BAD8 5A          PHY
$A0:BAD9 08          PHP
$A0:BADA A9 10 00    LDA #$0010             ;\
$A0:BADD 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BAE0 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BAE4 29 FF 00    AND #$00FF             ;\
$A0:BAE7 18          CLC                    ;|
$A0:BAE8 69 80 00    ADC #$0080             ;} $12 = 80h + [random number] % 80h (X position)
$A0:BAEB 85 12       STA $12    [$7E:0012]  ;/
$A0:BAED AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BAF0 29 00 3F    AND #$3F00             ;|
$A0:BAF3 EB          XBA                    ;|
$A0:BAF4 18          CLC                    ;} $14 = 120h + ([random number] >> 8) % 40h (Y position)
$A0:BAF5 69 20 01    ADC #$0120             ;|
$A0:BAF8 85 14       STA $14    [$7E:0014]  ;/
$A0:BAFA A9 FF EE    LDA #$EEFF             ;\
$A0:BAFD 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Bomb Torizo's(!) drop chances
$A0:BB01 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BB04 D0 DA       BNE $DA    [$BAE0]     ; If [$060B] != 0: go to LOOP
$A0:BB06 28          PLP
$A0:BB07 7A          PLY
$A0:BB08 FA          PLX
$A0:BB09 6B          RTL
}


;;; $BB0A: Spore Spawn death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BB0A DA          PHX
$A0:BB0B 5A          PHY
$A0:BB0C 08          PHP
$A0:BB0D A9 10 00    LDA #$0010             ;\
$A0:BB10 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BB13 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BB17 29 7F 00    AND #$007F             ;\
$A0:BB1A 18          CLC                    ;|
$A0:BB1B 69 40 00    ADC #$0040             ;} $12 = 40h + [random number] % 80h (X position)
$A0:BB1E 85 12       STA $12    [$7E:0012]  ;/
$A0:BB20 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BB23 29 00 3F    AND #$3F00             ;|
$A0:BB26 EB          XBA                    ;|
$A0:BB27 18          CLC                    ;} $14 = 210h + ([random number] >> 8) % 40h (Y position)
$A0:BB28 69 10 02    ADC #$0210             ;|
$A0:BB2B 85 14       STA $14    [$7E:0014]  ;/
$A0:BB2D A9 3F DF    LDA #$DF3F             ;\
$A0:BB30 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Spore Spawn's drop chances
$A0:BB34 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BB37 D0 DA       BNE $DA    [$BB13]     ; If [$060B] != 0: go to LOOP
$A0:BB39 28          PLP
$A0:BB3A 7A          PLY
$A0:BB3B FA          PLX
$A0:BB3C 6B          RTL
}


;;; $BB3D: Draygon death item drop routine ;;;
{
;; Parameters:
;;     X: Enemy index
$A0:BB3D DA          PHX
$A0:BB3E 5A          PHY
$A0:BB3F 08          PHP
$A0:BB40 A9 10 00    LDA #$0010             ;\
$A0:BB43 8D 0B 06    STA $060B  [$7E:060B]  ;} $060B = 10h (number of drops)

; LOOP
$A0:BB46 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A0:BB4A 29 FF 00    AND #$00FF             ;\
$A0:BB4D 18          CLC                    ;|
$A0:BB4E 69 80 00    ADC #$0080             ;} $12 = 80h + [random number] % 100h (X position)
$A0:BB51 85 12       STA $12    [$7E:0012]  ;/
$A0:BB53 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A0:BB56 29 00 3F    AND #$3F00             ;|
$A0:BB59 EB          XBA                    ;|
$A0:BB5A 18          CLC                    ;} $14 = 160h + ([random number] >> 8) % 40h (Y position)
$A0:BB5B 69 60 01    ADC #$0160             ;|
$A0:BB5E 85 14       STA $14    [$7E:0014]  ;/
$A0:BB60 A9 3F DE    LDA #$DE3F             ;\
$A0:BB63 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn item drop with Draygon body's drop chances
$A0:BB67 CE 0B 06    DEC $060B  [$7E:060B]  ; Decrement $060B
$A0:BB6A D0 DA       BNE $DA    [$BB46]     ; If [$060B] != 0: go to LOOP
$A0:BB6C 28          PLP
$A0:BB6D 7A          PLY
$A0:BB6E FA          PLX
$A0:BB6F 6B          RTL
}
}


;;; $BB70: Calculate the block containing a pixel position ;;;
{
;; Parameters:
;;     [S] + 4: Y position
;;     [S] + 6: X position

; Call after pushing a X then Y pixel position onto the stack (2 bytes each)
; $0DC4 is set to the block index. The stack is cleaned up (do not try to pop Y and X position from stack)
$A0:BB70 A3 04       LDA $04,s  [$7E:1FEB]  ;\
$A0:BB72 4A          LSR A                  ;|
$A0:BB73 4A          LSR A                  ;|
$A0:BB74 4A          LSR A                  ;|
$A0:BB75 4A          LSR A                  ;|
$A0:BB76 E2 20       SEP #$20               ;|
$A0:BB78 8D 02 42    STA $4202              ;|
$A0:BB7B AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BB7E 8D 03 42    STA $4203              ;|
$A0:BB81 C2 20       REP #$20               ;} Current block index = [[S] + 4] / 10h * [room width in blocks] + [[S] + 6] / 10h
$A0:BB83 A3 06       LDA $06,s  [$7E:1FED]  ;|
$A0:BB85 4A          LSR A                  ;|
$A0:BB86 4A          LSR A                  ;|
$A0:BB87 4A          LSR A                  ;|
$A0:BB88 4A          LSR A                  ;|
$A0:BB89 18          CLC                    ;|
$A0:BB8A 6D 16 42    ADC $4216              ;|
$A0:BB8D 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$A0:BB90 A3 02       LDA $02,s  [$7E:1FE9]  ;\
$A0:BB92 83 06       STA $06,s  [$7E:1FED]  ;|
$A0:BB94 A3 01       LDA $01,s  [$7E:1FE8]  ;} [S] + 5 = [[S] + 1] (move return address 4 bytes up the stack)
$A0:BB96 83 05       STA $05,s  [$7E:1FEC]  ;/
$A0:BB98 68          PLA                    ;\
$A0:BB99 68          PLA                    ;} S += 4
$A0:BB9A 6B          RTL
}


;;; $BB9B: Check if X distance between enemy and Samus is at least [A] ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     Carry: Set if X distance between enemy and Samus is at least [A], clear otherwise
$A0:BB9B 48          PHA
$A0:BB9C AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A0:BB9F 38          SEC
$A0:BBA0 FD 7A 0F    SBC $0F7A,x[$7E:107A]
$A0:BBA3 10 04       BPL $04    [$BBA9]
$A0:BBA5 49 FF FF    EOR #$FFFF
$A0:BBA8 1A          INC A

$A0:BBA9 C3 01       CMP $01,s  [$7E:1FEF]
$A0:BBAB 68          PLA
$A0:BBAC 6B          RTL
}


;;; $BBAD: Unused. Check if Y distance between enemy and Samus is at least [A] ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     Carry: Set if Y distance between enemy and Samus is at least [A], clear otherwise
$A0:BBAD 48          PHA
$A0:BBAE AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A0:BBB1 38          SEC
$A0:BBB2 FD 7E 0F    SBC $0F7E,x
$A0:BBB5 10 04       BPL $04    [$BBBB]
$A0:BBB7 49 FF FF    EOR #$FFFF
$A0:BBBA 1A          INC A

$A0:BBBB C3 01       CMP $01,s
$A0:BBBD 68          PLA
$A0:BBBE 6B          RTL
}


;;; $BBBF..C04D: Enemy "solid" block collision detection ;;;
{
;;; $BBBF: Check for horizontal "solid" block collision ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to check for collision (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:BBBF 8B          PHB
$A0:BBC0 E2 20       SEP #$20               ;\
$A0:BBC2 A9 A0       LDA #$A0               ;|
$A0:BBC4 48          PHA                    ;} DB = $A0
$A0:BBC5 AB          PLB                    ;|
$A0:BBC6 C2 30       REP #$30               ;/
$A0:BBC8 DA          PHX
$A0:BBC9 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A0:BBCC 38          SEC                    ;|
$A0:BBCD FD 84 0F    SBC $0F84,x[$7E:1004]  ;|
$A0:BBD0 29 F0 FF    AND #$FFF0             ;|
$A0:BBD3 85 1A       STA $1A    [$7E:001A]  ;|
$A0:BBD5 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$A0:BBD8 18          CLC                    ;|
$A0:BBD9 7D 84 0F    ADC $0F84,x[$7E:1004]  ;|
$A0:BBDC 3A          DEC A                  ;} $1A = (enemy bottom boundary) / 10h - (enemy top boundary) / 10h (number of blocks left to check)
$A0:BBDD 38          SEC                    ;|
$A0:BBDE E5 1A       SBC $1A    [$7E:001A]  ;|
$A0:BBE0 4A          LSR A                  ;|
$A0:BBE1 4A          LSR A                  ;|
$A0:BBE2 4A          LSR A                  ;|
$A0:BBE3 4A          LSR A                  ;|
$A0:BBE4 85 1A       STA $1A    [$7E:001A]  ;/
$A0:BBE6 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A0:BBE9 38          SEC                    ;|
$A0:BBEA FD 84 0F    SBC $0F84,x[$7E:1004]  ;|
$A0:BBED 4A          LSR A                  ;|
$A0:BBEE 4A          LSR A                  ;|
$A0:BBEF 4A          LSR A                  ;} Calculate (enemy top boundary) / 10h * [room width in blocks] (target row block index)
$A0:BBF0 4A          LSR A                  ;|
$A0:BBF1 E2 20       SEP #$20               ;|
$A0:BBF3 8D 02 42    STA $4202              ;|
$A0:BBF6 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BBF9 8D 03 42    STA $4203              ;|
$A0:BBFC C2 20       REP #$20               ;/
$A0:BBFE BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;\
$A0:BC01 18          CLC                    ;|
$A0:BC02 65 12       ADC $12    [$7E:0012]  ;|
$A0:BC04 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy X position] + [$14].[$12] (target X position)
$A0:BC06 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$A0:BC09 65 14       ADC $14    [$7E:0014]  ;|
$A0:BC0B 85 18       STA $18    [$7E:0018]  ;/
$A0:BC0D 24 14       BIT $14    [$7E:0014]  ;\
$A0:BC0F 30 07       BMI $07    [$BC18]     ;} If [$14] >= 0:
$A0:BC11 18          CLC                    ;\
$A0:BC12 7D 82 0F    ADC $0F82,x[$7E:1182]  ;} $22 = (target right boundary)
$A0:BC15 3A          DEC A                  ;/
$A0:BC16 80 04       BRA $04    [$BC1C]

$A0:BC18 38          SEC                    ;\ Else ([$14] < 0):
$A0:BC19 FD 82 0F    SBC $0F82,x[$7E:1002]  ;} $22 = (target left boundary)

$A0:BC1C 85 22       STA $22    [$7E:0022]
$A0:BC1E 4A          LSR A                  ;\
$A0:BC1F 4A          LSR A                  ;|
$A0:BC20 4A          LSR A                  ;|
$A0:BC21 4A          LSR A                  ;|
$A0:BC22 18          CLC                    ;} X = ((target row block index) + [$22] / 10h) * 2 (index of top block to check)
$A0:BC23 6D 16 42    ADC $4216              ;|
$A0:BC26 0A          ASL A                  ;|
$A0:BC27 AA          TAX                    ;/

; LOOP
$A0:BC28 BF 02 00 7F LDA $7F0002,x[$7F:021E];\
$A0:BC2C 30 11       BMI $11    [$BC3F]     ;} If (block type) < 8: <-- including horizontal extension, but not vertical extension ^^;
$A0:BC2E 8A          TXA                    ;\
$A0:BC2F 18          CLC                    ;|
$A0:BC30 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$A0:BC33 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$A0:BC36 AA          TAX                    ;/
$A0:BC37 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$A0:BC39 10 ED       BPL $ED    [$BC28]     ; If [$1A] >= 0: go to LOOP
$A0:BC3B FA          PLX
$A0:BC3C 18          CLC                    ;\
$A0:BC3D AB          PLB                    ;} Return carry clear
$A0:BC3E 6B          RTL                    ;/

$A0:BC3F FA          PLX
$A0:BC40 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A0:BC42 A5 22       LDA $22    [$7E:0022]
$A0:BC44 24 14       BIT $14    [$7E:0014]  ;\
$A0:BC46 30 15       BMI $15    [$BC5D]     ;} If [$14] < 0: go to BRANCH_MOVING_LEFT
$A0:BC48 29 F0 FF    AND #$FFF0             ; A = [$22] - [$22] % 10h (target right boundary rounded down to left of 16x16 tile)
$A0:BC4B 38          SEC                    ;\
$A0:BC4C FD 82 0F    SBC $0F82,x[$7E:1182]  ;|
$A0:BC4F 38          SEC                    ;|
$A0:BC50 FD 7A 0F    SBC $0F7A,x[$7E:117A]  ;|
$A0:BC53 10 03       BPL $03    [$BC58]     ;} $14 = max(0, [A] - [enemy X radius] - [enemy X position])
$A0:BC55 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:BC58 85 14       STA $14    [$7E:0014]  ;/
$A0:BC5A 38          SEC                    ;\
$A0:BC5B AB          PLB                    ;} Return carry set
$A0:BC5C 6B          RTL                    ;/

; BRANCH_MOVING_LEFT
$A0:BC5D 09 0F 00    ORA #$000F             ;\
$A0:BC60 38          SEC                    ;} A = [$22] - [$22] % 10h + 10h (target left boundary rounded up to right of 16x16 tile)
$A0:BC61 7D 82 0F    ADC $0F82,x[$7E:0FC2]  ;\
$A0:BC64 38          SEC                    ;|
$A0:BC65 FD 7A 0F    SBC $0F7A,x[$7E:0FBA]  ;|
$A0:BC68 30 03       BMI $03    [$BC6D]     ;|
$A0:BC6A A9 00 00    LDA #$0000             ;} $14 = -max(0, [A] + [enemy X radius] - [enemy X position])
                                            ;|
$A0:BC6D 49 FF FF    EOR #$FFFF             ;|
$A0:BC70 1A          INC A                  ;|
$A0:BC71 85 14       STA $14    [$7E:0014]  ;/
$A0:BC73 38          SEC                    ;\
$A0:BC74 AB          PLB                    ;} Return carry set
$A0:BC75 6B          RTL                    ;/
}


;;; $BC76: Check for vertical "solid" block collision ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to check for collision (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:BC76 8B          PHB
$A0:BC77 E2 20       SEP #$20               ;\
$A0:BC79 A9 A0       LDA #$A0               ;|
$A0:BC7B 48          PHA                    ;} DB = $A0
$A0:BC7C AB          PLB                    ;|
$A0:BC7D C2 30       REP #$30               ;/
$A0:BC7F DA          PHX
$A0:BC80 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A0:BC83 38          SEC                    ;|
$A0:BC84 FD 82 0F    SBC $0F82,x[$7E:1082]  ;|
$A0:BC87 29 F0 FF    AND #$FFF0             ;|
$A0:BC8A 85 1A       STA $1A    [$7E:001A]  ;|
$A0:BC8C BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;|
$A0:BC8F 18          CLC                    ;|
$A0:BC90 7D 82 0F    ADC $0F82,x[$7E:1082]  ;|
$A0:BC93 3A          DEC A                  ;} $1A = (enemy right boundary) / 10h - (enemy left boundary) / 10h (number of blocks left to check)
$A0:BC94 38          SEC                    ;|
$A0:BC95 E5 1A       SBC $1A    [$7E:001A]  ;|
$A0:BC97 4A          LSR A                  ;|
$A0:BC98 4A          LSR A                  ;|
$A0:BC99 4A          LSR A                  ;|
$A0:BC9A 4A          LSR A                  ;|
$A0:BC9B 85 1A       STA $1A    [$7E:001A]  ;/
$A0:BC9D BD 80 0F    LDA $0F80,x[$7E:1080]  ;\
$A0:BCA0 18          CLC                    ;|
$A0:BCA1 65 12       ADC $12    [$7E:0012]  ;|
$A0:BCA3 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy Y position] + [$14].[$12] (target position)
$A0:BCA5 BD 7E 0F    LDA $0F7E,x[$7E:107E]  ;|
$A0:BCA8 65 14       ADC $14    [$7E:0014]  ;|
$A0:BCAA 85 18       STA $18    [$7E:0018]  ;/
$A0:BCAC 24 14       BIT $14    [$7E:0014]  ;\
$A0:BCAE 30 07       BMI $07    [$BCB7]     ;} If [$14] >= 0: (moving down)
$A0:BCB0 18          CLC                    ;\
$A0:BCB1 7D 84 0F    ADC $0F84,x[$7E:1084]  ;} $22 = [$18] + [enemy Y radius] - 1 (target front boundary)
$A0:BCB4 3A          DEC A                  ;/
$A0:BCB5 80 04       BRA $04    [$BCBB]

$A0:BCB7 38          SEC                    ;\ Else ([$14] < 0): (moving up)
$A0:BCB8 FD 84 0F    SBC $0F84,x[$7E:1044]  ;} $22 = [$18] - [enemy Y radius] (target front boundary)

$A0:BCBB 85 22       STA $22    [$7E:0022]
$A0:BCBD 4A          LSR A                  ;\
$A0:BCBE 4A          LSR A                  ;|
$A0:BCBF 4A          LSR A                  ;|
$A0:BCC0 4A          LSR A                  ;|
$A0:BCC1 E2 20       SEP #$20               ;|
$A0:BCC3 8D 02 42    STA $4202              ;|
$A0:BCC6 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BCC9 8D 03 42    STA $4203              ;|
$A0:BCCC C2 20       REP #$20               ;|
$A0:BCCE BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;|
$A0:BCD1 38          SEC                    ;} X = ((enemy front boundary) / 10h * [room width] + (enemy left boundary) / 10h) * 2 (index of leftmost block to check)
$A0:BCD2 FD 82 0F    SBC $0F82,x[$7E:1082]  ;|
$A0:BCD5 4A          LSR A                  ;|
$A0:BCD6 4A          LSR A                  ;|
$A0:BCD7 4A          LSR A                  ;|
$A0:BCD8 4A          LSR A                  ;|
$A0:BCD9 18          CLC                    ;|
$A0:BCDA 6D 16 42    ADC $4216              ;|
$A0:BCDD 0A          ASL A                  ;|
$A0:BCDE AA          TAX                    ;/

; LOOP
$A0:BCDF BF 02 00 7F LDA $7F0002,x[$7F:232A];\
$A0:BCE3 30 0A       BMI $0A    [$BCEF]     ;} If (block type) < 8:
$A0:BCE5 E8          INX                    ;\
$A0:BCE6 E8          INX                    ;} X += 2
$A0:BCE7 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$A0:BCE9 10 F4       BPL $F4    [$BCDF]     ; If [$1A] >= 0: go to LOOP
$A0:BCEB FA          PLX
$A0:BCEC 18          CLC                    ;\
$A0:BCED AB          PLB                    ;} Return carry clear
$A0:BCEE 6B          RTL                    ;/

$A0:BCEF FA          PLX
$A0:BCF0 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A0:BCF2 A5 22       LDA $22    [$7E:0022]
$A0:BCF4 24 14       BIT $14    [$7E:0014]  ;\
$A0:BCF6 30 15       BMI $15    [$BD0D]     ;} If [$14] < 0: go to BRANCH_MOVING_UP
$A0:BCF8 29 F0 FF    AND #$FFF0             ; A = [$22] - [$22] % 10h (target bottom boundary rounded down to top of 16x16 tile)
$A0:BCFB 38          SEC                    ;\
$A0:BCFC FD 84 0F    SBC $0F84,x[$7E:1084]  ;|
$A0:BCFF 38          SEC                    ;|
$A0:BD00 FD 7E 0F    SBC $0F7E,x[$7E:107E]  ;|
$A0:BD03 10 03       BPL $03    [$BD08]     ;} $14 = max(0, [A] - [enemy Y radius] - [enemy Y position])
$A0:BD05 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:BD08 85 14       STA $14    [$7E:0014]  ;/
$A0:BD0A 38          SEC                    ;\
$A0:BD0B AB          PLB                    ;} Return carry set
$A0:BD0C 6B          RTL                    ;/

; BRANCH_MOVING_UP
$A0:BD0D 09 0F 00    ORA #$000F             ;\
$A0:BD10 38          SEC                    ;} A = [$22] - [$22] % 10h + 10h (target top boundary rounded up to bottom of 16x16 tile)
$A0:BD11 7D 84 0F    ADC $0F84,x[$7E:1044]  ;\
$A0:BD14 38          SEC                    ;|
$A0:BD15 FD 7E 0F    SBC $0F7E,x[$7E:103E]  ;|
$A0:BD18 30 03       BMI $03    [$BD1D]     ;|
$A0:BD1A A9 00 00    LDA #$0000             ;} $14 = -max(0, [A] + [enemy Y radius] - [enemy Y position])
                                            ;|
$A0:BD1D 49 FF FF    EOR #$FFFF             ;|
$A0:BD20 1A          INC A                  ;|
$A0:BD21 85 14       STA $14    [$7E:0014]  ;/
$A0:BD23 38          SEC                    ;\
$A0:BD24 AB          PLB                    ;} Return carry set
$A0:BD25 6B          RTL                    ;/
}


;;; $BD26: Unused. Move enemy right by [$14].[$12], no block collision reactions ;;;
{
;; Parameters:
;;     A: Direction. 0 = left, 1 = right
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:BD26 8B          PHB
$A0:BD27 E2 20       SEP #$20               ;\
$A0:BD29 A9 A0       LDA #$A0               ;|
$A0:BD2B 48          PHA                    ;} DB = $A0 <-- clobbers A, whoops
$A0:BD2C AB          PLB                    ;|
$A0:BD2D C2 30       REP #$30               ;/
$A0:BD2F DA          PHX
$A0:BD30 85 1C       STA $1C    [$7E:001C]  ; $1C = [A]
$A0:BD32 BD 7E 0F    LDA $0F7E,x            ;\
$A0:BD35 38          SEC                    ;|
$A0:BD36 FD 84 0F    SBC $0F84,x            ;|
$A0:BD39 29 F0 FF    AND #$FFF0             ;|
$A0:BD3C 85 1A       STA $1A    [$7E:001A]  ;|
$A0:BD3E BD 7E 0F    LDA $0F7E,x            ;|
$A0:BD41 18          CLC                    ;|
$A0:BD42 7D 84 0F    ADC $0F84,x            ;|
$A0:BD45 3A          DEC A                  ;} $1A = (enemy bottom boundary) / 10h - (enemy top boundary) / 10h (number of blocks left to check)
$A0:BD46 38          SEC                    ;|
$A0:BD47 E5 1A       SBC $1A    [$7E:001A]  ;|
$A0:BD49 4A          LSR A                  ;|
$A0:BD4A 4A          LSR A                  ;|
$A0:BD4B 4A          LSR A                  ;|
$A0:BD4C 4A          LSR A                  ;|
$A0:BD4D 85 1A       STA $1A    [$7E:001A]  ;/
$A0:BD4F BD 7E 0F    LDA $0F7E,x            ;\
$A0:BD52 38          SEC                    ;|
$A0:BD53 FD 84 0F    SBC $0F84,x            ;|
$A0:BD56 4A          LSR A                  ;|
$A0:BD57 4A          LSR A                  ;|
$A0:BD58 4A          LSR A                  ;} Calculate (enemy top boundary) / 10h * [room width in blocks] (target row block index)
$A0:BD59 4A          LSR A                  ;|
$A0:BD5A E2 20       SEP #$20               ;|
$A0:BD5C 8D 02 42    STA $4202              ;|
$A0:BD5F AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BD62 8D 03 42    STA $4203              ;|
$A0:BD65 C2 20       REP #$20               ;/
$A0:BD67 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BD69 4A          LSR A                  ;} If [$1C] & 1 != 0:
$A0:BD6A 90 16       BCC $16    [$BD82]     ;/
$A0:BD6C BD 7C 0F    LDA $0F7C,x            ;\
$A0:BD6F 18          CLC                    ;|
$A0:BD70 65 12       ADC $12    [$7E:0012]  ;|
$A0:BD72 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy X position] + [$14].[$12] (target X position)
$A0:BD74 BD 7A 0F    LDA $0F7A,x            ;|
$A0:BD77 65 14       ADC $14    [$7E:0014]  ;|
$A0:BD79 85 18       STA $18    [$7E:0018]  ;/
$A0:BD7B 18          CLC                    ;\
$A0:BD7C 7D 82 0F    ADC $0F82,x            ;} $22 = (target right boundary)
$A0:BD7F 3A          DEC A                  ;/
$A0:BD80 80 13       BRA $13    [$BD95]

$A0:BD82 BD 7C 0F    LDA $0F7C,x            ;\ Else ([$1C] & 1 = 0):
$A0:BD85 38          SEC                    ;|
$A0:BD86 E5 12       SBC $12    [$7E:0012]  ;|
$A0:BD88 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy X position] - [$14].[$12] (target X position)
$A0:BD8A BD 7A 0F    LDA $0F7A,x            ;|
$A0:BD8D E5 14       SBC $14    [$7E:0014]  ;|
$A0:BD8F 85 18       STA $18    [$7E:0018]  ;/
$A0:BD91 38          SEC                    ;\
$A0:BD92 FD 82 0F    SBC $0F82,x            ;} $22 = (target left boundary)

$A0:BD95 85 22       STA $22    [$7E:0022]
$A0:BD97 4A          LSR A                  ;\
$A0:BD98 4A          LSR A                  ;|
$A0:BD99 4A          LSR A                  ;|
$A0:BD9A 4A          LSR A                  ;|
$A0:BD9B 18          CLC                    ;} X = ((target row block index) + [$22] / 10h) * 2 (index of top block to check)
$A0:BD9C 6D 16 42    ADC $4216              ;|
$A0:BD9F 0A          ASL A                  ;|
$A0:BDA0 AA          TAX                    ;/

; LOOP
$A0:BDA1 BF 02 00 7F LDA $7F0002,x          ;\
$A0:BDA5 30 1B       BMI $1B    [$BDC2]     ;} If (block type) < 8:
$A0:BDA7 8A          TXA                    ;\
$A0:BDA8 18          CLC                    ;|
$A0:BDA9 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$A0:BDAC 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$A0:BDAF AA          TAX                    ;/
$A0:BDB0 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$A0:BDB2 10 ED       BPL $ED    [$BDA1]     ; If [$1A] >= 0: go to LOOP
$A0:BDB4 FA          PLX
$A0:BDB5 A5 16       LDA $16    [$7E:0016]  ;\
$A0:BDB7 9D 7C 0F    STA $0F7C,x            ;|
$A0:BDBA A5 18       LDA $18    [$7E:0018]  ;} Enemy X position = (target X position)
$A0:BDBC 9D 7A 0F    STA $0F7A,x            ;/
$A0:BDBF 18          CLC                    ;\
$A0:BDC0 AB          PLB                    ;} Return carry clear
$A0:BDC1 6B          RTL                    ;/

$A0:BDC2 FA          PLX
$A0:BDC3 9E 7C 0F    STZ $0F7C,x            ; Enemy X subposition = 0
$A0:BDC6 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BDC8 4A          LSR A                  ;} If [$1C] & 1 = 0: go to BRANCH_MOVING_LEFT
$A0:BDC9 90 14       BCC $14    [$BDDF]     ;/
$A0:BDCB A5 22       LDA $22    [$7E:0022]  ;\
$A0:BDCD 29 F0 FF    AND #$FFF0             ;} A = [$22] - [$22] % 10h (target right boundary rounded down to left of 16x16 tile)
$A0:BDD0 38          SEC                    ;\
$A0:BDD1 FD 82 0F    SBC $0F82,x            ;|
$A0:BDD4 DD 7A 0F    CMP $0F7A,x            ;} Enemy X position = min([enemy X position], [A] - [enemy X radius])
$A0:BDD7 30 03       BMI $03    [$BDDC]     ;|
$A0:BDD9 9D 7A 0F    STA $0F7A,x            ;/

$A0:BDDC 38          SEC                    ;\
$A0:BDDD AB          PLB                    ;} Return carry set
$A0:BDDE 6B          RTL                    ;/

; BRANCH_MOVING_LEFT
$A0:BDDF A5 22       LDA $22    [$7E:0022]  ;\
$A0:BDE1 09 0F 00    ORA #$000F             ;} A = [$22] - [$22] % 10h + 10h (target left boundary rounded up to right of 16x16 tile)
$A0:BDE4 38          SEC                    ;/
$A0:BDE5 7D 82 0F    ADC $0F82,x            ;\
$A0:BDE8 38          SEC                    ;|
$A0:BDE9 DD 7A 0F    CMP $0F7A,x            ;|
$A0:BDEC F0 02       BEQ $02    [$BDF0]     ;} Enemy X position = max([enemy X position], [A] + [enemy X radius])
$A0:BDEE 10 03       BPL $03    [$BDF3]     ;|
                                            ;|
$A0:BDF0 9D 7A 0F    STA $0F7A,x            ;/

$A0:BDF3 38          SEC                    ;\
$A0:BDF4 AB          PLB                    ;} Return carry set
$A0:BDF5 6B          RTL                    ;/
}


;;; $BDF6: Unused. Move enemy down by [$14].[$12], no block collision reactions ;;;
{
;; Parameters:
;;     A: Direction. 0 = up, 1 = down
;;     X: Enemy index
;;     $14.$12: Distance to move (unsigned)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:BDF6 8B          PHB
$A0:BDF7 E2 20       SEP #$20               ;\
$A0:BDF9 A9 A0       LDA #$A0               ;|
$A0:BDFB 48          PHA                    ;} DB = $A0 <-- clobbers A, whoops
$A0:BDFC AB          PLB                    ;|
$A0:BDFD C2 30       REP #$30               ;/
$A0:BDFF 85 1C       STA $1C    [$7E:001C]  ; $1C = [A]
$A0:BE01 DA          PHX
$A0:BE02 BD 7A 0F    LDA $0F7A,x            ;\
$A0:BE05 38          SEC                    ;|
$A0:BE06 FD 82 0F    SBC $0F82,x            ;|
$A0:BE09 29 F0 FF    AND #$FFF0             ;|
$A0:BE0C 85 1A       STA $1A    [$7E:001A]  ;|
$A0:BE0E BD 7A 0F    LDA $0F7A,x            ;|
$A0:BE11 18          CLC                    ;|
$A0:BE12 7D 82 0F    ADC $0F82,x            ;|
$A0:BE15 3A          DEC A                  ;} $1A = (enemy right boundary) / 10h - (enemy left boundary) / 10h (number of blocks left to check)
$A0:BE16 38          SEC                    ;|
$A0:BE17 E5 1A       SBC $1A    [$7E:001A]  ;|
$A0:BE19 4A          LSR A                  ;|
$A0:BE1A 4A          LSR A                  ;|
$A0:BE1B 4A          LSR A                  ;|
$A0:BE1C 4A          LSR A                  ;|
$A0:BE1D 85 1A       STA $1A    [$7E:001A]  ;/
$A0:BE1F A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BE21 4A          LSR A                  ;} If [$1C] & 1 != 0:
$A0:BE22 90 16       BCC $16    [$BE3A]     ;/
$A0:BE24 BD 80 0F    LDA $0F80,x            ;\
$A0:BE27 18          CLC                    ;|
$A0:BE28 65 12       ADC $12    [$7E:0012]  ;|
$A0:BE2A 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy Y position] + [$14].[$12] (target position)
$A0:BE2C BD 7E 0F    LDA $0F7E,x            ;|
$A0:BE2F 65 14       ADC $14    [$7E:0014]  ;|
$A0:BE31 85 18       STA $18    [$7E:0018]  ;/
$A0:BE33 18          CLC                    ;\
$A0:BE34 7D 84 0F    ADC $0F84,x            ;} $22 = [$18] + [enemy Y radius] - 1 (target front boundary)
$A0:BE37 3A          DEC A                  ;/
$A0:BE38 80 13       BRA $13    [$BE4D]

$A0:BE3A BD 80 0F    LDA $0F80,x            ;\ Else ([$1C] & 1 = 0):
$A0:BE3D 38          SEC                    ;|
$A0:BE3E E5 12       SBC $12    [$7E:0012]  ;|
$A0:BE40 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy Y position] - [$14].[$12] (target position)
$A0:BE42 BD 7E 0F    LDA $0F7E,x            ;|
$A0:BE45 E5 14       SBC $14    [$7E:0014]  ;|
$A0:BE47 85 18       STA $18    [$7E:0018]  ;/
$A0:BE49 38          SEC                    ;\
$A0:BE4A FD 84 0F    SBC $0F84,x            ;} $22 = [$18] - [enemy Y radius] (target front boundary)

$A0:BE4D 85 22       STA $22    [$7E:0022]
$A0:BE4F 4A          LSR A                  ;\
$A0:BE50 4A          LSR A                  ;|
$A0:BE51 4A          LSR A                  ;|
$A0:BE52 4A          LSR A                  ;|
$A0:BE53 E2 20       SEP #$20               ;|
$A0:BE55 8D 02 42    STA $4202              ;|
$A0:BE58 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BE5B 8D 03 42    STA $4203              ;|
$A0:BE5E C2 20       REP #$20               ;|
$A0:BE60 BD 7A 0F    LDA $0F7A,x            ;|
$A0:BE63 38          SEC                    ;} X = ((enemy front boundary) / 10h * [room width] + (enemy left boundary) / 10h) * 2 (index of leftmost block to check)
$A0:BE64 FD 82 0F    SBC $0F82,x            ;|
$A0:BE67 4A          LSR A                  ;|
$A0:BE68 4A          LSR A                  ;|
$A0:BE69 4A          LSR A                  ;|
$A0:BE6A 4A          LSR A                  ;|
$A0:BE6B 18          CLC                    ;|
$A0:BE6C 6D 16 42    ADC $4216              ;|
$A0:BE6F 0A          ASL A                  ;|
$A0:BE70 AA          TAX                    ;/

; LOOP
$A0:BE71 BF 02 00 7F LDA $7F0002,x          ;\
$A0:BE75 30 14       BMI $14    [$BE8B]     ;} If (block type) < 8:
$A0:BE77 E8          INX                    ;\
$A0:BE78 E8          INX                    ;} X += 2
$A0:BE79 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$A0:BE7B 10 F4       BPL $F4    [$BE71]     ; If [$1A] >= 0: go to LOOP
$A0:BE7D FA          PLX
$A0:BE7E A5 16       LDA $16    [$7E:0016]  ;\
$A0:BE80 9D 80 0F    STA $0F80,x            ;|
$A0:BE83 A5 18       LDA $18    [$7E:0018]  ;} Enemy Y position = (target Y position)
$A0:BE85 9D 7E 0F    STA $0F7E,x            ;/
$A0:BE88 18          CLC                    ;\
$A0:BE89 AB          PLB                    ;} Return carry clear
$A0:BE8A 6B          RTL                    ;/

$A0:BE8B FA          PLX
$A0:BE8C 9E 80 0F    STZ $0F80,x            ; Enemy Y subposition = 0
$A0:BE8F A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BE91 4A          LSR A                  ;} If [$1C] & 1 = 0: go to BRANCH_MOVING_UP
$A0:BE92 90 14       BCC $14    [$BEA8]     ;/
$A0:BE94 A5 22       LDA $22    [$7E:0022]  ;\
$A0:BE96 29 F0 FF    AND #$FFF0             ;} A = [$22] - [$22] % 10h (target bottom boundary rounded down to top of 16x16 tile)
$A0:BE99 38          SEC                    ;\
$A0:BE9A FD 84 0F    SBC $0F84,x            ;|
$A0:BE9D DD 7E 0F    CMP $0F7E,x            ;} Enemy Y position = min([enemy Y position], [A] - [enemy Y radius])
$A0:BEA0 30 03       BMI $03    [$BEA5]     ;|
$A0:BEA2 9D 7E 0F    STA $0F7E,x            ;/

$A0:BEA5 38          SEC                    ;\
$A0:BEA6 AB          PLB                    ;} Return carry set
$A0:BEA7 6B          RTL                    ;/

; BRANCH_MOVING_UP
$A0:BEA8 A5 22       LDA $22    [$7E:0022]  ;\
$A0:BEAA 09 0F 00    ORA #$000F             ;} A = [$22] - [$22] % 10h + 10h (target top boundary rounded up to bottom of 16x16 tile)
$A0:BEAD 38          SEC                    ;/
$A0:BEAE 7D 84 0F    ADC $0F84,x            ;\
$A0:BEB1 38          SEC                    ;|
$A0:BEB2 DD 7E 0F    CMP $0F7E,x            ;|
$A0:BEB5 F0 02       BEQ $02    [$BEB9]     ;} Enemy Y position = max([enemy Y position], [A] + [enemy Y radius])
$A0:BEB7 10 03       BPL $03    [$BEBC]     ;|
                                            ;|
$A0:BEB9 9D 7E 0F    STA $0F7E,x            ;/

$A0:BEBC 38          SEC                    ;\
$A0:BEBD AB          PLB                    ;} Return carry set
$A0:BEBE 6B          RTL                    ;/
}


;;; $BEBF: Unused. Check for horizontal "solid" block collision ;;;
{
;; Parameters:
;;     A: Direction. 0 = left, 1 = right
;;     X: Enemy index
;;     $14.$12: Distance to check for collision (unsigned)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:BEBF 85 1C       STA $1C    [$7E:001C]  ; $1C = [A]
$A0:BEC1 8B          PHB
$A0:BEC2 E2 20       SEP #$20               ;\
$A0:BEC4 A9 A0       LDA #$A0               ;|
$A0:BEC6 48          PHA                    ;} DB = $A0
$A0:BEC7 AB          PLB                    ;|
$A0:BEC8 C2 30       REP #$30               ;/
$A0:BECA DA          PHX
$A0:BECB BD 7E 0F    LDA $0F7E,x            ;\
$A0:BECE 38          SEC                    ;|
$A0:BECF FD 84 0F    SBC $0F84,x            ;|
$A0:BED2 29 F0 FF    AND #$FFF0             ;|
$A0:BED5 85 1A       STA $1A    [$7E:001A]  ;|
$A0:BED7 BD 7E 0F    LDA $0F7E,x            ;|
$A0:BEDA 18          CLC                    ;|
$A0:BEDB 7D 84 0F    ADC $0F84,x            ;|
$A0:BEDE 3A          DEC A                  ;} $1A = (enemy bottom boundary) / 10h - (enemy top boundary) / 10h (number of blocks left to check)
$A0:BEDF 38          SEC                    ;|
$A0:BEE0 E5 1A       SBC $1A    [$7E:001A]  ;|
$A0:BEE2 4A          LSR A                  ;|
$A0:BEE3 4A          LSR A                  ;|
$A0:BEE4 4A          LSR A                  ;|
$A0:BEE5 4A          LSR A                  ;|
$A0:BEE6 85 1A       STA $1A    [$7E:001A]  ;/
$A0:BEE8 BD 7E 0F    LDA $0F7E,x            ;\
$A0:BEEB 38          SEC                    ;|
$A0:BEEC FD 84 0F    SBC $0F84,x            ;|
$A0:BEEF 4A          LSR A                  ;|
$A0:BEF0 4A          LSR A                  ;|
$A0:BEF1 4A          LSR A                  ;} Calculate (enemy top boundary) / 10h * [room width in blocks] (target row block index)
$A0:BEF2 4A          LSR A                  ;|
$A0:BEF3 E2 20       SEP #$20               ;|
$A0:BEF5 8D 02 42    STA $4202              ;|
$A0:BEF8 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BEFB 8D 03 42    STA $4203              ;|
$A0:BEFE C2 20       REP #$20               ;/
$A0:BF00 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BF02 4A          LSR A                  ;} If [$1C] & 1 != 0:
$A0:BF03 90 16       BCC $16    [$BF1B]     ;/
$A0:BF05 BD 7C 0F    LDA $0F7C,x            ;\
$A0:BF08 18          CLC                    ;|
$A0:BF09 65 12       ADC $12    [$7E:0012]  ;|
$A0:BF0B 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy X position] + [$14].[$12] (target X position)
$A0:BF0D BD 7A 0F    LDA $0F7A,x            ;|
$A0:BF10 65 14       ADC $14    [$7E:0014]  ;|
$A0:BF12 85 18       STA $18    [$7E:0018]  ;/
$A0:BF14 18          CLC                    ;\
$A0:BF15 7D 82 0F    ADC $0F82,x            ;} $22 = (target right boundary)
$A0:BF18 3A          DEC A                  ;/
$A0:BF19 80 13       BRA $13    [$BF2E]

$A0:BF1B BD 7C 0F    LDA $0F7C,x            ;\ Else ([$1C] & 1 = 0):
$A0:BF1E 38          SEC                    ;|
$A0:BF1F E5 12       SBC $12    [$7E:0012]  ;|
$A0:BF21 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy X position] - [$14].[$12] (target X position)
$A0:BF23 BD 7A 0F    LDA $0F7A,x            ;|
$A0:BF26 E5 14       SBC $14    [$7E:0014]  ;|
$A0:BF28 85 18       STA $18    [$7E:0018]  ;/
$A0:BF2A 38          SEC                    ;\
$A0:BF2B FD 82 0F    SBC $0F82,x            ;} $22 = (target left boundary)

$A0:BF2E 85 22       STA $22    [$7E:0022]
$A0:BF30 4A          LSR A                  ;\
$A0:BF31 4A          LSR A                  ;|
$A0:BF32 4A          LSR A                  ;|
$A0:BF33 4A          LSR A                  ;|
$A0:BF34 18          CLC                    ;} X = ((target row block index) + [$22] / 10h) * 2 (index of top block to check)
$A0:BF35 6D 16 42    ADC $4216              ;|
$A0:BF38 0A          ASL A                  ;|
$A0:BF39 AA          TAX                    ;/

; LOOP
$A0:BF3A BF 02 00 7F LDA $7F0002,x          ;\
$A0:BF3E 30 11       BMI $11    [$BF51]     ;} If (block type) < 8:
$A0:BF40 8A          TXA                    ;\
$A0:BF41 18          CLC                    ;|
$A0:BF42 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$A0:BF45 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$A0:BF48 AA          TAX                    ;/
$A0:BF49 C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$A0:BF4B 10 ED       BPL $ED    [$BF3A]     ; If [$1A] >= 0: go to LOOP
$A0:BF4D FA          PLX
$A0:BF4E 18          CLC                    ;\
$A0:BF4F AB          PLB                    ;} Return carry clear
$A0:BF50 6B          RTL                    ;/

$A0:BF51 FA          PLX
$A0:BF52 64 12       STZ $12    [$7E:0012]
$A0:BF54 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BF56 4A          LSR A                  ;} If [$1C] & 1 = 0: go to BRANCH_MOVING_LEFT
$A0:BF57 90 16       BCC $16    [$BF6F]     ;/
$A0:BF59 A5 22       LDA $22    [$7E:0022]  ;\
$A0:BF5B 29 F0 FF    AND #$FFF0             ;} A = [$22] - [$22] % 10h (target right boundary rounded down to left of 16x16 tile)
$A0:BF5E 38          SEC                    ;\
$A0:BF5F FD 82 0F    SBC $0F82,x            ;|
$A0:BF62 FD 7A 0F    SBC $0F7A,x            ;|
$A0:BF65 10 03       BPL $03    [$BF6A]     ;} $14 = max(0, [A] - [enemy X radius] - [enemy X position])
$A0:BF67 A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:BF6A 85 14       STA $14    [$7E:0014]  ;/
$A0:BF6C 38          SEC                    ;\
$A0:BF6D AB          PLB                    ;} Return carry set
$A0:BF6E 6B          RTL                    ;/

; BRANCH_MOVING_LEFT
$A0:BF6F A5 22       LDA $22    [$7E:0022]  ;\
$A0:BF71 09 0F 00    ORA #$000F             ;} A = [$22] - [$22] % 10h + 10h (target left boundary rounded up to right of 16x16 tile)
$A0:BF74 38          SEC                    ;/
$A0:BF75 7D 82 0F    ADC $0F82,x            ;\
$A0:BF78 38          SEC                    ;|
$A0:BF79 FD 7A 0F    SBC $0F7A,x            ;|
$A0:BF7C 30 03       BMI $03    [$BF81]     ;|
$A0:BF7E A9 00 00    LDA #$0000             ;} $14 = -max(0, [A] + [enemy X radius] - [enemy X position])
                                            ;|
$A0:BF81 49 FF FF    EOR #$FFFF             ;|
$A0:BF84 1A          INC A                  ;|
$A0:BF85 85 14       STA $14    [$7E:0014]  ;/
$A0:BF87 38          SEC                    ;\
$A0:BF88 AB          PLB                    ;} Return carry set
$A0:BF89 6B          RTL                    ;/
}


;;; $BF8A: Check for vertical "solid" block collision ;;;
{
;; Parameters:
;;     A: Bit 0 = direction. Clear = up, set = down
;;     X: Enemy index
;;     $14.$12: Distance to check for collision (unsigned)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; Used by skree/metaree. Only used for downwards direction

$A0:BF8A 85 1C       STA $1C    [$7E:001C]  ; $1C = [A]
$A0:BF8C 8B          PHB                    ;\
$A0:BF8D E2 20       SEP #$20               ;|
$A0:BF8F A9 A0       LDA #$A0               ;} DB = $A0
$A0:BF91 48          PHA                    ;|
$A0:BF92 AB          PLB                    ;/
$A0:BF93 C2 30       REP #$30
$A0:BF95 DA          PHX
$A0:BF96 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A0:BF99 38          SEC                    ;|
$A0:BF9A FD 82 0F    SBC $0F82,x[$7E:1002]  ;|
$A0:BF9D 29 F0 FF    AND #$FFF0             ;|
$A0:BFA0 85 1A       STA $1A    [$7E:001A]  ;|
$A0:BFA2 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$A0:BFA5 18          CLC                    ;|
$A0:BFA6 7D 82 0F    ADC $0F82,x[$7E:1002]  ;|
$A0:BFA9 3A          DEC A                  ;} $1A = (enemy right boundary) / 10h - (enemy left boundary) / 10h (number of blocks left to check)
$A0:BFAA 38          SEC                    ;|
$A0:BFAB E5 1A       SBC $1A    [$7E:001A]  ;|
$A0:BFAD 4A          LSR A                  ;|
$A0:BFAE 4A          LSR A                  ;|
$A0:BFAF 4A          LSR A                  ;|
$A0:BFB0 4A          LSR A                  ;|
$A0:BFB1 85 1A       STA $1A    [$7E:001A]  ;/
$A0:BFB3 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:BFB5 4A          LSR A                  ;} If [$1C] & 1 != 0:
$A0:BFB6 90 16       BCC $16    [$BFCE]     ;/
$A0:BFB8 BD 80 0F    LDA $0F80,x[$7E:1000]  ;\
$A0:BFBB 18          CLC                    ;|
$A0:BFBC 65 12       ADC $12    [$7E:0012]  ;|
$A0:BFBE 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy Y position] + [$14].[$12] (target position)
$A0:BFC0 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$A0:BFC3 65 14       ADC $14    [$7E:0014]  ;|
$A0:BFC5 85 18       STA $18    [$7E:0018]  ;/
$A0:BFC7 18          CLC                    ;\
$A0:BFC8 7D 84 0F    ADC $0F84,x[$7E:1004]  ;} $22 = [$18] + [enemy Y radius] - 1 (target front boundary)
$A0:BFCB 3A          DEC A                  ;/
$A0:BFCC 80 13       BRA $13    [$BFE1]

$A0:BFCE BD 80 0F    LDA $0F80,x            ;\ Else ([$1C] & 1 = 0):
$A0:BFD1 38          SEC                    ;|
$A0:BFD2 E5 12       SBC $12    [$7E:0012]  ;|
$A0:BFD4 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy Y position] - [$14].[$12] (target position)
$A0:BFD6 BD 7E 0F    LDA $0F7E,x            ;|
$A0:BFD9 E5 14       SBC $14    [$7E:0014]  ;|
$A0:BFDB 85 18       STA $18    [$7E:0018]  ;/
$A0:BFDD 38          SEC                    ;\
$A0:BFDE FD 84 0F    SBC $0F84,x            ;} $22 = [$18] - [enemy Y radius] (target front boundary)

$A0:BFE1 85 22       STA $22    [$7E:0022]
$A0:BFE3 4A          LSR A                  ;\
$A0:BFE4 4A          LSR A                  ;|
$A0:BFE5 4A          LSR A                  ;|
$A0:BFE6 4A          LSR A                  ;|
$A0:BFE7 E2 20       SEP #$20               ;|
$A0:BFE9 8D 02 42    STA $4202              ;|
$A0:BFEC AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:BFEF 8D 03 42    STA $4203              ;|
$A0:BFF2 C2 20       REP #$20               ;|
$A0:BFF4 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$A0:BFF7 38          SEC                    ;} X = ((enemy front boundary) / 10h * [room width] + (enemy left boundary) / 10h) * 2 (index of leftmost block to check)
$A0:BFF8 FD 82 0F    SBC $0F82,x[$7E:1002]  ;|
$A0:BFFB 4A          LSR A                  ;|
$A0:BFFC 4A          LSR A                  ;|
$A0:BFFD 4A          LSR A                  ;|
$A0:BFFE 4A          LSR A                  ;|
$A0:BFFF 18          CLC                    ;|
$A0:C000 6D 16 42    ADC $4216              ;|
$A0:C003 0A          ASL A                  ;|
$A0:C004 AA          TAX                    ;/

; LOOP
$A0:C005 BF 02 00 7F LDA $7F0002,x[$7F:0DFC];\
$A0:C009 30 0A       BMI $0A    [$C015]     ;} If (block type) < 8:
$A0:C00B E8          INX                    ;\
$A0:C00C E8          INX                    ;} X += 2
$A0:C00D C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$A0:C00F 10 F4       BPL $F4    [$C005]     ; If [$1A] >= 0: go to LOOP
$A0:C011 FA          PLX
$A0:C012 18          CLC                    ;\
$A0:C013 AB          PLB                    ;} Return carry clear
$A0:C014 6B          RTL                    ;/

$A0:C015 FA          PLX
$A0:C016 64 12       STZ $12    [$7E:0012]
$A0:C018 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:C01A 4A          LSR A                  ;} If [$1C] & 1 = 0: go to BRANCH_MOVING_UP
$A0:C01B 90 16       BCC $16    [$C033]     ;/
$A0:C01D A5 22       LDA $22    [$7E:0022]  ;\
$A0:C01F 29 F0 FF    AND #$FFF0             ;} A = [$22] - [$22] % 10h (target bottom boundary rounded down to top of 16x16 tile)
$A0:C022 38          SEC                    ;\
$A0:C023 FD 84 0F    SBC $0F84,x[$7E:1004]  ;|
$A0:C026 FD 7E 0F    SBC $0F7E,x[$7E:0FFE]  ;|
$A0:C029 10 03       BPL $03    [$C02E]     ;} $14 = max(0, [A] - [enemy Y radius] - [enemy Y position])
$A0:C02B A9 00 00    LDA #$0000             ;|
                                            ;|
$A0:C02E 85 14       STA $14    [$7E:0014]  ;/
$A0:C030 38          SEC                    ;\
$A0:C031 AB          PLB                    ;} Return carry set
$A0:C032 6B          RTL                    ;/

; BRANCH_MOVING_UP
$A0:C033 A5 22       LDA $22    [$7E:0022]  ;\
$A0:C035 09 0F 00    ORA #$000F             ;} A = [$22] - [$22] % 10h + 10h (target top boundary rounded up to bottom of 16x16 tile)
$A0:C038 38          SEC                    ;/
$A0:C039 7D 84 0F    ADC $0F84,x            ;\
$A0:C03C 38          SEC                    ;|
$A0:C03D FD 7E 0F    SBC $0F7E,x            ;|
$A0:C040 30 03       BMI $03    [$C045]     ;|
$A0:C042 A9 00 00    LDA #$0000             ;} $14 = -max(0, [A] + [enemy Y radius] - [enemy Y position])
                                            ;|
$A0:C045 49 FF FF    EOR #$FFFF             ;|
$A0:C048 1A          INC A                  ;|
$A0:C049 85 14       STA $14    [$7E:0014]  ;/
$A0:C04B 38          SEC                    ;\
$A0:C04C AB          PLB                    ;} Return carry set
$A0:C04D 6B          RTL                    ;/
}
}


;;; $C04E..C18D: Calculate angle ;;;
{
;;; $C04E: Calculate angle of Samus from enemy projectile ;;;
{
;; Parameters:
;;     X: Origin enemy projectile index
;; Returns:
;;     A: The angle between the line from the enemy projectile to Samus and the negative y axis in 100h / (2 pi) radians

; Graphically:
;           0
;           |
;     C0h   #   40h
;
;          80h
;
; Where # is the origin enemy projectile and | is the negative y axis

; Assumes Samus and enemy are with FFh pixels of each other in both dimensions
; Used by Golden Torizo super missile

$A0:C04E 08          PHP
$A0:C04F C2 30       REP #$30
$A0:C051 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A0:C054 38          SEC
$A0:C055 FD 4B 1A    SBC $1A4B,x
$A0:C058 85 12       STA $12    [$7E:0012]
$A0:C05A AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A0:C05D 38          SEC
$A0:C05E FD 93 1A    SBC $1A93,x
$A0:C061 85 14       STA $14    [$7E:0014]
$A0:C063 4C B1 C0    JMP $C0B1  [$A0:C0B1]
}


;;; $C066: Calculate angle of Samus from enemy ;;;
{
;; Parameters:
;;     X: Origin enemy index
;; Returns:
;;     A: The angle between the line from the enemy to Samus and the negative y axis in 100h / (2 pi) radians

; Graphically:
;           0
;           |
;     C0h   #   40h
;
;          80h
;
; Where # is the origin enemy and | is the negative y axis

; Assumes Samus and enemy are with FFh pixels of each other in both dimensions

$A0:C066 08          PHP
$A0:C067 C2 30       REP #$30
$A0:C069 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A0:C06C 38          SEC
$A0:C06D FD 7A 0F    SBC $0F7A,x[$7E:0FBA]
$A0:C070 85 12       STA $12    [$7E:0012]
$A0:C072 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A0:C075 38          SEC
$A0:C076 FD 7E 0F    SBC $0F7E,x[$7E:0FBE]
$A0:C079 85 14       STA $14    [$7E:0014]
$A0:C07B 4C B1 C0    JMP $C0B1  [$A0:C0B1]
}


;;; $C07E: Unused. Calculate angle of enemy [Y] from enemy [X] ;;;
{
;; Parameters:
;;     X: Origin enemy index
;;     Y: Target enemy index
;; Returns:
;;     A: The angle between the line from enemy [X] to enemy [Y] and the negative y axis in 100h / (2 pi) radians

; Graphically:
;           0
;           |
;     C0h   #   40h
;
;          80h
;
; Where # is the origin enemy and | is the negative y axis
$A0:C07E 08          PHP
$A0:C07F C2 30       REP #$30
$A0:C081 B9 7A 0F    LDA $0F7A,y
$A0:C084 38          SEC
$A0:C085 FD 7A 0F    SBC $0F7A,x
$A0:C088 85 12       STA $12    [$7E:0012]
$A0:C08A B9 7E 0F    LDA $0F7E,y
$A0:C08D 38          SEC
$A0:C08E FD 7E 0F    SBC $0F7E,x
$A0:C091 85 14       STA $14    [$7E:0014]
$A0:C093 4C B1 C0    JMP $C0B1  [$A0:C0B1]
}


;;; $C096: Calculate angle of enemy [X] from enemy [Y] ;;;
{
;; Parameters:
;;     X: Target enemy index
;;     Y: Origin enemy index
;; Returns:
;;     A: The angle between the line from enemy [Y] to enemy [X] and the negative y axis in 100h / (2 pi) radians

; Graphically:
;           0
;           |
;     C0h   #   40h
;
;          80h
;
; Where # is the origin enemy and | is the negative y axis

; Assumes enemies are with FFh pixels of each other in both dimensions

; Used by shaktool

$A0:C096 08          PHP
$A0:C097 C2 30       REP #$30
$A0:C099 BD 7A 0F    LDA $0F7A,x[$7E:10FA]
$A0:C09C 38          SEC
$A0:C09D F9 7A 0F    SBC $0F7A,y[$7E:0F7A]
$A0:C0A0 85 12       STA $12    [$7E:0012]
$A0:C0A2 BD 7E 0F    LDA $0F7E,x[$7E:10FE]
$A0:C0A5 38          SEC
$A0:C0A6 F9 7E 0F    SBC $0F7E,y[$7E:0F7E]
$A0:C0A9 85 14       STA $14    [$7E:0014]
$A0:C0AB 4C B1 C0    JMP $C0B1  [$A0:C0B1]
}


;;; $C0AE: Calculate angle of ([$12], [$14]) offset ;;;
{
;; Parameters:
;;     $12: X offset
;;     $14: Y offset
;; Returns:
;;     A: The angle between the line from (0, 0) to (x, y) and the negative y axis in 100h / (2 pi) radians

; Graphically:
;           0
;           |
;     C0h   #   40h
;
;          80h
;
; Where # is the origin and | is the negative y axis

; Assumes -FFh <= x,y <= FFh

$A0:C0AE 08          PHP
$A0:C0AF C2 30       REP #$30
}


;;; $C0B1: Calculate angle of (x, y) offset ;;;
{
;; Parameters:
;;     $12: X offset
;;     $14: Y offset
;; Returns:
;;     A: The angle between the line from (0, 0) to (x, y) and the negative y axis in 100h / (2 pi) radians

; Graphically:
;           0
;           |
;     C0h   #   40h
;
;          80h
;
; Where # is the origin and | is the negative y axis

; Assumes PSR has been pushed
; Assumes -FFh <= x,y <= FFh

; Determines the result octant from the signs of the parameter co-ordinates,
; then approximates the inverse tangent within the octant as:
;     100h/(2 pi) arctan(z) ~= 32 z
; Which is approximating the taylor series around zero up to the second order:
;     100h/(2 pi) arctan(z) ~= 40.7 z
$A0:C0B1 DA          PHX
$A0:C0B2 A2 00 00    LDX #$0000             ; X = 0
$A0:C0B5 A5 12       LDA $12    [$7E:0012]  ;\
$A0:C0B7 10 07       BPL $07    [$C0C0]     ;} If [$12] < 0:
$A0:C0B9 A2 04 00    LDX #$0004             ; X = 4
$A0:C0BC 49 FF FF    EOR #$FFFF             ;\
$A0:C0BF 1A          INC A                  ;} $12 = -[$12]

$A0:C0C0 85 12       STA $12    [$7E:0012]
$A0:C0C2 A5 14       LDA $14    [$7E:0014]  ;\
$A0:C0C4 10 06       BPL $06    [$C0CC]     ;} If [$14] < 0:
$A0:C0C6 E8          INX                    ;\
$A0:C0C7 E8          INX                    ;} X += 2
$A0:C0C8 49 FF FF    EOR #$FFFF             ;\
$A0:C0CB 1A          INC A                  ;} $14 = -[$14]

$A0:C0CC 85 14       STA $14    [$7E:0014]
$A0:C0CE C5 12       CMP $12    [$7E:0012]  ;\
$A0:C0D0 90 20       BCC $20    [$C0F2]     ;} If [$14] < [$12]: go to BRANCH_LOWER_OCTANT
$A0:C0D2 E2 20       SEP #$20               ;\
$A0:C0D4 9C 04 42    STZ $4204              ;|
$A0:C0D7 A5 12       LDA $12    [$7E:0012]  ;|
$A0:C0D9 8D 05 42    STA $4205              ;|
$A0:C0DC A5 14       LDA $14    [$7E:0014]  ;} Quotient = [$12] * 100h / [$14]
$A0:C0DE 8D 06 42    STA $4206              ;|
$A0:C0E1 EA          NOP                    ;|
$A0:C0E2 C2 20       REP #$20               ;/
$A0:C0E4 FC EA C0    JSR ($C0EA,x)[$A0:C120]; Execute [$C0EA + [X]]
$A0:C0E7 FA          PLX
$A0:C0E8 28          PLP
$A0:C0E9 6B          RTL                    ; Return

$A0:C0EA             dw C120, C132, C14E, C17C

; BRANCH_LOWER_OCTANT
$A0:C0F2 E2 20       SEP #$20               ;\
$A0:C0F4 9C 04 42    STZ $4204              ;|
$A0:C0F7 A5 14       LDA $14    [$7E:0014]  ;|
$A0:C0F9 8D 05 42    STA $4205              ;|
$A0:C0FC A5 12       LDA $12    [$7E:0012]  ;} Quotient = [$14] * 100h / [$12]
$A0:C0FE 8D 06 42    STA $4206              ;|
$A0:C101 EA          NOP                    ;|
$A0:C102 C2 20       REP #$20               ;/
$A0:C104 FC 0A C1    JSR ($C10A,x)[$A0:C112]; Execute [$C10A + [X]]
$A0:C107 FA          PLX
$A0:C108 28          PLP
$A0:C109 6B          RTL

$A0:C10A             dw C112, C13C, C15C, C16E
}


;;; $C112: Calculate angle of (x, y) offset - bottom right upper octant ;;;
{
; A = 40h + quotient / 8
$A0:C112 AD 14 42    LDA $4214
$A0:C115 4A          LSR A
$A0:C116 4A          LSR A
$A0:C117 4A          LSR A
$A0:C118 18          CLC
$A0:C119 69 40 00    ADC #$0040
$A0:C11C 29 FF 00    AND #$00FF
$A0:C11F 60          RTS
}


;;; $C120: Calculate angle of (x, y) offset - bottom right lower octant ;;;
{
; A = 80h - quotient / 8
$A0:C120 AD 14 42    LDA $4214
$A0:C123 4A          LSR A
$A0:C124 4A          LSR A
$A0:C125 4A          LSR A
$A0:C126 85 12       STA $12    [$7E:0012]
$A0:C128 A9 80 00    LDA #$0080
$A0:C12B 38          SEC
$A0:C12C E5 12       SBC $12    [$7E:0012]
$A0:C12E 29 FF 00    AND #$00FF
$A0:C131 60          RTS
}


;;; $C132: Calculate angle of (x, y) offset - top right upper octant ;;;
{
; A = quotient / 8
$A0:C132 AD 14 42    LDA $4214
$A0:C135 4A          LSR A
$A0:C136 4A          LSR A
$A0:C137 4A          LSR A
$A0:C138 29 FF 00    AND #$00FF
$A0:C13B 60          RTS
}


;;; $C13C: Calculate angle of (x, y) offset - top right lower octant ;;;
{
; A = 40h - quotient / 8
$A0:C13C AD 14 42    LDA $4214
$A0:C13F 4A          LSR A
$A0:C140 4A          LSR A
$A0:C141 4A          LSR A
$A0:C142 85 12       STA $12    [$7E:0012]
$A0:C144 A9 40 00    LDA #$0040
$A0:C147 38          SEC
$A0:C148 E5 12       SBC $12    [$7E:0012]
$A0:C14A 29 FF 00    AND #$00FF
$A0:C14D 60          RTS
}


;;; $C14E: Calculate angle of (x, y) offset - bottom left lower octant ;;;
{
; A = 80h + quotient / 8
$A0:C14E AD 14 42    LDA $4214
$A0:C151 4A          LSR A
$A0:C152 4A          LSR A
$A0:C153 4A          LSR A
$A0:C154 18          CLC
$A0:C155 69 80 00    ADC #$0080
$A0:C158 29 FF 00    AND #$00FF
$A0:C15B 60          RTS
}


;;; $C15C: Calculate angle of (x, y) offset - bottom left upper octant ;;;
{
; A = C0h - quotient / 8
$A0:C15C AD 14 42    LDA $4214
$A0:C15F 4A          LSR A
$A0:C160 4A          LSR A
$A0:C161 4A          LSR A
$A0:C162 85 12       STA $12    [$7E:0012]
$A0:C164 A9 C0 00    LDA #$00C0
$A0:C167 38          SEC
$A0:C168 E5 12       SBC $12    [$7E:0012]
$A0:C16A 29 FF 00    AND #$00FF
$A0:C16D 60          RTS
}


;;; $C16E: Calculate angle of (x, y) offset - top left lower octant ;;;
{
; A = C0h + quotient / 8
$A0:C16E AD 14 42    LDA $4214
$A0:C171 4A          LSR A
$A0:C172 4A          LSR A
$A0:C173 4A          LSR A
$A0:C174 18          CLC
$A0:C175 69 C0 00    ADC #$00C0
$A0:C178 29 FF 00    AND #$00FF
$A0:C17B 60          RTS
}


;;; $C17C: Calculate angle of (x, y) offset - top left upper octant ;;;
{
; A = 100h - quotient / 8
$A0:C17C AD 14 42    LDA $4214
$A0:C17F 4A          LSR A
$A0:C180 4A          LSR A
$A0:C181 4A          LSR A
$A0:C182 85 12       STA $12    [$7E:0012]
$A0:C184 A9 00 01    LDA #$0100
$A0:C187 38          SEC
$A0:C188 E5 12       SBC $12    [$7E:0012]
$A0:C18A 29 FF 00    AND #$00FF
$A0:C18D 60          RTS
}
}


;;; $C18E: Check if enemy is horizontally off-screen ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     A/carry: Set if off-screen, clear otherwise
$A0:C18E BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$A0:C191 30 19       BMI $19    [$C1AC]     ;} If [enemy X position] >= 0:
$A0:C193 18          CLC                    ;\
$A0:C194 7D 82 0F    ADC $0F82,x[$7E:11C2]  ;|
$A0:C197 38          SEC                    ;} If [enemy X position] + [enemy X radius] >= [layer 1 X position]:
$A0:C198 ED 11 09    SBC $0911  [$7E:0911]  ;|
$A0:C19B 30 0F       BMI $0F    [$C1AC]     ;/
$A0:C19D 38          SEC                    ;\
$A0:C19E E9 00 01    SBC #$0100             ;|
$A0:C1A1 38          SEC                    ;} If [enemy X position] < [layer 1 X position] + 100h:
$A0:C1A2 FD 82 0F    SBC $0F82,x[$7E:11C2]  ;|
$A0:C1A5 10 05       BPL $05    [$C1AC]     ;/
$A0:C1A7 A9 00 00    LDA #$0000             ; A = 0
$A0:C1AA 18          CLC                    ;\
$A0:C1AB 6B          RTL                    ;} Return carry clear

$A0:C1AC A9 01 00    LDA #$0001             ; A = 1
$A0:C1AF 38          SEC                    ;\
$A0:C1B0 6B          RTL                    ;} Return carry set
}


;;; $C1B1: Unused. Check if enemy is vertically off-screen ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     A/carry: Set if off-screen, clear otherwise
$A0:C1B1 BD 7E 0F    LDA $0F7E,x            ;\
$A0:C1B4 30 19       BMI $19    [$C1CF]     ;} If [enemy Y position] >= 0:
$A0:C1B6 18          CLC                    ;\
$A0:C1B7 7D 84 0F    ADC $0F84,x            ;|
$A0:C1BA 38          SEC                    ;} If [enemy Y position] + [enemy Y radius] >= [layer 1 Y position]:
$A0:C1BB ED 15 09    SBC $0915  [$7E:0915]  ;|
$A0:C1BE 30 0F       BMI $0F    [$C1CF]     ;/
$A0:C1C0 38          SEC                    ;\
$A0:C1C1 E9 00 01    SBC #$0100             ;|
$A0:C1C4 38          SEC                    ;} If [enemy Y position] < [layer 1 Y position] + 100h:
$A0:C1C5 FD 84 0F    SBC $0F84,x            ;|
$A0:C1C8 10 05       BPL $05    [$C1CF]     ;/
$A0:C1CA A9 00 00    LDA #$0000             ; A = 0
$A0:C1CD 18          CLC                    ;\
$A0:C1CE 6B          RTL                    ;} Return carry clear

$A0:C1CF A9 01 00    LDA #$0001             ; A = 1
$A0:C1D2 38          SEC                    ;\
$A0:C1D3 6B          RTL                    ;} Return carry set
}


;;; $C1D4: Unused. Assess Samus threat level ;;;
{
;; Returns:
;;     $12: Threat level. Range 0..5

; ?

$A0:C1D4 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$A0:C1D7 8D 04 42    STA $4204              ;|
$A0:C1DA E2 20       SEP #$20               ;|
$A0:C1DC A9 03       LDA #$03               ;|
$A0:C1DE 8D 06 42    STA $4206              ;|
$A0:C1E1 C2 20       REP #$20               ;|
$A0:C1E3 EA          NOP                    ;|
$A0:C1E4 EA          NOP                    ;|
$A0:C1E5 EA          NOP                    ;|
$A0:C1E6 AD 14 42    LDA $4214              ;|
$A0:C1E9 CD C2 09    CMP $09C2  [$7E:09C2]  ;|
$A0:C1EC 90 05       BCC $05    [$C1F3]     ;|
$A0:C1EE A9 01 00    LDA #$0001             ;} $12 = ([Samus health] * 3 - 1) / [Samus max health] + 1 (roughly the number of thirds of Samus health she has)
$A0:C1F1 80 0E       BRA $0E    [$C201]     ;|
                                            ;|
$A0:C1F3 0A          ASL A                  ;|
$A0:C1F4 CD C2 09    CMP $09C2  [$7E:09C2]  ;|
$A0:C1F7 90 05       BCC $05    [$C1FE]     ;|
$A0:C1F9 A9 02 00    LDA #$0002             ;|
$A0:C1FC 80 03       BRA $03    [$C201]     ;|
                                            ;|
$A0:C1FE A9 03 00    LDA #$0003             ;|
                                            ;|
$A0:C201 85 12       STA $12    [$7E:0012]  ;/
$A0:C203 AD A8 09    LDA $09A8  [$7E:09A8]  ;\
$A0:C206 29 0F 00    AND #$000F             ;|
$A0:C209 49 FF FF    EOR #$FFFF             ;} $16 = ~([collected beams] & Fh)
$A0:C20C 85 16       STA $16    [$7E:0016]  ;/
$A0:C20E AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$A0:C211 49 FF FF    EOR #$FFFF             ;} $18 = ~[collected items]
$A0:C214 85 18       STA $18    [$7E:0018]  ;/
$A0:C216 A9 00 00    LDA #$0000             ; A = 0
$A0:C219 46 16       LSR $16    [$7E:0016]  ;\
$A0:C21B B0 03       BCS $03    [$C220]     ;} If wave beam collected:
$A0:C21D 69 02 00    ADC #$0002             ; A += 2

$A0:C220 46 16       LSR $16    [$7E:0016]  ;\
$A0:C222 B0 03       BCS $03    [$C227]     ;} If ice beam collected:
$A0:C224 69 01 00    ADC #$0001             ; A += 1

$A0:C227 46 16       LSR $16    [$7E:0016]  ;\
$A0:C229 B0 03       BCS $03    [$C22E]     ;} If spazer beam collected:
$A0:C22B 69 03 00    ADC #$0003             ; A += 3

$A0:C22E 46 16       LSR $16    [$7E:0016]  ;\
$A0:C230 B0 03       BCS $03    [$C235]     ;} If plasma beam collected:
$A0:C232 69 03 00    ADC #$0003             ; A += 3

$A0:C235 46 18       LSR $18    [$7E:0018]
$A0:C237 B0 03       BCS $03    [$C23C]
$A0:C239 69 00 00    ADC #$0000

$A0:C23C 46 18       LSR $18    [$7E:0018]
$A0:C23E B0 03       BCS $03    [$C243]
$A0:C240 69 00 00    ADC #$0000

$A0:C243 46 18       LSR $18    [$7E:0018]
$A0:C245 B0 03       BCS $03    [$C24A]
$A0:C247 69 00 00    ADC #$0000

$A0:C24A 46 18       LSR $18    [$7E:0018]  ;\
$A0:C24C B0 03       BCS $03    [$C251]     ;} If screw attack collected:
$A0:C24E 69 03 00    ADC #$0003             ; A += 3

$A0:C251 18          CLC                    ;\
$A0:C252 6D CA 09    ADC $09CA  [$7E:09CA]  ;|
$A0:C255 18          CLC                    ;} $14 = [A] + [Samus super missiles] + [Samus power bombs]
$A0:C256 6D CE 09    ADC $09CE  [$7E:09CE]  ;|
$A0:C259 85 14       STA $14    [$7E:0014]  ;/
$A0:C25B C9 0B 00    CMP #$000B             ;\
$A0:C25E 90 09       BCC $09    [$C269]     ;} If [$14] < 11: return
$A0:C260 E6 12       INC $12    [$7E:0012]  ; Increment $12
$A0:C262 C9 1E 00    CMP #$001E             ;\
$A0:C265 90 02       BCC $02    [$C269]     ;} If [$14] < 30: return
$A0:C267 E6 12       INC $12    [$7E:0012]  ; Increment $12

$A0:C269 6B          RTL
}
}


;;; $C26A: Process enemy instructions ;;;
{
$A0:C26A 8B          PHB
$A0:C26B AE 54 0E    LDX $0E54  [$7E:0E54]
$A0:C26E BD 8A 0F    LDA $0F8A,x[$7E:0F8A]  ;\
$A0:C271 29 04 00    AND #$0004             ;} If enemy is frozen: return
$A0:C274 D0 39       BNE $39    [$C2AF]     ;/
$A0:C276 DE 94 0F    DEC $0F94,x[$7E:0F94]  ; Decrement enemy instruction timer
$A0:C279 D0 36       BNE $36    [$C2B1]     ; If [enemy instruction timer] != 0: go to BRANCH_NO_UPDATE
$A0:C27B BD A5 0F    LDA $0FA5,x[$7E:0FA5]  ;\
$A0:C27E 48          PHA                    ;|
$A0:C27F AB          PLB                    ;} DB = [enemy bank]
$A0:C280 AB          PLB                    ;/
$A0:C281 BC 92 0F    LDY $0F92,x[$7E:0F92]  ; Y = [enemy instruction list pointer]

; LOOP
$A0:C284 B9 00 00    LDA $0000,y[$A6:F610]  ;\
$A0:C287 10 0C       BPL $0C    [$C295]     ;} If [[Y]] & 8000h != 0:
$A0:C289 8D 84 17    STA $1784  [$7E:1784]  ; $1784 = [[Y]]
$A0:C28C C8          INY                    ;\
$A0:C28D C8          INY                    ;} Y += 2
$A0:C28E 4B          PHK                    ;\
$A0:C28F F4 83 C2    PEA $C283              ;} Return to LOOP
$A0:C292 DC 84 17    JML [$1784][$A6:F68B]  ; Go to [$1784]

$A0:C295 9D 94 0F    STA $0F94,x[$7E:0F94]  ; Enemy instruction timer = [[Y]]
$A0:C298 B9 02 00    LDA $0002,y[$A6:F614]  ;\
$A0:C29B 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = [[Y] + 2]
$A0:C29E 98          TYA                    ;\
$A0:C29F 18          CLC                    ;|
$A0:C2A0 69 04 00    ADC #$0004             ;} Enemy instruction list pointer = [Y] + 4
$A0:C2A3 9D 92 0F    STA $0F92,x[$7E:0F92]  ;/
$A0:C2A6 BD 88 0F    LDA $0F88,x[$7E:0F88]  ;\
$A0:C2A9 09 00 80    ORA #$8000             ;} Set enemy graphic updated flag
$A0:C2AC 9D 88 0F    STA $0F88,x[$7E:0F88]  ;/

; Sleep/wait/delete instructions return to here
$A0:C2AF AB          PLB
$A0:C2B0 60          RTS                    ; Return

; BRANCH_NO_UPDATE
$A0:C2B1 BD 88 0F    LDA $0F88,x[$7E:0FC8]  ;\
$A0:C2B4 29 FF 7F    AND #$7FFF             ;} Clear enemy graphic updated flag
$A0:C2B7 9D 88 0F    STA $0F88,x[$7E:0FC8]  ;/
$A0:C2BA AB          PLB
$A0:C2BB 60          RTS
}


;;; $C2BC..C9BE: Enemy block collision handling ;;;
{
;;; $C2BC: Clear carry ;;;
{
$A0:C2BC 18          CLC
$A0:C2BD 60          RTS
}


;;; $C2BE: Set carry ;;;
{
$A0:C2BE 38          SEC
$A0:C2BF 60          RTS
}


;;; $C2C0: Enemy block collision reaction - spike ;;;
{
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A0:C2C0 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C2C3 BF 02 64 7F LDA $7F6402,x[$7F:65E4];|
$A0:C2C7 29 7F 00    AND #$007F             ;|
$A0:C2CA 0A          ASL A                  ;} A = [$A0:C2DA + ([block BTS] & 7Fh) * 2]
$A0:C2CB AA          TAX                    ;|
$A0:C2CC BF DA C2 A0 LDA $A0C2DA,x[$A0:C2DA];/
$A0:C2D0 F0 06       BEQ $06    [$C2D8]     ; If [A] = 0: return carry set
$A0:C2D2 22 E7 84 84 JSL $8484E7[$84:84E7]  ; Spawn PLM [A]
$A0:C2D6 18          CLC                    ;\
$A0:C2D7 60          RTS                    ;} Return carry clear

$A0:C2D8 38          SEC
$A0:C2D9 60          RTS

$A0:C2DA             dw 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, D094
}


;;; $C2FA: Enemy block collision reaction - horizontal - slope ;;;
{
;; Parameters:
;;     $14.$12: Distance to check for collision
;;     $1A: Target boundary position (left/right)
;;     $1C: Number of blocks left to check (0 if final (bottom) block)
;;     $1E: Enemy Y block span
;;     $20: In non-square slope collision:
;;         8000h: Process slopes
;;         4000h: Treat slopes as walls
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $14.$12: If carry clear, adjusted distance to move Samus
$A0:C2FA AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C2FD BF 02 64 7F LDA $7F6402,x[$7F:6A6C];|
$A0:C301 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5:
$A0:C304 C9 05 00    CMP #$0005             ;|
$A0:C307 B0 03       BCS $03    [$C30C]     ;/
$A0:C309 4C 2E C3    JMP $C32E  [$A0:C32E]  ; Go to enemy block collision reaction - horizontal - slope - square

$A0:C30C BF 02 64 7F LDA $7F6402,x[$7F:6A6C];\
$A0:C310 29 FF 00    AND #$00FF             ;} Current slope BTS = [block BTS]
$A0:C313 8D 77 1E    STA $1E77  [$7E:1E77]  ;/
$A0:C316 4C 49 C4    JMP $C449  [$A0:C449]  ; Go to enemy block collision reaction - horizontal - slope - non-square
}


;;; $C319: Enemy block collision reaction - vertical - slope ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $18: Target Y position
;;     $1A: Target boundary position (top/bottom)
;;     $1C: Number of blocks left to check (0 if final (rightmost) block)
;;     $1E: Enemy X block span
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A0:C319 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C31C BF 02 64 7F LDA $7F6402,x[$7F:65D7];|
$A0:C320 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5:
$A0:C323 C9 05 00    CMP #$0005             ;|
$A0:C326 B0 03       BCS $03    [$C32B]     ;/
$A0:C328 4C B2 C3    JMP $C3B2  [$A0:C3B2]  ; Go to enemy block collision reaction - vertical - slope - square

$A0:C32B 4C 1F C5    JMP $C51F  [$A0:C51F]  ; Go to enemy block collision reaction - vertical - slope - non-square
}


;;; $C32E: Enemy block collision reaction - horizontal - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $1A: Target boundary position (left/right)
;;     $1C: Number of blocks left to check (0 if final (bottom) block)
;;     $1E: Enemy Y block span
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A0:C32E 0A          ASL A                  ;\
$A0:C32F 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$A0:C330 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$A0:C333 BF 01 64 7F LDA $7F6401,x[$7F:6BB7];\
$A0:C337 2A          ROL A                  ;|
$A0:C338 2A          ROL A                  ;|
$A0:C339 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$A0:C33A 29 03 00    AND #$0003             ;|
$A0:C33D 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$A0:C340 A5 1A       LDA $1A    [$7E:001A]  ;\
$A0:C342 29 08 00    AND #$0008             ;} A = [$1A] & 8 (is enemy boundary in right half of block)
$A0:C345 4A          LSR A                  ;\
$A0:C346 4A          LSR A                  ;|
$A0:C347 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 3 (toggle X flip flag if enemy is in right half of block)
$A0:C348 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$A0:C34B 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$A0:C34E AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$A0:C34F AC 54 0E    LDY $0E54  [$7E:0E54]  ; Y = [enemy index]
$A0:C352 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:C354 D0 15       BNE $15    [$C36B]     ;} If [$1C] = 0 (bottom block check):
$A0:C356 B9 7E 0F    LDA $0F7E,y[$7E:103E]  ;\
$A0:C359 18          CLC                    ;|
$A0:C35A 79 84 0F    ADC $0F84,y[$7E:1044]  ;|
$A0:C35D 3A          DEC A                  ;} If enemy bottom boundary is in bottom half: go to BRANCH_CHECK_BOTH_HALVES
$A0:C35E 29 08 00    AND #$0008             ;|
$A0:C361 D0 18       BNE $18    [$C37B]     ;/
$A0:C363 BF 34 C4 A0 LDA $A0C434,x[$A0:C442];\
$A0:C367 30 25       BMI $25    [$C38E]     ;} If [$C435 + [X]] & 80h != 0 (top half is solid): go to BRANCH_SOLID
$A0:C369 80 21       BRA $21    [$C38C]     ; Return carry clear

$A0:C36B C5 1E       CMP $1E    [$7E:001E]  ;\
$A0:C36D D0 0C       BNE $0C    [$C37B]     ;} If [$1C] = [$1E] (top block check):
$A0:C36F B9 7E 0F    LDA $0F7E,y[$7E:0FFE]  ;\
$A0:C372 38          SEC                    ;|
$A0:C373 F9 84 0F    SBC $0F84,y[$7E:1004]  ;} If enemy top boundary is in bottom half: go to BRANCH_CHECK_BOTTOM_HALF
$A0:C376 29 08 00    AND #$0008             ;|
$A0:C379 D0 06       BNE $06    [$C381]     ;/

; BRANCH_CHECK_BOTH_HALVES
$A0:C37B BF 34 C4 A0 LDA $A0C434,x[$A0:C442];\
$A0:C37F 30 0D       BMI $0D    [$C38E]     ;} If [$C435 + [X]] & 80h != 0 (top half is solid): go to BRANCH_SOLID

; BRANCH_CHECK_BOTTOM_HALF
$A0:C381 8A          TXA                    ;\
$A0:C382 49 02 00    EOR #$0002             ;|
$A0:C385 AA          TAX                    ;} If [$C435 + ([X] ^ 2)] & 80h != 0 (bottom half is solid): go to BRANCH_SOLID
$A0:C386 BF 34 C4 A0 LDA $A0C434,x[$A0:C440];|
$A0:C38A 30 02       BMI $02    [$C38E]     ;/

$A0:C38C 18          CLC                    ;\
$A0:C38D 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$A0:C38E 38          SEC                    ;\
$A0:C38F 60          RTS                    ;} Return carry set

; Looks like code that was RTS'd out from a time where these collision reaction set the enemy position directly (now moved to $A0:C744)
$A0:C390 BB          TYX
$A0:C391 9E 7C 0F    STZ $0F7C,x            ; Enemy X subposition = 0
$A0:C394 A5 1A       LDA $1A    [$7E:001A]
$A0:C396 24 14       BIT $14    [$7E:0014]  ;\
$A0:C398 30 0C       BMI $0C    [$C3A6]     ;} If [$14] >= 0:
$A0:C39A 29 F8 FF    AND #$FFF8             ; A = [$1A] - [$1A] % 8 (target right boundary rounded down to left of 8x8 tile)
$A0:C39D 38          SEC                    ;\
$A0:C39E FD 82 0F    SBC $0F82,x            ;} Enemy X position = [A] - [enemy X radius]
$A0:C3A1 9D 7A 0F    STA $0F7A,x            ;/
$A0:C3A4 38          SEC                    ;\
$A0:C3A5 60          RTS                    ;} Return carry set

$A0:C3A6 09 07 00    ORA #$0007             ;\
$A0:C3A9 38          SEC                    ;} A = [$1A] - [$1A] % 8 + 8 (target left boundary rounded up to right of 8x8 tile)
$A0:C3AA 7D 82 0F    ADC $0F82,x            ;\
$A0:C3AD 9D 7A 0F    STA $0F7A,x            ;} Enemy X position = [A] + [enemy X radius]
$A0:C3B0 38          SEC                    ;\
$A0:C3B1 60          RTS                    ;} Return carry set
}


;;; $C3B2: Enemy block collision reaction - vertical - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $1A: Target boundary position (top/bottom)
;;     $1C: Number of blocks left to check (0 if final (rightmost) block)
;;     $1E: Enemy X block span
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A0:C3B2 0A          ASL A                  ;\
$A0:C3B3 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$A0:C3B4 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$A0:C3B7 BF 01 64 7F LDA $7F6401,x[$7F:65D6];\
$A0:C3BB 2A          ROL A                  ;|
$A0:C3BC 2A          ROL A                  ;|
$A0:C3BD 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$A0:C3BE 29 03 00    AND #$0003             ;|
$A0:C3C1 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$A0:C3C4 A5 1A       LDA $1A    [$7E:001A]  ;\
$A0:C3C6 29 08 00    AND #$0008             ;} A = [$1A] & 8 (is target boundary in lower half of block)
$A0:C3C9 4A          LSR A                  ;\
$A0:C3CA 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 2 (toggle Y flip flag if enemy is in lower half of block)
$A0:C3CB 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$A0:C3CE 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$A0:C3D1 AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$A0:C3D2 AC 54 0E    LDY $0E54  [$7E:0E54]  ; Y = [enemy index]
$A0:C3D5 A5 1C       LDA $1C    [$7E:001C]  ;\
$A0:C3D7 D0 15       BNE $15    [$C3EE]     ;} If [$1C] = 0 (rightmost block check):
$A0:C3D9 B9 7A 0F    LDA $0F7A,y[$7E:0FFA]  ;\
$A0:C3DC 18          CLC                    ;|
$A0:C3DD 79 82 0F    ADC $0F82,y[$7E:1002]  ;|
$A0:C3E0 3A          DEC A                  ;} If enemy right boundary is in right half: go to BRANCH_CHECK_BOTH_HALVES
$A0:C3E1 29 08 00    AND #$0008             ;|
$A0:C3E4 D0 18       BNE $18    [$C3FE]     ;/
$A0:C3E6 BF 34 C4 A0 LDA $A0C434,x[$A0:C442];\
$A0:C3EA 30 25       BMI $25    [$C411]     ;} If [$C435 + [X]] & 80h != 0 (left half is solid): go to BRANCH_SOLID
$A0:C3EC 80 21       BRA $21    [$C40F]     ; Return carry clear

$A0:C3EE C5 1E       CMP $1E    [$7E:001E]  ;\
$A0:C3F0 D0 0C       BNE $0C    [$C3FE]     ;} If [$1C] = [$1E] (leftmost block check):
$A0:C3F2 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;\
$A0:C3F5 38          SEC                    ;|
$A0:C3F6 F9 82 0F    SBC $0F82,y[$7E:0F82]  ;} If enemy left boundary is in right half: go to BRANCH_CHECK_RIGHT_HALF
$A0:C3F9 29 08 00    AND #$0008             ;|
$A0:C3FC D0 06       BNE $06    [$C404]     ;/

; BRANCH_CHECK_BOTH_HALVES
$A0:C3FE BF 34 C4 A0 LDA $A0C434,x[$A0:C436];\
$A0:C402 30 0D       BMI $0D    [$C411]     ;} If [$C435 + [X]] & 80h != 0 (left half is solid): go to BRANCH_SOLID

; BRANCH_CHECK_RIGHT_HALF
$A0:C404 8A          TXA                    ;\
$A0:C405 49 01 00    EOR #$0001             ;|
$A0:C408 AA          TAX                    ;} If [$C435 + ([X] ^ 1)] & 80h != 0 (right half is solid): go to BRANCH_SOLID
$A0:C409 BF 34 C4 A0 LDA $A0C434,x[$A0:C43F];|
$A0:C40D 30 02       BMI $02    [$C411]     ;/

$A0:C40F 18          CLC                    ;\
$A0:C410 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$A0:C411 38          SEC                    ;\
$A0:C412 60          RTS                    ;} Return carry set

; Looks like code that was RTS'd out. Without this code, enemies don't align with slopes when the collide with them,
; e.g. an enemy falling at 5px/frame can "land" 4px above a half-height slope
$A0:C413 BB          TYX
$A0:C414 9E 80 0F    STZ $0F80,x            ; Enemy Y subposition = 0
$A0:C417 A5 1A       LDA $1A    [$7E:001A]
$A0:C419 24 14       BIT $14    [$7E:0014]  ;\
$A0:C41B 30 0C       BMI $0C    [$C429]     ;} If [$14] >= 0:
$A0:C41D 29 F8 FF    AND #$FFF8             ; A = [$1A] - [$1A] % 8 (target bottom boundary rounded down to top of 8x8 tile)
$A0:C420 38          SEC                    ;\
$A0:C421 FD 84 0F    SBC $0F84,x            ;} Enemy X position = [A] - [enemy X radius]
$A0:C424 9D 7E 0F    STA $0F7E,x            ;/
$A0:C427 38          SEC                    ;\
$A0:C428 60          RTS                    ;} Return carry set

$A0:C429 09 07 00    ORA #$0007             ;\
$A0:C42C 38          SEC                    ;} A = [$1A] - [$1A] % 8 + 8 (target right boundary rounded up to bottom of 8x8 tile)
$A0:C42D 7D 84 0F    ADC $0F84,x            ;\
$A0:C430 9D 7E 0F    STA $0F7E,x            ;} Enemy X position = [A] + [enemy X radius]
$A0:C433 38          SEC                    ;\
$A0:C434 60          RTS                    ;} Return carry set
}


;;; $C435: Square slope definitions ;;;
{
; Copy of $94:8E54 for enemies
; 7Fh- = air, 80h+ = solid

;                        __________ Top-left
;                       |   _______ Top-right
;                       |  |   ____ Bottom-left
;                       |  |  |   _ Bottom-right
;                       |  |  |  |
$A0:C435             db 00,01,82,83, ; 0: Half height
                        00,81,02,83, ; 1: Half width
                        00,01,02,83, ; 2: Quarter
                        00,81,82,83, ; 3: Three-quarters
                        80,81,82,83  ; 4: Whole
}


;;; $C449: Enemy block collision reaction - horizontal - slope - non-square ;;;
{
;; Parameters:
;;     $14.$12: Distance to check for collision
;;     $1A: Target boundary position (left/right)
;;     $1C: Number of blocks left to check (0 if final (bottom) block)
;;     $1E: Enemy Y block span
;;     $20: In non-square slope collision:
;;         8000h: Process slopes
;;         4000h: Treat slopes as walls
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $14.$12: If carry clear, adjusted distance to move Samus
$A0:C449 24 20       BIT $20    [$7E:0020]  ;\
$A0:C44B 30 06       BMI $06    [$C453]     ;} If [$20] & 8000h != 0: go to BRANCH_PROCESS_SLOPES
$A0:C44D 70 02       BVS $02    [$C451]     ; If [$20] & 4000h = 0 (treat slopes as air):
$A0:C44F 18          CLC                    ;\
$A0:C450 60          RTS                    ;} Return carry clear

$A0:C451 38          SEC                    ;\
$A0:C452 60          RTS                    ;} Return carry set

; BRANCH_PROCESS_SLOPES
$A0:C453 AD 77 1E    LDA $1E77  [$7E:1E77]  ;\
$A0:C456 29 1F 00    AND #$001F             ;|
$A0:C459 0A          ASL A                  ;} X = ([current slope BTS] & 1Fh) * 4
$A0:C45A 0A          ASL A                  ;|
$A0:C45B AA          TAX                    ;/
$A0:C45C A5 14       LDA $14    [$7E:0014]  ;\
$A0:C45E 10 28       BPL $28    [$C488]     ;} If [$12] < 0:
$A0:C460 BF A1 C4 A0 LDA $A0C4A1,x          ;\
$A0:C464 A8          TAY                    ;|
$A0:C465 A5 13       LDA $13    [$7E:0013]  ;|
$A0:C467 49 FF FF    EOR #$FFFF             ;|
$A0:C46A 1A          INC A                  ;|
$A0:C46B 22 D6 82 80 JSL $8082D6[$80:82D6]  ;|
$A0:C46F AD F1 05    LDA $05F1  [$7E:05F1]  ;|
$A0:C472 49 FF FF    EOR #$FFFF             ;} $14.$12 *= [$C49F + [X] + 2] / 100h
$A0:C475 18          CLC                    ;|
$A0:C476 69 01 00    ADC #$0001             ;|
$A0:C479 85 12       STA $12    [$7E:0012]  ;|
$A0:C47B AD F3 05    LDA $05F3  [$7E:05F3]  ;|
$A0:C47E 49 FF FF    EOR #$FFFF             ;|
$A0:C481 69 00 00    ADC #$0000             ;|
$A0:C484 85 14       STA $14    [$7E:0014]  ;/
$A0:C486 18          CLC                    ;\
$A0:C487 60          RTS                    ;} Return carry clear

$A0:C488 BF A1 C4 A0 LDA $A0C4A1,x[$A0:C4E9];\
$A0:C48C A8          TAY                    ;|
$A0:C48D A5 13       LDA $13    [$7E:0013]  ;|
$A0:C48F 22 D6 82 80 JSL $8082D6[$80:82D6]  ;|
$A0:C493 AD F1 05    LDA $05F1  [$7E:05F1]  ;} $14.$12 *= [$C49F + [X] + 2] / 100h
$A0:C496 85 12       STA $12    [$7E:0012]  ;|
$A0:C498 AD F3 05    LDA $05F3  [$7E:05F3]  ;|
$A0:C49B 85 14       STA $14    [$7E:0014]  ;/
$A0:C49D 18          CLC                    ;\
$A0:C49E 60          RTS                    ;} Return carry clear

;                        ________ Unused. Seem to be additive speed modifiers in the $94:8586 version of this table
;                       |     ___ Adjusted distance multiplier * 100h
;                       |    |
$A0:C49F             dw 0000,0100,
                        0000,0100,
                        0000,0100,
                        0000,0100,
                        0000,0100,
                        0000,0100, ; 5: Unused. Half height isosceles triangle
                        0000,0100, ; 6: Unused. Isosceles triangle
                        0000,0100, ; 7: Half height rectangle
                        0000,0100, ; 8: Unused. Rectangle
                        0000,0100, ; 9: Unused. Rectangle
                        0000,0100, ; Ah: Unused. Rectangle
                        0000,0100, ; Bh: Unused. Rectangle
                        0000,0100, ; Ch: Unused. Rectangle
                        0000,0100, ; Dh: Unused. Rectangle
                        1000,00B0, ; Eh: Unused. Very bumpy triangle
                        1000,00B0, ; Fh: Bumpy triangle
                        0000,0100, ; 10h: Unused
                        0000,0100, ; 11h: Unused
                        1000,00C0, ; 12h: Triangle
                        0000,0100, ; 13h: Rectangle
                        1000,00C0, ; 14h: Quarter triangle
                        1000,00C0, ; 15h: Three quarter triangle
                        0800,00D8, ; 16h: Lower half-height triangle
                        0800,00D8, ; 17h: Upper half-height triangle
                        0600,00F0, ; 18h: Unused. Lower third-height triangle
                        0600,00F0, ; 19h: Unused. Middle third-height triangle
                        0600,00F0, ; 1Ah: Unused. Upper third-height triangle
                        4000,0080, ; 1Bh: Upper half-width triangle
                        4000,0080, ; 1Ch: Lower half-width triangle
                        6000,0050, ; 1Dh: Unused. Upper third-width triangle
                        6000,0050, ; 1Eh: Unused. Middle third-width triangle
                        6000,0050  ; 1Fh: Unused. Lower third-width triangle
}


;;; $C51F: Enemy block collision reaction - vertical - slope - non-square ;;;
{
;; Parameters:
;;     $14: Distance to check for collision
;;     $18: Target Y position
;; Returns:
;;     Carry: Set if collision, clear otherwise
$A0:C51F AC 54 0E    LDY $0E54  [$7E:0E54]  ; Y = [enemy index]
$A0:C522 A5 14       LDA $14    [$7E:0014]  ;\
$A0:C524 10 03       BPL $03    [$C529]     ;} If [$14] < 0:
$A0:C526 4C 9E C5    JMP $C59E  [$A0:C59E]  ; Go to BRANCH_UP

$A0:C529 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C52C 8E 04 42    STX $4204              ;|
$A0:C52F E2 20       SEP #$20               ;|
$A0:C531 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:C534 8D 06 42    STA $4206              ;|
$A0:C537 C2 20       REP #$20               ;|
$A0:C539 B9 7A 0F    LDA $0F7A,y[$7E:107A]  ;} If [current block index] % [room width in blocks] != [enemy X position] / 10h (enemy centre isn't in block):
$A0:C53C 4A          LSR A                  ;|
$A0:C53D 4A          LSR A                  ;|
$A0:C53E 4A          LSR A                  ;|
$A0:C53F 4A          LSR A                  ;|
$A0:C540 CD 16 42    CMP $4216              ;|
$A0:C543 F0 02       BEQ $02    [$C547]     ;/
$A0:C545 18          CLC                    ;\
$A0:C546 60          RTS                    ;} Return carry clear

$A0:C547 A5 18       LDA $18    [$7E:0018]  ;\
$A0:C549 18          CLC                    ;|
$A0:C54A 79 84 0F    ADC $0F84,y[$7E:0FC4]  ;|
$A0:C54D 3A          DEC A                  ;} $0DD4 = (enemy target bottom boundary) % 10h
$A0:C54E 29 0F 00    AND #$000F             ;|
$A0:C551 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$A0:C554 BF 02 64 7F LDA $7F6402,x[$7F:6713];\
$A0:C558 29 1F 00    AND #$001F             ;|
$A0:C55B 0A          ASL A                  ;|
$A0:C55C 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$A0:C55D 0A          ASL A                  ;|
$A0:C55E 0A          ASL A                  ;|
$A0:C55F 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$A0:C562 BF 01 64 7F LDA $7F6401,x[$7F:6712];\
$A0:C566 30 34       BMI $34    [$C59C]     ;} If [block BTS] & 80h = 0: return carry clear
$A0:C568 0A          ASL A                  ;\
$A0:C569 30 05       BMI $05    [$C570]     ;} If [block BTS] & 40h = 0:
$A0:C56B B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ; A = [enemy X position] % 10h
$A0:C56E 80 06       BRA $06    [$C576]

$A0:C570 B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ;\ Else ([block BTS] & 40h != 0):
$A0:C573 49 0F 00    EOR #$000F             ;} A = Fh - [enemy X position] % 10h

$A0:C576 29 0F 00    AND #$000F
$A0:C579 18          CLC                    ;\
$A0:C57A 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$A0:C57D AA          TAX                    ;} A = [$94:8B2B + [$0DD6] + [A]] (slope top Y offset)
$A0:C57E BF 2B 8B 94 LDA $948B2B,x[$94:8C6A];/
$A0:C582 29 1F 00    AND #$001F
$A0:C585 38          SEC                    ;\
$A0:C586 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$A0:C589 3A          DEC A                  ;/
$A0:C58A F0 02       BEQ $02    [$C58E]     ;\
$A0:C58C 10 0E       BPL $0E    [$C59C]     ;} If [A] > 0: return carry clear

$A0:C58E 18          CLC                    ;\
$A0:C58F 65 18       ADC $18    [$7E:0018]  ;} Enemy Y position = (target Y position) + [A]
$A0:C591 99 7E 0F    STA $0F7E,y[$7E:0FBE]  ;/
$A0:C594 A9 FF FF    LDA #$FFFF             ;\
$A0:C597 99 80 0F    STA $0F80,y[$7E:0FC0]  ;} Enemy Y subposition = FFFFh
$A0:C59A 38          SEC                    ;\
$A0:C59B 60          RTS                    ;} Return carry set

$A0:C59C 18          CLC
$A0:C59D 60          RTS

; BRANCH_UP
$A0:C59E AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C5A1 8E 04 42    STX $4204              ;|
$A0:C5A4 E2 20       SEP #$20               ;|
$A0:C5A6 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:C5A9 8D 06 42    STA $4206              ;|
$A0:C5AC C2 20       REP #$20               ;|
$A0:C5AE B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;} If [current block index] % [room width in blocks] != [enemy X position] / 10h (enemy centre isn't in block):
$A0:C5B1 4A          LSR A                  ;|
$A0:C5B2 4A          LSR A                  ;|
$A0:C5B3 4A          LSR A                  ;|
$A0:C5B4 4A          LSR A                  ;|
$A0:C5B5 CD 16 42    CMP $4216              ;|
$A0:C5B8 F0 02       BEQ $02    [$C5BC]     ;/
$A0:C5BA 18          CLC                    ;\
$A0:C5BB 60          RTS                    ;} Return carry clear

$A0:C5BC A5 18       LDA $18    [$7E:0018]  ;\
$A0:C5BE 38          SEC                    ;|
$A0:C5BF F9 84 0F    SBC $0F84,y[$7E:0F84]  ;|
$A0:C5C2 29 0F 00    AND #$000F             ;} $0DD4 = Fh - (enemy target top boundary) % 10h
$A0:C5C5 49 0F 00    EOR #$000F             ;|
$A0:C5C8 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$A0:C5CB BF 02 64 7F LDA $7F6402,x[$7F:6A6C];\
$A0:C5CF 29 1F 00    AND #$001F             ;|
$A0:C5D2 0A          ASL A                  ;|
$A0:C5D3 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$A0:C5D4 0A          ASL A                  ;|
$A0:C5D5 0A          ASL A                  ;|
$A0:C5D6 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$A0:C5D9 BF 01 64 7F LDA $7F6401,x[$7F:6A6B];\
$A0:C5DD 10 38       BPL $38    [$C617]     ;} If [block BTS] & 80h = 0: return carry clear
$A0:C5DF 0A          ASL A                  ;\
$A0:C5E0 30 05       BMI $05    [$C5E7]     ;} If [block BTS] & 40h = 0:
$A0:C5E2 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ; A = [enemy X position] % 10h
$A0:C5E5 80 06       BRA $06    [$C5ED]

$A0:C5E7 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;\ Else ([block BTS] & 40h != 0):
$A0:C5EA 49 0F 00    EOR #$000F             ;} A = Fh - [enemy X position] % 10h

$A0:C5ED 29 0F 00    AND #$000F
$A0:C5F0 18          CLC                    ;\
$A0:C5F1 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$A0:C5F4 AA          TAX                    ;} A = [$94:8B2B + [$0DD6] + [A]] (slope top Y offset)
$A0:C5F5 BF 2B 8B 94 LDA $948B2B,x[$94:8C4D];/
$A0:C5F9 29 1F 00    AND #$001F
$A0:C5FC 38          SEC                    ;\
$A0:C5FD ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$A0:C600 3A          DEC A                  ;/
$A0:C601 F0 02       BEQ $02    [$C605]     ;\
$A0:C603 10 12       BPL $12    [$C617]     ;} If [A] > 0: return carry clear

$A0:C605 49 FF FF    EOR #$FFFF             ;\
$A0:C608 1A          INC A                  ;|
$A0:C609 18          CLC                    ;} Enemy Y position = (target Y position) - [A]
$A0:C60A 65 18       ADC $18    [$7E:0018]  ;|
$A0:C60C 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;/
$A0:C60F A9 00 00    LDA #$0000             ;\
$A0:C612 99 80 0F    STA $0F80,y[$7E:0F80]  ;} Enemy Y subposition = 0
$A0:C615 38          SEC                    ;\
$A0:C616 60          RTS                    ;} Return carry set

$A0:C617 18          CLC
$A0:C618 60          RTS
}


;;; $C619: Enemy block collision reaction - horizontal extension ;;;
{
;; Returns:
;;     Carry: Clear. No collision

; Clone of $94:9411
; If BTS is 0, acts like air
; Otherwise, offsets block index by block BTS, updates X, and loops back to the `JSR (xxxx, X)` instruction that jumped to here
$A0:C619 AE C4 0D    LDX $0DC4  [$7E:0DC4]
$A0:C61C BF 02 64 7F LDA $7F6402,x[$7F:6642]
$A0:C620 29 FF 00    AND #$00FF
$A0:C623 F0 28       BEQ $28    [$C64D]
$A0:C625 89 80 00    BIT #$0080
$A0:C628 D0 05       BNE $05    [$C62F]
$A0:C62A 29 FF 00    AND #$00FF
$A0:C62D 80 03       BRA $03    [$C632]

$A0:C62F 09 00 FF    ORA #$FF00

$A0:C632 18          CLC
$A0:C633 6D C4 0D    ADC $0DC4  [$7E:0DC4]
$A0:C636 8D C4 0D    STA $0DC4  [$7E:0DC4]
$A0:C639 0A          ASL A
$A0:C63A AA          TAX
$A0:C63B BF 02 00 7F LDA $7F0002,x[$7F:0480]
$A0:C63F 29 00 F0    AND #$F000
$A0:C642 EB          XBA
$A0:C643 4A          LSR A
$A0:C644 4A          LSR A
$A0:C645 4A          LSR A
$A0:C646 AA          TAX
$A0:C647 68          PLA
$A0:C648 38          SEC
$A0:C649 E9 03 00    SBC #$0003
$A0:C64C 48          PHA

$A0:C64D 18          CLC
$A0:C64E 60          RTS
}


;;; $C64F: Enemy block collision reaction - vertical extension ;;;
{
;; Returns:
;;     Carry: Clear. No collision

; Clone of $94:9447
; If BTS is 0, acts like air
; Otherwise, offsets block index by block BTS, updates X, and loops back to the `JSR (xxxx, X)` instruction that jumped to here
$A0:C64F AE C4 0D    LDX $0DC4  [$7E:0DC4]
$A0:C652 BF 02 64 7F LDA $7F6402,x[$7F:6BB3]
$A0:C656 29 FF 00    AND #$00FF
$A0:C659 F0 40       BEQ $40    [$C69B]
$A0:C65B 89 80 00    BIT #$0080
$A0:C65E D0 12       BNE $12    [$C672]
$A0:C660 8D D4 0D    STA $0DD4  [$7E:0DD4]
$A0:C663 AD C4 0D    LDA $0DC4  [$7E:0DC4]

$A0:C666 18          CLC
$A0:C667 6D A5 07    ADC $07A5  [$7E:07A5]
$A0:C66A CE D4 0D    DEC $0DD4  [$7E:0DD4]
$A0:C66D D0 F7       BNE $F7    [$C666]
$A0:C66F 4C 84 C6    JMP $C684  [$A0:C684]

$A0:C672 09 00 FF    ORA #$FF00
$A0:C675 8D D4 0D    STA $0DD4  [$7E:0DD4]
$A0:C678 AD C4 0D    LDA $0DC4  [$7E:0DC4]

$A0:C67B 38          SEC
$A0:C67C ED A5 07    SBC $07A5  [$7E:07A5]
$A0:C67F EE D4 0D    INC $0DD4  [$7E:0DD4]
$A0:C682 D0 F7       BNE $F7    [$C67B]

$A0:C684 8D C4 0D    STA $0DC4  [$7E:0DC4]
$A0:C687 0A          ASL A
$A0:C688 AA          TAX
$A0:C689 BF 02 00 7F LDA $7F0002,x[$7F:0E44]
$A0:C68D 29 00 F0    AND #$F000
$A0:C690 EB          XBA
$A0:C691 4A          LSR A
$A0:C692 4A          LSR A
$A0:C693 4A          LSR A
$A0:C694 AA          TAX
$A0:C695 68          PLA
$A0:C696 38          SEC
$A0:C697 E9 03 00    SBC #$0003
$A0:C69A 48          PHA

$A0:C69B 18          CLC
$A0:C69C 60          RTS
}


;;; $C69D: Move enemy right by [$14].[$12], treat slopes as walls ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; Used by oum

$A0:C69D A9 00 40    LDA #$4000
$A0:C6A0 85 20       STA $20    [$7E:0020]
$A0:C6A2 80 09       BRA $09    [$C6AD]
}


;;; $C6A4: Move enemy right by [$14].[$12], process slopes ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; Call $A0:C8AD to adjust enemy Y position for any slopes, this function only adjusts enemy X position
; Used by yard and Wrecked Ship orange zoomer

$A0:C6A4 A9 00 80    LDA #$8000
$A0:C6A7 85 20       STA $20    [$7E:0020]
$A0:C6A9 80 02       BRA $02    [$C6AD]
}


;;; $C6AB: Move enemy right by [$14].[$12], ignore slopes ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; This is the commonly used one

$A0:C6AB 64 20       STZ $20    [$7E:0020]
}


;;; $C6AD: Move enemy right by [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;;     $20: In non-square slope collision:
;;         8000h: Process slopes
;;         4000h: Treat slopes as walls
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:C6AD A5 12       LDA $12    [$7E:0012]  ;\
$A0:C6AF 05 14       ORA $14    [$7E:0014]  ;} If [$14].[$12] = 0.0:
$A0:C6B1 D0 02       BNE $02    [$C6B5]     ;/
$A0:C6B3 18          CLC                    ;\
$A0:C6B4 6B          RTL                    ;} Return carry clear

$A0:C6B5 DA          PHX
$A0:C6B6 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A0:C6B9 38          SEC                    ;|
$A0:C6BA FD 84 0F    SBC $0F84,x[$7E:0F84]  ;|
$A0:C6BD 29 F0 FF    AND #$FFF0             ;|
$A0:C6C0 85 1C       STA $1C    [$7E:001C]  ;|
$A0:C6C2 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A0:C6C5 18          CLC                    ;|
$A0:C6C6 7D 84 0F    ADC $0F84,x[$7E:0F84]  ;|
$A0:C6C9 3A          DEC A                  ;} $1C = (enemy bottom boundary) / 10h - (enemy top boundary) / 10h (number of blocks left to check)
$A0:C6CA 38          SEC                    ;|
$A0:C6CB E5 1C       SBC $1C    [$7E:001C]  ;|
$A0:C6CD 4A          LSR A                  ;|
$A0:C6CE 4A          LSR A                  ;|
$A0:C6CF 4A          LSR A                  ;|
$A0:C6D0 4A          LSR A                  ;|
$A0:C6D1 85 1C       STA $1C    [$7E:001C]  ;|
$A0:C6D3 85 1E       STA $1E    [$7E:001E]  ; $1E = [$1C] (enemy Y block span)
$A0:C6D5 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A0:C6D8 38          SEC                    ;|
$A0:C6D9 FD 84 0F    SBC $0F84,x[$7E:0F84]  ;|
$A0:C6DC 4A          LSR A                  ;|
$A0:C6DD 4A          LSR A                  ;|
$A0:C6DE 4A          LSR A                  ;} Calculate (enemy top boundary) / 10h * [room width in blocks] (target row block index)
$A0:C6DF 4A          LSR A                  ;|
$A0:C6E0 E2 20       SEP #$20               ;|
$A0:C6E2 8D 02 42    STA $4202              ;|
$A0:C6E5 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:C6E8 8D 03 42    STA $4203              ;|
$A0:C6EB C2 20       REP #$20               ;/
$A0:C6ED BD 7C 0F    LDA $0F7C,x[$7E:0F7C]  ;\
$A0:C6F0 18          CLC                    ;|
$A0:C6F1 65 12       ADC $12    [$7E:0012]  ;|
$A0:C6F3 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy X position] + [$14].[$12] (target X position)
$A0:C6F5 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A0:C6F8 65 14       ADC $14    [$7E:0014]  ;|
$A0:C6FA 85 18       STA $18    [$7E:0018]  ;/
$A0:C6FC 24 14       BIT $14    [$7E:0014]  ;\
$A0:C6FE 30 07       BMI $07    [$C707]     ;} If [$14] >= 0:
$A0:C700 18          CLC                    ;\
$A0:C701 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;} $1A = (target right boundary)
$A0:C704 3A          DEC A                  ;/
$A0:C705 80 04       BRA $04    [$C70B]

$A0:C707 38          SEC                    ;\ Else ([$14] < 0):
$A0:C708 FD 82 0F    SBC $0F82,x[$7E:1002]  ;} $1A = (target left boundary)

$A0:C70B 85 1A       STA $1A    [$7E:001A]
$A0:C70D 4A          LSR A                  ;\
$A0:C70E 4A          LSR A                  ;|
$A0:C70F 4A          LSR A                  ;|
$A0:C710 4A          LSR A                  ;|
$A0:C711 18          CLC                    ;} X = ((target row block index) + [$1A] / 10h) * 2 (index of top block to check)
$A0:C712 6D 16 42    ADC $4216              ;|
$A0:C715 0A          ASL A                  ;|
$A0:C716 AA          TAX                    ;/

; LOOP
$A0:C717 BF 02 00 7F LDA $7F0002,x[$7F:0230]; A = [$7F:0002 + [X]] (block)
$A0:C71B 20 45 C8    JSR $C845  [$A0:C845]  ; Enemy horizontal block reaction
$A0:C71E B0 24       BCS $24    [$C744]     ; If solid: go to BRANCH_SOLID
$A0:C720 8A          TXA                    ;\
$A0:C721 18          CLC                    ;|
$A0:C722 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$A0:C725 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$A0:C728 AA          TAX                    ;/
$A0:C729 C6 1C       DEC $1C    [$7E:001C]  ; Decrement $1C
$A0:C72B 10 EA       BPL $EA    [$C717]     ; If [$1C] >= 0: go to LOOP
$A0:C72D FA          PLX
$A0:C72E A5 12       LDA $12    [$7E:0012]  ;\
$A0:C730 18          CLC                    ;|
$A0:C731 7D 7C 0F    ADC $0F7C,x[$7E:0F7C]  ;|
$A0:C734 9D 7C 0F    STA $0F7C,x[$7E:0F7C]  ;} Enemy X position += [$14].[$12]
$A0:C737 A5 14       LDA $14    [$7E:0014]  ;|
$A0:C739 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;|
$A0:C73C 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A0:C73F 18          CLC                    ;\
$A0:C740 6B          RTL                    ;} Return carry clear

; Nothing points here
$A0:C741 FA          PLX
$A0:C742 38          SEC
$A0:C743 6B          RTL

; BRANCH_SOLID
$A0:C744 FA          PLX
$A0:C745 A5 1A       LDA $1A    [$7E:001A]
$A0:C747 24 14       BIT $14    [$7E:0014]  ;\
$A0:C749 30 17       BMI $17    [$C762]     ;} If [$14] < 0: go to BRANCH_MOVING_LEFT
$A0:C74B 29 F0 FF    AND #$FFF0             ; A = [$1A] - [$1A] % 10h (target right boundary rounded down to left of 16x16 tile)
$A0:C74E 38          SEC                    ;\
$A0:C74F FD 82 0F    SBC $0F82,x[$7E:0FC2]  ;|
$A0:C752 DD 7A 0F    CMP $0F7A,x[$7E:0FBA]  ;} Enemy X position = max([enemy X position], [A] - [enemy X radius])
$A0:C755 90 03       BCC $03    [$C75A]     ;|
$A0:C757 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/

$A0:C75A A9 FF FF    LDA #$FFFF             ;\
$A0:C75D 9D 7C 0F    STA $0F7C,x[$7E:0FBC]  ;} Enemy X subposition = FFFFh
$A0:C760 38          SEC                    ;\
$A0:C761 6B          RTL                    ;} Return carry set

; BRANCH_MOVING_LEFT
$A0:C762 09 0F 00    ORA #$000F             ;\
$A0:C765 38          SEC                    ;} A = [$1A] - [$1A] % 10h + 10h (target left boundary rounded up to right of 16x16 tile)
$A0:C766 7D 82 0F    ADC $0F82,x[$7E:0FC2]  ;|
$A0:C769 DD 7A 0F    CMP $0F7A,x[$7E:0FBA]  ;|
$A0:C76C F0 02       BEQ $02    [$C770]     ;} Enemy X position = min([enemy X position], [A] + [enemy X radius])
$A0:C76E B0 03       BCS $03    [$C773]     ;|
                                            ;|
$A0:C770 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/

$A0:C773 9E 7C 0F    STZ $0F7C,x[$7E:0FBC]  ;} Enemy X subposition = 0
$A0:C776 38          SEC                    ;\
$A0:C777 6B          RTL                    ;} Return carry set
}


;;; $C778: Unused. Move enemy down by [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collided with wall

$A0:C778 A9 00 40    LDA #$4000
$A0:C77B 85 20       STA $20    [$7E:0020]
$A0:C77D 80 09       BRA $09    [$C788]
}


;;; $C77F: Unused. Move enemy down by [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collided with wall

$A0:C77F A9 00 80    LDA #$8000
$A0:C782 85 20       STA $20    [$7E:0020]
$A0:C784 80 02       BRA $02    [$C788]
}


;;; $C786: Move enemy down by [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; This is the commonly (and only) used one

$A0:C786 64 20       STZ $20    [$7E:0020]
}


;;; $C788: Move enemy down by [$14].[$12] ;;;
{
;; Parameters:
;;     X: Enemy index
;;     $14.$12: Distance to move (signed)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; The value of $20 actually has no effect for vertical movement
$A0:C788 A5 12       LDA $12    [$7E:0012]  ;\
$A0:C78A 05 14       ORA $14    [$7E:0014]  ;} If [$14].[$12] = 0.0:
$A0:C78C D0 02       BNE $02    [$C790]     ;/
$A0:C78E 18          CLC                    ;\
$A0:C78F 6B          RTL                    ;} Return carry clear

$A0:C790 DA          PHX
$A0:C791 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A0:C794 38          SEC                    ;|
$A0:C795 FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A0:C798 29 F0 FF    AND #$FFF0             ;|
$A0:C79B 85 1C       STA $1C    [$7E:001C]  ;|
$A0:C79D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A0:C7A0 18          CLC                    ;|
$A0:C7A1 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A0:C7A4 3A          DEC A                  ;} $1C = (enemy right boundary) / 10h - (enemy left boundary) / 10h (number of blocks left to check)
$A0:C7A5 38          SEC                    ;|
$A0:C7A6 E5 1C       SBC $1C    [$7E:001C]  ;|
$A0:C7A8 4A          LSR A                  ;|
$A0:C7A9 4A          LSR A                  ;|
$A0:C7AA 4A          LSR A                  ;|
$A0:C7AB 4A          LSR A                  ;|
$A0:C7AC 85 1C       STA $1C    [$7E:001C]  ;/
$A0:C7AE 85 1E       STA $1E    [$7E:001E]  ; $1E = [$1C] (enemy X block span)
$A0:C7B0 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A0:C7B3 18          CLC                    ;|
$A0:C7B4 65 12       ADC $12    [$7E:0012]  ;|
$A0:C7B6 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy Y position] + [$14].[$12] (target position)
$A0:C7B8 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A0:C7BB 65 14       ADC $14    [$7E:0014]  ;|
$A0:C7BD 85 18       STA $18    [$7E:0018]  ;/
$A0:C7BF 24 14       BIT $14    [$7E:0014]  ;\
$A0:C7C1 30 07       BMI $07    [$C7CA]     ;} If [$14] >= 0: (moving down)
$A0:C7C3 18          CLC                    ;\
$A0:C7C4 7D 84 0F    ADC $0F84,x[$7E:0F84]  ;} $1A = [$18] + [enemy Y radius] - 1 (target front boundary)
$A0:C7C7 3A          DEC A                  ;/
$A0:C7C8 80 04       BRA $04    [$C7CE]

$A0:C7CA 38          SEC                    ;\ Else ([$14] < 0): (moving up)
$A0:C7CB FD 84 0F    SBC $0F84,x[$7E:0FC4]  ;} $1A = [$18] - [enemy Y radius] (target front boundary)

$A0:C7CE 85 1A       STA $1A    [$7E:001A]
$A0:C7D0 4A          LSR A                  ;\
$A0:C7D1 4A          LSR A                  ;|
$A0:C7D2 4A          LSR A                  ;|
$A0:C7D3 4A          LSR A                  ;|
$A0:C7D4 E2 20       SEP #$20               ;|
$A0:C7D6 8D 02 42    STA $4202              ;|
$A0:C7D9 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$A0:C7DC 8D 03 42    STA $4203              ;|
$A0:C7DF C2 20       REP #$20               ;|
$A0:C7E1 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A0:C7E4 38          SEC                    ;} X = ((enemy front boundary) / 10h * [room width] + (enemy left boundary) / 10h) * 2 (index of leftmost block to check)
$A0:C7E5 FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A0:C7E8 4A          LSR A                  ;|
$A0:C7E9 4A          LSR A                  ;|
$A0:C7EA 4A          LSR A                  ;|
$A0:C7EB 4A          LSR A                  ;|
$A0:C7EC 18          CLC                    ;|
$A0:C7ED 6D 16 42    ADC $4216              ;|
$A0:C7F0 0A          ASL A                  ;|
$A0:C7F1 AA          TAX                    ;/

; LOOP
$A0:C7F2 BF 02 00 7F LDA $7F0002,x[$7F:03AC]; A = [$7F:0002 + [X]] (block)
$A0:C7F6 20 79 C8    JSR $C879  [$A0:C879]  ; Enemy vertical block reaction
$A0:C7F9 B0 16       BCS $16    [$C811]     ; If solid: go to BRANCH_SOLID
$A0:C7FB E8          INX                    ;\
$A0:C7FC E8          INX                    ;} X += 2
$A0:C7FD C6 1C       DEC $1C    [$7E:001C]  ; Decrement $1C
$A0:C7FF 10 F1       BPL $F1    [$C7F2]     ; If [$1C] >= 0: go to LOOP
$A0:C801 FA          PLX
$A0:C802 A5 16       LDA $16    [$7E:0016]  ;\
$A0:C804 9D 80 0F    STA $0F80,x[$7E:0FC0]  ;|
$A0:C807 A5 18       LDA $18    [$7E:0018]  ;} Enemy Y position = [$18].[$16]
$A0:C809 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A0:C80C 18          CLC                    ;\
$A0:C80D 6B          RTL                    ;} Return carry clear

; Nothing points here
$A0:C80E FA          PLX
$A0:C80F 38          SEC
$A0:C810 6B          RTL

; BRANCH_SOLID
$A0:C811 FA          PLX
$A0:C812 A5 1A       LDA $1A    [$7E:001A]
$A0:C814 24 14       BIT $14    [$7E:0014]  ;\
$A0:C816 30 17       BMI $17    [$C82F]     ;} If [$14] < 0: go to BRANCH_MOVING_UP
$A0:C818 29 F0 FF    AND #$FFF0             ; A = [$1A] - [$1A] % 10h (target bottom boundary rounded down to top of 16x16 tile)
$A0:C81B 38          SEC                    ;\
$A0:C81C FD 84 0F    SBC $0F84,x[$7E:0F84]  ;|
$A0:C81F DD 7E 0F    CMP $0F7E,x[$7E:0F7E]  ;} Enemy Y position = max([enemy Y position], [A] - [enemy Y radius])
$A0:C822 90 03       BCC $03    [$C827]     ;|
$A0:C824 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/

$A0:C827 A9 FF FF    LDA #$FFFF             ;\
$A0:C82A 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y subposition = FFFFh
$A0:C82D 38          SEC                    ;\
$A0:C82E 6B          RTL                    ;} Return carry set

; BRANCH_MOVING_UP
$A0:C82F 09 0F 00    ORA #$000F             ;\
$A0:C832 38          SEC                    ;} A = [$1A] - [$1A] % 10h + 10h (target right boundary rounded up to bottom of 16x16 tile)
$A0:C833 7D 84 0F    ADC $0F84,x[$7E:0FC4]  ;\
$A0:C836 DD 7E 0F    CMP $0F7E,x[$7E:0FBE]  ;|
$A0:C839 F0 02       BEQ $02    [$C83D]     ;} Enemy Y position = min([enemy Y position], [A] + [enemy Y radius])
$A0:C83B B0 03       BCS $03    [$C840]     ;|
                                            ;|
$A0:C83D 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/

$A0:C840 9E 80 0F    STZ $0F80,x[$7E:0FC0]  ;} Enemy Y subposition = 0
$A0:C843 38          SEC                    ;\
$A0:C844 6B          RTL                    ;} Return carry set
}


;;; $C845: Enemy horizontal block reaction ;;;
{
;; Parameters
;;     A: Block
;;     X: Block index (multiple of 2)
;;     $14.$12: Distance to check for collision
;;     $1A: Target boundary position (left/right)
;;     $1C: Number of blocks left to check (0 if final (bottom) block)
;;     $1E: Enemy Y block span
;;     $20: In non-square slope collision:
;;         8000h: Process slopes
;;         4000h: Treat slopes as walls
;; Returns:
;;     Carry: Set if collision, clear otherwise
;;     $14.$12: If carry clear, adjusted distance to move Samus

$A0:C845 DA          PHX
$A0:C846 9B          TXY                    ; Y = [X]
$A0:C847 29 00 F0    AND #$F000             ;\
$A0:C84A EB          XBA                    ;|
$A0:C84B 4A          LSR A                  ;|
$A0:C84C 4A          LSR A                  ;} X = (block type) * 2
$A0:C84D 4A          LSR A                  ;|
$A0:C84E AA          TAX                    ;/
$A0:C84F 98          TYA                    ;\
$A0:C850 4A          LSR A                  ;} Current block index = [Y] / 2
$A0:C851 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$A0:C854 FC 59 C8    JSR ($C859,x)[$A0:C2BC]; Execute [$C859 + [X]]
$A0:C857 FA          PLX
$A0:C858 60          RTS

$A0:C859             dw C2BC, ;  0: Air
                        C2FA, ; *1: Slope
                        C2BC, ;  2: Spike air
                        C2BC, ;  3: Special air
                        C2BC, ;  4: Shootable air
                        C619, ; *5: Horizontal extension
                        C2BC, ;  6: Unused air
                        C2BC, ;  7: Bombable air
                        C2BE, ;  8: Solid block
                        C2BE, ;  9: Door block
                        C2C0, ; *Ah: Spike block
                        C2BE, ;  Bh: Special block
                        C2BE, ;  Ch: Shootable block
                        C64F, ; *Dh: Vertical extension
                        C2BE, ;  Eh: Grapple block
                        C2BE  ;  Fh: Bombable block
}


;;; $C879: Enemy vertical block reaction ;;;
{
;; Parameters
;;     A: Block
;;     X: Block index (multiple of 2)
;;     $14.$12: Distance to check for collision
;;     $18: Target Y position
;;     $1A: Target boundary position (top/bottom)
;;     $1C: Number of blocks left to check (0 if final (rightmost) block)
;;     $1E: Enemy X block span
;; Returns:
;;     Carry: Set if collision, clear otherwise

$A0:C879 DA          PHX
$A0:C87A 9B          TXY                    ; Y = [X]
$A0:C87B 29 00 F0    AND #$F000             ;\
$A0:C87E EB          XBA                    ;|
$A0:C87F 4A          LSR A                  ;|
$A0:C880 4A          LSR A                  ;} X = (block type) * 2
$A0:C881 4A          LSR A                  ;|
$A0:C882 AA          TAX                    ;/
$A0:C883 98          TYA                    ;\
$A0:C884 4A          LSR A                  ;} Current block index = [Y] / 2
$A0:C885 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$A0:C888 FC 8D C8    JSR ($C88D,x)[$A0:C319]; Execute [$C88D + [X]]
$A0:C88B FA          PLX
$A0:C88C 60          RTS

$A0:C88D             dw C2BC, ;  0: Air
                        C319, ; *1: Slope
                        C2BC, ;  2: Spike air
                        C2BC, ;  3: Special air
                        C2BC, ;  4: Shootable air
                        C619, ; *5: Horizontal extension
                        C2BC, ;  6: Unused air
                        C2BC, ;  7: Bombable air
                        C2BE, ;  8: Solid block
                        C2BE, ;  9: Door block
                        C2C0, ; *Ah: Spike block
                        C2BE, ;  Bh: Special block
                        C2BE, ;  Ch: Shootable block
                        C64F, ; *Dh: Vertical extension
                        C2BE, ;  Eh: Grapple block
                        C2BE  ;  Fh: Bombable block
}


;;; $C8AD: Align enemy Y position with non-square slope ;;;
{
;; Parameters:
;;     X: Enemy index
;; Returns:
;;     Carry: Set if position was adjusted by slope, otherwise clear

; Align enemy vertically to slopes if currently in contact with slopes
; This function is usually called after $A0:C6A4 only if it returns carry clear, but it's applicable if it returns carry set too

$A0:C8AD 5A          PHY
$A0:C8AE DA          PHX
$A0:C8AF 18          CLC                    ;\
$A0:C8B0 08          PHP                    ;} Saved carry = clear
$A0:C8B1 9B          TXY                    ;\
$A0:C8B2 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;|
$A0:C8B5 48          PHA                    ;|
$A0:C8B6 B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;|
$A0:C8B9 18          CLC                    ;} Calculate the block containing enemy bottom centre
$A0:C8BA 79 84 0F    ADC $0F84,y[$7E:0F84]  ;|
$A0:C8BD 3A          DEC A                  ;|
$A0:C8BE 48          PHA                    ;|
$A0:C8BF 22 70 BB A0 JSL $A0BB70[$A0:BB70]  ;/
$A0:C8C3 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$A0:C8C6 0A          ASL A                  ;|
$A0:C8C7 AA          TAX                    ;|
$A0:C8C8 BF 02 00 7F LDA $7F0002,x[$7F:00EC];} If (block type) != slope: go to BRANCH_ENEMY_TOP_CHECK
$A0:C8CC 29 00 F0    AND #$F000             ;|
$A0:C8CF C9 00 10    CMP #$1000             ;|
$A0:C8D2 D0 5F       BNE $5F    [$C933]     ;/
$A0:C8D4 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C8D7 BF 02 64 7F LDA $7F6402,x[$7F:6A6C];|
$A0:C8DB 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5 (square slope): go to BRANCH_ENEMY_TOP_CHECK
$A0:C8DE C9 05 00    CMP #$0005             ;|
$A0:C8E1 90 50       BCC $50    [$C933]     ;/
$A0:C8E3 28          PLP                    ;\
$A0:C8E4 38          SEC                    ;} Saved carry = set
$A0:C8E5 08          PHP                    ;/
$A0:C8E6 B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;\
$A0:C8E9 18          CLC                    ;|
$A0:C8EA 79 84 0F    ADC $0F84,y[$7E:0F84]  ;|
$A0:C8ED 3A          DEC A                  ;} $0DD4 = (enemy bottom boundary) % 10h (Y distance into slope)
$A0:C8EE 29 0F 00    AND #$000F             ;|
$A0:C8F1 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$A0:C8F4 BF 02 64 7F LDA $7F6402,x[$7F:6A6C];\
$A0:C8F8 29 1F 00    AND #$001F             ;|
$A0:C8FB 0A          ASL A                  ;|
$A0:C8FC 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$A0:C8FD 0A          ASL A                  ;|
$A0:C8FE 0A          ASL A                  ;|
$A0:C8FF 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$A0:C902 BF 01 64 7F LDA $7F6401,x[$7F:6A6B];\
$A0:C906 30 2B       BMI $2B    [$C933]     ;} If [block BTS] & 80h != 0: go to BRANCH_ENEMY_TOP_CHECK
$A0:C908 0A          ASL A                  ;\
$A0:C909 30 05       BMI $05    [$C910]     ;} If [block BTS] & 40h = 0:
$A0:C90B B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ; A = [enemy X position] % 10h (X distance into slope)
$A0:C90E 80 06       BRA $06    [$C916]

$A0:C910 B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ;\ Else ([block BTS] & 40h != 0):
$A0:C913 49 0F 00    EOR #$000F             ;} A = Fh - [enemy X position] % 10h (X distance into slope)

$A0:C916 29 0F 00    AND #$000F
$A0:C919 18          CLC                    ;\
$A0:C91A 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;} X = (slope definition table base index) + [A] (slope definition index)
$A0:C91D AA          TAX                    ;/
$A0:C91E BF 2B 8B 94 LDA $948B2B,x[$94:8C5A];\
$A0:C922 29 1F 00    AND #$001F             ;} A = [$94:8B2B + [X]] % 20h (slope top Y offset)
$A0:C925 38          SEC                    ;\
$A0:C926 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Y distance into slope) + 1
$A0:C929 3A          DEC A                  ;/
$A0:C92A 10 07       BPL $07    [$C933]     ; If [A] >= 0 (enemy is above the slope): go to BRANCH_ENEMY_TOP_CHECK
$A0:C92C 18          CLC                    ;\
$A0:C92D 79 7E 0F    ADC $0F7E,y[$7E:117E]  ;} Enemy Y position += [A] (bring enemy on top of slope)
$A0:C930 99 7E 0F    STA $0F7E,y[$7E:117E]  ;/

; BRANCH_ENEMY_TOP_CHECK
$A0:C933 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;\
$A0:C936 48          PHA                    ;|
$A0:C937 B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;|
$A0:C93A 38          SEC                    ;} Calculate the block containing enemy top centre
$A0:C93B F9 84 0F    SBC $0F84,y[$7E:0F84]  ;|
$A0:C93E 48          PHA                    ;|
$A0:C93F 22 70 BB A0 JSL $A0BB70[$A0:BB70]  ;/
$A0:C943 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;\
$A0:C946 0A          ASL A                  ;|
$A0:C947 AA          TAX                    ;|
$A0:C948 BF 02 00 7F LDA $7F0002,x[$7F:00EC];} If (block type) != slope: return
$A0:C94C 29 00 F0    AND #$F000             ;|
$A0:C94F C9 00 10    CMP #$1000             ;|
$A0:C952 D0 67       BNE $67    [$C9BB]     ;/
$A0:C954 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$A0:C957 BF 02 64 7F LDA $7F6402,x[$7F:6A6C];|
$A0:C95B 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5 (square slope): return
$A0:C95E C9 05 00    CMP #$0005             ;|
$A0:C961 90 58       BCC $58    [$C9BB]     ;/
$A0:C963 28          PLP                    ;\
$A0:C964 38          SEC                    ;} Saved carry = set
$A0:C965 08          PHP                    ;/
$A0:C966 B9 7E 0F    LDA $0F7E,y[$7E:0F7E]  ;\
$A0:C969 38          SEC                    ;|
$A0:C96A F9 84 0F    SBC $0F84,y[$7E:0F84]  ;|
$A0:C96D 29 0F 00    AND #$000F             ;} $0DD4 = Fh - (enemy top boundary) % 10h (Y distance into slope)
$A0:C970 49 0F 00    EOR #$000F             ;|
$A0:C973 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$A0:C976 BF 02 64 7F LDA $7F6402,x[$7F:6A6C];\
$A0:C97A 29 1F 00    AND #$001F             ;|
$A0:C97D 0A          ASL A                  ;|
$A0:C97E 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$A0:C97F 0A          ASL A                  ;|
$A0:C980 0A          ASL A                  ;|
$A0:C981 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$A0:C984 BF 01 64 7F LDA $7F6401,x[$7F:6A6B];\
$A0:C988 10 31       BPL $31    [$C9BB]     ;} If [block BTS] & 80h != 0: return
$A0:C98A 0A          ASL A                  ;\
$A0:C98B 30 05       BMI $05    [$C992]     ;} If [block BTS] & 40h = 0:
$A0:C98D B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ; A = [enemy X position] % 10h (X distance into slope)
$A0:C990 80 06       BRA $06    [$C998]

$A0:C992 B9 7A 0F    LDA $0F7A,y[$7E:0F7A]  ;\ Else ([block BTS] & 40h != 0):
$A0:C995 49 0F 00    EOR #$000F             ;} A = Fh - [enemy X position] % 10h (X distance into slope)

$A0:C998 29 0F 00    AND #$000F
$A0:C99B 18          CLC                    ;\
$A0:C99C 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;} X = (slope definition table base index) + [A] (slope definition index)
$A0:C99F AA          TAX                    ;/
$A0:C9A0 BF 2B 8B 94 LDA $948B2B,x[$94:8C4B];\
$A0:C9A4 29 1F 00    AND #$001F             ;} A = [$94:8B2B + [X]] % 20h (slope top Y offset)
$A0:C9A7 38          SEC                    ;\
$A0:C9A8 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= (Y distance into slope) + 1
$A0:C9AB 3A          DEC A                  ;/
$A0:C9AC F0 02       BEQ $02    [$C9B0]     ;\
$A0:C9AE 10 0B       BPL $0B    [$C9BB]     ;} If [A] > 0 (enemy is above the slope): return

$A0:C9B0 49 FF FF    EOR #$FFFF             ;\
$A0:C9B3 1A          INC A                  ;|
$A0:C9B4 18          CLC                    ;} Enemy Y position -= [A] (bring enemy under slope)
$A0:C9B5 79 7E 0F    ADC $0F7E,y[$7E:0F7E]  ;|
$A0:C9B8 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;/

$A0:C9BB 28          PLP
$A0:C9BC FA          PLX
$A0:C9BD 7A          PLY
$A0:C9BE 6B          RTL
}
}


;;; $C9BF: Unused. Common enemy projectile speeds - linearly increasing ;;;
{
; Clone of $8187

; Subspeed, speed, negated subspeed, negated speed
$A0:C9BF             dw 0000,0000,0000,0000, 0000,1000,FFFF,F000, 0000,2000,FFFF,E000, 0000,3000,FFFF,D000,
                        0000,4000,FFFF,C000, 0000,5000,FFFF,B000, 0000,6000,FFFF,A000, 0000,7000,FFFF,9000,
                        0000,8000,FFFF,8000, 0000,9000,FFFF,7000, 0000,A000,FFFF,6000, 0000,B000,FFFF,5000,
                        0000,C000,FFFF,4000, 0000,D000,FFFF,3000, 0000,E000,FFFF,2000, 0000,F000,FFFF,1000,
                        0001,0000,FFFF,0000, 0001,1000,FFFE,F000, 0001,2000,FFFE,E000, 0001,3000,FFFE,D000,
                        0001,4000,FFFE,C000, 0001,5000,FFFE,B000, 0001,6000,FFFE,A000, 0001,7000,FFFE,9000,
                        0001,8000,FFFE,8000, 0001,9000,FFFE,7000, 0001,A000,FFFE,6000, 0001,B000,FFFE,5000,
                        0001,C000,FFFE,4000, 0001,D000,FFFE,3000, 0001,E000,FFFE,2000, 0001,F000,FFFE,1000,
                        0002,0000,FFFE,0000, 0002,1000,FFFD,F000, 0002,2000,FFFD,E000, 0002,3000,FFFD,D000,
                        0002,4000,FFFD,C000, 0002,5000,FFFD,B000, 0002,6000,FFFD,A000, 0002,7000,FFFD,9000,
                        0002,8000,FFFD,8000, 0002,9000,FFFD,7000, 0002,A000,FFFD,6000, 0002,B000,FFFD,5000,
                        0002,C000,FFFD,4000, 0002,D000,FFFD,3000, 0002,E000,FFFD,2000, 0002,F000,FFFD,1000,
                        0003,0000,FFFD,0000, 0003,1000,FFFC,F000, 0003,2000,FFFC,E000, 0003,3000,FFFC,D000,
                        0003,4000,FFFC,C000, 0003,5000,FFFC,B000, 0003,6000,FFFC,A000, 0003,7000,FFFC,9000,
                        0003,8000,FFFC,8000, 0003,9000,FFFC,7000, 0003,A000,FFFC,6000, 0003,B000,FFFC,5000,
                        0003,C000,FFFC,4000, 0003,D000,FFFC,3000, 0003,E000,FFFC,2000, 0003,F000,FFFC,1000,
                        0004,0000,FFFC,0000
}


;;; $CBC7: Common enemy projectile speeds - quadratically increasing ;;;
{
; Clone of $838F
; Used by Botwoon's body when dying and falling to the floor, and polyp rock

; Subspeed, speed, negated subspeed, negated speed
$A0:CBC7             dw 0000,0000,0000,0000, 0109,0000,FEF7,FFFF, 031B,0000,FCE5,FFFF, 0636,0000,F9CA,FFFF,
                        0A5A,0000,F5A6,FFFF, 0F87,0000,F079,FFFF, 15BD,0000,EA43,FFFF, 1CFC,0000,E304,FFFF,
                        2544,0000,DABC,FFFF, 2E95,0000,D16B,FFFF, 38EF,0000,C711,FFFF, 4452,0000,BBAE,FFFF,
                        50BE,0000,AF42,FFFF, 5E33,0000,A1CD,FFFF, 6CB1,0000,934F,FFFF, 7C38,0000,83C8,FFFF,
                        8CC8,0000,7338,FFFF, 9E61,0000,619F,FFFF, B103,0000,4EFD,FFFF, C4AE,0000,3B52,FFFF,
                        D962,0000,269E,FFFF, EF1F,0000,10E1,FFFF, 05E5,0000,FA1B,FFFF, 14B4,0001,EB4C,FFFE,
                        2D8C,0001,D274,FFFE, 476D,0001,B893,FFFE, 6257,0001,9DA9,FFFE, 7E4A,0001,81B6,FFFE,
                        9B46,0001,64BA,FFFE, B94B,0001,46B5,FFFE, D859,0001,27A7,FFFE, F870,0001,0790,FFFE,
                        1090,0002,EF70,FFFD, 32B9,0002,CD47,FFFD, 55EB,0002,AA15,FFFD, 7A26,0002,85DA,FFFD,
                        9F6A,0002,6096,FFFD, C5B7,0002,3A49,FFFD, ED0D,0002,12F3,FFFD, 0C6C,0003,F394,FFFC,
                        35D4,0003,CA2C,FFFC, 6045,0003,9FBB,FFFC, 8BBF,0003,7441,FFFC, B842,0003,47BE,FFFC,
                        E5CE,0003,1A32,FFFC, 0B63,0004,F49D,FFFB, 3B01,0004,C4FF,FFFB, 6BA8,0004,9458,FFFB,
                        9D58,0004,62A8,FFFB, D011,0004,2FEF,FFFB, 03D3,0004,FC2D,FFFB, 2F9E,0005,D062,FFFA,
                        6572,0005,9A8E,FFFA, 9C4F,0005,63B1,FFFA, D435,0005,2BCB,FFFA, 0424,0006,FBDC,FFF9,
                        3E1C,0006,C1E4,FFF9, 791D,0006,86E3,FFF9, B527,0006,4AD9,FFF9, F23A,0006,0DC6,FFF9,
                        2756,0007,D8AA,FFF8, 667B,0007,9985,FFF8, A6A9,0007,5957,FFF8, E7E0,0007,1820,FFF8,
                        2120,0008,DEE0,FFF7, 6469,0008,9B97,FFF7, A8BB,0008,5745,FFF7, EE16,0008,11EA,FFF7,
                        2B7A,0009,D486,FFF6, 72E7,0009,8D19,FFF6, BB5D,0009,44A3,FFF6, 04DC,0009,FB24,FFF6,
                        4664,000A,B99C,FFF5, 91F5,000A,6E0B,FFF5, DE8F,000A,2171,FFF5, 2332,000B,DCCE,FFF4,
                        71DE,000B,8E22,FFF4, C193,000B,3E6D,FFF4, 0951,000C,F6AF,FFF3, 5B18,000C,A4E8,FFF3,
                        ADE8,000C,5218,FFF3, 01C1,000C,FE3F,FFF3, 4DA3,000D,B25D,FFF2, A38E,000D,5C72,FFF2,
                        FA82,000D,057E,FFF2, 497F,000E,B681,FFF1, A285,000E,5D7B,FFF1, FC94,000E,036C,FFF1,
                        4EAC,000F,B154,FFF0, AACD,000F,5533,FFF0, 07F7,000F,F809,FFF0, 5D2A,0010,A2D6,FFEF,
                        BC66,0010,439A,FFEF, 13AB,0011,EC55,FFEE, 74F9,0011,8B07,FFEE
}


;;; $CEBF: Enemy headers ;;;
{
;                        _________________________________________________________________________________________________________________________________________________________________________________________ 0: Tile data size
;                       |      ___________________________________________________________________________________________________________________________________________________________________________________ 2: Palette
;                       |     |      _____________________________________________________________________________________________________________________________________________________________________________ 4: Health
;                       |     |     |      _______________________________________________________________________________________________________________________________________________________________________ 6: Damage
;                       |     |     |     |      _________________________________________________________________________________________________________________________________________________________________ 8: Width
;                       |     |     |     |     |      ___________________________________________________________________________________________________________________________________________________________ Ah: Height
;                       |     |     |     |     |     |      _____________________________________________________________________________________________________________________________________________________ Ch: Bank
;                       |     |     |     |     |     |     |    _________________________________________________________________________________________________________________________________________________ Dh: Hurt AI time
;                       |     |     |     |     |     |     |   |    _____________________________________________________________________________________________________________________________________________ Eh: Cry
;                       |     |     |     |     |     |     |   |   |      _______________________________________________________________________________________________________________________________________ 10h: Boss ID
;                       |     |     |     |     |     |     |   |   |     |      _________________________________________________________________________________________________________________________________ 12h: Initialisation AI
;                       |     |     |     |     |     |     |   |   |     |     |      ___________________________________________________________________________________________________________________________ 14h: Number of parts
;                       |     |     |     |     |     |     |   |   |     |     |     |      _____________________________________________________________________________________________________________________ 16h: Unused. Set to 1 by zoomer, stone zoomer, red ninja space pirate
;                       |     |     |     |     |     |     |   |   |     |     |     |     |      _______________________________________________________________________________________________________________ 18h: Main AI
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |      _________________________________________________________________________________________________________ 1Ah: Grapple AI
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |      ___________________________________________________________________________________________________ 1Ch: Hurt AI
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |      _____________________________________________________________________________________________ 1Eh: Frozen AI
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |      _______________________________________________________________________________________ 20h: Time is frozen AI
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |      _________________________________________________________________________________ 22h: Death animation
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |      ___________________________________________________________________________ 24h: Unused
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |          _________________________________________________________________ 28h: Power bomb reaction
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |      ___________________________________________________________ 2Ah: Sidehopper variant index. Unused proto instruction list (see $A0:AE7C) for flies, (multi)viola, ripper (ii), Ceres door
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |      _____________________________________________________ 2Ch: Unused
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |          ___________________________________________ 30h: Enemy touch
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |      _____________________________________ 32h: Enemy shot
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |      _______________________________ 34h: Unused. Spritemap pointer tables for flies, ripper, skultera, Ceres door (whose table is missing)
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |     |      _________________________ 36h: Tile data
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |     |     |        _________________ 39h: Layer
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |     |     |       |    _____________ 3Ah: Drop chances ($B4)
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |     |     |       |   |      _______ 3Ch: Vulnerabilities ($B4)
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |     |     |       |   |     |      _ 3Eh: Enemy name ($B4)
;                       |     |     |     |     |     |     |   |   |     |     |     |     |     |     |     |     |     |     |     |         |     |     |         |     |     |     |       |   |     |     |
;                       0     2     4     6     8     Ah    Ch  Dh  Eh    10h   12h   14h   16h   18h   1Ah   1Ch   1Eh   20h   22h   24h       28h   2Ah   2Ch       30h   32h   34h   36h     39h 3Ah   3Ch   3Eh
$A0:CEBF             dx 0400, 8687, 03E8, 000A, 0008, 0008, A2, 00, 0000, 0000, 871C, 0001, 0000, 879C, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, ACB600, 05, F320, EDA8, DDEB ; Boyon
$A0:CEFF             dx 0400, 8912, 0014, 0028, 0008, 0008, A2, 00, 0053, 0000, 89AD, 0001, 0000, 89F0, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, ACD000, 05, F3B6, EC1C, E15D ; Mini-Crocomire
$A0:CF3F             dx 0C00, 8B60, 4E20, 00C8, 0014, 0010, A2, 00, 0000, 0000, 8D6C, 0005, 0000, 8DD2, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 9281, 802D, 0000, ACD400, 05, F3BC, EEC6, DF11 ; Tatori
$A0:CF7F             dx 0C00, 8B60, 4E20, 0000, 0008, 0005, A2, 00, 0000, 0000, 8D9D, 0001, 0000, 912E, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 929F, 930F, 0000, ACD400, 05, F3BC, EEC6, 0000 ; Mini-tatori
$A0:CFBF             dx 0200, 998D, 0064, 003C, 0008, 0004, A2, 00, 0000, 0000, 9A3F, 0001, 0000, 9A7D, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, ACE400, 05, F20C, EC1C, E053 ; Puyo
$A0:CFFF             dx 0400, 9E6A, 003C, 0014, 0008, 0008, A2, 00, 0000, 0000, 9F48, 0001, 0000, 9FB3, 800A, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, ACE600, 05, F2BA, EC1C, E0C3 ; Cacatac
$A0:D03F             dx 0400, A38B, 0014, 0064, 0008, 0008, A2, 00, 003E, 0000, A3F9, 0001, 0000, A47E, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, A579, 0000, ACEA00, 05, F34A, EE84, E16B ; Owtch
$A0:D07F             dx 1000, A59E, 0014, 0028, 005C, 0028, A2, 00, 0000, 0000, A644, 0001, 0000, A759, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, ADB600, 02, F3C2, EC1C, 0000 ; Gunship top
$A0:D0BF             dx 0200, A59E, 0014, 0028, 0060, 0028, A2, 00, 0000, 0000, A6D2, 0001, 0000, 804C, 800F, 804C, 804C, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, ADB600, 02, F3C2, EC1C, 0000 ; Gunship bottom / entrance pad
$A0:D0FF             dx 0400, AFF3, 0009, 0008, 0008, 0004, A2, 00, 0020, 0000, B06B, 0001, 0000, B11F, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, B013, 00000000, 8023, 802D, B204, AEA600, 05, F236, EC1C, DF81 ; Mellow
$A0:D13F             dx 0400, B20C, 001E, 0010, 0008, 0004, A2, 00, 0020, 0000, B06B, 0001, 0000, B11F, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, B22C, 00000000, 8023, 802D, B25C, AEC920, 05, F23C, EE00, DF65 ; Mella
$A0:D17F             dx 0400, B264, 0064, 003C, 0008, 0008, A2, 00, 0020, 0000, B06B, 0001, 0000, B11F, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, B284, 00000000, 8023, 802D, B2B4, AECD20, 05, F242, EC1C, DF73 ; Memu
$A0:D1BF             dx 0400, B2BC, 005A, 0032, 0008, 0008, A2, 00, 003E, 0000, B3E0, 0001, 0000, B40F, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, B2DC, 00000000, 8023, 802D, 0000, AEB400, 05, F362, EE6E, DFB9 ; Multiviola
$A0:D1FF             dx 0600, BA5B, 0001, 0004, 0004, 0004, A2, 00, 0000, 0000, B570, 0001, 0000, B58F, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEB800, 05, F48E, EEC6, E029 ; Polyp
$A0:D23F             dx 0600, BA5B, 000A, 0028, 0008, 0008, A2, 00, 0000, 0000, B602, 0001, 0000, B7C4, 800F, 804C, B929, 0000, 0000, 00000000, B953, 0000, 00000000, B947, B94D, 0000, AEB800, 02, F374, EC1C, E06F ; Rinka
$A0:D27F             dx 0400, BA7B, 002D, 000F, 0010, 0007, A2, 00, 0036, 0000, BBCD, 0001, 0000, BBE3, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEB000, 05, F1FA, EC1C, E07D ; Rio
$A0:D2BF             dx 0400, BE1C, 012C, 0032, 0008, 000C, A2, 00, 0036, 0000, BE99, 0002, 0000, BED2, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEBD20, 05, F35C, EDEA, E141 ; Squeept
$A0:D2FF             dx 0600, C0D1, 0078, 003C, 0010, 0009, A2, 00, 0036, 0000, C242, 0002, 0000, C277, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AED520, 05, F1F4, EE42, DE85 ; Geruta
$A0:D33F             dx 0800, C5FA, 0384, 0078, 0010, 000A, A2, 00, 005F, 0000, C6F3, 0002, 0000, C724, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AED920, 05, F356, EE58, DED9 ; Holtz
$A0:D37F             dx 0800, CA2B, 012C, 0064, 0010, 0010, A2, 00, 0000, 0000, CCD4, 0001, 0000, CD13, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, D38C, D3B4, 0000, AF8000, 05, F338, EEC6, DFFF ; Oum
$A0:D3BF             dx 0400, D80C, 0064, 0050, 0010, 0005, A2, 00, 0022, 0000, DF76, 0001, 0000, E02E, 800A, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, ACE000, 05, F21E, EC1C, DECB ; Choot
$A0:D3FF             dx 0400, E17B, 00C8, 000A, 0008, 0008, A2, 00, 003E, 0000, E1D3, 0001, 0000, E221, 8005, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, E3A9, 0000, AEC520, 05, F2C6, EF4A, E099 ; Gripper
$A0:D43F             dx 0400, E2C0, 00C8, 000A, 0008, 0004, A2, 00, 003E, 0000, E318, 0001, 0000, E353, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, E477, 00000000, 8023, E3A9, 0000, AEC520, 05, F2C6, EDEA, E099 ; Ripper ii
$A0:D47F             dx 0400, E457, 00C8, 0005, 0008, 0004, A2, 00, 003E, 0000, E49F, 0001, 0000, E4DA, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, E477, 00000000, 8023, 802D, E56F, AEC520, 05, F308, EDEA, E08B ; Ripper
$A0:D4BF             dx 0600, E57B, 012C, 0018, 0008, 001C, A2, 00, 0036, 0000, E606, 0002, 0000, E64E, 800F, 804C, 8041, 0000, 0004, 00000000, E7D4, 0000, 00000000, E7C8, E7CE, 0000, AEA000, 05, F368, EE16, DE15 ; Dragon
$A0:D4FF             dx 0400, E978, 0014, 0028, 0008, 0008, A2, 00, 0000, 0000, E9DA, 0001, 0000, EAB6, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 802D, 0000, ACBA00, 05, F4A0, EF08, E0FB ; Growing shutter
$A0:D53F             dx 0400, E978, 0014, 0028, 0008, 0020, A2, 00, 0000, 0000, EE12, 0001, 0000, EED1, 800F, 804C, 8041, 0000, 0000, 00000000, F0B6, 0000, 00000000, F09D, F0A2, 0000, ACBA00, 05, F4A0, EF08, E109 ; Shootable shutter
$A0:D57F             dx 0400, E978, 0014, 0028, 0020, 0008, A2, 00, 0000, 0000, F111, 0001, 0000, F1DE, 800F, 804C, 8041, 0000, 0000, 00000000, F41A, 0000, 00000000, F3D8, F40E, 0000, ACBA00, 05, F4A0, EF08, E109 ; Horizontal shutter
$A0:D5BF             dx 0400, E978, 0014, 0028, 0008, 0020, A2, 00, 0000, 0000, EE12, 0001, 0000, EED1, 800F, 804C, 8041, 0000, 0000, 00000000, F0B6, 0000, 00000000, F09D, F0AA, 0000, ACBA00, 05, F4A0, EFB8, E109 ; Destroyable shutter
$A0:D5FF             dx 0400, EDC7, 0014, 0028, 0010, 0008, A2, 00, 0000, 0000, EE05, 0001, 0000, EED1, 800F, 804C, 8041, 0000, 0000, 00000000, F0B6, 0000, 00000000, F09D, F0A2, 0000, B18000, 05, F4A0, EF08, E109 ; Up/down mover platform

$A0:D63F             dx 0600, 8687, 001E, 000A, 0008, 0008, A3, 00, 0047, 0000, 86ED, 0001, 0000, 874C, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AE8600, 05, F200, EC1C, E187 ; Waver
$A0:D67F             dx 0600, 88F0, 0032, 0032, 0008, 000C, A3, 00, 0021, 0000, 8960, 0001, 0000, 8979, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 8B0F, 0000, AF9200, 05, F314, EDBE, DF8F ; Metaree
$A0:D6BF             dx 0600, 8C0F, 0014, 0004, 0008, 0008, A3, 00, 0020, 0000, 8D2D, 0001, 0000, 8DEE, 800F, 804C, 8041, 0000, 0000, 00000000, 8E83, 0000, 00000000, 8E6B, 8E89, 0000, AFA800, 05, F2E4, EC1C, DEE7 ; Fireflea
$A0:D6FF             dx 0600, 900A, 012C, 0050, 000D, 000B, A3, 00, 0049, 0000, 90B5, 0001, 0000, 912B, 8000, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 94AA, AFBC00, 05, F332, EC1C, DE4D ; Skultera
$A0:D73F             dx 0000, 0000, 0028, 000F, 0010, 0008, A3, 00, 0059, 0000, 94E6, 0001, 0000, 952A, 952A, 804C, 952A, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, 000000, 05, 0000, 0000, 0000 ; Elevator
$A0:D77F             dx 0400, 965B, 00C8, 0078, 0008, 0008, A3, 00, 0049, 0000, 96E3, 0001, 0000, E6C2, 800A, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B1B600, 05, F2D8, EF76, DF2D ; Sciser
$A0:D7BF             dx 0400, 980B, 0032, 0028, 0008, 0008, A3, 00, 0023, 0000, 993B, 0001, 0000, E6C2, 800A, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B1C800, 05, F2F0, EF76, E00D ; Zero
$A0:D7FF             dx 0400, 9B7B, 0014, 0028, 0010, 0008, A3, 00, 003E, 0000, 9CBA, 0001, 0000, 9D16, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 9F07, 9F08, 0000, AC9800, 05, F30E, EDEA, DF1F ; Tripper
$A0:D83F             dx 0400, 9B9B, 0014, 0028, 0010, 0008, A3, 00, 003E, 0000, 9C9F, 0001, 0000, 9D16, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 9F07, 802D, 0000, B18000, 05, F30E, EEC6, DF1F ; Suspensor platform
$A0:D87F             dx 0200, A051, 0014, 0028, 0004, 0004, A3, 00, 0000, 0000, A14D, 0001, 0000, A2D0, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AC8000, 05, F47C, EEC6, E0D1 ; Roach
$A0:D8BF             dx 8200, A051, 0014, 0028, 0004, 0004, A3, 00, 0000, 0000, A14D, 0001, 0000, A2D0, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AC8000, 05, F47C, EEC6, E0D1 ; Roach, unused/broken
$A0:D8FF             dx 0400, A725, 0064, 005A, 000A, 000C, A3, 00, 0058, 0000, A77D, 0001, 0000, A790, 800A, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, A953, A9A8, 0000, AC9400, 05, F218, EC1C, DF9D ; Mochtroid
$A0:D93F             dx 0400, AA48, 003C, 0014, 0010, 000D, A3, 00, 0023, 0000, AB09, 0001, 0000, ABCF, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, ABAC00, 05, F326, EC1C, E14F ; Sidehopper
$A0:D97F             dx 0400, AF85, 0078, 0050, 0010, 000D, A3, 00, 005F, 0000, AB09, 0001, 0000, ABCF, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0003, 00000000, 8023, 802D, 0000, ABB000, 05, F2DE, EC1C, E0ED ; Desgeega
$A0:D9BF             dx 0600, B085, 0140, 0050, 0018, 0014, A3, 00, 0023, 0000, AB09, 0001, 0000, ABCF, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0001, 00000000, 8023, 802D, 0000, AEAA00, 05, F32C, EC1C, E117 ; Super-sidehopper
$A0:D9FF             dx 0600, B0A5, 05DC, 0078, 0018, 0014, A3, 00, 0023, 0000, AB09, 0001, 0000, ABCF, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0001, 00000000, 8023, 802D, 0000, AEAA00, 05, F32C, F07E, E117 ; Tourian super-sidehopper
$A0:DA3F             dx 0400, B217, 0320, 00A0, 0018, 0014, A3, 00, 0030, 0000, AB09, 0001, 0000, ABCF, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0002, 00000000, 8023, 802D, 0000, AED120, 05, F28A, EC32, DDF9 ; Super-desgeega
$A0:DA7F             dx 0400, B3A1, 0028, 000F, 0008, 0008, A3, 00, 0049, 0000, B44A, 0001, 0000, B47C, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AFE800, 05, F260, EC1C, E1CD ; Zoa
$A0:DABF             dx 0400, B5B3, 001E, 000F, 0008, 0008, A3, 00, 005F, 0000, B66F, 0001, 0000, E6C2, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, B5D3, 00000000, 8023, 802D, 0000, AEF920, 05, F2CC, EC48, E179 ; Viola
$A0:DAFF             dx 0000, 8069, 0000, 0000, 0008, 0008, A3, 00, 0059, 0000, 804C, 0001, 0000, 804C, 800F, 804C, 804C, 0000, 0000, 00000000, 0000, 0000, 00000000, 804C, 804C, 0000, AE9000, 00, 0000, 0000, 0000 ; Respawning enemy placeholder
$A0:DB3F             dx 1000, B702, 000A, 0004, 0010, 0010, A3, 00, 0056, 0000, BAB3, 0003, 0000, BB25, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 8023, BEFD, 0000, AF9800, 05, F380, F010, DDA5 ; Bang
$A0:DB7F             dx 0400, C63E, 000F, 000A, 0008, 000C, A3, 00, 0021, 0000, C6AE, 0001, 0000, C6C7, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, C7F5, 0000, AE8C00, 05, F206, EC1C, E125 ; Skree
$A0:DBBF             dx 0800, C8A6, 000A, 0064, 0008, 0008, A3, 00, 003E, 0000, CDE2, 0001, 0000, CE64, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, D3B0, D469, 0000, AFB400, 05, F33E, EC48, E195 ; Yard
$A0:DBFF             dx 0600, DA9C, 00C8, 001E, 0010, 0010, A3, 00, 0057, 0000, DBD3, 0001, 0000, DC1B, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 804C, DC1C, 0000, AFAE00, 05, F31A, EEC6, E061 ; Reflec
$A0:DC3F             dx 0600, DFA2, 000F, 0005, 0008, 0008, A3, 00, 0023, 0000, E043, 0001, 0000, E08B, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AE8000, 05, F2FC, EC48, DEF5 ; Wrecked Ship orange zoomer
$A0:DC7F             dx 0600, E23C, 001E, 000A, 0008, 0008, A3, 00, 0023, 0000, E2D4, 0001, 0000, E6C2, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEED20, 05, F22A, EC48, E1BF ; Zeela
$A0:DCBF             dx 0600, E57C, 0028, 0014, 0008, 0008, A3, 00, 0023, 0000, E59C, 0001, 0000, E6C2, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEF320, 05, F230, EC48, DFF1 ; Sova
$A0:DCFF             dx 0600, E5B0, 000F, 0005, 0008, 0008, A3, 00, 0023, 0000, E669, 0001, 0001, E6C2, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AE8000, 05, F224, EC48, E1DB ; Zoomer
$A0:DD3F             dx 0600, E5D0, 000F, 0005, 0008, 0008, A3, 00, 0023, 0000, E669, 0001, 0001, E6C2, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AE8000, 05, F302, EDD4, DFC7 ; Stone zoomer
$A0:DD7F             dx 1000, E9AF, 01F4, 0078, 000A, 000A, A3, 00, 005A, 0000, EA4F, 0001, 0000, EB98, 800F, EB33, EAE6, 0000, 0004, 00000000, F042, 0000, 00000000, EDEB, EF07, 0000, AE9000, 05, F36E, EF60, DFAB ; Metroid

$A0:DDBF             dx A600, B87D, 7FFF, 0028, 0030, 0038, A4, 00, 0005, 0006, 8A5A, 0001, 0000, 8C04, 8005, 8687, 8041, 0000, 0000, 00000000, B992, 0000, 00000000, B950, 0000, 0000, AD8000, 05, F42E, F102, 0000 ; Crocomire
$A0:DDFF             dx 2000, B87D, 7FFF, 0028, 0008, 0008, A4, 00, 0000, 0006, F67A, 0001, 0000, F6BB, 8005, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AD8000, 05, F428, F102, 0000 ; Crocomire tongue

$A0:DE3F             dx 2000, A1F7, 1770, 00A0, 0040, 0040, A5, 04, 0000, 0008, 8687, 0001, 0000, 86FC, 8000, 954D, 8041, 0000, 0000, 00000000, 9607, 0000, 00000000, 95EA, 95F0, 0000, B0C800, 05, F440, F144, 0000 ; Draygon body
$A0:DE7F             dx 1800, 8069, 1770, 00A0, 0002, 0002, A5, 00, 0000, 0000, C46B, 0001, 0000, C486, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, B0C800, 05, F446, F144, 0000 ; Draygon eye
$A0:DEBF             dx 1800, A1F7, 1770, 00A0, 0010, 0020, A5, 00, 0000, 0000, C599, 0001, 0000, C5AA, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 8023, 802D, 0000, B0C800, 05, F440, F144, 0000 ; Draygon tail
$A0:DEFF             dx 1800, A1F7, 1770, 00A0, 0018, 0018, A5, 00, 0000, 0000, C5AD, 0001, 0000, C5C4, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, B0C800, 05, F440, F144, 0000 ; Draygon arms
$A0:DF3F             dx 0E00, E359, 03C0, 000C, 0030, 0020, A5, 04, 002C, 0004, EA2A, 0001, 0000, EB13, 800F, 804C, 8041, 0000, 0000, 00000000, EDF2, 0000, 00000000, EDEC, ED5A, 0000, AC9C00, 02, F410, F094, 0000 ; Spore Spawn
$A0:DF7F             dx 0E00, E359, 03C0, 000C, 0013, 0013, A5, 08, 0000, 0004, EA2A, 0001, 0000, EB13, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, EDEC, ED5A, 0000, AC9C00, 05, F416, F094, 0000 ; Spore Spawn

$A0:DFBF             dx 1000, 8687, 0014, 0028, 0010, 0010, A6, 00, 0000, 0000, 86F5, 0001, 0000, 8793, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AB9C00, 05, F46A, EEDC, E0B5 ; Boulder
$A0:DFFF             dx 0400, 8B09, 01F4, 00C8, 0010, 000C, A6, 00, 0000, 0000, 8B2F, 0002, 0000, 8BAD, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 804C, 0000, AB9800, 05, F470, EEC6, DF49 ; Spike platform top
$A0:E03F             dx 0200, 8B09, 01F4, 00C8, 0010, 0002, A6, 00, 0000, 0000, 8B85, 0001, 0000, 8B99, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 804C, 0000, AB9800, 05, F470, EEC6, 0000 ; Spike platform bottom
$A0:E07F             dx 0800, 8CFB, 0014, 001E, 0008, 0008, A6, 00, 0000, 0000, 8FFC, 0002, 0000, 9023, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 804C, 0000, AB9000, 05, F476, EEC6, DEBD ; Fire pillar
$A0:E0BF             dx 0800, 9470, 0028, 0032, 0008, 0008, A6, 00, 0000, 0000, 94C4, 0001, 0000, 960E, 8000, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 804C, 0000, AB9000, 05, F464, EEC6, E037 ; Fire arc
$A0:E0FF             dx 1000, 998C, 0190, 0064, 0020, 0018, A6, 00, 0000, 0000, 9A58, 0001, 0000, 9AC2, 800F, 804C, 8041, 0000, 0003, 00000000, 9C39, 0000, 00000000, 9C22, 9C39, 0000, AB8000, 05, F2C0, EFFA, E0DF ; Fake Kraid
$A0:E13F             dx 2000, E14F, 7FFF, 0005, 0008, 0008, A6, 08, 0000, 0001, A0F5, 0001, 0000, A288, 800F, A2D3, 8041, 0000, 0000, 00000000, DFB2, 0000, 00000000, 8023, DF8A, 0000, B09400, 05, F44C, F1B2, 0000 ; Ceres Ridley
$A0:E17F             dx 2000, E14F, 4650, 00A0, 0008, 0008, A6, 08, 0000, 0005, A0F5, 0001, 0000, B227, 800F, B297, 8041, B28A, 0000, 00000000, DFB2, 0000, 00000000, 8023, DF8A, 0000, B09400, 02, F44C, F1B2, 0000 ; Ridley
$A0:E1BF             dx 8400, E1AF, 4650, 00A0, 0008, 0008, A6, 00, 0000, 0000, C696, 0001, 0000, C8D4, 800F, 804C, 804C, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, B0B400, 05, 0000, EEC6, 0000 ; Ridley explosion
$A0:E1FF             dx 0000, E23F, 7FFF, 0000, 0008, 0008, A6, 00, 0000, 0000, EFB1, 0001, 0000, F00D, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, F03F, 804C, 0000, A0E23F, 05, F488, EEC6, 0000 ; Ceres steam
$A0:E23F             dx 8600, F4EC, 0028, 000F, 0008, 0020, A6, 00, 0059, 0000, F6C5, 0001, 0000, F765, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, F52C, 00000000, F920, F920, FB72, B0BA00, 02, 0000, 0000, 0000 ; Ceres door
$A0:E27F             dx 0000, 0000, 03E8, 0000, 0008, 0018, A6, 00, 0000, 0000, FB72, 0001, 0000, FC33, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, FDA7, FDAC, 0000, B78000, 05, 0000, F068, 0000 ; Zebetites

$A0:E2BF             dx 1E00, 8687, 03E8, 0014, 0038, 0090, A7, 00, 0000, 0003, A959, 0001, 0000, AC21, 800F, 804C, 8041, 0000, 0000, 00000000, 803C, 0000, 00000000, 949F, 804C, 0000, ABCC00, 05, F41C, F15A, 0000 ; Kraid
$A0:E2FF             dx 1E00, 8687, 03E8, 0014, 0030, 0030, A7, 00, 0000, 0000, AB43, 0001, 0000, B7BD, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 9490, 94B5, 0000, ABCC00, 05, 0000, F170, 0000 ; Kraid arm
$A0:E33F             dx 1E00, 8687, 03E8, 000A, 0018, 0008, A7, 00, 0000, 0000, AB68, 0001, 0000, B801, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 948F, 802D, 0000, ABCC00, 05, 0000, F186, 0000 ; Kraid top lint
$A0:E37F             dx 1E00, 8687, 03E8, 000A, 0018, 0008, A7, 00, 0000, 0000, AB9C, 0001, 0000, B80D, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 948F, 802D, 0000, ABCC00, 05, 0000, F186, 0000 ; Kraid middle lint
$A0:E3BF             dx 1E00, 8687, 03E8, 000A, 0018, 0008, A7, 00, 0000, 0000, ABCA, 0001, 0000, B819, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 948F, 802D, 0000, ABCC00, 05, 0000, F186, 0000 ; Kraid bottom lint
$A0:E3FF             dx 1E00, 8687, 03E8, 0014, 0008, 0008, A7, 00, 0000, 0000, ABF8, 0001, 0000, B9F6, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 948F, 94B5, 0000, ABCC00, 05, F422, F170, 0000 ; Kraid foot
$A0:E43F             dx 1E00, 8687, 000A, 000A, 0008, 0008, A7, 00, 0000, 0000, BCEF, 0001, 0000, BD32, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, BCCF, 802D, 0000, ABCC00, 05, F422, F19C, 0000 ; Kraid good fingernail
$A0:E47F             dx 1E00, 8687, 000A, 000A, 0008, 0008, A7, 00, 0000, 0000, BD2D, 0001, 0000, BD49, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, BCDE, 802D, 0000, ABCC00, 05, 0000, F19C, 0000 ; Kraid bad fingernail
$A0:E4BF             dx 0C00, CA01, 09C4, 0028, 0008, 0008, A7, 08, 0000, 0007, CDF3, 0001, 0000, CEA6, 8000, DD3F, 804C, 0000, 0000, 00000000, DD9A, 0000, 00000000, DD95, DD9B, 0000, ACAA00, 05, F434, F0EC, 0000 ; Phantoon body
$A0:E4FF             dx 0400, CA01, 09C4, 0028, 0008, 0008, A7, 00, 0000, 0000, CE55, 0001, 0000, 804C, 8000, 804C, 804C, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, ACAA00, 05, F43A, F0EC, 0000 ; Phantoon eye
$A0:E53F             dx 0400, CA01, 09C4, 0028, 0008, 0008, A7, 00, 0000, 0000, CE55, 0001, 0000, E011, 8000, 804C, 804C, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, ACAA00, 05, F434, F0EC, 0000 ; Phantoon tentacles
$A0:E57F             dx 0400, CA01, 09C4, 0028, 0008, 0008, A7, 00, 0000, 0000, CE55, 0001, 0000, E011, 8000, 804C, 804C, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, ACAA00, 05, F434, F0EC, 0000 ; Phantoon mouth
$A0:E5BF             dx 0600, E7FE, 7FFF, 0000, 0006, 0007, A7, 00, 0000, 0000, E912, 0001, 0000, E940, 8000, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, AC8200, 05, F482, 0000, 0000 ; Etecoon
$A0:E5FF             dx 0C00, F225, 7FFF, 0000, 0008, 0018, A7, 00, 0000, 0000, F4DD, 0001, 0000, F52E, 8000, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, AC8800, 05, F488, 0000, 0000 ; Dachora

$A0:E63F             dx 0600, 8687, 012C, 0064, 0010, 0014, A8, 00, 004A, 0000, 87E0, 0003, 0000, 891B, 800F, 804C, 8041, 0000, 0004, 00000000, 8B0C, 0000, 00000000, 8B06, 8B12, 0000, B19400, 05, F350, EFCE, DE23 ; Evir
$A0:E67F             dx 0600, 8687, 012C, 0064, 0008, 0008, A8, 00, 0000, 0000, 88B0, 0001, 0000, 899E, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 8023, 804C, 0000, B19400, 05, F350, EFE4, 0000 ; Evir projectile
$A0:E6BF             dx 0400, 8F8C, 0014, 0000, 0008, 0008, A8, 00, 0000, 0000, 9058, 0002, 0000, 90E2, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 804C, 0000, B19A00, 05, F3CE, EEC6, DE31 ; Morph ball eye
$A0:E6FF             dx 0800, 9379, 0014, 000A, 0010, 0010, A8, 00, 0000, 0000, 96E3, 0001, 0000, 9730, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B19E00, 05, F3D4, EEB0, E2BB ; Fune
$A0:E73F             dx 0800, 959D, 0014, 000A, 0010, 0010, A8, 00, 0000, 0000, 96E3, 0003, 0000, 9730, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B19E00, 05, F3DA, EEF2, DE3F ; Namihe
$A0:E77F             dx 0400, 99AC, 012C, 003C, 0010, 0010, A8, 00, 0051, 0000, 9AEE, 0001, 0000, 9B3C, 8000, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B1A600, 05, F266, EC1C, DE5B ; Coven
$A0:E7BF             dx 0400, 9F4F, 0014, 001E, 0008, 0008, A8, 00, 003E, 0000, A148, 0001, 0000, A211, 800F, 804C, A835, 0000, 0004, 00000000, 0000, 0000, 00000000, A799, A7BD, 0000, B1AA00, 05, F3E0, EE9A, DEAF ; Yapping maw
$A0:E7FF             dx 0800, AAFE, 0640, 0000, 0010, 0010, A8, 00, 0000, 0000, AB46, 0009, 0000, AB75, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 8023, AB83, 0000, B1AE00, 05, F26C, F026, DF03 ; Kago
$A0:E83F             dx 0600, AC1C, 0014, 0028, 0008, 0008, A8, 00, 0000, 0000, AF8B, 0003, 0000, B10A, 800F, 804C, 8041, 0000, 0004, 00000000, B400, 0000, 00000000, B406, B40C, 0000, B1BC00, 05, F3E6, EEB0, DF57 ; Magdollite
$A0:E87F             dx 0600, B65E, 003C, 000A, 0008, 0008, A8, 00, 0055, 0000, B776, 0001, 0000, B80D, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, BE2E, BEAC, 0000, B1C200, 05, F2F6, EF8C, DFE3 ; Beetom
$A0:E8BF             dx 0400, C143, 000A, 0064, 0008, 0010, A8, 00, 006A, 0000, C1C9, 0002, 0000, C21C, 8014, 804C, 8041, 0000, 0002, 00000000, C63F, 0000, 00000000, C5BE, C5EF, 0000, B1CC00, 05, F2B4, EF34, E045 ; Powamp
$A0:E8FF             dx 0C00, C6B3, 0320, 0050, 000C, 0020, A8, 00, 0068, 0000, CB77, 0001, 0000, CC36, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, D174, D192, 0000, B1D000, 05, F3EC, EEC6, E0A7 ; Work robot
$A0:E93F             dx 0C00, C6B3, 01C2, 0050, 000C, 0020, A8, 00, 0068, 0000, CBCC, 0001, 0000, CC66, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, D174, D18D, 0000, B1D000, 05, F3F2, EEC6, E2E5 ; Work robot deactivated
$A0:E97F             dx 0600, D821, 0064, 000A, 0008, 0008, A8, 00, 0000, 0000, D8C9, 0001, 0000, D90B, 800A, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, DB14, 0000, B1DC00, 05, F2D2, EFA2, E01B ; Bull
$A0:E9BF             dx 0800, DBC7, 00C8, 0032, 0008, 0018, A8, 00, 005F, 0000, DCCD, 0001, 0000, DD6B, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B1E200, 05, F2EA, EE2C, DFD5 ; Alcoon
$A0:E9FF             dx 0400, E230, 00FA, 0028, 0008, 0008, A8, 00, 003E, 0000, E388, 0001, 0000, E3C3, 800F, 804C, 8041, 0000, 0002, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B1FC00, 05, F212, EC1C, DD97 ; Atomic
$A0:EA3F             dx 0200, E587, 0050, 001E, 0008, 0008, A8, 00, 0000, 0000, E637, 0001, 0000, E68E, 801E, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, E70E, 0000, B1EA00, 05, F458, EEC6, E133 ; Wrecked Ship spark
$A0:EA7F             dx 0200, E7AC, 0014, 0000, 0008, 0008, A8, 00, 0000, 0000, E82E, 0001, 0000, E8AE, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 804C, E91D, 0000, B1BA00, 02, F45E, EEC6, DF3B ; Blue Brinstar face block
$A0:EABF             dx 1000, E99A, 003C, 0014, 0008, 0012, A8, 00, 0066, 0000, F188, 0002, 0000, F25C, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 8023, F701, 0000, B1EC00, 05, F272, ED66, DEA1 ; Green ki-hunter
$A0:EAFF             dx 0200, E99A, 003C, 0014, 000A, 000A, A8, 00, 0066, 0000, F214, 0001, 0000, F262, 800F, 804C, 8041, 0000, 0004, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, B1EC00, 05, F272, ED66, 0000 ; Green ki-hunter wings
$A0:EB3F             dx 1000, E9BA, 0168, 003C, 0008, 0012, A8, 00, 0066, 0000, F188, 0002, 0000, F25C, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 8023, F701, 0000, B1EC00, 05, F278, ED7C, E2C9 ; Yellow ki-hunter
$A0:EB7F             dx 0200, E9BA, 0168, 003C, 000A, 000A, A8, 00, 0066, 0000, F214, 0001, 0000, F262, 800F, 804C, 8041, 0000, 0004, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, B1EC00, 05, F278, ED7C, 0000 ; Yellow ki-hunter wings
$A0:EBBF             dx 1000, E9DA, 0708, 00C8, 0008, 0012, A8, 00, 0066, 0000, F188, 0002, 0000, F25C, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 8023, F701, 0000, B1EC00, 05, F27E, ED92, E2D7 ; Red ki-hunter
$A0:EBFF             dx 0200, E9DA, 0708, 00C8, 000A, 000A, A8, 00, 0066, 0000, F214, 0001, 0000, F262, 800F, 804C, 8041, 0000, 0004, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, B1EC00, 05, F27E, ED92, 0000 ; Red ki-hunter wings

$A0:EC3F             dx 1000, 9472, 4650, 0078, 0010, 0010, A9, 00, 0000, 000A, 8705, 0001, 0000, 878B, 800F, 878B, 8041, 0000, 0000, 00000000, 8787, 0000, 00000000, B5C6, B507, 0000, B78000, 05, F49A, F1C8, 0000 ; Mother Brain brain
$A0:EC7F             dx 8600, 9472, 4650, 0078, 0008, 0008, A9, 00, 0000, 0000, 8687, 0001, 0000, 873E, 800F, 873E, 8041, 0000, 0000, 00000000, 8787, 0000, 00000000, B5C5, B503, 0000, B0E800, 05, F3F8, F1DE, 0000 ; Mother Brain body
$A0:ECBF             dx 0000, F8E6, 0C80, 0028, 0024, 0024, A9, 00, 0000, 0000, C710, 0001, 0000, C779, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, CF03, 804C, 0000, B18400, 02, F4A0, EC1C, 0000 ; Shitroid in cutscene
$A0:ECFF             dx 0000, 9472, 03E8, 0000, 0000, 0000, A9, 00, 0000, 0000, 8B35, 0001, 0000, 8B85, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 804C, 804C, 0000, B78000, 05, 0000, EC1C, 0000 ; Mother Brain tubes falling
$A0:ED3F             dx 1800, D6BC, 03E8, 0000, 0010, 0028, A9, 00, 0000, 0000, D308, 0001, 0000, D368, 800F, 804C, 8041, 0000, 0000, 00000000, D42A, 0000, 00000000, D433, D433, 0000, B7A800, 05, F4A0, F12E, 0000 ; Torizo corpse
$A0:ED7F             dx 0E00, F8A6, 0140, 0050, 0016, 000C, A9, 00, 0000, 0000, D7B6, 0001, 0000, D8DB, 800F, D8DB, 8041, 0000, 0000, 00000000, D8CC, 0000, 00000000, DD44, DD1D, 0000, B7C000, 05, 0000, F12E, 0000 ; Sidehopper corpse
$A0:EDBF             dx 0600, EBAC, 0140, 0050, 0016, 000C, A9, 00, 0000, 0000, D7B6, 0001, 0000, D8DB, 800F, 804C, 8041, 0000, 0000, 00000000, DD1D, 0000, 00000000, DD1D, DD1D, 0000, AEAA00, 05, 0000, F12E, 0000 ; Sidehopper corpse
$A0:EDFF             dx 0000, F8A6, 03E8, 0000, 000A, 0008, A9, 00, 0000, 0000, D849, 0001, 0000, D8DB, 800F, 804C, 8041, 0000, 0000, 00000000, DCED, 0000, 00000000, DCF8, DCF8, 0000, B7C000, 05, 0000, F12E, 0000 ; Zoomer corpse
$A0:EE3F             dx 0000, F8A6, 03E8, 0000, 000B, 0006, A9, 00, 0000, 0000, D876, 0001, 0000, D8DB, 800F, 804C, 8041, 0000, 0000, 00000000, DCFD, 0000, 00000000, DD08, DD08, 0000, B7C000, 05, 0000, F12E, 0000 ; Ripper corpse
$A0:EE7F             dx 0000, F8A6, 03E8, 0000, 000C, 0010, A9, 00, 0000, 0000, D89F, 0001, 0000, D8DB, 800F, 804C, 8041, 0000, 0000, 00000000, DD0D, 0000, 00000000, DD18, DD18, 0000, B7C000, 05, 0000, F12E, 0000 ; Skree corpse
$A0:EEBF             dx 0C00, F8E6, 0C80, 0028, 0028, 0028, A9, 00, 0000, 0000, EF37, 0001, 0000, EFC5, 800F, 804C, 8041, 0000, 0000, 00000000, EFBA, 0000, 00000000, F789, F842, 0000, B18400, 02, 0000, F12E, 0000 ; Shitroid

$A0:EEFF             dx 2000, 8687, 0320, 0008, 0012, 0030, AA, 08, 0027, 0002, C87F, 0001, 0000, C6A4, 800F, C67E, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, C977, C97C, 0000, AFC200, 05, F3F8, F0C0, 0000 ; Bomb Torizo
$A0:EF3F             dx 2000, 8687, 0320, 0008, 0012, 0030, AA, 08, 0027, 0002, C87F, 0001, 0000, C6A4, 800F, C67E, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, C977, C97C, 0000, AFC200, 05, F3FE, F0C0, 0000 ; Bomb Torizo orb
$A0:EF7F             dx 2000, 8687, 34BC, 00A0, 0012, 0030, AA, 08, 0027, 0002, C87F, 0001, 0000, D369, 800F, D3BA, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, C977, D667, 0000, AFC200, 05, F404, F0D6, 0000 ; Golden Torizo
$A0:EFBF             dx 2000, 8687, 34BC, 00A0, 0012, 0030, AA, 08, 0027, 0002, C87F, 0001, 0000, D369, 800F, D3BA, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, C977, D667, 0000, AFC200, 05, F40A, F0D6, 0000 ; Golden Torizo orb
$A0:EFFF             dx 1600, D745, 0BB8, 0BB8, 0000, 0000, AA, 00, 0000, 0000, D7C8, 0001, 0000, D7C7, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, 87B364, 06, 0000, EC1C, 0000 ; Tourian entrance statue
$A0:F03F             dx 8600, D745, 0BB8, 0BB8, 0000, 0000, AA, 00, 0000, 0000, 804C, 0001, 0000, 804C, 800F, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, 87AD64, 06, 0000, EC1C, 0000 ; Tourian entrance statue ghost
$A0:F07F             dx 0400, D911, 012C, 0078, 0006, 0006, AA, 08, 0069, 0000, DE43, 0007, 0000, DCA3, 800F, DCA3, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, DF2F, DF34, 0000, B19000, 05, F3C8, EF1E, DE07 ; Shaktool
$A0:F0BF             dx 1800, E2BD, 0014, 0028, 0000, 0000, AA, 00, 0000, 0000, E716, 0001, 0000, 804C, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 804C, 804C, 0000, ABB400, 05, F452, EC1C, 0000 ; n00b tube cracks
$A0:F0FF             dx 1200, E31D, 0014, 0028, 0010, 0024, AA, 00, 0000, 0000, E725, 0001, 0000, E7A7, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, E7DB, E7DC, 0000, ACBE00, 05, F452, EEC6, 0000 ; Chozo statue

; Unused. Random bunch of 2s
; Impossible to speculate on; the only other long list of 2s in the game is scroll data
$A0:F13F             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, 02

; Weirdo discontinuity, enemy banks jump from $A2..AA to $B2..B3
$A0:F153             dx 0200, 8687, 0014, 0028, 0008, 0008, B3, 00, 0000, 0000, 86FB, 0001, 0000, 870E, 800F, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, B7FB00, 05, 0000, 0000, 0000 ; Unused spinning turtle eye
$A0:F193             dx 0400, 878B, 0009, 0006, 0008, 0008, B3, 00, 0022, 0000, 883B, 0001, 0000, 887A, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEC120, 05, F248, EC1C, E1A3 ; Zeb
$A0:F1D3             dx 0400, 89FD, 001E, 0014, 0008, 0008, B3, 00, 0022, 0000, 883B, 0001, 0000, 887A, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEE520, 05, F254, EC1C, E1B1 ; Zebbo
$A0:F213             dx 0400, 8AC1, 0014, 0010, 0008, 0008, B3, 00, 0022, 0000, 8B61, 0005, 0000, 8B9E, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEE920, 05, F25A, EC1C, DE69 ; Gamet
$A0:F253             dx 0400, 8EDC, 000A, 000A, 0008, 0008, B3, 00, 0022, 0000, 8F4C, 0001, 0000, 8FAE, 800A, 804C, 8041, 0000, 0000, 00000000, 0000, 0000, 00000000, 8023, 802D, 0000, AEE120, 05, F24E, EC1C, DE77 ; Geega
$A0:F293             dx 1800, 9319, 0BB8, 0078, 0008, 0008, B3, 00, 005F, 0009, 9583, 0001, 0000, 9668, 800F, 804C, 8041, 0000, 0000, 00000000, A041, 0000, 00000000, 9FFF, A016, 0000, B7E300, 05, F344, F118, DDDD ; Botwoon
$A0:F2D3             dx 0600, E525, 0BB8, 0BB8, 0006, 0008, B3, 00, 0000, 0000, E6CB, 0001, 0000, E655, 8000, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, AC8200, 05, F482, 0000, 0000 ; Escape etecoon
$A0:F313             dx 0C00, E944, 0BB8, 0BB8, 0008, 0018, B3, 00, 0000, 0000, EAE5, 0001, 0000, EB1A, 8000, 804C, 8041, 0000, 0000, 00000000, 804C, 0000, 00000000, 804C, 804C, 0000, AC8800, 05, F488, 0000, 0000 ; Escape dachora

$A0:F353             dx 0C00, 8687, 0014, 000F, 0010, 0018, B2, 00, 0021, 0000, EF9F, 0001, 0000, F02D, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F2A8, ECCC, DDB3 ; Grey wall space pirate
$A0:F393             dx 0C00, 86A7, 005A, 0014, 0010, 0018, B2, 00, 0021, 0000, EF9F, 0001, 0000, F02D, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F2AE, ECCC, E1E9 ; Green wall space pirate
$A0:F3D3             dx 0C00, 86E7, 00C8, 0050, 0010, 0018, B2, 00, 0021, 0000, EF9F, 0001, 0000, F02D, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F290, ECB6, E1F7 ; Red wall space pirate
$A0:F413             dx 0C00, 8727, 0384, 00C8, 0010, 0018, B2, 00, 0021, 0000, EF9F, 0001, 0000, F02D, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F2A2, ED50, E205 ; Gold wall space pirate
$A0:F453             dx 0C00, 86C7, 012C, 00A0, 0010, 0018, B2, 00, 0021, 0000, EF9F, 0001, 0000, F02D, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F3A4, ECE2, E213 ; Magenta wall space pirate
$A0:F493             dx 0C00, 8707, 01F4, 000F, 0010, 0018, B2, 00, 0021, 0000, EF9F, 0001, 0000, F02D, 800F, 804C, 8041, 0000, 0004, 00000000, 0000, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F4A6, EC8A, E221 ; Silver wall space pirate
$A0:F4D3             dx 1800, 8687, 0014, 000F, 0010, 0020, B2, 00, 0021, 0000, F5DE, 0001, 0000, F6A2, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F386, EC5E, DDC1 ; Grey ninja space pirate
$A0:F513             dx 1800, 86A7, 005A, 0014, 0010, 0020, B2, 00, 0021, 0000, F5DE, 0001, 0000, F6A2, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F392, EC5E, E22F ; Green ninja space pirate
$A0:F553             dx 1800, 86E7, 00C8, 0050, 0010, 0020, B2, 00, 0021, 0000, F5DE, 0001, 0001, F6A2, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F296, EC5E, E23D ; Red ninja space pirate
$A0:F593             dx 1800, 8707, 0708, 0064, 0010, 0020, B2, 00, 0021, 0000, F5DE, 0001, 0000, F6A2, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F284, EC74, E24B ; Gold ninja space pirate
$A0:F5D3             dx 1800, 86C7, 012C, 00A0, 0010, 0020, B2, 00, 0021, 0000, F5DE, 0001, 0000, F6A2, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F3AA, EC5E, E259 ; Magenta ninja space pirate
$A0:F613             dx 1800, 8707, 01F4, 000F, 0010, 0020, B2, 00, 0021, 0000, F5DE, 0001, 0000, F6A2, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F4AC, ECA0, E267 ; Silver ninja space pirate
$A0:F653             dx 0C00, 8687, 0014, 000F, 0010, 0020, B2, 00, 0066, 0000, FD02, 0001, 0000, FD32, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F38C, ECF8, DDCF ; Grey walking space pirate
$A0:F693             dx 0C00, 86A7, 005A, 0014, 0010, 0020, B2, 00, 0066, 0000, FD02, 0001, 0000, FD32, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F398, ED0E, E275 ; Green walking space pirate
$A0:F6D3             dx 0C00, 86E7, 00C8, 0050, 0010, 0020, B2, 00, 0066, 0000, FD02, 0001, 0000, FD32, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F29C, ED24, E283 ; Red walking space pirate
$A0:F713             dx 0C00, 8727, 0384, 00C8, 0010, 0020, B2, 00, 0066, 0000, FD02, 0001, 0000, FD32, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F39E, ED50, E291 ; Gold walking space pirate
$A0:F753             dx 0C00, 86C7, 012C, 00A0, 0010, 0020, B2, 00, 0066, 0000, FD02, 0001, 0000, FD32, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F3B0, ED3A, E29F ; Magenta walking space pirate
$A0:F793             dx 0C00, 8707, 01F4, 000F, 0010, 0020, B2, 00, 0066, 0000, FD02, 0001, 0000, FD32, 800F, 804C, 8041, 0000, 0004, 00000000, 8767, 0000, 00000000, 876C, 8779, 0000, ADC600, 05, F4B2, EC8A, E2AD ; Silver walking space pirate
}


;;; $F7D3: Free space ;;;
{
$A0:F7D3             fillto $A18000, $FF        ; Free space
}
