;;; $8000: Enable enemy projectiles ;;;
{
$86:8000 08          PHP
$86:8001 C2 20       REP #$20
$86:8003 A9 00 80    LDA #$8000
$86:8006 0C 8D 19    TSB $198D  [$7E:198D]
$86:8009 28          PLP
$86:800A 6B          RTL
}


;;; $800B: Disable enemy projectiles ;;;
{
$86:800B 08          PHP
$86:800C C2 20       REP #$20
$86:800E A9 00 80    LDA #$8000
$86:8011 1C 8D 19    TRB $198D  [$7E:198D]
$86:8014 28          PLP
$86:8015 6B          RTL
}


;;; $8016: Clear enemy projectiles ;;;
{
$86:8016 08          PHP
$86:8017 C2 30       REP #$30
$86:8019 DA          PHX
$86:801A A2 22 00    LDX #$0022             ; Y = 22h (enemy projectile index)

; LOOP
$86:801D 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:8020 CA          DEX                    ;\
$86:8021 CA          DEX                    ;} Y -= 2
$86:8022 10 F9       BPL $F9    [$801D]     ; If [Y] >= 0: go to LOOP
$86:8024 FA          PLX
$86:8025 28          PLP
$86:8026 6B          RTL
}


;;; $8027: Spawn enemy projectile [Y] with parameter [A] using enemy [X] graphics ;;;
{
;; Parameters:
;;     A: Enemy projectile initialisation parameter
;;     X: Enemy index, determines enemy projectile graphics indices
;;     Y: Enemy projectile ID
;; Returns:
;;     Carry: Set if enemy projectile could not be spawned
;;     A: Enemy projectile index if spawned
$86:8027 08          PHP
$86:8028 8B          PHB
$86:8029 DA          PHX
$86:802A 5A          PHY
$86:802B 8D 93 19    STA $1993  [$7E:1993]  ; Enemy projectile initialisation parameter = [A]
$86:802E 4B          PHK                    ;\
$86:802F AB          PLB                    ;} DB = $86
$86:8030 BD 96 0F    LDA $0F96,x[$86:A396]  ;\
$86:8033 1D 98 0F    ORA $0F98,x[$86:A398]  ;} A = [enemy palette index] | [enemy VRAM tiles index]
$86:8036 48          PHA                    ;/
$86:8037 BB          TYX                    ; X = [Y]
$86:8038 A0 22 00    LDY #$0022             ; Y = 22h (enemy projectile index)

; LOOP
$86:803B B9 97 19    LDA $1997,y[$7E:19B9]  ;\
$86:803E F0 0B       BEQ $0B    [$804B]     ;} If [enemy projectile ID] = 0: go to BRANCH_FOUND
$86:8040 88          DEY                    ;\
$86:8041 88          DEY                    ;} Y -= 2
$86:8042 10 F7       BPL $F7    [$803B]     ; If [Y] >= 0: go to LOOP
$86:8044 68          PLA
$86:8045 7A          PLY
$86:8046 FA          PLX
$86:8047 AB          PLB
$86:8048 28          PLP
$86:8049 38          SEC                    ;\
$86:804A 6B          RTL                    ;} Return carry set

; BRANCH_FOUND
$86:804B 68          PLA                    ;\
$86:804C 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile graphics indices = [enemy palette index] | [enemy VRAM tiles index]
$86:804F 8A          TXA                    ;\
$86:8050 99 97 19    STA $1997,y[$7E:19B9]  ;} Enemy projectile ID = [X]
$86:8053 BD 02 00    LDA $0002,x[$86:A389]  ;\
$86:8056 99 03 1A    STA $1A03,y[$7E:1A25]  ;} Enemy projectile pre-instruction = [[X] + 2]
$86:8059 BD 04 00    LDA $0004,x[$86:A38B]  ;\
$86:805C 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = [[X] + 4]
$86:805F BD 06 00    LDA $0006,x[$86:A38D]  ;\
$86:8062 99 B3 1B    STA $1BB3,y[$7E:1BD5]  ;} Enemy projectile X / Y radius = [[X] + 6]
$86:8065 BD 08 00    LDA $0008,x[$86:A38F]  ;\
$86:8068 99 D7 1B    STA $1BD7,y[$7E:1BF9]  ;} Enemy projectile properties = [[X] + 8]
$86:806B A9 01 00    LDA #$0001             ;\
$86:806E 99 8F 1B    STA $1B8F,y[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:8071 A9 00 80    LDA #$8000             ;\
$86:8074 99 6B 1B    STA $1B6B,y[$7E:1B8D]  ;} Enemy projectile spritemap pointer = $8000
$86:8077 A9 00 00    LDA #$0000             ;\
$86:807A 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile $1AFF = 0
$86:807D 99 23 1B    STA $1B23,y[$7E:1B45]  ; Enemy projectile $1B23 = 0
$86:8080 99 DF 19    STA $19DF,y[$7E:1A01]  ; Enemy projectile timer = 0
$86:8083 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile $1A27 = 0
$86:8086 99 6F 1A    STA $1A6F,y[$7E:1A91]  ; Enemy projectile $1A6F = 0
$86:8089 99 FB 1B    STA $1BFB,y[$7E:1C1D]  ; Enemy projectile collided projectile type = 0
$86:808C 5A          PHY
$86:808D FC 00 00    JSR ($0000,x)[$86:A2EE]; Execute [[X]] (initialisation AI)
$86:8090 68          PLA
$86:8091 7A          PLY
$86:8092 FA          PLX
$86:8093 AB          PLB
$86:8094 28          PLP
$86:8095 18          CLC                    ;\
$86:8096 6B          RTL                    ;} Return carry clear
}


;;; $8097: Spawn enemy projectile [Y] with parameter [A] using room graphics ;;;
{
;; Parameters:
;;     A: Enemy projectile initialisation parameter
;;     Y: Enemy projectile ID
;; Returns:
;;     Carry: Set if enemy projectile could not be spawned
;;     A: Enemy projectile index if spawned

; (0 used for palette and graphics index)
; Used by some enemies, also gate PLMs
$86:8097 08          PHP
$86:8098 8B          PHB
$86:8099 DA          PHX
$86:809A 5A          PHY
$86:809B 8D 93 19    STA $1993  [$7E:1993]  ; Enemy projectile initialisation parameter = [A]
$86:809E 4B          PHK                    ;\
$86:809F AB          PLB                    ;} DB = $86
$86:80A0 BB          TYX                    ; X = [Y]
$86:80A1 A0 22 00    LDY #$0022             ; Y = 22h (enemy projectile index)

; LOOP
$86:80A4 B9 97 19    LDA $1997,y[$7E:19B9]  ;\
$86:80A7 F0 0A       BEQ $0A    [$80B3]     ;} If [enemy projectile ID] = 0: go to BRANCH_FOUND
$86:80A9 88          DEY                    ;\
$86:80AA 88          DEY                    ;} Y -= 2
$86:80AB 10 F7       BPL $F7    [$80A4]     ; If [Y] >= 0: go to LOOP
$86:80AD 7A          PLY
$86:80AE FA          PLX
$86:80AF AB          PLB
$86:80B0 28          PLP
$86:80B1 38          SEC                    ;\
$86:80B2 6B          RTL                    ;} Return carry set

; BRANCH_FOUND
$86:80B3 A9 00 00    LDA #$0000             ;\
$86:80B6 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:80B9 8A          TXA                    ;\
$86:80BA 99 97 19    STA $1997,y[$7E:19B9]  ;} Enemy projectile ID = [X]
$86:80BD BD 02 00    LDA $0002,x[$86:9736]  ;\
$86:80C0 99 03 1A    STA $1A03,y[$7E:1A25]  ;} Enemy projectile pre-instruction = [[X] + 2]
$86:80C3 BD 04 00    LDA $0004,x[$86:9738]  ;\
$86:80C6 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = [[X] + 4]
$86:80C9 BD 06 00    LDA $0006,x[$86:973A]  ;\
$86:80CC 99 B3 1B    STA $1BB3,y[$7E:1BD5]  ;} Enemy projectile X / Y radius = [[X] + 6]
$86:80CF BD 08 00    LDA $0008,x[$86:973C]  ;\
$86:80D2 99 D7 1B    STA $1BD7,y[$7E:1BF9]  ;} Enemy projectile properties = [[X] + 8]
$86:80D5 A9 01 00    LDA #$0001             ;\
$86:80D8 99 8F 1B    STA $1B8F,y[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:80DB A9 00 80    LDA #$8000             ;\
$86:80DE 99 6B 1B    STA $1B6B,y[$7E:1B8D]  ;} Enemy projectile spritemap pointer = $8000
$86:80E1 A9 00 00    LDA #$0000             ;\
$86:80E4 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile $1AFF = 0
$86:80E7 99 23 1B    STA $1B23,y[$7E:1B45]  ; Enemy projectile $1B23 = 0
$86:80EA 99 DF 19    STA $19DF,y[$7E:1A01]  ; Enemy projectile timer = 0
$86:80ED 99 DF 19    STA $19DF,y[$7E:1A01]  ; >_<;
$86:80F0 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile $1A27 = 0
$86:80F3 99 6F 1A    STA $1A6F,y[$7E:1A91]  ; Enemy projectile $1A6F = 0
$86:80F6 99 FB 1B    STA $1BFB,y[$7E:1C1D]  ; Enemy projectile collided projectile type = 0
$86:80F9 5A          PHY
$86:80FA FC 00 00    JSR ($0000,x)[$86:96DC]; Execute [[X]] (initialisation AI)
$86:80FD 68          PLA
$86:80FE 7A          PLY
$86:80FF FA          PLX
$86:8100 AB          PLB
$86:8101 28          PLP
$86:8102 18          CLC                    ;\
$86:8103 6B          RTL                    ;} Return carry clear
}


;;; $8104: Enemy projectile handler ;;;
{
$86:8104 08          PHP
$86:8105 8B          PHB
$86:8106 4B          PHK                    ;\
$86:8107 AB          PLB                    ;} DB = $86
$86:8108 2C 8D 19    BIT $198D  [$7E:198D]  ;\
$86:810B 10 15       BPL $15    [$8122]     ;} If enemy projectiles not enabled: return
$86:810D A2 22 00    LDX #$0022             ; X = 22h (enemy projectile index)

; LOOP
$86:8110 8E 91 19    STX $1991  [$7E:1991]  ; Enemy projectile index = [X]
$86:8113 BD 97 19    LDA $1997,x[$7E:19B9]  ;\
$86:8116 F0 06       BEQ $06    [$811E]     ;} If [enemy projectile ID] != 0:
$86:8118 20 25 81    JSR $8125  [$86:8125]  ; Process enemy projectile
$86:811B AE 91 19    LDX $1991  [$7E:1991]  ; X = [enemy projectile index]

$86:811E CA          DEX                    ;\
$86:811F CA          DEX                    ;} X -= 2
$86:8120 10 EE       BPL $EE    [$8110]     ; If [X] >= 0: go to LOOP

$86:8122 AB          PLB
$86:8123 28          PLP
$86:8124 6B          RTL
}


;;; $8125: Process enemy projectile ;;;
{
;; Parameter:
;;     X: Enemy projectile index
$86:8125 FC 03 1A    JSR ($1A03,x)[$86:A328]; Execute [enemy projectile pre-instruction]
$86:8128 AE 91 19    LDX $1991  [$7E:1991]  ; X = [enemy projectile index]
$86:812B DE 8F 1B    DEC $1B8F,x[$7E:1BB1]  ; Decrement enemy projectile instruction timer
$86:812E D0 23       BNE $23    [$8153]     ; If [enemy projectile instruction timer] != 0: return
$86:8130 BC 47 1B    LDY $1B47,x[$7E:1B69]  ; Y = [enemy projectile instruction list pointer]

; LOOP
$86:8133 B9 00 00    LDA $0000,y[$86:A28D]  ;\
$86:8136 10 0A       BPL $0A    [$8142]     ;} If [[Y]] & 8000h != 0:
$86:8138 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]] (ASM instruction pointer)
$86:813A C8          INY                    ;\
$86:813B C8          INY                    ;} Y += 2
$86:813C F4 32 81    PEA $8132              ; Return to LOOP
$86:813F 6C 12 00    JMP ($0012)[$86:81AB]  ; Execute [$12]

$86:8142 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ; Enemy projectile instruction timer = [[Y]] (spritemap timer)
$86:8145 B9 02 00    LDA $0002,y[$86:A28F]  ;\
$86:8148 9D 6B 1B    STA $1B6B,x[$7E:1B8D]  ;} Enemy projectile spritemap pointer = [[Y] + 2]
$86:814B 98          TYA                    ;\
$86:814C 18          CLC                    ;|
$86:814D 69 04 00    ADC #$0004             ;} Enemy projectile instruction list pointer = [Y] + 4
$86:8150 9D 47 1B    STA $1B47,x[$7E:1B69]  ;/

$86:8153 60          RTS
}


;;; $8154..838F: Generic instructions ;;;
{
;;; $8154: Instruction - delete ;;;
{
$86:8154 9E 97 19    STZ $1997,x[$7E:19B7]
$86:8157 68          PLA
$86:8158 60          RTS
}


;;; $8159: Instruction - sleep ;;;
{
$86:8159 88          DEY
$86:815A 88          DEY
$86:815B 98          TYA
$86:815C 9D 47 1B    STA $1B47,x[$7E:1B69]
$86:815F 68          PLA
$86:8160 60          RTS
}


;;; $8161: Instruction - pre-instruction = [[Y]] ;;;
{
$86:8161 B9 00 00    LDA $0000,y[$86:A4CC]
$86:8164 9D 03 1A    STA $1A03,x[$7E:1A25]
$86:8167 C8          INY
$86:8168 C8          INY
$86:8169 60          RTS
}


;;; $816A: Instruction - clear pre-instruction ;;;
{
$86:816A A9 70 81    LDA #$8170
$86:816D 9D 03 1A    STA $1A03,x[$7E:1A11]
$86:8170 60          RTS
}


;;; $8171: Instruction - call external function [[Y]] ;;;
{
$86:8171 B9 00 00    LDA $0000,y[$86:C79C]
$86:8174 85 12       STA $12    [$7E:0012]
$86:8176 B9 01 00    LDA $0001,y[$86:C79D]
$86:8179 85 13       STA $13    [$7E:0013]
$86:817B 5A          PHY
$86:817C 22 88 81 86 JSL $868188[$86:8188]
$86:8180 7A          PLY
$86:8181 AE 91 19    LDX $1991  [$7E:1991]
$86:8184 C8          INY
$86:8185 C8          INY
$86:8186 C8          INY
$86:8187 60          RTS

$86:8188 DC 12 00    JML [$0012][$86:C7FB]
}


;;; $818B: Unused. Instruction - call external function [[Y]] with 2 byte parameter [[Y] + 3] ;;;
{
$86:818B B9 00 00    LDA $0000,y
$86:818E 85 12       STA $12    [$7E:0012]
$86:8190 B9 01 00    LDA $0001,y
$86:8193 85 13       STA $13    [$7E:0013]
$86:8195 B9 03 00    LDA $0003,y
$86:8198 5A          PHY
$86:8199 22 A8 81 86 JSL $8681A8[$86:81A8]
$86:819D 7A          PLY
$86:819E AE 91 19    LDX $1991  [$7E:1991]
$86:81A1 98          TYA
$86:81A2 18          CLC
$86:81A3 69 05 00    ADC #$0005
$86:81A6 A8          TAY
$86:81A7 60          RTS

$86:81A8 DC 12 00    JML [$0012]
}


;;; $81AB: Instruction - go to [[Y]] ;;;
{
$86:81AB B9 00 00    LDA $0000,y[$86:A29F]
$86:81AE A8          TAY
$86:81AF 60          RTS
}


;;; $81B0: Instruction - go to [Y] + ±[[Y]] ;;;
{
$86:81B0 84 12       STY $12    [$7E:0012]
$86:81B2 88          DEY
$86:81B3 B9 00 00    LDA $0000,y
$86:81B6 EB          XBA
$86:81B7 30 05       BMI $05    [$81BE]
$86:81B9 29 FF 00    AND #$00FF
$86:81BC 80 03       BRA $03    [$81C1]

$86:81BE 09 00 FF    ORA #$FF00

$86:81C1 18          CLC
$86:81C2 65 12       ADC $12    [$7E:0012]
$86:81C4 A8          TAY
$86:81C5 60          RTS
}


;;; $81C6: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$86:81C6 DE DF 19    DEC $19DF,x[$7E:1A01]
$86:81C9 D0 E0       BNE $E0    [$81AB]
$86:81CB C8          INY
$86:81CC C8          INY
$86:81CD 60          RTS
}


;;; $81CE: Unused. Instruction - decrement timer and go to [Y] + ±[[Y]] if non-zero ;;;
{
$86:81CE DE DF 19    DEC $19DF,x
$86:81D1 D0 DD       BNE $DD    [$81B0]
$86:81D3 C8          INY
$86:81D4 60          RTS
}


;;; $81D5: Instruction - timer = [[Y]] ;;;
{
$86:81D5 B9 00 00    LDA $0000,y[$86:ECAD]
$86:81D8 9D DF 19    STA $19DF,x[$7E:1A01]
$86:81DB C8          INY
$86:81DC C8          INY
$86:81DD 60          RTS
}


;;; $81DE: RTS. Instruction - NOP ;;;
{
$86:81DE 60          RTS
}


;;; $81DF: Instruction - move randomly within X radius [[Y]] - [[Y] - 1] and Y radius [[Y] - 2] - [[Y] - 3] ;;;
{
; Assumes [[Y]] + 1 and [[Y] + 2] + 1 are powers of 2
$86:81DF 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:81E3 85 12       STA $12    [$7E:0012]  ; $12 = [random number]

; LOOP_X
$86:81E5 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:81E9 E2 20       SEP #$20               ;\
$86:81EB 39 00 00    AND $0000,y[$86:A3D9]  ;|
$86:81EE 38          SEC                    ;} A = ([random number] & [[Y]]) - [[Y] + 1]
$86:81EF F9 01 00    SBC $0001,y[$86:A3DA]  ;/
$86:81F2 C2 20       REP #$20
$86:81F4 30 EF       BMI $EF    [$81E5]     ; If [A] < 0: go to LOOP_X
$86:81F6 29 FF 00    AND #$00FF
$86:81F9 24 12       BIT $12    [$7E:0012]  ;\
$86:81FB 10 04       BPL $04    [$8201]     ;} If [$12] & 8000h:
$86:81FD 49 FF FF    EOR #$FFFF             ;\
$86:8200 1A          INC A                  ;} A = -[A]

$86:8201 18          CLC                    ;\
$86:8202 7D 4B 1A    ADC $1A4B,x[$7E:1A59]  ;} Enemy projectile X position += [A]
$86:8205 9D 4B 1A    STA $1A4B,x[$7E:1A59]  ;/

; LOOP_Y
$86:8208 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:820C E2 20       SEP #$20               ;\
$86:820E 39 02 00    AND $0002,y[$86:A3DB]  ;|
$86:8211 38          SEC                    ;} A = (random number & [[Y] + 2]) - [[Y] + 3]
$86:8212 F9 03 00    SBC $0003,y[$86:A3DC]  ;/
$86:8215 C2 20       REP #$20
$86:8217 30 EF       BMI $EF    [$8208]     ; If [A] < 0: go to LOOP_Y
$86:8219 29 FF 00    AND #$00FF
$86:821C 24 12       BIT $12    [$7E:0012]  ;\
$86:821E 50 04       BVC $04    [$8224]     ;} If [$12] & 4000h:
$86:8220 49 FF FF    EOR #$FFFF             ;\
$86:8223 1A          INC A                  ;} A = -[A]

$86:8224 18          CLC                    ;\
$86:8225 7D 93 1A    ADC $1A93,x[$7E:1AA1]  ;} Enemy projectile Y position += [A]
$86:8228 9D 93 1A    STA $1A93,x[$7E:1AA1]  ;/
$86:822B C8          INY                    ;\
$86:822C C8          INY                    ;|
$86:822D C8          INY                    ;} Y += 4
$86:822E C8          INY                    ;/
$86:822F 60          RTS
}


;;; $8230: Instruction - enemy projectile properties |= [[Y]] ;;;
{
$86:8230 BD D7 1B    LDA $1BD7,x[$7E:1BE7]
$86:8233 19 00 00    ORA $0000,y[$86:A478]
$86:8236 9D D7 1B    STA $1BD7,x[$7E:1BE7]
$86:8239 C8          INY
$86:823A C8          INY
$86:823B 60          RTS
}


;;; $823C: Instruction - enemy projectile properties &= [[Y]] ;;;
{
$86:823C BD D7 1B    LDA $1BD7,x[$7E:1BE7]
$86:823F 39 00 00    AND $0000,y[$86:A480]
$86:8242 9D D7 1B    STA $1BD7,x[$7E:1BE7]
$86:8245 C8          INY
$86:8246 C8          INY
$86:8247 60          RTS
}


;;; $8248: Unused. Instruction - enable collision with Samus projectiles ;;;
{
$86:8248 BD D7 1B    LDA $1BD7,x
$86:824B 09 00 80    ORA #$8000
$86:824E 9D D7 1B    STA $1BD7,x
$86:8251 60          RTS
}


;;; $8252: Instruction - disable collision with Samus projectiles ;;;
{
$86:8252 BD D7 1B    LDA $1BD7,x[$7E:1BE5]
$86:8255 29 FF 7F    AND #$7FFF
$86:8258 9D D7 1B    STA $1BD7,x[$7E:1BE5]
$86:825B 60          RTS
}


;;; $825C: Instruction - disable collision with Samus ;;;
{
$86:825C BD D7 1B    LDA $1BD7,x[$7E:1BE5]
$86:825F 09 00 20    ORA #$2000
$86:8262 9D D7 1B    STA $1BD7,x[$7E:1BE5]
$86:8265 60          RTS
}


;;; $8266: Unused. Instruction - enable collision with Samus ;;;
{
$86:8266 BD D7 1B    LDA $1BD7,x
$86:8269 29 FF DF    AND #$DFFF
$86:826C 9D D7 1B    STA $1BD7,x
$86:826F 60          RTS
}


;;; $8270: Unused. Instruction - set to not die on contact ;;;
{
$86:8270 BD D7 1B    LDA $1BD7,x
$86:8273 09 00 40    ORA #$4000
$86:8276 9D D7 1B    STA $1BD7,x
$86:8279 60          RTS
}


;;; $827A: Unused. Instruction - set to die on contact ;;;
{
$86:827A BD D7 1B    LDA $1BD7,x
$86:827D 29 FF BF    AND #$BFFF
$86:8280 9D D7 1B    STA $1BD7,x
$86:8283 60          RTS
}


;;; $8284: Instruction - set high priority ;;;
{
$86:8284 BD D7 1B    LDA $1BD7,x[$7E:1BE5]
$86:8287 09 00 10    ORA #$1000
$86:828A 9D D7 1B    STA $1BD7,x[$7E:1BE5]
$86:828D 60          RTS
}


;;; $828E: Unused. Instruction - set low priority ;;;
{
$86:828E BD D7 1B    LDA $1BD7,x
$86:8291 29 FF EF    AND #$EFFF
$86:8294 9D D7 1B    STA $1BD7,x
$86:8297 60          RTS
}


;;; $8298: Instruction - X radius = [[Y]], Y radius = [[Y] + 1] ;;;
{
$86:8298 B9 00 00    LDA $0000,y[$86:C434]
$86:829B 9D B3 1B    STA $1BB3,x[$7E:1BD1]
$86:829E C8          INY
$86:829F C8          INY
$86:82A0 60          RTS
}


;;; $82A1: Unused. Instruction - X radius = 0, Y radius = 0 ;;;
{
$86:82A1 9E B3 1B    STZ $1BB3,x
$86:82A4 60          RTS
}


;;; $82A5: Instruction - calculate direction towards Samus ;;;
{
; Used only by eye door projectile
$86:82A5 5A          PHY
$86:82A6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:82A9 38          SEC                    ;|
$86:82AA FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$86:82AD 85 12       STA $12    [$7E:0012]  ;|
$86:82AF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} A = (angle from enemy projectile to Samus)
$86:82B2 38          SEC                    ;|
$86:82B3 FD 93 1A    SBC $1A93,x[$7E:1AB5]  ;|
$86:82B6 85 14       STA $14    [$7E:0014]  ;|
$86:82B8 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$86:82BC 0A          ASL A                  ;\
$86:82BD AC 91 19    LDY $1991  [$7E:1991]  ;} Enemy projectile angle to Samus = [A] * 2 (angle * 2)
$86:82C0 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$86:82C3 AA          TAX                    ;\
$86:82C4 BF 43 B4 A0 LDA $A0B443,x[$A0:B5B3];} Enemy projectile X velocity = sin([A] * pi / 80h)
$86:82C8 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:82CB BF C3 B3 A0 LDA $A0B3C3,x[$A0:B533];\
$86:82CF 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = -cos([A] * pi / 80h)
$86:82D2 BB          TYX
$86:82D3 7A          PLY
$86:82D4 60          RTS
}


;;; $82D5: Unused. Instruction - write [[Y] + 4] colours from [[Y]] to colour index [[Y] + 2] ;;;
{
$86:82D5 5A          PHY
$86:82D6 DA          PHX
$86:82D7 BE 02 00    LDX $0002,y
$86:82DA B9 04 00    LDA $0004,y
$86:82DD 29 FF 00    AND #$00FF
$86:82E0 85 12       STA $12    [$7E:0012]
$86:82E2 B9 00 00    LDA $0000,y
$86:82E5 A8          TAY

$86:82E6 B9 00 00    LDA $0000,y
$86:82E9 9F 00 C0 7E STA $7EC000,x
$86:82ED C8          INY
$86:82EE C8          INY
$86:82EF E8          INX
$86:82F0 E8          INX
$86:82F1 C6 12       DEC $12    [$7E:0012]
$86:82F3 10 F1       BPL $F1    [$82E6]
$86:82F5 FA          PLX
$86:82F6 68          PLA
$86:82F7 18          CLC
$86:82F8 69 05 00    ADC #$0005
$86:82FB A8          TAY
$86:82FC 60          RTS
}


;;; $82FD: Unused. Instruction - queue music track [[Y]] ;;;
{
$86:82FD B9 00 00    LDA $0000,y
$86:8300 29 FF 00    AND #$00FF
$86:8303 22 C1 8F 80 JSL $808FC1[$80:8FC1]
$86:8307 C8          INY
$86:8308 60          RTS
}


;;; $8309: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 6 ;;;
{
$86:8309 B9 00 00    LDA $0000,y
$86:830C 22 49 90 80 JSL $809049[$80:9049]
$86:8310 C8          INY
$86:8311 60          RTS
}


;;; $8312: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6 ;;;
{
$86:8312 B9 00 00    LDA $0000,y[$86:A4C9]
$86:8315 22 CB 90 80 JSL $8090CB[$80:90CB]
$86:8319 C8          INY
$86:831A 60          RTS
}


;;; $831B: Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 6 ;;;
{
$86:831B B9 00 00    LDA $0000,y[$86:AB4D]
$86:831E 22 4D 91 80 JSL $80914D[$80:914D]
$86:8322 C8          INY
$86:8323 60          RTS
}


;;; $8324: Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 15 ;;;
{
$86:8324 B9 00 00    LDA $0000,y
$86:8327 22 21 90 80 JSL $809021[$80:9021]
$86:832B C8          INY
$86:832C 60          RTS
}


;;; $832D: Unused. Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 15 ;;;
{
$86:832D B9 00 00    LDA $0000,y
$86:8330 22 A3 90 80 JSL $8090A3[$80:90A3]
$86:8334 C8          INY
$86:8335 60          RTS
}


;;; $8336: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 15 ;;;
{
$86:8336 B9 00 00    LDA $0000,y
$86:8339 22 25 91 80 JSL $809125[$80:9125]
$86:833D C8          INY
$86:833E 60          RTS
}


;;; $833F: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 3 ;;;
{
$86:833F B9 00 00    LDA $0000,y
$86:8342 22 35 90 80 JSL $809035[$80:9035]
$86:8346 C8          INY
$86:8347 60          RTS
}


;;; $8348: Unused. Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 3 ;;;
{
$86:8348 B9 00 00    LDA $0000,y
$86:834B 22 B7 90 80 JSL $8090B7[$80:90B7]
$86:834F C8          INY
$86:8350 60          RTS
}


;;; $8351: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 3 ;;;
{
$86:8351 B9 00 00    LDA $0000,y
$86:8354 22 39 91 80 JSL $809139[$80:9139]
$86:8358 C8          INY
$86:8359 60          RTS
}


;;; $835A: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 9 ;;;
{
$86:835A B9 00 00    LDA $0000,y
$86:835D 22 2B 90 80 JSL $80902B[$80:902B]
$86:8361 C8          INY
$86:8362 60          RTS
}


;;; $8363: Unused. Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 9 ;;;
{
$86:8363 B9 00 00    LDA $0000,y
$86:8366 22 AD 90 80 JSL $8090AD[$80:90AD]
$86:836A C8          INY
$86:836B 60          RTS
}


;;; $836C: Unused. Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 9 ;;;
{
$86:836C B9 00 00    LDA $0000,y
$86:836F 22 2F 91 80 JSL $80912F[$80:912F]
$86:8373 C8          INY
$86:8374 60          RTS
}


;;; $8375: Unused. Instruction - queue sound [[Y]], sound library 1, max queued sounds allowed = 1 ;;;
{
$86:8375 B9 00 00    LDA $0000,y
$86:8378 22 3F 90 80 JSL $80903F[$80:903F]
$86:837C C8          INY
$86:837D 60          RTS
}


;;; $837E: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 1 ;;;
{
$86:837E B9 00 00    LDA $0000,y[$86:A4AC]
$86:8381 22 C1 90 80 JSL $8090C1[$80:90C1]
$86:8385 C8          INY
$86:8386 60          RTS
}


;;; $8387: Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 1 ;;;
{
$86:8387 B9 00 00    LDA $0000,y
$86:838A 22 43 91 80 JSL $809143[$80:9143]
$86:838E C8          INY
$86:838F 60          RTS
}
}


;;; $8390: Draw high priority enemy projectiles ;;;
{
$86:8390 8B          PHB
$86:8391 F4 00 8D    PEA $8D00              ;\
$86:8394 AB          PLB                    ;} DB = $8D
$86:8395 AB          PLB                    ;/
$86:8396 20 27 84    JSR $8427  [$86:8427]  ; Get values for screen shaking
$86:8399 A2 22 00    LDX #$0022             ; X = 22h (enemy projectile index)

; LOOP
$86:839C BD 97 19    LDA $1997,x[$7E:19B9]  ;\
$86:839F F0 0B       BEQ $0B    [$83AC]     ;} If [enemy projectile ID] != 0:
$86:83A1 BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$86:83A4 29 00 10    AND #$1000             ;} If enemy projectile is high priority:
$86:83A7 F0 03       BEQ $03    [$83AC]     ;/
$86:83A9 20 D6 83    JSR $83D6  [$86:83D6]  ; Draw enemy projectile

$86:83AC CA          DEX                    ;\
$86:83AD CA          DEX                    ;} X -= 2
$86:83AE 10 EC       BPL $EC    [$839C]     ; If [X] >= 0: go to LOOP
$86:83B0 AB          PLB
$86:83B1 6B          RTL
}


;;; $83B2: Draw low priority enemy projectiles ;;;
{
$86:83B2 8B          PHB
$86:83B3 C2 30       REP #$30
$86:83B5 F4 00 8D    PEA $8D00              ;\
$86:83B8 AB          PLB                    ;} DB = $8D
$86:83B9 AB          PLB                    ;/
$86:83BA 20 27 84    JSR $8427  [$86:8427]  ; Get values for screen shaking
$86:83BD A2 22 00    LDX #$0022             ; X = 22h (enemy projectile index)

; LOOP
$86:83C0 BD 97 19    LDA $1997,x[$7E:19B9]  ;\
$86:83C3 F0 0B       BEQ $0B    [$83D0]     ;} If [enemy projectile ID] != 0:
$86:83C5 BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$86:83C8 29 00 10    AND #$1000             ;} If enemy projectile is not high priority:
$86:83CB D0 03       BNE $03    [$83D0]     ;/
$86:83CD 20 D6 83    JSR $83D6  [$86:83D6]  ; Draw enemy projectile

$86:83D0 CA          DEX                    ;\
$86:83D1 CA          DEX                    ;} X -= 2
$86:83D2 10 EC       BPL $EC    [$83C0]     ; If [X] >= 0: go to LOOP
$86:83D4 AB          PLB
$86:83D5 6B          RTL
}


;;; $83D6: Draw enemy projectile ;;;
{
;; Parameters:
;;     X: Enemy projectile index
;;     $22: Y displacement
;;     $24: X displacement
$86:83D6 BC 6B 1B    LDY $1B6B,x[$7E:1B8D]  ; Y = [enemy projectile spritemap pointer]
$86:83D9 BD BB 19    LDA $19BB,x[$7E:19DD]  ;\
$86:83DC 29 FF 00    AND #$00FF             ;} $1A = [enemy projectile VRAM tiles index]
$86:83DF 85 1A       STA $1A    [$7E:001A]  ;/
$86:83E1 BD BB 19    LDA $19BB,x[$7E:19DD]  ;\
$86:83E4 29 00 FF    AND #$FF00             ;} $1C = [enemy projectile palette index]
$86:83E7 85 1C       STA $1C    [$7E:001C]  ;/
$86:83E9 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:83EC 38          SEC                    ;|
$86:83ED ED 11 09    SBC $0911  [$7E:0911]  ;|
$86:83F0 18          CLC                    ;} $14 = [enemy projectile X position] - [layer 1 X position] + [$24]
$86:83F1 65 24       ADC $24    [$7E:0024]  ;|
$86:83F3 85 14       STA $14    [$7E:0014]  ;/
$86:83F5 18          CLC                    ;\
$86:83F6 69 80 00    ADC #$0080             ;|
$86:83F9 89 00 FE    BIT #$FE00             ;} If not -80h <= [$14] < 180h: return
$86:83FC D0 28       BNE $28    [$8426]     ;/
$86:83FE BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:8401 38          SEC                    ;|
$86:8402 ED 15 09    SBC $0915  [$7E:0915]  ;|
$86:8405 18          CLC                    ;} $12 = [enemy projectile Y position] - [layer 1 Y position] + [$22]
$86:8406 65 22       ADC $22    [$7E:0022]  ;|
$86:8408 85 12       STA $12    [$7E:0012]  ;/
$86:840A 89 00 FF    BIT #$FF00             ;\
$86:840D D0 08       BNE $08    [$8417]     ;} If 0 <= [$14] < 100h:
$86:840F DA          PHX                    ;\
$86:8410 22 0A 8C 81 JSL $818C0A[$81:8C0A]  ;} Add spritemap to OAM with base tile number
$86:8414 FA          PLX                    ;/
$86:8415 80 0F       BRA $0F    [$8426]

$86:8417 18          CLC                    ;\ Else (not 0 <= [$14] < 100h):
$86:8418 69 80 00    ADC #$0080             ;|
$86:841B 89 00 FE    BIT #$FE00             ;} If -80h <= [$14] < 180h:
$86:841E D0 06       BNE $06    [$8426]     ;/
$86:8420 DA          PHX                    ;\
$86:8421 22 7F 8C 81 JSL $818C7F[$81:8C7F]  ;} Add spritemap to OAM with base tile number offscreen
$86:8425 FA          PLX                    ;/

$86:8426 60          RTS
}


;;; $8427: Get values for screen shaking ;;;
{
;; Returns:
;;     $22: Y displacement
;;     $24: X displacement
$86:8427 AD 40 18    LDA $1840  [$7E:1840]  ;\
$86:842A F0 3A       BEQ $3A    [$8466]     ;} If [earthquake timer] = 0: return zeros
$86:842C AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$86:842F D0 35       BNE $35    [$8466]     ;} If time is frozen: return zeros
$86:8431 AD 3E 18    LDA $183E  [$7E:183E]  ;\
$86:8434 C9 24 00    CMP #$0024             ;} If [earthquake type] >= 24h: return
$86:8437 10 2D       BPL $2D    [$8466]     ;/
$86:8439 0A          ASL A                  ;\
$86:843A 0A          ASL A                  ;} X = [earthquake type] * 4
$86:843B AA          TAX                    ;/
$86:843C AD 40 18    LDA $1840  [$7E:1840]  ;\
$86:843F 89 02 00    BIT #$0002             ;} If [earthquake timer] / 2 % 2 != 0:
$86:8442 F0 15       BEQ $15    [$8459]     ;/
$86:8444 BF 6B 84 86 LDA $86846B,x[$86:84F7];\
$86:8448 49 FF FF    EOR #$FFFF             ;|
$86:844B 1A          INC A                  ;} $24 = -[$86:846B + [earthquake type] * 4]
$86:844C 85 24       STA $24    [$7E:0024]  ;/
$86:844E BF 6D 84 86 LDA $86846D,x[$86:84F9];\
$86:8452 49 FF FF    EOR #$FFFF             ;|
$86:8455 1A          INC A                  ;} $22 = -[$86:846B + [earthquake type] * 4 + 2]
$86:8456 85 22       STA $22    [$7E:0022]  ;/
$86:8458 60          RTS                    ; Return

$86:8459 BF 6B 84 86 LDA $86846B,x[$86:84F7];\
$86:845D 85 24       STA $24    [$7E:0024]  ;} $24 = [$86:846B + [earthquake type] * 4]
$86:845F BF 6D 84 86 LDA $86846D,x[$86:84F9];\
$86:8463 85 22       STA $22    [$7E:0022]  ;} $22 = [$86:846B + [earthquake type] * 4 + 2]
$86:8465 60          RTS                    ; Return

$86:8466 64 22       STZ $22    [$7E:0022]
$86:8468 64 24       STZ $24    [$7E:0024]
$86:846A 60          RTS

; [X displacement], [Y displacement]

;                        ______________________________ Horizontal shaking
;                       |           ___________________ Vertical shaking
;                       |          |           ________ Diagonal shaking
;                       |          |          |
$86:846B             dw 0000,0000, 0000,0000, 0000,0000, ;\
                        0000,0000, 0000,0000, 0000,0000, ;} BG1 only
                        0000,0000, 0000,0000, 0000,0000, ;/
                        0000,0000, 0000,0000, 0000,0000, ;\
                        0000,0000, 0000,0000, 0000,0000, ;} BG1 and BG2
                        0000,0000, 0000,0000, 0000,0000, ;/
                        0001,0000, 0000,0001, 0001,0001, ;\
                        0002,0000, 0000,0002, 0002,0002, ;} BG1, BG2 and enemies
                        0003,0000, 0000,0003, 0003,0003, ;/
                        0001,0000, 0000,0001, 0001,0001, ;\
                        0002,0000, 0000,0002, 0002,0002, ;} BG2 only and enemies
                        0003,0000, 0000,0003, 0003,0003  ;/
}


;;; $84FB: RTS ;;;
{
$86:84FB 60          RTS
}


;;; $84FC: Instruction list - delete ;;;
{
$86:84FC             dw 8154
}


;;; $84FE: Unused. Instruction list - blank spritemap ;;;
{
$86:84FE             dx 1000,8000,
                        81AB,84FE   ; Go to $84FE
}


;;; $8506..8A38: Enemy projectile block collision detection ;;;
{
;;; $8506: Enemy projectile block collision - horizontal extension ;;;
{
; Adjusting the return address and modifying the jump index is a pretty neat trick,
; like a sort of indirect tail recursion
$86:8506 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$86:8509 BF 02 64 7F LDA $7F6402,x[$7F:6A69];|
$86:850D 29 FF 00    AND #$00FF             ;} If [current block BTS] = 0: return carry clear
$86:8510 F0 28       BEQ $28    [$853A]     ;/
$86:8512 89 80 00    BIT #$0080             ;\
$86:8515 D0 05       BNE $05    [$851C]     ;|
$86:8517 29 FF 00    AND #$00FF             ;|
$86:851A 80 03       BRA $03    [$851F]     ;|
                                            ;|
$86:851C 09 00 FF    ORA #$FF00             ;} Current block index += ±[current block BTS]
                                            ;|
$86:851F 18          CLC                    ;|
$86:8520 6D C4 0D    ADC $0DC4  [$7E:0DC4]  ;|
$86:8523 8D C4 0D    STA $0DC4  [$7E:0DC4]  ;/
$86:8526 0A          ASL A                  ;\
$86:8527 AA          TAX                    ;|
$86:8528 BF 02 00 7F LDA $7F0002,x[$7F:0CCE];|
$86:852C 29 00 F0    AND #$F000             ;|
$86:852F EB          XBA                    ;} X = [current block type] * 2 (index for JSR on return)
$86:8530 4A          LSR A                  ;|
$86:8531 4A          LSR A                  ;|
$86:8532 4A          LSR A                  ;|
$86:8533 AA          TAX                    ;/
$86:8534 68          PLA                    ;\
$86:8535 38          SEC                    ;|
$86:8536 E9 03 00    SBC #$0003             ;} (Return address) -= 3
$86:8539 48          PHA                    ;/

$86:853A 18          CLC
$86:853B 60          RTS
}


;;; $853C: Enemy projectile block collision - vertical extension ;;;
{
$86:853C AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$86:853F BF 02 64 7F LDA $7F6402,x[$7F:6493];|
$86:8543 29 FF 00    AND #$00FF             ;} If [current block BTS] = 0: return carry clear
$86:8546 F0 40       BEQ $40    [$8588]     ;/
$86:8548 89 80 00    BIT #$0080             ;\
$86:854B D0 12       BNE $12    [$855F]     ;} If [current block BTS] & 80h != 0: go BRANCH_NEGATIVE
$86:854D 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;\
$86:8550 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;|
                                            ;|
$86:8553 18          CLC                    ;} Current block += [current block BTS] * [room width]
$86:8554 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$86:8557 CE D4 0D    DEC $0DD4  [$7E:0DD4]  ;|
$86:855A D0 F7       BNE $F7    [$8553]     ;/
$86:855C 4C 71 85    JMP $8571  [$86:8571]  ; Go to BRANCH_MERGE

; BRANCH_NEGATIVE
$86:855F 09 00 FF    ORA #$FF00             ;\
$86:8562 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;|
$86:8565 AD C4 0D    LDA $0DC4  [$7E:0DC4]  ;|
                                            ;|
$86:8568 38          SEC                    ;} Current block -= [current block BTS] * [room width]
$86:8569 ED A5 07    SBC $07A5  [$7E:07A5]  ;|
$86:856C EE D4 0D    INC $0DD4  [$7E:0DD4]  ;|
$86:856F D0 F7       BNE $F7    [$8568]     ;/

; BRANCH_MERGE
$86:8571 8D C4 0D    STA $0DC4  [$7E:0DC4]
$86:8574 0A          ASL A                  ;\
$86:8575 AA          TAX                    ;|
$86:8576 BF 02 00 7F LDA $7F0002,x[$7F:00C4];|
$86:857A 29 00 F0    AND #$F000             ;|
$86:857D EB          XBA                    ;} X = [current block type] * 2 (index for JSR on return)
$86:857E 4A          LSR A                  ;|
$86:857F 4A          LSR A                  ;|
$86:8580 4A          LSR A                  ;|
$86:8581 AA          TAX                    ;/
$86:8582 68          PLA                    ;\
$86:8583 38          SEC                    ;|
$86:8584 E9 03 00    SBC #$0003             ;} (Return address) -= 3
$86:8587 48          PHA                    ;/

$86:8588 18          CLC
$86:8589 60          RTS
}


;;; $858A: Clear carry ;;;
{
$86:858A 18          CLC
$86:858B 60          RTS
}


;;; $858C: Set carry ;;;
{
$86:858C 38          SEC
$86:858D 60          RTS
}


;;; $858E: Enemy projectile block collision - horizontal - slope ;;;
{
;; Parameters:
;;     $14: Enemy projectile X velocity (used only for sign)
;;     $1A: Number of blocks left to check
;;     $1C: Enemy projectile X radius
;;     $1E: Enemy projectile Y radius
;;     $20: Enemy projectile Y span - 1
;;     $22: Target front boundary (left/right depending on sign of enemy projectile velocity)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:858E AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$86:8591 BF 02 64 7F LDA $7F6402,x[$7F:671F];|
$86:8595 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5:
$86:8598 C9 05 00    CMP #$0005             ;|
$86:859B B0 03       BCS $03    [$85A0]     ;/
$86:859D 4C C2 85    JMP $85C2  [$86:85C2]  ; Go to enemy projectile block collision reaction - horizontal - slope - square

$86:85A0 BF 02 64 7F LDA $7F6402,x[$7F:671F];\
$86:85A4 29 FF 00    AND #$00FF             ;} Current slope BTS = [block BTS]
$86:85A7 8D 77 1E    STA $1E77  [$7E:1E77]  ;/
$86:85AA 4C 3D 87    JMP $873D  [$86:873D]  ; Go to enemy projectile block collision reaction - horizontal - slope - non-square
}


;;; $85AD: Enemy projectile block collision - vertical - slope ;;;
{
;; Parameters:
;;     $14: Enemy projectile Y velocity (used only for sign)
;;     $18: Target Y position
;;     $1A: Number of blocks left to check
;;     $1C: Enemy projectile X radius
;;     $1E: Enemy projectile Y radius
;;     $20: Enemy projectile X span - 1
;;     $22: Target boundary (top/bottom depending on sign of enemy projectile velocity)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:85AD AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$86:85B0 BF 02 64 7F LDA $7F6402,x[$7F:659B];|
$86:85B4 29 1F 00    AND #$001F             ;} If [block BTS] & 1Fh < 5:
$86:85B7 C9 05 00    CMP #$0005             ;|
$86:85BA B0 03       BCS $03    [$85BF]     ;/
$86:85BC 4C 76 86    JMP $8676  [$86:8676]  ; Go to enemy projectile block collision reaction - vertical - slope - square

$86:85BF 4C 4E 87    JMP $874E  [$86:874E]  ; Go to enemy projectile block collision reaction - vertical - slope - non-square
}


;;; $85C2: Enemy projectile block collision reaction - horizontal - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $14: Enemy projectile X velocity (used only for sign)
;;     $1A: Number of blocks left to check
;;     $1C: Enemy projectile X radius
;;     $1E: Enemy projectile Y radius
;;     $20: Enemy projectile Y span - 1
;;     $22: Target front boundary (left/right depending on sign of enemy projectile velocity)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:85C2 0A          ASL A                  ;\
$86:85C3 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$86:85C4 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$86:85C7 BF 01 64 7F LDA $7F6401,x[$7F:65CD];\
$86:85CB 2A          ROL A                  ;|
$86:85CC 2A          ROL A                  ;|
$86:85CD 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$86:85CE 29 03 00    AND #$0003             ;|
$86:85D1 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$86:85D4 A5 22       LDA $22    [$7E:0022]  ;\
$86:85D6 29 08 00    AND #$0008             ;} A = [$22] & 8 (is enemy projectile target boundary in right half of block)
$86:85D9 4A          LSR A                  ;\
$86:85DA 4A          LSR A                  ;|
$86:85DB 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 3 (toggle X flip flag if enemy projectile is in right half of block)
$86:85DC 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$86:85DF 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$86:85E2 AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$86:85E3 AC 91 19    LDY $1991  [$7E:1991]  ; Y = [enemy projectile index]
$86:85E6 A5 20       LDA $20    [$7E:0020]  ;\
$86:85E8 D0 2D       BNE $2D    [$8617]     ;} If [$20] != 0 (enemy projectile spans more than one block): go to BRANCH_MULTI_BLOCK
$86:85EA B9 93 1A    LDA $1A93,y[$7E:1AB5]  ;\
$86:85ED 38          SEC                    ;|
$86:85EE E5 1E       SBC $1E    [$7E:001E]  ;} If (enemy projectile top boundary) & 8 = 0 (enemy projectile top boundary is in top half of block):
$86:85F0 29 08 00    AND #$0008             ;|
$86:85F3 D0 06       BNE $06    [$85FB]     ;/
$86:85F5 BF 28 87 86 LDA $868728,x[$86:8736];\
$86:85F9 30 19       BMI $19    [$8614]     ;} If [$8729 + [X]] & 80h != 0 (top half is solid): go to BRANCH_COLLISION

$86:85FB 8A          TXA                    ;\
$86:85FC 49 02 00    EOR #$0002             ;} X ^= 2 (toggle Y flip flag)
$86:85FF AA          TAX                    ;/
$86:8600 B9 93 1A    LDA $1A93,y            ;\
$86:8603 18          CLC                    ;|
$86:8604 65 1E       ADC $1E    [$7E:001E]  ;|
$86:8606 3A          DEC A                  ;} If (enemy projectile bottom boundary) & 8 != 0 (enemy projectile bottom boundary is in bottom half of block):
$86:8607 29 08 00    AND #$0008             ;|
$86:860A F0 06       BEQ $06    [$8612]     ;/
$86:860C BF 28 87 86 LDA $868728,x          ;\
$86:8610 30 02       BMI $02    [$8614]     ;} If [$8729 + [X]] & 80h != 0 (bottom half is solid): go to BRANCH_COLLISION

$86:8612 18          CLC                    ;\
$86:8613 60          RTS                    ;} Return carry clear

$86:8614 4C 54 86    JMP $8654  [$86:8654]

; BRANCH_MULTI_BLOCK
$86:8617 A5 1A       LDA $1A    [$7E:001A]  ;\
$86:8619 D0 14       BNE $14    [$862F]     ;} If [$1A] = 0 (bottom block check):
$86:861B B9 93 1A    LDA $1A93,y            ;\
$86:861E 18          CLC                    ;|
$86:861F 65 1E       ADC $1E    [$7E:001E]  ;|
$86:8621 3A          DEC A                  ;} If (enemy projectile bottom boundary) & 8 != 0 (enemy projectile bottom boundary is in bottom half of block): go to BRANCH_CHECK_BOTH_HALVES
$86:8622 29 08 00    AND #$0008             ;|
$86:8625 D0 17       BNE $17    [$863E]     ;/
$86:8627 BF 28 87 86 LDA $868728,x          ;\
$86:862B 30 24       BMI $24    [$8651]     ;} If [$8729 + [X]] & 80h != 0 (top half is solid): go to BRANCH_COLLISION
$86:862D 80 20       BRA $20    [$864F]     ; Return carry clear

$86:862F C5 20       CMP $20    [$7E:0020]  ;\
$86:8631 D0 0B       BNE $0B    [$863E]     ;} If [$1A] = [$20] (top block check):
$86:8633 B9 93 1A    LDA $1A93,y[$7E:1AB5]  ;\
$86:8636 38          SEC                    ;|
$86:8637 E5 1E       SBC $1E    [$7E:001E]  ;} If enemy projectile top boundary is in bottom half: go to BRANCH_CHECK_BOTTOM_HALF
$86:8639 29 08 00    AND #$0008             ;|
$86:863C D0 06       BNE $06    [$8644]     ;/

; BRANCH_CHECK_BOTH_HALVES
$86:863E BF 28 87 86 LDA $868728,x          ;\
$86:8642 30 0D       BMI $0D    [$8651]     ;} If [$8729 + [X]] & 80h != 0 (top half is solid): go to BRANCH_COLLISION

; BRANCH_CHECK_BOTTOM_HALF
$86:8644 8A          TXA                    ;\
$86:8645 49 02 00    EOR #$0002             ;|
$86:8648 AA          TAX                    ;} If [$8729 + ([X] ^ 2)] & 80h != 0 (bottom half is solid): go to BRANCH_COLLISION
$86:8649 BF 28 87 86 LDA $868728,x[$86:8734];|
$86:864D 30 02       BMI $02    [$8651]     ;/

$86:864F 18          CLC                    ;\
$86:8650 60          RTS                    ;} Return carry clear

$86:8651 4C 54 86    JMP $8654  [$86:8654]

; BRANCH_COLLISION
$86:8654 AE 91 19    LDX $1991  [$7E:1991]  ; X = [enemy projectile index]
$86:8657 9E 27 1A    STZ $1A27,x[$7E:1A49]  ; Enemy projectile X subposition = 0
$86:865A A5 22       LDA $22    [$7E:0022]
$86:865C 24 14       BIT $14    [$7E:0014]  ;\
$86:865E 30 0B       BMI $0B    [$866B]     ;} If (enemy projectile X velocity) >= 0:
$86:8660 29 F8 FF    AND #$FFF8             ; A = [$22] - [$22] % 8 (target right boundary rounded down to left of 8x8 tile)
$86:8663 38          SEC                    ;\
$86:8664 E5 1C       SBC $1C    [$7E:001C]  ;} Enemy projectile X position = [A] - (enemy projectile X radius)
$86:8666 9D 4B 1A    STA $1A4B,x            ;/
$86:8669 38          SEC                    ;\
$86:866A 60          RTS                    ;} Return carry set

$86:866B 09 07 00    ORA #$0007             ;\
$86:866E 38          SEC                    ;} A = [$22] - [$22] % 8 + 8 (target left boundary rounded up to right of 8x8 tile)
$86:866F 65 1C       ADC $1C    [$7E:001C]  ;\
$86:8671 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [A] + (enemy projectile X radius)
$86:8674 38          SEC                    ;\
$86:8675 60          RTS                    ;} Return carry set
}


;;; $8676: Enemy projectile block collision reaction - vertical - slope - square ;;;
{
;; Parameters:
;;     A: [Block BTS] & 1Fh
;;     X: Block index
;;     $14: Enemy projectile Y velocity (used only for sign)
;;     $1A: Number of blocks left to check
;;     $1C: Enemy projectile X radius
;;     $1E: Enemy projectile Y radius
;;     $20: Enemy projectile X span - 1
;;     $22: Target boundary (top/bottom depending on sign of enemy projectile velocity)
;; Returns:
;;     Carry: Set if collision, clear otherwise

; BUG: The single block branch ($869A) doesn't load the enemy projectile index into Y,
;      so it loads garbage for the enemy projectile X position
;      Result is the enemy projectile might erroneously consider the slope to be X flipped
;      (which only affects the quarter and three-quarter slopes)

$86:8676 0A          ASL A                  ;\
$86:8677 0A          ASL A                  ;} $0DD4 = ([block BTS] & 1Fh) * 4 (solid slope definition table base index)
$86:8678 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$86:867B BF 01 64 7F LDA $7F6401,x[$7F:6435];\
$86:867F 2A          ROL A                  ;|
$86:8680 2A          ROL A                  ;|
$86:8681 2A          ROL A                  ;} $0DD6 = [block BTS] >> 6 & 3 (slope flip flags)
$86:8682 29 03 00    AND #$0003             ;|
$86:8685 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$86:8688 A5 22       LDA $22    [$7E:0022]  ;\
$86:868A 29 08 00    AND #$0008             ;} A = [$22] & 8 (is enemy projectile target boundary in bottom half of block)
$86:868D 4A          LSR A                  ;\
$86:868E 4A          LSR A                  ;} A = [$0DD6] ^ [A] >> 2 (toggle Y flip flag if enemy projectile is in bottom half of block)
$86:868F 4D D6 0D    EOR $0DD6  [$7E:0DD6]  ;/
$86:8692 6D D4 0D    ADC $0DD4  [$7E:0DD4]  ;\
$86:8695 AA          TAX                    ;} X = [$0DD4] + [A] (solid slope definition table index)
$86:8696 A5 20       LDA $20    [$7E:0020]  ;\
$86:8698 D0 2D       BNE $2D    [$86C7]     ;} If [$20] != 0 (enemy projectile spans more than one block): go to BRANCH_MULTI_BLOCK
$86:869A B9 4B 1A    LDA $1A4B,y[$86:B053]  ;\
$86:869D 38          SEC                    ;|
$86:869E E5 1C       SBC $1C    [$7E:001C]  ;} If (enemy projectile left boundary) & 8 = 0 (enemy projectile left boundary is in left half of block):
$86:86A0 29 08 00    AND #$0008             ;|
$86:86A3 D0 06       BNE $06    [$86AB]     ;/
$86:86A5 BF 28 87 86 LDA $868728,x[$86:8728];\
$86:86A9 30 19       BMI $19    [$86C4]     ;} If [$8729 + [X]] & 80h != 0 (left half is solid): go to BRANCH_COLLISION

$86:86AB 8A          TXA                    ;\
$86:86AC 49 01 00    EOR #$0001             ;} X ^= 1 (toggle X flip flag)
$86:86AF AA          TAX                    ;/
$86:86B0 B9 4B 1A    LDA $1A4B,y[$86:B053]  ;\
$86:86B3 18          CLC                    ;|
$86:86B4 65 1C       ADC $1C    [$7E:001C]  ;|
$86:86B6 3A          DEC A                  ;} If (enemy projectile right boundary) & 8 != 0 (enemy projectile right boundary is in right half of block):
$86:86B7 29 08 00    AND #$0008             ;|
$86:86BA F0 06       BEQ $06    [$86C2]     ;/
$86:86BC BF 28 87 86 LDA $868728,x[$86:8729];\
$86:86C0 30 02       BMI $02    [$86C4]     ;} If [$8729 + [X]] & 80h != 0 (right half is solid): go to BRANCH_COLLISION

$86:86C2 18          CLC                    ;\
$86:86C3 60          RTS                    ;} Return carry clear

$86:86C4 4C 07 87    JMP $8707  [$86:8707]

; BRANCH_MULTI_BLOCK
$86:86C7 AC 91 19    LDY $1991  [$7E:1991]  ; Y = [enemy projectile index]
$86:86CA A5 1A       LDA $1A    [$7E:001A]  ;\
$86:86CC D0 14       BNE $14    [$86E2]     ;} If [$1A] = 0 (rightmost block check):
$86:86CE B9 4B 1A    LDA $1A4B,y[$7E:1A6D]  ;\
$86:86D1 18          CLC                    ;|
$86:86D2 65 1C       ADC $1C    [$7E:001C]  ;|
$86:86D4 3A          DEC A                  ;} If (enemy projectile right boundary) & 8 != 0 (enemy projectile right boundary is in right half of block): go to BRANCH_CHECK_BOTH_HALVES
$86:86D5 29 08 00    AND #$0008             ;|
$86:86D8 D0 17       BNE $17    [$86F1]     ;/
$86:86DA BF 28 87 86 LDA $868728,x[$86:872C];\
$86:86DE 30 24       BMI $24    [$8704]     ;} If [$8729 + [X]] & 80h != 0 (left half is solid): go to BRANCH_COLLISION
$86:86E0 80 20       BRA $20    [$8702]     ; Return carry clear

$86:86E2 C5 20       CMP $20    [$7E:0020]  ;\
$86:86E4 D0 0B       BNE $0B    [$86F1]     ;} If [$1A] = [$20] (leftmost block check):
$86:86E6 B9 4B 1A    LDA $1A4B,y[$7E:1A6D]  ;\
$86:86E9 38          SEC                    ;|
$86:86EA E5 1C       SBC $1C    [$7E:001C]  ;} If enemy projectile left boundary is in left half: go to BRANCH_CHECK_LEFT_HALF
$86:86EC 29 08 00    AND #$0008             ;|
$86:86EF D0 06       BNE $06    [$86F7]     ;/

; BRANCH_CHECK_BOTH_HALVES
$86:86F1 BF 28 87 86 LDA $868728,x[$86:8728];\
$86:86F5 30 0D       BMI $0D    [$8704]     ;} If [$8729 + [X]] & 80h != 0 (left half is solid): go to BRANCH_COLLISION

; BRANCH_CHECK_LEFT_HALF
$86:86F7 8A          TXA                    ;\
$86:86F8 49 01 00    EOR #$0001             ;|
$86:86FB AA          TAX                    ;} If [$8729 + ([X] ^ 1)] & 80h != 0 (right half is solid): go to BRANCH_COLLISION
$86:86FC BF 28 87 86 LDA $868728,x[$86:872E];|
$86:8700 30 02       BMI $02    [$8704]     ;/

$86:8702 18          CLC                    ;\
$86:8703 60          RTS                    ;} Return carry clear

$86:8704 4C 07 87    JMP $8707  [$86:8707]

; BRANCH_COLLISION
$86:8707 AE 91 19    LDX $1991  [$7E:1991]  ; X = [enemy projectile index]
$86:870A 9E 6F 1A    STZ $1A6F,x            ; Enemy projectile Y subposition = 0
$86:870D A5 22       LDA $22    [$7E:0022]
$86:870F 24 14       BIT $14    [$7E:0014]  ;\
$86:8711 30 0B       BMI $0B    [$871E]     ;} If (enemy projectile Y velocity) >= 0:
$86:8713 29 F8 FF    AND #$FFF8             ; A = [$22] - [$22] % 8 (target bottom boundary rounded down to top of 8x8 tile)
$86:8716 38          SEC                    ;\
$86:8717 E5 1E       SBC $1E    [$7E:001E]  ;} Enemy projectile Y position = [A] - (enemy projectile Y radius)
$86:8719 9D 93 1A    STA $1A93,x            ;/
$86:871C 38          SEC                    ;\
$86:871D 60          RTS                    ;} Return carry set

$86:871E 09 07 00    ORA #$0007             ;\
$86:8721 38          SEC                    ;} A = [$22] - [$22] % 8 + 8 (target top boundary rounded up to bottom of 8x8 tile)
$86:8722 65 1E       ADC $1E    [$7E:001E]  ;\
$86:8724 9D 93 1A    STA $1A93,x            ;} Enemy projectile Y position = [A] + (enemy projectile Y radius)
$86:8727 38          SEC                    ;\
$86:8728 60          RTS                    ;} Return carry set
}


;;; $8729: Square slope definitions ;;;
{
; Copy of $94:8E54 for enemy projectiles
; 7Fh- = air, 80h+ = solid

;                        __________ Top-left
;                       |   _______ Top-right
;                       |  |   ____ Bottom-left
;                       |  |  |   _ Bottom-right
;                       |  |  |  |
$86:8729             db 00,01,82,83, ; 0: Half height
                        00,81,02,83, ; 1: Half width
                        00,01,02,83, ; 2: Quarter
                        00,81,82,83, ; 3: Three-quarters
                        80,81,82,83  ; 4: Whole
}


;;; $873D: Clear carry. Enemy projectile block collision reaction - horizontal - slope - non-square ;;;
{
$86:873D AD 77 1E    LDA $1E77  [$7E:1E77]
$86:8740 29 1F 00    AND #$001F
$86:8743 0A          ASL A
$86:8744 0A          ASL A
$86:8745 AA          TAX
$86:8746 A5 14       LDA $14    [$7E:0014]
$86:8748 10 02       BPL $02    [$874C]
$86:874A 18          CLC
$86:874B 60          RTS

$86:874C 18          CLC
$86:874D 60          RTS
}


;;; $874E: Enemy projectile block collision reaction - vertical - slope - non-square ;;;
{
;; Parameters:
;;     $14: Enemy projectile Y velocity (used only for sign)
;;     $18: Target Y position
;;     $1E: Enemy projectile Y radius
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:874E AC 91 19    LDY $1991  [$7E:1991]  ; Y = [enemy projectile index]
$86:8751 A5 14       LDA $14    [$7E:0014]  ;\
$86:8753 10 03       BPL $03    [$8758]     ;} If (enemy projectile Y velocity) < 0:
$86:8755 4C CC 87    JMP $87CC  [$86:87CC]  ; Go to BRANCH_UP

$86:8758 AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$86:875B 8E 04 42    STX $4204  [$7E:4204]  ;|
$86:875E E2 20       SEP #$20               ;|
$86:8760 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$86:8763 8D 06 42    STA $4206  [$7E:4206]  ;|
$86:8766 C2 20       REP #$20               ;|
$86:8768 B9 4B 1A    LDA $1A4B,y[$7E:1A6B]  ;} If [current block index] % [room width in blocks] != [enemy projectile X position] / 10h (enemy projectile centre isn't in block):
$86:876B 4A          LSR A                  ;|
$86:876C 4A          LSR A                  ;|
$86:876D 4A          LSR A                  ;|
$86:876E 4A          LSR A                  ;|
$86:876F CD 16 42    CMP $4216  [$7E:4216]  ;|
$86:8772 F0 02       BEQ $02    [$8776]     ;/
$86:8774 18          CLC                    ;\
$86:8775 60          RTS                    ;} Return carry clear

$86:8776 A5 18       LDA $18    [$7E:0018]  ;\
$86:8778 18          CLC                    ;|
$86:8779 65 1E       ADC $1E    [$7E:001E]  ;|
$86:877B 3A          DEC A                  ;} $0DD4 = (enemy projectile target bottom boundary) % 10h
$86:877C 29 0F 00    AND #$000F             ;|
$86:877F 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$86:8782 BF 02 64 7F LDA $7F6402,x[$7F:659B];\
$86:8786 29 1F 00    AND #$001F             ;|
$86:8789 0A          ASL A                  ;|
$86:878A 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$86:878B 0A          ASL A                  ;|
$86:878C 0A          ASL A                  ;|
$86:878D 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$86:8790 BF 01 64 7F LDA $7F6401,x[$7F:659A];\
$86:8794 30 34       BMI $34    [$87CA]     ;} If [block BTS] & 80h = 0: return carry clear
$86:8796 0A          ASL A                  ;\
$86:8797 30 05       BMI $05    [$879E]     ;} If [block BTS] & 40h = 0:
$86:8799 B9 4B 1A    LDA $1A4B,y[$7E:1A6B]  ; A = [enemy projectile X position] % 10h
$86:879C 80 06       BRA $06    [$87A4]

$86:879E B9 4B 1A    LDA $1A4B,y[$7E:1A63]  ;\ Else ([block BTS] & 40h != 0):
$86:87A1 49 0F 00    EOR #$000F             ;} A = Fh - [enemy projectile X position] % 10h

$86:87A4 29 0F 00    AND #$000F
$86:87A7 18          CLC                    ;\
$86:87A8 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$86:87AB AA          TAX                    ;} A = [$94:8B2B + [$0DD6] + [A]] (slope top Y offset)
$86:87AC BF 2B 8B 94 LDA $948B2B,x[$94:8C6B];/
$86:87B0 29 1F 00    AND #$001F
$86:87B3 38          SEC                    ;\
$86:87B4 ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$86:87B7 3A          DEC A                  ;/
$86:87B8 F0 02       BEQ $02    [$87BC]     ;\
$86:87BA 10 0E       BPL $0E    [$87CA]     ;} If [A] > 0: return carry clear

$86:87BC 18          CLC                    ;\
$86:87BD 65 18       ADC $18    [$7E:0018]  ;} Enemy projectile Y position = (target Y position) + [A]
$86:87BF 99 93 1A    STA $1A93,y[$7E:1AAB]  ;/
$86:87C2 A9 FF FF    LDA #$FFFF             ;\
$86:87C5 99 6F 1A    STA $1A6F,y[$7E:1A87]  ;} Enemy projectile Y subposition = FFFFh
$86:87C8 38          SEC                    ;\
$86:87C9 60          RTS                    ;} Return carry set

$86:87CA 18          CLC
$86:87CB 60          RTS

; BRANCH_UP
$86:87CC AE C4 0D    LDX $0DC4  [$7E:0DC4]  ;\
$86:87CF 8E 04 42    STX $4204  [$7E:4204]  ;|
$86:87D2 E2 20       SEP #$20               ;|
$86:87D4 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$86:87D7 8D 06 42    STA $4206  [$7E:4206]  ;|
$86:87DA C2 20       REP #$20               ;|
$86:87DC B9 4B 1A    LDA $1A4B,y[$7E:1A6B]  ;} If [current block index] % [room width in blocks] != [enemy projectile X position] / 10h (enemy projectile centre isn't in block):
$86:87DF 4A          LSR A                  ;|
$86:87E0 4A          LSR A                  ;|
$86:87E1 4A          LSR A                  ;|
$86:87E2 4A          LSR A                  ;|
$86:87E3 CD 16 42    CMP $4216  [$7E:4216]  ;|
$86:87E6 F0 02       BEQ $02    [$87EA]     ;/
$86:87E8 18          CLC                    ;\
$86:87E9 60          RTS                    ;} Return carry clear

$86:87EA A5 18       LDA $18    [$7E:0018]  ;\
$86:87EC 38          SEC                    ;|
$86:87ED E5 1E       SBC $1E    [$7E:001E]  ;|
$86:87EF 29 0F 00    AND #$000F             ;} $0DD4 = Fh - (enemy projectile target top boundary) % 10h
$86:87F2 49 0F 00    EOR #$000F             ;|
$86:87F5 8D D4 0D    STA $0DD4  [$7E:0DD4]  ;/
$86:87F8 BF 02 64 7F LDA $7F6402,x[$7F:6826];\
$86:87FC 29 1F 00    AND #$001F             ;|
$86:87FF 0A          ASL A                  ;|
$86:8800 0A          ASL A                  ;} $0DD6 = ([block BTS] & 1Fh) * 10h (slope definition table base index)
$86:8801 0A          ASL A                  ;|
$86:8802 0A          ASL A                  ;|
$86:8803 8D D6 0D    STA $0DD6  [$7E:0DD6]  ;/
$86:8806 BF 01 64 7F LDA $7F6401,x[$7F:6825];\
$86:880A 10 38       BPL $38    [$8844]     ;} If [block BTS] & 80h = 0: return carry clear
$86:880C 0A          ASL A                  ;\
$86:880D 30 05       BMI $05    [$8814]     ;} If [block BTS] & 40h = 0:
$86:880F B9 4B 1A    LDA $1A4B,y[$7E:1A6B]  ; A = [enemy projectile X position] % 10h
$86:8812 80 06       BRA $06    [$881A]

$86:8814 B9 4B 1A    LDA $1A4B,y[$7E:1A6D]  ;\ Else ([block BTS] & 40h != 0):
$86:8817 49 0F 00    EOR #$000F             ;} A = Fh - [enemy projectile X position] % 10h

$86:881A 29 0F 00    AND #$000F
$86:881D 18          CLC                    ;\
$86:881E 6D D6 0D    ADC $0DD6  [$7E:0DD6]  ;|
$86:8821 AA          TAX                    ;} A = [$94:8B2B + [$0DD6] + [A]] (slope top Y offset)
$86:8822 BF 2B 8B 94 LDA $948B2B,x[$94:8C62];/
$86:8826 29 1F 00    AND #$001F
$86:8829 38          SEC                    ;\
$86:882A ED D4 0D    SBC $0DD4  [$7E:0DD4]  ;} A -= [$0DD4] + 1
$86:882D 3A          DEC A                  ;/
$86:882E F0 02       BEQ $02    [$8832]     ;\
$86:8830 10 12       BPL $12    [$8844]     ;} If [A] > 0: return carry clear

$86:8832 49 FF FF    EOR #$FFFF             ;\
$86:8835 1A          INC A                  ;|
$86:8836 18          CLC                    ;} Enemy projectile Y position = (target Y position) - [A]
$86:8837 65 18       ADC $18    [$7E:0018]  ;|
$86:8839 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:883C A9 00 00    LDA #$0000             ;\
$86:883F 99 6F 1A    STA $1A6F,y[$7E:1A8F]  ;} Enemy projectile Y subposition = 0
$86:8842 38          SEC                    ;\
$86:8843 60          RTS                    ;} Return carry set

$86:8844 18          CLC
$86:8845 60          RTS
}


;;; $8846: Enemy projectile block collision reaction pointers - horizontal ;;;
{
$86:8846             dw 858A,
                        858E, ; 1: Slope
                        858A,
                        858A,
                        858A,
                        8506, ; 5: Horizontal extension
                        858A,
                        858A,
                        858C,
                        858C,
                        858C,
                        858C,
                        858C,
                        853C, ; Dh: Vertical extension
                        858A,
                        858C
}


;;; $8866: Enemy projectile block collision reaction pointers - vertical ;;;
{
$86:8866             dw 858A,
                        85AD, ; 1: Slope
                        858A,
                        858A,
                        858A,
                        8506, ; 5: Horizontal extension
                        858A,
                        858A,
                        858C,
                        858C,
                        858C,
                        858C,
                        858C,
                        853C, ; Dh: Vertical extension
                        858A,
                        858C
}


;;; $8886: Enemy projectile horizontal block reaction ;;;
{
;; Parameters:
;;     $14: Enemy projectile X velocity (used only for sign)
;;     $1A: Number of blocks left to check
;;     $1C: Enemy projectile X radius
;;     $1E: Enemy projectile Y radius
;;     $20: Enemy projectile Y span - 1
;;     $22: Target front boundary (left/right depending on sign of enemy projectile velocity)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:8886 DA          PHX
$86:8887 8E C4 0D    STX $0DC4  [$7E:0DC4]  ;\
$86:888A 4E C4 0D    LSR $0DC4  [$7E:0DC4]  ;} Current block index = [X] / 2
$86:888D BF 02 00 7F LDA $7F0002,x[$7F:00F8];\
$86:8891 29 00 F0    AND #$F000             ;|
$86:8894 EB          XBA                    ;|
$86:8895 4A          LSR A                  ;|
$86:8896 4A          LSR A                  ;} Execute [$8846 + (block type) * 2]
$86:8897 4A          LSR A                  ;|
$86:8898 AA          TAX                    ;|
$86:8899 FC 46 88    JSR ($8846,x)[$86:858A];/
$86:889C FA          PLX
$86:889D 60          RTS
}


;;; $889E: Enemy projectile vertical block reaction ;;;
{
;; Parameters:
;;     $14: Enemy projectile Y velocity (used only for sign)
;;     $18: Target Y position
;;     $1A: Number of blocks left to check
;;     $1C: Enemy projectile X radius
;;     $1E: Enemy projectile Y radius
;;     $20: Enemy projectile X span - 1
;;     $22: Target boundary (top/bottom depending on sign of enemy projectile velocity)
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:889E DA          PHX
$86:889F 8E C4 0D    STX $0DC4  [$7E:0DC4]  ;\
$86:88A2 4E C4 0D    LSR $0DC4  [$7E:0DC4]  ;} Current block index = [X] / 2
$86:88A5 BF 02 00 7F LDA $7F0002,x[$7F:00EA];\
$86:88A9 29 00 F0    AND #$F000             ;|
$86:88AC EB          XBA                    ;|
$86:88AD 4A          LSR A                  ;|
$86:88AE 4A          LSR A                  ;} Execute [$8866 + (block type) * 2]
$86:88AF 4A          LSR A                  ;|
$86:88B0 AA          TAX                    ;|
$86:88B1 FC 66 88    JSR ($8866,x)[$86:858A];/
$86:88B4 FA          PLX
$86:88B5 60          RTS
}


;;; $88B6: Move enemy projectile horizontally ;;;
{
;; Parameters:
;;     X: Enemy projectile index
;; Returns:
;;     Carry: Set if collided with block

; This routine expects:
;     Enemy projectile $1A27: X subposition
;     Enemy projectile $1AB7: X velocity (unit 1/100h px/frame)
$86:88B6 DA          PHX
$86:88B7 64 12       STZ $12    [$7E:0012]  ;\
$86:88B9 64 14       STZ $14    [$7E:0014]  ;|
$86:88BB BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;|
$86:88BE 10 02       BPL $02    [$88C2]     ;} $14.$12 = [enemy projectile X velocity] / 100h
$86:88C0 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:88C2 85 13       STA $13    [$7E:0013]  ;/
$86:88C4 BD B4 1B    LDA $1BB4,x[$7E:1BD6]  ;\
$86:88C7 29 FF 00    AND #$00FF             ;} $1E = [enemy projectile Y radius]
$86:88CA 85 1E       STA $1E    [$7E:001E]  ;/
$86:88CC BD B3 1B    LDA $1BB3,x[$7E:1BD5]  ;\
$86:88CF 29 FF 00    AND #$00FF             ;} $1C = [enemy projectile X radius]
$86:88D2 85 1C       STA $1C    [$7E:001C]  ;/
$86:88D4 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:88D7 38          SEC                    ;|
$86:88D8 E5 1E       SBC $1E    [$7E:001E]  ;|
$86:88DA 29 F0 FF    AND #$FFF0             ;|
$86:88DD 85 1A       STA $1A    [$7E:001A]  ;|
$86:88DF BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:88E2 18          CLC                    ;|
$86:88E3 65 1E       ADC $1E    [$7E:001E]  ;|
$86:88E5 3A          DEC A                  ;} $1A = (enemy projectile bottom boundary) / 10h - (enemy projectile top boundary) / 10h (number of blocks left to check)
$86:88E6 38          SEC                    ;|
$86:88E7 E5 1A       SBC $1A    [$7E:001A]  ;|
$86:88E9 4A          LSR A                  ;|
$86:88EA 4A          LSR A                  ;|
$86:88EB 4A          LSR A                  ;|
$86:88EC 4A          LSR A                  ;|
$86:88ED 85 1A       STA $1A    [$7E:001A]  ;/
$86:88EF 85 20       STA $20    [$7E:0020]  ; $20 = [$1A] (enemy projectile Y block span)
$86:88F1 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:88F4 38          SEC                    ;|
$86:88F5 E5 1E       SBC $1E    [$7E:001E]  ;|
$86:88F7 4A          LSR A                  ;|
$86:88F8 4A          LSR A                  ;|
$86:88F9 4A          LSR A                  ;|
$86:88FA 4A          LSR A                  ;} Calculate (enemy projectile top boundary) / 10h * [room width in blocks] (target row block index)
$86:88FB E2 20       SEP #$20               ;|
$86:88FD 8D 02 42    STA $4202  [$7E:4202]  ;|
$86:8900 AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$86:8903 8D 03 42    STA $4203  [$7E:4203]  ;|
$86:8906 C2 20       REP #$20               ;/
$86:8908 BD 27 1A    LDA $1A27,x[$7E:1A49]  ;\
$86:890B 18          CLC                    ;|
$86:890C 65 12       ADC $12    [$7E:0012]  ;|
$86:890E 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy projectile X position] + [$14].[$12]
$86:8910 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:8913 65 14       ADC $14    [$7E:0014]  ;|
$86:8915 85 18       STA $18    [$7E:0018]  ;/
$86:8917 24 14       BIT $14    [$7E:0014]  ;\
$86:8919 30 06       BMI $06    [$8921]     ;} If [$14] >= 0:
$86:891B 18          CLC                    ;\
$86:891C 65 1C       ADC $1C    [$7E:001C]  ;} $22 = [$18] + [enemy projectile X radius] - 1 (target front boundary)
$86:891E 3A          DEC A                  ;/
$86:891F 80 03       BRA $03    [$8924]

$86:8921 38          SEC                    ;\ Else ([$14] < 0):
$86:8922 E5 1C       SBC $1C    [$7E:001C]  ;} $22 = [$18] - [enemy projectile X radius] (target front boundary)

$86:8924 85 22       STA $22    [$7E:0022]
$86:8926 4A          LSR A                  ;\
$86:8927 4A          LSR A                  ;|
$86:8928 4A          LSR A                  ;|
$86:8929 4A          LSR A                  ;|
$86:892A 18          CLC                    ;} X = ((target row block index) + (target front boundary) / 10h) * 2 (index of top block to check)
$86:892B 6D 16 42    ADC $4216  [$7E:4216]  ;|
$86:892E 0A          ASL A                  ;|
$86:892F AA          TAX                    ;/

; LOOP
$86:8930 20 86 88    JSR $8886  [$86:8886]  ; Enemy projectile horizontal block reaction
$86:8933 B0 1A       BCS $1A    [$894F]     ; If solid: go to BRANCH_SOLID
$86:8935 8A          TXA                    ;\
$86:8936 18          CLC                    ;|
$86:8937 6D A5 07    ADC $07A5  [$7E:07A5]  ;} X += [room width in blocks] * 2 (next row)
$86:893A 6D A5 07    ADC $07A5  [$7E:07A5]  ;|
$86:893D AA          TAX                    ;/
$86:893E C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$86:8940 10 EE       BPL $EE    [$8930]     ; If [$1A] >= 0: go to LOOP
$86:8942 FA          PLX
$86:8943 A5 16       LDA $16    [$7E:0016]  ;\
$86:8945 9D 27 1A    STA $1A27,x[$7E:1A49]  ;|
$86:8948 A5 18       LDA $18    [$7E:0018]  ;} Enemy projectile X position = [$18].[$16]
$86:894A 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:894D 18          CLC                    ;\
$86:894E 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$86:894F FA          PLX
$86:8950 9E 27 1A    STZ $1A27,x[$7E:1A41]  ; Enemy projectile X subposition = 0
$86:8953 A5 22       LDA $22    [$7E:0022]
$86:8955 24 14       BIT $14    [$7E:0014]  ;\
$86:8957 30 10       BMI $10    [$8969]     ;} If [$14] < 0: go to BRANCH_MOVING_LEFT
$86:8959 29 F0 FF    AND #$FFF0             ;\
$86:895C 38          SEC                    ;|
$86:895D E5 1C       SBC $1C    [$7E:001C]  ;|
$86:895F DD 4B 1A    CMP $1A4B,x[$7E:1A5D]  ;} Enemy projectile X position = max([enemy projectile X position], (target front boundary) / 10h * 10h - [enemy projectile X radius])
$86:8962 90 03       BCC $03    [$8967]     ;|
$86:8964 9D 4B 1A    STA $1A4B,x[$7E:1A5D]  ;/

$86:8967 38          SEC                    ;\
$86:8968 60          RTS                    ;} Return carry set

; BRANCH_MOVING_LEFT
$86:8969 09 0F 00    ORA #$000F             ;\
$86:896C 38          SEC                    ;|
$86:896D 65 1C       ADC $1C    [$7E:001C]  ;|
$86:896F DD 4B 1A    CMP $1A4B,x[$7E:1A65]  ;|
$86:8972 F0 02       BEQ $02    [$8976]     ;} Enemy projectile X position = min([enemy projectile X position], (target front boundary) / 10h * 10h + 10h + [enemy projectile X radius])
$86:8974 B0 03       BCS $03    [$8979]     ;|
                                            ;|
$86:8976 9D 4B 1A    STA $1A4B,x[$7E:1A65]  ;/

$86:8979 38          SEC                    ;\
$86:897A 60          RTS                    ;} Return carry set
}


;;; $897B: Move enemy projectile vertically ;;;
{
;; Parameters:
;;     X: Enemy projectile index
;; Returns:
;;     Carry: Set if collided with block

; This routine expects:
;     Enemy projectile $1A6F: Y subposition
;     Enemy projectile $1ADB: Y velocity (unit 1/100h px/frame)
$86:897B DA          PHX
$86:897C 64 12       STZ $12    [$7E:0012]  ;\
$86:897E 64 14       STZ $14    [$7E:0014]  ;|
$86:8980 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;|
$86:8983 10 02       BPL $02    [$8987]     ;} $14.$12 = [enemy projectile Y velocity] / 100h
$86:8985 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:8987 85 13       STA $13    [$7E:0013]  ;/
$86:8989 BD B4 1B    LDA $1BB4,x[$7E:1BD6]  ;\
$86:898C 29 FF 00    AND #$00FF             ;} $1E = [enemy projectile Y radius]
$86:898F 85 1E       STA $1E    [$7E:001E]  ;/
$86:8991 BD B3 1B    LDA $1BB3,x[$7E:1BD5]  ;\
$86:8994 29 FF 00    AND #$00FF             ;} $1C = [enemy projectile X radius]
$86:8997 85 1C       STA $1C    [$7E:001C]  ;/
$86:8999 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:899C 38          SEC                    ;|
$86:899D E5 1C       SBC $1C    [$7E:001C]  ;|
$86:899F 29 F0 FF    AND #$FFF0             ;|
$86:89A2 85 1A       STA $1A    [$7E:001A]  ;|
$86:89A4 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:89A7 18          CLC                    ;|
$86:89A8 65 1C       ADC $1C    [$7E:001C]  ;|
$86:89AA 3A          DEC A                  ;} $1A = (enemy projectile right boundary) / 10h - (enemy projectile left boundary) / 10h (number of blocks left to check)
$86:89AB 38          SEC                    ;|
$86:89AC E5 1A       SBC $1A    [$7E:001A]  ;|
$86:89AE 4A          LSR A                  ;|
$86:89AF 4A          LSR A                  ;|
$86:89B0 4A          LSR A                  ;|
$86:89B1 4A          LSR A                  ;|
$86:89B2 85 1A       STA $1A    [$7E:001A]  ;/
$86:89B4 85 20       STA $20    [$7E:0020]  ; $20 = [$1A] (enemy projectile X block span)
$86:89B6 BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;\
$86:89B9 18          CLC                    ;|
$86:89BA 65 12       ADC $12    [$7E:0012]  ;|
$86:89BC 85 16       STA $16    [$7E:0016]  ;} $18.$16 = [enemy projectile Y position] + [$14].[$12] (target position)
$86:89BE BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:89C1 65 14       ADC $14    [$7E:0014]  ;|
$86:89C3 85 18       STA $18    [$7E:0018]  ;/
$86:89C5 24 14       BIT $14    [$7E:0014]  ;\
$86:89C7 30 06       BMI $06    [$89CF]     ;} If [$14] >= 0: (moving down)
$86:89C9 18          CLC                    ;\
$86:89CA 65 1E       ADC $1E    [$7E:001E]  ;} $22 = [$18] + [enemy projectile Y radius] - 1 (target front boundary)
$86:89CC 3A          DEC A                  ;/
$86:89CD 80 03       BRA $03    [$89D2]

$86:89CF 38          SEC                    ;\ Else ([$14] < 0): (moving up)
$86:89D0 E5 1E       SBC $1E    [$7E:001E]  ;} $22 = [$18] - [enemy projectile Y radius] (target front boundary)

$86:89D2 85 22       STA $22    [$7E:0022]
$86:89D4 4A          LSR A                  ;\
$86:89D5 4A          LSR A                  ;|
$86:89D6 4A          LSR A                  ;|
$86:89D7 4A          LSR A                  ;|
$86:89D8 E2 20       SEP #$20               ;|
$86:89DA 8D 02 42    STA $4202  [$7E:4202]  ;|
$86:89DD AD A5 07    LDA $07A5  [$7E:07A5]  ;|
$86:89E0 8D 03 42    STA $4203  [$7E:4203]  ;|
$86:89E3 C2 20       REP #$20               ;|
$86:89E5 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:89E8 38          SEC                    ;} X = ((enemy projectile front boundary) / 10h * [room width] + (enemy projectile left boundary) / 10h) * 2 (index of leftmost block to check)
$86:89E9 E5 1C       SBC $1C    [$7E:001C]  ;|
$86:89EB 4A          LSR A                  ;|
$86:89EC 4A          LSR A                  ;|
$86:89ED 4A          LSR A                  ;|
$86:89EE 4A          LSR A                  ;|
$86:89EF 18          CLC                    ;|
$86:89F0 6D 16 42    ADC $4216  [$7E:4216]  ;|
$86:89F3 0A          ASL A                  ;|
$86:89F4 AA          TAX                    ;/

; LOOP
$86:89F5 20 9E 88    JSR $889E  [$86:889E]  ; Enemy projectile vertical block reaction
$86:89F8 B0 13       BCS $13    [$8A0D]     ; If solid: go to BRANCH_SOLID
$86:89FA E8          INX                    ;\
$86:89FB E8          INX                    ;} X += 2
$86:89FC C6 1A       DEC $1A    [$7E:001A]  ; Decrement $1A
$86:89FE 10 F5       BPL $F5    [$89F5]     ; If [$1A] >= 0: go to LOOP
$86:8A00 FA          PLX
$86:8A01 A5 16       LDA $16    [$7E:0016]  ;\
$86:8A03 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;|
$86:8A06 A5 18       LDA $18    [$7E:0018]  ;} Enemy projectile Y position = [$18].[$16]
$86:8A08 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:8A0B 18          CLC                    ;\
$86:8A0C 60          RTS                    ;} Return carry clear

; BRANCH_SOLID
$86:8A0D FA          PLX
$86:8A0E 9E 6F 1A    STZ $1A6F,x[$7E:1A91]  ; Enemy projectile Y subposition = 0
$86:8A11 A5 22       LDA $22    [$7E:0022]
$86:8A13 24 14       BIT $14    [$7E:0014]  ;\
$86:8A15 30 10       BMI $10    [$8A27]     ;} If [$14] < 0: go to BRANCH_MOVING_UP
$86:8A17 29 F0 FF    AND #$FFF0             ; A = [$22] - [$22] % 10h (target bottom boundary rounded down to top of 16x16 tile)
$86:8A1A 38          SEC                    ;\
$86:8A1B E5 1E       SBC $1E    [$7E:001E]  ;|
$86:8A1D DD 93 1A    CMP $1A93,x[$7E:1AB5]  ;} Enemy projectile Y position = max([enemy projectile Y position], [A] - [enemy projectile Y radius])
$86:8A20 90 03       BCC $03    [$8A25]     ;|
$86:8A22 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/

$86:8A25 38          SEC                    ;\
$86:8A26 60          RTS                    ;} Return carry set

; BRANCH_MOVING_UP
$86:8A27 09 0F 00    ORA #$000F             ;\
$86:8A2A 38          SEC                    ;} A = [$22] - [$22] % 10h + 10h (target right boundary rounded up to bottom of 16x16 tile)
$86:8A2B 65 1E       ADC $1E    [$7E:001E]  ;\
$86:8A2D DD 93 1A    CMP $1A93,x[$7E:1AB3]  ;|
$86:8A30 F0 02       BEQ $02    [$8A34]     ;} Enemy projectile Y position = min([enemy projectile Y position], [A] + [enemy projectile Y radius])
$86:8A32 B0 03       BCS $03    [$8A37]     ;|
                                            ;|
$86:8A34 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/

$86:8A37 38          SEC                    ;\
$86:8A38 60          RTS                    ;} Return carry set
}
}


;;; $8A39..BC: Enemy projectile $8AAF (unused, incomplete) ;;;
{
;;; $8A39: Initialisation AI - enemy projectile $8AAF ;;;
{
$86:8A39 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:8A3D AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:8A40 BD 7E 0F    LDA $0F7E,x            ;\
$86:8A43 18          CLC                    ;|
$86:8A44 69 0C 00    ADC #$000C             ;} Enemy projectile Y position = [enemy Y position] + Ch
$86:8A47 99 93 1A    STA $1A93,y            ;/
$86:8A4A 69 48 00    ADC #$0048             ;\
$86:8A4D 99 DF 19    STA $19DF,y            ;} Enemy projectile target Y position = [enemy projectile Y position] + 48h
$86:8A50 BD AE 0F    LDA $0FAE,x            ;\
$86:8A53 99 DB 1A    STA $1ADB,y            ;} Enemy projectile Y velocity = [enemy $0FAE]
$86:8A56 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:8A59 29 1F 00    AND #$001F             ;|
$86:8A5C 38          SEC                    ;|
$86:8A5D E9 10 00    SBC #$0010             ;} Enemy projectile X position = [enemy X position] + [random number] % 20h - 10h
$86:8A60 18          CLC                    ;|
$86:8A61 7D 7A 0F    ADC $0F7A,x            ;|
$86:8A64 99 4B 1A    STA $1A4B,y            ;/
$86:8A67 B9 DC 1A    LDA $1ADC,y            ;\
$86:8A6A 29 06 00    AND #$0006             ;|
$86:8A6D AA          TAX                    ;} Enemy projectile instruction list pointer = [$8A75 + [enemy projectile Y velocity] / 200h % 3 * 2]
$86:8A6E BD 75 8A    LDA $8A75,x            ;|
$86:8A71 99 47 1B    STA $1B47,y            ;/
$86:8A74 60          RTS

; Garbage instruction list pointers
$86:8A75             dw 8A39, 8A39, 8A39, 8A39
}


;;; $8A7D: Pre-instruction - enemy projectile $8AAF ;;;
{
$86:8A7D BD DA 1A    LDA $1ADA,x            ;\
$86:8A80 29 00 FF    AND #$FF00             ;|
$86:8A83 85 14       STA $14    [$7E:0014]  ;|
$86:8A85 BD DB 1A    LDA $1ADB,x            ;|
$86:8A88 EB          XBA                    ;|
$86:8A89 10 05       BPL $05    [$8A90]     ;|
$86:8A8B 09 00 FF    ORA #$FF00             ;} $12.$14 = ±[enemy projectile Y velocity] / 100h
$86:8A8E 80 03       BRA $03    [$8A93]     ;|
                                            ;|
$86:8A90 29 FF 00    AND #$00FF             ;|
                                            ;|
$86:8A93 85 12       STA $12    [$7E:0012]  ;/
$86:8A95 BD 6F 1A    LDA $1A6F,x            ;\
$86:8A98 18          CLC                    ;|
$86:8A99 65 14       ADC $14    [$7E:0014]  ;|
$86:8A9B 9D 6F 1A    STA $1A6F,x            ;} Enemy projectile Y position += [$12].[$14]
$86:8A9E BD 93 1A    LDA $1A93,x            ;|
$86:8AA1 65 12       ADC $12    [$7E:0012]  ;|
$86:8AA3 9D 93 1A    STA $1A93,x            ;/
$86:8AA6 DD DF 19    CMP $19DF,x            ;\
$86:8AA9 90 03       BCC $03    [$8AAE]     ;} If [enemy projectile Y position] >= [enemy projectile target Y position]:
$86:8AAB 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:8AAE 60          RTS
}


;;; $8AAF: Unused. Enemy projectile ;;;
{
; There's no way of knowing what this enemy projectile might have been (especially with the garbage instruction lists)
; It has no hitbox and falls 48h pixels at a constant velocity (initialised to [enemy $0FAE]),
; so my best guess would have to be a sweat drop (a la eye door) or falling debris (a la Ceres pre elevator hall)

;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:8AAF             dx 8A39,8A7D,8A39,00,00,0002,0000,84FC ; Initial instruction list ignored
}
}


;;; $8ABD..8C31: Skree particles ;;;
{
;;; $8ABD: Instruction list - enemy projectile $8BC2/$8BD0/$8BDE/$8BEC (skree particle) ;;;
{
$86:8ABD             dw 0010,8023,
                        81AB,8ABD   ; Go to $8ABD
}


;;; $8AC5: Instruction list - enemy projectile $8BFA/$8C08/$8C16/$8C24 (metal skree particle) ;;;
{
$86:8AC5             dw 0010,8435,
                        81AB,8AC5   ; Go to $8AC5
}


;;; $8ACD: Initialisation AI - enemy projectile $8BC2/$8BFA ((metal) skree - down-right) ;;;
{
$86:8ACD AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:8AD0 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$86:8AD3 38          SEC                    ;|
$86:8AD4 E9 00 00    SBC #$0000             ;} Enemy projectile Y position = [enemy Y position]
$86:8AD7 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:8ADA A9 FF FC    LDA #$FCFF             ;\
$86:8ADD 99 DB 1A    STA $1ADB,y[$7E:1AFB]  ;} Enemy projectile Y velocity = -301h
$86:8AE0 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:8AE3 18          CLC                    ;|
$86:8AE4 69 06 00    ADC #$0006             ;} Enemy projectile X position = [enemy X position] + 6
$86:8AE7 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:8AEA A9 40 01    LDA #$0140             ;\
$86:8AED 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile X velocity = 140h
$86:8AF0 60          RTS
}


;;; $8AF1: Initialisation AI - enemy projectile $8BD0/$8C08 ((metal) skree - up-right) ;;;
{
$86:8AF1 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:8AF4 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$86:8AF7 38          SEC                    ;|
$86:8AF8 E9 00 00    SBC #$0000             ;} Enemy projectile Y position = [enemy Y position]
$86:8AFB 99 93 1A    STA $1A93,y[$7E:1AB1]  ;/
$86:8AFE A9 FF FB    LDA #$FBFF             ;\
$86:8B01 99 DB 1A    STA $1ADB,y[$7E:1AF9]  ;} Enemy projectile Y velocity = -401h
$86:8B04 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:8B07 18          CLC                    ;|
$86:8B08 69 06 00    ADC #$0006             ;} Enemy projectile X position = [enemy X position] + 6
$86:8B0B 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;/
$86:8B0E A9 60 00    LDA #$0060             ;\
$86:8B11 99 B7 1A    STA $1AB7,y[$7E:1AD5]  ;} Enemy projectile X velocity = 60h
$86:8B14 60          RTS
}


;;; $8B15: Initialisation AI - enemy projectile $8BDE/$8C16 ((metal) skree - down-left) ;;;
{
$86:8B15 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:8B18 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$86:8B1B 38          SEC                    ;|
$86:8B1C E9 00 00    SBC #$0000             ;} Enemy projectile Y position = [enemy Y position]
$86:8B1F 99 93 1A    STA $1A93,y[$7E:1AAF]  ;/
$86:8B22 A9 FF FC    LDA #$FCFF             ;\
$86:8B25 99 DB 1A    STA $1ADB,y[$7E:1AF7]  ;} Enemy projectile Y velocity = -301h
$86:8B28 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:8B2B 18          CLC                    ;|
$86:8B2C 69 FA FF    ADC #$FFFA             ;} Enemy projectile X position = [enemy X position] - 6
$86:8B2F 99 4B 1A    STA $1A4B,y[$7E:1A67]  ;/
$86:8B32 A9 C0 FE    LDA #$FEC0             ;\
$86:8B35 99 B7 1A    STA $1AB7,y[$7E:1AD3]  ;} Enemy projectile X velocity = -140h
$86:8B38 60          RTS
}


;;; $8B39: Initialisation AI - enemy projectile $8BEC/$8C24 ((metal) skree - up-left) ;;;
{
$86:8B39 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:8B3C BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$86:8B3F 38          SEC                    ;|
$86:8B40 E9 00 00    SBC #$0000             ;} Enemy projectile Y position = [enemy Y position]
$86:8B43 99 93 1A    STA $1A93,y[$7E:1AAD]  ;/
$86:8B46 A9 FF FB    LDA #$FBFF             ;\
$86:8B49 99 DB 1A    STA $1ADB,y[$7E:1AF5]  ;} Enemy projectile Y velocity = -401h
$86:8B4C BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:8B4F 18          CLC                    ;|
$86:8B50 69 FA FF    ADC #$FFFA             ;} Enemy projectile X position = [enemy X position] - 6
$86:8B53 99 4B 1A    STA $1A4B,y[$7E:1A65]  ;/
$86:8B56 A9 A0 FF    LDA #$FFA0             ;\
$86:8B59 99 B7 1A    STA $1AB7,y[$7E:1AD1]  ;} Enemy projectile X velocity = -60h
$86:8B5C 60          RTS
}


;;; $8B5D: Pre-instruction - enemy projectile $8BC2/$8BD0/$8BDE/$8BEC/$8BFA/$8C08/$8C16/$8C24 ((metal) skree particle) ;;;
{
$86:8B5D BD B6 1A    LDA $1AB6,x[$7E:1AD6]  ;\
$86:8B60 29 00 FF    AND #$FF00             ;|
$86:8B63 85 14       STA $14    [$7E:0014]  ;|
$86:8B65 BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;|
$86:8B68 EB          XBA                    ;|
$86:8B69 10 05       BPL $05    [$8B70]     ;|
$86:8B6B 09 00 FF    ORA #$FF00             ;} $12.$14 = [enemy projectile X velocity] / 100h
$86:8B6E 80 03       BRA $03    [$8B73]     ;|
                                            ;|
$86:8B70 29 FF 00    AND #$00FF             ;|
                                            ;|
$86:8B73 85 12       STA $12    [$7E:0012]  ;/
$86:8B75 BD 27 1A    LDA $1A27,x[$7E:1A47]  ;\
$86:8B78 18          CLC                    ;|
$86:8B79 65 14       ADC $14    [$7E:0014]  ;|
$86:8B7B 9D 27 1A    STA $1A27,x[$7E:1A47]  ;} Enemy projectile X position += [$12].[$14]
$86:8B7E BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;|
$86:8B81 65 12       ADC $12    [$7E:0012]  ;|
$86:8B83 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:8B86 BD DA 1A    LDA $1ADA,x[$7E:1AFA]  ;\
$86:8B89 29 00 FF    AND #$FF00             ;|
$86:8B8C 85 14       STA $14    [$7E:0014]  ;|
$86:8B8E BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;|
$86:8B91 EB          XBA                    ;|
$86:8B92 10 05       BPL $05    [$8B99]     ;|
$86:8B94 09 00 FF    ORA #$FF00             ;} $12.$14 = [enemy projectile Y velocity] / 100h
$86:8B97 80 03       BRA $03    [$8B9C]     ;|
                                            ;|
$86:8B99 29 FF 00    AND #$00FF             ;|
                                            ;|
$86:8B9C 85 12       STA $12    [$7E:0012]  ;/
$86:8B9E BD 6F 1A    LDA $1A6F,x[$7E:1A8F]  ;\
$86:8BA1 18          CLC                    ;|
$86:8BA2 65 14       ADC $14    [$7E:0014]  ;|
$86:8BA4 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;} Enemy projectile Y position += [$12].[$14]
$86:8BA7 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;|
$86:8BAA 65 12       ADC $12    [$7E:0012]  ;|
$86:8BAC 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:8BAF BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;\
$86:8BB2 18          CLC                    ;|
$86:8BB3 69 50 00    ADC #$0050             ;} Enemy projectile Y velocity += 50h
$86:8BB6 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;/
$86:8BB9 20 E0 E6    JSR $E6E0  [$86:E6E0]  ;\
$86:8BBC F0 03       BEQ $03    [$8BC1]     ;} If enemy projectile is off-screen:
$86:8BBE 9E 97 19    STZ $1997,x[$7E:19B7]  ; Enemy projectile ID = 0

$86:8BC1 60          RTS
}


;;; $8BC2: Enemy projectiles - skree particles ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:8BC2             dx 8ACD,8B5D,8ABD,02,02,0004,0000,84FC ; Skree particle - down-right
$86:8BD0             dx 8AF1,8B5D,8ABD,02,02,0004,0000,84FC ; Skree particle - up-right
$86:8BDE             dx 8B15,8B5D,8ABD,02,02,0004,0000,84FC ; Skree particle - down-left
$86:8BEC             dx 8B39,8B5D,8ABD,02,02,0004,0000,84FC ; Skree particle - up-left
$86:8BFA             dx 8ACD,8B5D,8AC5,02,02,0004,0000,84FC ; Metal skree particle - down-right
$86:8C08             dx 8AF1,8B5D,8AC5,02,02,0004,0000,84FC ; Metal skree particle - up-right
$86:8C16             dx 8B15,8B5D,8AC5,02,02,0004,0000,84FC ; Metal skree particle - down-left
$86:8C24             dx 8B39,8B5D,8AC5,02,02,0004,0000,84FC ; Metal skree particle - up-left
}
}


;;; $8C32..8F8E: Draygon ;;;
{
;;; $8C32: Unused. Instruction list ;;;
{
$86:8C32             dw 0010,8A0F,
                        8159         ; Wait
}


;;; $8C38: Touch instruction list - enemy projectile $8E50 (Draygon goop) ;;;
{
$86:8C38             dw 8D99        ; Draygon goop / Samus collision
}


;;; $8C3A: Instruction list - enemy projectile $8E50 (Draygon goop) ;;;
{
$86:8C3A             dw 000A,8A16,
                        000A,8A1D,
                        000A,8A24,
                        000A,8A2B,
                        000A,8A24,
                        000A,8A1D,
                        81AB,8C3A,   ; Go to $8C3A
                        8159         ; Sleep
}


;;; $8C58: Shot instruction list - enemy projectile $8E50 (Draygon goop) ;;;
{
$86:8C58             dx 0008,8A8D,
                        0008,8A94,
                        8C68,        ; Spawn enemy drops with Draygon eye's drop chances
                        81AB,84FC,   ; Go to delete
                        8154         ; Delete
}


;;; $8C68: Instruction - spawn enemy drops with Draygon eye's drop chances ;;;
{
$86:8C68 5A          PHY
$86:8C69 DA          PHX
$86:8C6A BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:8C6D 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:8C6F BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:8C72 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:8C74 A9 7F DE    LDA #$DE7F             ; A = $DE7F (Draygon eye)
$86:8C77 22 0E 92 A0 JSL $A0920E[$A0:920E]  ; Spawn enemy drops
$86:8C7B FA          PLX
$86:8C7C 7A          PLY
$86:8C7D 60          RTS
}


;;; $8C7E: Unused. Instruction list ;;;
{
$86:8C7E             dx 0004,8A32,
                        0006,8A39,
                        0008,8A40,
                        0018,8A47,
                        0018,8A4E,
                        0018,8A55,
                        0018,8A5C,
                        0018,8A47,
                        81AB,8C7E,  ; Go to $8C7E
                        8159        ; Sleep
}


;;; $8CA4: Instruction list - enemy projectile $8E5E (Draygon's wall turret projectile) ;;;
{
$86:8CA4             dx 0005,AF57,
                        0004,AF68,
                        0003,AF79,
                        0003,AF8A,
                        0003,AF9B,
                        0003,AFAC,
                        0004,AFBD,
                        0003,AFCE,
                        0002,AFDF,
                        0002,AFF0,
                        0002,B001,
                        0002,B012,
                        000A,8A71,
                        000A,8A78,
                        000A,8A7F,
                        000A,8A86,
                        8CF6        ; Pre-instruction = $8DFF (fired)
$86:8CE6             dx 0008,8AAA,
                        0008,8AB1,
                        0008,8AB8,
                        81AB,8CE6   ; Go to $8CE6
}


;;; $8CF6: Instruction - pre-instruction = $8DFF (Draygon's wall turret projectile - fired) ;;;
{
$86:8CF6 A9 FF 8D    LDA #$8DFF
$86:8CF9 9D 03 1A    STA $1A03,x[$7E:1A25]
$86:8CFC 60          RTS
}


;;; $8CFD: Unused. Pre-instruction = $8DCA (Draygon goop - stuck to Samus) ;;;
{
$86:8CFD A9 CA 8D    LDA #$8DCA             ;\
$86:8D00 9D 03 1A    STA $1A03,x            ;} Enemy projectile pre-instruction = $8DCA (Draygon goop - stuck to Samus)
$86:8D03 60          RTS
}


;;; $8D04: Initialisation AI - enemy projectile $8E50 (Draygon goop) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
;;     $1993: Speed
;;     $1995: Angle (using common maths convention)
$86:8D04 5A          PHY
$86:8D05 DA          PHX
$86:8D06 BB          TYX                    ; X = [Y]
$86:8D07 A5 12       LDA $12    [$7E:0012]  ;\
$86:8D09 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [$12]
$86:8D0C A5 14       LDA $14    [$7E:0014]  ;\
$86:8D0E 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [$14]
$86:8D11 AD 95 19    LDA $1995  [$7E:1995]  ;\
$86:8D14 9F DC 97 7E STA $7E97DC,x[$7E:97FE];} $12 = enemy projectile angle = [enemy projectile initialisation parameter 1]
$86:8D18 85 12       STA $12    [$7E:0012]  ;/
$86:8D1A AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:8D1D 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile initialisation parameter 0]
$86:8D1F 22 43 B6 A0 JSL $A0B643[$A0:B643]  ; ($16.$18, $1A.$1C) = ([$14] * |cos([$12] * pi / 80h)|, [$14] * |sin([$12] * pi / 80h)|)
$86:8D23 A5 16       LDA $16    [$7E:0016]  ;\
$86:8D25 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;|
$86:8D28 A5 18       LDA $18    [$7E:0018]  ;} Enemy projectile X speed = [$16].[$18]
$86:8D2A 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$86:8D2D A5 1A       LDA $1A    [$7E:001A]  ;\
$86:8D2F 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;|
$86:8D32 A5 1C       LDA $1C    [$7E:001C]  ;} Enemy projectile Y speed = [$1A].[$1C]
$86:8D34 99 23 1B    STA $1B23,y[$7E:1B45]  ;/
$86:8D37 A9 00 04    LDA #$0400             ;\
$86:8D3A 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:8D3D FA          PLX
$86:8D3E 7A          PLY
$86:8D3F 60          RTS
}


;;; $8D40: Initialisation AI - enemy projectile $8E5E (Draygon's wall turret projectile) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
;;     $1993: Speed
$86:8D40 5A          PHY
$86:8D41 DA          PHX
$86:8D42 20 AB E7    JSR $E7AB  [$86:E7AB]  ; Place and aim Draygon's wall turret projectile
$86:8D45 A9 00 0A    LDA #$0A00             ;\
$86:8D48 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:8D4B A9 54 8D    LDA #$8D54             ;\
$86:8D4E 99 03 1A    STA $1A03,y[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:8D51 FA          PLX
$86:8D52 7A          PLY
$86:8D53 60          RTS
}


;;; $8D54: RTS ;;;
{
$86:8D54 60          RTS
}


;;; $8D55: Unused. Delete enemy projectile [Y] ;;;
{
$86:8D55 A9 00 00    LDA #$0000             ;\
$86:8D58 99 97 19    STA $1997,y            ;} Enemy projectile ID = 0
$86:8D5B 60          RTS
}


;;; $8D5C: Delete enemy projectile if power bombed ;;;
{
$86:8D5C 5A          PHY                    ;\
$86:8D5D DA          PHX                    ;} >_<;
$86:8D5E AD EB 0C    LDA $0CEB  [$7E:0CEB]  ;\
$86:8D61 29 FF 00    AND #$00FF             ;} $12 = [power bomb explosion radius] / 100h (power bomb X radius)
$86:8D64 85 12       STA $12    [$7E:0012]  ;/
$86:8D66 F0 2E       BEQ $2E    [$8D96]     ; If (power bomb X radius) = 0: return
$86:8D68 4A          LSR A                  ;\
$86:8D69 65 12       ADC $12    [$7E:0012]  ;|
$86:8D6B 4A          LSR A                  ;} $14 = (power bomb X radius) * 3/4 (power bomb Y radius)
$86:8D6C 85 14       STA $14    [$7E:0014]  ;/
$86:8D6E AD E2 0C    LDA $0CE2  [$7E:0CE2]  ;\
$86:8D71 38          SEC                    ;|
$86:8D72 FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$86:8D75 10 04       BPL $04    [$8D7B]     ;|
$86:8D77 49 FF FF    EOR #$FFFF             ;} If |[power bomb explosion X position] - [enemy projectile X position]| >= (power bomb X radius): return
$86:8D7A 1A          INC A                  ;|
                                            ;|
$86:8D7B C5 12       CMP $12    [$7E:0012]  ;|
$86:8D7D B0 17       BCS $17    [$8D96]     ;/
$86:8D7F AD E4 0C    LDA $0CE4  [$7E:0CE4]  ;\
$86:8D82 38          SEC                    ;|
$86:8D83 FD 93 1A    SBC $1A93,x[$7E:1AB5]  ;|
$86:8D86 10 04       BPL $04    [$8D8C]     ;|
$86:8D88 49 FF FF    EOR #$FFFF             ;} If |[power bomb explosion Y position] - [enemy projectile Y position]| >= (power bomb Y radius): return
$86:8D8B 1A          INC A                  ;|
                                            ;|
$86:8D8C C5 14       CMP $14    [$7E:0014]  ;|
$86:8D8E B0 06       BCS $06    [$8D96]     ;/
$86:8D90 9E 97 19    STZ $1997,x[$7E:19B7]  ; Enemy projectile ID = 0
$86:8D93 9C 66 0A    STZ $0A66  [$7E:0A66]  ; Samus X speed divisor = 0

$86:8D96 FA          PLX
$86:8D97 7A          PLY
$86:8D98 60          RTS
}


;;; $8D99: Instruction - Draygon goop / Samus collision ;;;
{
$86:8D99 20 5C 8D    JSR $8D5C  [$86:8D5C]  ; Delete enemy projectile if power bombed
$86:8D9C AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$86:8D9F 1A          INC A                  ;|
$86:8DA0 C9 06 00    CMP #$0006             ;} If [Samus X speed divisor] >= 5: return
$86:8DA3 10 24       BPL $24    [$8DC9]     ;/
$86:8DA5 8D 66 0A    STA $0A66  [$7E:0A66]  ; Increment Samus X speed divisor
$86:8DA8 9D 23 1B    STA $1B23,x[$7E:1B45]  ; Enemy projectile Y offset = [Samus X speed divisor]
$86:8DAB A9 00 01    LDA #$0100             ;\
$86:8DAE 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile life timer = 100h
$86:8DB1 A9 CA 8D    LDA #$8DCA             ;\
$86:8DB4 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $8DCA (stuck to Samus)
$86:8DB7 BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$86:8DBA 29 FF 7F    AND #$7FFF             ;|
$86:8DBD 09 00 20    ORA #$2000             ;} Disable enemy projectile collisions
$86:8DC0 9D D7 1B    STA $1BD7,x[$7E:1BF9]  ;/
$86:8DC3 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$86:8DC6 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0

$86:8DC9 60          RTS
}


;;; $8DCA: Pre-instruction - Draygon goop - stuck to Samus ;;;
{
$86:8DCA 20 5C 8D    JSR $8D5C  [$86:8D5C]  ; Delete enemy projectile if power bombed
$86:8DCD AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$86:8DD0 D0 1E       BNE $1E    [$8DF0]     ;} If [Samus contact damage index] = normal:
$86:8DD2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:8DD5 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [Samus X position]
$86:8DD8 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:8DDB 0A          ASL A                  ;|
$86:8DDC 0A          ASL A                  ;|
$86:8DDD 18          CLC                    ;|
$86:8DDE 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Enemy projectile Y position = [Samus Y position] - Ch + [enemy projectile Y offset] * 4
$86:8DE1 38          SEC                    ;|
$86:8DE2 E9 0C 00    SBC #$000C             ;|
$86:8DE5 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:8DE8 DE FF 1A    DEC $1AFF,x[$7E:1B21]  ; Decrement enemy projectile life timer
$86:8DEB BD FF 1A    LDA $1AFF,x[$7E:1B21]
$86:8DEE D0 0E       BNE $0E    [$8DFE]     ; If [enemy projectile life timer] != 0: return

$86:8DF0 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:8DF3 CE 66 0A    DEC $0A66  [$7E:0A66]  ;\
$86:8DF6 AD 66 0A    LDA $0A66  [$7E:0A66]  ;|
$86:8DF9 10 03       BPL $03    [$8DFE]     ;} Samus X speed divisor = max(0, [Samus X speed divisor] - 1)
$86:8DFB 9C 66 0A    STZ $0A66  [$7E:0A66]  ;/

$86:8DFE 60          RTS
}


;;; $8DFF: Pre-instruction - Draygon's wall turret projectile - fired ;;;
{
$86:8DFF 20 5C 8D    JSR $8D5C  [$86:8D5C]  ; Delete enemy projectile if power bombed
$86:8E02 20 3E E7    JSR $E73E  [$86:E73E]  ; Move enemy projectile according to enemy projectile angle and speed
$86:8E05 20 22 E7    JSR $E722  [$86:E722]  ;\
$86:8E08 D0 01       BNE $01    [$8E0B]     ;} If enemy projectile is in Draygon room boundaries:
$86:8E0A 60          RTS                    ; Return

$86:8E0B 9E 97 19    STZ $1997,x[$7E:19B7]  ; Enemy projectile ID = 0
$86:8E0E 60          RTS
}


;;; $8E0F: Pre-instruction - enemy projectile $8E50 (Draygon goop) ;;;
{
$86:8E0F 20 5C 8D    JSR $8D5C  [$86:8D5C]  ; Delete enemy projectile if power bombed
$86:8E12 20 3E E7    JSR $E73E  [$86:E73E]  ; Move enemy projectile according to enemy projectile angle and speed
$86:8E15 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:8E18 38          SEC                    ;|
$86:8E19 FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$86:8E1C 10 04       BPL $04    [$8E22]     ;|
$86:8E1E 49 FF FF    EOR #$FFFF             ;} If |[Samus X position] - [enemy projectile X position]| < 10h:
$86:8E21 1A          INC A                  ;|
                                            ;|
$86:8E22 C9 10 00    CMP #$0010             ;|
$86:8E25 10 1F       BPL $1F    [$8E46]     ;/
$86:8E27 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:8E2A 38          SEC                    ;|
$86:8E2B FD 93 1A    SBC $1A93,x[$7E:1AB3]  ;|
$86:8E2E 10 04       BPL $04    [$8E34]     ;|
$86:8E30 49 FF FF    EOR #$FFFF             ;} If |[Samus Y position] - [enemy projectile Y position]| < 14h:
$86:8E33 1A          INC A                  ;|
                                            ;|
$86:8E34 C9 14 00    CMP #$0014             ;|
$86:8E37 10 0D       BPL $0D    [$8E46]     ;/
$86:8E39 A9 38 8C    LDA #$8C38             ;\
$86:8E3C 9D 47 1B    STA $1B47,x[$7E:1B67]  ;} Enemy projectile instruction list pointer = $8C38 (Samus collision)
$86:8E3F A9 01 00    LDA #$0001             ;\
$86:8E42 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:8E45 60          RTS                    ; Return

$86:8E46 20 22 E7    JSR $E722  [$86:E722]  ;\
$86:8E49 D0 01       BNE $01    [$8E4C]     ;} If enemy projectile is in Draygon room boundaries:
$86:8E4B 60          RTS                    ; Return

$86:8E4C 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:8E4F 60          RTS
}


;;; $8E50: Enemy projectiles - Draygon ;;;
{
; Enemy projectile $8E6C is partially coded, small sprite with a fairly short animation loop that travels towards Draygon
; It doesn't collide with Samus, but it is shootable
; Uses the last row of mini-Draygon tiles ($B1:9400), though I doubt those are the correct graphics for this enemy projectile

;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:8E50             dx 8D04,8E0F,8C3A,08,08,D000,8C38,8C58 ; Draygon goop
$86:8E5E             dx 8D40,8DFF,8CA4,08,08,1080,0000,E138 ; Draygon's wall turret projectile. Initial pre-instruction ignored
$86:8E6C             dx 8E7A,8E99,8CA4,08,08,7000,0000,E138 ; Unused. Initial instruction list ignored
}


;;; $8E7A: Initialisation AI - enemy projectile $8E6C ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
$86:8E7A DA          PHX                    ; >_<;
$86:8E7B A9 F0 03    LDA #$03F0             ;\
$86:8E7E 99 BB 19    STA $19BB,y            ;} Enemy projectile VRAM graphics index = 1F0h, palette 1
$86:8E81 A5 12       LDA $12    [$7E:0012]  ;\
$86:8E83 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [$12]
$86:8E86 A5 14       LDA $14    [$7E:0014]  ;\
$86:8E88 99 93 1A    STA $1A93,y            ;} Enemy projectile Y position = [$14]
$86:8E8B A9 DF 8E    LDA #$8EDF             ;\
$86:8E8E 99 47 1B    STA $1B47,y            ;} Enemy projectile instruction list pointer = $8EDF
$86:8E91 A9 01 00    LDA #$0001             ;\
$86:8E94 99 8F 1B    STA $1B8F,y            ;} Enemy projectile instruction timer = 1
$86:8E97 FA          PLX
$86:8E98 60          RTS
}


;;; $8E99: Pre-instruction - enemy projectile $8E6C ;;;
{
$86:8E99 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:8E9C 38          SEC                    ;|
$86:8E9D E5 12       SBC $12    [$7E:0012]  ;|
$86:8E9F 85 12       STA $12    [$7E:0012]  ;|
$86:8EA1 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;} A = angle from ([$12], [$14]) to enemy 0
$86:8EA4 38          SEC                    ;|
$86:8EA5 E5 14       SBC $14    [$7E:0014]  ;|
$86:8EA7 85 14       STA $14    [$7E:0014]  ;|
$86:8EA9 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$86:8EAD 49 FF 00    EOR #$00FF             ;\
$86:8EB0 1A          INC A                  ;|
$86:8EB1 18          CLC                    ;|
$86:8EB2 69 40 00    ADC #$0040             ;} Enemy projectile angle = (40h - [A]) % 100h (angle using the common maths convention)
$86:8EB5 29 FF 00    AND #$00FF             ;|
$86:8EB8 9F DC 97 7E STA $7E97DC,x          ;/
$86:8EBC 85 12       STA $12    [$7E:0012]  ; $12 = [enemy projectile angle]
$86:8EBE A9 01 00    LDA #$0001             ;\
$86:8EC1 85 14       STA $14    [$7E:0014]  ;} ($16.$18, $1A.$1C) = (|cos([$12] * pi / 80h)|, |sin([$12] * pi / 80h)|)
$86:8EC3 22 43 B6 A0 JSL $A0B643[$A0:B643]  ;/
$86:8EC7 A5 16       LDA $16    [$7E:0016]  ;\
$86:8EC9 9D B7 1A    STA $1AB7,x            ;|
$86:8ECC A5 18       LDA $18    [$7E:0018]  ;} Enemy projectile X speed = [$16].[$18]
$86:8ECE 9D FF 1A    STA $1AFF,x            ;/
$86:8ED1 A5 1A       LDA $1A    [$7E:001A]  ;\
$86:8ED3 9D DB 1A    STA $1ADB,x            ;|
$86:8ED6 A5 1C       LDA $1C    [$7E:001C]  ;} Enemy projectile Y speed = [$1A].[$1C]
$86:8ED8 9D 23 1B    STA $1B23,x            ;/
$86:8EDB 20 3E E7    JSR $E73E  [$86:E73E]  ; Move enemy projectile according to enemy projectile angle and speed
$86:8EDE 60          RTS
}


;;; $8EDF: Instruction list - enemy projectile $8E6C ;;;
{
$86:8EDF             dx 0005,8967,
                        0005,896E,
                        0005,8967,
                        0005,8975,
                        81AB,8EDF   ; Go to $8EDF
}


;;; $8EF3: Unused. Instruction list ;;;
{
$86:8EF3             dx 0005,897C,
                        0005,8983,
                        0005,897C,
                        0005,898A,
                        81AB,8EF3   ; Go to $8EF3
}


;;; $8F07: Unused. Instruction list ;;;
{
$86:8F07             dx 0005,8991,
                        0005,8998,
                        0005,8991,
                        0005,899F,
                        81AB,8F07   ; Go to $8F07
}


;;; $8F1B: Unused. Instruction list ;;;
{
$86:8F1B             dx 0005,89A6,
                        0005,89AD,
                        0005,89A6,
                        0005,89B4,
                        81AB,8F1B   ; Go to $8F1B
}


;;; $8F2F: Unused. Instruction list ;;;
{
$86:8F2F             dx 0005,89BB,
                        0005,89C2,
                        0005,89BB,
                        0005,89C9,
                        81AB,8F2F   ; Go to $8F2F
}


;;; $8F43: Unused. Instruction list ;;;
{
$86:8F43             dx 0005,89D0,
                        0005,89D7,
                        0005,89D0,
                        0005,89DE,
                        81AB,8F43   ; Go to $8F43
}


;;; $8F57: Unused. Instruction list ;;;
{
$86:8F57             dx 0005,89E5,
                        0005,89EC,
                        0005,89E5,
                        0005,89F3,
                        81AB,8F57   ; Go to $8F57
}


;;; $8F6B: Unused. Instruction list ;;;
{
$86:8F6B             dx 0005,89FA,
                        0005,8A01,
                        0005,89FA,
                        0005,8A08,
                        81AB,8F6B   ; Go to $8F6B
}


;;; $8F7F: Unused. Instruction list pointers ;;;
{
$86:8F7F             dw 8EDF, 8EF3, 8F07, 8F1B, 8F2F, 8F43, 8F57, 8F6B
}
}


;;; $8F8F..92D5: Crocomire ;;;
{
;;; $8F8F: Enemy projectiles - Crocomire ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:8F8F             dx 9023,906B,8FCF,08,08,8014,0000,9007 ; Crocomire's projectile
$86:8F9D             dx 9286,92BA,8FEB,04,04,8000,0000,84FC ; Crocomire bridge crumbling (see $A4:9136)
}


;;; $8FAB: Unused. Instruction list - Crocomire's projectile - part 1/3 ;;;
{
$86:8FAB             dx 0005,802A,
                        0005,8040,
                        81AB,8FAB   ; Go to $8FAB
}


;;; $8FB7: Unused. Instruction list - Crocomire's projectile - part 2/3 ;;;
{
$86:8FB7             dx 0005,8056,
                        0005,806C,
                        81AB,8FB7   ; Go to $8FB7
}


;;; $8FC3: Unused. Instruction list ;;;
{
; Might have been an old version of Crocomire's projectile that uses enemy graphics
$86:8FC3             dx 0005,8082,
                        0005,8098,
                        81AB,8FC3   ; Go to $8FC3
}


;;; $8FCF: Instruction list - enemy projectile $8F8F (Crocomire's projectile) ;;;
{
$86:8FCF             dx 0003,802A,
                        0003,8040,
                        0003,8056,
                        0003,806C,
                        0003,8056,
                        0003,8040,
                        81AB,8FCF   ; Go to $8FCF
}


;;; $8FEB: Instruction list - enemy projectile $8F9D (Crocomire bridge crumbling) ;;;
{
$86:8FEB             dx 7FFF,8109,
                        81AB,8FEB   ; Go to $8FEB
}


;;; $8FF3: Instruction list - enemy projectile $90C1 (Crocomire spike wall pieces) ;;;
{
$86:8FF3             dx 7FFF,8110,
                        81AB,8FF3   ; Go to $8FF3
}


;;; $8FFB: Unused. Instruction list ;;;
{
; Referenced by unused routine $922F (move enemy projectile up for 6 frames and then delete)
; Looks vaguely related to Crocomire bridge crumbling
$86:8FFB             dx 0002,8132,
                        0002,813E,
                        7FFF,815E
}


;;; $9007: Shot instruction list - enemy projectile $8F8F (Crocomire's projectile) ;;;
{
$86:9007             dx 0004,8D9C,
                        0004,8DA3,
                        0004,8DB9,
                        0004,8DCF,
                        0004,8DE5,
                        9270,       ; Spawn enemy drops with Crocomire's drop chances
                        81AB,84FC,  ; Go to delete
                        8154        ; Delete
}


;;; $9023: Initialisation AI - enemy projectile $8F8F (Crocomire's projectile) ;;;
{
$86:9023 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:9026 A9 00 FE    LDA #$FE00             ;\
$86:9029 99 B7 1A    STA $1AB7,y[$7E:1AD5]  ;} Enemy projectile X velocity = -200h
$86:902C A9 01 00    LDA #$0001             ;\
$86:902F 99 DB 1A    STA $1ADB,y[$7E:1AF9]  ;} Enemy projectile $1ADB = 1 (never read)
$86:9032 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:9035 38          SEC                    ;|
$86:9036 E9 20 00    SBC #$0020             ;} Enemy projectile X position = [enemy X position] - 20h
$86:9039 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;/
$86:903C BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:903F 38          SEC                    ;|
$86:9040 E9 10 00    SBC #$0010             ;} Enemy projectile Y position = [enemy Y position] - 10h
$86:9043 99 93 1A    STA $1A93,y[$7E:1AB1]  ;/
$86:9046 A9 00 00    LDA #$0000
$86:9049 99 DF 19    STA $19DF,y[$7E:19FD]
$86:904C 99 27 1A    STA $1A27,y[$7E:1A45]  ; Enemy projectile X subposition = 0
$86:904F 99 6F 1A    STA $1A6F,y[$7E:1A8D]  ; Enemy projectile Y subposition = 0
$86:9052 A9 00 0A    LDA #$0A00             ;\
$86:9055 99 BB 19    STA $19BB,y[$7E:19D9]  ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:9058 60          RTS
}


;;; $9059: Crocomire's projectile gradients ;;;
{
; Signed values v such that v / -40h is the actual gradient (so v = 40h is the down-left diagonal, v = 0 is straight left, v = FFC0h is the up-left diagonal)
; Indexed by [enemy 0 $0FB2]
$86:9059             dw FFF0,0000,0020,
                        FFF0,0000,0020,
                        FFF0,0000,0020
}


;;; $906B: Pre-instruction - Crocomire's projectile - setup ;;;
{
$86:906B 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:906E A9 00 0A    LDA #$0A00             ;\
$86:9071 8D BB 19    STA $19BB  [$7E:19BB]  ;} Enemy projectile 0 VRAM graphics index = 0, palette 5 <-- bug (would be a no-op if fixed >_>)
$86:9074 BD DF 19    LDA $19DF,x[$7E:19FD]  ;\
$86:9077 18          CLC                    ;|
$86:9078 7D B7 1A    ADC $1AB7,x[$7E:1AD5]  ;} Enemy projectile $19DF += [enemy projectile X velocity]
$86:907B 9D DF 19    STA $19DF,x[$7E:19FD]  ;/
$86:907E A9 C0 FF    LDA #$FFC0             ;\
$86:9081 85 12       STA $12    [$7E:0012]  ;} $12 = -40h
$86:9083 DA          PHX                    ;\
$86:9084 AE B2 0F    LDX $0FB2  [$7E:0FB2]  ;|
$86:9087 BD 59 90    LDA $9059,x[$86:905B]  ;} $14 = [$9059 + [enemy 0 $0FB2]]
$86:908A 85 14       STA $14    [$7E:0014]  ;|
$86:908C FA          PLX                    ;/
$86:908D 9B          TXY                    ; Y = [enemy projectile index]
$86:908E 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ; A = angle of ([$12], [$14]) offset
$86:9092 0A          ASL A                  ;\
$86:9093 AA          TAX                    ;} X = [A] * 2
$86:9094 18          CLC                    ; >_<;
$86:9095 BF 43 B4 A0 LDA $A0B443,x[$A0:B5C3];\
$86:9099 85 12       STA $12    [$7E:0012]  ;|
$86:909B 0A          ASL A                  ;} Enemy projectile X velocity = 400h * sin([A] * pi / 80h)
$86:909C 0A          ASL A                  ;|
$86:909D 99 B7 1A    STA $1AB7,y[$7E:1AD5]  ;/
$86:90A0 18          CLC                    ; >_<;
$86:90A1 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B543];\
$86:90A5 85 12       STA $12    [$7E:0012]  ;|
$86:90A7 0A          ASL A                  ;} Enemy projectile Y velocity = 400h * -cos([A] * pi / 80h)
$86:90A8 0A          ASL A                  ;|
$86:90A9 99 DB 1A    STA $1ADB,y[$7E:1AF9]  ;/
$86:90AC A9 B3 90    LDA #$90B3             ;\
$86:90AF 99 03 1A    STA $1A03,y[$7E:1A21]  ;} Enemy projectile pre-instruction = $90B3 (fired)
$86:90B2 60          RTS
}


;;; $90B3: Pre-instruction - Crocomire's projectile - fired ;;;
{
$86:90B3 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:90B6 B0 05       BCS $05    [$90BD]     ; If no collision:
$86:90B8 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:90BB 90 03       BCC $03    [$90C0]     ; If no collision: return

$86:90BD 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:90C0 60          RTS
}


;;; $90C1: Enemy projectile - Crocomire spike wall pieces ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:90C1             dx 90CF,9115,8FF3,00,00,0000,0000,84FC ; Crocomire spike wall pieces
}


;;; $90CF: Initialisation AI - enemy projectile $90C1 (Crocomire spike wall pieces) ;;;
{
; This code assumes the Crocomire spike wall piece enemy projectiles are the last 8 slots
; (enemy projectiles are spawned starting from the last slot)
$86:90CF C2 20       REP #$20
$86:90D1 98          TYA                    ;\
$86:90D2 38          SEC                    ;|
$86:90D3 E9 14 00    SBC #$0014             ;|
$86:90D6 AA          TAX                    ;} Enemy projectile Y position = 38h + ([enemy projectile index] / 2 - Ah) * 10h
$86:90D7 BD 05 91    LDA $9105,x[$86:9113]  ;|
$86:90DA 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:90DD A9 10 02    LDA #$0210             ;\
$86:90E0 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = 210h
$86:90E3 A9 00 00    LDA #$0000             ;\
$86:90E6 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = 0
$86:90E9 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ; >_<;
$86:90EC 99 FF 1A    STA $1AFF,y[$7E:1B21]  ; Enemy projectile X acceleration = 0
$86:90EF 99 23 1B    STA $1B23,y[$7E:1B45]  ; >_<;
$86:90F2 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile X subposition = 0
$86:90F5 99 6F 1A    STA $1A6F,y[$7E:1A91]
$86:90F8 A9 FB FF    LDA #$FFFB             ;\
$86:90FB 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;|
$86:90FE A9 00 88    LDA #$8800             ;} Enemy projectile Y velocity = -4.8800h
$86:9101 99 23 1B    STA $1B23,y[$7E:1B45]  ;/
$86:9104 60          RTS

; Y positions, indexed by [enemy projectile index] - 14h
$86:9105             dw 0038, 0048, 0058, 0068, 0078, 0088, 0098, 00A8
}


;;; $9115: Pre-instruction - enemy projectile $90C1 (Crocomire spike wall pieces) ;;;
{
$86:9115 C2 20       REP #$20
$86:9117 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:911A DD E7 91    CMP $91E7,x[$86:9209]  ;|
$86:911D F0 0C       BEQ $0C    [$912B]     ;|
$86:911F 18          CLC                    ;|
$86:9120 7D C3 91    ADC $91C3,x[$86:91E5]  ;|
$86:9123 DD E7 91    CMP $91E7,x[$86:9209]  ;} Enemy projectile X acceleration = min([enemy projectile X acceleration] + [$91C3 + [enemy projectile index]], [$91E7 + [enemy projectile index]])
$86:9126 90 03       BCC $03    [$912B]     ;|
$86:9128 BD E7 91    LDA $91E7,x[$86:9209]  ;|
                                            ;|
$86:912B 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/
$86:912E E2 20       SEP #$20
$86:9130 BD 00 1B    LDA $1B00,x[$7E:1B22]  ;\
$86:9133 18          CLC                    ;|
$86:9134 7D B7 1A    ADC $1AB7,x[$7E:1AD9]  ;|
$86:9137 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;|
$86:913A BD B8 1A    LDA $1AB8,x[$7E:1ADA]  ;|
$86:913D 69 00       ADC #$00               ;} Enemy projectile X velocity = min([enemy projectile X velocity] + [enemy projectile X acceleration] / 100h, [$920B + [enemy projectile index]])
$86:913F DD 0B 92    CMP $920B,x[$86:922D]  ;|
$86:9142 30 03       BMI $03    [$9147]     ;|
$86:9144 BD 0B 92    LDA $920B,x[$86:922B]  ;|
                                            ;|
$86:9147 9D B8 1A    STA $1AB8,x[$7E:1ADA]  ;/
$86:914A BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:914D 18          CLC                    ;|
$86:914E 7D 28 1A    ADC $1A28,x[$7E:1A4A]  ;|
$86:9151 9D 28 1A    STA $1A28,x[$7E:1A4A]  ;|
$86:9154 BD B8 1A    LDA $1AB8,x[$7E:1ADA]  ;|
$86:9157 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position += [enemy projectile X velocity] / 100h
$86:915A 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;|
$86:915D BD 4C 1A    LDA $1A4C,x[$7E:1A6E]  ;|
$86:9160 69 00       ADC #$00               ;|
$86:9162 9D 4C 1A    STA $1A4C,x[$7E:1A6E]  ;/
$86:9165 C2 20       REP #$20
$86:9167 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:916A 18          CLC                    ;|
$86:916B 69 00 30    ADC #$3000             ;|
$86:916E 9D 23 1B    STA $1B23,x[$7E:1B45]  ;} Enemy projectile Y velocity += 0.3000h
$86:9171 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;|
$86:9174 69 00 00    ADC #$0000             ;|
$86:9177 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:917A BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;\
$86:917D 18          CLC                    ;|
$86:917E 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;|
$86:9181 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;} Enemy projectile Y position += [enemy projectile Y velocity]
$86:9184 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:9187 7D DB 1A    ADC $1ADB,x[$7E:1AFD]  ;|
$86:918A 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:918D BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:9190 C9 A8 00    CMP #$00A8             ;} If [enemy projectile Y position] < A8h: return
$86:9193 90 2D       BCC $2D    [$91C2]     ;/
$86:9195 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:9198 8A          TXA                    ;\
$86:9199 89 02 00    BIT #$0002             ;} If [enemy projectile index] / 2 % 2 = 0:
$86:919C D0 09       BNE $09    [$91A7]     ;/
$86:919E DA          PHX
$86:919F A9 29 00    LDA #$0029             ;\
$86:91A2 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 29h, sound library 2, max queued sounds allowed = 6 (Crocomire's wall explodes)
$86:91A6 FA          PLX

$86:91A7 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:91AA 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:91AC BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:91AF 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:91B1 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$86:91B4 A0 09 E5    LDY #$E509             ;\
$86:91B7 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:91BB A9 25 00    LDA #$0025             ;\
$86:91BE 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 25h, sound library 2, max queued sounds allowed = 6 (big explosion)

$86:91C2 60          RTS

; Indexed by enemy projectile index
;                        _________________________Unused_________________________
;                       /                                                        \
$86:91C3             dw 0000, 0000, 0FF0, 0EE0, 0CC0, 0AA0, 0880, 0660, 0440, 0220, 0FF0, 0EE0, 0CC0, 0AA0, 0880, 0660, 0440, 0220 ; X acceleration delta (unit 1/10000h px/frame^3)
$86:91E7             dw 0000, 0000, FF00, EE00, CC00, AA00, 8800, 6600, 4400, 2200, FF00, EE00, CC00, AA00, 8800, 6600, 4400, 2200 ; Max X acceleration (unit 1/10000h px/frame^2)
$86:920B             dw 0000, 0000, 0004, 0004, 0003, 0003, 0002, 0002, 0001, 0001, 0006, 0005, 0004, 0003, 0002, 0002, 0001, 0001 ; Max X velocity (unit 1/100h px/frame)
}


;;; $922F: Unused. Move enemy projectile up for 6 frames and then delete ;;;
{
$86:922F BD 64 0B    LDA $0B64,x            ; >_<;
$86:9232 A9 01 00    LDA #$0001             ;\
$86:9235 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:9238 A9 FB 8F    LDA #$8FFB             ;\
$86:923B 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $8FFB
$86:923E A9 59 92    LDA #$9259             ;\
$86:9241 9D 03 1A    STA $1A03,x            ;} Enemy projectile pre-instruction = $9259
$86:9244 A9 00 00    LDA #$0000             ;\
$86:9247 9D B7 1A    STA $1AB7,x            ;} Enemy projectile $1AB7 = 0
$86:924A A9 02 00    LDA #$0002             ;\
$86:924D 9D DB 1A    STA $1ADB,x            ;} Enemy projectile Y speed = 2
$86:9250 A9 06 00    LDA #$0006             ;\
$86:9253 9D FF 1A    STA $1AFF,x            ;} Enemy projectile timer = 6
$86:9256 9D 23 1B    STA $1B23,x            ; Enemy projectile $1B23 = 0
}


;;; $9259: Unused. Pre-instruction - moving up ;;;
{
$86:9259 BD 93 1A    LDA $1A93,x            ;\
$86:925C 38          SEC                    ;|
$86:925D FD DB 1A    SBC $1ADB,x            ;} Enemy projectile Y position -= [enemy projectile Y speed]
$86:9260 9D 93 1A    STA $1A93,x            ;/
$86:9263 BD FF 1A    LDA $1AFF,x            ;\
$86:9266 3A          DEC A                  ;} Decrement enemy projectile timer
$86:9267 9D FF 1A    STA $1AFF,x            ;/
$86:926A D0 03       BNE $03    [$926F]     ; If [enemy projectile timer] = 0:
$86:926C 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:926F 60          RTS
}


;;; $9270: Instruction - spawn enemy drops with Crocomire's drop chances ;;;
{
$86:9270 5A          PHY
$86:9271 DA          PHX
$86:9272 BD 4B 1A    LDA $1A4B,x[$7E:1A69]  ;\
$86:9275 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:9277 BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;\
$86:927A 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:927C A9 BF DD    LDA #$DDBF             ; A = $DDBF (Crocomire)
$86:927F 22 0E 92 A0 JSL $A0920E[$A0:920E]  ; Spawn enemy drops
$86:9283 FA          PLX
$86:9284 7A          PLY
$86:9285 60          RTS
}


;;; $9286: Initialisation AI - enemy projectile $8F9D (Crocomire bridge crumbling) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X position
$86:9286 DA          PHX                    ;\
$86:9287 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} >_<;
$86:928A AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:928D 99 4B 1A    STA $1A4B,y[$7E:1A5B]  ;} Enemy projectile X position = [enemy projectile initialisation parameter 0]
$86:9290 A9 BB 00    LDA #$00BB             ;\
$86:9293 99 93 1A    STA $1A93,y[$7E:1AA3]  ;} Enemy projectile Y position = BBh
$86:9296 A9 00 00    LDA #$0000             ;\
$86:9299 99 6F 1A    STA $1A6F,y[$7E:1A7F]  ;} Enemy projectile Y subposition = 0
$86:929C 99 27 1A    STA $1A27,y[$7E:1A37]
$86:929F A9 00 00    LDA #$0000             ; >_<;
$86:92A2 99 B7 1A    STA $1AB7,y[$7E:1AC7]
$86:92A5 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:92A8 29 3F 00    AND #$003F             ;|
$86:92AB 18          CLC                    ;} Enemy projectile Y velocity = 40h + [random number] % 40h
$86:92AC 69 40 00    ADC #$0040             ;|
$86:92AF 99 DB 1A    STA $1ADB,y[$7E:1AEB]  ;/
$86:92B2 A9 00 04    LDA #$0400             ;\
$86:92B5 99 BB 19    STA $19BB,y[$7E:19CB]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:92B8 FA          PLX
$86:92B9 60          RTS
}


;;; $92BA: Pre-instruction - enemy projectile $8F9D (Crocomire bridge crumbling) ;;;
{
$86:92BA 08          PHP
$86:92BB C2 20       REP #$20
$86:92BD 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:92C0 B0 0F       BCS $0F    [$92D1]     ; If no collision:
$86:92C2 BD DB 1A    LDA $1ADB,x[$7E:1AEB]  ;\
$86:92C5 18          CLC                    ;|
$86:92C6 69 18 00    ADC #$0018             ;} Enemy projectile Y velocity += 18h
$86:92C9 29 FF 3F    AND #$3FFF             ;|
$86:92CC 9D DB 1A    STA $1ADB,x[$7E:1AEB]  ;/
$86:92CF 28          PLP
$86:92D0 60          RTS                    ; Return

$86:92D1 9E 97 19    STZ $1997,x[$7E:19A7]  ; Enemy projectile ID = 0
$86:92D4 28          PLP
$86:92D5 60          RTS
}
}


;;; $92D6: Move enemy projectile according to enemy projectile velocity ;;;
{
; Uses [enemy projectile $1AB7] / 100h as X velocity
; Uses [enemy projectile $1ADB] / 100h as Y velocity
; Uses enemy projectile $1A28 as 1/100h px X subposition
; Uses enemy projectile $1A70 as 1/100h px Y subposition
$86:92D6 BD B7 1A    LDA $1AB7,x[$7E:1AC1]  ;\
$86:92D9 E2 20       SEP #$20               ;|
$86:92DB 18          CLC                    ;|
$86:92DC 7D 28 1A    ADC $1A28,x[$7E:1A32]  ;} Enemy projectile $1A28 += [enemy projectile $1AB7 low]
$86:92DF 9D 28 1A    STA $1A28,x[$7E:1A32]  ;|
$86:92E2 C2 20       REP #$20               ;/
$86:92E4 29 00 FF    AND #$FF00             ;\
$86:92E7 EB          XBA                    ;|
$86:92E8 10 03       BPL $03    [$92ED]     ;|
$86:92EA 09 00 FF    ORA #$FF00             ;} Enemy projectile X position += [enemy projectile $1AB7 high] + carry
                                            ;|
$86:92ED 7D 4B 1A    ADC $1A4B,x[$7E:1A55]  ;|
$86:92F0 9D 4B 1A    STA $1A4B,x[$7E:1A55]  ;/
}


;;; $92F3: Move enemy projectile according to enemy projectile Y velocity ;;;
{
; Uses [enemy projectile $1ADB] / 100h as Y velocity
; Uses enemy projectile $1A70 as 1/100h px Y subposition (or equivalently enemy projectile $1A6F as 1/10000h px Y subposition)
$86:92F3 BD DB 1A    LDA $1ADB,x[$7E:1AF5]  ;\
$86:92F6 E2 20       SEP #$20               ;|
$86:92F8 18          CLC                    ;|
$86:92F9 7D 70 1A    ADC $1A70,x[$7E:1A8A]  ;} Enemy projectile $1A70 += [enemy projectile $1ADB low]
$86:92FC 9D 70 1A    STA $1A70,x[$7E:1A8A]  ;|
$86:92FF C2 20       REP #$20               ;/
$86:9301 29 00 FF    AND #$FF00             ;\
$86:9304 EB          XBA                    ;|
$86:9305 10 03       BPL $03    [$930A]     ;|
$86:9307 09 00 FF    ORA #$FF00             ;} Enemy projectile Y position += [enemy projectile $1ADB high] + carry
                                            ;|
$86:930A 7D 93 1A    ADC $1A93,x[$7E:1AAD]  ;|
$86:930D 9D 93 1A    STA $1A93,x[$7E:1AAD]  ;/
$86:9310 60          RTS
}


;;; $9311: Move enemy projectile according to enemy projectile X velocity ;;;
{
; Uses [enemy projectile $1AB7] / 100h as X velocity
; Uses enemy projectile $1A28 as 1/100h px X subposition (or equivalently enemy projectile $1A27 as 1/10000h px X subposition)
$86:9311 BD B7 1A    LDA $1AB7,x[$7E:1AD3]  ;\
$86:9314 E2 20       SEP #$20               ;|
$86:9316 18          CLC                    ;|
$86:9317 7D 28 1A    ADC $1A28,x[$7E:1A44]  ;} Enemy projectile $1A28 += [enemy projectile $1AB7 low]
$86:931A 9D 28 1A    STA $1A28,x[$7E:1A44]  ;|
$86:931D C2 20       REP #$20               ;/
$86:931F 29 00 FF    AND #$FF00             ;\
$86:9322 EB          XBA                    ;|
$86:9323 10 03       BPL $03    [$9328]     ;|
$86:9325 09 00 FF    ORA #$FF00             ;} Enemy projectile X position += [enemy projectile $1AB7 high] + carry
                                            ;|
$86:9328 7D 4B 1A    ADC $1A4B,x[$7E:1A67]  ;|
$86:932B 9D 4B 1A    STA $1A4B,x[$7E:1A67]  ;/
$86:932E 60          RTS
}


;;; $932F..96DB: Ridley's fireball / afterburn ;;;
{
;;; $932F: Set Ridley's fireball / afterburn damage ;;;
{
;; Parameters:
;;     X: Pointer to enemy projectile properties values
;;     Y: Enemy projectile index
$86:932F AD 9F 07    LDA $079F  [$7E:079F]  ;\
$86:9332 C9 02 00    CMP #$0002             ;} If [area index] = Norfair: go to BRANCH_NORFAIR
$86:9335 F0 0F       BEQ $0F    [$9346]     ;/
$86:9337 C9 05 00    CMP #$0005             ;\
$86:933A F0 05       BEQ $05    [$9341]     ;} If [area index] = Tourian: go to BRANCH_TOURIAN
$86:933C BD 00 00    LDA $0000,x            ; Enemy projectile properties = [[X]]
$86:933F 80 08       BRA $08    [$9349]     ; Return

; BRANCH_TOURIAN
$86:9341 BD 04 00    LDA $0004,x[$86:940C]  ; Enemy projectile properties = [[X] + 4]
$86:9344 80 03       BRA $03    [$9349]     ; Return

; BRANCH_NORFAIR
$86:9346 BD 02 00    LDA $0002,x[$86:940A]  ; Enemy projectile properties = [[X] + 2]

$86:9349 99 D7 1B    STA $1BD7,y[$7E:1BF7]
$86:934C 60          RTS
}


;;; $934D: Initialisation AI - enemy projectile $9634 (unused) ;;;
{
$86:934D A9 00 00    LDA #$0000             ;\
$86:9350 99 FF 1A    STA $1AFF,y            ;} Enemy projectile movement delay timer = 0
$86:9353 99 23 1B    STA $1B23,y
$86:9356 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9359 18          CLC                    ;|
$86:935A 69 E3 FF    ADC #$FFE3             ;} Enemy projectile X position = [enemy 0 X position] - 1Dh
$86:935D 99 4B 1A    STA $1A4B,y            ;/
$86:9360 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:9363 18          CLC                    ;|
$86:9364 69 DD FF    ADC #$FFDD             ;} Enemy projectile Y position = [enemy 0 Y position] - 23h
$86:9367 99 93 1A    STA $1A93,y            ;/
$86:936A A9 00 0A    LDA #$0A00             ;\
$86:936D 99 BB 19    STA $19BB,y            ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:9370 AD B4 0F    LDA $0FB4  [$7E:0FB4]  ;\
$86:9373 0A          ASL A                  ;} X = [enemy 0 $0FB4] * 2
$86:9374 AA          TAX                    ;/
$86:9375 BD 82 93    LDA $9382,x            ;\
$86:9378 99 B7 1A    STA $1AB7,y            ;} Enemy projectile X velocity = [$9382 + [X]]
$86:937B BD 8A 93    LDA $938A,x            ;\
$86:937E 99 DB 1A    STA $1ADB,y            ;} Enemy projectile Y velocity = [$938A + [X]]
$86:9381 60          RTS

$86:9382             dw FE00, FE10, FE44, FE96 ; X velocities
$86:938A             dw 0000, 0088, 00FC, 016A ; Y velocities
}


;;; $9392: Pre-instruction - enemy projectile $9634 (unused) ;;;
{
$86:9392 BD FF 1A    LDA $1AFF,x            ;\
$86:9395 C9 08 00    CMP #$0008             ;} If [enemy projectile movement delay timer] < 8:
$86:9398 B0 04       BCS $04    [$939E]     ;/
$86:939A FE FF 1A    INC $1AFF,x            ; Increment enemy projectile movement delay timer
$86:939D 60          RTS                    ; Return

$86:939E 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:93A1 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:93A4 B0 01       BCS $01    [$93A7]     ; If no collision:
$86:93A6 60          RTS                    ; Return

$86:93A7 A9 74 95    LDA #$9574             ;\
$86:93AA 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $9574 (afterburn - final)
$86:93AD FE FF 1A    INC $1AFF,x            ; Increment enemy projectile movement delay timer
$86:93B0 A9 01 00    LDA #$0001             ;\
$86:93B3 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:93B6 9E B7 1A    STZ $1AB7,x            ; Enemy projectile X velocity = 0
$86:93B9 9E DB 1A    STZ $1ADB,x            ; Enemy projectile Y velocity = 0
$86:93BC A9 00 0A    LDA #$0A00             ;\
$86:93BF 9D BB 19    STA $19BB,x            ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:93C2 A9 2B 00    LDA #$002B             ;\
$86:93C5 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Bh, sound library 2, max queued sounds allowed = 6 (Ridley's fireball hit surface)
$86:93C9 60          RTS
}


;;; $93CA: Initialisation AI - enemy projectile $9642 (Ridley's fireball) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Ridley facing direction. 0 = left, otherwise = right
;;     $1995: Afterburn flag. 0 = spawn afterburn
$86:93CA AD 95 19    LDA $1995  [$7E:1995]  ;\
$86:93CD 99 23 1B    STA $1B23,y[$7E:1B43]  ;} Enemy projectile afterburn flag = [enemy projectile initialisation parameter 1]
$86:93D0 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:93D3 D0 05       BNE $05    [$93DA]     ;} If [enemy projectile initialisation parameter 0] = 0:
$86:93D5 A9 E7 FF    LDA #$FFE7             ; A = -19h
$86:93D8 80 03       BRA $03    [$93DD]
                                            ; Else ([enemy projectile initialisation parameter 0] != 0):
$86:93DA A9 19 00    LDA #$0019             ; A = 19h

$86:93DD 18          CLC                    ;\
$86:93DE 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} Enemy projectile X position = [enemy 0 X position] + [A]
$86:93E1 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:93E4 A9 D5 FF    LDA #$FFD5             ;\
$86:93E7 18          CLC                    ;|
$86:93E8 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} Enemy projectile Y position = [enemy 0 Y position] - 2Bh
$86:93EB 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:93EE A9 00 0A    LDA #$0A00             ;\
$86:93F1 99 BB 19    STA $19BB,y[$7E:19DB]  ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:93F4 AF 32 78 7E LDA $7E7832[$7E:7832]  ;\
$86:93F8 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile X velocity = [$7E:7832]
$86:93FB AF 34 78 7E LDA $7E7834[$7E:7834]  ;\
$86:93FF 99 DB 1A    STA $1ADB,y[$7E:1AFB]  ;} Enemy projectile Y velocity = [$7E:7834]
}


;;; $9402: Set Ridley's fireball / afterburn properties ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
$86:9402 A2 08 94    LDX #$9408             ; X = $9408
$86:9405 4C 2F 93    JMP $932F  [$86:932F]  ; Go to set Ridley's fireball / afterburn damage

; Enemy projectile properties values
; 5000h = don't detect collisions with projectiles, don't die on contact, enable collisions with Samus, high priority
$86:9408             dw 5003, ; Default
                        503C, ; Norfair
                        5050  ; Tourian
}


;;; $940E: Pre-instruction - enemy projectile $9642 (Ridley's fireball) ;;;
{
$86:940E 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9411 B0 0B       BCS $0B    [$941E]     ; If collision: go to BRANCH_HIT_WALL
$86:9413 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9416 B0 01       BCS $01    [$9419]     ; If no collision:
$86:9418 60          RTS                    ; Return

$86:9419 A0 50 96    LDY #$9650             ; Y = $9650 (horizontal afterburn - centre)
$86:941C 80 03       BRA $03    [$9421]     ; Go to BRANCH_MERGE

; BRANCH_HIT_WALL
$86:941E A0 5E 96    LDY #$965E             ; Y = $965E (vertical afterburn - centre)

; BRANCH_MERGE
$86:9421 9E 97 19    STZ $1997,x[$7E:19B7]  ; Enemy projectile ID = 0
$86:9424 BD 23 1B    LDA $1B23,x[$7E:1B43]  ;\
$86:9427 D0 18       BNE $18    [$9441]     ;} If [enemy projectile afterburn flag] = 0:
$86:9429 BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:942C 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:942E BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:9431 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:9433 A9 03 00    LDA #$0003             ; A = 3 (number of afterburn enemy projectiles)
$86:9436 22 97 80 86 JSL $868097[$86:8097]  ; Spawn enemy projectile [Y]
$86:943A A9 2B 00    LDA #$002B             ;\
$86:943D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Bh, sound library 2, max queued sounds allowed = 6 (Ridley's fireball hit surface)

$86:9441 60          RTS
}


;;; $9442: Unused. Do fireball damage to Samus and turn into smoke ;;;
{
$86:9442 A9 5F 94    LDA #$945F             ;\
$86:9445 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $945F
$86:9448 A9 01 00    LDA #$0001             ;\
$86:944B 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:944E A9 03 00    LDA #$0003             ; A = 3
$86:9451 AC 9F 07    LDY $079F  [$7E:079F]  ;\
$86:9454 C0 02 00    CPY #$0002             ;} If [area index] = Norfair:
$86:9457 D0 03       BNE $03    [$945C]     ;/
$86:9459 A9 3C 00    LDA #$003C             ; A = 60

$86:945C 4C 5C C3    JMP $C35C  [$86:C35C]  ; Go to hurt Samus
}


;;; $945F: Unused. Instruction list - smoke ;;;
{
; Used by unused routine $9442
$86:945F             dx 9475,       ; Disable collisions with Samus
                        816A,       ; Clear pre-instruction
                        0008,B250,
                        0008,B257,
                        0008,B25E,
                        0008,B265,
                        8154        ; Delete
}


;;; $9475: Unused. Instruction - disable collisions with Samus ;;;
{
; Used by unused instruction list $945F
$86:9475 BD D7 1B    LDA $1BD7,x
$86:9478 09 00 20    ORA #$2000
$86:947B 9D D7 1B    STA $1BD7,x
$86:947E 60          RTS
}


;;; $947F: Initialisation AI - enemy projectile $9650/$965E (afterburn - centre) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Number of afterburn enemy projectiles
$86:947F BB          TYX                    ; X = [enemy projectile index]
$86:9480 A9 00 0A    LDA #$0A00             ;\
$86:9483 9D BB 19    STA $19BB,x[$7E:19DB]  ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:9486 A5 12       LDA $12    [$7E:0012]  ;\
$86:9488 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;} Enemy projectile X position = [$12]
$86:948B A5 14       LDA $14    [$7E:0014]  ;\
$86:948D 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;} Enemy projectile Y position = [$14]
$86:9490 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:9493 9D FF 1A    STA $1AFF,x[$7E:1B1F]  ;} Enemy projectile remaining afterburn enemy projectiles = [enemy projectile initialisation parameter 0]
$86:9496 9E 23 1B    STZ $1B23,x[$7E:1B43]
$86:9499 9E B7 1A    STZ $1AB7,x[$7E:1AD7]
$86:949C 9E DB 1A    STZ $1ADB,x[$7E:1AFB]
$86:949F 60          RTS
}


;;; $94A0: Initialisation AI - enemy projectile $9688/$96C0 (vertical afterburn - up) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Old enemy projectile index
$86:94A0 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:94A3 A9 00 00    LDA #$0000             ;\
$86:94A6 99 B7 1A    STA $1AB7,y[$7E:1AD1]  ;} Enemy projectile X velocity = 0
$86:94A9 A9 00 F2    LDA #$F200             ;\
$86:94AC 99 DB 1A    STA $1ADB,y[$7E:1AF5]  ;} Enemy projectile Y velocity = -E00h
$86:94AF A9 88 96    LDA #$9688             ; A = $9688 (vertical afterburn - up)
$86:94B2 80 3A       BRA $3A    [$94EE]     ; Go to common afterburn initialisation
}


;;; $94B4: Initialisation AI - enemy projectile $9696/$96CE (vertical afterburn - down) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Old enemy projectile index
$86:94B4 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:94B7 A9 00 00    LDA #$0000             ;\
$86:94BA 99 B7 1A    STA $1AB7,y[$7E:1ACF]  ;} Enemy projectile X velocity = 0
$86:94BD A9 00 0E    LDA #$0E00             ;\
$86:94C0 99 DB 1A    STA $1ADB,y[$7E:1AF3]  ;} Enemy projectile Y velocity = E00h
$86:94C3 A9 96 96    LDA #$9696             ; A = $9696 (vertical afterburn - down)
$86:94C6 80 26       BRA $26    [$94EE]     ; Go to common afterburn initialisation
}


;;; $94C8: Initialisation AI - enemy projectile $966C/$96A4 (horizontal afterburn - right) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Old enemy projectile index
$86:94C8 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:94CB A9 00 0E    LDA #$0E00             ;\
$86:94CE 99 B7 1A    STA $1AB7,y[$7E:1AD3]  ;} Enemy projectile X velocity = E00h
$86:94D1 A9 00 00    LDA #$0000             ;\
$86:94D4 99 DB 1A    STA $1ADB,y[$7E:1AF7]  ;} Enemy projectile Y velocity = 0
$86:94D7 A9 6C 96    LDA #$966C             ; A = $966C (horizontal afterburn - right)
$86:94DA 80 12       BRA $12    [$94EE]     ; Go to common afterburn initialisation
}


;;; $94DC: Initialisation AI - enemy projectile $967A/$96B2 (horizontal afterburn - left) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Old enemy projectile index
$86:94DC AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:94DF A9 00 F2    LDA #$F200             ;\
$86:94E2 99 B7 1A    STA $1AB7,y[$7E:1AD1]  ;} Enemy projectile X velocity = -E00h
$86:94E5 A9 00 00    LDA #$0000             ;\
$86:94E8 99 DB 1A    STA $1ADB,y[$7E:1AF5]  ;} Enemy projectile Y velocity = 0
$86:94EB A9 7A 96    LDA #$967A             ; A = $967A (horizontal afterburn - left)
}


;;; $94EE: Common afterburn initialisation - right/left/up/down ;;;
{
;; Parameters:
;;     A: Next afterburn enemy projectile ID
;;     X: Old enemy projectile index
;;     Y: Enemy projectile index
$86:94EE 99 23 1B    STA $1B23,y[$7E:1B3D]  ; Enemy projectile next projectile ID = [A]
$86:94F1 BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:94F4 99 4B 1A    STA $1A4B,y[$7E:1A65]  ;} Enemy projectile X position = [old enemy projectile X position]
$86:94F7 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:94FA 99 93 1A    STA $1A93,y[$7E:1AAD]  ;} Enemy projectile Y position = [old enemy projectile Y position]
$86:94FD BD FF 1A    LDA $1AFF,x[$7E:1B1F]  ;\
$86:9500 99 FF 1A    STA $1AFF,y[$7E:1B19]  ;} Enemy projectile remaining afterburn enemy projectiles = [old enemy projectile remaining afterburn enemy projectiles]
$86:9503 A9 00 0A    LDA #$0A00             ;\
$86:9506 99 BB 19    STA $19BB,y[$7E:19D5]  ;} Enemy projectile VRAM graphics index = 0, palette 5
$86:9509 4C 02 94    JMP $9402  [$86:9402]  ; Go to set afterburn properties
}


;;; $950C: RTS. Pre-instruction - enemy projectile $9650/$965E (afterburn - centre) ;;;
{
$86:950C 60          RTS
}


;;; $950D: Pre-instruction - enemy projectile $966C/$967A (horizontal afterburn - right/left) ;;;
{
$86:950D 20 11 93    JSR $9311  [$86:9311]  ; Move enemy projectile according to enemy projectile X velocity
$86:9510 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9513 90 0C       BCC $0C    [$9521]     ; If collision:
$86:9515 A9 74 95    LDA #$9574             ;\
$86:9518 9D 47 1B    STA $1B47,x[$7E:1B5F]  ;} Enemy projectile instruction list pointer = $9574 (afterburn - final)
$86:951B A9 01 00    LDA #$0001             ;\
$86:951E 9D 8F 1B    STA $1B8F,x[$7E:1BA7]  ;} Enemy projectile instruction timer = 1

$86:9521 60          RTS
}


;;; $9522: Pre-instruction - enemy projectile $9688/$9696 (vertical afterburn - up/down) ;;;
{
$86:9522 20 F3 92    JSR $92F3  [$86:92F3]  ; Move enemy projectile according to enemy projectile Y velocity
$86:9525 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9528 90 0C       BCC $0C    [$9536]     ; If collision:
$86:952A A9 74 95    LDA #$9574             ;\
$86:952D 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $9574 (afterburn - final)
$86:9530 A9 01 00    LDA #$0001             ;\
$86:9533 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1

$86:9536 60          RTS
}


;;; $9537: Pre-instruction - enemy projectile $96A4/$96B2 (unused. Proto horizontal afterburn - right/left) ;;;
{
$86:9537 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:953A 90 03       BCC $03    [$953F]     ; If collision:
$86:953C 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:953F 60          RTS
}


;;; $9540: Pre-instruction - enemy projectile $96C0 (unused. Proto vertical afterburn - up) ;;;
{
$86:9540 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9543 90 03       BCC $03    [$9548]     ; If collision:
$86:9545 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:9548 60          RTS
}


;;; $9549: Pre-instruction - enemy projectile $96CE (unused. Proto vertical afterburn - down) ;;;
{
; Clone of $9540
$86:9549 20 7B 89    JSR $897B  [$86:897B]
$86:954C 90 03       BCC $03    [$9551]
$86:954E 9E 97 19    STZ $1997,x

$86:9551 60          RTS
}


;;; $9552: Instruction list - enemy projectile $9634/$9642 (Ridley's fireball) ;;;
{
; Doesn't really make sense to use this instruction list with enemy projectile $9634

$86:9552             dx 816A,       ; Clear pre-instruction
                        0004,80CA,
                        8161,940E,  ; Pre-instruction = $940E (moving)
                        0004,80CA
$86:9560             dx 0002,80CA,
                        0002,80D1,
                        0002,80D8,
                        0002,80DF,
                        81AB,9560   ; Go to $9560
}


;;; $9574: Instruction list - afterburn - final ;;;
{
$86:9574             dx 816A,       ; Clear pre-instruction
                        0005,80E6,
                        0005,80ED,
                        0005,80F4,
                        0005,80FB,
                        0005,8102,
                        8154        ; Delete
}


;;; $958C: Unused. Instruction list ;;;
{
; References graphics not in Ridley or Mother Brain's VRAM
; But looks like an 8x8 px² version of the $9560 instruction loop
$86:958C             dx 0002,80AE,
                        0002,80B5,
                        0002,80BC,
                        0002,80C3,
                        81AB,958C   ; Go to $958C
}


;;; $95A0: Instruction list - enemy projectile $9650 (horizontal afterburn - centre) ;;;
{
$86:95A0             dx 816A,       ; Clear pre-instruction
                        0005,80E6,
                        95BA,       ; Spawn horizontal afterburn enemy projectiles
                        0005,80ED,
                        0005,80F4,
                        0005,80FB,
                        0005,8102,
                        8154        ; Delete
}


;;; $95BA: Instruction - spawn horizontal afterburn enemy projectiles ;;;
{
$86:95BA 5A          PHY
$86:95BB 9C 95 19    STZ $1995  [$7E:1995]  ; Enemy projectile initialisation parameter 1 = 0
$86:95BE 8A          TXA                    ; A = [enemy projectile index]
$86:95BF A0 6C 96    LDY #$966C             ;\
$86:95C2 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn horizontal afterburn - right enemy projectile
$86:95C6 9C 95 19    STZ $1995  [$7E:1995]  ; Enemy projectile initialisation parameter 1 = 0
$86:95C9 8A          TXA                    ; A = [enemy projectile index]
$86:95CA A0 7A 96    LDY #$967A             ;\
$86:95CD 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn horizontal afterburn - left enemy projectile
$86:95D1 7A          PLY
$86:95D2 60          RTS
}


;;; $95D3: Instruction list - enemy projectile $965E (vertical afterburn - centre) ;;;
{
$86:95D3             dx 816A,       ; Clear pre-instruction
                        0005,80E6,
                        95ED,       ; Spawn vertical afterburn enemy projectiles
                        0005,80ED,
                        0005,80F4,
                        0005,80FB,
                        0005,8102,
                        8154        ; Delete
}


;;; $95ED: Instruction - spawn vertical afterburn enemy projectiles ;;;
{
$86:95ED 5A          PHY
$86:95EE 9C 95 19    STZ $1995  [$7E:1995]  ; Enemy projectile initialisation parameter 1 = 0
$86:95F1 8A          TXA                    ; A = [enemy projectile index]
$86:95F2 A0 88 96    LDY #$9688             ;\
$86:95F5 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn vertical afterburn - up enemy projectile
$86:95F9 9C 95 19    STZ $1995  [$7E:1995]  ; Enemy projectile initialisation parameter 1 = 0
$86:95FC 8A          TXA                    ; A = [enemy projectile index]
$86:95FD A0 96 96    LDY #$9696             ;\
$86:9600 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn vertical afterburn - down enemy projectile
$86:9604 7A          PLY
$86:9605 60          RTS
}


;;; $9606: Instruction list - enemy projectile $966C/$967A/$9688/$9696/$96A4/$96B2/$96C0/$96CE (afterburn - right/left/up/down) ;;;
{
$86:9606             dx 816A,       ; Clear pre-instruction
                        0005,80E6,
                        9620,       ; Spawn next afterburn enemy projectile
                        0005,80ED,
                        0005,80F4,
                        0005,80FB,
                        0005,8102,
                        8154        ; Delete
}


;;; $9620: Instruction - spawn next afterburn enemy projectile ;;;
{
$86:9620 E2 20       SEP #$20
$86:9622 DE FF 1A    DEC $1AFF,x[$7E:1B19]  ; Decrement enemy projectile remaining afterburn enemy projectiles
$86:9625 C2 20       REP #$20
$86:9627 30 0A       BMI $0A    [$9633]     ; If [enemy projectile remaining afterburn enemy projectiles] >= 0:
$86:9629 5A          PHY
$86:962A 8A          TXA                    ; A = [enemy projectile index]
$86:962B BC 23 1B    LDY $1B23,x[$7E:1B3D]  ;\
$86:962E 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn enemy projectile [enemy projectile next projectile ID]
$86:9632 7A          PLY

$86:9633 60          RTS
}


;;; $9634: Enemy projectiles - Ridley / afterburn ;;;
{
; Enemy projectile $9634 seems to be a version of the fireball that has no afterburn
; It's fired at one of 4 down-left angles, the angle and its spawn position depend on enemy 0
; It's possible that it was intended to use the unused instruction list $958C, which uses 8x8 sprites
; Hard to guess what this must have been for, but I would guess an abandoned version of Ceres Ridley's fireballs

; Enemy projectiles $96A4/B2/C0/CE are just the same as $966C/7A/88/96 except they instantly delete themselves on collision instead of playing the $9574 animation

; Note that Mother Brain's bombs also spawn the afterburn, not just Ridley's fireballs


;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:9634             dx 934D,9392,9552,06,06,1003,0000,84FC ; Unused
$86:9642             dx 93CA,940E,9552,06,06,5003,0000,84FC ; Ridley's fireball. Properties ignored
$86:9650             dx 947F,950C,95A0,06,06,5003,0000,84FC ; Horizontal afterburn - centre
$86:965E             dx 947F,950C,95D3,06,06,5003,0000,84FC ; Vertical afterburn - centre
$86:966C             dx 94C8,950D,9606,06,06,5003,0000,84FC ; Horizontal afterburn - right. Properties ignored
$86:967A             dx 94DC,950D,9606,06,06,5003,0000,84FC ; Horizontal afterburn - left. Properties ignored
$86:9688             dx 94A0,9522,9606,06,06,5003,0000,84FC ; Vertical afterburn - up. Properties ignored
$86:9696             dx 94B4,9522,9606,06,06,5003,0000,84FC ; Vertical afterburn - down. Properties ignored
$86:96A4             dx 94C8,9537,9606,06,06,5003,0000,84FC ; Unused. Proto horizontal afterburn - right. Properties ignored
$86:96B2             dx 94DC,9537,9606,06,06,5003,0000,84FC ; Unused. Proto horizontal afterburn - left. Properties ignored
$86:96C0             dx 94A0,9540,9606,06,06,5003,0000,84FC ; Unused. Proto vertical afterburn - up. Properties ignored
$86:96CE             dx 94B4,9549,9606,06,06,5003,0000,84FC ; Unused. Proto vertical afterburn - down. Properties ignored
}
}


;;; $96DC..975B: Ceres falling debris ;;;
{
;;; $96DC: Initialisation AI - enemy projectile $9734/$9742 (Ceres falling debris) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X position
$86:96DC A9 00 00    LDA #$0000
$86:96DF 99 FF 1A    STA $1AFF,y[$7E:1B21]
$86:96E2 99 23 1B    STA $1B23,y[$7E:1B45]
$86:96E5 99 B7 1A    STA $1AB7,y[$7E:1AD9]
$86:96E8 A9 00 0E    LDA #$0E00             ;\
$86:96EB 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 7
$86:96EE AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:96F1 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [enemy projectile initialisation parameter 0]
$86:96F4 A9 2A 00    LDA #$002A             ;\
$86:96F7 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = 2Ah
$86:96FA A9 10 00    LDA #$0010             ;\
$86:96FD 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = 10h
$86:9700 60          RTS
}


;;; $9701: Pre-instruction - enemy projectile $9734/$9742 (Ceres falling debris) ;;;
{
$86:9701 A9 10 00    LDA #$0010             ;\
$86:9704 18          CLC                    ;|
$86:9705 7D DB 1A    ADC $1ADB,x[$7E:1AFD]  ;} Enemy projectile Y velocity += 10h
$86:9708 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:970B 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:970E B0 01       BCS $01    [$9711]     ; If no collision:
$86:9710 60          RTS                    ; Return

$86:9711 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:9714 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:9717 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:9719 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:971C 18          CLC                    ;|
$86:971D 69 00 00    ADC #$0000             ;} $14 = [enemy projectile Y position]
$86:9720 85 14       STA $14    [$7E:0014]  ;/
$86:9722 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$86:9725 A0 09 E5    LDY #$E509             ;\
$86:9728 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:972C A9 6D 00    LDA #$006D             ;\
$86:972F 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 6Dh, sound library 2, max queued sounds allowed = 6 (Ceres tiles falling from ceiling)
$86:9733 60          RTS
}


;;; $9734: Enemy projectiles - Ceres falling debris ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:9734             dx 96DC,9701,9750,08,08,4000,0000,84FC ; Ceres falling debris - light coloured
$86:9742             dx 96DC,9701,9756,08,08,4000,0000,84FC ; Ceres falling debris - dark coloured
}


;;; $9750: Instruction list - enemy projectile $9734 (Ceres falling debris - light coloured) ;;;
{
$86:9750             dx 0001,8ABF,
                        8159        ; Sleep
}


;;; $9756: Instruction list - enemy projectile $9742 (Ceres falling debris - dark coloured) ;;;
{
$86:9756             dx 0001,8AC6,
                        8159        ; Sleep
}
}


;;; $975C..9C44: Phantoon flames ;;;
{
;;; $975C: Instruction list - Phantoon destroyable flame - idle ;;;
{
$86:975C             dx 0005,819C,
                        0005,81A8,
                        0005,81B4,
                        81AB,975C   ; Go to $975C
}


;;; $976C: Instruction list - Phantoon destroyable flame - casual flame - hit ground ;;;
{
$86:976C             dx 0001,81C0,
                        8159        ; Sleep
}


;;; $9772: Instruction list - Phantoon destroyable flame - casual flame - bouncing ;;;
{
$86:9772             dx 0005,819C,
                        0005,81A8,
                        0005,81B4,
                        81AB,9772   ; Go to $9772
}


;;; $9782: Instruction list - Phantoon destroyable flame - casual flame - resting ;;;
{
$86:9782             dx 0005,8220,
                        0005,822C,
                        0005,8238,
                        0005,8244,
                        0005,8250,
                        0005,825C
}


;;; $979A: Instruction list - Phantoon destroyable flame - dying ;;;
{
$86:979A             dw 0005,81CC,
                        0005,81D8,
                        0005,81E4,
                        0005,81F0,
                        8154        ; Delete
}


;;; $97AC: Instruction list - Phantoon destroyable flame - flame rain - falling ;;;
{
$86:97AC             dx 0008,81C0,
                        81AB,979A   ; Go to $979A (dying)
}


;;; $97B4: Instruction list - Phantoon destroyable flame - casual flame - falling ;;;
{
$86:97B4             dx 81D5,0004,  ; Timer = 4
$86:97B8             dx 0001,81FC,
                        0001,8000,
                        81C6,97B8,  ; Decrement timer and go to $97B8 if non-zero
                        81D5,0004,  ; Timer = 4
$86:97C8             dx 0001,8208,
                        0001,8000,
                        81C6,97C8,  ; Decrement timer and go to $97C8 if non-zero
                        81D5,0004,  ; Timer = 4
$86:97D8             dx 0001,8214,
                        0001,8000,
                        81C6,97D8,  ; Decrement timer and go to $97D8 if non-zero
                        81AB,97B4   ; Go to $97B4
}


;;; $97E8: Instruction list - enemy projectile $9C37 (Phantoon starting flames) ;;;
{
$86:97E8             dx 0005,81FC,
                        0005,8208,
                        0005,8214,
                        81AB,97E8   ; Go to $97E8
}


;;; $97F8: Instruction list - delete ;;;
{
$86:97F8             dx 8154        ; Delete
}


;;; $97FA: Shot instruction list - enemy projectile $9C29 (Phantoon destroyable flames) ;;;
{
$86:97FA             dx 0005,81CC,
                        0005,81D8,
                        0005,81E4,
                        0005,81F0,
                        980E,       ; Spawn Phantoon drop
                        8154        ; Delete
}


;;; $980E: Instruction - spawn Phantoon drop ;;;
{
$86:980E 5A          PHY
$86:980F DA          PHX
$86:9810 BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:9813 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:9815 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:9818 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:981A A9 FF E4    LDA #$E4FF             ;\
$86:981D 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn Phantoon eye enemy drops
$86:9821 FA          PLX
$86:9822 7A          PLY
$86:9823 60          RTS
}


;;; $9824: Initialisation AI - enemy projectile $9C29 (Phantoon destroyable flames) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993:
;;         0000: Casual flame
;;         020i: Enraged flame
;;             i: Direction index. 0..7 are clockwise with initial angle 10h + i * 10h, 8..Fh are anti-clockwise with initial angle F0h - (i - 8) * 10h
;;         04dx: Flame rain
;;             x: X position index. X position = 30h + x * 14h
;;             d: Fall delay. Fall timer = d * 8
;;         060v: Flame spiral
;;             i: Direction index. Initial angle = i * 20h
$86:9824 08          PHP
$86:9825 C2 30       REP #$30
$86:9827 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:982A 29 00 FF    AND #$FF00             ;|
$86:982D EB          XBA                    ;} Go to [$9832 + [enemy initialisation parameter high]]
$86:982E AA          TAX                    ;|
$86:982F 7C 32 98    JMP ($9832,x)[$86:983A];/

$86:9832             dw 983A, 986D, 98C4, 9900
}


;;; $983A: Phantoon destroyable flame initialisation - type 0 (casual flame) ;;;
{
$86:983A A9 00 00    LDA #$0000             ;\
$86:983D 99 27 1A    STA $1A27,y[$7E:1A49]  ;} Enemy projectile X subposition
$86:9840 99 6F 1A    STA $1A6F,y[$7E:1A91]  ; Enemy projectile Y subposition
$86:9843 99 B7 1A    STA $1AB7,y[$7E:1AD9]
$86:9846 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ; Enemy projectile Y velocity
$86:9849 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:984C 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [Phantoon body X position]
$86:984F AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:9852 18          CLC                    ;|
$86:9853 69 20 00    ADC #$0020             ;} Enemy projectile Y position = [Phantoon body Y position] + 20h
$86:9856 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:9859 A9 B4 97    LDA #$97B4             ;\
$86:985C 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $97B4 (casual flame - falling)
$86:985F B9 D7 1B    LDA $1BD7,y[$7E:1BF9]  ;\
$86:9862 29 FF 0F    AND #$0FFF             ;|
$86:9865 09 00 20    ORA #$2000             ;} Disable projectile collisions, die on contact, disable Samus collisions, low priority
$86:9868 99 D7 1B    STA $1BD7,y[$7E:1BF9]  ;/
$86:986B 28          PLP
$86:986C 60          RTS
}


;;; $986D: Phantoon destroyable flame initialisation - type 2 (enraged flame) ;;;
{
$86:986D A9 00 00    LDA #$0000
$86:9870 99 27 1A    STA $1A27,y
$86:9873 99 6F 1A    STA $1A6F,y
$86:9876 99 DB 1A    STA $1ADB,y            ; Enemy projectile radius = 0
$86:9879 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:987C 29 FF 00    AND #$00FF             ;} X = [enemy projectile initialisation parameter low]
$86:987F AA          TAX                    ;/
$86:9880 E0 08 00    CPX #$0008             ;\
$86:9883 10 08       BPL $08    [$988D]     ;} If [X] < 8:
$86:9885 A9 02 00    LDA #$0002             ;\
$86:9888 99 B7 1A    STA $1AB7,y            ;} Enemy projectile angle delta = 2
$86:988B 80 06       BRA $06    [$9893]

$86:988D A9 FE FF    LDA #$FFFE             ;\ Else ([X] >= 8):
$86:9890 99 B7 1A    STA $1AB7,y            ;} Enemy projectile angle delta = -2

$86:9893 BD B4 98    LDA $98B4,x            ;\
$86:9896 29 FF 00    AND #$00FF             ;} Enemy projectile angle = [$98B4 + [X]]
$86:9899 99 FF 1A    STA $1AFF,y            ;/
$86:989C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:989F 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [Phantoon body X position]
$86:98A2 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:98A5 18          CLC                    ;|
$86:98A6 69 20 00    ADC #$0020             ;} Enemy projectile Y position = [Phantoon body Y position] + 20h
$86:98A9 99 93 1A    STA $1A93,y            ;/
$86:98AC A9 45 9A    LDA #$9A45             ;\
$86:98AF 99 03 1A    STA $1A03,y            ;} Enemy projectile pre-instruction = $9A45
$86:98B2 28          PLP
$86:98B3 60          RTS

$86:98B4             db 10, 20, 30, 40, 50, 60, 70, 80,
                        F0, E0, D0, C0, B0, A0, 90, 80
}


;;; $98C4: Phantoon destroyable flame initialisation - type 4 (flame rain) ;;;
{
$86:98C4 A9 00 00    LDA #$0000
$86:98C7 99 27 1A    STA $1A27,y[$7E:1A45]
$86:98CA 99 6F 1A    STA $1A6F,y[$7E:1A8D]  ; Enemy projectile Y subposition = 0
$86:98CD 99 DB 1A    STA $1ADB,y[$7E:1AF9]  ; Enemy projectile Y velocity = 0
$86:98D0 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:98D3 48          PHA                    ;|
$86:98D4 29 0F 00    AND #$000F             ;} X = [enemy projectile initialisation parameter low] & Fh
$86:98D7 AA          TAX                    ;|
$86:98D8 68          PLA                    ;/
$86:98D9 29 F0 00    AND #$00F0             ;\
$86:98DC 4A          LSR A                  ;} Enemy projectile fall timer = ([enemy projectile initialisation parameter low] >> 4) * 8
$86:98DD 99 B7 1A    STA $1AB7,y[$7E:1AD5]  ;/
$86:98E0 BD F7 98    LDA $98F7,x[$86:98F7]  ;\
$86:98E3 29 FF 00    AND #$00FF             ;} Enemy projectile X position = 30h + 14h * [X]
$86:98E6 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;/
$86:98E9 A9 28 00    LDA #$0028             ;\
$86:98EC 99 93 1A    STA $1A93,y[$7E:1AB1]  ;} Enemy projectile Y position = 28h
$86:98EF A9 94 9A    LDA #$9A94             ;\
$86:98F2 99 03 1A    STA $1A03,y[$7E:1A21]  ;} Enemy projectile pre-instruction = $9A94
$86:98F5 28          PLP
$86:98F6 60          RTS

$86:98F7             db 30, 44, 58, 6C, 80, 94, A8, BC, D0
}


;;; $9900: Phantoon destroyable flame initialisation - type 6 (flame spiral) ;;;
{
$86:9900 A9 00 00    LDA #$0000
$86:9903 99 27 1A    STA $1A27,y[$7E:1A45]
$86:9906 99 6F 1A    STA $1A6F,y[$7E:1A8D]
$86:9909 99 DB 1A    STA $1ADB,y[$7E:1AF9]  ; Enemy projectile radius = 0
$86:990C A9 80 00    LDA #$0080             ;\
$86:990F 99 B7 1A    STA $1AB7,y[$7E:1AD5]  ;} Enemy projectile X velocity = 80h
$86:9912 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:9915 29 FF 00    AND #$00FF             ;|
$86:9918 AA          TAX                    ;|
$86:9919 BD 79 99    LDA $9979,x[$86:9980]  ;} Enemy projectile angle = 20h * [enemy projectile initialisation parameter low]
$86:991C 29 FF 00    AND #$00FF             ;|
$86:991F 99 FF 1A    STA $1AFF,y[$7E:1B1D]  ;/
$86:9922 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9925 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;} Enemy projectile X position = [Phantoon body X position]
$86:9928 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:992B 18          CLC                    ;|
$86:992C 69 10 00    ADC #$0010             ;} Enemy projectile Y position = [Phantoon body Y position] + 10h
$86:992F 99 93 1A    STA $1A93,y[$7E:1AB1]  ;/
$86:9932 A9 DA 9A    LDA #$9ADA             ;\
$86:9935 99 03 1A    STA $1A03,y[$7E:1A21]  ;} Enemy projectile pre-instruction = $9ADA
$86:9938 28          PLP
$86:9939 60          RTS
}


;;; $993A: Initialisation AI - enemy projectile $9C37 (Phantoon starting flames) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction index. Initial angle = i * 20h
$86:993A 08          PHP
$86:993B C2 30       REP #$30
$86:993D A9 00 00    LDA #$0000
$86:9940 99 27 1A    STA $1A27,y[$7E:1A49]
$86:9943 99 6F 1A    STA $1A6F,y[$7E:1A91]
$86:9946 99 B7 1A    STA $1AB7,y[$7E:1AD9]
$86:9949 99 DB 1A    STA $1ADB,y[$7E:1AFD]
$86:994C 5A          PHY
$86:994D AE 93 19    LDX $1993  [$7E:1993]  ;\
$86:9950 BD 79 99    LDA $9979,x[$86:9979]  ;|
$86:9953 29 FF 00    AND #$00FF             ;} Enemy projectile angle = 20h * [enemy projectile initialisation parameter low]
$86:9956 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$86:9959 A8          TAY                    ;\
$86:995A A9 30 00    LDA #$0030             ;} Calculate X/Y components of radius 30h, angle [enemy projectile angle]
$86:995D 20 A2 9B    JSR $9BA2  [$86:9BA2]  ;/
$86:9960 7A          PLY
$86:9961 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9964 18          CLC                    ;|
$86:9965 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile X position = [Phantoon body X position] + [$14]
$86:9967 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:996A AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:996D 18          CLC                    ;|
$86:996E 69 10 00    ADC #$0010             ;|
$86:9971 18          CLC                    ;} Enemy projectile Y position = [Phantoon body Y position] + 10h + [$16]
$86:9972 65 16       ADC $16    [$7E:0016]  ;|
$86:9974 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:9977 28          PLP
$86:9978 60          RTS
}


;;; $9979: Phantoon flame angles ;;;
{
$86:9979             db 00, 20, 40, 60, 80, A0, C0, E0
}


;;; $9981: Pre-instruction - Phantoon destroyable flame - casual flame - falling ;;;
{
$86:9981 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:9984 18          CLC                    ;|
$86:9985 69 10 00    ADC #$0010             ;} Enemy projectile Y velocity += 10h
$86:9988 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:998B 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:998E 90 2E       BCC $2E    [$99BE]     ; If collided with block:
$86:9990 BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$86:9993 29 FF 0F    AND #$0FFF             ;|
$86:9996 09 00 80    ORA #$8000             ;} Enable projectile collisions, die on contact, enable Samus collisions, low priority
$86:9999 9D D7 1B    STA $1BD7,x[$7E:1BF9]  ;/
$86:999C A9 BF 99    LDA #$99BF             ;\
$86:999F 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $99BF
$86:99A2 A9 6C 97    LDA #$976C             ;\
$86:99A5 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $976C (casual flame - hit ground)
$86:99A8 A9 01 00    LDA #$0001             ;\
$86:99AB 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:99AE A9 08 00    LDA #$0008             ;\
$86:99B1 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile function timer = 8
$86:99B4 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:99B7 18          CLC                    ;|
$86:99B8 69 08 00    ADC #$0008             ;} Enemy projectile Y position += 8
$86:99BB 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/

$86:99BE 60          RTS
}


;;; $99BF: Pre-instruction - Phantoon destroyable flame - casual flame - hit ground ;;;
{
$86:99BF DE FF 1A    DEC $1AFF,x[$7E:1B21]  ; Decrement enemy projectile function timer
$86:99C2 F0 02       BEQ $02    [$99C6]     ;\
$86:99C4 10 3A       BPL $3A    [$9A00]     ;} If [enemy projectile function timer] > 0: return

$86:99C6 A9 01 9A    LDA #$9A01             ;\
$86:99C9 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $9A01
$86:99CC A9 72 97    LDA #$9772             ;\
$86:99CF 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $9772 (casual flame - bouncing)
$86:99D2 A9 01 00    LDA #$0001             ;\
$86:99D5 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:99D8 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:99DB 38          SEC                    ;|
$86:99DC E9 08 00    SBC #$0008             ;} Enemy projectile Y position -= 8
$86:99DF 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:99E2 A9 00 FD    LDA #$FD00             ;\
$86:99E5 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;} Enemy projectile Y velocity = -300h
$86:99E8 9E FF 1A    STZ $1AFF,x[$7E:1B21]  ; Enemy projectile bounce counter = 0
$86:99EB AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$86:99EE 89 01 00    BIT #$0001             ;} If [frame counter] % 2 = 0:
$86:99F1 D0 07       BNE $07    [$99FA]     ;/
$86:99F3 A9 80 00    LDA #$0080             ;\
$86:99F6 9D B7 1A    STA $1AB7,x[$7E:1AD7]  ;} Enemy projectile X velocity = 80h
$86:99F9 60          RTS                    ; Return

$86:99FA A9 80 FF    LDA #$FF80             ;\
$86:99FD 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile X velocity = -80h

$86:9A00 60          RTS
}


;;; $9A01: Pre-instruction - Phantoon destroyable flame - casual flame - bouncing ;;;
{
$86:9A01 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:9A04 18          CLC                    ;|
$86:9A05 69 10 00    ADC #$0010             ;} Enemy projectile Y velocity += 10h
$86:9A08 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:9A0B 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9A0E 90 15       BCC $15    [$9A25]     ; If collided with block:
$86:9A10 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:9A13 1A          INC A                  ;} Increment enemy projectile bounce counter
$86:9A14 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/
$86:9A17 C9 03 00    CMP #$0003             ;\
$86:9A1A 10 0F       BPL $0F    [$9A2B]     ;} If [enemy projectile bounce counter] >= 3: go to BRANCH_REST
$86:9A1C 0A          ASL A                  ;\
$86:9A1D A8          TAY                    ;|
$86:9A1E B9 3E 9A    LDA $9A3E,y[$86:9A40]  ;} Enemy projectile Y velocity = -300h + [enemy projectile bounce counter] * 100h
$86:9A21 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:9A24 60          RTS                    ; Return

$86:9A25 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9A28 B0 01       BCS $01    [$9A2B]     ; If not collided with block:
$86:9A2A 60          RTS                    ; Return

; BRANCH_REST
$86:9A2B A9 82 97    LDA #$9782             ;\
$86:9A2E 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $9782 (casual flame - resting)
$86:9A31 A9 01 00    LDA #$0001             ;\
$86:9A34 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:9A37 A9 44 9A    LDA #$9A44             ;\
$86:9A3A 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:9A3D 60          RTS

; Y velocity, indexed by bounce counter. First entry is unused
$86:9A3E             dw FD00, FE00, FF00
}


;;; $9A44: RTS ;;;
{
$86:9A44 60          RTS
}


;;; $9A45: Pre-instruction - Phantoon destroyable flame - enraged flame ;;;
{
$86:9A45 BD DB 1A    LDA $1ADB,x            ;\
$86:9A48 18          CLC                    ;|
$86:9A49 69 04 00    ADC #$0004             ;} Enemy projectile radius += 4
$86:9A4C 9D DB 1A    STA $1ADB,x            ;/
$86:9A4F BD FF 1A    LDA $1AFF,x            ;\
$86:9A52 18          CLC                    ;|
$86:9A53 7D B7 1A    ADC $1AB7,x            ;} Enemy projectile angle += [enemy projectile angle delta]
$86:9A56 29 FF 00    AND #$00FF             ;|
$86:9A59 9D FF 1A    STA $1AFF,x            ;/
$86:9A5C A8          TAY                    ;\
$86:9A5D BD DB 1A    LDA $1ADB,x            ;} Calculate X/Y components of radius [enemy projectile radius], angle [enemy projectile angle]
$86:9A60 20 A2 9B    JSR $9BA2  [$86:9BA2]  ;/
$86:9A63 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9A66 18          CLC                    ;|
$86:9A67 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile X position = [Phantoon body X position] + [$14]
$86:9A69 9D 4B 1A    STA $1A4B,x            ;/
$86:9A6C 30 19       BMI $19    [$9A87]     ;\
$86:9A6E C9 00 01    CMP #$0100             ;} If 0 <= [enemy projectile X position] < 100h:
$86:9A71 10 14       BPL $14    [$9A87]     ;/
$86:9A73 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:9A76 18          CLC                    ;|
$86:9A77 69 10 00    ADC #$0010             ;|
$86:9A7A 18          CLC                    ;} Enemy projectile Y position = [Phantoon body Y position] + 10h + [$16]
$86:9A7B 65 16       ADC $16    [$7E:0016]  ;|
$86:9A7D 9D 93 1A    STA $1A93,x            ;/
$86:9A80 30 05       BMI $05    [$9A87]     ;\
$86:9A82 C9 00 01    CMP #$0100             ;} If 0 <= [enemy projectile X position] < 100h: return
$86:9A85 30 0C       BMI $0C    [$9A93]     ;/

$86:9A87 A9 F8 97    LDA #$97F8             ;\
$86:9A8A 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $97F8 (delete)
$86:9A8D A9 01 00    LDA #$0001             ;\
$86:9A90 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1

$86:9A93 60          RTS
}


;;; $9A94: Pre-instruction - Phantoon destroyable flame - flame rain ;;;
{
$86:9A94 BD B7 1A    LDA $1AB7,x[$7E:1AD5]  ;\
$86:9A97 F0 0E       BEQ $0E    [$9AA7]     ;} If [enemy projectile fall timer] = 0: go to BRANCH_FALLING
$86:9A99 DE B7 1A    DEC $1AB7,x[$7E:1AD5]  ; Decrement enemy projectile fall timer
$86:9A9C F0 02       BEQ $02    [$9AA0]     ;\
$86:9A9E 10 39       BPL $39    [$9AD9]     ;} If [enemy projectile fall timer] > 0: return

$86:9AA0 A9 1D 00    LDA #$001D             ;\
$86:9AA3 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Dh, sound library 3, max queued sounds allowed = 6 (Phantoon's flame)

; BRANCH_FALLING
$86:9AA7 BD DB 1A    LDA $1ADB,x[$7E:1AF9]  ;\
$86:9AAA 18          CLC                    ;|
$86:9AAB 69 10 00    ADC #$0010             ;} Enemy projectile Y velocity += 10h
$86:9AAE 9D DB 1A    STA $1ADB,x[$7E:1AF9]  ;/
$86:9AB1 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9AB4 90 23       BCC $23    [$9AD9]     ; If collided with block:
$86:9AB6 A9 AC 97    LDA #$97AC             ;\
$86:9AB9 9D 47 1B    STA $1B47,x[$7E:1B65]  ;} Enemy projectile instruction list pointer = $97AC (flame rain - falling)
$86:9ABC A9 01 00    LDA #$0001             ;\
$86:9ABF 9D 8F 1B    STA $1B8F,x[$7E:1BAD]  ;} Enemy projectile instruction timer = 1
$86:9AC2 BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;\
$86:9AC5 18          CLC                    ;|
$86:9AC6 69 08 00    ADC #$0008             ;} Enemy projectile Y position += 8
$86:9AC9 9D 93 1A    STA $1A93,x[$7E:1AB1]  ;/
$86:9ACC A9 44 9A    LDA #$9A44             ;\
$86:9ACF 9D 03 1A    STA $1A03,x[$7E:1A21]  ;} Enemy projectile pre-instruction = RTS
$86:9AD2 A9 1D 00    LDA #$001D             ;\
$86:9AD5 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Dh, sound library 3, max queued sounds allowed = 6 (Phantoon's flame)

$86:9AD9 60          RTS
}


;;; $9ADA: Pre-instruction - Phantoon destroyable flame - flame spiral ;;;
{
$86:9ADA BD DB 1A    LDA $1ADB,x[$7E:1AF9]  ;\
$86:9ADD 18          CLC                    ;|
$86:9ADE 69 02 00    ADC #$0002             ;} Enemy projectile radius += 2
$86:9AE1 9D DB 1A    STA $1ADB,x[$7E:1AF9]  ;/
$86:9AE4 BD FF 1A    LDA $1AFF,x[$7E:1B1D]  ;\
$86:9AE7 18          CLC                    ;|
$86:9AE8 69 02 00    ADC #$0002             ;} Enemy projectile angle += 2
$86:9AEB 29 FF 00    AND #$00FF             ;|
$86:9AEE 9D FF 1A    STA $1AFF,x[$7E:1B1D]  ;/
$86:9AF1 A8          TAY                    ;\
$86:9AF2 BD DB 1A    LDA $1ADB,x[$7E:1AF9]  ;} Calculate X/Y components of radius [enemy projectile radius], angle [enemy projectile angle]
$86:9AF5 20 A2 9B    JSR $9BA2  [$86:9BA2]  ;/
$86:9AF8 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9AFB 18          CLC                    ;|
$86:9AFC 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile X position = [Phantoon body X position] + [$14]
$86:9AFE 9D 4B 1A    STA $1A4B,x[$7E:1A69]  ;/
$86:9B01 30 19       BMI $19    [$9B1C]     ;\
$86:9B03 C9 00 01    CMP #$0100             ;} If 0 <= [enemy projectile X position] < 100h:
$86:9B06 10 14       BPL $14    [$9B1C]     ;/
$86:9B08 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:9B0B 18          CLC                    ;|
$86:9B0C 69 10 00    ADC #$0010             ;|
$86:9B0F 18          CLC                    ;} Enemy projectile Y position = [Phantoon body Y position] + 10h + [$16]
$86:9B10 65 16       ADC $16    [$7E:0016]  ;|
$86:9B12 9D 93 1A    STA $1A93,x[$7E:1AB1]  ;/
$86:9B15 30 05       BMI $05    [$9B1C]     ;\
$86:9B17 C9 00 01    CMP #$0100             ;} If 0 <= [enemy projectile X position] < 100h: return
$86:9B1A 30 0C       BMI $0C    [$9B28]     ;/

$86:9B1C A9 F8 97    LDA #$97F8             ;\
$86:9B1F 9D 47 1B    STA $1B47,x[$7E:1B5B]  ;} Enemy projectile instruction list pointer = $97F8 (delete)
$86:9B22 A9 01 00    LDA #$0001             ;\
$86:9B25 9D 8F 1B    STA $1B8F,x[$7E:1BA3]  ;} Enemy projectile instruction timer = 1

$86:9B28 60          RTS
}


;;; $9B29: Pre-instruction - enemy projectile $9C37 (Phantoon starting flames) ;;;
{
$86:9B29 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$86:9B2C F0 12       BEQ $12    [$9B40]     ;} If Phantoon starting flames are activated:
$86:9B2E A9 41 9B    LDA #$9B41             ;\
$86:9B31 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $9B41
$86:9B34 A9 B4 00    LDA #$00B4             ;\
$86:9B37 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile contract timer = 180
$86:9B3A A9 30 00    LDA #$0030             ;\
$86:9B3D 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;} Enemy projectile radius = 30h

$86:9B40 60          RTS
}


;;; $9B41: Pre-instruction - Phantoon starting flames - activated ;;;
{
$86:9B41 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:9B44 F0 06       BEQ $06    [$9B4C]     ;} If [enemy projectile contract timer] != 0:
$86:9B46 3A          DEC A                  ;\
$86:9B47 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Decrement enemy projectile contract timer
$86:9B4A 80 11       BRA $11    [$9B5D]

$86:9B4C AD B6 05    LDA $05B6  [$7E:05B6]  ;\ Else ([enemy projectile contract timer] = 0):
$86:9B4F 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0:
$86:9B52 F0 09       BEQ $09    [$9B5D]     ;/
$86:9B54 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:9B57 3A          DEC A                  ;} Decrement enemy projectile radius
$86:9B58 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:9B5B F0 28       BEQ $28    [$9B85]     ; If [enemy projectile radius] = 0: go to BRANCH_DELETE

$86:9B5D BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:9B60 1A          INC A                  ;|
$86:9B61 29 FF 00    AND #$00FF             ;} Enemy projectile angle = ([enemy projectile angle] + 1) % 100h
$86:9B64 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/
$86:9B67 A8          TAY                    ;\
$86:9B68 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;} Calculate X/Y components of radius [enemy projectile radius], angle [enemy projectile angle]
$86:9B6B 20 A2 9B    JSR $9BA2  [$86:9BA2]  ;/
$86:9B6E AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9B71 18          CLC                    ;|
$86:9B72 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile X position = [Phantoon body X position] + [$14]
$86:9B74 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:9B77 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:9B7A 18          CLC                    ;|
$86:9B7B 69 10 00    ADC #$0010             ;|
$86:9B7E 18          CLC                    ;} Enemy projectile Y position = [Phantoon body Y position] + 10h + [$16]
$86:9B7F 65 16       ADC $16    [$7E:0016]  ;|
$86:9B81 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:9B84 60          RTS                    ; Return

; BRANCH_DELETE
$86:9B85 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:9B88 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [Phantoon body X position]
$86:9B8B AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:9B8E 18          CLC                    ;|
$86:9B8F 69 10 00    ADC #$0010             ;} Enemy projectile Y position = [Phantoon body Y position] + 10h
$86:9B92 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:9B95 A9 01 00    LDA #$0001             ;\
$86:9B98 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:9B9B A9 F8 97    LDA #$97F8             ;\
$86:9B9E 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $97F8 (delete)
$86:9BA1 60          RTS
}


;;; $9BA2: Calculate X/Y components of radius [A], angle [Y] ;;;
{
;; Parameters:
;;     A: Radius
;;     Y: Angle * 2. Origin = up, positive direction = clockwise
;; Returns:
;;     $14: X component of radius
;;     $16: Y component of radius
$86:9BA2 08          PHP
$86:9BA3 C2 30       REP #$30
$86:9BA5 DA          PHX
$86:9BA6 85 18       STA $18    [$7E:0018]  ; $18 = [A]
$86:9BA8 98          TYA                    ;\
$86:9BA9 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Y]
$86:9BAB C9 80 00    CMP #$0080             ;\
$86:9BAE 10 07       BPL $07    [$9BB7]     ;|
$86:9BB0 0A          ASL A                  ;|
$86:9BB1 AA          TAX                    ;|
$86:9BB2 20 F3 9B    JSR $9BF3  [$86:9BF3]  ;|
$86:9BB5 80 10       BRA $10    [$9BC7]     ;|
                                            ;|
$86:9BB7 38          SEC                    ;|
$86:9BB8 E9 80 00    SBC #$0080             ;} $14 = [A] * sin([Y] * pi / 80h)
$86:9BBB 29 FF 00    AND #$00FF             ;|
$86:9BBE 0A          ASL A                  ;|
$86:9BBF AA          TAX                    ;|
$86:9BC0 20 F3 9B    JSR $9BF3  [$86:9BF3]  ;|
$86:9BC3 49 FF FF    EOR #$FFFF             ;|
$86:9BC6 1A          INC A                  ;|
                                            ;|
$86:9BC7 85 14       STA $14    [$7E:0014]  ;/
$86:9BC9 A5 1A       LDA $1A    [$7E:001A]  ;\
$86:9BCB 38          SEC                    ;|
$86:9BCC E9 40 00    SBC #$0040             ;|
$86:9BCF 29 FF 00    AND #$00FF             ;|
$86:9BD2 C9 80 00    CMP #$0080             ;|
$86:9BD5 10 07       BPL $07    [$9BDE]     ;|
$86:9BD7 0A          ASL A                  ;|
$86:9BD8 AA          TAX                    ;|
$86:9BD9 20 F3 9B    JSR $9BF3  [$86:9BF3]  ;|
$86:9BDC 80 10       BRA $10    [$9BEE]     ;|
                                            ;} $16 = -[A] * cos([Y] * pi / 80h)
$86:9BDE 38          SEC                    ;|
$86:9BDF E9 80 00    SBC #$0080             ;|
$86:9BE2 29 FF 00    AND #$00FF             ;|
$86:9BE5 0A          ASL A                  ;|
$86:9BE6 AA          TAX                    ;|
$86:9BE7 20 F3 9B    JSR $9BF3  [$86:9BF3]  ;|
$86:9BEA 49 FF FF    EOR #$FFFF             ;|
$86:9BED 1A          INC A                  ;|
                                            ;|
$86:9BEE 85 16       STA $16    [$7E:0016]  ;/
$86:9BF0 FA          PLX
$86:9BF1 28          PLP
$86:9BF2 60          RTS
}


;;; $9BF3: A = [$18] * sin([X] / 2 * pi / 80h) ;;;
{
; Clone of $8B:8EA3
$86:9BF3 E2 20       SEP #$20               ;\
$86:9BF5 BF 43 B4 A0 LDA $A0B443,x[$A0:B443];|
$86:9BF9 8D 02 42    STA $4202  [$7E:4202]  ;|
$86:9BFC A5 18       LDA $18    [$7E:0018]  ;|
$86:9BFE 8D 03 42    STA $4203  [$7E:4203]  ;|
$86:9C01 EA          NOP                    ;|
$86:9C02 EA          NOP                    ;} $12 = [$18] * (sin([X] / 2 * pi / 80h) * 100h low byte) / 100h
$86:9C03 EA          NOP                    ;|
$86:9C04 C2 20       REP #$20               ;|
$86:9C06 AD 16 42    LDA $4216  [$7E:4216]  ;|
$86:9C09 EB          XBA                    ;|
$86:9C0A 29 FF 00    AND #$00FF             ;|
$86:9C0D 85 12       STA $12    [$7E:0012]  ;/
$86:9C0F E2 20       SEP #$20               ;\
$86:9C11 BF 44 B4 A0 LDA $A0B444,x[$A0:B444];|
$86:9C15 8D 02 42    STA $4202  [$7E:4202]  ;|
$86:9C18 A5 18       LDA $18    [$7E:0018]  ;|
$86:9C1A 8D 03 42    STA $4203  [$7E:4203]  ;|
$86:9C1D EA          NOP                    ;|
$86:9C1E EA          NOP                    ;} $12 += [$18] * (sin([X] / 2 * pi / 80h) * 100h high byte)
$86:9C1F EA          NOP                    ;|
$86:9C20 C2 20       REP #$20               ;|
$86:9C22 AD 16 42    LDA $4216  [$7E:4216]  ;|
$86:9C25 18          CLC                    ;|
$86:9C26 65 12       ADC $12    [$7E:0012]  ;/
$86:9C28 60          RTS
}


;;; $9C29: Phantoon flame enemy projectiles ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:9C29             dx 9824,9981,975C,08,10,8028,0000,97FA ; Phantoon destroyable flames
$86:9C37             dx 993A,9B29,97E8,08,10,4028,0000,975C ; Phantoon starting flames
}
}


;;; $9C45..9DAF: Kraid rock enemy projectiles ;;;
{
;;; $9C45: Kraid rock enemy projectiles ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:9C45             dx 9CA3,9D56,9C7D,04,04,8002,0000,9C89 ; Rocks Kraid spits at you
$86:9C53             dx 9CD8,9D89,9C7D,04,04,A000,0000,84FC ; Rocks that fall when Kraid's ceiling crumbles
$86:9C61             dx 9D0C,9D56,9C7D,04,04,A000,0000,84FC ; Rocks when Kraid rises - left
$86:9C6F             dx 9D0C,9D56,9C83,04,04,A000,0000,84FC ; Rocks when Kraid rises - right
}


;;; $9C7D: Instruction list - enemy projectile $9C45/$9C53/$9C61/$D02E (Kraid rocks / kago bug) ;;;
{
$86:9C7D             dx 7FFF,8268,
                        8159        ; Sleep
}


;;; $9C83: Instruction list - enemy projectile $9C6F (rocks when Kraid rises - right) ;;;
{
$86:9C83             dx 7FFF,826F,
                        8159        ; Sleep
}


;;; $9C89: Shot instruction list - enemy projectile $9C45 (rocks Kraid spits at you) ;;;
{
$86:9C89             dx 8161,9DA5,  ; Pre-instruction = $9DA5 (use palette 0)
                        0004,8D9C,
                        0004,8DA3,
                        0004,8DB9,
                        0004,8DCF,
                        0004,8DE5,
                        8154        ; Delete
}


;;; $9CA3: Initialisation AI - enemy projectile $9C45 (rocks Kraid spits at you) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X velocity
$86:9CA3 DA          PHX
$86:9CA4 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:9CA7 BD 7A 0F    LDA $0F7A,x            ;\
$86:9CAA 18          CLC                    ;|
$86:9CAB 69 10 00    ADC #$0010             ;} Enemy projectile X position = [enemy X position] + 10h
$86:9CAE 99 4B 1A    STA $1A4B,y            ;/
$86:9CB1 BD 7E 0F    LDA $0F7E,x            ;\
$86:9CB4 38          SEC                    ;|
$86:9CB5 E9 60 00    SBC #$0060             ;} Enemy projectile Y position = [enemy Y position] - 60h
$86:9CB8 99 93 1A    STA $1A93,y            ;/
$86:9CBB A9 00 00    LDA #$0000             ;\
$86:9CBE 99 6F 1A    STA $1A6F,y            ;} Enemy projectile Y subposition = 0
$86:9CC1 99 27 1A    STA $1A27,y            ; Enemy projectile X subposition = 0
$86:9CC4 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:9CC7 99 B7 1A    STA $1AB7,y            ;} Enemy projectile X velocity = [enemy projectile initialisation parameter 0]
$86:9CCA A9 00 FC    LDA #$FC00             ;\
$86:9CCD 99 DB 1A    STA $1ADB,y            ;} Enemy projectile Y velocity = -400h
$86:9CD0 A9 00 06    LDA #$0600             ;\
$86:9CD3 99 BB 19    STA $19BB,y            ;} Enemy projectile VRAM graphics index = 0, palette 3
$86:9CD6 FA          PLX
$86:9CD7 60          RTS
}


;;; $9CD8: Initialisation AI - enemy projectile $9C53 (rocks that fall when Kraid's ceiling crumbles) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X position
$86:9CD8 DA          PHX
$86:9CD9 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index] >_<;
$86:9CDC AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:9CDF 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [enemy projectile initialisation parameter 0]
$86:9CE2 A9 38 01    LDA #$0138             ;\
$86:9CE5 99 93 1A    STA $1A93,y            ;} Enemy projectile Y position = 138h
$86:9CE8 A9 00 00    LDA #$0000             ;\
$86:9CEB 99 6F 1A    STA $1A6F,y            ;} Enemy projectile Y subposition = 0
$86:9CEE 99 27 1A    STA $1A27,y            ; Enemy projectile X subposition = 0
$86:9CF1 A9 00 00    LDA #$0000
$86:9CF4 99 B7 1A    STA $1AB7,y            ; Enemy projectile X velocity = 0
$86:9CF7 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:9CFA 29 3F 00    AND #$003F             ;|
$86:9CFD 18          CLC                    ;} Enemy projectile Y velocity = 40h + [random number] % 40h
$86:9CFE 69 40 00    ADC #$0040             ;|
$86:9D01 99 DB 1A    STA $1ADB,y            ;/
$86:9D04 A9 00 06    LDA #$0600             ;\
$86:9D07 99 BB 19    STA $19BB,y            ;} Enemy projectile VRAM graphics index = 0, palette 3
$86:9D0A FA          PLX
$86:9D0B 60          RTS
}


;;; $9D0C: Initialisation AI - enemy projectile $9C61/$9C6F (rocks when Kraid rises) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X velocity
$86:9D0C DA          PHX
$86:9D0D AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:9D10 29 3F 00    AND #$003F             ;} A = [random number] % 40h
$86:9D13 AA          TAX                    ;/
$86:9D14 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:9D17 89 01 00    BIT #$0001             ;} If [A] % 2 = 0:
$86:9D1A D0 05       BNE $05    [$9D21]     ;/
$86:9D1C 8A          TXA                    ;\
$86:9D1D 49 FF FF    EOR #$FFFF             ;} Negate A
$86:9D20 AA          TAX                    ;/

$86:9D21 8A          TXA
$86:9D22 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:9D25 18          CLC                    ;\
$86:9D26 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;} Enemy projectile X position = [enemy X position] + [A]
$86:9D29 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:9D2C A9 B0 01    LDA #$01B0             ;\
$86:9D2F 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = 1B0h
$86:9D32 A9 00 00    LDA #$0000             ;\
$86:9D35 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;} Enemy projectile Y subposition = 0
$86:9D38 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile X subposition = 0
$86:9D3B AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:9D3E 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = [enemy projectile initialisation parameter 0]
$86:9D41 A9 00 FB    LDA #$FB00             ;\
$86:9D44 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = -500h
$86:9D47 A9 00 06    LDA #$0600             ;\
$86:9D4A 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 3
$86:9D4D A9 1E 00    LDA #$001E             ;\
$86:9D50 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Eh, sound library 3, max queued sounds allowed = 6 (Kraid's earthquake)
$86:9D54 FA          PLX
$86:9D55 60          RTS
}


;;; $9D56: Pre-instruction - enemy projectile $9C45/$9C61/$9C6F (Kraid rocks) ;;;
{
$86:9D56 08          PHP
$86:9D57 C2 20       REP #$20
$86:9D59 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9D5C B0 26       BCS $26    [$9D84]     ; If collided with block: go to BRANCH_DELETE
$86:9D5E 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9D61 B0 21       BCS $21    [$9D84]     ; If collided with block: go to BRANCH_DELETE
$86:9D63 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:9D66 18          CLC                    ;|
$86:9D67 69 08 00    ADC #$0008             ;} Enemy projectile X velocity += 8
$86:9D6A 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;/
$86:9D6D C9 00 01    CMP #$0100             ;\
$86:9D70 30 03       BMI $03    [$9D75]     ;} If [enemy projectile X velocity] >= 100h:
$86:9D72 A9 00 FF    LDA #$FF00             ; Enemy projectile X velocity = -100h

$86:9D75 9D B7 1A    STA $1AB7,x[$7E:1AD9]
$86:9D78 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:9D7B 18          CLC                    ;|
$86:9D7C 69 40 00    ADC #$0040             ;} Enemy projectile Y velocity += 40h
$86:9D7F 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:9D82 28          PLP
$86:9D83 60          RTS                    ; Return

; BRANCH_DELETE
$86:9D84 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:9D87 28          PLP
$86:9D88 60          RTS
}


;;; $9D89: Pre-instruction - enemy projectile $9C53 (rocks that fall when Kraid's ceiling crumbles) ;;;
{
$86:9D89 08          PHP
$86:9D8A C2 20       REP #$20
$86:9D8C 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9D8F B0 0F       BCS $0F    [$9DA0]     ; If not collided with block:
$86:9D91 BD DB 1A    LDA $1ADB,x            ;\
$86:9D94 18          CLC                    ;|
$86:9D95 69 18 00    ADC #$0018             ;} Enemy projectile Y velocity = ([enemy projectile Y velocity] + 18h) % 4000h
$86:9D98 29 FF 3F    AND #$3FFF             ;|
$86:9D9B 9D DB 1A    STA $1ADB,x            ;/
$86:9D9E 28          PLP
$86:9D9F 60          RTS                    ; Return

$86:9DA0 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0
$86:9DA3 28          PLP
$86:9DA4 60          RTS
}


;;; $9DA5: Pre-instruction - rocks Kraid spits at you - use palette 0 ;;;
{
$86:9DA5 08          PHP
$86:9DA6 C2 30       REP #$30
$86:9DA8 A9 00 00    LDA #$0000             ;\
$86:9DAB 9D BB 19    STA $19BB,x            ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:9DAE 28          PLP
$86:9DAF 60          RTS
}
}


;;; $9DB0..9E8F: Mini Kraid ;;;
{
;;; $9DB0: Enemy projectiles - mini Kraid ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:9DB0             dx 9DEC,9E1E,9DDA,04,04,0014,0000,84FC ; Mini Kraid spit
$86:9DBE             dx 9E46,9E83,9DE0,04,02,0006,0000,84FC ; Mini Kraid spikes - left
$86:9DCC             dx 9E4B,9E83,9DE6,04,02,0006,0000,84FC ; Mini Kraid spikes - right
}


;;; $9DDA: Instruction list - enemy projectile $9DB0 (mini Kraid spit) ;;;
{
$86:9DDA             dx 7FFF,8420,
                        8159        ; Sleep
}


;;; $9DE0: Instruction list - enemy projectile $9DBE (mini Kraid spikes - left) ;;;
{
$86:9DE0             dx 7FFF,8427,
                        8159        ; Sleep
}


;;; $9DE6: Instruction list - enemy projectile $9DCC (mini Kraid spikes - right) ;;;
{
$86:9DE6             dx 7FFF,842E,
                        8159        ; Sleep
}


;;; $9DEC: Initialisation AI - enemy projectile $9DB0 (mini Kraid spit) ;;;
{
$86:9DEC DA          PHX
$86:9DED AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:9DF0 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$86:9DF3 18          CLC                    ;|
$86:9DF4 7F 04 78 7E ADC $7E7804,x[$7E:78C4];} Enemy projectile X position = [enemy X position] + [enemy spit X offset]
$86:9DF8 99 4B 1A    STA $1A4B,y[$7E:1A65]  ;/
$86:9DFB BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$86:9DFE 38          SEC                    ;|
$86:9DFF E9 10 00    SBC #$0010             ;} Enemy projectile Y position = [enemy Y position] - 10h
$86:9E02 99 93 1A    STA $1A93,y[$7E:1AAD]  ;/
$86:9E05 A9 00 00    LDA #$0000             ;\
$86:9E08 99 6F 1A    STA $1A6F,y[$7E:1A89]  ;} Enemy projectile Y subposition = 0
$86:9E0B 99 27 1A    STA $1A27,y[$7E:1A41]  ; Enemy projectile X subposition = 0
$86:9E0E BF 00 78 7E LDA $7E7800,x[$7E:78C0];\
$86:9E12 99 B7 1A    STA $1AB7,y[$7E:1AD1]  ;} Enemy projectile X velocity = [enemy spit X velocity]
$86:9E15 BF 02 78 7E LDA $7E7802,x[$7E:78C2];\
$86:9E19 99 DB 1A    STA $1ADB,y[$7E:1AF5]  ;} Enemy projectile Y velocity = [enemy spit Y velocity]
$86:9E1C FA          PLX
$86:9E1D 60          RTS
}


;;; $9E1E: Pre-instruction - enemy projectile $9DB0 (mini Kraid spit) ;;;
{
$86:9E1E 08          PHP
$86:9E1F C2 20       REP #$20
$86:9E21 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9E24 B0 1B       BCS $1B    [$9E41]     ; If collision: go to BRANCH_DELETE
$86:9E26 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9E29 B0 16       BCS $16    [$9E41]     ; If collision: go to BRANCH_DELETE
$86:9E2B BD DB 1A    LDA $1ADB,x[$7E:1AF5]  ;\
$86:9E2E 18          CLC                    ;|
$86:9E2F 69 40 00    ADC #$0040             ;|
$86:9E32 30 08       BMI $08    [$9E3C]     ;|
$86:9E34 C9 00 04    CMP #$0400             ;} Enemy projectile Y velocity = min(400h, [enemy projectile Y velocity] + 40h)
$86:9E37 30 03       BMI $03    [$9E3C]     ;|
$86:9E39 A9 00 04    LDA #$0400             ;|
                                            ;|
$86:9E3C 9D DB 1A    STA $1ADB,x[$7E:1AF5]  ;/
$86:9E3F 28          PLP
$86:9E40 60          RTS                    ; Return

; BRANCH_DELETE
$86:9E41 9E 97 19    STZ $1997,x[$7E:19B1]  ; Enemy projectile ID = 0
$86:9E44 28          PLP
$86:9E45 60          RTS
}


;;; $9E46: Initialisation AI - enemy projectile $9DBE (mini Kraid spikes - left) ;;;
{
$86:9E46 A9 00 FE    LDA #$FE00             ; Enemy projectile X velocity = -200h
$86:9E49 80 03       BRA $03    [$9E4E]     ; Go to mini Kraid spikes common initialisation
}


;;; $9E4B: Initialisation AI - enemy projectile $9DCC (mini Kraid spikes - right) ;;;
{
$86:9E4B A9 00 02    LDA #$0200             ; Enemy projectile X velocity = 200h
}


;;; $9E4E: Mini Kraid spikes common initialisation ;;;
{
$86:9E4E 99 B7 1A    STA $1AB7,y[$7E:1AD5]
$86:9E51 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$86:9E54 BF 0C 78 7E LDA $7E780C,x[$7E:78CC];|
$86:9E58 AA          TAX                    ;} $12 = [$9E7D + [enemy spike index]]
$86:9E59 BD 7D 9E    LDA $9E7D,x[$86:9E81]  ;|
$86:9E5C 85 12       STA $12    [$7E:0012]  ;/
$86:9E5E AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:9E61 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$86:9E64 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;} Enemy projectile X position = [enemy X position]
$86:9E67 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$86:9E6A 18          CLC                    ;|
$86:9E6B 65 12       ADC $12    [$7E:0012]  ;} Enemy projectile Y position = [enemy Y position] + [$12]
$86:9E6D 99 93 1A    STA $1A93,y[$7E:1AB1]  ;/
$86:9E70 A9 00 00    LDA #$0000
$86:9E73 99 6F 1A    STA $1A6F,y[$7E:1A8D]
$86:9E76 99 27 1A    STA $1A27,y[$7E:1A45]  ; Enemy projectile X subposition = 0
$86:9E79 99 DB 1A    STA $1ADB,y[$7E:1AF9]
$86:9E7C 60          RTS

$86:9E7D             dw FFFE, 000C, 0018
}


;;; $9E83: Pre-instruction - enemy projectile $9DBE/$9DCC (mini Kraid spikes) ;;;
{
$86:9E83 08          PHP
$86:9E84 C2 20       REP #$20
$86:9E86 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9E89 90 03       BCC $03    [$9E8E]     ; If collision:
$86:9E8B 9E 97 19    STZ $1997,x[$7E:19A9]  ; Enemy projectile ID = 0

$86:9E8E 28          PLP
$86:9E8F 60          RTS
}
}


;;; $9E90..9F40: Walking lava seahorse fireball ;;;
{
;;; $9E90: Enemy projectile - walking lava seahorse fireball ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:9E90             dx 9EB2,9EFF,9E9E,04,04,0014,0000,84FC ; Walking lava seahorse fireball
}


;;; $9E9E: Instruction list - enemy projectile $9E90 (walking lava seahorse fireball) ;;;
{
$86:9E9E             dx 0003,8404,
                        0003,840B,
                        0003,8412,
                        0003,8419,
                        81AB,9E9E   ; Go to $9E9E
}


;;; $9EB2: Initialisation AI - enemy projectile $9E90 (walking lava seahorse fireball) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Y velocity index
$86:9EB2 DA          PHX
$86:9EB3 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:9EB6 BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;\
$86:9EB9 38          SEC                    ;|
$86:9EBA E9 0C 00    SBC #$000C             ;} Enemy projectile Y position = [enemy Y position] - Ch
$86:9EBD 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:9EC0 A9 00 FC    LDA #$FC00             ;\
$86:9EC3 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = -400h
$86:9EC6 BD 7A 0F    LDA $0F7A,x[$7E:10BA]  ;\
$86:9EC9 38          SEC                    ;|
$86:9ECA E9 10 00    SBC #$0010             ;} Enemy projectile X position = [enemy X position] - 10h
$86:9ECD 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:9ED0 BD AE 0F    LDA $0FAE,x[$7E:10EE]  ;\
$86:9ED3 30 10       BMI $10    [$9EE5]     ;} If [enemy $0FAE] >= 0:
$86:9ED5 A9 00 04    LDA #$0400             ;\
$86:9ED8 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = 400h
$86:9EDB BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$86:9EDE 18          CLC                    ;|
$86:9EDF 69 10 00    ADC #$0010             ;} Enemy projectile X position = [enemy X position] + 10h
$86:9EE2 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/

$86:9EE5 AE 93 19    LDX $1993  [$7E:1993]  ;\
$86:9EE8 BD F9 9E    LDA $9EF9,x[$86:9EFB]  ;} Enemy projectile Y velocity = [$9EF9 + [enemy projectile initialisation parameter 0]]
$86:9EEB 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;/
$86:9EEE A9 00 00    LDA #$0000             ;\
$86:9EF1 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;} Enemy projectile Y subposition = 0
$86:9EF4 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile X subposition = 0
$86:9EF7 FA          PLX
$86:9EF8 60          RTS

; Y velocities
$86:9EF9             dw FF00, 0000, 0100
}


;;; $9EFF: Pre-instruction - enemy projectile $9E90 (walking lava seahorse fireball) ;;;
{
$86:9EFF C2 30       REP #$30
$86:9F01 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:9F04 B0 34       BCS $34    [$9F3A]     ; If collision: go to BRANCH_DELETE
$86:9F06 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:9F09 B0 2F       BCS $2F    [$9F3A]     ; If collision: go to BRANCH_DELETE
$86:9F0B BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:9F0E 10 14       BPL $14    [$9F24]     ;} If [enemy projectile X velocity] < 0:
$86:9F10 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:9F13 18          CLC                    ;|
$86:9F14 69 40 00    ADC #$0040             ;|
$86:9F17 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile X velocity = min(-200h, [enemy projectile X velocity] + 40h)
$86:9F1A C9 00 FE    CMP #$FE00             ;|
$86:9F1D 30 17       BMI $17    [$9F36]     ;|
$86:9F1F A9 00 FE    LDA #$FE00             ;/
$86:9F22 80 12       BRA $12    [$9F36]

$86:9F24 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\ Else ([enemy projectile X velocity] >= 0):
$86:9F27 38          SEC                    ;|
$86:9F28 E9 40 00    SBC #$0040             ;|
$86:9F2B 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile X velocity = max(200h, [enemy projectile X velocity] - 40h)
$86:9F2E C9 00 02    CMP #$0200             ;|
$86:9F31 10 03       BPL $03    [$9F36]     ;|
$86:9F33 A9 00 02    LDA #$0200             ;/

$86:9F36 9D B7 1A    STA $1AB7,x[$7E:1AD9]
$86:9F39 60          RTS                    ; Return

; BRANCH_DELETE
$86:9F3A A9 00 00    LDA #$0000             ;\
$86:9F3D 9D 97 19    STA $1997,x[$7E:19B7]  ;} Enemy projectile ID = 0
$86:9F40 60          RTS
}
}


;;; $9F41..A196: Pirate ;;;
{
;;; $9F41: Instruction list - pirate / Mother Brain laser - moving left ;;;
{
$86:9F41             dx 0002,8C29,
                        0002,8C30,
                        0002,8C37,
                        A050,A05C,  ; Pre-instruction = $A05C, execute $A05C (move left)
                        0001,8BB5,
                        0001,8BBC,
                        0001,8BC3,
                        0001,8BCF,
                        0001,8BDB,
                        0001,8BEC,
                        0001,8BFD,
                        0001,8C13
$86:9F71             dx 0001,8BFD,
                        0001,8C13,
                        81AB,9F71   ; Go to $9F71
}


;;; $9F7D: Instruction list - pirate / Mother Brain laser - moving right ;;;
{
$86:9F7D             dx 0002,8C29,
                        0002,8C30,
                        0002,8C37,
                        A050,A07A,  ; Pre-instruction = $A07A, execute $A07A (move right)
                        0001,8BB5,
                        0001,8BBC,
                        0001,8BC3,
                        0001,8BCF,
                        0001,8BDB,
                        0001,8BEC,
                        0001,8BFD,
                        0001,8C13,
$86:9FAD             dx 0001,8BFD,
                        0001,8C13,
                        81AB,9FAD   ; Go to $9FAD
}


;;; $9FB9: Instruction list - pirate claw - thrown left ;;;
{
$86:9FB9             dx 8161,A0D1,  ; Pre-instruction = $A0D1 (thrown left)
$86:9FBD             dx 0001,8ACD,
                        0001,8ADE,
                        0001,8AEA,
                        0001,8AFB,
                        0001,8B07,
                        0001,8B18,
                        0001,8B24,
                        0001,8B35,
                        81AB,9FBD   ; Go to $9FBD
}


;;; $9FE1: Instruction list - pirate claw - thrown right ;;;
{
$86:9FE1             dx 8161,A124,  ; Pre-instruction = $A124 (thrown right)
$86:9FE5             dx 0001,8B41,
                        0001,8B52,
                        0001,8B5E,
                        0001,8B6F,
                        0001,8B7B,
                        0001,8B8C,
                        0001,8B98,
                        0001,8BA9,
                        81AB,9FE5   ; Go to $9FE5
}


;;; $A009: Initialisation AI - enemy projectile $A17B (pirate / Mother Brain laser) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
;;     $16: Direction. 0 = left, otherwise right

; Enemy projectile damage is taken from enemy header
; If [enemy parameter 1] & 8000h = 0, then movement is 4 px/frame, otherwise 2 px/frame

$86:A009 5A          PHY
$86:A00A DA          PHX
$86:A00B A2 41 9F    LDX #$9F41             ; Enemy projectile instruction list pointer = $9F41 (moving left)
$86:A00E A5 16       LDA $16    [$7E:0016]  ;\
$86:A010 29 FF FF    AND #$FFFF             ;} If [$16] != 0:
$86:A013 F0 03       BEQ $03    [$A018]     ;/
$86:A015 A2 7D 9F    LDX #$9F7D             ; Enemy projectile instruction list pointer = $9F7D (moving right)

$86:A018 8A          TXA
$86:A019 99 47 1B    STA $1B47,y[$7E:1B67]
$86:A01C A9 5B A0    LDA #$A05B             ;\
$86:A01F 99 03 1A    STA $1A03,y[$7E:1A23]  ;} Enemy projectile pre-instruction = RTS
$86:A022 A5 12       LDA $12    [$7E:0012]  ;\
$86:A024 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;} Enemy projectile X position = [$12]
$86:A027 A5 14       LDA $14    [$7E:0014]  ;\
$86:A029 99 93 1A    STA $1A93,y[$7E:1AB3]  ;} Enemy projectile Y position = [$14]
$86:A02C AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$86:A02F BD 78 0F    LDA $0F78,x[$7E:1038]  ;|
$86:A032 AA          TAX                    ;|
$86:A033 BF 06 00 A0 LDA $A00006,x[$A0:F659];} Enemy projectile properties = (enemy damage) | 1000h (high priority)
$86:A037 09 00 10    ORA #$1000             ;|
$86:A03A 99 D7 1B    STA $1BD7,y[$7E:1BF7]  ;/
$86:A03D AE 54 0E    LDX $0E54  [$7E:0E54]
$86:A040 BD B4 0F    LDA $0FB4,x[$7E:1074]  ;\
$86:A043 99 FF 1A    STA $1AFF,y[$7E:1B1F]  ;} Enemy projectile half-speed flag = [enemy parameter 1]
$86:A046 A9 67 00    LDA #$0067             ;\
$86:A049 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 67h, sound library 2, max queued sounds allowed = 6 (pirate laser)
$86:A04D FA          PLX
$86:A04E 7A          PLY
$86:A04F 60          RTS
}


;;; $A050: Instruction - pre-instruction = [[Y]], execute [[Y]] ;;;
{
$86:A050 DA          PHX
$86:A051 5A          PHY
$86:A052 B9 00 00    LDA $0000,y[$86:9F8B]
$86:A055 9D 03 1A    STA $1A03,x[$7E:1A23]
$86:A058 7A          PLY
$86:A059 FA          PLX
$86:A05A 60          RTS
}


;;; $A05B: RTS ;;;
{
$86:A05B 60          RTS
}


;;; $A05C: Pre-instruction - pirate / Mother Brain laser - move left ;;;
{
$86:A05C DE 4B 1A    DEC $1A4B,x[$7E:1A6D]  ;\
$86:A05F DE 4B 1A    DEC $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position -= 2
$86:A062 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A065 89 00 80    BIT #$8000             ;} If [enemy projectile half-speed flag] & 8000h = 0:
$86:A068 D0 06       BNE $06    [$A070]     ;/
$86:A06A DE 4B 1A    DEC $1A4B,x[$7E:1A6B]  ;\
$86:A06D DE 4B 1A    DEC $1A4B,x[$7E:1A6B]  ;} Enemy projectile X position -= 2

$86:A070 20 E0 E6    JSR $E6E0  [$86:E6E0]  ;\
$86:A073 D0 01       BNE $01    [$A076]     ;} If enemy projectile is not off-screen:
$86:A075 60          RTS                    ; Return

$86:A076 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:A079 60          RTS
}


;;; $A07A: Pre-instruction - pirate / Mother Brain laser - move right ;;;
{
$86:A07A FE 4B 1A    INC $1A4B,x[$7E:1A6B]  ;\
$86:A07D FE 4B 1A    INC $1A4B,x[$7E:1A6B]  ;} Enemy projectile X position += 2
$86:A080 BD FF 1A    LDA $1AFF,x[$7E:1B1F]  ;\
$86:A083 89 00 80    BIT #$8000             ;} If [enemy projectile half-speed flag] & 8000h = 0:
$86:A086 D0 06       BNE $06    [$A08E]     ;/
$86:A088 FE 4B 1A    INC $1A4B,x[$7E:1A69]  ;\
$86:A08B FE 4B 1A    INC $1A4B,x[$7E:1A69]  ;} Enemy projectile X position += 2

$86:A08E 20 E0 E6    JSR $E6E0  [$86:E6E0]  ;\
$86:A091 D0 01       BNE $01    [$A094]     ;} If enemy projectile is not off-screen:
$86:A093 60          RTS                    ; Return

$86:A094 9E 97 19    STZ $1997,x[$7E:19B3]  ; Enemy projectile ID = 0
$86:A097 60          RTS
}


;;; $A098: Initialisation AI - enemy projectile $A189 (pirate claw) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
;;     $16: X offset
;;     $18: Y offset
;;     $1993: Direction. 0 = left, otherwise right
$86:A098 5A          PHY
$86:A099 DA          PHX
$86:A09A A5 14       LDA $14    [$7E:0014]  ;\
$86:A09C 18          CLC                    ;|
$86:A09D 65 18       ADC $18    [$7E:0018]  ;} Enemy projectile Y position = [$14] + [$18]
$86:A09F 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:A0A2 A5 12       LDA $12    [$7E:0012]  ;\
$86:A0A4 18          CLC                    ;|
$86:A0A5 65 16       ADC $16    [$7E:0016]  ;} Enemy projectile X position = [$12] + [$16]
$86:A0A7 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:A0AA A2 B9 9F    LDX #$9FB9             ; Enemy projectile instruction list pointer = $9FB9 (thrown left)
$86:A0AD AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:A0B0 29 FF FF    AND #$FFFF             ;} If [enemy projectile initialisation parameter] != 0:
$86:A0B3 F0 03       BEQ $03    [$A0B8]     ;/
$86:A0B5 A2 E1 9F    LDX #$9FE1             ; Enemy projectile instruction list pointer = $9FE1 (thrown right)

$86:A0B8 8A          TXA
$86:A0B9 99 47 1B    STA $1B47,y[$7E:1B69]
$86:A0BC A9 5B A0    LDA #$A05B             ;\
$86:A0BF 99 03 1A    STA $1A03,y[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:A0C2 A9 00 08    LDA #$0800             ;\
$86:A0C5 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile X speed = 800h
$86:A0C8 A9 01 00    LDA #$0001             ;\
$86:A0CB 99 23 1B    STA $1B23,y[$7E:1B45]  ;} Enemy projectile deceleration flag = 1
$86:A0CE FA          PLX
$86:A0CF 7A          PLY
$86:A0D0 60          RTS
}


;;; $A0D1: Pre-instruction - pirate claw - thrown left ;;;
{
$86:A0D1 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:A0D4 F0 23       BEQ $23    [$A0F9]     ;} If [enemy projectile deceleration flag] != 0:
$86:A0D6 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A0D9 EB          XBA                    ;|
$86:A0DA 29 FF 00    AND #$00FF             ;|
$86:A0DD 85 12       STA $12    [$7E:0012]  ;|
$86:A0DF BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position -= [enemy projectile X speed] / 100h
$86:A0E2 38          SEC                    ;|
$86:A0E3 E5 12       SBC $12    [$7E:0012]  ;|
$86:A0E5 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:A0E8 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A0EB 38          SEC                    ;|
$86:A0EC E9 20 00    SBC #$0020             ;} Enemy projectile X speed -= 20h
$86:A0EF 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/
$86:A0F2 D0 1D       BNE $1D    [$A111]     ; If [enemy projectile X speed] = 0:
$86:A0F4 9E 23 1B    STZ $1B23,x[$7E:1B45]  ; Enemy projectile deceleration flag = 0
$86:A0F7 80 18       BRA $18    [$A111]

$86:A0F9 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\ Else ([enemy projectile deceleration flag] = 0):
$86:A0FC EB          XBA                    ;|
$86:A0FD 29 FF 00    AND #$00FF             ;|
$86:A100 18          CLC                    ;} Enemy projectile X position += [enemy projectile X speed] / 100h
$86:A101 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]  ;|
$86:A104 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:A107 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A10A 18          CLC                    ;|
$86:A10B 69 20 00    ADC #$0020             ;} Enemy projectile X speed += 20h
$86:A10E 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/

$86:A111 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:A114 18          CLC                    ;|
$86:A115 69 01 00    ADC #$0001             ;} Enemy projectile Y position += 1
$86:A118 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:A11B 20 E0 E6    JSR $E6E0  [$86:E6E0]  ;\
$86:A11E F0 03       BEQ $03    [$A123]     ;} If enemy projectile is off-screen:
$86:A120 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0

$86:A123 60          RTS
}


;;; $A124: Pre-instruction - pirate claw - thrown right ;;;
{
$86:A124 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:A127 F0 23       BEQ $23    [$A14C]     ;} If [enemy projectile deceleration flag] != 0:
$86:A129 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A12C EB          XBA                    ;|
$86:A12D 29 FF 00    AND #$00FF             ;|
$86:A130 85 12       STA $12    [$7E:0012]  ;|
$86:A132 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position += [enemy projectile X speed] / 100h
$86:A135 18          CLC                    ;|
$86:A136 65 12       ADC $12    [$7E:0012]  ;|
$86:A138 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:A13B BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A13E 38          SEC                    ;|
$86:A13F E9 20 00    SBC #$0020             ;} Enemy projectile X speed -= 20h
$86:A142 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/
$86:A145 D0 21       BNE $21    [$A168]     ; If [enemy projectile X speed] = 0:
$86:A147 9E 23 1B    STZ $1B23,x[$7E:1B45]  ; Enemy projectile deceleration flag = 0
$86:A14A 80 1C       BRA $1C    [$A168]

$86:A14C BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\ Else ([enemy projectile deceleration flag] = 0):
$86:A14F EB          XBA                    ;|
$86:A150 29 FF 00    AND #$00FF             ;|
$86:A153 85 12       STA $12    [$7E:0012]  ;|
$86:A155 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position -= [enemy projectile X speed] / 100h
$86:A158 38          SEC                    ;|
$86:A159 E5 12       SBC $12    [$7E:0012]  ;|
$86:A15B 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:A15E BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A161 18          CLC                    ;|
$86:A162 69 20 00    ADC #$0020             ;} Enemy projectile X speed += 20h
$86:A165 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/

$86:A168 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:A16B 18          CLC                    ;|
$86:A16C 69 01 00    ADC #$0001             ;} Enemy projectile Y position += 1
$86:A16F 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:A172 20 E0 E6    JSR $E6E0  [$86:E6E0]  ;\
$86:A175 F0 03       BEQ $03    [$A17A]     ;} If enemy projectile is off-screen:
$86:A177 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0

$86:A17A 60          RTS
}


;;; $A17B: Enemy projectiles - pirate ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:A17B             dx A009,A05C,9F41,10,04,100A,0000,84FC ; Pirate / Mother Brain laser. Initial pre-instruction and instruction list ignored
$86:A189             dx A098,A05B,0000,08,08,1014,0000,84FC ; Pirate claw. Initial pre-instruction and instruction list ignored
}
}


;;; $A197..A3A2: Gunship liftoff dust clouds / Ceres elevator ;;;
{
;;; $A197: Instruction list - gunship liftoff dust clouds - index = 0 ;;;
{
; Enemy projectile $E525 points here for its pre-instruction...

$86:A197             dx 81D5,0001   ; Timer = 1
$86:A19B             dx 0008,8483,
                        0008,848A,
                        0009,849B,
                        0009,84B1,
                        000A,84CC,
                        000A,84E7,
                        000A,84FD,
                        000A,8509,
                        81C6,A19B,  ; Decrement timer and go to $A19B if non-zero
                        8154        ; Delete
}


;;; $A1C1: Instruction list - gunship liftoff dust clouds - index = 2 ;;;
{
$86:A1C1             dx 81D5,0001   ; Timer = 1
$86:A1C5             dx 0006,8510,
                        0006,8517,
                        0007,8528,
                        0007,853E,
                        0008,8559,
                        0008,8574,
                        0008,858A,
                        0008,8596,
                        81C6,A1C5,  ; Decrement timer and go to $A1C5 if non-zero
                        8154        ; Delete
}


;;; $A1EB: Instruction list - gunship liftoff dust clouds - index = 4 ;;;
{
$86:A1EB             dx 81D5,0001   ; Timer = 1
$86:A1EF             dx 000B,859D,
                        000B,85BD,
                        000C,85F1,
                        000C,8639,
                        000D,8677,
                        000D,86B5,
                        000D,86DF,
                        81C6,A1EF,  ; Decrement timer and go to $A1EF if non-zero
                        8154        ; Delete
}


;;; $A211: Instruction list - gunship liftoff dust clouds - index = 6 ;;;
{
$86:A211             dx 81D5,0001   ; Timer = 1
$86:A215             dx 0008,86F5,
                        0008,86FC,
                        0009,870D,
                        0009,8723,
                        000A,873E,
                        000A,8759,
                        000A,876F,
                        000A,877B,
                        81C6,A215,  ; Decrement timer and go to $A215 if non-zero
                        8154        ; Delete
}


;;; $A23B: Instruction list - gunship liftoff dust clouds - index = 8 ;;;
{
$86:A23B             dx 81D5,0001   ; Timer = 1
$86:A23F             dx 0006,8782,
                        0006,8789,
                        0007,879A,
                        0007,87B0,
                        0008,87CB,
                        0008,87E6,
                        0008,87FC,
                        0008,8808,
                        81C6,A23F,  ; Decrement timer and go to $A23F if non-zero
                        8154        ; Delete
}


;;; $A265: Instruction list - gunship liftoff dust clouds - index = Ah ;;;
{
$86:A265             dx 81D5,0001   ; Timer = 1
$86:A269             dx 000B,880F,
                        000B,882F,
                        000C,8863,
                        000C,88AB,
                        000D,88E9,
                        000D,8927,
                        000D,8951,
                        81C6,A269,  ; Decrement timer and go to $A269 if non-zero
                        8154        ; Delete
}


;;; $A28B: Instruction list - delete ;;;
{
$86:A28B             dx 8154        ; Delete
}


;;; $A28D: Instruction list / shot instruction list - enemy projectile $A387 (Ceres elevator pad) ;;;
{
$86:A28D             dx 0001,B1BA,
                        0001,B1D0,
                        81AB,A28D   ; Go to $A28D
}


;;; $A299: Instruction list / shot instruction list - enemy projectile $A395 (Ceres elevator pad level data concealer) ;;;
{
$86:A299             dx 0001,846D,
                        81AB,A299   ; Go to $A299
}


;;; $A2A1: Initialisation AI - enemy projectile $A379 (gunship liftoff dust clouds) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Multiple of 2, range 0..Ah. 0/2/4 are on the right side, 6/8/Ah on the left side
$86:A2A1 08          PHP
$86:A2A2 C2 30       REP #$30
$86:A2A4 A9 00 00    LDA #$0000
$86:A2A7 99 27 1A    STA $1A27,y[$7E:1A49]
$86:A2AA 99 6F 1A    STA $1A6F,y[$7E:1A91]
$86:A2AD 99 B7 1A    STA $1AB7,y[$7E:1AD9]
$86:A2B0 99 DB 1A    STA $1ADB,y[$7E:1AFD]
$86:A2B3 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:A2B6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:A2B9 18          CLC                    ;|
$86:A2BA 7D D6 A2    ADC $A2D6,x[$86:A2D6]  ;} Enemy projectile X position = [Samus X position] + [$A2D6 + [X]]
$86:A2BD 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:A2C0 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:A2C3 18          CLC                    ;|
$86:A2C4 69 50 00    ADC #$0050             ;} Enemy projectile Y position = [Samus Y position] + 50h
$86:A2C7 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:A2CA BD E2 A2    LDA $A2E2,x[$86:A2E2]  ;\
$86:A2CD 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = [$A2E2 + [X]]
$86:A2D0 8A          TXA                    ;\
$86:A2D1 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile $1AFF = [X] (never read)
$86:A2D4 28          PLP
$86:A2D5 60          RTS

$86:A2D6             dw 0040, 0048, 0050, FFC0, FFB8, FFB0 ; X offsets
$86:A2E2             dw A197, A1C1, A1EB, A211, A23B, A265 ; Instruction list pointers
}


;;; $A2EE: Initialisation AI - enemy projectile $A387 (Ceres elevator pad) ;;;
{
$86:A2EE 08          PHP
$86:A2EF C2 30       REP #$30
$86:A2F1 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:A2F4 18          CLC                    ;|
$86:A2F5 69 1C 00    ADC #$001C             ;} Enemy projectile Y position = [Samus Y position] + 1Ch
$86:A2F8 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:A2FB A9 3C 00    LDA #$003C             ;\
$86:A2FE 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile timer = 60
}


;;; $A301: Ceres elevator common initialisation ;;;
{
$86:A301 A9 00 00    LDA #$0000
$86:A304 99 27 1A    STA $1A27,y[$7E:1A49]
$86:A307 99 6F 1A    STA $1A6F,y[$7E:1A91]
$86:A30A 99 B7 1A    STA $1AB7,y[$7E:1AD9]
$86:A30D 99 DB 1A    STA $1ADB,y[$7E:1AFD]
$86:A310 99 BB 19    STA $19BB,y[$7E:19DD]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:A313 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:A316 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [Samus X position]
$86:A319 28          PLP
$86:A31A 60          RTS
}


;;; $A31B: Initialisation AI - enemy projectile $A395 (Ceres elevator pad level data concealer) ;;;
{
$86:A31B 08          PHP
$86:A31C C2 30       REP #$30
$86:A31E A9 61 00    LDA #$0061             ;\
$86:A321 99 93 1A    STA $1A93,y[$7E:1AB3]  ;} Enemy projectile Y position = 61h
$86:A324 4C 01 A3    JMP $A301  [$86:A301]  ; Go to Ceres elevator common initialisation
}


;;; $A327: RTS. Pre-instruction - enemy projectile $A379 (gunship liftoff dust clouds) ;;;
{
$86:A327 60          RTS
}


;;; $A328: Pre-instruction - enemy projectile $A387 (Ceres elevator pad) ;;;
{
$86:A328 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:A32B F0 07       BEQ $07    [$A334]     ;} If [enemy projectile timer] != 0:
$86:A32D DE FF 1A    DEC $1AFF,x[$7E:1B21]  ; Decrement enemy projectile timer
$86:A330 F0 02       BEQ $02    [$A334]     ;\
$86:A332 10 2F       BPL $2F    [$A363]     ;} If [enemy projectile timer] > 0: return

$86:A334 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:A337 18          CLC                    ;|
$86:A338 69 1C 00    ADC #$001C             ;} Enemy projectile Y position = [Samus Y position] + 1Ch
$86:A33B 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:A33E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:A341 1A          INC A                  ;} Samus Y position += 1
$86:A342 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$86:A345 C9 49 00    CMP #$0049             ;\
$86:A348 30 19       BMI $19    [$A363]     ;} If [Samus Y position] > 48h:
$86:A34A A9 48 00    LDA #$0048             ;\
$86:A34D 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = 48h
$86:A350 A9 01 00    LDA #$0001             ;\
$86:A353 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:A356 A9 8B A2    LDA #$A28B             ;\
$86:A359 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $A28B (delete)
$86:A35C A9 0E 00    LDA #$000E             ;\
$86:A35F 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unlock Samus from Ceres elevator

$86:A363 60          RTS
}


;;; $A364: Pre-instruction - enemy projectile $A395 (Ceres elevator pad level data concealer) ;;;
{
$86:A364 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:A367 C9 48 00    CMP #$0048             ;} If [Samus Y position] = 48h:
$86:A36A D0 0C       BNE $0C    [$A378]     ;/
$86:A36C A9 01 00    LDA #$0001             ;\
$86:A36F 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:A372 A9 8B A2    LDA #$A28B             ;\
$86:A375 9D 47 1B    STA $1B47,x[$7E:1B67]  ;} Enemy projectile instruction list pointer = $A28B (delete)

$86:A378 60          RTS
}


;;; $A379: Enemy projectiles - gunship liftoff dust clouds / Ceres elevator ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:A379             dx A2A1,A327,A197,08,08,3000,0000,A197 ; Gunship liftoff dust clouds. Initial instruction list ignored
$86:A387             dx A2EE,A328,A28D,01,01,3000,0000,A28D ; Ceres elevator pad
$86:A395             dx A31B,A364,A299,01,01,3000,0000,A299 ; Ceres elevator pad level data concealer
}
}


;;; $A3A3..BD: Pre-Phantoon room ;;;
{
;;; $A3A3: Initialisation AI / pre-instruction - enemy projectile $A3B0 (pre-Phantoon room) ;;;
{
$86:A3A3 A9 00 00    LDA #$0000             ;\
$86:A3A6 8D 23 09    STA $0923  [$7E:0923]  ;} BG2 Y offset = 0
$86:A3A9 60          RTS
}


;;; $A3AA: Instruction list - enemy projectile $A3B0 (pre-Phantoon room) ;;;
{
$86:A3AA             dw 0020,8000,
                        8154        ; Delete
}


;;; $A3B0: Enemy projectile - pre-Phantoon room ;;;
{
; Scrolls BG2 up 32 pixels
; Normally, the top of the BG2 of a room is drawn after the HUD, this modification causes BG2 to be drawn under the HUD
; ...which I guess only mattered for this *one* room

;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:A3B0             dx A3A3,A3A3,A3AA,00,00,3000,0000,84FC
}
}


;;; $A3BE..A9BC: Torizo ;;;
{
;;; $A3BE..A5D2: Instruction lists ;;;
{
;;; $A3BE: Instruction - reset position ;;;
{
$86:A3BE BD FF 1A    LDA $1AFF,x[$7E:1B0D]  ;\
$86:A3C1 9D 4B 1A    STA $1A4B,x[$7E:1A59]  ;} Enemy projectile X position = [enemy projectile reset X position]
$86:A3C4 BD 23 1B    LDA $1B23,x[$7E:1B31]  ;\
$86:A3C7 9D 93 1A    STA $1A93,x[$7E:1AA1]  ;} Enemy projectile Y position = [enemy projectile reset Y position]
$86:A3CA 60          RTS
}


;;; $A3CB: Instruction list - enemy projectile $A9A1 (Bomb Torizo low-health explosion) ;;;
{
$86:A3CB             dx 816A,               ; Clear pre-instruction
                        8230,3000,          ; Enemy projectile properties |= 3000h (high priority, disable collisions with Samus)
                        81D5,0003           ; Timer = 3
$86:A3D5             dx A3BE,               ; Reset position
                        81DF,0F,00,0F,00,   ; Move randomly within X radius Fh and Y radius Fh
                        8312,24,            ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
                        0002,8D9C,
                        0002,8DA3,
                        0003,8DB9,
                        0003,8DCF,
                        0002,8DE5,
                        81C6,A3D5,          ; Decrement timer and go to $A3D5 if non-zero
                        8154                ; Delete
}


;;; $A3FA: Instruction list - enemy projectile $A9AF (Torizo death explosion) ;;;
{
$86:A3FA             dx 816A,               ; Clear pre-instruction
                        8230,3000,          ; Enemy projectile properties |= 3000h (high priority, disable collisions with Samus)
                        A456,A431,          ; Go to $A431 with probability 1/4
                        81D5,0002           ; Timer = 2
$86:A408             dx A3BE,               ; Reset position
                        81DF,1F,00,3F,10,   ; Move randomly within X radius 1Fh and Y radius 2Fh
                        8312,24,            ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
                        0004,B023,
                        0006,B02A,
                        0005,B040,
                        0005,B056,
                        0005,B06C,
                        0006,B082,
                        81C6,A408,          ; Decrement timer and go to $A408 if non-zero
                        8154                ; Delete
$86:A431             dx 81D5,0002           ; Timer = 2
$86:A435             dx A3BE,               ; Reset position
                        81DF,1F,00,3F,04,   ; Move randomly within X radius 1Fh and Y radius 3Bh
                        8312,24,            ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
                        0008,B250,
                        0008,B257,
                        0008,B25E,
                        0008,B265,
                        81C6,A435,          ; Decrement timer and go to $A435 if non-zero
                        8154                ; Delete
}


;;; $A456: Instruction - go to [[Y]] with probability 1/4 ;;;
{
$86:A456 22 11 81 80 JSL $808111[$80:8111]
$86:A45A 29 00 C0    AND #$C000
$86:A45D C9 00 C0    CMP #$C000
$86:A460 F0 03       BEQ $03    [$A465]
$86:A462 C8          INY
$86:A463 C8          INY
$86:A464 60          RTS

$86:A465 B9 00 00    LDA $0000,y[$86:A402]
$86:A468 A8          TAY
$86:A469 60          RTS
}


;;; $A46A: Instruction list - Bomb Torizo low-health drool - 4 frame delay ;;;
{
$86:A46A             dw 0002,8000
}


;;; $A46E: Instruction list - Bomb Torizo low-health drool - 2 frame delay ;;;
{
$86:A46E             dw 0002,8000
}


;;; $A472: Instruction list - Bomb Torizo low-health drool - no delay ;;;
{
$86:A472             dx 8161,A887,  ; Pre-instruction = $A887
                        8230,3000,  ; Enemy projectile properties |= 3000h (high priority, disable collisions with Samus)
                        0005,8C54,
                        823C,EFFF   ; Enemy projectile properties &= EFFFh (low priority)
$86:A482             dx 0040,8C54,
                        81AB,A482   ; Go to $A482
}


;;; $A48A: Instruction list - Bomb Torizo low-health drool - hit wall ;;;
{
$86:A48A             dx 816A,       ; Clear pre-instruction
                        8154        ; Delete
}


;;; $A48E: Instruction list - Bomb Torizo low-health drool - hit floor ;;;
{
$86:A48E             dx 816A,       ; Clear pre-instruction
                        0008,8C5B,
                        0008,8C62,
                        0008,8C69,
                        8154        ; Delete
}


;;; $A49E: Instruction list - enemy projectile $A977 ;;;
{
$86:A49E             dx 8230,3000,  ; Enemy projectile properties |= 3000h (high priority, disable collisions with Samus)
                        0024,8C54,
                        81AB,A48E   ; Go to $A48E (Bomb Torizo low-health drool - hit floor)
}


;;; $A4AA: Instruction list - enemy projectile $A985 (Bomb Torizo explosive swipe) ;;;
{
$86:A4AA             dx 837E,26,    ; Queue sound 26h, sound library 2, max queued sounds allowed = 1 (Bomb Torizo explosive swipe)
                        0005,8D9C,
                        0005,8DA3,
                        0005,8DB9,
                        0005,8DCF,
                        0005,8DE5,
                        8154        ; Delete
}


;;; $A4C3: Instruction list - Bomb Torizo statue breaking - index = 0 ;;;
{
$86:A4C3             dx 0080,8DFB,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8DFB,
                        8154        ; Delete
}


;;; $A4D4: Instruction list - Bomb Torizo statue breaking - index = 2 ;;;
{
$86:A4D4             dx 0078,8E02,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E02,
                        8154        ; Delete
}


;;; $A4E5: Instruction list - Bomb Torizo statue breaking - index = 4 ;;;
{
$86:A4E5             dx 0070,8E09,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E09,
                        8154        ; Delete
}


;;; $A4F6: Instruction list - Bomb Torizo statue breaking - index = 6 ;;;
{
$86:A4F6             dx 0068,8E10,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E10,
                        8154        ; Delete
}


;;; $A507: Instruction list - Bomb Torizo statue breaking - index = 8 ;;;
{
$86:A507             dx 0060,8E17,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E17,
                        8154        ; Delete
}


;;; $A518: Instruction list - Bomb Torizo statue breaking - index = Ah ;;;
{
$86:A518             dx 0058,8E1E,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E1E,
                        8154        ; Delete
}


;;; $A529: Instruction list - Bomb Torizo statue breaking - index = Ch ;;;
{
$86:A529             dx 0050,8E25,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E25,
                        8154        ; Delete
}


;;; $A53A: Instruction list - Bomb Torizo statue breaking - index = Eh ;;;
{
$86:A53A             dx 0048,8E2C,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E2C,
                        8154        ; Delete
}


;;; $A54B: Instruction list - Bomb Torizo statue breaking - index = 10h ;;;
{
$86:A54B             dx 0040,8E33,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E33,
                        8154        ; Delete
}


;;; $A55C: Instruction list - Bomb Torizo statue breaking - index = 12h ;;;
{
$86:A55C             dx 0040,8E3A,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E3A,
                        8154        ; Delete
}


;;; $A56D: Instruction list - Bomb Torizo statue breaking - index = 14h ;;;
{
$86:A56D             dx 0040,8E41,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E41,
                        8154        ; Delete
}


;;; $A57E: Instruction list - Bomb Torizo statue breaking - index = 16h ;;;
{
$86:A57E             dx 0040,8E48,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E48,
                        8154        ; Delete
}


;;; $A58F: Instruction list - Bomb Torizo statue breaking - index = 18h ;;;
{
$86:A58F             dx 0040,8E4F,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E4F,
                        8154        ; Delete
}


;;; $A5A0: Instruction list - Bomb Torizo statue breaking - index = 1Ah ;;;
{
$86:A5A0             dx 0040,8E56,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E56,
                        8154        ; Delete
}


;;; $A5B1: Instruction list - Bomb Torizo statue breaking - index = 1Ch ;;;
{
$86:A5B1             dx 0040,8E5D,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E5D,
                        8154        ; Delete
}


;;; $A5C2: Instruction list - Bomb Torizo statue breaking - index = 1Eh ;;;
{
$86:A5C2             dx 0040,8E64,
                        8312,0C,    ; Queue sound Ch, sound library 2, max queued sounds allowed = 6 (torizo statue crumbles)
                        8161,A8EF,  ; Pre-instruction = $A8EF
                        0070,8E64,
                        8154        ; Delete
}
}


;;; $A5D3: Initialisation AI - enemy projectile $A95B (Bomb Torizo low-health continuous drool) ;;;
{
$86:A5D3 A9 00 00    LDA #$0000             ;\
$86:A5D6 99 BB 19    STA $19BB,y[$7E:19D7]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:A5D9 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:A5DD 4A          LSR A                  ;\
$86:A5DE 29 0E 00    AND #$000E             ;|
$86:A5E1 AA          TAX                    ;} Enemy projectile instruction list pointer = [$A64D + [random number] / 4 % 8 * 2]
$86:A5E2 BD 4D A6    LDA $A64D,x[$86:A659]  ;|
$86:A5E5 99 47 1B    STA $1B47,y[$7E:1B63]  ;/
$86:A5E8 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:A5EC AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:A5EF BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:A5F2 18          CLC                    ;|
$86:A5F3 69 FB FF    ADC #$FFFB             ;} Enemy projectile Y position = [enemy Y position] - 5
$86:A5F6 99 93 1A    STA $1A93,y[$7E:1AAF]  ;/
$86:A5F9 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:A5FC 50 08       BVC $08    [$A606]     ;} If torizo is turning around:
$86:A5FE AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:A601 29 FE 01    AND #$01FE             ;} X = [random number] / 2 % 100h * 2
$86:A604 80 1A       BRA $1A    [$A620]     ; Go to BRANCH_ANGLE_DETERMINED

$86:A606 30 05       BMI $05    [$A60D]     ; If torizo is facing left:
$86:A608 A9 E0 00    LDA #$00E0             ; $12 = E0h
$86:A60B 80 03       BRA $03    [$A610]
                                            ; Else (torizo is facing right):
$86:A60D A9 20 00    LDA #$0020             ; $12 = 20h

$86:A610 85 12       STA $12    [$7E:0012]
$86:A612 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:A615 29 0F 00    AND #$000F             ;|
$86:A618 38          SEC                    ;|
$86:A619 E9 08 00    SBC #$0008             ;} X = ([$12] + [random number] % 10h - 8) * 2
$86:A61C 18          CLC                    ;|
$86:A61D 65 12       ADC $12    [$7E:0012]  ;|
$86:A61F 0A          ASL A                  ;/

; BRANCH_ANGLE_DETERMINED
$86:A620 AA          TAX
$86:A621 BF 43 B4 A0 LDA $A0B443,x[$A0:B605];\
$86:A625 99 B7 1A    STA $1AB7,y[$7E:1AD3]  ;} Enemy projectile X velocity = sin([X] / 2 * pi / 80h) * 100h
$86:A628 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B585];\
$86:A62C 99 DB 1A    STA $1ADB,y[$7E:1AF7]  ;} Enemy projectile Y velocity = -cos([X] / 2 * pi / 80h) * 100h
$86:A62F AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:A632 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:A635 30 0B       BMI $0B    [$A642]     ;} If torizo is facing left:
$86:A637 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:A63A 18          CLC                    ;|
$86:A63B 69 F8 FF    ADC #$FFF8             ;} Enemy projectile X position = [enemy X position] - 8
$86:A63E 99 4B 1A    STA $1A4B,y[$7E:1A67]  ;/
$86:A641 60          RTS                    ; Return

$86:A642 BD 7A 0F    LDA $0F7A,x            ;\
$86:A645 18          CLC                    ;|
$86:A646 69 08 00    ADC #$0008             ;} Enemy projectile X position = [enemy X position] + 8
$86:A649 99 4B 1A    STA $1A4B,y            ;/
$86:A64C 60          RTS

; Instruction list pointers
$86:A64D             dw A472, A46E, A46A,
                        A472, A46E, A46A,
                        A472, A46E
}


;;; $A65D: Initialisation AI - enemy projectile $A969 (Bomb Torizo low-health initial drool) ;;;
{
$86:A65D A9 00 00    LDA #$0000             ;\
$86:A660 99 BB 19    STA $19BB,y[$7E:19CB]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:A663 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:A667 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:A66A AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:A66D 29 03 00    AND #$0003             ;|
$86:A670 18          CLC                    ;|
$86:A671 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]  ;} Enemy projectile Y position = [enemy Y position] - 5 + [random number] % 4
$86:A674 69 FB FF    ADC #$FFFB             ;|
$86:A677 99 93 1A    STA $1A93,y[$7E:1AA3]  ;/
$86:A67A AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:A67D 29 1F 00    AND #$001F             ;|
$86:A680 69 30 00    ADC #$0030             ;} Enemy projectile Y velocity = 30h + [random number]
$86:A683 99 DB 1A    STA $1ADB,y[$7E:1AEB]  ;/
$86:A686 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:A68A AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:A68D 29 03 00    AND #$0003             ;} A = [random number] % 4
$86:A690 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:A693 50 0E       BVC $0E    [$A6A3]     ;} If torizo is turning around:
$86:A695 18          CLC                    ;\
$86:A696 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;} Enemy projectile X position = [enemy X position] + [random number] % 4
$86:A699 99 4B 1A    STA $1A4B,y[$7E:1A61]  ;/
$86:A69C A9 00 00    LDA #$0000             ;\
$86:A69F 99 B7 1A    STA $1AB7,y[$7E:1ACD]  ;} Enemy projectile X velocity = 0
$86:A6A2 60          RTS                    ; Return

$86:A6A3 30 11       BMI $11    [$A6B6]     ; If torizo is facing left:
$86:A6A5 18          CLC                    ;\
$86:A6A6 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;|
$86:A6A9 69 F8 FF    ADC #$FFF8             ;} Enemy projectile X position = [enemy X position] - 8 + [random number] % 4
$86:A6AC 99 4B 1A    STA $1A4B,y[$7E:1A5B]  ;/
$86:A6AF A9 00 00    LDA #$0000             ;\
$86:A6B2 99 B7 1A    STA $1AB7,y[$7E:1AC7]  ;} Enemy projectile X velocity = 0
$86:A6B5 60          RTS                    ; Return

$86:A6B6 18          CLC                    ;\
$86:A6B7 7D 7A 0F    ADC $0F7A,x[$7E:0F7A]  ;|
$86:A6BA 69 08 00    ADC #$0008             ;} Enemy projectile X position = [enemy X position] + 8 + [random number] % 4
$86:A6BD 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:A6C0 A9 00 00    LDA #$0000             ;\
$86:A6C3 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = 0
$86:A6C6 60          RTS
}


;;; $A6C7: Initialisation AI - enemy projectile $A977 ;;;
{
$86:A6C7 A9 00 00    LDA #$0000             ;\
$86:A6CA 99 BB 19    STA $19BB,y            ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:A6CD AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:A6D0 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:A6D4 AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:A6D7 0A          ASL A                  ;|
$86:A6D8 0A          ASL A                  ;|
$86:A6D9 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h
$86:A6DA 0A          ASL A                  ;|
$86:A6DB 99 4B 1A    STA $1A4B,y            ;/
$86:A6DE AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:A6E1 0A          ASL A                  ;|
$86:A6E2 0A          ASL A                  ;|
$86:A6E3 0A          ASL A                  ;|
$86:A6E4 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h - 4
$86:A6E5 38          SEC                    ;|
$86:A6E6 E9 04 00    SBC #$0004             ;|
$86:A6E9 99 93 1A    STA $1A93,y            ;/
$86:A6EC A9 00 00    LDA #$0000
$86:A6EF 99 27 1A    STA $1A27,y
$86:A6F2 99 6F 1A    STA $1A6F,y            ; Enemy projectile Y subposition = 0
$86:A6F5 60          RTS
}


;;; $A6F6: Initialisation AI - enemy projectile $A985 (Bomb Torizo explosive swipe) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Multiple of 2, range 0..14h
$86:A6F6 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:A6F9 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:A6FC 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:A6FE BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:A701 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:A703 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:A706 30 16       BMI $16    [$A71E]     ;} If torizo is facing left:
$86:A708 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:A70B BD 38 A7    LDA $A738,x[$86:A738]  ;\
$86:A70E 18          CLC                    ;|
$86:A70F 65 12       ADC $12    [$7E:0012]  ;} Enemy projectile X position = [$12] + [$A738 + [X]]
$86:A711 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:A714 BD 4E A7    LDA $A74E,x[$86:A74E]  ;\
$86:A717 18          CLC                    ;|
$86:A718 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile Y position = [$14] + [$A74E + [X]]
$86:A71A 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:A71D 60          RTS                    ; Return

$86:A71E AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:A721 BD 38 A7    LDA $A738,x            ;\
$86:A724 49 FF FF    EOR #$FFFF             ;|
$86:A727 1A          INC A                  ;|
$86:A728 18          CLC                    ;} Enemy projectile X position = [$12] - [$A738 + [X]]
$86:A729 65 12       ADC $12    [$7E:0012]  ;|
$86:A72B 99 4B 1A    STA $1A4B,y            ;/
$86:A72E BD 4E A7    LDA $A74E,x            ;\
$86:A731 18          CLC                    ;|
$86:A732 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile Y position = [$14] + [$A74E + [X]]
$86:A734 99 93 1A    STA $1A93,y            ;/
$86:A737 60          RTS

;                                                                                    _ Unused
;                                                                                   |
$86:A738             dw FFE2, FFD8, FFD1, FFE1, FFEB, FFFF, FFE4, FFD5, FFD0, FFE1, FFEB ; X position
$86:A74E             dw FFCC, FFE4, FFF5, 0009, 0015, 0014, FFCC, FFE5, FFF6, 0009, 0014 ; Y position
}


;;; $A764: Initialisation AI - enemy projectile $A993 (Bomb Torizo statue breaking) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Multiple of 2, range 0..1Eh
$86:A764 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:A767 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:A76B AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:A76E BD AB A7    LDA $A7AB,x[$86:A7AB]  ;\
$86:A771 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = [$A7AB + [X]]
$86:A774 AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:A777 0A          ASL A                  ;|
$86:A778 0A          ASL A                  ;|
$86:A779 0A          ASL A                  ;|
$86:A77A 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 100h + [$A7CB + [X]]
$86:A77B 18          CLC                    ;|
$86:A77C 7D CB A7    ADC $A7CB,x[$86:A7CB]  ;|
$86:A77F 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:A782 8A          TXA                    ;\
$86:A783 29 0F 00    AND #$000F             ;} X %= 10h
$86:A786 AA          TAX                    ;/
$86:A787 AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:A78A 0A          ASL A                  ;|
$86:A78B 0A          ASL A                  ;|
$86:A78C 0A          ASL A                  ;|
$86:A78D 0A          ASL A                  ;} Enemy projectile Y position += [PLM Y block] * 10h + [$A7EB + [X]]
$86:A78E 18          CLC                    ;|
$86:A78F 7D EB A7    ADC $A7EB,x[$86:A7EB]  ;|
$86:A792 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:A795 BD FB A7    LDA $A7FB,x[$86:A7FB]  ;\
$86:A798 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = 100h
$86:A79B BD 0B A8    LDA $A80B,x[$86:A80B]  ;\
$86:A79E 99 23 1B    STA $1B23,y[$7E:1B45]  ;} Enemy projectile Y acceleration = 10h
$86:A7A1 B9 D7 1B    LDA $1BD7,y[$7E:1BF9]  ;\
$86:A7A4 09 00 10    ORA #$1000             ;} Set enemy projectile high priority
$86:A7A7 99 D7 1B    STA $1BD7,y[$7E:1BF9]  ;/
$86:A7AA 60          RTS

; Instruction list pointers
$86:A7AB             dw A4C3,A4D4,A4E5,A4F6,A507,A518,A529,A53A,
                        A54B,A55C,A56D,A57E,A58F,A5A0,A5B1,A5C2 ; Unused. TODO: check if these face the other way

; X offsets
$86:A7CB             dw 0008,0018,FFF8,0008,0018,FFF8,0008,0018,
                        0008,FFF8,0018,0008,FFF8,0018,0008,FFF8 ; Unused

; Y offsets
$86:A7EB             dw FFF8,FFF8,0008,0008,0008,0018,0018,0018

; Y velocities (unit 1/100h px/frame)
$86:A7FB             dw 0100,0100,0100,0100,0100,0100,0100,0100

; Y accelerations (unit 1/100h px/frame²)
$86:A80B             dw 0010,0010,0010,0010,0010,0010,0010,0010
}


;;; $A81B: Initialisation AI - enemy projectile $A9A1 (Bomb Torizo low-health explosion) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. 0 (BT's gut) or 6 (BT's face)
$86:A81B AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:A81E BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:A821 99 4B 1A    STA $1A4B,y[$7E:1A59]  ;} Enemy projectile X position = [enemy X position]
$86:A824 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:A827 99 93 1A    STA $1A93,y[$7E:1AA1]  ;} Enemy projectile Y position = [enemy Y position]
$86:A82A 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:A82D 30 06       BMI $06    [$A835]     ;} If torizo is facing left:
$86:A82F EE 93 19    INC $1993  [$7E:1993]  ;\
$86:A832 EE 93 19    INC $1993  [$7E:1993]  ;} Enemy projectile initialisation parameter 0 += 2

$86:A835 EE 93 19    INC $1993  [$7E:1993]  ;\
$86:A838 EE 93 19    INC $1993  [$7E:1993]  ;} Enemy projectile initialisation parameter 0 += 2
$86:A83B AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:A83E B9 4B 1A    LDA $1A4B,y[$7E:1A59]  ;\
$86:A841 18          CLC                    ;|
$86:A842 7D 59 A8    ADC $A859,x[$86:A85D]  ;} Enemy projectile X position += [$A859 + [X]]
$86:A845 99 4B 1A    STA $1A4B,y[$7E:1A59]  ;/
$86:A848 99 FF 1A    STA $1AFF,y[$7E:1B0D]  ; Enemy projectile reset X position = [enemy projectile X position]
$86:A84B B9 93 1A    LDA $1A93,y[$7E:1AA1]  ;\
$86:A84E 18          CLC                    ;|
$86:A84F 7D 65 A8    ADC $A865,x[$86:A869]  ;} Enemy projectile Y position += [$A865 + [X]]
$86:A852 99 93 1A    STA $1A93,y[$7E:1AA1]  ;/
$86:A855 99 23 1B    STA $1B23,y[$7E:1B31]  ; Enemy projectile reset Y position = [enemy projectile Y position]
$86:A858 60          RTS

;                        _____________ Unused
;                       |     ________ Facing right
;                       |    |     ___ Facing left
;                       |    |    |
; X offsets
$86:A859             dw 0000,000C,FFF4,
                        0000,0010,FFF0

; Y offsets
$86:A865             dw FFF8,FFF8,FFF8,
                        FFEC,FFEC,FFEC
}


;;; $A871: Initialisation AI - enemy projectile $A9AF (torizo death explosion) ;;;
{
$86:A871 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:A874 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:A877 99 4B 1A    STA $1A4B,y[$7E:1A63]  ;} Enemy projectile X position = [enemy X position]
$86:A87A 99 FF 1A    STA $1AFF,y[$7E:1B17]  ; Enemy projectile reset X position = [enemy projectile X position]
$86:A87D BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:A880 99 93 1A    STA $1A93,y[$7E:1AAB]  ;} Enemy projectile Y position = [enemy Y position]
$86:A883 99 23 1B    STA $1B23,y[$7E:1B3B]  ; Enemy projectile reset Y position = [enemy projectile Y position]
$86:A886 60          RTS
}


;;; $A887: Pre-instruction - Bomb Torizo low-health drool - falling ;;;
{
$86:A887 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:A88A B0 3F       BCS $3F    [$A8CB]     ; If collision: go to BRANCH_HIT_WALL
$86:A88C BD B7 1A    LDA $1AB7,x[$7E:1AC7]  ;\
$86:A88F 10 0E       BPL $0E    [$A89F]     ;} If [enemy projectile X velocity] >= 0: go to BRANCH_RIGHT
$86:A891 18          CLC                    ;\
$86:A892 69 04 00    ADC #$0004             ;} Enemy projectile X velocity += 4
$86:A895 30 03       BMI $03    [$A89A]     ; If [enemy projectile X velocity] >= 0:
$86:A897 A9 03 00    LDA #$0003             ; Enemy projectile X velocity = 3

$86:A89A 9D B7 1A    STA $1AB7,x[$7E:1AD3]
$86:A89D 80 0C       BRA $0C    [$A8AB]     ; Go to BRANCH_MERGE

; BRANCH_RIGHT
$86:A89F 38          SEC                    ;\
$86:A8A0 E9 04 00    SBC #$0004             ;} Enemy projectile X velocity -= 4
$86:A8A3 10 03       BPL $03    [$A8A8]     ; If [enemy projectile X velocity] < 0:
$86:A8A5 A9 03 00    LDA #$0003             ; Enemy projectile X velocity = 3

$86:A8A8 9D B7 1A    STA $1AB7,x[$7E:1AC7]

; BRANCH_MERGE
$86:A8AB 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:A8AE 3C DB 1A    BIT $1ADB,x[$7E:1AEB]  ;\
$86:A8B1 30 02       BMI $02    [$A8B5]     ;} If [enemy projectile Y velocity] >= 0:
$86:A8B3 B0 23       BCS $23    [$A8D8]     ; If collision detected: go to BRANCH_HIT_FLOOR

$86:A8B5 BD DB 1A    LDA $1ADB,x[$7E:1AEB]  ;\
$86:A8B8 18          CLC                    ;|
$86:A8B9 69 10 00    ADC #$0010             ;} Enemy projectile Y velocity += 10h
$86:A8BC 9D DB 1A    STA $1ADB,x[$7E:1AEB]  ;/
$86:A8BF 29 00 F0    AND #$F000             ;\
$86:A8C2 C9 00 10    CMP #$1000             ;} If [enemy projectile Y velocity] / 1000h = 1:
$86:A8C5 D0 03       BNE $03    [$A8CA]     ;/
$86:A8C7 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:A8CA 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:A8CB A9 8A A4    LDA #$A48A             ;\
$86:A8CE 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $A48A
$86:A8D1 A9 01 00    LDA #$0001             ;\
$86:A8D4 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:A8D7 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:A8D8 BD 93 1A    LDA $1A93,x[$7E:1AA3]  ;\
$86:A8DB 38          SEC                    ;|
$86:A8DC E9 03 00    SBC #$0003             ;} Enemy projectile Y position -= 3
$86:A8DF 9D 93 1A    STA $1A93,x[$7E:1AA3]  ;/
$86:A8E2 A9 8E A4    LDA #$A48E             ;\
$86:A8E5 9D 47 1B    STA $1B47,x[$7E:1B57]  ;} Enemy projectile instruction list pointer = $A48E
$86:A8E8 A9 01 00    LDA #$0001             ;\
$86:A8EB 9D 8F 1B    STA $1B8F,x[$7E:1B9F]  ;} Enemy projectile instruction timer = 1
$86:A8EE 60          RTS
}


;;; $A8EF: Pre-instruction - Bomb Torizo statue breaking - falling / enemy projectile $A977 ;;;
{
$86:A8EF 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:A8F2 3C DB 1A    BIT $1ADB,x[$7E:1AFD]  ;\
$86:A8F5 30 02       BMI $02    [$A8F9]     ;} If [enemy projectile Y velocity] >= 0:
$86:A8F7 B0 19       BCS $19    [$A912]     ; If collision detected: go to BRANCH_HIT_FLOOR

$86:A8F9 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:A8FC 18          CLC                    ;|
$86:A8FD 6D 23 1B    ADC $1B23  [$7E:1B23]  ;} Enemy projectile Y velocity += [enemy projectile 0 Y acceleration] <-- bug
$86:A900 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:A903 29 00 F0    AND #$F000             ;\
$86:A906 C9 00 10    CMP #$1000             ;} If [enemy projectile Y velocity] / 1000h = 1:
$86:A909 D0 06       BNE $06    [$A911]     ;/
$86:A90B A9 00 10    LDA #$1000             ;\
$86:A90E 9D DB 1A    STA $1ADB,x            ;} Enemy projectile Y velocity = 1000h

$86:A911 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:A912 A9 18 A9    LDA #$A918             ;\
$86:A915 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS

$86:A918 60          RTS
}


;;; $A919: RTS. Pre-instruction - enemy projectile $A985 (Bomb Torizo explosive swipe) ;;;
{
$86:A919 60          RTS
}


;;; $A91A: Unused. Debug. Move enemy projectile with controller 2 ;;;
{
$86:A91A 9E B7 1A    STZ $1AB7,x            ; Enemy projectile X velocity = 0
$86:A91D A5 8D       LDA $8D    [$7E:008D]  ;\
$86:A91F 89 00 01    BIT #$0100             ;} If controller 2 pressing right:
$86:A922 F0 06       BEQ $06    [$A92A]     ;/
$86:A924 A9 00 01    LDA #$0100             ;\
$86:A927 9D B7 1A    STA $1AB7,x            ;} Enemy projectile X velocity = 100h

$86:A92A A5 8D       LDA $8D    [$7E:008D]  ;\
$86:A92C 89 00 02    BIT #$0200             ;} If controller 2 pressing left:
$86:A92F F0 06       BEQ $06    [$A937]     ;/
$86:A931 A9 00 FF    LDA #$FF00             ;\
$86:A934 9D B7 1A    STA $1AB7,x            ;} Enemy projectile X velocity = -100h

$86:A937 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:A93A 9E DB 1A    STZ $1ADB,x            ; Enemy projectile Y velocity = 0
$86:A93D A5 8D       LDA $8D    [$7E:008D]  ;\
$86:A93F 89 00 04    BIT #$0400             ;} If controller 2 pressing down:
$86:A942 F0 06       BEQ $06    [$A94A]     ;/
$86:A944 A9 00 01    LDA #$0100             ;\
$86:A947 9D DB 1A    STA $1ADB,x            ;} Enemy projectile Y velocity = 100h

$86:A94A A5 8D       LDA $8D    [$7E:008D]  ;\
$86:A94C 89 00 08    BIT #$0800             ;} If controller 2 pressing up:
$86:A94F F0 06       BEQ $06    [$A957]     ;/
$86:A951 A9 00 FF    LDA #$FF00             ;\
$86:A954 9D DB 1A    STA $1ADB,x            ;} Enemy projectile Y velocity = -100h

$86:A957 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:A95A 60          RTS
}


;;; $A95B: Enemy projectiles - torizo ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:A95B             dx A5D3,84FB,A472,01,02,3000,0000,84FC ; Bomb Torizo low-health continuous drool. Initial instruction list ignored
$86:A969             dx A65D,84FB,A472,01,02,2000,0000,84FC ; Bomb Torizo low-health initial drool
$86:A977             dx A6C7,A8EF,A49E,00,00,3000,0000,84FC ; Unused. Seems statue breaking esque, also seems like drool (maybe statue drool?)
$86:A985             dx A6F6,A919,A4AA,10,10,500A,0000,84FC ; Bomb Torizo explosive swipe
$86:A993             dx A764,84FB,A54B,08,08,3000,0000,84FC ; Bomb Torizo statue breaking. Initial instruction list ignored
$86:A9A1             dx A81B,84FB,A3CB,04,10,3000,0000,84FC ; Bomb Torizo low-health explosion
$86:A9AF             dx A871,84FB,A3FA,04,10,3000,0000,84FC ; Torizo death explosion
}
}


;;; $A9BD..AB14: Enemy projectile $AB07 (question mark) ;;;
{
;;; $A9BD: Tiles ;;;
{
; |--------|--------|
; |     111|111     |
; |    1111|1111    |
; |   11B  |  111   |
; |  11B   |   111  |
; |  11B   |   111  |
; |  111B  |   11B  |
; |   11B  |  11B   |
; |        |111B    |
; |--------|--------|
; |       1|11B     |
; |      11|1B      |
; |      11|11      |
; |       1|1B      |
; |        |        |
; |       1|1B      |
; |      11|11      |
; |       1|1B      |
; |--------|--------|

$86:A9BD             db 07,00,0F,00,1C,04,38,08,38,08,3C,04,1C,04,00,00,00,00,00,00,00,04,00,08,00,08,00,04,00,04,00,00,
                        E0,00,F0,00,38,00,1C,00,1C,00,1C,04,38,08,F0,10,00,00,00,00,00,00,00,00,00,00,00,04,00,08,00,10

$86:A9FD             db 01,00,03,00,03,00,01,00,00,00,01,00,03,00,01,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        E0,20,C0,40,C0,00,C0,40,00,00,C0,40,C0,00,C0,40,00,20,00,40,00,00,00,40,00,00,00,40,00,00,00,40
}


;;; $AA3D: Initialisation AI - enemy projectile $AB07 ;;;
{
$86:AA3D AE 30 03    LDX $0330  [$7E:0330]  ;\
$86:AA40 A9 40 00    LDA #$0040             ;|
$86:AA43 95 D0       STA $D0,x              ;|
$86:AA45 A9 BD A9    LDA #$A9BD             ;|
$86:AA48 95 D2       STA $D2,x              ;|
$86:AA4A A9 86 00    LDA #$0086             ;|
$86:AA4D 95 D4       STA $D4,x              ;} Queue transfer of $86:A9BD..FC to VRAM $6E00..1F
$86:AA4F A9 00 6E    LDA #$6E00             ;|
$86:AA52 95 D5       STA $D5,x              ;|
$86:AA54 8A          TXA                    ;|
$86:AA55 18          CLC                    ;|
$86:AA56 69 07 00    ADC #$0007             ;|
$86:AA59 8D 30 03    STA $0330  [$7E:0330]  ;/
$86:AA5C AE 30 03    LDX $0330  [$7E:0330]  ;\
$86:AA5F A9 40 00    LDA #$0040             ;|
$86:AA62 95 D0       STA $D0,x              ;|
$86:AA64 A9 FD A9    LDA #$A9FD             ;|
$86:AA67 95 D2       STA $D2,x              ;|
$86:AA69 A9 86 00    LDA #$0086             ;|
$86:AA6C 95 D4       STA $D4,x              ;} Queue transfer of $86:A9FD..AA3D to VRAM $6F00..1F
$86:AA6E A9 00 6F    LDA #$6F00             ;|
$86:AA71 95 D5       STA $D5,x              ;|
$86:AA73 8A          TXA                    ;|
$86:AA74 18          CLC                    ;|
$86:AA75 69 07 00    ADC #$0007             ;|
$86:AA78 8D 30 03    STA $0330  [$7E:0330]  ;/
$86:AA7B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:AA7E 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [Samus X position]
$86:AA81 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:AA84 38          SEC                    ;|
$86:AA85 E9 24 00    SBC #$0024             ;} Enemy projectile Y position = [Samus Y position] - 24h
$86:AA88 99 93 1A    STA $1A93,y            ;/
$86:AA8B 60          RTS
}


;;; $AA8C: Pre-instruction - enemy projectile $AB07 ;;;
{
; The `BPL + : DEC $14 : +` should really be done *before* the `ASL #3` >_<;
; Oh well
$86:AA8C 64 12       STZ $12    [$7E:0012]  ;\
$86:AA8E 64 14       STZ $14    [$7E:0014]  ;|
$86:AA90 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$86:AA93 38          SEC                    ;|
$86:AA94 FD 4B 1A    SBC $1A4B,x            ;|
$86:AA97 0A          ASL A                  ;|
$86:AA98 0A          ASL A                  ;|
$86:AA99 0A          ASL A                  ;|
$86:AA9A 10 02       BPL $02    [$AA9E]     ;|
$86:AA9C C6 14       DEC $14    [$7E:0014]  ;} Enemy projectile X position += ([Samus X position] - [enemy projectile X position]) / 20h
                                            ;|
$86:AA9E 85 13       STA $13    [$7E:0013]  ;|
$86:AAA0 A5 12       LDA $12    [$7E:0012]  ;|
$86:AAA2 18          CLC                    ;|
$86:AAA3 7D 27 1A    ADC $1A27,x            ;|
$86:AAA6 9D 27 1A    STA $1A27,x            ;|
$86:AAA9 A5 14       LDA $14    [$7E:0014]  ;|
$86:AAAB 7D 4B 1A    ADC $1A4B,x            ;|
$86:AAAE 9D 4B 1A    STA $1A4B,x            ;/
$86:AAB1 64 12       STZ $12    [$7E:0012]  ;\
$86:AAB3 64 14       STZ $14    [$7E:0014]  ;|
$86:AAB5 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$86:AAB8 38          SEC                    ;|
$86:AAB9 E9 24 00    SBC #$0024             ;|
$86:AABC 38          SEC                    ;|
$86:AABD FD 93 1A    SBC $1A93,x            ;|
$86:AAC0 0A          ASL A                  ;|
$86:AAC1 0A          ASL A                  ;|
$86:AAC2 0A          ASL A                  ;|
$86:AAC3 10 02       BPL $02    [$AAC7]     ;} Enemy projectile Y position += ([Samus Y position] - 24h - [enemy projectile Y position]) / 20h
$86:AAC5 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:AAC7 85 13       STA $13    [$7E:0013]  ;|
$86:AAC9 A5 12       LDA $12    [$7E:0012]  ;|
$86:AACB 18          CLC                    ;|
$86:AACC 7D 6F 1A    ADC $1A6F,x            ;|
$86:AACF 9D 6F 1A    STA $1A6F,x            ;|
$86:AAD2 A5 14       LDA $14    [$7E:0014]  ;|
$86:AAD4 7D 93 1A    ADC $1A93,x            ;|
$86:AAD7 9D 93 1A    STA $1A93,x            ;/
$86:AADA 60          RTS
}


;;; $AADB: Instruction list - enemy projectile $AB07 ;;;
{
$86:AADB             dx 831B,09,    ; Queue sound 9, sound library 3, max queued sounds allowed = 6 (shot zebetite / shot missile door with missile)
                        012C,8C4D,
                        81D5,0018   ; Timer = 18h
$86:AAE6             dx 0002,8C4D,
                        0002,8000,
                        81C6,AAE6   ; Decrement timer and go to $AAE6 if non-zero
}


;;; $AAF2: Shot instruction list - enemy projectile $AB07 ;;;
{
$86:AAF2             dx 8312,0D,    ; Queue sound Dh, sound library 2, max queued sounds allowed = 6 (splashed into water)
                        0008,B250,
                        0008,B257,
                        0008,B25E,
                        0008,B265,
                        8154        ; Delete
}


;;; $AB07: Unused. Enemy projectile $AB07 ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:AB07             dx AA3D,AA8C,AADB,00,00,B000,0000,AAF2
}
}


;;; $AB15..AD87: Torizo chozo orbs ;;;
{
;;; $AB15: Instruction list - torizo chozo orbs - leftwards ;;;
{
$86:AB15             dx 0055,8C70,
                        81AB,AB15   ; Go to $AB15
}


;;; $AB1D: Instruction list - torizo chozo orbs - rightwards ;;;
{
$86:AB1D             dx 0055,8C77,
                        81AB,AB1D   ; Go to $AB1D
}


;;; $AB25: Instruction list - torizo chozo orbs - break on wall / shot instruction list - enemy projectile $B1C0 (Golden Torizo egg) ;;;
{
$86:AB25             dx 816A,       ; Clear pre-instruction
                        8230,5000,  ; Enemy projectile properties |= 5000h (don't die on contact, high priority)
                        0004,8D9C,
                        0004,8DA3,
                        0004,8DB9,
                        0004,8DCF,
                        0004,8DE5,
                        8154        ; Delete
}


;;; $AB41: Instruction list - torizo chozo orbs - break on floor ;;;
{
$86:AB41             dx 816A,       ; Clear pre-instruction
                        823C,DFFF,  ; Enemy projectile properties &= DFFFh (enable collisions with Samus)
                        8230,5000,  ; Enemy projectile properties |= 5000h (don't die on contact, high priority)
                        831B,13,    ; Queue sound 13h, sound library 3, max queued sounds allowed = 6 (Mother Brain's / Torizo's projectile hits surface / Shitroid exploding)
                        0004,8C7E,
                        0005,8C85,
                        0006,8C91,
                        0007,8CA7,
                        0008,8CB8,
                        0009,8CC9,
                        8154        ; Delete
}


;;; $AB68: Shot instruction list - enemy projectile $AD5E/$AD6C/$AD7A (torizo chozo orbs) ;;;
{
$86:AB68             dx 816A,           ; Clear pre-instruction
                        8230,5000,      ; Enemy projectile properties |= 5000h (don't die on contact, high priority)
                        0004,8D9C,
                        0004,8DA3,
                        0004,8DB9,
                        0004,8DCF,
                        0004,8DE5,
                        AB8A,EF3F,EFBF  ; Spawn enemy drops with enemy $EF3F or enemy $EFBF's drop chances
                        8154            ; Delete
}


;;; $AB8A: Instruction - spawn enemy drops with enemy [[Y]] or enemy [[Y] + 2]'s drop chances ;;;
{
$86:AB8A 5A          PHY
$86:AB8B DA          PHX
$86:AB8C BD 4B 1A    LDA $1A4B,x[$7E:1A61]  ;\
$86:AB8F 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:AB91 BD 93 1A    LDA $1A93,x[$7E:1AA9]  ;\
$86:AB94 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:AB96 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$86:AB99 F0 05       BEQ $05    [$ABA0]     ;} If [area index] != Crateria:
$86:AB9B B9 02 00    LDA $0002,y[$86:AB86]  ; A = [[Y] + 2] (Golden Torizo orb)
$86:AB9E 80 03       BRA $03    [$ABA3]
                                            ; Else ([area index] = Crateria):
$86:ABA0 B9 00 00    LDA $0000,y[$86:AB84]  ; A = [[Y]] (Bomb Torizo orb)

$86:ABA3 22 0E 92 A0 JSL $A0920E[$A0:920E]  ; Spawn enemy drops
$86:ABA7 FA          PLX
$86:ABA8 7A          PLY
$86:ABA9 C8          INY                    ;\
$86:ABAA C8          INY                    ;|
$86:ABAB C8          INY                    ;} Y += 4
$86:ABAC C8          INY                    ;/
$86:ABAD 60          RTS
}


;;; $ABAE: Torizo chozo orbs / egg / eye beam common initialisation ;;;
{
;; Parameters:
;;     X: Pointer to constants (see $AC08/$AC99)
;;     Y: Enemy projectile index
;;     $12: Enemy X position
;;     $14: Enemy Y position
$86:ABAE BD 00 00    LDA $0000,x[$86:AC12]  ;\
$86:ABB1 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = [[X]]
$86:ABB4 A5 12       LDA $12    [$7E:0012]  ;\
$86:ABB6 18          CLC                    ;|
$86:ABB7 7D 02 00    ADC $0002,x[$86:AC14]  ;} Enemy projectile X position = [$12] + [[X] + 2]
$86:ABBA 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:ABBD 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:ABC1 29 FF 00    AND #$00FF             ;\
$86:ABC4 38          SEC                    ;|
$86:ABC5 E9 80 00    SBC #$0080             ;|
$86:ABC8 18          CLC                    ;} Enemy projectile X velocity = [[X] + 4] + [random number] % 100h - 80h
$86:ABC9 7D 04 00    ADC $0004,x[$86:AC16]  ;|
$86:ABCC 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:ABCF A5 14       LDA $14    [$7E:0014]  ;\
$86:ABD1 18          CLC                    ;|
$86:ABD2 7D 06 00    ADC $0006,x[$86:AC18]  ;} Enemy projectile Y position = [$14] + [[X] + 6]
$86:ABD5 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:ABD8 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:ABDC 29 FF 00    AND #$00FF             ;\
$86:ABDF 38          SEC                    ;|
$86:ABE0 E9 80 00    SBC #$0080             ;|
$86:ABE3 18          CLC                    ;} Enemy projectile Y velocity = [[X] + 8] + [random number] % 100h - 80h
$86:ABE4 7D 08 00    ADC $0008,x[$86:AC1A]  ;|
$86:ABE7 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;/
$86:ABEA 60          RTS
}


;;; $ABEB: Initialisation AI - enemy projectile $AD5E/$AD6C (Bomb Torizo's chozo orbs) ;;;
{
$86:ABEB AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:ABEE BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:ABF1 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:ABF3 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:ABF6 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:ABF8 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:ABFB 30 05       BMI $05    [$AC02]     ;} If torizo is facing left:
$86:ABFD A2 12 AC    LDX #$AC12             ; X = $AC12
$86:AC00 80 03       BRA $03    [$AC05]
                                            ; Else (torizo is facing right):
$86:AC02 A2 08 AC    LDX #$AC08             ; X = $AC08

$86:AC05 4C AE AB    JMP $ABAE  [$86:ABAE]  ; Go to torizo chozo orbs / egg / eye beam common initialisation

;                        _______________________ Instruction list pointer
;                       |     __________________ X offset
;                       |    |     _____________ X velocity (unit 1/100h px/frame)
;                       |    |    |     ________ Y offset
;                       |    |    |    |     ___ Y velocity (unit 1/100h px/frame)
;                       |    |    |    |    |
$86:AC08             dw AB1D,001B,0190,FFD8,FE60 ; Rightwards
$86:AC12             dw AB15,FFE5,FE70,FFD8,FE60 ; Leftwards
}


;;; $AC1C: Unused. Initialise torizo chozo orb to target Samus ;;;
{
$86:AC1C 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:AC20 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AC23 22 66 C0 A0 JSL $A0C066[$A0:C066]  ;\
$86:AC27 85 12       STA $12    [$7E:0012]  ;} $12 = angle of Samus from enemy
$86:AC29 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:AC2C 29 0F 00    AND #$000F             ;|
$86:AC2F 38          SEC                    ;|
$86:AC30 E9 08 00    SBC #$0008             ;} A = [$12] + [random number] % 10h - 8
$86:AC33 18          CLC                    ;|
$86:AC34 65 12       ADC $12    [$7E:0012]  ;/
$86:AC36 0A          ASL A                  ;\
$86:AC37 AA          TAX                    ;|
$86:AC38 BF 43 B4 A0 LDA $A0B443,x          ;} Enemy projectile X velocity = 100h * sin([A] * pi / 80h)
$86:AC3C 0A          ASL A                  ;|
$86:AC3D 99 B7 1A    STA $1AB7,y            ;/
$86:AC40 BF C3 B3 A0 LDA $A0B3C3,x          ;\
$86:AC44 0A          ASL A                  ;} Enemy projectile Y velocity = 100h * -cos([A] * pi / 80h)
$86:AC45 99 DB 1A    STA $1ADB,y            ;/
$86:AC48 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AC4B BD 7E 0F    LDA $0F7E,x            ;\
$86:AC4E 18          CLC                    ;|
$86:AC4F 69 D8 FF    ADC #$FFD8             ;} Enemy projectile Y position = [enemy Y position] - 28h
$86:AC52 99 93 1A    STA $1A93,y            ;/
$86:AC55 3C B4 0F    BIT $0FB4,x            ;\
$86:AC58 30 11       BMI $11    [$AC6B]     ;} If torizo is facing left:
$86:AC5A BD 7A 0F    LDA $0F7A,x            ;\
$86:AC5D 18          CLC                    ;|
$86:AC5E 69 E5 FF    ADC #$FFE5             ;} Enemy projectile X position = [enemy X position] - 1Bh
$86:AC61 99 4B 1A    STA $1A4B,y            ;/
$86:AC64 A9 15 AB    LDA #$AB15             ;\
$86:AC67 99 47 1B    STA $1B47,y            ;} Enemy projectile instruction list pointer = $AB15 (leftwards)
$86:AC6A 60          RTS                    ; Return

$86:AC6B BD 7A 0F    LDA $0F7A,x            ;\
$86:AC6E 18          CLC                    ;|
$86:AC6F 69 1B 00    ADC #$001B             ;} Enemy projectile X position = [enemy X position] + 1Bh
$86:AC72 99 4B 1A    STA $1A4B,y            ;/
$86:AC75 A9 1D AB    LDA #$AB1D             ;\
$86:AC78 99 47 1B    STA $1B47,y            ;} Enemy projectile instruction list pointer = $AB1D (rightwards)
$86:AC7B 60          RTS
}


;;; $AC7C: Initialisation AI - enemy projectile $AD7A (Golden Torizo's chozo orbs) ;;;
{
$86:AC7C AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AC7F BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:AC82 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:AC84 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:AC87 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:AC89 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:AC8C 30 05       BMI $05    [$AC93]     ;} If torizo is facing left:
$86:AC8E A2 A3 AC    LDX #$ACA3             ; X = $ACA3
$86:AC91 80 03       BRA $03    [$AC96]
                                            ; Else (torizo is facing right):
$86:AC93 A2 99 AC    LDX #$AC99             ; X = $AC99

$86:AC96 4C AE AB    JMP $ABAE  [$86:ABAE]  ; Go to torizo chozo orbs / egg / eye beam common initialisation

;                        _______________________ Instruction list pointer
;                       |     __________________ X offset
;                       |    |     _____________ X velocity (unit 1/100h px/frame)
;                       |    |    |     ________ Y offset
;                       |    |    |    |     ___ Y velocity (unit 1/100h px/frame)
;                       |    |    |    |    |
$86:AC99             dw AB1D,001B,0100,FFD8,FE40 ; Rightwards
$86:ACA3             dw AB15,FFE5,FF00,FFD8,FE40 ; Leftwards
}


;;; $ACAD: Pre-instruction - enemy projectile $AD5E/$AD6C (Bomb Torizo's chozo orbs) ;;;
{
$86:ACAD 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:ACB0 B0 20       BCS $20    [$ACD2]     ; If collision: go to BRANCH_HIT_WALL
$86:ACB2 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:ACB5 3C DB 1A    BIT $1ADB,x[$7E:1AFD]  ;\
$86:ACB8 30 02       BMI $02    [$ACBC]     ;} If [enemy projectile Y velocity] >= 0:
$86:ACBA B0 23       BCS $23    [$ACDF]     ; If collision detected: go to BRANCH_HIT_FLOOR

$86:ACBC BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:ACBF 18          CLC                    ;|
$86:ACC0 69 12 00    ADC #$0012             ;} Enemy projectile Y velocity += 12h
$86:ACC3 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:ACC6 29 00 F0    AND #$F000             ;\
$86:ACC9 C9 00 10    CMP #$1000             ;} If [enemy projectile Y velocity] / 1000h = 1:
$86:ACCC D0 03       BNE $03    [$ACD1]     ;/
$86:ACCE 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:ACD1 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:ACD2 A9 25 AB    LDA #$AB25             ;\
$86:ACD5 9D 47 1B    STA $1B47,x[$7E:1B61]  ;} Enemy projectile instruction list pointer = $AB25 (break on wall)
$86:ACD8 A9 01 00    LDA #$0001             ;\
$86:ACDB 9D 8F 1B    STA $1B8F,x[$7E:1BA9]  ;} Enemy projectile instruction timer = 1
$86:ACDE 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:ACDF BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:ACE2 29 F0 FF    AND #$FFF0             ;|
$86:ACE5 09 08 00    ORA #$0008             ;|
$86:ACE8 3A          DEC A                  ;} Enemy projectile Y position = [enemy projectile Y position] rounded to pixel 6 of 16x16 block
$86:ACE9 3A          DEC A                  ;|
$86:ACEA 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:ACED A9 41 AB    LDA #$AB41             ;\
$86:ACF0 9D 47 1B    STA $1B47,x[$7E:1B67]  ;} Enemy projectile instruction list pointer = $AB41 (break on floor)
$86:ACF3 A9 01 00    LDA #$0001             ;\
$86:ACF6 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:ACF9 60          RTS
}


;;; $ACFA: Pre-instruction - enemy projectile $AD7A (Golden Torizo's chozo orbs) ;;;
{
$86:ACFA 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:ACFD 90 0A       BCC $0A    [$AD09]     ; If collision:
$86:ACFF BD B7 1A    LDA $1AB7,x            ;\
$86:AD02 49 FF FF    EOR #$FFFF             ;|
$86:AD05 1A          INC A                  ;} Negate enemy projectile X velocity
$86:AD06 9D B7 1A    STA $1AB7,x            ;/

$86:AD09 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:AD0C 90 2A       BCC $2A    [$AD38]     ; If no collision: go to BRANCH_BOUNCE_END
$86:AD0E 3C DB 1A    BIT $1ADB,x[$7E:1AFD]  ;\
$86:AD11 30 25       BMI $25    [$AD38]     ;} If [enemy projectile Y velocity] < 0: go to BRANCH_BOUNCE_END
$86:AD13 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:AD16 10 06       BPL $06    [$AD1E]     ;|
$86:AD18 18          CLC                    ;|
$86:AD19 69 40 00    ADC #$0040             ;|
$86:AD1C 80 04       BRA $04    [$AD22]     ;|
                                            ;} Enemy projectile X velocity -= 40h * sgn([enemy projectile X velocity])
$86:AD1E 38          SEC                    ;|
$86:AD1F E9 40 00    SBC #$0040             ;|
                                            ;|
$86:AD22 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;/
$86:AD25 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:AD28 4A          LSR A                  ;|
$86:AD29 49 FF FF    EOR #$FFFF             ;} Enemy projectile Y velocity = -[enemy projectile Y velocity] / 2
$86:AD2C 1A          INC A                  ;|
$86:AD2D 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:AD30 29 80 FF    AND #$FF80             ;\
$86:AD33 C9 80 FF    CMP #$FF80             ;} If [enemy projectile Y velocity] / 80h = -1: go to BRANCH_BREAK
$86:AD36 F0 0B       BEQ $0B    [$AD43]     ;/

; BRANCH_BOUNCE_END
$86:AD38 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:AD3B 18          CLC                    ;|
$86:AD3C 69 18 00    ADC #$0018             ;} Enemy projectile Y velocity += 18h
$86:AD3F 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:AD42 60          RTS                    ; Return

; BRANCH_BREAK
$86:AD43 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:AD46 29 F0 FF    AND #$FFF0             ;|
$86:AD49 09 08 00    ORA #$0008             ;|
$86:AD4C 3A          DEC A                  ;} Enemy projectile Y position = [enemy projectile Y position] rounded to pixel 6 of 16x16 block
$86:AD4D 3A          DEC A                  ;|
$86:AD4E 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:AD51 A9 41 AB    LDA #$AB41             ;\
$86:AD54 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $AB41 (break on floor)
$86:AD57 A9 01 00    LDA #$0001             ;\
$86:AD5A 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:AD5D 60          RTS
}


;;; $AD5E: Enemy projectiles - torizo chozo orbs ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:AD5E             dx ABEB,ACAD,AB15,07,07,9008,0000,AB68 ; Bomb Torizo's chozo orbs. Initial instruction list ignored
$86:AD6C             dx ABEB,ACAD,AB15,07,07,900A,0000,AB68 ; Same as above but slightly more damage. Initial instruction list ignored
$86:AD7A             dx AC7C,ACFA,AB15,07,07,B050,0000,AB68 ; Golden Torizo's chozo orbs. Initial instruction list ignored
}
}


;;; $AD88..AEC3: Torizo sonic boom ;;;
{
;;; $AD88: Unused. Instruction list ;;;
{
$86:AD88             dx 8161,AE6C,      ; Pre-instruction = $AE6C
                        AD92,ADCA,ADDD  ; Move horizontally and go to $ADCA or $ADDD
}


;;; $AD92: Instruction - move horizontally and go to [[Y]] or [[Y] + 2] ;;;
{
; Used by unused instruction list $AD88
$86:AD92 64 12       STZ $12    [$7E:0012]  ;\
$86:AD94 64 14       STZ $14    [$7E:0014]  ;|
$86:AD96 BD B7 1A    LDA $1AB7,x            ;|
$86:AD99 10 02       BPL $02    [$AD9D]     ;|
$86:AD9B C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:AD9D 85 13       STA $13    [$7E:0013]  ;|
$86:AD9F BD 27 1A    LDA $1A27,x            ;} Enemy projectile X position += [enemy projectile X velocity] / 100h
$86:ADA2 18          CLC                    ;|
$86:ADA3 65 12       ADC $12    [$7E:0012]  ;|
$86:ADA5 9D 27 1A    STA $1A27,x            ;|
$86:ADA8 BD 4B 1A    LDA $1A4B,x            ;|
$86:ADAB 65 14       ADC $14    [$7E:0014]  ;|
$86:ADAD 9D 4B 1A    STA $1A4B,x            ;/
$86:ADB0 BD B7 1A    LDA $1AB7,x            ;\
$86:ADB3 10 05       BPL $05    [$ADBA]     ;} If [enemy projectile X velocity] < 0:
$86:ADB5 B9 00 00    LDA $0000,y            ;\
$86:ADB8 A8          TAY                    ;} Y = [[Y]] (moving leftwards)
$86:ADB9 60          RTS                    ; Return

$86:ADBA B9 02 00    LDA $0002,y            ;\
$86:ADBD A8          TAY                    ;} Y = [[Y] + 2] (moving rightwards)
$86:ADBE 60          RTS
}


;;; $ADBF: Instruction list - torizo sonic boom - fired leftwards ;;;
{
$86:ADBF             dx 8312,48,    ; Queue sound 48h, sound library 2, max queued sounds allowed = 6 (torizo sonic boom)
                        0006,8CE9,
                        0006,8CFF
}


;;; $ADCA: Instruction list - torizo sonic boom - moving leftwards ;;;
{
$86:ADCA             dw 0050,8D1F,
                        81AB,ADCA   ; Go to $ADCA
}


;;; $ADD2: Instruction list - torizo sonic boom - fired rightwards ;;;
{
$86:ADD2             dx 8312,48,    ; Queue sound 48h, sound library 2, max queued sounds allowed = 6 (torizo sonic boom)
                        0006,8D3F,
                        0006,8D55
}


;;; $ADDD: Instruction list - torizo sonic boom - moving rightwards ;;;
{
$86:ADDD             dw 0050,8D75,
                        81AB,ADDD   ; Go to $ADDD
}


;;; $ADE5: Instruction list - torizo sonic boom - hit wall ;;;
{
$86:ADE5             dx 816A,               ; Clear pre-instruction
                        8252,               ; Disable collision with Samus projectiles
                        825C,               ; Disable collision with Samus
                        8284,               ; Set high priority
                        81D5,0005           ; Timer = 5
$86:ADF1             dx A3BE,               ; Reset position
                        81DF,0F,00,1F,00,   ; Move randomly within X radius Fh and Y radius 1Fh
                        0002,8D9C,
                        0002,8DA3,
                        0003,8DB9,
                        0003,8DCF,
                        0002,8DE5,
                        81DE,               ; NOP
                        81C6,ADF1,          ; Decrement timer and go to $ADF1 if non-zero
                        8154                ; Delete
}


;;; $AE15: Initialisation AI - enemy projectile $AEA8/$AEB6 (torizo sonic boom) ;;;
{
$86:AE15 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:AE19 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AE1C AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:AE1F 29 01 00    AND #$0001             ;} If [random number] % 2 != 0:
$86:AE22 F0 05       BEQ $05    [$AE29]     ;/
$86:AE24 A9 F4 FF    LDA #$FFF4             ; A = -Ch
$86:AE27 80 03       BRA $03    [$AE2C]
                                            ; Else ([random number] % 2 = 0):
$86:AE29 A9 14 00    LDA #$0014             ; A = 14h

$86:AE2C 18          CLC                    ;\
$86:AE2D 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]  ;} Enemy projectile Y position = [enemy Y position] + [A]
$86:AE30 99 93 1A    STA $1A93,y[$7E:1AA1]  ;/
$86:AE33 A9 00 00    LDA #$0000
$86:AE36 99 DB 1A    STA $1ADB,y[$7E:1AE9]
$86:AE39 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:AE3C 30 17       BMI $17    [$AE55]     ;} If torizo is facing left:
$86:AE3E BD 7A 0F    LDA $0F7A,x            ;\
$86:AE41 18          CLC                    ;|
$86:AE42 69 E0 FF    ADC #$FFE0             ;} Enemy projectile X position -= 20h
$86:AE45 99 4B 1A    STA $1A4B,y            ;/
$86:AE48 A9 90 FD    LDA #$FD90             ;\
$86:AE4B 99 B7 1A    STA $1AB7,y            ;} Enemy projectile X velocity = -270h
$86:AE4E A9 BF AD    LDA #$ADBF             ;\
$86:AE51 99 47 1B    STA $1B47,y            ;} Enemy projectile instruction list pointer = $ADBF (fired leftwards)
$86:AE54 60          RTS                    ; Return

$86:AE55 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:AE58 18          CLC                    ;|
$86:AE59 69 20 00    ADC #$0020             ;} Enemy projectile X position += 20h
$86:AE5C 99 4B 1A    STA $1A4B,y[$7E:1A59]  ;/
$86:AE5F A9 70 02    LDA #$0270             ;\
$86:AE62 99 B7 1A    STA $1AB7,y[$7E:1AC5]  ;} Enemy projectile X velocity = 270h
$86:AE65 A9 D2 AD    LDA #$ADD2             ;\
$86:AE68 99 47 1B    STA $1B47,y[$7E:1B55]  ;} Enemy projectile instruction list pointer = $ADD2 (fired rightwards)
$86:AE6B 60          RTS
}


;;; $AE6C: Pre-instruction - enemy projectile $AEA8/$AEB6 (torizo sonic boom) ;;;
{
$86:AE6C 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:AE6F B0 1E       BCS $1E    [$AE8F]     ; If collision: go to BRANCH_HIT_WALL
$86:AE71 BD B7 1A    LDA $1AB7,x[$7E:1AC5]  ;\
$86:AE74 30 06       BMI $06    [$AE7C]     ;|
$86:AE76 18          CLC                    ;|
$86:AE77 69 10 00    ADC #$0010             ;|
$86:AE7A 80 04       BRA $04    [$AE80]     ;|
                                            ;} Enemy projectile X velocity += 10h * sgn([enemy projectile X velocity])
$86:AE7C 38          SEC                    ;|
$86:AE7D E9 10 00    SBC #$0010             ;|
                                            ;|
$86:AE80 9D B7 1A    STA $1AB7,x[$7E:1AC5]  ;/
$86:AE83 29 00 F0    AND #$F000             ;\
$86:AE86 C9 00 10    CMP #$1000             ;} If [enemy projectile X velocity] / 1000h = 1:
$86:AE89 D0 03       BNE $03    [$AE8E]     ;/
$86:AE8B 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:AE8E 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:AE8F A9 E5 AD    LDA #$ADE5             ;\
$86:AE92 9D 47 1B    STA $1B47,x[$7E:1B55]  ;} Enemy projectile instruction list pointer = $ADE5 (hit wall)
$86:AE95 A9 01 00    LDA #$0001             ;\
$86:AE98 9D 8F 1B    STA $1B8F,x[$7E:1B9D]  ;} Enemy projectile instruction timer = 1
$86:AE9B BD 4B 1A    LDA $1A4B,x[$7E:1A59]  ;\
$86:AE9E 9D FF 1A    STA $1AFF,x[$7E:1B0D]  ;} Enemy projectile reset X position = [enemy projectile X position]
$86:AEA1 BD 93 1A    LDA $1A93,x[$7E:1AA1]  ;\
$86:AEA4 9D 23 1B    STA $1B23,x[$7E:1B31]  ;} Enemy projectile reset Y position = [enemy projectile Y position]
$86:AEA7 60          RTS
}


;;; $AEA8: Enemy projectiles - torizo sonic boom ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:AEA8             dx AE15,AE6C,ADBF,03,14,100A,0000,84FC ; Bomb Torizo sonic boom. Initial instruction list ignored
$86:AEB6             dx AE15,AE6C,ADBF,03,14,1078,0000,84FC ; Golden Torizo sonic boom. Initial instruction list ignored
}
}


;;; $AEC4..AF91: Dust clouds ;;;
{
;;; $AEC4: Instruction list - enemy projectile $AF68 (Wrecked Ship chozo spike clearing footsteps) ;;;
{
$86:AEC4             dx 81DF,0F,00,0F,03,   ; Move randomly within X radius Fh and Y radius Ch
                        0002,AC9B,
                        0002,ACA2,
                        0002,ACAE,
                        0002,ACBF,
                        8154                ; Delete
}


;;; $AEDC: Instruction list - enemy projectile $AF76 (unused. Spike clearing explosions) ;;;
{
$86:AEDC             dx 81DF,0F,00,0F,03,   ; Move randomly within X radius Fh and Y radius Ch
                        0005,B406,
                        0005,B41C,
                        0005,B432,
                        0005,B448,
                        0005,B486,
                        0005,B4B0,
                        8154                ; Delete
}


;;; $AEFC: Initialisation AI - enemy projectile $AF68/$AF76 (Wrecked Ship chozo spike clearing footsteps / spike clearing explosions) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X offset
$86:AEFC AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AEFF BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:AF02 18          CLC                    ;|
$86:AF03 6D 93 19    ADC $1993  [$7E:1993]  ;} Enemy projectile X position = [enemy X position] + [enemy projectile initialisation parameter 0]
$86:AF06 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:AF09 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:AF0C 18          CLC                    ;|
$86:AF0D 69 1C 00    ADC #$001C             ;} Enemy projectile Y position = [enemy Y position] + 1Ch
$86:AF10 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:AF13 60          RTS
}


;;; $AF14: Instruction list - enemy projectile $AF84 (Tourian statue dust clouds) ;;;
{
$86:AF14             dw 81D5,0040           ; Timer = 40h
$86:AF18             dx AF36,               ; Reset position
                        81DF,3F,00,03,00,   ; Move randomly within X radius 3Fh and Y radius 3
                        0002,AC9B,
                        0002,ACA2,
                        0002,ACAE,
                        0002,ACBF,
                        81C6,AF18,          ; Decrement timer and go to $AF18 if non-zero
                        8154                ; Delete
}


;;; $AF36: Instruction - reset position ;;;
{
; Clone of $A3BE
$86:AF36 BD FF 1A    LDA $1AFF,x[$7E:1B1B]
$86:AF39 9D 4B 1A    STA $1A4B,x[$7E:1A67]
$86:AF3C BD 23 1B    LDA $1B23,x[$7E:1B3F]
$86:AF3F 9D 93 1A    STA $1A93,x[$7E:1AAF]
$86:AF42 60          RTS
}


;;; $AF43: Initialisation AI - enemy projectile $AF84 (Tourian statue dust clouds) ;;;
{
$86:AF43 A9 80 00    LDA #$0080             ;\
$86:AF46 99 FF 1A    STA $1AFF,y[$7E:1B1B]  ;} Enemy projectile reset X position = 80h
$86:AF49 A9 BC 00    LDA #$00BC             ;\
$86:AF4C 99 23 1B    STA $1B23,y[$7E:1B3F]  ;} Enemy projectile reset Y position = BCh
$86:AF4F 60          RTS
}


;;; $AF50: Initialisation AI - enemy projectile $AFE5 (Torizo landing dust cloud - right foot) ;;;
{
$86:AF50 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AF53 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:AF56 18          CLC                    ;|
$86:AF57 69 30 00    ADC #$0030             ;} Enemy projectile Y position = [enemy Y position] + 30h
$86:AF5A 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:AF5D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:AF60 18          CLC                    ;|
$86:AF61 69 18 00    ADC #$0018             ;} Enemy projectile X position = [enemy X position] + 18h
$86:AF64 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:AF67 60          RTS
}


;;; $AF68: Enemy projectiles ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:AF68             dx AEFC,84FB,AEC4,00,00,3000,0000,84FC ; Wrecked Ship chozo spike clearing footsteps
$86:AF76             dx AEFC,84FB,AEDC,00,00,3000,0000,84FC ; Unused. Spike clearing explosions
$86:AF84             dx AF43,84FB,AF14,00,00,3000,0000,84FC ; Tourian statue dust clouds
}
}


;;; $AF92..B000: Torizo landing dust cloud ;;;
{
;;; $AF92: Instruction - enemy projectile Y position -= 4 ;;;
{
$86:AF92 BD 93 1A    LDA $1A93,x[$7E:1AB5]
$86:AF95 38          SEC
$86:AF96 E9 04 00    SBC #$0004
$86:AF99 9D 93 1A    STA $1A93,x[$7E:1AB5]
$86:AF9C 60          RTS
}


;;; $AF9D: Instruction list - enemy projectile $AFE5 (Torizo landing dust cloud - right foot) ;;;
{
$86:AF9D             dx 0004,8EDF,
                        AF92,       ; Enemy projectile Y position -= 4
                        0004,8EE6,
                        AF92,       ; Enemy projectile Y position -= 4
                        0004,8EED,
                        AF92,       ; Enemy projectile Y position -= 4
                        0004,8EF4,
                        8154        ; Delete
}


;;; $AFB5: Instruction list - enemy projectile $AFF3 (Torizo landing dust cloud - left foot) ;;;
{
$86:AFB5             dx 0004,8EFB,
                        AF92,       ; Enemy projectile Y position -= 4
                        0004,8F02,
                        AF92,       ; Enemy projectile Y position -= 4
                        0004,8F09,
                        AF92,       ; Enemy projectile Y position -= 4
                        0004,8F10,
                        8154        ; Delete
}


;;; $AFCD: Initialisation AI - enemy projectile $AFF3 (Torizo landing dust cloud - left foot) ;;;
{
$86:AFCD AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:AFD0 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:AFD3 18          CLC                    ;|
$86:AFD4 69 30 00    ADC #$0030             ;} Enemy projectile Y position = [enemy Y position] + 30h
$86:AFD7 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:AFDA BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:AFDD 38          SEC                    ;|
$86:AFDE E9 18 00    SBC #$0018             ;} Enemy projectile X position = [enemy X position] - 18h
$86:AFE1 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:AFE4 60          RTS
}


;;; $AFE5: Enemy projectiles - torizo landing dust cloud ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:AFE5             dx AF50,84FB,AF9D,00,00,3000,0000,84FC ; Torizo landing dust cloud - right foot
$86:AFF3             dx AFCD,84FB,AFB5,00,00,3000,0000,84FC ; Torizo landing dust cloud - left foot
}
}


;;; $B001..B1CD: Golden Torizo egg ;;;
{
;;; $B001: Initialisation AI - enemy projectile $B1C0 (Golden Torizo egg) ;;;
{
$86:B001 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:B004 BD 7A 0F    LDA $0F7A,x            ;\
$86:B007 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:B009 BD 7E 0F    LDA $0F7E,x            ;\
$86:B00C 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:B00E AF 11 81 80 LDA $808111[$80:8111]  ;\ <-- typo >_<;
$86:B012 29 1F 00    AND #$001F             ;|
$86:B015 18          CLC                    ;} Enemy projectile egg hatch timer = 42h
$86:B016 69 40 00    ADC #$0040             ;|
$86:B019 99 23 1B    STA $1B23,y            ;/
$86:B01C BD B4 0F    LDA $0FB4,x            ;\
$86:B01F 99 FF 1A    STA $1AFF,y            ;} Enemy projectile direction = [enemy $0FB4]
$86:B022 30 05       BMI $05    [$B029]     ; If [enemy projectile direction] = leftwards:
$86:B024 A2 39 B0    LDX #$B039             ; X = $B039
$86:B027 80 03       BRA $03    [$B02C]
                                            ; Else ([enemy projectile direction] = rightwards):
$86:B029 A2 2F B0    LDX #$B02F             ; X = $B02F

$86:B02C 4C AE AB    JMP $ABAE  [$86:ABAE]  ; Go to torizo chozo orbs / egg / eye beam common initialisation

;                        _______________________ Instruction list pointer
;                       |     __________________ X offset
;                       |    |     _____________ X velocity (unit 1/100h px/frame)
;                       |    |    |     ________ Y offset
;                       |    |    |    |     ___ Y velocity (unit 1/100h px/frame)
;                       |    |    |    |    |
$86:B02F             dw B11C,0010,0080,FFFF,FE80 ; Rightwards
$86:B039             dw B104,FFF0,FF80,FFFF,FE80 ; Leftwards
}


;;; $B043: Pre-instruction - Golden Torizo egg - bouncing ;;;
{
$86:B043 DE 23 1B    DEC $1B23,x            ; Decrement enemy projectile egg hatch timer
$86:B046 30 54       BMI $54    [$B09C]     ; If [enemy projectile egg hatch timer] < 0: go to BRANCH_HATCH
$86:B048 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:B04B 90 13       BCC $13    [$B060]     ; If collision:
$86:B04D BD B7 1A    LDA $1AB7,x            ;\
$86:B050 49 FF FF    EOR #$FFFF             ;|
$86:B053 1A          INC A                  ;} Negate enemy projectile X velocity
$86:B054 9D B7 1A    STA $1AB7,x            ;/
$86:B057 BD FF 1A    LDA $1AFF,x            ;\
$86:B05A 49 00 80    EOR #$8000             ;} Toggle enemy projectile direction
$86:B05D 9D FF 1A    STA $1AFF,x            ;/

$86:B060 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:B063 90 21       BCC $21    [$B086]     ; If no collision: go to BRANCH_BOUNCE_END
$86:B065 3C DB 1A    BIT $1ADB,x            ;\
$86:B068 30 1C       BMI $1C    [$B086]     ;} If [enemy projectile Y velocity] < 0: go to BRANCH_BOUNCE_END
$86:B06A BD B7 1A    LDA $1AB7,x            ;\
$86:B06D 10 06       BPL $06    [$B075]     ;|
$86:B06F 18          CLC                    ;|
$86:B070 69 20 00    ADC #$0020             ;|
$86:B073 80 04       BRA $04    [$B079]     ;|
                                            ;} Enemy projectile X velocity -= 20h * sgn([enemy projectile X velocity])
$86:B075 38          SEC                    ;|
$86:B076 E9 20 00    SBC #$0020             ;|
                                            ;|
$86:B079 9D B7 1A    STA $1AB7,x            ;/
$86:B07C BD DB 1A    LDA $1ADB,x            ;\
$86:B07F 49 FF FF    EOR #$FFFF             ;|
$86:B082 1A          INC A                  ;} Negate enemy projectile Y velocity
$86:B083 9D DB 1A    STA $1ADB,x            ;/

; BRANCH_BOUNCE_END
$86:B086 BD DB 1A    LDA $1ADB,x            ;\
$86:B089 18          CLC                    ;|
$86:B08A 69 30 00    ADC #$0030             ;} Enemy projectile Y velocity += 30h
$86:B08D 9D DB 1A    STA $1ADB,x            ;/
$86:B090 29 00 F0    AND #$F000             ;\
$86:B093 C9 00 10    CMP #$1000             ;} If [enemy projectile Y velocity] / 1000h = 1:
$86:B096 D0 03       BNE $03    [$B09B]     ;/
$86:B098 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:B09B 60          RTS                    ; Return

; BRANCH_HATCH
$86:B09C FE 47 1B    INC $1B47,x            ;\
$86:B09F FE 47 1B    INC $1B47,x            ;} Enemy projectile instruction list pointer += 2 (wake up)
$86:B0A2 A9 01 00    LDA #$0001             ;\
$86:B0A5 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:B0A8 3C FF 1A    BIT $1AFF,x            ;\
$86:B0AB 30 05       BMI $05    [$B0B2]     ;} If [enemy projectile direction] = leftwards:
$86:B0AD A9 00 FF    LDA #$FF00             ; Enemy projectile X velocity = -100h
$86:B0B0 80 03       BRA $03    [$B0B5]
                                            ; Else ([enemy projectile direction] = rightwards):
$86:B0B2 A9 00 01    LDA #$0100             ; Enemy projectile X velocity = 100h

$86:B0B5 9D B7 1A    STA $1AB7,x
$86:B0B8 60          RTS
}


;;; $B0B9: Pre-instruction - Golden Torizo egg - hatched ;;;
{
$86:B0B9 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:B0BC B0 15       BCS $15    [$B0D3]     ; If collision: go to BRANCH_HIT_WALL
$86:B0BE 3C FF 1A    BIT $1AFF,x            ;\
$86:B0C1 30 05       BMI $05    [$B0C8]     ;} If [enemy projectile direction] = leftwards:
$86:B0C3 A9 D0 FF    LDA #$FFD0             ; A = -30h
$86:B0C6 80 03       BRA $03    [$B0CB]
                                            ; Else ([enemy projectile direction] = rightwards):
$86:B0C8 A9 30 00    LDA #$0030             ; A = 30h

$86:B0CB 18          CLC                    ;\
$86:B0CC 7D B7 1A    ADC $1AB7,x            ;} Enemy projectile X velocity += [A]
$86:B0CF 9D B7 1A    STA $1AB7,x            ;/
$86:B0D2 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:B0D3 A9 DD B0    LDA #$B0DD             ;\
$86:B0D6 9D 03 1A    STA $1A03,x            ;} Enemy projectile pre-instruction = $B0DD (hit wall)
$86:B0D9 9E DB 1A    STZ $1ADB,x            ; Enemy projectile Y velocity = 0
$86:B0DC 60          RTS
}


;;; $B0DD: Pre-instruction - Golden Torizo egg - hit wall ;;;
{
$86:B0DD 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:B0E0 B0 0B       BCS $0B    [$B0ED]     ; If no collision:
$86:B0E2 A9 30 00    LDA #$0030             ;\
$86:B0E5 18          CLC                    ;|
$86:B0E6 7D DB 1A    ADC $1ADB,x            ;} Enemy projectile Y velocity += 30h
$86:B0E9 9D DB 1A    STA $1ADB,x            ;/
$86:B0EC 60          RTS                    ; Return

$86:B0ED 3C FF 1A    BIT $1AFF,x            ;\
$86:B0F0 30 05       BMI $05    [$B0F7]     ;} If [enemy projectile direction] = leftwards:
$86:B0F2 A9 90 B1    LDA #$B190             ; Enemy projectile instruction list pointer = $B190 (break - facing left)
$86:B0F5 80 03       BRA $03    [$B0FA]
                                            ; Else ([enemy projectile direction] = rightwards):
$86:B0F7 A9 A8 B1    LDA #$B1A8             ; Enemy projectile instruction list pointer = $B1A8 (break - facing right)

$86:B0FA 9D 47 1B    STA $1B47,x
$86:B0FD A9 01 00    LDA #$0001             ;\
$86:B100 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:B103 60          RTS
}


;;; $B104: Instruction list - Golden Torizo egg - bouncing - leftwards ;;;
{
$86:B104             dx 0030,8F17,
                        8159,       ; Sleep
                        816A,       ; Clear pre-instruction
                        0004,8F1E,
                        0004,8F25,
                        0004,8F2C,
                        81AB,B134   ; Go to $B134 (hatch)
}


;;; $B11C: Instruction list - Golden Torizo egg - bouncing - rightwards ;;;
{
$86:B11C             dx 0030,8F75,
                        8159,       ; Sleep
                        816A,       ; Clear pre-instruction
                        0004,8F7C,
                        0004,8F83,
                        0004,8F8A,
                        81AB,B134   ; Go to $B134 (hatch)
}


;;; $B134: Instruction list - Golden Torizo egg - hatch ;;;
{
$86:B134             dx 823C,DFFF,  ; Enemy projectile properties &= DFFFh (enable collisions with Samus)
                        8230,8000,  ; Enemy projectile properties |= 8000h (detect collisions with projectiles)
                        B13E        ; Go to hatched
}


;;; $B13E: Instruction - go to hatched ;;;
{
$86:B13E 3C FF 1A    BIT $1AFF,x            ;\
$86:B141 30 04       BMI $04    [$B147]     ;} If [enemy projectile direction] = leftwards:
$86:B143 A0 4B B1    LDY #$B14B             ; Y = $B14B (hatched - leftwards)
$86:B146 60          RTS                    ; Return

$86:B147 A0 66 B1    LDY #$B166             ; Y = $B166 (hatched - rightwards)
$86:B14A 60          RTS
}


;;; $B14B: Instruction list - Golden Torizo egg - hatched - leftwards ;;;
{
$86:B14B             dx 8312,22,    ; Queue sound 22h, sound library 2, max queued sounds allowed = 6 (Golden Torizo egg hatches)
                        8161,B0B9   ; Pre-instruction = $B0B9 (hatched)
$86:B152             dx 0006,8F33,
                        0006,8F3A,
                        0006,8F41,
                        0006,8F3A,
                        81AB,B152   ; Go to $B152
}


;;; $B166: Instruction list - Golden Torizo egg - hatched - rightwards ;;;
{
$86:B166             dx 8312,22,    ; Queue sound 22h, sound library 2, max queued sounds allowed = 6 (Golden Torizo egg hatches)
                        8161,B0B9   ; Pre-instruction = $B0B9 (hatched)
$86:B16D             dx 0006,8F91,
                        0006,8F98,
                        0006,8F9F,
                        0006,8F98,
                        81AB,B16D   ; Go to $B16D
}


;;; $B181: Unused. Instruction list - break ;;;
{
$86:B181             dw B183        ; Go to break
}


;;; $B183: Unused. Instruction - go to break ;;;
{
; Used by unused instruction list $B181
$86:B183 BD FF 1A    LDA $1AFF,x            ;\
$86:B186 30 04       BMI $04    [$B18C]     ;} If [enemy projectile direction] = leftwards:
$86:B188 A0 90 B1    LDY #$B190             ; Y = $B190 (break - facing left)
$86:B18B 60          RTS                    ; Return

$86:B18C A0 A8 B1    LDY #$B1A8             ; Y = $B1A8 (break - facing right)
$86:B18F 60          RTS
}


;;; $B190: Instruction list - Golden Torizo egg - break - facing left ;;;
{
$86:B190             dx 816A,       ; Clear pre-instruction
                        0004,8F48,
                        0004,8F4F,
                        0004,8F56,
                        0004,8F5D,
                        000A,8F69,
                        8154        ; Delete
}


;;; $B1A8: Instruction list - Golden Torizo egg - break - facing right ;;;
{
$86:B1A8             dx 816A,       ; Clear pre-instruction
                        0004,8FA6,
                        0004,8FAD,
                        0004,8FB4,
                        0004,8FBB,
                        0008,8FC7,
                        8154        ; Delete
}


;;; $B1C0: Enemy projectile - Golden Torizo egg ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:B1C0             dx B001,B043,B104,07,07,6064,0000,AB25 ; Golden Torizo egg. Initial instruction list ignored
}
}


;;; $B1CE..B327: Golden Torizo super missile ;;;
{
;;; $B1CE: Initialisation AI - enemy projectile $B31A (Golden Torizo super missile) ;;;
{
$86:B1CE AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$86:B1D1 99 FF 1A    STA $1AFF,y            ;} X = enemy projectile enemy index = [enemy index]
$86:B1D4 AA          TAX                    ;/
$86:B1D5 BD 7A 0F    LDA $0F7A,x            ;\
$86:B1D8 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:B1DA BD 7E 0F    LDA $0F7E,x            ;\
$86:B1DD 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:B1DF 3C B4 0F    BIT $0FB4,x            ;\
$86:B1E2 30 05       BMI $05    [$B1E9]     ;} If torizo is facing left:
$86:B1E4 A2 00 00    LDX #$0000             ; X = 0
$86:B1E7 80 03       BRA $03    [$B1EC]
                                            ; Else (torizo is facing right):
$86:B1E9 A2 02 00    LDX #$0002             ; X = 2

$86:B1EC BD 05 B2    LDA $B205,x            ;\
$86:B1EF 18          CLC                    ;|
$86:B1F0 65 12       ADC $12    [$7E:0012]  ;} Enemy projectile X position = [enemy X position] + [$B205 + [X]]
$86:B1F2 99 4B 1A    STA $1A4B,y            ;/
$86:B1F5 A9 CC FF    LDA #$FFCC             ;\
$86:B1F8 18          CLC                    ;|
$86:B1F9 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile Y position = [enemy Y position] - 34h
$86:B1FB 99 93 1A    STA $1A93,y            ;/
$86:B1FE BD 09 B2    LDA $B209,x            ;\
$86:B201 99 47 1B    STA $1B47,y            ;} Enemy projectile instruction list pointer = [$B209 + [X]]
$86:B204 60          RTS

;                        _________ Leftwards
;                       |      ___ Rightwards
;                       |     |
$86:B205             dw FFE2, 001E ; X offsets
$86:B209             dw B2C1, B293 ; Instruction list pointers
}


;;; $B20D: Pre-instruction - Golden Torizo super missile - held ;;;
{
; If Golden Torizo is killed, its Y position will be 0, so this projectile will teleport off-screen
$86:B20D BC FF 1A    LDY $1AFF,x            ; Y = [enemy projectile enemy index]
$86:B210 B9 7A 0F    LDA $0F7A,y            ;\
$86:B213 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:B215 B9 7E 0F    LDA $0F7E,y            ;\
$86:B218 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:B21A B9 B4 0F    LDA $0FB4,y            ;\
$86:B21D 30 05       BMI $05    [$B224]     ;} If torizo is facing left:
$86:B21F A9 E0 FF    LDA #$FFE0             ; A = -20h
$86:B222 80 03       BRA $03    [$B227]
                                            ; Else (torizo is facing right):
$86:B224 A9 20 00    LDA #$0020             ; A = 20h

$86:B227 18          CLC                    ;\
$86:B228 65 12       ADC $12    [$7E:0012]  ;} Enemy projectile X position = [enemy X position] + [A]
$86:B22A 9D 4B 1A    STA $1A4B,x            ;/
$86:B22D A9 CC FF    LDA #$FFCC             ;\
$86:B230 18          CLC                    ;|
$86:B231 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile Y position = [enemy Y position] - 34h
$86:B233 9D 93 1A    STA $1A93,x            ;/
$86:B236 60          RTS
}


;;; $B237: Pre-instruction - Golden Torizo super missile - thrown ;;;
{
$86:B237 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:B23A B0 20       BCS $20    [$B25C]     ; If collision: go to BRANCH_COLLISION
$86:B23C 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:B23F 3C DB 1A    BIT $1ADB,x            ;\
$86:B242 30 02       BMI $02    [$B246]     ;} If [enemy projectile Y velocity] >= 0:
$86:B244 B0 16       BCS $16    [$B25C]     ; If collision: go to BRANCH_COLLISION

$86:B246 BD DB 1A    LDA $1ADB,x            ;\
$86:B249 18          CLC                    ;|
$86:B24A 69 10 00    ADC #$0010             ;} Enemy projectile Y velocity += 10h
$86:B24D 9D DB 1A    STA $1ADB,x            ;/
$86:B250 29 00 F0    AND #$F000             ;\
$86:B253 C9 00 10    CMP #$1000             ;} If [enemy projectile Y velocity] / 1000h = 1:
$86:B256 D0 03       BNE $03    [$B25B]     ;/
$86:B258 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0

$86:B25B 60          RTS                    ; Return

; BRANCH_COLLISION
$86:B25C A9 EF B2    LDA #$B2EF             ;\
$86:B25F 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $B2EF (explode)
$86:B262 A9 01 00    LDA #$0001             ;\
$86:B265 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1
$86:B268 60          RTS
}


;;; $B269: Instruction - aim super missile - rightwards ;;;
{
$86:B269 22 4E C0 A0 JSL $A0C04E[$A0:C04E]  ; A = angle of Samus from enemy projectile
$86:B26D 29 7F 00    AND #$007F             ; If angle >= 80h: invert angle
$86:B270 80 07       BRA $07    [$B279]     ; Go to calculate Golden Torizo super missile velocities from angle
}


;;; $B272: Instruction - aim super missile - leftwards ;;;
{
$86:B272 22 4E C0 A0 JSL $A0C04E[$A0:C04E]  ; A = angle of Samus from enemy projectile
$86:B276 09 80 00    ORA #$0080             ; If angle < 80h: invert angle
}


;;; $B279: Calculate Golden Torizo super missile velocities from angle ;;;
{
;; Parameters:
;;     A: Angle
$86:B279 DA          PHX
$86:B27A 5A          PHY
$86:B27B 9B          TXY                    ;\
$86:B27C 0A          ASL A                  ;|
$86:B27D AA          TAX                    ;|
$86:B27E BF 43 B4 A0 LDA $A0B443,x          ;} Enemy projectile X velocity = 400h * sin([A] * pi / 80h)
$86:B282 0A          ASL A                  ;|
$86:B283 0A          ASL A                  ;|
$86:B284 99 B7 1A    STA $1AB7,y            ;/
$86:B287 BF C3 B3 A0 LDA $A0B3C3,x          ;\
$86:B28B 0A          ASL A                  ;|
$86:B28C 0A          ASL A                  ;} Enemy projectile Y velocity = 400h * -cos([A] * pi / 80h)
$86:B28D 99 DB 1A    STA $1ADB,y            ;/
$86:B290 7A          PLY
$86:B291 FA          PLX
$86:B292 60          RTS
}


;;; $B293: Instruction list - Golden Torizo super missile - rightwards ;;;
{
$86:B293             dx 0030,8EC2,
                        B269,       ; Aim super missile - rightwards
                        8161,B237   ; Pre-instruction = $B237
$86:B29D             dx 0002,8EB1,
                        0002,8EA5,
                        0002,8E94,
                        0002,8E88,
                        0002,8E77,
                        0002,8E6B,
                        0002,8ECE,
                        0002,8EC2,
                        81AB,B29D   ; Go to $B29D
}


;;; $B2C1: Instruction list - Golden Torizo super missile - leftwards ;;;
{
$86:B2C1             dx 0030,8EC2,
                        B272,       ; Aim super missile - leftwards
                        8161,B237   ; Pre-instruction = $B237
$86:B2CB             dx 0002,8ECE,
                        0002,8E6B,
                        0002,8E77,
                        0002,8E88,
                        0002,8E94,
                        0002,8EA5,
                        0002,8EB1,
                        0002,8EC2,
                        81AB,B2CB   ; Go to $B2CB
}


;;; $B2EF: Instruction list - Golden Torizo super missile - explode / shot instruction list - enemy projectile $B31A (Golden Torizo super missile) ;;;
{
$86:B2EF             dx 8298,10,10, ; X radius = 10h, Y radius = 10h
                        816A,       ; Clear pre-instruction
                        8230,5000,  ; Enemy projectile properties |= 5000h (don't die on contact, high priority)
                        823C,5FFF,  ; Enemy projectile properties &= 5FFFh (don't detect collisions with projectiles, enable collisions with Samus)
                        8312,24,    ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
                        0005,B406,
                        0005,B41C,
                        0005,B432,
                        0005,B448,
                        0005,B486,
                        0005,B4B0,
                        8154        ; Delete
}


;;; $B31A: Enemy projectile - Golden Torizo super missile ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:B31A             dx B1CE,B20D,B293,04,04,A0C8,0000,B2EF ; Golden Torizo super missile. Initial instruction list ignored
}
}


;;; $B328..B435: Golden Torizo eye beam ;;;
{
;;; $B328: Initialisation AI - enemy projectile $B428 (Golden Torizo eye beam) ;;;
{
$86:B328 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:B32B BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:B32E 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$86:B330 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:B333 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$86:B335 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;\
$86:B338 30 05       BMI $05    [$B33F]     ;} If torizo is facing left:
$86:B33A A2 80 B3    LDX #$B380             ; X = $B380
$86:B33D 80 03       BRA $03    [$B342]
                                            ; Else (torizo is facing right):
$86:B33F A2 76 B3    LDX #$B376             ; X = $B376

$86:B342 20 AE AB    JSR $ABAE  [$86:ABAE]  ; Execute torizo chozo orbs / egg / eye beam common initialisation
$86:B345 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:B349 29 1E 00    AND #$001E             ;\
$86:B34C 38          SEC                    ;} A = ([random number] / 2 % 10h - 8) * 2 (random angle variance)
$86:B34D E9 10 00    SBC #$0010             ;/
$86:B350 18          CLC                    ;\
$86:B351 69 C0 00    ADC #$00C0             ;} X = 60h * 2 + [A] (down-right + variance)
$86:B354 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$86:B357 3C B4 0F    BIT $0FB4,x[$7E:0FB4]  ;} If torizo is facing left:
$86:B35A 30 04       BMI $04    [$B360]     ;/
$86:B35C 18          CLC                    ;\
$86:B35D 69 80 00    ADC #$0080             ;} X = A0h * 2 + [A] (down-left + variance)

$86:B360 AA          TAX
$86:B361 BF 43 B4 A0 LDA $A0B443,x[$A0:B581];\
$86:B365 0A          ASL A                  ;|
$86:B366 0A          ASL A                  ;} Enemy projectile X velocity = 800h * sin([X] / 2 * pi / 80h)
$86:B367 0A          ASL A                  ;|
$86:B368 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:B36B BF C3 B3 A0 LDA $A0B3C3,x[$A0:B501];\
$86:B36F 0A          ASL A                  ;|
$86:B370 0A          ASL A                  ;} Enemy projectile Y velocity = 800h * -cos([X] / 2 * pi / 80h)
$86:B371 0A          ASL A                  ;|
$86:B372 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;/
$86:B375 60          RTS

;                        _______________________ Instruction list pointer
;                       |     __________________ X offset
;                       |    |     _____________ X velocity (unit 1/100h px/frame)
;                       |    |    |     ________ Y offset
;                       |    |    |    |     ___ Y velocity (unit 1/100h px/frame)
;                       |    |    |    |    |
$86:B376             dw B410,0014,0400,FFE2,0400 ; Rightwards
$86:B380             dw B410,FFEC,FC00,FFE2,0400 ; Leftwards
}


;;; $B38A: Pre-instruction - enemy projectile $B428 (Golden Torizo eye beam) ;;;
{
$86:B38A 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:B38D B0 06       BCS $06    [$B395]     ; If no collision:
$86:B38F 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:B392 B0 09       BCS $09    [$B39D]     ; If collision: go to BRANCH_HIT_FLOOR
$86:B394 60          RTS                    ; Return

$86:B395 A9 CD B3    LDA #$B3CD             ;\
$86:B398 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $B3CD (hit wall)
$86:B39B 80 14       BRA $14    [$B3B1]     ; Go to BRANCH_INSTRUCTION_LIST_SET

; BRANCH_HIT_FLOOR
$86:B39D BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:B3A0 29 F0 FF    AND #$FFF0             ;|
$86:B3A3 09 08 00    ORA #$0008             ;|
$86:B3A6 3A          DEC A                  ;} Enemy projectile Y position = [enemy projectile Y position] rounded to pixel 6 of 16x16 block
$86:B3A7 3A          DEC A                  ;|
$86:B3A8 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:B3AB A9 E5 B3    LDA #$B3E5             ;\
$86:B3AE 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $B3E5 (hit floor)

; BRANCH_INSTRUCTION_LIST_SET
$86:B3B1 A9 01 00    LDA #$0001             ;\
$86:B3B4 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:B3B7 60          RTS
}


;;; $B3B8: Instruction - go to [[Y]] if eye beam explosions are disabled ;;;
{
; I'm guessing that enemy projectile $1B23 is enemy index here, it's never actually initialised, but 0 is correct for vanilla anyway
$86:B3B8 DA          PHX
$86:B3B9 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:B3BC AA          TAX                    ;} X = [enemy projectile $1B23] (enemy index)
$86:B3BD BF 0C 78 7E LDA $7E780C,x[$7E:780C];\
$86:B3C1 10 04       BPL $04    [$B3C7]     ;} If [enemy $7E:780C] & 8000h != 0 (eye beam explosions enabled):
$86:B3C3 FA          PLX
$86:B3C4 C8          INY                    ;\
$86:B3C5 C8          INY                    ;} Y += 2
$86:B3C6 60          RTS                    ; Return

$86:B3C7 FA          PLX
$86:B3C8 B9 00 00    LDA $0000,y[$86:B3ED]  ;\
$86:B3CB A8          TAY                    ;} Y = [[Y]]
$86:B3CC 60          RTS
}


;;; $B3CD: Instruction list - Golden Torizo eye beam - hit wall ;;;
{
$86:B3CD             dw 816A,       ; Clear pre-instruction
                        0004,8D9C,
                        0004,8DA3,
                        0004,8DB9,
                        0004,8DCF,
                        0004,8DE5,
                        8154        ; Delete
}


;;; $B3E5: Instruction list - Golden Torizo eye beam - hit floor ;;;
{
$86:B3E5             dw 816A        ; Clear pre-instruction
$86:B3E7             dx 0008,8000,
                        B3B8,B3E7,  ; Go to $B3E7 if eye beam explosions are disabled
                        831B,13,    ; Queue sound 13h, sound library 3, max queued sounds allowed = 6 (Mother Brain's / torizo's projectile hits surface / Shitroid exploding)
                        0004,8C7E,
                        0005,8C85,
                        823C,DFFF,  ; Enemy projectile properties &= DFFFh (enable collisions with Samus)
                        0006,8C91,
                        0007,8CA7,
                        0008,8CB8,
                        0009,8CC9,
                        8154        ; Delete
}


;;; $B410: Instruction list - Golden Torizo eye beam - normal ;;;
{
$86:B410             dx 0001,8DE5,
                        0001,8DCF,
                        0001,8DB9,
                        0001,8DA3,
                        0001,8D9C,
                        81AB,B410   ; Go to $B410
}


;;; $B428: Enemy projectile - Golden Torizo eye beam ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:B428             dx B328,B38A,B410,03,03,700A,0000,84FC ; Golden Torizo eye beam. Initial instruction list ignored
}
}


;;; $B436..B4BE: Old Tourian escape shaft fake wall explosion ;;;
{
;;; $B436: Unused. Instruction - reset position ;;;
{
; Clone of $A3BE
$86:B436 BD FF 1A    LDA $1AFF,x
$86:B439 9D 4B 1A    STA $1A4B,x
$86:B43C BD 23 1B    LDA $1B23,x
$86:B43F 9D 93 1A    STA $1A93,x
$86:B442 60          RTS
}


;;; $B443: Instruction list - enemy projectile $B4B1 (old Tourian escape shaft fake wall explosion) ;;;
{
$86:B443             dw 816A,               ; Clear pre-instruction
                        81D5,0001           ; Timer = 1
$86:B449             dx 81DF,07,00,0F,00,   ; Move randomly within X radius 7 and Y radius Fh
                        8312,24,            ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
                        0004,B023,
                        0006,B02A,
                        0005,B040,
                        0005,B056,
                        0005,B06C,
                        0006,B082,
                        81C6,B449,          ; Decrement timer and go to $B449 if non-zero
                        8154                ; Delete
}


;;; $B470: Unused. Instruction list ;;;
{
$86:B470             dx 8312,24,    ; Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
                        0008,B250,
                        0008,B257,
                        0008,B25E,
                        0008,B265,
                        81C6,B449,  ; Decrement timer and go to $B449 if non-zero
                        8154        ; Delete
}


;;; $B489: Unused. Instruction - go to [[Y]] with probability 1/4 ;;;
{
; Clone of $A456
$86:B489 22 11 81 80 JSL $808111[$80:8111]
$86:B48D 29 00 C0    AND #$C000
$86:B490 C9 00 C0    CMP #$C000
$86:B493 F0 03       BEQ $03    [$B498]
$86:B495 C8          INY
$86:B496 C8          INY
$86:B497 60          RTS

$86:B498 B9 00 00    LDA $0000,y
$86:B49B A8          TAY
$86:B49C 60          RTS
}


;;; $B49D: Initialisation AI - enemy projectile $B4B1 (old Tourian escape shaft fake wall explosion) ;;;
{
; Set position to middle of wall that breaks
$86:B49D A9 10 01    LDA #$0110             ;\
$86:B4A0 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;} Enemy projectile X position = 110h
$86:B4A3 99 FF 1A    STA $1AFF,y[$7E:1B1D]  ; Enemy projectile reset X position = [enemy projectile X position] (never read)
$86:B4A6 A9 88 08    LDA #$0888             ;\
$86:B4A9 99 93 1A    STA $1A93,y[$7E:1AB1]  ;} Enemy projectile Y position = 888h
$86:B4AC 99 23 1B    STA $1B23,y[$7E:1B41]  ; Enemy projectile reset Y position = [enemy projectile Y position] (never read)
$86:B4AF 60          RTS
}


;;; $B4B0: RTS. Pre-instruction - enemy projectile $B4B1 (old Tourian escape shaft fake wall explosion) ;;;
{
$86:B4B0 60          RTS
}


;;; $B4B1: Enemy projectile - old Tourian escape shaft fake wall explosion ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:B4B1             dx B49D,B4B0,B443,00,00,3000,0000,84FC ; Old Tourian escape shaft fake wall explosion
}
}


;;; $B4BF..B5D8: Lava seahorse fireball ;;;
{
;;; $B4BF: Instruction list - lava seahorse fireball - rising - leftwards ;;;
{
$86:B4BF             dx 0005,8FD3,
                        0005,8FDA,
                        81AB,B4BF   ; Go to $B4BF
}


;;; $B4CB: Instruction list - lava seahorse fireball - rising - rightwards ;;;
{
$86:B4CB             dx 0005,8FEF,
                        0005,8FF6,
                        81AB,B4CB   ; Go to $B4CB
}


;;; $B4D7: Instruction list - lava seahorse fireball - falling - leftwards ;;;
{
$86:B4D7             dx 0005,8FE1,
                        0005,8FE8,
                        81AB,B4D7   ; Go to $B4D7
}


;;; $B4E3: Instruction list - lava seahorse fireball - falling - rightwards ;;;
{
$86:B4E3             dx 0005,8FFD,
                        0005,9004,
                        81AB,B4E3   ; Go to $B4E3
}


;;; $B4EF: Initialisation AI - enemy projectile $B5CB (lava seahorse fireball) ;;;
{
$86:B4EF AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:B4F2 BD 7E 0F    LDA $0F7E,x[$7E:11BE]  ;\
$86:B4F5 38          SEC                    ;|
$86:B4F6 E9 1C 00    SBC #$001C             ;} Enemy projectile Y position = [enemy Y position] - 1Ch
$86:B4F9 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:B4FC A9 3F FC    LDA #$FC3F             ;\
$86:B4FF 99 DB 1A    STA $1ADB,y[$7E:1AFB]  ;} Enemy projectile Y velocity = -3C1h
$86:B502 3C A8 0F    BIT $0FA8,x[$7E:11E8]  ;\
$86:B505 10 17       BPL $17    [$B51E]     ;} If [enemy $0FA8] & 8000h != 0:
$86:B507 BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$86:B50A 18          CLC                    ;|
$86:B50B 69 F4 FF    ADC #$FFF4             ;} Enemy projectile X position = [enemy X position] - Ch
$86:B50E 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:B511 A9 40 FD    LDA #$FD40             ;\
$86:B514 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile X velocity = -2C0h
$86:B517 A9 BF B4    LDA #$B4BF             ;\
$86:B51A 99 47 1B    STA $1B47,y[$7E:1B67]  ;} Enemy projectile instruction list pointer = $B4BF (rising - leftwards)
$86:B51D 60          RTS                    ; Return

$86:B51E BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:B521 18          CLC                    ;|
$86:B522 69 0C 00    ADC #$000C             ;} Enemy projectile X position = [enemy X position] + Ch
$86:B525 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:B528 A9 C0 02    LDA #$02C0             ;\
$86:B52B 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = 2C0h
$86:B52E A9 CB B4    LDA #$B4CB             ;\
$86:B531 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $B4CB (rising - rightwards)
$86:B534 60          RTS
}


;;; $B535: Pre-instruction - enemy projectile $B5CB (lava seahorse fireball) ;;;
{
$86:B535 BD B6 1A    LDA $1AB6,x[$7E:1AD6]  ;\
$86:B538 29 00 FF    AND #$FF00             ;|
$86:B53B 85 14       STA $14    [$7E:0014]  ;|
$86:B53D BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;|
$86:B540 EB          XBA                    ;|
$86:B541 10 05       BPL $05    [$B548]     ;|
$86:B543 09 00 FF    ORA #$FF00             ;|
$86:B546 80 03       BRA $03    [$B54B]     ;|
                                            ;|
$86:B548 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile X velocity] / 100h
                                            ;|
$86:B54B 85 12       STA $12    [$7E:0012]  ;|
$86:B54D BD 27 1A    LDA $1A27,x[$7E:1A47]  ;|
$86:B550 18          CLC                    ;|
$86:B551 65 14       ADC $14    [$7E:0014]  ;|
$86:B553 9D 27 1A    STA $1A27,x[$7E:1A47]  ;|
$86:B556 BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;|
$86:B559 65 12       ADC $12    [$7E:0012]  ;|
$86:B55B 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:B55E BD DA 1A    LDA $1ADA,x[$7E:1AFA]  ;\
$86:B561 29 00 FF    AND #$FF00             ;|
$86:B564 85 14       STA $14    [$7E:0014]  ;|
$86:B566 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;|
$86:B569 EB          XBA                    ;|
$86:B56A 10 05       BPL $05    [$B571]     ;|
$86:B56C 09 00 FF    ORA #$FF00             ;|
$86:B56F 80 03       BRA $03    [$B574]     ;|
                                            ;|
$86:B571 29 FF 00    AND #$00FF             ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
                                            ;|
$86:B574 85 12       STA $12    [$7E:0012]  ;|
$86:B576 BD 6F 1A    LDA $1A6F,x[$7E:1A8F]  ;|
$86:B579 18          CLC                    ;|
$86:B57A 65 14       ADC $14    [$7E:0014]  ;|
$86:B57C 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;|
$86:B57F BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;|
$86:B582 65 12       ADC $12    [$7E:0012]  ;|
$86:B584 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:B587 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;\
$86:B58A 10 18       BPL $18    [$B5A4]     ;} If [enemy projectile Y velocity] >= 0: go to BRANCH_MOVING_DOWN
$86:B58C 18          CLC                    ;\
$86:B58D 69 20 00    ADC #$0020             ;} Enemy projectile Y velocity += 20h
$86:B590 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;/
$86:B593 30 19       BMI $19    [$B5AE]     ; If [enemy projectile Y velocity] < 0: return
$86:B595 3C B7 1A    BIT $1AB7,x[$7E:1AD7]  ;\
$86:B598 10 05       BPL $05    [$B59F]     ;} If [enemy projectile X velocity] < 0:
$86:B59A A9 D7 B4    LDA #$B4D7             ; Enemy projectile instruction list pointer = $B4D7 (falling - leftwards)
$86:B59D 80 10       BRA $10    [$B5AF]     ; Go to

$86:B59F A9 E3 B4    LDA #$B4E3             ; Enemy projectile instruction list pointer = $B4E3 (falling - rightwards)
$86:B5A2 80 0B       BRA $0B    [$B5AF]

; BRANCH_MOVING_DOWN
$86:B5A4 18          CLC                    ;\
$86:B5A5 69 20 00    ADC #$0020             ;} Enemy projectile Y velocity += 20h
$86:B5A8 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;/
$86:B5AB 20 B9 B5    JSR $B5B9  [$86:B5B9]  ; Delete enemy projectile if vertically off-screen

$86:B5AE 60          RTS                    ; Return

; BRANCH_INSTRUCTION_LIST_SET
$86:B5AF 9D 47 1B    STA $1B47,x[$7E:1B67]
$86:B5B2 A9 01 00    LDA #$0001             ;\
$86:B5B5 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:B5B8 60          RTS
}


;;; $B5B9: Delete enemy projectile if vertically off-screen ;;;
{
$86:B5B9 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:B5BC 38          SEC                    ;|
$86:B5BD ED 15 09    SBC $0915  [$7E:0915]  ;|
$86:B5C0 30 08       BMI $08    [$B5CA]     ;} If 0 <= [enemy projectile Y position] - [layer 1 Y position] < 120h:
$86:B5C2 C9 20 01    CMP #$0120             ;|
$86:B5C5 90 03       BCC $03    [$B5CA]     ;/
$86:B5C7 9E 97 19    STZ $1997,x[$7E:19B7]  ; Enemy projectile ID = 0

$86:B5CA 60          RTS
}


;;; $B5CB: Enemy projectile - lava seahorse fireball ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:B5CB             dx B4EF,B535,B4BF,02,02,000A,0000,84FC ; Lava seahorse fireball. Initial instruction list ignored
}
}


;;; $B5D9..B75E: Eye door ;;;
{
;;; $B5D9: Instruction list - eye door projectile - normal ;;;
{
$86:B5D9             dw 0004,900B,
                        0003,9021,
                        0002,9037,
                        82A5,       ; Calculate direction towards Samus
                        8161,B6B9   ; Pre-instruction = $B6B9 (moving)
$86:B5EB             dw 0010,904D,
                        81AB,B5EB   ; Go to $B5EB
}


;;; $B5F3: Instruction list - eye door projectile - explode ;;;
{
$86:B5F3             dw 816A,       ; Clear pre-instruction
                        0002,9037,
                        0003,9021,
                        0004,900B,
                        8154        ; Delete
}


;;; $B603: Shot instruction list - enemy projectile $B743 (eye door projectile) ;;;
{
$86:B603             dx 0004,8007,
                        0004,800E,
                        0004,8015,
                        0004,801C,
                        8154        ; Delete
}


;;; $B615: Instruction list - eye door sweat - falling ;;;
{
$86:B615             dx 0006,9063,
                        81AB,B615   ; Go to $B615
}


;;; $B61D: Instruction list - eye door sweat - hit floor ;;;
{
$86:B61D             dx 816A,       ; Clear pre-instruction
                        0006,906A,
                        0006,9071,
                        0006,9078,
                        8154        ; Delete
}


;;; $B62D: Initialisation AI - enemy projectile $B743 (eye door projectile) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Multiple of 4, range 0..24h. Only 0 and 14h are used
$86:B62D AE 27 1C    LDX $1C27  [$7E:1C27]  ; X = [PLM ID]
$86:B630 BD C7 1D    LDA $1DC7,x[$7E:1E0D]  ;\
$86:B633 99 23 1B    STA $1B23,y[$7E:1B45]  ;} Enemy projectile PLM room argument = [PLM room argument]
$86:B636 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$86:B63A AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:B63D AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:B640 38          SEC                    ;|
$86:B641 2A          ROL A                  ;|
$86:B642 0A          ASL A                  ;|
$86:B643 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h + 8 + [$B65B + [X]]
$86:B644 0A          ASL A                  ;|
$86:B645 18          CLC                    ;|
$86:B646 7D 5B B6    ADC $B65B,x[$86:B65B]  ;|
$86:B649 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:B64C AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:B64F 0A          ASL A                  ;|
$86:B650 0A          ASL A                  ;|
$86:B651 0A          ASL A                  ;|
$86:B652 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h + [$B65B + [X] + 2]
$86:B653 18          CLC                    ;|
$86:B654 7D 5D B6    ADC $B65D,x[$86:B65D]  ;|
$86:B657 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:B65A 60          RTS

$86:B65B             dw FFF0,0010, FFA0,FFC0, FF80,FFE0, FFA0,0040, FF80,0020,
                        0010,0010, 0060,FFC0, 0070,FFC0, 0080,FFC0, 0090,FFC0
}


;;; $B683: Initialisation AI - enemy projectile $B751 (eye door sweat) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction. 0 = left, 4 = right
$86:B683 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:B686 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:B68A AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:B68D 3A          DEC A                  ;|
$86:B68E 38          SEC                    ;|
$86:B68F 2A          ROL A                  ;|
$86:B690 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h - 8
$86:B691 0A          ASL A                  ;|
$86:B692 0A          ASL A                  ;|
$86:B693 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:B696 AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:B699 1A          INC A                  ;|
$86:B69A 0A          ASL A                  ;|
$86:B69B 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h + 10h
$86:B69C 0A          ASL A                  ;|
$86:B69D 0A          ASL A                  ;|
$86:B69E 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:B6A1 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:B6A4 BD B1 B6    LDA $B6B1,x[$86:B6B1]  ;\
$86:B6A7 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = [$B6B1 + [X]]
$86:B6AA BD B3 B6    LDA $B6B3,x[$86:B6B3]  ;\
$86:B6AD 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = 200h
$86:B6B0 60          RTS

$86:B6B1             dw FFC0,0200, 0040,0200
}


;;; $B6B9: Pre-instruction - eye door projectile - moving ;;;
{
; BUG: the $B707 branch assumes the enemy projectile index is in X, but this is only true if the branch on $B6BC/C1 is taken,
; otherwise the enemy projectile index is in Y, and the door bit array index is in X,
; causing misaligned writes to enemy projectile RAM if X is odd, eventually causing a crash when the garbage instruction pointer gets executed
; (which happens after a delay of 100h+ frames due to the misaligned write to the instruction timer)

; The X/Y velocity calculations were already done as a part of calculating the angle to Samus in $82A5,
; they don't need to be here

$86:B6B9 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:B6BC B0 49       BCS $49    [$B707]     ; If collision: go to BRANCH_COLLISION
$86:B6BE 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:B6C1 B0 44       BCS $44    [$B707]     ; If collision: go to BRANCH_COLLISION
$86:B6C3 9B          TXY                    ; Y = [enemy projectile index]
$86:B6C4 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:B6C7 AA          TAX                    ;} X = [enemy projectile angle to Samus]
$86:B6C8 BF 43 B4 A0 LDA $A0B443,x[$A0:B5B3];\
$86:B6CC 4A          LSR A                  ;|
$86:B6CD 4A          LSR A                  ;|
$86:B6CE 4A          LSR A                  ;|
$86:B6CF 4A          LSR A                  ;|
$86:B6D0 89 00 08    BIT #$0800             ;|
$86:B6D3 F0 03       BEQ $03    [$B6D8]     ;} Enemy projectile X velocity = 10h * sin([A] * pi / 80h)
$86:B6D5 09 00 F0    ORA #$F000             ;|
                                            ;|
$86:B6D8 18          CLC                    ;|
$86:B6D9 79 B7 1A    ADC $1AB7,y[$7E:1AD9]  ;|
$86:B6DC 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:B6DF BF C3 B3 A0 LDA $A0B3C3,x[$A0:B533];\
$86:B6E3 4A          LSR A                  ;|
$86:B6E4 4A          LSR A                  ;|
$86:B6E5 4A          LSR A                  ;|
$86:B6E6 4A          LSR A                  ;|
$86:B6E7 89 00 08    BIT #$0800             ;|
$86:B6EA F0 03       BEQ $03    [$B6EF]     ;} Enemy projectile Y velocity = 10h * -cos([A] * pi / 80h)
$86:B6EC 09 00 F0    ORA #$F000             ;|
                                            ;|
$86:B6EF 18          CLC                    ;|
$86:B6F0 79 DB 1A    ADC $1ADB,y[$7E:1AFD]  ;|
$86:B6F3 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;/
$86:B6F6 B9 23 1B    LDA $1B23,y[$7E:1B45]  ;\
$86:B6F9 22 8E 81 80 JSL $80818E[$80:818E]  ;|
$86:B6FD BF B0 D8 7E LDA $7ED8B0,x[$7E:D8B8];} If enemy projectile PLM room argument door is not marked:
$86:B701 2D E7 05    AND $05E7  [$7E:05E7]  ;|
$86:B704 D0 01       BNE $01    [$B707]     ;/
$86:B706 60          RTS                    ; Return

; BRANCH_COLLISION
$86:B707 A9 F3 B5    LDA #$B5F3             ;\
$86:B70A 9D 47 1B    STA $1B47,x[$7E:1B67]  ;} Enemy projectile instruction list pointer = $B5F3 (explode)
$86:B70D A9 01 00    LDA #$0001             ;\
$86:B710 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:B713 60          RTS
}


;;; $B714: Pre-instruction - enemy projectile $B751 (eye door sweat) ;;;
{
$86:B714 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:B717 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:B71A 3C DB 1A    BIT $1ADB,x[$7E:1AFD]  ;\
$86:B71D 30 02       BMI $02    [$B721]     ;} If [enemy projectile Y velocity] >= 0:
$86:B71F B0 0B       BCS $0B    [$B72C]     ; If collision: go to BRANCH_HIT_FLOOR

$86:B721 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:B724 18          CLC                    ;|
$86:B725 69 0C 00    ADC #$000C             ;} Enemy projectile Y velocity += Ch
$86:B728 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:B72B 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:B72C BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:B72F 38          SEC                    ;|
$86:B730 E9 04 00    SBC #$0004             ;} Enemy projectile Y position -= 4
$86:B733 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:B736 A9 1D B6    LDA #$B61D             ;\
$86:B739 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $B61D (hit floor)
$86:B73C A9 01 00    LDA #$0001             ;\
$86:B73F 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:B742 60          RTS
}


;;; $B743: Enemy projectiles - eye door ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:B743             dx B62D,84FB,B5D9,08,08,8004,0000,B603 ; Eye door projectile
$86:B751             dx B683,B714,B615,00,00,0004,0000,84FC ; Eye door sweat
}
}


;;; $B75F: Unused. Colours ;;;
{
; "5294, 39CE, 2108, 2484" is colours Bh..Eh of lots of sprite palette 5s (common sprites)
$86:B75F             db 5294, 39CE, 2108, 2484, ; (14h, 14h, 14h), (Eh, Eh, Eh), (8, 8, 8), (4, 4, 9)
                        35AD, 2529, 14A5, 1842, ; ( Dh,  Dh,  Dh), ( 9,  9,  9), (5, 5, 5), (2, 2, 6)
                        2108, 1084, 14A5, 1842, ; (  8,   8,   8), ( 4,  4,  4), (5, 5, 5), (2, 2, 6)
                        0C63, 0421, 0842, 0000, ; (  3,   3,   3), ( 1,  1,  1), (2, 2, 2), (0, 0, 0)
                        5294, 39CE, 2108, 2484,
                        5294, 39CE, 2108, 2484,
                        5294, 39CE, 2108, 2484,
                        5294, 39CE, 2108, 2484
}


;;; $B79F..BACB: Tourian statue ;;;
{
;;; $B79F..B879: Instruction lists ;;;
{
;;; $B79F: Instruction list - delete ;;;
{
$86:B79F             dw 8154        ; Delete
}


;;; $B7A1: Instruction list - enemy projectile $BA5C (Tourian statue unlocking particle water splash) ;;;
{
$86:B7A1             dw 0008,9086,
                        0008,908D,
                        0008,9094,
                        0008,909B,
                        8154        ; Delete
}


;;; $B7B3: Instruction list - enemy projectile $BA6A (Tourian statue eye glow) ;;;
{
$86:B7B3             dx 0008,910F,
                        0008,90EF,
                        0008,90E8,
                        0007,90E1,
                        0007,90DA,
                        0007,90D3,
                        0006,90CC,
                        0006,90C5,
                        0005,90BE,
                        0030,8000,
                        8312,19,    ; Queue sound 19h, sound library 2, max queued sounds allowed = 6 (Tourian statue unlocking particle)
                        B7F5,       ; Tourian statue unlocking earthquake
                        B7EA,       ; Spawn Tourian statue unlocking particle enemy projectile
                        B7EA,       ; Spawn Tourian statue unlocking particle enemy projectile
                        B7EA,       ; Spawn Tourian statue unlocking particle enemy projectile
                        B7EA,       ; Spawn Tourian statue unlocking particle enemy projectile
                        8154        ; Delete
}


;;; $B7EA: Instruction - spawn Tourian statue unlocking particle enemy projectile ;;;
{
$86:B7EA 5A          PHY
$86:B7EB 8A          TXA                    ; A = [enemy projectile index]
$86:B7EC A0 78 BA    LDY #$BA78             ;\
$86:B7EF 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue unlocking particle enemy projectile
$86:B7F3 7A          PLY
$86:B7F4 60          RTS
}


;;; $B7F5: Instruction - Tourian statue unlocking earthquake ;;;
{
$86:B7F5 A9 01 00    LDA #$0001             ;\
$86:B7F8 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, vertical
$86:B7FB A9 20 00    LDA #$0020             ;\
$86:B7FE 0C 40 18    TSB $1840  [$7E:1840]  ;} Earthquake timer = 20h+
$86:B801 60          RTS
}


;;; $B802: Instruction list - enemy projectile $BA78 (Tourian statue unlocking particle) ;;;
{
; Timer isn't set, making the instruction loop effectively infinite
$86:B802             dw 0003,9125,
                        0003,912C,
                        B818,       ; Spawn Tourian statue unlocking particle tail enemy projectile
                        0003,913A,
                        0003,9133,
                        81C6,B802   ; Decrement timer and go to $B802 if non-zero
}


;;; $B818: Instruction - spawn Tourian statue unlocking particle tail enemy projectile ;;;
{
$86:B818 5A          PHY
$86:B819 8A          TXA                    ; A = [enemy projectile index]
$86:B81A A0 86 BA    LDY #$BA86             ;\
$86:B81D 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue unlocking particle tail enemy projectile
$86:B821 7A          PLY
$86:B822 60          RTS
}


;;; $B823: Instruction list - enemy projectile $BA86 (Tourian statue unlocking particle tail) ;;;
{
$86:B823             dw 0004,90A2,
                        B841,0008,  ; Enemy projectile Y position += 8
                        0004,90A9,
                        B841,0004,  ; Enemy projectile Y position += 4
                        0004,90B0,
                        B841,0002,  ; Enemy projectile Y position += 2
                        0004,90B7,
                        8154        ; Delete
}


;;; $B841: Instruction - enemy projectile Y position += [[Y]] ;;;
{
$86:B841 BD 93 1A    LDA $1A93,x[$7E:1AA5]  ;\
$86:B844 18          CLC                    ;|
$86:B845 79 00 00    ADC $0000,y[$86:B829]  ;} Enemy projectile Y position += [[Y]]
$86:B848 9D 93 1A    STA $1A93,x[$7E:1AA5]  ;/
$86:B84B C8          INY                    ;\
$86:B84C C8          INY                    ;} Y += 2
$86:B84D 60          RTS
}


;;; $B84E: Instruction list - enemy projectile $BA94 (Tourian statue's soul) ;;;
{
$86:B84E             dw 0008,9141,
                        0008,9157,
                        81AB,B84E   ; Go to $B84E
}


;;; $B85A: Instruction list - enemy projectile $BABE (Tourian statue - base decoration) ;;;
{
$86:B85A             dw 0080,916D,
                        8161,BA37   ; Pre-instruction = $BA37 (allow processing to finish)
$86:B862             dw 0777,916D,
                        81AB,B862   ; Go to $B862
}


;;; $B86A: Instruction list - enemy projectile $BAA2 (Tourian statue - Ridley) ;;;
{
$86:B86A             dw 0777,9192,
                        81AB,B86A   ; Go to $B86A
}


;;; $B872: Instruction list - enemy projectile $BAB0 (Tourian statue - Phantoon) ;;;
{
$86:B872             dw 0777,9207,
                        81AB,B872   ; Go to $B872
}
}


;;; $B87A..B976: Initialisation AIs ;;;
{
;;; $B87A: Initialisation AI - enemy projectile $BA5C (Tourian statue unlocking particle water splash) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Tourian statue unlocking particle enemy projectile index
$86:B87A AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:B87D BD 4B 1A    LDA $1A4B,x[$7E:1A5F]  ;\
$86:B880 99 4B 1A    STA $1A4B,y[$7E:1A4F]  ;} Enemy projectile X position = [enemy projectile [X] X position]
$86:B883 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$86:B886 38          SEC                    ;|
$86:B887 E9 04 00    SBC #$0004             ;} Enemy projectile Y position = [FX Y position] - 4
$86:B88A 99 93 1A    STA $1A93,y[$7E:1A97]  ;/
$86:B88D 60          RTS
}


;;; $B88E: Initialisation AI - enemy projectile $BA6A (Tourian statue eye glow) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Boss
;;         0: Phantoon
;;         2: Ridley
;;         4: Draygon
;;         6: Kraid
$86:B88E AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:B891 BD 0E B9    LDA $B90E,x[$86:B914]  ;\
$86:B894 99 4B 1A    STA $1A4B,y[$7E:1A67]  ;} Enemy projectile X position = [$B90E + [X]]
$86:B897 BD 16 B9    LDA $B916,x[$86:B91C]  ;\
$86:B89A 99 93 1A    STA $1A93,y[$7E:1AAF]  ;} Enemy projectile Y position = [$B916 + [X]]
$86:B89D 8A          TXA                    ;\
$86:B89E 0A          ASL A                  ;|
$86:B89F 0A          ASL A                  ;|
$86:B8A0 A8          TAY                    ;|
$86:B8A1 A2 F2 01    LDX #$01F2             ;|
                                            ;|
$86:B8A4 B9 1E B9    LDA $B91E,y[$86:B936]  ;|
$86:B8A7 9F 00 C0 7E STA $7EC000,x[$7E:C1F2];} Sprite palette 7 colours 9..Ch = 8 bytes from $B91E + [X] * 4
$86:B8AB C8          INY                    ;|
$86:B8AC C8          INY                    ;|
$86:B8AD E8          INX                    ;|
$86:B8AE E8          INX                    ;|
$86:B8AF E0 FA 01    CPX #$01FA             ;|
$86:B8B2 D0 F0       BNE $F0    [$B8A4]     ;/
$86:B8B4 60          RTS
}


;;; $B8B5: Initialisation AI - enemy projectile $BA78 (Tourian statue unlocking particle) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Tourian statue eye glow enemy projectile index
$86:B8B5 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:B8B8 BD 4B 1A    LDA $1A4B,x[$7E:1A67]  ;\
$86:B8BB 99 4B 1A    STA $1A4B,y[$7E:1A65]  ;} Enemy projectile X position = [enemy projectile [X] X position]
$86:B8BE BD 93 1A    LDA $1A93,x[$7E:1AAF]  ;\
$86:B8C1 99 93 1A    STA $1A93,y[$7E:1AAD]  ;} Enemy projectile Y position = [enemy projectile [X] Y position]
$86:B8C4 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:B8C8 29 3F 00    AND #$003F             ;\
$86:B8CB 38          SEC                    ;|
$86:B8CC E9 20 00    SBC #$0020             ;} A = ([random number] % 40h - 20h) % 100h * 2
$86:B8CF 29 FF 00    AND #$00FF             ;/
$86:B8D2 0A          ASL A                  ;\
$86:B8D3 99 FF 1A    STA $1AFF,y[$7E:1B19]  ;} Enemy projectile angle = [A] * 2
$86:B8D6 AA          TAX                    ;\
$86:B8D7 BF 43 B4 A0 LDA $A0B443,x[$A0:B635];} Enemy projectile X velocity = 100h * sin([A] * pi / 80h)
$86:B8DB 99 B7 1A    STA $1AB7,y[$7E:1AD1]  ;/
$86:B8DE BF C3 B3 A0 LDA $A0B3C3,x[$A0:B5B5];\
$86:B8E2 0A          ASL A                  ;|
$86:B8E3 0A          ASL A                  ;} Enemy projectile Y velocity = 400h * -cos([A] * pi / 80h)
$86:B8E4 99 DB 1A    STA $1ADB,y[$7E:1AF5]  ;/
$86:B8E7 60          RTS
}


;;; $B8E8: Initialisation AI - enemy projectile $BA86 (Tourian statue unlocking particle tail) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Tourian statue unlocking particle enemy projectile index
$86:B8E8 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:B8EB BD 4B 1A    LDA $1A4B,x[$7E:1A65]  ;\
$86:B8EE 99 4B 1A    STA $1A4B,y[$7E:1A67]  ;} Enemy projectile X position = [enemy projectile [X] X position]
$86:B8F1 BD 93 1A    LDA $1A93,x[$7E:1AAD]  ;\
$86:B8F4 99 93 1A    STA $1A93,y[$7E:1AAF]  ;} Enemy projectile Y position = [enemy projectile [X] Y position]
$86:B8F7 60          RTS
}


;;; $B8F8: Initialisation AI - enemy projectile $BA94 (Tourian statue's soul) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Boss
;;         0: Phantoon
;;         2: Ridley
;;         4: Draygon
;;         6: Kraid
$86:B8F8 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter 0]
$86:B8FB BD 0E B9    LDA $B90E,x[$86:B914]  ;\
$86:B8FE 99 4B 1A    STA $1A4B,y[$7E:1A4F]  ;} Enemy projectile X position = [$B90E + [X]]
$86:B901 BD 16 B9    LDA $B916,x[$86:B91C]  ;\
$86:B904 99 93 1A    STA $1A93,y[$7E:1A97]  ;} Enemy projectile Y position = [$B916 + [X]]
$86:B907 A9 00 FC    LDA #$FC00             ;\
$86:B90A 99 DB 1A    STA $1ADB,y[$7E:1ADF]  ;} Enemy projectile Y velocity = -400h
$86:B90D 60          RTS
}


;;; $B90E: Tourian statue eye data ;;;
{
; Tourian statue eye/soul positions
;                        __________________ Phantoon
;                       |     _____________ Ridley
;                       |    |     ________ Draygon
;                       |    |    |     ___ Kraid
;                       |    |    |    |
$86:B90E             dw 0084,007A,009E,0068 ; X position
$86:B916             dw 0090,0051,0080,0072 ; Y position

; Sprite palette 7 colours 9..Ch. Eye glow colours
$86:B91E             dw 6BFF,033B,0216,0173 ; Phantoon (yellow)
                        7F5F,7C1F,5816,300C ; Ridley (red)
                        7F5A,7EC0,6DE0,54E0 ; Draygon (blue)
                        6BFA,3BE0,2680,1580 ; Kraid (green)
}


;;; $B93E: Initialisation AI - enemy projectile $BABE (Tourian statue - base decoration) ;;;
{
$86:B93E A9 78 00    LDA #$0078             ;\
$86:B941 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile X position = enemy projectile X position mirror = 78h
$86:B944 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:B947 A9 B8 00    LDA #$00B8             ;\
$86:B94A 99 23 1B    STA $1B23,y[$7E:1B45]  ;} Enemy projectile Y position = enemy projectile Y offset = B8h
$86:B94D 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:B950 60          RTS
}


;;; $B951: Initialisation AI - enemy projectile $BAA2 (Tourian statue - Ridley) ;;;
{
$86:B951 A9 8E 00    LDA #$008E             ;\
$86:B954 99 FF 1A    STA $1AFF,y[$7E:1B1F]  ;} Enemy projectile X position = enemy projectile X position mirror = 8Eh
$86:B957 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:B95A A9 55 00    LDA #$0055             ;\
$86:B95D 99 23 1B    STA $1B23,y[$7E:1B43]  ;} Enemy projectile Y position = enemy projectile Y offset = 55h
$86:B960 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:B963 60          RTS
}


;;; $B964: Initialisation AI - enemy projectile $BAB0 (Tourian statue - Phantoon) ;;;
{
$86:B964 A9 84 00    LDA #$0084             ;\
$86:B967 99 FF 1A    STA $1AFF,y[$7E:1B1D]  ;} Enemy projectile X position = enemy projectile X position mirror = 84h
$86:B96A 99 4B 1A    STA $1A4B,y[$7E:1A69]  ;/
$86:B96D A9 88 00    LDA #$0088             ;\
$86:B970 99 23 1B    STA $1B23,y[$7E:1B41]  ;} Enemy projectile Y position = enemy projectile Y offset = 88h
$86:B973 99 93 1A    STA $1A93,y[$7E:1AB1]  ;/
$86:B976 60          RTS
}
}


;;; $B977..BA5B: Pre-instructions ;;;
{
;;; $B977: Pre-instruction - enemy projectile $BA5C (Tourian statue unlocking particle water splash) ;;;
{
$86:B977 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$86:B97A 38          SEC                    ;|
$86:B97B E9 04 00    SBC #$0004             ;} Enemy projectile Y position = [FX Y position] - 4
$86:B97E 9D 93 1A    STA $1A93,x[$7E:1A97]  ;/
$86:B981 60          RTS
}


;;; $B982: Pre-instruction - enemy projectile $BA78 (Tourian statue unlocking particle) ;;;
{
$86:B982 64 12       STZ $12    [$7E:0012]  ;\
$86:B984 64 14       STZ $14    [$7E:0014]  ;|
$86:B986 BD B7 1A    LDA $1AB7,x[$7E:1AD1]  ;|
$86:B989 10 02       BPL $02    [$B98D]     ;|
$86:B98B C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:B98D 85 13       STA $13    [$7E:0013]  ;|
$86:B98F BD 27 1A    LDA $1A27,x[$7E:1A41]  ;} Enemy projectile X position += [enemy projectile X velocity] / 100h
$86:B992 18          CLC                    ;|
$86:B993 65 12       ADC $12    [$7E:0012]  ;|
$86:B995 9D 27 1A    STA $1A27,x[$7E:1A41]  ;|
$86:B998 BD 4B 1A    LDA $1A4B,x[$7E:1A65]  ;|
$86:B99B 65 14       ADC $14    [$7E:0014]  ;|
$86:B99D 9D 4B 1A    STA $1A4B,x[$7E:1A65]  ;/
$86:B9A0 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$86:B9A3 38          SEC                    ;} A = [FX Y position] - [enemy projectile Y position]
$86:B9A4 FD 93 1A    SBC $1A93,x[$7E:1AAD]  ;/
$86:B9A7 48          PHA
$86:B9A8 64 12       STZ $12    [$7E:0012]  ;\
$86:B9AA 64 14       STZ $14    [$7E:0014]  ;|
$86:B9AC BD DB 1A    LDA $1ADB,x[$7E:1AF5]  ;|
$86:B9AF 10 02       BPL $02    [$B9B3]     ;|
$86:B9B1 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:B9B3 85 13       STA $13    [$7E:0013]  ;|
$86:B9B5 BD 6F 1A    LDA $1A6F,x[$7E:1A89]  ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
$86:B9B8 18          CLC                    ;|
$86:B9B9 65 12       ADC $12    [$7E:0012]  ;|
$86:B9BB 9D 6F 1A    STA $1A6F,x[$7E:1A89]  ;|
$86:B9BE BD 93 1A    LDA $1A93,x[$7E:1AAD]  ;|
$86:B9C1 65 14       ADC $14    [$7E:0014]  ;|
$86:B9C3 9D 93 1A    STA $1A93,x[$7E:1AAD]  ;/
$86:B9C6 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$86:B9C9 38          SEC                    ;|
$86:B9CA FD 93 1A    SBC $1A93,x[$7E:1AAD]  ;} If sgn([A]) != sgn([FX Y position] - [enemy projectile Y position]):
$86:B9CD 43 01       EOR $01,s  [$7E:1FF1]  ;|
$86:B9CF 10 08       BPL $08    [$B9D9]     ;/
$86:B9D1 8A          TXA                    ; A = [enemy projectile index]
$86:B9D2 A0 5C BA    LDY #$BA5C             ;\
$86:B9D5 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Tourian statue unlocking particle water splash enemy projectile

$86:B9D9 68          PLA
$86:B9DA BD 93 1A    LDA $1A93,x[$7E:1AAD]  ;\
$86:B9DD 29 00 FF    AND #$FF00             ;|
$86:B9E0 C9 00 01    CMP #$0100             ;} If [enemy projectile Y position] / 100h != 1:
$86:B9E3 F0 0B       BEQ $0B    [$B9F0]     ;/
$86:B9E5 BD DB 1A    LDA $1ADB,x[$7E:1AF5]  ;\
$86:B9E8 18          CLC                    ;|
$86:B9E9 69 10 00    ADC #$0010             ;} Enemy projectile Y velocity += 10h
$86:B9EC 9D DB 1A    STA $1ADB,x[$7E:1AF5]  ;/
$86:B9EF 60          RTS                    ; Return

$86:B9F0 A9 9F B7    LDA #$B79F             ;\
$86:B9F3 9D 47 1B    STA $1B47,x[$7E:1B5B]  ;} Enemy projectile instruction list pointer = $B79F (delete)
$86:B9F6 A9 01 00    LDA #$0001             ;\
$86:B9F9 9D 8F 1B    STA $1B8F,x[$7E:1BA3]  ;} Enemy projectile instruction timer = 1
$86:B9FC 60          RTS
}


;;; $B9FD: Pre-instruction - enemy projectile $BA94 (Tourian statue's soul) ;;;
{
$86:B9FD 64 12       STZ $12    [$7E:0012]  ;\
$86:B9FF 64 14       STZ $14    [$7E:0014]  ;|
$86:BA01 BD DB 1A    LDA $1ADB,x[$7E:1ADF]  ;|
$86:BA04 10 02       BPL $02    [$BA08]     ;|
$86:BA06 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:BA08 85 13       STA $13    [$7E:0013]  ;|
$86:BA0A BD 6F 1A    LDA $1A6F,x[$7E:1A73]  ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
$86:BA0D 18          CLC                    ;|
$86:BA0E 65 12       ADC $12    [$7E:0012]  ;|
$86:BA10 9D 6F 1A    STA $1A6F,x[$7E:1A73]  ;|
$86:BA13 BD 93 1A    LDA $1A93,x[$7E:1A97]  ;|
$86:BA16 65 14       ADC $14    [$7E:0014]  ;|
$86:BA18 9D 93 1A    STA $1A93,x[$7E:1A97]  ;/
$86:BA1B 89 00 01    BIT #$0100             ;\
$86:BA1E F0 0C       BEQ $0C    [$BA2C]     ;} If [enemy projectile Y position] / 100h % 2 != 0:
$86:BA20 A9 9F B7    LDA #$B79F             ;\
$86:BA23 9D 47 1B    STA $1B47,x[$7E:1B4B]  ;} Enemy projectile instruction list pointer = $B79F (delete)
$86:BA26 A9 01 00    LDA #$0001             ;\
$86:BA29 9D 8F 1B    STA $1B8F,x[$7E:1B93]  ;} Enemy projectile instruction timer = 1

$86:BA2C BD DB 1A    LDA $1ADB,x[$7E:1ADF]  ;\
$86:BA2F 18          CLC                    ;|
$86:BA30 69 80 FF    ADC #$FF80             ;} Enemy projectile Y velocity -= 80h
$86:BA33 9D DB 1A    STA $1ADB,x[$7E:1ADF]  ;/
$86:BA36 60          RTS
}


;;; $BA37: Pre-instruction - Tourian statue - base decoration - allow processing to finish ;;;
{
$86:BA37 AD 6F 1E    LDA $1E6F  [$7E:1E6F]  ;\
$86:BA3A D0 06       BNE $06    [$BA42]     ;} If [Tourian entrance statue animation state] = 0:
$86:BA3C A9 00 80    LDA #$8000             ;\
$86:BA3F 0C 6D 1E    TSB $1E6D  [$7E:1E6D]  ;} Tourian entrance statue finished processing flag = 8000h
}


;;; $BA42: Pre-instruction - enemy projectile $BAA2/$BAB0/$BABE (Tourian statue - Ridley / Phantoon / base decoration) ;;;
{
$86:BA42 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:BA45 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [enemy projectile X position mirror]
$86:BA48 AF 00 9E 7E LDA $7E9E00[$7E:9E00]  ;\
$86:BA4C 49 FF FF    EOR #$FFFF             ;|
$86:BA4F 1A          INC A                  ;|
$86:BA50 18          CLC                    ;|
$86:BA51 6D 15 09    ADC $0915  [$7E:0915]  ;} Enemy projectile Y position = [enemy projectile Y offset] + [layer 1 Y position] - [Tourian entrance statue BG2 Y scroll]
$86:BA54 18          CLC                    ;|
$86:BA55 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;|
$86:BA58 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:BA5B 60          RTS
}
}


;;; $BA5C: Enemy projectiles - Tourian statue ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:BA5C             dx B87A,B977,B7A1,00,00,3000,0000,84FC ; Tourian statue unlocking particle water splash
$86:BA6A             dx B88E,84FB,B7B3,00,00,3000,0000,84FC ; Tourian statue eye glow
$86:BA78             dx B8B5,B982,B802,00,00,3000,0000,84FC ; Tourian statue unlocking particle
$86:BA86             dx B8E8,84FB,B823,00,00,3000,0000,84FC ; Tourian statue unlocking particle tail
$86:BA94             dx B8F8,B9FD,B84E,00,00,3000,0000,84FC ; Tourian statue's soul
$86:BAA2             dx B951,BA42,B86A,00,00,2000,0000,84FC ; Tourian statue - Ridley
$86:BAB0             dx B964,BA42,B872,00,00,2000,0000,84FC ; Tourian statue - Phantoon
$86:BABE             dx B93E,BA42,B85A,00,00,2000,0000,84FC ; Tourian statue - base decoration
}
}


;;; $BACC..BB5D: Enemy projectile $BB50 (unused) ;;;
{
;;; $BACC: Instruction list - enemy projectile $BB50 - parameter 0 ;;;
{
$86:BACC             dx 0002,9268,
                        0002,926F,
                        0002,9276,
                        0002,927D,
                        0002,9284,
                        0002,928B,
                        0002,9292,
                        8154        ; Delete
}


;;; $BAEA: Instruction list - enemy projectile $BB50 - parameter 1 ;;;
{
$86:BAEA             dx 0002,9299,
                        0002,92A0,
                        0002,92A7,
                        0002,92AE,
                        0002,92B5,
                        0002,92BC,
                        0002,92C3,
                        8154        ; Delete
}


;;; $BB08: Instruction list - enemy projectile $BB50 - parameter 2 ;;;
{
$86:BB08             dx 0002,92CA,
                        0002,92CA,
                        0002,92D6,
                        0002,92E2,
                        0002,92FA,
                        8154        ; Delete
}


;;; $BB1E: Instruction list pointers ;;;
{
$86:BB1E             dw BACC, BAEA, BB08
}


;;; $BB24: Unused. Random buggy code ;;;
{
; This code makes no sense
$86:BB24 5A          PHY
$86:BB25 AC 50 BB    LDY $BB50  [$86:BB50]
$86:BB28 A9 00 00    LDA #$0000
$86:BB2B 99 47 1B    STA $1B47,y
$86:BB2E 7A          PLY
$86:BB2F 60          RTS
}


;;; $BB30: Initialisation AI - enemy projectile $BB50 ;;;
{
; Ceres Ridley is the only enemy that uses both $7E:8022 and $7E:8024, but it uses them as flags
; So there's no way of knowing what enemy was supposed to spawn this projectile (if any)
$86:BB30 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:BB33 BF 22 80 7E LDA $7E8022,x          ;\
$86:BB37 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [enemy $7E:8022]
$86:BB3A BF 24 80 7E LDA $7E8024,x          ;\
$86:BB3E 99 93 1A    STA $1A93,y            ;} Enemy projectile Y position = [enemy $7E:8024]
$86:BB41 5A          PHY                    ;\
$86:BB42 AD 93 19    LDA $1993  [$7E:1993]  ;|
$86:BB45 0A          ASL A                  ;|
$86:BB46 A8          TAY                    ;} Enemy projectile instruction list pointer = [$BB1E + [enemy projectile initialisation parameter] * 2]
$86:BB47 B9 1E BB    LDA $BB1E,y            ;|
$86:BB4A 7A          PLY                    ;|
$86:BB4B 99 47 1B    STA $1B47,y            ;/
$86:BB4E 60          RTS
}


;;; $BB4F: RTS. Pre-instruction - enemy projectile $BB50 ;;;
{
$86:BB4F 60          RTS
}


;;; $BB50: Unused. Enemy projectile $BB50 ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:BB50             dx BB30,BB4F,BACC,00,00,0000,7000,84FC
}
}


;;; $BB5E..BBD4: Nuclear waffle body ;;;
{
;;; $BB5E: Instruction list - enemy projectile $BBC7 (Nuclear waffle body) ;;;
{
$86:BB5E             dx 0003,9306,
                        0003,930D,
                        0003,9322,
                        0003,9314,
                        0003,931B,
                        0003,9329,
                        0003,9306,
                        0003,930D,
                        0003,9330,
                        0003,9314,
                        0003,931B,
                        0003,9337,
                        81AB,BB5E   ; Go to $BB5E
}


;;; $BB92: Initialisation AI - enemy projectile $BBC7 (nuclear waffle body) ;;;
{
$86:BB92 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:BB95 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:BB98 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;|
$86:BB9B BD 7C 0F    LDA $0F7C,x[$7E:0F7C]  ;} Enemy projectile X position = [enemy X position]
$86:BB9E 99 27 1A    STA $1A27,y[$7E:1A49]  ;/
$86:BBA1 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:BBA4 99 93 1A    STA $1A93,y[$7E:1AB5]  ;|
$86:BBA7 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;} Enemy projectile Y position = [enemy Y position]
$86:BBAA 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;/
$86:BBAD DA          PHX
$86:BBAE BF 14 80 7E LDA $7E8014,x[$7E:8014];\
$86:BBB2 18          CLC                    ;|
$86:BBB3 6D 54 0E    ADC $0E54  [$7E:0E54]  ;|
$86:BBB6 AA          TAX                    ;} Enemy enemy projectile indices + [enemy body index] = [enemy projectile index]
$86:BBB7 98          TYA                    ;|
$86:BBB8 9F 00 78 7E STA $7E7800,x[$7E:7808];/
$86:BBBC BB          TYX                    ;\
$86:BBBD A9 01 00    LDA #$0001             ;} Enable enemy projectile buggy dud shot
$86:BBC0 9F 80 F3 7E STA $7EF380,x[$7E:F3A2];/
$86:BBC4 FA          PLX
$86:BBC5 60          RTS
}


;;; $BBC6: RTS. Pre-instruction - enemy projectile $BBC7 (nuclear waffle body) ;;;
{
$86:BBC6 60          RTS
}


;;; $BBC7: Enemy projectile - nuclear waffle body ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:BBC7             dx BB92,BBC6,BB5E,08,08,C040,0000,84FC ; Nuclear waffle body
}
}


;;; $BBD5..BD67: Norfair lavaquake rocks ;;;
{
;;; $BBD5: Instruction list - enemy projectile $BD5A (Norfair lavaquake rocks) ;;;
{
$86:BBD5             dx 0001,9340,
                        8159        ; Sleep
}


;;; $BBDB: Initialisation AI - enemy projectile $BD5A (Norfair lavaquake rocks) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Initial Y speed table index. Range 0..5Eh
;;     $1995: X velocity
$86:BBDB A9 D5 BB    LDA #$BBD5             ;\
$86:BBDE 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $BBD5
$86:BBE1 A9 16 BC    LDA #$BC16             ;\
$86:BBE4 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile function = $BC16 (rising)
$86:BBE7 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:BBEA 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y speed table index = [enemy projectile initialisation parameter 0]
$86:BBED AD 95 19    LDA $1995  [$7E:1995]  ;\
$86:BBF0 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = [enemy projectile initialisation parameter 1]
$86:BBF3 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:BBF6 BD 7A 0F    LDA $0F7A,x[$7E:11BA]  ;\
$86:BBF9 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;|
$86:BBFC BD 7C 0F    LDA $0F7C,x[$7E:11BC]  ;} Enemy projectile X position = [enemy X position]
$86:BBFF 99 27 1A    STA $1A27,y[$7E:1A49]  ;/
$86:BC02 BD 7E 0F    LDA $0F7E,x[$7E:11BE]  ;\
$86:BC05 99 93 1A    STA $1A93,y[$7E:1AB5]  ;|
$86:BC08 BD 80 0F    LDA $0F80,x[$7E:11C0]  ;} Enemy projectile Y position = [enemy Y position]
$86:BC0B 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;/
$86:BC0E 60          RTS
}


;;; $BC0F: Pre-instruction - enemy projectile $BD5A (Norfair lavaquake rocks) ;;;
{
$86:BC0F FC FF 1A    JSR ($1AFF,x)[$86:BC16]; Execute [enemy projectile function]
$86:BC12 20 1E BD    JSR $BD1E  [$86:BD1E]  ; Delete enemy projectile if off screen
$86:BC15 60          RTS
}


;;; $BC16: Norfair lavaquake rocks function - rising ;;;
{
$86:BC16 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:BC19 38          SEC                    ;|
$86:BC1A E9 02 00    SBC #$0002             ;} Enemy projectile Y speed table index -= 2
$86:BC1D 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:BC20 10 0B       BPL $0B    [$BC2D]     ; If [enemy projectile Y speed table index] < 0:
$86:BC22 9E DB 1A    STZ $1ADB,x[$7E:1AFD]  ; Enemy projectile Y speed table index = 0
$86:BC25 A9 8F BC    LDA #$BC8F             ;\
$86:BC28 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile function = $BC8F (falling)
$86:BC2B 80 61       BRA $61    [$BC8E]     ; Return

$86:BC2D A9 02 00    LDA #$0002             ;\
$86:BC30 85 12       STA $12    [$7E:0012]  ;} $12 = 2 (loop counter)

; LOOP
$86:BC32 DA          PHX
$86:BC33 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:BC36 18          CLC                    ;|
$86:BC37 65 12       ADC $12    [$7E:0012]  ;|
$86:BC39 3A          DEC A                  ;|
$86:BC3A 10 03       BPL $03    [$BC3F]     ;|
$86:BC3C A9 00 00    LDA #$0000             ;} A = max(0, [enemy projectile Y speed table index] + [$12] - 1) * 8 (quadratic speed table index)
                                            ;|
$86:BC3F 0A          ASL A                  ;|
$86:BC40 0A          ASL A                  ;|
$86:BC41 0A          ASL A                  ;/
$86:BC42 1A          INC A                  ;\
$86:BC43 1A          INC A                  ;|
$86:BC44 1A          INC A                  ;|
$86:BC45 1A          INC A                  ;|
$86:BC46 AA          TAX                    ;} Enemy projectile Y subvelocity = [$A0:CBC7 + [A] + 4]
$86:BC47 BF C7 CB A0 LDA $A0CBC7,x[$A0:CD03];|
$86:BC4B FA          PLX                    ;|
$86:BC4C 9D 23 1B    STA $1B23,x[$7E:1B45]  ;/
$86:BC4F BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;\
$86:BC52 18          CLC                    ;|
$86:BC53 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;|
$86:BC56 90 03       BCC $03    [$BC5B]     ;} Enemy projectile Y position += [enemy projectile Y subvelocity] / 10000h
$86:BC58 FE 93 1A    INC $1A93,x[$7E:1AB5]  ;|
                                            ;|
$86:BC5B 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;/
$86:BC5E DA          PHX
$86:BC5F BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:BC62 18          CLC                    ;|
$86:BC63 65 12       ADC $12    [$7E:0012]  ;|
$86:BC65 3A          DEC A                  ;|
$86:BC66 10 03       BPL $03    [$BC6B]     ;|
$86:BC68 A9 00 00    LDA #$0000             ;} A = max(0, [enemy projectile Y speed table index] + [$12] - 1) * 8 (quadratic speed table index) >_<;
                                            ;|
$86:BC6B 0A          ASL A                  ;|
$86:BC6C 0A          ASL A                  ;|
$86:BC6D 0A          ASL A                  ;/
$86:BC6E 1A          INC A                  ;\
$86:BC6F 1A          INC A                  ;|
$86:BC70 1A          INC A                  ;|
$86:BC71 1A          INC A                  ;|
$86:BC72 1A          INC A                  ;|
$86:BC73 1A          INC A                  ;} Enemy projectile Y velocity = [$A0:CBC7 + [A] + 6]
$86:BC74 AA          TAX                    ;|
$86:BC75 BF C7 CB A0 LDA $A0CBC7,x[$A0:CD05];|
$86:BC79 FA          PLX                    ;|
$86:BC7A 9D 23 1B    STA $1B23,x[$7E:1B45]  ;/
$86:BC7D BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:BC80 18          CLC                    ;|
$86:BC81 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;} Enemy projectile Y position += [enemy projectile Y velocity]
$86:BC84 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:BC87 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$86:BC89 D0 A7       BNE $A7    [$BC32]     ; If [$12] != 0: go to LOOP
$86:BC8B 20 F4 BC    JSR $BCF4  [$86:BCF4]  ; Move enemy projectile according to X velocity

$86:BC8E 60          RTS
}


;;; $BC8F: Norfair lavaquake rocks function - falling ;;;
{
$86:BC8F BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:BC92 18          CLC                    ;|
$86:BC93 69 02 00    ADC #$0002             ;|
$86:BC96 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;|
$86:BC99 C9 40 00    CMP #$0040             ;} Enemy projectile Y speed table index = min(40h, [enemy projectile Y speed table index] + 2)
$86:BC9C 30 06       BMI $06    [$BCA4]     ;|
$86:BC9E A9 40 00    LDA #$0040             ;|
$86:BCA1 9D DB 1A    STA $1ADB,x            ;/

$86:BCA4 A9 02 00    LDA #$0002             ;\
$86:BCA7 85 12       STA $12    [$7E:0012]  ;} $12 = 2 (loop counter)

; LOOP
$86:BCA9 DA          PHX
$86:BCAA BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:BCAD 38          SEC                    ;|
$86:BCAE E5 12       SBC $12    [$7E:0012]  ;|
$86:BCB0 1A          INC A                  ;} A = ([enemy projectile Y speed table index] - ([$12] - 1)) * 8 (quadratic speed table index)
$86:BCB1 0A          ASL A                  ;|
$86:BCB2 0A          ASL A                  ;|
$86:BCB3 0A          ASL A                  ;/
$86:BCB4 AA          TAX                    ;\
$86:BCB5 BF C7 CB A0 LDA $A0CBC7,x[$A0:CBCF];|
$86:BCB9 FA          PLX                    ;} Enemy projectile Y subvelocity = [$A0:CBC7 + [A]]
$86:BCBA 9D 23 1B    STA $1B23,x[$7E:1B45]  ;/
$86:BCBD BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;\
$86:BCC0 18          CLC                    ;|
$86:BCC1 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;|
$86:BCC4 90 03       BCC $03    [$BCC9]     ;} Enemy projectile Y position += [enemy projectile Y subvelocity] / 10000h
$86:BCC6 FE 93 1A    INC $1A93,x[$7E:1AB5]  ;|
                                            ;|
$86:BCC9 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;/
$86:BCCC DA          PHX
$86:BCCD BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:BCD0 38          SEC                    ;|
$86:BCD1 E5 12       SBC $12    [$7E:0012]  ;|
$86:BCD3 1A          INC A                  ;} A = ([enemy projectile Y speed table index] - ([$12] - 1)) * 8 (quadratic speed table index) >_<;
$86:BCD4 0A          ASL A                  ;|
$86:BCD5 0A          ASL A                  ;|
$86:BCD6 0A          ASL A                  ;/
$86:BCD7 1A          INC A                  ;\
$86:BCD8 1A          INC A                  ;|
$86:BCD9 AA          TAX                    ;|
$86:BCDA BF C7 CB A0 LDA $A0CBC7,x[$A0:CBD1];} Enemy projectile Y subvelocity = [$A0:CBC7 + [A] + 2]
$86:BCDE FA          PLX                    ;|
$86:BCDF 9D 23 1B    STA $1B23,x[$7E:1B45]  ;/
$86:BCE2 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:BCE5 18          CLC                    ;|
$86:BCE6 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;} Enemy projectile Y position += [enemy projectile Y velocity]
$86:BCE9 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:BCEC C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$86:BCEE D0 B9       BNE $B9    [$BCA9]     ; If [$12] != 0: go to LOOP
$86:BCF0 20 F4 BC    JSR $BCF4  [$86:BCF4]  ; Move enemy projectile according to X velocity
$86:BCF3 60          RTS
}


;;; $BCF4: Move enemy projectile according to X velocity ;;;
{
$86:BCF4 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:BCF7 29 00 FF    AND #$FF00             ;|
$86:BCFA EB          XBA                    ;} A = ±[enemy projectile X velocity high]
$86:BCFB 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;/
$86:BCFF 18          CLC                    ;\
$86:BD00 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position += [A]
$86:BD03 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:BD06 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:BD09 29 FF 00    AND #$00FF             ;} A = [enemy projectile X velocity low] * 100h
$86:BD0C EB          XBA                    ;/
$86:BD0D 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ; >_<;
$86:BD11 18          CLC                    ;\
$86:BD12 7D 27 1A    ADC $1A27,x[$7E:1A49]  ;} Enemy projectile X subposition += [A]
$86:BD15 90 03       BCC $03    [$BD1A]     ; If carry set:
$86:BD17 FE 4B 1A    INC $1A4B,x[$7E:1A6D]  ; Enemy projectile X position += 1

$86:BD1A 9D 27 1A    STA $1A27,x[$7E:1A49]
$86:BD1D 60          RTS
}


;;; $BD1E: Delete enemy projectile if off screen ;;;
{
$86:BD1E 20 2A BD    JSR $BD2A  [$86:BD2A]  ;\
$86:BD21 F0 06       BEQ $06    [$BD29]     ;} If enemy projectile is off screen:
$86:BD23 A9 00 00    LDA #$0000             ;\
$86:BD26 9D 97 19    STA $1997,x[$7E:19B9]  ;} Enemy projectile ID = 0

$86:BD29 60          RTS
}


;;; $BD2A: Check if enemy projectile is off screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise
$86:BD2A BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:BD2D CD 11 09    CMP $0911  [$7E:0911]  ;|
$86:BD30 30 24       BMI $24    [$BD56]     ;|
$86:BD32 AD 11 09    LDA $0911  [$7E:0911]  ;|
$86:BD35 18          CLC                    ;} If 0 <= [enemy projectile X position] - [layer 1 X position] <= 100h:
$86:BD36 69 00 01    ADC #$0100             ;|
$86:BD39 DD 4B 1A    CMP $1A4B,x[$7E:1A6D]  ;|
$86:BD3C 30 18       BMI $18    [$BD56]     ;/
$86:BD3E BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:BD41 CD 15 09    CMP $0915  [$7E:0915]  ;|
$86:BD44 30 10       BMI $10    [$BD56]     ;|
$86:BD46 AD 15 09    LDA $0915  [$7E:0915]  ;|
$86:BD49 18          CLC                    ;} If 0 <= [enemy projectile Y position] - [layer 1 Y position] <= 100h:
$86:BD4A 69 00 01    ADC #$0100             ;|
$86:BD4D DD 93 1A    CMP $1A93,x[$7E:1AB5]  ;|
$86:BD50 30 04       BMI $04    [$BD56]     ;/
$86:BD52 A9 00 00    LDA #$0000             ;\
$86:BD55 60          RTS                    ;} Return A = 0

$86:BD56 A9 01 00    LDA #$0001             ;\
$86:BD59 60          RTS                    ;} Return A = 1
}


;;; $BD5A: Enemy projectile - Norfair lavaquake rocks ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:BD5A             dx BBDB,BC0F,BBD5,02,02,0010,0000,84FC ; Norfair lavaquake rocks. Initial instruction list ignored
}
}


;;; $BD68..BE4E: Shaktool's attack ;;;
{
;;; $BD68: Instruction list - enemy projectile $BE25 (Shaktool's attack - front circle) ;;;
{
$86:BD68             dw 0004,9347,
                        0004,934E
$86:BD70             dw 0077,9355,
                        81AB,BD70   ; Go to $BD70
}


;;; $BD78: Instruction list - enemy projectile $BE33 (Shaktool's attack - middle circle) ;;;
{
$86:BD78             dw 0006,9347,
                        8161,BE12,  ; Pre-instruction = $BE12 (moving)
                        0004,9347
$86:BD84             dw 0077,934E,
                        81AB,BD84   ; Go to $BD84
}


;;; $BD8C: Instruction list - enemy projectile $BE41 (Shaktool's attack - back circle) ;;;
{
$86:BD8C             dw 000A,9347,
                        8161,BE12   ; Pre-instruction = $BE12 (moving)
$86:BD94             dw 0077,9347,
                        81AB,BD94   ; Go to $BD94
}


;;; $BD9C: Initialisation AI - enemy projectile $BE33/$BE41 (Shaktool's attack - middle/back circle) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Front circle enemy projectile index
$86:BD9C AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:BD9F 99 FF 1A    STA $1AFF,y            ;} Enemy projectile front circle index = [enemy projectile initialisation parameter 0]
}


;;; $BDA2: Initialisation AI - enemy projectile $BE25 (Shaktool's attack - front circle) ;;;
{
$86:BDA2 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:BDA5 BD 7A 0F    LDA $0F7A,x            ;\
$86:BDA8 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [enemy X position]
$86:BDAB BD 7E 0F    LDA $0F7E,x            ;\
$86:BDAE 99 93 1A    STA $1A93,y            ;} Enemy projectile Y position = [enemy Y position]
$86:BDB1 BD AE 0F    LDA $0FAE,x            ;\
$86:BDB4 29 FF 00    AND #$00FF             ;} A = [enemy head direction]
$86:BDB7 0A          ASL A                  ;\
$86:BDB8 AA          TAX                    ;|
$86:BDB9 BF 43 B4 A0 LDA $A0B443,x          ;} Enemy projectile X velocity = 100h * sin([A] * pi / 80h)
$86:BDBD 99 B7 1A    STA $1AB7,y            ;/
$86:BDC0 BF C3 B3 A0 LDA $A0B3C3,x          ;\
$86:BDC4 99 DB 1A    STA $1ADB,y            ;} Enemy projectile Y velocity = 100h * -cos([A] * pi / 80h)
$86:BDC7 8A          TXA                    ;\
$86:BDC8 4A          LSR A                  ;|
$86:BDC9 4A          LSR A                  ;|
$86:BDCA 4A          LSR A                  ;} X = [A] / 10h
$86:BDCB 4A          LSR A                  ;|
$86:BDCC 4A          LSR A                  ;|
$86:BDCD AA          TAX                    ;/
$86:BDCE BD E3 BD    LDA $BDE3,x            ;\
$86:BDD1 18          CLC                    ;|
$86:BDD2 79 4B 1A    ADC $1A4B,y            ;} Enemy projectile X position += [$BDE3 + [X]]
$86:BDD5 99 4B 1A    STA $1A4B,y            ;/
$86:BDD8 BD F3 BD    LDA $BDF3,x            ;\
$86:BDDB 18          CLC                    ;|
$86:BDDC 79 93 1A    ADC $1A93,y            ;} Enemy projectile Y position += [$BDF3 + [X]]
$86:BDDF 99 93 1A    STA $1A93,y            ;/
$86:BDE2 60          RTS

$86:BDE3             dw 0000, 000C, 0010, 000C, 0000, FFF4, FFF0, FFF4 ; X offset
$86:BDF3             dw FFF0, FFF4, 0000, 000C, 0010, 000C, 0000, FFF4 ; Y offset
}


;;; $BE03: Pre-instruction - enemy projectile $BE25 (Shaktool's attack - front circle) ;;;
{
$86:BE03 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:BE06 B0 06       BCS $06    [$BE0E]     ; If no collision:
$86:BE08 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:BE0B B0 01       BCS $01    [$BE0E]     ; If no collision:
$86:BE0D 60          RTS                    ; Return

$86:BE0E 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0
$86:BE11 60          RTS
}


;;; $BE12: Pre-instruction - Shaktool's attack - middle/back circle - moving ;;;
{
$86:BE12 BC FF 1A    LDY $1AFF,x            ; Y = [enemy projectile front circle index]
$86:BE15 B9 97 19    LDA $1997,y            ;\
$86:BE18 F0 07       BEQ $07    [$BE21]     ;} If [enemy projectile [Y] ID] != 0:
$86:BE1A 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:BE1D 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:BE20 60          RTS                    ; Return

$86:BE21 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0
$86:BE24 60          RTS
}


;;; $BE25: Enemy projectiles - Shaktool's attack ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:BE25             dx BDA2,BE03,BD68,04,04,000A,0000,84FC ; Shaktool's attack - front circle
$86:BE33             dx BD9C,84FB,BD78,04,04,2000,0000,84FC ; Shaktool's attack - middle circle
$86:BE41             dx BD9C,84FB,BD8C,04,04,2000,0000,84FC ; Shaktool's attack - back circle
}
}


;;; $BE4F..C1B7: Mother Brain's room turrets ;;;
{
;;; $BE4F: Initialisation AI - enemy projectile $C17E (Mother Brain's room turrets) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Range 0..Bh
$86:BE4F A9 00 04    LDA #$0400             ;\
$86:BE52 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:BE55 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:BE58 0A          ASL A                  ;} X = [enemy projectile initialisation parameter]
$86:BE59 AA          TAX                    ;/
$86:BE5A BD E1 BE    LDA $BEE1,x[$86:BEE1]  ;\
$86:BE5D 09 00 01    ORA #$0100             ;} Enemy projectile direction index = [$BEE1 + [X] * 2]
$86:BE60 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;} Enemy projectile direction index delta = 1
$86:BE63 DA          PHX                    ;\
$86:BE64 29 FF 00    AND #$00FF             ;|
$86:BE67 0A          ASL A                  ;|
$86:BE68 AA          TAX                    ;} Enemy projectile instruction list pointer = [$BEB9 + [enemy projectile direction index] * 2]
$86:BE69 BD B9 BE    LDA $BEB9,x[$86:BEBF]  ;|
$86:BE6C 99 47 1B    STA $1B47,y[$7E:1B69]  ;|
$86:BE6F FA          PLX                    ;/
$86:BE70 BD 89 BE    LDA $BE89,x[$86:BE89]  ;\
$86:BE73 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [$BE89 + [X] * 2]
$86:BE76 BD A1 BE    LDA $BEA1,x[$86:BEA1]  ;\
$86:BE79 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [$BEA1 + [X] * 2]
$86:BE7C BD C9 BE    LDA $BEC9,x[$86:BEC9]  ;\
$86:BE7F 99 27 1A    STA $1A27,y[$7E:1A49]  ;} Enemy projectile allowed rotations pointer = [$BEC9 + [X] * 2]
$86:BE82 BB          TYX                    ; X = [Y] (enemy projectile index)
$86:BE83 20 8E C0    JSR $C08E  [$86:C08E]  ; Set rotation timer
$86:BE86 4C A1 C0    JMP $C0A1  [$86:C0A1]  ; Go to set cooldown timer

; X positions
$86:BE89             dw 0398, 0348, 0328, 02D8, 0288, 0268, 0218, 01C8, 01A8, 0158, 0108, 00E8

; Y positions
$86:BEA1             dw 0030, 0040, 0040, 0030, 0040, 0040, 0030, 0040, 0040, 0030, 0040, 0040

; Instruction list pointers, indexed by [enemy projectile direction index]
$86:BEB9             dw C101, C107, C10D, C113, C119, C11F, C125, C12B

; Allowed rotations pointers
$86:BEC9             dw BEF9, BF01, BF09, BF11, BF19, BF21, BF29, BF31, BF39, BF41, BF49, BF51

; Direction indices
$86:BEE1             dw 0003, 0004, 0002, 0003, 0004, 0002, 0003, 0004, 0002, 0003, 0004, 0001


}


;;; $BEF9: Mother's Brain room turret allowed rotations ;;;
{
;                        ______________________ Pointing left
;                       |   ___________________ Pointing down-left
;                       |  |   ________________ Pointing down
;                       |  |  |   _____________ Pointing down-right
;                       |  |  |  |   __________ Pointing right
;                       |  |  |  |  |    _______ Pointing up-right
;                       |  |  |  |  |   |   ____ Pointing up
;                       |  |  |  |  |   |  |   _ Pointing up-left
;                       |  |  |  |  |   |  |  |
$86:BEF9             db 00,01,01,01,00, 00,00,00
$86:BF01             db 00,00,01,01,01, 00,00,00
$86:BF09             db 01,01,01,00,00, 00,00,00
$86:BF11             db 00,01,01,01,00, 00,00,00
$86:BF19             db 00,01,01,01,01, 00,00,00
$86:BF21             db 01,01,01,01,00, 00,00,00
$86:BF29             db 00,01,01,01,00, 00,00,00
$86:BF31             db 00,00,01,01,01, 00,00,00
$86:BF39             db 01,01,01,00,00, 00,00,00
$86:BF41             db 00,01,01,01,00, 00,00,00
$86:BF49             db 00,01,01,01,01, 00,00,00
$86:BF51             db 01,01,01,01,00, 00,00,00
}


;;; $BF59: Initialisation AI - enemy projectile $C18C (Mother Brain's room turret bullets) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Mother Brain's room turrets enemy projectile index
$86:BF59 A9 00 00    LDA #$0000
$86:BF5C 99 23 1B    STA $1B23,y[$7E:1B2D]
$86:BF5F A9 00 04    LDA #$0400             ;\
$86:BF62 99 BB 19    STA $19BB,y[$7E:19C5]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:BF65 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:BF68 BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;\
$86:BF6B 29 FF 00    AND #$00FF             ;|
$86:BF6E 0A          ASL A                  ;} Enemy projectile direction index = [enemy projectile [X] direction index] * 2
$86:BF6F 99 FF 1A    STA $1AFF,y[$7E:1B09]  ;/
$86:BF72 AA          TAX                    ; X = [enemy projectile direction index]
$86:BF73 BD 9F BF    LDA $BF9F,x[$86:BFA5]  ;\
$86:BF76 85 12       STA $12    [$7E:0012]  ;} $12 = [$BF9F + [X]]
$86:BF78 BD AF BF    LDA $BFAF,x[$86:BFB5]  ;\
$86:BF7B 85 14       STA $14    [$7E:0014]  ;} $14 = [$BFAF + [X]]
$86:BF7D BD BF BF    LDA $BFBF,x[$86:BFC5]  ;\
$86:BF80 99 B7 1A    STA $1AB7,y[$7E:1AC1]  ;} Enemy projectile X velocity = [$BFBF + [X]]
$86:BF83 BD CF BF    LDA $BFCF,x[$86:BFD5]  ;\
$86:BF86 99 DB 1A    STA $1ADB,y[$7E:1AE5]  ;} Enemy projectile Y velocity = [$BFCF + [X]]
$86:BF89 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:BF8C BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:BF8F 18          CLC                    ;|
$86:BF90 65 12       ADC $12    [$7E:0012]  ;} Enemy projectile X position = [enemy projectile [X] X position] + [$12]
$86:BF92 99 4B 1A    STA $1A4B,y[$7E:1A55]  ;/
$86:BF95 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:BF98 18          CLC                    ;|
$86:BF99 65 14       ADC $14    [$7E:0014]  ;} Enemy projectile Y position = [enemy projectile [X] Y position] + [$14]
$86:BF9B 99 93 1A    STA $1A93,y[$7E:1A9D]  ;/
$86:BF9E 60          RTS

;                        ______________________________________ Left
;                       |     _________________________________ Down-left
;                       |    |     ____________________________ Down
;                       |    |    |     _______________________ Down-right
;                       |    |    |    |     __________________ Right
;                       |    |    |    |    |     _____________ Up-right
;                       |    |    |    |    |    |     ________ Up
;                       |    |    |    |    |    |    |     ___ Up-left
;                       |    |    |    |    |    |    |    |
$86:BF9F             dw FFEF,FFF4,0000,000C,0011,000C,0000,FFF4 ; Position X offset
$86:BFAF             dw FFF7,0003,0007,0003,FFF7,FFED,FFEB,FFED ; Position Y offset
$86:BFBF             dw FD40,FE0E,0000,01F2,02C0,01F2,0000,FE0E ; X velocity
$86:BFCF             dw 0000,01F2,02C0,01F2,0000,FE0E,FD40,FE0E ; Y velocity
}


;;; $BFDF: Pre-instruction - enemy projectile $C17E (Mother Brain's room turrets) ;;;
{
$86:BFDF 20 B4 C0    JSR $C0B4  [$86:C0B4]  ; Check if turret is on-screen
$86:BFE2 90 07       BCC $07    [$BFEB]     ; If off-screen:
$86:BFE4 AF 3A 78 7E LDA $7E783A[$7E:783A]  ;\
$86:BFE8 D0 3A       BNE $3A    [$C024]     ;} If flagged to delete: go to BRANCH_DELETE_OFF_SCREEN
$86:BFEA 60          RTS                    ; Return

$86:BFEB AF 3A 78 7E LDA $7E783A[$7E:783A]  ;\
$86:BFEF D0 37       BNE $37    [$C028]     ;} If flagged to delete: go to BRANCH_DELETE_ON_SCREEN
$86:BFF1 DE B7 1A    DEC $1AB7,x[$7E:1AD9]  ; Decrement enemy projectile rotation timer
$86:BFF4 D0 1D       BNE $1D    [$C013]     ; If [enemy projectile rotation timer] = 0:
$86:BFF6 DA          PHX
$86:BFF7 20 8E C0    JSR $C08E  [$86:C08E]  ; Set rotation timer
$86:BFFA 20 50 C0    JSR $C050  [$86:C050]  ; Set next turret direction
$86:BFFD 7A          PLY
$86:BFFE B9 6F 1A    LDA $1A6F,y[$7E:1A8F]  ;\
$86:C001 29 FF 00    AND #$00FF             ;|
$86:C004 0A          ASL A                  ;|
$86:C005 AA          TAX                    ;} Enemy projectile instruction list pointer = [$C040 + [enemy projectile direction index] * 2]
$86:C006 BD 40 C0    LDA $C040,x[$86:C046]  ;|
$86:C009 99 47 1B    STA $1B47,y[$7E:1B67]  ;/
$86:C00C A9 01 00    LDA #$0001             ;\
$86:C00F 99 8F 1B    STA $1B8F,y[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:C012 BB          TYX

$86:C013 DE DB 1A    DEC $1ADB,x[$7E:1AFD]  ; Decrement enemy projectile cooldown timer
$86:C016 D0 0B       BNE $0B    [$C023]     ; If [enemy projectile cooldown timer] = 0:
$86:C018 20 A1 C0    JSR $C0A1  [$86:C0A1]  ; Set cooldown timer
$86:C01B A0 8C C1    LDY #$C18C             ;\
$86:C01E 8A          TXA                    ;} Spawn Mother Brain's room turret bullets enemy projectile
$86:C01F 22 97 80 86 JSL $868097[$86:8097]  ;/

$86:C023 60          RTS                    ; Return

; BRANCH_DELETE_OFF_SCREEN
$86:C024 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:C027 60          RTS                    ; Return

; BRANCH_DELETE_ON_SCREEN
$86:C028 9E 97 19    STZ $1997,x[$7E:19A7]  ; Enemy projectile ID = 0
$86:C02B BD 4B 1A    LDA $1A4B,x[$7E:1A5B]  ;\
$86:C02E 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C030 BD 93 1A    LDA $1A93,x[$7E:1AA3]  ;\
$86:C033 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C035 A9 0C 00    LDA #$000C             ; A = Ch (smoke)
$86:C038 A0 09 E5    LDY #$E509             ;\
$86:C03B 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:C03F 60          RTS

; Instruction list pointers, indexed by [enemy projectile direction index]
$86:C040             dw C101, C107, C10D, C113, C119, C11F, C125, C12B
}


;;; $C050: Set next turret direction ;;;
{
$86:C050 E2 20       SEP #$20               ;\
$86:C052 BD 6F 1A    LDA $1A6F,x[$7E:1A8F]  ;|
$86:C055 18          CLC                    ;|
$86:C056 7D 70 1A    ADC $1A70,x[$7E:1A90]  ;} $14 = ([enemy projectile direction index] + [enemy projectile direction index delta]) % 8
$86:C059 29 07       AND #$07               ;|
$86:C05B 85 14       STA $14    [$7E:0014]  ;|
$86:C05D C2 20       REP #$20               ;/
$86:C05F 29 07 00    AND #$0007             ;\
$86:C062 A8          TAY                    ;|
$86:C063 BD 27 1A    LDA $1A27,x[$7E:1A47]  ;|
$86:C066 85 12       STA $12    [$7E:0012]  ;} If [[enemy projectile allowed rotations pointer] + [$14]] != 0: (next direction is allowed)
$86:C068 B1 12       LDA ($12),y[$86:BF06]  ;|
$86:C06A 29 FF 00    AND #$00FF             ;|
$86:C06D F0 0A       BEQ $0A    [$C079]     ;/
$86:C06F E2 20       SEP #$20               ;\
$86:C071 A5 14       LDA $14    [$7E:0014]  ;|
$86:C073 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;} Enemy projectile direction index = [$14]
$86:C076 C2 20       REP #$20               ;/
$86:C078 60          RTS                    ; Return

$86:C079 E2 20       SEP #$20
$86:C07B BD 70 1A    LDA $1A70,x[$7E:1A90]  ;\
$86:C07E 49 FF       EOR #$FF               ;|
$86:C080 1A          INC A                  ;} Negate enemy projectile direction index delta
$86:C081 9D 70 1A    STA $1A70,x[$7E:1A90]  ;/
$86:C084 18          CLC                    ;\
$86:C085 7D 6F 1A    ADC $1A6F,x[$7E:1A8F]  ;} Enemy projectile direction index += [enemy projectile direction index delta]
$86:C088 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;/
$86:C08B C2 20       REP #$20
$86:C08D 60          RTS
}


;;; $C08E: Set rotation timer ;;;
{
$86:C08E 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:C092 29 FF 00    AND #$00FF             ;\
$86:C095 C9 20 00    CMP #$0020             ;|
$86:C098 10 03       BPL $03    [$C09D]     ;|
$86:C09A A9 20 00    LDA #$0020             ;} Enemy projectile rotation timer = max(20h, [random number] % 100h)
                                            ;|
$86:C09D 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;/
$86:C0A0 60          RTS
}


;;; $C0A1: Set cooldown timer ;;;
{
$86:C0A1 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:C0A5 29 FF 00    AND #$00FF             ;\
$86:C0A8 C9 80 00    CMP #$0080             ;|
$86:C0AB 10 03       BPL $03    [$C0B0]     ;|
$86:C0AD A9 80 00    LDA #$0080             ;} Enemy projectile cooldown timer = max(80h, [random number] % 100h)
                                            ;|
$86:C0B0 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:C0B3 60          RTS
}


;;; $C0B4: Check if turret is on-screen ;;;
{
;; Returns:
;;     Carry: Clear if on-screen, set otherwise
$86:C0B4 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:C0B7 30 25       BMI $25    [$C0DE]     ;} If [enemy projectile Y position] >= 0:
$86:C0B9 18          CLC                    ;\
$86:C0BA 69 10 00    ADC #$0010             ;|
$86:C0BD 38          SEC                    ;|
$86:C0BE ED 15 09    SBC $0915  [$7E:0915]  ;} If 0 <= [enemy projectile Y position] + 10h - [layer 1 Y position] < 100h
$86:C0C1 30 1B       BMI $1B    [$C0DE]     ;|
$86:C0C3 C9 00 01    CMP #$0100             ;|
$86:C0C6 10 16       BPL $16    [$C0DE]     ;/
$86:C0C8 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:C0CB 30 11       BMI $11    [$C0DE]     ;} If [enemy projectile X position] >= 0:
$86:C0CD 18          CLC                    ;\
$86:C0CE 69 04 00    ADC #$0004             ;|
$86:C0D1 38          SEC                    ;|
$86:C0D2 ED 11 09    SBC $0911  [$7E:0911]  ;} If -4 <= [enemy projectile X position] - [layer 1 X position] < 100h + 4
$86:C0D5 30 07       BMI $07    [$C0DE]     ;|
$86:C0D7 C9 08 01    CMP #$0108             ;|
$86:C0DA 10 02       BPL $02    [$C0DE]     ;/
$86:C0DC 18          CLC                    ;\
$86:C0DD 60          RTS                    ;} Return carry clear

$86:C0DE 38          SEC                    ;\
$86:C0DF 60          RTS                    ;} Return carry set
}


;;; $C0E0: Pre-instruction - enemy projectile $C18C (Mother Brain's room turret bullets) ;;;
{
$86:C0E0 BD D7 1B    LDA $1BD7,x[$7E:1BE1]  ;\
$86:C0E3 49 00 80    EOR #$8000             ;} Toggle projectile collision detection
$86:C0E6 9D D7 1B    STA $1BD7,x[$7E:1BE1]  ;/
$86:C0E9 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:C0EC BD 93 1A    LDA $1A93,x[$7E:1A9D]  ;\
$86:C0EF A8          TAY                    ;|
$86:C0F0 BD 4B 1A    LDA $1A4B,x[$7E:1A55]  ;|
$86:C0F3 AA          TAX                    ;} If collided with non-air block:
$86:C0F4 22 F9 D4 A6 JSL $A6D4F9[$A6:D4F9]  ;|
$86:C0F8 90 06       BCC $06    [$C100]     ;/
$86:C0FA AE 91 19    LDX $1991  [$7E:1991]  ;\
$86:C0FD 9E 97 19    STZ $1997,x[$7E:19A1]  ;} Enemy projectile ID = 0

$86:C100 60          RTS
}


;;; $C101..C130: Instruction lists - Mother Brain's room turrets ;;;
{
;;; $C101: Instruction list - pointing left ;;;
{
$86:C101             dx 0001,936B,
                        8159        ; Sleep
}


;;; $C107: Instruction list - pointing down-left ;;;
{
$86:C107             dx 0001,9372,
                        8159        ; Sleep
}


;;; $C10D: Instruction list - pointing down ;;;
{
$86:C10D             dx 0001,9379,
                        8159        ; Sleep
}


;;; $C113: Instruction list - pointing down-right ;;;
{
$86:C113             dx 0001,9380,
                        8159        ; Sleep
}


;;; $C119: Instruction list - pointing right ;;;
{
$86:C119             dx 0001,9387,
                        8159        ; Sleep
}


;;; $C11F: Instruction list - pointing up-right ;;;
{
$86:C11F             dx 0001,938E,
                        8159        ; Sleep
}


;;; $C125: Instruction list - pointing up ;;;
{
$86:C125             dx 0001,9395,
                        8159        ; Sleep
}


;;; $C12B: Instruction list - pointing up-left ;;;
{
$86:C12B             dx 0001,939C,
                        8159        ; Sleep
}
}


;;; $C131: Instruction list - enemy projectile $C18C (Mother Brain's room turret bullets) ;;;
{
$86:C131             dw C173,C143,C149,C14F,C155,C15B,C161,C167,C16D    ; Go to [[Y] + [enemy projectile direction index]]

; Left
$86:C143             dw 0001,93A3,
                        8159        ; Sleep

; Down-left
$86:C149             dw 0001,93AA,
                        8159        ; Sleep

; Down
$86:C14F             dw 0001,93B1,
                        8159        ; Sleep

; Down-right
$86:C155             dw 0001,93B8,
                        8159        ; Sleep

; Right
$86:C15B             dw 0001,93BF,
                        8159        ; Sleep

; Up-right
$86:C161             dw 0001,93C6,
                        8159        ; Sleep

; Up
$86:C167             dw 0001,93CD,
                        8159        ; Sleep

; Up-left
$86:C16D             dw 0001,93D4,
                        8159        ; Sleep
}


;;; $C173: Instruction - go to [[Y] + [enemy projectile direction index]] ;;;
{
$86:C173 98          TYA
$86:C174 18          CLC
$86:C175 7D FF 1A    ADC $1AFF,x[$7E:1B09]
$86:C178 A8          TAY
$86:C179 B9 00 00    LDA $0000,y[$86:C139]
$86:C17C A8          TAY
$86:C17D 60          RTS
}


;;; $C17E: Enemy projectiles - Mother Brain's room turrets ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:C17E             dx BE4F,BFDF,C10D,00,00,6000,0000,84FC ; Mother Brain's room turrets. Initial instruction list ignored
$86:C18C             dx BF59,C0E0,C131,03,03,4014,C19A,C19A ; Mother Brain's room turret bullets
}


;;; $C19A: Shot/touch instruction list - enemy projectile $C18C (Mother Brain's room turret bullets) ;;;
{
$86:C19A             dx C1B4,       ; Use palette 0
                        816A,       ; Clear pre-instruction
                        0008,B250,
                        0008,B257,
                        0008,B25E,
                        0008,B265,
                        0020,B27A,
                        8154        ; Delete
}


;;; $C1B4: Instruction - use palette 0 ;;;
{
$86:C1B4 9E BB 19    STZ $19BB,x[$7E:19C5]  ; Enemy projectile graphics indices = 0
$86:C1B7 60          RTS
}
}


;;; $C1B8: Check for bomb collision with rectangle ;;;
{
;; Parameters:
;;     $12: Rectangle centre X position
;;     $14: Rectangle centre Y position
;;     $16: Rectangle X radius
;;     $18: Rectangle Y radius
;; Returns:
;;     Carry: Set if collision, clear otherwise

; Used only by Mother Brain's bomb / bomb collision detection

$86:C1B8 AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$86:C1BB D0 02       BNE $02    [$C1BF]     ;} If [bomb counter] = 0:
$86:C1BD 18          CLC                    ;\
$86:C1BE 60          RTS                    ;} Return carry clear

$86:C1BF A0 0A 00    LDY #$000A             ; Y = Ah (projectile index)

; LOOP
$86:C1C2 B9 18 0C    LDA $0C18,y            ;\
$86:C1C5 29 00 0F    AND #$0F00             ;|
$86:C1C8 C9 00 05    CMP #$0500             ;} If projectile type is not bomb: go to BRANCH_NEXT
$86:C1CB D0 31       BNE $31    [$C1FE]     ;/
$86:C1CD B9 7C 0C    LDA $0C7C,y            ;\
$86:C1D0 D0 2C       BNE $2C    [$C1FE]     ;} If [bomb timer] != 0: go to BRANCH_NEXT
$86:C1D2 B9 64 0B    LDA $0B64,y            ;\
$86:C1D5 38          SEC                    ;|
$86:C1D6 E5 12       SBC $12    [$7E:0012]  ;|
$86:C1D8 10 04       BPL $04    [$C1DE]     ;|
$86:C1DA 49 FF FF    EOR #$FFFF             ;|
$86:C1DD 1A          INC A                  ;|
                                            ;} If |[bomb X positions] - [$12]| >= [bomb X radius] + [$16]: go to BRANCH_NEXT
$86:C1DE 38          SEC                    ;|
$86:C1DF F9 B4 0B    SBC $0BB4,y            ;|
$86:C1E2 90 04       BCC $04    [$C1E8]     ;|
$86:C1E4 C5 16       CMP $16    [$7E:0016]  ;|
$86:C1E6 B0 16       BCS $16    [$C1FE]     ;/

$86:C1E8 B9 78 0B    LDA $0B78,y            ;\
$86:C1EB 38          SEC                    ;|
$86:C1EC E5 14       SBC $14    [$7E:0014]  ;|
$86:C1EE 10 04       BPL $04    [$C1F4]     ;|
$86:C1F0 49 FF FF    EOR #$FFFF             ;|
$86:C1F3 1A          INC A                  ;|
                                            ;} If |[bomb Y positions] - [$14]| < [bomb Y radius] + [$18]: return carry set
$86:C1F4 38          SEC                    ;|
$86:C1F5 F9 C8 0B    SBC $0BC8,y            ;|
$86:C1F8 90 0D       BCC $0D    [$C207]     ;|
$86:C1FA C5 18       CMP $18    [$7E:0018]  ;|
$86:C1FC 90 09       BCC $09    [$C207]     ;/

; BRANCH_NEXT
$86:C1FE C8          INY                    ;\
$86:C1FF C8          INY                    ;} Y += 2
$86:C200 C0 14 00    CPY #$0014             ;\
$86:C203 30 BD       BMI $BD    [$C1C2]     ;} If [Y] < 14h: go to LOOP
$86:C205 18          CLC                    ;\
$86:C206 60          RTS                    ;} Return carry clear

$86:C207 38          SEC
$86:C208 60          RTS
}


;;; $C209: Check for enemy collision with rectangle ;;;
{
;; Parameters:
;;     $12: Rectangle centre X position
;;     $14: Rectangle centre Y position
;;     $16: Rectangle X radius
;;     $18: Rectangle Y radius
;; Returns:
;;     Carry: Set if collision, clear otherwise

$86:C209 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:C20C 38          SEC                    ;|
$86:C20D E5 12       SBC $12    [$7E:0012]  ;|
$86:C20F 10 04       BPL $04    [$C215]     ;|
$86:C211 49 FF FF    EOR #$FFFF             ;|
$86:C214 1A          INC A                  ;|
                                            ;} If |[enemy X position] - [$12]| >= [enemy X radius] + [$16]: return carry clear
$86:C215 38          SEC                    ;|
$86:C216 FD 82 0F    SBC $0F82,x[$7E:1002]  ;|
$86:C219 90 04       BCC $04    [$C21F]     ;|
$86:C21B C5 16       CMP $16    [$7E:0016]  ;|
$86:C21D B0 16       BCS $16    [$C235]     ;/

$86:C21F BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$86:C222 38          SEC                    ;|
$86:C223 E5 14       SBC $14    [$7E:0014]  ;|
$86:C225 10 04       BPL $04    [$C22B]     ;|
$86:C227 49 FF FF    EOR #$FFFF             ;|
$86:C22A 1A          INC A                  ;|
                                            ;} If |[enemy Y position] - [$14]| < [enemy Y radius] + [$18]: return carry set
$86:C22B 38          SEC                    ;|
$86:C22C FD 84 0F    SBC $0F84,x[$7E:1004]  ;|
$86:C22F 90 06       BCC $06    [$C237]     ;|
$86:C231 C5 18       CMP $18    [$7E:0018]  ;|
$86:C233 90 02       BCC $02    [$C237]     ;/

$86:C235 18          CLC                    ;\
$86:C236 60          RTS                    ;} Return carry clear

$86:C237 38          SEC
$86:C238 60          RTS
}


;;; $C239: Check for collision with Samus ;;;
{
; After executing $C3E9:
;     $12: Enemy projectile centre X position
;     $14: Enemy projectile centre Y position
;     $16: Enemy projectile X radius
;     $18: Enemy projectile Y radius
$86:C239 20 E9 C3    JSR $C3E9  [$86:C3E9]  ; Set up variables for enemy projectile collision detection
$86:C23C AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:C23F 38          SEC                    ;|
$86:C240 E5 12       SBC $12    [$7E:0012]  ;|
$86:C242 10 04       BPL $04    [$C248]     ;|
$86:C244 49 FF FF    EOR #$FFFF             ;|
$86:C247 1A          INC A                  ;|
                                            ;} If |[Samus X position] - [$12]| >= [Samus X radius] + [$16]: return carry clear
$86:C248 38          SEC                    ;|
$86:C249 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$86:C24C 90 04       BCC $04    [$C252]     ;|
$86:C24E C5 16       CMP $16    [$7E:0016]  ;|
$86:C250 B0 16       BCS $16    [$C268]     ;/

$86:C252 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:C255 38          SEC                    ;|
$86:C256 E5 14       SBC $14    [$7E:0014]  ;|
$86:C258 10 04       BPL $04    [$C25E]     ;|
$86:C25A 49 FF FF    EOR #$FFFF             ;|
$86:C25D 1A          INC A                  ;|
                                            ;} If |[Samus Y position] - [$14]| < [Samus Y radius] + [$18]: return carry set
$86:C25E 38          SEC                    ;|
$86:C25F ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$86:C262 90 06       BCC $06    [$C26A]     ;|
$86:C264 C5 18       CMP $18    [$7E:0018]  ;|
$86:C266 90 02       BCC $02    [$C26A]     ;/

$86:C268 18          CLC                    ;\
$86:C269 60          RTS                    ;} Return carry clear

$86:C26A 38          SEC
$86:C26B 60          RTS
}


;;; $C26C: A *= sin([$12] * pi / 80h) ;;;
{
$86:C26C 85 26       STA $26    [$7E:0026]  ; $26 = [A]
$86:C26E A5 12       LDA $12    [$7E:0012]  ; A = [$12]
$86:C270 80 08       BRA $08    [$C27A]     ; Go to A = [$26] * sin([A] * pi / 80h)
}


;;; $C272: A *= cos([$12] * pi / 80h) ;;;
{
$86:C272 85 26       STA $26    [$7E:0026]  ; $26 = [A]
$86:C274 A5 12       LDA $12    [$7E:0012]  ;\
$86:C276 18          CLC                    ;} A = [$12] + 40h
$86:C277 69 40 00    ADC #$0040             ;/
}


;;; $C27A: A = [$26] * sin([A] * pi / 80h) ;;;
{
$86:C27A 0A          ASL A                  ;\
$86:C27B 29 FE 01    AND #$01FE             ;|
$86:C27E AA          TAX                    ;} $2E = sin([A] * pi / 80h) * 100h
$86:C27F BF 43 B4 A0 LDA $A0B443,x[$A0:B46D];|
$86:C283 85 2E       STA $2E    [$7E:002E]  ;/
$86:C285 10 04       BPL $04    [$C28B]     ;\
$86:C287 49 FF FF    EOR #$FFFF             ;|
$86:C28A 1A          INC A                  ;} $28 = |[$2E]|
                                            ;|
$86:C28B 85 28       STA $28    [$7E:0028]  ;/
$86:C28D 20 9B C2    JSR $C29B  [$86:C29B]  ; $2A = [$26] * [$28]
$86:C290 A5 2B       LDA $2B    [$7E:002B]  ; A = [$2A] / 100h
$86:C292 24 2E       BIT $2E    [$7E:002E]  ;\
$86:C294 10 04       BPL $04    [$C29A]     ;} If [$2E] < 0:
$86:C296 49 FF FF    EOR #$FFFF             ;\
$86:C299 1A          INC A                  ;} Negate A

$86:C29A 6B          RTL
}


;;; $C29B: $2A = [$26] * [$28] (16-bit unsigned multiplication) ;;;
{
; Compared to $8B:85EE, this routine puts the words of the result in (the more useful) little endian order.
; Compared to $80:82D6, this routine produces correct results in all cases

; When leaving, Y.A = [$2D].[$2B]
; Let:
;     $26 = a + b * 100h
;     $28 = c + d * 100h
$86:C29B C2 20       REP #$20
$86:C29D E2 10       SEP #$10
$86:C29F A6 26       LDX $26    [$7E:0026]  ;\
$86:C2A1 8E 02 42    STX $4202  [$7E:4202]  ;|
$86:C2A4 A6 28       LDX $28    [$7E:0028]  ;|
$86:C2A6 8E 03 42    STX $4203  [$7E:4203]  ;|
$86:C2A9 EB          XBA                    ;} Result = ac
$86:C2AA EA          NOP                    ;|
$86:C2AB AD 16 42    LDA $4216  [$7E:4216]  ;|
$86:C2AE 85 2A       STA $2A    [$7E:002A]  ;/
$86:C2B0 A6 27       LDX $27    [$7E:0027]  ;\
$86:C2B2 8E 02 42    STX $4202  [$7E:4202]  ;|
$86:C2B5 A6 29       LDX $29    [$7E:0029]  ;|
$86:C2B7 8E 03 42    STX $4203  [$7E:4203]  ;|
$86:C2BA EB          XBA                    ;} Result += bd * 10000h
$86:C2BB EA          NOP                    ;|
$86:C2BC AE 16 42    LDX $4216  [$7E:4216]  ;|
$86:C2BF 86 2C       STX $2C    [$7E:002C]  ;|
$86:C2C1 AC 17 42    LDY $4217  [$7E:4217]  ;/
$86:C2C4 A6 27       LDX $27    [$7E:0027]  ;\
$86:C2C6 8E 02 42    STX $4202  [$7E:4202]  ;|
$86:C2C9 A6 28       LDX $28    [$7E:0028]  ;|
$86:C2CB 8E 03 42    STX $4203  [$7E:4203]  ;|
$86:C2CE A5 2B       LDA $2B    [$7E:002B]  ;} Result += bc * 100h
$86:C2D0 18          CLC                    ;|
$86:C2D1 6D 16 42    ADC $4216  [$7E:4216]  ;|
$86:C2D4 85 2B       STA $2B    [$7E:002B]  ;/
$86:C2D6 90 01       BCC $01    [$C2D9]     ;\
$86:C2D8 C8          INY                    ;} Propagate carry

$86:C2D9 A6 26       LDX $26    [$7E:0026]  ;\
$86:C2DB 8E 02 42    STX $4202  [$7E:4202]  ;|
$86:C2DE A6 29       LDX $29    [$7E:0029]  ;|
$86:C2E0 8E 03 42    STX $4203  [$7E:4203]  ;|
$86:C2E3 A5 2B       LDA $2B    [$7E:002B]  ;} Result += ad * 100h
$86:C2E5 18          CLC                    ;|
$86:C2E6 6D 16 42    ADC $4216  [$7E:4216]  ;|
$86:C2E9 85 2B       STA $2B    [$7E:002B]  ;/
$86:C2EB 90 01       BCC $01    [$C2EE]     ;\
$86:C2ED C8          INY                    ;} Propagate carry

$86:C2EE 84 2D       STY $2D    [$7E:002D]  ; Correct result for carries
$86:C2F0 C2 10       REP #$10
$86:C2F2 60          RTS
}


;;; $C2F3..C481: Mother Brain's blue ring lasers ;;;
{
;;; $C2F3: Initialisation AI - enemy projectile $CB4B (Mother Brain's blue ring lasers) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Angle. Anti-clockwise where 0 = down
; The initial delay is good for some marginal telegraphing, but also gives time for the next ring to spawn under the current one
$86:C2F3 BB          TYX                    ; X = [enemy projectile index]
$86:C2F4 A9 08 00    LDA #$0008             ;\
$86:C2F7 9D FF 1A    STA $1AFF,x[$7E:1B1D]  ;} Enemy projectile initial delay timer = 8
$86:C2FA 9E 23 1B    STZ $1B23,x[$7E:1B41]
$86:C2FD A9 00 04    LDA #$0400             ;\
$86:C300 9D BB 19    STA $19BB,x[$7E:19D9]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:C303 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:C306 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile initialisation parameter]
$86:C308 A9 50 04    LDA #$0450             ;\
$86:C30B DA          PHX                    ;|
$86:C30C 22 6C C2 86 JSL $86C26C[$86:C26C]  ;} Enemy projectile X velocity = 450h * sin([$12] * pi / 80h)
$86:C310 FA          PLX                    ;|
$86:C311 9D B7 1A    STA $1AB7,x[$7E:1AD5]  ;/
$86:C314 A9 50 04    LDA #$0450             ;\
$86:C317 DA          PHX                    ;|
$86:C318 22 72 C2 86 JSL $86C272[$86:C272]  ;} Enemy projectile Y velocity = 450h * cos([$12] * pi / 80h)
$86:C31C FA          PLX                    ;|
$86:C31D 9D DB 1A    STA $1ADB,x[$7E:1AF9]  ;/
}


;;; $C320: Move to blue ring spawn position ;;;
{
$86:C320 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$86:C323 18          CLC                    ;|
$86:C324 69 0A 00    ADC #$000A             ;} Enemy projectile X position = [Mother Brain's brain X position] + Ah
$86:C327 9D 4B 1A    STA $1A4B,x[$7E:1A69]  ;/
$86:C32A AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$86:C32D 18          CLC                    ;|
$86:C32E 69 10 00    ADC #$0010             ;} Enemy projectile Y position = [Mother Brain's brain Y position] + 10h
$86:C331 9D 93 1A    STA $1A93,x[$7E:1AB1]  ;/
$86:C334 60          RTS
}


;;; $C335: Pre-instruction - enemy projectile $CB4B (Mother Brain's blue ring lasers) ;;;
{
$86:C335 BD FF 1A    LDA $1AFF,x[$7E:1B1D]  ;\
$86:C338 F0 07       BEQ $07    [$C341]     ;} If [enemy projectile initial delay timer] = 0: go to BRANCH_ACTIVE
$86:C33A DE FF 1A    DEC $1AFF,x[$7E:1B1D]  ; Decrement enemy projectile initial delay timer
$86:C33D 4C 20 C3    JMP $C320  [$86:C320]  ; Go to move to blue ring spawn position

$86:C340 60          RTS

; BRANCH_ACTIVE
$86:C341 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:C344 20 A9 C3    JSR $C3A9  [$86:C3A9]  ; Check for collision with Shitroid
$86:C347 B0 38       BCS $38    [$C381]     ; If collided: go to handle blue ring collision with Shitroid
$86:C349 20 39 C2    JSR $C239  [$86:C239]  ; Check for collision with Samus
$86:C34C B0 08       BCS $08    [$C356]     ; If collided: go to handle blue ring collision with Samus
$86:C34E 20 C9 C3    JSR $C3C9  [$86:C3C9]  ; Check for blue ring collision with room
$86:C351 90 ED       BCC $ED    [$C340]     ; If no collision: return
$86:C353 4C 04 C4    JMP $C404  [$86:C404]  ; Go to handle blue ring collision with room
}


;;; $C356: Handle blue ring collision with Samus ;;;
{
$86:C356 20 10 C4    JSR $C410  [$86:C410]  ; Blue ring contact explosion
$86:C359 A9 50 00    LDA #$0050             ; A = 50h
}


;;; $C35C: Hurt Samus ;;;
{
; Jump destination for unused routine $9442
$86:C35C 22 5E A4 A0 JSL $A0A45E[$A0:A45E]  ;\
$86:C360 22 51 DF 91 JSL $91DF51[$91:DF51]  ;} Deal [A] suit-adjusted damage to Samus
$86:C364 A9 60 00    LDA #$0060             ;\
$86:C367 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 60h
$86:C36A A9 05 00    LDA #$0005             ;\
$86:C36D 8D AA 18    STA $18AA  [$7E:18AA]  ;} Samus knockback timer = 5
$86:C370 A0 00 00    LDY #$0000             ; Knockback X direction = left
$86:C373 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:C376 38          SEC                    ;|
$86:C377 FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;} If [Samus X position] >= [enemy projectile X position]:
$86:C37A 30 01       BMI $01    [$C37D]     ;/
$86:C37C C8          INY                    ; Knockback X direction = right

$86:C37D 8C 54 0A    STY $0A54  [$7E:0A54]
$86:C380 60          RTS
}


;;; $C381: Handle blue ring collision with Shitroid ;;;
{
$86:C381 AF 28 78 7E LDA $7E7828[$7E:7828]  ;\
$86:C385 1A          INC A                  ;} Set Shitroid cry to play
$86:C386 8F 28 78 7E STA $7E7828[$7E:7828]  ;/
$86:C38A 20 10 C4    JSR $C410  [$86:C410]  ; Blue ring contact explosion
$86:C38D AF 54 78 7E LDA $7E7854[$7E:7854]  ;\
$86:C391 AA          TAX                    ;} X = [Shitroid enemy index]
$86:C392 A9 10 00    LDA #$0010             ;\
$86:C395 9F 0C 78 7E STA $7E780C,x[$7E:788C];} Shitroid flash timer = 10h
$86:C399 BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$86:C39C 38          SEC                    ;|
$86:C39D E9 50 00    SBC #$0050             ;|
$86:C3A0 10 03       BPL $03    [$C3A5]     ;} Shitroid health = max(0, [Shitroid health] - 50h)
$86:C3A2 A9 00 00    LDA #$0000             ;|
                                            ;|
$86:C3A5 9D 8C 0F    STA $0F8C,x[$7E:100C]  ;/
$86:C3A8 60          RTS
}


;;; $C3A9: Check for collision with Shitroid ;;;
{
;; Returns:
;;     Carry: Set if collision, clear otherwise
$86:C3A9 18          CLC                    ; Clear carry
$86:C3AA AF 54 78 7E LDA $7E7854[$7E:7854]  ;\
$86:C3AE F0 13       BEQ $13    [$C3C3]     ;} If [Shitroid enemy index] = 0: return
$86:C3B0 A8          TAY                    ;\
$86:C3B1 B9 8C 0F    LDA $0F8C,y[$7E:100C]  ;} If [Shitroid health] = 0: go to BRANCH_DELETE
$86:C3B4 F0 0E       BEQ $0E    [$C3C4]     ;/
$86:C3B6 DA          PHX                    ;\
$86:C3B7 20 E9 C3    JSR $C3E9  [$86:C3E9]  ;|
$86:C3BA AF 54 78 7E LDA $7E7854[$7E:7854]  ;|
$86:C3BE AA          TAX                    ;} If collided with Shitroid: set carry
$86:C3BF 20 09 C2    JSR $C209  [$86:C209]  ;|
$86:C3C2 FA          PLX                    ;/

$86:C3C3 60          RTS                    ; Return

; BRANCH_DELETE
$86:C3C4 68          PLA                    ; Set to return to caller's caller
$86:C3C5 9E 97 19    STZ $1997,x[$7E:19B5]  ; Enemy projectile ID = 0
$86:C3C8 60          RTS
}


;;; $C3C9: Check for blue ring collision with room ;;;
{
;; Returns:
;;     Carry: Set if collision, clear otherwise
$86:C3C9 BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;\
$86:C3CC C9 20 00    CMP #$0020             ;|
$86:C3CF 30 16       BMI $16    [$C3E7]     ;} If 20h <= [enemy projectile Y position] < D8h:
$86:C3D1 C9 D8 00    CMP #$00D8             ;|
$86:C3D4 B0 11       BCS $11    [$C3E7]     ;/
$86:C3D6 BD 4B 1A    LDA $1A4B,x[$7E:1A69]  ;\
$86:C3D9 30 0C       BMI $0C    [$C3E7]     ;|
$86:C3DB 38          SEC                    ;|
$86:C3DC ED 11 09    SBC $0911  [$7E:0911]  ;} If 0 <= [enemy projectile X position] - [layer 1 X position] < F8h:
$86:C3DF 30 06       BMI $06    [$C3E7]     ;|
$86:C3E1 C9 F8 00    CMP #$00F8             ;|
$86:C3E4 10 01       BPL $01    [$C3E7]     ;/
$86:C3E6 60          RTS                    ; Return carry clear

$86:C3E7 38          SEC                    ;\
$86:C3E8 60          RTS                    ;} Return carry set
}


;;; $C3E9: Set up variables for enemy projectile collision detection ;;;
{
$86:C3E9 BD 4B 1A    LDA $1A4B,x[$7E:1A69]  ;\
$86:C3EC 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C3EE BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;\
$86:C3F1 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C3F3 BD B3 1B    LDA $1BB3,x[$7E:1BD1]  ;\
$86:C3F6 29 FF 00    AND #$00FF             ;} $16 = [enemy projectile X radius]
$86:C3F9 85 16       STA $16    [$7E:0016]  ;/
$86:C3FB BD B4 1B    LDA $1BB4,x[$7E:1BD2]  ;\
$86:C3FE 29 FF 00    AND #$00FF             ;} $18 = [enemy projectile Y radius]
$86:C401 85 18       STA $18    [$7E:0018]  ;/
$86:C403 60          RTS
}


;;; $C404: Handle blue ring collision with room ;;;
{
$86:C404 A9 0A 00    LDA #$000A             ;\
$86:C407 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 10
$86:C40A A9 05 00    LDA #$0005             ;\
$86:C40D 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 2 pixel displacement, diagonal
}


;;; $C410: Blue ring contact explosion ;;;
{
$86:C410 9E 97 19    STZ $1997,x[$7E:19B5]  ; Enemy projectile ID = 0
$86:C413 BD 4B 1A    LDA $1A4B,x[$7E:1A69]  ;\
$86:C416 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C418 BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;\
$86:C41B 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C41D A9 03 00    LDA #$0003             ; A = 3 (small explosion)
$86:C420 A0 09 E5    LDY #$E509             ;\
$86:C423 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:C427 A9 13 00    LDA #$0013             ;\
$86:C42A 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 13h, sound library 3, max queued sounds allowed = 6 (Mother Brain's / Torizo's projectile hits surface / Shitroid exploding)
}


;;; $C42E: Instruction - use palette 0 ;;;
{
$86:C42E 9E BB 19    STZ $19BB,x[$7E:19D9]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:C431 60          RTS
}


;;; $C432: Instruction list - enemy projectile $CB4B (Mother Brain's blue ring lasers) ;;;
{
$86:C432             dx 8298,01,01, ; X radius = 1, Y radius = 1
                        0010,8276,
                        8298,02,02, ; X radius = 2, Y radius = 2
                        000A,827D,
                        8298,03,03, ; X radius = 3, Y radius = 3
                        0008,8284,
                        8298,04,04, ; X radius = 4, Y radius = 4
                        0007,829A,
                        8298,05,05, ; X radius = 5, Y radius = 5
                        0006,82B0,
                        8298,06,06, ; X radius = 6, Y radius = 6
                        0005,82C6,
                        8159        ; Sleep
}


;;; $C464: Hit instruction list - enemy projectile $CB4B (Mother Brain's blue ring lasers) ;;;
{
$86:C464             dx C42E,       ; Use palette 0
                        816A,       ; Clear pre-instruction
                        0005,B406,
                        0005,B41C,
                        0005,B432,
                        0005,B448,
                        0005,B486,
                        0005,B4B0,
                        8154        ; Delete
}
}


;;; $C482..C604: Mother Brain's bomb ;;;
{
;;; $C482: Initialisation AI - enemy projectile $CB59 (Mother Brain's bomb) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Number of afterburn enemy projectiles
$86:C482 E2 20       SEP #$20               ;\
$86:C484 AD 93 19    LDA $1993  [$7E:1993]  ;|
$86:C487 99 27 1A    STA $1A27,y[$7E:1A47]  ;} Enemy projectile number of afterburn enemy projectiles = [enemy projectile initialisation parameter]
$86:C48A C2 20       REP #$20               ;/
$86:C48C A9 00 01    LDA #$0100             ;\
$86:C48F 99 DB 1A    STA $1ADB,y[$7E:1AFB]  ;} Enemy projectile Y velocity = 100h
$86:C492 A9 E0 00    LDA #$00E0             ;\
$86:C495 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile X velocity = E0h
$86:C498 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$86:C49B 18          CLC                    ;|
$86:C49C 69 0C 00    ADC #$000C             ;} Enemy projectile X position = [Mother Brain's brain X position] + Ch
$86:C49F 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:C4A2 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$86:C4A5 18          CLC                    ;|
$86:C4A6 69 10 00    ADC #$0010             ;} Enemy projectile Y position = [Mother Brain's brain Y position] + 10h
$86:C4A9 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:C4AC A9 00 04    LDA #$0400             ;\
$86:C4AF 99 BB 19    STA $19BB,y[$7E:19DB]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:C4B2 A9 70 00    LDA #$0070             ;\
$86:C4B5 99 FF 1A    STA $1AFF,y[$7E:1B1F]  ;} Enemy projectile post-bounce X speed = 70h
$86:C4B8 A9 00 00    LDA #$0000             ;\
$86:C4BB 99 23 1B    STA $1B23,y[$7E:1B43]  ;} Enemy projectile bounce counter = 0
$86:C4BE AF 4A 78 7E LDA $7E784A[$7E:784A]  ;\
$86:C4C2 1A          INC A                  ;} Increment Mother Brain bomb counter
$86:C4C3 8F 4A 78 7E STA $7E784A[$7E:784A]  ;/
$86:C4C7 60          RTS
}


;;; $C4C8: Pre-instruction - enemy projectile $CB59 (Mother Brain's bomb) ;;;
{
$86:C4C8 20 64 C5    JSR $C564  [$86:C564]  ; Mother Brain's bomb / bomb collision detection
$86:C4CB BD 23 1B    LDA $1B23,x[$7E:1B43]  ;\
$86:C4CE D0 2D       BNE $2D    [$C4FD]     ;} If [enemy projectile bounce counter] != 0: go to BRANCH_HAVE_BOUNCED
$86:C4D0 BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;\
$86:C4D3 10 04       BPL $04    [$C4D9]     ;|
$86:C4D5 49 FF FF    EOR #$FFFF             ;|
$86:C4D8 1A          INC A                  ;|
                                            ;|
$86:C4D9 38          SEC                    ;|
$86:C4DA E9 02 00    SBC #$0002             ;|
$86:C4DD 10 03       BPL $03    [$C4E2]     ;|
$86:C4DF A9 00 00    LDA #$0000             ;} Enemy projectile X velocity = max(0, |[enemy projectile X velocity]| - 2) * sgn([enemy projectile X velocity])
                                            ;|
$86:C4E2 3C B7 1A    BIT $1AB7,x[$7E:1AD7]  ;|
$86:C4E5 10 04       BPL $04    [$C4EB]     ;|
$86:C4E7 49 FF FF    EOR #$FFFF             ;|
$86:C4EA 1A          INC A                  ;|
                                            ;|
$86:C4EB 9D B7 1A    STA $1AB7,x[$7E:1AD7]  ;/
$86:C4EE A9 07 00    LDA #$0007             ; A = 7
$86:C4F1 20 C2 C5    JSR $C5C2  [$86:C5C2]  ; Move Mother Brain's bomb
$86:C4F4 90 06       BCC $06    [$C4FC]     ; If didn't bounce: return

; BRANCH_BOUNCED
$86:C4F6 FE 23 1B    INC $1B23,x[$7E:1B43]  ;\
$86:C4F9 FE 23 1B    INC $1B23,x[$7E:1B43]  ;} Enemy projectile bounce counter += 2

$86:C4FC 60          RTS                    ; Return

; BRANCH_HAVE_BOUNCED
$86:C4FD BC 23 1B    LDY $1B23,x[$7E:1B43]  ;\
$86:C500 B9 50 C5    LDA $C550,y[$86:C552]  ;} A = [$C550 + [enemy projectile bounce counter]]
$86:C503 F0 06       BEQ $06    [$C50B]     ; If [A] != 0:
$86:C505 20 C2 C5    JSR $C5C2  [$86:C5C2]  ; Move Mother Brain's bomb
$86:C508 B0 EC       BCS $EC    [$C4F6]     ; If bounced: go to BRANCH_BOUNCED
$86:C50A 60          RTS                    ; Return

$86:C50B 9E B7 1A    STZ $1AB7,x[$7E:1AD7]  ; Enemy projectile X velocity = 0
$86:C50E 9E DB 1A    STZ $1ADB,x[$7E:1AFB]  ; Enemy projectile Y velocity = 0
$86:C511 AF 4A 78 7E LDA $7E784A[$7E:784A]  ;\
$86:C515 3A          DEC A                  ;} Decrement Mother Brain bomb counter
$86:C516 8F 4A 78 7E STA $7E784A[$7E:784A]  ;/
$86:C51A 9E 97 19    STZ $1997,x[$7E:19B7]  ; Enemy projectile ID = 0
$86:C51D BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:C520 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C522 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:C525 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C527 BD 27 1A    LDA $1A27,x[$7E:1A47]  ;\
$86:C52A 29 FF 00    AND #$00FF             ;} A = [enemy projectile number of afterburn enemy projectiles]
$86:C52D A0 50 96    LDY #$9650             ;\
$86:C530 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn horizontal afterburn - centre enemy projectile
$86:C534 BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:C537 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C539 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:C53C 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C53E A9 03 00    LDA #$0003             ; A = 3 (small explosion)
$86:C541 A0 09 E5    LDY #$E509             ;\
$86:C544 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:C548 A9 13 00    LDA #$0013             ;\
$86:C54B 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 13h, sound library 3, max queued sounds allowed = 6 (Mother Brain's / Torizo's projectile hits surface / Shitroid exploding)
$86:C54F 60          RTS

; Y accelerations (1/100h px/frame^2), indexed by bounce counter
$86:C550             dw 0007, 0010, 0020, 0040, 0070, 00B0, 00F0, 0130, 0170, 0000
}


;;; $C564: Mother Brain's bomb / bomb collision detection ;;;
{
$86:C564 BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:C567 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C569 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:C56C 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C56E BD B3 1B    LDA $1BB3,x[$7E:1BD3]  ;\
$86:C571 29 FF 00    AND #$00FF             ;} $16 = [enemy projectile X radius]
$86:C574 85 16       STA $16    [$7E:0016]  ;/
$86:C576 BD B3 1B    LDA $1BB3,x[$7E:1BD3]  ;\
$86:C579 EB          XBA                    ;|
$86:C57A 29 FF 00    AND #$00FF             ;} $18 = [enemy projectile Y radius]
$86:C57D 85 18       STA $18    [$7E:0018]  ;/
$86:C57F 20 B8 C1    JSR $C1B8  [$86:C1B8]  ; Check for bomb collision with rectangle
$86:C582 B0 01       BCS $01    [$C585]     ; If no collision:
$86:C584 60          RTS                    ; Return

$86:C585 68          PLA                    ; Set to return to caller's caller
$86:C586 AF 4A 78 7E LDA $7E784A[$7E:784A]  ;\
$86:C58A 3A          DEC A                  ;} Decrement Mother Brain bomb counter
$86:C58B 8F 4A 78 7E STA $7E784A[$7E:784A]  ;/
$86:C58F 9E B7 1A    STZ $1AB7,x            ; Enemy projectile X velocity = 0
$86:C592 9E DB 1A    STZ $1ADB,x            ; Enemy projectile Y velocity = 0
$86:C595 9E 97 19    STZ $1997,x            ; Enemy projectile ID = 0
$86:C598 BD 4B 1A    LDA $1A4B,x            ;\
$86:C59B 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C59D BD 93 1A    LDA $1A93,x            ;\
$86:C5A0 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C5A2 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$86:C5A5 A0 09 E5    LDY #$E509             ;\
$86:C5A8 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:C5AC BD 4B 1A    LDA $1A4B,x            ;\
$86:C5AF 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C5B1 BD 93 1A    LDA $1A93,x            ;\
$86:C5B4 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C5B6 A9 3F EC    LDA #$EC3F             ;\
$86:C5B9 DA          PHX                    ;|
$86:C5BA 5A          PHY                    ;|
$86:C5BB 22 0E 92 A0 JSL $A0920E[$A0:920E]  ;} Spawn Mother Brain's brain enemy drops (100% nothing...)
$86:C5BF 7A          PLY                    ;|
$86:C5C0 FA          PLX                    ;/
$86:C5C1 60          RTS
}


;;; $C5C2: Move Mother Brain's bomb ;;;
{
;; Parameters:
;;     A: Y acceleration as 1/100h px/frame^2
;; Returns:
;;     Carry: Set if bounced, otherwise clear
$86:C5C2 18          CLC                    ;\
$86:C5C3 7D DB 1A    ADC $1ADB,x[$7E:1AFB]  ;} Enemy projectile Y velocity += [A]
$86:C5C6 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;/
$86:C5C9 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:C5CC BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:C5CF C9 F0 00    CMP #$00F0             ;} If [enemy projectile X position] >= F0h:
$86:C5D2 30 0A       BMI $0A    [$C5DE]     ;/
$86:C5D4 BD B7 1A    LDA $1AB7,x            ;\
$86:C5D7 49 FF FF    EOR #$FFFF             ;|
$86:C5DA 1A          INC A                  ;} Negate enemy projectile X velocity
$86:C5DB 9D B7 1A    STA $1AB7,x            ;/

$86:C5DE BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;\
$86:C5E1 C9 D0 00    CMP #$00D0             ;} If [enemy projectile Y position] < D0h: return carry clear
$86:C5E4 30 1D       BMI $1D    [$C603]     ;/
$86:C5E6 A9 D0 00    LDA #$00D0             ;\
$86:C5E9 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;} Enemy projectile Y position = D0h
$86:C5EC BD FF 1A    LDA $1AFF,x[$7E:1B1F]  ;\
$86:C5EF 3C B7 1A    BIT $1AB7,x[$7E:1AD7]  ;|
$86:C5F2 10 04       BPL $04    [$C5F8]     ;|
$86:C5F4 49 FF FF    EOR #$FFFF             ;} Enemy projectile X velocity = [enemy projectile post-bounce X speed] * sgn([enemy projectile X velocity])
$86:C5F7 1A          INC A                  ;|
                                            ;|
$86:C5F8 9D B7 1A    STA $1AB7,x[$7E:1AD7]  ;/
$86:C5FB A9 00 FE    LDA #$FE00             ;\
$86:C5FE 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;} Enemy projectile Y velocity = -200h
$86:C601 38          SEC                    ;\
$86:C602 60          RTS                    ;} Return carry set

$86:C603 18          CLC
$86:C604 60          RTS
}
}


;;; $C605..C76D: Mother Brain's death beam ;;;
{
;;; $C605: Initialisation AI - enemy projectile $CB67 (Mother Brain's death beam - charging) ;;;
{
$86:C605 A9 00 00    LDA #$0000
$86:C608 99 FF 1A    STA $1AFF,y[$7E:1B0F]
$86:C60B 99 23 1B    STA $1B23,y[$7E:1B33]
$86:C60E 99 B7 1A    STA $1AB7,y[$7E:1AC7]
$86:C611 99 DB 1A    STA $1ADB,y[$7E:1AEB]
$86:C614 99 27 1A    STA $1A27,y[$7E:1A37]
$86:C617 99 6F 1A    STA $1A6F,y[$7E:1A7F]
$86:C61A 8F 06 80 7E STA $7E8006[$7E:8006]  ; Mother Brain's death beam next X subposition = 0
$86:C61E 8F 0A 80 7E STA $7E800A[$7E:800A]  ; Mother Brain's death beam next Y subposition = 0
$86:C622 A9 00 04    LDA #$0400             ;\
$86:C625 99 BB 19    STA $19BB,y[$7E:19CB]  ;} Enemy projectile VRAM graphics index = 0, palette 2
$86:C628 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:C62B 18          CLC                    ;|
$86:C62C 69 40 00    ADC #$0040             ;} Enemy projectile X position = [Mother Brain's body X position] + 40h
$86:C62F 99 4B 1A    STA $1A4B,y[$7E:1A5B]  ;/
$86:C632 8F 08 80 7E STA $7E8008[$7E:8008]  ; Mother Brain's death beam next X position = [enemy projectile X position]
$86:C636 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:C639 38          SEC                    ;|
$86:C63A EF 08 80 7E SBC $7E8008[$7E:8008]  ;} $12 = [Samus X position] - [enemy projectile X position]
$86:C63E 85 12       STA $12    [$7E:0012]  ;/
$86:C640 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:C643 18          CLC                    ;|
$86:C644 69 D0 FF    ADC #$FFD0             ;} Enemy projectile Y position = [Mother Brain's body Y position] - 30h
$86:C647 99 93 1A    STA $1A93,y[$7E:1AA3]  ;/
$86:C64A 8F 0C 80 7E STA $7E800C[$7E:800C]  ; Mother Brain's death beam next Y position = [enemy projectile Y position]
$86:C64E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:C651 38          SEC                    ;|
$86:C652 EF 0C 80 7E SBC $7E800C[$7E:800C]  ;} $14 = [Samus Y position] - [enemy projectile Y position]
$86:C656 85 14       STA $14    [$7E:0014]  ;/
$86:C658 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ; A = angle of ([$12], [$14]) offset
$86:C65C 38          SEC                    ;\
$86:C65D E9 80 00    SBC #$0080             ;|
$86:C660 49 FF FF    EOR #$FFFF             ;} A = 80h - [A] (Y flip of angle)
$86:C663 1A          INC A                  ;/
$86:C664 29 FF 00    AND #$00FF             ;\
$86:C667 85 12       STA $12    [$7E:0012]  ;} $12 = Mother Brain's death beam next angle = [A]
$86:C669 8F 12 80 7E STA $7E8012[$7E:8012]  ;/
$86:C66D A9 00 0C    LDA #$0C00             ;\
$86:C670 22 6C C2 86 JSL $86C26C[$86:C26C]  ;} Mother Brain's death beam next X velocity = C00h * sin([$12] * pi / 80h)
$86:C674 8F 0E 80 7E STA $7E800E[$7E:800E]  ;/
$86:C678 A9 00 0C    LDA #$0C00             ;\
$86:C67B 22 72 C2 86 JSL $86C272[$86:C272]  ;} Mother Brain's death beam next Y velocity = C00h * cos([$12] * pi / 80h)
$86:C67F 8F 10 80 7E STA $7E8010[$7E:8010]  ;/
$86:C683 60          RTS
}


;;; $C684: Initialisation AI - enemy projectile $CB75 (Mother Brain's death beam - fired) ;;;
{
$86:C684 AF 08 80 7E LDA $7E8008[$7E:8008]  ;\
$86:C688 99 4B 1A    STA $1A4B,y[$7E:1A59]  ;} Enemy projectile X position = [Mother Brain's death beam next X position]
$86:C68B AF 06 80 7E LDA $7E8006[$7E:8006]  ;\
$86:C68F 99 27 1A    STA $1A27,y[$7E:1A35]  ;} Enemy projectile X subposition = [Mother Brain's death beam next X subposition]
$86:C692 AF 0C 80 7E LDA $7E800C[$7E:800C]  ;\
$86:C696 99 93 1A    STA $1A93,y[$7E:1AA1]  ;} Enemy projectile Y position = [Mother Brain's death beam next Y position]
$86:C699 AF 0A 80 7E LDA $7E800A[$7E:800A]  ;\
$86:C69D 99 6F 1A    STA $1A6F,y[$7E:1A7D]  ;} Enemy projectile Y subposition = [Mother Brain's death beam next Y subposition]
$86:C6A0 AF 0E 80 7E LDA $7E800E[$7E:800E]  ;\
$86:C6A4 99 B7 1A    STA $1AB7,y[$7E:1AC5]  ;} Enemy projectile X velocity = [Mother Brain's death beam next X velocity]
$86:C6A7 AF 10 80 7E LDA $7E8010[$7E:8010]  ;\
$86:C6AB 99 DB 1A    STA $1ADB,y[$7E:1AE9]  ;} Enemy projectile Y velocity = [Mother Brain's death beam next Y velocity]
$86:C6AE BB          TYX
$86:C6AF 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:C6B2 BD 4B 1A    LDA $1A4B,x[$7E:1A59]  ;\
$86:C6B5 8F 08 80 7E STA $7E8008[$7E:8008]  ;} Mother Brain's death beam next X position = [enemy projectile X position]
$86:C6B9 BD 27 1A    LDA $1A27,x[$7E:1A35]  ;\
$86:C6BC 8F 06 80 7E STA $7E8006[$7E:8006]  ;} Mother Brain's death beam next X subposition = [enemy projectile X subposition]
$86:C6C0 BD 93 1A    LDA $1A93,x[$7E:1AA1]  ;\
$86:C6C3 8F 0C 80 7E STA $7E800C[$7E:800C]  ;} Mother Brain's death beam next Y position = [enemy projectile Y position]
$86:C6C7 BD 6F 1A    LDA $1A6F,x[$7E:1A7D]  ;\
$86:C6CA 8F 0A 80 7E STA $7E800A[$7E:800A]  ;} Mother Brain's death beam next Y subposition = [enemy projectile Y subposition]
$86:C6CE 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:C6D2 29 FF 00    AND #$00FF             ;\
$86:C6D5 18          CLC                    ;|
$86:C6D6 6F 12 80 7E ADC $7E8012[$7E:8012]  ;} $12 = [Mother Brain's death beam next angle] + [random number] % 100h
$86:C6DA 29 FF 00    AND #$00FF             ;|
$86:C6DD 85 12       STA $12    [$7E:0012]  ;/
$86:C6DF 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:C6E3 29 00 07    AND #$0700             ;\
$86:C6E6 DA          PHX                    ;|
$86:C6E7 22 6C C2 86 JSL $86C26C[$86:C26C]  ;} Enemy projectile X velocity = ([random number] & 700h) * sin([$12] * pi / 80h)
$86:C6EB FA          PLX                    ;|
$86:C6EC 9D B7 1A    STA $1AB7,x[$7E:1AC5]  ;/
$86:C6EF AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:C6F2 29 00 07    AND #$0700             ;|
$86:C6F5 DA          PHX                    ;|
$86:C6F6 22 72 C2 86 JSL $86C272[$86:C272]  ;} Enemy projectile Y velocity = ([random number] & 700h) * cos([$12] * pi / 80h)
$86:C6FA FA          PLX                    ;|
$86:C6FB 9D DB 1A    STA $1ADB,x[$7E:1AE9]  ;/
$86:C6FE 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:C701 BD 93 1A    LDA $1A93,x[$7E:1AA1]  ;\
$86:C704 C9 22 00    CMP #$0022             ;|
$86:C707 30 29       BMI $29    [$C732]     ;} If 22h <= [enemy projectile Y position] < CEh:
$86:C709 C9 CE 00    CMP #$00CE             ;|
$86:C70C 10 24       BPL $24    [$C732]     ;/
$86:C70E BD 4B 1A    LDA $1A4B,x[$7E:1A59]  ;\
$86:C711 C9 02 00    CMP #$0002             ;|
$86:C714 30 1C       BMI $1C    [$C732]     ;} If 2 <= [enemy projectile X position] < EEh:
$86:C716 C9 EE 00    CMP #$00EE             ;|
$86:C719 10 17       BPL $17    [$C732]     ;/
$86:C71B BD FF 1A    LDA $1AFF,x[$7E:1B0D]  ;\
$86:C71E 1A          INC A                  ;|
$86:C71F 29 03 00    AND #$0003             ;} Enemy projectile $1AFF = ([enemy projectile $1AFF] + 1) % 4 (never read)
$86:C722 9D FF 1A    STA $1AFF,x[$7E:1B0D]  ;/
$86:C725 A9 00 00    LDA #$0000
$86:C728 9D 23 1B    STA $1B23,x[$7E:1B31]
$86:C72B 9D B7 1A    STA $1AB7,x[$7E:1AC5]  ; Enemy projectile X velocity = 0
$86:C72E 9D DB 1A    STA $1ADB,x[$7E:1AE9]  ; Enemy projectile Y velocity = 0
$86:C731 60          RTS                    ; Return

$86:C732 9E 97 19    STZ $1997,x[$7E:199D]  ; Enemy projectile ID = 0
$86:C735 BD 4B 1A    LDA $1A4B,x[$7E:1A51]  ;\
$86:C738 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:C73A BD 93 1A    LDA $1A93,x[$7E:1A99]  ;\
$86:C73D 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:C73F A0 09 E5    LDY #$E509
$86:C742 A9 1D 00    LDA #$001D             ; A = 1Dh (big explosion)
$86:C745 22 97 80 86 JSL $868097[$86:8097]  ; Spawn dust cloud / explosion enemy projectile
$86:C749 A9 13 00    LDA #$0013             ;\
$86:C74C 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 13h, sound library 3, max queued sounds allowed = 6 (Mother Brain's / Torizo's projectile hits surface / Shitroid exploding)
$86:C750 A9 0A 00    LDA #$000A             ;\
$86:C753 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 10
$86:C756 A9 05 00    LDA #$0005             ;\
$86:C759 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 2 pixel displacement, diagonal
$86:C75C 60          RTS

; Unused. Guessing that [enemy projectile $1AFF] was used to index this table at one point
$86:C75D             dw 0002,FFFE, 0002,FFFE, FFFE,0002, FFFE,0002
}


;;; $C76D: RTS. Pre-instruction - enemy projectile $CB67/$CB75 (Mother Brain's death beam) ;;;
{
$86:C76D 60          RTS
}
}


;;; $C76E: Instruction list - enemy projectile $CB59 (Mother Brain's bomb) ;;;
{
$86:C76E             dw 0006,82DC,
                        0005,82E8,
                        0004,82F4,
                        0003,8300,
                        0002,830C,
                        0002,8318,
                        0003,8324,
                        0004,8330,
                        0005,833C,
                        81AB,C76E   ; Go to $C76E
}


;;; $C796: Instruction list - enemy projectile $CB67/$CB75 (Mother Brain's death beam) ;;;
{
$86:C796             dx 0003,835D,
                        8171,86C7FB,    ; Call function spawn Mother Brain's death beam - fired enemy projectile
                        0003,8364,
                        0002,836B,
                        0002,8372,
                        0001,8379,
                        0001,8380,
                        0001,8387,
                        0003,835D,
                        8171,86C7FB,    ; Call function spawn Mother Brain's death beam - fired enemy projectile
                        0003,8364,
                        0002,836B,
                        0002,8372,
                        0001,8379,
                        0001,8380,
                        0001,8387,
                        0003,835D,
                        8171,86C7FB,    ; Call function spawn Mother Brain's death beam - fired enemy projectile
                        0003,8364,
                        0002,836B,
                        0002,8372,
                        0001,8379,
                        0001,8380,
                        0001,8387,
                        8154            ; Delete
}


;;; $C7FB: Spawn Mother Brain's death beam - fired enemy projectile ;;;
{
$86:C7FB DA          PHX
$86:C7FC 5A          PHY
$86:C7FD BD FF 1A    LDA $1AFF,x[$7E:1B0F]  ; A = [enemy projectile $1AFF] (ignored)
$86:C800 A0 75 CB    LDY #$CB75             ;\
$86:C803 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's death beam - fired enemy projectile
$86:C807 7A          PLY
$86:C808 FA          PLX
$86:C809 6B          RTL
}


;;; $C80A..42: Mother Brain's rainbow beam charging ;;;
{
;;; $C80A: Initialisation AI - enemy projectile $CB83 (Mother Brain's rainbow beam charging) ;;;
{
$86:C80A BB          TYX
$86:C80B 9E BB 19    STZ $19BB,x[$7E:19DB]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:C80E 9E B7 1A    STZ $1AB7,x[$7E:1AD7]
$86:C811 9E DB 1A    STZ $1ADB,x[$7E:1AFB]
}


;;; $C814: Pre-instruction - enemy projectile $CB83 (Mother Brain's rainbow beam charging) ;;;
{
$86:C814 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$86:C817 18          CLC                    ;|
$86:C818 69 00 00    ADC #$0000             ;} Enemy projectile X position = [Mother Brain's brain X position]
$86:C81B 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:C81E AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$86:C821 18          CLC                    ;|
$86:C822 69 00 00    ADC #$0000             ;} Enemy projectile Y position = [Mother Brain's brain Y position]
$86:C825 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:C828 60          RTS
}


;;; $C829: Instruction list - enemy projectile $CB83 (Mother Brain's rainbow beam charging) ;;;
{
$86:C829             dx 0005,94B7,
                        0005,9483,
                        0005,945E,
                        0005,9439,
                        0005,9414,
                        0005,93DB,
                        8154        ; Delete
}
}


;;; $C843..F4: Mother Brain's drool ;;;
{
;;; $C843: Initialisation AI - enemy projectile $CB91/$CB9F (Mother Brain's drool) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Attached position offset index. Range 0..5 (see $C86E)
$86:C843 BB          TYX
$86:C844 9E BB 19    STZ $19BB,x[$7E:19DD]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:C847 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:C84A 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile attached position offset index = [enemy projectile initialisation parameter]
}


;;; $C84D: Pre-instruction - Mother Brain's drool - attached to Mother Brain ;;;
{
$86:C84D BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:C850 0A          ASL A                  ;|
$86:C851 0A          ASL A                  ;} Y = [enemy projectile attached position offset index] * 4
$86:C852 A8          TAY                    ;/
$86:C853 B9 6E C8    LDA $C86E,y[$86:C872]  ;\
$86:C856 18          CLC                    ;|
$86:C857 6D BA 0F    ADC $0FBA  [$7E:0FBA]  ;} Enemy projectile X position = [Mother Brain's brain X position] + [$C86E + [Y]]
$86:C85A 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:C85D B9 70 C8    LDA $C870,y[$86:C874]  ;\
$86:C860 18          CLC                    ;|
$86:C861 6D BE 0F    ADC $0FBE  [$7E:0FBE]  ;} Enemy projectile Y position = [Mother Brain's brain Y position] + [$C86E + [Y] + 2]
$86:C864 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:C867 9E B7 1A    STZ $1AB7,x[$7E:1AD9]
$86:C86A 9E DB 1A    STZ $1ADB,x[$7E:1AFD]  ; Enemy projectile Y velocity = 0
$86:C86D 60          RTS

; X/Y position offsets
$86:C86E             dw 0006,0014,
                        000E,0012,
                        0008,0017,
                        000A,0013,
                        000B,0019,
                        000C,0012
}


;;; $C886: Pre-instruction - Mother Brain's drool - falling ;;;
{
$86:C886 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:C889 18          CLC                    ;|
$86:C88A 69 0C 00    ADC #$000C             ;} Enemy projectile Y velocity += Ch
$86:C88D 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:C890 20 F3 92    JSR $92F3  [$86:92F3]  ; Move enemy projectile according to enemy projectile Y velocity
$86:C893 C9 D7 00    CMP #$00D7             ;\
$86:C896 B0 01       BCS $01    [$C899]     ;} If [enemy projectile Y position] < D7h:
$86:C898 60          RTS                    ; Return

$86:C899 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:C89C 18          CLC                    ;|
$86:C89D 69 FC FF    ADC #$FFFC             ;} Enemy projectile Y position -= 4
$86:C8A0 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:C8A3 A9 E1 C8    LDA #$C8E1             ;\
$86:C8A6 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $C8E1 (hit floor)
$86:C8A9 A9 01 00    LDA #$0001             ;\
$86:C8AC 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:C8AF 60          RTS
}


;;; $C8B0: Instruction list - enemy projectile $CB91/$CB9F (Mother Brain's drool) ;;;
{
$86:C8B0             dx 000A,94FF,
                        000A,9506,
                        000A,9530,
                        000A,9537,
                        000A,9543,
                        8161,C886,  ; Pre-instruction = $C886
                        C8D0,       ; Move down Ch pixels
                        000A,950D,
                        8159        ; Sleep
}


;;; $C8D0: Instruction - move down Ch pixels ;;;
{
$86:C8D0 BD 93 1A    LDA $1A93,x[$7E:1AB5]
$86:C8D3 18          CLC
$86:C8D4 69 0C 00    ADC #$000C
$86:C8D7 9D 93 1A    STA $1A93,x[$7E:1AB5]
$86:C8DA 60          RTS
}


;;; $C8DB: Unused. Instruction list ;;;
{
$86:C8DB             dx 000A,950D,
                        8159        ; Sleep
}


;;; $C8E1: Instruction list - Mother Brain's drool - hit floor ;;;
{
$86:C8E1             dx 816A,       ; Clear pre-instruction
                        000A,9514,
                        000A,951B,
                        000A,9522,
                        000A,9529,
                        8154        ; Delete
}
}


;;; $C8F5..C92E: Mother Brain's death explosion ;;;
{
;;; $C8F5: Initialisation AI - enemy projectile $CB13 (Mother Brain's death explosion) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Explosion type
;;         0: Small explosion
;;         1: Smoke
;;         2: Big explosion
$86:C8F5 BB          TYX                    ; X = [enemy projectile index]
$86:C8F6 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:C8F9 0A          ASL A                  ;|
$86:C8FA A8          TAY                    ;} Enemy projectile instruction list pointer = [$C929 + [enemy projectile initialisation parameter] * 2]
$86:C8FB B9 29 C9    LDA $C929,y[$86:C92B]  ;|
$86:C8FE 9D 47 1B    STA $1B47,x[$7E:1B63]  ;/
$86:C901 A9 01 00    LDA #$0001             ;\
$86:C904 9D 8F 1B    STA $1B8F,x[$7E:1BAB]  ;} Enemy projectile instruction timer = 1
$86:C907 9E BB 19    STZ $19BB,x[$7E:19D7]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:C90A A5 12       LDA $12    [$7E:0012]  ;\
$86:C90C 9D B7 1A    STA $1AB7,x[$7E:1AD3]  ;} Enemy projectile X offset = [$12]
$86:C90F A5 14       LDA $14    [$7E:0014]  ;\
$86:C911 9D DB 1A    STA $1ADB,x[$7E:1AF7]  ;} Enemy projectile Y offset = [$14]
}


;;; $C914: Pre-instruction - enemy projectile $CB13 (Mother Brain's death explosion) ;;;
{
$86:C914 BD B7 1A    LDA $1AB7,x[$7E:1AD3]  ;\
$86:C917 18          CLC                    ;|
$86:C918 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} Enemy projectile X position = [Mother Brain's body X position] + [enemy projectile X offset]
$86:C91B 9D 4B 1A    STA $1A4B,x[$7E:1A67]  ;/
$86:C91E BD DB 1A    LDA $1ADB,x[$7E:1AF7]  ;\
$86:C921 18          CLC                    ;|
$86:C922 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;} Enemy projectile Y position = [Mother Brain's body Y position] + [enemy projectile Y offset]
$86:C925 9D 93 1A    STA $1A93,x[$7E:1AAF]  ;/
$86:C928 60          RTS
}


;;; $C929: Mother Brain's death explosion instruction list pointers ;;;
{
$86:C929             dw E138, ; Small explosion
                        E1EA, ; Smoke
                        E208  ; Big explosion
}
}


;;; $C92F..60: Mother Brain's rainbow beam explosion ;;;
{
;;; $C92F: Initialisation AI - enemy projectile $CBAD (Mother Brain's rainbow beam explosion) ;;;
{
$86:C92F BB          TYX
$86:C930 9E BB 19    STZ $19BB,x[$7E:19DB]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:C933 A5 12       LDA $12    [$7E:0012]  ;\
$86:C935 9D B7 1A    STA $1AB7,x[$7E:1AD7]  ;} Enemy projectile X offset = [$12]
$86:C938 18          CLC                    ;\
$86:C939 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Enemy projectile X position = [Samus X position] + [enemy projectile X offset]
$86:C93C 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:C93F A5 14       LDA $14    [$7E:0014]  ;\
$86:C941 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;} Enemy projectile Y offset = [$14]
$86:C944 18          CLC                    ;\
$86:C945 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Enemy projectile Y position = [Samus Y position] + [enemy projectile Y offset]
$86:C948 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:C94B 60          RTS
}


;;; $C94C: Pre-instruction - enemy projectile $CBAD (Mother Brain's rainbow beam explosion) ;;;
{
$86:C94C BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;\
$86:C94F 18          CLC                    ;|
$86:C950 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Enemy projectile X position = [Samus X position] + [enemy projectile X offset]
$86:C953 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:C956 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;\
$86:C959 18          CLC                    ;|
$86:C95A 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Enemy projectile Y position = [Samus Y position] + [enemy projectile Y offset]
$86:C95D 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:C960 60          RTS
}
}


;;; $C961..CA69: Mother Brain's exploded escape door particles ;;;
{
;;; $C961: Initialisation AI - enemy projectile $CB21 (Mother Brain's exploded escape door particles) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Range 0..7. Determines Y offset and Y velocity
$86:C961 BB          TYX
$86:C962 9E BB 19    STZ $19BB,x[$7E:19D1]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:C965 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:C968 0A          ASL A                  ;|
$86:C969 0A          ASL A                  ;} Y = [enemy projectile initialisation parameter] * 4
$86:C96A A8          TAY                    ;/
$86:C96B B9 92 C9    LDA $C992,y[$86:C992]  ;\
$86:C96E 18          CLC                    ;|
$86:C96F 69 10 00    ADC #$0010             ;} Enemy projectile X position = 10h
$86:C972 9D 4B 1A    STA $1A4B,x[$7E:1A61]  ;/
$86:C975 B9 94 C9    LDA $C994,y[$86:C994]  ;\
$86:C978 18          CLC                    ;|
$86:C979 69 80 00    ADC #$0080             ;} Enemy projectile Y position = 80h + [$C992 + [Y] + 2]
$86:C97C 9D 93 1A    STA $1A93,x[$7E:1AA9]  ;/
$86:C97F B9 B2 C9    LDA $C9B2,y[$86:C9B2]  ;\
$86:C982 9D B7 1A    STA $1AB7,x[$7E:1ACD]  ;} Enemy projectile X velocity = 500h
$86:C985 B9 B4 C9    LDA $C9B4,y[$86:C9B4]  ;\
$86:C988 9D DB 1A    STA $1ADB,x[$7E:1AF1]  ;} Enemy projectile Y velocity = [$C9B2 + [Y] + 2]
$86:C98B A9 20 00    LDA #$0020             ;\
$86:C98E 9D FF 1A    STA $1AFF,x[$7E:1B15]  ;} Enemy projectile delete timer = 20h
$86:C991 60          RTS

; X/Y offsets
$86:C992             dw 0000,FFE0, 0000,FFE8, 0000,FFF0, 0000,FFF8, 0000,0000, 0000,0008, 0000,0010, 0000,0018

; X/Y velocities
$86:C9B2             dw 0500,FE00, 0500,FF00, 0500,FF00, 0500,FF80, 0500,FF80, 0500,0080, 0500,FF00, 0500,0200
}


;;; $C9D2: Pre-instruction - enemy projectile $CB21 (Mother Brain's exploded escape door particles) ;;;
{
$86:C9D2 BD B7 1A    LDA $1AB7,x[$7E:1ACD]  ;\
$86:C9D5 10 04       BPL $04    [$C9DB]     ;|
$86:C9D7 49 FF FF    EOR #$FFFF             ;|
$86:C9DA 1A          INC A                  ;|
                                            ;|
$86:C9DB 38          SEC                    ;|
$86:C9DC E9 10 00    SBC #$0010             ;|
$86:C9DF 10 03       BPL $03    [$C9E4]     ;|
$86:C9E1 A9 00 00    LDA #$0000             ;} Enemy projectile X velocity = max(0, |[enemy projectile X velocity]| - 10h) * sgn([enemy projectile X velocity])
                                            ;|
$86:C9E4 3C B7 1A    BIT $1AB7,x[$7E:1ACD]  ;|
$86:C9E7 10 04       BPL $04    [$C9ED]     ;|
$86:C9E9 49 FF FF    EOR #$FFFF             ;|
$86:C9EC 1A          INC A                  ;|
                                            ;|
$86:C9ED 9D B7 1A    STA $1AB7,x[$7E:1ACD]  ;/
$86:C9F0 BD DB 1A    LDA $1ADB,x[$7E:1AF1]  ;\
$86:C9F3 18          CLC                    ;|
$86:C9F4 69 20 00    ADC #$0020             ;} Enemy projectile Y velocity += 20h
$86:C9F7 9D DB 1A    STA $1ADB,x[$7E:1AF1]  ;/
$86:C9FA 20 D6 92    JSR $92D6  [$86:92D6]  ; Move enemy projectile according to enemy projectile velocity
$86:C9FD DE FF 1A    DEC $1AFF,x[$7E:1B15]  ; Decrement enemy projectile delete timer
$86:CA00 30 01       BMI $01    [$CA03]     ; If [enemy projectile delete timer] >= 0:
$86:CA02 60          RTS                    ; Return

$86:CA03 9E 97 19    STZ $1997,x[$7E:19AD]  ; Enemy projectile ID = 0
$86:CA06 BD 93 1A    LDA $1A93,x[$7E:1AA9]  ;\
$86:CA09 18          CLC                    ;|
$86:CA0A 69 FC FF    ADC #$FFFC             ;} Enemy projectile Y position -= 4
$86:CA0D 9D 93 1A    STA $1A93,x[$7E:1AA9]  ;/
$86:CA10 85 14       STA $14    [$7E:0014]  ; $14 = [enemy projectile Y position]
$86:CA12 BD 4B 1A    LDA $1A4B,x[$7E:1A61]  ;\
$86:CA15 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:CA17 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$86:CA1A A0 09 E5    LDY #$E509             ;\
$86:CA1D 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:CA21 60          RTS
}


;;; $CA22: Instruction list - enemy projectile $CB21 (Mother Brain's exploded escape door particles) ;;;
{
$86:CA22             dx 0001,969B,
                        0001,96A2,
                        0001,96A9,
                        0001,96B0,
                        0003,96B7,
                        0003,96BE,
                        0004,96C5,
                        0004,96CC,
                        81AB,CA22   ; Go to $CA22
}


;;; $CA46: Unused. Instruction list ;;;
{
$86:CA46             dx 0001,96D3,
                        0001,96DA,
                        0001,96E1,
                        0001,96E8,
                        0003,96EF,
                        0003,96F6,
                        0004,96FD,
                        0004,9704,
                        81AB,CA46   ; Go to $CA46
}
}


;;; $CA6A..F5: Mother Brain's purple breath ;;;
{
;;; $CA6A: Initialisation AI - enemy projectile $CB2F (Mother Brain's purple breath - big) ;;;
{
$86:CA6A BB          TYX
$86:CA6B 9E BB 19    STZ $19BB,x[$7E:19DB]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:CA6E AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$86:CA71 18          CLC                    ;|
$86:CA72 69 06 00    ADC #$0006             ;} Enemy projectile X position = [Mother Brain's brain X position] + 6
$86:CA75 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:CA78 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$86:CA7B 18          CLC                    ;|
$86:CA7C 69 10 00    ADC #$0010             ;} Enemy projectile Y position = [Mother Brain's brain Y position] + 10h
$86:CA7F 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:CA82 60          RTS
}


;;; $CA83: Initialisation AI - enemy projectile $CB3D (Mother Brain's purple breath - small) ;;;
{
$86:CA83 BB          TYX
$86:CA84 9E BB 19    STZ $19BB,x[$7E:19DD]  ; Enemy projectile VRAM graphics index = 0, palette 0
$86:CA87 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$86:CA8A 18          CLC                    ;|
$86:CA8B 69 06 00    ADC #$0006             ;} Enemy projectile X position = [Mother Brain's brain X position] + 6
$86:CA8E 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:CA91 AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$86:CA94 18          CLC                    ;|
$86:CA95 69 10 00    ADC #$0010             ;} Enemy projectile Y position = [Mother Brain's brain Y position] + 10h
$86:CA98 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:CA9B A9 01 00    LDA #$0001             ;\
$86:CA9E 8F 6A 78 7E STA $7E786A[$7E:786A]  ;} Mother Brain's small purple breath is active flag = 1
$86:CAA2 60          RTS
}


;;; $CAA3: RTS. Pre-instruction - enemy projectile $CB2F/$CB3D (Mother Brain's purple breath) ;;;
{
$86:CAA3 60          RTS
}


;;; $CAA4: Instruction list - enemy projectile $CB2F (Mother Brain's purple breath - big) ;;;
{
$86:CAA4             dx 816A,       ; Clear pre-instruction
                        0008,954F,
                        0008,955B,
                        0009,9571,
                        0009,9596,
                        000A,95C0,
                        000A,95E5,
                        000B,9605,
                        000B,961B,
                        8154        ; Delete
}


;;; $CAC8: Instruction list - enemy projectile $CB3D (Mother Brain's purple breath - small) ;;;
{
$86:CAC8             dx 816A,       ; Clear pre-instruction
                        0008,9627,
                        0008,962E,
                        000A,963A,
                        000A,9650,
                        000B,9666,
                        000B,9677,
                        000C,9688,
                        000C,9694,
                        CAEE,       ; Mother Brain's small purple breath is active flag = 0
                        8154        ; Delete
}


;;; $CAEE: Instruction - Mother Brain's small purple breath is active flag = 0 ;;;
{
$86:CAEE A9 00 00    LDA #$0000
$86:CAF1 8F 6A 78 7E STA $7E786A[$7E:786A]
$86:CAF5 60          RTS
}
}


;;; $CAF6..CB12: Enemy projectile $CBBB (time bomb set Japanese text) ;;;
{
;;; $CAF6: Initialisation AI - enemy projectile $CBBB (time bomb set Japanese text) ;;;
{
$86:CAF6 BB          TYX
$86:CAF7 9E BB 19    STZ $19BB,x            ; Enemy projectile VRAM graphics index = 0, palette 0
}


;;; $CAFA: Pre-instruction - enemy projectile $CBBB (time bomb set Japanese text) ;;;
{
$86:CAFA 9E B7 1A    STZ $1AB7,x
$86:CAFD 9E DB 1A    STZ $1ADB,x
$86:CB00 A9 80 00    LDA #$0080     ;\
$86:CB03 9D 4B 1A    STA $1A4B,x    ;} Enemy projectile X position = 80h
$86:CB06 A9 C0 00    LDA #$00C0     ;\
$86:CB09 9D 93 1A    STA $1A93,x    ;} Enemy projectile Y position = C0h
$86:CB0C 60          RTS
}


;;; $CB0D: Instruction list - enemy projectile $CBBB (time bomb set Japanese text) ;;;
{
$86:CB0D             dx 0001,970B,
                        8159        ; Sleep
}
}


;;; $CB13: Enemy projectiles - Mother Brain ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:CB13             dx C8F5,C914,0000,00,00,2000,0000,84FC ; Mother Brain's death explosion. Initial instruction list ignored
$86:CB21             dx C961,C9D2,CA22,00,00,3000,0000,84FC ; Mother Brain's exploded escape door particles
$86:CB2F             dx CA6A,CAA3,CAA4,00,00,3000,0000,84FC ; Mother Brain's purple breath - big
$86:CB3D             dx CA83,CAA3,CAC8,00,00,3000,0000,84FC ; Mother Brain's purple breath - small
$86:CB4B             dx C2F3,C335,C432,06,06,3050,C464,84FC ; Mother Brain's blue ring lasers
$86:CB59             dx C482,C4C8,C76E,06,06,40A0,0000,84FC ; Mother Brain's bomb
$86:CB67             dx C605,C76D,C796,06,06,1190,0000,84FC ; Mother Brain's death beam - charging
$86:CB75             dx C684,C76D,C796,06,06,1190,0000,84FC ; Mother Brain's death beam - fired
$86:CB83             dx C80A,C814,C829,00,00,7000,0000,84FC ; Mother Brain's rainbow beam charging
$86:CB91             dx C843,C84D,C8B0,00,00,7000,0000,84FC ; Mother Brain's drool
$86:CB9F             dx C843,C84D,C8B0,00,00,7000,0000,84FC ; Mother Brain's dying drool
$86:CBAD             dx C92F,C94C,E152,01,01,7000,0000,84FC ; Mother Brain's rainbow beam explosion
$86:CBBB             dx CAF6,CAFA,CB0D,00,00,1000,0000,84FC ; Time bomb set Japanese text
}


;;; $CBC9..CC92: Mother Brain's tube falling ;;;
{
;;; $CBC9: Initialisation AI - enemy projectile $CC5B/$CC69/$CC77/$CC85 (Mother Brain's tube falling) ;;;
{
$86:CBC9 BB          TYX
$86:CBCA A9 00 0E    LDA #$0E00             ;\
$86:CBCD 9D BB 19    STA $19BB,x[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 7
$86:CBD0 9E B7 1A    STZ $1AB7,x[$7E:1AD9]
$86:CBD3 9E DB 1A    STZ $1ADB,x[$7E:1AFD]  ; Enemy projectile Y velocity = 0
$86:CBD6 A5 12       LDA $12    [$7E:0012]  ;\
$86:CBD8 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [$12]
$86:CBDB A5 14       LDA $14    [$7E:0014]  ;\
$86:CBDD 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;} Enemy projectile Y position = [$14]
$86:CBE0 A9 EA CB    LDA #$CBEA             ;\
$86:CBE3 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile function = $CBEA (generate explosion)
$86:CBE6 60          RTS
}


;;; $CBE7: Pre-instruction - enemy projectile $CC5B/$CC69/$CC77/$CC85 (Mother Brain's tube falling) ;;;
{
$86:CBE7 7C FF 1A    JMP ($1AFF,x)[$86:CBEA]; Go to [enemy projectile function]
}


;;; $CBEA: Mother Brain's tube falling function - generate explosion ;;;
{
$86:CBEA BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:CBED 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:CBEF BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:CBF2 18          CLC                    ;|
$86:CBF3 69 08 00    ADC #$0008             ;} $14 = [enemy projectile Y position] + 8
$86:CBF6 85 14       STA $14    [$7E:0014]  ;/
$86:CBF8 A9 09 00    LDA #$0009             ; A = 9 (small dust cloud)
$86:CBFB A0 09 E5    LDY #$E509             ;\
$86:CBFE 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$86:CC02 A9 08 CC    LDA #$CC08             ;\
$86:CC05 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile function = $CC08 (falling)
}


;;; $CC08: Mother Brain's tube falling function - falling ;;;
{
$86:CC08 C2 21       REP #$21               ;\
$86:CC0A BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;|
$86:CC0D 69 06 00    ADC #$0006             ;} Enemy projectile Y velocity += 6
$86:CC10 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:CC13 20 F3 92    JSR $92F3  [$86:92F3]  ; Move enemy projectile according to enemy projectile Y velocity
$86:CC16 C9 D0 00    CMP #$00D0             ;\
$86:CC19 30 17       BMI $17    [$CC32]     ;} If [enemy projectile Y position] < D0h: return
$86:CC1B 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0
$86:CC1E BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:CC21 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:CC23 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:CC26 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:CC28 A9 0C 00    LDA #$000C             ; A = Ch (smoke)
$86:CC2B A0 09 E5    LDY #$E509             ;\
$86:CC2E 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile

$86:CC32 60          RTS
}


;;; $CC33: Unused ;;;
{
$86:CC33             dw FF00,0100, 0100,0000, FF00,FF00, 0100,0000
}


;;; $CC43: Instruction list - enemy projectile $CC5B (Mother Brain's top-right tube falling) ;;;
{
$86:CC43             dx 0001,838E,
                        8159        ; Sleep
}


;;; $CC49: Instruction list - enemy projectile $CC69 (Mother Brain's top-left tube falling) ;;;
{
$86:CC49             dx 0001,83A4,
                        8159        ; Sleep
}


;;; $CC4F: Instruction list - enemy projectile $CC77 (Mother Brain's top-middle-left tube falling) ;;;
{
$86:CC4F             dx 0001,83BA,
                        8159        ; Sleep
}


;;; $CC55: Instruction list - enemy projectile $CC85 (Mother Brain's top-middle-right tube falling) ;;;
{
$86:CC55             dx 0001,83DF,
                        8159        ; Sleep
}


;;; $CC5B: Enemy projectiles - Mother Brain's top tube falling ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:CC5B             dx CBC9,CBE7,CC43,08,10,5000,0000,84FC ; Mother Brain's top-right tube falling
$86:CC69             dx CBC9,CBE7,CC49,08,10,5000,0000,84FC ; Mother Brain's top-left tube falling
$86:CC77             dx CBC9,CBE7,CC4F,08,18,5000,0000,84FC ; Mother Brain's top-middle-left tube falling
$86:CC85             dx CBC9,CBE7,CC55,08,18,5000,0000,84FC ; Mother Brain's top-middle-right tube falling
}
}


;;; $CC93..CF17: Mother Brain's glass shattering ;;;
{
;;; $CC93..CDB2: Instruction lists - Mother Brain's glass shattering - shard ;;;
{
;;; $CC93: Instruction list - Mother Brain's glass shattering 0 ;;;
{
$86:CC93             dx 0004,9749,
                        0003,9750,
                        0002,9757,
                        0003,975E,
                        0004,9765,
                        0003,976C,
                        0002,9773,
                        0003,977A,
                        81AB,CC93   ; Go to $CC93
}


;;; $CCB7: Instruction list - Mother Brain's glass shattering 1/2 ;;;
{
$86:CCB7             dx 0004,97B9,
                        0003,97C0,
                        0002,97C7,
                        0003,97CE,
                        0004,97D5,
                        0003,97DC,
                        0002,97E3,
                        0003,97EA,
                        81AB,CCB7   ; Go to $CCB7
}


;;; $CCDB: Instruction list - Mother Brain's glass shattering 3..5 ;;;
{
$86:CCDB             dx 0004,9781,
                        0003,9788,
                        0002,978F,
                        0003,9796,
                        0004,979D,
                        0003,97A4,
                        0002,97AB,
                        0003,97B2,
                        81AB,CCDB   ; Go to $CCDB
}


;;; $CCFF: Instruction list - Mother Brain's glass shattering 6/7 ;;;
{
$86:CCFF             dx 0004,97F1,
                        0003,97F8,
                        0002,97FF,
                        0003,9806,
                        0004,980D,
                        0003,9814,
                        0002,981B,
                        0003,9822,
                        81AB,CCFF   ; Go to $CCFF
}


;;; $CD23: Instruction list - Mother Brain's glass shattering 8 ;;;
{
$86:CD23             dx 0004,9829,
                        0003,9830,
                        0002,9837,
                        0003,983E,
                        0004,9845,
                        0003,984C,
                        0002,9853,
                        0003,985A,
                        81AB,CD23   ; Go to $CD23
}


;;; $CD47: Instruction list - Mother Brain's glass shattering 9/Ah ;;;
{
$86:CD47             dx 0004,9899,
                        0003,98A0,
                        0002,98A7,
                        0003,98AE,
                        0004,98B5,
                        0003,98BC,
                        0002,98C3,
                        0003,98CA,
                        81AB,CD47   ; Go to $CD47
}


;;; $CD6B: Instruction list - Mother Brain's glass shattering Bh..Dh ;;;
{
$86:CD6B             dx 0004,9861,
                        0003,9868,
                        0002,986F,
                        0003,9876,
                        0004,987D,
                        0003,9884,
                        0002,988B,
                        0003,9892,
                        81AB,CD6B   ; Go to $CD6B
}


;;; $CD8F: Instruction list - Mother Brain's glass shattering Eh/Fh ;;;
{
$86:CD8F             dx 0004,98D1,
                        0003,98D8,
                        0002,98DF,
                        0003,98E6,
                        0004,98ED,
                        0003,98F4,
                        0002,98FB,
                        0003,9902,
                        81AB,CD8F   ; Go to $CD8F
}
}


;;; $CDB3: Instruction list - enemy projectile $CF0A (Mother Brain's glass shattering - sparkle) ;;;
{
$86:CDB3             dx 0006,9909,
                        0008,9910,
                        0006,9917,
                        0008,991E,
                        8154        ; Delete
}


;;; $CDC5: Initialisation AI - enemy projectile $CEFC (Mother Brain's glass shattering - shard) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X offset index
;;         0: 8
;;         2: -28h
;;         4: -10h
$86:CDC5 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:CDC9 0A          ASL A                  ;\
$86:CDCA 29 FE 01    AND #$01FE             ;|
$86:CDCD 99 FF 1A    STA $1AFF,y[$7E:1B09]  ;} X = enemy projectile angle = [random number] % 100h * 2
$86:CDD0 AA          TAX                    ;/
$86:CDD1 BF 43 B4 A0 LDA $A0B443,x[$A0:B4E9];\
$86:CDD5 99 B7 1A    STA $1AB7,y[$7E:1AC1]  ;} Enemy projectile X velocity = sin([X] / 2 * pi / 80h)
$86:CDD8 BF C3 B3 A0 LDA $A0B3C3,x[$A0:B469];\
$86:CDDC 0A          ASL A                  ;|
$86:CDDD 0A          ASL A                  ;} Enemy projectile Y velocity = -4 * cos([X] / 2 * pi / 80h)
$86:CDDE 99 DB 1A    STA $1ADB,y[$7E:1AE5]  ;/
$86:CDE1 8A          TXA                    ;\
$86:CDE2 4A          LSR A                  ;|
$86:CDE3 4A          LSR A                  ;|
$86:CDE4 4A          LSR A                  ;|
$86:CDE5 4A          LSR A                  ;} Enemy projectile instruction list pointer = [$CE41 + [X] / 20h * 2]
$86:CDE6 29 1E 00    AND #$001E             ;|
$86:CDE9 AA          TAX                    ;|
$86:CDEA BD 41 CE    LDA $CE41,x[$86:CE4B]  ;|
$86:CDED 99 47 1B    STA $1B47,y[$7E:1B51]  ;/
$86:CDF0 A9 40 06    LDA #$0640             ;\
$86:CDF3 99 BB 19    STA $19BB,y[$7E:19C5]  ;} Enemy projectile VRAM graphics index = 40h, palette 3
$86:CDF6 AE 27 1C    LDX $1C27  [$7E:1C27]  ; X = [PLM index]
$86:CDF9 22 90 82 84 JSL $848290[$84:8290]  ; Calculate PLM block co-ordinates
$86:CDFD AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:CE00 AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:CE03 0A          ASL A                  ;|
$86:CE04 0A          ASL A                  ;|
$86:CE05 0A          ASL A                  ;|
$86:CE06 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h + [$CE61 + [X]]
$86:CE07 18          CLC                    ;|
$86:CE08 7D 61 CE    ADC $CE61,x[$86:CE61]  ;|
$86:CE0B 99 4B 1A    STA $1A4B,y[$7E:1A55]  ;/
$86:CE0E AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:CE11 0A          ASL A                  ;|
$86:CE12 0A          ASL A                  ;|
$86:CE13 0A          ASL A                  ;|
$86:CE14 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h + 20h
$86:CE15 18          CLC                    ;|
$86:CE16 7D 67 CE    ADC $CE67,x[$86:CE67]  ;|
$86:CE19 99 93 1A    STA $1A93,y[$7E:1A9D]  ;/
$86:CE1C 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:CE20 29 0F 00    AND #$000F             ;\
$86:CE23 38          SEC                    ;|
$86:CE24 E9 08 00    SBC #$0008             ;|
$86:CE27 18          CLC                    ;} Enemy projectile X position += [random number] % 10h - 8
$86:CE28 79 4B 1A    ADC $1A4B,y[$7E:1A55]  ;|
$86:CE2B 99 4B 1A    STA $1A4B,y[$7E:1A55]  ;/
$86:CE2E 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:CE32 29 0F 00    AND #$000F             ;\
$86:CE35 38          SEC                    ;|
$86:CE36 E9 08 00    SBC #$0008             ;|
$86:CE39 18          CLC                    ;} Enemy projectile Y position += [random number] % 10h - 8
$86:CE3A 79 93 1A    ADC $1A93,y[$7E:1A9D]  ;|
$86:CE3D 99 93 1A    STA $1A93,y[$7E:1A9D]  ;/
$86:CE40 60          RTS

; Instruction list pointers
$86:CE41             dw CC93, CCB7, CCB7, CCDB, CCDB, CCDB, CCFF, CCFF, CD23, CD47, CD47, CD6B, CD6B, CD6B, CD8F, CD8F

; X offsets. Indexed by initialisation parameter
$86:CE61             dw 0008, FFD8, FFF0

; Y offsets. Indexed by initialisation parameter
$86:CE67             dw 0020, 0020, 0020
}


;;; $CE6D: Initialisation AI - enemy projectile $CF0A (Mother Brain's glass shattering - sparkle) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Shard enemy projectile index
$86:CE6D AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:CE70 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:CE74 29 1F 00    AND #$001F             ;\
$86:CE77 38          SEC                    ;|
$86:CE78 E9 10 00    SBC #$0010             ;|
$86:CE7B 18          CLC                    ;} Enemy projectile X position = [enemy projectile [X] X position] + [random number] % 20h - 10h
$86:CE7C 7D 4B 1A    ADC $1A4B,x[$7E:1A55]  ;|
$86:CE7F 99 4B 1A    STA $1A4B,y[$7E:1A4D]  ;/
$86:CE82 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:CE86 29 1F 00    AND #$001F             ;\
$86:CE89 38          SEC                    ;|
$86:CE8A E9 10 00    SBC #$0010             ;|
$86:CE8D 18          CLC                    ;} Enemy projectile Y position = [enemy projectile [X] Y position] + [random number] % 20h - 10h
$86:CE8E 7D 93 1A    ADC $1A93,x[$7E:1A9D]  ;|
$86:CE91 99 93 1A    STA $1A93,y[$7E:1A95]  ;/
$86:CE94 A9 40 06    LDA #$0640             ;\
$86:CE97 99 BB 19    STA $19BB,y[$7E:19BD]  ;} Enemy projectile VRAM graphics index = 40h, palette 3
$86:CE9A 60          RTS
}


;;; $CE9B: Pre-instruction - enemy projectile $CEFC (Mother Brain's glass shattering - shard) ;;;
{
$86:CE9B 64 12       STZ $12    [$7E:0012]  ;\
$86:CE9D 64 14       STZ $14    [$7E:0014]  ;|
$86:CE9F BD B7 1A    LDA $1AB7,x[$7E:1AC1]  ;|
$86:CEA2 10 02       BPL $02    [$CEA6]     ;|
$86:CEA4 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:CEA6 85 13       STA $13    [$7E:0013]  ;|
$86:CEA8 BD 27 1A    LDA $1A27,x[$7E:1A31]  ;} Enemy projectile X position += [enemy projectile X velocity] / 100.0h
$86:CEAB 18          CLC                    ;|
$86:CEAC 65 12       ADC $12    [$7E:0012]  ;|
$86:CEAE 9D 27 1A    STA $1A27,x[$7E:1A31]  ;|
$86:CEB1 BD 4B 1A    LDA $1A4B,x[$7E:1A55]  ;|
$86:CEB4 65 14       ADC $14    [$7E:0014]  ;|
$86:CEB6 9D 4B 1A    STA $1A4B,x[$7E:1A55]  ;/
$86:CEB9 64 12       STZ $12    [$7E:0012]  ;\
$86:CEBB 64 14       STZ $14    [$7E:0014]  ;|
$86:CEBD BD DB 1A    LDA $1ADB,x[$7E:1AE5]  ;|
$86:CEC0 10 02       BPL $02    [$CEC4]     ;|
$86:CEC2 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:CEC4 85 13       STA $13    [$7E:0013]  ;|
$86:CEC6 BD 6F 1A    LDA $1A6F,x[$7E:1A79]  ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100.0h
$86:CEC9 18          CLC                    ;|
$86:CECA 65 12       ADC $12    [$7E:0012]  ;|
$86:CECC 9D 6F 1A    STA $1A6F,x[$7E:1A79]  ;|
$86:CECF BD 93 1A    LDA $1A93,x[$7E:1A9D]  ;|
$86:CED2 65 14       ADC $14    [$7E:0014]  ;|
$86:CED4 9D 93 1A    STA $1A93,x[$7E:1A9D]  ;/
$86:CED7 29 00 FF    AND #$FF00             ;\
$86:CEDA D0 1C       BNE $1C    [$CEF8]     ;} If not 0 <= [enemy projectile Y position] < 100h: go to BRANCH_DELETE
$86:CEDC BD DB 1A    LDA $1ADB,x[$7E:1AE5]  ;\
$86:CEDF 18          CLC                    ;|
$86:CEE0 69 20 00    ADC #$0020             ;} Enemy projectile Y velocity += 20h
$86:CEE3 9D DB 1A    STA $1ADB,x[$7E:1AE5]  ;/
$86:CEE6 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:CEEA 29 20 04    AND #$0420             ;\
$86:CEED D0 08       BNE $08    [$CEF7]     ;} If [random number] & 420h = 0:
$86:CEEF 8A          TXA                    ; A = [enemy projectile index]
$86:CEF0 A0 0A CF    LDY #$CF0A             ;\
$86:CEF3 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn Mother Brain's glass shattering - sparkle enemy projectile

$86:CEF7 60          RTS                    ; Return

; BRANCH_DELETE
$86:CEF8 9E 97 19    STZ $1997,x[$7E:199F]  ; Enemy projectile ID = 0
$86:CEFB 60          RTS
}


;;; $CEFC: Enemy projectiles - Mother Brain's glass shattering ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:CEFC             dx CDC5,CE9B,CC93,00,00,3000,0000,84FC ; Mother Brain's glass shattering - shard. Initial instruction list ignored
$86:CF0A             dx CE6D,84FB,CDB3,00,00,3000,0000,84FC ; Mother Brain's glass shattering - sparkle
}
}


;;; $CF18..D02D: Ki hunter acid spit ;;;
{
;;; $CF18: Enemy projectiles - ki hunter acid spit ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:CF18             dx CF90,CFF7,CF34,02,08,0014,0000,84FC ; Ki hunter acid spit - left
$86:CF26             dx CFA6,CFF7,CF6E,02,08,0014,0000,84FC ; Ki hunter acid spit - right
}


;;; $CF34: Instruction list - enemy projectile $CF18 (ki hunter acid spit - left) ;;;
{
$86:CF34             dx 0003,9925,
                        0003,992C,
                        0004,9938,
                        0003,993F,
                        0001,994B,
                        8161,CFD5,  ; Pre-instruction = $CFD5 (start moving)
                        0001,994B,
                        0001,9957,
                        8159        ; Sleep
}


;;; $CF56: Instruction list - ki hunter acid spit - hit floor ;;;
{
$86:CF56             dx 816A,       ; Clear pre-instruction
                        000C,995E,
                        000A,9965,
                        000A,9976,
                        0008,998C,
                        0008,99A2,
                        8154        ; Delete
}


;;; $CF6E: Instruction list - enemy projectile $CF26 (ki hunter acid spit - right) ;;;
{
$86:CF6E             dx 0003,99AE,
                        0003,99B5,
                        0004,99C1,
                        0003,99C8,
                        0001,99D4,
                        8161,CFE6,  ; Pre-instruction = $CFE6 (start moving)
                        0001,99D4,
                        0001,99E0,
                        8159        ; Sleep
}


;;; $CF90: Initialisation AI - enemy projectile $CF18 (ki hunter acid spit - left) ;;;
{
$86:CF90 DA          PHX
$86:CF91 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:CF94 A9 00 FD    LDA #$FD00             ;\
$86:CF97 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile X velocity = -300h
$86:CF9A BD 7A 0F    LDA $0F7A,x[$7E:11FA]  ;\
$86:CF9D 38          SEC                    ;|
$86:CF9E E9 16 00    SBC #$0016             ;} Enemy projectile X position = [enemy X position] - 16h
$86:CFA1 99 4B 1A    STA $1A4B,y[$7E:1A6B]  ;/
$86:CFA4 80 14       BRA $14    [$CFBA]     ; Go to ki hunter acid spit common initialisation
}


;;; $CFA6: Initialisation AI - enemy projectile $CF26 (ki hunter acid spit - right) ;;;
{
$86:CFA6 DA          PHX
$86:CFA7 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:CFAA A9 00 03    LDA #$0300             ;\
$86:CFAD 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile X velocity = 300h
$86:CFB0 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:CFB3 18          CLC                    ;|
$86:CFB4 69 16 00    ADC #$0016             ;} Enemy projectile X position = [enemy X position] + 16h
$86:CFB7 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
}


;;; $CFBA: Ki hunter acid spit common initialisation ;;;
{
; Expects a pushed X
$86:CFBA A9 00 00    LDA #$0000             ;\
$86:CFBD 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = 0
$86:CFC0 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:CFC3 38          SEC                    ;|
$86:CFC4 E9 10 00    SBC #$0010             ;} Enemy projectile Y position = [enemy Y position] - 10h
$86:CFC7 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:CFCA A9 00 00    LDA #$0000             ;\
$86:CFCD 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;} Enemy projectile Y subposition = 0
$86:CFD0 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile X subposition = 0
$86:CFD3 FA          PLX
$86:CFD4 60          RTS
}


;;; $CFD5: Pre-instruction - ki hunter acid spit - left - start moving ;;;
{
$86:CFD5 A9 F8 CF    LDA #$CFF8             ;\
$86:CFD8 9D 03 1A    STA $1A03,x[$7E:1A23]  ;} Enemy projectile pre-instruction = $CFF8 (moving)
$86:CFDB BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;\
$86:CFDE 38          SEC                    ;|
$86:CFDF E9 13 00    SBC #$0013             ;} Enemy projectile X position -= 13h
$86:CFE2 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:CFE5 60          RTS
}


;;; $CFE6: Pre-instruction - ki hunter acid spit - right - start moving ;;;
{
$86:CFE6 A9 F8 CF    LDA #$CFF8             ;\
$86:CFE9 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $CFF8 (moving)
$86:CFEC BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:CFEF 18          CLC                    ;|
$86:CFF0 69 13 00    ADC #$0013             ;} Enemy projectile X position += 13h
$86:CFF3 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:CFF6 60          RTS
}


;;; $CFF7: RTS. Pre-instruction - enemy projectile $CF18/$CF26 (ki hunter acid spit) ;;;
{
$86:CFF7 60          RTS
}


;;; $CFF8: Pre-instruction - ki hunter acid spit - moving ;;;
{
$86:CFF8 C2 30       REP #$30
$86:CFFA 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:CFFD B0 1B       BCS $1B    [$D01A]     ; If collision detected: go to BRANCH_HIT_FLOOR
$86:CFFF 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:D002 B0 23       BCS $23    [$D027]     ; If collision: go to BRANCH_HIT_WALL
$86:D004 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:D007 18          CLC                    ;|
$86:D008 69 10 00    ADC #$0010             ;|
$86:D00B 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;|
$86:D00E C9 00 02    CMP #$0200             ;} Enemy projectile Y velocity = min(200h, [enemy projectile Y velocity] + 10h)
$86:D011 30 03       BMI $03    [$D016]     ;|
$86:D013 A9 00 02    LDA #$0200             ;|
                                            ;|
$86:D016 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:D019 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:D01A A9 56 CF    LDA #$CF56             ;\
$86:D01D 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $CF56 (hit floor)
$86:D020 A9 01 00    LDA #$0001             ;\
$86:D023 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:D026 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:D027 A9 00 00    LDA #$0000             ;\
$86:D02A 9D B7 1A    STA $1AB7,x            ;} Enemy projectile X velocity = 0
$86:D02D 60          RTS
}
}


;;; $D02E..D207: Kago bug ;;;
{
;;; $D02E: Enemy projectile - kago bug ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:D02E             dx D088,D0EB,9C7D,04,04,0014,0000,D064 ; Kago bug. Initial pre-instruction ignored
}


;;; $D03C: Instruction list - kago bug - hit floor ;;;
{
$86:D03C             dw 0005,8466,
                        D1B6,       ; Start idling
                        7FFF,845F,
                        81AB,D03C   ; Go to $D03C
}


;;; $D04A: Instruction list - kago bug - falling ;;;
{
$86:D04A             dw 7FFF,845F,
                        81AB,D04A   ; Go to $D04A
}


;;; $D052: Instruction list - kago bug - jump ;;;
{
$86:D052             dw 0010,8466,
                        0005,845F,
                        D15C        ; Start jumping
$86:D05C             dw 7FFF,8458,
                        81AB,D05C   ; Go to $D05C
}


;;; $D064: Shot instruction list - enemy projectile $D02E (kago bug) ;;;
{
$86:D064             dw D1C7,       ; Use palette 0
                        0004,8D9C,
                        0004,8DA3,
                        0004,8DB9,
                        0004,8DCF,
                        0004,8DE5,
                        D1CE,       ; Spawn kago enemy drop
                        81AB,84FC   ; Go to $84FC (delete)
}


;;; $D080: Instruction list - delete ;;;
{
$86:D080             dx 8154        ; Delete
}


;;; $D082: Kago bug constants ;;;
{
$86:D082             dw 00E0 ; Y acceleration. Unit 1/100h px/frame²
$86:D084             dw 0030 ; X proximity. Kago bug will jump towards kago if it's at least this many pixels away
$86:D086             dw 0200 ; X velocity. Unit 1/100h px/frame
}


;;; $D088: Initialisation AI - enemy projectile $D02E (kago bug) ;;;
{
$86:D088 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$86:D08B 99 23 1B    STA $1B23,y[$7E:1B45]  ;} X = enemy projectile enemy index = [enemy index]
$86:D08E AA          TAX                    ;/
$86:D08F BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$86:D092 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [enemy X position]
$86:D095 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$86:D098 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [enemy Y position]
$86:D09B AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:D09E 29 07 00    AND #$0007             ;|
$86:D0A1 1A          INC A                  ;} Enemy projectile jump timer = 1 + [random number] % 8
$86:D0A2 99 FB 1B    STA $1BFB,y[$7E:1C1D]  ;/
$86:D0A5 18          CLC                    ;\
$86:D0A6 69 04 00    ADC #$0004             ;} Enemy projectile sound effect timer = [enemy projectile jump timer] + 4
$86:D0A9 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$86:D0AC A9 CA D0    LDA #$D0CA             ;\
$86:D0AF 99 03 1A    STA $1A03,y[$7E:1A25]  ;} Enemy projectile pre-instruction = $D0CA (idling)
$86:D0B2 60          RTS
}


;;; $D0B3: Handle kago bug sound effect ;;;
{
$86:D0B3 DA          PHX
$86:D0B4 5A          PHY
$86:D0B5 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:D0B8 F0 0D       BEQ $0D    [$D0C7]     ;} If [enemy projectile sound effect timer] != 0:
$86:D0BA 3A          DEC A                  ;\
$86:D0BB 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Decrement enemy projectile sound effect timer
$86:D0BE D0 07       BNE $07    [$D0C7]     ; If [enemy projectile sound effect timer] = 0:
$86:D0C0 A9 6C 00    LDA #$006C             ;\
$86:D0C3 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 6Ch, sound library 2, max queued sounds allowed = 6 (kago bug)

$86:D0C7 7A          PLY
$86:D0C8 FA          PLX
$86:D0C9 60          RTS
}


;;; $D0CA: Pre-instruction - kago bug - idling ;;;
{
$86:D0CA 20 B3 D0    JSR $D0B3  [$86:D0B3]  ; Handle kago bug sound effect
$86:D0CD 20 E4 D1    JSR $D1E4  [$86:D1E4]  ; Enable kago bug collision with Samus projectiles if far enough from kago
$86:D0D0 BD FB 1B    LDA $1BFB,x[$7E:1C1D]  ;\
$86:D0D3 F0 04       BEQ $04    [$D0D9]     ;} If [enemy projectile jump timer] != 0:
$86:D0D5 DE FB 1B    DEC $1BFB,x[$7E:1C1D]  ; Decrement enemy projectile jump timer
$86:D0D8 60          RTS                    ; Return

$86:D0D9 A9 52 D0    LDA #$D052             ;\
$86:D0DC 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $D052 (jump)
$86:D0DF A9 01 00    LDA #$0001             ;\
$86:D0E2 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:D0E5 A9 EB D0    LDA #$D0EB             ;\
$86:D0E8 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:D0EB 60          RTS
}


;;; $D0EC: Pre-instruction - kago bug - jumping ;;;
{
$86:D0EC 20 B3 D0    JSR $D0B3  [$86:D0B3]  ; Handle kago bug sound effect
$86:D0EF 20 E4 D1    JSR $D1E4  [$86:D1E4]  ; Enable kago bug collision with Samus projectiles if far enough from kago
$86:D0F2 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:D0F5 B0 12       BCS $12    [$D109]     ; If collision: go to BRANCH_HIT_WALL
$86:D0F7 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:D0FA B0 13       BCS $13    [$D10F]     ; If collision: go to BRANCH_HIT_CEILING
$86:D0FC BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:D0FF 18          CLC                    ;|
$86:D100 6D 82 D0    ADC $D082  [$86:D082]  ;} Enemy projectile Y velocity += E0h
$86:D103 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:D106 10 0D       BPL $0D    [$D115]     ; If [enemy projectile Y velocity] >= 0: go to BRANCH_FALLING
$86:D108 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:D109 A9 00 00    LDA #$0000             ;\
$86:D10C 9D B7 1A    STA $1AB7,x[$7E:1AD1]  ;} Enemy projectile X velocity = 0

; BRANCH_HIT_CEILING
$86:D10F A9 00 01    LDA #$0100             ;\
$86:D112 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;} Enemy projectile Y velocity = 100h

; BRANCH_FALLING
$86:D115 A9 28 D1    LDA #$D128             ;\
$86:D118 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $D128 (falling)
$86:D11B A9 4A D0    LDA #$D04A             ;\
$86:D11E 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $D04A
$86:D121 A9 01 00    LDA #$0001             ;\
$86:D124 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:D127 60          RTS
}


;;; $D128: Pre-instruction - kago bug - falling ;;;
{
$86:D128 20 B3 D0    JSR $D0B3  [$86:D0B3]  ; Handle kago bug sound effect
$86:D12B 20 E4 D1    JSR $D1E4  [$86:D1E4]  ; Enable kago bug collision with Samus projectiles if far enough from kago
$86:D12E 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:D131 B0 0F       BCS $0F    [$D142]     ; If collision: go to BRANCH_HIT_WALL
$86:D133 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:D136 B0 11       BCS $11    [$D149]     ; If collision: go to BRANCH_HIT_FLOOR
$86:D138 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:D13B 6D 82 D0    ADC $D082  [$86:D082]  ;} Enemy projectile Y velocity += E0h
$86:D13E 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:D141 60          RTS                    ; Return

; BRANCH_HIT_WALL
$86:D142 A9 00 00    LDA #$0000             ;\
$86:D145 9D B7 1A    STA $1AB7,x[$7E:1AD5]  ;} Enemy projectile X velocity = 0
$86:D148 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:D149 A9 EB D0    LDA #$D0EB             ;\
$86:D14C 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:D14F A9 3C D0    LDA #$D03C             ;\
$86:D152 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $D03C (hit floor)
$86:D155 A9 01 00    LDA #$0001             ;\
$86:D158 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:D15B 60          RTS
}


;;; $D15C: Instruction - start jumping ;;;
{
; Keeping the X direction flag on the stack was... not the least awkward approach
; If the kago is killed, its X position will be 0, which will cause the bugs to (usually) jump left
$86:D15C 20 B3 D0    JSR $D0B3  [$86:D0B3]  ; Handle kago bug sound effect
$86:D15F 20 E4 D1    JSR $D1E4  [$86:D1E4]  ; Enable kago bug collision with Samus projectiles if far enough from kago
$86:D162 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:D165 29 00 03    AND #$0300             ;|
$86:D168 18          CLC                    ;} A = 800h + [random number] / 100h % 4 * 100h
$86:D169 69 00 08    ADC #$0800             ;/
$86:D16C 89 00 01    BIT #$0100             ;\
$86:D16F 08          PHP                    ;} (X direction) = [A] / 100h % 2
$86:D170 49 FF FF    EOR #$FFFF             ;\
$86:D173 1A          INC A                  ;} Enemy projectile Y velocity = -[A]
$86:D174 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:D177 DA          PHX                    ;\
$86:D178 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;} X = [enemy projectile enemy index]
$86:D17B AA          TAX                    ;/
$86:D17C BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$86:D17F FA          PLX                    ;|
$86:D180 38          SEC                    ;|
$86:D181 FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$86:D184 08          PHP                    ;|
$86:D185 10 04       BPL $04    [$D18B]     ;} If |[enemy X position] - [enemy projectile X position]| < 30h: go to BRANCH_NEAR_KAGO
$86:D187 49 FF FF    EOR #$FFFF             ;|
$86:D18A 1A          INC A                  ;|
                                            ;|
$86:D18B CD 84 D0    CMP $D084  [$86:D084]  ;|
$86:D18E 30 11       BMI $11    [$D1A1]     ;/
$86:D190 28          PLP                    ;\
$86:D191 10 07       BPL $07    [$D19A]     ;} If [enemy X position] < [enemy projectile X position]:
$86:D193 28          PLP                    ;\
$86:D194 A9 01 00    LDA #$0001             ;} (X direction) = 1 (left)
$86:D197 08          PHP                    ;/
$86:D198 80 08       BRA $08    [$D1A2]     ; Go to BRANCH_DIRECTION_DETERMINED

$86:D19A 28          PLP                    ;\
$86:D19B A9 00 00    LDA #$0000             ;} (X direction) = 0 (right)
$86:D19E 08          PHP                    ;/
$86:D19F 80 01       BRA $01    [$D1A2]     ; Go to BRANCH_DIRECTION_DETERMINED

; BRANCH_NEAR_KAGO
$86:D1A1 28          PLP

; BRANCH_DIRECTION_DETERMINED
$86:D1A2 AD 86 D0    LDA $D086  [$86:D086]  ; Enemy projectile X velocity = 200h
$86:D1A5 28          PLP                    ;\
$86:D1A6 F0 04       BEQ $04    [$D1AC]     ;} If (X direction) != 0:
$86:D1A8 49 FF FF    EOR #$FFFF             ;\
$86:D1AB 1A          INC A                  ;} Negate enemy projectile X velocity

$86:D1AC 9D B7 1A    STA $1AB7,x[$7E:1AD9]
$86:D1AF A9 EC D0    LDA #$D0EC             ;\
$86:D1B2 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $D0EC (jumping)
$86:D1B5 60          RTS
}


;;; $D1B6: Instruction - start idling ;;;
{
$86:D1B6 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:D1B9 29 1F 00    AND #$001F             ;|
$86:D1BC 1A          INC A                  ;} Enemy projectile jump timer = 1 + [random number] % 20h
$86:D1BD 9D FB 1B    STA $1BFB,x[$7E:1C1D]  ;/
$86:D1C0 A9 CA D0    LDA #$D0CA             ;\
$86:D1C3 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $D0CA (idling)
$86:D1C6 60          RTS
}


;;; $D1C7: Instruction - use palette 0 ;;;
{
$86:D1C7 A9 00 00    LDA #$0000             ;\
$86:D1CA 9D BB 19    STA $19BB,x[$7E:19D9]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:D1CD 60          RTS
}


;;; $D1CE: Instruction - spawn kago enemy drop ;;;
{
$86:D1CE 5A          PHY
$86:D1CF DA          PHX
$86:D1D0 BD 4B 1A    LDA $1A4B,x[$7E:1A69]
$86:D1D3 85 12       STA $12    [$7E:0012]
$86:D1D5 BD 93 1A    LDA $1A93,x[$7E:1AB1]
$86:D1D8 85 14       STA $14    [$7E:0014]
$86:D1DA A9 FF E7    LDA #$E7FF
$86:D1DD 22 0E 92 A0 JSL $A0920E[$A0:920E]  ; Spawn enemy drops
$86:D1E1 FA          PLX
$86:D1E2 7A          PLY
$86:D1E3 60          RTS
}


;;; $D1E4: Enable kago bug collision with Samus projectiles if far enough from kago ;;;
{
; If the kago is killed, its X position will be 0, which will (usually) cause the Samus projectile collision to be enabled
$86:D1E4 DA          PHX
$86:D1E5 5A          PHY
$86:D1E6 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:D1E9 A8          TAY                    ;} Y = [enemy projectile enemy index]
$86:D1EA B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ;\
$86:D1ED 38          SEC                    ;|
$86:D1EE FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$86:D1F1 10 04       BPL $04    [$D1F7]     ;|
$86:D1F3 49 FF FF    EOR #$FFFF             ;} If |[enemy X position] - [enemy projectile X position]| >= 17h:
$86:D1F6 1A          INC A                  ;|
                                            ;|
$86:D1F7 C9 17 00    CMP #$0017             ;|
$86:D1FA 30 09       BMI $09    [$D205]     ;/
$86:D1FC BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$86:D1FF 09 00 80    ORA #$8000             ;} Enable enemy projectile collision with Samus projectiles
$86:D202 9D D7 1B    STA $1BD7,x[$7E:1BF9]  ;/

$86:D205 7A          PLY
$86:D206 FA          PLX
$86:D207 60          RTS
}
}


;;; $D208..A5: Maridia floater spike ;;;
{
;;; $D208: Instruction list - enemy projectile $D298 (Maridia floater spike) ;;;
{
$86:D208             dw 0006,99E7,
                        0006,99EE,
                        0006,99F5,
                        81AB,D208   ; Go to $D208
}


;;; $D218: Instruction - delete / shot instruction list - enemy projectile $D298 (Maridia floater spike) ;;;
{
$86:D218             dw 8154        ; Delete
}


;;; $D21A: Maridia floater's spike velocity table ;;;
{
;                        _____________________________________________ 0: Up
;                       |      _______________________________________ 1: Up-right
;                       |     |      _________________________________ 2: Right
;                       |     |     |      ___________________________ 3: Down-right
;                       |     |     |     |      _____________________ 4: Down
;                       |     |     |     |     |      _______________ 5: Down-left
;                       |     |     |     |     |     |      _________ 6: Left
;                       |     |     |     |     |     |     |      ___ 7: Up-left
;                       |     |     |     |     |     |     |     |
$86:D21A             dw 0000, 0020, 0020, 0020, 0000, FFE0, FFE0, FFE0 ; X velocity
$86:D22A             dw FFE0, FFE0, 0000, 0020, 0020, 0020, 0000, FFE0 ; Y velocity
}


;;; $D23A: Initialisation AI - enemy projectile $D298 (Maridia floater spike) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction
;;         0: Up
;;         1: Up-right
;;         2: Right
;;         3: Down-right
;;         4: Down
;;         5: Down-left
;;         6: Left
;;         7: Up-left
$86:D23A 08          PHP
$86:D23B C2 30       REP #$30
$86:D23D A9 00 00    LDA #$0000
$86:D240 99 27 1A    STA $1A27,y
$86:D243 99 6F 1A    STA $1A6F,y
$86:D246 99 B7 1A    STA $1AB7,y            ; Enemy projectile X velocity = 0
$86:D249 99 DB 1A    STA $1ADB,y            ; Enemy projectile Y velocity = 0
$86:D24C AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:D24F BD 7A 0F    LDA $0F7A,x            ;\
$86:D252 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [enemy X position]
$86:D255 BD 7E 0F    LDA $0F7E,x            ;\
$86:D258 99 93 1A    STA $1A93,y            ;} Enemy projectile Y position = [enemy Y position]
$86:D25B AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:D25E 99 FF 1A    STA $1AFF,y            ;} Enemy projectile direction = [enemy projectile initialisation parameter 0]
$86:D261 28          PLP
$86:D262 60          RTS
}


;;; $D263: Pre-instruction - enemy projectile $D298 (Maridia floater spike) ;;;
{
$86:D263 BD FF 1A    LDA $1AFF,x            ;\
$86:D266 0A          ASL A                  ;|
$86:D267 A8          TAY                    ;|
$86:D268 BD B7 1A    LDA $1AB7,x            ;} Enemy projectile X velocity += [$D21A + [enemy projectile direction] * 2]
$86:D26B 18          CLC                    ;|
$86:D26C 79 1A D2    ADC $D21A,y            ;|
$86:D26F 9D B7 1A    STA $1AB7,x            ;/
$86:D272 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:D275 B0 14       BCS $14    [$D28B]     ; If no collision:
$86:D277 BD FF 1A    LDA $1AFF,x            ;\
$86:D27A 0A          ASL A                  ;|
$86:D27B A8          TAY                    ;|
$86:D27C BD DB 1A    LDA $1ADB,x            ;} Enemy projectile Y velocity += [$D22A + [enemy projectile direction] * 2]
$86:D27F 18          CLC                    ;|
$86:D280 79 2A D2    ADC $D22A,y            ;|
$86:D283 9D DB 1A    STA $1ADB,x            ;/
$86:D286 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:D289 90 0C       BCC $0C    [$D297]     ; If no collision: return

$86:D28B A9 18 D2    LDA #$D218             ;\
$86:D28E 9D 47 1B    STA $1B47,x            ;} Enemy projectile instruction list pointer = $D218 (delete)
$86:D291 A9 01 00    LDA #$0001             ;\
$86:D294 9D 8F 1B    STA $1B8F,x            ;} Enemy projectile instruction timer = 1

$86:D297 60          RTS
}


;;; $D298: Enemy projectile - Maridia floater spike ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:D298             dx D23A,D263,D208,04,04,0014,0000,D218 ; Maridia floater spike
}
}


;;; $D2A6..D3D6: Wrecked Ship robot laser ;;;
{
;;; $D2A6: Enemy projectiles - Wrecked Ship robot laser ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:D2A6             dx D341,D3BF,D2EC,0C,0C,0004,0000,84FC ; Wrecked Ship robot laser - up-left
$86:D2B4             dx D32E,D3BF,D2EC,0F,02,0014,0000,84FC ; Wrecked Ship robot laser - horizontal
$86:D2C2             dx D30C,D3BF,D2EC,0C,0C,0004,0000,84FC ; Wrecked Ship robot laser - down-left
$86:D2D0             dx D341,D3BF,D2EC,0C,0C,0004,0000,84FC ; Wrecked Ship robot laser - up-right
$86:D2DE             dx D30C,D3BF,D2EC,0C,0C,0004,0000,84FC ; Wrecked Ship robot laser - down-right
}


;;; $D2EC: Instruction list - enemy projectile $D2A6/$D2B4/$D2C2/$D2D0/$D2DE (Wrecked Ship robot laser) ;;;
{
$86:D2EC             dw 0004,99FC,
                        0004,9A03,
                        0004,9A0A
$86:D2F8             dw 0004,9A20,
                        0004,9A36,
                        0004,9A4C,
                        0004,9A36,
                        81AB,D2F8   ; Go to $D2F8
}


;;; $D30C: Initialisation AI - enemy projectile $D2C2/$D2DE (Wrecked Ship robot laser - down-left/right) ;;;
{
$86:D30C DA          PHX
$86:D30D AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:D310 BD A8 0F    LDA $0FA8,x[$7E:11A8]  ;\
$86:D313 08          PHP                    ;} Enemy projectile X velocity = [enemy $0FA8]
$86:D314 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:D317 10 07       BPL $07    [$D320]     ;\
$86:D319 49 00 FF    EOR #$FF00             ;|
$86:D31C 18          CLC                    ;} >_<;
$86:D31D 69 00 01    ADC #$0100             ;/

$86:D320 A9 80 00    LDA #$0080             ;\
$86:D323 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = 80h
$86:D326 A9 00 00    LDA #$0000             ;\
$86:D329 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:D32C 80 2D       BRA $2D    [$D35B]     ; Go to Wrecked Ship robot laser common initialisation
}


;;; $D32E: Initialisation AI - enemy projectile $D2B4 (Wrecked Ship robot laser - horizontal) ;;;
{
$86:D32E DA          PHX
$86:D32F AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:D332 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$86:D335 08          PHP                    ;} Enemy projectile X velocity = [enemy $0FA8]
$86:D336 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:D339 A9 00 00    LDA #$0000             ;\
$86:D33C 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = 0
$86:D33F 80 1A       BRA $1A    [$D35B]     ; Go to Wrecked Ship robot laser common initialisation
}


;;; $D341: Initialisation AI - enemy projectile $D2A6/$D2D0 (Wrecked Ship robot laser - up-left/right) ;;;
{
$86:D341 DA          PHX
$86:D342 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:D345 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$86:D348 08          PHP                    ;} Enemy projectile X velocity = [enemy $0FA8]
$86:D349 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;/
$86:D34C 30 07       BMI $07    [$D355]     ;\
$86:D34E 49 00 FF    EOR #$FF00             ;|
$86:D351 18          CLC                    ;} >_<;
$86:D352 69 00 01    ADC #$0100             ;/

$86:D355 A9 80 FF    LDA #$FF80             ;\
$86:D358 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile Y velocity = -80h
}


;;; $D35B: Wrecked Ship robot laser common initialisation ;;;
{
; Expects a pushed PSR and X
; BUG: Missing `CMP $0915` at $D3B4 causes laser sound effect to only play if the robot is in the top row of scrolls
$86:D35B BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:D35E 38          SEC                    ;|
$86:D35F E9 10 00    SBC #$0010             ;} Enemy projectile Y position = [enemy Y position] - 10h
$86:D362 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:D365 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:D368 28          PLP                    ;|
$86:D369 30 06       BMI $06    [$D371]     ;|
$86:D36B 18          CLC                    ;|
$86:D36C 69 04 00    ADC #$0004             ;|
$86:D36F 80 04       BRA $04    [$D375]     ;} Enemy projectile X position = [enemy X position] + 4 * sgn([enemy projectile X velocity])
                                            ;|
$86:D371 38          SEC                    ;|
$86:D372 E9 04 00    SBC #$0004             ;|
                                            ;|
$86:D375 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:D378 A9 00 00    LDA #$0000             ;\
$86:D37B 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;} Enemy projectile Y subposition = 0
$86:D37E 99 27 1A    STA $1A27,y[$7E:1A49]  ; Enemy projectile X subposition = 0
$86:D381 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:D384 18          CLC                    ;|
$86:D385 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;} If (enemy right boundary) + 1 >= [layer 1 X position]:
$86:D388 CD 11 09    CMP $0911  [$7E:0911]  ;|
$86:D38B 30 30       BMI $30    [$D3BD]     ;/
$86:D38D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:D390 38          SEC                    ;|
$86:D391 FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$86:D394 38          SEC                    ;} If (enemy left boundary) <= [layer 1 X position] + 100h:
$86:D395 E9 01 01    SBC #$0101             ;|
$86:D398 CD 11 09    CMP $0911  [$7E:0911]  ;|
$86:D39B 10 20       BPL $20    [$D3BD]     ;/
$86:D39D BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:D3A0 18          CLC                    ;|
$86:D3A1 7D 84 0F    ADC $0F84,x[$7E:0F84]  ;} If (enemy bottom boundary) + 1 >= [layer 1 Y position]:
$86:D3A4 CD 15 09    CMP $0915  [$7E:0915]  ;|
$86:D3A7 30 14       BMI $14    [$D3BD]     ;/
$86:D3A9 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:D3AC 38          SEC                    ;|
$86:D3AD FD 84 0F    SBC $0F84,x[$7E:0F84]  ;|
$86:D3B0 38          SEC                    ;} If (enemy top boundary) < E0h:
$86:D3B1 E9 E0 00    SBC #$00E0             ;|
$86:D3B4 10 07       BPL $07    [$D3BD]     ;/
$86:D3B6 A9 67 00    LDA #$0067             ;\
$86:D3B9 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 67h, sound library 2, max queued sounds allowed = 6 (pirate laser)

$86:D3BD FA          PLX
$86:D3BE 60          RTS
}


;;; $D3BF: Pre-instruction - enemy projectile $D2A6/$D2B4/$D2C2/$D2D0/$D2DE (Wrecked Ship robot laser) ;;;
{
$86:D3BF 08          PHP
$86:D3C0 C2 20       REP #$20
$86:D3C2 A9 00 00    LDA #$0000             ;\
$86:D3C5 9D BB 19    STA $19BB,x[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:D3C8 20 B6 88    JSR $88B6  [$86:88B6]  ; Move enemy projectile horizontally
$86:D3CB B0 05       BCS $05    [$D3D2]     ; If no collision:
$86:D3CD 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically
$86:D3D0 90 03       BCC $03    [$D3D5]     ; If no collision: return

$86:D3D2 9E 97 19    STZ $1997,x[$7E:19B9]  ; Enemy projectile ID = 0

$86:D3D5 28          PLP
$86:D3D6 60          RTS
}
}


;;; $D3D7..D92D: n00b tube ;;;
{
;;; $D3D7..D6A4: Instruction lists ;;;
{
;;; $D3D7: Instruction list - enemy projectile $D904 (n00b tube crack) ;;;
{
$86:D3D7             dw 000C,9A62,
                        000A,9A8C,
                        0008,9AD4,
                        0006,9B6C,
                        0006,9C31,
                        0006,9D2D,
                        8161,D7BF,  ; Pre-instruction = $D7BF (flickering)
                        0001,9E71,
                        0001,9EB9,
                        0001,9F01,
                        0001,9F49,
                        0001,9F91,
                        0002,9FD9,
                        0003,A021,
                        0006,A069,
                        0009,A0B1,
                        0008,A0F9,
                        8161,D7DE,  ; Pre-instruction = $D7DE (falling)
                        0007,A141,
                        0007,A189,
                        0007,A1D1,
                        0007,A219,
                        0007,A261,
                        0007,A2A9,
                        0007,A2F1,
                        0007,A339,
                        0007,A381,
                        0007,A3C9,
                        0007,A411,
                        0007,A459,
                        0007,A4A1,
                        0007,A4E9,
                        0007,A531,
                        0007,A579,
                        0007,A5C1,
                        0007,A609,
                        0010,A651,
                        81D5,0006   ; Timer = 6
$86:D46F             dw 0010,A699,
                        0010,A651,
                        81C6,D46F,  ; Decrement timer and go to $D46F if non-zero
                        8154        ; Delete
}


;;; $D47D: Instruction list - n00b tube shard - parameter = 0 ;;;
{
$86:D47D             dw 81D5,0020       ; Timer = 20h
$86:D481             dw D5F2,A6E1,A6ED, ; Reflect-flicker n00b tube shard with left-side spritemap $A6E1 or right-side spritemap $A6ED
                        81C6,D481,      ; Decrement timer and go to $D481 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D495             dw D5F2,A6E1,A6ED, ; Reflect-flicker n00b tube shard with left-side spritemap $A6E1 or right-side spritemap $A6ED
                        81C6,D495,      ; Decrement timer and go to $D495 if non-zero
                        8154            ; Delete
}


;;; $D4A1: Instruction list - n00b tube shard - parameter = 2 ;;;
{
$86:D4A1             dw 81D5,0020       ; Timer = 20h
$86:D4A5             dw D5F2,A6F9,A705, ; Reflect-flicker n00b tube shard with left-side spritemap $A6F9 or right-side spritemap $A705
                        81C6,D4A5,      ; Decrement timer and go to $D4A5 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D4B9             dw D5F2,A6F9,A705, ; Reflect-flicker n00b tube shard with left-side spritemap $A6F9 or right-side spritemap $A705
                        81C6,D4B9,      ; Decrement timer and go to $D4B9 if non-zero
                        8154            ; Delete
}


;;; $D4C5: Instruction list - n00b tube shard - parameter = 4 ;;;
{
$86:D4C5             dw 81D5,0020       ; Timer = 20h
$86:D4C9             dw D5F2,A711,A718, ; Reflect-flicker n00b tube shard with left-side spritemap $A711 or right-side spritemap $A718
                        81C6,D4C9,      ; Decrement timer and go to $D4C9 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D4DD             dw D5F2,A711,A718, ; Reflect-flicker n00b tube shard with left-side spritemap $A711 or right-side spritemap $A718
                        81C6,D4DD,      ; Decrement timer and go to $D4DD if non-zero
                        8154            ; Delete
}


;;; $D4E9: Instruction list - n00b tube shard - parameter = 6 ;;;
{
$86:D4E9             dw 81D5,0020       ; Timer = 20h
$86:D4ED             dw D5F2,A71F,A72B, ; Reflect-flicker n00b tube shard with left-side spritemap $A71F or right-side spritemap $A72B
                        81C6,D4ED,      ; Decrement timer and go to $D4ED if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D501             dw D5F2,A71F,A72B, ; Reflect-flicker n00b tube shard with left-side spritemap $A71F or right-side spritemap $A72B
                        81C6,D501,      ; Decrement timer and go to $D501 if non-zero
                        8154            ; Delete
}


;;; $D50D: Instruction list - n00b tube shard - parameter = 8 ;;;
{
$86:D50D             dw 81D5,0020       ; Timer = 20h
$86:D511             dw D5F2,A737,A743, ; Reflect-flicker n00b tube shard with left-side spritemap $A737 or right-side spritemap $A743
                        81C6,D511,      ; Decrement timer and go to $D511 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D525             dw D5F2,A737,A743, ; Reflect-flicker n00b tube shard with left-side spritemap $A737 or right-side spritemap $A743
                        81C6,D525,      ; Decrement timer and go to $D525 if non-zero
                        8154            ; Delete
}


;;; $D531: Instruction list - n00b tube shard - parameter = Ah ;;;
{
$86:D531             dw 81D5,0020       ; Timer = 20h
$86:D535             dw D5F2,A74F,A75B, ; Reflect-flicker n00b tube shard with left-side spritemap $A74F or right-side spritemap $A75B
                        81C6,D535,      ; Decrement timer and go to $D535 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D549             dw D5F2,A74F,A75B, ; Reflect-flicker n00b tube shard with left-side spritemap $A74F or right-side spritemap $A75B
                        81C6,D549,      ; Decrement timer and go to $D549 if non-zero
                        8154            ; Delete
}


;;; $D555: Instruction list - n00b tube shard - parameter = Ch ;;;
{
$86:D555             dw 81D5,0020       ; Timer = 20h
$86:D559             dw D5F2,A767,A773, ; Reflect-flicker n00b tube shard with left-side spritemap $A767 or right-side spritemap $A773
                        81C6,D559,      ; Decrement timer and go to $D559 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D56D             dw D5F2,A767,A773, ; Reflect-flicker n00b tube shard with left-side spritemap $A767 or right-side spritemap $A773
                        81C6,D56D,      ; Decrement timer and go to $D56D if non-zero
                        8154            ; Delete
}


;;; $D579: Instruction list - n00b tube shard - parameter = Eh ;;;
{
$86:D579             dw 81D5,0020       ; Timer = 20h
$86:D57D             dw D5F2,A77F,A78B, ; Reflect-flicker n00b tube shard with left-side spritemap $A77F or right-side spritemap $A78B
                        81C6,D57D,      ; Decrement timer and go to $D57D if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D591             dw D5F2,A77F,A78B, ; Reflect-flicker n00b tube shard with left-side spritemap $A77F or right-side spritemap $A78B
                        81C6,D591,      ; Decrement timer and go to $D591 if non-zero
                        8154            ; Delete
}


;;; $D59D: Instruction list - n00b tube shard - parameter = 10h ;;;
{
$86:D59D             dw 81D5,0020       ; Timer = 20h
$86:D5A1             dw D62A,A797,      ; Flicker n00b tube shard with spritemap $A797
                        81C6,D5A1,      ; Decrement timer and go to $D5A1 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D5B3             dw D62A,A797,      ; Flicker n00b tube shard with spritemap $A797
                        81C6,D5B3,      ; Decrement timer and go to $D5B3 if non-zero
                        8154            ; Delete
}


;;; $D5BD: Instruction list - n00b tube shard - parameter = 12h ;;;
{
$86:D5BD             dw 81D5,0020       ; Timer = 20h
$86:D5C1             dw D5F2,A7A3,A7AF, ; Reflect-flicker n00b tube shard with left-side spritemap $A7A3 or right-side spritemap $A7AF
                        81C6,D5C1,      ; Decrement timer and go to $D5C1 if non-zero
                        D5E1,           ; Assign n00b tube shard falling angle
                        8161,D83D,      ; Pre-instruction = $D83D (falling)
                        81D5,0110       ; Timer = 110h
$86:D5D5             dw D5F2,A7A3,A7AF, ; Reflect-flicker n00b tube shard with left-side spritemap $A7A3 or right-side spritemap $A7AF
                        81C6,D5D5,      ; Decrement timer and go to $D5D5 if non-zero
                        8154            ; Delete
}


;;; $D5E1: Instruction - assign n00b tube shard falling angle ;;;
{
; TODO: seems that $05E7 (the bitmask result of $80:818E) is assumed to be 0 (or the low byte at least),
;       need to check if that's actually true (due to the n00b tube event check?)
;       Related: $D69A
$86:D5E1 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:D5E5 AD E6 05    LDA $05E6  [$7E:05E6]  ;\
$86:D5E8 9D B7 1A    STA $1AB7,x[$7E:1AD7]  ;} Enemy projectile falling angle = [random number] / 100h | [$05E7] * 100h
$86:D5EB A9 C0 00    LDA #$00C0             ;\
$86:D5EE 9D DB 1A    STA $1ADB,x[$7E:1AFB]  ;} Enemy projectile Y velocity = C0h
$86:D5F1 60          RTS
}


;;; $D5F2: Instruction - reflect-flicker n00b tube shard with left-side spritemap [[Y]] or right-side spritemap [[Y] + 2] ;;;
{
$86:D5F2 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$86:D5F5 4A          LSR A                  ;} If [frame counter] % 2 != 0:
$86:D5F6 90 0E       BCC $0E    [$D606]     ;/
$86:D5F8 BD 23 1B    LDA $1B23,x[$7E:1B43]  ;\
$86:D5FB 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;} Enemy projectile X position = [enemy projectile on-screen X position]
$86:D5FE B9 00 00    LDA $0000,y[$86:D483]  ;\
$86:D601 9D 6B 1B    STA $1B6B,x[$7E:1B8B]  ;} Enemy projectile spritemap pointer = [[Y]]
$86:D604 80 14       BRA $14    [$D61A]

$86:D606 A9 80 00    LDA #$0080             ;\ Else ([frame counter] % 2 = 0):
$86:D609 38          SEC                    ;|
$86:D60A FD 23 1B    SBC $1B23,x[$7E:1B43]  ;|
$86:D60D 18          CLC                    ;} Enemy projectile X position = 100h - [enemy projectile on-screen X position]
$86:D60E 69 80 00    ADC #$0080             ;|
$86:D611 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/
$86:D614 B9 02 00    LDA $0002,y[$86:D485]  ;\
$86:D617 9D 6B 1B    STA $1B6B,x[$7E:1B8B]  ;} Enemy projectile spritemap pointer = [[Y] + 2]

$86:D61A C8          INY                    ;\
$86:D61B C8          INY                    ;|
$86:D61C C8          INY                    ;} Y += 4
$86:D61D C8          INY                    ;/
$86:D61E 98          TYA                    ;\
$86:D61F 9D 47 1B    STA $1B47,x[$7E:1B67]  ;} Enemy projectile instruction list pointer = [Y]
$86:D622 A9 01 00    LDA #$0001             ;\
$86:D625 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:D628 68          PLA                    ; End instruction list processing
$86:D629 60          RTS
}


;;; $D62A: Instruction - flicker n00b tube shard with spritemap [[Y]] ;;;
{
$86:D62A AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$86:D62D 4A          LSR A                  ;} If [frame counter] % 2 != 0:
$86:D62E 90 08       BCC $08    [$D638]     ;/
$86:D630 BD 23 1B    LDA $1B23,x[$7E:1B33]  ;\
$86:D633 9D 4B 1A    STA $1A4B,x[$7E:1A5B]  ;} Enemy projectile X position = [enemy projectile on-screen X position]
$86:D636 80 06       BRA $06    [$D63E]

$86:D638 A9 00 EE    LDA #$EE00             ;\ Else ([frame counter] % 2 = 0):
$86:D63B 9D 4B 1A    STA $1A4B,x[$7E:1A5B]  ;} Enemy projectile X position = EE00h

$86:D63E B9 00 00    LDA $0000,y[$86:D5A3]  ;\
$86:D641 9D 6B 1B    STA $1B6B,x[$7E:1B7B]  ;} Enemy projectile spritemap pointer = [[Y]]
$86:D644 C8          INY                    ;\
$86:D645 C8          INY                    ;} Y += 2
$86:D646 98          TYA                    ;\
$86:D647 9D 47 1B    STA $1B47,x[$7E:1B57]  ;} Enemy projectile instruction list pointer = [Y]
$86:D64A A9 01 00    LDA #$0001             ;\
$86:D64D 9D 8F 1B    STA $1B8F,x[$7E:1B9F]  ;} Enemy projectile instruction timer = 1
$86:D650 68          PLA                    ; End instruction list processing
$86:D651 60          RTS
}


;;; $D652: Instruction list - enemy projectile $D920 (n00b tube released air bubbles) ;;;
{
$86:D652             dw 8161,D8DF,  ; Pre-instruction = $D8DF (flying)
                        0002,A7BB,
                        0002,A7C2,
                        0002,A7CE,
                        0002,A7DF,
                        D69A,       ; Assign n00b tube released air bubbles falling angle
                        8161,D89F,  ; Pre-instruction = $D89F (falling)
                        0002,A7DF,
                        0002,A7FA,
                        0002,A81F,
                        0002,A844,
                        0002,A864,
                        0002,A884,
                        0004,A89F,
                        0004,A8BA,
                        0004,A8D0,
                        0004,A8E6,
                        0004,A8FC,
                        8154        ; Delete
}


;;; $D69A: Instruction - assign n00b tube released air bubbles falling angle ;;;
{
$86:D69A 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:D69E AD E6 05    LDA $05E6  [$7E:05E6]  ;\
$86:D6A1 9D B7 1A    STA $1AB7,x[$7E:1AC3]  ;} Enemy projectile falling angle = [random number] / 100h | [$05E7] * 100h
$86:D6A4 60          RTS
}
}


;;; $D6A5: Initialisation AI - enemy projectile $D904 (n00b tube crack) ;;;
{
$86:D6A5 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:D6A8 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:D6AC AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:D6AF 0A          ASL A                  ;|
$86:D6B0 0A          ASL A                  ;|
$86:D6B1 0A          ASL A                  ;|
$86:D6B2 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h + 60h
$86:D6B3 18          CLC                    ;|
$86:D6B4 69 60 00    ADC #$0060             ;|
$86:D6B7 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:D6BA AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:D6BD 0A          ASL A                  ;|
$86:D6BE 0A          ASL A                  ;|
$86:D6BF 0A          ASL A                  ;|
$86:D6C0 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h + 30h
$86:D6C1 18          CLC                    ;|
$86:D6C2 69 30 00    ADC #$0030             ;|
$86:D6C5 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:D6C8 60          RTS
}


;;; $D6C9: Initialisation AI - enemy projectile $D912 (n00b tube shard) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Multiple of 2, range 0..12h
$86:D6C9 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:D6CC 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:D6D0 AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:D6D3 AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:D6D6 0A          ASL A                  ;|
$86:D6D7 0A          ASL A                  ;|
$86:D6D8 0A          ASL A                  ;|
$86:D6D9 0A          ASL A                  ;|
$86:D6DA 18          CLC                    ;} Enemy projectile on-screen X position = [PLM X block] * 10h + 60h + [$D710 + [X]]
$86:D6DB 69 60 00    ADC #$0060             ;|
$86:D6DE 18          CLC                    ;|
$86:D6DF 7D 10 D7    ADC $D710,x[$86:D710]  ;|
$86:D6E2 99 23 1B    STA $1B23,y[$7E:1B43]  ;/
$86:D6E5 A9 00 00    LDA #$0000             ;\
$86:D6E8 99 FF 1A    STA $1AFF,y[$7E:1B1F]  ;} Enemy projectile on-screen X subposition = 0
$86:D6EB AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:D6EE 0A          ASL A                  ;|
$86:D6EF 0A          ASL A                  ;|
$86:D6F0 0A          ASL A                  ;|
$86:D6F1 0A          ASL A                  ;|
$86:D6F2 18          CLC                    ;} Enemy projectile Y position = [PLM Y block] * 10h + 30h + [$D724 + [X]]
$86:D6F3 69 30 00    ADC #$0030             ;|
$86:D6F6 18          CLC                    ;|
$86:D6F7 7D 24 D7    ADC $D724,x[$86:D724]  ;|
$86:D6FA 99 93 1A    STA $1A93,y[$7E:1AB3]  ;/
$86:D6FD BD 60 D7    LDA $D760,x[$86:D760]  ;\
$86:D700 99 47 1B    STA $1B47,y[$7E:1B67]  ;} Enemy projectile instruction list pointer = [$D760 + [X]]
$86:D703 BD 38 D7    LDA $D738,x[$86:D738]  ;\
$86:D706 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile X velocity = [$D738 + [X]]
$86:D709 BD 4C D7    LDA $D74C,x[$86:D74C]  ;\
$86:D70C 99 DB 1A    STA $1ADB,y[$7E:1AFB]  ;} Enemy projectile Y velocity = [$D74C + [X]]
$86:D70F 60          RTS

$86:D710             dw FFC8,FFC0,FFEC,FFD8,FFC0,FFD0,FFE8,FFD8,0000,FFF8 ; X offset
$86:D724             dw 0008,FFF4,FFE6,FFE8,FFE0,001C,0010,FFF8,FFE8,0010 ; Y offset
$86:D738             dw FE80,FE80,FF60,FEE0,FEE0,FEC0,FFA0,FEA0,0000,FFC0 ; X velocity. Unit 1/100h px/frame
$86:D74C             dw 0140,FF00,FE60,FEE0,FEE0,01C0,0240,FFA0,FEE0,0180 ; Y velocity. Unit 1/100h px/frame
$86:D760             dw D47D,D4A1,D4C5,D4E9,D50D,D531,D555,D579,D59D,D5BD ; Instruction list pointer
}


;;; $D774: Initialisation AI - enemy projectile $D920 (n00b tube released air bubbles) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Position table index. Multiple of 2, range 0..Ah
$86:D774 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:D777 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:D77B AE 93 19    LDX $1993  [$7E:1993]  ; X = [enemy projectile initialisation parameter]
$86:D77E AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:D781 0A          ASL A                  ;|
$86:D782 0A          ASL A                  ;|
$86:D783 0A          ASL A                  ;|
$86:D784 0A          ASL A                  ;} Enemy projectile on-screen X position = [PLM X block] * 10h + [$D7A7 + [X]]
$86:D785 18          CLC                    ;|
$86:D786 7D A7 D7    ADC $D7A7,x[$86:D7A7]  ;|
$86:D789 99 23 1B    STA $1B23,y[$7E:1B2F]  ;/
$86:D78C A9 00 00    LDA #$0000             ;\
$86:D78F 99 FF 1A    STA $1AFF,y[$7E:1B0B]  ;} Enemy projectile on-screen X subposition = 0
$86:D792 AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:D795 0A          ASL A                  ;|
$86:D796 0A          ASL A                  ;|
$86:D797 0A          ASL A                  ;|
$86:D798 0A          ASL A                  ;|
$86:D799 18          CLC                    ;} Enemy projectile Y position = [PLM Y block] * 10h - 500h + [$D7B3 + [X]]
$86:D79A 7D B3 D7    ADC $D7B3,x[$86:D7B3]  ;|
$86:D79D 99 93 1A    STA $1A93,y[$7E:1A9F]  ;|
$86:D7A0 A9 00 FB    LDA #$FB00             ;|
$86:D7A3 99 DB 1A    STA $1ADB,y[$7E:1AE7]  ;/
$86:D7A6 60          RTS

$86:D7A7             dw 0028,0050,0068,0078,0098,00B8 ; X offset
$86:D7B3             dw 0050,0048,0054,0020,0040,0054 ; Y offset
}


;;; $D7BF: Pre-instruction - n00b tube crack - flickering ;;;
{
$86:D7BF BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:D7C2 C9 00 EE    CMP #$EE00             ;} If [enemy projectile X position] != EE00h:
$86:D7C5 F0 03       BEQ $03    [$D7CA]     ;/
$86:D7C7 9D FF 1A    STA $1AFF,x[$7E:1B21]  ; Enemy projectile on-screen X position = [enemy projectile X position]

$86:D7CA AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$86:D7CD 4A          LSR A                  ;} If [frame counter] % 2 != 0:
$86:D7CE 90 07       BCC $07    [$D7D7]     ;/
$86:D7D0 A9 00 EE    LDA #$EE00             ;\
$86:D7D3 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = EE00h
$86:D7D6 60          RTS                    ; Return

$86:D7D7 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:D7DA 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [enemy projectile on-screen X position]
$86:D7DD 60          RTS
}


;;; $D7DE: Pre-instruction - n00b tube crack - falling ;;;
{
; >_<;
; Here's my optimisation:
;     LDA $1A6F,x : CLC : ADC #$C000 : STA $1A6F,x
;     LDA $1A93,x : ADC #$0000 : STA $1A93,x
$86:D7DE 64 12       STZ $12    [$7E:0012]  ;\
$86:D7E0 64 14       STZ $14    [$7E:0014]  ;|
$86:D7E2 A9 C0 00    LDA #$00C0             ;|
$86:D7E5 10 02       BPL $02    [$D7E9]     ;|
$86:D7E7 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:D7E9 85 13       STA $13    [$7E:0013]  ;|
$86:D7EB BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;} Enemy Y position += 0.C000h
$86:D7EE 18          CLC                    ;|
$86:D7EF 65 12       ADC $12    [$7E:0012]  ;|
$86:D7F1 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;|
$86:D7F4 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:D7F7 65 14       ADC $14    [$7E:0014]  ;|
$86:D7F9 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:D7FC 60          RTS
}


;;; $D7FD: Pre-instruction - n00b tube shard - flying ;;;
{
$86:D7FD 64 12       STZ $12    [$7E:0012]  ;\
$86:D7FF 64 14       STZ $14    [$7E:0014]  ;|
$86:D801 BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;|
$86:D804 10 02       BPL $02    [$D808]     ;|
$86:D806 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:D808 85 13       STA $13    [$7E:0013]  ;|
$86:D80A BD FF 1A    LDA $1AFF,x[$7E:1B1F]  ;} Enemy projectile on-screen X position += [enemy projectile X velocity] / 100h
$86:D80D 18          CLC                    ;|
$86:D80E 65 12       ADC $12    [$7E:0012]  ;|
$86:D810 9D FF 1A    STA $1AFF,x[$7E:1B1F]  ;|
$86:D813 BD 23 1B    LDA $1B23,x[$7E:1B43]  ;|
$86:D816 65 14       ADC $14    [$7E:0014]  ;|
$86:D818 9D 23 1B    STA $1B23,x[$7E:1B43]  ;/
$86:D81B 64 12       STZ $12    [$7E:0012]  ;\
$86:D81D 64 14       STZ $14    [$7E:0014]  ;|
$86:D81F BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;|
$86:D822 10 02       BPL $02    [$D826]     ;|
$86:D824 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:D826 85 13       STA $13    [$7E:0013]  ;|
$86:D828 BD 6F 1A    LDA $1A6F,x[$7E:1A8F]  ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
$86:D82B 18          CLC                    ;|
$86:D82C 65 12       ADC $12    [$7E:0012]  ;|
$86:D82E 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;|
$86:D831 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;|
$86:D834 65 14       ADC $14    [$7E:0014]  ;|
$86:D836 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:D839 20 B9 B5    JSR $B5B9  [$86:B5B9]  ; Delete enemy projectile if vertically off-screen
$86:D83C 60          RTS
}


;;; $D83D: Pre-instruction - n00b tube shard - falling ;;;
{
; The `ORA #$0080` seems random/pointless. Given that the angle is chosen randomly, it has no real effect
$86:D83D BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;\
$86:D840 29 FE 01    AND #$01FE             ;|
$86:D843 09 80 00    ORA #$0080             ;} X = ([enemy projectile falling angle] / 2 % 100h | 40h) * 2
$86:D846 AA          TAX                    ;/
$86:D847 64 12       STZ $12    [$7E:0012]  ;\
$86:D849 64 14       STZ $14    [$7E:0014]  ;|
$86:D84B 18          CLC                    ;|
$86:D84C BF 43 B4 A0 LDA $A0B443,x[$A0:B517];|
$86:D850 29 FE FF    AND #$FFFE             ;|
$86:D853 10 06       BPL $06    [$D85B]     ;|
$86:D855 C6 14       DEC $14    [$7E:0014]  ;|
$86:D857 38          SEC                    ;|
$86:D858 09 01 00    ORA #$0001             ;|
                                            ;|
$86:D85B 6A          ROR A                  ;} Enemy projectile on-screen X position += 40h * sin([X] / 2 * pi / 80h)
$86:D85C 6A          ROR A                  ;|
$86:D85D 85 13       STA $13    [$7E:0013]  ;|
$86:D85F AE 91 19    LDX $1991  [$7E:1991]  ;|
$86:D862 BD FF 1A    LDA $1AFF,x[$7E:1B1F]  ;|
$86:D865 18          CLC                    ;|
$86:D866 65 12       ADC $12    [$7E:0012]  ;|
$86:D868 9D FF 1A    STA $1AFF,x[$7E:1B1F]  ;|
$86:D86B BD 23 1B    LDA $1B23,x[$7E:1B43]  ;|
$86:D86E 65 14       ADC $14    [$7E:0014]  ;|
$86:D870 9D 23 1B    STA $1B23,x[$7E:1B43]  ;/
$86:D873 BD B7 1A    LDA $1AB7,x[$7E:1AD7]  ;\
$86:D876 18          CLC                    ;|
$86:D877 69 02 00    ADC #$0002             ;} Enemy projectile falling angle += 2
$86:D87A 9D B7 1A    STA $1AB7,x[$7E:1AD7]  ;/
$86:D87D 64 12       STZ $12    [$7E:0012]  ;\
$86:D87F 64 14       STZ $14    [$7E:0014]  ;|
$86:D881 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;|
$86:D884 10 02       BPL $02    [$D888]     ;|
$86:D886 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:D888 85 13       STA $13    [$7E:0013]  ;|
$86:D88A BD 6F 1A    LDA $1A6F,x[$7E:1A8F]  ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
$86:D88D 18          CLC                    ;|
$86:D88E 65 12       ADC $12    [$7E:0012]  ;|
$86:D890 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;|
$86:D893 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;|
$86:D896 65 14       ADC $14    [$7E:0014]  ;|
$86:D898 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/
$86:D89B 20 B9 B5    JSR $B5B9  [$86:B5B9]  ; Delete enemy projectile if vertically off-screen
$86:D89E 60          RTS
}


;;; $D89F: Pre-instruction - n00b tube released air bubbles - falling ;;;
{
; The `ORA #$0080` seems random/pointless. Given that the angle is chosen randomly, it has no real effect
$86:D89F BD B7 1A    LDA $1AB7,x[$7E:1AC3]  ;\
$86:D8A2 29 FE 01    AND #$01FE             ;|
$86:D8A5 09 80 00    ORA #$0080             ;} X = ([enemy projectile falling angle] / 2 % 100h | 40h) * 2
$86:D8A8 AA          TAX                    ;/
$86:D8A9 64 12       STZ $12    [$7E:0012]  ;\
$86:D8AB 64 14       STZ $14    [$7E:0014]  ;|
$86:D8AD 18          CLC                    ;|
$86:D8AE BF 43 B4 A0 LDA $A0B443,x[$A0:B531];|
$86:D8B2 29 FE FF    AND #$FFFE             ;|
$86:D8B5 10 06       BPL $06    [$D8BD]     ;|
$86:D8B7 C6 14       DEC $14    [$7E:0014]  ;|
$86:D8B9 38          SEC                    ;|
$86:D8BA 09 01 00    ORA #$0001             ;|
                                            ;|
$86:D8BD 6A          ROR A                  ;} Enemy projectile on-screen X position += 40h * sin([X] / 2 * pi / 80h)
$86:D8BE 6A          ROR A                  ;|
$86:D8BF 85 13       STA $13    [$7E:0013]  ;|
$86:D8C1 AE 91 19    LDX $1991  [$7E:1991]  ;|
$86:D8C4 BD FF 1A    LDA $1AFF,x[$7E:1B0B]  ;|
$86:D8C7 18          CLC                    ;|
$86:D8C8 65 12       ADC $12    [$7E:0012]  ;|
$86:D8CA 9D FF 1A    STA $1AFF,x[$7E:1B0B]  ;|
$86:D8CD BD 23 1B    LDA $1B23,x[$7E:1B2F]  ;|
$86:D8D0 65 14       ADC $14    [$7E:0014]  ;|
$86:D8D2 9D 23 1B    STA $1B23,x[$7E:1B2F]  ;/
$86:D8D5 BD B7 1A    LDA $1AB7,x[$7E:1AC3]  ;\
$86:D8D8 18          CLC                    ;|
$86:D8D9 69 04 00    ADC #$0004             ;} Enemy projectile falling angle += 4
$86:D8DC 9D B7 1A    STA $1AB7,x[$7E:1AC3]  ;/
}


;;; $D8DF: Pre-instruction - n00b tube released air bubbles - flying ;;;
{
$86:D8DF 64 12       STZ $12    [$7E:0012]  ;\
$86:D8E1 64 14       STZ $14    [$7E:0014]  ;|
$86:D8E3 BD DB 1A    LDA $1ADB,x[$7E:1AE7]  ;|
$86:D8E6 10 02       BPL $02    [$D8EA]     ;|
$86:D8E8 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$86:D8EA 85 13       STA $13    [$7E:0013]  ;|
$86:D8EC BD 6F 1A    LDA $1A6F,x[$7E:1A7B]  ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
$86:D8EF 18          CLC                    ;|
$86:D8F0 65 12       ADC $12    [$7E:0012]  ;|
$86:D8F2 9D 6F 1A    STA $1A6F,x[$7E:1A7B]  ;|
$86:D8F5 BD 93 1A    LDA $1A93,x[$7E:1A9F]  ;|
$86:D8F8 65 14       ADC $14    [$7E:0014]  ;|
$86:D8FA 9D 93 1A    STA $1A93,x[$7E:1A9F]  ;/
$86:D8FD BD 23 1B    LDA $1B23,x[$7E:1B2F]  ;\
$86:D900 9D 4B 1A    STA $1A4B,x[$7E:1A57]  ;} Enemy projectile X position = [enemy projectile on-screen X position]
$86:D903 60          RTS
}


;;; $D904: Enemy projectiles - n00b tube ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:D904             dx D6A5,84FB,D3D7,00,00,3000,0000,84FC ; n00b tube crack
$86:D912             dx D6C9,D7FD,D47D,00,00,3000,0000,84FC ; n00b tube shard. Initial instruction list ignored
$86:D920             dx D774,84FB,D652,00,00,3000,0000,84FC ; n00b tube released air bubbles
}
}


;;; $D92E..DB0B: Spike shooting plant spike ;;;
{
;;; $D92E..69: Instruction lists ;;;
{
;;; $D92E: Instruction list - spike shooting plant spike - left - facing up ;;;
{
$86:D92E             dx 0001,A908,
                        8159        ; Sleep
}


;;; $D934: Instruction list - spike shooting plant spike - up-left ;;;
{
$86:D934             dx 0001,A90F,
                        8159        ; Sleep
}


;;; $D93A: Instruction list - spike shooting plant spike - up ;;;
{
$86:D93A             dx 0001,A916,
                        8159        ; Sleep
}


;;; $D940: Instruction list - spike shooting plant spike - up-right ;;;
{
$86:D940             dx 0001,A91D,
                        8159        ; Sleep
}


;;; $D946: Instruction list - spike shooting plant spike - right - facing up ;;;
{
$86:D946             dx 0001,A924,
                        8159        ; Sleep
}


;;; $D94C: Instruction list - spike shooting plant spike - left - facing down ;;;
{
$86:D94C             dx 0001,A92B,
                        8159        ; Sleep
}


;;; $D952: Instruction list - spike shooting plant spike - down-left ;;;
{
$86:D952             dx 0001,A932,
                        8159        ; Sleep
}


;;; $D958: Instruction list - spike shooting plant spike - down ;;;
{
$86:D958             dx 0001,A939,
                        8159        ; Sleep
}


;;; $D95E: Instruction list - spike shooting plant spike - down-right ;;;
{
$86:D95E             dx 0001,A940,
                        8159        ; Sleep
}


;;; $D964: Instruction list - spike shooting plant spike - right - facing down ;;;
{
$86:D964             dx 0001,A947,
                        8159        ; Sleep
}
}


;;; $D96A: Spike shooting plant instruction list pointers ;;;
{
$86:D96A             dw D92E, D93A, D946, D94C, D958, D964,
                        D934, D940, D952, D95E
}


;;; $D97E: Spike shooting plant function pointers ;;;
{
$86:D97E             dw DA8E, DA98, DA93, DA8E, DA9D, DA93,
                        DAA2, DAB2, DAAA, DABA
}


;;; $D992: Initialisation AI - enemy projectile $DAFE (spike shooting plant spike) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction
;;         0: Left - facing up
;;         2: Up
;;         4: Right - facing up
;;         6: Left - facing down
;;         8: Down
;;         Ah: Right - facing down
;;         Ch: Up-left
;;         Eh: Up-right
;;         10h: Down-left
;;         12h: Down-right
$86:D992 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:D995 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} X = enemy projectile direction = [enemy projectile initialisation parameter 0]
$86:D998 AA          TAX                    ;/
$86:D999 BD 6A D9    LDA $D96A,x[$86:D96A]  ;\
$86:D99C 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = [$D96A + [X]]
$86:D99F AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:D9A2 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:D9A5 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;|
$86:D9A8 BD 7C 0F    LDA $0F7C,x[$7E:0F7C]  ;} Enemy projectile X position = [enemy X position]
$86:D9AB 99 27 1A    STA $1A27,y[$7E:1A49]  ;/
$86:D9AE BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:D9B1 99 93 1A    STA $1A93,y[$7E:1AB5]  ;|
$86:D9B4 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;} Enemy projectile Y position = [enemy Y position]
$86:D9B7 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;/
$86:D9BA A9 00 FE    LDA #$FE00             ;\
$86:D9BD 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile negated speed = -200h
$86:D9C0 A9 00 02    LDA #$0200             ;\
$86:D9C3 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile speed = 200h
$86:D9C6 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:D9C9 C9 0C 00    CMP #$000C             ;} If [enemy projectile direction] >= Ch:
$86:D9CC 30 0C       BMI $0C    [$D9DA]     ;/
$86:D9CE A9 80 FE    LDA #$FE80             ;\
$86:D9D1 99 DB 1A    STA $1ADB,y[$7E:1AFB]  ;} Enemy projectile negated speed = -180h
$86:D9D4 A9 80 01    LDA #$0180             ;\
$86:D9D7 99 B7 1A    STA $1AB7,y[$7E:1AD7]  ;} Enemy projectile speed = 180h

$86:D9DA 60          RTS
}


;;; $D9DB: Pre-instruction - enemy projectile $DAFE (spike shooting plant spike) ;;;
{
$86:D9DB 9B          TXY                    ;\
$86:D9DC BE FF 1A    LDX $1AFF,y[$7E:1B21]  ;} Execute [$D97E + [enemy projectile direction]]
$86:D9DF FC 7E D9    JSR ($D97E,x)[$86:DA8E];/
$86:D9E2 20 C2 DA    JSR $DAC2  [$86:DAC2]  ; Delete enemy projectile if off screen
$86:D9E5 60          RTS
}


;;; $D9E6: Move spike shooting plant spike up ;;;
{
;; Parameters:
;;     X: Enemy projectile index
$86:D9E6 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;\
$86:D9E9 29 00 FF    AND #$FF00             ;|
$86:D9EC EB          XBA                    ;|
$86:D9ED 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:D9F1 18          CLC                    ;|
$86:D9F2 7D 93 1A    ADC $1A93,x[$7E:1AB3]  ;|
$86:D9F5 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;|
$86:D9F8 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;|
$86:D9FB 29 FF 00    AND #$00FF             ;} Enemy projectile Y position += [enemy projectile negated speed] / 100h
$86:D9FE EB          XBA                    ;|
$86:D9FF 18          CLC                    ;|
$86:DA00 7D 6F 1A    ADC $1A6F,x[$7E:1A8F]  ;|
$86:DA03 9D 6F 1A    STA $1A6F,x[$7E:1A8F]  ;|
$86:DA06 90 07       BCC $07    [$DA0F]     ;|
$86:DA08 BD 93 1A    LDA $1A93,x[$7E:1AB3]  ;|
$86:DA0B 1A          INC A                  ;|
$86:DA0C 9D 93 1A    STA $1A93,x[$7E:1AB3]  ;/

$86:DA0F 60          RTS
}


;;; $DA10: Move spike shooting plant spike down ;;;
{
;; Parameters:
;;     X: Enemy projectile index
$86:DA10 BD B7 1A    LDA $1AB7,x[$7E:1AD5]  ;\
$86:DA13 29 00 FF    AND #$FF00             ;|
$86:DA16 EB          XBA                    ;|
$86:DA17 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DA1B 18          CLC                    ;|
$86:DA1C 7D 93 1A    ADC $1A93,x[$7E:1AB1]  ;|
$86:DA1F 9D 93 1A    STA $1A93,x[$7E:1AB1]  ;|
$86:DA22 BD B7 1A    LDA $1AB7,x[$7E:1AD5]  ;|
$86:DA25 29 FF 00    AND #$00FF             ;} Enemy projectile Y position += [enemy projectile speed] / 100h
$86:DA28 EB          XBA                    ;|
$86:DA29 18          CLC                    ;|
$86:DA2A 7D 6F 1A    ADC $1A6F,x[$7E:1A8D]  ;|
$86:DA2D 9D 6F 1A    STA $1A6F,x[$7E:1A8D]  ;|
$86:DA30 90 07       BCC $07    [$DA39]     ;|
$86:DA32 BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;|
$86:DA35 1A          INC A                  ;|
$86:DA36 9D 93 1A    STA $1A93,x[$7E:1AB1]  ;/

$86:DA39 60          RTS
}


;;; $DA3A: Move spike shooting plant spike left ;;;
{
;; Parameters:
;;     X: Enemy projectile index
$86:DA3A BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:DA3D 29 00 FF    AND #$FF00             ;|
$86:DA40 EB          XBA                    ;|
$86:DA41 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DA45 18          CLC                    ;|
$86:DA46 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]  ;|
$86:DA49 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;|
$86:DA4C BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;|
$86:DA4F 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile negated speed] / 100h
$86:DA52 EB          XBA                    ;|
$86:DA53 18          CLC                    ;|
$86:DA54 7D 27 1A    ADC $1A27,x[$7E:1A49]  ;|
$86:DA57 9D 27 1A    STA $1A27,x[$7E:1A49]  ;|
$86:DA5A 90 07       BCC $07    [$DA63]     ;|
$86:DA5C BD 4B 1A    LDA $1A4B,x[$7E:1A6B]  ;|
$86:DA5F 1A          INC A                  ;|
$86:DA60 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;/

$86:DA63 60          RTS
}


;;; $DA64: Move spike shooting plant spike right ;;;
{
;; Parameters:
;;     X: Enemy projectile index
$86:DA64 BD B7 1A    LDA $1AB7,x[$7E:1AD3]  ;\
$86:DA67 29 00 FF    AND #$FF00             ;|
$86:DA6A EB          XBA                    ;|
$86:DA6B 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DA6F 18          CLC                    ;|
$86:DA70 7D 4B 1A    ADC $1A4B,x[$7E:1A67]  ;|
$86:DA73 9D 4B 1A    STA $1A4B,x[$7E:1A67]  ;|
$86:DA76 BD B7 1A    LDA $1AB7,x[$7E:1AD3]  ;|
$86:DA79 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile speed] / 100h
$86:DA7C EB          XBA                    ;|
$86:DA7D 18          CLC                    ;|
$86:DA7E 7D 27 1A    ADC $1A27,x[$7E:1A43]  ;|
$86:DA81 9D 27 1A    STA $1A27,x[$7E:1A43]  ;|
$86:DA84 90 07       BCC $07    [$DA8D]     ;|
$86:DA86 BD 4B 1A    LDA $1A4B,x[$7E:1A67]  ;|
$86:DA89 1A          INC A                  ;|
$86:DA8A 9D 4B 1A    STA $1A4B,x[$7E:1A67]  ;/

$86:DA8D 60          RTS
}


;;; $DA8E: Move spike shooting plant spike left ;;;
{
$86:DA8E BB          TYX
$86:DA8F 20 3A DA    JSR $DA3A  [$86:DA3A]  ; Move spike shooting plant spike left
$86:DA92 60          RTS
}


;;; $DA93: Move spike shooting plant spike right ;;;
{
$86:DA93 BB          TYX
$86:DA94 20 64 DA    JSR $DA64  [$86:DA64]  ; Move spike shooting plant spike right
$86:DA97 60          RTS
}


;;; $DA98: Move spike shooting plant spike up ;;;
{
$86:DA98 BB          TYX
$86:DA99 20 E6 D9    JSR $D9E6  [$86:D9E6]  ; Move spike shooting plant spike up
$86:DA9C 60          RTS
}


;;; $DA9D: Move spike shooting plant spike down ;;;
{
$86:DA9D BB          TYX
$86:DA9E 20 10 DA    JSR $DA10  [$86:DA10]  ; Move spike shooting plant spike down
$86:DAA1 60          RTS
}


;;; $DAA2: Move spike shooting plant spike up-left ;;;
{
$86:DAA2 BB          TYX
$86:DAA3 20 3A DA    JSR $DA3A  [$86:DA3A]  ; Move spike shooting plant spike left
$86:DAA6 20 E6 D9    JSR $D9E6  [$86:D9E6]  ; Move spike shooting plant spike up
$86:DAA9 60          RTS
}


;;; $DAAA: Move spike shooting plant spike down-left ;;;
{
$86:DAAA BB          TYX
$86:DAAB 20 3A DA    JSR $DA3A  [$86:DA3A]  ; Move spike shooting plant spike left
$86:DAAE 20 10 DA    JSR $DA10  [$86:DA10]  ; Move spike shooting plant spike down
$86:DAB1 60          RTS
}


;;; $DAB2: Move spike shooting plant spike up-right ;;;
{
$86:DAB2 BB          TYX
$86:DAB3 20 64 DA    JSR $DA64  [$86:DA64]  ; Move spike shooting plant spike right
$86:DAB6 20 E6 D9    JSR $D9E6  [$86:D9E6]  ; Move spike shooting plant spike up
$86:DAB9 60          RTS
}


;;; $DABA: Move spike shooting plant spike down-right ;;;
{
$86:DABA BB          TYX
$86:DABB 20 64 DA    JSR $DA64  [$86:DA64]  ; Move spike shooting plant spike right
$86:DABE 20 10 DA    JSR $DA10  [$86:DA10]  ; Move spike shooting plant spike down
$86:DAC1 60          RTS
}


;;; $DAC2: Delete enemy projectile if off screen ;;;
{
; Clone of $BD1E
$86:DAC2 20 CE DA    JSR $DACE  [$86:DACE]
$86:DAC5 F0 06       BEQ $06    [$DACD]
$86:DAC7 A9 00 00    LDA #$0000
$86:DACA 9D 97 19    STA $1997,x[$7E:19B1]

$86:DACD 60          RTS
}


;;; $DACE: Check if enemy projectile is off screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise

; Clone of $BD2A
$86:DACE BD 4B 1A    LDA $1A4B,x[$7E:1A6D]
$86:DAD1 CD 11 09    CMP $0911  [$7E:0911]
$86:DAD4 30 24       BMI $24    [$DAFA]
$86:DAD6 AD 11 09    LDA $0911  [$7E:0911]
$86:DAD9 18          CLC
$86:DADA 69 00 01    ADC #$0100
$86:DADD DD 4B 1A    CMP $1A4B,x[$7E:1A6D]
$86:DAE0 30 18       BMI $18    [$DAFA]
$86:DAE2 BD 93 1A    LDA $1A93,x[$7E:1AB5]
$86:DAE5 CD 15 09    CMP $0915  [$7E:0915]
$86:DAE8 30 10       BMI $10    [$DAFA]
$86:DAEA AD 15 09    LDA $0915  [$7E:0915]
$86:DAED 18          CLC
$86:DAEE 69 00 01    ADC #$0100
$86:DAF1 DD 93 1A    CMP $1A93,x[$7E:1AB5]
$86:DAF4 30 04       BMI $04    [$DAFA]
$86:DAF6 A9 00 00    LDA #$0000
$86:DAF9 60          RTS

$86:DAFA A9 01 00    LDA #$0001
$86:DAFD 60          RTS
}


;;; $DAFE: Enemy projectile - spike shooting plant spike ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:DAFE             dx D992,D9DB,D92E,02,02,0005,0000,84FC ; Spike shooting plant spike. Initial instruction list ignored
}
}


;;; $DB0C..FF: Mini-Crocomire projectile ;;;
{
;;; $DB0C: Instruction list - mini-Crocomire projectile ;;;
{
$86:DB0C             dx 0010,A94E,
                        0010,A955,
                        81AB,DB0C   ; Go to $DB0C
}


;;; $DB18: Initialisation AI - mini-Crocomire projectile ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction. 0 = left, otherwise = right
$86:DB18 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:DB1B A9 0C DB    LDA #$DB0C             ;\
$86:DB1E 99 47 1B    STA $1B47,y            ;} Enemy projectile instruction list pointer = $DB0C
$86:DB21 A9 62 DB    LDA #$DB62             ;\
$86:DB24 99 FF 1A    STA $1AFF,y            ;} Enemy projectile function = $DB62 (move left)
$86:DB27 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:DB2A F0 06       BEQ $06    [$DB32]     ;} If [enemy projectile initialisation parameter] != 0:
$86:DB2C A9 8C DB    LDA #$DB8C             ;\
$86:DB2F 99 FF 1A    STA $1AFF,y            ;} Enemy projectile function = $DB8C (move right)

$86:DB32 BD 7A 0F    LDA $0F7A,x            ;\
$86:DB35 99 4B 1A    STA $1A4B,y            ;|
$86:DB38 BD 7C 0F    LDA $0F7C,x            ;} Enemy projectile X position = [enemy X position]
$86:DB3B 99 27 1A    STA $1A27,y            ;/
$86:DB3E BD 7E 0F    LDA $0F7E,x            ;\
$86:DB41 18          CLC                    ;|
$86:DB42 69 02 00    ADC #$0002             ;|
$86:DB45 99 93 1A    STA $1A93,y            ;} Enemy projectile Y position = [enemy Y position] + 2.0
$86:DB48 BD 80 0F    LDA $0F80,x            ;|
$86:DB4B 99 6F 1A    STA $1A6F,y            ;/
$86:DB4E A9 00 FF    LDA #$FF00             ;\
$86:DB51 99 DB 1A    STA $1ADB,y            ;} Enemy projectile left X velocity = -100h
$86:DB54 A9 00 01    LDA #$0100             ;\
$86:DB57 99 B7 1A    STA $1AB7,y            ;} Enemy projectile right X velocity = 100h
$86:DB5A 60          RTS
}


;;; $DB5B: Pre-instruction - mini-Crocomire projectile ;;;
{
$86:DB5B FC FF 1A    JSR ($1AFF,x)          ; Execute [enemy projectile function]
$86:DB5E 20 B6 DB    JSR $DBB6  [$86:DBB6]  ; Delete enemy projectile if off screen
$86:DB61 60          RTS
}


;;; $DB62: Mini-Crocomire projectile function - move left ;;;
{
$86:DB62 BD DB 1A    LDA $1ADB,x            ;\
$86:DB65 29 00 FF    AND #$FF00             ;|
$86:DB68 EB          XBA                    ;|
$86:DB69 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DB6D 18          CLC                    ;|
$86:DB6E 7D 4B 1A    ADC $1A4B,x            ;|
$86:DB71 9D 4B 1A    STA $1A4B,x            ;|
$86:DB74 BD DB 1A    LDA $1ADB,x            ;|
$86:DB77 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile left X velocity] / 100h
$86:DB7A EB          XBA                    ;|
$86:DB7B 18          CLC                    ;|
$86:DB7C 7D 27 1A    ADC $1A27,x            ;|
$86:DB7F 9D 27 1A    STA $1A27,x            ;|
$86:DB82 90 07       BCC $07    [$DB8B]     ;|
$86:DB84 BD 4B 1A    LDA $1A4B,x            ;|
$86:DB87 1A          INC A                  ;|
$86:DB88 9D 4B 1A    STA $1A4B,x            ;/

$86:DB8B 60          RTS
}


;;; $DB8C: Mini-Crocomire projectile function - move right ;;;
{
$86:DB8C BD B7 1A    LDA $1AB7,x            ;\
$86:DB8F 29 00 FF    AND #$FF00             ;|
$86:DB92 EB          XBA                    ;|
$86:DB93 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DB97 18          CLC                    ;|
$86:DB98 7D 4B 1A    ADC $1A4B,x            ;|
$86:DB9B 9D 4B 1A    STA $1A4B,x            ;|
$86:DB9E BD B7 1A    LDA $1AB7,x            ;|
$86:DBA1 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile right X velocity] / 100h
$86:DBA4 EB          XBA                    ;|
$86:DBA5 18          CLC                    ;|
$86:DBA6 7D 27 1A    ADC $1A27,x            ;|
$86:DBA9 9D 27 1A    STA $1A27,x            ;|
$86:DBAC 90 07       BCC $07    [$DBB5]     ;|
$86:DBAE BD 4B 1A    LDA $1A4B,x            ;|
$86:DBB1 1A          INC A                  ;|
$86:DBB2 9D 4B 1A    STA $1A4B,x            ;/

$86:DBB5 60          RTS
}


;;; $DBB6: Delete enemy projectile if off screen ;;;
{
; Clone of $BD1E
$86:DBB6 20 C2 DB    JSR $DBC2  [$86:DBC2]
$86:DBB9 F0 06       BEQ $06    [$DBC1]
$86:DBBB A9 00 00    LDA #$0000
$86:DBBE 9D 97 19    STA $1997,x

$86:DBC1 60          RTS
}


;;; $DBC2: Check if enemy projectile is off screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise

; Clone of $BD2A
$86:DBC2 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]
$86:DBC5 CD 11 09    CMP $0911  [$7E:0911]
$86:DBC8 30 24       BMI $24    [$DBEE]
$86:DBCA AD 11 09    LDA $0911  [$7E:0911]
$86:DBCD 18          CLC
$86:DBCE 69 00 01    ADC #$0100
$86:DBD1 DD 4B 1A    CMP $1A4B,x[$7E:1A6D]
$86:DBD4 30 18       BMI $18    [$DBEE]
$86:DBD6 BD 93 1A    LDA $1A93,x[$7E:1AB5]
$86:DBD9 CD 15 09    CMP $0915  [$7E:0915]
$86:DBDC 30 10       BMI $10    [$DBEE]
$86:DBDE AD 15 09    LDA $0915  [$7E:0915]
$86:DBE1 18          CLC
$86:DBE2 69 00 01    ADC #$0100
$86:DBE5 DD 93 1A    CMP $1A93,x[$7E:1AB5]
$86:DBE8 30 04       BMI $04    [$DBEE]
$86:DBEA A9 00 00    LDA #$0000
$86:DBED 60          RTS

$86:DBEE A9 01 00    LDA #$0001
$86:DBF1 60          RTS
}


;;; $DBF2: Enemy projectile - mini-Crocomire projectile ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:DBF2             dx DB18,DB5B,DB0C,02,02,0005,0000,84FC ; Initial instruction list ignored
}
}


;;; $DC00..DE95: Spore Spawn ;;;
{
;;; $DC00: (Shot) instruction list - enemy projectile $DE88 (spore spawner) ;;;
{
$86:DC00             dx 0001,A99B,
                        8159        ; Sleep
}


;;; $DC06: Instruction list - spore spawner - spawn spore ;;;
{
$86:DC06             dx 0001,A99B,
                        0006,A9A2,
                        DC77,       ; Spawn spores enemy projectile
                        0010,A9A9,
                        0006,A9A2,
                        0001,A99B,
                        8159        ; Sleep
}


;;; $DC1E: Instruction list - enemy projectile $DE7A (spores) ;;;
{
$86:DC1E             dx 0005,A9B0,
                        0005,A9B7,
                        0005,A9BE,
                        81AB,DC1E   ; Go to $DC1E
}


;;; $DC2E: (Shot) instruction list - enemy projectile $DE6C (Spore Spawn's stalk) ;;;
{
$86:DC2E             dx 0005,A994,
                        8159        ; Sleep
}


;;; $DC34: Shot instruction list - enemy projectile $DE7A (spores) ;;;
{
$86:DC34             dw 0001,B023,
                        DC5A,       ; Enemy projectile properties = 3000h (disable collisions, high priority)
                        0003,B023,
                        0006,B02A,
                        0005,B040,
                        EE8B,       ; Queue enemy killed sound effect
                        0005,B056,
                        0005,B06C,
                        0006,B082,
                        DC61,       ; Spawn enemy drops with Spore Spawn's drop chances
                        81AB,84FC   ; Go to delete
}


;;; $DC5A: Instruction - enemy projectile properties = 3000h ;;;
{
$86:DC5A A9 00 30    LDA #$3000
$86:DC5D 9D D7 1B    STA $1BD7,x[$7E:1BE9]
$86:DC60 60          RTS
}


;;; $DC61: Instruction - spawn enemy drops with Spore Spawn's drop chances ;;;
{
$86:DC61 DA          PHX
$86:DC62 5A          PHY
$86:DC63 BD 4B 1A    LDA $1A4B,x[$7E:1A5D]  ;\
$86:DC66 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:DC68 BD 93 1A    LDA $1A93,x[$7E:1AA5]  ;\
$86:DC6B 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:DC6D A9 7F DF    LDA #$DF7F             ; A = $DF7F (Spore Spawn)
$86:DC70 22 0E 92 A0 JSL $A0920E[$A0:920E]  ; Spawn enemy drops
$86:DC74 7A          PLY
$86:DC75 FA          PLX
$86:DC76 60          RTS
}


;;; $DC77: Instruction - spawn spore enemy projectile ;;;
{
$86:DC77 DA          PHX
$86:DC78 5A          PHY
$86:DC79 BD 4B 1A    LDA $1A4B,x[$7E:1A65]  ;\
$86:DC7C 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:DC7E BD 93 1A    LDA $1A93,x[$7E:1AAD]  ;\
$86:DC81 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:DC83 A0 7A DE    LDY #$DE7A             ;\
$86:DC86 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn spores enemy projectile
$86:DC8A 7A          PLY
$86:DC8B FA          PLX
$86:DC8C 60          RTS
}


;;; $DC8D: Initialisation AI - enemy projectile $DE7A (spores) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
$86:DC8D DA          PHX
$86:DC8E A5 12       LDA $12    [$7E:0012]  ;\
$86:DC90 99 4B 1A    STA $1A4B,y[$7E:1A5D]  ;} Enemy projectile X position = [$12]
$86:DC93 99 23 1B    STA $1B23,y[$7E:1B35]  ; Enemy projectile spawn X position = [$12]
$86:DC96 A5 14       LDA $14    [$7E:0014]  ;\
$86:DC98 99 93 1A    STA $1A93,y[$7E:1AA5]  ;} Enemy projectile Y position = [$14]
$86:DC9B A9 00 02    LDA #$0200             ;\
$86:DC9E 99 BB 19    STA $19BB,y[$7E:19CD]  ;} Enemy projectile VRAM graphics index = 0, palette 1
$86:DCA1 FA          PLX
$86:DCA2 60          RTS
}


;;; $DCA3: Initialisation AI - enemy projectile $DE6C (Spore Spawn's stalk) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Y offset. Unit 8px
$86:DCA3 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:DCA6 0A          ASL A                  ;|
$86:DCA7 AA          TAX                    ;|
$86:DCA8 BD B9 DC    LDA $DCB9,x[$86:DCB9]  ;} Enemy projectile Y position = [enemy 0 Y position] - 40h + [enemy projectile initialisation parameter] * 8
$86:DCAB 18          CLC                    ;|
$86:DCAC 6D 7E 0F    ADC $0F7E  [$7E:0F7E]  ;|
$86:DCAF 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:DCB2 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:DCB5 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [enemy 0 X position]
$86:DCB8 60          RTS

$86:DCB9             dw FFC0, FFC8, FFD0, FFD8, FFE0
}


;;; $DCC3: Unused. Alternate Spore Spawn stalk initialisation AI ;;;
{
; Spawns 20h px above the highest Spore Spawn stalk
; Could maybe be an abandoned version of the breaking of the ceiling, but I'm going with the unused stalk guess
$86:DCC3 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:DCC6 18          CLC                    ;|
$86:DCC7 69 A0 FF    ADC #$FFA0             ;} Enemy projectile Y position = [enemy 0 Y position] - 60h
$86:DCCA 99 93 1A    STA $1A93,y            ;/
$86:DCCD AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:DCD0 99 4B 1A    STA $1A4B,y            ;} Enemy projectile X position = [enemy 0 X position]
$86:DCD3 60          RTS
}


;;; $DCD4: Initialisation AI - enemy projectile $DE88 (spore spawner) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: X offset. Unit 40px
$86:DCD4 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:DCD7 0A          ASL A                  ;|
$86:DCD8 AA          TAX                    ;} Enemy projectile X position = 20h + [enemy projectile initialisation parameter] * 40h
$86:DCD9 BD E6 DC    LDA $DCE6,x[$86:DCE6]  ;|
$86:DCDC 99 4B 1A    STA $1A4B,y[$7E:1A65]  ;/
$86:DCDF A9 08 02    LDA #$0208             ;\
$86:DCE2 99 93 1A    STA $1A93,y[$7E:1AAD]  ;} Enemy projectile Y position = 208h
$86:DCE5 60          RTS

$86:DCE6             dw 0020, 0060, 00A0, 00E0
}


;;; $DCEE: Pre-instruction - enemy projectile $DE7A (spores) ;;;
{
$86:DCEE BD FF 1A    LDA $1AFF,x[$7E:1B11]  ;\
$86:DCF1 29 FF 00    AND #$00FF             ;} Y = [enemy projectile movement table index]
$86:DCF4 A8          TAY                    ;/
$86:DCF5 B9 6C DD    LDA $DD6C,y[$86:DD6C]  ;\
$86:DCF8 29 FF 00    AND #$00FF             ;|
$86:DCFB 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;} $12 = ±[$DD6C + [Y]]
$86:DCFF 85 12       STA $12    [$7E:0012]  ;/
$86:DD01 BD 23 1B    LDA $1B23,x[$7E:1B35]  ;\
$86:DD04 89 80 00    BIT #$0080             ;} If [enemy projectile spawn X position] >= 80h:
$86:DD07 F0 08       BEQ $08    [$DD11]     ;/
$86:DD09 A5 12       LDA $12    [$7E:0012]  ;\
$86:DD0B 49 FF FF    EOR #$FFFF             ;|
$86:DD0E 1A          INC A                  ;} Negate $12
$86:DD0F 85 12       STA $12    [$7E:0012]  ;/

$86:DD11 A5 12       LDA $12    [$7E:0012]  ;\
$86:DD13 18          CLC                    ;|
$86:DD14 7D 4B 1A    ADC $1A4B,x[$7E:1A5D]  ;} Enemy projectile X position += [$12]
$86:DD17 9D 4B 1A    STA $1A4B,x[$7E:1A5D]  ;/
$86:DD1A B9 6D DD    LDA $DD6D,y[$86:DD6D]  ;\
$86:DD1D 29 FF 00    AND #$00FF             ;|
$86:DD20 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DD24 85 12       STA $12    [$7E:0012]  ;|
$86:DD26 18          CLC                    ;} Enemy projectile Y position += ±[$DD6C + [Y] + 1] * 2
$86:DD27 7D 93 1A    ADC $1A93,x[$7E:1AA5]  ;|
$86:DD2A 18          CLC                    ;|
$86:DD2B 65 12       ADC $12    [$7E:0012]  ;|
$86:DD2D 9D 93 1A    STA $1A93,x[$7E:1AA5]  ;/
$86:DD30 C9 00 03    CMP #$0300             ;\
$86:DD33 30 03       BMI $03    [$DD38]     ;} If [enemy projectile Y position] >= 300h:
$86:DD35 9E 97 19    STZ $1997,x[$7E:19A1]  ; Enemy projectile ID = 0

$86:DD38 BD FF 1A    LDA $1AFF,x[$7E:1B11]  ;\
$86:DD3B 1A          INC A                  ;|
$86:DD3C 1A          INC A                  ;} Enemy projectile movement table index = ([enemy projectile movement table index] + 2) % 100h
$86:DD3D 29 FF 00    AND #$00FF             ;|
$86:DD40 9D FF 1A    STA $1AFF,x[$7E:1B11]  ;/
$86:DD43 60          RTS
}


;;; $DD44: RTS. Pre-instruction - enemy projectile $DE6C (Spore Spawn's stalk) ;;;
{
$86:DD44 60          RTS
}


;;; $DD45: RTS ;;;
{
$86:DD45 60          RTS
}


;;; $DD46: Pre-instruction - enemy projectile $DE88 (spore spawner) ;;;
{
$86:DD46 AF 00 90 7E LDA $7E9000[$7E:9000]  ;\
$86:DD4A F0 01       BEQ $01    [$DD4D]     ;} If spore generation disabled:
$86:DD4C 60          RTS                    ; Return

$86:DD4D BD 23 1B    LDA $1B23,x[$7E:1B3D]  ;\
$86:DD50 D0 16       BNE $16    [$DD68]     ;} If [enemy projectile spore spawn timer] = 0:
$86:DD52 A9 06 DC    LDA #$DC06             ;\
$86:DD55 9D 47 1B    STA $1B47,x[$7E:1B61]  ;} Enemy projectile instruction list pointer = $DC06 (spawn spore)
$86:DD58 A9 01 00    LDA #$0001             ;\
$86:DD5B 9D 8F 1B    STA $1B8F,x[$7E:1BA9]  ;} Enemy projectile instruction timer = 1
$86:DD5E 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:DD62 29 FF 01    AND #$01FF             ;\
$86:DD65 9D 23 1B    STA $1B23,x[$7E:1B3D]  ;} Enemy projectile spore spawn timer = [random number] % 200h

$86:DD68 DE 23 1B    DEC $1B23,x[$7E:1B3D]  ; Decrement enemy projectile spore spawn timer
$86:DD6B 60          RTS
}


;;; $DD6C: Spore movement data ;;;
{
$86:DD6C             db 00,01, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01, 01,00,
                        00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00, 00,01,
                        01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 00,01, 01,00,
                        01,00, 00,01, 01,00, 00,01, 01,00, 01,00, 00,01, 01,00,
                        01,00, 00,01, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00,
                        00,01, 01,00, 01,00, 01,00, 00,01, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 00,FF, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        00,FF, 01,00, 01,00, 00,00, FF,01, FF,01, FF,01, FF,00,
                        00,01, FF,01, FF,01, FF,00, 00,01, FF,01, FF,00, 00,01,
                        FF,00, 00,01, FF,00, 00,01, FF,00, FF,01, FF,01, FF,00,
                        00,01, FF,00, FF,01, FF,00, 00,01, FF,00, FF,01, FF,00,
                        FF,00, 00,01, FF,00, FF,00, 00,01, FF,00, FF,00, FF,00,
                        FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00, FF,00,
                        FF,00, FF,00, 00,FF, FF,00, FF,00, FF,00, FF,FF, FF,00,
                        FF,00, FF,00, 00,FF, FF,00, FF,00, FF,FF, FF,00, 00,00
}


;;; $DE6C: Enemy projectiles - Spore Spawn ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:DE6C             dx DCA3,DD44,DC2E,08,08,2000,0000,DC2E ; Spore Spawn's stalk
$86:DE7A             dx DC8D,DCEE,DC1E,02,02,8004,0000,DC34 ; Spores
$86:DE88             dx DCD4,DD46,DC00,02,02,2000,0000,DC00 ; Spore spawner
}
}


;;; $DE96..DFD7: Nami/fune fireball ;;;
{
;;; $DE96: Instruction list - nami/fune fireball - left ;;;
{
$86:DE96             dx 0005,AAB9,
                        0005,AAC0,
                        0005,AAC7,
                        81AB,DE96   ; Go to $DE96
}


;;; $DEA6: Instruction list - nami/fune fireball - right ;;;
{
$86:DEA6             dx 0005,AACE,
                        0005,AAD5,
                        0005,AADC,
                        81AB,DEA6   ; Go to $DEA6
}


;;; $DEB6: Nami/fune fireball X velocity table ;;;
{
; Left velocity, right velocity
$86:DEB6             dw FFC0,0040, FF80,0080, FF40,00C0, FF00,0100, FEC0,0140, FE80,0180, FE40,01C0, FE00,0200
}


;;; $DED6: Initialisation AI - enemy projectile $DFBC/$DFCA (nami/fune fireball) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction. 0 = left, otherwise = right
$86:DED6 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:DED9 A9 96 DE    LDA #$DE96             ;\
$86:DEDC 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $DE96 (left)
$86:DEDF A9 40 DF    LDA #$DF40             ;\
$86:DEE2 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile function = $DF40 (left)
$86:DEE5 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:DEE8 F0 0C       BEQ $0C    [$DEF6]     ;} If [enemy projectile initialisation parameter 0] != 0:
$86:DEEA A9 A6 DE    LDA #$DEA6             ;\
$86:DEED 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $DEA6 (right)
$86:DEF0 A9 6A DF    LDA #$DF6A             ;\
$86:DEF3 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile function = $DF6A (right)

$86:DEF6 BD 7A 0F    LDA $0F7A,x[$7E:10FA]  ;\
$86:DEF9 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;|
$86:DEFC BD 7C 0F    LDA $0F7C,x[$7E:10FC]  ;} Enemy projectile X position = [enemy X position]
$86:DEFF 99 27 1A    STA $1A27,y[$7E:1A49]  ;/
$86:DF02 BD 7E 0F    LDA $0F7E,x[$7E:10FE]  ;\
$86:DF05 99 93 1A    STA $1A93,y[$7E:1AB5]  ;|
$86:DF08 BD 80 0F    LDA $0F80,x[$7E:1100]  ;} Enemy projectile Y position = [enemy Y position]
$86:DF0B 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;/
$86:DF0E BD B4 0F    LDA $0FB4,x[$7E:1134]  ;\
$86:DF11 29 0F 00    AND #$000F             ;} If [enemy $0FB4] & Fh != 0:
$86:DF14 F0 0A       BEQ $0A    [$DF20]     ;/
$86:DF16 B9 93 1A    LDA $1A93,y[$7E:1AB5]  ;\
$86:DF19 18          CLC                    ;|
$86:DF1A 69 04 00    ADC #$0004             ;} Enemy projectile Y position += 4
$86:DF1D 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/

$86:DF20 BD B6 0F    LDA $0FB6,x[$7E:1136]  ;\
$86:DF23 29 FF 00    AND #$00FF             ;|
$86:DF26 0A          ASL A                  ;} X = [enemy $0FB6 low] * 4
$86:DF27 0A          ASL A                  ;|
$86:DF28 AA          TAX                    ;/
$86:DF29 BD B6 DE    LDA $DEB6,x[$86:DED2]  ;\
$86:DF2C 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile left velocity = [$DEB6 + [X]]
$86:DF2F BD B8 DE    LDA $DEB8,x[$86:DED4]  ;\
$86:DF32 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile right velocity = [$DEB6 + [X] + 2]
$86:DF35 AE 54 0E    LDX $0E54  [$7E:0E54]
$86:DF38 60          RTS
}


;;; $DF39: Pre-instruction - enemy projectile $DFBC/$DFCA (nami/fune fireball) ;;;
{
$86:DF39 FC FF 1A    JSR ($1AFF,x)[$86:DF6A]; Execute [enemy projectile function]
$86:DF3C 20 94 DF    JSR $DF94  [$86:DF94]  ; Delete enemy projectile if horizontally off screen
$86:DF3F 60          RTS
}


;;; $DF40: Nami/fune fireball function - left ;;;
{
$86:DF40 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;\
$86:DF43 29 00 FF    AND #$FF00             ;|
$86:DF46 EB          XBA                    ;|
$86:DF47 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DF4B 18          CLC                    ;|
$86:DF4C 7D 4B 1A    ADC $1A4B,x[$7E:1A6B]  ;|
$86:DF4F 9D 4B 1A    STA $1A4B,x[$7E:1A6B]  ;|
$86:DF52 BD DB 1A    LDA $1ADB,x[$7E:1AFB]  ;|
$86:DF55 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile left X velocity] / 100h
$86:DF58 EB          XBA                    ;|
$86:DF59 18          CLC                    ;|
$86:DF5A 7D 27 1A    ADC $1A27,x[$7E:1A47]  ;|
$86:DF5D 9D 27 1A    STA $1A27,x[$7E:1A47]  ;|
$86:DF60 90 07       BCC $07    [$DF69]     ;|
$86:DF62 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:DF65 1A          INC A                  ;|
$86:DF66 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/

$86:DF69 60          RTS
}


;;; $DF6A: Nami/fune fireball function - right ;;;
{
$86:DF6A BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:DF6D 29 00 FF    AND #$FF00             ;|
$86:DF70 EB          XBA                    ;|
$86:DF71 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$86:DF75 18          CLC                    ;|
$86:DF76 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]  ;|
$86:DF79 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;|
$86:DF7C BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;|
$86:DF7F 29 FF 00    AND #$00FF             ;} Enemy projectile X position += [enemy projectile right X velocity] / 100h
$86:DF82 EB          XBA                    ;|
$86:DF83 18          CLC                    ;|
$86:DF84 7D 27 1A    ADC $1A27,x[$7E:1A49]  ;|
$86:DF87 9D 27 1A    STA $1A27,x[$7E:1A49]  ;|
$86:DF8A 90 07       BCC $07    [$DF93]     ;|
$86:DF8C BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:DF8F 1A          INC A                  ;|
$86:DF90 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/

$86:DF93 60          RTS
}


;;; $DF94: Delete enemy projectile if horizontally off screen ;;;
{
$86:DF94 20 C2 DB    JSR $DBC2  [$86:DBC2]  ;\
$86:DF97 F0 06       BEQ $06    [$DF9F]     ;} If enemy projectile is horizontally off screen:
$86:DF99 A9 00 00    LDA #$0000             ;\
$86:DF9C 9D 97 19    STA $1997,x[$7E:19B9]  ;} Enemy projectile ID = 0

$86:DF9F 60          RTS
}


;;; $DFA0: Check if enemy projectile is horizontally off screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise
$86:DFA0 BD 4B 1A    LDA $1A4B,x            ;\
$86:DFA3 CD 11 09    CMP $0911  [$7E:0911]  ;|
$86:DFA6 30 10       BMI $10    [$DFB8]     ;|
$86:DFA8 AD 11 09    LDA $0911  [$7E:0911]  ;|
$86:DFAB 18          CLC                    ;} If 0 <= [enemy projectile X position] - [layer 1 X position] <= 100h:
$86:DFAC 69 00 01    ADC #$0100             ;|
$86:DFAF DD 4B 1A    CMP $1A4B,x            ;|
$86:DFB2 30 04       BMI $04    [$DFB8]     ;/
$86:DFB4 A9 00 00    LDA #$0000             ;\
$86:DFB7 60          RTS                    ;} Return A = 0

$86:DFB8 A9 01 00    LDA #$0001             ;\
$86:DFBB 60          RTS                    ;} Return A = 1
}


;;; $DFBC: Enemy projectiles - nami/fune fireball ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:DFBC             dx DED6,DF39,DE96,04,08,00C8,0000,84FC ; Nami fireball. Initial instruction list ignored
$86:DFCA             dx DED6,DF39,DE96,04,08,003C,0000,84FC ; Fune fireball. Initial instruction list ignored
}
}


;;; $DFD8..E0ED: Lava thrown by lavaman ;;;
{
;;; $DFD8: Instruction list - enemy projectile $E0E0 (lava thrown by lavaman) ;;;
{
$86:DFD8             dw 0001,AB0F,
                        8159        ; Sleep
}


;;; $DFDE: Instruction list ;;;
{
$86:DFDE             dw 0001,AB25,
                        8159        ; Sleep
}


;;; $DFE4: Shot instruction list - enemy projectile $E0E0 (lava thrown by lavaman) ;;;
{
$86:DFE4             dw DFEA,       ; Spawn enemy drops with Norfair lava creature's drop chances
                        81AB,84FC   ; Go to $84FC
}


;;; $DFEA: Instruction - spawn enemy drops with Norfair lava creature's drop chances ;;;
{
$86:DFEA 5A          PHY
$86:DFEB DA          PHX
$86:DFEC BD 4B 1A    LDA $1A4B,x[$7E:1A69]  ;\
$86:DFEF 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy projectile X position]
$86:DFF1 BD 93 1A    LDA $1A93,x[$7E:1AB1]  ;\
$86:DFF4 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile Y position]
$86:DFF6 A9 3F E8    LDA #$E83F             ; A = $E83F (Norfair lava creature)
$86:DFF9 22 0E 92 A0 JSL $A0920E[$A0:920E]  ; Spawn enemy drops
$86:DFFD FA          PLX
$86:DFFE 7A          PLY
$86:DFFF 60          RTS
}


;;; $E000: Initialisation AI - enemy projectile $E0E0 (lava thrown by lavaman) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Direction. 0 = left, otherwise = right
$86:E000 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:E003 A9 D8 DF    LDA #$DFD8             ;\
$86:E006 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $DE96 (left)
$86:E009 A9 50 E0    LDA #$E050             ;\
$86:E00C 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile function = $DF40 (left)
$86:E00F AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:E012 F0 0C       BEQ $0C    [$E020]     ;} If [enemy projectile initialisation parameter 0] != 0:
$86:E014 A9 DE DF    LDA #$DFDE             ;\
$86:E017 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $DEA6 (right)
$86:E01A A9 7A E0    LDA #$E07A             ;\
$86:E01D 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile function = $DF6A (right)

$86:E020 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$86:E023 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;|
$86:E026 BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;} Enemy projectile X position = [enemy X position]
$86:E029 99 27 1A    STA $1A27,y[$7E:1A49]  ;/
$86:E02C BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$86:E02F 18          CLC                    ;|
$86:E030 69 02 00    ADC #$0002             ;|
$86:E033 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [enemy Y position] + 2.0
$86:E036 BD 80 0F    LDA $0F80,x[$7E:1000]  ;|
$86:E039 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;/
$86:E03C A9 00 FD    LDA #$FD00             ;\
$86:E03F 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile left velocity = -300h
$86:E042 A9 00 03    LDA #$0300             ;\
$86:E045 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile right velocity = 300h
$86:E048 60          RTS
}


;;; $E049: Pre-instruction - enemy projectile $E0E0 (lava thrown by lavaman) ;;;
{
$86:E049 FC FF 1A    JSR ($1AFF,x)[$86:E07A]; Execute [enemy projectile function]
$86:E04C 20 A4 E0    JSR $E0A4  [$86:E0A4]  ; Delete enemy projectile if off screen
$86:E04F 60          RTS
}


;;; $E050: Lava thrown by lavaman function - left ;;;
{
; Clone of $DF40
$86:E050 BD DB 1A    LDA $1ADB,x[$7E:1AFD]
$86:E053 29 00 FF    AND #$FF00
$86:E056 EB          XBA
$86:E057 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$86:E05B 18          CLC
$86:E05C 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]
$86:E05F 9D 4B 1A    STA $1A4B,x[$7E:1A6D]
$86:E062 BD DB 1A    LDA $1ADB,x[$7E:1AFD]
$86:E065 29 FF 00    AND #$00FF
$86:E068 EB          XBA
$86:E069 18          CLC
$86:E06A 7D 27 1A    ADC $1A27,x[$7E:1A49]
$86:E06D 9D 27 1A    STA $1A27,x[$7E:1A49]
$86:E070 90 07       BCC $07    [$E079]
$86:E072 BD 4B 1A    LDA $1A4B,x
$86:E075 1A          INC A
$86:E076 9D 4B 1A    STA $1A4B,x

$86:E079 60          RTS
}


;;; $E07A: Lava thrown by lavaman function - right ;;;
{
; Clone of $DF6A
$86:E07A BD B7 1A    LDA $1AB7,x[$7E:1AD9]
$86:E07D 29 00 FF    AND #$FF00
$86:E080 EB          XBA
$86:E081 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$86:E085 18          CLC
$86:E086 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]
$86:E089 9D 4B 1A    STA $1A4B,x[$7E:1A6D]
$86:E08C BD B7 1A    LDA $1AB7,x[$7E:1AD9]
$86:E08F 29 FF 00    AND #$00FF
$86:E092 EB          XBA
$86:E093 18          CLC
$86:E094 7D 27 1A    ADC $1A27,x[$7E:1A49]
$86:E097 9D 27 1A    STA $1A27,x[$7E:1A49]
$86:E09A 90 07       BCC $07    [$E0A3]
$86:E09C BD 4B 1A    LDA $1A4B,x
$86:E09F 1A          INC A
$86:E0A0 9D 4B 1A    STA $1A4B,x

$86:E0A3 60          RTS
}


;;; $E0A4: Delete enemy projectile if off screen ;;;
{
; Clone of $BD1E
$86:E0A4 20 B0 E0    JSR $E0B0  [$86:E0B0]
$86:E0A7 F0 06       BEQ $06    [$E0AF]
$86:E0A9 A9 00 00    LDA #$0000
$86:E0AC 9D 97 19    STA $1997,x[$7E:19B9]

$86:E0AF 60          RTS
}


;;; $E0B0: Check if enemy projectile is off screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise

; Clone of $BD2A
$86:E0B0 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]
$86:E0B3 CD 11 09    CMP $0911  [$7E:0911]
$86:E0B6 30 24       BMI $24    [$E0DC]
$86:E0B8 AD 11 09    LDA $0911  [$7E:0911]
$86:E0BB 18          CLC
$86:E0BC 69 00 01    ADC #$0100
$86:E0BF DD 4B 1A    CMP $1A4B,x[$7E:1A6D]
$86:E0C2 30 18       BMI $18    [$E0DC]
$86:E0C4 BD 93 1A    LDA $1A93,x[$7E:1AB5]
$86:E0C7 CD 15 09    CMP $0915  [$7E:0915]
$86:E0CA 30 10       BMI $10    [$E0DC]
$86:E0CC AD 15 09    LDA $0915  [$7E:0915]
$86:E0CF 18          CLC
$86:E0D0 69 00 01    ADC #$0100
$86:E0D3 DD 93 1A    CMP $1A93,x[$7E:1AB5]
$86:E0D6 30 04       BMI $04    [$E0DC]
$86:E0D8 A9 00 00    LDA #$0000
$86:E0DB 60          RTS

$86:E0DC A9 01 00    LDA #$0001
$86:E0DF 60          RTS
}


;;; $E0E0: Enemy projectile - lava thrown by lavaman ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:E0E0             dx E000,E049,DFD8,02,02,8028,0000,DFE4 ; Lava thrown by lavaman
}
}


;;; $E0EE..E532: Explosion / dust / smoke ;;;
{
;;; $E0EE..E42B: Instruction lists ;;;
{
;;; $E0EE: Instruction list - dust cloud / explosion - index = 0 (unused. Beam charge) ;;;
{
$86:E0EE             dx 0003,AF2C,
                        0003,AF33,
                        0003,AF3A,
                        0003,AF41,
                        8154        ; Delete
}


;;; $E100: Instruction list - dust cloud / explosion - index = 1 (Mother Brain elbow charge particles) ;;;
{
$86:E100             dx 0005,AF57,
                        0004,AF68,
                        0003,AF79,
                        0003,AF8A,
                        0003,AF9B,
                        0003,AFAC,
                        8154        ; Delete
}


;;; $E11A: Instruction list - dust cloud / explosion - index = 2 (Mother Brain elbow charge energy) ;;;
{
$86:E11A             dx 0004,AFBD,
                        0003,AFCE,
                        0002,AFDF,
                        0002,AFF0,
                        0002,B001,
                        0002,B012,
                        000C,B023,
                        8154        ; Delete
}


;;; $E138: Instruction list - dust cloud / explosion - index = 3 (small explosion) ;;;
{
$86:E138             dx 0004,B023,
                        0006,B02A,
                        0005,B040,
                        0005,B056,
                        0005,B06C,
                        0006,B082,
                        8154        ; Delete
}


;;; $E152: Instruction list - dust cloud / explosion - index = 4 (unused. Bomb explosion) / enemy projectile $CBAD (Mother Brain's rainbow beam explosion) ;;;
{
$86:E152             dx 0003,B098,
                        0003,B0AE,
                        0004,B0C4,
                        0004,B0DA,
                        0004,B0F0,
                        8154        ; Delete
}


;;; $E168: Instruction list - dust cloud / explosion - index = 5 (unused. Beam trail) ;;;
{
$86:E168             dx 0008,B11C,
                        0008,B123,
                        0008,B12A,
                        0008,B131,
                        0018,AFF0,
                        8154        ; Delete
}


;;; $E17E: Instruction list - dust cloud / explosion - index = 6 (dud shot / tiny explosion) ;;;
{
$86:E17E             dx 0004,B154,
                        0004,B15B,
                        0004,B162,
                        0004,B178,
                        0004,B18E,
                        0004,B1A4,
                        8154        ; Delete
}


;;; $E198: Instruction list - dust cloud / explosion - index = 7 (unused. Power bomb) ;;;
{
$86:E198             dx 0005,B138,
                        0005,B13F,
                        0005,B146,
                        8154        ; Delete
}


;;; $E1A6: Instruction list - dust cloud / explosion - index = 8 (unused. Elevator pad) ;;;
{
$86:E1A6             dx 0001,B1BA,
                        0001,B1D0,
                        8154        ; Delete
}


;;; $E1B0: Instruction list - dust cloud / explosion - index = 9 (small dust cloud) ;;;
{
$86:E1B0             dx 0005,B218,
                        0005,B1FC,
                        0005,B203,
                        0005,B20A,
                        0005,B211,
                        8154        ; Delete
}


;;; $E1C6: Instruction list - dust cloud / explosion - index = Ah (corpse dust cloud) ;;;
{
$86:E1C6             dx 0003,B218,
                        0003,B21F,
                        0003,B226,
                        0003,B22D,
                        8154        ; Delete
}


;;; $E1D8: Instruction list - dust cloud / explosion - index = Bh (eye door sweat drop) ;;;
{
$86:E1D8             dx 0005,B234,
                        0005,B23B,
                        0005,B242,
                        0005,B249,
                        8154        ; Delete
}


;;; $E1EA: Instruction list - dust cloud / explosion - index = Ch (smoke) ;;;
{
$86:E1EA             dx 0008,B250,
                        0008,B257,
                        0008,B25E,
                        0008,B265,
                        8154        ; Delete
}


;;; $E1FC: Instruction list - dust cloud / explosion - index = 1Ch (unused. Elevator pad) ;;;
{
$86:E1FC             dx 0001,B1BA,
                        0001,B1D0,
                        81AB,E1FC   ; Go to $E1FC
}


;;; $E208: Instruction list - dust cloud / explosion - index = 1Dh (big explosion) ;;;
{
$86:E208             dx 0005,B406,
                        0005,B41C,
                        0005,B432,
                        0005,B448,
                        0005,B486,
                        0005,B4B0,
                        8154        ; Delete
}


;;; $E222: Instruction list - dust cloud / explosion - index = Dh (unused. Small health drop) ;;;
{
$86:E222             dx 0008,B281,
                        0008,B288,
                        0008,B28F,
                        0008,B296,
                        8154        ; Delete
}


;;; $E234: Instruction list - dust cloud / explosion - index = Eh (unused. Big health drop) ;;;
{
$86:E234             dx 0008,B29D,
                        0008,B2B3,
                        0008,B2C9,
                        0008,B2DF,
                        8154        ; Delete
}


;;; $E246: Instruction list - dust cloud / explosion - index = Fh (unused. Bomb) ;;;
{
$86:E246             dx 0005,B2E6,
                        0005,B2ED,
                        0005,B2F4,
                        0005,B2FB,
                        8154        ; Delete
}


;;; $E258: Instruction list - dust cloud / explosion - index = 10h (unused. Weird small health drop) ;;;
{
$86:E258             dx 0010,B3EA,
                        0010,B3F1,
                        0010,B3F8,
                        8154        ; Delete
}


;;; $E266: Instruction list - dust cloud / explosion - index = 11h (rock particles) ;;;
{
$86:E266             dx 0002,AB3B,
                        0002,AB51,
                        0002,AB67,
                        0002,AB7D,
                        0002,AB93,
                        0002,ABA9,
                        0002,ABBF,
                        0002,ABD5,
                        0002,ABEB,
                        0002,AC01,
                        0002,AC17,
                        0002,AC2D,
                        0002,AC43,
                        0002,AC59,
                        0002,AC6F,
                        0002,AC85,
                        8154        ; Delete
}


;;; $E2A8: Instruction list - dust cloud / explosion - index = 12h (short big dust cloud) ;;;
{
$86:E2A8             dx 0002,AC9B,
                        0002,ACA2,
                        0002,ACAE,
                        0002,ACBF,
                        8154        ; Delete
}


;;; $E2BA: Instruction list - dust cloud / explosion - index = 13h (unused. Short big dust cloud with weird short beam) ;;;
{
$86:E2BA             dx 0003,ACD5,
                        0003,ACEB,
                        0003,ACFC,
                        0003,AD08,
                        0003,AD0F,
                        0005,AD16,
                        8154        ; Delete
}


;;; $E2D4: Instruction list - dust cloud / explosion - index = 14h (unused. Short big dust cloud with weird medium beam) ;;;
{
$86:E2D4             dx 0003,ACD5,
                        0003,ACEB,
                        0003,ACFC,
                        0003,AD08,
                        0003,AD0F,
                        0003,AD16,
                        0003,AD1D,
                        8154        ; Delete
}


;;; $E2F2: Instruction list - dust cloud / explosion - index = 15h (big dust cloud) ;;;
{
$86:E2F2             dx 0005,AC9B,
                        0005,ACA2,
                        0005,ACAE,
                        0005,ACBF,
                        0005,ACD5,
                        0005,ACEB,
                        0005,ACFC,
                        0005,AD08,
                        8154        ; Delete
}


;;; $E314: Instruction list - dust cloud / explosion - index = 16h (unused. Weird long beam) ;;;
{
$86:E314             dx 0001,AD0F,
                        0001,AD16,
                        0001,AD1D,
                        0001,AD29,
                        0001,AD35,
                        0001,AD46,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        8154        ; Delete
}


;;; $E392: Instruction list - dust cloud / explosion - index = 17h (unused. Weird long flickering beam) ;;;
{
$86:E392             dx 0001,AD57,
                        0001,AD6D,
                        0001,AD57,
                        8154        ; Delete
}


;;; $E3A0: Instruction list - dust cloud / explosion - index = 18h (long Draygon breath bubbles) ;;;
{
$86:E3A0             dx 0008,AD83,
                        0008,AD8A,
                        0008,AD9B,
                        0008,ADAC,
                        0008,ADBD,
                        0008,ADCE,
                        0008,ADDF,
                        0008,ADF0,
                        0008,ADFC,
                        8154        ; Delete
}


;;; $E3C6: Instruction list - dust cloud / explosion - index = 19h (unused. Save station electricity) ;;;
{
$86:E3C6             dx 0001,AE03,
                        0001,AE19,
                        0001,AE2F,
                        0001,AE45,
                        0001,AE5B,
                        0001,AE71,
                        0001,AE87,
                        0001,AE9D,
                        8154        ; Delete
}


;;; $E3E8: Instruction list - dust cloud / explosion - index = 1Ah (unused. Expanding vertical gate) ;;;
{
$86:E3E8             dx 0010,AEB3,
                        0010,AEBF,
                        0010,AEC6,
                        0010,AED2,
                        0010,AEDE,
                        0010,AEEF,
                        0010,AF00,
                        0010,AF16,
                        8154        ; Delete
}


;;; $E40A: Instruction list - dust cloud / explosion - index = 1Bh (unused. Contracting vertical gate) ;;;
{
$86:E40A             dx 0004,AF16,
                        0004,AF00,
                        0004,AEEF,
                        0004,AEDE,
                        0004,AED2,
                        0004,AEC6,
                        0004,AEBF,
                        0004,AEB3,
                        8154        ; Delete
}
}


;;; $E42C: Dust cloud / explosion instruction list pointers ;;;
{
$86:E42C             dw E0EE, E100, E11A, E138, E152, E168, E17E, E198, E1A6, E1B0, E1C6, E1D8, E1EA, E222, E234, E246,
                        E258, E266, E2A8, E2BA, E2D4, E2F2, E314, E392, E3A0, E3C6, E3E8, E40A, E1FC, E208
}


;;; $E468: Initialisation AI - enemy projectile $E509/$E525 (dust cloud / explosion) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Index. Range 0..1Dh. Same animations as sprite objects 0..1Dh
       {
;;         0: Unused. Beam charge
;;         1: Mother Brain elbow charge particles
;;         2: Mother Brain elbow charge energy
;;         3: Small explosion
;;         4: Unused. Bomb explosion
;;         5: Unused. Beam trail
;;         6: Dud shot
;;         7: Unused. Power bomb
;;         8: Unused. Elevator pad (same as 1Ch)
;;         9: Small dust cloud
;;         Ah: Corpse dust cloud
;;         Bh: Eye door sweat drop
;;         Ch: Smoke
;;         Dh: Unused. Small health drop
;;         Eh: Unused. Big health drop
;;         Fh: Unused. Bomb
;;         10h: Unused. Weird small health drop
;;         11h: Rock particles
;;         12h: Short big dust cloud
;;         13h: Unused. Short big dust cloud with weird short beam
;;         14h: Unused. Short big dust cloud with weird medium beam
;;         15h: Big dust cloud
;;         16h: Unused. Weird long beam
;;         17h: Unused. Weird long flickering beam
;;         18h: Long Draygon breath bubbles
;;         19h: Unused. Save station electricity
;;         1Ah: Unused. Expanding vertical gate
;;         1Bh: Unused. Contracting vertical gate
;;         1Ch: Unused. Elevator pad (same as 8)
;;         1Dh: Big explosion
       }
;;     $12: X position
;;     $14: Y position
$86:E468 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:E46B 0A          ASL A                  ;|
$86:E46C AA          TAX                    ;} Enemy projectile instruction list pointer = [$E42C + [enemy projectile initialisation parameter] * 2]
$86:E46D BD 2C E4    LDA $E42C,x[$86:E43E]  ;|
$86:E470 99 47 1B    STA $1B47,y[$7E:1B69]  ;/
$86:E473 A5 12       LDA $12    [$7E:0012]  ;\
$86:E475 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [$12]
$86:E478 A5 14       LDA $14    [$7E:0014]  ;\
$86:E47A 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [$14]
$86:E47D 60          RTS
}


;;; $E47E: PLM dust cloud / explosion X/Y offset table ;;;
{
;                        __________________ Random X offset range
;                       |     _____________ Random Y offset range
;                       |    |     ________ Minimum X offset
;                       |    |    |     ___ Minimum Y offset
;                       |    |    |    |
$86:E47E             dw 0000,0000,0000,0000,
                        0007,0007,FFFC,FFFC,
                        000F,000F,FFF8,FFF8,
                        000F,001F,FFF8,FFF0,
                        001F,003F,FFF0,FFE0
}


;;; $E4A6: Initialisation AI - enemy projectile $E517 (PLM dust cloud / explosion) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993 low: Index. Range 0..1Dh. Only Ah (corpse dust cloud) and Bh (eye door sweat drop) are used. See $E468 for other values
;;     $1993 high: X/Y offset table index. Range 0..4. Only 0 and 3 are used
$86:E4A6 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:E4A9 29 FF 00    AND #$00FF             ;|
$86:E4AC 0A          ASL A                  ;|
$86:E4AD AA          TAX                    ;} Enemy projectile instruction list pointer = [$E42C + [enemy projectile initialisation parameter low] * 2]
$86:E4AE BD 2C E4    LDA $E42C,x[$86:E440]  ;|
$86:E4B1 99 47 1B    STA $1B47,y[$7E:1B69]  ;/
$86:E4B4 AD 94 19    LDA $1994  [$7E:1994]  ;\
$86:E4B7 29 FF 00    AND #$00FF             ;|
$86:E4BA 0A          ASL A                  ;|
$86:E4BB 0A          ASL A                  ;} X = [enemy projectile initialisation parameter high] * 8
$86:E4BC 0A          ASL A                  ;|
$86:E4BD AA          TAX                    ;/
$86:E4BE AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:E4C1 3D 7E E4    AND $E47E,x[$86:E496]  ;|
$86:E4C4 18          CLC                    ;} $12 = [$E47E + [X] + 4] + [random number low] % ([$E47E + [X]] + 1)
$86:E4C5 7D 82 E4    ADC $E482,x[$86:E49A]  ;|
$86:E4C8 85 12       STA $12    [$7E:0012]  ;/
$86:E4CA AD E6 05    LDA $05E6  [$7E:05E6]  ;\
$86:E4CD 3D 80 E4    AND $E480,x[$86:E498]  ;|
$86:E4D0 18          CLC                    ;} $14 = [$E47E + [X] + 6] + [random number high] % ([$E47E + [X] + 2] + 1)
$86:E4D1 7D 84 E4    ADC $E484,x[$86:E49C]  ;|
$86:E4D4 85 14       STA $14    [$7E:0014]  ;/
$86:E4D6 AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:E4D9 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:E4DD AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:E4E0 38          SEC                    ;|
$86:E4E1 2A          ROL A                  ;|
$86:E4E2 0A          ASL A                  ;|
$86:E4E3 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h + 8 + [$12]
$86:E4E4 0A          ASL A                  ;|
$86:E4E5 18          CLC                    ;|
$86:E4E6 65 12       ADC $12    [$7E:0012]  ;|
$86:E4E8 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:E4EB AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:E4EE 38          SEC                    ;|
$86:E4EF 2A          ROL A                  ;|
$86:E4F0 0A          ASL A                  ;|
$86:E4F1 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h + 8 + [$14]
$86:E4F2 0A          ASL A                  ;|
$86:E4F3 18          CLC                    ;|
$86:E4F4 65 14       ADC $14    [$7E:0014]  ;|
$86:E4F6 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:E4F9 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:E4FD 60          RTS
}


;;; $E4FE: Pre-instruction - enemy projectile $E509 (dust cloud / explosion) ;;;
{
$86:E4FE 20 E0 E6    JSR $E6E0  [$86:E6E0]  ;\
$86:E501 D0 01       BNE $01    [$E504]     ;} If enemy projectile is not off screen:
$86:E503 60          RTS                    ; Return

$86:E504 9E 97 19    STZ $1997,x[$7E:19B5]  ; Enemy projectile ID = 0
$86:E507 60          RTS
}


;;; $E508: RTS. Pre-instruction - enemy projectile $E517 (PLM dust cloud / explosion) ;;;
{
$86:E508 60          RTS
}


;;; $E509: Enemy projectiles - dust cloud / explosion ;;;
{
; Enemy projectile $E525 is broken due to its bogus pre-instruction pointer and is otherwise just a low priority version of $E509
; Only difference between $E509 and $E517 is the former deletes itself once off-screen and takes position parameters in $12/$14,
; and the latter places itself at the current PLM block and takes a random X/Y offset parameter

;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:E509             dx E468,E4FE,E0EE,00,00,1000,0000,84FC ; Dust cloud / explosion. Initial instruction list ignored
$86:E517             dx E4A6,E508,E138,00,00,0000,0000,84FC ; PLM dust cloud / explosion. Initial instruction list ignored
$86:E525             dx E468,A197,E138,00,00,0000,0000,84FC ; Unused. Initial instruction list ignored
}
}


;;; $E533..E682: Shot gates ;;;
{
;;; $E533: Instruction - enemy projectile Y velocity = [[Y]] ;;;
{
$86:E533 B9 00 00    LDA $0000,y[$86:E560]  ;\
$86:E536 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;} Enemy projectile Y velocity = [[Y]]
$86:E539 C8          INY                    ;\
$86:E53A C8          INY                    ;} Y += 2
$86:E53B 60          RTS
}


;;; $E53C: Instruction list - enemy projectile $E64B (spawned downwards shot gate) ;;;
{
$86:E53C             dx E533,0100,  ; Enemy projectile Y velocity = 100h
                        8161,E605,  ; Pre-instruction = $E605 (moving)
                        0001,B4EE,
                        8159,       ; Sleep
                        0001,B4F5,
                        8159,       ; Sleep
                        0001,B501,
                        8159,       ; Sleep
                        0001,B512,
                        8159,       ; Sleep
                        816A        ; Clear pre-instruction
}


;;; $E55E: Instruction list - enemy projectile $E659 (initial closed downwards shot gate) ;;;
{
$86:E55E             dx E533,FF00,  ; Enemy projectile Y velocity = -100h
                        0001,B512,
                        8159,       ; Sleep
                        8161,E605,  ; Pre-instruction = $E605 (moving)
                        0001,B512,
                        8159,       ; Sleep
                        0001,B501,
                        8159,       ; Sleep
                        0001,B4F5,
                        8159,       ; Sleep
                        0001,B4EE,
                        8159,       ; Sleep
                        8154        ; Delete
}


;;; $E586: Instruction list - enemy projectile $E667 (spawned upwards shot gate) ;;;
{
$86:E586             dx E533,FF00,  ; Enemy projectile Y velocity = -100h
                        8161,E605,  ; Pre-instruction = $E605 (moving)
                        0001,B528,
                        8159,       ; Sleep
                        0001,B52F,
                        8159,       ; Sleep
                        0001,B53B,
                        8159,       ; Sleep
                        0001,B54C,
                        8159,       ; Sleep
                        816A        ; Clear pre-instruction
}


;;; $E5A8: Instruction list - enemy projectile $E675 (initial closed upwards shot gate) ;;;
{
$86:E5A8             dx E533,0100,  ; Enemy projectile Y velocity = 100h
                        0001,B54C,
                        8159,       ; Sleep
                        8161,E605,  ; Pre-instruction = $E605 (moving)
                        0001,B54C,
                        8159,       ; Sleep
                        0001,B53B,
                        8159,       ; Sleep
                        0001,B52F,
                        8159,       ; Sleep
                        0001,B528,
                        8159,       ; Sleep
                        8154        ; Delete
}


;;; $E5D0: Initialisation AI - enemy projectile $E64B/$E667 (spawned shot gate) ;;;
{
$86:E5D0 A9 00 00    LDA #$0000             ; A = 0 (Y offset)
$86:E5D3 80 08       BRA $08    [$E5DD]     ; Go to shot gate common initialisation
}


;;; $E5D5: Initialisation AI - enemy projectile $E659 (initial closed downwards shot gate) ;;;
{
$86:E5D5 A9 40 00    LDA #$0040             ; A = 40h (Y offset)
$86:E5D8 80 03       BRA $03    [$E5DD]     ; Go to shot gate common initialisation
}


;;; $E5DA: Initialisation AI - enemy projectile $E675 (initial closed upwards shot gate) ;;;
{
$86:E5DA A9 C0 FF    LDA #$FFC0             ; A = -40h (Y offset)
}


;;; $E5DD: Shot gate common initialisation ;;;
{
$86:E5DD 85 12       STA $12    [$7E:0012]  ; $12 = [A]
$86:E5DF AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:E5E2 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:E5E6 BD 87 1C    LDA $1C87,x[$7E:1CD5]  ;\
$86:E5E9 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile PLM block index = [PLM block index]
$86:E5EC AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:E5EF 0A          ASL A                  ;|
$86:E5F0 0A          ASL A                  ;|
$86:E5F1 0A          ASL A                  ;} Enemy projectile X position = [PLM X block] * 10h
$86:E5F2 0A          ASL A                  ;|
$86:E5F3 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:E5F6 AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:E5F9 0A          ASL A                  ;|
$86:E5FA 0A          ASL A                  ;|
$86:E5FB 0A          ASL A                  ;|
$86:E5FC 0A          ASL A                  ;} Enemy projectile Y position = [PLM Y block] * 10h + [$12]
$86:E5FD 18          CLC                    ;|
$86:E5FE 65 12       ADC $12    [$7E:0012]  ;|
$86:E600 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:E603 60          RTS
}


;;; $E604: RTS. Pre-instruction - enemy projectile $E64B/$E659/$E667/$E675 (shot gate) ;;;
{
$86:E604 60          RTS
}


;;; $E605: Pre-instruction - moving ;;;
{
$86:E605 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:E608 10 04       BPL $04    [$E60E]     ;|
$86:E60A 49 FF FF    EOR #$FFFF             ;|
$86:E60D 1A          INC A                  ;} Enemy projectile segment distance moved += |[enemy projectile Y velocity]|
                                            ;|
$86:E60E 18          CLC                    ;|
$86:E60F 7D DF 19    ADC $19DF,x[$7E:1A01]  ;/
$86:E612 C9 00 10    CMP #$1000             ;\
$86:E615 90 0F       BCC $0F    [$E626]     ;} If [enemy projectile segment distance moved] >= 1000h:
$86:E617 A9 01 00    LDA #$0001             ;\
$86:E61A 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Projectile instruction delay = 1
$86:E61D FE 47 1B    INC $1B47,x[$7E:1B69]  ;\
$86:E620 FE 47 1B    INC $1B47,x[$7E:1B69]  ;} Projectile instruction += 2 (break from wait)
$86:E623 A9 00 00    LDA #$0000             ; Enemy projectile segment distance moved = 0

$86:E626 9D DF 19    STA $19DF,x[$7E:1A01]
$86:E629 BD DA 1A    LDA $1ADA,x[$7E:1AFC]  ;\
$86:E62C 29 00 FF    AND #$FF00             ;|
$86:E62F 18          CLC                    ;} Enemy projectile Y subposition += [enemy projectile Y velocity] * 100h <-- always 0
$86:E630 7D 6F 1A    ADC $1A6F,x[$7E:1A91]  ;|
$86:E633 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;/
$86:E636 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:E639 EB          XBA                    ;|
$86:E63A 10 05       BPL $05    [$E641]     ;|
$86:E63C 09 00 FF    ORA #$FF00             ;|
$86:E63F 80 03       BRA $03    [$E644]     ;|
                                            ;} Enemy projectile Y position += [enemy projectile Y velocity] / 100h
$86:E641 29 FF 00    AND #$00FF             ;|
                                            ;|
$86:E644 7D 93 1A    ADC $1A93,x[$7E:1AB5]  ;|
$86:E647 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:E64A 60          RTS
}


;;; $E64B: Enemy projectiles - shot gates ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Touch AI
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:E64B             dx E5D0,E604,E53C,00,00,2000,0000,84FC ; Spawned downwards shot gate
$86:E659             dx E5D5,E604,E55E,00,00,2000,0000,84FC ; Initial closed downwards shot gate
$86:E667             dx E5D0,E604,E586,00,00,2000,0000,84FC ; Spawned upwards shot gate
$86:E675             dx E5DA,E604,E5A8,00,00,2000,0000,84FC ; Initial closed upwards shot gate
}
}


;;; $E683..DF: Save station electricity ;;;
{
;;; $E683: Instruction list - enemy projectile $E6D2 (save station electricity) ;;;
{
$86:E683             dx 81D5,0014   ; Timer = 14h
$86:E687             dx 0001,B562,
                        0001,B578,
                        0001,B58E,
                        0001,B5A4,
                        0001,B5BA,
                        0001,B5D0,
                        0001,B5E6,
                        0001,B5FC,
                        81C6,E687,  ; Decrement timer and go to $E687 if non-zero
                        8154        ; Delete
}


;;; $E6AD: Initialisation AI - enemy projectile $E6D2 (save station electricity) ;;;
{
$86:E6AD AE 27 1C    LDX $1C27  [$7E:1C27]  ;\
$86:E6B0 22 90 82 84 JSL $848290[$84:8290]  ;} Calculate PLM block co-ordinates
$86:E6B4 AD 29 1C    LDA $1C29  [$7E:1C29]  ;\
$86:E6B7 18          CLC                    ;|
$86:E6B8 69 01 00    ADC #$0001             ;|
$86:E6BB 0A          ASL A                  ;|
$86:E6BC 0A          ASL A                  ;} Enemy projectile X position = ([PLM X block] + 1) * 10h
$86:E6BD 0A          ASL A                  ;|
$86:E6BE 0A          ASL A                  ;|
$86:E6BF 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;/
$86:E6C2 AD 2B 1C    LDA $1C2B  [$7E:1C2B]  ;\
$86:E6C5 38          SEC                    ;|
$86:E6C6 E9 02 00    SBC #$0002             ;|
$86:E6C9 0A          ASL A                  ;|
$86:E6CA 0A          ASL A                  ;} Enemy projectile Y position = ([PLM Y block] - 2) * 10h
$86:E6CB 0A          ASL A                  ;|
$86:E6CC 0A          ASL A                  ;|
$86:E6CD 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:E6D0 60          RTS
}


;;; $E6D1: RTS. Pre-instruction - enemy projectile $E6D2 (save station electricity) ;;;
{
$86:E6D1 60          RTS
}


;;; $E6D2: Enemy projectile - save station electricity ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:E6D2             dx E6AD,E6D1,E683,00,00,3000,0000,84FC ; Save station electricity
}
}


;;; $E6E0: Check if enemy projectile is off screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise
$86:E6E0 DA          PHX
$86:E6E1 5A          PHY
$86:E6E2 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:E6E5 CD 11 09    CMP $0911  [$7E:0911]  ;|
$86:E6E8 30 32       BMI $32    [$E71C]     ;|
$86:E6EA AD 11 09    LDA $0911  [$7E:0911]  ;|
$86:E6ED 18          CLC                    ;|
$86:E6EE 69 00 01    ADC #$0100             ;} If 0 <= [enemy projectile X position] - [layer 1 X position] < 100h:
$86:E6F1 8D 20 0E    STA $0E20  [$7E:0E20]  ;|
$86:E6F4 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:E6F7 CD 20 0E    CMP $0E20  [$7E:0E20]  ;|
$86:E6FA 10 20       BPL $20    [$E71C]     ;/
$86:E6FC BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:E6FF CD 15 09    CMP $0915  [$7E:0915]  ;|
$86:E702 30 18       BMI $18    [$E71C]     ;|
$86:E704 AD 15 09    LDA $0915  [$7E:0915]  ;|
$86:E707 18          CLC                    ;|
$86:E708 69 00 01    ADC #$0100             ;} If 0 <= [enemy projectile Y position] - [layer 1 Y position] < 100h:
$86:E70B 8D 20 0E    STA $0E20  [$7E:0E20]  ;|
$86:E70E BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:E711 CD 20 0E    CMP $0E20  [$7E:0E20]  ;|
$86:E714 10 06       BPL $06    [$E71C]     ;/
$86:E716 7A          PLY
$86:E717 FA          PLX
$86:E718 A9 00 00    LDA #$0000             ;\
$86:E71B 60          RTS                    ;} Return A = 0

$86:E71C 7A          PLY
$86:E71D FA          PLX
$86:E71E A9 01 00    LDA #$0001             ;\
$86:E721 60          RTS                    ;} Return A = 1
}


;;; $E722: Check if enemy projectile is in Draygon room boundaries ;;;
{
;; Returns:
;;     A: 1 if out of Draygon room boundaries, 0 otherwise
$86:E722 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:E725 30 13       BMI $13    [$E73A]     ;|
$86:E727 C9 00 02    CMP #$0200             ;} If 0 <= [enemy projectile X position] < 200h:
$86:E72A 10 0E       BPL $0E    [$E73A]     ;/
$86:E72C BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:E72F 30 09       BMI $09    [$E73A]     ;|
$86:E731 C9 00 02    CMP #$0200             ;} If 0 <= [enemy projectile Y position] < 200h:
$86:E734 10 04       BPL $04    [$E73A]     ;/
$86:E736 A9 00 00    LDA #$0000             ;\
$86:E739 60          RTS                    ;} Return A = 0

$86:E73A A9 01 00    LDA #$0001             ;\
$86:E73D 60          RTS                    ;} Return A = 1
}


;;; $E73E: Move enemy projectile according to enemy projectile angle and speed ;;;
{
; Uses enemy projectile $1AB7 as X speed
; Uses enemy projectile $1AFF as X subspeed
; Uses enemy projectile $1ADB as Y speed
; Uses enemy projectile $1B23 as Y subspeed
; Uses enemy projectile $1A27 as X subposition
; Uses enemy projectile $1A6F as Y subposition
; Uses enemy projectile $7E:97DC(!) as angle
$86:E73E DA          PHX
$86:E73F BF DC 97 7E LDA $7E97DC,x[$7E:97E4];\
$86:E743 18          CLC                    ;|
$86:E744 69 40 00    ADC #$0040             ;} If ([enemy projectile angle] + 40h) % 100h < 80h:
$86:E747 89 80 00    BIT #$0080             ;|
$86:E74A D0 15       BNE $15    [$E761]     ;/
$86:E74C BD 27 1A    LDA $1A27,x[$7E:1A29]  ;\
$86:E74F 18          CLC                    ;|
$86:E750 7D FF 1A    ADC $1AFF,x[$7E:1B01]  ;|
$86:E753 9D 27 1A    STA $1A27,x[$7E:1A29]  ;} Enemy projectile X position += [enemy projectile X speed]
$86:E756 BD 4B 1A    LDA $1A4B,x[$7E:1A4D]  ;|
$86:E759 7D B7 1A    ADC $1AB7,x[$7E:1AB9]  ;|
$86:E75C 9D 4B 1A    STA $1A4B,x[$7E:1A4D]  ;/
$86:E75F 80 13       BRA $13    [$E774]

$86:E761 BD 27 1A    LDA $1A27,x[$7E:1A2F]  ;\ Else (([enemy projectile angle] + 40h) % 100h >= 80h):
$86:E764 38          SEC                    ;|
$86:E765 FD FF 1A    SBC $1AFF,x[$7E:1B07]  ;|
$86:E768 9D 27 1A    STA $1A27,x[$7E:1A2F]  ;} Enemy projectile X position -= [enemy projectile X speed]
$86:E76B BD 4B 1A    LDA $1A4B,x[$7E:1A53]  ;|
$86:E76E FD B7 1A    SBC $1AB7,x[$7E:1ABF]  ;|
$86:E771 9D 4B 1A    STA $1A4B,x[$7E:1A53]  ;/

$86:E774 BF DC 97 7E LDA $7E97DC,x[$7E:97E4];\
$86:E778 18          CLC                    ;|
$86:E779 69 80 00    ADC #$0080             ;} If [enemy projectile angle] >= 80h:
$86:E77C 89 80 00    BIT #$0080             ;|
$86:E77F D0 15       BNE $15    [$E796]     ;/
$86:E781 BD 6F 1A    LDA $1A6F,x[$7E:1A73]  ;\
$86:E784 18          CLC                    ;|
$86:E785 7D 23 1B    ADC $1B23,x[$7E:1B27]  ;|
$86:E788 9D 6F 1A    STA $1A6F,x[$7E:1A73]  ;} Enemy projectile Y position += [enemy projectile Y speed]
$86:E78B BD 93 1A    LDA $1A93,x[$7E:1A97]  ;|
$86:E78E 7D DB 1A    ADC $1ADB,x[$7E:1ADF]  ;|
$86:E791 9D 93 1A    STA $1A93,x[$7E:1A97]  ;/
$86:E794 80 13       BRA $13    [$E7A9]

$86:E796 BD 6F 1A    LDA $1A6F,x[$7E:1A77]  ;\ Else ([enemy projectile angle] < 80h):
$86:E799 38          SEC                    ;|
$86:E79A FD 23 1B    SBC $1B23,x[$7E:1B2B]  ;|
$86:E79D 9D 6F 1A    STA $1A6F,x[$7E:1A77]  ;} Enemy projectile Y position -= [enemy projectile Y speed]
$86:E7A0 BD 93 1A    LDA $1A93,x[$7E:1A9B]  ;|
$86:E7A3 FD DB 1A    SBC $1ADB,x[$7E:1AE3]  ;|
$86:E7A6 9D 93 1A    STA $1A93,x[$7E:1A9B]  ;/

$86:E7A9 FA          PLX
$86:E7AA 60          RTS
}


;;; $E7AB: Place and aim Draygon's wall turret projectile ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $12: X position
;;     $14: Y position
;;     $1993: Speed

; Uses enemy projectile $1AB7 as X speed
; Uses enemy projectile $1AFF as X subspeed
; Uses enemy projectile $1ADB as Y speed
; Uses enemy projectile $1B23 as Y subspeed
$86:E7AB BB          TYX                    ; X = [Y]
$86:E7AC A5 12       LDA $12    [$7E:0012]  ;\
$86:E7AE 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [$12]
$86:E7B1 A5 14       LDA $14    [$7E:0014]  ;\
$86:E7B3 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [$14]
$86:E7B6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:E7B9 38          SEC                    ;|
$86:E7BA F9 4B 1A    SBC $1A4B,y[$7E:1A6D]  ;} $12 = [Samus X position] - [enemy projectile X position]
$86:E7BD 85 12       STA $12    [$7E:0012]  ;/
$86:E7BF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:E7C2 38          SEC                    ;|
$86:E7C3 F9 93 1A    SBC $1A93,y[$7E:1AB5]  ;} $14 = [Samus Y position] - [enemy projectile Y position]
$86:E7C6 85 14       STA $14    [$7E:0014]  ;/
$86:E7C8 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ; A = angle of ([$12], [$14]) offset
$86:E7CC 49 FF 00    EOR #$00FF             ;\
$86:E7CF 1A          INC A                  ;|
$86:E7D0 18          CLC                    ;|
$86:E7D1 69 40 00    ADC #$0040             ;} $12 = enemy projectile angle = (40h - [A]) % 100h
$86:E7D4 29 FF 00    AND #$00FF             ;|
$86:E7D7 9F DC 97 7E STA $7E97DC,x[$7E:97FE];|
$86:E7DB 85 12       STA $12    [$7E:0012]  ;/
$86:E7DD AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:E7E0 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile initialisation parameter]
$86:E7E2 22 43 B6 A0 JSL $A0B643[$A0:B643]  ; ($16.$18, $1A.$1C) = ([$14] * |cos([$12] * pi / 80h)|, [$14] * |sin([$12] * pi / 80h)|)
$86:E7E6 A5 16       LDA $16    [$7E:0016]  ;\
$86:E7E8 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;|
$86:E7EB A5 18       LDA $18    [$7E:0018]  ;} Enemy projectile X speed = [$16].[$18]
$86:E7ED 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$86:E7F0 A5 1A       LDA $1A    [$7E:001A]  ;\
$86:E7F2 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;|
$86:E7F5 A5 1C       LDA $1C    [$7E:001C]  ;} Enemy projectile Y speed = [$1A].[$1C]
$86:E7F7 99 23 1B    STA $1B23,y[$7E:1B45]  ;/
$86:E7FA 60          RTS
}


;;; $E7FB..EBAD: Botwoon's body ;;;
{
;;; $E7FB..E8C2: Body segment instruction lists ;;;
{
;;; $E7FB: Unused. Instruction list - body segment - up (facing left) ;;;
{
$86:E7FB             dx 0008,B612,
                        0008,B619,
                        0008,B620,
                        0008,B627,
                        81AB,E7FB   ; Go to $E7FB
}


;;; $E80F: Instruction list - body segment - up-left ;;;
{
$86:E80F             dx 0008,B62E,
                        0008,B635,
                        0008,B63C,
                        0008,B643,
                        81AB,E80F   ; Go to $E80F
}


;;; $E823: Instruction list - body segment - left ;;;
{
$86:E823             dx 0008,B64A,
                        0008,B651,
                        0008,B658,
                        0008,B65F,
                        81AB,E823   ; Go to $E823
}


;;; $E837: Instruction list - body segment - down-left ;;;
{
$86:E837             dx 0008,B666,
                        0008,B66D,
                        0008,B674,
                        0008,B67B,
                        81AB,E837   ; Go to $E837
}


;;; $E84B: Unused. Instruction list - body segment - down (facing left) ;;;
{
$86:E84B             dx 0008,B682,
                        0008,B689,
                        0008,B690,
                        0008,B697,
                        81AB,E84B   ; Go to $E84B
}


;;; $E85F: Instruction list - body segment - down (facing right) ;;;
{
$86:E85F             dx 0008,B69E,
                        0008,B6A5,
                        0008,B6AC,
                        0008,B6B3,
                        81AB,E85F   ; Go to $E85F
}


;;; $E873: Instruction list - body segment - down-right ;;;
{
$86:E873             dx 0008,B6BA,
                        0008,B6C1,
                        0008,B6C8,
                        0008,B6CF,
                        81AB,E873   ; Go to $E873
}


;;; $E887: Instruction list - body segment - right ;;;
{
$86:E887             dx 0008,B6D6,
                        0008,B6DD,
                        0008,B6E4,
                        0008,B6EB,
                        81AB,E887   ; Go to $E887
}


;;; $E89B: Instruction list - body segment - up-right ;;;
{
$86:E89B             dx 0008,B6F2,
                        0008,B6F9,
                        0008,B700,
                        0008,B707,
                        81AB,E89B   ; Go to $E89B
}


;;; $E8AF: Instruction list - body segment - up (facing right) ;;;
{
$86:E8AF             dx 0008,B70E,
                        0008,B715,
                        0008,B71C,
                        0008,B723,
                        81AB,E8AF   ; Go to $E8AF
}
}


;;; $E8C3..F2: Tail instruction lists ;;;
{
;;; $E8C3: Instruction list - tail - up (facing right) ;;;
{
$86:E8C3             dx 0001,B72A,
                        8159        ; Sleep
}


;;; $E8C9: Instruction list - tail - up-left ;;;
{
$86:E8C9             dx 0001,B731,
                        8159        ; Sleep
}


;;; $E8CF: Instruction list - tail - left ;;;
{
$86:E8CF             dx 0001,B738,
                        8159        ; Sleep
}


;;; $E8D5: Instruction list - tail - down-left ;;;
{
$86:E8D5             dx 0001,B73F,
                        8159        ; Sleep
}


;;; $E8DB: Instruction list - tail - down ;;;
{
$86:E8DB             dx 0001,B746,
                        8159        ; Sleep
}


;;; $E8E1: Instruction list - tail - down-right ;;;
{
$86:E8E1             dx 0001,B74D,
                        8159        ; Sleep
}


;;; $E8E7: Instruction list - tail - right ;;;
{
$86:E8E7             dx 0001,B754,
                        8159        ; Sleep
}


;;; $E8ED: Instruction list - tail - up-right ;;;
{
$86:E8ED             dx 0001,B75B,
                        8159        ; Sleep
}
}


;;; $E8F3: Instruction list - hidden ;;;
{
$86:E8F3             dx 0001,B8B2,
                        8159        ; Sleep
}


;;; $E8F9..E9F0: Unused instruction lists ;;;
{
;;; $E8F9: Unused. Instruction list ;;;
{
$86:E8F9             dx 0008,B762,
                        0008,B769,
                        0008,B770,
                        0008,B777,
                        81AB,E8F9   ; Go to $E8F9
}


;;; $E90D: Unused. Instruction list ;;;
{
$86:E90D             dx 0008,B77E,
                        0008,B785,
                        0008,B78C,
                        0008,B793,
                        81AB,E90D   ; Go to $E90D
}


;;; $E921: Unused. Instruction list ;;;
{
$86:E921             dx 0008,B79A,
                        0008,B7A1,
                        0008,B7A8,
                        0008,B7AF,
                        81AB,E921   ; Go to $E921
}


;;; $E935: Unused. Instruction list ;;;
{
$86:E935             dx 0008,B7B6,
                        0008,B7BD,
                        0008,B7C4,
                        0008,B7CB,
                        81AB,E935   ; Go to $E935
}


;;; $E949: Unused. Instruction list ;;;
{
$86:E949             dx 0008,B7D2,
                        0008,B7D9,
                        0008,B7E0,
                        0008,B7E7,
                        81AB,E949   ; Go to $E949
}


;;; $E95D: Unused. Instruction list ;;;
{
$86:E95D             dx 0008,B7EE,
                        0008,B7F5,
                        0008,B7FC,
                        0008,B803,
                        81AB,E95D   ; Go to $E95D
}


;;; $E971: Unused. Instruction list ;;;
{
$86:E971             dx 0008,B80A,
                        0008,B811,
                        0008,B818,
                        0008,B81F,
                        81AB,E971   ; Go to $E971
}


;;; $E985: Unused. Instruction list ;;;
{
$86:E985             dx 0008,B826,
                        0008,B82D,
                        0008,B834,
                        0008,B83B,
                        81AB,E985   ; Go to $E985
}


;;; $E999: Unused. Instruction list ;;;
{
$86:E999             dx 0008,B842,
                        0008,B849,
                        0008,B850,
                        0008,B857,
                        81AB,E999   ; Go to $E999
}


;;; $E9AD: Unused. Instruction list ;;;
{
$86:E9AD             dx 0008,B85E,
                        0008,B865,
                        0008,B86C,
                        0008,B873,
                        81AB,E9AD   ; Go to $E9AD
}


;;; $E9C1: Unused. Instruction list ;;;
{
$86:E9C1             dx 0001,B87A,
                        8159        ; Sleep
}


;;; $E9C7: Unused. Instruction list ;;;
{
$86:E9C7             dx 0001,B881,
                        8159        ; Sleep
}


;;; $E9CD: Unused. Instruction list ;;;
{
$86:E9CD             dx 0001,B888,
                        8159        ; Sleep
}


;;; $E9D3: Unused. Instruction list ;;;
{
$86:E9D3             dx 0001,B88F,
                        8159        ; Sleep
}


;;; $E9D9: Unused. Instruction list ;;;
{
$86:E9D9             dx 0001,B896,
                        8159        ; Sleep
}


;;; $E9DF: Unused. Instruction list ;;;
{
$86:E9DF             dx 0001,B89D,
                        8159        ; Sleep
}


;;; $E9E5: Unused. Instruction list ;;;
{
$86:E9E5             dx 0001,B8A4,
                        8159        ; Sleep
}


;;; $E9EB: Unused. Instruction list ;;;
{
$86:E9EB             dx 0001,B8AB,
                        8159        ; Sleep
}
}


;;; $E9F1: Botwoon's body instruction list table ;;;
{
;                        _____________________________________________ Up (facing right)
;                       |      _______________________________________ Up-right
;                       |     |      _________________________________ Right
;                       |     |     |      ___________________________ Down-right
;                       |     |     |     |      _____________________ Down (facing right)
;                       |     |     |     |     |      _______________ Down-left
;                       |     |     |     |     |     |      _________ Left
;                       |     |     |     |     |     |     |      ___ Up-left
;                       |     |     |     |     |     |     |     |
$86:E9F1             dw E8AF, E89B, E887, E873, E85F, E837, E823, E80F, ; Body segment
                        E8F3, E8F3, E8F3, E8F3, E8F3, E8F3, E8F3, E8F3, ; Hidden
                        E8C3, E8ED, E8E7, E8E1, E8DB, E8D5, E8CF, E8C9, ; Tail
                        E8F3, E8F3, E8F3, E8F3, E8F3, E8F3, E8F3, E8F3  ; Hidden
}


;;; $EA31: Initialisation AI - enemy projectile $EBA0 (Botwoon's body) ;;;
{
$86:EA31 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$86:EA34 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [Botwoon X position]
$86:EA37 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$86:EA3A 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [Botwoon Y position]
$86:EA3D A9 00 00    LDA #$0000             ;\
$86:EA40 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;} Enemy projectile falling time counter = 0
$86:EA43 5A          PHY
$86:EA44 A0 10 00    LDY #$0010             ; $12 = 10h
$86:EA47 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$86:EA4A D0 03       BNE $03    [$EA4F]     ;} If [Botwoon body projectile index] = 0 (tail):
$86:EA4C A0 30 00    LDY #$0030             ; $12 = 30h

$86:EA4F 84 12       STY $12    [$7E:0012]
$86:EA51 B9 F1 E9    LDA $E9F1,y[$86:EA01]  ;\
$86:EA54 7A          PLY                    ;} Enemy projectile instruction list pointer = [$E9F1 + [$12]]
$86:EA55 99 47 1B    STA $1B47,y[$7E:1B69]  ;/
$86:EA58 99 23 1B    STA $1B23,y[$7E:1B45]  ; Enemy projectile instruction list = [enemy projectile instruction list pointer]
$86:EA5B A5 12       LDA $12    [$7E:0012]  ;\
$86:EA5D 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;} Enemy projectile instruction list table index = [$12]
$86:EA60 A9 98 EA    LDA #$EA98             ;\
$86:EA63 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile function = $EA98 (main)
$86:EA66 AE A8 0F    LDX $0FA8  [$7E:0FA8]  ;\
$86:EA69 98          TYA                    ;} $7E:7800 + [Botwoon body projectile index] = [enemy projectile index] (Botwoon enemy projectile indices)
$86:EA6A 9F 00 78 7E STA $7E7800,x[$7E:7818];/
$86:EA6E DA          PHX                    ;\
$86:EA6F AA          TAX                    ;|
$86:EA70 A9 02 00    LDA #$0002             ;} Disable enemy projectile interaction with projectiles
$86:EA73 9F 80 F3 7E STA $7EF380,x[$7E:F3A2];|
$86:EA77 FA          PLX                    ;/
$86:EA78 A9 01 00    LDA #$0001             ;\
$86:EA7B 9F 20 78 7E STA $7E7820,x[$7E:7838];} $7E:7820 + [Botwoon body projectile index] = 1 (Botwoon body hidden flag)
$86:EA7F 60          RTS
}


;;; $EA80: Pre-instruction - enemy projectile $EBA0 (Botwoon's body) ;;;
{
$86:EA80 AF 20 80 7E LDA $7E8020[$7E:8020]  ;\
$86:EA84 F0 0E       BEQ $0E    [$EA94]     ;} If [Botwoon body death flag] != 0:
$86:EA86 BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;\
$86:EA89 C9 98 EA    CMP #$EA98             ;} If [enemy projectile function] = $EA98 (main):
$86:EA8C D0 06       BNE $06    [$EA94]     ;/
$86:EA8E A9 F4 EA    LDA #$EAF4             ;\
$86:EA91 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile function = $EAF4 (dying)

$86:EA94 FC B7 1A    JSR ($1AB7,x)[$86:EA98]; Execute [enemy projectile function]
$86:EA97 60          RTS
}


;;; $EA98: Botwoon's body function - main ;;;
{
; Enemy projectile instruction list table index ($1AFF,x) is set by Botwoon, see $B3:9D4D
$86:EA98 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:EA9B A8          TAY                    ;|
$86:EA9C B9 F1 E9    LDA $E9F1,y[$86:EA01]  ;} If [enemy projectile instruction list] != [$E9F1 + [enemy projectile instruction list table index]]:
$86:EA9F DD 23 1B    CMP $1B23,x[$7E:1B45]  ;|
$86:EAA2 F0 0C       BEQ $0C    [$EAB0]     ;/
$86:EAA4 9D 47 1B    STA $1B47,x[$7E:1B69]  ; Enemy projectile instruction list pointer = [$E9F1 + [enemy projectile instruction list table index]]
$86:EAA7 9D 23 1B    STA $1B23,x[$7E:1B45]  ; Enemy projectile instruction list = [enemy projectile instruction list pointer]
$86:EAAA A9 01 00    LDA #$0001             ;\
$86:EAAD 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1

$86:EAB0 20 B4 EA    JSR $EAB4  [$86:EAB4]  ; Botwoon's body hurt flash handling
$86:EAB3 60          RTS
}


;;; $EAB4: Botwoon's body hurt flash handling ;;;
{
$86:EAB4 BD BB 19    LDA $19BB,x[$7E:19DD]  ;\
$86:EAB7 09 00 0E    ORA #$0E00             ;} Enemy projectile palette index = 7
$86:EABA 9D BB 19    STA $19BB,x[$7E:19DD]  ;/
$86:EABD AD 9C 0F    LDA $0F9C  [$7E:0F9C]  ;\
$86:EAC0 F0 11       BEQ $11    [$EAD3]     ;} If [Botwoon flash timer] = 0: return
$86:EAC2 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$86:EAC5 89 02 00    BIT #$0002             ;} If [number of times main enemy routine has been executed] % 4 >= 2:
$86:EAC8 F0 09       BEQ $09    [$EAD3]     ;/
$86:EACA BD BB 19    LDA $19BB,x[$7E:19DD]  ;\
$86:EACD 29 FF F1    AND #$F1FF             ;} Enemy projectile palette index = 0
$86:EAD0 9D BB 19    STA $19BB,x[$7E:19DD]  ;/

$86:EAD3 60          RTS
}


;;; $EAD4: Botwoon's body hurt flash handling ;;;
{
; Clone of $EAB4
$86:EAD4 B9 BB 19    LDA $19BB,y[$7E:19DD]
$86:EAD7 09 00 0E    ORA #$0E00
$86:EADA 99 BB 19    STA $19BB,y[$7E:19DD]
$86:EADD AD 9C 0F    LDA $0F9C  [$7E:0F9C]
$86:EAE0 F0 11       BEQ $11    [$EAF3]
$86:EAE2 AD 44 0E    LDA $0E44  [$7E:0E44]
$86:EAE5 89 02 00    BIT #$0002
$86:EAE8 F0 09       BEQ $09    [$EAF3]
$86:EAEA B9 BB 19    LDA $19BB,y
$86:EAED 29 FF F1    AND #$F1FF
$86:EAF0 99 BB 19    STA $19BB,y

$86:EAF3 60          RTS
}


;;; $EAF4: Botwoon's body function - dying - set delay ;;;
{
$86:EAF4 8A          TXA                    ;\
$86:EAF5 0A          ASL A                  ;|
$86:EAF6 0A          ASL A                  ;|
$86:EAF7 18          CLC                    ;} Enemy projectile pre-fall wait counter = [enemy projectile index] * 4 + 60h
$86:EAF8 69 60 00    ADC #$0060             ;|
$86:EAFB 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;/
$86:EAFE A9 04 EB    LDA #$EB04             ;\
$86:EB01 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile function = $EB04 (dying - waiting)
}


;;; $EB04: Botwoon's body function - dying - waiting ;;;
{
$86:EB04 FE FF 1A    INC $1AFF,x[$7E:1B21]  ; Increment enemy projectile pre-fall wait counter
$86:EB07 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:EB0A C9 00 01    CMP #$0100             ;} If [enemy projectile pre-fall wait counter] >= 100h:
$86:EB0D 30 06       BMI $06    [$EB15]     ;/
$86:EB0F A9 1F EB    LDA #$EB1F             ;\
$86:EB12 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;} Enemy projectile function = $EB1F (dying - falling)

$86:EB15 A9 00 00    LDA #$0000             ;\
$86:EB18 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 0
$86:EB1B 20 B4 EA    JSR $EAB4  [$86:EAB4]  ; Botwoon's body hurt flash handling
$86:EB1E 60          RTS
}


;;; $EB1F: Botwoon's body function - dying - falling ;;;
{
$86:EB1F 9B          TXY                    ;\
$86:EB20 B9 DB 1A    LDA $1ADB,y[$7E:1AFD]  ;|
$86:EB23 29 00 FF    AND #$FF00             ;|
$86:EB26 EB          XBA                    ;|
$86:EB27 0A          ASL A                  ;} X = [enemy projectile falling time counter] / 100h * 8 (quadratic speed table index)
$86:EB28 0A          ASL A                  ;|
$86:EB29 0A          ASL A                  ;|
$86:EB2A AA          TAX                    ;/
$86:EB2B B9 6F 1A    LDA $1A6F,y[$7E:1A91]  ;\
$86:EB2E 18          CLC                    ;|
$86:EB2F 7F C7 CB A0 ADC $A0CBC7,x[$A0:CBC7];|
$86:EB33 90 09       BCC $09    [$EB3E]     ;|
$86:EB35 48          PHA                    ;|
$86:EB36 B9 93 1A    LDA $1A93,y[$7E:1AB5]  ;|
$86:EB39 1A          INC A                  ;|
$86:EB3A 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position += [$A0:CBC7 + [X] + 2].[$A0:CBC7 + [X]]
$86:EB3D 68          PLA                    ;|
                                            ;|
$86:EB3E 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;|
$86:EB41 B9 93 1A    LDA $1A93,y[$7E:1AB5]  ;|
$86:EB44 18          CLC                    ;|
$86:EB45 7F C9 CB A0 ADC $A0CBC9,x[$A0:CBC9];|
$86:EB49 99 93 1A    STA $1A93,y[$7E:1AB5]  ;/
$86:EB4C C9 C8 00    CMP #$00C8             ;\
$86:EB4F 30 2E       BMI $2E    [$EB7F]     ;} If [enemy projectile Y position] < C8h: go to BRANCH_FALLING
$86:EB51 A9 C8 00    LDA #$00C8             ;\
$86:EB54 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = C8h
$86:EB57 A9 93 EB    LDA #$EB93             ;\
$86:EB5A 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile function = RTS
$86:EB5D A9 08 E2    LDA #$E208             ;\
$86:EB60 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $E208 (big explosion)
$86:EB63 A9 00 0A    LDA #$0A00             ;\
$86:EB66 99 BB 19    STA $19BB,y[$7E:19DD]  ;} Enemy projectile VRAM tiles index = 0, palette index = 5
$86:EB69 A9 01 00    LDA #$0001             ;\
$86:EB6C 99 8F 1B    STA $1B8F,y[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:EB6F 20 94 EB    JSR $EB94  [$86:EB94]  ; Queue small explosion sound effect
$86:EB72 C0 0A 00    CPY #$000A             ;\
$86:EB75 D0 07       BNE $07    [$EB7E]     ;} If [enemy projectile index] = Ah: (last body part's index)
$86:EB77 A9 01 00    LDA #$0001             ;\
$86:EB7A 8F 3E 88 7E STA $7E883E[$7E:883E]  ;} Botwoon body death flag = 1

$86:EB7E 60          RTS                    ; Return

; BRANCH_FALLING
$86:EB7F B9 DB 1A    LDA $1ADB,y[$7E:1AFD]  ;\
$86:EB82 18          CLC                    ;|
$86:EB83 69 C0 00    ADC #$00C0             ;} Enemy projectile falling time counter += C0h
$86:EB86 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;/
$86:EB89 A9 00 00    LDA #$0000             ;\
$86:EB8C 99 8F 1B    STA $1B8F,y[$7E:1BB1]  ;}
$86:EB8F 20 D4 EA    JSR $EAD4  [$86:EAD4]  ; Botwoon's body hurt flash handling
$86:EB92 60          RTS
}


;;; $EB93: RTS ;;;
{
$86:EB93 60          RTS
}


;;; $EB94: Queue small explosion sound effect ;;;
{
$86:EB94 5A          PHY
$86:EB95 DA          PHX
$86:EB96 A9 24 00    LDA #$0024             ;\
$86:EB99 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 6 (small explosion)
$86:EB9D FA          PLX
$86:EB9E 7A          PLY
$86:EB9F 60          RTS
}


;;; $EBA0: Enemy projectile - Botwoon's body ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:EBA0             dx EA31,EA80,E8F3,02,02,E080,0000,84FC ; Botwoon's body. Initial instruction list ignored
}
}


;;; $EBAE..EC55: Botwoon's spit ;;;
{
;;; $EBAE: Instruction list - enemy projectile $EC48 (Botwoon's spit) ;;;
{
$86:EBAE             dx 0003,B8B4,
                        0003,B8BB,
                        0003,B8C2,
                        0003,B8C9,
                        0003,B8D0,
                        81AB,EBAE   ; Go to $EBAE
}


;;; $EBC6: Initialisation AI - enemy projectile $EC48 (Botwoon's spit) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Speed
;;     $060B: Angle
$86:EBC6 DA          PHX
$86:EBC7 AE 54 0E    LDX $0E54  [$7E:0E54]
$86:EBCA BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:EBCD 99 4B 1A    STA $1A4B,y[$7E:1A53]  ;} Enemy projectile X position = [enemy X position]
$86:EBD0 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:EBD3 99 93 1A    STA $1A93,y[$7E:1A9B]  ;} Enemy projectile Y position = [enemy Y position]
$86:EBD6 A9 AE EB    LDA #$EBAE             ;\
$86:EBD9 99 47 1B    STA $1B47,y[$7E:1B4F]  ;} Enemy projectile instruction list pointer = $EBAE
$86:EBDC BB          TYX                    ;\
$86:EBDD AD 0B 06    LDA $060B  [$7E:060B]  ;|
$86:EBE0 9F DC 97 7E STA $7E97DC,x[$7E:97E4];} $12 = enemy projectile angle = [$060B]
$86:EBE4 85 12       STA $12    [$7E:0012]  ;/
$86:EBE6 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:EBE9 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy projectile initialisation parameter]
$86:EBEB 22 43 B6 A0 JSL $A0B643[$A0:B643]  ; ($16.$18, $1A.$1C) = ([$14] * |cos([$12] * pi / 80h)|, [$14] * |sin([$12] * pi / 80h)|)
$86:EBEF A5 16       LDA $16    [$7E:0016]  ;\
$86:EBF1 99 B7 1A    STA $1AB7,y[$7E:1ABF]  ;|
$86:EBF4 A5 18       LDA $18    [$7E:0018]  ;} Enemy projectile X speed = [$16].[$18]
$86:EBF6 99 FF 1A    STA $1AFF,y[$7E:1B07]  ;/
$86:EBF9 A5 1A       LDA $1A    [$7E:001A]  ;\
$86:EBFB 99 DB 1A    STA $1ADB,y[$7E:1AE3]  ;|
$86:EBFE A5 1C       LDA $1C    [$7E:001C]  ;} Enemy projectile Y speed = [$1A].[$1C]
$86:EC00 99 23 1B    STA $1B23,y[$7E:1B2B]  ;/
$86:EC03 FA          PLX
$86:EC04 60          RTS
}


;;; $EC05: Pre-instruction - enemy projectile $EC48 (Botwoon's spit) ;;;
{
$86:EC05 20 3E E7    JSR $E73E  [$86:E73E]  ; Move enemy projectile according to enemy projectile angle and speed
$86:EC08 20 0C EC    JSR $EC0C  [$86:EC0C]  ; Delete enemy projectile if off-screen
$86:EC0B 60          RTS
}


;;; $EC0C: Delete enemy projectile if off-screen ;;;
{
; Clone of $BD1E
$86:EC0C 20 18 EC    JSR $EC18  [$86:EC18]
$86:EC0F F0 06       BEQ $06    [$EC17]
$86:EC11 A9 00 00    LDA #$0000
$86:EC14 9D 97 19    STA $1997,x[$7E:1997]

$86:EC17 60          RTS
}


;;; $EC18: Check if enemy projectile is off-screen ;;;
{
;; Returns:
;;     A: 1 if off-screen, 0 otherwise

; Clone of $BD2A
$86:EC18 BD 4B 1A    LDA $1A4B,x[$7E:1A53]
$86:EC1B CD 11 09    CMP $0911  [$7E:0911]
$86:EC1E 30 24       BMI $24    [$EC44]
$86:EC20 AD 11 09    LDA $0911  [$7E:0911]
$86:EC23 18          CLC
$86:EC24 69 00 01    ADC #$0100
$86:EC27 DD 4B 1A    CMP $1A4B,x[$7E:1A53]
$86:EC2A 30 18       BMI $18    [$EC44]
$86:EC2C BD 93 1A    LDA $1A93,x[$7E:1A9B]
$86:EC2F CD 15 09    CMP $0915  [$7E:0915]
$86:EC32 30 10       BMI $10    [$EC44]
$86:EC34 AD 15 09    LDA $0915  [$7E:0915]
$86:EC37 18          CLC
$86:EC38 69 00 01    ADC #$0100
$86:EC3B DD 93 1A    CMP $1A93,x[$7E:1A9B]
$86:EC3E 30 04       BMI $04    [$EC44]
$86:EC40 A9 00 00    LDA #$0000
$86:EC43 60          RTS

$86:EC44 A9 01 00    LDA #$0001
$86:EC47 60          RTS
}


;;; $EC48: Enemy projectile - Botwoon's spit ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:EC48             dx EBC6,EC05,EBAE,02,02,1060,0000,84FC ; Botwoon's spit. Initial instruction list ignored
}
}


;;; $EC56..A2: Yapping maw's body ;;;
{
;;; $EC56: Instruction list - yapping maw's body - facing down ;;;
{
$86:EC56             dx 0001,B8D7,
                        8159        ; Sleep
}


;;; $EC5C: Instruction list - yapping maw's body - facing up ;;;
{
$86:EC5C             dx 0001,B8DE,
                        8159        ; Sleep
}


;;; $EC62: Initialisation AI - enemy projectile $EC95 (yapping maw's body) ;;;
{
$86:EC62 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:EC65 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$86:EC68 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;} Enemy projectile X position = [enemy X position]
$86:EC6B BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$86:EC6E 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [enemy Y position]
$86:EC71 A9 5C EC    LDA #$EC5C             ;\
$86:EC74 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $EC5C (facing up)
$86:EC77 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$86:EC7A D0 06       BNE $06    [$EC82]     ;} If [enemy parameter 2] = 0 (facing down):
$86:EC7C A9 56 EC    LDA #$EC56             ;\
$86:EC7F 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $EC56 (facing down)

$86:EC82 DA          PHX
$86:EC83 BF 08 88 7E LDA $7E8808,x[$7E:8808];\
$86:EC87 0A          ASL A                  ;|
$86:EC88 18          CLC                    ;|
$86:EC89 6D 54 0E    ADC $0E54  [$7E:0E54]  ;} Enemy $7E:8800 + [enemy body segment index] * 2 = [enemy projectile index]
$86:EC8C AA          TAX                    ;|
$86:EC8D 98          TYA                    ;|
$86:EC8E 9F 00 88 7E STA $7E8800,x[$7E:8806];/
$86:EC92 FA          PLX
$86:EC93 60          RTS
}


;;; $EC94: RTS. Pre-instruction - enemy projectile $EC95 (yapping maw's body) ;;;
{
$86:EC94 60          RTS
}


;;; $EC95: Enemy projectile - yapping maw's body ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:EC95             dx EC62,EC94,EC56,02,02,2005,0000,84FC ; Yapping maw's body. Initial instruction list ignored
}
}


;;; $ECA3..F352: Enemy death explosion / pickup ;;;
{
;;; $ECA3..EF28: Instruction lists ;;;
{
;;; $ECA3: Instruction list - handle respawning enemy ;;;
{
$86:ECA3             dx 0040,8000,
                        EF10,       ; Handle respawning enemy
                        8154        ; Delete
}


;;; $ECAB: Instruction list - enemy death explosion - type 4 (big explosion) ;;;
{
$86:ECAB             dx 81D5,0005   ; Timer = 5
$86:ECAF             dx ED17,0003,  ; Spawn sprite object 3 (small explosion) randomly within radius 10h
                        ED17,000C,  ; Spawn sprite object Ch (smoke) randomly within radius 10h
                        0008,8000,
                        EE97,       ; Queue small explosion sound effect
                        81C6,ECAF,  ; Decrement timer and go to $ECAF if non-zero
                        EEAF,       ; Become pickup
                        8154        ; Delete
}


;;; $ECC5: Instruction list - enemy death explosion - type 3 (mini-Kraid explosion) ;;;
{
$86:ECC5             dx 81D5,0010   ; Timer = 10h
$86:ECC9             dx ECE3,0003,  ; Spawn sprite object 3 (small explosion) randomly within radius 20h
                        ECE3,000C,  ; Spawn sprite object Ch (smoke) randomly within radius 20h
                        ECE3,0015,  ; Spawn sprite object 15h (big dust cloud) randomly within radius 20h
                        0008,8000,
                        EE97,       ; Queue small explosion sound effect
                        81C6,ECC9,  ; Decrement timer and go to $ECC9 if non-zero
                        EEAF,       ; Become pickup
                        8154        ; Delete
}


;;; $ECE3: Instruction - spawn sprite object [[Y]] randomly within radius 20h ;;;
{
$86:ECE3 DA          PHX
$86:ECE4 5A          PHY
$86:ECE5 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:ECE9 29 3F 00    AND #$003F             ;\
$86:ECEC 38          SEC                    ;|
$86:ECED E9 20 00    SBC #$0020             ;|
$86:ECF0 18          CLC                    ;} $12 = [enemy projectile X position] + [random number low] % 40h - 20h
$86:ECF1 7D 4B 1A    ADC $1A4B,x[$7E:1A5B]  ;|
$86:ECF4 85 12       STA $12    [$7E:0012]  ;/
$86:ECF6 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:ECF9 29 00 3F    AND #$3F00             ;|
$86:ECFC EB          XBA                    ;|
$86:ECFD 38          SEC                    ;|
$86:ECFE E9 20 00    SBC #$0020             ;} $14 = [enemy projectile Y position] + [random number high] % 40h - 20h
$86:ED01 18          CLC                    ;|
$86:ED02 7D 93 1A    ADC $1A93,x[$7E:1AA3]  ;|
$86:ED05 85 14       STA $14    [$7E:0014]  ;/
$86:ED07 B9 00 00    LDA $0000,y[$86:ECCB]  ;\
$86:ED0A 85 16       STA $16    [$7E:0016]  ;} $16 = [[Y]]
$86:ED0C 64 18       STZ $18    [$7E:0018]  ; $18 = 0
$86:ED0E 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object at position ([$12], [$14])
$86:ED12 7A          PLY
$86:ED13 FA          PLX
$86:ED14 C8          INY                    ;\
$86:ED15 C8          INY                    ;} Y += 2
$86:ED16 60          RTS
}


;;; $ED17: Instruction - spawn sprite object [[Y]] randomly within radius 10h ;;;
{
$86:ED17 DA          PHX
$86:ED18 5A          PHY
$86:ED19 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:ED1D 29 1F 00    AND #$001F             ;\
$86:ED20 38          SEC                    ;|
$86:ED21 E9 10 00    SBC #$0010             ;|
$86:ED24 18          CLC                    ;} $12 = [enemy projectile X position] + [random number low] % 20h - 10h
$86:ED25 7D 4B 1A    ADC $1A4B,x[$7E:1A6D]  ;|
$86:ED28 85 12       STA $12    [$7E:0012]  ;/
$86:ED2A AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$86:ED2D 29 00 1F    AND #$1F00             ;|
$86:ED30 EB          XBA                    ;|
$86:ED31 38          SEC                    ;|
$86:ED32 E9 10 00    SBC #$0010             ;} $14 = [enemy projectile Y position] + [random number high] % 20h - 10h
$86:ED35 18          CLC                    ;|
$86:ED36 7D 93 1A    ADC $1A93,x[$7E:1AB5]  ;|
$86:ED39 85 14       STA $14    [$7E:0014]  ;/
$86:ED3B B9 00 00    LDA $0000,y[$86:ECB1]  ;\
$86:ED3E 85 16       STA $16    [$7E:0016]  ;} $16 = [[Y]]
$86:ED40 64 18       STZ $18    [$7E:0018]  ; $18 = 0
$86:ED42 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object at position ([$12], [$14])
$86:ED46 7A          PLY                    
$86:ED47 FA          PLX                    
$86:ED48 C8          INY                    ;\
$86:ED49 C8          INY                    ;} Y += 2
$86:ED4A 60          RTS
}


;;; $ED4B: Instruction list - enemy death explosion - type 2 (normal explosion) ;;;
{
$86:ED4B             dx 0005,B406,
                        0005,B41C,
                        0005,B432,
                        EE8B,       ; Queue enemy killed sound effect
                        0005,B448,
                        0005,B486,
                        0005,B4B0,
                        EEAF,       ; Become pickup
                        8154        ; Delete
}


;;; $ED69: Instruction list - enemy death explosion - type 0 (small explosion) ;;;
{
$86:ED69             dx 0004,BDFF,
                        0006,BE06,
                        0005,BE1C,
                        EE8B,       ; Queue enemy killed sound effect
                        0005,BE32,
                        0005,BE48,
                        0006,BE5E,
                        EEAF,       ; Become pickup
                        8154        ; Delete
}


;;; $ED87: Unused. Instruction list - delete ;;;
{
$86:ED87             dx 81AB,84FC   ; Go to $84FC
}


;;; $ED8B: Unused. Instruction list - delete ;;;
{
$86:ED8B             dx 8154        ; Delete
}


;;; $ED8D: Instruction list - pickup - small health ;;;
{
$86:ED8D             dx 0008,C064,
                        0008,C06B,
                        0008,C072,
                        0008,C079,
                        81AB,ED8D,  ; Go to $ED8D
                        8159        ; Sleep
}


;;; $EDA3: Instruction list - pickup - big health ;;;
{
$86:EDA3             dx 0008,C080,
                        0008,C096,
                        0008,C0AC,
                        0008,C0C2,
                        81AB,EDA3,  ; Go to $EDA3
                        8159        ; Sleep
}


;;; $EDB9: Instruction list - pickup - missiles ;;;
{
$86:EDB9             dx 0005,C102,
                        0005,C10E,
                        81AB,EDB9,  ; Go to $EDB9
                        8159        ; Sleep
}


;;; $EDC7: Unused. Instruction list - pickup - bombs ;;;
{
$86:EDC7             dx 0005,C0C9,
                        0005,C0D0,
                        0005,C0D7,
                        0005,C0DE,
                        81AB,EDC7,  ; Go to $EDC7
                        8159        ; Sleep
}


;;; $EDDD: Instruction list - pickup - super missiles ;;;
{
$86:EDDD             dx 0005,C182,
                        0005,C18E,
                        81AB,EDDD,  ; Go to $EDDD
                        8159        ; Sleep
}


;;; $EDEB: Instruction list - pickup - power bombs ;;;
{
$86:EDEB             dx 0005,BF14,
                        0005,BF1B,
                        0005,BF22,
                        0005,BF29,
                        81AB,EDEB   ; Go to $EDEB
}


;;; $EDFF: Instruction list - enemy death explosion - type 1 (killed by Samus contact) ;;;
{
$86:EDFF             dx 0002,C2E9,
                        0002,C2FF,
                        0002,C329,
                        0002,C353,
                        0002,C37D,
                        0002,C3A7,
                        0002,C3D1,
                        EEA3,       ; Queue enemy killed by contact damage sound effect
                        0002,C3E7,
                        0002,C3FD,
                        0002,C413,
                        0002,C429,
                        0002,C43F,
                        0002,C455,
                        0002,C46B,
                        0002,C481,
                        0002,C497,
                        EEAF,       ; Become pickup
                        8154        ; Delete
}


;;; $EE45: Unused. Instruction list - enemy death explosion ;;;
{
$86:EE45             dx 0002,B8E5,
                        0002,B8F6,
                        0002,B907,
                        0002,B92C,
                        0002,B951,
                        0002,B976,
                        0002,B99B,
                        EEA3,       ; Queue enemy killed by contact damage sound effect
                        0002,B9B1,
                        0002,B9C7,
                        0002,B9DD,
                        0002,B9F3,
                        0002,BA09,
                        0002,BA1F,
                        0002,BA35,
                        0002,BA4B,
                        0002,BA61,
                        EEAF,       ; Become pickup
                        8154        ; Delete
}


;;; $EE8B: Instruction - queue enemy killed sound effect ;;;
{
$86:EE8B DA          PHX
$86:EE8C 5A          PHY
$86:EE8D A9 09 00    LDA #$0009             ;\
$86:EE90 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 9, sound library 2, max queued sounds allowed = 1 (enemy killed)
$86:EE94 7A          PLY
$86:EE95 FA          PLX
$86:EE96 60          RTS
}


;;; $EE97: Instruction - queue small explosion sound effect ;;;
{
$86:EE97 DA          PHX
$86:EE98 5A          PHY
$86:EE99 A9 24 00    LDA #$0024             ;\
$86:EE9C 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 24h, sound library 2, max queued sounds allowed = 1 (small explosion)
$86:EEA0 7A          PLY
$86:EEA1 FA          PLX
$86:EEA2 60          RTS
}


;;; $EEA3: Instruction - queue enemy killed by contact damage sound effect ;;;
{
$86:EEA3 DA          PHX
$86:EEA4 5A          PHY
$86:EEA5 A9 0B 00    LDA #$000B             ;\
$86:EEA8 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound Bh, sound library 2, max queued sounds allowed = 1 (enemy killed by contact damage)
$86:EEAC 7A          PLY
$86:EEAD FA          PLX
$86:EEAE 60          RTS
}


;;; $EEAF: Instruction - become pickup ;;;
{
$86:EEAF DA          PHX
$86:EEB0 5A          PHY
$86:EEB1 20 06 F1    JSR $F106  [$86:F106]  ; Random drop routine
$86:EEB4 F0 32       BEQ $32    [$EEE8]     ; If [enemy projectile index] = 0: go to BRANCH_NOTHING
$86:EEB6 C9 06 00    CMP #$0006             ;\
$86:EEB9 10 2D       BPL $2D    [$EEE8]     ;} If [A] = 6: go to BRANCH_NOTHING
$86:EEBB 0A          ASL A                  ;\
$86:EEBC 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;} Enemy projectile type = [A] * 2
$86:EEBF A8          TAY                    ;\
$86:EEC0 B9 04 EF    LDA $EF04,y[$86:EF0C]  ;} Enemy projectile instruction pointer list = [$EF04 + [A] * 2]
$86:EEC3 9D 47 1B    STA $1B47,x[$7E:1B69]  ;/
$86:EEC6 A9 01 00    LDA #$0001             ;\
$86:EEC9 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:EECC A9 90 01    LDA #$0190             ;\
$86:EECF 9D 23 1B    STA $1B23,x[$7E:1B45]  ;} Enemy projectile expiration timer = 400
$86:EED2 A9 E0 EF    LDA #$EFE0             ;\
$86:EED5 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = $EFE0 (pickup)
$86:EED8 BD D7 1B    LDA $1BD7,x[$7E:1BF9]  ;\
$86:EEDB 29 FF BF    AND #$BFFF             ;} Enemy projectile properties &= ~4000h (die on contact)
$86:EEDE 9D D7 1B    STA $1BD7,x[$7E:1BF9]  ;/
$86:EEE1 BD 47 1B    LDA $1B47,x[$7E:1B69]  ;\
$86:EEE4 7A          PLY                    ;|
$86:EEE5 FA          PLX                    ;} Y = [enemy projectile instruction pointer list]
$86:EEE6 A8          TAY                    ;/
$86:EEE7 60          RTS                    ; Return

; BRANCH_NOTHING
$86:EEE8 A9 01 00    LDA #$0001             ;\
$86:EEEB 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:EEEE A9 00 30    LDA #$3000             ;\
$86:EEF1 9D D7 1B    STA $1BD7,x[$7E:1BF9]  ;} Enemy projectile properties = 3000h (disable collisions, high priority)
$86:EEF4 A9 DF EF    LDA #$EFDF             ;\
$86:EEF7 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:EEFA A9 A3 EC    LDA #$ECA3             ;\
$86:EEFD 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction pointer list = $ECA3 (handle respawning enemy)
$86:EF00 7A          PLY
$86:EF01 FA          PLX
$86:EF02 A8          TAY                    ; Y = [enemy projectile instruction pointer list]
$86:EF03 60          RTS
}


;;; $EF04: Instruction list pointers - pickup ;;;
{
$86:EF04             dw 0000,
                        ED8D, ; Small health
                        EDA3, ; Big health
                        EDEB, ; Power bombs
                        EDB9, ; Missiles
                        EDDD  ; Super missiles
}


;;; $EF10: Instruction - handle respawning enemy ;;;
{
$86:EF10 5A          PHY
$86:EF11 DA          PHX
$86:EF12 BF 10 F4 7E LDA $7EF410,x[$7E:F430];\
$86:EF16 C9 FF FF    CMP #$FFFF             ;} If [enemy projectile killed enemy index] = FFFFh: return
$86:EF19 F0 0B       BEQ $0B    [$EF26]     ;/
$86:EF1B 89 00 80    BIT #$8000             ;\
$86:EF1E F0 06       BEQ $06    [$EF26]     ;} If [enemy projectile killed enemy index] & 8000h = 0: return
$86:EF20 29 FF 7F    AND #$7FFF             ; A = [enemy projectile killed enemy index] & ~8000h
$86:EF23 20 64 F2    JSR $F264  [$86:F264]  ; Respawn enemy

$86:EF26 FA          PLX
$86:EF27 7A          PLY
$86:EF28 60          RTS
}
}


;;; $EF29: Initialisation AI - enemy projectile $F337 (pickup) ;;;
{
;; Parameters:
;;     $12: X position
;;     $14: Y position
;;     $0E24: Enemy header pointer (to check drop rates)
$86:EF29 DA          PHX
$86:EF2A 5A          PHY
$86:EF2B A5 12       LDA $12    [$7E:0012]  ;\
$86:EF2D 99 4B 1A    STA $1A4B,y[$7E:1A4D]  ;} Enemy projectile X position = [$12]
$86:EF30 A5 14       LDA $14    [$7E:0014]  ;\
$86:EF32 99 93 1A    STA $1A93,y[$7E:1A95]  ;} Enemy projectile Y position = [$14]
$86:EF35 A9 00 00    LDA #$0000             ;\
$86:EF38 99 BB 19    STA $19BB,y[$7E:19BD]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:EF3B AD 24 0E    LDA $0E24  [$7E:0E24]  ;\
$86:EF3E 9F C8 F3 7E STA $7EF3C8,x[$7E:E6FF];} Enemy projectile enemy header pointer = [$0E24]
$86:EF42 20 06 F1    JSR $F106  [$86:F106]  ; Random drop routine
$86:EF45 F0 27       BEQ $27    [$EF6E]     ; If [enemy projectile index] = 0: go to BRANCH_NOTHING
$86:EF47 C9 06 00    CMP #$0006             ;\
$86:EF4A 10 22       BPL $22    [$EF6E]     ;} If [A] = 6: go to BRANCH_NOTHING
$86:EF4C 0A          ASL A                  ;\
$86:EF4D 99 FF 1A    STA $1AFF,y[$7E:1B01]  ;} Enemy projectile type = [A] * 2
$86:EF50 AA          TAX                    ;\
$86:EF51 BD 04 EF    LDA $EF04,x[$86:EF0C]  ;} Enemy projectile instruction pointer list = [$EF04 + [A] * 2]
$86:EF54 99 47 1B    STA $1B47,y[$7E:1B49]  ;/
$86:EF57 A9 01 00    LDA #$0001             ;\
$86:EF5A 99 8F 1B    STA $1B8F,y[$7E:1B91]  ;} Enemy projectile instruction timer = 1
$86:EF5D A9 90 01    LDA #$0190             ;\
$86:EF60 99 23 1B    STA $1B23,y[$7E:1B25]  ;} Enemy projectile expiration timer = 400
$86:EF63 BB          TYX                    ;\
$86:EF64 A9 FF FF    LDA #$FFFF             ;} Enemy projectile killed enemy index = FFFFh
$86:EF67 9F 10 F4 7E STA $7EF410,x[$7E:F412];/
$86:EF6B 7A          PLY
$86:EF6C FA          PLX
$86:EF6D 60          RTS                    ; Return

; BRANCH_NOTHING
$86:EF6E A9 A3 EC    LDA #$ECA3             ;\
$86:EF71 99 47 1B    STA $1B47,y[$7E:1B67]  ;} Enemy projectile instruction pointer list = $ECA3 (handle respawning enemy)
$86:EF74 A9 01 00    LDA #$0001             ;\
$86:EF77 99 8F 1B    STA $1B8F,y[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:EF7A A9 00 30    LDA #$3000             ;\
$86:EF7D 99 D7 1B    STA $1BD7,y[$7E:1BF7]  ;} Enemy projectile properties = 3000h (disable collisions, high priority)
$86:EF80 A9 DF EF    LDA #$EFDF             ;\
$86:EF83 99 03 1A    STA $1A03,y[$7E:1A23]  ;} Enemy projectile pre-instruction = RTS
$86:EF86 7A          PLY
$86:EF87 FA          PLX
$86:EF88 60          RTS
}


;;; $EF89: Initialisation AI - enemy projectile $F345 (enemy death explosion) ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
;;     $1993: Death animation. Range 0..4
;;         0: Small explosion
;;         1: Killed by Samus contact
;;         2: Normal explosion
;;         3: Mini-Kraid explosion
;;         4: Big explosion
$86:EF89 DA          PHX
$86:EF8A 5A          PHY
$86:EF8B BB          TYX                    ; X = [enemy projectile index]
$86:EF8C AC 54 0E    LDY $0E54  [$7E:0E54]  ; Y = [enemy index]
$86:EF8F B9 7A 0F    LDA $0F7A,y[$7E:0FBA]  ;\
$86:EF92 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;} Enemy projectile X position = [enemy X position]
$86:EF95 B9 7E 0F    LDA $0F7E,y[$7E:0FBE]  ;\
$86:EF98 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;} Enemy projectile Y position = [enemy Y position]
$86:EF9B AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$86:EF9E 9F 10 F4 7E STA $7EF410,x[$7E:F432];} Enemy projectile killed enemy index = [enemy index]
$86:EFA2 B9 86 0F    LDA $0F86,y[$7E:0FC6]  ;\
$86:EFA5 89 00 40    BIT #$4000             ;} If enemy respawns if killed:
$86:EFA8 F0 0A       BEQ $0A    [$EFB4]     ;/
$86:EFAA AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$86:EFAD 09 00 80    ORA #$8000             ;} Enemy projectile killed enemy index |= 8000h
$86:EFB0 9F 10 F4 7E STA $7EF410,x[$7E:F432];/

$86:EFB4 B9 78 0F    LDA $0F78,y[$7E:0FB8]  ;\
$86:EFB7 9F C8 F3 7E STA $7EF3C8,x[$7E:F3EA];} Enemy projectile enemy header pointer = [enemy ID]
$86:EFBB A9 00 00    LDA #$0000             ;\
$86:EFBE 9D BB 19    STA $19BB,x[$7E:19DD]  ;} Enemy projectile VRAM graphics index = 0, palette 0
$86:EFC1 AD 93 19    LDA $1993  [$7E:1993]  ;\
$86:EFC4 0A          ASL A                  ;|
$86:EFC5 A8          TAY                    ;} Enemy projectile instruction list pointer = [$EFD5 + [enemy projectile initialisation parameter] * 2]
$86:EFC6 B9 D5 EF    LDA $EFD5,y[$86:EFDD]  ;|
$86:EFC9 9D 47 1B    STA $1B47,x[$7E:1B69]  ;/
$86:EFCC A9 01 00    LDA #$0001             ;\
$86:EFCF 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:EFD2 7A          PLY
$86:EFD3 FA          PLX
$86:EFD4 60          RTS

; Instruction list pointers
$86:EFD5             dw ED69, EDFF, ED4B, ECC5, ECAB
}


;;; $EFDF: RTS. Pre-instruction - enemy projectile $F345 (enemy death explosion) ;;;
{
$86:EFDF 60          RTS
}


;;; $EFE0: Pre-instruction - enemy projectile $F337 (pickup) ;;;
{
$86:EFE0 DA          PHX
$86:EFE1 5A          PHY
$86:EFE2 DE 23 1B    DEC $1B23,x[$7E:1B45]  ; Decrement enemy projectile expiration timer
$86:EFE5 BD 23 1B    LDA $1B23,x[$7E:1B45]  ;\
$86:EFE8 F0 41       BEQ $41    [$F02B]     ;} If [enemy projectile expiration timer] = 0: go to BRANCH_TIMER_EXPIRED
$86:EFEA A9 0D 00    LDA #$000D             ;\
$86:EFED 22 84 F0 90 JSL $90F084[$90:F084]  ;|
$86:EFF1 29 FF FF    AND #$FFFF             ;} If grapple beam is inactive: go to BRANCH_NOT_GRAPPLED
$86:EFF4 F0 4F       BEQ $4F    [$F045]     ;/
$86:EFF6 BD 23 1B    LDA $1B23,x[$7E:1B2D]  ;\
$86:EFF9 C9 80 01    CMP #$0180             ;} If [enemy projectile expiration timer] >= 180h: go to BRANCH_NOT_GRAPPLED
$86:EFFC 10 47       BPL $47    [$F045]     ;/
$86:EFFE BD 4B 1A    LDA $1A4B,x[$7E:1A55]  ;\
$86:F001 38          SEC                    ;|
$86:F002 ED 08 0D    SBC $0D08  [$7E:0D08]  ;|
$86:F005 10 04       BPL $04    [$F00B]     ;|
$86:F007 49 FF FF    EOR #$FFFF             ;} If |[enemy projectile X position] - [grapple beam end X position]| >= 10h: go to BRANCH_NOT_GRAPPLED
$86:F00A 1A          INC A                  ;|
                                            ;|
$86:F00B C9 10 00    CMP #$0010             ;|
$86:F00E 10 35       BPL $35    [$F045]     ;/
$86:F010 BD 93 1A    LDA $1A93,x            ;\
$86:F013 38          SEC                    ;|
$86:F014 ED 0C 0D    SBC $0D0C  [$7E:0D0C]  ;|
$86:F017 10 04       BPL $04    [$F01D]     ;|
$86:F019 49 FF FF    EOR #$FFFF             ;} If |[enemy projectile X position] - [grapple beam end X position]| >= 10h: go to BRANCH_NOT_GRAPPLED
$86:F01C 1A          INC A                  ;|
                                            ;|
$86:F01D C9 10 00    CMP #$0010             ;|
$86:F020 10 23       BPL $23    [$F045]     ;/
$86:F022 DA          PHX                    ;\
$86:F023 BD FF 1A    LDA $1AFF,x            ;|
$86:F026 AA          TAX                    ;} Execute [$F0AD + [enemy projectile type]]
$86:F027 FC AD F0    JSR ($F0AD,x)          ;|
$86:F02A FA          PLX                    ;/

; BRANCH_TIMER_EXPIRED
$86:F02B A9 A3 EC    LDA #$ECA3             ;\
$86:F02E 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $ECA3 (handle respawning enemy)
$86:F031 A9 01 00    LDA #$0001             ;\
$86:F034 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:F037 A9 00 30    LDA #$3000             ;\
$86:F03A 9D D7 1B    STA $1BD7,x[$7E:1BF9]  ;} Enemy projectile properties = 3000h (disable collisions with Samus, high priority)
$86:F03D A9 DF EF    LDA #$EFDF             ;\
$86:F040 9D 03 1A    STA $1A03,x[$7E:1A25]  ;} Enemy projectile pre-instruction = RTS
$86:F043 80 65       BRA $65    [$F0AA]     ; Return

; BRANCH_NOT_GRAPPLED
$86:F045 BD B3 1B    LDA $1BB3,x[$7E:1BD5]  ;\
$86:F048 29 FF 00    AND #$00FF             ;} $0E20 = [enemy projectile X radius]
$86:F04B 8D 20 0E    STA $0E20  [$7E:0E20]  ;/
$86:F04E BD B4 1B    LDA $1BB4,x[$7E:1BD6]  ;\
$86:F051 29 FF 00    AND #$00FF             ;} $0E22 = [enemy projectile Y radius]
$86:F054 8D 22 0E    STA $0E22  [$7E:0E22]  ;/
$86:F057 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$86:F05A 38          SEC                    ;|
$86:F05B FD 4B 1A    SBC $1A4B,x[$7E:1A6D]  ;|
$86:F05E 10 04       BPL $04    [$F064]     ;|
$86:F060 49 FF FF    EOR #$FFFF             ;|
$86:F063 1A          INC A                  ;|
                                            ;} If |[Samus X position] - [enemy projectile X position]| >= [Samus X radius] + [enemy projectile X radius]: return
$86:F064 38          SEC                    ;|
$86:F065 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$86:F068 90 05       BCC $05    [$F06F]     ;|
$86:F06A CD 20 0E    CMP $0E20  [$7E:0E20]  ;|
$86:F06D B0 3B       BCS $3B    [$F0AA]     ;/

$86:F06F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$86:F072 38          SEC                    ;|
$86:F073 FD 93 1A    SBC $1A93,x[$7E:1AB5]  ;|
$86:F076 10 04       BPL $04    [$F07C]     ;|
$86:F078 49 FF FF    EOR #$FFFF             ;|
$86:F07B 1A          INC A                  ;|
                                            ;} If |[Samus Y position] - [enemy projectile Y position]| >= [Samus Y radius] + [enemy projectile Y radius]: return
$86:F07C 38          SEC                    ;|
$86:F07D ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$86:F080 90 07       BCC $07    [$F089]     ;|
$86:F082 CD 22 0E    CMP $0E22  [$7E:0E22]  ;|
$86:F085 90 02       BCC $02    [$F089]     ;|
$86:F087 80 21       BRA $21    [$F0AA]     ;/

$86:F089 DA          PHX                    ;\
$86:F08A BD FF 1A    LDA $1AFF,x[$7E:1B1F]  ;|
$86:F08D AA          TAX                    ;} Execute [$F0AD + [enemy projectile type]]
$86:F08E FC AD F0    JSR ($F0AD,x)[$86:F0E8];|
$86:F091 FA          PLX                    ;/
$86:F092 A9 A3 EC    LDA #$ECA3             ;\
$86:F095 9D 47 1B    STA $1B47,x[$7E:1B67]  ;} Enemy projectile instruction list pointer = $ECA3 (handle respawning enemy)
$86:F098 A9 01 00    LDA #$0001             ;\
$86:F09B 9D 8F 1B    STA $1B8F,x[$7E:1BAF]  ;} Enemy projectile instruction timer = 1
$86:F09E A9 00 30    LDA #$3000             ;\
$86:F0A1 9D D7 1B    STA $1BD7,x[$7E:1BF7]  ;} Enemy projectile properties = 3000h (disable collisions with Samus, high priority)
$86:F0A4 A9 DF EF    LDA #$EFDF             ;\
$86:F0A7 9D 03 1A    STA $1A03,x[$7E:1A23]  ;} Enemy projectile pre-instruction = RTS

$86:F0AA 7A          PLY
$86:F0AB FA          PLX
$86:F0AC 60          RTS

$86:F0AD             dw 0000,
                        F0BB, ; 2: Small health
                        F0CA, ; 4: Big health
                        F0D9, ; 6: Power bombs
                        F0E8, ; 8: Missiles
                        F0F7, ; Ah: Super missiles
                        0000
}


;;; $F0BB: Apply pickup to Samus - small health ;;;
{
$86:F0BB A9 05 00    LDA #$0005             ;\
$86:F0BE 22 12 DF 91 JSL $91DF12[$91:DF12]  ;} Restore 5 health to Samus
$86:F0C2 A9 01 00    LDA #$0001             ;\
$86:F0C5 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 1, sound library 2, max queued sounds allowed = 1 (collected small health drop)
$86:F0C9 60          RTS
}


;;; $F0CA: Apply pickup to Samus - big health ;;;
{
$86:F0CA A9 14 00    LDA #$0014             ;\
$86:F0CD 22 12 DF 91 JSL $91DF12[$91:DF12]  ;} Restore 20 health to Samus
$86:F0D1 A9 02 00    LDA #$0002             ;\
$86:F0D4 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 2, sound library 2, max queued sounds allowed = 1 (collected big health drop)
$86:F0D8 60          RTS
}


;;; $F0D9: Apply pickup to Samus - power bombs ;;;
{
$86:F0D9 A9 01 00    LDA #$0001             ;\
$86:F0DC 22 F0 DF 91 JSL $91DFF0[$91:DFF0]  ;} Restore 1 power bomb to Samus
$86:F0E0 A9 05 00    LDA #$0005             ;\
$86:F0E3 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 5, sound library 2, max queued sounds allowed = 1 (collected power bomb drop)
$86:F0E7 60          RTS
}


;;; $F0E8: Apply pickup to Samus - missiles ;;;
{
$86:F0E8 A9 02 00    LDA #$0002             ;\
$86:F0EB 22 80 DF 91 JSL $91DF80[$91:DF80]  ;} Restore 2 missiles to Samus
$86:F0EF A9 03 00    LDA #$0003             ;\
$86:F0F2 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 3, sound library 2, max queued sounds allowed = 1 (collected missile drop)
$86:F0F6 60          RTS
}


;;; $F0F7: Apply pickup to Samus - super missiles ;;;
{
$86:F0F7 A9 01 00    LDA #$0001             ;\
$86:F0FA 22 D3 DF 91 JSL $91DFD3[$91:DFD3]  ;} Restore 1 super missile to Samus
$86:F0FE A9 04 00    LDA #$0004             ;\
$86:F101 22 C1 90 80 JSL $8090C1[$80:90C1]  ;} Queue sound 4, sound library 2, max queued sounds allowed = 1 (collected super missile drop)
$86:F105 60          RTS
}


;;; $F106: Random drop routine ;;;
{
;; Parameters:
;;     X: Enemy projectile index
;; Returns:
;;     A: Drop type
;;         1: Small health
;;         2: Big health
;;         3: Power bombs
;;         4: Missiles
;;         5: Super missiles
;;         6: Nothing

; A random target value is chosen in 1..FFh
; In principle, the random selection process works by accumulating the drop chances until the random target is met
; If we assume the sum of the drop chances is FFh, this is a correct algorithm as:
;     Pr(small energy) = small energy chance / 255
;     Pr(big energy) = (Pr(not small energy)) * big energy chance / (255 - small energy chance)
;                    = (1 - Pr(small energy)) * big energy chance / (255 - small energy chance)
;                    = (1 - Pr(small energy)) * big energy chance / ((1 - Pr(small energy)) * 255)
;                    = big energy chance / 255
; The other cases follow similarly
; In practice, the selection system has to deal with:
;     Item drops being unavailable due to having full energy/missiles/super missiles/power bombs
;     Energy being guaranteed when Samus health is low (this is easy to deal with)
; For the first issue, rather than rescaling the drop chances, the system resolves these in such a way that
; the probability of getting super missiles (resp. power bombs) doesn't change,
; but the other items (inc. nothing) become more likely.
; In detail:
;     Define minor items as small energy, big energy, missiles and nothing, major items are super missiles and power bombs
;     The minor and major drop chances are pooled (summed) separately
;     If Samus is low on health, then the pooled major drop chance will be 0
;     If Samus has full of whatever item, it is not pooled
;     For the minor items, the accumulator of the drop chances is multiplied by (255 - pooled major drop chance) / (pooled minor drop chance)
;     The accumulator for the major items will then start at
;           (pooled minor drop chance) * (255 - pooled major drop chance) / (pooled minor drop chance)
;         = 255 - pooled major drop chance
;     as it would normally be

$86:F106 DA          PHX
$86:F107 5A          PHY
$86:F108 8B          PHB
$86:F109 F4 00 A0    PEA $A000              ;\
$86:F10C AB          PLB                    ;} DB = $A0
$86:F10D AB          PLB                    ;/
$86:F10E BF 10 F4 7E LDA $7EF410,x[$7E:F432];\
$86:F112 29 FF 7F    AND #$7FFF             ;} $0E2A = [enemy projectile killed enemy index] & 7FFFh (never read)
$86:F115 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/
$86:F118 BF C8 F3 7E LDA $7EF3C8,x[$7E:F3EA];\
$86:F11C AA          TAX                    ;} X = $0E28 = [enemy projectile $7E:F3C8] (enemy header pointer)
$86:F11D 8D 28 0E    STA $0E28  [$7E:0E28]  ;/
$86:F120 BF 3A 00 A0 LDA $A0003A,x[$A0:F38D];\
$86:F124 AA          TAX                    ;} X = (enemy drop chances pointer)
$86:F125 D0 03       BNE $03    [$F12A]     ; If (enemy drop chances pointer) = 0:
$86:F127 4C 4D F2    JMP $F24D  [$86:F24D]  ; Go to RETURN_NOTHING

$86:F12A 22 11 81 80 JSL $808111[$80:8111]  ;\
$86:F12E 29 FF 00    AND #$00FF             ;|
$86:F131 F0 F7       BEQ $F7    [$F12A]     ;} $1A = random number in 1..FFh (random target)
$86:F133 85 1A       STA $1A    [$7E:001A]  ;/
$86:F135 A9 FF 00    LDA #$00FF             ;\
$86:F138 85 14       STA $14    [$7E:0014]  ;} $14 = FFh (pooled major item drop chance complement)
$86:F13A 64 18       STZ $18    [$7E:0018]  ; $18 = 0 (drop chance accumulator)
$86:F13C A0 01 00    LDY #$0001             ; Y = 1
$86:F13F AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$86:F142 18          CLC                    ;|
$86:F143 6D D6 09    ADC $09D6  [$7E:09D6]  ;} If [Samus health] + [Samus reserve health] >= 30:
$86:F146 C9 1E 00    CMP #$001E             ;|
$86:F149 90 06       BCC $06    [$F151]     ;/
$86:F14B C9 32 00    CMP #$0032             ;\
$86:F14E 90 04       BCC $04    [$F154]     ;} If [Samus health] + [Samus reserve health] < 50: go to BRANCH_GRACE_PERIOD
$86:F150 88          DEY                    ; Y = 0

$86:F151 8C 1A 0E    STY $0E1A  [$7E:0E1A]  ; Health drop bias flag = [Y]

; BRANCH_GRACE_PERIOD
$86:F154 E2 20       SEP #$20
$86:F156 AD 1A 0E    LDA $0E1A  [$7E:0E1A]  ;\
$86:F159 F0 12       BEQ $12    [$F16D]     ;} If [health drop bias flag] != 0:
$86:F15B BF 00 00 B4 LDA $B40000,x[$B4:F398];\
$86:F15F 18          CLC                    ;|
$86:F160 7F 01 00 B4 ADC $B40001,x[$B4:F399];} Pooled minor item drop chance = (small energy chance) + (big energy chance)
$86:F164 85 12       STA $12    [$7E:0012]  ;/
$86:F166 A9 03       LDA #$03               ;\
$86:F168 85 16       STA $16    [$7E:0016]  ;} $16 = 3 (enabled drops)
$86:F16A 4C DF F1    JMP $F1DF  [$86:F1DF]  ; Go to BRANCH_DROP_CHANCES_POOLED

$86:F16D BF 03 00 B4 LDA $B40003,x[$B4:F2AB];\
$86:F171 85 12       STA $12    [$7E:0012]  ;} Pooled minor item drop chance = (nothing chance)
$86:F173 A9 08       LDA #$08               ;\
$86:F175 85 16       STA $16    [$7E:0016]  ;} Enabled drops = 8
$86:F177 AC C2 09    LDY $09C2  [$7E:09C2]  ;\
$86:F17A CC C4 09    CPY $09C4  [$7E:09C4]  ;} If [Samus health] = [Samus max health]:
$86:F17D D0 08       BNE $08    [$F187]     ;/
$86:F17F AC D6 09    LDY $09D6  [$7E:09D6]  ;\
$86:F182 CC D4 09    CPY $09D4  [$7E:09D4]  ;} If [Samus reserve health] = [Samus max reserve health]: go to BRANCH_FULL_HEALTH
$86:F185 F0 13       BEQ $13    [$F19A]     ;/

$86:F187 A5 12       LDA $12    [$7E:0012]  ;\
$86:F189 18          CLC                    ;|
$86:F18A 7F 00 00 B4 ADC $B40000,x[$B4:F38C];} Pooled minor item drop chance += (small energy chance) + (big energy chance)
$86:F18E 7F 01 00 B4 ADC $B40001,x[$B4:F38D];|
$86:F192 85 12       STA $12    [$7E:0012]  ;/
$86:F194 A5 16       LDA $16    [$7E:0016]  ;\
$86:F196 09 03       ORA #$03               ;} Enabled drops |= 3
$86:F198 85 16       STA $16    [$7E:0016]  ;/

; BRANCH_FULL_HEALTH
$86:F19A AC C6 09    LDY $09C6  [$7E:09C6]  ;\
$86:F19D CC C8 09    CPY $09C8  [$7E:09C8]  ;} If [Samus missiles] != [Samus max missiles]:
$86:F1A0 F0 0F       BEQ $0F    [$F1B1]     ;/
$86:F1A2 A5 12       LDA $12    [$7E:0012]  ;\
$86:F1A4 18          CLC                    ;|
$86:F1A5 7F 02 00 B4 ADC $B40002,x[$B4:F2AA];} Pooled minor item drop chance += (missile chance)
$86:F1A9 85 12       STA $12    [$7E:0012]  ;/
$86:F1AB A5 16       LDA $16    [$7E:0016]  ;\
$86:F1AD 09 04       ORA #$04               ;} Enabled drops |= 4
$86:F1AF 85 16       STA $16    [$7E:0016]  ;/

$86:F1B1 AC CA 09    LDY $09CA  [$7E:09CA]  ;\
$86:F1B4 CC CC 09    CPY $09CC  [$7E:09CC]  ;} If [Samus super missiles] != [Samus max super missiles]:
$86:F1B7 F0 0F       BEQ $0F    [$F1C8]     ;/
$86:F1B9 A5 14       LDA $14    [$7E:0014]  ;\
$86:F1BB 38          SEC                    ;|
$86:F1BC FF 04 00 B4 SBC $B40004,x[$B4:F252];} Pooled major item drop chance complement -= (super missile chance)
$86:F1C0 85 14       STA $14    [$7E:0014]  ;/
$86:F1C2 A5 16       LDA $16    [$7E:0016]  ;\
$86:F1C4 09 10       ORA #$10               ;} Enabled drops |= 10h
$86:F1C6 85 16       STA $16    [$7E:0016]  ;/

$86:F1C8 AC CE 09    LDY $09CE  [$7E:09CE]  ;\
$86:F1CB CC D0 09    CPY $09D0  [$7E:09D0]  ;} If [Samus power bombs] != [Samus max power bombs]:
$86:F1CE F0 0F       BEQ $0F    [$F1DF]     ;/
$86:F1D0 A5 14       LDA $14    [$7E:0014]  ;\
$86:F1D2 38          SEC                    ;|
$86:F1D3 FF 05 00 B4 SBC $B40005,x[$B4:F2F5];} Pooled major item drop chance complement -= (power bombs chance)
$86:F1D7 85 14       STA $14    [$7E:0014]  ;/
$86:F1D9 A5 16       LDA $16    [$7E:0016]  ;\
$86:F1DB 09 20       ORA #$20               ;} Enabled drops |= 20h
$86:F1DD 85 16       STA $16    [$7E:0016]  ;/

; BRANCH_DROP_CHANCES_POOLED
$86:F1DF A0 00 00    LDY #$0000             ; Y = 0 (returned drop index)

; LOOP_MINOR_DROPS
$86:F1E2 E2 20       SEP #$20
$86:F1E4 A5 12       LDA $12    [$7E:0012]  ;\
$86:F1E6 F0 37       BEQ $37    [$F21F]     ;} If [pooled minor item drop chance] = 0: go to BRANCH_NO_MINOR_DROPS
$86:F1E8 46 16       LSR $16    [$7E:0016]  ; Enabled drops >>= 1
$86:F1EA 90 2A       BCC $2A    [$F216]     ; If carry clear: go to BRANCH_NEXT_MINOR_DROP
$86:F1EC A5 14       LDA $14    [$7E:0014]  ;\
$86:F1EE 8D 02 42    STA $4202  [$7E:4202]  ;|
$86:F1F1 BF 00 00 B4 LDA $B40000,x[$B4:F2AA];|
$86:F1F5 8D 03 42    STA $4203  [$7E:4203]  ;|
$86:F1F8 5A          PHY                    ;|
$86:F1F9 EA          NOP                    ;|
$86:F1FA EA          NOP                    ;|
$86:F1FB AC 16 42    LDY $4216  [$7E:4216]  ;|
$86:F1FE 8C 04 42    STY $4204  [$7E:4204]  ;} Drop chance accumulator += (drop chance) * [pooled major item drop chance complement] / [pooled minor item drop chance]
$86:F201 A5 12       LDA $12    [$7E:0012]  ;|
$86:F203 8D 06 42    STA $4206  [$7E:4206]  ;|
$86:F206 7A          PLY                    ;|
$86:F207 EA          NOP                    ;|
$86:F208 C2 20       REP #$20               ;|
$86:F20A A5 18       LDA $18    [$7E:0018]  ;|
$86:F20C 18          CLC                    ;|
$86:F20D 6D 14 42    ADC $4214  [$7E:4214]  ;/
$86:F210 C5 1A       CMP $1A    [$7E:001A]  ;\
$86:F212 B0 3C       BCS $3C    [$F250]     ;} If [drop chance accumulator] >= [random target]: go to BRANCH_RETURN
$86:F214 85 18       STA $18    [$7E:0018]

; BRANCH_NEXT_MINOR_DROP
$86:F216 E8          INX                    ; Increment enemy drop chances pointer
$86:F217 C8          INY                    ; Increment returned drop index
$86:F218 C0 04 00    CPY #$0004             ;\
$86:F21B D0 C5       BNE $C5    [$F1E2]     ;} If [returned drop index] != 4: go to LOOP_MINOR_DROPS
$86:F21D 80 0F       BRA $0F    [$F22E]     ; Go to LOOP_MAJOR_DROPS

; BRANCH_NO_MINOR_DROPS
$86:F21F A5 16       LDA $16    [$7E:0016]  ;\
$86:F221 4A          LSR A                  ;|
$86:F222 4A          LSR A                  ;|
$86:F223 4A          LSR A                  ;} Enabled drops >>= 4 (shift out all minor drops)
$86:F224 4A          LSR A                  ;|
$86:F225 85 16       STA $16    [$7E:0016]  ;/
$86:F227 E8          INX                    ;\
$86:F228 E8          INX                    ;|
$86:F229 E8          INX                    ;} Enemy drop chances pointer += 4
$86:F22A E8          INX                    ;/
$86:F22B A0 04 00    LDY #$0004             ; Returned drop index = 4

; LOOP_MAJOR_DROPS
$86:F22E E2 20       SEP #$20
$86:F230 46 16       LSR $16    [$7E:0016]  ; Enabled drops >>= 1
$86:F232 90 12       BCC $12    [$F246]     ; If carry clear: go to BRANCH_NEXT_MAJOR_DROP
$86:F234 C2 20       REP #$20
$86:F236 BF 00 00 B4 LDA $B40000,x[$B4:F252];\
$86:F23A 29 FF 00    AND #$00FF             ;|
$86:F23D 18          CLC                    ;} Drop chance accumulator += (drop chance)
$86:F23E 65 18       ADC $18    [$7E:0018]  ;/
$86:F240 C5 1A       CMP $1A    [$7E:001A]  ;\
$86:F242 B0 0C       BCS $0C    [$F250]     ;} If [drop chance accumulator] + (drop chance) >= [random target]: go to BRANCH_RETURN
$86:F244 85 18       STA $18    [$7E:0018]

; BRANCH_NEXT_MAJOR_DROP
$86:F246 E8          INX                    ; Increment enemy drop chances pointer
$86:F247 C8          INY                    ; Increment returned drop index
$86:F248 C0 06 00    CPY #$0006             ;\
$86:F24B D0 E1       BNE $E1    [$F22E]     ;} If [returned drop index] != 6: go to LOOP_MAJOR_DROPS

; RETURN_NOTHING
$86:F24D A0 03 00    LDY #$0003             ; Returned drop index = 3

; BRANCH_RETURN
$86:F250 C2 20       REP #$20
$86:F252 BB          TYX                    ;\
$86:F253 BF 5E F2 86 LDA $86F25E,x[$86:F260];} A = [$86:F25E + [returned drop index]]
$86:F257 29 FF 00    AND #$00FF             ;/
$86:F25A AB          PLB
$86:F25B 7A          PLY
$86:F25C FA          PLX
$86:F25D 60          RTS

$86:F25E             db 01, ; Small health
                        02, ; Big health
                        04, ; Missiles
                        06, ; Nothing
                        05, ; Super missiles
                        03  ; Power bombs
}


;;; $F264: Respawn enemy ;;;
{
$86:F264 8B          PHB
$86:F265 DA          PHX
$86:F266 5A          PHY
$86:F267 F4 00 A0    PEA $A000              ;\
$86:F26A AB          PLB                    ;} DB = $A0
$86:F26B AB          PLB                    ;/
$86:F26C C2 30       REP #$30
$86:F26E 8D 54 0E    STA $0E54  [$7E:0E54]  ; Enemy index = [A]
$86:F271 4A          LSR A                  ;\
$86:F272 4A          LSR A                  ;|
$86:F273 18          CLC                    ;} X = [enemy population pointer] + [enemy index] / 4
$86:F274 6D CF 07    ADC $07CF  [$7E:07CF]  ;|
$86:F277 AA          TAX                    ;/
$86:F278 AC 54 0E    LDY $0E54  [$7E:0E54]  ; Y = [enemy index]
$86:F27B BF 00 00 A1 LDA $A10000,x[$A1:9AD0];\
$86:F27F 99 78 0F    STA $0F78,y[$7E:11B8]  ;} Enemy ID = [$A1:0000 + [X]]
$86:F282 BF 02 00 A1 LDA $A10002,x[$A1:9AD2];\
$86:F286 99 7A 0F    STA $0F7A,y[$7E:11BA]  ;} Enemy X position = [$A1:0000 + [X] + 2]
$86:F289 BF 04 00 A1 LDA $A10004,x[$A1:9AD4];\
$86:F28D 99 7E 0F    STA $0F7E,y[$7E:11BE]  ;} Enemy Y position = [$A1:0000 + [X] + 4]
$86:F290 BF 06 00 A1 LDA $A10006,x[$A1:9AD6];\
$86:F294 99 92 0F    STA $0F92,y[$7E:11D2]  ;} Enemy initialisation parameter = [$A1:0000 + [X] + 6]
$86:F297 BF 08 00 A1 LDA $A10008,x[$A1:9AD8];\
$86:F29B 99 86 0F    STA $0F86,y[$7E:11C6]  ;} Enemy properties = [$A1:0000 + [X] + 8]
$86:F29E BF 0A 00 A1 LDA $A1000A,x[$A1:9ADA];\
$86:F2A2 99 88 0F    STA $0F88,y[$7E:11C8]  ;} Enemy extra properties = [$A1:0000 + [X] + Ah]
$86:F2A5 BF 0C 00 A1 LDA $A1000C,x[$A1:9ADC];\
$86:F2A9 99 B4 0F    STA $0FB4,y[$7E:11F4]  ;} Enemy parameter 1 = [$A1:0000 + [X] + Ch]
$86:F2AC BF 0E 00 A1 LDA $A1000E,x[$A1:9ADE];\
$86:F2B0 99 B6 0F    STA $0FB6,y[$7E:11F6]  ;} Enemy parameter 2 = [$A1:0000 + [X] + Eh]
$86:F2B3 DA          PHX
$86:F2B4 BB          TYX
$86:F2B5 BF 08 70 7E LDA $7E7008,x[$7E:7248];\
$86:F2B9 9D 96 0F    STA $0F96,x[$7E:11D6]  ;} Enemy palette index = [enemy spawn palette index]
$86:F2BC BF 06 70 7E LDA $7E7006,x[$7E:7246];\
$86:F2C0 9D 98 0F    STA $0F98,x[$7E:11D8]  ;} Enemy VRAM tiles index = [enemy spawn VRAM tiles index]
$86:F2C3 FA          PLX
$86:F2C4 A9 00 00    LDA #$0000             ;\
$86:F2C7 99 9E 0F    STA $0F9E,y[$7E:11DE]  ;} Enemy frozen timer = 0
$86:F2CA 99 9C 0F    STA $0F9C,y[$7E:11DC]  ; Enemy flash timer = 0
$86:F2CD 99 A0 0F    STA $0FA0,y[$7E:11E0]  ; Enemy invincibility timer = 0
$86:F2D0 99 90 0F    STA $0F90,y[$7E:11D0]  ; Enemy timer = 0
$86:F2D3 99 A4 0F    STA $0FA4,y[$7E:11E4]  ; Enemy frame counter = 0
$86:F2D6 99 A8 0F    STA $0FA8,y[$7E:11E8]  ;\
$86:F2D9 99 AA 0F    STA $0FAA,y[$7E:11EA]  ;|
$86:F2DC 99 AC 0F    STA $0FAC,y[$7E:11EC]  ;|
$86:F2DF 99 AE 0F    STA $0FAE,y[$7E:11EE]  ;} Enemy AI variables = 0
$86:F2E2 99 B0 0F    STA $0FB0,y[$7E:11F0]  ;|
$86:F2E5 99 B2 0F    STA $0FB2,y[$7E:11F2]  ;/
$86:F2E8 A9 01 00    LDA #$0001             ;\
$86:F2EB 99 94 0F    STA $0F94,y[$7E:11D4]  ;} Enemy instruction timer = 0
$86:F2EE AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$86:F2F1 BD 78 0F    LDA $0F78,x[$7E:11B8]  ;} X = [enemy ID]
$86:F2F4 AA          TAX                    ;/
$86:F2F5 BD 12 00    LDA $0012,x[$A0:F1A5]  ;\
$86:F2F8 8D 84 17    STA $1784  [$7E:1784]  ;} Enemy AI pointer = [[X] + 12h] (enemy initialisation AI pointer)
$86:F2FB BD 08 00    LDA $0008,x[$A0:F19B]  ;\
$86:F2FE 99 82 0F    STA $0F82,y[$7E:11C2]  ;} Enemy X radius = [[X] + 8]
$86:F301 BD 0A 00    LDA $000A,x[$A0:F19D]  ;\
$86:F304 99 84 0F    STA $0F84,y[$7E:11C4]  ;} Enemy Y radius = [[X] + Ah]
$86:F307 BD 04 00    LDA $0004,x[$A0:F197]  ;\
$86:F30A 99 8C 0F    STA $0F8C,y[$7E:11CC]  ;} Enemy health = [[X] + 4]
$86:F30D BD 39 00    LDA $0039,x[$A0:F1CC]  ;\
$86:F310 29 FF 00    AND #$00FF             ;} Enemy layer = [[X] + 39h]
$86:F313 99 9A 0F    STA $0F9A,y[$7E:11DA]  ;/
$86:F316 BD 0C 00    LDA $000C,x[$A0:F19F]  ;\
$86:F319 99 A6 0F    STA $0FA6,y[$7E:11E6]  ;} Enemy AI bank = enemy bank = [[X] + Ch]
$86:F31C 8D 86 17    STA $1786  [$7E:1786]  ;/
$86:F31F 22 27 F3 86 JSL $86F327[$86:F327]  ; Execute enemy AI
$86:F323 7A          PLY
$86:F324 FA          PLX
$86:F325 AB          PLB
$86:F326 60          RTS                    ; Return

$86:F327 AE 54 0E    LDX $0E54  [$7E:0E54]
$86:F32A BD A6 0F    LDA $0FA6,x[$7E:11E6]
$86:F32D 8D 86 17    STA $1786  [$7E:1786]
$86:F330 EB          XBA                    ;\
$86:F331 48          PHA                    ;|
$86:F332 AB          PLB                    ;} DB = [enemy AI bank]
$86:F333 AB          PLB                    ;/
$86:F334 DC 84 17    JML [$1784][$B3:883B]  ; Go to [enemy AI pointer]
}


;;; $F337: Enemy projectiles - enemy death explosion / pickup ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:F337             dx EF29,EFE0,ED8D,10,10,3000,84FC,84FC ; Pickup (from bosses and enemy projectiles). Initial instruction list ignored
$86:F345             dx EF89,EFDF,ED8D,10,10,7000,84FC,84FC ; Enemy death explosion / pickup. Initial instruction list ignored
}
}


;;; $F353..F4A5: Falling spark ;;;
{
;;; $F353: Instruction list - falling spark - falling ;;;
{
$86:F353             dx 0003,C4AD,
                        0003,C4B4,
                        0003,C4BB,
                        81AB,F353   ; Go to $F353
}


;;; $F363: Instruction list - falling spark - hit floor ;;;
{
$86:F363             dx 0001,C4AD,
                        0001,8000,
                        0001,C4AD,
                        0001,8000,
                        0001,C4B4,
                        0001,8000,
                        0001,C4B4,
                        0001,8000,
                        0001,C4BB,
                        0001,8000,
                        0001,C4BB,
                        8154        ; Delete
}


;;; $F391: Initialisation AI - enemy projectile $F498 (falling spark) ;;;
{
$86:F391 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$86:F394 A9 53 F3    LDA #$F353             ;\
$86:F397 99 47 1B    STA $1B47,y[$7E:1B69]  ;} Enemy projectile instruction list pointer = $F353 (falling)
$86:F39A BD 7A 0F    LDA $0F7A,x[$7E:10FA]  ;\
$86:F39D 99 4B 1A    STA $1A4B,y[$7E:1A6D]  ;|
$86:F3A0 BD 7C 0F    LDA $0F7C,x[$7E:10FC]  ;} Enemy projectile X position = [enemy X position]
$86:F3A3 99 27 1A    STA $1A27,y[$7E:1A49]  ;/
$86:F3A6 BD 7E 0F    LDA $0F7E,x[$7E:10FE]  ;\
$86:F3A9 18          CLC                    ;|
$86:F3AA 69 08 00    ADC #$0008             ;|
$86:F3AD 99 93 1A    STA $1A93,y[$7E:1AB5]  ;} Enemy projectile Y position = [enemy Y position] + 8.0
$86:F3B0 BD 80 0F    LDA $0F80,x[$7E:1100]  ;|
$86:F3B3 99 6F 1A    STA $1A6F,y[$7E:1A91]  ;/
$86:F3B6 A9 00 00    LDA #$0000             ;\
$86:F3B9 99 B7 1A    STA $1AB7,y[$7E:1AD9]  ;} Enemy projectile Y velocity = 0.0
$86:F3BC 99 DB 1A    STA $1ADB,y[$7E:1AFD]  ;/
$86:F3BF 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$86:F3C3 29 1C 00    AND #$001C             ;\
$86:F3C6 AA          TAX                    ;} X = [random number] / 4 % 8 * 4
$86:F3C7 BD D4 F3    LDA $F3D4,x[$86:F3D8]  ;\
$86:F3CA 99 23 1B    STA $1B23,y[$7E:1B45]  ;|
$86:F3CD BD D6 F3    LDA $F3D6,x[$86:F3DA]  ;} Enemy projectile X velocity + [$F3D4 + [X]].[$F3D4 + [X] + 2]
$86:F3D0 99 FF 1A    STA $1AFF,y[$7E:1B21]  ;/
$86:F3D3 60          RTS

; This table is one entry too short to be indexed with 1Ch >_<;
$86:F3D4             dw FFFF,B800,
                        FFFF,C000,
                        FFFF,E000,
                        FFFF,FF00,
                        0000,0100,
                        0000,2000,
                        0000,4000
}


;;; $F3F0: Pre-instruction - enemy projectile $F498 (falling spark) ;;;
{
$86:F3F0 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:F3F3 30 1D       BMI $1D    [$F412]     ;} If [enemy projectile Y velocity] >= 0:
$86:F3F5 20 7B 89    JSR $897B  [$86:897B]  ; Move enemy projectile vertically <-- moves enemy projectile by [enemy projectile Y velocity] / 100h
$86:F3F8 B0 5F       BCS $5F    [$F459]     ; If collision: go to BRANCH_HIT_FLOOR
$86:F3FA 18          CLC                    ;\
$86:F3FB BD B7 1A    LDA $1AB7,x[$7E:1AD9]  ;|
$86:F3FE 69 00 40    ADC #$4000             ;} Enemy projectile Y subvelocity += 4000h
$86:F401 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;/
$86:F404 BD DB 1A    LDA $1ADB,x[$7E:1AFD]  ;\
$86:F407 69 00 00    ADC #$0000             ;|
$86:F40A C9 04 00    CMP #$0004             ;} Enemy projectile Y velocity = min(3, [enemy projectile Y velocity] + carry)
$86:F40D B0 03       BCS $03    [$F412]     ;|
$86:F40F 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/

$86:F412 18          CLC                    ;\
$86:F413 BD 6F 1A    LDA $1A6F,x[$7E:1A91]  ;|
$86:F416 7D B7 1A    ADC $1AB7,x[$7E:1AD9]  ;|
$86:F419 9D 6F 1A    STA $1A6F,x[$7E:1A91]  ;} Enemy projectile Y position += [enemy projectile Y velocity]
$86:F41C BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:F41F 7D DB 1A    ADC $1ADB,x[$7E:1AFD]  ;|
$86:F422 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:F425 18          CLC                    ;\
$86:F426 BD 27 1A    LDA $1A27,x[$7E:1A49]  ;|
$86:F429 7D FF 1A    ADC $1AFF,x[$7E:1B21]  ;|
$86:F42C 9D 27 1A    STA $1A27,x[$7E:1A49]  ;} Enemy projectile X position += [enemy projectile X velocity]
$86:F42F BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;|
$86:F432 7D 23 1B    ADC $1B23,x[$7E:1B45]  ;|
$86:F435 9D 4B 1A    STA $1A4B,x[$7E:1A6D]  ;/
$86:F438 AD B5 05    LDA $05B5  [$7E:05B5]  ;\
$86:F43B 89 03 00    BIT #$0003             ;} If [8-bit frame counter] % 4 = 0:
$86:F43E D0 18       BNE $18    [$F458]     ;/
$86:F440 BD 4B 1A    LDA $1A4B,x[$7E:1A6D]  ;\
$86:F443 85 12       STA $12    [$7E:0012]  ;|
$86:F445 BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;|
$86:F448 85 14       STA $14    [$7E:0014]  ;|
$86:F44A A9 30 00    LDA #$0030             ;} Create sprite object 30h (falling spark trail) at enemy projectile position with enemy projectile palette
$86:F44D 85 16       STA $16    [$7E:0016]  ;|
$86:F44F BD BB 19    LDA $19BB,x[$7E:19DD]  ;|
$86:F452 85 18       STA $18    [$7E:0018]  ;|
$86:F454 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

$86:F458 60          RTS                    ; Return

; BRANCH_HIT_FLOOR
$86:F459 A9 63 F3    LDA #$F363             ;\
$86:F45C 9D 47 1B    STA $1B47,x[$7E:1B69]  ;} Enemy projectile instruction list pointer = $F363 (hit floor)
$86:F45F A9 01 00    LDA #$0001             ;\
$86:F462 9D 8F 1B    STA $1B8F,x[$7E:1BB1]  ;} Enemy projectile instruction timer = 1
$86:F465 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;\
$86:F468 0A          ASL A                  ;|
$86:F469 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;|
$86:F46C BD 23 1B    LDA $1B23,x[$7E:1B45]  ;|
$86:F46F 2A          ROL A                  ;|
$86:F470 9D 23 1B    STA $1B23,x[$7E:1B45]  ;|
$86:F473 BD FF 1A    LDA $1AFF,x[$7E:1B21]  ;} Enemy projectile X velocity *= 4
$86:F476 0A          ASL A                  ;|
$86:F477 9D FF 1A    STA $1AFF,x[$7E:1B21]  ;|
$86:F47A BD 23 1B    LDA $1B23,x[$7E:1B45]  ;|
$86:F47D 2A          ROL A                  ;|
$86:F47E 9D 23 1B    STA $1B23,x[$7E:1B45]  ;/
$86:F481 A9 00 80    LDA #$8000             ;\
$86:F484 9D B7 1A    STA $1AB7,x[$7E:1AD9]  ;|
$86:F487 A9 FF FF    LDA #$FFFF             ;} Enemy projectile Y velocity = -0.8000h
$86:F48A 9D DB 1A    STA $1ADB,x[$7E:1AFD]  ;/
$86:F48D BD 93 1A    LDA $1A93,x[$7E:1AB5]  ;\
$86:F490 38          SEC                    ;|
$86:F491 E9 02 00    SBC #$0002             ;} Enemy projectile Y position -= 2
$86:F494 9D 93 1A    STA $1A93,x[$7E:1AB5]  ;/
$86:F497 60          RTS
}


;;; $F498: Enemy projectile - falling spark ;;;
{
;                        __________________________________ Initialisation AI
;                       |     _____________________________ Initial pre-instruction
;                       |    |     ________________________ Initial instruction list
;                       |    |    |     ___________________ X radius
;                       |    |    |    |   ________________ Y radius
;                       |    |    |    |  |   _____________ Properties
;                       |    |    |    |  |  |     ________ Hit instruction list
;                       |    |    |    |  |  |    |     ___ Shot instruction list
;                       |    |    |    |  |  |    |    |
$86:F498             dx F391,F3F0,F353,04,04,0005,0000,84FC ; Falling spark. Initial instruction list ignored
}
}


;;; $F4A6: Free space ;;;
{
$86:F4A6             fillto $878000, $FF	   ; Free space
}
