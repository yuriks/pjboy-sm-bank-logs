;;; $8000..85E1: Animate Samus ;;;
{
;;; $8000: Animate Samus ;;;
{
; Calls code to check FX for liquid physics (which affects the Samus animation frame buffer variable)
; That code also handles lava/acid damage and water splash / air bubble graphics
; Some special case code for keeping to frame 1 of neutral jump animation whilst rising
; Decrement the Samus animation frame timer,
; if zero then Samus animation frame is incremented and the Samus animation delay table is processed
; If an instruction is encountered in the animation delay table,
; some handling for speed booster running is called that deals with incrementing the speed booster stage
; If speed booster handling is not applicable, then the animation delay instruction is processed,
; which may cause looping or branching of the animation

; The actual drawing of Samus (using the Samus pose and Samus animation frame) happens elsewhere (draw Samus routines $85E2..8A4B)

$90:8000 08          PHP
$90:8001 C2 30       REP #$30
$90:8003 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $12 / $14 = Samus bottom / top boundary
$90:8007 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$90:800A 29 0F 00    AND #$000F             ;|
$90:800D AA          TAX                    ;} Execute [$8067 + ([FX type] & Fh)]
$90:800E FC 67 80    JSR ($8067,x)[$90:8078];/
$90:8011 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8014 C9 4D 00    CMP #$004D             ;|
$90:8017 F0 19       BEQ $19    [$8032]     ;} If [Samus pose] = normal jump - not aiming - not moving - gun not extended: go to BRANCH_NEUTRAL_JUMP
$90:8019 C9 4E 00    CMP #$004E             ;|
$90:801C F0 14       BEQ $14    [$8032]     ;/
$90:801E AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$90:8021 3A          DEC A                  ;} Decrement Samus animation frame timer
$90:8022 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$90:8025 F0 02       BEQ $02    [$8029]     ;\
$90:8027 10 3C       BPL $3C    [$8065]     ;} If [Samus animation frame timer] > 0: return

$90:8029 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:802C 1A          INC A                  ;} Increment Samus animation frame
$90:802D 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:8030 80 30       BRA $30    [$8062]     ; Go to BRANCH_HANDLE_DELAY

; BRANCH_NEUTRAL_JUMP
$90:8032 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:8035 C9 02 00    CMP #$0002             ;} If [Samus Y direction] != down:
$90:8038 F0 16       BEQ $16    [$8050]     ;/
$90:803A AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:803D C9 01 00    CMP #$0001             ;} If [Samus animation frame] = 1:
$90:8040 D0 0E       BNE $0E    [$8050]     ;/
$90:8042 AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$90:8045 C9 01 00    CMP #$0001             ;} If [Samus animation frame timer] = 1:
$90:8048 D0 06       BNE $06    [$8050]     ;/
$90:804A A9 04 00    LDA #$0004             ;\
$90:804D 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 4

$90:8050 AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$90:8053 3A          DEC A                  ;} Decrement Samus animation frame timer
$90:8054 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$90:8057 F0 02       BEQ $02    [$805B]     ;\
$90:8059 10 0A       BPL $0A    [$8065]     ;} If [Samus animation frame timer] > 0: return

$90:805B AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:805E 1A          INC A                  ;} Increment Samus animation frame
$90:805F 8D 96 0A    STA $0A96  [$7E:0A96]  ;/

; BRANCH_HANDLE_DELAY
$90:8062 20 DC 82    JSR $82DC  [$90:82DC]  ; Handle animation delay

$90:8065 28          PLP
$90:8066 60          RTS

$90:8067             dw 8078, 81C0, 8219, 80B8, 8077, 8077, 8077, 8077
}


;;; $8077: RTS ;;;
{
; 8: Spores
; Ah: Rain
; Ch: Fog
; 28h: Ceres Ridley
; 2Ah: Ceres elevator
; 2Ch: Haze
$90:8077 60          RTS
}


;;; $8078: Animate Samus - FX = none ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

; 0: None
; 20h: Scrolling sky

; Called by the subroutines for the other FX types too if the FX doesn't affect Samus

$90:8078 AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$90:807B 8D 9C 0A    STA $0A9C  [$7E:0A9C]  ;} Samus animation frame buffer = [Samus X speed divisor]
$90:807E AD D2 0A    LDA $0AD2  [$7E:0AD2]  ;\
$90:8081 F0 34       BEQ $34    [$80B7]     ;} If [liquid physics type] = air: return
$90:8083 89 01 00    BIT #$0001             ;\
$90:8086 D0 04       BNE $04    [$808C]     ;} If [liquid physics type] != water:
$90:8088 9C D2 0A    STZ $0AD2  [$7E:0AD2]  ; Liquid physics type = air
$90:808B 60          RTS                    ; Return

$90:808C 9C D2 0A    STZ $0AD2  [$7E:0AD2]  ; Liquid physics type = air
$90:808F A9 0E 00    LDA #$000E             ;\
$90:8092 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Eh, sound library 2, max queued sounds allowed = 6 (splashed out of water)
$90:8096 AD 74 0A    LDA $0A74  [$7E:0A74]  ;\
$90:8099 89 04 00    BIT #$0004             ;} If [Samus suit palette index] = gravity suit: go to spawn water splash
$90:809C D0 17       BNE $17    [$80B5]     ;/
$90:809E AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:80A1 29 FF 00    AND #$00FF             ;|
$90:80A4 C9 03 00    CMP #$0003             ;} If [Samus movement type] != spin jumping:
$90:80A7 F0 05       BEQ $05    [$80AE]     ;/
$90:80A9 C9 14 00    CMP #$0014             ;\
$90:80AC D0 07       BNE $07    [$80B5]     ;} If [Samus movement type] != wall jumping: go to spawn water splash

$90:80AE A9 30 00    LDA #$0030             ;\
$90:80B1 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 30h, sound library 1, max queued sounds allowed = 6 (resumed spin jump)

$90:80B5 80 2F       BRA $2F    [$80E6]     ; Go to spawn water splash

$90:80B7 60          RTS
}


;;; $80B8: Animate Samus - FX = water ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

; 6h: Water
; 26h: Tourian entrance statue
$90:80B8 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:80BB 30 BB       BMI $BB    [$8078]     ;} If [FX Y position] < 0: go to animate Samus - FX = none
$90:80BD C5 12       CMP $12    [$7E:0012]  ;\
$90:80BF 30 02       BMI $02    [$80C3]     ;} If [FX Y position] >= [Samus bottom boundary]:
$90:80C1 80 B5       BRA $B5    [$8078]     ; Go to animate Samus - FX = none

$90:80C3 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:80C6 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to animate Samus - FX = none
$90:80C9 D0 AD       BNE $AD    [$8078]     ;/
$90:80CB AD 93 9E    LDA $9E93  [$90:9E93]  ;\
$90:80CE 8D 9C 0A    STA $0A9C  [$7E:0A9C]  ;} Samus animation frame buffer = 3
$90:80D1 AD D2 0A    LDA $0AD2  [$7E:0AD2]  ;\
$90:80D4 C9 01 00    CMP #$0001             ;} If [liquid physics type] = water: go to spawn air bubbles
$90:80D7 F0 65       BEQ $65    [$813E]     ;/
$90:80D9 A9 01 00    LDA #$0001             ;\
$90:80DC 8D D2 0A    STA $0AD2  [$7E:0AD2]  ;} Liquid physics type = water
$90:80DF A9 0D 00    LDA #$000D             ;\
$90:80E2 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound Dh, sound library 2, max queued sounds allowed = 6 (splashed into water)
}


;;; $80E6: Spawn water splash and air bubbles ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

$90:80E6 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:80E9 29 FF 00    AND #$00FF             ;|
$90:80EC AA          TAX                    ;|
$90:80ED BD A4 81    LDA $81A4,x[$90:81A7]  ;} If [$81A4 + [Samus movement type]] = 0: (airborne)
$90:80F0 29 FF 00    AND #$00FF             ;|
$90:80F3 D0 1A       BNE $1A    [$810F]     ;/
$90:80F5 A9 00 03    LDA #$0300             ;\
$90:80F8 8D EC 0A    STA $0AEC  [$7E:0AEC]  ;} Atmospheric graphics 0 animation frame = 0, type = 3 (diving splash)
$90:80FB A9 02 00    LDA #$0002             ;\
$90:80FE 8D D4 0A    STA $0AD4  [$7E:0AD4]  ;} Atmospheric graphics 0 animation timer = 2
$90:8101 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8104 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;} Atmospheric graphics 0 X position = [Samus X position]
$90:8107 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:810A 8D E4 0A    STA $0AE4  [$7E:0AE4]  ;} Atmospheric graphics 0 Y position = [FX Y position]
$90:810D 80 2F       BRA $2F    [$813E]

$90:810F A9 00 01    LDA #$0100             ;\ Else ([$81A4 + [Samus movement type]] != 0): (grounded)
$90:8112 8D EC 0A    STA $0AEC  [$7E:0AEC]  ;} Atmospheric graphics 0/1 animation frame = 0, type = 1 (footstep splashes)
$90:8115 8D EE 0A    STA $0AEE  [$7E:0AEE]  ;/
$90:8118 A9 03 00    LDA #$0003             ;\
$90:811B 8D D4 0A    STA $0AD4  [$7E:0AD4]  ;} Atmospheric graphics 0/1 animation timer = 3
$90:811E 8D D6 0A    STA $0AD6  [$7E:0AD6]  ;/
$90:8121 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8124 18          CLC                    ;|
$90:8125 69 04 00    ADC #$0004             ;} Atmospheric graphics 0 X position = [Samus X position] + 4
$90:8128 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;/
$90:812B 38          SEC                    ;\
$90:812C E9 07 00    SBC #$0007             ;} Atmospheric graphics 1 X position = [Samus X position] - 3
$90:812F 8D DE 0A    STA $0ADE  [$7E:0ADE]  ;/
$90:8132 A5 12       LDA $12    [$7E:0012]  ;\
$90:8134 38          SEC                    ;|
$90:8135 E9 04 00    SBC #$0004             ;} Atmospheric graphics 0/1 Y position = [Samus bottom boundary] - 4
$90:8138 8D E4 0A    STA $0AE4  [$7E:0AE4]  ;|
$90:813B 8D E6 0A    STA $0AE6  [$7E:0AE6]  ;/
}


;;; $813E: Spawn air bubbles ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

$90:813E A5 14       LDA $14    [$7E:0014]  ;\
$90:8140 38          SEC                    ;|
$90:8141 E9 18 00    SBC #$0018             ;} If [Samus top boundary] - 18h < [FX Y position]: go to BRANCH_NO_BUBBLES
$90:8144 CD 5E 19    CMP $195E  [$7E:195E]  ;|
$90:8147 30 42       BMI $42    [$818B]     ;/
$90:8149 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:814C 89 7F 00    BIT #$007F             ;} If [frame counter] % 80h != 0: go to BRANCH_NO_BUBBLES
$90:814F D0 3A       BNE $3A    [$818B]     ;/
$90:8151 AD F0 0A    LDA $0AF0  [$7E:0AF0]  ;\
$90:8154 D0 35       BNE $35    [$818B]     ;} If [atmospheric graphics 2 frame/type] != 0: go to BRANCH_NO_BUBBLES
$90:8156 A9 00 05    LDA #$0500             ;\
$90:8159 8D F0 0A    STA $0AF0  [$7E:0AF0]  ;} Atmospheric graphics 2 frame = 0, type = bubbles
$90:815C A9 03 00    LDA #$0003             ;\
$90:815F 8D D8 0A    STA $0AD8  [$7E:0AD8]  ;} Atmospheric graphics 2 animation timer = 3
$90:8162 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8165 8D E0 0A    STA $0AE0  [$7E:0AE0]  ;} Atmospheric graphics 2 X position = [Samus X position]
$90:8168 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:816B 38          SEC                    ;|
$90:816C ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$90:816F 18          CLC                    ;} Atmospheric graphics 2 Y position = (Samus top boundary) + 6
$90:8170 69 06 00    ADC #$0006             ;|
$90:8173 8D E8 0A    STA $0AE8  [$7E:0AE8]  ;/
$90:8176 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$90:817A 89 01 00    BIT #$0001             ;\
$90:817D F0 05       BEQ $05    [$8184]     ;} If [random number] % 2 != 0:
$90:817F A9 0F 00    LDA #$000F             ; A = Fh (low pitched air bubbles)
$90:8182 80 03       BRA $03    [$8187]
                                            ; Else ([random number] % 2 = 0):
$90:8184 A9 11 00    LDA #$0011             ; A = 11h (high pitched air bubbles)

$90:8187 22 CB 90 80 JSL $8090CB[$80:90CB]  ; Queue sound [A], sound library 2, max queued sounds allowed = 6 (air bubbles)

; BRANCH_NO_BUBBLES
$90:818B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:818E C9 00 00    CMP #$0000             ;|
$90:8191 F0 0D       BEQ $0D    [$81A0]     ;} If [Samus pose] != facing forward:
$90:8193 C9 9B 00    CMP #$009B             ;|
$90:8196 F0 08       BEQ $08    [$81A0]     ;/
$90:8198 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:819B 89 20 00    BIT #$0020             ;} If gravity suit not equipped: return
$90:819E F0 03       BEQ $03    [$81A3]     ;/

$90:81A0 9C 9C 0A    STZ $0A9C  [$7E:0A9C]  ; Samus animation frame buffer = 0

$90:81A3 60          RTS
}


;;; $81A4: Water splash type table ;;;
{
; 0: diving splash, else footstep splashes
$90:81A4             db 01, ;* 0: Standing
                        00, ; 1: Running
                        00, ; 2: Normal jumping
                        00, ; 3: Spin jumping
                        01, ;* 4: Morph ball - on ground
                        01, ;* 5: Crouching
                        00, ; 6: Falling
                        00, ; 7: Unused
                        00, ; 8: Morph ball - falling
                        00, ; 9: Unused
                        00, ; Ah: Knockback / crystal flash ending
                        00, ; Bh: Unused
                        00, ; Ch: Unused
                        00, ; Dh: Unused
                        01, ;* Eh: Turning around - on ground
                        01, ;* Fh: Crouching/standing/morphing/unmorphing transition
                        01, ;* 10h: Moonwalking
                        01, ;* 11h: Spring ball - on ground
                        00, ; 12h: Spring ball - in air
                        00, ; 13h: Spring ball - falling
                        00, ; 14h: Wall jumping
                        01, ;* 15h: Ran into a wall
                        00, ; 16h: Grappling
                        00, ; 17h: Turning around - jumping
                        00, ; 18h: Turning around - falling
                        00, ; 19h: Damage boost
                        00, ; 1Ah: Grabbed by Draygon
                        00  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $81C0: Animate Samus - FX = lava ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

; 2: Lava
; 22h: Unused

; Contains lava damage / gravity suit check

$90:81C0 AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:81C3 30 47       BMI $47    [$820C]     ;} If [lava Y position] < 0: go to animate Samus - FX = none
$90:81C5 C5 12       CMP $12    [$7E:0012]  ;\
$90:81C7 10 43       BPL $43    [$820C]     ;} If [lava Y position] >= [Samus bottom boundary]: go to animate Samus - FX = none
$90:81C9 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:81CC F0 0A       BEQ $0A    [$81D8]     ;} If [Samus speed counter / timer] != 0:
$90:81CE 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:81D2 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:81D5 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0

$90:81D8 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:81DB 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_GRAVITY_SUIT_EQUIPPED
$90:81DE D0 2F       BNE $2F    [$820F]     ;/
$90:81E0 AD DA 09    LDA $09DA  [$7E:09DA]  ;\
$90:81E3 89 07 00    BIT #$0007             ;} If [in-game time frames] % 8 = 0:
$90:81E6 D0 0F       BNE $0F    [$81F7]     ;/
$90:81E8 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:81EB C9 47 00    CMP #$0047             ;} If [Samus health] > 70:
$90:81EE 30 07       BMI $07    [$81F7]     ;/
$90:81F0 A9 2D 00    LDA #$002D             ;\
$90:81F3 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 3 (gaining/losing incremental health)

$90:81F7 AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$90:81FA 18          CLC                    ;|
$90:81FB 6D 8B 9E    ADC $9E8B  [$90:9E8B]  ;|
$90:81FE 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;} Periodic damage += 0.8000h
$90:8201 AD 50 0A    LDA $0A50  [$7E:0A50]  ;|
$90:8204 6D 8D 9E    ADC $9E8D  [$90:9E8D]  ;|
$90:8207 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
$90:820A 80 40       BRA $40    [$824C]     ; Go to animate Samus - Samus is submerged in lava/acid

$90:820C 4C 78 80    JMP $8078  [$90:8078]

; BRANCH_GRAVITY_SUIT_EQUIPPED
$90:820F 9C 9C 0A    STZ $0A9C  [$7E:0A9C]  ; Samus animation frame buffer = 0
$90:8212 A9 02 00    LDA #$0002             ;\
$90:8215 8D D2 0A    STA $0AD2  [$7E:0AD2]  ;} Liquid physics type = lava/acid
$90:8218 60          RTS
}


;;; $8219: Animate Samus - FX = acid ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

; 4: Acid
; 24h: Fireflea
$90:8219 AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:821C 30 EE       BMI $EE    [$820C]     ;} If [acid Y position] < 0: go to animate Samus - FX = none
$90:821E C5 12       CMP $12    [$7E:0012]  ;\
$90:8220 10 EA       BPL $EA    [$820C]     ;} If [acid Y position] >= [Samus bottom boundary]: go to animate Samus - FX = none
$90:8222 AD DA 09    LDA $09DA  [$7E:09DA]  ;\
$90:8225 89 07 00    BIT #$0007             ;} If [game time, frames] % 8 = 0:
$90:8228 D0 0F       BNE $0F    [$8239]     ;/
$90:822A AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:822D C9 47 00    CMP #$0047             ;} If [Samus health] > 70:
$90:8230 30 07       BMI $07    [$8239]     ;/
$90:8232 A9 2D 00    LDA #$002D             ;\
$90:8235 22 39 91 80 JSL $809139[$80:9139]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 3 (gaining/losing incremental health)

$90:8239 AD 4E 0A    LDA $0A4E  [$7E:0A4E]  ;\
$90:823C 18          CLC                    ;|
$90:823D 6D 8F 9E    ADC $9E8F  [$90:9E8F]  ;|
$90:8240 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;} Periodic damage += 1.8000h
$90:8243 AD 50 0A    LDA $0A50  [$7E:0A50]  ;|
$90:8246 6D 91 9E    ADC $9E91  [$90:9E91]  ;|
$90:8249 8D 50 0A    STA $0A50  [$7E:0A50]  ;/
}


;;; $824C: Animate Samus - Samus is submerged in lava/acid ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
;;     $14: Samus top boundary

$90:824C AD 95 9E    LDA $9E95  [$90:9E95]  ;\
$90:824F 8D 9C 0A    STA $0A9C  [$7E:0A9C]  ;} Samus animation frame buffer = 2
$90:8252 A9 02 00    LDA #$0002             ;\
$90:8255 8D D2 0A    STA $0AD2  [$7E:0AD2]  ;} Liquid physics type = lava/acid
$90:8258 A5 14       LDA $14    [$7E:0014]  ;\
$90:825A CD 62 19    CMP $1962  [$7E:1962]  ;} If [Samus top boundary] >= [lava/acid Y position]: go to BRANCH_FULLY_SUBMERGED
$90:825D 10 64       BPL $64    [$82C3]     ;/

$90:825F AD EC 0A    LDA $0AEC  [$7E:0AEC]  ;\
$90:8262 89 00 04    BIT #$0400             ;} If [atmospheric graphics 0 type] != lava/acid surface damage:
$90:8265 D0 5C       BNE $5C    [$82C3]     ;/
$90:8267 A9 00 04    LDA #$0400             ;\
$90:826A 8D EC 0A    STA $0AEC  [$7E:0AEC]  ;} Atmospheric graphics 0 frame = 0, type = lava/acid surface damage
$90:826D 8D EE 0A    STA $0AEE  [$7E:0AEE]  ; Atmospheric graphics 1 frame = 0, type = lava/acid surface damage
$90:8270 8D F0 0A    STA $0AF0  [$7E:0AF0]  ; Atmospheric graphics 2 frame = 0, type = lava/acid surface damage
$90:8273 8D F2 0A    STA $0AF2  [$7E:0AF2]  ; Atmospheric graphics 3 frame = 0, type = lava/acid surface damage
$90:8276 A9 03 00    LDA #$0003             ;\
$90:8279 8D D4 0A    STA $0AD4  [$7E:0AD4]  ;} Atmospheric graphics 0 animation timer = 3
$90:827C 8D DA 0A    STA $0ADA  [$7E:0ADA]  ; Atmospheric graphics 3 animation timer = 3
$90:827F A9 02 80    LDA #$8002             ;\
$90:8282 8D D6 0A    STA $0AD6  [$7E:0AD6]  ;} Atmospheric graphics 1 animation timer = 2 | 8000h
$90:8285 8D D8 0A    STA $0AD8  [$7E:0AD8]  ; Atmospheric graphics 2 animation timer = 2 | 8000h
$90:8288 AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:828B 8D E4 0A    STA $0AE4  [$7E:0AE4]  ;} Atmospheric graphics 0 Y position = [lava/acid Y position]
$90:828E 8D E6 0A    STA $0AE6  [$7E:0AE6]  ; Atmospheric graphics 1 Y position = [lava/acid Y position]
$90:8291 8D E8 0A    STA $0AE8  [$7E:0AE8]  ; Atmospheric graphics 2 Y position = [lava/acid Y position]
$90:8294 8D EA 0A    STA $0AEA  [$7E:0AEA]  ; Atmospheric graphics 3 Y position = [lava/acid Y position]
$90:8297 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:829A 18          CLC                    ;|
$90:829B 69 06 00    ADC #$0006             ;} Atmospheric graphics 0 X position = [Samus X position]
$90:829E 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;/
$90:82A1 38          SEC                    ;\
$90:82A2 E9 06 00    SBC #$0006             ;} Atmospheric graphics 1 X position = [Samus X position] - 6
$90:82A5 8D DE 0A    STA $0ADE  [$7E:0ADE]  ;/
$90:82A8 E9 00 00    SBC #$0000             ;\
$90:82AB 8D E0 0A    STA $0AE0  [$7E:0AE0]  ;} Atmospheric graphics 2 X position = [Samus X position] - 6
$90:82AE E9 06 00    SBC #$0006             ;\
$90:82B1 8D E2 0A    STA $0AE2  [$7E:0AE2]  ;} Atmospheric graphics 3 X position = [Samus X position] - Ch
$90:82B4 AD DA 09    LDA $09DA  [$7E:09DA]  ;\
$90:82B7 89 01 00    BIT #$0001             ;} If [game time frames] % 2 = 0:
$90:82BA D0 07       BNE $07    [$82C3]     ;/
$90:82BC A9 10 00    LDA #$0010             ;\
$90:82BF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 10h, sound library 2, max queued sounds allowed = 6 (lava/acid damaging Samus)

; BRANCH_FULLY_SUBMERGED
$90:82C3 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:82C6 C9 00 00    CMP #$0000             ;|
$90:82C9 F0 0D       BEQ $0D    [$82D8]     ;} If not facing forward:
$90:82CB C9 9B 00    CMP #$009B             ;|
$90:82CE F0 08       BEQ $08    [$82D8]     ;/
$90:82D0 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:82D3 89 20 00    BIT #$0020             ;} If gravity suit not equipped: return
$90:82D6 F0 03       BEQ $03    [$82DB]     ;/

$90:82D8 9C 9C 0A    STZ $0A9C  [$7E:0A9C]  ; Samus animation frame buffer = 0

$90:82DB 60          RTS
}


;;; $82DC: Handle Samus animation delay ;;;
{
$90:82DC 08          PHP
$90:82DD E2 20       SEP #$20
$90:82DF 8B          PHB
$90:82E0 A9 91       LDA #$91               ;\
$90:82E2 85 02       STA $02    [$7E:0002]  ;} $02 = $91
$90:82E4 48          PHA                    ;\
$90:82E5 AB          PLB                    ;} DB = $91
$90:82E6 C2 30       REP #$30
$90:82E8 AC 96 0A    LDY $0A96  [$7E:0A96]  ; Y = [Samus animation frame]
$90:82EB AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:82EE 0A          ASL A                  ;|
$90:82EF AA          TAX                    ;} $00 = [$91:B010 + [Samus pose] * 2] (animation delay data)
$90:82F0 BF 10 B0 91 LDA $91B010,x[$91:B014];|
$90:82F4 85 00       STA $00    [$7E:0000]  ;/
$90:82F6 B7 00       LDA [$00],y[$91:B299]  ;\
$90:82F8 29 FF 00    AND #$00FF             ;|
$90:82FB 89 80 00    BIT #$0080             ;} If [[$00] + [Samus animation frame]] & 80h = 0:
$90:82FE D0 05       BNE $05    [$8305]     ;/
$90:8300 20 E3 84    JSR $84E3  [$90:84E3]  ; Handle normal animation delay
$90:8303 80 1C       BRA $1C    [$8321]     ; Return

$90:8305 20 2C 85    JSR $852C  [$90:852C]  ; Handle speed booster animation delay
$90:8308 AA          TAX                    ;\
$90:8309 F0 16       BEQ $16    [$8321]     ;} If [A] = 0 (animation delay was processed): return
$90:830B 29 0F 00    AND #$000F             ;\
$90:830E 0A          ASL A                  ;|
$90:830F AA          TAX                    ;} Execute [$8324 + ([A] & Fh) * 2]
$90:8310 FC 24 83    JSR ($8324,x)[$90:8346];/
$90:8313 90 0C       BCC $0C    [$8321]     ; If returned carry clear: return
$90:8315 B7 00       LDA [$00],y[$91:B298]  ;\
$90:8317 29 FF 00    AND #$00FF             ;|
$90:831A 18          CLC                    ;} Samus animation frame timer = [[$00] + [Y]] + [Samus animation frame buffer]
$90:831B 6D 9C 0A    ADC $0A9C  [$7E:0A9C]  ;|
$90:831E 8D 94 0A    STA $0A94  [$7E:0A94]  ;/

$90:8321 AB          PLB
$90:8322 28          PLP
$90:8323 60          RTS

$90:8324             dw 8344, 8344, 8344, 8344, 8344, 8344, 8346, 8360, 8370, 839A, 83F6, 841D, 848B, 84B6, 84C7, 84DB
}


;;; $8344: Clear carry. Animation delay instruction 0..5 ;;;
{
;; Returns:
;;     Carry: Clear. Samus animation frame is unchanged

$90:8344 18          CLC
$90:8345 60          RTS
}


;;; $8346: Animation delay instruction 6 - go to beginning if [Samus health] >= 30 ;;;
{
;; Returns:
;;     Carry: Set. Samus animation frame is changed
;;     Y: New Samus animation frame

; Used by:
;     1: Facing right - normal
;     2: Facing left  - normal
;     27h: Facing right - crouching
;     28h: Facing left  - crouching

$90:8346 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:8349 C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$90:834C 30 08       BMI $08    [$8356]     ;/
$90:834E A0 00 00    LDY #$0000             ;\
$90:8351 8C 96 0A    STY $0A96  [$7E:0A96]  ;} Y = Samus animation frame = 0
$90:8354 38          SEC                    ;\
$90:8355 60          RTS                    ;} Return carry set

$90:8356 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:8359 1A          INC A                  ;} Increment Samus animation frame
$90:835A 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:835D A8          TAY                    ; Y = [Samus animation frame]
$90:835E 38          SEC                    ;\
$90:835F 60          RTS                    ;} Return carry set
}


;;; $8360: Animation delay instruction 7 - set drained Samus movement handler ;;;
{
;; Returns:
;;     Carry: Set. Samus animation frame is changed
;;     Y: New Samus animation frame

; Used by:
;     E8h: Facing right - Samus drained - crouching
;     E9h: Facing left  - Samus drained - crouching

$90:8360 A9 CB 94    LDA #$94CB             ;\
$90:8363 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $94CB (Samus drained - falling)
$90:8366 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:8369 1A          INC A                  ;} Increment Samus animation frame
$90:836A 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:836D A8          TAY                    ; Y = [Samus animation frame]
$90:836E 38          SEC                    ;\
$90:836F 60          RTS                    ;} Return carry set
}


;;; $8370: Animation delay instruction 8 - enable auto-jump hack and transition to pose if not jumping ;;;
{
;; Returns:
;;     Carry: Clear. Samus animation frame is unchanged

; Used by:
;     25h/26h / 2Fh/30h / 43h/44h / 87h/88h / 8Bh..9Ah / 9Ch..A3h: Turning -> 2/1 / 52h/51h / 28h/27h / 2Ah/29h / 4/3/8/7/16h/15h/18h/17h/2Ch/2Bh/2Eh/2Dh/86h/85h/74h/73h/6/5/6Ah/69h/6Eh/6Dh/72h/71h
;         1: Facing right - normal
;         2: Facing left  - normal
;         3: Facing right - aiming up
;         4: Facing left  - aiming up
;         5: Facing right - aiming up-right
;         6: Facing left  - aiming up-left
;         7: Facing right - aiming down-right
;         8: Facing left  - aiming down-left
;         15h: Facing right - normal jump - aiming up
;         16h: Facing left  - normal jump - aiming up
;         17h: Facing right - normal jump - aiming down
;         18h: Facing left  - normal jump - aiming down
;         27h: Facing right - crouching
;         28h: Facing left  - crouching
;         29h: Facing right - falling
;         2Ah: Facing left  - falling
;         2Bh: Facing right - falling - aiming up
;         2Ch: Facing left  - falling - aiming up
;         2Dh: Facing right - falling - aiming down
;         2Eh: Facing left  - falling - aiming down
;         51h: Facing right - normal jump - not aiming - moving forward
;         52h: Facing left  - normal jump - not aiming - moving forward
;         69h: Facing right - normal jump - aiming up-right
;         6Ah: Facing left  - normal jump - aiming up-left
;         6Dh: Facing right - falling - aiming up-right
;         6Eh: Facing left  - falling - aiming up-left
;         71h: Facing right - crouching - aiming up-right
;         72h: Facing left  - crouching - aiming up-left
;         73h: Facing right - crouching - aiming down-right
;         74h: Facing left  - crouching - aiming down-left
;         85h: Facing right - crouching - aiming up
;         86h: Facing left  - crouching - aiming up
;     A4h..A7h / E0h..E7h: Landing from jump -> 1/2/1/2 / 3..8/1/2
;     BFh..C4h: Moonwalking - turn/jump -> 1Ah/19h/1Ah/19h/1Ah/19h
;         19h: Facing right - spin jump
;         1Ah: Facing left  - spin jump

$90:8370 AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$90:8373 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D: (not demo)
$90:8376 F0 1D       BEQ $1D    [$8395]     ;/
$90:8378 AD 28 0A    LDA $0A28  [$7E:0A28]  ;\
$90:837B C9 4B 00    CMP #$004B             ;|
$90:837E F0 18       BEQ $18    [$8398]     ;} If [prospective pose] = normal jump transition: return carry clear
$90:8380 C9 4C 00    CMP #$004C             ;|
$90:8383 F0 13       BEQ $13    [$8398]     ;/
$90:8385 C9 19 00    CMP #$0019             ;\
$90:8388 F0 0E       BEQ $0E    [$8398]     ;|
$90:838A C9 1A 00    CMP #$001A             ;} If [prospective pose] = spin jump: return carry clear
$90:838D F0 09       BEQ $09    [$8398]     ;/
$90:838F A9 26 E9    LDA #$E926             ;\
$90:8392 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E926 (auto-jump hack)

$90:8395 4C B6 84    JMP $84B6  [$90:84B6]  ; Go to animation delay instruction Dh

$90:8398 18          CLC
$90:8399 60          RTS
}


;;; $839A: Animation delay instruction 9 - transition to pose depending on item equipped and Y speed ;;;
{
;; Returns:
;;     Carry: Clear. Samus animation frame is unchanged

; Used by:
;     37h: Facing right - morphing transition. F9,0002,1D,31,79,7D
;         1Dh: Facing right - morph ball - no springball - on ground
;         31h: Facing right - morph ball - no springball - in air
;         79h: Facing right - morph ball - spring ball - on ground
;         7Dh: Facing right - morph ball - spring ball - falling
;     38h: Facing left  - morphing transition. F9,0002,41,32,7A,7E
;         41h: Facing left - morph ball - no springball - on ground
;         32h: Facing left - morph ball - no springball - in air
;         7Ah: Facing left - morph ball - spring ball - on ground
;         7Eh: Facing left - morph ball - spring ball - falling
;     DBh: Unused. F9,0002,1D,31,79,7D
;     DCh: Unused. F9,0002,DF,DF,DF,DF (unused, related to Draygon?)

$90:839A C8          INY                    ;\
$90:839B B7 00       LDA [$00],y[$91:B4CB]  ;|
$90:839D 85 12       STA $12    [$7E:0012]  ;|
$90:839F AD A2 09    LDA $09A2  [$7E:09A2]  ;} If [equipped items] & [[$00] + [Y] + 1] != 0: go to BRANCH_EQUIPPED_ITEMS
$90:83A2 24 12       BIT $12    [$7E:0012]  ;|
$90:83A4 D0 23       BNE $23    [$83C9]     ;/
$90:83A6 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:83A9 D0 11       BNE $11    [$83BC]     ;|
$90:83AB AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;} If [Samus Y speed] = 0:
$90:83AE D0 0C       BNE $0C    [$83BC]     ;/
$90:83B0 C8          INY                    ;\
$90:83B1 C8          INY                    ;|
$90:83B2 B7 00       LDA [$00],y[$91:B4CD]  ;} Super special prospective pose = [[$00] + [Y] + 3]
$90:83B4 29 FF 00    AND #$00FF             ;|
$90:83B7 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/
$90:83BA 80 32       BRA $32    [$83EE]     ; Go to BRANCH_RETURN

$90:83BC C8          INY                    ;\
$90:83BD C8          INY                    ;|
$90:83BE C8          INY                    ;|
$90:83BF B7 00       LDA [$00],y[$91:B4D7]  ;} Super special prospective pose = [[$00] + [Y] + 4]
$90:83C1 29 FF 00    AND #$00FF             ;|
$90:83C4 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/
$90:83C7 80 25       BRA $25    [$83EE]     ; Go to BRANCH_RETURN

; BRANCH_EQUIPPED_ITEMS
$90:83C9 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:83CC D0 13       BNE $13    [$83E1]     ;|
$90:83CE AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;} If [Samus Y speed] = 0:
$90:83D1 D0 0E       BNE $0E    [$83E1]     ;/
$90:83D3 C8          INY                    ;\
$90:83D4 C8          INY                    ;|
$90:83D5 C8          INY                    ;|
$90:83D6 C8          INY                    ;} Super special prospective pose = [[$00] + [Y] + 5]
$90:83D7 B7 00       LDA [$00],y[$91:B4D8]  ;|
$90:83D9 29 FF 00    AND #$00FF             ;|
$90:83DC 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/
$90:83DF 80 0D       BRA $0D    [$83EE]     ; Go to BRANCH_RETURN

$90:83E1 C8          INY                    ;\
$90:83E2 C8          INY                    ;|
$90:83E3 C8          INY                    ;|
$90:83E4 C8          INY                    ;|
$90:83E5 C8          INY                    ;} Super special prospective pose = [[$00] + [Y] + 6]
$90:83E6 B7 00       LDA [$00],y[$91:B4D0]  ;|
$90:83E8 29 FF 00    AND #$00FF             ;|
$90:83EB 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/

; BRANCH_RETURN
$90:83EE A9 03 00    LDA #$0003             ;\
$90:83F1 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = transition animation finished
$90:83F4 18          CLC                    ;\
$90:83F5 60          RTS                    ;} Return carry clear
}


;;; $83F6: Unused. Animation delay instruction Ah - transition to pose depending on Y speed ;;;
{
;; Returns:
;;     Carry: Clear. Samus animation frame is unchanged

$90:83F6 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:83F9 D0 10       BNE $10    [$840B]     ;|
$90:83FB AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;} If [Samus Y speed] = 0:
$90:83FE D0 0B       BNE $0B    [$840B]     ;/
$90:8400 C8          INY                    ;\
$90:8401 B7 00       LDA [$00],y            ;|
$90:8403 29 FF 00    AND #$00FF             ;} Super special prospective pose = [[$00] + [Y] + 1]
$90:8406 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/
$90:8409 80 0A       BRA $0A    [$8415]

$90:840B C8          INY                    ;\ Else ([Samus Y speed] != 0):
$90:840C C8          INY                    ;|
$90:840D B7 00       LDA [$00],y            ;} Super special prospective pose = [[$00] + [Y] + 2]
$90:840F 29 FF 00    AND #$00FF             ;|
$90:8412 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/

$90:8415 A9 03 00    LDA #$0003             ;\
$90:8418 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = transition animation finished
$90:841B 18          CLC                    ;\
$90:841C 60          RTS                    ;} Return carry clear
}


;;; $841D: Animation delay instruction Bh - select animation delay sequence for wall-jump ;;;
{
;; Returns:
;;     Carry: Set. Samus animation frame is changed
;;     Y: New Samus animation frame

; Used by:
;     83h: Facing right - wall jump
;     84h: Facing left  - wall jump

$90:841D AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:8420 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NOT_SUBMERGED
$90:8423 D0 20       BNE $20    [$8445]     ;/
$90:8425 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $14 = Samus top boundary
$90:8429 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:842C 30 0E       BMI $0E    [$843C]     ;} If [FX Y position] >= 0:
$90:842E C5 14       CMP $14    [$7E:0014]  ;\
$90:8430 10 13       BPL $13    [$8445]     ;} If [FX Y position] >= Samus top boundary: go to BRANCH_NOT_SUBMERGED
$90:8432 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:8435 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NOT_SUBMERGED
$90:8438 D0 0B       BNE $0B    [$8445]     ;/
$90:843A 80 16       BRA $16    [$8452]     ; Go to BRANCH_SUBMERGED

$90:843C AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:843F 30 04       BMI $04    [$8445]     ;} If [lava/acid Y position] < 0: go to BRANCH_NOT_SUBMERGED
$90:8441 C5 14       CMP $14    [$7E:0014]  ;\
$90:8443 30 0D       BMI $0D    [$8452]     ;} If [lava/acid Y position] < Samus top boundary: go to BRANCH_SUBMERGED

; BRANCH_NOT_SUBMERGED
$90:8445 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:8448 89 08 00    BIT #$0008             ;} If screw attack equipped: go to BRANCH_SCREW_ATTACK
$90:844B D0 2A       BNE $2A    [$8477]     ;/
$90:844D 89 00 02    BIT #$0200             ;\
$90:8450 D0 11       BNE $11    [$8463]     ;} If space jump equipped: go to BRANCH_SPACE_JUMP

; BRANCH_SUBMERGED
$90:8452 A9 31 00    LDA #$0031             ;\
$90:8455 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 31h, sound library 1, max queued sounds allowed = 6 (spin jump)
$90:8459 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:845C 1A          INC A                  ;} Samus animation frame += 3 - 2 (normal)
$90:845D 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:8460 A8          TAY                    ; Y = [Samus animation frame]
$90:8461 38          SEC                    ;\
$90:8462 60          RTS                    ;} Return carry set

; BRANCH_SPACE_JUMP
$90:8463 A9 3E 00    LDA #$003E             ;\
$90:8466 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Eh, sound library 1, max queued sounds allowed = 6 (space jump)
$90:846A AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:846D 18          CLC                    ;|
$90:846E 69 0B 00    ADC #$000B             ;} Samus animation frame += Dh - 2 (space jump)
$90:8471 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:8474 A8          TAY                    ; Y = [Samus animation frame]
$90:8475 38          SEC                    ;\
$90:8476 60          RTS                    ;} Return carry set

; BRANCH_SCREW_ATTACK
$90:8477 A9 33 00    LDA #$0033             ;\
$90:847A 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 33h, sound library 1, max queued sounds allowed = 6 (screw attack)
$90:847E AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:8481 18          CLC                    ;|
$90:8482 69 15 00    ADC #$0015             ;} Samus animation frame += 17h - 2 (screw attack)
$90:8485 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:8488 A8          TAY                    ; Y = [Samus animation frame]
$90:8489 38          SEC                    ;\
$90:848A 60          RTS                    ;} Return carry set
}


;;; $848B: Unused. Animation delay instruction Ch - transition to pose depending on item equipped ;;;
{
;; Returns:
;;     Carry: Clear. Samus animation frame is unchanged

; Used by:
;     3Fh: Unused. FC,0002,1D,79
;         1Dh: Facing right - morph ball - no springball - on ground
;         79h: Facing right - morph ball - spring ball - on ground
;     40h: Unused. FC,0002,41,7A
;         41h: Facing left - morph ball - no springball - on ground
;         7Ah: Facing left - morph ball - spring ball - on ground

$90:848B C8          INY                    ;\
$90:848C B7 00       LDA [$00],y            ;|
$90:848E 85 12       STA $12    [$7E:0012]  ;|
$90:8490 AD A2 09    LDA $09A2  [$7E:09A2]  ;} If [equipped items] & [[$00] + [Y] + 1] != 0: go to BRANCH_EQUIPPED_ITEMS
$90:8493 24 12       BIT $12    [$7E:0012]  ;|
$90:8495 D0 0C       BNE $0C    [$84A3]     ;/
$90:8497 C8          INY                    ;\
$90:8498 C8          INY                    ;|
$90:8499 B7 00       LDA [$00],y            ;} Super special prospective pose = [[$00] + [Y] + 3]
$90:849B 29 FF 00    AND #$00FF             ;|
$90:849E 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/
$90:84A1 80 0B       BRA $0B    [$84AE]     ; Go to BRANCH_RETURN

; BRANCH_EQUIPPED_ITEMS
$90:84A3 C8          INY                    ;\
$90:84A4 C8          INY                    ;|
$90:84A5 C8          INY                    ;|
$90:84A6 B7 00       LDA [$00],y            ;} Super special prospective pose = [[$00] + [Y] + 4]
$90:84A8 29 FF 00    AND #$00FF             ;|
$90:84AB 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/

; BRANCH_RETURN
$90:84AE A9 03 00    LDA #$0003             ;\
$90:84B1 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = transition animation finished
$90:84B4 18          CLC                    ;\
$90:84B5 60          RTS                    ;} Return carry clear
}


;;; $84B6: Animation delay instruction Dh - transition to pose ;;;
{
;; Returns:
;;     Carry: Clear. Samus animation frame is unchanged

; Also see instruction 8, which calls this instruction.

; Used by:
;     35h/36h / F1h..F6h: Crouching transition -> 27h/28h / 85h/86h/71h..74h
;         27h: Facing right - crouching
;         28h: Facing left  - crouching
;         85h: Facing right - crouching - aiming up
;         86h: Facing left  - crouching - aiming up
;         71h: Facing right - crouching - aiming up-right
;         72h: Facing left  - crouching - aiming up-left
;         73h: Facing right - crouching - aiming down-right
;         74h: Facing left  - crouching - aiming down-left

;     3Bh/3Ch / F7h..FCh: Standing transition -> 1/2 / 3..8
;         1: Facing right - normal
;         2: Facing left  - normal
;         3: Facing right - aiming up
;         4: Facing left  - aiming up
;         5: Facing right - aiming up-right
;         6: Facing left  - aiming up-left
;         7: Facing right - aiming down-right
;         8: Facing left  - aiming down-left

;     3Dh/3Eh: Unmorphing transition -> 27h/28h

;     4Bh/4Ch / 55h..5Ah: Normal jump transition -> 4Dh/4Eh / 15h/16h/69h..6Ch
;         4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
;         4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended
;         15h: Facing right - normal jump - aiming up
;         16h: Facing left  - normal jump - aiming up
;         69h: Facing right - normal jump - aiming up-right
;         6Ah: Facing left  - normal jump - aiming up-left
;         6Bh: Facing right - normal jump - aiming down-right
;         6Ch: Facing left  - normal jump - aiming down-left

;     D3h/D4h: Crystal flash -> 1/2

;     E8h..EBh: Samus drained -> 1/2/1/2

;     39h/3Ah / C6h / DDh/DEh: Unused -> 20h/42h / BAh / 1/BAh
;         20h: Unused
;         42h: Unused
;         BAh: Facing left  - grabbed by Draygon - not moving - not aiming

$90:84B6 C8          INY                    ;\
$90:84B7 B7 00       LDA [$00],y[$91:B234]  ;|
$90:84B9 29 FF 00    AND #$00FF             ;} Super special prospective pose = [[$00] + [Y] + 1]
$90:84BC 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;/
$90:84BF A9 03 00    LDA #$0003             ;\
$90:84C2 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = transition animation finished
$90:84C5 18          CLC                    ;\
$90:84C6 60          RTS                    ;} Return carry clear
}


;;; $84C7: Animation delay instruction Eh - go to [Y] - [[$00] + [Y] + 1] ;;;
{
;; Returns:
;;     Carry: Set. Samus animation frame is changed
;;     Y: New Samus animation frame

$90:84C7 C8          INY                    ;\
$90:84C8 B7 00       LDA [$00],y[$91:B34E]  ;|
$90:84CA 29 FF 00    AND #$00FF             ;|
$90:84CD 85 12       STA $12    [$7E:0012]  ;|
$90:84CF AD 96 0A    LDA $0A96  [$7E:0A96]  ;} Samus animation frame -= [[$00] + [Y] + 1]
$90:84D2 38          SEC                    ;|
$90:84D3 E5 12       SBC $12    [$7E:0012]  ;|
$90:84D5 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:84D8 A8          TAY                    ; Y = [Samus animation frame]
$90:84D9 38          SEC                    ;\
$90:84DA 60          RTS                    ;} Return carry set
}


;;; $84DB: Animation delay instruction Fh - go to beginning ;;;
{
;; Returns:
;;     Carry: Set. Samus animation frame is changed
;;     Y: New Samus animation frame

$90:84DB A0 00 00    LDY #$0000             ;\
$90:84DE 8C 96 0A    STY $0A96  [$7E:0A96]  ;} Y = Samus animation frame = 0
$90:84E1 38          SEC                    ;\
$90:84E2 60          RTS                    ;} Return carry set
}


;;; $84E3: Handle normal animation delay ;;;
{
;; Parameters:
;;     Y: Samus animation frame
;;     $00: Samus animation delay data pointer

; If Samus has running momentum and running:
;     If speed booster equipped:
;         Load animation delay data pointer from $91:B5DE table
;     Else:
;         Load animation delay data pointer from $91:B5D1
; Set animation frame timer

$90:84E3 08          PHP
$90:84E4 E2 20       SEP #$20
$90:84E6 8B          PHB
$90:84E7 A9 91       LDA #$91               ;\
$90:84E9 85 02       STA $02    [$7E:0002]  ;} $02 = $91
$90:84EB 48          PHA                    ;\
$90:84EC AB          PLB                    ;} DB = $91
$90:84ED C2 30       REP #$30
$90:84EF AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$90:84F2 F0 29       BEQ $29    [$851D]     ;} If [Samus running momentum flag] = 0: go to BRANCH_RETURN
$90:84F4 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:84F7 29 FF 00    AND #$00FF             ;|
$90:84FA C9 01 00    CMP #$0001             ;} If [Samus movement type] != running: go to BRANCH_RETURN
$90:84FD D0 1E       BNE $1E    [$851D]     ;/
$90:84FF AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:8502 89 00 20    BIT #$2000             ;} If speed booster equipped:
$90:8505 F0 10       BEQ $10    [$8517]     ;/
$90:8507 AD 3F 0B    LDA $0B3F  [$7E:0B3F]  ;\
$90:850A 29 FF 00    AND #$00FF             ;|
$90:850D 0A          ASL A                  ;|
$90:850E AA          TAX                    ;} $00 = [$91:B5DE + [speed boost counter] * 2]
$90:850F BF DE B5 91 LDA $91B5DE,x[$91:B5DE];|
$90:8513 85 00       STA $00    [$7E:0000]  ;/
$90:8515 80 06       BRA $06    [$851D]

$90:8517 AF D1 B5 91 LDA $91B5D1[$91:B5D1]  ;\ Else (speed booster not equipped):
$90:851B 85 00       STA $00    [$7E:0000]  ;} $00 = $B5D3

; BRANCH_RETURN
$90:851D B7 00       LDA [$00],y[$91:B299]  ;\
$90:851F 29 FF 00    AND #$00FF             ;|
$90:8522 18          CLC                    ;} Samus animation frame timer = [[$00] + [Samus animation frame]] + [Samus animation frame buffer]
$90:8523 6D 9C 0A    ADC $0A9C  [$7E:0A9C]  ;|
$90:8526 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$90:8529 AB          PLB
$90:852A 28          PLP
$90:852B 60          RTS
}


;;; $852C: Handle speed booster animation delay ;;;
{
;; Parameters:
;;     Y: Samus animation frame
;;     $00: Samus animation delay data pointer
;; Returns:
;;     A: 0 if Samus animation frame timer is set by this routine, otherwise animation delay
;;     $00: Samus animation delay data pointer

; Called when an instruction is encountered in the Samus animation delay table
; If speed booster handling is applicable, the instruction is ignored and Samus animation frame reset to 0

; If Samus has no running momentum or not running or not pressing run:
;     A = [[$00] + [Samus animation frame]]
; Else if speed booster not equipped:
;     Samus animation frame = 0
;     Load animation delay data pointer from $91:B5D1
;     A = 0
;     Set animation frame timer
; Else:
;     Decrement speed boost timer
;     If [speed boost timer] != 0:
;         A = [[$00] + [Samus animation frame]]
;     Else:
;         If [speed boost counter] != 4:
;             Increment speed boost counter
;             If [speed boost counter] = 4:
;                 Play speed echo sound effect
;                 BUG: This clobbers A. If the sound queue is not full, A high is the number of sounds queued,
;                      which can be greater than the $91:B61F table size 4,
;                      which causes the blue suit fail when speed boosting sometimes (mostly in heated rooms)
;                      If the speed boost timer ends up being set to 0, it lasts 100h frames, which causes the apparent sliding-on-one-leg pose
;         Load speed boost timer from $91:B61F table
;         Samus animation frame = 0
;         Load animation delay data pointer from $91:B5DE
;         A = 0
;         Set animation frame timer

$90:852C 08          PHP
$90:852D E2 20       SEP #$20
$90:852F 8B          PHB
$90:8530 A9 91       LDA #$91               ;\
$90:8532 85 02       STA $02    [$7E:0002]  ;} $02 = $91
$90:8534 48          PHA                    ;\
$90:8535 AB          PLB                    ;} DB = $91
$90:8536 C2 30       REP #$30
$90:8538 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$90:853B D0 03       BNE $03    [$8540]     ;} If [Samus running momentum flag] = 0:
$90:853D 4C DA 85    JMP $85DA  [$90:85DA]  ; Go to BRANCH_RETURN

$90:8540 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:8542 2C B6 09    BIT $09B6  [$7E:09B6]  ;} If not pressing run:
$90:8545 D0 03       BNE $03    [$854A]     ;/
$90:8547 4C DA 85    JMP $85DA  [$90:85DA]  ; Go to BRANCH_RETURN

$90:854A AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:854D 29 FF 00    AND #$00FF             ;|
$90:8550 C9 01 00    CMP #$0001             ;} If [Samus movement type] != running:
$90:8553 F0 03       BEQ $03    [$8558]     ;/
$90:8555 4C DA 85    JMP $85DA  [$90:85DA]  ; Go to BRANCH_RETURN

$90:8558 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:855B 89 00 20    BIT #$2000             ;} If speed booster not equipped:
$90:855E D0 1D       BNE $1D    [$857D]     ;/
$90:8560 A0 00 00    LDY #$0000             ;\
$90:8563 8C 96 0A    STY $0A96  [$7E:0A96]  ;} Y = Samus animation frame = 0
$90:8566 AF D1 B5 91 LDA $91B5D1[$91:B5D1]  ;\
$90:856A 85 00       STA $00    [$7E:0000]  ;|
$90:856C B7 00       LDA [$00],y[$91:B5D3]  ;|
$90:856E 29 FF 00    AND #$00FF             ;} Samus animation frame timer = 2 + [Samus animation frame buffer]
$90:8571 18          CLC                    ;|
$90:8572 6D 9C 0A    ADC $0A9C  [$7E:0A9C]  ;|
$90:8575 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$90:8578 A9 00 00    LDA #$0000             ; A = 0
$90:857B 80 62       BRA $62    [$85DF]     ; Return

$90:857D AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:8580 3A          DEC A                  ;} Decrement speed boost timer
$90:8581 8D 3E 0B    STA $0B3E  [$7E:0B3E]  ;/
$90:8584 89 FF 00    BIT #$00FF             ;\
$90:8587 D0 51       BNE $51    [$85DA]     ;} If [speed boost timer] != 0: go to BRANCH_RETURN
$90:8589 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:858C 89 00 04    BIT #$0400             ;} If [speed boost counter] != 4:
$90:858F D0 19       BNE $19    [$85AA]     ;/
$90:8591 18          CLC                    ;\
$90:8592 69 00 01    ADC #$0100             ;} Increment speed boost counter
$90:8595 8D 3E 0B    STA $0B3E  [$7E:0B3E]  ;/
$90:8598 89 00 04    BIT #$0400             ;\
$90:859B F0 0D       BEQ $0D    [$85AA]     ;} If [speed boost counter] = 4:
$90:859D A9 01 00    LDA #$0001             ;\
$90:85A0 8D 40 0B    STA $0B40  [$7E:0B40]  ;} Samus echo sound playing flag = 1
$90:85A3 A9 03 00    LDA #$0003             ;\
$90:85A6 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 3, sound library 3, max queued sounds allowed = 6 (speed booster)

$90:85AA EB          XBA                    ;\
$90:85AB 29 FF 00    AND #$00FF             ;|
$90:85AE 0A          ASL A                  ;} X = [speed boost counter] * 2 <-- X is clobbered if speed booster sound effect was played
$90:85AF AA          TAX                    ;/
$90:85B0 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:85B3 29 00 FF    AND #$FF00             ;|
$90:85B6 1F 1F B6 91 ORA $91B61F,x[$91:B621];} Speed boost timer = [$91:B61F + [X]]
$90:85BA 8D 3E 0B    STA $0B3E  [$7E:0B3E]  ;/
$90:85BD A0 00 00    LDY #$0000             ;\
$90:85C0 8C 96 0A    STY $0A96  [$7E:0A96]  ;} Y = Samus animation frame = 0
$90:85C3 BF DE B5 91 LDA $91B5DE,x[$91:B5E0];\
$90:85C7 85 00       STA $00    [$7E:0000]  ;} $00 = [$91:B5DE + [X]]
$90:85C9 B7 00       LDA [$00],y[$91:B5F3]  ;\
$90:85CB 29 FF 00    AND #$00FF             ;|
$90:85CE 18          CLC                    ;} Samus animation frame timer = [[$00]] + [Samus animation frame buffer]
$90:85CF 6D 9C 0A    ADC $0A9C  [$7E:0A9C]  ;|
$90:85D2 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$90:85D5 A9 00 00    LDA #$0000             ; A = 0
$90:85D8 80 05       BRA $05    [$85DF]     ; Return

; BRANCH_RETURN
$90:85DA B7 00       LDA [$00],y[$91:B29C]  ;\
$90:85DC 29 FF 00    AND #$00FF             ;} A = [[$00] + [Samus animation frame]]

$90:85DF AB          PLB
$90:85E0 28          PLP
$90:85E1 60          RTS
}
}


;;; $85E2..8A4B: Draw Samus ;;;
{
;;; $85E2: Draw Samus (not including arm cannon nor speed echoes) ;;;
{
; Does not draw non-closed arm cannon, speed echoes, nor charge / grapple flare
$90:85E2 08          PHP
$90:85E3 8B          PHB
$90:85E4 E2 20       SEP #$20               ;\
$90:85E6 A9 92       LDA #$92               ;|
$90:85E8 48          PHA                    ;} DB = $92
$90:85E9 AB          PLB                    ;|
$90:85EA C2 30       REP #$30               ;/
$90:85EC AD AA 18    LDA $18AA  [$7E:18AA]  ;\
$90:85EF D0 15       BNE $15    [$8606]     ;} If [Samus knockback timer] = 0:
$90:85F1 AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$90:85F4 F0 10       BEQ $10    [$8606]     ;} If [Samus invincibility timer] != 0:
$90:85F6 AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$90:85F9 D0 0B       BNE $0B    [$8606]     ;} If [special Samus palette timer] = 0:
$90:85FB AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:85FE 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0:
$90:8601 F0 03       BEQ $03    [$8606]     ;/
$90:8603 4C 47 86    JMP $8647  [$90:8647]  ; Go to BRANCH_INVISIBLE

$90:8606 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8609 0A          ASL A                  ;} X = [Samus pose] * 2
$90:860A AA          TAX                    ;/
$90:860B DA          PHX
$90:860C BF 63 92 92 LDA $929263,x[$92:9267];\
$90:8610 18          CLC                    ;|
$90:8611 6D 96 0A    ADC $0A96  [$7E:0A96]  ;} A = Samus top half spritemap index = [$92:9263 + [Samus pose] * 2] + [Samus animation frame]
$90:8614 8D C8 0A    STA $0AC8  [$7E:0AC8]  ;/
$90:8617 48          PHA                    ;\
$90:8618 20 1F 8C    JSR $8C1F  [$90:8C1F]  ;} Calculate Samus spritemap position
$90:861B 68          PLA                    ;/
$90:861C 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap to OAM
$90:8620 FA          PLX
$90:8621 86 24       STX $24    [$7E:0024]  ; $24 = [Samus pose] * 2
$90:8623 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:8626 29 FF 00    AND #$00FF             ;|
$90:8629 0A          ASL A                  ;} Execute [$864E + [Samus movement type] * 2]
$90:862A AA          TAX                    ;|
$90:862B FC 4E 86    JSR ($864E,x)[$90:868D];/
$90:862E 90 17       BCC $17    [$8647]     ; If carry set: (bottom spritemap is drawn)
$90:8630 A6 24       LDX $24    [$7E:0024]  ;\
$90:8632 BF 5D 94 92 LDA $92945D,x[$92:9461];|
$90:8636 18          CLC                    ;} A = Samus bottom half spritemap index = [$92:945D + [Samus pose] * 2] + [Samus animation frame]
$90:8637 6D 96 0A    ADC $0A96  [$7E:0A96]  ;|
$90:863A 8D CA 0A    STA $0ACA  [$7E:0ACA]  ;/
$90:863D AE 04 0B    LDX $0B04  [$7E:0B04]  ; X = [Samus spritemap X position]
$90:8640 AC 06 0B    LDY $0B06  [$7E:0B06]  ; Y = [Samus spritemap Y position]
$90:8643 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap to OAM

; BRANCH_INVISIBLE
$90:8647 22 00 80 92 JSL $928000[$92:8000]  ; Set Samus tiles definitions for current animation
$90:864B AB          PLB
$90:864C 28          PLP
$90:864D 60          RTS
}


;;; $864E: Function pointer table - check if Samus bottom half drawn ;;;
{
$90:864E             dw 868D, ; *0: Standing
                        8686, ;  1: Running
                        8686, ;  2: Normal jumping
                        86C6, ; *3: Spin jumping
                        8688, ;  4: Morph ball - on ground
                        8686, ;  5: Crouching
                        8686, ;  6: Falling
                        8688, ;  7: Unused
                        8688, ;  8: Morph ball - falling
                        8688, ;  9: Unused
                        86EE, ; *Ah: Knockback
                        8686, ;  Bh: Unused
                        8686, ;  Ch: Unused
                        874C, ; *Dh: Unused
                        8686, ;  Eh: Turning around - on ground
                        870C, ; *Fh: Crouching/standing/morphing/unmorphing transition
                        8686, ;  10h: Moonwalking
                        8688, ;  11h: Spring ball - on ground
                        8688, ;  12h: Spring ball - in air
                        8688, ;  13h: Spring ball - falling
                        8768, ; *14h: Wall jumping
                        8686, ;  15h: Ran into a wall
                        8686, ;  16h: Grappling
                        8686, ;  17h: Turning around - jumping
                        8686, ;  18h: Turning around - falling
                        877C, ; *19h: Damage boost
                        8686, ;  1Ah: Grabbed by Draygon
                        8790  ; *1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $8686: Flag that Samus bottom half is drawn ;;;
{
;; Returns:
;;     Carry: Set. Bottom spritemap is drawn

; 1: Running
; 2: Normal jumping
; 5: Crouching
; 6: Falling
; Bh: Unused
; Ch: Unused
; Eh: Turning around - on ground
; 10h: Moonwalking
; 15h: Ran into a wall
; 16h: Grappling
; 17h: Turning around - jumping
; 18h: Turning around - falling
; 1Ah: Grabbed by Draygon

$90:8686 38          SEC
$90:8687 60          RTS
}


;;; $8688: Flag that Samus bottom half is not drawn ;;;
{
;; Returns:
;;     Carry: Clear. Bottom spritemap is not drawn

; 4: Morph ball - on ground
; 7: Unused
; 8: Morph ball - falling
; 9: Unused
; 11h: Spring ball - on ground
; 12h: Spring ball - in air
; 13h: Spring ball - falling
$90:8688 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus bottom half spritemap index = 0
$90:868B 18          CLC
$90:868C 60          RTS
}


;;; $868D: Determine if Samus bottom half is drawn - standing ;;;
{
;; Returns:
;;     Carry: Set. Bottom spritemap is drawn

; If Samus is facing forward without varia/suit, spawns an extra sprite to cover the left part of her chest
$90:868D AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8690 C9 00 00    CMP #$0000             ;} If [Samus pose] = facing forward - power suit: go to BRANCH_FACING_FORWARD
$90:8693 F0 02       BEQ $02    [$8697]     ;/

$90:8695 38          SEC                    ;\
$90:8696 60          RTS                    ;} Return carry set

; BRANCH_FACING_FORWARD
$90:8697 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:869A AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:869D 38          SEC                    ;|
$90:869E E9 07 00    SBC #$0007             ;|
$90:86A1 38          SEC                    ;} OAM entry X position = [Samus X position] - 7 - [layer 1 X position]
$90:86A2 ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:86A5 9D 70 03    STA $0370,x[$7E:0398]  ;/
$90:86A8 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:86AB 38          SEC                    ;|
$90:86AC E9 11 00    SBC #$0011             ;|
$90:86AF 38          SEC                    ;} OAM entry Y position = [Samus Y position] - 11 - [layer 1 X position]
$90:86B0 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:86B3 9D 71 03    STA $0371,x[$7E:0399]  ;/
$90:86B6 A9 21 38    LDA #$3821             ;\
$90:86B9 9D 72 03    STA $0372,x[$7E:039A]  ;} OAM entry tile number = 21h, palette index = 4, priority = 3
$90:86BC 8A          TXA                    ;\
$90:86BD 18          CLC                    ;|
$90:86BE 69 04 00    ADC #$0004             ;} OAM stack pointer = [X] + 4
$90:86C1 8D 90 05    STA $0590  [$7E:0590]  ;/
$90:86C4 80 CF       BRA $CF    [$8695]     ; Return carry set
}


;;; $86C6: Determine if Samus bottom half is drawn - spin jumping ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise

; Samus animation frame is 0 during the spin jump start-up
; Samus animation frame is >= Bh during the wall jump eligible animation
$90:86C6 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:86C9 C9 81 00    CMP #$0081             ;|
$90:86CC F0 14       BEQ $14    [$86E2]     ;} If [Samus pose] = screw attack: return carry set
$90:86CE C9 82 00    CMP #$0082             ;|
$90:86D1 F0 0F       BEQ $0F    [$86E2]     ;/
$90:86D3 C9 1B 00    CMP #$001B             ;\
$90:86D6 F0 0A       BEQ $0A    [$86E2]     ;|
$90:86D8 C9 1C 00    CMP #$001C             ;} If [Samus pose] = space jump: return carry set
$90:86DB F0 05       BEQ $05    [$86E2]     ;/
$90:86DD AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:86E0 D0 02       BNE $02    [$86E4]     ;} If [Samus animation frame] != 0: go to BRANCH_SPINNING

$90:86E2 38          SEC                    ;\
$90:86E3 60          RTS                    ;} Return carry set

; BRANCH_SPINNING
$90:86E4 C9 0B 00    CMP #$000B             ;\
$90:86E7 10 F9       BPL $F9    [$86E2]     ;} If [Samus animation frame] >= Bh: return carry set
$90:86E9 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:86EC 18          CLC                    ;\
$90:86ED 60          RTS                    ;} Return carry clear
}


;;; $86EE: Determine if Samus bottom half is drawn - knockback / crystal flash ending ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise
$90:86EE AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:86F1 C9 D7 00    CMP #$00D7             ;|
$90:86F4 F0 07       BEQ $07    [$86FD]     ;} If [Samus pose] != crystal flash ending:
$90:86F6 C9 D8 00    CMP #$00D8             ;|
$90:86F9 F0 02       BEQ $02    [$86FD]     ;/
$90:86FB 80 08       BRA $08    [$8705]     ; Return carry set

$90:86FD AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:8700 C9 03 00    CMP #$0003             ;} If [Samus animation frame] < 3: go to BRANCH_NO_BOTTOM
$90:8703 30 02       BMI $02    [$8707]     ;/

$90:8705 38          SEC                    ;\
$90:8706 60          RTS                    ;} Return carry set

; BRANCH_NO_BOTTOM
$90:8707 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:870A 18          CLC                    ;\
$90:870B 60          RTS                    ;} Return carry clear
}


;;; $870C: Determine if Samus bottom half is drawn - crouching/standing/morphing/unmorphing transition ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise

; BRANCH_NO_BOTTOM is used for poses 37h..3Ah / 3Dh..40h (morphing/unmorphing transition and some unused poses)
; BRANCH_UNUSED is used for poses DBh..DEh (unused)
$90:870C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:870F C9 F1 00    CMP #$00F1             ;} If [Samus pose] = standing/crouching transition - aiming: return carry set
$90:8712 10 1B       BPL $1B    [$872F]     ;/
$90:8714 C9 DB 00    CMP #$00DB             ;\
$90:8717 10 1D       BPL $1D    [$8736]     ;} If [Samus pose] >= DBh: go to BRANCH_UNUSED
$90:8719 C9 35 00    CMP #$0035             ;\
$90:871C F0 11       BEQ $11    [$872F]     ;|
$90:871E C9 36 00    CMP #$0036             ;|
$90:8721 F0 0C       BEQ $0C    [$872F]     ;|
$90:8723 C9 3B 00    CMP #$003B             ;} If [Samus pose] = standing/crouching transition - not aiming: return carry set
$90:8726 F0 07       BEQ $07    [$872F]     ;|
$90:8728 C9 3C 00    CMP #$003C             ;|
$90:872B F0 02       BEQ $02    [$872F]     ;/
$90:872D 80 02       BRA $02    [$8731]     ; Go to BRANCH_NO_BOTTOM

$90:872F 38          SEC
$90:8730 60          RTS

; BRANCH_NO_BOTTOM
$90:8731 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:8734 18          CLC                    ;\
$90:8735 60          RTS                    ;} Return carry clear

; BRANCH_UNUSED
$90:8736 C9 DD 00    CMP #$00DD             ;\
$90:8739 10 07       BPL $07    [$8742]     ;} If [Samus pose] < DDh:
$90:873B AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:873E F0 EF       BEQ $EF    [$872F]     ;} If [Samus animation frame] = 0: return carry set
$90:8740 80 EF       BRA $EF    [$8731]     ; Go to BRANCH_NO_BOTTOM

$90:8742 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:8745 C9 02 00    CMP #$0002             ;} If [Samus animation frame] = 2: return carry set
$90:8748 F0 E5       BEQ $E5    [$872F]     ;/
$90:874A 80 E5       BRA $E5    [$8731]     ; Go to BRANCH_NO_BOTTOM
}


;;; $874C: Determine if Samus bottom half is drawn - unused movement type Dh ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise
$90:874C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:874F C9 65 00    CMP #$0065             ;|
$90:8752 F0 05       BEQ $05    [$8759]     ;} If [Samus pose] != 65h/66h: return carry set
$90:8754 C9 66 00    CMP #$0066             ;|
$90:8757 D0 08       BNE $08    [$8761]     ;/

$90:8759 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:875C C9 01 00    CMP #$0001             ;} If [Samus animation frame] >= 1: go to BRANCH_NO_BOTTOM
$90:875F 10 02       BPL $02    [$8763]     ;/

$90:8761 38          SEC                    ;\
$90:8762 60          RTS                    ;} Return carry set

; BRANCH_NO_BOTTOM
$90:8763 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:8766 18          CLC                    ;\
$90:8767 60          RTS                    ;} Return carry clear
}


;;; $8768: Determine if Samus bottom half is drawn - wall jumping ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise
$90:8768 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:876B C9 03 00    CMP #$0003             ;} If [Samus animation frame] >= 3: go to BRANCH_SPINNING
$90:876E 10 02       BPL $02    [$8772]     ;/

$90:8770 38          SEC                    ;\
$90:8771 60          RTS                    ;} Return carry set

; BRANCH_SPINNING
$90:8772 C9 0D 00    CMP #$000D             ;\
$90:8775 10 F9       BPL $F9    [$8770]     ;} If [Samus animation frame] >= Dh (space jump / screw attack): return carry set
$90:8777 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:877A 18          CLC                    ;\
$90:877B 60          RTS                    ;} Return carry clear
}


;;; $877C: Determine if Samus bottom half is drawn - damage boost ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise
$90:877C AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:877F C9 02 00    CMP #$0002             ;} If [Samus animation frame] >= 2: go to BRANCH_SPINNING
$90:8782 10 02       BPL $02    [$8786]     ;/

$90:8784 38          SEC                    ;\
$90:8785 60          RTS                    ;} Return carry set

; BRANCH_SPINNING
$90:8786 C9 09 00    CMP #$0009             ;\
$90:8789 10 F9       BPL $F9    [$8784]     ;} If [Samus animation frame] >= 9: return carry set
$90:878B 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:878E 18          CLC                    ;\
$90:878F 60          RTS                    ;} Return carry clear
}


;;; $8790: Determine if Samus bottom half is drawn - shinespark / crystal flash / drained by metroid / damaged by MB's attacks ;;;
{
;; Returns:
;;     Carry: Set if bottom spritemap is drawn, clear otherwise
$90:8790 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8793 C9 CF 00    CMP #$00CF             ;} If [Samus pose] = shinespark:
$90:8796 10 0C       BPL $0C    [$87A4]     ;/
$90:8798 C9 CB 00    CMP #$00CB             ;\
$90:879B F0 1B       BEQ $1B    [$87B8]     ;|
$90:879D C9 CC 00    CMP #$00CC             ;} If [Samus pose] = shinespark - vertical: go to BRANCH_NO_BOTTOM
$90:87A0 F0 16       BEQ $16    [$87B8]     ;/
$90:87A2 80 12       BRA $12    [$87B6]     ; Return carry set

$90:87A4 C9 E8 00    CMP #$00E8             ;\
$90:87A7 F0 05       BEQ $05    [$87AE]     ;|
$90:87A9 C9 E9 00    CMP #$00E9             ;} If [Samus pose] != Samus drained - crouching/falling: return carry set
$90:87AC D0 08       BNE $08    [$87B6]     ;/

$90:87AE AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:87B1 C9 02 00    CMP #$0002             ;} If [Samus animation frame] < 2: go to BRANCH_NO_BOTTOM
$90:87B4 30 02       BMI $02    [$87B8]     ;/

$90:87B6 38          SEC                    ;\
$90:87B7 60          RTS                    ;} Return carry set

; BRANCH_NO_BOTTOM
$90:87B8 9C CA 0A    STZ $0ACA  [$7E:0ACA]  ; Samus' bottom half spritemap index = 0
$90:87BB 18          CLC                    ;\
$90:87BC 60          RTS                    ;} Return carry clear
}


;;; $87BD: Draw Samus echoes ;;;
{
; Draws the echoes that trail behind Samus when she's running or shinesparking, but not during the shinespark crash
$90:87BD 08          PHP
$90:87BE C2 30       REP #$30
$90:87C0 AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$90:87C3 30 25       BMI $25    [$87EA]     ;} If speed echoes are merging back into Samus: go to BRANCH_MERGING_ECHOES
$90:87C5 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:87C8 29 00 FF    AND #$FF00             ;|
$90:87CB C9 00 04    CMP #$0400             ;} If [speed boost counter] != 4:
$90:87CE F0 02       BEQ $02    [$87D2]     ;/
$90:87D0 28          PLP
$90:87D1 60          RTS                    ; Return

$90:87D2 AD B2 0A    LDA $0AB2  [$7E:0AB2]  ;\
$90:87D5 F0 06       BEQ $06    [$87DD]     ;} If [speed echo 1 X position] != 0:
$90:87D7 A0 02 00    LDY #$0002             ; Y = 2 (speed echo index)
$90:87DA 20 55 88    JSR $8855  [$90:8855]  ; Draw Samus echo

$90:87DD AD B0 0A    LDA $0AB0  [$7E:0AB0]  ;\
$90:87E0 F0 06       BEQ $06    [$87E8]     ;} If [speed echo 0 X position] != 0:
$90:87E2 A0 00 00    LDY #$0000             ; Y = 0 (speed echo index)
$90:87E5 20 55 88    JSR $8855  [$90:8855]  ; Draw Samus echo

$90:87E8 28          PLP
$90:87E9 60          RTS                    ; Return

; BRANCH_MERGING_ECHOES
$90:87EA A0 02 00    LDY #$0002             ; Y = 2 (speed echo index)

; LOOP
$90:87ED B9 B0 0A    LDA $0AB0,y[$7E:0AB2]  ;\
$90:87F0 F0 50       BEQ $50    [$8842]     ;} If [speed echo X position] = 0: go to BRANCH_NEXT
$90:87F2 B9 B8 0A    LDA $0AB8,y[$7E:0ABA]  ;\
$90:87F5 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [speed echo Y position] = [Samus Y position]: go to BRANCH_NO_Y_ADJUSTMENT
$90:87F8 F0 12       BEQ $12    [$880C]     ;/
$90:87FA 30 09       BMI $09    [$8805]     ; If [speed echo Y position] > [Samus Y position]:
$90:87FC 38          SEC                    ;\
$90:87FD E9 02 00    SBC #$0002             ;} Speed echo Y position -= 2
$90:8800 99 B8 0A    STA $0AB8,y[$7E:0ABA]  ;/
$90:8803 80 07       BRA $07    [$880C]

$90:8805 18          CLC                    ;\ Else ([speed echo Y position] < [Samus Y position]):
$90:8806 69 02 00    ADC #$0002             ;} Speed echo Y position += 2
$90:8809 99 B8 0A    STA $0AB8,y[$7E:0ABA]  ;/

; BRANCH_NO_Y_ADJUSTMENT
$90:880C B9 C0 0A    LDA $0AC0,y[$7E:0AC2]  ;\
$90:880F 30 17       BMI $17    [$8828]     ;} If [speed echo X speed] >= 0:
$90:8811 B9 B0 0A    LDA $0AB0,y[$7E:0AB2]  ;\
$90:8814 18          CLC                    ;|
$90:8815 79 C0 0A    ADC $0AC0,y[$7E:0AC2]  ;} Speed echo X position += [speed echo X speed]
$90:8818 99 B0 0A    STA $0AB0,y[$7E:0AB2]  ;/
$90:881B CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;\
$90:881E 30 1F       BMI $1F    [$883F]     ;} If [speed echo X position] >= [Samus X position]:
$90:8820 A9 00 00    LDA #$0000             ;\
$90:8823 99 B0 0A    STA $0AB0,y[$7E:0AB0]  ;} Speed echo X position = 0
$90:8826 80 1A       BRA $1A    [$8842]     ; Go to BRANCH_NEXT

$90:8828 B9 B0 0A    LDA $0AB0,y[$7E:0AB2]  ;\ Else ([speed echo X speed] < 0):
$90:882B 18          CLC                    ;|
$90:882C 79 C0 0A    ADC $0AC0,y[$7E:0AC2]  ;} Speed echo X position += [speed echo X speed]
$90:882F 99 B0 0A    STA $0AB0,y[$7E:0AB2]  ;/
$90:8832 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;\
$90:8835 10 08       BPL $08    [$883F]     ;} If [speed echo X position] < [Samus X position]:
$90:8837 A9 00 00    LDA #$0000             ;\
$90:883A 99 B0 0A    STA $0AB0,y[$7E:0AB2]  ;} Speed echo X position = 0
$90:883D 80 03       BRA $03    [$8842]     ; Go to BRANCH_NEXT

$90:883F 20 55 88    JSR $8855  [$90:8855]  ; Draw Samus echo

; BRANCH_NEXT
$90:8842 88          DEY                    ;\
$90:8843 88          DEY                    ;} Y -= 2
$90:8844 10 A7       BPL $A7    [$87ED]     ; If [Y] >= 0: go to LOOP
$90:8846 AD B2 0A    LDA $0AB2  [$7E:0AB2]  ;\
$90:8849 D0 08       BNE $08    [$8853]     ;} If [speed echo 1 X position] = 0:
$90:884B AD B0 0A    LDA $0AB0  [$7E:0AB0]  ;\
$90:884E D0 03       BNE $03    [$8853]     ;} If [speed echo 0 X position] = 0:
$90:8850 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; $0AAE = 0

$90:8853 28          PLP
$90:8854 60          RTS
}


;;; $8855: Draw Samus echo ;;;
{
;; Parameters:
;;     Y: Speed echo index
$90:8855 5A          PHY
$90:8856 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8859 0A          ASL A                  ;|
$90:885A 0A          ASL A                  ;|
$90:885B 0A          ASL A                  ;|
$90:885C AA          TAX                    ;} $12 = [$91:B62D + [Samus pose] * 8] (Y offset of Samus GFX)
$90:885D BF 2D B6 91 LDA $91B62D,x[$91:B67D];|
$90:8861 29 FF 00    AND #$00FF             ;|
$90:8864 85 12       STA $12    [$7E:0012]  ;/
$90:8866 B9 B0 0A    LDA $0AB0,y[$7E:0AB0]  ;\
$90:8869 38          SEC                    ;|
$90:886A ED 11 09    SBC $0911  [$7E:0911]  ;} X = [speed echo X position] - [layer 1 X position]
$90:886D AA          TAX                    ;/
$90:886E B9 B8 0A    LDA $0AB8,y[$7E:0AB8]  ;\
$90:8871 38          SEC                    ;|
$90:8872 E5 12       SBC $12    [$7E:0012]  ;} Y = [speed echo Y position] - [$12] - [layer 1 Y position]
$90:8874 ED 15 09    SBC $0915  [$7E:0915]  ;/
$90:8877 30 05       BMI $05    [$887E]     ;\
$90:8879 C9 F8 00    CMP #$00F8             ;} If not 0 <= [Y] < F8h:
$90:887C 30 02       BMI $02    [$8880]     ;/
$90:887E 7A          PLY
$90:887F 60          RTS                    ; Return

$90:8880 A8          TAY
$90:8881 AD C8 0A    LDA $0AC8  [$7E:0AC8]  ; A = [Samus' top half spritemap index]
$90:8884 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap [A] to OAM at position ([X], [Y])
$90:8888 7A          PLY                    ; Y = (speed echo index)
$90:8889 AD CA 0A    LDA $0ACA  [$7E:0ACA]  ;\
$90:888C F0 2B       BEQ $2B    [$88B9]     ;} If [Samus' bottom half spritemap index] = 0: return
$90:888E AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8891 0A          ASL A                  ;|
$90:8892 0A          ASL A                  ;|
$90:8893 0A          ASL A                  ;|
$90:8894 AA          TAX                    ;} $12 = [$91:B62D + [Samus pose] * 8] (Y offset of Samus GFX)
$90:8895 BF 2D B6 91 LDA $91B62D,x[$91:B67D];|
$90:8899 29 FF 00    AND #$00FF             ;|
$90:889C 85 12       STA $12    [$7E:0012]  ;/
$90:889E 5A          PHY
$90:889F B9 B0 0A    LDA $0AB0,y[$7E:0AB0]  ;\
$90:88A2 38          SEC                    ;|
$90:88A3 ED 11 09    SBC $0911  [$7E:0911]  ;} X = [speed echo X position] - [layer 1 X position]
$90:88A6 AA          TAX                    ;/
$90:88A7 B9 B8 0A    LDA $0AB8,y[$7E:0AB8]  ;\
$90:88AA 38          SEC                    ;|
$90:88AB E5 12       SBC $12    [$7E:0012]  ;} Y = [speed echo Y position] - [$12] - [layer 1 Y position]
$90:88AD ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:88B0 A8          TAY                    ;/
$90:88B1 AD CA 0A    LDA $0ACA  [$7E:0ACA]  ; A = [Samus' bottom half spritemap index]
$90:88B4 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap [A] to OAM at position ([X], [Y])
$90:88B8 7A          PLY

$90:88B9 60          RTS
}


;;; $88BA: Draw shinespark crash echo circle ;;;
{
;; Parameters:
;;     X: Speed echo index

; Draws the echoes that circle around Samus on shinespark crash

$90:88BA 08          PHP
$90:88BB 8B          PHB
$90:88BC E2 20       SEP #$20               ;\
$90:88BE A9 92       LDA #$92               ;|
$90:88C0 48          PHA                    ;} DB = $92
$90:88C1 AB          PLB                    ;|
$90:88C2 C2 30       REP #$30               ;/
$90:88C4 9B          TXY                    ; Y = [X] (speed echo index)
$90:88C5 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:88C8 89 01 00    BIT #$0001             ;} If [frame counter] % 2 = 0:
$90:88CB D0 03       BNE $03    [$88D0]     ;/
$90:88CD 4C 50 89    JMP $8950  [$90:8950]  ; Return

$90:88D0 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:88D3 0A          ASL A                  ;} X = [Samus pose] * 2
$90:88D4 AA          TAX                    ;/
$90:88D5 DA          PHX
$90:88D6 5A          PHY
$90:88D7 BF 63 92 92 LDA $929263,x[$92:93F5];\
$90:88DB 18          CLC                    ;} A = [$92:9263 + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - top half)
$90:88DC 6D 96 0A    ADC $0A96  [$7E:0A96]  ;/
$90:88DF 48          PHA
$90:88E0 8A          TXA                    ;\
$90:88E1 0A          ASL A                  ;|
$90:88E2 0A          ASL A                  ;|
$90:88E3 AA          TAX                    ;} $12 = [$91:B62D + [Samus pose] * 8] (Y offset of Samus GFX)
$90:88E4 BF 2D B6 91 LDA $91B62D,x[$91:BC75];|
$90:88E8 29 FF 00    AND #$00FF             ;|
$90:88EB 85 12       STA $12    [$7E:0012]  ;/
$90:88ED B9 B0 0A    LDA $0AB0,y[$7E:0AB2]  ;\
$90:88F0 38          SEC                    ;|
$90:88F1 ED 11 09    SBC $0911  [$7E:0911]  ;} X = [speed echo X position] - [layer 1 X position]
$90:88F4 AA          TAX                    ;/
$90:88F5 B9 B8 0A    LDA $0AB8,y[$7E:0ABA]  ;\
$90:88F8 38          SEC                    ;|
$90:88F9 E5 12       SBC $12    [$7E:0012]  ;} Y = [speed echo Y position] - [$12] - [layer 1 Y position]
$90:88FB ED 15 09    SBC $0915  [$7E:0915]  ;/
$90:88FE 30 05       BMI $05    [$8905]     ;\
$90:8900 C9 F8 00    CMP #$00F8             ;} If not 0 <= [Y] < F8h:
$90:8903 30 05       BMI $05    [$890A]     ;/
$90:8905 68          PLA                    ;\
$90:8906 7A          PLY                    ;|
$90:8907 FA          PLX                    ;} Return
$90:8908 80 46       BRA $46    [$8950]     ;/

$90:890A A8          TAY
$90:890B 68          PLA
$90:890C 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap [A] to OAM at position ([X], [Y])
$90:8910 7A          PLY                    ; Y = (speed echo index)
$90:8911 FA          PLX
$90:8912 86 24       STX $24    [$7E:0024]  ; $24 = [X]
$90:8914 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:8917 29 FF 00    AND #$00FF             ;|
$90:891A 0A          ASL A                  ;} Execute [$864E + [Samus movement type] * 2]
$90:891B AA          TAX                    ;|
$90:891C FC 4E 86    JSR ($864E,x)[$90:8790];/
$90:891F 90 2F       BCC $2F    [$8950]     ; If carry set: (bottom spritemap is drawn)
$90:8921 A6 24       LDX $24    [$7E:0024]  ;\
$90:8923 BF 5D 94 92 LDA $92945D,x[$92:95EF];|
$90:8927 18          CLC                    ;} A = [$92:945D + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - bottom half)
$90:8928 6D 96 0A    ADC $0A96  [$7E:0A96]  ;/
$90:892B 48          PHA
$90:892C 8A          TXA                    ;\
$90:892D 0A          ASL A                  ;|
$90:892E 0A          ASL A                  ;|
$90:892F AA          TAX                    ;} $12 = [$91:B62D + [Samus pose] * 8] (Y offset of Samus GFX)
$90:8930 BF 2D B6 91 LDA $91B62D,x[$91:BC75];|
$90:8934 29 FF 00    AND #$00FF             ;|
$90:8937 85 12       STA $12    [$7E:0012]  ;/
$90:8939 B9 B0 0A    LDA $0AB0,y[$7E:0AB2]  ;\
$90:893C 38          SEC                    ;|
$90:893D ED 11 09    SBC $0911  [$7E:0911]  ;} X = [speed echo X position] - [layer 1 X position]
$90:8940 AA          TAX                    ;/
$90:8941 B9 B8 0A    LDA $0AB8,y[$7E:0ABA]  ;\
$90:8944 38          SEC                    ;|
$90:8945 E5 12       SBC $12    [$7E:0012]  ;} Y = [speed echo Y position] - [$12] - [layer 1 Y position]
$90:8947 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:894A A8          TAY                    ;/
$90:894B 68          PLA
$90:894C 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap [A] to OAM at position ([X], [Y])

$90:8950 AB          PLB
$90:8951 28          PLP
$90:8952 60          RTS
}


;;; $8953: Draw shinespark crash echo projectiles ;;;
{
; Draws the echoes that fire away from Samus after shinespark crash
$90:8953 08          PHP
$90:8954 C2 30       REP #$30
$90:8956 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:8959 89 01 00    BIT #$0001             ;} If [frame counter] % 2 = 0: return
$90:895C F0 16       BEQ $16    [$8974]     ;/
$90:895E AD C6 0A    LDA $0AC6  [$7E:0AC6]  ;\
$90:8961 F0 06       BEQ $06    [$8969]     ;} If [draw speed echo 3 flag] != 0:
$90:8963 A0 06 00    LDY #$0006             ; Y = 6 (speed echo index)
$90:8966 20 55 88    JSR $8855  [$90:8855]  ; Draw Samus echo

$90:8969 AD C4 0A    LDA $0AC4  [$7E:0AC4]  ;\
$90:896C F0 06       BEQ $06    [$8974]     ;} If [draw speed echo 2 flag] != 0:
$90:896E A0 04 00    LDY #$0004             ; Y = 4 (speed echo index)
$90:8971 20 55 88    JSR $8855  [$90:8855]  ; Draw Samus echo

$90:8974 28          PLP
$90:8975 6B          RTL
}


;;; $8976: Draw Samus starting death animation ;;;
{
$90:8976 08          PHP
$90:8977 8B          PHB
$90:8978 4B          PHK                    ;\
$90:8979 AB          PLB                    ;} DB = $90
$90:897A C2 30       REP #$30
$90:897C AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$90:897F 3A          DEC A                  ;} Decrement Samus animation frame timer
$90:8980 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$90:8983 F0 02       BEQ $02    [$8987]     ;\
$90:8985 10 0A       BPL $0A    [$8991]     ;} If [Samus animation frame timer] <= 0:
$90:8987 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:898A 1A          INC A                  ;} Increment Samus animation frame
$90:898B 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$90:898E 20 DC 82    JSR $82DC  [$90:82DC]  ; Handle Samus animation delay

$90:8991 22 98 89 90 JSL $908998[$90:8998]  ; Draw Samus during death animation
$90:8995 AB          PLB
$90:8996 28          PLP
$90:8997 6B          RTL
}


;;; $8998: Draw Samus during death animation ;;;
{
; This is the same as $8A00, except that layer 1 position is added to Samus spritemap position for some reason,
; to account for this, there's code at $9B:B409 that subtracts the layer 1 position from Samus position...
$90:8998 08          PHP
$90:8999 8B          PHB
$90:899A E2 20       SEP #$20               ;\
$90:899C A9 92       LDA #$92               ;|
$90:899E 48          PHA                    ;} DB = $92
$90:899F AB          PLB                    ;|
$90:89A0 C2 30       REP #$30               ;/
$90:89A2 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:89A5 0A          ASL A                  ;} X = [Samus pose] * 2
$90:89A6 AA          TAX                    ;/
$90:89A7 DA          PHX
$90:89A8 BF 63 92 92 LDA $929263,x[$92:9411];\
$90:89AC 18          CLC                    ;} A = [$92:9263 + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - top half)
$90:89AD 6D 96 0A    ADC $0A96  [$7E:0A96]  ;/
$90:89B0 48          PHA
$90:89B1 20 1F 8C    JSR $8C1F  [$90:8C1F]  ; Calculate Samus spritemap position
$90:89B4 AD 04 0B    LDA $0B04  [$7E:0B04]  ;\
$90:89B7 18          CLC                    ;|
$90:89B8 6D 11 09    ADC $0911  [$7E:0911]  ;} X = [layer 1 X position] + [Samus spritemap X position]
$90:89BB AA          TAX                    ;/
$90:89BC AD 06 0B    LDA $0B06  [$7E:0B06]  ;\
$90:89BF 18          CLC                    ;|
$90:89C0 6D 15 09    ADC $0915  [$7E:0915]  ;} Y = [layer 1 Y position] + [Samus spritemap Y position]
$90:89C3 A8          TAY                    ;/
$90:89C4 68          PLA
$90:89C5 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap [A] to OAM at position ([X], [Y])
$90:89C9 FA          PLX
$90:89CA 86 24       STX $24    [$7E:0024]  ; $24 = [X]
$90:89CC AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:89CF 29 FF 00    AND #$00FF             ;|
$90:89D2 0A          ASL A                  ;} Execute [$864E + [Samus movement type] * 2]
$90:89D3 AA          TAX                    ;|
$90:89D4 FC 4E 86    JSR ($864E,x)[$90:86EE];/
$90:89D7 90 20       BCC $20    [$89F9]     ; If carry set: (bottom spritemap is drawn)
$90:89D9 A6 24       LDX $24    [$7E:0024]  ;\
$90:89DB BF 5D 94 92 LDA $92945D,x[$92:960B];|
$90:89DF 18          CLC                    ;} A = [$92:945D + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - bottom half)
$90:89E0 6D 96 0A    ADC $0A96  [$7E:0A96]  ;/
$90:89E3 48          PHA
$90:89E4 AD 04 0B    LDA $0B04  [$7E:0B04]  ;\
$90:89E7 18          CLC                    ;|
$90:89E8 6D 11 09    ADC $0911  [$7E:0911]  ;} X = [layer 1 X position] + [Samus spritemap X position]
$90:89EB AA          TAX                    ;/
$90:89EC AD 06 0B    LDA $0B06  [$7E:0B06]  ;\
$90:89EF 18          CLC                    ;|
$90:89F0 6D 15 09    ADC $0915  [$7E:0915]  ;} Y = [layer 1 Y position] + [Samus spritemap Y position]
$90:89F3 A8          TAY                    ;/
$90:89F4 68          PLA
$90:89F5 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap [A] to OAM at position ([X], [Y])

$90:89F9 22 00 80 92 JSL $928000[$92:8000]  ; Set Samus tiles definitions for current animation
$90:89FD AB          PLB
$90:89FE 28          PLP
$90:89FF 6B          RTL
}


;;; $8A00: Draw inanimate Samus ;;;
{
; Used to draw Samus during:
;     Door transition
;     Using elevator
;     Taken fatal damage
;     Game state 15h (death sequence, pre-flashing)

; Compared to $85E2, this routine doesn't update $0A96/$0ACA for speed echo drawing,
; and doesn't have the checks for being invisible
$90:8A00 08          PHP
$90:8A01 8B          PHB
$90:8A02 E2 20       SEP #$20               ;\
$90:8A04 A9 92       LDA #$92               ;|
$90:8A06 48          PHA                    ;} DB = $92
$90:8A07 AB          PLB                    ;|
$90:8A08 C2 30       REP #$30               ;/
$90:8A0A AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8A0D 0A          ASL A                  ;} X = [Samus pose] * 2
$90:8A0E AA          TAX                    ;/
$90:8A0F DA          PHX
$90:8A10 BF 63 92 92 LDA $929263,x[$92:9275];\
$90:8A14 18          CLC                    ;} A = [$92:9263 + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - top half)
$90:8A15 6D 96 0A    ADC $0A96  [$7E:0A96]  ;/
$90:8A18 48          PHA                    ;\
$90:8A19 20 1F 8C    JSR $8C1F  [$90:8C1F]  ;} Calculate Samus spritemap position
$90:8A1C 68          PLA                    ;/
$90:8A1D 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap to OAM
$90:8A21 FA          PLX
$90:8A22 86 24       STX $24    [$7E:0024]  ; $24 = [Samus pose] * 2
$90:8A24 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:8A27 29 FF 00    AND #$00FF             ;|
$90:8A2A 0A          ASL A                  ;} Execute [$864E + [Samus movement type] * 2]
$90:8A2B AA          TAX                    ;|
$90:8A2C FC 4E 86    JSR ($864E,x)[$90:8686];/
$90:8A2F 90 14       BCC $14    [$8A45]     ; If carry set: (bottom spritemap is drawn)
$90:8A31 A6 24       LDX $24    [$7E:0024]  ;\
$90:8A33 BF 5D 94 92 LDA $92945D,x[$92:946F];|
$90:8A37 18          CLC                    ;} A = [$92:945D + [Samus pose] * 2] + [Samus animation frame] (Samus spritemap table index - bottom half)
$90:8A38 6D 96 0A    ADC $0A96  [$7E:0A96]  ;/
$90:8A3B AE 04 0B    LDX $0B04  [$7E:0B04]  ; X = [Samus spritemap X position]
$90:8A3E AC 06 0B    LDY $0B06  [$7E:0B06]  ; Y = [Samus spritemap Y position]
$90:8A41 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap to OAM

$90:8A45 22 00 80 92 JSL $928000[$92:8000]  ; Set Samus tiles definitions for current animation
$90:8A49 AB          PLB
$90:8A4A 28          PLP
$90:8A4B 6B          RTL
}
}


;;; $8A4C..8C1E: Handle atmospheric effects ;;;
{
;;; $8A4C: Handle atmospheric effects ;;;
{
; Water splash, air bubbles, footsteps
$90:8A4C 08          PHP
$90:8A4D C2 30       REP #$30
$90:8A4F A0 06 00    LDY #$0006             ; Y = 6 (atmospheric graphic index)

; LOOP
$90:8A52 B9 EC 0A    LDA $0AEC,y[$7E:0AF2]  ;\
$90:8A55 F0 58       BEQ $58    [$8AAF]     ;} If [atmospheric graphic animation frame / type] = 0: go to BRANCH_NEXT
$90:8A57 48          PHA                    ;\
$90:8A58 29 FF 00    AND #$00FF             ;|
$90:8A5B 0A          ASL A                  ;} $12 = [atmospheric graphic animation frame]
$90:8A5C 85 12       STA $12    [$7E:0012]  ;|
$90:8A5E 68          PLA                    ;/
$90:8A5F EB          XBA                    ;\
$90:8A60 29 FF 00    AND #$00FF             ;|
$90:8A63 0A          ASL A                  ;} X = [atmospheric graphic type] * 2
$90:8A64 AA          TAX                    ;/
$90:8A65 B9 D4 0A    LDA $0AD4,y[$7E:0ADA]  ;\
$90:8A68 3A          DEC A                  ;} Decrement atmospheric graphic animation timer
$90:8A69 99 D4 0A    STA $0AD4,y[$7E:0ADA]  ;/
$90:8A6C F0 18       BEQ $18    [$8A86]     ; If [atmospheric graphic animation timer] != 0:
$90:8A6E 10 3C       BPL $3C    [$8AAC]     ; If [atmospheric graphic animation timer] < 0:
$90:8A70 C9 00 80    CMP #$8000             ;\
$90:8A73 D0 3A       BNE $3A    [$8AAF]     ;} If [atmospheric graphic animation timer] != 8000h: go to BRANCH_NEXT
$90:8A75 DA          PHX                    ;\
$90:8A76 BD 93 8B    LDA $8B93,x[$90:8B95]  ;|
$90:8A79 18          CLC                    ;|
$90:8A7A 65 12       ADC $12    [$7E:0012]  ;|
$90:8A7C AA          TAX                    ;} Atmospheric graphic animation timer = [[$8B93 + [atmospheric graphic type] * 2] + [atmospheric graphic animation frame]]
$90:8A7D BD 00 00    LDA $0000,x[$90:8BA5]  ;|
$90:8A80 99 D4 0A    STA $0AD4,y[$7E:0AD4]  ;|
$90:8A83 FA          PLX                    ;/
$90:8A84 80 26       BRA $26    [$8AAC]

$90:8A86 DA          PHX                    ;\ Else ([atmospheric graphic animation timer] = 0):
$90:8A87 BD 93 8B    LDA $8B93,x[$90:8B9F]  ;|
$90:8A8A 18          CLC                    ;|
$90:8A8B 65 12       ADC $12    [$7E:0012]  ;|
$90:8A8D AA          TAX                    ;} Atmospheric graphic animation timer = [[$8B93 + [atmospheric graphic type] * 2] + [atmospheric graphic animation frame]]
$90:8A8E BD 00 00    LDA $0000,x[$90:8BDF]  ;|
$90:8A91 99 D4 0A    STA $0AD4,y[$7E:0ADA]  ;|
$90:8A94 FA          PLX                    ;/
$90:8A95 B9 EC 0A    LDA $0AEC,y[$7E:0AF2]  ;\
$90:8A98 1A          INC A                  ;} Increment atmospheric graphics animation frame
$90:8A99 99 EC 0A    STA $0AEC,y[$7E:0AF2]  ;/
$90:8A9C 29 FF 00    AND #$00FF             ;\
$90:8A9F DD EF 8B    CMP $8BEF,x[$90:8BFB]  ;} If [atmospheric graphics animation frame] >= [$8BEF + [atmospheric graphic type] * 2]:
$90:8AA2 30 08       BMI $08    [$8AAC]     ;/
$90:8AA4 A9 00 00    LDA #$0000             ;\
$90:8AA7 99 EC 0A    STA $0AEC,y[$7E:0AF2]  ;} Atmospheric graphic animation frame / type = 0
$90:8AAA 80 03       BRA $03    [$8AAF]

$90:8AAC FC B5 8A    JSR ($8AB5,x)[$90:8B57]; Execute [$8AB5 + [atmospheric graphic type] * 2]

; BRANCH_NEXT
$90:8AAF 88          DEY                    ;\
$90:8AB0 88          DEY                    ;} Y -= 2
$90:8AB1 10 9F       BPL $9F    [$8A52]     ; If [Y] >= 0: go to LOOP
$90:8AB3 28          PLP
$90:8AB4 60          RTS

$90:8AB5             dw 0000, 8AC5, 8AC5, 8B16, 8B2E, 8B64, 8B57, 8B57
}


;;; $8AC5: Handle atmospheric effects - [atmospheric graphic type] = 1/2 (footstep splashes) ;;;
{
;; Parameters:
;;     X: Atmospheric graphic type
;;     Y: Atmospheric graphic index

; Called by the subroutines for other atmospheric graphic types too
$90:8AC5 5A          PHY
$90:8AC6 B9 EC 0A    LDA $0AEC,y[$7E:0AF2]  ;\
$90:8AC9 29 FF 00    AND #$00FF             ;|
$90:8ACC 0A          ASL A                  ;} $12 = [atmospheric graphic animation frame]
$90:8ACD 85 12       STA $12    [$7E:0012]  ;/
$90:8ACF DA          PHX
$90:8AD0 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:8AD3 B9 DC 0A    LDA $0ADC,y[$7E:0AE2]  ;\
$90:8AD6 38          SEC                    ;|
$90:8AD7 ED 11 09    SBC $0911  [$7E:0911]  ;} If [atmospheric graphics X position] - [layer 1 X position] - 4 < 0: return
$90:8ADA E9 04 00    SBC #$0004             ;|
$90:8ADD 30 34       BMI $34    [$8B13]     ;/
$90:8ADF C9 00 01    CMP #$0100             ;\
$90:8AE2 10 2F       BPL $2F    [$8B13]     ;} If [atmospheric graphics X position] - [layer 1 X position] - 4 >= 100h: return
$90:8AE4 9D 70 03    STA $0370,x[$7E:03A4]  ; OAM entry X position = [atmospheric graphics X position] - [layer 1 X position] - 4
$90:8AE7 B9 E4 0A    LDA $0AE4,y[$7E:0AEA]  ;\
$90:8AEA 38          SEC                    ;|
$90:8AEB ED 15 09    SBC $0915  [$7E:0915]  ;} If [atmospheric graphics Y position] - [layer 1 Y position] - 4 < 0: return
$90:8AEE E9 04 00    SBC #$0004             ;|
$90:8AF1 30 20       BMI $20    [$8B13]     ;/
$90:8AF3 C9 00 01    CMP #$0100             ;\
$90:8AF6 10 1B       BPL $1B    [$8B13]     ;} If [atmospheric graphics Y position] - [layer 1 Y position] - 4 >= 100h: return
$90:8AF8 9D 71 03    STA $0371,x[$7E:03A5]  ; OAM entry Y position = [atmospheric graphics Y position] - [layer 1 Y position] - 4
$90:8AFB 7A          PLY                    ;\
$90:8AFC B9 FF 8B    LDA $8BFF,y[$90:8C0B]  ;|
$90:8AFF 18          CLC                    ;|
$90:8B00 65 12       ADC $12    [$7E:0012]  ;} OAM entry tile number and attributes = [[$8BFF + [atmospheric graphic type]] + [atmospheric graphic animation frame]]
$90:8B02 A8          TAY                    ;|
$90:8B03 B9 00 00    LDA $0000,y[$90:8C17]  ;|
$90:8B06 9D 72 03    STA $0372,x[$7E:03A6]  ;/
$90:8B09 8A          TXA                    ;\
$90:8B0A 18          CLC                    ;|
$90:8B0B 69 04 00    ADC #$0004             ;} OAM stack pointer += 4
$90:8B0E 8D 90 05    STA $0590  [$7E:0590]  ;/
$90:8B11 7A          PLY
$90:8B12 60          RTS                    ; Return

$90:8B13 7A          PLY
$90:8B14 7A          PLY
$90:8B15 60          RTS
}


;;; $8B16: Handle atmospheric effects - [atmospheric graphic type] = 3 (diving splash) ;;;
{
;; Parameters:
;;     Y: Atmospheric graphic index
$90:8B16 5A          PHY
$90:8B17 B9 EC 0A    LDA $0AEC,y[$7E:0AEC]  ;\
$90:8B1A 29 FF 00    AND #$00FF             ;} $12 = [atmospheric graphic animation frame]
$90:8B1D 85 12       STA $12    [$7E:0012]  ;/
$90:8B1F AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:8B22 99 E4 0A    STA $0AE4,y[$7E:0AE4]  ;} Atmospheric graphics Y position = [FX Y position]
$90:8B25 A9 8F 01    LDA #$018F             ;\
$90:8B28 18          CLC                    ;|
$90:8B29 65 12       ADC $12    [$7E:0012]  ;} Samus spritemap table index = 18Fh + [atmospheric graphic animation frame]
$90:8B2B 48          PHA                    ;/
$90:8B2C 80 46       BRA $46    [$8B74]     ; Add atmospheric spritemap to OAM
}


;;; $8B2E: Handle atmospheric effects - [atmospheric graphic type] = 4 (lava surface damage) ;;;
{
;; Parameters:
;;     X: Atmospheric graphic type
;;     Y: Atmospheric graphic index
$90:8B2E 98          TYA                    ;\
$90:8B2F 89 04 00    BIT #$0004             ;} If [atmospheric graphic index] < 4:
$90:8B32 D0 0C       BNE $0C    [$8B40]     ;/
$90:8B34 B9 DC 0A    LDA $0ADC,y[$7E:0ADC]  ;\
$90:8B37 18          CLC                    ;|
$90:8B38 69 01 00    ADC #$0001             ;} Increment atmospheric graphics X position
$90:8B3B 99 DC 0A    STA $0ADC,y[$7E:0ADC]  ;/
$90:8B3E 80 0A       BRA $0A    [$8B4A]

$90:8B40 B9 DC 0A    LDA $0ADC,y[$7E:0AE2]  ;\ Else ([atmospheric graphic index] >= 4):
$90:8B43 38          SEC                    ;|
$90:8B44 E9 01 00    SBC #$0001             ;} Decrement atmospheric graphics X position
$90:8B47 99 DC 0A    STA $0ADC,y[$7E:0AE2]  ;/

$90:8B4A B9 E4 0A    LDA $0AE4,y[$7E:0AEA]  ;\
$90:8B4D 38          SEC                    ;|
$90:8B4E E9 01 00    SBC #$0001             ;} Decrement atmospheric graphics Y position
$90:8B51 99 E4 0A    STA $0AE4,y[$7E:0AEA]  ;/
$90:8B54 4C C5 8A    JMP $8AC5  [$90:8AC5]  ; Go to handle atmospheric effects - [atmospheric graphic type] = 1/2 (footstep splashes)
}


;;; $8B57: Handle atmospheric effects - [atmospheric graphic type] = 6/7 (dust) ;;;
{
;; Parameters:
;;     X: Atmospheric graphic type
;;     Y: Atmospheric graphic index
$90:8B57 B9 E4 0A    LDA $0AE4,y[$7E:0AEA]  ;\
$90:8B5A 38          SEC                    ;|
$90:8B5B E9 01 00    SBC #$0001             ;} Decrement atmospheric graphics Y position
$90:8B5E 99 E4 0A    STA $0AE4,y[$7E:0AEA]  ;/
$90:8B61 4C C5 8A    JMP $8AC5  [$90:8AC5]  ; Go to handle atmospheric effects - [atmospheric graphic type] = 1/2 (footstep splashes)
}


;;; $8B64: Handle atmospheric effects - [atmospheric graphic type] = 5 (bubbles) ;;;
{
;; Parameters:
;;     Y: Atmospheric graphic index
$90:8B64 5A          PHY
$90:8B65 B9 EC 0A    LDA $0AEC,y[$7E:0AF0]  ;\
$90:8B68 29 FF 00    AND #$00FF             ;} $12 = [atmospheric graphic animation frame]
$90:8B6B 85 12       STA $12    [$7E:0012]  ;/
$90:8B6D A9 86 01    LDA #$0186             ;\
$90:8B70 18          CLC                    ;|
$90:8B71 65 12       ADC $12    [$7E:0012]  ;} Samus spritemap table index = 186h + [atmospheric graphic animation frame]
$90:8B73 48          PHA                    ;/
}


;;; $8B74: Add atmospheric spritemap to OAM ;;;
{
;; Parameters:
;;     Y: Atmospheric graphic index
;;     [[S] + 1] + 1: Samus spritemap table index

; Expects a pushed Y (in addition to the pushed table index)
$90:8B74 B9 DC 0A    LDA $0ADC,y[$7E:0ADC]  ;\
$90:8B77 38          SEC                    ;|
$90:8B78 ED 11 09    SBC $0911  [$7E:0911]  ;} Spritemap X position = [atmospheric graphics X position] - [layer 1 X position]
$90:8B7B AA          TAX                    ;/
$90:8B7C B9 E4 0A    LDA $0AE4,y[$7E:0AE4]  ;\
$90:8B7F 38          SEC                    ;|
$90:8B80 ED 15 09    SBC $0915  [$7E:0915]  ;} If 0 <= [atmospheric graphics Y position] - [layer 1 Y position] < 100h:
$90:8B83 89 00 FF    BIT #$FF00             ;|
$90:8B86 D0 08       BNE $08    [$8B90]     ;/
$90:8B88 A8          TAY                    ; Spritemap Y position = [atmospheric graphics Y position] - [layer 1 Y position]
$90:8B89 68          PLA
$90:8B8A 22 AE 89 81 JSL $8189AE[$81:89AE]  ; Add Samus spritemap to OAM
$90:8B8E 7A          PLY
$90:8B8F 60          RTS                    ; Return

$90:8B90 68          PLA
$90:8B91 7A          PLY
$90:8B92 60          RTS
}


;;; $8B93: Atmospheric graphics animation timers ;;;
{
; Indexed by [atmospheric graphics type] * 2
$90:8B93             dw 0000, 8BA5, 8BAD, 8BB5, 8BC7, 8BCF, 8BDF, 8BE7, 0000

; Indexed by [atmospheric graphics animation frame] * 2

; 1/2 - footstep splashes
$90:8BA5             dw 0003, 0003, 0003, 0003
$90:8BAD             dw 0003, 0003, 0003, 0003

; 3 - diving splash
$90:8BB5             dw 0002, 0002, 0003, 0003, 0003, 0005, 0005, 0006, 0007

; 4 - lava surface damage
$90:8BC7             dw 0002, 0002, 0002, 0002

; 5 - bubbles
$90:8BCF             dw 0005, 0005, 0005, 0005, 0005, 0005, 0005, 0005

; 6/7 - dust
$90:8BDF             dw 0003, 0004, 0005, 0006
$90:8BE7             dw 0003, 0004, 0005, 0006
}


;;; $8BEF: Number of atmospheric graphics animation frames ;;;
{
; Indexed by [atmospheric graphics type] * 2
$90:8BEF             dw 0000, 0004, 0004, 0009, 0004, 0008, 0004, 0004
}


;;; $8BFF: Atmospheric graphics sprite tile number and attributes ;;;
{
; Indexed by [atmospheric graphics type] * 2
$90:8BFF             dw 0000, 8C0F, 0000, 0000, 8C17, 0000, 8C17, 8C17

; Indexed by [atmospheric graphics animation frame] * 2
$90:8C0F             dw 2A2C, 2A2D, 2A2E, 2A2F ; 1 - footstep splashes
$90:8C17             dw 2A48, 2A49, 2A4A, 2A4B ; 4/6/7 - lava surface damage / dust
}
}


;;; $8C1F..8E0E: Calculate Samus spritemap position ;;;
{
;;; $8C1F: Calculate Samus spritemap position ;;;
{
;; Parameters:
;;     X: Samus pose * 2
;; Returns:
;;     X: Samus spritemap X position
;;     Y: Samus spritemap Y position
$90:8C1F AD 3F 09    LDA $093F  [$7E:093F]  ;\
$90:8C22 10 2B       BPL $2B    [$8C4F]     ;} If [Ceres status] = elevator room is rotating:
$90:8C24 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8C27 8D 82 0D    STA $0D82  [$7E:0D82]  ;} $0D82 = [Samus X position]
$90:8C2A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:8C2D 8D 84 0D    STA $0D84  [$7E:0D84]  ;} $0D84 = [Samus Y position]
$90:8C30 DA          PHX                    ;\
$90:8C31 22 52 8A 8B JSL $8B8A52[$8B:8A52]  ;} Calculate position of Samus in rotating elevator room
$90:8C35 FA          PLX                    ;/
$90:8C36 9B          TXY                    ; Y = [X]
$90:8C37 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:8C3A 29 FF 00    AND #$00FF             ;|
$90:8C3D 0A          ASL A                  ;} Execute [$8C5C + [Samus movement type]]
$90:8C3E AA          TAX                    ;|
$90:8C3F FC 5C 8C    JSR ($8C5C,x)[$90:8C94];/
$90:8C42 AD 84 0D    LDA $0D84  [$7E:0D84]  ;\
$90:8C45 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = [$0D84]
$90:8C48 AD 82 0D    LDA $0D82  [$7E:0D82]  ;\
$90:8C4B 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = [$0D82]
$90:8C4E 60          RTS                    ; Return

$90:8C4F 9B          TXY                    ; Y = [X]
$90:8C50 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:8C53 29 FF 00    AND #$00FF             ;|
$90:8C56 0A          ASL A                  ;} Execute [$8C5C + [Samus movement type]]
$90:8C57 AA          TAX                    ;|
$90:8C58 FC 5C 8C    JSR ($8C5C,x)[$90:8CC3];/
$90:8C5B 60          RTS

$90:8C5C             dw 8CC3, ; *0: Standing
                        8C94, ;  1: Running
                        8C94, ;  2: Normal jumping
                        8C94, ;  3: Spin jumping
                        8C94, ;  4: Morph ball - on ground
                        8C94, ;  5: Crouching
                        8C94, ;  6: Falling
                        8C94, ;  7: Unused
                        8C94, ;  8: Morph ball - falling
                        8C94, ;  9: Unused
                        8C94, ;  Ah: Knockback
                        8C94, ;  Bh: Unused
                        8C94, ;  Ch: Unused
                        8C94, ;  Dh: Unused
                        8C94, ;  Eh: Turning around - on ground
                        8D3C, ; *Fh: Crouching/standing/morphing/unmorphing transition
                        8C94, ;  10h: Moonwalking
                        8C94, ;  11h: Spring ball - on ground
                        8C94, ;  12h: Spring ball - in air
                        8C94, ;  13h: Spring ball - falling
                        8C94, ;  14h: Wall jumping
                        8C94, ;  15h: Ran into a wall
                        8C94, ;  16h: Grappling
                        8C94, ;  17h: Turning around - jumping
                        8C94, ;  18h: Turning around - falling
                        8C94, ;  19h: Damage boost
                        8C94, ;  1Ah: Grabbed by Draygon
                        8D98  ; *1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $8C94: Calculate usual Samus spritemap position ;;;
{
;; Parameters:
;;     Y: Samus pose * 2
;; Returns:
;;     X: Samus spritemap X position
;;     Y: Samus spritemap Y position
$90:8C94 98          TYA                    ;\
$90:8C95 0A          ASL A                  ;|
$90:8C96 0A          ASL A                  ;|
$90:8C97 AA          TAX                    ;|
$90:8C98 BF 2D B6 91 LDA $91B62D,x[$91:B63D];|
$90:8C9C 29 FF 00    AND #$00FF             ;} $12 = ±[$91:B62D + [Y] * 4] (Samus GFX Y offset)
$90:8C9F 89 80 00    BIT #$0080             ;|
$90:8CA2 F0 03       BEQ $03    [$8CA7]     ;|
$90:8CA4 09 00 FF    ORA #$FF00             ;|
                                            ;|
$90:8CA7 85 12       STA $12    [$7E:0012]  ;/
$90:8CA9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:8CAC 38          SEC                    ;|
$90:8CAD E5 12       SBC $12    [$7E:0012]  ;|
$90:8CAF 38          SEC                    ;} Y = Samus spritemap Y position = [Samus Y position] - [$12] - [layer 1 Y position]
$90:8CB0 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:8CB3 8D 06 0B    STA $0B06  [$7E:0B06]  ;|
$90:8CB6 A8          TAY                    ;/
$90:8CB7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8CBA 38          SEC                    ;|
$90:8CBB ED 11 09    SBC $0911  [$7E:0911]  ;} X = Samus spritemap X position = [Samus X position] - [layer 1 X position]
$90:8CBE 8D 04 0B    STA $0B04  [$7E:0B04]  ;|
$90:8CC1 AA          TAX                    ;/
$90:8CC2 60          RTS
}


;;; $8CC3: Calculate Samus spritemap position - standing ;;;
{
;; Parameters:
;;     Y: Samus pose * 2
;; Returns:
;;     X: Samus spritemap X position
;;     Y: Samus spritemap Y position
$90:8CC3 8B          PHB
$90:8CC4 4B          PHK                    ;\
$90:8CC5 AB          PLB                    ;} DB = $90
$90:8CC6 98          TYA                    ;\
$90:8CC7 4A          LSR A                  ;|
$90:8CC8 C9 00 00    CMP #$0000             ;|
$90:8CCB F0 3A       BEQ $3A    [$8D07]     ;} If (Samus pose) != facing forward:
$90:8CCD C9 9B 00    CMP #$009B             ;|
$90:8CD0 F0 35       BEQ $35    [$8D07]     ;/
$90:8CD2 C9 A4 00    CMP #$00A4             ;\
$90:8CD5 30 61       BMI $61    [$8D38]     ;|
$90:8CD7 C9 A8 00    CMP #$00A8             ;} If (Samus pose) != landing from a jump: go to calculate usual Samus spritemap position
$90:8CDA 10 5C       BPL $5C    [$8D38]     ;/
$90:8CDC 38          SEC                    ;\
$90:8CDD E9 A4 00    SBC #$00A4             ;|
$90:8CE0 0A          ASL A                  ;|
$90:8CE1 0A          ASL A                  ;|
$90:8CE2 18          CLC                    ;} $12 = [$8D28 + ((Samus pose) - A4h) * 4 + [Samus animation frame]]
$90:8CE3 6D 96 0A    ADC $0A96  [$7E:0A96]  ;|
$90:8CE6 AA          TAX                    ;|
$90:8CE7 BD 28 8D    LDA $8D28,x[$90:8D2C]  ;|
$90:8CEA 85 12       STA $12    [$7E:0012]  ;/
$90:8CEC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:8CEF 38          SEC                    ;|
$90:8CF0 E5 12       SBC $12    [$7E:0012]  ;|
$90:8CF2 38          SEC                    ;} Y = Samus spritemap Y position = [Samus Y position] - [$12] - [layer 1 Y position]
$90:8CF3 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:8CF6 8D 06 0B    STA $0B06  [$7E:0B06]  ;|
$90:8CF9 A8          TAY                    ;/
$90:8CFA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8CFD 38          SEC                    ;|
$90:8CFE ED 11 09    SBC $0911  [$7E:0911]  ;} X = Samus spritemap X position = [Samus X position] - [layer 1 X position]
$90:8D01 8D 04 0B    STA $0B04  [$7E:0B04]  ;|
$90:8D04 AA          TAX                    ;/
$90:8D05 AB          PLB
$90:8D06 60          RTS                    ; Return

$90:8D07 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:8D0A C9 02 00    CMP #$0002             ;} If [Samus animation frame] < 2: go to calculate usual Samus spritemap position
$90:8D0D 30 29       BMI $29    [$8D38]     ;/
$90:8D0F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:8D12 3A          DEC A                  ;|
$90:8D13 38          SEC                    ;|
$90:8D14 ED 15 09    SBC $0915  [$7E:0915]  ;} Y = Samus spritemap Y position = [Samus Y position] - 1 - [layer 1 Y position]
$90:8D17 8D 06 0B    STA $0B06  [$7E:0B06]  ;|
$90:8D1A A8          TAY                    ;/
$90:8D1B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8D1E 38          SEC                    ;|
$90:8D1F ED 11 09    SBC $0911  [$7E:0911]  ;} X = Samus spritemap X position = [Samus X position] - [layer 1 X position]
$90:8D22 8D 04 0B    STA $0B04  [$7E:0B04]  ;|
$90:8D25 AA          TAX                    ;/
$90:8D26 AB          PLB
$90:8D27 60          RTS

$90:8D28             db 03,06,00,00, ; Facing right - landing from normal jump
                        03,06,00,00, ; Facing left  - landing from normal jump
                        03,03,06,00, ; Facing right - landing from spin jump
                        03,03,06,00  ; Facing left  - landing from spin jump
}


;;; $8D38: Go to calculate usual Samus spritemap position ;;;
{
;; Parameters:
;;     Y: Samus pose * 2
;; Returns:
;;     X: Samus spritemap X position
;;     Y: Samus spritemap Y position

; Expects pushed DB
$90:8D38 AB          PLB
$90:8D39 4C 94 8C    JMP $8C94  [$90:8C94]
}


;;; $8D3C: Calculate Samus spritemap position - crouching/standing/morphing/unmorphing transition ;;;
{
;; Parameters:
;;     Y: Samus pose * 2
;; Returns:
;;     X: Samus spritemap X position
;;     Y: Samus spritemap Y position
$90:8D3C 8B          PHB
$90:8D3D 4B          PHK                    ;\
$90:8D3E AB          PLB                    ;} DB = $90
$90:8D3F 98          TYA                    ;\
$90:8D40 4A          LSR A                  ;|
$90:8D41 C9 35 00    CMP #$0035             ;|
$90:8D44 30 F2       BMI $F2    [$8D38]     ;} If (Samus pose) != crouching/standing/morphing/unmorphing transition: go to calculate usual Samus spritemap position
$90:8D46 C9 41 00    CMP #$0041             ;|
$90:8D49 10 ED       BPL $ED    [$8D38]     ;/
$90:8D4B 38          SEC                    ;\
$90:8D4C E9 35 00    SBC #$0035             ;|
$90:8D4F 0A          ASL A                  ;|
$90:8D50 18          CLC                    ;|
$90:8D51 6D 96 0A    ADC $0A96  [$7E:0A96]  ;|
$90:8D54 AA          TAX                    ;|
$90:8D55 BD 80 8D    LDA $8D80,x[$90:8D80]  ;} $12 = ±[$8D80 + ((Samus pose) - 35h) * 2 + [Samus animation frame]]
$90:8D58 29 FF 00    AND #$00FF             ;|
$90:8D5B 89 80 00    BIT #$0080             ;|
$90:8D5E F0 03       BEQ $03    [$8D63]     ;|
$90:8D60 09 00 FF    ORA #$FF00             ;|
                                            ;|
$90:8D63 85 12       STA $12    [$7E:0012]  ;/
$90:8D65 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:8D68 18          CLC                    ;|
$90:8D69 65 12       ADC $12    [$7E:0012]  ;|
$90:8D6B 38          SEC                    ;} Y = Samus spritemap Y position = [Samus Y position] + [$12] - [layer 1 Y position]
$90:8D6C ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:8D6F 8D 06 0B    STA $0B06  [$7E:0B06]  ;|
$90:8D72 A8          TAY                    ;/
$90:8D73 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8D76 38          SEC                    ;|
$90:8D77 ED 11 09    SBC $0911  [$7E:0911]  ;} X = Samus spritemap X position = [Samus X position] - [layer 1 X position]
$90:8D7A 8D 04 0B    STA $0B04  [$7E:0B04]  ;|
$90:8D7D AA          TAX                    ;/
$90:8D7E AB          PLB
$90:8D7F 60          RTS

$90:8D80             db F8,00, ; Facing right - crouching transition
                        F8,00, ; Facing left  - crouching transition
                        FC,FE, ; Facing right - morphing transition
                        FC,FE, ; Facing left  - morphing transition
                        00,00, ; Unused
                        00,00, ; Unused
                        FC,00, ; Facing right - standing transition
                        FC,00, ; Facing left  - standing transition
                        05,04, ; Facing right - unmorphing transition
                        05,04, ; Facing left  - unmorphing transition
                        00,00, ; Unused
                        00,00  ; Unused
}


;;; $8D98: Calculate Samus spritemap position - shinespark / crystal flash / drained by metroid / damaged by MB's attacks ;;;
{
;; Parameters:
;;     Y: Samus pose * 2
;; Returns:
;;     X: Samus spritemap X position
;;     Y: Samus spritemap Y position
$90:8D98 8B          PHB
$90:8D99 4B          PHK                    ;\
$90:8D9A AB          PLB                    ;} DB = $90
$90:8D9B 98          TYA                    ;\
$90:8D9C 4A          LSR A                  ;|
$90:8D9D C9 E8 00    CMP #$00E8             ;|
$90:8DA0 F0 1F       BEQ $1F    [$8DC1]     ;} If (Samus pose) = Samus drained - crouching/falling: go to BRANCH_DRAINED_NON_STANDING
$90:8DA2 C9 E9 00    CMP #$00E9             ;|
$90:8DA5 F0 1A       BEQ $1A    [$8DC1]     ;/
$90:8DA7 C9 EA 00    CMP #$00EA             ;\
$90:8DAA F0 05       BEQ $05    [$8DB1]     ;|
$90:8DAC C9 EB 00    CMP #$00EB             ;} If (Samus pose) != Samus drained - standing: go to calculate usual Samus spritemap position
$90:8DAF D0 0D       BNE $0D    [$8DBE]     ;/

$90:8DB1 AE 96 0A    LDX $0A96  [$7E:0A96]  ;\
$90:8DB4 E0 05 00    CPX #$0005             ;} If [Samus animation frame] >= 5:
$90:8DB7 30 05       BMI $05    [$8DBE]     ;/
$90:8DB9 A9 FD FF    LDA #$FFFD             ; $12 = -3
$90:8DBC 80 14       BRA $14    [$8DD2]     ; Go to BRANCH_MERGE

$90:8DBE 4C 38 8D    JMP $8D38  [$90:8D38]  ; Go to calculate usual Samus spritemap position

; BRANCH_DRAINED_NON_STANDING
$90:8DC1 AE 96 0A    LDX $0A96  [$7E:0A96]  ;\
$90:8DC4 BD EF 8D    LDA $8DEF,x[$90:8DF1]  ;|
$90:8DC7 29 FF 00    AND #$00FF             ;|
$90:8DCA 89 80 00    BIT #$0080             ;} $12 = ±[$8DEF + [Samus animation frame]]
$90:8DCD F0 03       BEQ $03    [$8DD2]     ;|
$90:8DCF 09 00 FF    ORA #$FF00             ;/

; BRANCH_MERGE
$90:8DD2 85 12       STA $12    [$7E:0012]
$90:8DD4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:8DD7 18          CLC                    ;|
$90:8DD8 65 12       ADC $12    [$7E:0012]  ;|
$90:8DDA 38          SEC                    ;} Y = Samus spritemap Y position = [Samus Y position] + [$12] - [layer 1 Y position]
$90:8DDB ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:8DDE 8D 06 0B    STA $0B06  [$7E:0B06]  ;|
$90:8DE1 A8          TAY                    ;/
$90:8DE2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:8DE5 38          SEC                    ;|
$90:8DE6 ED 11 09    SBC $0911  [$7E:0911]  ;} X = Samus spritemap X position = [Samus X position] - [layer 1 X position]
$90:8DE9 8D 04 0B    STA $0B04  [$7E:0B04]  ;|
$90:8DEC AA          TAX                    ;/
$90:8DED AB          PLB
$90:8DEE 60          RTS

; Samus drained - crouching
$90:8DEF             db 07, 05, F8, F8, F8, F8, F8, FB, 04, 04, 04, 04, 00, 00, 04, FD,
                        FB, 00, 00, 04, FD, FB, FD, 04, 00, 00, 04, 00, 00, 04, 00, 00
}
}


;;; $8E0F..63: Set liquid physics type ;;;
{
;;; $8E0F: Set liquid physics type ;;;
{
$90:8E0F 08          PHP
$90:8E10 8B          PHB
$90:8E11 4B          PHK                    ;\
$90:8E12 AB          PLB                    ;} DB = $90
$90:8E13 C2 30       REP #$30
$90:8E15 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $12 / $14 = Samus bottom / top boundary
$90:8E19 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$90:8E1C 29 0F 00    AND #$000F             ;|
$90:8E1F AA          TAX                    ;} Execute [$8E26 + ([FX type] & Fh)]
$90:8E20 FC 26 8E    JSR ($8E26,x)[$90:8E36];/
$90:8E23 AB          PLB
$90:8E24 28          PLP
$90:8E25 6B          RTL

$90:8E26             dw 8E36, ; 0: None / 20h: Unused scrolling sky
                        8E3A, ; 2: Lava / 22h: Unused
                        8E3A, ; 4: Acid / 24h: Fireflea
                        8E4A, ; 6: Water / 26h: Tourian entrance statue
                        8E36, ; 8: Spores / 28h: Ceres Ridley
                        8E36, ; Ah: Rain / 2Ah: Ceres elevator
                        8E36, ; Ch: Fog / 2Ch: Ceres haze
                        8E36
}


;;; $8E36: Set liquid physics type - air ;;;
{
$90:8E36 9C D2 0A    STZ $0AD2  [$7E:0AD2]  ; Liquid physics type = air
$90:8E39 60          RTS
}


;;; $8E3A: Set liquid physics type - lava/acid ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
$90:8E3A AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:8E3D 30 F7       BMI $F7    [$8E36]     ;} If [lava/acid Y position] < 0: go to set liquid physics type - air
$90:8E3F C5 12       CMP $12    [$7E:0012]  ;\
$90:8E41 10 F3       BPL $F3    [$8E36]     ;} If [lava/acid Y position] >= [$12]: go to set liquid physics type - air
$90:8E43 A9 02 00    LDA #$0002             ;\
$90:8E46 8D D2 0A    STA $0AD2  [$7E:0AD2]  ;} Liquid physics type = lava/acid
$90:8E49 60          RTS
}


;;; $8E4A: Set liquid physics type - water ;;;
{
;; Parameters:
;;     $12: Samus bottom boundary
$90:8E4A AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:8E4D 30 E7       BMI $E7    [$8E36]     ;} If [FX Y position] < 0: go to set liquid physics type - air
$90:8E4F C5 12       CMP $12    [$7E:0012]  ;\
$90:8E51 30 02       BMI $02    [$8E55]     ;} If [FX Y position] >= [$12]: go to set liquid physics type - air
$90:8E53 80 E1       BRA $E1    [$8E36]     ;/

$90:8E55 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:8E58 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to set liquid physics type - air
$90:8E5B D0 D9       BNE $D9    [$8E36]     ;/
$90:8E5D A9 01 00    LDA #$0001             ;\
$90:8E60 8D D2 0A    STA $0AD2  [$7E:0AD2]  ;} Liquid physics type = water
$90:8E63 60          RTS
}
}


;;; $8E64..94EB: Samus movement ;;;
{
;;; $8E64: Samus X movement ;;;
{
; Called by:
;     $A3E5: Samus movement - running
;     $A521: Samus movement - morph ball - on ground
;     $A67C: Samus movement - turning around - on ground
;     $A694: Samus movement - moonwalking
;     $A69F: Samus movement - spring ball - on ground
;     $A790: Samus movement - turning around - jumping
;     $A7AD: Samus movement - turning around - falling

$90:8E64 08          PHP
$90:8E65 C2 30       REP #$30
$90:8E67 20 3E 97    JSR $973E  [$90:973E]  ; Handle Samus X extra run speed
$90:8E6A 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:8E6D 20 7E 9A    JSR $9A7E  [$90:9A7E]  ; Calculate Samus X base speed - deceleration allowed
$90:8E70 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally
$90:8E73 28          PLP
$90:8E74 60          RTS
}


;;; $8E75: Unused ;;;
{
; Seems vaguely close to falling X movement, $919F in particular
$90:8E75 08          PHP
$90:8E76 C2 30       REP #$30
$90:8E78 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:8E7B 20 1F 9B    JSR $9B1F  [$90:9B1F]  ; Calculate Samus X base speed - deceleration disallowed
$90:8E7E AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:8E81 D0 21       BNE $21    [$8EA4]     ;} If [Samus X acceleration mode] != accelerating: go to BRANCH_DECELERATING
$90:8E83 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:8E85 89 00 01    BIT #$0100             ;} If not pressing right:
$90:8E88 D0 14       BNE $14    [$8E9E]     ;/
$90:8E8A 89 00 02    BIT #$0200             ;\
$90:8E8D D0 0F       BNE $0F    [$8E9E]     ;} If not pressing left:
$90:8E8F 64 12       STZ $12    [$7E:0012]  ;\
$90:8E91 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:8E93 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:8E96 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:8E99 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:8E9C 80 09       BRA $09    [$8EA7]     ; Return

$90:8E9E A9 02 00    LDA #$0002             ;\
$90:8EA1 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

; BRANCH_DECELERATING
$90:8EA4 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally

$90:8EA7 28          PLP
$90:8EA8 60          RTS
}


;;; $8EA9: Move Samus horizontally ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed

; Called by:
;     $8E64: Samus X movement
;     $8E75: Unused
;     $8FB3: Samus jumping movement
;     $9040: Samus spin jumping movement
;     $9168: Samus falling movement
;     $919F: Samus morphed falling movement
;     $91D1: Samus morphed bouncing movement
;     $9348: Move Samus horizontally with zero base X speed
;     $946E: Samus movement handler - released from grapple swing

$90:8EA9 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:8EAC F0 12       BEQ $12    [$8EC0]     ;|
$90:8EAE C9 02 00    CMP #$0002             ;} If [Samus X acceleration mode] = turning around:
$90:8EB1 F0 0D       BEQ $0D    [$8EC0]     ;/
$90:8EB3 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:8EB6 29 FF 00    AND #$00FF             ;|
$90:8EB9 C9 08 00    CMP #$0008             ;} If facing right: go to BRANCH_LEFTWARDS
$90:8EBC F0 12       BEQ $12    [$8ED0]     ;/
$90:8EBE 80 0B       BRA $0B    [$8ECB]     ; Go to BRANCH_RIGHTWARDS

$90:8EC0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\ Else ([Samus X acceleration mode] != turning around):
$90:8EC3 29 FF 00    AND #$00FF             ;|
$90:8EC6 C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_LEFTWARDS
$90:8EC9 F0 05       BEQ $05    [$8ED0]     ;/

; BRANCH_RIGHTWARDS
$90:8ECB 20 AD E4    JSR $E4AD  [$90:E4AD]  ; Calculate Samus X displacement for moving right
$90:8ECE 80 03       BRA $03    [$8ED3]     ; Go to BRANCH_MERGE

; BRANCH_LEFTWARDS
$90:8ED0 20 64 E4    JSR $E464  [$90:E464]  ; Calculate Samus X displacement for moving left

; BRANCH_MERGE
$90:8ED3 A5 12       LDA $12    [$7E:0012]  ;\
$90:8ED5 30 04       BMI $04    [$8EDB]     ;} If [$12] >= 0:
$90:8ED7 20 B1 93    JSR $93B1  [$90:93B1]  ; Move Samus right by [$12].[$14]
$90:8EDA 60          RTS                    ; Return

$90:8EDB 20 50 93    JSR $9350  [$90:9350]  ; Move Samus left by -[$12].[$14]
$90:8EDE 60          RTS
}


;;; $8EDF: Move Samus horizontally - knockback or bomb jump ;;;
{
; Called by:
;     $DF53: Knockback movement - up
;     $DF64: Knockback movement - down
;     $E04C: Samus movement handler - bomb jump - main - horizontal

$90:8EDF 08          PHP
$90:8EE0 C2 30       REP #$30
$90:8EE2 AD 52 0A    LDA $0A52  [$7E:0A52]  ;\
$90:8EE5 F0 0D       BEQ $0D    [$8EF4]     ;} If [knockback direction] != none:
$90:8EE7 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:8EEA 20 7E 9A    JSR $9A7E  [$90:9A7E]  ; Calculate Samus X base speed - deceleration allowed
$90:8EED AD 54 0A    LDA $0A54  [$7E:0A54]  ;\
$90:8EF0 D0 13       BNE $13    [$8F05]     ;} If [knockback X direction] = right: go to BRANCH_RIGHTWARDS
$90:8EF2 80 16       BRA $16    [$8F0A]     ; Go to BRANCH_LEFTWARDS

$90:8EF4 A2 25 9F    LDX #$9F25             ; X = $9F25
$90:8EF7 20 7E 9A    JSR $9A7E  [$90:9A7E]  ; Calculate Samus X base speed - deceleration allowed
$90:8EFA AD 56 0A    LDA $0A56  [$7E:0A56]  ;\
$90:8EFD 29 FF 00    AND #$00FF             ;|
$90:8F00 C9 01 00    CMP #$0001             ;} If [bomb jump direction] = left: go to BRANCH_LEFTWARDS
$90:8F03 F0 05       BEQ $05    [$8F0A]     ;/

; BRANCH_RIGHTWARDS
$90:8F05 20 AD E4    JSR $E4AD  [$90:E4AD]  ; Calculate Samus X displacement for moving right
$90:8F08 80 03       BRA $03    [$8F0D]     ; Go to BRANCH_MERGE

; BRANCH_LEFTWARDS
$90:8F0A 20 64 E4    JSR $E464  [$90:E464]  ; Calculate Samus X displacement for moving left

; BRANCH_MERGE
$90:8F0D A5 12       LDA $12    [$7E:0012]  ;\
$90:8F0F 30 05       BMI $05    [$8F16]     ;} If [$12] >= 0:
$90:8F11 20 B1 93    JSR $93B1  [$90:93B1]  ; Move Samus right by [$12].[$14]
$90:8F14 80 03       BRA $03    [$8F19]     ; Return

$90:8F16 20 50 93    JSR $9350  [$90:9350]  ; Move Samus left by -[$12].[$14]

$90:8F19 28          PLP
$90:8F1A 60          RTS
}


;;; $8F1B: Handle end of bomb jump ;;;
{
$90:8F1B 08          PHP
$90:8F1C C2 30       REP #$30
$90:8F1E AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:8F21 C9 01 00    CMP #$0001             ;} If [Samus Y direction] != up: return
$90:8F24 D0 37       BNE $37    [$8F5D]     ;/
$90:8F26 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:8F29 30 15       BMI $15    [$8F40]     ;} If [Samus Y speed] >= 0:
$90:8F2B C9 01 00    CMP #$0001             ;\
$90:8F2E 10 2D       BPL $2D    [$8F5D]     ;} If [Samus Y speed] >= 1: return
$90:8F30 AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$90:8F33 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] = $E91D (demo): return
$90:8F36 F0 25       BEQ $25    [$8F5D]     ;/
$90:8F38 A9 13 E9    LDA #$E913             ;\
$90:8F3B 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$90:8F3E 80 1D       BRA $1D    [$8F5D]     ; Return

$90:8F40 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:8F43 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:8F46 A9 02 00    LDA #$0002             ;\
$90:8F49 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$90:8F4C AD 56 0A    LDA $0A56  [$7E:0A56]  ;\
$90:8F4F 29 FF 00    AND #$00FF             ;|
$90:8F52 C9 02 00    CMP #$0002             ;} If [bomb jump direction] = straight: return
$90:8F55 F0 06       BEQ $06    [$8F5D]     ;/
$90:8F57 A9 02 00    LDA #$0002             ;\
$90:8F5A 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

$90:8F5D 28          PLP
$90:8F5E 60          RTS
}


;;; $8F5F: Move Samus horizontally - pushed by Ceres Ridley ;;;
{
$90:8F5F 08          PHP
$90:8F60 C2 30       REP #$30
$90:8F62 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:8F65 20 7E 9A    JSR $9A7E  [$90:9A7E]  ; Calculate Samus X base speed - deceleration allowed
$90:8F68 AD 62 0A    LDA $0A62  [$7E:0A62]  ;\
$90:8F6B C9 01 00    CMP #$0001             ;} If [Samus push direction] != left:
$90:8F6E F0 05       BEQ $05    [$8F75]     ;/
$90:8F70 20 AD E4    JSR $E4AD  [$90:E4AD]  ; Calculate Samus X displacement for moving right
$90:8F73 80 03       BRA $03    [$8F78]
                                            ; Else ([Samus push direction] = left):
$90:8F75 20 64 E4    JSR $E464  [$90:E464]  ; Calculate Samus X displacement for moving left

$90:8F78 A5 12       LDA $12    [$7E:0012]  ;\
$90:8F7A 30 05       BMI $05    [$8F81]     ;} If [$12] >= 0:
$90:8F7C 20 B1 93    JSR $93B1  [$90:93B1]  ; Move Samus right by [$12].[$14]
$90:8F7F 80 03       BRA $03    [$8F84]     ; Return

$90:8F81 20 50 93    JSR $9350  [$90:9350]  ; Move Samus left by -[$12].[$14]

$90:8F84 28          PLP
$90:8F85 60          RTS
}


;;; $8F86: Move Samus vertically - pushed by Ceres Ridley ;;;
{
$90:8F86 08          PHP
$90:8F87 C2 30       REP #$30
$90:8F89 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:8F8C C9 05 00    CMP #$0005             ;} If [Samus Y speed] < 5:
$90:8F8F 10 13       BPL $13    [$8FA4]     ;/
$90:8F91 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:8F94 18          CLC                    ;|
$90:8F95 6D 32 0B    ADC $0B32  [$7E:0B32]  ;|
$90:8F98 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;} Samus Y speed += [Samus Y acceleration]
$90:8F9B AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;|
$90:8F9E 6D 34 0B    ADC $0B34  [$7E:0B34]  ;|
$90:8FA1 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:8FA4 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:8FA7 85 14       STA $14    [$7E:0014]  ;|
$90:8FA9 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;} $12.$14 = [Samus Y speed]
$90:8FAC 85 12       STA $12    [$7E:0012]  ;/
$90:8FAE 20 40 94    JSR $9440  [$90:9440]  ; Move Samus down by [$12].[$14]
$90:8FB1 28          PLP
$90:8FB2 60          RTS
}


;;; $8FB3: Samus jumping movement ;;;
{
; Called by:
;     $A42E: Samus movement - normal jumping
;     $A6F1: Samus movement - spring ball - in air
;     $A734: Samus movement - wall jumping
;     $A7CA: Samus movement - damage boost

$90:8FB3 08          PHP
$90:8FB4 C2 30       REP #$30
$90:8FB6 20 3E 97    JSR $973E  [$90:973E]  ; Handle Samus X extra run speed
$90:8FB9 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:8FBC C9 4B 00    CMP #$004B             ;|
$90:8FBF F0 0F       BEQ $0F    [$8FD0]     ;|
$90:8FC1 C9 4C 00    CMP #$004C             ;|
$90:8FC4 F0 0A       BEQ $0A    [$8FD0]     ;} If [Samus pose] = normal jump transition:
$90:8FC6 C9 55 00    CMP #$0055             ;|
$90:8FC9 30 11       BMI $11    [$8FDC]     ;|
$90:8FCB C9 5B 00    CMP #$005B             ;|
$90:8FCE 10 0C       BPL $0C    [$8FDC]     ;/
$90:8FD0 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:8FD3 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:8FD6 20 88 92    JSR $9288  [$90:9288]  ; Move Samus by extra Samus Y displacement
$90:8FD9 4C 3E 90    JMP $903E  [$90:903E]  ; Return

$90:8FDC AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:8FDF C9 01 00    CMP #$0001             ;} If [Samus Y direction] != up: go to BRANCH_SET_FALLING_END
$90:8FE2 D0 18       BNE $18    [$8FFC]     ;/
$90:8FE4 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:8FE6 2D B4 09    AND $09B4  [$7E:09B4]  ;} If pressing jump:
$90:8FE9 F0 05       BEQ $05    [$8FF0]     ;/
$90:8FEB AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:8FEE 10 0C       BPL $0C    [$8FFC]     ;} If [Samus Y speed] >= 0: go to BRANCH_SET_FALLING_END

$90:8FF0 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:8FF3 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:8FF6 A9 02 00    LDA #$0002             ;\
$90:8FF9 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down

; BRANCH_SET_FALLING_END
$90:8FFC 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:8FFF 20 1F 9B    JSR $9B1F  [$90:9B1F]  ; Calculate Samus X base speed - deceleration disallowed
$90:9002 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:9005 29 FF 00    AND #$00FF             ;|
$90:9008 C9 14 00    CMP #$0014             ;} If [Samus movement type] = wall jumping: go to BRANCH_WALL_JUMPING
$90:900B F0 20       BEQ $20    [$902D]     ;/
$90:900D AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:9010 D0 26       BNE $26    [$9038]     ;} If [Samus X acceleration mode] != accelerating: go to BRANCH_X_MOVEMENT
$90:9012 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9014 89 00 01    BIT #$0100             ;} If pressing right: go to BRANCH_X_MOVEMENT
$90:9017 D0 1F       BNE $1F    [$9038]     ;/
$90:9019 89 00 02    BIT #$0200             ;\
$90:901C D0 1A       BNE $1A    [$9038]     ;} If pressing left: go to BRANCH_X_MOVEMENT
$90:901E 64 12       STZ $12    [$7E:0012]
$90:9020 64 14       STZ $14    [$7E:0014]
$90:9022 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:9025 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:9028 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:902B 80 0E       BRA $0E    [$903B]     ; Go to BRANCH_NO_X_MOVEMENT

; BRANCH_WALL_JUMPING
$90:902D AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:9030 D0 06       BNE $06    [$9038]     ;} If [Samus X acceleration mode] = accelerating:
$90:9032 A9 02 00    LDA #$0002             ;\
$90:9035 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

; BRANCH_X_MOVEMENT
$90:9038 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally

; BRANCH_NO_X_MOVEMENT
$90:903B 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations

$90:903E 28          PLP
$90:903F 60          RTS
}


;;; $9040: Samus spin jumping movement ;;;
{
; Called by:
;     $A436: Samus movement - spin jumping

$90:9040 08          PHP
$90:9041 C2 30       REP #$30
$90:9043 20 3E 97    JSR $973E  [$90:973E]  ; Handle Samus X extra run speed
$90:9046 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:9049 C9 01 00    CMP #$0001             ;} If [Samus Y direction] != up: go to BRANCH_SET_FALLING_END
$90:904C D0 18       BNE $18    [$9066]     ;/
$90:904E A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9050 2D B4 09    AND $09B4  [$7E:09B4]  ;} If pressing jump:
$90:9053 F0 05       BEQ $05    [$905A]     ;/
$90:9055 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:9058 10 0C       BPL $0C    [$9066]     ;} If [Samus Y speed] >= 0: go to BRANCH_SET_FALLING_END

$90:905A 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:905D 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:9060 A9 02 00    LDA #$0002             ;\
$90:9063 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down

; BRANCH_SET_FALLING_END
$90:9066 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:9069 20 1F 9B    JSR $9B1F  [$90:9B1F]  ; Calculate Samus X base speed - deceleration disallowed
$90:906C B0 37       BCS $37    [$90A5]     ; If reached max X speed: go to BRANCH_ALLOW_X_MOVEMENT
$90:906E AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:9071 C9 01 00    CMP #$0001             ;} If [Samus X acceleration mode] = turning around: go to BRANCH_ALLOW_X_MOVEMENT
$90:9074 F0 2F       BEQ $2F    [$90A5]     ;/
$90:9076 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:9079 29 FF 00    AND #$00FF             ;|
$90:907C C9 04 00    CMP #$0004             ;} If facing right:
$90:907F F0 09       BEQ $09    [$908A]     ;/
$90:9081 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9083 89 00 01    BIT #$0100             ;} If pressing right:
$90:9086 F0 0B       BEQ $0B    [$9093]     ;/
$90:9088 80 1B       BRA $1B    [$90A5]     ; Go to BRANCH_ALLOW_X_MOVEMENT

; BRANCH_LEFTWARDS
$90:908A A5 8B       LDA $8B    [$7E:008B]  ;\ Else (facing left):
$90:908C 89 00 02    BIT #$0200             ;} If pressing left:
$90:908F F0 02       BEQ $02    [$9093]     ;/
$90:9091 80 12       BRA $12    [$90A5]     ; Go to BRANCH_ALLOW_X_MOVEMENT

$90:9093 64 12       STZ $12    [$7E:0012]  ;\
$90:9095 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:9097 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:909A 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:909D 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:90A0 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:90A3 80 0B       BRA $0B    [$90B0]     ; Go to BRANCH_MERGE

; BRANCH_ALLOW_X_MOVEMENT
$90:90A5 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:90A8 D0 06       BNE $06    [$90B0]     ;} If [Samus X acceleration mode] = accelerating
$90:90AA A9 02 00    LDA #$0002             ;\
$90:90AD 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

; BRANCH_MERGE
$90:90B0 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally
$90:90B3 AD 9F 9E    LDA $9E9F  [$90:9E9F]  ;\
$90:90B6 85 12       STA $12    [$7E:0012]  ;} $12 = 8 (maximum distance from wall for wall-jump)
$90:90B8 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$90:90BA 20 35 9D    JSR $9D35  [$90:9D35]  ; Wall jump check
$90:90BD B0 03       BCS $03    [$90C2]     ; If wall jump not triggered:
$90:90BF 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations

$90:90C2 28          PLP
$90:90C3 60          RTS
}


;;; $90C4: Check if Samus has started falling ;;;
{
$90:90C4 08          PHP
$90:90C5 C2 30       REP #$30
$90:90C7 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:90CA C9 01 00    CMP #$0001             ;} If [Samus Y direction] = up:
$90:90CD D0 11       BNE $11    [$90E0]     ;/
$90:90CF AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:90D2 10 0C       BPL $0C    [$90E0]     ;} If [Samus Y speed] < 0:
$90:90D4 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:90D7 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:90DA A9 02 00    LDA #$0002             ;\
$90:90DD 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down

$90:90E0 28          PLP
$90:90E1 60          RTS
}


;;; $90E2: Samus Y movement - with speed calculations ;;;
{
; Called by:
;     $8FB3: Samus jumping movement
;     $9040: Samus spin jumping movement
;     $9168: Samus falling movement
;     $919F: Samus morphed falling movement
;     $91D1: Samus morphed bouncing movement
;     $92B8: Simple Samus Y movement
;     $92C7: Simple Samus Y movement
;     $946E: Samus movement handler - released from grapple swing
;     $94CB: Samus movement handler - Samus drained - falling
;     $DF53: Knockback movement - up
;     $DF5D: Knockback movement - straight up (unused)
;     $E04C: Samus movement handler - bomb jump - main - horizontal
;     $E066: Samus movement handler - bomb jump - main - straight

$90:90E2 08          PHP
$90:90E3 C2 30       REP #$30
$90:90E5 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:90E8 85 14       STA $14    [$7E:0014]  ;|
$90:90EA AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;} $12.$14 = [Samus Y speed]
$90:90ED 85 12       STA $12    [$7E:0012]  ;/
$90:90EF AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:90F2 C9 02 00    CMP #$0002             ;} If [Samus Y direction] != down:
$90:90F5 F0 15       BEQ $15    [$910C]     ;/
$90:90F7 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:90FA 38          SEC                    ;|
$90:90FB ED 32 0B    SBC $0B32  [$7E:0B32]  ;|
$90:90FE 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;} Samus Y speed -= [Samus Y acceleration]
$90:9101 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;|
$90:9104 ED 34 0B    SBC $0B34  [$7E:0B34]  ;|
$90:9107 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$90:910A 80 1B       BRA $1B    [$9127]

$90:910C AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\ Else ([Samus Y direction] = down):
$90:910F C9 05 00    CMP #$0005             ;} If [Samus Y speed] != 5:
$90:9112 F0 13       BEQ $13    [$9127]     ;/
$90:9114 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:9117 18          CLC                    ;|
$90:9118 6D 32 0B    ADC $0B32  [$7E:0B32]  ;|
$90:911B 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;} Samus Y speed += [Samus Y acceleration]
$90:911E AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;|
$90:9121 6D 34 0B    ADC $0B34  [$7E:0B34]  ;|
$90:9124 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:9127 AD 5C 0B    LDA $0B5C  [$7E:0B5C]
$90:912A F0 06       BEQ $06    [$9132]
$90:912C AD 5A 0B    LDA $0B5A  [$7E:0B5A]
$90:912F F0 01       BEQ $01    [$9132]
$90:9131 EA          NOP

$90:9132 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:9135 C9 02 00    CMP #$0002             ;} If [Samus Y direction] != down:
$90:9138 F0 13       BEQ $13    [$914D]     ;/
$90:913A A5 12       LDA $12    [$7E:0012]  ;\
$90:913C 49 FF FF    EOR #$FFFF             ;|
$90:913F 85 12       STA $12    [$7E:0012]  ;|
$90:9141 A5 14       LDA $14    [$7E:0014]  ;|
$90:9143 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9146 1A          INC A                  ;|
$90:9147 85 14       STA $14    [$7E:0014]  ;|
$90:9149 D0 02       BNE $02    [$914D]     ;|
$90:914B E6 12       INC $12    [$7E:0012]  ;/

$90:914D AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;\
$90:9150 18          CLC                    ;|
$90:9151 65 14       ADC $14    [$7E:0014]  ;|
$90:9153 85 14       STA $14    [$7E:0014]  ;} $12.$14 += [extra Samus Y displacement]
$90:9155 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;|
$90:9158 65 12       ADC $12    [$7E:0012]  ;|
$90:915A 85 12       STA $12    [$7E:0012]  ;/
$90:915C 30 05       BMI $05    [$9163]     ; If [$12] >= 0:
$90:915E 20 40 94    JSR $9440  [$90:9440]  ; Move Samus down by [$12].[$14]
$90:9161 80 03       BRA $03    [$9166]     ; Return

$90:9163 20 EC 93    JSR $93EC  [$90:93EC]  ; Move Samus up by -[$12].[$14]

$90:9166 28          PLP
$90:9167 60          RTS
}


;;; $9168: Samus falling movement ;;;
{
; Called by:
;     $A58D: Samus movement - falling

$90:9168 08          PHP
$90:9169 C2 30       REP #$30
$90:916B 20 3E 97    JSR $973E  [$90:973E]  ; Handle Samus X extra run speed
$90:916E 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:9171 20 1F 9B    JSR $9B1F  [$90:9B1F]  ; Calculate Samus X base speed - deceleration disallowed
$90:9174 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:9177 D0 1B       BNE $1B    [$9194]     ;} If [Samus X acceleration mode] = accelerating:
$90:9179 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:917B 89 00 01    BIT #$0100             ;} If not pressing right:
$90:917E D0 14       BNE $14    [$9194]     ;/
$90:9180 89 00 02    BIT #$0200             ;\
$90:9183 D0 0F       BNE $0F    [$9194]     ;} If not pressing left:
$90:9185 64 12       STZ $12    [$7E:0012]  ;\
$90:9187 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:9189 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:918C 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:918F 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:9192 80 03       BRA $03    [$9197]
                                            ; Else ([Samus X acceleration mode] != accelerating or pressing right/left):
$90:9194 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally

$90:9197 20 C4 90    JSR $90C4  [$90:90C4]  ; Check if Samus has started falling
$90:919A 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:919D 28          PLP
$90:919E 60          RTS
}


;;; $919F: Samus morphed falling movement ;;;
{
; Called by:
;     $A5CA: Samus movement - morph ball - falling
;     $A703: Samus movement - spring ball - falling

$90:919F 08          PHP
$90:91A0 C2 30       REP #$30
$90:91A2 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:91A5 20 1F 9B    JSR $9B1F  [$90:9B1F]  ; Calculate Samus X base speed - deceleration disallowed
$90:91A8 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:91AB D0 19       BNE $19    [$91C6]     ;} If [Samus X acceleration mode] = accelerating:
$90:91AD A5 8B       LDA $8B    [$7E:008B]  ;\
$90:91AF 89 00 01    BIT #$0100             ;} If not pressing right:
$90:91B2 D0 12       BNE $12    [$91C6]     ;/
$90:91B4 89 00 02    BIT #$0200             ;\
$90:91B7 D0 0D       BNE $0D    [$91C6]     ;} If not pressing left:
$90:91B9 64 12       STZ $12    [$7E:0012]  ;\
$90:91BB 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:91BD 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:91C0 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:91C3 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision

$90:91C6 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally
$90:91C9 20 C4 90    JSR $90C4  [$90:90C4]  ; Check if Samus has started falling
$90:91CC 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:91CF 28          PLP
$90:91D0 60          RTS
}


;;; $91D1: Samus morphed bouncing movement ;;;
{
; Called by:
;     $A5CA: Samus movement - morph ball - falling
;     $A6F1: Samus movement - spring ball - in air
;     $A703: Samus movement - spring ball - falling

$90:91D1 08          PHP
$90:91D2 C2 30       REP #$30
$90:91D4 20 D1 9B    JSR $9BD1  [$90:9BD1]  ; Determine Samus X speed table entry pointer
$90:91D7 20 1F 9B    JSR $9B1F  [$90:9B1F]  ; Calculate Samus X base speed - deceleration disallowed
$90:91DA AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:91DD D0 19       BNE $19    [$91F8]     ;} If [Samus X acceleration mode] = accelerating:
$90:91DF A5 8B       LDA $8B    [$7E:008B]  ;\
$90:91E1 89 00 01    BIT #$0100             ;} If not pressing right:
$90:91E4 D0 12       BNE $12    [$91F8]     ;/
$90:91E6 89 00 02    BIT #$0200             ;\
$90:91E9 D0 0D       BNE $0D    [$91F8]     ;} If not pressing left:
$90:91EB 64 12       STZ $12    [$7E:0012]  ;\
$90:91ED 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:91EF 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:91F2 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:91F5 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision

$90:91F8 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally
$90:91FB AD 52 0A    LDA $0A52  [$7E:0A52]  ;\
$90:91FE D0 3D       BNE $3D    [$923D]     ;} If [knockback direction] != 0: return
$90:9200 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;\
$90:9203 D0 05       BNE $05    [$920A]     ;|
$90:9205 AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;} If [extra Samus Y displacement] = 0.0: go to BRANCH_NO_EXTRA_DISPLACEMENT
$90:9208 F0 2D       BEQ $2D    [$9237]     ;/

$90:920A A9 02 00    LDA #$0002             ;\
$90:920D 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$90:9210 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:9213 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:9216 64 14       STZ $14    [$7E:0014]  ;\
$90:9218 64 12       STZ $12    [$7E:0012]  ;|
$90:921A AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;|
$90:921D 18          CLC                    ;|
$90:921E 65 14       ADC $14    [$7E:0014]  ;} $12.$14 = [extra Samus Y displacement]
$90:9220 85 14       STA $14    [$7E:0014]  ;|
$90:9222 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;|
$90:9225 65 12       ADC $12    [$7E:0012]  ;|
$90:9227 85 12       STA $12    [$7E:0012]  ;/
$90:9229 30 07       BMI $07    [$9232]     ; If [extra Samus Y displacement] >= 0:
$90:922B E6 12       INC $12    [$7E:0012]  ; $12.$14 += 1.0
$90:922D 20 40 94    JSR $9440  [$90:9440]  ; Move Samus down by [$12].[$14]
$90:9230 80 0B       BRA $0B    [$923D]     ; Return

$90:9232 20 EC 93    JSR $93EC  [$90:93EC]  ; Move Samus up by -[$12].[$14]
$90:9235 80 06       BRA $06    [$923D]     ; Return

; BRANCH_NO_EXTRA_DISPLACEMENT
$90:9237 20 C4 90    JSR $90C4  [$90:90C4]  ; Check if Samus has started falling
$90:923A 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations

$90:923D 28          PLP
$90:923E 60          RTS
}


;;; $923F: Samus Y movement - no speed calculations ;;;
{
; Called by:
;     $A383: Samus movement - standing
;     $A3E5: Samus movement - running
;     $A521: Samus movement - morph ball - on ground
;     $A573: Samus movement - crouching
;     $A5FC: Samus movement - knockback / crystal flash ending
;     $A61C: Samus movement - crouching/standing/morphing/unmorphing transition
;     $A67C: Samus movement - turning around - on ground
;     $A694: Samus movement - moonwalking
;     $A69F: Samus movement - spring ball - on ground
;     $A75F: Samus movement - ran into a wall
;     $A790: Samus movement - turning around - jumping
;     $A7AD: Samus movement - turning around - falling
;     $DF64: Knockback movement - down

; Total X speed is added to distance moved down in an attempt to keep Samus in contact with downwards slopes
; (unless it's already been determined that she's on a slope, in which case no adjustment is made)
; You'll note that this only works up to a steepness of 45°, which may or may not be intentional...
; If you wanted Samus to not fall off steep slopes, it might be better to just try pushing Samus to the bottom of the block that's one pixel down?
$90:923F 08          PHP
$90:9240 C2 30       REP #$30
$90:9242 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;\
$90:9245 D0 20       BNE $20    [$9267]     ;|
$90:9247 AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;} If [extra Samus Y displacement] != 0.0: go to BRANCH_USE_EXTRA_DISPLACEMENT
$90:924A D0 1B       BNE $1B    [$9267]     ;/
$90:924C AD BA 0D    LDA $0DBA  [$7E:0DBA]  ;\
$90:924F D0 0D       BNE $0D    [$925E]     ;} If Samus position was not adjusted by slope:
$90:9251 AD BE 0D    LDA $0DBE  [$7E:0DBE]  ;\
$90:9254 85 14       STA $14    [$7E:0014]  ;|
$90:9256 AD BC 0D    LDA $0DBC  [$7E:0DBC]  ;} $12.$14 = [total Samus X speed] + 1.0
$90:9259 1A          INC A                  ;|
$90:925A 85 12       STA $12    [$7E:0012]  ;/
$90:925C 80 07       BRA $07    [$9265]

$90:925E 64 14       STZ $14    [$7E:0014]  ;\ Else (Samus position was adjusted by slope):
$90:9260 A9 01 00    LDA #$0001             ;} $12.$14 = 1.0
$90:9263 85 12       STA $12    [$7E:0012]  ;/

$90:9265 80 17       BRA $17    [$927E]     ; Go to BRANCH_MOVE_DOWN

; BRANCH_USE_EXTRA_DISPLACEMENT
$90:9267 64 14       STZ $14    [$7E:0014]  ;\
$90:9269 64 12       STZ $12    [$7E:0012]  ;|
$90:926B AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;|
$90:926E 18          CLC                    ;|
$90:926F 65 14       ADC $14    [$7E:0014]  ;} $12.$14 = [extra Samus Y displacement]
$90:9271 85 14       STA $14    [$7E:0014]  ;|
$90:9273 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;|
$90:9276 65 12       ADC $12    [$7E:0012]  ;|
$90:9278 85 12       STA $12    [$7E:0012]  ;/
$90:927A 30 07       BMI $07    [$9283]     ; If [$12] < 0: go to BRANCH_MOVE_UP
$90:927C E6 12       INC $12    [$7E:0012]  ; $12.$14 += 1.0

; BRANCH_MOVE_DOWN
$90:927E 20 40 94    JSR $9440  [$90:9440]  ; Move Samus down by [$12].[$14]
$90:9281 80 03       BRA $03    [$9286]     ; Return

; BRANCH_MOVE_UP
$90:9283 20 EC 93    JSR $93EC  [$90:93EC]  ; Move Samus up by -[$12].[$14]

$90:9286 28          PLP
$90:9287 60          RTS
}


;;; $9288: Move Samus by extra Samus Y displacement ;;;
{
$90:9288 08          PHP
$90:9289 C2 30       REP #$30
$90:928B AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;\
$90:928E D0 07       BNE $07    [$9297]     ;|
$90:9290 AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;} If [extra Samus Y displacement] = 0.0:
$90:9293 D0 02       BNE $02    [$9297]     ;/
$90:9295 28          PLP
$90:9296 60          RTS                    ; Return

$90:9297 64 14       STZ $14    [$7E:0014]  ;\
$90:9299 64 12       STZ $12    [$7E:0012]  ;|
$90:929B AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;|
$90:929E 18          CLC                    ;|
$90:929F 65 14       ADC $14    [$7E:0014]  ;} $12.$14 = [extra Samus Y displacement]
$90:92A1 85 14       STA $14    [$7E:0014]  ;|
$90:92A3 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;|
$90:92A6 65 12       ADC $12    [$7E:0012]  ;|
$90:92A8 85 12       STA $12    [$7E:0012]  ;/
$90:92AA 30 07       BMI $07    [$92B3]     ; If [$12] < 0: go to BRANCH_MOVE_UP
$90:92AC E6 12       INC $12    [$7E:0012]  ; $12.$14 += 1.0
$90:92AE 20 40 94    JSR $9440  [$90:9440]  ; Move Samus down by [$12].[$14]
$90:92B1 80 03       BRA $03    [$92B6]     ; Return

$90:92B3 20 EC 93    JSR $93EC  [$90:93EC]  ; Move Samus up by -[$12].[$14]

$90:92B6 28          PLP
$90:92B7 60          RTS
}


;;; $92B8: Simple Samus Y movement ;;;
{
;; Returns:
;;     Carry: Set if [Samus Y direction] != none, clear otherwise

; Called by:
;     $A521: Samus movement - morph ball - on ground
;     $A69F: Samus movement - spring ball - on ground
;     $A790: Samus movement - turning around - jumping
;     $A7AD: Samus movement - turning around - falling

; In all cases, if this routine returns carry clear, $923F (Samus Y movement - no speed calculations) is called
$90:92B8 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:92BB D0 02       BNE $02    [$92BF]     ;} If [Samus Y direction] = none:
$90:92BD 18          CLC                    ;\
$90:92BE 60          RTS                    ;} Return carry clear

$90:92BF 20 C4 90    JSR $90C4  [$90:90C4]  ; Check if Samus has started falling
$90:92C2 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:92C5 38          SEC                    ;\
$90:92C6 60          RTS                    ;} Return carry set
}


;;; $92C7: Simple Samus Y movement ;;;
{
;; Returns:
;;     Carry: Set if [Samus Y direction] != none, clear otherwise

; Clone of $92B8
; Called by:
;     $A61C: Samus movement - crouching/standing/morphing/unmorphing transition

$90:92C7 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:92CA D0 02       BNE $02    [$92CE]     ;} If [Samus Y direction] = none:
$90:92CC 18          CLC                    ;\
$90:92CD 60          RTS                    ;} Return carry clear

$90:92CE 20 C4 90    JSR $90C4  [$90:90C4]  ; Check if Samus has started falling
$90:92D1 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:92D4 38          SEC                    ;\
$90:92D5 60          RTS                    ;} Return carry set
}


;;; $92D6: Unused ;;;
{
;; Parameters:
;;     $12: Samus Y velocity
$90:92D6 08          PHP
$90:92D7 C2 30       REP #$30
$90:92D9 80 00       BRA $00    [$92DB]

$90:92DB AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:92DE 18          CLC                    ;|
$90:92DF 65 12       ADC $12    [$7E:0012]  ;} Samus Y position += [$12]
$90:92E1 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:92E4 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$90:92E7 28          PLP
$90:92E8 60          RTS
}


;;; $92E9: RTS ;;;
{
; Looks like an old routine that was RTS'd out
; Called by $A75F: Samus movement - ran into a wall
$90:92E9 60          RTS

$90:92EA 08          PHP
$90:92EB C2 30       REP #$30
$90:92ED A9 01 00    LDA #$0001             ;\
$90:92F0 85 12       STA $12    [$7E:0012]  ;} $12.$14 = 1.0
$90:92F2 64 14       STZ $14    [$7E:0014]  ;/
$90:92F4 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:92F7 29 FF 00    AND #$00FF             ;|
$90:92FA C9 04 00    CMP #$0004             ;} If facing right:
$90:92FD F0 09       BEQ $09    [$9308]     ;/
$90:92FF A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9301 89 00 01    BIT #$0100             ;} If pressing right: go to BRANCH_RIGHTWARDS
$90:9304 D0 0B       BNE $0B    [$9311]     ;/
$90:9306 80 3E       BRA $3E    [$9346]     ; Return

$90:9308 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:930A 89 00 02    BIT #$0200             ;} If pressing left: go to BRANCH_LEFTWARDS
$90:930D D0 07       BNE $07    [$9316]     ;/
$90:930F 80 35       BRA $35    [$9346]     ; Return

; BRANCH_RIGHTWARDS
$90:9311 20 AD E4    JSR $E4AD  [$90:E4AD]  ; Calculate Samus X displacement for moving right
$90:9314 80 03       BRA $03    [$9319]     ; Go to BRANCH_MERGE

; BRANCH_LEFTWARDS
$90:9316 20 64 E4    JSR $E464  [$90:E464]  ; Calculate Samus X displacement for moving left

; BRANCH_MERGE
$90:9319 A5 12       LDA $12    [$7E:0012]  ;\
$90:931B 30 05       BMI $05    [$9322]     ;} If [$12] >= 0:
$90:931D 20 B1 93    JSR $93B1  [$90:93B1]  ; Move Samus right by [$12].[$14]
$90:9320 80 03       BRA $03    [$9325]
                                            ; Else ([$12] < 0):
$90:9322 20 50 93    JSR $9350  [$90:9350]  ; Move Samus left by -[$12].[$14]

$90:9325 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:9328 D0 1C       BNE $1C    [$9346]     ;} If solid collision: return
$90:932A AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:932D 29 FF 00    AND #$00FF             ;|
$90:9330 C9 04 00    CMP #$0004             ;} If facing right:
$90:9333 F0 08       BEQ $08    [$933D]     ;/
$90:9335 A9 09 00    LDA #$0009             ;\
$90:9338 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = moving right - not aiming
$90:933B 80 06       BRA $06    [$9343]

$90:933D A9 0A 00    LDA #$000A             ;\ Else (facing left):
$90:9340 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = moving left - not aiming

$90:9343 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change

$90:9346 28          PLP
$90:9347 60          RTS
}


;;; $9348: Move Samus horizontally with zero base X speed ;;;
{
$90:9348 64 12       STZ $12    [$7E:0012]  ;\
$90:934A 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:934C 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally
$90:934F 60          RTS
}


;;; $9350: Move Samus left by -[$12].[$14] ;;;
{
$90:9350 08          PHP
$90:9351 C2 30       REP #$30
$90:9353 A5 12       LDA $12    [$7E:0012]  ;\
$90:9355 49 FF FF    EOR #$FFFF             ;|
$90:9358 85 12       STA $12    [$7E:0012]  ;|
$90:935A A5 14       LDA $14    [$7E:0014]  ;|
$90:935C 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:935F 1A          INC A                  ;|
$90:9360 85 14       STA $14    [$7E:0014]  ;|
$90:9362 D0 02       BNE $02    [$9366]     ;|
$90:9364 E6 12       INC $12    [$7E:0012]  ;/

$90:9366 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:936A 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$90:936D AA          TAX                    ;\
$90:936E F0 0C       BEQ $0C    [$937C]     ;} If collision detected:
$90:9370 20 CE E5    JSR $E5CE  [$90:E5CE]  ; Kill Samus X speed if collision detected
$90:9373 20 42 98    JSR $9842  [$90:9842]  ; Move Samus left by [$12].[$14], no collision detection
$90:9376 22 F4 87 94 JSL $9487F4[$94:87F4]  ; Align Samus Y position with non-square slope
$90:937A 28          PLP
$90:937B 60          RTS                    ; Return

$90:937C A5 12       LDA $12    [$7E:0012]  ;\
$90:937E 49 FF FF    EOR #$FFFF             ;|
$90:9381 85 12       STA $12    [$7E:0012]  ;|
$90:9383 A5 14       LDA $14    [$7E:0014]  ;|
$90:9385 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9388 1A          INC A                  ;|
$90:9389 85 14       STA $14    [$7E:0014]  ;|
$90:938B D0 02       BNE $02    [$938F]     ;|
$90:938D E6 12       INC $12    [$7E:0012]  ;/

$90:938F 22 1E 97 94 JSL $94971E[$94:971E]  ; Move Samus right by [$12].[$14], no solid enemy collision
$90:9393 A5 14       LDA $14    [$7E:0014]  ;\
$90:9395 8D AC 0D    STA $0DAC  [$7E:0DAC]  ;|
$90:9398 A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved left = [$12].[$14]
$90:939A 8D AA 0D    STA $0DAA  [$7E:0DAA]  ;/
$90:939D AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$90:93A0 89 01 00    BIT #$0001             ;} If [collision direction] = right:
$90:93A3 F0 03       BEQ $03    [$93A8]     ;/
$90:93A5 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision

$90:93A8 20 CE E5    JSR $E5CE  [$90:E5CE]  ; Kill Samus X speed if collision detected
$90:93AB 22 F4 87 94 JSL $9487F4[$94:87F4]  ; Align Samus Y position with non-square slope
$90:93AF 28          PLP
$90:93B0 60          RTS
}


;;; $93B1: Move Samus right by [$12].[$14] ;;;
{
$90:93B1 08          PHP
$90:93B2 C2 30       REP #$30
$90:93B4 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:93B8 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$90:93BB AA          TAX                    ;\
$90:93BC F0 0C       BEQ $0C    [$93CA]     ;} If collision detected:
$90:93BE 20 CE E5    JSR $E5CE  [$90:E5CE]  ; Kill Samus X speed if collision detected
$90:93C1 20 26 98    JSR $9826  [$90:9826]  ; Move Samus right by [$12].[$14], no collision detection
$90:93C4 22 F4 87 94 JSL $9487F4[$94:87F4]  ; Align Samus Y position with non-square slope
$90:93C8 28          PLP
$90:93C9 60          RTS                    ; Return

$90:93CA 22 1E 97 94 JSL $94971E[$94:971E]  ; Move Samus right by [$12].[$14], no solid enemy collision
$90:93CE A5 14       LDA $14    [$7E:0014]  ;\
$90:93D0 8D B0 0D    STA $0DB0  [$7E:0DB0]  ;|
$90:93D3 A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved right = [$12].[$14]
$90:93D5 8D AE 0D    STA $0DAE  [$7E:0DAE]  ;/
$90:93D8 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$90:93DB 89 01 00    BIT #$0001             ;} If [collision direction] != right:
$90:93DE D0 03       BNE $03    [$93E3]     ;/
$90:93E0 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision

$90:93E3 20 CE E5    JSR $E5CE  [$90:E5CE]  ; Kill Samus X speed if collision detected
$90:93E6 22 F4 87 94 JSL $9487F4[$94:87F4]  ; Align Samus Y position with non-square slope
$90:93EA 28          PLP
$90:93EB 60          RTS
}


;;; $93EC: Move Samus up by -[$12].[$14] ;;;
{
$90:93EC 08          PHP
$90:93ED C2 30       REP #$30
$90:93EF A9 02 00    LDA #$0002             ;\
$90:93F2 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = up
$90:93F5 A5 12       LDA $12    [$7E:0012]  ;\
$90:93F7 49 FF FF    EOR #$FFFF             ;|
$90:93FA 85 12       STA $12    [$7E:0012]  ;|
$90:93FC A5 14       LDA $14    [$7E:0014]  ;|
$90:93FE 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9401 1A          INC A                  ;|
$90:9402 85 14       STA $14    [$7E:0014]  ;|
$90:9404 D0 02       BNE $02    [$9408]     ;|
$90:9406 E6 12       INC $12    [$7E:0012]  ;/

$90:9408 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:940C 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$90:940F AA          TAX                    ;\
$90:9410 F0 08       BEQ $08    [$941A]     ;} If collision detected:
$90:9412 20 06 E6    JSR $E606  [$90:E606]  ; Set Samus solid vertical collision result - upwards movement
$90:9415 20 8D 98    JSR $988D  [$90:988D]  ; Move Samus up by [$12].[$14], no collision detection
$90:9418 28          PLP
$90:9419 60          RTS                    ; Return

$90:941A A5 12       LDA $12    [$7E:0012]  ;\
$90:941C 49 FF FF    EOR #$FFFF             ;|
$90:941F 85 12       STA $12    [$7E:0012]  ;|
$90:9421 A5 14       LDA $14    [$7E:0014]  ;|
$90:9423 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9426 1A          INC A                  ;|
$90:9427 85 14       STA $14    [$7E:0014]  ;|
$90:9429 D0 02       BNE $02    [$942D]     ;|
$90:942B E6 12       INC $12    [$7E:0012]  ;/

$90:942D 22 63 97 94 JSL $949763[$94:9763]  ; Move Samus down by [$12].[$14], no solid enemy collision
$90:9431 A5 14       LDA $14    [$7E:0014]  ;\
$90:9433 8D B4 0D    STA $0DB4  [$7E:0DB4]  ;|
$90:9436 A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved up = [$12].[$14]
$90:9438 8D B2 0D    STA $0DB2  [$7E:0DB2]  ;/
$90:943B 20 06 E6    JSR $E606  [$90:E606]  ; Set Samus solid vertical collision result - upwards movement
$90:943E 28          PLP
$90:943F 60          RTS
}


;;; $9440: Move Samus down by [$12].[$14] ;;;
{
$90:9440 08          PHP
$90:9441 C2 30       REP #$30
$90:9443 A9 03 00    LDA #$0003             ;\
$90:9446 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = down
$90:9449 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:944D 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$90:9450 AA          TAX                    ;\
$90:9451 F0 08       BEQ $08    [$945B]     ;} If collision detected:
$90:9453 20 1B E6    JSR $E61B  [$90:E61B]  ; Set Samus solid vertical collision result - downwards movement
$90:9456 20 71 98    JSR $9871  [$90:9871]  ; Move Samus down by [$12].[$14], no collision detection
$90:9459 28          PLP
$90:945A 60          RTS                    ; Return

$90:945B 22 63 97 94 JSL $949763[$94:9763]  ; Move Samus down by [$12].[$14], no solid enemy collision
$90:945F A5 14       LDA $14    [$7E:0014]  ;\
$90:9461 8D B8 0D    STA $0DB8  [$7E:0DB8]  ;|
$90:9464 A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved down = [$12].[$14]
$90:9466 8D B6 0D    STA $0DB6  [$7E:0DB6]  ;/
$90:9469 20 1B E6    JSR $E61B  [$90:E61B]  ; Set Samus solid vertical collision result - downwards movement
$90:946C 28          PLP
$90:946D 60          RTS
}


;;; $946E: Samus movement handler - released from grapple swing ;;;
{
$90:946E AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:9471 C9 01 00    CMP #$0001             ;} If [Samus Y direction] = up:
$90:9474 D0 17       BNE $17    [$948D]     ;/
$90:9476 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:9479 10 12       BPL $12    [$948D]     ;} If [Samus Y speed] < 0:
$90:947B 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:947E 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:9481 A9 02 00    LDA #$0002             ;\
$90:9484 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$90:9487 A9 37 A3    LDA #$A337             ;\
$90:948A 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)

$90:948D A9 02 00    LDA #$0002             ;\
$90:9490 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating
$90:9493 20 21 9C    JSR $9C21  [$90:9C21]  ; Determine grapple swing Samus X speed table entry pointer
$90:9496 20 7E 9A    JSR $9A7E  [$90:9A7E]  ; Calculate Samus X base speed - deceleration allowed
$90:9499 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:949C D0 1B       BNE $1B    [$94B9]     ;} If [Samus X acceleration mode] = accelerating:
$90:949E A5 8B       LDA $8B    [$7E:008B]  ;\
$90:94A0 89 00 01    BIT #$0100             ;} If not pressing right:
$90:94A3 D0 14       BNE $14    [$94B9]     ;/
$90:94A5 89 00 02    BIT #$0200             ;\
$90:94A8 D0 0F       BNE $0F    [$94B9]     ;} If not pressing left:
$90:94AA 64 12       STZ $12    [$7E:0012]  ;\
$90:94AC 64 14       STZ $14    [$7E:0014]  ;} $12 = 0.0
$90:94AE 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:94B1 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:94B4 9C D0 0D    STZ $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:94B7 80 03       BRA $03    [$94BC]
                                            ; Else ([Samus X acceleration mode] != accelerating or pressing right/left):
$90:94B9 20 A9 8E    JSR $8EA9  [$90:8EA9]  ; Move Samus horizontally

$90:94BC 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:94BF AD C6 0D    LDA $0DC6  [$7E:0DC6]  ;\
$90:94C2 F0 06       BEQ $06    [$94CA]     ;} If [Samus solid vertical collision result] != no change:
$90:94C4 A9 37 A3    LDA #$A337             ;\
$90:94C7 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)

$90:94CA 60          RTS
}


;;; $94CB: Samus movement handler - Samus drained - falling ;;;
{
$90:94CB 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:94CE AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:94D1 F0 18       BEQ $18    [$94EB]     ;} If no solid collision: return
$90:94D3 A9 37 A3    LDA #$A337             ;\
$90:94D6 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:94D9 A9 08 00    LDA #$0008             ;\
$90:94DC 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 8
$90:94DF A9 07 00    LDA #$0007             ;\
$90:94E2 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 7 (crouching)
$90:94E5 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:94E8 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0

$90:94EB 60          RTS
}
}


;;; $94EC..973D: Scrolling ;;;
{
;;; $94EC: Main scrolling routine ;;;
{
; Called by:
;     $82:8B44: Game state 8 (main gameplay)
;     $82:E675 (unused door transition routine)
$90:94EC 08          PHP
$90:94ED 8B          PHB
$90:94EE 4B          PHK                    ;\
$90:94EF AB          PLB                    ;} DB = $90
$90:94F0 C2 30       REP #$30
$90:94F2 AD F8 0C    LDA $0CF8  [$7E:0CF8]  ;\
$90:94F5 F0 60       BEQ $60    [$9557]     ;} If [slow grapple scrolling flag] = 0: go to BRANCH_NORMAL_SCROLLING
$90:94F7 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:94FA 30 51       BMI $51    [$954D]     ;} If [Samus X position] < 0: go to BRANCH_GRAPPLE_SCROLL_VERTICAL_END
$90:94FC 38          SEC                    ;\
$90:94FD ED 11 09    SBC $0911  [$7E:0911]  ;} If [Samus X position] - [layer 1 X position] < 0: go to BRANCH_GRAPPLE_SCROLL_LEFT
$90:9500 90 16       BCC $16    [$9518]     ;/
$90:9502 C9 A0 00    CMP #$00A0             ;\
$90:9505 90 0C       BCC $0C    [$9513]     ;} If [Samus X position] - [layer 1 X position] >= A0h:
$90:9507 AD 11 09    LDA $0911  [$7E:0911]  ;\
$90:950A 18          CLC                    ;|
$90:950B 69 03 00    ADC #$0003             ;} Layer 1 X position += 3
$90:950E 8D 11 09    STA $0911  [$7E:0911]  ;/
$90:9511 80 0F       BRA $0F    [$9522]     ; Go to BRANCH_GRAPPLE_SCROLL_HORIZONTAL_END

$90:9513 C9 60 00    CMP #$0060             ;\
$90:9516 B0 0A       BCS $0A    [$9522]     ;} If [Samus X position] - [layer 1 X position] >= 60h: go to BRANCH_GRAPPLE_SCROLL_HORIZONTAL_END

; BRANCH_GRAPPLE_SCROLL_LEFT
$90:9518 AD 11 09    LDA $0911  [$7E:0911]  ;\
$90:951B 38          SEC                    ;|
$90:951C E9 03 00    SBC #$0003             ;} Layer 1 X position -= 3
$90:951F 8D 11 09    STA $0911  [$7E:0911]  ;/

; BRANCH_GRAPPLE_SCROLL_HORIZONTAL_END
$90:9522 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:9525 30 26       BMI $26    [$954D]     ;} If [Samus Y position] < 0: go to BRANCH_GRAPPLE_SCROLL_VERTICAL_END
$90:9527 38          SEC                    ;\
$90:9528 ED 15 09    SBC $0915  [$7E:0915]  ;} If [Samus Y position] - [layer 1 Y position] < 0: go to BRANCH_GRAPPLE_SCROLL_UP
$90:952B 90 16       BCC $16    [$9543]     ;/
$90:952D C9 90 00    CMP #$0090             ;\
$90:9530 90 0C       BCC $0C    [$953E]     ;} If [Samus Y position] - [layer 1 Y position] >= 90h:
$90:9532 AD 15 09    LDA $0915  [$7E:0915]  ;\
$90:9535 18          CLC                    ;|
$90:9536 69 03 00    ADC #$0003             ;} Layer 1 Y position += 3
$90:9539 8D 15 09    STA $0915  [$7E:0915]  ;/
$90:953C 80 0F       BRA $0F    [$954D]     ; Go to BRANCH_GRAPPLE_SCROLL_VERTICAL_END

$90:953E C9 70 00    CMP #$0070             ;\
$90:9541 B0 0A       BCS $0A    [$954D]     ;} If [Samus Y position] - [layer 1 Y position] >= 70h: go to BRANCH_GRAPPLE_SCROLL_VERTICAL_END

; BRANCH_GRAPPLE_SCROLL_UP
$90:9543 AD 15 09    LDA $0915  [$7E:0915]  ;\
$90:9546 38          SEC                    ;|
$90:9547 E9 03 00    SBC #$0003             ;} Layer 1 Y position -= 3
$90:954A 8D 15 09    STA $0915  [$7E:0915]  ;/

; BRANCH_GRAPPLE_SCROLL_VERTICAL_END
$90:954D 22 28 A5 80 JSL $80A528[$80:A528]  ; Handle scroll zones - horizontal autoscrolling
$90:9551 22 31 A7 80 JSL $80A731[$80:A731]  ; Handle scroll zones - vertical autoscrolling
$90:9555 80 0C       BRA $0C    [$9563]     ; Go to BRANCH_FINISHED_SCROLLING

; BRANCH_NORMAL_SCROLLING
$90:9557 20 C0 96    JSR $96C0  [$90:96C0]  ; Calculate the horizontal distance Samus has moved last frame + 1
$90:955A 20 A0 95    JSR $95A0  [$90:95A0]  ; Handle horizontal scrolling
$90:955D 20 FF 96    JSR $96FF  [$90:96FF]  ; Calculate the vertical distance Samus has moved last frame + 1
$90:9560 20 4F 96    JSR $964F  [$90:964F]  ; Handle vertical scrolling

; BRANCH_FINISHED_SCROLLING
$90:9563 AE E9 07    LDX $07E9  [$7E:07E9]  ;\
$90:9566 F0 06       BEQ $06    [$956E]     ;} If [scrolling finished hook] != 0:
$90:9568 A2 00 00    LDX #$0000             ;\
$90:956B FC E9 07    JSR ($07E9,x)[$90:9589];} Execute [scrolling finished hook]

$90:956E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:9571 8D 10 0B    STA $0B10  [$7E:0B10]  ;} Samus previous X position = [Samus X position]
$90:9574 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$90:9577 8D 12 0B    STA $0B12  [$7E:0B12]  ;} Samus previous X subposition = [Samus X subposition]
$90:957A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:957D 8D 14 0B    STA $0B14  [$7E:0B14]  ;} Samus previous Y position = [Samus Y position]
$90:9580 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$90:9583 8D 16 0B    STA $0B16  [$7E:0B16]  ;} Samus previous Y subposition = [Samus Y subposition]
$90:9586 AB          PLB
$90:9587 28          PLP
$90:9588 6B          RTL
}


;;; $9589: Scrolling finished hook - Spore Spawn fight ;;;
{
$90:9589 A9 D0 01    LDA #$01D0             ;\
$90:958C CD 15 09    CMP $0915  [$7E:0915]  ;|
$90:958F 90 03       BCC $03    [$9594]     ;} Layer 1 Y position = max([layer 1 Y position], 1D0h)
$90:9591 8D 15 09    STA $0915  [$7E:0915]  ;/

$90:9594 60          RTS
}


;;; $9595: Unused. Camera X speed = 0.0 ;;;
{
$90:9595 08          PHP
$90:9596 C2 30       REP #$30
$90:9598 9C A4 0D    STZ $0DA4  [$7E:0DA4]
$90:959B 9C A2 0D    STZ $0DA2  [$7E:0DA2]
$90:959E 28          PLP
$90:959F 60          RTS
}


;;; $95A0: Handle horizontal scrolling ;;;
{
$90:95A0 08          PHP
$90:95A1 C2 30       REP #$30
$90:95A3 AD 10 0B    LDA $0B10  [$7E:0B10]  ;\
$90:95A6 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [Samus X position] = [Samus previous X position]:
$90:95A9 D0 07       BNE $07    [$95B2]     ;/
$90:95AB 22 28 A5 80 JSL $80A528[$80:A528]  ; Handle scroll zones - horizontal autoscrolling
$90:95AF 4C 3D 96    JMP $963D  [$90:963D]  ; Return

$90:95B2 AD 11 09    LDA $0911  [$7E:0911]  ;\
$90:95B5 85 12       STA $12    [$7E:0012]  ;} $12 = [layer 1 X position]
$90:95B7 AD 52 0A    LDA $0A52  [$7E:0A52]  ;\
$90:95BA D0 0B       BNE $0B    [$95C7]     ;} If [knockback direction] != none: go to BRANCH_BACKWARDS
$90:95BC AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:95BF 29 FF 00    AND #$00FF             ;|
$90:95C2 C9 10 00    CMP #$0010             ;} If [Samus movement type] != moonwalking: go to BRANCH_FORWARDS
$90:95C5 D0 0D       BNE $0D    [$95D4]     ;/

; BRANCH_BACKWARDS
$90:95C7 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:95CA 29 FF 00    AND #$00FF             ;|
$90:95CD C9 04 00    CMP #$0004             ;} If Samus is facing left: go to BRANCH_RIGHT
$90:95D0 F0 15       BEQ $15    [$95E7]     ;/
$90:95D2 80 22       BRA $22    [$95F6]     ; Go to BRANCH_LEFT

; BRANCH_FORWARDS
$90:95D4 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:95D7 C9 01 00    CMP #$0001             ;} If [Samus X acceleration mode] = turning around: go to BRANCH_BACKWARDS
$90:95DA F0 EB       BEQ $EB    [$95C7]     ;/
$90:95DC AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:95DF 29 FF 00    AND #$00FF             ;|
$90:95E2 C9 04 00    CMP #$0004             ;} If Samus is facing left: go to BRANCH_LEFT
$90:95E5 F0 0F       BEQ $0F    [$95F6]     ;/

; BRANCH_RIGHT
$90:95E7 AE 41 09    LDX $0941  [$7E:0941]  ;\
$90:95EA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$90:95ED 38          SEC                    ;} Ideal layer 1 X position = [Samus X position] - [$963F + [camera distance index]]
$90:95EE FD 3F 96    SBC $963F,x[$90:963F]  ;|
$90:95F1 8D 0A 0B    STA $0B0A  [$7E:0B0A]  ;/
$90:95F4 80 0D       BRA $0D    [$9603]     ; Go to BRANCH_MERGE

; BRANCH_LEFT
$90:95F6 AE 41 09    LDX $0941  [$7E:0941]  ;\
$90:95F9 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$90:95FC 38          SEC                    ;} Ideal layer 1 X position = [Samus X position] - [$9647 + [camera distance index]]
$90:95FD FD 47 96    SBC $9647,x[$90:9647]  ;|
$90:9600 8D 0A 0B    STA $0B0A  [$7E:0B0A]  ;/

; BRANCH_MERGE
$90:9603 AD 0A 0B    LDA $0B0A  [$7E:0B0A]  ;\
$90:9606 CD 11 09    CMP $0911  [$7E:0911]  ;} If [ideal layer 1 X position] = [layer 1 X position]: return
$90:9609 F0 32       BEQ $32    [$963D]     ;/
$90:960B 30 19       BMI $19    [$9626]     ; If [ideal layer 1 X position] > [layer 1 X position]:
$90:960D AD 0F 09    LDA $090F  [$7E:090F]  ;\
$90:9610 18          CLC                    ;|
$90:9611 6D A4 0D    ADC $0DA4  [$7E:0DA4]  ;|
$90:9614 8D 0F 09    STA $090F  [$7E:090F]  ;} Layer 1 X position += [camera X speed]
$90:9617 AD 11 09    LDA $0911  [$7E:0911]  ;|
$90:961A 6D A2 0D    ADC $0DA2  [$7E:0DA2]  ;|
$90:961D 8D 11 09    STA $0911  [$7E:0911]  ;/
$90:9620 22 41 A6 80 JSL $80A641[$80:A641]  ; Handle scroll zones - scrolling right
$90:9624 80 17       BRA $17    [$963D]

$90:9626 AD 0F 09    LDA $090F  [$7E:090F]  ;\ Else ([ideal layer 1 X position] < [layer 1 X position]):
$90:9629 38          SEC                    ;|
$90:962A ED A4 0D    SBC $0DA4  [$7E:0DA4]  ;|
$90:962D 8D 0F 09    STA $090F  [$7E:090F]  ;} Layer 1 X position -= [camera X speed]
$90:9630 AD 11 09    LDA $0911  [$7E:0911]  ;|
$90:9633 ED A2 0D    SBC $0DA2  [$7E:0DA2]  ;|
$90:9636 8D 11 09    STA $0911  [$7E:0911]  ;/
$90:9639 22 BB A6 80 JSL $80A6BB[$80:A6BB]  ; Handle scroll zones - scrolling left

$90:963D 28          PLP
$90:963E 60          RTS

; Target distance camera is to the left of Samus
$90:963F             dw 0060, 0040, 0020, 00E0 ; When Samus is facing right
$90:9647             dw 00A0, 0050, 0020, 00E0 ; When Samus is facing left
}


;;; $964F: Handle vertical scrolling ;;;
{
$90:964F 08          PHP
$90:9650 C2 30       REP #$30
$90:9652 AD 14 0B    LDA $0B14  [$7E:0B14]  ;\
$90:9655 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [Samus Y position] = [Samus previous Y position]:
$90:9658 D0 07       BNE $07    [$9661]     ;/
$90:965A 22 31 A7 80 JSL $80A731[$80:A731]  ; Handle scroll zones - vertical autoscrolling
$90:965E 4C BE 96    JMP $96BE  [$90:96BE]  ; Return

$90:9661 AD 15 09    LDA $0915  [$7E:0915]  ;\
$90:9664 85 12       STA $12    [$7E:0012]  ;} $12 = [layer 1 Y position]
$90:9666 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:9669 C9 01 00    CMP #$0001             ;} If [Samus Y direction] != up:
$90:966C F0 0C       BEQ $0C    [$967A]     ;/
$90:966E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:9671 38          SEC                    ;|
$90:9672 ED AD 07    SBC $07AD  [$7E:07AD]  ;} Ideal layer 1 Y position = [Samus Y position] - [up scroller]
$90:9675 8D 0E 0B    STA $0B0E  [$7E:0B0E]  ;/
$90:9678 80 0A       BRA $0A    [$9684]

$90:967A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\ Else ([Samus Y direction] = up):
$90:967D 38          SEC                    ;|
$90:967E ED AF 07    SBC $07AF  [$7E:07AF]  ;} Ideal layer 1 Y position = [Samus Y position] - [down scroller]
$90:9681 8D 0E 0B    STA $0B0E  [$7E:0B0E]  ;/

$90:9684 AD 0E 0B    LDA $0B0E  [$7E:0B0E]  ;\
$90:9687 CD 15 09    CMP $0915  [$7E:0915]  ;} If [ideal layer 1 Y position] = [layer 1 Y position]: return
$90:968A F0 32       BEQ $32    [$96BE]     ;/
$90:968C 30 19       BMI $19    [$96A7]     ; If [ideal layer 1 Y position] > [layer 1 Y position]:
$90:968E AD 13 09    LDA $0913  [$7E:0913]  ;\
$90:9691 18          CLC                    ;|
$90:9692 6D A8 0D    ADC $0DA8  [$7E:0DA8]  ;|
$90:9695 8D 13 09    STA $0913  [$7E:0913]  ;} Layer 1 Y position += [camera Y speed]
$90:9698 AD 15 09    LDA $0915  [$7E:0915]  ;|
$90:969B 6D A6 0D    ADC $0DA6  [$7E:0DA6]  ;|
$90:969E 8D 15 09    STA $0915  [$7E:0915]  ;/
$90:96A1 22 93 A8 80 JSL $80A893[$80:A893]  ; Handle scroll zones - scrolling down
$90:96A5 80 17       BRA $17    [$96BE]

$90:96A7 AD 13 09    LDA $0913  [$7E:0913]  ;\ Else ([ideal layer 1 Y position] < [layer 1 Y position]):
$90:96AA 38          SEC                    ;|
$90:96AB ED A8 0D    SBC $0DA8  [$7E:0DA8]  ;|
$90:96AE 8D 13 09    STA $0913  [$7E:0913]  ;} Layer 1 Y position -= [camera Y speed]
$90:96B1 AD 15 09    LDA $0915  [$7E:0915]  ;|
$90:96B4 ED A6 0D    SBC $0DA6  [$7E:0DA6]  ;|
$90:96B7 8D 15 09    STA $0915  [$7E:0915]  ;/
$90:96BA 22 36 A9 80 JSL $80A936[$80:A936]  ; Handle scroll zones - scrolling up

$90:96BE 28          PLP
$90:96BF 60          RTS
}


;;; $96C0: Calculate camera X speed ;;;
{
; This check to go to BRANCH_RIGHT doesn't include the subpixel position,
; so that branch may be taken even if Samus moved left, so long as she hasn't reached the next pixel
; In that case, the ([Samus X position] - [Samus previous X position]) calculation results in a value -1.0 < x < 0.0,
; and as such, "absolute X distance Samus moved last frame + 1" can be less than 1
; >_>;
$90:96C0 08          PHP
$90:96C1 C2 30       REP #$30
$90:96C3 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:96C6 CD 10 0B    CMP $0B10  [$7E:0B10]  ;} If [Samus X position] >= [Samus previous X position]:
$90:96C9 30 02       BMI $02    [$96CD]     ;/
$90:96CB 80 19       BRA $19    [$96E6]     ; Go to BRANCH_RIGHT

$90:96CD AD 12 0B    LDA $0B12  [$7E:0B12]  ;\
$90:96D0 38          SEC                    ;|
$90:96D1 ED F8 0A    SBC $0AF8  [$7E:0AF8]  ;|
$90:96D4 8D A4 0D    STA $0DA4  [$7E:0DA4]  ;|
$90:96D7 AD 10 0B    LDA $0B10  [$7E:0B10]  ;} Camera X speed = [Samus previous X position] - [Samus X position] + 1.0
$90:96DA ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$90:96DD 18          CLC                    ;|
$90:96DE 6D AD 9E    ADC $9EAD  [$90:9EAD]  ;|
$90:96E1 8D A2 0D    STA $0DA2  [$7E:0DA2]  ;/
$90:96E4 80 17       BRA $17    [$96FD]     ; Return

; BRANCH_RIGHT
$90:96E6 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$90:96E9 38          SEC                    ;|
$90:96EA ED 12 0B    SBC $0B12  [$7E:0B12]  ;|
$90:96ED 8D A4 0D    STA $0DA4  [$7E:0DA4]  ;|
$90:96F0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;} Camera X speed = [Samus X position] - [Samus previous X position] + 1.0
$90:96F3 ED 10 0B    SBC $0B10  [$7E:0B10]  ;|
$90:96F6 18          CLC                    ;|
$90:96F7 6D AD 9E    ADC $9EAD  [$90:9EAD]  ;|
$90:96FA 8D A2 0D    STA $0DA2  [$7E:0DA2]  ;/

$90:96FD 28          PLP
$90:96FE 60          RTS
}


;;; $96FF: Calculate the vertical distance Samus has moved last frame + 1 ;;;
{
; Result can be less than 1.0, see $96C0
$90:96FF 08          PHP
$90:9700 C2 30       REP #$30
$90:9702 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:9705 CD 14 0B    CMP $0B14  [$7E:0B14]  ;} If [Samus Y position] >= [Samus previous Y position]:
$90:9708 30 02       BMI $02    [$970C]     ;/
$90:970A 80 19       BRA $19    [$9725]     ; Go to BRANCH_DOWN

$90:970C AD 16 0B    LDA $0B16  [$7E:0B16]  ;\
$90:970F 38          SEC                    ;|
$90:9710 ED FC 0A    SBC $0AFC  [$7E:0AFC]  ;|
$90:9713 8D A8 0D    STA $0DA8  [$7E:0DA8]  ;|
$90:9716 AD 14 0B    LDA $0B14  [$7E:0B14]  ;} Camera Y speed = [Samus previous Y position] - [Samus Y position] + 1.0
$90:9719 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$90:971C 18          CLC                    ;|
$90:971D 6D AD 9E    ADC $9EAD  [$90:9EAD]  ;|
$90:9720 8D A6 0D    STA $0DA6  [$7E:0DA6]  ;/
$90:9723 80 17       BRA $17    [$973C]     ; Return

; BRANCH_DOWN
$90:9725 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$90:9728 38          SEC                    ;|
$90:9729 ED 16 0B    SBC $0B16  [$7E:0B16]  ;|
$90:972C 8D A8 0D    STA $0DA8  [$7E:0DA8]  ;|
$90:972F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} Camera Y speed = [Samus Y position] - [Samus previous Y position] + 1.0
$90:9732 ED 14 0B    SBC $0B14  [$7E:0B14]  ;|
$90:9735 18          CLC                    ;|
$90:9736 6D AD 9E    ADC $9EAD  [$90:9EAD]  ;|
$90:9739 8D A6 0D    STA $0DA6  [$7E:0DA6]  ;/

$90:973C 28          PLP
$90:973D 60          RTS
}
}


;;; $973E..A7E1: Samus movement ;;;
{
;;; $973E: Handle Samus X extra run speed ;;;
{
; If not eligible to run or not running, set extra run speed to zero
; Otherwise accelerate and cap at max speed, depending on speed booster
$90:973E 08          PHP
$90:973F C2 30       REP #$30
$90:9741 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9744 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_GRAVITY
$90:9747 D0 18       BNE $18    [$9761]     ;/
$90:9749 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:974D AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:9750 30 06       BMI $06    [$9758]     ;} If [FX Y position] >= 0:
$90:9752 C5 12       CMP $12    [$7E:0012]  ;\
$90:9754 30 10       BMI $10    [$9766]     ;} If [FX Y position] < (Samus bottom boundary): go to BRANCH_SUBMERGED
$90:9756 80 09       BRA $09    [$9761]

$90:9758 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:975B 30 04       BMI $04    [$9761]     ;} If [lava/acid Y position] >= 0:
$90:975D C5 12       CMP $12    [$7E:0012]  ;\
$90:975F 30 0D       BMI $0D    [$976E]     ;} If [lava/acid Y position] < (Samus bottom boundary): go to BRANCH_NOT_RUNNING

; BRANCH_GRAVITY
$90:9761 A2 00 00    LDX #$0000             ; X = 0
$90:9764 80 0B       BRA $0B    [$9771]     ; Go to BRANCH_GRAVITY_CONTINUED

; BRANCH_SUBMERGED
$90:9766 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9769 89 04 00    BIT #$0004             ;} If water physics are disabled: go to BRANCH_GRAVITY
$90:976C D0 F3       BNE $F3    [$9761]     ;/

$90:976E 4C 08 98    JMP $9808  [$90:9808]  ; Go to BRANCH_NOT_RUNNING

; BRANCH_GRAVITY_CONTINUED
$90:9771 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:9774 29 FF 00    AND #$00FF             ;|
$90:9777 C9 01 00    CMP #$0001             ;} If [Samus movement type] != running:
$90:977A F0 03       BEQ $03    [$977F]     ;/
$90:977C 4C 08 98    JMP $9808  [$90:9808]  ; Go to BRANCH_NOT_RUNNING

$90:977F A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9781 2D B6 09    AND $09B6  [$7E:09B6]  ;} If not pressing run:
$90:9784 D0 03       BNE $03    [$9789]     ;/
$90:9786 4C 08 98    JMP $9808  [$90:9808]  ; Go to BRANCH_NOT_RUNNING

$90:9789 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:978C 89 00 20    BIT #$2000             ;} If speed booster not equipped: go to BRANCH_NO_SPEED_BOOSTER
$90:978F F0 36       BEQ $36    [$97C7]     ;/
$90:9791 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$90:9794 D0 13       BNE $13    [$97A9]     ;} If [Samus running momentum flag] = 0:
$90:9796 A9 01 00    LDA #$0001             ;\
$90:9799 8D 3C 0B    STA $0B3C  [$7E:0B3C]  ;} Samus running momentum flag = 1
$90:979C 8D D0 0A    STA $0AD0  [$7E:0AD0]  ; $0AD0 = 1
$90:979F 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$90:97A2 AF 1F B6 91 LDA $91B61F[$91:B61F]  ;\
$90:97A6 8D 3E 0B    STA $0B3E  [$7E:0B3E]  ;} Speed boost timer = 1, speed boost counter = 0

$90:97A9 AD 42 0B    LDA $0B42  [$7E:0B42]  ;\
$90:97AC DD 0D 9F    CMP $9F0D,x[$90:9F0D]  ;|
$90:97AF 30 42       BMI $42    [$97F3]     ;|
$90:97B1 AD 44 0B    LDA $0B44  [$7E:0B44]  ;} If [Samus X extra run speed] < 7.0: go to BRANCH_ACCELERATING
$90:97B4 DD 13 9F    CMP $9F13,x[$90:9F13]  ;|
$90:97B7 30 3A       BMI $3A    [$97F3]     ;/
$90:97B9 BD 0D 9F    LDA $9F0D,x[$90:9F0D]  ;\
$90:97BC 8D 42 0B    STA $0B42  [$7E:0B42]  ;|
$90:97BF BD 13 9F    LDA $9F13,x[$90:9F13]  ;} Samus X extra run speed = 7.0
$90:97C2 8D 44 0B    STA $0B44  [$7E:0B44]  ;/
$90:97C5 80 4C       BRA $4C    [$9813]     ; Go to BRANCH_DONE

; BRANCH_NO_SPEED_BOOSTER
$90:97C7 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$90:97CA D0 09       BNE $09    [$97D5]     ;} If [Samus running momentum flag] = 0:
$90:97CC A9 01 00    LDA #$0001             ;\
$90:97CF 8D 3C 0B    STA $0B3C  [$7E:0B3C]  ;} Samus running momentum flag = 1
$90:97D2 9C 3E 0B    STZ $0B3E  [$7E:0B3E]  ; Speed boost timer = 0, speed boost counter = 0

$90:97D5 AD 42 0B    LDA $0B42  [$7E:0B42]  ;\
$90:97D8 DD 19 9F    CMP $9F19,x[$90:9F19]  ;|
$90:97DB 30 16       BMI $16    [$97F3]     ;|
$90:97DD AD 44 0B    LDA $0B44  [$7E:0B44]  ;} If [Samus X extra run speed] < 2.0: go to BRANCH_ACCELERATING
$90:97E0 DD 1F 9F    CMP $9F1F,x[$90:9F1F]  ;|
$90:97E3 30 0E       BMI $0E    [$97F3]     ;/
$90:97E5 BD 19 9F    LDA $9F19,x[$90:9F19]  ;\
$90:97E8 8D 42 0B    STA $0B42  [$7E:0B42]  ;|
$90:97EB BD 1F 9F    LDA $9F1F,x[$90:9F1F]  ;} Samus X extra run speed = 2.0
$90:97EE 8D 44 0B    STA $0B44  [$7E:0B44]  ;/
$90:97F1 80 20       BRA $20    [$9813]     ; Go to BRANCH_DONE

; BRANCH_ACCELERATING
$90:97F3 AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$90:97F6 18          CLC                    ;|
$90:97F7 7D 07 9F    ADC $9F07,x[$90:9F07]  ;|
$90:97FA 8D 44 0B    STA $0B44  [$7E:0B44]  ;} Samus X extra run speed += 0.1000h
$90:97FD AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$90:9800 7D 01 9F    ADC $9F01,x[$90:9F01]  ;|
$90:9803 8D 42 0B    STA $0B42  [$7E:0B42]  ;/
$90:9806 80 0B       BRA $0B    [$9813]     ; Go to BRANCH_DONE

; BRANCH_NOT_RUNNING
$90:9808 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$90:980B D0 06       BNE $06    [$9813]     ;} If [Samus running momentum flag] = 0:
$90:980D 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:9810 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0

; BRANCH_DONE
$90:9813 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:9816 29 00 FF    AND #$FF00             ;|
$90:9819 C9 00 04    CMP #$0400             ;} If [speed boost counter] = 4:
$90:981C D0 06       BNE $06    [$9824]     ;/
$90:981E A9 01 00    LDA #$0001             ;\
$90:9821 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = speed boosting

$90:9824 28          PLP
$90:9825 60          RTS
}


;;; $9826: Move Samus right by [$12].[$14], no collision detection ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
$90:9826 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$90:9829 18          CLC                    ;|
$90:982A 65 14       ADC $14    [$7E:0014]  ;|
$90:982C 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X position += [$12].[$14]
$90:982F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$90:9832 65 12       ADC $12    [$7E:0012]  ;|
$90:9834 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$90:9837 A5 14       LDA $14    [$7E:0014]  ;\
$90:9839 8D B0 0D    STA $0DB0  [$7E:0DB0]  ;|
$90:983C A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved right = [$12].[$14]
$90:983E 8D AE 0D    STA $0DAE  [$7E:0DAE]  ;/
$90:9841 60          RTS
}


;;; $9842: Move Samus left by [$12].[$14], no collision detection ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
$90:9842 AD F8 0A    LDA $0AF8  [$7E:0AF8]  ;\
$90:9845 38          SEC                    ;|
$90:9846 E5 14       SBC $14    [$7E:0014]  ;|
$90:9848 8D F8 0A    STA $0AF8  [$7E:0AF8]  ;} Samus X position -= [$12].[$14]
$90:984B AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$90:984E E5 12       SBC $12    [$7E:0012]  ;|
$90:9850 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$90:9853 A5 12       LDA $12    [$7E:0012]  ;\
$90:9855 49 FF FF    EOR #$FFFF             ;|
$90:9858 85 12       STA $12    [$7E:0012]  ;|
$90:985A A5 14       LDA $14    [$7E:0014]  ;|
$90:985C 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:985F 1A          INC A                  ;|
$90:9860 85 14       STA $14    [$7E:0014]  ;|
$90:9862 D0 02       BNE $02    [$9866]     ;|
$90:9864 E6 12       INC $12    [$7E:0012]  ;/

$90:9866 A5 14       LDA $14    [$7E:0014]  ;\
$90:9868 8D AC 0D    STA $0DAC  [$7E:0DAC]  ;|
$90:986B A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved left = [$12].[$14]
$90:986D 8D AA 0D    STA $0DAA  [$7E:0DAA]  ;/
$90:9870 60          RTS
}


;;; $9871: Move Samus down by [$12].[$14], no collision detection ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
$90:9871 AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$90:9874 18          CLC                    ;|
$90:9875 65 14       ADC $14    [$7E:0014]  ;|
$90:9877 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position += [$12].[$14]
$90:987A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$90:987D 65 12       ADC $12    [$7E:0012]  ;|
$90:987F 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:9882 A5 14       LDA $14    [$7E:0014]  ;\
$90:9884 8D B8 0D    STA $0DB8  [$7E:0DB8]  ;|
$90:9887 A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved down = [$12].[$14]
$90:9889 8D B6 0D    STA $0DB6  [$7E:0DB6]  ;/
$90:988C 60          RTS
}


;;; $988D: Move Samus up by [$12].[$14], no collision detection ;;;
{
;; Parameters:
;;     $12.$14: Distance to move Samus
$90:988D AD FC 0A    LDA $0AFC  [$7E:0AFC]  ;\
$90:9890 38          SEC                    ;|
$90:9891 E5 14       SBC $14    [$7E:0014]  ;|
$90:9893 8D FC 0A    STA $0AFC  [$7E:0AFC]  ;} Samus Y position -= [$12].[$14]
$90:9896 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$90:9899 E5 12       SBC $12    [$7E:0012]  ;|
$90:989B 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:989E A5 12       LDA $12    [$7E:0012]  ;\
$90:98A0 49 FF FF    EOR #$FFFF             ;|
$90:98A3 85 12       STA $12    [$7E:0012]  ;|
$90:98A5 A5 14       LDA $14    [$7E:0014]  ;|
$90:98A7 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:98AA 1A          INC A                  ;|
$90:98AB 85 14       STA $14    [$7E:0014]  ;|
$90:98AD D0 02       BNE $02    [$98B1]     ;|
$90:98AF E6 12       INC $12    [$7E:0012]  ;/

$90:98B1 A5 14       LDA $14    [$7E:0014]  ;\
$90:98B3 8D B4 0D    STA $0DB4  [$7E:0DB4]  ;|
$90:98B6 A5 12       LDA $12    [$7E:0012]  ;} Distance Samus moved up = [$12].[$14]
$90:98B8 8D B2 0D    STA $0DB2  [$7E:0DB2]  ;/
$90:98BB 60          RTS
}


;;; $98BC: Make Samus jump ;;;
{
$90:98BC 08          PHP
$90:98BD 8B          PHB
$90:98BE 4B          PHK                    ;\
$90:98BF AB          PLB                    ;} DB = $90
$90:98C0 C2 30       REP #$30
$90:98C2 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:98C5 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NORMAL_GRAVITY
$90:98C8 D0 18       BNE $18    [$98E2]     ;/
$90:98CA 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:98CE AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:98D1 30 06       BMI $06    [$98D9]     ;} If [FX Y position] >= 0:
$90:98D3 C5 12       CMP $12    [$7E:0012]  ;\
$90:98D5 30 10       BMI $10    [$98E7]     ;} If [FX Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_WATER
$90:98D7 80 09       BRA $09    [$98E2]

$90:98D9 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:98DC 30 04       BMI $04    [$98E2]     ;} If [lava/acid Y position] >= 0:
$90:98DE C5 12       CMP $12    [$7E:0012]  ;\
$90:98E0 30 12       BMI $12    [$98F4]     ;} If [lava/acid Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_ACID_LAVA

; BRANCH_NORMAL_GRAVITY
$90:98E2 A2 00 00    LDX #$0000             ; X = 0
$90:98E5 80 10       BRA $10    [$98F7]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_WATER
$90:98E7 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:98EA 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NORMAL_GRAVITY
$90:98ED D0 F3       BNE $F3    [$98E2]     ;/
$90:98EF A2 02 00    LDX #$0002             ; X = 2
$90:98F2 80 03       BRA $03    [$98F7]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_ACID_LAVA
$90:98F4 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$90:98F7 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:98FA 89 00 01    BIT #$0100             ;} If hi-jump not equipped:
$90:98FD D0 0E       BNE $0E    [$990D]     ;/
$90:98FF BD BF 9E    LDA $9EBF,x[$90:9EBF]  ;\
$90:9902 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:9905 BD B9 9E    LDA $9EB9,x[$90:9EB9]  ;} Samus Y speed = [$9EB9 + [X]].[$9EBF + [X]] (initial jumping speed)
$90:9908 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$90:990B 80 0C       BRA $0C    [$9919]

$90:990D BD CB 9E    LDA $9ECB,x[$90:9ECB]  ;\ Else (hi-jump equipped):
$90:9910 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:9913 BD C5 9E    LDA $9EC5,x[$90:9EC5]  ;} Samus Y speed = [$9EC5 + [X]].[$9ECB + [X]] (initial hi-jumping speed)
$90:9916 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:9919 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:991C 89 00 20    BIT #$2000             ;} If speed booster equipped:
$90:991F F0 19       BEQ $19    [$993A]     ;/
$90:9921 AD 42 0B    LDA $0B42  [$7E:0B42]  ;\
$90:9924 4A          LSR A                  ;} $12 = [Samus X extra run speed] / 2
$90:9925 85 12       STA $12    [$7E:0012]  ;/
$90:9927 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:992A 18          CLC                    ;|
$90:992B 6D 44 0B    ADC $0B44  [$7E:0B44]  ;} Samus Y subspeed += [Samus X extra run subspeed]
$90:992E 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;/
$90:9931 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:9934 18          CLC                    ;|
$90:9935 65 12       ADC $12    [$7E:0012]  ;} Samus Y speed += [$12] (no carry from subspeed addition)
$90:9937 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:993A 9C 9E 0A    STZ $0A9E  [$7E:0A9E]  ; Grapple walljump timer = 0
$90:993D 9C A0 0A    STZ $0AA0  [$7E:0AA0]  ; Reached Ceres elevator fade timer = 0 (okay?)
$90:9940 A9 01 00    LDA #$0001             ;\
$90:9943 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$90:9946 AB          PLB
$90:9947 28          PLP
$90:9948 6B          RTL
}


;;; $9949: Make Samus wall-jump ;;;
{
$90:9949 08          PHP
$90:994A 8B          PHB
$90:994B 4B          PHK                    ;\
$90:994C AB          PLB                    ;} DB = $90
$90:994D C2 30       REP #$30
$90:994F AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9952 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NORMAL_GRAVITY
$90:9955 D0 18       BNE $18    [$996F]     ;/
$90:9957 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:995B AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:995E 30 06       BMI $06    [$9966]     ;} If [FX Y position] >= 0:
$90:9960 C5 12       CMP $12    [$7E:0012]  ;\
$90:9962 30 10       BMI $10    [$9974]     ;} If [FX Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_WATER
$90:9964 80 09       BRA $09    [$996F]

$90:9966 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:9969 30 04       BMI $04    [$996F]     ;} If [lava/acid Y position] >= 0:
$90:996B C5 12       CMP $12    [$7E:0012]  ;\
$90:996D 30 12       BMI $12    [$9981]     ;} If [lava/acid Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_ACID_LAVA

; BRANCH_NORMAL_GRAVITY
$90:996F A2 00 00    LDX #$0000             ; X = 0
$90:9972 80 10       BRA $10    [$9984]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_WATER
$90:9974 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9977 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NORMAL_GRAVITY
$90:997A D0 F3       BNE $F3    [$996F]     ;/
$90:997C A2 02 00    LDX #$0002             ; X = 2
$90:997F 80 03       BRA $03    [$9984]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_ACID_LAVA
$90:9981 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$90:9984 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9987 89 00 01    BIT #$0100             ;} If hi-jump not equipped:
$90:998A D0 0E       BNE $0E    [$999A]     ;/
$90:998C BD D7 9E    LDA $9ED7,x[$90:9ED7]  ;\
$90:998F 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:9992 BD D1 9E    LDA $9ED1,x[$90:9ED1]  ;} Samus Y speed = [$9ED1 + [X]].[$9ED7 + [X]] (initial wall-jumping)
$90:9995 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$90:9998 80 0C       BRA $0C    [$99A6]

$90:999A BD E3 9E    LDA $9EE3,x[$90:9EE3]  ;\ Else (hi-jump equipped):
$90:999D 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:99A0 BD DD 9E    LDA $9EDD,x[$90:9EDD]  ;} Samus Y speed = [$9EDD + [X]].[$9EE3 + [X]] (initial wall-hi-jumping)
$90:99A3 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:99A6 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:99A9 89 00 20    BIT #$2000             ;} If speed booster equipped:
$90:99AC F0 19       BEQ $19    [$99C7]     ;/
$90:99AE AD 42 0B    LDA $0B42  [$7E:0B42]  ;\
$90:99B1 4A          LSR A                  ;} $12 = [Samus X extra run speed] / 2
$90:99B2 85 12       STA $12    [$7E:0012]  ;/
$90:99B4 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:99B7 18          CLC                    ;|
$90:99B8 6D 44 0B    ADC $0B44  [$7E:0B44]  ;} Samus Y subspeed += [Samus X subspeed]
$90:99BB 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;/
$90:99BE AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:99C1 18          CLC                    ;|
$90:99C2 65 12       ADC $12    [$7E:0012]  ;} Samus Y speed += [$12] (no carry from subspeed addition)
$90:99C4 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:99C7 9C 9E 0A    STZ $0A9E  [$7E:0A9E]  ; Grapple walljump timer = 0
$90:99CA 9C A0 0A    STZ $0AA0  [$7E:0AA0]  ; Reached Ceres elevator fade timer = 0 (okay?)
$90:99CD A9 01 00    LDA #$0001             ;\
$90:99D0 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$90:99D3 AB          PLB
$90:99D4 28          PLP
$90:99D5 6B          RTL
}


;;; $99D6: Set Samus Y speed for knockback ;;;
{
$90:99D6 08          PHP
$90:99D7 8B          PHB
$90:99D8 4B          PHK                    ;\
$90:99D9 AB          PLB                    ;} DB = $90
$90:99DA C2 30       REP #$30
$90:99DC AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:99DF 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_IN_AIR
$90:99E2 D0 18       BNE $18    [$99FC]     ;/
$90:99E4 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:99E8 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:99EB 30 06       BMI $06    [$99F3]     ;} If [FX Y position] >= 0:
$90:99ED C5 12       CMP $12    [$7E:0012]  ;\
$90:99EF 30 10       BMI $10    [$9A01]     ;} If [FX Y position] < Samus bottom boundary: go to BRANCH_IN_WATER
$90:99F1 80 09       BRA $09    [$99FC]     ; Go to BRANCH_IN_AIR

$90:99F3 AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:99F6 30 04       BMI $04    [$99FC]     ;} If [lava/acid Y position] >= 0:
$90:99F8 C5 12       CMP $12    [$7E:0012]  ;\
$90:99FA 30 12       BMI $12    [$9A0E]     ;} If [lava/acid Y position] < Samus bottom boundary: go to BRANCH_IN_ACID_LAVA

; BRANCH_IN_AIR
$90:99FC A2 00 00    LDX #$0000             ; X = 0
$90:99FF 80 10       BRA $10    [$9A11]     ; Go to BRANCH_MERGE

; BRANCH_IN_WATER
$90:9A01 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9A04 89 04 00    BIT #$0004             ;} If water physics disabled: go to BRANCH_IN_AIR
$90:9A07 D0 F3       BNE $F3    [$99FC]     ;/
$90:9A09 A2 02 00    LDX #$0002             ; X = 2
$90:9A0C 80 03       BRA $03    [$9A11]     ; Go to BRANCH_MERGE

; BRANCH_IN_ACID_LAVA
$90:9A0E A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$90:9A11 BD EF 9E    LDA $9EEF,x[$90:9EEF]  ;\
$90:9A14 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:9A17 BD E9 9E    LDA $9EE9,x[$90:9EE9]  ;} Samus Y speed = [$9EE9 + [X]].[$9EEF + [X]] (initial knockback speed)
$90:9A1A 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$90:9A1D 9C 9E 0A    STZ $0A9E  [$7E:0A9E]  ; Grapple walljump timer = 0
$90:9A20 9C A0 0A    STZ $0AA0  [$7E:0AA0]  ; Reached Ceres elevator fade timer = 0 (okay?)
$90:9A23 A9 01 00    LDA #$0001             ;\
$90:9A26 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$90:9A29 AB          PLB
$90:9A2A 28          PLP
$90:9A2B 6B          RTL
}


;;; $9A2C: Make Samus bomb jump ;;;
{
$90:9A2C 08          PHP
$90:9A2D C2 30       REP #$30
$90:9A2F AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9A32 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NORMAL_GRAVITY
$90:9A35 D0 18       BNE $18    [$9A4F]     ;/
$90:9A37 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:9A3B AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:9A3E 30 06       BMI $06    [$9A46]     ;} If [FX Y position] >= 0:
$90:9A40 C5 12       CMP $12    [$7E:0012]  ;\
$90:9A42 30 10       BMI $10    [$9A54]     ;} If [FX Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_WATER
$90:9A44 80 09       BRA $09    [$9A4F]

$90:9A46 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:9A49 30 04       BMI $04    [$9A4F]     ;} If [lava/acid Y position] >= 0:
$90:9A4B C5 12       CMP $12    [$7E:0012]  ;\
$90:9A4D 30 12       BMI $12    [$9A61]     ;} If [lava/acid Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_ACID_LAVA

; BRANCH_NORMAL_GRAVITY
$90:9A4F A2 00 00    LDX #$0000             ; X = 0
$90:9A52 80 10       BRA $10    [$9A64]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_WATER
$90:9A54 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9A57 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NORMAL_GRAVITY
$90:9A5A D0 F3       BNE $F3    [$9A4F]     ;/
$90:9A5C A2 02 00    LDX #$0002             ; X = 2
$90:9A5F 80 03       BRA $03    [$9A64]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_ACID_LAVA
$90:9A61 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$90:9A64 BD FB 9E    LDA $9EFB,x[$90:9EFB]  ;\
$90:9A67 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:9A6A BD F5 9E    LDA $9EF5,x[$90:9EF5]  ;} Samus Y speed = [$9EF5 + [X]].[$9EFB + [X]] (initial bomb jump)
$90:9A6D 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$90:9A70 9C 9E 0A    STZ $0A9E  [$7E:0A9E]  ; Grapple walljump timer = 0
$90:9A73 9C A0 0A    STZ $0AA0  [$7E:0AA0]  ; Reached Ceres elevator fade timer = 0 (okay?)
$90:9A76 A9 01 00    LDA #$0001             ;\
$90:9A79 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$90:9A7C 28          PLP
$90:9A7D 60          RTS
}


;;; $9A7E: Calculate Samus X base speed - deceleration allowed ;;;
{
;; Parameters:
;;     X: Samus X speed table entry pointer
;;         [[X] + 0].[[X] + 2]: X acceleration
;;         [[X] + 4].[[X] + 6]: Max X speed
;;         [[X] + 8].[[X] + Ah]: X deceleration
;; Returns:
;;     $12.$14: Samus X base speed

$90:9A7E 08          PHP
$90:9A7F C2 30       REP #$30
$90:9A81 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:9A84 D0 34       BNE $34    [$9ABA]     ;} If [Samus X acceleration mode] != accelerating: go to BRANCH_DECELERATING
$90:9A86 AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$90:9A89 18          CLC                    ;|
$90:9A8A 7D 02 00    ADC $0002,x[$90:9FCF]  ;|
$90:9A8D 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [[X]].[[X] + 2]
$90:9A90 AD 46 0B    LDA $0B46  [$7E:0B46]  ;|
$90:9A93 7D 00 00    ADC $0000,x[$90:9FCD]  ;|
$90:9A96 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$90:9A99 DD 04 00    CMP $0004,x[$90:9FD1]  ;\
$90:9A9C 30 75       BMI $75    [$9B13]     ;} If [Samus X base speed] < [[X] + 4]: go to BRANCH_RETURN
$90:9A9E F0 0E       BEQ $0E    [$9AAE]     ; If [Samus X base speed] = [[X] + 4]: go to BRANCH_CHECK_MAX_SUBSPEED

; BRANCH_CAP_X_SPEED
$90:9AA0 BD 04 00    LDA $0004,x[$90:9FD1]  ;\
$90:9AA3 8D 46 0B    STA $0B46  [$7E:0B46]  ;|
$90:9AA6 BD 06 00    LDA $0006,x[$90:9FD3]  ;} Samus X base speed = [[X] + 4].[[X] + 6]
$90:9AA9 8D 48 0B    STA $0B48  [$7E:0B48]  ;/
$90:9AAC 80 65       BRA $65    [$9B13]     ; Go to BRANCH_RETURN

; BRANCH_CHECK_MAX_SUBSPEED
$90:9AAE AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$90:9AB1 DD 06 00    CMP $0006,x[$90:9F67]  ;|
$90:9AB4 30 5D       BMI $5D    [$9B13]     ;} If [Samus X base subspeed] <= [[X] + 6]: go to BRANCH_RETURN
$90:9AB6 F0 5B       BEQ $5B    [$9B13]     ;/
$90:9AB8 80 E6       BRA $E6    [$9AA0]     ; Go to BRANCH_CAP_X_SPEED

; BRANCH_DECELERATING
$90:9ABA E2 20       SEP #$20
$90:9ABC AD 4C 0B    LDA $0B4C  [$7E:0B4C]  ;\
$90:9ABF F0 2A       BEQ $2A    [$9AEB]     ;} If [Samus X deceleration multiplier] != 0:
$90:9AC1 8D 02 42    STA $4202              ;\
$90:9AC4 BD 0B 00    LDA $000B,x            ;|
$90:9AC7 8D 03 42    STA $4203              ;|
$90:9ACA EA          NOP                    ;|
$90:9ACB EA          NOP                    ;|
$90:9ACC EA          NOP                    ;|
$90:9ACD C2 20       REP #$20               ;|
$90:9ACF AD 16 42    LDA $4216              ;|
$90:9AD2 85 14       STA $14    [$7E:0014]  ;|
$90:9AD4 E2 20       SEP #$20               ;} $12.$14 = [[X] + 8].[[X] + Ah] * [Samus X deceleration multiplier] / 100h
$90:9AD6 BD 08 00    LDA $0008,x            ;|
$90:9AD9 8D 03 42    STA $4203              ;|
$90:9ADC EA          NOP                    ;|
$90:9ADD EA          NOP                    ;|
$90:9ADE EA          NOP                    ;|
$90:9ADF C2 20       REP #$20               ;|
$90:9AE1 AD 17 42    LDA $4217              ;|
$90:9AE4 29 FF 00    AND #$00FF             ;|
$90:9AE7 85 12       STA $12    [$7E:0012]  ;/
$90:9AE9 80 0C       BRA $0C    [$9AF7]

$90:9AEB C2 20       REP #$20               ; Else ([Samus X deceleration multiplier] = 0):
$90:9AED BD 0A 00    LDA $000A,x[$90:9F6B]  ;\
$90:9AF0 85 14       STA $14    [$7E:0014]  ;|
$90:9AF2 BD 08 00    LDA $0008,x[$90:9F69]  ;} $12.$14 = [[X] + 8].[[X] + Ah]
$90:9AF5 85 12       STA $12    [$7E:0012]  ;/

$90:9AF7 AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$90:9AFA 38          SEC                    ;|
$90:9AFB E5 14       SBC $14    [$7E:0014]  ;|
$90:9AFD 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed -= [$12].[$14]
$90:9B00 AD 46 0B    LDA $0B46  [$7E:0B46]  ;|
$90:9B03 E5 12       SBC $12    [$7E:0012]  ;|
$90:9B05 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$90:9B08 10 09       BPL $09    [$9B13]     ; If [Samus X base speed] < 0:
$90:9B0A 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:9B0D 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:9B10 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating

; BRANCH_RETURN
$90:9B13 AD 46 0B    LDA $0B46  [$7E:0B46]  ;\
$90:9B16 85 12       STA $12    [$7E:0012]  ;|
$90:9B18 AD 48 0B    LDA $0B48  [$7E:0B48]  ;} $12.$14 = [Samus X base speed]
$90:9B1B 85 14       STA $14    [$7E:0014]  ;/
$90:9B1D 28          PLP
$90:9B1E 60          RTS
}


;;; $9B1F: Calculate Samus X base speed - deceleration disallowed ;;;
{
;; Parameters:
;;     X: Samus X speed table entry pointer
;;         [[X] + 0].[[X] + 2]: X acceleration
;;         [[X] + 4].[[X] + 6]: Max X speed
;;         [[X] + 8].[[X] + Ah]: X deceleration
;; Returns:
;;     Carry: Set if reached max X speed, otherwise clear
;;     $12.$14: Samus X base speed

$90:9B1F 08          PHP
$90:9B20 C2 30       REP #$30
$90:9B22 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:9B25 89 01 00    BIT #$0001             ;} If [Samus X acceleration mode] = turning around: go to BRANCH_TURNING_AROUND
$90:9B28 D0 34       BNE $34    [$9B5E]     ;/
$90:9B2A AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$90:9B2D 18          CLC                    ;|
$90:9B2E 7D 02 00    ADC $0002,x[$90:9F9F]  ;|
$90:9B31 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [[X]].[[X] + 2]
$90:9B34 AD 46 0B    LDA $0B46  [$7E:0B46]  ;|
$90:9B37 7D 00 00    ADC $0000,x[$90:9F9D]  ;|
$90:9B3A 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$90:9B3D DD 04 00    CMP $0004,x[$90:9FA1]  ;\
$90:9B40 30 75       BMI $75    [$9BB7]     ;} If [Samus X base speed] < [[X] + 4]: go to BRANCH_RETURN_CLEAR
$90:9B42 F0 0E       BEQ $0E    [$9B52]     ; If [Samus X base speed] = [[X] + 4]: go to BRANCH_CHECK_MAX_SUBSPEED

; BRANCH_CAP_X_SPEED
$90:9B44 BD 04 00    LDA $0004,x[$90:9FA1]  ;\
$90:9B47 8D 46 0B    STA $0B46  [$7E:0B46]  ;|
$90:9B4A BD 06 00    LDA $0006,x[$90:9FA3]  ;} Samus X base speed = [[X] + 4].[[X] + 6]
$90:9B4D 8D 48 0B    STA $0B48  [$7E:0B48]  ;/
$90:9B50 80 72       BRA $72    [$9BC4]     ; Go to BRANCH_RETURN_SET

; BRANCH_CHECK_MAX_SUBSPEED
$90:9B52 AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$90:9B55 DD 06 00    CMP $0006,x[$90:9FA3]  ;|
$90:9B58 30 5D       BMI $5D    [$9BB7]     ;} If [Samus X base subspeed] <= [[X] + 6]: go to BRANCH_RETURN_CLEAR
$90:9B5A F0 5B       BEQ $5B    [$9BB7]     ;/
$90:9B5C 80 E6       BRA $E6    [$9B44]     ; Go to BRANCH_CAP_X_SPEED

; BRANCH_TURNING_AROUND
$90:9B5E E2 20       SEP #$20
$90:9B60 AD 4C 0B    LDA $0B4C  [$7E:0B4C]  ;\
$90:9B63 F0 2A       BEQ $2A    [$9B8F]     ;} If [Samus X deceleration multiplier] != 0:
$90:9B65 8D 02 42    STA $4202              ;\
$90:9B68 BD 0B 00    LDA $000B,x            ;|
$90:9B6B 8D 03 42    STA $4203              ;|
$90:9B6E EA          NOP                    ;|
$90:9B6F EA          NOP                    ;|
$90:9B70 EA          NOP                    ;|
$90:9B71 C2 20       REP #$20               ;|
$90:9B73 AD 16 42    LDA $4216              ;|
$90:9B76 85 14       STA $14    [$7E:0014]  ;|
$90:9B78 E2 20       SEP #$20               ;} $12.$14 = [[X] + 8].[[X] + Ah] * [Samus X deceleration multiplier] / 100h
$90:9B7A BD 08 00    LDA $0008,x            ;|
$90:9B7D 8D 03 42    STA $4203              ;|
$90:9B80 EA          NOP                    ;|
$90:9B81 EA          NOP                    ;|
$90:9B82 EA          NOP                    ;|
$90:9B83 C2 20       REP #$20               ;|
$90:9B85 AD 17 42    LDA $4217              ;|
$90:9B88 29 FF 00    AND #$00FF             ;|
$90:9B8B 85 12       STA $12    [$7E:0012]  ;/
$90:9B8D 80 0C       BRA $0C    [$9B9B]

$90:9B8F C2 20       REP #$20               ; Else ([Samus X deceleration multiplier] = 0):
$90:9B91 BD 0A 00    LDA $000A,x[$90:9F83]  ;\
$90:9B94 85 14       STA $14    [$7E:0014]  ;|
$90:9B96 BD 08 00    LDA $0008,x[$90:9F81]  ;} $12.$14 = [[X] + 8].[[X] + Ah]
$90:9B99 85 12       STA $12    [$7E:0012]  ;/

$90:9B9B AD 48 0B    LDA $0B48  [$7E:0B48]  ;\
$90:9B9E 38          SEC                    ;|
$90:9B9F E5 14       SBC $14    [$7E:0014]  ;|
$90:9BA1 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed -= [$12].[$14]
$90:9BA4 AD 46 0B    LDA $0B46  [$7E:0B46]  ;|
$90:9BA7 E5 12       SBC $12    [$7E:0012]  ;|
$90:9BA9 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$90:9BAC 10 09       BPL $09    [$9BB7]     ; If [Samus X base speed] < 0:
$90:9BAE 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:9BB1 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:9BB4 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating

; BRANCH_RETURN_CLEAR
$90:9BB7 AD 46 0B    LDA $0B46  [$7E:0B46]  ;\
$90:9BBA 85 12       STA $12    [$7E:0012]  ;|
$90:9BBC AD 48 0B    LDA $0B48  [$7E:0B48]  ;} $12.$14 = [Samus X base speed]
$90:9BBF 85 14       STA $14    [$7E:0014]  ;/
$90:9BC1 28          PLP
$90:9BC2 18          CLC                    ;\
$90:9BC3 60          RTS                    ;} Return carry clear

; BRANCH_RETURN_SET
$90:9BC4 AD 46 0B    LDA $0B46  [$7E:0B46]  ;\
$90:9BC7 85 12       STA $12    [$7E:0012]  ;|
$90:9BC9 AD 48 0B    LDA $0B48  [$7E:0B48]  ;} $12.$14 = [Samus X base speed]
$90:9BCC 85 14       STA $14    [$7E:0014]  ;/
$90:9BCE 28          PLP
$90:9BCF 38          SEC                    ;\
$90:9BD0 60          RTS                    ;} Return carry set
}


;;; $9BD1: Determine Samus X speed table entry pointer ;;;
{
;; Returns:
;;     X: Samus X speed table entry pointer
$90:9BD1 08          PHP
$90:9BD2 C2 30       REP #$30
$90:9BD4 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9BD7 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_SPEED_TABLE_SET
$90:9BDA D0 18       BNE $18    [$9BF4]     ;/
$90:9BDC 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:9BE0 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:9BE3 30 06       BMI $06    [$9BEB]     ;} If [FX Y position] >= 0:
$90:9BE5 C5 12       CMP $12    [$7E:0012]  ;\
$90:9BE7 30 0D       BMI $0D    [$9BF6]     ;} If [FX Y position] < (Samus bottom boundary): go to BRANCH_WATER
$90:9BE9 80 09       BRA $09    [$9BF4]

$90:9BEB AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:9BEE 30 04       BMI $04    [$9BF4]     ;} If [lava/acid Y position] >= 0:
$90:9BF0 C5 12       CMP $12    [$7E:0012]  ;\
$90:9BF2 30 12       BMI $12    [$9C06]     ;} If [lava/acid Y position] < (Samus bottom boundary): go to BRANCH_LAVA

$90:9BF4 80 16       BRA $16    [$9C0C]     ; Go to BRANCH_SPEED_TABLE_SET

; BRANCH_SUBMERGED_IN_WATER
$90:9BF6 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9BF9 89 04 00    BIT #$0004             ;} If water physics are disabled: go to BRANCH_SPEED_TABLE_SET
$90:9BFC D0 F6       BNE $F6    [$9BF4]     ;/
$90:9BFE A9 8D A0    LDA #$A08D             ;\
$90:9C01 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $A08D
$90:9C04 80 06       BRA $06    [$9C0C]     ; Go to BRANCH_SPEED_TABLE_SET

; BRANCH_SUBMERGED_IN_ACID_LAVA
$90:9C06 A9 DD A1    LDA #$A1DD             ;\
$90:9C09 8D 6C 0A    STA $0A6C  [$7E:0A6C]  ;} Samus X speed table pointer = $A1DD

; BRANCH_SPEED_TABLE_SET
$90:9C0C AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:9C0F 29 FF 00    AND #$00FF             ;|
$90:9C12 85 14       STA $14    [$7E:0014]  ;|
$90:9C14 0A          ASL A                  ;|
$90:9C15 18          CLC                    ;|
$90:9C16 65 14       ADC $14    [$7E:0014]  ;} X = [Samus X speed table pointer] + [Samus movement type] * Ch
$90:9C18 0A          ASL A                  ;|
$90:9C19 0A          ASL A                  ;|
$90:9C1A 18          CLC                    ;|
$90:9C1B 6D 6C 0A    ADC $0A6C  [$7E:0A6C]  ;|
$90:9C1E AA          TAX                    ;/
$90:9C1F 28          PLP
$90:9C20 60          RTS
}


;;; $9C21: Determine grapple swing Samus X speed table entry pointer ;;;
{
;; Returns:
;;     X: Samus X speed table entry pointer
$90:9C21 08          PHP
$90:9C22 C2 30       REP #$30
$90:9C24 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9C27 89 20 00    BIT #$0020             ;} If gravity equipped: go to BRANCH_NORMAL_GRAVITY
$90:9C2A D0 18       BNE $18    [$9C44]     ;/
$90:9C2C 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:9C30 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:9C33 30 06       BMI $06    [$9C3B]     ;} If [FX Y position] >= 0:
$90:9C35 C5 12       CMP $12    [$7E:0012]  ;\
$90:9C37 30 10       BMI $10    [$9C49]     ;} If [FX Y position] < (Samus bottom boundary): go to BRANCH_SUBMERGED_IN_WATER
$90:9C39 80 09       BRA $09    [$9C44]

$90:9C3B AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:9C3E 30 04       BMI $04    [$9C44]     ;} If [lava/acid Y position] >= 0:
$90:9C40 C5 12       CMP $12    [$7E:0012]  ;\
$90:9C42 30 12       BMI $12    [$9C56]     ;} If [lava/acid Y position] < (Samus bottom boundary): go to BRANCH_SUBMERGED_IN_ACID_LAVA

; BRANCH_NORMAL_GRAVITY
$90:9C44 A2 31 9F    LDX #$9F31             ; X = $9F31
$90:9C47 80 10       BRA $10    [$9C59]     ; Return

; BRANCH_SUBMERGED_IN_WATER
$90:9C49 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9C4C 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NORMAL_GRAVITY
$90:9C4F D0 F3       BNE $F3    [$9C44]     ;/
$90:9C51 A2 3D 9F    LDX #$9F3D             ; X = $9F3D
$90:9C54 80 03       BRA $03    [$9C59]     ; Return

; BRANCH_SUBMERGED_IN_ACID_LAVA
$90:9C56 A2 49 9F    LDX #$9F49             ; X = $9F49

$90:9C59 28          PLP
$90:9C5A 60          RTS
}


;;; $9C5B: Determine Samus Y acceleration ;;;
{
$90:9C5B AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:9C5E 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NOT_SUBMERGED
$90:9C61 D0 18       BNE $18    [$9C7B]     ;/
$90:9C63 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:9C67 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:9C6A 30 06       BMI $06    [$9C72]     ;} If [FX Y position] >= 0:
$90:9C6C C5 12       CMP $12    [$7E:0012]  ;\
$90:9C6E 30 19       BMI $19    [$9C89]     ;} If [FX Y position] < [$12]: go to BRANCH_SUBMERGED_WATER
$90:9C70 80 09       BRA $09    [$9C7B]     ; Go to BRANCH_NOT_SUBMERGED

$90:9C72 AD 62 19    LDA $1962  [$7E:1962]  ;\
$90:9C75 30 04       BMI $04    [$9C7B]     ;} If [lava/acid Y position] < 0: go to BRANCH_NOT_SUBMERGED
$90:9C77 C5 12       CMP $12    [$7E:0012]  ;\
$90:9C79 30 24       BMI $24    [$9C9F]     ;} If [lava/acid Y position] < Samus top boundary: go to BRANCH_SUBMERGED_IN_ACID_LAVA

; BRANCH_NOT_SUBMERGED
$90:9C7B AD A1 9E    LDA $9EA1  [$90:9EA1]  ;\
$90:9C7E 8D 32 0B    STA $0B32  [$7E:0B32]  ;|
$90:9C81 AD A7 9E    LDA $9EA7  [$90:9EA7]  ;} Samus Y acceleration = 0.1C00h
$90:9C84 8D 34 0B    STA $0B34  [$7E:0B34]  ;/
$90:9C87 80 22       BRA $22    [$9CAB]

; BRANCH_SUBMERGED_IN_WATER
$90:9C89 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:9C8C 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NOT_SUBMERGED
$90:9C8F D0 EA       BNE $EA    [$9C7B]     ;/
$90:9C91 AD A3 9E    LDA $9EA3  [$90:9EA3]  ;\
$90:9C94 8D 32 0B    STA $0B32  [$7E:0B32]  ;|
$90:9C97 AD A9 9E    LDA $9EA9  [$90:9EA9]  ;} Samus Y acceleration = 0.0800h
$90:9C9A 8D 34 0B    STA $0B34  [$7E:0B34]  ;/
$90:9C9D 80 0C       BRA $0C    [$9CAB]

; BRANCH_SUBMERGED_IN_ACID_LAVA
$90:9C9F AD A5 9E    LDA $9EA5  [$90:9EA5]  ;\
$90:9CA2 8D 32 0B    STA $0B32  [$7E:0B32]  ;|
$90:9CA5 AD AB 9E    LDA $9EAB  [$90:9EAB]  ;} Samus Y acceleration = 0.0900h
$90:9CA8 8D 34 0B    STA $0B34  [$7E:0B34]  ;/

$90:9CAB 60          RTS
}


;;; $9CAC: Grapple wall jump check ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if wall jump triggered, clear otherwise

$90:9CAC 08          PHP
$90:9CAD 8B          PHB
$90:9CAE 4B          PHK                    ;\
$90:9CAF AB          PLB                    ;} DB = $90
$90:9CB0 C2 30       REP #$30
$90:9CB2 A9 FF FF    LDA #$FFFF             ;\
$90:9CB5 8D 1C 0E    STA $0E1C  [$7E:0E1C]  ;} Enemy index to shake = FFFFh
$90:9CB8 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:9CBB 29 FF 00    AND #$00FF             ;|
$90:9CBE C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_FACING_LEFT
$90:9CC1 F0 2E       BEQ $2E    [$9CF1]     ;/
$90:9CC3 C9 08 00    CMP #$0008             ;\
$90:9CC6 F0 03       BEQ $03    [$9CCB]     ;} If facing right: go to BRANCH_FACING_RIGHT

$90:9CC8 4C 31 9D    JMP $9D31  [$90:9D31]  ; Return carry clear

; BRANCH_FACING_RIGHT
$90:9CCB A9 01 00    LDA #$0001             ;\
$90:9CCE 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = right
$90:9CD1 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:9CD5 AA          TAX                    ;\
$90:9CD6 D0 10       BNE $10    [$9CE8]     ;} If no collision:
$90:9CD8 22 7F 96 94 JSL $94967F[$94:967F]  ; Wall jump block collision detection
$90:9CDC 90 EA       BCC $EA    [$9CC8]     ; If no collision: return carry clear
$90:9CDE A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9CE0 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If newly pressing jump: return carry set
$90:9CE3 D0 48       BNE $48    [$9D2D]     ;/
$90:9CE5 4C 31 9D    JMP $9D31  [$90:9D31]  ; Return carry clear

$90:9CE8 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9CEA 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If newly pressing jump: go to BRANCH_WALL_JUMP_ENEMY
$90:9CED D0 35       BNE $35    [$9D24]     ;/
$90:9CEF 80 40       BRA $40    [$9D31]     ; Return carry clear

; BRANCH_FACING_LEFT
$90:9CF1 9C 02 0B    STZ $0B02  [$7E:0B02]  ; Collision direction = left
$90:9CF4 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:9CF8 AA          TAX                    ;\
$90:9CF9 D0 22       BNE $22    [$9D1D]     ;} If collision detected: go to BRANCH_COLLISION_DETECTED
$90:9CFB A5 12       LDA $12    [$7E:0012]  ;\
$90:9CFD 49 FF FF    EOR #$FFFF             ;|
$90:9D00 85 12       STA $12    [$7E:0012]  ;|
$90:9D02 A5 14       LDA $14    [$7E:0014]  ;|
$90:9D04 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9D07 1A          INC A                  ;|
$90:9D08 85 14       STA $14    [$7E:0014]  ;|
$90:9D0A D0 02       BNE $02    [$9D0E]     ;|
$90:9D0C E6 12       INC $12    [$7E:0012]  ;/

$90:9D0E 22 7F 96 94 JSL $94967F[$94:967F]  ; Wall jump block collision detection
$90:9D12 90 1D       BCC $1D    [$9D31]     ; If no collision: return carry clear
$90:9D14 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9D16 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If newly pressing jump: return carry set
$90:9D19 D0 12       BNE $12    [$9D2D]     ;/
$90:9D1B 80 14       BRA $14    [$9D31]     ; Return carry clear

; BRANCH_COLLISION_DETECTED
$90:9D1D A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9D1F 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If not newly pressing jump: return carry clear
$90:9D22 F0 0D       BEQ $0D    [$9D31]     ;/

; BRANCH_WALL_JUMP_ENEMY
$90:9D24 A5 16       LDA $16    [$7E:0016]  ;\
$90:9D26 8D 1C 0E    STA $0E1C  [$7E:0E1C]  ;} Enemy index to shake = [$16]
$90:9D29 AB          PLB
$90:9D2A 28          PLP
$90:9D2B 38          SEC                    ;\
$90:9D2C 6B          RTL                    ;} Return carry set

$90:9D2D AB          PLB
$90:9D2E 28          PLP
$90:9D2F 38          SEC
$90:9D30 6B          RTL

$90:9D31 AB          PLB
$90:9D32 28          PLP
$90:9D33 18          CLC
$90:9D34 6B          RTL
}


;;; $9D35: Wall jump check ;;;
{
;; Parameters:
;;     $12.$14: Distance to check for collision
;; Returns:
;;     Carry: Set if wall jump triggered, clear otherwise

$90:9D35 08          PHP
$90:9D36 C2 30       REP #$30
$90:9D38 AD 27 0A    LDA $0A27  [$7E:0A27]  ;\
$90:9D3B 29 FF 00    AND #$00FF             ;|
$90:9D3E C9 03 00    CMP #$0003             ;} If [Samus last different pose movement type] != spin jumping:
$90:9D41 F0 05       BEQ $05    [$9D48]     ;/
$90:9D43 C9 14 00    CMP #$0014             ;\
$90:9D46 D0 2F       BNE $2F    [$9D77]     ;} If [Samus last different pose movement type] != wall jumping: return

$90:9D48 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:9D4B C9 81 00    CMP #$0081             ;|
$90:9D4E F0 10       BEQ $10    [$9D60]     ;} If [Samus pose] != screw attack:
$90:9D50 C9 82 00    CMP #$0082             ;|
$90:9D53 F0 0B       BEQ $0B    [$9D60]     ;/
$90:9D55 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:9D58 C9 0B 00    CMP #$000B             ;} If [Samus animation frame] >= Bh:
$90:9D5B 30 0E       BMI $0E    [$9D6B]     ;/
$90:9D5D 4C DD 9D    JMP $9DDD  [$90:9DDD]  ; Go to BRANCH_WALL_JUMP_ELIGIBLE_ANIMATION

$90:9D60 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\ Else ([Samus pose] = screw attack):
$90:9D63 C9 1B 00    CMP #$001B             ;} If [Samus animation frame] < 1Bh: go to BRANCH_SPINNING_ANIMATION
$90:9D66 30 03       BMI $03    [$9D6B]     ;/
$90:9D68 4C DD 9D    JMP $9DDD  [$90:9DDD]  ; Go to BRANCH_WALL_JUMP_ELIGIBLE_ANIMATION

; BRANCH_SPINNING_ANIMATION
$90:9D6B A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9D6D 89 00 02    BIT #$0200             ;} If pressing left: go to BRANCH_SPINNING_PRESSING_LEFT
$90:9D70 D0 08       BNE $08    [$9D7A]     ;/
$90:9D72 89 00 01    BIT #$0100             ;\
$90:9D75 D0 18       BNE $18    [$9D8F]     ;} If pressing right: go to BRANCH_SPINNING_PRESSING_RIGHT

$90:9D77 28          PLP
$90:9D78 18          CLC                    ;\
$90:9D79 60          RTS                    ;} Return carry clear

; BRANCH_SPINNING_PRESSING_LEFT
$90:9D7A A9 01 00    LDA #$0001             ;\
$90:9D7D 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = right
$90:9D80 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:9D84 AA          TAX                    ;\
$90:9D85 D0 2B       BNE $2B    [$9DB2]     ;} If collision detected: go to BRANCH_COLLISION_DETECTED
$90:9D87 22 7F 96 94 JSL $94967F[$94:967F]  ; Wall jump block collision detection
$90:9D8B 90 EA       BCC $EA    [$9D77]     ; If no collision: return carry clear
$90:9D8D 80 23       BRA $23    [$9DB2]     ; Go to BRANCH_COLLISION_DETECTED

; BRANCH_SPINNING_PRESSING_RIGHT
$90:9D8F 9C 02 0B    STZ $0B02  [$7E:0B02]  ; Collision direction = left
$90:9D92 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:9D96 AA          TAX                    ;\
$90:9D97 D0 19       BNE $19    [$9DB2]     ;} If collision detected: go to BRANCH_COLLISION_DETECTED
$90:9D99 A5 12       LDA $12    [$7E:0012]  ;\
$90:9D9B 49 FF FF    EOR #$FFFF             ;|
$90:9D9E 85 12       STA $12    [$7E:0012]  ;|
$90:9DA0 A5 14       LDA $14    [$7E:0014]  ;|
$90:9DA2 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9DA5 1A          INC A                  ;|
$90:9DA6 85 14       STA $14    [$7E:0014]  ;|
$90:9DA8 D0 02       BNE $02    [$9DAC]     ;|
$90:9DAA E6 12       INC $12    [$7E:0012]  ;/

$90:9DAC 22 7F 96 94 JSL $94967F[$94:967F]  ; Wall jump block collision detection
$90:9DB0 90 C5       BCC $C5    [$9D77]     ; If no collision: return carry clear

; BRANCH_COLLISION_DETECTED
$90:9DB2 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:9DB5 C9 81 00    CMP #$0081             ;|
$90:9DB8 F0 14       BEQ $14    [$9DCE]     ;} If [Samus pose] != screw attack:
$90:9DBA C9 82 00    CMP #$0082             ;|
$90:9DBD F0 0F       BEQ $0F    [$9DCE]     ;/
$90:9DBF A9 01 00    LDA #$0001             ;\
$90:9DC2 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$90:9DC5 A9 0A 00    LDA #$000A             ;\
$90:9DC8 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = Bh - 1 (wall jump eligible)
$90:9DCB 4C 77 9D    JMP $9D77  [$90:9D77]  ; Return carry clear

$90:9DCE A9 01 00    LDA #$0001             ;\
$90:9DD1 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$90:9DD4 A9 1A 00    LDA #$001A             ;\
$90:9DD7 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 1Bh - 1 (wall jump eligible)
$90:9DDA 4C 77 9D    JMP $9D77  [$90:9D77]  ; Return carry clear

; BRANCH_WALL_JUMP_ELIGIBLE_ANIMATION
$90:9DDD A9 FF FF    LDA #$FFFF             ;\
$90:9DE0 8D 1C 0E    STA $0E1C  [$7E:0E1C]  ;} Enemy index to shake = FFFFh
$90:9DE3 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:9DE5 89 00 02    BIT #$0200             ;} If pressing left: go to BRANCH_WALL_JUMP_ELIGIBLE_PRESSING_LEFT
$90:9DE8 D0 08       BNE $08    [$9DF2]     ;/
$90:9DEA 89 00 01    BIT #$0100             ;\
$90:9DED D0 29       BNE $29    [$9E18]     ;} If pressing right: go to BRANCH_WALL_JUMP_ELIGIBLE_PRESSING_RIGHT

$90:9DEF 4C 88 9E    JMP $9E88  [$90:9E88]  ; Return carry clear

; BRANCH_WALL_JUMP_ELIGIBLE_PRESSING_LEFT
$90:9DF2 A9 01 00    LDA #$0001             ;\
$90:9DF5 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = right
$90:9DF8 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:9DFC AA          TAX                    ;\
$90:9DFD D0 10       BNE $10    [$9E0F]     ;} If no collision:
$90:9DFF 22 7F 96 94 JSL $94967F[$94:967F]  ; Wall jump block collision detection
$90:9E03 90 EA       BCC $EA    [$9DEF]     ; If no collision: return carry clear
$90:9E05 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9E07 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If newly pressing jump: go to BRANCH_WALL_JUMP_BLOCK
$90:9E0A D0 60       BNE $60    [$9E6C]     ;/
$90:9E0C 4C 88 9E    JMP $9E88  [$90:9E88]  ; Return carry clear

$90:9E0F A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9E11 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If newly pressing jump: go to BRANCH_WALL_JUMP_ENEMY
$90:9E14 D0 35       BNE $35    [$9E4B]     ;/
$90:9E16 80 70       BRA $70    [$9E88]     ; Return carry clear

; BRANCH_WALL_JUMP_ELIGIBLE_PRESSING_RIGHT
$90:9E18 9C 02 0B    STZ $0B02  [$7E:0B02]  ; Collision direction = left
$90:9E1B 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:9E1F AA          TAX                    ;\
$90:9E20 D0 22       BNE $22    [$9E44]     ;} If collision: go to BRANCH_LEFT_COLLISION_DETECTED
$90:9E22 A5 12       LDA $12    [$7E:0012]  ;\
$90:9E24 49 FF FF    EOR #$FFFF             ;|
$90:9E27 85 12       STA $12    [$7E:0012]  ;|
$90:9E29 A5 14       LDA $14    [$7E:0014]  ;|
$90:9E2B 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:9E2E 1A          INC A                  ;|
$90:9E2F 85 14       STA $14    [$7E:0014]  ;|
$90:9E31 D0 02       BNE $02    [$9E35]     ;|
$90:9E33 E6 12       INC $12    [$7E:0012]  ;/

$90:9E35 22 7F 96 94 JSL $94967F[$94:967F]  ; Wall jump block collision detection
$90:9E39 90 4D       BCC $4D    [$9E88]     ; If no collision: return carry clear
$90:9E3B A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9E3D 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If newly pressing jump: go to BRANCH_WALL_JUMP_BLOCK
$90:9E40 D0 2A       BNE $2A    [$9E6C]     ;/
$90:9E42 80 44       BRA $44    [$9E88]     ; Return carry clear

; BRANCH_LEFT_COLLISION_DETECTED
$90:9E44 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:9E46 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If not newly pressing jump: return carry clear
$90:9E49 F0 3D       BEQ $3D    [$9E88]     ;/

; BRANCH_WALL_JUMP_ENEMY
$90:9E4B A9 00 00    LDA #$0000             ;\
$90:9E4E F0 07       BEQ $07    [$9E57]     ;} Disabled code:
$90:9E50 A5 12       LDA $12    [$7E:0012]  ;\
$90:9E52 C9 05 00    CMP #$0005             ;} If (collision distance) < 5: return carry clear
$90:9E55 30 31       BMI $31    [$9E88]     ;/

$90:9E57 A5 12       LDA $12    [$7E:0012]  ;\
$90:9E59 C9 08 00    CMP #$0008             ;} If (collision distance) >= 8: go to return carry clear
$90:9E5C 10 2A       BPL $2A    [$9E88]     ;/
$90:9E5E A9 05 00    LDA #$0005             ;\
$90:9E61 8D C6 0D    STA $0DC6  [$7E:0DC6]  ;} Samus solid vertical collision result = wall jump triggered
$90:9E64 A5 16       LDA $16    [$7E:0016]  ;\
$90:9E66 8D 1C 0E    STA $0E1C  [$7E:0E1C]  ;} Enemy index to shake = [$16]
$90:9E69 28          PLP
$90:9E6A 38          SEC                    ;\
$90:9E6B 60          RTS                    ;} Return carry set

; BRANCH_WALL_JUMP_BLOCK
$90:9E6C A9 00 00    LDA #$0000             ;\
$90:9E6F F0 07       BEQ $07    [$9E78]     ;} Disabled code:
$90:9E71 A5 12       LDA $12    [$7E:0012]  ;\
$90:9E73 C9 05 00    CMP #$0005             ;} If (collision distance) < 5: return carry clear
$90:9E76 30 10       BMI $10    [$9E88]     ;/

$90:9E78 A5 12       LDA $12    [$7E:0012]  ;\
$90:9E7A C9 08 00    CMP #$0008             ;} If (collision distance) >= 8: go to return carry clear
$90:9E7D 10 09       BPL $09    [$9E88]     ;/
$90:9E7F A9 05 00    LDA #$0005             ;\
$90:9E82 8D C6 0D    STA $0DC6  [$7E:0DC6]  ;} Samus solid vertical collision result = wall jump triggered
$90:9E85 28          PLP
$90:9E86 38          SEC                    ;\
$90:9E87 60          RTS                    ;} Return carry set

$90:9E88 28          PLP
$90:9E89 18          CLC
$90:9E8A 60          RTS
}


;;; $9E8B: Samus physics constants ;;;
{
$90:9E8B             dw 8000    ; Lava subdamage per frame
$90:9E8D             dw 0000    ; Lava damage per frame
$90:9E8F             dw 8000    ; Acid subdamage per frame
$90:9E91             dw 0001    ; Acid damage per frame
$90:9E93             dw 0003    ; Samus animation delay in water
$90:9E95             dw 0002    ; Samus animation delay in lava/acid
$90:9E97             dw 0280    ; Space jump minimum Y velocity in air * 100h
$90:9E99             dw 0500    ; Space jump maximum Y velocity in air * 100h
$90:9E9B             dw 0080    ; Space jump minimum Y velocity in water * 100h
$90:9E9D             dw 0500    ; Space jump maximum Y velocity in water * 100h
$90:9E9F             dw 0008    ; Maximum distance from wall for wall-jump
$90:9EA1             dw 1C00    ; Samus Y subacceleration in air
$90:9EA3             dw 0800    ; Samus Y subacceleration in water
$90:9EA5             dw 0900    ; Samus Y subacceleration in acid/lava
$90:9EA7             dw 0000    ; Samus Y acceleration in air
$90:9EA9             dw 0000    ; Samus Y acceleration in water
$90:9EAB             dw 0000    ; Samus Y acceleration in acid/lava
$90:9EAD             dw 0001    ; Camera X offset from Samus when turning
$90:9EAF             dw 0000    ; Camera X suboffset from Samus when turning
$90:9EB1             dw 0001    ; Camera Y offset from Samus when turning
$90:9EB3             dw 0000    ; Camera Y suboffset from Samus when turning
$90:9EB5             dw 0001    ; Samus Y speed when bouncing in morph ball
$90:9EB7             dw 0000    ; Samus Y subspeed when bouncing in morph ball

;                        _____________________________ Initial Y speed in air
;                       |     ________________________ Initial Y speed in water
;                       |    |     ___________________ Initial Y speed in lava/acid
;                       |    |    |      _____________ Initial Y subspeed in air
;                       |    |    |     |     ________ Initial Y subspeed in water
;                       |    |    |     |    |     ___ Initial Y subspeed in lava/acid
;                       |    |    |     |    |    |
$90:9EB9             dw 0004,0001,0002, E000,C000,C000 ; When jumping
$90:9EC5             dw 0006,0002,0003, 0000,8000,8000 ; When jumping with hi-jump
$90:9ED1             dw 0004,0000,0002, A000,4000,A000 ; When wall-jumping
$90:9EDD             dw 0005,0000,0003, 8000,8000,8000 ; When wall-jumping with hi-jump
$90:9EE9             dw 0005,0002,0002, 0000,0000,0000 ; During knockback
$90:9EF5             dw 0002,0000,0000, C000,1000,1000 ; During bomb jump

;                        _____________________________ X acceleration in air
;                       |     ________________________ X acceleration in water
;                       |    |     ___________________ X acceleration in lava/acid
;                       |    |    |      _____________ X subacceleration in air
;                       |    |    |     |     ________ X subacceleration in water
;                       |    |    |     |    |     ___ X subacceleration in lava/acid
;                       |    |    |     |    |    |
$90:9F01             dw 0000,0000,0000, 1000,0400,0400 ; Extra run speed when running (due to holding the run button)

;                        _____________________________ Max X extra run speed in air
;                       |     ________________________ Max X extra run speed in water
;                       |    |     ___________________ Max X extra run speed in lava/acid
;                       |    |    |      _____________ Max X extra run subspeed in air
;                       |    |    |     |     ________ Max X extra run subspeed in water
;                       |    |    |     |    |     ___ Max X extra run subspeed in lava/acid
;                       |    |    |     |    |    |
$90:9F0D             dw 0007,0004,0004, 0000,0000,0000 ; With speed booster
$90:9F19             dw 0002,0001,0000, 0000,0000,0000 ; Without speed booster

;                        ______________________________ X acceleration
;                       |     _________________________ X subacceleration
;                       |    |      ___________________ Max X speed
;                       |    |     |     ______________ Max X subspeed
;                       |    |     |    |      ________ X deceleration
;                       |    |     |    |     |     ___ X subdeceleration
;                       |    |     |    |     |    |
$90:9F25             dw 0000,3000, 0003,0000, 0000,0800 ; During diagonal bomb jump
$90:9F31             dw 0000,3000, 000F,0000, 0000,1000 ; When disconnecting grapple beam in air
$90:9F3D             dw 0000,3000, 000F,0000, 0000,1000 ; When disconnecting grapple beam in water
$90:9F49             dw 0000,3000, 000F,0000, 0000,1000 ; When disconnecting grapple beam in lava/acid
}


;;; $9F55: Samus X speed table - normal ;;;
{
; Used for Samus X base speed (due to general movement)

;                        ______________________________ X acceleration
;                       |     _________________________ X subacceleration
;                       |    |      ___________________ Max X speed
;                       |    |     |     ______________ Max X subspeed
;                       |    |     |    |      ________ X deceleration
;                       |    |     |    |     |     ___ X subdeceleration
;                       |    |     |    |     |    |
$90:9F55             dw 0000,C000,0000,0000,0000,8000, ; 0: Standing
                        0000,3000,0002,C000,0000,8000, ; 1: Running
                        0000,C000,0001,4000,0000,8000, ; 2: Normal jumping
                        0000,C000,0001,6000,0000,8000, ; 3: Spin jumping
                        0000,C000,0003,4000,0000,8000, ; 4: Morph ball - on ground
                        0000,C000,0000,0000,0000,8000, ; 5: Crouching
                        0000,C000,0001,0000,0000,8000, ; 6: Falling
                        0002,0000,0001,0000,0000,8000, ; 7: Unused
                        0000,C000,0001,0000,0000,8000, ; 8: Morph ball - falling
                        0002,0000,0002,0000,0000,8000, ; 9: Unused
                        0001,8000,0005,0000,0000,8000, ; Ah: Knockback / crystal flash ending
                        0000,C000,0000,0000,0000,8000, ; Bh: Unused
                        0000,C000,0000,0000,0000,8000, ; Ch: Unused
                        0000,C000,0002,0000,0000,8000, ; Dh: Unused
                        0000,C000,0000,0000,0000,8000, ; Eh: Turning around - on ground
                        0000,C000,0001,4000,0000,8000, ; Fh: Crouching/standing/morphing/unmorphing transition
                        0000,C000,0000,8000,0000,8000, ; 10h: Moonwalking
                        0000,C000,0003,4000,0000,8000, ; 11h: Spring ball - on ground
                        0000,C000,0001,4000,0000,8000, ; 12h: Spring ball - in air
                        0000,C000,0001,0000,0000,8000, ; 13h: Spring ball - falling
                        0000,C000,0001,6000,0000,8000, ; 14h: Wall jumping
                        0000,C000,0000,0000,0000,8000, ; 15h: Ran into a wall
                        0000,C000,0001,4000,0000,8000, ; 16h: Grappling
                        0000,C000,0000,0000,0000,8000, ; 17h: Turning around - jumping
                        0000,C000,0000,0000,0000,8000, ; 18h: Turning around - falling
                        0000,C000,0005,0000,0000,8000  ; 19h: Damage boost
}


;;; $A08D: Samus X speed table - in water ;;;
{
; Used for Samus X base speed (due to general movement)

;                        ______________________________ X acceleration
;                       |     _________________________ X subacceleration
;                       |    |      ___________________ Max X speed
;                       |    |     |     ______________ Max X subspeed
;                       |    |     |    |      ________ X deceleration
;                       |    |     |    |     |     ___ X subdeceleration
;                       |    |     |    |     |    |
$90:A08D             dw 0000,C000,0000,0000,0000,0800,  ; 0: Standing
                        0000,0400,0002,C000,0000,0800,  ; 1: Running
                        0000,C000,0001,4000,0000,0800,  ; 2: Normal jumping
                        0000,C000,0001,6000,0000,0800,  ; 3: Spin jumping
                        0000,0400,0002,C000,0000,0800,  ; 4: Morph ball - on ground
                        0000,C000,0000,0000,0000,0800,  ; 5: Crouching
                        0000,C000,0001,0000,0000,0800,  ; 6: Falling
                        0002,0000,0001,0000,0000,0800,  ; 7: Unused
                        0000,0400,0001,8000,0000,0800,  ; 8: Morph ball - falling
                        0002,0000,0002,0000,0000,0800,  ; 9: Unused
                        0001,8000,0005,0000,0000,0800,  ; Ah: Knockback / crystal flash ending
                        0000,C000,0000,0000,0000,0800,  ; Bh: Unused
                        0000,C000,0000,0000,0000,0800,  ; Ch: Unused
                        0000,C000,0002,0000,0000,0800,  ; Dh: Unused
                        0000,C000,0000,0000,0000,0800,  ; Eh: Turning around - on ground
                        0000,C000,0001,4000,0000,0800,  ; Fh: Crouching/standing/morphing/unmorphing transition
                        0000,C000,0000,8000,0000,0800,  ; 10h: Moonwalking
                        0000,0400,0002,C000,0000,0800,  ; 11h: Spring ball - on ground
                        0000,0400,0001,4000,0000,0800,  ; 12h: Spring ball - in air
                        0000,0400,0001,8000,0000,0800,  ; 13h: Spring ball - falling
                        0000,C000,0001,6000,0000,0800,  ; 14h: Wall jumping
                        0000,C000,0000,0000,0000,0800,  ; 15h: Ran into a wall
                        0000,C000,0001,4000,0000,0800,  ; 16h: Grappling
                        0000,C000,0000,0000,0000,0800,  ; 17h: Turning around - jumping
                        0000,C000,0000,0000,0000,0800,  ; 18h: Turning around - falling
                        0000,C000,0000,8000,0000,0800,  ; 19h: Damage boost
                        0000,C000,0005,0000,0000,0800,  ; 1Ah: Grabbed by Draygon
                        0000,C000,0005,0000,0000,0800   ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $A1DD: Samus X speed table - in lava/acid ;;;
{
; Used for Samus X base speed (due to general movement)

;                        ______________________________ X acceleration
;                       |     _________________________ X subacceleration
;                       |    |      ___________________ Max X speed
;                       |    |     |     ______________ Max X subspeed
;                       |    |     |    |      ________ X deceleration
;                       |    |     |    |     |     ___ X subdeceleration
;                       |    |     |    |     |    |
$90:A1DD             dw 0000,C000,0000,0000,0000,4000,  ; 0: Standing
                        0000,0400,0001,C000,0000,4000,  ; 1: Running
                        0000,C000,0001,4000,0000,4000,  ; 2: Normal jumping
                        0000,C000,0001,6000,0000,4000,  ; 3: Spin jumping
                        0000,0400,0002,C000,0000,4000,  ; 4: Morph ball - on ground
                        0000,C000,0000,0000,0000,4000,  ; 5: Crouching
                        0000,C000,0001,0000,0000,4000,  ; 6: Falling
                        0002,0000,0001,0000,0000,4000,  ; 7: Unused
                        0000,0400,0001,6000,0000,4000,  ; 8: Morph ball - falling
                        0002,0000,0002,0000,0000,4000,  ; 9: Unused
                        0001,8000,0005,0000,0000,4000,  ; Ah: Knockback / crystal flash ending
                        0000,C000,0000,0000,0000,4000,  ; Bh: Unused
                        0000,C000,0000,0000,0000,4000,  ; Ch: Unused
                        0000,C000,0002,0000,0000,4000,  ; Dh: Unused
                        0000,C000,0000,0000,0000,4000,  ; Eh: Turning around - on ground
                        0000,C000,0001,4000,0000,4000,  ; Fh: Crouching/standing/morphing/unmorphing transition
                        0000,C000,0000,8000,0000,4000,  ; 10h: Moonwalking
                        0000,0400,0002,C000,0000,4000,  ; 11h: Spring ball - on ground
                        0000,0400,0001,4000,0000,4000,  ; 12h: Spring ball - in air
                        0000,0400,0001,6000,0000,4000,  ; 13h: Spring ball - falling
                        0000,C000,0001,6000,0000,4000,  ; 14h: Wall jumping
                        0000,C000,0000,0000,0000,4000,  ; 15h: Ran into a wall
                        0000,C000,0001,4000,0000,4000,  ; 16h: Grappling
                        0000,C000,0000,0000,0000,4000,  ; 17h: Turning around - jumping
                        0000,C000,0000,0000,0000,4000,  ; 18h: Turning around - falling
                        0000,C000,0000,8000,0000,4000,  ; 19h: Damage boost
                        0000,C000,0005,0000,0000,4000,  ; 1Ah: Grabbed by Draygon
                        0000,C000,0005,0000,0000,4000   ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $A32D: Samus movement - movement type 7 (unused) ;;;
{
$90:A32D 08          PHP
$90:A32E C2 30       REP #$30
$90:A330 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A333 28          PLP
$90:A334 60          RTS
}


;;; $A335: Unused ;;;
{
$90:A335             dw 001E
}


;;; $A337: Samus movement handler - normal ;;;
{
; Cause of elevator blue suit
$90:A337 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:A33A D0 0E       BNE $0E    [$A34A]     ;} If time is frozen: return
$90:A33C AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:A33F 29 FF 00    AND #$00FF             ;|
$90:A342 0A          ASL A                  ;} Execute [$A34B + [Samus movement type]]
$90:A343 AA          TAX                    ;|
$90:A344 FC 4B A3    JSR ($A34B,x)[$90:A383];/
$90:A347 20 E7 EE    JSR $EEE7  [$90:EEE7]  ; Update speed echo position

$90:A34A 60          RTS

$90:A34B             dw A383, ; 0: Standing
                        A3E5, ; 1: Running
                        A42E, ; 2: Normal jumping
                        A436, ; 3: Spin jumping
                        A521, ; 4: Morph ball - on ground
                        A573, ; 5: Crouching
                        A58D, ; 6: Falling
                        A32D, ; 7: Unused
                        A5CA, ; 8: Morph ball - falling
                        A5FB, ; 9: Unused
                        A5FC, ; Ah: Knockback / crystal flash ending
                        A607, ; Bh: Unused
                        A60F, ; Ch: Unused
                        A617, ; Dh: Unused
                        A67C, ; Eh: Turning around - on ground
                        A61C, ; Fh: Crouching/standing/morphing/unmorphing transition
                        A694, ; 10h: Moonwalking
                        A69F, ; 11h: Spring ball - on ground
                        A6F1, ; 12h: Spring ball - in air
                        A703, ; 13h: Spring ball - falling
                        A734, ; 14h: Wall jumping
                        A75F, ; 15h: Ran into a wall
                        A780, ; 16h: Grappling
                        A790, ; 17h: Turning around - jumping
                        A7AD, ; 18h: Turning around - falling
                        A7CA, ; 19h: Damage boost
                        A7D2, ; 1Ah: Grabbed by Draygon
                        A7DA  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $A383: Samus movement - standing ;;;
{
; The fact that $9348 is called is what allows the shinespark -> suit pickup to move Samus horizontally,
; only her base X speed is set to 0 for the purposes of these calculations, her X extra run speed is taken into account
; (extra X displacement is also taken into account)
$90:A383 08          PHP
$90:A384 C2 30       REP #$30
$90:A386 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A389 F0 07       BEQ $07    [$A392]     ;|
$90:A38B C9 9B 00    CMP #$009B             ;} If [Samus pose] != facing forward:
$90:A38E F0 02       BEQ $02    [$A392]     ;/
$90:A390 80 1B       BRA $1B    [$A3AD]     ; Go to BRANCH_NOT_FACING_FORWARD

$90:A392 AD 18 0E    LDA $0E18  [$7E:0E18]  ;\
$90:A395 F0 11       BEQ $11    [$A3A8]     ;} If [elevator status] != inactive:
$90:A397 A9 02 00    LDA #$0002             ;\
$90:A39A 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = up
$90:A39D A9 01 00    LDA #$0001             ;\
$90:A3A0 85 12       STA $12    [$7E:0012]  ;|
$90:A3A2 64 14       STZ $14    [$7E:0014]  ;} Move Samus down by 1.0, no solid enemy collision
$90:A3A4 22 63 97 94 JSL $949763[$94:9763]  ;/

$90:A3A8 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A3AB 80 36       BRA $36    [$A3E3]     ; Return

; BRANCH_NOT_FACING_FORWARD
$90:A3AD AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A3B0 C9 01 00    CMP #$0001             ;|
$90:A3B3 F0 05       BEQ $05    [$A3BA]     ;} If [Samus pose] = normal:
$90:A3B5 C9 02 00    CMP #$0002             ;|
$90:A3B8 D0 10       BNE $10    [$A3CA]     ;/
$90:A3BA A5 8B       LDA $8B    [$7E:008B]  ;\
$90:A3BC 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If pressing shoot:
$90:A3BF F0 09       BEQ $09    [$A3CA]     ;/
$90:A3C1 A9 10 00    LDA #$0010             ;\
$90:A3C4 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 10h
$90:A3C7 9C 96 0A    STZ $0A96  [$7E:0A96]  ; Samus animation frame = 0

$90:A3CA 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:A3CD 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A3D0 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A3D4 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A3D7 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A3DA 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A3DD 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A3E0 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating

$90:A3E3 28          PLP
$90:A3E4 60          RTS
}


;;; $A3E5: Samus movement - running ;;;
{
$90:A3E5 08          PHP
$90:A3E6 C2 30       REP #$30
$90:A3E8 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A3EB 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A3EE AE 96 0A    LDX $0A96  [$7E:0A96]  ; X = [Samus animation frame]
$90:A3F1 AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$90:A3F4 C9 01 00    CMP #$0001             ;} If [Samus animation frame timer] != 1: return
$90:A3F7 D0 29       BNE $29    [$A422]     ;/
$90:A3F9 BD 24 A4    LDA $A424,x[$90:A424]  ;\
$90:A3FC 29 FF 00    AND #$00FF             ;} If [$A424 + [Samus animation frame]] = 0: return
$90:A3FF F0 21       BEQ $21    [$A422]     ;/
$90:A401 20 88 ED    JSR $ED88  [$90:ED88]  ; Footstep graphics
$90:A404 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$90:A407 D0 19       BNE $19    [$A422]     ;} If [cinematic function] != 0: return
$90:A409 AD 9C 17    LDA $179C  [$7E:179C]  ;\
$90:A40C D0 14       BNE $14    [$A422]     ;} If [boss ID] != 0: return
$90:A40E AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$90:A411 D0 0F       BNE $0F    [$A422]     ;} If [special Samus palette timer] != 0: return
$90:A413 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:A416 89 00 04    BIT #$0400             ;} If speed boosting: return
$90:A419 D0 07       BNE $07    [$A422]     ;/
$90:A41B A9 06 00    LDA #$0006             ;\
$90:A41E 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 6, sound library 3, max queued sounds allowed = 6 (Samus' footsteps)

$90:A422 28          PLP
$90:A423 60          RTS

; Presumably these frames correspond to the points when Samus' foot hits the ground
$90:A424             db 00, 00, 01, 00, 00, 00, 00, 01, 00, 00
}


;;; $A42E: Samus movement - normal jumping ;;;
{
$90:A42E 08          PHP
$90:A42F C2 30       REP #$30
$90:A431 20 B3 8F    JSR $8FB3  [$90:8FB3]  ; Samus jumping movement
$90:A434 28          PLP
$90:A435 60          RTS
}


;;; $A436: Samus movement - spin jumping ;;;
{
; Handles space jump
$90:A436 08          PHP
$90:A437 C2 30       REP #$30
$90:A439 AD 74 0A    LDA $0A74  [$7E:0A74]  ;\
$90:A43C 89 04 00    BIT #$0004             ;} If [Samus suit palette index] & 4 != 0 (gravity suit palette): go to BRANCH_NON_LIQUID_PHYSICS
$90:A43F D0 27       BNE $27    [$A468]     ;/
$90:A441 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $14 = Samus top boundary
$90:A445 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:A448 30 0E       BMI $0E    [$A458]     ;} If [FX Y position] >= 0:
$90:A44A C5 14       CMP $14    [$7E:0014]  ;\
$90:A44C 10 1A       BPL $1A    [$A468]     ;} If [FX Y position] >= (Samus top boundary): go to BRANCH_NON_LIQUID_PHYSICS
$90:A44E AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:A451 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$90:A454 D0 12       BNE $12    [$A468]     ;/
$90:A456 80 09       BRA $09    [$A461]

$90:A458 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:A45B 30 0B       BMI $0B    [$A468]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$90:A45D C5 14       CMP $14    [$7E:0014]  ;\
$90:A45F 10 07       BPL $07    [$A468]     ;} If [lava/acid Y position] >= (Samus top boundary): go to BRANCH_NON_LIQUID_PHYSICS

$90:A461 A9 01 00    LDA #$0001             ;\
$90:A464 85 12       STA $12    [$7E:0012]  ;} $12 = 1
$90:A466 80 02       BRA $02    [$A46A]     ; Go to BRANCH_DETERMINED_LIQUID_PHYSICS

; BRANCH_NON_LIQUID_PHYSICS
$90:A468 64 12       STZ $12    [$7E:0012]  ; $12 = 0

; BRANCH_DETERMINED_LIQUID_PHYSICS
$90:A46A A5 12       LDA $12    [$7E:0012]  ;\
$90:A46C D0 69       BNE $69    [$A4D7]     ;} If [$12] != 0 (liquid physics): go to BRANCH_LIQUID_PHYSICS
$90:A46E AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:A471 89 00 02    BIT #$0200             ;} If space jump equipped: go to BRANCH_SPACE_JUMP_ELIGIBLE
$90:A474 D0 12       BNE $12    [$A488]     ;/
$90:A476 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A479 C9 81 00    CMP #$0081             ;|
$90:A47C F0 07       BEQ $07    [$A485]     ;} If [Samus pose] = screw attack: go to BRANCH_SCREW_ATTACK
$90:A47E C9 82 00    CMP #$0082             ;|
$90:A481 F0 02       BEQ $02    [$A485]     ;/
$90:A483 80 52       BRA $52    [$A4D7]     ; Go to BRANCH_LIQUID_PHYSICS

$90:A485 4C 09 A5    JMP $A509  [$90:A509]

; BRANCH_SPACE_JUMP_ELIGIBLE
$90:A488 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:A48B C9 02 00    CMP #$0002             ;} If [Samus Y direction] != down: go to BRANCH_SCREW_ATTACK_ELIGIBLE
$90:A48E D0 38       BNE $38    [$A4C8]     ;/
$90:A490 AD D2 0A    LDA $0AD2  [$7E:0AD2]  ;\
$90:A493 F0 0F       BEQ $0F    [$A4A4]     ;} If [liquid physics type] != air:
$90:A495 AD 2D 0B    LDA $0B2D  [$7E:0B2D]  ;\
$90:A498 CD 9B 9E    CMP $9E9B  [$90:9E9B]  ;|
$90:A49B 30 2B       BMI $2B    [$A4C8]     ;} If not 0.80h <= [Samus Y speed] < 5.00h: go to BRANCH_SCREW_ATTACK_ELIGIBLE
$90:A49D CD 9D 9E    CMP $9E9D  [$90:9E9D]  ;|
$90:A4A0 10 26       BPL $26    [$A4C8]     ;/
$90:A4A2 80 0D       BRA $0D    [$A4B1]

$90:A4A4 AD 2D 0B    LDA $0B2D  [$7E:0B2D]  ;\ Else ([liquid physics type] = air):
$90:A4A7 CD 97 9E    CMP $9E97  [$90:9E97]  ;|
$90:A4AA 30 1C       BMI $1C    [$A4C8]     ;} If not 2.80h <= [Samus Y speed] < 5.00h: go to BRANCH_SCREW_ATTACK_ELIGIBLE
$90:A4AC CD 99 9E    CMP $9E99  [$90:9E99]  ;|
$90:A4AF 10 17       BPL $17    [$A4C8]     ;/

$90:A4B1 AD FA 0D    LDA $0DFA  [$7E:0DFA]  ;\
$90:A4B4 29 00 FF    AND #$FF00             ;|
$90:A4B7 09 01 00    ORA #$0001             ;} $0DFA low = 1
$90:A4BA 8D FA 0D    STA $0DFA  [$7E:0DFA]  ;/
$90:A4BD A5 8F       LDA $8F    [$7E:008F]  ;\
$90:A4BF 2D B4 09    AND $09B4  [$7E:09B4]  ;} If newly pressed jump:
$90:A4C2 F0 04       BEQ $04    [$A4C8]     ;/
$90:A4C4 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump

; BRANCH_SCREW_ATTACK_ELIGIBLE
$90:A4C8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A4CB C9 81 00    CMP #$0081             ;|
$90:A4CE F0 39       BEQ $39    [$A509]     ;} If [Samus pose] = screw attack: go to BRANCH_SCREW_ATTACK
$90:A4D0 C9 82 00    CMP #$0082             ;|
$90:A4D3 F0 34       BEQ $34    [$A509]     ;/
$90:A4D5 80 00       BRA $00    [$A4D7]     ; >_<;

; BRANCH_LIQUID_PHYSICS
$90:A4D7 A5 12       LDA $12    [$7E:0012]  ;\
$90:A4D9 F0 1A       BEQ $1A    [$A4F5]     ;} If [$12] != 0 (liquid physics):
$90:A4DB AE 96 0A    LDX $0A96  [$7E:0A96]  ; X = [Samus animation frame]
$90:A4DE AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$90:A4E1 C9 01 00    CMP #$0001             ;} If [Samus animation frame timer] = 1:
$90:A4E4 D0 0F       BNE $0F    [$A4F5]     ;/
$90:A4E6 BD 14 A5    LDA $A514,x[$90:A51A]  ;\
$90:A4E9 29 FF 00    AND #$00FF             ;} If [$A514 + [Samus animation frame]] != 0:
$90:A4EC F0 07       BEQ $07    [$A4F5]     ;/
$90:A4EE A9 2F 00    LDA #$002F             ;\
$90:A4F1 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 2Fh, sound library 1, max queued sounds allowed = 6 (underwater space jump)

$90:A4F5 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:A4F8 C9 3C 00    CMP #$003C             ;} If [flare counter] < 3Ch: go to BRANCH_RETURN
$90:A4FB 30 12       BMI $12    [$A50F]     ;/
$90:A4FD A5 12       LDA $12    [$7E:0012]  ;\
$90:A4FF D0 0E       BNE $0E    [$A50F]     ;} If [$12] != 0 (liquid physics): go to BRANCH_RETURN
$90:A501 A9 04 00    LDA #$0004             ;\
$90:A504 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = pseudo screw attacking
$90:A507 80 06       BRA $06    [$A50F]     ; Go to BRANCH_RETURN

; BRANCH_SCREW_ATTACK
$90:A509 A9 03 00    LDA #$0003             ;\
$90:A50C 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = screw attacking

; BRANCH_RETURN
$90:A50F 20 40 90    JSR $9040  [$90:9040]  ; Samus spin jumping movement
$90:A512 28          PLP
$90:A513 60          RTS

; Samus animation frames on which to play underwater space jump sound effect
$90:A514             db 01, 00, 00, 00, 00, 00, 00, 00, 01, 00, 00, 00, 00
}


;;; $A521: Samus movement - morph ball - on ground ;;;
{
$90:A521 08          PHP
$90:A522 C2 30       REP #$30
$90:A524 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:A527 D0 3D       BNE $3D    [$A566]     ;} If [Samus X acceleration mode] != accelerating: go to BRANCH_DECELERATING
$90:A529 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:A52C 29 FF 00    AND #$00FF             ;|
$90:A52F C9 04 00    CMP #$0004             ;} If facing right:
$90:A532 F0 0A       BEQ $0A    [$A53E]     ;/
$90:A534 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A537 C9 1D 00    CMP #$001D             ;} If [Samus pose] != facing right - morph ball - no springball - on ground: go to BRANCH_DECELERATING
$90:A53A D0 2A       BNE $2A    [$A566]     ;/
$90:A53C 80 08       BRA $08    [$A546]

$90:A53E AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\ Else (facing left):
$90:A541 C9 41 00    CMP #$0041             ;} If [Samus pose] != facing left  - morph ball - no springball - on ground: go to BRANCH_DECELERATING
$90:A544 D0 20       BNE $20    [$A566]     ;/

$90:A546 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:A549 20 B8 92    JSR $92B8  [$90:92B8]  ; Simple Samus Y movement
$90:A54C B0 23       BCS $23    [$A571]     ; If [Samus Y direction] != none: return
$90:A54E 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A551 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A555 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A558 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A55B 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A55E 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A561 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:A564 80 0B       BRA $0B    [$A571]     ; Return

; BRANCH_DECELERATING
$90:A566 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A569 20 B8 92    JSR $92B8  [$90:92B8]  ; Simple Samus Y movement
$90:A56C B0 03       BCS $03    [$A571]     ; If [Samus Y direction] = none:
$90:A56E 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations

$90:A571 28          PLP
$90:A572 60          RTS
}


;;; $A573: Samus movement - crouching ;;;
{
$90:A573 08          PHP
$90:A574 C2 30       REP #$30
$90:A576 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:A579 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A57C 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A57F 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A582 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A585 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A588 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:A58B 28          PLP
$90:A58C 60          RTS
}


;;; $A58D: Samus movement - falling ;;;
{
$90:A58D 08          PHP
$90:A58E C2 30       REP #$30
$90:A590 20 68 91    JSR $9168  [$90:9168]  ; Samus falling movement
$90:A593 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A596 C9 29 00    CMP #$0029             ;|
$90:A599 F0 11       BEQ $11    [$A5AC]     ;} If [Samus pose] != falling:
$90:A59B C9 2A 00    CMP #$002A             ;|
$90:A59E F0 0C       BEQ $0C    [$A5AC]     ;/
$90:A5A0 C9 67 00    CMP #$0067             ;\
$90:A5A3 F0 07       BEQ $07    [$A5AC]     ;|
$90:A5A5 C9 68 00    CMP #$0068             ;} If [Samus pose] != falling - gun extended:
$90:A5A8 F0 02       BEQ $02    [$A5AC]     ;/
$90:A5AA 80 1C       BRA $1C    [$A5C8]     ; Return

$90:A5AC AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:A5AF C9 05 00    CMP #$0005             ;} If [Samus Y speed] < 5: return
$90:A5B2 30 14       BMI $14    [$A5C8]     ;/
$90:A5B4 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:A5B7 C9 05 00    CMP #$0005             ;} If [Samus animation frame] >= 5: return
$90:A5BA 10 0C       BPL $0C    [$A5C8]     ;/
$90:A5BC A9 08 00    LDA #$0008             ;\
$90:A5BF 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 8
$90:A5C2 A9 05 00    LDA #$0005             ;\
$90:A5C5 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 5 (terminal velocity)

$90:A5C8 28          PLP
$90:A5C9 60          RTS
}


;;; $A5CA: Samus movement - morph ball - falling ;;;
{
$90:A5CA 08          PHP
$90:A5CB C2 30       REP #$30
$90:A5CD A5 8B       LDA $8B    [$7E:008B]  ;\
$90:A5CF 89 00 03    BIT #$0300             ;} If not pressing left or right:
$90:A5D2 D0 18       BNE $18    [$A5EC]     ;/
$90:A5D4 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:A5D7 D0 13       BNE $13    [$A5EC]     ;} If [Samus X acceleration mode] = accelerating:
$90:A5D9 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A5DD 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A5E0 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A5E3 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A5E6 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A5E9 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating

$90:A5EC AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$90:A5EF D0 05       BNE $05    [$A5F6]     ;} If not bouncing:
$90:A5F1 20 9F 91    JSR $919F  [$90:919F]  ; Samus morphed falling movement
$90:A5F4 80 03       BRA $03    [$A5F9]     ; Return

$90:A5F6 20 D1 91    JSR $91D1  [$90:91D1]  ; Samus morphed bouncing movement

$90:A5F9 28          PLP
$90:A5FA 60          RTS
}


;;; $A5FB: RTS. Samus movement - movement type 9 (unused) ;;;
{
$90:A5FB 60          RTS
}


;;; $A5FC: Samus movement - knockback / crystal flash ending ;;;
{
$90:A5FC 08          PHP
$90:A5FD C2 30       REP #$30
$90:A5FF 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A602 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A605 28          PLP
$90:A606 60          RTS
}


;;; $A607: Samus movement - movement type Bh (unused) ;;;
{
$90:A607 08          PHP
$90:A608 C2 30       REP #$30
$90:A60A 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A60D 28          PLP
$90:A60E 60          RTS
}


;;; $A60F: Samus movement - movement type Ch (unused) ;;;
{
$90:A60F 08          PHP
$90:A610 C2 30       REP #$30
$90:A612 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A615 28          PLP
$90:A616 60          RTS
}


;;; $A617: RTS. Samus movement - movement type Dh (unused) ;;;
{
$90:A617 08          PHP
$90:A618 C2 30       REP #$30
$90:A61A 28          PLP
$90:A61B 60          RTS
}


;;; $A61C: Samus movement - crouching/standing/morphing/unmorphing transition ;;;
{
$90:A61C 08          PHP
$90:A61D C2 30       REP #$30
$90:A61F AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A622 C9 F1 00    CMP #$00F1             ;} If [Samus pose] != crouching/standing transition - aiming:
$90:A625 10 0E       BPL $0E    [$A635]     ;/
$90:A627 C9 DB 00    CMP #$00DB             ;\
$90:A62A 10 14       BPL $14    [$A640]     ;} If [Samus pose] >= DBh: go to BRANCH_NO_Y_MOVEMENT
$90:A62C 38          SEC                    ;\
$90:A62D E9 35 00    SBC #$0035             ;|
$90:A630 0A          ASL A                  ;} X = ([Samus pose] - 35h) * 2
$90:A631 AA          TAX                    ;/
$90:A632 FC 59 A6    JSR ($A659,x)[$90:A671]; Execute [$A659 + [X]] (effectively a NOP)

$90:A635 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:A638 20 C7 92    JSR $92C7  [$90:92C7]  ; Simple Samus Y movement
$90:A63B B0 03       BCS $03    [$A640]     ; If [Samus Y direction] = none:
$90:A63D 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations

; BRANCH_NO_Y_MOVEMENT
$90:A640 AD C6 0D    LDA $0DC6  [$7E:0DC6]  ;\
$90:A643 C9 01 04    CMP #$0401             ;} If [Samus solid vertical collision result] = landed and [Samus downwards movement solid collision result] = no change:
$90:A646 D0 0C       BNE $0C    [$A654]     ;/
$90:A648 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:A64B 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:A64E 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$90:A651 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing

$90:A654 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A657 28          PLP
$90:A658 60          RTS

$90:A659             dw A671, ; 35h: Facing right - crouching transition
                        A671, ; 36h: Facing left  - crouching transition
                        A671, ; 37h: Facing right - morphing transition
                        A671, ; 38h: Facing left  - morphing transition
                        A672, ; 39h: Unused
                        A672, ; 3Ah: Unused
                        A671, ; 3Bh: Facing right - standing transition
                        A671, ; 3Ch: Facing left  - standing transition
                        A671, ; 3Dh: Facing right - unmorphing transition
                        A671, ; 3Eh: Facing left  - unmorphing transition
                        A672, ; 3Fh: Unused
                        A672  ; 40h: Unused
}


;;; $A671: RTS ;;;
{
$90:A671 60          RTS
}


;;; $A672: Enable horizontal slope detection ;;;
{
$90:A672 A9 03 00    LDA #$0003             ;\
$90:A675 8D 46 0A    STA $0A46  [$7E:0A46]  ;} Enable horizontal slope detection
$90:A678 9C A4 0A    STZ $0AA4  [$7E:0AA4]  ; $0AA4 = 0 (never read)
$90:A67B 60          RTS
}


;;; $A67C: Samus movement - turning around - on ground ;;;
{
$90:A67C 08          PHP
$90:A67D C2 30       REP #$30
$90:A67F 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A682 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A685 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A689 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A68C 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A68F 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A692 28          PLP
$90:A693 60          RTS
}


;;; $A694: Samus movement - moonwalking ;;;
{
$90:A694 08          PHP
$90:A695 C2 30       REP #$30
$90:A697 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A69A 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A69D 28          PLP
$90:A69E 60          RTS
}


;;; $A69F: Samus movement - spring ball - on ground ;;;
{
$90:A69F 08          PHP
$90:A6A0 C2 30       REP #$30
$90:A6A2 AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:A6A5 D0 3D       BNE $3D    [$A6E4]     ;} If [Samus X acceleration mode] != accelerating: go to BRANCH_DECELERATING
$90:A6A7 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:A6AA 29 FF 00    AND #$00FF             ;|
$90:A6AD C9 04 00    CMP #$0004             ;} If facing right:
$90:A6B0 F0 0A       BEQ $0A    [$A6BC]     ;/
$90:A6B2 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:A6B5 C9 79 00    CMP #$0079             ;} If [Samus pose] != [facing right - morph ball - spring ball - on ground]: go to BRANCH_DECELERATING
$90:A6B8 D0 2A       BNE $2A    [$A6E4]     ;/
$90:A6BA 80 08       BRA $08    [$A6C4]

$90:A6BC AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\ Else (facing left):
$90:A6BF C9 7A 00    CMP #$007A             ;} If [Samus pose] != [facing left - morph ball - spring ball - on ground]: go to BRANCH_DECELERATING
$90:A6C2 D0 20       BNE $20    [$A6E4]     ;/

$90:A6C4 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:A6C7 20 B8 92    JSR $92B8  [$90:92B8]  ; Simple Samus Y movement
$90:A6CA B0 23       BCS $23    [$A6EF]     ; If [Samus Y direction] != none: return
$90:A6CC 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A6CF 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A6D3 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A6D6 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A6D9 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A6DC 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A6DF 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:A6E2 80 0B       BRA $0B    [$A6EF]     ; Return

; BRANCH_DECELERATING
$90:A6E4 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A6E7 20 B8 92    JSR $92B8  [$90:92B8]  ; Simple Samus Y movement
$90:A6EA B0 03       BCS $03    [$A6EF]     ; If [Samus Y direction] = none:
$90:A6EC 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations

$90:A6EF 28          PLP
$90:A6F0 60          RTS
}


;;; $A6F1: Samus movement - spring ball - in air ;;;
{
$90:A6F1 08          PHP
$90:A6F2 C2 30       REP #$30
$90:A6F4 AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$90:A6F7 D0 05       BNE $05    [$A6FE]     ;} If not bouncing:
$90:A6F9 20 B3 8F    JSR $8FB3  [$90:8FB3]  ; Samus jumping movement
$90:A6FC 80 03       BRA $03    [$A701]     ; Return

$90:A6FE 20 D1 91    JSR $91D1  [$90:91D1]  ; Samus morphed bouncing movement

$90:A701 28          PLP
$90:A702 60          RTS
}


;;; $A703: Samus movement - spring ball - falling ;;;
{
$90:A703 08          PHP
$90:A704 C2 30       REP #$30
$90:A706 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:A708 89 00 03    BIT #$0300             ;} If not pressing left or right:
$90:A70B D0 18       BNE $18    [$A725]     ;/
$90:A70D AD 4A 0B    LDA $0B4A  [$7E:0B4A]  ;\
$90:A710 D0 13       BNE $13    [$A725]     ;} If [Samus X acceleration mode] = accelerating:
$90:A712 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A716 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A719 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A71C 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A71F 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A722 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating

$90:A725 AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$90:A728 D0 05       BNE $05    [$A72F]     ;} If not bouncing:
$90:A72A 20 9F 91    JSR $919F  [$90:919F]  ; Samus morphed falling movement
$90:A72D 80 03       BRA $03    [$A732]     ; Return

$90:A72F 20 D1 91    JSR $91D1  [$90:91D1]  ; Samus morphed bouncing movement

$90:A732 28          PLP
$90:A733 60          RTS
}


;;; $A734: Samus movement - wall jumping ;;;
{
$90:A734 08          PHP
$90:A735 C2 30       REP #$30
$90:A737 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:A73A C9 17 00    CMP #$0017             ;} If [Samus animation frame] < 17h:
$90:A73D 10 15       BPL $15    [$A754]     ;/
$90:A73F C9 03 00    CMP #$0003             ;\
$90:A742 30 16       BMI $16    [$A75A]     ;} If [Samus animation frame] >= 3:
$90:A744 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:A747 C9 3C 00    CMP #$003C             ;} If [flare counter] >= 3Ch:
$90:A74A 30 0E       BMI $0E    [$A75A]     ;/
$90:A74C A9 04 00    LDA #$0004             ;\
$90:A74F 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = pseudo screw attacking
$90:A752 80 06       BRA $06    [$A75A]

$90:A754 A9 03 00    LDA #$0003             ;\ Else ([Samus animation frame] >= 17h):
$90:A757 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = screw attacking

$90:A75A 20 B3 8F    JSR $8FB3  [$90:8FB3]  ; Samus jumping movement
$90:A75D 28          PLP
$90:A75E 60          RTS
}


;;; $A75F: Samus movement - ran into a wall ;;;
{
$90:A75F 08          PHP
$90:A760 C2 30       REP #$30
$90:A762 20 48 93    JSR $9348  [$90:9348]  ; Move Samus horizontally with zero base X speed
$90:A765 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:A768 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A76C 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A76F 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A772 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:A775 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:A778 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:A77B 20 E9 92    JSR $92E9  [$90:92E9]  ; RTS
$90:A77E 28          PLP
$90:A77F 60          RTS
}


;;; $A780: Samus movement - grappling ;;;
{
$90:A780 08          PHP
$90:A781 C2 30       REP #$30
$90:A783 AD C6 0D    LDA $0DC6  [$7E:0DC6]  ;\
$90:A786 C9 05 00    CMP #$0005             ;} If [Samus solid vertical collision result] != wall jump triggered:
$90:A789 F0 03       BEQ $03    [$A78E]     ;/
$90:A78B 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change

$90:A78E 28          PLP
$90:A78F 60          RTS
}


;;; $A790: Samus movement - turning around - jumping ;;;
{
$90:A790 08          PHP
$90:A791 C2 30       REP #$30
$90:A793 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A796 20 B8 92    JSR $92B8  [$90:92B8]  ; Simple Samus Y movement
$90:A799 B0 03       BCS $03    [$A79E]     ; If [Samus Y direction] = none:
$90:A79B 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations

$90:A79E 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A7A2 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A7A5 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A7A8 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A7AB 28          PLP
$90:A7AC 60          RTS
}


;;; $A7AD: Samus movement - turning around - falling ;;;
{
; Clone of $A790
$90:A7AD 08          PHP
$90:A7AE C2 30       REP #$30
$90:A7B0 20 64 8E    JSR $8E64  [$90:8E64]  ; Samus X movement
$90:A7B3 20 B8 92    JSR $92B8  [$90:92B8]  ; Simple Samus Y movement
$90:A7B6 B0 03       BCS $03    [$A7BB]     ; If [Samus Y direction] = none:
$90:A7B8 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations

$90:A7BB 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:A7BF 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:A7C2 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:A7C5 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A7C8 28          PLP
$90:A7C9 60          RTS
}


;;; $A7CA: Samus movement - damage boost ;;;
{
$90:A7CA 08          PHP
$90:A7CB C2 30       REP #$30
$90:A7CD 20 B3 8F    JSR $8FB3  [$90:8FB3]  ; Samus jumping movement
$90:A7D0 28          PLP
$90:A7D1 60          RTS
}


;;; $A7D2: Samus movement - grabbed by Draygon ;;;
{
$90:A7D2 08          PHP
$90:A7D3 C2 30       REP #$30
$90:A7D5 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A7D8 28          PLP
$90:A7D9 60          RTS
}


;;; $A7DA: Samus movement - shinespark / crystal flash / drained by metroid / damaged by MB's attacks ;;;
{
$90:A7DA 08          PHP
$90:A7DB C2 30       REP #$30
$90:A7DD 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:A7E0 28          PLP
$90:A7E1 60          RTS
}
}


;;; $A7E2..AC1B: Mini-map ;;;
{
;;; $A7E2: Disable mini-map and mark boss room map tiles as explored ;;;
{
$90:A7E2 08          PHP
$90:A7E3 8B          PHB
$90:A7E4 C2 30       REP #$30
$90:A7E6 4B          PHK                    ;\
$90:A7E7 AB          PLB                    ;} DB = $90
$90:A7E8 A9 01 00    LDA #$0001             ;\
$90:A7EB 8D F7 05    STA $05F7  [$7E:05F7]  ;} Disable mini-map
$90:A7EE A9 1F 00    LDA #$001F             ;\
$90:A7F1 09 00 2C    ORA #$2C00             ;|
$90:A7F4 A2 00 00    LDX #$0000             ;|
                                            ;|
$90:A7F7 9F 3C C6 7E STA $7EC63C,x[$7E:C63C];|
$90:A7FB 9F 7C C6 7E STA $7EC67C,x[$7E:C67C];} HUD tilemap (1Ah..1Eh, 1..3) = 2C1Fh
$90:A7FF 9F BC C6 7E STA $7EC6BC,x[$7E:C6BC];|
$90:A803 E8          INX                    ;|
$90:A804 E8          INX                    ;|
$90:A805 E0 0A 00    CPX #$000A             ;|
$90:A808 30 ED       BMI $ED    [$A7F7]     ;/
$90:A80A AD 9C 17    LDA $179C  [$7E:179C]  ; A = [boss ID]
$90:A80D A2 14 00    LDX #$0014             ; X = 14h

; LOOP_BOSS_ID
$90:A810 DD 3A A8    CMP $A83A,x[$90:A84E]  ;\
$90:A813 F0 09       BEQ $09    [$A81E]     ;} If [$A83A + [X]] != [boss ID]:
$90:A815 CA          DEX                    ;\
$90:A816 CA          DEX                    ;|
$90:A817 CA          DEX                    ;} X -= 4
$90:A818 CA          DEX                    ;/
$90:A819 10 F5       BPL $F5    [$A810]     ; If [X] >= 0: go to LOOP_BOSS_ID
$90:A81B AB          PLB
$90:A81C 28          PLP
$90:A81D 6B          RTL                    ; Return

$90:A81E BD 3C A8    LDA $A83C,x[$90:A83C]  ;\
$90:A821 AA          TAX                    ;} X = [$A83A + [X] + 2]

; LOOP_MAP_TILES
$90:A822 BD 00 00    LDA $0000,x[$90:A852]  ;\
$90:A825 30 10       BMI $10    [$A837]     ;} If [[X]] >= 0:
$90:A827 85 12       STA $12    [$7E:0012]  ; $12 = [[X]]
$90:A829 BD 02 00    LDA $0002,x[$90:A854]  ;\
$90:A82C 85 18       STA $18    [$7E:0018]  ;} $18 = [[X] + 2]
$90:A82E 20 A6 A8    JSR $A8A6  [$90:A8A6]  ; Mark map tile as explored
$90:A831 E8          INX                    ;\
$90:A832 E8          INX                    ;|
$90:A833 E8          INX                    ;} X += 4
$90:A834 E8          INX                    ;/
$90:A835 80 EB       BRA $EB    [$A822]     ; Go to LOOP_MAP_TILES

$90:A837 AB          PLB
$90:A838 28          PLP
$90:A839 6B          RTL

;                        ________ Boss ID
;                       |     ___ Pointer to room map tile offsets
;                       |    |
$90:A83A             dw 0003,A852,
                        0006,A864,
                        0007,A872,
                        0008,A878,
                        000A,A88A,
                        0005,A89C

;                        ________ X offset (in pixels)
;                       |     ___ Y offset (in pixels)
;                       |    |
; Kraid
$90:A852             dw 0000,0000,
                        0100,0000,
                        0000,0100,
                        0100,0100,
                        FFFF

; Crocomire
$90:A864             dw 0300,0000,
                        0400,0000,
                        0500,0000,
                        FFFF

; Phantoon
$90:A872             dw 0000,0000,
                        FFFF

; Draygon
$90:A878             dw 0000,0000,
                        0100,0000,
                        0000,0100,
                        0100,0100,
                        FFFF

; Mother Brain
$90:A88A             dw 0000,0000,
                        0100,0000,
                        0200,0000,
                        0300,0000,
                        FFFF

; Ridley
$90:A89C             dw 0000,0000,
                        0000,0100,
                        FFFF
}


;;; $A8A6: Mark map tile as explored ;;;
{
;; Parameters:
;;     $12: X offset of map tile in room. Unit px
;;     $18: Y offset of map tile in room. Unit px

; Set tiles explored for current area, used only for marking boss room map tiles as explored
; The first row is skipped during index calculation, that is, room (0, 0) maps to $07FB rather than $07F7

; From RAM map, $07F7..08F6:
;     Map tiles explored (for current area). One bit per room.
;     Laid out like a 64x32 1bpp VRAM tilemap:
;         2x1 pages of 32x32 map tiles (80h bytes per page, 4 bytes per row, 1 bit per tile),
;         each byte is 8 map tiles where the most significant bit is the leftmost tile.

; Let
;     x = [room X co-ordinate] + [$12] / 100h
;     y = [room Y co-ordinate] + [$18] / 100h
; Then
;     $07FB + (y + (x & 20h)) * 4 + (x & 1Fh) / 8 |= 80h >> (x & 7)

$90:A8A6 08          PHP
$90:A8A7 DA          PHX
$90:A8A8 5A          PHY
$90:A8A9 A5 12       LDA $12    [$7E:0012]  ;\
$90:A8AB 29 00 FF    AND #$FF00             ;|
$90:A8AE EB          XBA                    ;|
$90:A8AF 18          CLC                    ;|
$90:A8B0 6D A1 07    ADC $07A1  [$7E:07A1]  ;} $22 = [room X co-ordinate] + [$12] / 100h & 20h (map page)
$90:A8B3 48          PHA                    ;|
$90:A8B4 29 20 00    AND #$0020             ;|
$90:A8B7 85 22       STA $22    [$7E:0022]  ;/
$90:A8B9 68          PLA                    ;\
$90:A8BA 29 1F 00    AND #$001F             ;|
$90:A8BD 85 12       STA $12    [$7E:0012]  ;} Y = [room X co-ordinate] + [$12] / 100h & 7 (bit subindex of column)
$90:A8BF 29 07 00    AND #$0007             ;|
$90:A8C2 A8          TAY                    ;/
$90:A8C3 A5 12       LDA $12    [$7E:0012]  ;\
$90:A8C5 4A          LSR A                  ;|
$90:A8C6 4A          LSR A                  ;} $14 = ([room X co-ordinate] + [$12] / 100h & 1Fh) / 8 (byte index of column)
$90:A8C7 4A          LSR A                  ;|
$90:A8C8 85 14       STA $14    [$7E:0014]  ;/
$90:A8CA A5 18       LDA $18    [$7E:0018]  ;\
$90:A8CC 29 00 FF    AND #$FF00             ;|
$90:A8CF EB          XBA                    ;|
$90:A8D0 18          CLC                    ;} $16 = [room Y co-ordinate] + [$18] / 100h + 1 (index of row + 1)
$90:A8D1 6D A3 07    ADC $07A3  [$7E:07A3]  ;|
$90:A8D4 1A          INC A                  ;|
$90:A8D5 85 16       STA $16    [$7E:0016]  ;/
$90:A8D7 18          CLC                    ;\
$90:A8D8 65 22       ADC $22    [$7E:0022]  ;|
$90:A8DA 0A          ASL A                  ;|
$90:A8DB 0A          ASL A                  ;} X = ([$16] + [$22]) * 4 + [$14] (byte index of map co-ordinate)
$90:A8DC 18          CLC                    ;|
$90:A8DD 65 14       ADC $14    [$7E:0014]  ;|
$90:A8DF AA          TAX                    ;/
$90:A8E0 E2 20       SEP #$20               ;\
$90:A8E2 BD F7 07    LDA $07F7,x[$7E:08C5]  ;|
$90:A8E5 19 04 AC    ORA $AC04,y[$90:AC0B]  ;} $07F7 + [X] |= 80h >> [Y]
$90:A8E8 9D F7 07    STA $07F7,x[$7E:08C5]  ;/
$90:A8EB 7A          PLY
$90:A8EC FA          PLX
$90:A8ED 28          PLP
$90:A8EE 60          RTS
}


;;; $A8EF: Initialise mini-map (broken) ;;;
{
; Called by:
;     $9A79: Initialise HUD

; This function isn't setting the variables needed for the call to $AA43 and otherwise is unnecessary
$90:A8EF 08          PHP
$90:A8F0 C2 30       REP #$30
$90:A8F2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:A8F5 29 00 FF    AND #$FF00             ;|
$90:A8F8 EB          XBA                    ;|
$90:A8F9 18          CLC                    ;} $12 = [room X co-ordinate] + [Samus X position] / 100h
$90:A8FA 6D A1 07    ADC $07A1  [$7E:07A1]  ;|
$90:A8FD AA          TAX                    ;|
$90:A8FE 85 12       STA $12    [$7E:0012]  ;/
$90:A900 29 07 00    AND #$0007             ;\
$90:A903 A8          TAY                    ;} Y = [$12] & 7 (bit subindex of column)
$90:A904 8A          TXA                    ;\
$90:A905 4A          LSR A                  ;|
$90:A906 4A          LSR A                  ;} $14 = [$12] / 8 (byte index of column)
$90:A907 4A          LSR A                  ;|
$90:A908 85 14       STA $14    [$7E:0014]  ;/
$90:A90A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:A90D 29 00 FF    AND #$FF00             ;|
$90:A910 EB          XBA                    ;|
$90:A911 18          CLC                    ;} $16 = [room Y co-ordinate] + [Samus Y position] / 100h + 1 (index of row + 1)
$90:A912 6D A3 07    ADC $07A3  [$7E:07A3]  ;|
$90:A915 1A          INC A                  ;|
$90:A916 85 16       STA $16    [$7E:0016]  ;/
$90:A918 4C 43 AA    JMP $AA43  [$90:AA43]  ; Go to update HUD mini-map tilemap
}


;;; $A91B: Update mini-map ;;;
{
; Direct page usage:
;     $09: Mini-map origin map data pointer ($82:0000 + [$0F] + [$32/$30])
;     $0F: Area map data pointer ([$82:9717 + [area index] * 2])
;     $12: Samus map X co-ordinate ([room X co-ordinate] + [Samus X position] / 100h)
;     $14: Byte index of Samus map column (([room X co-ordinate] + [Samus X position] / 100h & 1Fh) / 8)
;     $16: Index of Samus map row ([room Y co-ordinate] + [Samus Y position] / 100h + 1)
;     $18: Explored row 0 map bits (([$07F7 + [$32/$30]]     << 8 | [$07F7 + [$32/$30] + 1]) & FC00h >> [$34] / 2)
;     $1A: Explored row 1 map bits (([$07F7 + [$32/$30] + 4] << 8 | [$07F7 + [$32/$30] + 5]) & FC00h >> [$34] / 2)
;     $1C: Explored row 2 map bits (([$07F7 + [$32/$30] + 8] << 8 | [$07F7 + [$32/$30] + 9]) & FC00h >> [$34] / 2)
;     $1E: Byte index of Samus map co-ordinate (([$16] + [$22]) * 4 + [$14])
;     $20: Bit subindex of column of Samus map position ([room X co-ordinate] + [Samus X position] / 100h & 7)
;     $22: Map page of Samus position ([room X co-ordinate] + [Samus X position] / 100h & 20h)
;     $26: Row 0 map bits ([[$09]] << 8     | [[$09] + 1])
;     $28: Row 1 map bits ([[$09] + 4] << 8 | [[$09] + 5])
;     $2A: Row 2 map bits ([[$09] + 8] << 8 | [[$09] + 9])
;     $2C: Spilt explored row map bits ([$07F7 + [$30] + 0/4/8])
;     $2D: Spilt row map bits ([[$09] + 0/4/8])
;     $2E: Flag that Samus map position is in a different byte than the mini-map origin ([$20] < 2)
;     $30: Byte index of spilt map bits (if [$22] = 0 then [$32] + 7Dh else [$32] - 7Ch)
;     $32: Byte index of map co-ordinate of mini-map origin ([$1E] - 4 - [$2E])
;     $34: Bit subindex of column of mini-map origin * 2 (([$20] - 2 & 7) * 2)

; From RAM map, $07F7..08F6:
;     Map tiles explored (for current area). One bit per room.
;     Laid out like a 64x32 1bpp VRAM tilemap:
;         2x1 pages of 32x32 map tiles (80h bytes per page, 4 bytes per row, 1 bit per tile),
;         each byte is 8 map tiles where the most significant bit is the leftmost tile.
;     The first row is padding and skipped during index calculation,
;     that is, room (0, 0) maps to $07FB rather than $07F7.

$90:A91B 08          PHP
$90:A91C C2 30       REP #$30
$90:A91E AD F7 05    LDA $05F7  [$7E:05F7]  ;\
$90:A921 F0 02       BEQ $02    [$A925]     ;} If mini-map disabled:
$90:A923 28          PLP
$90:A924 6B          RTL                    ; Return

$90:A925 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:A928 4A          LSR A                  ;|
$90:A929 4A          LSR A                  ;|
$90:A92A 4A          LSR A                  ;} If [Samus X position] / 10h >= [room width]:
$90:A92B 4A          LSR A                  ;|
$90:A92C CD A5 07    CMP $07A5  [$7E:07A5]  ;|
$90:A92F 90 02       BCC $02    [$A933]     ;/
$90:A931 28          PLP
$90:A932 6B          RTL                    ; Return

$90:A933 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:A936 4A          LSR A                  ;|
$90:A937 4A          LSR A                  ;|
$90:A938 4A          LSR A                  ;} If [Samus Y position] / 10h >= [room height]:
$90:A939 4A          LSR A                  ;|
$90:A93A CD A7 07    CMP $07A7  [$7E:07A7]  ;|
$90:A93D 90 02       BCC $02    [$A941]     ;/
$90:A93F 28          PLP
$90:A940 6B          RTL                    ; Return

$90:A941 64 2E       STZ $2E    [$7E:002E]  ; $2E = 0
$90:A943 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:A946 29 00 FF    AND #$FF00             ;|
$90:A949 EB          XBA                    ;|
$90:A94A 18          CLC                    ;|
$90:A94B 6D A1 07    ADC $07A1  [$7E:07A1]  ;} $22 = [room X co-ordinate] + [Samus X position] / 100h & 20h (map page of Samus position)
$90:A94E 48          PHA                    ;|
$90:A94F 29 20 00    AND #$0020             ;|
$90:A952 85 22       STA $22    [$7E:0022]  ;/
$90:A954 68          PLA                    ;\
$90:A955 29 1F 00    AND #$001F             ;} $12 = [room X co-ordinate] + [Samus X position] / 100h (Samus map X co-ordinate)
$90:A958 85 12       STA $12    [$7E:0012]  ;/
$90:A95A 29 07 00    AND #$0007             ;\
$90:A95D A8          TAY                    ;} Y = [room X co-ordinate] + [Samus X position] / 100h & 7 (bit subindex of Samus map column)
$90:A95E A5 12       LDA $12    [$7E:0012]  ;\
$90:A960 4A          LSR A                  ;|
$90:A961 4A          LSR A                  ;} $14 = ([room X co-ordinate] + [Samus X position] / 100h & 1Fh) / 8 (byte index of Samus map column)
$90:A962 4A          LSR A                  ;|
$90:A963 85 14       STA $14    [$7E:0014]  ;/
$90:A965 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:A968 29 00 FF    AND #$FF00             ;|
$90:A96B EB          XBA                    ;|
$90:A96C 18          CLC                    ;} $16 = [room Y co-ordinate] + [Samus Y position] / 100h + 1 (index of Samus map row)
$90:A96D 6D A3 07    ADC $07A3  [$7E:07A3]  ;|
$90:A970 1A          INC A                  ;|
$90:A971 85 16       STA $16    [$7E:0016]  ;/
$90:A973 18          CLC                    ;\
$90:A974 65 22       ADC $22    [$7E:0022]  ;|
$90:A976 0A          ASL A                  ;|
$90:A977 0A          ASL A                  ;} X = ([$16] + [$22]) * 4 + [$14] (byte index of Samus map co-ordinate)
$90:A978 18          CLC                    ;|
$90:A979 65 14       ADC $14    [$7E:0014]  ;|
$90:A97B AA          TAX                    ;/
$90:A97C E2 20       SEP #$20               ;\
$90:A97E BD F7 07    LDA $07F7,x[$7E:0830]  ;|
$90:A981 19 04 AC    ORA $AC04,y[$90:AC08]  ;} $07F7 + [X] |= 80h >> [Y] (mark Samus map tile as explored)
$90:A984 9D F7 07    STA $07F7,x[$7E:0830]  ;/
$90:A987 84 20       STY $20    [$7E:0020]  ; $20 = [Y] (bit subindex of column of Samus map position)
$90:A989 86 1E       STX $1E    [$7E:001E]  ; $1E = [X] (byte index of map co-ordinate of Samus map position)
$90:A98B C2 30       REP #$30
$90:A98D CA          DEX                    ;\
$90:A98E CA          DEX                    ;|
$90:A98F CA          DEX                    ;} X -= 4 (adjust byte index to one row up)
$90:A990 CA          DEX                    ;/
$90:A991 98          TYA                    ;\
$90:A992 3A          DEC A                  ;} Y -= 2 (adjust bit subindex to two columns left)
$90:A993 3A          DEC A                  ;/
$90:A994 10 06       BPL $06    [$A99C]     ; If [Y] < 0: (adjust index/subindex if needed)
$90:A996 29 07 00    AND #$0007             ; Y %= 8
$90:A999 CA          DEX                    ; Decrement X
$90:A99A E6 2E       INC $2E    [$7E:002E]  ; $2E = 1

$90:A99C 0A          ASL A                  ;\
$90:A99D A8          TAY                    ;} Y *= 2
$90:A99E 86 32       STX $32    [$7E:0032]  ; $32 = [X] (byte index of map co-ordinate of mini-map origin)
$90:A9A0 84 34       STY $34    [$7E:0034]  ; $34 = [Y] (bit subindex of column of mini-map origin * 2)
$90:A9A2 BD F7 07    LDA $07F7,x[$7E:082C]  ;\
$90:A9A5 EB          XBA                    ;|
$90:A9A6 39 0C AC    AND $AC0C,y[$90:AC10]  ;} $18 = ([$07F7 + [X]] << 8 | [$07F7 + [X] + 1]) & FC00h >> [Y] / 2 (explored row 0 map bits)
$90:A9A9 85 18       STA $18    [$7E:0018]  ;/
$90:A9AB BD FB 07    LDA $07FB,x[$7E:0830]  ;\
$90:A9AE EB          XBA                    ;|
$90:A9AF 39 0C AC    AND $AC0C,y[$90:AC10]  ;} $1A = ([$07F7 + [X] + 4] << 8 | [$07F7 + [X] + 5]) & FC00h >> [Y] / 2 (explored row 1 map bits)
$90:A9B2 85 1A       STA $1A    [$7E:001A]  ;/
$90:A9B4 BD FF 07    LDA $07FF,x[$7E:0834]  ;\
$90:A9B7 EB          XBA                    ;|
$90:A9B8 39 0C AC    AND $AC0C,y[$90:AC10]  ;} $1C = ([$07F7 + [X] + 8] << 8 | [$07F7 + [X] + 9]) & FC00h >> [Y] / 2 (explored row 1 map bits)
$90:A9BB 85 1C       STA $1C    [$7E:001C]  ;/
$90:A9BD DA          PHX                    ;\
$90:A9BE AD 9F 07    LDA $079F  [$7E:079F]  ;|
$90:A9C1 0A          ASL A                  ;|
$90:A9C2 AA          TAX                    ;|
$90:A9C3 A9 82 00    LDA #$0082             ;} $09 = $82:0000 + [$82:9717 + [area index] * 2]
$90:A9C6 85 0B       STA $0B    [$7E:000B]  ;|
$90:A9C8 BF 17 97 82 LDA $829717,x[$82:9723];|
$90:A9CC 85 09       STA $09    [$7E:0009]  ;/
$90:A9CE 85 0F       STA $0F    [$7E:000F]  ; $0F = [$82:9717 + [area index] * 2]
$90:A9D0 68          PLA                    ;\
$90:A9D1 18          CLC                    ;|
$90:A9D2 65 09       ADC $09    [$7E:0009]  ;} $09 += [X]
$90:A9D4 85 09       STA $09    [$7E:0009]  ;/
$90:A9D6 A7 09       LDA [$09]  [$82:9D5C]  ;\
$90:A9D8 EB          XBA                    ;} $26 = [[$09]] << 8 | [[$09] + 1] (row 0 map bits)
$90:A9D9 85 26       STA $26    [$7E:0026]  ;/
$90:A9DB A5 09       LDA $09    [$7E:0009]  ;\
$90:A9DD 18          CLC                    ;|
$90:A9DE 69 04 00    ADC #$0004             ;|
$90:A9E1 85 09       STA $09    [$7E:0009]  ;} $28 = [[$09] + 4] << 8 | [[$09] + 5] (row 1 map bits)
$90:A9E3 A7 09       LDA [$09]  [$82:9D60]  ;|
$90:A9E5 EB          XBA                    ;|
$90:A9E6 85 28       STA $28    [$7E:0028]  ;/
$90:A9E8 A5 09       LDA $09    [$7E:0009]  ;\
$90:A9EA 18          CLC                    ;|
$90:A9EB 69 04 00    ADC #$0004             ;|
$90:A9EE 85 09       STA $09    [$7E:0009]  ;} $2A = [[$09] + 8] << 8 | [[$09] + 9] (row 2 map bits)
$90:A9F0 A7 09       LDA [$09]  [$82:9D64]  ;|
$90:A9F2 EB          XBA                    ;|
$90:A9F3 85 2A       STA $2A    [$7E:002A]  ;/
$90:A9F5 A6 32       LDX $32    [$7E:0032]  ; X = [$32] (byte index of map co-ordinate of mini-map origin)
$90:A9F7 A4 34       LDY $34    [$7E:0034]  ; Y = [$34] (bit subindex of column of mini-map origin * 2)
$90:A9F9 8A          TXA                    ;\
$90:A9FA 29 03 00    AND #$0003             ;|
$90:A9FD C9 03 00    CMP #$0003             ;} If [X] % 4 != 3: go to BRANCH_SINGLE_PAGE (if [X] = 3, then mini-map origin is within 8 squares of the right page boundary)
$90:AA00 D0 2A       BNE $2A    [$AA2C]     ;/

; If [X] % 4 == 3 then mini-map origin is within last 8 tiles of the row.
; If the mini-map origin is on the same page as Samus map position,
; then there's a chance that at least one of the two tiles right of Samus map position spilled onto the next map page.
; If the mini-map origin is on a different page to Samus map position,
; then at least one of the two tiles left of Samus map position spilled onto the previous map page.

; If the spilt map bits were from the next page,
; then their real address is given by subtracting 3 from [X] to get back to the start of the row,
; and then adding 80h to get to same position in the next page.
; If the spilt map bits were from the previous page,
; then their real address is given by adding 4 to [X] to get to the end of the row that the non-spilt bits are on,
; then subtracting 80h to get to the same position in the previous page.

$90:AA02 A5 2E       LDA $2E    [$7E:002E]  ;\
$90:AA04 F0 04       BEQ $04    [$AA0A]     ;} If [$2E] != 0: (Samus map position is in a different map data byte than the mini-map origin)
$90:AA06 98          TYA                    ;\
$90:AA07 4A          LSR A                  ;} A = [Y] / 2 (bit subindex of column of mini-map origin) (necessarily 6 or 7)
$90:AA08 80 02       BRA $02    [$AA0C]
                                            ; Else ([$2E] = 0): (Samus map position in the same map data byte as the origin)
$90:AA0A A5 20       LDA $20    [$7E:0020]  ; A = [$20] (bit subindex of column of Samus map position) (if 0..5, then the right-most mini-map tile is on the same page)

$90:AA0C C9 06 00    CMP #$0006             ;\
$90:AA0F 30 1B       BMI $1B    [$AA2C]     ;} If [A] < 6: go to BRANCH_SINGLE_PAGE
$90:AA11 A5 22       LDA $22    [$7E:0022]  ;\
$90:AA13 D0 0A       BNE $0A    [$AA1F]     ;} If [$22] = 0: (map page of Samus position)
$90:AA15 E2 20       SEP #$20               ;\
$90:AA17 8A          TXA                    ;|
$90:AA18 18          CLC                    ;} $30 = [X] + 80h - 3 (byte index of spilt map bits)
$90:AA19 69 7D       ADC #$7D               ;|
$90:AA1B 85 30       STA $30    [$7E:0030]  ;/
$90:AA1D 80 08       BRA $08    [$AA27]

$90:AA1F E2 20       SEP #$20               ;\ Else ([$22] != 0):
$90:AA21 8A          TXA                    ;|
$90:AA22 38          SEC                    ;} $30 = [X] - 80h + 4 (byte index of spilt map bits)
$90:AA23 E9 7C       SBC #$7C               ;|
$90:AA25 85 30       STA $30    [$7E:0030]  ;/

$90:AA27 C2 30       REP #$30
$90:AA29 20 75 AB    JSR $AB75  [$90:AB75]  ; Adjust map bits for map page spill

; BRANCH_SINGLE_PAGE
$90:AA2C A5 34       LDA $34    [$7E:0034]  ;\
$90:AA2E 4A          LSR A                  ;|
$90:AA2F C9 00 00    CMP #$0000             ;| Shift left the row map bits variables so that 8000h represents the left-most map bit
                                            ;|
$90:AA32 F0 0F       BEQ $0F    [$AA43]     ;|
$90:AA34 06 18       ASL $18    [$7E:0018]  ;} $18 <<= [$34] / 2 (explored row 0 map bits)
$90:AA36 06 26       ASL $26    [$7E:0026]  ;} $26 <<= [$34] / 2 (row 0 map bits)
$90:AA38 06 1A       ASL $1A    [$7E:001A]  ;} $1A <<= [$34] / 2 (explored row 1 map bits)
$90:AA3A 06 28       ASL $28    [$7E:0028]  ;} $28 <<= [$34] / 2 (row 1 map bits)
$90:AA3C 06 1C       ASL $1C    [$7E:001C]  ;} $1C <<= [$34] / 2 (explored row 2 map bits)
$90:AA3E 06 2A       ASL $2A    [$7E:002A]  ;} $2A <<= [$34] / 2 (row 2 map bits)
$90:AA40 3A          DEC A                  ;|
$90:AA41 80 EF       BRA $EF    [$AA32]     ;/
}


;;; $AA43: Update HUD mini-map tilemap ;;;
{
;; Parameters:
;;     $12: Samus map X co-ordinate ([room X co-ordinate] + [Samus X position] / 100h)
;;     $16: Index of Samus map row ([room Y co-ordinate] + [Samus Y position] / 100h + 1)
;;     $18: Explored row 0 map bits (([$07F7 + [$32/$30]]     << 8 | [$07F7 + [$32/$30] + 1]) << [$34] / 2 & FC00h)
;;     $1A: Explored row 1 map bits (([$07F7 + [$32/$30] + 4] << 8 | [$07F7 + [$32/$30] + 5]) << [$34] / 2 & FC00h)
;;     $1C: Explored row 2 map bits (([$07F7 + [$32/$30] + 8] << 8 | [$07F7 + [$32/$30] + 9]) << [$34] / 2 & FC00h)
;;     $22: Map page of Samus position ([room X co-ordinate] + [Samus X position] / 100h & 20h)
;;     $26: Row 0 map bits ([[$09]] << 8     | [[$09] + 1]) << [$34] / 2
;;     $28: Row 1 map bits ([[$09] + 4] << 8 | [[$09] + 5]) << [$34] / 2
;;     $2A: Row 2 map bits ([[$09] + 8] << 8 | [[$09] + 9]) << [$34] / 2

$90:AA43 A5 16       LDA $16    [$7E:0016]  ;\
$90:AA45 18          CLC                    ;|
$90:AA46 65 22       ADC $22    [$7E:0022]  ;|
$90:AA48 EB          XBA                    ;|
$90:AA49 4A          LSR A                  ;|
$90:AA4A 4A          LSR A                  ;} $060B = ([$16] + [$22]) * 20h + [$12] (bit index of Samus map co-ordinate)
$90:AA4B 4A          LSR A                  ;|
$90:AA4C 18          CLC                    ;|
$90:AA4D 65 12       ADC $12    [$7E:0012]  ;|
$90:AA4F 8D 0B 06    STA $060B  [$7E:060B]  ;/
$90:AA52 A5 22       LDA $22    [$7E:0022]  ;\
$90:AA54 F0 14       BEQ $14    [$AA6A]     ;} If [$22] != 0: (Samus position is on right map page)
$90:AA56 AD 0B 06    LDA $060B  [$7E:060B]  ;\
$90:AA59 29 1F 00    AND #$001F             ;|
$90:AA5C C9 02 00    CMP #$0002             ;} If [$060B] & 1Fh < 2: (spilt onto left map page)
$90:AA5F 10 09       BPL $09    [$AA6A]     ;/
$90:AA61 AD 0B 06    LDA $060B  [$7E:060B]  ;\
$90:AA64 38          SEC                    ;} A = [$060B] - 20h - 2 + 20h - 400h (bit index of map origin) (one row up, two tiles left, one row down to account for wrapping, one page left)
$90:AA65 E9 02 04    SBC #$0402             ;/
$90:AA68 80 07       BRA $07    [$AA71]

$90:AA6A AD 0B 06    LDA $060B  [$7E:060B]  ;\ Else ([$22] = 0 or [$060B] & 1Fh >= 2): (didn't spill onto left map page)
$90:AA6D 38          SEC                    ;} A = [$060B] - 20h - 2 (bit index of map origin) (one row up, two tiles left)
$90:AA6E E9 22 00    SBC #$0022             ;/

$90:AA71 0A          ASL A                  ;\
$90:AA72 A8          TAY                    ;} Y = [A] * 2 (map tilemap index)
$90:AA73 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$90:AA76 0A          ASL A                  ;|
$90:AA77 18          CLC                    ;|
$90:AA78 6D 9F 07    ADC $079F  [$7E:079F]  ;|
$90:AA7B AA          TAX                    ;|
$90:AA7C BF 4C 96 82 LDA $82964C,x[$82:965E];|
$90:AA80 85 02       STA $02    [$7E:0002]  ;|
$90:AA82 85 05       STA $05    [$7E:0005]  ;} $00 = [$82:964A + [area index] * 3] (map tilemap row 0 pointer)
$90:AA84 85 08       STA $08    [$7E:0008]  ;} $03 = [$82:964A + [area index] * 3] + 40h (map tilemap row 1 pointer)
$90:AA86 BF 4A 96 82 LDA $82964A,x[$82:965C];} $06 = [$82:964A + [area index] * 3] + 80h (map tilemap row 2 pointer)
$90:AA8A 85 00       STA $00    [$7E:0000]  ;|
$90:AA8C 18          CLC                    ;|
$90:AA8D 69 40 00    ADC #$0040             ;|
$90:AA90 85 03       STA $03    [$7E:0003]  ;|
$90:AA92 18          CLC                    ;|
$90:AA93 69 40 00    ADC #$0040             ;|
$90:AA96 85 06       STA $06    [$7E:0006]  ;/
$90:AA98 A9 05 00    LDA #$0005             ;\
$90:AA9B 85 12       STA $12    [$7E:0012]  ;} $12 = 5 (map columns remaining)
$90:AA9D A2 00 00    LDX #$0000             ; X = 0 (HUD mini-map tilemap index)
$90:AAA0 AD 89 07    LDA $0789  [$7E:0789]
$90:AAA3 08          PHP

; LOOP
$90:AAA4 06 26       ASL $26    [$7E:0026]  ; $26 <<= 1 (row 0 map bits)
$90:AAA6 90 06       BCC $06    [$AAAE]     ; If shifted a bit out:
$90:AAA8 B7 00       LDA [$00],y[$B5:E358]  ; A = [[$00] + [Y]] (map tilemap row 0 tile)
$90:AAAA 28          PLP                    ;\
$90:AAAB 08          PHP                    ;} If current area's map has been collected: go to BRANCH_ROW_0_NOT_BLANK
$90:AAAC D0 03       BNE $03    [$AAB1]     ;/

$90:AAAE A9 1F 00    LDA #$001F             ; A = 1Fh (blank tile)

; BRANCH_ROW_0_NOT_BLANK
$90:AAB1 29 FF E3    AND #$E3FF             ;\
$90:AAB4 09 00 2C    ORA #$2C00             ;} $7E:C63C + [X] = [A] & E3FFh | 2C00h (write tile to HUD tilemap with priority enabled and palette 3)
$90:AAB7 9F 3C C6 7E STA $7EC63C,x[$7E:C63C];/
$90:AABB 06 18       ASL $18    [$7E:0018]  ; $18 <<= 1 (explored row 0 map bits)
$90:AABD 90 0C       BCC $0C    [$AACB]     ; If shifted a bit out:
$90:AABF B7 00       LDA [$00],y[$B5:E354]  ;\
$90:AAC1 29 FF E3    AND #$E3FF             ;|
$90:AAC4 09 00 28    ORA #$2800             ;} $7E:C63C + [X] = [[$00] + [Y]] & E3FFh | 2800h (write tile to HUD tilemap with priority enabled and palette 2)
$90:AAC7 9F 3C C6 7E STA $7EC63C,x[$7E:C63C];/

$90:AACB 06 28       ASL $28    [$7E:0028]  ; $28 <<= 1 (row 1 map bits)
$90:AACD 90 06       BCC $06    [$AAD5]     ; If shifted a bit out:
$90:AACF B7 03       LDA [$03],y[$B5:E398]  ; A = [[$03] + [Y]] (map tilemap row 1 tile)
$90:AAD1 28          PLP                    ;\
$90:AAD2 08          PHP                    ;} If current area's map has been collected: go to BRANCH_ROW_1_NOT_BLANK
$90:AAD3 D0 03       BNE $03    [$AAD8]     ;/

$90:AAD5 A9 1F 00    LDA #$001F             ; A = 1Fh (blank tile)

; BRANCH_ROW_1_NOT_BLANK
$90:AAD8 29 FF E3    AND #$E3FF             ;\
$90:AADB 09 00 2C    ORA #$2C00             ;} $7E:C67C + [X] = [A] & E3FFh | 2C00h (write tile to HUD tilemap with priority enabled and palette 3)
$90:AADE 9F 7C C6 7E STA $7EC67C,x[$7E:C67C];/
$90:AAE2 06 1A       ASL $1A    [$7E:001A]  ; $1A <<= 1 (explored row 1 map bits)
$90:AAE4 90 22       BCC $22    [$AB08]     ; If shifted a bit out:
$90:AAE6 B7 03       LDA [$03],y[$B5:E398]  ;\
$90:AAE8 29 FF E3    AND #$E3FF             ;|
$90:AAEB 09 00 28    ORA #$2800             ;} $7E:C67C + [[$03] + [Y]] = [A] & E3FFh | 2800h (write tile to HUD tilemap with priority enabled and palette 2)
$90:AAEE 9F 7C C6 7E STA $7EC67C,x[$7E:C680];/
$90:AAF2 A5 12       LDA $12    [$7E:0012]  ;\
$90:AAF4 C9 03 00    CMP #$0003             ;} If [$12] = 3: (Samus map tile)
$90:AAF7 D0 0F       BNE $0F    [$AB08]     ;/
$90:AAF9 BF 7C C6 7E LDA $7EC67C,x[$7E:C680];\
$90:AAFD 29 FF 01    AND #$01FF             ;|
$90:AB00 C9 28 00    CMP #$0028             ;} If [$7E:C67C + [X]] & 1FFh = 28h: (used in a couple places in Crateria/Norfair diagonal room)
$90:AB03 D0 03       BNE $03    [$AB08]     ;/
$90:AB05 20 5F AB    JSR $AB5F  [$90:AB5F]  ; Mark map tile above Samus as explored

$90:AB08 06 2A       ASL $2A    [$7E:002A]  ; $2A <<= 1 (row 2 map bits)
$90:AB0A 90 06       BCC $06    [$AB12]     ; If shifted a bit out:
$90:AB0C B7 06       LDA [$06],y[$B5:E3D8]  ; A = [[$06] + [Y]] (map tilemap row 2 tile)
$90:AB0E 28          PLP                    ;\
$90:AB0F 08          PHP                    ;} If current area's map has been collected: go to BRANCH_ROW_2_NOT_BLANK
$90:AB10 D0 03       BNE $03    [$AB15]     ;/

$90:AB12 A9 1F 00    LDA #$001F             ; A = 1Fh (blank tile)

; BRANCH_ROW_2_NOT_BLANK
$90:AB15 29 FF E3    AND #$E3FF             ;\
$90:AB18 09 00 2C    ORA #$2C00             ;} $7E:C6BC + [X] = [A] & E3FFh | 2C00h (write tile to HUD tilemap with priority enabled and palette 3)
$90:AB1B 9F BC C6 7E STA $7EC6BC,x[$7E:C6BC];/
$90:AB1F 06 1C       ASL $1C    [$7E:001C]  ; $1C <<= 1 (explored row 2 map bits)
$90:AB21 90 0C       BCC $0C    [$AB2F]     ; If shifted a bit out:
$90:AB23 B7 06       LDA [$06],y[$B5:E3D4]  ;\
$90:AB25 29 FF E3    AND #$E3FF             ;|
$90:AB28 09 00 28    ORA #$2800             ;} $7E:C6BC + [[$06] + [Y]] = [A] & E3FFh | 2800h (write tile to HUD tilemap with priority enabled and palette 2)
$90:AB2B 9F BC C6 7E STA $7EC6BC,x[$7E:C6BC];/

$90:AB2F E8          INX                    ;\
$90:AB30 E8          INX                    ;} X += 2 (HUD mini-map tilemap index)
$90:AB31 C8          INY                    ;\
$90:AB32 C8          INY                    ;} Y += 2 (map tilemap index)
$90:AB33 98          TYA                    ;\
$90:AB34 29 3F 00    AND #$003F             ;|
$90:AB37 C9 00 00    CMP #$0000             ;} If [Y] & 3Fh = 0: (reached end of row)
$90:AB3A D0 06       BNE $06    [$AB42]     ;/
$90:AB3C 98          TYA                    ;\
$90:AB3D 18          CLC                    ;|
$90:AB3E 69 C0 07    ADC #$07C0             ;} Y += 800h - 40h (move to start of row on next page)
$90:AB41 A8          TAY                    ;/

$90:AB42 C6 12       DEC $12    [$7E:0012]  ; Decrement $12 (map columns remaining)
$90:AB44 F0 03       BEQ $03    [$AB49]     ; If [$12] != 0:
$90:AB46 4C A4 AA    JMP $AAA4  [$90:AAA4]  ; Go to LOOP

; Note that the 8-bit frame counter used here is set to 0 by door transition,
; which usually causes the flash cycle to reset
$90:AB49 28          PLP
$90:AB4A AD B5 05    LDA $05B5  [$7E:05B5]  ;\
$90:AB4D 29 08 00    AND #$0008             ;} If [8-bit frame counter] & 8 = 0:
$90:AB50 D0 0B       BNE $0B    [$AB5D]     ;/
$90:AB52 AF 80 C6 7E LDA $7EC680[$7E:C680]  ;\
$90:AB56 09 00 1C    ORA #$1C00             ;} $7E:C680 |= 1C00h (give Samus position in mini-map palette 7)
$90:AB59 8F 80 C6 7E STA $7EC680[$7E:C680]  ;/

$90:AB5D 28          PLP
$90:AB5E 6B          RTL
}


;;; $AB5F: Mark map tile above Samus as explored ;;;
{
;; Parameters:
;;     $1E: Byte index of Samus map co-ordinate (([$16] + [$22]) * 4 + [$14])
;;     $20: Bit subindex of column of Samus map position ([room X co-ordinate] + [Samus X position] / 100h & 7)

$90:AB5F DA          PHX
$90:AB60 5A          PHY
$90:AB61 A6 1E       LDX $1E    [$7E:001E]  ;\
$90:AB63 E2 20       SEP #$20               ;|
$90:AB65 A4 20       LDY $20    [$7E:0020]  ;|
$90:AB67 BD F3 07    LDA $07F3,x[$7E:080C]  ;} $07F7 + [$1E] - 4 |= 80h >> [$20]
$90:AB6A 19 04 AC    ORA $AC04,y[$90:AC0B]  ;|
$90:AB6D 9D F3 07    STA $07F3,x[$7E:080C]  ;/
$90:AB70 C2 20       REP #$20
$90:AB72 7A          PLY
$90:AB73 FA          PLX
$90:AB74 60          RTS
}


;;; $AB75: Adjust map bits for map page spill ;;;
{
;; Parameters:
;;     $0B: $82 (bank for map data)
;;     $0F: Area map data pointer ([$82:9717 + [area index] * 2])
;;     $22: Map page of Samus position ([room X co-ordinate] + [Samus X position] / 100h & 20h)
;;     $30: Byte index of spilt map bits (if [$22] = 0 then [$32] + 7Dh else [$32] - 7Ch)

; Direct page usage:
;     $09: Spilt map data pointer ($82:0000 + [$0F] + [$30])
;     $18: Explored row 0 map bits (([$07F7 + [$32/$30]]     << 8 | [$07F7 + [$32/$30] + 1]) & FC00h >> [$34] / 2)
;     $1A: Explored row 1 map bits (([$07F7 + [$32/$30] + 4] << 8 | [$07F7 + [$32/$30] + 5]) & FC00h >> [$34] / 2)
;     $1C: Explored row 2 map bits (([$07F7 + [$32/$30] + 8] << 8 | [$07F7 + [$32/$30] + 9]) & FC00h >> [$34] / 2)
;     $2C: Spilt explored row map bits ([$07F7 + [$30] + 0/4/8])
;     $2D: Spilt row map bits ([[$09] + 0/4/8])

$90:AB75 08          PHP
$90:AB76 C2 30       REP #$30
$90:AB78 A5 30       LDA $30    [$7E:0030]  ;\
$90:AB7A 29 FF 00    AND #$00FF             ;} X = [$30]
$90:AB7D AA          TAX                    ;/
$90:AB7E 18          CLC                    ;\
$90:AB7F 65 0F       ADC $0F    [$7E:000F]  ;} $09 = [$0F] + [$30] (spilt map data pointer)
$90:AB81 85 09       STA $09    [$7E:0009]  ;/
$90:AB83 E2 20       SEP #$20
$90:AB85 BD F7 07    LDA $07F7,x[$7E:089F]  ;\
$90:AB88 85 2C       STA $2C    [$7E:002C]  ;} $2C = [$07F7 + [$30]]
$90:AB8A A7 09       LDA [$09]  [$82:98CF]  ;\
$90:AB8C 85 2D       STA $2D    [$7E:002D]  ;} $2D = [[$09]]
$90:AB8E A9 20       LDA #$20               ;\
$90:AB90 C5 22       CMP $22    [$7E:0022]  ;} If [$22] = 20h: (Samus position is on right map page)
$90:AB92 D0 0A       BNE $0A    [$AB9E]     ;/
$90:AB94 A5 2C       LDA $2C    [$7E:002C]  ;\
$90:AB96 85 19       STA $19    [$7E:0019]  ;} $19 = [$2C] (explored row 0 map bits - left half)
$90:AB98 A5 2D       LDA $2D    [$7E:002D]  ;\
$90:AB9A 85 27       STA $27    [$7E:0027]  ;} $27 = [$2D] (row 0 map bits - left half)
$90:AB9C 80 08       BRA $08    [$ABA6]

$90:AB9E A5 2C       LDA $2C    [$7E:002C]  ;\ Else ([$22] != 20h): (Samus position is on left map page)
$90:ABA0 85 18       STA $18    [$7E:0018]  ;} $18 = [$2C] (explored row 0 map bits - right half)
$90:ABA2 A5 2D       LDA $2D    [$7E:002D]  ;\
$90:ABA4 85 26       STA $26    [$7E:0026]  ;} $26 = [$2D] (row 0 map bits - right half)

$90:ABA6 BD FB 07    LDA $07FB,x[$7E:08A3]  ;\
$90:ABA9 85 2C       STA $2C    [$7E:002C]  ;} $2C = [$07F7 + [$30] + 4]
$90:ABAB C2 20       REP #$20               ;\
$90:ABAD A5 09       LDA $09    [$7E:0009]  ;|
$90:ABAF 18          CLC                    ;|
$90:ABB0 69 04 00    ADC #$0004             ;|
$90:ABB3 85 09       STA $09    [$7E:0009]  ;} $2D = [[$09] + 4]
$90:ABB5 E2 20       SEP #$20               ;|
$90:ABB7 A7 09       LDA [$09]  [$82:98D3]  ;|
$90:ABB9 85 2D       STA $2D    [$7E:002D]  ;/
$90:ABBB A9 20       LDA #$20               ;\
$90:ABBD C5 22       CMP $22    [$7E:0022]  ;} If [$22] = 20h: (Samus position is on right map page)
$90:ABBF D0 0A       BNE $0A    [$ABCB]     ;/
$90:ABC1 A5 2C       LDA $2C    [$7E:002C]  ;\
$90:ABC3 85 1B       STA $1B    [$7E:001B]  ;} $1B = [$2C] (explored row 1 map bits - left half)
$90:ABC5 A5 2D       LDA $2D    [$7E:002D]  ;\
$90:ABC7 85 29       STA $29    [$7E:0029]  ;} $29 = [$2D] (row 1 map bits - left half)
$90:ABC9 80 08       BRA $08    [$ABD3]

$90:ABCB A5 2C       LDA $2C    [$7E:002C]  ;\ Else ([$22] != 20h): (Samus position is on left map page)
$90:ABCD 85 1A       STA $1A    [$7E:001A]  ;} $1A = [$2C] (explored row 1 map bits - right half)
$90:ABCF A5 2D       LDA $2D    [$7E:002D]  ;\
$90:ABD1 85 28       STA $28    [$7E:0028]  ;} $28 = [$2D] (row 1 map bits - right half)

$90:ABD3 BD FF 07    LDA $07FF,x[$7E:08A7]  ;\
$90:ABD6 85 2C       STA $2C    [$7E:002C]  ;} $2C = [$07F7 + [$30] + 8]
$90:ABD8 C2 20       REP #$20               ;\
$90:ABDA A5 09       LDA $09    [$7E:0009]  ;|
$90:ABDC 18          CLC                    ;|
$90:ABDD 69 04 00    ADC #$0004             ;|
$90:ABE0 85 09       STA $09    [$7E:0009]  ;} $2D = [[$09] + 8]
$90:ABE2 E2 20       SEP #$20               ;|
$90:ABE4 A7 09       LDA [$09]  [$82:98D7]  ;|
$90:ABE6 85 2D       STA $2D    [$7E:002D]  ;/
$90:ABE8 A9 20       LDA #$20               ;\
$90:ABEA C5 22       CMP $22    [$7E:0022]  ;} If [$22] = 20h: (Samus position is on right map page)
$90:ABEC D0 0A       BNE $0A    [$ABF8]     ;/
$90:ABEE A5 2C       LDA $2C    [$7E:002C]  ;\
$90:ABF0 85 1D       STA $1D    [$7E:001D]  ;} $1D = [$2C] (explored row 2 map bits - left half)
$90:ABF2 A5 2D       LDA $2D    [$7E:002D]  ;\
$90:ABF4 85 2B       STA $2B    [$7E:002B]  ;} $2B = [$2D] (row 2 map bits - left half)
$90:ABF6 80 08       BRA $08    [$AC00]

$90:ABF8 A5 2C       LDA $2C    [$7E:002C]  ;\ Else ([$22] != 20h): (Samus position is on left map page)
$90:ABFA 85 1C       STA $1C    [$7E:001C]  ;} $1C = [$2C] (explored row 2 map bits - right half)
$90:ABFC A5 2D       LDA $2D    [$7E:002D]  ;\
$90:ABFE 85 2A       STA $2A    [$7E:002A]  ;} $2A = [$2D] (row 2 map bits - right half)

$90:AC00 C2 30       REP #$30
$90:AC02 28          PLP
$90:AC03 60          RTS
}


;;; $AC04: 1-bit bitmasks ;;;
{
$90:AC04             db 80, 40, 20, 10, 08, 04, 02, 01
}


;;; $AC0C: 6-bit bitmasks ;;;
{
; Why are these 6-bits instead of 5?

; FC00h >> i
; 3Fh << Ah - i
$90:AC0C             dw FC00, 7E00, 3F00, 1F80, 0FC0, 07E0, 03F0, 01F8
}
}


;;; $AC1C..CFF9: Projectiles ;;;
{
;;; $AC1C: Handle Samus cooldown ;;;
{
$90:AC1C AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:AC1F D0 11       BNE $11    [$AC32]     ;} If time is frozen: go to BRANCH_TIME_FROZEN
$90:AC21 AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$90:AC24 F0 0B       BEQ $0B    [$AC31]     ;|
$90:AC26 30 06       BMI $06    [$AC2E]     ;|
$90:AC28 3A          DEC A                  ;|
$90:AC29 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = max(0, [cooldown timer] - 1)
$90:AC2C 10 03       BPL $03    [$AC31]     ;|
                                            ;|
$90:AC2E 9C CC 0C    STZ $0CCC  [$7E:0CCC]  ;/

$90:AC31 60          RTS                    ; Return

; BRANCH_TIME_FROZEN
$90:AC32 A9 20 00    LDA #$0020             ;\
$90:AC35 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 20h
$90:AC38 60          RTS
}


;;; $AC39: Check if Samus can fire beam ;;;
{
;; Returns:
;;     Carry: Set if Samus can fire beam, clear otherwise

; Increments projectile counter(!)
$90:AC39 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$90:AC3C C9 05 00    CMP #$0005             ;} If [projectile counter] >= 5: go to BRANCH_CARRY_CLEAR
$90:AC3F 10 17       BPL $17    [$AC58]     ;/
$90:AC41 AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$90:AC44 29 FF 00    AND #$00FF             ;} If [cooldown timer] != 0: go to BRANCH_CARRY_CLEAR
$90:AC47 D0 0F       BNE $0F    [$AC58]     ;/
$90:AC49 A9 01 00    LDA #$0001             ;\
$90:AC4C 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 1
$90:AC4F AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$90:AC52 1A          INC A                  ;} Increment projectile counter
$90:AC53 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;/
$90:AC56 38          SEC                    ;\
$90:AC57 60          RTS                    ;} Return carry set

; BRANCH_CARRY_CLEAR
$90:AC58 18          CLC                    ;\
$90:AC59 60          RTS                    ;} Return carry clear
}


;;; $AC5A: Check if Samus can fire (super) missile ;;;
{
;; Returns:
;;     Carry: Set if Samus can fire (super) missile

; Increments projectile counter(!)
$90:AC5A AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:AC5D C9 02 00    CMP #$0002             ;} If [HUD item index] = super missile: go to BRANCH_SUPER_MISSILE
$90:AC60 F0 21       BEQ $21    [$AC83]     ;/
$90:AC62 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$90:AC65 C9 05 00    CMP #$0005             ;} If [projectile counter] >= 5: return carry clear
$90:AC68 10 17       BPL $17    [$AC81]     ;/

; BRANCH_FREE_SLOT
$90:AC6A AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$90:AC6D 29 FF 00    AND #$00FF             ;} If [cooldown timer] != 0: go to BRANCH_CARRY_CLEAR
$90:AC70 D0 0F       BNE $0F    [$AC81]     ;/
$90:AC72 A9 01 00    LDA #$0001             ;\
$90:AC75 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 1
$90:AC78 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$90:AC7B 1A          INC A                  ;} Increment projectile counter
$90:AC7C 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;/
$90:AC7F 38          SEC                    ;\
$90:AC80 60          RTS                    ;} Return carry set

; BRANCH_CARRY_CLEAR
$90:AC81 18          CLC                    ;\
$90:AC82 60          RTS                    ;} Return carry clear

; BRANCH_SUPER_MISSILE
$90:AC83 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$90:AC86 C9 04 00    CMP #$0004             ;} If [projectile counter] < 4: go to BRANCH_FREE_SLOT
$90:AC89 30 DF       BMI $DF    [$AC6A]     ;/
$90:AC8B 18          CLC                    ;\
$90:AC8C 60          RTS                    ;} Return carry clear
}


;;; $AC8D..AD21: Update beam tiles and palette ;;;
{
;;; $AC8D: Update beam tiles and palette ;;;
{
$90:AC8D 08          PHP
$90:AC8E 8B          PHB
$90:AC8F 4B          PHK                    ;\
$90:AC90 AB          PLB                    ;} DB = $90
$90:AC91 C2 30       REP #$30
$90:AC93 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:AC96 29 FF 0F    AND #$0FFF             ;|
$90:AC99 0A          ASL A                  ;} Y = ([equipped beams] & FFFh) * 2
$90:AC9A A8          TAY                    ;/
$90:AC9B AE 30 03    LDX $0330  [$7E:0330]  ;\
$90:AC9E A9 00 01    LDA #$0100             ;|
$90:ACA1 95 D0       STA $D0,x  [$7E:00D0]  ;|
$90:ACA3 E8          INX                    ;|
$90:ACA4 E8          INX                    ;|
$90:ACA5 B9 B1 C3    LDA $C3B1,y[$90:C3B1]  ;|
$90:ACA8 95 D0       STA $D0,x  [$7E:00D2]  ;|
$90:ACAA E8          INX                    ;|
$90:ACAB E8          INX                    ;|
$90:ACAC E2 20       SEP #$20               ;} Queue transfer of 100h bytes from $9A:0000 + [$C3B1 + [Y]] to VRAM $6300 (beam tiles)
$90:ACAE A9 9A       LDA #$9A               ;|
$90:ACB0 95 D0       STA $D0,x  [$7E:00D4]  ;|
$90:ACB2 C2 20       REP #$20               ;|
$90:ACB4 E8          INX                    ;|
$90:ACB5 A9 00 63    LDA #$6300             ;|
$90:ACB8 95 D0       STA $D0,x  [$7E:00D5]  ;|
$90:ACBA E8          INX                    ;|
$90:ACBB E8          INX                    ;|
$90:ACBC 8E 30 03    STX $0330  [$7E:0330]  ;/
$90:ACBF 4C CD AC    JMP $ACCD  [$90:ACCD]  ; Go to load beam palette
}


;;; $ACC2: Load beam palette (external) ;;;
{
;; Parameters:
;;     A: Equipped beams

; Same as $ACF0. Called for crystal flash finish
$90:ACC2 08          PHP
$90:ACC3 8B          PHB
$90:ACC4 4B          PHK                    ;\
$90:ACC5 AB          PLB                    ;} DB = $90
$90:ACC6 C2 30       REP #$30
$90:ACC8 29 FF 0F    AND #$0FFF             ;\
$90:ACCB 0A          ASL A                  ;} Y = ([A] & FFFh) * 2
$90:ACCC A8          TAY                    ;/
}


;;; $ACCD: Load beam palette ;;;
{
;; Parameters:
;;     Y: Beam type * 2 (without the charge beam bit)

; Requires DB and PSR to have been pushed
$90:ACCD A9 90 00    LDA #$0090             ;\
$90:ACD0 EB          XBA                    ;|
$90:ACD1 85 01       STA $01    [$7E:0001]  ;|
$90:ACD3 B9 C9 C3    LDA $C3C9,y[$90:C3C9]  ;|
$90:ACD6 85 00       STA $00    [$7E:0000]  ;|
$90:ACD8 A0 00 00    LDY #$0000             ;|
$90:ACDB A2 00 00    LDX #$0000             ;|
                                            ;|
$90:ACDE B7 00       LDA [$00],y[$90:C3E1]  ;} Copy 20h bytes from $90:0000 + [$C3C9 + [Y]] to sprite palette 6
$90:ACE0 9F C0 C1 7E STA $7EC1C0,x[$7E:C1C0];|
$90:ACE4 E8          INX                    ;|
$90:ACE5 E8          INX                    ;|
$90:ACE6 C8          INY                    ;|
$90:ACE7 C8          INY                    ;|
$90:ACE8 C0 20 00    CPY #$0020             ;|
$90:ACEB 30 F1       BMI $F1    [$ACDE]     ;/
$90:ACED AB          PLB
$90:ACEE 28          PLP
$90:ACEF 6B          RTL
}


;;; $ACF0: Load beam palette (external) ;;;
{
;; Parameters:
;;     A: Equipped beams

; Same as $ACC2. Called for grapple start/finish
$90:ACF0 08          PHP
$90:ACF1 8B          PHB
$90:ACF2 4B          PHK                    ;\
$90:ACF3 AB          PLB                    ;} DB = $90
$90:ACF4 C2 30       REP #$30
$90:ACF6 20 FC AC    JSR $ACFC  [$90:ACFC]  ; Load beam palette
$90:ACF9 AB          PLB
$90:ACFA 28          PLP
$90:ACFB 6B          RTL
}


;;; $ACFC: Load beam palette ;;;
{
;; Parameters:
;;     A: Equipped beams
$90:ACFC 29 FF 0F    AND #$0FFF             ;\
$90:ACFF 0A          ASL A                  ;} Y = ([A] & FFFh) * 2
$90:AD00 A8          TAY                    ;/
$90:AD01 A9 90 00    LDA #$0090             ;\
$90:AD04 EB          XBA                    ;|
$90:AD05 85 01       STA $01    [$7E:0001]  ;|
$90:AD07 B9 C9 C3    LDA $C3C9,y[$90:C3CD]  ;|
$90:AD0A 85 00       STA $00    [$7E:0000]  ;|
$90:AD0C A0 00 00    LDY #$0000             ;|
$90:AD0F A2 00 00    LDX #$0000             ;|
                                            ;|
$90:AD12 B7 00       LDA [$00],y[$90:C401]  ;} Copy 20h bytes from $90:0000 + [$C3C9 + [Y]] to sprite palette 6
$90:AD14 9F C0 C1 7E STA $7EC1C0,x[$7E:C1C0];|
$90:AD18 E8          INX                    ;|
$90:AD19 E8          INX                    ;|
$90:AD1A C8          INY                    ;|
$90:AD1B C8          INY                    ;|
$90:AD1C C0 20 00    CPY #$0020             ;|
$90:AD1F 30 F1       BMI $F1    [$AD12]     ;/
$90:AD21 60          RTS
}
}


;;; $AD22: Reset projectile data ;;;
{
; Called during door transition ($82:E4A9) and when elevator is activated ($A3:9548)
$90:AD22 08          PHP
$90:AD23 C2 30       REP #$30
$90:AD25 A2 00 00    LDX #$0000             ; X = 0 (projectile index)

; LOOP
$90:AD28 9E 90 0C    STZ $0C90,x[$7E:0C90]  ; Projectile trail timer / bomb Y subvelocity = 0
$90:AD2B 9E 64 0B    STZ $0B64,x[$7E:0B64]  ; Projectile X position = 0
$90:AD2E 9E 78 0B    STZ $0B78,x[$7E:0B78]  ; Projectile Y position = 0
$90:AD31 9E 04 0C    STZ $0C04,x[$7E:0C04]  ; Projectile direction = 0
$90:AD34 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X velocity = 0
$90:AD37 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y velocity = 0
$90:AD3A 9E B4 0B    STZ $0BB4,x[$7E:0BB4]  ; Projectile X radius = 0
$90:AD3D 9E C8 0B    STZ $0BC8,x[$7E:0BC8]  ; Projectile Y radius = 0
$90:AD40 9E 18 0C    STZ $0C18,x[$7E:0C18]  ; Projectile type = 0
$90:AD43 9E 2C 0C    STZ $0C2C,x[$7E:0C2C]  ; Projectile damage = 0
$90:AD46 9E 40 0C    STZ $0C40,x[$7E:0C40]  ; Projectile instruction pointer = 0
$90:AD49 9E 54 0C    STZ $0C54,x[$7E:0C54]  ; Projectile instruction timer = 0
$90:AD4C 9E 7C 0C    STZ $0C7C,x[$7E:0C7C]  ; Projectile variable / bomb timer = 0
$90:AD4F 9E B8 0C    STZ $0CB8,x[$7E:0CB8]  ; Projectile spritemap pointer = 0
$90:AD52 A9 69 B1    LDA #$B169             ;\
$90:AD55 9D 68 0C    STA $0C68,x[$7E:0C68]  ;} Projectile pre-instruction = RTS
$90:AD58 E8          INX                    ;\
$90:AD59 E8          INX                    ;} X += 2
$90:AD5A E0 14 00    CPX #$0014             ;\
$90:AD5D 30 C9       BMI $C9    [$AD28]     ;} If [X] < 14h: go to LOOP
$90:AD5F 9C D2 0C    STZ $0CD2  [$7E:0CD2]  ; Bomb counter = 0
$90:AD62 9C CC 0C    STZ $0CCC  [$7E:0CCC]  ; Cooldown timer = 0
$90:AD65 9C CE 0C    STZ $0CCE  [$7E:0CCE]  ; Projectile counter = 0
$90:AD68 9C EE 0C    STZ $0CEE  [$7E:0CEE]  ; Power bomb flag = 0
$90:AD6B AD EA 09    LDA $09EA  [$7E:09EA]  ;\
$90:AD6E F0 06       BEQ $06    [$AD76]     ;} If [icon cancel flag] != 0:
$90:AD70 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$90:AD73 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing

$90:AD76 9C B0 0A    STZ $0AB0  [$7E:0AB0]  ; Speed echo 0 X position = 0
$90:AD79 9C B2 0A    STZ $0AB2  [$7E:0AB2]  ; Speed echo 1 X position = 0
$90:AD7C 9C B4 0A    STZ $0AB4  [$7E:0AB4]  ; Speed echo 2 X position = 0
$90:AD7F 9C B6 0A    STZ $0AB6  [$7E:0AB6]  ; Speed echo 3 X position = 0
$90:AD82 9C B8 0A    STZ $0AB8  [$7E:0AB8]  ; Speed echo 0 Y position = 0
$90:AD85 9C BA 0A    STZ $0ABA  [$7E:0ABA]  ; Speed echo 1 Y position = 0
$90:AD88 9C BC 0A    STZ $0ABC  [$7E:0ABC]  ; Speed echo 2 Y position = 0
$90:AD8B 9C BE 0A    STZ $0ABE  [$7E:0ABE]  ; Speed echo 3 Y position = 0
$90:AD8E 9C C0 0A    STZ $0AC0  [$7E:0AC0]  ; Speed echo 0 X speed = 0
$90:AD91 9C C2 0A    STZ $0AC2  [$7E:0AC2]  ; Speed echo 1 X speed = 0
$90:AD94 9C C4 0A    STZ $0AC4  [$7E:0AC4]  ; Draw speed echo 2 flag = 0
$90:AD97 9C C6 0A    STZ $0AC6  [$7E:0AC6]  ; Draw speed echo 3 flag = 0
$90:AD9A 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echoes index = 0
$90:AD9D AD 4A 0A    LDA $0A4A  [$7E:0A4A]  ;\
$90:ADA0 F0 07       BEQ $07    [$ADA9]     ;} If [super special Samus palette flags] != 0:
$90:ADA2 9C 4A 0A    STZ $0A4A  [$7E:0A4A]  ; Super special Samus palette flags = 0
$90:ADA5 22 E6 DE 91 JSL $91DEE6[$91:DEE6]  ; Load Samus target colours based on suit

$90:ADA9 AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$90:ADAC F0 07       BEQ $07    [$ADB5]     ;} If hyper beam is enabled:
$90:ADAE A0 F0 E1    LDY #$E1F0             ;\
$90:ADB1 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn hyper beam palette FX object

$90:ADB5 28          PLP
$90:ADB6 6B          RTL
}


;;; $ADB7: Clear projectile ;;;
{
;; Parameters:
;;     X: Projectile index
$90:ADB7 08          PHP
$90:ADB8 C2 30       REP #$30
$90:ADBA 9E 64 0B    STZ $0B64,x[$7E:0B64]  ; Projectile X position = 0
$90:ADBD 9E 78 0B    STZ $0B78,x[$7E:0B78]  ; Projectile Y position = 0
$90:ADC0 9E 8C 0B    STZ $0B8C,x[$7E:0B8C]  ; Projectile X subposition = 0
$90:ADC3 9E A0 0B    STZ $0BA0,x[$7E:0BA0]  ; Projectile Y subposition = 0
$90:ADC6 9E 04 0C    STZ $0C04,x[$7E:0C04]  ; Projectile direction = 0
$90:ADC9 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X speed = 0
$90:ADCC 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y speed = 0
$90:ADCF 9E B4 0B    STZ $0BB4,x[$7E:0BB4]  ; Projectile X radius = 0
$90:ADD2 9E C8 0B    STZ $0BC8,x[$7E:0BC8]  ; Projectile Y radius = 0
$90:ADD5 9E 18 0C    STZ $0C18,x[$7E:0C18]  ; Projectile type = 0
$90:ADD8 9E 2C 0C    STZ $0C2C,x[$7E:0C2C]  ; Projectile damage = 0
$90:ADDB 9E 40 0C    STZ $0C40,x[$7E:0C40]  ; Projectile instruction pointer = 0
$90:ADDE 9E 54 0C    STZ $0C54,x[$7E:0C54]  ; Projectile instruction timer = 0
$90:ADE1 9E 7C 0C    STZ $0C7C,x[$7E:0C7C]  ; Projectile variable / bomb timer = 0
$90:ADE4 9E B8 0C    STZ $0CB8,x[$7E:0CB8]  ; Projectile spritemap pointer = 0
$90:ADE7 A9 69 B1    LDA #$B169             ;\
$90:ADEA 9D 68 0C    STA $0C68,x[$7E:0C68]  ;} Projectile pre-instruction = RTS
$90:ADED E0 0A 00    CPX #$000A             ;\
$90:ADF0 10 0A       BPL $0A    [$ADFC]     ;} If [X] < Ah:
$90:ADF2 CE CE 0C    DEC $0CCE  [$7E:0CCE]  ;\
$90:ADF5 10 0D       BPL $0D    [$AE04]     ;} Projectile counter = max(0, [projectile counter] - 1)
$90:ADF7 9C CE 0C    STZ $0CCE  [$7E:0CCE]  ;/
$90:ADFA 80 08       BRA $08    [$AE04]     ; Return

$90:ADFC CE D2 0C    DEC $0CD2  [$7E:0CD2]  ;\
$90:ADFF 10 03       BPL $03    [$AE04]     ;} Bomb counter = max(0, [bomb counter] - 1)
$90:AE01 9C D2 0C    STZ $0CD2  [$7E:0CD2]  ;/

$90:AE04 28          PLP
$90:AE05 6B          RTL
}


;;; $AE06..CD: Kill projectile ;;;
{
;;; $AE06: Kill projectile ;;;
{
;; Parameters:
;;     X: Projectile index
$90:AE06 08          PHP
$90:AE07 8B          PHB
$90:AE08 4B          PHK                    ;\
$90:AE09 AB          PLB                    ;} DB = $90
$90:AE0A C2 30       REP #$30
$90:AE0C BD 19 0C    LDA $0C19,x[$7E:0C19]  ;\
$90:AE0F 29 0F 00    AND #$000F             ;} If projectile is beam: go to BRANCH_BEAM
$90:AE12 F0 0C       BEQ $0C    [$AE20]     ;/
$90:AE14 C9 03 00    CMP #$0003             ;\
$90:AE17 30 14       BMI $14    [$AE2D]     ;} If projectile is (super) missile: go to BRANCH_MISSILE
$90:AE19 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:AE1D AB          PLB
$90:AE1E 28          PLP
$90:AE1F 6B          RTL                    ; Return

; BRANCH_BEAM
$90:AE20 9B          TXY                    ;\
$90:AE21 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;|
$90:AE24 29 0F 00    AND #$000F             ;|
$90:AE27 0A          ASL A                  ;} Execute [$AE3A + ([projectile direction] & Fh) * 2]
$90:AE28 AA          TAX                    ;|
$90:AE29 FC 3A AE    JSR ($AE3A,x)[$90:AEB9];|
$90:AE2C BB          TYX                    ;/

; BRANCH_MISSILE
$90:AE2D 22 CF 80 93 JSL $9380CF[$93:80CF]  ; Part of kill projectile - queue sound effect and set instruction
$90:AE31 A9 69 B1    LDA #$B169             ;\
$90:AE34 9D 68 0C    STA $0C68,x[$7E:0C68]  ;} Projectile pre-instruction = RTS
$90:AE37 AB          PLB
$90:AE38 28          PLP
$90:AE39 6B          RTL

$90:AE3A             dw AE4E, AE59, AE6E, AE79, AE8E, AE8E, AE99, AEAE, AEB9, AE4E
}


;;; $AE4E: Kill beam - up ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AE4E B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$90:AE51 38          SEC                    ;|
$90:AE52 F9 C8 0B    SBC $0BC8,y[$7E:0BC8]  ;} Projectile Y position -= [projectile Y radii]
$90:AE55 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:AE58 60          RTS
}


;;; $AE59: Kill beam - up-right ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AE59 B9 64 0B    LDA $0B64,y[$7E:0B66]  ;\
$90:AE5C 18          CLC                    ;|
$90:AE5D 79 B4 0B    ADC $0BB4,y[$7E:0BB6]  ;} Projectile X position += [projectile X radii]
$90:AE60 99 64 0B    STA $0B64,y[$7E:0B66]  ;/
$90:AE63 B9 78 0B    LDA $0B78,y[$7E:0B7A]  ;\
$90:AE66 38          SEC                    ;|
$90:AE67 F9 C8 0B    SBC $0BC8,y[$7E:0BCA]  ;} Projectile Y position -= [projectile Y radii]
$90:AE6A 99 78 0B    STA $0B78,y[$7E:0B7A]  ;/
$90:AE6D 60          RTS
}


;;; $AE6E: Kill beam - right ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AE6E B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$90:AE71 18          CLC                    ;|
$90:AE72 79 B4 0B    ADC $0BB4,y[$7E:0BB4]  ;} Projectile X position += [projectile X radii]
$90:AE75 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:AE78 60          RTS
}


;;; $AE79: Kill beam - down-right ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AE79 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$90:AE7C 18          CLC                    ;|
$90:AE7D 79 B4 0B    ADC $0BB4,y[$7E:0BB4]  ;} Projectile X position += [projectile X radii]
$90:AE80 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:AE83 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$90:AE86 18          CLC                    ;|
$90:AE87 79 C8 0B    ADC $0BC8,y[$7E:0BC8]  ;} Projectile Y position += [projectile Y radii]
$90:AE8A 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:AE8D 60          RTS
}


;;; $AE8E: Kill beam - down ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AE8E B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$90:AE91 18          CLC                    ;|
$90:AE92 79 C8 0B    ADC $0BC8,y[$7E:0BC8]  ;} Projectile Y position += [projectile Y radii]
$90:AE95 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:AE98 60          RTS
}


;;; $AE99: Kill beam - down-left ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AE99 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$90:AE9C 38          SEC                    ;|
$90:AE9D F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;} Projectile X position -= [projectile X radii]
$90:AEA0 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:AEA3 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$90:AEA6 18          CLC                    ;|
$90:AEA7 79 C8 0B    ADC $0BC8,y[$7E:0BC8]  ;} Projectile Y position += [projectile Y radii]
$90:AEAA 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:AEAD 60          RTS
}


;;; $AEAE: Kill beam - left ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AEAE B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$90:AEB1 38          SEC                    ;|
$90:AEB2 F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;} Projectile X position -= [projectile X radii]
$90:AEB5 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:AEB8 60          RTS
}


;;; $AEB9: Kill beam - up-left ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:AEB9 B9 64 0B    LDA $0B64,y[$7E:0B64]  ;\
$90:AEBC 38          SEC                    ;|
$90:AEBD F9 B4 0B    SBC $0BB4,y[$7E:0BB4]  ;} Projectile X position -= [projectile X radii]
$90:AEC0 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:AEC3 B9 78 0B    LDA $0B78,y[$7E:0B78]  ;\
$90:AEC6 38          SEC                    ;|
$90:AEC7 F9 C8 0B    SBC $0BC8,y[$7E:0BC8]  ;} Projectile Y position -= [projectile Y radii]
$90:AECA 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:AECD 60          RTS
}
}


;;; $AECE: Handle projectiles ;;;
{
$90:AECE 08          PHP
$90:AECF C2 30       REP #$30
$90:AED1 A9 12 00    LDA #$0012             ;\
$90:AED4 8D DE 0D    STA $0DDE  [$7E:0DDE]  ;} Projectile index = 12h
$90:AED7 AA          TAX                    ;/

; LOOP
$90:AED8 BD 40 0C    LDA $0C40,x[$7E:0C52]  ;\
$90:AEDB F0 0A       BEQ $0A    [$AEE7]     ;} If [projectile instruction pointer] != 0:
$90:AEDD FC 68 0C    JSR ($0C68,x)[$90:AF68]; Execute [projectile pre-instruction]
$90:AEE0 22 E9 81 93 JSL $9381E9[$93:81E9]  ; Projectile instruction handler
$90:AEE4 AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:AEE7 CA          DEX                    ;\
$90:AEE8 CA          DEX                    ;} Projectile index -= 2
$90:AEE9 8E DE 0D    STX $0DDE  [$7E:0DDE]  ;/
$90:AEEC 10 EA       BPL $EA    [$AED8]     ; If [projectile index] >= 0: go to LOOP
$90:AEEE 9C D2 0D    STZ $0DD2  [$7E:0DD2]  ; Projectile proto type = normal
$90:AEF1 28          PLP
$90:AEF2 60          RTS
}


;;; $AEF3..AF67: Beam - no wave beam ;;;
{
;;; $AEF3: Projectile pre-instruction - beam - no wave beam ;;;
{
;; Parameters:
;;     X: Projectile index
$90:AEF3 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:AEF6 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:AEF9 F0 05       BEQ $05    [$AF00]     ;/
$90:AEFB 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:AEFF 60          RTS                    ; Return

$90:AF00 DE 90 0C    DEC $0C90,x[$7E:0C90]  ; Decrement projectile trail timer
$90:AF03 D0 0D       BNE $0D    [$AF12]     ; If [projectile trail timer] = 0:
$90:AF05 A9 04 00    LDA #$0004             ;\
$90:AF08 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 4
$90:AF0B 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:AF0F AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:AF12 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:AF15 29 0F 00    AND #$000F             ;|
$90:AF18 0A          ASL A                  ;} Y = ([projectile direction] & Fh) * 2
$90:AF19 A8          TAY                    ;/
$90:AF1A BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;\
$90:AF1D 18          CLC                    ;|
$90:AF1E 79 53 C3    ADC $C353,y[$90:C363]  ;} Projectile X velocity += [$C353 + [Y]]
$90:AF21 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:AF24 BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;\
$90:AF27 18          CLC                    ;|
$90:AF28 79 67 C3    ADC $C367,y[$90:C377]  ;} Projectile Y velocity += [$C367 + [Y]]
$90:AF2B 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:AF2E BB          TYX                    ;\
$90:AF2F FC 36 AF    JSR ($AF36,x)[$90:AF52];} Execute [$AF36 + [Y]]
$90:AF32 20 6A B1    JSR $B16A  [$90:B16A]  ; Delete projectile if too far off-screen
$90:AF35 60          RTS

$90:AF36             dw AF4A, ; 0: Up, facing right
                        AF52, ; 1: Up-right
                        AF60, ; 2: Right
                        AF52, ; 3: Down-right
                        AF4A, ; 4: Down, facing right
                        AF4A, ; 5: Down, facing left
                        AF52, ; 6: Down-left
                        AF60, ; 7: Left
                        AF52, ; 8: Up-left
                        AF4A  ; 9: Up, facing left
}


;;; $AF4A: Beam block collision - no wave beam - vertical ;;;
{
$90:AF4A AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:AF4D 22 CA A2 94 JSL $94A2CA[$94:A2CA]  ; Move beam vertically - no wave beam
$90:AF51 60          RTS
}


;;; $AF52: Beam block collision - no wave beam - diagonal ;;;
{
$90:AF52 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:AF55 22 3B A2 94 JSL $94A23B[$94:A23B]  ; Move beam horizontally - no wave beam
$90:AF59 B0 04       BCS $04    [$AF5F]     ; If not collided:
$90:AF5B 22 CA A2 94 JSL $94A2CA[$94:A2CA]  ; Move beam vertically - no wave beam

$90:AF5F 60          RTS
}


;;; $AF60: Beam block collision - no wave beam - horizontal ;;;
{
$90:AF60 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:AF63 22 3B A2 94 JSL $94A23B[$94:A23B]  ; Move beam horizontally - no wave beam
$90:AF67 60          RTS
}
}


;;; $AF68..E4: Missile ;;;
{
;;; $AF68: Projectile pre-instruction - missile ;;;
{
;; Parameters:
;;     X: Projectile index
$90:AF68 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:AF6B 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:AF6E F0 05       BEQ $05    [$AF75]     ;/
$90:AF70 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:AF74 60          RTS                    ; Return

$90:AF75 DE 90 0C    DEC $0C90,x[$7E:0C90]  ; Decrement projectile trail timer
$90:AF78 D0 0D       BNE $0D    [$AF87]     ; If [projectile trail timer] = 0:
$90:AF7A A9 04 00    LDA #$0004             ;\
$90:AF7D 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 4
$90:AF80 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:AF84 AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:AF87 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:AF8A 29 0F 00    AND #$000F             ;|
$90:AF8D 0A          ASL A                  ;} Y = [projectile direction] * 2
$90:AF8E A8          TAY                    ;/
$90:AF8F BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;\
$90:AF92 18          CLC                    ;|
$90:AF93 79 53 C3    ADC $C353,y[$90:C361]  ;} Projectile X velocity += [$C353 + [Y]]
$90:AF96 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:AF99 BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;\
$90:AF9C 18          CLC                    ;|
$90:AF9D 79 67 C3    ADC $C367,y[$90:C375]  ;} Projectile Y velocity += [$C367 + [Y]]
$90:AFA0 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:AFA3 98          TYA                    ;\
$90:AFA4 4A          LSR A                  ;} Y /= 2
$90:AFA5 A8          TAY                    ;/
$90:AFA6 20 F6 B2    JSR $B2F6  [$90:B2F6]  ; Accelerate (super) missile
$90:AFA9 98          TYA                    ;\
$90:AFAA 0A          ASL A                  ;|
$90:AFAB AA          TAX                    ;} Execute [$AF36 + [Y] * 2]
$90:AFAC FC B3 AF    JSR ($AFB3,x)[$90:AFDD];/
$90:AFAF 20 6A B1    JSR $B16A  [$90:B16A]  ; Delete projectile if too far off-screen
$90:AFB2 60          RTS

$90:AFB3             dw AFC7, ; 0: Up, facing right
                        AFCF, ; 1: Up-right
                        AFDD, ; 2: Right
                        AFCF, ; 3: Down-right
                        AFC7, ; 4: Down, facing right
                        AFC7, ; 5: Down, facing left
                        AFCF, ; 6: Down-left
                        AFDD, ; 7: Left
                        AFCF, ; 8: Up-left
                        AFC7  ; 9: Up, facing left
}


;;; $AFC7: Missile block collision - vertical ;;;
{
$90:AFC7 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:AFCA 22 D9 A4 94 JSL $94A4D9[$94:A4D9]  ; Move (super) missile vertically
$90:AFCE 60          RTS
}


;;; $AFCF: Missile block collision - diagonal ;;;
{
$90:AFCF AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:AFD2 22 6F A4 94 JSL $94A46F[$94:A46F]  ; Move (super) missile horizontally
$90:AFD6 B0 04       BCS $04    [$AFDC]     ; If not collided:
$90:AFD8 22 D9 A4 94 JSL $94A4D9[$94:A4D9]  ; Move (super) missile vertically

$90:AFDC 60          RTS
}


;;; $AFDD: Missile block collision - horizontal ;;;
{
$90:AFDD AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:AFE0 22 6F A4 94 JSL $94A46F[$94:A46F]  ; Move (super) missile horizontally
$90:AFE4 60          RTS
}
}


;;; $AFE5..B098: Super missile ;;;
{
;;; $AFE5: Projectile pre-instruction - super missile ;;;
{
;; Parameters:
;;     X: Projectile index
$90:AFE5 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:AFE8 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:AFEB F0 06       BEQ $06    [$AFF3]     ;/
$90:AFED 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:AFF1 80 28       BRA $28    [$B01B]     ; Go to BRANCH_DELETE

$90:AFF3 DE 90 0C    DEC $0C90,x[$7E:0C90]  ; Decrement projectile trail timer
$90:AFF6 D0 0D       BNE $0D    [$B005]     ; If [projectile trail timer] = 0:
$90:AFF8 A9 02 00    LDA #$0002             ;\
$90:AFFB 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 2
$90:AFFE 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:B002 AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:B005 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B008 29 0F 00    AND #$000F             ;} Y = [projectile direction]
$90:B00B A8          TAY                    ;/
$90:B00C 20 F6 B2    JSR $B2F6  [$90:B2F6]  ; Accelerate (super) missile
$90:B00F 98          TYA                    ;\
$90:B010 0A          ASL A                  ;|
$90:B011 AA          TAX                    ;} Execute [$B033 + [projectile direction] * 2]
$90:B012 FC 33 B0    JSR ($B033,x)[$90:B06A];/
$90:B015 20 6A B1    JSR $B16A  [$90:B16A]  ; Delete projectile if too far off-screen
$90:B018 B0 01       BCS $01    [$B01B]     ; If projectile not deleted:
$90:B01A 60          RTS                    ; Return

; BRANCH_DELETE
$90:B01B A0 08 00    LDY #$0008             ; Y = 8 (projectile index)

; LOOP
$90:B01E B9 18 0C    LDA $0C18,y[$7E:0C20]  ;\
$90:B021 29 FF 0F    AND #$0FFF             ;|
$90:B024 C9 00 02    CMP #$0200             ;} If (projectile type) = super missile:
$90:B027 D0 05       BNE $05    [$B02E]     ;/
$90:B029 BB          TYX                    ; X = [Y]
$90:B02A 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile

$90:B02E 88          DEY                    ;\
$90:B02F 88          DEY                    ;} Y -= 2
$90:B030 10 EC       BPL $EC    [$B01E]     ; If [Y] >= 0: go to LOOP
$90:B032 60          RTS

$90:B033             dw B047, ; 0: Up, facing right
                        B052, ; 1: Up-right
                        B06A, ; 2: Right
                        B052, ; 3: Down-right
                        B047, ; 4: Down, facing right
                        B047, ; 5: Down, facing left
                        B052, ; 6: Down-left
                        B06A, ; 7: Left
                        B052, ; 8: Up-left
                        B047  ; 9: Up, facing left
}


;;; $B047: Super missile block collision - vertical ;;;
{
$90:B047 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B04A 22 D9 A4 94 JSL $94A4D9[$94:A4D9]  ; Move (super) missile vertically
$90:B04E 20 66 B3    JSR $B366  [$90:B366]  ; Super missile link vertical block collision detection
$90:B051 60          RTS
}


;;; $B052: Super missile block collision - diagonal ;;;
{
$90:B052 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B055 22 6F A4 94 JSL $94A46F[$94:A46F]  ; Move (super) missile horizontally
$90:B059 B0 0B       BCS $0B    [$B066]     ; If not collided:
$90:B05B 20 06 B4    JSR $B406  [$90:B406]  ; Super missile link horizontal block collision detection
$90:B05E 22 D9 A4 94 JSL $94A4D9[$94:A4D9]  ; Move (super) missile vertically
$90:B062 20 66 B3    JSR $B366  [$90:B366]  ; Super missile link vertical block collision detection
$90:B065 60          RTS                    ; Return

$90:B066 20 06 B4    JSR $B406  [$90:B406]  ; Super missile link horizontal block collision detection
$90:B069 60          RTS
}


;;; $B06A: Super missile block collision - horizontal ;;;
{
$90:B06A AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B06D 22 6F A4 94 JSL $94A46F[$94:A46F]  ; Move (super) missile horizontally
$90:B071 20 06 B4    JSR $B406  [$90:B406]  ; Super missile link horizontal block collision detection
$90:B074 60          RTS
}


;;; $B075: Projectile pre-instruction - super missile link ;;;
{
;; Parameters:
;;     X: Projectile index

; If super missile link is flagged for deletion, clear *all* super missile projectiles
$90:B075 BD 04 0C    LDA $0C04,x[$7E:0C06]  ;\
$90:B078 29 F0 00    AND #$00F0             ;} If projectile is not deleted: return
$90:B07B F0 1B       BEQ $1B    [$B098]     ;/
$90:B07D 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B081 A0 08 00    LDY #$0008             ; Y = 8 (projectile index)

; LOOP
$90:B084 B9 18 0C    LDA $0C18,y[$7E:0C20]  ;\
$90:B087 29 FF 0F    AND #$0FFF             ;|
$90:B08A C9 00 02    CMP #$0200             ;} If (projectile type) = super missile:
$90:B08D D0 05       BNE $05    [$B094]     ;/
$90:B08F BB          TYX                    ; X = [Y]
$90:B090 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile

$90:B094 88          DEY                    ;\
$90:B095 88          DEY                    ;} Y -= 2
$90:B096 10 EC       BPL $EC    [$B084]     ; If [Y] >= 0: go to LOOP

$90:B098 60          RTS
}
}


;;; $B099: Projectile pre-instruction - bomb ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B099 BD 04 0C    LDA $0C04,x[$7E:0C0E]  ;\
$90:B09C 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:B09F F0 05       BEQ $05    [$B0A6]     ;/
$90:B0A1 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B0A5 60          RTS                    ; Return

$90:B0A6 20 28 C1    JSR $C128  [$90:C128]  ; Handle bomb
$90:B0A9 22 AC 9C 94 JSL $949CAC[$94:9CAC]  ; (Power) bomb explosion block collision handling
$90:B0AD 60          RTS
}


;;; $B0AE: Projectile pre-instruction - power bomb ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B0AE BD 04 0C    LDA $0C04,x[$7E:0C0E]  ;\
$90:B0B1 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:B0B4 F0 05       BEQ $05    [$B0BB]     ;/
$90:B0B6 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B0BA 60          RTS                    ; Return

$90:B0BB 20 57 C1    JSR $C157  [$90:C157]  ; Handle power bomb
$90:B0BE 22 AC 9C 94 JSL $949CAC[$94:9CAC]  ; (Power) bomb explosion block collision handling
$90:B0C2 60          RTS
}


;;; $B0C3..B158: Wave beam ;;;
{
;;; $B0C3: Projectile pre-instruction - beam - wave + plasma/spazer / charged (ice) wave ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B0C3 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B0C6 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:B0C9 F0 05       BEQ $05    [$B0D0]     ;/
$90:B0CB 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B0CF 60          RTS                    ; Return

$90:B0D0 DE 90 0C    DEC $0C90,x[$7E:0C90]  ; Decrement projectile trail timer
$90:B0D3 D0 2E       BNE $2E    [$B103]     ; If [projectile trail timer] != 0: go to wave beam shared pre-instruction
$90:B0D5 A9 04 00    LDA #$0004             ;\
$90:B0D8 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 4
$90:B0DB 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:B0DF AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B0E2 80 1F       BRA $1F    [$B103]     ; Go to wave beam shared pre-instruction
}


;;; $B0E4: Projectile pre-instruction - beam - uncharged (ice) wave ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B0E4 BD 04 0C    LDA $0C04,x            ;\
$90:B0E7 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:B0EA F0 05       BEQ $05    [$B0F1]     ;/
$90:B0EC 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B0F0 60          RTS                    ; Return

$90:B0F1 DE 90 0C    DEC $0C90,x            ; Decrement projectile trail timer
$90:B0F4 D0 0D       BNE $0D    [$B103]     ; If [projectile trail timer] = 0:
$90:B0F6 A9 03 00    LDA #$0003             ;\
$90:B0F9 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 3
$90:B0FC 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:B100 AE DE 0D    LDX $0DDE  [$7E:0DDE]
}


;;; $B103: Wave beam shared pre-instruction ;;;
{
$90:B103 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B106 29 0F 00    AND #$000F             ;|
$90:B109 0A          ASL A                  ;} Y = ([projectile direction] & Fh) * 2
$90:B10A A8          TAY                    ;/
$90:B10B BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;\
$90:B10E 18          CLC                    ;|
$90:B10F 79 53 C3    ADC $C353,y[$90:C361]  ;} Projectile X velocity += [$C353 + [Y]]
$90:B112 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B115 BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;\
$90:B118 18          CLC                    ;|
$90:B119 79 67 C3    ADC $C367,y[$90:C375]  ;} Projectile Y velocity += [$C367 + [Y]]
$90:B11C 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:B11F BB          TYX                    ;\
$90:B120 FC 27 B1    JSR ($B127,x)[$90:B151];} Execute [$B127 + [Y]]
$90:B123 20 6A B1    JSR $B16A  [$90:B16A]  ; Delete projectile if too far off-screen
$90:B126 60          RTS

$90:B127             dw B13B, B143, B151, B143, B13B, B13B, B143, B151, B143, B13B
}


;;; $B13B: Wave beam block collision - vertical ;;;
{
$90:B13B AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B13E 22 E4 A3 94 JSL $94A3E4[$94:A3E4]  ; Move beam vertically - wave beam
$90:B142 60          RTS
}


;;; $B143: Wave beam block collision - diagonal ;;;
{
$90:B143 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B146 22 52 A3 94 JSL $94A352[$94:A352]  ; Move beam horizontally - wave beam
$90:B14A B0 04       BCS $04    [$B150]
$90:B14C 22 E4 A3 94 JSL $94A3E4[$94:A3E4]  ; Move beam vertically - wave beam

$90:B150 60          RTS
}


;;; $B151: Wave beam block collision - horizontal ;;;
{
$90:B151 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B154 22 52 A3 94 JSL $94A352[$94:A352]  ; Move beam horizontally - wave beam
$90:B158 60          RTS
}
}


;;; $B159: Projectile pre-instruction - hyper beam ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B159 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B15C 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:B15F F0 05       BEQ $05    [$B166]     ;/
$90:B161 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B165 60          RTS                    ; Return

$90:B166 4C 03 B1    JMP $B103  [$90:B103]  ; Go to wave beam shared pre-instruction
}


;;; $B169: RTS ;;;
{
$90:B169 60          RTS
}


;;; $B16A: Delete projectile if too far off-screen ;;;
{
;; Returns:
;;     Carry: Set if projectile deleted, clear otherwise
$90:B16A AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B16D BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$90:B170 38          SEC                    ;|
$90:B171 ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:B174 C9 C0 FF    CMP #$FFC0             ;} If -40h <= [projectile X position] < 140h: go to BRANCH_VERTICAL_CHECK
$90:B177 30 05       BMI $05    [$B17E]     ;|
$90:B179 C9 40 01    CMP #$0140             ;|
$90:B17C 30 06       BMI $06    [$B184]     ;/

; BRANCH_DELETE
$90:B17E 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:B182 38          SEC                    ;\
$90:B183 60          RTS                    ;} Return carry set

; BRANCH_VERTICAL_CHECK
$90:B184 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$90:B187 38          SEC                    ;|
$90:B188 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:B18B C9 C0 FF    CMP #$FFC0             ;} If not -40h <= [projectile Y position] < 140h: go to BRANCH_DELETE
$90:B18E 30 EE       BMI $EE    [$B17E]     ;|
$90:B190 C9 40 01    CMP #$0140             ;|
$90:B193 10 E9       BPL $E9    [$B17E]     ;/
$90:B195 18          CLC                    ;\
$90:B196 60          RTS                    ;} Return carry clear
}


;;; $B197..B2F5: Initialise projectile velocities ;;;
{
;;; $B197: Initialise beam velocities ;;;
{
;; Parameters:
;;     $14: Projectile index
$90:B197 08          PHP
$90:B198 8B          PHB
$90:B199 4B          PHK                    ;\
$90:B19A AB          PLB                    ;} DB = $90
$90:B19B C2 30       REP #$30
$90:B19D A6 14       LDX $14    [$7E:0014]  ; X = [$14] (projectile index)
$90:B19F BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B1A2 29 0F 00    AND #$000F             ;|
$90:B1A5 0A          ASL A                  ;} Y = (beam type) * 4
$90:B1A6 0A          ASL A                  ;|
$90:B1A7 A8          TAY                    ;/
$90:B1A8 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B1AB 29 0F 00    AND #$000F             ;|
$90:B1AE 0A          ASL A                  ;} If projectile direction is diagonal: go to BRANCH_DIAGONAL
$90:B1AF AA          TAX                    ;|
$90:B1B0 7C C9 B1    JMP ($B1C9,x)[$90:B1BA];/

$90:B1B3 B9 D1 C2    LDA $C2D1,y[$90:C2D1]  ;\
$90:B1B6 85 16       STA $16    [$7E:0016]  ;} $16 = [$C2D1 + [Y]] (base speed)
$90:B1B8 80 05       BRA $05    [$B1BF]     ; Go to BRANCH_MERGE

; BRANCH_DIAGONAL
$90:B1BA B9 D3 C2    LDA $C2D3,y[$90:C2D3]  ;\
$90:B1BD 85 16       STA $16    [$7E:0016]  ;} $16 = [$C2D1 + [Y] + 2] (base speed)

; BRANCH_MERGE
$90:B1BF A6 14       LDX $14    [$7E:0014]  ;\
$90:B1C1 86 12       STX $12    [$7E:0012]  ;} X = $12 = [$14]
$90:B1C3 20 F3 B1    JSR $B1F3  [$90:B1F3]  ; Initialise projectile velocities
$90:B1C6 AB          PLB
$90:B1C7 28          PLP
$90:B1C8 6B          RTL

$90:B1C9             dw B1B3, B1BA, B1B3, B1BA, B1B3, B1B3, B1BA, B1B3, B1BA, B1B3
}


;;; $B1DD: Initialise (super) missile velocities ;;;
{
;; Parameters:
;;     $14: Projectile index
$90:B1DD 08          PHP
$90:B1DE C2 30       REP #$30
$90:B1E0 A6 14       LDX $14    [$7E:0014]  ; X = [$14] (projectile index)
$90:B1E2 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B1E5 29 0F 00    AND #$000F             ;|
$90:B1E8 0A          ASL A                  ;} Y = (beam type) * 2
$90:B1E9 A8          TAY                    ;/
$90:B1EA 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (base speed)
$90:B1EC 86 12       STX $12    [$7E:0012]  ; $12 = [X]
$90:B1EE 20 F3 B1    JSR $B1F3  [$90:B1F3]  ; Initialise projectile velocities
$90:B1F1 28          PLP
$90:B1F2 60          RTS
}


;;; $B1F3: Initialise projectile velocities ;;;
{
;; Parameters:
;;     X: Projectile index
;;     $12: Projectile index
;;     $16: Base speed

; There's a repeating issue in all of the subroutines jumped to from here with how "distance Samus moved" is loaded
; These are the variables:
;     $0DAA.$0DAC: Distance Samus moved left
;     $0DAE.$0DB0: Distance Samus moved right
;     $0DB2.$0DB4: Distance Samus moved up
;     $0DB6.$0DB8: Distance Samus moved down

; Notice that the most significant word is stored before the least significant
; Generally speaking, it's more useful to extend little endian ordering and store the least significant word first
; If distance Samus moved left was $0DAC.$0DAA, then loading $0DAB would give (distance Samus moved left) * 100h,
; disregarding the high byte of $0DAC and low byte of $0DAA, which is a common trick used a lot in SM

; It looks like they tried to apply this trick without realising the ordering of the words isn't suitable
; E.g. $0DA9 is loaded into A for (distance Samus moved left) * 100h, which does load the low byte of $0DAA into the high byte of A,
; but also loads garbage (namely the high byte of $0DA8) into the low byte of A

; TODO: add these pesky garbage low bytes to the below calculations

$90:B1F3 9E 8C 0B    STZ $0B8C,x[$7E:0B8C]  ; Projectile X subposition = 0
$90:B1F6 9E A0 0B    STZ $0BA0,x[$7E:0BA0]  ; Projectile Y subposition = 0
$90:B1F9 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B1FC 29 0F 00    AND #$000F             ;|
$90:B1FF 0A          ASL A                  ;} Go to [$B204 + ([projectile direction] & Fh) * 2]
$90:B200 AA          TAX                    ;|
$90:B201 7C 04 B2    JMP ($B204,x)[$90:B2B4];/

$90:B204             dw B218, B23D, B268, B277, B28C, B28C, B29B, B2B4, B2C7, B218
}


;;; $B218: Initialise projectile velocities - up ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed

; Note: [distance Samus moved up] is negative
$90:B218 A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B21A AD B1 0D    LDA $0DB1  [$7E:0DB1]  ;\
$90:B21D 89 00 FF    BIT #$FF00             ;|
$90:B220 D0 04       BNE $04    [$B226]     ;|
$90:B222 64 12       STZ $12    [$7E:0012]  ;|
$90:B224 80 07       BRA $07    [$B22D]     ;|
                                            ;|
$90:B226 4A          LSR A                  ;|
$90:B227 4A          LSR A                  ;|
$90:B228 09 00 C0    ORA #$C000             ;} Projectile Y velocity = ±[distance Samus moved up] * 40h - [$16]
$90:B22B 85 12       STA $12    [$7E:0012]  ;|
                                            ;|
$90:B22D A5 16       LDA $16    [$7E:0016]  ;|
$90:B22F 49 FF FF    EOR #$FFFF             ;|
$90:B232 1A          INC A                  ;|
$90:B233 18          CLC                    ;|
$90:B234 65 12       ADC $12    [$7E:0012]  ;|
$90:B236 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:B239 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X velocity = 0
$90:B23C 60          RTS
}


;;; $B23D: Initialise projectile velocities - up-right ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed
$90:B23D A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B23F AD B1 0D    LDA $0DB1  [$7E:0DB1]  ;\
$90:B242 89 00 FF    BIT #$FF00             ;|
$90:B245 D0 04       BNE $04    [$B24B]     ;|
$90:B247 64 12       STZ $12    [$7E:0012]  ;|
$90:B249 80 07       BRA $07    [$B252]     ;|
                                            ;|
$90:B24B 4A          LSR A                  ;|
$90:B24C 4A          LSR A                  ;|
$90:B24D 09 00 C0    ORA #$C000             ;} Projectile Y velocity = ±[distance Samus moved up] * 40h - [$16]
$90:B250 85 12       STA $12    [$7E:0012]  ;|
                                            ;|
$90:B252 A5 16       LDA $16    [$7E:0016]  ;|
$90:B254 49 FF FF    EOR #$FFFF             ;|
$90:B257 1A          INC A                  ;|
$90:B258 18          CLC                    ;|
$90:B259 65 12       ADC $12    [$7E:0012]  ;|
$90:B25B 9D F0 0B    STA $0BF0,x[$7E:0BF2]  ;/
$90:B25E A5 16       LDA $16    [$7E:0016]  ;\
$90:B260 18          CLC                    ;|
$90:B261 6D AD 0D    ADC $0DAD  [$7E:0DAD]  ;} Projectile X velocity = [distance Samus moved right] * 100h + [$16]
$90:B264 9D DC 0B    STA $0BDC,x[$7E:0BDE]  ;/
$90:B267 60          RTS
}


;;; $B268: Initialise projectile velocities - right ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed
$90:B268 A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B26A 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y velocity = 0
$90:B26D A5 16       LDA $16    [$7E:0016]  ;\
$90:B26F 18          CLC                    ;|
$90:B270 6D AD 0D    ADC $0DAD  [$7E:0DAD]  ;} Projectile X velocity = [distance Samus moved right] * 100h + [$16]
$90:B273 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B276 60          RTS
}


;;; $B277: Initialise projectile velocities - down-right ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed
$90:B277 A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B279 A5 16       LDA $16    [$7E:0016]  ;\
$90:B27B 18          CLC                    ;|
$90:B27C 6D B5 0D    ADC $0DB5  [$7E:0DB5]  ;} Projectile Y velocity = [distance Samus moved down] * 100h + [$16]
$90:B27F 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:B282 A5 16       LDA $16    [$7E:0016]  ;\
$90:B284 18          CLC                    ;|
$90:B285 6D AD 0D    ADC $0DAD  [$7E:0DAD]  ;} Projectile X velocity = [distance Samus moved right] * 100h + [$16]
$90:B288 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B28B 60          RTS
}


;;; $B28C: Initialise projectile velocities - down ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed
$90:B28C A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B28E A5 16       LDA $16    [$7E:0016]  ;\
$90:B290 18          CLC                    ;|
$90:B291 6D B5 0D    ADC $0DB5  [$7E:0DB5]  ;} Projectile Y velocity = [distance Samus moved down] * 100h + [$16]
$90:B294 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:B297 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X velocity = 0
$90:B29A 60          RTS
}


;;; $B29B: Initialise projectile velocities - down-left ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed
$90:B29B A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B29D A5 16       LDA $16    [$7E:0016]  ;\
$90:B29F 18          CLC                    ;|
$90:B2A0 6D B5 0D    ADC $0DB5  [$7E:0DB5]  ;} Projectile Y velocity = [distance Samus moved down] * 100h + [$16]
$90:B2A3 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:B2A6 A5 16       LDA $16    [$7E:0016]  ;\
$90:B2A8 49 FF FF    EOR #$FFFF             ;|
$90:B2AB 1A          INC A                  ;|
$90:B2AC 18          CLC                    ;} Projectile X velocity = [distance Samus moved left] * 100h - [$16] + [camera Y subspeed] / 100h
$90:B2AD 6D A9 0D    ADC $0DA9  [$7E:0DA9]  ;|
$90:B2B0 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B2B3 60          RTS
}


;;; $B2B4: Initialise projectile velocities - left ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed

; Note: [distance Samus moved left] is negative
; The low byte of $0DA9 is the high byte of camera Y subspeed
$90:B2B4 A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B2B6 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y velocity = 0
$90:B2B9 A5 16       LDA $16    [$7E:0016]  ;\
$90:B2BB 49 FF FF    EOR #$FFFF             ;|
$90:B2BE 1A          INC A                  ;|
$90:B2BF 18          CLC                    ;} Projectile X velocity = [distance Samus moved left] * 100h - [$16] + [camera Y subspeed] / 100h
$90:B2C0 6D A9 0D    ADC $0DA9  [$7E:0DA9]  ;|
$90:B2C3 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B2C6 60          RTS
}


;;; $B2C7: Initialise projectile velocities - up-left ;;;
{
;; Parameters:
;;     $12: Projectile index
;;     $16: Base speed
$90:B2C7 A6 12       LDX $12    [$7E:0012]  ; X = [$12] (projectile index)
$90:B2C9 AD B1 0D    LDA $0DB1  [$7E:0DB1]  ;\
$90:B2CC 89 00 FF    BIT #$FF00             ;|
$90:B2CF D0 04       BNE $04    [$B2D5]     ;|
$90:B2D1 64 12       STZ $12    [$7E:0012]  ;|
$90:B2D3 80 07       BRA $07    [$B2DC]     ;|
                                            ;|
$90:B2D5 4A          LSR A                  ;|
$90:B2D6 4A          LSR A                  ;|
$90:B2D7 09 00 C0    ORA #$C000             ;} Projectile Y velocity = ±[distance Samus moved up] * 40h - [$16]
$90:B2DA 85 12       STA $12    [$7E:0012]  ;|
                                            ;|
$90:B2DC A5 16       LDA $16    [$7E:0016]  ;|
$90:B2DE 49 FF FF    EOR #$FFFF             ;|
$90:B2E1 1A          INC A                  ;|
$90:B2E2 18          CLC                    ;|
$90:B2E3 65 12       ADC $12    [$7E:0012]  ;|
$90:B2E5 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/
$90:B2E8 A5 16       LDA $16    [$7E:0016]  ;\
$90:B2EA 49 FF FF    EOR #$FFFF             ;|
$90:B2ED 1A          INC A                  ;|
$90:B2EE 18          CLC                    ;} Projectile X velocity = [distance Samus moved left] * 100h - [$16] + [camera Y subspeed] / 100h
$90:B2EF 6D A9 0D    ADC $0DA9  [$7E:0DA9]  ;|
$90:B2F2 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B2F5 60          RTS
}
}


;;; $B2F6: Accelerate (super) missile ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B2F6 08          PHP
$90:B2F7 C2 30       REP #$30
$90:B2F9 DA          PHX
$90:B2FA 5A          PHY
$90:B2FB BD 7C 0C    LDA $0C7C,x[$7E:0C7C]  ;\
$90:B2FE 29 00 FF    AND #$FF00             ;} If [projectile initialised flag] = 0:
$90:B301 D0 26       BNE $26    [$B329]     ;/
$90:B303 BD 7C 0C    LDA $0C7C,x[$7E:0C7C]  ;\
$90:B306 18          CLC                    ;|
$90:B307 6D 01 C3    ADC $C301  [$90:C301]  ;} Projectile initialised flag = 1
$90:B30A 9D 7C 0C    STA $0C7C,x[$7E:0C7C]  ;/
$90:B30D 29 00 FF    AND #$FF00             ;\
$90:B310 F0 50       BEQ $50    [$B362]     ;} >_<;
$90:B312 BD 7C 0C    LDA $0C7C,x[$7E:0C7C]  ;\
$90:B315 85 16       STA $16    [$7E:0016]  ;} $16 = 100h + [projectile extra base speed] (base speed)
$90:B317 86 12       STX $12    [$7E:0012]  ; $12 = [projectile index]
$90:B319 20 F3 B1    JSR $B1F3  [$90:B1F3]  ; Initialise projectile velocities
$90:B31C BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B31F 89 00 02    BIT #$0200             ;} If [projectile type] != super missile: return
$90:B322 F0 3E       BEQ $3E    [$B362]     ;/
$90:B324 20 46 BF    JSR $BF46  [$90:BF46]  ; Spawn super missile link
$90:B327 80 39       BRA $39    [$B362]     ; Return

$90:B329 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:B32C 29 0F 00    AND #$000F             ;|
$90:B32F 0A          ASL A                  ;} $12 = ([projectile direction] & Fh) * 4
$90:B330 0A          ASL A                  ;|
$90:B331 85 12       STA $12    [$7E:0012]  ;/
$90:B333 BD 19 0C    LDA $0C19,x[$7E:0C19]  ;\
$90:B336 29 0F 00    AND #$000F             ;|
$90:B339 89 02 00    BIT #$0002             ;} If [projectile type] != super missile:
$90:B33C D0 09       BNE $09    [$B347]     ;/
$90:B33E A9 03 C3    LDA #$C303             ;\
$90:B341 18          CLC                    ;|
$90:B342 65 12       ADC $12    [$7E:0012]  ;} Y = $C303 + [$12]
$90:B344 A8          TAY                    ;/
$90:B345 80 07       BRA $07    [$B34E]

$90:B347 A9 2B C3    LDA #$C32B             ;\ Else ([projectile type] = super missile):
$90:B34A 18          CLC                    ;|
$90:B34B 65 12       ADC $12    [$7E:0012]  ;} Y = $C32B + [$12]
$90:B34D A8          TAY                    ;/

$90:B34E BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;\
$90:B351 18          CLC                    ;|
$90:B352 79 00 00    ADC $0000,y[$90:C31F]  ;} Projectile X velocity += [[Y]]
$90:B355 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;/
$90:B358 BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;\
$90:B35B 18          CLC                    ;|
$90:B35C 79 02 00    ADC $0002,y[$90:C321]  ;} Projectile Y velocity += [[Y] + 2]
$90:B35F 9D F0 0B    STA $0BF0,x[$7E:0BF0]  ;/

$90:B362 7A          PLY
$90:B363 FA          PLX
$90:B364 28          PLP
$90:B365 60          RTS
}


;;; $B366..B4C8: Super missile link ;;;
{
;;; $B366: Super missile link vertical block collision detection ;;;
{
; If the super missile is moving fast enough vertically, at least Bh px/frame,
; do an additional collision check Ah pixels ahead of the old Y position
$90:B366 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B369 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B36C 29 00 0F    AND #$0F00             ;|
$90:B36F C9 00 02    CMP #$0200             ;} If (projectile type) != super missile:
$90:B372 F0 06       BEQ $06    [$B37A]     ;/
$90:B374 C9 00 08    CMP #$0800             ;\
$90:B377 F0 01       BEQ $01    [$B37A]     ;} If (projectile type) != (super) missile explosion:
$90:B379 60          RTS                    ; Return

$90:B37A BD 7C 0C    LDA $0C7C,x[$7E:0C7C]  ;\
$90:B37D 89 00 FF    BIT #$FF00             ;} If [projectile initialised flag] = 0:
$90:B380 D0 01       BNE $01    [$B383]     ;/
$90:B382 60          RTS                    ; Return

$90:B383 29 FF 00    AND #$00FF             ;\
$90:B386 A8          TAY                    ;} Y = [projectile super missile link index]
$90:B387 BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;\
$90:B38A 10 04       BPL $04    [$B390]     ;|
$90:B38C 49 FF FF    EOR #$FFFF             ;|
$90:B38F 1A          INC A                  ;|
                                            ;} If |[projectile Y velocity]| / 100h < Bh: go to BRANCH_SLOW
$90:B390 29 00 FF    AND #$FF00             ;|
$90:B393 C9 00 0B    CMP #$0B00             ;|
$90:B396 30 5C       BMI $5C    [$B3F4]     ;/
$90:B398 EB          XBA                    ;\
$90:B399 38          SEC                    ;|
$90:B39A E9 0A 00    SBC #$000A             ;} $12 = |[projectile Y velocity]| / 100h - Ah
$90:B39D 85 12       STA $12    [$7E:0012]  ;/
$90:B39F BD F0 0B    LDA $0BF0,x[$7E:0BF0]  ;\
$90:B3A2 30 28       BMI $28    [$B3CC]     ;} If [projectile Y velocity] < 0: go to BRANCH_UPWARDS
$90:B3A4 DA          PHX                    ; Save X (projectile index)
$90:B3A5 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$90:B3A8 38          SEC                    ;|
$90:B3A9 E5 12       SBC $12    [$7E:0012]  ;} Linked projectile Y position = [projectile Y position] - [projectile Y velocity] / 100h + Ah
$90:B3AB 99 78 0B    STA $0B78,y[$7E:0B7A]  ;/
$90:B3AE BB          TYX                    ;\
$90:B3AF 8C DE 0D    STY $0DDE  [$7E:0DDE]  ;} X = projectile index = [Y]
$90:B3B2 22 D9 A4 94 JSL $94A4D9[$94:A4D9]  ; Move (super) missile vertically
$90:B3B6 9B          TXY
$90:B3B7 FA          PLX                    ; Restore X
$90:B3B8 8E DE 0D    STX $0DDE  [$7E:0DDE]
$90:B3BB BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B3BE 29 00 0F    AND #$0F00             ;|
$90:B3C1 C9 00 08    CMP #$0800             ;} If (projectile type) = (super) missile explosion:
$90:B3C4 D0 05       BNE $05    [$B3CB]     ;/
$90:B3C6 BB          TYX                    ;\
$90:B3C7 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear linked projectile

$90:B3CB 60          RTS                    ; Return

; BRANCH_UPWARDS
$90:B3CC DA          PHX                    ; Save X (projectile index)
$90:B3CD BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$90:B3D0 18          CLC                    ;|
$90:B3D1 65 12       ADC $12    [$7E:0012]  ;} Linked projectile Y position = [projectile Y position] - [projectile Y velocity] / 100h - Ah
$90:B3D3 99 78 0B    STA $0B78,y[$7E:0B7A]  ;/
$90:B3D6 BB          TYX                    ;\
$90:B3D7 8C DE 0D    STY $0DDE  [$7E:0DDE]  ;} X = projectile index = [Y]
$90:B3DA 22 D9 A4 94 JSL $94A4D9[$94:A4D9]  ; Move (super) missile vertically
$90:B3DE 9B          TXY
$90:B3DF FA          PLX                    ; Restore X
$90:B3E0 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:B3E3 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B3E6 29 00 0F    AND #$0F00             ;|
$90:B3E9 C9 00 08    CMP #$0800             ;} If (projectile type) != (super) missile explosion: return
$90:B3EC D0 DD       BNE $DD    [$B3CB]     ;/

; BRANCH_EXPLOSION
$90:B3EE BB          TYX                    ;\
$90:B3EF 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear linked projectile
$90:B3F3 60          RTS                    ; Return

; BRANCH_SLOW
$90:B3F4 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B3F7 29 00 0F    AND #$0F00             ;|
$90:B3FA C9 00 08    CMP #$0800             ;} If (projectile type) = (super) missile explosion: go to BRANCH_EXPLOSION
$90:B3FD F0 EF       BEQ $EF    [$B3EE]     ;/
$90:B3FF BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$90:B402 99 78 0B    STA $0B78,y[$7E:0B7A]  ;} Linked projectile Y position = [projectile Y position]
$90:B405 60          RTS
}


;;; $B406: Super missile link horizontal block collision detection ;;;
{
; If the super missile is moving fast enough horizontally, at least Bh px/frame,
; do an additional collision check Ah pixels ahead of the old X position
$90:B406 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B409 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B40C 29 00 0F    AND #$0F00             ;|
$90:B40F C9 00 02    CMP #$0200             ;} If (projectile type) != super missile:
$90:B412 F0 06       BEQ $06    [$B41A]     ;/
$90:B414 C9 00 08    CMP #$0800             ;\
$90:B417 F0 01       BEQ $01    [$B41A]     ;} If (projectile type) != (super) missile explosion:
$90:B419 60          RTS                    ; Return

$90:B41A BD 7C 0C    LDA $0C7C,x[$7E:0C7C]  ;\
$90:B41D 89 00 FF    BIT #$FF00             ;} If [projectile initialised flag] = 0:
$90:B420 D0 01       BNE $01    [$B423]     ;/
$90:B422 60          RTS                    ; Return

$90:B423 29 FF 00    AND #$00FF             ;\
$90:B426 A8          TAY                    ;} Y = [projectile super missile link index]
$90:B427 BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;\
$90:B42A 10 04       BPL $04    [$B430]     ;|
$90:B42C 49 FF FF    EOR #$FFFF             ;|
$90:B42F 1A          INC A                  ;|
                                            ;} If |[projectile X velocity]| / 100h < Bh: go to BRANCH_SLOW
$90:B430 29 00 FF    AND #$FF00             ;|
$90:B433 C9 00 0B    CMP #$0B00             ;|
$90:B436 30 5C       BMI $5C    [$B494]     ;/
$90:B438 EB          XBA                    ;\
$90:B439 38          SEC                    ;|
$90:B43A E9 0A 00    SBC #$000A             ;} $12 = |[projectile X velocity]| / 100h - Ah
$90:B43D 85 12       STA $12    [$7E:0012]  ;/
$90:B43F BD DC 0B    LDA $0BDC,x[$7E:0BDC]  ;\
$90:B442 30 28       BMI $28    [$B46C]     ;} If [projectile X velocity] < 0: go to BRANCH_LEFTWARDS
$90:B444 DA          PHX                    ; Save X (projectile index)
$90:B445 BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$90:B448 38          SEC                    ;|
$90:B449 E5 12       SBC $12    [$7E:0012]  ;} Linked projectile X position = [projectile X position] - [projectile X velocity] / 100h + Ah
$90:B44B 99 64 0B    STA $0B64,y[$7E:0B66]  ;/
$90:B44E BB          TYX                    ;\
$90:B44F 8C DE 0D    STY $0DDE  [$7E:0DDE]  ;} X = projectile index = [Y]
$90:B452 22 6F A4 94 JSL $94A46F[$94:A46F]  ; Move (super) missile horizontally
$90:B456 9B          TXY
$90:B457 FA          PLX                    ; Restore X
$90:B458 8E DE 0D    STX $0DDE  [$7E:0DDE]
$90:B45B BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B45E 29 00 0F    AND #$0F00             ;|
$90:B461 C9 00 08    CMP #$0800             ;} If (projectile type) = (super) missile explosion:
$90:B464 D0 05       BNE $05    [$B46B]     ;/
$90:B466 BB          TYX                    ;\
$90:B467 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear linked projectile

$90:B46B 60          RTS                    ; Return

; BRANCH_LEFTWARDS
$90:B46C DA          PHX                    ; Save X (projectile index)
$90:B46D BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$90:B470 18          CLC                    ;|
$90:B471 65 12       ADC $12    [$7E:0012]  ;} Linked projectile X position = [projectile X position] - [projectile X velocity] / 100h - Ah
$90:B473 99 64 0B    STA $0B64,y[$7E:0B66]  ;/
$90:B476 BB          TYX                    ;\
$90:B477 8C DE 0D    STY $0DDE  [$7E:0DDE]  ;} X = projectile index = [Y]
$90:B47A 22 6F A4 94 JSL $94A46F[$94:A46F]  ; Move (super) missile horizontally
$90:B47E 9B          TXY
$90:B47F FA          PLX                    ; Restore X
$90:B480 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:B483 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B486 29 00 0F    AND #$0F00             ;|
$90:B489 C9 00 08    CMP #$0800             ;} If (projectile type) != (super) missile explosion: return
$90:B48C D0 DD       BNE $DD    [$B46B]     ;/

; BRANCH_EXPLOSION
$90:B48E BB          TYX                    ;\
$90:B48F 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear linked projectile
$90:B493 60          RTS                    ; Return

; BRANCH_SLOW
$90:B494 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B497 29 00 0F    AND #$0F00             ;|
$90:B49A C9 00 08    CMP #$0800             ;} If (projectile type) = (super) missile explosion: go to BRANCH_EXPLOSION
$90:B49D F0 EF       BEQ $EF    [$B48E]     ;/
$90:B49F BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$90:B4A2 99 64 0B    STA $0B64,y[$7E:0B66]  ;} Linked projectile X position = [projectile X position]
$90:B4A5 60          RTS
}


;;; $B4A6: Unused. Clear linked super missile if super missile explosion ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B4A6 08          PHP
$90:B4A7 C2 30       REP #$30
$90:B4A9 BD 7C 0C    LDA $0C7C,x            ;\
$90:B4AC 89 00 FF    BIT #$FF00             ;} If [projectile initialised flag] = 0:
$90:B4AF D0 02       BNE $02    [$B4B3]     ;/
$90:B4B1 28          PLP
$90:B4B2 6B          RTL                    ; Return

$90:B4B3 29 FF 00    AND #$00FF             ;\
$90:B4B6 A8          TAY                    ;} Y = [projectile super missile link index]
$90:B4B7 BD 18 0C    LDA $0C18,x            ;\
$90:B4BA 29 00 0F    AND #$0F00             ;|
$90:B4BD C9 00 08    CMP #$0800             ;} If (projectile type) = (super) missile explosion:
$90:B4C0 D0 05       BNE $05    [$B4C7]     ;/
$90:B4C2 BB          TYX                    ;\
$90:B4C3 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear linked projectile

$90:B4C7 28          PLP
$90:B4C8 6B          RTL
}
}


;;; $B4C9..B80C: Projectile trail ;;;
{
;;; $B4C9: Instruction list - beam trail - empty ;;;
{
$90:B4C9             dw 0000
}


;;; $B4CB: Instruction list - left beam trail - ice beams / charged power beam ;;;
{
$90:B4CB             dw 0001,2C38,
                        0001,2C38,
                        0001,2C38,
                        0001,2C38,
                        0001,2C39,
                        0001,2C39,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C39,
                        0001,2C39,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0001,2C3A,
                        B525,       ; Move left projectile trail down one pixel
                        0004,2C3B,
                        0000
}


;;; $B525: Instruction - move left projectile trail down one pixel ;;;
{
;; Parameters:
;;     Y: Projectile trail index
$90:B525 B9 78 D7    LDA $D778,y[$7E:D79A]
$90:B528 1A          INC A
$90:B529 99 78 D7    STA $D778,y[$7E:D79A]
$90:B52C 60          RTS
}


;;; $B52D: Instruction list - right beam trail - some ice beams ;;;
{
$90:B52D             dw 0001,2C38,
                        0001,2C38,
                        0001,2C38,
                        0001,2C38,
                        0001,2C39,
                        0001,2C39,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C39,
                        0001,2C39,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0001,2C3A,
                        B587,       ; Move right projectile trail down one pixel
                        0004,2C3B,
                        0000
}


;;; $B587: Instruction - move right projectile trail down one pixel ;;;
{
;; Parameters:
;;     Y: Projectile trail index
$90:B587 B9 9C D7    LDA $D79C,y[$7E:D7BE]
$90:B58A 1A          INC A
$90:B58B 99 9C D7    STA $D79C,y[$7E:D7BE]
$90:B58E 60          RTS
}


;;; $B58F: Instruction list - beam trail - wave beam ;;;
{
$90:B58F             dw 0004,2A3C,
                        0004,2A3D,
                        0004,2A3E,
                        0004,2A3F,
                        0000
}


;;; $B5A1: Instruction list - beam trail - (super) missile ;;;
{
$90:B5A1             dw 0004,2A48,
                        0004,2A49,
                        0004,2A4A,
                        0004,2A4B,
                        0000
}


;;; $B5B3: Instruction - move left projectile trail up one pixel ;;;
{
;; Parameters:
;;     Y: Projectile trail index
$90:B5B3 B9 78 D7    LDA $D778,y
$90:B5B6 3A          DEC A
$90:B5B7 99 78 D7    STA $D778,y
$90:B5BA 60          RTS
}


;;; $B5BB: Projectile trail instruction list pointers - left ;;;
{
$90:B5BB             dw B4C9, ;  0: Uncharged power
                        B58F, ; *1: Uncharged wave
                        B4CB, ; *2: Uncharged ice
                        B4CB, ; *3: Uncharged ice + wave
                        B4C9, ;  4: Uncharged spazer
                        B4C9, ;  5: Uncharged spazer + wave
                        B4CB, ; *6: Uncharged spazer + ice
                        B4CB, ; *7: Uncharged spazer + ice + wave
                        B4C9, ;  8: Uncharged plasma
                        B4C9, ;  9: Uncharged plasma + wave
                        B4CB, ; *Ah: Uncharged plasma + ice
                        B4CB, ; *Bh: Uncharged plasma + ice + wave
                        B4C9, ;  Ch
                        B4C9, ;  Dh
                        B4C9, ;  Eh
                        B4C9, ;  Fh
                        B4CB, ; *10h: Charged power
                        B58F, ; *11h: Charged wave
                        B4CB, ; *12h: Charged ice
                        B4CB, ; *13h: Charged ice + wave
                        B4C9, ;  14h: Charged spazer
                        B4C9, ;  15h: Charged spazer + wave
                        B4CB, ; *16h: Charged spazer + ice
                        B4CB, ; *17h: Charged spazer + ice + wave
                        B4C9, ;  18h: Charged plasma
                        B4C9, ;  19h: Charged plasma + wave
                        B4CB, ; *1Ah: Charged plasma + ice
                        B4CB, ; *1Bh: Charged plasma + ice + wave
                        B4C9, ;  1Ch
                        B4C9, ;  1Dh
                        B4C9, ;  1Eh
                        B4C9, ;  1Fh
                        B5A1, ; *20h: Missile
                        B5A1, ; *21h: Super missile
                        B4C9, ;  22h
                        B4C9, ;  23h
                        B4CB, ; *24h: Spazer SBA trail
                        B4CB, ; *25h
                        B4CB  ; *26h
}


;;; $B609: Projectile trail instruction list pointers - right ;;;
{
$90:B609             dw B4C9, ;  0: Uncharged power
                        B4C9, ;  1: Uncharged wave
                        B4C9, ;  2: Uncharged ice
                        B4C9, ;  3: Uncharged ice + wave
                        B4C9, ;  4: Uncharged spazer
                        B4C9, ;  5: Uncharged spazer + wave
                        B52D, ; *6: Uncharged spazer + ice
                        B52D, ; *7: Uncharged spazer + ice + wave
                        B4C9, ;  8: Uncharged plasma
                        B4C9, ;  9: Uncharged plasma + wave
                        B4C9, ;  Ah: Uncharged plasma + ice
                        B52D, ; *Bh: Uncharged plasma + ice + wave
                        B4C9, ;  Ch
                        B4C9, ;  Dh
                        B4C9, ;  Eh
                        B4C9, ;  Fh
                        B4C9, ;  10h: Charged power
                        B58F, ; *11h: Charged wave
                        B4C9, ;  12h: Charged ice
                        B52D, ; *13h: Charged ice + wave
                        B4C9, ;  14h: Charged spazer
                        B4C9, ;  15h: Charged spazer + wave
                        B52D, ; *16h: Charged spazer + ice
                        B52D, ; *17h: Charged spazer + ice + wave
                        B4C9, ;  18h: Charged plasma
                        B4C9, ;  19h: Charged plasma + wave
                        B4C9, ;  1Ah: Charged plasma + ice
                        B52D, ; *1Bh: Charged plasma + ice + wave
                        B4C9, ;  1Ch
                        B4C9, ;  1Dh
                        B4C9, ;  1Eh
                        B4C9, ;  1Fh
                        B4C9, ;  20h: Missile
                        B4C9, ;  21h: Super missile
                        B4C9, ;  22h
                        B4C9, ;  23h
                        B4CB, ; *24h: Spazer SBA trail
                        B52D, ; *25h
                        B4CB  ; *26h
}


;;; $B657: Spawn projectile trail ;;;
{
;; Parameters:
;;     X: Projectile index
$90:B657 8B          PHB
$90:B658 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B65B 89 00 0F    BIT #$0F00             ;} If projectile is beam:
$90:B65E D0 05       BNE $05    [$B665]     ;/
$90:B660 29 3F 00    AND #$003F             ; A = [projectile type] & 3Fh
$90:B663 80 0D       BRA $0D    [$B672]

$90:B665 EB          XBA                    ;\ Else (projectile is not beam):
$90:B666 29 0F 00    AND #$000F             ;|
$90:B669 C9 03 00    CMP #$0003             ;} If projectile is not (super) missile: return carry set
$90:B66C B0 17       BCS $17    [$B685]     ;/
$90:B66E 18          CLC                    ;\
$90:B66F 69 1F 00    ADC #$001F             ;} A = (projectile type) + 1Fh

$90:B672 0A          ASL A                  ;\
$90:B673 AA          TAX                    ;} X = [A] * 2
$90:B674 F4 7E 7E    PEA $7E7E              ;\
$90:B677 AB          PLB                    ;} DB = $7E
$90:B678 AB          PLB                    ;/
$90:B679 A0 22 00    LDY #$0022             ; Y = 22h (projectile trail index)

; LOOP
$90:B67C B9 58 D6    LDA $D658,y[$7E:D67A]  ;\
$90:B67F F0 07       BEQ $07    [$B688]     ;} If [projectile trail left instruction timer] = 0: go to BRANCH_FOUND
$90:B681 88          DEY                    ;\
$90:B682 88          DEY                    ;} Y -= 2
$90:B683 10 F7       BPL $F7    [$B67C]     ; If [Y] >= 0: go to LOOP

$90:B685 AB          PLB
$90:B686 38          SEC                    ;\
$90:B687 6B          RTL                    ;} Return carry set

; BRANCH_FOUND
$90:B688 A9 01 00    LDA #$0001             ;\
$90:B68B 99 58 D6    STA $D658,y[$7E:D67A]  ;} Projectile trail left instruction timer = 1
$90:B68E 99 7C D6    STA $D67C,y[$7E:D69E]  ; Projectile trail right instruction timer = 1
$90:B691 BF BB B5 90 LDA $90B5BB,x[$90:B5FB];\
$90:B695 99 A0 D6    STA $D6A0,y[$7E:D6C2]  ;} Projectile trail left instruction list pointer = [$90:B5BB + [X]]
$90:B698 BF 09 B6 90 LDA $90B609,x[$90:B649];\
$90:B69C 99 C4 D6    STA $D6C4,y[$7E:D6E6]  ;} Projectile trail right instruction list pointer = [$90:B609 + [X]]
$90:B69F AE DE 0D    LDX $0DDE  [$7E:0DDE]  ; X = [projectile index]
$90:B6A2 22 CC A3 9B JSL $9BA3CC[$9B:A3CC]  ; Set projectile trail position
$90:B6A6 AB          PLB
$90:B6A7 18          CLC                    ;\
$90:B6A8 6B          RTL                    ;} Return carry clear
}


;;; $B6A9: Handle projectile trails ;;;
{
$90:B6A9 8B          PHB
$90:B6AA F4 7E 7E    PEA $7E7E              ;\
$90:B6AD AB          PLB                    ;} DB = $7E
$90:B6AE AB          PLB                    ;/
$90:B6AF AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:B6B2 F0 03       BEQ $03    [$B6B7]     ;} If time is frozen:
$90:B6B4 4C 8F B7    JMP $B78F  [$90:B78F]  ; Go to BRANCH_TIME_IS_FROZEN

$90:B6B7 A0 22 00    LDY #$0022             ; Y = 22h (projectile trail index)

; LOOP_MAIN
$90:B6BA B9 58 D6    LDA $D658,y[$7E:D67A]  ;\
$90:B6BD F0 61       BEQ $61    [$B720]     ;} If [projectile trail left instruction timer] = 0: go to BRANCH_LEFT_TRAIL_END
$90:B6BF 3A          DEC A                  ;\
$90:B6C0 99 58 D6    STA $D658,y[$7E:D67A]  ;} Decrement projectile trail left instruction timer
$90:B6C3 D0 27       BNE $27    [$B6EC]     ; If [projectile trail left instruction timer] != 0: go to BRANCH_LEFT_INSTRUCTIONS_END
$90:B6C5 BE A0 D6    LDX $D6A0,y[$7E:D6C2]  ; X = [projectile trail left instruction list pointer]

; LOOP_LEFT
$90:B6C8 BF 00 00 90 LDA $900000,x[$90:B5A1];\
$90:B6CC 10 0A       BPL $0A    [$B6D8]     ;} If [$90:0000 + [X]] & 8000h != 0:
$90:B6CE E8          INX                    ;\
$90:B6CF E8          INX                    ;} X += 2
$90:B6D0 F4 C7 B6    PEA $B6C7              ; Return to LOOP_LEFT
$90:B6D3 85 12       STA $12    [$7E:0012]  ;\
$90:B6D5 6C 12 00    JMP ($0012)[$90:B525]  ;} Go to [$90:0000 + [X]]

$90:B6D8 99 58 D6    STA $D658,y[$7E:D67A]  ; Projectile trail left instruction timer = [$90:0000 + [X]]
$90:B6DB F0 43       BEQ $43    [$B720]     ; If [projectile trail left instruction timer] = 0 (terminator): go to BRANCH_LEFT_TRAIL_END
$90:B6DD BF 02 00 90 LDA $900002,x[$90:B5A3];\
$90:B6E1 99 E8 D6    STA $D6E8,y[$7E:D70A]  ;} Projectile trail left tile number and attributes = [$90:0000 + [X] + 2]
$90:B6E4 8A          TXA                    ;\
$90:B6E5 18          CLC                    ;|
$90:B6E6 69 04 00    ADC #$0004             ;} Projectile trail left instruction list pointer = [X] + 4
$90:B6E9 99 A0 D6    STA $D6A0,y[$7E:D6C2]  ;/

; BRANCH_LEFT_INSTRUCTIONS_END
$90:B6EC AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:B6EF E0 00 02    CPX #$0200             ;\
$90:B6F2 10 2C       BPL $2C    [$B720]     ;} If [OAM stack pointer] < 200h:
$90:B6F4 B9 30 D7    LDA $D730,y[$7E:D752]  ;\
$90:B6F7 38          SEC                    ;|
$90:B6F8 ED 11 09    SBC $0911  [$7E:0911]  ;} If [projectile trail left X position] >= [layer 1 X position]:
$90:B6FB 89 00 FF    BIT #$FF00             ;|
$90:B6FE D0 20       BNE $20    [$B720]     ;/
$90:B700 9D 70 03    STA $0370,x[$7E:0398]  ; OAM entry X position = [projectile trail left X position] - [layer 1 X position]
$90:B703 B9 78 D7    LDA $D778,y[$7E:D79A]  ;\
$90:B706 38          SEC                    ;|
$90:B707 ED 15 09    SBC $0915  [$7E:0915]  ;} If [projectile trail left Y position] >= [layer 1 Y position]:
$90:B70A 89 00 FF    BIT #$FF00             ;|
$90:B70D D0 11       BNE $11    [$B720]     ;/
$90:B70F 9D 71 03    STA $0371,x[$7E:0399]  ; OAM entry Y position = [projectile trail left Y position] - [layer 1 Y position]
$90:B712 B9 E8 D6    LDA $D6E8,y[$7E:D70A]  ;\
$90:B715 9D 72 03    STA $0372,x[$7E:039A]  ;} OAM entry tile number and attributes = [projectile trail left tile number and attributes]
$90:B718 8A          TXA                    ;\
$90:B719 18          CLC                    ;|
$90:B71A 69 04 00    ADC #$0004             ;} OAM stack pointer += 4
$90:B71D 8D 90 05    STA $0590  [$7E:0590]  ;/

; BRANCH_LEFT_TRAIL_END
$90:B720 B9 7C D6    LDA $D67C,y[$7E:D69E]  ;\
$90:B723 F0 61       BEQ $61    [$B786]     ;} If [projectile trail right instruction timer] = 0: go to BRANCH_RIGHT_TRAIL_END
$90:B725 3A          DEC A                  ;\
$90:B726 99 7C D6    STA $D67C,y[$7E:D69E]  ;} Decrement projectile trail right instruction timer
$90:B729 D0 27       BNE $27    [$B752]     ; If [projectile trail right instruction timer] != 0: go to BRANCH_RIGHT_INSTRUCTIONS_END
$90:B72B BE C4 D6    LDX $D6C4,y[$7E:D6E6]  ; X = [projectile trail right instruction list pointer]

; LOOP_RIGHT
$90:B72E BF 00 00 90 LDA $900000,x[$90:B4C9];\
$90:B732 10 0A       BPL $0A    [$B73E]     ;} If [$90:0000 + [X]] & 8000h != 0:
$90:B734 E8          INX                    ;\
$90:B735 E8          INX                    ;} X += 2
$90:B736 F4 2D B7    PEA $B72D              ; Return to LOOP_RIGHT
$90:B739 85 12       STA $12    [$7E:0012]  ;\
$90:B73B 6C 12 00    JMP ($0012)[$90:B587]  ;} Go to [$90:0000 + [X]]

$90:B73E 99 7C D6    STA $D67C,y[$7E:D69E]  ; Projectile trail right instruction timer = [$90:0000 + [X]]
$90:B741 F0 43       BEQ $43    [$B786]     ; If [projectile trail right instruction timer] = 0 (terminator): go to BRANCH_RIGHT_TRAIL_END
$90:B743 BF 02 00 90 LDA $900002,x[$90:B52F];\
$90:B747 99 0C D7    STA $D70C,y[$7E:D72E]  ;} Projectile trail right tile number and attributes = [$90:0000 + [X] + 2]
$90:B74A 8A          TXA                    ;\
$90:B74B 18          CLC                    ;|
$90:B74C 69 04 00    ADC #$0004             ;} Projectile trail right instruction list pointer = [X] + 4
$90:B74F 99 C4 D6    STA $D6C4,y[$7E:D6E6]  ;/

; BRANCH_RIGHT_INSTRUCTIONS_END
$90:B752 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:B755 E0 00 02    CPX #$0200             ;\
$90:B758 10 2C       BPL $2C    [$B786]     ;} If [OAM stack pointer] < 200h:
$90:B75A B9 54 D7    LDA $D754,y[$7E:D776]  ;\
$90:B75D 38          SEC                    ;|
$90:B75E ED 11 09    SBC $0911  [$7E:0911]  ;} If [projectile trail right X position] >= [layer 1 X position]:
$90:B761 89 00 FF    BIT #$FF00             ;|
$90:B764 D0 20       BNE $20    [$B786]     ;/
$90:B766 9D 70 03    STA $0370,x[$7E:03A0]  ; OAM entry X position = [projectile trail right X position] - [layer 1 X position]
$90:B769 B9 9C D7    LDA $D79C,y[$7E:D7BE]  ;\
$90:B76C 38          SEC                    ;|
$90:B76D ED 15 09    SBC $0915  [$7E:0915]  ;} If [projectile trail right Y position] >= [layer 1 Y position]:
$90:B770 89 00 FF    BIT #$FF00             ;|
$90:B773 D0 11       BNE $11    [$B786]     ;/
$90:B775 9D 71 03    STA $0371,x[$7E:03A1]  ; OAM entry Y position = [projectile trail right Y position] - [layer 1 Y position]
$90:B778 B9 0C D7    LDA $D70C,y[$7E:D72E]  ;\
$90:B77B 9D 72 03    STA $0372,x[$7E:03A2]  ;} OAM entry tile number and attributes = [projectile trail right tile number and attributes]
$90:B77E 8A          TXA                    ;\
$90:B77F 18          CLC                    ;|
$90:B780 69 04 00    ADC #$0004             ;} OAM stack pointer += 4
$90:B783 8D 90 05    STA $0590  [$7E:0590]  ;/

; BRANCH_RIGHT_TRAIL_END
$90:B786 88          DEY                    ;\
$90:B787 88          DEY                    ;} Y -= 2
$90:B788 30 03       BMI $03    [$B78D]     ; If [Y] >= 0:
$90:B78A 4C BA B6    JMP $B6BA  [$90:B6BA]  ; Go to LOOP_MAIN

$90:B78D AB          PLB
$90:B78E 6B          RTL                    ; Return

; BRANCH_TIME_IS_FROZEN
$90:B78F A0 22 00    LDY #$0022             ; Y = 22h (projectile trail index)

; LOOP_TIME_IS_FROZEN
$90:B792 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:B795 E0 00 02    CPX #$0200             ;\
$90:B798 10 31       BPL $31    [$B7CB]     ;} If [OAM stack pointer] < 200h:
$90:B79A B9 58 D6    LDA $D658,y[$7E:D67A]  ;\
$90:B79D F0 2C       BEQ $2C    [$B7CB]     ;} If [projectile trail left instruction timer] != 0:
$90:B79F B9 30 D7    LDA $D730,y[$7E:D752]  ;\
$90:B7A2 38          SEC                    ;|
$90:B7A3 ED 11 09    SBC $0911  [$7E:0911]  ;} If [projectile trail left X position] >= [layer 1 X position]:
$90:B7A6 89 00 FF    BIT #$FF00             ;|
$90:B7A9 D0 20       BNE $20    [$B7CB]     ;/
$90:B7AB 9D 70 03    STA $0370,x[$7E:03B0]  ; OAM entry X position = [projectile trail left X position] - [layer 1 X position]
$90:B7AE B9 78 D7    LDA $D778,y[$7E:D79A]  ;\
$90:B7B1 38          SEC                    ;|
$90:B7B2 ED 15 09    SBC $0915  [$7E:0915]  ;} If [projectile trail left Y position] >= [layer 1 Y position]:
$90:B7B5 89 00 FF    BIT #$FF00             ;|
$90:B7B8 D0 11       BNE $11    [$B7CB]     ;/
$90:B7BA 9D 71 03    STA $0371,x[$7E:03B1]  ; OAM entry Y position = [projectile trail left Y position] - [layer 1 Y position]
$90:B7BD B9 E8 D6    LDA $D6E8,y[$7E:D70A]  ;\
$90:B7C0 9D 72 03    STA $0372,x[$7E:03B2]  ;} OAM entry tile number and attributes = [projectile trail left tile number and attributes]
$90:B7C3 8A          TXA                    ;\
$90:B7C4 18          CLC                    ;|
$90:B7C5 69 04 00    ADC #$0004             ;} OAM stack pointer += 4
$90:B7C8 8D 90 05    STA $0590  [$7E:0590]  ;/

$90:B7CB AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:B7CE E0 00 02    CPX #$0200             ;\
$90:B7D1 10 31       BPL $31    [$B804]     ;} If [OAM stack pointer] < 200h:
$90:B7D3 B9 7C D6    LDA $D67C,y[$7E:D69E]  ;\
$90:B7D6 F0 2C       BEQ $2C    [$B804]     ;} If [projectile trail right instruction timer] != 0:
$90:B7D8 B9 54 D7    LDA $D754,y[$7E:D776]  ;\
$90:B7DB 38          SEC                    ;|
$90:B7DC ED 11 09    SBC $0911  [$7E:0911]  ;} If [projectile trail right X position] >= [layer 1 X position]:
$90:B7DF 89 00 FF    BIT #$FF00             ;|
$90:B7E2 D0 20       BNE $20    [$B804]     ;/
$90:B7E4 9D 70 03    STA $0370,x[$7E:03B4]  ; OAM entry X position = [projectile trail right X position] - [layer 1 X position]
$90:B7E7 B9 9C D7    LDA $D79C,y[$7E:D7BE]  ;\
$90:B7EA 38          SEC                    ;|
$90:B7EB ED 15 09    SBC $0915  [$7E:0915]  ;} If [projectile trail right Y position] >= [layer 1 Y position]:
$90:B7EE 89 00 FF    BIT #$FF00             ;|
$90:B7F1 D0 11       BNE $11    [$B804]     ;/
$90:B7F3 9D 71 03    STA $0371,x[$7E:03B5]  ; OAM entry Y position = [projectile trail right Y position] - [layer 1 Y position]
$90:B7F6 B9 0C D7    LDA $D70C,y[$7E:D72E]  ;\
$90:B7F9 9D 72 03    STA $0372,x[$7E:03B6]  ;} OAM entry tile number and attributes = [projectile trail right tile number and attributes]
$90:B7FC 8A          TXA                    ;\
$90:B7FD 18          CLC                    ;|
$90:B7FE 69 04 00    ADC #$0004             ;} OAM stack pointer += 4
$90:B801 8D 90 05    STA $0590  [$7E:0590]  ;/

$90:B804 88          DEY                    ;\
$90:B805 88          DEY                    ;} Y -= 2
$90:B806 30 03       BMI $03    [$B80B]     ; If [Y] >= 0:
$90:B808 4C 92 B7    JMP $B792  [$90:B792]  ; Go to LOOP_TIME_IS_FROZEN

$90:B80B AB          PLB
$90:B80C 6B          RTL                    ; Return
}
}


;;; $B80D: HUD selection handler - nothing / power bombs ;;;
{
$90:B80D 08          PHP
$90:B80E C2 30       REP #$30
$90:B810 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:B813 8D C2 0D    STA $0DC2  [$7E:0DC2]  ;} Previous beam charge counter = [beam charge counter]
$90:B816 AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$90:B819 D0 08       BNE $08    [$B823]     ;} If hyper beam not equipped:
$90:B81B AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:B81E 89 00 10    BIT #$1000             ;} If charge beam equipped: go to BRANCH_CHARGE
$90:B821 D0 0A       BNE $0A    [$B82D]     ;/

$90:B823 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:B825 2D B2 09    AND $09B2  [$7E:09B2]  ;} If not pressing shoot: return
$90:B828 F0 5B       BEQ $5B    [$B885]     ;/
$90:B82A 4C 87 B8    JMP $B887  [$90:B887]  ; Go to fire uncharged beam

; BRANCH_CHARGE
$90:B82D AD 5E 0B    LDA $0B5E  [$7E:0B5E]  ;\
$90:B830 F0 0A       BEQ $0A    [$B83C]     ;} If [pose transition shot direction] != 0:
$90:B832 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:B835 C9 3C 00    CMP #$003C             ;} If [beam charge counter] >= 60: go to BRANCH_RELEASE_CHARGED_BEAM
$90:B838 10 33       BPL $33    [$B86D]     ;/
$90:B83A 80 28       BRA $28    [$B864]     ; Go to BRANCH_RELEASE_UNCHARGED_BEAM

$90:B83C A5 8B       LDA $8B    [$7E:008B]  ;\
$90:B83E 2D B2 09    AND $09B2  [$7E:09B2]  ;} If pressing shoot:
$90:B841 F0 17       BEQ $17    [$B85A]     ;/
$90:B843 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:B846 C9 78 00    CMP #$0078             ;} If [beam charge counter] >= 120: go to BRANCH_SBA
$90:B849 10 2B       BPL $2B    [$B876]     ;/
$90:B84B 1A          INC A                  ;\
$90:B84C 8D D0 0C    STA $0CD0  [$7E:0CD0]  ;} Increment beam charge counter
$90:B84F C9 01 00    CMP #$0001             ;\
$90:B852 D0 31       BNE $31    [$B885]     ;} If [beam charge counter] != 1: return
$90:B854 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:B857 4C 87 B8    JMP $B887  [$90:B887]  ; Go to fire uncharged beam

$90:B85A AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:B85D F0 26       BEQ $26    [$B885]     ;} If [beam charge counter] = 0: return
$90:B85F C9 3C 00    CMP #$003C             ;\
$90:B862 10 09       BPL $09    [$B86D]     ;} If [beam charge counter] >= 60: go to BRANCH_RELEASE_CHARGED_BEAM

; BRANCH_RELEASE_UNCHARGED_BEAM
$90:B864 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Beam charge counter = 0
$90:B867 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:B86A 4C 87 B8    JMP $B887  [$90:B887]  ; Go to fire uncharged beam

; BRANCH_RELEASE_CHARGED_BEAM
$90:B86D 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Beam charge counter = 0
$90:B870 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:B873 4C 86 B9    JMP $B986  [$90:B986]  ; Go to fire charged beam

; BRANCH_SBA
$90:B876 20 C0 CC    JSR $CCC0  [$90:CCC0]  ; Fire SBA
$90:B879 90 0A       BCC $0A    [$B885]     ; If succeeded:
$90:B87B 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Beam charge counter = 0
$90:B87E 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:B881 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette

$90:B885 28          PLP
$90:B886 60          RTS
}


;;; $B887: Fire uncharged beam ;;;
{
$90:B887 AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$90:B88A F0 03       BEQ $03    [$B88F]     ;} If hyper beam is enabled:
$90:B88C 4C D1 BC    JMP $BCD1  [$90:BCD1]  ; Go to fire hyper beam

$90:B88F 20 39 AC    JSR $AC39  [$90:AC39]  ;\
$90:B892 B0 16       BCS $16    [$B8AA]     ;} If Samus can fire beam: go to BRANCH_FIRE

; BRANCH_CANNOT_FIRE
$90:B894 AD C2 0D    LDA $0DC2  [$7E:0DC2]  ;\
$90:B897 C9 10 00    CMP #$0010             ;} If [previous beam charge counter] < 10h:
$90:B89A 10 02       BPL $02    [$B89E]     ;/
$90:B89C 28          PLP
$90:B89D 60          RTS                    ; Return

$90:B89E 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0
$90:B8A1 A9 02 00    LDA #$0002             ;\
$90:B8A4 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)
$90:B8A8 28          PLP
$90:B8A9 60          RTS                    ; Return

; BRANCH_FIRE
$90:B8AA A2 00 00    LDX #$0000             ; X = 0 (projectile index)

; LOOP
$90:B8AD BD 2C 0C    LDA $0C2C,x[$7E:0C2C]  ;\
$90:B8B0 F0 09       BEQ $09    [$B8BB]     ;} If [projectile damage] != 0:
$90:B8B2 E8          INX                    ;\
$90:B8B3 E8          INX                    ;} X += 2
$90:B8B4 E0 0A 00    CPX #$000A             ;\
$90:B8B7 30 F4       BMI $F4    [$B8AD]     ;} If [X] < Ah: go to LOOP
$90:B8B9 CA          DEX                    ;\
$90:B8BA CA          DEX                    ;} X -= 2 (overwrite last slot(!))

$90:B8BB 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:B8BD 20 56 BA    JSR $BA56  [$90:BA56]  ; Initialise projectile position / direction
$90:B8C0 B0 D2       BCS $D2    [$B894]     ; If cannot fire: go to BRANCH_CANNOT_FIRE
$90:B8C2 A9 0A 00    LDA #$000A             ;\
$90:B8C5 8D AC 18    STA $18AC  [$7E:18AC]  ;} Projectile invincibility timer = 10
$90:B8C8 A6 14       LDX $14    [$7E:0014]
$90:B8CA A9 04 00    LDA #$0004             ;\
$90:B8CD 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 4
$90:B8D0 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:B8D3 09 00 80    ORA #$8000             ;} Projectile type = [equipped beams] | 8000h
$90:B8D6 9D 18 0C    STA $0C18,x[$7E:0C18]  ;/
$90:B8D9 29 0F 00    AND #$000F             ;\
$90:B8DC 0A          ASL A                  ;|
$90:B8DD A8          TAY                    ;} Queue sound [$C2A7 + ([projectile type] & Fh) * 2], sound library 1, max queued sounds = 15
$90:B8DE B9 8F C2    LDA $C28F,y[$90:C28F]  ;|
$90:B8E1 22 21 90 80 JSL $809021[$80:9021]  ;/
$90:B8E5 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0
$90:B8E8 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:B8EC AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:B8EF 89 00 10    BIT #$1000             ;} If charge beam not equipped:
$90:B8F2 D0 28       BNE $28    [$B91C]     ;/
$90:B8F4 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:B8F6 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not newly pressing shoot:
$90:B8F9 D0 21       BNE $21    [$B91C]     ;/
$90:B8FB AD 00 0E    LDA $0E00  [$7E:0E00]  ;\
$90:B8FE 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not previously newly pressing shot:
$90:B901 D0 19       BNE $19    [$B91C]     ;/
$90:B903 BD 18 0C    LDA $0C18,x[$7E:0C1A]  ;\
$90:B906 48          PHA                    ;|
$90:B907 29 3F 00    AND #$003F             ;|
$90:B90A A8          TAY                    ;|
$90:B90B B9 83 C2    LDA $C283,y[$90:C283]  ;} Cooldown timer = [$C283 + ([projectile type] & 3Fh)] (auto-fire cooldown)
$90:B90E 29 FF 00    AND #$00FF             ;|
$90:B911 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;|
$90:B914 68          PLA                    ;/
$90:B915 89 01 00    BIT #$0001             ;\
$90:B918 D0 32       BNE $32    [$B94C]     ;} If wave beam: go to BRANCH_WAVE_BEAM
$90:B91A 80 17       BRA $17    [$B933]

$90:B91C BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\ Else (charge beam equipped or (previously) newly pressing shoot):
$90:B91F 48          PHA                    ;|
$90:B920 29 3F 00    AND #$003F             ;|
$90:B923 A8          TAY                    ;|
$90:B924 B9 54 C2    LDA $C254,y[$90:C254]  ;} Cooldown timer = [$C254 + ([projectile type] & 3Fh)]
$90:B927 29 FF 00    AND #$00FF             ;|
$90:B92A 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;|
$90:B92D 68          PLA                    ;/
$90:B92E 89 01 00    BIT #$0001             ;\
$90:B931 D0 19       BNE $19    [$B94C]     ;} If wave beam: go to BRANCH_WAVE_BEAM

$90:B933 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X speed = 0
$90:B936 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y speed = 0
$90:B939 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:B93C 20 64 BD    JSR $BD64  [$90:BD64]  ; Initial beam block collision - no wave beam
$90:B93F AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:B942 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B945 89 00 0F    BIT #$0F00             ;} If not beam: return
$90:B948 D0 22       BNE $22    [$B96C]     ;/
$90:B94A 80 0C       BRA $0C    [$B958]     ; Go to BRANCH_MERGE

; BRANCH_WAVE_BEAM
$90:B94C 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X speed = 0
$90:B94F 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y speed = 0
$90:B952 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:B955 20 B2 BD    JSR $BDB2  [$90:BDB2]  ; Initial wave beam block collision

; BRANCH_MERGE
$90:B958 86 14       STX $14    [$7E:0014]  ; $14 = [X] (projectile index)
$90:B95A BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B95D 29 0F 00    AND #$000F             ;|
$90:B960 0A          ASL A                  ;|
$90:B961 A8          TAY                    ;} Projectile pre-instruction = [$B96E + (beam type) * 2]
$90:B962 B9 6E B9    LDA $B96E,y[$90:B96E]  ;|
$90:B965 9D 68 0C    STA $0C68,x[$7E:0C68]  ;/
$90:B968 22 97 B1 90 JSL $90B197[$90:B197]  ; Initialise beam velocities

$90:B96C 28          PLP
$90:B96D 60          RTS

; Projectile pre-instruction pointers
$90:B96E             dw AEF3, ; 0: Power
                        B0E4, ; 1: Wave
                        AEF3, ; 2: Ice
                        B0E4, ; 3: Ice + wave
                        AEF3, ; 4: Spazer
                        B0C3, ; 5: Spazer + wave
                        AEF3, ; 6: Spazer + ice
                        B0C3, ; 7: Spazer + ice + wave
                        AEF3, ; 8: Plasma
                        B0C3, ; 9: Plasma + wave
                        AEF3, ; Ah: Plasma + ice
                        B0C3  ; Bh: Plasma + ice + wave
}


;;; $B986: Fire charged beam ;;;
{
$90:B986 20 39 AC    JSR $AC39  [$90:AC39]  ;\
$90:B989 B0 16       BCS $16    [$B9A1]     ;} If Samus can fire beam: go to BRANCH_FIRE

; BRANCH_CANNOT_FIRE
$90:B98B AD C2 0D    LDA $0DC2  [$7E:0DC2]  ;\
$90:B98E C9 10 00    CMP #$0010             ;} If [previous beam charge counter] < 10h:
$90:B991 10 02       BPL $02    [$B995]     ;/
$90:B993 28          PLP
$90:B994 60          RTS                    ; Return

$90:B995 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0
$90:B998 A9 02 00    LDA #$0002             ;\
$90:B99B 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)
$90:B99F 28          PLP
$90:B9A0 60          RTS                    ; Return

; BRANCH_FIRE
$90:B9A1 A2 00 00    LDX #$0000             ; X = 0 (projectile index)

; LOOP
$90:B9A4 BD 2C 0C    LDA $0C2C,x[$7E:0C2C]  ;\
$90:B9A7 F0 09       BEQ $09    [$B9B2]     ;} If [projectile damage] != 0:
$90:B9A9 E8          INX                    ;\
$90:B9AA E8          INX                    ;} X += 2
$90:B9AB E0 0A 00    CPX #$000A             ;\
$90:B9AE 30 F4       BMI $F4    [$B9A4]     ;} If [X] < Ah: go to LOOP
$90:B9B0 CA          DEX                    ;\
$90:B9B1 CA          DEX                    ;} X -= 2

$90:B9B2 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:B9B4 20 56 BA    JSR $BA56  [$90:BA56]  ; Initialise projectile position / direction
$90:B9B7 B0 D2       BCS $D2    [$B98B]     ; If cannot fire (pose check): go to BRANCH_CANNOT_FIRE
$90:B9B9 A9 0A 00    LDA #$000A             ;\
$90:B9BC 8D AC 18    STA $18AC  [$7E:18AC]  ;} Projectile invincibility timer = 10
$90:B9BF A6 14       LDX $14    [$7E:0014]
$90:B9C1 A9 04 00    LDA #$0004             ;\
$90:B9C4 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 4
$90:B9C7 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:B9CA 29 0F 10    AND #$100F             ;|
$90:B9CD 09 10 80    ORA #$8010             ;} Projectile type = [equipped beams] | 8010h
$90:B9D0 9D 18 0C    STA $0C18,x[$7E:0C18]  ;/
$90:B9D3 29 0F 00    AND #$000F             ;\
$90:B9D6 0A          ASL A                  ;|
$90:B9D7 A8          TAY                    ;} Queue sound [$C2A7 + ([projectile type] & Fh) * 2], sound library 1, max queued sounds = 15
$90:B9D8 B9 A7 C2    LDA $C2A7,y[$90:C2AF]  ;|
$90:B9DB 22 21 90 80 JSL $809021[$80:9021]  ;/
$90:B9DF 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0
$90:B9E2 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:B9E6 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:B9E9 48          PHA                    ;|
$90:B9EA 29 3F 00    AND #$003F             ;|
$90:B9ED A8          TAY                    ;|
$90:B9EE B9 54 C2    LDA $C254,y[$90:C268]  ;} Cooldown timer = [$C254 + ([projectile type] & 3Fh)]
$90:B9F1 29 FF 00    AND #$00FF             ;|
$90:B9F4 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;|
$90:B9F7 68          PLA                    ;/
$90:B9F8 89 01 00    BIT #$0001             ;\
$90:B9FB D0 19       BNE $19    [$BA16]     ;} If not wave beam:
$90:B9FD 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X speed = 0
$90:BA00 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y speed = 0
$90:BA03 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:BA06 20 64 BD    JSR $BD64  [$90:BD64]  ; Initial beam block collision - no wave beam
$90:BA09 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BA0C BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:BA0F 89 00 0F    BIT #$0F00             ;} If not beam: go to BRANCH_RETURN
$90:BA12 D0 22       BNE $22    [$BA36]     ;/
$90:BA14 80 0C       BRA $0C    [$BA22]
                                            ; Else (wave beam):
$90:BA16 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X speed = 0
$90:BA19 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y speed = 0
$90:BA1C 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:BA1F 20 B2 BD    JSR $BDB2  [$90:BDB2]  ; Initial wave beam block collision

$90:BA22 86 14       STX $14    [$7E:0014]  ; $14 = [X] (projectile index)
$90:BA24 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:BA27 29 0F 00    AND #$000F             ;|
$90:BA2A 0A          ASL A                  ;|
$90:BA2B A8          TAY                    ;} Projectile pre-instruction = [$BA3E + (beam type) * 2]
$90:BA2C B9 3E BA    LDA $BA3E,y[$90:BA46]  ;|
$90:BA2F 9D 68 0C    STA $0C68,x[$7E:0C68]  ;/
$90:BA32 22 97 B1 90 JSL $90B197[$90:B197]  ; Initialise beam velocities

; BRANCH_RETURN
$90:BA36 A9 04 00    LDA #$0004             ;\
$90:BA39 8D 18 0B    STA $0B18  [$7E:0B18]  ;} Charged shot glow timer = 4
$90:BA3C 28          PLP
$90:BA3D 60          RTS

; Projectile pre-instruction pointers
$90:BA3E             dw AEF3, ; 0: Power
                        B0C3, ; 1: Wave
                        AEF3, ; 2: Ice
                        B0C3, ; 3: Ice + wave
                        AEF3, ; 4: Spazer
                        B0C3, ; 5: Spazer + wave
                        AEF3, ; 6: Spazer + ice
                        B0C3, ; 7: Spazer + ice + wave
                        AEF3, ; 8: Plasma
                        B0C3, ; 9: Plasma + wave
                        AEF3, ; Ah: Plasma + ice
                        B0C3  ; Bh: Plasma + ice + wave
}


;;; $BA56: Initialise projectile position / direction ;;;
{
;; Parameters:
;;     $14: Projectile index
;; Returns:
;;     Carry: Clear is can fire, set otherwise

; As far as I can tell, BRANCH_RETURN_NO_FIRE can only possibly be taken when trying to shoot whilst in pose BEh/F0h (grabbed by Draygon - moving)

$90:BA56 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:BA59 0A          ASL A                  ;|
$90:BA5A 0A          ASL A                  ;} X = [Samus pose] * 8
$90:BA5B 0A          ASL A                  ;|
$90:BA5C AA          TAX                    ;/
$90:BA5D A4 14       LDY $14    [$7E:0014]  ; Y = [$14] (projectile index)
$90:BA5F AD 5E 0B    LDA $0B5E  [$7E:0B5E]  ; A = [pose transition shot direction]
$90:BA62 F0 08       BEQ $08    [$BA6C]     ; If [pose transition shot direction] != 0:
$90:BA64 29 FF 00    AND #$00FF
$90:BA67 9C 5E 0B    STZ $0B5E  [$7E:0B5E]  ; Pose transition shot direction = 0
$90:BA6A 80 14       BRA $14    [$BA80]

$90:BA6C BF 2C B6 91 LDA $91B62C,x[$91:B63C];\ Else ([pose transition shot direction] = 0):
$90:BA70 29 FF 00    AND #$00FF             ;} A = [$91:B62C + [Samus pose] * 8] (direction shots are fired)
$90:BA73 89 F0 00    BIT #$00F0             ;\
$90:BA76 F0 08       BEQ $08    [$BA80]     ;} If [A] & F0h != 0:
$90:BA78 C9 10 00    CMP #$0010             ;\
$90:BA7B F0 61       BEQ $61    [$BADE]     ;} If [A] = 10h: go to BRANCH_UNUSED
$90:BA7D 4C F7 BA    JMP $BAF7  [$90:BAF7]  ; Go to BRANCH_RETURN_NO_FIRE

$90:BA80 99 04 0C    STA $0C04,y[$7E:0C04]  ; Projectile direction = [A]
$90:BA83 BF 2D B6 91 LDA $91B62D,x[$91:B63D];\
$90:BA87 29 FF 00    AND #$00FF             ;} $16 = [$91:B62D + [Samus pose] * 8] (Y offset of projectile origin)
$90:BA8A 85 16       STA $16    [$7E:0016]  ;/
$90:BA8C B9 04 0C    LDA $0C04,y[$7E:0C04]  ;\
$90:BA8F 29 0F 00    AND #$000F             ;|
$90:BA92 0A          ASL A                  ;} X = [projectile direction] * 2
$90:BA93 AA          TAX                    ;/
$90:BA94 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:BA97 C9 75 00    CMP #$0075             ;} If [Samus pose] != facing left - moonwalk - aiming up-left:
$90:BA9A F0 29       BEQ $29    [$BAC5]     ;/
$90:BA9C C9 76 00    CMP #$0076             ;\
$90:BA9F F0 24       BEQ $24    [$BAC5]     ;} If [Samus pose] != facing right - moonwalk - aiming up-right:
$90:BAA1 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:BAA4 29 FF 00    AND #$00FF             ;|
$90:BAA7 C9 01 00    CMP #$0001             ;} If [Samus movement type] != running:
$90:BAAA F0 19       BEQ $19    [$BAC5]     ;/
$90:BAAC BD 04 C2    LDA $C204,x[$90:C212]  ;\
$90:BAAF 18          CLC                    ;|
$90:BAB0 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Projectile X position = [Samus X position] + [$C204 + [projectile direction] * 2]
$90:BAB3 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:BAB6 BD 18 C2    LDA $C218,x[$90:C226]  ;\
$90:BAB9 18          CLC                    ;|
$90:BABA 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$90:BABD 38          SEC                    ;} Projectile Y position = [Samus Y position] + [$C218 + [projectile direction] * 2] - [$16]
$90:BABE E5 16       SBC $16    [$7E:0016]  ;|
$90:BAC0 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:BAC3 18          CLC                    ;\
$90:BAC4 60          RTS                    ;} Return carry clear

$90:BAC5 BD 2C C2    LDA $C22C,x[$90:C23C]  ;\
$90:BAC8 18          CLC                    ;|
$90:BAC9 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} Projectile X position = [Samus X position] + [$C22C + [projectile direction] * 2]
$90:BACC 99 64 0B    STA $0B64,y[$7E:0B64]  ;/
$90:BACF BD 40 C2    LDA $C240,x[$90:C250]  ;\
$90:BAD2 18          CLC                    ;|
$90:BAD3 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$90:BAD6 38          SEC                    ;} Projectile Y position = [Samus Y position] + [$C240 + [projectile direction] * 2] - [$16]
$90:BAD7 E5 16       SBC $16    [$7E:0016]  ;|
$90:BAD9 99 78 0B    STA $0B78,y[$7E:0B78]  ;/
$90:BADC 18          CLC                    ;\
$90:BADD 60          RTS                    ;} Return carry clear

; BRANCH_UNUSED
$90:BADE DA          PHX
$90:BADF AD 24 0A    LDA $0A24  [$7E:0A24]
$90:BAE2 0A          ASL A
$90:BAE3 0A          ASL A
$90:BAE4 0A          ASL A
$90:BAE5 AA          TAX
$90:BAE6 BF 2C B6 91 LDA $91B62C,x
$90:BAEA 89 F0 00    BIT #$00F0
$90:BAED D0 07       BNE $07    [$BAF6]
$90:BAEF 29 FF 00    AND #$00FF
$90:BAF2 FA          PLX
$90:BAF3 4C 80 BA    JMP $BA80  [$90:BA80]

$90:BAF6 FA          PLX

; BRANCH_RETURN_NO_FIRE
$90:BAF7 CE CE 0C    DEC $0CCE  [$7E:0CCE]  ; Decrement projectile counter
$90:BAFA 38          SEC                    ;\
$90:BAFB 60          RTS                    ;} Return carry set
}


;;; $BAFC: Handle charging beam graphics / audio ;;;
{
$90:BAFC 08          PHP
$90:BAFD C2 30       REP #$30
$90:BAFF AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$90:BB02 D0 09       BNE $09    [$BB0D]     ;} If hyper beam enabled: go to BRANCH_HYPER_BEAM
$90:BB04 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:BB07 F0 02       BEQ $02    [$BB0B]     ;} If [beam charge counter] > 0: go to BRANCH_CHARGE_BEAM
$90:BB09 10 05       BPL $05    [$BB10]     ;/

$90:BB0B 28          PLP
$90:BB0C 60          RTS                    ; Return

$90:BB0D 4C B2 BB    JMP $BBB2  [$90:BBB2]

; BRANCH_CHARGE_BEAM
$90:BB10 C9 01 00    CMP #$0001             ;\
$90:BB13 D0 1B       BNE $1B    [$BB30]     ;} If [beam charge counter] = 1:
$90:BB15 9C D6 0C    STZ $0CD6  [$7E:0CD6]  ;\
$90:BB18 9C D8 0C    STZ $0CD8  [$7E:0CD8]  ;} Charge beam sparks animation frames = 0
$90:BB1B 9C DA 0C    STZ $0CDA  [$7E:0CDA]  ;/
$90:BB1E A9 03 00    LDA #$0003             ;\
$90:BB21 8D DC 0C    STA $0CDC  [$7E:0CDC]  ;} Charge beam animation timer = 3
$90:BB24 A9 05 00    LDA #$0005             ;\
$90:BB27 8D DE 0C    STA $0CDE  [$7E:0CDE]  ;} Charge beam slow sparks animation timer = 5
$90:BB2A A9 04 00    LDA #$0004             ;\
$90:BB2D 8D E0 0C    STA $0CE0  [$7E:0CE0]  ;} Charge beam fast sparks animation timer = 4

$90:BB30 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:BB33 C9 0F 00    CMP #$000F             ;} If [beam charge counter] < Fh:
$90:BB36 10 03       BPL $03    [$BB3B]     ;/
$90:BB38 4C B0 BB    JMP $BBB0  [$90:BBB0]  ; Return

$90:BB3B C9 10 00    CMP #$0010             ;\
$90:BB3E D0 07       BNE $07    [$BB47]     ;} If [beam charge counter] = 10h:
$90:BB40 A9 08 00    LDA #$0008             ;\
$90:BB43 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 8, sound library 1, max queued sounds allowed = 9 (charging beam)

$90:BB47 A2 00 00    LDX #$0000             ; X = 0 (charge beam animation component index)

; LOOP_CHARGE_BEAM
$90:BB4A E2 20       SEP #$20
$90:BB4C A9 90       LDA #$90               ;\
$90:BB4E 85 02       STA $02    [$7E:0002]  ;} $02 = $90
$90:BB50 C2 20       REP #$20
$90:BB52 BD DC 0C    LDA $0CDC,x[$7E:0CDC]  ;\
$90:BB55 3A          DEC A                  ;} Decrement charge beam animation component timer
$90:BB56 9D DC 0C    STA $0CDC,x[$7E:0CDC]  ;/
$90:BB59 10 41       BPL $41    [$BB9C]     ; If [charge beam animation component timer] >= 0: go to BRANCH_CHARGE_BEAM_ANIMATION_UPDATE_END
$90:BB5B BD D6 0C    LDA $0CD6,x[$7E:0CD6]  ;\
$90:BB5E 1A          INC A                  ;} Increment charge beam animation component frame
$90:BB5F 9D D6 0C    STA $0CD6,x[$7E:0CD6]  ;/
$90:BB62 A8          TAY                    ; Y = [charge beam animation component frame]
$90:BB63 BD 81 C4    LDA $C481,x[$90:C481]  ;\
$90:BB66 85 00       STA $00    [$7E:0000]  ;} $00 = [$C481 + [X]]
$90:BB68 B7 00       LDA [$00],y[$90:C488]  ;\
$90:BB6A 29 FF 00    AND #$00FF             ;|
$90:BB6D C9 FF 00    CMP #$00FF             ;} If [[$00] + [Y]] = FFh: go to BRANCH_RESTART
$90:BB70 F0 07       BEQ $07    [$BB79]     ;/
$90:BB72 C9 FE 00    CMP #$00FE             ;\
$90:BB75 F0 0B       BEQ $0B    [$BB82]     ;} If [[$00] + [Y]] = FEh: go to BRANCH_GO_BACK
$90:BB77 80 1B       BRA $1B    [$BB94]     ; Go to BRANCH_MERGE

; BRANCH_RESTART
$90:BB79 A9 00 00    LDA #$0000             ;\
$90:BB7C 9D D6 0C    STA $0CD6,x[$7E:0CDA]  ;} Charge beam animation component frame = 0
$90:BB7F A8          TAY                    ; Y = [charge beam animation component frame]
$90:BB80 80 12       BRA $12    [$BB94]     ; Go to BRANCH_MERGE

; BRANCH_GO_BACK
$90:BB82 C8          INY                    ;\
$90:BB83 B7 00       LDA [$00],y[$90:C4A6]  ;|
$90:BB85 29 FF 00    AND #$00FF             ;|
$90:BB88 85 12       STA $12    [$7E:0012]  ;|
$90:BB8A BD D6 0C    LDA $0CD6,x[$7E:0CD6]  ;} Charge beam animation component frame -= [[$00] + [Y] + 1]
$90:BB8D 38          SEC                    ;|
$90:BB8E E5 12       SBC $12    [$7E:0012]  ;|
$90:BB90 9D D6 0C    STA $0CD6,x[$7E:0CD6]  ;/
$90:BB93 A8          TAY                    ; Y = [charge beam animation component frame]

; BRANCH_MERGE
$90:BB94 B7 00       LDA [$00],y[$90:C488]  ;\
$90:BB96 29 FF 00    AND #$00FF             ;} Charge beam animation component timer = [[$00] + [Y]]
$90:BB99 9D DC 0C    STA $0CDC,x[$7E:0CDC]  ;/

; BRANCH_CHARGE_BEAM_ANIMATION_UPDATE_END
$90:BB9C DA          PHX                    ;\
$90:BB9D 20 E1 BB    JSR $BBE1  [$90:BBE1]  ;} Draw flare animation component
$90:BBA0 FA          PLX                    ;/
$90:BBA1 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:BBA4 C9 1E 00    CMP #$001E             ;} If [beam charge counter] < 30: return
$90:BBA7 30 07       BMI $07    [$BBB0]     ;/
$90:BBA9 E8          INX                    ;\
$90:BBAA E8          INX                    ;} X += 2 (next charge beam animation component)
$90:BBAB E0 06 00    CPX #$0006             ;\
$90:BBAE 30 9A       BMI $9A    [$BB4A]     ;} If [X] < 6: go to LOOP_CHARGE_BEAM

$90:BBB0 28          PLP
$90:BBB1 60          RTS                    ; Return

; BRANCH_HYPER_BEAM
$90:BBB2 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:BBB5 F0 28       BEQ $28    [$BBDF]     ;} If [flare counter] = 0: return
$90:BBB7 A2 04 00    LDX #$0004             ; X = 4 (flare animation component index)

; LOOP_HYPER_BEAM
$90:BBBA DE DC 0C    DEC $0CDC,x[$7E:0CE0]  ; Decrement flare animation component timer
$90:BBBD F0 02       BEQ $02    [$BBC1]     ;\
$90:BBBF 10 15       BPL $15    [$BBD6]     ;} If [flare animation component timer] > 0: go to BRANCH_HYPER_BEAM_ANIMATION_UPDATE_END

$90:BBC1 DE D6 0C    DEC $0CD6,x[$7E:0CDA]  ; Decrement flare animation component frame
$90:BBC4 D0 0A       BNE $0A    [$BBD0]     ; If [flare animation component frame] = 0:
$90:BBC6 E0 04 00    CPX #$0004             ;\
$90:BBC9 D0 0B       BNE $0B    [$BBD6]     ;} If [X] != 4: go to BRANCH_HYPER_BEAM_ANIMATION_UPDATE_END
$90:BBCB 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:BBCE 80 06       BRA $06    [$BBD6]

$90:BBD0 A9 03 00    LDA #$0003             ;\ Else ([flare animation component frame] != 0):
$90:BBD3 9D DC 0C    STA $0CDC,x[$7E:0CE0]  ;} Flare animation component timer = 3

; BRANCH_HYPER_BEAM_ANIMATION_UPDATE_END
$90:BBD6 DA          PHX                    ;\
$90:BBD7 20 E1 BB    JSR $BBE1  [$90:BBE1]  ;} Draw flare animation component
$90:BBDA FA          PLX                    ;/
$90:BBDB CA          DEX                    ;\
$90:BBDC CA          DEX                    ;} X -= 2 (next flare animation component)
$90:BBDD 10 DB       BPL $DB    [$BBBA]     ; If [X] >= 0: go to LOOP_HYPER_BEAM

$90:BBDF 28          PLP
$90:BBE0 60          RTS
}


;;; $BBE1: Draw flare animation component ;;;
{
;; Parameters:
;;     X: Flare animation index (0/2/4)

; Is this making sure charging works in the rotating elevator room?!
$90:BBE1 08          PHP
$90:BBE2 E2 20       SEP #$20               ;\
$90:BBE4 A9 93       LDA #$93               ;|
$90:BBE6 85 02       STA $02    [$7E:0002]  ;} $02 = $93
$90:BBE8 C2 30       REP #$30               ;/
$90:BBEA BD D6 0C    LDA $0CD6,x[$7E:0CD6]  ;\
$90:BBED 29 FF 00    AND #$00FF             ;} $12 = [flare animation frame]
$90:BBF0 85 12       STA $12    [$7E:0012]  ;/
$90:BBF2 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:BBF5 29 FF 00    AND #$00FF             ;|
$90:BBF8 C9 04 00    CMP #$0004             ;} If facing right:
$90:BBFB F0 0B       BEQ $0B    [$BC08]     ;/
$90:BBFD BF 25 A2 93 LDA $93A225,x[$93:A225];\
$90:BC01 18          CLC                    ;|
$90:BC02 65 12       ADC $12    [$7E:0012]  ;} $16 = [$93:A225 + [X]] + [flare animation frame] (flare spritemap index)
$90:BC04 85 16       STA $16    [$7E:0016]  ;/
$90:BC06 80 09       BRA $09    [$BC11]

$90:BC08 BF 2B A2 93 LDA $93A22B,x[$93:A22B];\ Else (facing left):
$90:BC0C 18          CLC                    ;|
$90:BC0D 65 12       ADC $12    [$7E:0012]  ;} $16 = [$93:A22B + [X]] + [flare animation frame] (flare spritemap index)
$90:BC0F 85 16       STA $16    [$7E:0016]  ;/

$90:BC11 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:BC14 0A          ASL A                  ;|
$90:BC15 0A          ASL A                  ;} X = [Samus pose] * 8
$90:BC16 0A          ASL A                  ;|
$90:BC17 AA          TAX                    ;/
$90:BC18 BF 2D B6 91 LDA $91B62D,x[$91:B6CD];\
$90:BC1C 29 FF 00    AND #$00FF             ;} $18 = [$91:B62D + [X]] (Y offset of projectile origin)
$90:BC1F 85 18       STA $18    [$7E:0018]  ;/
$90:BC21 BF 2C B6 91 LDA $91B62C,x[$91:B6CC];\
$90:BC25 29 FF 00    AND #$00FF             ;} A = [$91:B62C + [X]] (direction shots are fired)
$90:BC28 C9 FF 00    CMP #$00FF             ;\
$90:BC2B F0 0A       BEQ $0A    [$BC37]     ;} If [A] = FFh: return
$90:BC2D C9 10 00    CMP #$0010             ;\
$90:BC30 F0 05       BEQ $05    [$BC37]     ;} If [A] = 10h (never true): return
$90:BC32 C9 10 00    CMP #$0010             ;\
$90:BC35 D0 02       BNE $02    [$BC39]     ;} Go to BRANCH_CONTINUE

$90:BC37 28          PLP
$90:BC38 60          RTS                    ; Return

; BRANCH_CONTINUE
$90:BC39 29 0F 00    AND #$000F             ;\
$90:BC3C 0A          ASL A                  ;} X = ([A] & Fh) * 2
$90:BC3D AA          TAX                    ;/
$90:BC3E AD 3F 09    LDA $093F  [$7E:093F]  ;\
$90:BC41 10 10       BPL $10    [$BC53]     ;} If Ceres elevator room is rotating:
$90:BC43 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:BC46 8D 82 0D    STA $0D82  [$7E:0D82]  ;} $0D82 = [Samus X position]
$90:BC49 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:BC4C 8D 84 0D    STA $0D84  [$7E:0D84]  ;} $0D84 = [Samus Y position]
$90:BC4F 22 52 8A 8B JSL $8B8A52[$8B:8A52]  ; Calculate position of Samus in rotating elevator room

$90:BC53 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:BC56 29 FF 00    AND #$00FF             ;|
$90:BC59 C9 01 00    CMP #$0001             ;} If [Samus movement type] != running:
$90:BC5C F0 1E       BEQ $1E    [$BC7C]     ;/
$90:BC5E BD A8 C1    LDA $C1A8,x[$90:C1B6]  ;\
$90:BC61 18          CLC                    ;|
$90:BC62 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;|
$90:BC65 38          SEC                    ;} $14 = [Samus X position] + [$C1A8 + [X]] - [layer 1 X position]
$90:BC66 ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:BC69 85 14       STA $14    [$7E:0014]  ;/
$90:BC6B BD C2 C1    LDA $C1C2,x[$90:C1D0]  ;\
$90:BC6E 18          CLC                    ;|
$90:BC6F 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$90:BC72 38          SEC                    ;} $12 = [Samus Y position] + [$C1C2 + [X]] - [$18] - [layer 1 Y position]
$90:BC73 E5 18       SBC $18    [$7E:0018]  ;|
$90:BC75 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:BC78 85 12       STA $12    [$7E:0012]  ;/
$90:BC7A 80 1C       BRA $1C    [$BC98]

$90:BC7C BD DC C1    LDA $C1DC,x[$90:C1E0]  ;\ Else ([Samus movement type] = running):
$90:BC7F 18          CLC                    ;|
$90:BC80 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;|
$90:BC83 38          SEC                    ;} $14 = [Samus X position] + [$C1DC + [X]] - [layer 1 X position]
$90:BC84 ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:BC87 85 14       STA $14    [$7E:0014]  ;/
$90:BC89 BD F0 C1    LDA $C1F0,x[$90:C1F4]  ;\
$90:BC8C 18          CLC                    ;|
$90:BC8D 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$90:BC90 38          SEC                    ;} $12 = [Samus Y position] + [$C1F0 + [X]] - [$18] - [layer 1 Y position]
$90:BC91 E5 18       SBC $18    [$7E:0018]  ;|
$90:BC93 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:BC96 85 12       STA $12    [$7E:0012]  ;/

$90:BC98 29 00 FF    AND #$FF00             ;\
$90:BC9B D0 08       BNE $08    [$BCA5]     ;} If [$12] < 100h:
$90:BC9D A5 16       LDA $16    [$7E:0016]  ; A = [$16]
$90:BC9F 22 37 8A 81 JSL $818A37[$81:8A37]  ; Add spritemap from $93:A1A1 table to OAM
$90:BCA3 80 06       BRA $06    [$BCAB]

$90:BCA5 A5 16       LDA $16    [$7E:0016]  ;\ Else ([$12] >= 100h):
$90:BCA7 22 B7 8A 81 JSL $818AB7[$81:8AB7]  ;} NOP

$90:BCAB AD 3F 09    LDA $093F  [$7E:093F]  ;\
$90:BCAE 10 0C       BPL $0C    [$BCBC]     ;} If Ceres elevator room is rotating:
$90:BCB0 AD 84 0D    LDA $0D84  [$7E:0D84]  ;\
$90:BCB3 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position = [$0D84]
$90:BCB6 AD 82 0D    LDA $0D82  [$7E:0D82]  ;\
$90:BCB9 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = [$0D82]

$90:BCBC 28          PLP
$90:BCBD 60          RTS
}


;;; $BCBE: Clear flare animation state ;;;
{
$90:BCBE 9C D6 0C    STZ $0CD6  [$7E:0CD6]  ; Flare animation frame = 0
$90:BCC1 9C D8 0C    STZ $0CD8  [$7E:0CD8]  ; Flare slow sparks animation frame = 0
$90:BCC4 9C DA 0C    STZ $0CDA  [$7E:0CDA]  ; Flare fast sparks animation frame = 0
$90:BCC7 9C DC 0C    STZ $0CDC  [$7E:0CDC]  ; Flare animation timer = 0
$90:BCCA 9C DE 0C    STZ $0CDE  [$7E:0CDE]  ; Flare slow sparks animation timer = 0
$90:BCCD 9C E0 0C    STZ $0CE0  [$7E:0CE0]  ; Flare fast sparks animation timer = 0
$90:BCD0 60          RTS
}


;;; $BCD1: Fire hyper beam ;;;
{
$90:BCD1 20 39 AC    JSR $AC39  [$90:AC39]  ;\
$90:BCD4 B0 02       BCS $02    [$BCD8]     ;} If Samus cannot fire beam:
$90:BCD6 28          PLP
$90:BCD7 60          RTS                    ; Return

$90:BCD8 A2 00 00    LDX #$0000             ; X = 0 (projectile index)

; LOOP
$90:BCDB BD 2C 0C    LDA $0C2C,x[$7E:0C2C]  ;\
$90:BCDE F0 09       BEQ $09    [$BCE9]     ;} If [projectile damage] != 0:
$90:BCE0 E8          INX                    ;\
$90:BCE1 E8          INX                    ;} X += 2
$90:BCE2 E0 0A 00    CPX #$000A             ;\
$90:BCE5 30 F4       BMI $F4    [$BCDB]     ;} If [X] < Ah: go to LOOP
$90:BCE7 CA          DEX                    ;\
$90:BCE8 CA          DEX                    ;} X -= 2 (overwrite last slot(!))

$90:BCE9 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:BCEB 20 56 BA    JSR $BA56  [$90:BA56]  ; Initialise projectile position / direction
$90:BCEE B0 72       BCS $72    [$BD62]     ; If cannot fire: return
$90:BCF0 A9 0A 00    LDA #$000A             ;\
$90:BCF3 8D AC 18    STA $18AC  [$7E:18AC]  ;} Projectile invincibility timer = 10
$90:BCF6 A6 14       LDX $14    [$7E:0014]
$90:BCF8 DA          PHX
$90:BCF9 A9 18 90    LDA #$9018             ;\
$90:BCFC 9D 18 0C    STA $0C18,x[$7E:0C18]  ;} Projectile type = live charged plasma beam | 1000h
$90:BCFF 29 0F 00    AND #$000F             ;\
$90:BD02 0A          ASL A                  ;|
$90:BD03 AA          TAX                    ;} Queue sound 1Fh, sound library 1, max queued sounds = 15 (charged plasma beam / hyper beam)
$90:BD04 BD A7 C2    LDA $C2A7,x[$90:C2B7]  ;|
$90:BD07 22 21 90 80 JSL $809021[$80:9021]  ;/
$90:BD0B 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0
$90:BD0E FA          PLX
$90:BD0F 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:BD13 9E DC 0B    STZ $0BDC,x[$7E:0BDC]  ; Projectile X speed = 0
$90:BD16 9E F0 0B    STZ $0BF0,x[$7E:0BF0]  ; Projectile Y speed = 0
$90:BD19 8E DE 0D    STX $0DDE  [$7E:0DDE]  ; Projectile index = [X]
$90:BD1C 20 B2 BD    JSR $BDB2  [$90:BDB2]  ; Initial wave beam block collision
$90:BD1F AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BD22 AF BF 83 93 LDA $9383BF[$93:83BF]  ;\
$90:BD26 9D 2C 0C    STA $0C2C,x[$7E:0C2C]  ;} Projectile damage = 1000
$90:BD29 A9 59 B1    LDA #$B159             ;\
$90:BD2C 9D 68 0C    STA $0C68,x[$7E:0C68]  ;} Projectile pre-instruction = $B159
$90:BD2F 86 14       STX $14    [$7E:0014]
$90:BD31 22 97 B1 90 JSL $90B197[$90:B197]  ; Initialise beam velocities
$90:BD35 A9 15 00    LDA #$0015             ;\
$90:BD38 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 15h
$90:BD3B A9 14 80    LDA #$8014             ;\
$90:BD3E 8D 18 0B    STA $0B18  [$7E:0B18]  ;} Charged shot glow timer = 20
$90:BD41 A9 1D 00    LDA #$001D             ;\
$90:BD44 8D D6 0C    STA $0CD6  [$7E:0CD6]  ;} Flare animation frame = 1Dh
$90:BD47 A9 05 00    LDA #$0005             ;\
$90:BD4A 8D D8 0C    STA $0CD8  [$7E:0CD8]  ;} Flare slow sparks animation frame = 5
$90:BD4D 8D DA 0C    STA $0CDA  [$7E:0CDA]  ; Flare fast sparks animation frame = 5
$90:BD50 A9 03 00    LDA #$0003             ;\
$90:BD53 8D DC 0C    STA $0CDC  [$7E:0CDC]  ;} Flare animation timer = 3
$90:BD56 8D DE 0C    STA $0CDE  [$7E:0CDE]  ; Flare slow sparks animation timer = 3
$90:BD59 8D E0 0C    STA $0CE0  [$7E:0CE0]  ; Flare fast sparks animation timer = 3
$90:BD5C A9 00 80    LDA #$8000             ;\
$90:BD5F 8D D0 0C    STA $0CD0  [$7E:0CD0]  ;} Flare counter = 8000h

$90:BD62 28          PLP
$90:BD63 60          RTS
}


;;; $BD64..BDFF: Initial beam block collision ;;;
{
;;; $BD64: Initial beam block collision - no wave beam ;;;
{
;; Parameters:
;;     X: Projectile index
$90:BD64 DA          PHX
$90:BD65 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:BD68 29 0F 00    AND #$000F             ;|
$90:BD6B 0A          ASL A                  ;} Execute [$BD72 + ([projectile direction] & Fh) * 2]
$90:BD6C AA          TAX                    ;|
$90:BD6D FC 72 BD    JSR ($BD72,x)[$90:BD8E];/
$90:BD70 FA          PLX
$90:BD71 60          RTS

$90:BD72             dw BD86, ; 0: Up, facing right
                        BD8E, ; 1: Up-right
                        BD9C, ; 2: Right
                        BD8E, ; 3: Down-right
                        BD86, ; 4: Down, facing right
                        BD86, ; 5: Down, facing left
                        BD8E, ; 6: Down-left
                        BDA4, ; 7: Left
                        BD8E, ; 8: Up-left
                        BD86  ; 9: Up, facing left
}


;;; $BD86: Initial beam block collision - no wave beam - vertical ;;;
{
$90:BD86 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BD89 22 CA A2 94 JSL $94A2CA[$94:A2CA]  ; Move beam vertically - no wave beam
$90:BD8D 60          RTS
}


;;; $BD8E: Initial beam block collision - no wave beam - diagonal ;;;
{
$90:BD8E AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BD91 22 3B A2 94 JSL $94A23B[$94:A23B]  ; Move beam horizontally - no wave beam
$90:BD95 B0 04       BCS $04    [$BD9B]     ; If not collided:
$90:BD97 22 CA A2 94 JSL $94A2CA[$94:A2CA]  ; Move beam vertically - no wave beam

$90:BD9B 60          RTS
}


;;; $BD9C: Initial beam block collision - no wave beam - right ;;;
{
$90:BD9C AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BD9F 22 3B A2 94 JSL $94A23B[$94:A23B]  ; Move beam horizontally - no wave beam
$90:BDA3 60          RTS
}


;;; $BDA4: Initial beam block collision - no wave beam - left ;;;
{
$90:BDA4 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BDA7 A9 FF FF    LDA #$FFFF             ;\
$90:BDAA 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;} Projectile X velocity = -1
$90:BDAD 22 3B A2 94 JSL $94A23B[$94:A23B]  ; Move beam horizontally - no wave beam
$90:BDB1 60          RTS
}


;;; $BDB2: Initial wave beam block collision ;;;
{
;; Parameters:
;;     X: Projectile index
$90:BDB2 DA          PHX
$90:BDB3 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:BDB6 29 0F 00    AND #$000F             ;|
$90:BDB9 0A          ASL A                  ;} Execute [$BDC0 + ([projectile direction] & Fh) * 2]
$90:BDBA AA          TAX                    ;|
$90:BDBB FC C0 BD    JSR ($BDC0,x)[$90:BDF2];/
$90:BDBE FA          PLX
$90:BDBF 60          RTS

$90:BDC0             dw BDD4, ; 0: Up, facing right
                        BDDC, ; 1: Up-right
                        BDEA, ; 2: Right
                        BDDC, ; 3: Down-right
                        BDD4, ; 4: Down, facing right
                        BDD4, ; 5: Down, facing left
                        BDDC, ; 6: Down-left
                        BDF2, ; 7: Left
                        BDDC, ; 8: Up-left
                        BDD4  ; 9: Up, facing left
}


;;; $BDD4: Initial wave beam block collision - vertical ;;;
{
$90:BDD4 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BDD7 22 E4 A3 94 JSL $94A3E4[$94:A3E4]  ; Move beam vertically - wave beam
$90:BDDB 60          RTS
}


;;; $BDDC: Initial wave beam block collision - diagonal ;;;
{
$90:BDDC AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BDDF 22 52 A3 94 JSL $94A352[$94:A352]  ; Move beam horizontally - wave beam
$90:BDE3 B0 04       BCS $04    [$BDE9]
$90:BDE5 22 E4 A3 94 JSL $94A3E4[$94:A3E4]  ; Move beam vertically - wave beam

$90:BDE9 60          RTS
}


;;; $BDEA: Initial wave beam block collision - right ;;;
{
$90:BDEA AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BDED 22 52 A3 94 JSL $94A352[$94:A352]  ; Move beam horizontally - wave beam
$90:BDF1 60          RTS
}


;;; $BDF2: Initial wave beam block collision - left ;;;
{
$90:BDF2 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:BDF5 A9 FF FF    LDA #$FFFF             ;\
$90:BDF8 9D DC 0B    STA $0BDC,x[$7E:0BDC]  ;} Projectile X velocity = -1
$90:BDFB 22 52 A3 94 JSL $94A352[$94:A352]  ; Move beam horizontally - wave beam
$90:BDFF 60          RTS
}
}


;;; $BE00: Projectile reflection ;;;
{
;; Parameters:
;;     $14: Projectile index
$90:BE00 08          PHP
$90:BE01 8B          PHB
$90:BE02 4B          PHK                    ;\
$90:BE03 AB          PLB                    ;} DB = $90
$90:BE04 C2 30       REP #$30
$90:BE06 DA          PHX
$90:BE07 A6 14       LDX $14    [$7E:0014]  ; X = [$14]
$90:BE09 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:BE0C 89 00 01    BIT #$0100             ;} If (projectile type) = missile: go to BRANCH_MISSILE
$90:BE0F D0 1E       BNE $1E    [$BE2F]     ;/
$90:BE11 89 00 02    BIT #$0200             ;\
$90:BE14 D0 2B       BNE $2B    [$BE41]     ;} If (projectile type) = super missile: go to BRANCH_SUPER
$90:BE16 22 97 B1 90 JSL $90B197[$90:B197]  ; Initialise beam velocities
$90:BE1A 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:BE1E BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:BE21 29 0F 00    AND #$000F             ;|
$90:BE24 0A          ASL A                  ;|
$90:BE25 A8          TAY                    ;} Projectile pre-instruction = [$BA3E + (beam type) * 2]
$90:BE26 B9 3E BA    LDA $BA3E,y[$90:BA50]  ;|
$90:BE29 9D 68 0C    STA $0C68,x[$7E:0C68]  ;|
$90:BE2C 9B          TXY                    ;/
$90:BE2D 80 2F       BRA $2F    [$BE5E]     ; Return

; BRANCH_MISSILE
$90:BE2F 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:BE33 A9 68 AF    LDA #$AF68             ;\
$90:BE36 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $AF68
$90:BE39 A9 F0 00    LDA #$00F0             ;\
$90:BE3C 9D 7C 0C    STA $0C7C,x            ;} Projectile extra base speed = F0h
$90:BE3F 80 1D       BRA $1D    [$BE5E]     ; Return

; BRANCH_SUPER
$90:BE41 DA          PHX                    ;\
$90:BE42 BD 7C 0C    LDA $0C7C,x            ;|
$90:BE45 29 FF 00    AND #$00FF             ;|
$90:BE48 AA          TAX                    ;} Clear super missile link projectile
$90:BE49 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;|
$90:BE4D FA          PLX                    ;/
$90:BE4E 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:BE52 A9 E5 AF    LDA #$AFE5             ;\
$90:BE55 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $AFE5
$90:BE58 A9 F0 00    LDA #$00F0             ;\
$90:BE5B 9D 7C 0C    STA $0C7C,x            ;} Projectile extra base speed = F0h

$90:BE5E FA          PLX
$90:BE5F AB          PLB
$90:BE60 28          PLP
$90:BE61 6B          RTL
}


;;; $BE62: HUD selection handler - missiles / super missiles ;;;
{
; The checks at $BE8D and $BE94 *should* be useless, due to (super) missiles getting deselected when they reach 0
; But actually, crystal flash can reduce the ammo count to zero and does *not* deselect the weapon, so the checks aren't quite useless
$90:BE62 08          PHP
$90:BE63 C2 30       REP #$30
$90:BE65 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:BE67 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not newly pressing shoot:
$90:BE6A D0 0A       BNE $0A    [$BE76]     ;/
$90:BE6C AD 00 0E    LDA $0E00  [$7E:0E00]  ;\
$90:BE6F 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not previously newly pressing shoot:
$90:BE72 D0 02       BNE $02    [$BE76]     ;/
$90:BE74 28          PLP
$90:BE75 60          RTS                    ; Return

$90:BE76 20 5A AC    JSR $AC5A  [$90:AC5A]  ; Check if Samus can fire (super) missile
$90:BE79 B0 07       BCS $07    [$BE82]     ; If so: go to BRANCH_FIRE

$90:BE7B 28          PLP
$90:BE7C 60          RTS                    ; Return

; BRANCH_CANNOT_FIRE
$90:BE7D CE CE 0C    DEC $0CCE  [$7E:0CCE]  ; Decrement projectile counter
$90:BE80 28          PLP
$90:BE81 60          RTS                    ; Return

; BRANCH_FIRE
$90:BE82 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:BE85 C9 02 00    CMP #$0002             ;} If [HUD item index] != super missiles:
$90:BE88 F0 07       BEQ $07    [$BE91]     ;/
$90:BE8A AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$90:BE8D F0 EE       BEQ $EE    [$BE7D]     ;} If [Samus missiles] = 0: go to BRANCH_CANNOT_FIRE
$90:BE8F 80 05       BRA $05    [$BE96]

$90:BE91 AD CA 09    LDA $09CA  [$7E:09CA]  ;\ Else ([HUD item index] = super missiles):
$90:BE94 F0 E7       BEQ $E7    [$BE7D]     ;} If [Samus super missiles] = 0: go to BRANCH_CANNOT_FIRE

$90:BE96 A2 00 00    LDX #$0000             ; X = 0 (projectile index)

; LOOP
$90:BE99 BD 2C 0C    LDA $0C2C,x[$7E:0C2C]  ;\
$90:BE9C F0 09       BEQ $09    [$BEA7]     ;} If [projectile damage] != 0:
$90:BE9E E8          INX                    ;\
$90:BE9F E8          INX                    ;} X += 2
$90:BEA0 E0 0A 00    CPX #$000A             ;\
$90:BEA3 30 F4       BMI $F4    [$BE99]     ;} If [X] < Ah: go to LOOP
$90:BEA5 80 D6       BRA $D6    [$BE7D]     ; Go to BRANCH_CANNOT_FIRE

$90:BEA7 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:BEA9 20 56 BA    JSR $BA56  [$90:BA56]  ; Initialise projectile position / direction
$90:BEAC 90 03       BCC $03    [$BEB1]     ; If cannot fire:
$90:BEAE 4C 7B BE    JMP $BE7B  [$90:BE7B]  ; Return

$90:BEB1 A9 14 00    LDA #$0014             ;\
$90:BEB4 8D AC 18    STA $18AC  [$7E:18AC]  ;} Projectile invincibility timer = 20
$90:BEB7 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:BEBA C9 02 00    CMP #$0002             ;} If [HUD item index] != super missiles:
$90:BEBD F0 05       BEQ $05    [$BEC4]     ;/
$90:BEBF CE C6 09    DEC $09C6  [$7E:09C6]  ; Decrement Samus missiles
$90:BEC2 80 03       BRA $03    [$BEC7]
                                            ; Else ([HUD item index] = super missiles):
$90:BEC4 CE CA 09    DEC $09CA  [$7E:09CA]  ; Decrement Samus super missiles

$90:BEC7 A6 14       LDX $14    [$7E:0014]  ; X = [$14] (projectile index)
$90:BEC9 A9 04 00    LDA #$0004             ;\
$90:BECC 9D 90 0C    STA $0C90,x[$7E:0C90]  ;} Projectile trail timer = 4
$90:BECF AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:BED2 48          PHA                    ;|
$90:BED3 EB          XBA                    ;|
$90:BED4 85 12       STA $12    [$7E:0012]  ;|
$90:BED6 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;} Projectile type |= [HUD item index] * 100h | 8000h
$90:BED9 05 12       ORA $12    [$7E:0012]  ;|
$90:BEDB 09 00 80    ORA #$8000             ;|
$90:BEDE 9D 18 0C    STA $0C18,x[$7E:0C18]  ;/
$90:BEE1 68          PLA                    ;\
$90:BEE2 29 0F 00    AND #$000F             ;|
$90:BEE5 0A          ASL A                  ;} X = [HUD item index] * 2
$90:BEE6 AA          TAX                    ;/
$90:BEE7 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$90:BEEA D0 07       BNE $07    [$BEF3]     ;} If [cinematic function] = 0:
$90:BEEC BD BF C2    LDA $C2BF,x[$90:C2C1]  ;\
$90:BEEF 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound [$C2BF + [HUD item index] * 2], sound library 1, max queued sounds allowed = 6

$90:BEF3 20 DD B1    JSR $B1DD  [$90:B1DD]  ; Initialise (super) missile velocities
$90:BEF6 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:BEFA BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$90:BEFD 48          PHA                    ;|
$90:BEFE 89 00 02    BIT #$0200             ;} If projectile is not super missile:
$90:BF01 D0 08       BNE $08    [$BF0B]     ;/
$90:BF03 A9 68 AF    LDA #$AF68             ;\
$90:BF06 9D 68 0C    STA $0C68,x[$7E:0C68]  ;} Projectile pre-instruction = $AF68 (missile)
$90:BF09 80 06       BRA $06    [$BF11]

$90:BF0B A9 E5 AF    LDA #$AFE5             ;\ Else (projectile is super missile):
$90:BF0E 9D 68 0C    STA $0C68,x[$7E:0C68]  ;} Projectile pre-instruction = $AFE5 (super missile)

$90:BF11 68          PLA                    ;\
$90:BF12 EB          XBA                    ;|
$90:BF13 29 0F 00    AND #$000F             ;|
$90:BF16 A8          TAY                    ;} Cooldown timer = [$C27A + (projectile type)]
$90:BF17 B9 7A C2    LDA $C27A,y[$90:C27B]  ;|
$90:BF1A 29 FF 00    AND #$00FF             ;|
$90:BF1D 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:BF20 AD 04 0A    LDA $0A04  [$7E:0A04]  ;\
$90:BF23 F0 08       BEQ $08    [$BF2D]     ;} If [auto-cancel HUD item index] != nothing:
$90:BF25 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$90:BF28 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing
$90:BF2B 80 17       BRA $17    [$BF44]     ; Return

$90:BF2D AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:BF30 C9 02 00    CMP #$0002             ;} If [HUD item index] != super missiles:
$90:BF33 F0 07       BEQ $07    [$BF3C]     ;/
$90:BF35 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$90:BF38 D0 0A       BNE $0A    [$BF44]     ;} If [Samus missiles] != 0: return
$90:BF3A 80 05       BRA $05    [$BF41]

$90:BF3C AD CA 09    LDA $09CA  [$7E:09CA]  ;\ Else ([HUD item index] = super missiles):
$90:BF3F D0 03       BNE $03    [$BF44]     ;} If [Samus super missiles] != 0: return

$90:BF41 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing

$90:BF44 28          PLP
$90:BF45 60          RTS
}


;;; $BF46: Spawn super missile link ;;;
{
$90:BF46 A2 00 00    LDX #$0000             ; X = 0 (new projectile index)

; LOOP
$90:BF49 BD 2C 0C    LDA $0C2C,x[$7E:0C2C]  ;\
$90:BF4C F0 09       BEQ $09    [$BF57]     ;} If [projectile [X] damage] != 0:
$90:BF4E E8          INX                    ;\
$90:BF4F E8          INX                    ;} X += 2
$90:BF50 E0 0A 00    CPX #$000A             ;\
$90:BF53 30 F4       BMI $F4    [$BF49]     ;} If [X] < Ah: go to LOOP
$90:BF55 80 43       BRA $43    [$BF9A]     ; Return

$90:BF57 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:BF59 9B          TXY                    ; Y = [X]
$90:BF5A B9 18 0C    LDA $0C18,y[$7E:0C1A]  ;\
$90:BF5D 09 00 82    ORA #$8200             ;} New projectile type |= 8200h (super missile)
$90:BF60 99 18 0C    STA $0C18,y[$7E:0C1A]  ;/
$90:BF63 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ; X = [projectile index]
$90:BF66 BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$90:BF69 99 64 0B    STA $0B64,y[$7E:0B66]  ;} New projectile X position = [projectile X position]
$90:BF6C BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$90:BF6F 99 78 0B    STA $0B78,y[$7E:0B7A]  ;} New projectile Y position = [projectile Y position]
$90:BF72 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$90:BF75 99 04 0C    STA $0C04,y[$7E:0C06]  ;} New projectile direction = [projectile X direction]
$90:BF78 20 56 BA    JSR $BA56  [$90:BA56]  ; Initialise projectile position / direction (overwriting the last three stores...)
$90:BF7B BB          TYX                    ; X = [Y]
$90:BF7C 22 71 80 93 JSL $938071[$93:8071]  ; Initialise super missile link
$90:BF80 A9 75 B0    LDA #$B075             ;\
$90:BF83 9D 68 0C    STA $0C68,x[$7E:0C6A]  ;} New projectile pre-instruction = $B075 (super missile link)
$90:BF86 86 12       STX $12    [$7E:0012]  ;\
$90:BF88 AE DE 0D    LDX $0DDE  [$7E:0DDE]  ;|
$90:BF8B BD 7C 0C    LDA $0C7C,x[$7E:0C7C]  ;|
$90:BF8E 29 00 FF    AND #$FF00             ;} Projectile super missile link index = [X]
$90:BF91 18          CLC                    ;|
$90:BF92 65 12       ADC $12    [$7E:0012]  ;|
$90:BF94 9D 7C 0C    STA $0C7C,x[$7E:0C7C]  ;/
$90:BF97 EE CE 0C    INC $0CCE  [$7E:0CCE]  ; Increment projectile counter

$90:BF9A 60          RTS
}


;;; $BF9B: Bomb timer reset value ;;;
{
$90:BF9B             dw 003C
}


;;; $BF9D: HUD selection handler - morph ball ;;;
{
$90:BF9D 08          PHP
$90:BF9E C2 30       REP #$30
$90:BFA0 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:BFA2 2D B2 09    AND $09B2  [$7E:09B2]  ;} If pressing shoot:
$90:BFA5 F0 0B       BEQ $0B    [$BFB2]     ;/
$90:BFA7 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:BFAA C9 03 00    CMP #$0003             ;} If [HUD item index] != power bombs: go to BRANCH_BOMB
$90:BFAD D0 1B       BNE $1B    [$BFCA]     ;/
$90:BFAF 4C 1C C0    JMP $C01C  [$90:C01C]  ; Go to BRANCH_POWER_BOMB

$90:BFB2 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:BFB5 F0 11       BEQ $11    [$BFC8]     ;} If [flare counter] != 0:
$90:BFB7 A9 02 00    LDA #$0002             ;\
$90:BFBA 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 9 (silence)
$90:BFBE 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:BFC1 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear flare animation state
$90:BFC4 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette

$90:BFC8 28          PLP
$90:BFC9 60          RTS                    ; Return

; BRANCH_BOMB
$90:BFCA 20 AB C0    JSR $C0AB  [$90:C0AB]  ; Charge bomb spread or reserve slot to fire bomb
$90:BFCD 90 4B       BCC $4B    [$C01A]     ; If not reserved bomb slot: return
$90:BFCF A2 0A 00    LDX #$000A             ; X = Ah (projectile index)

; LOOP_BOMB
$90:BFD2 BD 18 0C    LDA $0C18,x[$7E:0C22]  ;\
$90:BFD5 F0 09       BEQ $09    [$BFE0]     ;} If [projectile type] != 0:
$90:BFD7 E8          INX                    ;\
$90:BFD8 E8          INX                    ;} X += 2
$90:BFD9 E0 14 00    CPX #$0014             ;\
$90:BFDC 30 F4       BMI $F4    [$BFD2]     ;} If [X] < 14h: go to LOOP
$90:BFDE CA          DEX                    ;\
$90:BFDF CA          DEX                    ;} X -= 2 (overwrite last slot(!))

$90:BFE0 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:BFE2 A9 00 05    LDA #$0500             ;\
$90:BFE5 9D 18 0C    STA $0C18,x[$7E:0C22]  ;} Projectile type = bomb
$90:BFE8 48          PHA
$90:BFE9 A9 00 00    LDA #$0000             ;\
$90:BFEC 9D 04 0C    STA $0C04,x[$7E:0C0E]  ;} Projectile direction = 0
$90:BFEF AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:BFF2 9D 64 0B    STA $0B64,x[$7E:0B6E]  ;} Projectile X position = [Samus X position]
$90:BFF5 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:BFF8 9D 78 0B    STA $0B78,x[$7E:0B82]  ;} Projectile Y position = [Samus Y position]
$90:BFFB AD 9B BF    LDA $BF9B  [$90:BF9B]  ;\
$90:BFFE 9D 7C 0C    STA $0C7C,x[$7E:0C86]  ;} Bomb timer = 60
$90:C001 22 A0 80 93 JSL $9380A0[$93:80A0]  ; Initialise (power) bomb
$90:C005 A9 99 B0    LDA #$B099             ;\
$90:C008 9D 68 0C    STA $0C68,x[$7E:0C72]  ;} Projectile pre-instruction = $B099 (bomb)
$90:C00B 68          PLA
$90:C00C EB          XBA                    ;\
$90:C00D 29 0F 00    AND #$000F             ;|
$90:C010 A8          TAY                    ;|
$90:C011 B9 7A C2    LDA $C27A,y[$90:C27F]  ;} Cooldown timer = 10h
$90:C014 29 FF 00    AND #$00FF             ;|
$90:C017 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/

$90:C01A 28          PLP
$90:C01B 60          RTS                    ; Return

; BRANCH_POWER_BOMB
$90:C01C AD EE 0C    LDA $0CEE  [$7E:0CEE]  ;\
$90:C01F 10 02       BPL $02    [$C023]     ;} If power bomb is active:
$90:C021 28          PLP
$90:C022 60          RTS                    ; Return

$90:C023 20 E7 C0    JSR $C0E7  [$90:C0E7]  ; Reserve slot to fire (power) bomb
$90:C026 90 F9       BCC $F9    [$C021]     ; If not reserved bomb slot: return
$90:C028 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$90:C02B F0 7C       BEQ $7C    [$C0A9]     ;} If [Samus power bombs] = 0: return
$90:C02D 3A          DEC A                  ;\
$90:C02E 8D CE 09    STA $09CE  [$7E:09CE]  ;} Decrement Samus power bombs
$90:C031 30 76       BMI $76    [$C0A9]     ; If [Samus power bombs] < 0: return
$90:C033 A9 FF FF    LDA #$FFFF             ;\
$90:C036 8D EE 0C    STA $0CEE  [$7E:0CEE]  ;} Power bomb flag = FFFFh
$90:C039 A2 0A 00    LDX #$000A             ; X = Ah (projectile index)

; LOOP_POWER_BOMB
$90:C03C BD 18 0C    LDA $0C18,x[$7E:0C22]  ;\
$90:C03F F0 09       BEQ $09    [$C04A]     ;} If [projectile type] != 0:
$90:C041 E8          INX                    ;\
$90:C042 E8          INX                    ;} X += 2
$90:C043 E0 14 00    CPX #$0014             ;\
$90:C046 30 F4       BMI $F4    [$C03C]     ;} If [X] < 14h: go to LOOP
$90:C048 CA          DEX                    ;\
$90:C049 CA          DEX                    ;} X -= 2 (overwrite last slot(!))

$90:C04A 86 14       STX $14    [$7E:0014]  ; $14 = [X]
$90:C04C AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C04F EB          XBA                    ;|
$90:C050 85 12       STA $12    [$7E:0012]  ;|
$90:C052 BD 18 0C    LDA $0C18,x[$7E:0C22]  ;} Projectile type = [HUD item index] * 100h
$90:C055 05 12       ORA $12    [$7E:0012]  ;|
$90:C057 9D 18 0C    STA $0C18,x[$7E:0C22]  ;/
$90:C05A 48          PHA
$90:C05B A9 00 00    LDA #$0000             ;\
$90:C05E 9D 04 0C    STA $0C04,x[$7E:0C0E]  ;} Projectile direction = 0
$90:C061 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:C064 9D 64 0B    STA $0B64,x[$7E:0B6E]  ;} Projectile X position = [Samus X position]
$90:C067 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:C06A 9D 78 0B    STA $0B78,x[$7E:0B82]  ;} Projectile Y position = [Samus Y position]
$90:C06D AD 9B BF    LDA $BF9B  [$90:BF9B]  ;\
$90:C070 9D 7C 0C    STA $0C7C,x[$7E:0C86]  ;} Bomb timer = 60
$90:C073 22 A0 80 93 JSL $9380A0[$93:80A0]  ; Initialise (power) bomb
$90:C077 A9 AE B0    LDA #$B0AE             ;\
$90:C07A 9D 68 0C    STA $0C68,x[$7E:0C72]  ;} Projectile pre-instruction = $B0AE (power bomb)
$90:C07D 68          PLA
$90:C07E EB          XBA                    ;\
$90:C07F 29 0F 00    AND #$000F             ;|
$90:C082 A8          TAY                    ;|
$90:C083 B9 7A C2    LDA $C27A,y[$90:C27D]  ;} Cooldown timer = 28h
$90:C086 29 FF 00    AND #$00FF             ;|
$90:C089 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:C08C AD 04 0A    LDA $0A04  [$7E:0A04]  ;\
$90:C08F F0 08       BEQ $08    [$C099]     ;} If [auto-cancel HUD item index] != nothing:
$90:C091 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$90:C094 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing
$90:C097 80 10       BRA $10    [$C0A9]     ; Return

$90:C099 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C09C C9 03 00    CMP #$0003             ;} If [HUD item index] = power bombs:
$90:C09F D0 08       BNE $08    [$C0A9]     ;/
$90:C0A1 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$90:C0A4 D0 03       BNE $03    [$C0A9]     ;} If [Samus power bombs] = 0:
$90:C0A6 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing

$90:C0A9 28          PLP
$90:C0AA 60          RTS
}


;;; $C0AB: Charge bomb spread or reserve slot to fire bomb ;;;
{
;; Returns:
;;     Carry: Set if reserved bomb slot, otherwise clear
$90:C0AB AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:C0AE 89 00 10    BIT #$1000             ;} If bombs not equipped: return carry clear
$90:C0B1 F0 32       BEQ $32    [$C0E5]     ;/
$90:C0B3 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:C0B6 C9 3C 00    CMP #$003C             ;} If [beam charge counter] < 60: go to reserve slot to fire bomb
$90:C0B9 30 2C       BMI $2C    [$C0E7]     ;/
$90:C0BB AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$90:C0BE D0 27       BNE $27    [$C0E7]     ;} If [bomb counter] != 0: go to reserve slot to fire bomb
$90:C0C0 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:C0C2 89 00 04    BIT #$0400             ;} If pressing down:
$90:C0C5 F0 10       BEQ $10    [$C0D7]     ;/
$90:C0C7 AD D4 0C    LDA $0CD4  [$7E:0CD4]  ;\
$90:C0CA 29 C0 00    AND #$00C0             ;|
$90:C0CD C9 C0 00    CMP #$00C0             ;} If [bomb spread charge timeout counter] < C0h:
$90:C0D0 10 05       BPL $05    [$C0D7]     ;/
$90:C0D2 EE D4 0C    INC $0CD4  [$7E:0CD4]  ; Increment bomb spread charge timeout counter
$90:C0D5 80 0E       BRA $0E    [$C0E5]     ; Return carry clear

$90:C0D7 20 49 D8    JSR $D849  [$90:D849]  ; Bomb spread
$90:C0DA 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C0DE A9 02 00    LDA #$0002             ;\
$90:C0E1 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 9 (silence)

$90:C0E5 18          CLC                    ;\
$90:C0E6 60          RTS                    ;} Return carry clear
}


;;; $C0E7: Reserve slot to fire (power) bomb ;;;
{
;; Returns:
;;     Carry: Set if reserved bomb slot, otherwise clear

; The caller routines overwrite the cooldown timer ($C017/$C089), so the (rather odd) increment done here has no effect
$90:C0E7 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:C0E9 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not pressing shoot: go to BRANCH_NO_FIRE
$90:C0EC F0 22       BEQ $22    [$C110]     ;/
$90:C0EE AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$90:C0F1 F0 0D       BEQ $0D    [$C100]     ;} If [bomb counter] != 0:
$90:C0F3 C9 05 00    CMP #$0005             ;\
$90:C0F6 10 18       BPL $18    [$C110]     ;} If [bomb counter] >= 5: go to BRANCH_NO_FIRE
$90:C0F8 AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$90:C0FB 29 FF 00    AND #$00FF             ;} If [cooldown timer] != 0: go to BRANCH_NO_FIRE
$90:C0FE D0 10       BNE $10    [$C110]     ;/

$90:C100 AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$90:C103 1A          INC A                  ;} Increment cooldown timer (>_<;)
$90:C104 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:C107 AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;\
$90:C10A 1A          INC A                  ;} Increment bomb counter
$90:C10B 8D D2 0C    STA $0CD2  [$7E:0CD2]  ;/
$90:C10E 38          SEC                    ;\
$90:C10F 60          RTS                    ;} Return carry set

; BRANCH_NO_FIRE
$90:C110 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:C113 F0 11       BEQ $11    [$C126]     ;} If [flare counter] != 0:
$90:C115 A9 02 00    LDA #$0002             ;\
$90:C118 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 9 (silence)
$90:C11C 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:C11F 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear flare animation state
$90:C122 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette

$90:C126 18          CLC                    ;\
$90:C127 60          RTS                    ;} Return carry clear
}


;;; $C128: Handle bomb ;;;
{
$90:C128 08          PHP
$90:C129 C2 30       REP #$30
$90:C12B AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:C12E BD 7C 0C    LDA $0C7C,x[$7E:0C86]  ;\
$90:C131 F0 22       BEQ $22    [$C155]     ;} If [bomb timer] = 0: return
$90:C133 3A          DEC A                  ;\
$90:C134 9D 7C 0C    STA $0C7C,x[$7E:0C86]  ;} Decrement bomb timer
$90:C137 F0 11       BEQ $11    [$C14A]     ; If [bomb timer] != 0:
$90:C139 C9 0F 00    CMP #$000F             ;\
$90:C13C D0 17       BNE $17    [$C155]     ;} If [bomb timer] != Fh: return
$90:C13E BD 40 0C    LDA $0C40,x[$7E:0C4A]  ;\
$90:C141 18          CLC                    ;|
$90:C142 69 1C 00    ADC #$001C             ;} Projectile instruction pointer += 1Ch
$90:C145 9D 40 0C    STA $0C40,x[$7E:0C4A]  ;/
$90:C148 80 0B       BRA $0B    [$C155]     ; Return

$90:C14A A9 08 00    LDA #$0008             ;\
$90:C14D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 8, sound library 2, max queued sounds allowed = 6 (bomb explosion)
$90:C151 22 4E 81 93 JSL $93814E[$93:814E]  ; Initialise bomb explosion

$90:C155 28          PLP
$90:C156 60          RTS
}


;;; $C157: Handle power bomb ;;;
{
; The call to $ADB7 really shouldn't be there, there's more processing to be done to the projectile this frame
; Clearing projectile RAM should be left for the pre-instruction $B0AE to do, by signalling to delete the projectile
$90:C157 08          PHP
$90:C158 C2 30       REP #$30
$90:C15A AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:C15D BD 7C 0C    LDA $0C7C,x[$7E:0C86]  ;\
$90:C160 F0 3B       BEQ $3B    [$C19D]     ;} If [bomb timer] = 0: go to BRANCH_ZERO
$90:C162 3A          DEC A                  ;\
$90:C163 9D 7C 0C    STA $0C7C,x[$7E:0C86]  ;} Decrement bomb timer
$90:C166 F0 11       BEQ $11    [$C179]     ; If [bomb timer] != 0:
$90:C168 C9 0F 00    CMP #$000F             ;\
$90:C16B D0 39       BNE $39    [$C1A6]     ;} If [bomb timer] != Fh: return
$90:C16D BD 40 0C    LDA $0C40,x[$7E:0C4A]  ;\
$90:C170 18          CLC                    ;|
$90:C171 69 1C 00    ADC #$001C             ;} Projectile instruction pointer += 1Ch
$90:C174 9D 40 0C    STA $0C40,x[$7E:0C4A]  ;/
$90:C177 80 2D       BRA $2D    [$C1A6]     ; Return

$90:C179 BD 64 0B    LDA $0B64,x[$7E:0B6E]  ;\
$90:C17C 8D E2 0C    STA $0CE2  [$7E:0CE2]  ;} Power bomb explosion X position = [projectile X position]
$90:C17F BD 78 0B    LDA $0B78,x[$7E:0B82]  ;\
$90:C182 8D E4 0C    STA $0CE4  [$7E:0CE4]  ;} Power bomb explosion Y position = [projectile Y position]
$90:C185 DA          PHX
$90:C186 5A          PHY
$90:C187 08          PHP
$90:C188 8B          PHB
$90:C189 22 88 82 88 JSL $888288[$88:8288]  ; Enable HDMA objects
$90:C18D 22 A4 8A 88 JSL $888AA4[$88:8AA4]  ; Spawn power bomb explosion
$90:C191 AB          PLB
$90:C192 28          PLP
$90:C193 7A          PLY
$90:C194 FA          PLX
$90:C195 A9 FF FF    LDA #$FFFF             ;\
$90:C198 9D 7C 0C    STA $0C7C,x[$7E:0C86]  ;} Bomb timer = FFFFh
$90:C19B 80 09       BRA $09    [$C1A6]     ; Return

; BRANCH_ZERO
$90:C19D AD EE 0C    LDA $0CEE  [$7E:0CEE]  ;\
$90:C1A0 D0 04       BNE $04    [$C1A6]     ;} If power bomb is not active:
$90:C1A2 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile

$90:C1A6 28          PLP
$90:C1A7 60          RTS
}


;;; $C1A8: Projectile origin offsets by direction ;;;
{
;                        ________________________________________________ 0: Up, facing right
;                       |     ___________________________________________ 1: Up-right
;                       |    |     ______________________________________ 2: Right
;                       |    |    |     _________________________________ 3: Down-right
;                       |    |    |    |     ____________________________ 4: Down, facing right
;                       |    |    |    |    |     _______________________ 5: Down, facing left
;                       |    |    |    |    |    |     __________________ 6: Down-left
;                       |    |    |    |    |    |    |     _____________ 7: Left
;                       |    |    |    |    |    |    |    |     ________ 8: Up-left
;                       |    |    |    |    |    |    |    |    |     ___ 9: Up, facing left
;                       |    |    |    |    |    |    |    |    |    |      _____________ Ah: Turning - aiming up / up-left / up-right
;                       |    |    |    |    |    |    |    |    |    |     |     ________ Bh: Turning - neutral aim
;                       |    |    |    |    |    |    |    |    |    |     |    |     ___ Ch: Turning - aiming down / down-left / down-right
;                       |    |    |    |    |    |    |    |    |    |     |    |    |
$90:C1A8             dw 0002,0012,000F,0011,0003,FFFC,FFEF,FFF1,FFEE,FFFE, FFFC,FFFC,FFFC ; Flare X offsets - default
$90:C1C2             dw FFE4,FFED,0001,0006,0011,0011,0006,0001,FFEC,FFE4, FFEC,FFFE,0008 ; Flare Y offsets - default

$90:C1DC             dw 0002,0013,0014,0012,0003,FFFC,FFEE,FFEC,FFED,FFFE ; Flare X offsets - running
$90:C1F0             dw FFE0,FFEA,FFFD,0006,0019,0019,0006,FFFD,FFEC,FFE0 ; Flare Y offsets - running

$90:C204             dw 0002,000D,000B,000D,0002,FFFB,FFF2,FFF5,FFED,FFFE ; Projectile origin X offsets - default
$90:C218             dw FFF8,FFF3,0001,0004,000D,000D,0004,0001,FFED,FFF8 ; Projectile origin Y offsets - default

$90:C22C             dw 0002,000F,000F,000D,0002,FFFB,FFF3,FFF3,FFF1,FFFE ; Projectile origin X offsets - moonwalking - aiming up / running
$90:C240             dw FFF8,FFF0,FFFE,0001,000D,000D,0001,FFFE,FFF0,FFF8 ; Projectile origin Y offsets - moonwalking - aiming up / running
}


;;; $C254: Projectile cooldowns ;;;
{
; Uncharged
$90:C254             db 0F, ; 0: Power
                        0F, ; 1: Wave
                        0F, ; 2: Ice
                        0F, ; 3: Ice + wave
                        0F, ; 4: Spazer
                        0F, ; 5: Spazer + wave
                        0F, ; 6: Spazer + ice
                        0F, ; 7: Spazer + ice + wave
                        0F, ; 8: Plasma
                        0F, ; 9: Plasma + wave
                        0C, ; Ah: Plasma + ice <-- !
                        0F, ; Bh: Plasma + ice + wave
                        00, 00, 00, 00

; Charged
$90:C264             db 1E, ; 0: Power
                        1E, ; 1: Wave
                        1E, ; 2: Ice
                        1E, ; 3: Ice + wave
                        1E, ; 4: Spazer
                        1E, ; 5: Spazer + wave
                        1E, ; 6: Spazer + ice
                        1E, ; 7: Spazer + ice + wave
                        1E, ; 8: Plasma
                        1E, ; 9: Plasma + wave
                        1E, ; Ah: Plasma + ice
                        1E, ; Bh: Plasma + ice + wave
                        00, 00, 00, 00

; Useless padding?
$90:C274             db 00, 00, 00, 00, 00, 00

; Non-beam projectiles
$90:C27A             db 00,
                        0A, ; Missile
                        14, ; Super missile
                        28, ; Power bomb
                        00,
                        10, ; Bomb
                        00,
                        00,
                        00
}


;;; $C283: Beam auto-fire cooldowns ;;;
{
$90:C283             db 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19
}


;;; $C28F: Projectile sound effects ;;;
{
; Uncharged
$90:C28F             dw 000B, ; 0: Power
                        000D, ; 1: Wave
                        000C, ; 2: Ice
                        000E, ; 3: Ice + wave
                        000F, ; 4: Spazer
                        0012, ; 5: Spazer + wave
                        0010, ; 6: Spazer + ice
                        0011, ; 7: Spazer + ice + wave
                        0013, ; 8: Plasma
                        0016, ; 9: Plasma + wave
                        0014, ; Ah: Plasma + ice
                        0015  ; Bh: Plasma + ice + wave

; Charged
$90:C2A7             dw 0017, ; 0: Power
                        0019, ; 1: Wave
                        0018, ; 2: Ice
                        001A, ; 3: Ice + wave
                        001B, ; 4: Spazer
                        001E, ; 5: Spazer + wave
                        001C, ; 6: Spazer + ice
                        001D, ; 7: Spazer + ice + wave
                        001F, ; 8: Plasma
                        0022, ; 9: Plasma + wave
                        0020, ; Ah: Plasma + ice
                        0021  ; Bh: Plasma + ice + wave

; Non-beam projectiles
;                              _________ Missiles
;                             |      ___ Super missiles
;                             |     |
$90:C2BF             dw 0000, 0003, 0004, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $C2D1: Beam speeds ;;;
{
;                        ________ Speed for horizontal / vertical direction
;                       |     ___ Speed for diagonal direction
;                       |    |
$90:C2D1             dw 0400,02AB, ; 0: Power
                        0400,02AB, ; 1: Wave
                        0400,02AB, ; 2: Ice
                        0400,02AB, ; 3: Ice + wave
                        0400,02AB, ; 4: Spazer
                        0400,02AB, ; 5: Spazer + wave
                        0400,02AB, ; 6: Spazer + ice
                        0400,02AB, ; 7: Spazer + ice + wave
                        0400,02AB, ; 8: Plasma
                        0400,02AB, ; 9: Plasma + wave
                        0400,02AB, ; Ah: Plasma + ice
                        0400,02AB  ; Bh: Plasma + ice + wave
}


;;; $C301: (Super) missile initialised bitset ;;;
{
; This gets added to projectile $0C7C to indicate that it's been initialised
$90:C301             dw 0100
}


;;; $C303: Missile accelerations ;;;
{
;                        ________ X acceleration. Unit 1/100h px/frame²
;                       |     ___ Y acceleration. Unit 1/100h px/frame²
;                       |    |
$90:C303             dw 0000,FFC0, ; 0: Up, facing right
                        0036,FFCA, ; 1: Up-right
                        0040,0000, ; 2: Right
                        0036,0036, ; 3: Down-right
                        0000,0040, ; 4: Down, facing right
                        0000,0040, ; 5: Down, facing left
                        FFCA,0036, ; 6: Down-left
                        FFC0,0000, ; 7: Left
                        FFCA,FFCA, ; 8: Up-left
                        0000,FFC0  ; 9: Up, facing left
}


;;; $C32B: Super missile accelerations ;;;
{
;                        ________ X acceleration. Unit 1/100h px/frame²
;                       |     ___ Y acceleration. Unit 1/100h px/frame²
;                       |    |
$90:C32B             dw 0000,FF00, ; 0: Up, facing right
                        00B6,FF4A, ; 1: Up-right
                        0100,0000, ; 2: Right
                        00B6,00B6, ; 3: Down-right
                        0000,0100, ; 4: Down, facing right
                        0000,0100, ; 5: Down, facing left
                        FF4A,00B6, ; 6: Down-left
                        FF00,0000, ; 7: Left
                        FF4A,FF4A, ; 8: Up-left
                        0000,FF00  ; 9: Up, facing left
}


;;; $C353: Projectile accelerations ;;;
{
; X acceleration. Unit 1/100h px/frame²
$90:C353             dw 0000, ; 0: Up, facing right
                        0010, ; 1: Up-right
                        0010, ; 2: Right
                        0010, ; 3: Down-right
                        0000, ; 4: Down, facing right
                        0000, ; 5: Down, facing left
                        FFF0, ; 6: Down-left
                        FFF0, ; 7: Left
                        FFF0, ; 8: Up-left
                        0000  ; 9: Up, facing left

; Y acceleration. Unit 1/100h px/frame²
$90:C367             dw FFF0, ; 0: Up, facing right
                        FFF0, ; 1: Up-right
                        0000, ; 2: Right
                        0010, ; 3: Down-right
                        0010, ; 4: Down, facing right
                        0010, ; 5: Down, facing left
                        0010, ; 6: Down-left
                        0000, ; 7: Left
                        FFF0, ; 8: Up-left
                        FFF0  ; 9: Up, facing left
}


;;; $C37B: Proto weapon constants ;;;
{
; Used only by $94:9C73 to set $0DD2 as part of bomb explosion block collision detection
; Highly likely that these tables were supposed to be abandoned entirely and that one check was left over

; Beams:
;                        _______ Unused. Uncharged damage?
;                       |   ____ Unused. Charged damage?
;                       |  |   _ Projectile proto type
;                       |  |  |
$90:C37B             db 03,14,00, ; 0: Power
                        0A,28,01, ; 1: Wave
                        05,1E,00, ; 2: Ice
                        0A,28,01, ; 3: Ice + wave
                        14,50,00, ; 4: Spazer
                        14,50,01, ; 5: Spazer + wave
                        14,50,00, ; 6: Spazer + ice
                        14,50,01, ; 7: Spazer + ice + wave
                        1E,64,00, ; 8: Plasma
                        1E,64,01, ; 9: Plasma + wave
                        1E,64,00, ; Ah: Plasma + ice
                        1E,64,01  ; Bh: Plasma + ice + wave

; Non-beams:
;                        ____ Unused. Damage?
;                       |   _ Projectile proto type
;                       |  |
$90:C39F             db 00,00,
                        0A,00, ; Missile
                        32,00, ; Super missile
                        32,03, ; Power bomb
                        00,FF,
                        0A,02, ; Bomb
                        00,FF,
                        00,FF,
                        00,FF
}


;;; $C3B1: Beam tiles pointers ;;;
{
; Pointers to bank $9A
$90:C3B1             dw F200, ; 0: Power
                        F600, ; 1: Wave
                        F400, ; 2: Ice
                        F600, ; 3: Ice + wave
                        FA00, ; 4: Spazer
                        FA00, ; 5: Spazer + wave
                        FA00, ; 6: Spazer + ice
                        FA00, ; 7: Spazer + ice + wave
                        F800, ; 8: Plasma
                        F800, ; 9: Plasma + wave
                        F800, ; Ah: Plasma + ice
                        F800  ; Bh: Plasma + ice + wave
}


;;; $C3C9: Beam palette pointers ;;;
{
$90:C3C9             dw C3E1, ; 0: Power
                        C421, ; 1: Wave
                        C401, ; 2: Ice
                        C401, ; 3: Ice + wave
                        C461, ; 4: Spazer
                        C421, ; 5: Spazer + wave
                        C401, ; 6: Spazer + ice
                        C401, ; 7: Spazer + ice + wave
                        C441, ; 8: Plasma
                        C441, ; 9: Plasma + wave
                        C401, ; Ah: Plasma + ice
                        C401  ; Bh: Plasma + ice + wave
}


;;; $C3E1: Beam palettes ;;;
{
$90:C3E1             dw 3800,7FFF,19FF,1D55,10AD,53FF,039E,295F,18DF,0000,0000,0000,0000,0000,0000,104A ; Power
$90:C401             dw 3800,7FFF,7EC0,6DE0,54E0,7F6E,730A,6665,5E22,7FA0,7B60,7720,72A0,6E60,7F91,20C0 ; Ice
$90:C421             dw 3800,7FFF,7C1F,5816,300C,7EDF,7DDF,7CDF,681A,0000,0000,0000,0000,0000,0000,2409 ; Wave
$90:C441             dw 3800,7FFF,3BE0,2680,1580,6BFA,4BF2,2BEA,03E0,0000,0000,0000,0000,0000,0000,0920 ; Plasma
$90:C461             dw 3800,7FFF,03FF,0216,00EE,6BFF,4BFF,2BFF,037B,0000,0000,0000,0000,0000,0000,00AD ; Spazer
}


;;; $C481: Flare animation delays ;;;
{
; Flare animation delay pointers
$90:C481             dw C487, C4A7, C4AE

; Main flare
$90:C487             db 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03,
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, FE,0E

; Flare slow sparks
$90:C4A7             db 05, 04, 03, 03, 03, 03, FF

; Flare fast sparks
$90:C4AE             db 04, 03, 02, 02, 02, 02, FF
}


;;; $C4B5: Handle switching HUD selection ;;;
{
$90:C4B5 08          PHP
$90:C4B6 C2 30       REP #$30
$90:C4B8 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C4BB 85 12       STA $12    [$7E:0012]  ;} $12 = currently selected HUD item
$90:C4BD A5 8F       LDA $8F    [$7E:008F]  ;\
$90:C4BF 2C B8 09    BIT $09B8  [$7E:09B8]  ;} If newly pressed item cancel:
$90:C4C2 F0 05       BEQ $05    [$C4C9]     ;/
$90:C4C4 9C 04 0A    STZ $0A04  [$7E:0A04]  ;\
$90:C4C7 80 20       BRA $20    [$C4E9]     ; Go to BRANCH_ITEM_CANCEL

$90:C4C9 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:C4CB 2C B8 09    BIT $09B8  [$7E:09B8]  ;|
$90:C4CE D0 04       BNE $04    [$C4D4]     ;|
$90:C4D0 64 16       STZ $16    [$7E:0016]  ;|
$90:C4D2 80 05       BRA $05    [$C4D9]     ;} $16 = pressing item cancel flag
                                            ;|
$90:C4D4 A9 01 00    LDA #$0001             ;|
$90:C4D7 85 16       STA $16    [$7E:0016]  ;/

$90:C4D9 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:C4DB 2C BA 09    BIT $09BA  [$7E:09BA]  ;} If not newly pressed item select: go to BRANCH_ITEM_SELECT_END
$90:C4DE F0 39       BEQ $39    [$C519]     ;/
$90:C4E0 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C4E3 1A          INC A                  ;} Increment currently selected HUD item
$90:C4E4 C9 06 00    CMP #$0006             ;\
$90:C4E7 30 03       BMI $03    [$C4EC]     ;} If [currently selected HUD item] < 6: go to BRANCH_ITEM_CANCEL_END

; BRANCH_ITEM_CANCEL
$90:C4E9 A9 00 00    LDA #$0000             ; Currently selected HUD item = nothing

; BRANCH_ITEM_CANCEL_END
$90:C4EC 8D D2 09    STA $09D2  [$7E:09D2]

; LOOP
$90:C4EF 0A          ASL A                  ;\
$90:C4F0 AA          TAX                    ;} Execute switched to HUD item handler
$90:C4F1 FC 39 C5    JSR ($C539,x)[$90:C551];/
$90:C4F4 90 14       BCC $14    [$C50A]     ; If returned carry set (e.g. switching to missiles but out of ammo or switching to x-ray from missiles):
$90:C4F6 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C4F9 1A          INC A                  ;} Increment currently selected HUD item
$90:C4FA 8D D2 09    STA $09D2  [$7E:09D2]  ;/
$90:C4FD C9 06 00    CMP #$0006             ;\
$90:C500 30 ED       BMI $ED    [$C4EF]     ;} If [currently selected HUD item] < 6: go to LOOP
$90:C502 A9 00 00    LDA #$0000             ;\
$90:C505 8D D2 09    STA $09D2  [$7E:09D2]  ;} Currently selected HUD item = nothing
$90:C508 80 E5       BRA $E5    [$C4EF]     ; Go to LOOP

$90:C50A A5 16       LDA $16    [$7E:0016]  ;\
$90:C50C F0 08       BEQ $08    [$C516]     ;} If holding item cancel:
$90:C50E AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C511 8D 04 0A    STA $0A04  [$7E:0A04]  ;} Auto-cancelling HUD item = [currently selected HUD item]
$90:C514 80 03       BRA $03    [$C519]
                                            ; Else (not holding item cancel):
$90:C516 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancelling HUD item = nothing

; BRANCH_ITEM_SELECT_END
$90:C519 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C51C C5 12       CMP $12    [$7E:0012]  ;} If currently selected HUD item changed: go to BRANCH_ITEM_CHANGED
$90:C51E D0 11       BNE $11    [$C531]     ;/
$90:C520 AD AA 0A    LDA $0AAA  [$7E:0AAA]  ;\
$90:C523 1A          INC A                  ;|
$90:C524 C9 03 00    CMP #$0003             ;|
$90:C527 30 03       BMI $03    [$C52C]     ;} Arm cannon toggle flag = min(2, [arm cannon toggle flag] + 1)
$90:C529 A9 02 00    LDA #$0002             ;|
                                            ;|
$90:C52C 8D AA 0A    STA $0AAA  [$7E:0AAA]  ;/
$90:C52F 80 06       BRA $06    [$C537]     ; Return

; BRANCH_ITEM_CHANGED
$90:C531 A9 01 00    LDA #$0001             ;\
$90:C534 8D AA 0A    STA $0AAA  [$7E:0AAA]  ;} Arm cannon toggle flag = 1

$90:C537 28          PLP
$90:C538 60          RTS

; Switched to HUD item handlers
$90:C539             dw C545, ; Nothing
                        C551, ; Missiles
                        C564, ; Super missiles
                        C577, ; Power bombs
                        C58A, ; Grapple
                        C5AE  ; X-ray
}


;;; $C545: Switched to HUD item handler - nothing ;;;
{
$90:C545 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Clear beam charge counter
$90:C548 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:C54B 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C54F 18          CLC                    ;\
$90:C550 60          RTS                    ;} Return carry clear
}


;;; $C551: Switched to HUD item handler - missiles ;;;
{
$90:C551 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$90:C554 D0 02       BNE $02    [$C558]     ;} If [Samus missiles] = 0:
$90:C556 38          SEC                    ;\
$90:C557 60          RTS                    ;} Return carry set

$90:C558 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Clear beam charge counter
$90:C55B 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:C55E 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C562 18          CLC                    ;\
$90:C563 60          RTS                    ;} Return carry clear
}


;;; $C564: Switched to HUD item handler - super missiles ;;;
{
$90:C564 AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$90:C567 D0 02       BNE $02    [$C56B]     ;} If [Samus super missiles] = 0:
$90:C569 38          SEC                    ;\
$90:C56A 60          RTS                    ;} Return carry set

$90:C56B 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Clear beam charge counter
$90:C56E 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:C571 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C575 18          CLC                    ;\
$90:C576 60          RTS                    ;} Return carry clear
}


;;; $C577: Switched to HUD item handler - power bombs ;;;
{
$90:C577 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$90:C57A D0 02       BNE $02    [$C57E]     ;} If [Samus power bombs] = 0:
$90:C57C 38          SEC                    ;\
$90:C57D 60          RTS                    ;} Return carry set

$90:C57E 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Clear beam charge counter
$90:C581 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:C584 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C588 18          CLC                    ;\
$90:C589 60          RTS                    ;} Return carry clear
}


;;; $C58A: Switched to HUD item handler - grapple ;;;
{
$90:C58A AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:C58D 89 00 40    BIT #$4000             ;} If not equipped grapple:
$90:C590 D0 02       BNE $02    [$C594]     ;/
$90:C592 38          SEC                    ;\
$90:C593 60          RTS                    ;} Return carry set

$90:C594 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:C597 C9 F0 C4    CMP #$C4F0             ;} If [grapple function] != inactive: return carry clear
$90:C59A D0 10       BNE $10    [$C5AC]     ;/
$90:C59C 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C5A0 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Clear beam charge counter
$90:C5A3 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:C5A6 A9 F0 C4    LDA #$C4F0             ;\
$90:C5A9 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple function = inactive

$90:C5AC 18          CLC                    ;\
$90:C5AD 60          RTS                    ;} Return carry clear
}


;;; $C5AE: Switched to HUD item handler - x-ray ;;;
{
$90:C5AE AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:C5B1 89 00 80    BIT #$8000             ;} If not equipped x-ray:
$90:C5B4 D0 02       BNE $02    [$C5B8]     ;/
$90:C5B6 38          SEC                    ;\
$90:C5B7 60          RTS                    ;} Return carry set

$90:C5B8 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Clear beam charge counter
$90:C5BB 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:C5BE 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:C5C2 18          CLC                    ;\
$90:C5C3 60          RTS                    ;} Return carry clear
}


;;; $C5C4: Handle arm cannon open state ;;;
{
$90:C5C4 08          PHP
$90:C5C5 C2 30       REP #$30
$90:C5C7 AD A7 0A    LDA $0AA7  [$7E:0AA7]  ;\
$90:C5CA 29 FF 00    AND #$00FF             ;} If arm cannon is not opening/closing:
$90:C5CD D0 05       BNE $05    [$C5D4]     ;/
$90:C5CF 20 EB C5    JSR $C5EB  [$90:C5EB]  ; Update arm cannon is open flag
$90:C5D2 90 03       BCC $03    [$C5D7]     ; If flag was not changed: go to BRANCH_NO_CHANGE

$90:C5D4 20 27 C6    JSR $C627  [$90:C627]  ; Advance arm cannon frame

; BRANCH_NO_CHANGE
$90:C5D7 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:C5DA 0A          ASL A                  ;|
$90:C5DB AA          TAX                    ;|
$90:C5DC BD DF C7    LDA $C7DF,x[$90:C7E3]  ;|
$90:C5DF A8          TAY                    ;} Arm cannon drawing mode = [[$C7DF + [Samus pose] * 2] + 1]
$90:C5E0 B9 01 00    LDA $0001,y[$90:C9F2]  ;|
$90:C5E3 29 FF 00    AND #$00FF             ;|
$90:C5E6 8D AC 0A    STA $0AAC  [$7E:0AAC]  ;/
$90:C5E9 28          PLP
$90:C5EA 60          RTS
}


;;; $C5EB: Update arm cannon is open flag ;;;
{
;; Returns:
;;     Carry: Set if arm cannon is open flag changed, otherwise clear
$90:C5EB AD AA 0A    LDA $0AAA  [$7E:0AAA]  ;\
$90:C5EE C9 02 00    CMP #$0002             ;} If arm cannon not toggled: return carry clear
$90:C5F1 30 32       BMI $32    [$C625]     ;/
$90:C5F3 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:C5F6 AA          TAX                    ;|
$90:C5F7 BD D9 C7    LDA $C7D9,x[$90:C7DA]  ;} $12 = [$C7D9 + [HUD item index]] (1 if arm cannon should be open)
$90:C5FA 29 FF 00    AND #$00FF             ;|
$90:C5FD 85 12       STA $12    [$7E:0012]  ;/
$90:C5FF AD A6 0A    LDA $0AA6  [$7E:0AA6]  ;\
$90:C602 29 FF 00    AND #$00FF             ;|
$90:C605 C5 12       CMP $12    [$7E:0012]  ;} If [arm cannon is open flag] = [$12]: return carry clear
$90:C607 F0 1C       BEQ $1C    [$C625]     ;/
$90:C609 A5 12       LDA $12    [$7E:0012]  ;\
$90:C60B F0 08       BEQ $08    [$C615]     ;} If [$12] != 0: (arm cannon should be open)
$90:C60D A9 00 00    LDA #$0000             ;\
$90:C610 8D A8 0A    STA $0AA8  [$7E:0AA8]  ;} Arm cannon frame = 0 (closed)
$90:C613 80 06       BRA $06    [$C61B]

$90:C615 A9 04 00    LDA #$0004             ;\ Else ([$12] = 0): (arm cannon should be closed)
$90:C618 8D A8 0A    STA $0AA8  [$7E:0AA8]  ;} Arm cannon frame = 4

$90:C61B A5 12       LDA $12    [$7E:0012]  ; Arm cannon is open flag = [$12]
$90:C61D 09 00 01    ORA #$0100             ; Flag arm cannon as opening/closing
$90:C620 8D A6 0A    STA $0AA6  [$7E:0AA6]
$90:C623 38          SEC                    ;\
$90:C624 60          RTS                    ;} Return carry set

$90:C625 18          CLC
$90:C626 60          RTS
}


;;; $C627: Advance arm cannon frame ;;;
{
$90:C627 08          PHP
$90:C628 C2 30       REP #$30
$90:C62A AD A6 0A    LDA $0AA6  [$7E:0AA6]  ;\
$90:C62D 29 FF 00    AND #$00FF             ;} If arm cannon is not open:
$90:C630 D0 0D       BNE $0D    [$C63F]     ;/
$90:C632 AD A8 0A    LDA $0AA8  [$7E:0AA8]  ;\
$90:C635 3A          DEC A                  ;|
$90:C636 F0 15       BEQ $15    [$C64D]     ;} If [arm cannon frame] <= 1: go to BRANCH_FULLY_CLOSED
$90:C638 30 13       BMI $13    [$C64D]     ;/
$90:C63A 8D A8 0A    STA $0AA8  [$7E:0AA8]  ; Decrement arm cannon frame
$90:C63D 80 22       BRA $22    [$C661]     ; Return

$90:C63F AD A8 0A    LDA $0AA8  [$7E:0AA8]  ;\
$90:C642 1A          INC A                  ;|
$90:C643 C9 03 00    CMP #$0003             ;} If [arm cannon frame] >= 2: go to BRANCH_FULLY_OPEN
$90:C646 10 0A       BPL $0A    [$C652]     ;/
$90:C648 8D A8 0A    STA $0AA8  [$7E:0AA8]  ; Increment arm cannon frame
$90:C64B 80 14       BRA $14    [$C661]     ; Return

; BRANCH_FULLY_CLOSED
$90:C64D 9C A8 0A    STZ $0AA8  [$7E:0AA8]  ; Arm cannon frame = 0
$90:C650 80 06       BRA $06    [$C658]     ; Go to BRANCH_FULLY_TRANSITIONED

; BRANCH_FULLY_OPEN
$90:C652 A9 03 00    LDA #$0003             ;\
$90:C655 8D A8 0A    STA $0AA8  [$7E:0AA8]  ;} Arm cannon frame = 3

; BRANCH_FULLY_TRANSITIONED
$90:C658 AD A6 0A    LDA $0AA6  [$7E:0AA6]  ;\
$90:C65B 29 FF 00    AND #$00FF             ;} Flag arm cannon as not opening/closing
$90:C65E 8D A6 0A    STA $0AA6  [$7E:0AA6]  ;/

$90:C661 28          PLP
$90:C662 60          RTS
}


;;; $C663: Draw arm cannon ;;;
{
; Does nothing if arm cannon is fully closed
$90:C663 08          PHP
$90:C664 C2 30       REP #$30
$90:C666 AD A8 0A    LDA $0AA8  [$7E:0AA8]  ;\
$90:C669 F0 0D       BEQ $0D    [$C678]     ;} If [arm cannon frame] = 0: return
$90:C66B AD A8 18    LDA $18A8  [$7E:18A8]  ;\
$90:C66E F0 0A       BEQ $0A    [$C67A]     ;} If [Samus invincibility timer] = 0: go to BRANCH_DRAW
$90:C670 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:C673 29 01 00    AND #$0001             ;} If [frame counter] % 2 = 0: go to BRANCH_DRAW
$90:C676 F0 02       BEQ $02    [$C67A]     ;/

$90:C678 28          PLP
$90:C679 60          RTS                    ; Return

; BRANCH_DRAW
$90:C67A AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:C67D 0A          ASL A                  ;|
$90:C67E AA          TAX                    ;} Y = [$C7DF + [Samus pose] * 2]
$90:C67F BD DF C7    LDA $C7DF,x[$90:C7E3]  ;|
$90:C682 A8          TAY                    ;/
$90:C683 B9 00 00    LDA $0000,y[$90:C9F1]  ;\
$90:C686 29 FF 00    AND #$00FF             ;|
$90:C689 89 80 00    BIT #$0080             ;} If [[Y]] & 80h = 0: go to BRANCH_SPRITE_POSITIVE
$90:C68C F0 27       BEQ $27    [$C6B5]     ;/
$90:C68E AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:C691 D0 11       BNE $11    [$C6A4]     ;} If [Samus animation frame] = 0:
$90:C693 B9 00 00    LDA $0000,y[$90:CAB5]  ;\
$90:C696 29 7F 00    AND #$007F             ;|
$90:C699 0A          ASL A                  ;} X = [[Y]] & 7Fh * 2 (direction)
$90:C69A AA          TAX                    ;/
$90:C69B 98          TYA                    ;\
$90:C69C 18          CLC                    ;|
$90:C69D 69 04 00    ADC #$0004             ;} $16 = [Y] + 4 (base address of arm cannon X/Y offsets)
$90:C6A0 85 16       STA $16    [$7E:0016]  ;/
$90:C6A2 80 18       BRA $18    [$C6BC]     ; Go to BRANCH_MERGE

$90:C6A4 B9 02 00    LDA $0002,y[$90:CA07]  ;\
$90:C6A7 29 7F 00    AND #$007F             ;|
$90:C6AA 0A          ASL A                  ;} X = [[Y] + 2] & 7Fh * 2 (direction)
$90:C6AB AA          TAX                    ;/
$90:C6AC 98          TYA                    ;\
$90:C6AD 18          CLC                    ;|
$90:C6AE 69 04 00    ADC #$0004             ;} $16 = [Y] + 4 (base address of arm cannon X/Y offsets)
$90:C6B1 85 16       STA $16    [$7E:0016]  ;/
$90:C6B3 80 07       BRA $07    [$C6BC]     ; Go to BRANCH_MERGE

; BRANCH_SPRITE_POSITIVE
$90:C6B5 0A          ASL A                  ;\
$90:C6B6 AA          TAX                    ;} X = [[Y]] * 2 (direction)
$90:C6B7 98          TYA                    ;\
$90:C6B8 1A          INC A                  ;|
$90:C6B9 1A          INC A                  ;} $16 = [Y] + 2 (base address of arm cannon X/Y offsets)
$90:C6BA 85 16       STA $16    [$7E:0016]  ;/

; BRANCH_MERGE
$90:C6BC BD 91 C7    LDA $C791,x[$90:C79F]  ;\
$90:C6BF 85 18       STA $18    [$7E:0018]  ;} $18 = [$C791 + [X]] (sprite tile number and attributes)
$90:C6C1 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:C6C4 0A          ASL A                  ;|
$90:C6C5 18          CLC                    ;} Y = [$16] + [Samus animation frame] * 2 (address of X/Y offsets)
$90:C6C6 65 16       ADC $16    [$7E:0016]  ;|
$90:C6C8 A8          TAY                    ;/
$90:C6C9 B9 00 00    LDA $0000,y[$90:C9F3]  ;\
$90:C6CC 29 FF 00    AND #$00FF             ;|
$90:C6CF 89 80 00    BIT #$0080             ;|
$90:C6D2 F0 03       BEQ $03    [$C6D7]     ;} $12 = ±[[Y]] (X offset)
$90:C6D4 09 00 FF    ORA #$FF00             ;|
                                            ;|
$90:C6D7 85 12       STA $12    [$7E:0012]  ;/
$90:C6D9 B9 01 00    LDA $0001,y[$90:C9F4]  ;\
$90:C6DC 29 FF 00    AND #$00FF             ;|
$90:C6DF 89 80 00    BIT #$0080             ;|
$90:C6E2 F0 03       BEQ $03    [$C6E7]     ;} $14 = ±[[Y] + 1] (Y offset)
$90:C6E4 09 00 FF    ORA #$FF00             ;|
                                            ;|
$90:C6E7 85 14       STA $14    [$7E:0014]  ;/
$90:C6E9 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:C6EC 0A          ASL A                  ;|
$90:C6ED 0A          ASL A                  ;|
$90:C6EE 0A          ASL A                  ;|
$90:C6EF AA          TAX                    ;} $16 = [$91:B62D + [Samus pose] * 8] (projectile origin Y offset)
$90:C6F0 BF 2D B6 91 LDA $91B62D,x[$91:B63D];|
$90:C6F4 29 FF 00    AND #$00FF             ;|
$90:C6F7 85 16       STA $16    [$7E:0016]  ;/
$90:C6F9 AE 90 05    LDX $0590  [$7E:0590]  ; X = [OAM stack pointer]
$90:C6FC AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:C6FF 18          CLC                    ;|
$90:C700 65 12       ADC $12    [$7E:0012]  ;|
$90:C702 38          SEC                    ;|
$90:C703 ED 11 09    SBC $0911  [$7E:0911]  ;} If 0 <= [Samus X position] + [$12] - [layer 1 X position] < 100h:
$90:C706 30 2B       BMI $2B    [$C733]     ;|
$90:C708 C9 00 01    CMP #$0100             ;|
$90:C70B 10 26       BPL $26    [$C733]     ;/
$90:C70D 9D 70 03    STA $0370,x[$7E:0370]  ; OAM entry X position = [Samus X position] + [$12] - [layer 1 X position]
$90:C710 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:C713 18          CLC                    ;|
$90:C714 65 14       ADC $14    [$7E:0014]  ;|
$90:C716 38          SEC                    ;|
$90:C717 E5 16       SBC $16    [$7E:0016]  ;} If 0 <= [Samus Y position] + [$14] - [$16] - [layer 1 Y position] < 100h:
$90:C719 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:C71C 30 15       BMI $15    [$C733]     ;|
$90:C71E C9 00 01    CMP #$0100             ;|
$90:C721 10 10       BPL $10    [$C733]     ;/
$90:C723 9D 71 03    STA $0371,x[$7E:0371]  ; OAM entry Y position = [Samus Y position] + [$14] - [$16] - [layer 1 Y position]
$90:C726 A5 18       LDA $18    [$7E:0018]  ;\
$90:C728 9D 72 03    STA $0372,x[$7E:0372]  ;} OAM entry tile number and attributes = [$18]
$90:C72B 8A          TXA                    ;\
$90:C72C 18          CLC                    ;|
$90:C72D 69 04 00    ADC #$0004             ;} OAM stack pointer += 4
$90:C730 8D 90 05    STA $0590  [$7E:0590]  ;/

$90:C733 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:C736 0A          ASL A                  ;|
$90:C737 AA          TAX                    ;} Y = [$C7DF + [Samus pose] * 2]
$90:C738 BD DF C7    LDA $C7DF,x[$90:C7E3]  ;|
$90:C73B A8          TAY                    ;/
$90:C73C B9 00 00    LDA $0000,y[$90:C9F1]  ;\
$90:C73F 29 FF 00    AND #$00FF             ;} A = [[Y]] (direction)
$90:C742 89 80 00    BIT #$0080             ;\
$90:C745 F0 15       BEQ $15    [$C75C]     ;} If [A] & 80h = 0: go to BRANCH_TILES_POSITIVE
$90:C747 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:C74A D0 08       BNE $08    [$C754]     ;} If [Samus animation frame] = 0:
$90:C74C B9 00 00    LDA $0000,y[$90:CAB5]  ;\
$90:C74F 29 7F 00    AND #$007F             ;} A = [[Y]] & 7Fh (direction)
$90:C752 80 08       BRA $08    [$C75C]

$90:C754 C8          INY                    ;\ Else ([Samus animation frame] != 0):
$90:C755 C8          INY                    ;|
$90:C756 B9 00 00    LDA $0000,y[$90:CA07]  ;} A = [[Y] + 2] & 7Fh (direction)
$90:C759 29 7F 00    AND #$007F             ;/

; BRANCH_TILES_POSITIVE
$90:C75C 0A          ASL A                  ;\
$90:C75D AA          TAX                    ;|
$90:C75E BD A5 C7    LDA $C7A5,x[$90:C7B3]  ;|
$90:C761 85 16       STA $16    [$7E:0016]  ;|
$90:C763 AD A8 0A    LDA $0AA8  [$7E:0AA8]  ;} Y = [$C7A5 + [A] * 2] + [arm cannon frame] * 2
$90:C766 0A          ASL A                  ;|
$90:C767 18          CLC                    ;|
$90:C768 65 16       ADC $16    [$7E:0016]  ;|
$90:C76A A8          TAY                    ;/
$90:C76B AE 30 03    LDX $0330  [$7E:0330]  ;\
$90:C76E A9 20 00    LDA #$0020             ;|
$90:C771 95 D0       STA $D0,x  [$7E:00DE]  ;|
$90:C773 E8          INX                    ;|
$90:C774 E8          INX                    ;|
$90:C775 B9 00 00    LDA $0000,y[$90:C7C3]  ;|
$90:C778 95 D0       STA $D0,x  [$7E:00E0]  ;|
$90:C77A E8          INX                    ;|
$90:C77B E8          INX                    ;|
$90:C77C E2 20       SEP #$20               ;} Queue transfer of 20h bytes from $9A:0000 + [Y] to VRAM $61F0
$90:C77E A9 9A       LDA #$9A               ;|
$90:C780 95 D0       STA $D0,x  [$7E:00E2]  ;|
$90:C782 C2 20       REP #$20               ;|
$90:C784 E8          INX                    ;|
$90:C785 A9 F0 61    LDA #$61F0             ;|
$90:C788 95 D0       STA $D0,x  [$7E:00E3]  ;|
$90:C78A E8          INX                    ;|
$90:C78B E8          INX                    ;|
$90:C78C 8E 30 03    STX $0330  [$7E:0330]  ;/
$90:C78F 28          PLP
$90:C790 60          RTS

;                        ________________________________________________ 0: Up, facing right
;                       |     ___________________________________________ 1: Up-right
;                       |    |     ______________________________________ 2: Right
;                       |    |    |     _________________________________ 3: Down-right
;                       |    |    |    |     ____________________________ 4: Down, facing right
;                       |    |    |    |    |     _______________________ 5: Down, facing left
;                       |    |    |    |    |    |     __________________ 6: Down-left
;                       |    |    |    |    |    |    |     _____________ 7: Left
;                       |    |    |    |    |    |    |    |     ________ 8: Up-left
;                       |    |    |    |    |    |    |    |    |     ___ 9: Up, facing left
;                       |    |    |    |    |    |    |    |    |    |
$90:C791             dw 281F,281F,281F,681F,A81F,E81F,281F,681F,681F,681F ; Sprite tile number and attributes
$90:C7A5             dw C7B9,C7D1,C7C1,C7C9,C7B9,C7B9,C7C9,C7C1,C7D1,C7B9 ; Pointers to below table

; Pointers to tiles in bank $9A, indexed by arm cannon frame
$90:C7B9             dw 0000,9A00,9C00,9E00
$90:C7C1             dw 0000,A000,A200,A400
$90:C7C9             dw 0000,A600,A800,AA00
$90:C7D1             dw 0000,AC00,AE00,B000
}


;;; $C7D9: Arm cannon open flags ;;;
{
; Indexed by HUD item index. 1 for open arm cannon
$90:C7D9             db 00, 01, 01, 00, 01, 00
}


;;; $C7DF: Arm cannon drawing data ;;;
{
$90:C7DF             dw C9DB, C9DD, C9F1, CA05, CA0D, CA15, CA19, CA1D, CA21, C9D9, C9D9, CA25, CA3B, C9D9, C9D9, CA51,
                        CA67, CA7D, CA93, CAA9, CAAF, CAB5, CABD, CAC5, CACB, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, CB5D, CB71, C9D9, C9D9, CB1D, CB27, CB31, CB37, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9DD, C9F1, CBA5, CBB3, CAD1, C9D9, C9D9, C9D9, C9D9,
                        C9D9, CAD9, CADF, C9D9, C9D9, CC15, CC1B, CA15, CA19, CA1D, CA21, C9D9, C9D9, C9D9, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, CAFD, CB0D, CAE5, CAEB, CAF1, CAF7, CB3D, CB45, CB4D,
                        CB55, CB85, CB89, CB8D, CB91, CBC1, CBCF, CBDD, CBEB, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, CB95, CB9D, C9D9, C9D9, C9DD, C9F1, C9D9, C9D9, C9D9, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9DB, C9D9, C9D9, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, CBF9, C9D9, CC05, C9D9, C9DD, C9F1, CA1D, CA21, CAA9, CAAF, CAC5, CACB,
                        CAF1, CAF7, C9D9, C9D9, CB5D, CB71, CB8D, CB91, C9D9, C9D9, C9D9, CA19, C9F1, CA21, C9D9, C9D9,
                        C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, CA15,
                        CA19, CA1D, CA21, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9, C9D9,
                        CC15, CC1B, CA15, CA19, CA1D, CA21, C9DD, C9F1, C9D9, C9D9, C9D9, C9D9, C9D9, CA15, C9DD, CA1D,
                        C9D9, CC15, CC1B, CA15, CA19, CA1D, CA21, CC15, CC1B, CA15, CA19, CA1D, CA21

; Format:
;     dd aa
;     [DD aa] ; If d & 80h != 0
;     [xx yy]...
;
; where
;     d: Direction
;     D: Direction if [Samus animation frame] != 0
;     {
;         0: Up, facing right
;         1: Up-right
;         2: Right
;         3: Down-right
;         4: Down, facing right
;         5: Down, facing left
;         6: Down-left
;         7: Left
;         8: Up-left
;         9: Up, facing left
;     }
;     a: Arm cannon drawing mode
;     {
;         0: Arm cannon isn't drawn
;         1: Arm cannon is drawn normally
;         2: Samus is facing forward (same as 0?)
;     }
;     x/y: X/Y offsets, indexed by [Samus animation frame]

; All other poses
$90:C9D9             db 00, 00

; 0: Facing forward - power suit
; 9Bh: Facing forward - varia/gravity suit
$90:C9DB             db 00, 02

; 1: Facing right - normal
; 47h: Unused
; 89h: Facing right - ran into a wall
; A8h: Unused
; E6h: Facing right - landing from normal jump - firing
; EEh: Facing right - grabbed by Draygon - firing
$90:C9DD             db 02, 01, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD

; 2: Facing left  - normal
; 48h: Unused
; 8Ah: Facing left  - ran into a wall
; A9h: Unused
; BCh: Facing left  - grabbed by Draygon - firing
; E7h: Facing left  - landing from normal jump - firing
$90:C9F1             db 07, 01, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD

; 3: Facing right - aiming up
$90:CA05             db 81, 01, 80, 01, 0E,EA, FE,E1

; 4: Facing left  - aiming up
$90:CA0D             db 88, 01, 89, 01, EA,E9, FA,E1

; 5: Facing right - aiming up-right
; 57h: Facing right - normal jump transition - aiming up-right
; CFh: Facing right - ran into a wall - aiming up-right
; E2h: Facing right - landing from normal jump - aiming up-right
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
; F3h: Facing right - crouching transition - aiming up-right
; F9h: Facing right - standing transition - aiming up-right
$90:CA15             db 01, 01, 0D,EA

; 6: Facing left  - aiming up-left
; 58h: Facing left  - normal jump transition - aiming up-left
; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left
; D0h: Facing left  - ran into a wall - aiming up-left
; E3h: Facing left  - landing from normal jump - aiming up-left
; F4h: Facing left  - crouching transition - aiming up-left
; FAh: Facing left  - standing transition - aiming up-left
$90:CA19             db 08, 01, EB,E9

; 7: Facing right - aiming down-right
; 59h: Facing right - normal jump transition - aiming down-right
; AAh: Unused
; D1h: Facing right - ran into a wall - aiming down-right
; E4h: Facing right - landing from normal jump - aiming down-right
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
; F5h: Facing right - crouching transition - aiming down-right
; FBh: Facing right - standing transition - aiming down-right
$90:CA1D             db 03, 01, 0D,02

; 8: Facing left  - aiming down-left
; 5Ah: Facing left  - normal jump transition - aiming down-left
; ABh: Unused
; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left
; D2h: Facing left  - ran into a wall - aiming down-left
; E5h: Facing left  - landing from normal jump - aiming down-left
; F6h: Facing left  - crouching transition - aiming down-left
; FCh: Facing left  - standing transition - aiming down-left
$90:CA21             db 06, 01, EB,02

; Bh: Moving right - gun extended
$90:CA25             db 02, 01, 11,FA, 11,FA, 11,F9, 11,F8, 11,F9, 11,FA, 11,F9, 11,F9, 11,F8, 11,F9

; Ch: Moving left  - gun extended
$90:CA3B             db 07, 01, E7,FA, E7,FA, E7,F8, E7,F9, E7,F9, E7,FA, E7,F9, E7,F8, E7,F9, E7,F9

; Fh: Moving right - aiming up-right
$90:CA51             db 01, 01, 0C,EA, 0C,EA, 0C,E9, 0C,E8, 0C,E9, 0C,EA, 0C,EA, 0C,E9, 0C,E8, 0C,E9

; 10h: Moving left  - aiming up-left
$90:CA67             db 08, 01, EC,EA, EC,EA, EC,E9, EC,E8, EC,E9, EC,EA, EC,EA, EC,E9, EC,E8, EC,E9

; 11h: Moving right - aiming down-right
$90:CA7D             db 03, 01, 0B,01, 0B,01, 0B,00, 0B,FF, 0B,00, 0B,01, 0B,01, 0B,00, 0B,FF, 0B,00

; 12h: Moving left  - aiming down-left
$90:CA93             db 06, 01, ED,01, ED,01, ED,00, ED,FF, ED,00, ED,01, ED,01, ED,00, ED,FF, ED,00

; 13h: Facing right - normal jump - not aiming - not moving - gun extended
; ACh: Unused
$90:CAA9             db 02, 01, 0B,FD, 0B,FD

; 14h: Facing left  - normal jump - not aiming - not moving - gun extended
; ADh: Unused
$90:CAAF             db 07, 01, ED,FD, ED,FD

; 15h: Facing right - normal jump - aiming up
$90:CAB5             db 81, 01, 80, 01, 0E,E9, FE,E0

; 16h: Facing left  - normal jump - aiming up
$90:CABD             db 88, 01, 89, 01, EA,E8, FA,E0

; 17h: Facing right - normal jump - aiming down
; AEh: Unused
$90:CAC5             db 04, 01, 00,0D, 00,0D

; 18h: Facing left  - normal jump - aiming down
; AFh: Unused
$90:CACB             db 05, 01, F7,0D, F7,0D

; 4Bh: Facing right - normal jump transition
$90:CAD1             db 03, 01, FB,00, 06,02, ED,FE

; 51h: Facing right - normal jump - not aiming - moving forward
$90:CAD9             db 02, 01, 0B,FD, 0B,FD

; 52h: Facing left  - normal jump - not aiming - moving forward
$90:CADF             db 07, 01, ED,FD, ED,FD

; 69h: Facing right - normal jump - aiming up-right
$90:CAE5             db 01, 01, 0C,EA, 0C,EA

; 6Ah: Facing left  - normal jump - aiming up-left
$90:CAEB             db 08, 01, EC,EA, EC,EA

; 6Bh: Facing right - normal jump - aiming down-right
; B0h: Unused
$90:CAF1             db 03, 01, 0B,01, 0B,01

; 6Ch: Facing left  - normal jump - aiming down-left
; B1h: Unused
$90:CAF7             db 06, 01, ED,01, ED,01

; 67h: Facing right - falling - gun extended
$90:CAFD             db 02, 01, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD

; 68h: Facing left  - falling - gun extended
$90:CB0D             db 07, 01, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD

; 2Bh: Facing right - falling - aiming up
$90:CB1D             db 81, 01, 80, 01, 0E,E9, FE,E0, FE,E0

; 2Ch: Facing left  - falling - aiming up
$90:CB27             db 88, 01, 89, 01, EA,E8, FA,E4, FA,E4

; 2Dh: Facing right - falling - aiming down
$90:CB31             db 04, 01, 00,09, 00,09

; 2Eh: Facing left  - falling - aiming down
$90:CB37             db 05, 01, F7,09, F7,09

; 6Dh: Facing right - falling - aiming up-right
$90:CB3D             db 01, 01, 0C,EA, 0C,EA, 0C,EA

; 6Eh: Facing left  - falling - aiming up-left
$90:CB45             db 08, 01, EC,EA, EC,EA, EC,EA

; 6Fh: Facing right - falling - aiming down-right
$90:CB4D             db 03, 01, 0B,01, 0B,01, 0B,01

; 70h: Facing left  - falling - aiming down-left
$90:CB55             db 06, 01, ED,01, ED,01, ED,01

; 27h: Facing right - crouching
; B4h: Unused
$90:CB5D             db 02, 01, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD, 0B,FD

; 28h: Facing left  - crouching
; B5h: Unused
$90:CB71             db 07, 01, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD, ED,FD

; 71h: Facing right - crouching - aiming up-right
$90:CB85             db 01, 01, 0E,E9

; 72h: Facing left  - crouching - aiming up-left
$90:CB89             db 08, 01, EA,E8

; 73h: Facing right - crouching - aiming down-right
; B6h: Unused
$90:CB8D             db 03, 01, 0D,02

; 74h: Facing left  - crouching - aiming down-left
; B7h: Unused
$90:CB91             db 06, 01, EB,02

; 85h: Facing right - crouching - aiming up
$90:CB95             db 81, 01, 80, 01, 0E,E9, FE,E0

; 86h: Facing left  - crouching - aiming up
$90:CB9D             db 88, 01, 89, 01, EA,E8, FA,E0

; 49h: Facing left  - moonwalk
$90:CBA5             db 02, 01, F1,FD, F1,FC, F1,FC, F1,FD, F1,FC, F1,FC

; 4Ah: Facing right - moonwalk
$90:CBB3             db 07, 01, 07,FD, 07,FC, 07,FC, 07,FD, 07,FC, 07,FC

; 75h: Facing left  - moonwalk - aiming up-left
$90:CBC1             db 08, 01, EC,EA, EC,E9, EC,E9, EC,EA, EC,E9, EC,E9

; 76h: Facing right - moonwalk - aiming up-right
$90:CBCF             db 01, 01, 0C,EA, 0C,E9, 0C,E9, 0C,EA, 0C,E9, 0C,E9

; 77h: Facing left  - moonwalk - aiming down-left
$90:CBDD             db 06, 01, ED,01, ED,00, ED,00, ED,01, ED,00, ED,00

; 78h: Facing right - moonwalk - aiming down-right
$90:CBEB             db 03, 01, 0B,01, 0B,00, 0B,00, 0B,01, 0B,00, 0B,00

; A4h: Facing right - landing from normal jump
$90:CBF9             db 03, 01, FB,00, FB,00, 06,02, ED,FE, ED,FE

; A6h: Facing right - landing from spin jump
$90:CC05             db 03, 01, FB,00, FB,00, FB,00, 06,02, ED,FE, ED,FE, ED,FE

; 55h: Facing right - normal jump transition - aiming up
; E0h: Facing right - landing from normal jump - aiming up
; F1h: Facing right - crouching transition - aiming up
; F7h: Facing right - standing transition - aiming up
$90:CC15             db 00, 01, FE,E1, FE,E1

; 56h: Facing left  - normal jump transition - aiming up
; E1h: Facing left  - landing from normal jump - aiming up
; F2h: Facing left  - crouching transition - aiming up
; F8h: Facing left  - standing transition - aiming up
$90:CC1B             db 09, 01, FA,E1, FA,E1
}


;;; $CC21: Cost of SBAs in power bombs ;;;
{
; Obviously only the pure beams have non-zero values, and obviously they're all 1
; This table sucks
$90:CC21             dw 0000, ; 0: Power
                        0001, ; 1: Wave
                        0001, ; 2: Ice
                        0000, ; 3: Ice + wave
                        0001, ; 4: Spazer
                        0000, ; 5: Spazer + wave
                        0000, ; 6: Spazer + ice
                        0000, ; 7: Spazer + ice + wave
                        0001, ; 8: Plasma
                        0000, ; 9: Plasma + wave
                        0000, ; Ah: Plasma + ice
                        0000  ; Bh: Plasma + ice + wave
}


;;; $CC39: Calculate X/Y components of radius [A], angle [Y] ;;;
{
;; Parameters:
;;     A: Radius
;;     Y: Angle. Origin = up, positive direction = clockwise
;; Returns:
;;     $14: X component of radius
;;     $16: Y component of radius

; Clone of $86:9BA2
$90:CC39 08          PHP
$90:CC3A C2 30       REP #$30
$90:CC3C DA          PHX
$90:CC3D 85 18       STA $18    [$7E:0018]  ; $18 = [A]
$90:CC3F 98          TYA                    ;\
$90:CC40 85 1A       STA $1A    [$7E:001A]  ;} $1A = [Y]
$90:CC42 C9 80 00    CMP #$0080             ;\
$90:CC45 10 07       BPL $07    [$CC4E]     ;} If [$1A] < 80h:
$90:CC47 0A          ASL A                  ;\
$90:CC48 AA          TAX                    ;} $14 = [$18] * sin([$1A] * pi / 80h)
$90:CC49 20 8A CC    JSR $CC8A  [$90:CC8A]  ;/
$90:CC4C 80 10       BRA $10    [$CC5E]

$90:CC4E 38          SEC                    ;\ Else ([$1A] >= 80h):
$90:CC4F E9 80 00    SBC #$0080             ;\
$90:CC52 29 FF 00    AND #$00FF             ;|
$90:CC55 0A          ASL A                  ;|
$90:CC56 AA          TAX                    ;} $14 = -[$18] * sin(([$1A] - 80h) * pi / 80h)
$90:CC57 20 8A CC    JSR $CC8A  [$90:CC8A]  ;|
$90:CC5A 49 FF FF    EOR #$FFFF             ;|
$90:CC5D 1A          INC A                  ;/

$90:CC5E 85 14       STA $14    [$7E:0014]
$90:CC60 A5 1A       LDA $1A    [$7E:001A]  ;\
$90:CC62 38          SEC                    ;|
$90:CC63 E9 40 00    SBC #$0040             ;} A = ([$1A] - 40h) % 100h
$90:CC66 29 FF 00    AND #$00FF             ;/
$90:CC69 C9 80 00    CMP #$0080             ;\
$90:CC6C 10 07       BPL $07    [$CC75]     ;} If [A] < 80h:
$90:CC6E 0A          ASL A                  ;\
$90:CC6F AA          TAX                    ;} $16 = [$18] * sin([A] * pi / 80h)
$90:CC70 20 8A CC    JSR $CC8A  [$90:CC8A]  ;/
$90:CC73 80 10       BRA $10    [$CC85]

$90:CC75 38          SEC                    ;\ Else ([A] >= 80h):
$90:CC76 E9 80 00    SBC #$0080             ;\
$90:CC79 29 FF 00    AND #$00FF             ;|
$90:CC7C 0A          ASL A                  ;|
$90:CC7D AA          TAX                    ;} $16 = -[$18] * sin(([A] - 80h) * pi / 80h)
$90:CC7E 20 8A CC    JSR $CC8A  [$90:CC8A]  ;|
$90:CC81 49 FF FF    EOR #$FFFF             ;|
$90:CC84 1A          INC A                  ;/

$90:CC85 85 16       STA $16    [$7E:0016]
$90:CC87 FA          PLX
$90:CC88 28          PLP
$90:CC89 60          RTS
}


;;; $CC8A: A = [$18] * sin([X] / 2 * pi / 80h) ;;;
{
;; Parameters:
;;     X: Angle * 2
;;     $18: Radius
;; Returns:
;;     A: Sine component

; Clone of $8B:8EA3
; Angle [X] / 2 must be less than 80h, as this routine does unsigned multiplication
$90:CC8A E2 20       SEP #$20
$90:CC8C BF 43 B4 A0 LDA $A0B443,x[$A0:B503]
$90:CC90 8D 02 42    STA $4202
$90:CC93 A5 18       LDA $18    [$7E:0018]
$90:CC95 8D 03 42    STA $4203
$90:CC98 EA          NOP
$90:CC99 EA          NOP
$90:CC9A EA          NOP
$90:CC9B C2 20       REP #$20
$90:CC9D AD 16 42    LDA $4216
$90:CCA0 EB          XBA
$90:CCA1 29 FF 00    AND #$00FF
$90:CCA4 85 12       STA $12    [$7E:0012]
$90:CCA6 E2 20       SEP #$20
$90:CCA8 BF 44 B4 A0 LDA $A0B444,x[$A0:B504]
$90:CCAC 8D 02 42    STA $4202
$90:CCAF A5 18       LDA $18    [$7E:0018]
$90:CCB1 8D 03 42    STA $4203
$90:CCB4 EA          NOP
$90:CCB5 EA          NOP
$90:CCB6 EA          NOP
$90:CCB7 C2 20       REP #$20
$90:CCB9 AD 16 42    LDA $4216
$90:CCBC 18          CLC
$90:CCBD 65 12       ADC $12    [$7E:0012]
$90:CCBF 60          RTS
}


;;; $CCC0: Fire SBA ;;;
{
;; Returns:
;;     Carry: Set if succeeded
$90:CCC0 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:CCC3 C9 03 00    CMP #$0003             ;} If [HUD item index] != power bombs:
$90:CCC6 F0 02       BEQ $02    [$CCCA]     ;/
$90:CCC8 18          CLC                    ;\
$90:CCC9 60          RTS                    ;} Return clear carry

$90:CCCA AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:CCCD 29 0F 00    AND #$000F             ;|
$90:CCD0 0A          ASL A                  ;} X = ([equipped beams] & Fh) * 2
$90:CCD1 AA          TAX                    ;/
$90:CCD2 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$90:CCD5 38          SEC                    ;|
$90:CCD6 FD 21 CC    SBC $CC21,x[$90:CC31]  ;|
$90:CCD9 10 03       BPL $03    [$CCDE]     ;} Samus power bombs = max(0, [Samus power bombs] - [$CC21 + [X]]
$90:CCDB A9 00 00    LDA #$0000             ;|
                                            ;|
$90:CCDE 8D CE 09    STA $09CE  [$7E:09CE]  ;/
$90:CCE1 FC F0 CC    JSR ($CCF0,x)[$90:CE98]; Execute [$CCF0 + [X]]
$90:CCE4 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$90:CCE7 D0 06       BNE $06    [$CCEF]     ;} If [Samus power bombs] = 0:
$90:CCE9 9C D2 09    STZ $09D2  [$7E:09D2]  ; HUD item index = nothing
$90:CCEC 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Auto-cancel HUD item index = nothing

$90:CCEF 60          RTS

$90:CCF0             dw CD18, ; 0: Power
                        CD1A, ; 1: Wave
                        CD9B, ; 2: Ice
                        CD18, ; 3: Ice + wave
                        CE14, ; 4: Spazer
                        CD18, ; 5: Spazer + wave
                        CD18, ; 6: Spazer + ice
                        CD18, ; 7: Spazer + ice + wave
                        CE98, ; 8: Plasma
                        CD18, ; 9: Plasma + wave
                        CD18, ; Ah: Plasma + ice
                        CD18  ; Bh: Plasma + ice + wave
}


;;; $CD08: Ice/plasma SBA projectile origin angles ;;;
{
; Angle of projectiles from Samus (2pi / 100h radians clockwise, 0 = up) for ice/plasma SBA
$90:CD08             dw 0000,
                        0040,
                        0080,
                        00C0,
                        0020, ; Unused
                        0060, ; Unused
                        00A0, ; Unused
                        00E0  ; Unused
}


;;; $CD18: Clear carry. Disabled SBA beam combinations ;;;
{
$90:CD18 18          CLC
$90:CD19 60          RTS
}


;;; $CD1A: Fire wave SBA ;;;
{
;; Returns:
;;     Carry: Set. Fire SBA succeeded
$90:CD1A A2 06 00    LDX #$0006             ; X = 6 (projectile index)

; LOOP
$90:CD1D A9 04 00    LDA #$0004             ;\
$90:CD20 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:CD23 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:CD26 29 0F 10    AND #$100F             ;|
$90:CD29 09 10 80    ORA #$8010             ;} Projectile type = charged beam
$90:CD2C 9D 18 0C    STA $0C18,x            ;/
$90:CD2F 9E 04 0C    STZ $0C04,x            ; Projectile direction = 0
$90:CD32 A9 08 DA    LDA #$DA08             ;\
$90:CD35 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $DA08 (wave SBA)
$90:CD38 A9 58 02    LDA #$0258             ;\
$90:CD3B 9D F0 0B    STA $0BF0,x            ;} Projectile SBA timer = 600
$90:CD3E 9E DC 0B    STZ $0BDC,x            ; Projectile X velocity = 0
$90:CD41 9E 7C 0C    STZ $0C7C,x            ; Projectile Y velocity = 0
$90:CD44 9E 8C 0B    STZ $0B8C,x            ; Projectile X subposition = 0
$90:CD47 9E A0 0B    STZ $0BA0,x            ; Projectile Y subposition = 0
$90:CD4A AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:CD4D 18          CLC                    ;|
$90:CD4E 7D 8B CD    ADC $CD8B,x            ;} Projectile X position = [Samus X position] + [$CD8B + [X]]
$90:CD51 9D 64 0B    STA $0B64,x            ;/
$90:CD54 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:CD57 18          CLC                    ;|
$90:CD58 7D 93 CD    ADC $CD93,x            ;} Projectile Y position = [Samus Y position] + [$CD93 + [X]]
$90:CD5B 9D 78 0B    STA $0B78,x            ;/
$90:CD5E 22 A4 81 93 JSL $9381A4[$93:81A4]  ; Initialise SBA projectile
$90:CD62 CA          DEX                    ;\
$90:CD63 CA          DEX                    ;} X -= 2
$90:CD64 10 B7       BPL $B7    [$CD1D]     ; If [X] >= 0: go to LOOP
$90:CD66 A9 04 00    LDA #$0004             ;\
$90:CD69 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;} Projectile counter = 4
$90:CD6C AD 18 0C    LDA $0C18  [$7E:0C18]  ;\
$90:CD6F 29 3F 00    AND #$003F             ;|
$90:CD72 A8          TAY                    ;|
$90:CD73 B9 54 C2    LDA $C254,y            ;} Cooldown timer = [$C254 + ([projectile type] & 3Fh)]
$90:CD76 29 FF 00    AND #$00FF             ;|
$90:CD79 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:CD7C A9 04 00    LDA #$0004             ;\
$90:CD7F 8D 60 0B    STA $0B60  [$7E:0B60]  ;} SBA angle delta = 4 (unused)
$90:CD82 A9 28 00    LDA #$0028             ;\
$90:CD85 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 28h, sound library 1, max queued sounds allowed = 6 (wave SBA)
$90:CD89 38          SEC                    ;\
$90:CD8A 60          RTS                    ;} Return carry set

; X offsets from Samus
$90:CD8B             dw 0080,
                        0080,
                        FF80,
                        FF80

; Y offsets from Samus
$90:CD93             dw 0080,
                        FF80,
                        FF80,
                        0080
}


;;; $CD9B: Fire ice SBA ;;;
{
;; Returns:
;;     Carry: Set if succeeded
$90:CD9B AD 68 0C    LDA $0C68  [$7E:0C68]  ;\
$90:CD9E C9 7A CF    CMP #$CF7A             ;} If [projectile pre-instruction] = $CF7A (ice SBA - end): return carry clear
$90:CDA1 F0 05       BEQ $05    [$CDA8]     ;/
$90:CDA3 C9 09 CF    CMP #$CF09             ;\
$90:CDA6 D0 02       BNE $02    [$CDAA]     ;} If [projectile pre-instruction] != $CF09 (ice SBA - main): go to BRANCH_FIRE

$90:CDA8 18          CLC                    ;\
$90:CDA9 60          RTS                    ;} Return carry clear

; BRANCH_FIRE
$90:CDAA A2 06 00    LDX #$0006             ; X = 6 (projectile index)

; LOOP
$90:CDAD A9 04 00    LDA #$0004             ;\
$90:CDB0 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:CDB3 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:CDB6 29 0F 10    AND #$100F             ;|
$90:CDB9 09 10 80    ORA #$8010             ;} Projectile type = charged beam
$90:CDBC 9D 18 0C    STA $0C18,x            ;/
$90:CDBF 9E 04 0C    STZ $0C04,x            ; Projectile direction = 0
$90:CDC2 A9 09 CF    LDA #$CF09             ;\
$90:CDC5 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $CF09 (ice SBA)
$90:CDC8 BD 08 CD    LDA $CD08,x            ;\
$90:CDCB 9D 7C 0C    STA $0C7C,x            ;} Projectile angle = [$CD08 + [X]]
$90:CDCE A9 58 02    LDA #$0258             ;\
$90:CDD1 9D F0 0B    STA $0BF0,x            ;} Projectile SBA timer = 600
$90:CDD4 22 00 80 93 JSL $938000[$93:8000]  ; Initialise projectile
$90:CDD8 CA          DEX                    ;\
$90:CDD9 CA          DEX                    ;} X -= 2
$90:CDDA 10 D1       BPL $D1    [$CDAD]     ; If [X] >= 0: go to LOOP
$90:CDDC A9 04 00    LDA #$0004             ;\
$90:CDDF 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;} Projectile counter = 4
$90:CDE2 AD 18 0C    LDA $0C18  [$7E:0C18]  ;\
$90:CDE5 29 3F 00    AND #$003F             ;|
$90:CDE8 A8          TAY                    ;|
$90:CDE9 B9 54 C2    LDA $C254,y            ;} Cooldown timer = [$C254 + ([projectile type] & 3Fh)]
$90:CDEC 29 FF 00    AND #$00FF             ;|
$90:CDEF 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:CDF2 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:CDF5 29 FF 00    AND #$00FF             ;|
$90:CDF8 C9 04 00    CMP #$0004             ;} If facing right:
$90:CDFB F0 08       BEQ $08    [$CE05]     ;/
$90:CDFD A9 04 00    LDA #$0004             ;\
$90:CE00 8D 60 0B    STA $0B60  [$7E:0B60]  ;} SBA angle delta = 4
$90:CE03 80 06       BRA $06    [$CE0B]

$90:CE05 A9 FC FF    LDA #$FFFC             ;\ Else (facing left):
$90:CE08 8D 60 0B    STA $0B60  [$7E:0B60]  ;} SBA angle delta = -4

$90:CE0B A9 23 00    LDA #$0023             ;\
$90:CE0E 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 23h, sound library 1, max queued sounds allowed = 6 (ice SBA)
$90:CE12 38          SEC                    ;\
$90:CE13 60          RTS                    ;} Return carry set
}


;;; $CE14: Fire spazer SBA ;;;
{
;; Returns:
;;     Carry: Set. Fire SBA succeeded
$90:CE14 A2 06 00    LDX #$0006             ; X = 6 (projectile index)

; LOOP
$90:CE17 BD 88 CE    LDA $CE88,x            ;\
$90:CE1A 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = [$CE88 + [X]]
$90:CE1D A9 05 00    LDA #$0005             ;\
$90:CE20 9D 04 0C    STA $0C04,x            ;} Projectile direction = 5 (down, facing left)
$90:CE23 A9 06 DB    LDA #$DB06             ;\
$90:CE26 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $DB06 (spazer SBA)
$90:CE29 A9 28 00    LDA #$0028             ;\
$90:CE2C 9D DC 0B    STA $0BDC,x            ;} Projectile distance = 28h
$90:CE2F BD 90 CE    LDA $CE90,x            ;\
$90:CE32 9D F0 0B    STA $0BF0,x            ;} Projectile angle delta = [$CE90 + [X]]
$90:CE35 9E 7C 0C    STZ $0C7C,x            ; Projectile angle = 0
$90:CE38 9E A4 0C    STZ $0CA4,x            ; Projectile phase = 0
$90:CE3B 9E 8C 0B    STZ $0B8C,x            ; Projectile X subposition = 0
$90:CE3E 9E A0 0B    STZ $0BA0,x            ; Projectile Y subposition = 0
$90:CE41 E0 04 00    CPX #$0004             ;\
$90:CE44 10 12       BPL $12    [$CE58]     ;} If [X] < 4:
$90:CE46 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:CE49 29 0F 10    AND #$100F             ;|
$90:CE4C 09 10 80    ORA #$8010             ;} Projectile type = charged beam
$90:CE4F 9D 18 0C    STA $0C18,x            ;/
$90:CE52 22 A4 81 93 JSL $9381A4[$93:81A4]  ; Initialise SBA projectile
$90:CE56 80 0A       BRA $0A    [$CE62]

$90:CE58 A9 24 80    LDA #$8024             ;\ Else ([X] >= 4):
$90:CE5B 9D 18 0C    STA $0C18,x            ;} Projectile type = 8024h
$90:CE5E 22 63 81 93 JSL $938163[$93:8163]  ; Initialise spazer SBA trail projectile

$90:CE62 CA          DEX                    ;\
$90:CE63 CA          DEX                    ;} X -= 2
$90:CE64 10 B1       BPL $B1    [$CE17]     ; If [X] >= 0: go to LOOP
$90:CE66 A9 04 00    LDA #$0004             ;\
$90:CE69 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;} Projectile counter = 4
$90:CE6C AD 18 0C    LDA $0C18  [$7E:0C18]  ;\
$90:CE6F 29 3F 00    AND #$003F             ;|
$90:CE72 A8          TAY                    ;|
$90:CE73 B9 54 C2    LDA $C254,y            ;} Cooldown timer = [$C254 + ([projectile type] & 3Fh)]
$90:CE76 29 FF 00    AND #$00FF             ;|
$90:CE79 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:CE7C 9C 60 0B    STZ $0B60  [$7E:0B60]  ; SBA angle delta = 0 (unused)
$90:CE7F A9 25 00    LDA #$0025             ;\
$90:CE82 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 25h, sound library 1, max queued sounds allowed = 6 (spazer SBA)
$90:CE86 38          SEC                    ;\
$90:CE87 60          RTS                    ;} Return carry set

; Initial trail timers
$90:CE88             dw 0000,
                        0000,
                        0004,
                        0004

; Angle deltas
$90:CE90             dw 0004,
                        FFFC,
                        0004,
                        FFFC
}


;;; $CE98: Fire plasma SBA ;;;
{
;; Returns:
;;     Carry: Set if succeeded
$90:CE98 AD 68 0C    LDA $0C68  [$7E:0C68]  ;\
$90:CE9B C9 93 D7    CMP #$D793             ;} If [projectile pre-instruction] = $D793:
$90:CE9E D0 02       BNE $02    [$CEA2]     ;/
$90:CEA0 18          CLC                    ;\
$90:CEA1 60          RTS                    ;} Return carry clear

$90:CEA2 A2 06 00    LDX #$0006             ; X = 6 (projectile index)

; LOOP
$90:CEA5 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:CEA8 29 0F 10    AND #$100F             ;|
$90:CEAB 09 10 80    ORA #$8010             ;} Projectile type = charged beam
$90:CEAE 9D 18 0C    STA $0C18,x[$7E:0C1E]  ;/
$90:CEB1 9E 04 0C    STZ $0C04,x[$7E:0C0A]  ; Projectile direction = 0
$90:CEB4 A9 93 D7    LDA #$D793             ;\
$90:CEB7 9D 68 0C    STA $0C68,x[$7E:0C6E]  ;} Projectile pre-instruction = $D793 (plasma SBA)
$90:CEBA BD 08 CD    LDA $CD08,x[$90:CD0E]  ;\
$90:CEBD 9D 7C 0C    STA $0C7C,x[$7E:0C82]  ;} Projectile angle = [$CD08 + [X]]
$90:CEC0 A9 28 00    LDA #$0028             ;\
$90:CEC3 9D DC 0B    STA $0BDC,x[$7E:0BE2]  ;} Projectile distance = 28h
$90:CEC6 9E F0 0B    STZ $0BF0,x[$7E:0BF6]  ; Projectile phase = 0
$90:CEC9 22 A4 81 93 JSL $9381A4[$93:81A4]  ; Initialise projectile
$90:CECD CA          DEX                    ;\
$90:CECE CA          DEX                    ;} X -= 2
$90:CECF 10 D4       BPL $D4    [$CEA5]     ; If [X] >= 0: go to LOOP
$90:CED1 A9 04 00    LDA #$0004             ;\
$90:CED4 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;} Projectile counter = 4
$90:CED7 AD 18 0C    LDA $0C18  [$7E:0C18]  ;\
$90:CEDA 29 3F 00    AND #$003F             ;|
$90:CEDD A8          TAY                    ;|
$90:CEDE B9 54 C2    LDA $C254,y[$90:C26C]  ;} Cooldown timer = [$C254 + ([projectile type] & 3Fh)]
$90:CEE1 29 FF 00    AND #$00FF             ;|
$90:CEE4 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:CEE7 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:CEEA 29 FF 00    AND #$00FF             ;|
$90:CEED C9 04 00    CMP #$0004             ;} If facing right:
$90:CEF0 F0 08       BEQ $08    [$CEFA]     ;/
$90:CEF2 A9 04 00    LDA #$0004             ;\
$90:CEF5 8D 60 0B    STA $0B60  [$7E:0B60]  ;} SBA angle delta = 4
$90:CEF8 80 06       BRA $06    [$CF00]

$90:CEFA A9 FC FF    LDA #$FFFC             ;\ Else (facing left):
$90:CEFD 8D 60 0B    STA $0B60  [$7E:0B60]  ;} SBA angle delta = -4

$90:CF00 A9 27 00    LDA #$0027             ;\
$90:CF03 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 27h, sound library 1, max queued sounds allowed = 6 (plasma SBA)
$90:CF07 38          SEC                    ;\
$90:CF08 60          RTS                    ;} Return carry set
}


;;; $CF09: Projectile pre-instruction - ice SBA - main ;;;
{
;; Parameters:
;;     X: Projectile index
$90:CF09 BD 04 0C    LDA $0C04,x            ;\
$90:CF0C 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:CF0F F0 0C       BEQ $0C    [$CF1D]     ;/
$90:CF11 A9 24 00    LDA #$0024             ;\
$90:CF14 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 24h, sound library 1, max queued sounds allowed = 6 (ice SBA end)
$90:CF18 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:CF1C 60          RTS                    ; Return

$90:CF1D DE 90 0C    DEC $0C90,x            ; Decrement projectile trail timer
$90:CF20 D0 0D       BNE $0D    [$CF2F]     ; If [projectile trail timer] = 0:
$90:CF22 A9 04 00    LDA #$0004             ;\
$90:CF25 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:CF28 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:CF2C AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:CF2F BD 7C 0C    LDA $0C7C,x            ;\
$90:CF32 A8          TAY                    ;} Y = [projectile angle]
$90:CF33 A9 20 00    LDA #$0020             ;\
$90:CF36 20 39 CC    JSR $CC39  [$90:CC39]  ;} ($14, $16) = (20h * sin([Y] * pi / 80h), 20h * -cos([Y] * pi / 80h))
$90:CF39 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:CF3C 18          CLC                    ;|
$90:CF3D 65 14       ADC $14    [$7E:0014]  ;} Projectile X position = [Samus X position] + [$14]
$90:CF3F 9D 64 0B    STA $0B64,x            ;/
$90:CF42 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:CF45 18          CLC                    ;|
$90:CF46 65 16       ADC $16    [$7E:0016]  ;} Projectile Y position = [Samus Y position] + [$16]
$90:CF48 9D 78 0B    STA $0B78,x            ;/
$90:CF4B BD 7C 0C    LDA $0C7C,x            ;\
$90:CF4E 18          CLC                    ;|
$90:CF4F 6D 60 0B    ADC $0B60  [$7E:0B60]  ;} Projectile angle = ([projectile angle] + [SBA angle delta]) % 100h
$90:CF52 29 FF 00    AND #$00FF             ;|
$90:CF55 9D 7C 0C    STA $0C7C,x            ;/
$90:CF58 DE F0 0B    DEC $0BF0,x            ; Decrement SBA timer
$90:CF5B D0 13       BNE $13    [$CF70]     ; If [SBA timer] = 0:
$90:CF5D A9 7A CF    LDA #$CF7A             ;\
$90:CF60 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $CF7A
$90:CF63 A9 28 00    LDA #$0028             ;\
$90:CF66 9D DC 0B    STA $0BDC,x            ;} Projectile distance = 28h
$90:CF69 A9 24 00    LDA #$0024             ;\
$90:CF6C 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 24h, sound library 1, max queued sounds allowed = 6 (ice SBA end)

$90:CF70 A9 02 00    LDA #$0002             ;\
$90:CF73 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 2
$90:CF76 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:CF79 60          RTS
}


;;; $CF7A: Projectile pre-instruction - ice SBA - end ;;;
{
;; Parameters:
;;     X: Projectile index
$90:CF7A BD 04 0C    LDA $0C04,x            ;\
$90:CF7D 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:CF80 F0 05       BEQ $05    [$CF87]     ;/
$90:CF82 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:CF86 60          RTS                    ; Return

$90:CF87 DE 90 0C    DEC $0C90,x            ; Decrement projectile trail timer
$90:CF8A D0 0D       BNE $0D    [$CF99]     ; If [projectile trail timer] = 0:
$90:CF8C A9 04 00    LDA #$0004             ;\
$90:CF8F 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:CF92 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:CF96 AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:CF99 BD 7C 0C    LDA $0C7C,x            ;\
$90:CF9C A8          TAY                    ;} Y = [projectile angle]
$90:CF9D BD DC 0B    LDA $0BDC,x            ; A = [projectile distance]
$90:CFA0 20 39 CC    JSR $CC39  [$90:CC39]  ; ($14, $16) = ([A] * sin([Y] * pi / 80h), [A] * -cos([Y] * pi / 80h))
$90:CFA3 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:CFA6 18          CLC                    ;|
$90:CFA7 65 14       ADC $14    [$7E:0014]  ;} Projectile X position = [Samus X position] + [$14]
$90:CFA9 9D 64 0B    STA $0B64,x            ;/
$90:CFAC 38          SEC                    ;\
$90:CFAD ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:CFB0 C9 E0 FF    CMP #$FFE0             ;|
$90:CFB3 30 40       BMI $40    [$CFF5]     ;} If -20h <= [projectile X position] - [layer 1 X position] < 120h:
$90:CFB5 C9 20 01    CMP #$0120             ;|
$90:CFB8 10 3B       BPL $3B    [$CFF5]     ;/
$90:CFBA AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:CFBD 18          CLC                    ;|
$90:CFBE 65 16       ADC $16    [$7E:0016]  ;} Projectile Y position = [Samus Y position] + [$16]
$90:CFC0 9D 78 0B    STA $0B78,x            ;/
$90:CFC3 38          SEC                    ;\
$90:CFC4 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:CFC7 C9 10 00    CMP #$0010             ;|
$90:CFCA 30 29       BMI $29    [$CFF5]     ;} If 10h <= [projectile Y position] - [layer 1 Y position] < 100h:
$90:CFCC C9 00 01    CMP #$0100             ;|
$90:CFCF 10 24       BPL $24    [$CFF5]     ;/
$90:CFD1 BD 7C 0C    LDA $0C7C,x            ;\
$90:CFD4 18          CLC                    ;|
$90:CFD5 6D 60 0B    ADC $0B60  [$7E:0B60]  ;} Projectile angle = ([projectile angle] + [SBA angle delta]) % 100h
$90:CFD8 29 FF 00    AND #$00FF             ;|
$90:CFDB 9D 7C 0C    STA $0C7C,x            ;/
$90:CFDE BD DC 0B    LDA $0BDC,x            ;\
$90:CFE1 18          CLC                    ;|
$90:CFE2 69 08 00    ADC #$0008             ;} Projectile distance = ([projectile distance] + 8) % 100h
$90:CFE5 29 FF 00    AND #$00FF             ;|
$90:CFE8 9D DC 0B    STA $0BDC,x            ;/
$90:CFEB A9 02 00    LDA #$0002             ;\
$90:CFEE 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 2
$90:CFF1 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:CFF4 60          RTS                    ; Return

$90:CFF5 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:CFF9 60          RTS
}
}


;;; $CFFA..D524: Shinespark ;;;
{
;;; $CFFA: Trigger shinespark windup ;;;
{
$90:CFFA 08          PHP
$90:CFFB 8B          PHB
$90:CFFC 4B          PHK                    ;\
$90:CFFD AB          PLB                    ;} DB = $90
$90:CFFE C2 30       REP #$30
$90:D000 A9 68 D0    LDA #$D068             ;\
$90:D003 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D068 (shinespark windup)
$90:D006 A9 01 00    LDA #$0001             ;\
$90:D009 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$90:D00C A9 00 04    LDA #$0400             ;\
$90:D00F 8D 3E 0B    STA $0B3E  [$7E:0B3E]  ;} Speed boost counter = 4, speed boost timer = 0
$90:D012 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:D015 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:D018 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = none
$90:D01B A9 08 00    LDA #$0008             ;\
$90:D01E 8D 42 0B    STA $0B42  [$7E:0B42]  ;} Samus X extra run speed = 8.0
$90:D021 9C 44 0B    STZ $0B44  [$7E:0B44]  ;/
$90:D024 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:D027 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:D02A A9 07 00    LDA #$0007             ;\
$90:D02D 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} Shinespark Y acceleration = 7.0
$90:D030 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ;/
$90:D033 9C CC 0C    STZ $0CCC  [$7E:0CCC]  ; Cooldown timer = 0
$90:D036 A9 1E 00    LDA #$001E             ;\
$90:D039 8D A2 0A    STA $0AA2  [$7E:0AA2]  ;} Shinespark windup timer = 30
$90:D03C A9 3C 00    LDA #$003C             ;\
$90:D03F 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 60
$90:D042 A9 06 00    LDA #$0006             ;\
$90:D045 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = 6 (shinesparking)
$90:D048 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$90:D04B 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = none
$90:D04E AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:D051 F0 12       BEQ $12    [$D065]     ;} If [flare counter] = 0: return
$90:D053 C9 10 00    CMP #$0010             ;\
$90:D056 30 07       BMI $07    [$D05F]     ;} If [flare counter] >= 10h:
$90:D058 A9 02 00    LDA #$0002             ;\
$90:D05B 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 9 (silence)

$90:D05F 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:D062 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear flare animation state

$90:D065 AB          PLB
$90:D066 28          PLP
$90:D067 6B          RTL
}


;;; $D068: Samus movement handler - shinespark windup ;;;
{
$90:D068 CE A2 0A    DEC $0AA2  [$7E:0AA2]  ; Decrement shinespark windup timer
$90:D06B F0 02       BEQ $02    [$D06F]     ;\
$90:D06D 10 3B       BPL $3B    [$D0AA]     ;} If [shinespark windup timer] > 0: return

$90:D06F AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:D072 29 FF 00    AND #$00FF             ;|
$90:D075 C9 04 00    CMP #$0004             ;} If facing right:
$90:D078 F0 08       BEQ $08    [$D082]     ;/
$90:D07A A9 CB 00    LDA #$00CB             ;\
$90:D07D 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - shinespark - vertical
$90:D080 80 06       BRA $06    [$D088]

$90:D082 A9 CC 00    LDA #$00CC             ;\ Else (facing left):
$90:D085 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - shinespark - vertical

$90:D088 A9 AB D0    LDA #$D0AB             ;\
$90:D08B 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D0AB (vertical shinespark)
$90:D08E A9 0E E9    LDA #$E90E             ;\
$90:D091 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS
$90:D094 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echoes index = 0
$90:D097 9C C0 0A    STZ $0AC0  [$7E:0AC0]  ;\
$90:D09A 9C C2 0A    STZ $0AC2  [$7E:0AC2]  ;} Speed echo X speeds = 0
$90:D09D 9C B0 0A    STZ $0AB0  [$7E:0AB0]  ;\
$90:D0A0 9C B2 0A    STZ $0AB2  [$7E:0AB2]  ;} Speed echo X positions = 0
$90:D0A3 A9 0F 00    LDA #$000F             ;\
$90:D0A6 22 2F 91 80 JSL $80912F[$80:912F]  ;} Queue sound Fh, sound library 3, max queued sounds allowed = 9 (shinespark)

$90:D0AA 60          RTS
}


;;; $D0AB: Samus movement handler - vertical shinespark ;;;
{
$90:D0AB A9 02 00    LDA #$0002             ;\
$90:D0AE 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = shinesparking
$90:D0B1 A9 08 00    LDA #$0008             ;\
$90:D0B4 8D 48 0A    STA $0A48  [$7E:0A48]  ;} Samus hurt flash counter = 8
$90:D0B7 A2 04 00    LDX #$0004             ;\
$90:D0BA AC 20 EF    LDY $EF20  [$90:EF20]  ;} >_<;
$90:D0BD 20 E7 EE    JSR $EEE7  [$90:EEE7]  ; Update speed echo position
$90:D0C0 20 FF D1    JSR $D1FF  [$90:D1FF]  ; Shinespark vertical movement
$90:D0C3 20 BA D2    JSR $D2BA  [$90:D2BA]  ; End shinespark if collision detected or low health
$90:D0C6 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:D0C9 C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$90:D0CC 30 08       BMI $08    [$D0D6]     ;/
$90:D0CE CE C2 09    DEC $09C2  [$7E:09C2]  ; Decrement Samus health
$90:D0D1 10 03       BPL $03    [$D0D6]     ;\
$90:D0D3 9C C2 09    STZ $09C2  [$7E:09C2]  ;} >_<;

$90:D0D6 60          RTS
}


;;; $D0D7: Samus movement handler - diagonal shinespark ;;;
{
$90:D0D7 A9 02 00    LDA #$0002             ;\
$90:D0DA 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = shinesparking
$90:D0DD A9 08 00    LDA #$0008             ;\
$90:D0E0 8D 48 0A    STA $0A48  [$7E:0A48]  ;} Samus hurt flash counter = 8
$90:D0E3 A2 04 00    LDX #$0004             ;\
$90:D0E6 AC 20 EF    LDY $EF20  [$90:EF20]  ;} >_<;
$90:D0E9 20 E7 EE    JSR $EEE7  [$90:EEE7]  ; Update speed echo position
$90:D0EC 20 32 D1    JSR $D132  [$90:D132]  ; Shinespark horizontal movement
$90:D0EF 20 FF D1    JSR $D1FF  [$90:D1FF]  ; Shinespark vertical movement
$90:D0F2 20 BA D2    JSR $D2BA  [$90:D2BA]  ; End shinespark if collision detected or low health
$90:D0F5 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:D0F8 C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$90:D0FB 30 08       BMI $08    [$D105]     ;/
$90:D0FD CE C2 09    DEC $09C2  [$7E:09C2]  ; Decrement Samus health
$90:D100 10 03       BPL $03    [$D105]     ;\
$90:D102 9C C2 09    STZ $09C2  [$7E:09C2]  ;} >_<;

$90:D105 60          RTS
}


;;; $D106: Samus movement handler - horizontal shinespark ;;;
{
$90:D106 A9 02 00    LDA #$0002             ;\
$90:D109 8D 6E 0A    STA $0A6E  [$7E:0A6E]  ;} Samus contact damage index = shinesparking
$90:D10C A9 08 00    LDA #$0008             ;\
$90:D10F 8D 48 0A    STA $0A48  [$7E:0A48]  ;} Samus hurt flash counter = 8
$90:D112 A2 08 00    LDX #$0008             ;\
$90:D115 AC 20 EF    LDY $EF20  [$90:EF20]  ;} >_<;
$90:D118 20 E7 EE    JSR $EEE7  [$90:EEE7]  ; Update speed echo position
$90:D11B 20 32 D1    JSR $D132  [$90:D132]  ; Shinespark horizontal movement
$90:D11E 20 BA D2    JSR $D2BA  [$90:D2BA]  ; End shinespark if collision detected or low health
$90:D121 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:D124 C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$90:D127 30 08       BMI $08    [$D131]     ;/
$90:D129 CE C2 09    DEC $09C2  [$7E:09C2]  ; Decrement Samus health
$90:D12C 10 03       BPL $03    [$D131]     ;\
$90:D12E 9C C2 09    STZ $09C2  [$7E:09C2]  ;} >_<;

$90:D131 60          RTS
}


;;; $D132: Shinespark horizontal movement ;;;
{
$90:D132 A9 0F 00    LDA #$000F             ;\
$90:D135 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = Fh
$90:D138 AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$90:D13B 18          CLC                    ;|
$90:D13C 6D 32 0B    ADC $0B32  [$7E:0B32]  ;|
$90:D13F 8D 44 0B    STA $0B44  [$7E:0B44]  ;} Shinespark X speed += [shinespark X acceleration]
$90:D142 AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$90:D145 6D 34 0B    ADC $0B34  [$7E:0B34]  ;|
$90:D148 8D 42 0B    STA $0B42  [$7E:0B42]  ;/
$90:D14B C9 0F 00    CMP #$000F             ;\
$90:D14E 30 09       BMI $09    [$D159]     ;} If [shinespark X speed] >= Fh:
$90:D150 A9 0F 00    LDA #$000F             ;\
$90:D153 8D 42 0B    STA $0B42  [$7E:0B42]  ;} Shinespark X speed = Fh.0
$90:D156 9C 44 0B    STZ $0B44  [$7E:0B44]  ;/

$90:D159 64 12       STZ $12    [$7E:0012]  ;\
$90:D15B 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = 0.0
$90:D15D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:D160 29 FF 00    AND #$00FF             ;|
$90:D163 C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_LEFT
$90:D166 F0 25       BEQ $25    [$D18D]     ;/
$90:D168 20 AD E4    JSR $E4AD  [$90:E4AD]  ; Calculate Samus X displacement for moving right
$90:D16B A5 12       LDA $12    [$7E:0012]  ;\
$90:D16D C9 0F 00    CMP #$000F             ;|
$90:D170 30 05       BMI $05    [$D177]     ;} $12 = min([$12], Fh)
$90:D172 A9 0F 00    LDA #$000F             ;|
$90:D175 85 12       STA $12    [$7E:0012]  ;/

$90:D177 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:D17B AA          TAX                    ;\
$90:D17C F0 05       BEQ $05    [$D183]     ;} If collision detected:
$90:D17E 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:D181 80 53       BRA $53    [$D1D6]     ; Go to BRANCH_MERGE

$90:D183 22 1E 97 94 JSL $94971E[$94:971E]  ; Move Samus right by [$12].[$14], no solid enemy collision
$90:D187 22 F4 87 94 JSL $9487F4[$94:87F4]  ; Align Samus Y position with non-square slope
$90:D18B 80 49       BRA $49    [$D1D6]     ; Go to BRANCH_MERGE

; BRANCH_LEFT
$90:D18D 20 64 E4    JSR $E464  [$90:E464]  ; Calculate Samus X displacement for moving left
$90:D190 A5 12       LDA $12    [$7E:0012]  ;\
$90:D192 49 FF FF    EOR #$FFFF             ;|
$90:D195 85 12       STA $12    [$7E:0012]  ;|
$90:D197 A5 14       LDA $14    [$7E:0014]  ;|
$90:D199 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:D19C 1A          INC A                  ;|
$90:D19D 85 14       STA $14    [$7E:0014]  ;|
$90:D19F D0 02       BNE $02    [$D1A3]     ;|
$90:D1A1 E6 12       INC $12    [$7E:0012]  ;/

$90:D1A3 A5 12       LDA $12    [$7E:0012]  ;\
$90:D1A5 C9 0F 00    CMP #$000F             ;|
$90:D1A8 30 05       BMI $05    [$D1AF]     ;} $12 = min([$12], Fh)
$90:D1AA A9 0F 00    LDA #$000F             ;|
$90:D1AD 85 12       STA $12    [$7E:0012]  ;/

$90:D1AF 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:D1B3 AA          TAX                    ;\
$90:D1B4 F0 05       BEQ $05    [$D1BB]     ;} If collision detected:
$90:D1B6 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:D1B9 80 1B       BRA $1B    [$D1D6]     ; Go to BRANCH_MERGE

$90:D1BB A5 12       LDA $12    [$7E:0012]  ;\
$90:D1BD 49 FF FF    EOR #$FFFF             ;|
$90:D1C0 85 12       STA $12    [$7E:0012]  ;|
$90:D1C2 A5 14       LDA $14    [$7E:0014]  ;|
$90:D1C4 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:D1C7 1A          INC A                  ;|
$90:D1C8 85 14       STA $14    [$7E:0014]  ;|
$90:D1CA D0 02       BNE $02    [$D1CE]     ;|
$90:D1CC E6 12       INC $12    [$7E:0012]  ;/

$90:D1CE 22 1E 97 94 JSL $94971E[$94:971E]  ; Move Samus right by [$12].[$14], no solid enemy collision
$90:D1D2 22 F4 87 94 JSL $9487F4[$94:87F4]  ; Align Samus Y position with non-square slope

; BRANCH_MERGE
$90:D1D6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D1D9 38          SEC                    ;|
$90:D1DA ED 10 0B    SBC $0B10  [$7E:0B10]  ;} If [Samus X position] >= [Samus previous X position]:
$90:D1DD 30 10       BMI $10    [$D1EF]     ;/
$90:D1DF C9 10 00    CMP #$0010             ;\
$90:D1E2 30 1A       BMI $1A    [$D1FE]     ;} If [Samus X position] < [Samus previous X position] + 10h: return
$90:D1E4 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D1E7 38          SEC                    ;|
$90:D1E8 E9 0F 00    SBC #$000F             ;} Samus previous X position = [Samus X position] - Fh
$90:D1EB 8D 10 0B    STA $0B10  [$7E:0B10]  ;/
$90:D1EE 60          RTS                    ; Return

$90:D1EF C9 F1 FF    CMP #$FFF1             ;\
$90:D1F2 10 0A       BPL $0A    [$D1FE]     ;} If [Samus X position] >= [Samus previous X position] - Fh: return
$90:D1F4 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D1F7 18          CLC                    ;|
$90:D1F8 69 0F 00    ADC #$000F             ;} Samus previous X position = [Samus X position] + Fh
$90:D1FB 8D 10 0B    STA $0B10  [$7E:0B10]  ;/

$90:D1FE 60          RTS
}


;;; $D1FF: Shinespark vertical movement ;;;
{
$90:D1FF A9 0F 00    LDA #$000F             ;\
$90:D202 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = Fh
$90:D205 AD EE 0D    LDA $0DEE  [$7E:0DEE]  ;\
$90:D208 18          CLC                    ;|
$90:D209 6D 32 0B    ADC $0B32  [$7E:0B32]  ;|
$90:D20C 8D EE 0D    STA $0DEE  [$7E:0DEE]  ;} Shinespark Y acceleration += [shinespark Y acceleration delta]
$90:D20F AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;|
$90:D212 6D 34 0B    ADC $0B34  [$7E:0B34]  ;|
$90:D215 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;/
$90:D218 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:D21B 18          CLC                    ;|
$90:D21C 6D EE 0D    ADC $0DEE  [$7E:0DEE]  ;|
$90:D21F 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$90:D222 85 14       STA $14    [$7E:0014]  ;} Samus Y speed += [shinespark Y acceleration]
$90:D224 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;|
$90:D227 6D EC 0D    ADC $0DEC  [$7E:0DEC]  ;|
$90:D22A 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$90:D22D 85 12       STA $12    [$7E:0012]  ; $12.$14 = [Samus Y speed]
$90:D22F C9 0E 00    CMP #$000E             ;\
$90:D232 30 05       BMI $05    [$D239]     ;|
$90:D234 A9 0E 00    LDA #$000E             ;} $12 = min([$12], Eh)
$90:D237 85 12       STA $12    [$7E:0012]  ;/

$90:D239 A5 12       LDA $12    [$7E:0012]  ;\
$90:D23B 49 FF FF    EOR #$FFFF             ;|
$90:D23E 85 12       STA $12    [$7E:0012]  ;|
$90:D240 A5 14       LDA $14    [$7E:0014]  ;|
$90:D242 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:D245 1A          INC A                  ;|
$90:D246 85 14       STA $14    [$7E:0014]  ;|
$90:D248 D0 02       BNE $02    [$D24C]     ;|
$90:D24A E6 12       INC $12    [$7E:0012]  ;/

$90:D24C AD 5A 0B    LDA $0B5A  [$7E:0B5A]  ;\
$90:D24F 18          CLC                    ;|
$90:D250 65 14       ADC $14    [$7E:0014]  ;|
$90:D252 85 14       STA $14    [$7E:0014]  ;} $12.$14 += [extra Samus Y displacement]
$90:D254 AD 5C 0B    LDA $0B5C  [$7E:0B5C]  ;|
$90:D257 65 12       ADC $12    [$7E:0012]  ;|
$90:D259 85 12       STA $12    [$7E:0012]  ;/
$90:D25B A9 02 00    LDA #$0002             ;\
$90:D25E 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = up
$90:D261 A5 12       LDA $12    [$7E:0012]  ;\
$90:D263 49 FF FF    EOR #$FFFF             ;|
$90:D266 85 12       STA $12    [$7E:0012]  ;|
$90:D268 A5 14       LDA $14    [$7E:0014]  ;|
$90:D26A 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:D26D 1A          INC A                  ;|
$90:D26E 85 14       STA $14    [$7E:0014]  ;|
$90:D270 D0 02       BNE $02    [$D274]     ;|
$90:D272 E6 12       INC $12    [$7E:0012]  ;/

$90:D274 A5 12       LDA $12    [$7E:0012]  ;\
$90:D276 C9 0F 00    CMP #$000F             ;|
$90:D279 30 05       BMI $05    [$D280]     ;} $12 = min([$12], Fh)
$90:D27B A9 0F 00    LDA #$000F             ;|
$90:D27E 85 12       STA $12    [$7E:0012]  ;/

$90:D280 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$90:D284 AA          TAX                    ;\
$90:D285 F0 05       BEQ $05    [$D28C]     ;} If collision detected:
$90:D287 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = no collision
$90:D28A 80 17       BRA $17    [$D2A3]     ; Go to BRANCH_NO_MOVEMENT

$90:D28C A5 12       LDA $12    [$7E:0012]  ;\
$90:D28E 49 FF FF    EOR #$FFFF             ;|
$90:D291 85 12       STA $12    [$7E:0012]  ;|
$90:D293 A5 14       LDA $14    [$7E:0014]  ;|
$90:D295 49 FF FF    EOR #$FFFF             ;} $12.$14 = -[$12].[$14]
$90:D298 1A          INC A                  ;|
$90:D299 85 14       STA $14    [$7E:0014]  ;|
$90:D29B D0 02       BNE $02    [$D29F]     ;|
$90:D29D E6 12       INC $12    [$7E:0012]  ;/

$90:D29F 22 63 97 94 JSL $949763[$94:9763]  ; Move Samus down by [$12].[$14], no solid enemy collision

; BRANCH_NO_MOVEMENT
$90:D2A3 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D2A6 38          SEC                    ;|
$90:D2A7 ED 14 0B    SBC $0B14  [$7E:0B14]  ;} If [Samus Y position] >= [Samus previous Y position] - Eh: return
$90:D2AA C9 F2 FF    CMP #$FFF2             ;|
$90:D2AD 10 0A       BPL $0A    [$D2B9]     ;/
$90:D2AF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D2B2 18          CLC                    ;|
$90:D2B3 69 0E 00    ADC #$000E             ;} Samus previous Y position = [Samus Y position] + Eh
$90:D2B6 8D 14 0B    STA $0B14  [$7E:0B14]  ;/

$90:D2B9 60          RTS
}


;;; $D2BA: End shinespark if collision detected or low health ;;;
{
;; Returns:
;;     Carry: Set if shinespark ended, otherwise clear
$90:D2BA AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:D2BD C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$90:D2C0 30 07       BMI $07    [$D2C9]     ;/
$90:D2C2 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:D2C5 D0 02       BNE $02    [$D2C9]     ;} If no solid collision:
$90:D2C7 18          CLC                    ;\
$90:D2C8 60          RTS                    ;} Return carry clear

$90:D2C9 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:D2CC 29 FF 00    AND #$00FF             ;|
$90:D2CF C9 04 00    CMP #$0004             ;} If facing right:
$90:D2D2 F0 14       BEQ $14    [$D2E8]     ;/
$90:D2D4 A9 E0 00    LDA #$00E0             ;\
$90:D2D7 8D C0 0A    STA $0AC0  [$7E:0AC0]  ;} Speed echo 0 angle = E0h
$90:D2DA A9 60 00    LDA #$0060             ;\
$90:D2DD 8D C2 0A    STA $0AC2  [$7E:0AC2]  ;} Speed echo 1 angle = 60h
$90:D2E0 A9 FC FF    LDA #$FFFC             ;\
$90:D2E3 8D B4 0A    STA $0AB4  [$7E:0AB4]  ;} Speed echo angle delta = -4
$90:D2E6 80 12       BRA $12    [$D2FA]

$90:D2E8 A9 20 00    LDA #$0020             ;\ Else (facing left):
$90:D2EB 8D C0 0A    STA $0AC0  [$7E:0AC0]  ;} Speed echo 0 angle = 20h
$90:D2EE A9 A0 00    LDA #$00A0             ;\
$90:D2F1 8D C2 0A    STA $0AC2  [$7E:0AC2]  ;} Speed echo 1 angle = A0h
$90:D2F4 A9 04 00    LDA #$0004             ;\
$90:D2F7 8D B4 0A    STA $0AB4  [$7E:0AB4]  ;} Speed echo angle delta = 4

$90:D2FA 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:D2FD 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:D300 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:D303 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:D306 9C 3E 0B    STZ $0B3E  [$7E:0B3E]  ; Speed boost counter = 0, speed boost timer = 0
$90:D309 9C 1A 0B    STZ $0B1A  [$7E:0B1A]  ; $0B1A = 0
$90:D30C 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$90:D30F A9 46 D3    LDA #$D346             ;\
$90:D312 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D346 (shinespark crash - echoes circle Samus)
$90:D315 A9 F3 EB    LDA #$EBF3             ;\
$90:D318 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = $EBF3 (shinespark crash echo circle)
$90:D31B 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echoes index = 0
$90:D31E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D321 8D B0 0A    STA $0AB0  [$7E:0AB0]  ;} Speed echo 0/1 X position = [Samus X position]
$90:D324 8D B2 0A    STA $0AB2  [$7E:0AB2]  ;/
$90:D327 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D32A 8D B8 0A    STA $0AB8  [$7E:0AB8]  ;} Speed echo 0/1 Y position = [Samus Y position]
$90:D32D 8D BA 0A    STA $0ABA  [$7E:0ABA]  ;/
$90:D330 9C C4 0A    STZ $0AC4  [$7E:0AC4]  ; $0AC4 = 0
$90:D333 9C 48 0A    STZ $0A48  [$7E:0A48]  ; Samus hurt flash counter = 0
$90:D336 A9 35 00    LDA #$0035             ;\
$90:D339 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 35h, sound library 1, max queued sounds allowed = 5 (Samus damaged)
$90:D33D A9 10 00    LDA #$0010             ;\
$90:D340 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 10h, sound library 3, max queued sounds allowed = 6 (shinespark ended)
$90:D344 38          SEC                    ;\
$90:D345 60          RTS                    ;} Return carry set
}


;;; $D346: Samus movement handler - shinespark crash - echoes circle Samus ;;;
{
$90:D346 A9 0F 00    LDA #$000F             ;\
$90:D349 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = Fh
$90:D34C AD AF 0A    LDA $0AAF  [$7E:0AAF]  ;\
$90:D34F 29 FF 00    AND #$00FF             ;|
$90:D352 0A          ASL A                  ;} Execute [$D37D + [shinespark crash echo circle phase] * 2]
$90:D353 AA          TAX                    ;|
$90:D354 FC 7D D3    JSR ($D37D,x)[$90:D383];/
$90:D357 A2 02 00    LDX #$0002             ; X = 2 (speed echo index)

; LOOP
$90:D35A BC C0 0A    LDY $0AC0,x[$7E:0AC2]  ; Y = [speed echo angle]
$90:D35D AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$90:D360 29 FF 00    AND #$00FF             ;} A = [speed echo distance]
$90:D363 20 39 CC    JSR $CC39  [$90:CC39]  ; ($14, $16) = ([A] * sin([Y] * pi / 80h), [A] * -cos([Y] * pi / 80h))
$90:D366 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D369 18          CLC                    ;|
$90:D36A 65 14       ADC $14    [$7E:0014]  ;} Speed echo X position = [Samus X position] + [$14]
$90:D36C 9D B0 0A    STA $0AB0,x[$7E:0AB2]  ;/
$90:D36F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D372 18          CLC                    ;|
$90:D373 65 16       ADC $16    [$7E:0016]  ;} Speed echo Y position = [Samus Y position] + [$16]
$90:D375 9D B8 0A    STA $0AB8,x[$7E:0ABA]  ;/
$90:D378 CA          DEX                    ;\
$90:D379 CA          DEX                    ;} X -= 2
$90:D37A 10 DE       BPL $DE    [$D35A]     ; If [X] >= 0: go to LOOP
$90:D37C 60          RTS

$90:D37D             dw D383, D396, D3CC
}


;;; $D383: Samus movement handler - shinespark crash - echoes circle Samus - phase 0 ;;;
{
$90:D383 AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$90:D386 18          CLC                    ;} Speed echo distance += 4
$90:D387 69 04 00    ADC #$0004             ;/
$90:D38A C9 10 00    CMP #$0010             ;\
$90:D38D 30 03       BMI $03    [$D392]     ;} If [speed echo distance] >= 10h:
$90:D38F 09 00 01    ORA #$0100             ; Shinespark crash echo circle phase = 1

$90:D392 8D AE 0A    STA $0AAE  [$7E:0AAE]
$90:D395 60          RTS
}


;;; $D396: Samus movement handler - shinespark crash - echoes circle Samus - phase 1 ;;;
{
$90:D396 AD C0 0A    LDA $0AC0  [$7E:0AC0]  ;\
$90:D399 18          CLC                    ;|
$90:D39A 6D B4 0A    ADC $0AB4  [$7E:0AB4]  ;} Speed echo 0 angle = ([speed echo 0 angle] + [speed echo angle delta]) % 100h
$90:D39D 29 FF 00    AND #$00FF             ;|
$90:D3A0 8D C0 0A    STA $0AC0  [$7E:0AC0]  ;/
$90:D3A3 AD C2 0A    LDA $0AC2  [$7E:0AC2]  ;\
$90:D3A6 18          CLC                    ;|
$90:D3A7 6D B4 0A    ADC $0AB4  [$7E:0AB4]  ;} Speed echo 1 angle = ([speed echo 1 angle] + [speed echo angle delta]) % 100h
$90:D3AA 29 FF 00    AND #$00FF             ;|
$90:D3AD 8D C2 0A    STA $0AC2  [$7E:0AC2]  ;/
$90:D3B0 AD BC 0A    LDA $0ABC  [$7E:0ABC]  ;\
$90:D3B3 18          CLC                    ;|
$90:D3B4 69 04 00    ADC #$0004             ;} Shinespark crash echo circle timer += 4
$90:D3B7 8D BC 0A    STA $0ABC  [$7E:0ABC]  ;/
$90:D3BA C9 80 00    CMP #$0080             ;\
$90:D3BD 30 0C       BMI $0C    [$D3CB]     ;} If [shinespark crash echo circle timer] >= 80h:
$90:D3BF AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$90:D3C2 29 FF 00    AND #$00FF             ;|
$90:D3C5 09 00 02    ORA #$0200             ;} Shinespark crash echo circle phase = 2
$90:D3C8 8D AE 0A    STA $0AAE  [$7E:0AAE]  ;/

$90:D3CB 60          RTS
}


;;; $D3CC: Samus movement handler - shinespark crash - echoes circle Samus - phase 2 ;;;
{
$90:D3CC AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$90:D3CF 38          SEC                    ;|
$90:D3D0 E9 04 00    SBC #$0004             ;} Speed echo distance -= 4
$90:D3D3 8D AE 0A    STA $0AAE  [$7E:0AAE]  ;/
$90:D3D6 29 FF 00    AND #$00FF             ;\
$90:D3D9 F0 02       BEQ $02    [$D3DD]     ;} If [speed echo distance] > 0: return
$90:D3DB 10 15       BPL $15    [$D3F2]     ;/

$90:D3DD A9 F3 D3    LDA #$D3F3             ;\
$90:D3E0 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D3F3 (shinespark crash - echoes finished circling Samus)
$90:D3E3 A9 1E 00    LDA #$001E             ;\
$90:D3E6 8D A2 0A    STA $0AA2  [$7E:0AA2]  ;} Shinespark crash timer = 30
$90:D3E9 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echo distance = 0
$90:D3EC 9C C0 0A    STZ $0AC0  [$7E:0AC0]  ; Speed echo 0 angle = 0
$90:D3EF 9C C2 0A    STZ $0AC2  [$7E:0AC2]  ; Speed echo 1 angle = 0

$90:D3F2 60          RTS
}


;;; $D3F3: Samus movement handler - shinespark crash - echoes finished circling Samus ;;;
{
$90:D3F3 A9 0F 00    LDA #$000F             ;\
$90:D3F6 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = Fh
$90:D3F9 CE A2 0A    DEC $0AA2  [$7E:0AA2]  ; Decrement shinespark crash timer
$90:D3FC F0 02       BEQ $02    [$D400]     ;\
$90:D3FE 10 0C       BPL $0C    [$D40C]     ;} If [shinespark crash timer] > 0: return

$90:D400 A9 0D D4    LDA #$D40D             ;\
$90:D403 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D40D (shinespark crash - finish)
$90:D406 A9 52 EB    LDA #$EB52             ;\
$90:D409 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default

$90:D40C 60          RTS
}


;;; $D40D: Samus movement handler - shinespark crash - finish ;;;
{
$90:D40D 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echoes index = 0
$90:D410 AD CE 0C    LDA $0CCE  [$7E:0CCE]  ;\
$90:D413 C9 05 00    CMP #$0005             ;} If [projectile counter] >= 5: go to BRANCH_DONT_FIRE
$90:D416 10 7F       BPL $7F    [$D497]     ;/
$90:D418 C9 04 00    CMP #$0004             ;\
$90:D41B 10 3D       BPL $3D    [$D45A]     ;} If [projectile counter] < 4:
$90:D41D EE CE 0C    INC $0CCE  [$7E:0CCE]  ; Increment projectile counter
$90:D420 A9 40 00    LDA #$0040             ;\
$90:D423 8D C4 0A    STA $0AC4  [$7E:0AC4]  ;} Draw speed echo 2 flag = 40h
$90:D426 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D429 8D B4 0A    STA $0AB4  [$7E:0AB4]  ;} Speed echo 2 X position = [Samus X position]
$90:D42C AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D42F 8D BC 0A    STA $0ABC  [$7E:0ABC]  ;} Speed echo 2 Y position = [Samus Y position]
$90:D432 A9 29 80    LDA #$8029             ;\
$90:D435 8D 1E 0C    STA $0C1E  [$7E:0C1E]  ;} Projectile 3 type = 8029h
$90:D438 A2 06 00    LDX #$0006             ; X = 6 (projectile 3 index)
$90:D43B 22 63 81 93 JSL $938163[$93:8163]  ; Initialise shinespark echo
$90:D43F A9 D2 D4    LDA #$D4D2             ;\
$90:D442 8D 6E 0C    STA $0C6E  [$7E:0C6E]  ;} Projectile 3 pre-instruction = $D4D2
$90:D445 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:D448 38          SEC                    ;|
$90:D449 E9 C9 00    SBC #$00C9             ;|
$90:D44C 0A          ASL A                  ;|
$90:D44D AA          TAX                    ;} Projectile 3 angle = [$D4C6 + ([Samus pose] - C9h) * 2]
$90:D44E BD C6 D4    LDA $D4C6,x[$90:D4C6]  ;|
$90:D451 29 FF 00    AND #$00FF             ;|
$90:D454 8D 82 0C    STA $0C82  [$7E:0C82]  ;/
$90:D457 9C E2 0B    STZ $0BE2  [$7E:0BE2]  ; Projectile 3 distance from Samus = 0

$90:D45A EE CE 0C    INC $0CCE  [$7E:0CCE]  ; Increment projectile counter
$90:D45D A9 40 00    LDA #$0040             ;\
$90:D460 8D C6 0A    STA $0AC6  [$7E:0AC6]  ;} Draw speed echo 3 flag = 40h
$90:D463 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D466 8D B6 0A    STA $0AB6  [$7E:0AB6]  ;} Speed echo 3 X position = [Samus X position]
$90:D469 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D46C 8D BE 0A    STA $0ABE  [$7E:0ABE]  ;} Speed echo 3 Y position = [Samus Y position]
$90:D46F A9 29 80    LDA #$8029             ;\
$90:D472 8D 20 0C    STA $0C20  [$7E:0C20]  ;} Projectile 4 type = 8029h
$90:D475 A2 08 00    LDX #$0008             ; X = 8 (projectile 4 index)
$90:D478 22 63 81 93 JSL $938163[$93:8163]  ; Initialise shinespark echo
$90:D47C A9 D2 D4    LDA #$D4D2             ;\
$90:D47F 8D 70 0C    STA $0C70  [$7E:0C70]  ;} Projectile 4 pre-instruction = $D4D2
$90:D482 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:D485 38          SEC                    ;|
$90:D486 E9 C9 00    SBC #$00C9             ;|
$90:D489 0A          ASL A                  ;|
$90:D48A AA          TAX                    ;} Projectile 4 angle = [$D4C6 + ([Samus pose] - C9h) * 2 + 1]
$90:D48B BD C7 D4    LDA $D4C7,x[$90:D4C7]  ;|
$90:D48E 29 FF 00    AND #$00FF             ;|
$90:D491 8D 84 0C    STA $0C84  [$7E:0C84]  ;/
$90:D494 9C E4 0B    STZ $0BE4  [$7E:0BE4]  ; Projectile 4 distance from Samus = 0

; BRANCH_DONT_FIRE
$90:D497 9C CC 0C    STZ $0CCC  [$7E:0CCC]  ; Cooldown timer = 0
$90:D49A A9 01 00    LDA #$0001             ;\
$90:D49D 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 1
$90:D4A0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:D4A3 29 FF 00    AND #$00FF             ;\
$90:D4A6 C9 04 00    CMP #$0004             ;} If facing right:
$90:D4A9 F0 08       BEQ $08    [$D4B3]     ;/
$90:D4AB A9 01 00    LDA #$0001             ;\
$90:D4AE 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;} Super special prospective pose = facing right - normal
$90:D4B1 80 06       BRA $06    [$D4B9]

$90:D4B3 A9 02 00    LDA #$0002             ;\ Else (facing left):
$90:D4B6 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;} Super special prospective pose = facing left - normal

$90:D4B9 A9 02 00    LDA #$0002             ;\
$90:D4BC 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = shinespark finished
$90:D4BF 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; $0DEC = 0
$90:D4C2 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ; $0DEE = 0
$90:D4C5 60          RTS

$90:D4C6             db 00,80, ; C9h: Facing right - shinespark - horizontal
                        00,80, ; CAh: Facing left  - shinespark - horizontal
                        40,C0, ; CBh: Facing right - shinespark - vertical
                        40,C0, ; CCh: Facing left  - shinespark - vertical
                        E0,60, ; CDh: Facing right - shinespark - diagonal
                        20,A0  ; CEh: Facing left  - shinespark - diagonal
}


;;; $D4D2: Projectile pre-instruction - speed echo ;;;
{
;; Parameters:
;;     X: Projectile index. Must be projectile slot 3 or 4, corresponding to speed echo 2 or 3 respectively

; BUG: It's possible for the projectile distance to be F8h..FFh whilst still on-screen,
;      e.g. Samus is within 8px of the left/right edge of the screen and a horizontal echo reaches the opposite edge of the screen
;      In this case, because only the low byte of projectile distance is used,
;      adding 8 to projectile distance effectively wraps around to 0..7, causing the echo itself to warp back to Samus
$90:D4D2 BD DC 0B    LDA $0BDC,x[$7E:0BE4]  ;\
$90:D4D5 18          CLC                    ;|
$90:D4D6 69 08 00    ADC #$0008             ;} Projectile distance += 8
$90:D4D9 9D DC 0B    STA $0BDC,x[$7E:0BE4]  ;/
$90:D4DC BC 7C 0C    LDY $0C7C,x[$7E:0C84]  ; Y = [projectile angle]
$90:D4DF BD DC 0B    LDA $0BDC,x[$7E:0BE4]  ;\
$90:D4E2 29 FF 00    AND #$00FF             ;} A = [projectile distance] % 100h
$90:D4E5 20 39 CC    JSR $CC39  [$90:CC39]  ; ($14, $16) = ([A] * sin([Y] * pi / 80h), [A] * -cos([Y] * pi / 80h))
$90:D4E8 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D4EB 18          CLC                    ;|
$90:D4EC 65 14       ADC $14    [$7E:0014]  ;} Speed echo X position = projectile X position = [Samus X position] + [$14]
$90:D4EE 9D AE 0A    STA $0AAE,x[$7E:0AB6]  ;|
$90:D4F1 9D 64 0B    STA $0B64,x[$7E:0B6C]  ;/
$90:D4F4 38          SEC                    ;\
$90:D4F5 ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:D4F8 30 1D       BMI $1D    [$D517]     ;} If 0 <= [projectile X position] - [layer 1 X position] < 100h:
$90:D4FA C9 00 01    CMP #$0100             ;|
$90:D4FD 10 18       BPL $18    [$D517]     ;/
$90:D4FF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D502 18          CLC                    ;|
$90:D503 65 16       ADC $16    [$7E:0016]  ;} Speed echo Y position = projectile Y position = [Samus Y position] + [$16]
$90:D505 9D B6 0A    STA $0AB6,x[$7E:0ABE]  ;|
$90:D508 9D 78 0B    STA $0B78,x[$7E:0B80]  ;/
$90:D50B 38          SEC                    ;\
$90:D50C ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:D50F 30 06       BMI $06    [$D517]     ;} If 0 <= [projectile Y position] - [layer 1 Y position] < 100h:
$90:D511 C9 00 01    CMP #$0100             ;|
$90:D514 10 01       BPL $01    [$D517]     ;/
$90:D516 60          RTS                    ; Return

$90:D517 9E BE 0A    STZ $0ABE,x[$7E:0AC6]  ; Draw speed echo flag = 0
$90:D51A 9E AE 0A    STZ $0AAE,x[$7E:0AB6]  ; Speed echo X position = 0
$90:D51D 9E B6 0A    STZ $0AB6,x[$7E:0ABE]  ; Speed echo Y position = 0
$90:D520 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:D524 60          RTS
}
}


;;; $D525: Unused ;;;
{
; Looks like this is supposed to make Samus extend and contract her grapple beam in a loop for the duration of [$0A9E]
; No idea what this would hypothetically be used for
; This is the only place where $0CFA and $0CFC aren't mirrors of each other
$90:D525 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:D527 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If pressing shoot: go to BRANCH_HOLDING_SHOOT
$90:D52A D0 07       BNE $07    [$D533]     ;/

; BRANCH_CANCEL
$90:D52C A9 56 C8    LDA #$C856             ;\
$90:D52F 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = cancel
$90:D532 60          RTS                    ; Return

; BRANCH_HOLDING_SHOOT
$90:D533 AD 9E 0A    LDA $0A9E  [$7E:0A9E]  ;\
$90:D536 3A          DEC A                  ;} Decrement [grapple walljump timer]
$90:D537 8D 9E 0A    STA $0A9E  [$7E:0A9E]  ;/
$90:D53A F0 F0       BEQ $F0    [$D52C]     ;\
$90:D53C 30 EE       BMI $EE    [$D52C]     ;} If [grapple walljump timer] <= 0: go to BRANCH_CANCEL
$90:D53E AD 00 0D    LDA $0D00  [$7E:0D00]  ;\
$90:D541 30 30       BMI $30    [$D573]     ;} If [grapple beam length delta] < 0: go to BRANCH_CONTINUE <-- think this branch target is wrong
$90:D543 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$90:D546 18          CLC                    ;|
$90:D547 6D 00 0D    ADC $0D00  [$7E:0D00]  ;} Grapple beam length += [grapple beam length delta]
$90:D54A 8D FE 0C    STA $0CFE  [$7E:0CFE]  ;/
$90:D54D C9 60 00    CMP #$0060             ;\
$90:D550 30 21       BMI $21    [$D573]     ;} If [grapple beam length] < 60h: go to BRANCH_CONTINUE
$90:D552 A9 10 00    LDA #$0010             ;\
$90:D555 49 FF FF    EOR #$FFFF             ;|
$90:D558 1A          INC A                  ;} Grapple beam length delta = -10h
$90:D559 8D 00 0D    STA $0D00  [$7E:0D00]  ;/
$90:D55C 80 15       BRA $15    [$D573]     ; Go to BRANCH_CONTINUE

; Unused branch
$90:D55E AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$90:D561 18          CLC                    ;|
$90:D562 6D 00 0D    ADC $0D00  [$7E:0D00]  ;} Grapple beam length += [grapple beam length delta]
$90:D565 8D FE 0C    STA $0CFE  [$7E:0CFE]  ;/
$90:D568 10 09       BPL $09    [$D573]     ; If [grapple beam length] < 0:
$90:D56A 9C FE 0C    STZ $0CFE  [$7E:0CFE]  ; Grapple beam length = 0
$90:D56D A9 10 00    LDA #$0010             ;\
$90:D570 8D 00 0D    STA $0D00  [$7E:0D00]  ;} Grapple beam length delta = 10h

; BRANCH_CONTINUE
$90:D573 AD FA 0C    LDA $0CFA  [$7E:0CFA]  ;\
$90:D576 EB          XBA                    ;|
$90:D577 29 FF 00    AND #$00FF             ;} Y = [grapple beam end angle / 100h]
$90:D57A A8          TAY                    ;/
$90:D57B AD FE 0C    LDA $0CFE  [$7E:0CFE]  ; A = [grapple beam length]
$90:D57E 20 39 CC    JSR $CC39  [$90:CC39]  ; ($14, $16) = ([A] * sin([Y] * pi / 80h), [A] * -cos([Y] * pi / 80h))
$90:D581 AD 16 0D    LDA $0D16  [$7E:0D16]  ;\
$90:D584 18          CLC                    ;|
$90:D585 65 14       ADC $14    [$7E:0014]  ;} Grapple beam end X position = [grapple beam start X position] + [$14]
$90:D587 8D 08 0D    STA $0D08  [$7E:0D08]  ;/
$90:D58A AD 18 0D    LDA $0D18  [$7E:0D18]  ;\
$90:D58D 18          CLC                    ;|
$90:D58E 65 16       ADC $16    [$7E:0016]  ;} Grapple beam end Y position = [grapple beam start Y position] + [$16]
$90:D590 8D 0C 0D    STA $0D0C  [$7E:0D0C]  ;/
$90:D593 AD FA 0C    LDA $0CFA  [$7E:0CFA]  ;\
$90:D596 18          CLC                    ;|
$90:D597 69 00 08    ADC #$0800             ;} Grapple beam end angle += 800h
$90:D59A 8D FA 0C    STA $0CFA  [$7E:0CFA]  ;/
$90:D59D 22 1B BF 9B JSL $9BBF1B[$9B:BF1B]  ; Update grapple beam start position during grapple fire
$90:D5A1 60          RTS
}


;;; $D5A2..D792: Crystal flash ;;;
{
;;; $D5A2: Crystal flash ;;;
{
;; Returns:
;;     Carry: Clear if succeeded, otherwise set
$90:D5A2 08          PHP
$90:D5A3 C2 30       REP #$30
$90:D5A5 AD 98 09    LDA $0998  [$7E:0998]  ;\
$90:D5A8 C9 28 00    CMP #$0028             ;} If not in demo:
$90:D5AB 10 0E       BPL $0E    [$D5BB]     ;/
$90:D5AD A9 30 04    LDA #$0430             ;\
$90:D5B0 0D B2 09    ORA $09B2  [$7E:09B2]  ;|
$90:D5B3 85 12       STA $12    [$7E:0012]  ;|
$90:D5B5 A5 8B       LDA $8B    [$7E:008B]  ;} If not pressing exactly down + L + R + shoot: return carry set
$90:D5B7 C5 12       CMP $12    [$7E:0012]  ;|
$90:D5B9 D0 2F       BNE $2F    [$D5EA]     ;/

$90:D5BB AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:D5BE D0 2A       BNE $2A    [$D5EA]     ;|
$90:D5C0 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;} If [Samus Y speed] != 0.0: return carry set
$90:D5C3 D0 25       BNE $25    [$D5EA]     ;/
$90:D5C5 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:D5C8 C9 33 00    CMP #$0033             ;} If [Samus health] > 50: return carry set
$90:D5CB 10 1D       BPL $1D    [$D5EA]     ;/
$90:D5CD AD D6 09    LDA $09D6  [$7E:09D6]  ;\
$90:D5D0 D0 18       BNE $18    [$D5EA]     ;} If [Samus reserve tanks] != 0: return carry set
$90:D5D2 AD C6 09    LDA $09C6  [$7E:09C6]  ;\
$90:D5D5 C9 0A 00    CMP #$000A             ;} If [Samus missiles] < 10: return carry set
$90:D5D8 30 10       BMI $10    [$D5EA]     ;/
$90:D5DA AD CA 09    LDA $09CA  [$7E:09CA]  ;\
$90:D5DD C9 0A 00    CMP #$000A             ;} If [Samus super missiles] < 10: return carry set
$90:D5E0 30 08       BMI $08    [$D5EA]     ;/
$90:D5E2 AD CE 09    LDA $09CE  [$7E:09CE]  ;\
$90:D5E5 C9 0A 00    CMP #$000A             ;} If [Samus power bombs] >= 10: go to BRANCH_ACTIVATE
$90:D5E8 10 03       BPL $03    [$D5ED]     ;/

$90:D5EA 28          PLP
$90:D5EB 38          SEC                    ;\
$90:D5EC 6B          RTL                    ;} Return carry set

; BRANCH_ACTIVATE
$90:D5ED AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:D5F0 29 FF 00    AND #$00FF             ;|
$90:D5F3 C9 04 00    CMP #$0004             ;} If facing right:
$90:D5F6 F0 05       BEQ $05    [$D5FD]     ;/
$90:D5F8 A9 D3 00    LDA #$00D3             ; Samus pose = D3h (facing right - crystal flash)
$90:D5FB 80 03       BRA $03    [$D600]
                                            ; Else (facing left):
$90:D5FD A9 D4 00    LDA #$00D4             ; Samus pose = D4h (facing left  - crystal flash)

$90:D600 8D 1C 0A    STA $0A1C  [$7E:0A1C]
$90:D603 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:D607 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:D60B AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:D60E 29 FF 00    AND #$00FF             ;|
$90:D611 C9 1B 00    CMP #$001B             ;} If [Samus movement type] != crystal flash: return
$90:D614 D0 D4       BNE $D4    [$D5EA]     ;/
$90:D616 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$90:D619 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$90:D61C AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$90:D61F 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$90:D622 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:D625 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$90:D628 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:D62B 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:D62E A9 78 D6    LDA #$D678             ;\
$90:D631 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D678 (crystal flash - start)
$90:D634 AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$90:D637 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$90:D63A F0 06       BEQ $06    [$D642]     ;/
$90:D63C A9 0E E9    LDA #$E90E             ;\
$90:D63F 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS

$90:D642 A9 09 00    LDA #$0009             ;\
$90:D645 8D A2 0A    STA $0AA2  [$7E:0AA2]  ;} Crystal flash raise Samus timer = 9
$90:D648 9C EA 0D    STZ $0DEA  [$7E:0DEA]  ; Crystal flash ammo decrementing index = missiles
$90:D64B A9 0A 00    LDA #$000A             ;\
$90:D64E 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} Crystal flash ammo decrementing timer = 10
$90:D651 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ;\
$90:D654 9C F0 0D    STZ $0DF0  [$7E:0DF0]  ;} Pointless writes
$90:D657 9C F2 0D    STZ $0DF2  [$7E:0DF2]  ;/
$90:D65A A9 07 00    LDA #$0007             ;\
$90:D65D 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = 7 (crystal flash)
$90:D660 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; $0ACE = 0
$90:D663 A9 01 00    LDA #$0001             ;\
$90:D666 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 1
$90:D669 8D F2 0D    STA $0DF2  [$7E:0DF2]  ; $0DF2 = 1 (unused)
$90:D66C 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$90:D66F 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knock back timer = 0
$90:D672 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = none
$90:D675 28          PLP
$90:D676 18          CLC                    ;\
$90:D677 6B          RTL                    ;} Return carry clear
}


;;; $D678: Samus movement handler - crystal flash - start (raise Samus and generate bubble) ;;;
{
$90:D678 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D67B 3A          DEC A                  ;|
$90:D67C 3A          DEC A                  ;} Samus Y position -= 2
$90:D67D 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:D680 AD A2 0A    LDA $0AA2  [$7E:0AA2]  ;\
$90:D683 3A          DEC A                  ;} Decrement crystal flash raise Samus timer
$90:D684 8D A2 0A    STA $0AA2  [$7E:0AA2]  ;/
$90:D687 10 44       BPL $44    [$D6CD]     ; If [crystal flash raise Samus timer] >= 0: return
$90:D689 A9 03 00    LDA #$0003             ;\
$90:D68C 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 3
$90:D68F A9 06 00    LDA #$0006             ;\
$90:D692 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 6 (main)
$90:D695 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D698 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;} Crystal flash Samus Y position = [Samus Y position]
$90:D69B A9 CE D6    LDA #$D6CE             ;\
$90:D69E 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D6CE (crystal flash - main)
$90:D6A1 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$90:D6A4 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knock back timer = 0
$90:D6A7 A9 01 00    LDA #$0001             ;\
$90:D6AA 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 15 (silence)
$90:D6AE 9C EE 0C    STZ $0CEE  [$7E:0CEE]  ; Power bomb flag = 0
$90:D6B1 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D6B4 8D E2 0C    STA $0CE2  [$7E:0CE2]  ;} X position of power bomb explosion = [Samus X position]
$90:D6B7 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D6BA 8D E4 0C    STA $0CE4  [$7E:0CE4]  ;} Y position of power bomb explosion = [Samus Y position]
$90:D6BD DA          PHX
$90:D6BE 5A          PHY
$90:D6BF 08          PHP
$90:D6C0 8B          PHB
$90:D6C1 22 88 82 88 JSL $888288[$88:8288]  ; Enable HDMA objects
$90:D6C5 22 A6 A2 88 JSL $88A2A6[$88:A2A6]  ; Spawn crystal flash HDMA objects
$90:D6C9 AB          PLB
$90:D6CA 28          PLP
$90:D6CB 7A          PLY
$90:D6CC FA          PLX

$90:D6CD 60          RTS
}


;;; $D6CE: Samus movement handler - crystal flash - main (decrement ammo) ;;;
{
$90:D6CE AD EA 0D    LDA $0DEA  [$7E:0DEA]  ;\
$90:D6D1 0A          ASL A                  ;|
$90:D6D2 AA          TAX                    ;} Execute [$D6DD + [crystal flash ammo decrementing index] * 2]
$90:D6D3 FC DD D6    JSR ($D6DD,x)          ;/
$90:D6D6 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0 (!)
$90:D6D9 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0
$90:D6DC 60          RTS

$90:D6DD             dw D6E3, D706, D729
}


;;; $D6E3: Crystal flash - decrement missiles ;;;
{
$90:D6E3 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:D6E6 89 07 00    BIT #$0007             ;} If [frame counter] % 8 != 0: return
$90:D6E9 D0 1A       BNE $1A    [$D705]     ;/
$90:D6EB CE C6 09    DEC $09C6  [$7E:09C6]  ; Decrement Samus missiles
$90:D6EE A9 32 00    LDA #$0032             ;\
$90:D6F1 22 12 DF 91 JSL $91DF12[$91:DF12]  ;} Give Samus 50 health
$90:D6F5 CE EC 0D    DEC $0DEC  [$7E:0DEC]  ; Decrement crystal flash ammo decrementing timer
$90:D6F8 F0 02       BEQ $02    [$D6FC]     ;\
$90:D6FA 10 09       BPL $09    [$D705]     ;} If [crystal flash ammo decrementing timer] > 0: return

$90:D6FC A9 0A 00    LDA #$000A             ;\
$90:D6FF 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} Crystal flash ammo decrementing timer = 10
$90:D702 EE EA 0D    INC $0DEA  [$7E:0DEA]  ; Crystal flash ammo decrementing index = super missiles

$90:D705 60          RTS
}


;;; $D706: Crystal flash - decrement super missiles ;;;
{
$90:D706 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:D709 89 07 00    BIT #$0007             ;} If [frame counter] % 8 != 0: return
$90:D70C D0 1A       BNE $1A    [$D728]     ;/
$90:D70E CE CA 09    DEC $09CA  [$7E:09CA]  ; Decrement Samus super missiles
$90:D711 A9 32 00    LDA #$0032             ;\
$90:D714 22 12 DF 91 JSL $91DF12[$91:DF12]  ;} Give Samus 50 health
$90:D718 CE EC 0D    DEC $0DEC  [$7E:0DEC]  ; Decrement crystal flash ammo decrementing timer
$90:D71B F0 02       BEQ $02    [$D71F]     ;\
$90:D71D 10 09       BPL $09    [$D728]     ;} If [crystal flash ammo decrementing timer] > 0: return

$90:D71F A9 0A 00    LDA #$000A             ;\
$90:D722 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;} Crystal flash ammo decrementing timer = 10
$90:D725 EE EA 0D    INC $0DEA  [$7E:0DEA]  ; Crystal flash ammo decrementing index = power bombs

$90:D728 60          RTS
}


;;; $D729: Crystal flash - decrement power bombs ;;;
{
$90:D729 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:D72C 89 07 00    BIT #$0007             ;} If [frame counter] % 8 != 0: return
$90:D72F D0 29       BNE $29    [$D75A]     ;/
$90:D731 CE CE 09    DEC $09CE  [$7E:09CE]  ; Decrement Samus power bombs
$90:D734 A9 32 00    LDA #$0032             ;\
$90:D737 22 12 DF 91 JSL $91DF12[$91:DF12]  ;} Give Samus 50 health
$90:D73B CE EC 0D    DEC $0DEC  [$7E:0DEC]  ; Decrement crystal flash ammo decrementing timer
$90:D73E F0 02       BEQ $02    [$D742]     ;\
$90:D740 10 18       BPL $18    [$D75A]     ;} If [crystal flash ammo decrementing timer] > 0: return

$90:D742 A9 5B D7    LDA #$D75B             ;\
$90:D745 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $D75B (crystal flash - finish)
$90:D748 A9 52 EB    LDA #$EB52             ;\
$90:D74B 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = $EB52 (default)
$90:D74E A9 03 00    LDA #$0003             ;\
$90:D751 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 3
$90:D754 A9 0C 00    LDA #$000C             ;\
$90:D757 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = Ch (finish)

$90:D75A 60          RTS
}


;;; $D75B: Samus movement handler - crystal flash - finish ;;;
{
$90:D75B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D75E CD F0 0D    CMP $0DF0  [$7E:0DF0]  ;} If [Samus Y position] != [Crystal flash Samus Y position]:
$90:D761 F0 04       BEQ $04    [$D767]     ;/
$90:D763 1A          INC A                  ;\
$90:D764 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;} Samus Y position += 1

$90:D767 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:D76A 29 FF 00    AND #$00FF             ;} If [Samus movement type] != standing: return
$90:D76D D0 23       BNE $23    [$D792]     ;/
$90:D76F 9C EE 0C    STZ $0CEE  [$7E:0CEE]  ; Power bomb flag = 0
$90:D772 A9 FF FF    LDA #$FFFF             ;\
$90:D775 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = FFFFh
$90:D778 A9 37 A3    LDA #$A337             ;\
$90:D77B 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:D77E AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$90:D781 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] = $E91D (demo): return
$90:D784 F0 0C       BEQ $0C    [$D792]     ;/
$90:D786 A9 13 E9    LDA #$E913             ;\
$90:D789 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$90:D78C 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$90:D78F 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knock back timer = 0

$90:D792 60          RTS
}
}


;;; $D793..DDE8: Projectiles ;;;
{
;;; $D793: Projectile pre-instruction - plasma SBA ;;;
{
;; Parameters:
;;     X: Projectile index
$90:D793 BD 04 0C    LDA $0C04,x[$7E:0C0A]  ;\
$90:D796 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:D799 F0 05       BEQ $05    [$D7A0]     ;/
$90:D79B 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:D79F 60          RTS                    ; Return

$90:D7A0 A9 02 00    LDA #$0002             ;\
$90:D7A3 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 2
$90:D7A6 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:D7A9 BD 7C 0C    LDA $0C7C,x[$7E:0C82]  ;\
$90:D7AC A8          TAY                    ;} Y = [projectile angle]
$90:D7AD BD DC 0B    LDA $0BDC,x[$7E:0BE2]  ; A = [projectile distance]
$90:D7B0 20 39 CC    JSR $CC39  [$90:CC39]  ; ($14, $16) = ([A] * sin([Y] * pi / 80h), [A] * -cos([Y] * pi / 80h))
$90:D7B3 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D7B6 18          CLC                    ;|
$90:D7B7 65 14       ADC $14    [$7E:0014]  ;} Projectile X position = [Samus X position] + [$14]
$90:D7B9 9D 64 0B    STA $0B64,x[$7E:0B6A]  ;/
$90:D7BC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D7BF 18          CLC                    ;|
$90:D7C0 65 16       ADC $16    [$7E:0016]  ;} Projectile Y position = [Samus Y position] + [$16]
$90:D7C2 9D 78 0B    STA $0B78,x[$7E:0B7E]  ;/
$90:D7C5 BD 7C 0C    LDA $0C7C,x[$7E:0C82]  ;\
$90:D7C8 18          CLC                    ;|
$90:D7C9 6D 60 0B    ADC $0B60  [$7E:0B60]  ;} Projectile angle = ([projectile angle] + [SBA angle delta]) % 100h
$90:D7CC 29 FF 00    AND #$00FF             ;|
$90:D7CF 9D 7C 0C    STA $0C7C,x[$7E:0C82]  ;/
$90:D7D2 9B          TXY                    ; Y = [X]
$90:D7D3 BD F0 0B    LDA $0BF0,x[$7E:0BF6]  ;\
$90:D7D6 0A          ASL A                  ;|
$90:D7D7 AA          TAX                    ;} Go to [$D7DB + [projectile phase] * 2]
$90:D7D8 7C DB D7    JMP ($D7DB,x)[$90:D7E1];/

$90:D7DB             dw D7E1, D7FA, D813
}


;;; $D7E1: Plasma SBA - phase 0: expanding ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:D7E1 B9 DC 0B    LDA $0BDC,y[$7E:0BE2]  ;\
$90:D7E4 18          CLC                    ;|
$90:D7E5 69 04 00    ADC #$0004             ;} Projectile distance = ([projectile distance] + 4) % 100h
$90:D7E8 29 FF 00    AND #$00FF             ;|
$90:D7EB 99 DC 0B    STA $0BDC,y[$7E:0BE2]  ;/
$90:D7EE C9 C0 00    CMP #$00C0             ;\
$90:D7F1 30 06       BMI $06    [$D7F9]     ;} If [projectile distance] >= C0h:
$90:D7F3 A9 01 00    LDA #$0001             ;\
$90:D7F6 99 F0 0B    STA $0BF0,y[$7E:0BF6]  ;} Projectile phase = 1

$90:D7F9 60          RTS
}


;;; $D7FA: Plasma SBA - phase 1: contracting ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:D7FA B9 DC 0B    LDA $0BDC,y[$7E:0BE2]  ;\
$90:D7FD 38          SEC                    ;|
$90:D7FE E9 04 00    SBC #$0004             ;} Projectile distance = ([projectile distance] - 4) % 100h
$90:D801 29 FF 00    AND #$00FF             ;|
$90:D804 99 DC 0B    STA $0BDC,y[$7E:0BE2]  ;/
$90:D807 C9 2D 00    CMP #$002D             ;\
$90:D80A 10 06       BPL $06    [$D812]     ;} If [projectile distance] < 2Dh:
$90:D80C A9 02 00    LDA #$0002             ;\
$90:D80F 99 F0 0B    STA $0BF0,y[$7E:0BF6]  ;} Projectile phase = 2

$90:D812 60          RTS
}


;;; $D813: Plasma SBA - phase 2: dispersing ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:D813 B9 64 0B    LDA $0B64,y[$7E:0B6A]  ;\
$90:D816 38          SEC                    ;|
$90:D817 ED 11 09    SBC $0911  [$7E:0911]  ;|
$90:D81A C9 E0 FF    CMP #$FFE0             ;} If -20h <= [projectile X position] - [layer 1 X position] < 120h:
$90:D81D 30 24       BMI $24    [$D843]     ;|
$90:D81F C9 20 01    CMP #$0120             ;|
$90:D822 10 1F       BPL $1F    [$D843]     ;/
$90:D824 B9 78 0B    LDA $0B78,y[$7E:0B7E]  ;\
$90:D827 38          SEC                    ;|
$90:D828 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:D82B C9 10 00    CMP #$0010             ;} If 10h <= [projectile Y position] - [layer 1 Y position] < 100h:
$90:D82E 30 13       BMI $13    [$D843]     ;|
$90:D830 C9 00 01    CMP #$0100             ;|
$90:D833 10 0E       BPL $0E    [$D843]     ;/
$90:D835 B9 DC 0B    LDA $0BDC,y[$7E:0BE2]  ;\
$90:D838 18          CLC                    ;|
$90:D839 69 04 00    ADC #$0004             ;} Projectile distance = ([projectile distance] + 4) % 100h
$90:D83C 29 FF 00    AND #$00FF             ;|
$90:D83F 99 DC 0B    STA $0BDC,y[$7E:0BE2]  ;/
$90:D842 60          RTS                    ; Return

$90:D843 BB          TYX                    ; X = [Y]
$90:D844 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:D848 60          RTS
}


;;; $D849: Bomb spread ;;;
{
$90:D849 AD 72 0C    LDA $0C72  [$7E:0C72]  ;\
$90:D84C C9 F7 D8    CMP #$D8F7             ;} If [main bomb pre-instruction] = $D8F7:
$90:D84F D0 02       BNE $02    [$D853]     ;/
$90:D851 18          CLC
$90:D852 60          RTS                    ; Return

$90:D853 A2 0A 00    LDX #$000A             ; X = Ah (projectile index)

; LOOP
$90:D856 A9 00 85    LDA #$8500             ;\
$90:D859 9D 18 0C    STA $0C18,x            ;} Bomb type = bomb, don't interact with Samus
$90:D85C 9E 04 0C    STZ $0C04,x            ; Bomb direction = 0
$90:D85F A9 F7 D8    LDA #$D8F7             ;\
$90:D862 9D 68 0C    STA $0C68,x            ;} Bomb pre-instruction = $D8F7
$90:D865 22 A0 80 93 JSL $9380A0[$93:80A0]  ; Initialise bomb
$90:D869 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:D86C 9D 64 0B    STA $0B64,x            ;} Bomb X position = [Samus X position]
$90:D86F 9E 8C 0B    STZ $0B8C,x            ; Bomb X subposition = 0
$90:D872 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:D875 9D 78 0B    STA $0B78,x            ;} Bomb Y position = [Samus Y position]
$90:D878 9E A0 0B    STZ $0BA0,x            ; Bomb Y subposition = 0
$90:D87B 8A          TXA                    ;\
$90:D87C 38          SEC                    ;|
$90:D87D E9 0A 00    SBC #$000A             ;} Y = [X] - Ah
$90:D880 A8          TAY                    ;/
$90:D881 B9 D9 D8    LDA $D8D9,y            ;\
$90:D884 9D DC 0B    STA $0BDC,x            ;} Bomb X velocity = [$D8D9 + [Y]]
$90:D887 B9 ED D8    LDA $D8ED,y            ;\
$90:D88A 9D 90 0C    STA $0C90,x            ;} Bomb Y subvelocity = [$D8ED + [Y]]
$90:D88D AD D4 0C    LDA $0CD4  [$7E:0CD4]  ;\
$90:D890 0A          ASL A                  ;|
$90:D891 0A          ASL A                  ;|
$90:D892 EB          XBA                    ;|
$90:D893 29 03 00    AND #$0003             ;|
$90:D896 18          CLC                    ;} Bomb Y velocity = -([$D8E3 + [Y]] + [bomb spread charge timeout counter] / 40h % 4)
$90:D897 79 E3 D8    ADC $D8E3,y            ;|
$90:D89A 49 FF FF    EOR #$FFFF             ;|
$90:D89D 1A          INC A                  ;|
$90:D89E 9D F0 0B    STA $0BF0,x            ;/
$90:D8A1 9D A4 0C    STA $0CA4,x            ; Bomb bounce Y velocity = [bomb Y velocity]
$90:D8A4 B9 CF D8    LDA $D8CF,y            ;\
$90:D8A7 9D 7C 0C    STA $0C7C,x            ;} Bomb timer = [$D8CF + [Y]]
$90:D8AA E8          INX                    ;\
$90:D8AB E8          INX                    ;} X += 2
$90:D8AC E0 14 00    CPX #$0014             ;\
$90:D8AF 30 A5       BMI $A5    [$D856]     ;} If [X] < 14h: go to LOOP
$90:D8B1 A9 05 00    LDA #$0005             ;\
$90:D8B4 8D D2 0C    STA $0CD2  [$7E:0CD2]  ;} Bomb counter = 5
$90:D8B7 AD 22 0C    LDA $0C22  [$7E:0C22]  ;\
$90:D8BA EB          XBA                    ;|
$90:D8BB 29 0F 00    AND #$000F             ;|
$90:D8BE A8          TAY                    ;} Cooldown timer = [$C27A + (main bomb projectile type)]
$90:D8BF B9 7A C2    LDA $C27A,y            ;|
$90:D8C2 29 FF 00    AND #$00FF             ;|
$90:D8C5 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;/
$90:D8C8 9C D4 0C    STZ $0CD4  [$7E:0CD4]  ; Bomb spread charge timeout counter = 0
$90:D8CB 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:D8CE 60          RTS
}


;;; $D8CF: Bomb spread data ;;;
{
$90:D8CF             dw 0078, 006E, 0064, 006E, 0078 ; Bomb timers
$90:D8D9             dw 8100, 8080, 0000, 0080, 0100 ; Bomb X velocities. Unit 1/100h px/frame. MSb = direction, set = left, clear = right
$90:D8E3             dw 0000, 0001, 0002, 0001, 0000 ; Bomb Y speeds
$90:D8ED             dw 0000, 0000, 8000, 0000, 0000 ; Bomb Y subspeeds
}


;;; $D8F7: Projectile pre-instruction - spread bomb ;;;
{
;; Parameters:
;;     X: Projectile index
$90:D8F7 BD 04 0C    LDA $0C04,x            ;\
$90:D8FA 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:D8FD F0 05       BEQ $05    [$D904]     ;/
$90:D8FF 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:D903 60          RTS                    ; Return

$90:D904 20 28 C1    JSR $C128  [$90:C128]  ; Handle bomb
$90:D907 BD 7C 0C    LDA $0C7C,x            ;\
$90:D90A D0 03       BNE $03    [$D90F]     ;} If [bomb timer] = 0:
$90:D90C 4C B7 D9    JMP $D9B7  [$90:D9B7]  ; Go to BRANCH_MOVEMENT_DONE

$90:D90F BD 90 0C    LDA $0C90,x            ;\
$90:D912 18          CLC                    ;|
$90:D913 6D 32 0B    ADC $0B32  [$7E:0B32]  ;|
$90:D916 9D 90 0C    STA $0C90,x            ;} Bomb Y velocity += [Samus Y acceleration]
$90:D919 BD F0 0B    LDA $0BF0,x            ;|
$90:D91C 6D 34 0B    ADC $0B34  [$7E:0B34]  ;|
$90:D91F 9D F0 0B    STA $0BF0,x            ;/
$90:D922 BD A0 0B    LDA $0BA0,x            ;\
$90:D925 18          CLC                    ;|
$90:D926 7D 90 0C    ADC $0C90,x            ;|
$90:D929 9D A0 0B    STA $0BA0,x            ;} Bomb Y position += [bomb Y velocity]
$90:D92C BD 78 0B    LDA $0B78,x            ;|
$90:D92F 7D F0 0B    ADC $0BF0,x            ;|
$90:D932 9D 78 0B    STA $0B78,x            ;/
$90:D935 22 21 A6 94 JSL $94A621[$94:A621]  ; Spread bomb block collision detection
$90:D939 90 39       BCC $39    [$D974]     ; If no collision detected: go to BRANCH_FALLING
$90:D93B AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:D93E 8A          TXA                    ;\
$90:D93F 38          SEC                    ;|
$90:D940 E9 0A 00    SBC #$000A             ;} Y = [X] - Ah
$90:D943 A8          TAY                    ;/
$90:D944 BD A0 0B    LDA $0BA0,x            ;\
$90:D947 38          SEC                    ;|
$90:D948 FD 90 0C    SBC $0C90,x            ;|
$90:D94B 9D A0 0B    STA $0BA0,x            ;} Bomb Y position -= [bomb Y velocity]
$90:D94E BD 78 0B    LDA $0B78,x            ;|
$90:D951 FD F0 0B    SBC $0BF0,x            ;|
$90:D954 9D 78 0B    STA $0B78,x            ;/
$90:D957 BD F0 0B    LDA $0BF0,x            ;\
$90:D95A 30 0F       BMI $0F    [$D96B]     ;} If [bomb Y velocity] >= 0:
$90:D95C B9 ED D8    LDA $D8ED,y            ;\
$90:D95F 9D 90 0C    STA $0C90,x            ;} Bomb Y subvelocity = [$D8ED + [Y]]
$90:D962 BD A4 0C    LDA $0CA4,x            ;\
$90:D965 9D F0 0B    STA $0BF0,x            ;} Bomb Y velocity = [bomb bounce Y velocity]
$90:D968 4C 07 DA    JMP $DA07  [$90:DA07]  ; Return

$90:D96B 9E F0 0B    STZ $0BF0,x            ; Bomb Y velocity = 0
$90:D96E 9E C8 0B    STZ $0BC8,x            ; Bomb Y radius = 0
$90:D971 4C 07 DA    JMP $DA07  [$90:DA07]  ; Return

; BRANCH_FALLING
$90:D974 AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:D977 BD DC 0B    LDA $0BDC,x            ;\
$90:D97A EB          XBA                    ;|
$90:D97B 48          PHA                    ;|
$90:D97C 29 00 FF    AND #$FF00             ;|
$90:D97F 85 14       STA $14    [$7E:0014]  ;} $12.$14 = [bomb X velocity] / 100h
$90:D981 68          PLA                    ;|
$90:D982 29 FF 00    AND #$00FF             ;|
$90:D985 85 12       STA $12    [$7E:0012]  ;/
$90:D987 89 80 00    BIT #$0080             ;\
$90:D98A F0 07       BEQ $07    [$D993]     ;} If [$12] & 80h != 0:
$90:D98C 29 7F FF    AND #$FF7F             ;\
$90:D98F 85 12       STA $12    [$7E:0012]  ;} $12 &= ~80h
$90:D991 80 13       BRA $13    [$D9A6]     ; Go to BRANCH_LEFT

$90:D993 BD 8C 0B    LDA $0B8C,x            ;\
$90:D996 18          CLC                    ;|
$90:D997 65 14       ADC $14    [$7E:0014]  ;|
$90:D999 9D 8C 0B    STA $0B8C,x            ;} Bomb X position += [$12].[$14]
$90:D99C BD 64 0B    LDA $0B64,x            ;|
$90:D99F 65 12       ADC $12    [$7E:0012]  ;|
$90:D9A1 9D 64 0B    STA $0B64,x            ;/
$90:D9A4 80 11       BRA $11    [$D9B7]     ; Go to BRANCH_MOVEMENT_DONE

; BRANCH_LEFT
$90:D9A6 BD 8C 0B    LDA $0B8C,x            ;\
$90:D9A9 38          SEC                    ;|
$90:D9AA E5 14       SBC $14    [$7E:0014]  ;|
$90:D9AC 9D 8C 0B    STA $0B8C,x            ;} Bomb X position -= [$12].[$14]
$90:D9AF BD 64 0B    LDA $0B64,x            ;|
$90:D9B2 E5 12       SBC $12    [$7E:0012]  ;|
$90:D9B4 9D 64 0B    STA $0B64,x            ;/

; BRANCH_MOVEMENT_DONE
$90:D9B7 22 21 A6 94 JSL $94A621[$94:A621]  ; Spread bomb block collision detection
$90:D9BB 90 4A       BCC $4A    [$DA07]     ; If no collision: return
$90:D9BD AE DE 0D    LDX $0DDE  [$7E:0DDE]
$90:D9C0 BD DC 0B    LDA $0BDC,x            ;\
$90:D9C3 48          PHA                    ;|
$90:D9C4 EB          XBA                    ;|
$90:D9C5 48          PHA                    ;|
$90:D9C6 29 00 FF    AND #$FF00             ;} $12.$14 = ([bomb X velocity] & ~8000h) / 100h
$90:D9C9 85 14       STA $14    [$7E:0014]  ;|
$90:D9CB 68          PLA                    ;|
$90:D9CC 29 7F 00    AND #$007F             ;|
$90:D9CF 85 12       STA $12    [$7E:0012]  ;/
$90:D9D1 68          PLA                    ;\
$90:D9D2 89 00 80    BIT #$8000             ;} If [bomb X velocity] & 8000h != 0:
$90:D9D5 F0 19       BEQ $19    [$D9F0]     ;/
$90:D9D7 29 FF 7F    AND #$7FFF             ;\
$90:D9DA 9D DC 0B    STA $0BDC,x            ;} Bomb X velocity &= ~8000h
$90:D9DD BD 8C 0B    LDA $0B8C,x            ;\
$90:D9E0 18          CLC                    ;|
$90:D9E1 65 14       ADC $14    [$7E:0014]  ;|
$90:D9E3 9D 8C 0B    STA $0B8C,x            ;} Bomb X position += [$12].[$14]
$90:D9E6 BD 64 0B    LDA $0B64,x            ;|
$90:D9E9 65 12       ADC $12    [$7E:0012]  ;|
$90:D9EB 9D 64 0B    STA $0B64,x            ;/
$90:D9EE 80 17       BRA $17    [$DA07]

$90:D9F0 09 00 80    ORA #$8000             ;\ Else ([bomb X velocity] & 8000h = 0):
$90:D9F3 9D DC 0B    STA $0BDC,x            ;} Bomb X velocity |= 8000h
$90:D9F6 BD 8C 0B    LDA $0B8C,x            ;\
$90:D9F9 38          SEC                    ;|
$90:D9FA E5 14       SBC $14    [$7E:0014]  ;|
$90:D9FC 9D 8C 0B    STA $0B8C,x            ;} Bomb X position -= [$12].[$14]
$90:D9FF BD 64 0B    LDA $0B64,x            ;|
$90:DA02 E5 12       SBC $12    [$7E:0012]  ;|
$90:DA04 9D 64 0B    STA $0B64,x            ;/

$90:DA07 60          RTS
}


;;; $DA08: Projectile pre-instruction - wave SBA ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DA08 BD 04 0C    LDA $0C04,x            ;\
$90:DA0B 89 F0 00    BIT #$00F0             ;} If projectile is not deleted:
$90:DA0E D0 07       BNE $07    [$DA17]     ;/
$90:DA10 DE F0 0B    DEC $0BF0,x            ; Decrement projectile SBA timer
$90:DA13 F0 02       BEQ $02    [$DA17]     ;\
$90:DA15 10 0C       BPL $0C    [$DA23]     ;} If [projectile SBA timer] > 0: go to BRANCH_ALIVE

$90:DA17 A9 29 00    LDA #$0029             ;\
$90:DA1A 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 29h, sound library 1, max queued sounds allowed = 6 (wave SBA end)
$90:DA1E 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DA22 60          RTS                    ; Return

; BRANCH_ALIVE
$90:DA23 BD DC 0B    LDA $0BDC,x            ;\
$90:DA26 85 22       STA $22    [$7E:0022]  ;} $22 = [projectile X velocity] (old projectile X velocity)
$90:DA28 BD 7C 0C    LDA $0C7C,x            ;\
$90:DA2B 85 24       STA $24    [$7E:0024]  ;} $24 = [projectile Y velocity] (old projectile Y velocity)
$90:DA2D DE 90 0C    DEC $0C90,x            ; Decrement projectile trail timer
$90:DA30 D0 0D       BNE $0D    [$DA3F]     ; If [projectile trail timer] = 0:
$90:DA32 A9 04 00    LDA #$0004             ;\
$90:DA35 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:DA38 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:DA3C AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:DA3F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:DA42 DD 64 0B    CMP $0B64,x            ;} If [Samus X position] >= [projectile X position]:
$90:DA45 30 11       BMI $11    [$DA58]     ;/
$90:DA47 BD DC 0B    LDA $0BDC,x            ;\
$90:DA4A C9 00 08    CMP #$0800             ;} If [projectile X velocity] < 800h:
$90:DA4D 10 18       BPL $18    [$DA67]     ;/
$90:DA4F 18          CLC                    ;\
$90:DA50 69 40 00    ADC #$0040             ;} Projectile X velocity += 40h
$90:DA53 9D DC 0B    STA $0BDC,x            ;/
$90:DA56 80 0F       BRA $0F    [$DA67]

$90:DA58 BD DC 0B    LDA $0BDC,x            ;\ Else ([Samus X position] < [projectile X position]):
$90:DA5B C9 01 F8    CMP #$F801             ;} If [projectile X velocity] > -800h:
$90:DA5E 30 07       BMI $07    [$DA67]     ;/
$90:DA60 38          SEC                    ;\
$90:DA61 E9 40 00    SBC #$0040             ;} Projectile X velocity -= 40h
$90:DA64 9D DC 0B    STA $0BDC,x            ;/

$90:DA67 BD DC 0B    LDA $0BDC,x            ;\
$90:DA6A EB          XBA                    ;|
$90:DA6B 48          PHA                    ;|
$90:DA6C 29 00 FF    AND #$FF00             ;|
$90:DA6F 85 14       STA $14    [$7E:0014]  ;|
$90:DA71 68          PLA                    ;|
$90:DA72 29 FF 00    AND #$00FF             ;} $12.$14 = ±[projectile X velocity] * 100h
$90:DA75 89 80 00    BIT #$0080             ;|
$90:DA78 F0 03       BEQ $03    [$DA7D]     ;|
$90:DA7A 09 00 FF    ORA #$FF00             ;|
                                            ;|
$90:DA7D 85 12       STA $12    [$7E:0012]  ;/
$90:DA7F BD 8C 0B    LDA $0B8C,x            ;\
$90:DA82 18          CLC                    ;|
$90:DA83 65 14       ADC $14    [$7E:0014]  ;|
$90:DA85 9D 8C 0B    STA $0B8C,x            ;} Projectile X position += [$12].[$14]
$90:DA88 BD 64 0B    LDA $0B64,x            ;|
$90:DA8B 65 12       ADC $12    [$7E:0012]  ;|
$90:DA8D 9D 64 0B    STA $0B64,x            ;/
$90:DA90 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:DA93 DD 78 0B    CMP $0B78,x            ;} If [Samus Y position] >= [projectile Y position]:
$90:DA96 30 11       BMI $11    [$DAA9]     ;/
$90:DA98 BD 7C 0C    LDA $0C7C,x            ;\
$90:DA9B C9 00 08    CMP #$0800             ;} If [projectile Y velocity] < 800h:
$90:DA9E 10 18       BPL $18    [$DAB8]     ;/
$90:DAA0 18          CLC                    ;\
$90:DAA1 69 40 00    ADC #$0040             ;} Projectile Y velocity += 40h
$90:DAA4 9D 7C 0C    STA $0C7C,x            ;/
$90:DAA7 80 0F       BRA $0F    [$DAB8]

$90:DAA9 BD 7C 0C    LDA $0C7C,x            ;\ Else ([Samus Y position] < [projectile Y position]):
$90:DAAC C9 01 F8    CMP #$F801             ;} If [projectile Y velocity] > -800h:
$90:DAAF 30 07       BMI $07    [$DAB8]     ;/
$90:DAB1 38          SEC                    ;\
$90:DAB2 E9 40 00    SBC #$0040             ;} Projectile Y velocity -= 40h
$90:DAB5 9D 7C 0C    STA $0C7C,x            ;/

$90:DAB8 BD 7C 0C    LDA $0C7C,x            ;\
$90:DABB EB          XBA                    ;|
$90:DABC 48          PHA                    ;|
$90:DABD 29 00 FF    AND #$FF00             ;|
$90:DAC0 85 14       STA $14    [$7E:0014]  ;|
$90:DAC2 68          PLA                    ;|
$90:DAC3 29 FF 00    AND #$00FF             ;} $12.$14 = ±[projectile Y velocity] * 100h
$90:DAC6 89 80 00    BIT #$0080             ;|
$90:DAC9 F0 03       BEQ $03    [$DACE]     ;|
$90:DACB 09 00 FF    ORA #$FF00             ;|
                                            ;|
$90:DACE 85 12       STA $12    [$7E:0012]  ;/
$90:DAD0 BD A0 0B    LDA $0BA0,x            ;\
$90:DAD3 18          CLC                    ;|
$90:DAD4 65 14       ADC $14    [$7E:0014]  ;|
$90:DAD6 9D A0 0B    STA $0BA0,x            ;} Projectile Y position += [$12].[$14]
$90:DAD9 BD 78 0B    LDA $0B78,x            ;|
$90:DADC 65 12       ADC $12    [$7E:0012]  ;|
$90:DADE 9D 78 0B    STA $0B78,x            ;/
$90:DAE1 E0 06 00    CPX #$0006             ;\
$90:DAE4 D0 16       BNE $16    [$DAFC]     ;} If [X] != 6: go to BRANCH_RETURN
$90:DAE6 BD DC 0B    LDA $0BDC,x            ;\
$90:DAE9 30 06       BMI $06    [$DAF1]     ;} If [projectile X velocity] >= 0:
$90:DAEB A5 22       LDA $22    [$7E:0022]  ;\
$90:DAED 10 0D       BPL $0D    [$DAFC]     ;} If (old projectile X velocity) >= 0: go to BRANCH_RETURN
$90:DAEF 80 04       BRA $04    [$DAF5]

$90:DAF1 A5 22       LDA $22    [$7E:0022]  ;\ Else ([projectile X velocity] < 0):
$90:DAF3 30 07       BMI $07    [$DAFC]     ;} If (old projectile X velocity) < 0: go to BRANCH_RETURN

$90:DAF5 A9 28 00    LDA #$0028             ;\
$90:DAF8 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 28h, sound library 1, max queued sounds allowed = 6 (wave SBA)

; BRANCH_RETURN
$90:DAFC A9 02 00    LDA #$0002             ;\
$90:DAFF 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 2
$90:DB02 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:DB05 60          RTS
}


;;; $DB06: Projectile pre-instruction - spazer SBA ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DB06 BD 04 0C    LDA $0C04,x            ;\
$90:DB09 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:DB0C F0 04       BEQ $04    [$DB12]     ;/
$90:DB0E FC 4F DB    JSR ($DB4F,x)          ; Execute [$DB4F + [X]]
$90:DB11 60          RTS                    ; Return

$90:DB12 DE 90 0C    DEC $0C90,x            ; Decrement projectile trail timer
$90:DB15 D0 0D       BNE $0D    [$DB24]     ; If [projectile trail timer] = 0:
$90:DB17 A9 04 00    LDA #$0004             ;\
$90:DB1A 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:DB1D 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:DB21 AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:DB24 BD 7C 0C    LDA $0C7C,x            ;\
$90:DB27 A8          TAY                    ;} Y = [projectile angle]
$90:DB28 BD DC 0B    LDA $0BDC,x            ; A = [projectile distance]
$90:DB2B 20 39 CC    JSR $CC39  [$90:CC39]  ; ($14, $16) = ([A] * sin([Y] * pi / 80h), [A] * -cos([Y] * pi / 80h))
$90:DB2E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:DB31 18          CLC                    ;|
$90:DB32 65 14       ADC $14    [$7E:0014]  ;} Projectile X position = [Samus X position] + [$14]
$90:DB34 9D 64 0B    STA $0B64,x            ;/
$90:DB37 9B          TXY                    ; Y = [X]
$90:DB38 BD A4 0C    LDA $0CA4,x            ;\
$90:DB3B AA          TAX                    ;} Execute [$DB49 + [projectile phase]]
$90:DB3C FC 49 DB    JSR ($DB49,x)          ;/
$90:DB3F A9 02 00    LDA #$0002             ;\
$90:DB42 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 2
$90:DB45 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:DB48 60          RTS

$90:DB49             dw DB93, DBCF, DC30

; Projectile clearing subroutines
$90:DB4F             dw DB57, DB66, DB75, DB84
}


;;; $DB57: Clear spazer SBA projectile pair - projectile index 0 ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DB57 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DB5B A2 04 00    LDX #$0004             ;\
$90:DB5E 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear projectile 4
$90:DB62 A2 00 00    LDX #$0000             ;/
$90:DB65 60          RTS
}


;;; $DB66: Clear spazer SBA projectile pair - projectile index 2 ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DB66 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DB6A A2 06 00    LDX #$0006             ;\
$90:DB6D 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear projectile 6
$90:DB71 A2 02 00    LDX #$0002             ;/
$90:DB74 60          RTS
}


;;; $DB75: Clear spazer SBA projectile pair - projectile index 4 ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DB75 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DB79 A2 00 00    LDX #$0000             ;\
$90:DB7C 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear projectile 0
$90:DB80 A2 04 00    LDX #$0004             ;/
$90:DB83 60          RTS
}


;;; $DB84: Clear spazer SBA projectile pair - projectile index 6 ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DB84 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DB88 A2 02 00    LDX #$0002             ;\
$90:DB8B 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ;} Clear projectile 2
$90:DB8F A2 06 00    LDX #$0006             ;/
$90:DB92 60          RTS
}


;;; $DB93: Spazer SBA - phase 0: circling ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:DB93 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:DB96 18          CLC                    ;|
$90:DB97 65 16       ADC $16    [$7E:0016]  ;} Projectile Y position = [Samus Y position] + [$16]
$90:DB99 99 78 0B    STA $0B78,y            ;/
$90:DB9C B9 7C 0C    LDA $0C7C,y            ;\
$90:DB9F 18          CLC                    ;|
$90:DBA0 79 F0 0B    ADC $0BF0,y            ;} Projectile angle = ([projectile angle] + [projectile angle delta]) % 100h
$90:DBA3 29 FF 00    AND #$00FF             ;|
$90:DBA6 99 7C 0C    STA $0C7C,y            ;/
$90:DBA9 C9 80 00    CMP #$0080             ;\
$90:DBAC D0 18       BNE $18    [$DBC6]     ;} If [projectile angle] = 80h:
$90:DBAE A9 A0 00    LDA #$00A0             ;\
$90:DBB1 99 DC 0B    STA $0BDC,y            ;} Projectile distance = A0h
$90:DBB4 B9 C7 DB    LDA $DBC7,y            ;\
$90:DBB7 99 F0 0B    STA $0BF0,y            ;} Projectile angle delta = [$DBC7 + [Y]]
$90:DBBA A9 00 00    LDA #$0000             ;\
$90:DBBD 99 04 0C    STA $0C04,y            ;} Projectile direction = 0 (up, facing right)
$90:DBC0 A9 02 00    LDA #$0002             ;\
$90:DBC3 99 A4 0C    STA $0CA4,y            ;} Projectile phase = 2

$90:DBC6 60          RTS

$90:DBC7             dw 0002, FFFE, 0002, FFFE
}


;;; $DBCF: Spazer SBA - phase 2: flying up towards point ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:DBCF AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:DBD2 38          SEC                    ;|
$90:DBD3 E9 72 00    SBC #$0072             ;|
$90:DBD6 18          CLC                    ;} Projectile Y position = [Samus Y position] - 72h + [$16]
$90:DBD7 65 16       ADC $16    [$7E:0016]  ;|
$90:DBD9 99 78 0B    STA $0B78,y            ;/
$90:DBDC 38          SEC                    ;\
$90:DBDD ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:DBE0 C9 10 00    CMP #$0010             ;} If [projectile Y position] - [layer 1 Y position] < 10h:
$90:DBE3 10 04       BPL $04    [$DBE9]     ;/
$90:DBE5 20 67 DC    JSR $DC67  [$90:DC67]  ; Fire end of spazer SBA
$90:DBE8 60          RTS                    ; Return

$90:DBE9 B9 7C 0C    LDA $0C7C,y            ;\
$90:DBEC 18          CLC                    ;|
$90:DBED 79 F0 0B    ADC $0BF0,y            ;} Projectile angle = ([projectile angle] + [projectile angle delta]) % 100h
$90:DBF0 29 FF 00    AND #$00FF             ;|
$90:DBF3 99 7C 0C    STA $0C7C,y            ;/
$90:DBF6 B9 DC 0B    LDA $0BDC,y            ;\
$90:DBF9 38          SEC                    ;|
$90:DBFA E9 05 00    SBC #$0005             ;} Projectile distance -= 5
$90:DBFD 99 DC 0B    STA $0BDC,y            ;/
$90:DC00 D0 25       BNE $25    [$DC27]     ; If [projectile distance] = 0:
$90:DC02 B9 28 DC    LDA $DC28,y            ;\
$90:DC05 99 F0 0B    STA $0BF0,y            ;} Projectile angle delta = [$DC28 + [Y]]
$90:DC08 B9 7C 0C    LDA $0C7C,y            ;\
$90:DC0B 18          CLC                    ;|
$90:DC0C 69 80 00    ADC #$0080             ;} Projectile angle = ([projectile angle] + 80h) % 100h
$90:DC0F 29 FF 00    AND #$00FF             ;|
$90:DC12 99 7C 0C    STA $0C7C,y            ;/
$90:DC15 A9 04 00    LDA #$0004             ;\
$90:DC18 99 A4 0C    STA $0CA4,y            ;} Projectile phase = 4
$90:DC1B C0 00 00    CPY #$0000             ;\
$90:DC1E D0 07       BNE $07    [$DC27]     ;} If [Y] = 0:
$90:DC20 A9 26 00    LDA #$0026             ;\
$90:DC23 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 26h, sound library 1, max queued sounds allowed = 6 (spazer SBA end)

$90:DC27 60          RTS

$90:DC28             dw FFFE, 0002, FFFE, 0002
}


;;; $DC30: Spazer SBA - phase 4: flying up away from point ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:DC30 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:DC33 38          SEC                    ;|
$90:DC34 E9 72 00    SBC #$0072             ;|
$90:DC37 18          CLC                    ;} Projectile Y position = [Samus Y position] - 72h + [$16]
$90:DC38 65 16       ADC $16    [$7E:0016]  ;|
$90:DC3A 99 78 0B    STA $0B78,y            ;/
$90:DC3D 38          SEC                    ;\
$90:DC3E ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:DC41 C9 10 00    CMP #$0010             ;} If [projectile Y position] - [layer 1 Y position] >= 10h: BRANCH_ON_SCREEN
$90:DC44 10 04       BPL $04    [$DC4A]     ;/

; BRANCH_FIRE_SBA_END
$90:DC46 20 67 DC    JSR $DC67  [$90:DC67]  ; Fire end of spazer SBA
$90:DC49 60          RTS                    ; Return

; BRANCH_ON_SCREEN
$90:DC4A B9 7C 0C    LDA $0C7C,y            ;\
$90:DC4D 18          CLC                    ;|
$90:DC4E 79 F0 0B    ADC $0BF0,y            ;} Projectile angle = ([projectile angle] + [projectile angle delta]) % 100h
$90:DC51 29 FF 00    AND #$00FF             ;|
$90:DC54 99 7C 0C    STA $0C7C,y            ;/
$90:DC57 B9 DC 0B    LDA $0BDC,y            ;\
$90:DC5A 18          CLC                    ;|
$90:DC5B 69 05 00    ADC #$0005             ;} Projectile distance += 5
$90:DC5E 99 DC 0B    STA $0BDC,y            ;/
$90:DC61 C9 60 00    CMP #$0060             ;\
$90:DC64 10 E0       BPL $E0    [$DC46]     ;} If [projectile distance] >= 60h: go to BRANCH_FIRE_SBA_END
$90:DC66 60          RTS
}


;;; $DC67: Fire end of spazer SBA ;;;
{
;; Parameters:
;;     Y: Projectile index
$90:DC67 B9 64 0B    LDA $0B64,y            ;\
$90:DC6A 18          CLC                    ;|
$90:DC6B 79 94 DC    ADC $DC94,y            ;} Projectile X position += [$DC94 + [Y]]
$90:DC6E 99 64 0B    STA $0B64,y            ;/
$90:DC71 A9 05 00    LDA #$0005             ;\
$90:DC74 99 04 0C    STA $0C04,y            ;} Projectile direction = 5 (down, facing left)
$90:DC77 A9 04 00    LDA #$0004             ;\
$90:DC7A 99 90 0C    STA $0C90,y            ;} Projectile trail timer = 4
$90:DC7D A9 9C DC    LDA #$DC9C             ;\
$90:DC80 99 68 0C    STA $0C68,y            ;} Projectile pre-instruction = $DC9C
$90:DC83 C0 04 00    CPY #$0004             ;\
$90:DC86 10 0B       BPL $0B    [$DC93]     ;} If [Y] < 4:
$90:DC88 A9 24 80    LDA #$8024             ;\
$90:DC8B 99 18 0C    STA $0C18,y            ;} Projectile type = 8024h
$90:DC8E BB          TYX                    ; X = [Y]
$90:DC8F 22 63 81 93 JSL $938163[$93:8163]  ; Initialise spazer SBA trail projectile

$90:DC93 60          RTS

$90:DC94             dw 0010, 0010, FFF0, FFF0
}


;;; $DC9C: Projectile pre-instruction - end of spazer SBA ;;;
{
;; Parameters:
;;     X: Projectile index
$90:DC9C BD 04 0C    LDA $0C04,x            ;\
$90:DC9F 29 F0 00    AND #$00F0             ;} If projectile is deleted:
$90:DCA2 F0 05       BEQ $05    [$DCA9]     ;/
$90:DCA4 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DCA8 60          RTS                    ; Return

$90:DCA9 DE 90 0C    DEC $0C90,x            ; Decrement projectile trail timer
$90:DCAC D0 0D       BNE $0D    [$DCBB]     ; If [projectile trail timer] = 0:
$90:DCAE A9 04 00    LDA #$0004             ;\
$90:DCB1 9D 90 0C    STA $0C90,x            ;} Projectile trail timer = 4
$90:DCB4 22 57 B6 90 JSL $90B657[$90:B657]  ; Spawn projectile trail
$90:DCB8 AE DE 0D    LDX $0DDE  [$7E:0DDE]

$90:DCBB BD 78 0B    LDA $0B78,x            ;\
$90:DCBE 18          CLC                    ;|
$90:DCBF 69 08 00    ADC #$0008             ;} Projectile Y position = [Samus Y position] + 8
$90:DCC2 9D 78 0B    STA $0B78,x            ;/
$90:DCC5 38          SEC                    ;\
$90:DCC6 ED 15 09    SBC $0915  [$7E:0915]  ;|
$90:DCC9 C9 F8 00    CMP #$00F8             ;} If [projectile Y position] - [layer 1 Y position] >= F8h:
$90:DCCC 30 05       BMI $05    [$DCD3]     ;/
$90:DCCE 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:DCD2 60          RTS                    ; Return

$90:DCD3 A9 02 00    LDA #$0002             ;\
$90:DCD6 8D CC 0C    STA $0CCC  [$7E:0CCC]  ;} Cooldown timer = 2
$90:DCD9 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:DCDC 60          RTS
}


;;; $DCDD: Handle HUD specific behaviour and projectiles ;;;
{
$90:DCDD 08          PHP
$90:DCDE C2 30       REP #$30
$90:DCE0 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:DCE3 F0 1B       BEQ $1B    [$DD00]     ;|
$90:DCE5 C9 9B 00    CMP #$009B             ;} If Samus is not facing forward:
$90:DCE8 F0 16       BEQ $16    [$DD00]     ;/
$90:DCEA 20 1C AC    JSR $AC1C  [$90:AC1C]  ; Handle Samus cooldown
$90:DCED 20 B5 C4    JSR $C4B5  [$90:C4B5]  ; Handle switching HUD selection
$90:DCF0 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:DCF3 29 FF 00    AND #$00FF             ;|
$90:DCF6 0A          ASL A                  ;} Execute [$DD05 + [Samus movement type] * 2] (HUD selection handler)
$90:DCF7 AA          TAX                    ;|
$90:DCF8 FC 05 DD    JSR ($DD05,x)[$90:DD3D];/
$90:DCFB AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:DCFE D0 03       BNE $03    [$DD03]     ;} If time is frozen: return

$90:DD00 20 CE AE    JSR $AECE  [$90:AECE]  ; Handle current projectiles/bombs

$90:DD03 28          PLP
$90:DD04 60          RTS

$90:DD05             dw DD3D, ; 0: Standing
                        DD3D, ; 1: Running
                        DD3D, ; 2: Normal jumping
                        DDB6, ; 3: Spin jumping
                        BF9D, ; 4: Morph ball - on ground
                        DD3D, ; 5: Crouching
                        DD3D, ; 6: Falling
                        BF9D, ; 7: Unused. Glitchy morph ball / spin jump
                        BF9D, ; 8: Morph ball - falling
                        BF9D, ; 9: Unused
                        DDB6, ; Ah: Knockback / crystal flash ending
                        DD6F, ; Bh: Unused
                        DD6F, ; Ch: Unused
                        DDB6, ; Dh: Unused
                        DD74, ; Eh: Turning around - on ground
                        DD8C, ; Fh: Crouching/standing/morphing/unmorphing transition
                        DD3D, ; 10h: Moonwalking
                        BF9D, ; 11h: Spring ball - on ground
                        BF9D, ; 12h: Spring ball - in air
                        BF9D, ; 13h: Spring ball - falling
                        DDB6, ; 14h: Wall jumping
                        DD3D, ; 15h: Ran into a wall
                        DD6F, ; 16h: Grappling
                        DD74, ; 17h: Turning around - jumping
                        DD74, ; 18h: Turning around - falling
                        DDB6, ; 19h: Damage boost
                        DDD8, ; 1Ah: Grabbed by Draygon
                        DDB6  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $DD3D: Standard HUD selection handler ;;;
{
; Standing, running, normal jumping, crouching, falling, moon walking, ran into a wall
$90:DD3D 08          PHP
$90:DD3E C2 30       REP #$30
$90:DD40 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:DD43 C9 F0 C4    CMP #$C4F0             ;} If fired grapple beam:
$90:DD46 F0 05       BEQ $05    [$DD4D]     ;/
$90:DD48 A2 08 00    LDX #$0008             ;\
$90:DD4B 80 0F       BRA $0F    [$DD5C]     ;} Execute grapple handler

$90:DD4D AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:DD50 F0 05       BEQ $05    [$DD57]     ;} If time is frozen:
$90:DD52 A2 0A 00    LDX #$000A             ;\
$90:DD55 80 05       BRA $05    [$DD5C]     ;} Execute x-ray handler

$90:DD57 AD D2 09    LDA $09D2  [$7E:09D2]  ;\
$90:DD5A 0A          ASL A                  ;} Execute handler for current HUD selection
$90:DD5B AA          TAX                    ;/

$90:DD5C FC 61 DD    JSR ($DD61,x)[$90:BE62]
$90:DD5F 28          PLP
$90:DD60 60          RTS

$90:DD61             dw B80D, ; Nothing
                        BE62, ; Missiles
                        BE62, ; Super missiles
                        B80D, ; Power bombs
                        DD6F, ; Grapple
                        DDC8, ; X-ray
                        DD74  ; HUD selection handler for turning, looks like a mistake, would cause stack overflow if Samus shoots in the air, can't be indexed anyway
}


;;; $DD6F: HUD selection handler - grappling ;;;
{
$90:DD6F 22 90 C4 9B JSL $9BC490[$9B:C490]  ; Grapple beam handler
$90:DD73 60          RTS
}


;;; $DD74: HUD selection handler - turning around ;;;
{
$90:DD74 AD 5E 0B    LDA $0B5E  [$7E:0B5E]  ;\
$90:DD77 F0 04       BEQ $04    [$DD7D]     ;} If [pose transition shot direction] != 0:
$90:DD79 20 3D DD    JSR $DD3D  [$90:DD3D]  ; Standard HUD selection handler
$90:DD7C 60          RTS                    ; Return

$90:DD7D AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:DD80 C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] != inactive:
$90:DD83 F0 06       BEQ $06    [$DD8B]     ;/
$90:DD85 A9 56 C8    LDA #$C856             ;\
$90:DD88 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Cancel grapple beam

$90:DD8B 60          RTS
}


;;; $DD8C: HUD selection handler - crouching/standing/morphing/unmorphing transition ;;;
{
$90:DD8C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:DD8F C9 F1 00    CMP #$00F1             ;} If not aiming whilst transitioning:
$90:DD92 10 12       BPL $12    [$DDA6]     ;/
$90:DD94 C9 DB 00    CMP #$00DB             ;\
$90:DD97 10 10       BPL $10    [$DDA9]     ;} If [Samus pose] >= DBh (not sure what this is supposed to be guarding): return
$90:DD99 38          SEC                    ;\
$90:DD9A E9 35 00    SBC #$0035             ;|
$90:DD9D AA          TAX                    ;|
$90:DD9E BD AA DD    LDA $DDAA,x[$90:DDAA]  ;} If not crouching/standing transition: go to HUD selection handler - cancel grapple
$90:DDA1 29 FF 00    AND #$00FF             ;|
$90:DDA4 D0 10       BNE $10    [$DDB6]     ;/

$90:DDA6 20 3D DD    JSR $DD3D  [$90:DD3D]  ; Standard HUD selection handler

$90:DDA9 60          RTS

$90:DDAA             db 00, ; Facing right - crouching transition
                        00, ; Facing left  - crouching transition
                        01, ; Facing right - morphing transition
                        01, ; Facing left  - morphing transition
                        01, ; Unused
                        01, ; Unused
                        00, ; Facing right - standing transition
                        00, ; Facing left  - standing transition
                        01, ; Facing right - unmorphing transition
                        01, ; Facing left  - unmorphing transition
                        01, ; Unused
                        01  ; Unused
}


;;; $DDB6: HUD selection handler - cancel grapple (spin jumping / wall jumping / knockback / damage boosting / shinespark / crystal flash / drained by metroid / damaged by MB's attacks) ;;;
{
$90:DDB6 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:DDB9 C9 F0 C4    CMP #$C4F0             ;} If [grapple handler] = inactive: return
$90:DDBC F0 09       BEQ $09    [$DDC7]     ;/
$90:DDBE A9 56 C8    LDA #$C856             ;\
$90:DDC1 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Cancel grapple beam
$90:DDC4 20 3D DD    JSR $DD3D  [$90:DD3D]  ; Standard HUD selection handler

$90:DDC7 60          RTS
}


;;; $DDC8: HUD selection handler - x-ray ;;;
{
$90:DDC8 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:DDCA 2C B6 09    BIT $09B6  [$7E:09B6]  ;} If not holding run:
$90:DDCD D0 04       BNE $04    [$DDD3]     ;/
$90:DDCF 20 0D B8    JSR $B80D  [$90:B80D]  ; HUD selection handler - nothing / power bombs
$90:DDD2 60          RTS                    ; Return

$90:DDD3 22 D6 CA 91 JSL $91CAD6[$91:CAD6]  ; Execute x-ray handler
$90:DDD7 60          RTS
}


;;; $DDD8: HUD selection handler - grabbed by Draygon ;;;
{
$90:DDD8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:DDDB C9 DF 00    CMP #$00DF             ;} If [Samus pose] != DFh (unused?):
$90:DDDE F0 05       BEQ $05    [$DDE5]     ;/
$90:DDE0 20 3D DD    JSR $DD3D  [$90:DD3D]  ; Standard HUD selection handler
$90:DDE3 80 03       BRA $03    [$DDE8]
                                            ; Else ([Samus pose] = DFh):
$90:DDE5 20 9D BF    JSR $BF9D  [$90:BF9D]  ; HUD selection handler - morph ball

$90:DDE8 60          RTS
}
}


;;; $DDE9..DF98: Knockback ;;;
{
;;; $DDE9: Samus is hit interruption ;;;
{
; Called by "active" $0A44 handlers (where active = normal or title/intro demo)
; Checks for knockback start, knockback finish, and bomb jump
; The pose written to $0A2C is ignored, it just needs to be a positive value (per $0A32 = 1 branch of $91:EB88)
; This is why Samus can land immediately when knockback finishes and not need to fall for a frame first
$90:DDE9 08          PHP
$90:DDEA C2 30       REP #$30
$90:DDEC AD AA 18    LDA $18AA  [$7E:18AA]  ;\
$90:DDEF F0 2F       BEQ $2F    [$DE20]     ;} If [Samus knockback timer] = 0: go to BRANCH_KNOCKBACK_TIMER_ZERO
$90:DDF1 AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$90:DDF4 C9 07 00    CMP #$0007             ;} If debug invincibility enabled:
$90:DDF7 30 08       BMI $08    [$DE01]     ;/
$90:DDF9 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$90:DDFC 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0
$90:DDFF 80 1D       BRA $1D    [$DE1E]     ; Return

$90:DE01 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:DE04 D0 18       BNE $18    [$DE1E]     ;} If time is frozen: return
$90:DE06 AD 52 0A    LDA $0A52  [$7E:0A52]  ;\
$90:DE09 D0 13       BNE $13    [$DE1E]     ;} If [knockback direction] = none:
$90:DE0B AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:DE0E 29 FF 00    AND #$00FF             ;|
$90:DE11 0A          ASL A                  ;} Execute [$DE82 + [Samus movement type] * 2]
$90:DE12 AA          TAX                    ;|
$90:DE13 FC 82 DE    JSR ($DE82,x)[$90:DEFA];/
$90:DE16 90 06       BCC $06    [$DE1E]     ; If carry set (start knockback):
$90:DE18 A9 01 00    LDA #$0001             ;\
$90:DE1B 8D 30 0A    STA $0A30  [$7E:0A30]  ;} Special prospective pose change command = start knockback

$90:DE1E 28          PLP
$90:DE1F 60          RTS                    ; Return

; BRANCH_KNOCKBACK_TIMER_ZERO
$90:DE20 AD 52 0A    LDA $0A52  [$7E:0A52]  ;\
$90:DE23 F0 53       BEQ $53    [$DE78]     ;} If [knockback direction] = none: go to BRANCH_NO_KNOCKBACK
$90:DE25 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:DE28 29 FF 00    AND #$00FF             ;|
$90:DE2B C9 0A 00    CMP #$000A             ;} If [Samus movement type] = knockback / crystal flash ending: go to BRANCH_KNOCKBACK_MOVEMENT
$90:DE2E F0 18       BEQ $18    [$DE48]     ;/
$90:DE30 AD 32 0A    LDA $0A32  [$7E:0A32]  ;\
$90:DE33 C9 03 00    CMP #$0003             ;} If [super special prospective pose change command] = transition animation finished:
$90:DE36 D0 08       BNE $08    [$DE40]     ;/
$90:DE38 A9 08 00    LDA #$0008             ;\
$90:DE3B 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = knockback and transition animation both finished
$90:DE3E 28          PLP
$90:DE3F 60          RTS                    ; Return

$90:DE40 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:DE43 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;} Super special prospective pose = [Samus pose]
$90:DE46 80 28       BRA $28    [$DE70]     ; Go to BRANCH_KNOCKBACK_FINISHED

; BRANCH_KNOCKBACK_MOVEMENT
$90:DE48 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:DE4B C9 10 00    CMP #$0010             ;} If [flare counter] >= 10h:
$90:DE4E 30 07       BMI $07    [$DE57]     ;/
$90:DE50 A9 41 00    LDA #$0041             ;\
$90:DE53 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 41h, sound library 1, max queued sounds allowed = 5 (resume charging beam)

$90:DE57 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:DE5A 29 FF 00    AND #$00FF             ;|
$90:DE5D C9 04 00    CMP #$0004             ;} If facing right:
$90:DE60 F0 08       BEQ $08    [$DE6A]     ;/
$90:DE62 A9 29 00    LDA #$0029             ;\
$90:DE65 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;} Super special prospective pose = facing right - falling
$90:DE68 80 06       BRA $06    [$DE70]

$90:DE6A A9 2A 00    LDA #$002A             ;\ Else (facing left):
$90:DE6D 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ;} Super special prospective pose = facing left - falling

; BRANCH_KNOCKBACK_FINISHED
$90:DE70 A9 01 00    LDA #$0001             ;\
$90:DE73 8D 32 0A    STA $0A32  [$7E:0A32]  ;} Super special prospective pose change command = knockback finished
$90:DE76 28          PLP
$90:DE77 60          RTS                    ; Return

; BRANCH_NO_KNOCKBACK
$90:DE78 AD 56 0A    LDA $0A56  [$7E:0A56]  ;\
$90:DE7B F0 03       BEQ $03    [$DE80]     ;} If [bomb jump direction] != 0:
$90:DE7D 20 99 DF    JSR $DF99  [$90:DF99]  ; Set up bomb jump

$90:DE80 28          PLP
$90:DE81 60          RTS

$90:DE82             dw DEFA, ; 0: Standing
                        DEFA, ; 1: Running
                        DEFA, ; 2: Normal jumping
                        DEFA, ; 3: Spin jumping
                        DF15, ; 4: Morph ball - on ground
                        DEFA, ; 5: Crouching
                        DEEA, ; 6: Falling
                        DF1D, ; 7: Unused
                        DF15, ; 8: Morph ball - falling
                        DF15, ; 9: Unused
                        DEDD, ; Ah: Knockback / crystal flash ending
                        DEE2, ; Bh: Unused
                        DEE2, ; Ch: Unused
                        DEFA, ; Dh: Unused
                        DEE2, ; Eh: Turning around - on ground
                        DEE2, ; Fh: Crouching/standing/morphing/unmorphing transition
                        DEFA, ; 10h: Moonwalking
                        DF15, ; 11h: Spring ball - on ground
                        DF15, ; 12h: Spring ball - in air
                        DF15, ; 13h: Spring ball - falling
                        DEFA, ; 14h: Wall jumping
                        DEFA, ; 15h: Ran into a wall
                        DEDD, ; 16h: Grappling
                        DEE2, ; 17h: Turning around - jumping
                        DEE2, ; 18h: Turning around - falling
                        DEE2, ; 19h: Damage boost
                        DEE2, ; 1Ah: Grabbed by Draygon
                        DEBA  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $DEBA: Knockback transition - set Samus drained hurt animation or ignore ;;;
{
;; Returns:
;;     Carry: Clear. Ignore knockback

; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks

; This routine checks for pose E8h, but the facing right version doesn't support these non-idle animations
$90:DEBA AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:DEBD C9 E8 00    CMP #$00E8             ;|
$90:DEC0 F0 07       BEQ $07    [$DEC9]     ;} If [Samus pose] != Samus drained - crouching/falling:
$90:DEC2 C9 E9 00    CMP #$00E9             ;|
$90:DEC5 F0 02       BEQ $02    [$DEC9]     ;/
$90:DEC7 80 0C       BRA $0C    [$DED5]     ; Go to BRANCH_RETURN

$90:DEC9 A9 11 00    LDA #$0011             ;\
$90:DECC 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 11h
$90:DECF A9 1A 00    LDA #$001A             ;\
$90:DED2 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 1Ah (Samus gets hit)

; BRANCH_RETURN
$90:DED5 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:DED8 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = 0
$90:DEDB 18          CLC                    ;\
$90:DEDC 60          RTS                    ;} Return carry clear
}


;;; $DEDD: Knockback transition - ignore ;;;
{
;; Returns:
;;     Carry: Clear. Ignore knockback

; Ah: Knockback / crystal flash ending
; 16h: Grappling
$90:DEDD 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:DEE0 18          CLC                    ;\
$90:DEE1 60          RTS                    ;} Return carry clear
}


;;; $DEE2: Knockback transition - ignore ;;;
{
;; Returns:
;;     Carry: Clear. Ignore knockback

; Bh: Unused
; Ch: Unused
; Eh: Turning around - on ground
; Fh: Crouching/standing/morphing/unmorphing transition
; 17h: Turning around - jumping
; 18h: Turning around - falling
; 19h: Damage boost
; 1Ah: Grabbed by Draygon

$90:DEE2 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:DEE5 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = none
$90:DEE8 18          CLC                    ;\
$90:DEE9 60          RTS                    ;} Return carry clear
}


;;; $DEEA: Knockback transition - normal ;;;
{
;; Returns:
;;     Carry: Set to start knockback, clear to ignore

; 6: Falling
$90:DEEA AD 5A 0A    LDA $0A5A  [$7E:0A5A]  ;\
$90:DEED C9 1B E4    CMP #$E41B             ;} If [timer / Samus hack handler] = $E41B (unused):
$90:DEF0 D0 08       BNE $08    [$DEFA]     ;/
$90:DEF2 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:DEF5 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = 0
$90:DEF8 18          CLC                    ;\
$90:DEF9 60          RTS                    ;} Return carry clear
}


;;; $DEFA: Knockback transition - normal ;;;
{
;; Returns:
;;     Carry: Set. Start knockback

; 0: Standing
; 1: Running
; 2: Normal jumping
; 3: Spin jumping
; 5: Crouching
; Dh: Unused
; 10h: Moonwalking
; 14h: Wall jumping
; 15h: Ran into a wall

$90:DEFA AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:DEFD 29 FF 00    AND #$00FF             ;|
$90:DF00 C9 04 00    CMP #$0004             ;} If facing right:
$90:DF03 F0 08       BEQ $08    [$DF0D]     ;/
$90:DF05 A9 53 00    LDA #$0053             ;\
$90:DF08 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - knockback
$90:DF0B 80 06       BRA $06    [$DF13]

$90:DF0D A9 54 00    LDA #$0054             ;\ Else (facing left):
$90:DF10 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - knockback

$90:DF13 38          SEC                    ;\
$90:DF14 60          RTS                    ;} Return carry set
}


;;; $DF15: Knockback transition - morphed ;;;
{
;; Returns:
;;     Carry: Set. Start knockback

; 4: Morph ball - on ground
; 8: Morph ball - falling
; 9: Unused
; 11h: Spring ball - on ground
; 12h: Spring ball - in air
; 13h: Spring ball - falling

$90:DF15 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:DF18 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = [Samus pose]
$90:DF1B 38          SEC                    ;\
$90:DF1C 60          RTS                    ;} Return carry set
}


;;; $DF1D: Knockback transition - movement type 7 ;;;
{
;; Returns:
;;     Carry: Set. Start knockback

; 7: Unused

$90:DF1D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:DF20 29 FF 00    AND #$00FF             ;|
$90:DF23 C9 04 00    CMP #$0004             ;} If facing right:
$90:DF26 F0 08       BEQ $08    [$DF30]     ;/
$90:DF28 A9 33 00    LDA #$0033             ;\
$90:DF2B 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = 33h (unused)
$90:DF2E 80 06       BRA $06    [$DF36]

$90:DF30 A9 34 00    LDA #$0034             ;\ Else (facing left):
$90:DF33 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = 34h (unused)

$90:DF36 38          SEC                    ;\
$90:DF37 60          RTS                    ;} Return carry set
}


;;; $DF38: Samus movement handler - knockback ;;;
{
$90:DF38 AD 52 0A    LDA $0A52  [$7E:0A52]  ;\
$90:DF3B 0A          ASL A                  ;|
$90:DF3C AA          TAX                    ;} Execute [$DF44 + [knockback direction] * 2]
$90:DF3D FC 44 DF    JSR ($DF44,x)[$90:DF53];/
$90:DF40 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:DF43 60          RTS

$90:DF44             dw DF50, ; 0: Crashes
                        DF53, ; 1: Up left
                        DF53, ; 2: Up right
                        DF5D, ; 3: Straight up (unused)
                        DF64, ; 4: Down left
                        DF64  ; 5: Down right
}


;;; $DF50: Crash ;;;
{
$90:DF50 80 FE       BRA $FE    [$DF50]
$90:DF52 60          RTS
}


;;; $DF53: Knockback movement - up ;;;
{
$90:DF53 20 DF 8E    JSR $8EDF  [$90:8EDF]  ; Move Samus horizontally - knockback or bomb jump
$90:DF56 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:DF59 20 6E DF    JSR $DF6E  [$90:DF6E]  ; Handle knockback vertical collision
$90:DF5C 60          RTS
}


;;; $DF5D: Knockback movement - straight up (unused) ;;;
{
$90:DF5D 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:DF60 20 6E DF    JSR $DF6E  [$90:DF6E]  ; Handle knockback vertical collision
$90:DF63 60          RTS
}


;;; $DF64: Knockback movement - down ;;;
{
$90:DF64 20 DF 8E    JSR $8EDF  [$90:8EDF]  ; Move Samus horizontally - knockback or bomb jump
$90:DF67 20 3F 92    JSR $923F  [$90:923F]  ; Samus Y movement - no speed calculations
$90:DF6A 20 6E DF    JSR $DF6E  [$90:DF6E]  ; Handle knockback vertical collision
$90:DF6D 60          RTS
}


;;; $DF6E: Handle knockback vertical collision ;;;
{
; Called by Ceres to end pushing
$90:DF6E AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:DF71 F0 25       BEQ $25    [$DF98]     ;} If solid collision:
$90:DF73 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:DF76 9C CE 0D    STZ $0DCE  [$7E:0DCE]  ; Samus X speed killed flag = 0
$90:DF79 9C 22 0B    STZ $0B22  [$7E:0B22]  ; Samus is falling flag = 0
$90:DF7C 9C 1A 0B    STZ $0B1A  [$7E:0B1A]  ; $0B1A = 0 (never read)
$90:DF7F 9C 2A 0B    STZ $0B2A  [$7E:0B2A]  ; $0B2A = 0 (never read)
$90:DF82 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:DF85 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:DF88 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$90:DF8B 9C 38 0B    STZ $0B38  [$7E:0B38]  ; $0B38 = 0 (never read)
$90:DF8E 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:DF91 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:DF94 22 7E EC 90 JSL $90EC7E[$90:EC7E]  ; Align Samus bottom position with previous pose

$90:DF98 60          RTS
}
}


;;; $DF99..E094: Bomb jump ;;;
{
;;; $DF99: Set up bomb jump ;;;
{
$90:DF99 AD 56 0A    LDA $0A56  [$7E:0A56]  ;\
$90:DF9C 89 00 FF    BIT #$FF00             ;} If bomb jump active: return
$90:DF9F D0 13       BNE $13    [$DFB4]     ;/
$90:DFA1 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:DFA4 29 FF 00    AND #$00FF             ;|
$90:DFA7 0A          ASL A                  ;} Execute [$DFB5 + [Samus movement type] * 2]
$90:DFA8 AA          TAX                    ;|
$90:DFA9 FC B5 DF    JSR ($DFB5,x)[$90:E012];/
$90:DFAC 90 06       BCC $06    [$DFB4]     ; If carry set (bomb jump is enabled):
$90:DFAE A9 03 00    LDA #$0003             ;\
$90:DFB1 8D 30 0A    STA $0A30  [$7E:0A30]  ;} Special prospective pose change command = start bomb jump

$90:DFB4 60          RTS

$90:DFB5             dw DFED, ; 0: Standing
                        DFF7, ; 1: Running
                        E01A, ; 2: Normal jumping
                        E01A, ; 3: Spin jumping
                        E012, ; 4: Morph ball - on ground
                        DFED, ; 5: Crouching
                        DFF7, ; 6: Falling
                        E012, ; 7: Unused
                        E012, ; 8: Morph ball - falling
                        E012, ; 9: Unused
                        E012, ; Ah: Knockback / crystal flash ending
                        DFF7, ; Bh: Unused
                        DFF7, ; Ch: Unused
                        DFF7, ; Dh: Unused
                        E01A, ; Eh: Turning around - on ground
                        E01A, ; Fh: Crouching/standing/morphing/unmorphing transition
                        DFF7, ; 10h: Moonwalking
                        E012, ; 11h: Spring ball - on ground
                        E012, ; 12h: Spring ball - in air
                        E012, ; 13h: Spring ball - falling
                        DFF7, ; 14h: Wall jumping
                        DFF7, ; 15h: Ran into a wall
                        DFF7, ; 16h: Grappling
                        E01A, ; 17h: Turning around - jumping
                        E01A, ; 18h: Turning around - falling
                        E01A, ; 19h: Damage boost
                        E020, ; 1Ah: Grabbed by Draygon
                        E020  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $DFED: Set up bomb jump - standing / crouching ;;;
{
;; Returns:
;;     Carry: Set if bomb jump enabled, otherwise clear
$90:DFED AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:DFF0 F0 05       BEQ $05    [$DFF7]     ;} If time is frozen:
$90:DFF2 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = 0
$90:DFF5 18          CLC                    ;\
$90:DFF6 60          RTS                    ;} Return carry clear
}


;;; $DFF7: Set up bomb jump - running / falling / moonwalking / wall jumping / ran into a wall / grappling ;;;
{
;; Returns:
;;     Carry: Set. Bomb jump enabled
$90:DFF7 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:DFFA 29 FF 00    AND #$00FF             ;|
$90:DFFD C9 04 00    CMP #$0004             ;} If facing right:
$90:E000 F0 08       BEQ $08    [$E00A]     ;/
$90:E002 A9 51 00    LDA #$0051             ;\
$90:E005 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - normal jump - not aiming - moving forward
$90:E008 80 06       BRA $06    [$E010]

$90:E00A A9 52 00    LDA #$0052             ;\ Else (facing left):
$90:E00D 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - normal jump - not aiming - moving forward

$90:E010 38          SEC                    ;\
$90:E011 60          RTS                    ;} Return carry set
}


;;; $E012: Set up bomb jump - morphed / knockback / crystal flash ending ;;;
{
;; Returns:
;;     Carry: Set. Bomb jump enabled
$90:E012 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:E015 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = [Samus pose]
$90:E018 38          SEC                    ;\
$90:E019 60          RTS                    ;} Return carry set
}


;;; $E01A: Set up bomb jump - jumping / turning around / damage boost / crouching/standing/morphing/unmorphing transition ;;;
{
;; Returns:
;;     Carry: Clear. Bomb jump not enabled
$90:E01A A9 13 E9    LDA #$E913             ;\
$90:E01D 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
}


;;; $E020: Set up bomb jump - grabbed by Draygon / shinespark / crystal flash / drained by metroid / damaged by MB's attacks ;;;
{
;; Returns:
;;     Carry: Clear. Bomb jump not enabled
$90:E020 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = 0
$90:E023 18          CLC                    ;\
$90:E024 60          RTS                    ;} Return carry clear
}


;;; $E025: Samus movement handler - bomb jump - start ;;;
{
$90:E025 20 2C 9A    JSR $9A2C  [$90:9A2C]  ; Make Samus bomb jump
$90:E028 A9 32 E0    LDA #$E032             ;\
$90:E02B 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $E032 (bomb jump - main)
$90:E02E 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:E031 60          RTS
}


;;; $E032: Samus movement handler - bomb jump - main ;;;
{
$90:E032 AD 56 0A    LDA $0A56  [$7E:0A56]  ;\
$90:E035 D0 04       BNE $04    [$E03B]     ;} If [bomb jump direction] = none:
$90:E037 20 7D E0    JSR $E07D  [$90:E07D]  ; End bomb jump
$90:E03A 60          RTS                    ; Return

$90:E03B 29 FF 00    AND #$00FF             ;\
$90:E03E 0A          ASL A                  ;|
$90:E03F AA          TAX                    ;} Execute [$E044 + [bomb jump direction] * 2]
$90:E040 FC 44 E0    JSR ($E044,x)[$90:E066];/
$90:E043 60          RTS

$90:E044             dw DF50, ; 0: Crashes
                        E04C, ; 1: Left
                        E066, ; 2: Straight
                        E04C  ; 3: Right
}


;;; $E04C: Samus movement handler - bomb jump - main - horizontal ;;;
{
$90:E04C 20 DF 8E    JSR $8EDF  [$90:8EDF]  ; Move Samus horizontally - knockback or bomb jump
$90:E04F 20 1B 8F    JSR $8F1B  [$90:8F1B]  ; Handle end of bomb jump
$90:E052 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:E055 C9 02 00    CMP #$0002             ;} If [Samus Y direction] != down:
$90:E058 F0 08       BEQ $08    [$E062]     ;/
$90:E05A 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:E05D AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E060 F0 03       BEQ $03    [$E065]     ;} If no solid collision: return

$90:E062 20 7D E0    JSR $E07D  [$90:E07D]  ; End bomb jump

$90:E065 60          RTS
}


;;; $E066: Samus movement handler - bomb jump - main - straight ;;;
{
$90:E066 20 1B 8F    JSR $8F1B  [$90:8F1B]  ; Handle end of bomb jump
$90:E069 AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$90:E06C C9 02 00    CMP #$0002             ;} If [Samus Y direction] != down:
$90:E06F F0 08       BEQ $08    [$E079]     ;/
$90:E071 20 E2 90    JSR $90E2  [$90:90E2]  ; Samus Y movement - with speed calculations
$90:E074 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E077 F0 03       BEQ $03    [$E07C]     ;} If no solid collision: return

$90:E079 20 7D E0    JSR $E07D  [$90:E07D]  ; End bomb jump

$90:E07C 60          RTS
}


;;; $E07D: End bomb jump ;;;
{
$90:E07D A9 37 A3    LDA #$A337             ;\
$90:E080 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:E083 AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$90:E086 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$90:E089 F0 06       BEQ $06    [$E091]     ;/
$90:E08B A9 13 E9    LDA #$E913             ;\
$90:E08E 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)

$90:E091 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = none
$90:E094 60          RTS
}
}


;;; $E095: Draygon-escape button counter target ;;;
{
$90:E095             dw 003C
}


;;; $E097..E463: Timer / Samus hack handler ;;;
{
;;; $E097: Timer / Samus hack handler ;;;
{
$90:E097 6C 5A 0A    JMP ($0A5A)[$90:E0E6]  ; Go to [timer / Samus hack handler]
}


;;; $E09A: RTS ;;;
{
$90:E09A 60          RTS
}


;;; $E09B: Timer / Samus hack handler - handle letting Samus up from being drained ;;;
{
$90:E09B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:E09E C9 E9 00    CMP #$00E9             ;} If [Samus pose] != E9h (facing left - Samus drained - crouching): return
$90:E0A1 D0 21       BNE $21    [$E0C4]     ;/
$90:E0A3 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:E0A6 C9 08 00    CMP #$0008             ;} If [Samus animation frame] < 8 (falling / transition to crouching): return
$90:E0A9 30 19       BMI $19    [$E0C4]     ;/
$90:E0AB A5 8F       LDA $8F    [$7E:008F]  ;\
$90:E0AD 89 00 08    BIT #$0800             ;} If not newly pressing up: return
$90:E0B0 F0 12       BEQ $12    [$E0C4]     ;/
$90:E0B2 A9 01 00    LDA #$0001             ;\
$90:E0B5 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$90:E0B8 A9 0D 00    LDA #$000D             ;\
$90:E0BB 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = Eh - 1 (Samus is let up)
$90:E0BE A9 0E E9    LDA #$E90E             ;\
$90:E0C1 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS

$90:E0C4 60          RTS
}


;;; $E0C5: Timer / Samus hack handler - handle letting Samus fail to stand up from being drained ;;;
{
$90:E0C5 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:E0C8 C9 08 00    CMP #$0008             ;} If [Samus animation frame] < 8: return
$90:E0CB 30 18       BMI $18    [$E0E5]     ;/
$90:E0CD C9 0C 00    CMP #$000C             ;\
$90:E0D0 10 13       BPL $13    [$E0E5]     ;} If [Samus animation frame] >= Ch: return
$90:E0D2 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:E0D4 89 00 08    BIT #$0800             ;} If not newly pressing up: return
$90:E0D7 F0 0C       BEQ $0C    [$E0E5]     ;/
$90:E0D9 A9 01 00    LDA #$0001             ;\
$90:E0DC 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$90:E0DF A9 12 00    LDA #$0012             ;\
$90:E0E2 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 13h - 1 (Samus fails to stand up)

$90:E0E5 60          RTS
}


;;; $E0E6: Timer / Samus hack handler - handle timer ;;;
{
$90:E0E6 22 E7 9D 80 JSL $809DE7[$80:9DE7]  ; Process timer
$90:E0EA 90 1E       BCC $1E    [$E10A]     ; If timer hasn't reached zero: go to BRANCH_NOT_ZERO
$90:E0EC A9 23 00    LDA #$0023             ;\
$90:E0EF 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 23h (time up)
$90:E0F2 A2 FE 01    LDX #$01FE             ;\
$90:E0F5 A9 FF 7F    LDA #$7FFF             ;|
                                            ;|
$90:E0F8 9F 00 C2 7E STA $7EC200,x          ;} Target palettes = 7FFFh (white)
$90:E0FC CA          DEX                    ;|
$90:E0FD CA          DEX                    ;|
$90:E0FE 10 F8       BPL $F8    [$E0F8]     ;/
$90:E100 A9 14 E1    LDA #$E114             ;\
$90:E103 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E114 (draw timer)
$90:E106 22 CD C4 8D JSL $8DC4CD[$8D:C4CD]  ; Disable palette FX objects

; BRANCH_NOT_ZERO
$90:E10A AD 43 09    LDA $0943  [$7E:0943]  ;\
$90:E10D F0 04       BEQ $04    [$E113]     ;} If [timer status] != inactive:
$90:E10F 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$90:E113 60          RTS
}


;;; $E114: Timer / Samus hack handler - draw timer ;;;
{
$90:E114 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer
$90:E118 60          RTS
}


;;; $E119: Set Samus to be pushed out of Ceres Ridley's way ;;;
{
$90:E119 08          PHP
$90:E11A 8B          PHB
$90:E11B 4B          PHK                    ;\
$90:E11C AB          PLB                    ;} DB = $90
$90:E11D C2 30       REP #$30
$90:E11F A9 0E E9    LDA #$E90E             ;\
$90:E122 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = RTS
$90:E125 A9 2E E1    LDA #$E12E             ;\
$90:E128 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E12E (push Samus out of Ceres Ridley's way)
$90:E12B AB          PLB
$90:E12C 28          PLP
$90:E12D 6B          RTL
}


;;; $E12E: Timer / Samus hack handler - push Samus out of Ceres Ridley's way ;;;
{
$90:E12E AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E131 29 FF 00    AND #$00FF             ;|
$90:E134 C9 04 00    CMP #$0004             ;} If facing right:
$90:E137 F0 08       BEQ $08    [$E141]     ;/
$90:E139 A9 53 00    LDA #$0053             ;\
$90:E13C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - knockback
$90:E13F 80 06       BRA $06    [$E147]

$90:E141 A9 54 00    LDA #$0054             ;\ Else (facing left):
$90:E144 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - knockback

$90:E147 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:E14B 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:E14F AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$90:E152 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$90:E155 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$90:E158 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$90:E15B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:E15E 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$90:E161 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E164 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:E167 A9 15 00    LDA #$0015             ;\
$90:E16A 38          SEC                    ;|
$90:E16B ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$90:E16E 85 12       STA $12    [$7E:0012]  ;|
$90:E170 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} Samus Y position -= 15h - [Samus Y radius]
$90:E173 38          SEC                    ;|
$90:E174 E5 12       SBC $12    [$7E:0012]  ;|
$90:E176 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:E179 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:E17C 38          SEC                    ;|
$90:E17D ED 11 09    SBC $0911  [$7E:0911]  ;} If [Samus X position] - [layer 1 X position] >= 80h:
$90:E180 C9 80 00    CMP #$0080             ;|
$90:E183 30 08       BMI $08    [$E18D]     ;/
$90:E185 A9 02 00    LDA #$0002             ;\
$90:E188 8D 62 0A    STA $0A62  [$7E:0A62]  ;} Samus push direction = right
$90:E18B 80 06       BRA $06    [$E193]

$90:E18D A9 01 00    LDA #$0001             ;\ Else ([Samus X position] - [layer 1 X position] < 80h):
$90:E190 8D 62 0A    STA $0A62  [$7E:0A62]  ;} Samus push direction = left

$90:E193 A9 05 00    LDA #$0005             ;\
$90:E196 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;} Samus Y speed = 5.0
$90:E199 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;/
$90:E19C 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = none
$90:E19F A9 C8 E1    LDA #$E1C8             ;\
$90:E1A2 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E1C8 (pushing Samus out of Ceres Ridley's way)
$90:E1A5 A9 FF FF    LDA #$FFFF             ;\
$90:E1A8 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:E1AB 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:E1AE 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:E1B1 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:E1B4 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E1B7 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$90:E1BA 22 E7 9D 80 JSL $809DE7[$80:9DE7]  ; Process timer
$90:E1BE AD 43 09    LDA $0943  [$7E:0943]  ;\
$90:E1C1 F0 04       BEQ $04    [$E1C7]     ;} If [timer status] != inactive:
$90:E1C3 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$90:E1C7 60          RTS
}


;;; $E1C8: Timer / Samus hack handler - pushing Samus out of Ceres Ridley's way ;;;
{
$90:E1C8 AD 28 0A    LDA $0A28  [$7E:0A28]  ;\
$90:E1CB C9 4F 00    CMP #$004F             ;|
$90:E1CE F0 05       BEQ $05    [$E1D5]     ;} If [prospective pose] != damage boost: go to BRANCH_NOT_DAMAGE_BOOST
$90:E1D0 C9 50 00    CMP #$0050             ;|
$90:E1D3 D0 09       BNE $09    [$E1DE]     ;/

$90:E1D5 A9 FF FF    LDA #$FFFF             ;\
$90:E1D8 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:E1DB 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none

; BRANCH_NOT_DAMAGE_BOOST
$90:E1DE AD 62 0A    LDA $0A62  [$7E:0A62]  ;\
$90:E1E1 0A          ASL A                  ;|
$90:E1E2 AA          TAX                    ;} Execute [$E1F7 + [Samus push direction] * 2]
$90:E1E3 FC F7 E1    JSR ($E1F7,x)[$90:E1FD];/
$90:E1E6 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:E1E9 22 E7 9D 80 JSL $809DE7[$80:9DE7]  ; Process timer
$90:E1ED AD 43 09    LDA $0943  [$7E:0943]  ;\
$90:E1F0 F0 04       BEQ $04    [$E1F6]     ;} If [timer status] != inactive:
$90:E1F2 22 6C 9F 80 JSL $809F6C[$80:9F6C]  ; Draw timer

$90:E1F6 60          RTS

$90:E1F7             dw 0000, E1FD, E21C
}


;;; $E1FD: Pushing Samus out of Ceres Ridley's way - leftwards ;;;
{
$90:E1FD 20 5F 8F    JSR $8F5F  [$90:8F5F]  ; Move Samus horizontally - pushed by Ceres Ridley
$90:E200 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E203 F0 13       BEQ $13    [$E218]     ;} If solid collision:
$90:E205 A9 37 A3    LDA #$A337             ;\
$90:E208 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:E20B A9 E6 E0    LDA #$E0E6             ;\
$90:E20E 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E0E6 (handle timer)
$90:E211 9C 62 0A    STZ $0A62  [$7E:0A62]  ; Samus push direction = none
$90:E214 20 6E DF    JSR $DF6E  [$90:DF6E]  ; Handle knockback vertical collision
$90:E217 60          RTS                    ; Return

$90:E218 20 86 8F    JSR $8F86  [$90:8F86]  ; Move Samus vertically - pushed by Ceres Ridley
$90:E21B 60          RTS
}


;;; $E21C: Pushing Samus out of Ceres Ridley's way - rightwards ;;;
{
; Clone of $E1FD
$90:E21C 20 5F 8F    JSR $8F5F  [$90:8F5F]  ; Move Samus horizontally - pushed by Ceres Ridley
$90:E21F AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E222 F0 13       BEQ $13    [$E237]     ;} If solid collision:
$90:E224 A9 37 A3    LDA #$A337             ;\
$90:E227 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:E22A A9 E6 E0    LDA #$E0E6             ;\
$90:E22D 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E0E6 (handle timer)
$90:E230 9C 62 0A    STZ $0A62  [$7E:0A62]  ; Samus push direction = none
$90:E233 20 6E DF    JSR $DF6E  [$90:DF6E]  ; Handle knockback vertical collision
$90:E236 60          RTS                    ; Return

$90:E237 20 86 8F    JSR $8F86  [$90:8F86]  ; Move Samus vertically - pushed by Ceres Ridley
$90:E23A 60          RTS
}


;;; $E23B: Set Samus into the grabbed by Draygon pose ;;;
{
;; Parameters:
;;     A: Draygon's direction when grabbing Samus. 0 = left, 1 = right
$90:E23B 08          PHP
$90:E23C 8B          PHB
$90:E23D 4B          PHK                    ;\
$90:E23E AB          PLB                    ;} DB = $90
$90:E23F C2 30       REP #$30
$90:E241 89 01 00    BIT #$0001             ;\
$90:E244 F0 08       BEQ $08    [$E24E]     ;} If [A] & 1 != 0:
$90:E246 A9 EC 00    LDA #$00EC             ;\
$90:E249 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - grabbed by Draygon - not moving - not aiming
$90:E24C 80 06       BRA $06    [$E254]

$90:E24E A9 BA 00    LDA #$00BA             ;\ Else ([A] & 1 = 0):
$90:E251 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - grabbed by Draygon - not moving - not aiming

$90:E254 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:E258 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:E25C A9 A1 E2    LDA #$E2A1             ;\
$90:E25F 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E2A1 (grabbed by Draygon)
$90:E262 A9 0E E9    LDA #$E90E             ;\
$90:E265 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = RTS
$90:E268 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; Draygon-escape button counter = 0
$90:E26B 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ; Draygon-escape previous d-pad input = 0
$90:E26E 9C F0 0D    STZ $0DF0  [$7E:0DF0]  ; $0DF0 = 0
$90:E271 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$90:E274 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$90:E277 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$90:E27A 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$90:E27D AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:E280 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$90:E283 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E286 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:E289 A9 FF FF    LDA #$FFFF             ;\
$90:E28C 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:E28F 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:E292 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:E295 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:E298 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E29B 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$90:E29E AB          PLB
$90:E29F 28          PLP
$90:E2A0 6B          RTL
}


;;; $E2A1: Timer / Samus hack handler - grabbed by Draygon ;;;
{
; If grapple connected: prevent pose transition due to $0A28 (prevents Samus from aiming elsewhere).
; Handle Draygon-escape button counter and release Samus if reached 60.
$90:E2A1 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:E2A4 C9 7E C7    CMP #$C77E             ;} If [grapple beam function] != $C77E (connected - locked in place): go to BRANCH
$90:E2A7 D0 0C       BNE $0C    [$E2B5]     ;/
$90:E2A9 A9 FF FF    LDA #$FFFF             ;\
$90:E2AC 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:E2AF 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:E2B2 80 01       BRA $01    [$E2B5]     ; Go to BRANCH

$90:E2B4 60          RTS

; BRANCH
$90:E2B5 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:E2B7 29 00 0F    AND #$0F00             ;} If not newly pressing d-pad: return
$90:E2BA F0 F8       BEQ $F8    [$E2B4]     ;/
$90:E2BC CD EE 0D    CMP $0DEE  [$7E:0DEE]  ;\
$90:E2BF F0 F3       BEQ $F3    [$E2B4]     ;} If newly pressed d-pad input = [Draygon-escape previous d-pad input]: return
$90:E2C1 8D EE 0D    STA $0DEE  [$7E:0DEE]  ; Draygon-escape previous d-pad input = newly pressed d-pad input
$90:E2C4 AD EC 0D    LDA $0DEC  [$7E:0DEC]  ;\
$90:E2C7 1A          INC A                  ;} Increment Draygon-escape button counter
$90:E2C8 8D EC 0D    STA $0DEC  [$7E:0DEC]  ;/
$90:E2CB CD 95 E0    CMP $E095  [$90:E095]  ;\
$90:E2CE 30 E4       BMI $E4    [$E2B4]     ;} If [Draygon-escape button counter] < 60: return
$90:E2D0 20 DE E2    JSR $E2DE  [$90:E2DE]  ; Release Samus from Draygon
$90:E2D3 60          RTS
}


;;; $E2D4: Release Samus from Draygon (external) ;;;
{
$90:E2D4 08          PHP
$90:E2D5 8B          PHB
$90:E2D6 4B          PHK                    ;\
$90:E2D7 AB          PLB                    ;} DB = $90
$90:E2D8 20 DE E2    JSR $E2DE  [$90:E2DE]  ; Release Samus from Draygon
$90:E2DB AB          PLB
$90:E2DC 28          PLP
$90:E2DD 6B          RTL
}


;;; $E2DE: Release Samus from Draygon ;;;
{
$90:E2DE AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E2E1 29 FF 00    AND #$00FF             ;|
$90:E2E4 C9 04 00    CMP #$0004             ;} If facing right:
$90:E2E7 F0 08       BEQ $08    [$E2F1]     ;/
$90:E2E9 A9 01 00    LDA #$0001             ;\
$90:E2EC 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - normal
$90:E2EF 80 06       BRA $06    [$E2F7]

$90:E2F1 A9 02 00    LDA #$0002             ;\ Else (facing left):
$90:E2F4 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - normal

$90:E2F7 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:E2FB 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:E2FF A9 37 A3    LDA #$A337             ;\
$90:E302 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:E305 A9 0E E9    LDA #$E90E             ;\
$90:E308 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS
$90:E30B AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$90:E30E 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$90:E311 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$90:E314 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$90:E317 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:E31A 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$90:E31D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E320 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:E323 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:E326 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:E329 A9 FF FF    LDA #$FFFF             ;\
$90:E32C 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:E32F 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:E332 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:E335 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:E338 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E33B 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$90:E33E 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;\
$90:E341 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;} Samus Y speed = 0.0
$90:E344 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$90:E347 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$90:E34A 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:E34D AD 64 0A    LDA $0A64  [$7E:0A64]  ;\
$90:E350 29 FD FF    AND #$FFFD             ;|
$90:E353 09 02 00    ORA #$0002             ;} Grapple connected flags = 2 (Samus released from Draygon)
$90:E356 8D 64 0A    STA $0A64  [$7E:0A64]  ;/
$90:E359 60          RTS
}


;;; $E35A: Unused ;;;
{
$90:E35A 08          PHP
$90:E35B 8B          PHB
$90:E35C 4B          PHK                    ;\
$90:E35D AB          PLB                    ;} DB = $90
$90:E35E C2 30       REP #$30
$90:E360 A9 C5 00    LDA #$00C5             ;\
$90:E363 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = C5h (unused)
$90:E366 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E369 A9 0E E9    LDA #$E90E             ;\
$90:E36C 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = RTS
$90:E36F A9 7E E3    LDA #$E37E             ;\
$90:E372 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS
$90:E375 A9 F2 EB    LDA #$EBF2             ;\
$90:E378 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = RTS
$90:E37B AB          PLB
$90:E37C 28          PLP
$90:E37D 6B          RTL
}


;;; $E37E: RTS ;;;
{
$90:E37E 60          RTS
}


;;; $E37F: Unused. Push morph ball Samus out of Ceres Ridley's way ;;;
{
; This might well be a different kind of unused Samus movement, perhaps an unused Draygon action,
; the code is just quite similar to the Ceres Ridley stuff
$90:E37F 08          PHP
$90:E380 8B          PHB
$90:E381 4B          PHK                    ;\
$90:E382 AB          PLB                    ;} DB = $90
$90:E383 C2 30       REP #$30
$90:E385 A9 03 00    LDA #$0003             ;\
$90:E388 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;} Samus Y speed = 3.0
$90:E38B 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;/
$90:E38E A9 01 00    LDA #$0001             ;\
$90:E391 8D 62 0A    STA $0A62  [$7E:0A62]  ;} Samus push direction = left
$90:E394 A9 A3 E3    LDA #$E3A3             ;\
$90:E397 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E3A3
$90:E39A A9 52 EB    LDA #$EB52             ;\
$90:E39D 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$90:E3A0 AB          PLB
$90:E3A1 28          PLP
$90:E3A2 6B          RTL
}


;;; $E3A3: Unused. Timer / Samus hack handler - pushing morph ball Samus out of Ceres Ridley's way ;;;
{
$90:E3A3 20 5F 8F    JSR $8F5F  [$90:8F5F]  ; Move Samus horizontally - pushed by Ceres Ridley
$90:E3A6 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E3A9 D0 08       BNE $08    [$E3B3]     ;} If solid collision:
$90:E3AB 20 86 8F    JSR $8F86  [$90:8F86]  ; Move Samus vertically - pushed by Ceres Ridley
$90:E3AE AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E3B1 F0 1B       BEQ $1B    [$E3CE]     ;} If solid collision: return

$90:E3B3 A9 37 A3    LDA #$A337             ;\
$90:E3B6 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:E3B9 A9 0E E9    LDA #$E90E             ;\
$90:E3BC 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS
$90:E3BF 9C 62 0A    STZ $0A62  [$7E:0A62]  ; Samus push direction = none
$90:E3C2 20 6E DF    JSR $DF6E  [$90:DF6E]  ; Handle knockback vertical collision
$90:E3C5 A9 41 00    LDA #$0041             ;\
$90:E3C8 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - morph ball - no springball - on ground
$90:E3CB 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none

$90:E3CE 60          RTS
}


;;; $E3CF: Unused. Set Samus special falling ;;;
{
$90:E3CF 08          PHP
$90:E3D0 8B          PHB
$90:E3D1 4B          PHK                    ;\
$90:E3D2 AB          PLB                    ;} DB = $90
$90:E3D3 C2 30       REP #$30
$90:E3D5 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E3D8 29 FF 00    AND #$00FF             ;|
$90:E3DB C9 04 00    CMP #$0004             ;} If facing right:
$90:E3DE F0 08       BEQ $08    [$E3E8]     ;/
$90:E3E0 A9 29 00    LDA #$0029             ;\
$90:E3E3 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - falling
$90:E3E6 80 06       BRA $06    [$E3EE]

$90:E3E8 A9 2A 00    LDA #$002A             ;\
$90:E3EB 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - falling

$90:E3EE 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E3F1 A9 0E E9    LDA #$E90E             ;\
$90:E3F4 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = RTS
$90:E3F7 A9 1B E4    LDA #$E41B             ;\
$90:E3FA 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E41B
$90:E3FD AB          PLB
$90:E3FE 28          PLP
$90:E3FF 6B          RTL
}


;;; $E400: Unused. Clear Samus special falling ;;;
{
$90:E400 08          PHP
$90:E401 8B          PHB
$90:E402 4B          PHK                    ;\
$90:E403 AB          PLB                    ;} DB = $90
$90:E404 C2 30       REP #$30
$90:E406 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$90:E409 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$90:E40C A9 37 A3    LDA #$A337             ;\
$90:E40F 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:E412 A9 0E E9    LDA #$E90E             ;\
$90:E415 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS
$90:E418 AB          PLB
$90:E419 28          PLP
$90:E41A 6B          RTL
}


;;; $E41B: Unused. Timer / Samus hack handler - special falling ;;;
{
; Looks like a cut-down version of $A58D (Samus movement - falling)
; In particular, this version doesn't do any horizontal movement
; Perhaps it was used for the Maridia elevatube at one point
$90:E41B AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:E41E C9 05 00    CMP #$0005             ;} If [Samus Y speed] < 5:
$90:E421 10 13       BPL $13    [$E436]     ;/
$90:E423 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$90:E426 18          CLC                    ;|
$90:E427 6D 32 0B    ADC $0B32  [$7E:0B32]  ;|
$90:E42A 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;} Samus Y speed += [Samus Y acceleration]
$90:E42D AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;|
$90:E430 6D 34 0B    ADC $0B34  [$7E:0B34]  ;|
$90:E433 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/

$90:E436 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:E439 C9 29 00    CMP #$0029             ;|
$90:E43C F0 11       BEQ $11    [$E44F]     ;} If [Samus pose] != falling:
$90:E43E C9 2A 00    CMP #$002A             ;|
$90:E441 F0 0C       BEQ $0C    [$E44F]     ;/
$90:E443 C9 67 00    CMP #$0067             ;\
$90:E446 F0 07       BEQ $07    [$E44F]     ;|
$90:E448 C9 68 00    CMP #$0068             ;} If [Samus pose] != falling - gun extended:
$90:E44B F0 02       BEQ $02    [$E44F]     ;/
$90:E44D 80 14       BRA $14    [$E463]     ; Return

$90:E44F AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$90:E452 C9 05 00    CMP #$0005             ;} If [Samus Y speed] >= 5:
$90:E455 30 0C       BMI $0C    [$E463]     ;/
$90:E457 A9 10 00    LDA #$0010             ;\
$90:E45A 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 10h
$90:E45D A9 04 00    LDA #$0004             ;\
$90:E460 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 5 - 1 (terminal velocity)

$90:E463 60          RTS
}
}


;;; $E464..E691: Samus movement ;;;
{
;;; $E464: Calculate Samus X displacement for moving left ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Samus X displacement
$90:E464 08          PHP
$90:E465 C2 30       REP #$30
$90:E467 20 E6 E4    JSR $E4E6  [$90:E4E6]  ; Calculate Samus X speed
$90:E46A 9C 02 0B    STZ $0B02  [$7E:0B02]  ; Collision direction = left
$90:E46D A5 12       LDA $12    [$7E:0012]  ;\
$90:E46F 49 FF FF    EOR #$FFFF             ;|
$90:E472 85 12       STA $12    [$7E:0012]  ;|
$90:E474 A5 14       LDA $14    [$7E:0014]  ;|
$90:E476 49 FF FF    EOR #$FFFF             ;} Negate $12.$14
$90:E479 1A          INC A                  ;|
$90:E47A 85 14       STA $14    [$7E:0014]  ;|
$90:E47C D0 02       BNE $02    [$E480]     ;|
$90:E47E E6 12       INC $12    [$7E:0012]  ;/

$90:E480 AD 56 0B    LDA $0B56  [$7E:0B56]  ;\
$90:E483 18          CLC                    ;|
$90:E484 65 14       ADC $14    [$7E:0014]  ;|
$90:E486 85 14       STA $14    [$7E:0014]  ;} $12.$14 += [extra Samus X displacement]
$90:E488 AD 58 0B    LDA $0B58  [$7E:0B58]  ;|
$90:E48B 65 12       ADC $12    [$7E:0012]  ;|
$90:E48D 85 12       STA $12    [$7E:0012]  ;/
$90:E48F 30 0E       BMI $0E    [$E49F]     ;\
$90:E491 C9 10 00    CMP #$0010             ;|
$90:E494 10 02       BPL $02    [$E498]     ;|
$90:E496 28          PLP                    ;|
$90:E497 60          RTS                    ;|
                                            ;|
$90:E498 A9 0F 00    LDA #$000F             ;|
$90:E49B 85 12       STA $12    [$7E:0012]  ;|
$90:E49D 28          PLP                    ;|
$90:E49E 60          RTS                    ;} $12 = clamp([$12], -Fh, Fh)
                                            ;|
$90:E49F C9 F1 FF    CMP #$FFF1             ;|
$90:E4A2 30 02       BMI $02    [$E4A6]     ;|
$90:E4A4 28          PLP                    ;|
$90:E4A5 60          RTS                    ;|
                                            ;|
$90:E4A6 A9 F1 FF    LDA #$FFF1             ;|
$90:E4A9 85 12       STA $12    [$7E:0012]  ;/
$90:E4AB 28          PLP
$90:E4AC 60          RTS
}


;;; $E4AD: Calculate Samus X displacement for moving right ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Samus X displacement
$90:E4AD 08          PHP
$90:E4AE C2 30       REP #$30
$90:E4B0 20 E6 E4    JSR $E4E6  [$90:E4E6]  ; Calculate Samus X speed
$90:E4B3 A9 01 00    LDA #$0001             ;\
$90:E4B6 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = right
$90:E4B9 AD 56 0B    LDA $0B56  [$7E:0B56]  ;\
$90:E4BC 18          CLC                    ;|
$90:E4BD 65 14       ADC $14    [$7E:0014]  ;|
$90:E4BF 85 14       STA $14    [$7E:0014]  ;} $12.$14 += [extra Samus X displacement]
$90:E4C1 AD 58 0B    LDA $0B58  [$7E:0B58]  ;|
$90:E4C4 65 12       ADC $12    [$7E:0012]  ;|
$90:E4C6 85 12       STA $12    [$7E:0012]  ;/
$90:E4C8 30 0E       BMI $0E    [$E4D8]     ;\
$90:E4CA C9 10 00    CMP #$0010             ;|
$90:E4CD 10 02       BPL $02    [$E4D1]     ;|
$90:E4CF 28          PLP                    ;|
$90:E4D0 60          RTS                    ;|
                                            ;|
$90:E4D1 A9 0F 00    LDA #$000F             ;|
$90:E4D4 85 12       STA $12    [$7E:0012]  ;|
$90:E4D6 28          PLP                    ;|
$90:E4D7 60          RTS                    ;} $12 = clamp([$12], -Fh, Fh)
                                            ;|
$90:E4D8 C9 F1 FF    CMP #$FFF1             ;|
$90:E4DB 30 02       BMI $02    [$E4DF]     ;|
$90:E4DD 28          PLP                    ;|
$90:E4DE 60          RTS                    ;|
                                            ;|
$90:E4DF A9 F1 FF    LDA #$FFF1             ;|
$90:E4E2 85 12       STA $12    [$7E:0012]  ;/
$90:E4E4 28          PLP
$90:E4E5 60          RTS
}


;;; $E4E6: Calculate Samus X speed ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Total Samus X speed

; Total Samus X speed = $12.$14 = ([$12].[$14] + [Samus X extra run speed]) / 2^min(4, [Samus X speed divisor])

; It's clear that whoever wrote this code was unaware of LSR-ROR for multi-word bitshift

$90:E4E6 AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$90:E4E9 C9 05 00    CMP #$0005             ;|
$90:E4EC 30 03       BMI $03    [$E4F1]     ;} A = min(4, [Samus X speed divisor])
$90:E4EE A9 04 00    LDA #$0004             ;/

$90:E4F1 0A          ASL A                  ;\
$90:E4F2 AA          TAX                    ;} Go to [$E4F6 + [A] * 2]
$90:E4F3 7C F6 E4    JMP ($E4F6,x)[$90:E500];/

$90:E4F6             dw E500, E516, E541, E56E, E59D
}


;;; $E500: Calculate Samus X speed - [Samus X speed divisor] = 0 ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Total Samus X speed

$90:E500 A5 14       LDA $14    [$7E:0014]  ;\
$90:E502 18          CLC                    ;|
$90:E503 6D 44 0B    ADC $0B44  [$7E:0B44]  ;|
$90:E506 85 14       STA $14    [$7E:0014]  ;|
$90:E508 8D BE 0D    STA $0DBE  [$7E:0DBE]  ;} Total Samus X speed = $12.$14 += [Samus X extra run speed]
$90:E50B A5 12       LDA $12    [$7E:0012]  ;|
$90:E50D 6D 42 0B    ADC $0B42  [$7E:0B42]  ;|
$90:E510 85 12       STA $12    [$7E:0012]  ;|
$90:E512 8D BC 0D    STA $0DBC  [$7E:0DBC]  ;/
$90:E515 60          RTS
}


;;; $E516: Calculate Samus X speed - [Samus X speed divisor] = 1 ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Total Samus X speed

; $12.$14 = ([$12].[$14] + [Samus X extra run speed]) / 2
; Calculation here is only valid for [$12] + [Samus X extra run speed] < 100h

$90:E516 A5 14       LDA $14    [$7E:0014]  ;\
$90:E518 18          CLC                    ;|
$90:E519 6D 44 0B    ADC $0B44  [$7E:0B44]  ;} $14 += [Samus X extra run subspeed]
$90:E51C 85 14       STA $14    [$7E:0014]  ;/
$90:E51E A5 12       LDA $12    [$7E:0012]  ;\
$90:E520 6D 42 0B    ADC $0B42  [$7E:0B42]  ;|
$90:E523 EB          XBA                    ;|
$90:E524 4A          LSR A                  ;|
$90:E525 EB          XBA                    ;} Total Samus X speed = $12 = ([$12] + [Samus X extra run speed]) / 2
$90:E526 48          PHA                    ;|
$90:E527 29 FF 00    AND #$00FF             ;|
$90:E52A 85 12       STA $12    [$7E:0012]  ;|
$90:E52C 8D BC 0D    STA $0DBC  [$7E:0DBC]  ;/
$90:E52F 68          PLA                    ;\
$90:E530 29 00 FF    AND #$FF00             ;} $16 = ([$12] + [Samus X extra run speed] & 1) * 8000h
$90:E533 85 16       STA $16    [$7E:0016]  ;/
$90:E535 A5 14       LDA $14    [$7E:0014]  ;\
$90:E537 4A          LSR A                  ;|
$90:E538 18          CLC                    ;|
$90:E539 65 16       ADC $16    [$7E:0016]  ;} Total Samus X subspeed = $14 = [$14] / 2 + [$16]
$90:E53B 85 14       STA $14    [$7E:0014]  ;|
$90:E53D 8D BE 0D    STA $0DBE  [$7E:0DBE]  ;/
$90:E540 60          RTS
}


;;; $E541: Calculate Samus X speed - [Samus X speed divisor] = 2 ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Total Samus X speed

; $12.$14 = ([$12].[$14] + [Samus X extra run speed]) / 4
; Calculation here is only valid for [$12] + [Samus X extra run speed] < 100h

$90:E541 A5 14       LDA $14    [$7E:0014]  ;\
$90:E543 18          CLC                    ;|
$90:E544 6D 44 0B    ADC $0B44  [$7E:0B44]  ;} $14 += [Samus X extra run subspeed]
$90:E547 85 14       STA $14    [$7E:0014]  ;/
$90:E549 A5 12       LDA $12    [$7E:0012]  ;\
$90:E54B 6D 42 0B    ADC $0B42  [$7E:0B42]  ;|
$90:E54E EB          XBA                    ;|
$90:E54F 4A          LSR A                  ;|
$90:E550 4A          LSR A                  ;|
$90:E551 EB          XBA                    ;} Total Samus X speed = $12 = ([$12] + [Samus X extra run speed]) / 4
$90:E552 48          PHA                    ;|
$90:E553 29 FF 00    AND #$00FF             ;|
$90:E556 85 12       STA $12    [$7E:0012]  ;|
$90:E558 8D BC 0D    STA $0DBC  [$7E:0DBC]  ;/
$90:E55B 68          PLA                    ;\
$90:E55C 29 00 FF    AND #$FF00             ;} $16 = ([$12] + [Samus X extra run speed] & 3) * 4000h
$90:E55F 85 16       STA $16    [$7E:0016]  ;/
$90:E561 A5 14       LDA $14    [$7E:0014]  ;\
$90:E563 4A          LSR A                  ;|
$90:E564 4A          LSR A                  ;|
$90:E565 18          CLC                    ;} Total Samus X subspeed = $14 = [$14] / 4 + [$16]
$90:E566 65 16       ADC $16    [$7E:0016]  ;|
$90:E568 85 14       STA $14    [$7E:0014]  ;|
$90:E56A 8D BE 0D    STA $0DBE  [$7E:0DBE]  ;/
$90:E56D 60          RTS
}


;;; $E56E: Calculate Samus X speed - [Samus X speed divisor] = 3 ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Total Samus X speed

; $12.$14 = ([$12].[$14] + [Samus X extra run speed]) / 8
; Calculation here is only valid for [$12] + [Samus X extra run speed] < 100h

$90:E56E A5 14       LDA $14    [$7E:0014]  ;\
$90:E570 18          CLC                    ;|
$90:E571 6D 44 0B    ADC $0B44  [$7E:0B44]  ;} $14 += [Samus X extra run subspeed]
$90:E574 85 14       STA $14    [$7E:0014]  ;/
$90:E576 A5 12       LDA $12    [$7E:0012]  ;\
$90:E578 6D 42 0B    ADC $0B42  [$7E:0B42]  ;|
$90:E57B EB          XBA                    ;|
$90:E57C 4A          LSR A                  ;|
$90:E57D 4A          LSR A                  ;|
$90:E57E 4A          LSR A                  ;} Total Samus X speed = $12 = ([$12] + [Samus X extra run speed]) / 8
$90:E57F EB          XBA                    ;|
$90:E580 48          PHA                    ;|
$90:E581 29 FF 00    AND #$00FF             ;|
$90:E584 85 12       STA $12    [$7E:0012]  ;|
$90:E586 8D BC 0D    STA $0DBC  [$7E:0DBC]  ;/
$90:E589 68          PLA                    ;\
$90:E58A 29 00 FF    AND #$FF00             ;} $16 = ([$12] + [Samus X extra run speed] & 7) * 2000h
$90:E58D 85 16       STA $16    [$7E:0016]  ;/
$90:E58F A5 14       LDA $14    [$7E:0014]  ;\
$90:E591 4A          LSR A                  ;|
$90:E592 4A          LSR A                  ;|
$90:E593 4A          LSR A                  ;|
$90:E594 18          CLC                    ;} Total Samus X subspeed = $14 = [$14] / 8 + [$16]
$90:E595 65 16       ADC $16    [$7E:0016]  ;|
$90:E597 85 14       STA $14    [$7E:0014]  ;|
$90:E599 8D BE 0D    STA $0DBE  [$7E:0DBE]  ;/
$90:E59C 60          RTS
}


;;; $E59D: Calculate Samus X speed - [Samus X speed divisor] = 4 ;;;
{
;; Parameters:
;;     $12.$14: Samus X base speed
;; Returns:
;;     $12.$14: Total Samus X speed

; $12.$14 = ([$12].[$14] + [Samus X extra run speed]) / 10h
; Calculation here is only valid for [$12] + [Samus X extra run speed] < 100h

$90:E59D A5 14       LDA $14    [$7E:0014]  ;\
$90:E59F 18          CLC                    ;|
$90:E5A0 6D 44 0B    ADC $0B44  [$7E:0B44]  ;} $14 += [Samus X extra run subspeed]
$90:E5A3 85 14       STA $14    [$7E:0014]  ;/
$90:E5A5 A5 12       LDA $12    [$7E:0012]  ;\
$90:E5A7 6D 42 0B    ADC $0B42  [$7E:0B42]  ;|
$90:E5AA EB          XBA                    ;|
$90:E5AB 4A          LSR A                  ;|
$90:E5AC 4A          LSR A                  ;|
$90:E5AD 4A          LSR A                  ;|
$90:E5AE 4A          LSR A                  ;} Total Samus X speed = $12 = ([$12] + [Samus X extra run speed]) / 10h
$90:E5AF EB          XBA                    ;|
$90:E5B0 48          PHA                    ;|
$90:E5B1 29 FF 00    AND #$00FF             ;|
$90:E5B4 85 12       STA $12    [$7E:0012]  ;|
$90:E5B6 8D BC 0D    STA $0DBC  [$7E:0DBC]  ;/
$90:E5B9 68          PLA                    ;\
$90:E5BA 29 00 FF    AND #$FF00             ;} $16 = ([$12] + [Samus X extra run speed] & Fh) * 1000h
$90:E5BD 85 16       STA $16    [$7E:0016]  ;/
$90:E5BF A5 14       LDA $14    [$7E:0014]  ;\
$90:E5C1 4A          LSR A                  ;|
$90:E5C2 4A          LSR A                  ;|
$90:E5C3 4A          LSR A                  ;|
$90:E5C4 4A          LSR A                  ;} Total Samus X subspeed = $14 = [$14] / 10h + [$16]
$90:E5C5 18          CLC                    ;|
$90:E5C6 65 16       ADC $16    [$7E:0016]  ;|
$90:E5C8 85 14       STA $14    [$7E:0014]  ;|
$90:E5CA 8D BE 0D    STA $0DBE  [$7E:0DBE]  ;/
$90:E5CD 60          RTS
}


;;; $E5CE: Kill Samus X speed if collision detected ;;;
{
$90:E5CE 08          PHP
$90:E5CF C2 30       REP #$30
$90:E5D1 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E5D4 F0 28       BEQ $28    [$E5FE]     ;} If no solid collision: go to BRANCH_NO_COLLISION
$90:E5D6 AD 02 0B    LDA $0B02  [$7E:0B02]  ;\
$90:E5D9 F0 08       BEQ $08    [$E5E3]     ;} If [collision direction] != left:
$90:E5DB A9 08 00    LDA #$0008             ;\
$90:E5DE 8D CE 0D    STA $0DCE  [$7E:0DCE]  ;} Samus X speed killed flag = 8
$90:E5E1 80 06       BRA $06    [$E5E9]

$90:E5E3 A9 04 00    LDA #$0004             ;\ Else ([collision direction] = left):
$90:E5E6 8D CE 0D    STA $0DCE  [$7E:0DCE]  ;} Samus X speed killed flag = 4

$90:E5E9 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$90:E5ED 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$90:E5F0 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$90:E5F3 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$90:E5F6 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$90:E5F9 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$90:E5FC 80 06       BRA $06    [$E604]     ; Return

; BRANCH_NO_COLLISION
$90:E5FE 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$90:E601 9C CE 0D    STZ $0DCE  [$7E:0DCE]  ; Samus X speed killed flag = 0

$90:E604 28          PLP
$90:E605 60          RTS
}


;;; $E606: Set Samus solid vertical collision result - upwards movement ;;;
{
$90:E606 08          PHP
$90:E607 C2 30       REP #$30
$90:E609 AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E60C F0 08       BEQ $08    [$E616]     ;} If solid collision:
$90:E60E A9 04 00    LDA #$0004             ;\
$90:E611 8D C6 0D    STA $0DC6  [$7E:0DC6]  ;} Samus solid vertical collision result = hit ceiling
$90:E614 80 03       BRA $03    [$E619]     ; Return

$90:E616 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change

$90:E619 28          PLP
$90:E61A 60          RTS
}


;;; $E61B: Set Samus solid vertical collision result - downwards movement ;;;
{
$90:E61B 08          PHP
$90:E61C C2 30       REP #$30
$90:E61E AD D0 0D    LDA $0DD0  [$7E:0DD0]  ;\
$90:E621 F0 16       BEQ $16    [$E639]     ;} If solid collision:
$90:E623 A9 01 00    LDA #$0001             ;\
$90:E626 8D C6 0D    STA $0DC6  [$7E:0DC6]  ;} Samus solid vertical collision result = landed
$90:E629 E2 30       SEP #$30               ;\
$90:E62B AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;|
$90:E62E AA          TAX                    ;|
$90:E62F BD 76 E6    LDA $E676,x[$90:E676]  ;} Samus downwards movement solid collision result = [$E676 + [Samus movement type]]
$90:E632 8D C7 0D    STA $0DC7  [$7E:0DC7]  ;|
$90:E635 C2 30       REP #$30               ;/
$90:E637 80 1F       BRA $1F    [$E658]     ; Return

$90:E639 AD C6 0D    LDA $0DC6  [$7E:0DC6]  ;\
$90:E63C 29 FF 00    AND #$00FF             ;|
$90:E63F C9 05 00    CMP #$0005             ;} If [Samus solid vertical collision result] != wall jump triggered:
$90:E642 F0 14       BEQ $14    [$E658]     ;/
$90:E644 A9 02 00    LDA #$0002             ;\
$90:E647 8D C6 0D    STA $0DC6  [$7E:0DC6]  ;} Samus solid vertical collision result = falling
$90:E64A E2 30       SEP #$30               ;\
$90:E64C AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;|
$90:E64F AA          TAX                    ;|
$90:E650 BD 5A E6    LDA $E65A,x[$90:E664]  ;} Samus downwards movement solid collision result = [$E65A + [Samus movement type]]
$90:E653 8D C7 0D    STA $0DC7  [$7E:0DC7]  ;|
$90:E656 C2 30       REP #$30               ;/

$90:E658 28          PLP
$90:E659 60          RTS

; Samus downwards movement solid collision results - falling
;     0: Airborne
;     1: Morph ball airborne
;     2: Unused (unused movement type 7)
;     3: Spring ball airborne
;     4: No change
$90:E65A             db 00, ; *0: Standing
                        00, ; *1: Running
                        04, ;  2: Normal jumping
                        04, ;  3: Spin jumping
                        01, ; *4: Morph ball - on ground
                        00, ; *5: Crouching
                        04, ;  6: Falling
                        02, ; *7: Unused
                        04, ;  8: Morph ball - falling
                        04, ;  9: Unused
                        00, ; *Ah: Knockback
                        00, ; *Bh: Unused
                        00, ; *Ch: Unused
                        00, ; *Dh: Unused
                        04, ;  Eh: Turning around - on ground
                        04, ;  Fh: Crouching/standing/morphing/unmorphing transition
                        00, ; *10h: Moonwalking
                        03, ; *11h: Spring ball - on ground
                        04, ;  12h: Spring ball - in air
                        04, ;  13h: Spring ball - falling
                        04, ;  14h: Wall jumping
                        00, ; *15h: Ran into a wall
                        04, ;  16h: Grappling
                        04, ;  17h: Turning around - jumping
                        04, ;  18h: Turning around - falling
                        04, ;  19h: Damage boost
                        04, ;  1Ah: Grabbed by Draygon
                        04  ;  1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks

; Samus downwards movement solid collision results - landed
;     0: Grounded
;     1: Morph ball grounded
;     2: Unused (unused movement type 9)
;     3: Spring ball grounded
;     4: No change
;     5: Unused
$90:E676             db 04, ;  0: Standing
                        04, ;  1: Running
                        00, ; *2: Normal jumping
                        00, ; *3: Spin jumping
                        04, ;  4: Morph ball - on ground
                        04, ;  5: Crouching
                        00, ; *6: Falling
                        04, ;  7: Unused
                        01, ; *8: Morph ball - falling
                        02, ; *9: Unused
                        00, ; *Ah: Knockback
                        04, ;  Bh: Unused
                        04, ;  Ch: Unused
                        00, ; *Dh: Unused
                        04, ;  Eh: Turning around - on ground
                        04, ;  Fh: Crouching/standing/morphing/unmorphing transition
                        04, ;  10h: Moonwalking
                        04, ;  11h: Spring ball - on ground
                        03, ; *12h: Spring ball - in air
                        03, ; *13h: Spring ball - falling
                        00, ; *14h: Wall jumping
                        04, ;  15h: Ran into a wall
                        04, ;  16h: Grappling
                        04, ;  17h: Turning around - jumping
                        04, ;  18h: Turning around - falling
                        00, ; *19h: Damage boost
                        04, ;  1Ah: Grabbed by Draygon
                        04  ;  1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}
}


;;; $E692..E721: Samus current state handler ($0A42) ;;;
{
;;; $E692: Samus current state handler ;;;
{
$90:E692 6C 42 0A    JMP ($0A42)[$90:E6C9]  ; Go to [Samus current state handler]
}


;;; $E695: Samus current state handler - normal ;;;
{
$90:E695 08          PHP
$90:E696 8B          PHB
$90:E697 4B          PHK                    ;\
$90:E698 AB          PLB                    ;} DB = $90
$90:E699 C2 30       REP #$30
$90:E69B A9 FF FF    LDA #$FFFF
$90:E69E 8D 28 0A    STA $0A28  [$7E:0A28]  ; Prospective pose = FFFFh
$90:E6A1 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:E6A4 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:E6A7 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:E6AA 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E6AD 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$90:E6B0 20 22 EC    JSR $EC22  [$90:EC22]  ; Set Samus radius
$90:E6B3 20 0F E9    JSR $E90F  [$90:E90F]  ; Execute [Samus pose input handler]
$90:E6B6 20 B6 EC    JSR $ECB6  [$90:ECB6]  ; Determine Samus suit palette index
$90:E6B9 20 5B 9C    JSR $9C5B  [$90:9C5B]  ; Determine Samus Y acceleration
$90:E6BC 22 60 9B 94 JSL $949B60[$94:9B60]  ; Samus block inside handling
$90:E6C0 20 DD DC    JSR $DCDD  [$90:DCDD]  ; Handle HUD specific behaviour and projectiles
$90:E6C3 20 02 EB    JSR $EB02  [$90:EB02]  ; Reset movement and pose change variables
$90:E6C6 AB          PLB
$90:E6C7 28          PLP
$90:E6C8 6B          RTL
}


;;; $E6C9: Samus current state handler - demo ;;;
{
$90:E6C9 08          PHP
$90:E6CA 8B          PHB
$90:E6CB 4B          PHK                    ;\
$90:E6CC AB          PLB                    ;} DB = $90
$90:E6CD C2 30       REP #$30
$90:E6CF A9 FF FF    LDA #$FFFF
$90:E6D2 8D 28 0A    STA $0A28  [$7E:0A28]  ; Prospective pose = FFFFh
$90:E6D5 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:E6D8 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:E6DB 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:E6DE 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:E6E1 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Super special pose change command = none
$90:E6E4 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:E6E6 8D 14 0A    STA $0A14  [$7E:0A14]  ;} $0A14 = [controller 1 input]
$90:E6E9 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:E6EB 8D 16 0A    STA $0A16  [$7E:0A16]  ;} $0A16 = [newly pressed controller 1 input]
$90:E6EE AD FE 0D    LDA $0DFE  [$7E:0DFE]  ;\
$90:E6F1 8D 90 0A    STA $0A90  [$7E:0A90]  ;} $0A90 = [previous controller 1 input]
$90:E6F4 AD 00 0E    LDA $0E00  [$7E:0E00]  ;\
$90:E6F7 8D 92 0A    STA $0A92  [$7E:0A92]  ;} $0A92 = [previous newly pressed controller 1 input]
$90:E6FA 20 22 EC    JSR $EC22  [$90:EC22]  ; Set Samus radius
$90:E6FD 20 B6 EC    JSR $ECB6  [$90:ECB6]  ; Determine Samus suit palette index
$90:E700 20 0F E9    JSR $E90F  [$90:E90F]  ; Execute [Samus pose input handler]
$90:E703 20 5B 9C    JSR $9C5B  [$90:9C5B]  ; Determine Samus Y acceleration
$90:E706 22 60 9B 94 JSL $949B60[$94:9B60]  ; Samus block inside handling
$90:E70A 20 DD DC    JSR $DCDD  [$90:DCDD]  ; Handle HUD specific behaviour and projectiles
$90:E70D 20 02 EB    JSR $EB02  [$90:EB02]  ; Reset movement and pose change variables
$90:E710 AB          PLB
$90:E711 28          PLP
$90:E712 6B          RTL
}


;;; $E713: Samus current state handler - Samus is locked ;;;
{
$90:E713 08          PHP
$90:E714 8B          PHB
$90:E715 4B          PHK                    ;\
$90:E716 AB          PLB                    ;} DB = $90
$90:E717 C2 30       REP #$30
$90:E719 20 CE AE    JSR $AECE  [$90:AECE]  ; Handle projectiles
$90:E71C 20 02 EB    JSR $EB02  [$90:EB02]  ; Reset movement and pose change variables
$90:E71F AB          PLB
$90:E720 28          PLP
$90:E721 6B          RTL
}
}


;;; $E722..E90D: Samus new state handler ($0A44) ;;;
{
;;; $E722: Samus new state handler ;;;
{
$90:E722 6C 44 0A    JMP ($0A44)[$90:E833]  ; Go to [Samus new state handler]
}


;;; $E725: Samus new state handler - normal ;;;
{
; The return at $E756 was added to make the demo recorder handling inaccessible.
; On the PAL version the return was removed, exposing the demo recorder in debug mode
$90:E725 08          PHP
$90:E726 8B          PHB
$90:E727 4B          PHK                    ;\
$90:E728 AB          PLB                    ;} DB = $90
$90:E729 C2 30       REP #$30
$90:E72B 20 2F F5    JSR $F52F  [$90:F52F]  ; Debug command handler
$90:E72E 9C 6E 0A    STZ $0A6E  [$7E:0A6E]  ; Samus contact damage index = normal
$90:E731 20 4B E9    JSR $E94B  [$90:E94B]  ; Execute Samus movement handler
$90:E734 22 1B A9 90 JSL $90A91B[$90:A91B]  ; Update mini-map
$90:E738 20 97 E0    JSR $E097  [$90:E097]  ; Timer / Samus hack handler
$90:E73B 20 00 80    JSR $8000  [$90:8000]  ; Animate Samus
$90:E73E 20 E9 DD    JSR $DDE9  [$90:DDE9]  ; Samus is hit interruption
$90:E741 22 B6 E8 91 JSL $91E8B6[$91:E8B6]  ; Set prospective Samus pose according to solid vertical collision result
$90:E745 22 88 EB 91 JSL $91EB88[$91:EB88]  ; Update Samus pose
$90:E749 22 F7 D6 91 JSL $91D6F7[$91:D6F7]  ; Handle Samus palette
$90:E74D 20 CE E9    JSR $E9CE  [$90:E9CE]  ; Handle periodic damage to Samus
$90:E750 20 45 EA    JSR $EA45  [$90:EA45]  ; Pause check
$90:E753 20 7F EA    JSR $EA7F  [$90:EA7F]  ; Low health check
$90:E756 AB          PLB
$90:E757 28          PLP
$90:E758 6B          RTL                    ; Return

; Handle demo recorder
$90:E759 AD E6 09    LDA $09E6  [$7E:09E6]  ;\
$90:E75C D0 08       BNE $08    [$E766]     ;} If Samus placement mode enabled:
$90:E75E AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:E761 D0 03       BNE $03    [$E766]     ;} If time not frozen:
$90:E763 20 D5 EC    JSR $ECD5  [$90:ECD5]  ; Move Samus with control pad

$90:E766 AF 02 80 80 LDA $808002[$80:8002]  ;\
$90:E76A F0 08       BEQ $08    [$E774]     ;} If demo recorder enabled:
$90:E76C 22 64 84 91 JSL $918464[$91:8464]  ; Record demo input frame
$90:E770 22 D5 84 91 JSL $9184D5[$91:84D5]  ; Pause/terminate/reset demo recorder

$90:E774 22 55 E3 91 JSL $91E355[$91:E355]  ; Handle debug mode select + L + B
$90:E778 2C CF 05    BIT $05CF  [$7E:05CF]  ;\
$90:E77B 10 03       BPL $03    [$E780]     ;} If ammo is swapped:
$90:E77D 20 26 ED    JSR $ED26  [$90:ED26]  ; Display Samus position as ammo if morphed

$90:E780 20 86 E7    JSR $E786  [$90:E786]  ; Handle Samus placement mode toggles
$90:E783 AB          PLB
$90:E784 28          PLP
$90:E785 6B          RTL
}


;;; $E786: Handle Samus placement mode toggles ;;;
{
$90:E786 08          PHP
$90:E787 C2 30       REP #$30
$90:E789 A5 91       LDA $91    [$7E:0091]  ;\
$90:E78B 89 00 80    BIT #$8000             ;} If controller 2 not newly pressed B: go to BRANCH_NO_TOGGLE_PLACEMENT_MODE
$90:E78E F0 1E       BEQ $1E    [$E7AE]     ;/
$90:E790 AD E6 09    LDA $09E6  [$7E:09E6]  ;\
$90:E793 F0 0B       BEQ $0B    [$E7A0]     ;} If Samus placement mode disabled:
$90:E795 A9 0E E9    LDA #$E90E             ;\
$90:E798 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = RTS
$90:E79B 9C E6 09    STZ $09E6  [$7E:09E6]  ; Enable Samus placement mode
$90:E79E 80 30       BRA $30    [$E7D0]     ; Return

$90:E7A0 A9 01 00    LDA #$0001             ;\ Else (Samus placement mode enabled):
$90:E7A3 8D E6 09    STA $09E6  [$7E:09E6]  ;} Disable Samus placement mode
$90:E7A6 A9 52 EB    LDA #$EB52             ;\
$90:E7A9 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$90:E7AC 80 22       BRA $22    [$E7D0]     ; Return

; BRANCH_NO_TOGGLE_PLACEMENT_MODE
$90:E7AE AD E6 09    LDA $09E6  [$7E:09E6]  ;\
$90:E7B1 D0 1D       BNE $1D    [$E7D0]     ;} If Samus placement mode enabled:
$90:E7B3 A5 91       LDA $91    [$7E:0091]  ;\
$90:E7B5 89 80 00    BIT #$0080             ;} If controller 2 newly pressed A:
$90:E7B8 F0 16       BEQ $16    [$E7D0]     ;/
$90:E7BA 22 0B 80 86 JSL $86800B[$86:800B]  ; Disable enemy projectiles
$90:E7BE A9 01 00    LDA #$0001             ;\
$90:E7C1 8D 78 0A    STA $0A78  [$7E:0A78]  ;} Freeze time
$90:E7C4 A9 CD E8    LDA #$E8CD             ;\
$90:E7C7 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = RTL
$90:E7CA A9 D2 E7    LDA #$E7D2             ;\
$90:E7CD 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E7D2 (debug, do nothing until controller 2 presses A)

$90:E7D0 28          PLP
$90:E7D1 60          RTS
}


;;; $E7D2: Samus new state handler - debug ;;;
{
$90:E7D2 08          PHP
$90:E7D3 8B          PHB
$90:E7D4 4B          PHK                    ;\
$90:E7D5 AB          PLB                    ;} DB = $90
$90:E7D6 C2 30       REP #$30
$90:E7D8 A5 91       LDA $91    [$7E:0091]  ;\
$90:E7DA 89 80 00    BIT #$0080             ;} If controller 2 not newly pressed A: return
$90:E7DD F0 13       BEQ $13    [$E7F2]     ;/
$90:E7DF A9 95 E6    LDA #$E695             ;\
$90:E7E2 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:E7E5 A9 25 E7    LDA #$E725             ;\
$90:E7E8 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E725 (normal)
$90:E7EB 22 00 80 86 JSL $868000[$86:8000]  ; Enable enemy projectiles
$90:E7EF 9C 78 0A    STZ $0A78  [$7E:0A78]  ; Unfreeze time

$90:E7F2 AB          PLB
$90:E7F3 28          PLP
$90:E7F4 6B          RTL
}


;;; $E7F5: Samus new state handler - title demo ;;;
{
$90:E7F5 08          PHP
$90:E7F6 8B          PHB
$90:E7F7 4B          PHK                    ;\
$90:E7F8 AB          PLB                    ;} DB = $90
$90:E7F9 C2 30       REP #$30
$90:E7FB 9C 6E 0A    STZ $0A6E  [$7E:0A6E]  ; Samus contact damage index = normal
$90:E7FE 20 4B E9    JSR $E94B  [$90:E94B]  ; Execute Samus movement handler
$90:E801 22 1B A9 90 JSL $90A91B[$90:A91B]  ; Update mini-map
$90:E805 20 00 80    JSR $8000  [$90:8000]  ; Animate Samus
$90:E808 20 E9 DD    JSR $DDE9  [$90:DDE9]  ; Samus is hit interruption
$90:E80B 22 B6 E8 91 JSL $91E8B6[$91:E8B6]  ; Set prospective Samus pose according to solid vertical collision result
$90:E80F 22 88 EB 91 JSL $91EB88[$91:EB88]  ; Update Samus pose
$90:E813 22 F7 D6 91 JSL $91D6F7[$91:D6F7]  ; Handle Samus palette
$90:E817 20 2F F5    JSR $F52F  [$90:F52F]  ; Debug command handler
$90:E81A AD 14 0A    LDA $0A14  [$7E:0A14]  ;\
$90:E81D 85 8B       STA $8B    [$7E:008B]  ;} Controller 1 input = [demo backup of controller 1 input]
$90:E81F AD 16 0A    LDA $0A16  [$7E:0A16]  ;\
$90:E822 85 8F       STA $8F    [$7E:008F]  ;} Newly pressed controller 1 input = [demo backup of newly pressed controller 1 input]
$90:E824 AD 90 0A    LDA $0A90  [$7E:0A90]  ;\
$90:E827 8D FE 0D    STA $0DFE  [$7E:0DFE]  ;} Previous controller 1 input = [demo backup of previous controller 1 input]
$90:E82A AD 92 0A    LDA $0A92  [$7E:0A92]  ;\
$90:E82D 8D 00 0E    STA $0E00  [$7E:0E00]  ;} Previous newly pressed controller 1 input = [demo backup of previous newly pressed controller 1 input]
$90:E830 AB          PLB
$90:E831 28          PLP
$90:E832 6B          RTL
}


;;; $E833: Samus new state handler - intro demo ;;;
{
$90:E833 08          PHP
$90:E834 8B          PHB
$90:E835 4B          PHK                    ;\
$90:E836 AB          PLB                    ;} DB = $90
$90:E837 C2 30       REP #$30
$90:E839 9C 6E 0A    STZ $0A6E  [$7E:0A6E]  ; Samus contact damage index = normal
$90:E83C 20 4B E9    JSR $E94B  [$90:E94B]  ; Execute Samus movement handler
$90:E83F 20 00 80    JSR $8000  [$90:8000]  ; Animate Samus
$90:E842 20 E9 DD    JSR $DDE9  [$90:DDE9]  ; Samus is hit interruption
$90:E845 22 B6 E8 91 JSL $91E8B6[$91:E8B6]  ; Set prospective Samus pose according to solid vertical collision result
$90:E849 22 88 EB 91 JSL $91EB88[$91:EB88]  ; Update Samus pose
$90:E84D 22 F7 D6 91 JSL $91D6F7[$91:D6F7]  ; Handle Samus palette
$90:E851 AD 14 0A    LDA $0A14  [$7E:0A14]  ;\
$90:E854 85 8B       STA $8B    [$7E:008B]  ;} Controller 1 input = [demo backup of controller 1 input]
$90:E856 AD 16 0A    LDA $0A16  [$7E:0A16]  ;\
$90:E859 85 8F       STA $8F    [$7E:008F]  ;} Newly pressed controller 1 input = [demo backup of newly pressed controller 1 input]
$90:E85B AD 90 0A    LDA $0A90  [$7E:0A90]  ;\
$90:E85E 8D FE 0D    STA $0DFE  [$7E:0DFE]  ;} Previous controller 1 input = [demo backup of previous controller 1 input]
$90:E861 AD 92 0A    LDA $0A92  [$7E:0A92]  ;\
$90:E864 8D 00 0E    STA $0E00  [$7E:0E00]  ;} Previous newly pressed controller 1 input = [demo backup of previous newly pressed controller 1 input]
$90:E867 AB          PLB
$90:E868 28          PLP
$90:E869 6B          RTL
}


;;; $E86A: Samus new state handler - Samus appearance ;;;
{
; The code here for disabling debug invincibility has no effect, as debug invincibility is disabled by Samus initialisation ($91:E156)
$90:E86A 08          PHP
$90:E86B 8B          PHB
$90:E86C 4B          PHK                    ;\
$90:E86D AB          PLB                    ;} DB = $90
$90:E86E C2 30       REP #$30
$90:E870 20 22 EC    JSR $EC22  [$90:EC22]  ; Set Samus radius
$90:E873 22 1B A9 90 JSL $90A91B[$90:A91B]  ; Update mini-map
$90:E877 20 00 80    JSR $8000  [$90:8000]  ; Animate Samus
$90:E87A 9C 18 0E    STZ $0E18  [$7E:0E18]  ; Elevator status = inactive
$90:E87D AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:E880 8D 14 0B    STA $0B14  [$7E:0B14]  ;} Samus previous Y position = [Samus Y position]
$90:E883 22 24 ED 92 JSL $92ED24[$92:ED24]  ; Play Samus fanfare
$90:E887 90 1E       BCC $1E    [$E8A7]     ; If fanfare not finished: return
$90:E889 AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$90:E88C C9 07 00    CMP #$0007             ;} If debug invincibility enabled:
$90:E88F 30 07       BMI $07    [$E898]     ;/
$90:E891 A5 8D       LDA $8D    [$7E:008D]  ;\
$90:E893 89 00 80    BIT #$8000             ;} If controller 2 is pressing B: go to BRANCH_KEEP_DEBUG_INVINCIBILITY
$90:E896 D0 03       BNE $03    [$E89B]     ;/

$90:E898 9C E0 0D    STZ $0DE0  [$7E:0DE0]  ; Disable debug invincibility

; BRANCH_KEEP_DEBUG_INVINCIBILITY
$90:E89B A9 95 E6    LDA #$E695             ;\
$90:E89E 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:E8A1 A9 25 E7    LDA #$E725             ;\
$90:E8A4 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E725 (normal)

$90:E8A7 AB          PLB
$90:E8A8 28          PLP
$90:E8A9 6B          RTL
}


;;; $E8AA: Samus new state handler - Ceres ;;;
{
$90:E8AA 08          PHP
$90:E8AB 8B          PHB
$90:E8AC 4B          PHK                    ;\
$90:E8AD AB          PLB                    ;} DB = $90
$90:E8AE C2 30       REP #$30
$90:E8B0 22 25 E7 90 JSL $90E725[$90:E725]  ; Samus new state handler - normal
$90:E8B4 AD 5A 0A    LDA $0A5A  [$7E:0A5A]  ;\
$90:E8B7 C9 14 E1    CMP #$E114             ;} If [timer / Samus hack handler] = $E114 (draw timer):
$90:E8BA D0 0E       BNE $0E    [$E8CA]     ;/
$90:E8BC AD 98 09    LDA $0998  [$7E:0998]  ;\
$90:E8BF C9 23 00    CMP #$0023             ;} >_<;
$90:E8C2 F0 06       BEQ $06    [$E8CA]     ;/
$90:E8C4 A9 23 00    LDA #$0023             ;\
$90:E8C7 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = 23h (time up)

$90:E8CA AB          PLB
$90:E8CB 28          PLP
$90:E8CC 6B          RTL
}


;;; $E8CD: RTL ;;;
{
$90:E8CD 08          PHP
$90:E8CE 8B          PHB
$90:E8CF 4B          PHK
$90:E8D0 AB          PLB
$90:E8D1 C2 30       REP #$30
$90:E8D3 AB          PLB
$90:E8D4 28          PLP
$90:E8D5 6B          RTL
}


;;; $E8D6: RTL. Samus new state handler - Samus is locked into station ;;;
{
$90:E8D6 4C CD E8    JMP $E8CD  [$90:E8CD]  ; Go to RTL
}


;;; $E8D9: RTL. Samus new state handler - Samus is being drained ;;;
{
$90:E8D9 4C CD E8    JMP $E8CD  [$90:E8CD]  ; Go to RTL
}


;;; $E8DC: Samus new state handler - Samus is locked ;;;
{
$90:E8DC 08          PHP
$90:E8DD 8B          PHB
$90:E8DE 4B          PHK                    ;\
$90:E8DF AB          PLB                    ;} DB = $90
$90:E8E0 C2 30       REP #$30
$90:E8E2 9C 6E 0A    STZ $0A6E  [$7E:0A6E]  ; Samus contact damage index = normal
$90:E8E5 22 1B A9 90 JSL $90A91B[$90:A91B]  ; Update mini-map
$90:E8E9 AB          PLB
$90:E8EA 28          PLP
$90:E8EB 6B          RTL
}


;;; $E8EC: Samus new state handler - riding elevator ;;;
{
$90:E8EC 08          PHP
$90:E8ED 8B          PHB
$90:E8EE 4B          PHK                    ;\
$90:E8EF AB          PLB                    ;} DB = $90
$90:E8F0 C2 30       REP #$30
$90:E8F2 9C 6E 0A    STZ $0A6E  [$7E:0A6E]  ; Samus contact damage index = normal
$90:E8F5 20 4B E9    JSR $E94B  [$90:E94B]  ; Execute Samus movement handler
$90:E8F8 22 1B A9 90 JSL $90A91B[$90:A91B]  ; Update mini-map
$90:E8FC 20 00 80    JSR $8000  [$90:8000]  ; Animate Samus
$90:E8FF AB          PLB
$90:E900 28          PLP
$90:E901 6B          RTL
}


;;; $E902: Samus new state handler - entering/exiting gunship ;;;
{
$90:E902 08          PHP
$90:E903 8B          PHB
$90:E904 4B          PHK                    ;\
$90:E905 AB          PLB                    ;} DB = $90
$90:E906 C2 30       REP #$30
$90:E908 20 7F EA    JSR $EA7F  [$90:EA7F]  ; Low health check
$90:E90B AB          PLB
$90:E90C 28          PLP
$90:E90D 6B          RTL
}
}


;;; $E90E: RTS ;;;
{
$90:E90E 60          RTS
}


;;; $E90F..4A: Samus pose input handler ($0A60) ;;;
{
;;; $E90F: Samus pose input handler ;;;
{
$90:E90F 6C 60 0A    JMP ($0A60)[$90:E91D]  ; Go to [Samus pose input]
}


;;; $E912: RTS ;;;
{
$90:E912 60          RTS
}


;;; $E913: Samus pose input handler - normal ;;;
{
$90:E913 22 00 80 91 JSL $918000[$91:8000]  ; Normal Samus pose input handler
$90:E917 60          RTS
}


;;; $E918: Samus pose input handler - x-ray ;;;
{
$90:E918 22 AF FC 91 JSL $91FCAF[$91:FCAF]  ; X-ray Samus pose input handler
$90:E91C 60          RTS
}


;;; $E91D: Samus pose input handler - demo ;;;
{
$90:E91D 22 C0 83 91 JSL $9183C0[$91:83C0]  ; Demo input object handler
$90:E921 22 00 80 91 JSL $918000[$91:8000]  ; Normal Samus pose input handler
$90:E925 60          RTS
}


;;; $E926: Samus pose input handler - auto-jump hack ;;;
{
$90:E926 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:E928 48          PHA                    ;} Push controller 1 input
$90:E929 AD F4 0A    LDA $0AF4  [$7E:0AF4]  ;\
$90:E92C F0 0F       BEQ $0F    [$E93D]     ;} If [auto-jump timer] != 0:
$90:E92E C9 09 00    CMP #$0009             ;\
$90:E931 10 0A       BPL $0A    [$E93D]     ;} If [auto-jump timer] < 9:
$90:E933 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:E935 0D B4 09    ORA $09B4  [$7E:09B4]  ;} Newly pressed controller 1 input |= jump
$90:E938 85 8F       STA $8F    [$7E:008F]  ;/
$90:E93A 9C F4 0A    STZ $0AF4  [$7E:0AF4]  ; Auto-jump timer = 0

$90:E93D 22 00 80 91 JSL $918000[$91:8000]  ; Animate Samus
$90:E941 68          PLA                    ;\
$90:E942 85 8F       STA $8F    [$7E:008F]  ;} Pull into controller 1 input
$90:E944 A9 13 E9    LDA #$E913             ;\
$90:E947 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$90:E94A 60          RTS
}
}


;;; $E94B: Execute Samus movement handler ;;;
{
$90:E94B 6C 58 0A    JMP ($0A58)[$90:A337]  ; Go to [Samus movement handler]
}


;;; $E94E: RTS ;;;
{
$90:E94E 60          RTS
}


;;; $E94F: Samus movement handler - x-ray ;;;
{
$90:E94F AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:E952 29 FF 00    AND #$00FF             ;|
$90:E955 C9 0E 00    CMP #$000E             ;} If [Samus movement type] = turning around - on ground:
$90:E958 D0 01       BNE $01    [$E95B]     ;/
$90:E95A 60          RTS                    ; Return

$90:E95B A9 0F 00    LDA #$000F             ;\
$90:E95E 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = Fh
$90:E961 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:E964 29 FF 00    AND #$00FF             ;|
$90:E967 C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_FACING_LEFT
$90:E96A F0 30       BEQ $30    [$E99C]     ;/
$90:E96C AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$90:E96F C9 19 00    CMP #$0019             ;} If [x-ray angle] < 19h:
$90:E972 10 05       BPL $05    [$E979]     ;/
$90:E974 A9 00 00    LDA #$0000             ; Samus animation frame = 0 (looking up)
$90:E977 80 51       BRA $51    [$E9CA]     ; Return

$90:E979 C9 32 00    CMP #$0032             ;\
$90:E97C 10 05       BPL $05    [$E983]     ;} If [x-ray angle] < 32h:
$90:E97E A9 01 00    LDA #$0001             ; Samus animation frame = 1 (looking up-forward)
$90:E981 80 47       BRA $47    [$E9CA]     ; Return

$90:E983 C9 4B 00    CMP #$004B             ;\
$90:E986 10 05       BPL $05    [$E98D]     ;} If [x-ray angle] < 4Bh:
$90:E988 A9 02 00    LDA #$0002             ; Samus animation frame = 2 (looking forward)
$90:E98B 80 3D       BRA $3D    [$E9CA]     ; Return

$90:E98D C9 64 00    CMP #$0064             ;\
$90:E990 10 05       BPL $05    [$E997]     ;} If [x-ray angle] < 64h:
$90:E992 A9 03 00    LDA #$0003             ; Samus animation frame = 3 (looking down-forward)
$90:E995 80 33       BRA $33    [$E9CA]     ; Return

$90:E997 A9 04 00    LDA #$0004             ; Samus animation frame = 4 (looking down)
$90:E99A 80 2E       BRA $2E    [$E9CA]     ; Return

; BRANCH_FACING_LEFT
$90:E99C AD 82 0A    LDA $0A82  [$7E:0A82]  ;\
$90:E99F C9 99 00    CMP #$0099             ;} If [x-ray angle] < 99h:
$90:E9A2 10 05       BPL $05    [$E9A9]     ;/
$90:E9A4 A9 04 00    LDA #$0004             ; Samus animation frame = 4 (looking down)
$90:E9A7 80 21       BRA $21    [$E9CA]     ; Return

$90:E9A9 C9 B2 00    CMP #$00B2             ;\
$90:E9AC 10 05       BPL $05    [$E9B3]     ;} If [x-ray angle] < B2h:
$90:E9AE A9 03 00    LDA #$0003             ; Samus animation frame = 3 (looking down-forward)
$90:E9B1 80 17       BRA $17    [$E9CA]     ; Return

$90:E9B3 C9 CB 00    CMP #$00CB             ;\
$90:E9B6 10 05       BPL $05    [$E9BD]     ;} If [x-ray angle] < CBh:
$90:E9B8 A9 02 00    LDA #$0002             ; Samus animation frame = 2 (looking forward)
$90:E9BB 80 0D       BRA $0D    [$E9CA]     ; Return

$90:E9BD C9 E4 00    CMP #$00E4             ;\
$90:E9C0 10 05       BPL $05    [$E9C7]     ;} If [x-ray angle] < E4h:
$90:E9C2 A9 01 00    LDA #$0001             ; Samus animation frame = 1 (looking up-forward)
$90:E9C5 80 03       BRA $03    [$E9CA]     ; Return

$90:E9C7 A9 00 00    LDA #$0000             ; Samus animation frame = 0 (looking up)

$90:E9CA 8D 96 0A    STA $0A96  [$7E:0A96]
$90:E9CD 60          RTS
}


;;; $E9CE: Handle periodic damage to Samus ;;;
{
; (Lava, acid, heat, not Metroids)
$90:E9CE 08          PHP
$90:E9CF C2 30       REP #$30
$90:E9D1 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:E9D4 F0 03       BEQ $03    [$E9D9]     ;} If time is frozen: go to BRANCH_TIME_IS_FROZEN
$90:E9D6 4C 3D EA    JMP $EA3D  [$90:EA3D]  ;/

$90:E9D9 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:E9DC 89 20 00    BIT #$0020             ;} If gravity suit not equipped:
$90:E9DF D0 1B       BNE $1B    [$E9FC]     ;/
$90:E9E1 89 01 00    BIT #$0001             ;\
$90:E9E4 F0 2B       BEQ $2B    [$EA11]     ;} If varia suit equipped:
$90:E9E6 AD 4F 0A    LDA $0A4F  [$7E:0A4F]  ;\
$90:E9E9 4A          LSR A                  ;|
$90:E9EA 48          PHA                    ;|
$90:E9EB EB          XBA                    ;|
$90:E9EC 29 00 FF    AND #$FF00             ;|
$90:E9EF 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;} Periodic damage /= 2
$90:E9F2 68          PLA                    ;|
$90:E9F3 EB          XBA                    ;|
$90:E9F4 29 FF 00    AND #$00FF             ;|
$90:E9F7 8D 50 0A    STA $0A50  [$7E:0A50]  ;|
$90:E9FA 80 15       BRA $15    [$EA11]     ;/

$90:E9FC AD 4F 0A    LDA $0A4F  [$7E:0A4F]  ;\ Else (gravity suit equipped)
$90:E9FF 4A          LSR A                  ;|
$90:EA00 4A          LSR A                  ;|
$90:EA01 48          PHA                    ;|
$90:EA02 EB          XBA                    ;|
$90:EA03 29 00 FF    AND #$FF00             ;} Periodic damage /= 4
$90:EA06 8D 4E 0A    STA $0A4E  [$7E:0A4E]  ;|
$90:EA09 68          PLA                    ;|
$90:EA0A EB          XBA                    ;|
$90:EA0B 29 FF 00    AND #$00FF             ;|
$90:EA0E 8D 50 0A    STA $0A50  [$7E:0A50]  ;/

$90:EA11 AD 50 0A    LDA $0A50  [$7E:0A50]  ;\
$90:EA14 10 04       BPL $04    [$EA1A]     ;} If periodic damage is negative, crash...
$90:EA16 5C 73 85 80 JML $808573[$80:8573]  ;/

$90:EA1A AD 4C 0A    LDA $0A4C  [$7E:0A4C]  ;\
$90:EA1D 38          SEC                    ;|
$90:EA1E ED 4E 0A    SBC $0A4E  [$7E:0A4E]  ;|
$90:EA21 8D 4C 0A    STA $0A4C  [$7E:0A4C]  ;} Samus health -= [periodic damage]
$90:EA24 AD C2 09    LDA $09C2  [$7E:09C2]  ;|
$90:EA27 ED 50 0A    SBC $0A50  [$7E:0A50]  ;|
$90:EA2A 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$90:EA2D 10 0E       BPL $0E    [$EA3D]     ; If [Samus health] < 0:
$90:EA2F 9C 4C 0A    STZ $0A4C  [$7E:0A4C]  ;\
$90:EA32 9C C2 09    STZ $09C2  [$7E:09C2]  ;} Samus health = 0.0
$90:EA35 9C 4E 0A    STZ $0A4E  [$7E:0A4E]  ;\
$90:EA38 9C 50 0A    STZ $0A50  [$7E:0A50]  ;} Periodic damage = 0.0
$90:EA3B 28          PLP
$90:EA3C 60          RTS                    ; Return

; BRANCH_TIME_IS_FROZEN
$90:EA3D 9C 4E 0A    STZ $0A4E  [$7E:0A4E]  ;\
$90:EA40 9C 50 0A    STZ $0A50  [$7E:0A50]  ;} Periodic damage = 0.0
$90:EA43 28          PLP
$90:EA44 60          RTS
}


;;; $EA45: Pause check ;;;
{
$90:EA45 08          PHP
$90:EA46 C2 30       REP #$30
$90:EA48 AD EE 0C    LDA $0CEE  [$7E:0CEE]  ;\
$90:EA4B D0 30       BNE $30    [$EA7D]     ;} If power bomb is active: return
$90:EA4D AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$90:EA50 D0 2B       BNE $2B    [$EA7D]     ;} If time is frozen: return
$90:EA52 AD 97 07    LDA $0797  [$7E:0797]  ;\
$90:EA55 D0 26       BNE $26    [$EA7D]     ;} If in door transition: return
$90:EA57 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$90:EA5A C9 06 00    CMP #$0006             ;} If [area index] = Ceres: return
$90:EA5D F0 1E       BEQ $1E    [$EA7D]     ;/
$90:EA5F AD 98 09    LDA $0998  [$7E:0998]  ;\
$90:EA62 C9 08 00    CMP #$0008             ;} If [game state] != main gameplay: return
$90:EA65 D0 16       BNE $16    [$EA7D]     ;/
$90:EA67 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:EA69 89 00 10    BIT #$1000             ;} If not newly pressing start: return
$90:EA6C F0 0F       BEQ $0F    [$EA7D]     ;/
$90:EA6E A9 01 00    LDA #$0001             ;\
$90:EA71 8D 23 07    STA $0723  [$7E:0723]  ;} Screen fade delay = 1
$90:EA74 8D 25 07    STA $0725  [$7E:0725]  ; Screen fade counter = 1
$90:EA77 A9 0C 00    LDA #$000C             ;\
$90:EA7A 8D 98 09    STA $0998  [$7E:0998]  ;} Game state = Ch (pausing, normal gameplay but darkening)

$90:EA7D 28          PLP
$90:EA7E 60          RTS
}


;;; $EA7F: Low health check ;;;
{
; Queuing a sound effect can fail due to a power bomb explosion being active,
; and this routine sets the $0A6A flag regardless,
; which causes a bug where the beep doesn't turn on or off correctly even though this function is called every frame
$90:EA7F AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:EA82 C9 1F 00    CMP #$001F             ;} If [Samus health] > 30:
$90:EA85 30 11       BMI $11    [$EA98]     ;/
$90:EA87 AD 6A 0A    LDA $0A6A  [$7E:0A6A]  ;\
$90:EA8A F0 1E       BEQ $1E    [$EAAA]     ;} If Samus health warning is not on: return
$90:EA8C 9C 6A 0A    STZ $0A6A  [$7E:0A6A]  ; Set Samus health warning off
$90:EA8F A9 01 00    LDA #$0001             ;\
$90:EA92 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1, sound library 3, max queued sounds allowed = 6 (silence)
$90:EA96 80 12       BRA $12    [$EAAA]     ; Return

$90:EA98 AD 6A 0A    LDA $0A6A  [$7E:0A6A]  ;\
$90:EA9B D0 0D       BNE $0D    [$EAAA]     ;} If Samus health warning is on: return
$90:EA9D A9 02 00    LDA #$0002             ;\
$90:EAA0 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2, sound library 3, max queued sounds allowed = 6 (low health beep)
$90:EAA4 A9 01 00    LDA #$0001             ;\
$90:EAA7 8D 6A 0A    STA $0A6A  [$7E:0A6A]  ;} Set Samus health warning on

$90:EAAA 60          RTS
}


;;; $EAAB: Low health check (external) ;;;
{
$90:EAAB 08          PHP
$90:EAAC C2 30       REP #$30
$90:EAAE 20 7F EA    JSR $EA7F  [$90:EA7F]  ; Low health check
$90:EAB1 28          PLP
$90:EAB2 6B          RTL
}


;;; $EAB3: Handle auto-jump timer and Samus hurt flash counter, update previous input and Samus health ;;;
{
$90:EAB3 08          PHP
$90:EAB4 C2 30       REP #$30
$90:EAB6 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:EAB8 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If pressing jump:
$90:EABB F0 0D       BEQ $0D    [$EACA]     ;/
$90:EABD AD FE 0D    LDA $0DFE  [$7E:0DFE]  ;\
$90:EAC0 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If previously pressing jump:
$90:EAC3 F0 05       BEQ $05    [$EACA]     ;/
$90:EAC5 EE F4 0A    INC $0AF4  [$7E:0AF4]  ; Increment auto-jump timer
$90:EAC8 80 03       BRA $03    [$EACD]
                                            ; Else (not pressing jump or not previously pressing jump)
$90:EACA 9C F4 0A    STZ $0AF4  [$7E:0AF4]  ; Auto-jump timer = 0

$90:EACD A5 8B       LDA $8B    [$7E:008B]  ;\
$90:EACF 8D FE 0D    STA $0DFE  [$7E:0DFE]  ;} Previous controller 1 input = [controller 1 input]
$90:EAD2 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:EAD4 8D 00 0E    STA $0E00  [$7E:0E00]  ;} Previous newly pressed controller 1 input = [newly pressed controller 1 input]
$90:EAD7 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:EADA CD 12 0A    CMP $0A12  [$7E:0A12]  ;} If [Samus health] >= [Samus previous health]: go to BRANCH_RETURN
$90:EADD 10 1B       BPL $1B    [$EAFA]     ;/
$90:EADF AD 48 0A    LDA $0A48  [$7E:0A48]  ;\
$90:EAE2 D0 06       BNE $06    [$EAEA]     ;} If [Samus hurt flash counter] = 0:
$90:EAE4 A9 01 00    LDA #$0001             ;\
$90:EAE7 8D 48 0A    STA $0A48  [$7E:0A48]  ;} Samus hurt flash counter = 1

$90:EAEA AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$90:EAED C9 07 00    CMP #$0007             ;} If debug invincibility enabled:
$90:EAF0 30 08       BMI $08    [$EAFA]     ;/
$90:EAF2 AD 12 0A    LDA $0A12  [$7E:0A12]  ;\
$90:EAF5 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus previous health]
$90:EAF8 80 06       BRA $06    [$EB00]     ; Return

; BRANCH_RETURN
$90:EAFA AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:EAFD 8D 12 0A    STA $0A12  [$7E:0A12]  ;} Samus previous health = [Samus health]

$90:EB00 28          PLP
$90:EB01 60          RTS
}


;;; $EB02: Reset movement and pose change variables ;;;
{
$90:EB02 08          PHP
$90:EB03 C2 30       REP #$30
$90:EB05 9C AA 0D    STZ $0DAA  [$7E:0DAA]  ;\
$90:EB08 9C AC 0D    STZ $0DAC  [$7E:0DAC]  ;} Distance Samus moved left = 0.0
$90:EB0B 9C AE 0D    STZ $0DAE  [$7E:0DAE]  ;\
$90:EB0E 9C B0 0D    STZ $0DB0  [$7E:0DB0]  ;} Distance Samus moved right = 0.0
$90:EB11 9C B2 0D    STZ $0DB2  [$7E:0DB2]  ;\
$90:EB14 9C B4 0D    STZ $0DB4  [$7E:0DB4]  ;} Distance Samus moved up = 0.0
$90:EB17 9C B6 0D    STZ $0DB6  [$7E:0DB6]  ;\
$90:EB1A 9C B8 0D    STZ $0DB8  [$7E:0DB8]  ;} Distance Samus moved down = 0.0
$90:EB1D 9C 9A 0A    STZ $0A9A  [$7E:0A9A]  ; New pose Samus animation frame = 0
$90:EB20 9C 5E 0B    STZ $0B5E  [$7E:0B5E]  ; Pose transition shot direction = 0
$90:EB23 AD FA 0D    LDA $0DFA  [$7E:0DFA]  ;\
$90:EB26 EB          XBA                    ;|
$90:EB27 29 00 FF    AND #$FF00             ;} $0DFA <<= 8 (never read meaningfully)
$90:EB2A 8D FA 0D    STA $0DFA  [$7E:0DFA]  ;/
$90:EB2D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:EB30 8D 10 0A    STA $0A10  [$7E:0A10]  ;} Samus' previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:EB33 28          PLP
$90:EB34 60          RTS
}


;;; $EB35..EC21: Draw Samus ;;;
{
;;; $EB35: Draw Samus and projectiles ;;;
{
$90:EB35 08          PHP
$90:EB36 8B          PHB
$90:EB37 4B          PHK                    ;\
$90:EB38 AB          PLB                    ;} DB = $90
$90:EB39 C2 30       REP #$30
$90:EB3B 20 4B EB    JSR $EB4B  [$90:EB4B]  ; Draw Samus sprites
$90:EB3E 22 54 82 93 JSL $938254[$93:8254]  ; Draw projectiles
$90:EB42 20 B3 EA    JSR $EAB3  [$90:EAB3]  ; Handle auto-jump timer and Samus hurt flash counter, update previous input and Samus health
$90:EB45 20 76 F5    JSR $F576  [$90:F576]  ; Handle unspin sound effects, cancelling echo sound and setting time up game state
$90:EB48 AB          PLB
$90:EB49 28          PLP
$90:EB4A 6B          RTL
}


;;; $EB4B: Draw Samus sprites ;;;
{
$90:EB4B 20 C4 C5    JSR $C5C4  [$90:C5C4]  ; Handle arm cannon open state
$90:EB4E 6C 5C 0A    JMP ($0A5C)[$90:EB52]  ; Go to [Samus drawing handler]
}


;;; $EB51: RTS ;;;
{
$90:EB51 60          RTS
}


;;; $EB52: Samus drawing handler - default ;;;
{
$90:EB52 20 FC BA    JSR $BAFC  [$90:BAFC]  ; Handle charging beam graphics / audio
}


;;; $EB55: Draw Samus - no charge / grapple beam ;;;
{
$90:EB55 AD AC 0A    LDA $0AAC  [$7E:0AAC]  ;\
$90:EB58 29 0F 00    AND #$000F             ;} If [arm cannon drawing mode] = 0: go to BRANCH_NO_ARM_CANNON
$90:EB5B F0 1F       BEQ $1F    [$EB7C]     ;/
$90:EB5D C9 02 00    CMP #$0002             ;\
$90:EB60 D0 0D       BNE $0D    [$EB6F]     ;} If [arm cannon drawing mode] = 2: (facing forward)
$90:EB62 20 4C 8A    JSR $8A4C  [$90:8A4C]  ; Handle atmospheric effects
$90:EB65 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EB68 20 63 C6    JSR $C663  [$90:C663]  ; Draw arm cannon
$90:EB6B 20 BD 87    JSR $87BD  [$90:87BD]  ; Draw Samus echoes
$90:EB6E 60          RTS                    ; Return

$90:EB6F 20 4C 8A    JSR $8A4C  [$90:8A4C]  ; Handle atmospheric effects
$90:EB72 20 63 C6    JSR $C663  [$90:C663]  ; Draw arm cannon
$90:EB75 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EB78 20 BD 87    JSR $87BD  [$90:87BD]  ; Draw Samus echoes
$90:EB7B 60          RTS                    ; Return

; BRANCH_NO_ARM_CANNON
$90:EB7C 20 4C 8A    JSR $8A4C  [$90:8A4C]  ; Handle atmospheric effects
$90:EB7F 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EB82 20 BD 87    JSR $87BD  [$90:87BD]  ; Draw Samus echoes
$90:EB85 60          RTS
}


;;; $EB86: Samus drawing handler - firing grapple beam ;;;
{
$90:EB86 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:EB89 C9 56 C8    CMP #$C856             ;} If [grapple beam function] >= cancel: go to draw Samus - no charge / grapple beam
$90:EB8C 10 C7       BPL $C7    [$EB55]     ;/
$90:EB8E AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:EB91 C9 03 C7    CMP #$C703             ;} If [grapple beam function] != firing:
$90:EB94 F0 05       BEQ $05    [$EB9B]     ;/
$90:EB96 C9 59 C7    CMP #$C759             ;\
$90:EB99 D0 04       BNE $04    [$EB9F]     ;} If [grapple beam function] != unfiring (unused): go to BRANCH_START_POSITION_CALCULATED

$90:EB9B 22 1B BF 9B JSL $9BBF1B[$9B:BF1B]  ; Update grapple beam start position during grapple fire

; BRANCH_START_POSITION_CALCULATED
$90:EB9F 22 36 C0 9B JSL $9BC036[$9B:C036]  ; Handle grapple beam flare
$90:EBA3 AD AC 0A    LDA $0AAC  [$7E:0AAC]  ;\
$90:EBA6 29 0F 00    AND #$000F             ;} If [arm cannon drawing mode] = 0: go to BRANCH_NO_ARM_CANNON
$90:EBA9 F0 33       BEQ $33    [$EBDE]     ;/
$90:EBAB C9 02 00    CMP #$0002             ;\
$90:EBAE D0 17       BNE $17    [$EBC7]     ;} If [arm cannon drawing mode] = 2: (facing forward)
$90:EBB0 20 4C 8A    JSR $8A4C  [$90:8A4C]  ; Handle atmospheric effects
$90:EBB3 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EBB6 20 63 C6    JSR $C663  [$90:C663]  ; Draw arm cannon
$90:EBB9 22 A5 BF 9B JSL $9BBFA5[$9B:BFA5]  ; Update grapple beam tiles and increment flare counter
$90:EBBD AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$90:EBC0 F0 2F       BEQ $2F    [$EBF1]     ;} If [grapple beam length] != 0:
$90:EBC2 22 BA AF 94 JSL $94AFBA[$94:AFBA]  ; Draw grapple beam
$90:EBC6 60          RTS                    ; Return

$90:EBC7 20 4C 8A    JSR $8A4C  [$90:8A4C]  ; Handle atmospheric effects
$90:EBCA 20 63 C6    JSR $C663  [$90:C663]  ; Draw arm cannon
$90:EBCD 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EBD0 22 A5 BF 9B JSL $9BBFA5[$9B:BFA5]  ; Update grapple beam tiles and increment flare counter
$90:EBD4 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$90:EBD7 F0 18       BEQ $18    [$EBF1]     ;} If [grapple beam length] != 0:
$90:EBD9 22 BA AF 94 JSL $94AFBA[$94:AFBA]  ; Draw grapple beam
$90:EBDD 60          RTS                    ; Return

; BRANCH_NO_ARM_CANNON
$90:EBDE 20 4C 8A    JSR $8A4C  [$90:8A4C]  ; Handle atmospheric effects
$90:EBE1 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EBE4 22 A5 BF 9B JSL $9BBFA5[$9B:BFA5]  ; Update grapple beam tiles and increment flare counter
$90:EBE8 AD FE 0C    LDA $0CFE  [$7E:0CFE]  ;\
$90:EBEB F0 04       BEQ $04    [$EBF1]     ;} If [grapple beam length] != 0:
$90:EBED 22 BA AF 94 JSL $94AFBA[$94:AFBA]  ; Draw grapple beam

$90:EBF1 60          RTS
}


;;; $EBF2: RTS. Samus display handler ;;;
{
$90:EBF2 60          RTS
}


;;; $EBF3: Samus display handler - shinespark crash echo circle ;;;
{
$90:EBF3 20 E2 85    JSR $85E2  [$90:85E2]  ; Draw Samus
$90:EBF6 A2 02 00    LDX #$0002             ; X = 2 (speed echo index)

; LOOP
$90:EBF9 DA          PHX                    ;\
$90:EBFA 20 BA 88    JSR $88BA  [$90:88BA]  ;} Draw shinespark crash echoes
$90:EBFD FA          PLX                    ;/
$90:EBFE CA          DEX                    ;\
$90:EBFF CA          DEX                    ;} X -= 2
$90:EC00 10 F7       BPL $F7    [$EBF9]     ; If [X] >= 0: go to LOOP
$90:EC02 60          RTS
}


;;; $EC03: Unused ;;;
{
; Looks like leftover code for a previous implementation of either the shinespark crash or some such
; Note how this routine is similar to $EBF3, but also note that $87BD does the loop for both echoes itself,
; so presumably $87BD used to be like $88BA and then things got refactored

$90:EC03 20 52 EB    JSR $EB52  [$90:EB52]  ; Samus drawing handler - default
$90:EC06 A2 02 00    LDX #$0002             ; X = 2 (speed echo index)

; LOOP
$90:EC09 DA          PHX                    ;\
$90:EC0A 20 BD 87    JSR $87BD  [$90:87BD]  ;} Draw Samus echoes
$90:EC0D FA          PLX                    ;/
$90:EC0E CA          DEX                    ;\
$90:EC0F CA          DEX                    ;} X -= 2
$90:EC10 10 F7       BPL $F7    [$EC09]     ; If [X] >= 0: go to LOOP
$90:EC12 60          RTS
}


;;; $EC13: RTS ;;;
{
$90:EC13 60          RTS
}


;;; $EC14: Samus display handler - using elevator ;;;
{
$90:EC14 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$90:EC17 89 01 00    BIT #$0001             ;} If [frame counter] % 2 != 0:
$90:EC1A F0 01       BEQ $01    [$EC1D]     ;/
$90:EC1C 60          RTS                    ; Return
}


;;; $EC1D: Samus display handler - inanimate Samus ;;;
{
$90:EC1D 22 00 8A 90 JSL $908A00[$90:8A00]  ; Draw inanimate Samus
$90:EC21 60          RTS
}
}


;;; $EC22: Set Samus radius ;;;
{
$90:EC22 08          PHP
$90:EC23 C2 30       REP #$30
$90:EC25 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:EC28 0A          ASL A                  ;|
$90:EC29 0A          ASL A                  ;|
$90:EC2A 0A          ASL A                  ;|
$90:EC2B AA          TAX                    ;} Samus Y radius = [$91:B62F + [Samus pose] * 8]
$90:EC2C BF 2F B6 91 LDA $91B62F,x[$91:B63F];|
$90:EC30 29 FF 00    AND #$00FF             ;|
$90:EC33 8D 00 0B    STA $0B00  [$7E:0B00]  ;/
$90:EC36 A9 05 00    LDA #$0005             ;\
$90:EC39 8D FE 0A    STA $0AFE  [$7E:0AFE]  ;} Samus X radius = 5
$90:EC3C 28          PLP
$90:EC3D 60          RTS
}


;;; $EC3E: $12 = Samus bottom boundary ;;;
{
$90:EC3E 08          PHP
$90:EC3F C2 30       REP #$30
$90:EC41 AD 1C 0A    LDA $0A1C  [$7E:0A1C]
$90:EC44 0A          ASL A
$90:EC45 0A          ASL A
$90:EC46 0A          ASL A
$90:EC47 AA          TAX
$90:EC48 BF 2F B6 91 LDA $91B62F,x[$91:B63F]
$90:EC4C 29 FF 00    AND #$00FF
$90:EC4F 18          CLC
$90:EC50 6D FA 0A    ADC $0AFA  [$7E:0AFA]
$90:EC53 3A          DEC A
$90:EC54 85 12       STA $12    [$7E:0012]
$90:EC56 28          PLP
$90:EC57 6B          RTL
}


;;; $EC58: $12 / $14 = Samus bottom / top boundary ;;;
{
$90:EC58 08          PHP
$90:EC59 C2 30       REP #$30
$90:EC5B AD 1C 0A    LDA $0A1C  [$7E:0A1C]
$90:EC5E 0A          ASL A
$90:EC5F 0A          ASL A
$90:EC60 0A          ASL A
$90:EC61 AA          TAX
$90:EC62 BF 2F B6 91 LDA $91B62F,x[$91:B63F]
$90:EC66 29 FF 00    AND #$00FF
$90:EC69 48          PHA
$90:EC6A 18          CLC
$90:EC6B 6D FA 0A    ADC $0AFA  [$7E:0AFA]
$90:EC6E 3A          DEC A
$90:EC6F 85 12       STA $12    [$7E:0012]
$90:EC71 68          PLA
$90:EC72 85 14       STA $14    [$7E:0014]
$90:EC74 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$90:EC77 38          SEC
$90:EC78 E5 14       SBC $14    [$7E:0014]
$90:EC7A 85 14       STA $14    [$7E:0014]
$90:EC7C 28          PLP
$90:EC7D 6B          RTL
}


;;; $EC7E: Align Samus bottom position with previous pose ;;;
{
; Move Samus to align Samus bottom position to be the same as with previous pose
$90:EC7E 08          PHP
$90:EC7F C2 30       REP #$30
$90:EC81 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:EC84 0A          ASL A                  ;|
$90:EC85 0A          ASL A                  ;|
$90:EC86 0A          ASL A                  ;|
$90:EC87 AA          TAX                    ;|
$90:EC88 BF 2F B6 91 LDA $91B62F,x[$91:B8CF];|
$90:EC8C 29 FF 00    AND #$00FF             ;|
$90:EC8F 85 12       STA $12    [$7E:0012]  ;|
$90:EC91 AD 20 0A    LDA $0A20  [$7E:0A20]  ;|
$90:EC94 0A          ASL A                  ;} $12 = (Samus previous pose Y radius) - (Samus pose Y radius)
$90:EC95 0A          ASL A                  ;|
$90:EC96 0A          ASL A                  ;|
$90:EC97 AA          TAX                    ;|
$90:EC98 BF 2F B6 91 LDA $91B62F,x[$91:B8CF];|
$90:EC9C 29 FF 00    AND #$00FF             ;|
$90:EC9F 38          SEC                    ;|
$90:ECA0 E5 12       SBC $12    [$7E:0012]  ;|
$90:ECA2 85 12       STA $12    [$7E:0012]  ;/
$90:ECA4 18          CLC                    ;\
$90:ECA5 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;} Samus Y position += [$12]
$90:ECA8 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:ECAB A5 12       LDA $12    [$7E:0012]  ;\
$90:ECAD 18          CLC                    ;|
$90:ECAE 6D 14 0B    ADC $0B14  [$7E:0B14]  ;} Samus previous Y position += [$12]
$90:ECB1 8D 14 0B    STA $0B14  [$7E:0B14]  ;/
$90:ECB4 28          PLP
$90:ECB5 6B          RTL
}


;;; $ECB6: Determine Samus suit palette index ;;;
{
$90:ECB6 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:ECB9 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_GRAVITY
$90:ECBC D0 10       BNE $10    [$ECCE]     ;/
$90:ECBE 89 01 00    BIT #$0001             ;\
$90:ECC1 D0 04       BNE $04    [$ECC7]     ;} If varia suit equipped: go to BRANCH_VARIA
$90:ECC3 9C 74 0A    STZ $0A74  [$7E:0A74]  ; Samus suit palette index = 0
$90:ECC6 60          RTS                    ; Return

; BRANCH_VARIA
$90:ECC7 A9 02 00    LDA #$0002             ;\
$90:ECCA 8D 74 0A    STA $0A74  [$7E:0A74]  ;} Samus suit palette index = 2
$90:ECCD 60          RTS                    ; Return

; BRANCH_GRAVITY
$90:ECCE A9 04 00    LDA #$0004             ;\
$90:ECD1 8D 74 0A    STA $0A74  [$7E:0A74]  ;} Samus suit palette index = 4
$90:ECD4 60          RTS
}


;;; $ECD5: Demo recorder - move Samus with control pad ;;;
{
$90:ECD5 08          PHP
$90:ECD6 C2 30       REP #$30
$90:ECD8 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:ECDA 89 00 08    BIT #$0800             ;} If pressing up:
$90:ECDD F0 0A       BEQ $0A    [$ECE9]     ;/
$90:ECDF A9 FC FF    LDA #$FFFC             ;\
$90:ECE2 85 12       STA $12    [$7E:0012]  ;|
$90:ECE4 64 14       STZ $14    [$7E:0014]  ;} Move Samus up by 4.0
$90:ECE6 20 EC 93    JSR $93EC  [$90:93EC]  ;/

$90:ECE9 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:ECEB 89 00 04    BIT #$0400             ;} If pressing down:
$90:ECEE F0 0A       BEQ $0A    [$ECFA]     ;/
$90:ECF0 A9 04 00    LDA #$0004             ;\
$90:ECF3 85 12       STA $12    [$7E:0012]  ;|
$90:ECF5 64 14       STZ $14    [$7E:0014]  ;} Move Samus down by 4.0
$90:ECF7 20 40 94    JSR $9440  [$90:9440]  ;/

$90:ECFA A5 8B       LDA $8B    [$7E:008B]  ;\
$90:ECFC 89 00 02    BIT #$0200             ;} If pressing left:
$90:ECFF F0 0A       BEQ $0A    [$ED0B]     ;/
$90:ED01 A9 FC FF    LDA #$FFFC             ;\
$90:ED04 85 12       STA $12    [$7E:0012]  ;|
$90:ED06 64 14       STZ $14    [$7E:0014]  ;} Move Samus left by 4.0
$90:ED08 20 50 93    JSR $9350  [$90:9350]  ;/

$90:ED0B A5 8B       LDA $8B    [$7E:008B]  ;\
$90:ED0D 89 00 01    BIT #$0100             ;} If pressing right:
$90:ED10 F0 0A       BEQ $0A    [$ED1C]     ;/
$90:ED12 A9 04 00    LDA #$0004             ;\
$90:ED15 85 12       STA $12    [$7E:0012]  ;|
$90:ED17 64 14       STZ $14    [$7E:0014]  ;} Move Samus right by 4.0
$90:ED19 20 B1 93    JSR $93B1  [$90:93B1]  ;/

$90:ED1C 28          PLP
$90:ED1D 60          RTS
}


;;; $ED1E: RTS ;;;
{
$90:ED1E 60          RTS
}


;;; $ED1F: Unused. Waste time ;;;
{
$90:ED1F A2 C8 00    LDX #$00C8

$90:ED22 CA          DEX
$90:ED23 10 FD       BPL $FD    [$ED22]
$90:ED25 60          RTS
}


;;; $ED26: Demo recorder - display Samus position as ammo if morphed ;;;
{
$90:ED26 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:ED29 29 FF 00    AND #$00FF             ;|
$90:ED2C AA          TAX                    ;|
$90:ED2D BD 50 ED    LDA $ED50,x[$90:ED50]  ;} If in morph ball:
$90:ED30 29 FF 00    AND #$00FF             ;|
$90:ED33 F0 1A       BEQ $1A    [$ED4F]     ;/
$90:ED35 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:ED38 4A          LSR A                  ;|
$90:ED39 4A          LSR A                  ;|
$90:ED3A 4A          LSR A                  ;} Samus missiles = Samus max missiles = [Samus X position] / 10h
$90:ED3B 4A          LSR A                  ;|
$90:ED3C 8D C6 09    STA $09C6  [$7E:09C6]  ;|
$90:ED3F 8D C8 09    STA $09C8  [$7E:09C8]  ;/
$90:ED42 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:ED45 4A          LSR A                  ;|
$90:ED46 4A          LSR A                  ;|
$90:ED47 4A          LSR A                  ;} Samus super missiles = Samus max super missiles = [Samus Y position] / 10h
$90:ED48 4A          LSR A                  ;|
$90:ED49 8D CA 09    STA $09CA  [$7E:09CA]  ;|
$90:ED4C 8D CC 09    STA $09CC  [$7E:09CC]  ;/

$90:ED4F 60          RTS

$90:ED50             db 00, ;  0: Standing
                        00, ;  1: Running
                        00, ;  2: Normal jumping
                        00, ;  3: Spin jumping
                        01, ; *4: Morph ball - on ground
                        00, ;  5: Crouching
                        00, ;  6: Falling
                        01, ; *7: Unused
                        01, ; *8: Morph ball - falling
                        01, ; *9: Unused
                        00, ;  Ah: Knockback / crystal flash ending
                        00, ;  Bh: Unused
                        00, ;  Ch: Unused
                        00, ;  Dh: Unused
                        00, ;  Eh: Turning around - on ground
                        00, ;  Fh: Crouching/standing/morphing/unmorphing transition
                        00, ;  10h: Moonwalking
                        01, ; *11h: Spring ball - on ground
                        01, ; *12h: Spring ball - in air
                        01, ; *13h: Spring ball - falling
                        00, ;  14h: Wall jumping
                        00, ;  15h: Ran into a wall
                        00, ;  16h: Grappling
                        00, ;  17h: Turning around - jumping
                        00, ;  18h: Turning around - falling
                        00, ;  19h: Damage boost
                        00, ;  1Ah: Grabbed by Draygon
                        00  ;  1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $ED6C: Unused. Display in-game time as ammo ;;;
{
$90:ED6C AD E0 09    LDA $09E0  [$7E:09E0]  ;\
$90:ED6F 8D C6 09    STA $09C6  [$7E:09C6]  ;} Current missiles = max missiles = [game time hours]
$90:ED72 8D C8 09    STA $09C8  [$7E:09C8]  ;/
$90:ED75 AD DE 09    LDA $09DE  [$7E:09DE]  ;\
$90:ED78 8D CA 09    STA $09CA  [$7E:09CA]  ;} Current super missiles = max super missiles = [game time minutes]
$90:ED7B 8D CC 09    STA $09CC  [$7E:09CC]  ;/
$90:ED7E AD DC 09    LDA $09DC  [$7E:09DC]  ;\
$90:ED81 8D CE 09    STA $09CE  [$7E:09CE]  ;} Current power bombs = max power bombs = [game time seconds]
$90:ED84 8D D0 09    STA $09D0  [$7E:09D0]  ;/
$90:ED87 60          RTS
}


;;; $ED88..EEE6: Footstep graphics ;;;
{
;;; $ED88: Footstep graphics ;;;
{
; Water splashing in Maridia and Crateria, dust if speedboosting.
; Only works on certain frames, assumed to be walking/running
$90:ED88 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$90:ED8B 0A          ASL A                  ;|
$90:ED8C AA          TAX                    ;} Execute [$ED91 + [area index]]
$90:ED8D FC 91 ED    JSR ($ED91,x)[$90:EDA1];/
$90:ED90 60          RTS

$90:ED91             dw EDA1, ; Crateria
                        EE64, ; Brinstar
                        EE64, ; Norfair
                        EE64, ; Wrecked Ship
                        EDEC, ; Maridia
                        EE64, ; Tourian
                        EE64, ; Ceres
                        EE64  ; Debug
}


;;; $EDA1: Footstep graphics - Crateria ;;;
{
$90:EDA1 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$90:EDA4 F0 03       BEQ $03    [$EDA9]     ;} If [cinematic function] != 0:
$90:EDA6 4C 64 EE    JMP $EE64  [$90:EE64]  ; Go to footstep graphics - common

$90:EDA9 AE 9D 07    LDX $079D  [$7E:079D]  ;\
$90:EDAC E0 10 00    CPX #$0010             ;} If [room index] < 10h:
$90:EDAF 10 15       BPL $15    [$EDC6]     ;/
$90:EDB1 BD C9 ED    LDA $EDC9,x[$90:EDC9]  ;\
$90:EDB4 29 FF 00    AND #$00FF             ;} A = [$EDC9 + [room index]]
$90:EDB7 89 01 00    BIT #$0001             ;\
$90:EDBA D0 28       BNE $28    [$EDE4]     ;} If [A] = 1: go to BRANCH_LANDING_SITE
$90:EDBC 89 02 00    BIT #$0002             ;\
$90:EDBF D0 18       BNE $18    [$EDD9]     ;} If [A] = 2: go to BRANCH_WS_ENTRANCE
$90:EDC1 89 04 00    BIT #$0004             ;\
$90:EDC4 D0 26       BNE $26    [$EDEC]     ;} If [A] = 4: go to footstep graphics - Maridia

$90:EDC6 4C 64 EE    JMP $EE64  [$90:EE64]  ; Go to footstep graphics - common

$90:EDC9             db 01, ; 0: Landing site
                        00,
                        00,
                        00,
                        00,
                        02, ; 5: Wrecked Ship entrance
                        00,
                        04, ; 7: Pre moat room
                        00,
                        04, ; 9: Wrecked Ship back door
                        04, ; Ah: East Crateria kago shaft
                        04, ; Bh: East Crateria maze
                        04, ; Ch: Post Crateria maze yellow door
                        00,
                        04, ; Eh: Moat
                        00

; BRANCH_WS_ENTRANCE
$90:EDD9 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EDDC C9 B0 03    CMP #$03B0             ;} If [Samus Y position] >= 3B0h: go to footstep graphics - Maridia
$90:EDDF 10 0B       BPL $0B    [$EDEC]     ;/
$90:EDE1 4C 64 EE    JMP $EE64  [$90:EE64]  ; Go to footstep graphics - common

; BRANCH_LANDING_SITE
$90:EDE4 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$90:EDE7 C9 0A 00    CMP #$000A             ;} If [FX type] != rain: go to footstep graphics - common
$90:EDEA D0 78       BNE $78    [$EE64]     ;/
}


;;; $EDEC: Footstep graphics - Maridia ;;;
{
$90:EDEC 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:EDF0 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:EDF3 30 0E       BMI $0E    [$EE03]     ;} If [FX Y position] >= 0:
$90:EDF5 C5 12       CMP $12    [$7E:0012]  ;\
$90:EDF7 10 13       BPL $13    [$EE0C]     ;} If [FX Y position] >= (Samus bottom boundary): go to BRANCH_NON_LIQUID_PHYSICS
$90:EDF9 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:EDFC 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$90:EDFF D0 0B       BNE $0B    [$EE0C]     ;/
$90:EE01 80 60       BRA $60    [$EE63]     ; Return

$90:EE03 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:EE06 30 04       BMI $04    [$EE0C]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$90:EE08 C5 12       CMP $12    [$7E:0012]  ;\
$90:EE0A 30 57       BMI $57    [$EE63]     ;} If [lava/acid Y position] < (Samus bottom boundary): return

; BRANCH_NON_LIQUID_PHYSICS
$90:EE0C AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:EE0F 29 FF 00    AND #$00FF             ;|
$90:EE12 C9 04 00    CMP #$0004             ;} If facing right:
$90:EE15 F0 16       BEQ $16    [$EE2D]     ;/
$90:EE17 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EE1A 18          CLC                    ;|
$90:EE1B 69 0C 00    ADC #$000C             ;} Atmospheric graphics 0 X position = [Samus X position] + Ch
$90:EE1E 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;/
$90:EE21 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EE24 38          SEC                    ;|
$90:EE25 E9 08 00    SBC #$0008             ;} Atmospheric graphics 1 X position = [Samus X position] - 8
$90:EE28 8D DE 0A    STA $0ADE  [$7E:0ADE]  ;/
$90:EE2B 80 14       BRA $14    [$EE41]

$90:EE2D AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else (facing left):
$90:EE30 38          SEC                    ;|
$90:EE31 E9 0C 00    SBC #$000C             ;} Atmospheric graphics 0 X position = [Samus X position] - Ch
$90:EE34 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;/
$90:EE37 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EE3A 18          CLC                    ;|
$90:EE3B 69 08 00    ADC #$0008             ;} Atmospheric graphics 1 X position = [Samus X position] + 8
$90:EE3E 8D DE 0A    STA $0ADE  [$7E:0ADE]  ;/

$90:EE41 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EE44 18          CLC                    ;|
$90:EE45 69 10 00    ADC #$0010             ;} Atmospheric graphics 0/1 Y positions = [Samus Y position] + 10h
$90:EE48 8D E4 0A    STA $0AE4  [$7E:0AE4]  ;|
$90:EE4B 8D E6 0A    STA $0AE6  [$7E:0AE6]  ;/
$90:EE4E A9 00 01    LDA #$0100             ;\
$90:EE51 8D EC 0A    STA $0AEC  [$7E:0AEC]  ;} Atmospheric graphics 0/1 animation frames = 0, types = 1 (footstep splash)
$90:EE54 8D EE 0A    STA $0AEE  [$7E:0AEE]  ;/
$90:EE57 A9 02 80    LDA #$8002             ;\
$90:EE5A 8D D4 0A    STA $0AD4  [$7E:0AD4]  ;} Atmospheric graphics 0 animation timer = 2 | 8000h (disabled)
$90:EE5D A9 03 00    LDA #$0003             ;\
$90:EE60 8D D6 0A    STA $0AD6  [$7E:0AD6]  ;} Atmospheric graphics 1 animation timer = 3

$90:EE63 60          RTS
}


;;; $EE64: Footstep graphics - common ;;;
{
$90:EE64 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:EE67 29 00 FF    AND #$FF00             ;|
$90:EE6A C9 00 04    CMP #$0400             ;} If not speed boosting: return
$90:EE6D D0 77       BNE $77    [$EEE6]     ;/
$90:EE6F 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$90:EE73 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$90:EE76 30 0E       BMI $0E    [$EE86]     ;} If [FX Y position] >= 0:
$90:EE78 C5 12       CMP $12    [$7E:0012]  ;\
$90:EE7A 10 13       BPL $13    [$EE8F]     ;} If [FX Y position] >= (Samus bottom boundary): go to BRANCH_NON_LIQUID_PHYSICS
$90:EE7C AD 7E 19    LDA $197E  [$7E:197E]  ;\
$90:EE7F 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$90:EE82 D0 0B       BNE $0B    [$EE8F]     ;/
$90:EE84 80 60       BRA $60    [$EEE6]     ; Return

$90:EE86 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$90:EE89 30 04       BMI $04    [$EE8F]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$90:EE8B C5 12       CMP $12    [$7E:0012]  ;\
$90:EE8D 30 57       BMI $57    [$EEE6]     ;} If [lava/acid Y position] < (Samus bottom boundary): return

; BRANCH_NON_LIQUID_PHYSICS
$90:EE8F AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:EE92 29 FF 00    AND #$00FF             ;|
$90:EE95 C9 04 00    CMP #$0004             ;} If facing right:
$90:EE98 F0 16       BEQ $16    [$EEB0]     ;/
$90:EE9A AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EE9D 18          CLC                    ;|
$90:EE9E 69 0C 00    ADC #$000C             ;} Atmospheric graphics 0 X position = [Samus X position] + Ch
$90:EEA1 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;/
$90:EEA4 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EEA7 38          SEC                    ;|
$90:EEA8 E9 08 00    SBC #$0008             ;} Atmospheric graphics 1 X position = [Samus X position] - 8
$90:EEAB 8D DE 0A    STA $0ADE  [$7E:0ADE]  ;/
$90:EEAE 80 14       BRA $14    [$EEC4]

$90:EEB0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\ Else (facing left):
$90:EEB3 38          SEC                    ;|
$90:EEB4 E9 0C 00    SBC #$000C             ;} Atmospheric graphics 0 X position = [Samus X position] - Ch
$90:EEB7 8D DC 0A    STA $0ADC  [$7E:0ADC]  ;/
$90:EEBA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EEBD 18          CLC                    ;|
$90:EEBE 69 08 00    ADC #$0008             ;} Atmospheric graphics 1 X position = [Samus X position] + 8
$90:EEC1 8D DE 0A    STA $0ADE  [$7E:0ADE]  ;/

$90:EEC4 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EEC7 18          CLC                    ;|
$90:EEC8 69 10 00    ADC #$0010             ;} Atmospheric graphics 0/1 Y positions = [Samus Y position] + 10h
$90:EECB 8D E4 0A    STA $0AE4  [$7E:0AE4]  ;|
$90:EECE 8D E6 0A    STA $0AE6  [$7E:0AE6]  ;/
$90:EED1 A9 00 07    LDA #$0700             ;\
$90:EED4 8D EC 0A    STA $0AEC  [$7E:0AEC]  ;} Atmospheric graphics 0/1 animation frames = 0, types = 7 (dust due to speed boosting)
$90:EED7 8D EE 0A    STA $0AEE  [$7E:0AEE]  ;/
$90:EEDA A9 02 80    LDA #$8002             ;\
$90:EEDD 8D D4 0A    STA $0AD4  [$7E:0AD4]  ;} Atmospheric graphics 0 animation timer = 2 | 8000h (disabled)
$90:EEE0 A9 03 00    LDA #$0003             ;\
$90:EEE3 8D D6 0A    STA $0AD6  [$7E:0AD6]  ;} Atmospheric graphics 1 animation timer = 3

$90:EEE6 60          RTS
}
}


;;; $EEE7: Update speed echo position ;;;
{
$90:EEE7 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:EEEA 29 00 FF    AND #$FF00             ;|
$90:EEED C9 00 04    CMP #$0400             ;} If not speed boosting: return
$90:EEF0 D0 29       BNE $29    [$EF1B]     ;/
$90:EEF2 AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$90:EEF5 30 24       BMI $24    [$EF1B]     ;} If [speed echoes index] & 8000h != 0 (echoes are merging back into Samus): return
$90:EEF7 AD DA 09    LDA $09DA  [$7E:09DA]  ;\
$90:EEFA 89 03 00    BIT #$0003             ;} If [game time frames] % 4 != 0: return
$90:EEFD D0 1C       BNE $1C    [$EF1B]     ;/
$90:EEFF AE AE 0A    LDX $0AAE  [$7E:0AAE]  ; X = [speed echoes index]
$90:EF02 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EF05 9D B0 0A    STA $0AB0,x[$7E:0AB0]  ;} Speed echo X position = [Samus X position]
$90:EF08 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EF0B 9D B8 0A    STA $0AB8,x[$7E:0AB8]  ;} Speed echo Y position = [Samus Y position]
$90:EF0E E8          INX                    ;\
$90:EF0F E8          INX                    ;|
$90:EF10 E0 04 00    CPX #$0004             ;|
$90:EF13 30 03       BMI $03    [$EF18]     ;} Speed echoes index = ([X] + 2) % 4
$90:EF15 A2 00 00    LDX #$0000             ;|
                                            ;|
$90:EF18 8E AE 0A    STX $0AAE  [$7E:0AAE]  ;/

$90:EF1B 60          RTS
}


;;; $EF1C: Unused ;;;
{
; My best guess is footstep graphic offsets from Samus' position
$90:EF1C             dw 000C, 0010
}


;;; $EF20: Unknown ;;;
{
; Loaded by shinespark Samus movement handlers and then unused >_<;
$90:EF20             dw 0010
}


;;; $EF22: Post grapple collision detection ;;;
{
$90:EF22 08          PHP
$90:EF23 C2 30       REP #$30
$90:EF25 22 C4 84 94 JSL $9484C4[$94:84C4]  ; Post grapple collision detection - horizontal
$90:EF29 22 CD 84 94 JSL $9484CD[$94:84CD]  ; Post grapple collision detection - vertical
$90:EF2D AD 0A 0E    LDA $0E0A  [$7E:0E0A]  ;\
$90:EF30 F0 05       BEQ $05    [$EF37]     ;|
$90:EF32 AD 08 0E    LDA $0E08  [$7E:0E08]  ;|
$90:EF35 D0 25       BNE $25    [$EF5C]     ;} If [distance to eject Samus up] = 0 or [distance to eject Samus down] != 0: return
                                            ;|
$90:EF37 AD 08 0E    LDA $0E08  [$7E:0E08]  ;|
$90:EF3A F0 20       BEQ $20    [$EF5C]     ;/
$90:EF3C AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EF3F 38          SEC                    ;|
$90:EF40 ED 08 0E    SBC $0E08  [$7E:0E08]  ;} Samus Y position -= [distance to eject Samus up]
$90:EF43 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$90:EF46 AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$90:EF49 C9 10 00    CMP #$0010             ;} If [Samus Y radius] < 10h: return
$90:EF4C 30 0E       BMI $0E    [$EF5C]     ;/
$90:EF4E 22 CD 84 94 JSL $9484CD[$94:84CD]  ; Post grapple collision detection - vertical
$90:EF52 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EF55 38          SEC                    ;|
$90:EF56 ED 08 0E    SBC $0E08  [$7E:0E08]  ;} Samus Y position -= [distance to eject Samus up]
$90:EF59 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/

$90:EF5C 28          PLP
$90:EF5D 6B          RTL
}


;;; $EF5E..F083: Unused. Unknown projectile 27h ;;;
{
;;; $EF5E: Unused. Fire unknown projectile 27h ;;;
{
$90:EF5E A9 0E E9    LDA #$E90E             ;\
$90:EF61 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = RTS
$90:EF64 A9 13 E7    LDA #$E713             ;\
$90:EF67 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$90:EF6A A9 FF FF    LDA #$FFFF             ;\
$90:EF6D 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:EF70 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:EF73 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:EF76 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:EF79 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:EF7C 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$90:EF7F A2 06 00    LDX #$0006             ; X = 6 (projectile index)

; LOOP
$90:EF82 A9 27 80    LDA #$8027             ;\
$90:EF85 9D 18 0C    STA $0C18,x            ;} Projectile type = 8027h
$90:EF88 9E 04 0C    STZ $0C04,x            ; Projectile direction = up, facing right
$90:EF8B A9 D3 EF    LDA #$EFD3             ;\
$90:EF8E 9D 68 0C    STA $0C68,x            ;} Projectile pre-instruction = $EFD3
$90:EF91 9E F0 0B    STZ $0BF0,x            ; Projectile $0BF0 = 0
$90:EF94 9E DC 0B    STZ $0BDC,x            ; Projectile $0BDC = 0
$90:EF97 9E 7C 0C    STZ $0C7C,x            ; Projectile $0C7C = 0
$90:EF9A 9E 8C 0B    STZ $0B8C,x            ; Projectile X subposition = 0
$90:EF9D 9E A0 0B    STZ $0BA0,x            ; Projectile Y subposition = 0
$90:EFA0 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:EFA3 18          CLC                    ;|
$90:EFA4 7D C3 EF    ADC $EFC3,x            ;} Projectile X position = [Samus X position] + [$EFC3 + (projectile index)]
$90:EFA7 9D 64 0B    STA $0B64,x            ;/
$90:EFAA AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:EFAD 18          CLC                    ;|
$90:EFAE 7D CB EF    ADC $EFCB,x            ;} Projectile Y position = [Samus Y position] + [$EFCB + (projectile index)]
$90:EFB1 9D 78 0B    STA $0B78,x            ;/
$90:EFB4 22 63 81 93 JSL $938163[$93:8163]  ; Initialise shinespark echo or spazer SBA trail projectile
$90:EFB8 CA          DEX                    ;\
$90:EFB9 CA          DEX                    ;} X -= 2
$90:EFBA 10 C6       BPL $C6    [$EF82]     ; If [X] >= 0: go to LOOP
$90:EFBC A9 04 00    LDA #$0004             ;\
$90:EFBF 8D CE 0C    STA $0CCE  [$7E:0CCE]  ;} Projectile counter = 4
$90:EFC2 60          RTS

; Indexed by projectile index
$90:EFC3             dw 0080, 0080, FF80, FF80 ; X offsets from Samus
$90:EFCB             dw FF80, 0080, 0080, FF80 ; Y offsets from Samus
}


;;; $EFD3: Projectile pre-instruction - unknown projectile 27h ;;;
{
;; Parameters:
;;     X: Projectile index

; Shinespark beam code(?)
$90:EFD3 BD 64 0B    LDA $0B64,x            ;\
$90:EFD6 18          CLC                    ;|
$90:EFD7 7D 2B F0    ADC $F02B,x            ;} Projectile X position += [$F02B + [projectile index]]
$90:EFDA 9D 64 0B    STA $0B64,x            ;/
$90:EFDD BD 78 0B    LDA $0B78,x            ;\
$90:EFE0 18          CLC                    ;|
$90:EFE1 7D 33 F0    ADC $F033,x            ;} Projectile Y position += [$F033 + [projectile index]]
$90:EFE4 9D 78 0B    STA $0B78,x            ;/
$90:EFE7 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;\
$90:EFEA D0 3E       BNE $3E    [$F02A]     ;} If [projectile Y position] != [Samus Y position]: return
$90:EFEC BD 7C 0C    LDA $0C7C,x            ;\
$90:EFEF C9 01 00    CMP #$0001             ;} If [projectile $0C7C] != 1: go to BRANCH_0C7C_NOT_1
$90:EFF2 D0 10       BNE $10    [$F004]     ;/
$90:EFF4 E0 06 00    CPX #$0006             ;\
$90:EFF7 D0 06       BNE $06    [$EFFF]     ;} If [projectile index] = 6:
$90:EFF9 A9 4B F0    LDA #$F04B             ;\
$90:EFFC 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $F04B

$90:EFFF 22 B7 AD 90 JSL $90ADB7[$90:ADB7]  ; Clear projectile
$90:F003 60          RTS                    ; Return

; BRANCH_0C7C_NOT_1
$90:F004 FE 7C 0C    INC $0C7C,x            ; Increment projectile $0C7C
$90:F007 A9 B4 00    LDA #$00B4             ;\
$90:F00A 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 180
$90:F00D A9 01 00    LDA #$0001             ;\
$90:F010 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = 1 (speed booster shine)
$90:F013 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$90:F016 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$90:F019 18          CLC                    ;|
$90:F01A 7D 3B F0    ADC $F03B,x            ;} Projectile X position = [Samus X position] + [$F03B + [projectile index]]
$90:F01D 9D 64 0B    STA $0B64,x            ;/
$90:F020 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$90:F023 18          CLC                    ;|
$90:F024 7D 43 F0    ADC $F043,x            ;} Projectile Y position = [Samus Y position] + [$F043 + [projectile index]]
$90:F027 9D 78 0B    STA $0B78,x            ;/

$90:F02A 60          RTS

; Indexed by projectile index
$90:F02B             dw FFFC,FFFC,0004,0004 ; X velocities
$90:F033             dw 0004,FFFC,FFFC,0004 ; Y velocities
$90:F03B             dw 0080,0080,FF80,FF80 ; X offsets from Samus
$90:F043             dw FF80,0080,0080,FF80 ; Y offsets from Samus
}


;;; $F04B: Samus movement handler - unused ;;;
{
; Shinespark beam related?
$90:F04B AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$90:F04E D0 21       BNE $21    [$F071]     ;} If [special Samus palette timer] != 0: return
$90:F050 A9 06 00    LDA #$0006             ;\
$90:F053 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;} Special Samus palette frame = 6
$90:F056 A9 01 00    LDA #$0001             ;\
$90:F059 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} $0AD0 = 1
$90:F05C 8D 80 0A    STA $0A80  [$7E:0A80]  ; $0A80 = 1
$90:F05F A9 0A 00    LDA #$000A             ;\
$90:F062 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = Ah
$90:F065 A9 78 00    LDA #$0078             ;\
$90:F068 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 120
$90:F06B A9 72 F0    LDA #$F072             ;\
$90:F06E 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $F072

$90:F071 60          RTS
}


;;; $F072: Samus movement handler - unused ;;;
{
; Shinespark beam related?
$90:F072 AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$90:F075 D0 0C       BNE $0C    [$F083]     ;} If [special Samus palette timer] != 0: return
$90:F077 A9 95 E6    LDA #$E695             ;\
$90:F07A 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:F07D A9 37 A3    LDA #$A337             ;\
$90:F080 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)

$90:F083 60          RTS
}
}


;;; $F084..F506: Samus commands ;;;
{
;;; $F084: Run Samus command ;;;
{
;; Parameters:
;;     A: Command ID. Range 0..1Fh
;;         0: Lock Samus
;;         1: Unlock Samus
;;         2: Samus reached Ceres elevator
;;         3: Unspin Samus
;;         4: End charge beam
;;         5: Set up Samus for being drained - able to stand
;;         6: Lock Samus into recharge station
;;         7: Set up Samus for elevator
;;         8: Set up Samus for Ceres start
;;         9: Set up Samus for Zebes start
;;         Ah: Stop drawing Samus
;;         Bh: Unlock Samus from facing forward
;;         Ch: Unlock Samus from map station
;;         Dh: Check if grapple beam is active
;;         Eh: Unlock Samus from Ceres elevator
;;         Fh: Enable timer handling
;;         10h: Unlock Samus from reserve tank
;;         11h: Set up Samus for death sequence
;;         12h: Enable Samus blue flashing
;;         13h: Disable Samus blue flashing
;;         14h: Queue low health and grapple sound effects
;;         15h: Lock Samus into suit pickup
;;         16h: Enable rainbow Samus
;;         17h: Disable rainbow Samus and stand her up
;;         18h: Set up Samus for being drained - unable to stand
;;         19h: Freeze drained Samus animation
;;         1Ah: Samus enters gunship
;;         1Bh: Lock Samus for reserve tank
;;         1Ch: Play spin jump sound if spin jumping
;;         1Dh: Clear sounds when going through door
;;         1Eh: Resume sounds after power bomb explosion
;;         1Fh: Kill grapple beam

; Some of these commands unconditionally return false, and you might be wondering what the point is in calling that code indirectly through this function
$90:F084 08          PHP
$90:F085 8B          PHB
$90:F086 4B          PHK                    ;\
$90:F087 AB          PLB                    ;} DB = $90
$90:F088 C2 30       REP #$30
$90:F08A DA          PHX
$90:F08B 29 1F 00    AND #$001F             ;\
$90:F08E 0A          ASL A                  ;|
$90:F08F AA          TAX                    ;} Execute [$F0AE + ([A] & 1Fh) * 2]
$90:F090 FC AE F0    JSR ($F0AE,x)[$90:F1E9];/
$90:F093 90 15       BCC $15    [$F0AA]     ; If carry set:
$90:F095 A9 FF FF    LDA #$FFFF             ;\
$90:F098 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$90:F09B 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$90:F09E 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$90:F0A1 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$90:F0A4 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$90:F0A7 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none

$90:F0AA FA          PLX
$90:F0AB AB          PLB
$90:F0AC 28          PLP
$90:F0AD 6B          RTL

$90:F0AE             dw F109, F117, F125, F152, F19B, F38E, F1AA, F1C8, F1E9, F23C, F28D, F295, F29E, F2B8, F2CA, F2D8,
                        F2E0, F2F8, F320, F328, F331, F310, F3C9, F3DD, F3C0, F3FB, F409, F411, F41E, F471, F4A2, F4D0
}


;;; $F0EE: Update Samus previous pose ;;;
{
$90:F0EE AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$90:F0F1 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$90:F0F4 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$90:F0F7 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$90:F0FA AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:F0FD 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$90:F100 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:F103 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:F106 60          RTS
}


;;; $F107: Clear carry ;;;
{
$90:F107 18          CLC
$90:F108 60          RTS
}


;;; $F109: Samus command 0: lock Samus ;;;
{
; Called by:
;     $82:E17D: Door transition function - handle elevator
;     $82:E6A2: Door transition function - nudge Samus if she's intercepting the door
;     $84:D18F: Setup - PLM $D6DA (collision reaction, special, BTS Norfair 83h. Lower Norfair chozo hand trigger)
;     $84:D5E6: Instruction - lock Samus
;     $84:D620: Setup - PLM $D6F2 (collision reaction, special, BTS Wrecked Ship 80h. Wrecked Ship chozo hand trigger)
;     $87:815A: Unused. Instruction - lock Samus
;     $8F:E26C: Door ASM: set up elevatube from south
;     $8F:E291: Door ASM: set up elevatube from north
;     $A6:BC68: (Draygon grabs Samus)
;     $A9:8829: Mother Brain body function - fake death - descent - lock Samus and set scroll region

$90:F109 A9 13 E7    LDA #$E713             ;\
$90:F10C 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$90:F10F A9 DC E8    LDA #$E8DC             ;\
$90:F112 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8DC (Samus is locked)
$90:F115 38          SEC                    ;\
$90:F116 60          RTS                    ;} Return carry set
}


;;; $F117: Samus command 1: unlock Samus ;;;
{
; Called by:
;     $84:8CAF: Instruction - activate energy station
;     $84:8CD0: Instruction - activate missile station
;     $84:AE35: Instruction - go to [[Y]] and enable movement if Samus health is full
;     $84:AEBF: Instruction - go to [[Y]] and enable movement if Samus missiles are full
;     $84:B030: Instruction - enable movement and set save station used
;     $84:D5EE: Instruction - unlock Samus
;     $87:8162: Unused. Instruction - unlock Samus
;     $8F:E301: Door ASM: reset elevatube on north exit
;     $8F:E309: Door ASM: reset elevatube on south exit
;     $A6:BC84: (Draygon releases Samus)
;     $A9:886C: Mother Brain body function - fake death - descent - unlock Samus
;     $A9:BA5E: Mother Brain body function - second phase - firing rainbow beam - finish firing rainbow beam
;     $AA:E43D: Instruction - unlock Samus
;     $AA:E6F0: Instruction - release Samus

$90:F117 A9 95 E6    LDA #$E695             ;\
$90:F11A 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:F11D A9 25 E7    LDA #$E725             ;\
$90:F120 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E725 (normal)
$90:F123 38          SEC                    ;\
$90:F124 60          RTS                    ;} Return carry set
}


;;; $F125: Samus command 2: Samus reached Ceres elevator ;;;
{
; Called by:
;     $89:ACC3: Room main ASM - Ceres elevator shaft
$90:F125 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:F128 29 FF 00    AND #$00FF             ;|
$90:F12B C9 04 00    CMP #$0004             ;} If Samus is facing right:
$90:F12E F0 08       BEQ $08    [$F138]     ;/
$90:F130 A9 01 00    LDA #$0001             ;\
$90:F133 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - normal
$90:F136 80 06       BRA $06    [$F13E]

$90:F138 A9 02 00    LDA #$0002             ;\ Else (Samus is facing left):
$90:F13B 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - normal

$90:F13E 9C 9A 0A    STZ $0A9A  [$7E:0A9A]  ; New pose Samus animation frame = 0
$90:F141 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:F145 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:F149 A9 3C 00    LDA #$003C             ;\
$90:F14C 8D A0 0A    STA $0AA0  [$7E:0AA0]  ;} Reached Ceres elevator fade timer = 60
$90:F14F 4C 09 F1    JMP $F109  [$90:F109]  ; Go to lock Samus
}


;;; $F152: Samus command 3: unspin Samus ;;;
{
; Called by:
;     $A8:A665: (yapping maw)
$90:F152 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:F155 C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] = inactive: go to BRANCH_GRAPPLE_INACTIVE
$90:F158 F0 08       BEQ $08    [$F162]     ;/
$90:F15A A9 C5 C8    LDA #$C8C5             ;\
$90:F15D 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = dropped

$90:F160 18          CLC                    ;\
$90:F161 60          RTS                    ;} Return carry clear

; BRANCH_GRAPPLE_INACTIVE
$90:F162 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:F165 29 FF 00    AND #$00FF             ;|
$90:F168 C9 03 00    CMP #$0003             ;} If [Samus movement type] != spin jumping:
$90:F16B F0 05       BEQ $05    [$F172]     ;/
$90:F16D C9 14 00    CMP #$0014             ;\
$90:F170 D0 EE       BNE $EE    [$F160]     ;} If [Samus movement type] != wall jumping: return carry clear

$90:F172 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:F175 29 FF 00    AND #$00FF             ;|
$90:F178 C9 04 00    CMP #$0004             ;} If Samus is facing right:
$90:F17B F0 08       BEQ $08    [$F185]     ;/
$90:F17D A9 01 00    LDA #$0001             ;\
$90:F180 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - normal
$90:F183 80 06       BRA $06    [$F18B]

$90:F185 A9 02 00    LDA #$0002             ;\ Else (Samus is facing left):
$90:F188 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - normal

$90:F18B 9C 9A 0A    STZ $0A9A  [$7E:0A9A]  ; New pose Samus animation frame = 0
$90:F18E 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:F192 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:F196 20 EE F0    JSR $F0EE  [$90:F0EE]  ; Update Samus previous pose
$90:F199 38          SEC                    ;\
$90:F19A 60          RTS                    ;} Return carry set
}


;;; $F19B: Samus command 4: end charge beam ;;;
{
; Called by:
;     $A0:A4A1: Normal enemy touch AI - no death check

; $A0:A4A1 assumes that this routine preserves Y (which it does)
$90:F19B 9C 62 0B    STZ $0B62  [$7E:0B62]  ; Samus' charge palette index = 0
}


;;; $F19E: End charge beam ;;;
{
$90:F19E 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:F1A1 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:F1A4 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F1A8 18          CLC                    ;\
$90:F1A9 60          RTS                    ;} Return carry clear
}


;;; $F1AA: Samus command 6: lock Samus into recharge station ;;;
{
; Called by:
;     $84:B146: Activate the station at block index [A] if Samus arm cannon is lined up
$90:F1AA A9 13 E7    LDA #$E713             ;\
$90:F1AD 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$90:F1B0 A9 D6 E8    LDA #$E8D6             ;\
$90:F1B3 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8D6 (RTL)
$90:F1B6 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:F1B9 C9 0F 00    CMP #$000F             ;} If [flare counter] >= Fh:
$90:F1BC 30 07       BMI $07    [$F1C5]     ;/
$90:F1BE A9 02 00    LDA #$0002             ;\
$90:F1C1 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)

$90:F1C5 4C 9E F1    JMP $F19E  [$90:F19E]  ; Go to end charge beam
}


;;; $F1C8: Samus command 7: set up Samus for elevator ;;;
{
; Called by:
;     $82:E6A2: Door transition function - nudge Samus if she's intercepting the door
;     $A3:9548: Elevator AI - elevator status = 0: inactive
$90:F1C8 22 F6 E3 91 JSL $91E3F6[$91:E3F6]  ; Make Samus face forward
$90:F1CC A9 EC E8    LDA #$E8EC             ;\
$90:F1CF 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8EC (riding elevator)
$90:F1D2 A9 37 A3    LDA #$A337             ;\
$90:F1D5 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$90:F1D8 A9 14 EC    LDA #$EC14             ;\
$90:F1DB 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = using elevator
$90:F1DE A9 13 E9    LDA #$E913             ;\
$90:F1E1 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$90:F1E4 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = 0
$90:F1E7 38          SEC                    ;\
$90:F1E8 60          RTS                    ;} Return carry set
}


;;; $F1E9: Samus command 8: set up Samus for Ceres start ;;;
{
; Called by:
;     $82:8000: Game state 6/1Fh/28h (loading game data / set up new game / load demo game data)
$90:F1E9 A9 CD E8    LDA #$E8CD             ;\
$90:F1EC 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = RTL
$90:F1EF A9 DC E8    LDA #$E8DC             ;\
$90:F1F2 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8DC (Samus is locked)
$90:F1F5 A9 00 00    LDA #$0000             ;\
$90:F1F8 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - power suit
$90:F1FB 9C 9A 0A    STZ $0A9A  [$7E:0A9A]  ; New pose Samus animation frame = 0
$90:F1FE 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:F202 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:F206 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F20A A9 52 EB    LDA #$EB52             ;\
$90:F20D 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$90:F210 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:F213 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$90:F216 8D 24 0A    STA $0A24  [$7E:0A24]  ; Samus last different pose = [Samus pose]
$90:F219 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:F21C 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$90:F21F 8D 26 0A    STA $0A26  [$7E:0A26]  ; Samus last different pose X direction / movement type = [Samus pose X direction / Samus movement type]
$90:F222 9C FA 0A    STZ $0AFA  [$7E:0AFA]  ; Samus Y position = 0
$90:F225 A0 87 A3    LDY #$A387             ;\
$90:F228 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Ceres elevator pad enemy projectile
$90:F22C A0 95 A3    LDY #$A395             ;\
$90:F22F 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Ceres elevator pad level data concealer enemy projectile
$90:F233 9C F7 05    STZ $05F7  [$7E:05F7]  ; Enable mini-map
$90:F236 22 18 E1 82 JSL $82E118[$82:E118]  ; Play room music track after [A] frames (A happens to be 20h here, index of the 2nd enemy projectile)
$90:F23A 38          SEC                    ;\
$90:F23B 60          RTS                    ;} Return carry set
}


;;; $F23C: Samus command 9: set up Samus for Zebes start ;;;
{
; Called by:
;     $82:8000: Game state 6/1Fh/28h (loading game data / set up new game / load demo game data)
$90:F23C AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$90:F23F 89 20 00    BIT #$0020             ;} If equipped gravity suit: go to BRANCH_GRAVITY
$90:F242 D0 23       BNE $23    [$F267]     ;/
$90:F244 89 01 00    BIT #$0001             ;\
$90:F247 D0 0F       BNE $0F    [$F258]     ;} If equipped varia suit: go to BRANCH_VARIA
$90:F249 A0 F4 E1    LDY #$E1F4             ;\
$90:F24C 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1F4 (Samus loading - power suit)
$90:F250 A9 00 00    LDA #$0000             ;\
$90:F253 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - power suit
$90:F256 80 1C       BRA $1C    [$F274]     ; Go to BRANCH_MERGE

; BRANCH_VARIA
$90:F258 A0 F8 E1    LDY #$E1F8             ;\
$90:F25B 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1F8 (Samus loading - varia suit)
$90:F25F A9 9B 00    LDA #$009B             ;\
$90:F262 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit
$90:F265 80 0D       BRA $0D    [$F274]     ; Go to BRANCH_MERGE

; BRANCH_GRAVITY
$90:F267 A0 FC E1    LDY #$E1FC             ;\
$90:F26A 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn palette FX object $E1FC (Samus loading - gravity suit)
$90:F26E A9 9B 00    LDA #$009B             ;\
$90:F271 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit

; BRANCH_MERGE
$90:F274 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F278 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:F27C A9 03 00    LDA #$0003             ;\
$90:F27F 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 3
$90:F282 A9 02 00    LDA #$0002             ;\
$90:F285 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 2 (Samus appears)
$90:F288 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; Samus appears fanfare timer = 0
$90:F28B 38          SEC                    ;\
$90:F28C 60          RTS                    ;} Return carry set
}


;;; $F28D: Samus command Ah: stop drawing Samus ;;;
{
; Called by:
;     $A2:AAA2: Gunship function - go to liftoff or restore Samus health / ammo
$90:F28D A9 0E E9    LDA #$E90E             ;\
$90:F290 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = RTS
$90:F293 18          CLC                    ;\
$90:F294 60          RTS                    ;} Return carry clear
}


;;; $F295: Samus command Bh: unlock Samus from facing forward ;;;
{
; Called by:
;     $88:E25F: Suit pickup stage 6
;     $A3:95BC: Elevator AI - elevator status = 3: entering room
$90:F295 A9 52 EB    LDA #$EB52             ;\
$90:F298 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$90:F29B 4C 17 F1    JMP $F117  [$90:F117]  ; Go to unlock Samus
}


;;; $F29E: Samus command Ch: update Samus due to unpause ;;;
{
; Called by:
;     $82:A2E3: Continue initialising gameplay resume

; This code is responsible for unlocking Samus from map stations

$90:F29E 22 33 E6 91 JSL $91E633[$91:E633]  ; Update Samus pose due to change of equipment
$90:F2A2 AD 44 0A    LDA $0A44  [$7E:0A44]  ;\
$90:F2A5 C9 D6 E8    CMP #$E8D6             ;} If [Samus new state handler] = $E8D6 (RTL):
$90:F2A8 D0 0C       BNE $0C    [$F2B6]     ;/
$90:F2AA A9 95 E6    LDA #$E695             ;\
$90:F2AD 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:F2B0 A9 25 E7    LDA #$E725             ;\
$90:F2B3 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E725 (normal)

$90:F2B6 38          SEC                    ;\
$90:F2B7 60          RTS                    ;} Return carry set
}


;;; $F2B8: Samus command Dh: check if grapple beam is active ;;;
{
; Called by:
;     $86:EFE0: Pre-instruction - enemy projectile $F337 (pickup)
;     $A0:9E9A: Enemy / grapple beam collision detection
;     $A5:8E19: Draygon body function - chase Samus
$90:F2B8 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:F2BB C9 F0 C4    CMP #$C4F0             ;} If [grapple function] = inactive:
$90:F2BE D0 05       BNE $05    [$F2C5]     ;/
$90:F2C0 A9 00 00    LDA #$0000             ; A = 0
$90:F2C3 18          CLC                    ;\
$90:F2C4 60          RTS                    ;} Return carry clear

$90:F2C5 A9 01 00    LDA #$0001             ; A = 1
$90:F2C8 18          CLC                    ;\
$90:F2C9 60          RTS                    ;} Return carry clear
}


;;; $F2CA: Samus command Eh: unlock Samus from Ceres elevator ;;;
{
; Called by:
;     $86:A328: Pre-instruction - enemy projectile $A387 (Ceres elevator pad)
$90:F2CA A9 95 E6    LDA #$E695             ;\
$90:F2CD 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:F2D0 A9 AA E8    LDA #$E8AA             ;\
$90:F2D3 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8AA (Ceres)
$90:F2D6 38          SEC                    ;\
$90:F2D7 60          RTS                    ;} Return carry set
}


;;; $F2D8: Samus command Fh: enable timer handling ;;;
{
; Called by:
;     $A9:B2F9: Mother Brain body function - third phase - death sequence - escape door is exploding, start escape timer
$90:F2D8 A9 E6 E0    LDA #$E0E6             ;\
$90:F2DB 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E0E6 (handle timer)
$90:F2DE 18          CLC                    ;\
$90:F2DF 60          RTS                    ;} Return carry clear
}


;;; $F2E0: Samus command 10h: unlock Samus from reserve tank ;;;
{
; Called by:
;     $82:DC10: Game state 1Bh (reserve tank auto)
$90:F2E0 AD 44 0A    LDA $0A44  [$7E:0A44]  ;\
$90:F2E3 C9 D9 E8    CMP #$E8D9             ;} If [Samus new state handler] = $E8D9 (Samus is being drained by rainbow beam):
$90:F2E6 D0 02       BNE $02    [$F2EA]     ;/
$90:F2E8 38          SEC                    ;\
$90:F2E9 60          RTS                    ;} Return carry set

$90:F2EA A9 95 E6    LDA #$E695             ;\
$90:F2ED 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$90:F2F0 A9 25 E7    LDA #$E725             ;\
$90:F2F3 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E725 (normal)
$90:F2F6 38          SEC                    ;\
$90:F2F7 60          RTS                    ;} Return carry set
}


;;; $F2F8: Samus command 11h: set up Samus for death sequence ;;;
{
; Called by:
;     $82:DB69: Handle Samus running out of health and increment game time
$90:F2F8 22 CD C4 8D JSL $8DC4CD[$8D:C4CD]  ; Disable palette FX objects
}


;;; $F2FC: Lock Samus and set inanimate Samus drawing handler ;;;
{
$90:F2FC A9 13 E7    LDA #$E713             ;\
$90:F2FF 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$90:F302 A9 CD E8    LDA #$E8CD             ;\
$90:F305 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = RTL
$90:F308 A9 1D EC    LDA #$EC1D             ;\
$90:F30B 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = inanimate Samus
$90:F30E 38          SEC                    ;\
$90:F30F 60          RTS                    ;} Return carry set
}


;;; $F310: Samus command 15h: lock Samus into suit pickup ;;;
{
; Called by:
;     $91:D4E4: Varia suit pick up
;     $91:D5BA: Gravity suit pick up
$90:F310 20 EE F0    JSR $F0EE  [$90:F0EE]  ; Update Samus previous pose
$90:F313 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:F316 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear flare animation state
$90:F319 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F31D 4C FC F2    JMP $F2FC  [$90:F2FC]  ; Go to lock Samus and set inanimate Samus drawing handler
}


;;; $F320: Samus command 12h: enable Samus blue flashing ;;;
{
; Called by:
;     $A3:EDEB: Enemy touch - enemy $DD7F (metroid)
;     $A9:F20E: Shitroid function - start draining Samus
$90:F320 A9 01 00    LDA #$0001             ;\
$90:F323 8D 4A 0A    STA $0A4A  [$7E:0A4A]  ;} Super special Samus palette flags = 1
$90:F326 18          CLC                    ;\
$90:F327 60          RTS                    ;} Return carry clear
}


;;; $F328: Samus command 13h: disable Samus blue flashing ;;;
{
; Called by:
;     $A3:EF07: Enemy shot - enemy $DD7F (metroid)
;     $A3:F042: Power bomb reaction - enemy $DD7F (metroid)
;     $A9:F21B: Shitroid function - draining Samus
$90:F328 9C 4A 0A    STZ $0A4A  [$7E:0A4A]  ; Super special Samus palette flags = 0
$90:F32B 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F32F 18          CLC                    ;\
$90:F330 60          RTS                    ;} Return carry clear
}


;;; $F331: Samus command 14h: queue low health and grapple sound effects ;;;
{
; Called by:
;     $82:BE2F: Queue Samus movement sound effects

; Typo: The LDA $0A1E at $F34F looks like it's supposed to be LDA $0A1F to check [Samus movement type] != spin jumping

$90:F331 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$90:F334 C9 1F 00    CMP #$001F             ;} If [Samus health] <= 30:
$90:F337 10 07       BPL $07    [$F340]     ;/
$90:F339 A9 02 00    LDA #$0002             ;\
$90:F33C 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2, sound library 3, max queued sounds allowed = 6 (low health beep)

$90:F340 20 B8 F2    JSR $F2B8  [$90:F2B8]  ;\
$90:F343 A8          TAY                    ;} If grapple beam is active:
$90:F344 F0 09       BEQ $09    [$F34F]     ;/
$90:F346 A9 06 00    LDA #$0006             ;\
$90:F349 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 6, sound library 1, max queued sounds allowed = 6 (grappling)
$90:F34D 18          CLC                    ;\
$90:F34E 60          RTS                    ;} Return carry clear

$90:F34F AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$90:F352 29 FF 00    AND #$00FF             ;|
$90:F355 C9 03 00    CMP #$0003             ;} If [Samus pose X direction] != 3: (always true)
$90:F358 F0 02       BEQ $02    [$F35C]     ;/
$90:F35A 18          CLC                    ;\
$90:F35B 60          RTS                    ;} Return carry clear

$90:F35C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:F35F C9 81 00    CMP #$0081             ;|
$90:F362 F0 21       BEQ $21    [$F385]     ;} If [Samus pose] = screw attack: go to BRANCH_SCREW_ATTACK
$90:F364 C9 82 00    CMP #$0082             ;|
$90:F367 F0 1C       BEQ $1C    [$F385]     ;/
$90:F369 C9 1B 00    CMP #$001B             ;\
$90:F36C F0 0E       BEQ $0E    [$F37C]     ;|
$90:F36E C9 1C 00    CMP #$001C             ;} If [Samus pose] = space jump: go to BRANCH_SPACE_JUMP
$90:F371 F0 09       BEQ $09    [$F37C]     ;/
$90:F373 A9 31 00    LDA #$0031             ;\
$90:F376 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 31h, sound library 1, max queued sounds allowed = 6 (spin jump)
$90:F37A 18          CLC                    ;\
$90:F37B 60          RTS                    ;} Return carry clear

; BRANCH_SPACE_JUMP
$90:F37C A9 3E 00    LDA #$003E             ;\
$90:F37F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Eh, sound library 1, max queued sounds allowed = 6 (space jump)
$90:F383 18          CLC                    ;\
$90:F384 60          RTS                    ;} Return carry clear

; BRANCH_SCREW_ATTACK
$90:F385 A9 33 00    LDA #$0033             ;\
$90:F388 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 33h, sound library 1, max queued sounds allowed = 6 (screw attack)
$90:F38C 18          CLC                    ;\
$90:F38D 60          RTS                    ;} Return carry clear
}


;;; $F38E: Samus command 5: set up Samus for being drained - able to stand ;;;
{
; Called by:
;     $A9:B975: Mother Brain body function - second phase - firing rainbow beam - start firing rainbow beam
$90:F38E A9 9B E0    LDA #$E09B             ;\
$90:F391 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E09B (handle letting Samus up from being drained)
}


;;; $F394: Set up Samus for being drained ;;;
{
$90:F394 A9 54 00    LDA #$0054             ;\
$90:F397 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - knockback
$90:F39A 9C 9A 0A    STZ $0A9A  [$7E:0A9A]  ; New pose Samus animation frame = 0
$90:F39D 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$90:F3A1 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$90:F3A5 20 EE F0    JSR $F0EE  [$90:F0EE]  ; Update Samus previous pose
$90:F3A8 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$90:F3AB 20 BE BC    JSR $BCBE  [$90:BCBE]  ; Clear charge beam animation state
$90:F3AE 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F3B2 A9 13 E7    LDA #$E713             ;\
$90:F3B5 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$90:F3B8 A9 D9 E8    LDA #$E8D9             ;\
$90:F3BB 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8D9 (RTL)
$90:F3BE 38          SEC                    ;\
$90:F3BF 60          RTS                    ;} Return carry set
}


;;; $F3C0: Samus command 18h: set up Samus for being drained - unable to stand ;;;
{
; Called by:
;     $A9:B975: Mother Brain body function - second phase - firing rainbow beam - start firing rainbow beam
$90:F3C0 A9 C5 E0    LDA #$E0C5             ;\
$90:F3C3 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E0C5 (handle letting Samus fail to stand up from being drained)
$90:F3C6 4C 94 F3    JMP $F394  [$90:F394]  ; Go to set up Samus for being drained
}


;;; $F3C9: Samus command 16h: enable rainbow Samus ;;;
{
; Called by:
;     $A9:CD30: Samus rainbow palette function - activate rainbow when enemy is low enough
$90:F3C9 A9 00 80    LDA #$8000             ;\
$90:F3CC 8D 4A 0A    STA $0A4A  [$7E:0A4A]  ;} Super special Samus palette flags = 8000h
$90:F3CF A9 01 00    LDA #$0001             ;\
$90:F3D2 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;} Rainbow Samus palette timer reset value = 1
$90:F3D5 8D D0 0A    STA $0AD0  [$7E:0AD0]  ; Rainbow Samus palette timer = 1
$90:F3D8 9C 62 0B    STZ $0B62  [$7E:0B62]  ; Samus' charge palette index = 0
$90:F3DB 18          CLC                    ;\
$90:F3DC 60          RTS                    ;} Return carry clear
}


;;; $F3DD: Samus command 17h: disable rainbow Samus and stand her up ;;;
{
; Called by:
;     $90:F54C: Debug command handler - disable rainbow Samus and stand her up if controller 2 Y is newly pressed
;     $A9:CCF0: Shitroid function - finish cutscene
$90:F3DD 9C 4A 0A    STZ $0A4A  [$7E:0A4A]  ; Super special Samus palette flags = 0
$90:F3E0 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Rainbow Samus palette timer reset value = 0
$90:F3E3 9C D0 0A    STZ $0AD0  [$7E:0AD0]  ; Rainbow Samus palette timer = 0
$90:F3E6 9C 62 0B    STZ $0B62  [$7E:0B62]  ; Samus' charge palette index = 0
$90:F3E9 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$90:F3ED A9 01 00    LDA #$0001             ;\
$90:F3F0 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$90:F3F3 A9 0D 00    LDA #$000D             ;\
$90:F3F6 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = Eh - 1 (Samus is let up)
$90:F3F9 18          CLC                    ;\
$90:F3FA 60          RTS                    ;} Return carry clear
}


;;; $F3FB: Samus command 19h: freeze drained Samus animation ;;;
{
; Called by:
;     $A9:CC7F: Shitroid function - prepare Samus for hyper beam acquisition
$90:F3FB A9 01 00    LDA #$0001             ;\
$90:F3FE 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$90:F401 A9 1C 00    LDA #$001C             ;\
$90:F404 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 1Dh - 1 (Samus is frozen)
$90:F407 38          SEC                    ;\
$90:F408 60          RTS                    ;} Return carry set
}


;;; $F409: Samus command 1Ah: Samus enters gunship ;;;
{
; Called by:
;     $A2:A9BD: Gunship function - handle letting Samus enter
$90:F409 A9 02 E9    LDA #$E902             ;\
$90:F40C 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E902 (entering/exiting gunship)
$90:F40F 18          CLC                    ;\
$90:F410 60          RTS                    ;} Return carry clear
}


;;; $F411: Samus command 1Bh: lock Samus for reserve tank ;;;
{
; Called by:
;     $82:DB69: Handle Samus running out of health and increment game time
$90:F411 AD 44 0A    LDA $0A44  [$7E:0A44]  ;\
$90:F414 C9 D9 E8    CMP #$E8D9             ;} If [Samus new state handler] != $E8D9 (Samus is being drained by rainbow beam):
$90:F417 F0 03       BEQ $03    [$F41C]     ;/
$90:F419 4C 09 F1    JMP $F109  [$90:F109]  ; Go to lock Samus

$90:F41C 38          SEC                    ;\
$90:F41D 60          RTS                    ;} Return carry set
}


;;; $F41E: Samus command 1Ch: play spin jump sound if spin jumping ;;;
{
; Called by:
;     $84:8270: Play spin jump sound if spin jumping
;     $91:D8A5: Handle misc. Samus palette
;     $9B:C856: Grapple beam function - hit nothing / cancel
$90:F41E AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:F421 29 FF 00    AND #$00FF             ;|
$90:F424 C9 14 00    CMP #$0014             ;} If [Samus movement type] = wall jumping: go to BRANCH_WALL_JUMP
$90:F427 F0 20       BEQ $20    [$F449]     ;/
$90:F429 C9 03 00    CMP #$0003             ;\
$90:F42C F0 02       BEQ $02    [$F430]     ;} If [Samus movement type] != spin jumping:
$90:F42E 18          CLC                    ;\
$90:F42F 60          RTS                    ;} Return carry clear

$90:F430 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:F433 C9 81 00    CMP #$0081             ;|
$90:F436 F0 30       BEQ $30    [$F468]     ;} If [Samus pose] = screw attacking: go to BRANCH_SCREW_ATTACK
$90:F438 C9 82 00    CMP #$0082             ;|
$90:F43B F0 2B       BEQ $2B    [$F468]     ;/
$90:F43D C9 1B 00    CMP #$001B             ;\
$90:F440 F0 1D       BEQ $1D    [$F45F]     ;|
$90:F442 C9 1C 00    CMP #$001C             ;} If [Samus pose] = space jumping: go to BRANCH_SPACE_JUMP
$90:F445 F0 18       BEQ $18    [$F45F]     ;/
$90:F447 80 0D       BRA $0D    [$F456]     ; Go to BRANCH_SPIN_JUMP

; BRANCH_WALL_JUMP
$90:F449 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$90:F44C C9 17 00    CMP #$0017             ;} If [Samus animation counter] >= 17h: go to BRANCH_SCREW_ATTACK
$90:F44F 10 17       BPL $17    [$F468]     ;/
$90:F451 C9 0D 00    CMP #$000D             ;\
$90:F454 10 09       BPL $09    [$F45F]     ;} If [Samus animation counter] >= Dh: go to BRANCH_SPACE_JUMP

; BRANCH_SPIN_JUMP
$90:F456 A9 31 00    LDA #$0031             ;\
$90:F459 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 31h, sound library 1, max queued sounds allowed = 9 (spin jump)
$90:F45D 18          CLC                    ;\
$90:F45E 60          RTS                    ;} Return carry clear

; BRANCH_SPACE_JUMP
$90:F45F A9 3E 00    LDA #$003E             ;\
$90:F462 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 3Eh, sound library 1, max queued sounds allowed = 9 (space jump)
$90:F466 18          CLC                    ;\
$90:F467 60          RTS                    ;} Return carry clear

; BRANCH_SCREW_ATTACK
$90:F468 A9 33 00    LDA #$0033             ;\
$90:F46B 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 33h, sound library 1, max queued sounds allowed = 9 (screw attack)
$90:F46F 18          CLC                    ;\
$90:F470 60          RTS                    ;} Return carry clear
}


;;; $F471: Samus command 1Dh: clear sounds when going through door ;;;
{
; Called by:
;     $84:8250: Clear sounds when going through door
$90:F471 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:F474 29 FF 00    AND #$00FF             ;|
$90:F477 C9 03 00    CMP #$0003             ;} If [Samus movement type] != wall jumping:
$90:F47A F0 05       BEQ $05    [$F481]     ;/
$90:F47C C9 14 00    CMP #$0014             ;\
$90:F47F D0 09       BNE $09    [$F48A]     ;} If [Samus movement type] != spin jumping: go to BRANCH_NOT_SPINNING

$90:F481 A9 32 00    LDA #$0032             ;\
$90:F484 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 15 (spin jump end)
$90:F488 18          CLC                    ;\
$90:F489 60          RTS                    ;} Return carry clear

; BRANCH_NOT_SPINNING
$90:F48A A5 8B       LDA $8B    [$7E:008B]  ;\
$90:F48C 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not pressing shoot:
$90:F48F D0 0F       BNE $0F    [$F4A0]     ;/
$90:F491 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:F494 C9 10 00    CMP #$0010             ;} If [beam charge] < 10h:
$90:F497 10 07       BPL $07    [$F4A0]     ;/
$90:F499 A9 02 00    LDA #$0002             ;\
$90:F49C 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 2, sound library 1, max queued sounds allowed = 15 (silence)

$90:F4A0 18          CLC                    ;\
$90:F4A1 60          RTS                    ;} Return carry clear
}


;;; $F4A2: Samus command 1Eh: resume sounds after power bomb explosion ;;;
{
; Called by:
;     $88:8B4E: Power bomb explosion - clean up and try crystal flash
$90:F4A2 AD 98 09    LDA $0998  [$7E:0998]  ;\
$90:F4A5 C9 08 00    CMP #$0008             ;} If [game state] != main gameplay: return carry clear
$90:F4A8 D0 24       BNE $24    [$F4CE]     ;/
$90:F4AA AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:F4AD 29 FF 00    AND #$00FF             ;|
$90:F4B0 C9 03 00    CMP #$0003             ;} If [Samus movement type] != wall jumping:
$90:F4B3 F0 05       BEQ $05    [$F4BA]     ;/
$90:F4B5 C9 14 00    CMP #$0014             ;\
$90:F4B8 D0 05       BNE $05    [$F4BF]     ;} If [Samus movement type] != spin jumping: go to BRANCH_NOT_SPINNING

$90:F4BA 20 1E F4    JSR $F41E  [$90:F41E]  ; Play spin jump sound if spin jumping
$90:F4BD 18          CLC                    ;\
$90:F4BE 60          RTS                    ;} Return carry clear

; BRANCH_NOT_SPINNING
$90:F4BF AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:F4C2 C9 10 00    CMP #$0010             ;} If [beam charge] >= 10h:
$90:F4C5 30 07       BMI $07    [$F4CE]     ;/
$90:F4C7 A9 41 00    LDA #$0041             ;\
$90:F4CA 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 41h, sound library 1, max queued sounds allowed = 9 (resume charging beam)

$90:F4CE 18          CLC                    ;\
$90:F4CF 60          RTS                    ;} Return carry clear
}


;;; $F4D0: Samus command 1Fh: kill grapple beam ;;;
{
; Called by:
;     $91:E3F6: Make Samus face forward
$90:F4D0 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$90:F4D3 C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] = inactive:
$90:F4D6 D0 02       BNE $02    [$F4DA]     ;/
$90:F4D8 18          CLC                    ;\
$90:F4D9 60          RTS                    ;} Return carry clear

$90:F4DA 9C 1E 0D    STZ $0D1E  [$7E:0D1E]  ; $0D1E = 0
$90:F4DD 9C 20 0D    STZ $0D20  [$7E:0D20]  ; $0D20 = 0
$90:F4E0 9C 34 0D    STZ $0D34  [$7E:0D34]  ; Direction grapple is fired = 0
$90:F4E3 9C 36 0D    STZ $0D36  [$7E:0D36]  ; Disable special grapple beam angle handling
$90:F4E6 9C 9E 0A    STZ $0A9E  [$7E:0A9E]  ; Grapple walljump timer = 0
$90:F4E9 9C F8 0C    STZ $0CF8  [$7E:0CF8]  ; Slow grapple scrolling flag = 0
$90:F4EC 9C F6 0C    STZ $0CF6  [$7E:0CF6]  ; Grapple pose change auto-fire timer = 0
$90:F4EF 9C F4 0C    STZ $0CF4  [$7E:0CF4]  ; Grapple beam flags = 0
$90:F4F2 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$90:F4F5 22 F0 AC 90 JSL $90ACF0[$90:ACF0]  ;} Load current beam palette
$90:F4F9 A9 F0 C4    LDA #$C4F0             ;\
$90:F4FC 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = inactive
$90:F4FF A9 52 EB    LDA #$EB52             ;\
$90:F502 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$90:F505 18          CLC                    ;\
$90:F506 60          RTS                    ;} Return carry clear
}
}


;;; $F507: Unused ;;;
{
; Similar to $F4A2, except this routine doesn't play spin jump sound if spin jumping
$90:F507 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:F50A 29 FF 00    AND #$00FF             ;|
$90:F50D C9 03 00    CMP #$0003             ;} If [Samus movement type] != spinning:
$90:F510 F0 1B       BEQ $1B    [$F52D]     ;/
$90:F512 C9 14 00    CMP #$0014             ;\
$90:F515 F0 16       BEQ $16    [$F52D]     ;} If [Samus movement type] != wall jumping:
$90:F517 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:F519 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If pressing shoot:
$90:F51C F0 0F       BEQ $0F    [$F52D]     ;/
$90:F51E AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:F521 C9 10 00    CMP #$0010             ;} If [beam charge] >= 10h:
$90:F524 30 07       BMI $07    [$F52D]     ;/
$90:F526 A9 41 00    LDA #$0041             ;\
$90:F529 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 41h, sound library 1, max queued sounds allowed = 9 (resume charging beam)

$90:F52D 18          CLC                    ;\
$90:F52E 60          RTS                    ;} Return carry clear
}


;;; $F52F..F575: Debug commands ;;;
{
;;; $F52F: Debug command handler ;;;
{
; RTS'd out as you can see
$90:F52F 60          RTS
$90:F530 6C 5E 0A    JMP ($0A5E)            ; Go to [debug command handler]
}


;;; $F533: RTS ;;;
{
$90:F533 60          RTS
}


;;; $F534: RTS ;;;
{
$90:F534 60          RTS
}


;;; $F535: Debug command handler - give Samus a shinespark if Y is newly pressed ;;;
{
$90:F535 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:F537 89 00 40    BIT #$4000             ;} If not newly pressed Y: return
$90:F53A F0 0F       BEQ $0F    [$F54B]     ;/
$90:F53C A9 B4 00    LDA #$00B4             ;\
$90:F53F 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 180
$90:F542 A9 01 00    LDA #$0001             ;\
$90:F545 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = 1 (speed booster shine)
$90:F548 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0

$90:F54B 60          RTS
}


;;; $F54C: Debug command handler - disable rainbow Samus and stand her up if controller 2 Y is newly pressed ;;;
{
$90:F54C A5 91       LDA $91    [$7E:0091]  ;\
$90:F54E 89 00 40    BIT #$4000             ;} If not newly pressed controller 2 Y: return
$90:F551 F0 0D       BEQ $0D    [$F560]     ;/
$90:F553 A9 17 00    LDA #$0017             ;\
$90:F556 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - disable rainbow Samus and stand her up
$90:F55A A9 34 F5    LDA #$F534             ;\
$90:F55D 8D 5E 0A    STA $0A5E  [$7E:0A5E]  ;} Debug command handler = RTS

$90:F560 60          RTS
}


;;; $F561: Debug command handler - release Samus from drained pose if Y newly pressed ;;;
{
$90:F561 A5 8F       LDA $8F    [$7E:008F]  ;\
$90:F563 89 00 40    BIT #$4000             ;} If not newly pressed Y: return
$90:F566 F0 0D       BEQ $0D    [$F575]     ;/
$90:F568 A9 34 F5    LDA #$F534             ;\
$90:F56B 8D 5E 0A    STA $0A5E  [$7E:0A5E]  ;} Debug command handler = RTS
$90:F56E A9 02 00    LDA #$0002             ;\
$90:F571 22 AD E4 91 JSL $91E4AD[$91:E4AD]  ;} Release Samus from drained pose

$90:F575 60          RTS
}
}


;;; $F576: Handle unspin sound effects, cancelling echo sound and setting time up game state ;;;
{
; Also enables debug invincibility if debug mode is enabled and controller 2 newly presses A whilst L + R is pressed
; The code at $90:E0E6 is supposed to set the time up game state, and also sets $0A5A to $E114
; The purpose of the code at $F619 checking for $0A5A = $E114 and setting the time up game state seems to be for handling edge cases like entering at door at timer = 00'00"00
$90:F576 08          PHP
$90:F577 C2 30       REP #$30
$90:F579 AD C0 0D    LDA $0DC0  [$7E:0DC0]  ;\
$90:F57C 30 60       BMI $60    [$F5DE]     ;} If [resume charging beam sound effect flag] & 8000h != 0 (never true): go to BRANCH_NEGATIVE
$90:F57E F0 11       BEQ $11    [$F591]     ; If [resume charging beam sound effect flag] != 0:
$90:F580 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:F582 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If pressing shoot:
$90:F585 F0 07       BEQ $07    [$F58E]     ;/
$90:F587 A9 41 00    LDA #$0041             ;\
$90:F58A 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 41h, sound library 1, max queued sounds allowed = 9 (resume charging beam)

$90:F58E 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0

$90:F591 AD 40 0B    LDA $0B40  [$7E:0B40]  ;\
$90:F594 F0 12       BEQ $12    [$F5A8]     ;} If Samus echoes sound is playing:
$90:F596 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$90:F599 89 00 04    BIT #$0400             ;} If not speed boosting:
$90:F59C D0 0A       BNE $0A    [$F5A8]     ;/
$90:F59E 9C 40 0B    STZ $0B40  [$7E:0B40]  ; Samus echo sound playing flag = 0
$90:F5A1 A9 25 00    LDA #$0025             ;\
$90:F5A4 22 25 91 80 JSL $809125[$80:9125]  ;} Queue sound 25h, sound library 3, max queued sounds allowed = 15 (silence)

$90:F5A8 AD 11 0A    LDA $0A11  [$7E:0A11]  ;\
$90:F5AB 29 FF 00    AND #$00FF             ;|
$90:F5AE C9 03 00    CMP #$0003             ;} If [Samus previous movement type] != spin jumping:
$90:F5B1 F0 05       BEQ $05    [$F5B8]     ;/
$90:F5B3 C9 14 00    CMP #$0014             ;\
$90:F5B6 D0 2C       BNE $2C    [$F5E4]     ;} If [Samus previous movement type] != wall jumping: go to BRANCH_NOT_UNSPINNING

$90:F5B8 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$90:F5BB 29 FF 00    AND #$00FF             ;|
$90:F5BE C9 03 00    CMP #$0003             ;} If [Samus movement type] = spin jumping: go to BRANCH_NOT_UNSPINNING
$90:F5C1 F0 21       BEQ $21    [$F5E4]     ;/
$90:F5C3 C9 14 00    CMP #$0014             ;\
$90:F5C6 F0 1C       BEQ $1C    [$F5E4]     ;} If [Samus movement type] = wall jumping: go to BRANCH_NOT_UNSPINNING
$90:F5C8 A9 32 00    LDA #$0032             ;\
$90:F5CB 22 21 90 80 JSL $809021[$80:9021]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 15 (spin jump end)
$90:F5CF AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$90:F5D2 C9 10 00    CMP #$0010             ;} If [beam charge counter] < 10h: go to BRANCH_NOT_RESUMING_CHARGE
$90:F5D5 30 0D       BMI $0D    [$F5E4]     ;/
$90:F5D7 A5 8B       LDA $8B    [$7E:008B]  ;\
$90:F5D9 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not pressing shoot: go to BRANCH_NOT_RESUMING_CHARGE
$90:F5DC F0 06       BEQ $06    [$F5E4]     ;/

; BRANCH_NEGATIVE
$90:F5DE A9 01 00    LDA #$0001             ;\
$90:F5E1 8D C0 0D    STA $0DC0  [$7E:0DC0]  ;} Resume charging beam sound effect flag = 1

; BRANCH_NOT_RESUMING_CHARGE
; BRANCH_NOT_UNSPINNING
$90:F5E4 AD D1 05    LDA $05D1  [$7E:05D1]  ;\
$90:F5E7 F0 30       BEQ $30    [$F619]     ;} If debug not enabled: go to BRANCH_DEBUG_END
$90:F5E9 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$90:F5EC F0 0F       BEQ $0F    [$F5FD]     ;} If [Samus pose] != facing forward - power suit:
$90:F5EE C9 9B 00    CMP #$009B             ;\
$90:F5F1 F0 0A       BEQ $0A    [$F5FD]     ;} If [Samus pose] != facing forward - varia/gravity suit:
$90:F5F3 AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$90:F5F6 C9 07 00    CMP #$0007             ;} If [debug invincibility] < 7: go to BRANCH_CLEAR_DEBUG_INVINCIBILITY
$90:F5F9 30 1B       BMI $1B    [$F616]     ;/
$90:F5FB 28          PLP                    ;\
$90:F5FC 60          RTS                    ;} Return

$90:F5FD A5 8D       LDA $8D    [$7E:008D]  ;\
$90:F5FF 29 30 00    AND #$0030             ;|
$90:F602 C9 30 00    CMP #$0030             ;} If controller 2 not pressing L + R: go to BRANCH_DEBUG_END
$90:F605 D0 12       BNE $12    [$F619]     ;/
$90:F607 A5 91       LDA $91    [$7E:0091]  ;\
$90:F609 89 80 00    BIT #$0080             ;} If controller 2 not newly pressed A: go to BRANCH_DEBUG_END
$90:F60C F0 0B       BEQ $0B    [$F619]     ;/
$90:F60E A9 07 00    LDA #$0007             ;\
$90:F611 8D E0 0D    STA $0DE0  [$7E:0DE0]  ;} Debug invincibility = 7
$90:F614 80 03       BRA $03    [$F619]     ; Go to BRANCH_DEBUG_END

; BRANCH_CLEAR_DEBUG_INVINCIBILITY
$90:F616 9C E0 0D    STZ $0DE0  [$7E:0DE0]  ; Debug invincibility = 0

; BRANCH_DEBUG_END
$90:F619 A9 0E 00    LDA #$000E             ;\
$90:F61C 22 33 82 80 JSL $808233[$80:8233]  ;} If Zebes timebomb set:
$90:F620 90 16       BCC $16    [$F638]     ;/
$90:F622 AD 5A 0A    LDA $0A5A  [$7E:0A5A]  ;\
$90:F625 C9 14 E1    CMP #$E114             ;} If [timer / Samus hack handler] = $E114 (draw timer):
$90:F628 D0 0E       BNE $0E    [$F638]     ;/
$90:F62A AD 98 09    LDA $0998  [$7E:0998]  ;\
$90:F62D C9 23 00    CMP #$0023             ;|
$90:F630 F0 06       BEQ $06    [$F638]     ;} Game state = 23h (time up)
$90:F632 A9 23 00    LDA #$0023             ;|
$90:F635 8D 98 09    STA $0998  [$7E:0998]  ;/

$90:F638 28          PLP
$90:F639 60          RTS
}


;;; $F63A: Free space ;;;
{
$90:F63A             fillto $918000, $FF       ; Free space
}
