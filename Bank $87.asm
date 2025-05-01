;;; $8000: Enable animated tiles objects ;;;
{
$87:8000 08          PHP
$87:8001 C2 20       REP #$20
$87:8003 A9 00 80    LDA #$8000
$87:8006 0C F1 1E    TSB $1EF1  [$7E:1EF1]
$87:8009 28          PLP
$87:800A 6B          RTL
}


;;; $800B: Disable animated tiles objects ;;;
{
$87:800B 08          PHP
$87:800C C2 20       REP #$20
$87:800E A9 00 80    LDA #$8000
$87:8011 1C F1 1E    TRB $1EF1  [$7E:1EF1]
$87:8014 28          PLP
$87:8015 6B          RTL
}


;;; $8016: Clear animated tiles objects ;;;
{
$87:8016 08          PHP
$87:8017 C2 30       REP #$30
$87:8019 DA          PHX
$87:801A A2 0A 00    LDX #$000A

$87:801D 9E F5 1E    STZ $1EF5,x[$7E:1EFF]
$87:8020 CA          DEX
$87:8021 CA          DEX
$87:8022 10 F9       BPL $F9    [$801D]
$87:8024 FA          PLX
$87:8025 28          PLP
$87:8026 6B          RTL
}


;;; $8027: Spawn animated tiles object ;;;
{
;; Parameter:
;;     Y: Animated tiles object ID
$87:8027 08          PHP
$87:8028 8B          PHB
$87:8029 DA          PHX
$87:802A 4B          PHK                    ;\
$87:802B AB          PLB                    ;} DB = $87
$87:802C A2 0A 00    LDX #$000A             ; X = Ah (animated tiles object index)

; LOOP
$87:802F BD F5 1E    LDA $1EF5,x[$7E:1EFF]  ;\
$87:8032 F0 09       BEQ $09    [$803D]     ;} If [animated tiles object ID] = 0: go to BRANCH_FOUND
$87:8034 CA          DEX                    ;\
$87:8035 CA          DEX                    ;} X -= 2 (next index)
$87:8036 10 F7       BPL $F7    [$802F]     ; If [X] >= 0: go to LOOP
$87:8038 FA          PLX
$87:8039 AB          PLB
$87:803A 28          PLP
$87:803B 38          SEC
$87:803C 6B          RTL                    ; Return

; BRANCH_FOUND
$87:803D 98          TYA
$87:803E 9D F5 1E    STA $1EF5,x[$7E:1EFF]  ; Animated tiles object ID = [Y]
$87:8041 9E 01 1F    STZ $1F01,x[$7E:1F0B]  ; Animated tiles object counter = 0
$87:8044 B9 00 00    LDA $0000,y[$87:82E7]  ;\
$87:8047 9D 0D 1F    STA $1F0D,x[$7E:1F17]  ;} Animated tiles object instruction list pointer = [[Y]]
$87:804A 9E 25 1F    STZ $1F25,x[$7E:1F2F]  ; Animated tiles object source address = 0
$87:804D B9 02 00    LDA $0002,y[$87:82E9]  ;\
$87:8050 9D 31 1F    STA $1F31,x[$7E:1F3B]  ;} Animated tiles object size = [[Y] + 2]
$87:8053 B9 04 00    LDA $0004,y[$87:82EB]  ;\
$87:8056 9D 3D 1F    STA $1F3D,x[$7E:1F47]  ;} Animated tiles object VRAM address = [[Y] + 4]
$87:8059 A9 01 00    LDA #$0001             ;\
$87:805C 9D 19 1F    STA $1F19,x[$7E:1F23]  ;} Animated tiles object instruction timer = 1
$87:805F FA          PLX
$87:8060 AB          PLB
$87:8061 28          PLP
$87:8062 18          CLC
$87:8063 6B          RTL
}


;;; $8064: Animated tiles objects handler ;;;
{
$87:8064 08          PHP
$87:8065 8B          PHB
$87:8066 4B          PHK                    ;\
$87:8067 AB          PLB                    ;} DB = $87
$87:8068 2C F1 1E    BIT $1EF1  [$7E:1EF1]  ;\
$87:806B 10 15       BPL $15    [$8082]     ;} If animated tiles objects are disabled: return
$87:806D A2 0A 00    LDX #$000A             ; X = Ah (animated tiles object index)

; LOOP
$87:8070 8E F3 1E    STX $1EF3  [$7E:1EF3]  ; Animated tiles object index = [X]
$87:8073 BD F5 1E    LDA $1EF5,x[$7E:1EFF]  ;} If [animated tiles object ID] != 0:
$87:8076 F0 06       BEQ $06    [$807E]     ;/
$87:8078 20 85 80    JSR $8085  [$87:8085]  ; Process animated tiles object
$87:807B AE F3 1E    LDX $1EF3  [$7E:1EF3]

$87:807E CA          DEX                    ;\
$87:807F CA          DEX                    ;} X -= 2
$87:8080 10 EE       BPL $EE    [$8070]     ; If [X] >= 0: go to LOOP

$87:8082 AB          PLB
$87:8083 28          PLP
$87:8084 6B          RTL
}


;;; $8085: Process animated tiles object ;;;
{
; Some instructions (e.g. delete) pop the return address pushed to the stack by $809A to return out of *this* routine
; (marked "terminate processing animated tiles object")
$87:8085 AE F3 1E    LDX $1EF3  [$7E:1EF3]  ; X = [animated tiles object index]
$87:8088 DE 19 1F    DEC $1F19,x[$7E:1F23]  ; Decrement animated tiles object instruction timer
$87:808B D0 24       BNE $24    [$80B1]     ; If [animated tiles object instruction timer] != 0: return
$87:808D BC 0D 1F    LDY $1F0D,x[$7E:1F17]  ; Y = [animated tiles object instruction list pointer]

; LOOP
$87:8090 B9 00 00    LDA $0000,y[$87:82CF]  ;\
$87:8093 10 0B       BPL $0B    [$80A0]     ;} If [[Y]] & 8000h (ASM instruction):
$87:8095 8D 49 1F    STA $1F49  [$7E:1F49]  ; Animated tiles object instruction = [[Y]]
$87:8098 C8          INY                    ;\
$87:8099 C8          INY                    ;} Y += 2
$87:809A F4 8F 80    PEA $808F
$87:809D 6C 49 1F    JMP ($1F49)[$87:80B7]  ; Execute [animated tiles object instruction] and go to LOOP

$87:80A0 9D 19 1F    STA $1F19,x[$7E:1F23]  ; Animated tiles object instruction timer = [[Y]]
$87:80A3 B9 02 00    LDA $0002,y[$87:82D1]  ;\
$87:80A6 9D 25 1F    STA $1F25,x[$7E:1F2F]  ;} Animated tiles object source address = [[Y] + 2]
$87:80A9 98          TYA                    ;\
$87:80AA 18          CLC                    ;|
$87:80AB 69 04 00    ADC #$0004             ;} Animated tiles object instruction pointer = [Y] + 4
$87:80AE 9D 0D 1F    STA $1F0D,x[$7E:1F17]  ;/

$87:80B1 60          RTS
}


;;; $80B2..8169: Instructions ;;;
{
;;; $80B2: Instruction - delete ;;;
{
;; Parameters:
;;     X: Animated tiles object index
$87:80B2 9E F5 1E    STZ $1EF5,x[$7E:1EFF]  ; Animated tiles object ID = 0
$87:80B5 68          PLA                    ; Terminate processing animated tiles object
$87:80B6 60          RTS
}


;;; $80B7: Instruction - go to [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80B7 B9 00 00    LDA $0000,y[$87:82E5]
$87:80BA A8          TAY
$87:80BB 60          RTS
}


;;; $80BC: Unused. Instruction - go to [Y] + ±[[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80BC 8C 49 1F    STY $1F49  [$7E:1F49]
$87:80BF 88          DEY
$87:80C0 B9 00 00    LDA $0000,y
$87:80C3 EB          XBA
$87:80C4 30 05       BMI $05    [$80CB]
$87:80C6 29 FF 00    AND #$00FF
$87:80C9 80 03       BRA $03    [$80CE]

$87:80CB 09 00 FF    ORA #$FF00

$87:80CE 18          CLC
$87:80CF 6D 49 1F    ADC $1F49  [$7E:1F49]
$87:80D2 A8          TAY
$87:80D3 60          RTS
}


;;; $80D4: Unused. Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Animated tiles object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80D4 DE 01 1F    DEC $1F01,x
$87:80D7 D0 DE       BNE $DE    [$80B7]
$87:80D9 C8          INY
$87:80DA C8          INY
$87:80DB 60          RTS
}


;;; $80DC: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
;; Parameters:
;;     X: Animated tiles object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80DC DE 01 1F    DEC $1F01,x
$87:80DF D0 DB       BNE $DB    [$80BC]
$87:80E1 C8          INY
$87:80E2 60          RTS
}


;;; $80E3: Unused. Instruction - timer = [[Y]] ;;;
{
;; Parameters:
;;     X: Animated tiles object index
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80E3 E2 20       SEP #$20
$87:80E5 B9 00 00    LDA $0000,y
$87:80E8 9D 01 1F    STA $1F01,x
$87:80EB C2 20       REP #$20
$87:80ED C8          INY
$87:80EE 60          RTS
}


;;; $80EF: Unused. RTS ;;;
{
$87:80EF 60          RTS
}


;;; $80F0: Unused. Instruction - queue music track [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80F0 B9 00 00    LDA $0000,y
$87:80F3 29 FF 00    AND #$00FF
$87:80F6 22 C1 8F 80 JSL $808FC1[$80:8FC1]
$87:80FA C8          INY
$87:80FB 60          RTS
}


;;; $80FC: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:80FC B9 00 00    LDA $0000,y
$87:80FF 29 FF 00    AND #$00FF
$87:8102 22 49 90 80 JSL $809049[$80:9049]
$87:8106 C8          INY
$87:8107 60          RTS
}


;;; $8108: Unused. Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8108 B9 00 00    LDA $0000,y
$87:810B 29 FF 00    AND #$00FF
$87:810E 22 CB 90 80 JSL $8090CB[$80:90CB]
$87:8112 C8          INY
$87:8113 60          RTS
}


;;; $8114: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 6 ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8114 B9 00 00    LDA $0000,y
$87:8117 29 FF 00    AND #$00FF
$87:811A 22 4D 91 80 JSL $80914D[$80:914D]
$87:811E C8          INY
$87:811F 60          RTS
}


;;; $8120: Unused. Instruction - go to [[Y] + 1] if any of the boss bits [[Y]] are set ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8120 B9 00 00    LDA $0000,y
$87:8123 C8          INY
$87:8124 29 FF 00    AND #$00FF
$87:8127 22 DC 81 80 JSL $8081DC[$80:81DC]
$87:812B 90 03       BCC $03    [$8130]
$87:812D 4C B7 80    JMP $80B7  [$87:80B7]

$87:8130 C8          INY
$87:8131 C8          INY
$87:8132 60          RTS
}


;;; $8133: Unused. Instruction - set the boss bits [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8133 B9 00 00    LDA $0000,y
$87:8136 29 FF 00    AND #$00FF
$87:8139 22 A6 81 80 JSL $8081A6[$80:81A6]
$87:813D C8          INY
$87:813E 60          RTS
}


;;; $813F: Instruction - go to [[Y] + 2] if the event [[Y]] is set ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:813F B9 00 00    LDA $0000,y[$87:8482]
$87:8142 C8          INY
$87:8143 C8          INY
$87:8144 22 33 82 80 JSL $808233[$80:8233]
$87:8148 90 03       BCC $03    [$814D]
$87:814A 4C B7 80    JMP $80B7  [$87:80B7]

$87:814D C8          INY
$87:814E C8          INY
$87:814F 60          RTS
}


;;; $8150: Instruction - set event [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8150 B9 00 00    LDA $0000,y[$87:84D2]
$87:8153 22 FA 81 80 JSL $8081FA[$80:81FA]
$87:8157 C8          INY
$87:8158 C8          INY
$87:8159 60          RTS
}


;;; $815A: Unused. Instruction - lock Samus ;;;
{
$87:815A A9 00 00    LDA #$0000             ;\
$87:815D 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus
$87:8161 60          RTS
}


;;; $8162: Unused. Instruction - unlock Samus ;;;
{
$87:8162 A9 01 00    LDA #$0001             ;\
$87:8165 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus
$87:8169 60          RTS
}
}


;;; $816A..824A: Instruction lists - FX ;;;
{
;;; $816A: Instruction list - animated tiles object $8251 (all areas 1 - vertical spikes) ;;;
{
; LOOP
$87:816A             dw 0008,9C04,
                        0008,9C84,
                        0008,9D04,
                        0008,9C84,
                        80B7,816A    ; Go to LOOP
}


;;; $817E: Instruction list - animated tiles object $8257 (all areas 2 - horizontal spikes) ;;;
{
; LOOP
$87:817E             dw 0008,9D84,
                        0008,9E04,
                        0008,9E84,
                        0008,9E04,
                        80B7,817E    ; Go to LOOP
}


;;; $8192: Instruction list - animated tiles object $825D (Crateria 4 - Crateria lake) ;;;
{
; LOOP
$87:8192             dw 000A,8564,
                        000A,8764,
                        000A,8964,
                        000A,8764,
                        80B7,8192    ; Go to LOOP
}


;;; $81A6: Instruction list - animated tiles object $8263/$8269 (Crateria 8 - unused Crateria lava) ;;;
{
; LOOP
$87:81A6             dw 000A,8B64,
                        000A,8C24,
                        000A,8CE4,
                        000A,8DA4,
                        80B7,81A6    ; Go to LOOP
}


;;; $81BA: Instruction - wait until area boss is dead ;;;
{
;; Parameters:
;;     X: Animated tiles object index
$87:81BA A9 01 00    LDA #$0001
$87:81BD 22 DC 81 80 JSL $8081DC[$80:81DC]
$87:81C1 B0 07       BCS $07    [$81CA]
$87:81C3 68          PLA                    ; Terminate processing animated tiles object
$87:81C4 A9 01 00    LDA #$0001
$87:81C7 9D 19 1F    STA $1F19,x[$7E:1F23]

$87:81CA 60          RTS
}


;;; $81CB: Instruction list - animated tiles object $826F (Wrecked Ship 10h - Wrecked Ship screen) ;;;
{
$87:81CB             dw 81BA,        ; Wait until area boss is dead
; LOOP
$87:81CD             dw 000A,8EE4,
                        000A,8F64,
                        000A,8FE4,
                        000A,8F64,
                        80B7,81CD    ; Go to LOOP
}


;;; $81E1: Instruction list - animated tiles object $8275 (Wrecked Ship 4 - Wrecked Ship treadmill - rightwards) ;;;
{
$87:81E1             dw 81BA,        ; Wait until area boss is dead
; LOOP
$87:81E3             dw 0001,8E64,
                        0001,8E84,
                        0001,8EA4,
                        0001,8EC4,
                        80B7,81E3    ; Go to LOOP
}


;;; $81F7: Instruction list - animated tiles object $827B (Wrecked Ship 8 - Wrecked Ship treadmill - leftwards) ;;;
{
$87:81F7             dw 81BA,        ; Wait until area boss is dead
; LOOP
$87:81F9             dw 0001,8EC4,
                        0001,8EA4,
                        0001,8E84,
                        0001,8E64,
                        80B7,81F9    ; Go to LOOP
}


;;; $820D: Instruction list - animated tiles object $8281 (Brinstar 4 - Brinstar plant) ;;;
{
; LOOP
$87:820D             dw 0010,9964,
                        0010,9A44,
                        0010,9B24,
                        0010,9A44,
                        80B7,820D    ; Go to LOOP
}


;;; $8221: Instruction list - animated tiles object $8287 (Maridia 4 - Maridia sand ceiling) ;;;
{
; LOOP
$87:8221             dw 000A,91E4,
                        000A,9224,
                        000A,9264,
                        000A,92A4,
                        80B7,8221    ; Go to LOOP
}


;;; $8235: Instruction list - animated tiles object $828D (Maridia 8 - Maridia sand falling) ;;;
{
; LOOP
$87:8235             dw 000A,9164,
                        000A,9184,
                        000A,91A4,
                        000A,91C4,
                        80B7,8235    ; Go to LOOP
}


;;; $8249: Instruction list - animated tiles object $824B (nothing) ;;;
{
$87:8249             dw 80B2         ; Delete
}
}


;;; $824B: Animated tiles objects - FX ;;;
{
; Instruction list, size, VRAM address
$87:824B             dw 8249,0000,0000 ; Nothing
$87:8251             dw 816A,0080,3880 ; All areas 1 - vertical spikes
$87:8257             dw 817E,0080,3D60 ; All areas 2 - horizontal spikes
$87:825D             dw 8192,0200,1B00 ; Crateria 4 - Crateria lake
$87:8263             dw 81A6,00C0,0A00 ; Crateria 8 - unused Crateria lava
$87:8269             dw 81A6,00C0,0640 ; Unused. Crateria lava
$87:826F             dw 81CB,0080,19C0 ; Wrecked Ship 10h - Wrecked Ship screen
$87:8275             dw 81E1,0020,00E0 ; Wrecked Ship 4 - Wrecked Ship treadmill - rightwards
$87:827B             dw 81F7,0020,00E0 ; Wrecked Ship 8 - Wrecked Ship treadmill - leftwards
$87:8281             dw 820D,00E0,0410 ; Brinstar 4 - Brinstar plant
$87:8287             dw 8221,0040,1000 ; Maridia 4 - Maridia sand ceiling
$87:828D             dw 8235,0020,1020 ; Maridia 8 - Maridia sand falling
}


;;; $8293..8302: Animated tiles objects and instruction lists - FX layer 3 ;;;
{
;;; $8293: Instruction list - animated tiles object $82AB (lava) ;;;
{
; LOOP
$87:8293             dw 000D,A564,
                        000D,A5A4,
                        000D,A5E4,
                        000D,A624,
                        000D,A664,
                        80B7,8293    ; Go to LOOP
}


;;; $82AB: Animated tiles object - lava ;;;
{
$87:82AB             dw 8293,0040,4280
}


;;; $82B1: Instruction list - animated tiles object $82C9 (acid) ;;;
{
; LOOP
$87:82B1             dw 000A,A6A4,
                        000A,A6E4,
                        000A,A724,
                        000A,A764,
                        000A,A7A4,
                        80B7,82B1    ; Go to LOOP
}


;;; $82C9: Animated tiles object - acid ;;;
{
$87:82C9             dw 82B1,0040,4280
}


;;; $82CF: Instruction list - animated tiles object $82E7 (rain) ;;;
{
; LOOP
$87:82CF             dw 000A,A874,
                        000A,A8C4,
                        000A,A914,
                        000A,A964,
                        000A,A9B4,
                        80B7,82CF    ; Go to LOOP
}


;;; $82E7: Animated tiles object - rain ;;;
{
$87:82E7             dw 82CF,0050,4280
}


;;; $82ED: Instruction list - animated tiles object $82FD (spores) ;;;
{
; LOOP
$87:82ED             dw 000A,A7E4,
                        000A,A814,
                        000A,A844,
                        80B7,82ED    ; Go to LOOP
}


;;; $82FD: Animated tiles object - spores ;;;
{
$87:82FD             dw 82ED,0030,4280
}
}


