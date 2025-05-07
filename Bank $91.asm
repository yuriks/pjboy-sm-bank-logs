;;; $8000..834D: Normal Samus pose input handler ;;;
{
;;; $8000: Normal Samus pose input handler ;;;
{
; Called by Samus pose input handlers other than x-ray (which uses $91:FCAF instead)
$91:8000 08          PHP
$91:8001 8B          PHB
$91:8002 4B          PHK                    ;\
$91:8003 AB          PLB                    ;} DB = $91
$91:8004 C2 30       REP #$30
$91:8006 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:8009 29 FF 00    AND #$00FF             ;|
$91:800C 0A          ASL A                  ;} Execute [$8014 + [Samus movement type] * 2]
$91:800D AA          TAX                    ;|
$91:800E FC 14 80    JSR ($8014,x)[$91:804D];/
$91:8011 AB          PLB
$91:8012 28          PLP
$91:8013 6B          RTL

$91:8014             dw 804D, ; 0: Standing
                        8066, ; 1: Running
                        806E, ; 2: Normal jumping
                        8076, ; 3: Spin jumping
                        807E, ; 4: Morph ball - on ground
                        8087, ; 5: Crouching
                        80B6, ; 6: Falling
                        8086, ; 7: Unused
                        810A, ; 8: Morph ball - falling
                        8112, ; 9: Unused
                        8113, ; Ah: Knockback / crystal flash ending
                        812D, ; Bh: Unused
                        8132, ; Ch: Unused
                        813A, ; Dh: Unused
                        8142, ; Eh: Turning around - on ground
                        8146, ; Fh: Crouching/standing/morphing/unmorphing transition
                        8147, ; 10h: Moonwalking
                        814F, ; 11h: Spring ball - on ground
                        8157, ; 12h: Spring ball - in air
                        815F, ; 13h: Spring ball - falling
                        8167, ; 14h: Wall jumping
                        816F, ; 15h: Ran into a wall
                        8181, ; 16h: Grappling
                        8189, ; 17h: Turning around - jumping
                        818D, ; 18h: Turning around - falling
                        8191, ; 19h: Damage boost
                        8199, ; 1Ah: Grabbed by Draygon
                        81A1  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $804C: RTS ;;;
{
$91:804C 60          RTS
}


;;; $804D: Normal Samus pose input handler - [Samus movement type] = standing ;;;
{
$91:804D 08          PHP
$91:804E C2 30       REP #$30
$91:8050 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:8053 F0 07       BEQ $07    [$805C]     ;|
$91:8055 C9 9B 00    CMP #$009B             ;} If not facing forward:
$91:8058 F0 02       BEQ $02    [$805C]     ;/
$91:805A 80 05       BRA $05    [$8061]     ; Go to NOT_FACING_FORWARD

$91:805C AD 18 0E    LDA $0E18  [$7E:0E18]  ;\
$91:805F D0 03       BNE $03    [$8064]     ;} If [elevator status] != inactive: return

; NOT_FACING_FORWARD
$91:8061 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table

$91:8064 28          PLP
$91:8065 60          RTS
}


;;; $8066: Normal Samus pose input handler - [Samus movement type] = running ;;;
{
$91:8066 08          PHP
$91:8067 C2 30       REP #$30
$91:8069 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:806C 28          PLP
$91:806D 60          RTS
}


;;; $806E: Normal Samus pose input handler - [Samus movement type] = normal jumping ;;;
{
$91:806E 08          PHP
$91:806F C2 30       REP #$30
$91:8071 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8074 28          PLP
$91:8075 60          RTS
}


;;; $8076: Normal Samus pose input handler - [Samus movement type] = spin jumping ;;;
{
$91:8076 08          PHP
$91:8077 C2 30       REP #$30
$91:8079 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:807C 28          PLP
$91:807D 60          RTS
}


;;; $807E: Normal Samus pose input handler - [Samus movement type] = morph ball - on ground ;;;
{
$91:807E 08          PHP
$91:807F C2 30       REP #$30
$91:8081 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8084 28          PLP
$91:8085 60          RTS
}


;;; $8086: RTS. Normal Samus pose input handler - [Samus movement type] = 7 ;;;
{
$91:8086 60          RTS
}


;;; $8087: Normal Samus pose input handler - [Samus movement type] = crouching ;;;
{
; Note that this routine is not called when time is frozen ([$0A42] = $E713 during reserve tanks, [$0A60] = $E918 during x-ray),
; so the call to $91:FCAF (x-ray) is dead code.
; I also don't think there's any way to transition directly from crouching to standing, (actually: check x-ray stand up)
; so the Y position adjustment is dead code too.

$91:8087 08          PHP
$91:8088 C2 30       REP #$30
$91:808A AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$91:808D D0 21       BNE $21    [$80B0]     ;} If time is not frozen:
$91:808F 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8092 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:8095 29 FF 00    AND #$00FF             ;} If [Samus movement type] != standing: return
$91:8098 D0 1A       BNE $1A    [$80B4]     ;/
$91:809A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:809D 38          SEC                    ;|
$91:809E E9 05 00    SBC #$0005             ;} Samus Y position -= 5
$91:80A1 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:80A4 AD 14 0B    LDA $0B14  [$7E:0B14]  ;\
$91:80A7 38          SEC                    ;|
$91:80A8 E9 05 00    SBC #$0005             ;} Samus previous Y position -= 5
$91:80AB 8D 14 0B    STA $0B14  [$7E:0B14]  ;/
$91:80AE 80 04       BRA $04    [$80B4]
                                            ; Else (time is frozen):
$91:80B0 22 AF FC 91 JSL $91FCAF[$91:FCAF]  ; X-ray Samus pose input handler

$91:80B4 28          PLP
$91:80B5 60          RTS
}


;;; $80B6: Normal Samus pose input handler - [Samus movement type] = falling ;;;
{
$91:80B6 08          PHP
$91:80B7 C2 30       REP #$30
$91:80B9 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:80BC 28          PLP
$91:80BD 60          RTS
}


;;; $80BE: Unused ;;;
{
; Tries to make Samus jump if pressing jump and she's falling straight down but has zero Y speed and she wasn't crouching before she fell...?
; Perhaps an earlier attempt at auto-jump
$91:80BE AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:80C1 C9 29 00    CMP #$0029             ;|
$91:80C4 F0 05       BEQ $05    [$80CB]     ;} If [Samus pose] != falling (not aiming): return
$91:80C6 C9 2A 00    CMP #$002A             ;|
$91:80C9 D0 3D       BNE $3D    [$8108]     ;/

$91:80CB AD 27 0A    LDA $0A27  [$7E:0A27]  ;\
$91:80CE 29 FF 00    AND #$00FF             ;|
$91:80D1 C9 05 00    CMP #$0005             ;} If [Samus last different pose movement type] = crouching: return
$91:80D4 F0 32       BEQ $32    [$8108]     ;/
$91:80D6 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:80D8 89 00 03    BIT #$0300             ;} If pressing left or right: return
$91:80DB D0 2B       BNE $2B    [$8108]     ;/
$91:80DD AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:80E0 D0 26       BNE $26    [$8108]     ;} If [Samus Y speed] != 0: return
$91:80E2 A5 8F       LDA $8F    [$7E:008F]  ;\
$91:80E4 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If not newly pressing jump: return
$91:80E7 F0 1F       BEQ $1F    [$8108]     ;/
$91:80E9 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:80EC 29 FF 00    AND #$00FF             ;|
$91:80EF C9 04 00    CMP #$0004             ;} If facing right:
$91:80F2 F0 08       BEQ $08    [$80FC]     ;/
$91:80F4 A9 4D 00    LDA #$004D             ;\
$91:80F7 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - normal jump - not aiming - not moving - gun not extended
$91:80FA 80 06       BRA $06    [$8102]

$91:80FC A9 4E 00    LDA #$004E             ;\
$91:80FF 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - normal jump - not aiming - not moving - gun not extended

$91:8102 A9 04 00    LDA #$0004             ;\
$91:8105 8D 30 0A    STA $0A30  [$7E:0A30]  ;} Special prospective pose change command = 4

$91:8108 28          PLP
$91:8109 60          RTS
}


;;; $810A: Normal Samus pose input handler - [Samus movement type] = morph ball - falling ;;;
{
$91:810A 08          PHP
$91:810B C2 30       REP #$30
$91:810D 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8110 28          PLP
$91:8111 60          RTS
}


;;; $8112: RTS. Normal Samus pose input handler - [Samus movement type] = 9 ;;;
{
$91:8112 60          RTS
}


;;; $8113: Normal Samus pose input handler - [Samus movement type] = knockback / crystal flash ending ;;;
{
; Only processes knockback in practice as [$0A60] = RTS during crystal flash, so this function never gets called.
; Samus movement type cannot be changed via $81A9... but if it did then Samus would jump(?!).
$91:8113 08          PHP
$91:8114 C2 30       REP #$30
$91:8116 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8119 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:811C 29 FF 00    AND #$00FF             ;|
$91:811F C9 0A 00    CMP #$000A             ;} If [Samus movement type] != knockback / crystal flash ending:
$91:8122 F0 07       BEQ $07    [$812B]     ;/
$91:8124 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump
$91:8128 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0

$91:812B 28          PLP
$91:812C 60          RTS
}


;;; $812D: RTS. Normal Samus pose input handler - [Samus movement type] = Bh ;;;
{
$91:812D 08          PHP
$91:812E C2 30       REP #$30
$91:8130 28          PLP
$91:8131 60          RTS
}


;;; $8132: Normal Samus pose input handler - [Samus movement type] = Ch ;;;
{
$91:8132 08          PHP
$91:8133 C2 30       REP #$30
$91:8135 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8138 28          PLP
$91:8139 60          RTS
}


;;; $813A: Normal Samus pose input handler - [Samus movement type] = Dh ;;;
{
$91:813A 08          PHP
$91:813B C2 30       REP #$30
$91:813D 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8140 28          PLP
$91:8141 60          RTS
}


;;; $8142: Normal Samus pose input handler - [Samus movement type] = turning around - on ground ;;;
{
$91:8142 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8145 60          RTS
}


;;; $8146: RTS. Normal Samus pose input handler - [Samus movement type] = crouching/standing/morphing/unmorphing transition ;;;
{
; 
$91:8146 60          RTS
}


;;; $8147: Normal Samus pose input handler - [Samus movement type] = moonwalking ;;;
{
$91:8147 08          PHP
$91:8148 C2 30       REP #$30
$91:814A 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:814D 28          PLP
$91:814E 60          RTS
}


;;; $814F: Normal Samus pose input handler - [Samus movement type] = spring ball - on ground ;;;
{
$91:814F 08          PHP
$91:8150 C2 30       REP #$30
$91:8152 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8155 28          PLP
$91:8156 60          RTS
}


;;; $8157: Normal Samus pose input handler - [Samus movement type] = spring ball - in air ;;;
{
$91:8157 08          PHP
$91:8158 C2 30       REP #$30
$91:815A 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:815D 28          PLP
$91:815E 60          RTS
}


;;; $815F: Normal Samus pose input handler - [Samus movement type] = spring ball - falling ;;;
{
$91:815F 08          PHP
$91:8160 C2 30       REP #$30
$91:8162 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8165 28          PLP
$91:8166 60          RTS
}


;;; $8167: Normal Samus pose input handler - [Samus movement type] = wall jumping ;;;
{
$91:8167 08          PHP
$91:8168 C2 30       REP #$30
$91:816A 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:816D 28          PLP
$91:816E 60          RTS
}


;;; $816F: Normal Samus pose input handler - [Samus movement type] = ran into a wall ;;;
{
; Note that this routine is not (under normal circumstances) called when time is frozen,
; [$0A42] = $E713 during reserve tanks, [$0A60] = $E918 during x-ray,
; so the broken call to $91:FCAF (x-ray) is (normally) not an issue

; In X-mode, touching a wall (by arm pumping) *will* cause this buggy code to execute and (almost certainly) crash the game
; This is because if x-ray is activated on the frame that knockback finishes,
; the knockback finish installs the normal pose input handler *after* x-ray does
$91:816F 08          PHP
$91:8170 C2 30       REP #$30
$91:8172 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$91:8175 D0 05       BNE $05    [$817C]     ;} If time is not frozen:
$91:8177 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:817A 80 03       BRA $03    [$817F]
                                            ; Else (time is frozen):
$91:817C 20 AF FC    JSR $FCAF  [$91:FCAF]  ; Execute $FCAF (bug, should be JSL)

$91:817F 28          PLP
$91:8180 60          RTS
}


;;; $8181: Normal Samus pose input handler - [Samus movement type] = grappling ;;;
{
$91:8181 08          PHP
$91:8182 C2 30       REP #$30
$91:8184 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8187 28          PLP
$91:8188 60          RTS
}


;;; $8189: Normal Samus pose input handler - [Samus movement type] = turning around - jumping ;;;
{
$91:8189 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:818C 60          RTS
}


;;; $818D: Normal Samus pose input handler - [Samus movement type] = turning around - falling ;;;
{
$91:818D 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8190 60          RTS
}


;;; $8191: Normal Samus pose input handler - [Samus movement type] = damage boost ;;;
{
$91:8191 08          PHP
$91:8192 C2 30       REP #$30
$91:8194 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:8197 28          PLP
$91:8198 60          RTS
}


;;; $8199: Normal Samus pose input handler - [Samus movement type] = grabbed by Draygon ;;;
{
$91:8199 08          PHP
$91:819A C2 30       REP #$30
$91:819C 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:819F 28          PLP
$91:81A0 60          RTS
}


;;; $81A1: Normal Samus pose input handler - [Samus movement type] = shinespark / crystal flash / drained by metroid / damaged by MB's attacks ;;;
{
$91:81A1 08          PHP
$91:81A2 C2 30       REP #$30
$91:81A4 20 A9 81    JSR $81A9  [$91:81A9]  ; Determine prospective pose from transition table
$91:81A7 28          PLP
$91:81A8 60          RTS
}


;;; $81A9: Determine prospective pose from transition table ;;;
{
;; Returns:
;;     Carry: Set if pose was found, clear otherwise

; Transition table entries have the format:
;     nnnn cccc pppp
;     nnnn cccc pppp
;     ...
;     FFFF
; where:
;     n is the required newly pressed input, n = FFFF terminates the table entry
;     c is the required held input
;     p is the pose to transition to (if not currently already in that pose)

; Iterate through transition table entry for current pose, if transition found with the required inputs being pressed:
;     If transition pose is the current pose, return carry clear
;     Else, set prospective pose and return carry set
; If not pressing nothing and transition table entry is empty, return carry clear
; Else, execute $91:82D9 and return carry clear

; $12: The controller 1 input bits *not* newly pressed (not including start/select)
; $14: The controller 1 input bits *not* pressed (not including start/select)
; [[Y]]: Required newly pressed input
; [[Y] + 2]: Required input
; If [[Y]] & [$12/14] != 0 then there were some buttons specified in [[Y]] that are not being pressed

$91:81A9 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:81AB F0 2E       BEQ $2E    [$81DB]     ;} If pressing nothing: go to BRANCH_NO_INPUT
$91:81AD 20 F4 81    JSR $81F4  [$91:81F4]  ; Translate custom controller bindings to default bindings
$91:81B0 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:81B3 0A          ASL A                  ;|
$91:81B4 AA          TAX                    ;} Y = [$9EE2 + [Samus pose] * 2] (transition table entry pointer)
$91:81B5 BD E2 9E    LDA $9EE2,x[$91:9EE6]  ;|
$91:81B8 A8          TAY                    ;/
$91:81B9 B9 00 00    LDA $0000,y[$91:A172]  ;\
$91:81BC 1A          INC A                  ;} If [[Y]] = FFFFh: return carry clear
$91:81BD F0 23       BEQ $23    [$81E2]     ;/

; LOOP
$91:81BF 3A          DEC A                  ;\
$91:81C0 F0 04       BEQ $04    [$81C6]     ;} If [[Y]] != 0 (required newly pressed input):
$91:81C2 25 12       AND $12    [$7E:0012]  ;\
$91:81C4 D0 09       BNE $09    [$81CF]     ;} If [[Y]] & [$12] != 0: go to BRANCH_NEXT

$91:81C6 B9 02 00    LDA $0002,y[$91:A1A4]  ;\
$91:81C9 F0 19       BEQ $19    [$81E4]     ;} If [[Y] + 2] = 0 (required input): go to BRANCH_FOUND_TRANSITION
$91:81CB 25 14       AND $14    [$7E:0014]  ;\
$91:81CD F0 15       BEQ $15    [$81E4]     ;} If [[Y] + 2] & [$14] = 0: go to BRANCH_FOUND_TRANSITION

; BRANCH_NEXT
$91:81CF 98          TYA                    ;\
$91:81D0 18          CLC                    ;|
$91:81D1 69 06 00    ADC #$0006             ;} Y += 6
$91:81D4 A8          TAY                    ;/
$91:81D5 B9 00 00    LDA $0000,y[$91:A178]  ;\
$91:81D8 1A          INC A                  ;} If [[Y]] != FFFFh: go to LOOP
$91:81D9 D0 E4       BNE $E4    [$81BF]     ;/

; BRANCH_NO_INPUT
$91:81DB 9C 18 0A    STZ $0A18  [$7E:0A18]  ; $0A18 = 0 (never read)
$91:81DE 22 D9 82 91 JSL $9182D9[$91:82D9]  ; Handle transition table lookup failure

$91:81E2 18          CLC                    ;\
$91:81E3 60          RTS                    ;} Return carry clear

; BRANCH_FOUND_TRANSITION
$91:81E4 B9 04 00    LDA $0004,y[$91:A1F4]  ;\
$91:81E7 CD 1C 0A    CMP $0A1C  [$7E:0A1C]  ;} If [[Y] + 4] = [Samus pose]: return carry clear
$91:81EA F0 F6       BEQ $F6    [$81E2]     ;/
$91:81EC 8D 28 0A    STA $0A28  [$7E:0A28]  ; Prospective pose = [[Y] + 4]
$91:81EF 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = 0
$91:81F2 38          SEC                    ;\
$91:81F3 60          RTS                    ;} Return carry set
}


;;; $81F4: Translate custom controller bindings to default bindings ;;;
{
;; Returns:
;;     $12: The controller 1 input bits *not* newly pressed (not including start/select)
;;     $14: The controller 1 input bits *not* pressed (not including start/select)

; This contains the evil code that disallows aiming to not be L and R
; $82:F587 handles the graphical part of the controller settings menu
$91:81F4 A5 8F       LDA $8F    [$7E:008F]  ;\
$91:81F6 29 00 0F    AND #$0F00             ;} $12 = newly pressed d-pad input
$91:81F9 85 12       STA $12    [$7E:0012]  ;/
$91:81FB A5 8B       LDA $8B    [$7E:008B]  ;\
$91:81FD 29 00 0F    AND #$0F00             ;} $14 = current d-pad input
$91:8200 85 14       STA $14    [$7E:0014]  ;/
$91:8202 A5 8F       LDA $8F    [$7E:008F]  ;\
$91:8204 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If newly pressed shoot:
$91:8207 F0 09       BEQ $09    [$8212]     ;/
$91:8209 A5 12       LDA $12    [$7E:0012]  ;\
$91:820B 09 40 00    ORA #$0040             ;|
$91:820E 85 12       STA $12    [$7E:0012]  ;} $12 |= X
$91:8210 A5 8F       LDA $8F    [$7E:008F]  ;/

$91:8212 2C B4 09    BIT $09B4  [$7E:09B4]  ;\
$91:8215 F0 09       BEQ $09    [$8220]     ;} If newly pressed jump:
$91:8217 A5 12       LDA $12    [$7E:0012]  ;\
$91:8219 09 80 00    ORA #$0080             ;|
$91:821C 85 12       STA $12    [$7E:0012]  ;} $12 |= A
$91:821E A5 8F       LDA $8F    [$7E:008F]  ;/

$91:8220 2C B6 09    BIT $09B6  [$7E:09B6]  ;\
$91:8223 F0 09       BEQ $09    [$822E]     ;} If newly pressed run:
$91:8225 A5 12       LDA $12    [$7E:0012]  ;\
$91:8227 09 00 80    ORA #$8000             ;|
$91:822A 85 12       STA $12    [$7E:0012]  ;} $12 |= B
$91:822C A5 8F       LDA $8F    [$7E:008F]  ;/

$91:822E 2C B8 09    BIT $09B8  [$7E:09B8]  ;\
$91:8231 F0 09       BEQ $09    [$823C]     ;} If newly pressed item cancel:
$91:8233 A5 12       LDA $12    [$7E:0012]  ;\
$91:8235 09 00 40    ORA #$4000             ;|
$91:8238 85 12       STA $12    [$7E:0012]  ;} $12 |= Y
$91:823A A5 8F       LDA $8F    [$7E:008F]  ;/

$91:823C 2C BE 09    BIT $09BE  [$7E:09BE]  ;\
$91:823F F0 11       BEQ $11    [$8252]     ;} If newly pressed aim up:
$91:8241 AD BE 09    LDA $09BE  [$7E:09BE]  ;\
$91:8244 89 30 00    BIT #$0030             ;} If aim up binding is L or R:
$91:8247 F0 07       BEQ $07    [$8250]     ;/
$91:8249 A5 12       LDA $12    [$7E:0012]  ;\
$91:824B 09 10 00    ORA #$0010             ;} $12 |= R
$91:824E 85 12       STA $12    [$7E:0012]  ;/

$91:8250 A5 8F       LDA $8F    [$7E:008F]

$91:8252 2C BC 09    BIT $09BC  [$7E:09BC]  ;\
$91:8255 F0 0F       BEQ $0F    [$8266]     ;} If newly pressed aim down:
$91:8257 AD BC 09    LDA $09BC  [$7E:09BC]  ;\
$91:825A 89 30 00    BIT #$0030             ;} If aim up binding is L or R:
$91:825D F0 07       BEQ $07    [$8266]     ;/
$91:825F A5 12       LDA $12    [$7E:0012]  ;\
$91:8261 09 20 00    ORA #$0020             ;} $12 |= L
$91:8264 85 12       STA $12    [$7E:0012]  ;/

$91:8266 A5 12       LDA $12    [$7E:0012]  ;\
$91:8268 49 FF FF    EOR #$FFFF             ;} $12 = ~[$12]
$91:826B 85 12       STA $12    [$7E:0012]  ;/
$91:826D A5 8B       LDA $8B    [$7E:008B]  ;\
$91:826F 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If pressing shoot:
$91:8272 F0 09       BEQ $09    [$827D]     ;/
$91:8274 A5 14       LDA $14    [$7E:0014]  ;\
$91:8276 09 40 00    ORA #$0040             ;|
$91:8279 85 14       STA $14    [$7E:0014]  ;} $14 |= X
$91:827B A5 8B       LDA $8B    [$7E:008B]  ;/

$91:827D 2C B4 09    BIT $09B4  [$7E:09B4]  ;\
$91:8280 F0 09       BEQ $09    [$828B]     ;} If pressing jump:
$91:8282 A5 14       LDA $14    [$7E:0014]  ;\
$91:8284 09 80 00    ORA #$0080             ;|
$91:8287 85 14       STA $14    [$7E:0014]  ;} $14 |= A
$91:8289 A5 8B       LDA $8B    [$7E:008B]  ;/

$91:828B 2C B6 09    BIT $09B6  [$7E:09B6]  ;\
$91:828E F0 09       BEQ $09    [$8299]     ;} If pressing run:
$91:8290 A5 14       LDA $14    [$7E:0014]  ;\
$91:8292 09 00 80    ORA #$8000             ;|
$91:8295 85 14       STA $14    [$7E:0014]  ;} $14 |= B
$91:8297 A5 8B       LDA $8B    [$7E:008B]  ;/

$91:8299 2C B8 09    BIT $09B8  [$7E:09B8]  ;\
$91:829C F0 09       BEQ $09    [$82A7]     ;} If pressing item cancel:
$91:829E A5 14       LDA $14    [$7E:0014]  ;\
$91:82A0 09 00 40    ORA #$4000             ;|
$91:82A3 85 14       STA $14    [$7E:0014]  ;} $14 |= Y
$91:82A5 A5 8B       LDA $8B    [$7E:008B]  ;/

$91:82A7 2C BE 09    BIT $09BE  [$7E:09BE]  ;\
$91:82AA F0 11       BEQ $11    [$82BD]     ;} If pressing aim up:
$91:82AC AD BE 09    LDA $09BE  [$7E:09BE]  ;\
$91:82AF 89 30 00    BIT #$0030             ;} If aim up binding is L or R:
$91:82B2 F0 07       BEQ $07    [$82BB]     ;/
$91:82B4 A5 14       LDA $14    [$7E:0014]  ;\
$91:82B6 09 10 00    ORA #$0010             ;} $14 |= R
$91:82B9 85 14       STA $14    [$7E:0014]  ;/

$91:82BB A5 8B       LDA $8B    [$7E:008B]

$91:82BD 2C BC 09    BIT $09BC  [$7E:09BC]  ;\
$91:82C0 F0 0F       BEQ $0F    [$82D1]     ;} If pressing aim down:
$91:82C2 AD BC 09    LDA $09BC  [$7E:09BC]  ;\
$91:82C5 89 30 00    BIT #$0030             ;} If aim up binding is L or R:
$91:82C8 F0 07       BEQ $07    [$82D1]     ;/
$91:82CA A5 14       LDA $14    [$7E:0014]  ;\
$91:82CC 09 20 00    ORA #$0020             ;} $14 |= L
$91:82CF 85 14       STA $14    [$7E:0014]  ;/

$91:82D1 A5 14       LDA $14    [$7E:0014]  ;\
$91:82D3 49 FF FF    EOR #$FFFF             ;} $14 = ~[$14]
$91:82D6 85 14       STA $14    [$7E:0014]  ;/
$91:82D8 60          RTS
}


;;; $82D9: Handle transition table lookup failure ;;;
{
; Also called when grapple beam is disconnected
$91:82D9 08          PHP
$91:82DA 8B          PHB
$91:82DB 4B          PHK                    ;\
$91:82DC AB          PLB                    ;} DB = $91
$91:82DD C2 30       REP #$30
$91:82DF 20 04 83    JSR $8304  [$91:8304]  ; Set prospective pose change command
$91:82E2 90 08       BCC $08    [$82EC]     ; If not retaining current pose: go to BRANCH_CONSULT_POSE_DEFINITION

; BRANCH_RETAIN_CURRENT_POSE
$91:82E4 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:82E7 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:82EA 80 15       BRA $15    [$8301]     ; Return

; BRANCH_CONSULT_POSE_DEFINITION
$91:82EC AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:82EF 0A          ASL A                  ;|
$91:82F0 0A          ASL A                  ;|
$91:82F1 0A          ASL A                  ;} A = [$B62B + [Samus pose] * 8] (new pose if not affected by buttons)
$91:82F2 AA          TAX                    ;|
$91:82F3 BD 2B B6    LDA $B62B,x[$91:B63B]  ;|
$91:82F6 29 FF 00    AND #$00FF             ;/
$91:82F9 C9 FF 00    CMP #$00FF             ;\
$91:82FC F0 E6       BEQ $E6    [$82E4]     ;} If [A] = FFh: go to BRANCH_RETAIN_CURRENT_POSE
$91:82FE 8D 28 0A    STA $0A28  [$7E:0A28]  ; Prospective pose = [A]

$91:8301 AB          PLB
$91:8302 28          PLP
$91:8303 6B          RTL
}


;;; $8304: Set prospective pose change command ;;;
{
;; Returns:
;;     Carry: Set if retaining current pose (i.e. command = decelerate), clear otherwise
$91:8304 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:8307 29 FF 00    AND #$00FF             ;|
$91:830A AA          TAX                    ;|
$91:830B BD 32 83    LDA $8332,x[$91:8332]  ;} If [$8332 + [Samus movement type]] = 1: go to BRANCH_DECELERATE
$91:830E 29 FF 00    AND #$00FF             ;|
$91:8311 C9 01 00    CMP #$0001             ;|
$91:8314 F0 05       BEQ $05    [$831B]     ;/

$91:8316 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ; Prospective pose change command = [$8332 + [Samus movement type]]
$91:8319 18          CLC                    ;\
$91:831A 60          RTS                    ;} Return carry clear

; BRANCH_DECELERATE
$91:831B AD 46 0B    LDA $0B46  [$7E:0B46]  ;\
$91:831E D0 0A       BNE $0A    [$832A]     ;|
$91:8320 AD 48 0B    LDA $0B48  [$7E:0B48]  ;} If [Samus X base speed] = 0.0:
$91:8323 D0 05       BNE $05    [$832A]     ;/
$91:8325 A9 02 00    LDA #$0002             ; Prospective pose change command = stop
$91:8328 80 EC       BRA $EC    [$8316]     ; Return carry clear

$91:832A A9 01 00    LDA #$0001             ;\
$91:832D 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = decelerate
$91:8330 38          SEC                    ;\
$91:8331 60          RTS                    ;} Return carry set

; Value for prospective pose change command. If 1 and [Samus X base speed] = 0, use 2 instead
$91:8332             db 02, ; 0: Standing
                        01, ; 1: Running
                        01, ; 2: Normal jumping
                        00, ; 3: Spin jumping
                        06, ; 4: Morph ball - on ground
                        02, ; 5: Crouching
                        08, ; 6: Falling
                        02, ; 7: Unused
                        01, ; 8: Morph ball - falling
                        06, ; 9: Unused
                        02, ; Ah: Knockback / crystal flash ending
                        02, ; Bh: Unused
                        02, ; Ch: Unused
                        06, ; Dh: Unused
                        02, ; Eh: Turning around - on ground
                        02, ; Fh: Crouching/standing/morphing/unmorphing transition
                        02, ; 10h: Moonwalking
                        06, ; 11h: Spring ball - on ground
                        06, ; 12h: Spring ball - in air
                        06, ; 13h: Spring ball - falling
                        06, ; 14h: Wall jumping
                        02, ; 15h: Ran into a wall
                        06, ; 16h: Grappling
                        02, ; 17h: Turning around - jumping
                        02, ; 18h: Turning around - falling
                        02, ; 19h: Damage boost
                        02, ; 1Ah: Grabbed by Draygon
                        02  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}
}


;;; $834E..9EE1: Demo ;;;
{
;;; $834E: Enable demo input ;;;
{
$91:834E 08          PHP
$91:834F C2 30       REP #$30
$91:8351 A9 1D E9    LDA #$E91D             ;\
$91:8354 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E91D (demo)
$91:8357 A9 00 80    LDA #$8000             ;\
$91:835A 0C 88 0A    TSB $0A88  [$7E:0A88]  ;} Enable demo input
$91:835D 28          PLP
$91:835E 6B          RTL
}


;;; $835F: Disable demo input ;;;
{
$91:835F 08          PHP
$91:8360 C2 30       REP #$30
$91:8362 A9 13 E9    LDA #$E913             ;\
$91:8365 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$91:8368 A9 00 80    LDA #$8000             ;\
$91:836B 1C 88 0A    TRB $0A88  [$7E:0A88]  ;} Disable demo input
$91:836E 28          PLP
$91:836F 6B          RTL
}


;;; $8370: Clear demo input RAM ;;;
{
; Called before calling $834E
$91:8370 08          PHP
$91:8371 C2 30       REP #$30
$91:8373 DA          PHX
$91:8374 9C 7A 0A    STZ $0A7A  [$7E:0A7A]  ; Demo input pre-instruction = 0
$91:8377 9C 7C 0A    STZ $0A7C  [$7E:0A7C]  ; Demo input instruction timer = 0
$91:837A 9C 7E 0A    STZ $0A7E  [$7E:0A7E]  ; Demo input instruction list pointer = 0
$91:837D 9C 80 0A    STZ $0A80  [$7E:0A80]  ; Demo input timer = 0
$91:8380 9C 82 0A    STZ $0A82  [$7E:0A82]  ; Demo input initialisation parameter = 0
$91:8383 9C 84 0A    STZ $0A84  [$7E:0A84]  ; Demo input = 0
$91:8386 9C 86 0A    STZ $0A86  [$7E:0A86]  ; Demo newly pressed input = 0
$91:8389 9C 8C 0A    STZ $0A8C  [$7E:0A8C]  ; Previous demo input = 0
$91:838C 9C 8E 0A    STZ $0A8E  [$7E:0A8E]  ; Previous demo newly pressed input = 0
$91:838F 9C 88 0A    STZ $0A88  [$7E:0A88]  ; Disable demo input
$91:8392 FA          PLX
$91:8393 28          PLP
$91:8394 6B          RTL
}


;;; $8395: Load demo input object ;;;
{
;; Parameters:
;;     A: Initialisation parameter
;;     Y: Pointer to demo input object
$91:8395 08          PHP
$91:8396 8B          PHB
$91:8397 4B          PHK                    ;\
$91:8398 AB          PLB                    ;} DB = $91
$91:8399 C2 30       REP #$30
$91:839B DA          PHX
$91:839C 8D 82 0A    STA $0A82  [$7E:0A82]  ; $0A82 = [A]
$91:839F BB          TYX                    ; X = [Y]
$91:83A0 BD 02 00    LDA $0002,x[$91:8786]  ;\
$91:83A3 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;} Demo input pre-instruction = [[X] + 2]
$91:83A6 BD 04 00    LDA $0004,x[$91:8788]  ;\
$91:83A9 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;} Demo input instruction list pointer = [[X] + 4] (instruction list pointer)
$91:83AC A9 01 00    LDA #$0001             ;\
$91:83AF 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ;} Demo input instruction timer = 1
$91:83B2 A9 00 00    LDA #$0000             ;\
$91:83B5 8D 80 0A    STA $0A80  [$7E:0A80]  ;} Demo input timer = 0
$91:83B8 FC 00 00    JSR ($0000,x)[$91:83BF]; Execute [[X]] (RTS)
$91:83BB FA          PLX
$91:83BC AB          PLB
$91:83BD 28          PLP
$91:83BE 6B          RTL
}


;;; $83BF: RTS ;;;
{
$91:83BF 60          RTS
}


;;; $83C0: Demo input object handler ;;;
{
$91:83C0 08          PHP
$91:83C1 8B          PHB
$91:83C2 4B          PHK                    ;\
$91:83C3 AB          PLB                    ;} DB = $91
$91:83C4 C2 30       REP #$30
$91:83C6 2C 88 0A    BIT $0A88  [$7E:0A88]  ;\
$91:83C9 10 24       BPL $24    [$83EF]     ;} If demo input not enabled: return
$91:83CB AD 7E 0A    LDA $0A7E  [$7E:0A7E]  ;\
$91:83CE F0 1F       BEQ $1F    [$83EF]     ;} If [demo input instruction list pointer] = 0: return
$91:83D0 20 F2 83    JSR $83F2  [$91:83F2]  ; Process demo input object
$91:83D3 AD 8C 0A    LDA $0A8C  [$7E:0A8C]  ;\
$91:83D6 8D FE 0D    STA $0DFE  [$7E:0DFE]  ;} Previous controller 1 input = [previous demo input]
$91:83D9 AD 8E 0A    LDA $0A8E  [$7E:0A8E]  ;\
$91:83DC 8D 00 0E    STA $0E00  [$7E:0E00]  ;} Previous newly pressed controller 1 input = [previous demo newly pressed input]
$91:83DF AD 84 0A    LDA $0A84  [$7E:0A84]  ;\
$91:83E2 85 8B       STA $8B    [$7E:008B]  ;} Controller 1 input = [demo input]
$91:83E4 8D 8C 0A    STA $0A8C  [$7E:0A8C]  ; Previous demo input = [demo input]
$91:83E7 AD 86 0A    LDA $0A86  [$7E:0A86]  ;\
$91:83EA 85 8F       STA $8F    [$7E:008F]  ;} Newly pressed controller 1 input = [demo newly pressed input]
$91:83EC 8D 8E 0A    STA $0A8E  [$7E:0A8E]  ; Previous demo newly pressed input = [demo newly pressed input]

$91:83EF AB          PLB
$91:83F0 28          PLP
$91:83F1 6B          RTL
}


;;; $83F2: Process demo input object ;;;
{
$91:83F2 A2 00 00    LDX #$0000             ;\
$91:83F5 FC 7A 0A    JSR ($0A7A,x)[$91:83BF];} Execute [demo input pre-instruction]
$91:83F8 CE 7C 0A    DEC $0A7C  [$7E:0A7C]  ; Decrement demo input instruction timer
$91:83FB D0 29       BNE $29    [$8426]     ; If [demo input instruction timer] != 0: return
$91:83FD AC 7E 0A    LDY $0A7E  [$7E:0A7E]  ; Y = [demo input instruction list pointer]

; LOOP
$91:8400 B9 00 00    LDA $0000,y[$91:8694]  ;\
$91:8403 10 0A       BPL $0A    [$840F]     ;} If [[Y]] & 8000h != 0:
$91:8405 85 12       STA $12    [$7E:0012]  ; $12 = [[Y]]
$91:8407 C8          INY                    ;\
$91:8408 C8          INY                    ;} Y += 2
$91:8409 F4 FF 83    PEA $83FF              ; Return to LOOP
$91:840C 6C 12 00    JMP ($0012)[$91:8739]  ; Go to [$12]

$91:840F 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ; Demo input instruction timer = [[Y]]
$91:8412 B9 02 00    LDA $0002,y[$91:8696]  ;\
$91:8415 8D 84 0A    STA $0A84  [$7E:0A84]  ;} Demo input [[Y] + 2]
$91:8418 B9 04 00    LDA $0004,y[$91:8698]  ;\
$91:841B 8D 86 0A    STA $0A86  [$7E:0A86]  ;} Demo newly pressed input [[Y] + 4]
$91:841E 98          TYA                    ;\
$91:841F 18          CLC                    ;|
$91:8420 69 06 00    ADC #$0006             ;} Demo input instruction list pointer = [Y] + 6
$91:8423 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;/

$91:8426 60          RTS
}


;;; $8427: Instruction - delete ;;;
{
$91:8427 C2 30       REP #$30
$91:8429 9C 7E 0A    STZ $0A7E  [$7E:0A7E]  ; Demo input instruction list pointer = 0
$91:842C 9C 84 0A    STZ $0A84  [$7E:0A84]  ; Demo input = 0
$91:842F 9C 86 0A    STZ $0A86  [$7E:0A86]  ; Demo newly pressed input = 0
$91:8432 68          PLA                    ; Terminate processing demo input object
$91:8433 60          RTS
}


;;; $8434: Instruction - pre-instruction = [[Y]] ;;;
{
$91:8434 C2 30       REP #$30
$91:8436 B9 00 00    LDA $0000,y
$91:8439 8D 7A 0A    STA $0A7A  [$7E:0A7A]
$91:843C C8          INY
$91:843D C8          INY
$91:843E 60          RTS
}


;;; $843F: Instruction - clear pre-instruction ;;;
{
$91:843F C2 30       REP #$30
$91:8441 A9 47 84    LDA #$8447
$91:8444 8D 7A 0A    STA $0A7A  [$7E:0A7A]
$91:8447 60          RTS
}


;;; $8448: Instruction - go to [[Y]] ;;;
{
$91:8448 C2 30       REP #$30
$91:844A B9 00 00    LDA $0000,y[$91:8621]
$91:844D A8          TAY
$91:844E 60          RTS
}


;;; $844F: Instruction - decrement timer and go to [[Y]] if non-zero ;;;
{
$91:844F C2 30       REP #$30
$91:8451 CE 80 0A    DEC $0A80  [$7E:0A80]
$91:8454 D0 F2       BNE $F2    [$8448]
$91:8456 C8          INY
$91:8457 C8          INY
$91:8458 60          RTS
}


;;; $8459: Instruction - timer = [[Y]] ;;;
{
$91:8459 C2 30       REP #$30
$91:845B B9 00 00    LDA $0000,y
$91:845E 8D 80 0A    STA $0A80  [$7E:0A80]
$91:8461 C8          INY
$91:8462 C8          INY
$91:8463 60          RTS
}


;;; $8464: Record demo input frame ;;;
{
; Controller 2 Y enables recording
$91:8464 08          PHP
$91:8465 8B          PHB
$91:8466 4B          PHK                    ;\
$91:8467 AB          PLB                    ;} DB = $91
$91:8468 C2 30       REP #$30
$91:846A AD 8A 0A    LDA $0A8A  [$7E:0A8A]  ;\
$91:846D 29 FF 7F    AND #$7FFF             ;} $0E24 = [recorded demo duration] & 7FFFh
$91:8470 8D 24 0E    STA $0E24  [$7E:0E24]  ;/
$91:8473 A9 E0 00    LDA #$00E0             ;\
$91:8476 8D 20 0E    STA $0E20  [$7E:0E20]  ;} $0E20 = E0h (X position)
$91:8479 A9 38 00    LDA #$0038             ;\
$91:847C 8D 22 0E    STA $0E22  [$7E:0E22]  ;} $0E22 = 38h (Y position)
$91:847F 20 2F 85    JSR $852F  [$91:852F]  ; Draw recorded demo duration
$91:8482 AD 8A 0A    LDA $0A8A  [$7E:0A8A]  ;\
$91:8485 30 4B       BMI $4B    [$84D2]     ;} If demo is not being recorded: return
$91:8487 D0 07       BNE $07    [$8490]     ; If [recorded demo duration] = 0:
$91:8489 A5 91       LDA $91    [$7E:0091]  ;\
$91:848B 89 00 40    BIT #$4000             ;} If controller 2 not newly pressed Y: return
$91:848E F0 42       BEQ $42    [$84D2]     ;/

$91:8490 AD 8A 0A    LDA $0A8A  [$7E:0A8A]  ;\
$91:8493 0A          ASL A                  ;|
$91:8494 0A          ASL A                  ;|
$91:8495 85 12       STA $12    [$7E:0012]  ;} X = [recorded demo duration] * Ch
$91:8497 0A          ASL A                  ;|
$91:8498 65 12       ADC $12    [$7E:0012]  ;|
$91:849A AA          TAX                    ;/
$91:849B A5 8B       LDA $8B    [$7E:008B]  ;\
$91:849D 9F 00 80 B8 STA $B88000,x          ;} $B8:8000 + [X] = [controller 1 input]
$91:84A1 A5 8F       LDA $8F    [$7E:008F]  ;\
$91:84A3 9F 02 80 B8 STA $B88002,x          ;} $B8:8000 + [X] + 2 = [newly pressed controller 1 input]
$91:84A7 AD 11 09    LDA $0911  [$7E:0911]  ;\
$91:84AA 9F 04 80 B8 STA $B88004,x          ;} $B8:8000 + [X] + 4 = [layer 1 X position]
$91:84AE AD 15 09    LDA $0915  [$7E:0915]  ;\
$91:84B1 9F 06 80 B8 STA $B88006,x          ;} $B8:8000 + [X] + 6 = [layer 1 Y position]
$91:84B5 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:84B8 9F 08 80 B8 STA $B88008,x          ;} $B8:8000 + [X] + 8 = [Samus X position]
$91:84BC AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:84BF 9F 0A 80 B8 STA $B8800A,x          ;} $B8:8000 + [X] + Ah = [Samus Y position]
$91:84C3 AD 8A 0A    LDA $0A8A  [$7E:0A8A]  ;\
$91:84C6 1A          INC A                  ;|
$91:84C7 C9 00 0A    CMP #$0A00             ;|
$91:84CA D0 03       BNE $03    [$84CF]     ;} Recorded demo duration = ([recorded demo duration] + 1) % A00h
$91:84CC A9 00 00    LDA #$0000             ;|
                                            ;|
$91:84CF 8D 8A 0A    STA $0A8A  [$7E:0A8A]  ;/

$91:84D2 AB          PLB
$91:84D3 28          PLP
$91:84D4 6B          RTL
}


;;; $84D5: Pause/terminate/reset demo recorder ;;;
{
; Controller 2 X pauses/terminates demo recorder
; Controller 2 A resets demo recorder
$91:84D5 08          PHP
$91:84D6 8B          PHB
$91:84D7 4B          PHK                    ;\
$91:84D8 AB          PLB                    ;} DB = $91
$91:84D9 C2 30       REP #$30
$91:84DB A5 91       LDA $91    [$7E:0091]  ;\
$91:84DD 89 40 00    BIT #$0040             ;} If controller 2 newly pressed X:
$91:84E0 F0 3D       BEQ $3D    [$851F]     ;/
$91:84E2 AD 8A 0A    LDA $0A8A  [$7E:0A8A]  ;\
$91:84E5 0A          ASL A                  ;|
$91:84E6 0A          ASL A                  ;|
$91:84E7 85 12       STA $12    [$7E:0012]  ;} X = [recorded demo duration] * Ch
$91:84E9 0A          ASL A                  ;|
$91:84EA 65 12       ADC $12    [$7E:0012]  ;|
$91:84EC AA          TAX                    ;/
$91:84ED A9 FF FF    LDA #$FFFF             ;\
$91:84F0 9F 00 80 B8 STA $B88000,x          ;|
$91:84F4 9F 02 80 B8 STA $B88002,x          ;|
$91:84F8 9F 04 80 B8 STA $B88004,x          ;} Write Ch bytes of FFFFh to $B8:8000 + [X]
$91:84FC 9F 06 80 B8 STA $B88006,x          ;|
$91:8500 9F 08 80 B8 STA $B88008,x          ;|
$91:8504 9F 0A 80 B8 STA $B8800A,x          ;/
$91:8508 AD 8F 07    LDA $078F  [$7E:078F]  ;\
$91:850B 8F 00 FF B8 STA $B8FF00[$B8:FF00]  ;} $B8:FF00 = [door BTS]
$91:850F AD 9F 07    LDA $079F  [$7E:079F]  ;\
$91:8512 8F 02 FF B8 STA $B8FF02[$B8:FF02]  ;} $B8:FF02 = [area index]
$91:8516 AD 8A 0A    LDA $0A8A  [$7E:0A8A]  ;\
$91:8519 09 00 80    ORA #$8000             ;} Set demo as not being recorded
$91:851C 8D 8A 0A    STA $0A8A  [$7E:0A8A]  ;/

$91:851F A5 91       LDA $91    [$7E:0091]  ;\
$91:8521 89 80 00    BIT #$0080             ;} If controller 2 newly pressed A:
$91:8524 F0 06       BEQ $06    [$852C]     ;/
$91:8526 A9 00 00    LDA #$0000             ;\
$91:8529 8D 8A 0A    STA $0A8A  [$7E:0A8A]  ;} Recorded demo duration = 0

$91:852C AB          PLB
$91:852D 28          PLP
$91:852E 6B          RTL
}


;;; $852F: Draw recorded demo duration ;;;
{
;; Parameters:
;;     $0E20: X position
;;     $0E22: Y position
;;     $0E24: Recorded demo duration
$91:852F AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$91:8532 18          CLC                    ;|
$91:8533 69 00 00    ADC #$0000             ;} $14 = [$0E20] (X position)
$91:8536 85 14       STA $14    [$7E:0014]  ;/
$91:8538 AD 22 0E    LDA $0E22  [$7E:0E22]  ;\
$91:853B 18          CLC                    ;|
$91:853C 69 00 00    ADC #$0000             ;} $12 = [$0E22] (Y position)
$91:853F 85 12       STA $12    [$7E:0012]  ;/
$91:8541 A9 00 0A    LDA #$0A00             ;\
$91:8544 85 26       STA $26    [$7E:0026]  ;} $26 = A00h (palette 5)
$91:8546 AD 24 0E    LDA $0E24  [$7E:0E24]  ;\
$91:8549 29 00 F0    AND #$F000             ;|
$91:854C EB          XBA                    ;|
$91:854D 4A          LSR A                  ;|
$91:854E 4A          LSR A                  ;} A = 4 + [$0E24] / 1000h (first digit)
$91:854F 4A          LSR A                  ;|
$91:8550 4A          LSR A                  ;|
$91:8551 18          CLC                    ;|
$91:8552 69 04 00    ADC #$0004             ;/
$91:8555 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap to OAM
$91:8559 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$91:855C 18          CLC                    ;|
$91:855D 69 08 00    ADC #$0008             ;} $14 = [$0E20] + 8 (X position)
$91:8560 85 14       STA $14    [$7E:0014]  ;/
$91:8562 AD 22 0E    LDA $0E22  [$7E:0E22]  ;\
$91:8565 18          CLC                    ;|
$91:8566 69 00 00    ADC #$0000             ;} $12 = [$0E22] (Y position)
$91:8569 85 12       STA $12    [$7E:0012]  ;/
$91:856B A9 00 0A    LDA #$0A00             ;\
$91:856E 85 26       STA $26    [$7E:0026]  ;} $26 = A00h (palette 5)
$91:8570 AD 24 0E    LDA $0E24  [$7E:0E24]  ;\
$91:8573 29 00 0F    AND #$0F00             ;|
$91:8576 EB          XBA                    ;} A = 4 + [$0E24] / 10h % Fh (second digit)
$91:8577 18          CLC                    ;|
$91:8578 69 04 00    ADC #$0004             ;/
$91:857B 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap to OAM
$91:857F AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$91:8582 18          CLC                    ;|
$91:8583 69 10 00    ADC #$0010             ;} $14 = [$0E20] + 100h (X position)
$91:8586 85 14       STA $14    [$7E:0014]  ;/
$91:8588 AD 22 0E    LDA $0E22  [$7E:0E22]  ;\
$91:858B 18          CLC                    ;|
$91:858C 69 00 00    ADC #$0000             ;} $12 = [$0E22] (Y position)
$91:858F 85 12       STA $12    [$7E:0012]  ;/
$91:8591 A9 00 0A    LDA #$0A00             ;\
$91:8594 85 26       STA $26    [$7E:0026]  ;} $26 = A00h (palette 5)
$91:8596 AD 24 0E    LDA $0E24  [$7E:0E24]  ;\
$91:8599 29 F0 00    AND #$00F0             ;|
$91:859C 4A          LSR A                  ;|
$91:859D 4A          LSR A                  ;|
$91:859E 4A          LSR A                  ;} A = 4 + [$0E24] / 10h % Fh (third digit)
$91:859F 4A          LSR A                  ;|
$91:85A0 18          CLC                    ;|
$91:85A1 69 04 00    ADC #$0004             ;/
$91:85A4 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap to OAM
$91:85A8 AD 20 0E    LDA $0E20  [$7E:0E20]  ;\
$91:85AB 18          CLC                    ;|
$91:85AC 69 18 00    ADC #$0018             ;} $14 = [$0E20] + 18h (X position)
$91:85AF 85 14       STA $14    [$7E:0014]  ;/
$91:85B1 A9 00 0A    LDA #$0A00             ;\
$91:85B4 85 26       STA $26    [$7E:0026]  ;|
$91:85B6 AD 22 0E    LDA $0E22  [$7E:0E22]  ;} $12 = [$0E22] (Y position)
$91:85B9 18          CLC                    ;/
$91:85BA 69 00 00    ADC #$0000             ;\
$91:85BD 85 12       STA $12    [$7E:0012]  ;} $26 = A00h (palette 5)
$91:85BF AD 24 0E    LDA $0E24  [$7E:0E24]  ;\
$91:85C2 29 0F 00    AND #$000F             ;|
$91:85C5 18          CLC                    ;} A = 4 + [$0E24] % Fh (fourth digit)
$91:85C6 69 04 00    ADC #$0004             ;/
$91:85C9 22 1D A0 B4 JSL $B4A01D[$B4:A01D]  ; Add debug spritemap to OAM
$91:85CD 60          RTS
}


;;; $85CE: Instruction list - demo input - demo input object $8778 ;;;
{
$91:85CE             dx 001E,0000,0000, ;
                        0001,0200,0200, ;       <
                        001A,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0034,0280,0000, ;       < A
                        001E,0200,0000, ;       <
                        0049,0000,0000, ;
                        85FC,           ; End demo input and give control back to player
                        8427            ; Delete
}


;;; $85FC: Instruction - end demo input and give control back to player ;;;
{
$91:85FC A9 95 E6    LDA #$E695             ;\
$91:85FF 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E695 (normal)
$91:8602 A9 25 E7    LDA #$E725             ;\
$91:8605 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E725 (normal)
$91:8608 22 5F 83 91 JSL $91835F[$91:835F]  ; Disable demo input
$91:860C 60          RTS
}


;;; $860D: Instruction list - demo input - baby metroid discovery - running left ;;;
{
$91:860D             dx 005A,0000,0000, ;
                        0001,0200,0200  ;       <
$91:8619             dx 0001,0200,0000, ;       <
                        8448,8619       ; Go to $8619
}


;;; $8623: Instruction list - demo input - baby metroid discovery - stop and look ;;;
{
$91:8623             dx 012C,0000,0000, ;
                        0001,0010,0010, ;            R
                        00AA,0010,0000, ;            R
                        00F0,0000,0000, ;
                        0001,0200,0200  ;       <
$91:8641             dx 0001,0200,0000, ;       <
                        8448,8641       ; Go to $8641
}


;;; $864B: Instruction list - demo input - baby metroid discovery - end ;;;
{
$91:864B             dx 8682,           ; End demo input
                        8427            ; Delete
}


;;; $864F: Pre-instruction - demo input - baby metroid discovery - running left ;;;
{
$91:864F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:8652 C9 B2 00    CMP #$00B2             ;} If [Samus X position] < B2h:
$91:8655 10 12       BPL $12    [$8669]     ;/
$91:8657 A9 6A 86    LDA #$866A             ;\
$91:865A 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;} Demo input pre-instruction = $866A
$91:865D A9 23 86    LDA #$8623             ;\
$91:8660 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;} Demo input instruction list pointer = $8623
$91:8663 A9 01 00    LDA #$0001             ;\
$91:8666 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ;} Demo input instruction timer = 1

$91:8669 60          RTS
}


;;; $866A: Pre-instruction - demo input - baby metroid discovery - stop and look ;;;
{
$91:866A AD 4B 1A    LDA $1A4B  [$7E:1A4B]  ;\
$91:866D D0 12       BNE $12    [$8681]     ;} If [$1A4B] = 0:
$91:866F A9 BF 83    LDA #$83BF             ;\
$91:8672 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;} Demo input pre-instruction = RTS
$91:8675 A9 4B 86    LDA #$864B             ;\
$91:8678 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;} Demo input instruction list pointer = $864B
$91:867B A9 01 00    LDA #$0001             ;\
$91:867E 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ;} Demo input instruction timer = 1

$91:8681 60          RTS
}


;;; $8682: Instruction - end demo input ;;;
{
$91:8682 DA          PHX
$91:8683 5A          PHY
$91:8684 A9 CD E8    LDA #$E8CD             ;\
$91:8687 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = RTL
$91:868A 8D 44 0A    STA $0A44  [$7E:0A44]  ; Samus new state handler = RTL
$91:868D 22 5F 83 91 JSL $91835F[$91:835F]  ; Disable demo input
$91:8691 7A          PLY
$91:8692 FA          PLX
$91:8693 60          RTS
}


;;; $8694: Instruction list - demo input - old Mother Brain fight ;;;
{
$91:8694             dx 005A,0000,0000, ;
                        0001,0040,0040, ;          X
                        0028,0040,0000, ;          X
                        0001,0040,0040, ;          X
                        001D,0040,0000, ;          X
                        0046,0000,0000  ;
}


;;; $86B8: Instruction list - demo input - demo input object $878A ;;;
{
$91:86B8             dx 0014,0000,0000, ;
                        0001,0200,0200, ;       <
                        0007,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0007,0280,0000, ;       < A
                        0004,0200,0000, ;       <
                        003C,0000,0000, ;
                        0001,0040,0040, ;          X
                        0028,0040,0000, ;          X
                        0001,0040,0040, ;          X
                        0013,0040,0000, ;          X
                        8739,           ; End demo input with Samus facing left
                        8427            ; Delete
}


;;; $86FE: Unused. End demo input with Samus facing left ;;;
{
; Clone of $8739
$91:86FE DA          PHX
$91:86FF 5A          PHY
$91:8700 A9 13 E7    LDA #$E713             ;\
$91:8703 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$91:8706 A9 02 00    LDA #$0002             ;\
$91:8709 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - normal
$91:870C 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:8710 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:8714 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:8717 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:871A AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:871D 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:8720 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:8723 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:8726 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:8729 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$91:872C 22 5F 83 91 JSL $91835F[$91:835F]  ; Disable demo input
$91:8730 A9 0E E9    LDA #$E90E             ;\
$91:8733 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS
$91:8736 7A          PLY
$91:8737 FA          PLX
$91:8738 60          RTS
}


;;; $8739: Instruction - end demo input with Samus facing left ;;;
{
$91:8739 DA          PHX
$91:873A 5A          PHY
$91:873B A9 13 E7    LDA #$E713             ;\
$91:873E 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$91:8741 A9 02 00    LDA #$0002             ;\
$91:8744 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - normal
$91:8747 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:874B 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:874F AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:8752 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:8755 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:8758 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:875B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:875E 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:8761 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:8764 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$91:8767 22 5F 83 91 JSL $91835F[$91:835F]  ; Disable demo input
$91:876B A9 0E E9    LDA #$E90E             ;\
$91:876E 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS
$91:8771 7A          PLY
$91:8772 FA          PLX
$91:8773 60          RTS
}


;;; $8774: Unused. Instruction list - demo input - delete ;;;
{
$91:8774             dx 8427            ; Delete
}


;;; $8776: Instruction list - demo input - delete ;;;
{
$91:8776             dx 8427            ; Delete
}


;;; $8778: Demo input objects - intro ;;;
{
;                        _____________ Initialisation (RTS)
;                       |     ________ Pre-instruction
;                       |    |     ___ Pointer to input instruction list
;                       |    |    |
$91:8778             dw 83BF,83BF,85CE ; Unused. Jump left and give control back to player
$91:877E             dw 83BF,864F,860D ; Baby metroid discovery
$91:8784             dw 83BF,83BF,8694 ; Old Mother Brain fight
$91:878A             dw 83BF,83BF,86B8 ; Unused. Old Mother Brain fight without first shot
}


;;; $8790: Load demo data ;;;
{
$91:8790 AD 57 1F    LDA $1F57  [$7E:1F57]  ;\
$91:8793 0A          ASL A                  ;|
$91:8794 0A          ASL A                  ;|
$91:8795 0A          ASL A                  ;|
$91:8796 0A          ASL A                  ;|
$91:8797 85 12       STA $12    [$7E:0012]  ;|
$91:8799 AD 55 1F    LDA $1F55  [$7E:1F55]  ;} X = [$8885 + [demo set] * 2] + [demo scene] * 10h
$91:879C 0A          ASL A                  ;|
$91:879D AA          TAX                    ;|
$91:879E BD 85 88    LDA $8885,x[$91:8885]  ;|
$91:87A1 18          CLC                    ;|
$91:87A2 65 12       ADC $12    [$7E:0012]  ;|
$91:87A4 AA          TAX                    ;/
$91:87A5 BD 00 00    LDA $0000,x[$91:888D]  ;\
$91:87A8 8D A4 09    STA $09A4  [$7E:09A4]  ;} Equipped items = collected items = [[X]]
$91:87AB 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$91:87AE BD 02 00    LDA $0002,x[$91:888F]  ;\
$91:87B1 8D C8 09    STA $09C8  [$7E:09C8]  ;} Samus max missiles = Samus missiles = [[X] + 2]
$91:87B4 8D C6 09    STA $09C6  [$7E:09C6]  ;/
$91:87B7 BD 04 00    LDA $0004,x[$91:8891]  ;\
$91:87BA 8D CC 09    STA $09CC  [$7E:09CC]  ;} Samus max super missiles = Samus super missiles = [[X] + 4]
$91:87BD 8D CA 09    STA $09CA  [$7E:09CA]  ;/
$91:87C0 BD 06 00    LDA $0006,x[$91:8893]  ;\
$91:87C3 8D D0 09    STA $09D0  [$7E:09D0]  ;} Samus max power bombs = Samus power bombs = [[X] + 6]
$91:87C6 8D CE 09    STA $09CE  [$7E:09CE]  ;/
$91:87C9 BD 08 00    LDA $0008,x[$91:8895]  ;\
$91:87CC 8D C4 09    STA $09C4  [$7E:09C4]  ;} Samus max health = Samus health = [[X] + 8]
$91:87CF 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$91:87D2 BD 0A 00    LDA $000A,x[$91:8897]  ;\
$91:87D5 8D A8 09    STA $09A8  [$7E:09A8]  ;} Collected beams = [[X] + Ah]
$91:87D8 BD 0C 00    LDA $000C,x[$91:8899]  ;\
$91:87DB 8D A6 09    STA $09A6  [$7E:09A6]  ;} Equipped beams = [[X] + Ch]
$91:87DE 9C D6 09    STZ $09D6  [$7E:09D6]  ; Samus reserve health = 0
$91:87E1 DA          PHX
$91:87E2 22 70 83 91 JSL $918370[$91:8370]  ; Clear demo input RAM
$91:87E6 22 4E 83 91 JSL $91834E[$91:834E]  ; Enable demo input
$91:87EA FA          PLX
$91:87EB BD 0E 00    LDA $000E,x[$91:889B]  ;\
$91:87EE A8          TAY                    ;} Load demo input object [[X] + Eh]
$91:87EF 22 95 83 91 JSL $918395[$91:8395]  ;/
$91:87F3 AD 57 1F    LDA $1F57  [$7E:1F57]  ;\
$91:87F6 0A          ASL A                  ;|
$91:87F7 85 12       STA $12    [$7E:0012]  ;|
$91:87F9 AD 55 1F    LDA $1F55  [$7E:1F55]  ;|
$91:87FC 0A          ASL A                  ;|
$91:87FD AA          TAX                    ;|
$91:87FE BD FD 89    LDA $89FD,x[$91:89FD]  ;|
$91:8801 18          CLC                    ;} Execute [[$89FD + [demo set] * 2] + [demo scene] * 2] (demo Samus setup)
$91:8802 65 12       ADC $12    [$7E:0012]  ;|
$91:8804 AA          TAX                    ;|
$91:8805 BD 00 00    LDA $0000,x[$91:8A05]  ;|
$91:8808 85 12       STA $12    [$7E:0012]  ;|
$91:880A F4 0F 88    PEA $880F              ;|
$91:880D 6C 12 00    JMP ($0012)[$91:8A33]  ;/

$91:8810 A9 C9 E6    LDA #$E6C9             ;\
$91:8813 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E6C9 (demo)
$91:8816 A9 F5 E7    LDA #$E7F5             ;\
$91:8819 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E7F5 (title demo)
$91:881C 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$91:881F 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$91:8822 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$91:8825 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$91:8829 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$91:882D A9 00 08    LDA #$0800             ;\
$91:8830 8D AA 09    STA $09AA  [$7E:09AA]  ;} Up binding = up
$91:8833 A9 00 04    LDA #$0400             ;\
$91:8836 8D AC 09    STA $09AC  [$7E:09AC]  ;} Down binding = down
$91:8839 A9 00 02    LDA #$0200             ;\
$91:883C 8D AE 09    STA $09AE  [$7E:09AE]  ;} Left binding = left
$91:883F A9 00 01    LDA #$0100             ;\
$91:8842 8D B0 09    STA $09B0  [$7E:09B0]  ;} Right binding = right
$91:8845 A9 40 00    LDA #$0040             ;\
$91:8848 8D B2 09    STA $09B2  [$7E:09B2]  ;} Shoot binding = X
$91:884B A9 80 00    LDA #$0080             ;\
$91:884E 8D B4 09    STA $09B4  [$7E:09B4]  ;} Jump binding = A
$91:8851 A9 00 80    LDA #$8000             ;\
$91:8854 8D B6 09    STA $09B6  [$7E:09B6]  ;} Run binding = B
$91:8857 A9 00 40    LDA #$4000             ;\
$91:885A 8D B8 09    STA $09B8  [$7E:09B8]  ;} Item cancel binding = Y
$91:885D A9 00 20    LDA #$2000             ;\
$91:8860 8D BA 09    STA $09BA  [$7E:09BA]  ;} Item select binding = select
$91:8863 A9 10 00    LDA #$0010             ;\
$91:8866 8D BE 09    STA $09BE  [$7E:09BE]  ;} Aim up binding = R
$91:8869 A9 20 00    LDA #$0020             ;\
$91:886C 8D BC 09    STA $09BC  [$7E:09BC]  ;} Aim down binding = L
$91:886F A9 01 00    LDA #$0001             ;\
$91:8872 8D E8 09    STA $09E8  [$7E:09E8]  ;} $09E8 = 1
$91:8875 8D E6 09    STA $09E6  [$7E:09E6]  ; Disable Samus placement mode
$91:8878 9C E4 09    STZ $09E4  [$7E:09E4]  ; Disable moonwalk
$91:887B 9C F8 0D    STZ $0DF8  [$7E:0DF8]  ; $0DF8 = 0
$91:887E 9C FA 0D    STZ $0DFA  [$7E:0DFA]  ; $0DFA = 0
$91:8881 9C FC 0D    STZ $0DFC  [$7E:0DFC]  ; $0DFC = 0
$91:8884 60          RTS
}


;;; $8885: Demo data ;;;
{
$91:8885             dw 888D, 88ED, 894D, 89AD

;                        ______________________________________ Equipment
;                       |     _________________________________ Missiles
;                       |    |     ____________________________ Super missiles
;                       |    |    |     _______________________ Power bombs
;                       |    |    |    |     __________________ Health
;                       |    |    |    |    |     _____________ Collected beams
;                       |    |    |    |    |    |     ________ Equipped beams
;                       |    |    |    |    |    |    |     ___ Demo input object pointer
;                       |    |    |    |    |    |    |    |
$91:888D             dw 0000,0000,0000,0000,0063,0000,0000,9E52, ; Landing site
                        0004,0005,0000,0000,0063,0000,0000,9E88, ; Missile door
                        0004,000F,0000,0000,00C7,1000,1000,9EAC, ; Pre Spore Spawn hall
                        2105,001E,0005,0000,012B,1004,1004,9E5E, ; Speed booster
                        6105,001E,0005,0005,018F,1006,1006,9EB2, ; Grapple beam
                        0004,0014,0000,0000,00C7,1000,1000,9E58  ; Pseudo screw attack

$91:88ED             dw 2105,001E,0005,0000,012B,1006,1006,9EB8, ; Ice beam
                        0004,000A,0000,0000,00C7,0000,0000,9E94, ; Fireflea room
                        0004,0019,0005,0000,00C7,1000,1000,9EA0, ; Brinstar diagonal room
                        E325,004B,000F,000A,0383,1000,1000,9E76, ; Lower Norfair entrance
                        E32D,0055,000F,000A,03E7,0000,0000,9E9A, ; Screw attack
                        E105,002D,0005,0005,018F,1000,1000,9E64  ; Dachora

$91:894D             dw E105,0037,0005,0005,018F,1000,1000,9E70, ; Pre Phantoon hall
                        F33F,0055,000F,000A,03E7,100F,1000,9E82, ; Shinespark
                        0104,0019,0005,0000,012B,1004,1004,9E7C, ; Eye door
                        2105,001E,0005,0000,012B,0000,0000,9E6A, ; Red Brinstar -> Crateria elevator
                        0104,0019,0005,0000,012B,0000,0000,9E8E, ; Kraid
                        2105,001E,0005,0005,012B,1008,1008,9ED6  ; Tourian entrance

$91:89AD             dw F32D,0055,000F,000A,03E7,1000,1000,9EBE, ; Gauntlet entrance
                        F32D,0055,000F,000A,03E7,0000,0000,9EC4, ; Advanced grapple beam
                        F32D,0055,000F,000A,03E7,0000,0000,9ECA, ; IBJ
                        F32D,0055,000F,000A,03E7,1008,1008,9ED0, ; SBA
                        F32D,0055,0014,0014,03E7,1000,1000,9EDC  ; Crystal flash
}


;;; $89FD: Demo Samus setup function pointers ;;;
{
$91:89FD             dw 8A05, 8A11, 8A1D, 8A29

$91:8A05             dw 8A33, 8A53, 8A53, 8A49, 8A53, 8A3E
$91:8A11             dw 8A49, 8A49, 8A53, 8A49, 8A53, 8A4E
$91:8A1D             dw 8A49, 8A68, 8A53, 8A53, 8A53, 8A53
$91:8A29             dw 8A81, 8A49, 8A49, 8A53, 8A43
}


;;; $8A33: Demo Samus setup - landing site ;;;
{
$91:8A33 22 F6 E3 91 JSL $91E3F6[$91:E3F6]  ; Make Samus face forward
$91:8A37 A9 52 EB    LDA #$EB52             ;\
$91:8A3A 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$91:8A3D 60          RTS
}


;;; $8A3E: Demo Samus setup - morph ball moving left ;;;
{
$91:8A3E A9 1F 00    LDA #$001F             ;\
$91:8A41 80 13       BRA $13    [$8A56]     ;} Initialise Samus with pose = moving left - morph ball - no springball - on ground
}


;;; $8A43: Demo Samus setup - standing facing left - low health ;;;
{
$91:8A43 A9 14 00    LDA #$0014             ;\
$91:8A46 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = 20
}


;;; $8A49: Demo Samus setup - standing facing left ;;;
{
$91:8A49 A9 02 00    LDA #$0002             ;\
$91:8A4C 80 08       BRA $08    [$8A56]     ;} Initialise Samus with pose = facing left - normal
}


;;; $8A4E: Demo Samus setup - falling facing left ;;;
{
$91:8A4E A9 2A 00    LDA #$002A             ;\
$91:8A51 80 03       BRA $03    [$8A56]     ;} Initialise Samus with pose = facing left - falling
}


;;; $8A53: Demo Samus setup - standing facing right ;;;
{
$91:8A53 A9 01 00    LDA #$0001             ; Initialise Samus with pose = facing right - normal
}


;;; $8A56: Initialise Samus with pose = [A] ;;;
{
$91:8A56 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ; Samus pose = [A]
$91:8A59 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:8A5D 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:8A61 A9 52 EB    LDA #$EB52             ;\
$91:8A64 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$91:8A67 60          RTS
}


;;; $8A68: Demo Samus setup - shinespark ;;;
{
$91:8A68 A9 52 EB    LDA #$EB52             ;\
$91:8A6B 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$91:8A6E 22 FA CF 90 JSL $90CFFA[$90:CFFA]  ; Trigger shinespark windup
$91:8A72 A9 CD 00    LDA #$00CD             ;\
$91:8A75 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - shinespark - diagonal
$91:8A78 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:8A7C 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:8A80 60          RTS
}


;;; $8A81: Demo Samus setup - gauntlet entrance ;;;
{
$91:8A81 A9 52 EB    LDA #$EB52             ;\
$91:8A84 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$91:8A87 22 FA CF 90 JSL $90CFFA[$90:CFFA]  ; Trigger shinespark windup
$91:8A8B A9 CA 00    LDA #$00CA             ;\
$91:8A8E 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - shinespark - horizontal
$91:8A91 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:8A95 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:8A99 60          RTS
}


;;; $8A9A: RTS ;;;
{
$91:8A9A 60          RTS
}


;;; $8A9B: Pre-instruction - demo input - normal ;;;
{
$91:8A9B AD 98 09    LDA $0998  [$7E:0998]  ;\
$91:8A9E C9 2C 00    CMP #$002C             ;} If [game state] = transition from demo:
$91:8AA1 D0 0C       BNE $0C    [$8AAF]     ;/
$91:8AA3 A9 76 87    LDA #$8776             ;\
$91:8AA6 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;} Demo input instruction list pointer = delete
$91:8AA9 A9 01 00    LDA #$0001             ;\
$91:8AAC 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ;} Demo input instruction timer = 1

$91:8AAF 60          RTS
}


;;; $8AB0: Pre-instruction - demo input - shinespark ;;;
{
$91:8AB0 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:8AB3 29 FF 00    AND #$00FF             ;|
$91:8AB6 C9 1A 00    CMP #$001A             ;} If [Samus movement type] != grabbed by Draygon (!?):
$91:8AB9 F0 12       BEQ $12    [$8ACD]     ;/
$91:8ABB A9 9B 8A    LDA #$8A9B             ;\
$91:8ABE 8D 7A 0A    STA $0A7A  [$7E:0A7A]  ;} Demo input pre-instruction = $8A9B (normal)
$91:8AC1 A9 46 93    LDA #$9346             ;\
$91:8AC4 8D 7E 0A    STA $0A7E  [$7E:0A7E]  ;} Demo input instruction list pointer = $9346 (shinespark - unseen section)
$91:8AC7 A9 01 00    LDA #$0001             ;\
$91:8ACA 8D 7C 0A    STA $0A7C  [$7E:0A7C]  ;} Demo input instruction timer = 1

$91:8ACD 60          RTS
}


;;; $8ACE..9E51: Demo input instruction lists ;;;
{
; Format is
;     nnnn iiii IIII
;
; where
;     n: Number of frames
;     i: Current input
;     I: New input

;;; $8ACE: Instruction list - demo input - landing site ;;;
{
$91:8ACE             dx 0121,0000,0000, ;
                        0001,0200,0200, ;       <
                        0006,0200,0000, ;       <
                        0001,0A00,0800, ;     ^ <
                        0003,0A00,0000, ;     ^ <
                        0013,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0028,0280,0000, ;       < A
                        0032,0200,0000, ;       <
                        0024,0000,0000, ;
                        0001,0100,0100, ;        >
                        0005,0100,0000, ;        >
                        000F,0000,0000, ;
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        0022,0000,0000, ;
                        0001,0200,0200, ;       <
                        004A,0200,0000, ;       <
                        0005,0000,0000, ;
                        0001,0100,0100, ;        >
                        0005,0100,0000, ;        >
                        0045,0000,0000, ;
                        0001,0200,0200, ;       <
                        0003,0200,0000, ;       <
                        0001,8200,8000, ; B     <
                        0049,8200,0000, ; B     <
                        0001,8A00,0800, ; B   ^ <
                        0003,8A00,0000, ; B   ^ <
                        0001,0200,0000, ;       <
                        0002,0000,0000, ;
                        0001,0100,0100, ;        >
                        0007,0100,0000, ;        >
                        000B,0000,0000, ;
                        0001,0010,0010, ;            R
                        001F,0010,0000, ;            R
                        0001,0210,0200, ;       <    R
                        0005,0210,0000, ;       <    R
                        001D,0010,0000, ;            R
                        0001,0200,0200, ;       <
                        005E,0200,0000, ;       <
                        0030,0000,0000, ;
                        0001,0200,0200, ;       <
                        002E,0200,0000, ;       <
                        001F,0000,0000, ;
                        0001,0100,0100, ;        >
                        0004,0100,0000, ;        >
                        0040,0000,0000, ;
                        0001,0200,0200, ;       <
                        0004,0200,0000, ;       <
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0006,0040,0000, ;          X
                        002B,0000,0000, ;
                        0001,0200,0200, ;       <
                        0011,0200,0000, ;       <
                        0007,0000,0000, ;
                        0001,0200,0200, ;       <
                        0004,0200,0000, ;       <
                        0014,0100,0000, ;        >
                        0001,0140,0040, ;        > X
                        0003,0140,0000, ;        > X
                        8427            ; Delete
}


;;; $8C3E: Instruction list - demo input - pseudo screw attack ;;;
{
$91:8C3E             dx 0016,0000,0000, ;
                        0001,0800,0800, ;     ^
                        0003,0800,0000, ;     ^
                        0005,0000,0000, ;
                        0001,0800,0800, ;     ^
                        0006,0800,0000, ;     ^
                        0016,0000,0000, ;
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        000B,0000,0000, ;
                        0001,0040,0040, ;          X
                        004E,0040,0000, ;          X
                        0001,0240,0200, ;       <  X
                        000D,0240,0000, ;       <  X
                        0001,02C0,0080, ;       < AX
                        0014,02C0,0000, ;       < AX
                        0014,0240,0000, ;       <  X
                        0020,0040,0000, ;          X
                        0001,0140,0100, ;        > X
                        000F,0140,0000, ;        > X
                        0001,01C0,0080, ;        >AX
                        0006,01C0,0000, ;        >AX
                        0002,00C0,0000, ;         AX
                        0001,02C0,0200, ;       < AX
                        001E,02C0,0000, ;       < AX
                        0008,0240,0000, ;       <  X
                        0006,0040,0000, ;          X
                        0001,0140,0100, ;        > X
                        000B,0140,0000, ;        > X
                        0001,01C0,0080, ;        >AX
                        0023,01C0,0000, ;        >AX
                        003A,0140,0000, ;        > X
                        0001,01C0,0080, ;        >AX
                        0013,01C0,0000, ;        >AX
                        0001,09C0,0800, ;     ^  >AX
                        0002,01C0,0000, ;        >AX
                        0008,00C0,0000, ;         AX
                        000D,0040,0000, ;          X
                        0001,0240,0200, ;       <  X
                        0029,0240,0000, ;       <  X
                        0001,02C0,0080, ;       < AX
                        0007,02C0,0000, ;       < AX
                        0001,0AC0,0800, ;     ^ < AX
                        0002,0AC0,0000, ;     ^ < AX
                        0001,08C0,0000, ;     ^   AX
                        0001,01C0,0100, ;        >AX
                        0028,01C0,0000, ;        >AX
                        0010,0140,0000, ;        > X
                        0006,0040,0000, ;          X
                        0001,00C0,0080, ;         AX
                        0004,00C0,0000, ;         AX
                        0001,00E0,0020, ;         AXL
                        0012,00E0,0000, ;         AXL
                        002A,0020,0000, ;           L
                        0001,0120,0100, ;        >  L
                        0002,0120,0000, ;        >  L
                        0005,0100,0000, ;        >
                        0008,0000,0000, ;
                        0001,0100,0100, ;        >
                        0011,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        000F,0180,0000, ;        >A
                        0013,0100,0000, ;        >
                        0001,8100,8000, ; B      >
                        0029,8100,0000, ; B      >
                        0001,8180,0080, ; B      >A
                        0020,8180,0000, ; B      >A
                        0005,8080,0000, ; B       A
                        0006,8000,0000, ; B
                        0001,0200,0200, ;       <
                        000F,0200,0000, ;       <
                        0065,0000,0000, ;
                        8427            ; Delete
}


;;; $8DF0: Instruction list - demo input - speed booster ;;;
{
$91:8DF0             dx 0020,0000,0000, ;
                        0001,0200,0200, ;       <
                        0002,0200,0000, ;       <
                        0001,8200,8000, ; B     <
                        00EE,8200,0000, ; B     <
                        0001,8A00,0800, ; B   ^ <
                        0002,8200,0000, ; B     <
                        0001,8100,0100, ; B      >
                        0016,0100,0000, ;        >
                        0031,0000,0000, ;
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        0013,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0011,0000,0000, ;
                        0001,0200,0200, ;       <
                        001B,0200,0000, ;       <
                        0063,0000,0000, ;
                        8427            ; Delete
}


;;; $8E64: Instruction list - demo input - dachora ;;;
{
$91:8E64             dx 0008,0000,0000, ;
                        0001,0200,0200, ;       <
                        0001,0200,0000, ;       <
                        010A,0000,0000, ;
                        0001,0100,0100, ;        >
                        0004,0100,0000, ;        >
                        0011,0000,0000, ;
                        0001,0200,0200, ;       <
                        0004,0200,0000, ;       <
                        0038,0000,0000, ;
                        0001,0200,0200, ;       <
                        0164,0200,0000, ;       <
                        011E,0000,0000, ;
                        8427            ; Delete
}


;;; $8EB4: Instruction list - demo input - Red Brinstar -> Crateria elevator ;;;
{
$91:8EB4             dx 005A,0000,0000, ;
                        0001,0100,0100, ;        >
                        000A,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0006,0180,0000, ;        >A
                        0011,0100,0000, ;        >
                        0020,0000,0000, ;
                        0001,0200,0200, ;       <
                        0001,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0014,0280,0000, ;       < A
                        0003,0200,0000, ;       <
                        0014,0000,0000, ;
                        0001,0100,0100, ;        >
                        0004,0100,0000, ;        >
                        0048,0000,0000, ;
                        0001,0080,0080, ;         A
                        0011,0080,0000, ;         A
                        0001,0180,0100, ;        >A
                        000A,0180,0000, ;        >A
                        0016,0100,0000, ;        >
                        0200,0000,0000, ;
                        8427            ; Delete
}


;;; $8F3A: Instruction list - demo input - pre Phantoon hall ;;;
{
$91:8F3A             dx 003D,0000,0000, ;
                        0001,0100,0100, ;        >
                        0005,0100,0000, ;        >
                        000F,0000,0000, ;
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        0027,0000,0000, ;
                        0001,0200,0200, ;       <
                        0066,0200,0000, ;       <
                        0001,8200,8000, ; B     <
                        0007,8200,0000, ; B     <
                        004F,0200,0000, ;       <
                        0057,0000,0000, ;
                        0001,0100,0100, ;        >
                        0002,0100,0000, ;        >
                        0064,0000,0000, ;
                        0001,0100,0100, ;        >
                        004E,0100,0000, ;        >
                        0001,8100,8000, ; B      >
                        0017,8100,0000, ; B      >
                        0006,0100,0000, ;        >
                        0001,8100,8000, ; B      >
                        0003,8100,0000, ; B      >
                        0001,0100,0000, ;        >
                        0001,8100,8000, ; B      >
                        0002,8100,0000, ; B      >
                        0034,0100,0000, ;        >
                        00A9,0000,0000, ;
                        8427            ; Delete
}


;;; $8FE4: Instruction list - demo input - Lower Norfair entrance ;;;
{
$91:8FE4             dx 0013,0000,0000, ;
                        0001,0200,0200, ;       <
                        0012,0200,0000, ;       <
                        0029,0000,0000, ;
                        0001,8000,8000, ; B
                        0015,8000,0000, ; B
                        000B,0000,0000, ;
                        0001,8000,8000, ; B
                        001F,8000,0000, ; B
                        0001,8200,0200, ; B     <
                        0030,8200,0000, ; B     <
                        0003,8000,0000, ; B
                        0001,8200,0200, ; B     <
                        0007,8200,0000, ; B     <
                        0045,8000,0000, ; B
                        0001,8200,0200, ; B     <
                        0091,8200,0000, ; B     <
                        000A,8000,0000, ; B
                        0001,8200,0200, ; B     <
                        0006,8200,0000, ; B     <
                        0036,8000,0000, ; B
                        0001,8200,0200, ; B     <
                        0090,8200,0000, ; B     <
                        0011,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0017,0280,0000, ;       < A
                        0008,0080,0000, ;         A
                        0001,0180,0100, ;        >A
                        000E,0180,0000, ;        >A
                        000F,0100,0000, ;        >
                        0002,0000,0000, ;
                        0001,0080,0080, ;         A
                        001C,0080,0000, ;         A
                        0001,0280,0200, ;       < A
                        000C,0280,0000, ;       < A
                        0002,0200,0000, ;       <
                        000F,0000,0000, ;
                        0001,0080,0080, ;         A
                        0011,0080,0000, ;         A
                        0001,0180,0100, ;        >A
                        000F,0180,0000, ;        >A
                        0002,0080,0000, ;         A
                        0010,0000,0000, ;
                        0001,0080,0080, ;         A
                        0001,0280,0200, ;       < A
                        0014,0280,0000, ;       < A
                        0015,0200,0000, ;       <
                        0001,8200,8000, ; B     <
                        000E,8200,0000, ; B     <
                        0006,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0004,0280,0000, ;       < A
                        0011,0200,0000, ;       <
                        0001,8200,8000, ; B     <
                        0024,8200,0000, ; B     <
                        0002,0200,0000, ;       <
                        0014,0200,0000, ;       <
                        0007,0000,0000, ;
                        0001,0100,0100, ;        >
                        0009,0100,0000, ;        >
                        002D,0000,0000, ;
                        8427            ; Delete
}


;;; $9154: Instruction list - demo input - eye door ;;;
{
$91:9154             dx 000B,0100,0000, ;        >
                        0017,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0004,0000,0000, ;
                        0001,0100,0100, ;        >
                        0002,0100,0000, ;        >
                        000C,0000,0000, ;
                        0001,2000,2000, ;   s
                        0006,2000,0000, ;   s
                        000D,0000,0000, ;
                        0001,0100,0100, ;        >
                        000A,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0006,0180,0000, ;        >A
                        000E,0100,0000, ;        >
                        0010,0000,0000, ;
                        0001,0100,0100, ;        >
                        0002,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0006,0180,0000, ;        >A
                        000D,0100,0000, ;        >
                        0010,0000,0000, ;
                        0001,0100,0100, ;        >
                        0002,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0008,0180,0000, ;        >A
                        001C,0100,0000, ;        >
                        0020,0000,0000, ;
                        0001,0100,0100, ;        >
                        0001,0180,0080, ;        >A
                        000B,0180,0000, ;        >A
                        0012,0100,0000, ;        >
                        0016,0000,0000, ;
                        0001,0100,0100, ;        >
                        0006,0100,0000, ;        >
                        0028,0000,0000, ;
                        0001,0100,0100, ;        >
                        0006,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0008,0180,0000, ;        >A
                        0017,0100,0000, ;        >
                        000F,0000,0000, ;
                        0001,0080,0080, ;         A
                        0006,0080,0000, ;         A
                        000A,0000,0000, ;
                        0001,0040,0040, ;          X
                        0006,0040,0000, ;          X
                        0025,0000,0000, ;
                        0001,0200,0200, ;       <
                        0007,0200,0000, ;       <
                        0008,0000,0000, ;
                        0001,0100,0100, ;        >
                        0007,0100,0000, ;        >
                        0052,0000,0000, ;
                        0001,0080,0080, ;         A
                        0007,0080,0000, ;         A
                        0011,0000,0000, ;
                        0001,0040,0040, ;          X
                        0004,0040,0000, ;          X
                        000C,0000,0000, ;
                        0001,0080,0080, ;         A
                        000B,0080,0000, ;         A
                        001E,0000,0000, ;
                        0001,0040,0040, ;          X
                        0006,0040,0000, ;          X
                        000D,0000,0000, ;
                        0001,0080,0080, ;         A
                        0005,0080,0000, ;         A
                        000D,0000,0000, ;
                        0001,0040,0040, ;          X
                        0006,0040,0000, ;          X
                        007C,0000,0000, ;
                        0001,0200,0200, ;       <
                        0007,0200,0000, ;       <
                        0011,0000,0000, ;
                        0001,0100,0100, ;        >
                        0009,0100,0000, ;        >
                        0001,0140,0040, ;        > X
                        0003,0140,0000, ;        > X
                        0004,0100,0000, ;        >
                        8427            ; Delete
}


;;; $933C: Instruction list - demo input - shinespark ;;;
{
$91:933C             dx 00A5,0000,0000, ;
                        8448,933C       ; Go to $933C
}


;;; $9346: Instruction list - demo input - shinespark - unseen section ;;;
{
; The demo timer expires before these inputs are used
$91:9346             dx 0096,0000,0000, ;
                        0001,0200,0200, ;       <
                        00CC,0200,0000, ;       <
                        0001,8200,8000, ; B     <
                        0076,8200,0000, ; B     <
                        0002,8000,0000, ; B
                        0001,8100,0100, ; B      >
                        00B6,8100,0000, ; B      >
                        000C,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0006,0180,0000, ;        >A
                        000E,0100,0000, ;        >
                        0024,0000,0000, ;
                        0001,2000,2000, ;   s
                        0005,2000,0000, ;   s
                        000B,0000,0000, ;
                        0001,2000,2000, ;   s
                        0004,2000,0000, ;   s
                        000E,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        00F0,0000,0000, ;
                        8427            ; Delete
}


;;; $93CC: Instruction list - demo input - missile door ;;;
{
$91:93CC             dx 0029,0000,0000, ;
                        0001,0100,0100, ;        >
                        0031,0100,0000, ;        >
                        0044,0000,0000, ;
                        0001,2000,2000, ;   s
                        0005,2000,0000, ;   s
                        0023,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        000A,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0011,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        000D,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0007,0000,0000, ;
                        0001,0040,0040, ;          X
                        0009,0040,0000, ;          X
                        0020,0000,0000, ;
                        0001,8100,8100, ; B      >
                        0011,8100,0000, ; B      >
                        001A,0000,0000, ;
                        8427            ; Delete
}


;;; $9464: Instruction list - demo input - Kraid ;;;
{
$91:9464             dx 0200,0000,0000, ;
                        8427            ; Delete
}


;;; $946C: Instruction list - demo input - fireflea room ;;;
{
$91:946C             dx 002B,0000,0000, ;
                        0001,0200,0200, ;       <
                        0046,0200,0000, ;       <
                        0037,0000,0000, ;
                        0001,0200,0200, ;       <
                        000C,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0013,0280,0000, ;       < A
                        0013,0200,0000, ;       <
                        0001,0240,0040, ;       <  X
                        000B,0240,0000, ;       <  X
                        0005,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0015,0280,0000, ;       < A
                        0025,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        000E,0280,0000, ;       < A
                        0021,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0009,0280,0000, ;       < A
                        001D,0200,0000, ;       <
                        0008,0000,0000, ;
                        0001,0020,0020, ;           L
                        0001,0020,0000, ;           L
                        0001,0420,0400, ;      v    L
                        00C4,0020,0000, ;           L
                        8427            ; Delete
}


;;; $950A: Instruction list - demo input - screw attack ;;;
{
$91:950A             dx 0030,0000,0000, ;
                        0001,8100,8100, ; B      >
                        001E,8100,0000, ; B      >
                        0001,8180,0080, ; B      >A
                        000C,8180,0000, ; B      >A
                        001C,8100,0000, ; B      >
                        0001,8180,0080, ; B      >A
                        0017,8180,0000, ; B      >A
                        002B,8100,0000, ; B      >
                        0001,0400,0400, ;      v
                        0003,0000,0000, ;
                        0001,0200,0200, ;       <
                        0001,0210,0010, ;       <    R
                        009D,0010,0000, ;            R
                        8427            ; Delete
}


;;; $9560: Instruction list - demo input - Brinstar diagonal room ;;;
{
$91:9560             dx 0029,0000,0000, ;
                        0001,0100,0100, ;        >
                        0012,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0016,0180,0000, ;        >A
                        0041,0100,0000, ;        >
                        0014,0000,0000, ;
                        0001,0010,0010, ;            R
                        000A,0010,0000, ;            R
                        0001,0050,0040, ;          X R
                        001D,0050,0000, ;          X R
                        0005,0040,0000, ;          X
                        0001,0440,0400, ;      v   X
                        0037,0440,0000, ;      v   X
                        00DB,0000,0000, ;
                        8427            ; Delete
}


;;; $95BC: Instruction list - demo input - unused ;;;
{
$91:95BC             dx 0029,0000,0000, ;
                        0001,0200,0200, ;       <
                        0018,0200,0000, ;       <
                        0011,0000,0000, ;
                        0001,0080,0080, ;         A
                        0018,0080,0000, ;         A
                        0001,0280,0200, ;       < A
                        0005,0280,0000, ;       < A
                        0010,0200,0000, ;       <
                        0020,0000,0000, ;
                        0001,0080,0080, ;         A
                        0009,0080,0000, ;         A
                        0001,0280,0200, ;       < A
                        0015,0280,0000, ;       < A
                        0016,0200,0000, ;       <
                        0014,0000,0000, ;
                        0001,0100,0100, ;        >
                        0007,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        0018,0180,0000, ;        >A
                        001D,0100,0000, ;        >
                        0010,0000,0000, ;
                        0001,0400,0400, ;      v
                        0005,0400,0000, ;      v
                        0001,0600,0200, ;      v<
                        0096,0000,0000, ;
                        8427            ; Delete
}


;;; $965A: Instruction list - demo input - pre Spore Spawn hall ;;;
{
$91:965A             dx 001B,0000,0000, ;
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        000F,0000,0000, ;
                        0001,0100,0100, ;        >
                        0005,0100,0000, ;        >
                        0010,0000,0000, ;
                        0001,0100,0100, ;        >
                        000D,0100,0000, ;        >
                        002A,0100,0000, ;        >
                        0007,0000,0000, ;
                        0001,0080,0080, ;         A
                        0015,0080,0000, ;         A
                        001E,0000,0000, ;
                        0001,0200,0200, ;       <
                        0013,0200,0000, ;       <
                        0010,0000,0000, ;
                        0001,0100,0100, ;        >
                        0008,0100,0000, ;        >
                        0001,0180,0080, ;        >A
                        000F,0180,0000, ;        >A
                        0001,0080,0000, ;         A
                        0001,0280,0200, ;       < A
                        0007,0280,0000, ;       < A
                        0004,0200,0000, ;       <
                        0001,0000,0000, ;
                        0001,0100,0100, ;        >
                        0004,0100,0000, ;        >
                        0001,0140,0040, ;        > X
                        0009,0140,0000, ;        > X
                        0005,0140,0000, ;        > X
                        004C,0040,0000, ;          X
                        0001,0440,0400, ;      v   X
                        0003,0040,0000, ;          X
                        0001,0050,0010, ;          X R
                        0004,0050,0000, ;          X R
                        0084,0010,0000, ;            R
                        8427            ; Delete
}


;;; $973A: Instruction list - demo input - grapple beam ;;;
{
$91:973A             dx 0010,0000,0000, ;
                        0001,2000,2000, ;   s
                        000C,0000,0000, ;
                        0001,2000,2000, ;   s
                        000C,0000,0000, ;
                        0001,2000,2000, ;   s
                        000C,0000,0000, ;
                        0001,2000,2000, ;   s
                        000C,0000,0000, ;
                        0001,0010,0010, ;            R
                        0022,0010,0000, ;            R
                        0001,0050,0040, ;          X R
                        0010,0050,0000, ;          X R
                        0001,0650,0600, ;      v<  X R
                        0006,0650,0000, ;      v<  X R
                        000C,0450,0000, ;      v   X R
                        0001,0550,0100, ;      v > X R
                        0004,0550,0000, ;      v > X R
                        0012,0150,0000, ;        > X R
                        0006,0110,0000, ;        >   R
                        0001,0150,0040, ;        > X R
                        0007,0150,0000, ;        > X R
                        0001,0550,0400, ;      v > X R
                        0004,0550,0000, ;      v > X R
                        0016,0450,0000, ;      v   X R
                        0001,0550,0100, ;      v > X R
                        0005,0550,0000, ;      v > X R
                        000B,0150,0000, ;        > X R
                        0007,0110,0000, ;        >   R
                        0001,0150,0040, ;        > X R
                        000A,0150,0000, ;        > X R
                        0001,0550,0400, ;      v > X R
                        000C,0550,0000, ;      v > X R
                        000E,0150,0000, ;        > X R
                        000A,0110,0000, ;        >   R
                        0001,0150,0040, ;        > X R
                        0008,0150,0000, ;        > X R
                        0001,0550,0400, ;      v > X R
                        000C,0550,0000, ;      v > X R
                        000E,0150,0000, ;        > X R
                        000A,0110,0000, ;        >   R
                        0001,0150,0040, ;        > X R
                        0008,0150,0000, ;        > X R
                        0001,0550,0400, ;      v > X R
                        000D,0550,0000, ;      v > X R
                        000E,0150,0000, ;        > X R
                        000A,0110,0000, ;        >   R
                        0001,0150,0040, ;        > X R
                        0009,0150,0000, ;        > X R
                        0001,0550,0400, ;      v > X R
                        000C,0550,0000, ;      v > X R
                        0008,0150,0000, ;        > X R
                        0004,0100,0000, ;        >
                        0020,0000,0000, ;
                        0001,0400,0400, ;      v
                        0005,0400,0000, ;      v
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        0028,0000,0000, ;
                        8427            ; Delete
}


;;; $989E: Instruction list - demo input - ice beam ;;;
{
$91:989E             dx 0021,0000,0000, ;
                        0001,0040,0040, ;          X
                        0005,0040,0000, ;          X
                        0006,0000,0000, ;
                        0001,0040,0040, ;          X
                        0005,0040,0000, ;          X
                        0012,0000,0000, ;
                        0001,0200,0200, ;       <
                        0017,0200,0000, ;       <
                        001C,0000,0000, ;
                        0001,0080,0080, ;         A
                        000E,0080,0000, ;         A
                        0001,0480,0400, ;      v  A
                        0005,0480,0000, ;      v  A
                        000B,0400,0000, ;      v
                        0001,0440,0040, ;      v   X
                        0006,0440,0000, ;      v   X
                        0008,0400,0000, ;      v
                        0007,0000,0000, ;
                        0001,0200,0200, ;       <
                        001D,0200,0000, ;       <
                        0009,0000,0000, ;
                        0001,0200,0200, ;       <
                        000E,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        001D,0280,0000, ;       < A
                        0038,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0016,0280,0000, ;       < A
                        002B,0200,0000, ;       <
                        0001,0080,0080, ;         A
                        0010,0080,0000, ;         A
                        0001,0480,0400, ;      v  A
                        0008,0480,0000, ;      v  A
                        0005,0400,0000, ;      v
                        0001,0440,0040, ;      v   X
                        0008,0440,0000, ;      v   X
                        0008,0400,0000, ;      v
                        0008,0000,0000, ;
                        0001,0200,0200, ;       <
                        002B,0200,0000, ;       <
                        0001,0280,0080, ;       < A
                        0010,0280,0000, ;       < A
                        0012,0200,0000, ;       <
                        005D,0000,0000, ;
                        8427            ; Delete
}


;;; $99AE: Instruction list - demo input - gauntlet entrance ;;;
{
$91:99AE             dx 0016,0000,0000, ;
                        0001,0100,0100, ;        >
                        0005,0100,0000, ;        >
                        0100,0000,0000, ;
                        8427            ; Delete
}


;;; $99C8: Instruction list - demo input - advanced grapple beam ;;;
{
$91:99C8             dx 003F,0000,0000, ;
                        0001,0100,0100, ;        >
                        0005,0100,0000, ;        >
                        001E,0000,0000, ;
                        0001,0200,0200, ;       <
                        0005,0200,0000, ;       <
                        0016,0000,0000, ;
                        0001,2000,2000, ;   s
                        0004,2000,0000, ;   s
                        000D,0000,0000, ;
                        0001,2000,2000, ;   s
                        0005,2000,0000, ;   s
                        0008,0000,0000, ;
                        0001,2000,2000, ;   s
                        0006,2000,0000, ;   s
                        0007,0000,0000, ;
                        0001,2000,2000, ;   s
                        0005,2000,0000, ;   s
                        002F,0000,0000, ;
                        0001,0200,0200, ;       <
                        0014,0200,0000, ;       <
                        0002,0000,0000, ;
                        0001,0100,0100, ;        >
                        0006,0100,0000, ;        >
                        0009,0000,0000, ;
                        0001,0040,0040, ;          X
                        0019,0040,0000, ;          X
                        0001,0440,0400, ;      v   X
                        0005,0440,0000, ;      v   X
                        0001,0540,0100, ;      v > X
                        0002,0540,0000, ;      v > X
                        0006,0140,0000, ;        > X
                        0027,0040,0000, ;          X
                        0001,0240,0200, ;       <  X
                        000D,0240,0000, ;       <  X
                        0034,0040,0000, ;          X
                        0001,0140,0100, ;        > X
                        0007,0140,0000, ;        > X
                        0037,0040,0000, ;          X
                        0001,0240,0200, ;       <  X
                        000F,0240,0000, ;       <  X
                        002F,0040,0000, ;          X
                        0001,0140,0100, ;        > X
                        00B1,0140,0000, ;        > X
                        0001,01C0,0080, ;        >AX
                        000B,01C0,0000, ;        >AX
                        00BA,0180,0000, ;        >A
                        0003,0100,0000, ;        >
                        0046,0000,0000, ;
                        8427            ; Delete
}


;;; $9AF0: Instruction list - demo input - IBJ ;;;
{
$91:9AF0             dx 0019,0000,0000, ;
                        0001,0100,0100, ;        >
                        0022,0100,0000, ;        >
                        0018,0000,0000, ;
                        0001,0080,0080, ;         A
                        000B,0080,0000, ;         A
                        0001,0480,0400, ;      v  A
                        0007,0480,0000, ;      v  A
                        0002,0080,0000, ;         A
                        0001,0480,0400, ;      v  A
                        0008,0480,0000, ;      v  A
                        0001,04C0,0040, ;      v  AX
                        0003,04C0,0000, ;      v  AX
                        000A,00C0,0000, ;         AX
                        0002,0080,0000, ;         A
                        0020,0000,0000, ;
                        0001,0040,0040, ;          X
                        000B,0040,0000, ;          X
                        0025,0000,0000, ;
                        0001,0040,0040, ;          X
                        0009,0040,0000, ;          X
                        0026,0000,0000, ;
                        0001,0040,0040, ;          X
                        0009,0040,0000, ;          X
                        0026,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0027,0000,0000, ;
                        0001,0040,0040, ;          X
                        0009,0040,0000, ;          X
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0009,0040,0000, ;          X
                        0026,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        0029,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        0029,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0008,0040,0000, ;          X
                        0027,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        002A,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        002A,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        0028,0000,0000, ;
                        0001,0040,0040, ;          X
                        0007,0040,0000, ;          X
                        0010,0000,0000, ;
                        0001,0100,0100, ;        >
                        001E,0100,0000, ;        >
                        0017,0000,0000, ;
                        0001,0800,0800, ;     ^
                        0009,0800,0000, ;     ^
                        0008,0000,0000, ;
                        0001,0800,0800, ;     ^
                        0005,0800,0000, ;     ^
                        0001,0000,0000, ;
                        0001,0800,0800, ;     ^
                        0009,0000,0000, ;
                        0001,0200,0200, ;       <
                        0004,0200,0000, ;       <
                        00C4,0000,0000, ;
                        8427            ; Delete
}


;;; $9CD8: Instruction list - demo input - SBA ;;;
{
$91:9CD8             dx 001A,0000,0000, ;
                        0001,2000,2000, ;   s
                        0008,2000,0000, ;   s
                        0006,0000,0000, ;
                        0001,2000,2000, ;   s
                        0006,2000,0000, ;   s
                        0006,0000,0000, ;
                        0001,2000,2000, ;   s
                        0006,2000,0000, ;   s
                        0008,0000,0000, ;
                        0001,0080,0080, ;         A
                        0003,0080,0000, ;         A
                        0001,0180,0100, ;        >A
                        0023,0180,0000, ;        >A
                        0007,0100,0000, ;        >
                        0010,0000,0000, ;
                        0001,0080,0080, ;         A
                        0010,0080,0000, ;         A
                        0001,0280,0200, ;       < A
                        0007,0280,0000, ;       < A
                        0001,02C0,0040, ;       < AX
                        0004,02C0,0000, ;       < AX
                        000E,0240,0000, ;       <  X
                        0010,0040,0000, ;          X
                        0001,00C0,0080, ;         AX
                        0008,00C0,0000, ;         AX
                        0001,01C0,0100, ;        >AX
                        000B,01C0,0000, ;        >AX
                        0014,0140,0000, ;        > X
                        0015,0040,0000, ;          X
                        0001,0440,0400, ;      v   X
                        0006,0440,0000, ;      v   X
                        0040,0040,0000, ;          X
                        0034,0000,0000, ;
                        8427            ; Delete
}


;;; $9DA6: Instruction list - demo input - Tourian entrance ;;;
{
$91:9DA6             dx 0195,0000,0000, ;
                        8427            ; Delete
}


;;; $9DAE: Instruction list - demo input - crystal flash ;;;
{
$91:9DAE             dx 001B,0000,0000, ;
                        0001,0400,0400, ;      v
                        0005,0400,0000, ;      v
                        0005,0000,0000, ;
                        0001,0400,0400, ;      v
                        0007,0400,0000, ;      v
                        0009,0000,0000, ;
                        0001,2000,2000, ;   s
                        0006,2000,0000, ;   s
                        0006,0000,0000, ;
                        0001,2000,2000, ;   s
                        0005,2000,0000, ;   s
                        0008,0000,0000, ;
                        0001,2000,2000, ;   s
                        0007,2000,0000, ;   s
                        0031,0000,0000, ;
                        0001,0430,0430, ;      v    LR
                        0009,0430,0000, ;      v    LR
                        0001,0470,0040, ;      v   XLR
                        0010,0470,0000, ;      v   XLR
                        001E,0430,0000, ;      v    LR
                        0001,0470,0040, ;      v   XLR
                        00BE,0470,0000, ;      v   XLR
                        0003,0070,0000, ;          XLR
                        0001,0030,0000, ;           LR
                        0001,0010,0000, ;            R
                        013C,0000,0000, ;
                        8427            ; Delete
}
}


;;; $9E52: Demo input objects - title ;;;
{
;                        _____________ Initialisation (RTS)
;                       |     ________ Pre-instruction (ends demo controller input)
;                       |    |     ___ Pointer to input instruction list
;                       |    |    |
$91:9E52             dw 83BF,8A9B,8ACE ; Landing site
$91:9E58             dw 83BF,8A9B,8C3E ; Pseudo screw attack
$91:9E5E             dw 83BF,8A9B,8DF0 ; Speed booster
$91:9E64             dw 83BF,8A9B,8E64 ; Dachora
$91:9E6A             dw 83BF,8A9B,8EB4 ; Red Brinstar -> Crateria elevator
$91:9E70             dw 83BF,8A9B,8F3A ; Pre Phantoon hall
$91:9E76             dw 83BF,8A9B,8FE4 ; Lower Norfair entrance
$91:9E7C             dw 83BF,8A9B,9154 ; Eye door
$91:9E82             dw 83BF,8AB0,933C ; Shinespark
$91:9E88             dw 83BF,8A9B,93CC ; Missile door
$91:9E8E             dw 83BF,8A9B,9464 ; Kraid
$91:9E94             dw 83BF,8A9B,946C ; Fireflea room
$91:9E9A             dw 83BF,8A9B,950A ; Screw attack
$91:9EA0             dw 83BF,8A9B,9560 ; Brinstar diagonal room
$91:9EA6             dw 83BF,8A9B,95BC ; Unused
$91:9EAC             dw 83BF,8A9B,965A ; Pre Spore Spawn hall
$91:9EB2             dw 83BF,8A9B,973A ; Grapple beam
$91:9EB8             dw 83BF,8A9B,989E ; Ice beam
$91:9EBE             dw 83BF,8A9B,99AE ; Gauntlet entrance
$91:9EC4             dw 83BF,8A9B,99C8 ; Advanced grapple beam
$91:9ECA             dw 83BF,8A9B,9AF0 ; IBJ
$91:9ED0             dw 83BF,8A9B,9CD8 ; SBA
$91:9ED6             dw 83BF,8A9B,9DA6 ; Tourian entrance
$91:9EDC             dw 83BF,8A9B,9DAE ; Crystal flash
}
}


;;; $9EE2..B00F: Transition table ;;;
{
; Transition table entries have the format:
;     nnnn cccc pppp
;     nnnn cccc pppp
;     FFFF
; where:
;     n is the required newly pressed input, n = FFFF terminates the table entry
;     c is the required held input
;     p is the pose to transition to (if not currently already in that pose)

; Note that all of the buttons in c and n must be part of the respective input.
; Buttons are defined with the following bitflags:
;     8000: Run
;     4000: Cancel
;     2000: Select
;     1000: Start
;     0800: Up
;     0400: Down
;     0200: Left
;     0100: Right
;     0080: Jump
;     0040: Shoot
;     0020: Aim diagonally down
;     0010: Aim diagonally up

$91:9EE2             dw A0DE, A0EC, A172, A0EC, A172, A0EC, A172, A0EC, A172, A1F8, A242, AE94, AEDE, A1F8, A242, A1F8,
                        A242, A1F8, A242, AAC0, AB3A, A2F6, A376, ABB4, AC40, A41E, A46E, A4BE, A50E, A5FE, A618, A632,
                        A666, A666, A666, A668, A666, ACF4, AD08, A66C, A6BC, A70C, A750, A70C, A750, AD94, ADD2, A0DC,
                        A0DC, A794, A7AE, A7C8, A7CA, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, ACCC, ACE0, A0DC,
                        A0DC, A64C, A66A, A0DC, A0DC, A7CC, A7E0, A7F4, A834, A874, A8AC, A28C, A2BE, A2F6, A376, A3F6,
                        A40A, A2F6, A376, A8E4, A8EC, A28C, A2BE, A28C, A2BE, A28C, A2BE, A8FC, A904, A0DC, A0DC, A0DC,
                        A0DC, A0DC, A0DC, A990, A998, A9A0, A9C6, AF28, AF60, A2F6, A376, A2F6, A376, A70C, A750, A70C,
                        A750, A66C, A6BC, A66C, A6BC, A874, A8AC, A874, A8AC, A90C, A926, A90C, A926, A940, A954, A968,
                        A97C, A55E, A5AE, A9EC, AA12, A66C, A6BC, A0DC, A0DC, AA38, AA7C, AD1C, AD30, AD44, AD58, A0DC,
                        A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DE, A0DC, A0DC, A0DC, A0DC,
                        A0DC, A0DC, A0DC, A0DC, A0EC, A172, A0EC, A172, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC,
                        A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, AE18, AE18, AE18, AE18, AE18, AF98,
                        AFAC, AFC0, AFD4, AFE8, AFFC, A0DC, A0DC, AD6C, AD80, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, AA38,
                        AA7C, AA38, AA7C, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, AE10,
                        A0EC, A172, A0EC, A172, A0EC, A172, A0EC, A172, A0DC, A0DC, A0DC, A0DC, AE56, AE56, AE56, AE56,
                        AE56, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC, A0DC


;;; $A0DC: Transition table - entry 2F/30/35/36/37/38/39/3A/3B/3C/3F/40/43/44/5D/5E/5F/60/61/62/87/88/8F/90/91/92/93/94/95/96/97/98/99/9A/9C/9D/9E/9F/A0/A1/A2/A3/A8/A9/AA/AB/AC/AD/AE/AF/B0/B1/B2/B3/B4/B5/B6/B7/B8/B9/C5/C6/C9/CA/CB/CC/CD/CE/D3/D4/D5/D6/D7/D8/D9/DA/DB/DC/DD/DE/E8/E9/EA/EB/F1/F2/F3/F4/F5/F6/F7/F8/F9/FA/FB/FC ;;;
{
$91:A0DC             dw FFFF
}


;;; $A0DE: Transition table - entry 00/9B ;;;
{
; 00: Facing forward - power suit
; 9B: Facing forward - varia/gravity suit
$91:A0DE             dw 0000, 0100, 0026,
                        0000, 0200, 0025,
                        FFFF
}


;;; $A0EC: Transition table - entry 01/03/05/07/A4/A6/E0/E2/E4/E6 ;;;
{
; 01: Facing right - normal
; 03: Facing right - aiming up
; 05: Facing right - aiming up-right
; 07: Facing right - aiming down-right
; A4: Facing right - landing from normal jump
; A6: Facing right - landing from spin jump
; E0: Facing right - landing from normal jump - aiming up
; E2: Facing right - landing from normal jump - aiming up-right
; E4: Facing right - landing from normal jump - aiming down-right
; E6: Facing right - landing from normal jump - firing
$91:A0EC             dw 0080, 0800, 0055,
                        0080, 0010, 0057,
                        0080, 0020, 0059,
                        0080, 0000, 004B,
                        0400, 0030, 00F1,
                        0400, 0010, 00F3,
                        0400, 0020, 00F5,
                        0400, 0000, 0035,
                        0000, 0260, 0078,
                        0000, 0250, 0076,
                        0000, 0230, 0025,
                        0000, 0030, 0003,
                        0000, 0110, 000F,
                        0000, 0120, 0011,
                        0000, 0900, 000F,
                        0000, 0500, 0011,
                        0000, 0240, 004A,
                        0000, 0200, 0025,
                        0000, 0800, 0003,
                        0000, 0010, 0005,
                        0000, 0020, 0007,
                        0000, 0100, 0009,
                        FFFF
}


;;; $A172: Transition table - entry 02/04/06/08/A5/A7/E1/E3/E5/E7 ;;;
{
; 02: Facing left - normal
; 04: Facing left - aiming up
; 06: Facing left - aiming up-left
; 08: Facing left - aiming down-left
; A5: Facing left - landing from normal jump
; A7: Facing left - landing from spin jump
; E1: Facing left - landing from normal jump - aiming up
; E3: Facing left - landing from normal jump - aiming up-left
; E5: Facing left - landing from normal jump - aiming down-left
; E7: Facing left - landing from normal jump - firing
$91:A172             dw 0080, 0800, 0056,
                        0080, 0010, 0058,
                        0080, 0020, 005A,
                        0080, 0000, 004C,
                        0400, 0030, 00F2,
                        0400, 0010, 00F4,
                        0400, 0020, 00F6,
                        0400, 0000, 0036,
                        0000, 0160, 0077,
                        0000, 0150, 0075,
                        0000, 0130, 0026,
                        0000, 0030, 0004,
                        0000, 0210, 0010,
                        0000, 0220, 0012,
                        0000, 0A00, 0010,
                        0000, 0600, 0012,
                        0000, 0140, 0049,
                        0000, 0100, 0026,
                        0000, 0800, 0004,
                        0000, 0010, 0006,
                        0000, 0020, 0008,
                        0000, 0200, 000A,
                        FFFF
}


;;; $A1F8: Transition table - entry 09/0D/0F/11 ;;;
{
; 09: Moving right - not aiming
; 0D: Moving right - aiming up (unused)
; 0F: Moving right - aiming up-right
; 11: Moving right - aiming down-right
$91:A1F8             dw 0400, 0000, 0035,
                        0080, 0000, 0019,
                        0000, 0110, 000F,
                        0000, 0120, 0011,
                        0000, 0900, 000F,
                        0000, 0500, 0011,
                        0000, 0140, 000B,
                        0000, 0100, 0009,
                        0000, 0200, 0025,
                        0000, 0800, 0003,
                        0000, 0010, 0005,
                        0000, 0020, 0007,
                        FFFF
}


;;; $A242: Transition table - entry 0A/0E/10/12 ;;;
{
; 0A: Moving left - not aiming
; 0E: Moving left - aiming up (unused)
; 10: Moving left - aiming up-left
; 12: Moving left - aiming down-left
$91:A242             dw 0400, 0000, 0036,
                        0080, 0000, 001A,
                        0000, 0210, 0010,
                        0000, 0220, 0012,
                        0000, 0A00, 0010,
                        0000, 0600, 0012,
                        0000, 0240, 000C,
                        0000, 0200, 000A,
                        0000, 0100, 0026,
                        0000, 0800, 0004,
                        0000, 0010, 0006,
                        0000, 0020, 0008,
                        FFFF
}


;;; $A28C: Transition table - entry 4B/55/57/59 ;;;
{
; 4B: Facing right - normal jump transition
; 55: Facing right - normal jump transition - aiming up
; 57: Facing right - normal jump transition - aiming up-right
; 59: Facing right - normal jump transition - aiming down-right
$91:A28C             dw 0000, 0280, 002F,
                        0000, 0880, 0015,
                        0000, 0480, 0017,
                        0000, 0090, 0069,
                        0000, 00A0, 006B,
                        0000, 0180, 0051,
                        0000, 00C0, 0013,
                        0000, 0040, 0013,
                        FFFF
}


;;; $A2BE: Transition table - entry 4C/56/58/5A ;;;
{
; 4C: Facing left - normal jump transition
; 56: Facing left - normal jump transition - aiming up
; 58: Facing left - normal jump transition - aiming up-left
; 5A: Facing left - normal jump transition - aiming down-left
$91:A2BE             dw 0000, 0180, 0030,
                        0000, 0880, 0016,
                        0000, 0480, 0018,
                        0000, 0090, 006A,
                        0000, 00A0, 006C,
                        0000, 0280, 0052,
                        0000, 00C0, 0014,
                        0000, 0100, 0030,
                        0000, 0040, 0014,
                        FFFF
}


;;; $A2F6: Transition table - entry 15/4D/51/69/6B ;;;
{
; 15: Facing right - normal jump - aiming up
; 4D: Facing right - normal jump - not aiming - not moving - gun not extended
; 51: Facing right - normal jump - not aiming - moving forward
; 69: Facing right - normal jump - aiming up-right
; 6B: Facing right - normal jump - aiming down-right
$91:A2F6             dw 0000, 0980, 0069,
                        0000, 0580, 006B,
                        0000, 0190, 0069,
                        0000, 01A0, 006B,
                        0000, 0900, 0069,
                        0000, 0500, 006B,
                        0000, 0280, 002F,
                        0000, 0880, 0015,
                        0000, 0480, 0017,
                        0000, 0090, 0069,
                        0000, 00A0, 006B,
                        0000, 0180, 0051,
                        0000, 00C0, 0013,
                        0000, 0200, 002F,
                        0000, 0800, 0015,
                        0000, 0400, 0017,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0100, 0051,
                        0000, 0080, 004D,
                        0000, 0040, 0013,
                        FFFF
}


;;; $A376: Transition table - entry 16/4E/52/6A/6C ;;;
{
; 16: Facing left - normal jump - aiming up
; 4E: Facing left - normal jump - not aiming - not moving - gun not extended
; 52: Facing left - normal jump - not aiming - moving forward
; 6A: Facing left - normal jump - aiming up-left
; 6C: Facing left - normal jump - aiming down-left
$91:A376             dw 0000, 0A80, 006A,
                        0000, 0680, 006C,
                        0000, 0290, 006A,
                        0000, 02A0, 006C,
                        0000, 0A00, 006A,
                        0000, 0600, 006C,
                        0000, 0180, 0030,
                        0000, 0880, 0016,
                        0000, 0480, 0018,
                        0000, 0090, 006A,
                        0000, 00A0, 006C,
                        0000, 0280, 0052,
                        0000, 00C0, 0014,
                        0000, 0100, 0030,
                        0000, 0800, 0016,
                        0000, 0400, 0018,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0200, 0052,
                        0000, 0080, 004E,
                        0000, 0040, 0014,
                        FFFF
}


;;; $A3F6: Transition table - entry 4F ;;;
{
; 4F: Facing left - damage boost
$91:A3F6             dw 0000, 0280, 0052,
                        0000, 0180, 004F,
                        0000, 0080, 004E,
                        FFFF
}


;;; $A40A: Transition table - entry 50 ;;;
{
; 50: Facing right - damage boost
$91:A40A             dw 0000, 0280, 0050,
                        0000, 0180, 0051,
                        0000, 0080, 004D,
                        FFFF
}


;;; $A41E: Transition table - entry 19 ;;;
{
; 19: Facing right - spin jump
$91:A41E             dw 0040, 0000, 0013,
                        0040, 0100, 0013,
                        0000, 0840, 0015,
                        0000, 0440, 0017,
                        0000, 0050, 0069,
                        0000, 0060, 006B,
                        0000, 0180, 0019,
                        0000, 0800, 0015,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0400, 0017,
                        0000, 0100, 0019,
                        0000, 0200, 001A,
                        FFFF
}


;;; $A46E: Transition table - entry 1A ;;;
{
; 1A: Facing left - spin jump
$91:A46E             dw 0040, 0000, 0014,
                        0040, 0200, 0014,
                        0000, 0840, 0016,
                        0000, 0440, 0018,
                        0000, 0050, 006A,
                        0000, 0060, 006C,
                        0000, 0280, 001A,
                        0000, 0800, 0016,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0400, 0018,
                        0000, 0200, 001A,
                        0000, 0100, 0019,
                        FFFF
}


;;; $A4BE: Transition table - entry 1B ;;;
{
; 1B: Facing right - space jump
$91:A4BE             dw 0040, 0000, 0013,
                        0040, 0100, 0013,
                        0000, 0840, 0015,
                        0000, 0440, 0017,
                        0000, 0050, 0069,
                        0000, 0060, 006B,
                        0000, 0180, 001B,
                        0000, 0800, 0015,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0400, 0017,
                        0000, 0100, 001B,
                        0000, 0200, 001C,
                        FFFF
}


;;; $A50E: Transition table - entry 1C ;;;
{
; 1C: Facing left - space jump
$91:A50E             dw 0040, 0000, 0014,
                        0040, 0200, 0014,
                        0000, 0840, 0016,
                        0000, 0440, 0018,
                        0000, 0050, 006A,
                        0000, 0060, 006C,
                        0000, 0280, 001C,
                        0000, 0800, 0016,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0400, 0018,
                        0000, 0200, 001C,
                        0000, 0100, 001B,
                        FFFF
}


;;; $A55E: Transition table - entry 81 ;;;
{
; 81: Facing right - screw attack
$91:A55E             dw 0040, 0000, 0013,
                        0040, 0100, 0013,
                        0000, 0840, 0015,
                        0000, 0440, 0017,
                        0000, 0050, 0069,
                        0000, 0060, 006B,
                        0000, 0180, 0081,
                        0000, 0800, 0015,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0400, 0017,
                        0000, 0100, 0081,
                        0000, 0200, 0082,
                        FFFF
}


;;; $A5AE: Transition table - entry 82 ;;;
{
; 82: Facing left - screw attack
$91:A5AE             dw 0040, 0000, 0014,
                        0040, 0200, 0014,
                        0000, 0840, 0016,
                        0000, 0440, 0018,
                        0000, 0050, 006A,
                        0000, 0060, 006C,
                        0000, 0280, 0082,
                        0000, 0800, 0016,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0400, 0018,
                        0000, 0200, 0082,
                        0000, 0100, 0081,
                        FFFF
}


;;; $A5FE: Transition table - entry 1D ;;;
{
; 1D: Facing right - morph ball - no springball - on ground
$91:A5FE             dw 0800, 0000, 003D,
                        0080, 0000, 003D,
                        0000, 0100, 001E,
                        0000, 0200, 001F,
                        FFFF
}


;;; $A618: Transition table - entry 1E ;;;
{
; 1E: Moving right - morph ball - no springball - on ground
$91:A618             dw 0800, 0000, 003D,
                        0080, 0000, 003D,
                        0000, 0100, 001E,
                        0000, 0200, 001F,
                        FFFF
}


;;; $A632: Transition table - entry 1F ;;;
{
; 1F: Moving left - morph ball - no springball - on ground
$91:A632             dw 0800, 0000, 003E,
                        0080, 0000, 003E,
                        0000, 0100, 001E,
                        0000, 0200, 001F,
                        FFFF
}


;;; $A64C: Transition table - entry 41 ;;;
{
; 41: Facing left - morph ball - no springball - on ground
$91:A64C             dw 0800, 0000, 003E,
                        0080, 0000, 003E,
                        0000, 0100, 001E,
                        0000, 0200, 001F,
                        FFFF
}


;;; $A666: Transition table - entry 20/21/22/24 ;;;
{
; Unused
$91:A666             dw FFFF
}


;;; $A668: Transition table - entry 23 ;;;
{
; Unused
$91:A668             dw FFFF
}


;;; $A66A: Transition table - entry 42 ;;;
{
; Unused
$91:A66A             dw FFFF
}


;;; $A66C: Transition table - entry 27/71/73/85 ;;;
{
; 27: Facing right - crouching
; 71: Facing right - crouching transition - aiming up-right
; 73: Facing right - crouching transition - aiming down-right
; 85: Facing right - crouching - aiming up
$91:A66C             dw 0800, 0030, 00F7,
                        0800, 0010, 00F9,
                        0800, 0020, 00FB,
                        0800, 0000, 003B,
                        0200, 0000, 0043,
                        0400, 0000, 0037,
                        0080, 0000, 004B,
                        0000, 0030, 0085,
                        0000, 0110, 0001,
                        0000, 0120, 0001,
                        0000, 0010, 0071,
                        0000, 0020, 0073,
                        0000, 0100, 0001,
                        FFFF
}


;;; $A6BC: Transition table - entry 28/72/74/86 ;;;
{
; 28: Facing left - crouching
; 72: Facing left - crouching transition - aiming up-left
; 74: Facing left - crouching transition - aiming down-left
; 86: Facing left - crouching - aiming up
$91:A6BC             dw 0800, 0030, 00F8,
                        0800, 0010, 00FA,
                        0800, 0020, 00FC,
                        0800, 0000, 003C,
                        0100, 0000, 0044,
                        0400, 0000, 0038,
                        0080, 0000, 004C,
                        0000, 0030, 0086,
                        0000, 0220, 0002,
                        0000, 0210, 0002,
                        0000, 0010, 0072,
                        0000, 0020, 0074,
                        0000, 0200, 0002,
                        FFFF
}


;;; $A70C: Transition table - entry 29/2B/6D/6F ;;;
{
; 29: Facing right - falling
; 2B: Facing right - falling - aiming up
; 6D: Facing right - falling - aiming up-right
; 6F: Facing right - falling - aiming down-right
$91:A70C             dw 0000, 0900, 006D,
                        0000, 0500, 006F,
                        0000, 0A00, 0087,
                        0000, 0600, 0087,
                        0000, 0200, 0087,
                        0000, 0800, 002B,
                        0000, 0400, 002D,
                        0000, 0010, 006D,
                        0000, 0020, 006F,
                        0000, 0040, 0067,
                        0000, 0100, 0029,
                        FFFF
}


;;; $A750: Transition table - entry 2A/2C/6E/70 ;;;
{
; 2A: Facing left - falling
; 2C: Facing left - falling - aiming up
; 6E: Facing left - falling - aiming up-left
; 70: Facing left - falling - aiming down-left
$91:A750             dw 0000, 0A00, 006E,
                        0000, 0600, 0070,
                        0000, 0900, 0088,
                        0000, 0500, 0088,
                        0000, 0100, 0088,
                        0000, 0800, 002C,
                        0000, 0400, 002E,
                        0000, 0010, 006E,
                        0000, 0020, 0070,
                        0000, 0040, 0068,
                        0000, 0200, 002A,
                        FFFF
}


;;; $A794: Transition table - entry 31 ;;;
{
; 31: Facing right - morph ball - no springball - in air
$91:A794             dw 0800, 0000, 003D,
                        0080, 0000, 003D,
                        0000, 0100, 0031,
                        0000, 0200, 0032,
                        FFFF
}


;;; $A7AE: Transition table - entry 32 ;;;
{
; 32: Facing left - morph ball - no springball - in air
$91:A7AE             dw 0800, 0000, 003E,
                        0080, 0000, 003E,
                        0000, 0200, 0032,
                        0000, 0100, 0031,
                        FFFF
}


;;; $A7C8: Transition table - entry 33 ;;;
{
; Unused
$91:A7C8             dw FFFF
}


;;; $A7CA: Transition table - entry 34 ;;;
{
; Unused
$91:A7CA             dw FFFF
}


;;; $A7CC: Transition table - entry 45 ;;;
{
; Unused
$91:A7CC             dw 0000, 0240, 0045,
                        0000, 0100, 0009,
                        0000, 0200, 0025,
                        FFFF
}


;;; $A7E0: Transition table - entry 46 ;;;
{
; Unused
$91:A7E0             dw 0000, 0140, 0046,
                        0000, 0200, 000A,
                        0000, 0100, 0026,
                        FFFF
}


;;; $A7F4: Transition table - entry 47 ;;;
{
; Unused
$91:A7F4             dw FFFF
}


;;; $A7F6: Unused ;;;
{
; Possibly no-op'd sections of the above?
$91:A7F6             dw 0080, 0000, 004B,
                        0400, 0000, 0035,
                        0000, 0210, 0078,
                        0000, 0220, 0076,
                        0000, 0240, 004A,
                        0000, 0100, 0009,
                        0000, 0200, 0025,
                        0000, 0800, 0003,
                        0000, 0010, 0005,
                        0000, 0020, 0007,
                        FFFF
}


;;; $A834: Transition table - entry 48 ;;;
{
; Unused
$91:A834             dw FFFF
}


;;; $A836: Unused ;;;
{
; Possibly no-op'd sections of the above?
$91:A836             dw 0080, 0000, 004C,
                        0400, 0000, 0036,
                        0000, 0120, 0077,
                        0000, 0110, 0075,
                        0000, 0140, 0049,
                        0000, 0200, 000A,
                        0000, 0100, 0026,
                        0000, 0800, 0004,
                        0000, 0010, 0006,
                        0000, 0020, 0008,
                        FFFF
}


;;; $A874: Transition table - entry 49/75/77 ;;;
{
; 49: Facing left - moonwalk
; 75: Facing left - moonwalk - aiming up-left
; 77: Facing left - moonwalk - aiming down-left
$91:A874             dw 0400, 0000, 0036,
                        0080, 0000, 00C0,
                        0080, 0010, 00C2,
                        0080, 0020, 00C4,
                        0000, 0160, 0077,
                        0000, 0150, 0075,
                        0000, 0140, 0049,
                        0000, 0200, 000A,
                        0000, 0100, 0026,
                        FFFF
}


;;; $A8AC: Transition table - entry 4A/76/78 ;;;
{
; 4A: Facing right - moonwalk
; 76: Facing right - moonwalk - aiming up-right
; 78: Facing right - moonwalk - aiming down-right
$91:A8AC             dw 0400, 0000, 0035,
                        0080, 0000, 00BF,
                        0080, 0010, 00C1,
                        0080, 0020, 00C3,
                        0000, 0250, 0076,
                        0000, 0260, 0078,
                        0000, 0240, 004A,
                        0000, 0100, 0009,
                        0000, 0200, 0025,
                        FFFF
}


;;; $A8E4: Transition table - entry 53 ;;;
{
; 53: Facing right - knockback
$91:A8E4             dw 0000, 0280, 0050,
                        FFFF
}


;;; $A8EC: Transition table - entry 54 ;;;
{
; 54: Facing left - knockback
$91:A8EC             dw 0000, 0180, 004F,
                        FFFF
}


;;; $A8F4: Unused ;;;
{
$91:A8F4             dw FFFF
$91:A8F6             dw FFFF
$91:A8F8             dw FFFF
$91:A8FA             dw FFFF
}


;;; $A8FC: Transition table - entry 5B ;;;
{
; Unused
$91:A8FC             dw 0000, 0280, 0066,
                        FFFF
}


;;; $A904: Transition table - entry 5C ;;;
{
; Unused
$91:A904             dw 0000, 0180, 0065,
                        FFFF
}


;;; $A90C: Transition table - entry 79/7B ;;;
{
; 79: Facing right - morph ball - spring ball - on ground
; 7B: Moving right - morph ball - spring ball - on ground
$91:A90C             dw 0800, 0000, 003D,
                        0080, 0000, 007F,
                        0000, 0100, 007B,
                        0000, 0200, 007C,
                        FFFF
}


;;; $A926: Transition table - entry 7A/7C ;;;
{
; 7A: Facing left - morph ball - spring ball - on ground
; 7C: Moving left - morph ball - spring ball - on ground
$91:A926             dw 0800, 0000, 003E,
                        0080, 0000, 0080,
                        0000, 0100, 007B,
                        0000, 0200, 007C,
                        FFFF
}


;;; $A940: Transition table - entry 7D ;;;
{
; 7D: Facing right - morph ball - spring ball - falling
$91:A940             dw 0800, 0000, 003D,
                        0000, 0200, 007E,
                        0000, 0100, 007D,
                        FFFF
}


;;; $A954: Transition table - entry 7E ;;;
{
; 7E: Facing left - morph ball - spring ball - falling
$91:A954             dw 0800, 0000, 003E,
                        0000, 0100, 007D,
                        0000, 0200, 007E,
                        FFFF
}


;;; $A968: Transition table - entry 7F ;;;
{
; 7F: Facing right - morph ball - spring ball - in air
$91:A968             dw 0800, 0000, 003D,
                        0000, 0100, 007F,
                        0000, 0200, 0080,
                        FFFF
}


;;; $A97C: Transition table - entry 80 ;;;
{
; 80: Facing left - morph ball - spring ball - in air
$91:A97C             dw 0800, 0000, 003E,
                        0000, 0100, 007F,
                        0000, 0200, 0080,
                        FFFF
}


;;; $A990: Transition table - entry 63 ;;;
{
; Unused
$91:A990             dw 0000, 0280, 0066,
                        FFFF
}


;;; $A998: Transition table - entry 64 ;;;
{
; Unused
$91:A998             dw 0000, 0180, 0065,
                        FFFF
}


;;; $A9A0: Transition table - entry 65 ;;;
{
; Unused
$91:A9A0             dw 0000, 0180, 0065,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0040, 0013,
                        0000, 0080, 0065,
                        0000, 0100, 0065,
                        FFFF
}


;;; $A9C6: Transition table - entry 66 ;;;
{
; 66: Unused
$91:A9C6             dw 0000, 0280, 0066,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0040, 0014,
                        0000, 0080, 0066,
                        0000, 0200, 0066,
                        FFFF
}


;;; $A9EC: Transition table - entry 83 ;;;
{
; 83: Facing right - wall jump
$91:A9EC             dw 0400, 0000, 0037,
                        0000, 0200, 001A,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0040, 0013,
                        0000, 0080, 0083,
                        FFFF
}


;;; $AA12: Transition table - entry 84 ;;;
{
; 84: Facing left - wall jump
$91:AA12             dw 0400, 0000, 0038,
                        0000, 0100, 0019,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0040, 0014,
                        0000, 0080, 0084,
                        FFFF
}


;;; $AA38: Transition table - entry 89/CF/D1 ;;;
{
; 89: Facing right - ran into a wall
; CF: Facing right - ran into a wall - aiming up-right
; D1: Facing right - ran into a wall - aiming down-right
$91:AA38             dw 0080, 0000, 004B,
                        0000, 0900, 000F,
                        0000, 0500, 0011,
                        0400, 0000, 0035,
                        0000, 0220, 0078,
                        0000, 0210, 0076,
                        0000, 0800, 0003,
                        0000, 0010, 0005,
                        0000, 0020, 0007,
                        0000, 0200, 0025,
                        0000, 0100, 0009,
                        FFFF
}


;;; $AA7C: Transition table - entry 8A/D0/D2 ;;;
{
; 8A: Facing left - ran into a wall
; D0: Facing left - ran into a wall - aiming up-left
; D2: Facing left - ran into a wall - aiming down-left
$91:AA7C             dw 0080, 0000, 004C,
                        0000, 0A00, 0010,
                        0000, 0600, 0012,
                        0400, 0000, 0036,
                        0000, 0120, 0077,
                        0000, 0110, 0075,
                        0000, 0800, 0004,
                        0000, 0010, 0006,
                        0000, 0020, 0008,
                        0000, 0100, 0026,
                        0000, 0200, 000A,
                        FFFF
}


;;; $AAC0: Transition table - entry 13 ;;;
{
; 13: Facing right - normal jump - not aiming - not moving - gun extended
$91:AAC0             dw 0000, 0980, 0069,
                        0000, 0580, 006B,
                        0000, 0190, 0069,
                        0000, 01A0, 006B,
                        0000, 0900, 0069,
                        0000, 0500, 006B,
                        0000, 0280, 002F,
                        0000, 0880, 0015,
                        0000, 0480, 0017,
                        0000, 0090, 0069,
                        0000, 00A0, 006B,
                        0000, 0180, 0051,
                        0000, 00C0, 0013,
                        0000, 0200, 002F,
                        0000, 0800, 0015,
                        0000, 0400, 0017,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0100, 0051,
                        0000, 0040, 0013,
                        FFFF
}


;;; $AB3A: Transition table - entry 14 ;;;
{
; 14: Facing left - normal jump - not aiming - not moving - gun extended
$91:AB3A             dw 0000, 0A80, 006A,
                        0000, 0680, 006C,
                        0000, 0290, 006A,
                        0000, 02A0, 006C,
                        0000, 0A00, 006A,
                        0000, 0600, 006C,
                        0000, 0180, 0030,
                        0000, 0880, 0016,
                        0000, 0480, 0018,
                        0000, 0090, 006A,
                        0000, 00A0, 006C,
                        0000, 0280, 0052,
                        0000, 00C0, 0014,
                        0000, 0100, 0030,
                        0000, 0800, 0016,
                        0000, 0400, 0018,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0200, 0052,
                        0000, 0040, 0014,
                        FFFF
}


;;; $ABB4: Transition table - entry 17 ;;;
{
; 17: Facing right - normal jump - aiming down
$91:ABB4             dw 0400, 0000, 0037,
                        0000, 0980, 0069,
                        0000, 0580, 006B,
                        0000, 0190, 0069,
                        0000, 01A0, 006B,
                        0000, 01C0, 0013,
                        0000, 0900, 0069,
                        0000, 0500, 006B,
                        0000, 0280, 002F,
                        0000, 0880, 0015,
                        0000, 0480, 0017,
                        0000, 0090, 0069,
                        0000, 00A0, 006B,
                        0000, 0180, 0051,
                        0000, 00C0, 0013,
                        0000, 0200, 002F,
                        0000, 0800, 0015,
                        0000, 0400, 0017,
                        0000, 0010, 0069,
                        0000, 0020, 006B,
                        0000, 0100, 0051,
                        0000, 0080, 0017,
                        0000, 0040, 0013,
                        FFFF
}


;;; $AC40: Transition table - entry 18 ;;;
{
; 18: Facing left - normal jump - aiming down
$91:AC40             dw 0400, 0000, 0038,
                        0000, 0A80, 006A,
                        0000, 0680, 006C,
                        0000, 0290, 006A,
                        0000, 02A0, 006C,
                        0000, 02A0, 006C,
                        0000, 0A00, 006A,
                        0000, 0600, 006C,
                        0000, 0180, 0030,
                        0000, 0880, 0016,
                        0000, 0480, 0018,
                        0000, 0090, 006A,
                        0000, 00A0, 006C,
                        0000, 0280, 0052,
                        0000, 00C0, 0014,
                        0000, 0100, 0030,
                        0000, 0800, 0016,
                        0000, 0400, 0018,
                        0000, 0010, 006A,
                        0000, 0020, 006C,
                        0000, 0200, 0052,
                        0000, 0080, 0018,
                        0000, 0040, 0014,
                        FFFF
}


;;; $ACCC: Transition table - entry 3D ;;;
{
; 3D: Facing right - unmorphing
$91:ACCC             dw 0000, 0140, 0067,
                        0000, 0840, 002B,
                        0000, 0440, 002D,
                        FFFF
}


;;; $ACE0: Transition table - entry 3E ;;;
{
; 3E: Facing left - unmorphing
$91:ACE0             dw 0000, 0240, 0068,
                        0000, 0840, 002C,
                        0000, 0440, 002E,
                        FFFF
}


;;; $ACF4: Transition table - entry 25 ;;;
{
; 25: Facing right - turning - standing
$91:ACF4             dw 0000, 0280, 001A,
                        0080, 0000, 004C,
                        0000, 0200, 0025,
                        FFFF
}


;;; $AD08: Transition table - entry 26 ;;;
{
; 26: Facing left - turning - standing
$91:AD08             dw 0000, 0180, 0019,
                        0080, 0000, 004B,
                        0000, 0100, 0026,
                        FFFF
}


;;; $AD1C: Transition table - entry 8B ;;;
{
; 8B: Facing right - turning - standing - aiming up
$91:AD1C             dw 0080, 0200, 001A,
                        0080, 0000, 004C,
                        0000, 0200, 008B,
                        FFFF
}


;;; $AD30: Transition table - entry 8C ;;;
{
; 8C: Facing left - turning - standing - aiming up
$91:AD30             dw 0080, 0100, 0019,
                        0080, 0000, 004B,
                        0000, 0100, 008C,
                        FFFF
}


;;; $AD44: Transition table - entry 8D ;;;
{
; 8D: Facing right - turning - standing - aiming down-right
$91:AD44             dw 0080, 0200, 001A,
                        0080, 0000, 004C,
                        0000, 0200, 008D,
                        FFFF
}


;;; $AD58: Transition table - entry 8E ;;;
{
; 8E: Facing left - turning - standing - aiming down-left
$91:AD58             dw 0080, 0100, 0019,
                        0080, 0000, 004B,
                        0000, 0100, 008E,
                        FFFF
}


;;; $AD6C: Transition table - entry C7 ;;;
{
; C7: Facing right - vertical shinespark windup
$91:AD6C             dw 0000, 0880, 00CB,
                        0000, 0090, 00CD,
                        0000, 0180, 00C9,
                        FFFF
}


;;; $AD80: Transition table - entry C8 ;;;
{
; C8: Facing left - vertical shinespark windup
$91:AD80             dw 0000, 0880, 00CC,
                        0000, 0090, 00CE,
                        0000, 0280, 00CA,
                        FFFF
}


;;; $AD94: Transition table - entry 2D ;;;
{
; 2D: Facing right - falling - aiming down
$91:AD94             dw 0400, 0000, 0037,
                        0000, 0900, 006D,
                        0000, 0500, 006F,
                        0000, 0800, 002B,
                        0000, 0400, 002D,
                        0000, 0200, 0087,
                        0000, 0010, 006D,
                        0000, 0020, 006F,
                        0000, 0040, 0067,
                        0000, 0100, 0029,
                        FFFF
}


;;; $ADD2: Transition table - entry 2E ;;;
{
; 2E: Facing left - falling - aiming down
$91:ADD2             dw 0400, 0000, 0038,
                        0000, 0A00, 006E,
                        0000, 0600, 0070,
                        0000, 0800, 002C,
                        0000, 0400, 002E,
                        0000, 0100, 0088,
                        0000, 0010, 006E,
                        0000, 0020, 0070,
                        0000, 0040, 0068,
                        0000, 0200, 002A,
                        FFFF
}


;;; $AE10: Transition table - entry DF ;;;
{
; Unused
$91:AE10             dw 0800, 0000, 00DE,
                        FFFF
}


;;; $AE18: Transition table - entry BA/BB/BC/BD/BE ;;;
{
; BA: Facing left - grabbed by Draygon - not moving - not aiming
; BB: Facing left - grabbed by Draygon - not moving - aiming up-left
; BC: Facing left - grabbed by Draygon - firing
; BD: Facing left - grabbed by Draygon - not moving - aiming down-left
; BE: Facing left - grabbed by Draygon - moving
$91:AE18             dw 0000, 0A40, 00BB,
                        0000, 0640, 00BD,
                        0000, 0240, 00BC,
                        0000, 0010, 00BB,
                        0000, 0020, 00BD,
                        0000, 0040, 00BC,
                        0000, 0200, 00BE,
                        0000, 0100, 00BE,
                        0000, 0800, 00BE,
                        0000, 0400, 00BE,
                        FFFF
}


;;; $AE56: Transition table - entry EC/ED/EE/EF/F0 ;;;
{
; EC: Facing right - grabbed by Draygon - not moving - not aiming
; ED: Facing right - grabbed by Draygon - not moving - aiming up-right
; EE: Facing right - grabbed by Draygon - firing
; EF: Facing right - grabbed by Draygon - not moving - aiming down-right
; F0: Facing right - grabbed by Draygon - moving
$91:AE56             dw 0000, 0940, 00ED,
                        0000, 0540, 00EF,
                        0000, 0140, 00EE,
                        0000, 0010, 00ED,
                        0000, 0020, 00EF,
                        0000, 0040, 00EE,
                        0000, 0200, 00F0,
                        0000, 0100, 00F0,
                        0000, 0800, 00F0,
                        0000, 0400, 00F0,
                        FFFF
}


;;; $AE94: Transition table - entry 0B ;;;
{
; 0B: Moving right - gun extended
$91:AE94             dw 0400, 0000, 0035,
                        0080, 0000, 0019,
                        0000, 0110, 000F,
                        0000, 0120, 0011,
                        0000, 0900, 000F,
                        0000, 0500, 0011,
                        0000, 0140, 000B,
                        0000, 0100, 000B,
                        0000, 0200, 0025,
                        0000, 0800, 0003,
                        0000, 0010, 0005,
                        0000, 0020, 0007,
                        FFFF
}


;;; $AEDE: Transition table - entry 0C ;;;
{
; 0C: Moving left - gun extended
$91:AEDE             dw 0400, 0000, 0036,
                        0080, 0000, 001A,
                        0000, 0210, 0010,
                        0000, 0220, 0012,
                        0000, 0A00, 0010,
                        0000, 0600, 0012,
                        0000, 0240, 000C,
                        0000, 0200, 000C,
                        0000, 0100, 0026,
                        0000, 0800, 0004,
                        0000, 0010, 0006,
                        0000, 0020, 0008,
                        FFFF
}


;;; $AF28: Transition table - entry 67 ;;;
{
; 67: Facing right - falling - gun extended
$91:AF28             dw 0000, 0900, 006D,
                        0000, 0500, 006F,
                        0000, 0800, 002B,
                        0000, 0400, 002D,
                        0000, 0200, 0087,
                        0000, 0010, 006D,
                        0000, 0020, 006F,
                        0000, 0040, 0067,
                        0000, 0100, 0067,
                        FFFF
}


;;; $AF60: Transition table - entry 68 ;;;
{
; 68: Facing left - falling - gun extended
$91:AF60             dw 0000, 0A00, 006E,
                        0000, 0600, 0070,
                        0000, 0800, 002C,
                        0000, 0400, 002E,
                        0000, 0100, 0088,
                        0000, 0010, 006E,
                        0000, 0020, 0070,
                        0000, 0040, 0068,
                        0000, 0200, 0068,
                        FFFF
}


;;; $AF98: Transition table - entry BF ;;;
{
; BF: Facing right - moonwalking - turn/jump left
$91:AF98             dw 0000, 0280, 001A,
                        0080, 0000, 004C,
                        0000, 0200, 00BF,
                        FFFF
}


;;; $AFAC: Transition table - entry C0 ;;;
{
; C0: Facing left - moonwalking - turn/jump right
$91:AFAC             dw 0000, 0180, 0019,
                        0080, 0000, 004B,
                        0000, 0100, 00C0,
                        FFFF
}


;;; $AFC0: Transition table - entry C1 ;;;
{
; C1: Facing right - moonwalking - turn/jump left - aiming up-right
$91:AFC0             dw 0080, 0200, 001A,
                        0080, 0000, 004C,
                        0000, 0200, 00C1,
                        FFFF
}


;;; $AFD4: Transition table - entry C2 ;;;
{
; C2: Facing left - moonwalking - turn/jump right - aiming up-left
$91:AFD4             dw 0080, 0100, 0019,
                        0080, 0000, 004B,
                        0000, 0100, 00C2,
                        FFFF
}


;;; $AFE8: Transition table - entry C3 ;;;
{
; C3: Facing right - moonwalking - turn/jump left - aiming down-right
$91:AFE8             dw 0080, 0200, 001A,
                        0080, 0000, 004C,
                        0000, 0200, 00C3,
                        FFFF
}


;;; $AFFC: Transition table - entry C4 ;;;
{
; C4: Facing left - moonwalking - turn/jump right - aiming down-left
$91:AFFC             dw 0080, 0100, 0019,
                        0080, 0000, 004B,
                        0000, 0100, 00C4,
                        FFFF
}
}


;;; $B010: Animation delay table ;;;
{
; Indexed by [Samus pose] * 2
$91:B010             dw B56F, B298, B298, B222, B222, B2B4, B2B4, B2B4, B2B4, B20A, B20A, B20A, B20A, B20A, B20A, B20A,
                        B20A, B20A, B20A, B346, B346, B33A, B33A, B33E, B33E, B384, B384, B391, B391, B378, B378, B378,
                        B378, B378, B378, B378, B378, B3BB, B3C0, B2A3, B2A3, B34A, B34A, B35C, B35C, B366, B366, B3C5,
                        B3CA, B378, B378, B378, B378, B4C2, B4C5, B4C8, B4D1, B4DA, B4DD, B4E0, B4E3, B4E6, B4EA, B4EE,
                        B4F4, B378, B378, B3CF, B3D4, B20A, B20A, B2B4, B2B4, B226, B226, B308, B30B, B326, B326, B32E,
                        B32E, B342, B342, B36A, B36A, B30E, B312, B316, B31A, B31E, B322, B378, B378, B378, B378, B378,
                        B378, B378, B378, B47E, B482, B486, B486, B353, B353, B346, B346, B346, B346, B361, B361, B361,
                        B361, B2B4, B2B4, B2B4, B2B4, B226, B226, B226, B226, B378, B378, B378, B378, B378, B378, B378,
                        B378, B39E, B39E, B491, B491, B222, B222, B3D9, B3DE, B2B4, B2B4, B3E3, B3E8, B3ED, B3F2, B3F7,
                        B3FC, B401, B406, B40B, B410, B415, B41A, B41F, B424, B429, B42E, B56F, B433, B438, B43D, B442,
                        B447, B44C, B451, B456, B22D, B231, B235, B23A, B2B6, B2B6, B2B6, B2B6, B2B8, B2B8, B2BC, B2BC,
                        B2C0, B2C0, B2C4, B2C4, B2B4, B2B4, B2B4, B2B4, B2B4, B2B4, B2B4, B2B4, B2B4, B2B4, B53C, B45B,
                        B460, B465, B46A, B46F, B474, B378, B479, B326, B326, B543, B543, B543, B543, B543, B543, B2B4,
                        B2B4, B2B4, B2B4, B545, B556, B2AE, B2AE, B567, B567, B2AE, B2AE, B4FA, B504, B50E, B513, B378,
                        B23F, B243, B247, B24B, B24F, B253, B22D, B231, B257, B268, B288, B290, B2B4, B2B4, B2B4, B2B4,
                        B53C, B518, B51B, B51E, B521, B524, B527, B52A, B52D, B530, B533, B536, B539

; Positive values are animation delay durations, negative values are instructions (first nybble ignored):
;     F6:                  Go to beginning if [Samus health] >= 30
;     F7:                  Set drained Samus movement handler
;     F8 pp:               Enable auto-jump hack and transition to pose p if not jumping
;     F9 eeee gg aa GG AA: Transition to pose G/A if item e equipped, otherwise g/a, and to pose g/G if Y speed = 0, otherwise a/A
;     FA gg aa:            Transition to pose g if Y speed = 0, otherwise a
;     FB:                  Select animation delay sequence for wall-jump
;     FC eeee pp PP:       Transition to pose P if item e equipped, otherwise p
;     FD pp:               Transition to pose p
;     FE nn:               Go back n bytes
;     FF:                  Go to beginning

; 9: Moving right - not aiming
; Ah: Moving left  - not aiming
; Bh: Moving right - gun extended
; Ch: Moving left  - gun extended
; Dh: Moving right - aiming up (unused)
; Eh: Moving left  - aiming up (unused)
; Fh: Moving right - aiming up-right
; 10h: Moving left  - aiming up-left
; 11h: Moving right - aiming down-right
; 12h: Moving left  - aiming down-left
; 45h: Unused
; 46h: Unused
$91:B20A             db 02, 03, 02, 03, 02, 03, 02, 03, 02, 03, FF

; Unused. Not a subanimation of the above, just looks like a slower version
$91:B215             db 04, 04, 04, 04, 04, 04, 03, 04, 04, 03, FF,
                        0A, FF

; 3: Facing right - aiming up
; 4: Facing left  - aiming up
; 85h: Facing right - crouching - aiming up
; 86h: Facing left  - crouching - aiming up
$91:B222             db 02,
                        10, FE,01

; 49h: Facing left  - moonwalk
; 4Ah: Facing right - moonwalk
; 75h: Facing left  - moonwalk - aiming up-left
; 76h: Facing right - moonwalk - aiming up-right
; 77h: Facing left  - moonwalk - aiming down-left
; 78h: Facing right - moonwalk - aiming down-right
$91:B226             db 10, 10, 10, 10, 10, 10, FF

; A4h: Facing right - landing from normal jump
; E6h: Facing right - landing from normal jump - firing
$91:B22D             db 05, 02, F8,01

; A5h: Facing left  - landing from normal jump
; E7h: Facing left  - landing from normal jump - firing
$91:B231             db 05, 02, F8,02

; A6h: Facing right - landing from spin jump
$91:B235             db 03, 05, 02, F8,01

; A7h: Facing left  - landing from spin jump
$91:B23A             db 03, 05, 02, F8,02

; E0h: Facing right - landing from normal jump - aiming up
$91:B23F             db 05, 02, F8,03

; E1h: Facing left  - landing from normal jump - aiming up
$91:B243             db 05, 02, F8,04

; E2h: Facing right - landing from normal jump - aiming up-right
$91:B247             db 05, 02, F8,05

; E3h: Facing left  - landing from normal jump - aiming up-left
$91:B24B             db 05, 02, F8,06

; E4h: Facing right - landing from normal jump - aiming down-right
$91:B24F             db 05, 02, F8,07

; E5h: Facing left  - landing from normal jump - aiming down-left
$91:B253             db 05, 02, F8,08

; E8h: Facing right - Samus drained - crouching/falling
$91:B257             db 02, 02, 02, 10, F7,
                        01, FE,01,
                        10, 10, 10, 10, FE,04,
                        03, FD,01

; E9h: Facing left  - Samus drained - crouching/falling
                        ; Falling
$91:B268             db 02, 02, 10, F7,
                        01, FE,01,
                        
                        ; Crouching
                        08,
                        10, 10, 10, 10, FE,04,

                        ; Samus is let up
                        10, 10, 10, FD,02,

                        ; Samus fails to stand up
                        10, 10, 10, 10, 10, FE,0E,

                        ; Samus gets hit
                        10, FE,11,

                        ; Samus is frozen (receiving hyper beam)
                        10, FE,01

; EAh: Facing right - Samus drained - standing
$91:B288             db 10, 10, 10, 10, FF,

                        ; Samus is let up
                        03, FD,01

; EBh: Facing left  - Samus drained - standing
$91:B290             db 10, 10, 10, 10, FF,

                        ; Samus is let up
                        03, FD,02

; 1: Facing right - normal
; 2: Facing left  - normal
$91:B298             db 0A, 0A, 0A, 0A, F6,
                        08, 08, 08, 08, FE,04

; 27h: Facing right - crouching
; 28h: Facing left  - crouching
$91:B2A3             db 0A, 0A, 0A, 0A, F6,
                        08, 08, 08, 08, FE,04

; D5h: Facing right - x-ray - standing
; D6h: Facing left  - x-ray - standing
; D9h: Facing right - x-ray - crouching
; DAh: Facing left  - x-ray - crouching
; These delays don't really take effect, Samus animation frame is set every frame during x-ray
$91:B2AE             db 0F, ; Looking up
                        0F, ; Looking up-forward
                        0F, ; Looking forward
                        0F, ; Looking down-forward
                        0F, ; Looking down
                        FF

; 5: Facing right - aiming up-right
; 6: Facing left  - aiming up-left
; 7: Facing right - aiming down-right
; 8: Facing left  - aiming down-left
; 47h: Unused
; 48h: Unused
; 71h: Facing right - crouching - aiming up-right
; 72h: Facing left  - crouching - aiming up-left
; 73h: Facing right - crouching - aiming down-right
; 74h: Facing left  - crouching - aiming down-left
; 89h: Facing right - ran into a wall
; 8Ah: Facing left  - ran into a wall
; B4h: Facing right - grappling - crouching
; B5h: Facing left  - grappling - crouching
; B6h: Facing right - grappling - crouching - aiming down-right
; B7h: Facing left  - grappling - crouching - aiming down-left
; B8h: Facing left  - grapple wall jump pose
; B9h: Facing right - grapple wall jump pose
; BAh: Facing left  - grabbed by Draygon - not moving - not aiming
; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left
; BCh: Facing left  - grabbed by Draygon - firing
; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left
; CFh: Facing right - ran into a wall - aiming up-right
; D0h: Facing left  - ran into a wall - aiming up-left
; D1h: Facing right - ran into a wall - aiming down-right
; D2h: Facing left  - ran into a wall - aiming down-left
; ECh: Facing right - grabbed by Draygon - not moving - not aiming
; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
; EEh: Facing right - grabbed by Draygon - firing
; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
$91:B2B4             db 10, FF

; A8h: Facing right - grappling
; A9h: Facing left  - grappling
; AAh: Facing right - grappling - aiming down-right
; ABh: Facing left  - grappling - aiming down-left
$91:B2B6             db 10, FF

; ACh: Unused. Facing right - grappling - in air
; ADh: Unused. Facing left  - grappling - in air
$91:B2B8             db 02,
                        10, FE,01

; AEh: Unused. Facing right - grappling - in air - aiming down
; AFh: Unused. Facing left  - grappling - in air - aiming down
$91:B2BC             db 02,
                        10, FE,01

; B0h: Unused. Facing right - grappling - in air - aiming down-right
; B1h: Unused. Facing left  - grappling - in air - aiming down-left
$91:B2C0             db 02,
                        10, FE,01

; B2h: Facing clockwise     - grapple - in air
; B3h: Facing anticlockwise - grapple - in air
; These delays don't really take effect, Samus animation frame is set every frame during grapple swinging
                        ; Swinging
$91:B2C4             db 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08,

                        ; Kicking
                        08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08, 08,
                        
                        ; Hanging straight down
                        08,
                        08, FE,01

; 4Bh: Facing right - normal jump transition
$91:B308             db 01, FD,4D

; 4Ch: Facing left  - normal jump transition
$91:B30B             db 01, FD,4E

; 55h: Facing right - normal jump transition - aiming up
$91:B30E             db 01, FD,15, 00

; 56h: Facing left  - normal jump transition - aiming up
$91:B312             db 01, FD,16, 00

; 57h: Facing right - normal jump transition - aiming up-right
$91:B316             db 01, FD,69, 00

; 58h: Facing left  - normal jump transition - aiming up-left
$91:B31A             db 01, FD,6A, 00

; 59h: Facing right - normal jump transition - aiming down-right
$91:B31E             db 01, FD,6B, 00

; 5Ah: Facing left  - normal jump transition - aiming down-left
$91:B322             db 01, FD,6C, 00

; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended
; C7h: Facing right - vertical shinespark windup
; C8h: Facing left  - vertical shinespark windup
$91:B326             db 03, 04, 04, 04, 04,
                        50, FE,01

; 4Fh: Facing left  - damage boost
; 50h: Facing right - damage boost
$91:B32E             db 08, 02, 02, 02, 02, 02, 02, 02, 02,
                        02, FE,01

; 15h: Facing right - normal jump - aiming up
; 16h: Facing left  - normal jump - aiming up
$91:B33A             db 02,
                        10, FE,01

; 17h: Facing right - normal jump - aiming down
; 18h: Facing left  - normal jump - aiming down
$91:B33E             db 02,
                        10, FE,01

; 51h: Facing right - normal jump - not aiming - moving forward
; 52h: Facing left  - normal jump - not aiming - moving forward
$91:B342             db 02,
                        03, FE,01

; 13h: Facing right - normal jump - not aiming - not moving - gun extended
; 14h: Facing left  - normal jump - not aiming - not moving - gun extended
; 69h: Facing right - normal jump - aiming up-right
; 6Ah: Facing left  - normal jump - aiming up-left
; 6Bh: Facing right - normal jump - aiming down-right
; 6Ch: Facing left  - normal jump - aiming down-left
$91:B346             db 02,
                        10, FE,01

; 29h: Facing right - falling
; 2Ah: Facing left  - falling
$91:B34A             db 08, 06,
                        06, FE,01,
                        
                        ; Terminal velocity
                        08,
                        10, FE,01

; 67h: Facing right - falling - gun extended
; 68h: Facing left  - falling - gun extended
$91:B353             db 08, 06,
                        06, FE,01,
                        
                        ; Terminal velocity
                        08,
                        10, FE,01

; 2Bh: Facing right - falling - aiming up
; 2Ch: Facing left  - falling - aiming up
$91:B35C             db 02, 10,
                        10, FE,01

; 6Dh: Facing right - falling - aiming up-right
; 6Eh: Facing left  - falling - aiming up-left
; 6Fh: Facing right - falling - aiming down-right
; 70h: Facing left  - falling - aiming down-left
$91:B361             db 02, F0,
                        10, FE,01

; 2Dh: Facing right - falling - aiming down
; 2Eh: Facing left  - falling - aiming down
$91:B366             db 02,
                        10, FE,01

; 53h: Facing right - knockback
; 54h: Facing left  - knockback
$91:B36A             db 02,
                        10, FE,01
                        
; Unused. Not a subanimation of the above
$91:B36E             db 06, 06, 06, 08, FF,
                        08, 08, FF,
                        0A, FF

; 1Dh: Facing right - morph ball - no springball - on ground
; 1Eh: Moving right - morph ball - no springball - on ground
; 1Fh: Moving left  - morph ball - no springball - on ground
; 20h: Unused
; 21h: Unused
; 22h: Unused
; 23h: Unused
; 24h: Unused
; 31h: Facing right - morph ball - no springball - in air
; 32h: Facing left  - morph ball - no springball - in air
; 33h: Unused
; 34h: Unused
; 41h: Facing left  - morph ball - no springball - on ground
; 42h: Unused
; 5Bh: Unused
; 5Ch: Unused
; 5Dh: Unused
; 5Eh: Unused
; 5Fh: Unused
; 60h: Unused
; 61h: Unused
; 62h: Unused
; 79h: Facing right - morph ball - spring ball - on ground
; 7Ah: Facing left  - morph ball - spring ball - on ground
; 7Bh: Moving right - morph ball - spring ball - on ground
; 7Ch: Moving left  - morph ball - spring ball - on ground
; 7Dh: Facing right - morph ball - spring ball - falling
; 7Eh: Facing left  - morph ball - spring ball - falling
; 7Fh: Facing right - morph ball - spring ball - in air
; 80h: Facing left  - morph ball - spring ball - in air
; C5h: Unused
; DFh: Unused. Related to Draygon
$91:B378             db 03, 03, 03, 03, 03, 03, 03, 03, FF,

                        ; Unused. Squished morph ball
                        03, FE,0A

; 19h: Facing right - spin jump
; 1Ah: Facing left  - spin jump
$91:B384             db 04,
                        03, 02, 03, 02, 03, 02, 03, 02, FE,08,
                        
                        ; Wall jump eligible
                        08, FF

; 1Bh: Facing right - space jump
; 1Ch: Facing left  - space jump
$91:B391             db 04,
                        01, 01, 01, 01, 01, 01, 01, 01, FE,08,
                        
                        ; Wall jump eligible
                        08, FF

; 81h: Facing right - screw attack
; 82h: Facing left  - screw attack
$91:B39E             db 04,
                        01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, FE,18,
                        
                        ; Wall jump eligible
                        08, FF

; 25h: Facing right - turning - standing
$91:B3BB             db 02, 02, 02, F8,02

; 26h: Facing left  - turning - standing
$91:B3C0             db 02, 02, 02, F8,01

; 2Fh: Facing right - turning - jumping
$91:B3C5             db 02, 02, 02, F8,52

; 30h: Facing left  - turning - jumping
$91:B3CA             db 02, 02, 02, F8,51

; 43h: Facing right - turning - crouching
$91:B3CF             db 02, 02, 02, F8,28

; 44h: Facing left  - turning - crouching
$91:B3D4             db 02, 02, 02, F8,27

; 87h: Facing right - turning - falling
$91:B3D9             db 02, 02, 02, F8,2A

; 88h: Facing left  - turning - falling
$91:B3DE             db 02, 02, 02, F8,29

; 8Bh: Facing right - turning - standing - aiming up
$91:B3E3             db 02, 02, 02, F8,04

; 8Ch: Facing left  - turning - standing - aiming up
$91:B3E8             db 02, 02, 02, F8,03

; 8Dh: Facing right - turning - standing - aiming down-right
$91:B3ED             db 02, 02, 02, F8,08

; 8Eh: Facing left  - turning - standing - aiming down-left
$91:B3F2             db 02, 02, 02, F8,07

; 8Fh: Facing right - turning - in air - aiming up
$91:B3F7             db 02, 02, 02, F8,16

; 90h: Facing left  - turning - in air - aiming up
$91:B3FC             db 02, 02, 02, F8,15

; 91h: Facing right - turning - in air - aiming down/down-right
$91:B401             db 02, 02, 02, F8,18

; 92h: Facing left  - turning - in air - aiming down/down-left
$91:B406             db 02, 02, 02, F8,17

; 93h: Facing right - turning - falling - aiming up
$91:B40B             db 02, 02, 02, F8,2C

; 94h: Facing left  - turning - falling - aiming up
$91:B410             db 02, 02, 02, F8,2B

; 95h: Facing right - turning - falling - aiming down/down-right
$91:B415             db 02, 02, 02, F8,2E

; 96h: Facing left  - turning - falling - aiming down/down-left
$91:B41A             db 02, 02, 02, F8,2D

; 97h: Facing right - turning - crouching - aiming up
$91:B41F             db 02, 02, 02, F8,86

; 98h: Facing left  - turning - crouching - aiming up
$91:B424             db 02, 02, 02, F8,85

; 99h: Facing right - turning - crouching - aiming down/down-right
$91:B429             db 02, 02, 02, F8,74

; 9Ah: Facing left  - turning - crouching - aiming down/down-left
$91:B42E             db 02, 02, 02, F8,73

; 9Ch: Facing right - turning - standing - aiming up-right
$91:B433             db 02, 02, 02, F8,06

; 9Dh: Facing left  - turning - standing - aiming up-left
$91:B438             db 02, 02, 02, F8,05

; 9Eh: Facing right - turning - in air - aiming up-right
$91:B43D             db 02, 02, 02, F8,6A

; 9Fh: Facing left  - turning - in air - aiming up-left
$91:B442             db 02, 02, 02, F8,69

; A0h: Facing right - turning - falling - aiming up-right
$91:B447             db 02, 02, 02, F8,6E

; A1h: Facing left  - turning - falling - aiming up-left
$91:B44C             db 02, 02, 02, F8,6D

; A2h: Facing right - turning - crouching - aiming up-right
$91:B451             db 02, 02, 02, F8,72

; A3h: Facing left  - turning - crouching - aiming up-left
$91:B456             db 02, 02, 02, F8,71

; BFh: Facing right - moonwalking - turn/jump left
$91:B45B             db 02, 02, 02, F8,1A

; C0h: Facing left  - moonwalking - turn/jump right
$91:B460             db 02, 02, 02, F8,19

; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right
$91:B465             db 02, 02, 02, F8,1A

; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left
$91:B46A             db 02, 02, 02, F8,19

; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right
$91:B46F             db 02, 02, 02, F8,1A

; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left
$91:B474             db 02, 02, 02, F8,19

; C6h: Unused
$91:B479             db 02, 02, 02, FD,BA

; 63h: Unused
$91:B47E             db 04,
                        03, FE,01

; 64h: Unused
$91:B482             db 04,
                        03, FE,01

; 65h: Unused. Related to movement type Dh
; 66h: Unused. Related to movement type Dh
$91:B486             db 03,
                        02, 02, 02, 02, 02, 02, 02, 02, FE,08

; 83h: Facing right - wall jump
; 84h: Facing left  - wall jump
                        ; Wall jump start-up
$91:B491             db 05, 05, FB,

                        ; Normal
                        03, 02, 03, 02, 03, 02, 03, 02, FE,08,
                        
                        ; Space jump
                        02, 01, 02, 01, 02, 01, 02, 01, FE,08,
                        
                        ; Screw attack
                        01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, FE,18

; 35h: Facing right - crouching transition
$91:B4C2             db 03, FD,27

; 36h: Facing left  - crouching transition
$91:B4C5             db 03, FD,28

; 37h: Facing right - morphing transition
$91:B4C8             dx 03, 03, F9,0002,1D,31,79,7D

; 38h: Facing left  - morphing transition
$91:B4D1             dx 03, 03, F9,0002,41,32,7A,7E

; 39h: Unused
$91:B4DA             db 00, FD,20

; 3Ah: Unused
$91:B4DD             db 00, FD,42

; 3Bh: Facing right - standing transition
$91:B4E0             db 03, FD,01

; 3Ch: Facing left  - standing transition
$91:B4E3             db 03, FD,02

; 3Dh: Facing right - unmorphing transition
$91:B4E6             db 03, 03, FD,27

; 3Eh: Facing left  - unmorphing transition
$91:B4EA             db 03, 03, FD,28

; 3Fh: Unused
$91:B4EE             dx 00, FC,0002,1D,79

; 40h: Unused
$91:B4F4             dx 00, FC,0002,41,7A

; DBh: Unused
$91:B4FA             dx 03, 03, 03, F9,0002,1D,31,79,7D

; DCh: Unused
$91:B504             dx 03, 03, 03, F9,0002,DF,DF,DF,DF

; DDh: Unused
$91:B50E             db 03, 03, 03, FD,01

; DEh: Unused
$91:B513             db 03, 03, 03, FD,BA

; F1h: Facing right - crouching transition - aiming up
$91:B518             db 03, FD,85

; F2h: Facing left  - crouching transition - aiming up
$91:B51B             db 03, FD,86

; F3h: Facing right - crouching transition - aiming up-right
$91:B51E             db 03, FD,71

; F4h: Facing left  - crouching transition - aiming up-left
$91:B521             db 03, FD,72

; F5h: Facing right - crouching transition - aiming down-right
$91:B524             db 03, FD,73

; F6h: Facing left  - crouching transition - aiming down-left
$91:B527             db 03, FD,74

; F7h: Facing right - standing transition - aiming up
$91:B52A             db 03, FD,03

; F8h: Facing left  - standing transition - aiming up
$91:B52D             db 03, FD,04

; F9h: Facing right - standing transition - aiming up-right
$91:B530             db 03, FD,05

; FAh: Facing left  - standing transition - aiming up-left
$91:B533             db 03, FD,06

; FBh: Facing right - standing transition - aiming down-right
$91:B536             db 03, FD,07

; FCh: Facing left  - standing transition - aiming down-left
$91:B539             db 03, FD,08

; BEh: Facing left  - grabbed by Draygon - moving
; F0h: Facing right - grabbed by Draygon - moving
$91:B53C             db 06, 06, 06, 06, 06, 06, FF

; C9h: Facing right - shinespark - horizontal
; CAh: Facing left  - shinespark - horizontal
; CBh: Facing right - shinespark - vertical
; CCh: Facing left  - shinespark - vertical
; CDh: Facing right - shinespark - diagonal
; CEh: Facing left  - shinespark - diagonal
$91:B543             db 08, FF

; D3h: Facing right - crystal flash
                        ; Raise Samus and generate bubble
$91:B545             db 03, 03,
                        01, 01, FE,02,
                        
                        ; Main
                        0C, 0C, 0C, 0C, FE,04,
                        
                        ; Finish
                        03, 03, 03, FD,01

; D4h: Facing left  - crystal flash
                        ; Raise Samus and generate bubble
$91:B556             db 03, 03,
                        01, 01, FE,02,
                        
                        ; Main
                        0C, 0C, 0C, 0C, FE,04,
                        
                        ; Finish
                        03, 03, 03, FD,02

; D7h: Facing right - crystal flash ending
; D8h: Facing left  - crystal flash ending
                        ; Transition from morphed
$91:B567             db 02, 02, 02, 02, 02,

                        ; Unmorphed
                        02, FE,01

; 0: Facing forward - power suit
; 9Bh: Facing forward - varia/gravity suit
$91:B56F             db 08, FF,

                        ; Samus appears (with save station electricity)
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03,
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03,
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03,
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03,
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, 03,
                        03, 03, 03, 03, 03, 03, 03, 03, 03, 33, 02, 02, 02,
                        30, FE,01
}


;;; $B5D1: Animation delay table - running - speed booster not equipped ;;;
{
$91:B5D1             dw B5D3

$91:B5D3             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, FF
}


;;; $B5DE: Animation delay table - running - speed booster equipped ;;;
{
; Indexed by [speed boost counter] * 2
$91:B5DE             dw B5E8, B5F3, B5FE, B609, B614

$91:B5E8             db 03, 03, 03, 03, 03, 03, 03, 03, 03, 03, FF ; Unused, except for the first speed boosting animation cycle sometimes due to a bug (see $90:852C)
$91:B5F3             db 02, 03, 02, 03, 02, 03, 02, 03, 02, 03, FF ; Speed booster stage 1 (after the first run button check)
$91:B5FE             db 02, 02, 02, 02, 02, 02, 02, 02, 02, 02, FF ; Speed booster stage 2
$91:B609             db 01, 02, 01, 02, 01, 02, 01, 02, 01, 02, FF ; Speed booster stage 3
$91:B614             db 01, 01, 01, 01, 01, 01, 01, 01, 01, 01, FF ; Speed boosting (after the first speed boosting animation cycle)
}


;;; $B61F: Speed boost timer reset values ;;;
{
; Indexed by [speed boost counter] * 2
$91:B61F             dw 0001, 0001, 0001, 0001, 0002
}


;;; $B629: Pose definitions ;;;
{
;                        ______________________ $B629: Pose X direction
;                       |   ___________________ $B62A: Movement type
;                       |  |   ________________ $B62B: New pose if not affected by buttons
;                       |  |  |   _____________ $B62C: Direction shots are fired. High nybble set means can't fire and grapple beam is cancelled
;                       |  |  |  |   __________ $B62D: Y offset of Samus GFX and projectile origin (but not Samus hitbox)
;                       |  |  |  |  |   _______ $B62E: Unused
;                       |  |  |  |  |  |   ____ $B62F: Y radius
;                       |  |  |  |  |  |  |   _ $B630: Unused
;                       |  |  |  |  |  |  |  |
$91:B629             db 00,00,FF,FF,08,00,18,00 ; 0: Facing forward - power suit
$91:B631             db 08,00,FF,02,06,00,15,00 ; 1: Facing right - normal
$91:B639             db 04,00,FF,07,06,00,15,00 ; 2: Facing left  - normal
$91:B641             db 08,00,01,00,06,00,15,00 ; 3: Facing right - aiming up
$91:B649             db 04,00,02,09,06,00,15,00 ; 4: Facing left  - aiming up
$91:B651             db 08,00,01,01,06,00,15,00 ; 5: Facing right - aiming up-right
$91:B659             db 04,00,02,08,06,00,15,00 ; 6: Facing left  - aiming up-left
$91:B661             db 08,00,01,03,06,00,15,00 ; 7: Facing right - aiming down-right
$91:B669             db 04,00,02,06,06,00,15,00 ; 8: Facing left  - aiming down-left
$91:B671             db 08,01,01,02,06,00,15,00 ; 9: Moving right - not aiming
$91:B679             db 04,01,02,07,06,00,15,00 ; Ah: Moving left  - not aiming
$91:B681             db 08,01,01,02,06,00,15,00 ; Bh: Moving right - gun extended
$91:B689             db 04,01,02,07,06,00,15,00 ; Ch: Moving left  - gun extended
$91:B691             db 08,01,01,00,06,00,15,00 ; Dh: Moving right - aiming up (unused)
$91:B699             db 04,01,02,09,06,00,15,00 ; Eh: Moving left  - aiming up (unused)
$91:B6A1             db 08,01,01,01,06,00,15,00 ; Fh: Moving right - aiming up-right
$91:B6A9             db 04,01,02,08,06,00,15,00 ; 10h: Moving left  - aiming up-left
$91:B6B1             db 08,01,01,03,06,00,15,00 ; 11h: Moving right - aiming down-right
$91:B6B9             db 04,01,02,06,06,00,15,00 ; 12h: Moving left  - aiming down-left
$91:B6C1             db 08,02,FF,02,08,00,13,00 ; 13h: Facing right - normal jump - not aiming - not moving - gun extended
$91:B6C9             db 04,02,FF,07,08,00,13,00 ; 14h: Facing left  - normal jump - not aiming - not moving - gun extended
$91:B6D1             db 08,02,51,00,08,00,13,00 ; 15h: Facing right - normal jump - aiming up
$91:B6D9             db 04,02,52,09,08,00,13,00 ; 16h: Facing left  - normal jump - aiming up
$91:B6E1             db 08,02,FF,04,06,00,0A,00 ; 17h: Facing right - normal jump - aiming down
$91:B6E9             db 04,02,FF,05,06,00,0A,00 ; 18h: Facing left  - normal jump - aiming down
$91:B6F1             db 08,03,FF,FF,00,00,0C,00 ; 19h: Facing right - spin jump
$91:B6F9             db 04,03,FF,FF,00,00,0C,00 ; 1Ah: Facing left  - spin jump
$91:B701             db 08,03,FF,FF,00,00,0C,00 ; 1Bh: Facing right - space jump
$91:B709             db 04,03,FF,FF,00,00,0C,00 ; 1Ch: Facing left  - space jump
$91:B711             db 08,04,FF,FF,00,00,07,00 ; 1Dh: Facing right - morph ball - no springball - on ground
$91:B719             db 08,04,1D,FF,00,00,07,00 ; 1Eh: Moving right - morph ball - no springball - on ground
$91:B721             db 04,04,41,FF,00,00,07,00 ; 1Fh: Moving left  - morph ball - no springball - on ground
$91:B729             db 08,07,FF,FF,00,00,07,00 ; 20h: Unused
$91:B731             db 01,07,20,FF,00,00,07,00 ; 21h: Unused
$91:B739             db 02,07,20,FF,00,00,07,00 ; 22h: Unused
$91:B741             db 04,07,42,FF,00,00,07,00 ; 23h: Unused
$91:B749             db 08,07,20,FF,00,00,07,00 ; 24h: Unused
$91:B751             db 04,0E,FF,FB,06,00,15,00 ; 25h: Facing right - turning - standing
$91:B759             db 08,0E,FF,FB,06,00,15,00 ; 26h: Facing left  - turning - standing
$91:B761             db 08,05,27,02,00,00,10,00 ; 27h: Facing right - crouching
$91:B769             db 04,05,28,07,00,00,10,00 ; 28h: Facing left  - crouching
$91:B771             db 08,06,FF,02,08,00,13,00 ; 29h: Facing right - falling
$91:B779             db 04,06,FF,07,08,00,13,00 ; 2Ah: Facing left  - falling
$91:B781             db 08,06,29,00,08,00,13,00 ; 2Bh: Facing right - falling - aiming up
$91:B789             db 04,06,2A,09,08,00,13,00 ; 2Ch: Facing left  - falling - aiming up
$91:B791             db 08,06,FF,04,06,00,0A,00 ; 2Dh: Facing right - falling - aiming down
$91:B799             db 04,06,FF,05,06,00,0A,00 ; 2Eh: Facing left  - falling - aiming down
$91:B7A1             db 04,17,FF,FB,08,00,13,00 ; 2Fh: Facing right - turning - jumping
$91:B7A9             db 08,17,FF,FB,08,00,13,00 ; 30h: Facing left  - turning - jumping
$91:B7B1             db 08,08,FF,FF,00,00,07,00 ; 31h: Facing right - morph ball - no springball - in air
$91:B7B9             db 04,08,FF,FF,00,00,07,00 ; 32h: Facing left  - morph ball - no springball - in air
$91:B7C1             db 08,09,FF,FF,00,00,07,00 ; 33h: Unused
$91:B7C9             db 04,09,FF,FF,00,00,07,00 ; 34h: Unused
$91:B7D1             db 08,0F,FF,02,00,00,10,00 ; 35h: Facing right - crouching transition
$91:B7D9             db 04,0F,FF,07,00,00,10,00 ; 36h: Facing left  - crouching transition
$91:B7E1             db 08,0F,FF,FF,00,00,07,00 ; 37h: Facing right - morphing transition
$91:B7E9             db 04,0F,FF,FF,00,00,07,00 ; 38h: Facing left  - morphing transition
$91:B7F1             db 08,0F,FF,FF,00,00,07,00 ; 39h: Unused
$91:B7F9             db 04,0F,FF,FF,00,00,07,00 ; 3Ah: Unused
$91:B801             db 08,0F,FF,02,06,00,15,00 ; 3Bh: Facing right - standing transition
$91:B809             db 04,0F,FF,07,06,00,15,00 ; 3Ch: Facing left  - standing transition
$91:B811             db 08,0F,FF,FF,00,00,10,00 ; 3Dh: Facing right - unmorphing transition
$91:B819             db 04,0F,FF,FF,00,00,10,00 ; 3Eh: Facing left  - unmorphing transition
$91:B821             db 08,0F,FF,FF,00,00,07,00 ; 3Fh: Unused
$91:B829             db 04,0F,FF,FF,00,00,07,00 ; 40h: Unused
$91:B831             db 04,04,FF,FF,00,00,07,00 ; 41h: Facing left  - morph ball - no springball - on ground
$91:B839             db 04,07,FF,FF,00,00,07,00 ; 42h: Unused
$91:B841             db 04,0E,FF,FB,00,00,10,00 ; 43h: Facing right - turning - crouching
$91:B849             db 08,0E,FF,FB,00,00,10,00 ; 44h: Facing left  - turning - crouching
$91:B851             db 08,01,01,07,06,00,15,00 ; 45h: Unused
$91:B859             db 04,01,02,02,06,00,15,00 ; 46h: Unused
$91:B861             db 08,00,FF,02,06,00,15,00 ; 47h: Unused
$91:B869             db 04,00,FF,07,06,00,15,00 ; 48h: Unused
$91:B871             db 08,10,02,07,06,00,15,00 ; 49h: Facing left  - moonwalk
$91:B879             db 04,10,01,02,06,00,15,00 ; 4Ah: Facing right - moonwalk
$91:B881             db 08,02,FF,02,03,00,13,00 ; 4Bh: Facing right - normal jump transition
$91:B889             db 04,02,FF,07,03,00,13,00 ; 4Ch: Facing left  - normal jump transition
$91:B891             db 08,02,FF,02,08,00,13,00 ; 4Dh: Facing right - normal jump - not aiming - not moving - gun not extended
$91:B899             db 04,02,FF,07,08,00,13,00 ; 4Eh: Facing left  - normal jump - not aiming - not moving - gun not extended
$91:B8A1             db 08,19,4E,FF,08,00,13,00 ; 4Fh: Facing left  - damage boost
$91:B8A9             db 04,19,4D,FF,08,00,13,00 ; 50h: Facing right - damage boost
$91:B8B1             db 08,02,FF,02,08,00,13,00 ; 51h: Facing right - normal jump - not aiming - moving forward
$91:B8B9             db 04,02,FF,07,08,00,13,00 ; 52h: Facing left  - normal jump - not aiming - moving forward
$91:B8C1             db 08,0A,FF,FF,06,00,15,00 ; 53h: Facing right - knockback
$91:B8C9             db 04,0A,FF,FF,06,00,15,00 ; 54h: Facing left  - knockback
$91:B8D1             db 08,02,FF,00,03,00,13,00 ; 55h: Facing right - normal jump transition - aiming up
$91:B8D9             db 04,02,FF,09,03,00,13,00 ; 56h: Facing left  - normal jump transition - aiming up
$91:B8E1             db 08,02,FF,01,03,00,13,00 ; 57h: Facing right - normal jump transition - aiming up-right
$91:B8E9             db 04,02,FF,08,03,00,13,00 ; 58h: Facing left  - normal jump transition - aiming up-left
$91:B8F1             db 08,02,FF,03,03,00,13,00 ; 59h: Facing right - normal jump transition - aiming down-right
$91:B8F9             db 04,02,FF,06,03,00,13,00 ; 5Ah: Facing left  - normal jump transition - aiming down-left
$91:B901             db 08,16,FF,FF,10,00,10,00 ; 5Bh: Unused
$91:B909             db 04,16,FF,FF,10,00,10,00 ; 5Ch: Unused
$91:B911             db 08,0B,5D,FF,10,00,10,00 ; 5Dh: Unused
$91:B919             db 04,0B,5E,FF,10,00,10,00 ; 5Eh: Unused
$91:B921             db 08,0B,5F,FF,10,00,10,00 ; 5Fh: Unused
$91:B929             db 04,0B,60,FF,10,00,10,00 ; 60h: Unused
$91:B931             db 08,16,B2,FF,10,00,10,00 ; 61h: Unused
$91:B939             db 04,16,B3,FF,10,00,10,00 ; 62h: Unused
$91:B941             db 08,0D,FF,FF,0C,00,0C,00 ; 63h: Unused
$91:B949             db 04,0D,FF,FF,0C,00,0C,00 ; 64h: Unused
$91:B951             db 08,0D,29,FF,0C,00,0C,00 ; 65h: Unused
$91:B959             db 04,0D,2A,FF,0C,00,0C,00 ; 66h: Unused
$91:B961             db 08,06,FF,02,08,00,13,00 ; 67h: Facing right - falling - gun extended
$91:B969             db 04,06,FF,07,08,00,13,00 ; 68h: Facing left  - falling - gun extended
$91:B971             db 08,02,51,01,08,00,13,00 ; 69h: Facing right - normal jump - aiming up-right
$91:B979             db 04,02,52,08,08,00,13,00 ; 6Ah: Facing left  - normal jump - aiming up-left
$91:B981             db 08,02,51,03,08,00,13,00 ; 6Bh: Facing right - normal jump - aiming down-right
$91:B989             db 04,02,52,06,08,00,13,00 ; 6Ch: Facing left  - normal jump - aiming down-left
$91:B991             db 08,06,29,01,08,00,13,00 ; 6Dh: Facing right - falling - aiming up-right
$91:B999             db 04,06,2A,08,08,00,13,00 ; 6Eh: Facing left  - falling - aiming up-left
$91:B9A1             db 08,06,29,03,08,00,13,00 ; 6Fh: Facing right - falling - aiming down-right
$91:B9A9             db 04,06,2A,06,08,00,13,00 ; 70h: Facing left  - falling - aiming down-left
$91:B9B1             db 08,05,27,01,00,00,10,00 ; 71h: Facing right - crouching - aiming up-right
$91:B9B9             db 04,05,28,08,00,00,10,00 ; 72h: Facing left  - crouching - aiming up-left
$91:B9C1             db 08,05,27,03,00,00,10,00 ; 73h: Facing right - crouching - aiming down-right
$91:B9C9             db 04,05,28,06,00,00,10,00 ; 74h: Facing left  - crouching - aiming down-left
$91:B9D1             db 08,10,06,08,06,00,15,00 ; 75h: Facing left  - moonwalk - aiming up-left
$91:B9D9             db 04,10,05,01,06,00,15,00 ; 76h: Facing right - moonwalk - aiming up-right
$91:B9E1             db 08,10,08,06,06,00,15,00 ; 77h: Facing left  - moonwalk - aiming down-left
$91:B9E9             db 04,10,07,03,06,00,15,00 ; 78h: Facing right - moonwalk - aiming down-right
$91:B9F1             db 08,11,FF,FF,00,00,07,00 ; 79h: Facing right - morph ball - spring ball - on ground
$91:B9F9             db 04,11,FF,FF,00,00,07,00 ; 7Ah: Facing left  - morph ball - spring ball - on ground
$91:BA01             db 08,11,79,FF,00,00,07,00 ; 7Bh: Moving right - morph ball - spring ball - on ground
$91:BA09             db 04,11,7A,FF,00,00,07,00 ; 7Ch: Moving left  - morph ball - spring ball - on ground
$91:BA11             db 08,13,FF,FF,00,00,07,00 ; 7Dh: Facing right - morph ball - spring ball - falling
$91:BA19             db 04,13,FF,FF,00,00,07,00 ; 7Eh: Facing left  - morph ball - spring ball - falling
$91:BA21             db 08,12,FF,FF,00,00,07,00 ; 7Fh: Facing right - morph ball - spring ball - in air
$91:BA29             db 04,12,FF,FF,00,00,07,00 ; 80h: Facing left  - morph ball - spring ball - in air
$91:BA31             db 08,03,FF,FF,00,00,0C,00 ; 81h: Facing right - screw attack
$91:BA39             db 04,03,FF,FF,00,00,0C,00 ; 82h: Facing left  - screw attack
$91:BA41             db 08,14,19,FF,08,00,13,00 ; 83h: Facing right - wall jump
$91:BA49             db 04,14,1A,FF,08,00,13,00 ; 84h: Facing left  - wall jump
$91:BA51             db 08,05,27,00,00,00,10,00 ; 85h: Facing right - crouching - aiming up
$91:BA59             db 04,05,28,09,00,00,10,00 ; 86h: Facing left  - crouching - aiming up
$91:BA61             db 04,18,FF,FB,08,00,13,00 ; 87h: Facing right - turning - falling
$91:BA69             db 08,18,FF,FB,08,00,13,00 ; 88h: Facing left  - turning - falling
$91:BA71             db 08,15,FF,02,06,00,15,00 ; 89h: Facing right - ran into a wall
$91:BA79             db 04,15,FF,07,06,00,15,00 ; 8Ah: Facing left  - ran into a wall
$91:BA81             db 04,0E,FF,FA,06,00,15,00 ; 8Bh: Facing right - turning - standing - aiming up
$91:BA89             db 08,0E,FF,FA,06,00,15,00 ; 8Ch: Facing left  - turning - standing - aiming up
$91:BA91             db 04,0E,FF,FC,06,00,15,00 ; 8Dh: Facing right - turning - standing - aiming down-right
$91:BA99             db 08,0E,FF,FC,06,00,15,00 ; 8Eh: Facing left  - turning - standing - aiming down-left
$91:BAA1             db 04,17,FF,FA,08,00,13,00 ; 8Fh: Facing right - turning - in air - aiming up
$91:BAA9             db 08,17,FF,FA,08,00,13,00 ; 90h: Facing left  - turning - in air - aiming up
$91:BAB1             db 04,17,FF,FC,08,00,13,00 ; 91h: Facing right - turning - in air - aiming down/down-right
$91:BAB9             db 08,17,FF,FC,08,00,13,00 ; 92h: Facing left  - turning - in air - aiming down/down-left
$91:BAC1             db 04,18,FF,FA,08,00,13,00 ; 93h: Facing right - turning - falling - aiming up
$91:BAC9             db 08,18,FF,FA,08,00,13,00 ; 94h: Facing left  - turning - falling - aiming up
$91:BAD1             db 04,18,FF,FC,08,00,13,00 ; 95h: Facing right - turning - falling - aiming down/down-right
$91:BAD9             db 08,18,FF,FC,08,00,13,00 ; 96h: Facing left  - turning - falling - aiming down/down-left
$91:BAE1             db 04,17,28,FA,00,00,10,00 ; 97h: Facing right - turning - crouching - aiming up
$91:BAE9             db 08,17,28,FA,00,00,10,00 ; 98h: Facing left  - turning - crouching - aiming up
$91:BAF1             db 04,17,28,FC,00,00,10,00 ; 99h: Facing right - turning - crouching - aiming down/down-right
$91:BAF9             db 08,17,28,FC,00,00,10,00 ; 9Ah: Facing left  - turning - crouching - aiming down/down-left
$91:BB01             db 00,00,FF,FF,08,00,18,00 ; 9Bh: Facing forward - varia/gravity suit
$91:BB09             db 04,0E,FF,FA,06,00,15,00 ; 9Ch: Facing right - turning - standing - aiming up-right
$91:BB11             db 08,0E,FF,FA,06,00,15,00 ; 9Dh: Facing left  - turning - standing - aiming up-left
$91:BB19             db 04,17,FF,FA,08,00,13,00 ; 9Eh: Facing right - turning - in air - aiming up-right
$91:BB21             db 08,17,FF,FA,08,00,13,00 ; 9Fh: Facing left  - turning - in air - aiming up-left
$91:BB29             db 04,18,FF,FA,08,00,13,00 ; A0h: Facing right - turning - falling - aiming up-right
$91:BB31             db 08,18,FF,FA,08,00,13,00 ; A1h: Facing left  - turning - falling - aiming up-left
$91:BB39             db 04,17,28,FA,00,00,10,00 ; A2h: Facing right - turning - crouching - aiming up-right
$91:BB41             db 08,17,28,FA,00,00,10,00 ; A3h: Facing left  - turning - crouching - aiming up-left
$91:BB49             db 08,00,FF,02,03,00,15,00 ; A4h: Facing right - landing from normal jump
$91:BB51             db 04,00,FF,07,03,00,15,00 ; A5h: Facing left  - landing from normal jump
$91:BB59             db 08,00,FF,02,03,00,15,00 ; A6h: Facing right - landing from spin jump
$91:BB61             db 04,00,FF,07,03,00,15,00 ; A7h: Facing left  - landing from spin jump
$91:BB69             db 08,16,01,02,06,00,15,00 ; A8h: Unused
$91:BB71             db 04,16,02,07,06,00,15,00 ; A9h: Unused
$91:BB79             db 08,16,07,03,06,00,15,00 ; AAh: Unused
$91:BB81             db 04,16,08,06,06,00,15,00 ; ABh: Unused
$91:BB89             db 08,16,67,02,08,00,13,00 ; ACh: Unused
$91:BB91             db 04,16,68,07,08,00,13,00 ; ADh: Unused
$91:BB99             db 08,16,2D,04,06,00,0A,00 ; AEh: Unused
$91:BBA1             db 04,16,2E,05,06,00,0A,00 ; AFh: Unused
$91:BBA9             db 08,16,6F,03,08,00,13,00 ; B0h: Unused
$91:BBB1             db 04,16,70,06,08,00,13,00 ; B1h: Unused
$91:BBB9             db 08,16,B2,FF,10,00,11,00 ; B2h: Facing clockwise     - grapple
$91:BBC1             db 04,16,B3,FF,10,00,11,00 ; B3h: Facing anticlockwise - grapple
$91:BBC9             db 08,16,27,02,00,00,10,00 ; B4h: Unused
$91:BBD1             db 04,16,28,07,00,00,10,00 ; B5h: Unused
$91:BBD9             db 08,16,27,03,00,00,10,00 ; B6h: Unused
$91:BBE1             db 04,16,28,06,00,00,10,00 ; B7h: Unused
$91:BBE9             db 08,16,FF,03,00,00,10,00 ; B8h: Facing left  - grapple wall jump pose
$91:BBF1             db 04,16,FF,06,00,00,10,00 ; B9h: Facing right - grapple wall jump pose
$91:BBF9             db 04,1A,FF,07,06,00,15,00 ; BAh: Facing left  - grabbed by Draygon - not moving - not aiming
$91:BC01             db 04,1A,BA,08,06,00,15,00 ; BBh: Facing left  - grabbed by Draygon - not moving - aiming up-left
$91:BC09             db 04,1A,BA,07,06,00,15,00 ; BCh: Facing left  - grabbed by Draygon - firing
$91:BC11             db 04,1A,BA,06,06,00,15,00 ; BDh: Facing left  - grabbed by Draygon - not moving - aiming down-left
$91:BC19             db 04,1A,BA,FF,06,00,15,00 ; BEh: Facing left  - grabbed by Draygon - moving
$91:BC21             db 04,0E,FF,FB,06,00,15,00 ; BFh: Facing right - moonwalking - turn/jump left
$91:BC29             db 08,0E,FF,FB,06,00,15,00 ; C0h: Facing left  - moonwalking - turn/jump right
$91:BC31             db 04,0E,FF,FA,08,00,15,00 ; C1h: Facing right - moonwalking - turn/jump left  - aiming up-right
$91:BC39             db 08,0E,FF,FA,08,00,15,00 ; C2h: Facing left  - moonwalking - turn/jump right - aiming up-left
$91:BC41             db 04,0E,FF,FC,08,00,15,00 ; C3h: Facing right - moonwalking - turn/jump left  - aiming down-right
$91:BC49             db 08,0E,FF,FC,08,00,15,00 ; C4h: Facing left  - moonwalking - turn/jump right - aiming down-left
$91:BC51             db 04,1A,FF,FF,00,00,07,00 ; C5h: Unused
$91:BC59             db 04,1A,FF,FB,06,00,15,00 ; C6h: Unused
$91:BC61             db 08,1B,FF,FF,08,00,13,00 ; C7h: Facing right - vertical shinespark windup
$91:BC69             db 04,1B,FF,FF,08,00,13,00 ; C8h: Facing left  - vertical shinespark windup
$91:BC71             db 08,1B,FF,02,08,00,13,00 ; C9h: Facing right - shinespark - horizontal
$91:BC79             db 04,1B,FF,07,08,00,13,00 ; CAh: Facing left  - shinespark - horizontal
$91:BC81             db 08,1B,FF,00,08,00,13,00 ; CBh: Facing right - shinespark - vertical
$91:BC89             db 04,1B,FF,09,08,00,13,00 ; CCh: Facing left  - shinespark - vertical
$91:BC91             db 08,1B,FF,01,08,00,13,00 ; CDh: Facing right - shinespark - diagonal
$91:BC99             db 04,1B,FF,08,08,00,13,00 ; CEh: Facing left  - shinespark - diagonal
$91:BCA1             db 08,15,89,01,06,00,15,00 ; CFh: Facing right - ran into a wall - aiming up-right
$91:BCA9             db 04,15,8A,08,06,00,15,00 ; D0h: Facing left  - ran into a wall - aiming up-left
$91:BCB1             db 08,15,89,03,06,00,15,00 ; D1h: Facing right - ran into a wall - aiming down-right
$91:BCB9             db 04,15,8A,06,06,00,15,00 ; D2h: Facing left  - ran into a wall - aiming down-left
$91:BCC1             db 08,1B,FF,FF,06,00,15,00 ; D3h: Facing right - crystal flash
$91:BCC9             db 04,1B,FF,FF,06,00,15,00 ; D4h: Facing left  - crystal flash
$91:BCD1             db 08,00,FF,02,06,00,15,00 ; D5h: Facing right - x-ray - standing
$91:BCD9             db 04,00,FF,07,06,00,15,00 ; D6h: Facing left  - x-ray - standing
$91:BCE1             db 08,0A,FF,02,06,00,15,00 ; D7h: Facing right - crystal flash ending
$91:BCE9             db 04,0A,FF,07,06,00,15,00 ; D8h: Facing left  - crystal flash ending
$91:BCF1             db 08,05,FF,02,00,00,10,00 ; D9h: Facing right - x-ray - crouching
$91:BCF9             db 04,05,FF,07,00,00,10,00 ; DAh: Facing left  - x-ray - crouching
$91:BD01             db 08,0F,FF,FF,00,00,07,00 ; DBh: Unused
$91:BD09             db 04,0F,FF,FF,00,00,07,00 ; DCh: Unused
$91:BD11             db 08,0F,FF,FF,06,00,15,00 ; DDh: Unused
$91:BD19             db 04,0F,FF,FF,06,00,15,00 ; DEh: Unused
$91:BD21             db 04,1A,FF,FF,00,00,07,00 ; DFh: Unused
$91:BD29             db 08,00,FF,00,03,00,15,00 ; E0h: Facing right - landing from normal jump - aiming up
$91:BD31             db 04,00,FF,09,03,00,15,00 ; E1h: Facing left  - landing from normal jump - aiming up
$91:BD39             db 08,00,FF,01,03,00,15,00 ; E2h: Facing right - landing from normal jump - aiming up-right
$91:BD41             db 04,00,FF,08,03,00,15,00 ; E3h: Facing left  - landing from normal jump - aiming up-left
$91:BD49             db 08,00,FF,03,03,00,15,00 ; E4h: Facing right - landing from normal jump - aiming down-right
$91:BD51             db 04,00,FF,06,03,00,15,00 ; E5h: Facing left  - landing from normal jump - aiming down-left
$91:BD59             db 08,00,FF,02,03,00,15,00 ; E6h: Facing right - landing from normal jump - firing
$91:BD61             db 04,00,FF,07,03,00,15,00 ; E7h: Facing left  - landing from normal jump - firing
$91:BD69             db 08,1B,FF,FF,FC,00,15,00 ; E8h: Facing right - Samus drained - crouching
$91:BD71             db 04,1B,FF,FF,FC,00,15,00 ; E9h: Facing left  - Samus drained - crouching
$91:BD79             db 08,1B,FF,FF,FC,00,15,00 ; EAh: Facing right - Samus drained - standing
$91:BD81             db 04,1B,FF,FF,FC,00,15,00 ; EBh: Facing left  - Samus drained - standing
$91:BD89             db 08,1A,FF,02,06,00,15,00 ; ECh: Facing right - grabbed by Draygon - not moving - not aiming
$91:BD91             db 08,1A,EC,01,06,00,15,00 ; EDh: Facing right - grabbed by Draygon - not moving - aiming up-right
$91:BD99             db 08,1A,EC,02,06,00,15,00 ; EEh: Facing right - grabbed by Draygon - firing
$91:BDA1             db 08,1A,EC,03,06,00,15,00 ; EFh: Facing right - grabbed by Draygon - not moving - aiming down-right
$91:BDA9             db 08,1A,EC,FF,06,00,15,00 ; F0h: Facing right - grabbed by Draygon - moving
$91:BDB1             db 08,0F,FF,00,08,00,10,00 ; F1h: Facing right - crouching transition - aiming up
$91:BDB9             db 04,0F,FF,09,08,00,10,00 ; F2h: Facing left  - crouching transition - aiming up
$91:BDC1             db 08,0F,FF,01,08,00,10,00 ; F3h: Facing right - crouching transition - aiming up-right
$91:BDC9             db 04,0F,FF,08,08,00,10,00 ; F4h: Facing left  - crouching transition - aiming up-left
$91:BDD1             db 08,0F,FF,03,08,00,10,00 ; F5h: Facing right - crouching transition - aiming down-right
$91:BDD9             db 04,0F,FF,06,08,00,10,00 ; F6h: Facing left  - crouching transition - aiming down-left
$91:BDE1             db 08,0F,FF,00,03,00,15,00 ; F7h: Facing right - standing transition - aiming up
$91:BDE9             db 04,0F,FF,09,03,00,15,00 ; F8h: Facing left  - standing transition - aiming up
$91:BDF1             db 08,0F,FF,01,03,00,15,00 ; F9h: Facing right - standing transition - aiming up-right
$91:BDF9             db 04,0F,FF,08,03,00,15,00 ; FAh: Facing left  - standing transition - aiming up-left
$91:BE01             db 08,0F,FF,03,03,00,15,00 ; FBh: Facing right - standing transition - aiming down-right
$91:BE09             db 04,0F,FF,06,03,00,15,00 ; FCh: Facing left  - standing transition - aiming down-left
}


;;; $BE11..C9D3: Calculate x-ray / morph ball eye beam HDMA data table ;;;
{
;;; $BE11: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen ;;;
{
;; Parameters:
;;     X: Beam origin X position
;;     Y: Beam origin Y position
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $12: Beam angle
;;     $14: Beam angular width
$91:BE11 08          PHP
$91:BE12 8B          PHB
$91:BE13 4B          PHK                    ;\
$91:BE14 AB          PLB                    ;} DB = $91
$91:BE15 C2 30       REP #$30
$91:BE17 8A          TXA                    ;\
$91:BE18 EB          XBA                    ;|
$91:BE19 29 00 FF    AND #$FF00             ;} $16 = [X] * 100h
$91:BE1C 85 16       STA $16    [$7E:0016]  ;/
$91:BE1E 84 18       STY $18    [$7E:0018]  ; $18 = [Y]
$91:BE20 A5 12       LDA $12    [$7E:0012]  ;\
$91:BE22 38          SEC                    ;|
$91:BE23 E5 14       SBC $14    [$7E:0014]  ;} $1A = [beam angle] - [beam angular width] (beam left edge angle)
$91:BE25 85 1A       STA $1A    [$7E:001A]  ;/
$91:BE27 10 08       BPL $08    [$BE31]     ; If [beam angle] < [beam angular width]:
$91:BE29 A9 00 01    LDA #$0100             ;\
$91:BE2C 18          CLC                    ;|
$91:BE2D 65 1A       ADC $1A    [$7E:001A]  ;} $1A += 100h
$91:BE2F 85 1A       STA $1A    [$7E:001A]  ;/

$91:BE31 A5 12       LDA $12    [$7E:0012]  ;\
$91:BE33 18          CLC                    ;|
$91:BE34 65 14       ADC $14    [$7E:0014]  ;} $1C = [beam angle] + [beam angular width] (beam right edge angle)
$91:BE36 85 1C       STA $1C    [$7E:001C]  ;/
$91:BE38 C9 01 01    CMP #$0101             ;\
$91:BE3B 30 06       BMI $06    [$BE43]     ;} If [beam angle] + [beam angular width] > 100h:
$91:BE3D 38          SEC                    ;\
$91:BE3E E9 00 01    SBC #$0100             ;} $1C -= 100h
$91:BE41 85 1C       STA $1C    [$7E:001C]  ;/

$91:BE43 A5 14       LDA $14    [$7E:0014]  ;\
$91:BE45 D0 0C       BNE $0C    [$BE53]     ;} If [beam angular width] = 0:
$91:BE47 A5 12       LDA $12    [$7E:0012]  ;\
$91:BE49 C9 40 00    CMP #$0040             ;} If [beam angle] = 40h: go to BRANCH_STRICTLY_HORIZONTAL
$91:BE4C F0 3C       BEQ $3C    [$BE8A]     ;/
$91:BE4E C9 C0 00    CMP #$00C0             ;\
$91:BE51 F0 37       BEQ $37    [$BE8A]     ;} If [beam angle] = C0h: go to BRANCH_STRICTLY_HORIZONTAL

$91:BE53 A5 1A       LDA $1A    [$7E:001A]  ;\
$91:BE55 C9 80 00    CMP #$0080             ;} If [beam left edge angle] < 80h:
$91:BE58 10 0E       BPL $0E    [$BE68]     ;/
$91:BE5A C9 40 00    CMP #$0040             ;\
$91:BE5D 10 21       BPL $21    [$BE80]     ;} If [beam left edge angle] >= 40h: go to BRANCH_BOTTOM_HALF
$91:BE5F A5 1C       LDA $1C    [$7E:001C]  ;\
$91:BE61 C9 40 00    CMP #$0040             ;} If [beam right edge angle] < 40h: go to BRANCH_TOP_HALF
$91:BE64 30 15       BMI $15    [$BE7B]     ;/
$91:BE66 80 0E       BRA $0E    [$BE76]     ; Go to BRANCH_RIGHT

$91:BE68 C9 C0 00    CMP #$00C0             ;\
$91:BE6B 10 0E       BPL $0E    [$BE7B]     ;} If [beam left edge angle] >= C0h: go to BRANCH_TOP_HALF
$91:BE6D A5 1C       LDA $1C    [$7E:001C]  ;\
$91:BE6F C9 C0 00    CMP #$00C0             ;} If [beam right edge angle] < C0h: go to BRANCH_BOTTOM_HALF
$91:BE72 30 0C       BMI $0C    [$BE80]     ;/
$91:BE74 80 0F       BRA $0F    [$BE85]     ; Go to BRANCH_LEFT

; BRANCH_RIGHT
; [beam left edge angle] < 40h and [beam right edge angle] >= 40h
$91:BE76 A0 00 00    LDY #$0000             ; Y = 0
$91:BE79 80 12       BRA $12    [$BE8D]     ; Go to BRANCH_MERGE

; BRANCH_TOP_HALF
; [beam right edge angle] < 40h or [beam left edge angle] >= C0h
$91:BE7B A0 02 00    LDY #$0002             ; Y = 2
$91:BE7E 80 0D       BRA $0D    [$BE8D]     ; Go to BRANCH_MERGE

; BRANCH_BOTTOM_HALF
; 40h <= [beam left edge angle] < 80h or 80h <= [beam left edge angle] and [beam right edge angle] < C0h
$91:BE80 A0 04 00    LDY #$0004             ; Y = 4
$91:BE83 80 08       BRA $08    [$BE8D]     ; Go to BRANCH_MERGE

; BRANCH_LEFT
; [beam left edge angle] < C0h and [beam right edge angle] >= C0h
$91:BE85 A0 06 00    LDY #$0006             ; Y = 6
$91:BE88 80 03       BRA $03    [$BE8D]     ; Go to BRANCH_MERGE

; BRANCH_STRICTLY_HORIZONTAL
; [beam angular width] = 0 and ([beam angle] = 40h or [beam angle] = C0h)
$91:BE8A A0 08 00    LDY #$0008             ; Y = 8

; BRANCH_MERGE
$91:BE8D A5 1A       LDA $1A    [$7E:001A]  ;\
$91:BE8F C9 80 00    CMP #$0080             ;|
$91:BE92 30 04       BMI $04    [$BE98]     ;|
$91:BE94 38          SEC                    ;|
$91:BE95 E9 80 00    SBC #$0080             ;|
                                            ;} $1E = |tan([beam left edge angle] % 80h * pi / 80h)| * 100h (beam left edge gradient)
$91:BE98 0A          ASL A                  ;|
$91:BE99 AA          TAX                    ;|
$91:BE9A BD D4 C9    LDA $C9D4,x[$91:CA74]  ;|
$91:BE9D 85 1E       STA $1E    [$7E:001E]  ;/
$91:BE9F A5 1C       LDA $1C    [$7E:001C]  ;\
$91:BEA1 C9 80 00    CMP #$0080             ;|
$91:BEA4 30 04       BMI $04    [$BEAA]     ;|
$91:BEA6 38          SEC                    ;|
$91:BEA7 E9 80 00    SBC #$0080             ;|
                                            ;} $20 = |tan([beam right edge angle] % 80h * pi / 80h)| * 100h (beam right edge gradient)
$91:BEAA 0A          ASL A                  ;|
$91:BEAB AA          TAX                    ;|
$91:BEAC BD D4 C9    LDA $C9D4,x[$91:CA84]  ;|
$91:BEAF 85 20       STA $20    [$7E:0020]  ;/
$91:BEB1 BB          TYX                    ;\
$91:BEB2 FC B8 BE    JSR ($BEB8,x)[$91:C27F];} Execute [$BEB8 + [Y]]
$91:BEB5 AB          PLB
$91:BEB6 28          PLP
$91:BEB7 6B          RTL

$91:BEB8             dw BEC2, C022, C27F, BF72, C505
}


;;; $BEC2: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed right ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h (note: negative)
;;     $18: Beam origin Y position
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
; [$12]/2 and [$14]/2 become the top and bottom Y positions of the largest rectangular region of the beam
$91:BEC2 08          PHP
$91:BEC3 C2 30       REP #$30
$91:BEC5 A5 18       LDA $18    [$7E:0018]  ;\
$91:BEC7 3A          DEC A                  ;|
$91:BEC8 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:BEC9 A8          TAY                    ;/
$91:BECA A5 16       LDA $16    [$7E:0016]  ;\
$91:BECC 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:BECE 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]

; LOOP_LEFT_OFF_SCREEN
$91:BED0 A5 22       LDA $22    [$7E:0022]  ;\
$91:BED2 18          CLC                    ;|
$91:BED3 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:BED5 85 22       STA $22    [$7E:0022]  ;/
$91:BED7 B0 09       BCS $09    [$BEE2]     ; If [$22] < 0:
$91:BED9 88          DEY                    ;\
$91:BEDA 88          DEY                    ;} Y -= 2
$91:BEDB 10 F3       BPL $F3    [$BED0]     ; If [Y] >= 0: go to LOOP_LEFT_OFF_SCREEN
$91:BEDD 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$91:BEDF 4C 12 BF    JMP $BF12  [$91:BF12]  ; Go to BRANCH_LEFT_EDGE_END

$91:BEE2 A5 23       LDA $23    [$7E:0023]  ;\
$91:BEE4 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = 00h, [$22] / 100h
$91:BEE7 97 00       STA [$00],y[$7E:918C]  ;/
$91:BEE9 C8          INY                    ;\
$91:BEEA C8          INY                    ;} $12 = [Y] + 2
$91:BEEB 84 12       STY $12    [$7E:0012]  ;/
$91:BEED 98          TYA                    ;\
$91:BEEE 38          SEC                    ;|
$91:BEEF E9 04 00    SBC #$0004             ;} Y -= 2
$91:BEF2 A8          TAY                    ;/

; LOOP_LEFT_ON_SCREEN
$91:BEF3 A5 22       LDA $22    [$7E:0022]  ;\
$91:BEF5 18          CLC                    ;|
$91:BEF6 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:BEF8 85 22       STA $22    [$7E:0022]  ;/
$91:BEFA B0 0D       BCS $0D    [$BF09]     ; If [$22] < 10000h:
$91:BEFC A5 23       LDA $23    [$7E:0023]  ;\
$91:BEFE 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = 00h, [$22] / 100h
$91:BF01 97 00       STA [$00],y[$7E:918A]  ;/
$91:BF03 88          DEY                    ;\
$91:BF04 88          DEY                    ;} Y -= 2
$91:BF05 10 EC       BPL $EC    [$BEF3]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:BF07 80 09       BRA $09    [$BF12]     ; Go to BRANCH_LEFT_EDGE_END

$91:BF09 A9 FF 00    LDA #$00FF             ;\
$91:BF0C 97 00       STA [$00],y[$7E:9180]  ;|
$91:BF0E 88          DEY                    ;} [$00]..([$00] + [Y]) = FFh, 00h
$91:BF0F 88          DEY                    ;|
$91:BF10 10 F7       BPL $F7    [$BF09]     ;/

; BRANCH_LEFT_EDGE_END
$91:BF12 A5 18       LDA $18    [$7E:0018]  ;\
$91:BF14 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:BF15 A8          TAY                    ;/

; LOOP_RIGHT_OFF_SCREEN
$91:BF16 A5 24       LDA $24    [$7E:0024]  ;\
$91:BF18 18          CLC                    ;|
$91:BF19 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:BF1B 85 24       STA $24    [$7E:0024]  ;/
$91:BF1D B0 0C       BCS $0C    [$BF2B]     ; If [$24] < 0:
$91:BF1F C8          INY                    ;\
$91:BF20 C8          INY                    ;} Y += 2
$91:BF21 C0 CC 01    CPY #$01CC             ;\
$91:BF24 30 F0       BMI $F0    [$BF16]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_OFF_SCREEN
$91:BF26 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$91:BF28 4C 61 BF    JMP $BF61  [$91:BF61]  ; Go to BRANCH_RIGHT_EDGE_END

$91:BF2B A5 25       LDA $25    [$7E:0025]  ;\
$91:BF2D 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = 00h, [$24] / 100h
$91:BF30 97 00       STA [$00],y[$7E:91A4]  ;/
$91:BF32 88          DEY                    ;\
$91:BF33 88          DEY                    ;} $14 = [Y] - 2
$91:BF34 84 14       STY $14    [$7E:0014]  ;/
$91:BF36 98          TYA                    ;\
$91:BF37 18          CLC                    ;|
$91:BF38 69 04 00    ADC #$0004             ;} Y += 2
$91:BF3B A8          TAY                    ;/

; LOOP_RIGHT_ON_SCREEN
$91:BF3C A5 24       LDA $24    [$7E:0024]  ;\
$91:BF3E 18          CLC                    ;|
$91:BF3F 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:BF41 85 24       STA $24    [$7E:0024]  ;/
$91:BF43 B0 10       BCS $10    [$BF55]     ; If [$24] < 10000h:
$91:BF45 A5 25       LDA $25    [$7E:0025]  ;\
$91:BF47 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = 00h, [$24] / 100h
$91:BF4A 97 00       STA [$00],y[$7E:91A6]  ;/
$91:BF4C C8          INY                    ;\
$91:BF4D C8          INY                    ;} Y += 2
$91:BF4E C0 CC 01    CPY #$01CC             ;\
$91:BF51 30 E9       BMI $E9    [$BF3C]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:BF53 80 0C       BRA $0C    [$BF61]     ; Go to BRANCH_RIGHT_EDGE_END

$91:BF55 A9 FF 00    LDA #$00FF             ;\
$91:BF58 97 00       STA [$00],y[$7E:91FC]  ;|
$91:BF5A C8          INY                    ;|
$91:BF5B C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:BF5C C0 CC 01    CPY #$01CC             ;|
$91:BF5F 30 F4       BMI $F4    [$BF55]     ;/

; BRANCH_RIGHT_EDGE_END
$91:BF61 A4 12       LDY $12    [$7E:0012]  ;\
                                            ;|
$91:BF63 A9 00 FF    LDA #$FF00             ;|
$91:BF66 97 00       STA [$00],y[$7E:918E]  ;|
$91:BF68 C8          INY                    ;} ([$00] + [$12])..([$00] + [$14]) = 00h, FFh
$91:BF69 C8          INY                    ;|
$91:BF6A C4 14       CPY $14    [$7E:0014]  ;|
$91:BF6C 30 F5       BMI $F5    [$BF63]     ;|
$91:BF6E F0 F3       BEQ $F3    [$BF63]     ;/
$91:BF70 28          PLP
$91:BF71 60          RTS
}


;;; $BF72: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed left ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h (note: over 10000h)
;;     $18: Beam origin Y position
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
; [$12]/2 and [$14]/2 become the top and bottom Y positions of the largest rectangular region of the beam
$91:BF72 08          PHP
$91:BF73 C2 30       REP #$30
$91:BF75 A5 18       LDA $18    [$7E:0018]  ;\
$91:BF77 3A          DEC A                  ;|
$91:BF78 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:BF79 A8          TAY                    ;/
$91:BF7A A5 16       LDA $16    [$7E:0016]  ;\
$91:BF7C 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:BF7E 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]

; LOOP_RIGHT_OFF_SCREEN
$91:BF80 A5 24       LDA $24    [$7E:0024]  ;\
$91:BF82 38          SEC                    ;|
$91:BF83 E5 20       SBC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:BF85 85 24       STA $24    [$7E:0024]  ;/
$91:BF87 90 09       BCC $09    [$BF92]     ; If [$24] >= 10000h:
$91:BF89 88          DEY                    ;\
$91:BF8A 88          DEY                    ;} Y -= 2
$91:BF8B 10 F3       BPL $F3    [$BF80]     ; If [Y] >= 0: go to LOOP_RIGHT_OFF_SCREEN
$91:BF8D 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$91:BF8F 4C C2 BF    JMP $BFC2  [$91:BFC2]  ; Go to BRANCH_RIGHT_EDGE_END

$91:BF92 A5 24       LDA $24    [$7E:0024]  ;\
$91:BF94 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [$24] / 100h
$91:BF97 97 00       STA [$00],y            ;/
$91:BF99 C8          INY                    ;\
$91:BF9A C8          INY                    ;} $12 = [Y] + 2
$91:BF9B 84 12       STY $12    [$7E:0012]  ;/
$91:BF9D 98          TYA                    ;\
$91:BF9E 38          SEC                    ;|
$91:BF9F E9 04 00    SBC #$0004             ;} Y -= 2
$91:BFA2 A8          TAY                    ;/

; LOOP_RIGHT_ON_SCREEN
$91:BFA3 A5 24       LDA $24    [$7E:0024]  ;\
$91:BFA5 38          SEC                    ;|
$91:BFA6 E5 20       SBC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:BFA8 85 24       STA $24    [$7E:0024]  ;/
$91:BFAA 90 0D       BCC $0D    [$BFB9]     ; If [$24] >= 0:
$91:BFAC A5 24       LDA $24    [$7E:0024]  ;\
$91:BFAE 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [$24] / 100h
$91:BFB1 97 00       STA [$00],y            ;/
$91:BFB3 88          DEY                    ;\
$91:BFB4 88          DEY                    ;} Y -= 2
$91:BFB5 10 EC       BPL $EC    [$BFA3]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:BFB7 80 09       BRA $09    [$BFC2]     ; Go to BRANCH_RIGHT_EDGE_END

$91:BFB9 A9 FF 00    LDA #$00FF             ;\
$91:BFBC 97 00       STA [$00],y            ;|
$91:BFBE 88          DEY                    ;} [$00]..([$00] + [Y]) = FFh, 00h
$91:BFBF 88          DEY                    ;|
$91:BFC0 10 F7       BPL $F7    [$BFB9]     ;/

; BRANCH_RIGHT_EDGE_END
$91:BFC2 A5 18       LDA $18    [$7E:0018]  ;\
$91:BFC4 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:BFC5 A8          TAY                    ;/

; LOOP_LEFT_OFF_SCREEN
$91:BFC6 A5 22       LDA $22    [$7E:0022]  ;\
$91:BFC8 38          SEC                    ;|
$91:BFC9 E5 1E       SBC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:BFCB 85 22       STA $22    [$7E:0022]  ;/
$91:BFCD 90 0C       BCC $0C    [$BFDB]     ; If [$22] >= 10000h:
$91:BFCF C8          INY                    ;\
$91:BFD0 C8          INY                    ;} Y += 2
$91:BFD1 C0 CC 01    CPY #$01CC             ;\
$91:BFD4 30 F0       BMI $F0    [$BFC6]     ;} If [Y] < 1CCh: go to LOOP_LEFT_OFF_SCREEN
$91:BFD6 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$91:BFD8 4C 11 C0    JMP $C011  [$91:C011]  ; Go to BRANCH_LEFT_EDGE_END

$91:BFDB A5 22       LDA $22    [$7E:0022]  ;\
$91:BFDD 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [$22] / 100h
$91:BFE0 97 00       STA [$00],y            ;/
$91:BFE2 88          DEY                    ;\
$91:BFE3 88          DEY                    ;} $14 = [Y] - 2
$91:BFE4 84 14       STY $14    [$7E:0014]  ;/
$91:BFE6 98          TYA                    ;\
$91:BFE7 18          CLC                    ;|
$91:BFE8 69 04 00    ADC #$0004             ;} Y += 2
$91:BFEB A8          TAY                    ;/

; LOOP_LEFT_ON_SCREEN
$91:BFEC A5 22       LDA $22    [$7E:0022]  ;\
$91:BFEE 38          SEC                    ;|
$91:BFEF E5 1E       SBC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:BFF1 85 22       STA $22    [$7E:0022]  ;/
$91:BFF3 90 10       BCC $10    [$C005]     ; If [$22] >= 0:
$91:BFF5 A5 22       LDA $22    [$7E:0022]  ;\
$91:BFF7 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [$22] / 100h
$91:BFFA 97 00       STA [$00],y            ;/
$91:BFFC C8          INY                    ;\
$91:BFFD C8          INY                    ;} Y += 2
$91:BFFE C0 CC 01    CPY #$01CC             ;\
$91:C001 30 E9       BMI $E9    [$BFEC]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C003 80 0C       BRA $0C    [$C011]     ; Go to BRANCH_LEFT_EDGE_END

$91:C005 A9 FF 00    LDA #$00FF             ;\
$91:C008 97 00       STA [$00],y            ;|
$91:C00A C8          INY                    ;|
$91:C00B C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C00C C0 CC 01    CPY #$01CC             ;|
$91:C00F 30 F4       BMI $F4    [$C005]     ;/

; BRANCH_LEFT_EDGE_END
$91:C011 A4 12       LDY $12    [$7E:0012]  ;\
                                            ;|
$91:C013 A9 00 FF    LDA #$FF00             ;|
$91:C016 97 00       STA [$00],y            ;|
$91:C018 C8          INY                    ;} ([$00] + [$12])..([$00] + [$14]) = 00h, FFh
$91:C019 C8          INY                    ;|
$91:C01A C4 14       CPY $14    [$7E:0014]  ;|
$91:C01C 30 F5       BMI $F5    [$C013]     ;|
$91:C01E F0 F3       BEQ $F3    [$C013]     ;/
$91:C020 28          PLP
$91:C021 60          RTS
}


;;; $C022: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed upwards ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
;;     $1A: Beam left edge angle
;;     $1C: Beam right edge angle
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
$91:C022 08          PHP
$91:C023 C2 30       REP #$30
$91:C025 A5 18       LDA $18    [$7E:0018]  ;\
$91:C027 3A          DEC A                  ;|
$91:C028 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C029 A8          TAY                    ;/
$91:C02A A5 16       LDA $16    [$7E:0016]  ;\
$91:C02C 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:C02E 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]
$91:C030 A5 1A       LDA $1A    [$7E:001A]  ;\
$91:C032 C9 C0 00    CMP #$00C0             ;} If [beam left edge angle] < C0h:
$91:C035 10 05       BPL $05    [$C03C]     ;/
$91:C037 A2 00 00    LDX #$0000             ; X = 0
$91:C03A 80 0F       BRA $0F    [$C04B]     ; Go to BRANCH_MERGE

$91:C03C A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C03E C9 C0 00    CMP #$00C0             ;} If [beam right edge angle] < C0h:
$91:C041 10 05       BPL $05    [$C048]     ;/
$91:C043 A2 02 00    LDX #$0002             ; X = 2
$91:C046 80 03       BRA $03    [$C04B]     ; Go to BRANCH_MERGE

$91:C048 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$91:C04B A5 18       LDA $18    [$7E:0018]  ;\
$91:C04D 0A          ASL A                  ;} $1A = [beam origin Y position] * 2
$91:C04E 85 1A       STA $1A    [$7E:001A]  ;/
$91:C050 FC 63 C0    JSR ($C063,x)          ; Execute [$C063 + [X]]
$91:C053 A4 12       LDY $12    [$7E:0012]  ;\
                                            ;|
$91:C055 A9 FF 00    LDA #$00FF             ;|
$91:C058 97 00       STA [$00],y            ;|
$91:C05A C8          INY                    ;} ([$00] + [$12])..([$00] + 1CBh) = FFh, 00h
$91:C05B C8          INY                    ;|
$91:C05C C0 CC 01    CPY #$01CC             ;|
$91:C05F 30 F4       BMI $F4    [$C055]     ;/
$91:C061 28          PLP
$91:C062 60          RTS

$91:C063             dw C069, C123, C1CA
}


;;; $C069: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed upwards - beam is aimed up-right ;;;
{
;; Parameters:
;;     Y: ([Beam origin Y position] - 1) * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h (note: negative)
;;     $24: Beam origin X position * 100h (note: negative)

;; Returns:
;;     $12: Index of bottom Y position of the beam

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
; [$12]/2 and [$14]/2 become the top and bottom Y positions of the largest rectangular region of the beam
$91:C069 08          PHP
$91:C06A C2 30       REP #$30
$91:C06C 5A          PHY                    ; Save Y

; LOOP_LEFT_OFF_SCREEN
$91:C06D A5 22       LDA $22    [$7E:0022]  ;\
$91:C06F 18          CLC                    ;|
$91:C070 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C072 85 22       STA $22    [$7E:0022]  ;/
$91:C074 B0 08       BCS $08    [$C07E]     ; If [$22] < 0:
$91:C076 88          DEY                    ;\
$91:C077 88          DEY                    ;} Y -= 2
$91:C078 10 F3       BPL $F3    [$C06D]     ; If [Y] >= 0: go to LOOP_LEFT_OFF_SCREEN
$91:C07A 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$91:C07C 80 3B       BRA $3B    [$C0B9]     ; Go to BRANCH_LEFT_EDGE_END

$91:C07E E2 20       SEP #$20               ;\
$91:C080 A5 23       LDA $23    [$7E:0023]  ;|
$91:C082 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C084 C2 20       REP #$20               ;/
$91:C086 88          DEY                    ;\
$91:C087 88          DEY                    ;} Y -= 2
$91:C088 10 07       BPL $07    [$C091]     ; If [Y] < 0:
$91:C08A A9 02 00    LDA #$0002             ;\
$91:C08D 85 12       STA $12    [$7E:0012]  ;} $12 = 2
$91:C08F 80 28       BRA $28    [$C0B9]     ; Go to BRANCH_LEFT_EDGE_END

$91:C091 98          TYA                    ;\
$91:C092 18          CLC                    ;|
$91:C093 69 04 00    ADC #$0004             ;} $12 = [Y] + 4
$91:C096 85 12       STA $12    [$7E:0012]  ;/

; LOOP_LEFT_ON_SCREEN
$91:C098 A5 22       LDA $22    [$7E:0022]  ;\
$91:C09A 18          CLC                    ;|
$91:C09B 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C09D 85 22       STA $22    [$7E:0022]  ;/
$91:C09F B0 0E       BCS $0E    [$C0AF]     ; If [$22] < 10000h:
$91:C0A1 E2 20       SEP #$20               ;\
$91:C0A3 A5 23       LDA $23    [$7E:0023]  ;|
$91:C0A5 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C0A7 C2 20       REP #$20               ;/
$91:C0A9 88          DEY                    ;\
$91:C0AA 88          DEY                    ;} Y -= 2
$91:C0AB 10 EB       BPL $EB    [$C098]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:C0AD 80 0A       BRA $0A    [$C0B9]     ; Go to BRANCH_LEFT_EDGE_END

$91:C0AF E2 20       SEP #$20               ;\
                                            ;|
$91:C0B1 A9 FF       LDA #$FF               ;|
$91:C0B3 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = FFh, xx
$91:C0B5 88          DEY                    ;|
$91:C0B6 88          DEY                    ;|
$91:C0B7 10 F8       BPL $F8    [$C0B1]     ;/

; BRANCH_LEFT_EDGE_END
$91:C0B9 C2 20       REP #$20
$91:C0BB 7A          PLY                    ;\
$91:C0BC C8          INY                    ;} Y = ([beam origin Y position] - 1) * 2 + 1

; LOOP_RIGHT_OFF_SCREEN
$91:C0BD A5 24       LDA $24    [$7E:0024]  ;\
$91:C0BF 18          CLC                    ;|
$91:C0C0 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C0C2 85 24       STA $24    [$7E:0024]  ;/
$91:C0C4 B0 0B       BCS $0B    [$C0D1]     ; If [$24] < 0:
$91:C0C6 88          DEY                    ;\
$91:C0C7 88          DEY                    ;} Y -= 2
$91:C0C8 10 F3       BPL $F3    [$C0BD]     ; If [Y] >= 0: go to LOOP_RIGHT_OFF_SCREEN
$91:C0CA A9 01 00    LDA #$0001             ;\
$91:C0CD 85 14       STA $14    [$7E:0014]  ;} $14 = 1
$91:C0CF 80 3B       BRA $3B    [$C10C]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C0D1 E2 20       SEP #$20               ;\
$91:C0D3 A5 25       LDA $25    [$7E:0025]  ;|
$91:C0D5 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C0D7 C2 20       REP #$20               ;/
$91:C0D9 88          DEY                    ;\
$91:C0DA 88          DEY                    ;} Y -= 2
$91:C0DB 10 07       BPL $07    [$C0E4]     ; If [Y] < 0:
$91:C0DD A9 03 00    LDA #$0003             ;\
$91:C0E0 85 14       STA $14    [$7E:0014]  ;} $14 = 3
$91:C0E2 80 28       BRA $28    [$C10C]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C0E4 98          TYA                    ;\
$91:C0E5 18          CLC                    ;|
$91:C0E6 69 04 00    ADC #$0004             ;} $14 = [Y] + 4
$91:C0E9 85 14       STA $14    [$7E:0014]  ;/

; LOOP_RIGHT_ON_SCREEN
$91:C0EB A5 24       LDA $24    [$7E:0024]  ;\
$91:C0ED 18          CLC                    ;|
$91:C0EE 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C0F0 85 24       STA $24    [$7E:0024]  ;/
$91:C0F2 B0 0E       BCS $0E    [$C102]     ; If [$24] < 10000h:
$91:C0F4 E2 20       SEP #$20               ;\
$91:C0F6 A5 25       LDA $25    [$7E:0025]  ;|
$91:C0F8 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C0FA C2 20       REP #$20               ;/
$91:C0FC 88          DEY                    ;\
$91:C0FD 88          DEY                    ;} Y -= 2
$91:C0FE 10 EB       BPL $EB    [$C0EB]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C100 80 0A       BRA $0A    [$C10C]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C102 E2 20       SEP #$20               ;\
                                            ;|
$91:C104 A9 FF       LDA #$FF               ;|
$91:C106 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = xx,FFh
$91:C108 88          DEY                    ;|
$91:C109 88          DEY                    ;|
$91:C10A 10 F8       BPL $F8    [$C104]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C10C E2 20       SEP #$20               ;\
$91:C10E A4 12       LDY $12    [$7E:0012]  ;|
                                            ;|
$91:C110 A9 00       LDA #$00               ;|
$91:C112 97 00       STA [$00],y            ;|
$91:C114 C8          INY                    ;} ([$00] + [$12])..([$00] + [$14]) = 00h
$91:C115 C8          INY                    ;|
$91:C116 C4 14       CPY $14    [$7E:0014]  ;|
$91:C118 30 F6       BMI $F6    [$C110]     ;|
$91:C11A C2 20       REP #$20               ;/
$91:C11C A5 14       LDA $14    [$7E:0014]  ;\
$91:C11E 3A          DEC A                  ;} $12 = [$14] - 1
$91:C11F 85 12       STA $12    [$7E:0012]  ;/
$91:C121 28          PLP
$91:C122 60          RTS
}


;;; $C123: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed upwards - beam is aimed up ;;;
{
;; Parameters:
;;     Y: ([Beam origin Y position] - 1) * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

;; Returns:
;;     $12: Index of bottom Y position of the beam

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)

; This routine is never called, because x-ray is not allowed to be aimed upwards and morph ball eye isn't positioned to allow it.
; That said, this routine seems... wrong?
; It looks like it works off the assumption that the beam left/right lines both start off-screen,
; specifically that the left line comes from right off-screen and the right line comes from left off-screen,
; which is clearly impossible.
; The return value $12 is questionable too,
; it's given here as the index of the lowest Y position of the left line that's on-screen,
; rather than the minimum of left and right lines.
; This routine ought to be split into two cases depending on which side off-screen Samus is.

$91:C123 08          PHP
$91:C124 C2 30       REP #$30
$91:C126 5A          PHY                    ; Save Y

; LOOP_LEFT_OFF_SCREEN
$91:C127 A5 22       LDA $22    [$7E:0022]  ;\
$91:C129 38          SEC                    ;|
$91:C12A E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C12C 85 22       STA $22    [$7E:0022]  ;/
$91:C12E 90 08       BCC $08    [$C138]     ; If [$22] < 10000h:
$91:C130 88          DEY                    ;\
$91:C131 88          DEY                    ;} Y -= 2
$91:C132 10 F3       BPL $F3    [$C127]     ; If [Y] >= 0: go to LOOP_LEFT_OFF_SCREEN
$91:C134 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$91:C136 80 3B       BRA $3B    [$C173]     ; Go to BRANCH_LEFT_EDGE_END

$91:C138 E2 20       SEP #$20               ;\
$91:C13A A5 23       LDA $23    [$7E:0023]  ;|
$91:C13C 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C13E C2 20       REP #$20               ;/
$91:C140 88          DEY                    ;\
$91:C141 88          DEY                    ;} Y -= 2
$91:C142 10 07       BPL $07    [$C14B]     ; If [Y] < 0:
$91:C144 A9 02 00    LDA #$0002             ;\
$91:C147 85 12       STA $12    [$7E:0012]  ;} $12 = 2
$91:C149 80 28       BRA $28    [$C173]     ; Go to BRANCH_LEFT_EDGE_END

$91:C14B 98          TYA                    ;\
$91:C14C 18          CLC                    ;|
$91:C14D 69 04 00    ADC #$0004             ;} $12 = [Y] + 4
$91:C150 85 12       STA $12    [$7E:0012]  ;/

; LOOP_LEFT_ON_SCREEN
$91:C152 A5 22       LDA $22    [$7E:0022]  ;\
$91:C154 38          SEC                    ;|
$91:C155 E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C157 85 22       STA $22    [$7E:0022]  ;/
$91:C159 90 0E       BCC $0E    [$C169]     ; If [$22] >= 0:
$91:C15B E2 20       SEP #$20               ;\
$91:C15D A5 23       LDA $23    [$7E:0023]  ;|
$91:C15F 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C161 C2 20       REP #$20               ;/
$91:C163 88          DEY                    ;\
$91:C164 88          DEY                    ;} Y -= 2
$91:C165 10 EB       BPL $EB    [$C152]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:C167 80 0A       BRA $0A    [$C173]     ; Go to BRANCH_LEFT_EDGE_END

$91:C169 E2 20       SEP #$20               ;\
                                            ;|
$91:C16B A9 00       LDA #$00               ;|
$91:C16D 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = FFh, xx
$91:C16F 88          DEY                    ;|
$91:C170 88          DEY                    ;|
$91:C171 10 F8       BPL $F8    [$C16B]     ;/

; BRANCH_LEFT_EDGE_END
$91:C173 C2 20       REP #$20
$91:C175 7A          PLY                    ;\
$91:C176 C8          INY                    ;} Y = ([beam origin Y position] - 1) * 2 + 1

; LOOP_RIGHT_OFF_SCREEN
$91:C177 A5 24       LDA $24    [$7E:0024]  ;\
$91:C179 18          CLC                    ;|
$91:C17A 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C17C 85 24       STA $24    [$7E:0024]  ;/
$91:C17E B0 0B       BCS $0B    [$C18B]     ; If [$24] < 0:
$91:C180 88          DEY                    ;\
$91:C181 88          DEY                    ;} Y -= 2
$91:C182 10 F3       BPL $F3    [$C177]     ; If [Y] >= 0: go to LOOP_RIGHT_OFF_SCREEN
$91:C184 A9 01 00    LDA #$0001             ;\
$91:C187 85 14       STA $14    [$7E:0014]  ;} $14 = 1
$91:C189 80 3B       BRA $3B    [$C1C6]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C18B E2 20       SEP #$20               ;\
$91:C18D A5 25       LDA $25    [$7E:0025]  ;|
$91:C18F 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C191 C2 20       REP #$20               ;/
$91:C193 88          DEY                    ;\
$91:C194 88          DEY                    ;} Y -= 2
$91:C195 10 07       BPL $07    [$C19E]     ; If [Y] < 0:
$91:C197 A9 03 00    LDA #$0003             ;\
$91:C19A 85 14       STA $14    [$7E:0014]  ;} $14 = 3
$91:C19C 80 28       BRA $28    [$C1C6]     ; Return

$91:C19E 98          TYA                    ;\
$91:C19F 18          CLC                    ;|
$91:C1A0 69 04 00    ADC #$0004             ;} $14 = [Y] + 4
$91:C1A3 85 14       STA $14    [$7E:0014]  ;/

; LOOP_RIGHT_ON_SCREEN
$91:C1A5 A5 24       LDA $24    [$7E:0024]  ;\
$91:C1A7 18          CLC                    ;|
$91:C1A8 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C1AA 85 24       STA $24    [$7E:0024]  ;/
$91:C1AC B0 0E       BCS $0E    [$C1BC]     ; If [$24] < 10000h:
$91:C1AE E2 20       SEP #$20               ;\
$91:C1B0 A5 25       LDA $25    [$7E:0025]  ;|
$91:C1B2 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C1B4 C2 20       REP #$20               ;/
$91:C1B6 88          DEY                    ;\
$91:C1B7 88          DEY                    ;} Y -= 2
$91:C1B8 10 EB       BPL $EB    [$C1A5]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C1BA 80 0A       BRA $0A    [$C1C6]     ; Return

$91:C1BC E2 20       SEP #$20               ;\
                                            ;|
$91:C1BE A9 FF       LDA #$FF               ;|
$91:C1C0 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = xx,FFh
$91:C1C2 88          DEY                    ;|
$91:C1C3 88          DEY                    ;|
$91:C1C4 10 F8       BPL $F8    [$C1BE]     ;/

$91:C1C6 C2 20       REP #$20
$91:C1C8 28          PLP
$91:C1C9 60          RTS
}


;;; $C1CA: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed upwards - beam is aimed up-left ;;;
{
;; Parameters:
;;     Y: ([Beam origin Y position] - 1) * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h (note: over 10000h)
;;     $24: Beam origin X position * 100h (note: over 10000h)

;; Returns:
;;     $12: Index of bottom Y position of the beam

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
; [$12]/2 and [$14]/2 become the top and bottom Y positions of the largest rectangular region of the beam
$91:C1CA 08          PHP
$91:C1CB C2 30       REP #$30
$91:C1CD 5A          PHY                    ; Save Y

; LOOP_LEFT_OFF_SCREEN
$91:C1CE A5 22       LDA $22    [$7E:0022]  ;\
$91:C1D0 38          SEC                    ;|
$91:C1D1 E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C1D3 85 22       STA $22    [$7E:0022]  ;/
$91:C1D5 90 08       BCC $08    [$C1DF]     ; If [$22] >= 10000h:
$91:C1D7 88          DEY                    ;\
$91:C1D8 88          DEY                    ;} Y -= 2
$91:C1D9 10 F3       BPL $F3    [$C1CE]     ; If [Y] >= 0: go to LOOP_LEFT_OFF_SCREEN
$91:C1DB 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$91:C1DD 80 3B       BRA $3B    [$C21A]     ; Go to BRANCH_LEFT_EDGE_END

$91:C1DF E2 20       SEP #$20               ;\
$91:C1E1 A5 23       LDA $23    [$7E:0023]  ;|
$91:C1E3 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C1E5 C2 20       REP #$20               ;/
$91:C1E7 88          DEY                    ;\
$91:C1E8 88          DEY                    ;} Y -= 2
$91:C1E9 10 07       BPL $07    [$C1F2]     ; If [Y] < 0:
$91:C1EB A9 02 00    LDA #$0002             ;\
$91:C1EE 85 12       STA $12    [$7E:0012]  ;} $12 = 2
$91:C1F0 80 28       BRA $28    [$C21A]     ; Go to BRANCH_LEFT_EDGE_END

$91:C1F2 98          TYA                    ;\
$91:C1F3 18          CLC                    ;|
$91:C1F4 69 04 00    ADC #$0004             ;} $12 = [Y] + 4
$91:C1F7 85 12       STA $12    [$7E:0012]  ;/

; LOOP_LEFT_ON_SCREEN
$91:C1F9 A5 22       LDA $22    [$7E:0022]  ;\
$91:C1FB 38          SEC                    ;|
$91:C1FC E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C1FE 85 22       STA $22    [$7E:0022]  ;/
$91:C200 90 0E       BCC $0E    [$C210]     ; If [$22] >= 0:
$91:C202 E2 20       SEP #$20               ;\
$91:C204 A5 23       LDA $23    [$7E:0023]  ;|
$91:C206 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C208 C2 20       REP #$20               ;/
$91:C20A 88          DEY                    ;\
$91:C20B 88          DEY                    ;} Y -= 2
$91:C20C 10 EB       BPL $EB    [$C1F9]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:C20E 80 0A       BRA $0A    [$C21A]

$91:C210 E2 20       SEP #$20               ;\
                                            ;|
$91:C212 A9 00       LDA #$00               ;|
$91:C214 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = FFh, xx
$91:C216 88          DEY                    ;|
$91:C217 88          DEY                    ;|
$91:C218 10 F8       BPL $F8    [$C212]     ;/

; BRANCH_LEFT_EDGE_END
$91:C21A C2 20       REP #$20
$91:C21C 7A          PLY                    ;\
$91:C21D C8          INY                    ;} Y = ([beam origin Y position] - 1) * 2 + 1

; LOOP_RIGHT_OFF_SCREEN
$91:C21E A5 24       LDA $24    [$7E:0024]  ;\
$91:C220 38          SEC                    ;|
$91:C221 E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C223 85 24       STA $24    [$7E:0024]  ;/
$91:C225 90 0B       BCC $0B    [$C232]     ; If [$24] < 10000h:
$91:C227 88          DEY                    ;\
$91:C228 88          DEY                    ;} Y -= 2
$91:C229 10 F3       BPL $F3    [$C21E]     ; If [Y] >= 0: go to LOOP_RIGHT_OFF_SCREEN
$91:C22B A9 01 00    LDA #$0001             ;\
$91:C22E 85 14       STA $14    [$7E:0014]  ;} $14 = 1
$91:C230 80 3B       BRA $3B    [$C26D]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C232 E2 20       SEP #$20               ;\
$91:C234 A5 23       LDA $23    [$7E:0023]  ;|
$91:C236 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C238 C2 20       REP #$20               ;/
$91:C23A 88          DEY                    ;\
$91:C23B 88          DEY                    ;} Y -= 2
$91:C23C 10 07       BPL $07    [$C245]     ; If [Y] < 0:
$91:C23E A9 03 00    LDA #$0003             ;\
$91:C241 85 14       STA $14    [$7E:0014]  ;} $14 = 3
$91:C243 80 28       BRA $28    [$C26D]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C245 98          TYA                    ;\
$91:C246 18          CLC                    ;|
$91:C247 69 04 00    ADC #$0004             ;} $14 = [Y] + 4
$91:C24A 85 14       STA $14    [$7E:0014]  ;/

; LOOP_RIGHT_ON_SCREEN
$91:C24C A5 24       LDA $24    [$7E:0024]  ;\
$91:C24E 38          SEC                    ;|
$91:C24F E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C251 85 24       STA $24    [$7E:0024]  ;/
$91:C253 90 0E       BCC $0E    [$C263]     ; If [$24] < 0:
$91:C255 E2 20       SEP #$20               ;\
$91:C257 A5 25       LDA $25    [$7E:0025]  ;|
$91:C259 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C25B C2 20       REP #$20               ;/
$91:C25D 88          DEY                    ;\
$91:C25E 88          DEY                    ;} Y -= 2
$91:C25F 10 EB       BPL $EB    [$C24C]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C261 80 0A       BRA $0A    [$C26D]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C263 E2 20       SEP #$20               ;\
                                            ;|
$91:C265 A9 00       LDA #$00               ;|
$91:C267 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = xx,00h
$91:C269 88          DEY                    ;|
$91:C26A 88          DEY                    ;|
$91:C26B 10 F8       BPL $F8    [$C265]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C26D E2 20       SEP #$20               ;\
$91:C26F A4 14       LDY $14    [$7E:0014]  ;|
                                            ;|
$91:C271 A9 FF       LDA #$FF               ;|
$91:C273 97 00       STA [$00],y            ;|
$91:C275 C8          INY                    ;} ([$00] + [$12])..([$00] + [$14]) = FFh
$91:C276 C8          INY                    ;|
$91:C277 C4 12       CPY $12    [$7E:0012]  ;|
$91:C279 30 F6       BMI $F6    [$C271]     ;|
$91:C27B C2 20       REP #$20               ;/
$91:C27D 28          PLP
$91:C27E 60          RTS
}


;;; $C27F: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed downwards ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
;;     $1A: Beam left edge angle
;;     $1C: Beam right edge angle
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
$91:C27F 08          PHP
$91:C280 C2 30       REP #$30
$91:C282 A5 18       LDA $18    [$7E:0018]  ;\
$91:C284 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:C285 A8          TAY                    ;/
$91:C286 A5 16       LDA $16    [$7E:0016]  ;\
$91:C288 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:C28A 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]
$91:C28C A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C28E C9 80 00    CMP #$0080             ;} If [beam right edge angle] < 80h:
$91:C291 10 05       BPL $05    [$C298]     ;/
$91:C293 A2 00 00    LDX #$0000             ; X = 0
$91:C296 80 0F       BRA $0F    [$C2A7]     ; Go to BRANCH_MERGE

$91:C298 A5 1A       LDA $1A    [$7E:001A]  ;\
$91:C29A C9 80 00    CMP #$0080             ;} If [beam left edge angle] < 80h:
$91:C29D 10 05       BPL $05    [$C2A4]     ;/
$91:C29F A2 02 00    LDX #$0002             ; X = 2
$91:C2A2 80 03       BRA $03    [$C2A7]     ; Go to BRANCH_MERGE

$91:C2A4 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$91:C2A7 FC B7 C2    JSR ($C2B7,x)[$91:C2BD]; Execute [$C063 + [X]]
$91:C2AA A4 12       LDY $12    [$7E:0012]  ;\
$91:C2AC A9 FF 00    LDA #$00FF             ;|
                                            ;|
$91:C2AF 97 00       STA [$00],y[$7E:918E]  ;} [$00]..([$00] + [$12] + 1) = FFh, 00h
$91:C2B1 88          DEY                    ;|
$91:C2B2 88          DEY                    ;|
$91:C2B3 10 FA       BPL $FA    [$C2AF]     ;/
$91:C2B5 28          PLP
$91:C2B6 60          RTS

$91:C2B7             dw C2BD, C381, C446
}


;;; $C2BD: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed downwards - beam is aimed down-right ;;;
{
;; Parameters:
;;     Y: [Beam origin Y position] * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h (note: negative)
;;     $24: Beam origin X position * 100h (note: negative)

;; Returns:
;;     $12: Index of top Y position of the beam

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
; [$12]/2 and [$14]/2 become the bottom and top Y positions of the largest rectangular region of the beam
$91:C2BD 08          PHP
$91:C2BE C2 30       REP #$30
$91:C2C0 5A          PHY                    ; Save Y

; LOOP_RIGHT_OFF_SCREEN
$91:C2C1 A5 24       LDA $24    [$7E:0024]  ;\
$91:C2C3 18          CLC                    ;|
$91:C2C4 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C2C6 85 24       STA $24    [$7E:0024]  ;/
$91:C2C8 B0 0B       BCS $0B    [$C2D5]     ; If [$24] < 0:
$91:C2CA C8          INY                    ;\
$91:C2CB C8          INY                    ;} Y += 2
$91:C2CC C0 CC 01    CPY #$01CC             ;\
$91:C2CF 30 F0       BMI $F0    [$C2C1]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_OFF_SCREEN
$91:C2D1 84 12       STY $12    [$7E:0012]  ; $12 = [Y]
$91:C2D3 80 3B       BRA $3B    [$C310]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C2D5 A5 25       LDA $25    [$7E:0025]  ;\
$91:C2D7 97 00       STA [$00],y[$7E:9192]  ;} [$00] + [Y] = [$24] / 100h
$91:C2D9 C8          INY                    ;\
$91:C2DA C8          INY                    ;|
$91:C2DB C0 CC 01    CPY #$01CC             ;}
$91:C2DE 30 07       BMI $07    [$C2E7]     ;/ If [Y] >= 1CAh:
$91:C2E0 A9 CA 01    LDA #$01CA             ;\
$91:C2E3 85 12       STA $12    [$7E:0012]  ;} $12 = 1CAh
$91:C2E5 80 29       BRA $29    [$C310]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C2E7 98          TYA                    ;\
$91:C2E8 38          SEC                    ;|
$91:C2E9 E9 04 00    SBC #$0004             ;} $12 = [Y] - 2
$91:C2EC 85 12       STA $12    [$7E:0012]  ;/

; LOOP_RIGHT_ON_SCREEN
$91:C2EE A5 24       LDA $24    [$7E:0024]  ;\
$91:C2F0 18          CLC                    ;|
$91:C2F1 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C2F3 85 24       STA $24    [$7E:0024]  ;/
$91:C2F5 B0 0D       BCS $0D    [$C304]     ; If [$24] < 10000h:
$91:C2F7 A5 25       LDA $25    [$7E:0025]  ;\
$91:C2F9 97 00       STA [$00],y[$7E:9194]  ;} [$00] + [Y] = [$24] / 100h
$91:C2FB C8          INY                    ;\
$91:C2FC C8          INY                    ;} Y += 2
$91:C2FD C0 CC 01    CPY #$01CC             ;\
$91:C300 30 EC       BMI $EC    [$C2EE]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C302 80 0C       BRA $0C    [$C310]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C304 A9 FF 00    LDA #$00FF             ;\
$91:C307 97 00       STA [$00],y[$7E:92BA]  ;|
$91:C309 C8          INY                    ;|
$91:C30A C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C30B C0 CC 01    CPY #$01CC             ;|
$91:C30E 30 F4       BMI $F4    [$C304]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C310 7A          PLY                    ;\
$91:C311 C8          INY                    ;} Y = [beam origin Y position] * 2 + 1

; LOOP_LEFT_OFF_SCREEN
$91:C312 A5 22       LDA $22    [$7E:0022]  ;\
$91:C314 18          CLC                    ;|
$91:C315 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C317 85 22       STA $22    [$7E:0022]  ;/
$91:C319 B0 0B       BCS $0B    [$C326]     ; If [$22] < 0:
$91:C31B C8          INY                    ;\
$91:C31C C8          INY                    ;} Y += 2
$91:C31D C0 CC 01    CPY #$01CC             ;\
$91:C320 30 F0       BMI $F0    [$C312]     ;} If [Y] < 1CCh: go to LOOP_LEFT_OFF_SCREEN
$91:C322 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$91:C324 80 44       BRA $44    [$C36A]     ; Go to BRANCH_LEFT_EDGE_END

$91:C326 E2 20       SEP #$20               ;\
$91:C328 A5 23       LDA $23    [$7E:0023]  ;|
$91:C32A 97 00       STA [$00],y[$7E:9191]  ;} [$00] + [Y] = [$22] / 100h
$91:C32C C2 20       REP #$20               ;/
$91:C32E C8          INY                    ;\
$91:C32F C8          INY                    ;|
$91:C330 C0 CC 01    CPY #$01CC             ;} If [Y] >= 1CAh:
$91:C333 30 07       BMI $07    [$C33C]     ;/
$91:C335 A9 CB 01    LDA #$01CB             ;\
$91:C338 85 14       STA $14    [$7E:0014]  ;} $14 = 1CAh
$91:C33A 80 2E       BRA $2E    [$C36A]     ; Go to BRANCH_LEFT_EDGE_END

$91:C33C 98          TYA                    ;\
$91:C33D 38          SEC                    ;|
$91:C33E E9 04 00    SBC #$0004             ;} $14 = [Y] - 2
$91:C341 85 14       STA $14    [$7E:0014]  ;/

; LOOP_LEFT_ON_SCREEN
$91:C343 A5 22       LDA $22    [$7E:0022]  ;\
$91:C345 18          CLC                    ;|
$91:C346 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C348 85 22       STA $22    [$7E:0022]  ;/
$91:C34A B0 11       BCS $11    [$C35D]     ; If [$22] < 10000h:
$91:C34C E2 20       SEP #$20               ;\
$91:C34E A5 23       LDA $23    [$7E:0023]  ;|
$91:C350 97 00       STA [$00],y[$7E:9193]  ;} [$00] + [Y] = [$22] / 100h
$91:C352 C2 20       REP #$20               ;/
$91:C354 C8          INY                    ;\
$91:C355 C8          INY                    ;} Y += 2
$91:C356 C0 CC 01    CPY #$01CC             ;\
$91:C359 30 E8       BMI $E8    [$C343]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C35B 80 0D       BRA $0D    [$C36A]     ; Go to BRANCH_LEFT_EDGE_END

$91:C35D E2 20       SEP #$20               ;\
                                            ;|
$91:C35F A9 FF       LDA #$FF               ;|
$91:C361 97 00       STA [$00],y[$7E:9265]  ;|
$91:C363 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CCh) = xx, FFh
$91:C364 C8          INY                    ;|
$91:C365 C0 CC 01    CPY #$01CC             ;|
$91:C368 30 F5       BMI $F5    [$C35F]     ;/

; BRANCH_LEFT_EDGE_END
$91:C36A E2 20       SEP #$20               ;\
$91:C36C A4 12       LDY $12    [$7E:0012]  ;|
                                            ;|
$91:C36E A9 00       LDA #$00               ;|
$91:C370 97 00       STA [$00],y[$7E:9190]  ;|
$91:C372 88          DEY                    ;} ([$00] + [$14])..([$00] + [$12]) = 00h
$91:C373 88          DEY                    ;|
$91:C374 C4 14       CPY $14    [$7E:0014]  ;|
$91:C376 10 F6       BPL $F6    [$C36E]     ;|
$91:C378 C2 20       REP #$20               ;/
$91:C37A A5 14       LDA $14    [$7E:0014]  ;\
$91:C37C 3A          DEC A                  ;} $12 = [$14] - 1
$91:C37D 85 12       STA $12    [$7E:0012]  ;/
$91:C37F 28          PLP
$91:C380 60          RTS
}


;;; $C381: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed downwards - beam is aimed down ;;;
{
;; Parameters:
;;     Y: [Beam origin Y position] * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

;; Returns:
;;     $12: Index of top Y position of the beam

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)

$91:C381 08          PHP
$91:C382 C2 30       REP #$30
$91:C384 5A          PHY                    ; Save Y
$91:C385 A5 20       LDA $20    [$7E:0020]  ;\
$91:C387 D0 10       BNE $10    [$C399]     ;} If [beam right edge gradient * 100h] != 0: go to LOOP_RIGHT_OFF_SCREEN
$91:C389 84 12       STY $12    [$7E:0012]  ; $12 = [Y]
$91:C38B A9 00 00    LDA #$0000             ;\
                                            ;|
$91:C38E 97 00       STA [$00],y            ;|
$91:C390 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = 00h, 00h
$91:C391 C8          INY                    ;|
$91:C392 C0 CC 01    CPY #$01CC             ;|
$91:C395 30 F7       BMI $F7    [$C38E]     ;/
$91:C397 80 4F       BRA $4F    [$C3E8]     ; Go to BRANCH_RIGHT_EDGE_END

; LOOP_RIGHT_OFF_SCREEN
$91:C399 A5 24       LDA $24    [$7E:0024]  ;\
$91:C39B 38          SEC                    ;|
$91:C39C E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C39E 85 24       STA $24    [$7E:0024]  ;/
$91:C3A0 90 0B       BCC $0B    [$C3AD]     ; If [$24] >= 10000h:
$91:C3A2 C8          INY                    ;\
$91:C3A3 C8          INY                    ;} Y += 2
$91:C3A4 C0 CC 01    CPY #$01CC             ;\
$91:C3A7 30 F0       BMI $F0    [$C399]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_OFF_SCREEN
$91:C3A9 84 12       STY $12    [$7E:0012]  ; $12 = [Y]
$91:C3AB 80 3B       BRA $3B    [$C3E8]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C3AD A5 25       LDA $25    [$7E:0025]  ;\
$91:C3AF 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C3B1 C8          INY                    ;\
$91:C3B2 C8          INY                    ;|
$91:C3B3 C0 CC 01    CPY #$01CC             ;}
$91:C3B6 30 07       BMI $07    [$C3BF]     ;/ If [Y] >= 1CAh:
$91:C3B8 A9 CA 01    LDA #$01CA             ;\
$91:C3BB 85 12       STA $12    [$7E:0012]  ;} $12 = 1CAh
$91:C3BD 80 29       BRA $29    [$C3E8]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C3BF 98          TYA                    ;\
$91:C3C0 38          SEC                    ;|
$91:C3C1 E9 04 00    SBC #$0004             ;} $12 = [Y] - 2
$91:C3C4 85 12       STA $12    [$7E:0012]  ;/

; LOOP_RIGHT_ON_SCREEN
$91:C3C6 A5 24       LDA $24    [$7E:0024]  ;\
$91:C3C8 38          SEC                    ;|
$91:C3C9 E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C3CB 85 24       STA $24    [$7E:0024]  ;/
$91:C3CD 90 0D       BCC $0D    [$C3DC]     ; If [$24] >= 0:
$91:C3CF A5 25       LDA $25    [$7E:0025]  ;\
$91:C3D1 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C3D3 C8          INY                    ;\
$91:C3D4 C8          INY                    ;} Y += 2
$91:C3D5 C0 CC 01    CPY #$01CC             ;\
$91:C3D8 30 EC       BMI $EC    [$C3C6]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C3DA 80 0C       BRA $0C    [$C3E8]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C3DC A9 00 00    LDA #$0000             ;\
$91:C3DF 97 00       STA [$00],y            ;|
$91:C3E1 C8          INY                    ;|
$91:C3E2 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = 00h, 00h
$91:C3E3 C0 CC 01    CPY #$01CC             ;|
$91:C3E6 30 F4       BMI $F4    [$C3DC]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C3E8 7A          PLY                    ;\
$91:C3E9 C8          INY                    ;} Y = [beam origin Y position] * 2 + 1

; LOOP_LEFT_OFF_SCREEN
$91:C3EA A5 22       LDA $22    [$7E:0022]  ;\
$91:C3EC 18          CLC                    ;|
$91:C3ED 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C3EF 85 22       STA $22    [$7E:0022]  ;/
$91:C3F1 B0 0B       BCS $0B    [$C3FE]     ; If [$22] < 0:
$91:C3F3 C8          INY                    ;\
$91:C3F4 C8          INY                    ;} Y += 2
$91:C3F5 C0 CC 01    CPY #$01CC             ;\
$91:C3F8 30 F0       BMI $F0    [$C3EA]     ;} If [Y] < 1CCh: go to LOOP_LEFT_OFF_SCREEN
$91:C3FA 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$91:C3FC 80 46       BRA $46    [$C444]     ; Go to BRANCH_LEFT_EDGE_END

$91:C3FE E2 20       SEP #$20               ;\
$91:C400 A5 23       LDA $23    [$7E:0023]  ;|
$91:C402 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C404 C2 20       REP #$20               ;/
$91:C406 C8          INY                    ;\
$91:C407 C8          INY                    ;|
$91:C408 C0 CC 01    CPY #$01CC             ;} If [Y] >= 1CAh:
$91:C40B 30 07       BMI $07    [$C414]     ;/
$91:C40D A9 CB 01    LDA #$01CB             ;\
$91:C410 85 14       STA $14    [$7E:0014]  ;} $14 = 1CAh
$91:C412 80 30       BRA $30    [$C444]     ; Return

$91:C414 98          TYA                    ;\
$91:C415 38          SEC                    ;|
$91:C416 E9 04 00    SBC #$0004             ;} $14 = [Y] - 2
$91:C419 85 14       STA $14    [$7E:0014]  ;/

; LOOP_LEFT_ON_SCREEN
$91:C41B A5 22       LDA $22    [$7E:0022]  ;\
$91:C41D 18          CLC                    ;|
$91:C41E 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C420 85 22       STA $22    [$7E:0022]  ;/
$91:C422 B0 11       BCS $11    [$C435]     ; If [$22] < 10000h:
$91:C424 E2 20       SEP #$20               ;\
$91:C426 A5 23       LDA $23    [$7E:0023]  ;|
$91:C428 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C42A C2 20       REP #$20               ;/
$91:C42C C8          INY                    ;\
$91:C42D C8          INY                    ;} Y += 2
$91:C42E C0 CC 01    CPY #$01CC             ;\
$91:C431 30 E8       BMI $E8    [$C41B]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C433 80 0F       BRA $0F    [$C444]     ; Return

$91:C435 E2 20       SEP #$20               ;\
$91:C437 A9 FF       LDA #$FF               ;|
                                            ;|
$91:C439 97 00       STA [$00],y            ;|
$91:C43B C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, xx
$91:C43C C8          INY                    ;|
$91:C43D C0 CC 01    CPY #$01CC             ;|
$91:C440 30 F7       BMI $F7    [$C439]     ;|
$91:C442 C2 20       REP #$20               ;/

$91:C444 28          PLP
$91:C445 60          RTS
}


;;; $C446: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is aimed downwards - beam is aimed down-left ;;;
{
;; Parameters:
;;     Y: [Beam origin Y position] * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h (note: above 10000h)
;;     $24: Beam origin X position * 100h (note: above 10000h)

;; Returns:
;;     $12: Index of top Y position of the beam

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
; [$12]/2 and [$14]/2 become the bottom and top Y positions of the largest rectangular region of the beam
$91:C446 08          PHP
$91:C447 C2 30       REP #$30
$91:C449 5A          PHY                    ; Save Y

; LOOP_RIGHT_OFF_SCREEN
$91:C44A A5 24       LDA $24    [$7E:0024]  ;\
$91:C44C 38          SEC                    ;|
$91:C44D E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C44F 85 24       STA $24    [$7E:0024]  ;/
$91:C451 90 0B       BCC $0B    [$C45E]     ; If [$24] >= 10000h:
$91:C453 C8          INY                    ;\
$91:C454 C8          INY                    ;} Y += 2
$91:C455 C0 CC 01    CPY #$01CC             ;\
$91:C458 30 F0       BMI $F0    [$C44A]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_OFF_SCREEN
$91:C45A 84 12       STY $12    [$7E:0012]  ; $12 = [Y]
$91:C45C 80 3B       BRA $3B    [$C499]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C45E A5 25       LDA $25    [$7E:0025]  ;\
$91:C460 97 00       STA [$00],y[$7E:91D0]  ;} [$00] + [Y] = [$24] / 100h
$91:C462 C8          INY                    ;\
$91:C463 C8          INY                    ;|
$91:C464 C0 CC 01    CPY #$01CC             ;}
$91:C467 30 07       BMI $07    [$C470]     ;/ If [Y] >= 1CAh:
$91:C469 A9 CA 01    LDA #$01CA             ;\
$91:C46C 85 12       STA $12    [$7E:0012]  ;} $12 = 1CAh
$91:C46E 80 29       BRA $29    [$C499]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C470 98          TYA                    ;\
$91:C471 38          SEC                    ;|
$91:C472 E9 04 00    SBC #$0004             ;} $12 = [Y] - 2
$91:C475 85 12       STA $12    [$7E:0012]  ;/

; LOOP_RIGHT_ON_SCREEN
$91:C477 A5 24       LDA $24    [$7E:0024]  ;\
$91:C479 38          SEC                    ;|
$91:C47A E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C47C 85 24       STA $24    [$7E:0024]  ;/
$91:C47E 90 0D       BCC $0D    [$C48D]     ; If [$24] >= 0:
$91:C480 A5 25       LDA $25    [$7E:0025]  ;\
$91:C482 97 00       STA [$00],y[$7E:91D2]  ;} [$00] + [Y] = [$24] / 100h
$91:C484 C8          INY                    ;\
$91:C485 C8          INY                    ;} Y += 2
$91:C486 C0 CC 01    CPY #$01CC             ;\
$91:C489 30 EC       BMI $EC    [$C477]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C48B 80 0C       BRA $0C    [$C499]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C48D A9 00 00    LDA #$0000             ;\
$91:C490 97 00       STA [$00],y[$7E:92C2]  ;|
$91:C492 C8          INY                    ;|
$91:C493 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = 00h, 00h
$91:C494 C0 CC 01    CPY #$01CC             ;|
$91:C497 30 F4       BMI $F4    [$C48D]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C499 7A          PLY                    ;\
$91:C49A C8          INY                    ;} Y = [beam origin Y position] * 2 + 1

; LOOP_LEFT_OFF_SCREEN
$91:C49B A5 22       LDA $22    [$7E:0022]  ;\
$91:C49D 38          SEC                    ;|
$91:C49E E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C4A0 85 22       STA $22    [$7E:0022]  ;/
$91:C4A2 90 0B       BCC $0B    [$C4AF]     ; If [$22] >= 10000h:
$91:C4A4 C8          INY                    ;\
$91:C4A5 C8          INY                    ;} Y += 2
$91:C4A6 C0 CC 01    CPY #$01CC             ;\
$91:C4A9 30 F0       BMI $F0    [$C49B]     ;} If [Y] < 1CCh: go to LOOP_LEFT_OFF_SCREEN
$91:C4AB 84 14       STY $14    [$7E:0014]  ; $14 = [Y]
$91:C4AD 80 44       BRA $44    [$C4F3]     ; Go to BRANCH_LEFT_EDGE_END

$91:C4AF E2 20       SEP #$20               ;\
$91:C4B1 A5 23       LDA $23    [$7E:0023]  ;|
$91:C4B3 97 00       STA [$00],y[$7E:91D1]  ;} [$00] + [Y] = [$22] / 100h
$91:C4B5 C2 20       REP #$20               ;/
$91:C4B7 C8          INY                    ;\
$91:C4B8 C8          INY                    ;|
$91:C4B9 C0 CC 01    CPY #$01CC             ;} If [Y] >= 1CAh:
$91:C4BC 30 07       BMI $07    [$C4C5]     ;/
$91:C4BE A9 CB 01    LDA #$01CB             ;\
$91:C4C1 85 14       STA $14    [$7E:0014]  ;} $14 = 1CAh
$91:C4C3 80 2E       BRA $2E    [$C4F3]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C4C5 98          TYA                    ;\
$91:C4C6 38          SEC                    ;|
$91:C4C7 E9 04 00    SBC #$0004             ;} $14 = [Y] - 2
$91:C4CA 85 14       STA $14    [$7E:0014]  ;/

; LOOP_LEFT_ON_SCREEN
$91:C4CC A5 22       LDA $22    [$7E:0022]  ;\
$91:C4CE 38          SEC                    ;|
$91:C4CF E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C4D1 85 22       STA $22    [$7E:0022]  ;/
$91:C4D3 90 11       BCC $11    [$C4E6]     ; If [$22] >= 0:
$91:C4D5 E2 20       SEP #$20               ;\
$91:C4D7 A5 23       LDA $23    [$7E:0023]  ;|
$91:C4D9 97 00       STA [$00],y[$7E:91D3]  ;} [$00] + [Y] = [$22] / 100h
$91:C4DB C2 20       REP #$20               ;/
$91:C4DD C8          INY                    ;\
$91:C4DE C8          INY                    ;} Y += 2
$91:C4DF C0 CC 01    CPY #$01CC             ;\
$91:C4E2 30 E8       BMI $E8    [$C4CC]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C4E4 80 0D       BRA $0D    [$C4F3]     ; Go to BRANCH_LEFT_EDGE_END

$91:C4E6 E2 20       SEP #$20               ;\
                                            ;|
$91:C4E8 A9 00       LDA #$00               ;|
$91:C4EA 97 00       STA [$00],y            ;|
$91:C4EC C8          INY                    ;} ([$00] + [Y] - 1)..([$00] + 1CCh) = xx, 00h
$91:C4ED C8          INY                    ;|
$91:C4EE C0 CC 01    CPY #$01CC             ;|
$91:C4F1 30 F5       BMI $F5    [$C4E8]     ;/

; BRANCH_LEFT_EDGE_END
$91:C4F3 E2 20       SEP #$20               ;\
$91:C4F5 A4 14       LDY $14    [$7E:0014]  ;|
                                            ;|
$91:C4F7 A9 FF       LDA #$FF               ;|
$91:C4F9 97 00       STA [$00],y[$7E:91CF]  ;|
$91:C4FB 88          DEY                    ;} ([$00] + [$12])..([$00] + [$14]) = FFh, xx
$91:C4FC 88          DEY                    ;|
$91:C4FD C4 12       CPY $12    [$7E:0012]  ;|
$91:C4FF 10 F6       BPL $F6    [$C4F7]     ;|
$91:C501 C2 20       REP #$20               ;/
$91:C503 28          PLP
$91:C504 60          RTS
}


;;; $C505: Calculate x-ray / morph ball eye beam HDMA data table - origin is off screen - beam is horizontal line ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $12: Beam angle
;;     $18: Beam origin Y position
$91:C505 08          PHP
$91:C506 C2 30       REP #$30
$91:C508 A5 18       LDA $18    [$7E:0018]  ;\
$91:C50A 3A          DEC A                  ;|
$91:C50B 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C50C A8          TAY                    ;/
$91:C50D A5 12       LDA $12    [$7E:0012]  ;\
$91:C50F C9 40 00    CMP #$0040             ;|
$91:C512 D0 07       BNE $07    [$C51B]     ;|
$91:C514 A9 00 FF    LDA #$FF00             ;|
$91:C517 97 00       STA [$00],y            ;} [$00] + [Y] = 00h, FFh
$91:C519 80 05       BRA $05    [$C520]     ;|
                                            ;|
$91:C51B A9 00 FF    LDA #$FF00             ;|
$91:C51E 97 00       STA [$00],y            ;/

$91:C520 88          DEY                    ;\
$91:C521 88          DEY                    ;} Y -= 2

; LOOP_TOP
$91:C522 B7 00       LDA [$00],y            ;\
$91:C524 C9 FF 00    CMP #$00FF             ;} If [[$00] + [Y]] != FFh, 00h:
$91:C527 F0 09       BEQ $09    [$C532]     ;/
$91:C529 A9 FF 00    LDA #$00FF             ;\
$91:C52C 97 00       STA [$00],y            ;} [$00] + [Y] = FFh, 00h
$91:C52E 88          DEY                    ;\
$91:C52F 88          DEY                    ;} Y -= 2
$91:C530 10 F0       BPL $F0    [$C522]     ; If [Y] >= 0: go to LOOP_TOP

; LOOP_BOTTOM
$91:C532 A5 18       LDA $18    [$7E:0018]  ;\
$91:C534 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:C535 A8          TAY                    ;/

$91:C536 B7 00       LDA [$00],y            ;\
$91:C538 C9 FF 00    CMP #$00FF             ;} If [[$00] + [Y]] != FFh, 00h:
$91:C53B F0 0C       BEQ $0C    [$C549]     ;/
$91:C53D A9 FF 00    LDA #$00FF             ;\
$91:C540 97 00       STA [$00],y            ;} [$00] + [Y] = FFh, 00h
$91:C542 C8          INY                    ;\
$91:C543 C8          INY                    ;} Y += 2
$91:C544 C0 CC 01    CPY #$01CC             ;\
$91:C547 30 ED       BMI $ED    [$C536]     ;} If [Y] < 1CCh: go to LOOP_BOTTOM

$91:C549 28          PLP
$91:C54A 60          RTS
}


;;; $C54B: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen ;;;
{
;; Parameters:
;;     X: Beam origin X position
;;     Y: Beam origin Y position
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $12: [beam angle]
;;     $14: [beam angular width]
$91:C54B 08          PHP
$91:C54C 8B          PHB
$91:C54D 4B          PHK                    ;\
$91:C54E AB          PLB                    ;} DB = $91
$91:C54F C2 30       REP #$30
$91:C551 8A          TXA                    ;\
$91:C552 EB          XBA                    ;|
$91:C553 29 00 FF    AND #$FF00             ;} $16 = [X] * 100h
$91:C556 85 16       STA $16    [$7E:0016]  ;/
$91:C558 84 18       STY $18    [$7E:0018]  ; $18 = [Y]
$91:C55A A5 12       LDA $12    [$7E:0012]  ;\
$91:C55C 38          SEC                    ;|
$91:C55D E5 14       SBC $14    [$7E:0014]  ;} $1A = [beam angle] - [beam angular width] (beam left edge angle)
$91:C55F 85 1A       STA $1A    [$7E:001A]  ;/
$91:C561 10 08       BPL $08    [$C56B]     ; If [beam angle] < [beam angular width]:
$91:C563 A9 00 01    LDA #$0100             ;\
$91:C566 18          CLC                    ;|
$91:C567 65 1A       ADC $1A    [$7E:001A]  ;} $1A += 100h
$91:C569 85 1A       STA $1A    [$7E:001A]  ;/

$91:C56B A5 12       LDA $12    [$7E:0012]  ;\
$91:C56D 18          CLC                    ;|
$91:C56E 65 14       ADC $14    [$7E:0014]  ;} $1C = [beam angle] + [beam angular width] (beam right edge angle)
$91:C570 85 1C       STA $1C    [$7E:001C]  ;/
$91:C572 C9 01 01    CMP #$0101             ;\
$91:C575 30 06       BMI $06    [$C57D]     ;} If [beam angle] + [beam angular width] > 100h:
$91:C577 38          SEC                    ;\
$91:C578 E9 00 01    SBC #$0100             ;} $1C -= 100h
$91:C57B 85 1C       STA $1C    [$7E:001C]  ;/

$91:C57D A5 14       LDA $14    [$7E:0014]  ;\
$91:C57F D0 0C       BNE $0C    [$C58D]     ;} If [beam angular width] = 0:
$91:C581 A5 12       LDA $12    [$7E:0012]  ;\
$91:C583 C9 40 00    CMP #$0040             ;} If [beam angle] = 40h: go to BRANCH_STRICTLY_HORIZONTAL
$91:C586 F0 3C       BEQ $3C    [$C5C4]     ;/
$91:C588 C9 C0 00    CMP #$00C0             ;\
$91:C58B F0 37       BEQ $37    [$C5C4]     ;} If [beam angle] = C0h: go to BRANCH_STRICTLY_HORIZONTAL

$91:C58D A5 1A       LDA $1A    [$7E:001A]  ;\
$91:C58F C9 80 00    CMP #$0080             ;} If [beam left edge angle] < 80h:
$91:C592 10 0E       BPL $0E    [$C5A2]     ;/
$91:C594 C9 40 00    CMP #$0040             ;\
$91:C597 10 21       BPL $21    [$C5BA]     ;} If [beam left edge angle] >= 40h: go to BRANCH_BOTTOM_HALF
$91:C599 A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C59B C9 40 00    CMP #$0040             ;} If [beam right edge angle] < 40h: go to BRANCH_TOP_HALF
$91:C59E 30 15       BMI $15    [$C5B5]     ;/
$91:C5A0 80 0E       BRA $0E    [$C5B0]     ; Go to BRANCH_RIGHT

$91:C5A2 C9 C0 00    CMP #$00C0             ;\
$91:C5A5 10 0E       BPL $0E    [$C5B5]     ;} If [beam left edge angle] >= C0h: go to BRANCH_TOP_HALF
$91:C5A7 A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C5A9 C9 C0 00    CMP #$00C0             ;} If [beam right edge angle] < C0h: go to BRANCH_BOTTOM_HALF
$91:C5AC 30 0C       BMI $0C    [$C5BA]     ;/
$91:C5AE 80 0F       BRA $0F    [$C5BF]     ; Go to BRANCH_LEFT

; BRANCH_RIGHT
; [beam left edge angle] < 40h and [beam right edge angle] >= 40h
$91:C5B0 A0 00 00    LDY #$0000             ; Y = 0
$91:C5B3 80 12       BRA $12    [$C5C7]     ; Go to BRANCH_MERGE

; BRANCH_TOP_HALF
; [beam right edge angle] < 40h or [beam left edge angle] >= C0h
$91:C5B5 A0 02 00    LDY #$0002             ; Y = 2
$91:C5B8 80 0D       BRA $0D    [$C5C7]     ; Go to BRANCH_MERGE

; BRANCH_BOTTOM_HALF
; 40h <= [beam left edge angle] < 80h or 80h <= [beam left edge angle] and [beam right edge angle] < C0h
$91:C5BA A0 04 00    LDY #$0004             ; Y = 4
$91:C5BD 80 08       BRA $08    [$C5C7]     ; Go to BRANCH_MERGE

; BRANCH_LEFT
; [beam left edge angle] < C0h and [beam right edge angle] >= C0h
$91:C5BF A0 06 00    LDY #$0006             ; Y = 6
$91:C5C2 80 03       BRA $03    [$C5C7]     ; Go to BRANCH_MERGE

; BRANCH_STRICTLY_HORIZONTAL
; [beam angular width] = 0 and ([beam angle] = 40h or [beam angle] = C0h)
$91:C5C4 A0 08 00    LDY #$0008             ; Y = 8

; BRANCH_MERGE
$91:C5C7 A5 1A       LDA $1A    [$7E:001A]  ;\
$91:C5C9 C9 80 00    CMP #$0080             ;|
$91:C5CC 30 04       BMI $04    [$C5D2]     ;|
$91:C5CE 38          SEC                    ;|
$91:C5CF E9 80 00    SBC #$0080             ;|
                                            ;} $1E = |tan([beam left edge angle] % 80h * pi / 80h)| * 100h (beam left edge gradient)
$91:C5D2 0A          ASL A                  ;|
$91:C5D3 AA          TAX                    ;|
$91:C5D4 BD D4 C9    LDA $C9D4,x[$91:CA7E]  ;|
$91:C5D7 85 1E       STA $1E    [$7E:001E]  ;/
$91:C5D9 A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C5DB C9 80 00    CMP #$0080             ;|
$91:C5DE 30 04       BMI $04    [$C5E4]     ;|
$91:C5E0 38          SEC                    ;|
$91:C5E1 E9 80 00    SBC #$0080             ;|
                                            ;} $20 = |tan([beam right edge angle] % 80h * pi / 80h)| * 100h (beam right edge gradient)
$91:C5E4 0A          ASL A                  ;|
$91:C5E5 AA          TAX                    ;|
$91:C5E6 BD D4 C9    LDA $C9D4,x[$91:CA7E]  ;|
$91:C5E9 85 20       STA $20    [$7E:0020]  ;/
$91:C5EB BB          TYX
$91:C5EC 9C 1E 0D    STZ $0D1E  [$7E:0D1E]  ; Off-screen beam HDMA data table index = 0
$91:C5EF FC F5 C5    JSR ($C5F5,x)[$91:C822]; Execute [$C5F5 + [Y]]
$91:C5F2 AB          PLB
$91:C5F3 28          PLP
$91:C5F4 6B          RTL

$91:C5F5             dw C5FF, C6C1, C822, C660, C998
}


;;; $C5FF: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed right ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C5FF 08          PHP
$91:C600 C2 30       REP #$30
$91:C602 A5 18       LDA $18    [$7E:0018]  ;\
$91:C604 3A          DEC A                  ;|
$91:C605 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C606 A8          TAY                    ;/
$91:C607 A5 17       LDA $17    [$7E:0017]  ;\
$91:C609 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = [beam origin X position], FFh
$91:C60C 97 00       STA [$00],y[$7E:9894]  ;/
$91:C60E 88          DEY                    ;\
$91:C60F 88          DEY                    ;} Y -= 2
$91:C610 A5 16       LDA $16    [$7E:0016]  ;\
$91:C612 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:C614 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]

; LOOP_LEFT_ON_SCREEN
$91:C616 A5 22       LDA $22    [$7E:0022]  ;\
$91:C618 18          CLC                    ;|
$91:C619 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C61B 85 22       STA $22    [$7E:0022]  ;/
$91:C61D B0 0D       BCS $0D    [$C62C]     ; If [$22] < 10000h:
$91:C61F A5 23       LDA $23    [$7E:0023]  ;\
$91:C621 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = [$22] / 100h, FFh
$91:C624 97 00       STA [$00],y[$7E:9892]  ;/
$91:C626 88          DEY                    ;\
$91:C627 88          DEY                    ;} Y -= 2
$91:C628 10 EC       BPL $EC    [$C616]     ; If [Y] >= 0: go to LOOP_LEFT
$91:C62A 80 09       BRA $09    [$C635]     ; Go to BRANCH_LEFT_EDGE_END

$91:C62C A9 FF 00    LDA #$00FF             ;\
$91:C62F 97 00       STA [$00],y[$7E:988E]  ;|
$91:C631 88          DEY                    ;} [$00]..([$00] + [Y] + 1) = FFh, 00h
$91:C632 88          DEY                    ;|
$91:C633 10 F7       BPL $F7    [$C62C]     ;/

; BRANCH_LEFT_EDGE_END
$91:C635 A5 18       LDA $18    [$7E:0018]  ;\
$91:C637 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:C638 A8          TAY                    ;/

; LOOP_RIGHT_ON_SCREEN
$91:C639 A5 24       LDA $24    [$7E:0024]  ;\
$91:C63B 18          CLC                    ;|
$91:C63C 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C63E 85 24       STA $24    [$7E:0024]  ;/
$91:C640 B0 10       BCS $10    [$C652]     ; If [$24] < 10000h:
$91:C642 A5 25       LDA $25    [$7E:0025]  ;\
$91:C644 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = 00h, [$24] / 100h
$91:C647 97 00       STA [$00],y[$7E:9896]  ;/
$91:C649 C8          INY                    ;\
$91:C64A C8          INY                    ;} Y += 2
$91:C64B C0 CC 01    CPY #$01CC             ;\
$91:C64E 30 E9       BMI $E9    [$C639]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C650 80 0C       BRA $0C    [$C65E]     ; Return

$91:C652 A9 FF 00    LDA #$00FF             ;\
$91:C655 97 00       STA [$00],y[$7E:989A]  ;|
$91:C657 C8          INY                    ;|
$91:C658 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C659 C0 CC 01    CPY #$01CC             ;|
$91:C65C 30 F4       BMI $F4    [$C652]     ;/

$91:C65E 28          PLP
$91:C65F 60          RTS
}


;;; $C660: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed left ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C660 08          PHP
$91:C661 C2 30       REP #$30
$91:C663 A5 18       LDA $18    [$7E:0018]  ;\
$91:C665 3A          DEC A                  ;|
$91:C666 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C667 A8          TAY                    ;/
$91:C668 A5 16       LDA $16    [$7E:0016]  ;\
$91:C66A 29 00 FF    AND #$FF00             ;} [$00] + [Y] = [beam origin X position], FFh
$91:C66D 97 00       STA [$00],y[$7E:98FE]  ;/
$91:C66F 88          DEY                    ;\
$91:C670 88          DEY                    ;} Y -= 2
$91:C671 A5 16       LDA $16    [$7E:0016]  ;\
$91:C673 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:C675 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]

; LOOP_RIGHT_ON_SCREEN
$91:C677 A5 24       LDA $24    [$7E:0024]  ;\
$91:C679 38          SEC                    ;|
$91:C67A E5 20       SBC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C67C 85 24       STA $24    [$7E:0024]  ;/
$91:C67E 90 0D       BCC $0D    [$C68D]     ; If [$24] >= 0:
$91:C680 A5 24       LDA $24    [$7E:0024]  ;\
$91:C682 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [$24] / 100h
$91:C685 97 00       STA [$00],y[$7E:98FC]  ;/
$91:C687 88          DEY                    ;\
$91:C688 88          DEY                    ;} Y -= 2
$91:C689 10 EC       BPL $EC    [$C677]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C68B 80 09       BRA $09    [$C696]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C68D A9 FF 00    LDA #$00FF             ;\
$91:C690 97 00       STA [$00],y[$7E:98F8]  ;|
$91:C692 88          DEY                    ;} [$00]..([$00] + [Y]) = FFh, 00h
$91:C693 88          DEY                    ;|
$91:C694 10 F7       BPL $F7    [$C68D]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C696 A5 18       LDA $18    [$7E:0018]  ;\
$91:C698 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:C699 A8          TAY                    ;/

; LOOP_LEFT_ON_SCREEN
$91:C69A A5 22       LDA $22    [$7E:0022]  ;\
$91:C69C 38          SEC                    ;|
$91:C69D E5 1E       SBC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C69F 85 22       STA $22    [$7E:0022]  ;/
$91:C6A1 90 10       BCC $10    [$C6B3]     ; If [$22] >= 0:
$91:C6A3 A5 22       LDA $22    [$7E:0022]  ;\
$91:C6A5 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [$22] / 100h
$91:C6A8 97 00       STA [$00],y[$7E:9900]  ;/
$91:C6AA C8          INY                    ;\
$91:C6AB C8          INY                    ;} Y += 2
$91:C6AC C0 CC 01    CPY #$01CC             ;\
$91:C6AF 30 E9       BMI $E9    [$C69A]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C6B1 80 0C       BRA $0C    [$C6BF]     ; Return

$91:C6B3 A9 FF 00    LDA #$00FF             ;\
$91:C6B6 97 00       STA [$00],y[$7E:9904]  ;|
$91:C6B8 C8          INY                    ;|
$91:C6B9 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C6BA C0 CC 01    CPY #$01CC             ;|
$91:C6BD 30 F4       BMI $F4    [$C6B3]     ;/

$91:C6BF 28          PLP
$91:C6C0 60          RTS
}


;;; $C6C1: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed upwards ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
;;     $1A: Beam left edge angle
;;     $1C: Beam right edge angle
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
$91:C6C1 08          PHP
$91:C6C2 C2 30       REP #$30
$91:C6C4 A5 18       LDA $18    [$7E:0018]  ;\
$91:C6C6 3A          DEC A                  ;|
$91:C6C7 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C6C8 A8          TAY                    ;/
$91:C6C9 E2 20       SEP #$20               ;\
$91:C6CB A5 17       LDA $17    [$7E:0017]  ;|
$91:C6CD 97 00       STA [$00],y[$7E:9948]  ;|
$91:C6CF C8          INY                    ;|
$91:C6D0 A5 17       LDA $17    [$7E:0017]  ;} [$00] + [Y] = [beam origin X position], [beam origin X position]
$91:C6D2 97 00       STA [$00],y[$7E:9949]  ;|
$91:C6D4 C2 20       REP #$20               ;|
$91:C6D6 88          DEY                    ;/
$91:C6D7 88          DEY                    ;\
$91:C6D8 88          DEY                    ;} Y -= 2
$91:C6D9 A5 16       LDA $16    [$7E:0016]  ;\
$91:C6DB 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:C6DD 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]
$91:C6DF A5 1A       LDA $1A    [$7E:001A]  ;\
$91:C6E1 C9 C0 00    CMP #$00C0             ;} If [beam left edge angle] < C0h:
$91:C6E4 10 05       BPL $05    [$C6EB]     ;/
$91:C6E6 A2 00 00    LDX #$0000             ; X = 0
$91:C6E9 80 0F       BRA $0F    [$C6FA]     ; Go to BRANCH_MERGE

$91:C6EB A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C6ED C9 C0 00    CMP #$00C0             ;} If [beam right edge angle] < C0h:
$91:C6F0 10 05       BPL $05    [$C6F7]     ;/
$91:C6F2 A2 02 00    LDX #$0002             ; X = 2
$91:C6F5 80 03       BRA $03    [$C6FA]     ; Go to BRANCH_MERGE

$91:C6F7 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$91:C6FA FC 16 C7    JSR ($C716,x)[$91:C7CB]; Execute [$C716 + [X]]
$91:C6FD A5 18       LDA $18    [$7E:0018]  ;\
$91:C6FF 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:C700 A8          TAY                    ;/

; LOOP
$91:C701 B7 00       LDA [$00],y[$7E:994A]  ;\
$91:C703 C9 FF 00    CMP #$00FF             ;} If [[$00] + [Y]] != FFh, 00h:
$91:C706 F0 0C       BEQ $0C    [$C714]     ;/
$91:C708 A9 FF 00    LDA #$00FF             ;\
$91:C70B 97 00       STA [$00],y[$7E:994A]  ;} [$00] + [Y] = FFh, 00h
$91:C70D C8          INY                    ;\
$91:C70E C8          INY                    ;} Y += 2
$91:C70F C0 CC 01    CPY #$01CC             ;\
$91:C712 30 ED       BMI $ED    [$C701]     ;} If [Y] < 1CCh: go to LOOP

$91:C714 28          PLP
$91:C715 60          RTS

$91:C716             dw C71C, C77F, C7CB
}


;;; $C71C: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed upwards - beam is aimed up-right ;;;
{
;; Parameters:
;;     Y: ([Beam origin Y position] - 1) * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C71C 08          PHP
$91:C71D C2 30       REP #$30
$91:C71F 5A          PHY                    ; Save Y

; LOOP_LEFT_ON_SCREEN
$91:C720 A5 22       LDA $22    [$7E:0022]  ;\
$91:C722 18          CLC                    ;|
$91:C723 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C725 85 22       STA $22    [$7E:0022]  ;/
$91:C727 B0 0E       BCS $0E    [$C737]     ; If [$22] < 10000h:
$91:C729 E2 20       SEP #$20               ;\
$91:C72B A5 23       LDA $23    [$7E:0023]  ;|
$91:C72D 97 00       STA [$00],y[$7E:98FE]  ;} [$00] + [Y] = [$22] / 100h
$91:C72F C2 20       REP #$20               ;/
$91:C731 88          DEY                    ;\
$91:C732 88          DEY                    ;} Y -= 2
$91:C733 10 EB       BPL $EB    [$C720]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:C735 80 0F       BRA $0F    [$C746]     ; Go to BRANCH_LEFT_EDGE_END

$91:C737 8C 1E 0D    STY $0D1E  [$7E:0D1E]  ; Off-screen beam HDMA data table index = [Y]
$91:C73A E2 20       SEP #$20               ;\
$91:C73C A9 FF       LDA #$FF               ;|
                                            ;|
$91:C73E 97 00       STA [$00],y[$7E:985C]  ;} [$00]..([$00] + [Y]) = FFh, xx
$91:C740 88          DEY                    ;|
$91:C741 88          DEY                    ;|
$91:C742 10 FA       BPL $FA    [$C73E]     ;/
$91:C744 C2 20       REP #$20

; BRANCH_LEFT_EDGE_END
$91:C746 7A          PLY                    ;\
$91:C747 C8          INY                    ;} Y = ([beam origin Y position] - 1) * 2 + 1

; LOOP_RIGHT_ON_SCREEN
$91:C748 A5 24       LDA $24    [$7E:0024]  ;\
$91:C74A 18          CLC                    ;|
$91:C74B 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C74D 85 24       STA $24    [$7E:0024]  ;/
$91:C74F B0 0E       BCS $0E    [$C75F]     ; If [$24] < 10000h:
$91:C751 E2 20       SEP #$20               ;\
$91:C753 A5 25       LDA $25    [$7E:0025]  ;|
$91:C755 97 00       STA [$00],y[$7E:98FF]  ;} [$00] + [Y] = [$24] / 100h
$91:C757 C2 20       REP #$20               ;/
$91:C759 88          DEY                    ;\
$91:C75A 88          DEY                    ;} Y -= 2
$91:C75B 10 EB       BPL $EB    [$C748]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C75D 80 1E       BRA $1E    [$C77D]     ; Return

$91:C75F E2 20       SEP #$20               ;\
                                            ;|
$91:C761 A9 FF       LDA #$FF               ;|
$91:C763 97 00       STA [$00],y[$7E:98F9]  ;|
$91:C765 88          DEY                    ;} [$00]..([$00] + [Y]) = xx,FFh
$91:C766 88          DEY                    ;|
$91:C767 10 F8       BPL $F8    [$C761]     ;|
$91:C769 C2 20       REP #$20               ;/
$91:C76B AC 1E 0D    LDY $0D1E  [$7E:0D1E]  ; Y = [off-screen beam HDMA data table index]
$91:C76E F0 0D       BEQ $0D    [$C77D]     ; If [Y] = 0: return
$91:C770 88          DEY                    ;\
$91:C771 88          DEY                    ;} Y -= 2
$91:C772 30 09       BMI $09    [$C77D]     ; If [Y] < 0: return
$91:C774 A9 FF 00    LDA #$00FF             ;\
                                            ;|
$91:C777 97 00       STA [$00],y[$7E:985A]  ;|
$91:C779 88          DEY                    ;} [$00]..([$00] + [Y] + 1) = FFh, 00h
$91:C77A 88          DEY                    ;|
$91:C77B 10 FA       BPL $FA    [$C777]     ;/

$91:C77D 28          PLP
$91:C77E 60          RTS
}


;;; $C77F: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed upwards - beam is aimed up ;;;
{
;; Parameters:
;;     Y: ([Beam origin Y position] - 1) * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)

; This routine is never called, because x-ray is not allowed to be aimed upwards and morph ball eye isn't positioned to allow it.
$91:C77F 08          PHP
$91:C780 C2 30       REP #$30
$91:C782 5A          PHY                    ; Save Y

; LOOP_LEFT_ON_SCREEN
$91:C783 A5 22       LDA $22    [$7E:0022]  ;\
$91:C785 38          SEC                    ;|
$91:C786 E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C788 85 22       STA $22    [$7E:0022]  ;/
$91:C78A 90 0E       BCC $0E    [$C79A]     ; If [$22] >= 0:
$91:C78C E2 20       SEP #$20               ;\
$91:C78E A5 23       LDA $23    [$7E:0023]  ;|
$91:C790 97 00       STA [$00],y            ;} [$00] + [Y] = [$22] / 100h
$91:C792 C2 20       REP #$20               ;/
$91:C794 88          DEY                    ;\
$91:C795 88          DEY                    ;} Y -= 2
$91:C796 10 EB       BPL $EB    [$C783]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:C798 80 0C       BRA $0C    [$C7A6]     ; Go to BRANCH_LEFT_EDGE_END

$91:C79A E2 20       SEP #$20               ;\
                                            ;|
$91:C79C A9 00       LDA #$00               ;|
$91:C79E 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = FFh, xx
$91:C7A0 88          DEY                    ;|
$91:C7A1 88          DEY                    ;|
$91:C7A2 10 F8       BPL $F8    [$C79C]     ;/
$91:C7A4 C2 20       REP #$20

; BRANCH_LEFT_EDGE_END
$91:C7A6 7A          PLY                    ;\
$91:C7A7 C8          INY                    ;} Y = ([beam origin Y position] - 1) * 2 + 1

; LOOP_RIGHT_ON_SCREEN
$91:C7A8 A5 24       LDA $24    [$7E:0024]  ;\
$91:C7AA 18          CLC                    ;|
$91:C7AB 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C7AD 85 24       STA $24    [$7E:0024]  ;/
$91:C7AF B0 0E       BCS $0E    [$C7BF]     ; If [$24] < 10000h:
$91:C7B1 E2 20       SEP #$20               ;\
$91:C7B3 A5 25       LDA $25    [$7E:0025]  ;|
$91:C7B5 97 00       STA [$00],y            ;} [$00] + [Y] = [$24] / 100h
$91:C7B7 C2 20       REP #$20               ;/
$91:C7B9 88          DEY                    ;\
$91:C7BA 88          DEY                    ;} Y -= 2
$91:C7BB 10 EB       BPL $EB    [$C7A8]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C7BD 80 0A       BRA $0A    [$C7C9]     ; Return

$91:C7BF E2 20       SEP #$20               ;\
                                            ;|
$91:C7C1 A9 FF       LDA #$FF               ;|
$91:C7C3 97 00       STA [$00],y            ;} [$00]..([$00] + [Y]) = xx,FFh
$91:C7C5 88          DEY                    ;|
$91:C7C6 88          DEY                    ;|
$91:C7C7 10 F8       BPL $F8    [$C7C1]     ;/

$91:C7C9 28          PLP
$91:C7CA 60          RTS
}


;;; $C7CB: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed upwards - beam is aimed up-left ;;;
{
;; Parameters:
;;     Y: ([Beam origin Y position] - 1) * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C7CB 08          PHP
$91:C7CC C2 30       REP #$30
$91:C7CE 5A          PHY                    ; Save Y

; LOOP_LEFT_ON_SCREEN
$91:C7CF A5 22       LDA $22    [$7E:0022]  ;\
$91:C7D1 38          SEC                    ;|
$91:C7D2 E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C7D4 85 22       STA $22    [$7E:0022]  ;/
$91:C7D6 90 0E       BCC $0E    [$C7E6]     ; If [$22] >= 0:
$91:C7D8 E2 20       SEP #$20               ;\
$91:C7DA A5 23       LDA $23    [$7E:0023]  ;|
$91:C7DC 97 00       STA [$00],y[$7E:9946]  ;} [$00] + [Y] = [$22] / 100h
$91:C7DE C2 20       REP #$20               ;/
$91:C7E0 88          DEY                    ;\
$91:C7E1 88          DEY                    ;} Y -= 2
$91:C7E2 10 EB       BPL $EB    [$C7CF]     ; If [Y] >= 0: go to LOOP_LEFT_ON_SCREEN
$91:C7E4 80 0C       BRA $0C    [$C7F2]

$91:C7E6 E2 20       SEP #$20               ;\
$91:C7E8 A9 00       LDA #$00               ;|
                                            ;|
$91:C7EA 97 00       STA [$00],y[$7E:9942]  ;} [$00]..([$00] + [Y]) = FFh, xx
$91:C7EC 88          DEY                    ;|
$91:C7ED 88          DEY                    ;|
$91:C7EE 10 FA       BPL $FA    [$C7EA]     ;/
$91:C7F0 C2 20       REP #$20

; BRANCH_LEFT_EDGE_END
$91:C7F2 7A          PLY                    ;\
$91:C7F3 C8          INY                    ;} Y = ([beam origin Y position] - 1) * 2 + 1

; LOOP_RIGHT_ON_SCREEN
$91:C7F4 A5 24       LDA $24    [$7E:0024]  ;\
$91:C7F6 38          SEC                    ;|
$91:C7F7 E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C7F9 85 24       STA $24    [$7E:0024]  ;/
$91:C7FB 90 0E       BCC $0E    [$C80B]     ; If [$24] < 0:
$91:C7FD E2 20       SEP #$20               ;\
$91:C7FF A5 25       LDA $25    [$7E:0025]  ;|
$91:C801 97 00       STA [$00],y[$7E:9947]  ;} [$00] + [Y] = [$24] / 100h
$91:C803 C2 20       REP #$20               ;/
$91:C805 88          DEY                    ;\
$91:C806 88          DEY                    ;} Y -= 2
$91:C807 10 EB       BPL $EB    [$C7F4]     ; If [Y] >= 0: go to LOOP_RIGHT_ON_SCREEN
$91:C809 80 15       BRA $15    [$C820]     ; Return

$91:C80B E2 20       SEP #$20
$91:C80D 5A          PHY                    ;\
$91:C80E A9 00       LDA #$00               ;|
                                            ;|
$91:C810 97 00       STA [$00],y[$7E:98A1]  ;|
$91:C812 88          DEY                    ;|
$91:C813 88          DEY                    ;|
$91:C814 10 FA       BPL $FA    [$C810]     ;|
$91:C816 7A          PLY                    ;} [$00]..([$00] + [Y]) = FFh,00h
$91:C817 88          DEY                    ;|
$91:C818 A9 FF       LDA #$FF               ;|
                                            ;|
$91:C81A 97 00       STA [$00],y[$7E:98A0]  ;|
$91:C81C 88          DEY                    ;|
$91:C81D 88          DEY                    ;|
$91:C81E 10 FA       BPL $FA    [$C81A]     ;/

$91:C820 28          PLP
$91:C821 60          RTS
}


;;; $C822: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed downwards ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
;;     $1A: Beam left edge angle
;;     $1C: Beam right edge angle
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
$91:C822 08          PHP
$91:C823 C2 30       REP #$30
$91:C825 A5 18       LDA $18    [$7E:0018]  ;\
$91:C827 3A          DEC A                  ;|
$91:C828 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C829 A8          TAY                    ;/
$91:C82A E2 20       SEP #$20               ;\
$91:C82C A5 17       LDA $17    [$7E:0017]  ;|
$91:C82E 97 00       STA [$00],y[$7E:918E]  ;|
$91:C830 C8          INY                    ;} [$00] + [Y] = [beam origin X position], [beam origin X position]
$91:C831 A5 17       LDA $17    [$7E:0017]  ;|
$91:C833 97 00       STA [$00],y[$7E:918F]  ;|
$91:C835 C2 20       REP #$20               ;/
$91:C837 C8          INY                    ; Y += 2
$91:C838 A5 16       LDA $16    [$7E:0016]  ;\
$91:C83A 85 22       STA $22    [$7E:0022]  ;} $22 = [beam origin X position * 100h]
$91:C83C 85 24       STA $24    [$7E:0024]  ; $24 = [beam origin X position * 100h]
$91:C83E A5 1C       LDA $1C    [$7E:001C]  ;\
$91:C840 C9 80 00    CMP #$0080             ;} If [beam right edge angle] < 80h:
$91:C843 10 05       BPL $05    [$C84A]     ;/
$91:C845 A2 00 00    LDX #$0000             ; X = 0
$91:C848 80 0F       BRA $0F    [$C859]     ; Go to BRANCH_MERGE

$91:C84A A5 1A       LDA $1A    [$7E:001A]  ;\
$91:C84C C9 80 00    CMP #$0080             ;} If [beam left edge angle] < 80h:
$91:C84F 10 05       BPL $05    [$C856]     ;/
$91:C851 A2 02 00    LDX #$0002             ; X = 2
$91:C854 80 03       BRA $03    [$C859]     ; Go to BRANCH_MERGE

$91:C856 A2 04 00    LDX #$0004             ; X = 4

; BRANCH_MERGE
$91:C859 FC 74 C8    JSR ($C874,x)[$91:C87A]; Execute [$C874 + [X]]
$91:C85C A5 18       LDA $18    [$7E:0018]  ;\
$91:C85E 3A          DEC A                  ;|
$91:C85F 3A          DEC A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C860 0A          ASL A                  ;|
$91:C861 A8          TAY                    ;/

; LOOP
$91:C862 B7 00       LDA [$00],y[$7E:918C]  ;\
$91:C864 C9 FF 00    CMP #$00FF             ;} If [[$00] + [Y]] != FFh, 00h:
$91:C867 F0 09       BEQ $09    [$C872]     ;/
$91:C869 A9 FF 00    LDA #$00FF             ;\
$91:C86C 97 00       STA [$00],y[$7E:98FC]  ;} [$00] + [Y] = FFh, 00h
$91:C86E 88          DEY                    ;\
$91:C86F 88          DEY                    ;} Y -= 2
$91:C870 10 F0       BPL $F0    [$C862]     ; If [Y] >= 0: go to LOOP

$91:C872 28          PLP
$91:C873 60          RTS

$91:C874             dw C87A, C8E8, C939
}


;;; $C87A: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed downwards - beam is aimed down-right ;;;
{
;; Parameters:
;;     Y: [Beam origin Y position] * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C87A 08          PHP
$91:C87B C2 30       REP #$30
$91:C87D 5A          PHY                    ; Save Y

; LOOP_RIGHT_ON_SCREEN
$91:C87E A5 24       LDA $24    [$7E:0024]  ;\
$91:C880 18          CLC                    ;|
$91:C881 65 20       ADC $20    [$7E:0020]  ;} $24 += [beam right edge gradient * 100h]
$91:C883 85 24       STA $24    [$7E:0024]  ;/
$91:C885 B0 0D       BCS $0D    [$C894]     ; If [$24] < 10000h:
$91:C887 A5 25       LDA $25    [$7E:0025]  ;\
$91:C889 97 00       STA [$00],y[$7E:9190]  ;} [$00] + [Y] = [$24] / 100h
$91:C88B C8          INY                    ;\
$91:C88C C8          INY                    ;} Y += 2
$91:C88D C0 CC 01    CPY #$01CC             ;\
$91:C890 30 EC       BMI $EC    [$C87E]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C892 80 0F       BRA $0F    [$C8A3]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C894 8C 1E 0D    STY $0D1E  [$7E:0D1E]  ; Off-screen beam HDMA data table index = [Y]
$91:C897 A9 FF 00    LDA #$00FF             ;\
                                            ;|
$91:C89A 97 00       STA [$00],y[$7E:92A4]  ;|
$91:C89C C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C89D C8          INY                    ;|
$91:C89E C0 CC 01    CPY #$01CC             ;|
$91:C8A1 30 F7       BMI $F7    [$C89A]     ;/

; BRANCH_RIGHT_EDGE_END                     ;\
$91:C8A3 7A          PLY                    ;} Y = [beam origin Y position] * 2 + 1
$91:C8A4 C8          INY

; LOOP_LEFT_ON_SCREEN
$91:C8A5 A5 22       LDA $22    [$7E:0022]  ;\
$91:C8A7 18          CLC                    ;|
$91:C8A8 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C8AA 85 22       STA $22    [$7E:0022]  ;/
$91:C8AC B0 11       BCS $11    [$C8BF]     ; If [$22] < 10000h:
$91:C8AE E2 20       SEP #$20               ;\
$91:C8B0 A5 23       LDA $23    [$7E:0023]  ;|
$91:C8B2 97 00       STA [$00],y[$7E:9191]  ;} [$00] + [Y] = [$22] / 100h
$91:C8B4 C2 20       REP #$20               ;/
$91:C8B6 C8          INY                    ;\
$91:C8B7 C8          INY                    ;} Y += 2
$91:C8B8 C0 CC 01    CPY #$01CC             ;\
$91:C8BB 30 E8       BMI $E8    [$C8A5]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C8BD 80 27       BRA $27    [$C8E6]     ; Go to BRANCH_LEFT_EDGE_END

$91:C8BF E2 20       SEP #$20               ;\
                                            ;|
$91:C8C1 A9 FF       LDA #$FF               ;|
$91:C8C3 97 00       STA [$00],y[$7E:92A5]  ;|
$91:C8C5 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CCh) = xx, FFh
$91:C8C6 C8          INY                    ;|
$91:C8C7 C0 CC 01    CPY #$01CC             ;|
$91:C8CA 30 F5       BMI $F5    [$C8C1]     ;/
$91:C8CC C2 20       REP #$20
$91:C8CE AC 1E 0D    LDY $0D1E  [$7E:0D1E]  ; Y = [off-screen beam HDMA data table index]
$91:C8D1 F0 13       BEQ $13    [$C8E6]     ; If [Y] = 0: return
$91:C8D3 C8          INY                    ;\
$91:C8D4 C8          INY                    ;} Y += 2
$91:C8D5 C0 CC 01    CPY #$01CC             ;\
$91:C8D8 10 0C       BPL $0C    [$C8E6]     ;} If [Y] >= 1CCh: return
$91:C8DA A9 FF 00    LDA #$00FF             ;\
                                            ;|
$91:C8DD 97 00       STA [$00],y[$7E:92A6]  ;|
$91:C8DF C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C8E0 C8          INY                    ;|
$91:C8E1 C0 CC 01    CPY #$01CC             ;|
$91:C8E4 30 F7       BMI $F7    [$C8DD]     ;/

$91:C8E6 28          PLP
$91:C8E7 60          RTS
}


;;; $C8E8: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed downwards - beam is aimed down ;;;
{
;; Parameters:
;;     Y: [Beam origin Y position] * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C8E8 08          PHP
$91:C8E9 C2 30       REP #$30
$91:C8EB 5A          PHY                    ; Save Y

; LOOP_RIGHT_ON_SCREEN
$91:C8EC A5 24       LDA $24    [$7E:0024]  ;\
$91:C8EE 38          SEC                    ;|
$91:C8EF E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C8F1 85 24       STA $24    [$7E:0024]  ;/
$91:C8F3 90 0D       BCC $0D    [$C902]     ; If [$24] >= 0:
$91:C8F5 A5 25       LDA $25    [$7E:0025]  ;\
$91:C8F7 97 00       STA [$00],y[$7E:91D0]  ;} [$00] + [Y] = [$24] / 100h
$91:C8F9 C8          INY                    ;\
$91:C8FA C8          INY                    ;} Y += 2
$91:C8FB C0 CC 01    CPY #$01CC             ;\
$91:C8FE 30 EC       BMI $EC    [$C8EC]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C900 80 0C       BRA $0C    [$C90E]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C902 A9 00 00    LDA #$0000             ;\
$91:C905 97 00       STA [$00],y            ;|
$91:C907 C8          INY                    ;|
$91:C908 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = 00h, 00h
$91:C909 C0 CC 01    CPY #$01CC             ;|
$91:C90C 30 F4       BMI $F4    [$C902]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C90E 7A          PLY                    ;\
$91:C90F C8          INY                    ;} Y = [beam origin Y position] * 2 + 1

; LOOP_LEFT_ON_SCREEN
$91:C910 A5 22       LDA $22    [$7E:0022]  ;\
$91:C912 18          CLC                    ;|
$91:C913 65 1E       ADC $1E    [$7E:001E]  ;} $22 += [beam left edge gradient * 100h]
$91:C915 85 22       STA $22    [$7E:0022]  ;/
$91:C917 B0 11       BCS $11    [$C92A]     ; If [$22] < 10000h:
$91:C919 E2 20       SEP #$20               ;\
$91:C91B A5 23       LDA $23    [$7E:0023]  ;|
$91:C91D 97 00       STA [$00],y[$7E:91D1]  ;} [$00] + [Y] = [$22] / 100h
$91:C91F C2 20       REP #$20               ;/
$91:C921 C8          INY                    ;\
$91:C922 C8          INY                    ;} Y += 2
$91:C923 C0 CC 01    CPY #$01CC             ;\
$91:C926 30 E8       BMI $E8    [$C910]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C928 80 0D       BRA $0D    [$C937]     ; Return

$91:C92A E2 20       SEP #$20               ;\
                                            ;|
$91:C92C A9 FF       LDA #$FF               ;|
$91:C92E 97 00       STA [$00],y            ;|
$91:C930 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, xx
$91:C931 C8          INY                    ;|
$91:C932 C0 CC 01    CPY #$01CC             ;|
$91:C935 30 F5       BMI $F5    [$C92C]     ;/

$91:C937 28          PLP
$91:C938 60          RTS
}


;;; $C939: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is aimed downwards - beam is aimed down-left ;;;
{
;; Parameters:
;;     Y: [Beam origin Y position] * 2
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $1E: Beam left edge gradient * 100h (dx/dy)
;;     $20: Beam right edge gradient * 100h (dx/dy)
;;     $22: Beam origin X position * 100h
;;     $24: Beam origin X position * 100h

; Current left line co-ordinates = ([$22], [Y] / 2)
; Current right line co-ordinates = ([$24], [Y] / 2)
$91:C939 08          PHP
$91:C93A C2 30       REP #$30
$91:C93C 5A          PHY                    ; Save Y

; LOOP_RIGHT_ON_SCREEN
$91:C93D A5 24       LDA $24    [$7E:0024]  ;\
$91:C93F 38          SEC                    ;|
$91:C940 E5 20       SBC $20    [$7E:0020]  ;} $24 -= [beam right edge gradient * 100h]
$91:C942 85 24       STA $24    [$7E:0024]  ;/
$91:C944 90 0D       BCC $0D    [$C953]     ; If [$24] >= 0:
$91:C946 A5 25       LDA $25    [$7E:0025]  ;\
$91:C948 97 00       STA [$00],y[$7E:91D0]  ;} [$00] + [Y] = [$24] / 100h
$91:C94A C8          INY                    ;\
$91:C94B C8          INY                    ;} Y += 2
$91:C94C C0 CC 01    CPY #$01CC             ;\
$91:C94F 30 EC       BMI $EC    [$C93D]     ;} If [Y] < 1CCh: go to LOOP_RIGHT_ON_SCREEN
$91:C951 80 0C       BRA $0C    [$C95F]     ; Go to BRANCH_RIGHT_EDGE_END

$91:C953 A9 00 00    LDA #$0000             ;\
$91:C956 97 00       STA [$00],y[$7E:9904]  ;|
$91:C958 C8          INY                    ;|
$91:C959 C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = 00h, 00h
$91:C95A C0 CC 01    CPY #$01CC             ;|
$91:C95D 30 F4       BMI $F4    [$C953]     ;/

; BRANCH_RIGHT_EDGE_END
$91:C95F 7A          PLY                    ;\
$91:C960 C8          INY                    ;} Y = [beam origin Y position] * 2 + 1

; LOOP_LEFT_ON_SCREEN
$91:C961 A5 22       LDA $22    [$7E:0022]  ;\
$91:C963 38          SEC                    ;|
$91:C964 E5 1E       SBC $1E    [$7E:001E]  ;} $22 -= [beam left edge gradient * 100h]
$91:C966 85 22       STA $22    [$7E:0022]  ;/
$91:C968 90 11       BCC $11    [$C97B]     ; If [$22] >= 0:
$91:C96A E2 20       SEP #$20               ;\
$91:C96C A5 23       LDA $23    [$7E:0023]  ;|
$91:C96E 97 00       STA [$00],y[$7E:91D1]  ;} [$00] + [Y] = [$22] / 100h
$91:C970 C2 20       REP #$20               ;/
$91:C972 C8          INY                    ;\
$91:C973 C8          INY                    ;} Y += 2
$91:C974 C0 CC 01    CPY #$01CC             ;\
$91:C977 30 E8       BMI $E8    [$C961]     ;} If [Y] < 1CCh: go to LOOP_LEFT_ON_SCREEN
$91:C979 80 1B       BRA $1B    [$C996]     ; Go to BRANCH_LEFT_EDGE_END

$91:C97B E2 20       SEP #$20               ;\
$91:C97D 5A          PHY                    ;|
$91:C97E A9 00       LDA #$00               ;|
                                            ;|
$91:C980 97 00       STA [$00],y[$7E:9975]  ;|
$91:C982 C8          INY                    ;|
$91:C983 C8          INY                    ;|
$91:C984 C0 CC 01    CPY #$01CC             ;|
$91:C987 30 F7       BMI $F7    [$C980]     ;|
$91:C989 7A          PLY                    ;} ([$00] + [Y] - 1)..([$00] + 1CCh) = FFh, 00h
$91:C98A 88          DEY                    ;|
$91:C98B A9 FF       LDA #$FF               ;|
                                            ;|
$91:C98D 97 00       STA [$00],y[$7E:9974]  ;|
$91:C98F C8          INY                    ;|
$91:C990 C8          INY                    ;|
$91:C991 C0 CC 01    CPY #$01CC             ;|
$91:C994 30 F7       BMI $F7    [$C98D]     ;/

$91:C996 28          PLP
$91:C997 60          RTS
}


;;; $C998: Calculate x-ray / morph ball eye beam HDMA data table - origin is on screen - beam is horizontal line ;;;
{
;; Parameters:
;;     $00: HDMA data table pointer. $7E:9100 for morph ball eye beam, $7E:9800 for x-ray
;;     $12: Beam angle
;;     $16: Beam origin X position * 100h
;;     $18: Beam origin Y position
$91:C998 08          PHP
$91:C999 C2 30       REP #$30
$91:C99B A5 18       LDA $18    [$7E:0018]  ;\
$91:C99D 3A          DEC A                  ;|
$91:C99E 0A          ASL A                  ;} Y = ([beam origin Y position] - 1) * 2
$91:C99F A8          TAY                    ;/
$91:C9A0 A5 12       LDA $12    [$7E:0012]  ;\
$91:C9A2 C9 40 00    CMP #$0040             ;} If [beam angle] = 40h:
$91:C9A5 D0 09       BNE $09    [$C9B0]     ;/
$91:C9A7 A5 17       LDA $17    [$7E:0017]  ;\
$91:C9A9 09 00 FF    ORA #$FF00             ;} [$00] + [Y] = [beam origin X position], FFh
$91:C9AC 97 00       STA [$00],y[$7E:9894]  ;/
$91:C9AE 80 07       BRA $07    [$C9B7]

$91:C9B0 A5 16       LDA $16    [$7E:0016]  ;\ Else ([beam angle] != 40h):
$91:C9B2 29 00 FF    AND #$FF00             ;} [$00] + [Y] = 00h, [beam origin X position]
$91:C9B5 97 00       STA [$00],y[$7E:98FE]  ;/

$91:C9B7 88          DEY                    ;\
$91:C9B8 88          DEY                    ;} Y -= 2
$91:C9B9 A9 FF 00    LDA #$00FF             ;\
                                            ;|
$91:C9BC 97 00       STA [$00],y[$7E:98FC]  ;|
$91:C9BE 88          DEY                    ;} [$00]..([$00] + [Y] + 1) = FFh, 00h
$91:C9BF 88          DEY                    ;|
$91:C9C0 10 FA       BPL $FA    [$C9BC]     ;/
$91:C9C2 A5 18       LDA $18    [$7E:0018]  ;\
$91:C9C4 0A          ASL A                  ;} Y = [beam origin Y position] * 2
$91:C9C5 A8          TAY                    ;/
$91:C9C6 A9 FF 00    LDA #$00FF             ;\
                                            ;|
$91:C9C9 97 00       STA [$00],y[$7E:9900]  ;|
$91:C9CB C8          INY                    ;} ([$00] + [Y])..([$00] + 1CBh) = FFh, 00h
$91:C9CC C8          INY                    ;|
$91:C9CD C0 CC 01    CPY #$01CC             ;|
$91:C9D0 30 F7       BMI $F7    [$C9C9]     ;/
$91:C9D2 28          PLP
$91:C9D3 60          RTS
}
}


;;; $C9D4: Absolute tangent table ;;;
{
; |tan(t * pi / 80h)| * 100h
; Recall that SM angles are measured clockwise with 0 = up
; So this table provides absolute dx/dy gradients for angle t * pi / 80h
$91:C9D4             dw 0000, 0006, 000C, 0012, 0019, 001F, 0025, 002C, 0032, 0039, 0040, 0046, 004D, 0054, 005B, 0062,
                        006A, 0071, 0079, 0080, 0088, 0091, 0099, 00A2, 00AB, 00B4, 00BD, 00C7, 00D2, 00DC, 00E8, 00F3,
                        0100, 010C, 011A, 0128, 0137, 0148, 0159, 016B, 017F, 0194, 01AB, 01C3, 01DE, 01FC, 021D, 0241,
                        026A, 0297, 02CB, 0306, 034B, 039D, 03FE, 0474, 0506, 05C3, 06BD, 081B, 0A27, 0D8E, 145A, 28BB,
                        3C00, 28BB, 145A, 0D8E, 0A27, 081B, 06BD, 05C3, 0506, 0474, 03FE, 039D, 034B, 0306, 02CB, 0297,
                        026A, 0241, 021D, 01FC, 01DE, 01C3, 01AB, 0194, 017F, 016B, 0159, 0148, 0137, 0128, 011A, 010C,
                        0100, 00F3, 00E8, 00DC, 00D2, 00C7, 00BD, 00B4, 00AB, 00A2, 0099, 0091, 0088, 0080, 0079, 0071,
                        006A, 0062, 005B, 0054, 004D, 0046, 0040, 0039, 0032, 002C, 0025, 001F, 0019, 0012, 000C, 0006
                        0000
}


;;; $CAD6..D4D9: X-ray ;;;
{
;;; $CAD6: X-ray handler ;;;
{
$91:CAD6 08          PHP
$91:CAD7 8B          PHB
$91:CAD8 4B          PHK                    ;\
$91:CAD9 AB          PLB                    ;} DB = $91
$91:CADA C2 30       REP #$30
$91:CADC AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$91:CADF D0 15       BNE $15    [$CAF6]     ;} If time is frozen: return
$91:CAE1 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:CAE3 2C B6 09    BIT $09B6  [$7E:09B6]  ;} If not pressing run: return
$91:CAE6 F0 0E       BEQ $0E    [$CAF6]     ;/
$91:CAE8 22 6D E1 91 JSL $91E16D[$91:E16D]  ; X-ray setup
$91:CAEC 90 08       BCC $08    [$CAF6]     ; If returned carry clear: return
$91:CAEE 22 35 84 88 JSL $888435[$88:8435]  ;\
$91:CAF2             dx 41, 28, D223        ;} Spawn x-ray HDMA object for indirect HDMA to window 2 left/right positions

$91:CAF6 AB          PLB
$91:CAF7 28          PLP
$91:CAF8 6B          RTL
}


;;; $CAF9: X-ray setup stage 1 - freeze time and backup BG2 registers ;;;
{
$91:CAF9 08          PHP
$91:CAFA E2 30       SEP #$30
$91:CAFC A9 01       LDA #$01               ;\
$91:CAFE 8D 78 0A    STA $0A78  [$7E:0A78]  ;} Time is frozen flag = x-ray is active
$91:CB01 A5 B5       LDA $B5    [$7E:00B5]  ;\
$91:CB03 9D 14 19    STA $1914,x[$7E:1918]  ;|
$91:CB06 A5 B6       LDA $B6    [$7E:00B6]  ;} HDMA object backup BG2 X scroll = [BG2 X scroll]
$91:CB08 9D 15 19    STA $1915,x[$7E:1919]  ;/
$91:CB0B A5 B7       LDA $B7    [$7E:00B7]  ;\
$91:CB0D 9D 20 19    STA $1920,x[$7E:1924]  ;|
$91:CB10 A5 B8       LDA $B8    [$7E:00B8]  ;} HDMA object backup BG2 Y scroll = [BG2 Y scroll]
$91:CB12 9D 21 19    STA $1921,x[$7E:1925]  ;/
$91:CB15 A5 59       LDA $59    [$7E:0059]  ;\
$91:CB17 9D 2C 19    STA $192C,x[$7E:1930]  ;} HDMA object backup BG2 tilemap base address and size = [BG2 tilemap base address and size]
$91:CB1A 28          PLP
$91:CB1B 6B          RTL
}


;;; $CB1C: X-ray setup stage 2 - read BG1 tilemap - 2nd screen ;;;
{
; Queue transfer of 800h bytes from VRAM BG1 tilemap base + 400h to $7E:6800
$91:CB1C 08          PHP
$91:CB1D C2 30       REP #$30
$91:CB1F AE 60 03    LDX $0360  [$7E:0360]
$91:CB22 A5 58       LDA $58    [$7E:0058]
$91:CB24 29 FC 00    AND #$00FC
$91:CB27 EB          XBA
$91:CB28 18          CLC
$91:CB29 69 00 04    ADC #$0400
$91:CB2C 9D 40 03    STA $0340,x[$7E:0340]
$91:CB2F A9 81 00    LDA #$0081
$91:CB32 9D 42 03    STA $0342,x[$7E:0342]
$91:CB35 A9 39 00    LDA #$0039
$91:CB38 9D 43 03    STA $0343,x[$7E:0343]
$91:CB3B A9 00 68    LDA #$6800
$91:CB3E 9D 44 03    STA $0344,x[$7E:0344]
$91:CB41 A9 7E 00    LDA #$007E
$91:CB44 9D 46 03    STA $0346,x[$7E:0346]
$91:CB47 A9 00 08    LDA #$0800
$91:CB4A 9D 47 03    STA $0347,x[$7E:0347]
$91:CB4D 8A          TXA
$91:CB4E 18          CLC
$91:CB4F 69 09 00    ADC #$0009
$91:CB52 8D 60 03    STA $0360  [$7E:0360]
$91:CB55 28          PLP
$91:CB56 6B          RTL
}


;;; $CB57: X-ray setup stage 3 - read BG1 tilemap - 1st screen ;;;
{
; Queue transfer of 800h bytes from VRAM BG1 tilemap base to $7E:6000
$91:CB57 08          PHP
$91:CB58 C2 30       REP #$30
$91:CB5A AE 60 03    LDX $0360  [$7E:0360]
$91:CB5D A5 58       LDA $58    [$7E:0058]
$91:CB5F 29 FC 00    AND #$00FC
$91:CB62 EB          XBA
$91:CB63 9D 40 03    STA $0340,x[$7E:0340]
$91:CB66 A9 81 00    LDA #$0081
$91:CB69 9D 42 03    STA $0342,x[$7E:0342]
$91:CB6C A9 39 00    LDA #$0039
$91:CB6F 9D 43 03    STA $0343,x[$7E:0343]
$91:CB72 A9 00 60    LDA #$6000
$91:CB75 9D 44 03    STA $0344,x[$7E:0344]
$91:CB78 A9 7E 00    LDA #$007E
$91:CB7B 9D 46 03    STA $0346,x[$7E:0346]
$91:CB7E A9 00 08    LDA #$0800
$91:CB81 9D 47 03    STA $0347,x[$7E:0347]
$91:CB84 8A          TXA
$91:CB85 18          CLC
$91:CB86 69 09 00    ADC #$0009
$91:CB89 8D 60 03    STA $0360  [$7E:0360]
$91:CB8C 28          PLP
$91:CB8D 6B          RTL
}


;;; $CB8E: X-ray setup stage 4 - build x-ray BG2 tilemap, read BG2 tilemap - 1st screen ;;;
{
; Calls $84:831A to load item x-ray blocks
$91:CB8E 08          PHP
$91:CB8F C2 30       REP #$30
$91:CB91 AD 1F 09    LDA $091F  [$7E:091F]  ;\
$91:CB94 18          CLC                    ;|
$91:CB95 6D 15 09    ADC $0915  [$7E:0915]  ;|
$91:CB98 29 F0 00    AND #$00F0             ;|
$91:CB9B 0A          ASL A                  ;|
$91:CB9C 0A          ASL A                  ;|
$91:CB9D 85 18       STA $18    [$7E:0018]  ;|
$91:CB9F AD 1D 09    LDA $091D  [$7E:091D]  ;|
$91:CBA2 18          CLC                    ;|
$91:CBA3 6D 11 09    ADC $0911  [$7E:0911]  ;|
$91:CBA6 29 F0 00    AND #$00F0             ;|
$91:CBA9 4A          LSR A                  ;} $18 (BG1 row origin block index) =
$91:CBAA 4A          LSR A                  ;}       (([BG1 Y offset] + [layer 1 Y position]) / 8 & 1Eh) * 20h (20h tiles per tilemap row, rounded down to top-left of 16x16 block)
$91:CBAB 4A          LSR A                  ;}     + (([BG1 X offset] + [layer 1 X position]) / 8 & 1Eh)       (1 byte per tilemap column, rounded down to top-left of 16x16 block)
$91:CBAC 18          CLC                    ;}     + ([BG1 X offset] + [layer 1 X position]) / 100h % 2 * 400h (400h tiles per tilemap screen)
$91:CBAD 65 18       ADC $18    [$7E:0018]  ;|
$91:CBAF 85 18       STA $18    [$7E:0018]  ;|
$91:CBB1 AD 1D 09    LDA $091D  [$7E:091D]  ;|
$91:CBB4 18          CLC                    ;|
$91:CBB5 6D 11 09    ADC $0911  [$7E:0911]  ;|
$91:CBB8 29 00 01    AND #$0100             ;|
$91:CBBB 0A          ASL A                  ;|
$91:CBBC 0A          ASL A                  ;|
$91:CBBD 18          CLC                    ;|
$91:CBBE 65 18       ADC $18    [$7E:0018]  ;|
$91:CBC0 85 18       STA $18    [$7E:0018]  ;/
$91:CBC2 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (x-ray BG2 tilemap index)
$91:CBC4 A9 10 00    LDA #$0010             ;\
$91:CBC7 85 14       STA $14    [$7E:0014]  ;} $14 = 10h (row loop counter)

; LOOP_COPY_BG1_ROW
$91:CBC9 A9 10 00    LDA #$0010             ;\
$91:CBCC 85 12       STA $12    [$7E:0012]  ;} $12 = 10h (column loop counter)
$91:CBCE A5 18       LDA $18    [$7E:0018]  ;\
$91:CBD0 29 E0 07    AND #$07E0             ;} $1A = [BG1 row origin block index] & 7E0h (BG1 row origin block row index)
$91:CBD3 85 1A       STA $1A    [$7E:001A]  ;/
$91:CBD5 A5 18       LDA $18    [$7E:0018]  ;\
$91:CBD7 29 1F 00    AND #$001F             ;} $1C = [BG1 row origin block index] & 1Fh (BG1 row origin block column index)
$91:CBDA 85 1C       STA $1C    [$7E:001C]  ;/
$91:CBDC 64 1E       STZ $1E    [$7E:001E]  ; $1E = 0 (BG1 block X offset)

; LOOP_COPY_BG1_COLUMN
$91:CBDE A5 1C       LDA $1C    [$7E:001C]  ;\
$91:CBE0 18          CLC                    ;|
$91:CBE1 65 1E       ADC $1E    [$7E:001E]  ;} If [BG1 row origin block column index] + [BG1 block X offset] >= 20h (reached end of tilemap screen):
$91:CBE3 C9 20 00    CMP #$0020             ;|
$91:CBE6 30 12       BMI $12    [$CBFA]     ;/
$91:CBE8 A5 1A       LDA $1A    [$7E:001A]  ;\
$91:CBEA 18          CLC                    ;|
$91:CBEB 69 00 04    ADC #$0400             ;} BG1 row origin block row index = [BG1 row origin block row index] + 400h & 7E0h (switch tilemap screens)
$91:CBEE 29 E0 07    AND #$07E0             ;|
$91:CBF1 85 1A       STA $1A    [$7E:001A]  ;/
$91:CBF3 A9 00 00    LDA #$0000             ;\
$91:CBF6 85 1C       STA $1C    [$7E:001C]  ;} BG1 row origin block column index = 0
$91:CBF8 85 1E       STA $1E    [$7E:001E]  ; BG1 block X offset = 0

$91:CBFA A5 1A       LDA $1A    [$7E:001A]  ;\
$91:CBFC 18          CLC                    ;|
$91:CBFD 65 1C       ADC $1C    [$7E:001C]  ;|
$91:CBFF 65 1E       ADC $1E    [$7E:001E]  ;} X = ([BG1 row origin block row index] + [BG1 row origin block column index] + [BG1 block X offset]) * 2
$91:CC01 0A          ASL A                  ;|
$91:CC02 AA          TAX                    ;/
$91:CC03 BF 00 60 7E LDA $7E6000,x[$7E:650C];\
$91:CC07 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] = [$7E:6000 + [X]]
$91:CC08 BF 02 60 7E LDA $7E6002,x[$7E:650E]; \
$91:CC0C 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 2 = [$7E:6000 + [X] + 2]
$91:CC0D BF 40 60 7E LDA $7E6040,x[$7E:654C];  \
$91:CC11 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + 40h = [$7E:6000 + [X] + 40h]
$91:CC12 BF 42 60 7E LDA $7E6042,x[$7E:654E];   \
$91:CC16 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + 42h = [$7E:6000 + [X] + 42h]
$91:CC18 9F 42 40 7E STA $7E4042,x[$7E:4042];   /
$91:CC1C 68          PLA                    ;  |
$91:CC1D 9F 40 40 7E STA $7E4040,x[$7E:4040];  /
$91:CC21 68          PLA                    ; |
$91:CC22 9F 02 40 7E STA $7E4002,x[$7E:4002]; /
$91:CC26 68          PLA                    ;|
$91:CC27 9F 00 40 7E STA $7E4000,x[$7E:4000];/
$91:CC2B A5 16       LDA $16    [$7E:0016]  ;\
$91:CC2D 18          CLC                    ;|
$91:CC2E 69 04 00    ADC #$0004             ;} X-ray BG2 tilemap index += 4 (move right two tilemap columns)
$91:CC31 85 16       STA $16    [$7E:0016]  ;/
$91:CC33 A5 1E       LDA $1E    [$7E:001E]  ;\
$91:CC35 69 02 00    ADC #$0002             ;} BG1 block X offset += 2 (move right two tilemap columns)
$91:CC38 85 1E       STA $1E    [$7E:001E]  ;/
$91:CC3A C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$91:CC3C D0 A0       BNE $A0    [$CBDE]     ; If [$12] != 0: go to LOOP_COPY_BG1_COLUMN
$91:CC3E 20 F1 CC    JSR $CCF1  [$91:CCF1]  ; Copy last BG1 block of row to x-ray BG2 tilemap
$91:CC41 A5 18       LDA $18    [$7E:0018]  ;\
$91:CC43 29 00 04    AND #$0400             ;|
$91:CC46 85 20       STA $20    [$7E:0020]  ;|
$91:CC48 A5 18       LDA $18    [$7E:0018]  ;|
$91:CC4A 18          CLC                    ;} BG1 row origin block index = ([BG1 row origin block index] & 400h)
$91:CC4B 69 40 00    ADC #$0040             ;}                            + ([BG1 row origin block index] + 40h & 3FFh) (move down two tilemap rows)
$91:CC4E 29 FF 03    AND #$03FF             ;|
$91:CC51 18          CLC                    ;|
$91:CC52 65 20       ADC $20    [$7E:0020]  ;|
$91:CC54 85 18       STA $18    [$7E:0018]  ;/
$91:CC56 A5 16       LDA $16    [$7E:0016]  ;\
$91:CC58 18          CLC                    ;|
$91:CC59 69 40 00    ADC #$0040             ;} X-ray BG2 tilemap index += 40h (move down two tilemap rows)
$91:CC5C 85 16       STA $16    [$7E:0016]  ;/
$91:CC5E C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$91:CC60 F0 03       BEQ $03    [$CC65]     ; If [$14] != 0:
$91:CC62 4C C9 CB    JMP $CBC9  [$91:CBC9]  ; Go to LOOP_COPY_BG1_ROW

$91:CC65 AD 15 09    LDA $0915  [$7E:0915]  ;\
$91:CC68 4A          LSR A                  ;|
$91:CC69 4A          LSR A                  ;|
$91:CC6A 4A          LSR A                  ;|
$91:CC6B 4A          LSR A                  ;|
$91:CC6C EB          XBA                    ;|
$91:CC6D 0D A5 07    ORA $07A5  [$7E:07A5]  ;|
$91:CC70 8D 02 42    STA $4202              ;|
$91:CC73 AD 11 09    LDA $0911  [$7E:0911]  ;} $22 = [layer 1 Y position] / 10h * [room width in blocks] + [layer 1 X position] / 10h (block index)
$91:CC76 4A          LSR A                  ;|
$91:CC77 4A          LSR A                  ;|
$91:CC78 4A          LSR A                  ;|
$91:CC79 4A          LSR A                  ;|
$91:CC7A 18          CLC                    ;|
$91:CC7B 6D 16 42    ADC $4216              ;|
$91:CC7E 85 22       STA $22    [$7E:0022]  ;/
$91:CC80 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (x-ray BG2 tilemap index)
$91:CC82 A9 10 00    LDA #$0010             ;\
$91:CC85 85 14       STA $14    [$7E:0014]  ;} $14 = 10h (row loop counter)

; LOOP_REVEALED_ROW
$91:CC87 20 42 CD    JSR $CD42  [$91:CD42]  ; Load right half of revealed 2xN block
$91:CC8A A9 10 00    LDA #$0010             ;\
$91:CC8D 85 12       STA $12    [$7E:0012]  ;} $12 = 10h (column loop counter)
$91:CC8F A5 22       LDA $22    [$7E:0022]  ;\
$91:CC91 85 24       STA $24    [$7E:0024]  ;} $24 = (block index)

; LOOP_REVEALED_COLUMN
$91:CC93 20 BE CD    JSR $CDBE  [$91:CDBE]  ; Load revealed block
$91:CC96 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$91:CC98 D0 F9       BNE $F9    [$CC93]     ; If [$12] != 0: go to LOOP_REVEALED_COLUMN
$91:CC9A A5 16       LDA $16    [$7E:0016]  ;\
$91:CC9C 48          PHA                    ;} A = [$16]
$91:CC9D 18          CLC                    ;\
$91:CC9E 69 C0 07    ADC #$07C0             ;} $16 += 7C0h
$91:CCA1 85 16       STA $16    [$7E:0016]  ;/
$91:CCA3 20 BE CD    JSR $CDBE  [$91:CDBE]  ; Load revealed block
$91:CCA6 68          PLA                    ;\
$91:CCA7 18          CLC                    ;|
$91:CCA8 69 40 00    ADC #$0040             ;} $16 = [A] + 40h
$91:CCAB 85 16       STA $16    [$7E:0016]  ;/
$91:CCAD A5 22       LDA $22    [$7E:0022]  ;\
$91:CCAF 18          CLC                    ;|
$91:CCB0 6D A5 07    ADC $07A5  [$7E:07A5]  ;} (Block index) += [room width]
$91:CCB3 85 22       STA $22    [$7E:0022]  ;/
$91:CCB5 C6 14       DEC $14    [$7E:0014]  ; Decrement $14
$91:CCB7 D0 CE       BNE $CE    [$CC87]     ; If [$14] != 0: go to LOOP_REVEALED_ROW
$91:CCB9 22 1A 83 84 JSL $84831A[$84:831A]  ; Load item x-ray blocks
$91:CCBD AE 60 03    LDX $0360  [$7E:0360]  ;\
$91:CCC0 A5 59       LDA $59    [$7E:0059]  ;|
$91:CCC2 29 FC 00    AND #$00FC             ;|
$91:CCC5 EB          XBA                    ;|
$91:CCC6 9D 40 03    STA $0340,x[$7E:0340]  ;|
$91:CCC9 A9 81 00    LDA #$0081             ;|
$91:CCCC 9D 42 03    STA $0342,x[$7E:0342]  ;|
$91:CCCF A9 39 00    LDA #$0039             ;|
$91:CCD2 9D 43 03    STA $0343,x[$7E:0343]  ;|
$91:CCD5 A9 00 50    LDA #$5000             ;} Queue transfer of 800h bytes from VRAM BG2 tilemap base to $7E:5000
$91:CCD8 9D 44 03    STA $0344,x[$7E:0344]  ;|
$91:CCDB A9 7E 00    LDA #$007E             ;|
$91:CCDE 9D 46 03    STA $0346,x[$7E:0346]  ;|
$91:CCE1 A9 00 08    LDA #$0800             ;|
$91:CCE4 9D 47 03    STA $0347,x[$7E:0347]  ;|
$91:CCE7 8A          TXA                    ;|
$91:CCE8 18          CLC                    ;|
$91:CCE9 69 09 00    ADC #$0009             ;|
$91:CCEC 8D 60 03    STA $0360  [$7E:0360]  ;/
$91:CCEF 28          PLP
$91:CCF0 6B          RTL
}


;;; $CCF1: Copy last BG1 block of row to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     $16: X-ray BG2 tilemap index
;;     $1A: BG1 row origin block row index
;;     $1C: BG1 row origin block column index
;;     $1E: BG1 block X offset

; The last BG1 column is written to the first column of the second screen of BG2

$91:CCF1 A5 1A       LDA $1A    [$7E:001A]  ;\
$91:CCF3 85 20       STA $20    [$7E:0020]  ;} $20 = [BG1 row origin block row index]
$91:CCF5 A5 1C       LDA $1C    [$7E:001C]  ;\
$91:CCF7 18          CLC                    ;} A = [BG1 row origin block column index] + [BG1 block X offset]
$91:CCF8 65 1E       ADC $1E    [$7E:001E]  ;/
$91:CCFA C9 20 00    CMP #$0020             ;\
$91:CCFD 30 0E       BMI $0E    [$CD0D]     ;} If [A] >= 20h (reached end of tilemap screen):
$91:CCFF A5 20       LDA $20    [$7E:0020]  ;\
$91:CD01 18          CLC                    ;|
$91:CD02 69 00 04    ADC #$0400             ;} $20 = [BG1 row origin block row index] + 400h & 7E0h (switch tilemap screens)
$91:CD05 29 E0 07    AND #$07E0             ;|
$91:CD08 85 20       STA $20    [$7E:0020]  ;/
$91:CD0A A9 00 00    LDA #$0000             ; A = 0

$91:CD0D 18          CLC                    ;\
$91:CD0E 65 20       ADC $20    [$7E:0020]  ;|
$91:CD10 0A          ASL A                  ;} X = ([$20] + [A]) * 2
$91:CD11 AA          TAX                    ;/
$91:CD12 BF 00 60 7E LDA $7E6000,x[$7E:6D0C];\
$91:CD16 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h = [$7E:6000 + [X]]
$91:CD17 BF 02 60 7E LDA $7E6002,x[$7E:6D0E]; \
$91:CD1B 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h + 2 = [$7E:6000 + [X] + 2]
$91:CD1C BF 40 60 7E LDA $7E6040,x[$7E:6D4C];  \
$91:CD20 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h + 40h = [$7E:6000 + [X] + 40h]
$91:CD21 BF 42 60 7E LDA $7E6042,x[$7E:6D4E];   \
$91:CD25 48          PHA                    ;   } $7E:4000 + [x-ray BG2 tilemap index] - 40h + 800h + 42h = [$7E:6000 + [X] + 42h]
$91:CD26 A5 16       LDA $16    [$7E:0016]  ;   |
$91:CD28 18          CLC                    ;   |
$91:CD29 69 C0 07    ADC #$07C0             ;   |
$91:CD2C AA          TAX                    ;   |
$91:CD2D 68          PLA                    ;   |
$91:CD2E 9F 42 40 7E STA $7E4042,x[$7E:4842];   /
$91:CD32 68          PLA                    ;  |
$91:CD33 9F 40 40 7E STA $7E4040,x[$7E:4840];  /
$91:CD37 68          PLA                    ; |
$91:CD38 9F 02 40 7E STA $7E4002,x[$7E:4802]; /
$91:CD3C 68          PLA                    ;|
$91:CD3D 9F 00 40 7E STA $7E4000,x[$7E:4800];/
$91:CD41 60          RTS
}


;;; $CD42: Load right half of revealed 2xN block ;;;
{
;; Parameters:
;;     $16: X-ray BG2 tilemap index
;;     $22: Block index
$91:CD42 A6 22       LDX $22    [$7E:0022]  ;\
$91:CD44 CA          DEX                    ;} X = [$22] - 1
$91:CD45 20 D6 CD    JSR $CDD6  [$91:CDD6]  ; Load revealed block command (sets A, Y and $03)
$91:CD48 C9 4E CF    CMP #$CF4E             ;\
$91:CD4B F0 3C       BEQ $3C    [$CD89]     ;} If [A] = $CF4E: go to BRANCH_2x1
$91:CD4D C9 6F CF    CMP #$CF6F             ;\
$91:CD50 F0 01       BEQ $01    [$CD53]     ;} If [A] = $CF6F: go to BRANCH_2x2
$91:CD52 60          RTS                    ; Return

; BRANCH_2x2
$91:CD53 5A          PHY
$91:CD54 98          TYA                    ;\
$91:CD55 18          CLC                    ;|
$91:CD56 69 08 00    ADC #$0008             ;|
$91:CD59 A8          TAY                    ;|
$91:CD5A B1 03       LDA ($03),y            ;} X = [[$03] + 8] * 8 (fourth argument)
$91:CD5C 0A          ASL A                  ;|
$91:CD5D 0A          ASL A                  ;|
$91:CD5E 0A          ASL A                  ;|
$91:CD5F AA          TAX                    ;/
$91:CD60 BF 00 A0 7E LDA $7EA000,x          ;\
$91:CD64 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] + 80h = [$7E:A000 + [X]]
$91:CD65 BF 02 A0 7E LDA $7EA002,x          ; \
$91:CD69 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 82h = [$7E:A000 + [X] + 2]
$91:CD6A BF 04 A0 7E LDA $7EA004,x          ;  \
$91:CD6E 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + C0h = [$7E:A000 + [X] + 4]
$91:CD6F BF 06 A0 7E LDA $7EA006,x          ;   \
$91:CD73 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + C2h = [$7E:A000 + [X] + 8]
$91:CD75 9F C2 40 7E STA $7E40C2,x          ;   /
$91:CD79 68          PLA                    ;  |
$91:CD7A 9F C0 40 7E STA $7E40C0,x          ;  /
$91:CD7E 68          PLA                    ; |
$91:CD7F 9F 82 40 7E STA $7E4082,x          ; /
$91:CD83 68          PLA                    ;|
$91:CD84 9F 80 40 7E STA $7E4080,x          ;/
$91:CD88 7A          PLY

; BRANCH_2x1
$91:CD89 98          TYA                    ;\
$91:CD8A 18          CLC                    ;|
$91:CD8B 69 04 00    ADC #$0004             ;|
$91:CD8E A8          TAY                    ;|
$91:CD8F B1 03       LDA ($03),y            ;} X = [[$03] + 4] * 8 (second argument)
$91:CD91 0A          ASL A                  ;|
$91:CD92 0A          ASL A                  ;|
$91:CD93 0A          ASL A                  ;|
$91:CD94 AA          TAX                    ;/
$91:CD95 BF 00 A0 7E LDA $7EA000,x          ;\
$91:CD99 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] + 0 = [$7E:A000 + [X]]
$91:CD9A BF 02 A0 7E LDA $7EA002,x          ; \
$91:CD9E 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 2 = [$7E:A000 + [X] + 2]
$91:CD9F BF 04 A0 7E LDA $7EA004,x          ;  \
$91:CDA3 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + 40h = [$7E:A000 + [X] + 4]
$91:CDA4 BF 06 A0 7E LDA $7EA006,x          ;   \
$91:CDA8 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + 42h = [$7E:A000 + [X] + 8]
$91:CDAA 9F 42 40 7E STA $7E4042,x          ;   /
$91:CDAE 68          PLA                    ;  |
$91:CDAF 9F 40 40 7E STA $7E4040,x          ;  /
$91:CDB3 68          PLA                    ; |
$91:CDB4 9F 02 40 7E STA $7E4002,x          ; /
$91:CDB8 68          PLA                    ;|
$91:CDB9 9F 00 40 7E STA $7E4000,x          ;/
$91:CDBD 60          RTS
}


;;; $CDBE: Load revealed block ;;;
{
;; Parameters:
;;     $12: Tilemap column loop counter
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CDBE A6 24       LDX $24    [$7E:0024]  ; X = [block index]
$91:CDC0 20 D6 CD    JSR $CDD6  [$91:CDD6]  ; Load revealed block command (sets A, Y, $03, $26, $28)
$91:CDC3 C9 FF FF    CMP #$FFFF             ;\
$91:CDC6 F0 03       BEQ $03    [$CDCB]     ;} If [A] = FFFFh: go to load revealed block - done
$91:CDC8 6C 00 00    JMP ($0000)[$91:CF36]  ; Go to [[$00]]
}


;;; $CDCB: Load revealed block - done ;;;
{
;; Parameters:
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CDCB A5 16       LDA $16    [$7E:0016]  ;\
$91:CDCD 18          CLC                    ;|
$91:CDCE 69 04 00    ADC #$0004             ;} X-ray BG2 tilemap index += 4
$91:CDD1 85 16       STA $16    [$7E:0016]  ;/
$91:CDD3 E6 24       INC $24    [$7E:0024]  ; Increment block index
$91:CDD5 60          RTS
}


;;; $CDD6: Load revealed block command ;;;
{
;; Parameters:
;;     X: Block index
;; Returns:
;;     A/$00: Revealed block command or FFFFh if there is no block to reveal
;;     Y: 0 if [A] != FFFFh
;;     $03: Revealed block command pointer if [A] != FFFFh
;;     $26: Block BTS
;;     $28: Block type

$91:CDD6 BF 02 64 7F LDA $7F6402,x[$7F:7104];\
$91:CDDA 29 FF 00    AND #$00FF             ;} $26 = (block BTS)
$91:CDDD 85 26       STA $26    [$7E:0026]  ;/
$91:CDDF 8A          TXA                    ;\
$91:CDE0 0A          ASL A                  ;|
$91:CDE1 AA          TAX                    ;|
$91:CDE2 BF 02 00 7F LDA $7F0002,x[$7F:1A06];} $28 = (block type)
$91:CDE6 29 00 F0    AND #$F000             ;|
$91:CDE9 85 28       STA $28    [$7E:0028]  ;/
$91:CDEB A2 00 00    LDX #$0000             ; X = 0

; LOOP_BLOCK_TYPE
$91:CDEE BD D6 D2    LDA $D2D6,x[$91:D2D6]  ;\
$91:CDF1 C9 FF FF    CMP #$FFFF             ;} If [$D2D6 + [X]] = FFFFh: return
$91:CDF4 F0 35       BEQ $35    [$CE2B]     ;/
$91:CDF6 C5 28       CMP $28    [$7E:0028]  ;\
$91:CDF8 F0 06       BEQ $06    [$CE00]     ;} If [$D2D6 + [X]] != (block type):
$91:CDFA E8          INX                    ;\
$91:CDFB E8          INX                    ;|
$91:CDFC E8          INX                    ;} X += 4
$91:CDFD E8          INX                    ;/
$91:CDFE 80 EE       BRA $EE    [$CDEE]     ; Go to LOOP_BLOCK_TYPE

$91:CE00 BD D8 D2    LDA $D2D8,x[$91:D2D8]  ;\
$91:CE03 85 00       STA $00    [$7E:0000]  ;} $00 = [$D2D6 + [X] + 2] (revealed block table pointer)
$91:CE05 A0 00 00    LDY #$0000             ; Y = 0

; LOOP_BTS
$91:CE08 B1 00       LDA ($00),y[$91:D2FC]  ;\
$91:CE0A C9 FF FF    CMP #$FFFF             ;} If [[$00] + [Y]] = FFFFh: return
$91:CE0D F0 1C       BEQ $1C    [$CE2B]     ;/
$91:CE0F C9 00 FF    CMP #$FF00             ;\
$91:CE12 F0 0A       BEQ $0A    [$CE1E]     ;} If [[$00] + [Y]] != FF00h:
$91:CE14 C5 26       CMP $26    [$7E:0026]  ;\
$91:CE16 F0 06       BEQ $06    [$CE1E]     ;} If [[$00] + [Y]] != (block BTS):
$91:CE18 C8          INY                    ;\
$91:CE19 C8          INY                    ;|
$91:CE1A C8          INY                    ;} Y += 4
$91:CE1B C8          INY                    ;/
$91:CE1C 80 EA       BRA $EA    [$CE08]     ; Go to LOOP_BTS

$91:CE1E C8          INY                    ;\
$91:CE1F C8          INY                    ;|
$91:CE20 B1 00       LDA ($00),y[$91:D2FE]  ;} $03 = [[$00] + [Y] + 2] (revealed block command pointer)
$91:CE22 85 03       STA $03    [$7E:0003]  ;/
$91:CE24 A0 00 00    LDY #$0000             ;\
$91:CE27 B1 03       LDA ($03),y[$91:D302]  ;} A = $00 = [[$03]] (revealed block command)
$91:CE29 85 00       STA $00    [$7E:0000]  ;/

$91:CE2B 60          RTS
}


;;; $CE2C: Calculate block co-ordinates ;;;
{
;; Parameters:
;;     $24: Block index
;; Returns:
;;     $2A: X block co-ordinate
;;     $2C: Y block co-ordinate
 
; $2C = [$24] / [room width in blocks]
; $2A = [$24] % [room width in blocks]
$91:CE2C E2 20       SEP #$20
$91:CE2E A5 24       LDA $24    [$7E:0024]
$91:CE30 8D 04 42    STA $4204            
$91:CE33 A5 25       LDA $25    [$7E:0025]
$91:CE35 8D 05 42    STA $4205            
$91:CE38 AD A5 07    LDA $07A5  [$7E:07A5]
$91:CE3B 8D 06 42    STA $4206            
$91:CE3E C2 20       REP #$20
$91:CE40 EA          NOP
$91:CE41 EA          NOP
$91:CE42 EA          NOP
$91:CE43 EA          NOP
$91:CE44 EA          NOP
$91:CE45 EA          NOP
$91:CE46 AD 14 42    LDA $4214            
$91:CE49 85 2C       STA $2C    [$7E:002C]
$91:CE4B AD 16 42    LDA $4216            
$91:CE4E 85 2A       STA $2A    [$7E:002A]
$91:CE50 60          RTS
}


;;; $CE51: Get block type and BTS ;;;
{
;; Parameters:
;;     $2A: X block co-ordinate
;;     $2C: Y block co-ordinate
;; Returns:
;;     A/$30: Block type
;;     $2E: Block BTS
$91:CE51 A5 2C       LDA $2C    [$7E:002C]  ;\
$91:CE53 EB          XBA                    ;|
$91:CE54 0D A5 07    ORA $07A5  [$7E:07A5]  ;|
$91:CE57 8D 02 42    STA $4202              ;|
$91:CE5A EA          NOP                    ;|
$91:CE5B EA          NOP                    ;} X = [$2A] + [$2C] * [room width in blocks] (block index)
$91:CE5C A5 2A       LDA $2A    [$7E:002A]  ;|
$91:CE5E 18          CLC                    ;|
$91:CE5F 6D 16 42    ADC $4216              ;|
$91:CE62 AA          TAX                    ;/
$91:CE63 BF 02 64 7F LDA $7F6402,x[$7F:6671];\
$91:CE67 29 FF 00    AND #$00FF             ;} $2E = (block BTS)
$91:CE6A 85 2E       STA $2E    [$7E:002E]  ;/
$91:CE6C 8A          TXA                    ;\
$91:CE6D 0A          ASL A                  ;|
$91:CE6E AA          TAX                    ;|
$91:CE6F BF 02 00 7F LDA $7F0002,x[$7F:04E0];} $30 = (block type)
$91:CE73 29 00 F0    AND #$F000             ;|
$91:CE76 85 30       STA $30    [$7E:0030]  ;/
$91:CE78 60          RTS
}


;;; $CE79: Revealed block command - vertical extension ;;;
{
;; Parameters:
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
;;     $26: Block BTS
;;     $28: Block type
$91:CE79 20 2C CE    JSR $CE2C  [$91:CE2C]  ; Calculate block co-ordinates
$91:CE7C A5 28       LDA $28    [$7E:0028]  ;\
$91:CE7E 85 30       STA $30    [$7E:0030]  ;} $30 = [block type]
$91:CE80 A5 26       LDA $26    [$7E:0026]  ;\
$91:CE82 F0 79       BEQ $79    [$CEFD]     ;} If [block BTS] = 0: go to copy 1x1 block to x-ray BG2 tilemap if scroll PLM trigger
$91:CE84 89 80 00    BIT #$0080             ;\
$91:CE87 F0 03       BEQ $03    [$CE8C]     ;|
$91:CE89 09 00 FF    ORA #$FF00             ;} $2E = ±[block BTS]
                                            ;|
$91:CE8C 85 2E       STA $2E    [$7E:002E]  ;/
}


;;; $CE8E: Revealed block extension loop - vertical ;;;
{
;; Parameters:
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
;;     $2A: X block co-ordinate
;;     $2C: Y block co-ordinate
;;     $2E: Block BTS (sign extended)

; LOOP
$91:CE8E A5 2C       LDA $2C    [$7E:002C]  ;\
$91:CE90 18          CLC                    ;|
$91:CE91 65 2E       ADC $2E    [$7E:002E]  ;} If [Y block co-ordinate] + [block BTS] < 0:
$91:CE93 10 09       BPL $09    [$CE9E]     ;/
$91:CE95 A9 FF 00    LDA #$00FF             ; A = FFh (blank tile)
$91:CE98 20 C1 CF    JSR $CFC1  [$91:CFC1]  ; Copy block to x-ray BG2 tilemap
$91:CE9B 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done

$91:CE9E 85 2C       STA $2C    [$7E:002C]  ; Y block co-ordinate += [block BTS]
$91:CEA0 20 51 CE    JSR $CE51  [$91:CE51]  ; Get block type and BTS
$91:CEA3 C9 00 D0    CMP #$D000             ;\
$91:CEA6 F0 E6       BEQ $E6    [$CE8E]     ;} If (block type) = vertical extension: go to LOOP
$91:CEA8 C9 00 50    CMP #$5000             ;\
$91:CEAB D0 50       BNE $50    [$CEFD]     ;} If (block type) != horizontal extension: go to copy 1x1 block to x-ray BG2 tilemap if scroll PLM trigger
$91:CEAD A5 2E       LDA $2E    [$7E:002E]  ;\
$91:CEAF 89 80 00    BIT #$0080             ;} If [block BTS] >= 0: go to LOOP <-- uh
$91:CEB2 F0 DA       BEQ $DA    [$CE8E]     ;/
$91:CEB4 49 00 FF    EOR #$FF00             ;\
$91:CEB7 85 2E       STA $2E    [$7E:002E]  ;} Block BTS = ±[block BTS]
$91:CEB9 80 15       BRA $15    [$CED0]     ; Go to revealed block extension loop - horizontal
}


;;; $CEBB: Revealed block command - horizontal extension ;;;
{
;; Parameters:
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
;;     $26: Block BTS
;;     $28: Block type
$91:CEBB 20 2C CE    JSR $CE2C  [$91:CE2C]  ; Calculate block co-ordinates
$91:CEBE A5 28       LDA $28    [$7E:0028]  ;\
$91:CEC0 85 30       STA $30    [$7E:0030]  ;} $30 = [block type]
$91:CEC2 A5 26       LDA $26    [$7E:0026]  ;\
$91:CEC4 F0 37       BEQ $37    [$CEFD]     ;} If [block BTS] = 0: go to copy 1x1 block to x-ray BG2 tilemap if scroll PLM trigger
$91:CEC6 89 80 00    BIT #$0080             ;\
$91:CEC9 F0 03       BEQ $03    [$CECE]     ;|
$91:CECB 09 00 FF    ORA #$FF00             ;} $2E = ±[block BTS]
                                            ;|
$91:CECE 85 2E       STA $2E    [$7E:002E]  ;/
}


;;; $CED0: Revealed block extension loop - horizontal ;;;
{
;; Parameters:
;;     $16: X-ray BG2 tilemap index
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
;;     $24: Block index
;;     $2A: X block co-ordinate
;;     $2C: Y block co-ordinate
;;     $2E: Block BTS (sign extended)

; LOOP
$91:CED0 A5 2A       LDA $2A    [$7E:002A]  ;\
$91:CED2 18          CLC                    ;|
$91:CED3 65 2E       ADC $2E    [$7E:002E]  ;} If [X block co-ordinate] + [block BTS] < 0:
$91:CED5 10 09       BPL $09    [$CEE0]     ;/
$91:CED7 A9 FF 00    LDA #$00FF             ; A = FFh (blank tile)
$91:CEDA 20 C1 CF    JSR $CFC1  [$91:CFC1]  ; Copy block to x-ray BG2 tilemap
$91:CEDD 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done

$91:CEE0 85 2A       STA $2A    [$7E:002A]  ; X block co-ordinate += [block BTS]
$91:CEE2 20 51 CE    JSR $CE51  [$91:CE51]  ; Get block type and BTS
$91:CEE5 C9 00 D0    CMP #$D000             ;\
$91:CEE8 F0 A4       BEQ $A4    [$CE8E]     ;} If (block type) = vertical extension: go to revealed block extension loop - vertical
$91:CEEA C9 00 50    CMP #$5000             ;\
$91:CEED D0 0E       BNE $0E    [$CEFD]     ;} If (block type) != horizontal extension: go to copy 1x1 block to x-ray BG2 tilemap if scroll PLM trigger
$91:CEEF A5 2E       LDA $2E    [$7E:002E]  ;\
$91:CEF1 89 80 00    BIT #$0080             ;} If (block BTS) >= 0: go to LOOP
$91:CEF4 F0 DA       BEQ $DA    [$CED0]     ;/
$91:CEF6 49 00 FF    EOR #$FF00             ;\
$91:CEF9 85 2E       STA $2E    [$7E:002E]  ;} $2E = ±(block BTS)
$91:CEFB 80 D3       BRA $D3    [$CED0]     ; Go to LOOP
}


;;; $CEFD: Copy 1x1 block to x-ray BG2 tilemap if scroll PLM trigger ;;;
{
;; Parameters:
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
;;     $2E: Block BTS
;;     $30: Block type
$91:CEFD AD DA D2    LDA $D2DA  [$91:D2DA]  ;\
$91:CF00 C5 30       CMP $30    [$7E:0030]  ;} If [block type] != special air: go to load revealed block - done
$91:CF02 D0 2F       BNE $2F    [$CF33]     ;/
$91:CF04 AD DC D2    LDA $D2DC  [$91:D2DC]  ;\
$91:CF07 85 00       STA $00    [$7E:0000]  ;} $00 = $D306 (revealed block table - special air)
$91:CF09 A0 00 00    LDY #$0000             ; Y = 0

; LOOP
$91:CF0C B1 00       LDA ($00),y            ;\
$91:CF0E C9 FF FF    CMP #$FFFF             ;} If [$D306 + [Y]] = FFFFh: go to load revealed block - done
$91:CF11 F0 20       BEQ $20    [$CF33]     ;/
$91:CF13 C9 00 FF    CMP #$FF00             ;\
$91:CF16 F0 0A       BEQ $0A    [$CF22]     ;} If [$D306 + [Y]] != FF00h:
$91:CF18 C5 2E       CMP $2E    [$7E:002E]  ;\
$91:CF1A F0 06       BEQ $06    [$CF22]     ;} If [$D306 + [Y]] != (block BTS):
$91:CF1C C8          INY                    ;\
$91:CF1D C8          INY                    ;|
$91:CF1E C8          INY                    ;} Y += 4
$91:CF1F C8          INY                    ;/
$91:CF20 80 EA       BRA $EA    [$CF0C]     ; Go to LOOP

$91:CF22 C8          INY                    ;\
$91:CF23 C8          INY                    ;|
$91:CF24 B1 00       LDA ($00),y            ;|
$91:CF26 1A          INC A                  ;} $03 = [$D306 + [Y] + 2] + 2 (revealed block command argument pointer)
$91:CF27 1A          INC A                  ;|
$91:CF28 85 03       STA $03    [$7E:0003]  ;/
$91:CF2A A0 00 00    LDY #$0000             ; Y = 0
$91:CF2D 20 BF CF    JSR $CFBF  [$91:CFBF]  ; Copy revealed block command argument to x-ray BG2 tilemap
$91:CF30 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done

$91:CF33 4C CB CD    JMP $CDCB  [$91:CDCB]
}


;;; $CF36: Revealed block command - copy 1x1 block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     Y: 0
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CF36 C8          INY                    ;\
$91:CF37 C8          INY                    ;} Y = 2
$91:CF38 20 BF CF    JSR $CFBF  [$91:CFBF]  ; Copy revealed block command argument to x-ray BG2 tilemap
$91:CF3B 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done
}


;;; $CF3E: Revealed block command - copy 1x1 block to x-ray BG2 tilemap if in Brinstar ;;;
{
;; Parameters:
;;     Y: 0
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CF3E C8          INY                    ;\
$91:CF3F C8          INY                    ;} Y = 2
$91:CF40 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$91:CF43 C9 01 00    CMP #$0001             ;} If [area index] = Brinstar:
$91:CF46 D0 03       BNE $03    [$CF4B]     ;/
$91:CF48 20 BF CF    JSR $CFBF  [$91:CFBF]  ; Copy revealed block command argument to x-ray BG2 tilemap

$91:CF4B 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done
}


;;; $CF4E: Revealed block command - copy 2x1 block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     Y: 0
;;     $03: Revealed block command pointer
;;     $12: Tilemap column loop counter
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CF4E C8          INY                    ;\
$91:CF4F C8          INY                    ;} Y = 2
$91:CF50 20 BF CF    JSR $CFBF  [$91:CFBF]  ; Copy revealed block command argument to x-ray BG2 tilemap
$91:CF53 A5 12       LDA $12    [$7E:0012]  ;\
$91:CF55 C9 01 00    CMP #$0001             ;} If [$12] != 1 (if not last column):
$91:CF58 F0 05       BEQ $05    [$CF5F]     ;/
$91:CF5A C8          INY                    ;\
$91:CF5B C8          INY                    ;} Y += 2
$91:CF5C 20 EE CF    JSR $CFEE  [$91:CFEE]  ; Copy revealed block command argument to x-ray BG2 tilemap one block right

$91:CF5F 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done
}


;;; $CF62: Revealed block command - copy 1x2 block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     Y: 0
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CF62 C8          INY                    ;\
$91:CF63 C8          INY                    ;} Y = 2
$91:CF64 20 BF CF    JSR $CFBF  [$91:CFBF]  ; Copy revealed block command argument to x-ray BG2 tilemap
$91:CF67 C8          INY                    ;\
$91:CF68 C8          INY                    ;} Y += 2
$91:CF69 20 1D D0    JSR $D01D  [$91:D01D]  ; Copy revealed block command argument to x-ray BG2 tilemap one block down
$91:CF6C 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done
}


;;; $CF6F: Revealed block command - copy 2x2 block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     Y: 0
;;     $03: Revealed block command pointer
;;     $12: Tilemap column loop counter
;;     $16: X-ray BG2 tilemap index
;;     $24: Block index
$91:CF6F C8          INY                    ;\
$91:CF70 C8          INY                    ;} Y = 2
$91:CF71 20 BF CF    JSR $CFBF  [$91:CFBF]  ; Copy revealed block command argument to x-ray BG2 tilemap
$91:CF74 C8          INY                    ;\
$91:CF75 C8          INY                    ;} Y += 2
$91:CF76 A5 12       LDA $12    [$7E:0012]  ;\
$91:CF78 C9 01 00    CMP #$0001             ;} If [$12] != 1 (if not last column):
$91:CF7B F0 03       BEQ $03    [$CF80]     ;/
$91:CF7D 20 EE CF    JSR $CFEE  [$91:CFEE]  ; Copy revealed block command argument to x-ray BG2 tilemap one block right

$91:CF80 C8          INY                    ;\
$91:CF81 C8          INY                    ;} Y += 2
$91:CF82 20 1D D0    JSR $D01D  [$91:D01D]  ; Copy revealed block command argument to x-ray BG2 tilemap one block down
$91:CF85 C8          INY                    ;\
$91:CF86 C8          INY                    ;} Y += 2
$91:CF87 A5 12       LDA $12    [$7E:0012]  ;\
$91:CF89 C9 01 00    CMP #$0001             ;} If [$12] != 1 (if not last column):
$91:CF8C F0 2E       BEQ $2E    [$CFBC]     ;/
$91:CF8E B1 03       LDA ($03),y            ;\
$91:CF90 0A          ASL A                  ;|
$91:CF91 0A          ASL A                  ;} X = [[$03] + [Y]] * 8
$91:CF92 0A          ASL A                  ;|
$91:CF93 AA          TAX                    ;/
$91:CF94 BF 00 A0 7E LDA $7EA000,x          ;\
$91:CF98 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] + 84h = [$7E:A000 + [X]]
$91:CF99 BF 02 A0 7E LDA $7EA002,x          ; \
$91:CF9D 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 86h = [$7E:A000 + [X] + 2]
$91:CF9E BF 04 A0 7E LDA $7EA004,x          ;  \
$91:CFA2 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + C4h = [$7E:A000 + [X] + 4]
$91:CFA3 BF 06 A0 7E LDA $7EA006,x          ;   \
$91:CFA7 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + C6h = [$7E:A000 + [X] + 6]
$91:CFA9 9F C6 40 7E STA $7E40C6,x          ;   /
$91:CFAD 68          PLA                    ;  |
$91:CFAE 9F C4 40 7E STA $7E40C4,x          ;  /
$91:CFB2 68          PLA                    ; |
$91:CFB3 9F 86 40 7E STA $7E4086,x          ; /
$91:CFB7 68          PLA                    ;|
$91:CFB8 9F 84 40 7E STA $7E4084,x          ;/

$91:CFBC 4C CB CD    JMP $CDCB  [$91:CDCB]  ; Go to load revealed block - done
}


;;; $CFBF: Copy revealed block command argument to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     Y: Revealed block command argument offset
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
$91:CFBF B1 03       LDA ($03),y[$91:D304]  ; A = [[$03] + [Y]]
}


;;; $CFC1: Copy block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     A: Tile table index
;;     $16: X-ray BG2 tilemap index
$91:CFC1 0A          ASL A                  ;\
$91:CFC2 0A          ASL A                  ;|
$91:CFC3 0A          ASL A                  ;} X = (tile table index) * 8
$91:CFC4 AA          TAX                    ;/
$91:CFC5 BF 00 A0 7E LDA $7EA000,x[$7E:A7F8];\
$91:CFC9 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] = [$7E:A000 + [X]]
$91:CFCA BF 02 A0 7E LDA $7EA002,x[$7E:A7FA]; \
$91:CFCE 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 2 = [$7E:A000 + [X] + 2]
$91:CFCF BF 04 A0 7E LDA $7EA004,x[$7E:A7FC];  \
$91:CFD3 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + 40h = [$7E:A000 + [X] + 4]
$91:CFD4 BF 06 A0 7E LDA $7EA006,x[$7E:A7FE];   \
$91:CFD8 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + 42h = [$7E:A000 + [X] + 6]
$91:CFDA 9F 42 40 7E STA $7E4042,x[$7E:4042];   /
$91:CFDE 68          PLA                    ;  |
$91:CFDF 9F 40 40 7E STA $7E4040,x[$7E:4040];  /
$91:CFE3 68          PLA                    ; |
$91:CFE4 9F 02 40 7E STA $7E4002,x[$7E:4002]; /
$91:CFE8 68          PLA                    ;|
$91:CFE9 9F 00 40 7E STA $7E4000,x[$7E:4000];/
$91:CFED 60          RTS
}


;;; $CFEE: Copy revealed block command argument to x-ray BG2 tilemap one block right ;;;
{
;; Parameters:
;;     Y: Revealed block command argument offset
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
$91:CFEE B1 03       LDA ($03),y[$91:D4AE]  ;\
$91:CFF0 0A          ASL A                  ;|
$91:CFF1 0A          ASL A                  ;} X = [[$03] + [Y]] * 8
$91:CFF2 0A          ASL A                  ;|
$91:CFF3 AA          TAX                    ;/
$91:CFF4 BF 00 A0 7E LDA $7EA000,x[$7E:A2C0];\
$91:CFF8 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] + 4 = [$7E:A000 + [X]]
$91:CFF9 BF 02 A0 7E LDA $7EA002,x[$7E:A2C2]; \
$91:CFFD 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 6 = [$7E:A000 + [X] + 2]
$91:CFFE BF 04 A0 7E LDA $7EA004,x[$7E:A2C4];  \
$91:D002 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + 44h = [$7E:A000 + [X] + 4]
$91:D003 BF 06 A0 7E LDA $7EA006,x[$7E:A2C6];   \
$91:D007 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + 46h = [$7E:A000 + [X] + 6]
$91:D009 9F 46 40 7E STA $7E4046,x[$7E:4F46];   /
$91:D00D 68          PLA                    ;  |
$91:D00E 9F 44 40 7E STA $7E4044,x[$7E:4F44];  /
$91:D012 68          PLA                    ; |
$91:D013 9F 06 40 7E STA $7E4006,x[$7E:4F06]; /
$91:D017 68          PLA                    ;|
$91:D018 9F 04 40 7E STA $7E4004,x[$7E:4F04];/
$91:D01C 60          RTS
}


;;; $D01D: Copy revealed block command argument to x-ray BG2 tilemap one block down ;;;
{
;; Parameters:
;;     Y: Revealed block command argument offset
;;     $03: Revealed block command pointer
;;     $16: X-ray BG2 tilemap index
$91:D01D B1 03       LDA ($03),y[$91:D382]  ;\
$91:D01F 0A          ASL A                  ;|
$91:D020 0A          ASL A                  ;} X = [[$03] + [Y]] * 8
$91:D021 0A          ASL A                  ;|
$91:D022 AA          TAX                    ;/
$91:D023 BF 00 A0 7E LDA $7EA000,x[$7E:A5E0];\
$91:D027 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] + 80h = [$7E:A000 + [X]]
$91:D028 BF 02 A0 7E LDA $7EA002,x[$7E:A5E2]; \
$91:D02C 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 82h = [$7E:A000 + [X] + 2]
$91:D02D BF 04 A0 7E LDA $7EA004,x[$7E:A5E4];  \
$91:D031 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] + C0h = [$7E:A000 + [X] + 4]
$91:D032 BF 06 A0 7E LDA $7EA006,x[$7E:A5E6];   \
$91:D036 A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + C2h = [$7E:A000 + [X] + 6]
$91:D038 9F C2 40 7E STA $7E40C2,x[$7E:4C42];   /
$91:D03C 68          PLA                    ;  |
$91:D03D 9F C0 40 7E STA $7E40C0,x[$7E:4C40];  /
$91:D041 68          PLA                    ; |
$91:D042 9F 82 40 7E STA $7E4082,x[$7E:4C02]; /
$91:D046 68          PLA                    ;|
$91:D047 9F 80 40 7E STA $7E4080,x[$7E:4C00];/
$91:D04B 60          RTS
}


;;; $D04C: Load block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     A: Level data block (block type ignored)
;;     X: X block
;;     Y: Y block

; Called by $84:831A (load item x-ray blocks)
; Doesn't support X flipped blocks
$91:D04C 08          PHP
$91:D04D DA          PHX
$91:D04E 5A          PHY
$91:D04F C2 30       REP #$30
$91:D051 85 28       STA $28    [$7E:0028]  ; $28 = (level data block)
$91:D053 AD 11 09    LDA $0911  [$7E:0911]  ;\
$91:D056 4A          LSR A                  ;|
$91:D057 4A          LSR A                  ;|
$91:D058 4A          LSR A                  ;|
$91:D059 4A          LSR A                  ;|
$91:D05A 85 18       STA $18    [$7E:0018]  ;} If (X block) < (layer 1 X block): return
$91:D05C 8A          TXA                    ;|
$91:D05D 38          SEC                    ;|
$91:D05E E5 18       SBC $18    [$7E:0018]  ;|
$91:D060 30 40       BMI $40    [$D0A2]     ;/
$91:D062 85 18       STA $18    [$7E:0018]  ; $18 = (block X offset)
$91:D064 E9 10 00    SBC #$0010             ;\
$91:D067 10 39       BPL $39    [$D0A2]     ;} If (block X offset) >= 10h: return
$91:D069 AD 15 09    LDA $0915  [$7E:0915]  ;\
$91:D06C 4A          LSR A                  ;|
$91:D06D 4A          LSR A                  ;|
$91:D06E 4A          LSR A                  ;|
$91:D06F 4A          LSR A                  ;|
$91:D070 85 1A       STA $1A    [$7E:001A]  ;} If (Y block) < (layer 1 Y block): return
$91:D072 98          TYA                    ;|
$91:D073 38          SEC                    ;|
$91:D074 E5 1A       SBC $1A    [$7E:001A]  ;|
$91:D076 30 2A       BMI $2A    [$D0A2]     ;/
$91:D078 85 1A       STA $1A    [$7E:001A]  ; $1A = (block Y offset)
$91:D07A E9 10 00    SBC #$0010             ;\
$91:D07D 10 23       BPL $23    [$D0A2]     ;} If (block Y offset) >= 10h: return
$91:D07F A5 1A       LDA $1A    [$7E:001A]  ;\
$91:D081 0A          ASL A                  ;|
$91:D082 0A          ASL A                  ;|
$91:D083 0A          ASL A                  ;|
$91:D084 0A          ASL A                  ;|
$91:D085 0A          ASL A                  ;} $16 = ((block Y offset) * 20h + (block X offset)) * 4
$91:D086 18          CLC                    ;|
$91:D087 65 18       ADC $18    [$7E:0018]  ;|
$91:D089 0A          ASL A                  ;|
$91:D08A 0A          ASL A                  ;|
$91:D08B 85 16       STA $16    [$7E:0016]  ;/
$91:D08D A5 28       LDA $28    [$7E:0028]  ;\
$91:D08F 89 00 08    BIT #$0800             ;} If block is not Y flipped:
$91:D092 D0 08       BNE $08    [$D09C]     ;/
$91:D094 29 FF 03    AND #$03FF             ; A = (level data block) & 3FFh
$91:D097 20 C1 CF    JSR $CFC1  [$91:CFC1]  ; Copy block to x-ray BG2 tilemap
$91:D09A 80 06       BRA $06    [$D0A2]
                                            ; Else (block is Y flipped):
$91:D09C 29 FF 03    AND #$03FF             ; A = (level data block) & 3FFh
$91:D09F 20 A6 D0    JSR $D0A6  [$91:D0A6]  ; Copy Y flipped block to x-ray BG2 tilemap

$91:D0A2 7A          PLY
$91:D0A3 FA          PLX
$91:D0A4 28          PLP
$91:D0A5 6B          RTL
}


;;; $D0A6: Copy Y flipped block to x-ray BG2 tilemap ;;;
{
;; Parameters:
;;     A: Tile table index
;;     $16: X-ray BG2 tilemap index
$91:D0A6 0A          ASL A                  ;\
$91:D0A7 0A          ASL A                  ;|
$91:D0A8 0A          ASL A                  ;} X = (tile table index) * 8
$91:D0A9 AA          TAX                    ;/
$91:D0AA BF 00 A0 7E LDA $7EA000,x          ;\
$91:D0AE 48          PHA                    ;} $7E:4000 + [x-ray BG2 tilemap index] + 40h = [$7E:A000 + [X]]
$91:D0AF BF 02 A0 7E LDA $7EA002,x          ; \
$91:D0B3 48          PHA                    ; } $7E:4000 + [x-ray BG2 tilemap index] + 42h = [$7E:A000 + [X] + 2]
$91:D0B4 BF 04 A0 7E LDA $7EA004,x          ;  \
$91:D0B8 48          PHA                    ;  } $7E:4000 + [x-ray BG2 tilemap index] = [$7E:A000 + [X] + 4]
$91:D0B9 BF 06 A0 7E LDA $7EA006,x          ;   \
$91:D0BD A6 16       LDX $16    [$7E:0016]  ;   } $7E:4000 + [x-ray BG2 tilemap index] + 2 = [$7E:A000 + [X] + 6]
$91:D0BF 9F 02 40 7E STA $7E4002,x          ;   /
$91:D0C3 68          PLA                    ;  |
$91:D0C4 9F 00 40 7E STA $7E4000,x          ;  /
$91:D0C8 68          PLA                    ; |
$91:D0C9 9F 42 40 7E STA $7E4042,x          ; /
$91:D0CD 68          PLA                    ;|
$91:D0CE 9F 40 40 7E STA $7E4040,x          ;/
$91:D0D2 60          RTS
}


;;; $D0D3: X-ray setup stage 5 - read BG2 tilemap - 2nd screen ;;;
{
$91:D0D3 08          PHP
$91:D0D4 C2 30       REP #$30
$91:D0D6 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$91:D0DA F0 2D       BEQ $2D    [$D109]     ;} If x-ray should not show any blocks: go to BRANCH_NO_REVEAL
$91:D0DC AD 40 18    LDA $1840  [$7E:1840]  ;\
$91:D0DF F0 12       BEQ $12    [$D0F3]     ;} If [earthquake timer] != 0:
$91:D0E1 AD 1D 09    LDA $091D  [$7E:091D]  ;\
$91:D0E4 18          CLC                    ;|
$91:D0E5 6D 11 09    ADC $0911  [$7E:0911]  ;} BG1 X scroll = [layer 1 X position] + [BG1 X offset]
$91:D0E8 85 B1       STA $B1    [$7E:00B1]  ;/
$91:D0EA AD 1F 09    LDA $091F  [$7E:091F]  ;\
$91:D0ED 18          CLC                    ;|
$91:D0EE 6D 15 09    ADC $0915  [$7E:0915]  ;} BG1 Y scroll = [layer 1 Y position] + [BG1 Y offset]
$91:D0F1 85 B3       STA $B3    [$7E:00B3]  ;/

$91:D0F3 A5 B1       LDA $B1    [$7E:00B1]  ;\
$91:D0F5 29 0F 00    AND #$000F             ;} BG2 X scroll = [BG1 X scroll] % 10h
$91:D0F8 85 B5       STA $B5    [$7E:00B5]  ;/
$91:D0FA A5 B3       LDA $B3    [$7E:00B3]  ;\
$91:D0FC 29 0F 00    AND #$000F             ;} BG2 Y scroll = [BG1 Y scroll] % 10h
$91:D0FF 85 B7       STA $B7    [$7E:00B7]  ;/
$91:D101 E2 20       SEP #$20
$91:D103 A9 49       LDA #$49               ;\
$91:D105 85 59       STA $59    [$7E:0059]  ;} BG2 tilemap base address = $4800, size = 64x32
$91:D107 C2 20       REP #$20

; BRANCH_NO_REVEAL
$91:D109 AE 60 03    LDX $0360  [$7E:0360]  ;\
$91:D10C A5 59       LDA $59    [$7E:0059]  ;|
$91:D10E 29 FC 00    AND #$00FC             ;|
$91:D111 EB          XBA                    ;|
$91:D112 18          CLC                    ;|
$91:D113 69 00 04    ADC #$0400             ;|
$91:D116 9D 40 03    STA $0340,x[$7E:0340]  ;|
$91:D119 A9 81 00    LDA #$0081             ;|
$91:D11C 9D 42 03    STA $0342,x[$7E:0342]  ;|
$91:D11F A9 39 00    LDA #$0039             ;|
$91:D122 9D 43 03    STA $0343,x[$7E:0343]  ;} Queue transfer of 800h bytes from VRAM BG2 tilemap base + 400h to $7E:5800
$91:D125 A9 00 58    LDA #$5800             ;|
$91:D128 9D 44 03    STA $0344,x[$7E:0344]  ;|
$91:D12B A9 7E 00    LDA #$007E             ;|
$91:D12E 9D 46 03    STA $0346,x[$7E:0346]  ;|
$91:D131 A9 00 08    LDA #$0800             ;|
$91:D134 9D 47 03    STA $0347,x[$7E:0347]  ;|
$91:D137 8A          TXA                    ;|
$91:D138 18          CLC                    ;|
$91:D139 69 09 00    ADC #$0009             ;|
$91:D13C 8D 60 03    STA $0360  [$7E:0360]  ;/
$91:D13F 28          PLP
$91:D140 6B          RTL
}


;;; $D141: REP #$30 ;;;
{
; A stray REP, seemingly split away from the below routine
$91:D141 C2 30       REP #$30
}


;;; $D143: Check if x-ray should show any blocks ;;;
{
$91:D143 AD 9B 07    LDA $079B  [$7E:079B]  ;\
$91:D146 C9 6A A6    CMP #$A66A             ;} If in Tourian entrance room: return zero set
$91:D149 F0 27       BEQ $27    [$D172]     ;/
$91:D14B C9 FB CE    CMP #$CEFB             ;\
$91:D14E F0 22       BEQ $22    [$D172]     ;} If in n00b tube room: return zero set
$91:D150 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$91:D153 C9 24 00    CMP #$0024             ;} If [FX type] = fireflea: return zero set
$91:D156 F0 1A       BEQ $1A    [$D172]     ;/
$91:D158 AD 9C 17    LDA $179C  [$7E:179C]  ;\
$91:D15B C9 03 00    CMP #$0003             ;} If fighting Kraid: return zero set
$91:D15E F0 12       BEQ $12    [$D172]     ;/
$91:D160 C9 06 00    CMP #$0006             ;\
$91:D163 F0 0D       BEQ $0D    [$D172]     ;} If fighting Crocomire: return zero set
$91:D165 C9 07 00    CMP #$0007             ;\
$91:D168 F0 08       BEQ $08    [$D172]     ;} If fighting Phantoon: return zero set
$91:D16A C9 08 00    CMP #$0008             ;\
$91:D16D F0 03       BEQ $03    [$D172]     ;} If fighting Draygon: return zero set
$91:D16F C9 0A 00    CMP #$000A             ; If fighting Mother Brain: return zero set, else return zero clear

$91:D172 6B          RTL
}


;;; $D173: X-ray setup stage 6 - transfer x-ray tilemap - 1st screen ;;;
{
$91:D173 08          PHP
$91:D174 C2 30       REP #$30
$91:D176 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$91:D17A F0 22       BEQ $22    [$D19E]     ;} If x-ray should not show any blocks: return
$91:D17C AE 30 03    LDX $0330  [$7E:0330]  ;\
$91:D17F A9 00 08    LDA #$0800             ;|
$91:D182 95 D0       STA $D0,x  [$7E:00D0]  ;|
$91:D184 A9 00 40    LDA #$4000             ;|
$91:D187 95 D2       STA $D2,x  [$7E:00D2]  ;|
$91:D189 A9 7E 00    LDA #$007E             ;|
$91:D18C 95 D4       STA $D4,x  [$7E:00D4]  ;|
$91:D18E A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of 800h bytes from $7E:4000 to VRAM BG2 tilemap base
$91:D190 29 FC 00    AND #$00FC             ;|
$91:D193 EB          XBA                    ;|
$91:D194 95 D5       STA $D5,x  [$7E:00D5]  ;|
$91:D196 8A          TXA                    ;|
$91:D197 18          CLC                    ;|
$91:D198 69 07 00    ADC #$0007             ;|
$91:D19B 8D 30 03    STA $0330  [$7E:0330]  ;/

$91:D19E 28          PLP
$91:D19F 6B          RTL
}


;;; $D1A0: X-ray setup stage 7 - initialise x-ray beam, transfer x-ray tilemap - 2nd screen ;;;
{
$91:D1A0 08          PHP
$91:D1A1 C2 30       REP #$30
$91:D1A3 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$91:D1A7 F0 26       BEQ $26    [$D1CF]     ;} If x-ray should not show any blocks: return
$91:D1A9 AE 30 03    LDX $0330  [$7E:0330]  ;\
$91:D1AC A9 00 08    LDA #$0800             ;|
$91:D1AF 95 D0       STA $D0,x  [$7E:00D0]  ;|
$91:D1B1 A9 00 48    LDA #$4800             ;|
$91:D1B4 95 D2       STA $D2,x  [$7E:00D2]  ;|
$91:D1B6 A9 7E 00    LDA #$007E             ;|
$91:D1B9 95 D4       STA $D4,x  [$7E:00D4]  ;|
$91:D1BB A5 59       LDA $59    [$7E:0059]  ;|
$91:D1BD 29 FC 00    AND #$00FC             ;} Queue transfer of 800h bytes from $7E:4800 to VRAM BG2 tilemap base + 400h
$91:D1C0 EB          XBA                    ;|
$91:D1C1 18          CLC                    ;|
$91:D1C2 69 00 04    ADC #$0400             ;|
$91:D1C5 95 D5       STA $D5,x  [$7E:00D5]  ;|
$91:D1C7 8A          TXA                    ;|
$91:D1C8 18          CLC                    ;|
$91:D1C9 69 07 00    ADC #$0007             ;|
$91:D1CC 8D 30 03    STA $0330  [$7E:0330]  ;/

$91:D1CF A9 E4 00    LDA #$00E4             ;\
$91:D1D2 8D 88 0A    STA $0A88  [$7E:0A88]  ;|
$91:D1D5 A9 00 98    LDA #$9800             ;|
$91:D1D8 8D 89 0A    STA $0A89  [$7E:0A89]  ;|
$91:D1DB A9 E4 00    LDA #$00E4             ;|
$91:D1DE 8D 8B 0A    STA $0A8B  [$7E:0A8B]  ;|
$91:D1E1 A9 C8 98    LDA #$98C8             ;} $0A88..92 = E4h,$9800, E4h,$98C8, 98h,$9990, 0,0
$91:D1E4 8D 8C 0A    STA $0A8C  [$7E:0A8C]  ;|
$91:D1E7 A9 98 00    LDA #$0098             ;|
$91:D1EA 8D 8E 0A    STA $0A8E  [$7E:0A8E]  ;|
$91:D1ED A9 90 99    LDA #$9990             ;|
$91:D1F0 8D 8F 0A    STA $0A8F  [$7E:0A8F]  ;|
$91:D1F3 9C 91 0A    STZ $0A91  [$7E:0A91]  ;/
$91:D1F6 9C 7A 0A    STZ $0A7A  [$7E:0A7A]  ; X-ray state = no beam
$91:D1F9 9C 7C 0A    STZ $0A7C  [$7E:0A7C]  ;\
$91:D1FC 9C 7E 0A    STZ $0A7E  [$7E:0A7E]  ;} X-ray angular width delta = 0.0
$91:D1FF A9 00 00    LDA #$0000             ;\
$91:D202 8D 84 0A    STA $0A84  [$7E:0A84]  ;} X-ray angular width = 0.0
$91:D205 9C 86 0A    STZ $0A86  [$7E:0A86]  ;/
$91:D208 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:D20B 29 FF 00    AND #$00FF             ;|
$91:D20E C9 04 00    CMP #$0004             ;} If Samus is facing right:
$91:D211 F0 08       BEQ $08    [$D21B]     ;/
$91:D213 A9 40 00    LDA #$0040             ;\
$91:D216 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = 40h
$91:D219 80 06       BRA $06    [$D221]     ; Return

$91:D21B A9 C0 00    LDA #$00C0             ;\
$91:D21E 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = C0h

$91:D221 28          PLP
$91:D222 6B          RTL
}


;;; $D223: HDMA object instruction list - x-ray ;;;
{
$91:D223             dx 8655,00,    ; HDMA table bank = $00
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,91D27F,; Pre-instruction = $91:D27F (x-ray setup)
                        85B4,91CAF9,; X-ray setup stage 1 - freeze time and backup BG2 registers
                        0001,0A88,
                        85B4,91CB1C,; X-ray setup stage 2 - read BG1 tilemap - 2nd screen
                        0001,0A88,
                        85B4,91CB57,; X-ray setup stage 3 - read BG1 tilemap - 1st screen
                        0001,0A88,
                        85B4,91CB8E,; X-ray setup stage 4 - build x-ray BG2 tilemap, read BG2 tilemap - 1st screen
                        0001,0A88,
                        85B4,91D0D3,; X-ray setup stage 5 - read BG2 tilemap - 2nd screen
                        0001,0A88,
                        85B4,91D173,; X-ray setup stage 6 - transfer x-ray tilemap - 1st screen
                        0001,0A88,
                        85B4,91D1A0,; X-ray setup stage 7 - initialise x-ray beam, transfer x-ray tilemap - 2nd screen
                        0001,0A88,
                        85B4,91D2BC,; X-ray setup stage 8 - backdrop colour = (3, 3, 3)
                        8570,8886EF ; Pre-instruction = $88:86EF (x-ray main)
$91:D277             dw 0001,0A88,
                        85EC,D277   ; Go to $D277
}


;;; $D27F: HDMA object pre-instruction - x-ray setup ;;;
{
$91:D27F 08          PHP
$91:D280 C2 30       REP #$30
$91:D282 DA          PHX
$91:D283 A2 00 10    LDX #$1000             ; X = 1000h
$91:D286 AD 6E 19    LDA $196E  [$7E:196E]  ;\
$91:D289 C9 24 00    CMP #$0024             ;} If [FX type] = fireflea: go to BRANCH_FIREFLEA
$91:D28C F0 22       BEQ $22    [$D2B0]     ;/
$91:D28E A2 00 20    LDX #$2000             ; X = 2000h
$91:D291 22 43 D1 91 JSL $91D143[$91:D143]  ;\
$91:D295 F0 12       BEQ $12    [$D2A9]     ;} If x-ray should not show any blocks: go to BRANCH_SET_BACKDROP_COLOUR_END
$91:D297 A2 00 40    LDX #$4000             ; X = 4000h

; BRANCH_SET_BACKDROP_COLOUR
$91:D29A A9 27 00    LDA #$0027             ;\
$91:D29D 85 74       STA $74    [$7E:0074]  ;|
$91:D29F A9 47 00    LDA #$0047             ;|
$91:D2A2 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour = (7, 7, 7) (grey)
$91:D2A4 A9 87 00    LDA #$0087             ;|
$91:D2A7 85 76       STA $76    [$7E:0076]  ;/

; BRANCH_SET_BACKDROP_COLOUR_END
$91:D2A9 8A          TXA                    ;\
$91:D2AA 0C 86 19    TSB $1986  [$7E:1986]  ;} Layer blending window 2 configuration |= [X] >> 8
$91:D2AD FA          PLX
$91:D2AE 28          PLP
$91:D2AF 6B          RTL                    ; Return

; BRANCH_FIREFLEA
$91:D2B0 A5 74       LDA $74    [$7E:0074]  ;\
$91:D2B2 29 1F 00    AND #$001F             ;|
$91:D2B5 C9 07 00    CMP #$0007             ;} If [value 1 for colour math subscreen backdrop colour] >= 7: go to BRANCH_SET_BACKDROP_COLOUR_END
$91:D2B8 10 EF       BPL $EF    [$D2A9]     ;/
$91:D2BA 80 DE       BRA $DE    [$D29A]     ; Go to BRANCH_SET_BACKDROP_COLOUR
}


;;; $D2BC: X-ray setup stage 8 - backdrop colour = (3, 3, 3) ;;;
{
$91:D2BC 08          PHP
$91:D2BD DA          PHX
$91:D2BE 5A          PHY
$91:D2BF E2 20       SEP #$20
$91:D2C1 A9 63       LDA #$63
$91:D2C3 8F 00 C0 7E STA $7EC000[$7E:C000]
$91:D2C7 A9 0C       LDA #$0C
$91:D2C9 8F 01 C0 7E STA $7EC001[$7E:C001]
$91:D2CD 7A          PLY
$91:D2CE FA          PLX
$91:D2CF 28          PLP
$91:D2D0 6B          RTL
}


;;; $D2D1: RTS ;;;
{
$91:D2D1 08          PHP
$91:D2D2 C2 30       REP #$30
$91:D2D4 28          PLP
$91:D2D5 60          RTS
}


;;; $D2D6..D4D9: Revealed block data ;;;
{
;;; $D2D6: Revealed block table pointers ;;;
{
$91:D2D6             dw 0000,D2FC  ; Air
$91:D2DA             dw 3000,D306, ; Special air
                        5000,D310, ; Horizontal extension
                        A000,D318, ; Spike block
                        B000,D322, ; Special block
                        C000,D3CC, ; Shootable block
                        D000,D462, ; Vertical extension
                        E000,D46A, ; Grapple block
                        F000,D484, ; Bombable block
                        FFFF
}


;;; $D2FC: Revealed block table - air ;;;
{
$91:D2FC             dw FF00,D302, ; Any BTS
                        FFFF

$91:D302             dw CF36, 00FF ; Copy 1x1 block to x-ray BG2 tilemap
}


;;; $D306: Revealed block table - special air ;;;
{
$91:D306             dw 0046,D30C, ; Scroll PLM trigger
                        FFFF

$91:D30C             dw CF36, 00FF ; Copy 1x1 block to x-ray BG2 tilemap
}


;;; $D310: Revealed block table - horizontal extension ;;;
{
$91:D310             dw FF00,D316, ; Any BTS
                        FFFF

$91:D316             dw CEBB ; Horizontal extension
}


;;; $D318: Revealed block table - spike block ;;;
{
$91:D318             dw 000E,D31E, ; X-rayable block
                        FFFF

$91:D31E             dw CF36, 005F ; Copy 1x1 block to x-ray BG2 tilemap
}


;;; $D322: Revealed block table - special block ;;;
{
$91:D322             dw 0000,D374, ; 1x1 respawning crumble block
                        0001,D378, ; 2x1 respawning crumble block
                        0002,D37E, ; 1x2 respawning crumble block
                        0003,D384, ; 2x2 respawning crumble block
                        0004,D38E, ; 1x1 crumble block
                        0005,D392, ; 2x1 crumble block
                        0006,D398, ; 1x2 crumble block
                        0007,D39E, ; 2x2 crumble block
                        0008,D3A8, ; Unused air
                        0009,D3AC, ; Unused air
                        000A,D3B0, ; Unused air
                        000B,D3B4, ; Unused air
                        000C,D3B8, ; Unused air
                        000D,D3BC, ; Unused air
                        000E,D3C0, ; Respawning speed block
                        000F,D3C4, ; Speed block
                        0082,D3C8, ; Brinstar only. Respawning speed block, slower crumble animation
                        0083,D3C8, ; Brinstar only. Speed block, slower crumble animation
                        0084,D3C8, ; Brinstar only. Respawning speed block (used by dachora pit)
                        0085,D3C8, ; Brinstar only. Speed block
                        FFFF

$91:D374             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D378             dw CF4E, 00BC, 00BC             ; Copy 2x1 block to x-ray BG2 tilemap
$91:D37E             dw CF62, 00BC, 00BC             ; Copy 1x2 block to x-ray BG2 tilemap
$91:D384             dw CF6F, 00BC, 00BC, 00BC, 00BC ; Copy 2x2 block to x-ray BG2 tilemap
$91:D38E             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D392             dw CF4E, 00BC, 00BC             ; Copy 2x1 block to x-ray BG2 tilemap
$91:D398             dw CF62, 00BC, 00BC             ; Copy 1x2 block to x-ray BG2 tilemap
$91:D39E             dw CF6F, 00BC, 00BC, 00BC, 00BC ; Copy 2x2 block to x-ray BG2 tilemap
$91:D3A8             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3AC             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3B0             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3B4             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3B8             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3BC             dw CF36, 00BC                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3C0             dw CF36, 00B6                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3C4             dw CF36, 00B6                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D3C8             dw CF3E, 00B6                   ; Copy 1x1 block to x-ray BG2 tilemap if in Brinstar
}


;;; $D3CC: Revealed block table - shootable block ;;;
{
$91:D3CC             dw 0000,D40E, ; 1x1 respawning shot block
                        0001,D412, ; 2x1 respawning shot block
                        0002,D418, ; 1x2 respawning shot block
                        0003,D41E, ; 2x2 respawning shot block
                        0004,D428, ; 1x1 shot block
                        0005,D42C, ; 2x1 shot block
                        0006,D432, ; 1x2 shot block
                        0007,D438, ; 2x2 shot block
                        0008,D442, ; Respawning power bomb block
                        0009,D446, ; Power bomb block
                        000A,D44A, ; Respawning super missile block
                        000B,D44E, ; Super missile block
                        000C,D452, ; Fake super missile block
                        000D,D456, ; Fake super missile block
                        000E,D45A, ; Fake super missile block
                        000F,D45E, ; Fake super missile block
                        FFFF

$91:D40E             dw CF36, 0052                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D412             dw CF4E, 0096, 0097             ; Copy 2x1 block to x-ray BG2 tilemap
$91:D418             dw CF62, 0098, 00B8             ; Copy 1x2 block to x-ray BG2 tilemap
$91:D41E             dw CF6F, 0099, 009A, 00B9, 00BA ; Copy 2x2 block to x-ray BG2 tilemap
$91:D428             dw CF36, 0052                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D42C             dw CF4E, 0096, 0097             ; Copy 2x1 block to x-ray BG2 tilemap
$91:D432             dw CF62, 0098, 00B8             ; Copy 1x2 block to x-ray BG2 tilemap
$91:D438             dw CF6F, 0099, 009A, 00B9, 00BA ; Copy 2x2 block to x-ray BG2 tilemap
$91:D442             dw CF36, 0057                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D446             dw CF36, 0057                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D44A             dw CF36, 009F                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D44E             dw CF36, 009F                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D452             dw CF36, 009F                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D456             dw CF36, 009F                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D45A             dw CF36, 009F                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D45E             dw CF36, 009F                   ; Copy 1x1 block to x-ray BG2 tilemap
}


;;; $D462: Revealed block table - vertical extension ;;;
{
$91:D462             dw FF00,D468, ; Any BTS
                        FFFF

$91:D468             dw CE79 ; Vertical extension
}


;;; $D46A: Revealed block table - grapple block ;;;
{
$91:D46A             dw 0000,D478, ; Generic grapple block
                        0001,D47C, ; Respawning crumbling grapple block
                        0002,D480, ; Non-respawning crumbling grapple block
                        FFFF

$91:D478             dw CF36, 009B ; Copy 1x1 block to x-ray BG2 tilemap
$91:D47C             dw CF36, 00B7 ; Copy 1x1 block to x-ray BG2 tilemap
$91:D480             dw CF36, 00B7 ; Copy 1x1 block to x-ray BG2 tilemap
}


;;; $D484: Revealed block table - bombable block ;;;
{
$91:D484             dw 0000,D4A6, ; 1x1 respawning bomb block
                        0001,D4AA, ; 2x1 respawning bomb block
                        0002,D4B0, ; 1x2 respawning bomb block
                        0003,D4B6, ; 2x2 respawning bomb block
                        0004,D4C0, ; 1x1 bomb block
                        0005,D4C4, ; 2x1 bomb block
                        0006,D4CA, ; 1x2 bomb block
                        0007,D4D0, ; 2x2 bomb block
                        FFFF

$91:D4A6             dw CF36, 0058                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D4AA             dw CF4E, 0058, 0058             ; Copy 2x1 block to x-ray BG2 tilemap
$91:D4B0             dw CF62, 0058, 0058             ; Copy 1x2 block to x-ray BG2 tilemap
$91:D4B6             dw CF6F, 0058, 0058, 0058, 0058 ; Copy 2x2 block to x-ray BG2 tilemap
$91:D4C0             dw CF36, 0058                   ; Copy 1x1 block to x-ray BG2 tilemap
$91:D4C4             dw CF4E, 0058, 0058             ; Copy 2x1 block to x-ray BG2 tilemap
$91:D4CA             dw CF62, 0058, 0058             ; Copy 1x2 block to x-ray BG2 tilemap
$91:D4D0             dw CF6F, 0058, 0058, 0058, 0058 ; Copy 2x2 block to x-ray BG2 tilemap
}
}
}


;;; $D4DA: Game state 1Ch (unused) ;;;
{
; $0DEA is never set to a pointer
$91:D4DA 08          PHP
$91:D4DB C2 30       REP #$30
$91:D4DD 6C EA 0D    JMP ($0DEA)            ; Go to [$0DEA]
}


;;; $D4E0: Unused. PLP : RTL ;;;
{
$91:D4E0 28          PLP
$91:D4E1 6B          RTL
}


;;; $D4E2: Unused. PLP : RTL ;;;
{
$91:D4E2 28          PLP
$91:D4E3 6B          RTL
}


;;; $D4E4: Varia suit pick up ;;;
{
$91:D4E4 08          PHP
$91:D4E5 8B          PHB
$91:D4E6 4B          PHK                    ;\
$91:D4E7 AB          PLB                    ;} DB = $91
$91:D4E8 E2 30       SEP #$30
$91:D4EA A9 30       LDA #$30               ;\
$91:D4EC 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;} Suit pickup colour math subscreen backdrop red component = 10h
$91:D4EF A9 50       LDA #$50               ;\
$91:D4F1 8D F1 0D    STA $0DF1  [$7E:0DF1]  ;} Suit pickup colour math subscreen backdrop green component = 10h
$91:D4F4 A9 80       LDA #$80               ;\
$91:D4F6 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;} Suit pickup colour math subscreen backdrop blue component = 0
$91:D4F9 9C F3 0D    STZ $0DF3  [$7E:0DF3]  ; Suit pickup palette transition colour = orange
$91:D4FC C2 30       REP #$30
$91:D4FE 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:D502 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$91:D505 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$91:D508 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:D50B 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:D50E 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:D511 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:D514 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:D517 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:D51A 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:D51D 9C 18 0E    STZ $0E18  [$7E:0E18]  ; Elevator status = inactive
$91:D520 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; Suit pickup stage = 0
$91:D523 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ; Suit pickup light beam height = 0
$91:D526 A9 00 01    LDA #$0100             ;\
$91:D529 8D DC 0D    STA $0DDC  [$7E:0DDC]  ;} Suit pickup light beam widening speed = 100h
$91:D52C A2 FE 01    LDX #$01FE             ;\
$91:D52F A9 FF 00    LDA #$00FF             ;|
                                            ;|
$91:D532 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800..99FF = FFh,00h (suit pickup HDMA data table for window 1)
$91:D536 CA          DEX                    ;|
$91:D537 CA          DEX                    ;|
$91:D538 10 F8       BPL $F8    [$D532]     ;/
$91:D53A AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:D53D 29 FF 00    AND #$00FF             ;|
$91:D540 C9 03 00    CMP #$0003             ;} If [Samus movement type] != spin jumping:
$91:D543 F0 05       BEQ $05    [$D54A]     ;/
$91:D545 C9 14 00    CMP #$0014             ;\
$91:D548 D0 07       BNE $07    [$D551]     ;} If [Samus movement type] != wall jumping: go to BRANCH_NOT_SPINNING

$91:D54A A9 32 00    LDA #$0032             ;\
$91:D54D 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 9 (spin jump end)

; BRANCH_NOT_SPINNING
$91:D551 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:D554 89 20 00    BIT #$0020             ;} If gravity suit not equipped:
$91:D557 D0 08       BNE $08    [$D561]     ;/
$91:D559 A9 00 00    LDA #$0000             ;\
$91:D55C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - power suit
$91:D55F 80 06       BRA $06    [$D567]

$91:D561 A9 9B 00    LDA #$009B             ;\ Else (gravity suit equipped):
$91:D564 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit

$91:D567 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:D56B 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:D56F A9 15 00    LDA #$0015             ;\
$91:D572 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus into suit pickup
$91:D576 AD 11 09    LDA $0911  [$7E:0911]  ;\
$91:D579 18          CLC                    ;|
$91:D57A 69 78 00    ADC #$0078             ;} Samus X position = [layer 1 X position] + 78h
$91:D57D 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$91:D580 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$91:D583 AD 15 09    LDA $0915  [$7E:0915]  ;\
$91:D586 18          CLC                    ;|
$91:D587 69 88 00    ADC #$0088             ;} Samus Y position = [layer 1 Y position] + 88h
$91:D58A 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:D58D 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:D590 A9 56 00    LDA #$0056             ;\
$91:D593 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 56h, sound library 2, max queued sounds allowed = 6 (acquired suit)
$91:D597 22 35 84 88 JSL $888435[$88:8435]  ;\
$91:D59B             dx 41, 26, D5A2        ;} Spawn indirect HDMA object for window 1 position with instruction list $D5A2
$91:D59F AB          PLB
$91:D5A0 28          PLP
$91:D5A1 6B          RTL
}


;;; $D5A2: HDMA object instruction list - window 1 position - varia suit pickup ;;;
{
$91:D5A2             dx 8655,00,    ; HDMA table bank = $00
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        85B4,91D692,; Initialise suit pickup HDMA
                        0001,0A88,
                        8570,88E026,; Pre-instruction = $88:E026
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $D5BA: Gravity suit pick up ;;;
{
$91:D5BA 08          PHP
$91:D5BB 8B          PHB
$91:D5BC 4B          PHK                    ;\
$91:D5BD AB          PLB                    ;} DB = $91
$91:D5BE E2 30       SEP #$30
$91:D5C0 A9 30       LDA #$30               ;\
$91:D5C2 8D F0 0D    STA $0DF0  [$7E:0DF0]  ;} Suit pickup colour math subscreen backdrop red component = 10h
$91:D5C5 A9 49       LDA #$49               ;\
$91:D5C7 8D F1 0D    STA $0DF1  [$7E:0DF1]  ;} Suit pickup colour math subscreen backdrop green component = 9
$91:D5CA A9 90       LDA #$90               ;\
$91:D5CC 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;} Suit pickup colour math subscreen backdrop blue component = 0
$91:D5CF A9 01       LDA #$01               ;\
$91:D5D1 8D F3 0D    STA $0DF3  [$7E:0DF3]  ;} Suit pickup palette transition colour = blue
$91:D5D4 C2 30       REP #$30
$91:D5D6 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:D5DA 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$91:D5DD 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$91:D5E0 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:D5E3 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:D5E6 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:D5E9 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:D5EC 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:D5EF 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:D5F2 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:D5F5 9C 18 0E    STZ $0E18  [$7E:0E18]  ; Elevator status = inactive
$91:D5F8 9C EC 0D    STZ $0DEC  [$7E:0DEC]  ; Suit pickup stage = 0
$91:D5FB 9C EE 0D    STZ $0DEE  [$7E:0DEE]  ; Suit pickup light beam height = 0
$91:D5FE A9 00 01    LDA #$0100             ;\
$91:D601 8D DC 0D    STA $0DDC  [$7E:0DDC]  ;} Suit pickup light beam widening speed = 100h
$91:D604 A2 FE 01    LDX #$01FE             ;\
$91:D607 A9 FF 00    LDA #$00FF             ;|
                                            ;|
$91:D60A 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800..99FF = FFh,00h (suit pickup HDMA data table for window 1)
$91:D60E CA          DEX                    ;|
$91:D60F CA          DEX                    ;|
$91:D610 10 F8       BPL $F8    [$D60A]     ;/
$91:D612 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:D615 29 FF 00    AND #$00FF             ;|
$91:D618 C9 03 00    CMP #$0003             ;} If [Samus movement type] != spin jumping:
$91:D61B F0 05       BEQ $05    [$D622]     ;/
$91:D61D C9 14 00    CMP #$0014             ;\
$91:D620 D0 07       BNE $07    [$D629]     ;} If [Samus movement type] != wall jumping: go to BRANCH_NOT_SPINNING

$91:D622 A9 32 00    LDA #$0032             ;\
$91:D625 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 9 (spin jump end)

; BRANCH_NOT_SPINNING
$91:D629 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:D62C 89 01 00    BIT #$0001             ;} If varia suit not equipped:
$91:D62F D0 08       BNE $08    [$D639]     ;/
$91:D631 A9 00 00    LDA #$0000             ;\
$91:D634 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - power suit
$91:D637 80 06       BRA $06    [$D63F]

$91:D639 A9 9B 00    LDA #$009B             ;\ Else (gravity suit equipped):
$91:D63C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit

$91:D63F 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:D643 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:D647 A9 15 00    LDA #$0015             ;\
$91:D64A 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - lock Samus into suit pickup
$91:D64E AD 11 09    LDA $0911  [$7E:0911]  ;\
$91:D651 18          CLC                    ;|
$91:D652 69 78 00    ADC #$0078             ;} Samus X position = [layer 1 X position] + 78h
$91:D655 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$91:D658 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$91:D65B AD 15 09    LDA $0915  [$7E:0915]  ;\
$91:D65E 18          CLC                    ;|
$91:D65F 69 88 00    ADC #$0088             ;} Samus Y position = [layer 1 Y position] + 88h
$91:D662 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:D665 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:D668 A9 56 00    LDA #$0056             ;\
$91:D66B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 56h, sound library 2, max queued sounds allowed = 6 (acquired suit)
$91:D66F 22 35 84 88 JSL $888435[$88:8435]  ;\
$91:D673             dx 41, 26, D67A        ;} Spawn indirect HDMA object for window 1 position with instruction list $D67A
$91:D677 AB          PLB
$91:D678 28          PLP
$91:D679 6B          RTL
}


;;; $D67A: HDMA object instruction list - window 1 position - gravity suit pickup ;;;
{
$91:D67A             dx 8655,00,    ; HDMA table bank = $00
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        85B4,91D692,; Initialise suit pickup HDMA
                        0001,0A88,
                        8570,88E05C,; Pre-instruction = $88:E05C
                        8682,       ; Sleep
                        8569        ; Delete
}


;;; $D692: Initialise suit pickup HDMA ;;;
{
$91:D692 08          PHP
$91:D693 8B          PHB
$91:D694 4B          PHK                    ;\
$91:D695 AB          PLB                    ;} DB = $91
$91:D696 E2 30       SEP #$30
$91:D698 A9 13       LDA #$13               ;\
$91:D69A 85 69       STA $69    [$7E:0069]  ;} Main screen layers = BG1/BG2/sprites
$91:D69C A9 13       LDA #$13               ;\
$91:D69E 85 6C       STA $6C    [$7E:006C]  ;} Disable BG1/BG2/sprites in window area main screen
$91:D6A0 A9 04       LDA #$04               ;\
$91:D6A2 85 6B       STA $6B    [$7E:006B]  ;} Subscreen layers = BG3
$91:D6A4 A9 04       LDA #$04               ;\
$91:D6A6 85 6D       STA $6D    [$7E:006D]  ;} Disable BG3 in window area subscreen
$91:D6A8 A9 10       LDA #$10               ;\
$91:D6AA 85 6E       STA $6E    [$7E:006E]  ;} Restrict colour math to inside window
$91:D6AC A9 00       LDA #$00               ;\
$91:D6AE 85 60       STA $60    [$7E:0060]  ;} Disable BG1/BG2 window 1/2 masking
$91:D6B0 A9 02       LDA #$02               ;\
$91:D6B2 85 61       STA $61    [$7E:0061]  ;} Enable BG3 window 1 inclusive mask
$91:D6B4 A9 20       LDA #$20               ;\
$91:D6B6 85 62       STA $62    [$7E:0062]  ;} Enable colour math window 1 inclusive mask
$91:D6B8 A9 33       LDA #$33               ;\
$91:D6BA 85 71       STA $71    [$7E:0071]  ;} Enable colour math on BG1/BG2/sprites/backdrop
$91:D6BC AD F0 0D    LDA $0DF0  [$7E:0DF0]  ;\
$91:D6BF 85 74       STA $74    [$7E:0074]  ;} Colour math subscreen backdrop colour 0 = [$0DF0]
$91:D6C1 AD F1 0D    LDA $0DF1  [$7E:0DF1]  ;\
$91:D6C4 85 75       STA $75    [$7E:0075]  ;} Colour math subscreen backdrop colour 1 = [$0DF1]
$91:D6C6 AD F2 0D    LDA $0DF2  [$7E:0DF2]  ;\
$91:D6C9 85 76       STA $76    [$7E:0076]  ;} Colour math subscreen backdrop colour 2 = [$0DF2]
$91:D6CB C2 30       REP #$30
$91:D6CD A9 E4 00    LDA #$00E4             ;\
$91:D6D0 8D 88 0A    STA $0A88  [$7E:0A88]  ;|
$91:D6D3 A9 00 98    LDA #$9800             ;|
$91:D6D6 8D 89 0A    STA $0A89  [$7E:0A89]  ;|
$91:D6D9 A9 E4 00    LDA #$00E4             ;|
$91:D6DC 8D 8B 0A    STA $0A8B  [$7E:0A8B]  ;|
$91:D6DF A9 C8 98    LDA #$98C8             ;} $0A88..92 = E4h,$9800, E4h,$98C8, 98h,$9990, 00h,00h
$91:D6E2 8D 8C 0A    STA $0A8C  [$7E:0A8C]  ;|
$91:D6E5 A9 98 00    LDA #$0098             ;|
$91:D6E8 8D 8E 0A    STA $0A8E  [$7E:0A8E]  ;|
$91:D6EB A9 90 99    LDA #$9990             ;|
$91:D6EE 8D 8F 0A    STA $0A8F  [$7E:0A8F]  ;|
$91:D6F1 9C 91 0A    STZ $0A91  [$7E:0A91]  ;/
$91:D6F4 AB          PLB
$91:D6F5 28          PLP
$91:D6F6 6B          RTL
}


;;; $D6F7..DE52: Samus palette handling ;;;
{
;;; $D6F7: Handle Samus palette ;;;
{
; Also handles super jump timer
$91:D6F7 08          PHP
$91:D6F8 8B          PHB
$91:D6F9 4B          PHK                    ;\
$91:D6FA AB          PLB                    ;} DB = $91
$91:D6FB C2 30       REP #$30
$91:D6FD AD 4A 0A    LDA $0A4A  [$7E:0A4A]  ;\
$91:D700 10 06       BPL $06    [$D708]     ;} If acquiring hyper beam palette:
$91:D702 20 A5 D8    JSR $D8A5  [$91:D8A5]  ; Handle misc. Samus palette
$91:D705 AB          PLB
$91:D706 28          PLP
$91:D707 6B          RTL                    ; Return

$91:D708 20 43 D7    JSR $D743  [$91:D743]  ; Handle beam charge palettes
$91:D70B B0 0A       BCS $0A    [$D717]     ; If carry clear (glow has not ended):
$91:D70D AD CC 0A    LDA $0ACC  [$7E:0ACC]  ;\
$91:D710 0A          ASL A                  ;|
$91:D711 AA          TAX                    ;} Execute [$D72D + [special Samus palette type] * 2]
$91:D712 FC 2D D7    JSR ($D72D,x)[$91:D9B2];/
$91:D715 B0 0A       BCS $0A    [$D721]     ; If carry set: go to BRANCH_RETURN

$91:D717 AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:D71A BD 27 D7    LDA $D727,x[$91:D727]  ;} X = [$D727 + [Samus suit palette index]]
$91:D71D AA          TAX                    ;/
$91:D71E 20 5B DD    JSR $DD5B  [$91:DD5B]  ; Samus palette = 20h bytes from $9B:[X]

; BRANCH_RETURN
$91:D721 20 A5 D8    JSR $D8A5  [$91:D8A5]  ; Handle misc. Samus palette
$91:D724 AB          PLB
$91:D725 28          PLP
$91:D726 6B          RTL

; Samus palette pointers. Normal
$91:D727             dw 9400, ; Power suit
                        9520, ; Varia suit
                        9800  ; Gravity suit

$91:D72D             dw D9B2, ; 0: Screw attacking / speed boosting
                        DAC7, ; 1: Speed booster shine
                        D8A5, ; 2: Unused
                        0000,
                        0000,
                        0000,
                        DB3A, ; 6: Shinesparking
                        DB93, ; 7: Crystal flash
                        DCB4, ; 8: X-ray
                        D83F, ; 9: Unused
                        DD31  ; Ah: RTS. Unused
}


;;; $D743: Handle beam charge palettes ;;;
{
;; Returns:
;;     Carry: Set if charged shot glow has ended, clear otherwise

; Including beam charging, charged shot / grapple glow, pseudo screw attack, also calls visor palette handler
$91:D743 AD 18 0B    LDA $0B18  [$7E:0B18]  ;\
$91:D746 D0 4C       BNE $4C    [$D794]     ;} If [charged shot glow timer] != 0: go to BRANCH_CHARGED_SHOT_GLOW
$91:D748 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$91:D74B C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] != inactive: go to BRANCH_NO_CHARGE_GLOW
$91:D74E D0 60       BNE $60    [$D7B0]     ;/
$91:D750 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$91:D753 F0 5B       BEQ $5B    [$D7B0]     ;} If [beam charge counter] = 0: go to BRANCH_NO_CHARGE_GLOW
$91:D755 C9 3C 00    CMP #$003C             ;\
$91:D758 30 56       BMI $56    [$D7B0]     ;} If [beam charge counter] < 3Ch: go to BRANCH_NO_CHARGE_GLOW
$91:D75A AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$91:D75D C9 04 00    CMP #$0004             ;} If [Samus contact damage index] = pseudo screw attacking:
$91:D760 D0 0A       BNE $0A    [$D76C]     ;/
$91:D762 AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:D765 BD FF D7    LDA $D7FF,x[$91:D801]  ;} $24 = [$D7FF + [Samus suit palette index]]
$91:D768 85 24       STA $24    [$7E:0024]  ;/
$91:D76A 80 08       BRA $08    [$D774]

$91:D76C AE 74 0A    LDX $0A74  [$7E:0A74]  ;\ Else ([Samus contact damage index] != pseudo screw attacking):
$91:D76F BD D5 D7    LDA $D7D5,x[$91:D7D5]  ;} $24 = [$D7D5 + [Samus suit palette index]]
$91:D772 85 24       STA $24    [$7E:0024]  ;/

$91:D774 AD 62 0B    LDA $0B62  [$7E:0B62]  ;\
$91:D777 18          CLC                    ;|
$91:D778 65 24       ADC $24    [$7E:0024]  ;|
$91:D77A AA          TAX                    ;} Samus palette = 20h bytes from $9B:0000 + [[$24] + [Samus charge palette index]]
$91:D77B BD 00 00    LDA $0000,x[$91:D7DB]  ;|
$91:D77E AA          TAX                    ;|
$91:D77F 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:D782 AD 62 0B    LDA $0B62  [$7E:0B62]  ;\
$91:D785 1A          INC A                  ;|
$91:D786 1A          INC A                  ;|
$91:D787 C9 0C 00    CMP #$000C             ;|
$91:D78A 30 03       BMI $03    [$D78F]     ;} Samus charge palette index = ([Samus charge palette index] + 2) % Ch
$91:D78C A9 00 00    LDA #$0000             ;|
                                            ;|
$91:D78F 8D 62 0B    STA $0B62  [$7E:0B62]  ;/
$91:D792 18          CLC                    ;\
$91:D793 60          RTS                    ;} Return carry clear

; BRANCH_CHARGED_SHOT_GLOW
$91:D794 AD 76 0A    LDA $0A76  [$7E:0A76]  ;\
$91:D797 D0 1D       BNE $1D    [$D7B6]     ;} If hyper beam is enabled: go to BRANCH_HYPER_BEAM
$91:D799 CE 18 0B    DEC $0B18  [$7E:0B18]  ; Decrement charged shot glow timer
$91:D79C F0 10       BEQ $10    [$D7AE]     ; If [charged shot glow timer] = 0: return carry set
$91:D79E A2 1C 00    LDX #$001C             ;\
$91:D7A1 A9 FF 03    LDA #$03FF             ;|
                                            ;|
$91:D7A4 9F 82 C1 7E STA $7EC182,x[$7E:C19E];} Samus palette colours 1..Fh = (31, 31, 0) (yellow)
$91:D7A8 CA          DEX                    ;|
$91:D7A9 CA          DEX                    ;|
$91:D7AA 10 F8       BPL $F8    [$D7A4]     ;/
$91:D7AC 18          CLC                    ;\
$91:D7AD 60          RTS                    ;} Return carry clear

$91:D7AE 38          SEC
$91:D7AF 60          RTS

; BRANCH_NO_CHARGE_GLOW
$91:D7B0 9C 62 0B    STZ $0B62  [$7E:0B62]  ; Samus charge palette index = 0
$91:D7B3 4C 3F D8    JMP $D83F  [$91:D83F]  ; Go to handle visor palette (returns carry clear)

; BRANCH_HYPER_BEAM
$91:D7B6 AD 18 0B    LDA $0B18  [$7E:0B18]  ;\
$91:D7B9 89 01 00    BIT #$0001             ;} If [charged shot glow timer] % 2 = 0:
$91:D7BC D0 0D       BNE $0D    [$D7CB]     ;/
$91:D7BE 29 1E 00    AND #$001E             ;\
$91:D7C1 F0 0D       BEQ $0D    [$D7D0]     ;} If [charged shot glow timer] % 20h = 0: go to BRANCH_END_GLOW
$91:D7C3 A8          TAY                    ;\
$91:D7C4 B9 29 D8    LDA $D829,y[$91:D83D]  ;|
$91:D7C7 AA          TAX                    ;} Samus palette = 20h bytes from $9B:0000 + [$D829 + [charged shot glow timer]]
$91:D7C8 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/

$91:D7CB CE 18 0B    DEC $0B18  [$7E:0B18]  ; Decrement charged shot glow timer
$91:D7CE 18          CLC                    ;\
$91:D7CF 60          RTS                    ;} Return carry clear

; BRANCH_END_GLOW
$91:D7D0 9C 18 0B    STZ $0B18  [$7E:0B18]  ; Charged shot glow timer = 0
$91:D7D3 38          SEC                    ;\
$91:D7D4 60          RTS                    ;} Return carry set

; Samus palette table. Beam charge
$91:D7D5             dw D7DB, D7E7, D7F3

$91:D7DB             dw 9820,9840,9860,9880,9860,9840 ; Power suit
$91:D7E7             dw 9920,9940,9960,9980,9960,9940 ; Varia suit
$91:D7F3             dw 9A20,9A40,9A60,9A80,9A60,9A40 ; Gravity suit

; Samus palette table. Pseudo screw attack
$91:D7FF             dw D805, D811, D81D

$91:D805             dw 9C80,9C80,9C80,9400,9400,9400 ; Power suit
$91:D811             dw 9E80,9E80,9E80,9520,9520,9520 ; Varia suit
$91:D81D             dw A080,A080,A080,9800,9800,9800 ; Gravity suit

; Hyper beam palette table (with a padding zero)
$91:D829             dw 0000, A360, A340, A320, A300, A2E0, A2C0, A2A0, A280, A260, A240
}


;;; $D83F: Handle visor palette ;;;
{
;; Returns:
;;     Carry: Clear

; For colour math backdrop rooms. Does not handle x-ray
$91:D83F AD CC 0A    LDA $0ACC  [$7E:0ACC]  ;\
$91:D842 C9 08 00    CMP #$0008             ;} If [special Samus palette type] = x-ray:
$91:D845 D0 02       BNE $02    [$D849]     ;/
$91:D847 18          CLC                    ;\
$91:D848 60          RTS                    ;} Return carry clear

$91:D849 AD 82 19    LDA $1982  [$7E:1982]  ;\
$91:D84C C9 28 00    CMP #$0028             ;} If [default layer blending configuration] != 28h:
$91:D84F F0 05       BEQ $05    [$D856]     ;/
$91:D851 C9 2A 00    CMP #$002A             ;\
$91:D854 D0 47       BNE $47    [$D89D]     ;} If [default layer blending configuration] != 2Ah: go to BRANCH_NORMAL

$91:D856 AD 72 0A    LDA $0A72  [$7E:0A72]  ;\
$91:D859 3A          DEC A                  ;} Decrement Samus visor palette timer
$91:D85A 8D 72 0A    STA $0A72  [$7E:0A72]  ;/
$91:D85D 89 FF 00    BIT #$00FF             ;\
$91:D860 F0 02       BEQ $02    [$D864]     ;} If [Samus visor palette timer] != 0:
$91:D862 D0 E3       BNE $E3    [$D847]     ; Return carry clear

$91:D864 09 05 00    ORA #$0005             ;\
$91:D867 8D 72 0A    STA $0A72  [$7E:0A72]  ;} Samus visor palette timer = 5
$91:D86A EB          XBA                    ;\
$91:D86B 29 FF 00    AND #$00FF             ;|
$91:D86E AA          TAX                    ;} Sprite palette 4 colour 4 (Samus visor) = [$9B:A3C0 + [Samus visor palette index]]
$91:D86F BF C0 A3 9B LDA $9BA3C0,x[$9B:A3C6];|
$91:D873 8F 88 C1 7E STA $7EC188[$7E:C188]  ;/
$91:D877 8A          TXA                    ;\
$91:D878 1A          INC A                  ;|
$91:D879 1A          INC A                  ;} If [Samus visor palette index] >= Ah:
$91:D87A C9 0C 00    CMP #$000C             ;|
$91:D87D 30 0E       BMI $0E    [$D88D]     ;/
$91:D87F AD 72 0A    LDA $0A72  [$7E:0A72]  ;\
$91:D882 29 FF 00    AND #$00FF             ;|
$91:D885 09 00 06    ORA #$0600             ;} Samus visor palette index = 6
$91:D888 8D 72 0A    STA $0A72  [$7E:0A72]  ;/
$91:D88B 18          CLC                    ;\
$91:D88C 60          RTS                    ;} Return carry clear

$91:D88D EB          XBA                    ;\
$91:D88E 85 12       STA $12    [$7E:0012]  ;|
$91:D890 AD 72 0A    LDA $0A72  [$7E:0A72]  ;|
$91:D893 29 FF 00    AND #$00FF             ;} Samus visor palette index += 2
$91:D896 05 12       ORA $12    [$7E:0012]  ;|
$91:D898 8D 72 0A    STA $0A72  [$7E:0A72]  ;/
$91:D89B 18          CLC                    ;\
$91:D89C 60          RTS                    ;} Return carry clear

; BRANCH_NORMAL
$91:D89D A9 01 06    LDA #$0601             ;\
$91:D8A0 8D 72 0A    STA $0A72  [$7E:0A72]  ;} Samus visor palette timer = 1, Samus visor palette index = 6
$91:D8A3 18          CLC                    ;\
$91:D8A4 60          RTS                    ;} Return carry clear
}


;;; $D8A5: Handle misc. Samus palette ;;;
{
; This stuff happens after (pseudo) screw attacking / speed boosting / speed booster shine / shinesparking / crystal flash / x-ray / beam effects,
; so takes priority

; In the PAL version, there's a time is frozen check at BRANCH_NON_HURT_SFX to prevent spin jump sound playing through reserve tank activation

$91:D8A5 AD 4A 0A    LDA $0A4A  [$7E:0A4A]  ;\
$91:D8A8 D0 06       BNE $06    [$D8B0]     ;} If [super special Samus palette flags] = 0:
$91:D8AA AD 48 0A    LDA $0A48  [$7E:0A48]  ;\
$91:D8AD D0 04       BNE $04    [$D8B3]     ;} If [Samus hurt flash counter] = 0:
$91:D8AF 60          RTS                    ; Return

                                            ; Else ([super special Samus palette flags] != 0):
$91:D8B0 4C 54 D9    JMP $D954  [$91:D954]  ; Go to BRANCH_SUPER_SPECIAL

$91:D8B3 C9 02 00    CMP #$0002             ;\
$91:D8B6 D0 21       BNE $21    [$D8D9]     ;} If [Samus hurt flash counter] != 2: go to BRANCH_NOT_HURT_FRAME_2
$91:D8B8 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:D8BB D0 19       BNE $19    [$D8D6]     ;} If [cinematic function] != 0: go to BRANCH_NO_SFX
$91:D8BD AD 44 0A    LDA $0A44  [$7E:0A44]  ;\
$91:D8C0 C9 D9 E8    CMP #$E8D9             ;} If [Samus new state handler] = $E8D9 (RTL):
$91:D8C3 D0 08       BNE $08    [$D8CD]     ;/
$91:D8C5 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:D8C8 C9 54 00    CMP #$0054             ;} If [Samus pose] = 54h (facing left  - knockback): go to BRANCH_NO_SFX
$91:D8CB F0 09       BEQ $09    [$D8D6]     ;/

$91:D8CD A9 35 00    LDA #$0035             ;\ Else ([Samus new state handler] != $E8D9):
$91:D8D0 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 35h, sound library 1, max queued sounds allowed = 6 (Samus damaged)
$91:D8D4 80 15       BRA $15    [$D8EB]     ; Go to BRANCH_NOT_HURT_FLASH

; BRANCH_NO_SFX
$91:D8D6 AD 48 0A    LDA $0A48  [$7E:0A48]

; BRANCH_NOT_HURT_FRAME_2
$91:D8D9 C9 07 00    CMP #$0007             ;\
$91:D8DC 10 1E       BPL $1E    [$D8FC]     ;} If [Samus hurt flash counter] >= 7: go to BRANCH_HURT_FLASH_DONE
$91:D8DE 89 01 00    BIT #$0001             ;\
$91:D8E1 F0 08       BEQ $08    [$D8EB]     ;} If [Samus hurt flash counter] % 2 = 0: go to BRANCH_NOT_HURT_FLASH
$91:D8E3 A2 80 A3    LDX #$A380             ;\
$91:D8E6 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = [$A380..9F] (hurt flash)
$91:D8E9 80 11       BRA $11    [$D8FC]     ; Go to BRANCH_HURT_FLASH_DONE

; BRANCH_NOT_HURT_FLASH
$91:D8EB AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:D8EE F0 08       BEQ $08    [$D8F8]     ;} If [cinematic function] != 0:
$91:D8F0 A2 A0 A3    LDX #$A3A0             ;\
$91:D8F3 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = [$A3A0..BF] (intro Samus (greyscale))
$91:D8F6 80 04       BRA $04    [$D8FC]     ; Go to BRANCH_HURT_FLASH_DONE

$91:D8F8 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette

; BRANCH_HURT_FLASH_DONE
$91:D8FC AD 48 0A    LDA $0A48  [$7E:0A48]  ;\
$91:D8FF 1A          INC A                  ;} Increment Samus hurt flash counter
$91:D900 8D 48 0A    STA $0A48  [$7E:0A48]  ;/
$91:D903 C9 28 00    CMP #$0028             ;\
$91:D906 F0 09       BEQ $09    [$D911]     ;} If [Samus hurt flash counter] = 28h: go to BRANCH_NON_HURT_SFX
$91:D908 C9 3C 00    CMP #$003C             ;\
$91:D90B 30 03       BMI $03    [$D910]     ;} If [Samus hurt flash counter] >= 3Ch:
$91:D90D 9C 48 0A    STZ $0A48  [$7E:0A48]  ; Samus hurt flash counter = 0

$91:D910 60          RTS                    ; Return

; BRANCH_NON_HURT_SFX
$91:D911 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$91:D914 C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] = inactive:
$91:D917 D0 26       BNE $26    [$D93F]     ;/
$91:D919 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:D91C 29 FF 00    AND #$00FF             ;|
$91:D91F C9 03 00    CMP #$0003             ;} If [Samus movement type] = spin jumping: go to BRANCH_SPINNING
$91:D922 F0 28       BEQ $28    [$D94C]     ;/
$91:D924 C9 14 00    CMP #$0014             ;\
$91:D927 F0 23       BEQ $23    [$D94C]     ;} If [Samus movement type] = wall jumping: go to BRANCH_SPINNING
$91:D929 AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\
$91:D92C C9 10 00    CMP #$0010             ;} If [flare counter] < 10h: return
$91:D92F 30 DF       BMI $DF    [$D910]     ;/
$91:D931 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:D933 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not pressing shoot: return
$91:D936 F0 D8       BEQ $D8    [$D910]     ;/
$91:D938 A9 01 00    LDA #$0001             ;\
$91:D93B 8D C0 0D    STA $0DC0  [$7E:0DC0]  ;} Resume charging beam sound effect flag = 1
$91:D93E 60          RTS                    ; Return

$91:D93F C9 56 C8    CMP #$C856             ;\
$91:D942 10 CC       BPL $CC    [$D910]     ;} If [grapple beam function] >= cancel: return
$91:D944 A9 06 00    LDA #$0006             ;\
$91:D947 22 2B 90 80 JSL $80902B[$80:902B]  ;} Queue sound 6, sound library 1, max queued sounds allowed = 9 (grappling)
$91:D94B 60          RTS                    ; Return

; BRANCH_SPINNING
$91:D94C A9 1C 00    LDA #$001C             ;\
$91:D94F 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - play spin jump sound if spin jumping
$91:D953 60          RTS                    ; Return

; BRANCH_SUPER_SPECIAL
$91:D954 30 19       BMI $19    [$D96F]     ; If [super special Samus palette flags] & 8000h != 0: go to BRANCH_ACQUIRING_HYPER_BEAM
$91:D956 89 01 00    BIT #$0001             ;\
$91:D959 F0 0C       BEQ $0C    [$D967]     ;} If [super special Samus palette flags] & 1 != 0:
$91:D95B AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:D95E BD 98 D9    LDA $D998,x[$91:D99C]  ;|
$91:D961 AA          TAX                    ;} Samus palette = 20h bytes from $9B:0000 + [$D998 + [Samus suit palette index]]
$91:D962 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:D965 80 04       BRA $04    [$D96B]
                                            ; Else ([super special Samus palette flags] & 1 = 0):
$91:D967 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette

$91:D96B EE 4A 0A    INC $0A4A  [$7E:0A4A]  ; Increment super special Samus palette flags
$91:D96E 60          RTS                    ; Return

; BRANCH_ACQUIRING_HYPER_BEAM
$91:D96F AD 62 0B    LDA $0B62  [$7E:0B62]  ;\
$91:D972 0A          ASL A                  ;|
$91:D973 A8          TAY                    ;|
$91:D974 B9 9E D9    LDA $D99E,y[$91:D99E]  ;} Samus palette = 20h bytes from $9B:0000 + [$D99E + [Samus' charge palette index] * 2]
$91:D977 AA          TAX                    ;|
$91:D978 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:D97B CE D0 0A    DEC $0AD0  [$7E:0AD0]  ; Decrement rainbow Samus palette timer
$91:D97E F0 02       BEQ $02    [$D982]     ;\
$91:D980 10 15       BPL $15    [$D997]     ;} If [rainbow Samus palette timer] > 0: return

$91:D982 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:D985 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} Rainbow Samus palette timer = [special Samus palette delay]
$91:D988 AD 62 0B    LDA $0B62  [$7E:0B62]  ;\
$91:D98B 1A          INC A                  ;|
$91:D98C 8D 62 0B    STA $0B62  [$7E:0B62]  ;|
$91:D98F C9 0A 00    CMP #$000A             ;} Samus' charge palette index = ([Samus' charge palette index] + 1) % Ah
$91:D992 30 03       BMI $03    [$D997]     ;|
$91:D994 9C 62 0B    STZ $0B62  [$7E:0B62]  ;/

$91:D997 60          RTS

; Samus palette pointers. Speed boosting palettes
$91:D998             dw 9B80, ; Power suit
                        9D80, ; Varia suit
                        9F80  ; Gravity suit

; Samus palette pointers. Hyper beam
$91:D99E             dw A360, A340, A320, A300, A2E0, A2C0, A2A0, A280, A260, A240
}


;;; $D9B2: Handle screw attacking / speed boosting palette ;;;
{
;; Returns:
;;     Carry: Clear to use normal suit palette, set otherwise
$91:D9B2 AD 74 0A    LDA $0A74  [$7E:0A74]  ;\
$91:D9B5 89 04 00    BIT #$0004             ;} If [Samus suit palette index] = gravity suit: go to BRANCH_NON_LIQUID_PHYSICS
$91:D9B8 D0 20       BNE $20    [$D9DA]     ;/
$91:D9BA 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $14 = Samus top boundary
$91:D9BE AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:D9C1 30 0E       BMI $0E    [$D9D1]     ;} If [FX Y position] >= 0:
$91:D9C3 C5 14       CMP $14    [$7E:0014]  ;\
$91:D9C5 10 13       BPL $13    [$D9DA]     ;} If [FX Y position] >= (Samus top boundary): go to BRANCH_NON_LIQUID_PHYSICS
$91:D9C7 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:D9CA 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$91:D9CD D0 0B       BNE $0B    [$D9DA]     ;/
$91:D9CF 80 24       BRA $24    [$D9F5]     ; Return set

$91:D9D1 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$91:D9D4 30 04       BMI $04    [$D9DA]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$91:D9D6 C5 14       CMP $14    [$7E:0014]  ;\
$91:D9D8 30 1B       BMI $1B    [$D9F5]     ;} If [lava/acid Y position] < (Samus top boundary): return carry set

; BRANCH_NON_LIQUID_PHYSICS
$91:D9DA AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:D9DD 29 FF 00    AND #$00FF             ;|
$91:D9E0 C9 03 00    CMP #$0003             ;} If [Samus movement type] = spin jumping: go to BRANCH_SPIN_JUMPING
$91:D9E3 F0 12       BEQ $12    [$D9F7]     ;/
$91:D9E5 C9 14 00    CMP #$0014             ;\
$91:D9E8 F0 21       BEQ $21    [$DA0B]     ;} If [Samus movement type] = wall jumping: go to BRANCH_WALL_JUMPING

; BRANCH_NOT_SCREW_ATTACKING
$91:D9EA AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$91:D9ED 29 00 FF    AND #$FF00             ;|
$91:D9F0 C9 00 04    CMP #$0400             ;} If speed boosting: go to BRANCH_SPEED_BOOSTING
$91:D9F3 F0 7F       BEQ $7F    [$DA74]     ;/

$91:D9F5 38          SEC                    ;\
$91:D9F6 60          RTS                    ;} Return carry set

; BRANCH_SPIN_JUMPING
$91:D9F7 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:D9FA 89 08 00    BIT #$0008             ;} If screw attack not equipped: go to BRANCH_NOT_SCREW_ATTACKING
$91:D9FD F0 EB       BEQ $EB    [$D9EA]     ;/
$91:D9FF AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$91:DA02 F0 3F       BEQ $3F    [$DA43]     ;} If [Samus animation frame] = 0: go to BRANCH_NO_PALETTE_UPDATE
$91:DA04 C9 1B 00    CMP #$001B             ;\
$91:DA07 10 3F       BPL $3F    [$DA48]     ;} If [Samus animation frame] >= 1Bh (wall jump eligible): return carry clear
$91:DA09 80 10       BRA $10    [$DA1B]     ; Go to BRANCH_MERGE

; BRANCH_WALL_JUMPING
$91:DA0B AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:DA0E 89 08 00    BIT #$0008             ;} If screw attack not equipped: return carry set
$91:DA11 F0 33       BEQ $33    [$DA46]     ;/
$91:DA13 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$91:DA16 C9 03 00    CMP #$0003             ;} If [Samus animation frame] < 3: go to BRANCH_NO_PALETTE_UPDATE
$91:DA19 30 28       BMI $28    [$DA43]     ;/

; BRANCH_MERGE
$91:DA1B AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:DA1E BD 4A DA    LDA $DA4A,x[$91:DA4E]  ;|
$91:DA21 85 24       STA $24    [$7E:0024]  ;|
$91:DA23 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;|
$91:DA26 18          CLC                    ;|
$91:DA27 65 24       ADC $24    [$7E:0024]  ;} Samus palette = 20h bytes from $9B:0000 + [[$DA4A + [Samus suit palette index]] + [special Samus palette frame]]
$91:DA29 AA          TAX                    ;|
$91:DA2A BD 00 00    LDA $0000,x[$91:DA68]  ;|
$91:DA2D AA          TAX                    ;|
$91:DA2E 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:DA31 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DA34 1A          INC A                  ;|
$91:DA35 1A          INC A                  ;|
$91:DA36 C9 0C 00    CMP #$000C             ;|
$91:DA39 30 03       BMI $03    [$DA3E]     ;} Special Samus palette frame = ([special Samus palette frame] + 2) % Ch
$91:DA3B A9 00 00    LDA #$0000             ;|
                                            ;|
$91:DA3E 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/
$91:DA41 38          SEC                    ;\
$91:DA42 60          RTS                    ;} Return carry set

; BRANCH_NO_PALETTE_UPDATE
$91:DA43 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0

$91:DA46 38          SEC                    ;\
$91:DA47 60          RTS                    ;} Return carry set

$91:DA48 18          CLC
$91:DA49 60          RTS

; Screw attack Samus palette table. Indexed by [Samus suit palette index]
$91:DA4A             dw DA50, DA5C, DA68

; Pointers to bank $9B. Indexed by [special Samus palette frame]
$91:DA50             dw 9CA0,9CC0,9CE0,9D00,9CE0,9CC0 ; No suit
$91:DA5C             dw 9EA0,9EC0,9EE0,9F00,9EE0,9EC0 ; Varia suit
$91:DA68             dw A0A0,A0C0,A0E0,A100,A0E0,A0C0 ; Gravity suit

; BRANCH_SPEED_BOOSTING
$91:DA74 CE D0 0A    DEC $0AD0  [$7E:0AD0]  ; Decrement speed boosting palette timer
$91:DA77 F0 02       BEQ $02    [$DA7B]     ;\
$91:DA79 10 2C       BPL $2C    [$DAA7]     ;} If [speed boosting palette timer] > 0: return carry set

$91:DA7B A9 04 00    LDA #$0004             ;\
$91:DA7E 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} Speed boosting palette timer = 4
$91:DA81 AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:DA84 BD A9 DA    LDA $DAA9,x[$91:DAAB]  ;|
$91:DA87 85 24       STA $24    [$7E:0024]  ;|
$91:DA89 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;|
$91:DA8C 18          CLC                    ;|
$91:DA8D 65 24       ADC $24    [$7E:0024]  ;} Samus palette = 20h bytes from $9B:0000 + [$DAA9 + [Samus suit palette index]] + [special Samus palette frame]
$91:DA8F AA          TAX                    ;|
$91:DA90 BD 00 00    LDA $0000,x[$91:DAB7]  ;|
$91:DA93 AA          TAX                    ;|
$91:DA94 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:DA97 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DA9A 1A          INC A                  ;|
$91:DA9B 1A          INC A                  ;|
$91:DA9C C9 08 00    CMP #$0008             ;|
$91:DA9F 30 03       BMI $03    [$DAA4]     ;} Special Samus palette frame = min(6, [special Samus palette frame] + 2)
$91:DAA1 A9 06 00    LDA #$0006             ;|
                                            ;|
$91:DAA4 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/

$91:DAA7 38          SEC                    ;\
$91:DAA8 60          RTS                    ;} Return carry set

; Samus palette table. Speed boosting
$91:DAA9             dw DAAF, DAB7, DABF

$91:DAAF             dw 9B20,9B40,9B60,9B80 ; No suit
$91:DAB7             dw 9D20,9D40,9D60,9D80 ; Varia suit
$91:DABF             dw 9F20,9F40,9F60,9F80 ; Gravity suit
}


;;; $DAC7: Handle speed booster shine palette ;;;
{
;; Returns:
;;     Carry: Clear to use normal suit palette, set otherwise
$91:DAC7 AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$91:DACA C9 AA 00    CMP #$00AA             ;} If [special Samus palette timer] = AAh:
$91:DACD D0 09       BNE $09    [$DAD8]     ;/
$91:DACF 48          PHA                    ;\
$91:DAD0 A9 0C 00    LDA #$000C             ;|
$91:DAD3 22 2F 91 80 JSL $80912F[$80:912F]  ;} Queue sound Ch, sound library 3, max queued sounds allowed = 9 (stored shinespark)
$91:DAD7 68          PLA                    ;/

$91:DAD8 3A          DEC A                  ;\
$91:DAD9 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Decrement special Samus palette timer
$91:DADC F0 2A       BEQ $2A    [$DB08]     ;\
$91:DADE 30 28       BMI $28    [$DB08]     ;} If [special Samus palette timer] <= 0: go to BRANCH_FINISH
$91:DAE0 AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:DAE3 BD 10 DB    LDA $DB10,x[$91:DB12]  ;|
$91:DAE6 85 24       STA $24    [$7E:0024]  ;|
$91:DAE8 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;|
$91:DAEB 18          CLC                    ;|
$91:DAEC 65 24       ADC $24    [$7E:0024]  ;} Samus palette = 20h bytes from $9B:0000 + [$DB10 + [Samus suit palette index]] + [special Samus palette frame]
$91:DAEE AA          TAX                    ;|
$91:DAEF BD 00 00    LDA $0000,x[$91:DB22]  ;|
$91:DAF2 AA          TAX                    ;|
$91:DAF3 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:DAF6 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DAF9 1A          INC A                  ;|
$91:DAFA 1A          INC A                  ;|
$91:DAFB C9 0C 00    CMP #$000C             ;|
$91:DAFE 30 03       BMI $03    [$DB03]     ;} Special Samus palette frame = ([special Samus palette frame] + 2) % Ch
$91:DB00 A9 00 00    LDA #$0000             ;|
                                            ;|
$91:DB03 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/
$91:DB06 38          SEC                    ;\
$91:DB07 60          RTS                    ;} Return carry set

; BRANCH_FINISH
$91:DB08 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$91:DB0B 9C CC 0A    STZ $0ACC  [$7E:0ACC]  ; Special Samus palette type = 0 (screw attacking / speed boosting)
$91:DB0E 18          CLC                    ;\
$91:DB0F 60          RTS                    ;} Return carry clear

; Speed booster shine Samus palette table. Indexed by [Samus suit palette index]
$91:DB10             dw DB16, DB22, DB2E

; Pointers to bank $9B. Indexed by [special Samus palette frame]
$91:DB16             dw 9BA0, 9BC0, 9BE0, 9C00, 9BE0, 9BC0 ; No suit
$91:DB22             dw 9DA0, 9DC0, 9DE0, 9E00, 9DE0, 9DC0 ; Varia suit
$91:DB2E             dw 9FA0, 9FC0, 9FE0, A000, 9FE0, 9FC0 ; Gravity suit

}


;;; $DB3A: Handle shinesparking palette ;;;
{
;; Returns:
;;     Carry: Clear to use normal suit palette, set otherwise
$91:DB3A AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$91:DB3D 3A          DEC A                  ;} Decrement special Samus palette timer
$91:DB3E 8D 68 0A    STA $0A68  [$7E:0A68]  ;/
$91:DB41 F0 2A       BEQ $2A    [$DB6D]     ;\
$91:DB43 30 28       BMI $28    [$DB6D]     ;} If [special Samus palette timer] <= 0: go to BRANCH_FINISH
$91:DB45 AE 74 0A    LDX $0A74  [$7E:0A74]  ;\
$91:DB48 BD 75 DB    LDA $DB75,x[$91:DB77]  ;|
$91:DB4B 85 24       STA $24    [$7E:0024]  ;|
$91:DB4D AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;|
$91:DB50 18          CLC                    ;|
$91:DB51 65 24       ADC $24    [$7E:0024]  ;} Samus palette = 20h bytes from $9B:0000 + [$DB75 + [Samus suit palette index]] + [special Samus palette frame]
$91:DB53 AA          TAX                    ;|
$91:DB54 BD 00 00    LDA $0000,x[$91:DB83]  ;|
$91:DB57 AA          TAX                    ;|
$91:DB58 20 5B DD    JSR $DD5B  [$91:DD5B]  ;/
$91:DB5B AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DB5E 1A          INC A                  ;|
$91:DB5F 1A          INC A                  ;|
$91:DB60 C9 08 00    CMP #$0008             ;|
$91:DB63 30 03       BMI $03    [$DB68]     ;} Special Samus palette frame = ([special Samus palette frame] + 2) % 8
$91:DB65 A9 00 00    LDA #$0000             ;|
                                            ;|
$91:DB68 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/
$91:DB6B 38          SEC                    ;\
$91:DB6C 60          RTS                    ;} Return carry set

; BRANCH_FINISH
$91:DB6D 9C CC 0A    STZ $0ACC  [$7E:0ACC]  ; Special Samus palette frame = 0
$91:DB70 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette type = 0 (screw attacking / speed boosting)
$91:DB73 18          CLC                    ;\
$91:DB74 60          RTS                    ;} Return carry clear

; Shinespark Samus palette table. Indexed by [Samus suit palette index]
$91:DB75             dw DB7B, DB83, DB8B

; Pointers to bank $9B. Indexed by [special Samus palette frame]
$91:DB7B             dw 9C20, 9C40, 9C60, 9C80 ; No suit
$91:DB83             dw 9E20, 9E40, 9E60, 9E80 ; Varia suit
$91:DB8B             dw A020, A040, A060, A080 ; Gravity suit
}


;;; $DB93: Handle crystal flash palette  ;;;
{
;; Returns:
;;     Carry: Clear to use normal suit palette, set otherwise
$91:DB93 AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$91:DB96 30 53       BMI $53    [$DBEB]     ;} If [special Samus palette timer] < 0: go to BRANCH_FINISH
$91:DB98 3A          DEC A                  ;\
$91:DB99 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Decrement special Samus palette timer
$91:DB9C F0 02       BEQ $02    [$DBA0]     ;\
$91:DB9E 10 20       BPL $20    [$DBC0]     ;} If [special Samus palette timer] > 0: go to BRANCH_BUBBLE_END

$91:DBA0 A9 05 00    LDA #$0005             ;\
$91:DBA3 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 5
$91:DBA6 AE CE 0A    LDX $0ACE  [$7E:0ACE]  ;\
$91:DBA9 BD 28 DC    LDA $DC28,x[$91:DC28]  ;|
$91:DBAC A8          TAY                    ;} Y = [$DC28 + [special Samus palette frame]]
$91:DBAD 20 82 DC    JSR $DC82  [$91:DC82]  ; Set crystal flash bubble colours
$91:DBB0 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DBB3 1A          INC A                  ;|
$91:DBB4 1A          INC A                  ;|
$91:DBB5 C9 0C 00    CMP #$000C             ;|
$91:DBB8 30 03       BMI $03    [$DBBD]     ;} Special Samus palette frame = ([special Samus palette frame] + 2) % Ch
$91:DBBA A9 00 00    LDA #$0000             ;|
                                            ;|
$91:DBBD 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/

; BRANCH_BUBBLE_END
$91:DBC0 CE F2 0D    DEC $0DF2  [$7E:0DF2]  ; Decrement crystal flash Samus palette timer
$91:DBC3 F0 02       BEQ $02    [$DBC7]     ;\
$91:DBC5 10 22       BPL $22    [$DBE9]     ;} If [crystal flash Samus palette timer] > 0: return carry set

$91:DBC7 AE D0 0A    LDX $0AD0  [$7E:0AD0]  ;\
$91:DBCA BD 02 DC    LDA $DC02,x[$91:DC02]  ;} Crystal flash Samus palette timer = [$DC00 + [crystal flash Samus palette frame] + 2]
$91:DBCD 8D F2 0D    STA $0DF2  [$7E:0DF2]  ;/
$91:DBD0 BD 00 DC    LDA $DC00,x[$91:DC00]  ;\
$91:DBD3 A8          TAY                    ;} Y = [$DC00 + [crystal flash Samus palette frame]]
$91:DBD4 20 34 DC    JSR $DC34  [$91:DC34]  ; Set crystal flash Samus colours
$91:DBD7 AD D0 0A    LDA $0AD0  [$7E:0AD0]  ;\
$91:DBDA 18          CLC                    ;|
$91:DBDB 69 04 00    ADC #$0004             ;|
$91:DBDE C9 28 00    CMP #$0028             ;|
$91:DBE1 30 03       BMI $03    [$DBE6]     ;} Crystal flash Samus palette frame = ([crystal flash Samus palette frame] + 4) % 28h
$91:DBE3 A9 00 00    LDA #$0000             ;|
                                            ;|
$91:DBE6 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;/

$91:DBE9 38          SEC                    ;\
$91:DBEA 60          RTS                    ;} Return carry set

; BRANCH_FINISH
$91:DBEB AD A6 09    LDA $09A6  [$7E:09A6]  ; A = [equipped beams]
$91:DBEE 22 C2 AC 90 JSL $90ACC2[$90:ACC2]  ; Load beam palette
$91:DBF2 9C CC 0A    STZ $0ACC  [$7E:0ACC]  ; Special Samus palette frame = 0
$91:DBF5 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette type = 0 (screw attacking / speed boosting)
$91:DBF8 9C D0 0A    STZ $0AD0  [$7E:0AD0]  ; Crystal flash Samus palette frame = 0
$91:DBFB 9C 68 0A    STZ $0A68  [$7E:0A68]  ; Special Samus palette timer = 0
$91:DBFE 18          CLC                    ;\
$91:DBFF 60          RTS                    ;} Return carry clear

; Crystal flash Samus palette table. Bank $9B. Sprite palette 6 colours 0..9
; [palette pointer], [timer]
$91:DC00             dw 96C0,000A, 96E0,000A, 9700,000A, 9720,000A, 9740,000A, 9760,000A, 9740,000A, 9720,000A, 9700,000A, 96E0,000A

; Crystal flash bubble palette table. Bank $9B. Sprite palette 6 colours Ah..Fh
$91:DC28             dw 96D4, 96F4, 9714, 9734, 9754, 9774
}


;;; $DC34: Set crystal flash Samus colours ;;;
{
; Sprite palette 6 colours 0..9 = 14h bytes from $9B:[Y]
$91:DC34 8B          PHB
$91:DC35 F4 00 9B    PEA $9B00
$91:DC38 AB          PLB
$91:DC39 AB          PLB
$91:DC3A B9 00 00    LDA $0000,y[$9B:96C0]
$91:DC3D 8F C0 C1 7E STA $7EC1C0[$7E:C1C0]
$91:DC41 B9 02 00    LDA $0002,y[$9B:96C2]
$91:DC44 8F C2 C1 7E STA $7EC1C2[$7E:C1C2]
$91:DC48 B9 04 00    LDA $0004,y[$9B:96C4]
$91:DC4B 8F C4 C1 7E STA $7EC1C4[$7E:C1C4]
$91:DC4F B9 06 00    LDA $0006,y[$9B:96C6]
$91:DC52 8F C6 C1 7E STA $7EC1C6[$7E:C1C6]
$91:DC56 B9 08 00    LDA $0008,y[$9B:96C8]
$91:DC59 8F C8 C1 7E STA $7EC1C8[$7E:C1C8]
$91:DC5D B9 0A 00    LDA $000A,y[$9B:96CA]
$91:DC60 8F CA C1 7E STA $7EC1CA[$7E:C1CA]
$91:DC64 B9 0C 00    LDA $000C,y[$9B:96CC]
$91:DC67 8F CC C1 7E STA $7EC1CC[$7E:C1CC]
$91:DC6B B9 0E 00    LDA $000E,y[$9B:96CE]
$91:DC6E 8F CE C1 7E STA $7EC1CE[$7E:C1CE]
$91:DC72 B9 10 00    LDA $0010,y[$9B:96D0]
$91:DC75 8F D0 C1 7E STA $7EC1D0[$7E:C1D0]
$91:DC79 B9 12 00    LDA $0012,y[$9B:96D2]
$91:DC7C 8F D2 C1 7E STA $7EC1D2[$7E:C1D2]
$91:DC80 AB          PLB
$91:DC81 60          RTS
}


;;; $DC82: Set crystal flash bubble colours ;;;
{
; Sprite palette 6 colours Ah..Fh = Ch bytes from $9B:[Y]
$91:DC82 8B          PHB
$91:DC83 F4 00 9B    PEA $9B00
$91:DC86 AB          PLB
$91:DC87 AB          PLB
$91:DC88 B9 00 00    LDA $0000,y[$9B:96D4]
$91:DC8B 8F D4 C1 7E STA $7EC1D4[$7E:C1D4]
$91:DC8F B9 02 00    LDA $0002,y[$9B:96D6]
$91:DC92 8F D6 C1 7E STA $7EC1D6[$7E:C1D6]
$91:DC96 B9 04 00    LDA $0004,y[$9B:96D8]
$91:DC99 8F D8 C1 7E STA $7EC1D8[$7E:C1D8]
$91:DC9D B9 06 00    LDA $0006,y[$9B:96DA]
$91:DCA0 8F DA C1 7E STA $7EC1DA[$7E:C1DA]
$91:DCA4 B9 08 00    LDA $0008,y[$9B:96DC]
$91:DCA7 8F DC C1 7E STA $7EC1DC[$7E:C1DC]
$91:DCAB B9 0A 00    LDA $000A,y[$9B:96DE]
$91:DCAE 8F DE C1 7E STA $7EC1DE[$7E:C1DE]
$91:DCB2 AB          PLB
$91:DCB3 60          RTS
}


;;; $DCB4: Handle x-ray palette ;;;
{
;; Returns:
;;     Carry: Clear to use normal suit palette, set otherwise
$91:DCB4 AD 80 0A    LDA $0A80  [$7E:0A80]  ;\
$91:DCB7 30 6A       BMI $6A    [$DD23]     ;} If [$0A80] < 0: go to BRANCH_FINISH
$91:DCB9 D0 3E       BNE $3E    [$DCF9]     ; If [$0A80] != 0: go to BRANCH_PALETTE_SET
$91:DCBB AD 7A 0A    LDA $0A7A  [$7E:0A7A]  ;\
$91:DCBE C9 02 00    CMP #$0002             ;} If [x-ray state] >= 2: go to BRANCH_NOT_WIDENING
$91:DCC1 10 27       BPL $27    [$DCEA]     ;/
$91:DCC3 CE D0 0A    DEC $0AD0  [$7E:0AD0]  ; Decrement x-ray palette timer
$91:DCC6 F0 02       BEQ $02    [$DCCA]     ;\
$91:DCC8 10 1E       BPL $1E    [$DCE8]     ;} If [x-ray palette timer] > 0: return set

$91:DCCA A9 05 00    LDA #$0005             ;\
$91:DCCD 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} X-ray palette timer = 5
$91:DCD0 AE CE 0A    LDX $0ACE  [$7E:0ACE]  ;\
$91:DCD3 BF C0 A3 9B LDA $9BA3C0,x[$9B:A3C0];} Sprite palette 4 colour 4 (Samus visor) = [$9B:A3C0 + [x-ray palette index]]
$91:DCD7 8F 88 C1 7E STA $7EC188[$7E:C188]  ;/
$91:DCDB AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DCDE C9 04 00    CMP #$0004             ;} If [x-ray palette index] < 4:
$91:DCE1 10 05       BPL $05    [$DCE8]     ;/
$91:DCE3 1A          INC A                  ;\
$91:DCE4 1A          INC A                  ;} X-ray palette index += 2
$91:DCE5 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;/

$91:DCE8 38          SEC                    ;\
$91:DCE9 60          RTS                    ;} Return carry set

; BRANCH_NOT_WIDENING
$91:DCEA A9 06 00    LDA #$0006             ;\
$91:DCED 8D CE 0A    STA $0ACE  [$7E:0ACE]  ;} X-ray palette index = 6
$91:DCF0 A9 01 00    LDA #$0001             ;\
$91:DCF3 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} X-ray palette timer = 1
$91:DCF6 8D 80 0A    STA $0A80  [$7E:0A80]  ; $0A80 = 1

; BRANCH_PALETTE_SET
$91:DCF9 CE D0 0A    DEC $0AD0  [$7E:0AD0]  ; Decrement x-ray palette timer
$91:DCFC F0 02       BEQ $02    [$DD00]     ;\
$91:DCFE 10 E8       BPL $E8    [$DCE8]     ;} If [x-ray palette timer] > 0: return set

$91:DD00 A9 05 00    LDA #$0005             ;\
$91:DD03 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} X-ray palette timer = 5
$91:DD06 AE CE 0A    LDX $0ACE  [$7E:0ACE]  ;\
$91:DD09 BF C0 A3 9B LDA $9BA3C0,x[$9B:A3C6];} Sprite palette 4 colour 4 (Samus visor) = [$9B:A3C0 + [x-ray palette index]]
$91:DD0D 8F 88 C1 7E STA $7EC188[$7E:C188]  ;/
$91:DD11 AD CE 0A    LDA $0ACE  [$7E:0ACE]  ;\
$91:DD14 1A          INC A                  ;} X-ray palette index += 2
$91:DD15 1A          INC A                  ;/
$91:DD16 C9 0C 00    CMP #$000C             ;\
$91:DD19 30 03       BMI $03    [$DD1E]     ;} If [x-ray palette index] >= Ch:
$91:DD1B A9 06 00    LDA #$0006             ; X-ray palette index = 6

$91:DD1E 8D CE 0A    STA $0ACE  [$7E:0ACE]
$91:DD21 38          SEC                    ;\
$91:DD22 60          RTS                    ;} Return carry set

; BRANCH_FINISH
$91:DD23 9C CC 0A    STZ $0ACC  [$7E:0ACC]  ; Special Samus palette frame = 0
$91:DD26 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette type = 0 (screw attacking / speed boosting)
$91:DD29 9C D0 0A    STZ $0AD0  [$7E:0AD0]  ; X-ray palette timer = 0
$91:DD2C 9C 80 0A    STZ $0A80  [$7E:0A80]  ; Special Samus palette timer = 0
$91:DD2F 18          CLC                    ;\
$91:DD30 60          RTS                    ;} Return carry clear
}


;;; $DD31: RTS ;;;
{
$91:DD31 60          RTS
}


;;; $DD32:  ;;;
{
; Seemingly completely unreferenced
$91:DD32             db 01, 00, 00, 01, 00, 00, 01, 00, 00, 01, 01, 00, 01, 00, 01, 00,
                        01, 00, 01, 00, 01, 00, 01, 00, 01, 00
}


;;; $DD4C: Unused. Set Samus palette to $9B:9500 ;;;
{
; For testing perhaps, palette is solid white
$91:DD4C 08          PHP
$91:DD4D 8B          PHB
$91:DD4E 4B          PHK                    ;\
$91:DD4F AB          PLB                    ;} DB = $91
$91:DD50 C2 30       REP #$30
$91:DD52 A2 00 95    LDX #$9500             ;\
$91:DD55 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9500
$91:DD58 AB          PLB
$91:DD59 28          PLP
$91:DD5A 6B          RTL
}


;;; $DD5B: Samus palette = 20h bytes from $9B:[X] ;;;
{
$91:DD5B 08          PHP
$91:DD5C C2 30       REP #$30
$91:DD5E 8B          PHB
$91:DD5F F4 00 9B    PEA $9B00
$91:DD62 AB          PLB
$91:DD63 AB          PLB
$91:DD64 BD 00 00    LDA $0000,x[$9B:A380]
$91:DD67 8F 80 C1 7E STA $7EC180[$7E:C180]
$91:DD6B BD 02 00    LDA $0002,x[$9B:A382]
$91:DD6E 8F 82 C1 7E STA $7EC182[$7E:C182]
$91:DD72 BD 04 00    LDA $0004,x[$9B:A384]
$91:DD75 8F 84 C1 7E STA $7EC184[$7E:C184]
$91:DD79 BD 06 00    LDA $0006,x[$9B:A386]
$91:DD7C 8F 86 C1 7E STA $7EC186[$7E:C186]
$91:DD80 BD 08 00    LDA $0008,x[$9B:A388]
$91:DD83 8F 88 C1 7E STA $7EC188[$7E:C188]
$91:DD87 BD 0A 00    LDA $000A,x[$9B:A38A]
$91:DD8A 8F 8A C1 7E STA $7EC18A[$7E:C18A]
$91:DD8E BD 0C 00    LDA $000C,x[$9B:A38C]
$91:DD91 8F 8C C1 7E STA $7EC18C[$7E:C18C]
$91:DD95 BD 0E 00    LDA $000E,x[$9B:A38E]
$91:DD98 8F 8E C1 7E STA $7EC18E[$7E:C18E]
$91:DD9C BD 10 00    LDA $0010,x[$9B:A390]
$91:DD9F 8F 90 C1 7E STA $7EC190[$7E:C190]
$91:DDA3 BD 12 00    LDA $0012,x[$9B:A392]
$91:DDA6 8F 92 C1 7E STA $7EC192[$7E:C192]
$91:DDAA BD 14 00    LDA $0014,x[$9B:A394]
$91:DDAD 8F 94 C1 7E STA $7EC194[$7E:C194]
$91:DDB1 BD 16 00    LDA $0016,x[$9B:A396]
$91:DDB4 8F 96 C1 7E STA $7EC196[$7E:C196]
$91:DDB8 BD 18 00    LDA $0018,x[$9B:A398]
$91:DDBB 8F 98 C1 7E STA $7EC198[$7E:C198]
$91:DDBF BD 1A 00    LDA $001A,x[$9B:A39A]
$91:DDC2 8F 9A C1 7E STA $7EC19A[$7E:C19A]
$91:DDC6 BD 1C 00    LDA $001C,x[$9B:A39C]
$91:DDC9 8F 9C C1 7E STA $7EC19C[$7E:C19C]
$91:DDCD BD 1E 00    LDA $001E,x[$9B:A39E]
$91:DDD0 8F 9E C1 7E STA $7EC19E[$7E:C19E]
$91:DDD4 AB          PLB
$91:DDD5 28          PLP
$91:DDD6 60          RTS
}


;;; $DDD7: Target Samus palette = 20h bytes from $9B:[X] ;;;
{
; Used only by $DEE6: Load Samus target colours based on suit
$91:DDD7 08          PHP
$91:DDD8 C2 30       REP #$30
$91:DDDA 8B          PHB
$91:DDDB F4 00 9B    PEA $9B00
$91:DDDE AB          PLB
$91:DDDF AB          PLB
$91:DDE0 BD 00 00    LDA $0000,x[$9B:9400]
$91:DDE3 8F 80 C3 7E STA $7EC380[$7E:C380]
$91:DDE7 BD 02 00    LDA $0002,x[$9B:9402]
$91:DDEA 8F 82 C3 7E STA $7EC382[$7E:C382]
$91:DDEE BD 04 00    LDA $0004,x[$9B:9404]
$91:DDF1 8F 84 C3 7E STA $7EC384[$7E:C384]
$91:DDF5 BD 06 00    LDA $0006,x[$9B:9406]
$91:DDF8 8F 86 C3 7E STA $7EC386[$7E:C386]
$91:DDFC BD 08 00    LDA $0008,x[$9B:9408]
$91:DDFF 8F 88 C3 7E STA $7EC388[$7E:C388]
$91:DE03 BD 0A 00    LDA $000A,x[$9B:940A]
$91:DE06 8F 8A C3 7E STA $7EC38A[$7E:C38A]
$91:DE0A BD 0C 00    LDA $000C,x[$9B:940C]
$91:DE0D 8F 8C C3 7E STA $7EC38C[$7E:C38C]
$91:DE11 BD 0E 00    LDA $000E,x[$9B:940E]
$91:DE14 8F 8E C3 7E STA $7EC38E[$7E:C38E]
$91:DE18 BD 10 00    LDA $0010,x[$9B:9410]
$91:DE1B 8F 90 C3 7E STA $7EC390[$7E:C390]
$91:DE1F BD 12 00    LDA $0012,x[$9B:9412]
$91:DE22 8F 92 C3 7E STA $7EC392[$7E:C392]
$91:DE26 BD 14 00    LDA $0014,x[$9B:9414]
$91:DE29 8F 94 C3 7E STA $7EC394[$7E:C394]
$91:DE2D BD 16 00    LDA $0016,x[$9B:9416]
$91:DE30 8F 96 C3 7E STA $7EC396[$7E:C396]
$91:DE34 BD 18 00    LDA $0018,x[$9B:9418]
$91:DE37 8F 98 C3 7E STA $7EC398[$7E:C398]
$91:DE3B BD 1A 00    LDA $001A,x[$9B:941A]
$91:DE3E 8F 9A C3 7E STA $7EC39A[$7E:C39A]
$91:DE42 BD 1C 00    LDA $001C,x[$9B:941C]
$91:DE45 8F 9C C3 7E STA $7EC39C[$7E:C39C]
$91:DE49 BD 1E 00    LDA $001E,x[$9B:941E]
$91:DE4C 8F 9E C3 7E STA $7EC39E[$7E:C39E]
$91:DE50 AB          PLB
$91:DE51 28          PLP
$91:DE52 60          RTS
}
}


;;; $DE53: Cancel speed boosting ;;;
{
$91:DE53 08          PHP
$91:DE54 8B          PHB
$91:DE55 4B          PHK                    ;\
$91:DE56 AB          PLB                    ;} DB = $91
$91:DE57 C2 30       REP #$30
$91:DE59 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$91:DE5C F0 2F       BEQ $2F    [$DE8D]     ;} If [Samus running momentum flag] = 0: go to BRANCH_MERGE
$91:DE5E 9C 3C 0B    STZ $0B3C  [$7E:0B3C]  ; Samus running momentum flag = 0
$91:DE61 9C 3E 0B    STZ $0B3E  [$7E:0B3E]  ; Speed boost counter / timer = 0
$91:DE64 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$91:DE67 9C D0 0A    STZ $0AD0  [$7E:0AD0]  ; Speed boosting palette timer = 0
$91:DE6A AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:DE6D 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_GRAVITY
$91:DE70 D0 15       BNE $15    [$DE87]     ;/
$91:DE72 89 01 00    BIT #$0001             ;\
$91:DE75 D0 08       BNE $08    [$DE7F]     ;} If varia suit equipped: go to BRANCH_VARIA
$91:DE77 A2 00 94    LDX #$9400             ;\
$91:DE7A 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9400 (normal - power suit)
$91:DE7D 80 0E       BRA $0E    [$DE8D]     ; Go to BRANCH_MERGE

; BRANCH_VARIA
$91:DE7F A2 20 95    LDX #$9520             ;\
$91:DE82 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9520 (normal - varia suit)
$91:DE85 80 06       BRA $06    [$DE8D]     ; Go to BRANCH_MERGE

; BRANCH_GRAVITY
$91:DE87 A2 00 98    LDX #$9800             ;\
$91:DE8A 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9800 (normal - gravity suit)

; BRANCH_MERGE
$91:DE8D AD AE 0A    LDA $0AAE  [$7E:0AAE]  ;\
$91:DE90 30 25       BMI $25    [$DEB7]     ;} If speed echoes are merging back into Samus: return
$91:DE92 A9 FF FF    LDA #$FFFF             ;\
$91:DE95 8D AE 0A    STA $0AAE  [$7E:0AAE]  ;} Set speed echoes to merge back into Samus
$91:DE98 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:DE9B 29 FF 00    AND #$00FF             ;|
$91:DE9E C9 04 00    CMP #$0004             ;} If facing right:
$91:DEA1 F0 0B       BEQ $0B    [$DEAE]     ;/
$91:DEA3 A9 08 00    LDA #$0008             ;\
$91:DEA6 8D C0 0A    STA $0AC0  [$7E:0AC0]  ;} Speed echo 0 X speed = 8
$91:DEA9 8D C2 0A    STA $0AC2  [$7E:0AC2]  ; Speed echo 1 X speed = 8
$91:DEAC 80 09       BRA $09    [$DEB7]     ; Return

$91:DEAE A9 F8 FF    LDA #$FFF8             ;\
$91:DEB1 8D C0 0A    STA $0AC0  [$7E:0AC0]  ;} Speed echo 0 X speed = -8
$91:DEB4 8D C2 0A    STA $0AC2  [$7E:0AC2]  ; Speed echo 1 X speed = -8

$91:DEB7 AB          PLB
$91:DEB8 28          PLP
$91:DEB9 6B          RTL
}


;;; $DEBA: Load Samus suit palette ;;;
{
$91:DEBA 08          PHP
$91:DEBB 8B          PHB
$91:DEBC 4B          PHK                    ;\
$91:DEBD AB          PLB                    ;} DB = $91
$91:DEBE C2 30       REP #$30
$91:DEC0 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:DEC3 89 20 00    BIT #$0020             ;} If equipped gravity suit: go to BRANCH_GRAVITY_SUIT
$91:DEC6 D0 15       BNE $15    [$DEDD]     ;/
$91:DEC8 89 01 00    BIT #$0001             ;\
$91:DECB D0 08       BNE $08    [$DED5]     ;} If equipped varia suit: go to BRANCH_VARIA_SUIT
$91:DECD A2 00 94    LDX #$9400             ;\
$91:DED0 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9400 (normal - power suit)
$91:DED3 80 0E       BRA $0E    [$DEE3]     ; Return

; BRANCH_VARIA_SUIT
$91:DED5 A2 20 95    LDX #$9520             ;\
$91:DED8 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9520 (normal - varia suit)
$91:DEDB 80 06       BRA $06    [$DEE3]     ; Return

; BRANCH_GRAVITY_SUIT
$91:DEDD A2 00 98    LDX #$9800             ;\
$91:DEE0 20 5B DD    JSR $DD5B  [$91:DD5B]  ;} Samus palette = 20h bytes from $9B:9800 (normal - gravity suit)

$91:DEE3 AB          PLB
$91:DEE4 28          PLP
$91:DEE5 6B          RTL
}


;;; $DEE6: Load Samus suit target palette ;;;
{
$91:DEE6 08          PHP
$91:DEE7 8B          PHB
$91:DEE8 4B          PHK                    ;\
$91:DEE9 AB          PLB                    ;} DB = $91
$91:DEEA C2 30       REP #$30
$91:DEEC AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:DEEF 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_GRAVITY
$91:DEF2 D0 15       BNE $15    [$DF09]     ;/
$91:DEF4 89 01 00    BIT #$0001             ;\
$91:DEF7 D0 08       BNE $08    [$DF01]     ;} If varia suit equipped: go to BRANCH_VARIA
$91:DEF9 A2 00 94    LDX #$9400             ;\
$91:DEFC 20 D7 DD    JSR $DDD7  [$91:DDD7]  ;} Samus palette = 20h bytes from $9B:9400 (normal - power suit)
$91:DEFF 80 0E       BRA $0E    [$DF0F]

; BRANCH_VARIA_SUIT
$91:DF01 A2 20 95    LDX #$9520             ;\
$91:DF04 20 D7 DD    JSR $DDD7  [$91:DDD7]  ;} Samus palette = 20h bytes from $9B:9520 (normal - varia suit)
$91:DF07 80 06       BRA $06    [$DF0F]     ; Return

; BRANCH_GRAVITY_SUIT
$91:DF09 A2 00 98    LDX #$9800             ;\
$91:DF0C 20 D7 DD    JSR $DDD7  [$91:DDD7]  ;} Samus palette = 20h bytes from $9B:9800 (normal - gravity suit)

$91:DF0F AB          PLB
$91:DF10 28          PLP
$91:DF11 6B          RTL
}


;;; $DF12: Restore [A] health to Samus ;;;
{
$91:DF12 08          PHP
$91:DF13 8B          PHB
$91:DF14 4B          PHK                    ;\
$91:DF15 AB          PLB                    ;} DB = $91
$91:DF16 C2 30       REP #$30
$91:DF18 85 12       STA $12    [$7E:0012]  ;\
$91:DF1A AD C2 09    LDA $09C2  [$7E:09C2]  ;|
$91:DF1D 18          CLC                    ;} Samus health += [A]
$91:DF1E 65 12       ADC $12    [$7E:0012]  ;|
$91:DF20 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$91:DF23 CD C4 09    CMP $09C4  [$7E:09C4]  ;\
$91:DF26 30 26       BMI $26    [$DF4E]     ;} If [Samus health] < [Samus max health]: return
$91:DF28 38          SEC                    ;\
$91:DF29 ED C4 09    SBC $09C4  [$7E:09C4]  ;} A = [Samus health] - [Samus max health] (health overflow)
$91:DF2C 18          CLC                    ;\
$91:DF2D 6D D6 09    ADC $09D6  [$7E:09D6]  ;|
$91:DF30 CD D4 09    CMP $09D4  [$7E:09D4]  ;|
$91:DF33 30 03       BMI $03    [$DF38]     ;} Samus reserve health = min([Samus max reserve health], [Samus reserve health] + (health overflow))
$91:DF35 AD D4 09    LDA $09D4  [$7E:09D4]  ;|
                                            ;|
$91:DF38 8D D6 09    STA $09D6  [$7E:09D6]  ;/
$91:DF3B F0 0B       BEQ $0B    [$DF48]     ; If [Samus reserve health] != 0:
$91:DF3D AD C0 09    LDA $09C0  [$7E:09C0]  ;\
$91:DF40 D0 06       BNE $06    [$DF48]     ;} If not obtained reserve tanks:
$91:DF42 A9 01 00    LDA #$0001             ;\
$91:DF45 8D C0 09    STA $09C0  [$7E:09C0]  ;} Reserve health mode = auto

$91:DF48 AD C4 09    LDA $09C4  [$7E:09C4]  ;\
$91:DF4B 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = [Samus max health]

$91:DF4E AB          PLB
$91:DF4F 28          PLP
$91:DF50 6B          RTL
}


;;; $DF51: Deal [A] damage to Samus ;;;
{
; Does NOT do any damage if damage = 300 (#$12C) or if time is paused by x-ray / reserve tanks, ignores suits.
; NOTE: If damage is negative, game will stop (JML $808573) (change $91DF65 to 00 to skip 300-damage check)
$91:DF51 08          PHP
$91:DF52 8B          PHB
$91:DF53 4B          PHK                    ;\
$91:DF54 AB          PLB                    ;} DB = $91
$91:DF55 C2 30       REP #$30
$91:DF57 DA          PHX
$91:DF58 85 12       STA $12    [$7E:0012]  ; $12 = [A]
$91:DF5A AA          TAX                    ;\
$91:DF5B 10 04       BPL $04    [$DF61]     ;} If [$12] < 0:
$91:DF5D 5C 73 85 80 JML $808573[$80:8573]  ; Crash

$91:DF61 C9 2C 01    CMP #$012C             ;\
$91:DF64 F0 17       BEQ $17    [$DF7D]     ;} If [$12] = 300: return
$91:DF66 AD 78 0A    LDA $0A78  [$7E:0A78]  ;\
$91:DF69 D0 0E       BNE $0E    [$DF79]     ;} If time is frozen: return
$91:DF6B AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$91:DF6E 38          SEC                    ;|
$91:DF6F E5 12       SBC $12    [$7E:0012]  ;|
$91:DF71 8D C2 09    STA $09C2  [$7E:09C2]  ;} Samus health = max(0, [Samus health] - [$12])
$91:DF74 10 03       BPL $03    [$DF79]     ;|
$91:DF76 9C C2 09    STZ $09C2  [$7E:09C2]  ;/

$91:DF79 FA          PLX
$91:DF7A AB          PLB
$91:DF7B 28          PLP
$91:DF7C 6B          RTL                    ; Return

$91:DF7D EA          NOP                    ; Wild NOP appears!
$91:DF7E 80 F9       BRA $F9    [$DF79]
}


;;; $DF80: Restore [A] missiles to Samus ;;;
{
; Samus reserve missiles = min(99, [Samus max missiles], [Samus reserve missiles] + max(0, [Samus missiles] + [A] - [Samus max missiles]))
; Samus missiles = min([Samus missiles] + [A], [Samus max missiles])

; This is the only routine that uses Samus reserve missiles (other than RAM clearing routines)
$91:DF80 08          PHP
$91:DF81 8B          PHB
$91:DF82 4B          PHK                    ;\
$91:DF83 AB          PLB                    ;} DB = $91
$91:DF84 C2 30       REP #$30
$91:DF86 18          CLC                    ;\
$91:DF87 6D C6 09    ADC $09C6  [$7E:09C6]  ;} Samus missiles += [A]
$91:DF8A 8D C6 09    STA $09C6  [$7E:09C6]  ;/
$91:DF8D CD C8 09    CMP $09C8  [$7E:09C8]  ;\
$91:DF90 30 3E       BMI $3E    [$DFD0]     ;} If [Samus missiles] < [Samus max missiles]: return
$91:DF92 38          SEC                    ;\
$91:DF93 ED C8 09    SBC $09C8  [$7E:09C8]  ;} $12 = [Samus missiles] - [Samus max missiles] (missile overflow)
$91:DF96 85 12       STA $12    [$7E:0012]  ;/
$91:DF98 AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$91:DF9B C9 63 00    CMP #$0063             ;} If [Samus max missiles] >= 99:
$91:DF9E 30 16       BMI $16    [$DFB6]     ;/
$91:DFA0 A5 12       LDA $12    [$7E:0012]  ;\
$91:DFA2 18          CLC                    ;|
$91:DFA3 6D D8 09    ADC $09D8  [$7E:09D8]  ;|
$91:DFA6 8D D8 09    STA $09D8  [$7E:09D8]  ;|
$91:DFA9 C9 63 00    CMP #$0063             ;} Samus reserve missiles = min(99, [Samus reserve missiles] + (missile overflow))
$91:DFAC 30 1C       BMI $1C    [$DFCA]     ;|
$91:DFAE A9 63 00    LDA #$0063             ;|
$91:DFB1 8D D8 09    STA $09D8  [$7E:09D8]  ;/
$91:DFB4 80 14       BRA $14    [$DFCA]

$91:DFB6 A5 12       LDA $12    [$7E:0012]  ;\ Else ([Samus max missiles] < 99):
$91:DFB8 18          CLC                    ;|
$91:DFB9 6D D8 09    ADC $09D8  [$7E:09D8]  ;|
$91:DFBC 8D D8 09    STA $09D8  [$7E:09D8]  ;|
$91:DFBF CD C8 09    CMP $09C8  [$7E:09C8]  ;} Samus reserve missiles = min([Samus max missiles], [Samus reserve missiles] + (missile overflow))
$91:DFC2 30 06       BMI $06    [$DFCA]     ;|
$91:DFC4 AD C8 09    LDA $09C8  [$7E:09C8]  ;|
$91:DFC7 8D D8 09    STA $09D8  [$7E:09D8]  ;/

$91:DFCA AD C8 09    LDA $09C8  [$7E:09C8]  ;\
$91:DFCD 8D C6 09    STA $09C6  [$7E:09C6]  ;} Samus missiles = [Samus max missiles]

$91:DFD0 AB          PLB
$91:DFD1 28          PLP
$91:DFD2 6B          RTL
}


;;; $DFD3: Restore [A] super missiles to Samus ;;;
{
$91:DFD3 08          PHP
$91:DFD4 8B          PHB
$91:DFD5 4B          PHK                    ;\
$91:DFD6 AB          PLB                    ;} DB = $91
$91:DFD7 C2 30       REP #$30
$91:DFD9 18          CLC                    ;\
$91:DFDA 6D CA 09    ADC $09CA  [$7E:09CA]  ;|
$91:DFDD 8D CA 09    STA $09CA  [$7E:09CA]  ;|
$91:DFE0 CD CC 09    CMP $09CC  [$7E:09CC]  ;|
$91:DFE3 30 08       BMI $08    [$DFED]     ;} Samus super missiles = min([Samus max super missiles], [Samus super missiles] + [A])
$91:DFE5 F0 06       BEQ $06    [$DFED]     ;|
$91:DFE7 AD CC 09    LDA $09CC  [$7E:09CC]  ;|
$91:DFEA 8D CA 09    STA $09CA  [$7E:09CA]  ;/

$91:DFED AB          PLB
$91:DFEE 28          PLP
$91:DFEF 6B          RTL
}


;;; $DFF0: Restore [A] power bombs to Samus ;;;
{
$91:DFF0 08          PHP
$91:DFF1 8B          PHB
$91:DFF2 4B          PHK                    ;\
$91:DFF3 AB          PLB                    ;} DB = $91
$91:DFF4 C2 30       REP #$30
$91:DFF6 18          CLC                    ;\
$91:DFF7 6D CE 09    ADC $09CE  [$7E:09CE]  ;|
$91:DFFA 8D CE 09    STA $09CE  [$7E:09CE]  ;|
$91:DFFD CD D0 09    CMP $09D0  [$7E:09D0]  ;|
$91:E000 30 08       BMI $08    [$E00A]     ;} Samus power bombs = min([Samus max power bombs], [Samus power bombs] + [A])
$91:E002 F0 06       BEQ $06    [$E00A]     ;|
$91:E004 AD D0 09    LDA $09D0  [$7E:09D0]  ;|
$91:E007 8D CE 09    STA $09CE  [$7E:09CE]  ;/

$91:E00A AB          PLB
$91:E00B 28          PLP
$91:E00C 6B          RTL
}


;;; $E00D: Initialise Samus ;;;
{
; Executed when loading demo or starting at Ceres/Zebes
$91:E00D 08          PHP
$91:E00E 8B          PHB
$91:E00F 4B          PHK                    ;\
$91:E010 AB          PLB                    ;} DB = $91
$91:E011 C2 30       REP #$30
$91:E013 AD E0 0D    LDA $0DE0  [$7E:0DE0]  ;\
$91:E016 85 12       STA $12    [$7E:0012]  ;} >_<;
$91:E018 A2 0B 0E    LDX #$0E0B             ;\
$91:E01B E2 20       SEP #$20               ;|
$91:E01D A9 00       LDA #$00               ;|
                                            ;|
$91:E01F 9D 00 00    STA $0000,x[$7E:0E0B]  ;} $0A02..0E0B = 0
$91:E022 CA          DEX                    ;|
$91:E023 E0 02 0A    CPX #$0A02             ;|
$91:E026 10 F7       BPL $F7    [$E01F]     ;|
$91:E028 C2 20       REP #$20               ;/
$91:E02A AD 98 09    LDA $0998  [$7E:0998]  ;\
$91:E02D C9 28 00    CMP #$0028             ;} If [game state] = 28h (load demo game data): go to BRANCH_DEMO
$91:E030 F0 59       BEQ $59    [$E08B]     ;/
$91:E032 AF 14 D9 7E LDA $7ED914[$7E:D914]  ;\
$91:E036 C9 22 00    CMP #$0022             ;} If landing on Zebes:
$91:E039 D0 2A       BNE $2A    [$E065]     ;/
$91:E03B A9 CD E8    LDA #$E8CD             ;\
$91:E03E 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = RTL
$91:E041 A9 DC E8    LDA #$E8DC             ;\
$91:E044 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8DC (Samus is locked)
$91:E047 A9 52 EB    LDA #$EB52             ;\
$91:E04A 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$91:E04D A9 FF FF    LDA #$FFFF             ;\
$91:E050 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = FFFFh <-- bug?
$91:E053 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$91:E056 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$91:E059 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$91:E05D A9 13 E9    LDA #$E913             ;\
$91:E060 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$91:E063 80 26       BRA $26    [$E08B]

$91:E065 A9 CD E8    LDA #$E8CD             ;\ Else (not landing on Zebes):
$91:E068 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = RTL
$91:E06B A9 6A E8    LDA #$E86A             ;\
$91:E06E 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E86A (Samus appearance)
$91:E071 A9 52 EB    LDA #$EB52             ;\
$91:E074 8D 5C 0A    STA $0A5C  [$7E:0A5C]  ;} Samus drawing handler = default
$91:E077 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$91:E07A 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$91:E07D 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$91:E080 A9 13 E9    LDA #$E913             ;\
$91:E083 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$91:E086 A5 12       LDA $12    [$7E:0012]  ;\
$91:E088 8D E0 0D    STA $0DE0  [$7E:0DE0]  ;} >_<

; BRANCH_DEMO
$91:E08B A9 FF FF    LDA #$FFFF             ;\
$91:E08E 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$91:E091 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$91:E094 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$91:E097 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$91:E09A C9 06 00    CMP #$0006             ;} If [area index] = Ceres:
$91:E09D D0 08       BNE $08    [$E0A7]     ;/
$91:E09F A9 E6 E0    LDA #$E0E6             ;\
$91:E0A2 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = $E0E6 (handle timer)
$91:E0A5 80 06       BRA $06    [$E0AD]

$91:E0A7 A9 0E E9    LDA #$E90E             ;\ Else ([area index] != Ceres):
$91:E0AA 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS

$91:E0AD A9 37 A3    LDA #$A337             ;\
$91:E0B0 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$91:E0B3 A9 34 F5    LDA #$F534             ;\
$91:E0B6 8D 5E 0A    STA $0A5E  [$7E:0A5E]  ;} Debug command handler = RTS
$91:E0B9 A9 32 00    LDA #$0032             ;\
$91:E0BC 8D 12 0A    STA $0A12  [$7E:0A12]  ;} Samus health mirror = 50
$91:E0BF A9 01 06    LDA #$0601             ;\
$91:E0C2 8D 72 0A    STA $0A72  [$7E:0A72]  ;} Samus visor palette timer = 1, Samus visor palette index = 6
$91:E0C5 A2 00 00    LDX #$0000             ;\
                                            ;|
$91:E0C8 A9 69 B1    LDA #$B169             ;|
$91:E0CB 9D 68 0C    STA $0C68,x[$7E:0C68]  ;|
$91:E0CE E8          INX                    ;} Projectile pre-instructions = RTS
$91:E0CF E8          INX                    ;|
$91:E0D0 E0 14 00    CPX #$0014             ;|
$91:E0D3 30 F3       BMI $F3    [$E0C8]     ;/
$91:E0D5 A9 F0 C4    LDA #$C4F0             ;\
$91:E0D8 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = inactive
$91:E0DB A9 03 00    LDA #$0003             ;\
$91:E0DE 8D 46 0A    STA $0A46  [$7E:0A46]  ;} Enable horizontal slope detection
$91:E0E1 9C 48 0A    STZ $0A48  [$7E:0A48]  ; Samus hurt flash counter = 0
$91:E0E4 9C 4A 0A    STZ $0A4A  [$7E:0A4A]  ; Super special Samus palette flags = 0 (normal)
$91:E0E7 AF AF 9E 90 LDA $909EAF[$90:9EAF]  ;\
$91:E0EB 8D A4 0D    STA $0DA4  [$7E:0DA4]  ;|
$91:E0EE AF AD 9E 90 LDA $909EAD[$90:9EAD]  ;} Camera X speed = 1.0
$91:E0F2 8D A2 0D    STA $0DA2  [$7E:0DA2]  ;/
$91:E0F5 AF B3 9E 90 LDA $909EB3[$90:9EB3]  ;\
$91:E0F9 8D A8 0D    STA $0DA8  [$7E:0DA8]  ;|
$91:E0FC AF B1 9E 90 LDA $909EB1[$90:9EB1]  ;} Camera Y speed = 1.0
$91:E100 8D A6 0D    STA $0DA6  [$7E:0DA6]  ;/
$91:E103 A2 FE 01    LDX #$01FE             ;\
$91:E106 A9 FF 00    LDA #$00FF             ;|
                                            ;|
$91:E109 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800..99FF = FFh,0 (x-ray / suit pickup window HDMA data table)
$91:E10D CA          DEX                    ;|
$91:E10E CA          DEX                    ;|
$91:E10F 10 F8       BPL $F8    [$E109]     ;/
$91:E111 AF A1 9E 90 LDA $909EA1[$90:9EA1]  ;\
$91:E115 8D 32 0B    STA $0B32  [$7E:0B32]  ;|
$91:E118 AF A7 9E 90 LDA $909EA7[$90:9EA7]  ;} Samus Y acceleration = 0.1C00h
$91:E11C 8D 34 0B    STA $0B34  [$7E:0B34]  ;/
$91:E11F A9 FF FF    LDA #$FFFF             ;\
$91:E122 8D 5E 19    STA $195E  [$7E:195E]  ;} FX Y position = FFFFh
$91:E125 8D 62 19    STA $1962  [$7E:1962]  ; Lava/acid Y position = FFFFh
$91:E128 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$91:E12C 9C 51 1F    STZ $1F51  [$7E:1F51]  ; Cinematic function = 0
$91:E12F 9C 1C 0A    STZ $0A1C  [$7E:0A1C]  ; Samus pose = 0
$91:E132 9C 1E 0A    STZ $0A1E  [$7E:0A1E]  ; Samus pose X direction = Samus movement type = 0
$91:E135 9C 20 0A    STZ $0A20  [$7E:0A20]  ; Samus previous pose = 0
$91:E138 9C 22 0A    STZ $0A22  [$7E:0A22]  ; Samus previous pose X direction = Samus previous movement type = 0
$91:E13B 9C 24 0A    STZ $0A24  [$7E:0A24]  ; Samus last different pose = 0
$91:E13E 9C 26 0A    STZ $0A26  [$7E:0A26]  ; Samus last different pose X direction = Samus last different pose movement type = 0
$91:E141 A9 FF FF    LDA #$FFFF             ;\
$91:E144 8D 1C 0E    STA $0E1C  [$7E:0E1C]  ;} Enemy index to shake = FFFFh
$91:E147 9C D2 09    STZ $09D2  [$7E:09D2]  ; Currently selected status bar item = 0
$91:E14A 9C 04 0A    STZ $0A04  [$7E:0A04]  ; Item selected for auto-cancel = 0
$91:E14D 9C A8 18    STZ $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$91:E150 9C AA 18    STZ $18AA  [$7E:18AA]  ; Samus knockback timer = 0
$91:E153 9C 48 0A    STZ $0A48  [$7E:0A48]  ; Samus hurt flash counter = 0 (again)
$91:E156 9C E0 0D    STZ $0DE0  [$7E:0DE0]  ; Disable debug invincibility
$91:E159 AD 98 09    LDA $0998  [$7E:0998]  ;\
$91:E15C C9 28 00    CMP #$0028             ;} If [game state] = 28h (load demo game data):
$91:E15F D0 03       BNE $03    [$E164]     ;/
$91:E161 20 90 87    JSR $8790  [$91:8790]  ; Load demo data

$91:E164 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$91:E167 8D 12 0A    STA $0A12  [$7E:0A12]  ;} Mirror Samus health
$91:E16A AB          PLB
$91:E16B 28          PLP
$91:E16C 6B          RTL
}


;;; $E16D: X-ray setup ;;;
{
;; Returns:
;;     Carry: set for success, clear for error
$91:E16D 08          PHP
$91:E16E 8B          PHB
$91:E16F 4B          PHK                    ;\
$91:E170 AB          PLB                    ;} DB = $91
$91:E171 C2 30       REP #$30
$91:E173 AD CC 0C    LDA $0CCC  [$7E:0CCC]  ;\
$91:E176 C9 07 00    CMP #$0007             ;|
$91:E179 D0 10       BNE $10    [$E18B]     ;|
$91:E17B AD D2 0C    LDA $0CD2  [$7E:0CD2]  ;|
$91:E17E C9 05 00    CMP #$0005             ;} If being drained by Shitroid: return carry clear
$91:E181 D0 08       BNE $08    [$E18B]     ;|
$91:E183 AD 66 0A    LDA $0A66  [$7E:0A66]  ;|
$91:E186 C9 02 00    CMP #$0002             ;|
$91:E189 F0 54       BEQ $54    [$E1DF]     ;/

$91:E18B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E18E C9 A4 00    CMP #$00A4             ;|
$91:E191 30 0F       BMI $0F    [$E1A2]     ;} If A4h <= [Samus pose] < A8h (landing from jump - neutral): return carry clear
$91:E193 C9 A8 00    CMP #$00A8             ;|
$91:E196 30 47       BMI $47    [$E1DF]     ;/
$91:E198 C9 E0 00    CMP #$00E0             ;\
$91:E19B 30 05       BMI $05    [$E1A2]     ;|
$91:E19D C9 E8 00    CMP #$00E8             ;} If E0h <= [Samus pose] < E8h (landing from a jump - aiming/firing): return carry clear
$91:E1A0 30 3D       BMI $3D    [$E1DF]     ;/

$91:E1A2 AD 98 09    LDA $0998  [$7E:0998]  ;\
$91:E1A5 C9 08 00    CMP #$0008             ;} If [game state] != main gameplay: return carry clear
$91:E1A8 D0 35       BNE $35    [$E1DF]     ;/
$91:E1AA AD 92 05    LDA $0592  [$7E:0592]  ;\
$91:E1AD D0 30       BNE $30    [$E1DF]     ;} If [power bomb explosion status] != inactive: return carry clear
$91:E1AF AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:E1B2 D0 2B       BNE $2B    [$E1DF]     ;} If [Samus Y speed] != 0: return carry clear
$91:E1B4 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$91:E1B7 D0 26       BNE $26    [$E1DF]     ;} If [Samus Y subspeed] != 0: return carry clear
$91:E1B9 AD 11 0A    LDA $0A11  [$7E:0A11]  ;\
$91:E1BC 29 FF 00    AND #$00FF             ;|
$91:E1BF AA          TAX                    ;|
$91:E1C0 BD 91 E2    LDA $E291,x[$91:E292]  ;} If [$E291 + [Samus previous movement type]] = 0: return carry clear
$91:E1C3 29 FF 00    AND #$00FF             ;|
$91:E1C6 F0 17       BEQ $17    [$E1DF]     ;/
$91:E1C8 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:E1CB 29 FF 00    AND #$00FF             ;|
$91:E1CE AA          TAX                    ;|
$91:E1CF BD 91 E2    LDA $E291,x[$91:E292]  ;} If [$E291 + [Samus movement type]] = 1: go to BRANCH_STANDING
$91:E1D2 29 FF 00    AND #$00FF             ;|
$91:E1D5 C9 01 00    CMP #$0001             ;|
$91:E1D8 F0 09       BEQ $09    [$E1E3]     ;/
$91:E1DA C9 02 00    CMP #$0002             ;\
$91:E1DD F0 1F       BEQ $1F    [$E1FE]     ;} If [$E291 + [Samus movement type]] = 2: go to BRANCH_CROUCHING

$91:E1DF AB          PLB
$91:E1E0 28          PLP
$91:E1E1 18          CLC                    ;\
$91:E1E2 6B          RTL                    ;} Return carry clear

; BRANCH_STANDING
$91:E1E3 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E1E6 29 FF 00    AND #$00FF             ;|
$91:E1E9 C9 04 00    CMP #$0004             ;} If Samus is facing right:
$91:E1EC F0 08       BEQ $08    [$E1F6]     ;/
$91:E1EE A9 D5 00    LDA #$00D5             ;\
$91:E1F1 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - x-ray - standing
$91:E1F4 80 21       BRA $21    [$E217]     ; Go to BRANCH_MERGE

$91:E1F6 A9 D6 00    LDA #$00D6             ;\
$91:E1F9 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - x-ray - standing
$91:E1FC 80 19       BRA $19    [$E217]     ; Go to BRANCH_MERGE

; BRANCH_CROUCHING
$91:E1FE AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E201 29 FF 00    AND #$00FF             ;|
$91:E204 C9 04 00    CMP #$0004             ;} If Samus is facing right:
$91:E207 F0 08       BEQ $08    [$E211]     ;/
$91:E209 A9 D9 00    LDA #$00D9             ;\
$91:E20C 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing right - x-ray - crouching
$91:E20F 80 06       BRA $06    [$E217]     ; Go to BRANCH_MERGE

$91:E211 A9 DA 00    LDA #$00DA             ;\
$91:E214 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ;} Special prospective pose = facing left - x-ray - crouching

; BRANCH_MERGE
$91:E217 A9 01 00    LDA #$0001             ;\
$91:E21A 8D 78 0A    STA $0A78  [$7E:0A78]  ;} Time is frozen flag = x-ray is active
$91:E21D A9 05 00    LDA #$0005             ;\
$91:E220 8D 30 0A    STA $0A30  [$7E:0A30]  ;} Special prospective pose change command = x-ray
$91:E223 A2 FE 01    LDX #$01FE             ;\
                                            ;|
$91:E226 A9 FF 00    LDA #$00FF             ;|
$91:E229 9F 00 98 7E STA $7E9800,x[$7E:99FE];} $7E:9800..99FF = 00,FFh (x-ray HDMA data table for window 2)
$91:E22D CA          DEX                    ;|
$91:E22E CA          DEX                    ;|
$91:E22F 10 F5       BPL $F5    [$E226]     ;/
$91:E231 22 0B 80 86 JSL $86800B[$86:800B]  ; Disable enemy projectiles
$91:E235 22 B8 83 84 JSL $8483B8[$84:83B8]  ; Disable PLMs
$91:E239 22 0B 80 87 JSL $87800B[$87:800B]  ; Disable animated tiles objects
$91:E23D 22 CD C4 8D JSL $8DC4CD[$8D:C4CD]  ; Disable palette FX objects
$91:E241 A9 01 00    LDA #$0001             ;\
$91:E244 8D 88 0A    STA $0A88  [$7E:0A88]  ;|
$91:E247 A9 00 98    LDA #$9800             ;|
$91:E24A 8D 89 0A    STA $0A89  [$7E:0A89]  ;|
$91:E24D 9C 8B 0A    STZ $0A8B  [$7E:0A8B]  ;|
$91:E250 A9 C8 98    LDA #$98C8             ;|
$91:E253 8D 8C 0A    STA $0A8C  [$7E:0A8C]  ;} $0A88..92 = 1,$9800, 0,$98C8, 98h,$9990, 0,0 (x-ray indirect HDMA table)
$91:E256 A9 98 00    LDA #$0098             ;|
$91:E259 8D 8E 0A    STA $0A8E  [$7E:0A8E]  ;|
$91:E25C A9 90 99    LDA #$9990             ;|
$91:E25F 8D 8F 0A    STA $0A8F  [$7E:0A8F]  ;|
$91:E262 9C 91 0A    STZ $0A91  [$7E:0A91]  ;/
$91:E265 9C 7A 0A    STZ $0A7A  [$7E:0A7A]  ; X-ray state = 0
$91:E268 9C 7C 0A    STZ $0A7C  [$7E:0A7C]  ; X-ray angular width delta = 0
$91:E26B 9C 7E 0A    STZ $0A7E  [$7E:0A7E]  ; X-ray angular subwidth delta = 0
$91:E26E 9C 84 0A    STZ $0A84  [$7E:0A84]  ; X-ray angular width = 0
$91:E271 9C 86 0A    STZ $0A86  [$7E:0A86]  ; X-ray angular subwidth = 0
$91:E274 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E277 29 FF 00    AND #$00FF             ;|
$91:E27A C9 04 00    CMP #$0004             ;} If Samus is facing right:
$91:E27D F0 08       BEQ $08    [$E287]     ;/
$91:E27F A9 40 00    LDA #$0040             ;\
$91:E282 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = 40h
$91:E285 80 06       BRA $06    [$E28D]

$91:E287 A9 C0 00    LDA #$00C0             ;\ Else (Samus is facing left):
$91:E28A 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = C0h

$91:E28D AB          PLB
$91:E28E 28          PLP
$91:E28F 38          SEC                    ;\
$91:E290 6B          RTL                    ;} Return carry set

$91:E291             db 01, ; 0: Standing
                        01, ; 1: Running
                        00, ; 2: Normal jumping
                        00, ; 3: Spin jumping
                        00, ; 4: Morph ball - on ground
                        02, ; 5: Crouching
                        00, ; 6: Falling
                        00, ; 7: Unused
                        00, ; 8: Morph ball - falling
                        00, ; 9: Unused
                        00, ; Ah: Knockback / crystal flash ending
                        00, ; Bh: Unused
                        00, ; Ch: Unused
                        00, ; Dh: Unused
                        00, ; Eh: Turning around - on ground
                        00, ; Fh: Crouching/standing/morphing/unmorphing transition
                        00, ; 10h: Moonwalking
                        00, ; 11h: Spring ball - on ground
                        00, ; 12h: Spring ball - in air
                        00, ; 13h: Spring ball - falling
                        00, ; 14h: Wall jumping
                        01, ; 15h: Ran into a wall
                        00, ; 16h: Grappling
                        00, ; 17h: Turning around - jumping
                        00, ; 18h: Turning around - falling
                        00, ; 19h: Damage boost
                        00, ; 1Ah: Grabbed by Draygon
                        00  ; 1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $E2AD: Set non x-ray Samus pose ;;;
{
; This routine is responsible for the x-ray stand-up glitch
; The case of [Samus movement type] = turning around isn't considered, and falls into the standing case,
; even if she was crouched whilst turning
$91:E2AD 08          PHP
$91:E2AE C2 30       REP #$30
$91:E2B0 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:E2B3 29 FF 00    AND #$00FF             ;|
$91:E2B6 C9 05 00    CMP #$0005             ;} If [Samus movement type] = crouching: go to BRANCH_CROUCHING
$91:E2B9 F0 1B       BEQ $1B    [$E2D6]     ;/
$91:E2BB AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E2BE 29 FF 00    AND #$00FF             ;|
$91:E2C1 C9 04 00    CMP #$0004             ;} If facing right:
$91:E2C4 F0 08       BEQ $08    [$E2CE]     ;/
$91:E2C6 A9 01 00    LDA #$0001             ;\
$91:E2C9 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - normal
$91:E2CC 80 21       BRA $21    [$E2EF]     ; Go to BRANCH_MERGE

$91:E2CE A9 02 00    LDA #$0002             ;\
$91:E2D1 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - normal
$91:E2D4 80 19       BRA $19    [$E2EF]     ; Go to BRANCH_MERGE

; BRANCH_CROUCHING
$91:E2D6 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E2D9 29 FF 00    AND #$00FF             ;|
$91:E2DC C9 04 00    CMP #$0004             ;} If facing right:
$91:E2DF F0 08       BEQ $08    [$E2E9]     ;/
$91:E2E1 A9 27 00    LDA #$0027             ;\
$91:E2E4 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - crouching
$91:E2E7 80 06       BRA $06    [$E2EF]     ; Go to BRANCH_MERGE

$91:E2E9 A9 28 00    LDA #$0028             ;\
$91:E2EC 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - crouching

; BRANCH_MERGE
$91:E2EF 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E2F3 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E2F7 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:E2FA 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:E2FD AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:E300 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:E303 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E306 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:E309 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E30C 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$91:E30F A9 37 A3    LDA #$A337             ;\
$91:E312 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$91:E315 A9 13 E9    LDA #$E913             ;\
$91:E318 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$91:E31B A9 FF FF    LDA #$FFFF             ;\
$91:E31E 8D 80 0A    STA $0A80  [$7E:0A80]  ;} $0A80 = FFFFh
$91:E321 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E324 0A          ASL A                  ;|
$91:E325 0A          ASL A                  ;|
$91:E326 0A          ASL A                  ;|
$91:E327 AA          TAX                    ;|
$91:E328 BF 2F B6 91 LDA $91B62F,x[$91:B63F];} If (pose Y radius) >= [Samus Y radius]:
$91:E32C 29 FF 00    AND #$00FF             ;|
$91:E32F 38          SEC                    ;|
$91:E330 ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$91:E333 85 12       STA $12    [$7E:0012]  ;|
$91:E335 30 0C       BMI $0C    [$E343]     ;/
$91:E337 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:E33A 38          SEC                    ;|
$91:E33B E5 12       SBC $12    [$7E:0012]  ;} Samus Y position -= (pose Y radius) - [Samus Y radius]
$91:E33D 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:E340 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]

$91:E343 22 00 80 86 JSL $868000[$86:8000]  ; Enable enemy projectiles
$91:E347 22 AD 83 84 JSL $8483AD[$84:83AD]  ; Enable PLMs
$91:E34B 22 00 80 87 JSL $878000[$87:8000]  ; Enable animated tiles objects
$91:E34F 22 C2 C4 8D JSL $8DC4C2[$8D:C4C2]  ; Enable palette FX objects
$91:E353 28          PLP
$91:E354 6B          RTL
}


;;; $E355: Debug. Handle debug mode select + L + B ;;;
{
; Give ammo, all items, switch to next beam configuration, toggle Samus tile viewer
$91:E355 08          PHP
$91:E356 C2 30       REP #$30
$91:E358 AD C5 05    LDA $05C5  [$7E:05C5]  ;\
$91:E35B 29 00 80    AND #$8000             ;|
$91:E35E D0 03       BNE $03    [$E363]     ;} If not newly pressed B whilst select + L is pressed: go to BRANCH_HANDLED_INPUT
$91:E360 4C EB E3    JMP $E3EB  [$91:E3EB]  ;/

$91:E363 AD F6 0D    LDA $0DF6  [$7E:0DF6]  ;\
$91:E366 F0 03       BEQ $03    [$E36B]     ;} If [Samus tile viewer flag] != 0: go to BRANCH_TOGGLE_OFF
$91:E368 4C E8 E3    JMP $E3E8  [$91:E3E8]  ;/

$91:E36B A9 01 00    LDA #$0001             ;\
$91:E36E 8D F6 0D    STA $0DF6  [$7E:0DF6]  ;} Samus tile viewer flag = 1
$91:E371 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$91:E374 1A          INC A                  ;} Equipped beams += 1
$91:E375 8D A6 09    STA $09A6  [$7E:09A6]  ;/
$91:E378 29 FF 0F    AND #$0FFF             ;\
$91:E37B C9 0C 00    CMP #$000C             ;} If [equipped beams] & FFFh >= spazer + plasma:
$91:E37E 30 09       BMI $09    [$E389]     ;/
$91:E380 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$91:E383 29 00 F0    AND #$F000             ;} Equipped beams &= ~FFFh (clear beams except charge)
$91:E386 8D A6 09    STA $09A6  [$7E:09A6]  ;/

$91:E389 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$91:E38D A9 3F F3    LDA #$F33F             ;\
$91:E390 8D A4 09    STA $09A4  [$7E:09A4]  ;} Equipped items = collected items = F33Fh (all of them + 10h)
$91:E393 8D A2 09    STA $09A2  [$7E:09A2]  ;/
$91:E396 A9 84 03    LDA #$0384             ;\
$91:E399 8D C8 09    STA $09C8  [$7E:09C8]  ;} Samus missiles = Samus max missiles = 900
$91:E39C 8D C6 09    STA $09C6  [$7E:09C6]  ;/
$91:E39F A9 5A 00    LDA #$005A             ;\
$91:E3A2 8D CC 09    STA $09CC  [$7E:09CC]  ;} Samus super missiles = Samus max super missiles = 90
$91:E3A5 8D CA 09    STA $09CA  [$7E:09CA]  ;/
$91:E3A8 A9 5A 00    LDA #$005A             ;\
$91:E3AB 8D D0 09    STA $09D0  [$7E:09D0]  ;} Samus power bombs = Samus max power bombs = 90
$91:E3AE 8D CE 09    STA $09CE  [$7E:09CE]  ;/
$91:E3B1 A9 4B 04    LDA #$044B             ;\
$91:E3B4 8D C4 09    STA $09C4  [$7E:09C4]  ;} Samus health = Samus max health = 1099
$91:E3B7 8D C2 09    STA $09C2  [$7E:09C2]  ;/
$91:E3BA A9 F3 01    LDA #$01F3             ;\
$91:E3BD 8D D6 09    STA $09D6  [$7E:09D6]  ;} Samus reserve health = 499
$91:E3C0 9C D8 09    STZ $09D8  [$7E:09D8]  ; Samus reserve missiles = 0
$91:E3C3 A9 0F 10    LDA #$100F             ;\
$91:E3C6 8D A8 09    STA $09A8  [$7E:09A8]  ;} Collected beams = 100Fh (all of them)
$91:E3C9 AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$91:E3CC 09 00 10    ORA #$1000             ;} Equip charge beam
$91:E3CF 8D A6 09    STA $09A6  [$7E:09A6]  ;/
$91:E3D2 22 2E 9A 80 JSL $809A2E[$80:9A2E]  ; Add grapple to HUD WRAM tilemap
$91:E3D6 22 3E 9A 80 JSL $809A3E[$80:9A3E]  ; Add x-ray to HUD WRAM tilemap
$91:E3DA 22 CF 99 80 JSL $8099CF[$80:99CF]  ; Add missiles to HUD WRAM tilemap
$91:E3DE 22 0E 9A 80 JSL $809A0E[$80:9A0E]  ; Add super missiles to HUD WRAM tilemap
$91:E3E2 22 1E 9A 80 JSL $809A1E[$80:9A1E]  ; Add power bombs to HUD WRAM tilemap
$91:E3E6 80 03       BRA $03    [$E3EB]     ; Go to BRANCH_HANDLED_INPUT

; BRANCH_TOGGLE_OFF
$91:E3E8 9C F6 0D    STZ $0DF6  [$7E:0DF6]  ; Samus tile viewer flag = 0

; BRANCH_HANDLED_INPUT
$91:E3EB AD F6 0D    LDA $0DF6  [$7E:0DF6]  ;\
$91:E3EE F0 04       BEQ $04    [$E3F4]     ;} If [Samus tile viewer flag] != 0:
$91:E3F0 22 7A ED 92 JSL $92ED7A[$92:ED7A]  ; Samus tile viewer

$91:E3F4 28          PLP
$91:E3F5 6B          RTL
}


;;; $E3F6: Make Samus face forward ;;;
{
$91:E3F6 08          PHP
$91:E3F7 8B          PHB
$91:E3F8 4B          PHK                    ;\
$91:E3F9 AB          PLB                    ;} DB = $91
$91:E3FA C2 30       REP #$30
$91:E3FC DA          PHX
$91:E3FD AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E400 89 20 00    BIT #$0020             ;} If gravity suit not equipped:
$91:E403 D0 0D       BNE $0D    [$E412]     ;/
$91:E405 89 01 00    BIT #$0001             ;\
$91:E408 D0 08       BNE $08    [$E412]     ;} If varia suit not equipped:
$91:E40A A9 00 00    LDA #$0000             ;\
$91:E40D 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - power suit
$91:E410 80 06       BRA $06    [$E418]

$91:E412 A9 9B 00    LDA #$009B             ;\ Else (varia/gravity suit equipped):
$91:E415 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit

$91:E418 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E41C 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E420 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:E423 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:E426 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:E429 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:E42C AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E42F 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:E432 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E435 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$91:E438 AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$91:E43B C9 18 00    CMP #$0018             ;} If [Samus Y radius] != 18h: (Y radius of 18h is only used by the two facing forward poses)
$91:E43E F0 0D       BEQ $0D    [$E44D]     ;/
$91:E440 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:E443 38          SEC                    ;|
$91:E444 E9 03 00    SBC #$0003             ;} Samus Y position -= 3
$91:E447 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:E44A 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]

$91:E44D A9 13 E7    LDA #$E713             ;\
$91:E450 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = $E713 (Samus is locked)
$91:E453 A9 DC E8    LDA #$E8DC             ;\
$91:E456 8D 44 0A    STA $0A44  [$7E:0A44]  ;} Samus new state handler = $E8DC (Samus is locked)
$91:E459 A9 FF FF    LDA #$FFFF             ;\
$91:E45C 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$91:E45F 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$91:E462 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$91:E465 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$91:E468 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$91:E46B 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none
$91:E46E A9 1F 00    LDA #$001F             ;\
$91:E471 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - kill grapple beam
$91:E475 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$91:E478 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$91:E47B 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:E47E 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:E481 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:E484 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:E487 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:E48A 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:E48D 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:E490 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$91:E493 9C D6 0C    STZ $0CD6  [$7E:0CD6]  ;\
$91:E496 9C D8 0C    STZ $0CD8  [$7E:0CD8]  ;} Flare animation frames = 0
$91:E499 9C DA 0C    STZ $0CDA  [$7E:0CDA]  ;/
$91:E49C 9C DC 0C    STZ $0CDC  [$7E:0CDC]  ;\
$91:E49F 9C DE 0C    STZ $0CDE  [$7E:0CDE]  ;} Flare animation timers = 0
$91:E4A2 9C E0 0C    STZ $0CE0  [$7E:0CE0]  ;/
$91:E4A5 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$91:E4A9 FA          PLX
$91:E4AA AB          PLB
$91:E4AB 28          PLP
$91:E4AC 6B          RTL
}


;;; $E4AD..E632: Drained Samus controller ;;;
{
;;; $E4AD: Drained Samus controller ;;;
{
;; Parameters:
;;     A: Function index
;;         0: Let drained Samus fall
;;         1: Put Samus into standing drained pose
;;         2: Release Samus from drained pose
;;         3: Enable hyper beam
;;         4: Put Samus into crouching/falling drained pose

; Very similar to $90:F084
$91:E4AD 08          PHP
$91:E4AE 8B          PHB
$91:E4AF 4B          PHK                    ;\
$91:E4B0 AB          PLB                    ;} DB = $91
$91:E4B1 C2 30       REP #$30
$91:E4B3 DA          PHX
$91:E4B4 5A          PHY
$91:E4B5 0A          ASL A                  ;\
$91:E4B6 AA          TAX                    ;} Execute [$E4EE + [A] * 2]
$91:E4B7 FC EE E4    JSR ($E4EE,x)[$91:E4F8];/
$91:E4BA 90 2D       BCC $2D    [$E4E9]     ; If carry set:
$91:E4BC AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:E4BF 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:E4C2 AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:E4C5 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:E4C8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E4CB 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:E4CE AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E4D1 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$91:E4D4 A9 FF FF    LDA #$FFFF             ;\
$91:E4D7 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = FFFFh
$91:E4DA 8D 2A 0A    STA $0A2A  [$7E:0A2A]  ; Special prospective pose = FFFFh
$91:E4DD 8D 2C 0A    STA $0A2C  [$7E:0A2C]  ; Super special prospective pose = FFFFh
$91:E4E0 9C 2E 0A    STZ $0A2E  [$7E:0A2E]  ; Prospective pose change command = none
$91:E4E3 9C 30 0A    STZ $0A30  [$7E:0A30]  ; Special prospective pose change command = none
$91:E4E6 9C 32 0A    STZ $0A32  [$7E:0A32]  ; Special Super special pose change command = none

$91:E4E9 7A          PLY
$91:E4EA FA          PLX
$91:E4EB AB          PLB
$91:E4EC 28          PLP
$91:E4ED 6B          RTL

$91:E4EE             dw E4F8, E571, E59B, E5F0, E60C
}


;;; $E4F8: Drained Samus controller - 0: let drained Samus fall ;;;
{
$91:E4F8 A9 15 00    LDA #$0015             ;\
$91:E4FB 38          SEC                    ;|
$91:E4FC ED 00 0B    SBC $0B00  [$7E:0B00]  ;|
$91:E4FF 85 12       STA $12    [$7E:0012]  ;|
$91:E501 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} Samus Y position -= 15h - [Samus Y radius]
$91:E504 38          SEC                    ;|
$91:E505 E5 12       SBC $12    [$7E:0012]  ;|
$91:E507 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:E50A 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:E50D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E510 29 FF 00    AND #$00FF             ;|
$91:E513 C9 04 00    CMP #$0004             ;} If facing right:
$91:E516 F0 08       BEQ $08    [$E520]     ;/
$91:E518 A9 E8 00    LDA #$00E8             ;\
$91:E51B 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - Samus drained - crouching/falling
$91:E51E 80 06       BRA $06    [$E526]

$91:E520 A9 E9 00    LDA #$00E9             ;\ Else (facing left):
$91:E523 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - Samus drained - crouching/falling

$91:E526 A9 02 00    LDA #$0002             ;\
$91:E529 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 2
$91:E52C 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E530 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E534 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E537 0A          ASL A                  ;|
$91:E538 0A          ASL A                  ;|
$91:E539 0A          ASL A                  ;|
$91:E53A AA          TAX                    ;} Samus Y radius = [$B62F + [Samus pose] * 8]
$91:E53B BD 2F B6    LDA $B62F,x[$91:BD77]  ;|
$91:E53E 29 FF 00    AND #$00FF             ;|
$91:E541 8D 00 0B    STA $0B00  [$7E:0B00]  ;/
$91:E544 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:E547 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:E54A 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:E54D 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:E550 A9 02 00    LDA #$0002             ;\
$91:E553 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$91:E556 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$91:E559 9C D6 0C    STZ $0CD6  [$7E:0CD6]  ;\
$91:E55C 9C D8 0C    STZ $0CD8  [$7E:0CD8]  ;} Flare animation frames = 0
$91:E55F 9C DA 0C    STZ $0CDA  [$7E:0CDA]  ;/
$91:E562 9C DC 0C    STZ $0CDC  [$7E:0CDC]  ;\
$91:E565 9C DE 0C    STZ $0CDE  [$7E:0CDE]  ;} Flare animation timers = 0
$91:E568 9C E0 0C    STZ $0CE0  [$7E:0CE0]  ;/
$91:E56B 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$91:E56F 38          SEC                    ;\
$91:E570 60          RTS                    ;} Return carry set
}


;;; $E571: Drained Samus controller - 1: put Samus into standing drained pose ;;;
{
; Put Samus into standing drained pose
$91:E571 A9 10 00    LDA #$0010             ;\
$91:E574 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 10h
$91:E577 9C 96 0A    STZ $0A96  [$7E:0A96]  ; Samus animation frame = 0
$91:E57A AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E57D 29 FF 00    AND #$00FF             ;|
$91:E580 C9 04 00    CMP #$0004             ;} If facing right:
$91:E583 F0 08       BEQ $08    [$E58D]     ;/
$91:E585 A9 EA 00    LDA #$00EA             ;\
$91:E588 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - Samus drained - standing
$91:E58B 80 06       BRA $06    [$E593]

$91:E58D A9 EB 00    LDA #$00EB             ;\ Else (facing left):
$91:E590 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - Samus drained - standing

$91:E593 A9 0E E9    LDA #$E90E             ;\
$91:E596 8D 5A 0A    STA $0A5A  [$7E:0A5A]  ;} Timer / Samus hack handler = RTS
$91:E599 38          SEC                    ;\
$91:E59A 60          RTS                    ;} Return carry set
}


;;; $E59B: Drained Samus controller - 2: release Samus from drained pose ;;;
{
$91:E59B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E59E C9 E8 00    CMP #$00E8             ;|
$91:E5A1 F0 1D       BEQ $1D    [$E5C0]     ;} If [Samus pose] = Samus drained - crouching/falling: go to BRANCH_CROUCHING_FALLING
$91:E5A3 C9 E9 00    CMP #$00E9             ;|
$91:E5A6 F0 18       BEQ $18    [$E5C0]     ;/
$91:E5A8 C9 EA 00    CMP #$00EA             ;\
$91:E5AB F0 05       BEQ $05    [$E5B2]     ;|
$91:E5AD C9 EB 00    CMP #$00EB             ;} If [Samus pose] != Samus drained - standing: go to BRANCH_MERGE
$91:E5B0 D0 1A       BNE $1A    [$E5CC]     ;/

$91:E5B2 A9 01 00    LDA #$0001             ;\
$91:E5B5 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$91:E5B8 A9 04 00    LDA #$0004             ;\
$91:E5BB 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 5 - 1 (Samus is let up)
$91:E5BE 80 0C       BRA $0C    [$E5CC]     ; Go to BRANCH_MERGE

; BRANCH_CROUCHING_FALLING
$91:E5C0 A9 01 00    LDA #$0001             ;\
$91:E5C3 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 1
$91:E5C6 A9 0D 00    LDA #$000D             ;\
$91:E5C9 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = Eh - 1 (Samus is let up)

; BRANCH_MERGE
$91:E5CC AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E5CF 0A          ASL A                  ;|
$91:E5D0 0A          ASL A                  ;|
$91:E5D1 0A          ASL A                  ;|
$91:E5D2 AA          TAX                    ;} Samus Y radius = [$B62F + [Samus pose] * 8]
$91:E5D3 BD 2F B6    LDA $B62F,x[$91:BD77]  ;|
$91:E5D6 29 FF 00    AND #$00FF             ;|
$91:E5D9 8D 00 0B    STA $0B00  [$7E:0B00]  ;/
$91:E5DC 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:E5DF 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:E5E2 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:E5E5 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:E5E8 A9 02 00    LDA #$0002             ;\
$91:E5EB 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$91:E5EE 38          SEC                    ;\
$91:E5EF 60          RTS                    ;} Return carry set
}


;;; $E5F0: Drained Samus controller - 3: enable hyper beam ;;;
{
$91:E5F0 A9 09 10    LDA #$1009             ;\
$91:E5F3 8D A6 09    STA $09A6  [$7E:09A6]  ;} Equipped beams = wave/plasma/charge
$91:E5F6 22 8D AC 90 JSL $90AC8D[$90:AC8D]  ; Update beam tiles and palette
$91:E5FA A0 F0 E1    LDY #$E1F0             ;\
$91:E5FD 22 E9 C4 8D JSL $8DC4E9[$8D:C4E9]  ;} Spawn hyper beam palette FX object
$91:E601 A9 00 80    LDA #$8000             ;\
$91:E604 8D 76 0A    STA $0A76  [$7E:0A76]  ;} Enable hyper beam
$91:E607 9C C0 0D    STZ $0DC0  [$7E:0DC0]  ; Resume charging beam sound effect flag = 0
$91:E60A 18          CLC                    ;\
$91:E60B 60          RTS                    ;} Return carry clear
}


;;; $E60C: Drained Samus controller - 4: put Samus into crouching/falling drained pose ;;;
{
$91:E60C A9 10 00    LDA #$0010             ;\
$91:E60F 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 10h
$91:E612 A9 08 00    LDA #$0008             ;\
$91:E615 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 8 (crouching)
$91:E618 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E61B 29 FF 00    AND #$00FF             ;|
$91:E61E C9 04 00    CMP #$0004             ;} If facing right:
$91:E621 F0 08       BEQ $08    [$E62B]     ;/
$91:E623 A9 E8 00    LDA #$00E8             ;\
$91:E626 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - Samus drained - crouching/falling
$91:E629 38          SEC                    ;\
$91:E62A 60          RTS                    ;} Return carry set

$91:E62B A9 E9 00    LDA #$00E9             ;\ Else (facing left):
$91:E62E 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - Samus drained - crouching/falling
$91:E631 38          SEC                    ;\
$91:E632 60          RTS                    ;} Return carry set
}
}


;;; $E633: Update Samus pose due to change of equipment ;;;
{
; Called by $90:F29E: unlock Samus from map station
; Seems to have been coded far more generally than for just map station release
; Notably, this handles equipping speed booster mid-run
; (if it did not, the speed boost timer might be 0 and underflow during the speed boost check $90:857D)
$91:E633 08          PHP
$91:E634 8B          PHB
$91:E635 4B          PHK                    ;\
$91:E636 AB          PLB                    ;} DB = $91
$91:E637 C2 30       REP #$30
$91:E639 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:E63C 29 FF 00    AND #$00FF             ;|
$91:E63F 0A          ASL A                  ;} Execute [$E6E1 + [Samus movement type] * 2]
$91:E640 AA          TAX                    ;|
$91:E641 FC E1 E6    JSR ($E6E1,x)[$91:E732];/
$91:E644 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E647 89 00 20    BIT #$2000             ;} If speed booster not equipped:
$91:E64A D0 23       BNE $23    [$E66F]     ;/
$91:E64C 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echoes index = 0
$91:E64F 9C C0 0A    STZ $0AC0  [$7E:0AC0]  ;\
$91:E652 9C C2 0A    STZ $0AC2  [$7E:0AC2]  ;} Speed echo X speeds = 0
$91:E655 9C 3C 0B    STZ $0B3C  [$7E:0B3C]  ; Samus running momentum flag = 0
$91:E658 9C 3E 0B    STZ $0B3E  [$7E:0B3E]  ; Speed boost counter / timer = 0
$91:E65B 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$91:E65E 9C D0 0A    STZ $0AD0  [$7E:0AD0]  ; Speed boosting palette timer = 0
$91:E661 9C B0 0A    STZ $0AB0  [$7E:0AB0]  ;\
$91:E664 9C B2 0A    STZ $0AB2  [$7E:0AB2]  ;} Speed echo X positions = 0
$91:E667 9C B8 0A    STZ $0AB8  [$7E:0AB8]  ;\
$91:E66A 9C BA 0A    STZ $0ABA  [$7E:0ABA]  ;} Speed echo Y positions = 0
$91:E66D 80 16       BRA $16    [$E685]

$91:E66F AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\ Else (speed booster equipped):
$91:E672 F0 11       BEQ $11    [$E685]     ;} If [Samus running momentum flag] != 0:
$91:E674 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$91:E677 D0 0C       BNE $0C    [$E685]     ;} If [speed boost counter / timer] = 0:
$91:E679 8D D0 0A    STA $0AD0  [$7E:0AD0]  ; Speed boosting palette timer = 0
$91:E67C 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0
$91:E67F AD 1F B6    LDA $B61F  [$91:B61F]  ;\
$91:E682 8D 3E 0B    STA $0B3E  [$7E:0B3E]  ;} Speed boost timer = 1, speed boost counter = 0

$91:E685 AD 32 0D    LDA $0D32  [$7E:0D32]  ;\
$91:E688 C9 F0 C4    CMP #$C4F0             ;} If [grapple beam function] != inactive:
$91:E68B F0 10       BEQ $10    [$E69D]     ;/
$91:E68D A9 02 00    LDA #$0002             ;\
$91:E690 22 F0 AC 90 JSL $90ACF0[$90:ACF0]  ;} Load ice beam palette
$91:E694 A9 06 00    LDA #$0006             ;\
$91:E697 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 6, sound library 1, max queued sounds allowed = 6 (grappling)
$91:E69B 80 2E       BRA $2E    [$E6CB]     ; Go to BRANCH_LIBRARY_1_SOUND_PLAYED

$91:E69D AD A6 09    LDA $09A6  [$7E:09A6]  ;\
$91:E6A0 89 00 10    BIT #$1000             ;} If not equipped charge beam:
$91:E6A3 D0 17       BNE $17    [$E6BC]     ;/
$91:E6A5 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Flare counter = 0
$91:E6A8 9C D6 0C    STZ $0CD6  [$7E:0CD6]  ;\
$91:E6AB 9C D8 0C    STZ $0CD8  [$7E:0CD8]  ;} Flare animation frames = 0
$91:E6AE 9C DA 0C    STZ $0CDA  [$7E:0CDA]  ;/
$91:E6B1 9C DC 0C    STZ $0CDC  [$7E:0CDC]  ;\
$91:E6B4 9C DE 0C    STZ $0CDE  [$7E:0CDE]  ;} Flare animation timers = 0
$91:E6B7 9C E0 0C    STZ $0CE0  [$7E:0CE0]  ;/
$91:E6BA 80 0F       BRA $0F    [$E6CB]

$91:E6BC AD D0 0C    LDA $0CD0  [$7E:0CD0]  ;\ Else (equipped charge beam):
$91:E6BF C9 10 00    CMP #$0010             ;} If [flare counter] >= 10h:
$91:E6C2 30 07       BMI $07    [$E6CB]     ;/
$91:E6C4 A9 41 00    LDA #$0041             ;\
$91:E6C7 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 41h, sound library 1, max queued sounds allowed = 6 (resume charging beam)

; BRANCH_LIBRARY_1_SOUND_PLAYED
$91:E6CB 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette
$91:E6CF AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$91:E6D2 C9 1F 00    CMP #$001F             ;} If [Samus health] <= 30:
$91:E6D5 10 07       BPL $07    [$E6DE]     ;/
$91:E6D7 A9 02 00    LDA #$0002             ;\
$91:E6DA 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2, sound library 3, max queued sounds allowed = 6 (low health beep)

$91:E6DE AB          PLB
$91:E6DF 28          PLP
$91:E6E0 6B          RTL

$91:E6E1             dw E733, ; *0: Standing
                        E732, ;  1: Running
                        E732, ;  2: Normal jumping
                        E776, ; *3: Spin jumping
                        E83A, ; *4: Morph ball - on ground
                        E732, ;  5: Crouching
                        E732, ;  6: Falling
                        E732, ;  7: Unused
                        E83A, ; *8: Morph ball - falling
                        E732, ;  9: Unused
                        E732, ;  Ah: Knockback / crystal flash ending
                        E732, ;  Bh: Unused
                        E732, ;  Ch: Unused
                        E732, ;  Dh: Unused
                        E732, ;  Eh: Turning around - on ground
                        E732, ;  Fh: Crouching/standing/morphing/unmorphing transition
                        E732, ;  10h: Moonwalking
                        E867, ; *11h: Spring ball - on ground
                        E867, ; *12h: Spring ball - in air
                        E867, ; *13h: Spring ball - falling
                        E894, ; *14h: Wall jumping
                        E732, ;  15h: Ran into a wall
                        E732, ;  16h: Grappling
                        E732, ;  17h: Turning around - jumping
                        E732, ;  18h: Turning around - falling
                        E732, ;  19h: Damage boost
                        E732, ;  1Ah: Grabbed by Draygon
                        E732  ;  1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $E719: Update Samus previous pose ;;;
{
$91:E719 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:E71C 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:E71F AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:E722 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:E725 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E728 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:E72B AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E72E 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]
$91:E731 60          RTS
}


;;; $E732: RTS ;;;
{
$91:E732 60          RTS
}


;;; $E733..E8B5: Update Samus pose due to change of equipment ;;;
{
;;; $E733: Update Samus pose due to change of equipment - standing ;;;
{
$91:E733 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E736 C9 00 00    CMP #$0000             ;} If [Samus pose] != facing forward - power suit:
$91:E739 F0 06       BEQ $06    [$E741]     ;/
$91:E73B C9 9B 00    CMP #$009B             ;\
$91:E73E F0 17       BEQ $17    [$E757]     ;} If [Samus pose] = facing forward - varia/gravity suit: go to BRANCH_VARIA_GRAVITY
$91:E740 60          RTS                    ; Return

$91:E741 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E744 89 01 00    BIT #$0001             ;} If varia suit not equipped:
$91:E747 D0 06       BNE $06    [$E74F]     ;/
$91:E749 89 20 00    BIT #$0020             ;\
$91:E74C D0 01       BNE $01    [$E74F]     ;} If gravity suit not equipped:
$91:E74E 60          RTS                    ; Return

$91:E74F A9 9B 00    LDA #$009B             ;\
$91:E752 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - varia/gravity suit
$91:E755 80 13       BRA $13    [$E76A]     ; Go to BRANCH_POSE_CHANGED

; BRANCH_VARIA_GRAVITY
$91:E757 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E75A 89 01 00    BIT #$0001             ;} If varia suit not equipped:
$91:E75D D0 16       BNE $16    [$E775]     ;/
$91:E75F 89 20 00    BIT #$0020             ;\
$91:E762 D0 11       BNE $11    [$E775]     ;} If gravity suit not equipped:
$91:E764 A9 00 00    LDA #$0000             ;\
$91:E767 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing forward - power suit

; BRANCH_POSE_CHANGED
$91:E76A 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E76E 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E772 20 19 E7    JSR $E719  [$91:E719]  ; Update Samus previous pose

$91:E775 60          RTS
}


;;; $E776: Update Samus pose due to change of equipment - spin jumping ;;;
{
$91:E776 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E779 29 FF 00    AND #$00FF             ;|
$91:E77C C9 04 00    CMP #$0004             ;|
$91:E77F F0 08       BEQ $08    [$E789]     ;|
$91:E781 A9 08 01    LDA #$0108             ;} Samus previous pose X direction = [Samus pose X direction]
$91:E784 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous movement type = running
$91:E787 80 06       BRA $06    [$E78F]     ;|
                                            ;|
$91:E789 A9 04 01    LDA #$0104             ;|
$91:E78C 8D 22 0A    STA $0A22  [$7E:0A22]  ;/

$91:E78F AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E792 C9 81 00    CMP #$0081             ;|
$91:E795 F0 20       BEQ $20    [$E7B7]     ;} If [Samus pose] = screw attack: go to BRANCH_SCREW_ATTACK
$91:E797 C9 82 00    CMP #$0082             ;|
$91:E79A F0 1B       BEQ $1B    [$E7B7]     ;/
$91:E79C C9 1B 00    CMP #$001B             ;\
$91:E79F F0 07       BEQ $07    [$E7A8]     ;|
$91:E7A1 C9 1C 00    CMP #$001C             ;} If [Samus pose] != space jump:
$91:E7A4 F0 02       BEQ $02    [$E7A8]     ;/
$91:E7A6 80 6D       BRA $6D    [$E815]     ; Go to BRANCH_MERGE

$91:E7A8 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E7AB 89 08 00    BIT #$0008             ;} If screw attack equipped: go to BRANCH_CHANGE_TO_SCREW_ATTACK
$91:E7AE D0 16       BNE $16    [$E7C6]     ;/
$91:E7B0 89 00 02    BIT #$0200             ;\
$91:E7B3 F0 47       BEQ $47    [$E7FC]     ;} If space jump not equipped: go to BRANCH_CHANGE_TO_SPIN_JUMP
$91:E7B5 80 5E       BRA $5E    [$E815]     ; Go to BRANCH_MERGE

; BRANCH_SCREW_ATTACK
$91:E7B7 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E7BA 89 08 00    BIT #$0008             ;} If screw attack equipped: go to BRANCH_MERGE
$91:E7BD D0 56       BNE $56    [$E815]     ;/
$91:E7BF 89 00 02    BIT #$0200             ;\
$91:E7C2 D0 1D       BNE $1D    [$E7E1]     ;} If space jump equipped: go to BRANCH_CHANGE_TO_SPACE_JUMP
$91:E7C4 80 36       BRA $36    [$E7FC]     ; Go to BRANCH_CHANGE_TO_SPIN_JUMP

; BRANCH_CHANGE_TO_SCREW_ATTACK
$91:E7C6 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E7C9 29 FF 00    AND #$00FF             ;|
$91:E7CC C9 04 00    CMP #$0004             ;} If facing right:
$91:E7CF F0 08       BEQ $08    [$E7D9]     ;/
$91:E7D1 A9 81 00    LDA #$0081             ;\
$91:E7D4 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - screw attack
$91:E7D7 80 3C       BRA $3C    [$E815]     ; Go to BRANCH_MERGE

$91:E7D9 A9 82 00    LDA #$0082             ;\ Else (facing left):
$91:E7DC 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - screw attack
$91:E7DF 80 34       BRA $34    [$E815]     ; Go to BRANCH_MERGE

; BRANCH_CHANGE_TO_SPACE_JUMP
$91:E7E1 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E7E4 29 FF 00    AND #$00FF             ;|
$91:E7E7 C9 04 00    CMP #$0004             ;} If facing right:
$91:E7EA F0 08       BEQ $08    [$E7F4]     ;/
$91:E7EC A9 1B 00    LDA #$001B             ;\
$91:E7EF 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - space jump
$91:E7F2 80 21       BRA $21    [$E815]     ; Go to BRANCH_MERGE

$91:E7F4 A9 1C 00    LDA #$001C             ;\ Else (facing left):
$91:E7F7 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - space jump
$91:E7FA 80 19       BRA $19    [$E815]     ; Go to BRANCH_MERGE

; BRANCH_CHANGE_TO_SPIN_JUMP
$91:E7FC AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E7FF 29 FF 00    AND #$00FF             ;|
$91:E802 C9 04 00    CMP #$0004             ;} If facing right:
$91:E805 F0 08       BEQ $08    [$E80F]     ;/
$91:E807 A9 19 00    LDA #$0019             ;\
$91:E80A 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - spin jump
$91:E80D 80 06       BRA $06    [$E815]     ; Go to BRANCH_MERGE

$91:E80F A9 1A 00    LDA #$001A             ;\ Else (facing left):
$91:E812 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - spin jump

; BRANCH_MERGE
$91:E815 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E819 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E81D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E820 29 FF 00    AND #$00FF             ;|
$91:E823 C9 04 00    CMP #$0004             ;|
$91:E826 F0 08       BEQ $08    [$E830]     ;|
$91:E828 A9 08 03    LDA #$0308             ;} Samus previous pose X direction = [Samus pose X direction]
$91:E82B 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous movement type = spin jumping
$91:E82E 80 06       BRA $06    [$E836]     ;|
                                            ;|
$91:E830 A9 04 03    LDA #$0304             ;|
$91:E833 8D 22 0A    STA $0A22  [$7E:0A22]  ;/

$91:E836 20 19 E7    JSR $E719  [$91:E719]  ; Update Samus previous pose
$91:E839 60          RTS
}


;;; $E83A: Update Samus pose due to change of equipment - morph ball ;;;
{
$91:E83A AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E83D 89 02 00    BIT #$0002             ;} If spring ball not equipped: return
$91:E840 F0 24       BEQ $24    [$E866]     ;/
$91:E842 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E845 29 FF 00    AND #$00FF             ;|
$91:E848 C9 04 00    CMP #$0004             ;} If facing right:
$91:E84B F0 08       BEQ $08    [$E855]     ;/
$91:E84D A9 79 00    LDA #$0079             ;\
$91:E850 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - spring ball - on ground
$91:E853 80 06       BRA $06    [$E85B]

$91:E855 A9 7A 00    LDA #$007A             ;\ Else (facing left):
$91:E858 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - morph ball - spring ball - on ground

$91:E85B 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E85F 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E863 20 19 E7    JSR $E719  [$91:E719]  ; Update Samus previous pose

$91:E866 60          RTS
}


;;; $E867: Update Samus pose due to change of equipment - spring ball ;;;
{
$91:E867 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E86A 89 02 00    BIT #$0002             ;} If spring ball equipped: return
$91:E86D D0 24       BNE $24    [$E893]     ;/
$91:E86F AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E872 29 FF 00    AND #$00FF             ;|
$91:E875 C9 04 00    CMP #$0004             ;} If facing right:
$91:E878 F0 08       BEQ $08    [$E882]     ;/
$91:E87A A9 1D 00    LDA #$001D             ;\
$91:E87D 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - no springball - on ground
$91:E880 80 06       BRA $06    [$E888]

$91:E882 A9 41 00    LDA #$0041             ;\ Else (facing left):
$91:E885 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - morph ball - no springball - on ground

$91:E888 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:E88C 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:E890 20 19 E7    JSR $E719  [$91:E719]  ; Update Samus previous pose

$91:E893 60          RTS
}


;;; $E894: Update Samus pose due to change of equipment - wall jumping ;;;
{
$91:E894 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:E897 89 08 00    BIT #$0008             ;} If screw attack equipped: go to BRANCH_SCREW_ATTACK
$91:E89A D0 13       BNE $13    [$E8AF]     ;/
$91:E89C 89 00 02    BIT #$0200             ;\
$91:E89F D0 07       BNE $07    [$E8A8]     ;} If space jump equipped: go to BRANCH_SPACE_JUMP
$91:E8A1 A9 03 00    LDA #$0003             ;\
$91:E8A4 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 3 (normal)
$91:E8A7 60          RTS                    ; Return

; BRANCH_SPACE_JUMP
$91:E8A8 A9 0D 00    LDA #$000D             ;\
$91:E8AB 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = Dh (space jump)
$91:E8AE 60          RTS                    ; Return

; BRANCH_SCREW_ATTACK
$91:E8AF A9 17 00    LDA #$0017             ;\
$91:E8B2 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 17h (screw attack)
$91:E8B5 60          RTS
}
}


;;; $E8B6..EADD: Set prospective Samus pose according to solid vertical collision result ;;;
{
;;; $E8B6: Set prospective Samus pose according to solid vertical collision result ;;;
{
; Called by "active" $0A44 handlers (where active = normal or title/intro demo)
$91:E8B6 08          PHP
$91:E8B7 8B          PHB
$91:E8B8 4B          PHK                    ;\
$91:E8B9 AB          PLB                    ;} DB = $91
$91:E8BA C2 30       REP #$30
$91:E8BC AD C6 0D    LDA $0DC6  [$7E:0DC6]  ;\
$91:E8BF F0 08       BEQ $08    [$E8C9]     ;} If [Samus solid vertical collision result] != no change:
$91:E8C1 29 FF 00    AND #$00FF             ;\
$91:E8C4 0A          ASL A                  ;|
$91:E8C5 AA          TAX                    ;} Execute [$E8CC + [Samus solid vertical collision result] * 2]
$91:E8C6 FC CC E8    JSR ($E8CC,x)[$91:E931];/

$91:E8C9 AB          PLB
$91:E8CA 28          PLP
$91:E8CB 6B          RTL

$91:E8CC             dw EFC3, E931, E8F2, E8D8, E8E5, EABE
}


;;; $E8D8: Set prospective Samus pose according to solid vertical collision result - unused ;;;
{
; Set pose for unwritten Samus movement
; Clone of $E8E5
$91:E8D8 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E8DB 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:E8DE A9 05 00    LDA #$0005             ;\
$91:E8E1 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = solid vertical collision
$91:E8E4 60          RTS
}


;;; $E8E5: Set prospective Samus pose according to solid vertical collision result - hit ceiling ;;;
{
; Set pose for Samus upward movement after collision with block or solid enemy
$91:E8E5 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E8E8 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:E8EB A9 05 00    LDA #$0005             ;\
$91:E8EE 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = solid vertical collision
$91:E8F1 60          RTS
}


;;; $E8F2: Set prospective Samus pose according to solid vertical collision result - falling ;;;
{
$91:E8F2 AD C7 0D    LDA $0DC7  [$7E:0DC7]  ;\
$91:E8F5 29 FF 00    AND #$00FF             ;|
$91:E8F8 C9 04 00    CMP #$0004             ;} If [Samus downwards movement solid collision result] = no change:
$91:E8FB D0 01       BNE $01    [$E8FE]     ;/
$91:E8FD 60          RTS                    ; Return

$91:E8FE 0A          ASL A                  ;\
$91:E8FF 0A          ASL A                  ;} X = [Samus downwards movement solid collision result] * 4
$91:E900 AA          TAX                    ;/
$91:E901 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E904 29 FF 00    AND #$00FF             ;|
$91:E907 C9 04 00    CMP #$0004             ;} If facing right:
$91:E90A F0 08       BEQ $08    [$E914]     ;/
$91:E90C BD 21 E9    LDA $E921,x[$91:E921]  ;\
$91:E90F 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [$E921 + [X]]
$91:E912 80 06       BRA $06    [$E91A]

$91:E914 BD 23 E9    LDA $E923,x[$91:E923]  ;\ Else (facing left):
$91:E917 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [$E921 + [X] + 2]

$91:E91A A9 05 00    LDA #$0005             ;\
$91:E91D 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = solid vertical collision
$91:E920 60          RTS

;                        ________ Facing right
;                       |     ___ Facing left
;                       |    |
$91:E921             dw 0029,002A, ; Falling
                        0031,0032, ; Morph ball - no spring ball - in air
                        0033,0034, ; Unused
                        007D,007E  ; Morph ball - spring ball - falling
}


;;; $E931: Set prospective Samus pose according to solid vertical collision result - landed ;;;
{
$91:E931 AD C7 0D    LDA $0DC7  [$7E:0DC7]  ;\
$91:E934 29 FF 00    AND #$00FF             ;|
$91:E937 C9 04 00    CMP #$0004             ;} If [Samus downwards movement solid collision result] = no change: return
$91:E93A F0 14       BEQ $14    [$E950]     ;/
$91:E93C 0A          ASL A                  ;\
$91:E93D AA          TAX                    ;} Execute [$E951 + [Samus downwards movement solid collision result] * 2]
$91:E93E FC 51 E9    JSR ($E951,x)[$91:E95D];/
$91:E941 90 07       BCC $07    [$E94A]     ; If carry set:
$91:E943 A9 00 00    LDA #$0000             ;\
$91:E946 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = none
$91:E949 60          RTS                    ; Return

$91:E94A A9 05 00    LDA #$0005             ;\
$91:E94D 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = solid vertical collision

$91:E950 60          RTS

$91:E951             dw E95D, EA07, EA48, EA63, EFC3, EAB6
}


;;; $E95D: Set prospective Samus pose according to solid vertical collision result - landed - grounded ;;;
{
;; Returns:
;;     Carry: clear
$91:E95D AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:E960 29 FF 00    AND #$00FF             ;|
$91:E963 C9 03 00    CMP #$0003             ;} If [Samus previous movement type] = spin jumping: go to BRANCH_WAS_SPINNING
$91:E966 F0 70       BEQ $70    [$E9D8]     ;/
$91:E968 C9 14 00    CMP #$0014             ;\
$91:E96B F0 6B       BEQ $6B    [$E9D8]     ;} If [Samus previous movement type] = wall jumping: go to BRANCH_WAS_SPINNING
$91:E96D AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:E970 0A          ASL A                  ;|
$91:E971 0A          ASL A                  ;|
$91:E972 0A          ASL A                  ;} A = (pose direction shots are fired)
$91:E973 AA          TAX                    ;|
$91:E974 BD 2C B6    LDA $B62C,x[$91:B77C]  ;|
$91:E977 29 FF 00    AND #$00FF             ;/
$91:E97A C9 FF 00    CMP #$00FF             ;\
$91:E97D F0 3E       BEQ $3E    [$E9BD]     ;} If [A] = FFh: go to BRANCH_NO_AIM
$91:E97F C9 02 00    CMP #$0002             ;\
$91:E982 F0 17       BEQ $17    [$E99B]     ;} If [A] = right: go to BRANCH_AIM_HORIZONTAL
$91:E984 C9 07 00    CMP #$0007             ;\
$91:E987 F0 12       BEQ $12    [$E99B]     ;} If [A] = left: go to BRANCH_AIM_HORIZONTAL

; BRANCH_LANDING_FROM_NORMAL_JUMP_NO_FIRE
$91:E989 0A          ASL A                  ;\
$91:E98A AA          TAX                    ;|
$91:E98B BD F3 E9    LDA $E9F3,x[$91:EA01]  ;} Prospective pose = [$E9F3 + [A] * 2]
$91:E98E 8D 28 0A    STA $0A28  [$7E:0A28]  ;/
$91:E991 18          CLC                    ;\
$91:E992 60          RTS                    ;} Return carry clear

; BRANCH_LANDING_FROM_NORMAL_JUMP_NO_SHOOT
$91:E993 BD 2C B6    LDA $B62C,x[$91:B77C]  ;\
$91:E996 29 FF 00    AND #$00FF             ;} A = (pose direction shots are fired)
$91:E999 80 EE       BRA $EE    [$E989]     ; Go to BRANCH_LANDING_FROM_NORMAL_JUMP_NO_FIRE

; BRANCH_AIM_HORIZONTAL
$91:E99B A5 8B       LDA $8B    [$7E:008B]  ;\
$91:E99D 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If not pressing shoot: go to BRANCH_LANDING_FROM_NORMAL_JUMP_NO_SHOOT
$91:E9A0 F0 F1       BEQ $F1    [$E993]     ;/
$91:E9A2 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E9A5 29 FF 00    AND #$00FF             ;|
$91:E9A8 C9 04 00    CMP #$0004             ;} If facing right:
$91:E9AB F0 08       BEQ $08    [$E9B5]     ;/
$91:E9AD A9 E6 00    LDA #$00E6             ;\
$91:E9B0 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing right - landing from normal jump - firing
$91:E9B3 18          CLC                    ;\
$91:E9B4 60          RTS                    ;} Return carry clear

$91:E9B5 A9 E7 00    LDA #$00E7             ;\
$91:E9B8 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing left - landing from normal jump - firing
$91:E9BB 18          CLC                    ;\
$91:E9BC 60          RTS                    ;} Return carry clear

; BRANCH_NO_AIM
$91:E9BD AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E9C0 29 FF 00    AND #$00FF             ;|
$91:E9C3 C9 04 00    CMP #$0004             ;} If facing right:
$91:E9C6 F0 08       BEQ $08    [$E9D0]     ;/
$91:E9C8 A9 A4 00    LDA #$00A4             ;\
$91:E9CB 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing right - landing from normal jump
$91:E9CE 18          CLC                    ;\
$91:E9CF 60          RTS                    ;} Return carry clear

$91:E9D0 A9 A5 00    LDA #$00A5             ;\
$91:E9D3 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing left - landing from normal jump
$91:E9D6 18          CLC                    ;\
$91:E9D7 60          RTS                    ;} Return carry clear

; BRANCH_WAS_SPINNING
$91:E9D8 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:E9DB 29 FF 00    AND #$00FF             ;|
$91:E9DE C9 04 00    CMP #$0004             ;} If facing right:
$91:E9E1 F0 08       BEQ $08    [$E9EB]     ;/
$91:E9E3 A9 A6 00    LDA #$00A6             ;\
$91:E9E6 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing right - landing from spin jump
$91:E9E9 18          CLC                    ;\
$91:E9EA 60          RTS                    ;} Return carry clear

$91:E9EB A9 A7 00    LDA #$00A7             ;\
$91:E9EE 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing left - landing from spin jump
$91:E9F1 18          CLC                    ;\
$91:E9F2 60          RTS                    ;} Return carry clear

$91:E9F3             dw 00E0, ; 0: Up, facing right:   Facing right - landing from normal jump - aiming up
                        00E2, ; 1: Up-right:           Facing right - landing from normal jump - aiming up-right
                        00A4, ; 2: Right:              Facing right - landing from normal jump
                        00E4, ; 3: Down-right:         Facing right - landing from normal jump - aiming down-right
                        00A4, ; 4: Down, facing right: Facing right - landing from normal jump
                        00A5, ; 5: Down, facing left:  Facing left  - landing from normal jump
                        00E5, ; 6: Down-left:          Facing left  - landing from normal jump - aiming down-left
                        00A5, ; 7: Left:               Facing left  - landing from normal jump
                        00E3, ; 8: Up-left:            Facing left  - landing from normal jump - aiming up-left
                        00E1  ; 9: Up, facing left:    Facing left  - landing from normal jump - aiming up
}


;;; $EA07: Set prospective Samus pose according to solid vertical collision result - landed - morph ball grounded ;;;
{
;; Returns:
;;     Carry: clear

; TODO: talk about how dequipping spring ball during bounce causes jump table overflow here due to [$0B20] >= 600h
;       need to check other places like $F1FC too
$91:EA07 AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$91:EA0A 0A          ASL A                  ;|
$91:EA0B AA          TAX                    ;} Go to [$EA0F + [morph ball bounce state] * 2]
$91:EA0C 7C 0F EA    JMP ($EA0F,x)[$91:EA15];/

$91:EA0F             dw EA15, EA25, EA2D
}


;;; $EA15: Set prospective Samus pose according to solid vertical collision result - landed - morph ball grounded - not bouncing ;;;
{
$91:EA15 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:EA18 C9 03 00    CMP #$0003             ;} If [Samus Y speed] < 3: go to second bounce
$91:EA1B 30 10       BMI $10    [$EA2D]     ;/
$91:EA1D AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EA20 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:EA23 18          CLC                    ;\
$91:EA24 60          RTS                    ;} Return carry clear
}


;;; $EA25: Set prospective Samus pose according to solid vertical collision result - landed - morph ball grounded - first bounce ;;;
{
$91:EA25 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EA28 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:EA2B 18          CLC                    ;\
$91:EA2C 60          RTS                    ;} Return carry clear
}


;;; $EA2D: Set prospective Samus pose according to solid vertical collision result - landed - morph ball grounded - second bounce ;;;
{
$91:EA2D AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EA30 29 FF 00    AND #$00FF             ;|
$91:EA33 C9 04 00    CMP #$0004             ;} If facing right:
$91:EA36 F0 08       BEQ $08    [$EA40]     ;/
$91:EA38 A9 1D 00    LDA #$001D             ;\
$91:EA3B 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing right - morph ball - no springball - on ground
$91:EA3E 80 06       BRA $06    [$EA46]

$91:EA40 A9 41 00    LDA #$0041             ;\ Else (facing left):
$91:EA43 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing left  - morph ball - no springball - on ground

$91:EA46 18          CLC                    ;\
$91:EA47 60          RTS                    ;} Return carry clear
}


;;; $EA48: Set prospective Samus pose according to solid vertical collision result - landed - unused ;;;
{
$91:EA48 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EA4B 29 FF 00    AND #$00FF             ;|
$91:EA4E C9 04 00    CMP #$0004             ;} If facing right:
$91:EA51 F0 08       BEQ $08    [$EA5B]     ;/
$91:EA53 A9 20 00    LDA #$0020             ;\
$91:EA56 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = 20h (unused)
$91:EA59 80 06       BRA $06    [$EA61]

$91:EA5B A9 42 00    LDA #$0042             ;\ Else (facing left):
$91:EA5E 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = 42h (unused)

$91:EA61 18          CLC                    ;\
$91:EA62 60          RTS                    ;} Return carry clear
}


;;; $EA63: Set prospective Samus pose according to solid vertical collision result - landed - spring ball grounded ;;;
{
;; Returns:
;;     Carry: clear

$91:EA63 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:EA65 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If pressing jump:
$91:EA68 F0 08       BEQ $08    [$EA72]     ;/
$91:EA6A AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EA6D 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:EA70 18          CLC                    ;\
$91:EA71 60          RTS                    ;} Return carry clear

$91:EA72 AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$91:EA75 29 FF 00    AND #$00FF             ;|
$91:EA78 0A          ASL A                  ;} Go to [$EA0F + ([morph ball bounce state] & FFh) * 2]
$91:EA79 AA          TAX                    ;|
$91:EA7A 7C 7D EA    JMP ($EA7D,x)[$91:EA83];/

$91:EA7D             dw EA83, EA93, EA9B
}


;;; $EA83: Set prospective Samus pose according to solid vertical collision result - landed - spring ball grounded - not bouncing ;;;
{
$91:EA83 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:EA86 C9 03 00    CMP #$0003             ;} If [Samus Y speed] < 3: go to second bounce
$91:EA89 30 10       BMI $10    [$EA9B]     ;/
$91:EA8B AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EA8E 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:EA91 18          CLC                    ;\
$91:EA92 60          RTS                    ;} Return carry clear
}


;;; $EA93: Set prospective Samus pose according to solid vertical collision result - landed - spring ball grounded - first bounce ;;;
{
$91:EA93 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EA96 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:EA99 18          CLC                    ;\
$91:EA9A 60          RTS                    ;} Return carry clear
}


;;; $EA9B: Set prospective Samus pose according to solid vertical collision result - landed - spring ball grounded - second bounce ;;;
{
$91:EA9B AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EA9E 29 FF 00    AND #$00FF             ;|
$91:EAA1 C9 04 00    CMP #$0004             ;} If facing right:
$91:EAA4 F0 08       BEQ $08    [$EAAE]     ;/
$91:EAA6 A9 79 00    LDA #$0079             ;\
$91:EAA9 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing right - morph ball - spring ball - on ground
$91:EAAC 80 06       BRA $06    [$EAB4]

$91:EAAE A9 7A 00    LDA #$007A             ;\ Else (facing left):
$91:EAB1 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing left  - morph ball - spring ball - on ground

$91:EAB4 18          CLC                    ;\
$91:EAB5 60          RTS                    ;} Return carry clear
}


;;; $EAB6: Set prospective Samus pose according to solid vertical collision result - landed - [$0DC7] = 5 ;;;
{
; AFAIK, $0DC7 is never 5
$91:EAB6 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EAB9 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = [Samus pose]
$91:EABC 18          CLC                    ;\
$91:EABD 60          RTS                    ;} Return carry clear
}


;;; $EABE: Set prospective Samus pose according to solid vertical collision result - wall jump triggered ;;;
{
$91:EABE AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EAC1 29 FF 00    AND #$00FF             ;|
$91:EAC4 C9 04 00    CMP #$0004             ;} If facing right:
$91:EAC7 F0 08       BEQ $08    [$EAD1]     ;/
$91:EAC9 A9 83 00    LDA #$0083             ;\
$91:EACC 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing right - wall jump
$91:EACF 80 06       BRA $06    [$EAD7]

$91:EAD1 A9 84 00    LDA #$0084             ;\ Else (facing left):
$91:EAD4 8D 28 0A    STA $0A28  [$7E:0A28]  ;} Prospective pose = facing left - wall jump

$91:EAD7 A9 05 00    LDA #$0005             ;\
$91:EADA 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = solid vertical collision
$91:EADD 60          RTS
}
}


;;; $EADE: Check if prospective pose runs into a wall ;;;
{
; Check if Samus ran into a wall this frame, set the prospective pose to ran into a wall with the corresponding arm cannon aim
; Otherwise, if prospective pose is running:
;     Check if Samus can move one pixel horizontally forward,
;     if she would collide with a solid enemy, set the prospective pose to ran into a wall with the corresponding arm cannon aim
;     Otherwise, *move* Samus one pixel horizontally forward,
;     if she collided with a solid block, set the prospective pose to ran into a wall with the corresponding arm cannon aim
; Returned carry is ignored by caller

; This code is responsible for the arm pump bug
; If Samus pose changes from a running pose to another running pose (changing arm cannon aim),
; Samus is moved one pixel horizontally forwards,
; the fact that it's pure horizontal movement causes Samus to sometimes lose contact with downwards slopes

$91:EADE AD CE 0D    LDA $0DCE  [$7E:0DCE]  ;\
$91:EAE1 F0 0B       BEQ $0B    [$EAEE]     ;} If Samus X speed killed due to solid collision:
$91:EAE3 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:EAE6 29 FF 00    AND #$00FF             ;|
$91:EAE9 C9 01 00    CMP #$0001             ;} If [Samus movement type] = running: go to BRANCH_RAN_INTO_WALL
$91:EAEC F0 65       BEQ $65    [$EB53]     ;/

$91:EAEE AD 28 0A    LDA $0A28  [$7E:0A28]  ;\
$91:EAF1 C9 FF FF    CMP #$FFFF             ;} If [prospective pose] = FFFFh: go to BRANCH_RETURN_POSE_UNCHANGED
$91:EAF4 F0 74       BEQ $74    [$EB6A]     ;/
$91:EAF6 0A          ASL A                  ;\
$91:EAF7 0A          ASL A                  ;|
$91:EAF8 0A          ASL A                  ;|
$91:EAF9 AA          TAX                    ;|
$91:EAFA BD 2A B6    LDA $B62A,x[$91:B63A]  ;} If (pose [prospective pose] movement type) != running: go to BRANCH_RETURN_POSE_UNCHANGED
$91:EAFD 29 FF 00    AND #$00FF             ;|
$91:EB00 C9 01 00    CMP #$0001             ;|
$91:EB03 D0 65       BNE $65    [$EB6A]     ;/
$91:EB05 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EB08 29 FF 00    AND #$00FF             ;|
$91:EB0B C9 04 00    CMP #$0004             ;} If facing right:
$91:EB0E F0 1D       BEQ $1D    [$EB2D]     ;/
$91:EB10 A9 01 00    LDA #$0001             ;\
$91:EB13 85 12       STA $12    [$7E:0012]  ;|
$91:EB15 8D 02 0B    STA $0B02  [$7E:0B02]  ;} $12.$14 = 1.0, collision direction = right
$91:EB18 64 14       STZ $14    [$7E:0014]  ;/
$91:EB1A 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$91:EB1E AA          TAX                    ;\
$91:EB1F D0 2D       BNE $2D    [$EB4E]     ;} If collision detected: go to BRANCH_PROSPECTIVE_POSE_RAN_INTO_WALL
$91:EB21 A9 01 00    LDA #$0001             ;\
$91:EB24 85 12       STA $12    [$7E:0012]  ;|
$91:EB26 8D 02 0B    STA $0B02  [$7E:0B02]  ;} $12.$14 = 1.0, collision direction = right
$91:EB29 64 14       STZ $14    [$7E:0014]  ;/
$91:EB2B 80 1B       BRA $1B    [$EB48]

$91:EB2D A9 01 00    LDA #$0001             ;\ Else (facing left):
$91:EB30 85 12       STA $12    [$7E:0012]  ;} $12.$14 = 1.0
$91:EB32 64 14       STZ $14    [$7E:0014]  ;/
$91:EB34 9C 02 0B    STZ $0B02  [$7E:0B02]  ; Collision direction = left
$91:EB37 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$91:EB3B AA          TAX                    ;\
$91:EB3C D0 10       BNE $10    [$EB4E]     ;} If collision detected: go to BRANCH_PROSPECTIVE_POSE_RAN_INTO_WALL
$91:EB3E A9 FF FF    LDA #$FFFF             ;\
$91:EB41 85 12       STA $12    [$7E:0012]  ;|
$91:EB43 64 14       STZ $14    [$7E:0014]  ;} $12.$14 = -1.0, collision direction = right
$91:EB45 9C 02 0B    STZ $0B02  [$7E:0B02]  ;/

$91:EB48 22 1E 97 94 JSL $94971E[$94:971E]  ; Move Samus right by [$12].[$14], no solid enemy collision
$91:EB4C 90 1C       BCC $1C    [$EB6A]     ; If no collision: go to BRANCH_RETURN_POSE_UNCHANGED

; BRANCH_PROSPECTIVE_POSE_RAN_INTO_WALL
$91:EB4E AD 28 0A    LDA $0A28  [$7E:0A28]  ; A = [prospective pose]
$91:EB51 80 03       BRA $03    [$EB56]     ; Go to BRANCH_SET_RAN_INTO_WALL_POSE

; BRANCH_RAN_INTO_WALL
$91:EB53 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ; A = [Samus pose]

; BRANCH_SET_RAN_INTO_WALL_POSE
$91:EB56 0A          ASL A                  ;\
$91:EB57 0A          ASL A                  ;|
$91:EB58 0A          ASL A                  ;|
$91:EB59 AA          TAX                    ;|
$91:EB5A BD 2C B6    LDA $B62C,x[$91:B674]  ;|
$91:EB5D 29 FF 00    AND #$00FF             ;} Prospective pose = [$EB74 + (pose [A] direction shots are fired) * 2]
$91:EB60 0A          ASL A                  ;|
$91:EB61 AA          TAX                    ;|
$91:EB62 BD 74 EB    LDA $EB74,x[$91:EB78]  ;|
$91:EB65 8D 28 0A    STA $0A28  [$7E:0A28]  ;/
$91:EB68 80 05       BRA $05    [$EB6F]     ; Go to BRANCH_RETURN_POSE_CHANGED

; BRANCH_RETURN_POSE_UNCHANGED
$91:EB6A 9C CE 0D    STZ $0DCE  [$7E:0DCE]  ; Samus X speed killed due to solid collision flag = 0
$91:EB6D 18          CLC                    ;\
$91:EB6E 60          RTS                    ;} Return carry clear

; BRANCH_RETURN_POSE_CHANGED
$91:EB6F 9C CE 0D    STZ $0DCE  [$7E:0DCE]  ; Samus X speed killed due to solid collision flag = 0
$91:EB72 38          SEC                    ;\
$91:EB73 60          RTS                    ;} Return carry set

$91:EB74             dw 0003, ; 0: Up, facing right:   Facing right - aiming up
                        00CF, ; 1: Up-right:           Facing right - ran into a wall - aiming up-right
                        0089, ; 2: Right:              Facing right - ran into a wall
                        00D1, ; 3: Down-right:         Facing right - ran into a wall - aiming down-right
                        0089, ; 4: Down, facing right: Facing right - ran into a wall
                        008A, ; 5: Down, facing left:  Facing left  - ran into a wall
                        00D2, ; 6: Down-left:          Facing left  - ran into a wall - aiming down-left
                        008A, ; 7: Left:               Facing left  - ran into a wall
                        00D0, ; 8: Up-left:            Facing left  - ran into a wall - aiming up-left
                        0004  ; 9: Up, facing left:    Facing left  - aiming up
}


;;; $EB88: Update Samus pose ;;;
{
; See also "Samus.asm"
$91:EB88 08          PHP
$91:EB89 8B          PHB
$91:EB8A 4B          PHK                    ;\
$91:EB8B AB          PLB                    ;} DB = $91
$91:EB8C C2 30       REP #$30
$91:EB8E AD 2C 0A    LDA $0A2C  [$7E:0A2C]  ;\
$91:EB91 30 32       BMI $32    [$EBC5]     ;} If [super special prospective pose] & 8000h != 0: go to BRANCH_NOT_SUPER_SPECIAL_PROSPECTIVE_POSE
$91:EB93 48          PHA
$91:EB94 AD 32 0A    LDA $0A32  [$7E:0A32]  ;\
$91:EB97 C9 03 00    CMP #$0003             ;} If [super special prospective pose change command] = transition animation finished: go to BRANCH_ANIMATION_FINISHED
$91:EB9A F0 08       BEQ $08    [$EBA4]     ;/
$91:EB9C C9 01 00    CMP #$0001             ;\
$91:EB9F D0 0E       BNE $0E    [$EBAF]     ;} If [super special prospective pose change command] != knockback finished: go to BRANCH_SUPER_SPECIAL_PROSPECTIVE_POSE
$91:EBA1 68          PLA
$91:EBA2 80 17       BRA $17    [$EBBB]     ; Go to BRANCH_KNOCKBACK_FINISHED

; BRANCH_ANIMATION_FINISHED
$91:EBA4 AD 30 0A    LDA $0A30  [$7E:0A30]  ;\
$91:EBA7 C9 09 00    CMP #$0009             ;} If [special prospective pose change command] = connecting grapple - swinging:
$91:EBAA D0 03       BNE $03    [$EBAF]     ;/
$91:EBAC 68          PLA
$91:EBAD 80 16       BRA $16    [$EBC5]     ; Go to BRANCH_NOT_SUPER_SPECIAL_PROSPECTIVE_POSE

; BRANCH_SUPER_SPECIAL_PROSPECTIVE_POSE
$91:EBAF 68          PLA
$91:EBB0 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ; Samus pose = [super special prospective pose]
$91:EBB3 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:EBB7 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed

; BRANCH_KNOCKBACK_FINISHED
$91:EBBB AD 32 0A    LDA $0A32  [$7E:0A32]  ;\
$91:EBBE 0A          ASL A                  ;|
$91:EBBF AA          TAX                    ;} Execute [$EC3E + [super special prospective pose change command]]
$91:EBC0 FC 3E EC    JSR ($EC3E,x)[$91:F31D];/
$91:EBC3 80 33       BRA $33    [$EBF8]     ; Go to BRANCH_POSE_CHANGED

; BRANCH_NOT_SUPER_SPECIAL_PROSPECTIVE_POSE
$91:EBC5 AD 2A 0A    LDA $0A2A  [$7E:0A2A]  ;\
$91:EBC8 10 0A       BPL $0A    [$EBD4]     ;} If [special prospective pose] & 8000h = 0: go to BRANCH_SPECIAL_PROSPECTIVE_POSE
$91:EBCA 20 DE EA    JSR $EADE  [$91:EADE]  ; Check if prospective pose runs into a wall
$91:EBCD AD 28 0A    LDA $0A28  [$7E:0A28]  ;\
$91:EBD0 30 3E       BMI $3E    [$EC10]     ;} If [prospective pose] & 8000h != 0: go to BRANCH_RETURN
$91:EBD2 80 13       BRA $13    [$EBE7]     ; Go to BRANCH_PROSPECTIVE_POSE

; BRANCH_SPECIAL_PROSPECTIVE_POSE
$91:EBD4 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ; Samus pose = [special prospective pose]
$91:EBD7 22 04 F4 91 JSL $91F404[$91:F404]  ; Handle Samus pose change
$91:EBDB B0 1B       BCS $1B    [$EBF8]     ; If carry set: go to BRANCH_POSE_CHANGED
$91:EBDD AD 30 0A    LDA $0A30  [$7E:0A30]  ;\
$91:EBE0 0A          ASL A                  ;|
$91:EBE1 AA          TAX                    ;} Execute [$EC28 + [special prospective pose change command] * 2]
$91:EBE2 FC 28 EC    JSR ($EC28,x)[$91:ED4E];/
$91:EBE5 80 11       BRA $11    [$EBF8]     ; Go to BRANCH_POSE_CHANGED

; BRANCH_PROSPECTIVE_POSE
$91:EBE7 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ; Samus pose = [prospective pose]
$91:EBEA 22 04 F4 91 JSL $91F404[$91:F404]  ; Handle Samus pose change
$91:EBEE B0 08       BCS $08    [$EBF8]     ; If carry set: go to BRANCH_POSE_CHANGED
$91:EBF0 AD 2E 0A    LDA $0A2E  [$7E:0A2E]  ;\
$91:EBF3 0A          ASL A                  ;|
$91:EBF4 AA          TAX                    ;} Execute [$EC16 + [prospective pose change command] * 2]
$91:EBF5 FC 16 EC    JSR ($EC16,x)[$91:ECD0];/

; BRANCH_POSE_CHANGED
$91:EBF8 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:EBFB 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:EBFE AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:EC01 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:EC04 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:EC07 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:EC0A AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EC0D 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]

; BRANCH_RETURN
$91:EC10 9C C6 0D    STZ $0DC6  [$7E:0DC6]  ; Samus solid vertical collision result = no change
$91:EC13 AB          PLB
$91:EC14 28          PLP
$91:EC15 6B          RTL

; Prospective pose change command function pointers
$91:EC16             dw EFC3, EC50, ECD0, ECD8, ECD9, EFC4, EC85, ECDA, EC8E

; Special prospective pose change command function pointers
$91:EC28             dw EFC3, ED4E, EE69, EE80, EEA1, EEA6, EF39, EF3A, EF3B, EF4F, EFBC

; Super special prospective pose change command function pointers
$91:EC3E             dw EFC3, F31D, F34E, F36E, F37C, F397, F3A5, F3AA, F3FD
}


;;; $EC50..ED4D: Prospective pose change commands ;;;
{
;;; $EC50: Prospective pose change command 1 - decelerate ;;;
{
; Running / normal jumping / morph ball in air and [Samus X base speed] != 0.0
; Samus X base speed *can* be 0.0 coming into this function
$91:EC50 AD 46 0B    LDA $0B46  [$7E:0B46]  ;\
$91:EC53 D0 08       BNE $08    [$EC5D]     ;|
$91:EC55 AD 48 0B    LDA $0B48  [$7E:0B48]  ;} If [Samus X base speed] = 0.0:
$91:EC58 D0 03       BNE $03    [$EC5D]     ;/
$91:EC5A 4C D0 EC    JMP $ECD0  [$91:ECD0]  ; Go to prospective pose change command 2 - stop

$91:EC5D AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$91:EC60 18          CLC                    ;|
$91:EC61 6D 48 0B    ADC $0B48  [$7E:0B48]  ;|
$91:EC64 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [Samus X extra run speed]
$91:EC67 AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$91:EC6A 6D 46 0B    ADC $0B46  [$7E:0B46]  ;|
$91:EC6D 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$91:EC70 A9 02 00    LDA #$0002             ;\
$91:EC73 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating
$91:EC76 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:EC7A 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:EC7D 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:EC80 22 8E FB 91 JSL $91FB8E[$91:FB8E]  ; Execute $91:FB8E
$91:EC84 60          RTS
}


;;; $EC85: Prospective pose change command 6 - kill X speed ;;;
{
; Morph ball on ground / spring ball / wall jumping / grappling
$91:EC85 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:EC88 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:EC8B 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
}


;;; $EC8E: Prospective pose change command 8 - kill run speed ;;;
{
; Falling
$91:EC8E 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:EC92 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:EC95 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:EC98 22 8E FB 91 JSL $91FB8E[$91:FB8E]  ; Execute $91:FB8E
$91:EC9C 60          RTS
}


;;; $EC9D: Unused ;;;
{
$91:EC9D AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:ECA0 29 FF 00    AND #$00FF             ;|
$91:ECA3 AA          TAX                    ;|
$91:ECA4 BD B4 EC    LDA $ECB4,x            ;} If [Samus movement type] != normal jumping or damage boost:
$91:ECA7 29 FF 00    AND #$00FF             ;|
$91:ECAA D0 01       BNE $01    [$ECAD]     ;/
$91:ECAC 60          RTS                    ; Return

$91:ECAD A9 04 00    LDA #$0004             ;\
$91:ECB0 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 4
$91:ECB3 60          RTS

$91:ECB4             db 00, 00, 02, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00, 00,
                        00, 00, 00, 00, 00, 00, 00, 00, 00, 02, 00, 00
}


;;; $ECD0: Prospective pose change command 2 - stop ;;;
{
; Default: not running / jumping / wall jumping / falling / morph ball / spring ball / grappling
; or running / normal jumping / morph ball in air and [Samus X momentum] = 0.0
$91:ECD0 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:ECD3 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:ECD7 60          RTS
}


;;; $ECD8: RTS. Prospective pose change command 3 - unused ;;;
{
$91:ECD8 60          RTS
}


;;; $ECD9: RTS. Prospective pose change command 4 - unused ;;;
{
$91:ECD9 60          RTS
}


;;; $ECDA: Prospective pose change command 7 - start transition animation ;;;
{
; Run during start of transition animations.
; Corrects Samus height so crouching/morphing ends on ground instead of in the air
; Doesn't kill Samus' X speed or cancel speed boosting
$91:ECDA AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:ECDD C9 DB 00    CMP #$00DB             ;} If [Samus pose] >= DBh: go to BRANCH_AIMING
$91:ECE0 10 41       BPL $41    [$ED23]     ;/
$91:ECE2 38          SEC                    ;\
$91:ECE3 E9 35 00    SBC #$0035             ;|
$91:ECE6 0A          ASL A                  ;|
$91:ECE7 AA          TAX                    ;} $12 = [$ED36 + ([Samus pose] - 35h) * 2] (distance to check for collision)
$91:ECE8 BD 36 ED    LDA $ED36,x[$91:ED36]  ;|
$91:ECEB 85 12       STA $12    [$7E:0012]  ;/
$91:ECED F0 16       BEQ $16    [$ED05]     ; If [$12] = 0: go to BRANCH_NOT_SHRINKING
$91:ECEF 64 14       STZ $14    [$7E:0014]  ; $14 = 0

; BRANCH_SHRINKING
$91:ECF1 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:ECF4 0A          ASL A                  ;|
$91:ECF5 0A          ASL A                  ;|
$91:ECF6 0A          ASL A                  ;|
$91:ECF7 AA          TAX                    ;} Samus Y radius = [$B62F + [Samus pose] * 8]
$91:ECF8 BD 2F B6    LDA $B62F,x[$91:B7D7]  ;|
$91:ECFB 29 FF 00    AND #$00FF             ;|
$91:ECFE 8D 00 0B    STA $0B00  [$7E:0B00]  ;/
$91:ED01 22 AB 96 94 JSL $9496AB[$94:96AB]  ; Block collision detection due to change of pose

; BRANCH_NOT_SHRINKING
$91:ED05 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:ED08 18          CLC                    ;|
$91:ED09 65 12       ADC $12    [$7E:0012]  ;} Samus Y position += [$12]
$91:ED0B 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:ED0E 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:ED11 AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$91:ED14 F0 0C       BEQ $0C    [$ED22]     ;} If [morph ball bounce state] != not bouncing:
$91:ED16 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:ED19 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:ED1C 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:ED1F 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none

$91:ED22 60          RTS                    ; Return

; BRANCH_AIMING
$91:ED23 C9 F1 00    CMP #$00F1             ;\
$91:ED26 30 FA       BMI $FA    [$ED22]     ;|
$91:ED28 C9 F7 00    CMP #$00F7             ;} If not F1h <= [Samus pose] < F7h (crouching transition - aiming): return
$91:ED2B 10 F5       BPL $F5    [$ED22]     ;/
$91:ED2D A9 05 00    LDA #$0005             ;\
$91:ED30 85 12       STA $12    [$7E:0012]  ;} $12 = 5 (distance to check for collision)
$91:ED32 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:ED34 80 BB       BRA $BB    [$ECF1]     ; Go to BRANCH_SHRINKING

$91:ED36             dw 0005, ; *35h: Facing right - crouching transition
                        0005, ; *36h: Facing left  - crouching transition
                        0009, ; *37h: Facing right - morphing transition
                        0009, ; *38h: Facing left  - morphing transition
                        0000, ;  39h: Unused
                        0000, ;  3Ah: Unused
                        0000, ;  3Bh: Facing right - standing transition
                        0000, ;  3Ch: Facing left  - standing transition
                        0000, ;  3Dh: Facing right - unmorphing transition
                        0000, ;  3Eh: Facing left  - unmorphing transition
                        0000, ;  3Fh: Unused
                        0000  ;  40h: Unused
}
}


;;; $ED4E..EFC2: Special prospective pose change commands ;;;
{
;;; $ED4E: Special prospective pose change command 1 - start knockback ;;;
{
$91:ED4E AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:ED51 29 FF 00    AND #$00FF             ;|
$91:ED54 0A          ASL A                  ;} Execute [$ED6A + [Samus previous movement type] * 2]
$91:ED55 AA          TAX                    ;|
$91:ED56 FC 6A ED    JSR ($ED6A,x)[$91:EDB0];/
$91:ED59 22 D6 99 90 JSL $9099D6[$90:99D6]  ; Set Samus Y speed for knockback
$91:ED5D 9C 56 0A    STZ $0A56  [$7E:0A56]  ; Bomb jump direction = none
$91:ED60 9C 6E 0A    STZ $0A6E  [$7E:0A6E]  ; Samus contact damage index = normal
$91:ED63 A9 01 00    LDA #$0001             ;\
$91:ED66 8D 48 0A    STA $0A48  [$7E:0A48]  ;} Samus hurt flash counter = 1
$91:ED69 60          RTS

$91:ED6A             dw EDB0, ; *0: Standing
                        EDB0, ; *1: Running
                        EDB0, ; *2: Normal jumping
                        EDB0, ; *3: Spin jumping
                        EE27, ; *4: Morph ball - on ground
                        EDB0, ; *5: Crouching
                        EDA6, ; *6: Falling
                        EE48, ; *7: Unused
                        EE27, ; *8: Morph ball - falling
                        EE27, ; *9: Unused
                        EDA2, ;  Ah: Knockback / crystal flash ending
                        EDA4, ;  Bh: Unused
                        EDA4, ;  Ch: Unused
                        EDB0, ; *Dh: Unused
                        EDA4, ;  Eh: Turning around - on ground
                        EDA4, ;  Fh: Crouching/standing/morphing/unmorphing transition
                        EDB0, ; *10h: Moonwalking
                        EE27, ; *11h: Spring ball - on ground
                        EE27, ; *12h: Spring ball - in air
                        EE27, ; *13h: Spring ball - falling
                        EDB0, ; *14h: Wall jumping
                        EDB0, ; *15h: Ran into a wall
                        EDA2, ;  16h: Grappling
                        EDA4, ;  17h: Turning around - jumping
                        EDA4, ;  18h: Turning around - falling
                        EDA4, ;  19h: Damage boost
                        EDA4, ;  1Ah: Grabbed by Draygon
                        EDA4  ;  1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $EDA2: Clear carry ;;;
{
$91:EDA2 18          CLC
$91:EDA3 60          RTS
}


;;; $EDA4: Clear carry ;;;
{
$91:EDA4 18          CLC
$91:EDA5 60          RTS
}


;;; $EDA6: Determine knockback direction - falling ;;;
{
; Falling
$91:EDA6 AD 5A 0A    LDA $0A5A  [$7E:0A5A]  ;\
$91:EDA9 C9 1B E4    CMP #$E41B             ;} If [timer / Samus hack handler] = $E41B (unused special falling):
$91:EDAC D0 02       BNE $02    [$EDB0]     ;/
$91:EDAE 18          CLC
$91:EDAF 60          RTS                    ; Return
}


;;; $EDB0: Determine knockback direction - normal ;;;
{
; Standing / running / jumping / crouching / moonwalking / ran into a wall
; If [knockback X direction] = left  and not pressing forward: knockback direction = 1 (up left)
; If [knockback X direction] = right and not pressing forward: knockback direction = 2 (up right)
; If [knockback X direction] = left  and     pressing forward: knockback direction = 4 (down left)
; If [knockback X direction] = right and     pressing forward: knockback direction = 5 (down right)
$91:EDB0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EDB3 29 FF 00    AND #$00FF             ;|
$91:EDB6 C9 04 00    CMP #$0004             ;} If Samus is facing left: go to BRANCH_FACING_LEFT
$91:EDB9 F0 33       BEQ $33    [$EDEE]     ;/
$91:EDBB AD 54 0A    LDA $0A54  [$7E:0A54]  ;\
$91:EDBE F0 17       BEQ $17    [$EDD7]     ;} If [knockback X direction] = left: go to BRANCH_FACING_RIGHT_KNOCKBACK_LEFT
$91:EDC0 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:EDC2 89 00 01    BIT #$0100             ;} If not pressing right:
$91:EDC5 D0 08       BNE $08    [$EDCF]     ;/
$91:EDC7 A9 02 00    LDA #$0002             ;\
$91:EDCA 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up right
$91:EDCD 80 50       BRA $50    [$EE1F]

$91:EDCF A9 05 00    LDA #$0005             ;\ Else (pressing right):
$91:EDD2 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = down right
$91:EDD5 80 48       BRA $48    [$EE1F]

; BRANCH_FACING_RIGHT_KNOCKBACK_LEFT
$91:EDD7 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:EDD9 89 00 01    BIT #$0100             ;} If not pressing right:
$91:EDDC D0 08       BNE $08    [$EDE6]     ;/
$91:EDDE A9 01 00    LDA #$0001             ;\
$91:EDE1 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up left
$91:EDE4 80 39       BRA $39    [$EE1F]

$91:EDE6 A9 04 00    LDA #$0004             ;\ Else (pressing right):
$91:EDE9 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = down left
$91:EDEC 80 31       BRA $31    [$EE1F]

; BRANCH_FACING_LEFT
$91:EDEE AD 54 0A    LDA $0A54  [$7E:0A54]  ;\
$91:EDF1 F0 17       BEQ $17    [$EE0A]     ;} If [knockback X direction] = left: go to BRANCH_FACING_LEFT_KNOCKBACK_LEFT
$91:EDF3 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:EDF5 89 00 02    BIT #$0200             ;} If not pressing left:
$91:EDF8 D0 08       BNE $08    [$EE02]     ;/
$91:EDFA A9 02 00    LDA #$0002             ;\
$91:EDFD 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up right
$91:EE00 80 1D       BRA $1D    [$EE1F]

$91:EE02 A9 05 00    LDA #$0005             ;\ Else (pressing left):
$91:EE05 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = down right
$91:EE08 80 15       BRA $15    [$EE1F]

; BRANCH_FACING_LEFT_KNOCKBACK_LEFT
$91:EE0A A5 8B       LDA $8B    [$7E:008B]  ;\
$91:EE0C 89 00 02    BIT #$0200             ;} If not pressing left:
$91:EE0F D0 08       BNE $08    [$EE19]     ;/
$91:EE11 A9 01 00    LDA #$0001             ;\
$91:EE14 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up left
$91:EE17 80 06       BRA $06    [$EE1F]

$91:EE19 A9 04 00    LDA #$0004             ;\ Else (pressing left):
$91:EE1C 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = down left

$91:EE1F A9 38 DF    LDA #$DF38             ;\
$91:EE22 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $DF38 (knockback)
$91:EE25 38          SEC
$91:EE26 60          RTS
}


;;; $EE27: Determine knockback direction - morphed ;;;
{
; Morph ball / spring ball
$91:EE27 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EE2A 29 FF 00    AND #$00FF             ;|
$91:EE2D C9 04 00    CMP #$0004             ;} If facing right:
$91:EE30 F0 08       BEQ $08    [$EE3A]     ;/
$91:EE32 A9 02 00    LDA #$0002             ;\
$91:EE35 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up right
$91:EE38 80 06       BRA $06    [$EE40]

$91:EE3A A9 01 00    LDA #$0001             ;\ Else (facing left):
$91:EE3D 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up left

$91:EE40 A9 38 DF    LDA #$DF38             ;\
$91:EE43 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $DF38 (knockback)
$91:EE46 18          CLC
$91:EE47 60          RTS
}


;;; $EE48: Determine knockback direction - movement type 7 ;;;
{
; 7: Unused
; Clone of $EE27 except that the (ignored) carry return is set
$91:EE48 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EE4B 29 FF 00    AND #$00FF             ;|
$91:EE4E C9 04 00    CMP #$0004             ;} If facing right:
$91:EE51 F0 08       BEQ $08    [$EE5B]     ;/
$91:EE53 A9 02 00    LDA #$0002             ;\
$91:EE56 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up right
$91:EE59 80 06       BRA $06    [$EE61]

$91:EE5B A9 01 00    LDA #$0001             ;\ Else (facing left):
$91:EE5E 8D 52 0A    STA $0A52  [$7E:0A52]  ;} Knockback direction = up left

$91:EE61 A9 38 DF    LDA #$DF38             ;\
$91:EE64 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $DF38 (knockback)
$91:EE67 38          SEC
$91:EE68 60          RTS
}


;;; $EE69: Special prospective pose change command 2 - unused ;;;
{
$91:EE69 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = none
$91:EE6C A9 37 A3    LDA #$A337             ;\
$91:EE6F 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$91:EE72 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;\
$91:EE75 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;} Samus Y speed = 0.0
$91:EE78 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:EE7B 22 7E EC 90 JSL $90EC7E[$90:EC7E]  ; Align Samus bottom position with previous pose
$91:EE7F 60          RTS
}


;;; $EE80: Special prospective pose change command 3 - start bomb jump ;;;
{
$91:EE80 AD 56 0A    LDA $0A56  [$7E:0A56]  ;\
$91:EE83 29 FF 00    AND #$00FF             ;|
$91:EE86 09 00 08    ORA #$0800             ;} Bomb jump direction |= 800h
$91:EE89 8D 56 0A    STA $0A56  [$7E:0A56]  ;/
$91:EE8C A9 25 E0    LDA #$E025             ;\
$91:EE8F 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $E025 (bomb jump - start)
$91:EE92 AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$91:EE95 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$91:EE98 F0 06       BEQ $06    [$EEA0]     ;/
$91:EE9A A9 0E E9    LDA #$E90E             ;\
$91:EE9D 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS

$91:EEA0 60          RTS
}


;;; $EEA1: Special prospective pose change command 4 - unused ;;;
{
$91:EEA1 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump
$91:EEA5 60          RTS
}


;;; $EEA6: Special prospective pose change command 5 - x-ray ;;;
{
$91:EEA6 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:EEA9 29 FF 00    AND #$00FF             ;} If [Samus movement type] != standing:
$91:EEAC F0 10       BEQ $10    [$EEBE]     ;/
$91:EEAE C9 05 00    CMP #$0005             ;\
$91:EEB1 F0 26       BEQ $26    [$EED9]     ;} If [Samus movement type] = crouching: go to BRANCH_CROUCHING
$91:EEB3 C9 15 00    CMP #$0015             ;\
$91:EEB6 F0 06       BEQ $06    [$EEBE]     ;} If [Samus movement type] != ran into a wall:
$91:EEB8 C9 01 00    CMP #$0001             ;\
$91:EEBB F0 01       BEQ $01    [$EEBE]     ;} If [Samus movement type] != running(!):
$91:EEBD 60          RTS                    ; Return

$91:EEBE AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EEC1 29 FF 00    AND #$00FF             ;|
$91:EEC4 C9 04 00    CMP #$0004             ;} If Samus is facing right:
$91:EEC7 F0 08       BEQ $08    [$EED1]     ;/
$91:EEC9 A9 40 00    LDA #$0040             ;\
$91:EECC 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = 40h
$91:EECF 80 21       BRA $21    [$EEF2]     ; Go to BRANCH_MERGE

$91:EED1 A9 C0 00    LDA #$00C0             ;\
$91:EED4 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = C0h
$91:EED7 80 19       BRA $19    [$EEF2]     ; Go to BRANCH_MERGE

; BRANCH_CROUCHING
$91:EED9 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:EEDC 29 FF 00    AND #$00FF             ;|
$91:EEDF C9 04 00    CMP #$0004             ;} If Samus is facing right:
$91:EEE2 F0 08       BEQ $08    [$EEEC]     ;/
$91:EEE4 A9 40 00    LDA #$0040             ;\
$91:EEE7 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = 40h
$91:EEEA 80 06       BRA $06    [$EEF2]     ; Go to BRANCH_MERGE

$91:EEEC A9 C0 00    LDA #$00C0             ;\
$91:EEEF 8D 82 0A    STA $0A82  [$7E:0A82]  ;} X-ray angle = C0h

; BRANCH_MERGE
$91:EEF2 A9 02 00    LDA #$0002             ;\
$91:EEF5 8D 96 0A    STA $0A96  [$7E:0A96]  ;} Samus animation frame = 2 (facing forward)
$91:EEF8 A9 3F 00    LDA #$003F             ;\
$91:EEFB 8D 94 0A    STA $0A94  [$7E:0A94]  ;} Samus animation frame timer = 3Fh
$91:EEFE A9 4F E9    LDA #$E94F             ;\
$91:EF01 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $E94F (x-ray)
$91:EF04 A9 18 E9    LDA #$E918             ;\
$91:EF07 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E918 (x-ray)
$91:EF0A A9 08 00    LDA #$0008             ;\
$91:EF0D 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = 8 (x-ray)
$91:EF10 A9 01 00    LDA #$0001             ;\
$91:EF13 8D D0 0A    STA $0AD0  [$7E:0AD0]  ;} X-ray palette timer = 1
$91:EF16 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; X-ray visor palette index = 0
$91:EF19 9C 68 0A    STZ $0A68  [$7E:0A68]  ; Special Samus palette timer = 0
$91:EF1C 9C D0 0C    STZ $0CD0  [$7E:0CD0]  ; Beam charge counter = 0
$91:EF1F 9C D6 0C    STZ $0CD6  [$7E:0CD6]  ;\
$91:EF22 9C D8 0C    STZ $0CD8  [$7E:0CD8]  ;} Charge beam animation frames = 0
$91:EF25 9C DA 0C    STZ $0CDA  [$7E:0CDA]  ;/
$91:EF28 9C DC 0C    STZ $0CDC  [$7E:0CDC]  ;\
$91:EF2B 9C DE 0C    STZ $0CDE  [$7E:0CDE]  ;} Charge beam animation delays = 0
$91:EF2E 9C E0 0C    STZ $0CE0  [$7E:0CE0]  ;/
$91:EF31 A9 09 00    LDA #$0009             ;\
$91:EF34 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 9, sound library 1, max queued sounds allowed = 6 (x-ray)
$91:EF38 60          RTS
}


;;; $EF39: RTS. Special prospective pose change command 6 - unused ;;;
{
$91:EF39 60          RTS
}


;;; $EF3A: RTS. Special prospective pose change command 7 - unused ;;;
{
$91:EF3A 60          RTS
}


;;; $EF3B: Special prospective pose change command 8 - unused ;;;
{
; This is like the opposite of $F397
$91:EF3B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:EF3E 38          SEC                    ;|
$91:EF3F E9 05 00    SBC #$0005             ;} Samus Y position -= 5
$91:EF42 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:EF45 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:EF48 A9 CD E8    LDA #$E8CD             ;\
$91:EF4B 8D 42 0A    STA $0A42  [$7E:0A42]  ;} Samus current state handler = RTL
$91:EF4E 60          RTS
}


;;; $EF4F: Special prospective pose change command 9 - connecting grapple - swinging ;;;
{
$91:EF4F 22 95 BD 9B JSL $9BBD95[$9B:BD95]  ; Set Samus animation frame and position during grapple swinging
}


;;; $EF53: Connecting grapple - kill speed and clamp scrolling speed ;;;
{
$91:EF53 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:EF56 38          SEC                    ;|
$91:EF57 ED 10 0B    SBC $0B10  [$7E:0B10]  ;|
$91:EF5A 30 11       BMI $11    [$EF6D]     ;|
$91:EF5C C9 0D 00    CMP #$000D             ;|
$91:EF5F 30 1B       BMI $1B    [$EF7C]     ;|
$91:EF61 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$91:EF64 38          SEC                    ;|
$91:EF65 E9 0C 00    SBC #$000C             ;|
$91:EF68 8D 10 0B    STA $0B10  [$7E:0B10]  ;} Samus previous X position = clamp([Samus previous X position], [Samus X position] - Ch, [Samus X position] + Ch)
$91:EF6B 80 0F       BRA $0F    [$EF7C]     ;|
                                            ;|
$91:EF6D C9 F4 FF    CMP #$FFF4             ;|
$91:EF70 10 0A       BPL $0A    [$EF7C]     ;|
$91:EF72 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$91:EF75 18          CLC                    ;|
$91:EF76 69 0C 00    ADC #$000C             ;|
$91:EF79 8D 10 0B    STA $0B10  [$7E:0B10]  ;/
                                            
$91:EF7C AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:EF7F 38          SEC                    ;|
$91:EF80 ED 14 0B    SBC $0B14  [$7E:0B14]  ;|
$91:EF83 30 11       BMI $11    [$EF96]     ;|
$91:EF85 C9 0D 00    CMP #$000D             ;|
$91:EF88 30 1B       BMI $1B    [$EFA5]     ;|
$91:EF8A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$91:EF8D 38          SEC                    ;|
$91:EF8E E9 0C 00    SBC #$000C             ;|
$91:EF91 8D 14 0B    STA $0B14  [$7E:0B14]  ;} Samus previous Y position = clamp([Samus previous Y position], [Samus Y position] - Ch, [Samus Y position] + Ch)
$91:EF94 80 0F       BRA $0F    [$EFA5]     ;|
                                            ;|
$91:EF96 C9 F4 FF    CMP #$FFF4             ;|
$91:EF99 10 0A       BPL $0A    [$EFA5]     ;|
$91:EF9B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$91:EF9E 18          CLC                    ;|
$91:EF9F 69 0C 00    ADC #$000C             ;|
$91:EFA2 8D 14 0B    STA $0B14  [$7E:0B14]  ;/

$91:EFA5 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:EFA9 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:EFAC 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:EFAF 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:EFB2 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:EFB5 9C 42 0B    STZ $0B42  [$7E:0B42]  ;\
$91:EFB8 9C 44 0B    STZ $0B44  [$7E:0B44]  ;} Samus X extra run speed = 0.0
$91:EFBB 60          RTS
}


;;; $EFBC: Special prospective pose change command Ah - connecting grapple - stuck in place ;;;
{
$91:EFBC 22 EB BE 9B JSL $9BBEEB[$9B:BEEB]  ; Set Samus animation frame and position for connecting grapple stuck in place
$91:EFC0 4C 53 EF    JMP $EF53  [$91:EF53]  ; Go to connecting grapple - kill speed and clamp scrolling speed
}
}


;;; $EFC3: RTS ;;;
{
$91:EFC3 60          RTS
}


;;; $EFC4..F31C: Solid vertical collision ;;;
{
;;; $EFC4: Prospective pose change command 5 - solid vertical collision ;;;
{
$91:EFC4 AD C6 0D    LDA $0DC6  [$7E:0DC6]  ;\
$91:EFC7 29 FF 00    AND #$00FF             ;|
$91:EFCA 0A          ASL A                  ;} Execute [$EFD0 + [Samus solid vertical collision result] * 2]
$91:EFCB AA          TAX                    ;|
$91:EFCC FC D0 EF    JSR ($EFD0,x)[$91:EFEF];/
$91:EFCF 60          RTS

$91:EFD0             dw EFC3, F010, EFEF, EFDE, EFDF, F2D3, F2F0
}


;;; $EFDE: RTS. Solid vertical collision - [Samus solid vertical collision result] = 3 ;;;
{
$91:EFDE 60          RTS
}


;;; $EFDF: Solid vertical collision - [Samus solid vertical collision result] = hit ceiling ;;;
{
$91:EFDF 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:EFE2 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:EFE5 9C 1A 0B    STZ $0B1A  [$7E:0B1A]  ; $0B1A = 0
$91:EFE8 A9 02 00    LDA #$0002             ;\
$91:EFEB 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$91:EFEE 60          RTS
}


;;; $EFEF: Solid vertical collision - [Samus solid vertical collision result] = falling ;;;
{
$91:EFEF AD 36 0B    LDA $0B36  [$7E:0B36]  ;\
$91:EFF2 C9 01 00    CMP #$0001             ;} If [Samus Y direction] != up:
$91:EFF5 F0 15       BEQ $15    [$F00C]     ;/
$91:EFF7 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:EFFA 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:EFFD 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:F000 A9 01 00    LDA #$0001             ;\
$91:F003 8D 22 0B    STA $0B22  [$7E:0B22]  ;} Set Samus as falling
$91:F006 A9 02 00    LDA #$0002             ;\
$91:F009 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down

$91:F00C 9C 18 0A    STZ $0A18  [$7E:0A18]  ; $0A18 = 0
$91:F00F 60          RTS
}


;;; $F010..F2D2: Landing ;;;
{
;;; $F010: Solid vertical collision - [Samus solid vertical collision result] = landed ;;;
{
$91:F010 20 46 F0    JSR $F046  [$91:F046]  ; Handle landing sound effects and graphics
$91:F013 AD C7 0D    LDA $0DC7  [$7E:0DC7]  ;\
$91:F016 29 FF 00    AND #$00FF             ;|
$91:F019 C9 04 00    CMP #$0004             ;} If [Samus downwards movement solid collision result] = no change:
$91:F01C D0 04       BNE $04    [$F022]     ;/
$91:F01E 20 D3 F1    JSR $F1D3  [$91:F1D3]  ; Set Samus as not bouncing
$91:F021 60          RTS                    ; Return

$91:F022 0A          ASL A                  ;\
$91:F023 AA          TAX                    ;} Execute [$F03A + [Samus downwards movement solid collision result] * 2]
$91:F024 FC 3A F0    JSR ($F03A,x)[$91:F1EC];/
$91:F027 90 01       BCC $01    [$F02A]     ; If carry set:
$91:F029 60          RTS                    ; Return

$91:F02A 9C 18 0A    STZ $0A18  [$7E:0A18]  ; $0A18 = 0
$91:F02D 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:F030 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:F033 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:F036 20 D3 F1    JSR $F1D3  [$91:F1D3]  ; Set Samus as not bouncing
$91:F039 60          RTS

$91:F03A             dw F1EC, F1FC, F253, F25E, EFC3, F2CE
}


;;; $F046: Handle landing sound effects and graphics ;;;
{
; The playing of the end spin jump / screw attack sound effect is done more generally by $90:F576
; and doesn't really need to be here
$91:F046 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F049 29 FF 00    AND #$00FF             ;|
$91:F04C C9 03 00    CMP #$0003             ;} If [Samus previous movement type] != spin jumping:
$91:F04F F0 05       BEQ $05    [$F056]     ;/
$91:F051 C9 14 00    CMP #$0014             ;\
$91:F054 D0 22       BNE $22    [$F078]     ;} If [Samus previous movement type] != wall jumping: go to BRANCH_NOT_ENDING_SOUND_EFFECT

$91:F056 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:F059 D0 1D       BNE $1D    [$F078]     ;} If [cinematic function] != 0: go to BRANCH_NOT_ENDING_SOUND_EFFECT
$91:F05B AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F05E C9 81 00    CMP #$0081             ;|
$91:F061 F0 0E       BEQ $0E    [$F071]     ;} If [Samus previous pose] != screw attack:
$91:F063 C9 82 00    CMP #$0082             ;|
$91:F066 F0 09       BEQ $09    [$F071]     ;/
$91:F068 A9 32 00    LDA #$0032             ;\
$91:F06B 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 6 (spin jump end)
$91:F06F 80 07       BRA $07    [$F078]

$91:F071 A9 34 00    LDA #$0034             ;\ Else ([Samus previous pose] = screw attack):
$91:F074 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 34h, sound library 1, max queued sounds allowed = 6 (screw attack end)

; BRANCH_NOT_ENDING_SOUND_EFFECT
$91:F078 AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:F07B F0 05       BEQ $05    [$F082]     ;|
$91:F07D C9 05 00    CMP #$0005             ;} If [Samus Y speed] >= 5: go to BRANCH_HARD_LANDING
$91:F080 10 13       BPL $13    [$F095]     ;/

$91:F082 AD 2C 0B    LDA $0B2C  [$7E:0B2C]  ;\
$91:F085 F0 1D       BEQ $1D    [$F0A4]     ;} If [Samus Y subspeed] = 0: return
$91:F087 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:F08A D0 15       BNE $15    [$F0A1]     ;} If [cinematic function] = 0:
$91:F08C A9 05 00    LDA #$0005             ;\
$91:F08F 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 5, sound library 3, max queued sounds allowed = 6 (Samus landed / wall-jumped)
$91:F093 80 0C       BRA $0C    [$F0A1]     ; Go to BRANCH_MERGE

; BRANCH_HARD_LANDING
$91:F095 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:F098 D0 07       BNE $07    [$F0A1]     ;} If [cinematic function] = 0:
$91:F09A A9 04 00    LDA #$0004             ;\
$91:F09D 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 4, sound library 3, max queued sounds allowed = 6 (Samus landed hard)

; BRANCH_MERGE
$91:F0A1 20 A5 F0    JSR $F0A5  [$91:F0A5]  ; Handle landing graphics

$91:F0A4 60          RTS
}


;;; $F0A5: Handle landing graphics ;;;
{
$91:F0A5 AD 9F 07    LDA $079F  [$7E:079F]  ;\
$91:F0A8 0A          ASL A                  ;|
$91:F0A9 AA          TAX                    ;} Execute [$F0AE + [area index] * 2]
$91:F0AA FC AE F0    JSR ($F0AE,x)[$91:F0C5];/
$91:F0AD 60          RTS

$91:F0AE             dw F0C5, ; Crateria
                        F1B2, ; Brinstar
                        F166, ; Norfair
                        F166, ; Wrecked Ship
                        F116, ; Maridia
                        F1BA, ; Tourian
                        F0BE, ; Ceres
                        F0BE  ; Debug
}


;;; $F0BE: Delete landing atmospheric graphics ;;;
{
$91:F0BE 9C F0 0A    STZ $0AF0  [$7E:0AF0]  ; Delete atmospheric graphics 2
$91:F0C1 9C F2 0A    STZ $0AF2  [$7E:0AF2]  ; Delete atmospheric graphics 3
$91:F0C4 60          RTS
}


;;; $F0C5: Handle landing graphics - Crateria ;;;
{
$91:F0C5 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:F0C8 D0 F4       BNE $F4    [$F0BE]     ;} If [cinematic function] != 0: go to delete landing atmospheric graphics
$91:F0CA AD 9D 07    LDA $079D  [$7E:079D]  ;\
$91:F0CD C9 1C 00    CMP #$001C             ;} If [room index] = 1Ch (Crateria space pirate shaft): go to BRANCH_CRATERIA_SPACE_PIRATE_SHAFT
$91:F0D0 F0 1E       BEQ $1E    [$F0F0]     ;/
$91:F0D2 AA          TAX                    ;\
$91:F0D3 E0 10 00    CPX #$0010             ;} If [room index] < 10h:
$91:F0D6 10 15       BPL $15    [$F0ED]     ;/
$91:F0D8 BD F3 F0    LDA $F0F3,x[$91:F0F3]  ;\
$91:F0DB 29 FF 00    AND #$00FF             ;|
$91:F0DE 89 01 00    BIT #$0001             ;} If [$F0F3 + [room index]] & 1: go to BRANCH_LANDING_SITE
$91:F0E1 D0 2B       BNE $2B    [$F10E]     ;/
$91:F0E3 89 02 00    BIT #$0002             ;\
$91:F0E6 D0 1C       BNE $1C    [$F104]     ;} If [$F0F3 + [room index]] & 2: go to BRANCH_WS_ENTRANCE
$91:F0E8 89 04 00    BIT #$0004             ;\
$91:F0EB D0 29       BNE $29    [$F116]     ;} If [$F0F3 + [room index]] & 4: go to handle landing footstep splashes

$91:F0ED 4C BE F0    JMP $F0BE  [$91:F0BE]  ; Go to delete landing atmospheric graphics

; BRANCH_CRATERIA_SPACE_PIRATE_SHAFT
$91:F0F0 4C 66 F1    JMP $F166  [$91:F166]  ; Go to handle landing dust

$91:F0F3             db 01, ; 0: Landing site
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
                        00,
                        00

; BRANCH_WS_ENTRANCE
$91:F104 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:F107 C9 B0 03    CMP #$03B0             ;} If [Samus Y position] >= 3B0h: go to handle landing footstep splashes
$91:F10A 10 0A       BPL $0A    [$F116]     ;/
$91:F10C 80 B0       BRA $B0    [$F0BE]     ; Go to delete landing atmospheric graphics

; BRANCH_LANDING_SITE
$91:F10E AD 6E 19    LDA $196E  [$7E:196E]  ;\
$91:F111 C9 0A 00    CMP #$000A             ;} If [FX type] != rain: go to delete landing atmospheric graphics
$91:F114 D0 A8       BNE $A8    [$F0BE]     ;/
}


;;; $F116: Handle landing graphics - Maridia / handle landing footstep splashes ;;;
{
$91:F116 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$91:F11A AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:F11D 30 0E       BMI $0E    [$F12D]     ;} If [FX Y position] >= 0:
$91:F11F C5 12       CMP $12    [$7E:0012]  ;\
$91:F121 10 13       BPL $13    [$F136]     ;} If [FX Y position] >= (Samus bottom boundary): go to BRANCH_NON_LIQUID_PHYSICS
$91:F123 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:F126 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$91:F129 D0 0B       BNE $0B    [$F136]     ;/
$91:F12B 80 38       BRA $38    [$F165]     ; Return

$91:F12D AD 62 19    LDA $1962  [$7E:1962]  ;\
$91:F130 30 04       BMI $04    [$F136]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$91:F132 C5 12       CMP $12    [$7E:0012]  ;\
$91:F134 30 2F       BMI $2F    [$F165]     ;} If [lava/acid Y position] < (Samus bottom boundary): return

; BRANCH_NON_LIQUID_PHYSICS
$91:F136 A9 00 01    LDA #$0100             ;\
$91:F139 8D F0 0A    STA $0AF0  [$7E:0AF0]  ;} Atmospheric graphics 2/3 animation frame = 0, type = 1 (footstep splashes)
$91:F13C 8D F2 0A    STA $0AF2  [$7E:0AF2]  ;/
$91:F13F A9 03 00    LDA #$0003             ;\
$91:F142 8D D8 0A    STA $0AD8  [$7E:0AD8]  ;} Atmospheric graphics 2/3 animation timer = 3
$91:F145 8D DA 0A    STA $0ADA  [$7E:0ADA]  ;/
$91:F148 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:F14B 18          CLC                    ;|
$91:F14C 69 04 00    ADC #$0004             ;} Atmospheric graphics 2 X position = [Samus X position] + 4
$91:F14F 8D E0 0A    STA $0AE0  [$7E:0AE0]  ;/
$91:F152 38          SEC                    ;\
$91:F153 E9 07 00    SBC #$0007             ;} Atmospheric graphics 3 X position = [Samus X position] - 3
$91:F156 8D E2 0A    STA $0AE2  [$7E:0AE2]  ;/
$91:F159 A5 12       LDA $12    [$7E:0012]  ;\
$91:F15B 38          SEC                    ;|
$91:F15C E9 04 00    SBC #$0004             ;} Atmospheric graphics 2/3 Y position = [Samus bottom boundary] - 4
$91:F15F 8D E8 0A    STA $0AE8  [$7E:0AE8]  ;|
$91:F162 8D EA 0A    STA $0AEA  [$7E:0AEA]  ;/

$91:F165 60          RTS
}


;;; $F166: Handle landing graphics - Norfair / Wrecked Ship / handle landing dust ;;;
{
$91:F166 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$91:F16A AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:F16D 30 0E       BMI $0E    [$F17D]     ;} If [FX Y position] >= 0:
$91:F16F C5 12       CMP $12    [$7E:0012]  ;\
$91:F171 10 13       BPL $13    [$F186]     ;} If [FX Y position] >= (Samus bottom boundary): go to BRANCH_NON_LIQUID_PHYSICS
$91:F173 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:F176 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$91:F179 D0 0B       BNE $0B    [$F186]     ;/
$91:F17B 80 34       BRA $34    [$F1B1]     ; Return

$91:F17D AD 62 19    LDA $1962  [$7E:1962]  ;\
$91:F180 30 04       BMI $04    [$F186]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$91:F182 C5 12       CMP $12    [$7E:0012]  ;\
$91:F184 30 2B       BMI $2B    [$F1B1]     ;} If [lava/acid Y position] < (Samus bottom boundary): return

; BRANCH_NON_LIQUID_PHYSICS
$91:F186 A9 00 06    LDA #$0600             ;\
$91:F189 8D F0 0A    STA $0AF0  [$7E:0AF0]  ;} Atmospheric graphics 2/3 animation frame = 0, type = 6 (dust due to landing)
$91:F18C 8D F2 0A    STA $0AF2  [$7E:0AF2]  ;/
$91:F18F A9 03 00    LDA #$0003             ;\
$91:F192 8D D8 0A    STA $0AD8  [$7E:0AD8]  ;} Atmospheric graphics 2/3 animation timer = 3
$91:F195 8D DA 0A    STA $0ADA  [$7E:0ADA]  ;/
$91:F198 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:F19B 18          CLC                    ;|
$91:F19C 69 08 00    ADC #$0008             ;} Atmospheric graphics 2 X position = [Samus X position] + 8
$91:F19F 8D E0 0A    STA $0AE0  [$7E:0AE0]  ;/
$91:F1A2 38          SEC                    ;\
$91:F1A3 E9 10 00    SBC #$0010             ;} Atmospheric graphics 3 X position = [Samus X position] - 8
$91:F1A6 8D E2 0A    STA $0AE2  [$7E:0AE2]  ;/
$91:F1A9 A5 12       LDA $12    [$7E:0012]  ;\
$91:F1AB 8D E8 0A    STA $0AE8  [$7E:0AE8]  ;} Atmospheric graphics 2/3 Y position = [Samus bottom boundary]
$91:F1AE 8D EA 0A    STA $0AEA  [$7E:0AEA]  ;/

$91:F1B1 60          RTS
}


;;; $F1B2: Handle landing graphics - Brinstar ;;;
{
; Seem to be missing an RTS (fallthrough doesn't look intentional)
$91:F1B2 AD 9D 07    LDA $079D  [$7E:079D]  ;\
$91:F1B5 C9 08 00    CMP #$0008             ;} If [room index] = 8 (Dachora room): go to handle landing dust
$91:F1B8 F0 AC       BEQ $AC    [$F166]     ;/
}


;;; $F1BA: Handle landing graphics - Tourian ;;;
{
; Brinstar:
;     5: Brinstar map station
;     6: Fireflea room
;     7: Green Brinstar missile station
;     Bh: Spore Spawn
; Tourian:
;     5: Tourian super-sidehopper room
;     6: Drained Torizo room
;     7: Shitroid room
;     8: Post Shitroid room
;     Bh: Tourian eye-door room
$91:F1BA AD 9D 07    LDA $079D  [$7E:079D]  ;\
$91:F1BD C9 05 00    CMP #$0005             ;} If [room index] >= 5:
$91:F1C0 30 0A       BMI $0A    [$F1CC]     ;/
$91:F1C2 C9 09 00    CMP #$0009             ;\
$91:F1C5 30 9F       BMI $9F    [$F166]     ;} If [room index] < 9: go to handle landing dust
$91:F1C7 C9 0B 00    CMP #$000B             ;\
$91:F1CA F0 9A       BEQ $9A    [$F166]     ;} If [room index] = Bh: go to handle landing dust

$91:F1CC 9C F0 0A    STZ $0AF0  [$7E:0AF0]  ; Delete atmospheric graphics 2
$91:F1CF 9C F2 0A    STZ $0AF2  [$7E:0AF2]  ; Delete atmospheric graphics 3
$91:F1D2 60          RTS
}


;;; $F1D3: Solid vertical collision - landed - set Samus as not bouncing ;;;
{
; More of a "set grounded state" operation
$91:F1D3 9C 22 0B    STZ $0B22  [$7E:0B22]  ; Set Samus as not falling
$91:F1D6 9C 1A 0B    STZ $0B1A  [$7E:0B1A]  ; $0B1A = 0
$91:F1D9 9C 2A 0B    STZ $0B2A  [$7E:0B2A]  ; $0B2A = 0
$91:F1DC 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:F1DF 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:F1E2 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:F1E5 9C 38 0B    STZ $0B38  [$7E:0B38]  ; $0B38 = 0
$91:F1E8 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F1EB 60          RTS
}


;;; $F1EC: Solid vertical collision - landed - [Samus downwards movement solid collision result] = grounded ;;;
{
$91:F1EC AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$91:F1EF C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$91:F1F2 F0 06       BEQ $06    [$F1FA]     ;/
$91:F1F4 A9 26 E9    LDA #$E926             ;\
$91:F1F7 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E926 (auto-jump hack)

$91:F1FA 18          CLC                    ;\
$91:F1FB 60          RTS                    ;} Return carry clear
}


;;; $F1FC: Solid vertical collision - landed - [Samus downwards movement solid collision result] = morph ball grounded ;;;
{
; Morph ball bounce - no springball
$91:F1FC AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$91:F1FF 0A          ASL A                  ;|
$91:F200 AA          TAX                    ;} Go to [$F204 + [morph ball bounce state] * 2]
$91:F201 7C 04 F2    JMP ($F204,x)[$91:F20A];/

$91:F204             dw F20A, F22B, F245
}


;;; $F20A: Morph ball bounce - morph ball - not bouncing ;;;
{
$91:F20A AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:F20D C9 03 00    CMP #$0003             ;} If [Samus Y speed] < 3: go to second bounce
$91:F210 30 33       BMI $33    [$F245]     ;/
$91:F212 EE 20 0B    INC $0B20  [$7E:0B20]  ; Morph ball bounce state = morph ball - first bounce
$91:F215 A9 01 00    LDA #$0001             ;\
$91:F218 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$91:F21B AF B7 9E 90 LDA $909EB7[$90:9EB7]  ;\
$91:F21F 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$91:F222 AF B5 9E 90 LDA $909EB5[$90:9EB5]  ;} Samus Y speed = 1.0 (morph ball bounce speed)
$91:F226 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$91:F229 38          SEC                    ;\
$91:F22A 60          RTS                    ;} Return carry set
}


;;; $F22B: Morph ball bounce - morph ball - first bounce ;;;
{
$91:F22B EE 20 0B    INC $0B20  [$7E:0B20]  ; Morph ball bounce state = morph ball - second bounce
$91:F22E A9 01 00    LDA #$0001             ;\
$91:F231 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$91:F234 AF B7 9E 90 LDA $909EB7[$90:9EB7]  ;\
$91:F238 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$91:F23B AF B5 9E 90 LDA $909EB5[$90:9EB5]  ;} Samus Y speed = 0.0 (morph ball bounce speed - 1)
$91:F23F 3A          DEC A                  ;|
$91:F240 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$91:F243 38          SEC                    ;\
$91:F244 60          RTS                    ;} Return carry set
}


;;; $F245: Morph ball bounce - morph ball - second bounce ;;;
{
$91:F245 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F248 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:F24B 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:F24E 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:F251 18          CLC                    ;\
$91:F252 60          RTS                    ;} Return carry clear
}


;;; $F253: Solid vertical collision - landed - [Samus downwards movement solid collision result] = 2 ;;;
{
$91:F253 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F256 A9 03 00    LDA #$0003             ;\
$91:F259 8D 46 0A    STA $0A46  [$7E:0A46]  ;} Enable horizontal slope detection
$91:F25C 18          CLC                    ;\
$91:F25D 60          RTS                    ;} Return carry clear
}


;;; $F25E: Solid vertical collision - landed - [Samus downwards movement solid collision result] = spring ball grounded ;;;
{
; Morph ball bounce - springball
$91:F25E A5 8B       LDA $8B    [$7E:008B]  ;\
$91:F260 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If pressing jump:
$91:F263 F0 09       BEQ $09    [$F26E]     ;/
$91:F265 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F268 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump
$91:F26C 38          SEC                    ;\
$91:F26D 60          RTS                    ;} Return carry set

$91:F26E AD 20 0B    LDA $0B20  [$7E:0B20]  ;\
$91:F271 29 FF 00    AND #$00FF             ;|
$91:F274 0A          ASL A                  ;} Go to [$F279 + ([morph ball bounce state] & FFh) * 2]
$91:F275 AA          TAX                    ;|
$91:F276 7C 79 F2    JMP ($F279,x)[$91:F27F];/

$91:F279             dw F27F, F2A3, F2C0
}


;;; $F27F: Morph ball bounce - spring ball - not bouncing ;;;
{
$91:F27F AD 2E 0B    LDA $0B2E  [$7E:0B2E]  ;\
$91:F282 C9 03 00    CMP #$0003             ;} If [Samus Y speed] < 3: go to second bounce
$91:F285 30 39       BMI $39    [$F2C0]     ;/
$91:F287 A9 01 06    LDA #$0601             ;\
$91:F28A 8D 20 0B    STA $0B20  [$7E:0B20]  ;} Morph ball bounce state = spring ball - first bounce
$91:F28D A9 01 00    LDA #$0001             ;\
$91:F290 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$91:F293 AF B7 9E 90 LDA $909EB7[$90:9EB7]  ;\
$91:F297 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$91:F29A AF B5 9E 90 LDA $909EB5[$90:9EB5]  ;} Samus Y speed = 1.0 (morph ball bounce speed)
$91:F29E 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$91:F2A1 38          SEC                    ;\
$91:F2A2 60          RTS                    ;} Return carry set
}


;;; $F2A3: Morph ball bounce - spring ball - first bounce ;;;
{
$91:F2A3 A9 02 06    LDA #$0602             ;\
$91:F2A6 8D 20 0B    STA $0B20  [$7E:0B20]  ;} Morph ball bounce state = spring ball - second bounce
$91:F2A9 A9 01 00    LDA #$0001             ;\
$91:F2AC 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = up
$91:F2AF AF B7 9E 90 LDA $909EB7[$90:9EB7]  ;\
$91:F2B3 8D 2C 0B    STA $0B2C  [$7E:0B2C]  ;|
$91:F2B6 AF B5 9E 90 LDA $909EB5[$90:9EB5]  ;} Samus Y speed = 0.0 (morph ball bounce speed - 1)
$91:F2BA 3A          DEC A                  ;|
$91:F2BB 8D 2E 0B    STA $0B2E  [$7E:0B2E]  ;/
$91:F2BE 38          SEC                    ;\
$91:F2BF 60          RTS                    ;} Return carry set
}


;;; $F2C0: Morph ball bounce - spring ball - second bounce ;;;
{
$91:F2C0 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F2C3 9C 36 0B    STZ $0B36  [$7E:0B36]  ; Samus Y direction = none
$91:F2C6 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:F2C9 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:F2CC 18          CLC                    ;\
$91:F2CD 60          RTS                    ;} Return carry clear
}


;;; $F2CE: Solid vertical collision - landed - [Samus downwards movement solid collision result] = 5 ;;;
{
$91:F2CE 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F2D1 18          CLC                    ;\
$91:F2D2 60          RTS                    ;} Return carry clear
}
}


;;; $F2D3: Solid vertical collision - [Samus solid vertical collision result] = wall jump triggered ;;;
{
$91:F2D3 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:F2D6 9C CE 0D    STZ $0DCE  [$7E:0DCE]  ; Samus X speed killed flag = 0
$91:F2D9 9C 22 0B    STZ $0B22  [$7E:0B22]  ; Set Samus as not falling
$91:F2DC 9C 1A 0B    STZ $0B1A  [$7E:0B1A]  ; $0B1A = 0
$91:F2DF 9C 46 0B    STZ $0B46  [$7E:0B46]  ;\
$91:F2E2 9C 48 0B    STZ $0B48  [$7E:0B48]  ;} Samus X base speed = 0.0
$91:F2E5 9C 18 0A    STZ $0A18  [$7E:0A18]  ; $0A18 = 0
$91:F2E8 A9 05 00    LDA #$0005             ;\
$91:F2EB 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 5, sound library 3, max queued sounds allowed = 6 (Samus landed / wall-jumped)
$91:F2EF 60          RTS
}


;;; $F2F0: Solid vertical collision - [Samus solid vertical collision result] = 6 ;;;
{
; This is the only code in the game that sets $0A46 to a non-3 value
; Code that checks this variable only cares if the 2 bit is set or not,
; so it's not known what the intended difference between 0 and 1 is here
$91:F2F0 AD CE 0D    LDA $0DCE  [$7E:0DCE]  ;\
$91:F2F3 F0 23       BEQ $23    [$F318]     ;} If Samus X speed not killed: return
$91:F2F5 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F2F8 29 FF 00    AND #$00FF             ;|
$91:F2FB C9 09 00    CMP #$0009             ;} If [Samus previous movement type] != 9 (unused): return
$91:F2FE D0 18       BNE $18    [$F318]     ;/
$91:F300 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:F303 29 FF 00    AND #$00FF             ;|
$91:F306 C9 04 00    CMP #$0004             ;} If facing right:
$91:F309 F0 08       BEQ $08    [$F313]     ;/
$91:F30B A9 01 00    LDA #$0001             ;\
$91:F30E 8D 46 0A    STA $0A46  [$7E:0A46]  ;} Disable horizontal slope detection
$91:F311 80 06       BRA $06    [$F319]     ; Go to BRANCH_RETURN

$91:F313 9C 46 0A    STZ $0A46  [$7E:0A46]  ; Disable horizontal slope detection
$91:F316 80 01       BRA $01    [$F319]     ; Go to BRANCH_RETURN

$91:F318 60          RTS

; BRANCH_RETURN
$91:F319 9C 18 0A    STZ $0A18  [$7E:0A18]  ; $0A18 = 0
$91:F31C 60          RTS
}
}


;;; $F31D..F403: Super special prospective pose change commands ;;;
{
;;; $F31D: Super special prospective pose change command 1 - knockback finished ;;;
{
$91:F31D 9C 52 0A    STZ $0A52  [$7E:0A52]  ; Knockback direction = none
$91:F320 A9 37 A3    LDA #$A337             ;\
$91:F323 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$91:F326 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F329 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:F32C 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:F32F A9 01 00    LDA #$0001             ;\
$91:F332 8D 22 0B    STA $0B22  [$7E:0B22]  ;} Samus is falling flag = 1
$91:F335 A9 02 00    LDA #$0002             ;\
$91:F338 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down
$91:F33B 22 7E EC 90 JSL $90EC7E[$90:EC7E]  ; Align Samus bottom position with previous pose
$91:F33F AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$91:F342 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$91:F345 F0 06       BEQ $06    [$F34D]     ;/
$91:F347 A9 13 E9    LDA #$E913             ;\
$91:F34A 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)

$91:F34D 60          RTS
}


;;; $F34E: Super special prospective pose change command 2 - shinespark finished ;;;
{
$91:F34E 22 7E EC 90 JSL $90EC7E[$90:EC7E]  ; Align Samus bottom position with previous pose
$91:F352 A9 37 A3    LDA #$A337             ;\
$91:F355 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$91:F358 AD 98 09    LDA $0998  [$7E:0998]  ;\
$91:F35B C9 2A 00    CMP #$002A             ;} If [game state] != playing demo:
$91:F35E F0 07       BEQ $07    [$F367]     ;/
$91:F360 A9 13 E9    LDA #$E913             ;\
$91:F363 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$91:F366 60          RTS                    ; Return

$91:F367 A9 1D E9    LDA #$E91D             ;\ Else ([game state] = playing demo):
$91:F36A 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E91D (demo)
$91:F36D 60          RTS
}


;;; $F36E: Super special prospective pose change command 3 - transition animation finished ;;;
{
$91:F36E 9C 20 0B    STZ $0B20  [$7E:0B20]  ; Morph ball bounce state = not bouncing
$91:F371 AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$91:F374 18          CLC                    ;|
$91:F375 6D 9C 0A    ADC $0A9C  [$7E:0A9C]  ;} Samus animation frame timer += [Samus animation frame buffer]
$91:F378 8D 94 0A    STA $0A94  [$7E:0A94]  ;/
$91:F37B 60          RTS
}


;;; $F37C: Super special prospective pose change command 4 ;;;
{
$91:F37C AD 11 09    LDA $0911  [$7E:0911]  ;\
$91:F37F 18          CLC                    ;|
$91:F380 69 80 00    ADC #$0080             ;} Samus X position = [layer 1 X position] + 80h
$91:F383 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$91:F386 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$91:F389 AD 15 09    LDA $0915  [$7E:0915]  ;\
$91:F38C 18          CLC                    ;|
$91:F38D 69 80 00    ADC #$0080             ;} Samus Y position = [layer 1 Y position] + 80h
$91:F390 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:F393 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:F396 60          RTS
}


;;; $F397: Super special prospective pose change command 5 ;;;
{
$91:F397 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:F39A 18          CLC                    ;|
$91:F39B 69 05 00    ADC #$0005             ;} Samus Y position += 5
$91:F39E 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:F3A1 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:F3A4 60          RTS
}


;;; $F3A5: Super special prospective pose change command 6 - start grapple wall-jump ;;;
{
$91:F3A5 22 BB FB 91 JSL $91FBBB[$91:FBBB]  ; Handle jump transition
$91:F3A9 60          RTS
}


;;; $F3AA: Super special prospective pose change command 7 - start release from grapple swing ;;;
{
; Clamps scrolling speed. I guess the idea is that Samus might have moved too far due to the pose change
$91:F3AA AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:F3AD 38          SEC                    ;|
$91:F3AE ED 10 0B    SBC $0B10  [$7E:0B10]  ;|
$91:F3B1 30 11       BMI $11    [$F3C4]     ;|
$91:F3B3 C9 0D 00    CMP #$000D             ;|
$91:F3B6 30 1B       BMI $1B    [$F3D3]     ;|
$91:F3B8 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$91:F3BB 38          SEC                    ;|
$91:F3BC E9 0C 00    SBC #$000C             ;|
$91:F3BF 8D 10 0B    STA $0B10  [$7E:0B10]  ;} Samus previous X position = clamp([Samus previous X position], [Samus X position] - Ch, [Samus X position] + Ch)
$91:F3C2 80 0F       BRA $0F    [$F3D3]     ;|
                                            ;|
$91:F3C4 C9 F4 FF    CMP #$FFF4             ;|
$91:F3C7 10 0A       BPL $0A    [$F3D3]     ;|
$91:F3C9 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$91:F3CC 18          CLC                    ;|
$91:F3CD 69 0C 00    ADC #$000C             ;|
$91:F3D0 8D 10 0B    STA $0B10  [$7E:0B10]  ;/
                                            
$91:F3D3 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:F3D6 38          SEC                    ;|
$91:F3D7 ED 14 0B    SBC $0B14  [$7E:0B14]  ;|
$91:F3DA 30 11       BMI $11    [$F3ED]     ;|
$91:F3DC C9 0D 00    CMP #$000D             ;|
$91:F3DF 30 1B       BMI $1B    [$F3FC]     ;|
$91:F3E1 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$91:F3E4 38          SEC                    ;|
$91:F3E5 E9 0C 00    SBC #$000C             ;|
$91:F3E8 8D 14 0B    STA $0B14  [$7E:0B14]  ;} Samus previous Y position = clamp([Samus previous Y position], [Samus Y position] - Ch, [Samus Y position] + Ch)
$91:F3EB 80 0F       BRA $0F    [$F3FC]     ;|
                                            ;|
$91:F3ED C9 F4 FF    CMP #$FFF4             ;|
$91:F3F0 10 0A       BPL $0A    [$F3FC]     ;|
$91:F3F2 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$91:F3F5 18          CLC                    ;|
$91:F3F6 69 0C 00    ADC #$000C             ;|
$91:F3F9 8D 14 0B    STA $0B14  [$7E:0B14]  ;/

$91:F3FC 60          RTS
}


;;; $F3FD: Super special prospective pose change command 8 - knockback and transition animation both finished ;;;
{
$91:F3FD 20 1D F3    JSR $F31D  [$91:F31D]  ; Super special prospective pose change command 1 - knockback finished
$91:F400 20 6E F3    JSR $F36E  [$91:F36E]  ; Super special prospective pose change command 3 - transition animation finished
$91:F403 60          RTS
}
}


;;; $F404: Handle Samus pose change ;;;
{
;; Returns:
;;     Carry: Set if pose changed, clear otherwise
$91:F404 08          PHP
$91:F405 8B          PHB
$91:F406 4B          PHK                    ;\
$91:F407 AB          PLB                    ;} DB = $91
$91:F408 C2 30       REP #$30
$91:F40A AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F40D 48          PHA                    ;} A = [Samus pose]
$91:F40E CD 20 0A    CMP $0A20  [$7E:0A20]  ;\
$91:F411 F0 12       BEQ $12    [$F425]     ;} If [Samus pose] = [Samus previous pose]: return carry clear
$91:F413 20 AE FD    JSR $FDAE  [$91:FDAE]  ; Handle collision due to change of pose
$91:F416 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:F41A 22 BB FB 91 JSL $91FBBB[$91:FBBB]  ; Handle jump transition
$91:F41E 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:F422 9C 9A 0A    STZ $0A9A  [$7E:0A9A]  ; New pose Samus animation frame = 0

$91:F425 68          PLA
$91:F426 CD 1C 0A    CMP $0A1C  [$7E:0A1C]  ;\
$91:F429 D0 04       BNE $04    [$F42F]     ;} If [Samus pose] != [A]: return carry set
$91:F42B AB          PLB
$91:F42C 28          PLP
$91:F42D 18          CLC                    ;\
$91:F42E 6B          RTL                    ;} Return carry clear

$91:F42F AB          PLB
$91:F430 28          PLP
$91:F431 38          SEC
$91:F432 6B          RTL
}


;;; $F433..FB07: Initialise Samus pose ;;;
{
;;; $F433: Initialise Samus pose (1/2) ;;;
{
$91:F433 08          PHP
$91:F434 8B          PHB
$91:F435 4B          PHK                    ;\
$91:F436 AB          PLB                    ;} DB = $91
$91:F437 C2 30       REP #$30
$91:F439 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F43C 0A          ASL A                  ;|
$91:F43D 0A          ASL A                  ;|
$91:F43E 0A          ASL A                  ;} Samus pose X direction / movement type = [$B629 + [Samus pose] * 8]
$91:F43F AA          TAX                    ;|
$91:F440 BD 29 B6    LDA $B629,x[$91:B639]  ;|
$91:F443 8D 1E 0A    STA $0A1E  [$7E:0A1E]  ;/
$91:F446 20 68 F4    JSR $F468  [$91:F468]  ; Initialise Samus pose (2/2)
$91:F449 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F44C 29 FF 00    AND #$00FF             ;|
$91:F44F C9 03 00    CMP #$0003             ;} If [Samus previous movement type] != spin jumping:
$91:F452 F0 05       BEQ $05    [$F459]     ;/
$91:F454 C9 14 00    CMP #$0014             ;\
$91:F457 D0 0C       BNE $0C    [$F465]     ;} If [Samus previous movement type] != wall jumping: return

$91:F459 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:F45C 89 08 00    BIT #$0008             ;} If screw attack equipped:
$91:F45F F0 04       BEQ $04    [$F465]     ;/
$91:F461 22 BA DE 91 JSL $91DEBA[$91:DEBA]  ; Load Samus suit palette

$91:F465 AB          PLB
$91:F466 28          PLP
$91:F467 6B          RTL
}


;;; $F468: Initialise Samus pose (2/2) ;;;
{
$91:F468 08          PHP
$91:F469 C2 30       REP #$30
$91:F46B AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:F46E 29 FF 00    AND #$00FF             ;|
$91:F471 0A          ASL A                  ;} Execute [$F4A2 + [Samus movement type] * 2]
$91:F472 AA          TAX                    ;|
$91:F473 FC A2 F4    JSR ($F4A2,x)[$91:F4DC];/
$91:F476 90 28       BCC $28    [$F4A0]     ; If carry set:
$91:F478 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F47B 0A          ASL A                  ;|
$91:F47C 0A          ASL A                  ;|
$91:F47D 0A          ASL A                  ;} Samus pose X direction / movement type = [$B629 + [Samus pose] * 8]
$91:F47E AA          TAX                    ;|
$91:F47F BD 29 B6    LDA $B629,x[$91:B759]  ;|
$91:F482 8D 1E 0A    STA $0A1E  [$7E:0A1E]  ;/
$91:F485 29 00 FF    AND #$FF00             ;\
$91:F488 C9 00 0E    CMP #$0E00             ;} If [Samus movement type] = turning around - on ground:
$91:F48B D0 13       BNE $13    [$F4A0]     ;/
$91:F48D EB          XBA                    ;\
$91:F48E 0A          ASL A                  ;|
$91:F48F AA          TAX                    ;} Initialise Samus pose - turning around - on ground
$91:F490 FC A2 F4    JSR ($F4A2,x)[$91:F8D3];/
$91:F493 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F496 0A          ASL A                  ;|
$91:F497 0A          ASL A                  ;|
$91:F498 0A          ASL A                  ;} Samus pose X direction / movement type = [$B629 + [Samus pose] * 8]
$91:F499 AA          TAX                    ;|
$91:F49A BD 29 B6    LDA $B629,x[$91:B759]  ;|
$91:F49D 8D 1E 0A    STA $0A1E  [$7E:0A1E]  ;/

$91:F4A0 28          PLP
$91:F4A1 60          RTS

$91:F4A2             dw F4DC, ; *0: Standing
                        F50C, ; *1: Running
                        F543, ; *2: Normal jumping
                        F624, ; *3: Spin jumping
                        F9F4, ; *4: Morph ball - on ground
                        F5EB, ; *5: Crouching
                        F60D, ; *6: Falling
                        F4DA, ;  7: Unused
                        F9F4, ; *8: Morph ball - falling
                        F4DA, ;  9: Unused
                        F4DA, ;  Ah: Knockback / crystal flash ending
                        F4DA, ;  Bh: Unused
                        F4DA, ;  Ch: Unused
                        F4DA, ;  Dh: Unused
                        F8D3, ; *Eh: Turning around - on ground
                        F758, ; *Fh: Crouching/standing/morphing/unmorphing transition
                        F88C, ; *10h: Moonwalking
                        FA56, ; *11h: Spring ball - on ground
                        FA56, ; *12h: Spring ball - in air
                        FA56, ; *13h: Spring ball - falling
                        FA76, ; *14h: Wall jumping
                        F4DA, ;  15h: Ran into a wall
                        F4DA, ;  16h: Grappling
                        F952, ; *17h: Turning around - jumping
                        F98A, ; *18h: Turning around - falling
                        F8AE, ; *19h: Damage boost
                        F4DA, ;  1Ah: Grabbed by Draygon
                        FACA  ; *1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $F4DA: Clear carry ;;;
{
$91:F4DA 18          CLC
$91:F4DB 60          RTS
}


;;; $F4DC: Initialise Samus pose - standing ;;;
{
$91:F4DC AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F4DF 0A          ASL A                  ;|
$91:F4E0 0A          ASL A                  ;|
$91:F4E1 0A          ASL A                  ;|
$91:F4E2 AA          TAX                    ;|
$91:F4E3 BD 2C B6    LDA $B62C,x[$91:B63C]  ;} If direction shots are fired != up: return carry clear
$91:F4E6 29 FF 00    AND #$00FF             ;|
$91:F4E9 F0 05       BEQ $05    [$F4F0]     ;|
$91:F4EB C9 09 00    CMP #$0009             ;|
$91:F4EE D0 1A       BNE $1A    [$F50A]     ;/

$91:F4F0 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F4F3 0A          ASL A                  ;|
$91:F4F4 0A          ASL A                  ;|
$91:F4F5 0A          ASL A                  ;|
$91:F4F6 AA          TAX                    ;|
$91:F4F7 BD 2C B6    LDA $B62C,x[$91:B634]  ;} If previous direction shots are fired != up: return carry clear
$91:F4FA 29 FF 00    AND #$00FF             ;|
$91:F4FD F0 05       BEQ $05    [$F504]     ;|
$91:F4FF C9 09 00    CMP #$0009             ;|
$91:F502 D0 06       BNE $06    [$F50A]     ;/

$91:F504 A9 01 00    LDA #$0001             ;\
$91:F507 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 1

$91:F50A 18          CLC                    ;\
$91:F50B 60          RTS                    ;} Return carry clear
}


;;; $F50C: Initialise Samus pose - running ;;;
{
$91:F50C AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F50F 29 FF 00    AND #$00FF             ;|
$91:F512 C9 01 00    CMP #$0001             ;} If [Samus previous movement type] = running:
$91:F515 D0 06       BNE $06    [$F51D]     ;/
$91:F517 A9 00 80    LDA #$8000             ;\
$91:F51A 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 8000h (preserve animation frame)

$91:F51D AD F8 0D    LDA $0DF8  [$7E:0DF8]  ;\
$91:F520 F0 1F       BEQ $1F    [$F541]     ;} If [$0DF8] = 0 (always true): return carry clear
$91:F522 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F525 C9 45 00    CMP #$0045             ;} If [Samus pose] = 45h: go to BRANCH_TURN_LEFT
$91:F528 F0 07       BEQ $07    [$F531]     ;/
$91:F52A C9 46 00    CMP #$0046             ;\
$91:F52D F0 0A       BEQ $0A    [$F539]     ;} If [Samus pose] = 46h: go to BRANCH_TURN_RIGHT
$91:F52F 80 10       BRA $10    [$F541]     ; Return carry clear

; BRANCH_TURN_LEFT
$91:F531 A9 25 00    LDA #$0025             ;\
$91:F534 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - turning - standing
$91:F537 80 06       BRA $06    [$F53F]     ; Return carry set

; BRANCH_TURN_RIGHT
$91:F539 A9 26 00    LDA #$0026             ;\
$91:F53C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - turning - standing

$91:F53F 38          SEC                    ;\
$91:F540 60          RTS                    ;} Return carry set

$91:F541 18          CLC
$91:F542 60          RTS
}


;;; $F543: Initialise Samus pose - normal jumping ;;;
{
; The $F5CF section seems kinda pointless(?)
; NOPing it causes fire to be required to be held for more than 1 frame to fire from a spin-jump,
; otherwise, if charge is equipped, fire only needs to be held for one frame.
; Note that if Samus has her beam charged, then she only needs to hold fire for one frame to fire the charged beam,
; regardless of whether this section is NOPed or not

; This checklist of poses notably excludes the two gun extended poses 13h/14h

$91:F543 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F546 C9 4E 00    CMP #$004E             ;} If [Samus pose] = facing left - normal jump - not aiming - not moving - gun not extended: go to BRANCH_SHINESPARK_FACING_LEFT
$91:F549 F0 26       BEQ $26    [$F571]     ;/
$91:F54B C9 4D 00    CMP #$004D             ;\
$91:F54E F0 14       BEQ $14    [$F564]     ;} If [Samus pose] = facing right - normal jump - not aiming - not moving - gun not extended: go to BRANCH_SHINESPARK_FACING_RIGHT
$91:F550 C9 15 00    CMP #$0015             ;\
$91:F553 F0 0F       BEQ $0F    [$F564]     ;} If [Samus pose] = facing right - normal jump - aiming up: go to BRANCH_SHINESPARK_FACING_RIGHT
$91:F555 C9 16 00    CMP #$0016             ;\
$91:F558 F0 17       BEQ $17    [$F571]     ;} If [Samus pose] = facing left - normal jump - aiming up: go to BRANCH_SHINESPARK_FACING_LEFT
$91:F55A C9 6A 00    CMP #$006A             ;\
$91:F55D F0 12       BEQ $12    [$F571]     ;} If [Samus pose] = facing left - normal jump - aiming up-left: go to BRANCH_SHINESPARK_FACING_LEFT
$91:F55F C9 69 00    CMP #$0069             ;\
$91:F562 D0 36       BNE $36    [$F59A]     ;} If [Samus pose] != facing right - normal jump - aiming up-right: go to BRANCH_NOT_SHINESPARK

; BRANCH_SHINESPARK_FACING_RIGHT
$91:F564 AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$91:F567 F0 31       BEQ $31    [$F59A]     ;} If [special Samus palette timer] = 0: go to BRANCH_NOT_SHINESPARK
$91:F569 A9 C7 00    LDA #$00C7             ;\
$91:F56C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - vertical shinespark windup
$91:F56F 80 0B       BRA $0B    [$F57C]     ; Go to BRANCH_SHINESPARK_MERGE

; BRANCH_SHINESPARK_FACING_LEFT
$91:F571 AD 68 0A    LDA $0A68  [$7E:0A68]  ;\
$91:F574 F0 24       BEQ $24    [$F59A]     ;} If [special Samus palette timer] = 0: go to BRANCH_NOT_SHINESPARK
$91:F576 A9 C8 00    LDA #$00C8             ;\
$91:F579 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - vertical shinespark windup

; BRANCH_SHINESPARK_MERGE
$91:F57C 22 FA CF 90 JSL $90CFFA[$90:CFFA]  ; Trigger shinespark windup
$91:F580 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F583 29 FF 00    AND #$00FF             ;|
$91:F586 C9 02 00    CMP #$0002             ;} If [Samus previous movement type] = normal jumping:
$91:F589 D0 0D       BNE $0D    [$F598]     ;/
$91:F58B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:F58E 38          SEC                    ;|
$91:F58F E9 01 00    SBC #$0001             ;} Samus Y position -= 1
$91:F592 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:F595 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]

$91:F598 38          SEC                    ;\
$91:F599 60          RTS                    ;} Return carry set

; BRANCH_NOT_SHINESPARK
$91:F59A AD 42 0B    LDA $0B42  [$7E:0B42]  ;\
$91:F59D D0 0A       BNE $0A    [$F5A9]     ;|
$91:F59F AD 44 0B    LDA $0B44  [$7E:0B44]  ;} If [Samus X extra run speed] = 0.0:
$91:F5A2 D0 05       BNE $05    [$F5A9]     ;/
$91:F5A4 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:F5A7 80 06       BRA $06    [$F5AF]

$91:F5A9 A9 02 00    LDA #$0002             ;\ Else ([Samus X extra run speed] != 0.0):
$91:F5AC 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

$91:F5AF AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F5B2 C9 15 00    CMP #$0015             ;|
$91:F5B5 F0 05       BEQ $05    [$F5BC]     ;} If [Samus pose] != normal jump - aiming up: go to BRANCH_NO_ANIMATION_SKIP
$91:F5B7 C9 16 00    CMP #$0016             ;|
$91:F5BA D0 13       BNE $13    [$F5CF]     ;/

$91:F5BC AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F5BF C9 55 00    CMP #$0055             ;|
$91:F5C2 F0 05       BEQ $05    [$F5C9]     ;} If [Samus previous pose] != normal jump transition - aiming up: go to BRANCH_NO_ANIMATION_SKIP
$91:F5C4 C9 56 00    CMP #$0056             ;|
$91:F5C7 D0 06       BNE $06    [$F5CF]     ;/

$91:F5C9 A9 01 00    LDA #$0001             ;\
$91:F5CC 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 1 (skip arm cannon moving up animation)

; BRANCH_NO_ANIMATION_SKIP
$91:F5CF A5 8F       LDA $8F    [$7E:008F]  ;\
$91:F5D1 2C B2 09    BIT $09B2  [$7E:09B2]  ;} If newly pressed shoot:
$91:F5D4 F0 13       BEQ $13    [$F5E9]     ;/
$91:F5D6 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F5D9 0A          ASL A                  ;|
$91:F5DA 0A          ASL A                  ;|
$91:F5DB 0A          ASL A                  ;|
$91:F5DC AA          TAX                    ;} Pose transition shot direction = [$B62C + [Samus pose] * 8] (direction shots are fired) | 8000h
$91:F5DD BD 2C B6    LDA $B62C,x[$91:B6C4]  ;|
$91:F5E0 29 FF 00    AND #$00FF             ;|
$91:F5E3 09 00 80    ORA #$8000             ;|
$91:F5E6 8D 5E 0B    STA $0B5E  [$7E:0B5E]  ;/

$91:F5E9 18          CLC                    ;\
$91:F5EA 60          RTS                    ;} Return carry clear
}


;;; $F5EB: Initialise Samus pose - crouching ;;;
{
$91:F5EB AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F5EE C9 85 00    CMP #$0085             ;|
$91:F5F1 F0 05       BEQ $05    [$F5F8]     ;} If [Samus pose] != crouching - aiming up: return carry clear
$91:F5F3 C9 86 00    CMP #$0086             ;|
$91:F5F6 D0 13       BNE $13    [$F60B]     ;/

$91:F5F8 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F5FB C9 F1 00    CMP #$00F1             ;|
$91:F5FE F0 05       BEQ $05    [$F605]     ;} If [Samus previous pose] != crouching transition - aiming up: return carry clear
$91:F600 C9 F2 00    CMP #$00F2             ;|
$91:F603 D0 06       BNE $06    [$F60B]     ;/

$91:F605 A9 01 00    LDA #$0001             ;\
$91:F608 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 1 (skip arm cannon moving up animation)

$91:F60B 18          CLC                    ;\
$91:F60C 60          RTS                    ;} Return carry clear
}


;;; $F60D: Initialise Samus pose - falling ;;;
{
$91:F60D AD 42 0B    LDA $0B42  [$7E:0B42]  ;\
$91:F610 D0 0A       BNE $0A    [$F61C]     ;|
$91:F612 AD 44 0B    LDA $0B44  [$7E:0B44]  ;} If [Samus X extra run speed] = 0.0:
$91:F615 D0 05       BNE $05    [$F61C]     ;/
$91:F617 9C 4A 0B    STZ $0B4A  [$7E:0B4A]  ; Samus X acceleration mode = accelerating
$91:F61A 80 06       BRA $06    [$F622]

$91:F61C A9 02 00    LDA #$0002             ;\ Else ([Samus X extra run speed] != 0.0):
$91:F61F 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

$91:F622 18          CLC                    ;\
$91:F623 60          RTS                    ;} Return carry clear
}


;;; $F624: Initialise Samus pose - spin jumping ;;;
{
$91:F624 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F627 29 FF 00    AND #$00FF             ;|
$91:F62A C9 03 00    CMP #$0003             ;} If [Samus previous movement type] != spin jumping:
$91:F62D F0 05       BEQ $05    [$F634]     ;/
$91:F62F C9 14 00    CMP #$0014             ;\
$91:F632 D0 4B       BNE $4B    [$F67F]     ;} If [Samus previous movement type] != wall jumping: go to BRANCH_NOT_TURNING_AROUND

$91:F634 A9 01 00    LDA #$0001             ;\
$91:F637 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 1 (skip jumping from floor animation)
$91:F63A AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:F63D 29 0F 00    AND #$000F             ;|
$91:F640 C9 08 00    CMP #$0008             ;|
$91:F643 F0 0F       BEQ $0F    [$F654]     ;|
$91:F645 C9 04 00    CMP #$0004             ;|
$91:F648 D0 35       BNE $35    [$F67F]     ;|
$91:F64A AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;|
$91:F64D C9 08 03    CMP #$0308             ;} If [Samus previous pose X direction] = [Samus pose X direction]: go to BRANCH_NOT_TURNING_AROUND
$91:F650 F0 0A       BEQ $0A    [$F65C]     ;|
$91:F652 80 2B       BRA $2B    [$F67F]     ;|
                                            ;|
$91:F654 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;|
$91:F657 C9 04 03    CMP #$0304             ;|
$91:F65A D0 23       BNE $23    [$F67F]     ;/

$91:F65C AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$91:F65F 18          CLC                    ;|
$91:F660 6D 48 0B    ADC $0B48  [$7E:0B48]  ;|
$91:F663 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [Samus X extra run speed]
$91:F666 AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$91:F669 6D 46 0B    ADC $0B46  [$7E:0B46]  ;|
$91:F66C 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$91:F66F 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:F673 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:F676 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:F679 A9 01 00    LDA #$0001             ;\
$91:F67C 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = turning around

; BRANCH_NOT_TURNING_AROUND
$91:F67F AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:F682 29 FF 00    AND #$00FF             ;|
$91:F685 C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_FACING_LEFT
$91:F688 F0 61       BEQ $61    [$F6EB]     ;/
$91:F68A AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:F68D 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NON_LIQUID_PHYSICS_RIGHT
$91:F690 D0 20       BNE $20    [$F6B2]     ;/
$91:F692 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $14 = Samus top boundary
$91:F696 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:F699 30 0E       BMI $0E    [$F6A9]     ;} If [FX Y position] >= 0:
$91:F69B C5 14       CMP $14    [$7E:0014]  ;\
$91:F69D 10 13       BPL $13    [$F6B2]     ;} If [FX Y position] >= (Samus top boundary): go to BRANCH_NON_LIQUID_PHYSICS_RIGHT
$91:F69F AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:F6A2 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS_RIGHT
$91:F6A5 D0 0B       BNE $0B    [$F6B2]     ;/
$91:F6A7 80 1B       BRA $1B    [$F6C4]     ; Return carry clear

$91:F6A9 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$91:F6AC 30 04       BMI $04    [$F6B2]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS_RIGHT
$91:F6AE C5 14       CMP $14    [$7E:0014]  ;\
$91:F6B0 30 12       BMI $12    [$F6C4]     ;} If [lava/acid Y position] < (Samus top boundary): return carry clear

; BRANCH_NON_LIQUID_PHYSICS_RIGHT
$91:F6B2 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:F6B5 89 08 00    BIT #$0008             ;} If screw attack equipped: go to BRANCH_SCREW_ATTACK_RIGHT
$91:F6B8 D0 29       BNE $29    [$F6E3]     ;/
$91:F6BA 89 00 02    BIT #$0200             ;\
$91:F6BD D0 15       BNE $15    [$F6D4]     ;} If space jump equipped: go to BRANCH_SPACE_JUMP_RIGHT
$91:F6BF AD 9A 0A    LDA $0A9A  [$7E:0A9A]  ;\
$91:F6C2 F0 02       BEQ $02    [$F6C6]     ;} If [new pose Samus animation frame] = 0 (not previously spinning): go to BRANCH_SPIN_JUMP_RIGHT

$91:F6C4 18          CLC                    ;\
$91:F6C5 60          RTS                    ;} Return carry clear

; BRANCH_SPIN_JUMP_RIGHT
$91:F6C6 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:F6C9 D0 F9       BNE $F9    [$F6C4]     ;} If [cinematic function] != 0: return carry clear
$91:F6CB A9 31 00    LDA #$0031             ;\
$91:F6CE 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 31h, sound library 1, max queued sounds allowed = 6 (spin jump)
$91:F6D2 18          CLC                    ;\
$91:F6D3 60          RTS                    ;} Return carry clear

; BRANCH_SPACE_JUMP_RIGHT
$91:F6D4 A9 3E 00    LDA #$003E             ;\
$91:F6D7 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Eh, sound library 1, max queued sounds allowed = 6 (space jump)
$91:F6DB A9 1B 00    LDA #$001B             ;\
$91:F6DE 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - space jump
$91:F6E1 18          CLC                    ;\
$91:F6E2 60          RTS                    ;} Return carry clear

; BRANCH_SCREW_ATTACK_RIGHT
$91:F6E3 A9 81 00    LDA #$0081             ;\
$91:F6E6 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - screw attack
$91:F6E9 80 5F       BRA $5F    [$F74A]     ; Go to BRANCH_SCREW_ATTACK_SOUND_EFFECT

; BRANCH_FACING_LEFT
$91:F6EB AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:F6EE 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NON_LIQUID_PHYSICS_LEFT
$91:F6F1 D0 20       BNE $20    [$F713]     ;/
$91:F6F3 22 58 EC 90 JSL $90EC58[$90:EC58]  ; $14 = Samus top boundary
$91:F6F7 AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:F6FA 30 0E       BMI $0E    [$F70A]     ;} If [FX Y position] >= 0:
$91:F6FC C5 14       CMP $14    [$7E:0014]  ;\
$91:F6FE 10 13       BPL $13    [$F713]     ;} If [FX Y position] >= (Samus top boundary): go to BRANCH_NON_LIQUID_PHYSICS_LEFT
$91:F700 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:F703 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS_LEFT
$91:F706 D0 0B       BNE $0B    [$F713]     ;/
$91:F708 80 1B       BRA $1B    [$F725]     ; Return carry clear

$91:F70A AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$91:F70D 30 04       BMI $04    [$F713]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS_LEFT
$91:F70F C5 14       CMP $14    [$7E:0014]  ;\
$91:F711 30 12       BMI $12    [$F725]     ;} If [lava/acid Y position] < (Samus top boundary): return carry clear

; BRANCH_NON_LIQUID_PHYSICS_LEFT
$91:F713 AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:F716 89 08 00    BIT #$0008             ;} If screw attack equipped: go to BRANCH_SCREW_ATTACK_LEFT
$91:F719 D0 29       BNE $29    [$F744]     ;/
$91:F71B 89 00 02    BIT #$0200             ;\
$91:F71E D0 15       BNE $15    [$F735]     ;} If space jump equipped: go to BRANCH_SPACE_JUMP_LEFT
$91:F720 AD 9A 0A    LDA $0A9A  [$7E:0A9A]  ;\
$91:F723 F0 02       BEQ $02    [$F727]     ;} If [new pose Samus animation frame] = 0 (not previously spinning): go to BRANCH_SPIN_JUMP_LEFT

$91:F725 18          CLC                    ;\
$91:F726 60          RTS                    ;} Return carry clear

; BRANCH_SPIN_JUMP_LEFT
$91:F727 AD 51 1F    LDA $1F51  [$7E:1F51]  ;\
$91:F72A D0 F9       BNE $F9    [$F725]     ;} If [cinematic function] != 0: return carry clear
$91:F72C A9 31 00    LDA #$0031             ;\
$91:F72F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 31h, sound library 1, max queued sounds allowed = 6 (spin jump)
$91:F733 18          CLC                    ;\
$91:F734 60          RTS                    ;} Return carry clear

; BRANCH_SPACE_JUMP_LEFT
$91:F735 A9 3E 00    LDA #$003E             ;\
$91:F738 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 3Eh, sound library 1, max queued sounds allowed = 6 (space jump)
$91:F73C A9 1C 00    LDA #$001C             ;\
$91:F73F 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - space jump
$91:F742 18          CLC                    ;\
$91:F743 60          RTS                    ;} Return carry clear

; BRANCH_SCREW_ATTACK_LEFT
$91:F744 A9 82 00    LDA #$0082             ;\
$91:F747 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - screw attack

; BRANCH_SCREW_ATTACK_SOUND_EFFECT
$91:F74A AD 9A 0A    LDA $0A9A  [$7E:0A9A]  ;\
$91:F74D D0 07       BNE $07    [$F756]     ;} If [new pose Samus animation frame] = 0 (not previously spinning):
$91:F74F A9 33 00    LDA #$0033             ;\
$91:F752 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 33h, sound library 1, max queued sounds allowed = 6 (screw attack)

$91:F756 18          CLC                    ;\
$91:F757 60          RTS                    ;} Return carry clear
}


;;; $F758: Initialise Samus pose - crouching/standing/morphing/unmorphing transition ;;;
{
$91:F758 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:F75B C9 F1 00    CMP #$00F1             ;} If [Samus pose] >= F1h: go to BRANCH_AIMING
$91:F75E 10 1F       BPL $1F    [$F77F]     ;/
$91:F760 C9 DB 00    CMP #$00DB             ;\
$91:F763 10 10       BPL $10    [$F775]     ;} If [Samus pose] >= DBh: go to BRANCH_UNUSED
$91:F765 38          SEC                    ;\
$91:F766 E9 35 00    SBC #$0035             ;|
$91:F769 0A          ASL A                  ;} X = ([Samus pose] - 35h) * 2
$91:F76A AA          TAX                    ;/

$91:F76B A9 07 00    LDA #$0007             ;\
$91:F76E 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = start transition animation
$91:F771 FC 90 F7    JSR ($F790,x)[$91:F7B0]; Execute [$F790 + [X]]
$91:F774 60          RTS                    ; Return carry

; BRANCH_UNUSED
$91:F775 38          SEC                    ;\
$91:F776 E9 DB 00    SBC #$00DB             ;|
$91:F779 0A          ASL A                  ;} Execute [$F7A8 + ([Samus pose] - DBh) * 2]
$91:F77A AA          TAX                    ;|
$91:F77B FC A8 F7    JSR ($F7A8,x)          ;/
$91:F77E 60          RTS                    ; Return carry

; BRANCH_AIMING
$91:F77F C9 F7 00    CMP #$00F7             ;\
$91:F782 10 05       BPL $05    [$F789]     ;} If [Samus pose] = crouching transition - aiming:
$91:F784 A2 00 00    LDX #$0000             ;\
$91:F787 80 E2       BRA $E2    [$F76B]     ;} Initialise Samus pose - crouching transition

$91:F789 A9 07 00    LDA #$0007             ;\
$91:F78C 8D 2E 0A    STA $0A2E  [$7E:0A2E]  ;} Prospective pose change command = start transition animation
$91:F78F 60          RTS                    ; Return carry

$91:F790             dw F7B0, ; 35h: Facing right - crouching transition / crouching transition - aiming
                        F7B0, ; 36h: Facing left  - crouching transition
                        F7CE, ; 37h: Facing right - morphing transition
                        F7CE, ; 38h: Facing left  - morphing transition
                        F7F4, ; 39h: Unused
                        F840, ; 3Ah: Unused
                        F7CC, ; 3Bh: Facing right - standing transition
                        F7CC, ; 3Ch: Facing left  - standing transition
                        F7CC, ; 3Dh: Facing right - unmorphing transition
                        F7CC, ; 3Eh: Facing left  - unmorphing transition
                        F7CC, ; 3Fh: Unused
                        F7CC  ; 40h: Unused

; Unused poses DBh..DEh
$91:F7A8             dw F7CE, F7CE, F7CC, F7CC
}


;;; $F7B0: Initialise Samus pose - crouching transition ;;;
{
; Gives Samus shinespark
$91:F7B0 AD 3E 0B    LDA $0B3E  [$7E:0B3E]  ;\
$91:F7B3 29 00 FF    AND #$FF00             ;|
$91:F7B6 C9 00 04    CMP #$0400             ;} If speed boosting:
$91:F7B9 30 0F       BMI $0F    [$F7CA]     ;/
$91:F7BB A9 B4 00    LDA #$00B4             ;\
$91:F7BE 8D 68 0A    STA $0A68  [$7E:0A68]  ;} Special Samus palette timer = 180
$91:F7C1 A9 01 00    LDA #$0001             ;\
$91:F7C4 8D CC 0A    STA $0ACC  [$7E:0ACC]  ;} Special Samus palette type = 1 (speed booster shine)
$91:F7C7 9C CE 0A    STZ $0ACE  [$7E:0ACE]  ; Special Samus palette frame = 0

$91:F7CA 18          CLC                    ;\
$91:F7CB 60          RTS                    ;} Return carry clear
}


;;; $F7CC: Clear carry ;;;
{
$91:F7CC 18          CLC
$91:F7CD 60          RTS
}


;;; $F7CE: Initialise Samus pose - morphing transition ;;;
{
$91:F7CE AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:F7D1 89 04 00    BIT #$0004             ;} If morph ball not equipped: go to BRANCH_NO_MORPH_BALL
$91:F7D4 F0 16       BEQ $16    [$F7EC]     ;/
$91:F7D6 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F7D9 29 FF 00    AND #$00FF             ;|
$91:F7DC C9 03 00    CMP #$0003             ;} If [Samus previous movement type] = spin jumping:
$91:F7DF D0 06       BNE $06    [$F7E7]     ;/
$91:F7E1 A9 02 00    LDA #$0002             ;\
$91:F7E4 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = decelerating

$91:F7E7 9C D4 0C    STZ $0CD4  [$7E:0CD4]  ; Bomb spread charge timeout counter = 0
$91:F7EA 18          CLC                    ;\
$91:F7EB 60          RTS                    ;} Return carry clear

; BRANCH_NO_MORPH_BALL
$91:F7EC AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F7EF 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = [Samus previous pose]
$91:F7F2 38          SEC                    ;\
$91:F7F3 60          RTS                    ;} Return carry set
}


;;; $F7F4: Initialise Samus pose - unused pose 39h ;;;
{
$91:F7F4 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F7F7 29 FF 00    AND #$00FF             ;|
$91:F7FA C9 08 00    CMP #$0008             ;} If [Samus previous movement type] = morph ball - falling: go to BRANCH_WAS_FALLING
$91:F7FD F0 22       BEQ $22    [$F821]     ;/
$91:F7FF C9 13 00    CMP #$0013             ;\
$91:F802 F0 1D       BEQ $1D    [$F821]     ;} If [Samus previous movement type] = spring ball - falling: go to BRANCH_WAS_FALLING
$91:F804 AD A2 09    LDA $09A2  [$7E:09A2]
$91:F807 89 00 00    BIT #$0000             ;\
$91:F80A D0 32       BNE $32    [$F83E]     ;} >_<;
$91:F80C 89 02 00    BIT #$0002             ;\
$91:F80F D0 08       BNE $08    [$F819]     ;} If spring ball not equipped:
$91:F811 A9 1D 00    LDA #$001D             ;\
$91:F814 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - no springball - on ground
$91:F817 80 23       BRA $23    [$F83C]     ; Return carry set

$91:F819 A9 79 00    LDA #$0079             ;\
$91:F81C 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - spring ball - on ground
$91:F81F 80 1B       BRA $1B    [$F83C]     ; Return carry set

; BRANCH_WAS_FALLING
$91:F821 AD A2 09    LDA $09A2  [$7E:09A2]
$91:F824 89 00 00    BIT #$0000             ;\
$91:F827 D0 15       BNE $15    [$F83E]     ;} >_<;
$91:F829 89 02 00    BIT #$0002             ;\
$91:F82C D0 08       BNE $08    [$F836]     ;} If spring ball not equipped:
$91:F82E A9 31 00    LDA #$0031             ;\
$91:F831 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - no springball - in air
$91:F834 80 06       BRA $06    [$F83C]     ; Return carry set

$91:F836 A9 7D 00    LDA #$007D             ;\
$91:F839 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - morph ball - spring ball - falling

$91:F83C 38          SEC                    ;\
$91:F83D 60          RTS                    ;} Return carry set

$91:F83E 18          CLC
$91:F83F 60          RTS
}


;;; $F840: Initialise Samus pose - unused pose 3Ah ;;;
{
$91:F840 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F843 29 FF 00    AND #$00FF             ;|
$91:F846 C9 08 00    CMP #$0008             ;} If [Samus previous movement type] = morph ball - falling: go to BRANCH_WAS_FALLING
$91:F849 F0 22       BEQ $22    [$F86D]     ;/
$91:F84B C9 13 00    CMP #$0013             ;\
$91:F84E F0 1D       BEQ $1D    [$F86D]     ;} If [Samus previous movement type] = spring ball - falling: go to BRANCH_WAS_FALLING
$91:F850 AD A2 09    LDA $09A2  [$7E:09A2]
$91:F853 89 00 00    BIT #$0000             ;\
$91:F856 D0 32       BNE $32    [$F88A]     ;} >_<;
$91:F858 89 02 00    BIT #$0002             ;\
$91:F85B D0 08       BNE $08    [$F865]     ;} If spring ball not equipped:
$91:F85D A9 41 00    LDA #$0041             ;\
$91:F860 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - morph ball - no springball - on ground
$91:F863 80 23       BRA $23    [$F888]     ; Return carry set

$91:F865 A9 7A 00    LDA #$007A             ;\
$91:F868 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - morph ball - spring ball - on ground
$91:F86B 80 1B       BRA $1B    [$F888]     ; Return carry set

; BRANCH_WAS_FALLING
$91:F86D AD A2 09    LDA $09A2  [$7E:09A2]
$91:F870 89 00 00    BIT #$0000             ;\
$91:F873 D0 15       BNE $15    [$F88A]     ;} >_<;
$91:F875 89 02 00    BIT #$0002             ;\
$91:F878 D0 08       BNE $08    [$F882]     ;} If spring ball not equipped:
$91:F87A A9 32 00    LDA #$0032             ;\
$91:F87D 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - morph ball - no springball - in air
$91:F880 80 06       BRA $06    [$F888]     ; Return carry set

$91:F882 A9 7E 00    LDA #$007E             ;\
$91:F885 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - morph ball - spring ball - falling

$91:F888 38          SEC                    ;\
$91:F889 60          RTS                    ;} Return carry set

$91:F88A 18          CLC
$91:F88B 60          RTS
}


;;; $F88C: Initialise Samus pose - moonwalking ;;;
{
$91:F88C AD E4 09    LDA $09E4  [$7E:09E4]  ;\
$91:F88F F0 02       BEQ $02    [$F893]     ;} If moonwalk enabled:
$91:F891 18          CLC                    ;\
$91:F892 60          RTS                    ;} Return carry clear

$91:F893 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:F896 29 FF 00    AND #$00FF             ;|
$91:F899 C9 04 00    CMP #$0004             ;} If facing right:
$91:F89C F0 08       BEQ $08    [$F8A6]     ;/
$91:F89E A9 26 00    LDA #$0026             ;\
$91:F8A1 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - turning - standing
$91:F8A4 80 06       BRA $06    [$F8AC]

$91:F8A6 A9 25 00    LDA #$0025             ;\ Else (facing left):
$91:F8A9 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - turning - standing

$91:F8AC 38          SEC                    ;\
$91:F8AD 60          RTS                    ;} Return carry set
}


;;; $F8AE: Initialise Samus pose - damage boost ;;;
{
; Looks like a BRA past leftover code to me

$91:F8AE 80 1B       BRA $1B    [$F8CB]     ; Go to BRANCH_NEW_IMPL
$91:F8B0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:F8B3 29 FF 00    AND #$00FF             ;|
$91:F8B6 C9 04 00    CMP #$0004             ;} If facing right:
$91:F8B9 F0 08       BEQ $08    [$F8C3]     ;/
$91:F8BB A9 53 00    LDA #$0053             ;\
$91:F8BE 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - knockback
$91:F8C1 80 06       BRA $06    [$F8C9]

$91:F8C3 A9 54 00    LDA #$0054             ;\ Else (facing left):
$91:F8C6 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left  - knockback

$91:F8C9 38          SEC                    ;\
$91:F8CA 60          RTS                    ;} Return carry set

; BRANCH_NEW_IMPL
$91:F8CB A9 37 A3    LDA #$A337             ;\
$91:F8CE 8D 58 0A    STA $0A58  [$7E:0A58]  ;} Samus movement handler = $A337 (normal)
$91:F8D1 18          CLC                    ;\
$91:F8D2 60          RTS                    ;} Return carry clear
}


;;; $F8D3: Initialise Samus pose - turning around - on ground ;;;
{
$91:F8D3 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F8D6 F0 59       BEQ $59    [$F931]     ;|
$91:F8D8 C9 9B 00    CMP #$009B             ;} If [Samus previous pose] = facing forward: go to BRANCH_DONE
$91:F8DB F0 54       BEQ $54    [$F931]     ;/
$91:F8DD 0A          ASL A                  ;\
$91:F8DE 0A          ASL A                  ;|
$91:F8DF 0A          ASL A                  ;|
$91:F8E0 AA          TAX                    ;} X = [$B62C + [Samus previous pose] * 8] (direction shots are fired)
$91:F8E1 BD 2C B6    LDA $B62C,x[$91:B674]  ;|
$91:F8E4 29 FF 00    AND #$00FF             ;|
$91:F8E7 AA          TAX                    ;/
$91:F8E8 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F8EB 29 FF 00    AND #$00FF             ;|
$91:F8EE C9 10 00    CMP #$0010             ;} If [Samus previous movement type] = moonwalking:
$91:F8F1 D0 25       BNE $25    [$F918]     ;/
$91:F8F3 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F8F6 0A          ASL A                  ;|
$91:F8F7 0A          ASL A                  ;|
$91:F8F8 0A          ASL A                  ;|
$91:F8F9 A8          TAY                    ;} Pose transition shot direction = [$B62C + [Samus previous pose] * 8] (direction shots are fired) | 100h
$91:F8FA B9 2C B6    LDA $B62C,y[$91:B874]  ;|
$91:F8FD 29 FF 00    AND #$00FF             ;|
$91:F900 09 00 01    ORA #$0100             ;|
$91:F903 8D 5E 0B    STA $0B5E  [$7E:0B5E]  ;/
$91:F906 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:F908 2C B4 09    BIT $09B4  [$7E:09B4]  ;} If not pressing jump: go to BRANCH_STANDING
$91:F90B F0 10       BEQ $10    [$F91D]     ;/
$91:F90D BD EA F9    LDA $F9EA,x[$91:F9F1]  ;\
$91:F910 29 FF 00    AND #$00FF             ;} Samus pose = [$F9EA + [X]]
$91:F913 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;/
$91:F916 80 19       BRA $19    [$F931]     ; Go to BRANCH_DONE

$91:F918 C9 05 00    CMP #$0005             ;\
$91:F91B F0 0B       BEQ $0B    [$F928]     ;} If [Samus previous movement type] = crouching: go to BRANCH_CROUCHING

; BRANCH_STANDING
$91:F91D BD C2 F9    LDA $F9C2,x[$91:F9C4]  ;\
$91:F920 29 FF 00    AND #$00FF             ;} Samus pose = [$F9C2 + [X]]
$91:F923 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;/
$91:F926 80 09       BRA $09    [$F931]     ; Go to BRANCH_DONE

; BRANCH_CROUCHING
$91:F928 BD CC F9    LDA $F9CC,x[$91:F9CE]  ;\
$91:F92B 29 FF 00    AND #$00FF             ;} Samus pose = [$F9CC + [X]]
$91:F92E 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;/

; BRANCH_DONE
$91:F931 AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$91:F934 18          CLC                    ;|
$91:F935 6D 48 0B    ADC $0B48  [$7E:0B48]  ;|
$91:F938 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [Samus X extra run speed]
$91:F93B AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$91:F93E 6D 46 0B    ADC $0B46  [$7E:0B46]  ;|
$91:F941 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$91:F944 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:F947 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:F94A A9 01 00    LDA #$0001             ;\
$91:F94D 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = turning around
$91:F950 38          SEC                    ;\
$91:F951 60          RTS                    ;} Return carry set
}


;;; $F952: Initialise Samus pose - turning around - jumping ;;;
{
$91:F952 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F955 0A          ASL A                  ;|
$91:F956 0A          ASL A                  ;|
$91:F957 0A          ASL A                  ;|
$91:F958 AA          TAX                    ;} X = [$B62C + [Samus previous pose] * 8] (direction shots are fired)
$91:F959 BD 2C B6    LDA $B62C,x[$91:B8BC]  ;|
$91:F95C 29 FF 00    AND #$00FF             ;|
$91:F95F AA          TAX                    ;/
$91:F960 BD D6 F9    LDA $F9D6,x[$91:F9DD]  ;\
$91:F963 29 FF 00    AND #$00FF             ;} Samus pose = [$F9D6 + [X]]
$91:F966 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;/
$91:F969 AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$91:F96C 18          CLC                    ;|
$91:F96D 6D 48 0B    ADC $0B48  [$7E:0B48]  ;|
$91:F970 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [Samus X extra run speed]
$91:F973 AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$91:F976 6D 46 0B    ADC $0B46  [$7E:0B46]  ;|
$91:F979 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$91:F97C 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:F97F 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:F982 A9 01 00    LDA #$0001             ;\
$91:F985 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = turning around
$91:F988 38          SEC                    ;\
$91:F989 60          RTS                    ;} Return carry set
}


;;; $F98A: Initialise Samus pose - turning around - falling ;;;
{
$91:F98A AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:F98D 0A          ASL A                  ;|
$91:F98E 0A          ASL A                  ;|
$91:F98F 0A          ASL A                  ;|
$91:F990 AA          TAX                    ;} X = [$B62C + [Samus previous pose] * 8] (direction shots are fired)
$91:F991 BD 2C B6    LDA $B62C,x[$91:B774]  ;|
$91:F994 29 FF 00    AND #$00FF             ;|
$91:F997 AA          TAX                    ;/
$91:F998 BD E0 F9    LDA $F9E0,x[$91:F9E2]  ;\
$91:F99B 29 FF 00    AND #$00FF             ;} Samus pose = [$F9E0 + [X]]
$91:F99E 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;/
$91:F9A1 AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$91:F9A4 18          CLC                    ;|
$91:F9A5 6D 48 0B    ADC $0B48  [$7E:0B48]  ;|
$91:F9A8 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [Samus X extra run speed]
$91:F9AB AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$91:F9AE 6D 46 0B    ADC $0B46  [$7E:0B46]  ;|
$91:F9B1 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$91:F9B4 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:F9B7 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:F9BA A9 01 00    LDA #$0001             ;\
$91:F9BD 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = turning around
$91:F9C0 38          SEC                    ;\
$91:F9C1 60          RTS                    ;} Return carry set
}


;;; $F9C2: Turning Samus poses ;;;
{
;                        _____________________________________ Up, facing right
;                       |    _________________________________ Up-right
;                       |   |    _____________________________ Right
;                       |   |   |    _________________________ Down-right, facing right
;                       |   |   |   |    _____________________ Down-right, facing left
;                       |   |   |   |   |    _________________ Down-left
;                       |   |   |   |   |   |    _____________ Down-left
;                       |   |   |   |   |   |   |    _________ Left
;                       |   |   |   |   |   |   |   |    _____ Up-left
;                       |   |   |   |   |   |   |   |   |    _ Up, facing left
;                       |   |   |   |   |   |   |   |   |   |
$91:F9C2             db 8B, 9C, 25, 8D, 8D, 8E, 8E, 26, 9D, 8C ; Standing
$91:F9CC             db 97, A2, 43, 99, 99, 9A, 9A, 44, A3, 98 ; Crouching
$91:F9D6             db 8F, 9E, 2F, 91, 91, 92, 92, 30, 9F, 90 ; Jumping / in air
$91:F9E0             db 93, A0, 87, 95, 95, 96, 96, 88, A1, 94 ; Falling
$91:F9EA             db C1, C1, BF, C3, 8D, 8E, C4, C0, C2, C2 ; Moonwalk
}


;;; $F9F4: Initialise Samus pose - morph ball ;;;
{
$91:F9F4 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:F9F7 29 FF 00    AND #$00FF             ;|
$91:F9FA C9 04 00    CMP #$0004             ;} If [Samus previous movement type] != morph ball - on ground:
$91:F9FD F0 05       BEQ $05    [$FA04]     ;/
$91:F9FF C9 08 00    CMP #$0008             ;\
$91:FA02 D0 06       BNE $06    [$FA0A]     ;} If [Samus previous movement type] != morph ball - falling: go to BRANCH_WAS_NOT_MORPH_BALL

$91:FA04 A9 00 80    LDA #$8000             ;\
$91:FA07 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 8000h (preserve animation frame)

; BRANCH_WAS_NOT_MORPH_BALL
$91:FA0A 20 0F FA    JSR $FA0F  [$91:FA0F]  ; Apply momentum if turning in morph ball
$91:FA0D 18          CLC                    ;\
$91:FA0E 60          RTS                    ;} Return carry clear
}


;;; $FA0F: Apply momentum if turning in morph ball ;;;
{
$91:FA0F AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:FA12 29 FF 00    AND #$00FF             ;|
$91:FA15 C9 08 00    CMP #$0008             ;|
$91:FA18 F0 0D       BEQ $0D    [$FA27]     ;|
$91:FA1A AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;|
$91:FA1D 29 FF 00    AND #$00FF             ;|
$91:FA20 C9 08 00    CMP #$0008             ;|
$91:FA23 F0 0D       BEQ $0D    [$FA32]     ;} If [Samus previous pose X direction] = [Samus pose X direction]: return
$91:FA25 80 2E       BRA $2E    [$FA55]     ;|
                                            ;|
$91:FA27 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;|
$91:FA2A 29 FF 00    AND #$00FF             ;|
$91:FA2D C9 04 00    CMP #$0004             ;|
$91:FA30 D0 23       BNE $23    [$FA55]     ;/

$91:FA32 AD 44 0B    LDA $0B44  [$7E:0B44]  ;\
$91:FA35 18          CLC                    ;|
$91:FA36 6D 48 0B    ADC $0B48  [$7E:0B48]  ;|
$91:FA39 8D 48 0B    STA $0B48  [$7E:0B48]  ;} Samus X base speed += [Samus X extra run speed]
$91:FA3C AD 42 0B    LDA $0B42  [$7E:0B42]  ;|
$91:FA3F 6D 46 0B    ADC $0B46  [$7E:0B46]  ;|
$91:FA42 8D 46 0B    STA $0B46  [$7E:0B46]  ;/
$91:FA45 22 53 DE 91 JSL $91DE53[$91:DE53]  ; Cancel speed boosting
$91:FA49 9C 44 0B    STZ $0B44  [$7E:0B44]  ;\
$91:FA4C 9C 42 0B    STZ $0B42  [$7E:0B42]  ;} Samus X extra run speed = 0.0
$91:FA4F A9 01 00    LDA #$0001             ;\
$91:FA52 8D 4A 0B    STA $0B4A  [$7E:0B4A]  ;} Samus X acceleration mode = turning around

$91:FA55 60          RTS
}


;;; $FA56: Initialise Samus pose - spring ball ;;;
{
$91:FA56 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:FA59 29 FF 00    AND #$00FF             ;|
$91:FA5C C9 11 00    CMP #$0011             ;} If [Samus previous movement type] != spring ball - on ground:
$91:FA5F F0 0A       BEQ $0A    [$FA6B]     ;/
$91:FA61 C9 12 00    CMP #$0012             ;\
$91:FA64 F0 05       BEQ $05    [$FA6B]     ;} If [Samus previous movement type] != spring ball - in air:
$91:FA66 C9 13 00    CMP #$0013             ;\
$91:FA69 D0 06       BNE $06    [$FA71]     ;} If [Samus previous movement type] != spring ball - falling: go to BRANCH_WAS_NOT_SPRING_BALL

$91:FA6B A9 00 80    LDA #$8000             ;\
$91:FA6E 8D 9A 0A    STA $0A9A  [$7E:0A9A]  ;} New pose Samus animation frame = 8000h (preserve animation frame)

; BRANCH_WAS_NOT_SPRING_BALL
$91:FA71 20 0F FA    JSR $FA0F  [$91:FA0F]  ; Apply momentum if turning in morph ball
$91:FA74 18          CLC                    ;\
$91:FA75 60          RTS                    ;} Return carry clear
}


;;; $FA76: Initialise Samus pose - wall jumping ;;;
{
$91:FA76 22 3E EC 90 JSL $90EC3E[$90:EC3E]  ; $12 = Samus bottom boundary
$91:FA7A AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:FA7D 30 0E       BMI $0E    [$FA8D]     ;} If [FX Y position] >= 0:
$91:FA7F C5 12       CMP $12    [$7E:0012]  ;\
$91:FA81 10 13       BPL $13    [$FA96]     ;} If [FX Y position] >= (Samus bottom boundary): go to BRANCH_NON_LIQUID_PHYSICS
$91:FA83 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:FA86 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NON_LIQUID_PHYSICS
$91:FA89 D0 0B       BNE $0B    [$FA96]     ;/
$91:FA8B 80 3B       BRA $3B    [$FAC8]     ; Return carry clear

$91:FA8D AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$91:FA90 30 04       BMI $04    [$FA96]     ;} If [lava/acid Y position] < 0: go to BRANCH_NON_LIQUID_PHYSICS
$91:FA92 C5 12       CMP $12    [$7E:0012]  ;\
$91:FA94 30 32       BMI $32    [$FAC8]     ;} If [lava/acid Y position] < (Samus bottom boundary): return carry clear

; BRANCH_NON_LIQUID_PHYSICS
$91:FA96 A9 00 06    LDA #$0600             ;\
$91:FA99 8D F2 0A    STA $0AF2  [$7E:0AF2]  ;} Atmospheric graphics 3 animation frame = 0, type = dust due to landing
$91:FA9C A9 03 00    LDA #$0003             ;\
$91:FA9F 8D DA 0A    STA $0ADA  [$7E:0ADA]  ;} Atmospheric graphics 3 animation timer = 3
$91:FAA2 A5 12       LDA $12    [$7E:0012]  ;\
$91:FAA4 8D EA 0A    STA $0AEA  [$7E:0AEA]  ;} Atmospheric graphics 3 Y position = (Samus bottom boundary)
$91:FAA7 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:FAAA 29 FF 00    AND #$00FF             ;|
$91:FAAD C9 08 00    CMP #$0008             ;} If facing left:
$91:FAB0 F0 0C       BEQ $0C    [$FABE]     ;/
$91:FAB2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:FAB5 18          CLC                    ;|
$91:FAB6 69 06 00    ADC #$0006             ;} Atmospheric graphics 3 X position = [Samus X position] + 6
$91:FAB9 8D E2 0A    STA $0AE2  [$7E:0AE2]  ;/
$91:FABC 18          CLC                    ;\
$91:FABD 60          RTS                    ;} Return carry clear

$91:FABE AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$91:FAC1 38          SEC                    ;|
$91:FAC2 E9 06 00    SBC #$0006             ;} Atmospheric graphics 3 X position = [Samus X position] - 6
$91:FAC5 8D E2 0A    STA $0AE2  [$7E:0AE2]  ;/

$91:FAC8 18          CLC                    ;\
$91:FAC9 60          RTS                    ;} Return carry clear
}


;;; $FACA: Initialise Samus pose - shinespark / crystal flash / drained by metroid / damaged by MB's attacks ;;;
{
; Need to check what happens with poses C7h/C8h (vertical shinespark windup)
$91:FACA AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FACD C9 CF 00    CMP #$00CF             ;} If [Samus pose] = shinespark:
$91:FAD0 10 28       BPL $28    [$FAFA]     ;/
$91:FAD2 38          SEC                    ;\
$91:FAD3 E9 C9 00    SBC #$00C9             ;|
$91:FAD6 0A          ASL A                  ;|
$91:FAD7 AA          TAX                    ;} Samus movement handler = [$FAFC + [Samus pose] - C9h]
$91:FAD8 BD FC FA    LDA $FAFC,x[$91:FAFC]  ;|
$91:FADB 8D 58 0A    STA $0A58  [$7E:0A58]  ;/
$91:FADE A9 0E E9    LDA #$E90E             ;\
$91:FAE1 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS
$91:FAE4 9C AE 0A    STZ $0AAE  [$7E:0AAE]  ; Speed echoes index = 0
$91:FAE7 9C C0 0A    STZ $0AC0  [$7E:0AC0]  ;\
$91:FAEA 9C C2 0A    STZ $0AC2  [$7E:0AC2]  ;} Speed echo X speeds = 0
$91:FAED 9C B0 0A    STZ $0AB0  [$7E:0AB0]  ;\
$91:FAF0 9C B2 0A    STZ $0AB2  [$7E:0AB2]  ;} Speed echo X positions = 0
$91:FAF3 A9 0F 00    LDA #$000F             ;\
$91:FAF6 22 2F 91 80 JSL $80912F[$80:912F]  ;} Queue sound Fh, sound library 3, max queued sounds allowed = 9 (shinespark)

$91:FAFA 18          CLC                    ;\
$91:FAFB 60          RTS                    ;} Return carry clear

$91:FAFC             dw D106, ; C9h: Facing right - shinespark - horizontal
                        D106, ; CAh: Facing left  - shinespark - horizontal
                        D0AB, ; CBh: Facing right - shinespark - vertical
                        D0AB, ; CCh: Facing left  - shinespark - vertical
                        D0D7, ; CDh: Facing right - shinespark - diagonal
                        D0D7  ; CEh: Facing left  - shinespark - diagonal
}
}


;;; $FB08: Set Samus animation frame if pose changed ;;;
{
$91:FB08 08          PHP
$91:FB09 8B          PHB
$91:FB0A 4B          PHK                    ;\
$91:FB0B AB          PLB                    ;} DB = $91
$91:FB0C C2 30       REP #$30
$91:FB0E AD A2 09    LDA $09A2  [$7E:09A2]  ;\
$91:FB11 89 20 00    BIT #$0020             ;} If gravity suit equipped: go to BRANCH_NORMAL_GRAVITY
$91:FB14 D0 29       BNE $29    [$FB3F]     ;/
$91:FB16 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FB19 0A          ASL A                  ;|
$91:FB1A 0A          ASL A                  ;|
$91:FB1B 0A          ASL A                  ;|
$91:FB1C AA          TAX                    ;|
$91:FB1D BF 2F B6 91 LDA $91B62F,x[$91:B63F];} $12 = [Samus Y position] + [$91:B62F + [Samus pose] * 8] - 1 (Samus bottom boundary)
$91:FB21 29 FF 00    AND #$00FF             ;|
$91:FB24 18          CLC                    ;|
$91:FB25 6D FA 0A    ADC $0AFA  [$7E:0AFA]  ;|
$91:FB28 3A          DEC A                  ;|
$91:FB29 85 12       STA $12    [$7E:0012]  ;/
$91:FB2B AD 5E 19    LDA $195E  [$7E:195E]  ;\
$91:FB2E 30 06       BMI $06    [$FB36]     ;} If [FX Y position] >= 0:
$91:FB30 C5 12       CMP $12    [$7E:0012]  ;\
$91:FB32 30 12       BMI $12    [$FB46]     ;} If [FX Y position] < (Samus bottom boundary): go to BRANCH_SUBMERGED_IN_WATER
$91:FB34 80 09       BRA $09    [$FB3F]

$91:FB36 AD 62 19    LDA $1962  [$7E:1962]  ;\ Else ([FX Y position] < 0):
$91:FB39 30 04       BMI $04    [$FB3F]     ;} If [lava/acid Y position] >= 0:
$91:FB3B C5 12       CMP $12    [$7E:0012]  ;\
$91:FB3D 30 17       BMI $17    [$FB56]     ;} If [lava/acid Y position] < [Samus bottom boundary]: go to BRANCH_SUBMERGED_IN_ACID_LAVA

; BRANCH_NORMAL_GRAVITY
$91:FB3F AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$91:FB42 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus X speed divisor]
$91:FB44 80 16       BRA $16    [$FB5C]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_WATER
$91:FB46 AD 7E 19    LDA $197E  [$7E:197E]  ;\
$91:FB49 89 04 00    BIT #$0004             ;} If liquid physics are disabled: go to BRANCH_NORMAL_GRAVITY
$91:FB4C D0 F1       BNE $F1    [$FB3F]     ;/
$91:FB4E AF 93 9E 90 LDA $909E93[$90:9E93]  ;\
$91:FB52 85 12       STA $12    [$7E:0012]  ;} $12 = 3 (Samus animation delay in water)
$91:FB54 80 06       BRA $06    [$FB5C]     ; Go to BRANCH_MERGE

; BRANCH_SUBMERGED_IN_ACID_LAVA
$91:FB56 AF 95 9E 90 LDA $909E95[$90:9E95]  ;\
$91:FB5A 85 12       STA $12    [$7E:0012]  ;} $12 = 2 (Samus animation delay in lava/acid)

; BRANCH_MERGE
$91:FB5C AD 9A 0A    LDA $0A9A  [$7E:0A9A]  ;\
$91:FB5F 30 2A       BMI $2A    [$FB8B]     ;} If [new pose Samus animation frame] & 8000h != 0: return
$91:FB61 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FB64 CD 20 0A    CMP $0A20  [$7E:0A20]  ;} If [Samus pose] = [Samus previous pose]: return
$91:FB67 F0 22       BEQ $22    [$FB8B]     ;/
$91:FB69 A9 00 00    LDA #$0000             ;\
$91:FB6C 18          CLC                    ;|
$91:FB6D 6D 9A 0A    ADC $0A9A  [$7E:0A9A]  ;} Samus animation frame = [new pose Samus animation frame]
$91:FB70 8D 96 0A    STA $0A96  [$7E:0A96]  ;/
$91:FB73 A8          TAY                    ;\
$91:FB74 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;|
$91:FB77 0A          ASL A                  ;|
$91:FB78 AA          TAX                    ;|
$91:FB79 98          TYA                    ;|
$91:FB7A 18          CLC                    ;|
$91:FB7B 7D 10 B0    ADC $B010,x[$91:B014]  ;} Samus animation frame timer = [$12] + [[$B010 + [Samus pose] * 2] + [Samus animation frame]]
$91:FB7E A8          TAY                    ;|
$91:FB7F B9 00 00    LDA $0000,y[$91:B298]  ;|
$91:FB82 29 FF 00    AND #$00FF             ;|
$91:FB85 18          CLC                    ;|
$91:FB86 65 12       ADC $12    [$7E:0012]  ;|
$91:FB88 8D 94 0A    STA $0A94  [$7E:0A94]  ;/

$91:FB8B AB          PLB
$91:FB8C 28          PLP
$91:FB8D 6B          RTL
}


;;; $FB8E:  ;;;
{
; Don't think this routine serves any purpose...
$91:FB8E 08          PHP
$91:FB8F 8B          PHB
$91:FB90 4B          PHK                    ;\
$91:FB91 AB          PLB                    ;} DB = $91
$91:FB92 C2 30       REP #$30
$91:FB94 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:FB97 29 FF 00    AND #$00FF             ;|
$91:FB9A C9 06 00    CMP #$0006             ;} If [Samus previous movement type] = falling: return
$91:FB9D F0 19       BEQ $19    [$FBB8]     ;/
$91:FB9F AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:FBA2 29 FF 00    AND #$00FF             ;|
$91:FBA5 C9 06 00    CMP #$0006             ;} If [Samus movement type] != falling:
$91:FBA8 F0 02       BEQ $02    [$FBAC]     ;/
$91:FBAA 80 0C       BRA $0C    [$FBB8]     ; Return

$91:FBAC 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ;\
$91:FBAF 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ;} Samus Y speed = 0.0
$91:FBB2 A9 02 00    LDA #$0002             ;\
$91:FBB5 8D 36 0B    STA $0B36  [$7E:0B36]  ;} Samus Y direction = down

$91:FBB8 AB          PLB
$91:FBB9 28          PLP
$91:FBBA 6B          RTL
}


;;; $FBBB..FCAE: Handle jump transition ;;;
{
;;; $FBBB: Handle jump transition ;;;
{
$91:FBBB 08          PHP
$91:FBBC 8B          PHB
$91:FBBD 4B          PHK                    ;\
$91:FBBE AB          PLB                    ;} DB = $91
$91:FBBF C2 30       REP #$30
$91:FBC1 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:FBC4 29 FF 00    AND #$00FF             ;|
$91:FBC7 0A          ASL A                  ;} Execute [$FBCF + [Samus movement type] * 2]
$91:FBC8 AA          TAX                    ;|
$91:FBC9 FC CF FB    JSR ($FBCF,x)[$91:FC07];/
$91:FBCC AB          PLB
$91:FBCD 28          PLP
$91:FBCE 6B          RTL

$91:FBCF             dw FC07, ;  0: Standing
                        FC07, ;  1: Running
                        FC66, ; *2: Normal jumping
                        FC99, ; *3: Spin jumping
                        FC07, ;  4: Morph ball - on ground
                        FC07, ;  5: Crouching
                        FC07, ;  6: Falling
                        FC07, ;  7: Unused
                        FC07, ;  8: Morph ball - falling
                        FC07, ;  9: Unused
                        FC07, ;  Ah: Knockback / crystal flash ending
                        FC07, ;  Bh: Unused
                        FC07, ;  Ch: Unused
                        FC42, ; *Dh: Unused
                        FC07, ;  Eh: Turning around - on ground
                        FC07, ;  Fh: Crouching/standing/morphing/unmorphing transition
                        FC07, ;  10h: Moonwalking
                        FC07, ;  11h: Spring ball - on ground
                        FC18, ; *12h: Spring ball - in air
                        FC07, ;  13h: Spring ball - falling
                        FC08, ; *14h: Wall jumping
                        FC07, ;  15h: Ran into a wall
                        FC07, ;  16h: Grappling
                        FC07, ;  17h: Turning around - jumping
                        FC07, ;  18h: Turning around - falling
                        FCAE, ;  19h: Damage boost
                        FC07, ;  1Ah: Grabbed by Draygon
                        FC07  ;  1Bh: Shinespark / crystal flash / drained by metroid / damaged by MB's attacks
}


;;; $FC07: RTS ;;;
{
$91:FC07 60          RTS
}


;;; $FC08: Handle jump transition - wall jumping ;;;
{
$91:FC08 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:FC0B 29 FF 00    AND #$00FF             ;|
$91:FC0E C9 14 00    CMP #$0014             ;} If [Samus previous movement type] = wall jumping: return
$91:FC11 F0 04       BEQ $04    [$FC17]     ;/

$91:FC13 22 49 99 90 JSL $909949[$90:9949]  ; Make Samus wall-jump

$91:FC17 60          RTS
}


;;; $FC18: Handle jump transition - spring ball - in air ;;;
{
$91:FC18 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FC1B C9 7F 00    CMP #$007F             ;} If [Samus pose] = facing right - morph ball - spring ball - in air:
$91:FC1E D0 0D       BNE $0D    [$FC2D]     ;/
$91:FC20 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:FC23 29 FF 00    AND #$00FF             ;|
$91:FC26 C9 11 00    CMP #$0011             ;} If [Samus previous movement type] != spring ball - on ground:
$91:FC29 F0 12       BEQ $12    [$FC3D]     ;/
$91:FC2B 80 14       BRA $14    [$FC41]     ; Return

$91:FC2D C9 80 00    CMP #$0080             ;\ Else ([Samus pose] != facing right - morph ball - spring ball - in air):
$91:FC30 D0 0F       BNE $0F    [$FC41]     ;} If [Samus pose] != facing left - morph ball - spring ball - in air: return
$91:FC32 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:FC35 29 FF 00    AND #$00FF             ;|
$91:FC38 C9 11 00    CMP #$0011             ;} If [Samus previous movement type] != spring ball - on ground: return
$91:FC3B D0 04       BNE $04    [$FC41]     ;/

$91:FC3D 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump

$91:FC41 60          RTS
}


;;; $FC42: Handle jump transition - Samus movement type Dh (unused) ;;;
{
$91:FC42 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FC45 C9 65 00    CMP #$0065             ;} If [Samus pose] = 65h (unused):
$91:FC48 D0 0A       BNE $0A    [$FC54]     ;/
$91:FC4A AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FC4D C9 64 00    CMP #$0064             ;} If [Samus previous pose] != 64h:
$91:FC50 F0 0F       BEQ $0F    [$FC61]     ;/
$91:FC52 80 11       BRA $11    [$FC65]     ; Return

$91:FC54 C9 66 00    CMP #$0066             ;\ Else ([Samus pose] != 65h):
$91:FC57 D0 0C       BNE $0C    [$FC65]     ;} If [Samus pose] != 66h (unused): return
$91:FC59 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FC5C C9 63 00    CMP #$0063             ;} If [Samus previous pose] != 63h: return
$91:FC5F D0 04       BNE $04    [$FC65]     ;/

$91:FC61 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump

$91:FC65 60          RTS
}


;;; $FC66: Handle jump transition - normal jumping ;;;
{
$91:FC66 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FC69 C9 4B 00    CMP #$004B             ;|
$91:FC6C F0 0F       BEQ $0F    [$FC7D]     ;|
$91:FC6E C9 4C 00    CMP #$004C             ;|
$91:FC71 F0 0A       BEQ $0A    [$FC7D]     ;} If [Samus pose] != normal jump transition: return
$91:FC73 C9 55 00    CMP #$0055             ;|
$91:FC76 30 20       BMI $20    [$FC98]     ;|
$91:FC78 C9 5B 00    CMP #$005B             ;|
$91:FC7B 10 1B       BPL $1B    [$FC98]     ;/

$91:FC7D AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FC80 C9 27 00    CMP #$0027             ;|
$91:FC83 F0 05       BEQ $05    [$FC8A]     ;} If [Samus previous pose] = crouching (and *not* aiming):
$91:FC85 C9 28 00    CMP #$0028             ;|
$91:FC88 D0 0A       BNE $0A    [$FC94]     ;/

$91:FC8A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:FC8D 38          SEC                    ;|
$91:FC8E E9 0A 00    SBC #$000A             ;} Samus Y position -= Ah (crouch jump boost)
$91:FC91 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/

$91:FC94 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump

$91:FC98 60          RTS
}


;;; $FC99: Handle jump transition - spin jumping ;;;
{
$91:FC99 AD 23 0A    LDA $0A23  [$7E:0A23]  ;\
$91:FC9C 29 FF 00    AND #$00FF             ;|
$91:FC9F C9 03 00    CMP #$0003             ;} If [Samus previous movement type] = spin jumping: return
$91:FCA2 F0 09       BEQ $09    [$FCAD]     ;/
$91:FCA4 C9 14 00    CMP #$0014             ;\
$91:FCA7 F0 04       BEQ $04    [$FCAD]     ;} If [Samus previous movement type] = wall jumping: return
$91:FCA9 22 BC 98 90 JSL $9098BC[$90:98BC]  ; Make Samus jump

$91:FCAD 60          RTS
}


;;; $FCAE: RTS ;;;
{
$91:FCAE 60          RTS
}
}


;;; $FCAF: X-ray Samus pose input handler ;;;
{
$91:FCAF 08          PHP
$91:FCB0 C2 30       REP #$30
$91:FCB2 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:FCB5 29 FF 00    AND #$00FF             ;|
$91:FCB8 C9 0E 00    CMP #$000E             ;} If [Samus movement type] = turning around - on ground:
$91:FCBB D0 03       BNE $03    [$FCC0]     ;/
$91:FCBD 4C 43 FD    JMP $FD43  [$91:FD43]  ; Go to BRANCH_TURNING_ON_GROUND

$91:FCC0 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:FCC3 29 FF 00    AND #$00FF             ;|
$91:FCC6 C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_NOT_TURNING_FACING_LEFT
$91:FCC9 F0 2C       BEQ $2C    [$FCF7]     ;/
$91:FCCB A5 8B       LDA $8B    [$7E:008B]  ;\
$91:FCCD 2C AE 09    BIT $09AE  [$7E:09AE]  ;} If not pressing left: return
$91:FCD0 F0 6F       BEQ $6F    [$FD41]     ;/
$91:FCD2 A9 00 01    LDA #$0100             ;\
$91:FCD5 38          SEC                    ;|
$91:FCD6 ED 82 0A    SBC $0A82  [$7E:0A82]  ;} X-ray angle = 100h - [x-ray angle]
$91:FCD9 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$91:FCDC AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:FCDF 29 FF 00    AND #$00FF             ;|
$91:FCE2 C9 05 00    CMP #$0005             ;} If [Samus movement type] != crouching:
$91:FCE5 F0 08       BEQ $08    [$FCEF]     ;/
$91:FCE7 A9 25 00    LDA #$0025             ;\
$91:FCEA 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - turning - standing
$91:FCED 80 32       BRA $32    [$FD21]     ; Go to BRANCH_NOT_TURNING_MERGE

$91:FCEF A9 43 00    LDA #$0043             ;\
$91:FCF2 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - turning - crouching
$91:FCF5 80 2A       BRA $2A    [$FD21]     ; Go to BRANCH_NOT_TURNING_MERGE

; BRANCH_NOT_TURNING_FACING_LEFT
$91:FCF7 A5 8B       LDA $8B    [$7E:008B]  ;\
$91:FCF9 2C B0 09    BIT $09B0  [$7E:09B0]  ;} If not pressing right: return
$91:FCFC F0 43       BEQ $43    [$FD41]     ;/
$91:FCFE A9 00 01    LDA #$0100             ;\
$91:FD01 38          SEC                    ;|
$91:FD02 ED 82 0A    SBC $0A82  [$7E:0A82]  ;} X-ray angle = 100h - [x-ray angle]
$91:FD05 8D 82 0A    STA $0A82  [$7E:0A82]  ;/
$91:FD08 AD 1F 0A    LDA $0A1F  [$7E:0A1F]  ;\
$91:FD0B 29 FF 00    AND #$00FF             ;|
$91:FD0E C9 05 00    CMP #$0005             ;} If [Samus movement type] != crouching:
$91:FD11 F0 08       BEQ $08    [$FD1B]     ;/
$91:FD13 A9 26 00    LDA #$0026             ;\
$91:FD16 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - turning - standing
$91:FD19 80 06       BRA $06    [$FD21]     ; Go to BRANCH_NOT_TURNING_MERGE

$91:FD1B A9 44 00    LDA #$0044             ;\ Else ([Samus movement type] = crouching):
$91:FD1E 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - turning - crouching

; BRANCH_NOT_TURNING_MERGE
$91:FD21 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:FD25 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:FD29 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FD2C 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:FD2F AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:FD32 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction / movement type]
$91:FD35 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FD38 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:FD3B AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:FD3E 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]

$91:FD41 28          PLP
$91:FD42 6B          RTL                    ; Return

; BRANCH_TURNING_ON_GROUND
$91:FD43 AD 96 0A    LDA $0A96  [$7E:0A96]  ;\
$91:FD46 C9 02 00    CMP #$0002             ;} If [Samus animation frame] != 2: return
$91:FD49 D0 61       BNE $61    [$FDAC]     ;/
$91:FD4B AD 94 0A    LDA $0A94  [$7E:0A94]  ;\
$91:FD4E C9 01 00    CMP #$0001             ;} If [Samus animation frame timer] != 1: return
$91:FD51 D0 59       BNE $59    [$FDAC]     ;/
$91:FD53 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:FD56 29 FF 00    AND #$00FF             ;|
$91:FD59 C9 04 00    CMP #$0004             ;} If facing left: go to BRANCH_TURNING_FACING_LEFT
$91:FD5C F0 18       BEQ $18    [$FD76]     ;/
$91:FD5E AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FD61 C9 26 00    CMP #$0026             ;} If [Samus pose] = facing left - turning - standing:
$91:FD64 D0 08       BNE $08    [$FD6E]     ;/
$91:FD66 A9 D5 00    LDA #$00D5             ;\
$91:FD69 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - x-ray - standing
$91:FD6C 80 1E       BRA $1E    [$FD8C]     ; Go to BRANCH_TURNING_MERGE

$91:FD6E A9 D9 00    LDA #$00D9             ;\
$91:FD71 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing right - x-ray - crouching
$91:FD74 80 16       BRA $16    [$FD8C]     ; Go to BRANCH_TURNING_MERGE

; BRANCH_TURNING_FACING_LEFT
$91:FD76 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FD79 C9 25 00    CMP #$0025             ;} If [Samus pose] = facing right - turning - standing:
$91:FD7C D0 08       BNE $08    [$FD86]     ;/
$91:FD7E A9 D6 00    LDA #$00D6             ;\
$91:FD81 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - x-ray - standing
$91:FD84 80 06       BRA $06    [$FD8C]     ; Go to BRANCH_TURNING_MERGE

$91:FD86 A9 DA 00    LDA #$00DA             ;\
$91:FD89 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = facing left - x-ray - crouching

; BRANCH_TURNING_MERGE
$91:FD8C 22 33 F4 91 JSL $91F433[$91:F433]  ; Initialise Samus pose
$91:FD90 22 08 FB 91 JSL $91FB08[$91:FB08]  ; Set Samus animation frame if pose changed
$91:FD94 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FD97 8D 24 0A    STA $0A24  [$7E:0A24]  ;} Samus last different pose = [Samus previous pose]
$91:FD9A AD 22 0A    LDA $0A22  [$7E:0A22]  ;\
$91:FD9D 8D 26 0A    STA $0A26  [$7E:0A26]  ;} Samus last different pose X direction / movement type = [Samus previous pose X direction /
$91:FDA0 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FDA3 8D 20 0A    STA $0A20  [$7E:0A20]  ;} Samus previous pose = [Samus pose]
$91:FDA6 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:FDA9 8D 22 0A    STA $0A22  [$7E:0A22]  ;} Samus previous pose X direction / movement type = [Samus pose X direction / movement type]

$91:FDAC 28          PLP
$91:FDAD 6B          RTL
}


;;; $FDAE..FFED: Handle collision due to change of pose ;;;
{
;;; $FDAE: Handle collision due to change of pose ;;;
{
; Does nothing if facing forward.

; Check for collisions with solid enemies and blocks due to change of pose,
; adjusts Samus Y position accordingly to be flush with any colliding boundaries.

; If Samus collides with surfaces in both above and below,
; attempts to put her in crouch (if not morphed) with position flush to bottom boundary,
; if morphed, disallows new pose.

; If Samus collides with surface either above or below,
; and Samus would collide with opposite surface due to position adjustment,
; new pose is disallowed.

; The result stored to $0DD0 is unused

$91:FDAE 08          PHP
$91:FDAF C2 30       REP #$30
$91:FDB1 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FDB4 F0 05       BEQ $05    [$FDBB]     ;|
$91:FDB6 C9 9B 00    CMP #$009B             ;} If not facing forward: go to BRANCH_NOT_FACING_FORWARD
$91:FDB9 D0 02       BNE $02    [$FDBD]     ;/

$91:FDBB 28          PLP
$91:FDBC 60          RTS                    ; Return

; BRANCH_NOT_FACING_FORWARD
$91:FDBD 9C 34 0A    STZ $0A34  [$7E:0A34]  ; Solid enemy collision flags = 0
$91:FDC0 9C 36 0A    STZ $0A36  [$7E:0A36]  ; Block collision flags = 0
$91:FDC3 AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FDC6 0A          ASL A                  ;|
$91:FDC7 0A          ASL A                  ;|
$91:FDC8 0A          ASL A                  ;|
$91:FDC9 AA          TAX                    ;} $12 = [$91:B62F + [Samus pose] * 8] (Y radius)
$91:FDCA BF 2F B6 91 LDA $91B62F,x[$91:B8CF];|
$91:FDCE 29 FF 00    AND #$00FF             ;|
$91:FDD1 85 12       STA $12    [$7E:0012]  ;/
$91:FDD3 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FDD6 0A          ASL A                  ;|
$91:FDD7 0A          ASL A                  ;|
$91:FDD8 0A          ASL A                  ;} A = [$91:B62F + [Samus previous pose] * 8] (previous pose Y radius)
$91:FDD9 AA          TAX                    ;|
$91:FDDA BF 2F B6 91 LDA $91B62F,x[$91:B63F];|
$91:FDDE 29 FF 00    AND #$00FF             ;/
$91:FDE1 C5 12       CMP $12    [$7E:0012]  ;\
$91:FDE3 30 02       BMI $02    [$FDE7]     ;} If [A] >= [$12]: (new radius is smaller)
$91:FDE5 28          PLP
$91:FDE6 60          RTS                    ; Return

$91:FDE7 8D 00 0B    STA $0B00  [$7E:0B00]  ; Samus Y radius = [A] (previous pose Y radius)
$91:FDEA A5 12       LDA $12    [$7E:0012]  ;\
$91:FDEC 38          SEC                    ;|
$91:FDED ED 00 0B    SBC $0B00  [$7E:0B00]  ;} Samus Y radius difference = [$12] - [Samus Y radius]
$91:FDF0 8D 3A 0A    STA $0A3A  [$7E:0A3A]  ;/
$91:FDF3 85 12       STA $12    [$7E:0012]  ; $12 = [Samus Y radius difference]
$91:FDF5 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FDF7 A9 02 00    LDA #$0002             ;\
$91:FDFA 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = up
$91:FDFD 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$91:FE01 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$91:FE04 AA          TAX                    ;\
$91:FE05 F0 06       BEQ $06    [$FE0D]     ;} If collision detected:
$91:FE07 A9 01 00    LDA #$0001             ;\
$91:FE0A 8D 34 0A    STA $0A34  [$7E:0A34]  ;} Solid enemy collision flags = 1 (collision from above)

$91:FE0D A5 12       LDA $12    [$7E:0012]  ;\
$91:FE0F 8D 3E 0A    STA $0A3E  [$7E:0A3E]  ;} $0A3E = [$12] (space to move Samus up)
$91:FE12 AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FE15 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus Y radius difference]
$91:FE17 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FE19 A9 03 00    LDA #$0003             ;\
$91:FE1C 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = down
$91:FE1F 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$91:FE23 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$91:FE26 AA          TAX                    ;\
$91:FE27 F0 09       BEQ $09    [$FE32]     ;} If collision detected:
$91:FE29 AD 34 0A    LDA $0A34  [$7E:0A34]  ;\
$91:FE2C 09 02 00    ORA #$0002             ;} Solid enemy collision flags |= 2 (collision from below)
$91:FE2F 8D 34 0A    STA $0A34  [$7E:0A34]  ;/

$91:FE32 A5 12       LDA $12    [$7E:0012]  ;\
$91:FE34 8D 40 0A    STA $0A40  [$7E:0A40]  ;} $0A40 = [$12] (space to move Samus down)
$91:FE37 AD 34 0A    LDA $0A34  [$7E:0A34]  ;\
$91:FE3A 0A          ASL A                  ;|
$91:FE3B AA          TAX                    ;} Execute [$FE8A + [solid enemy collision flags] * 2] (handle collisions with solid enemies)
$91:FE3C FC 8A FE    JSR ($FE8A,x)[$91:FE9A];/
$91:FE3F B0 41       BCS $41    [$FE82]     ; If carry set: go to BRANCH_REVERT_POSE
$91:FE41 AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FE44 49 FF FF    EOR #$FFFF             ;|
$91:FE47 1A          INC A                  ;} $12 = -[Samus Y radius difference]
$91:FE48 85 12       STA $12    [$7E:0012]  ;/
$91:FE4A 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FE4C 22 AB 96 94 JSL $9496AB[$94:96AB]  ; Block collision detection due to change of pose
$91:FE50 90 06       BCC $06    [$FE58]     ; If carry set: (collision detected)
$91:FE52 A9 01 00    LDA #$0001             ;\
$91:FE55 8D 36 0A    STA $0A36  [$7E:0A36]  ;} Block collision flags = 1 (collision from above)

$91:FE58 A5 12       LDA $12    [$7E:0012]  ;\
$91:FE5A 8D 38 0A    STA $0A38  [$7E:0A38]  ;} $0A38 = [$12] (space to move Samus up)
$91:FE5D AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FE60 85 12       STA $12    [$7E:0012]  ;} $12 = [Samus Y radius difference]
$91:FE62 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FE64 22 AB 96 94 JSL $9496AB[$94:96AB]  ; Block collision detection due to change of pose
$91:FE68 90 09       BCC $09    [$FE73]     ; If carry set: (collision detected)
$91:FE6A AD 36 0A    LDA $0A36  [$7E:0A36]  ;\
$91:FE6D 09 02 00    ORA #$0002             ;} Block collision flags |= 2 (collision from below)
$91:FE70 8D 36 0A    STA $0A36  [$7E:0A36]  ;/

$91:FE73 A5 12       LDA $12    [$7E:0012]  ;\
$91:FE75 8D 3C 0A    STA $0A3C  [$7E:0A3C]  ;} $0A3C = [$12] (space to move Samus down)
$91:FE78 AD 36 0A    LDA $0A36  [$7E:0A36]  ;\
$91:FE7B 0A          ASL A                  ;|
$91:FE7C AA          TAX                    ;} Execute [$FE92 + [block collision flags] * 2] (handle collisions with blocks)
$91:FE7D FC 92 FE    JSR ($FE92,x)[$91:FF49];/
$91:FE80 90 06       BCC $06    [$FE88]     ; If carry clear: return

; BRANCH_REVERT_POSE
$91:FE82 AD 20 0A    LDA $0A20  [$7E:0A20]  ;\
$91:FE85 8D 1C 0A    STA $0A1C  [$7E:0A1C]  ;} Samus pose = [Samus previous pose]

$91:FE88 28          PLP
$91:FE89 60          RTS

$91:FE8A             dw FE9A, FE9E, FEDF, FE9C
$91:FE92             dw FF76, FF20, FF49, FFA7
}


;;; $FE9A: Clear carry. Handle solid enemy collision due to pose change - no collision ;;;
{
$91:FE9A 18          CLC
$91:FE9B 60          RTS
}


;;; $FE9C: Clear carry. Handle solid enemy collision due to pose change - collision from both sides ;;;
{
$91:FE9C 18          CLC
$91:FE9D 60          RTS
}


;;; $FE9E: Handle solid enemy collision due to pose change - collision from above ;;;
{
;; Returns:
;;     Carry: Set if there's no space for Samus pose, clear otherwise

; The result stored to $0DD0 is unused

$91:FE9E AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FEA1 38          SEC                    ;|
$91:FEA2 ED 3E 0A    SBC $0A3E  [$7E:0A3E]  ;} $12 = [Samus Y radius difference] - [space to move Samus up] (distance to move down)
$91:FEA5 85 12       STA $12    [$7E:0012]  ;/
$91:FEA7 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FEA9 AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$91:FEAC 48          PHA                    ;} Push [Samus Y radius] (previous pose Y radius)
$91:FEAD AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FEB0 0A          ASL A                  ;|
$91:FEB1 0A          ASL A                  ;|
$91:FEB2 0A          ASL A                  ;|
$91:FEB3 AA          TAX                    ;} Samus Y radius = [$91:B62F + [Samus pose] * 8] (Y radius)
$91:FEB4 BF 2F B6 91 LDA $91B62F,x[$91:BB5F];|
$91:FEB8 29 FF 00    AND #$00FF             ;|
$91:FEBB 8D 00 0B    STA $0B00  [$7E:0B00]  ;/
$91:FEBE A9 03 00    LDA #$0003             ;\
$91:FEC1 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = down
$91:FEC4 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$91:FEC8 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$91:FECB AA          TAX                    ;\
$91:FECC D0 0B       BNE $0B    [$FED9]     ;} If collision not detected:
$91:FECE A5 12       LDA $12    [$7E:0012]  ;\
$91:FED0 8D 3E 0A    STA $0A3E  [$7E:0A3E]  ;} Space to move Samus up = [$12]
$91:FED3 68          PLA                    ;\
$91:FED4 8D 00 0B    STA $0B00  [$7E:0B00]  ;} Samus Y radius = (previous pose Y radius)
$91:FED7 18          CLC                    ;\
$91:FED8 60          RTS                    ;} Return carry clear

$91:FED9 68          PLA                    ;\
$91:FEDA 8D 00 0B    STA $0B00  [$7E:0B00]  ;} Samus Y radius = (previous pose Y radius)
$91:FEDD 38          SEC                    ;\
$91:FEDE 60          RTS                    ;} Return carry set
}


;;; $FEDF: Handle solid enemy collision due to pose change - collision from below ;;;
{
;; Returns:
;;     Carry: Set if there's no space for Samus pose, clear otherwise

; The result stored to $0DD0 is unused

$91:FEDF AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FEE2 38          SEC                    ;|
$91:FEE3 ED 40 0A    SBC $0A40  [$7E:0A40]  ;} $12 = [Samus Y radius difference] - [space to move Samus down]
$91:FEE6 85 12       STA $12    [$7E:0012]  ;/
$91:FEE8 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FEEA AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$91:FEED 48          PHA                    ;} Push [Samus Y radius] (previous pose Y radius)
$91:FEEE AD 1C 0A    LDA $0A1C  [$7E:0A1C]  ;\
$91:FEF1 0A          ASL A                  ;|
$91:FEF2 0A          ASL A                  ;|
$91:FEF3 0A          ASL A                  ;|
$91:FEF4 AA          TAX                    ;} Samus Y radius = [$91:B62F + [Samus pose] * 8] (Y radius)
$91:FEF5 BF 2F B6 91 LDA $91B62F,x[$91:BB57];|
$91:FEF9 29 FF 00    AND #$00FF             ;|
$91:FEFC 8D 00 0B    STA $0B00  [$7E:0B00]  ;/
$91:FEFF A9 02 00    LDA #$0002             ;\
$91:FF02 8D 02 0B    STA $0B02  [$7E:0B02]  ;} Collision direction = up
$91:FF05 22 F0 A8 A0 JSL $A0A8F0[$A0:A8F0]  ; Samus / solid enemy collision detection
$91:FF09 8D D0 0D    STA $0DD0  [$7E:0DD0]  ; Samus solid collision flag = FFFFh if solid enemy collision, 0 otherwise
$91:FF0C AA          TAX                    ;\
$91:FF0D D0 0B       BNE $0B    [$FF1A]     ;} If collision not detected:
$91:FF0F A5 12       LDA $12    [$7E:0012]  ;\
$91:FF11 8D 40 0A    STA $0A40  [$7E:0A40]  ;} Space to move Samus down = [$12]
$91:FF14 68          PLA                    ;\
$91:FF15 8D 00 0B    STA $0B00  [$7E:0B00]  ;} Samus Y radius = (previous pose Y radius)
$91:FF18 18          CLC                    ;\
$91:FF19 60          RTS                    ;} Return carry clear

$91:FF1A 68          PLA                    ;\
$91:FF1B 8D 00 0B    STA $0B00  [$7E:0B00]  ;} Samus Y radius = (previous pose Y radius)
$91:FF1E 38          SEC                    ;\
$91:FF1F 60          RTS                    ;} Return carry set
}


;;; $FF20: Handle block collision due to pose change - collision from above ;;;
{
$91:FF20 AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FF23 38          SEC                    ;|
$91:FF24 ED 38 0A    SBC $0A38  [$7E:0A38]  ;} $12 = [Samus Y radius difference] - [space to move Samus up]
$91:FF27 85 12       STA $12    [$7E:0012]  ;/
$91:FF29 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FF2B 22 AB 96 94 JSL $9496AB[$94:96AB]  ; Block collision detection due to change of pose
$91:FF2F B0 16       BCS $16    [$FF47]     ; If carry set (collision detected): return carry set
$91:FF31 AD 34 0A    LDA $0A34  [$7E:0A34]  ;\
$91:FF34 89 02 00    BIT #$0002             ;} If solid enemy collision from below: go to handle collision from both sides due to pose change
$91:FF37 D0 6E       BNE $6E    [$FFA7]     ;/
$91:FF39 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:FF3C 18          CLC                    ;|
$91:FF3D 65 12       ADC $12    [$7E:0012]  ;} Samus Y position += [$12] (align Samus top boundary with block)
$91:FF3F 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:FF42 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:FF45 18          CLC                    ;\
$91:FF46 60          RTS                    ;} Return carry clear

$91:FF47 38          SEC
$91:FF48 60          RTS
}


;;; $FF49: Handle block collision due to pose change - collision from below ;;;
{
$91:FF49 AD 3A 0A    LDA $0A3A  [$7E:0A3A]  ;\
$91:FF4C 38          SEC                    ;|
$91:FF4D ED 3C 0A    SBC $0A3C  [$7E:0A3C]  ;|
$91:FF50 49 FF FF    EOR #$FFFF             ;} $12 = [space to move Samus down] - [Samus Y radius difference]
$91:FF53 1A          INC A                  ;|
$91:FF54 85 12       STA $12    [$7E:0012]  ;/
$91:FF56 64 14       STZ $14    [$7E:0014]  ; $14 = 0
$91:FF58 22 AB 96 94 JSL $9496AB[$94:96AB]  ; Block collision detection due to change of pose
$91:FF5C B0 16       BCS $16    [$FF74]     ; If carry set (collision detected): return carry set
$91:FF5E AD 34 0A    LDA $0A34  [$7E:0A34]  ;\
$91:FF61 89 01 00    BIT #$0001             ;} If solid enemy collision from above: go to handle collision from both sides due to pose change
$91:FF64 D0 41       BNE $41    [$FFA7]     ;/
$91:FF66 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:FF69 38          SEC                    ;|
$91:FF6A E5 12       SBC $12    [$7E:0012]  ;} Samus Y position -= [$12] (align Samus bottom boundary with block)
$91:FF6C 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:FF6F 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:FF72 18          CLC                    ;\
$91:FF73 60          RTS                    ;} Return carry clear

$91:FF74 38          SEC
$91:FF75 60          RTS
}


;;; $FF76: Handle block collision due to pose change - no collision ;;;
{
$91:FF76 AD 34 0A    LDA $0A34  [$7E:0A34]  ;\
$91:FF79 0A          ASL A                  ;|
$91:FF7A AA          TAX                    ;} Execute [$FF7F + [solid enemy collision flags] * 2] (handle collisions with solid enemies)
$91:FF7B 7C 7F FF    JMP ($FF7F,x)[$91:FF87];/

$91:FF7E 60          RTS

$91:FF7F             dw FF87, FF89, FF98, FFA7
}


;;; $FF87: Clear carry. Handle block collision to pose change - no collision - no solid enemy collision ;;;
{
$91:FF87 18          CLC
$91:FF88 60          RTS
}


;;; $FF89: Handle block collision to pose change - no collision - solid enemy collision from above ;;;
{
$91:FF89 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:FF8C 18          CLC                    ;|
$91:FF8D 6D 3E 0A    ADC $0A3E  [$7E:0A3E]  ;} Samus Y position += [space to move Samus up due to solid enemy]
$91:FF90 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:FF93 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:FF96 18          CLC                    ;\
$91:FF97 60          RTS                    ;} Return carry clear
}


;;; $FF98: Handle block collision to pose change - no collision - solid enemy collision from below ;;;
{
$91:FF98 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:FF9B 38          SEC                    ;|
$91:FF9C ED 40 0A    SBC $0A40  [$7E:0A40]  ;} Samus Y position -= [space to move Samus down due to solid enemy]
$91:FF9F 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:FFA2 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]
$91:FFA5 18          CLC                    ;\
$91:FFA6 60          RTS                    ;} Return carry clear
}


;;; $FFA7: Handle collision from both sides due to pose change ;;;
{
$91:FFA7 AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$91:FFAA C9 08 00    CMP #$0008             ;} If [Samus Y radius] < 8: (if Samus is in morph ball, just deny the transition)
$91:FFAD 10 02       BPL $02    [$FFB1]     ;/
$91:FFAF 38          SEC                    ;\
$91:FFB0 60          RTS                    ;} Return carry set

$91:FFB1 AD 1E 0A    LDA $0A1E  [$7E:0A1E]  ;\
$91:FFB4 29 FF 00    AND #$00FF             ;|
$91:FFB7 C9 04 00    CMP #$0004             ;} If facing right:
$91:FFBA F0 05       BEQ $05    [$FFC1]     ;/
$91:FFBC A9 27 00    LDA #$0027             ; Samus pose = facing right - crouching
$91:FFBF 80 03       BRA $03    [$FFC4]

                                            ; Else (facing left):
$91:FFC1 A9 28 00    LDA #$0028             ; Samus pose = facing left - crouching

$91:FFC4 8D 1C 0A    STA $0A1C  [$7E:0A1C]
$91:FFC7 0A          ASL A                  ;\
$91:FFC8 0A          ASL A                  ;|
$91:FFC9 0A          ASL A                  ;|
$91:FFCA AA          TAX                    ;} $12 = [$91:B62F + [Samus pose] * 8] (Y radius)
$91:FFCB BF 2F B6 91 LDA $91B62F,x[$91:B767];|
$91:FFCF 29 FF 00    AND #$00FF             ;|
$91:FFD2 85 12       STA $12    [$7E:0012]  ;/
$91:FFD4 AD 00 0B    LDA $0B00  [$7E:0B00]  ;\
$91:FFD7 C5 12       CMP $12    [$7E:0012]  ;} If [$12] <= [Samus Y radius]: return carry clear
$91:FFD9 10 11       BPL $11    [$FFEC]     ;/
$91:FFDB 38          SEC                    ;\
$91:FFDC E5 12       SBC $12    [$7E:0012]  ;} $12 = [Samus Y radius] - [$12] (radius difference (negative))
$91:FFDE 85 12       STA $12    [$7E:0012]  ;/
$91:FFE0 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$91:FFE3 18          CLC                    ;|
$91:FFE4 65 12       ADC $12    [$7E:0012]  ;} Samus Y position += [$12] (move Samus up so that her bottom boundary position stays the same)
$91:FFE6 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$91:FFE9 8D 14 0B    STA $0B14  [$7E:0B14]  ; Samus previous Y position = [Samus Y position]

$91:FFEC 18          CLC                    ;\
$91:FFED 60          RTS                    ;} Return carry clear
}
}


;;; $FFEE: Free space ;;;
{
$91:FFEE             fillto $928000, $FF       ; Free space
}