;;; $8303..83AB: Instructions - Tourian entrance statue ;;;
{
;;; $8303: Instruction - go to [[Y] + 2] if any of the boss bits [[Y]] for area [[Y] + 1] are set ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8303 DA          PHX
$87:8304 B9 01 00    LDA $0001,y[$87:849D]
$87:8307 29 FF 00    AND #$00FF
$87:830A AA          TAX
$87:830B BF 28 D8 7E LDA $7ED828,x[$7E:D829]
$87:830F FA          PLX
$87:8310 39 00 00    AND $0000,y[$87:849C]
$87:8313 C8          INY
$87:8314 C8          INY
$87:8315 29 FF 00    AND #$00FF
$87:8318 F0 03       BEQ $03    [$831D]
$87:831A 4C B7 80    JMP $80B7  [$87:80B7]

$87:831D C8          INY
$87:831E C8          INY
$87:831F 60          RTS
}


;;; $8320: Instruction - spawn Tourian entrance statue eye glow enemy projectile with parameter [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8320 5A          PHY
$87:8321 B9 00 00    LDA $0000,y[$87:84BE]
$87:8324 A0 6A BA    LDY #$BA6A             ;\
$87:8327 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian entrance statue eye glow enemy projectile
$87:832B 7A          PLY
$87:832C C8          INY
$87:832D C8          INY
$87:832E 60          RTS
}


;;; $832F: Instruction - spawn Tourian entrance statue's soul enemy projectile with parameter [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:832F 5A          PHY
$87:8330 B9 00 00    LDA $0000,y[$87:84C6]
$87:8333 A0 94 BA    LDY #$BA94             ;\
$87:8336 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian entrance statue's soul enemy projectile
$87:833A 7A          PLY
$87:833B C8          INY
$87:833C C8          INY
$87:833D 60          RTS
}


;;; $833E: Instruction - go to [[Y]] if Tourian entrance statue is busy releasing lock ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:833E AD 6F 1E    LDA $1E6F  [$7E:1E6F]
$87:8341 10 03       BPL $03    [$8346]
$87:8343 4C B7 80    JMP $80B7  [$87:80B7]

$87:8346 C8          INY
$87:8347 C8          INY
$87:8348 60          RTS
}


;;; $8349: Instruction - Tourian entrance statue animation state |= [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8349 B9 00 00    LDA $0000,y[$87:847E]
$87:834C 0C 6F 1E    TSB $1E6F  [$7E:1E6F]
$87:834F C8          INY
$87:8350 C8          INY
$87:8351 60          RTS
}


;;; $8352: Instruction - Tourian entrance statue animation state &= ~[[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8352 B9 00 00    LDA $0000,y[$87:84D6]
$87:8355 1C 6F 1E    TRB $1E6F  [$7E:1E6F]
$87:8358 C8          INY
$87:8359 C8          INY
$87:835A 60          RTS
}


;;; $835B: Instruction - clear 3 colours of palette data at $7E:C000 + [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:835B DA          PHX
$87:835C BE 00 00    LDX $0000,y[$87:84B2]
$87:835F A9 00 00    LDA #$0000
$87:8362 9F 00 C0 7E STA $7EC000,x[$7E:C0F8]
$87:8366 9F 02 C0 7E STA $7EC002,x[$7E:C0FA]
$87:836A 9F 04 C0 7E STA $7EC004,x[$7E:C0FC]
$87:836E FA          PLX
$87:836F C8          INY
$87:8370 C8          INY
$87:8371 60          RTS
}


;;; $8372: Instruction - spawn palette FX object [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:8372 5A          PHY
$87:8373 B9 00 00    LDA $0000,y[$87:84CA]
$87:8376 A8          TAY
$87:8377 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]
$87:837B 7A          PLY
$87:837C C8          INY
$87:837D C8          INY
$87:837E 60          RTS
}


;;; $837F: Instruction - write 8 colours of target palette data to $7E:C200 + [[Y]] ;;;
{
;; Parameters:
;;     Y: Pointer to instruction arguments
;; Returns:
;;     Y: Pointer to next instruction
$87:837F DA          PHX
$87:8380 5A          PHY
$87:8381 BE 00 00    LDX $0000,y
$87:8384 A0 00 00    LDY #$0000

$87:8387 B9 9C 83    LDA $839C,y
$87:838A 9F 00 C2 7E STA $7EC200,x
$87:838E E8          INX
$87:838F E8          INX
$87:8390 C8          INY
$87:8391 C8          INY
$87:8392 C0 10 00    CPY #$0010
$87:8395 D0 F0       BNE $F0    [$8387]
$87:8397 7A          PLY
$87:8398 FA          PLX
$87:8399 C8          INY
$87:839A C8          INY
$87:839B 60          RTS

$87:839C             dw 3800, 7F58, 6ED5, 5A71, 49EE, 356A, 24E7, 1083
}
}


;;; $83AC..854B: Instruction lists - Tourian entrance statue ;;;
{
;;; $83AC: Instruction list - animated tiles object $854C (Tourian entrance statue - Phantoon) ;;;
{
$87:83AC             dw 8349,0001,       ; Set Tourian entrance statue to process Phantoon
                        813F,0006,840A,  ; Go to BRANCH_STATUE_IS_GREY if Phantoon statue is grey
                        0006,9364
; LOOP
$87:83BA             dx 000C,93E4,
                        000C,9464,
                        000C,93E4,
                        0010,9364,
                        8303,01,03,83D8, ; Go to BRANCH_PHANTOON_IS_DEAD if Phantoon is dead
                        8352,0001,       ; Set Tourian entrance statue to stop processing Phantoon
                        80B7,83BA        ; Go to LOOP
; BRANCH_PHANTOON_IS_DEAD
$87:83D8             dw 833E,83BA,       ; Go to LOOP if Tourian entrance statue is busy releasing lock
                        8349,8000,       ; Set Tourian entrance statue busy releasing lock
                        835B,0158,       ; Clear 3 colours of palette data at $7E:C158
                        0010,93E4,
                        0010,9464,
                        8320,0000,       ; Spawn Tourian entrance statue eye glow enemy projectile with parameter 0
                        00C0,97E4,
                        832F,0000,       ; Spawn Tourian entrance statue's soul enemy projectile with parameter 0
                        8372,F755,       ; Spawn palette FX object $F755 (grey out Tourian entrance statue - Phantoon)
                        0080,97E4,
                        8150,0006,       ; Set Phantoon statue is grey event
                        8352,8001,       ; Set Tourian entrance statue not processing Phantoon and not busy
                        80B2             ; Delete
; BRANCH_STATUE_IS_GREY
$87:840A             dw 8352,8001,       ; Set Tourian entrance statue not processing Phantoon and not busy
                        837F,0140,       ; Write 8 colours of target palette data to $7E:C340
                        80B2             ; Delete
}


;;; $8414: Instruction list - animated tiles object $8552 (Tourian entrance statue - Ridley) ;;;
{
$87:8414             dw 8349,0002,       ; Set Tourian entrance statue to process Ridley
                        813F,0007,8472,  ; Go to BRANCH_STATUE_IS_GREY if Ridley statue is grey
                        000A,94E4
; LOOP_WAIT
$87:8422             dx 000C,9524,
                        000C,9564,
                        000C,9524,
                        0010,94E4,
                        8303,01,02,8440, ; Go to BRANCH_RIDLEY_IS_DEAD if Ridley is dead
                        8352,0002,       ; Set Tourian entrance statue to stop processing Ridley
                        80B7,8422        ; Go to LOOP
; BRANCH_RIDLEY_IS_DEAD
$87:8440             dw 833E,8422,       ; Go to LOOP if Tourian entrance statue is busy releasing lock
                        8349,8000,       ; Set Tourian entrance statue busy releasing lock
                        835B,0132,       ; Clear 3 colours of palette data at $7E:C132
                        0010,9524,
                        0010,9564,
                        8320,0002,       ; Spawn Tourian entrance statue eye glow enemy projectile with parameter 2
                        00C0,9864,
                        832F,0002,       ; Spawn Tourian entrance statue's soul enemy projectile with parameter 2
                        8372,F751,       ; Spawn palette FX object $F751 (grey out Tourian entrance statue - Ridley)
                        0080,9864,
                        8150,0007,       ; Set Ridley statue is grey event
                        8352,8002,       ; Set Tourian entrance statue not processing Ridley and not busy
                        80B2             ; Delete
; BRANCH_STATUE_IS_GREY
$87:8472             dw 8352,8002,       ; Set Tourian entrance statue not processing Ridley and not busy
                        837F,0120,       ; Write 8 colours of target palette data to $7E:C320
                        80B2             ; Delete
}


;;; $847C: Instruction list - animated tiles object $8558 (Tourian entrance statue - Kraid) ;;;
{
$87:847C             dw 8349,0004,       ; Set Tourian entrance statue to process Kraid
                        813F,0009,84DA,  ; Go to BRANCH_STATUE_IS_GREY if Kraid statue is grey
                        0004,9724
; LOOP_WAIT
$87:848A             dx 000C,9764,
                        000C,97A4,
                        000C,9764,
                        0010,9724,
                        8303,01,01,84A8, ; Go to BRANCH_KRAID_IS_DEAD if Kraid is dead
                        8352,0004,       ; Set Tourian entrance statue to stop processing Kraid
                        80B7,848A        ; Go to LOOP
; BRANCH_KRAID_IS_DEAD
$87:84A8             dw 833E,848A,       ; Go to LOOP if Tourian entrance statue is busy releasing lock
                        8349,8000,       ; Set Tourian entrance statue busy releasing lock
                        835B,00F8,       ; Clear 3 colours of palette data at $7E:C0F8
                        0010,9764,
                        0010,97A4,
                        8320,0006,       ; Spawn Tourian entrance statue eye glow enemy projectile with parameter 6
                        00C0,98A4,
                        832F,0006,       ; Spawn Tourian entrance statue's soul enemy projectile with parameter 6
                        8372,F74D,       ; Spawn palette FX object $F74D (grey out Tourian entrance statue - Kraid)
                        0080,98A4,
                        8150,0009,       ; Set Kraid statue is grey event
                        8352,8004,       ; Set Tourian entrance statue not processing Kraid and not busy
                        80B2             ; Delete
; BRANCH_STATUE_IS_GREY
$87:84DA             dw 8352,8004,       ; Set Tourian entrance statue not processing Kraid and not busy
                        837F,00E0,       ; Write 8 colours of target palette data to $7E:C2E0
                        80B2             ; Delete
}


;;; $84E4: Instruction list - animated tiles object $855E (Tourian entrance statue - Draygon) ;;;
{
$87:84E4             dw 8349,0008,       ; Set Tourian entrance statue to process Draygon
                        813F,0008,8542,  ; Go to BRANCH_STATUE_IS_GREY if Draygon statue is grey
                        0008,95A4
; LOOP_WAIT
$87:84F2             dx 000C,9624,
                        000C,96A4,
                        000C,9624,
                        0010,95A4,
                        8303,01,04,8510, ; Go to BRANCH_DRAYGON_IS_DEAD if Draygon is dead
                        8352,0008,       ; Set Tourian entrance statue to stop processing Draygon
                        80B7,84F2        ; Go to LOOP
; BRANCH_DRAYGON_IS_DEAD
$87:8510             dw 833E,84F2,       ; Go to LOOP if Tourian entrance statue is busy releasing lock
                        8349,8000,       ; Set Tourian entrance statue busy releasing lock
                        835B,00D2,       ; Clear 3 colours of palette data at $7E:C0D2
                        0010,9624,
                        0010,96A4,
                        8320,0004,       ; Spawn Tourian entrance statue eye glow enemy projectile with parameter 4
                        00C0,98E4,
                        832F,0004,       ; Spawn Tourian entrance statue's soul enemy projectile with parameter 4
                        8372,F749,       ; Spawn palette FX object $F749 (grey out Tourian entrance statue - Draygon)
                        0080,98E4,
                        8150,0008,       ; Set Draygon statue is grey event
                        8352,8008,       ; Set Tourian entrance statue not processing Draygon and not busy
                        80B2             ; Delete
; BRANCH_STATUE_IS_GREY
$87:8542             dw 8352,8008,       ; Set Tourian entrance statue not processing Draygon and not busy
                        837F,00C0,       ; Write 8 colours of target palette data to $7E:C2C0
                        80B2             ; Delete
}
}


;;; $854C: Animated tiles objects - Tourian entrance statue ;;;
{
$87:854C             dw 83AC,0080,7800 ; Tourian entrance statue - Phantoon
$87:8552             dw 8414,0040,7220 ; Tourian entrance statue - Ridley
$87:8558             dw 847C,0040,0B40 ; Tourian entrance statue - Kraid
$87:855E             dw 84E4,0080,0CA0 ; Tourian entrance statue - Draygon
}


;;; $8564..AA03: Animated tiles ;;;
{
;;; $8564: Crateria 4 - Crateria lake ;;;
{
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
; |FF7777FF|FF77777F|F777FFFF|F777777F|    |FF7777FF|FF77777F|F777FFFF|F777777F|    |FF7777FF|FF77777F|F777FFFF|F777777F|
; |77777777|77777777|77777777|77777777|    |77777777|77777777|77777777|77777777|    |77777777|77777777|77777777|77777777|
; |66666667|77777777|76677777|77767766|    |66666677|77777777|66777777|77677666|    |66666777|77777776|67777777|76776666|
; |66666666|66666666|67777777|76667777|    |76666666|66666666|66777777|77666777|    |77666666|66666666|66677777|77766677|
; |65555555|66666677|76666555|55666666|    |55555556|66666777|66665555|56666666|    |55555566|66667776|66655555|66666665|
; |66666666|66666666|66666666|66666666|    |66666666|66666666|66666666|66666666|    |66666666|66666666|66666666|66666666|
; |55555555|55555666|55555566|66666555|    |55555555|55556665|55555666|66665555|    |55555555|55566655|55556666|66655555|
; |55555566|66666665|66666666|66666555|    |55555556|66666666|56666666|66666655|    |55555555|66666666|65666666|66666665|
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
; |66654444|44456666|55555555|56666666|    |66544444|44566665|55555555|66666666|    |65444444|45666655|55555556|66666666|
; |55555555|55555555|55666666|55555555|    |55555555|55555555|55566666|65555555|    |55555555|55555555|55556666|66555555|
; |65666655|55555554|44444445|55445566|    |56666555|55555544|44444455|54455666|    |66665555|55555444|44444555|44556665|
; |44444444|55555555|55555555|55444444|    |44444444|45555555|55555555|55544444|    |44444444|44555555|55555555|55554444|
; |55544444|44444444|44444445|55555555|    |54444444|44444444|44444555|55555555|    |44444444|44444444|44455555|55555554|
; |55555555|54444455|55555555|55555555|    |55555555|55544444|55555555|55555555|    |55555555|55555444|44555555|55555555|
; |55555555|55555555|55555555|44444555|    |55555555|55555555|55555544|44455555|    |55555555|55555555|55554444|45555555|
; |55544444|55555554|44444444|44444555|    |55555444|44555555|54444444|44444445|    |45555554|44445555|55544444|44444444|
; |--------|--------|--------|--------| => |--------|--------|--------|--------| => |--------|--------|--------|--------|
; |44554444|44444444|45555555|44444444|    |55444444|44444445|55555544|44444444|    |44444444|44444555|55554444|44444455|
; |55544455|54444444|44455554|45555555|    |55555444|55544444|44444555|54455555|    |55555554|44555444|44444445|55544555|
; |54555555|55555555|55554444|55555555|    |55555555|55555555|55444455|55555554|    |55555555|55555555|44445555|55555455|
; |55555444|44445555|55555555|54444444|    |44555554|44444455|55555555|55544444|    |44445555|54444444|55555555|55555444|
; |44444444|44444555|55555555|54444444|    |44444444|44455555|55555554|44444444|    |44444444|45555555|55555444|44444444|
; |44444455|55555555|55444444|44444444|    |44444444|55555555|55554444|44444444|    |44444444|44555555|55555544|44444444|
; |44444455|55555555|55544444|44444444|    |44445555|55555555|54444444|44444444|    |44555555|55555554|44444444|44444444|
; |55555554|44455555|54444444|44455555|    |55555555|54444555|55544444|44444555|    |55555555|55544445|55555444|44444445|
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
; |55555444|44444444|45555555|44445555|    |55544444|44444445|55555544|44555555|    |54444444|44444555|55554444|55555555|
; |44444444|44445555|55555555|55554444|    |44444444|44444455|55555555|55555544|    |44444444|44444444|55555555|55555555|
; |54544444|44444555|55555544|44555555|    |54444444|44455555|55554444|55555554|    |44444444|45555555|55444455|55555454|
; |55544445|55555544|44444444|44555555|    |55555444|45555555|44444444|44445555|    |55555554|44455555|55444444|44444455|
; |55555555|54445555|44444444|44444444|    |55555554|44555544|44444444|44444455|    |55555444|55554444|44444444|44445555|
; |45555444|44555544|44444444|44444444|    |44455554|44445555|44444444|44444444|    |44444555|54444455|55444444|44444444|
; |44555554|44444444|45554444|44444444|    |55555444|44444445|55444444|44444444|    |55544444|44444555|44444444|44444455|
; |54444444|44444444|44444444|44555555|    |55544444|44444444|44444444|44445555|    |55555444|44444444|44444444|44444455|
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
$87:8564             db FF,FF,FF,FF,01,FF,00,FF,7F,80,00,FF,FF,00,FC,03,FF,C3,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,FF,FF,00,FF,03,FF,00,FF,F8,07,01,FE,FF,C1,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,9F,FF,7F,FF,87,F8,00,FF,FC,03,00,FF,FF,8F,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,EC,FF,8F,FF,C0,3F,00,FF,07,F8,07,F8,FF,81,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        10,E0,FF,00,43,BC,00,00,E0,00,FF,00,FF,00,E0,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        10,0F,FF,00,FE,00,FF,00,00,00,83,00,FF,00,FE,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,00,C0,3F,01,00,FF,00,01,00,FF,00,FF,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        80,7F,FF,00,CC,03,C0,00,FF,00,FF,00,07,00,07,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        30,00,E3,00,BF,00,F8,00,00,00,03,00,03,00,FE,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,80,00,FF,00,0F,00,07,00,FF,00,FF,00,1F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        7F,00,1E,00,F0,00,FF,00,FF,00,C0,00,E0,00,80,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,7F,00,FF,00,80,00,80,00,00,00,00,00,1F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        F8,00,00,00,A0,00,E1,00,FF,00,78,00,3E,00,80,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,0F,00,07,00,FC,00,8F,00,3C,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        7F,00,FF,00,FC,00,00,00,00,00,00,00,70,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        0F,00,F0,00,3F,00,3F,00,00,00,00,00,00,00,3F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00

$87:8764             db FF,FF,FF,FF,03,FF,80,FF,FE,01,00,FF,FF,00,FE,01,FF,C3,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,FF,FF,00,FF,07,FF,00,FF,F1,0E,00,FF,FF,C1,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,3F,FF,3F,FF,0F,F0,00,FF,F8,07,80,7F,FF,8F,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,D8,FF,C7,FF,80,7F,00,FF,0F,F0,03,FC,FF,81,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        20,C0,FF,00,87,78,00,00,80,00,FF,00,FF,00,F8,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        21,1E,FF,00,FC,00,7F,00,00,00,E0,00,FF,00,3F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,00,E0,1F,03,00,FF,00,07,00,FF,00,FC,00,80,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,FF,7F,80,98,07,E0,00,FF,00,FF,00,1F,00,01,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        C0,00,F8,00,FF,00,3E,00,00,00,00,00,0F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        01,00,E0,00,FF,00,03,00,1F,00,FF,00,FF,00,87,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FC,00,07,00,C3,00,FF,00,FE,00,F0,00,80,00,E0,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,9F,00,FE,00,E0,00,00,00,00,00,00,00,07,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        E0,00,00,00,80,00,F8,00,FE,00,1E,00,F8,00,E0,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        01,00,03,00,1F,00,7F,00,3C,00,0F,00,01,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FC,00,FF,00,F0,00,00,00,00,00,00,00,C0,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        3F,00,FC,00,FE,00,0F,00,03,00,00,00,00,00,0F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00

$87:8964             db FF,FF,FF,FF,07,FF,C0,FF,FC,03,00,FF,FF,00,FF,00,FF,C3,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,FE,FF,00,FF,0E,FF,00,FF,E3,1C,00,FF,FF,C1,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,7F,FF,1F,FF,1F,E0,00,FF,F0,0F,40,BF,FF,8F,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,FF,FF,FF,B0,FF,E3,FF,01,FE,00,FF,1F,E0,01,FE,FF,81,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        40,80,FF,00,0F,F0,00,00,00,00,FF,00,FF,00,7E,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        43,3C,FF,00,F8,00,3F,00,00,00,F8,00,FF,00,0F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FE,01,F0,0F,07,00,FF,00,1F,00,3F,00,F0,00,E0,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,FF,3F,C0,31,0E,F0,00,FE,00,FF,00,7F,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,FE,00,FF,00,0F,00,00,00,00,00,3F,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        07,00,38,00,FF,00,80,00,7F,00,3F,00,FE,00,E1,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        F0,00,01,00,0F,00,FF,00,F8,00,FC,00,00,00,F8,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        03,00,E7,00,FB,00,F8,00,00,00,00,00,00,00,01,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        80,00,00,00,00,00,FE,00,F8,00,07,00,E0,00,F8,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        07,00,00,00,7F,00,1F,00,F0,00,83,00,07,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        F0,00,FF,00,C3,00,C0,00,00,00,C0,00,00,00,00,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        FF,00,FF,00,FA,00,03,00,0F,00,00,00,03,00,03,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00
}


;;; $8B64: Crateria 8 - unused Crateria lava ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|    |--------|--------|
; |        |        |    |        |        |    |        |        |    |        |        |
; |        |        |    |        |        |    |        |        |    |        |        |
; |        |        |    |        |        |    |        |        |    |        |        |
; |        |        |    |        |        |    |        |        |    |        |        |
; |        |        |    |        |        |    |        |        |    |    8   |D       |
; |        |        |    |        |        |    |    D9  |D9      |    | D      |   8    |
; |   D    |  9     |    |     DDD|9       |    | 8D  8  |8  8D   |    |        |        |
; |99   DDD|9   D 99|    |  9DE888|89C9    |    |  8899DD|9988    |    |   8 99 | D   99 |
; |--------|--------|    |--------|--------|    |--------|--------|    |--------|--------|
; |9888DD88|89888899|    |988DD888|899C8899|    |9D89C999|9C99D889|    |88999889|9988DD99|
; |9D88D888|9C8DDD89|    |9D88DD88|99C99DD9|    |88DCDCDD|CDCD88D9|    |998999DD|98899888|
; |99888D89|C8998899|    |99988889|CC889999|    |999D8D88|D8D88999|    |98898888|89999999|
; |89989888|9999D998|    |88DD9888|999999D9|    |D9999988|89989999|    |899DD999|DD988988|
; |99999899|99999999| => |99999999|C9999999| => |99999999|99999999| => |99999999|999998D8|
; |99998D89|99999999|    |99999999|99999999|    |99C99999|99999999|    |99999999|99999989|
; |99999899|9F999999|    |99999999|99999999|    |99999999|99999D99|    |99999999|99999999|
; |99999999|99999999|    |9F999999|99998999|    |99999999|99999999|    |999999D9|99999999|
; |--------|--------|    |--------|--------|    |--------|--------|    |--------|--------|
; |99999999|99999999|    |99999999|9998D899|    |99999899|99999999|    |99999999|99F99999|
; |99C99999|99999999|    |99999999|99998999|    |99998D89|99999999|    |99999999|99999999|
; |99999999|99999D99|    |99999999|99999999|    |99999899|9C999999|    |99999999|99999999|
; |99999999|99999999|    |9999D999|99999999|    |99999999|99999999|    |999C9999|99999989|
; |99999899|99999999|    |99999999|C9999999|    |99999999|99999999|    |99999999|999998D8|
; |99998D89|99999999|    |99999999|99999999|    |99C99999|99999999|    |99999999|99999989|
; |99999899|9F999999|    |99999999|99999999|    |99999999|99999D99|    |99999999|99999999|
; |99999999|99999999|    |9F999999|99998999|    |99999999|99999999|    |999999D9|99999999|
; |--------|--------|    |--------|--------|    |--------|--------|    |--------|--------|
$87:8B64             db 00,00,00,00,00,00,00,00,00,00,00,00,10,00,C7,00,00,00,00,00,00,00,00,00,00,00,00,00,10,10,07,C7,
                        00,00,00,00,00,00,00,00,00,00,00,00,20,00,8B,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,08,8B,
                        8C,00,C8,00,C5,00,68,00,FB,00,F5,00,FB,00,FF,00,0C,FF,48,FF,04,FF,00,FF,00,FF,04,FF,00,FF,00,FF,
                        43,00,9D,00,33,00,FE,00,FF,00,FF,00,FF,40,FF,00,00,FF,5C,FF,80,FF,08,FF,00,FF,00,FF,40,FF,00,FF,
                        FF,00,DF,00,FF,00,FF,00,FB,00,F5,00,FB,00,FF,00,00,FF,20,FF,00,FF,00,FF,00,FF,04,FF,00,FF,00,FF,
                        FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,40,FF,00,00,FF,00,FF,04,FF,00,FF,00,FF,00,FF,40,FF,00,FF

$87:8C24             db 00,00,00,00,00,00,00,00,00,00,00,00,07,00,30,08,00,00,00,00,00,00,00,00,00,00,00,00,07,07,18,3F,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,00,50,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,20,F0,
                        98,00,CC,00,E1,00,38,00,FF,00,FF,00,FF,00,FF,40,18,FF,4C,FF,00,FF,30,FF,00,FF,00,FF,00,FF,40,FF,
                        63,00,DF,00,0F,00,FF,00,7F,00,FF,00,FF,00,F7,00,10,FF,26,FF,C0,FF,02,FF,80,FF,00,FF,00,FF,00,FF,
                        FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,40,00,FF,00,FF,00,FF,08,FF,00,FF,00,FF,00,FF,40,FF,
                        EB,00,F7,00,FF,00,FF,00,7F,00,FF,00,FF,00,F7,00,08,FF,00,FF,00,FF,00,FF,80,FF,00,FF,00,FF,00,FF

$87:8CE4             db 00,00,00,00,00,00,00,00,00,00,0C,00,20,00,0F,00,00,00,00,00,00,00,00,00,00,00,08,0C,20,64,03,3F,
                        00,00,00,00,00,00,00,00,00,00,C0,00,08,00,C0,00,00,00,00,00,00,00,00,00,00,00,80,C0,08,98,00,F0,
                        D7,00,2B,00,F4,00,FC,00,FF,00,DF,00,FF,00,FF,00,48,FF,3F,FF,14,FF,80,FF,00,FF,20,FF,00,FF,00,FF,
                        B9,00,53,00,A7,00,6F,00,FF,00,FF,00,FF,00,FF,00,48,FF,F2,FF,A0,FF,00,FF,00,FF,00,FF,04,FF,00,FF,
                        FB,00,F5,00,FB,00,FF,00,FF,00,DF,00,FF,00,FF,00,00,FF,04,FF,00,FF,00,FF,00,FF,20,FF,00,FF,00,FF,
                        FF,00,FF,00,BF,00,FF,00,FF,00,FF,00,FF,00,FF,00,00,FF,00,FF,40,FF,00,FF,00,FF,00,FF,04,FF,00,FF

$87:8DA4             db 00,00,00,00,00,00,00,00,00,00,40,00,00,00,06,00,00,00,00,00,00,00,00,00,00,08,40,40,00,00,00,16,
                        00,00,00,00,00,00,00,00,80,00,00,00,00,00,46,00,00,00,00,00,00,00,00,00,80,80,00,10,00,00,40,46,
                        39,00,DF,00,90,00,7F,00,FF,00,FF,00,FF,00,FF,00,00,FF,03,FF,00,FF,18,FF,00,FF,00,FF,00,FF,02,FF,
                        CF,00,98,00,7F,00,E4,00,FA,00,FD,00,FF,00,FF,00,0C,FF,00,FF,00,FF,C0,FF,02,FF,00,FF,00,FF,00,FF,
                        FF,00,FF,00,FF,00,EF,00,FF,00,FF,00,FF,00,FF,00,00,FF,00,FF,00,FF,10,FF,00,FF,00,FF,00,FF,02,FF,
                        FF,20,FF,00,FF,00,FD,00,FA,00,FD,00,FF,00,FF,00,20,FF,00,FF,00,FF,00,FF,02,FF,00,FF,00,FF,00,FF
}


;;; $8E64: Wrecked Ship 4/8 - Wrecked Ship treadmill ;;;
{
; |--------|    |--------|    |--------|    |--------|
; | AAAAAA |    |A  AAAAA|    |AAA  AAA|    |AAAAA  A|
; |AEE8888A|    |8AAEE888|    |888AAEE8|    |E8888AAE|
; |B999999B|    |9BB99999|    |999BB999|    |99999BB9|
; |BAAAAAAB|    |ABBAAAAA|    |AAABBAAA|    |AAAAABBA|
; |FBBBBBBF| => |BFFBBBBB| => |BBBFFBBB| => |BBBBBFFB|
; |FFFFFFFF|    |FFFFFFFF|    |FFFFFFFF|    |FFFFFFFF|
; |7EE44444|    |7EE44444|    |7EE44444|    |7EE44444|
; |75555555|    |75555555|    |75555555|    |75555555|
; |--------|    |--------|    |--------|    |--------|
$87:8E64             db 00,7E,00,E1,FF,81,81,FF,FF,FF,FF,FF,80,E0,FF,80,00,7E,60,FF,00,FF,00,FF,81,FF,FF,FF,FF,60,FF,00
$87:8E84             db 00,9F,00,78,FF,60,60,FF,FF,FF,FF,FF,80,E0,FF,80,00,9F,18,FF,00,FF,00,FF,60,FF,FF,FF,FF,60,FF,00
$87:8EA4             db 00,E7,00,1E,FF,18,18,FF,FF,FF,FF,FF,80,E0,FF,80,00,E7,06,FF,00,FF,00,FF,18,FF,FF,FF,FF,60,FF,00
$87:8EC4             db 00,F9,00,87,FF,06,06,FF,FF,FF,FF,FF,80,E0,FF,80,00,F9,81,FF,00,FF,00,FF,06,FF,FF,FF,FF,60,FF,00
}


;;; $8EE4: Wrecked Ship 10h - Wrecked Ship screen ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; |3333333F|F3333333|    |33333333|3FF39999|    |3333333F|F3333333|
; |39999FFF|11212222|    |999933FF|FF112122|    |3333FFFF|11212222|
; |33FF1111|22222222|    |3333FF11|11222222|    |3339999F|11199222|
; |3FF11129|99933333|    |333FF111|29999933|    |33333FF1|11221223|
; |3333F111|22222232|    |33F11122|22223233|    |3333F111|22222232|
; |333FF112|12223999|    |3FF11212|22332333|    |333FF112|12299923|
; |333F1122|22332333|    |3F112999|992333CC|    |11999993|2333CCCC|
; |99999212|2323333C|    |F1121223|23333CDD|    |12122323|333CDDDD|
; |--------|--------| => |--------|--------| => |--------|--------|
; |12223333|399999CD|    |F1122233|3333CDDC|    |12223333|33CDD999|
; |22232333|33CDCDDC|    |F1222323|33999DCD|    |22232333|33CDCDDC|
; |12323333|3FCCDCCD|    |12123233|333FCCDC|    |33121239|99933FCC|
; |22233333|3FCCCC8C|    |99992333|333FCC8C|    |33122223|33333F8C|
; |33222339|9999CC8C|    |22233333|CCCCFC89|    |99222333|33CCCC8C|
; |33123233|3CDCDE8F|    |12329999|9CDCCE8C|    |33123233|3CDCDE8F|
; |39999933|CDC888CC|    |223333CD|CDC888FF|    |33399999|CCC888FF|
; |33233333|CDDCCCCC|    |233333CD|DCCCCCFF|    |3333CDDC|CCCCFFFF|
; |--------|--------|    |--------|--------|    |--------|--------|
$87:8EE4             db FF,FF,FF,87,FF,F0,FD,E2,FF,F8,FE,F9,FC,F3,FA,05,01,01,07,7F,30,30,60,61,08,08,18,18,10,10,00,F8,
                        FF,FF,D0,2F,00,FF,FF,1F,02,FF,8F,78,37,FF,5E,FE,80,80,00,00,00,00,00,E0,00,00,00,07,00,00,01,01,
                        8F,7F,17,FF,AF,7F,1F,FF,C7,FE,EB,DF,FF,83,DF,FF,00,00,00,00,00,00,00,00,00,01,00,00,00,7C,00,00,
                        FD,80,D6,C0,C9,C0,C0,C0,F0,00,A9,85,40,00,60,00,03,7F,3F,3F,7F,7F,7D,7F,0D,FF,7D,7F,E3,FF,FF,FF

$87:8F64             db FF,FF,FF,0F,FF,FC,FF,F8,FC,E3,FA,E5,F7,C8,E9,97,00,00,03,F3,0C,0C,18,18,20,20,60,60,40,47,80,80,
                        FF,F0,F4,CB,C0,3F,7F,83,0B,FF,37,FF,DC,3C,7B,F8,60,6F,C0,C0,00,00,00,7C,00,00,00,00,03,C3,07,07,
                        E3,9F,C5,BF,AB,5F,F7,0F,1F,FF,AF,70,3D,FC,7D,FC,80,80,80,80,00,00,00,F0,00,00,00,0F,03,03,03,03,
                        F6,F0,FD,C0,F2,F0,F0,F0,09,08,A0,04,43,03,83,03,0F,0F,07,3F,1F,1F,1D,1F,FC,FF,7D,FF,E3,FF,FF,FF

$87:8FE4             db FF,FF,FF,FF,FF,E1,FF,FE,FF,F8,FE,F9,FF,01,A5,5F,01,01,0F,0F,01,1F,06,06,08,08,18,18,00,3E,00,00,
                        FF,FF,D0,2F,F8,07,C9,37,02,FF,9D,63,70,F0,EF,E0,80,80,00,00,00,18,00,00,00,00,00,1C,0F,0F,1F,1F,
                        8F,7F,17,FF,EB,D6,E1,DF,C7,3F,EB,DF,FF,E0,F6,F0,00,00,00,00,00,01,00,00,00,C0,00,00,00,1F,0F,0F,
                        DF,C0,D6,C0,FC,1C,FC,FC,C0,C0,A9,85,03,03,0F,0F,38,3F,3F,3F,07,E7,05,07,3D,3F,7D,7F,E3,FF,FF,FF
}


;;; $9064: Unused. "X" ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|
$87:9064             db 00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00
}


;;; $9164: Maridia 8 - Maridia sand falling ;;;
{
; |--------|    |--------|    |--------|    |--------|
; |5 7 5 5 |    | 5 7 7 7|    | 6 6 6  |    |  6 7 7 |
; | 4 6 6  |    |  7 5 4 |    |5 4 4 6 |    | 7 4 5 5|
; |7 6 7 7 |    | 4 6 6 6|    | 5 7 7 7|    |6 6   5 |
; | 7 4 5 5|    |7 6   7 |    |5 7 5 4 |    | 6 6 6 4|
; |  6 6 4 | => | 7 4 5 5| => | 4 6 6 6| => |5 4 4 6 |
; | 6 6 6 4|    |6 6 6 5 |    |  6 7   |    | 5 7 7 7|
; |5 4   6 |    | 6 6 6  |    | 7 4 5 5|    |5 7 5 4 |
; | 5 7 7 7|    |5 4 4 6 |    |6 6 6 5 |    | 4 6 6  |
; |--------|    |--------|    |--------|    |--------|
$87:9164             db AA,20,00,14,8A,AA,45,40,00,28,00,54,80,02,55,15,AA,00,54,00,AA,00,55,00,2A,00,55,00,A2,00,55,00
$87:9184             db 55,15,28,20,00,15,82,A2,45,40,02,A8,00,54,80,02,55,00,2A,00,55,00,A2,00,55,00,AA,00,54,00,AA,00
$87:91A4             db 00,54,80,02,55,15,A8,20,00,15,08,28,45,40,02,A8,54,00,AA,00,55,00,AA,00,55,00,28,00,55,00,AA,00
$87:91C4             db 0A,2A,45,40,02,A0,00,54,80,02,55,15,A8,20,00,14,2A,00,55,00,A2,00,55,00,AA,00,55,00,AA,00,54,00
}


;;; $91E4: Maridia 4 - Maridia sand ceiling ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|    |--------|--------|
; |99B99898|998A9999|    |99B99898|998A9999|    |99B99898|998A9999|    |99B99898|998A9999|
; |AA98E998|89E9A899|    |AA98E998|89E9A899|    |AA98E998|89E9A899|    |AA98E998|89E9A899|
; |988EE9E9|8EE89EA9|    |988EE9E9|8EE89EA9|    |988EE9E9|8EE89EA9|    |988EE9E9|8EE89EA9|
; |9E8EE989|9EEEAE99|    |9E8EE989|9EEEAE99|    |9E8EE989|9EEEAE99|    |9E8EE989|9EEEAE99|
; |8E989ABB|AE88A8EE| => |8E989ABB|AE88A8EE| => |8E989ABB|AE88A8EE| => |8E989ABB|AE88A8EE|
; |889BAB7 |BAA8A889|    |889BAB5 |BAA8A889|    |889BAB7 |BAA8A889|    |889BAB5 |BAA8A889|
; |9AA7 6 6| 6 BBAA8|    |9AA5 4 4| 4 BBAA8|    |9AA7 6 6| 6 BBAA8|    |9AA5 4 4| 4 BBAA8|
; |BB5 6 5 |4 5 6BAB|    |BB7 4 7 |6 7 4BAB|    |BB5 6 5 |4 5 6BAB|    |BB7 4 7 |6 7 4BAB|
; |--------|--------|    |--------|--------|    |--------|--------|    |--------|--------|
$87:91E4             db FA,20,26,C8,85,1A,85,58,2B,47,36,1E,90,75,E2,C8,00,FF,08,FF,1A,FF,58,FF,40,FF,02,FC,15,E0,2A,C0,
                        CF,10,53,28,09,66,83,7C,00,CB,81,E8,18,5E,25,0F,00,FF,20,FF,64,FF,74,FF,43,FF,00,FF,40,1F,A8,07

$87:9224             db FA,20,26,C8,85,1A,85,58,2B,47,36,1C,90,60,E2,E2,00,FF,08,FF,1A,FF,58,FF,40,FF,02,FC,15,E0,2A,C0,
                        CF,10,53,28,09,66,83,7C,00,CB,81,E8,18,1E,25,A7,00,FF,20,FF,64,FF,74,FF,43,FF,00,FF,40,1F,A8,07

$87:9264             db FA,20,26,C8,85,1A,85,58,2B,47,36,1E,90,75,E2,C8,00,FF,08,FF,1A,FF,58,FF,40,FF,02,FC,15,E0,2A,C0,
                        CF,10,53,28,09,66,83,7C,00,CB,81,E8,18,5E,25,0F,00,FF,20,FF,64,FF,74,FF,43,FF,00,FF,40,1F,A8,07

$87:92A4             db FA,20,26,C8,85,1A,85,58,2B,47,36,1C,90,60,E2,E2,00,FF,08,FF,1A,FF,58,FF,40,FF,02,FC,15,E0,2A,C0,
                        CF,10,53,28,09,66,83,7C,00,CB,81,E8,18,1E,25,A7,00,FF,20,FF,64,FF,74,FF,43,FF,00,FF,40,1F,A8,07
}


;;; $92E4: Unused. "X" ;;;
{
; |--------|--------|--------|--------|
; |        |        |        |        |
; | E   E  | E   E  | E   E  | E   E  |
; |  E E   |  E E   |  E E   |  E E   |
; |   E    |   E    |   E    |   E    |
; |  E E   |  E E   |  E E   |  E E   |
; | E   E  | E   E  | E   E  | E   E  |
; |        |        |        |        |
; |        |        |        |        |
; |--------|--------|--------|--------|
$87:92E4             db 00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00
}


;;; $9364: Phantoon statue ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; |67434775|58855587|    |67434775|58855587|    |67434775|58855587|
; |73223455|65544458|    |73223455|65544458|    |73223455|65544458|
; |32455545|64555445|    |32455545|64555445|    |32455545|64555445|
; |45666665|66666654|    |45666665|66666654|    |45666665|66666654|
; |56888184|68488865|    |56888184|68488865|    |56888184|68488865|
; |68838387|78384886|    |68838387|78384886|    |68838387|78384886|
; |81688EED|DEE88638|    |81688FEE|EEF88638|    |81688FEE|EEF88638|
; |6618EDDC|CDDE8366|    |6618FEED|DEEF8366|    |6618FEEE|EEEF8366|
; |--------|--------| => |--------|--------| => |--------|--------|
; |2688EDCC|CCDE8864|    |2688EEDD|DDEE8864|    |2688EEED|EEEE8864|
; |6488DCC1|CCCD8846|    |6488EDD1|DDDE8846|    |6488EED1|DEEE8846|
; |8888DCCC|CCCD8888|    |8888EDDD|DDDE8888|    |8888EEED|EEEE8888|
; |8888EDCC|CCDE8888|    |8888EEDD|DDEE8888|    |8888EEEE|EEEE8888|
; |8888EDDC|CDDE8888|    |8888FEED|DEEF8888|    |8888FEEE|EEEF8888|
; |28888EED|DEE88883|    |28888FEE|EEF88883|    |28888FEE|EEF88883|
; |68288887|78888386|    |68288887|78888386|    |68288887|78888386|
; |68381884|68838486|    |68381884|68838486|    |68381884|68838486|
; |--------|--------|    |--------|--------|    |--------|--------|
$87:9364             db 57,D6,CB,F8,9D,C0,41,3E,84,40,15,95,41,26,26,C8,EF,00,87,00,3F,00,FF,00,C1,3A,81,6A,27,9F,CF,1F,
                        9D,01,62,80,39,80,02,FC,01,82,A0,A1,82,66,64,17,9D,62,FE,01,FF,00,FF,00,A3,5C,89,56,E4,F9,F3,F8,
                        04,C8,09,80,08,00,04,08,06,08,01,86,01,A1,28,A0,4F,3F,CE,3E,0F,FF,0F,FF,0F,FF,07,7F,81,5E,81,56,
                        20,12,10,01,10,00,20,10,60,10,81,61,84,85,10,91,F3,FC,F3,FC,F0,FF,F0,FF,F0,FF,E0,FE,81,7A,85,6A

$87:93E4             db 57,D6,CB,F8,9D,C0,41,3E,84,40,15,95,44,27,29,CE,EF,00,87,00,3F,00,FF,00,C1,3A,81,6A,27,9F,CF,1F,
                        9D,01,62,80,39,80,02,FC,01,82,A0,A1,22,E6,94,77,9D,62,FE,01,FF,00,FF,00,A3,5C,89,56,E4,F9,F3,F8,
                        03,CC,07,88,07,08,03,0C,09,0E,04,87,01,A1,28,A0,4F,3F,CE,3E,0F,FF,0F,FF,0F,FF,07,7F,81,5E,81,56,
                        C0,32,E0,11,E0,10,C0,30,90,70,21,E1,84,85,10,91,F3,FC,F3,FC,F0,FF,F0,FF,F0,FF,E0,FE,81,7A,85,6A

$87:9464             db 57,D6,CB,F8,9D,C0,41,3E,84,40,15,95,44,27,28,CF,EF,00,87,00,3F,00,FF,00,C1,3A,81,6A,27,9F,CF,1F,
                        9D,01,62,80,39,80,02,FC,01,82,A0,A1,22,E6,14,F7,9D,62,FE,01,FF,00,FF,00,A3,5C,89,56,E4,F9,F3,F8,
                        01,CE,03,8C,01,0E,00,0F,08,0F,04,87,01,A1,28,A0,4F,3F,CE,3E,0F,FF,0F,FF,0F,FF,07,7F,81,5E,81,56,
                        00,F2,80,71,00,F0,00,F0,10,F0,21,E1,84,85,10,91,F3,FC,F3,FC,F0,FF,F0,FF,F0,FF,E0,FE,81,7A,85,6A
}


;;; $94E4: Ridley statue ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; | 8656778|8FF88788|    | 8656778|8FF88788|    | 8656778|8FF88788|
; |76566791|99887787|    |765667A1|AA887787|    |765667B1|BB887787|
; |65457919|98876687|    |65457A1A|A8876687|    |65457B1B|B8876687|
; |54579999|88765568|    |5457AAAA|88765568|    |5457BBBB|88765568|
; |36899777|76654456| => |368AA777|76654456| => |368BB777|76654456|
; |68977665|55387756|    |68A77665|55387756|    |68B77665|55387756|
; |87765446|78488667|    |87765446|78488667|    |87765446|78488667|
; |76544657|58557877|    |76544657|58557877|    |76544657|58557877|
; |--------|--------|    |--------|--------|    |--------|--------|
$87:94E4             db 16,2E,A7,DC,5F,88,BF,10,9F,C7,39,9E,68,71,A3,C5,3E,41,FC,02,F8,05,F0,0F,47,38,9F,60,7F,80,FF,00,
                        64,64,CD,0D,91,1D,2C,32,92,E1,EE,2D,81,87,BB,0B,64,FB,0D,F2,1D,E2,3E,C1,FF,00,CF,10,A7,58,BB,44

$87:9524             db 16,2E,A5,DE,5A,8D,B0,1F,87,DF,19,BE,68,71,A3,C5,3E,41,FC,02,F8,05,F0,0F,47,38,9F,60,7F,80,FF,00,
                        64,64,0D,CD,11,9D,2C,32,92,E1,EE,2D,81,87,BB,0B,64,FB,0D,F2,1D,E2,3E,C1,FF,00,CF,10,A7,58,BB,44

$87:9564             db 16,2E,A7,DE,5F,8D,BF,1F,9F,DF,39,BE,68,71,A3,C5,3E,41,FC,02,F8,05,F0,0F,47,38,9F,60,7F,80,FF,00,
                        64,64,CD,CD,91,9D,2C,32,92,E1,EE,2D,81,87,BB,0B,64,FB,0D,F2,1D,E2,3E,C1,FF,00,CF,10,A7,58,BB,44
}


;;; $95A4: Draygon statue ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; |76777687|53586554|    |76777687|53586554|    |76777687|53586554|
; |87677687|53565554|    |87677687|53565554|    |87677687|53565554|
; |87767787|54554453|    |87767787|54554453|    |87767787|54554453|
; |88777787|64644533|    |88777787|64644533|    |88777787|64644533|
; |88877787|65543353|    |88877787|65543353|    |88877787|65543353|
; |88888887|75443354|    |88888887|75443354|    |88888887|75443354|
; |8888AAA7|76554456|    |8888AAA7|76554456|    |8888BBB7|76554456|
; |888A999A|87665567|    |888AAAAA|87665567|    |888BBBBB|87665567|
; |--------|--------| => |--------|--------| => |--------|--------|
; |88899919|A8776678|    |888AAA1A|A8776678|    |888BBB1B|B8776678|
; |888A9999|A887778 |    |888AAAAA|A887778 |    |888BBBBB|B887778 |
; |5778A99A|877888  |    |5778AAAA|877888  |    |5778BBBB|877888  |
; |75466777|88677   |    |75466777|88677   |    |75466777|88677   |
; |87543457|64457   |    |87543457|64457   |    |87543457|64457   |
; |54778864|45868   |    |54778864|45868   |    |54778864|45868   |
; |75486545|888548  |    |75486545|888548  |    |75486545|888548  |
; |58886588|668888  |    |58886588|668888  |    |58886588|668888  |
; |--------|--------|    |--------|--------|    |--------|--------|
$87:95A4             db B9,FD,59,7D,6D,7D,3D,3D,1D,1D,01,01,01,0F,0E,11,FD,02,7D,82,7D,82,3D,C2,1D,E2,01,FE,01,FE,00,FF,
                        E6,48,EE,50,B3,01,07,A3,6F,8D,CE,8C,B2,C1,4D,73,AF,10,BF,00,FE,00,FC,00,F2,00,F3,00,FF,00,7F,80,
                        1F,00,0F,10,E6,69,C7,9F,6B,49,B0,32,C5,88,84,08,00,FD,00,FF,E0,1F,FF,00,77,80,F3,0C,EF,10,8C,73,
                        32,BE,1C,9C,60,60,18,38,18,88,40,10,10,00,00,C0,3E,C1,1C,E2,60,9C,38,C0,F8,00,D0,28,18,E4,C0,3C

$87:9624             db B9,FD,59,7D,6D,7D,3D,3D,1D,1D,01,01,01,0F,00,1F,FD,02,7D,82,7D,82,3D,C2,1D,E2,01,FE,01,FE,00,FF,
                        E6,48,EE,50,B3,01,07,A3,6F,8D,CE,8C,B2,C1,4D,73,AF,10,BF,00,FE,00,FC,00,F2,00,F3,00,FF,00,7F,80,
                        02,1D,00,1F,E0,6F,C7,9F,6B,49,B0,32,C5,88,84,08,00,FD,00,FF,E0,1F,FF,00,77,80,F3,0C,EF,10,8C,73,
                        32,BE,1C,9C,60,60,18,38,18,88,40,10,10,00,00,C0,3E,C1,1C,E2,60,9C,38,C0,F8,00,D0,28,18,E4,C0,3C

$87:96A4             db B9,FD,59,7D,6D,7D,3D,3D,1D,1D,01,01,0F,0F,1F,1F,FD,02,7D,82,7D,82,3D,C2,1D,E2,01,FE,01,FE,00,FF,
                        E6,48,EE,50,B3,01,07,A3,6F,8D,CE,8C,B2,C1,4D,73,AF,10,BF,00,FE,00,FC,00,F2,00,F3,00,FF,00,7F,80,
                        1F,1D,1F,1F,EF,6F,C7,9F,6B,49,B0,32,C5,88,84,08,00,FD,00,FF,E0,1F,FF,00,77,80,F3,0C,EF,10,8C,73,
                        B2,BE,9C,9C,60,60,18,38,18,88,40,10,10,00,00,C0,3E,C1,1C,E2,60,9C,38,C0,F8,00,D0,28,18,E4,C0,3C
}


;;; $9724: Kraid statue ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; |      63|46386777|    |      63|46386777|    |      63|46386777|
; |     848|88487358|    |     848|88487358|    |     848|88487358|
; |     88C|85843846|    |     88D|85843846|    |     88E|85843846|
; |     81C|85888858|    |     81D|85888858|    |     81E|85888858|
; | 8   8CC|68CCC868| => | 8   8DD|68DDD868| => | 8   8EE|68EEE868|
; | 68  8C8|6C1CE856|    | 68  8D8|6D1D8856|    | 68  8E8|6E1E8856|
; | 48  786|88888544|    | 48  786|88888544|    | 48  786|88888544|
; | 4688666|65554488|    | 4688666|65554488|    | 4688666|65554488|
; |--------|--------|    |--------|--------|    |--------|--------|
$87:9724             db 01,03,00,00,00,00,02,00,00,00,00,40,04,05,00,27,02,00,02,05,01,07,01,05,03,47,42,27,45,22,67,18,
                        27,6F,0E,0C,48,09,42,00,00,82,22,89,04,00,70,80,CF,10,2A,D1,53,A4,42,BD,BA,7D,DB,5C,07,F8,FC,03

$87:9764             db 01,03,00,00,01,00,03,00,03,00,02,40,04,05,00,27,02,00,02,05,01,07,01,05,03,47,42,27,45,22,67,18,
                        27,6F,0E,0C,48,09,42,00,38,82,72,81,04,00,70,80,CF,10,2A,D1,53,A4,42,BD,BA,7D,D3,5C,07,F8,FC,03

$87:97A4             db 01,03,00,00,00,01,02,01,00,03,00,42,04,05,00,27,02,00,02,05,01,07,01,05,03,47,42,27,45,22,67,18,
                        27,6F,0E,0C,48,09,42,00,00,BA,22,D1,04,00,70,80,CF,10,2A,D1,53,A4,42,BD,BA,7D,D3,5C,07,F8,FC,03
}


;;; $97E4: Phantoon statue - other ;;;
{
; |--------|--------|
; |67434775|58855587|
; |73223455|65544458|
; |32455545|64555445|
; |45666665|66666654|
; |56888184|68488865|
; |68838387|78384886|
; |81688888|88888638|
; |66188888|88888366|
; |--------|--------|
; |26888888|88888864|
; |64888888|88888846|
; |88888888|88888888|
; |88888888|88888888|
; |88888888|88888888|
; |28888888|88888883|
; |68288887|78888386|
; |68381884|68838486|
; |--------|--------|
$87:97E4             db 57,D6,CB,F8,9D,C0,41,3E,84,40,15,95,40,20,20,C0,EF,00,87,00,3F,00,FF,00,C1,3A,81,6A,20,9F,C0,1F,
                        9D,01,62,80,39,80,02,FC,01,82,A0,A1,02,06,04,07,9D,62,FE,01,FF,00,FF,00,A3,5C,89,56,04,F9,03,F8,
                        00,C0,00,80,00,00,00,00,00,00,00,80,01,A1,28,A0,40,3F,C0,3F,00,FF,00,FF,00,FF,00,7F,81,5E,81,56,
                        00,02,00,01,00,00,00,00,00,00,01,01,84,85,10,91,03,FC,03,FC,00,FF,00,FF,00,FF,00,FE,81,7A,85,6A
}


;;; $9864: Ridley statue - other ;;;
{
; |--------|--------|
; | 8656778|8FF88788|
; |76566788|88887787|
; |65457888|88876687|
; |54578888|88765568|
; |36887777|76654456|
; |68877665|55787756|
; |87765446|78388667|
; |76544667|58467877|
; |--------|--------|
$87:9864             db 16,2E,A4,DC,58,88,B0,10,8F,CF,19,9E,68,71,A1,C7,3E,41,FC,03,F8,07,F0,0F,4F,30,9F,60,7F,80,FF,00,
                        64,64,0D,0D,11,1D,2C,32,92,E1,EE,2D,A1,A7,8B,1B,64,FB,0D,F2,1D,E2,3E,C1,FF,00,EF,10,87,58,BB,44
}


;;; $98A4: Draygon statue - other ;;;
{
; |--------|--------|
; |      63|46386777|
; |     848|88487358|
; | 8   888|85843846|
; | 68  888|85888858|
; | 48  888|68888868|
; | 468 888|68888856|
; | 558 786|88888544|
; |86888666|55558488|
; |--------|--------|
$87:98A4             db 01,03,00,00,00,00,00,40,00,00,00,20,64,05,00,47,02,00,02,05,00,47,40,27,40,27,60,17,65,12,47,B8,
                        27,6F,0E,0C,48,09,42,00,00,82,02,81,04,00,F0,00,CF,10,2A,D1,53,A4,42,BD,82,7D,83,7C,07,F8,F4,0B
}


;;; $98E4: Kraid statue - other ;;;
{
; |--------|--------|
; |76777687|53586554|
; |87677687|53565554|
; |87767787|54554453|
; |88777787|64644533|
; |88877787|65543353|
; |88888887|75443354|
; |88888887|76554456|
; |88888888|87665567|
; |--------|--------|
; |88888888|88766668|
; |88888888|8887778 |
; |57788788|875888  |
; |75466777|8857    |
; |87543457|6678    |
; |54778864|5848    |
; |75486545|183     |
; |58886588|838     |
; |--------|--------|
$87:98E4             db B9,FD,59,7D,6D,7D,3D,3D,1D,1D,01,01,01,01,00,00,FD,02,7D,82,7D,82,3D,C2,1D,E2,01,FE,01,FE,00,FF,
                        E6,48,EE,50,B3,01,07,A3,6F,8D,CE,8C,B2,C1,4D,73,AF,10,BF,00,FE,00,FC,00,F2,00,F3,00,FF,00,7F,80,
                        00,00,00,00,E4,64,C7,9F,6B,49,B0,32,C5,88,84,08,00,FF,00,FF,E4,1B,FF,00,77,80,F3,0C,EF,10,8C,73,
                        20,3E,1C,1C,60,40,30,10,20,E0,80,00,A0,20,40,40,3E,C1,1C,E2,60,9C,30,C0,E0,10,A0,50,00,40,00,A0
}


;;; $9964: Brinstar 4 - Brinstar plant ;;;
{
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
; |        |        |        | BBB BB |    |        |        |        | BBB BB |    |        |        |        | BBB BB |
; |        |        |        | B46BEB |    |        |        |        | B46BEB |    |        |        |        | B46BEB |
; |        |        |        |  B46B  |    |        |        |        |  B46B  |    |        | BBBB   |       B|  B46B  |
; |        |        |        |  B64B  |    |        | B33333B|B  B23BB|  B64B  |    |    BBBB|B3B3B3BB|  B23BB3|  B64B  |
; |        |   BBBBB|BB  B23B|   546B |    |      33|33BBBBB3|3BB333BB|   546B |    |  BB3322|3BBBBB33|BB333BBB|   546B |
; |       B|BBB33232|33B 3BBB|   B15B |    |   B33BB|BB332323|33BBBBBB|   B15B |    | B323BBB|BB323233|3BBBBBBB|   B15B |
; |    BB33|23232121|333BBBBB|   B46B |    |  BBBB32|32321212|3BB3333B|   B46B |    | BBBB323|23212123|BB33333B|   B46B |
; |   B3332|12121111|2332333B|   B46B |    |  B33321|21211111|23333222|   B46B |    | B333212|12111112|33332223|   B46B |
; |--------|--------|--------|--------| => |--------|--------|--------|--------| => |--------|--------|--------|--------|
; |  B33321|21212121|23232111|             |  B23212|12121212|23322111|             |B3232121|21212122|B3221111|
; |  333232|12121212|33323211|             |  332321|21212122|33332111|             |B3323212|1212122B|33321111|
; |  333321|21212323|23232221|             |  333232|32323333|33323221|             | B333323|23233333|B3232212|
; |  333232|32323233|33323211|             |  B33323|23232333|BB332311|             |  B33232|3232333B|B3323121|
; |  B33323|232333BB|B3232323|             |  BB3333|33333BBB|BB333232|             |  BBB333|3333BBBB|BB332323|
; |   B3333|3333BBAA|AB323232|             |  BBBBBB|BBBBBBAA|ABB33323|             |   BBBBB|BBBBBBAA|ABBB3232|
; |   BBBB3|33BBAA89|8AB33323|             |  BBBBBB|BBBBAA89|8ABBB333|             |   BBBBB|BBBBAA89|8ABBBB33|
; |  BBBABB|BBAA88A8|A88AB333|             | 6BBBABB|BBAA88A8|A88ABBBB|             |  BBBABB|BBAA88A8|A88ABBBB|
; |--------|--------|--------|             |--------|--------|--------|             |--------|--------|--------|
$87:9964             db 00,00,00,00,00,00,00,00,00,00,01,01,0F,0F,1E,1F,00,00,00,00,00,00,00,00,00,00,00,01,00,0C,00,10,
                        00,00,00,00,00,00,00,00,1F,1F,FA,FF,55,FA,AF,50,00,00,00,00,00,00,00,00,00,1F,00,E0,00,00,00,00,
                        00,00,00,00,00,00,00,00,CB,CF,EF,EF,FF,FF,6F,FF,00,00,00,00,00,00,00,00,00,C9,00,27,00,1F,00,01,
                        76,76,4A,5E,24,2C,24,34,12,06,1E,12,12,16,12,16,00,76,34,4E,18,24,18,24,1C,02,04,12,0C,12,0C,12,
                        3D,3E,3A,3F,3D,3E,3A,3F,3D,3F,1F,1F,1F,1F,3B,3F,00,20,00,00,00,00,00,00,00,20,00,10,00,1E,00,3F,
                        55,AA,AA,55,55,AF,AB,FF,5F,FF,FC,FF,F1,FC,C0,F2,00,00,00,00,00,00,00,00,00,03,00,0F,00,3F,00,FF,
                        57,F8,EB,FC,51,FE,EB,FC,D5,FF,6A,FF,3D,7F,0F,9F,00,00,00,00,00,00,00,00,00,80,00,C0,00,E0,00,F8

$87:9A44             db 00,00,00,00,00,00,00,00,03,03,1F,1F,3E,3F,3D,3E,00,00,00,00,00,00,00,00,00,00,00,13,00,3C,00,20,
                        00,00,00,00,00,00,7F,7F,FF,FF,F5,FF,AA,F5,5F,A0,00,00,00,00,00,00,00,41,00,3E,00,C0,00,00,00,00,
                        00,00,00,00,00,00,97,9F,FF,FF,FF,FF,FF,FF,78,FF,00,00,00,00,00,00,00,93,00,63,00,3F,00,61,00,00,
                        76,76,4A,5E,24,2C,24,34,12,06,1E,12,12,16,12,16,00,76,34,4E,18,24,18,24,1C,02,04,12,0C,12,0C,12,
                        2A,3D,35,3E,3A,3F,3D,3F,3F,3F,3F,3F,3F,3F,3B,7F,00,20,00,00,00,00,00,20,00,30,00,3F,00,3F,40,3F,
                        AA,55,54,AB,AF,FF,57,FF,FF,FF,FC,FF,F1,FC,C0,F2,00,00,00,00,00,00,00,00,00,07,00,FF,00,FF,00,FF,
                        67,F8,F7,F8,E9,FE,F7,FC,FA,FF,7D,FF,3F,7F,0F,9F,00,00,00,00,00,00,00,C0,00,C0,00,E0,00,F8,00,FF

$87:9B24             db 00,00,00,00,00,00,0F,0F,3C,3F,6F,7F,7D,7F,7A,7D,00,00,00,00,00,00,00,0F,00,30,00,47,00,78,00,40,
                        00,00,00,00,78,78,FF,FF,FF,FF,EB,FF,55,EB,BE,41,00,00,00,00,00,78,00,AB,00,7C,00,C0,00,00,00,00,
                        00,00,00,00,01,01,2F,3F,FF,FF,FF,FF,FF,FF,F1,FF,00,00,00,00,00,01,00,26,00,C7,00,7F,00,C1,00,00,
                        76,76,4A,5E,24,2C,24,34,12,06,1E,12,12,16,12,16,00,76,34,4E,18,24,18,24,1C,02,04,12,0C,12,0C,12,
                        D5,FA,EA,FD,7D,7F,3A,3F,3F,3F,1F,1F,1F,1F,3B,3F,00,80,00,80,00,40,00,20,00,38,00,1F,00,1F,00,3F,
                        54,AB,A9,57,5F,FF,AF,FF,FF,FF,FC,FF,F1,FC,C0,F2,00,00,00,01,00,00,00,01,00,0F,00,FF,00,FF,00,FF,
                        CF,F0,EF,F0,D2,FD,ED,FA,F5,FF,7A,FF,3F,7F,0F,9F,00,80,00,00,00,80,00,80,00,C0,00,F0,00,FC,00,FF
}


;;; $9C04: All areas 1 - vertical spikes ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; |   4    |        |    |        |        |    |        |   4    |
; |   4    |        |    |   4    |   4    |    |        |  747   |
; |  747   |   4    |    |  747   |  747   |    |   4    |  747   |
; |  747   |  747   |    |  747   |  747   |    |  747   |  747   |
; |  6C6   |  747   |    |  747   |  747   |    |  747   |  6C6   |
; |  6C6   |  747   |    |  6C6   |  6C6   |    |  747   |  6C6   |
; | 76C67  |  6C6   |    |  6C6   |  6C6   |    |  6C6   | 76C67  |
; | 75C57  |  6C6   |    | 76C67  | 76C67  |    |  6C6   | 75C57  |
; |--------|--------| => |--------|--------| => |--------|--------|
; | 75C57  | 76C67  |    | 75C57  | 75C57  |    | 76C67  | 75C57  |
; | 74C47  | 75C57  |    | 75C57  | 75C57  |    | 75C57  | 74C47  |
; | F767F  | 75C57  |    | 74C47  | 74C47  |    | 75C57  | F767F  |
; |7654567 | 74C47  |    | F767F  | F767F  |    | 74C47  |7654567 |
; |666C666 | F767F  |    |7654567 |7654567 |    | F767F  |666C666 |
; |FF646FF |7654567 |    |666C666 |666C666 |    |7654567F|FF646FF |
; |FFFFFFFF|666C666F|    |FF646FFF|FF646FFF|    |666C666F|FFFFFFFF|
; |1F646F33|FF646FF1|    |2F777F22|FF777FF2|    |3F646F11|FF646FF3|
; |--------|--------|    |--------|--------|    |--------|--------|
$87:9C04             db 00,00,00,00,28,28,28,28,00,28,00,28,44,6C,6C,44,10,00,10,00,38,00,38,00,38,10,38,10,7C,10,7C,10,
                        00,00,00,00,00,00,28,28,28,28,28,28,00,28,00,28,00,00,00,00,10,00,38,00,38,00,38,00,38,10,38,10,
                        6C,44,44,44,6C,7C,AA,C6,00,EE,C6,EE,FF,FF,C7,6F,7C,10,7C,10,7C,44,FE,00,FE,10,FE,C6,FF,FF,7C,44,
                        44,6C,6C,44,6C,44,44,44,6C,7C,AA,C6,01,EF,C7,EE,7C,10,7C,10,7C,10,7C,10,7C,44,FE,00,FF,11,FE,C6

$87:9C84             db 00,00,00,00,28,28,28,28,28,28,00,28,00,28,44,6C,00,00,10,00,38,00,38,00,38,00,38,10,38,10,7C,10,
                        00,00,00,00,28,28,28,28,28,28,00,28,00,28,44,6C,00,00,10,00,38,00,38,00,38,00,38,10,38,10,7C,10,
                        6C,44,6C,44,44,44,6C,7C,AA,C6,00,EE,C7,EF,7C,FF,7C,10,7C,10,7C,10,7C,44,FE,00,FE,10,FF,C7,7C,44,
                        6C,44,6C,44,44,44,6C,7C,AA,C6,00,EE,C7,EF,FE,FF,7C,10,7C,10,7C,10,7C,44,FE,00,FE,10,FF,C7,FE,C6

$87:9D04             db 00,00,00,00,00,00,28,28,28,28,28,28,00,28,00,28,00,00,00,00,10,00,38,00,38,00,38,00,38,10,38,10,
                        00,00,28,28,28,28,28,28,00,28,00,28,44,6C,6C,44,10,00,38,00,38,00,38,00,38,10,38,10,7C,10,7C,10,
                        44,6C,6C,44,6C,44,44,44,6C,7C,AB,C7,01,EF,C7,EC,7C,10,7C,10,7C,10,7C,10,7C,44,FF,01,FF,11,7C,44,
                        6C,44,44,44,6C,7C,AA,C6,00,EE,C6,EE,FF,FF,C7,EF,7C,10,7C,10,7C,44,FE,00,FE,10,FE,C6,FF,FF,FE,C6
}


;;; $9D84: All areas 2 - horizontal spikes ;;;
{
; |--------|--------|    |--------|--------|    |--------|--------|
; |        |      F1|    |        |      F2|    |        |      F3|
; |        |     76F|    |        |    76FF|    |        |   76FFF|
; |        |7777F66F|    |       7|777F66FF|    |      77|77F66FFF|
; |   77766|65547566|    |  777666|55475667|    | 7776665|547566F6|
; |  4444CC|CCCC64C4|    | 4444CCC|CCC64C47|    |4444CCCC|CC64C4F4|
; |   77766|65547566|    |  777666|55475667|    | 7776665|547566F6|
; |        |7777F66F|    |       7|777F66FF|    |      77|77F66FFF|
; |        |     76F|    |        |    76FF|    |        |   76FFF|
; |--------|--------| => |--------|--------| => |--------|--------|
; |        |      F3|    |        |      F2|    |        |     FF1|
; |        |   76FF3|    |        |    76F2|    |        |     761|
; |      77|77F66FFF|    |       7|777F66FF|    |        |7777F66F|
; |  776665|547566F6|    |  777666|55475667|    |   77766|65547566|
; |4444CCCC|CC64C4F4|    | 4444CCC|CCC64C47|    |  4444CC|CCCC64C4|
; |  776665|547566F6|    |  777666|55475667|    |   77766|65547566|
; |      77|77F66FFF|    |       7|777F66FF|    |        |7777F66F|
; |        |   76FF1|    |        |    76F2|    |        |     763|
; |--------|--------|    |--------|--------|    |--------|--------|
$87:9D84             db 00,00,00,00,00,00,1C,1F,00,00,1C,1F,00,00,00,00,00,00,00,00,00,00,1F,00,3F,03,1F,00,00,00,00,00,
                        03,02,05,07,F9,FF,6C,8B,00,08,6C,8B,F9,FF,05,07,02,02,07,01,FF,09,FF,00,FF,F2,FF,00,FF,09,07,01,
                        00,00,00,00,03,03,31,3E,00,00,31,3E,03,03,00,00,00,00,00,00,03,00,3F,00,FF,0F,3F,00,03,00,00,00,
                        03,03,17,1F,E7,FF,B2,2F,02,22,B2,2F,E7,FF,17,1E,02,02,1E,06,FF,27,FF,02,FF,CA,FF,02,FF,27,1E,06

$87:9E04             db 00,00,00,00,01,01,38,3F,00,00,38,3F,01,01,00,00,00,00,00,00,01,00,3F,00,7F,07,3F,00,01,00,00,00,
                        02,03,0B,0F,F3,FF,D9,17,01,11,D9,17,F3,FF,0B,0F,02,02,0F,03,FF,13,FF,00,FF,E4,FF,00,FF,13,0F,03,
                        00,00,00,00,01,01,38,3F,00,00,38,3F,01,01,00,00,00,00,00,00,01,00,3F,00,7F,07,3F,00,01,00,00,00,
                        02,03,0A,0F,F3,FF,D9,17,01,11,D9,17,F3,FF,0A,0F,02,02,0E,02,FF,13,FF,00,FF,E4,FF,00,FF,13,0E,02

$87:9E84             db 00,00,00,00,03,03,71,7E,00,00,71,7E,03,03,00,00,00,00,00,00,03,00,7F,00,FF,0F,7F,00,03,00,00,00,
                        03,03,17,1F,E7,FF,B2,2F,02,22,B2,2F,E7,FF,17,1F,02,02,1F,07,FF,27,FF,02,FF,CA,FF,02,FF,27,1F,07,
                        00,00,00,00,00,00,1C,1F,00,00,1C,1F,00,00,00,00,00,00,00,00,00,00,1F,00,3F,03,1F,00,00,00,00,00,
                        07,06,05,06,F9,FF,6C,8B,00,08,6C,8B,F9,FF,05,07,06,06,06,00,FF,09,FF,00,FF,F2,FF,00,FF,09,06,00
}


;;; $9F04: Unused. "X" ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |   E    |
; |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |  E E   |
; | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  | E   E  |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
$87:9F04             db 00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00,
                        00,00,00,44,00,28,00,10,00,28,00,44,00,00,00,00,00,00,44,44,28,28,10,10,28,28,44,44,00,00,00,00
}


;;; $A564: Lava ;;;
{
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
; |33333333|33233333|33333333|22222222|    |33333333|33333333|33333333|22222212|    |33233333|33333333|33333333|12222222|    |33333333|33333333|33233333|22222222|    |33333333|33333333|33333333|22222222|
; |33333333|33333313|33333333|22222222|    |33333333|33333333|33333333|12222222|    |33333313|33333333|33333333|22222222|    |33333333|33333333|33333313|22222222|    |33333333|33333333|33333333|22212222|
; |33333333|33333333|33333333|22222212|    |33333333|33333333|33333333|22222222|    |33333333|33333333|33333333|22222222|    |33333333|33333333|33333333|22212222|    |33333333|33333333|33333333|22222222|
; |33333333|31333333|33333333|12222222|    |33222233|33332333|33333333|22222222|    |31333332|33333333|33333333|22221222|    |33332333|33333333|31333333|22222222|    |33333333|33222233|33332333|22222212|
; |33333333|23332333|23333333|22222222| => |32111123|23333332|33333333|22221222| => |22332332|23333333|33222233|22222222| => |23333332|33333333|33332333|22222222| => |33333333|32111123|23333332|22222222|
; |33222233|11313131|23333333|22222222|    |21112222|33323333|33322333|22222222|    |12212121|23333333|32112223|22222222|    |33323333|33222233|21313131|22222212|    |33333333|21112222|33323333|12222222|
; |32111223|31211221|33323333|22212222|    |21122222|33232332|33211233|22222222|    |31222221|33323333|32122223|22222212|    |23232332|32111223|31211121|22222222|    |33323333|21122222|33232332|22222222|
; |21122222|22222223|23232232|22222222|    |22222222|22122122|21122222|22222222|    |22222222|23232232|22222222|22222222|    |22122122|21122222|22222223|12222222|    |23232232|22222222|22122122|22212222|
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
$87:A564             db FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,C3,FF,B9,C7,60,9F,
                        DF,FF,FF,FD,FF,FF,FF,BF,77,FF,FF,2A,D9,A6,01,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,7F,FF,7F,FF,EF,FF,52,FF,
                        00,FF,00,FF,02,FD,80,7F,00,FF,00,FF,10,EF,00,FF

$87:A5A4             db FF,FF,FF,FF,FF,FF,C3,FF,BD,C3,70,8F,60,9F,00,FF,
                        FF,FF,FF,FF,FF,FF,F7,FF,7E,FF,EF,FF,D6,FF,24,DB,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,E7,FF,DB,E7,60,9F,
                        02,FD,80,7F,00,FF,00,FF,08,F7,00,FF,00,FF,00,FF

$87:A5E4             db DF,FF,FF,FD,FF,FF,FE,BF,36,FF,95,6A,C1,BE,00,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,7F,FF,7F,FF,EF,FF,52,FF,
                        FF,FF,FF,FF,FF,FF,FF,FF,C3,FF,B1,CF,A1,DF,00,FF,
                        80,7F,00,FF,00,FF,08,F7,00,FF,00,FF,02,FD,00,FF

$87:A624             db FF,FF,FF,FF,FF,FF,F7,FF,7E,FF,EF,FF,56,FF,24,DB,
                        FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,C3,FF,B9,C7,60,9F,
                        DF,FF,FF,FD,FF,FF,FF,BF,F7,FF,7F,AA,DD,A2,01,FF,
                        00,FF,00,FF,10,EF,00,FF,00,FF,02,FD,00,FF,80,7F

$87:A664             db FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,EF,FF,52,FF,
                        FF,FF,FF,FF,FF,FF,C3,FF,BD,C3,70,8F,60,9F,00,FF,
                        FF,FF,FF,FF,FF,FF,F7,FF,7E,FF,EF,FF,D6,FF,24,DB,
                        00,FF,10,EF,00,FF,02,FD,00,FF,80,7F,00,FF,10,EF
}


;;; $A6A4: Acid ;;;
{
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
; |22322233|33332123|33222333|33333333|    |32223333|33212333|22333322|33333323|    |22333333|12233323|23332232|23333333|    |33333321|23332223|33223332|33333333|    |23332223|33223222|33333321|33323333|
; |22211223|33321112|33321223|33333333|    |22112333|32111233|32232322|23333333|    |32233332|22233332|32232122|33333333|    |23333211|12333223|33212322|33333333|    |22333233|33213212|23333211|33333333|
; |22121233|22322122|33221122|33333323|    |22123322|32212233|22321221|33333333|    |23332232|23323321|23321112|33333333|    |33223221|22332123|22223212|33323333|    |12332132|22223222|33223222|33333333|
; |32212231|21333223|22322222|23333333|    |23223212|33322322|23212232|33333333|    |22332133|33232112|22322123|33332333|    |31123332|23222223|22323322|33333333|    |23232232|12323322|32123332|33333323|
; |33232322|12232332|22233323|33333333| => |33332222|23233223|33222323|33332333| => |33232223|23322123|22323233|33333333| => |22222333|32222332|23232333|33333333| => |32233322|23333333|22222333|33333333|
; |33333232|23233233|23232333|33333333|    |32333223|32333323|33232333|33333333|    |33323333|23332332|33223322|33333333|    |32233232|33233323|32223233|33333323|    |33233333|33323233|32233323|23333333|
; |33323333|32323332|33323333|33323333|    |33323333|23323333|23333323|33333333|    |23333332|32323333|32332333|33333323|    |33323333|32323232|33233332|33333333|    |23333323|33232332|33332333|33333333|
; |33333332|33333333|32332333|33333333|    |33333333|33333333|33333333|33333333|    |33332333|33333333|33333333|33333333|    |33333333|33333323|33332333|23333333|    |33333333|33333323|23333323|33323333|
; |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|    |--------|--------|--------|--------|
$87:A6A4             db 23,FF,19,E7,2B,D7,93,EE,D4,FF,FA,FF,EF,FF,FE,FF,
                        F5,FB,EE,F1,24,FB,79,BF,96,7F,5B,FF,AE,FF,FF,FF,
                        C7,FF,E9,F7,CC,F3,20,FF,1D,FF,57,FF,EF,FF,B7,FF,
                        FF,FF,FF,FF,FD,FF,7F,FF,FF,FF,FF,FF,EF,FF,FF,FF

$87:A6E4             db 8F,FF,37,CF,2C,DF,4A,FD,F0,FF,B9,FF,EF,FF,FF,FF,
                        D7,EF,BB,C7,93,EF,E4,FF,59,FF,BD,FF,6F,FF,FF,FF,
                        3C,FF,94,FF,29,F6,52,EF,C5,FF,D7,FF,7D,FF,FF,FF,
                        FD,FF,7F,FF,FF,FF,FF,FF,F7,FF,FF,FF,FF,FF,FF,FF

$87:A724             db 3F,FF,9E,FF,72,FF,37,FB,D1,FF,EF,FF,7E,FF,F7,FF,
                        9D,7F,1E,FF,6D,FE,D6,F9,65,FB,76,FF,AF,FF,FF,FF,
                        72,FF,94,FB,6E,F1,25,FB,2B,FF,CC,FF,B7,FF,FF,FF,
                        7F,FF,FF,FF,FF,FF,F7,FF,FF,FF,FF,FF,FD,FF,FF,FF

$87:A764             db FD,FE,7B,FC,C9,FE,EE,9F,07,FF,9A,FF,EF,FF,FF,FF,
                        71,FF,B9,7F,35,FB,41,FF,86,FF,DD,FF,AA,FF,FD,FF,
                        CE,FF,D4,EF,0A,FD,2C,FF,57,FF,8B,FF,DE,FF,F7,FF,
                        FF,FF,FF,FF,EF,FF,FF,FF,FF,FF,FD,FF,FF,FF,7F,FF

$87:A7A4             db 71,FF,3B,FF,B6,7B,52,FF,9C,FF,DF,FF,7D,FF,FF,FF,
                        C8,FF,DA,ED,08,FF,AC,7F,7F,FF,EB,FF,D6,FF,FD,FF,
                        FD,FE,7B,FC,C8,FF,AE,DF,07,FF,9D,FF,F7,FF,7D,FF,
                        EF,FF,FF,FF,FF,FF,FD,FF,FF,FF,7F,FF,FF,FF,EF,FF
}


;;; $A7E4: Spores ;;;
{
; |--------|--------|--------|    |--------|--------|--------|    |--------|--------|--------|
; |33333333|33333333|33333333|    |33333333|33333333|33333333|    |33333333|33333333|33333333|
; |33333333|33333333|33333333|    |33333333|33333333|33333333|    |33333333|33333333|33333333|
; |33333333|33322333|33332333|    |33333333|33332333|33333333|    |33333333|33332333|33333333|
; |33313333|33222333|33332233|    |33311333|33323333|33332333|    |33331333|33322333|33322333|
; |33313333|33223333|33333233| => |33311333|33233333|33333233| => |33331333|33323333|33332333|
; |33333333|33333333|33333333|    |33333333|33333333|33333333|    |33333333|33333333|33333333|
; |33333333|33333333|33333333|    |33333333|33333333|33333333|    |33333333|33333333|33333333|
; |33333333|33333333|33333333|    |33333333|33333333|33333333|    |33333333|33333333|33333333|
; |--------|--------|--------|    |--------|--------|--------|    |--------|--------|--------|
$87:A7E4             db FF,FF,FF,FF,FF,FF,FF,EF,FF,EF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,E7,FF,C7,FF,CF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,F7,FF,F3,FF,FB,FF,FF,FF,FF,FF,FF,FF

$87:A814             db FF,FF,FF,FF,FF,FF,FF,E7,FF,E7,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,F7,FF,EF,FF,DF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,F7,FF,FB,FF,FF,FF,FF,FF,FF,FF

$87:A844             db FF,FF,FF,FF,FF,FF,FF,F7,FF,F7,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,F7,FF,E7,FF,EF,FF,FF,FF,FF,FF,FF,FF,
                        FF,FF,FF,FF,FF,FF,E7,FF,F7,FF,FF,FF,FF,FF,FF,FF
}


;;; $A874: Rain ;;;
{
; |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|
; |33333333|33332333|33333333|33333333|33333333|    |33332333|33333333|33333333|33333333|33333333|    |33333333|33333333|33333333|33333333|33332333|    |33333333|33333333|33333333|33332333|33333333|    |33333333|33333333|33332333|33333333|33333333|
; |33233313|32333313|33323333|33333233|33313333|    |32333313|33323333|33333233|33313333|33233313|    |33323333|33333233|33313333|33233313|32333313|    |33333233|33313333|33233313|32333313|33323333|    |33313333|33233313|32333313|33323333|33333233|
; |33333333|33333333|33333323|32313333|33333333|    |33333333|33333323|32313333|33333333|33333333|    |33333323|32313333|33333333|33333333|33333333|    |32313333|33333333|33333333|33333333|33333323|    |33333333|33333333|33333333|33333323|32313333|
; |33333233|33333233|31333333|33333333|33333323|    |33333233|31333333|33333333|33333323|33333233|    |31333333|33333333|33333323|33333233|33333233|    |33333333|33333323|33333233|33333233|31333333|    |33333323|33333233|33333233|31333333|33333333|
; |31333333|33333333|33333333|33333333|33333333| => |33333333|33333333|33333333|33333333|31333333| => |33333333|33333333|33333333|31333333|33333333| => |33333333|33333333|31333333|33333333|33333333| => |33333333|31333333|33333333|33333333|33333333|
; |33313333|23313333|33333333|33333233|33133333|    |23313333|33333333|33333233|33133333|33313333|    |33333333|33333233|33133333|33313333|23313333|    |33333233|33133333|33313333|23313333|33333333|    |33133333|33313333|23313333|33333333|33333233|
; |33333313|33333323|33133233|33133333|33333233|    |33333323|33133233|33133333|33333233|33333313|    |33133233|33133333|33333233|33333313|33333323|    |33133333|33333233|33333313|33333323|33133233|    |33333233|33333313|33333323|33133233|33133333|
; |33333333|33333333|33333333|33333333|33333333|    |33333333|33333333|33333333|33333333|33333333|    |33333333|33333333|33333333|33333333|33333333|    |33333333|33333333|33333333|33333333|33333333|    |33333333|33333333|33333333|33333333|33333333|
; |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|    |--------|--------|--------|--------|--------|
$87:A874             db FF,FF,DF,FD,FF,FF,FB,FF,FF,BF,FF,EF,FF,FD,FF,FF,
                        F7,FF,BF,FD,FF,FF,FB,FF,FF,FF,7F,EF,FD,FF,FF,FF,
                        FF,FF,EF,FF,FD,FF,FF,BF,FF,FF,FF,FF,FB,DF,FF,FF,
                        FF,FF,FB,FF,BF,EF,FF,FF,FF,FF,FB,FF,FF,DF,FF,FF,
                        FF,FF,FF,EF,FF,FF,FD,FF,FF,FF,FF,DF,FB,FF,FF,FF

$87:A8C4             db F7,FF,BF,FD,FF,FF,FB,FF,FF,FF,7F,EF,FD,FF,FF,FF,
                        FF,FF,EF,FF,FD,FF,FF,BF,FF,FF,FF,FF,FB,DF,FF,FF,
                        FF,FF,FB,FF,BF,EF,FF,FF,FF,FF,FB,FF,FF,DF,FF,FF,
                        FF,FF,FF,EF,FF,FF,FD,FF,FF,FF,FF,DF,FB,FF,FF,FF,
                        FF,FF,DF,FD,FF,FF,FB,FF,FF,BF,FF,EF,FF,FD,FF,FF

$87:A914             db FF,FF,EF,FF,FD,FF,FF,BF,FF,FF,FF,FF,FB,DF,FF,FF,
                        FF,FF,FB,FF,BF,EF,FF,FF,FF,FF,FB,FF,FF,DF,FF,FF,
                        FF,FF,FF,EF,FF,FF,FD,FF,FF,FF,FF,DF,FB,FF,FF,FF,
                        FF,FF,DF,FD,FF,FF,FB,FF,FF,BF,FF,EF,FF,FD,FF,FF,
                        F7,FF,BF,FD,FF,FF,FB,FF,FF,FF,7F,EF,FD,FF,FF,FF

$87:A964             db FF,FF,FB,FF,BF,EF,FF,FF,FF,FF,FB,FF,FF,DF,FF,FF,
                        FF,FF,FF,EF,FF,FF,FD,FF,FF,FF,FF,DF,FB,FF,FF,FF,
                        FF,FF,DF,FD,FF,FF,FB,FF,FF,BF,FF,EF,FF,FD,FF,FF,
                        F7,FF,BF,FD,FF,FF,FB,FF,FF,FF,7F,EF,FD,FF,FF,FF,
                        FF,FF,EF,FF,FD,FF,FF,BF,FF,FF,FF,FF,FB,DF,FF,FF

$87:A9B4             db FF,FF,FF,EF,FF,FF,FD,FF,FF,FF,FF,DF,FB,FF,FF,FF,
                        FF,FF,DF,FD,FF,FF,FB,FF,FF,BF,FF,EF,FF,FD,FF,FF,
                        F7,FF,BF,FD,FF,FF,FB,FF,FF,FF,7F,EF,FD,FF,FF,FF,
                        FF,FF,EF,FF,FD,FF,FF,BF,FF,FF,FF,FF,FB,DF,FF,FF,
                        FF,FF,FB,FF,BF,EF,FF,FF,FF,FF,FB,FF,FF,DF,FF,FF
}
}


;;; $AA04: Zeros ;;;
{
$87:AA04             fillto $87AD64, $00
}


;;; $AD64: Tiles - enemy $F03F (Tourian entrance statue ghost) ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |   C    |        | FEDDEF |7FEEDEEF|FEEDEEF7|7FEEDEEF|FEEDEEF7|7EFFFFE7|    B   |  C   B |    B   | C     B|        |        |
; |        |     B  |  CBC   |   C    |  FEDF  | 7FEDEF7|7FEEEF7 | 7FEDEF7|7FEEEF7 | FEDDEF |   CAC  |  A  BAB| A      |    C   |        |        |
; |        |   CA   | CBBBC  |  CAB   |  FEEF  | 7FEEEF7|7FEEEF7 | 7FFEEF7|7FEEFF7 | 7FDEF7 |  BA9AB |CA9AC B |  B A B |      C |        |        |
; |   B    |  CAC   |BBAAABBC| CB9C   |   FEF  | 7FFEEF7|7FEEFF7 | 77FEEF7|7FEEF77 |  FEEF  |  BCAC  |  A  C  | B      | B      |        |        |
; |  CAC   |  AC    | CBBBC  | CAC    |    FE  | 77FEDF7|7FDEF77 | 77FEDF7|7FDEF77 |  FEF   | CACBC  |  C  A  |    B B |        |        |        |
; |   B    | B      |  CBC   | CBC    |     E  |  7FEDFF|FFDEF7  | 77FEDF7|7FDEF77 |  EF    |BA9ACAC |   CA9AC|BA B BAB|C  C  C |        |        |
; |        |        |   C    |  C     |     F  |  7FEDF1|1FDEF7  |  77FDFF|FFDF77  |  E     | CACA9AC|     A  |      B |        |        |        |
; |        |        |        |        |        |   7FEDD|DDEF7   |  77FDF1|1FDF77  |  F     |  B CAC |     C  | B      |    B   |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    7FFE|EFF7    |        |        |       B|        |        |        |      BB|B       |        |        |        |      C |        |        |
; |  7FEEDD|DDEEF7  |        |        |       A|        |       C|C      B|    BBCC|CBB     |        | BB BB  |        |        | C      |        |
; | 7FFFFFE|EFFFFF7 |  C     |        |     BBA|BB      |     CC | BC  BA |   BCC  | CCB    |       B|      BB|        |  C     |        |        |
; | FFF1FFF|FFD1FFF |   A  CB|C  B    |    BCCA|CCB     |    B   |   BAA  |  BC   C|   CB   |     BB |        |        |        |  C     |        |
; |7FFDDEDD|DDEDDFF7|    ABCC|CCB     |   BC  A|  CB    |   BA   |   A9   | BC    A|    CB  |    B   |        |       C|        |        |        |
; |7FFFEDDF|FDDEFFF7|    BA  | CC     |  BC   9|   CB   |  C  A  |  A9 B  | B    C9|C   CB  |   B    |        |        |        |  C     |        |
; |7FEDDDE1|1EDDDEF7|   CC BA|  CC    |  BC  A9|A  CB   |  B   AA|AA9  C  |BCC  CA9|AC   CB |        |        |     C  |        |        |        |
; |7FEDDE1E|E1EDDEF7|   BC AA|A CB    | BC  A99|9A  CB  | BC   A9|99    B |AAA99999|99999AAA|  B     |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |7FEEDEEF|FEEDEEF7|   CC  A|B CC    |  BC  A9|A  CB   | B    A9|9A    B |BC   CA9|AC   CB | B      |        |        |        |        |        |
; | 7FEDEF7|7FEEEF7 |    CC  | AB     |  BC   9|   CB   |  B  A9A|AA   B  | BC   C9|C    B  |        |        |        |        |     C  |        |
; | 7FEEEF7|7FEEEF7 |    BCCC|CBA     |   BC  A|  CB    |  B A9B |  A  B  | BC    A|    CB  |B       |        |  C     |        |        |        |
; | 7FFEEF7|7FEEFF7 |   B  CB|C  A    |    BCCA|CCB     |   A9B  |   BB   |  BC   C|   CB   |B       |        |        |        |       C|        |
; | 77FEDF7|7FDEF77 |        |    C   |     BBA|BB      |  AAB   |   B    |   BCC  |CCCB    |     C  |CCBBC CC|  C     |        |        |        |
; |  7FEDFF|FFDEF7  |        |        |       A|        | AB  CB | CC     |    BBCC|CBB     |B       |        |        |        |        |  C     |
; |  7FEDF1|1FDEF7  |        |        |       A|        |B      B|B       |      BB|B       |B       |        |        |        |        |        |
; |   7FEDD|DDEF7   |        |        |       B|        |        |        |        |        | B      |        |C  C C  | B   C  |        |      C |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
$87:AD64             db 00,00,00,00,00,00,10,10,00,10,10,10,00,00,00,00,00,00,00,00,00,00,00,10,28,38,00,10,00,00,00,00,
                        00,00,04,04,00,08,00,10,00,20,40,40,00,00,00,00,00,00,00,04,10,18,28,38,10,30,00,40,00,00,00,00,
                        00,00,10,10,38,38,C6,FE,38,38,10,10,00,00,00,00,10,10,28,38,44,7C,01,FF,44,7C,28,38,10,10,00,00,
                        00,00,00,00,08,18,30,20,00,20,20,20,00,00,00,00,00,00,10,10,20,38,48,78,50,70,50,70,20,20,00,00,
                        5A,66,2C,34,24,3C,14,1C,08,0C,00,04,04,04,00,00,7E,7E,3C,3C,3C,3C,1C,1C,0C,0C,04,04,04,04,00,00,
                        C9,F7,6B,77,63,7F,73,7F,77,7B,37,3B,37,3A,1B,1C,FF,7F,7F,3E,7F,3E,7F,3E,7F,1E,3F,1F,3E,1E,1F,0F,
                        93,EF,C6,FE,C6,FE,CE,FE,EE,DE,EC,DC,EC,5C,D8,38,FF,FE,FE,7C,FE,7C,FE,7C,FE,78,FC,F8,7C,78,F8,F0,
                        C9,F7,6B,77,73,7F,73,7F,77,7B,77,7B,3F,3B,3F,3A,FF,7F,7F,3E,7F,3E,7F,1E,7F,1E,7F,1E,3F,0F,3E,0E,
                        93,EF,C6,FE,CE,FE,CE,FE,EE,DE,EE,DE,FC,DC,FC,5C,FF,FE,FE,7C,FE,7C,FE,78,FE,78,FE,78,FC,F0,7C,70,
                        BD,FF,5A,66,76,6E,24,3C,28,38,10,30,00,20,20,20,FF,7E,7E,7E,7E,3C,3C,3C,38,38,30,30,20,20,20,20,
                        08,08,00,08,2A,36,20,28,08,28,A0,D4,04,2A,20,24,00,08,14,1C,00,3E,14,3C,54,7C,0A,FE,51,7F,0A,2E,
                        02,02,05,27,22,52,00,20,00,04,04,0A,00,04,00,00,20,22,00,27,88,FA,04,24,20,24,11,1F,00,04,04,04,
                        08,08,00,40,22,2A,40,40,0A,0A,95,D7,02,02,40,40,00,08,00,40,00,2A,00,40,00,0A,00,D7,00,02,00,40,
                        01,01,00,00,00,00,40,40,00,00,00,00,00,00,08,08,40,41,08,08,02,02,00,40,00,00,92,92,00,00,00,08,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        0E,0F,33,3C,7E,7F,7F,77,FB,E4,F7,F9,DD,E2,DA,E5,0F,07,3F,1F,7F,3F,77,77,FF,7F,FF,7F,FE,7E,FD,7D,
                        70,F0,CC,3C,7E,FE,FE,CE,DF,27,EF,9F,BB,47,5B,A7,F0,E0,FC,F8,FE,FC,EE,EE,FF,FE,FF,FE,7F,7E,BF,BE,
                        00,00,00,00,00,00,01,11,04,0C,08,0C,02,03,10,13,00,00,00,00,20,20,02,13,03,0F,00,0C,18,1B,08,1B,
                        00,00,00,00,00,00,10,10,20,20,00,00,00,00,10,90,00,00,00,00,00,00,80,90,C0,E0,60,60,30,30,20,B0,
                        01,01,00,01,06,07,08,09,10,11,21,20,21,22,43,44,00,01,00,01,00,07,06,0F,08,19,10,31,10,33,20,67,
                        00,00,00,00,C0,C0,20,20,10,10,08,08,08,88,84,44,00,00,00,00,00,C0,C0,E0,20,30,10,18,10,98,08,CC,
                        00,00,00,00,00,00,08,08,10,18,00,04,20,23,41,42,00,00,01,01,06,06,00,08,00,18,20,24,00,23,20,63,
                        00,00,01,01,44,46,10,1C,08,10,14,24,20,C0,C2,02,00,00,80,81,20,66,00,1C,00,18,00,34,04,E4,00,C2,
                        03,03,0C,0C,10,10,20,20,40,41,41,40,81,82,1F,E0,00,03,03,0F,0C,1C,11,31,20,61,02,43,64,E7,00,FF,
                        80,80,60,60,10,10,08,08,04,04,04,04,02,82,F8,07,00,80,80,E0,60,70,10,18,08,0C,88,8C,44,C6,00,FF,
                        00,00,00,00,01,01,06,06,08,08,10,10,00,00,20,20,00,00,00,00,00,01,00,06,00,08,00,10,00,00,00,20,
                        00,00,6C,6C,03,03,00,00,00,00,00,00,00,00,00,00,00,00,00,6C,00,03,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,01,00,00,04,04,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,02,00,00,20,20,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,40,40,00,00,20,20,00,00,20,20,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        C9,F7,6B,77,63,7F,73,7F,77,7B,37,3B,37,3A,1B,1C,FF,7F,7F,3E,7F,3E,7F,3E,7F,1E,3F,1F,3E,1E,1F,0F,
                        93,EF,C6,FE,C6,FE,CE,FE,EE,DE,EC,DC,EC,5C,D8,38,FF,FE,FE,7C,FE,7C,FE,7C,FE,78,FC,F8,7C,78,F8,F0,
                        00,01,00,00,08,08,11,11,00,00,00,00,00,00,00,00,18,19,0C,0C,07,0F,02,13,00,00,00,00,00,00,00,00,
                        80,80,20,60,40,60,00,10,00,00,00,00,00,00,00,00,30,B0,00,60,80,E0,80,90,08,08,00,00,00,00,00,00,
                        21,22,21,20,10,11,08,09,06,07,00,01,00,01,01,01,10,33,10,31,08,19,06,0F,00,07,00,01,00,01,00,01,
                        08,88,08,08,10,10,20,20,C0,C0,00,00,00,00,00,00,10,98,10,18,20,30,C0,E0,00,C0,00,00,00,00,00,00,
                        41,42,22,25,26,2A,0C,14,08,38,22,62,81,81,00,00,00,43,00,27,00,2E,00,1C,00,38,04,66,00,81,00,00,
                        82,42,04,C4,04,24,18,18,10,10,00,00,80,80,00,00,00,C2,00,C4,00,24,00,18,00,10,60,60,00,80,00,00,
                        81,82,41,40,40,41,20,20,10,10,0C,0C,03,03,00,00,44,C7,22,63,20,61,11,31,0C,1C,03,0F,00,03,00,00,
                        02,82,04,04,04,04,08,08,10,10,60,60,80,80,00,00,44,C6,80,84,08,0C,10,18,E0,F0,80,E0,00,80,00,00,
                        40,40,00,00,80,80,80,80,00,00,80,80,80,80,40,40,00,40,00,00,00,80,00,80,04,04,00,80,00,80,00,40,
                        00,00,00,00,00,00,00,00,30,30,00,00,00,00,00,00,00,00,00,00,00,00,00,00,CB,FB,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,20,00,00,20,20,00,00,00,00,94,94,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,40,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,44,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,04,04,00,00,01,01,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,20,00,00,02,02
}


;;; $B364: Tiles - enemy $EFFF (Tourian entrance statue) ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |        |        |        |        |        |        | 7478788|    8765|578F8867|88888887|65578855|67      |        |
; |        |        |        |        |        |        |        |        |        | 7368778|     876|65788778|67766678|88876578|777     |        |
; |        |        |        |        |        | 8886667|77777778|        |        | 8458778|     875|66667777|86656555|55677885|5887    |        |
; |        |        |        |        |    8886|54444555|65656667|8888    |        | 8548777|      86|56656877|78588568|88888888|87678   |        |
; |        |        |        |        | 8865444|57788888|88888877|66677888|        | 8648878|8   8877|46F75578|688556  |        |8887678 |        |
; |      88|88      |        |       8|65446777|78877777|77788888|8       |        |  756878|88887778|45FF7746|86556   |        |    888 |        |
; |   88655|458     |        |    8665|46678877|76665445|56668   |        |        |  767878|88777888|54FFF875|48658   |        |        |        |
; |  866688|6648    |        |  865446|78877766|66553555|5567    |        |        |  778787|66667788|547F6788|74868   |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | 8778877|88658   |        |88546787|77766544|55435444|467     |        |        |88865555|55666778|557F8868|87576   |        |        |        |
; | 888  88|67845   |      88|64687887|76665776|43454333|477     |        |    8  8|76544455|55666778|567F7888|78867   |        |        |        |
; |        |667638  |    8875|568F8878|88557544|66643355|4       |        |   88886|66555544|55667787|668F7668|666868  |        |        |        |
; |        |8678488 | 8887657|7FFF8886|66888777|65334533|6       |        |   85866|35634455|56677876|67887678|8888868 |        |        |        |
; |        | 8784888|87665566|6667F888|76666555|46665544|6       |        |  856664|25444556|67FF8786|7888878 |      68|        |        |        |
; |        |88848678|88765443|34455556|87888765|54455344|6       |        |  756563|44555668|FF888878|88888877|678     |        |        |        |
; |        |43465457|  875567|77778766|65566788|65545544|6       |        |  865464|5556678F|88778887|77777887|7778    |        |        |        |
; |        |84568765|   87656|7FFFF888|88876556|68875443|6       |        |  865555|5667F888|87778876|66677788|88      |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        | 8656778|8FF88788|77688865|55667788|8       |        |        |        |    7446|34583657|7    878|88888856|87777885|56568765|
; |        |        |76566788|88887787|76688655|44566778|7888    |        |   8    |        |   77376|4538767 |     888|78865446|68777786|56568766|
; |        |       7|65457888|88876687|66787643|34567787|88888878|87      | 8868   |        |   76375|584867  |     788|87665556|85688778|66668767|
; |        |      76|54578888|88765568|76786543|34567886|88888665|68      |88557   |        |   75374|68877F  |   87776|77886668|54578787|76667777|
; |        |     765|36887777|76654456|77787543|24577876|88876643|46888   |773468  |        |   75445|8677776F| 8875555|56778776|64468787|65557767|
; |        |    7753|68877665|55787756|77786654|25678867|87665542|25885888|65256557|        |   76436|87  FFF |87654444|45677886|53368877|54457756|
; |        |   77536|87765446|78388667|67786654|35678778|76655543|25684575|53465345|777     |    8546|8       |86543333|34566786|53356775|43457755|
; |        |  774368|76544667|58467877|67787665|46678787|66545664|35583544|52654334|6857    |    8657|        |85433334|55546786|53345755|54568654|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        | 7743676|54465638|37768676|67766666|56678787|65456433|45484533|54665435|4367    |     868|        |75444456|43346776|42344854|56578645|
; |        |77436754|35888847|86786675|67785665|66568776|54566542|45485544|55776654|2678    |      88|        |76545664|55556786|42344844|57888676|
; |       7|74465444|68384786|88766765|68875765|65468876|54675452|45586565|65877543|5768    |        |        |87656677|78767775|42345643|58865477|
; |       7|33554335|5858666F|87656756|87876754|55456876|55674463|45686776|76887457|6568    |        |        | 8767755|66777775|53447533|68843347|
; |      76|45543458|37856FF7|86457668|65688854|65356876|56762454|55776778|88885676|5468    |        |        | 7887777|77778875|53548434|68677747|
; |     763|55434538|7568FF87|86455588|76777753|65356776|66753455|56877788| 8888865|446     |        |        |   78888|87878876|53748325|67853588|
; |     743|53346847|578 F877|86656788|87788853|65456766|56654456|67877788|  888865|356     |        |        |   67788|54677888|55758324|67843488|
; |    7635|33455885|7F   877|87666788|87778864|56558765|67655566|888878  |  888865|368     |        |        |     865|86567766|78887324|86842488|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |67656678|888 8   |  865454|567     |    8886|67777588|78777334|85852588|8887747 |        |        |        |        |       7|54444444|53566783|
; |77556788|8       |  876345|67      |   85468|88788478|88875334|85862688|   8757 |        |        |        |        |      76|44443334|43466783|
; |76566888|        | 8888853|45      |   77746|68655668|88875355|56863788|    767 |        |        |        |        |      76|44332233|44456782|
; |6666788 |        |86865456|7       |   84775|88445688|88875456|6687378 |     7  |        |       7|7       |        |      75|43322224|34556681|
; |766788  |        |86354367|7       |  753577|76325888| 8886566|8887478 |        |        |      76|67      |        |      75|44322223|44555671|
; |77768   |       8|87535588|        |  734577|74677488|  878688|888758  |        |        |    7776|6888    |        |     764|43322224|35455671|
; |66678   |      87|635538  |        |  735688|87525888|    787 |  7878  |        |        | 7777786|677888  |        |     764|44322223|44555671|
; |45677   |     885|54488   |        | 7546788|8763588 |        |    7   |        |       7|77666786|68888888|        |     764|43322224|35456671|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |66678   |     883|45888   |        | 74578  | 863588 |        |        |        |      77|66666685|68776778|88      |     754|44322223|44556671|
; |65368   |    8856|468     |        | 7457   | 76458  |        |        |        |    7766|66666785|68867676|788     |     764|43322224|35456672|
; |536788  |    8645|68      |        | 757    | 76567  |        |        |        |   76655|66655685|68776767|6788    |     764|44332233|44556672|
; |547357  |   85776|88      |        | 757    |  6667  |        |        |        |  776554|54567784|58867676|77788   |     765|45333334|45456673|
; |6743477 |   86446|8       |        |  7     |  767   |        |        |        | 7765534|45666684|58776767|677888  |      75|45334344|45556673|
; |8865346 |  888688|        |        |        |   77   |        |        |        |77555345|44666784|58867676|7677888 |      75|45534444|54566773|
; |8878447 |  885468|        |        |        |        |        |        |        |75445344|54666783|58776767|6767878 |      76|44553335|45566774|
; |8887537 |  888888|        |        |        |        |        |        |        |64444444|53566783|57867676|76777878|      76|54545553|55667774|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
;          |58776767|67678788|        |       7|65454555|77878788|        |     676|45685875|77684865|56848677|57858583|676     |87885678|        |
;          |57766676|76777878|8       |       7|66545456|87787888|        |      73|78824587|48887552|35578885|78548487|47      |74384745|        |
;          |58765667|67678787|8       |       7|76555567|57878888|        |       7|85745857|54543345|54555555|75858747|7       |74373745|        |
;          |57765566|76777878|8       |        |76655675|5678888 |        |        |57778858|76434567|76555567|8588777 |        |85373746|        |
;          |58675567|67678787|8       |        |77666754|6588888 |        |        |88876688|87766772|37766778|88667888|        |86463756|        |
;          |57765566|76777878|88      |       7|57767745|85688885|8       |        | 8874567|87777756|65777778|7654788 |        |86464766|        |
;          |57675567|67678787|88      |       7|73777656|86688858|8       |        | 8775447|88654678|87655688|7445778 |        |88554776|        |
;          |57765666|76777878|88      |       7|27277666|87686485|8       |        |85688658|87765862|36856778|85688658|        | 8754777|        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |57676667|67678787|88      |      88|67557688|88675578|88      |       8|32578688|76576788|88767567|88687523|8       | 8754678|
; |        |57766676|76777877|88      |     632|37485768|86758475|356     |      83|45875688|76547652|35675567|88658854|38      |  874778|
; |        |57766767|67678788|88      |     885|75885768|86758857|588     |     845|87855887|88765784|48756788|78855877|548     |  87578 |
; |        |57767676|76777878|88      |     876|74745768|86754747|678     |      88|88846886|54478888|88887655|68864888|88      |  87578 |
; |        |57776767|67778788|8       |   85323|53834768|86743835|33458   |        | 8448886|54445543|24555655|68884488|        |   878  |
; |        |57767676|76787878|8       |     567|74845766|66754847|765     |        |87368  8|27545543|24555675|88 86377|        |   878  |
; |        |57777767|67778788|8       |     773|78585657|75658575|377     |        |75488  8|47828827|74884875|8  88457|        |    8   |
; |        |57788877|77787888|8       |     526|82858745|54785858|645     |        |84688  8|68848848|85885886|8  88647|        |    8   |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
;                            |        |        |67434775|58855587|26888888|88888864|83688  8|87868868|86886877|8  88637|        |        |        |        |        |        |
;                            |        |        |73223455|65544458|64888888|88888846|8368688 |   88888|77777   | 7868627|        |        |        |        |        |        |
;                            |        |        |32455545|64555445|88888888|88888888|7367468 |        |        | 7647637|        |        |        |        |        |        |
;                            |        |        |45666665|66666654|88888888|88888888|7436468 |        |        | 7646347|        |        |        |        |        |        |
;                            |        |        |56888184|68488865|88888888|88888888|8544588 |        |        |  854458|        |        |        |        |        |        |
;                            |        |        |68838387|78384886|28888888|88888883| 87688  |        |        |   8768 |        |        |        |        |        |        |
;                            |        |        |81688888|88888638|68288887|78888386|        |        |        |        |        |        |        |        |        |        |
;                            |        |        |66188888|88888366|68381884|68838486|        |        |        |        |        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        | 7777777|77887756|88888888|88888888|88888888|88888888|88788877|88888888|88888888|888     |        |        |        |
; |        |        |        |77777787|77778767|88888888|88888888|88888888|88888887|78778877|78777888|88888888|88888888|8       |        |        |
; |        |        |       7|77677786|77788878|78887888|88888888|88888888|88888887|78877887|78877788|88888888|88888888|88888   |        |        |
; |        |        |      77|77568776|78788868|87778888|88888888|88888888|88888888|77877787|77788777|88888888|88888888|8888888 |        |        |
; |        |        |     766|77578776|86788767|76677787|86888888|88888888|88888888|77787678|76678887|77888888|88888888|8888788 |        |        |
; |        |        |     767|77577776|66666666|76487778|74488888|88878887|77778788|77687656|87667788|77887778|78888888|87877788|88      |        |
; |        |        |     757|77676765|55555555|66887678|74677736|68774787|77878787|87558754|66756678|87788887|77877877|87777778|8888    |        |
; |        |        |     768|87665755|44343455|56667778|75787748|87675887|68667456|78545885|46674577|88777888|77778777|76676787|88788688|87      |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |    8787|66655544|58484344|84456778|76866648|76676876|86448756|78654676|54667467|77877777|67777666|65666666|77888888|888     |
; |        |        |   88766|66586666|66556658|55666788|86666657|66685766|85554877|86684467|85556774|87566666|68888656|55548555|66748777|78888   |
; |        |        |  887666|48886866|88886666|66666787|85488654|85665665|87666688|75486456|77755678|85484585|55666655|65488456|77788777|778888  |
; |        |        | 8877766|88777668|86688867|84877788|75565556|66665688|48888887|78558555|66864565|55885584|55567888|88778888|88888787|487888  |
; |        |        | 8877787|77788887|54445688|88888878|87665565|55688533|58455588|68668665|66765467|76668886|76678855|66666667|77778888|8877888 |
; |        |        |88787778|88887588|88765445|68687866|88886666|55544388|87666668|66767854|57776543|34555677|77886667|66777777|87877778|8788888 |
; |        |        |88778888|75555777|77777776|55557855|44334545|45668755|76766778|86877875|75575555|56666667|78867487|77777887|78787888|8888888 |
; |        |        |88888888|88888888|88888887|88888788|88888888|77778888|77777778|77887787|77777777|77788888|88888888|77778888|88888888|88888888|
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
$87:B364             db 00,00,00,00,00,00,00,00,00,00,00,00,03,04,00,1C,00,00,00,00,00,00,00,00,00,00,00,03,07,18,1C,23,
                        00,00,00,00,00,00,00,00,00,00,00,00,40,00,00,C0,00,00,00,00,00,00,00,00,00,00,00,C0,C0,20,E0,10,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,01,06,08,11,00,00,00,00,00,00,00,00,00,00,00,01,07,08,1F,20,
                        00,00,00,00,00,00,00,01,08,10,47,8F,13,73,9C,9F,00,00,00,00,00,00,01,0E,1F,60,FF,00,F3,0C,9F,60,
                        00,00,00,00,01,0F,87,00,E0,60,9F,9F,89,F0,3F,C8,00,00,00,00,0F,70,FF,00,E0,1F,9F,60,FF,00,F7,00,
                        00,00,00,00,FE,FE,51,AF,03,03,E0,E0,80,70,D0,30,00,00,00,00,FE,01,FF,00,03,FC,E0,1F,F0,08,F0,00,
                        00,00,00,00,00,00,00,00,18,F8,00,00,00,00,00,00,00,00,00,00,00,00,00,F0,F8,07,00,80,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        54,54,66,76,16,06,27,07,02,22,32,2A,2A,3A,35,35,74,0B,56,09,36,49,37,48,32,4D,3A,05,3A,05,35,0A,
                        05,06,02,03,03,02,00,01,03,03,0E,0E,38,38,0C,FC,07,08,03,04,03,04,01,02,03,8C,0E,F1,38,C7,FC,03,
                        D1,53,66,A6,0F,FF,93,6B,3E,72,7C,3D,BB,3A,B4,3C,D3,3C,E6,19,FF,00,FB,04,FE,21,FF,30,FB,3C,FC,13,
                        01,01,62,FE,17,68,A4,82,18,84,30,48,10,20,80,90,01,FE,FE,01,7F,80,A6,59,9C,60,78,80,B0,48,D0,28,
                        73,90,16,1A,D9,38,00,00,00,00,00,00,00,00,00,00,F3,0C,1E,E1,F9,06,00,FF,00,00,00,00,00,00,00,00,
                        40,C0,E0,E0,90,10,50,70,14,1C,00,00,00,00,00,00,C0,00,E0,00,90,60,70,88,1C,E2,00,0E,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        33,33,00,00,00,00,00,00,00,00,00,00,00,00,00,00,33,4C,00,73,00,00,00,00,00,00,00,00,00,00,00,00,
                        10,20,48,C0,28,F8,20,60,20,20,02,06,4B,51,25,16,30,C8,D8,20,F0,04,68,96,28,57,16,E9,BF,00,77,88,
                        00,00,00,00,03,02,0B,0D,4C,73,29,31,1D,13,0A,0D,00,00,00,03,03,0C,0F,70,7F,80,3E,C0,1F,20,0F,10,
                        25,0D,09,A9,92,52,F0,F1,18,F8,9E,81,F4,F7,F8,F8,3D,C2,E9,16,D2,3D,F1,7E,F8,0F,7F,00,F7,08,F8,7F,
                        E4,F8,8E,F7,3C,08,07,C7,87,F8,45,46,64,9C,16,19,FF,00,FF,00,3F,C0,C7,38,FF,00,47,B8,FC,03,1F,E0,
                        D8,10,57,47,0F,EC,77,B3,0C,70,9C,04,6C,80,19,91,EF,00,B8,00,F3,00,CC,00,FF,00,FB,00,FF,00,9E,60,
                        20,60,60,60,00,00,00,80,00,80,00,80,00,80,00,80,E0,00,E0,00,80,00,80,00,80,00,80,00,80,00,80,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,01,08,03,10,0E,35,2B,08,12,0F,10,00,00,00,09,01,1E,0B,14,1F,20,3E,00,1F,20,1F,20,
                        0F,10,A3,C0,3C,C0,D3,B0,46,81,38,06,E5,1D,98,78,1F,E0,FF,00,FF,00,6F,00,7F,00,FE,01,FD,03,F8,0F,
                        C6,3E,C6,3E,CD,3D,9A,7B,74,F5,C2,C2,31,31,72,73,FE,01,FE,01,FD,02,FB,04,F5,3A,C2,FD,31,CE,73,8C,
                        F0,32,B8,78,18,DE,4A,CE,84,84,03,03,F9,F9,1C,FC,F2,1D,F8,17,DE,31,CE,31,84,7A,03,FC,F9,06,FC,03,
                        70,58,88,98,00,E8,00,04,00,02,40,C0,E0,E0,00,00,78,80,98,60,E8,14,04,FA,02,01,C0,20,E0,10,00,C0,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,02,03,05,06,0F,0D,1E,1B,34,36,00,00,00,00,01,00,03,00,07,00,0E,00,1D,00,3A,01,
                        16,2E,A4,DC,58,88,B0,10,8F,CF,19,9E,68,71,A1,C7,3E,41,FC,03,F8,07,F0,0F,4F,30,9F,60,7F,80,FF,00,
                        64,64,0D,0D,11,1D,2C,32,92,E1,EE,2D,A1,A7,8B,1B,64,FB,0D,F2,1D,E2,3E,C1,FF,00,EF,10,87,58,BB,44,
                        C1,E2,83,E4,29,ED,A5,E9,ED,E9,E2,EC,62,EC,69,EE,E3,1C,E7,18,EE,10,EE,10,EE,10,EF,10,EF,10,EF,10,
                        CC,3C,26,1E,AD,9D,A8,99,3A,9B,51,B3,D6,B6,15,75,FC,03,FE,01,7D,02,79,06,7B,04,73,0C,76,09,F5,0A,
                        00,00,80,80,02,02,01,06,11,1D,4C,71,9D,E1,28,C6,00,80,80,70,02,FD,07,F8,1E,E0,7E,80,FE,00,FF,00,
                        00,00,00,00,40,40,00,80,00,40,48,80,47,A2,EC,88,00,00,00,00,40,80,80,40,C0,38,48,37,6F,10,67,10,
                        00,00,00,00,00,10,38,08,E0,E8,57,A9,CD,54,96,66,00,00,00,10,10,68,38,C0,D8,04,DF,00,BB,00,B9,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,E0,E0,30,90,00,00,00,00,00,00,00,00,00,00,00,00,E0,00,B0,40,
                        08,09,1E,1F,17,1E,1E,16,19,10,12,1B,04,01,03,05,0F,00,1B,00,1B,00,1B,00,1F,00,1D,00,07,08,07,08,
                        AB,8D,6A,2E,84,0C,1C,9C,3D,7F,4E,4E,00,00,00,00,67,10,CE,10,AC,50,9C,64,7F,81,4E,8E,00,80,00,00,
                        82,82,00,00,04,04,0E,0F,1F,10,50,60,2F,4F,5E,1E,82,05,00,07,04,03,0F,10,1F,60,7F,80,70,80,61,80,
                        02,01,88,91,4E,71,C0,CE,B6,77,58,39,A4,9D,E4,0D,03,FC,9F,60,7F,80,CE,31,F7,08,F9,06,7D,02,FD,02,
                        79,78,3C,BD,46,26,B5,15,05,95,E3,73,F7,6E,EF,64,79,86,BD,42,66,99,F5,0A,F5,0A,93,0C,9F,00,9F,00,
                        A5,56,A4,57,05,F7,8F,FF,7D,8F,9E,0D,5F,4C,A2,14,F7,08,F7,08,F7,08,FF,00,FF,00,FF,00,BF,00,F7,08,
                        00,00,00,00,01,01,01,01,02,03,05,07,05,05,0B,0E,00,00,00,00,01,00,01,00,03,00,06,00,06,00,0D,00,
                        6A,6F,D6,DC,88,90,F7,C6,6A,08,D6,12,E1,69,D9,C0,77,00,EF,00,FF,00,39,00,F6,01,EC,01,9B,04,39,06,
                        8A,16,C1,81,24,A5,A1,0F,D7,CF,CD,AD,CB,4B,C3,C3,FC,01,43,3C,8D,52,AF,51,5F,26,ED,1E,CB,2C,C3,44,
                        E2,F7,23,6E,25,3E,56,6D,18,4E,1C,40,14,6C,44,7C,77,08,6F,90,3F,C0,7F,80,7E,81,7C,83,7C,83,7C,83,
                        60,FF,69,E6,1D,96,56,5C,42,A0,BF,FD,63,61,70,72,FF,00,EF,10,9F,60,5F,A0,E3,1C,FE,00,62,9C,73,8C,
                        95,75,26,D7,42,93,D2,0B,72,AB,76,AF,54,8F,B5,46,F5,0A,F7,08,F3,0C,FB,04,DB,04,DF,00,FF,00,F7,08,
                        53,8B,A4,19,9A,31,D1,33,A2,78,3B,E8,92,61,5C,E3,FC,00,FE,00,FE,00,FE,00,F7,00,F7,00,FF,00,FF,00,
                        47,03,4C,00,65,0A,46,2F,F6,3E,9C,5C,5C,DC,08,08,EC,10,EF,10,EF,10,EF,10,FE,01,DC,23,DC,23,08,F4,
                        8B,32,F2,3C,5D,99,8B,C9,0A,07,01,02,01,02,01,02,FD,00,FF,00,DE,20,CF,30,0F,F0,03,7C,03,3C,03,3C,
                        50,70,20,E0,C0,60,40,A0,80,20,00,20,C0,A0,80,C0,B0,00,60,10,E0,10,E0,10,E0,10,E0,00,60,00,40,20,
                        00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,00,02,05,00,03,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        C2,81,A8,C6,53,6F,2F,3C,4F,4F,10,10,0C,1C,01,02,FF,00,FF,00,7F,80,3F,40,4F,30,10,0F,1C,03,03,04,
                        66,6F,F4,0D,AF,BE,3F,FE,F3,F2,52,53,98,38,2C,5F,9F,00,FD,02,BF,40,FF,00,F3,0C,53,AC,F8,07,7F,80,
                        22,60,20,60,29,65,CF,4B,E2,42,E5,66,F4,26,8C,8E,9B,04,9B,04,9E,00,BC,00,B5,08,B1,08,F1,08,89,70,
                        B1,54,C2,47,8B,13,0D,8D,1D,BD,5C,C8,48,C8,00,48,F7,08,C7,38,9F,60,93,60,BF,40,D4,23,D4,23,54,A3,
                        52,EE,F4,CC,A0,D8,08,F8,90,F0,E0,F0,10,F0,58,38,FE,01,FC,03,F8,07,F8,06,F0,0C,F0,08,F0,08,F8,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,01,01,01,00,00,E8,00,80,00,00,00,00,00,00,00,01,01,02,01,06,
                        0A,10,15,1C,03,01,0A,51,35,67,7C,50,78,C8,80,00,1F,20,1B,20,02,7C,5F,A0,5B,80,6C,83,B0,04,E0,18,
                        A0,60,40,C0,40,00,80,80,80,80,00,00,00,00,00,00,E0,00,C0,00,C0,00,80,00,80,00,00,00,00,00,00,00,
                        00,01,08,02,1C,1D,07,06,3F,2B,37,33,38,34,64,4C,01,0E,0E,11,1F,00,0F,10,37,00,2F,00,2C,03,7C,03,
                        7C,F8,22,22,18,A6,08,04,A8,F0,98,B8,68,50,58,70,FC,03,26,D9,BE,41,3C,C3,C8,07,FC,03,68,87,68,86,
                        BE,BE,1E,16,1F,14,1A,11,04,0B,10,14,0A,0A,00,00,B9,40,19,E0,1B,E0,1F,E0,0F,70,14,2B,0A,04,00,00,
                        54,08,40,1C,8C,5C,1C,DC,14,14,18,10,28,28,08,08,54,A3,54,A3,D4,23,D4,22,1C,E2,18,E4,28,14,08,00,
                        1A,1A,0E,0A,0A,0E,04,04,00,00,00,00,00,00,00,00,1E,E0,0E,10,0E,00,04,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,01,00,
                        00,00,00,00,00,00,01,01,02,03,0E,0F,7C,7D,C4,FD,00,00,00,00,00,00,01,00,03,00,0F,00,7D,02,FD,02,
                        00,00,00,00,00,00,80,80,40,C0,00,80,60,E0,00,80,00,00,00,00,00,00,80,00,C0,00,80,70,E0,1C,80,7F,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        01,01,02,03,02,03,03,02,03,02,04,06,04,06,04,06,01,00,03,00,03,00,03,00,03,00,07,00,07,00,07,00,
                        80,00,0E,0E,33,3F,60,7E,21,3F,60,7E,21,3F,60,7E,FF,00,F1,00,C0,00,81,00,C0,00,81,00,C0,00,81,00,
                        E5,5D,45,5D,14,0D,B1,8C,3B,06,DB,86,3B,06,D3,8E,BC,02,BC,02,FC,02,7C,02,FE,00,7E,00,FE,00,7E,00,
                        10,F0,60,B0,D0,70,BC,34,56,D6,18,2A,22,22,1E,16,F0,08,D0,08,B0,0C,EC,00,EE,00,36,C0,2E,D0,1A,E0,
                        01,01,02,01,01,04,0E,07,00,09,00,04,08,02,00,00,00,06,03,0C,07,08,0F,10,0F,10,04,3B,0E,31,00,3F,
                        40,00,00,40,00,80,00,00,00,00,00,00,00,00,00,00,C0,38,C0,20,80,40,00,C0,00,80,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        58,48,58,48,70,50,70,50,20,20,00,00,00,00,00,00,78,04,78,00,70,00,70,00,20,00,00,00,00,00,00,00,
                        18,30,48,60,54,6C,04,3C,28,38,18,18,00,00,00,00,28,46,78,04,7C,00,3C,00,38,00,18,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,03,0C,0F,13,1C,36,38,6E,72,FD,C4,CC,84,00,80,03,00,0F,00,1F,00,3F,00,7D,00,FB,00,FB,00,FF,00,
                        01,FC,05,FC,19,E4,AC,1C,40,3C,04,3C,85,3D,E5,5D,FD,02,FD,02,FD,02,FD,02,FD,02,FD,02,FC,02,BC,02,
                        36,BE,0A,9F,35,BF,8A,1F,B5,3F,8A,1F,B5,3F,CA,5F,BE,41,9F,60,BF,40,9F,60,BF,40,9F,60,BF,40,DF,20,
                        00,00,80,80,40,C0,E0,E0,60,E0,B0,F0,54,F4,BA,FA,00,C0,80,60,C0,30,E0,18,E0,1C,F0,0E,F4,0A,FA,05,
                        06,04,04,06,04,06,05,06,03,02,03,02,02,03,02,03,07,00,07,00,07,00,07,00,03,00,03,00,03,00,03,00,
                        21,3F,60,7E,33,3F,7E,3E,74,34,70,10,3F,0E,AF,01,C0,00,81,00,C0,00,C1,00,CB,00,EF,00,F1,00,FE,00,
                        33,0E,D2,8F,32,0F,53,0F,73,0F,A7,1F,66,1E,CE,3E,FE,00,7E,00,FE,00,FE,00,FE,00,FE,00,FF,00,FF,00,
                        B5,3F,E2,7F,A9,37,EC,73,9D,33,EC,73,DD,73,E8,77,BF,40,FF,00,BF,40,FF,00,BF,40,FF,00,FF,00,FF,00,
                        54,F4,BA,FA,55,F5,BA,FA,55,F5,BA,FA,55,F5,BA,FA,F4,0B,FA,05,F5,0A,FA,05,F5,0A,FA,05,F5,0A,FA,05,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,80,00,80,00,80,00,C0,00,C0,00,C0,
                        01,01,01,01,01,01,00,00,00,00,01,01,01,01,01,01,01,00,01,00,01,00,00,00,00,00,01,00,01,00,01,00,
                        57,80,2A,C1,BD,C3,9B,E6,C6,FC,ED,7C,FA,FD,58,FF,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,BF,00,5F,00,
                        D4,D4,68,68,D0,50,A0,60,40,80,41,20,02,60,41,68,D4,2B,68,97,D0,2F,E0,1E,C0,3E,61,9E,62,9D,6D,92,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,80,00,80,
                        02,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,07,00,02,00,01,00,00,00,00,00,00,00,00,00,00,00,
                        4B,22,85,91,6B,21,F2,70,10,1C,15,13,39,31,42,24,EB,14,8D,62,7B,84,F2,0D,1C,E3,1F,60,3F,40,66,99,
                        C1,E2,0E,09,AD,0C,95,D3,66,7F,7E,7D,12,26,68,73,EB,14,8E,70,F3,00,EF,00,7E,80,7F,80,3E,C1,7A,84,
                        83,47,F1,90,BF,00,BD,C3,E6,FE,7E,BE,58,64,96,CE,D7,28,71,0E,FF,00,FF,00,7E,01,FE,01,7C,83,5E,21,
                        D5,41,A1,81,D5,85,4E,0E,08,38,A8,C8,9C,8C,42,24,D4,2A,B5,4A,D7,28,4E,B0,38,C7,F8,06,FC,02,66,99,
                        40,E0,40,40,80,80,00,00,00,00,00,00,00,00,00,00,E0,00,C0,00,80,00,00,00,00,00,00,00,00,00,00,00,
                        4A,46,A5,A4,BD,BC,7C,3D,0E,5D,04,57,36,07,37,27,4E,B1,CF,10,D7,00,57,80,77,80,7F,80,3F,C0,3F,40,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        D1,7F,E2,7F,E5,7F,EA,7F,F5,7F,EA,7F,FD,7F,E3,63,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,E3,1C,
                        55,F5,BB,FB,54,F4,BA,FA,74,F4,AA,EA,74,F4,E8,E8,F5,0A,FB,04,F4,0B,FA,05,F4,0B,EA,15,F4,0B,E8,17,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,C0,00,C0,00,C0,00,C0,00,80,00,80,00,80,00,80,
                        00,00,02,07,01,00,02,03,0D,07,05,03,07,07,04,03,00,03,04,00,01,06,03,04,08,10,07,00,06,00,05,00,
                        78,CC,CC,C6,CC,86,AC,A6,D4,56,8C,87,AB,85,15,44,FC,03,6E,11,CE,31,FE,01,8E,21,DF,20,AF,50,17,A8,
                        1E,32,33,62,33,61,35,65,2B,6A,31,E1,D7,A2,AA,20,3E,C1,77,88,73,8C,7F,80,71,84,FB,04,F7,08,EA,15,
                        00,00,C0,A0,80,00,40,C0,D0,C0,A0,C0,E0,E0,20,80,00,C0,60,00,80,60,C0,20,30,08,E0,00,60,00,E0,00,
                        00,00,01,01,01,00,00,00,00,00,00,00,00,00,00,00,00,01,00,02,03,04,00,03,00,00,00,00,00,00,00,00,
                        B0,D4,58,14,59,41,00,09,00,01,60,70,C0,80,00,20,34,0B,DC,23,59,A6,19,E6,31,4E,50,89,E0,19,60,99,
                        B4,DC,AA,CD,2C,34,90,10,8D,01,6D,C1,41,53,00,80,FC,03,FE,00,3D,C2,F0,0F,FE,00,7E,00,C1,2C,92,6D,
                        2D,3B,DD,B3,34,2C,0B,0C,3B,84,3B,86,83,82,48,01,3F,C0,7F,00,BC,43,0F,F0,7F,00,7F,00,CB,34,49,B6,
                        0D,2B,12,20,9B,83,00,90,00,80,07,0F,03,01,01,05,2C,D0,33,CC,9B,64,98,67,8C,73,0B,D0,07,98,07,98,
                        00,00,80,80,80,00,00,00,00,00,00,00,00,00,00,00,00,80,00,40,C0,20,00,C0,00,00,00,00,00,00,00,00,
                        32,26,16,16,1C,14,1C,14,08,08,08,08,00,00,00,00,3E,41,1E,21,1C,22,1C,22,08,14,08,14,00,08,00,08,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        57,D6,CB,F8,9D,C0,41,3E,84,40,15,95,40,20,20,C0,EF,00,87,00,3F,00,FF,00,C1,3A,81,6A,20,9F,C0,1F,
                        9D,01,62,80,39,80,02,FC,01,82,A0,A1,02,06,04,07,9D,62,FE,01,FF,00,FF,00,A3,5C,89,56,04,F9,03,F8,
                        00,C0,00,80,00,00,00,00,00,00,00,80,01,A1,28,A0,40,3F,C0,3F,00,FF,00,FF,00,FF,00,7F,81,5E,81,56,
                        00,02,00,01,00,00,00,00,00,00,01,01,84,85,10,91,03,FC,03,FC,00,FF,00,FF,00,FF,00,FE,81,7A,85,6A,
                        40,60,40,68,D0,F4,A0,B4,48,00,20,30,00,00,00,00,20,99,28,96,BC,02,DC,02,78,86,30,4C,00,00,00,00,
                        40,52,00,00,00,00,00,00,00,00,00,00,00,00,00,00,52,AD,00,1F,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,4B,F8,F8,00,00,00,00,00,00,00,00,00,00,00,00,4B,B4,F8,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,07,41,57,4B,6F,45,6D,12,00,08,0C,00,00,00,00,05,98,55,28,7D,00,7B,00,1E,21,0C,12,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,01,01,03,03,04,07,05,07,07,05,04,06,00,00,00,00,01,00,03,00,07,00,07,00,07,00,06,01,
                        7F,7F,FD,FD,DC,FD,E6,D7,F6,D7,FE,DF,D5,FE,4F,74,7F,00,FD,02,FD,02,F7,08,F7,08,FF,00,FF,00,7F,80,
                        CE,CD,F5,F7,E2,E2,A0,A2,25,67,00,FF,FF,00,2B,28,CF,30,F7,08,E2,1D,A2,5D,67,98,FF,00,FF,00,D7,00,
                        00,00,00,00,88,88,70,70,9D,FD,8E,CE,0A,CE,8E,7E,00,FF,00,FF,88,77,70,8F,FD,02,EE,11,CE,31,FE,01,
                        00,00,00,00,00,00,00,00,00,40,80,80,9E,BF,EC,AC,00,FF,00,FF,00,FF,00,FF,40,BF,E0,1F,FD,00,EE,11,
                        00,00,00,00,00,00,00,00,00,00,11,11,35,B5,59,71,00,FF,00,FF,00,FF,00,FF,00,FF,11,EE,BD,42,79,86,
                        00,00,01,01,01,01,00,00,00,00,F4,F4,D5,D5,0A,B9,00,FF,01,FE,01,FE,00,FF,00,FF,F4,0B,D5,2A,BF,40,
                        23,23,B3,B3,99,99,DD,DD,EA,EE,CA,ED,76,44,A9,80,23,DC,B3,4C,99,66,DD,22,EE,11,EF,10,77,88,B9,46,
                        00,00,B8,B8,9C,9C,E7,E7,91,F1,4C,7C,32,EE,17,73,00,FF,B8,47,9C,63,E7,18,F1,0E,7C,83,FE,01,FF,00,
                        00,00,00,00,00,00,00,00,C0,C0,CE,CE,61,61,38,38,00,FF,00,FF,00,FF,00,FF,C0,3F,CE,31,61,9E,38,C7,
                        00,00,00,00,00,00,00,00,00,00,80,80,DB,DB,F7,F7,00,E0,00,FF,00,FF,00,FF,00,FF,80,7F,DB,24,F7,08,
                        00,00,00,00,00,00,00,00,08,08,5C,5C,7E,7E,95,FD,00,00,00,80,00,F8,00,FE,08,F6,5C,A3,7E,81,FD,02,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,20,24,00,00,00,00,00,00,00,00,00,00,00,C0,00,F0,24,DB,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,40,40,00,00,00,00,00,00,00,00,00,00,00,00,00,00,40,80,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        05,05,04,07,08,0F,1C,1F,1D,1D,2E,2E,30,30,00,00,05,0A,07,18,0F,30,1F,60,1D,62,2E,D1,30,CF,00,FF,
                        1C,E0,20,CF,00,0B,38,3E,E1,E1,0C,08,FF,87,00,00,FF,00,EF,10,8B,74,3E,C1,E1,1E,0C,F3,FF,00,00,FF,
                        84,04,32,CC,00,0F,01,63,88,04,29,30,FE,FF,01,01,AB,50,FE,01,0F,F0,63,9C,FC,03,3F,C0,FF,00,01,FE,
                        16,0E,C4,3C,05,FD,1C,1C,02,02,08,AB,FB,08,04,04,7E,81,FC,03,FD,02,5C,A3,02,FD,AB,54,FB,04,04,FB,
                        80,DC,03,7D,42,04,EE,91,4D,72,00,0F,35,30,00,00,DE,21,7F,80,67,98,FF,00,7F,80,0F,F0,CF,00,00,FF,
                        92,FB,0C,E7,49,36,08,F4,C7,23,E4,04,47,34,F0,F0,FB,04,EF,10,7F,80,FC,03,E4,18,F8,03,F7,08,F0,0F,
                        06,45,73,03,40,7C,01,01,9C,00,40,7E,A6,FE,FE,FE,77,88,7B,84,7C,83,81,7E,BC,43,7E,81,FE,01,FE,01,
                        92,A7,01,63,C2,89,B7,80,01,B6,2A,F8,1B,5A,CD,CD,BF,40,6F,90,EF,10,B7,48,B7,48,FB,04,5B,A4,CD,32,
                        89,3B,76,0E,FA,E6,05,D2,29,F3,F5,79,FF,90,FF,FF,FF,00,7F,80,FE,01,DF,20,FF,00,FE,00,FF,00,FF,00,
                        DF,DF,60,5F,45,00,CC,00,80,F1,BB,87,81,7F,E0,E0,DF,20,7F,80,6D,92,CD,32,F1,0E,7F,00,FF,00,E0,1F,
                        78,FF,02,85,C3,3C,E8,18,93,F0,C1,CF,89,99,00,00,FF,00,87,78,FF,00,F8,07,F3,0C,CF,30,9D,62,00,FF,
                        40,BF,E7,00,42,81,30,30,01,FF,3F,FF,F9,F9,F0,F0,FF,00,F7,08,E7,18,30,CF,FF,00,FF,00,F9,06,F0,0F,
                        C0,C0,27,E7,E7,E7,05,05,F0,F0,5E,5E,A8,A8,00,00,C0,3F,F7,08,E7,18,05,FA,F0,0F,5E,A1,A8,57,00,FF,
                        00,00,80,80,C0,C0,20,20,30,30,40,40,00,00,00,00,00,E0,80,78,C0,3C,A0,5C,30,CE,40,BE,00,FE,00,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
}


;;; $C964: Free space ;;;
{
$87:C964             fillto $888000, $FF
}
