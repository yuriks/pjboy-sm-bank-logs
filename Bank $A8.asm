;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..8F8B: Evir ;;;
{
;;; $8687: Palette - enemy $E63F/$E67F (evir) ;;;
{
$A8:8687             dw 3800, 57FF, 42F7, 0929, 00A5, 4F5A, 36B5, 2610, 158C, 03FF, 02B9, 0170, 0069, 0BB1, 1EA9, 0145
}


;;; $86A7..878E: Instruction lists ;;;
{
;;; $86A7: Instruction list - evir body - facing left ;;;
{
$A8:86A7             dw 000A,8B59,
                        000A,8B88,
                        000A,8BB7,
                        000A,8BE6,
                        000A,8C15,
                        000A,8C44,
                        80ED,86A7   ; Go to $86A7
}


;;; $86C3: Instruction list - evir arms - facing left ;;;
{
$A8:86C3             dw 000A,8CA2,
                        000A,8CBD,
                        000A,8CD8,
                        000A,8CF3,
                        000A,8CA2,
                        000A,8CBD,
                        000A,8CD8,
                        000A,8CF3,
                        000A,8CA2,
                        000A,8CBD,
                        000A,8CD8,
                        000A,8CF3,
                        000A,8CA2,
                        000A,8CBD,
                        000A,8CD8,
                        000A,8CF3,
                        0030,8D13,
                        80ED,86C3   ; Go to $86C3
}


;;; $870B: Instruction list - evir body - facing right ;;;
{
$A8:870B             dw 000A,8D81,
                        000A,8DB0,
                        000A,8DDF,
                        000A,8E0E,
                        000A,8E3D,
                        000A,8E6C,
                        80ED,870B   ; Go to $870B
}


;;; $8727: Instruction list - evir arms - facing right ;;;
{
$A8:8727             dw 000A,8ECA,
                        000A,8EE5,
                        000A,8F00,
                        000A,8F1B,
                        000A,8ECA,
                        000A,8EE5,
                        000A,8F00,
                        000A,8F1B,
                        000A,8ECA,
                        000A,8EE5,
                        000A,8F00,
                        000A,8F1B,
                        000A,8ECA,
                        000A,8EE5,
                        000A,8F00,
                        000A,8F1B,
                        0030,8F3B,
                        80ED,8727   ; Go to $8727
}


;;; $876F: Instruction list - evir projectile - normal ;;;
{
$A8:876F             dw 0001,8D7A,
                        812F        ; Sleep
}


;;; $8775: Instruction list - evir projectile - regenerating ;;;
{
$A8:8775             dw 879B,       ; Set initial regeneration X offset
                        8123,0008,  ; Timer = 8
                        878F        ; Queue evir spit sound effect
$A8:877D             dw 0008,8D64,
                        87B6,       ; Advance regeneration X offset
                        8110,877D,  ; Decrement timer and go to $877D if non-zero
                        0010,8D7A,
                        87CB,       ; Finish regeneration
                        812F        ; Sleep
}
}


;;; $878F..DF: Instructions ;;;
{
;;; $878F: Instruction - queue evir spit sound effect ;;;
{
$A8:878F DA          PHX
$A8:8790 5A          PHY
$A8:8791 A9 5E 00    LDA #$005E             ;\
$A8:8794 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Eh, sound library 2, max queued sounds allowed = 6 (evir spit)
$A8:8798 7A          PLY
$A8:8799 FA          PLX
$A8:879A 6B          RTL
}


;;; $879B: Instruction - set initial regeneration X offset ;;;
{
$A8:879B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:879E BF 82 77 7E LDA $7E7782,x[$7E:7802];\
$A8:87A2 C9 0B 87    CMP #$870B             ;} If [enemy ([X] - 2) instruction list] != $870B: (facing left)
$A8:87A5 F0 08       BEQ $08    [$87AF]     ;/
$A8:87A7 A9 08 00    LDA #$0008             ;\
$A8:87AA 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;} Enemy regeneration X offset = 8
$A8:87AD 80 06       BRA $06    [$87B5]

$A8:87AF A9 F8 FF    LDA #$FFF8             ;\ Else ([enemy ([X] - 2) instruction list] = $870B (facing right)):
$A8:87B2 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy regeneration X offset = -8

$A8:87B5 6B          RTL
}


;;; $87B6: Instruction - advance regeneration X offset ;;;
{
$A8:87B6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:87B9 BF 82 77 7E LDA $7E7782,x[$7E:7802];\
$A8:87BD C9 0B 87    CMP #$870B             ;} If [enemy ([X] - 2) instruction list] != $870B: (facing left)
$A8:87C0 F0 05       BEQ $05    [$87C7]     ;/
$A8:87C2 DE B2 0F    DEC $0FB2,x[$7E:10F2]  ; Enemy regeneration X offset -= 1
$A8:87C5 80 03       BRA $03    [$87CA]
                                            ; Else ([enemy ([X] - 2) instruction list] = $870B (facing right)):
$A8:87C7 FE B2 0F    INC $0FB2,x[$7E:1032]  ; Enemy regeneration X offset += 1

$A8:87CA 6B          RTL
}


;;; $87CB: Instruction - finish regeneration ;;;
{
$A8:87CB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:87CE A9 00 00    LDA #$0000             ;\
$A8:87D1 9F 18 78 7E STA $7E7818,x[$7E:7898];} Enemy regenerating flag = 0
$A8:87D5 9F 16 78 7E STA $7E7816,x[$7E:7896]; Enemy moving flag = 0
$A8:87D9 A9 34 8A    LDA #$8A34             ;\
$A8:87DC 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy function = $8A34 (idle)
$A8:87DF 6B          RTL
}
}


;;; $87E0: Initialisation AI - enemy $E63F (evir) ;;;
{
$A8:87E0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:87E3 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:87E6 D0 35       BNE $35    [$881D]     ;} If [enemy parameter 1] = 0:
$A8:87E8 20 38 88    JSR $8838  [$A8:8838]  ; Set evir facing direction
$A8:87EB BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A8:87EE 29 FF 00    AND #$00FF             ;|
$A8:87F1 0A          ASL A                  ;|
$A8:87F2 0A          ASL A                  ;} Y = [enemy parameter 2 low] * 8 (linear speed table index)
$A8:87F3 0A          ASL A                  ;|
$A8:87F4 A8          TAY                    ;/
$A8:87F5 B9 87 81    LDA $8187,y[$A8:81C7]  ;\
$A8:87F8 9F 08 78 7E STA $7E7808,x[$7E:7808];|
$A8:87FC B9 89 81    LDA $8189,y[$A8:81C9]  ;} Enemy down velocity = [$8187 + [Y]].[$8187 + [Y] + 2]
$A8:87FF 9F 06 78 7E STA $7E7806,x[$7E:7806];/
$A8:8803 B9 8B 81    LDA $818B,y[$A8:81CB]  ;\
$A8:8806 9F 0C 78 7E STA $7E780C,x[$7E:780C];|
$A8:880A B9 8D 81    LDA $818D,y[$A8:81CD]  ;} Enemy up velocity = [$8187 + [Y] + 4].[$8187 + [Y] + 6]
$A8:880D 9F 0A 78 7E STA $7E780A,x[$7E:780A];/
$A8:8811 B9 B7 0F    LDA $0FB7,y[$7E:0FF7]  ;\
$A8:8814 29 FF 00    AND #$00FF             ;|
$A8:8817 4A          LSR A                  ;} Enemy movement timer = [enemy parameter 2 high] / 2
$A8:8818 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$A8:881B 80 09       BRA $09    [$8826]
                                            ; Else ([enemy parameter 1] != 0):
$A8:881D 20 66 88    JSR $8866  [$A8:8866]  ; Handle evir arms
$A8:8820 A9 04 00    LDA #$0004             ;\
$A8:8823 9D 9A 0F    STA $0F9A,x[$7E:0FDA]  ;} Enemy layer = 4

$A8:8826 A9 00 00    LDA #$0000             ;\
$A8:8829 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy movement direction = up
$A8:882D 9F 02 78 7E STA $7E7802,x[$7E:7802]; Enemy instruction list = 0
$A8:8831 A9 22 89    LDA #$8922             ;\
$A8:8834 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy function = $8922 (handle body/arms)
$A8:8837 6B          RTL
}


;;; $8838: Set evir facing direction ;;;
{
$A8:8838 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:883B 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:883F 10 08       BPL $08    [$8849]     ;} If [Samus X position] < [enemy X position]:
$A8:8841 A9 00 00    LDA #$0000             ;\
$A8:8844 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy facing direction = left
$A8:8847 80 06       BRA $06    [$884F]

$A8:8849 A9 01 00    LDA #$0001             ;\ Else ([Samus X position] >= [enemy X position])
$A8:884C 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy facing direction = right

$A8:884F A9 A7 86    LDA #$86A7             ;\
$A8:8852 9F 04 78 7E STA $7E7804,x[$7E:7804];} Enemy new instruction list = $86A7
$A8:8856 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:8859 F0 07       BEQ $07    [$8862]     ;} If [enemy facing direction] != left:
$A8:885B A9 0B 87    LDA #$870B             ;\
$A8:885E 9F 04 78 7E STA $7E7804,x[$7E:7804];} Enemy new instruction list = $870B

$A8:8862 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:8865 60          RTS
}


;;; $8866: Handle evir arms ;;;
{
$A8:8866 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8869 BD 6A 0F    LDA $0F6A,x[$7E:0FAA]  ;\
$A8:886C 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy facing direction = [enemy ([X] - 1) facing direction]
$A8:886F D0 20       BNE $20    [$8891]     ; If [enemy facing direction] = left:
$A8:8871 BD 3A 0F    LDA $0F3A,x[$7E:0F7A]  ;\
$A8:8874 38          SEC                    ;|
$A8:8875 E9 04 00    SBC #$0004             ;} Enemy X position = [enemy ([X] - 1) X position] - 4
$A8:8878 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$A8:887B BD 3E 0F    LDA $0F3E,x[$7E:0F7E]  ;\
$A8:887E 18          CLC                    ;|
$A8:887F 69 0A 00    ADC #$000A             ;} Enemy Y position = [enemy ([X] - 1) Y position] + Ah
$A8:8882 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:8885 A9 C3 86    LDA #$86C3             ;\
$A8:8888 9F 04 78 7E STA $7E7804,x[$7E:7844];} Enemy new instruction list = $86C3
$A8:888C 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:888F 80 1E       BRA $1E    [$88AF]

$A8:8891 BD 3A 0F    LDA $0F3A,x[$7E:0F7A]  ;\ Else ([enemy facing direction] = right):
$A8:8894 18          CLC                    ;|
$A8:8895 69 04 00    ADC #$0004             ;} Enemy X position = [enemy ([X] - 1) X position] + 4
$A8:8898 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$A8:889B BD 3E 0F    LDA $0F3E,x[$7E:0F7E]  ;\
$A8:889E 18          CLC                    ;|
$A8:889F 69 0A 00    ADC #$000A             ;} Enemy Y position = [enemy ([X] - 1) Y position] + Ah
$A8:88A2 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:88A5 A9 27 87    LDA #$8727             ;\
$A8:88A8 9F 04 78 7E STA $7E7804,x[$7E:7844];} Enemy new instruction list = $8727
$A8:88AC 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list

$A8:88AF 60          RTS
}


;;; $88B0: Initialisation AI - enemy $E67F (evir projectile) ;;;
{
$A8:88B0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:88B3 A9 6F 87    LDA #$876F             ;\
$A8:88B6 9F 04 78 7E STA $7E7804,x[$7E:7884];} Enemy new instruction list = $876F
$A8:88BA 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:88BD BD 16 0F    LDA $0F16,x[$7E:0F96]  ;\
$A8:88C0 9D 96 0F    STA $0F96,x[$7E:1016]  ;} Enemy palette index = [enemy ([X] - 2) palette index]
$A8:88C3 BD 18 0F    LDA $0F18,x[$7E:0F98]  ;\
$A8:88C6 9D 98 0F    STA $0F98,x[$7E:1018]  ;} Enemy VRAM tiles index = [enemy ([X] - 2) VRAM tiles index]
$A8:88C9 20 E5 88    JSR $88E5  [$A8:88E5]  ; Reset evir projectile position
$A8:88CC A9 00 00    LDA #$0000             ;\
$A8:88CF 9F 02 78 7E STA $7E7802,x[$7E:7882];} Enemy instruction list = 0
$A8:88D3 9F 18 78 7E STA $7E7818,x[$7E:7898]; Enemy regenerating flag = 0
$A8:88D7 9F 16 78 7E STA $7E7816,x[$7E:7896]; Enemy moving flag = 0
$A8:88DB 9D B2 0F    STA $0FB2,x[$7E:1032]  ; Enemy regeneration X offset = 0
$A8:88DE A9 34 8A    LDA #$8A34             ;\
$A8:88E1 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy function = $8A34 (idle)
$A8:88E4 6B          RTL
}


;;; $88E5: Reset evir projectile position ;;;
{
$A8:88E5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:88E8 BD 2A 0F    LDA $0F2A,x[$7E:0FAA]  ;\
$A8:88EB 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy facing direction = [enemy ([X] - 2) facing direction]
$A8:88EE D0 16       BNE $16    [$8906]     ; If [enemy facing direction] = up:
$A8:88F0 BD FA 0E    LDA $0EFA,x[$7E:0F7A]  ;\
$A8:88F3 38          SEC                    ;|
$A8:88F4 E9 04 00    SBC #$0004             ;} Enemy X position = [enemy ([X] - 2) X position] - 4
$A8:88F7 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A8:88FA BD FE 0E    LDA $0EFE,x[$7E:0F7E]  ;\
$A8:88FD 18          CLC                    ;|
$A8:88FE 69 12 00    ADC #$0012             ;} Enemy Y position = [enemy ([X] - 2) Y position] + 12h
$A8:8901 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A8:8904 80 14       BRA $14    [$891A]

$A8:8906 BD FA 0E    LDA $0EFA,x[$7E:0F7A]  ;\ Else ([enemy facing direction] != up):
$A8:8909 18          CLC                    ;|
$A8:890A 69 04 00    ADC #$0004             ;} Enemy X position = [enemy ([X] - 2) X position] + 4
$A8:890D 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A8:8910 BD FE 0E    LDA $0EFE,x[$7E:0F7E]  ;\
$A8:8913 18          CLC                    ;|
$A8:8914 69 12 00    ADC #$0012             ;} Enemy Y position = [enemy ([X] - 2) Y position] + 12h
$A8:8917 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/

$A8:891A 60          RTS
}


;;; $891B: Main AI - enemy $E63F (evir) ;;;
{
$A8:891B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:891E FC AC 0F    JSR ($0FAC,x)[$A8:8922]; Execute [enemy function]
$A8:8921 6B          RTL
}


;;; $8922: Evir function - handle body/arms ;;;
{
$A8:8922 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8925 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:8928 D0 05       BNE $05    [$892F]     ;} If [enemy parameter 1] = 0:
$A8:892A 20 33 89    JSR $8933  [$A8:8933]  ; Handle evir body
$A8:892D 80 03       BRA $03    [$8932]     ; Return

$A8:892F 20 97 89    JSR $8997  [$A8:8997]  ; Handle evir arms

$A8:8932 60          RTS
}


;;; $8933: Handle evir body ;;;
{
$A8:8933 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8936 BF 98 78 7E LDA $7E7898,x[$7E:7898];\
$A8:893A D0 03       BNE $03    [$893F]     ;} If [enemy ([X] + 2) regenerating flag] = 0:
$A8:893C 20 38 88    JSR $8838  [$A8:8838]  ; Set evir facing direction

$A8:893F BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$A8:8943 D0 1D       BNE $1D    [$8962]     ;} If [enemy movement direction] = up:
$A8:8945 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:8948 18          CLC                    ;|
$A8:8949 7F 0C 78 7E ADC $7E780C,x[$7E:780C];|
$A8:894D 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;|
$A8:8950 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;|
$A8:8953 18          CLC                    ;} Enemy Y position += [enemy up velocity]
$A8:8954 7F 0A 78 7E ADC $7E780A,x[$7E:780A];|
$A8:8958 90 03       BCC $03    [$895D]     ;|
$A8:895A FE 7E 0F    INC $0F7E,x            ;|
                                            ;|
$A8:895D 9D 80 0F    STA $0F80,x[$7E:0F80]  ;/
$A8:8960 80 1B       BRA $1B    [$897D]

$A8:8962 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\ Else ([enemy movement direction] != up):
$A8:8965 18          CLC                    ;|
$A8:8966 7F 08 78 7E ADC $7E7808,x[$7E:7808];|
$A8:896A 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;|
$A8:896D BD 80 0F    LDA $0F80,x[$7E:0F80]  ;|
$A8:8970 18          CLC                    ;} Enemy Y position += [enemy down velocity]
$A8:8971 7F 06 78 7E ADC $7E7806,x[$7E:7806];|
$A8:8975 90 03       BCC $03    [$897A]     ;|
$A8:8977 FE 7E 0F    INC $0F7E,x[$7E:0F7E]  ;|
                                            ;|
$A8:897A 9D 80 0F    STA $0F80,x[$7E:0F80]  ;/

$A8:897D DE B0 0F    DEC $0FB0,x[$7E:0FB0]  ; Decrement enemy movement timer
$A8:8980 10 14       BPL $14    [$8996]     ; If [enemy movement timer] < 0:
$A8:8982 BD B7 0F    LDA $0FB7,x[$7E:0FB7]  ;\
$A8:8985 29 FF 00    AND #$00FF             ;} Enemy movement timer = [enemy parameter 2 high]
$A8:8988 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;/
$A8:898B BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$A8:898F 49 01 00    EOR #$0001             ;} Enemy movement direction ^= 1
$A8:8992 9F 00 78 7E STA $7E7800,x[$7E:7800];/

$A8:8996 60          RTS
}


;;; $8997: Handle evir arms ;;;
{
$A8:8997 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:899A 20 66 88    JSR $8866  [$A8:8866]  ; Handle evir arms
$A8:899D 60          RTS
}


;;; $899E: Main AI - enemy $E67F (evir projectile) ;;;
{
$A8:899E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:89A1 BD 9E 0F    LDA $0F9E,x[$7E:101E]  ;\
$A8:89A4 D0 2A       BNE $2A    [$89D0]     ;} If [enemy frozen timer] != 0: go to BRANCH_MERGE
$A8:89A6 BF 16 78 7E LDA $7E7816,x[$7E:7896];\
$A8:89AA F0 0F       BEQ $0F    [$89BB]     ;} If [enemy moving flag] != 0:
$A8:89AC BD AA 0F    LDA $0FAA,x[$7E:102A]  ; >_<;
$A8:89AF A9 6F 87    LDA #$876F             ;\
$A8:89B2 9F 04 78 7E STA $7E7804,x[$7E:7884];} Enemy new instruction list = $876F
$A8:89B6 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:89B9 80 15       BRA $15    [$89D0]     ; Go to BRANCH_MERGE

$A8:89BB BF 18 78 7E LDA $7E7818,x[$7E:7898];\
$A8:89BF F0 0C       BEQ $0C    [$89CD]     ;} If [enemy regenerating flag] != 0:
$A8:89C1 A9 75 87    LDA #$8775             ;\
$A8:89C4 9F 04 78 7E STA $7E7804,x[$7E:7884];} Enemy new instruction list = $8775
$A8:89C8 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:89CB 80 03       BRA $03    [$89D0]     ; Go to BRANCH_MERGE

$A8:89CD 20 D4 89    JSR $89D4  [$A8:89D4]  ; Shoot evir projectile at Samus

; BRANCH_MERGE
$A8:89D0 FC AC 0F    JSR ($0FAC,x)[$A8:8A34]; Execute [enemy function]
$A8:89D3 6B          RTL
}


;;; $89D4: Shoot evir projectile at Samus ;;;
{
$A8:89D4 AD 54 0E    LDA $0E54  [$7E:0E54]  ;\
$A8:89D7 38          SEC                    ;|
$A8:89D8 E9 80 00    SBC #$0080             ;|
$A8:89DB AA          TAX                    ;} If Samus is within 80h pixel columns of enemy ([X] - 2):
$A8:89DC A9 80 00    LDA #$0080             ;|
$A8:89DF 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A8:89E3 F0 4E       BEQ $4E    [$8A33]     ;/
$A8:89E5 A9 04 00    LDA #$0004             ;\
$A8:89E8 8D 32 0E    STA $0E32  [$7E:0E32]  ;} $0E32 = 4 (speed)
$A8:89EB 22 66 C0 A0 JSL $A0C066[$A0:C066]  ; A = angle of Samus from enemy
$A8:89EF 38          SEC                    ;\
$A8:89F0 E9 40 00    SBC #$0040             ;|
$A8:89F3 29 FF 00    AND #$00FF             ;|
$A8:89F6 49 FF FF    EOR #$FFFF             ;} $16 = 40h - [A] (angle using the common maths convention)
$A8:89F9 1A          INC A                  ;|
$A8:89FA 85 16       STA $16    [$7E:0016]  ;/
$A8:89FC 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;\
$A8:8A00 9F 0E 78 7E STA $7E780E,x[$7E:788E];|
$A8:8A04 AD 38 0E    LDA $0E38  [$7E:0E38]  ;} Enemy X velocity = 4 * cos([$16] * pi / 80h) * FFh / 100h
$A8:8A07 9F 10 78 7E STA $7E7810,x[$7E:7890];/
$A8:8A0B A5 16       LDA $16    [$7E:0016]  ;\
$A8:8A0D 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A8:8A11 9F 12 78 7E STA $7E7812,x[$7E:7892];} Enemy Y velocity = 4 * -sin([$16] * pi / 80h) * FFh / 100h
$A8:8A15 AD 38 0E    LDA $0E38  [$7E:0E38]  ;|
$A8:8A18 9F 14 78 7E STA $7E7814,x[$7E:7894];/
$A8:8A1C A9 6F 87    LDA #$876F             ;\
$A8:8A1F 9F 04 78 7E STA $7E7804,x[$7E:7884];} Enemy new instruction list = $876F
$A8:8A23 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:8A26 A9 01 00    LDA #$0001             ;\
$A8:8A29 9F 16 78 7E STA $7E7816,x[$7E:7896];} Enemy moving flag = 1
$A8:8A2D A9 3B 8A    LDA #$8A3B             ;\
$A8:8A30 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy function = $8A3B (moving)

$A8:8A33 60          RTS
}


;;; $8A34: Evir projectile function - idle ;;;
{
$A8:8A34 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8A37 20 E5 88    JSR $88E5  [$A8:88E5]  ; Reset evir projectile position
$A8:8A3A 60          RTS
}


;;; $8A3B: Evir projectile function - moving ;;;
{
$A8:8A3B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8A3E 20 B1 8A    JSR $8AB1  [$A8:8AB1]  ; Start evir projectile regenerating if far off-screen
$A8:8A41 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A8:8A44 18          CLC                    ;|
$A8:8A45 7F 0E 78 7E ADC $7E780E,x[$7E:788E];|
$A8:8A49 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;|
$A8:8A4C BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;|
$A8:8A4F 18          CLC                    ;} Enemy X position += [enemy X velocity]
$A8:8A50 7F 10 78 7E ADC $7E7810,x[$7E:7890];|
$A8:8A54 90 03       BCC $03    [$8A59]     ;|
$A8:8A56 FE 7A 0F    INC $0F7A,x[$7E:0FFA]  ;|
                                            ;|
$A8:8A59 9D 7C 0F    STA $0F7C,x[$7E:0FFC]  ;/
$A8:8A5C BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A8:8A5F 18          CLC                    ;|
$A8:8A60 7F 12 78 7E ADC $7E7812,x[$7E:7892];|
$A8:8A64 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;|
$A8:8A67 BD 80 0F    LDA $0F80,x[$7E:1000]  ;|
$A8:8A6A 18          CLC                    ;} Enemy Y position += [enemy Y velocity]
$A8:8A6B 7F 14 78 7E ADC $7E7814,x[$7E:7894];|
$A8:8A6F 90 03       BCC $03    [$8A74]     ;|
$A8:8A71 FE 7E 0F    INC $0F7E,x[$7E:0FFE]  ;|
                                            ;|
$A8:8A74 9D 80 0F    STA $0F80,x[$7E:1000]  ;/
$A8:8A77 60          RTS
}


;;; $8A78: Evir projectile function - regenerating ;;;
{
$A8:8A78 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8A7B BD 1E 0F    LDA $0F1E,x[$7E:0F9E]  ;\
$A8:8A7E D0 30       BNE $30    [$8AB0]     ;} If [enemy ([X] - 2) frozen timer] != 0: return
$A8:8A80 BF 18 78 7E LDA $7E7818,x[$7E:7898];\
$A8:8A84 D0 1D       BNE $1D    [$8AA3]     ;} If [enemy regenerating flag] = 0:
$A8:8A86 A9 6F 87    LDA #$876F             ;\
$A8:8A89 9F 04 78 7E STA $7E7804,x          ;} Enemy new instruction list = $876F
$A8:8A8D 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list
$A8:8A90 A9 00 00    LDA #$0000             ;\
$A8:8A93 9F 18 78 7E STA $7E7818,x          ;} Enemy regenerating flag = 0
$A8:8A97 9F 16 78 7E STA $7E7816,x          ; Enemy moving flag = 0
$A8:8A9B A9 34 8A    LDA #$8A34             ;\
$A8:8A9E 9D AC 0F    STA $0FAC,x            ;} Enemy function = $8A34 (idle)
$A8:8AA1 80 0D       BRA $0D    [$8AB0]     ; Return

$A8:8AA3 20 E5 88    JSR $88E5  [$A8:88E5]  ; Reset evir projectile position
$A8:8AA6 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A8:8AA9 18          CLC                    ;|
$A8:8AAA 7D B2 0F    ADC $0FB2,x[$7E:1032]  ;} Enemy X position += [enemy regeneration X offset]
$A8:8AAD 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/

$A8:8AB0 60          RTS
}


;;; $8AB1: Start evir projectile regenerating if far off-screen ;;;
{
$A8:8AB1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8AB4 A9 00 01    LDA #$0100             ;\
$A8:8AB7 22 A3 AD A0 JSL $A0ADA3[$A0:ADA3]  ;} If enemy centre is over 100h pixels off-screen:
$A8:8ABB F0 2A       BEQ $2A    [$8AE7]     ;/
$A8:8ABD BD 1E 0F    LDA $0F1E,x[$7E:0F9E]  ;\
$A8:8AC0 D0 25       BNE $25    [$8AE7]     ;} If [enemy ([X] - 2) frozen timer] = 0:
$A8:8AC2 A9 00 00    LDA #$0000             ;\
$A8:8AC5 9F 16 78 7E STA $7E7816,x[$7E:7896];} Enemy moving flag = 0
$A8:8AC9 A9 01 00    LDA #$0001             ;\
$A8:8ACC 9F 18 78 7E STA $7E7818,x[$7E:7898];} Enemy regenerating flag = 1
$A8:8AD0 A9 78 8A    LDA #$8A78             ;\
$A8:8AD3 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy function = $8A78 (regenerating)
$A8:8AD6 A9 01 00    LDA #$0001             ;\
$A8:8AD9 9F 18 78 7E STA $7E7818,x[$7E:7898];} >_<;
$A8:8ADD A9 75 87    LDA #$8775             ;\
$A8:8AE0 9F 04 78 7E STA $7E7804,x[$7E:7884];} Enemy new instruction list = $8775
$A8:8AE4 20 E8 8A    JSR $8AE8  [$A8:8AE8]  ; Set evir instruction list

$A8:8AE7 60          RTS
}


;;; $8AE8: Set evir instruction list ;;;
{
$A8:8AE8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8AEB BF 04 78 7E LDA $7E7804,x[$7E:7804];\
$A8:8AEF DF 02 78 7E CMP $7E7802,x[$7E:7802];} If [enemy instruction list] != [enemy new instruction list]:
$A8:8AF3 F0 10       BEQ $10    [$8B05]     ;/
$A8:8AF5 9D 92 0F    STA $0F92,x[$7E:0F92]  ; Enemy instruction list pointer = [enemy new instruction list]
$A8:8AF8 9F 02 78 7E STA $7E7802,x[$7E:7802]; Enemy instruction list = [enemy new instruction list]
$A8:8AFC A9 01 00    LDA #$0001             ;\
$A8:8AFF 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:8B02 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0

$A8:8B05 60          RTS
}


;;; $8B06: Enemy shot - enemy $E63F (evir) ;;;
{
$A8:8B06 22 23 80 A8 JSL $A88023[$A8:8023]  ; Normal enemy touch AI
$A8:8B0A 80 0A       BRA $0A    [$8B16]     ; Go to evir shared contact reaction
}


;;; $8B0C: Power bomb reaction - enemy $E63F (evir) ;;;
{
$A8:8B0C 22 37 80 A8 JSL $A88037[$A8:8037]  ; Normal enemy power bomb AI
$A8:8B10 80 04       BRA $04    [$8B16]     ; Go to evir shared contact reaction
}


;;; $8B12: Enemy touch - enemy $E63F (evir) ;;;
{
$A8:8B12 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
}


;;; $8B16: Evir shared contact reaction ;;;
{
$A8:8B16 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:8B19 BD 8C 0F    LDA $0F8C,x[$7E:104C]  ;\
$A8:8B1C D0 12       BNE $12    [$8B30]     ;} If [enemy health] = 0:
$A8:8B1E BD C6 0F    LDA $0FC6,x            ;\
$A8:8B21 09 00 02    ORA #$0200             ;} Mark enemy ([X] + 1) for deletion
$A8:8B24 9D C6 0F    STA $0FC6,x            ;/
$A8:8B27 BD 06 10    LDA $1006,x            ;\
$A8:8B2A 09 00 02    ORA #$0200             ;} Mark enemy ([X] + 2) for deletion
$A8:8B2D 9D 06 10    STA $1006,x            ;/

$A8:8B30 BD 9E 0F    LDA $0F9E,x[$7E:105E]  ;\
$A8:8B33 F0 23       BEQ $23    [$8B58]     ;} If [enemy frozen timer] = 0: return
$A8:8B35 9D DE 0F    STA $0FDE,x[$7E:109E]  ; Enemy ([X] + 1) frozen timer = [enemy frozen timer]
$A8:8B38 BD CA 0F    LDA $0FCA,x[$7E:108A]  ;\
$A8:8B3B 09 04 00    ORA #$0004             ;} Set enemy ([X] + 1) frozen AI
$A8:8B3E 9D CA 0F    STA $0FCA,x[$7E:108A]  ;/
$A8:8B41 BD 2C 10    LDA $102C,x[$7E:10EC]  ;\
$A8:8B44 C9 3B 8A    CMP #$8A3B             ;} If [enemy ([X] + 2) function] = $8A3B (moving): return
$A8:8B47 F0 0F       BEQ $0F    [$8B58]     ;/
$A8:8B49 BD 0A 10    LDA $100A,x[$7E:118A]  ;\
$A8:8B4C 09 04 00    ORA #$0004             ;} Set enemy ([X] + 2) frozen AI
$A8:8B4F 9D 0A 10    STA $100A,x[$7E:118A]  ;/
$A8:8B52 BD 9E 0F    LDA $0F9E,x[$7E:111E]  ;\
$A8:8B55 9D 1E 10    STA $101E,x[$7E:119E]  ;} Enemy ([X] + 2) frozen timer = [enemy frozen timer]

$A8:8B58 6B          RTL
}


;;; $8B59: Evir spritemaps ;;;
{
$A8:8B59             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FB,2108, 8001,01,2108, 81FF,07,210C, 01FE,10,2126, 01FE,08,2125
$A8:8B88             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FC,2108, 8001,02,2108, 81FF,07,210C, 01FE,10,2126, 01FE,08,2125
$A8:8BB7             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FD,2108, 8001,03,2108, 81FF,08,210C, 01FE,11,2126, 01FE,09,2125
$A8:8BE6             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FD,2108, 8001,04,2108, 81FF,09,210C, 01FE,12,2126, 01FE,0A,2125
$A8:8C15             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FD,2108, 8001,04,2108, 81FF,0A,210C, 01FE,11,2126, 01FE,09,2125
$A8:8C44             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FC,2108, 8001,03,2108, 81FF,09,210C, 01FE,10,2126, 01FE,08,2125
$A8:8C73             dx 0009, 81FE,FB,2106, 81EE,FB,2104, 81FE,EB,2102, 81EE,EB,2100, 8002,FB,2108, 8001,01,2108, 81FF,07,210C, 01FE,10,2126, 01FE,08,2125 ; Unused
$A8:8CA2             dx 0005, 0000,F8,2123, 01F8,F8,2122, 0002,FC,2124, 01FE,F4,2121, 01F6,F4,2120
$A8:8CBD             dx 0005, 01FE,F4,2123, 01F6,F4,2122, 0000,F8,2124, 0002,FC,2123, 01FA,FC,2122
$A8:8CD8             dx 0005, 01FE,F4,2124, 01F8,F8,2122, 0000,F8,2123, 0002,FC,2121, 01FA,FC,2120
$A8:8CF3             dx 0006, 01FE,F4,2123, 01F6,F4,2122, 01F8,F8,2120, 0000,F8,2121, 0002,FC,2123, 01FA,FC,2122
$A8:8D13             dx 0003, 01FE,F4,2124, 0000,F8,2124, 0002,FC,2124
$A8:8D24             dx 0006, 01FE,F4,2123, 01F6,F4,2122, 01F8,F8,2122, 0000,F8,2123, 0002,FC,2123, 01FA,FC,2122 ; Unused
$A8:8D44             dx 0006, 01FE,F4,2121, 01F6,F4,2120, 0000,F8,2121, 01F8,F8,2120, 0002,FC,2121, 01FA,FC,2120 ; Unused
$A8:8D64             dx 0004, 0000,00,A128, 01F8,00,A127, 0000,F8,2128, 01F8,F8,2127
$A8:8D7A             dx 0001, 81F8,F8,210E
$A8:8D81             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FB,6108, 81EF,01,6108, 81F1,07,610C, 01FA,10,6126, 01FA,08,6125
$A8:8DB0             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FC,6108, 81EF,02,6108, 81F1,07,610C, 01FA,10,6126, 01FA,08,6125
$A8:8DDF             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FD,6108, 81EF,03,6108, 81F1,08,610C, 01FA,11,6126, 01FA,09,6125
$A8:8E0E             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FD,6108, 81EF,04,6108, 81F1,09,610C, 01FA,12,6126, 01FA,0A,6125
$A8:8E3D             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FD,6108, 81EF,04,6108, 81F1,0A,610C, 01FA,11,6126, 01FA,09,6125
$A8:8E6C             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FC,6108, 81EF,03,6108, 81F1,09,610C, 01FA,10,6126, 01FA,08,6125
$A8:8E9B             dx 0009, 81F2,FB,6106, 8002,FB,6104, 81F2,EB,6102, 8002,EB,6100, 81EE,FB,6108, 81EF,01,6108, 81F1,07,610C, 01FA,10,6126, 01FA,08,6125 ; Unused
$A8:8ECA             dx 0005, 01F8,F8,6123, 0000,F8,6122, 01FA,F4,6121, 0002,F4,6120, 01F6,FC,6124
$A8:8EE5             dx 0005, 01FA,F4,6123, 0002,F4,6122, 01F8,F8,6124, 01F6,FC,6123, 01FE,FC,6122
$A8:8F00             dx 0005, 01FA,F4,6124, 01F8,F8,6123, 0000,F8,6122, 01F6,FC,6121, 01FE,FC,6120
$A8:8F1B             dx 0006, 01FA,F4,6123, 0002,F4,6122, 0000,F8,6120, 01F8,F8,6121, 01F6,FC,6123, 01FE,FC,6122
$A8:8F3B             dx 0003, 01F6,FC,6124, 01F8,F8,6124, 01FA,F4,6124
$A8:8F4C             dx 0006, 01FA,F4,6123, 0002,F4,6122, 01F8,F8,6123, 0000,F8,6122, 01F6,FC,6123, 01FE,FC,6122 ; Unused
$A8:8F6C             dx 0006, 01FA,F4,6121, 0002,F4,6120, 0000,F8,6120, 01F8,F8,6121, 01F6,FC,6121, 01FE,FC,6120 ; Unused
}
}


;;; $8F8C..9378: Morph ball eye ;;;
{
;;; $8F8C: Palette - enemy $E6BF (morph ball eye) ;;;
{
$A8:8F8C             dw 3800, 72B2, 71C7, 2461, 1840, 7A8E, 660B, 4D03, 4900, 7FE0, 7E80, 44E0, 2C20, 0000, 0000, 0000
}


;;; $8FAC..904F: Instruction lists ;;;
{
;;; $8FAC: Instruction list - eye - active ;;;
{
; Indexed by [enemy angle] / 10h * 4, set every frame
$A8:8FAC             dx 000A,9210,
                        000A,9210,
                        000A,9217,
                        000A,921E,
                        000A,9225,
                        000A,922C,
                        000A,9233,
                        000A,923A,
                        000A,9209,
                        000A,9202,
                        000A,91FB,
                        000A,91F4,
                        000A,91ED,
                        000A,91E6,
                        000A,91DF,
                        000A,91DF,
                        80ED,8FAC   ; Go to $8FAC
}


;;; $8FF0: Instruction list - eye - facing right - deactivating ;;;
{
$A8:8FF0             dw 0008,9257,
                        0030,91F4,
                        0005,9257
}


;;; $8FFC: Instruction list - eye - facing right - closed ;;;
{
$A8:8FFC             dw 0030,9241,
                        812F        ; Sleep
}


;;; $9002: Instruction list - eye - facing left - deactivating ;;;
{
$A8:9002             dw 0008,9283,
                        0030,9225,
                        0005,9283
}


;;; $900E: Instruction list - eye - facing left - closed ;;;
{
$A8:900E             dw 0030,926D,
                        812F        ; Sleep
}


;;; $9014: Instruction list - eye - activating - facing right ;;;
{
$A8:9014             dx 0020,9241,
                        0005,9257,
                        0030,91F4,
                        0008,9257,
                        812F        ; Sleep
}


;;; $9026: Instruction list - eye - activating - facing left ;;;
{
$A8:9026             dx 0020,926D,
                        0005,9283,
                        0030,9225,
                        0008,9283,
                        812F        ; Sleep
}


;;; $9038: Instruction list - mount - facing right ;;;
{
$A8:9038             dx 0001,9299,
                        812F        ; Sleep
}


;;; $903E: Instruction list - mount - facing down ;;;
{
$A8:903E             dx 0001,92A5,
                        812F        ; Sleep
}


;;; $9044: Instruction list - mount - facing left ;;;
{
$A8:9044             dx 0001,92B1,
                        812F        ; Sleep
}


;;; $904A: Instruction list - mount - facing up ;;;
{
$A8:904A             dx 0001,92BD,
                        812F        ; Sleep
}
}


;;; $9050: Morph ball eye proximities ;;;
{
$A8:9050             dw 0080 ; X proximity to activate
$A8:9052             dw 00B0 ; X proximity to deactivate
$A8:9054             dw 0080 ; Y proximity to activate
$A8:9056             dw 0080 ; Y proximity to deactivate
}


;;; $9058: Initialisation AI - enemy $E6BF (morph ball eye) ;;;
{
$A8:9058 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:905B BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:905E 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A8:9061 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:9064 A9 4D 80    LDA #$804D             ;\
$A8:9067 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D (nothing)
$A8:906A A9 01 00    LDA #$0001             ;\
$A8:906D 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:9070 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:9073 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A8:9076 30 1E       BMI $1E    [$9096]     ;} If [enemy parameter 2] & 8000h != 0: go to BRANCH_MOUNT
$A8:9078 A9 F1 90    LDA #$90F1             ;\
$A8:907B 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $90F1 (wait for Samus to get near)
$A8:907E BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$A8:9081 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$A8:9084 F0 08       BEQ $08    [$908E]     ;/
$A8:9086 A9 0E 90    LDA #$900E             ;\
$A8:9089 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $900E (eye - facing left - closed)
$A8:908C 80 3B       BRA $3B    [$90C9]     ; Return

$A8:908E A9 FC 8F    LDA #$8FFC             ;\ Else ([enemy parameter 1] & 1 = 0):
$A8:9091 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $8FFC (eye - facing right - closed)
$A8:9094 80 33       BRA $33    [$90C9]     ; Return

; BRANCH_MOUNT
$A8:9096 29 0F 00    AND #$000F             ;\
$A8:9099 0A          ASL A                  ;} Y = ([enemy parameter 2] & Fh) * 2
$A8:909A A8          TAY                    ;/
$A8:909B BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:909E 18          CLC                    ;|
$A8:909F 79 CA 90    ADC $90CA,y[$A8:90CA]  ;} Enemy X position += [$90CA + [Y]]
$A8:90A2 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A8:90A5 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:90A8 18          CLC                    ;|
$A8:90A9 79 D2 90    ADC $90D2,y[$A8:90D2]  ;} Enemy Y position += [$90D2 + [Y]]
$A8:90AC 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A8:90AF A9 DC 91    LDA #$91DC             ;\
$A8:90B2 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = RTL
$A8:90B5 B9 DA 90    LDA $90DA,y[$A8:90DA]  ;\
$A8:90B8 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = [$90DA + [Y]]
$A8:90BB A2 FE 01    LDX #$01FE             ;\
                                            ;|
$A8:90BE A9 FF 00    LDA #$00FF             ;|
$A8:90C1 9F 00 91 7E STA $7E9100,x[$7E:92FE];} Morph ball eye beam window 1 HDMA data table = FFh,00h
$A8:90C5 CA          DEX                    ;|
$A8:90C6 CA          DEX                    ;|
$A8:90C7 10 F5       BPL $F5    [$90BE]     ;/

$A8:90C9 6B          RTL

$A8:90CA             dw FFF8, 0008, 0000, 0000 ; X offsets
$A8:90D2             dw 0000, 0000, FFF8, 0008 ; Y offsets
$A8:90DA             dw 9044, 9038, 904A, 903E ; Instruction list pointers
}


;;; $90E2: Main AI - enemy $E6BF (morph ball eye) ;;;
{
$A8:90E2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:90E5 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$A8:90E8 89 04 00    BIT #$0004             ;} If collected morph ball:
$A8:90EB F0 03       BEQ $03    [$90F0]     ;/
$A8:90ED 7C B2 0F    JMP ($0FB2,x)[$A8:91DC]; Go to [enemy function]

$A8:90F0 6B          RTL
}


;;; $90F1: Morph ball eye function - wait for Samus to get near ;;;
{
$A8:90F1 AD 54 90    LDA $9054  [$A8:9054]  ;\
$A8:90F4 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$A8:90F8 A8          TAY                    ;} If Samus is not within 80h pixels rows of enemy: return
$A8:90F9 F0 32       BEQ $32    [$912D]     ;/
$A8:90FB AD 50 90    LDA $9050  [$A8:9050]  ;\
$A8:90FE 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A8:9102 A8          TAY                    ;} If Samus is not within 80h pixel columns of enemy: return
$A8:9103 F0 28       BEQ $28    [$912D]     ;/
$A8:9105 A9 20 00    LDA #$0020             ;\
$A8:9108 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy function timer = 20h
$A8:910B A9 01 00    LDA #$0001             ;\
$A8:910E 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:9111 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$A8:9114 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$A8:9117 F0 08       BEQ $08    [$9121]     ;/
$A8:9119 A9 26 90    LDA #$9026             ;\
$A8:911C 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $9026 (activating - facing left)
$A8:911F 80 06       BRA $06    [$9127]

$A8:9121 A9 14 90    LDA #$9014             ;\ Else ([enemy parameter 1] & 1 = 0):
$A8:9124 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $9014 (activating - facing right)

$A8:9127 A9 2E 91    LDA #$912E             ;\
$A8:912A 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $912E

$A8:912D 6B          RTL
}


;;; $912E: Morph ball eye function - activating ;;;
{
$A8:912E DE B0 0F    DEC $0FB0,x[$7E:0FF0]  ; Decrement enemy function timer
$A8:9131 F0 02       BEQ $02    [$9135]     ;\
$A8:9133 10 2A       BPL $2A    [$915F]     ;} If [enemy function timer] > 0: return

$A8:9135 A9 17 00    LDA #$0017             ;\
$A8:9138 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 17h, sound library 2, max queued sounds allowed = 6 (morph ball eye's ray)
$A8:913C 22 D9 E8 88 JSL $88E8D9[$88:E8D9]  ; Spawn morph ball eye beam HDMA object
$A8:9140 A9 60 91    LDA #$9160             ;\
$A8:9143 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $9160
$A8:9146 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:9149 38          SEC                    ;|
$A8:914A FD 7A 0F    SBC $0F7A,x[$7E:0FBA]  ;|
$A8:914D 85 12       STA $12    [$7E:0012]  ;|
$A8:914F AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A8:9152 38          SEC                    ;} Enemy angle = angle from enemy to Samus
$A8:9153 FD 7E 0F    SBC $0F7E,x[$7E:0FBE]  ;|
$A8:9156 85 14       STA $14    [$7E:0014]  ;|
$A8:9158 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;|
$A8:915C 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/

$A8:915F 6B          RTL
}


;;; $9160: Morph ball eye function - active ;;;
{
$A8:9160 AD 56 90    LDA $9056  [$A8:9056]  ;\
$A8:9163 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;|
$A8:9167 A8          TAY                    ;} If Samus is within 80h pixels rows of enemy:
$A8:9168 F0 0A       BEQ $0A    [$9174]     ;/
$A8:916A AD 52 90    LDA $9052  [$A8:9052]  ;\
$A8:916D 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;|
$A8:9171 A8          TAY                    ;} If Samus is within 80h pixel columns of enemy: go to BRANCH_IN_PROXIMITY
$A8:9172 D0 2E       BNE $2E    [$91A2]     ;/

$A8:9174 A9 71 00    LDA #$0071             ;\
$A8:9177 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 71h, sound library 2, max queued sounds allowed = 6 (silence)
$A8:917B 9E AC 0F    STZ $0FAC,x[$7E:0FEC]  ; Enemy activated flag = 0 (this is set to 1 by the HDMA object)
$A8:917E A9 20 00    LDA #$0020             ;\
$A8:9181 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy function timer = 20h
$A8:9184 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$A8:9187 89 01 00    BIT #$0001             ;} If [enemy parameter 1] & 1 != 0:
$A8:918A F0 08       BEQ $08    [$9194]     ;/
$A8:918C A9 02 90    LDA #$9002             ;\
$A8:918F 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $9002 (facing left - deactivating)
$A8:9192 80 06       BRA $06    [$919A]

$A8:9194 A9 F0 8F    LDA #$8FF0             ;\ Else ([enemy parameter 1] & 1 = 0):
$A8:9197 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $8FF0 (facing right - deactivating)

$A8:919A A9 CE 91    LDA #$91CE             ;\
$A8:919D 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $91CE
$A8:91A0 80 25       BRA $25    [$91C7]     ; Go to BRANCH_MERGE

; BRANCH_IN_PROXIMITY
$A8:91A2 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:91A5 38          SEC                    ;|
$A8:91A6 FD 7A 0F    SBC $0F7A,x[$7E:0FBA]  ;|
$A8:91A9 85 12       STA $12    [$7E:0012]  ;|
$A8:91AB AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A8:91AE 38          SEC                    ;} Enemy angle = angle from enemy to Samus
$A8:91AF FD 7E 0F    SBC $0F7E,x[$7E:0FBE]  ;|
$A8:91B2 85 14       STA $14    [$7E:0014]  ;|
$A8:91B4 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;|
$A8:91B8 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/
$A8:91BB 29 F0 00    AND #$00F0             ;\
$A8:91BE 4A          LSR A                  ;|
$A8:91BF 4A          LSR A                  ;|
$A8:91C0 18          CLC                    ;} Enemy instruction list pointer = $8FAC + [enemy angle] / 10h * 4
$A8:91C1 69 AC 8F    ADC #$8FAC             ;|
$A8:91C4 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;/

; BRANCH_MERGE
$A8:91C7 A9 01 00    LDA #$0001             ;\
$A8:91CA 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:91CD 6B          RTL
}


;;; $91CE: Morph ball eye function - deactivating ;;;
{
$A8:91CE DE B0 0F    DEC $0FB0,x[$7E:0FF0]  ; Decrement enemy function timer
$A8:91D1 F0 02       BEQ $02    [$91D5]     ;\
$A8:91D3 10 06       BPL $06    [$91DB]     ;} If [enemy function timer] > 0: return

$A8:91D5 A9 F1 90    LDA #$90F1             ;\
$A8:91D8 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $90F1 (wait for Samus to get near)

$A8:91DB 6B          RTL
}


;;; $91DC: RTL ;;;
{
$A8:91DC 6B          RTL
}


;;; $91DD: RTL ;;;
{
$A8:91DD 6B          RTL
}


;;; $91DE: RTL ;;;
{
$A8:91DE 6B          RTL
}


;;; $91DF: Morph ball eye spritemaps ;;;
{
$A8:91DF             dx 0001, 81F8,F8,2100
$A8:91E6             dx 0001, 81F8,F8,2102
$A8:91ED             dx 0001, 81F8,F8,2104
$A8:91F4             dx 0001, 81F8,F8,2106
$A8:91FB             dx 0001, 81F8,F8,2108
$A8:9202             dx 0001, 81F8,F8,210A
$A8:9209             dx 0001, 81F8,F8,210C
$A8:9210             dx 0001, 81F8,F8,6100
$A8:9217             dx 0001, 81F8,F8,6102
$A8:921E             dx 0001, 81F8,F8,6104
$A8:9225             dx 0001, 81F8,F8,6106
$A8:922C             dx 0001, 81F8,F8,6108
$A8:9233             dx 0001, 81F8,F8,610A
$A8:923A             dx 0001, 81F8,F8,610C
$A8:9241             dx 0004, 01F8,00,A11F, 01F8,F8,211F, 0000,00,2117, 0000,F8,2107
$A8:9257             dx 0004, 01F8,00,A11E, 01F8,F8,211E, 0000,00,2117, 0000,F8,2107
$A8:926D             dx 0004, 0000,00,E11F, 0000,F8,611F, 01F8,00,6117, 01F8,F8,6107
$A8:9283             dx 0004, 0000,00,E11E, 0000,F8,611E, 01F8,00,6117, 01F8,F8,6107
$A8:9299             dx 0002, 01FC,00,A10E, 01FC,F8,210E
$A8:92A5             dx 0002, 0000,FC,610F, 01F8,FC,210F
$A8:92B1             dx 0002, 01FC,00,E10E, 01FC,F8,610E
$A8:92BD             dx 0002, 0000,FC,E10F, 01F8,FC,A10F
$A8:92C9             dx 0004, 01F8,00,A11F, 01F8,F8,211F, 0000,00,2117, 0000,F8,2107
$A8:92DF             dx 0004, 01F8,00,A11E, 01F8,F8,211E, 0000,00,2117, 0000,F8,2107
$A8:92F5             dx 0004, 0000,00,E11F, 0000,F8,611F, 01F8,00,6117, 01F8,F8,6107
$A8:930B             dx 0004, 0000,00,E11E, 0000,F8,611E, 01F8,00,6117, 01F8,F8,6107
$A8:9321             dx 0004, 0000,00,E11F, 0000,F8,611F, 01F8,00,6117, 01F8,F8,6107
$A8:9337             dx 0004, 0000,00,E11E, 0000,F8,611E, 01F8,00,6117, 01F8,F8,6107
$A8:934D             dx 0004, 01F8,00,A11F, 01F8,F8,211F, 0000,00,2117, 0000,F8,2107
$A8:9363             dx 0004, 01F8,00,A11E, 01F8,F8,211E, 0000,00,2117, 0000,F8,2107
}
}


;;; $9379..99AB: Fune / namihe ;;;
{
;;; $9379: Palette - enemy $E6FF (fune) ;;;
{
$A8:9379             dw 3800, 4B9C, 3694, 0929, 0042, 3B18, 2A52, 19AD, 116B, 7F5A, 7EC0, 6DE0, 54E0, 001D, 0014, 000A
}


;;; $9399..F8: Fune instruction lists ;;;
{
;;; $9399: Instruction list - fune - facing left - idle ;;;
{
$A8:9399             dx 0001,93F9,
                        812F        ; Sleep
}


;;; $939F: Instruction list - fune - facing left - active ;;;
{
$A8:939F             dx 0010,93F9,
                        0008,9423,
                        0008,944D,
                        0008,9477,
                        9663,       ; Spawn leftwards fune fireball
                        9625,       ; Queue fune spits sound effect
                        0010,94A1,
                        0008,9477,
                        0008,944D,
                        0008,9423,
                        9695,       ; Finish activity
                        80ED,9399   ; Go to $9399
}


;;; $93C9: Instruction list - fune - facing right - idle ;;;
{
$A8:93C9             dx 0001,94CB,
                        812F        ; Sleep
}


;;; $93CF: Instruction list - fune - facing right - active ;;;
{
$A8:93CF             dx 0010,94CB,
                        0008,94F5,
                        0008,951F,
                        0008,9549,
                        967C,       ; Spawn rightwards fune fireball
                        9625,       ; Queue fune spits sound effect
                        0010,9573,
                        0008,9549,
                        0008,951F,
                        0008,94F5,
                        96B4,       ; Finish activity
                        80ED,93C9   ; Go to $93C9
}
}


;;; $93F9: Fune spritemaps ;;;
{
; Facing left
$A8:93F9             dx 0008, 0008,0C,2127, 0000,0C,2126, 8000,FC,2122, 8000,EC,2120, 81F0,FC,2102, 01F8,FC,2125, 01F0,FC,2124, 81F0,EC,2100
$A8:9423             dx 0008, 0006,0C,2127, 01FE,0C,2126, 81FE,FC,2122, 81FE,EC,2120, 81EE,FE,2102, 01F6,FC,2125, 01EE,FC,2124, 81EE,EC,2100
$A8:944D             dx 0008, 0004,0C,2127, 01FC,0C,2126, 81FC,FC,2122, 81FC,EC,2120, 81EC,00,2102, 01F4,FC,2125, 01EC,FC,2124, 81EC,EC,2100
$A8:9477             dx 0008, 0002,0C,2127, 01FA,0C,2126, 81FA,FC,2122, 81FA,EC,2120, 81EA,01,2102, 01F2,FC,2125, 01EA,FC,2124, 81EA,EC,2100
$A8:94A1             dx 0008, 0000,0C,2127, 01F8,0C,2126, 81F8,FC,2122, 81F8,EC,2120, 81E8,03,2102, 01F0,FC,2125, 01E8,FC,2124, 81E8,EC,2100

; Facing right
$A8:94CB             dx 0008, 01F0,0C,6127, 01F8,0C,6126, 81F0,FC,6122, 81F0,EC,6120, 8000,FC,6102, 0000,FC,6125, 0008,FC,6124, 8000,EC,6100
$A8:94F5             dx 0008, 01F2,0C,6127, 01FA,0C,6126, 81F2,FC,6122, 81F2,EC,6120, 8002,FE,6102, 0002,FC,6125, 000A,FC,6124, 8002,EC,6100
$A8:951F             dx 0008, 01F4,0C,6127, 01FC,0C,6126, 81F4,FC,6122, 81F4,EC,6120, 8004,00,6102, 0004,FC,6125, 000C,FC,6124, 8004,EC,6100
$A8:9549             dx 0008, 01F6,0C,6127, 01FE,0C,6126, 81F6,FC,6122, 81F6,EC,6120, 8006,01,6102, 0006,FC,6125, 000E,FC,6124, 8006,EC,6100
$A8:9573             dx 0008, 01F8,0C,6127, 0000,0C,6126, 81F8,FC,6122, 81F8,EC,6120, 8007,02,6102, 0008,FC,6125, 0010,FC,6124, 8008,EC,6100
}


;;; $959D: Palette - enemy $E73F (namihe) ;;;
{
$A8:959D             dw 3800, 4B9C, 3694, 0929, 0042, 3B18, 2A52, 19AD, 116B, 7F5A, 7EC0, 6DE0, 54E0, 001D, 0014, 000A
}


;;; $95BD..9624: Namihe instruction lists ;;;
{
;;; $95BD: Instruction list - namihe - facing left - idle ;;;
{
$A8:95BD             dx 0001,97B4,
                        812F        ; Sleep
}


;;; $95C3: Instruction list - namihe - facing left - active ;;;
{
$A8:95C3             dx 0008,97B4,
                        0008,97DE,
                        0008,9808,
                        0008,9832,
                        0008,985C,
                        9631,       ; Spawn leftwards namihe fireball
                        9625,       ; Queue fune spits sound effect
                        0008,9886,
                        0008,985C,
                        0008,9832,
                        0008,9808,
                        9695,       ; Finish activity
                        80ED,95BD   ; Go to $95BD
}


;;; $95F1: Instruction list - namihe - facing right - idle ;;;
{
$A8:95F1             dx 0001,98B0,
                        812F        ; Sleep
}


;;; $95F7: Instruction list - namihe - facing right - active ;;;
{
$A8:95F7             dx 0008,98B0,
                        0008,98DA,
                        0008,9904,
                        0008,992E,
                        0008,9958,
                        964A,       ; Spawn rightwards namihe fireball
                        9625,       ; Queue fune spits sound effect
                        0008,9982,
                        0008,9958,
                        0008,992E,
                        0008,9904,
                        96B4,       ; Finish activity
                        80ED,95F1   ; Go to $95F1
}
}


;;; $9625..D2: Instructions ;;;
{
;;; $9625: Instruction - queue fune spits sound effect ;;;
{
$A8:9625 5A          PHY
$A8:9626 DA          PHX
$A8:9627 A9 1F 00    LDA #$001F             ;\
$A8:962A 22 AD 90 80 JSL $8090AD[$80:90AD]  ;} Queue sound 1Fh, sound library 2, max queued sounds allowed = 9 (fune spits)
$A8:962E FA          PLX
$A8:962F 7A          PLY
$A8:9630 6B          RTL
}


;;; $9631: Instruction - spawn leftwards namihe fireball ;;;
{
$A8:9631 5A          PHY
$A8:9632 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9635 BD B6 0F    LDA $0FB6,x[$7E:10B6]  ;\
$A8:9638 29 FF 00    AND #$00FF             ;} Enemy projectile initialisation parameter 1 = [enemy parameter 2 low] (never read)
$A8:963B 8D 95 19    STA $1995  [$7E:1995]  ;/
$A8:963E A9 00 00    LDA #$0000             ;\
$A8:9641 A0 BC DF    LDY #$DFBC             ;} Spawn namihe fireball enemy projectile with parameter 0 (direction = left)
$A8:9644 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:9648 7A          PLY
$A8:9649 6B          RTL
}


;;; $964A: Instruction - spawn rightwards namihe fireball ;;;
{
$A8:964A 5A          PHY
$A8:964B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:964E BD B6 0F    LDA $0FB6,x[$7E:0FF6]  ;\
$A8:9651 29 FF 00    AND #$00FF             ;} Enemy projectile initialisation parameter 1 = [enemy parameter 2 low] (never read)
$A8:9654 8D 95 19    STA $1995  [$7E:1995]  ;/
$A8:9657 A9 01 00    LDA #$0001             ;\
$A8:965A A0 BC DF    LDY #$DFBC             ;} Spawn namihe fireball enemy projectile with parameter 1 (direction = right)
$A8:965D 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:9661 7A          PLY
$A8:9662 6B          RTL
}


;;; $9663: Instruction - spawn leftwards fune fireball ;;;
{
$A8:9663 5A          PHY
$A8:9664 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9667 BD B6 0F    LDA $0FB6,x[$7E:1076]  ;\
$A8:966A 29 FF 00    AND #$00FF             ;} Enemy projectile initialisation parameter 1 = [enemy parameter 2 low] (never read)
$A8:966D 8D 95 19    STA $1995  [$7E:1995]  ;/
$A8:9670 A9 00 00    LDA #$0000             ;\
$A8:9673 A0 CA DF    LDY #$DFCA             ;} Spawn fune fireball enemy projectile with parameter 0 (direction = left)
$A8:9676 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:967A 7A          PLY
$A8:967B 6B          RTL
}


;;; $967C: Instruction - spawn rightwards fune fireball ;;;
{
$A8:967C 5A          PHY
$A8:967D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9680 BD B6 0F    LDA $0FB6,x[$7E:1136]  ;\
$A8:9683 29 FF 00    AND #$00FF             ;} Enemy projectile initialisation parameter 1 = [enemy parameter 2 low] (never read)
$A8:9686 8D 95 19    STA $1995  [$7E:1995]  ;/
$A8:9689 A9 01 00    LDA #$0001             ;\
$A8:968C A0 CA DF    LDY #$DFCA             ;} Spawn fune fireball enemy projectile with parameter 1 (direction = right)
$A8:968F 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:9693 7A          PLY
$A8:9694 6B          RTL
}


;;; $9695: Instruction - finish activity ;;;
{
$A8:9695 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9698 BD A8 0F    LDA $0FA8,x[$7E:1068]  ;\
$A8:969B 1A          INC A                  ;|
$A8:969C 1A          INC A                  ;|
$A8:969D 1A          INC A                  ;} Enemy instruction list pointers pointer += 4 (idle)
$A8:969E 1A          INC A                  ;|
$A8:969F 9D A8 0F    STA $0FA8,x[$7E:1068]  ;/
$A8:96A2 A9 37 97    LDA #$9737             ;\
$A8:96A5 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy function = $9737 (wait for timer)
$A8:96A8 BD AE 0F    LDA $0FAE,x[$7E:106E]  ;\
$A8:96AB F0 06       BEQ $06    [$96B3]     ;} If [enemy variant index] != fune:
$A8:96AD A9 5C 97    LDA #$975C             ;\
$A8:96B0 9D AA 0F    STA $0FAA,x[$7E:10AA]  ;} Enemy function = $975C (wait for Samus to get near)

$A8:96B3 6B          RTL
}


;;; $96B4: Instruction - finish activity ;;;
{
; Clone of $9695
$A8:96B4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:96B7 BD A8 0F    LDA $0FA8,x[$7E:1128]
$A8:96BA 1A          INC A
$A8:96BB 1A          INC A
$A8:96BC 1A          INC A
$A8:96BD 1A          INC A
$A8:96BE 9D A8 0F    STA $0FA8,x[$7E:1128]
$A8:96C1 A9 37 97    LDA #$9737
$A8:96C4 9D AA 0F    STA $0FAA,x[$7E:112A]
$A8:96C7 BD AE 0F    LDA $0FAE,x[$7E:112E]
$A8:96CA F0 06       BEQ $06    [$96D2]
$A8:96CC A9 5C 97    LDA #$975C
$A8:96CF 9D AA 0F    STA $0FAA,x[$7E:0FEA]

$A8:96D2 6B          RTL
}
}


;;; $96D3: Instruction list pointers ;;;
{
;                        ___________________ Active - facing left
;                       |     ______________ Active - facing right
;                       |    |      ________ Idle - facing left
;                       |    |     |     ___ Idle - facing right
;                       |    |     |    |
$A8:96D3             dw 939F,93CF, 9399,93C9 ; Fune
$A8:96DB             dw 95C3,95F7, 95BD,95F1 ; Namihe
}


;;; $96E3: Initialisation AI - enemy $E6FF/$E73F (fune / namihe) ;;;
{
$A8:96E3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:96E6 A9 D7 96    LDA #$96D7             ;\
$A8:96E9 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy instruction list pointers pointer = $96D3 + 4 (fune - active - facing left)
$A8:96EC A9 37 97    LDA #$9737             ;\
$A8:96EF 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy function = $9737 (wait for timer)
$A8:96F2 BD B4 0F    LDA $0FB4,x[$7E:1074]  ;\
$A8:96F5 29 0F 00    AND #$000F             ;} Enemy variant index = [enemy parameter 1 low] & Fh
$A8:96F8 9D AE 0F    STA $0FAE,x[$7E:106E]  ;/
$A8:96FB F0 0C       BEQ $0C    [$9709]     ; If [enemy variant index] != fune:
$A8:96FD A9 DF 96    LDA #$96DF             ;\
$A8:9700 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy instruction list pointers pointer = $96DB + 4 (namihe - active - facing left)
$A8:9703 A9 5C 97    LDA #$975C             ;\
$A8:9706 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy function = $975C (wait for Samus to get near)

$A8:9709 BD B4 0F    LDA $0FB4,x[$7E:1074]  ;\
$A8:970C 29 F0 00    AND #$00F0             ;} If [enemy parameter 1 low] & F0h != 0: (facing right)
$A8:970F F0 06       BEQ $06    [$9717]     ;/
$A8:9711 FE A8 0F    INC $0FA8,x[$7E:10A8]  ;\
$A8:9714 FE A8 0F    INC $0FA8,x[$7E:10A8]  ;} Enemy instruction list pointers pointer += 2 (facing right)

$A8:9717 20 9B 97    JSR $979B  [$A8:979B]  ; Set fune / namihe instruction list
$A8:971A BD B7 0F    LDA $0FB7,x[$7E:1077]  ;\
$A8:971D 29 FF 00    AND #$00FF             ;} Enemy Y proximity = [enemy parameter 2 high]
$A8:9720 9D AC 0F    STA $0FAC,x[$7E:106C]  ;/
$A8:9723 BD B5 0F    LDA $0FB5,x[$7E:1075]  ;\
$A8:9726 29 FF 00    AND #$00FF             ;} Enemy cooldown time = [enemy parameter 1 high]
$A8:9729 9D B2 0F    STA $0FB2,x[$7E:1072]  ;/
$A8:972C 9E B0 0F    STZ $0FB0,x[$7E:1070]  ; Enemy cooldown timer = 0
$A8:972F 6B          RTL
}


;;; $9730: Main AI - enemy $E6FF/$E73F (fune / namihe) ;;;
{
$A8:9730 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9733 FC AA 0F    JSR ($0FAA,x)[$A8:9737]; Execute [enemy function]
$A8:9736 6B          RTL
}


;;; $9737: Fune / namihe function - wait for timer (fune) ;;;
{
$A8:9737 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:973A FE B0 0F    INC $0FB0,x[$7E:1130]  ; Increment enemy cooldown timer
$A8:973D BD B0 0F    LDA $0FB0,x[$7E:1130]  ;\
$A8:9740 DD B2 0F    CMP $0FB2,x[$7E:1132]  ;} If [enemy cooldown timer] >= [enemy cooldown time]:
$A8:9743 30 16       BMI $16    [$975B]     ;/
$A8:9745 BD A8 0F    LDA $0FA8,x[$7E:1128]  ;\
$A8:9748 3A          DEC A                  ;|
$A8:9749 3A          DEC A                  ;|
$A8:974A 3A          DEC A                  ;} Enemy instruction list pointers pointer -= 4 (active)
$A8:974B 3A          DEC A                  ;|
$A8:974C 9D A8 0F    STA $0FA8,x[$7E:1128]  ;/
$A8:974F 20 9B 97    JSR $979B  [$A8:979B]  ; Set fune / namihe instruction list
$A8:9752 A9 8E 97    LDA #$978E             ;\
$A8:9755 9D AA 0F    STA $0FAA,x[$7E:112A]  ;} Enemy function = RTS
$A8:9758 9E B0 0F    STZ $0FB0,x[$7E:1130]  ; Enemy cooldown timer = 0

$A8:975B 60          RTS
}


;;; $975C: Fune / namihe function - wait for Samus to get near (namihe) ;;;
{
$A8:975C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:975F BD A8 0F    LDA $0FA8,x[$7E:10A8]  ;\
$A8:9762 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy $7E:7800 = [enemy instruction list pointers pointer] (not meaningfully used)
$A8:9766 20 90 97    JSR $9790  [$A8:9790]  ;\
$A8:9769 F0 1B       BEQ $1B    [$9786]     ;} If Samus is in proximity:
$A8:976B BF 00 78 7E LDA $7E7800,x[$7E:7900];\
$A8:976F 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} >_<;
$A8:9772 3A          DEC A                  ;\
$A8:9773 3A          DEC A                  ;|
$A8:9774 3A          DEC A                  ;|
$A8:9775 3A          DEC A                  ;} Enemy instruction list pointers pointer -= 4 (active)
$A8:9776 9F 00 78 7E STA $7E7800,x[$7E:7900];|
$A8:977A 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;/
$A8:977D 20 9B 97    JSR $979B  [$A8:979B]  ; Set fune / namihe instruction list
$A8:9780 A9 8F 97    LDA #$978F             ;\
$A8:9783 9D AA 0F    STA $0FAA,x[$7E:10AA]  ;} Enemy function = RTS

$A8:9786 BF 00 78 7E LDA $7E7800,x[$7E:7900];\
$A8:978A 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} >_<;
$A8:978D 60          RTS
}


;;; $978E: RTS ;;;
{
$A8:978E 60          RTS
}


;;; $978F: RTS ;;;
{
$A8:978F 60          RTS
}


;;; $9790: Check if Samus is in proximity ;;;
{
;; Returns:
;;     Zero: Clear if Samus is in proximity, set otherwise
$A8:9790 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9793 BD AC 0F    LDA $0FAC,x[$7E:10AC]  ;\
$A8:9796 22 ED AE A0 JSL $A0AEED[$A0:AEED]  ;} Is Samus is within [enemy Y proximity] pixel rows of enemy
$A8:979A 60          RTS
}


;;; $979B: Set fune / namihe instruction list ;;;
{
$A8:979B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:979E A9 01 00    LDA #$0001             ;\
$A8:97A1 9D 94 0F    STA $0F94,x[$7E:1054]  ;} Enemy instruction timer = 1
$A8:97A4 9E 90 0F    STZ $0F90,x[$7E:1050]  ; Enemy timer = 0
$A8:97A7 BD A8 0F    LDA $0FA8,x[$7E:1068]  ;\
$A8:97AA A8          TAY                    ;|
$A8:97AB B9 00 00    LDA $0000,y[$A8:96D7]  ;} Enemy instruction list pointer = [[enemy instruction list pointers pointer]]
$A8:97AE 9D 92 0F    STA $0F92,x[$7E:1052]  ;/
$A8:97B1 60          RTS
}


;;; $97B2: RTL ;;;
{
$A8:97B2 6B          RTL
}


;;; $97B3: RTL ;;;
{
$A8:97B3 6B          RTL
}


;;; $97B4: Namihe spritemaps ;;;
{
; Facing left
$A8:97B4             dx 0008, 0008,0C,2127, 0000,0C,2126, 8000,FC,2122, 8000,EC,2120, 81F0,00,2106, 01F8,FC,2135, 01F0,FC,2134, 81F0,EC,2104
$A8:97DE             dx 0008, 81F0,00,2106, 01F8,EC,2105, 01F0,EC,2104, 81F0,F4,2108, 0008,0C,2127, 0000,0C,2126, 8000,FC,2122, 8000,EC,2120
$A8:9808             dx 0008, 81EE,02,2106, 01F6,EC,2105, 01EE,EC,2104, 81EE,F4,2108, 0006,0C,2127, 01FE,0C,2126, 81FE,FC,2122, 81FE,EC,2120
$A8:9832             dx 0008, 81EC,03,2106, 01F4,EC,2105, 01EC,EC,2104, 81EC,F4,2108, 0004,0C,2127, 01FC,0C,2126, 81FC,FC,2122, 81FC,EC,2120
$A8:985C             dx 0008, 81EA,04,2106, 01F2,EC,2105, 01EA,EC,2104, 81EA,F4,2108, 0002,0C,2127, 01FA,0C,2126, 81FA,FC,2122, 81FA,EC,2120
$A8:9886             dx 0008, 81E9,05,2106, 01F0,EC,2105, 01E8,EC,2104, 81E8,F4,2108, 0000,0C,2127, 01F8,0C,2126, 81F8,FC,2122, 81F8,EC,2120

; Facing right
$A8:98B0             dx 0008, 01F0,0C,6127, 01F8,0C,6126, 81F0,FC,6122, 81F0,EC,6120, 8000,00,6106, 0000,FC,6135, 0008,FC,6134, 8000,EC,6104
$A8:98DA             dx 0008, 8000,00,6106, 0000,EC,6105, 0008,EC,6104, 8000,F4,6108, 01F0,0C,6127, 01F8,0C,6126, 81F0,FC,6122, 81F0,EC,6120
$A8:9904             dx 0008, 8002,02,6106, 0002,EC,6105, 000A,EC,6104, 8002,F4,6108, 01F2,0C,6127, 01FA,0C,6126, 81F2,FC,6122, 81F2,EC,6120
$A8:992E             dx 0008, 8004,03,6106, 0004,EC,6105, 000C,EC,6104, 8004,F4,6108, 01F4,0C,6127, 01FC,0C,6126, 81F4,FC,6122, 81F4,EC,6120
$A8:9958             dx 0008, 8006,04,6106, 0006,EC,6105, 000E,EC,6104, 8006,F4,6108, 01F6,0C,6127, 01FE,0C,6126, 81F6,FC,6122, 81F6,EC,6120
$A8:9982             dx 0008, 8007,05,6106, 0008,EC,6105, 0010,EC,6104, 8008,F4,6108, 01F8,0C,6127, 0000,0C,6126, 81F8,FC,6122, 81F8,EC,6120
}
}


;;; $99AC..9F4E: Coven ;;;
{
;;; $99AC: Palette - enemy $E77F (coven) ;;;
{
$A8:99AC             dw 3800, 57FF, 42F7, 0929, 00A5, 4F5A, 36B5, 2610, 1DCE, 01DF, 001F, 0018, 000A, 06B9, 00EA, 0045
}


;;; $99CC: Unused. Black palettes ;;;
{
$A8:99CC             dw 3800, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$A8:99EC             dw 3800, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$A8:9A0C             dw 3800, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$A8:9A2C             dw 3800, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$A8:9A4C             dw 3800, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
$A8:9A6C             dw 3800, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $9A8C: Instruction list - coven ;;;
{
$A8:9A8C             dx 0010,9E46,
                        0010,9E5C,
                        0010,9E72,
                        80ED,9A8C   ; Go to $9A8C
}


;;; $9A9C: Coven constants ;;;
{
$A8:9A9C             dw 0010 ; Number of times Samus has to move in the same direction to materialise
$A8:9A9E             dw 0040 ; Number of frames Samus has to remain stationary to materialise
$A8:9AA0             dw 1800 ; Hovering Y acceleration/deceleration
$A8:9AA2             dw 0001 ; Initial hovering Y velocity
$A8:9AA4             dw 0078 ; Number of frames to sleep after dematerialising
$A8:9AA6             dw 0078 ; Number of frames to be materialised for

; X/Y offsets from Samus position to materialise when Samus has been moving a given direction
$A8:9AA8             dw FFC0,FFC0, ; 0: Up-left
                        0000,FFC0, ; 4: Up
                        0040,0000, ; 8: Up-right
                        FFC0,0000, ; Ch: Left
                        0000,0000, ; 10h: None (dummy)
                        0040,0000, ; 14h: Right
                        FFC0,0040, ; 18h: Down-left
                        0000,0040, ; 1Ch: Down
                        0040,0040  ; 20h: Down-right

; Palette transition delay table
$A8:9ACC             dw 0001, 0008, 0001, 0008, 0001, 0007, 0001, 0007, 0002, 0006, 0002, 0006, 0003, 0005, 0003, 0005,
                        FFFF
}


;;; $9AEE: Initialisation AI - enemy $E77F (coven) ;;;
{
$A8:9AEE AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9AF1 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:9AF4 09 00 25    ORA #$2500             ;} Set enemy to process instructions, as intangible and invisible
$A8:9AF7 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:9AFA A9 01 00    LDA #$0001             ;\
$A8:9AFD 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:9B00 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:9B03 A9 8C 9A    LDA #$9A8C             ;\
$A8:9B06 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $9A8C
$A8:9B09 A9 13 9D    LDA #$9D13             ;\
$A8:9B0C 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9D13 (dematerialised - asleep)
$A8:9B0F AD A4 9A    LDA $9AA4  [$A8:9AA4]  ;\
$A8:9B12 18          CLC                    ;|
$A8:9B13 69 A0 00    ADC #$00A0             ;} Enemy function timer = 280
$A8:9B16 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:9B19 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9B1C BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:9B1F EB          XBA                    ;|
$A8:9B20 0A          ASL A                  ;|
$A8:9B21 0A          ASL A                  ;|
$A8:9B22 0A          ASL A                  ;|
$A8:9B23 0A          ASL A                  ;|
$A8:9B24 18          CLC                    ;|
$A8:9B25 69 00 01    ADC #$0100             ;|
$A8:9B28 AA          TAX                    ;|
$A8:9B29 A9 10 00    LDA #$0010             ;} Target enemy sprite palette = 0
$A8:9B2C 85 12       STA $12    [$7E:0012]  ;|
$A8:9B2E A9 00 00    LDA #$0000             ;|
                                            ;|
$A8:9B31 9F 00 C2 7E STA $7EC200,x[$7E:C320];|
$A8:9B35 E8          INX                    ;|
$A8:9B36 E8          INX                    ;|
$A8:9B37 C6 12       DEC $12    [$7E:0012]  ;|
$A8:9B39 10 F6       BPL $F6    [$9B31]     ;/
$A8:9B3B 6B          RTL
}


;;; $9B3C: Main AI - enemy $E77F (coven) ;;;
{
$A8:9B3C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9B3F 7C A8 0F    JMP ($0FA8,x)[$A8:9D13]; Go to [enemy function]
}


;;; $9B42: Coven function - materialising - fade to white ;;;
{
; You only see this fade to white transition once where it transitions from the initial black palette
; On subsequent calls to this function, it will already have a white palette from the dematerialisation fade to white
$A8:9B42 DA          PHX
$A8:9B43 20 31 9C    JSR $9C31  [$A8:9C31]  ; Process coven palette transition delay
$A8:9B46 A0 10 00    LDY #$0010             ; Y = 10h
$A8:9B49 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9B4C BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:9B4F EB          XBA                    ;|
$A8:9B50 0A          ASL A                  ;|
$A8:9B51 0A          ASL A                  ;|
$A8:9B52 0A          ASL A                  ;} X = 100h + [enemy palette index] / 10h
$A8:9B53 0A          ASL A                  ;|
$A8:9B54 18          CLC                    ;|
$A8:9B55 69 00 01    ADC #$0100             ;|
$A8:9B58 AA          TAX                    ;/
$A8:9B59 A9 10 00    LDA #$0010             ;\
$A8:9B5C 85 12       STA $12    [$7E:0012]  ;} $12 = 10h

; LOOP
$A8:9B5E BF 00 C0 7E LDA $7EC000,x[$7E:C120];\
$A8:9B62 29 1F 00    AND #$001F             ;|
$A8:9B65 C9 1F 00    CMP #$001F             ;} If [$7E:C000 + [X]] & 1Fh (red component) != 1Fh:
$A8:9B68 10 0D       BPL $0D    [$9B77]     ;/
$A8:9B6A BF 00 C0 7E LDA $7EC000,x[$7E:C120];\
$A8:9B6E 18          CLC                    ;|
$A8:9B6F 69 21 04    ADC #$0421             ;} $7E:C000 + [X] += 1 | 1 << 5 | 1 << Ah (increment each colour component)
$A8:9B72 9F 00 C0 7E STA $7EC000,x[$7E:C120];/
$A8:9B76 88          DEY                    ; Decrement Y

$A8:9B77 E8          INX                    ;\
$A8:9B78 E8          INX                    ;} X += 2
$A8:9B79 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$A8:9B7B D0 E1       BNE $E1    [$9B5E]     ; If [$12] != 0: go to LOOP
$A8:9B7D C0 10 00    CPY #$0010             ;\
$A8:9B80 30 29       BMI $29    [$9BAB]     ;} If [Y] < 10h: return
$A8:9B82 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9B85 A9 AD 9B    LDA #$9BAD             ;\
$A8:9B88 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9BAD (materialising - fade from white)
$A8:9B8B BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:9B8E EB          XBA                    ;|
$A8:9B8F 0A          ASL A                  ;|
$A8:9B90 0A          ASL A                  ;|
$A8:9B91 0A          ASL A                  ;|
$A8:9B92 0A          ASL A                  ;|
$A8:9B93 18          CLC                    ;|
$A8:9B94 69 00 01    ADC #$0100             ;|
$A8:9B97 AA          TAX                    ;|
$A8:9B98 A0 00 00    LDY #$0000             ;} Target enemy sprite palette = [$99AC..CB]
                                            ;|
$A8:9B9B B9 AC 99    LDA $99AC,y[$A8:99AC]  ;|
$A8:9B9E 9F 00 C2 7E STA $7EC200,x[$7E:C320];|
$A8:9BA2 E8          INX                    ;|
$A8:9BA3 E8          INX                    ;|
$A8:9BA4 C8          INY                    ;|
$A8:9BA5 C8          INY                    ;|
$A8:9BA6 C0 20 00    CPY #$0020             ;|
$A8:9BA9 30 F0       BMI $F0    [$9B9B]     ;/

$A8:9BAB FA          PLX
$A8:9BAC 6B          RTL
}


;;; $9BAD: Coven function - materialising - fade from white ;;;
{
$A8:9BAD 20 88 9E    JSR $9E88  [$A8:9E88]  ; Advance coven palette transition
$A8:9BB0 48          PHA                    ;\
$A8:9BB1 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A8:9BB4 20 31 9C    JSR $9C31  [$A8:9C31]  ;} Process coven palette transition delay
$A8:9BB7 68          PLA                    ;/
$A8:9BB8 1D AA 0F    ORA $0FAA,x[$7E:0FAA]  ;\
$A8:9BBB D0 73       BNE $73    [$9C30]     ;} If transition not complete or [enemy function timer] != 0: return
$A8:9BBD BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:9BC0 29 FF FB    AND #$FBFF             ;|
$A8:9BC3 29 FF FE    AND #$FEFF             ;} Set enemy as tangible and visible
$A8:9BC6 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:9BC9 A9 8A 9C    LDA #$9C8A             ;\
$A8:9BCC 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9C8A (materialised)
$A8:9BCF BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:9BD2 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy hover centre Y position = [enemy Y position]
$A8:9BD6 A9 01 00    LDA #$0001             ;\
$A8:9BD9 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} >_<;
$A8:9BDC A9 02 00    LDA #$0002             ;\
$A8:9BDF 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy palette transition delay index = 2
$A8:9BE2 A9 00 00    LDA #$0000             ;\
$A8:9BE5 9F 02 78 7E STA $7E7802,x[$7E:7802];|
$A8:9BE9 AD A2 9A    LDA $9AA2  [$A8:9AA2]  ;} Enemy Y velocity = 1.0
$A8:9BEC 9F 04 78 7E STA $7E7804,x[$7E:7804];/
$A8:9BF0 AD A6 9A    LDA $9AA6  [$A8:9AA6]  ;\
$A8:9BF3 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy function timer = 120
$A8:9BF6 A9 04 00    LDA #$0004             ;\
$A8:9BF9 9F 0A 78 7E STA $7E780A,x[$7E:780A];} Enemy previous Samus X movement direction = none
$A8:9BFD AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:9C00 9F 0C 78 7E STA $7E780C,x[$7E:780C];} Enemy previous Samus X position = [Samus X position]
$A8:9C04 9F 0E 78 7E STA $7E780E,x[$7E:780E]; Enemy zone left position = [Samus X position]
$A8:9C08 9F 10 78 7E STA $7E7810,x[$7E:7810]; Enemy zone right position = [Samus X position]
$A8:9C0C A9 0C 00    LDA #$000C             ;\
$A8:9C0F 9F 12 78 7E STA $7E7812,x[$7E:7812];} Enemy previous Samus Y movement direction = none
$A8:9C13 BD FA 0A    LDA $0AFA,x[$7E:0AFA]  ;\
$A8:9C16 9F 14 78 7E STA $7E7814,x[$7E:7814];} Enemy previous Samus Y position = [Samus Y position] (buggy)
$A8:9C1A 9F 16 78 7E STA $7E7816,x[$7E:7816]; Enemy zone top position = [Samus Y position]
$A8:9C1E 9F 18 78 7E STA $7E7818,x[$7E:7818]; Enemy zone bottom position = [Samus Y position]
$A8:9C22 AD 9E 9A    LDA $9A9E  [$A8:9A9E]  ;\
$A8:9C25 9F 1A 78 7E STA $7E781A,x[$7E:781A];} Enemy lock-on timer = 40h
$A8:9C29 AD 9C 9A    LDA $9A9C  [$A8:9A9C]  ;\
$A8:9C2C 9F 1C 78 7E STA $7E781C,x[$7E:781C];} Enemy directed movement timer = 10h

$A8:9C30 6B          RTL
}


;;; $9C31: Process coven palette transition delay ;;;
{
$A8:9C31 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:9C34 F0 1F       BEQ $1F    [$9C55]     ;} If [enemy function timer] != 0:
$A8:9C36 3A          DEC A                  ;\
$A8:9C37 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Decrement enemy function timer
$A8:9C3A D0 18       BNE $18    [$9C54]     ; If [enemy function timer] != 0: return
$A8:9C3C BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:9C3F A8          TAY                    ;} Y = [enemy palette transition delay index]
$A8:9C40 B9 CC 9A    LDA $9ACC,y[$A8:9ACE]  ;\
$A8:9C43 30 1A       BMI $1A    [$9C5F]     ;} If [$9ACC + [Y]] < 0: go to BRANCH_END
$A8:9C45 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ; Enemy function timer = [$9ACC + [Y]]
$A8:9C48 98          TYA                    ;\
$A8:9C49 1A          INC A                  ;|
$A8:9C4A 1A          INC A                  ;} Enemy palette transition delay index += 2
$A8:9C4B 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;/
$A8:9C4E 98          TYA                    ;\
$A8:9C4F 89 02 00    BIT #$0002             ;} If [Y] / 2 % 2 != 0:
$A8:9C52 F0 01       BEQ $01    [$9C55]     ;/
$A8:9C54 60          RTS                    ; Return

$A8:9C55 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:9C58 29 FF FE    AND #$FEFF             ;} Set enemy as visible
$A8:9C5B 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:9C5E 60          RTS                    ; Return

; BRANCH_END
$A8:9C5F A9 00 00    LDA #$0000             ;\
$A8:9C62 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy function timer = 0
$A8:9C65 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ; Enemy palette transition delay index = 0
$A8:9C68 60          RTS
}


;;; $9C69: Coven function - dematerialising ;;;
{
$A8:9C69 20 88 9E    JSR $9E88  [$A8:9E88]  ; Advance coven palette transition
$A8:9C6C C9 00 00    CMP #$0000             ;\
$A8:9C6F D0 18       BNE $18    [$9C89]     ;} If completed transition:
$A8:9C71 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9C74 A9 13 9D    LDA #$9D13             ;\
$A8:9C77 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9D13 (dematerialised - asleep)
$A8:9C7A BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:9C7D 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A8:9C80 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:9C83 AD A4 9A    LDA $9AA4  [$A8:9AA4]  ;\
$A8:9C86 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy function timer = 120

$A8:9C89 6B          RTL
}


;;; $9C8A: Coven function - materialised ;;;
{
$A8:9C8A BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A8:9C8D 18          CLC                    ;|
$A8:9C8E 7F 02 78 7E ADC $7E7802,x[$7E:7802];|
$A8:9C92 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y position += [enemy Y velocity]
$A8:9C95 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A8:9C98 7F 04 78 7E ADC $7E7804,x[$7E:7804];|
$A8:9C9C 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A8:9C9F BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:9CA2 DF 00 78 7E CMP $7E7800,x[$7E:7800];} If [enemy Y position] >= [enemy hover centre Y position]:
$A8:9CA6 30 19       BMI $19    [$9CC1]     ;/
$A8:9CA8 BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A8:9CAC 38          SEC                    ;|
$A8:9CAD ED A0 9A    SBC $9AA0  [$A8:9AA0]  ;|
$A8:9CB0 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy Y velocity -= 0.1800h
$A8:9CB4 BF 04 78 7E LDA $7E7804,x[$7E:7804];|
$A8:9CB8 E9 00 00    SBC #$0000             ;|
$A8:9CBB 9F 04 78 7E STA $7E7804,x[$7E:7804];/
$A8:9CBF 80 17       BRA $17    [$9CD8]

$A8:9CC1 BF 02 78 7E LDA $7E7802,x[$7E:7802];\ Else ([enemy Y position] < [enemy hover centre Y position]):
$A8:9CC5 18          CLC                    ;|
$A8:9CC6 6D A0 9A    ADC $9AA0  [$A8:9AA0]  ;|
$A8:9CC9 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy Y velocity += 0.1800h
$A8:9CCD BF 04 78 7E LDA $7E7804,x[$7E:7804];|
$A8:9CD1 69 00 00    ADC #$0000             ;|
$A8:9CD4 9F 04 78 7E STA $7E7804,x[$7E:7804];/

$A8:9CD8 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:9CDB 3A          DEC A                  ;} Decrement enemy function timer
$A8:9CDC 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:9CDF D0 31       BNE $31    [$9D12]     ; If [enemy function timer] != 0: return
$A8:9CE1 A9 69 9C    LDA #$9C69             ;\
$A8:9CE4 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9C69 (dematerialising)
$A8:9CE7 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:9CEA 09 00 04    ORA #$0400             ;} Set enemy as intangible
$A8:9CED 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:9CF0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9CF3 BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:9CF6 EB          XBA                    ;|
$A8:9CF7 0A          ASL A                  ;|
$A8:9CF8 0A          ASL A                  ;|
$A8:9CF9 0A          ASL A                  ;|
$A8:9CFA 0A          ASL A                  ;|
$A8:9CFB 18          CLC                    ;|
$A8:9CFC 69 00 01    ADC #$0100             ;|
$A8:9CFF AA          TAX                    ;|
$A8:9D00 A9 10 00    LDA #$0010             ;} Enemy target sprite palette = 7FFFh
$A8:9D03 85 12       STA $12    [$7E:0012]  ;|
$A8:9D05 A9 FF 7F    LDA #$7FFF             ;|
                                            ;|
$A8:9D08 9F 00 C2 7E STA $7EC200,x[$7E:C320];|
$A8:9D0C E8          INX                    ;|
$A8:9D0D E8          INX                    ;|
$A8:9D0E C6 12       DEC $12    [$7E:0012]  ;|
$A8:9D10 10 F6       BPL $F6    [$9D08]     ;/

$A8:9D12 6B          RTL
}


;;; $9D13: Coven function - dematerialised - asleep ;;;
{
$A8:9D13 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:9D16 F0 06       BEQ $06    [$9D1E]     ;} If [enemy function timer] != 0:
$A8:9D18 3A          DEC A                  ;\
$A8:9D19 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Decrement enemy function timer
$A8:9D1C D0 12       BNE $12    [$9D30]     ; If [enemy function timer] != 0: return

$A8:9D1E A9 01 00    LDA #$0001             ;\
$A8:9D21 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy function timer = 1
$A8:9D24 A9 02 00    LDA #$0002             ;\
$A8:9D27 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy palette transition delay index = 2
$A8:9D2A A9 36 9D    LDA #$9D36             ;\
$A8:9D2D 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9D36 (dematerialised - awake)

$A8:9D30 6B          RTL
}


;;; $9D31: RTL ;;;
{
$A8:9D31 6B          RTL
}


;;; $9D32: Coven stationary zone radii ;;;
{
; Number of pixels of tolerance to consider Samus stationary for the materialisation check
$A8:9D32             dw 0001 ; X radius
$A8:9D34             dw 0001 ; Y radius
}


;;; $9D36: Coven function - dematerialised - awake ;;;
{
; The Samus position loads at $9D45 / $9DC3 / $9DCD are erroneously being indexed by X, which is the enemy index
; Consequently, this code has unexpected results if the enemy is not enemy slot 0

; Materialise if Samus has moved at most 1px/frame for 40h frames (tracked by the "lock-on timer" and "zone" variables)
; or has moved more than 1px/frame in the same direction 10h times (tracked by the "directed movement timer" and "previous Samus" variables)
$A8:9D36 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:9D39 DF 0E 78 7E CMP $7E780E,x[$7E:780E];|
$A8:9D3D 30 33       BMI $33    [$9D72]     ;} If not [enemy zone left position] <= [Samus X position] < [enemy zone right position]: go to BRANCH_BREAK_LOCK_ON
$A8:9D3F DF 10 78 7E CMP $7E7810,x[$7E:7810];|
$A8:9D43 10 2D       BPL $2D    [$9D72]     ;/
$A8:9D45 BD FA 0A    LDA $0AFA,x[$7E:0AFA]  ;\
$A8:9D48 DF 16 78 7E CMP $7E7816,x[$7E:7816];|
$A8:9D4C 30 24       BMI $24    [$9D72]     ;} If not [enemy zone top position] <= [Samus Y position] (buggy) < [enemy zone bottom position]: go to BRANCH_BREAK_LOCK_ON
$A8:9D4E DF 18 78 7E CMP $7E7818,x[$7E:7818];|
$A8:9D52 10 1E       BPL $1E    [$9D72]     ;/
$A8:9D54 BF 1A 78 7E LDA $7E781A,x[$7E:781A];\
$A8:9D58 3A          DEC A                  ;} Decrement enemy lock-on timer
$A8:9D59 9F 1A 78 7E STA $7E781A,x[$7E:781A];/
$A8:9D5D F0 03       BEQ $03    [$9D62]     ; If [enemy lock-on timer] != 0:
$A8:9D5F 4C 0F 9E    JMP $9E0F  [$A8:9E0F]  ; Go to BRANCH_UPDATE_ZONE

$A8:9D62 A9 04 00    LDA #$0004             ;\
$A8:9D65 9F 0A 78 7E STA $7E780A,x          ;} Enemy previous Samus X movement direction = 4 (none)
$A8:9D69 A9 0C 00    LDA #$000C             ;\
$A8:9D6C 9F 12 78 7E STA $7E7812,x          ;} Enemy previous Samus Y movement direction = Ch (none)
$A8:9D70 80 33       BRA $33    [$9DA5]     ; Go to BRANCH_MATERIALISE

; BRANCH_BREAK_LOCK_ON
$A8:9D72 AD 9E 9A    LDA $9A9E  [$A8:9A9E]  ;\
$A8:9D75 9F 1A 78 7E STA $7E781A,x[$7E:781A];} Enemy lock-on timer = 40h
$A8:9D79 A0 00 00    LDY #$0000             ; Y = 0 (left)
$A8:9D7C AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:9D7F 38          SEC                    ;|
$A8:9D80 FF 0C 78 7E SBC $7E780C,x[$7E:780C];} If [Samus X position] < [enemy previous Samus X position]: go to BRANCH_CHECK_X_MOVEMENT_DIRECTION
$A8:9D84 30 0A       BMI $0A    [$9D90]     ;/
$A8:9D86 F0 05       BEQ $05    [$9D8D]     ; If [Samus X position] > [enemy previous Samus X position]:
$A8:9D88 A0 08 00    LDY #$0008             ; Y = 8 (right)
$A8:9D8B 80 03       BRA $03    [$9D90]
                                            ; Else ([Samus X position] = [enemy previous Samus X position]):
$A8:9D8D A0 04 00    LDY #$0004             ; Y = 4 (none)

; BRANCH_CHECK_X_MOVEMENT_DIRECTION
$A8:9D90 98          TYA                    ;\
$A8:9D91 DF 0A 78 7E CMP $7E780A,x[$7E:780A];} If [Y] = [enemy previous Samus X movement direction]: go to BRANCH_CHECK_Y_MOVEMENT
$A8:9D95 F0 41       BEQ $41    [$9DD8]     ;/
$A8:9D97 98          TYA                    ; >_<;
$A8:9D98 9F 0A 78 7E STA $7E780A,x[$7E:780A]; Enemy previous Samus X movement direction = [Y]
$A8:9D9C AD 9C 9A    LDA $9A9C  [$A8:9A9C]  ;\
$A8:9D9F 9F 1C 78 7E STA $7E781C,x[$7E:781C];} Enemy directed movement timer = 10h
$A8:9DA3 80 6A       BRA $6A    [$9E0F]     ; Go to BRANCH_UPDATE_ZONE

; BRANCH_MATERIALISE
$A8:9DA5 A9 42 9B    LDA #$9B42             ;\
$A8:9DA8 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $9B42 (materialising - fade to white)
$A8:9DAB AD 9E 9A    LDA $9A9E  [$A8:9A9E]  ;\
$A8:9DAE 9F 1A 78 7E STA $7E781A,x[$7E:781A];} Enemy lock-on timer = 40h
$A8:9DB2 AD 9C 9A    LDA $9A9C  [$A8:9A9C]  ;\
$A8:9DB5 9F 1C 78 7E STA $7E781C,x[$7E:781C];} Enemy directed movement timer = 10h
$A8:9DB9 BF 0A 78 7E LDA $7E780A,x[$7E:780A];\
$A8:9DBD 18          CLC                    ;|
$A8:9DBE 7F 12 78 7E ADC $7E7812,x[$7E:7812];} Y = [enemy previous Samus Y movement direction] + [enemy previous Samus X movement direction]
$A8:9DC2 A8          TAY                    ;/
$A8:9DC3 BD F6 0A    LDA $0AF6,x[$7E:0AF6]  ;\
$A8:9DC6 18          CLC                    ;|
$A8:9DC7 79 A8 9A    ADC $9AA8,y[$A8:9AB0]  ;} Enemy X position = [Samus X position] (buggy) + [$9AA8 + [Y]]
$A8:9DCA 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A8:9DCD BD FA 0A    LDA $0AFA,x[$7E:0AFA]  ;\
$A8:9DD0 18          CLC                    ;|
$A8:9DD1 79 AA 9A    ADC $9AAA,y[$A8:9AB2]  ;} Enemy Y position = [Samus Y position] (buggy) + [$9AA8 + [Y] + 2]
$A8:9DD4 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A8:9DD7 6B          RTL                    ; Return

; BRANCH_CHECK_Y_MOVEMENT
$A8:9DD8 A0 00 00    LDY #$0000             ; Y = 0 (up)
$A8:9DDB AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:9DDE 38          SEC                    ;|
$A8:9DDF FF 14 78 7E SBC $7E7814,x[$7E:7814];} If [Samus Y position] < [enemy previous Samus Y position]: go to BRANCH_CHECK_Y_MOVEMENT_DIRECTION
$A8:9DE3 30 0A       BMI $0A    [$9DEF]     ;/
$A8:9DE5 F0 05       BEQ $05    [$9DEC]     ; If [Samus Y position] > [enemy previous Samus Y position]:
$A8:9DE7 A0 18 00    LDY #$0018             ; Y = 18h (down)
$A8:9DEA 80 03       BRA $03    [$9DEF]
                                            ; Else ([Samus Y position] = [enemy previous Samus Y position]):
$A8:9DEC A0 0C 00    LDY #$000C             ; Y = Ch (none)

; BRANCH_CHECK_Y_MOVEMENT_DIRECTION
$A8:9DEF 98          TYA                    ;\
$A8:9DF0 DF 12 78 7E CMP $7E7812,x[$7E:7812];} If [Y] != [enemy previous Samus Y movement direction]:
$A8:9DF4 F0 0E       BEQ $0E    [$9E04]     ;/
$A8:9DF6 98          TYA                    ; >_<;
$A8:9DF7 9F 12 78 7E STA $7E7812,x[$7E:7812]; Enemy previous Samus Y movement direction = [Y]
$A8:9DFB AD 9C 9A    LDA $9A9C  [$A8:9A9C]  ;\
$A8:9DFE 9F 1C 78 7E STA $7E781C,x[$7E:781C];} Enemy directed movement timer = 10h
$A8:9E02 80 0B       BRA $0B    [$9E0F]

$A8:9E04 BF 1C 78 7E LDA $7E781C,x[$7E:781C];\ Else ([Y] = [enemy previous Samus Y movement direction]):
$A8:9E08 3A          DEC A                  ;} Decrement enemy directed movement timer
$A8:9E09 9F 1C 78 7E STA $7E781C,x[$7E:781C];/
$A8:9E0D F0 96       BEQ $96    [$9DA5]     ; If [enemy directed movement timer] = 0: go to BRANCH_MATERIALISE

; BRANCH_UPDATE_ZONE
$A8:9E0F AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:9E12 9F 0C 78 7E STA $7E780C,x[$7E:780C];} Enemy previous Samus X position = [Samus X position]
$A8:9E16 38          SEC                    ;\
$A8:9E17 ED 32 9D    SBC $9D32  [$A8:9D32]  ;} Enemy zone left position = [Samus X position] - 1
$A8:9E1A 9F 0E 78 7E STA $7E780E,x[$7E:780E];/
$A8:9E1E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:9E21 18          CLC                    ;|
$A8:9E22 6D 32 9D    ADC $9D32  [$A8:9D32]  ;} Enemy zone right position = [Samus X position] + 1
$A8:9E25 9F 10 78 7E STA $7E7810,x[$7E:7810];/
$A8:9E29 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:9E2C 9F 14 78 7E STA $7E7814,x[$7E:7814];} Enemy previous Samus Y position = [Samus Y position]
$A8:9E30 38          SEC                    ;\
$A8:9E31 ED 34 9D    SBC $9D34  [$A8:9D34]  ;} Enemy zone top position = [Samus Y position] - 1
$A8:9E34 9F 16 78 7E STA $7E7816,x[$7E:7816];/
$A8:9E38 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:9E3B 18          CLC                    ;|
$A8:9E3C 6D 34 9D    ADC $9D34  [$A8:9D34]  ;} Enemy zone bottom position = [Samus Y position] + 1
$A8:9E3F 9F 18 78 7E STA $7E7818,x[$7E:7818];/
$A8:9E43 6B          RTL
}


;;; $9E44: RTL ;;;
{
$A8:9E44 6B          RTL
}


;;; $9E45: RTL ;;;
{
$A8:9E45 6B          RTL
}


;;; $9E46: Coven spritemaps ;;;
{
$A8:9E46             dx 0004, 8000,00,3106, 81F0,00,3104, 8000,F0,3102, 81F0,F0,3100
$A8:9E5C             dx 0004, 8000,00,310A, 81F0,00,3108, 8000,F0,3102, 81F0,F0,3100
$A8:9E72             dx 0004, 8000,00,310E, 81F0,00,310C, 8000,F0,3102, 81F0,F0,3100
}


;;; $9E88: Advance coven palette transition ;;;
{
;; Returns:
;;     A: Zero if completed transition, non-zero otherwise
$A8:9E88 08          PHP
$A8:9E89 DA          PHX
$A8:9E8A 5A          PHY
$A8:9E8B C2 30       REP #$30
$A8:9E8D A0 00 00    LDY #$0000             ; Y = 0
$A8:9E90 AD 97 07    LDA $0797  [$7E:0797]  ;\
$A8:9E93 F0 03       BEQ $03    [$9E98]     ;} If [door transition flag] != 0:
$A8:9E95 4C 4A 9F    JMP $9F4A  [$A8:9F4A]  ; Go to BRANCH_RETURN

$A8:9E98 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:9E9B BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:9E9E EB          XBA                    ;|
$A8:9E9F 0A          ASL A                  ;|
$A8:9EA0 0A          ASL A                  ;|
$A8:9EA1 0A          ASL A                  ;} X = 100h + [enemy palette index] / 10h (palette colour index)
$A8:9EA2 0A          ASL A                  ;|
$A8:9EA3 18          CLC                    ;|
$A8:9EA4 69 00 01    ADC #$0100             ;|
$A8:9EA7 AA          TAX                    ;/
$A8:9EA8 18          CLC                    ;\
$A8:9EA9 69 20 00    ADC #$0020             ;} $14 = [X] + 20h
$A8:9EAC 85 14       STA $14    [$7E:0014]  ;/

; LOOP
$A8:9EAE BF 00 C2 7E LDA $7EC200,x[$7E:C320];\
$A8:9EB2 DF 00 C0 7E CMP $7EC000,x[$7E:C120];} If (palette colour) = (target palette colour):
$A8:9EB6 D0 03       BNE $03    [$9EBB]     ;/
$A8:9EB8 4C 41 9F    JMP $9F41  [$A8:9F41]  ; Go to BRANCH_NEXT

$A8:9EBB 29 1F 00    AND #$001F             ;\
$A8:9EBE 85 12       STA $12    [$7E:0012]  ;} $12 = (target palette colour) & 1Fh (target red component)
$A8:9EC0 BF 00 C0 7E LDA $7EC000,x[$7E:C120];\
$A8:9EC4 29 1F 00    AND #$001F             ;} A = (palette colour) & 1Fh (red component)
$A8:9EC7 C5 12       CMP $12    [$7E:0012]  ;\
$A8:9EC9 F0 16       BEQ $16    [$9EE1]     ;} If (red component) = (target red component): go to BRANCH_RED_END
$A8:9ECB 10 03       BPL $03    [$9ED0]     ; If (red component) < (target red component):
$A8:9ECD 1A          INC A                  ; A += 1
$A8:9ECE 80 01       BRA $01    [$9ED1]
                                            ; Else ((red component) > (target red component)):
$A8:9ED0 3A          DEC A                  ; A -= 1

$A8:9ED1 85 12       STA $12    [$7E:0012]  ;\
$A8:9ED3 BF 00 C0 7E LDA $7EC000,x[$7E:C120];|
$A8:9ED7 29 E0 FF    AND #$FFE0             ;} (Palette colour) = (palette colour) & ~1Fh | [A] (set the red component)
$A8:9EDA 05 12       ORA $12    [$7E:0012]  ;|
$A8:9EDC 9F 00 C0 7E STA $7EC000,x[$7E:C120];/
$A8:9EE0 C8          INY                    ; Increment Y

; BRANCH_RED_END
$A8:9EE1 BF 00 C2 7E LDA $7EC200,x[$7E:C320];\
$A8:9EE5 29 E0 03    AND #$03E0             ;} $12 = (target palette colour) & 1Fh << 5 (target green component)
$A8:9EE8 85 12       STA $12    [$7E:0012]  ;/
$A8:9EEA BF 00 C0 7E LDA $7EC000,x[$7E:C120];\
$A8:9EEE 29 E0 03    AND #$03E0             ;} A = (palette colour) & 1Fh << 5 (green component)
$A8:9EF1 C5 12       CMP $12    [$7E:0012]  ;\
$A8:9EF3 F0 1C       BEQ $1C    [$9F11]     ;} If (green component) = (target green component): go to BRANCH_GREEN_END
$A8:9EF5 10 06       BPL $06    [$9EFD]     ; If (green component) < (target green component):
$A8:9EF7 18          CLC                    ;\
$A8:9EF8 69 20 00    ADC #$0020             ;} A += 1 << 5
$A8:9EFB 80 04       BRA $04    [$9F01]

$A8:9EFD 38          SEC                    ;\ Else ((green component) > (target green component)):
$A8:9EFE E9 20 00    SBC #$0020             ;} A += 1 << 5

$A8:9F01 85 12       STA $12    [$7E:0012]  ;\
$A8:9F03 BF 00 C0 7E LDA $7EC000,x[$7E:C120];|
$A8:9F07 29 1F FC    AND #$FC1F             ;} (Palette colour) = (palette colour) & ~(1Fh << 5) | [A] (set the green component)
$A8:9F0A 05 12       ORA $12    [$7E:0012]  ;|
$A8:9F0C 9F 00 C0 7E STA $7EC000,x[$7E:C120];/
$A8:9F10 C8          INY                    ; Increment Y

; BRANCH_GREEN_END
$A8:9F11 BF 00 C2 7E LDA $7EC200,x[$7E:C320];\
$A8:9F15 29 00 7C    AND #$7C00             ;} $12 = (target palette colour) & 1Fh << Ah (target blue component)
$A8:9F18 85 12       STA $12    [$7E:0012]  ;/
$A8:9F1A BF 00 C0 7E LDA $7EC000,x[$7E:C120];\
$A8:9F1E 29 00 7C    AND #$7C00             ;} A = (palette colour) & 1Fh << Ah (blue component)
$A8:9F21 C5 12       CMP $12    [$7E:0012]  ;\
$A8:9F23 F0 1C       BEQ $1C    [$9F41]     ;} If (blue component) = (target blue component): go to BRANCH_NEXT
$A8:9F25 10 06       BPL $06    [$9F2D]     ; If (blue component) < (target blue component):
$A8:9F27 18          CLC                    ;\
$A8:9F28 69 00 04    ADC #$0400             ;} A += 1 << Ah
$A8:9F2B 80 04       BRA $04    [$9F31]

$A8:9F2D 38          SEC                    ;\ Else ((blue component) > (target blue component)):
$A8:9F2E E9 00 04    SBC #$0400             ;} A += 1 << Ah

$A8:9F31 85 12       STA $12    [$7E:0012]  ;\
$A8:9F33 BF 00 C0 7E LDA $7EC000,x[$7E:C120];|
$A8:9F37 29 FF 83    AND #$83FF             ;} (Palette colour) = (palette colour) & ~(1Fh << Ah) | [A] (set the blue component)
$A8:9F3A 05 12       ORA $12    [$7E:0012]  ;|
$A8:9F3C 9F 00 C0 7E STA $7EC000,x[$7E:C120];/
$A8:9F40 C8          INY                    ; Increment Y

; BRANCH_NEXT
$A8:9F41 E8          INX                    ;\
$A8:9F42 E8          INX                    ;} X += 2
$A8:9F43 E4 14       CPX $14    [$7E:0014]  ;\
$A8:9F45 10 03       BPL $03    [$9F4A]     ;} If [X] < [$14]:
$A8:9F47 4C AE 9E    JMP $9EAE  [$A8:9EAE]  ; Go to LOOP

; BRANCH_RETURN
$A8:9F4A 98          TYA                    ; A = [Y]
$A8:9F4B 7A          PLY
$A8:9F4C FA          PLX
$A8:9F4D 28          PLP
$A8:9F4E 60          RTS
}
}


;;; $9F4F..AAFD: Yapping maw ;;;
{
;;; $9F4F: Palette - enemy $E7BF (yapping maw) ;;;
{
$A8:9F4F             dw 3800, 57FF, 42F7, 0929, 00A5, 4F5A, 36B5, 2610, 1DCE, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $9F6F..A096: Instruction lists - yapping maw ;;;
{
;;; $9F6F: Instruction list - attacking - facing up / initial - facing up ;;;
{
$A8:9F6F             dx 0005,A8EE,
                        0003,A909,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,A91A,
                        0003,A909,
                        80ED,9F6F   ; Go to $9F6F
}


;;; $9F85: Instruction list - attacking - facing up-right ;;;
{
$A8:9F85             dx 0005,A935,
                        0003,A946,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,A961,
                        0003,A946,
                        80ED,9F85   ; Go to $9F85
}


;;; $9F9B: Instruction list - attacking - facing right ;;;
{
$A8:9F9B             dx 0005,A972,
                        0003,A98D,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,A99E,
                        0003,A98D,
                        80ED,9F9B   ; Go to $9F9B
}


;;; $9FB1: Instruction list - attacking - facing down-right ;;;
{
$A8:9FB1             dx 0005,A9B9,
                        0003,A9CA,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,A9E5,
                        0003,A9CA,
                        80ED,9FB1   ; Go to $9FB1
}


;;; $9FC7: Instruction list - attacking - facing down / initial - facing down ;;;
{
$A8:9FC7             dx 0005,A9F6,
                        0003,AA11,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,AA22,
                        0003,AA11,
                        80ED,9FC7   ; Go to $9FC7
}


;;; $9FDD: Instruction list - attacking - facing down-left ;;;
{
$A8:9FDD             dx 0005,AA3D,
                        0003,AA4E,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,AA69,
                        0003,AA4E,
                        80ED,9FDD   ; Go to $9FDD
}


;;; $9FF3: Instruction list - attacking - facing left ;;;
{
$A8:9FF3             dx 0005,AA7A,
                        0003,AA95,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,AAA6,
                        0003,AA95,
                        80ED,9FF3   ; Go to $9FF3
}


;;; $A009: Instruction list - attacking - facing up-left ;;;
{
$A8:A009             dx 0005,AAC1,
                        0003,AAD2,
                        A133,       ; Queue yapping maw sound effect if on screen
                        0050,AAED,
                        0003,AAD2,
                        80ED,A009   ; Go to $A009
}


;;; $A01F: Instruction list - cooldown - facing up-right ;;;
{
$A8:A01F             dw A0C7,       ; Offset Samus up-right
                        0004,A961
}


;;; $A025: Instruction list - cooldown - facing up ;;;
{
$A8:A025             dw A10F        ; Offset Samus up
$A8:A027             dw 0050,A91A,
                        0003,A909,
                        0005,A8EE,
                        0003,A909,
                        A133,       ; Queue yapping maw sound effect if on screen
                        80ED,A027   ; Go to $A027
}


;;; $A03D: Instruction list - cooldown - facing up-left ;;;
{
$A8:A03D             dx A0D9,       ; Offset Samus up-left
                        0004,AAED,
                        A10F        ; Offset Samus up
$A2:A045             dx 0050,A91A,
                        0003,A909,
                        0005,A8EE,
                        0003,A909,
                        A133,       ; Queue yapping maw sound effect if on screen
                        80ED,A045   ; Go to $A045
}


;;; $A05B: Instruction list - cooldown - facing down-right ;;;
{
$A8:A05B             dw A0EB,       ; Offset Samus down-right
                        0004,A9E5
}


;;; $A061: Instruction list - cooldown - facing down ;;;
{
$A2:A061             dw A121        ; Offset Samus down
$A2:A063             dw 0050,AA22,
                        0003,AA11,
                        0005,A9F6,
                        0003,AA11,
                        A133,       ; Queue yapping maw sound effect if on screen
                        80ED,A063   ; Go to $A063
}


;;; $A079: Instruction list - cooldown - facing down-left ;;;
{
$A8:A079             dx A0FD,       ; Offset Samus down-left
                        0004,AA69,
                        A121        ; Offset Samus down
$A2:A081             dx 0050,AA22,
                        0003,AA11,
                        0005,A9F6,
                        0003,AA11,
                        A133,       ; Queue yapping maw sound effect if on screen
                        80ED,A081   ; Go to $A081
}
}


;;; $A097: Yapping maw attack instruction list pointers ;;;
{
; Indexed by [enemy $7E:8028]
$A8:A097             dw 9F6F, 9F85, 9F9B, 9FB1, 9FC7, 9FDD, 9FF3, A009
}


;;; $A0A7: Yapping maw Samus offsets ;;;
{
; Offset from enemy position to place Samus when grabbed

;                        _________ X offset
;                       |      ___ Y offset
;                       |     |
$A8:A0A7             dw 0000, FFF0 ; Up
$A8:A0AB             dw 0008, FFF8 ; Up-right
$A8:A0AF             dw 0010, 0000 ; Unused. Right
$A8:A0B3             dw 0008, 0008 ; Down-right
$A8:A0B7             dw 0000, 0010 ; Down
$A8:A0BB             dw FFF8, 0008 ; Down-left
$A8:A0BF             dw FFF0, 0000 ; Unused. Left
$A8:A0C3             dw FFF8, FFF8 ; Up-left
}


;;; $A0C7..A147: Instructions ;;;
{
;;; $A0C7: Instruction - offset Samus up-right ;;;
{
$A8:A0C7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A0CA AD AB A0    LDA $A0AB  [$A8:A0AB]  ;\
$A8:A0CD 9F 24 80 7E STA $7E8024,x[$7E:8064];} Enemy Samus X offset = 8
$A8:A0D1 AD AD A0    LDA $A0AD  [$A8:A0AD]  ;\
$A8:A0D4 9F 26 80 7E STA $7E8026,x[$7E:8066];} Enemy Samus Y offset = -8
$A8:A0D8 6B          RTL
}


;;; $A0D9: Instruction - offset Samus up-left ;;;
{
$A8:A0D9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A0DC AD C3 A0    LDA $A0C3  [$A8:A0C3]  ;\
$A8:A0DF 9F 24 80 7E STA $7E8024,x          ;} Enemy Samus X offset = -8
$A8:A0E3 AD C5 A0    LDA $A0C5  [$A8:A0C5]  ;\
$A8:A0E6 9F 26 80 7E STA $7E8026,x          ;} Enemy Samus Y offset = -8
$A8:A0EA 6B          RTL
}


;;; $A0EB: Instruction - offset Samus down-right ;;;
{
$A8:A0EB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A0EE AD B3 A0    LDA $A0B3  [$A8:A0B3]  ;\
$A8:A0F1 9F 24 80 7E STA $7E8024,x[$7E:8024];} Enemy Samus X offset = 8
$A8:A0F5 AD B5 A0    LDA $A0B5  [$A8:A0B5]  ;\
$A8:A0F8 9F 26 80 7E STA $7E8026,x[$7E:8026];} Enemy Samus Y offset = 8
$A8:A0FC 6B          RTL
}


;;; $A0FD: Instruction - offset Samus down-left ;;;
{
$A8:A0FD AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A100 AD BB A0    LDA $A0BB  [$A8:A0BB]  ;\
$A8:A103 9F 24 80 7E STA $7E8024,x          ;} Enemy Samus X offset = -8
$A8:A107 AD BD A0    LDA $A0BD  [$A8:A0BD]  ;\
$A8:A10A 9F 26 80 7E STA $7E8026,x          ;} Enemy Samus Y offset = 8
$A8:A10E 6B          RTL
}


;;; $A10F: Instruction - offset Samus up ;;;
{
$A8:A10F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A112 AD A7 A0    LDA $A0A7  [$A8:A0A7]  ;\
$A8:A115 9F 24 80 7E STA $7E8024,x[$7E:8064];} Enemy Samus X offset = 0
$A8:A119 AD A9 A0    LDA $A0A9  [$A8:A0A9]  ;\
$A8:A11C 9F 26 80 7E STA $7E8026,x[$7E:8066];} Enemy Samus Y offset = -10h
$A8:A120 6B          RTL
}


;;; $A121: Instruction - offset Samus down ;;;
{
$A8:A121 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A124 AD B7 A0    LDA $A0B7  [$A8:A0B7]  ;\
$A8:A127 9F 24 80 7E STA $7E8024,x[$7E:8024];} Enemy Samus X offset = 0
$A8:A12B AD B9 A0    LDA $A0B9  [$A8:A0B9]  ;\
$A8:A12E 9F 26 80 7E STA $7E8026,x[$7E:8026];} Enemy Samus Y offset = 10h
$A8:A132 6B          RTL
}


;;; $A133: Instruction - queue yapping maw sound effect if on screen ;;;
{
$A8:A133 5A          PHY
$A8:A134 DA          PHX
$A8:A135 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A138 BF 2C 80 7E LDA $7E802C,x[$7E:806C];\
$A8:A13C D0 07       BNE $07    [$A145]     ;} If enemy is on screen:
$A8:A13E A9 2F 00    LDA #$002F             ;\
$A8:A141 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Fh, sound library 2, max queued sounds allowed = 6 (yapping maw)

$A8:A145 FA          PLX
$A8:A146 7A          PLY
$A8:A147 6B          RTL
}
}


;;; $A148: Initialisation AI - enemy $E7BF (yapping maw) ;;;
{
$A8:A148 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A14B BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:A14E 9F 18 78 7E STA $7E7818,x[$7E:7818];} Enemy body segment base X position = [enemy X position]
$A8:A152 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:A155 9F 1A 78 7E STA $7E781A,x[$7E:781A];} Enemy body segment base Y position = [enemy Y position]
$A8:A159 A9 00 00    LDA #$0000
$A8:A15C 9F 00 78 7E STA $7E7800,x[$7E:7800]; Enemy body segment 1 X offset = 0
$A8:A160 9F 02 78 7E STA $7E7802,x[$7E:7802]; Enemy body segment 1 Y offset = 0
$A8:A164 9F 04 78 7E STA $7E7804,x[$7E:7804]; Enemy body segment 2 X offset = 0
$A8:A168 9F 06 78 7E STA $7E7806,x[$7E:7806]; Enemy body segment 2 Y offset = 0
$A8:A16C 9F 08 78 7E STA $7E7808,x[$7E:7808]; Enemy body segment 3 X offset = 0
$A8:A170 9F 0A 78 7E STA $7E780A,x[$7E:780A]; Enemy body segment 3 Y offset = 0
$A8:A174 9F 0C 78 7E STA $7E780C,x[$7E:780C]; Enemy head segment X offset = 0
$A8:A178 9F 0E 78 7E STA $7E780E,x[$7E:780E]; Enemy head segment Y offset = 0
$A8:A17C 9F 20 80 7E STA $7E8020,x[$7E:8020]; Enemy grabbing Samus flag = 0
$A8:A180 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:A183 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy proximity = [enemy parameter 1]
$A8:A186 A9 40 00    LDA #$0040             ;\
$A8:A189 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy cooldown timer = 40h
$A8:A18C A9 6F 9F    LDA #$9F6F             ;\
$A8:A18F 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $9F6F
$A8:A192 A9 39 00    LDA #$0039             ;\
$A8:A195 85 24       STA $24    [$7E:0024]  ;} $24 = 39h (yapping maw base - facing up)
$A8:A197 A9 08 00    LDA #$0008             ;\
$A8:A19A 85 22       STA $22    [$7E:0022]  ;} $22 = 8 (base Y offset)
$A8:A19C BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A8:A19F D0 10       BNE $10    [$A1B1]     ;} If [enemy parameter 1] = 0 (facing down):
$A8:A1A1 A9 C7 9F    LDA #$9FC7             ;\
$A8:A1A4 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $9FC7
$A8:A1A7 A9 38 00    LDA #$0038             ;\
$A8:A1AA 85 24       STA $24    [$7E:0024]  ;} $24 = 38h (yapping maw base - facing down)
$A8:A1AC A9 F8 FF    LDA #$FFF8             ;\
$A8:A1AF 85 22       STA $22    [$7E:0022]  ;} $22 = -8 (base Y offset)

$A8:A1B1 A9 01 00    LDA #$0001             ;\
$A8:A1B4 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:A1B7 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:A1BA A9 35 A2    LDA #$A235             ;\
$A8:A1BD 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $A235 (neutral)
$A8:A1C0 BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:A1C3 29 00 0E    AND #$0E00             ;} Enemy initial palette index = [enemy palette index]
$A8:A1C6 9F 0A 88 7E STA $7E880A,x[$7E:880A];/
$A8:A1CA A9 03 00    LDA #$0003             ;\
$A8:A1CD 9F 08 88 7E STA $7E8808,x[$7E:8808];} Enemy body segment index = 3

; LOOP
$A8:A1D1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A1D4 A0 95 EC    LDY #$EC95             ;\
$A8:A1D7 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn yapping maw's body enemy projectile
$A8:A1DB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A1DE BF 08 88 7E LDA $7E8808,x[$7E:8808];\
$A8:A1E2 3A          DEC A                  ;} Decrement enemy body segment index
$A8:A1E3 9F 08 88 7E STA $7E8808,x[$7E:8808];/
$A8:A1E7 10 E8       BPL $E8    [$A1D1]     ; If [enemy body segment index] >= 0: go to LOOP
$A8:A1E9 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:A1EC 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A8:A1EE BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:A1F1 18          CLC                    ;|
$A8:A1F2 65 22       ADC $22    [$7E:0022]  ;} $14 = [enemy Y position] + [$22]
$A8:A1F4 85 14       STA $14    [$7E:0014]  ;/
$A8:A1F6 A5 24       LDA $24    [$7E:0024]  ;\
$A8:A1F8 85 16       STA $16    [$7E:0016]  ;} $16 = [$24] (sprite object ID)
$A8:A1FA BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:A1FD 1D 98 0F    ORA $0F98,x[$7E:0F98]  ;|
$A8:A200 9F 0E 88 7E STA $7E880E,x[$7E:880E];} $18 = enemy base sprite object palette and VRAM index = [enemy palette index] | [enemy VRAM tiles index]
$A8:A204 85 18       STA $18    [$7E:0018]  ;/
$A8:A206 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ; Create sprite object
$A8:A20A A5 12       LDA $12    [$7E:0012]  ;\
$A8:A20C 9F 0C 88 7E STA $7E880C,x[$7E:880C];} Enemy base sprite object index = [$12]
$A8:A210 6B          RTL
}


;;; $A211: Main AI - enemy $E7BF (yapping maw) ;;;
{
$A8:A211 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A214 BF 2A 80 7E LDA $7E802A,x[$7E:806A];\
$A8:A218 3A          DEC A                  ;} Decrement enemy intangibility timer
$A8:A219 9F 2A 80 7E STA $7E802A,x[$7E:806A];/
$A8:A21D 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ; Check if enemy centre is on screen or not
$A8:A221 9F 2C 80 7E STA $7E802C,x[$7E:806C]; Enemy off-screen flag = [A]
$A8:A225 FC A8 0F    JSR ($0FA8,x)[$A8:A235]; Execute [enemy function]
$A8:A228 20 1D A7    JSR $A71D  [$A8:A71D]  ; Set body segment 3 position
$A8:A22B 20 FC A6    JSR $A6FC  [$A8:A6FC]  ; Set body segment 2 position
$A8:A22E 20 DB A6    JSR $A6DB  [$A8:A6DB]  ; Set body segment 1 position
$A8:A231 20 C4 A6    JSR $A6C4  [$A8:A6C4]  ; Set body segment 0 position
$A8:A234 6B          RTL
}


;;; $A235: Yapping maw function - neutral ;;;
{
$A8:A235 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A238 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A8:A23B 8D 32 0E    STA $0E32  [$7E:0E32]  ;} $0E32 = [enemy X position]
$A8:A23E BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:A241 8D 34 0E    STA $0E34  [$7E:0E34]  ;} $0E34 = [enemy Y position]
$A8:A244 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:A247 8D 36 0E    STA $0E36  [$7E:0E36]  ;} $0E36 = [Samus X position]
$A8:A24A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:A24D 8D 38 0E    STA $0E38  [$7E:0E38]  ;} $0E38 = [Samus Y position]
$A8:A250 22 A8 AC A0 JSL $A0ACA8[$A0:ACA8]  ; Calculate distance and angle of Samus from enemy
$A8:A254 22 67 B0 A0 JSL $A0B067[$A0:B067]  ; >_<;
$A8:A258 9F 10 78 7E STA $7E7810,x[$7E:7850]; Enemy target length = (distance of Samus from enemy)
$A8:A25C C9 20 00    CMP #$0020             ;\
$A8:A25F 30 23       BMI $23    [$A284]     ;} If [A] < 20h: go to BRANCH_POINT_BLANK
$A8:A261 DD B2 0F    CMP $0FB2,x[$7E:0FF2]  ;\
$A8:A264 10 1D       BPL $1D    [$A283]     ;} If [A] >= [enemy proximity]: return
$A8:A266 BF 10 78 7E LDA $7E7810,x[$7E:7850]; >_<;
$A8:A26A C9 40 00    CMP #$0040             ;\
$A8:A26D 30 07       BMI $07    [$A276]     ;|
$A8:A26F A9 40 00    LDA #$0040             ;} Enemy target length = min(40h, [A])
$A8:A272 9F 10 78 7E STA $7E7810,x[$7E:7890];/

$A8:A276 AD 3A 0E    LDA $0E3A  [$7E:0E3A]  ;\
$A8:A279 9F 14 78 7E STA $7E7814,x[$7E:7854];} Enemy target angle = [$0E3A] (angle of Samus from enemy)
$A8:A27D A9 8C A2    LDA #$A28C             ;\
$A8:A280 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $A28C (attack)

$A8:A283 60          RTS                    ; Return

; BRANCH_POINT_BLANK
$A8:A284 A9 30 00    LDA #$0030             ;\
$A8:A287 9F 2A 80 7E STA $7E802A,x[$7E:806A];} Enemy intangibility timer = 30h
$A8:A28B 60          RTS
}


;;; $A28C: Yapping maw function - attack ;;;
{
$A8:A28C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A28F 9E AA 0F    STZ $0FAA,x[$7E:0FEA]  ;\
$A8:A292 9E AC 0F    STZ $0FAC,x[$7E:0FEC]  ;} Enemy angle = 0.0
$A8:A295 9E AE 0F    STZ $0FAE,x[$7E:0FEE]  ; Enemy angular speed table index = 0
$A8:A298 BF 10 78 7E LDA $7E7810,x[$7E:7850];\
$A8:A29C 4A          LSR A                  ;} Enemy length = [enemy target length] / 2
$A8:A29D 9F 12 78 7E STA $7E7812,x[$7E:7852];/
$A8:A2A1 BF 14 78 7E LDA $7E7814,x[$7E:7854];\
$A8:A2A5 38          SEC                    ;|
$A8:A2A6 E9 40 00    SBC #$0040             ;|
$A8:A2A9 29 FF 00    AND #$00FF             ;|
$A8:A2AC 49 FF FF    EOR #$FFFF             ;|
$A8:A2AF 1A          INC A                  ;} Enemy target angle = (40h - [enemy target angle]) % 100h (angle using common maths convention)
$A8:A2B0 18          CLC                    ;|
$A8:A2B1 69 00 01    ADC #$0100             ;|
$A8:A2B4 29 FF 00    AND #$00FF             ;|
$A8:A2B7 9F 16 78 7E STA $7E7816,x[$7E:7856];/
$A8:A2BB C9 80 00    CMP #$0080             ;\
$A8:A2BE 10 09       BPL $09    [$A2C9]     ;} If [enemy target angle] < 80h:
$A8:A2C0 A9 00 00    LDA #$0000             ;\
$A8:A2C3 9F 1E 80 7E STA $7E801E,x[$7E:805E];} Enemy aiming down flag = 0
$A8:A2C7 80 07       BRA $07    [$A2D0]

$A8:A2C9 A9 01 00    LDA #$0001             ;\ Else ([enemy target angle] >= 80h):
$A8:A2CC 9F 1E 80 7E STA $7E801E,x[$7E:821E];} Enemy aiming down flag = 1

$A8:A2D0 20 10 A3    JSR $A310  [$A8:A310]  ; Calculate yapping maw origin position
$A8:A2D3 BF 14 78 7E LDA $7E7814,x[$7E:7854];\
$A8:A2D7 18          CLC                    ;|
$A8:A2D8 69 10 00    ADC #$0010             ;|
$A8:A2DB 29 FF 00    AND #$00FF             ;|
$A8:A2DE 4A          LSR A                  ;|
$A8:A2DF 4A          LSR A                  ;|
$A8:A2E0 4A          LSR A                  ;} Y = enemy instruction list table index = ([enemy target angle] + 10h) % 100h / 20h * 2
$A8:A2E1 4A          LSR A                  ;|
$A8:A2E2 4A          LSR A                  ;|
$A8:A2E3 0A          ASL A                  ;|
$A8:A2E4 9F 28 80 7E STA $7E8028,x[$7E:8068];|
$A8:A2E8 A8          TAY                    ;/
$A8:A2E9 B9 97 A0    LDA $A097,y[$A8:A099]  ;} Enemy instruction list pointer = [$A097 + [Y]]
$A8:A2EC 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;/
$A8:A2EF A9 01 00    LDA #$0001             ;\
$A8:A2F2 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:A2F5 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0
$A8:A2F8 98          TYA                    ;\
$A8:A2F9 0A          ASL A                  ;} Y *= 2
$A8:A2FA A8          TAY                    ;/
$A8:A2FB B9 A7 A0    LDA $A0A7,y[$A8:A0AB]  ;\
$A8:A2FE 9F 24 80 7E STA $7E8024,x[$7E:8064];} Enemy Samus X offset = [$A0A7 + [Y]]
$A8:A302 B9 A9 A0    LDA $A0A9,y[$A8:A0AD]  ;\
$A8:A305 9F 26 80 7E STA $7E8026,x[$7E:8066];} Enemy Samus Y offset = [$A0A7 + [Y] + 2]
$A8:A309 A9 45 A4    LDA #$A445             ;\
$A8:A30C 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $A445 (attacking)
$A8:A30F 60          RTS
}


;;; $A310: Calculate yapping maw origin position ;;;
{
$A8:A310 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A313 BF 12 78 7E LDA $7E7812,x[$7E:7852];\
$A8:A317 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A31A A9 80 00    LDA #$0080             ;} Enemy origin X position = [enemy length] * -7FFFh / 8000h
$A8:A31D 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A321 9F 1C 78 7E STA $7E781C,x[$7E:785C];/
$A8:A325 BF 12 78 7E LDA $7E7812,x[$7E:7852];\
$A8:A329 4A          LSR A                  ;|
$A8:A32A 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A32D A9 80 00    LDA #$0080             ;} Enemy origin Y position = 0
$A8:A330 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A334 9F 1E 78 7E STA $7E781E,x[$7E:785E];/
$A8:A338 60          RTS
}


;;; $A339: Calculate body segment 1 velocities ;;;
{
$A8:A339 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A33C BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$A8:A340 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A343 A9 00 00    LDA #$0000             ;} Enemy $7E:7820 = [enemy body segment 1 X offset] * 7FFFh / 8000h
$A8:A346 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A34A 9F 20 78 7E STA $7E7820,x[$7E:7860];/
$A8:A34E A9 00 00    LDA #$0000             ;\
$A8:A351 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;} Enemy $7E:7822 = 0
$A8:A355 9F 22 78 7E STA $7E7822,x[$7E:7862];/
$A8:A359 BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A35D 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A361 38          SEC                    ;} Enemy body segment 1 X velocity = [enemy body segment 1 X offset] * cos([enemy target angle] * pi / 80h) * 7FFFh / 8000h - [enemy $7E:7820]
$A8:A362 FF 20 78 7E SBC $7E7820,x[$7E:7860];|
$A8:A366 9F 0E 80 7E STA $7E800E,x[$7E:804E];/
$A8:A36A BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A36E 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A372 38          SEC                    ;} Enemy body segment 1 Y velocity = [enemy body segment 1 X offset] * -sin([enemy target angle] * pi / 80h) * 7FFFh / 8000h
$A8:A373 FF 22 78 7E SBC $7E7822,x[$7E:7862];|
$A8:A377 9F 10 80 7E STA $7E8010,x[$7E:8050];/
$A8:A37B 60          RTS
}


;;; $A37C: Calculate body segment 2 velocities ;;;
{
$A8:A37C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A37F BF 04 78 7E LDA $7E7804,x[$7E:7844];\
$A8:A383 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A386 A9 00 00    LDA #$0000             ;} Enemy $7E:7820 = [enemy body segment 2 X offset] * 7FFFh / 8000h
$A8:A389 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A38D 9F 20 78 7E STA $7E7820,x[$7E:7860];/
$A8:A391 A9 00 00    LDA #$0000             ;\
$A8:A394 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;} Enemy $7E:7822 = 0
$A8:A398 9F 22 78 7E STA $7E7822,x[$7E:7862];/
$A8:A39C BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A3A0 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A3A4 38          SEC                    ;} Enemy body segment 2 X velocity = [enemy body segment 2 X offset] * cos([enemy target angle] * pi / 80h) * 7FFFh / 8000h - [enemy $7E:7820]
$A8:A3A5 FF 20 78 7E SBC $7E7820,x[$7E:7860];|
$A8:A3A9 9F 12 80 7E STA $7E8012,x[$7E:8052];/
$A8:A3AD BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A3B1 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A3B5 38          SEC                    ;} Enemy body segment 2 Y velocity = [enemy body segment 2 X offset] * -sin([enemy target angle] * pi / 80h) * 7FFFh / 8000h
$A8:A3B6 FF 22 78 7E SBC $7E7822,x[$7E:7862];|
$A8:A3BA 9F 14 80 7E STA $7E8014,x[$7E:8054];/
$A8:A3BE 60          RTS
}


;;; $A3BF: Calculate body segment 3 velocities ;;;
{
$A8:A3BF AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A3C2 BF 08 78 7E LDA $7E7808,x[$7E:7848];\
$A8:A3C6 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A3C9 A9 00 00    LDA #$0000             ;} Enemy $7E:7820 = [enemy body segment 3 X offset] * 7FFFh / 8000h
$A8:A3CC 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A3D0 9F 20 78 7E STA $7E7820,x[$7E:7860];/
$A8:A3D4 A9 00 00    LDA #$0000             ;\
$A8:A3D7 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;} Enemy $7E:7822 = 0
$A8:A3DB 9F 22 78 7E STA $7E7822,x[$7E:7862];/
$A8:A3DF BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A3E3 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A3E7 38          SEC                    ;} Enemy body segment 3 X velocity = [enemy body segment 3 X offset] * cos([enemy target angle] * pi / 80h) * 7FFFh / 8000h - [enemy $7E:7820]
$A8:A3E8 FF 20 78 7E SBC $7E7820,x[$7E:7860];|
$A8:A3EC 9F 16 80 7E STA $7E8016,x[$7E:8056];/
$A8:A3F0 BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A3F4 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A3F8 38          SEC                    ;} Enemy body segment 3 Y velocity = [enemy body segment 3 X offset] * -sin([enemy target angle] * pi / 80h) * 7FFFh / 8000h
$A8:A3F9 FF 22 78 7E SBC $7E7822,x[$7E:7862];|
$A8:A3FD 9F 18 80 7E STA $7E8018,x[$7E:8058];/
$A8:A401 60          RTS
}


;;; $A402: Calculate head segment velocities ;;;
{
$A8:A402 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A405 BF 0C 78 7E LDA $7E780C,x[$7E:784C];\
$A8:A409 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A40C A9 00 00    LDA #$0000             ;} Enemy $7E:7820 = [enemy head segment X offset] * 7FFFh / 8000h
$A8:A40F 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A413 9F 20 78 7E STA $7E7820,x[$7E:7860];/
$A8:A417 A9 00 00    LDA #$0000             ;\
$A8:A41A 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;} Enemy $7E:7822 = 0
$A8:A41E 9F 22 78 7E STA $7E7822,x[$7E:7862];/
$A8:A422 BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A426 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A42A 38          SEC                    ;} Enemy head segment X velocity = [enemy head segment X offset] * cos([enemy target angle] * pi / 80h) * 7FFFh / 8000h - [enemy $7E:7820]
$A8:A42B FF 20 78 7E SBC $7E7820,x[$7E:7860];|
$A8:A42F 9F 1A 80 7E STA $7E801A,x[$7E:805A];/
$A8:A433 BF 16 78 7E LDA $7E7816,x[$7E:7856];\
$A8:A437 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A43B 38          SEC                    ;} Enemy head segment Y velocity = [enemy head segment X offset] * -sin([enemy target angle] * pi / 80h) * 7FFFh / 8000h
$A8:A43C FF 22 78 7E SBC $7E7822,x[$7E:7862];|
$A8:A440 9F 1C 80 7E STA $7E801C,x[$7E:805C];/
$A8:A444 60          RTS
}


;;; $A445: Yapping maw function - attacking ;;;
{
; Eventually we end up approximating these rather complicated calculations for each segment:
;     Enemy segment X offset = ([enemy length] * cos([enemy segment angle] * pi / 80h) - [enemy origin X position]) * cos([enemy target angle] * pi / 80h)
;     Enemy segment Y offset = ([enemy length] * cos([enemy segment angle] * pi / 80h) - [enemy origin X position]) * -sin([enemy target angle] * pi / 80h) + [enemy length] / 2 * -sin([enemy segment angle] * pi / 80h) - [enemy origin Y position]

; TODO: deserving of a diagram? need to verify with lua script also
$A8:A445 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A448 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:A44B 4A          LSR A                  ;|
$A8:A44C 4A          LSR A                  ;} $14 = [enemy angle] / 4
$A8:A44D 85 14       STA $14    [$7E:0014]  ;/
$A8:A44F BF 1E 80 7E LDA $7E801E,x[$7E:805E];\
$A8:A453 D0 1E       BNE $1E    [$A473]     ;} If [enemy aiming down flag] = 0:
$A8:A455 38          SEC                    ;\
$A8:A456 A9 80 00    LDA #$0080             ;|
$A8:A459 E5 14       SBC $14    [$7E:0014]  ;} Enemy body segment 1 angle = 80h - [$14]
$A8:A45B 9F 02 80 7E STA $7E8002,x[$7E:8042];/
$A8:A45F E5 14       SBC $14    [$7E:0014]  ;\
$A8:A461 9F 04 80 7E STA $7E8004,x[$7E:8044];} Enemy body segment 2 angle = 80h - [$14] * 2
$A8:A465 E5 14       SBC $14    [$7E:0014]  ;\
$A8:A467 9F 06 80 7E STA $7E8006,x[$7E:8046];} Enemy body segment 3 angle = 80h - [$14] * 3
$A8:A46B E5 14       SBC $14    [$7E:0014]  ;\
$A8:A46D 9F 08 80 7E STA $7E8008,x[$7E:8048];} Enemy head segment angle = 80h - [$14] * 4
$A8:A471 80 1C       BRA $1C    [$A48F]

$A8:A473 18          CLC                    ;\ Else ([enemy aiming down flag] != 0):
$A8:A474 A9 80 00    LDA #$0080             ;|
$A8:A477 65 14       ADC $14    [$7E:0014]  ;} Enemy body segment 1 angle = 80h + [$14]
$A8:A479 9F 02 80 7E STA $7E8002,x[$7E:8202];/
$A8:A47D 65 14       ADC $14    [$7E:0014]  ;\
$A8:A47F 9F 04 80 7E STA $7E8004,x[$7E:8204];} Enemy body segment 2 angle = 80h + [$14] * 2
$A8:A483 65 14       ADC $14    [$7E:0014]  ;\
$A8:A485 9F 06 80 7E STA $7E8006,x[$7E:8206];} Enemy body segment 3 angle = 80h + [$14] * 3
$A8:A489 65 14       ADC $14    [$7E:0014]  ;\
$A8:A48B 9F 08 80 7E STA $7E8008,x[$7E:8208];} Enemy head segment angle = 80h + [$14] * 4

$A8:A48F BF 12 78 7E LDA $7E7812,x[$7E:7852];\
$A8:A493 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A496 BF 02 80 7E LDA $7E8002,x[$7E:8042];|
$A8:A49A 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;} Enemy body segment 1 X offset = [enemy length] * cos([enemy body segment 1 angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin X position]
$A8:A49E 38          SEC                    ;|
$A8:A49F FF 1C 78 7E SBC $7E781C,x[$7E:785C];|
$A8:A4A3 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$A8:A4A7 BF 04 80 7E LDA $7E8004,x[$7E:8044];\
$A8:A4AB 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A4AF 38          SEC                    ;} Enemy body segment 2 X offset = [enemy length] * cos([enemy body segment 2 angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin X position]
$A8:A4B0 FF 1C 78 7E SBC $7E781C,x[$7E:785C];|
$A8:A4B4 9F 04 78 7E STA $7E7804,x[$7E:7844];/
$A8:A4B8 BF 06 80 7E LDA $7E8006,x[$7E:8046];\
$A8:A4BC 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A4C0 38          SEC                    ;} Enemy body segment 3 X offset = [enemy length] * cos([enemy body segment 3 angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin X position]
$A8:A4C1 FF 1C 78 7E SBC $7E781C,x[$7E:785C];|
$A8:A4C5 9F 08 78 7E STA $7E7808,x[$7E:7848];/
$A8:A4C9 BF 08 80 7E LDA $7E8008,x[$7E:8048];\
$A8:A4CD 22 3E A7 A8 JSL $A8A73E[$A8:A73E]  ;|
$A8:A4D1 38          SEC                    ;} Enemy head segment X offset = [enemy length] * cos([enemy head segment angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin X position]
$A8:A4D2 FF 1C 78 7E SBC $7E781C,x[$7E:785C];|
$A8:A4D6 9F 0C 78 7E STA $7E780C,x[$7E:784C];/
$A8:A4DA BF 12 78 7E LDA $7E7812,x[$7E:7852];\
$A8:A4DE 4A          LSR A                  ;|
$A8:A4DF 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:A4E2 BF 02 80 7E LDA $7E8002,x[$7E:8042];|
$A8:A4E6 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;} Enemy body segment 1 Y offset = [enemy length] / 2 * -sin([enemy body segment 1 angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin Y position]
$A8:A4EA 38          SEC                    ;|
$A8:A4EB FF 1E 78 7E SBC $7E781E,x[$7E:785E];|
$A8:A4EF 9F 02 78 7E STA $7E7802,x[$7E:7842];/
$A8:A4F3 BF 04 80 7E LDA $7E8004,x[$7E:8044];\
$A8:A4F7 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A4FB 38          SEC                    ;} Enemy body segment 2 Y offset = [enemy length] / 2 * -sin([enemy body segment 2 angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin Y position]
$A8:A4FC FF 1E 78 7E SBC $7E781E,x[$7E:785E];|
$A8:A500 9F 06 78 7E STA $7E7806,x[$7E:7846];/
$A8:A504 BF 06 80 7E LDA $7E8006,x[$7E:8046];\
$A8:A508 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A50C 38          SEC                    ;} Enemy body segment 3 Y offset = [enemy length] / 2 * -sin([enemy body segment 3 angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin Y position]
$A8:A50D FF 1E 78 7E SBC $7E781E,x[$7E:785E];|
$A8:A511 9F 0A 78 7E STA $7E780A,x[$7E:784A];/
$A8:A515 BF 08 80 7E LDA $7E8008,x[$7E:8048];\
$A8:A519 22 42 A7 A8 JSL $A8A742[$A8:A742]  ;|
$A8:A51D 38          SEC                    ;} Enemy head segment Y offset = [enemy length] / 2 * -sin([enemy head segment angle] * pi / 80h) * 7FFFh / 8000h - [enemy origin Y position]
$A8:A51E FF 1E 78 7E SBC $7E781E,x[$7E:785E];|
$A8:A522 9F 0E 78 7E STA $7E780E,x[$7E:784E];/
$A8:A526 20 39 A3    JSR $A339  [$A8:A339]  ; Calculate body segment 1 velocities
$A8:A529 20 7C A3    JSR $A37C  [$A8:A37C]  ; Calculate body segment 2 velocities
$A8:A52C 20 BF A3    JSR $A3BF  [$A8:A3BF]  ; Calculate body segment 3 velocities
$A8:A52F 20 02 A4    JSR $A402  [$A8:A402]  ; Calculate head segment velocities
$A8:A532 18          CLC                    ;\
$A8:A533 BF 00 78 7E LDA $7E7800,x[$7E:7840];|
$A8:A537 7F 0E 80 7E ADC $7E800E,x[$7E:804E];} Enemy body segment 1 X offset += [enemy body segment 1 X velocity]
$A8:A53B 9F 00 78 7E STA $7E7800,x[$7E:7840];/
$A8:A53F BF 02 78 7E LDA $7E7802,x[$7E:7842];\
$A8:A543 7F 10 80 7E ADC $7E8010,x[$7E:8050];} Enemy body segment 1 Y offset += [enemy body segment 1 Y velocity]
$A8:A547 9F 02 78 7E STA $7E7802,x[$7E:7842];/
$A8:A54B BF 04 78 7E LDA $7E7804,x[$7E:7844];\
$A8:A54F 7F 12 80 7E ADC $7E8012,x[$7E:8052];} Enemy body segment 2 X offset += [enemy body segment 2 X velocity]
$A8:A553 9F 04 78 7E STA $7E7804,x[$7E:7844];/
$A8:A557 BF 06 78 7E LDA $7E7806,x[$7E:7846];\
$A8:A55B 7F 14 80 7E ADC $7E8014,x[$7E:8054];} Enemy body segment 2 Y offset += [enemy body segment 2 Y velocity]
$A8:A55F 9F 06 78 7E STA $7E7806,x[$7E:7846];/
$A8:A563 BF 08 78 7E LDA $7E7808,x[$7E:7848];\
$A8:A567 7F 16 80 7E ADC $7E8016,x[$7E:8056];} Enemy body segment 3 X offset += [enemy body segment 3 X velocity]
$A8:A56B 9F 08 78 7E STA $7E7808,x[$7E:7848];/
$A8:A56F BF 0A 78 7E LDA $7E780A,x[$7E:784A];\
$A8:A573 7F 18 80 7E ADC $7E8018,x[$7E:8058];} Enemy body segment 3 Y offset += [enemy body segment 3 Y velocity]
$A8:A577 9F 0A 78 7E STA $7E780A,x[$7E:784A];/
$A8:A57B BF 0C 78 7E LDA $7E780C,x[$7E:784C];\
$A8:A57F 7F 1A 80 7E ADC $7E801A,x[$7E:805A];} Enemy head segment X offset += [enemy head segment X velocity]
$A8:A583 9F 0C 78 7E STA $7E780C,x[$7E:784C];/
$A8:A587 BF 0E 78 7E LDA $7E780E,x[$7E:784E];\
$A8:A58B 7F 1C 80 7E ADC $7E801C,x[$7E:805C];} Enemy head segment Y offset += [enemy head segment Y velocity]
$A8:A58F 9F 0E 78 7E STA $7E780E,x[$7E:784E];/
$A8:A593 BF 18 78 7E LDA $7E7818,x[$7E:7858];\
$A8:A597 18          CLC                    ;|
$A8:A598 7F 0C 78 7E ADC $7E780C,x[$7E:784C];} Enemy X position = [enemy body segment base X position] + [enemy head segment X offset]
$A8:A59C 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;/
$A8:A59F BF 1A 78 7E LDA $7E781A,x[$7E:785A];\
$A8:A5A3 18          CLC                    ;|
$A8:A5A4 7F 0E 78 7E ADC $7E780E,x[$7E:784E];} Enemy Y position = [enemy body segment base Y position] + [enemy head segment Y offset]
$A8:A5A8 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:A5AB 20 3E A6    JSR $A63E  [$A8:A63E]  ; Update yapping maw angular speed
$A8:A5AE BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:A5B1 C9 00 00    CMP #$0000             ;} If [enemy angle] < 0: go to BRANCH_COOLDOWN
$A8:A5B4 30 1C       BMI $1C    [$A5D2]     ;/
$A8:A5B6 C9 80 00    CMP #$0080             ;\
$A8:A5B9 30 34       BMI $34    [$A5EF]     ;} If [enemy angle] < 80h: go to BRANCH_MOVE_SAMUS
$A8:A5BB A9 80 00    LDA #$0080             ;\
$A8:A5BE 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy angle = 80h.0
$A8:A5C1 9E AC 0F    STZ $0FAC,x[$7E:0FEC]  ;/
$A8:A5C4 FE AE 0F    INC $0FAE,x[$7E:0FEE]  ;\
$A8:A5C7 FE AE 0F    INC $0FAE,x[$7E:0FEE]  ;|
$A8:A5CA FE AE 0F    INC $0FAE,x[$7E:0FEE]  ;} Enemy angular speed table index += 4 (negated speed)
$A8:A5CD FE AE 0F    INC $0FAE,x[$7E:0FEE]  ;/
$A8:A5D0 80 1D       BRA $1D    [$A5EF]     ; Go to BRANCH_MOVE_SAMUS

; BRANCH_COOLDOWN
$A8:A5D2 A9 8A A6    LDA #$A68A             ;\
$A8:A5D5 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $A68A (cooldown)
$A8:A5D8 A9 30 00    LDA #$0030             ;\
$A8:A5DB 9F 2A 80 7E STA $7E802A,x[$7E:806A];} Enemy intangibility timer = 30h
$A8:A5DF BF 28 80 7E LDA $7E8028,x[$7E:8068];\
$A8:A5E3 C9 04 00    CMP #$0004             ;} If [enemy instruction list table index] = right: go to BRANCH_UP_RIGHT
$A8:A5E6 F0 09       BEQ $09    [$A5F1]     ;/
$A8:A5E8 C9 0C 00    CMP #$000C             ;\
$A8:A5EB F0 0C       BEQ $0C    [$A5F9]     ;} If [enemy instruction list table index] = left: go to BRANCH_UP_LEFT
$A8:A5ED 80 12       BRA $12    [$A601]     ; Go to BRANCH_UP

$A8:A5EF 80 43       BRA $43    [$A634]

; BRANCH_UP_RIGHT
$A8:A5F1 A9 1F A0    LDA #$A01F             ;\
$A8:A5F4 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $A01F
$A8:A5F7 80 0E       BRA $0E    [$A607]     ; Go to BRANCH_UP_MERGE

; BRANCH_UP_LEFT
$A8:A5F9 A9 3D A0    LDA #$A03D             ;\
$A8:A5FC 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $A03D
$A8:A5FF 80 06       BRA $06    [$A607]     ; Go to BRANCH_UP_MERGE

; BRANCH_UP
$A8:A601 A9 25 A0    LDA #$A025             ;\
$A8:A604 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $A025

; BRANCH_UP_MERGE
$A8:A607 BD B6 0F    LDA $0FB6,x[$7E:0FF6]  ;\
$A8:A60A D0 31       BNE $31    [$A63D]     ;} If [enemy parameter 2] != 0: return
$A8:A60C BF 28 80 7E LDA $7E8028,x[$7E:8028];\
$A8:A610 C9 04 00    CMP #$0004             ;} If [enemy instruction list table index] = right: go to BRANCH_DOWN_RIGHT
$A8:A613 F0 07       BEQ $07    [$A61C]     ;/
$A8:A615 C9 0C 00    CMP #$000C             ;\
$A8:A618 F0 0A       BEQ $0A    [$A624]     ;} If [enemy instruction list table index] = left: go to BRANCH_DOWN_LEFT
$A8:A61A 80 10       BRA $10    [$A62C]     ; Go to BRANCH_DOWN

; BRANCH_DOWN_RIGHT
$A8:A61C A9 5B A0    LDA #$A05B             ;\
$A8:A61F 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $A05B
$A8:A622 80 10       BRA $10    [$A634]     ; Go to BRANCH_MOVE_SAMUS

; BRANCH_DOWN_LEFT
$A8:A624 A9 79 A0    LDA #$A079             ;\
$A8:A627 9D 92 0F    STA $0F92,x            ;} Enemy instruction list pointer = $A079
$A8:A62A 80 08       BRA $08    [$A634]     ; Go to BRANCH_MOVE_SAMUS

; BRANCH_DOWN
$A8:A62C A9 61 A0    LDA #$A061             ;\
$A8:A62F 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $A061
$A8:A632 80 09       BRA $09    [$A63D]     ; Return

; BRANCH_MOVE_SAMUS
$A8:A634 BF 20 80 7E LDA $7E8020,x[$7E:8060];\
$A8:A638 F0 03       BEQ $03    [$A63D]     ;} If [enemy grabbing Samus flag] != 0:
$A8:A63A 20 65 A6    JSR $A665  [$A8:A665]  ; Move Samus with yapping maw pincers

$A8:A63D 60          RTS
}


;;; $A63E: Update yapping maw angular speed ;;;
{
$A8:A63E BC AE 0F    LDY $0FAE,x[$7E:0FEE]  ; Y = [enemy angular speed table index] (quadratic speed table index)
$A8:A641 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:A644 18          CLC                    ;|
$A8:A645 79 91 83    ADC $8391,y[$A8:8391]  ;|
$A8:A648 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;|
$A8:A64B BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;|
$A8:A64E 18          CLC                    ;} Enemy angle += [$838F + [Y] + 2].[$838F + [Y]]
$A8:A64F 79 8F 83    ADC $838F,y[$A8:838F]  ;|
$A8:A652 90 03       BCC $03    [$A657]     ;|
$A8:A654 FE AA 0F    INC $0FAA,x[$7E:0FEA]  ;|
                                            ;|
$A8:A657 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;/
$A8:A65A BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$A8:A65D 18          CLC                    ;|
$A8:A65E 69 08 00    ADC #$0008             ;} Enemy angular speed table index += 8
$A8:A661 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/
$A8:A664 60          RTS
}


;;; $A665: Move Samus with yapping maw pincers ;;;
{
$A8:A665 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A668 A9 03 00    LDA #$0003             ;\
$A8:A66B 22 84 F0 90 JSL $90F084[$90:F084]  ;} Run Samus command - unspin Samus
$A8:A66F BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A8:A672 18          CLC                    ;|
$A8:A673 7F 24 80 7E ADC $7E8024,x[$7E:8064];} Samus X position = [enemy X position] + [enemy Samus X offset]
$A8:A677 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$A8:A67A BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:A67D 18          CLC                    ;|
$A8:A67E 7F 26 80 7E ADC $7E8026,x[$7E:8066];} Samus Y position = [enemy Y position] + [enemy Samus Y offset]
$A8:A682 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A8:A685 22 A1 B7 A0 JSL $A0B7A1[$A0:B7A1]  ; Cap scrolling speed
$A8:A689 60          RTS
}


;;; $A68A: Yapping maw function - cooldown ;;;
{
; BUG: Yapping maw shinespark crash crash is an eventual consequence of the *reckless* setting of Samus pose input handler to $E913 (normal)
;      During shinespark, Samus pose input handler is supposed to be an RTS to disable transition table lookup
;      With transition table lookup allowed, and because the entries for shinespark poses are empty, if no buttons are being pressed,
;      then $91:8304 is executed, which sets prospective pose change command = stop
;      Hence, when $91:EB88 (update Samus pose) is called, $91:ECD0 (prospective pose change command 2 - stop) is executed,
;      which calls $91:DE53 (cancel speed boosting), which sets $0AAF = FFh with the intention of flagging the echoes to merge back into Samus
;      However, during shinespark crash, $0AAF is used as "shinespark crash echo circle phase",
;      which is a jump table index in $90:D346 (Samus movement handler - shinespark crash - echoes circle Samus),
;      which is only 3 entries long
;      The resulting jump pointer is loaded from $90:D57B, which happens to be $FEAD, which is in the free space of bank $90
;      Eventually, the PC lands on $0001 and starts executing from WRAM where a crash is inevitable

$A8:A68A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A68D BF 20 80 7E LDA $7E8020,x[$7E:8060];\
$A8:A691 F0 03       BEQ $03    [$A696]     ;} If [enemy grabbing Samus flag] != 0:
$A8:A693 20 65 A6    JSR $A665  [$A8:A665]  ; Move Samus with yapping maw pincers

$A8:A696 DE B0 0F    DEC $0FB0,x[$7E:0FF0]  ; Decrement enemy cooldown timer
$A8:A699 10 28       BPL $28    [$A6C3]     ; If [enemy cooldown timer] >= 0: return
$A8:A69B AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$A8:A69E C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] = $E91D (demo): return
$A8:A6A1 F0 20       BEQ $20    [$A6C3]     ;/
$A8:A6A3 A9 13 E9    LDA #$E913             ;\
$A8:A6A6 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)
$A8:A6A9 A9 00 00    LDA #$0000             ;\
$A8:A6AC 9F 20 80 7E STA $7E8020,x[$7E:80A0];} Enemy grabbing Samus flag = 0
$A8:A6B0 A9 30 00    LDA #$0030             ;\
$A8:A6B3 9F 2A 80 7E STA $7E802A,x[$7E:80AA];} Enemy intangibility timer = 30h
$A8:A6B7 A9 40 00    LDA #$0040             ;\
$A8:A6BA 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy cooldown timer = 40h
$A8:A6BD A9 35 A2    LDA #$A235             ;\
$A8:A6C0 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $A235 (neutral)

$A8:A6C3 60          RTS
}


;;; $A6C4: Set body segment 0 position ;;;
{
$A8:A6C4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A6C7 BF 00 88 7E LDA $7E8800,x[$7E:8840];\
$A8:A6CB A8          TAY                    ;} Y = [enemy body segment 0 enemy projectile index] (enemy projectile index)
$A8:A6CC BF 18 78 7E LDA $7E7818,x[$7E:7858];\
$A8:A6D0 99 4B 1A    STA $1A4B,y[$7E:1A5F]  ;} Enemy projectile X position = [enemy body segment base X position]
$A8:A6D3 BF 1A 78 7E LDA $7E781A,x[$7E:785A];\
$A8:A6D7 99 93 1A    STA $1A93,y[$7E:1AA7]  ;} Enemy projectile Y position = [enemy body segment base Y position]
$A8:A6DA 60          RTS
}


;;; $A6DB: Set body segment 1 position ;;;
{
$A8:A6DB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A6DE BF 02 88 7E LDA $7E8802,x[$7E:8842];\
$A8:A6E2 A8          TAY                    ;} Y = [enemy body segment 1 enemy projectile index] (enemy projectile index)
$A8:A6E3 BF 18 78 7E LDA $7E7818,x[$7E:7858];\
$A8:A6E7 18          CLC                    ;|
$A8:A6E8 7F 00 78 7E ADC $7E7800,x[$7E:7840];} Enemy projectile X position = [enemy body segment base X position] + [enemy body segment 1 X offset]
$A8:A6EC 99 4B 1A    STA $1A4B,y[$7E:1A61]  ;/
$A8:A6EF BF 1A 78 7E LDA $7E781A,x[$7E:785A];\
$A8:A6F3 18          CLC                    ;|
$A8:A6F4 7F 02 78 7E ADC $7E7802,x[$7E:7842];} Enemy projectile Y position = [enemy body segment base Y position] + [enemy body segment 1 Y offset]
$A8:A6F8 99 93 1A    STA $1A93,y[$7E:1AA9]  ;/
$A8:A6FB 60          RTS
}


;;; $A6FC: Set body segment 2 position ;;;
{
$A8:A6FC AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A6FF BF 04 88 7E LDA $7E8804,x[$7E:8844];\
$A8:A703 A8          TAY                    ;} Y = [enemy body segment 2 enemy projectile index] (enemy projectile index)
$A8:A704 BF 18 78 7E LDA $7E7818,x[$7E:7858];\
$A8:A708 18          CLC                    ;|
$A8:A709 7F 04 78 7E ADC $7E7804,x[$7E:7844];} Enemy projectile X position = [enemy body segment base X position] + [enemy body segment 2 X offset]
$A8:A70D 99 4B 1A    STA $1A4B,y[$7E:1A63]  ;/
$A8:A710 BF 1A 78 7E LDA $7E781A,x[$7E:785A];\
$A8:A714 18          CLC                    ;|
$A8:A715 7F 06 78 7E ADC $7E7806,x[$7E:7846];} Enemy projectile Y position = [enemy body segment base Y position] + [enemy body segment 2 Y offset]
$A8:A719 99 93 1A    STA $1A93,y[$7E:1AAB]  ;/
$A8:A71C 60          RTS
}


;;; $A71D: Set body segment 3 position ;;;
{
$A8:A71D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A720 BF 06 88 7E LDA $7E8806,x[$7E:8846];\
$A8:A724 A8          TAY                    ;} Y = [enemy body segment 3 enemy projectile index] (enemy projectile index)
$A8:A725 BF 18 78 7E LDA $7E7818,x[$7E:7858];\
$A8:A729 18          CLC                    ;|
$A8:A72A 7F 08 78 7E ADC $7E7808,x[$7E:7848];} Enemy projectile X position = [enemy body segment base X position] + [enemy body segment 3 X offset]
$A8:A72E 99 4B 1A    STA $1A4B,y[$7E:1A65]  ;/
$A8:A731 BF 1A 78 7E LDA $7E781A,x[$7E:785A];\
$A8:A735 18          CLC                    ;|
$A8:A736 7F 0A 78 7E ADC $7E780A,x[$7E:784A];} Enemy projectile Y position = [enemy body segment base Y position] + [enemy body segment 3 Y offset]
$A8:A73A 99 93 1A    STA $1A93,y[$7E:1AAD]  ;/
$A8:A73D 60          RTS
}


;;; $A73E: A = [$0E32] * cos([A] * pi / 80h) * 7FFFh / 8000h ;;;
{
;; Parameters:
;;     A: Angle
;;     $0E32: Radius
;; Returns:
;;     A: [$0E32] * cos([A] * pi / 80h) * 7FFFh / 8000h
$A8:A73E 38          SEC                    ;\
$A8:A73F E9 40 00    SBC #$0040             ;} A -= 40h
}


;;; $A742: A = [$0E32] * -sin([A] * pi / 80h) * 7FFFh / 8000h ;;;
{
;; Parameters:
;;     A: Angle
;;     $0E32: Radius
;; Returns:
;;     A: [$0E32] * -sin([A] * pi / 80h) * 7FFFh / 8000h
$A8:A742 85 12       STA $12    [$7E:0012]  ;\
$A8:A744 A9 00 01    LDA #$0100             ;|
$A8:A747 38          SEC                    ;|
$A8:A748 E5 12       SBC $12    [$7E:0012]  ;} X = -[A] % 100h * 2
$A8:A74A 29 FF 00    AND #$00FF             ;|
$A8:A74D 0A          ASL A                  ;|
$A8:A74E AA          TAX                    ;/
$A8:A74F 08          PHP
$A8:A750 64 14       STZ $14    [$7E:0014]  ; $14 = 0 (sign bit)
$A8:A752 64 16       STZ $16    [$7E:0016]  ; $16 = 0 (result)
$A8:A754 BF C3 B1 A0 LDA $A0B1C3,x[$A0:B343]; A = sin([X] / 2 * pi / 80h) * 7FFFh
$A8:A758 10 06       BPL $06    [$A760]     ; If [A] < 0:
$A8:A75A 49 FF FF    EOR #$FFFF             ;\
$A8:A75D 1A          INC A                  ;} Negate A
$A8:A75E E6 14       INC $14    [$7E:0014]  ; $14 = 1

$A8:A760 29 00 FF    AND #$FF00             ;\
$A8:A763 EB          XBA                    ;|
$A8:A764 E2 20       SEP #$20               ;} $4202 = [A] / 100h
$A8:A766 8D 02 42    STA $4202              ;/
$A8:A769 AD 32 0E    LDA $0E32  [$7E:0E32]  ;\
$A8:A76C F0 24       BEQ $24    [$A792]     ;} If [$0E32] != 0:
$A8:A76E 8D 03 42    STA $4203              ;\
$A8:A771 EA          NOP                    ;|
$A8:A772 EA          NOP                    ;|
$A8:A773 EA          NOP                    ;|
$A8:A774 C2 20       REP #$20               ;|
$A8:A776 AD 16 42    LDA $4216              ;} $16 = [$4202] * [$0E32] / 100h * 2
$A8:A779 29 00 FF    AND #$FF00             ;|
$A8:A77C EB          XBA                    ;|
$A8:A77D 0A          ASL A                  ;|
$A8:A77E 85 16       STA $16    [$7E:0016]  ;/
$A8:A780 A5 14       LDA $14    [$7E:0014]  ;\
$A8:A782 F0 0E       BEQ $0E    [$A792]     ;} If [$14] != 0:
$A8:A784 AD 16 42    LDA $4216              ;\
$A8:A787 49 FF FF    EOR #$FFFF             ;|
$A8:A78A 1A          INC A                  ;|
$A8:A78B EB          XBA                    ;} Negate $16
$A8:A78C 0A          ASL A                  ;|
$A8:A78D 09 00 FF    ORA #$FF00             ;|
$A8:A790 85 16       STA $16    [$7E:0016]  ;/

$A8:A792 A5 16       LDA $16    [$7E:0016]  ; A = [$16]
$A8:A794 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A797 28          PLP
$A8:A798 6B          RTL
}


;;; $A799: Enemy touch - enemy $E7BF (yapping maw) ;;;
{
$A8:A799 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A79C BF 2A 80 7E LDA $7E802A,x[$7E:806A];\
$A8:A7A0 10 1A       BPL $1A    [$A7BC]     ;} If [enemy intangibility timer] >= 0: return
$A8:A7A2 BF 20 80 7E LDA $7E8020,x[$7E:8060];\
$A8:A7A6 D0 14       BNE $14    [$A7BC]     ;} If [enemy grabbing Samus flag] != 0: return
$A8:A7A8 A9 00 00    LDA #$0000             ;\
$A8:A7AB 9F 2A 80 7E STA $7E802A,x[$7E:806A];} Enemy intangibility timer = 0
$A8:A7AF A9 01 00    LDA #$0001             ;\
$A8:A7B2 9F 20 80 7E STA $7E8020,x[$7E:8060];} Enemy grabbing Samus flag = 1
$A8:A7B6 A9 0E E9    LDA #$E90E             ;\
$A8:A7B9 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = RTS

$A8:A7BC 6B          RTL
}


;;; $A7BD: Enemy shot - enemy $E7BF (yapping maw) ;;;
{
; BUG: Yapping maw shinespark crash crash applies here too if a yapping maw is frozen or killed, see $A68A
$A8:A7BD 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A8:A7C1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A7C4 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;\
$A8:A7C7 D0 51       BNE $51    [$A81A]     ;} If [enemy health] != 0: go to BRANCH_ALIVE
$A8:A7C9 BF 00 88 7E LDA $7E8800,x          ;\
$A8:A7CD A8          TAY                    ;|
$A8:A7CE A9 00 00    LDA #$0000             ;} Enemy body segment 0 enemy projectile ID = 0
$A8:A7D1 99 97 19    STA $1997,y            ;/
$A8:A7D4 BF 02 88 7E LDA $7E8802,x          ;\
$A8:A7D8 A8          TAY                    ;|
$A8:A7D9 A9 00 00    LDA #$0000             ;} Enemy body segment 1 enemy projectile ID = 0
$A8:A7DC 99 97 19    STA $1997,y            ;/
$A8:A7DF BF 04 88 7E LDA $7E8804,x          ;\
$A8:A7E3 A8          TAY                    ;|
$A8:A7E4 A9 00 00    LDA #$0000             ;} Enemy body segment 2 enemy projectile ID = 0
$A8:A7E7 99 97 19    STA $1997,y            ;/
$A8:A7EA BF 06 88 7E LDA $7E8806,x          ;\
$A8:A7EE A8          TAY                    ;|
$A8:A7EF A9 00 00    LDA #$0000             ;} Enemy body segment 3 enemy projectile ID = 0
$A8:A7F2 99 97 19    STA $1997,y            ;/
$A8:A7F5 DA          PHX                    ;\
$A8:A7F6 BF 0C 88 7E LDA $7E880C,x          ;|
$A8:A7FA AA          TAX                    ;|
$A8:A7FB A9 00 00    LDA #$0000             ;} Enemy base sprite object instruction list pointer = 0
$A8:A7FE 9F 78 EF 7E STA $7EEF78,x          ;|
$A8:A802 FA          PLX                    ;/
$A8:A803 AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$A8:A806 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$A8:A809 F0 06       BEQ $06    [$A811]     ;/
$A8:A80B A9 13 E9    LDA #$E913             ;\
$A8:A80E 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)

$A8:A811 A9 00 00    LDA #$0000             ;\
$A8:A814 9F 20 80 7E STA $7E8020,x          ;} Enemy grabbing Samus flag = 0
$A8:A818 80 1A       BRA $1A    [$A834]     ; Return

; BRANCH_ALIVE
$A8:A81A BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A8:A81D F0 15       BEQ $15    [$A834]     ;} If [enemy frozen timer] = 0: return
$A8:A81F AD 60 0A    LDA $0A60  [$7E:0A60]  ;\
$A8:A822 C9 1D E9    CMP #$E91D             ;} If [Samus pose input handler] != $E91D (demo):
$A8:A825 F0 06       BEQ $06    [$A82D]     ;/
$A8:A827 A9 13 E9    LDA #$E913             ;\
$A8:A82A 8D 60 0A    STA $0A60  [$7E:0A60]  ;} Samus pose input handler = $E913 (normal)

$A8:A82D A9 00 00    LDA #$0000             ;\
$A8:A830 9F 20 80 7E STA $7E8020,x[$7E:8020];} Enemy grabbing Samus flag = 0

$A8:A834 6B          RTL
}


;;; $A835: Frozen AI - enemy $E7BF (yapping maw) ;;;
{
$A8:A835 22 41 80 A8 JSL $A88041[$A8:8041]  ; Normal enemy frozen AI
$A8:A839 BF 00 88 7E LDA $7E8800,x[$7E:8800];\
$A8:A83D A8          TAY                    ;} Y = [enemy body segment 0 enemy projectile index]
$A8:A83E 20 5D A8    JSR $A85D  [$A8:A85D]  ; Set yapping maw body segment frozen palette
$A8:A841 BF 02 88 7E LDA $7E8802,x[$7E:8802];\
$A8:A845 A8          TAY                    ;} Y = [enemy body segment 1 enemy projectile index]
$A8:A846 20 5D A8    JSR $A85D  [$A8:A85D]  ; Set yapping maw body segment frozen palette
$A8:A849 BF 04 88 7E LDA $7E8804,x[$7E:8804];\
$A8:A84D A8          TAY                    ;} Y = [enemy body segment 2 enemy projectile index]
$A8:A84E 20 5D A8    JSR $A85D  [$A8:A85D]  ; Set yapping maw body segment frozen palette
$A8:A851 BF 06 88 7E LDA $7E8806,x[$7E:8806];\
$A8:A855 A8          TAY                    ;} Y = [enemy body segment 3 enemy projectile index]
$A8:A856 20 5D A8    JSR $A85D  [$A8:A85D]  ; Set yapping maw body segment frozen palette
$A8:A859 20 99 A8    JSR $A899  [$A8:A899]  ; Set yapping maw base frozen palette
$A8:A85C 6B          RTL
}


;;; $A85D: Set yapping maw body segment frozen palette ;;;
{
;; Parameters:
;;     Y: Enemy projectile index
$A8:A85D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A860 B9 BB 19    LDA $19BB,y[$7E:19D7]  ;\
$A8:A863 29 FF F1    AND #$F1FF             ;|
$A8:A866 1F 0A 88 7E ORA $7E880A,x[$7E:880A];} Enemy projectile palette index = [enemy initial palette index]
$A8:A86A 99 BB 19    STA $19BB,y[$7E:19D7]  ;/
$A8:A86D BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A8:A870 F0 26       BEQ $26    [$A898]     ;} If [enemy frozen timer] = 0: return
$A8:A872 B9 BB 19    LDA $19BB,y[$7E:19D7]  ;\
$A8:A875 29 FF F1    AND #$F1FF             ;|
$A8:A878 09 00 0C    ORA #$0C00             ;} Enemy projectile palette index = palette 6 (beams)
$A8:A87B 99 BB 19    STA $19BB,y[$7E:19D7]  ;/
$A8:A87E BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A8:A881 C9 5A 00    CMP #$005A             ;} If [enemy frozen timer] < 90:
$A8:A884 10 12       BPL $12    [$A898]     ;/
$A8:A886 89 02 00    BIT #$0002             ;\
$A8:A889 D0 0D       BNE $0D    [$A898]     ;} If [enemy frozen timer] / 2 % 2 = 0:
$A8:A88B B9 BB 19    LDA $19BB,y[$7E:19D7]  ;\
$A8:A88E 29 FF F1    AND #$F1FF             ;|
$A8:A891 1F 0A 88 7E ORA $7E880A,x[$7E:880A];} Enemy projectile palette index = [enemy initial palette index]
$A8:A895 99 BB 19    STA $19BB,y[$7E:19D7]  ;/

$A8:A898 60          RTS
}


;;; $A899: Set yapping maw base frozen palette ;;;
{
$A8:A899 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A89C BF 0A 88 7E LDA $7E880A,x[$7E:880A];\
$A8:A8A0 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy initial palette index]
$A8:A8A2 BF 0C 88 7E LDA $7E880C,x[$7E:880C];\
$A8:A8A6 85 14       STA $14    [$7E:0014]  ;} X = $14 = [enemy base sprite object index]
$A8:A8A8 AA          TAX                    ;/
$A8:A8A9 BF 78 F0 7E LDA $7EF078,x[$7E:F0B6];\
$A8:A8AD 29 FF F1    AND #$F1FF             ;|
$A8:A8B0 05 12       ORA $12    [$7E:0012]  ;} Sprite object palette = [enemy initial palette index]
$A8:A8B2 9F 78 F0 7E STA $7EF078,x[$7E:F0B6];/
$A8:A8B6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A8B9 BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A8:A8BC F0 2F       BEQ $2F    [$A8ED]     ;} If [enemy frozen timer] = 0: return
$A8:A8BE A6 14       LDX $14    [$7E:0014]  ;\
$A8:A8C0 BF 78 F0 7E LDA $7EF078,x[$7E:F0B6];|
$A8:A8C4 29 FF F1    AND #$F1FF             ;} Sprite object palette index = palette 6 (beams)
$A8:A8C7 09 00 0C    ORA #$0C00             ;|
$A8:A8CA 9F 78 F0 7E STA $7EF078,x[$7E:F0B6];/
$A8:A8CE AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:A8D1 BD 9E 0F    LDA $0F9E,x[$7E:0F9E]  ;\
$A8:A8D4 C9 5A 00    CMP #$005A             ;} If [enemy frozen timer] < 90:
$A8:A8D7 10 14       BPL $14    [$A8ED]     ;/
$A8:A8D9 89 02 00    BIT #$0002             ;\
$A8:A8DC D0 0F       BNE $0F    [$A8ED]     ;} If [enemy frozen timer] / 2 % 2 = 0:
$A8:A8DE A6 14       LDX $14    [$7E:0014]  ;\
$A8:A8E0 BF 78 F0 7E LDA $7EF078,x[$7E:F0B6];|
$A8:A8E4 29 FF F1    AND #$F1FF             ;} Sprite object palette index = [enemy initial palette index]
$A8:A8E7 05 12       ORA $12    [$7E:0012]  ;|
$A8:A8E9 9F 78 F0 7E STA $7EF078,x[$7E:F0B6];/

$A8:A8ED 60          RTS
}


;;; $A8EE: Yapping maw spritemaps ;;;
{
$A8:A8EE             dx 0005, 81F8,F8,2100, 01F4,FA,210F, 01EC,FA,210E, 0004,FA,610F, 000C,FA,610E
$A8:A909             dx 0003, 81F8,F8,2100, 8004,F0,6106, 81EC,F0,2106
$A8:A91A             dx 0005, 81F8,F8,2100, 0000,F6,610D, 0000,EE,610C, 01F8,F6,210D, 01F8,EE,210C
$A8:A935             dx 0003, 81F8,F8,2102, 81F2,EE,2106, 8002,FE,E108
$A8:A946             dx 0005, 81F8,F8,2102, 0005,FD,610F, 000D,FD,610E, 01FB,F3,210D, 01FB,EB,210C
$A8:A961             dx 0003, 81F8,F8,2102, 8001,F4,6106, 81FC,EF,6108
$A8:A972             dx 0005, 81F8,F8,2104, 01FE,04,A10D, 01FE,0C,A10C, 01FE,F4,210D, 01FE,EC,210C
$A8:A98D             dx 0003, 81F8,F8,2104, 8000,EC,6108, 8000,04,E108
$A8:A99E             dx 0005, 81F8,F8,2104, 0003,F8,E10F, 000B,F8,E10E, 0003,00,610F, 000B,00,610E
$A8:A9B9             dx 0003, 81F8,F8,A102, 81F2,02,A106, 8002,F2,6108
$A8:A9CA             dx 0005, 81F8,F8,A102, 0005,FB,E10F, 000D,FB,E10E, 01FB,05,A10D, 01FB,0D,A10C
$A8:A9E5             dx 0003, 81F8,F8,A102, 8001,FC,E106, 81FC,01,E108
$A8:A9F6             dx 0005, 81F8,F8,A100, 01F4,FE,A10F, 01EC,FE,A10E, 0004,FE,E10F, 000C,FE,E10E
$A8:AA11             dx 0003, 81F8,F8,A100, 8004,00,E106, 81EC,00,A106
$A8:AA22             dx 0005, 81F8,F8,A100, 0000,02,E10D, 0000,0A,E10C, 01F8,02,A10D, 01F8,0A,A10C
$A8:AA3D             dx 0003, 81F8,F8,E102, 81FE,02,E106, 81EE,F2,2108
$A8:AA4E             dx 0005, 81F8,F8,E102, 01F3,FB,A10F, 01EB,FB,A10E, 01FD,05,E10D, 01FD,0D,E10C
$A8:AA69             dx 0003, 81F8,F8,E102, 81EF,FC,A106, 81F4,01,A108
$A8:AA7A             dx 0005, 81F8,F8,6104, 01FA,04,E10D, 01FA,0C,E10C, 01FA,F4,610D, 01FA,EC,610C
$A8:AA95             dx 0003, 81F8,F8,6104, 81F0,EC,2108, 81F0,04,A108
$A8:AAA6             dx 0005, 81F8,F8,6104, 01F5,F8,A10F, 01ED,F8,A10E, 01F5,00,210F, 01ED,00,210E
$A8:AAC1             dx 0003, 81F8,F8,6102, 81FE,EE,6106, 81EE,FE,A108
$A8:AAD2             dx 0005, 81F8,F8,6102, 01F3,FD,210F, 01EB,FD,210E, 01FD,F3,610D, 01FD,EB,610C
$A8:AAED             dx 0003, 81F8,F8,6102, 81EF,F4,2106, 81F4,EF,2108
}
}


;;; $AAFE..AC1B: Kago ;;;
{
;;; $AAFE: Palette - enemy $E7FF (kago) ;;;
{
$A8:AAFE             dw 3800, 57FF, 42F7, 0929, 00A5, 4F5A, 36B5, 2610, 1DCE, 01DF, 001F, 0018, 000A, 06B9, 00EA, 0045
}


;;; $AB1E: Instruction list - slow ;;;
{
$A8:AB1E             dx 000A,ABDA,
                        000A,ABF0,
                        000A,AC06,
                        000A,ABF0,
                        80ED,AB1E   ; Go to $AB1E
}


;;; $AB32: Instruction list - fast ;;;
{
$A8:AB32             dx 0003,ABDA,
                        0003,ABF0,
                        0003,AC06,
                        0003,ABF0,
                        80ED,AB32   ; Go to $AB32
}


;;; $AB46: Initialisation AI - enemy $E7FF (kago) ;;;
{
; Hit counter is $7E:7808, how obscure
$A8:AB46 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AB49 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:AB4C 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A8:AB4F 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:AB52 A9 01 00    LDA #$0001             ;\
$A8:AB55 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:AB58 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:AB5B 9E B0 0F    STZ $0FB0,x[$7E:0FB0]  ; Enemy $0FB0 = 0 (never read)
$A8:AB5E A9 1E AB    LDA #$AB1E             ;\
$A8:AB61 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $AB1E (slow)
$A8:AB64 A9 7B AB    LDA #$AB7B             ;\
$A8:AB67 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $AB7B (nothing)
$A8:AB6A 9E B2 0F    STZ $0FB2,x[$7E:0FB2]  ; Enemy $0FB2 = 0 (never read)
$A8:AB6D BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:AB70 9F 08 78 7E STA $7E7808,x[$7E:7808];} Enemy hit counter = [enemy parameter 1]
$A8:AB74 6B          RTL
}


;;; $AB75: Main AI - enemy $E7FF (kago) ;;;
{
$A8:AB75 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AB78 7C A8 0F    JMP ($0FA8,x)[$A8:AB7B]; Go to [enemy function]
}


;;; $AB7B: Kago function - nothing ;;;
{
$A8:AB7B A9 81 AB    LDA #$AB81             ;\
$A8:AB7E 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = RTL
$A8:AB81 6B          RTL
}


;;; $AB82: RTL ;;;
{
$A8:AB82 6B          RTL
}


;;; $AB83: Enemy shot - enemy $E7FF (kago) ;;;
{
$A8:AB83 DA          PHX
$A8:AB84 5A          PHY
$A8:AB85 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A8:AB89 A9 02 00    LDA #$0002             ;\
$A8:AB8C 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 1 pixel displacement, diagonal
$A8:AB8F A9 10 00    LDA #$0010             ;\
$A8:AB92 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 10h
$A8:AB95 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AB98 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:AB9B D0 12       BNE $12    [$ABAF]     ;} If [enemy fast animation flag] = 0:
$A8:AB9D A9 01 00    LDA #$0001             ;\
$A8:ABA0 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy fast animation flag = 1
$A8:ABA3 A9 32 AB    LDA #$AB32             ;\
$A8:ABA6 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $AB32 (fast)
$A8:ABA9 A9 01 00    LDA #$0001             ;\
$A8:ABAC 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1

$A8:ABAF BF 08 78 7E LDA $7E7808,x[$7E:7848];\
$A8:ABB3 38          SEC                    ;|
$A8:ABB4 E9 01 00    SBC #$0001             ;} Decrement enemy hit counter
$A8:ABB7 9F 08 78 7E STA $7E7808,x[$7E:7848];/
$A8:ABBB 10 10       BPL $10    [$ABCD]     ; If [enemy hit counter] < 0:
$A8:ABBD A9 04 00    LDA #$0004             ; A = 4 (big explosion)
$A8:ABC0 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death
$A8:ABC4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:ABC7 A9 01 00    LDA #$0001             ;\
$A8:ABCA 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy $0FB2 = 1 (never read)

$A8:ABCD A0 2E D0    LDY #$D02E             ;\
$A8:ABD0 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;} Spawn kago bug enemy projectile (parameter ignored)
$A8:ABD3 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:ABD7 7A          PLY
$A8:ABD8 FA          PLX
$A8:ABD9 6B          RTL
}


;;; $ABDA: Kago spritemaps ;;;
{
$A8:ABDA             dx 0004, 8000,00,210E, 81F0,00,210C, 8000,F0,2102, 81F0,F0,2100
$A8:ABF0             dx 0004, 8000,00,2122, 81F0,00,2120, 8000,F0,2106, 81F0,F0,2104
$A8:AC06             dx 0004, 8000,00,2126, 81F0,00,2124, 8000,F0,210A, 81F0,F0,2108
}
}


;;; $AC1C..B65D: Magdollite ;;;
{
;;; $AC1C: Palette - enemy $E83F (magdollite) ;;;
{
$A8:AC1C             dw 3800, 001F, 001C, 0018, 0015, 7FFF, 3BE0, 2680, 1580, 023F, 00BD, 0014, 0010, 0000, 0000, 0000
}


;;; $AC3C: Magdollite glow palettes ;;;
{
;                                                                     Only these four colours are actually used
;                                                                     |
$A8:AC3C             dw 3800,0000,0000,0000,0000,0000,0000,0000,0000, 00BD,0014,0010,023F, 0000,0000,0000,
$A8:AC5C             dw 3800,0000,0000,0000,0000,0000,0000,0000,0000, 0014,0010,023F,00BD, 0000,0000,0000,
$A8:AC7C             dw 3800,0000,0000,0000,0000,0000,0000,0000,0000, 0010,023F,00BD,0014, 0000,0000,0000
}


;;; $AC9C..AE11: Instruction lists - magdollite ;;;
{
;;; $AC9C: Instruction list - head - facing left - idle ;;;
{
$A8:AC9C             dx 000D,B448,
                        000D,B459,
                        000D,B46A,
                        000D,B459,
                        80ED,AC9C   ; Go to $AC9C
}


;;; $ACB0: Instruction list - hand - facing left - throwing lava ;;;
{
$A8:ACB0             dx AE12,0061,  ; Queue sound 61h, sound library 2, max queued sounds allowed = 6 (magdollite spit), if enemy is on-screen
                        AE3A,       ; Set animation active flag
                        AF44,       ; Reset cooldown timer
                        001A,B47B,
                        0008,B48C,
                        AEE4,       ; Set open hand position - facing left
                        0005,B49D,
                        AEBA,       ; Spawn magdollite lava enemy projectile
                        0005,B49D,
                        AEBA,       ; Spawn magdollite lava enemy projectile
                        0005,B49D,
                        AEBA,       ; Spawn magdollite lava enemy projectile
                        AF18,       ; Set closed hand position - facing left
                        0005,B4A9,
                        AE45,       ; Clear animation active flag
                        812F        ; Sleep
}


;;; $ACDE: Instruction list - head - facing left - submerge into lava ;;;
{
$A8:ACDE             dx AE3A,       ; Set animation active flag
                        0005,B459,
                        AE26,       ; Move head down 2px
                        0005,B459,
                        0005,B4CF,
                        0005,B4E0,
                        AE26,       ; Move head down 2px
                        0005,B4E0,
                        AE64,       ; Set submerged head + arm position, make arm + hand visible
                        8123,0018   ; Timer = 18h
$A8:ACFE             dx AE50,       ; Move head + arm up 1px
                        0001,B4C1,
                        8110,ACFE,  ; Decrement timer and go to $ACFE if non-zero
                        AE45,       ; Clear animation active flag
                        812F        ; Sleep
}


;;; $AD0C: Instruction list - head - facing left - emerge from lava ;;;
{
$A8:AD0C             dx AE3A,       ; Set animation active flag
                        AE88,       ; Reset head + arm position
                        8123,0018   ; Timer = 18h
$A8:AD14             dx AE5A,       ; Move head + arm down 1px
                        0001,B4C1,
                        8110,AD14,  ; Decrement timer and go to $AD14 if non-zero
                        AE96,       ; Set emerged head + arm position, make arm + hand invisible
                        0005,B4E0,
                        AE30,       ; Move head up 2px
                        0005,B4E0,
                        0005,B4CF,
                        0005,B459,
                        AE30,       ; Move head up 2px
                        0005,B459,
                        AE45,       ; Clear animation active flag
                        812F        ; Sleep
}


;;; $AD3C: Instruction list - head - facing right - idle ;;;
{
$A8:AD3C             dx 000D,B4F1,
                        000D,B502,
                        000D,B513,
                        000D,B502,
                        80ED,AD3C   ; Go to $AD3C
}


;;; $AD50: Instruction list - hand - facing right - throwing lava ;;;
{
$A8:AD50             dx AE12,0061,  ; Queue sound 61h, sound library 2, max queued sounds allowed = 6 (magdollite spit), if enemy is on-screen
                        AE3A,       ; Set animation active flag
                        AF44,       ; Reset cooldown timer
                        001A,B524,
                        0008,B535,
                        AECA,       ; Set open hand position - facing right
                        0005,B546,
                        AEBA,       ; Spawn magdollite lava enemy projectile
                        0005,B546,
                        AEBA,       ; Spawn magdollite lava enemy projectile
                        0005,B546,
                        AEBA,       ; Spawn magdollite lava enemy projectile
                        AEFE,       ; Set closed hand position - facing right
                        0005,B552,
                        AE45,       ; Clear animation active flag
                        812F        ; Sleep
}


;;; $AD7E: Instruction list - head - facing right - submerge into lava ;;;
{
$A8:AD7E             dx AE3A,       ; Set animation active flag
                        0005,B502,
                        AE26,       ; Move head down 2px
                        0005,B502,
                        0005,B578,
                        0005,B589,
                        AE26,       ; Move head down 2px
                        0005,B589,
                        AE64,       ; Set submerged head + arm position, make arm + hand visible
                        8123,0018   ; Timer = 18h
$A8:AD9E             dx AE50,       ; Move head + arm up 1px
                        0001,B56A,
                        8110,AD9E,  ; Decrement timer and go to $AD9E if non-zero
                        AE45,       ; Clear animation active flag
                        812F        ; Sleep
}


;;; $ADAC: Instruction list - head - facing right - emerge from lava ;;;
{
$A8:ADAC             dx AE3A,       ; Set animation active flag
                        AE88,       ; Reset head + arm position
                        8123,0018   ; Timer = 18h
$A2:ADB4             dx AE5A,       ; Move head + arm down 1px
                        0001,B56A,
                        8110,ADB4,  ; Decrement timer and go to $ADB4 if non-zero
                        AE96,       ; Set emerged head + arm position, make arm + hand invisible
                        0005,B589,
                        AE30,       ; Move head up 2px
                        0005,B589,
                        0005,B578,
                        0005,B502,
                        AE30,       ; Move head up 2px
                        0005,B502,
                        AE45,       ; Clear animation active flag
                        812F        ; Sleep
}


;;; $ADDC: Instruction list - arm - growth level 0 ;;;
{
$A8:ADDC             dx 0001,B59A,
                        812F        ; Sleep
}


;;; $ADE2: Instruction list - arm - growth level 1 ;;;
{
$A8:ADE2             dx 0001,B5A1,
                        812F        ; Sleep
}


;;; $ADE8: Instruction list - arm - growth level 2 ;;;
{
$A8:ADE8             dx 0001,B5AD,
                        812F        ; Sleep
}


;;; $ADEE: Instruction list - arm - growth level 3 ;;;
{
$A8:ADEE             dx 0001,B5BE,
                        812F        ; Sleep
}


;;; $ADF4: Instruction list - arm - growth level 4 ;;;
{
$A8:ADF4             dx 0001,B5D4,
                        812F        ; Sleep
}


;;; $ADFA: Instruction list - arm - growth level 5 ;;;
{
$A8:ADFA             dx 0001,B5EF,
                        812F        ; Sleep
}


;;; $AE00: Instruction list - arm - growth level 6 ;;;
{
$A8:AE00             dx 0001,B60F,
                        812F        ; Sleep
}


;;; $AE06: Instruction list - arm - growth level 7 ;;;
{
$A8:AE06             dx 0001,B634,
                        812F        ; Sleep
}


;;; $AE0C: Instruction list - hand - stub ;;;
{
$A8:AE0C             dx 0001,B4B5,
                        812F        ; Sleep
}
}


;;; $AE12..AF4E: Magdollite instructions ;;;
{
;;; $AE12: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6, if enemy is on-screen ;;;
{
$A8:AE12 DA          PHX
$A8:AE13 5A          PHY
$A8:AE14 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$A8:AE18 D0 07       BNE $07    [$AE21]     ;} If enemy centre is on screen:
$A8:AE1A B9 00 00    LDA $0000,y[$A8:AD52]  ;\
$A8:AE1D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound [[Y]], sound library 2, max queued sounds allowed = 6

$A8:AE21 7A          PLY
$A8:AE22 FA          PLX
$A8:AE23 C8          INY                    ;\
$A8:AE24 C8          INY                    ;} Y += 2
$A8:AE25 6B          RTL
}


;;; $AE26: Instruction - move head down 2px ;;;
{
$A8:AE26 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE29 FE 7E 0F    INC $0F7E,x[$7E:0F7E]
$A8:AE2C FE 7E 0F    INC $0F7E,x[$7E:0F7E]
$A8:AE2F 6B          RTL
}


;;; $AE30: Instruction - move head up 2px ;;;
{
$A8:AE30 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE33 DE 7E 0F    DEC $0F7E,x[$7E:0F7E]
$A8:AE36 DE 7E 0F    DEC $0F7E,x[$7E:0F7E]
$A8:AE39 6B          RTL
}


;;; $AE3A: Instruction - set animation active flag ;;;
{
$A8:AE3A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE3D A9 01 00    LDA #$0001
$A8:AE40 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A8:AE44 6B          RTL
}


;;; $AE45: Instruction - clear animation active flag ;;;
{
$A8:AE45 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE48 A9 00 00    LDA #$0000
$A8:AE4B 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A8:AE4F 6B          RTL
}


;;; $AE50: Instruction - move head + arm up 1px ;;;
{
$A8:AE50 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE53 DE 7E 0F    DEC $0F7E,x[$7E:0F7E]
$A8:AE56 DE BE 0F    DEC $0FBE,x[$7E:0FBE]
$A8:AE59 6B          RTL
}


;;; $AE5A: Instruction - move head + arm down 1px ;;;
{
$A8:AE5A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE5D FE 7E 0F    INC $0F7E,x[$7E:0F7E]
$A8:AE60 FE BE 0F    INC $0FBE,x[$7E:0FBE]
$A8:AE63 6B          RTL
}


;;; $AE64: Instruction - set submerged head + arm position, make arm + hand visible ;;;
{
$A8:AE64 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE67 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A8:AE6B 18          CLC
$A8:AE6C 69 18 00    ADC #$0018
$A8:AE6F 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A8:AE72 9D BE 0F    STA $0FBE,x[$7E:0FBE]
$A8:AE75 BD C6 0F    LDA $0FC6,x[$7E:0FC6]
$A8:AE78 29 FF FE    AND #$FEFF
$A8:AE7B 9D C6 0F    STA $0FC6,x[$7E:0FC6]
$A8:AE7E BD 06 10    LDA $1006,x[$7E:1006]
$A8:AE81 29 FF FE    AND #$FEFF
$A8:AE84 9D 06 10    STA $1006,x[$7E:1006]
$A8:AE87 6B          RTL
}


;;; $AE88: Instruction - reset head + arm position ;;;
{
$A8:AE88 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE8B BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A8:AE8F 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A8:AE92 9D BE 0F    STA $0FBE,x[$7E:0FBE]
$A8:AE95 6B          RTL
}


;;; $AE96: Instruction - set emerged head + arm position, make arm + hand invisible ;;;
{
$A8:AE96 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AE99 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A8:AE9D 18          CLC
$A8:AE9E 69 04 00    ADC #$0004
$A8:AEA1 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A8:AEA4 9D BE 0F    STA $0FBE,x[$7E:0FBE]
$A8:AEA7 BD C6 0F    LDA $0FC6,x[$7E:0FC6]
$A8:AEAA 09 00 01    ORA #$0100
$A8:AEAD 9D C6 0F    STA $0FC6,x[$7E:0FC6]
$A8:AEB0 BD 06 10    LDA $1006,x[$7E:1006]
$A8:AEB3 09 00 01    ORA #$0100
$A8:AEB6 9D 06 10    STA $1006,x[$7E:1006]
$A8:AEB9 6B          RTL
}


;;; $AEBA: Instruction - spawn magdollite lava enemy projectile ;;;
{
$A8:AEBA 5A          PHY
$A8:AEBB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AEBE A0 E0 E0    LDY #$E0E0             ;\
$A8:AEC1 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;} Spawn magdollite lava enemy projectile with parameter [enemy hand direction]
$A8:AEC4 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:AEC8 7A          PLY
$A8:AEC9 6B          RTL
}


;;; $AECA: Instruction - set open hand position - facing right ;;;
{
$A8:AECA AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AECD BF 24 78 7E LDA $7E7824,x[$7E:78A4];\
$A8:AED1 18          CLC                    ;|
$A8:AED2 69 08 00    ADC #$0008             ;} Enemy X position = [enemy throw X position] + 8
$A8:AED5 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A8:AED8 BF 26 78 7E LDA $7E7826,x[$7E:78A6];\
$A8:AEDC 18          CLC                    ;|
$A8:AEDD 69 FC FF    ADC #$FFFC             ;} Enemy Y position = [enemy throw Y position] - 4
$A8:AEE0 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A8:AEE3 6B          RTL
}


;;; $AEE4: Instruction - set open hand position - facing left ;;;
{
$A8:AEE4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AEE7 BF 24 78 7E LDA $7E7824,x[$7E:7A24];\
$A8:AEEB 18          CLC                    ;|
$A8:AEEC 69 F8 FF    ADC #$FFF8             ;} Enemy X position = [enemy throw X position] - 8
$A8:AEEF 9D 7A 0F    STA $0F7A,x[$7E:117A]  ;/
$A8:AEF2 BF 26 78 7E LDA $7E7826,x[$7E:7A26];\
$A8:AEF6 18          CLC                    ;|
$A8:AEF7 69 FC FF    ADC #$FFFC             ;} Enemy Y position = [enemy throw Y position] - 4
$A8:AEFA 9D 7E 0F    STA $0F7E,x[$7E:117E]  ;/
$A8:AEFD 6B          RTL
}


;;; $AEFE: Instruction - set closed hand position - facing right ;;;
{
$A8:AEFE AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AF01 BF 24 78 7E LDA $7E7824,x[$7E:78A4];\
$A8:AF05 18          CLC                    ;|
$A8:AF06 69 08 00    ADC #$0008             ;} Enemy X position = [enemy throw X position] + 8
$A8:AF09 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A8:AF0C BF 26 78 7E LDA $7E7826,x[$7E:78A6];\
$A8:AF10 18          CLC                    ;|
$A8:AF11 69 F8 FF    ADC #$FFF8             ;} Enemy Y position = [enemy throw Y position] - 8 <-- not 4?
$A8:AF14 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A8:AF17 6B          RTL
}


;;; $AF18: Instruction - set closed hand position - facing left ;;;
{
$A8:AF18 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AF1B BF 24 78 7E LDA $7E7824,x[$7E:7A24];\
$A8:AF1F 18          CLC                    ;|
$A8:AF20 69 F8 FF    ADC #$FFF8             ;} Enemy X position = [enemy throw X position] - 8
$A8:AF23 9D 7A 0F    STA $0F7A,x[$7E:117A]  ;/
$A8:AF26 BF 26 78 7E LDA $7E7826,x[$7E:7A26];\
$A8:AF2A 18          CLC                    ;|
$A8:AF2B 69 FC FF    ADC #$FFFC             ;} Enemy Y position = [enemy throw Y position] - 4
$A8:AF2E 9D 7E 0F    STA $0F7E,x[$7E:117E]  ;/
$A8:AF31 6B          RTL
}


;;; $AF32: Unused. Set hand throw position ;;;
{
$A8:AF32 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AF35 BF 24 78 7E LDA $7E7824,x
$A8:AF39 9D 7A 0F    STA $0F7A,x
$A8:AF3C BF 26 78 7E LDA $7E7826,x
$A8:AF40 9D 7E 0F    STA $0F7E,x
$A8:AF43 6B          RTL
}


;;; $AF44: Instruction - reset cooldown timer ;;;
{
$A8:AF44 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AF47 A9 00 01    LDA #$0100
$A8:AF4A 9F 08 78 7E STA $7E7808,x[$7E:7888]
$A8:AF4E 6B          RTL
}
}


;;; $AF4F: Initialisation function pointers ;;;
{
$A8:AF4F             dw AF9D, AFE2, B020
}


;;; $AF55: Magdollite arm growth table ;;;
{
; Indexed by [enemy $0FAA]. First entry is unused
$A8:AF55             dw 0000, 0010, 0020, 0030, 0040, 0050, 0060, 0070, 0080 ; Arm height threshold
$A8:AF67             dw ADDC, ADDC, ADE2, ADE8, ADEE, ADF4, ADFA, AE00, AE06 ; Instruction list pointer
$A8:AF79             dw 000C, 000C, 0014, 001C, 0024, 002C, 0034, 003C, 0044 ; Hand Y offset
}


;;; $AF8B: Initialisation AI - enemy $E83F (magdollite) ;;;
{
$A8:AF8B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AF8E BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:AF91 0A          ASL A                  ;|
$A8:AF92 AA          TAX                    ;} Execute [$AF4F + [enemy parameter 1] * 2]
$A8:AF93 FC 4F AF    JSR ($AF4F,x)[$A8:AF9D];/
$A8:AF96 20 5E B0    JSR $B05E  [$A8:B05E]  ; Set magdollite arm Y velocities
$A8:AF99 20 88 B0    JSR $B088  [$A8:B088]  ; Set up magdollite palette cycling
$A8:AF9C 6B          RTL
}


;;; $AF9D: Magdollite initialisation function - head ;;;
{
$A8:AF9D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AFA0 A9 00 00    LDA #$0000             ;\
$A8:AFA3 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy instruction list = 0
$A8:AFA6 9F 00 78 7E STA $7E7800,x[$7E:7800]; Enemy head direction = left
$A8:AFAA 9F 04 78 7E STA $7E7804,x[$7E:7804]; Enemy emerge not ready flag = 0 (no effect)
$A8:AFAE BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:AFB1 9F 06 78 7E STA $7E7806,x[$7E:7806];} Enemy Y spawn position = [enemy Y position]
$A8:AFB5 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:AFB9 10 07       BPL $07    [$AFC2]     ;} If [Samus X position] < [enemy X position]: (should be BMI >_<;)
$A8:AFBB A9 01 00    LDA #$0001             ;\
$A8:AFBE 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy head direction = right

$A8:AFC2 BF 00 78 7E LDA $7E7800,x[$7E:7800]; >_<;
$A8:AFC6 A9 9C AC    LDA #$AC9C             ;\
$A8:AFC9 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AC9C (facing left - idle)
$A8:AFCC BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$A8:AFD0 D0 06       BNE $06    [$AFD8]     ;} If [enemy head direction] = left: (should be BEQ >_<;)
$A8:AFD2 A9 3C AD    LDA #$AD3C             ;\
$A8:AFD5 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AD3C (facing right - idle)

$A8:AFD8 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:AFDB A9 1A B1    LDA #$B11A             ;\
$A8:AFDE 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B11A (idle)
$A8:AFE1 60          RTS
}


;;; $AFE2: Magdollite initialisation function - arm ;;;
{
$A8:AFE2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:AFE5 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:AFE8 9F 06 78 7E STA $7E7806,x[$7E:7846];} Enemy Y spawn position = [enemy Y position]
$A8:AFEC A9 00 00    LDA #$0000             ;\
$A8:AFEF 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy instruction list = 0
$A8:AFF2 9F 18 78 7E STA $7E7818,x[$7E:7858]; Enemy finished growing flag = 0
$A8:AFF6 A9 01 00    LDA #$0001             ;\
$A8:AFF9 9F 1A 78 7E STA $7E781A,x[$7E:785A];} Enemy not submerged flag = 1
$A8:AFFD A9 DC AD    LDA #$ADDC             ;\
$A8:B000 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy new instruction list = $ADDC
$A8:B003 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B006 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:B009 18          CLC                    ;|
$A8:B00A 69 20 00    ADC #$0020             ;} Enemy Y position += 20h
$A8:B00D 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:B010 A9 DD B1    LDA #$B1DD             ;\
$A8:B013 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $B1DD (wait until head submerged)
$A8:B016 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A8:B019 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A8:B01C 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A8:B01F 60          RTS
}


;;; $B020: Magdollite initialisation function - hand ;;;
{
$A8:B020 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B023 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A8:B026 9F 06 78 7E STA $7E7806,x[$7E:7886];} Enemy Y spawn position = [enemy Y position]
$A8:B02A BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A8:B02D 9F 22 78 7E STA $7E7822,x[$7E:78A2];} Enemy $7E:7822 = [enemy X position] (never read)
$A8:B031 A9 00 00    LDA #$0000             ;\
$A8:B034 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy instruction list = 0
$A8:B037 9F 08 78 7E STA $7E7808,x[$7E:7888]; Enemy cooldown timer = 0
$A8:B03B A9 0C AE    LDA #$AE0C             ;\
$A8:B03E 9D AE 0F    STA $0FAE,x[$7E:102E]  ;} Enemy new instruction list = $AE0C (stub)
$A8:B041 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B044 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A8:B047 18          CLC                    ;|
$A8:B048 69 20 00    ADC #$0020             ;} Enemy Y position += 20h
$A8:B04B 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A8:B04E A9 0D B3    LDA #$B30D             ;\
$A8:B051 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $B30D (idle)
$A8:B054 BD 86 0F    LDA $0F86,x[$7E:1006]  ;\
$A8:B057 09 00 01    ORA #$0100             ;} Set enemy as invisible
$A8:B05A 9D 86 0F    STA $0F86,x[$7E:1006]  ;/
$A8:B05D 60          RTS
}


;;; $B05E: Set magdollite arm Y velocities ;;;
{
$A8:B05E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B061 BD B7 0F    LDA $0FB7,x[$7E:0FB7]  ;\
$A8:B064 29 FF 00    AND #$00FF             ;|
$A8:B067 0A          ASL A                  ;|
$A8:B068 0A          ASL A                  ;} Y = [enemy parameter 2 high] * 8 (linear speed table index)
$A8:B069 0A          ASL A                  ;|
$A8:B06A A8          TAY                    ;/
$A8:B06B B9 87 81    LDA $8187,y[$A8:8357]  ;\
$A8:B06E 9F 10 78 7E STA $7E7810,x[$7E:7810];|
$A8:B072 B9 89 81    LDA $8189,y[$A8:8359]  ;} Enemy down velocity = [$8187 + [Y]].[$8187 + [Y] + 2]
$A8:B075 9F 0E 78 7E STA $7E780E,x[$7E:780E];/
$A8:B079 B9 8B 81    LDA $818B,y[$A8:835B]  ;\
$A8:B07C 9F 14 78 7E STA $7E7814,x[$7E:7814];|
$A8:B080 B9 8D 81    LDA $818D,y[$A8:835D]  ;} Enemy up velocity = [$8187 + [Y] + 4].[$8187 + [Y] + 8]
$A8:B083 9F 12 78 7E STA $7E7812,x[$7E:7812];/
$A8:B087 60          RTS
}


;;; $B088: Set up magdollite palette cycling ;;;
{
$A8:B088 A9 B2 B0    LDA #$B0B2             ;\
$A8:B08B 8D 8C 17    STA $178C  [$7E:178C]  ;|
$A8:B08E A9 A8 00    LDA #$00A8             ;} Enemy graphics drawn hook = $A8:B0B2
$A8:B091 8D 8E 17    STA $178E  [$7E:178E]  ;/
$A8:B094 BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:B097 29 00 0E    AND #$0E00             ;|
$A8:B09A 4A          LSR A                  ;|
$A8:B09B 4A          LSR A                  ;|
$A8:B09C 4A          LSR A                  ;} Enemy palette cycle enemy palette index = 100h + [enemy palette index] / 10h
$A8:B09D 4A          LSR A                  ;|
$A8:B09E 18          CLC                    ;|
$A8:B09F 69 00 01    ADC #$0100             ;|
$A8:B0A2 8D 94 17    STA $1794  [$7E:1794]  ;/
$A8:B0A5 A9 08 00    LDA #$0008             ;\
$A8:B0A8 8D 98 17    STA $1798  [$7E:1798]  ;} Enemy palette cycle timer = 8
$A8:B0AB A9 00 00    LDA #$0000             ;\
$A8:B0AE 8D 96 17    STA $1796  [$7E:1796]  ;} Enemy palette cycle colour set index = 0
$A8:B0B1 60          RTS
}


;;; $B0B2: Enemy graphics drawn hook - magdollite - periodically cycle between palettes ;;;
{
; Why is this one implemented differently to the others? >_<;
$A8:B0B2 AD 97 07    LDA $0797  [$7E:0797]  ;\
$A8:B0B5 D0 52       BNE $52    [$B109]     ;} If currently transitioning the room: return
$A8:B0B7 AE 54 0E    LDX $0E54  [$7E:0E54]  ; >_<
$A8:B0BA AD 98 17    LDA $1798  [$7E:1798]  ;\
$A8:B0BD 3A          DEC A                  ;} Decrement enemy palette cycle timer
$A8:B0BE 8D 98 17    STA $1798  [$7E:1798]  ;/
$A8:B0C1 D0 46       BNE $46    [$B109]     ; If [enemy palette cycle timer] != 0: return
$A8:B0C3 A9 08 00    LDA #$0008             ;\
$A8:B0C6 8D 98 17    STA $1798  [$7E:1798]  ;} Enemy palette cycle timer = 8
$A8:B0C9 AD 96 17    LDA $1796  [$7E:1796]  ;\
$A8:B0CC 1A          INC A                  ;} Increment enemy palette cycle colour set index
$A8:B0CD 8D 96 17    STA $1796  [$7E:1796]  ;/
$A8:B0D0 29 03 00    AND #$0003             ;\
$A8:B0D3 0A          ASL A                  ;|
$A8:B0D4 0A          ASL A                  ;|
$A8:B0D5 0A          ASL A                  ;|
$A8:B0D6 0A          ASL A                  ;|
$A8:B0D7 0A          ASL A                  ;|
$A8:B0D8 A8          TAY                    ;|
$A8:B0D9 B9 2E AC    LDA $AC2E,y[$A8:AC4E]  ;|
$A8:B0DC 85 12       STA $12    [$7E:0012]  ;|
$A8:B0DE B9 30 AC    LDA $AC30,y[$A8:AC50]  ;|
$A8:B0E1 85 14       STA $14    [$7E:0014]  ;|
$A8:B0E3 B9 32 AC    LDA $AC32,y[$A8:AC52]  ;|
$A8:B0E6 85 16       STA $16    [$7E:0016]  ;} Copy 4 colours from $AC2E + [enemy palette cycle colour set index] % 4 * 20h to enemy palette colours 9..Ch
$A8:B0E8 B9 34 AC    LDA $AC34,y[$A8:AC54]  ;|
$A8:B0EB 85 18       STA $18    [$7E:0018]  ;|
$A8:B0ED AD 94 17    LDA $1794  [$7E:1794]  ;|
$A8:B0F0 AA          TAX                    ;|
$A8:B0F1 A5 12       LDA $12    [$7E:0012]  ;|
$A8:B0F3 9F 12 C0 7E STA $7EC012,x[$7E:C1F2];|
$A8:B0F7 A5 14       LDA $14    [$7E:0014]  ;|
$A8:B0F9 9F 14 C0 7E STA $7EC014,x[$7E:C1F4];|
$A8:B0FD A5 16       LDA $16    [$7E:0016]  ;|
$A8:B0FF 9F 16 C0 7E STA $7EC016,x[$7E:C1F6];|
$A8:B103 A5 18       LDA $18    [$7E:0018]  ;|
$A8:B105 9F 18 C0 7E STA $7EC018,x[$7E:C1F8];/

$A8:B109 6B          RTL
}


;;; $B10A: Main AI - enemy $E83F (magdollite) ;;;
{
$A8:B10A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B10D BF 08 78 7E LDA $7E7808,x[$7E:7808];\
$A8:B111 3A          DEC A                  ;} Decrement enemy cooldown timer
$A8:B112 9F 08 78 7E STA $7E7808,x[$7E:7808];/
$A8:B116 FC B2 0F    JSR ($0FB2,x)[$A8:B11A]; Execute [enemy function]
$A8:B119 6B          RTL
}


;;; $B11A..DC: Head ;;;
{
;;; $B11A: Magdollite function - idle ;;;
{
$A8:B11A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B11D A9 00 00    LDA #$0000             ;\
$A8:B120 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy head direction = left
$A8:B124 A9 9C AC    LDA #$AC9C             ;\
$A8:B127 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AC9C (facing left - idle)
$A8:B12A 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:B12E 30 0D       BMI $0D    [$B13D]     ;} If [Samus X position] >= [enemy X position]:
$A8:B130 A9 3C AD    LDA #$AD3C             ;\
$A8:B133 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AD3C (facing right - idle)
$A8:B136 A9 01 00    LDA #$0001             ;\
$A8:B139 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy head direction = right

$A8:B13D 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B140 BF 88 78 7E LDA $7E7888,x[$7E:7888];\
$A8:B144 10 2E       BPL $2E    [$B174]     ;} If [enemy ([X] + 2) cooldown timer] >= 0: return
$A8:B146 A9 00 00    LDA #$0000             ;\
$A8:B149 9F 88 78 7E STA $7E7888,x[$7E:7888];} Enemy ([X] + 2) cooldown timer = 0
$A8:B14D BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A8:B150 29 FF 00    AND #$00FF             ;|
$A8:B153 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;} If Samus is not within [enemy parameter 2] pixel columns of enemy: return
$A8:B157 F0 1B       BEQ $1B    [$B174]     ;/
$A8:B159 A9 DE AC    LDA #$ACDE             ;\
$A8:B15C 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $ACDE (facing left - submerge into lava)
$A8:B15F BF 00 78 7E LDA $7E7800,x[$7E:7800];\
$A8:B163 F0 06       BEQ $06    [$B16B]     ;} If [enemy head direction] != left:
$A8:B165 A9 7E AD    LDA #$AD7E             ;\
$A8:B168 9D AE 0F    STA $0FAE,x[$7E:112E]  ;} Enemy new instruction list = $AD7E (facing right - submerge into lava)

$A8:B16B 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B16E A9 75 B1    LDA #$B175             ;\
$A8:B171 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B175 (wait until submerged)

$A8:B174 60          RTS
}


;;; $B175: Magdollite function - wait until submerged ;;;
{
$A8:B175 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B178 BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A8:B17C D0 14       BNE $14    [$B192]     ;} If [enemy animation active flag] = 0:
$A8:B17E A9 01 00    LDA #$0001             ;\
$A8:B181 9F 04 78 7E STA $7E7804,x[$7E:7804];} Enemy emerge not ready flag = 1
$A8:B185 A9 00 00    LDA #$0000             ;\
$A8:B188 9F 5A 78 7E STA $7E785A,x[$7E:785A];} Enemy ([X] + 1) not submerged flag = 0
$A8:B18C A9 93 B1    LDA #$B193             ;\
$A8:B18F 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B193 (emerge when ready)

$A8:B192 60          RTS
}


;;; $B193: Magdollite function - emerge when ready ;;;
{
$A8:B193 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B196 BF 04 78 7E LDA $7E7804,x[$7E:7804];\
$A8:B19A D0 1B       BNE $1B    [$B1B7]     ;} If [enemy emerge not ready flag] != 0: return
$A8:B19C A9 0C AD    LDA #$AD0C             ;\
$A8:B19F 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AD0C (facing left - emerge from lava)
$A8:B1A2 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:B1A6 30 06       BMI $06    [$B1AE]     ;} If [Samus X position] >= [enemy X position]:
$A8:B1A8 A9 AC AD    LDA #$ADAC             ;\
$A8:B1AB 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $ADAC (facing right - emerge from lava)

$A8:B1AE 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B1B1 A9 B8 B1    LDA #$B1B8             ;\
$A8:B1B4 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B1B8 (wait until emerged)

$A8:B1B7 60          RTS
}


;;; $B1B8: Magdollite function - wait until emerged ;;;
{
$A8:B1B8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B1BB BF 02 78 7E LDA $7E7802,x[$7E:7802];\
$A8:B1BF D0 1B       BNE $1B    [$B1DC]     ;} If [enemy animation active flag] != 0: return
$A8:B1C1 A9 9C AC    LDA #$AC9C             ;\
$A8:B1C4 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AC9C (facing left - idle)
$A8:B1C7 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:B1CB 30 06       BMI $06    [$B1D3]     ;} If [Samus X position] >= [enemy X position]:
$A8:B1CD A9 3C AD    LDA #$AD3C             ;\
$A8:B1D0 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy new instruction list = $AD3C (facing right - idle)

$A8:B1D3 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B1D6 A9 1A B1    LDA #$B11A             ;\
$A8:B1D9 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = $B11A (idle)

$A8:B1DC 60          RTS
}
}


;;; $B1DD..B30C: Arm ;;;
{
;;; $B1DD: Magdollite function - wait until head submerged ;;;
{
$A8:B1DD AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B1E0 BF 1A 78 7E LDA $7E781A,x[$7E:785A];\
$A8:B1E4 D0 1D       BNE $1D    [$B203]     ;} If [enemy not submerged flag] = 0:
$A8:B1E6 A9 04 B2    LDA #$B204             ;\
$A8:B1E9 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $B204 (growing arm)
$A8:B1EC A9 00 00    LDA #$0000             ;\
$A8:B1EF 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy arm height = 0
$A8:B1F2 9F 1A 78 7E STA $7E781A,x[$7E:785A]; >_<;
$A8:B1F6 A9 02 00    LDA #$0002             ;\
$A8:B1F9 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy growth table index = 2
$A8:B1FC BF 06 78 7E LDA $7E7806,x[$7E:7846];\
$A8:B200 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy Y spawn position]

$A8:B203 60          RTS
}


;;; $B204: Magdollite function - growing arm ;;;
{
$A8:B204 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B207 18          CLC                    ;\
$A8:B208 BD 80 0F    LDA $0F80,x[$7E:0FC0]  ;|
$A8:B20B 7F D2 77 7E ADC $7E77D2,x[$7E:7812];|
$A8:B20F 9D 80 0F    STA $0F80,x[$7E:0FC0]  ;|
$A8:B212 90 03       BCC $03    [$B217]     ;|
$A8:B214 FE B0 0F    INC $0FB0,x[$7E:0FF0]  ;|
                                            ;} Enemy Y position += [enemy ([X] - 1) up velocity]
$A8:B217 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;} Enemy arm height += (new enemy Y position) - (old enemy Y position)
$A8:B21A 7F D4 77 7E ADC $7E77D4,x[$7E:7814];|
$A8:B21E 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;|
$A8:B221 18          CLC                    ;|
$A8:B222 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;|
$A8:B225 7F D4 77 7E ADC $7E77D4,x[$7E:7814];|
$A8:B229 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;/
$A8:B22C 20 30 B2    JSR $B230  [$A8:B230]  ; Grow arm
$A8:B22F 60          RTS
}


;;; $B230: Grow arm ;;;
{
$A8:B230 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A8:B233 49 FF FF    EOR #$FFFF             ;|
$A8:B236 1A          INC A                  ;} If -[enemy arm height] < 6Ch: (whoops, we forgot to load Y before taking this branch >_<;)
$A8:B237 C9 6C 00    CMP #$006C             ;|
$A8:B23A 10 1D       BPL $1D    [$B259]     ;/
$A8:B23C BC AA 0F    LDY $0FAA,x[$7E:0FEA]  ; Y = [enemy growth table index]
$A8:B23F BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:B242 38          SEC                    ;|
$A8:B243 F9 79 AF    SBC $AF79,y[$A8:AF7B]  ;} If [enemy Y position] - [$AF79 + [Y]] >= [Samus Y position]:
$A8:B246 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;|
$A8:B249 30 0E       BMI $0E    [$B259]     ;/
$A8:B24B BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A8:B24E 49 FF FF    EOR #$FFFF             ;|
$A8:B251 1A          INC A                  ;} If -[enemy arm height] >= [$AF55 + [Y]]: go to BRANCH_NEXT_GROWTH_LEVEL
$A8:B252 D9 55 AF    CMP $AF55,y[$A8:AF57]  ;|
$A8:B255 10 1D       BPL $1D    [$B274]     ;/
$A8:B257 80 37       BRA $37    [$B290]     ; Return

$A8:B259 A9 91 B2    LDA #$B291             ;\
$A8:B25C 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = RTS
$A8:B25F A9 01 00    LDA #$0001             ;\
$A8:B262 9F 18 78 7E STA $7E7818,x[$7E:7858];} Enemy finished growing flag = 1
$A8:B266 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A8:B269 49 FF FF    EOR #$FFFF             ;|
$A8:B26C 1A          INC A                  ;} If -[enemy arm height] >= [$AF55 + [Y]]: go to BRANCH_NEXT_GROWTH_LEVEL
$A8:B26D D9 55 AF    CMP $AF55,y[$A8:AF57]  ;|
$A8:B270 10 02       BPL $02    [$B274]     ;/
$A8:B272 80 1C       BRA $1C    [$B290]     ; Return

; BRANCH_NEXT_GROWTH_LEVEL
$A8:B274 FE AA 0F    INC $0FAA,x[$7E:0FEA]  ;\
$A8:B277 FE AA 0F    INC $0FAA,x[$7E:0FEA]  ;} Enemy growth table index += 2
$A8:B27A BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:B27D 18          CLC                    ;|
$A8:B27E 69 08 00    ADC #$0008             ;} Enemy Y position += 8
$A8:B281 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:B284 BC AA 0F    LDY $0FAA,x[$7E:0FEA]  ;\
$A8:B287 B9 67 AF    LDA $AF67,y[$A8:AF6B]  ;} Enemy new instruction list = [$AF67 + [enemy growth table index]]
$A8:B28A 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/
$A8:B28D 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list

$A8:B290 60          RTS
}


;;; $B291: RTS ;;;
{
$A8:B291 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B294 60          RTS
}


;;; $B295: Magdollite function - shrinking arm ;;;
{
$A8:B295 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B298 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:B29B 18          CLC                    ;|
$A8:B29C 7F D0 77 7E ADC $7E77D0,x[$7E:7810];|
$A8:B2A0 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;|
$A8:B2A3 BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;|
$A8:B2A6 18          CLC                    ;|
$A8:B2A7 7F D0 77 7E ADC $7E77D0,x[$7E:7810];|
$A8:B2AB 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy Y position += [enemy ([X] - 1) down velocity]
$A8:B2AE BD 80 0F    LDA $0F80,x[$7E:0FC0]  ;} Enemy arm height += (new enemy Y position) - (old enemy Y position)
$A8:B2B1 18          CLC                    ;|
$A8:B2B2 7F CE 77 7E ADC $7E77CE,x[$7E:780E];|
$A8:B2B6 90 06       BCC $06    [$B2BE]     ;|
$A8:B2B8 FE 7E 0F    INC $0F7E,x[$7E:0FBE]  ;|
$A8:B2BB FE B0 0F    INC $0FB0,x[$7E:0FF0]  ;|
                                            ;|
$A8:B2BE 9D 80 0F    STA $0F80,x[$7E:0FC0]  ;/
$A8:B2C1 20 C5 B2    JSR $B2C5  [$A8:B2C5]  ; Shrink arm
$A8:B2C4 60          RTS
}


;;; $B2C5: Shrink arm ;;;
{
$A8:B2C5 BC AA 0F    LDY $0FAA,x[$7E:0FEA]  ;\
$A8:B2C8 88          DEY                    ;} Y = [enemy growth table index] - 2
$A8:B2C9 88          DEY                    ;/
$A8:B2CA BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A8:B2CD 10 29       BPL $29    [$B2F8]     ;} If [enemy arm height] >= 0: go to BRANCH_FINISHED
$A8:B2CF 49 FF FF    EOR #$FFFF             ;\
$A8:B2D2 1A          INC A                  ;|
$A8:B2D3 D9 55 AF    CMP $AF55,y[$A8:AF57]  ;} If -[enemy arm height] >= [$AF55 + [Y]]:
$A8:B2D6 30 02       BMI $02    [$B2DA]     ;/
$A8:B2D8 80 32       BRA $32    [$B30C]     ; Return

$A8:B2DA DE AA 0F    DEC $0FAA,x[$7E:0FEA]  ;\
$A8:B2DD DE AA 0F    DEC $0FAA,x[$7E:0FEA]  ;} Enemy growth table index = [Y]
$A8:B2E0 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:B2E3 38          SEC                    ;|
$A8:B2E4 E9 08 00    SBC #$0008             ;} Enemy Y position -= 8
$A8:B2E7 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:B2EA BC AA 0F    LDY $0FAA,x[$7E:0FEA]  ;\
$A8:B2ED B9 67 AF    LDA $AF67,y[$A8:AF69]  ;} Enemy new instruction list = [$AF67 + [Y]]
$A8:B2F0 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/
$A8:B2F3 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B2F6 80 14       BRA $14    [$B30C]     ; Return

; BRANCH_FINISHED
$A8:B2F8 A9 01 00    LDA #$0001             ;\
$A8:B2FB 9F 1A 78 7E STA $7E781A,x[$7E:785A];} Enemy not submerged flag = 1
$A8:B2FF A9 00 00    LDA #$0000             ;\
$A8:B302 9F C4 77 7E STA $7E77C4,x[$7E:7804];} Enemy ([X] - 1) emerge not ready flag = 0
$A8:B306 A9 DD B1    LDA #$B1DD             ;\
$A8:B309 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $B1DD (wait until head submerged)

$A8:B30C 60          RTS
}
}


;;; $B30D..E4: Hand ;;;
{
;;; $B30D: Magdollite function - idle ;;;
{
$A8:B30D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B310 BD 32 0F    LDA $0F32,x[$7E:0FB2]  ;\
$A8:B313 C9 75 B1    CMP #$B175             ;} If [enemy ([X] - 2) function] = $B175 (wait until submerged):
$A8:B316 D0 06       BNE $06    [$B31E]     ;/
$A8:B318 A9 56 B3    LDA #$B356             ;\
$A8:B31B 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $B356 (wait until finished growing and throw lava)

$A8:B31E 60          RTS
}


;;; $B31F: Magdollite function - wait until finished throwing lava and shrink arm ;;;
{
$A8:B31F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B322 BF 02 78 7E LDA $7E7802,x[$7E:7882];\
$A8:B326 D0 2A       BNE $2A    [$B352]     ;} If [enemy animation active flag] = 0:
$A8:B328 A9 0C AE    LDA #$AE0C             ;\
$A8:B32B 9D AE 0F    STA $0FAE,x[$7E:102E]  ;} Enemy new instruction list = $AE0C (stub)
$A8:B32E 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B331 A9 95 B2    LDA #$B295             ;\
$A8:B334 9D 72 0F    STA $0F72,x[$7E:0FF2]  ;} Enemy ([X] - 1) function = $B295 (shrinking arm)
$A8:B337 A9 A7 B3    LDA #$B3A7             ;\
$A8:B33A 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $B3A7 (move with shrinking arm)
$A8:B33D A9 00 00    LDA #$0000             ;\
$A8:B340 9F D8 77 7E STA $7E77D8,x[$7E:7858];} Enemy ([X] - 1) finished growing flag = 0
$A8:B344 BF 24 78 7E LDA $7E7824,x[$7E:78A4];\
$A8:B348 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [enemy throw X position]
$A8:B34B BF 26 78 7E LDA $7E7826,x[$7E:78A6];\
$A8:B34F 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;} Enemy Y position = [enemy throw Y position]

$A8:B352 20 CB B3    JSR $B3CB  [$A8:B3CB]  ; Update magdollite head Y radius
$A8:B355 60          RTS
}


;;; $B356: Magdollite function - wait until finished growing and throw lava ;;;
{
$A8:B356 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B359 BF D8 77 7E LDA $7E77D8,x[$7E:7858];\
$A8:B35D F0 37       BEQ $37    [$B396]     ;} If [enemy ([X] - 1) finished growing flag] = 0: go to BRANCH_NOT_READY
$A8:B35F A9 B0 AC    LDA #$ACB0             ;\
$A8:B362 9D AE 0F    STA $0FAE,x[$7E:102E]  ;} Enemy new instruction list = $ACB0 (facing left - throwing lava)
$A8:B365 A9 00 00    LDA #$0000             ;\
$A8:B368 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy hand direction = left
$A8:B36B 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:B36F 30 0C       BMI $0C    [$B37D]     ;} If [Samus X position] >= [enemy X position]:
$A8:B371 A9 50 AD    LDA #$AD50             ;\
$A8:B374 9D AE 0F    STA $0FAE,x[$7E:102E]  ;} Enemy new instruction list = $AD50 (facing right - throwing lava)
$A8:B377 A9 01 00    LDA #$0001             ;\
$A8:B37A 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy hand direction = right

$A8:B37D 20 E5 B3    JSR $B3E5  [$A8:B3E5]  ; Set magdollite instruction list
$A8:B380 A9 1F B3    LDA #$B31F             ;\
$A8:B383 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $B31F (wait until finished throwing lava and shrink arm)
$A8:B386 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;\
$A8:B389 9F 24 78 7E STA $7E7824,x[$7E:78A4];} Enemy throw X position = [enemy X position]
$A8:B38D BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;\
$A8:B390 9F 26 78 7E STA $7E7826,x[$7E:78A6];} Enemy throw Y position = [enemy Y position]
$A8:B394 80 0D       BRA $0D    [$B3A3]     ; Go to BRANCH_MERGE

; BRANCH_NOT_READY
$A8:B396 BC 6A 0F    LDY $0F6A,x[$7E:0FEA]  ;\
$A8:B399 BD 3E 0F    LDA $0F3E,x[$7E:0FBE]  ;|
$A8:B39C 38          SEC                    ;} Enemy Y position = [enemy ([X] - 1) Y position] - [$AF79 + [Y]]
$A8:B39D F9 79 AF    SBC $AF79,y[$A8:AF79]  ;|
$A8:B3A0 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/

; BRANCH_MERGE
$A8:B3A3 20 CB B3    JSR $B3CB  [$A8:B3CB]  ; Update magdollite head Y radius
$A8:B3A6 60          RTS
}


;;; $B3A7: Magdollite function - move with shrinking arm ;;;
{
$A8:B3A7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B3AA BD 32 0F    LDA $0F32,x[$7E:0FB2]  ;\
$A8:B3AD C9 1A B1    CMP #$B11A             ;} If [enemy ([X] - 2) function] = $B11A (idle):
$A8:B3B0 D0 08       BNE $08    [$B3BA]     ;/
$A8:B3B2 A9 0D B3    LDA #$B30D             ;\
$A8:B3B5 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy function = $B30D (idle)
$A8:B3B8 80 0D       BRA $0D    [$B3C7]

$A8:B3BA BC 6A 0F    LDY $0F6A,x[$7E:0FEA]  ;\ Else ([enemy ([X] - 2) function] != $B11A (idle)):
$A8:B3BD BD 3E 0F    LDA $0F3E,x[$7E:0FBE]  ;|
$A8:B3C0 38          SEC                    ;} Enemy Y position = [enemy ([X] - 1) Y position] - [$AF79 + [Y]]
$A8:B3C1 F9 79 AF    SBC $AF79,y[$A8:AF7B]  ;|
$A8:B3C4 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/

$A8:B3C7 20 CB B3    JSR $B3CB  [$A8:B3CB]  ; Update magdollite head Y radius
$A8:B3CA 60          RTS
}


;;; $B3CB: Update magdollite head Y radius ;;;
{
$A8:B3CB BD FE 0E    LDA $0EFE,x[$7E:0F7E]  ;\
$A8:B3CE 38          SEC                    ;|
$A8:B3CF FD 7E 0F    SBC $0F7E,x[$7E:0FFE]  ;|
$A8:B3D2 18          CLC                    ;|
$A8:B3D3 69 02 00    ADC #$0002             ;|
$A8:B3D6 9D 04 0F    STA $0F04,x[$7E:0F84]  ;} Enemy ([X] - 2) Y radius = max(8, [enemy ([X] - 2) Y position] - [enemy Y position] + 2)
$A8:B3D9 C9 08 00    CMP #$0008             ;|
$A8:B3DC 10 06       BPL $06    [$B3E4]     ;|
$A8:B3DE A9 08 00    LDA #$0008             ;|
$A8:B3E1 9D 04 0F    STA $0F04,x[$7E:0F84]  ;/

$A8:B3E4 60          RTS
}
}


;;; $B3E5: Set magdollite instruction list ;;;
{
$A8:B3E5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B3E8 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:B3EB DD AC 0F    CMP $0FAC,x[$7E:0FAC]  ;} If [enemy instruction list] != [enemy new instruction list]:
$A8:B3EE F0 0F       BEQ $0F    [$B3FF]     ;/
$A8:B3F0 9D 92 0F    STA $0F92,x[$7E:0F92]  ; Enemy instruction list pointer = [enemy new instruction list]
$A8:B3F3 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ; Enemy instruction list = [enemy new instruction list]
$A8:B3F6 A9 01 00    LDA #$0001             ;\
$A8:B3F9 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:B3FC 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0

$A8:B3FF 60          RTS
}


;;; $B400: Power bomb reaction - enemy $E83F (magdollite) ;;;
{
$A8:B400 22 37 80 A8 JSL $A88037[$A8:8037]
$A8:B404 80 0A       BRA $0A    [$B410]
}


;;; $B406: Enemy touch - enemy $E83F (magdollite) ;;;
{
$A8:B406 22 23 80 A8 JSL $A88023[$A8:8023]  ; Normal enemy touch AI
$A8:B40A 80 04       BRA $04    [$B410]     ; Go to magdollite shared contact reaction
}


;;; $B40C: Enemy shot - enemy $E83F (magdollite) ;;;
{
$A8:B40C 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
}


;;; $B410: Magdollite shared contact reaction ;;;
{
$A8:B410 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B413 BD 8C 0F    LDA $0F8C,x[$7E:104C]  ;\
$A8:B416 D0 12       BNE $12    [$B42A]     ;} If [enemy health] = 0:
$A8:B418 BD C6 0F    LDA $0FC6,x            ;\
$A8:B41B 09 00 02    ORA #$0200             ;} Flag enemy ([X] + 1) for deletion
$A8:B41E 9D C6 0F    STA $0FC6,x            ;/
$A8:B421 BD 06 10    LDA $1006,x            ;\
$A8:B424 09 00 02    ORA #$0200             ;} Flag enemy ([X] + 2) for deletion
$A8:B427 9D 06 10    STA $1006,x            ;/

$A8:B42A BD 9E 0F    LDA $0F9E,x[$7E:105E]  ;\
$A8:B42D F0 18       BEQ $18    [$B447]     ;} If [enemy frozen timer] != 0:
$A8:B42F 9D DE 0F    STA $0FDE,x            ; Enemy ([X] + 1) frozen timer = [enemy frozen timer]
$A8:B432 9D 1E 10    STA $101E,x            ; Enemy ([X] + 2) frozen timer = [enemy frozen timer]
$A8:B435 BD CA 0F    LDA $0FCA,x            ;\
$A8:B438 09 04 00    ORA #$0004             ;} Set enemy ([X] + 1) frozen AI
$A8:B43B 9D CA 0F    STA $0FCA,x            ;/
$A8:B43E BD 0A 10    LDA $100A,x            ;\
$A8:B441 09 04 00    ORA #$0004             ;} Set enemy ([X] + 2) frozen AI
$A8:B444 9D 0A 10    STA $100A,x            ;/

$A8:B447 6B          RTL
}


;;; $B448: Magdollite spritemaps ;;;
{
; Head - facing left
$A8:B448             dx 0003, 0004,FF,2123, 0004,F7,2122, 81F4,F7,210A
$A8:B459             dx 0003, 0004,00,2123, 0004,F8,2122, 81F4,F8,210A
$A8:B46A             dx 0003, 0004,01,2123, 0004,F9,2122, 81F4,F9,210A

; Hand - facing left
$A8:B47B             dx 0003, 0000,04,2121, 01F8,04,2120, 81F8,F4,2108
$A8:B48C             dx 0003, 01FD,04,2121, 01F5,04,2120, 81F9,F5,2108
$A8:B49D             dx 0002, 8000,FC,2106, 81F0,F9,2104
$A8:B4A9             dx 0002, 8000,F8,2102, 81F0,F8,2100

; Hand
$A8:B4B5             dx 0002, 0000,FC,2125, 01F8,FC,2124

; Head - facing left
$A8:B4C1             dx 0001, 81F8,F8,210E
$A8:B4C8             dx 0001, 81F8,F8,210C ; Unused
$A8:B4CF             dx 0003, 0004,FC,2128, 01FC,FC,2127, 01F4,FC,2126
$A8:B4E0             dx 0003, 0004,FC,212B, 01FC,FC,212A, 01F4,FC,2129

; Head - facing right
$A8:B4F1             dx 0003, 01F4,FF,6123, 01F4,F7,6122, 81FC,F7,610A
$A8:B502             dx 0003, 01F4,00,6123, 01F4,F8,6122, 81FC,F8,610A
$A8:B513             dx 0003, 01F4,01,6123, 01F4,F9,6122, 81FC,F9,610A

; Hand - facing right
$A8:B524             dx 0003, 01F8,04,6121, 0000,04,6120, 81F8,F4,6108
$A8:B535             dx 0003, 01FB,04,6121, 0003,04,6120, 81F7,F5,6108
$A8:B546             dx 0002, 81F0,FC,6106, 8000,F9,6104
$A8:B552             dx 0002, 81F0,F8,6102, 8000,F8,6100

; Hand
$A8:B55E             dx 0002, 01F8,FC,6125, 0000,FC,6124 ; Unused

; Head - facing right
$A8:B56A             dx 0001, 81F8,F8,610E
$A8:B571             dx 0001, 81F8,F8,610C ; Unused
$A8:B578             dx 0003, 01F4,FC,6128, 01FC,FC,6127, 0004,FC,6126
$A8:B589             dx 0003, 01F4,FC,612B, 01FC,FC,612A, 0004,FC,6129

; Arm
$A8:B59A             dx 0001, 81F8,F8,210C
$A8:B5A1             dx 0002, 81F8,00,210C, 81F8,F0,210C
$A8:B5AD             dx 0003, 81F8,08,210C, 81F8,E8,210C, 81F8,F8,210C
$A8:B5BE             dx 0004, 81F8,10,210C, 81F8,00,210C, 81F8,F0,210C, 81F8,E0,210C
$A8:B5D4             dx 0005, 81F8,18,210C, 81F8,08,210C, 81F8,D8,210C, 81F8,F8,210C, 81F8,E8,210C
$A8:B5EF             dx 0006, 81F8,10,210C, 81F8,20,210C, 81F8,00,210C, 81F8,F0,210C, 81F8,E0,210C, 81F8,D0,210C
$A8:B60F             dx 0007, 81F8,28,210C, 81F8,18,210C, 81F8,08,210C, 81F8,F8,210C, 81F8,E8,210C, 81F8,D8,210C, 81F8,C8,210C
$A8:B634             dx 0008, 81F8,30,210C, 81F8,00,210C, 81F8,20,210C, 81F8,10,210C, 81F8,F0,210C, 81F8,E0,210C, 81F8,D0,210C, 81F8,C0,210C
}
}


;;; $B65E..C142: Beetom ;;;
{
;;; $B65E: Palette - enemy $E87F (beetom) ;;;
{
$A8:B65E             dw 3800, 57FF, 42F7, 158C, 00A5, 4F5A, 36B5, 2610, 1DCE, 1CDF, 4FE0, 3B20, 2A20, 1097, 6BDF, 042E
}


;;; $B67E: Unused. Beetom eye colours ;;;
{
; Colours Ah..Ch
$A8:B67E             dw 4FE0, 3B20, 2A20,
                        3BE0, 2680, 1580,
                        2740, 11E0, 00E0,
                        12A0, 0140, 0040
}


;;; $B696..B74D: Instruction lists ;;;
{
;;; $B696: Instruction list - crawling - facing left ;;;
{
$A8:B696             dw 817D        ; Disable off-screen processing
$A8:B698             dw 000A,BED3,
                        000A,BEEE,
                        000A,BF09,
                        000A,BEEE,
                        80ED,B698   ; Go to $B698
}


;;; $B6AC: Instruction list - hop - facing left ;;;
{
$A8:B6AC             dw 8173,       ; Enable off-screen processing
                        0004,BF24,
                        0008,BF3F,
                        0004,BF24,
                        0001,BED3,
                        812F        ; Sleep
}


;;; $B6C0: Unused. Instruction list - small hop - facing left ;;;
{
$A8:B6C0             dw 8173,       ; Enable off-screen processing
                        0004,BF24,
                        0001,BED3,
                        812F        ; Sleep
}


;;; $B6CC: Instruction list - draining Samus - facing left ;;;
{
$A8:B6CC             dw 0005,BF5A,
                        0005,BF75,
                        0005,BF90,
                        0030,BF75,
                        B75E        ; NOP
$A8:B6DE             dw 0005,BFAB,
                        0005,BFCB,
                        0005,BFEB,
                        0005,BFCB,
                        80ED,B6DE   ; Go to $B6DE
}


;;; $B6F2: Instruction list - crawling - facing right ;;;
{
$A8:B6F2             dw 817D        ; Disable off-screen processing
$A8:B6F4             dw 000A,C00B,
                        000A,C026,
                        000A,C041,
                        000A,C026,
                        80ED,B6F4   ; Go to $B6F4
}


;;; $B708: Instruction list - hop - facing right ;;;
{
$A8:B708             dw 8173,       ; Enable off-screen processing
                        0004,C05C,
                        0008,C077,
                        0004,C05C,
                        0001,C00B,
                        812F        ; Sleep
}


;;; $B71C: Unused. Instruction list - small hop - facing right ;;;
{
$A8:B71C             dw 8173,       ; Enable off-screen processing
                        0004,C05C,
                        0001,C00B,
                        812F        ; Sleep
}


;;; $B728: Instruction list - draining Samus - facing right ;;;
{
$A8:B728             dw 0005,C092,
                        0005,C0AD,
                        0005,C0C8,
                        0030,C0AD,
                        B75E        ; NOP
$A8:B73A             dw 0005,C0E3,
                        0005,C103,
                        0005,C123,
                        0005,C103,
                        80ED,B73A   ; Go to $B73A
}
}


;;; $B74E: Samus not in proximity beetom function pointers ;;;
{
;                        _________ Facing left
;                       |      ___ Facing right
;                       |     |
$A8:B74E             dw B84F, B84F,
                        B887, B8ED,
                        B887, B8A9,
                        B8CB, B8ED
}


;;; $B75E: Instruction - nothing ;;;
{
$A8:B75E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B761 6B          RTL
}


;;; $B762: Set beetom instruction list ;;;
{
$A8:B762 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B765 BF 00 78 7E LDA $7E7800,x[$7E:7940];\
$A8:B769 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = [enemy instruction list]
$A8:B76C A9 01 00    LDA #$0001             ;\
$A8:B76F 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:B772 9E 90 0F    STZ $0F90,x[$7E:10D0]  ; Enemy timer = 0
$A8:B775 60          RTS
}


;;; $B776: Initialisation AI - enemy $E87F (beetom) ;;;
{
$A8:B776 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B779 A9 00 00    LDA #$0000
$A8:B77C 9D AE 0F    STA $0FAE,x[$7E:10EE]
$A8:B77F 9D AC 0F    STA $0FAC,x[$7E:10EC]
$A8:B782 9F 0A 78 7E STA $7E780A,x[$7E:794A]
$A8:B786 9F 10 78 7E STA $7E7810,x[$7E:7950]; Enemy attached to Samus flag = 0
$A8:B78A 9D A8 0F    STA $0FA8,x[$7E:10E8]
$A8:B78D A9 40 00    LDA #$0040             ;\
$A8:B790 9D B0 0F    STA $0FB0,x[$7E:10F0]  ;} Enemy button counter = 40h
$A8:B793 A5 8B       LDA $8B    [$7E:008B]  ;\
$A8:B795 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;} Enemy previous controller 1 input = [controller 1 input]
$A8:B798 A9 17 00    LDA #$0017             ;\
$A8:B79B 8D E5 05    STA $05E5  [$7E:05E5]  ;} Random number = 17h
$A8:B79E A9 00 30    LDA #$3000             ;\
$A8:B7A1 85 16       STA $16    [$7E:0016]  ;} $16 = 30.00h (target hop height)
$A8:B7A3 A9 04 00    LDA #$0004             ;\
$A8:B7A6 85 18       STA $18    [$7E:0018]  ;} $18 = 4 (Y acceleration scalar)
$A8:B7A8 20 EF B7    JSR $B7EF  [$A8:B7EF]  ; Calculate initial hop speed
$A8:B7AB 9F 04 78 7E STA $7E7804,x[$7E:7944]; Enemy initial short leap Y speed table index = [A]
$A8:B7AF A9 00 40    LDA #$4000             ;\
$A8:B7B2 85 16       STA $16    [$7E:0016]  ;} $16 = 40.00h (target hop height)
$A8:B7B4 A9 05 00    LDA #$0005             ;\
$A8:B7B7 85 18       STA $18    [$7E:0018]  ;} $18 = 5 (Y acceleration scalar)
$A8:B7B9 20 EF B7    JSR $B7EF  [$A8:B7EF]  ; Calculate initial hop speed
$A8:B7BC 9F 06 78 7E STA $7E7806,x[$7E:7946]; Enemy initial long leap Y speed table index = [A]
$A8:B7C0 A9 00 30    LDA #$3000             ;\
$A8:B7C3 85 16       STA $16    [$7E:0016]  ;} $16 = 30.00h (target hop height)
$A8:B7C5 A9 03 00    LDA #$0003             ;\
$A8:B7C8 85 18       STA $18    [$7E:0018]  ;} $18 = 3 (Y acceleration scalar)
$A8:B7CA 20 EF B7    JSR $B7EF  [$A8:B7EF]  ; Calculate initial hop speed
$A8:B7CD 9F 08 78 7E STA $7E7808,x[$7E:7948]; Enemy initial lunge Y speed table index = [A]
$A8:B7D1 A9 F2 B6    LDA #$B6F2             ;\
$A8:B7D4 9F 00 78 7E STA $7E7800,x[$7E:7940];} Enemy instruction list = $B6F2 (crawling - facing right)
$A8:B7D8 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:B7DC 10 07       BPL $07    [$B7E5]     ;} If [Samus X position] < [enemy X position]:
$A8:B7DE A9 96 B6    LDA #$B696             ;\
$A8:B7E1 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B696 (crawling - facing left)

$A8:B7E5 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B7E8 A9 14 B8    LDA #$B814             ;\
$A8:B7EB 9D AC 0F    STA $0FAC,x[$7E:10EC]  ;} Enemy function = $B814 (decide action)
$A8:B7EE 6B          RTL
}


;;; $B7EF: Calculate initial hop speed ;;;
{
;; Parameters:
;;     $16: Target hop height. Unit 1/100h pixels
;;     $18: Y acceleration scalar
;; Returns:
;;     A: Initial Y speed table index

$A8:B7EF 64 12       STZ $12    [$7E:0012]  ; $12 = 0 (Y speed table index)
$A8:B7F1 64 14       STZ $14    [$7E:0014]  ; $14 = 0 (Y distance accumulator)

; LOOP
$A8:B7F3 A5 12       LDA $12    [$7E:0012]  ;\
$A8:B7F5 18          CLC                    ;|
$A8:B7F6 65 18       ADC $18    [$7E:0018]  ;} $12 += [$18]
$A8:B7F8 85 12       STA $12    [$7E:0012]  ;/
$A8:B7FA 0A          ASL A                  ;\
$A8:B7FB 0A          ASL A                  ;|
$A8:B7FC 0A          ASL A                  ;} Y = [$12] * 8 (quadratic speed table index)
$A8:B7FD A8          TAY                    ;/
$A8:B7FE A5 14       LDA $14    [$7E:0014]  ;\
$A8:B800 18          CLC                    ;|
$A8:B801 79 90 83    ADC $8390,y[$A8:83B0]  ;} $14 += floor([$838F + [Y] + 2].[$838F + [Y]] * 100h)
$A8:B804 85 14       STA $14    [$7E:0014]  ;/
$A8:B806 C5 16       CMP $16    [$7E:0016]  ;\
$A8:B808 30 E9       BMI $E9    [$B7F3]     ;} If [$14] < [$16]: go to LOOP
$A8:B80A A5 12       LDA $12    [$7E:0012]  ; A = [$12]
$A8:B80C 60          RTS
}


;;; $B80D: Main AI - enemy $E87F (beetom) ;;;
{
$A8:B80D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B810 FC AC 0F    JSR ($0FAC,x)[$A8:B814]; Execute [enemy function]
$A8:B813 6B          RTL
}


;;; $B814..BE2D: Beetom functions ;;;
{
;;; $B814: Beetom function - decide action ;;;
{
$A8:B814 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B817 A9 60 00    LDA #$0060             ;\
$A8:B81A 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;} If Samus is within 60h pixel columns of enemy:
$A8:B81E F0 08       BEQ $08    [$B828]     ;/
$A8:B820 A9 0F B9    LDA #$B90F             ;\
$A8:B823 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B90F (Samus in proximity)
$A8:B826 80 06       BRA $06    [$B82E]     ; Return

$A8:B828 A9 2F B8    LDA #$B82F             ;\
$A8:B82B 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B82F (Samus not in proximity)

$A8:B82E 60          RTS
}


;;; $B82F: Beetom function - decide action - Samus not in proximity ;;;
{
$A8:B82F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B832 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A8:B836 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A8:B839 29 07 00    AND #$0007             ;|
$A8:B83C 0A          ASL A                  ;|
$A8:B83D A8          TAY                    ;} Enemy function = [$B74E + [random number] % 8 * 2]
$A8:B83E B9 4E B7    LDA $B74E,y[$A8:B75A]  ;|
$A8:B841 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;/
$A8:B844 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A8:B847 29 01 00    AND #$0001             ;} Enemy direction = [random number] % 2
$A8:B84A 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:B84E 60          RTS
}


;;; $B84F: Beetom function - start idling ;;;
{
$A8:B84F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B852 A9 20 00    LDA #$0020             ;\
$A8:B855 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy function timer = 20h
$A8:B858 A9 B2 B9    LDA #$B9B2             ;\
$A8:B85B 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy function = $B9B2 (idling)
$A8:B85E 60          RTS
}


;;; $B85F: Beetom function - start crawling left ;;;
{
$A8:B85F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B862 A9 C1 B9    LDA #$B9C1             ;\
$A8:B865 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B9C1 (crawling left)
$A8:B868 A9 96 B6    LDA #$B696             ;\
$A8:B86B 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B696 (crawling - facing left)
$A8:B86F 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B872 60          RTS
}


;;; $B873: Beetom function - start crawling right ;;;
{
$A8:B873 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B876 A9 24 BA    LDA #$BA24             ;\
$A8:B879 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $BA24 (crawling right)
$A8:B87C A9 F2 B6    LDA #$B6F2             ;\
$A8:B87F 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B6F2 (crawling - facing right)
$A8:B883 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B886 60          RTS
}


;;; $B887: Beetom function - start short hop left ;;;
{
$A8:B887 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B88A BF 04 78 7E LDA $7E7804,x[$7E:7844];\
$A8:B88E 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy Y speed table index = [enemy initial short leap Y speed table index]
$A8:B891 A9 84 BA    LDA #$BA84             ;\
$A8:B894 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy function = $BA84 (short hop left)
$A8:B897 A9 00 00    LDA #$0000             ;\
$A8:B89A 9F 0A 78 7E STA $7E780A,x[$7E:784A];} Enemy falling flag = 0
$A8:B89E A9 AC B6    LDA #$B6AC             ;\
$A8:B8A1 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy instruction list = $B6AC (hop - facing left)
$A8:B8A5 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B8A8 60          RTS
}


;;; $B8A9: Beetom function - start short hop right ;;;
{
$A8:B8A9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B8AC BF 04 78 7E LDA $7E7804,x[$7E:78C4];\
$A8:B8B0 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy Y speed table index = [enemy initial short leap Y speed table index]
$A8:B8B3 A9 B7 BA    LDA #$BAB7             ;\
$A8:B8B6 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy function = $BAB7 (short hop right)
$A8:B8B9 A9 00 00    LDA #$0000             ;\
$A8:B8BC 9F 0A 78 7E STA $7E780A,x[$7E:78CA];} Enemy falling flag = 0
$A8:B8C0 A9 08 B7    LDA #$B708             ;\
$A8:B8C3 9F 00 78 7E STA $7E7800,x[$7E:78C0];} Enemy instruction list = $B708 (hop - facing right)
$A8:B8C7 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B8CA 60          RTS
}


;;; $B8CB: Beetom function - start long hop left ;;;
{
$A8:B8CB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B8CE BF 06 78 7E LDA $7E7806,x[$7E:7906];\
$A8:B8D2 9D AA 0F    STA $0FAA,x[$7E:10AA]  ;} Enemy Y speed table index = [enemy initial long leap Y speed table index]
$A8:B8D5 A9 55 BB    LDA #$BB55             ;\
$A8:B8D8 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $BB55 (long hop left)
$A8:B8DB A9 00 00    LDA #$0000             ;\
$A8:B8DE 9F 0A 78 7E STA $7E780A,x[$7E:790A];} Enemy falling flag = 0
$A8:B8E2 A9 AC B6    LDA #$B6AC             ;\
$A8:B8E5 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B6AC (hop - facing left)
$A8:B8E9 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B8EC 60          RTS
}


;;; $B8ED: Beetom function - start long hop right ;;;
{
$A8:B8ED AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B8F0 BF 06 78 7E LDA $7E7806,x[$7E:78C6];\
$A8:B8F4 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy Y speed table index = [enemy initial long leap Y speed table index]
$A8:B8F7 A9 88 BB    LDA #$BB88             ;\
$A8:B8FA 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy function = $BB88 (long hop right)
$A8:B8FD A9 00 00    LDA #$0000             ;\
$A8:B900 9F 0A 78 7E STA $7E780A,x[$7E:78CA];} Enemy falling flag = 0
$A8:B904 A9 08 B7    LDA #$B708             ;\
$A8:B907 9F 00 78 7E STA $7E7800,x[$7E:78C0];} Enemy instruction list = $B708 (hop - facing right)
$A8:B90B 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B90E 60          RTS
}


;;; $B90F: Beetom function - decide action - Samus in proximity ;;;
{
$A8:B90F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B912 BF 08 78 7E LDA $7E7808,x[$7E:7908];\
$A8:B916 9D AA 0F    STA $0FAA,x[$7E:10AA]  ;} Enemy Y speed table index = [enemy initial lunge Y speed table index]
$A8:B919 A9 08 B7    LDA #$B708             ;\
$A8:B91C 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B708 (hop - facing right)
$A8:B920 A9 5A BC    LDA #$BC5A             ;\
$A8:B923 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $BC5A (lunge right)
$A8:B926 A9 01 00    LDA #$0001             ;\
$A8:B929 9F 12 78 7E STA $7E7812,x[$7E:7912];} Enemy direction = right
$A8:B92D 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:B931 10 14       BPL $14    [$B947]     ;} If [Samus X position] < [enemy X position]:
$A8:B933 A9 AC B6    LDA #$B6AC             ;\
$A8:B936 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B6AC (hop - facing left)
$A8:B93A A9 26 BC    LDA #$BC26             ;\
$A8:B93D 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $BC26 (lunge left)
$A8:B940 A9 00 00    LDA #$0000             ;\
$A8:B943 9F 12 78 7E STA $7E7812,x[$7E:7912];} Enemy direction = left

$A8:B947 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B94A A9 00 00    LDA #$0000             ;\
$A8:B94D 9F 0A 78 7E STA $7E780A,x[$7E:790A];} Enemy falling flag = 0
$A8:B951 60          RTS
}


;;; $B952: Beetom function - start draining Samus - facing left ;;;
{
$A8:B952 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B955 A9 CC B6    LDA #$B6CC             ;\
$A8:B958 9F 00 78 7E STA $7E7800,x[$7E:7840];} Enemy instruction list = $B6CC (draining Samus - facing left)
$A8:B95C 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B95F A9 F8 BC    LDA #$BCF8             ;\
$A8:B962 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy function = $BCF8 (draining Samus - facing left)
$A8:B965 60          RTS
}


;;; $B966: Beetom function - start draining Samus - facing right ;;;
{
$A8:B966 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B969 A9 28 B7    LDA #$B728             ;\
$A8:B96C 9F 00 78 7E STA $7E7800,x[$7E:7880];} Enemy instruction list = $B728 (draining Samus - facing right)
$A8:B970 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B973 A9 42 BD    LDA #$BD42             ;\
$A8:B976 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy function = $BD42 (draining Samus - facing right)
$A8:B979 60          RTS
}


;;; $B97A: Beetom function - start dropping ;;;
{
$A8:B97A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B97D A9 96 B6    LDA #$B696             ;\
$A8:B980 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B696 (crawling - facing left)
$A8:B984 BF 12 78 7E LDA $7E7812,x[$7E:7912];\
$A8:B988 F0 07       BEQ $07    [$B991]     ;} If [enemy direction] != left:
$A8:B98A A9 F2 B6    LDA #$B6F2             ;\
$A8:B98D 9F 00 78 7E STA $7E7800,x[$7E:7900];} Enemy instruction list = $B6F2 (crawling - facing right)

$A8:B991 20 62 B7    JSR $B762  [$A8:B762]  ; Set beetom instruction list
$A8:B994 A9 00 00    LDA #$0000             ;\
$A8:B997 9F 0A 78 7E STA $7E780A,x[$7E:790A];} Enemy falling flag = 0
$A8:B99B A9 9D BD    LDA #$BD9D             ;\
$A8:B99E 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $BD9D (dropping)
$A8:B9A1 60          RTS
}


;;; $B9A2: Beetom function - start being flung ;;;
{
$A8:B9A2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B9A5 A9 00 00    LDA #$0000             ;\
$A8:B9A8 9D AA 0F    STA $0FAA,x            ;} Enemy Y speed table index = 0
$A8:B9AB A9 C5 BD    LDA #$BDC5             ;\
$A8:B9AE 9D AC 0F    STA $0FAC,x            ;} Enemy function = $BDC5 (being flung)
$A8:B9B1 60          RTS
}


;;; $B9B2: Beetom function - idling ;;;
{
$A8:B9B2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B9B5 DE AE 0F    DEC $0FAE,x[$7E:0FAE]  ; Decrement enemy function timer
$A8:B9B8 10 06       BPL $06    [$B9C0]     ; If [enemy function timer] < 0:
$A8:B9BA A9 14 B8    LDA #$B814             ;\
$A8:B9BD 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy function = $B814 (decide action)

$A8:B9C0 60          RTS
}


;;; $B9C1: Beetom function - crawling left ;;;
{
$A8:B9C1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:B9C4 DE AE 0F    DEC $0FAE,x[$7E:10AE]  ; Decrement enemy function timer
$A8:B9C7 30 4E       BMI $4E    [$BA17]     ; If [enemy function timer] < 0: go to BRANCH_END
$A8:B9C9 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A8:B9CC 38          SEC                    ;|
$A8:B9CD E9 08 00    SBC #$0008             ;} Enemy X position -= 8
$A8:B9D0 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A8:B9D3 A9 01 00    LDA #$0001             ;\
$A8:B9D6 85 14       STA $14    [$7E:0014]  ;|
$A8:B9D8 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$A8:B9DA 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:B9DE B0 15       BCS $15    [$B9F5]     ; If not collided with block:
$A8:B9E0 A9 73 B8    LDA #$B873             ;\
$A8:B9E3 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B873 (start crawling right)
$A8:B9E6 DE 7E 0F    DEC $0F7E,x            ; Enemy Y position -= 1
$A8:B9E9 BD 7A 0F    LDA $0F7A,x            ;\
$A8:B9EC 18          CLC                    ;|
$A8:B9ED 69 08 00    ADC #$0008             ;} Enemy X position += 8
$A8:B9F0 9D 7A 0F    STA $0F7A,x            ;/
$A8:B9F3 80 2E       BRA $2E    [$BA23]     ; Return

$A8:B9F5 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A8:B9F8 18          CLC                    ;|
$A8:B9F9 69 08 00    ADC #$0008             ;} Enemy X position += 8
$A8:B9FC 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A8:B9FF A9 00 C0    LDA #$C000             ;\
$A8:BA02 85 12       STA $12    [$7E:0012]  ;|
$A8:BA04 A9 FF FF    LDA #$FFFF             ;} Move enemy left by 0.4000h
$A8:BA07 85 14       STA $14    [$7E:0014]  ;|
$A8:BA09 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BA0D 90 14       BCC $14    [$BA23]     ; If not collided with wall: return
$A8:BA0F A9 73 B8    LDA #$B873             ;\
$A8:BA12 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B873 (start crawling right)
$A8:BA15 80 0C       BRA $0C    [$BA23]     ; Return

; BRANCH_END
$A8:BA17 A9 40 00    LDA #$0040             ;\
$A8:BA1A 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy function timer = 40h
$A8:BA1D A9 14 B8    LDA #$B814             ;\
$A8:BA20 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy function = $B814 (decide action)

$A8:BA23 60          RTS
}


;;; $BA24: Beetom function - crawling right ;;;
{
$A8:BA24 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BA27 DE AE 0F    DEC $0FAE,x[$7E:10AE]  ; Decrement enemy function timer
$A8:BA2A 30 4B       BMI $4B    [$BA77]     ; If [enemy function timer] < 0: go to BRANCH_END
$A8:BA2C BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A8:BA2F 18          CLC                    ;|
$A8:BA30 69 08 00    ADC #$0008             ;} Enemy X position += 8
$A8:BA33 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A8:BA36 A9 01 00    LDA #$0001             ;\
$A8:BA39 85 14       STA $14    [$7E:0014]  ;|
$A8:BA3B 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by 1.0
$A8:BA3D 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:BA41 B0 15       BCS $15    [$BA58]     ; If not collided with block:
$A8:BA43 A9 5F B8    LDA #$B85F             ;\
$A8:BA46 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B85F (start crawling left)
$A8:BA49 DE 7E 0F    DEC $0F7E,x            ; Enemy Y position -= 1
$A8:BA4C BD 7A 0F    LDA $0F7A,x            ;\
$A8:BA4F 38          SEC                    ;|
$A8:BA50 E9 08 00    SBC #$0008             ;} Enemy X position -= 8
$A8:BA53 9D 7A 0F    STA $0F7A,x            ;/
$A8:BA56 80 2B       BRA $2B    [$BA83]     ; Return

$A8:BA58 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A8:BA5B 38          SEC                    ;|
$A8:BA5C E9 08 00    SBC #$0008             ;} Enemy X position -= 8
$A8:BA5F 9D 7A 0F    STA $0F7A,x[$7E:107A]  ;/
$A8:BA62 A9 00 40    LDA #$4000             ;\
$A8:BA65 85 12       STA $12    [$7E:0012]  ;|
$A8:BA67 64 14       STZ $14    [$7E:0014]  ;} Move enemy right by 0.4000h
$A8:BA69 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BA6D 90 14       BCC $14    [$BA83]     ; If not collided with wall: return
$A8:BA6F A9 5F B8    LDA #$B85F             ;\
$A8:BA72 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B85F (start crawling left)
$A8:BA75 80 0C       BRA $0C    [$BA83]     ; Return

; BRANCH_END
$A8:BA77 A9 40 00    LDA #$0040             ;\
$A8:BA7A 9D AE 0F    STA $0FAE,x[$7E:10AE]  ;} Enemy function timer = 40h
$A8:BA7D A9 14 B8    LDA #$B814             ;\
$A8:BA80 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B814 (decide action)

$A8:BA83 60          RTS
}


;;; $BA84: Beetom function - short hop left ;;;
{
$A8:BA84 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BA87 BF 0A 78 7E LDA $7E780A,x[$7E:784A];\
$A8:BA8B D0 05       BNE $05    [$BA92]     ;} If [enemy falling flag] = 0:
$A8:BA8D 20 E7 BA    JSR $BAE7  [$A8:BAE7]  ; Beetom Y movement - short hop - rising
$A8:BA90 80 03       BRA $03    [$BA95]

                                            ; Else ([enemy falling flag] != 0):
$A8:BA92 20 20 BB    JSR $BB20  [$A8:BB20]  ; Beetom Y movement - short hop - falling

$A8:BA95 A9 FF FF    LDA #$FFFF             ;\
$A8:BA98 85 14       STA $14    [$7E:0014]  ;|
$A8:BA9A A9 00 C0    LDA #$C000             ;} Move enemy left by 0.4000h
$A8:BA9D 85 12       STA $12    [$7E:0012]  ;|
$A8:BA9F 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BAA3 90 11       BCC $11    [$BAB6]     ; If not collided with wall: return
$A8:BAA5 BF 12 78 7E LDA $7E7812,x[$7E:7912];\
$A8:BAA9 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BAAC 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:BAB0 A9 7A B9    LDA #$B97A             ;\
$A8:BAB3 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B97A (start dropping)

$A8:BAB6 60          RTS
}


;;; $BAB7: Beetom function - short hop right ;;;
{
$A8:BAB7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BABA BF 0A 78 7E LDA $7E780A,x[$7E:78CA];\
$A8:BABE D0 05       BNE $05    [$BAC5]     ;} If [enemy falling flag] = 0:
$A8:BAC0 20 E7 BA    JSR $BAE7  [$A8:BAE7]  ; Beetom Y movement - short hop - rising
$A8:BAC3 80 03       BRA $03    [$BAC8]

                                            ; Else ([enemy falling flag] != 0):
$A8:BAC5 20 20 BB    JSR $BB20  [$A8:BB20]  ; Beetom Y movement - short hop - falling

$A8:BAC8 64 14       STZ $14    [$7E:0014]  ;\
$A8:BACA A9 00 40    LDA #$4000             ;|
$A8:BACD 85 12       STA $12    [$7E:0012]  ;} Move enemy right by 0.4000h
$A8:BACF 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BAD3 90 11       BCC $11    [$BAE6]     ; If not collided with wall: return
$A8:BAD5 BF 12 78 7E LDA $7E7812,x          ;\
$A8:BAD9 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BADC 9F 12 78 7E STA $7E7812,x          ;/
$A8:BAE0 A9 7A B9    LDA #$B97A             ;\
$A8:BAE3 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B97A (start dropping)

$A8:BAE6 60          RTS
}


;;; $BAE7: Beetom Y movement - short hop - rising ;;;
{
$A8:BAE7 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A8:BAEA 0A          ASL A                  ;|
$A8:BAEB 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BAEC 0A          ASL A                  ;|
$A8:BAED A8          TAY                    ;/
$A8:BAEE B9 95 83    LDA $8395,y[$A8:85B5]  ;\
$A8:BAF1 85 14       STA $14    [$7E:0014]  ;|
$A8:BAF3 B9 93 83    LDA $8393,y[$A8:85B3]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A8:BAF6 85 12       STA $12    [$7E:0012]  ;/
$A8:BAF8 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BAFC 90 08       BCC $08    [$BB06]     ; If collided with block:
$A8:BAFE A9 7A B9    LDA #$B97A             ;\
$A8:BB01 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy function = $B97A (start dropping)
$A8:BB04 80 19       BRA $19    [$BB1F]     ; Return

$A8:BB06 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A8:BB09 38          SEC                    ;|
$A8:BB0A E9 04 00    SBC #$0004             ;} Enemy Y speed table index -= 4
$A8:BB0D 9D AA 0F    STA $0FAA,x[$7E:106A]  ;/
$A8:BB10 10 0D       BPL $0D    [$BB1F]     ; If [enemy Y speed table index] < 0:
$A8:BB12 A9 00 00    LDA #$0000             ;\
$A8:BB15 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy Y speed table index = 0
$A8:BB18 A9 01 00    LDA #$0001             ;\
$A8:BB1B 9F 0A 78 7E STA $7E780A,x[$7E:78CA];} Enemy falling flag = 1

$A8:BB1F 60          RTS
}


;;; $BB20: Beetom Y movement - short hop - falling ;;;
{
$A8:BB20 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A8:BB23 0A          ASL A                  ;|
$A8:BB24 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BB25 0A          ASL A                  ;|
$A8:BB26 A8          TAY                    ;/
$A8:BB27 B9 91 83    LDA $8391,y[$A8:8391]  ;\
$A8:BB2A 85 14       STA $14    [$7E:0014]  ;|
$A8:BB2C B9 8F 83    LDA $838F,y[$A8:838F]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A8:BB2F 85 12       STA $12    [$7E:0012]  ;/
$A8:BB31 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BB35 90 08       BCC $08    [$BB3F]     ; If collided with block:
$A8:BB37 A9 14 B8    LDA #$B814             ;\
$A8:BB3A 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy function = $B814 (decide action)
$A8:BB3D 80 15       BRA $15    [$BB54]     ; Return

$A8:BB3F BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A8:BB42 18          CLC                    ;|
$A8:BB43 69 04 00    ADC #$0004             ;|
$A8:BB46 9D AA 0F    STA $0FAA,x[$7E:106A]  ;|
$A8:BB49 C9 40 00    CMP #$0040             ;} Enemy Y speed table index = min(40h, [enemy Y speed table index] + 4)
$A8:BB4C 30 06       BMI $06    [$BB54]     ;|
$A8:BB4E A9 40 00    LDA #$0040             ;|
$A8:BB51 9D AA 0F    STA $0FAA,x[$7E:106A]  ;/

$A8:BB54 60          RTS
}


;;; $BB55: Beetom function - long hop left ;;;
{
$A8:BB55 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BB58 BF 0A 78 7E LDA $7E780A,x[$7E:790A];\
$A8:BB5C D0 05       BNE $05    [$BB63]     ;} If [enemy falling flag] = 0:
$A8:BB5E 20 B8 BB    JSR $BBB8  [$A8:BBB8]  ; Beetom Y movement - long hop - rising
$A8:BB61 80 03       BRA $03    [$BB66]

                                            ; Else ([enemy falling flag] != 0):
$A8:BB63 20 F1 BB    JSR $BBF1  [$A8:BBF1]  ; Beetom Y movement - long hop - falling

$A8:BB66 A9 FF FF    LDA #$FFFF             ;\
$A8:BB69 85 14       STA $14    [$7E:0014]  ;|
$A8:BB6B A9 00 C0    LDA #$C000             ;} Move enemy left by 0.4000h
$A8:BB6E 85 12       STA $12    [$7E:0012]  ;|
$A8:BB70 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BB74 90 11       BCC $11    [$BB87]     ; If not collided with wall: return
$A8:BB76 BF 12 78 7E LDA $7E7812,x[$7E:7912];\
$A8:BB7A 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BB7D 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:BB81 A9 7A B9    LDA #$B97A             ;\
$A8:BB84 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B97A (start dropping)

$A8:BB87 60          RTS
}


;;; $BB88: Beetom function - long hop right ;;;
{
$A8:BB88 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BB8B BF 0A 78 7E LDA $7E780A,x[$7E:78CA];\
$A8:BB8F D0 05       BNE $05    [$BB96]     ;} If [enemy falling flag] = 0:
$A8:BB91 20 B8 BB    JSR $BBB8  [$A8:BBB8]  ; Beetom Y movement - long hop - rising
$A8:BB94 80 03       BRA $03    [$BB99]

                                            ; Else ([enemy falling flag] != 0):
$A8:BB96 20 F1 BB    JSR $BBF1  [$A8:BBF1]  ; Beetom Y movement - long hop - falling

$A8:BB99 64 14       STZ $14    [$7E:0014]  ;\
$A8:BB9B A9 00 40    LDA #$4000             ;|
$A8:BB9E 85 12       STA $12    [$7E:0012]  ;} Move enemy right by 0.4000h
$A8:BBA0 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BBA4 90 11       BCC $11    [$BBB7]     ; If not collided with wall: return
$A8:BBA6 BF 12 78 7E LDA $7E7812,x[$7E:7912];\
$A8:BBAA 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BBAD 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:BBB1 A9 7A B9    LDA #$B97A             ;\
$A8:BBB4 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B97A (start dropping)

$A8:BBB7 60          RTS
}


;;; $BBB8: Beetom Y movement - long hop - rising ;;;
{
$A8:BBB8 BD AA 0F    LDA $0FAA,x[$7E:10AA]  ;\
$A8:BBBB 0A          ASL A                  ;|
$A8:BBBC 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BBBD 0A          ASL A                  ;|
$A8:BBBE A8          TAY                    ;/
$A8:BBBF B9 95 83    LDA $8395,y[$A8:8615]  ;\
$A8:BBC2 85 14       STA $14    [$7E:0014]  ;|
$A8:BBC4 B9 93 83    LDA $8393,y[$A8:8613]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A8:BBC7 85 12       STA $12    [$7E:0012]  ;/
$A8:BBC9 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BBCD 90 08       BCC $08    [$BBD7]     ; If collided with block:
$A8:BBCF A9 7A B9    LDA #$B97A             ;\
$A8:BBD2 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B97A (start dropping)
$A8:BBD5 80 19       BRA $19    [$BBF0]     ; Return

$A8:BBD7 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:BBDA 38          SEC                    ;|
$A8:BBDB E9 05 00    SBC #$0005             ;} Enemy Y speed table index -= 5
$A8:BBDE 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A8:BBE1 10 0D       BPL $0D    [$BBF0]     ; If [enemy Y speed table index] < 0:
$A8:BBE3 A9 00 00    LDA #$0000             ;\
$A8:BBE6 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy Y speed table index = 0
$A8:BBE9 A9 01 00    LDA #$0001             ;\
$A8:BBEC 9F 0A 78 7E STA $7E780A,x[$7E:784A];} Enemy falling flag = 1

$A8:BBF0 60          RTS
}


;;; $BBF1: Beetom Y movement - long hop - falling ;;;
{
$A8:BBF1 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:BBF4 0A          ASL A                  ;|
$A8:BBF5 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BBF6 0A          ASL A                  ;|
$A8:BBF7 A8          TAY                    ;/
$A8:BBF8 B9 91 83    LDA $8391,y[$A8:8391]  ;\
$A8:BBFB 85 14       STA $14    [$7E:0014]  ;|
$A8:BBFD B9 8F 83    LDA $838F,y[$A8:838F]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A8:BC00 85 12       STA $12    [$7E:0012]  ;/
$A8:BC02 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BC06 90 08       BCC $08    [$BC10]     ; If collided with block:
$A8:BC08 A9 14 B8    LDA #$B814             ;\
$A8:BC0B 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy function = $B814 (decide action)
$A8:BC0E 80 15       BRA $15    [$BC25]     ; Return

$A8:BC10 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:BC13 18          CLC                    ;|
$A8:BC14 69 05 00    ADC #$0005             ;|
$A8:BC17 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;|
$A8:BC1A C9 40 00    CMP #$0040             ;} Enemy Y speed table index = min(40h, [enemy Y speed table index] + 5)
$A8:BC1D 30 06       BMI $06    [$BC25]     ;|
$A8:BC1F A9 40 00    LDA #$0040             ;|
$A8:BC22 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/

$A8:BC25 60          RTS
}


;;; $BC26: Beetom function - lunge left ;;;
{
$A8:BC26 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BC29 BF 0A 78 7E LDA $7E780A,x[$7E:790A];\
$A8:BC2D D0 05       BNE $05    [$BC34]     ;} If [enemy falling flag] = 0:
$A8:BC2F 20 8A BC    JSR $BC8A  [$A8:BC8A]  ; Beetom Y movement - lunge - rising
$A8:BC32 80 03       BRA $03    [$BC37]

                                            ; Else ([enemy falling flag] != 0):
$A8:BC34 20 C3 BC    JSR $BCC3  [$A8:BCC3]  ; Beetom Y movement - lunge - falling

$A8:BC37 A9 03 00    LDA #$0003             ;\
$A8:BC3A 49 FF FF    EOR #$FFFF             ;|
$A8:BC3D 1A          INC A                  ;|
$A8:BC3E 85 14       STA $14    [$7E:0014]  ;} Move enemy left by 3.0
$A8:BC40 64 12       STZ $12    [$7E:0012]  ;|
$A8:BC42 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BC46 90 11       BCC $11    [$BC59]     ; If collided with wall:
$A8:BC48 BF 12 78 7E LDA $7E7812,x[$7E:7912];\
$A8:BC4C 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BC4F 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:BC53 A9 7A B9    LDA #$B97A             ;\
$A8:BC56 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B97A (start dropping)

$A8:BC59 60          RTS
}


;;; $BC5A: Beetom function - lunge right ;;;
{
$A8:BC5A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BC5D BF 0A 78 7E LDA $7E780A,x[$7E:788A];\
$A8:BC61 D0 05       BNE $05    [$BC68]     ;} If [enemy falling flag] = 0:
$A8:BC63 20 8A BC    JSR $BC8A  [$A8:BC8A]  ; Beetom Y movement - lunge - rising
$A8:BC66 80 03       BRA $03    [$BC6B]

                                            ; Else ([enemy falling flag] != 0):
$A8:BC68 20 C3 BC    JSR $BCC3  [$A8:BCC3]  ; Beetom Y movement - lunge - falling

$A8:BC6B A9 03 00    LDA #$0003             ;\
$A8:BC6E 85 14       STA $14    [$7E:0014]  ;|
$A8:BC70 64 12       STZ $12    [$7E:0012]  ;} Move enemy right by 3.0
$A8:BC72 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BC76 90 11       BCC $11    [$BC89]     ; If collided with wall:
$A8:BC78 BF 12 78 7E LDA $7E7812,x[$7E:78D2];\
$A8:BC7C 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BC7F 9F 12 78 7E STA $7E7812,x[$7E:78D2];/
$A8:BC83 A9 7A B9    LDA #$B97A             ;\
$A8:BC86 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy function = $B97A (start dropping)

$A8:BC89 60          RTS
}


;;; $BC8A: Beetom Y movement - lunge - rising ;;;
{
$A8:BC8A BD AA 0F    LDA $0FAA,x[$7E:10AA]  ;\
$A8:BC8D 0A          ASL A                  ;|
$A8:BC8E 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BC8F 0A          ASL A                  ;|
$A8:BC90 A8          TAY                    ;/
$A8:BC91 B9 95 83    LDA $8395,y[$A8:8575]  ;\
$A8:BC94 85 14       STA $14    [$7E:0014]  ;|
$A8:BC96 B9 93 83    LDA $8393,y[$A8:8573]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A8:BC99 85 12       STA $12    [$7E:0012]  ;/
$A8:BC9B 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BC9F 90 08       BCC $08    [$BCA9]     ; If collided with block:
$A8:BCA1 A9 7A B9    LDA #$B97A             ;\
$A8:BCA4 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B97A (start dropping)
$A8:BCA7 80 19       BRA $19    [$BCC2]     ; Return

$A8:BCA9 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A8:BCAC 38          SEC                    ;|
$A8:BCAD E9 05 00    SBC #$0005             ;} Enemy Y speed table index -= 5
$A8:BCB0 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/
$A8:BCB3 10 0D       BPL $0D    [$BCC2]     ; If [enemy Y speed table index] < 0:
$A8:BCB5 A9 00 00    LDA #$0000             ;\
$A8:BCB8 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy Y speed table index = 0
$A8:BCBB A9 01 00    LDA #$0001             ;\
$A8:BCBE 9F 0A 78 7E STA $7E780A,x[$7E:788A];} Enemy falling flag = 1

$A8:BCC2 60          RTS
}


;;; $BCC3: Beetom Y movement - lunge - falling ;;;
{
$A8:BCC3 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A8:BCC6 0A          ASL A                  ;|
$A8:BCC7 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BCC8 0A          ASL A                  ;|
$A8:BCC9 A8          TAY                    ;/
$A8:BCCA B9 91 83    LDA $8391,y[$A8:8391]  ;\
$A8:BCCD 85 14       STA $14    [$7E:0014]  ;|
$A8:BCCF B9 8F 83    LDA $838F,y[$A8:838F]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A8:BCD2 85 12       STA $12    [$7E:0012]  ;/
$A8:BCD4 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BCD8 90 08       BCC $08    [$BCE2]     ; If collided with block:
$A8:BCDA A9 14 B8    LDA #$B814             ;\
$A8:BCDD 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy function = $B814 (decide action)
$A8:BCE0 80 15       BRA $15    [$BCF7]     ; Return

$A8:BCE2 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A8:BCE5 18          CLC                    ;|
$A8:BCE6 69 03 00    ADC #$0003             ;|
$A8:BCE9 9D AA 0F    STA $0FAA,x[$7E:102A]  ;|
$A8:BCEC C9 40 00    CMP #$0040             ;} Enemy Y speed table index = min(40h, [enemy Y speed table index] + 3)
$A8:BCEF 30 06       BMI $06    [$BCF7]     ;|
$A8:BCF1 A9 40 00    LDA #$0040             ;|
$A8:BCF4 9D AA 0F    STA $0FAA,x            ;/

$A8:BCF7 60          RTS
}


;;; $BCF8: Beetom function - draining Samus - facing left ;;;
{
$A8:BCF8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BCFB BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;\
$A8:BCFE D0 2E       BNE $2E    [$BD2E]     ;} If [enemy button counter] != 0: go to BRANCH_ATTACHED
$A8:BD00 64 12       STZ $12    [$7E:0012]  ;\
$A8:BD02 A9 10 00    LDA #$0010             ;|
$A8:BD05 85 14       STA $14    [$7E:0014]  ;} Move enemy right by 10.0h
$A8:BD07 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BD0B 90 12       BCC $12    [$BD1F]     ; If collided with wall:
$A8:BD0D A9 01 00    LDA #$0001             ;\
$A8:BD10 9F 12 78 7E STA $7E7812,x          ;} Enemy direction = right
$A8:BD14 64 12       STZ $12    [$7E:0012]  ;\
$A8:BD16 A9 E0 FF    LDA #$FFE0             ;|
$A8:BD19 85 14       STA $14    [$7E:0014]  ;} Move enemy left by 20.0h
$A8:BD1B 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/

$A8:BD1F A9 00 00    LDA #$0000             ;\
$A8:BD22 9F 10 78 7E STA $7E7810,x          ;} Enemy attached to Samus flag = 0
$A8:BD26 A9 A2 B9    LDA #$B9A2             ;\
$A8:BD29 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B9A2 (start being flung)
$A8:BD2C 80 13       BRA $13    [$BD41]     ; Return

; BRANCH_ATTACHED
$A8:BD2E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:BD31 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [Samus X position]
$A8:BD34 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:BD37 38          SEC                    ;|
$A8:BD38 E9 04 00    SBC #$0004             ;} Enemy Y position = [Samus Y position] - 4
$A8:BD3B 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;/
$A8:BD3E 20 8C BD    JSR $BD8C  [$A8:BD8C]  ; Update beetom button counter

$A8:BD41 60          RTS
}


;;; $BD42: Beetom function - draining Samus - facing right ;;;
{
$A8:BD42 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BD45 BD B0 0F    LDA $0FB0,x[$7E:1030]  ;\
$A8:BD48 D0 2E       BNE $2E    [$BD78]     ;} If [enemy button counter] != 0: go to BRANCH_ATTACHED
$A8:BD4A 64 12       STZ $12    [$7E:0012]  ;\
$A8:BD4C A9 F0 FF    LDA #$FFF0             ;|
$A8:BD4F 85 14       STA $14    [$7E:0014]  ;} Move enemy left by 10.0h
$A8:BD51 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:BD55 90 12       BCC $12    [$BD69]     ; If collided with wall:
$A8:BD57 A9 00 00    LDA #$0000             ;\
$A8:BD5A 9F 12 78 7E STA $7E7812,x          ;} Enemy direction = left
$A8:BD5E 64 12       STZ $12    [$7E:0012]  ;\
$A8:BD60 A9 20 00    LDA #$0020             ;|
$A8:BD63 85 14       STA $14    [$7E:0014]  ;} Move enemy right by 20.0h
$A8:BD65 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/

$A8:BD69 A9 00 00    LDA #$0000             ;\
$A8:BD6C 9F 10 78 7E STA $7E7810,x          ;} Enemy attached to Samus flag = 0
$A8:BD70 A9 A2 B9    LDA #$B9A2             ;\
$A8:BD73 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B9A2 (start being flung)
$A8:BD76 80 13       BRA $13    [$BD8B]     ; Return

; BRANCH_ATTACHED
$A8:BD78 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:BD7B 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;} Enemy X position = [Samus X position]
$A8:BD7E AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:BD81 38          SEC                    ;|
$A8:BD82 E9 04 00    SBC #$0004             ;} Enemy Y position = [Samus Y position] - 4
$A8:BD85 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A8:BD88 20 8C BD    JSR $BD8C  [$A8:BD8C]  ; Update beetom button counter

$A8:BD8B 60          RTS
}


;;; $BD8C: Update beetom button counter ;;;
{
$A8:BD8C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BD8F A5 8B       LDA $8B    [$7E:008B]  ;\
$A8:BD91 DD B2 0F    CMP $0FB2,x[$7E:1032]  ;} If [controller 1 input] != [enemy previous controller 1 input]:
$A8:BD94 F0 06       BEQ $06    [$BD9C]     ;/
$A8:BD96 9D B2 0F    STA $0FB2,x[$7E:1032]  ; Enemy previous controller 1 input = [controller 1 input]
$A8:BD99 DE B0 0F    DEC $0FB0,x[$7E:1030]  ; Decrement enemy button counter

$A8:BD9C 60          RTS
}


;;; $BD9D: Beetom function - dropping ;;;
{
$A8:BD9D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BDA0 A9 03 00    LDA #$0003             ;\
$A8:BDA3 85 14       STA $14    [$7E:0014]  ;|
$A8:BDA5 A9 00 00    LDA #$0000             ;} Move enemy down by 3.0
$A8:BDA8 85 12       STA $12    [$7E:0012]  ;|
$A8:BDAA 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:BDAE 90 14       BCC $14    [$BDC4]     ; If not collided with block: return
$A8:BDB0 BF 12 78 7E LDA $7E7812,x[$7E:7912];\
$A8:BDB4 D0 08       BNE $08    [$BDBE]     ;} If [enemy direction] = left:
$A8:BDB6 A9 5F B8    LDA #$B85F             ;\
$A8:BDB9 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy function = $B85F (start crawling left)
$A8:BDBC 80 06       BRA $06    [$BDC4]

$A8:BDBE A9 73 B8    LDA #$B873             ;\ Else ([enemy direction] != left):
$A8:BDC1 9D AC 0F    STA $0FAC,x[$7E:10AC]  ;} Enemy function = $B873 (start crawling right)

$A8:BDC4 60          RTS
}


;;; $BDC5: Beetom function - being flung ;;;
{
; >_<;
$A8:BDC5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BDC8 20 CC BD    JSR $BDCC  [$A8:BDCC]  ; Beetom movement - being flung
$A8:BDCB 60          RTS
}


;;; $BDCC: Beetom movement - being flung ;;;
{
$A8:BDCC BD AA 0F    LDA $0FAA,x            ;\
$A8:BDCF 0A          ASL A                  ;|
$A8:BDD0 0A          ASL A                  ;} Y = [enemy Y speed table index] * 8 (quadratic speed table index)
$A8:BDD1 0A          ASL A                  ;|
$A8:BDD2 A8          TAY                    ;/
$A8:BDD3 B9 91 83    LDA $8391,y            ;\
$A8:BDD6 85 14       STA $14    [$7E:0014]  ;|
$A8:BDD8 B9 8F 83    LDA $838F,y            ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A8:BDDB 85 12       STA $12    [$7E:0012]  ;/
$A8:BDDD 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A8:BDE1 90 08       BCC $08    [$BDEB]     ; If collided with block:
$A8:BDE3 A9 14 B8    LDA #$B814             ;\
$A8:BDE6 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B814 (decide action)
$A8:BDE9 80 15       BRA $15    [$BE00]     ; Return

$A8:BDEB BD AA 0F    LDA $0FAA,x            ;\
$A8:BDEE 18          CLC                    ;|
$A8:BDEF 69 01 00    ADC #$0001             ;|
$A8:BDF2 9D AA 0F    STA $0FAA,x            ;|
$A8:BDF5 C9 40 00    CMP #$0040             ;} Enemy Y speed table index = min(40h, [enemy Y speed table index] + 1)
$A8:BDF8 30 06       BMI $06    [$BE00]     ;|
$A8:BDFA A9 40 00    LDA #$0040             ;|
$A8:BDFD 9D AA 0F    STA $0FAA,x            ;/

$A8:BE00 BF 12 78 7E LDA $7E7812,x          ;\
$A8:BE04 D0 05       BNE $05    [$BE0B]     ;} If [enemy direction] = left:
$A8:BE06 A9 02 00    LDA #$0002             ; $14 = 2
$A8:BE09 80 07       BRA $07    [$BE12]

$A8:BE0B A9 02 00    LDA #$0002             ;\ Else ([enemy direction] != left):
$A8:BE0E 49 FF FF    EOR #$FFFF             ;} $14 = -2
$A8:BE11 1A          INC A                  ;/

$A8:BE12 85 14       STA $14    [$7E:0014]
$A8:BE14 64 12       STZ $12    [$7E:0012]  ;\
$A8:BE16 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;} Move enemy right by [$14]
$A8:BE1A 90 11       BCC $11    [$BE2D]     ; If collided with wall:
$A8:BE1C BF 12 78 7E LDA $7E7812,x          ;\
$A8:BE20 49 01 00    EOR #$0001             ;} Toggle enemy direction
$A8:BE23 9F 12 78 7E STA $7E7812,x          ;/
$A8:BE27 A9 7A B9    LDA #$B97A             ;\
$A8:BE2A 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B97A (start dropping)

$A8:BE2D 60          RTS
}
}


;;; $BE2E: Enemy touch - enemy $E87F (beetom) ;;;
{
$A8:BE2E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BE31 BF 10 78 7E LDA $7E7810,x[$7E:7890];\
$A8:BE35 D0 3D       BNE $3D    [$BE74]     ;} If [enemy attached to Samus flag] != 0: go to BRANCH_ATTACHED
$A8:BE37 BF 12 78 7E LDA $7E7812,x[$7E:7892];\
$A8:BE3B D0 08       BNE $08    [$BE45]     ;} If [enemy direction] = left:
$A8:BE3D A9 52 B9    LDA #$B952             ;\
$A8:BE40 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy function = $B952 (start draining Samus - facing left)
$A8:BE43 80 06       BRA $06    [$BE4B]

$A8:BE45 A9 66 B9    LDA #$B966             ;\ Else ([enemy direction] != left):
$A8:BE48 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy function = $B966 (start draining Samus - facing right)

$A8:BE4B A9 01 00    LDA #$0001             ;\
$A8:BE4E 9F 10 78 7E STA $7E7810,x[$7E:7890];} Enemy attached to Samus flag = 1
$A8:BE52 A9 40 00    LDA #$0040             ;\
$A8:BE55 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy button counter = 40h
$A8:BE58 A9 02 00    LDA #$0002             ;\
$A8:BE5B 9D 9A 0F    STA $0F9A,x[$7E:101A]  ;} Enemy layer = 2
$A8:BE5E AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:BE61 38          SEC                    ;|
$A8:BE62 FD 7A 0F    SBC $0F7A,x[$7E:0FFA]  ;} Enemy $7E:780C = [Samus X position] - [enemy X position] (unused)
$A8:BE65 9F 0C 78 7E STA $7E780C,x[$7E:788C];/
$A8:BE69 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:BE6C 38          SEC                    ;|
$A8:BE6D FD 7E 0F    SBC $0F7E,x[$7E:0FFE]  ;} Enemy $7E:780E = [Samus Y position] - [enemy Y position] (unused)
$A8:BE70 9F 0E 78 7E STA $7E780E,x[$7E:788E];/

; BRANCH_ATTACHED
$A8:BE74 AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A8:BE77 D0 25       BNE $25    [$BE9E]     ;} If [Samus contact damage index] != normal: go to BRANCH_DAMAGE
$A8:BE79 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A8:BE7C 29 07 00    AND #$0007             ;|
$A8:BE7F C9 07 00    CMP #$0007             ;} If [number of times main enemy routine has been executed] % 8 = 7:
$A8:BE82 D0 0F       BNE $0F    [$BE93]     ;/
$A8:BE84 AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$A8:BE87 C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$A8:BE8A 30 07       BMI $07    [$BE93]     ;/
$A8:BE8C A9 2D 00    LDA #$002D             ;\
$A8:BE8F 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 6 (gaining/losing incremental health)

$A8:BE93 BD A4 0F    LDA $0FA4,x[$7E:1024]  ;\
$A8:BE96 29 3F 00    AND #$003F             ;|
$A8:BE99 C9 3F 00    CMP #$003F             ;} If [enemy frame counter] % 40h != 3Fh: return
$A8:BE9C D0 0D       BNE $0D    [$BEAB]     ;/

; BRANCH_DAMAGE
$A8:BE9E 22 23 80 A8 JSL $A88023[$A8:8023]  ; Normal enemy touch AI
$A8:BEA2 A9 00 00    LDA #$0000             ;\
$A8:BEA5 8D A8 18    STA $18A8  [$7E:18A8]  ;} Samus invincibility timer = 0
$A8:BEA8 8D AA 18    STA $18AA  [$7E:18AA]  ; Samus knockback timer = 0

$A8:BEAB 6B          RTL
}


;;; $BEAC: Enemy shot - enemy $E87F (beetom) ;;;
{
$A8:BEAC 22 2D 80 A8 JSL $A8802D[$A8:802D]  ; Normal enemy shot AI
$A8:BEB0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:BEB3 BD 9E 0F    LDA $0F9E,x[$7E:101E]  ;\
$A8:BEB6 F0 13       BEQ $13    [$BECB]     ;} If [enemy frozen timer] = 0: go to BRANCH_RETURN
$A8:BEB8 BD AC 0F    LDA $0FAC,x[$7E:10AC]  ;\
$A8:BEBB C9 42 BD    CMP #$BD42             ;|
$A8:BEBE F0 05       BEQ $05    [$BEC5]     ;} If [enemy function] != draining Samus: go to BRANCH_RETURN
$A8:BEC0 C9 F8 BC    CMP #$BCF8             ;|
$A8:BEC3 D0 06       BNE $06    [$BECB]     ;/

$A8:BEC5 A9 7A B9    LDA #$B97A             ;\
$A8:BEC8 9D AC 0F    STA $0FAC,x            ;} Enemy function = $B97A (start dropping)

; BRANCH_RETURN
$A8:BECB A9 00 00    LDA #$0000             ;\
$A8:BECE 9F 10 78 7E STA $7E7810,x[$7E:7890];} Enemy attached to Samus flag = 0
$A8:BED2 6B          RTL
}


;;; $BED3: Beetom spritemaps ;;;
{
$A8:BED3             dx 0005, 0000,FE,211E, 0000,F6,210E, 0005,00,211F, 0005,F8,210F, 81F8,F8,2100
$A8:BEEE             dx 0005, 0000,FF,211E, 0000,F7,210E, 0006,00,211F, 0005,F9,210F, 81F8,F8,2102
$A8:BF09             dx 0005, 0000,00,211E, 0001,F8,210E, 0007,00,211F, 0006,FA,210F, 81F8,F8,2104
$A8:BF24             dx 0005, 0007,FE,A10D, 01FF,FE,A10C, 000C,FF,210F, 000D,07,211F, 81F8,F8,2100
$A8:BF3F             dx 0005, 000E,0F,211F, 000C,07,210F, 0008,02,210D, 0000,02,210C, 81F8,F8,2100
$A8:BF5A             dx 0005, 0002,00,210D, 01FA,00,210C, 0000,05,211D, 01F8,05,211C, 81F8,F8,2106
$A8:BF75             dx 0005, 0001,00,210D, 01F9,00,210C, 01FF,05,211D, 01F8,05,211C, 81F8,F8,2108
$A8:BF90             dx 0005, 0000,00,210D, 01F8,00,210C, 01FE,05,211D, 01F8,05,211C, 81F8,F8,210A
$A8:BFAB             dx 0006, 01FA,F8,2120, 0002,00,210D, 01FA,00,210C, 0000,05,211D, 01F8,05,211C, 81F8,F8,2106
$A8:BFCB             dx 0006, 01FA,F8,2121, 0001,00,210D, 01F9,00,210C, 01FF,05,211D, 01F8,05,211C, 81F8,F8,2108
$A8:BFEB             dx 0006, 01FA,F8,2122, 0000,00,210D, 01F8,00,210C, 01FE,05,211D, 01F8,05,211C, 81F8,F8,210A
$A8:C00B             dx 0005, 01F8,FE,611E, 01F8,F6,610E, 01F3,00,611F, 01F3,F8,610F, 81F8,F8,6100
$A8:C026             dx 0005, 01F8,FF,611E, 01F8,F7,610E, 01F2,00,611F, 01F3,F9,610F, 81F8,F8,6102
$A8:C041             dx 0005, 01F8,00,611E, 01F7,F8,610E, 01F1,00,611F, 01F2,FA,610F, 81F8,F8,6104
$A8:C05C             dx 0005, 01F1,FE,E10D, 01F9,FE,E10C, 01EC,FF,610F, 01EB,07,611F, 81F8,F8,6100
$A8:C077             dx 0005, 01EA,0F,611F, 01EC,07,610F, 01F0,02,610D, 01F8,02,610C, 81F8,F8,6100
$A8:C092             dx 0005, 01F6,00,610D, 01FE,00,610C, 01F8,05,611D, 0000,05,611C, 81F8,F8,6106
$A8:C0AD             dx 0005, 01F7,00,610D, 01FF,00,610C, 01F9,05,611D, 0000,05,611C, 81F8,F8,6108
$A8:C0C8             dx 0005, 01F8,00,610D, 0000,00,610C, 01FA,05,611D, 0000,05,611C, 81F8,F8,610A
$A8:C0E3             dx 0006, 01FE,F8,6120, 01F6,00,610D, 01FE,00,610C, 01F8,05,611D, 0000,05,611C, 81F8,F8,6106
$A8:C103             dx 0006, 01FE,F8,6121, 01F7,00,610D, 01FF,00,610C, 01F9,05,611D, 0000,05,611C, 81F8,F8,6108
$A8:C123             dx 0006, 01FE,F8,6122, 01F8,00,610D, 0000,00,610C, 01FA,05,611D, 0000,05,611C, 81F8,F8,610A
}
}


;;; $C143..C6B2: Powamp ;;;
{
;;; $C143: Palette - enemy $E8BF (powamp) ;;;
{
$A8:C143             dw 3800, 57FF, 42F7, 0929, 00A5, 4F5A, 36B5, 2610, 1DCE, 02FF, 01BF, 000F, 0008, 03FF, 0237, 00D1
}


;;; $C163..9E: Instruction lists ;;;
{
;;; $C163: Instruction list - body - fast ;;;
{
$A8:C163             dx 0005,C675,
                        0005,C67C,
                        0005,C683,
                        80ED,C163   ; Go to $C163
}


;;; $C173: Instruction list - body - slow ;;;
{
$A8:C173             dx 0009,C675,
                        0009,C67C,
                        0009,C683,
                        80ED,C173   ; Go to $C173
}


;;; $C183: Instruction list - balloon - inflate ;;;
{
$A8:C183             dw 0001,C68A
$A8:C187             dw 0006,C691
$A8:C18B             dw 00A0,C698,
                        812F        ; Sleep
}


;;; $C191: Instruction list - balloon - deflate ;;;
{
$A8:C191             dw 0001,C698,
                        0006,C691
}


;;; $C199: Instruction list - balloon - initial ;;;
{
$A8:C199             dw 00A0,C68A,
                        812F        ; Sleep
}
}


;;; $C19F: Powamp constants ;;;
{
$A8:C19F             dw 0040 ; Travel distance when not grappled

; Wiggle table. X offsets applied for 5 frames each in a loop
$A8:C1A1             dw 0000, 0001, 0002, 0003, 0002, 0001, 0000, FFFF, FFFE, FFFD, FFFE, FFFF

$A8:C1B9             dw 0000, 0000 ; Y acceleration - rising
$A8:C1BD             dw 0000, 0000 ; Y acceleration - sinking
$A8:C1C1             dw 0001, 0000 ; Initial Y velocity - sinking
$A8:C1C5             dw FFFF, 8000 ; Initial Y velocity - rising
}


;;; $C1C9: Initialisation AI - enemy $E8BF (powamp) ;;;
{
$A8:C1C9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:C1CC BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:C1CF 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A8:C1D2 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:C1D5 A9 4D 80    LDA #$804D             ;\
$A8:C1D8 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D (nothing)
$A8:C1DB A9 01 00    LDA #$0001             ;\
$A8:C1DE 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:C1E1 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:C1E4 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:C1E7 D0 14       BNE $14    [$C1FD]     ;} If [enemy parameter 1] = 0: (body)
$A8:C1E9 A9 3C 00    LDA #$003C             ;\
$A8:C1EC 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy function timer = 60
$A8:C1EF A9 83 C2    LDA #$C283             ;\
$A8:C1F2 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C283 (deflated - resting)
$A8:C1F5 A9 73 C1    LDA #$C173             ;\
$A8:C1F8 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $C173 (body - slow)
$A8:C1FB 80 1E       BRA $1E    [$C21B]

$A8:C1FD BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\ Else ([enemy parameter 1] != 0): (balloon)
$A8:C200 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy spawn X position = [enemy X position]
$A8:C203 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:C206 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;} Enemy spawn Y position = [enemy Y position]
$A8:C209 A9 68 C5    LDA #$C568             ;\
$A8:C20C 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = RTL
$A8:C20F A9 99 C1    LDA #$C199             ;\
$A8:C212 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $C199 (balloon - initial)
$A8:C215 BD B6 0F    LDA $0FB6,x[$7E:0FB6]  ;\
$A8:C218 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy grapple travel distance = [enemy parameter 2]

$A8:C21B 6B          RTL
}


;;; $C21C: Main AI - enemy $E8BF (powamp) ;;;
{
$A8:C21C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:C21F 7C B2 0F    JMP ($0FB2,x)[$A8:C568]; Go to [enemy function]
}


;;; $C222: RTL ;;;
{
$A8:C222 6B          RTL
}


;;; $C223: Spawn powamp spike enemy projectiles ;;;
{
$A8:C223 A0 07 00    LDY #$0007             ; Y = 7

; LOOP
$A8:C226 98          TYA                    ;\
$A8:C227 5A          PHY                    ;|
$A8:C228 A0 98 D2    LDY #$D298             ;} Spawn powamp spike enemy projectile with parameter [Y] (direction)
$A8:C22B 22 27 80 86 JSL $868027[$86:8027]  ;|
$A8:C22F 7A          PLY                    ;/
$A8:C230 88          DEY                    ; Decrement Y
$A8:C231 10 F3       BPL $F3    [$C226]     ; If [Y] >= 0: go to LOOP
$A8:C233 60          RTS
}


;;; $C234: Set powamp balloon Y position ;;;
{
$A8:C234 BD 52 0F    LDA $0F52,x[$7E:0F92]  ; A = [enemy ([X] - 1) instruction list pointer]
$A8:C237 C9 91 C1    CMP #$C191             ;\
$A8:C23A 10 1E       BPL $1E    [$C25A]     ;} If [A] >= $C191 (balloon - deflate): go to BRANCH_DEFLATE
$A8:C23C 38          SEC                    ;\
$A8:C23D E9 04 00    SBC #$0004             ;|
$A8:C240 38          SEC                    ;} A = ([A] - 4 - $C183) / 2 (animation frame into inflate instruction list * 2)
$A8:C241 E9 83 C1    SBC #$C183             ;|
$A8:C244 4A          LSR A                  ;/
$A8:C245 C9 06 00    CMP #$0006             ;\
$A8:C248 30 03       BMI $03    [$C24D]     ;} If [A] >= 6:
$A8:C24A A9 00 00    LDA #$0000             ; A = 0

$A8:C24D A8          TAY                    ;\
$A8:C24E BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;|
$A8:C251 18          CLC                    ;} Enemy ([X] - 1) Y position = [enemy Y position] + [$C277 + [A]]
$A8:C252 79 77 C2    ADC $C277,y[$A8:C277]  ;|
$A8:C255 9D 3E 0F    STA $0F3E,x[$7E:0F7E]  ;/
$A8:C258 80 1C       BRA $1C    [$C276]     ; Return

; BRANCH_DEFLATE
$A8:C25A 38          SEC                    ;\
$A8:C25B E9 04 00    SBC #$0004             ;|
$A8:C25E 38          SEC                    ;} A = ([A] - 4 - $C191) / 2 (animation frame into deflate instruction list * 2)
$A8:C25F E9 91 C1    SBC #$C191             ;|
$A8:C262 4A          LSR A                  ;/
$A8:C263 C9 06 00    CMP #$0006             ;\
$A8:C266 30 03       BMI $03    [$C26B]     ;} If [A] >= 6:
$A8:C268 A9 00 00    LDA #$0000             ; A = 0

$A8:C26B A8          TAY                    ;\
$A8:C26C BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;|
$A8:C26F 18          CLC                    ;} Enemy ([X] - 1) Y position = [enemy Y position] + [$C27D + [A]]
$A8:C270 79 7D C2    ADC $C27D,y[$A8:C281]  ;|
$A8:C273 9D 3E 0F    STA $0F3E,x[$7E:0F7E]  ;/

$A8:C276 60          RTS

; Balloon Y offsets. Indexed by animation frame into inflate/deflate instruction list
$A8:C277             dw FFF4, FFF0, FFEC ; Inflate
$A8:C27D             dw FFEC, FFF0, FFF4 ; Deflate
}


;;; $C283..C5BD: Powamp functions ;;;
{
;;; $C283: Powamp function - body - deflated - resting ;;;
{
$A8:C283 DE B0 0F    DEC $0FB0,x[$7E:0FF0]  ; Decrement enemy function timer
$A8:C286 F0 02       BEQ $02    [$C28A]     ;\
$A8:C288 10 18       BPL $18    [$C2A2]     ;} If [enemy function timer] <= 0:

$A8:C28A A9 01 00    LDA #$0001             ;\
$A8:C28D 9D 54 0F    STA $0F54,x[$7E:0F94]  ;} Enemy ([X] - 1) instruction timer = 1
$A8:C290 A9 83 C1    LDA #$C183             ;\
$A8:C293 9D 52 0F    STA $0F52,x[$7E:0F92]  ;} Enemy ([X] - 1) instruction list pointer = $C183 (balloon - inflate)
$A8:C296 A9 A6 C2    LDA #$C2A6             ;\
$A8:C299 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C2A6 (inflating)
$A8:C29C A9 0A 00    LDA #$000A             ;\
$A8:C29F 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy function timer = Ah

$A8:C2A2 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C2A5 6B          RTL
}


;;; $C2A6: Powamp function - body - inflating ;;;
{
$A8:C2A6 DE B0 0F    DEC $0FB0,x[$7E:0FF0]  ; Decrement enemy function timer
$A8:C2A9 F0 02       BEQ $02    [$C2AD]     ;\
$A8:C2AB 10 1E       BPL $1E    [$C2CB]     ;} If [enemy function timer] <= 0:

$A8:C2AD A9 CF C2    LDA #$C2CF             ;\
$A8:C2B0 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C2CF (inflated - rise to target height)
$A8:C2B3 AD C5 C1    LDA $C1C5  [$A8:C1C5]  ;\
$A8:C2B6 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;|
$A8:C2B9 AD C7 C1    LDA $C1C7  [$A8:C1C7]  ;} Enemy Y velocity = -0.8000h
$A8:C2BC 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A8:C2BF A9 01 00    LDA #$0001             ;\
$A8:C2C2 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:C2C5 A9 63 C1    LDA #$C163             ;\
$A8:C2C8 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $C163 (body - fast)

$A8:C2CB 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C2CE 6B          RTL
}


;;; $C2CF: Powamp function - body - inflated - rise to target height ;;;
{
$A8:C2CF BD 8A 0F    LDA $0F8A,x[$7E:0FCA]  ;\
$A8:C2D2 89 01 00    BIT #$0001             ;} If [enemy AI handler] & 1 (grapple AI) != 0:
$A8:C2D5 F0 09       BEQ $09    [$C2E0]     ;/
$A8:C2D7 A9 E1 C3    LDA #$C3E1             ;\
$A8:C2DA 9D B2 0F    STA $0FB2,x[$7E:1072]  ;} Enemy function = $C3E1 (grappled - rise to target height)
$A8:C2DD 4C E1 C3    JMP $C3E1  [$A8:C3E1]  ; Go to $C3E1 (grappled - rise to target height)

$A8:C2E0 DE AE 0F    DEC $0FAE,x[$7E:0FEE]  ; Decrement enemy wiggle timer
$A8:C2E3 F0 02       BEQ $02    [$C2E7]     ;\
$A8:C2E5 10 27       BPL $27    [$C30E]     ;} If [enemy wiggle timer] <= 0:

$A8:C2E7 A9 05 00    LDA #$0005             ;\
$A8:C2EA 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy wiggle timer = 5
$A8:C2ED BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:C2F0 0A          ASL A                  ;|
$A8:C2F1 A8          TAY                    ;|
$A8:C2F2 BD 68 0F    LDA $0F68,x[$7E:0FA8]  ;} Enemy ([X] - 1) X position = [enemy ([X] - 1) spawn X position] + [$C1A1 + [enemy wiggle index] * 2]
$A8:C2F5 18          CLC                    ;|
$A8:C2F6 79 A1 C1    ADC $C1A1,y[$A8:C1A1]  ;|
$A8:C2F9 9D 3A 0F    STA $0F3A,x[$7E:0F7A]  ;/
$A8:C2FC 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ; Enemy X position = [enemy ([X] - 1) X position]
$A8:C2FF BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:C302 1A          INC A                  ;|
$A8:C303 C9 0C 00    CMP #$000C             ;|
$A8:C306 30 03       BMI $03    [$C30B]     ;} Enemy wiggle index = ([enemy wiggle index] + 1) % Ch
$A8:C308 A9 00 00    LDA #$0000             ;|
                                            ;|
$A8:C30B 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;/

$A8:C30E BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:C311 18          CLC                    ;|
$A8:C312 6D BB C1    ADC $C1BB  [$A8:C1BB]  ;|
$A8:C315 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy Y velocity += 0.0 >_<;
$A8:C318 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;|
$A8:C31B 6D B9 C1    ADC $C1B9  [$A8:C1B9]  ;|
$A8:C31E 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;/
$A8:C321 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A8:C324 85 14       STA $14    [$7E:0014]  ;|
$A8:C326 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;} Move enemy down by [enemy Y velocity]
$A8:C329 85 12       STA $12    [$7E:0012]  ;|
$A8:C32B 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:C32F B0 0C       BCS $0C    [$C33D]     ; If not collided with block:
$A8:C331 BD 6A 0F    LDA $0F6A,x[$7E:0FAA]  ;\
$A8:C334 38          SEC                    ;|
$A8:C335 ED 9F C1    SBC $C19F  [$A8:C19F]  ;} If [enemy ([X] - 1) spawn Y position] - 40h < [enemy Y position]: go to BRANCH_RETURN
$A8:C338 DD 7E 0F    CMP $0F7E,x[$7E:0FBE]  ;|
$A8:C33B 30 2A       BMI $2A    [$C367]     ;/

$A8:C33D BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:C340 F0 0D       BEQ $0D    [$C34F]     ;} If [enemy wiggle index] != 0:
$A8:C342 C9 06 00    CMP #$0006             ;\
$A8:C345 F0 08       BEQ $08    [$C34F]     ;} If [enemy wiggle index] != 6:
$A8:C347 A9 6B C3    LDA #$C36B             ;\
$A8:C34A 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C36B (inflated - finish wiggle)
$A8:C34D 80 18       BRA $18    [$C367]     ; Go to BRANCH_RETURN

$A8:C34F A9 00 C5    LDA #$C500             ;\
$A8:C352 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C500 (deflating)
$A8:C355 A9 0A 00    LDA #$000A             ;\
$A8:C358 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Ah
$A8:C35B A9 01 00    LDA #$0001             ;\
$A8:C35E 9D 54 0F    STA $0F54,x            ;} Enemy ([X] - 1) instruction timer = 1
$A8:C361 A9 91 C1    LDA #$C191             ;\
$A8:C364 9D 52 0F    STA $0F52,x            ;} Enemy ([X] - 1) instruction list pointer = $C191 (balloon - deflate)

; BRANCH_RETURN
$A8:C367 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C36A 6B          RTL
}


;;; $C36B: Powamp function - body - inflated - finish wiggle ;;;
{
$A8:C36B DE AE 0F    DEC $0FAE,x[$7E:0FEE]  ; Decrement enemy wiggle timer
$A8:C36E F0 02       BEQ $02    [$C372]     ;\
$A8:C370 10 4A       BPL $4A    [$C3BC]     ;} If [enemy wiggle timer] > 0: go to BRANCH_CONTINUE_RISING

$A8:C372 A9 05 00    LDA #$0005             ;\
$A8:C375 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy wiggle timer = 5
$A8:C378 BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:C37B 0A          ASL A                  ;|
$A8:C37C A8          TAY                    ;|
$A8:C37D BD 68 0F    LDA $0F68,x[$7E:0FA8]  ;} Enemy ([X] - 1) X position = [enemy ([X] - 1) spawn X position] + [$C1A1 + [enemy wiggle index] * 2]
$A8:C380 18          CLC                    ;|
$A8:C381 79 A1 C1    ADC $C1A1,y[$A8:C1A5]  ;|
$A8:C384 9D 3A 0F    STA $0F3A,x[$7E:0F7A]  ;/
$A8:C387 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ; Enemy X position = [enemy ([X] - 1) X position]
$A8:C38A BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:C38D F0 13       BEQ $13    [$C3A2]     ;} If [enemy wiggle index] != 0:
$A8:C38F C9 06 00    CMP #$0006             ;\
$A8:C392 F0 0E       BEQ $0E    [$C3A2]     ;} If [enemy wiggle index] != 6:
$A8:C394 1A          INC A                  ;\
$A8:C395 C9 0C 00    CMP #$000C             ;|
$A8:C398 30 03       BMI $03    [$C39D]     ;|
$A8:C39A A9 00 00    LDA #$0000             ;} Enemy wiggle index = ([enemy wiggle index] + 1) % Ch
                                            ;|
$A8:C39D 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;/
$A8:C3A0 80 1A       BRA $1A    [$C3BC]     ; Go to BRANCH_CONTINUE_RISING

$A8:C3A2 A9 00 C5    LDA #$C500             ;\
$A8:C3A5 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C500 (deflating)
$A8:C3A8 A9 0A 00    LDA #$000A             ;\
$A8:C3AB 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy function timer = Ah
$A8:C3AE A9 01 00    LDA #$0001             ;\
$A8:C3B1 9D 54 0F    STA $0F54,x[$7E:0F94]  ;} Enemy ([X] - 1) instruction timer = 1
$A8:C3B4 A9 91 C1    LDA #$C191             ;\
$A8:C3B7 9D 52 0F    STA $0F52,x[$7E:0F92]  ;} Enemy ([X] - 1) instruction list pointer = $C191 (balloon - deflate)
$A8:C3BA 80 21       BRA $21    [$C3DD]     ; Go to BRANCH_RETURN

; BRANCH_CONTINUE_RISING
$A8:C3BC BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:C3BF 18          CLC                    ;|
$A8:C3C0 6D BB C1    ADC $C1BB  [$A8:C1BB]  ;|
$A8:C3C3 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy Y velocity += 0.0 >_<;
$A8:C3C6 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;|
$A8:C3C9 6D B9 C1    ADC $C1B9  [$A8:C1B9]  ;|
$A8:C3CC 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;/
$A8:C3CF BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A8:C3D2 85 14       STA $14    [$7E:0014]  ;|
$A8:C3D4 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;} Move enemy down by [enemy Y velocity]
$A8:C3D7 85 12       STA $12    [$7E:0012]  ;|
$A8:C3D9 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/

; BRANCH_RETURN
$A8:C3DD 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C3E0 6B          RTL
}


;;; $C3E1: Powamp function - body - grappled - rise to target height ;;;
{
$A8:C3E1 BD 8A 0F    LDA $0F8A,x[$7E:104A]  ;\
$A8:C3E4 89 01 00    BIT #$0001             ;} If [enemy AI handler] & 1 (grapple AI) = 0:
$A8:C3E7 D0 07       BNE $07    [$C3F0]     ;/
$A8:C3E9 A9 6B C3    LDA #$C36B             ;\
$A8:C3EC 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C36B (inflated - finish wiggle)
$A8:C3EF 6B          RTL                    ; Return

$A8:C3F0 DE AE 0F    DEC $0FAE,x[$7E:106E]  ; Decrement enemy wiggle timer
$A8:C3F3 F0 02       BEQ $02    [$C3F7]     ;\
$A8:C3F5 10 27       BPL $27    [$C41E]     ;} If [enemy wiggle timer] <= 0:
                                            
$A8:C3F7 A9 05 00    LDA #$0005             ;\
$A8:C3FA 9D AE 0F    STA $0FAE,x[$7E:106E]  ;} Enemy wiggle timer = 5
$A8:C3FD BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:C400 0A          ASL A                  ;|
$A8:C401 A8          TAY                    ;|
$A8:C402 BD 68 0F    LDA $0F68,x[$7E:1028]  ;} Enemy ([X] - 1) X position = [enemy ([X] - 1) spawn X position] + [$C1A1 + [enemy wiggle index] * 2]
$A8:C405 18          CLC                    ;|
$A8:C406 79 A1 C1    ADC $C1A1,y[$A8:C1AD]  ;|
$A8:C409 9D 3A 0F    STA $0F3A,x[$7E:0FFA]  ;/
$A8:C40C 9D 7A 0F    STA $0F7A,x[$7E:103A]  ; Enemy X position = [enemy ([X] - 1) X position]
$A8:C40F BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:C412 1A          INC A                  ;|
$A8:C413 C9 0C 00    CMP #$000C             ;|
$A8:C416 30 03       BMI $03    [$C41B]     ;} Enemy wiggle index = ([enemy wiggle index] + 1) % Ch
$A8:C418 A9 00 00    LDA #$0000             ;|
                                            ;|
$A8:C41B 9D AC 0F    STA $0FAC,x[$7E:106C]  ;/

$A8:C41E BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A8:C421 18          CLC                    ;|
$A8:C422 6D BB C1    ADC $C1BB  [$A8:C1BB]  ;|
$A8:C425 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy Y velocity += 0.0 >_<;
$A8:C428 BD A8 0F    LDA $0FA8,x[$7E:1068]  ;|
$A8:C42B 6D B9 C1    ADC $C1B9  [$A8:C1B9]  ;|
$A8:C42E 9D A8 0F    STA $0FA8,x[$7E:1068]  ;/
$A8:C431 BD A8 0F    LDA $0FA8,x[$7E:1068]  ;\
$A8:C434 85 14       STA $14    [$7E:0014]  ;|
$A8:C436 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;} Move enemy down by [enemy Y velocity]
$A8:C439 85 12       STA $12    [$7E:0012]  ;|
$A8:C43B 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:C43F B0 0C       BCS $0C    [$C44D]     ; If not collided with block:
$A8:C441 BD 6A 0F    LDA $0F6A,x[$7E:102A]  ;\
$A8:C444 38          SEC                    ;|
$A8:C445 FD 6E 0F    SBC $0F6E,x[$7E:102E]  ;} If [enemy ([X] - 1) spawn Y position] - [enemy ([X] - 1) grapple travel distance] < [enemy Y position]: go to BRANCH_RETURN
$A8:C448 DD 7E 0F    CMP $0F7E,x[$7E:103E]  ;|
$A8:C44B 30 18       BMI $18    [$C465]     ;/

$A8:C44D BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:C450 F0 0D       BEQ $0D    [$C45F]     ;} If [enemy wiggle index] != 0:
$A8:C452 C9 06 00    CMP #$0006             ;\
$A8:C455 F0 08       BEQ $08    [$C45F]     ;} If [enemy wiggle index] != 6:
$A8:C457 A9 69 C4    LDA #$C469             ;\
$A8:C45A 9D B2 0F    STA $0FB2,x[$7E:1072]  ;} Enemy function = $C469 (grappled - finish wiggle)
$A8:C45D 80 06       BRA $06    [$C465]     ; Go to BRANCH_RETURN

$A8:C45F A9 DC C4    LDA #$C4DC             ;\
$A8:C462 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C4DC (grappled - resting)

; BRANCH_RETURN
$A8:C465 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C468 6B          RTL
}


;;; $C469: Powamp function - body - grappled - finish wiggle ;;;
{
$A8:C469 BD 8A 0F    LDA $0F8A,x[$7E:104A]  ;\
$A8:C46C 89 01 00    BIT #$0001             ;} If [enemy AI handler] & 1 (grapple AI) = 0:
$A8:C46F D0 07       BNE $07    [$C478]     ;/
$A8:C471 A9 6B C3    LDA #$C36B             ;\
$A8:C474 9D B2 0F    STA $0FB2,x[$7E:1072]  ;} Enemy function = $C36B (inflated - finish wiggle)
$A8:C477 6B          RTL                    ; Return

$A8:C478 DE AE 0F    DEC $0FAE,x[$7E:106E]  ; Decrement enemy wiggle timer
$A8:C47B F0 02       BEQ $02    [$C47F]     ;\
$A8:C47D 10 38       BPL $38    [$C4B7]     ;} If [enemy wiggle timer] > 0: go to BRANCH_CONTINUE_RISING

$A8:C47F A9 05 00    LDA #$0005             ;\
$A8:C482 9D AE 0F    STA $0FAE,x[$7E:106E]  ;} Enemy wiggle timer = 5
$A8:C485 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:C488 0A          ASL A                  ;|
$A8:C489 A8          TAY                    ;|
$A8:C48A BD 68 0F    LDA $0F68,x[$7E:1028]  ;} Enemy ([X] - 1) X position = [enemy ([X] - 1) spawn X position] + [$C1A1 + [enemy wiggle index] * 2]
$A8:C48D 18          CLC                    ;|
$A8:C48E 79 A1 C1    ADC $C1A1,y[$A8:C1A3]  ;|
$A8:C491 9D 3A 0F    STA $0F3A,x[$7E:0FFA]  ;/
$A8:C494 9D 7A 0F    STA $0F7A,x[$7E:103A]  ; Enemy X position = [enemy ([X] - 1) X position]
$A8:C497 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:C49A F0 13       BEQ $13    [$C4AF]     ;} If [enemy wiggle index] != 0:
$A8:C49C C9 06 00    CMP #$0006             ;\
$A8:C49F F0 0E       BEQ $0E    [$C4AF]     ;} If [enemy wiggle index] != 6:
$A8:C4A1 1A          INC A                  ;\
$A8:C4A2 C9 0C 00    CMP #$000C             ;|
$A8:C4A5 30 03       BMI $03    [$C4AA]     ;|
$A8:C4A7 A9 00 00    LDA #$0000             ;} Enemy wiggle index = ([enemy wiggle index] + 1) % Ch
                                            ;|
$A8:C4AA 9D AC 0F    STA $0FAC,x[$7E:106C]  ;/
$A8:C4AD 80 08       BRA $08    [$C4B7]     ; Go to BRANCH_CONTINUE_RISING

$A8:C4AF A9 DC C4    LDA #$C4DC             ;\
$A8:C4B2 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C4DC (grappled - resting)
$A8:C4B5 80 21       BRA $21    [$C4D8]     ; Go to BRANCH_RETURN

; BRANCH_CONTINUE_RISING
$A8:C4B7 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;\
$A8:C4BA 18          CLC                    ;|
$A8:C4BB 6D BB C1    ADC $C1BB  [$A8:C1BB]  ;|
$A8:C4BE 9D AA 0F    STA $0FAA,x[$7E:106A]  ;} Enemy Y velocity += 0.0 >_<;
$A8:C4C1 BD A8 0F    LDA $0FA8,x[$7E:1068]  ;|
$A8:C4C4 6D B9 C1    ADC $C1B9  [$A8:C1B9]  ;|
$A8:C4C7 9D A8 0F    STA $0FA8,x[$7E:1068]  ;/
$A8:C4CA BD A8 0F    LDA $0FA8,x[$7E:1068]  ;\
$A8:C4CD 85 14       STA $14    [$7E:0014]  ;|
$A8:C4CF BD AA 0F    LDA $0FAA,x[$7E:106A]  ;} Move enemy down by [enemy Y velocity]
$A8:C4D2 85 12       STA $12    [$7E:0012]  ;|
$A8:C4D4 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/

; BRANCH_RETURN
$A8:C4D8 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C4DB 6B          RTL
}


;;; $C4DC: Powamp function - body - grappled - resting ;;;
{
$A8:C4DC BD 8A 0F    LDA $0F8A,x            ;\
$A8:C4DF 89 01 00    BIT #$0001             ;} If [enemy AI handler] & 1 (grapple AI) = 0:
$A8:C4E2 D0 18       BNE $18    [$C4FC]     ;/
$A8:C4E4 A9 00 C5    LDA #$C500             ;\
$A8:C4E7 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C500 (deflating)
$A8:C4EA A9 0A 00    LDA #$000A             ;\
$A8:C4ED 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = Ah
$A8:C4F0 A9 01 00    LDA #$0001             ;\
$A8:C4F3 9D 54 0F    STA $0F54,x            ;} Enemy ([X] - 1) instruction timer = 1
$A8:C4F6 A9 91 C1    LDA #$C191             ;\
$A8:C4F9 9D 52 0F    STA $0F52,x            ;} Enemy ([X] - 1) instruction list pointer = $C191 (balloon - deflate)

$A8:C4FC 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C4FF 6B          RTL
}


;;; $C500: Powamp function - body - deflating ;;;
{
$A8:C500 DE B0 0F    DEC $0FB0,x[$7E:0FF0]  ; Decrement enemy function timer
$A8:C503 F0 02       BEQ $02    [$C507]     ;\
$A8:C505 10 12       BPL $12    [$C519]     ;} If [enemy function timer] <= 0:

$A8:C507 A9 1D C5    LDA #$C51D             ;\
$A8:C50A 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C51D (deflated - sinking)
$A8:C50D AD C1 C1    LDA $C1C1  [$A8:C1C1]  ;\
$A8:C510 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;|
$A8:C513 AD C3 C1    LDA $C1C3  [$A8:C1C3]  ;} Enemy Y velocity = 1.0
$A8:C516 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/

$A8:C519 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C51C 6B          RTL
}


;;; $C51D: Powamp function - body - deflated - sinking ;;;
{
$A8:C51D BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:C520 18          CLC                    ;|
$A8:C521 6D BF C1    ADC $C1BF  [$A8:C1BF]  ;|
$A8:C524 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy Y velocity += 0.0 >_<;
$A8:C527 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;|
$A8:C52A 6D BD C1    ADC $C1BD  [$A8:C1BD]  ;|
$A8:C52D 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;/
$A8:C530 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A8:C533 85 14       STA $14    [$7E:0014]  ;|
$A8:C535 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;} Move enemy down by [enemy Y velocity]
$A8:C538 85 12       STA $12    [$7E:0012]  ;|
$A8:C53A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:C53E BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A8:C541 DD 6A 0F    CMP $0F6A,x[$7E:0FAA]  ;} If [enemy Y position] >= [enemy ([X] - 1) spawn Y position]:
$A8:C544 30 1E       BMI $1E    [$C564]     ;/
$A8:C546 BD 6A 0F    LDA $0F6A,x[$7E:0FAA]  ;\
$A8:C549 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy ([X] - 1) spawn Y position]
$A8:C54C A9 83 C2    LDA #$C283             ;\
$A8:C54F 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function = $C283 (deflated - resting)
$A8:C552 A9 3C 00    LDA #$003C             ;\
$A8:C555 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ;} Enemy function timer = 60
$A8:C558 A9 01 00    LDA #$0001             ;\
$A8:C55B 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:C55E A9 73 C1    LDA #$C173             ;\
$A8:C561 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $C173 (body - slow)

$A8:C564 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C567 6B          RTL
}


;;; $C568: RTL ;;;
{
$A8:C568 6B          RTL
}


;;; $C569: Powamp function - body - fatal damage ;;;
{
$A8:C569 BD 52 0F    LDA $0F52,x            ; A = [enemy ([X] - 1) instruction list pointer]
$A8:C56C C9 91 C1    CMP #$C191             ;\
$A8:C56F 30 18       BMI $18    [$C589]     ;} If [A] >= $C191 (balloon - deflate):
$A8:C571 38          SEC                    ;\
$A8:C572 E9 04 00    SBC #$0004             ;|
$A8:C575 38          SEC                    ;} A = ([A] - 4 - $C191) / 2 (animation frame into deflate instruction list * 2)
$A8:C576 E9 91 C1    SBC #$C191             ;|
$A8:C579 4A          LSR A                  ;/
$A8:C57A F0 0D       BEQ $0D    [$C589]     ; If [A] != 0:
$A8:C57C A8          TAY                    ;\
$A8:C57D B9 99 C5    LDA $C599,y            ;} Enemy ([X] - 1) instruction list pointer = [$C599 + [A]]
$A8:C580 9D 52 0F    STA $0F52,x            ;/
$A8:C583 A9 01 00    LDA #$0001             ;\
$A8:C586 9D 54 0F    STA $0F54,x            ;} Enemy ([X] - 1) instruction timer = 1

$A8:C589 A9 9F C5    LDA #$C59F             ;\
$A8:C58C 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C59F (death sequence)
$A8:C58F A9 20 00    LDA #$0020             ;\
$A8:C592 9D B0 0F    STA $0FB0,x            ;} Enemy function timer = 20h
$A8:C595 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C598 6B          RTL

; Pointers to animation frames in inflate instruction list
$A8:C599             dw C18B, C187, C183
}


;;; $C59F: Powamp function - body - death sequence ;;;
{
$A8:C59F DE B0 0F    DEC $0FB0,x            ; Decrement enemy function timer
$A8:C5A2 F0 02       BEQ $02    [$C5A6]     ;\
$A8:C5A4 10 14       BPL $14    [$C5BA]     ;} If [enemy function timer] <= 0:

$A8:C5A6 9E 4C 0F    STZ $0F4C,x            ; Enemy ([X] - 1) health = 0
$A8:C5A9 BD 46 0F    LDA $0F46,x            ;\
$A8:C5AC 09 00 02    ORA #$0200             ;} Mark enemy ([X] - 1) for deletion
$A8:C5AF 9D 46 0F    STA $0F46,x            ;/
$A8:C5B2 20 23 C2    JSR $C223  [$A8:C223]  ; Spawn powamp spike enemy projectiles
$A8:C5B5 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Enemy death (with garbage in A)
$A8:C5B9 6B          RTL                    ; Return

$A8:C5BA 20 34 C2    JSR $C234  [$A8:C234]  ; Set powamp balloon Y position
$A8:C5BD 6B          RTL
}
}


;;; $C5BE: Enemy touch - enemy $E8BF (powamp) ;;;
{
$A8:C5BE AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:C5C1 BD B6 0F    LDA $0FB6,x[$7E:1076]  ;\
$A8:C5C4 D0 28       BNE $28    [$C5EE]     ;} If [enemy parameter 2] != 0 (body): return
$A8:C5C6 BD 96 0F    LDA $0F96,x[$7E:1056]  ;\
$A8:C5C9 48          PHA                    ;} A = [enemy palette index]
$A8:C5CA 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A8:C5CE AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:C5D1 BD 8C 0F    LDA $0F8C,x[$7E:104C]  ;\
$A8:C5D4 F0 02       BEQ $02    [$C5D8]     ;} If [enemy health] != 0:
$A8:C5D6 68          PLA                    ;\
$A8:C5D7 6B          RTL                    ;} Return

$A8:C5D8 BD 46 0F    LDA $0F46,x            ;\
$A8:C5DB 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$A8:C5DE 9D 46 0F    STA $0F46,x            ;/
$A8:C5E1 68          PLA                    ;\
$A8:C5E2 9D 96 0F    STA $0F96,x            ;} Enemy palette index = [A]
$A8:C5E5 20 23 C2    JSR $C223  [$A8:C223]  ; Spawn powamp spike enemy projectiles
$A8:C5E8 A9 00 0A    LDA #$0A00             ;\
$A8:C5EB 9D 96 0F    STA $0F96,x            ;} Enemy palette index = A00h (palette 5)

$A8:C5EE 6B          RTL
}


;;; $C5EF: Enemy shot - enemy $E8BF (powamp) ;;;
{
$A8:C5EF 8B          PHB
$A8:C5F0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:C5F3 BD B6 0F    LDA $0FB6,x            ;\
$A8:C5F6 F0 02       BEQ $02    [$C5FA]     ;} If [enemy parameter 2] != 0 (body):
$A8:C5F8 AB          PLB
$A8:C5F9 6B          RTL                    ; Return

$A8:C5FA 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI - no death check, no enemy shot graphic
$A8:C5FE BD 8A 0F    LDA $0F8A,x            ;\
$A8:C601 89 04 00    BIT #$0004             ;} If [enemy AI handler] & 4 (frozen AI) != 0:
$A8:C604 F0 0F       BEQ $0F    [$C615]     ;/
$A8:C606 BD 9E 0F    LDA $0F9E,x            ;\
$A8:C609 9D 5E 0F    STA $0F5E,x            ;} Enemy ([X] - 1) frozen timer = [enemy frozen timer]
$A8:C60C BD 4A 0F    LDA $0F4A,x            ;\
$A8:C60F 09 04 00    ORA #$0004             ;} Set enemy ([X] - 1) frozen AI
$A8:C612 9D 4A 0F    STA $0F4A,x            ;/

$A8:C615 BD 8A 0F    LDA $0F8A,x            ;\
$A8:C618 89 02 00    BIT #$0002             ;} If [enemy AI handler] & 2 (hurt AI) != 0:
$A8:C61B F0 0F       BEQ $0F    [$C62C]     ;/
$A8:C61D BD 9C 0F    LDA $0F9C,x            ;\
$A8:C620 9D 5C 0F    STA $0F5C,x            ;} Enemy ([X] - 1) flash timer = [enemy flash timer]
$A8:C623 BD 4A 0F    LDA $0F4A,x            ;\
$A8:C626 09 02 00    ORA #$0002             ;} Set enemy ([X] - 1) hurt AI
$A8:C629 9D 4A 0F    STA $0F4A,x            ;/

$A8:C62C BD 8C 0F    LDA $0F8C,x            ;\
$A8:C62F D0 0C       BNE $0C    [$C63D]     ;} If [enemy health] = 0:
$A8:C631 A9 69 C5    LDA #$C569             ;\
$A8:C634 9D B2 0F    STA $0FB2,x            ;} Enemy function = $C569 (fatal damage)
$A8:C637 A9 01 00    LDA #$0001             ;\
$A8:C63A 9D B6 0F    STA $0FB6,x            ;} Enemy parameter 2 = 1

$A8:C63D AB          PLB
$A8:C63E 6B          RTL
}


;;; $C63F: Power bomb reaction - enemy $E8BF (powamp) ;;;
{
$A8:C63F 22 37 80 A8 JSL $A88037[$A8:8037]  ; Normal enemy power bomb AI
$A8:C643 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:C646 BD 8C 0F    LDA $0F8C,x            ;\
$A8:C649 D0 0B       BNE $0B    [$C656]     ;} If [enemy health] = 0:
$A8:C64B BD 46 0F    LDA $0F46,x            ;\
$A8:C64E 09 00 02    ORA #$0200             ;} Mark enemy ([X] - 1) for deletion
$A8:C651 9D 46 0F    STA $0F46,x            ;/
$A8:C654 80 1E       BRA $1E    [$C674]     ; Return

$A8:C656 BD A2 0F    LDA $0FA2,x            ;\
$A8:C659 9D 62 0F    STA $0F62,x            ;} Enemy ([X] - 1) shake timer = [enemy shake timer]
$A8:C65C BD A0 0F    LDA $0FA0,x            ;\
$A8:C65F 9D 60 0F    STA $0F60,x            ;} Enemy ([X] - 1) invincibility timer = [enemy invincibility timer]
$A8:C662 BD 9C 0F    LDA $0F9C,x            ;\
$A8:C665 9D 5C 0F    STA $0F5C,x            ;} Enemy ([X] - 1) flash timer = [enemy flash timer]
$A8:C668 BD 9E 0F    LDA $0F9E,x            ;\
$A8:C66B 9D 5E 0F    STA $0F5E,x            ;} Enemy ([X] - 1) frozen timer = [enemy frozen timer]
$A8:C66E BD 8A 0F    LDA $0F8A,x            ;\
$A8:C671 9D 4A 0F    STA $0F4A,x            ;} Enemy ([X] - 1) AI handler = [enemy AI handler]

$A8:C674 6B          RTL
}


;;; $C675: Powamp spritemaps ;;;
{
; Body
$A8:C675             dx 0001, 81F8,F8,2100
$A8:C67C             dx 0001, 81F8,F8,2102
$A8:C683             dx 0001, 81F8,F8,2104

; Balloon
$A8:C68A             dx 0001, 01FC,FC,210E
$A8:C691             dx 0001, 81F8,F8,2106
$A8:C698             dx 0005, 0004,04,210D, 01FC,04,210C, 01F4,04,210B, 81FC,F4,2109, 81F4,F4,2108
}
}


;;; $C6B3..D820: Work robot ;;;
{
;;; $C6B3: Palette - enemy $E8FF/$E93F (work robot) ;;;
{
$A8:C6B3             dw 3800, 57FF, 42F7, 0929, 00A5, 4F5A, 36B5, 2610, 1DCE, 001F, 0018, 000F, 0008, 000A, 03FF, 02B5
}


;;; $C6D3..C6E4: Instruction lists - work robot deactivated ;;;
{
;;; $C6D3: Instruction list - work robot deactivated - neutral ;;;
{
$A8:C6D3             dx 7FFF,D7E1,
                        812F        ; Sleep
}


;;; $C6D9: Instruction list - work robot deactivated - leaning left ;;;
{
$A8:C6D9             dx 7FFF,D7C1,
                        812F        ; Sleep
}


;;; $C6DF: Instruction list - work robot deactivated - leaning right ;;;
{
$A8:C6DF             dx 7FFF,D801,
                        812F        ; Sleep
}
}


;;; $C6E5..CB76: Instruction lists - work robot ;;;
{
;;; $C6E5: Instruction list - initial ;;;
{
$A8:C6E5             dx 0020,D22F
}


;;; $C6E9: Instruction list - facing left - walking forwards ;;;
{
$A8:C6E9             dx 0001,D22F,
$A8:C6ED             dx 000A,D22F,
                        0001,D26D,
                        D107,       ; Try shooting laser horizontally and go to $C8BD if so
                        0009,D26D,
                        0001,D2AB,
                        D0D2,       ; Try shooting laser up-left and go to $C8D1 if so
                        0009,D2AB,
                        000A,D2E9,
                        D091,       ; Queue work robot sound effect if on screen
                        CD09,       ; Facing left - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        000A,D327,
                        CD09,       ; Facing left - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        000A,D365,
                        000A,D3A3,
                        000A,D3E1,
                        000A,D41F,
                        000A,D45D,
                        CD09,       ; Facing left - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        D091,       ; Queue work robot sound effect if on screen
                        000A,D49B,
                        CD09,       ; Facing left - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        0001,D1F1,
                        D13D,       ; Try shooting laser down-left and go to $C8B1 if so
                        0009,D1F1,
                        80ED,C6ED   ; Go to $C6ED
}


;;; $C73F: Instruction list - facing left - hit wall moving forwards ;;;
{
$A8:C73F             dx 0001,D49B,
                        000A,D49B,
                        D091,       ; Queue work robot sound effect if on screen
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D45D,
                        000A,D41F,
                        000A,D3E1,
                        000A,D3A3,
                        000A,D365,
                        D091,       ; Queue work robot sound effect if on screen
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D327,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D2E9,
                        000A,D2AB,
                        000A,D26D,
                        000A,D22F,
                        000A,D1F1,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        D091,       ; Queue work robot sound effect if on screen
                        000A,D49B,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D45D,
                        000A,D41F,
                        000A,D3E1,
                        000A,D3A3,
                        000A,D365,
                        D091,       ; Queue work robot sound effect if on screen
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D327,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D2E9,
                        000A,D2AB,
                        000A,D26D,
                        000A,D22F,
                        000A,D1F1,
                        CECB        ; Go to $C92D (facing right - walking forwards)
}


;;; $C7BB: Instruction list - facing left - shot - Samus is ahead ;;;
{
$A8:C7BB             dx 0005,D49B,
                        D091,       ; Queue work robot sound effect if on screen
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        0005,D45D,
                        0005,D41F,
                        0005,D3E1,
                        0005,D3A3,
                        0005,D365,
                        D091,       ; Queue work robot sound effect if on screen
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        0005,D327,
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        0005,D2E9,
                        0005,D2AB,
                        0005,D26D,
                        0005,D22F,
                        0005,D1F1,
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D49B,
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        0005,D45D,
                        0005,D41F,
                        0005,D3E1,
                        0005,D3A3,
                        0005,D365,
                        D091,       ; Queue work robot sound effect if on screen
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        0005,D327,
                        CE85,       ; Facing left - move backwards, go to $C6E9 if hit wall
                        0005,D2E9,
                        0005,D2AB,
                        0005,D26D,
                        0005,D22F,
                        0005,D1F1,
                        CECB        ; Go to $C92D (facing right - walking forwards)
}


;;; $C833: Instruction list - facing left - shot - Samus is behind ;;;
{
$A8:C833             dx D091,       ; Queue work robot sound effect if on screen
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D22F,
                        0005,D26D,
                        0005,D2AB,
                        0005,D2E9,
                        D091,       ; Queue work robot sound effect if on screen
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D327,
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D365,
                        0005,D3A3,
                        0005,D3E1,
                        0005,D41F,
                        0005,D45D,
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D49B,
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D1F1,
                        0005,D22F,
                        0005,D26D,
                        0005,D2AB,
                        0005,D2E9,
                        D091,       ; Queue work robot sound effect if on screen
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D327,
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D365,
                        0005,D3A3,
                        0005,D3E1,
                        0005,D41F,
                        0005,D45D,
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D49B,
                        CDA4,       ; Facing left - move forwards, go to $C73F if hit wall
                        0005,D1F1,
                        D0C2        ; Go to $C6E9 (facing left - walking forwards)
}


;;; $C8B1: Instruction list - facing left - shot laser down-left ;;;
{
$A8:C8B1             dx 0005,D1F1,
                        0002,D49B,
                        80ED,C8E9   ; Go to $C8E9 (facing left - laser shot recoil)
}


;;; $C8BD: Instruction list - facing left - shot laser left ;;;
{
$A8:C8BD             dx 0005,D22F,
                        0002,D1F1,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        D091,       ; Queue work robot sound effect if on screen
                        000A,D49B,
                        80ED,C8E9   ; Go to $C8E9 (facing left - laser shot recoil)
}


;;; $C8D1: Instruction list - facing left - shot laser up-left ;;;
{
$A8:C8D1             dx 0005,D2AB,
                        0002,D26D,
                        0002,D22F,
                        0004,D1F1,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        D091,       ; Queue work robot sound effect if on screen
                        0004,D49B
}


;;; $C8E9: Instruction list - facing left - laser shot recoil ;;;
{
$A8:C8E9             dx CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        0010,D45D,
                        0005,D41F,
                        0005,D3E1,
                        0005,D3A3,
                        0005,D365,
                        D091,       ; Queue work robot sound effect if on screen
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D327,
                        CDEA,       ; Facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D2E9,
                        000A,D2AB,
                        0060,D26D,
                        D16B,       ; Decrement enemy laser cooldown
                        80ED,C6E9   ; Go to $C6E9 (facing left - walking forwards)
}


;;; $C91B: Instruction list - approaching a fall to the right ;;;
{
$A8:C91B             dx 0080,D4D9,
                        000A,D517,
                        000A,D555,
                        D16B,       ; Decrement enemy laser cooldown
                        80ED,C6E9   ; Go to $C6E9 (facing left - walking forwards)
}


;;; $C92D: Instruction list - facing right - walking forwards ;;;
{
$A8:C92D             dx 0001,D4D9,
$A8:C931             dx 0001,D4D9,
                        D131,       ; Try shooting laser down-right and go to $CAFD if so
                        0009,D4D9,
                        D16B,       ; Decrement enemy laser cooldown
                        000A,D517,
                        0001,D555,
                        D100,       ; Try shooting laser horizontally and go to $CB09 if so
                        0009,D555,
                        0001,D593,
                        D0C6,       ; Try shooting laser up-right and go to $CB1D if so
                        0009,D593,
                        000A,D5D1,
                        D091,       ; Queue work robot sound effect if on screen
                        CECF,       ; Facing right - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        000A,D60F,
                        CECF,       ; Facing right - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        000A,D64D,
                        000A,D68B,
                        000A,D6C9,
                        000A,D707,
                        000A,D745,
                        CECF,       ; Facing right - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        D091,       ; Queue work robot sound effect if on screen
                        000A,D783,
                        CECF,       ; Facing right - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall
                        80ED,C931   ; Go to $C931
}


;;; $C985: Instruction list - facing right - hit wall moving forwards ;;;
{
$A8:C985             dx 0001,D783,
                        000A,D783,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D745,
                        000A,D707,
                        000A,D6C9,
                        000A,D68B,
                        000A,D64D,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D60F,
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D5D1,
                        000A,D593,
                        000A,D555,
                        000A,D517,
                        000A,D4D9,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D783,
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D745,
                        000A,D707,
                        000A,D6C9,
                        000A,D68B,
                        000A,D64D,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D60F,
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D5D1,
                        000A,D593,
                        000A,D555,
                        000A,D517,
                        000A,D4D9,
                        D0C2        ; Go to $C6E9 (facing left - walking forwards)
}


;;; $CA01: Instruction list - facing right - shot - Samus is ahead ;;;
{
$A8:CA01             dx 0001,D783,
                        0005,D783,
                        D091,       ; Queue work robot sound effect if on screen
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        0005,D745,
                        0005,D707,
                        0005,D6C9,
                        0005,D68B,
                        0005,D64D,
                        D091,       ; Queue work robot sound effect if on screen
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        0005,D60F,
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        0005,D5D1,
                        0005,D593,
                        0005,D555,
                        0005,D517,
                        0005,D4D9,
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D783,
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        0005,D745,
                        0005,D707,
                        0005,D6C9,
                        0005,D68B,
                        0005,D64D,
                        D091,       ; Queue work robot sound effect if on screen
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        000A,D60F,
                        D04B,       ; Facing right - move backwards, go to $C6E9 if hit wall
                        0005,D5D1,
                        0005,D593,
                        0005,D555,
                        0005,D517,
                        0005,D4D9,
                        D0C2        ; Go to $C6E9 (facing left - walking forwards)
}


;;; $CA7D: Instruction list - facing right - shot - Samus is behind ;;;
{
$A8:CA7D             dx CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D4D9,
                        0005,D517,
                        0005,D555,
                        0005,D593,
                        0005,D5D1,
                        D091,       ; Queue work robot sound effect if on screen
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        0005,D60F,
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D64D,
                        0005,D68B,
                        0005,D6C9,
                        0005,D707,
                        0005,D745,
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D783,
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        0005,D4D9,
                        0005,D517,
                        0005,D555,
                        0005,D593,
                        0005,D5D1,
                        D091,       ; Queue work robot sound effect if on screen
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        0005,D60F,
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        0005,D64D,
                        0005,D68B,
                        0005,D6C9,
                        0005,D707,
                        0005,D745,
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        D091,       ; Queue work robot sound effect if on screen
                        0005,D783,
                        CF6A,       ; Facing right - move forwards, go to $C73F if hit wall
                        CECB        ; Go to $C92D (facing right - walking forwards)
}


;;; $CAFD: Instruction list - facing right - shot laser down-right ;;;
{
$A8:CAFD             dx 0005,D4D9,
                        0002,D783,
                        80ED,CB35   ; Go to $CB35 (facing right - laser shot recoil)
}


;;; $CB09: Instruction list - facing right - shot laser right ;;;
{
$A8:CB09             dx 0005,D517,
                        0002,D4D9,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D783,
                        80ED,CB35   ; Go to $CB35 (facing right - laser shot recoil)
}


;;; $CB1D: Instruction list - facing right - shot laser up-right ;;;
{
$A8:CB1D             dx 0005,D593,
                        0002,D555,
                        0002,D517,
                        0004,D4D9,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        0004,D783
}


;;; $CB35: Instruction list - facing right - laser shot recoil ;;;
{
$A8:CB35             dx CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        0010,D745,
                        0005,D707,
                        0005,D6C9,
                        0005,D68B,
                        0005,D64D,
                        D091,       ; Queue work robot sound effect if on screen
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D60F,
                        CFB0,       ; Facing right - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall
                        000A,D5D1,
                        000A,D593,
                        0060,D555,
                        80ED,C92D   ; Go to $C92D (facing right - walking forwards)
}


;;; $CB65: Instruction list - approaching a fall to the left ;;;
{
$A8:CB65             dx 0080,D1F1,
                        000A,D22F,
                        000A,D26D,
                        D16B,       ; Decrement enemy laser cooldown
                        80ED,C92D   ; Go to $C92D (facing right - walking forwards)
}
}


;;; $CB77: Initialisation AI - enemy $E8FF (work robot) ;;;
{
$A8:CB77 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A8:CB7A BF 28 D8 7E LDA $7ED828,x[$7E:D82B];|
$A8:CB7E 89 01 00    BIT #$0001             ;} If area boss is not dead: go to initialisation AI - enemy $E93F (work robot deactivated)
$A8:CB81 F0 49       BEQ $49    [$CBCC]     ;|
$A8:CB83 AE 54 0E    LDX $0E54  [$7E:0E54]  ;/
$A8:CB86 E2 20       SEP #$20               ;\
$A8:CB88 A9 A8       LDA #$A8               ;|
$A8:CB8A 8D 8E 17    STA $178E  [$7E:178E]  ;|
$A8:CB8D C2 20       REP #$20               ;} Enemy graphics drawn hook = $A8:CC67
$A8:CB8F A9 67 CC    LDA #$CC67             ;|
$A8:CB92 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A8:CB95 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:CB98 09 00 A0    ORA #$A000             ;} Set enemy hitbox as solid
$A8:CB9B 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:CB9E A9 04 00    LDA #$0004             ;\
$A8:CBA1 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:CBA4 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:CBA7 A9 E5 C6    LDA #$C6E5             ;\
$A8:CBAA 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $C6E5
$A8:CBAD A9 00 FE    LDA #$FE00             ;\
$A8:CBB0 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = -200h
$A8:CBB3 A9 01 00    LDA #$0001             ;\
$A8:CBB6 8F 54 D6 7E STA $7ED654[$7E:D654]  ;} Work robot palette animation timer = 1
$A8:CBBA A9 00 00    LDA #$0000             ;\
$A8:CBBD 8F 56 D6 7E STA $7ED656[$7E:D656]  ;} Work robot palette animation table index = 0
$A8:CBC1 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ; Enemy laser cooldown = 0
$A8:CBC4 BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A8:CBC7 8F 52 D6 7E STA $7ED652[$7E:D652]  ;} Work robot palette animation palette index = [enemy palette index]
$A8:CBCB 6B          RTL
}


;;; $CBCC: Initialisation AI - enemy $E93F (work robot deactivated) ;;;
{
; The colour writes at $A8:CC1C have no effect for multiple reasons:
;     It writes to the active palette RAM instead of the target palette RAM, so room fade in immediately overwrites any changes
;     $7E:D652 is 0 until an *activated* robot gets initialised, so this effectively hardcodes the palette index to 0, but the robots never use palette 0
;     Even if there was an activated robot loaded at some point in some previous room, that robot's palette index would be unrelated to the current room's one
;     It wouldn't have any effect if there was an activated robot in the same room either, due to the active palette animation
;     In the pre-Phantoon hall, they use the roach's palette, so it has yellow eyes in that room(!)

$A8:CBCC AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CBCF BD B4 0F    LDA $0FB4,x[$7E:14B4]  ;\
$A8:CBD2 C9 00 00    CMP #$0000             ;} If [enemy parameter 1] >= 0:
$A8:CBD5 30 05       BMI $05    [$CBDC]     ;/
$A8:CBD7 C9 04 00    CMP #$0004             ;\
$A8:CBDA 30 03       BMI $03    [$CBDF]     ;} If [enemy parameter 1] < 4: go to BRANCH_VALID

$A8:CBDC A9 00 00    LDA #$0000             ; Enemy parameter 1 = 0

; BRANCH_VALID
$A8:CBDF 9D B4 0F    STA $0FB4,x[$7E:14B4]
$A8:CBE2 0A          ASL A                  ;\
$A8:CBE3 A8          TAY                    ;|
$A8:CBE4 B9 30 CC    LDA $CC30,y[$A8:CC32]  ;} Enemy instruction list pointer = [$CC30 + [enemy parameter 1] * 2]
$A8:CBE7 9D 92 0F    STA $0F92,x[$7E:1492]  ;/
$A8:CBEA BD 86 0F    LDA $0F86,x[$7E:1486]  ;\
$A8:CBED 09 00 80    ORA #$8000             ;} Set enemy hitbox as solid
$A8:CBF0 9D 86 0F    STA $0F86,x[$7E:1486]  ;/
$A8:CBF3 A9 01 00    LDA #$0001             ;\
$A8:CBF6 9D 94 0F    STA $0F94,x[$7E:1494]  ;} Enemy instruction timer = 1
$A8:CBF9 9E 90 0F    STZ $0F90,x[$7E:1490]  ; Enemy timer = 0
$A8:CBFC A9 00 00    LDA #$0000             ;\
$A8:CBFF 8F 54 D6 7E STA $7ED654[$7E:D654]  ;} Work robot palette animation timer = 0
$A8:CC03 A9 00 00    LDA #$0000             ;\
$A8:CC06 9D B0 0F    STA $0FB0,x[$7E:14B0]  ;|
$A8:CC09 A9 01 00    LDA #$0001             ;} Enemy Y velocity = 1.0
$A8:CC0C 9D B2 0F    STA $0FB2,x[$7E:14B2]  ;/
$A8:CC0F AF 52 D6 7E LDA $7ED652[$7E:D652]  ;\
$A8:CC13 29 00 FF    AND #$FF00             ;|
$A8:CC16 EB          XBA                    ;|
$A8:CC17 0A          ASL A                  ;|
$A8:CC18 0A          ASL A                  ;} X = [work robot palette animation palette index] / 200h * 20h (WRAM palette index)
$A8:CC19 0A          ASL A                  ;|
$A8:CC1A 0A          ASL A                  ;|
$A8:CC1B AA          TAX                    ;/
$A8:CC1C A9 0A 00    LDA #$000A             ;\
$A8:CC1F 9F 12 C1 7E STA $7EC112,x[$7E:C112];|
$A8:CC23 9F 14 C1 7E STA $7EC114,x[$7E:C114];} Palette [X] colours 9..Ch = (Ah, 0, 0) (dark red) <-- has no effect
$A8:CC27 9F 16 C1 7E STA $7EC116,x[$7E:C116];|
$A8:CC2B 9F 18 C1 7E STA $7EC118,x[$7E:C118];/
$A8:CC2F 6B          RTL

; Instruction list pointers. Indexed by [enemy parameter 1] * 2
$A8:CC30             dw C6D3, ; 0: Neutral
                        C6D9, ; 1: Leaning left
                        C6DF  ; 2: Leaning right
}


;;; $CC36: Main AI - enemy $E8FF (work robot) ;;;
{
$A8:CC36 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CC39 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A8:CC3C 85 12       STA $12    [$7E:0012]  ;|
$A8:CC3E BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;} Move enemy down by [enemy Y velocity]
$A8:CC41 85 14       STA $14    [$7E:0014]  ;|
$A8:CC43 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:CC47 B0 1D       BCS $1D    [$CC66]     ; If collided with block: return
$A8:CC49 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CC4C BD 94 0F    LDA $0F94,x[$7E:0F94]  ;\
$A8:CC4F 1A          INC A                  ;} Increment enemy instruction timer
$A8:CC50 9D 94 0F    STA $0F94,x[$7E:0F94]  ;/
$A8:CC53 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A8:CC56 18          CLC                    ;|
$A8:CC57 69 00 80    ADC #$8000             ;|
$A8:CC5A 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Enemy Y velocity += 0.8000h
$A8:CC5D BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;|
$A8:CC60 69 00 00    ADC #$0000             ;|
$A8:CC63 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;/
}


;;; $CC66: RTL. Main AI - enemy $E93F (work robot deactivated) ;;;
{
$A8:CC66 6B          RTL
}


;;; $CC67: Enemy graphics drawn hook - work robot - periodically cycle between palettes ;;;
{
$A8:CC67 AD 97 07    LDA $0797  [$7E:0797]  ;\
$A8:CC6A D0 4F       BNE $4F    [$CCBB]     ;} If currently transitioning the room: return
$A8:CC6C AF 54 D6 7E LDA $7ED654[$7E:D654]  ;\
$A8:CC70 F0 49       BEQ $49    [$CCBB]     ;} If [work robot palette animation timer] = 0: return
$A8:CC72 3A          DEC A                  ;\
$A8:CC73 8F 54 D6 7E STA $7ED654[$7E:D654]  ;} Decrement work robot palette animation timer
$A8:CC77 D0 42       BNE $42    [$CCBB]     ; If [work robot palette animation timer] != 0: return
$A8:CC79 DA          PHX
$A8:CC7A AF 52 D6 7E LDA $7ED652[$7E:D652]  ;\
$A8:CC7E 29 00 FF    AND #$FF00             ;|
$A8:CC81 EB          XBA                    ;|
$A8:CC82 0A          ASL A                  ;|
$A8:CC83 0A          ASL A                  ;} X = [work robot palette animation palette index] / 200h * 20h (WRAM palette index)
$A8:CC84 0A          ASL A                  ;|
$A8:CC85 0A          ASL A                  ;|
$A8:CC86 AA          TAX                    ;/
$A8:CC87 AF 56 D6 7E LDA $7ED656[$7E:D656]  ;\
$A8:CC8B A8          TAY                    ;} Y = [work robot palette animation table index]

; BRANCH_AGAIN
$A8:CC8C B9 C1 CC    LDA $CCC1,y[$A8:CCC1]  ;\
$A8:CC8F 30 2B       BMI $2B    [$CCBC]     ;} If [$CCC1 + [Y]] & 8000h: go to BRANCH_ZERO
$A8:CC91 9F 12 C1 7E STA $7EC112,x[$7E:C132];\
$A8:CC95 B9 C3 CC    LDA $CCC3,y[$A8:CCC3]  ;|
$A8:CC98 9F 14 C1 7E STA $7EC114,x[$7E:C134];|
$A8:CC9C B9 C5 CC    LDA $CCC5,y[$A8:CCC5]  ;} Copy 4 colours from $CCC1 + [Y] to enemy palette colours 9..Ch
$A8:CC9F 9F 16 C1 7E STA $7EC116,x[$7E:C136];|
$A8:CCA3 B9 C7 CC    LDA $CCC7,y[$A8:CCC7]  ;|
$A8:CCA6 9F 18 C1 7E STA $7EC118,x[$7E:C138];/
$A8:CCAA B9 C9 CC    LDA $CCC9,y[$A8:CCC9]  ;\
$A8:CCAD 8F 54 D6 7E STA $7ED654[$7E:D654]  ;} Work robot palette animation timer = [$CCC1 + [Y] + 8]
$A8:CCB1 98          TYA                    ;\
$A8:CCB2 18          CLC                    ;|
$A8:CCB3 69 0A 00    ADC #$000A             ;} Work robot palette animation table index = [Y] + Ah
$A8:CCB6 8F 56 D6 7E STA $7ED656[$7E:D656]  ;/
$A8:CCBA FA          PLX

$A8:CCBB 6B          RTL                    ; Return

; BRANCH_ZERO
$A8:CCBC A0 00 00    LDY #$0000             ; Y = 0
$A8:CCBF 80 CB       BRA $CB    [$CC8C]     ; Go to BRANCH_AGAIN

; Robot palette animation table
;                        ________________________ Palette colours 9..Ch. Negative = terminator
;                       |                     ___ Timer
;                       |                    |
$A8:CCC1             dw 001F,0018,000F,0008, 0040,
                        0018,000F,0008,001F, 0010,
                        000F,0008,001F,0018, 0010,
                        0008,001F,0018,000F, 0040,
                        000F,0008,001F,0018, 0010,
                        0018,000F,0008,001F, 0010,
                        FFFF
}


;;; $CCFF: Decrement enemy laser cooldown ;;;
{
$A8:CCFF BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:CD02 F0 04       BEQ $04    [$CD08]     ;|
$A8:CD04 3A          DEC A                  ;} Enemy laser cooldown = max(0, [enemy laser cooldown] - 1)
$A8:CD05 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/

$A8:CD08 60          RTS
}


;;; $CD09..D173: Instructions ;;;
{
;;; $CD09: Instruction - facing left - move forwards, go to $C73F if hit wall, go to $CB65 if approaching a fall ;;;
{
$A8:CD09 DA          PHX
$A8:CD0A 5A          PHY
$A8:CD0B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CD0E 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CD11 A9 00 FE    LDA #$FE00             ;\
$A8:CD14 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = -200h
$A8:CD17 A9 00 00    LDA #$0000             ;\
$A8:CD1A 85 12       STA $12    [$7E:0012]  ;|
$A8:CD1C A9 FC FF    LDA #$FFFC             ;} Move enemy left by 4.0
$A8:CD1F 85 14       STA $14    [$7E:0014]  ;|
$A8:CD21 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CD25 90 10       BCC $10    [$CD37]     ; If collided with wall:
$A8:CD27 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:CD2A 18          CLC                    ;|
$A8:CD2B 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CD2E 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:CD31 7A          PLY
$A8:CD32 A0 3F C7    LDY #$C73F             ; Y = $C73F
$A8:CD35 FA          PLX
$A8:CD36 6B          RTL                    ; Return

$A8:CD37 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CD3B 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CD3E F0 0C       BEQ $0C    [$CD4C]     ;/
$A8:CD40 A9 00 00    LDA #$0000             ;\
$A8:CD43 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CD46 A9 FC FF    LDA #$FFFC             ;} Extra Samus X displacement = -4.0
$A8:CD49 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CD4C BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:CD4F 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy Y position backup = [enemy Y position]
$A8:CD52 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:CD55 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy X position backup = [enemy X position]
$A8:CD58 38          SEC                    ;\
$A8:CD59 FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A8:CD5C 38          SEC                    ;} Enemy X position -= [enemy X radius] * 2
$A8:CD5D FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A8:CD60 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A8:CD63 64 12       STZ $12    [$7E:0012]  ;\
$A8:CD65 A9 01 00    LDA #$0001             ;|
$A8:CD68 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 1.0
$A8:CD6A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:CD6E B0 25       BCS $25    [$CD95]     ; If not collided with block:
$A8:CD70 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:CD73 18          CLC                    ;|
$A8:CD74 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CD77 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A8:CD7A BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:CD7D 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy X position backup]
$A8:CD80 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$A8:CD83 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy Y position backup]
$A8:CD86 7A          PLY
$A8:CD87 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CD8A A9 00 02    LDA #$0200             ;\
$A8:CD8D 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy laser X velocity = 200h
$A8:CD90 A0 65 CB    LDY #$CB65             ; Y = $CB65
$A8:CD93 FA          PLX
$A8:CD94 6B          RTL                    ; Return

$A8:CD95 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:CD98 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy X position backup]
$A8:CD9B BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:CD9E 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = [enemy Y position backup]
$A8:CDA1 7A          PLY
$A8:CDA2 FA          PLX
$A8:CDA3 6B          RTL
}


;;; $CDA4: Instruction - facing left - move forwards, go to $C73F if hit wall ;;;
{
$A8:CDA4 DA          PHX
$A8:CDA5 5A          PHY
$A8:CDA6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CDA9 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CDAC A9 00 FE    LDA #$FE00             ;\
$A8:CDAF 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy laser X velocity = -200h
$A8:CDB2 A9 00 00    LDA #$0000             ;\
$A8:CDB5 85 12       STA $12    [$7E:0012]  ;|
$A8:CDB7 A9 FC FF    LDA #$FFFC             ;} Move enemy left by 4.0
$A8:CDBA 85 14       STA $14    [$7E:0014]  ;|
$A8:CDBC 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CDC0 90 10       BCC $10    [$CDD2]     ; If collided with wall:
$A8:CDC2 BD AA 0F    LDA $0FAA,x            ;\
$A8:CDC5 18          CLC                    ;|
$A8:CDC6 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CDC9 9D AA 0F    STA $0FAA,x            ;/
$A8:CDCC 7A          PLY
$A8:CDCD A0 3F C7    LDY #$C73F             ; Y = $C73F
$A8:CDD0 FA          PLX
$A8:CDD1 6B          RTL                    ; Return

$A8:CDD2 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CDD6 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CDD9 F0 0C       BEQ $0C    [$CDE7]     ;/
$A8:CDDB A9 00 00    LDA #$0000             ;\
$A8:CDDE 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CDE1 A9 FC FF    LDA #$FFFC             ;} Extra Samus X displacement = -4.0
$A8:CDE4 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CDE7 7A          PLY
$A8:CDE8 FA          PLX
$A8:CDE9 6B          RTL
}


;;; $CDEA: Instruction - facing left - move backwards, go to $C6E9 if hit wall, go to $C91B if approaching a fall ;;;
{
$A8:CDEA DA          PHX
$A8:CDEB 5A          PHY
$A8:CDEC AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CDEF 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CDF2 A9 00 FE    LDA #$FE00             ;\
$A8:CDF5 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = -200h
$A8:CDF8 A9 00 00    LDA #$0000             ;\
$A8:CDFB 85 12       STA $12    [$7E:0012]  ;|
$A8:CDFD A9 04 00    LDA #$0004             ;} Move enemy right by 4.0
$A8:CE00 85 14       STA $14    [$7E:0014]  ;|
$A8:CE02 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CE06 90 10       BCC $10    [$CE18]     ; If collided with wall:
$A8:CE08 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:CE0B 18          CLC                    ;|
$A8:CE0C 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CE0F 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A8:CE12 7A          PLY
$A8:CE13 A0 E9 C6    LDY #$C6E9             ; Y = $C6E9
$A8:CE16 FA          PLX
$A8:CE17 6B          RTL                    ; Return

$A8:CE18 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CE1C 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CE1F F0 0C       BEQ $0C    [$CE2D]     ;/
$A8:CE21 A9 00 00    LDA #$0000             ;\
$A8:CE24 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CE27 A9 04 00    LDA #$0004             ;} Extra Samus X displacement = 4.0
$A8:CE2A 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CE2D BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:CE30 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy Y position backup = [enemy Y position]
$A8:CE33 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:CE36 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy X position backup = [enemy X position]
$A8:CE39 18          CLC                    ;\
$A8:CE3A 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A8:CE3D 18          CLC                    ;} Enemy X position += [enemy X radius] * 2
$A8:CE3E 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A8:CE41 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A8:CE44 64 12       STZ $12    [$7E:0012]  ;\
$A8:CE46 A9 01 00    LDA #$0001             ;|
$A8:CE49 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 1.0
$A8:CE4B 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:CE4F B0 25       BCS $25    [$CE76]     ; If not collided with block:
$A8:CE51 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:CE54 18          CLC                    ;|
$A8:CE55 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CE58 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A8:CE5B BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A8:CE5E 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy X position backup]
$A8:CE61 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$A8:CE64 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy Y position backup]
$A8:CE67 7A          PLY
$A8:CE68 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CE6B A9 00 FE    LDA #$FE00             ;\
$A8:CE6E 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy laser X velocity = -200h
$A8:CE71 A0 1B C9    LDY #$C91B             ; Y = $C91B
$A8:CE74 FA          PLX
$A8:CE75 6B          RTL                    ; Return

$A8:CE76 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:CE79 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy X position backup]
$A8:CE7C BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:CE7F 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = [enemy Y position backup]
$A8:CE82 7A          PLY
$A8:CE83 FA          PLX
$A8:CE84 6B          RTL
}


;;; $CE85: Instruction - facing left - move backwards, go to $C6E9 if hit wall ;;;
{
$A8:CE85 DA          PHX
$A8:CE86 5A          PHY
$A8:CE87 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CE8A 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CE8D A9 00 FE    LDA #$FE00             ;\
$A8:CE90 9D A8 0F    STA $0FA8,x[$7E:11E8]  ;} Enemy laser X velocity = -200h
$A8:CE93 A9 00 00    LDA #$0000             ;\
$A8:CE96 85 12       STA $12    [$7E:0012]  ;|
$A8:CE98 A9 04 00    LDA #$0004             ;} Move enemy right by 4.0
$A8:CE9B 85 14       STA $14    [$7E:0014]  ;|
$A8:CE9D 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CEA1 90 10       BCC $10    [$CEB3]     ; If collided with wall:
$A8:CEA3 BD AA 0F    LDA $0FAA,x[$7E:11EA]  ;\
$A8:CEA6 18          CLC                    ;|
$A8:CEA7 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CEAA 9D AA 0F    STA $0FAA,x[$7E:11EA]  ;/
$A8:CEAD 7A          PLY
$A8:CEAE A0 E9 C6    LDY #$C6E9             ; Y = $C6E9
$A8:CEB1 FA          PLX
$A8:CEB2 6B          RTL                    ; Return

$A8:CEB3 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CEB7 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CEBA F0 0C       BEQ $0C    [$CEC8]     ;/
$A8:CEBC A9 00 00    LDA #$0000             ;\
$A8:CEBF 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CEC2 A9 04 00    LDA #$0004             ;} Extra Samus X displacement = 4.0
$A8:CEC5 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CEC8 7A          PLY
$A8:CEC9 FA          PLX
$A8:CECA 6B          RTL
}


;;; $CECB: Instruction - go to $C92D ;;;
{
$A8:CECB A0 2D C9    LDY #$C92D
$A8:CECE 6B          RTL
}


;;; $CECF: Instruction - facing right - move forwards, go to $C985 if hit wall, go to $C91B if approaching a fall ;;;
{
$A8:CECF DA          PHX
$A8:CED0 5A          PHY
$A8:CED1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CED4 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CED7 A9 00 02    LDA #$0200             ;\
$A8:CEDA 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = 200h
$A8:CEDD A9 00 00    LDA #$0000             ;\
$A8:CEE0 85 12       STA $12    [$7E:0012]  ;|
$A8:CEE2 A9 04 00    LDA #$0004             ;} Move enemy right by 4.0
$A8:CEE5 85 14       STA $14    [$7E:0014]  ;|
$A8:CEE7 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CEEB 90 10       BCC $10    [$CEFD]     ; If collided with wall:
$A8:CEED BD AA 0F    LDA $0FAA,x            ;\
$A8:CEF0 18          CLC                    ;|
$A8:CEF1 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CEF4 9D AA 0F    STA $0FAA,x            ;/
$A8:CEF7 7A          PLY
$A8:CEF8 A0 85 C9    LDY #$C985             ; Y = $C985
$A8:CEFB FA          PLX
$A8:CEFC 6B          RTL                    ; Return

$A8:CEFD 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CF01 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CF04 F0 0C       BEQ $0C    [$CF12]     ;/
$A8:CF06 A9 00 00    LDA #$0000             ;\
$A8:CF09 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CF0C A9 04 00    LDA #$0004             ;} Extra Samus X displacement = 4.0
$A8:CF0F 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CF12 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:CF15 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy Y position backup = [enemy Y position]
$A8:CF18 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:CF1B 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy X position backup = [enemy X position]
$A8:CF1E 18          CLC                    ;\
$A8:CF1F 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A8:CF22 18          CLC                    ;} Enemy X position += [enemy X radius] * 2
$A8:CF23 7D 82 0F    ADC $0F82,x[$7E:0F82]  ;|
$A8:CF26 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A8:CF29 64 12       STZ $12    [$7E:0012]  ;\
$A8:CF2B A9 01 00    LDA #$0001             ;|
$A8:CF2E 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 1.0
$A8:CF30 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:CF34 B0 25       BCS $25    [$CF5B]     ; If not collided with block:
$A8:CF36 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:CF39 18          CLC                    ;|
$A8:CF3A 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CF3D 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:CF40 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:CF43 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy X position backup]
$A8:CF46 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:CF49 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = [enemy Y position backup]
$A8:CF4C 7A          PLY
$A8:CF4D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CF50 A9 00 FE    LDA #$FE00             ;\
$A8:CF53 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = -200h
$A8:CF56 A0 1B C9    LDY #$C91B             ; Y = $C91B
$A8:CF59 FA          PLX
$A8:CF5A 6B          RTL                    ; Return

$A8:CF5B BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:CF5E 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy X position backup]
$A8:CF61 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:CF64 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = [enemy Y position backup]
$A8:CF67 7A          PLY
$A8:CF68 FA          PLX
$A8:CF69 6B          RTL
}


;;; $CF6A: Instruction - facing right - move forwards, go to $C985 if hit wall ;;;
{
$A8:CF6A DA          PHX
$A8:CF6B 5A          PHY
$A8:CF6C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CF6F 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CF72 A9 00 02    LDA #$0200             ;\
$A8:CF75 9D A8 0F    STA $0FA8,x[$7E:11A8]  ;} Enemy laser X velocity = 200h
$A8:CF78 A9 00 00    LDA #$0000             ;\
$A8:CF7B 85 12       STA $12    [$7E:0012]  ;|
$A8:CF7D A9 04 00    LDA #$0004             ;} Move enemy right by 4.0
$A8:CF80 85 14       STA $14    [$7E:0014]  ;|
$A8:CF82 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CF86 90 10       BCC $10    [$CF98]     ; If collided with wall:
$A8:CF88 BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A8:CF8B 18          CLC                    ;|
$A8:CF8C 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CF8F 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;/
$A8:CF92 7A          PLY
$A8:CF93 A0 85 C9    LDY #$C985             ; Y = $C985
$A8:CF96 FA          PLX
$A8:CF97 6B          RTL                    ; Return

$A8:CF98 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CF9C 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CF9F F0 0C       BEQ $0C    [$CFAD]     ;/
$A8:CFA1 A9 00 00    LDA #$0000             ;\
$A8:CFA4 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CFA7 A9 04 00    LDA #$0004             ;} Extra Samus X displacement = 4.0
$A8:CFAA 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CFAD 7A          PLY
$A8:CFAE FA          PLX
$A8:CFAF 6B          RTL
}


;;; $CFB0: Instruction - facing right - move backwards, go to $C6E9 if hit wall, go to $CB65 if approaching a fall ;;;
{
$A8:CFB0 DA          PHX
$A8:CFB1 5A          PHY
$A8:CFB2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:CFB5 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:CFB8 A9 00 02    LDA #$0200             ;\
$A8:CFBB 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = 200h
$A8:CFBE A9 00 00    LDA #$0000             ;\
$A8:CFC1 85 12       STA $12    [$7E:0012]  ;|
$A8:CFC3 A9 FC FF    LDA #$FFFC             ;} Move enemy left by 4.0
$A8:CFC6 85 14       STA $14    [$7E:0014]  ;|
$A8:CFC8 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:CFCC 90 10       BCC $10    [$CFDE]     ; If collided with wall:
$A8:CFCE BD AA 0F    LDA $0FAA,x[$7E:11AA]  ;\
$A8:CFD1 18          CLC                    ;|
$A8:CFD2 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:CFD5 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;/
$A8:CFD8 7A          PLY
$A8:CFD9 A0 E9 C6    LDY #$C6E9             ; Y = $C6E9
$A8:CFDC FA          PLX
$A8:CFDD 6B          RTL                    ; Return

$A8:CFDE 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:CFE2 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:CFE5 F0 0C       BEQ $0C    [$CFF3]     ;/
$A8:CFE7 A9 00 00    LDA #$0000             ;\
$A8:CFEA 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:CFED A9 FC FF    LDA #$FFFC             ;} Extra Samus X displacement = -4.0
$A8:CFF0 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:CFF3 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:CFF6 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy Y position backup = [enemy Y position]
$A8:CFF9 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:CFFC 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy X position backup = [enemy X position]
$A8:CFFF 38          SEC                    ;\
$A8:D000 FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A8:D003 38          SEC                    ;} Enemy X position -= [enemy X radius] * 2
$A8:D004 FD 82 0F    SBC $0F82,x[$7E:0F82]  ;|
$A8:D007 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A8:D00A 64 12       STZ $12    [$7E:0012]  ;\
$A8:D00C A9 01 00    LDA #$0001             ;|
$A8:D00F 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 1.0
$A8:D011 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:D015 B0 25       BCS $25    [$D03C]     ; If not collided with block:
$A8:D017 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:D01A 18          CLC                    ;|
$A8:D01B 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:D01E 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:D021 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:D024 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy X position = [enemy X position backup]
$A8:D027 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:D02A 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy Y position = [enemy Y position backup]
$A8:D02D 7A          PLY
$A8:D02E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D031 A9 00 02    LDA #$0200             ;\
$A8:D034 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy laser X velocity = 200h
$A8:D037 A0 65 CB    LDY #$CB65             ; Y = $CB65
$A8:D03A FA          PLX
$A8:D03B 6B          RTL                    ; Return

$A8:D03C BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:D03F 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy X position = [enemy X position backup]
$A8:D042 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A8:D045 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy Y position = [enemy Y position backup]
$A8:D048 7A          PLY
$A8:D049 FA          PLX
$A8:D04A 6B          RTL
}


;;; $D04B: Instruction - facing right - move backwards, go to $C6E9 if hit wall ;;;
{
$A8:D04B DA          PHX
$A8:D04C 5A          PHY
$A8:D04D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D050 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:D053 A9 00 02    LDA #$0200             ;\
$A8:D056 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy laser X velocity = 200h
$A8:D059 A9 00 00    LDA #$0000             ;\
$A8:D05C 85 12       STA $12    [$7E:0012]  ;|
$A8:D05E A9 FC FF    LDA #$FFFC             ;} Move enemy left by 4.0
$A8:D061 85 14       STA $14    [$7E:0014]  ;|
$A8:D063 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:D067 90 10       BCC $10    [$D079]     ; If collided with wall:
$A8:D069 BD AA 0F    LDA $0FAA,x            ;\
$A8:D06C 18          CLC                    ;|
$A8:D06D 69 08 00    ADC #$0008             ;} Enemy laser cooldown += 8
$A8:D070 9D AA 0F    STA $0FAA,x            ;/
$A8:D073 7A          PLY
$A8:D074 A0 E9 C6    LDY #$C6E9             ; Y = $C6E9
$A8:D077 FA          PLX
$A8:D078 6B          RTL                    ; Return

$A8:D079 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A8:D07D 29 FF FF    AND #$FFFF             ;} If enemy is touching Samus from below:
$A8:D080 F0 0C       BEQ $0C    [$D08E]     ;/
$A8:D082 A9 00 00    LDA #$0000             ;\
$A8:D085 8D 56 0B    STA $0B56  [$7E:0B56]  ;|
$A8:D088 A9 FC FF    LDA #$FFFC             ;} Extra Samus X displacement = -4.0
$A8:D08B 8D 58 0B    STA $0B58  [$7E:0B58]  ;/

$A8:D08E 7A          PLY
$A8:D08F FA          PLX
$A8:D090 6B          RTL
}


;;; $D091: Instruction - queue work robot sound effect if on screen ;;;
{
$A8:D091 DA          PHX
$A8:D092 5A          PHY
$A8:D093 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D096 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A8:D099 DD 7A 0F    CMP $0F7A,x[$7E:0F7A]  ;|
$A8:D09C 10 21       BPL $21    [$D0BF]     ;|
$A8:D09E 18          CLC                    ;} If not [layer 1 X position] < [enemy X position] <= [layer 1 X position] + 100h: return
$A8:D09F 69 00 01    ADC #$0100             ;|
$A8:D0A2 DD 7A 0F    CMP $0F7A,x[$7E:0FBA]  ;|
$A8:D0A5 30 18       BMI $18    [$D0BF]     ;/
$A8:D0A7 AD 15 09    LDA $0915  [$7E:0915]  ;\
$A8:D0AA DD 7E 0F    CMP $0F7E,x[$7E:0FBE]  ;|
$A8:D0AD 10 10       BPL $10    [$D0BF]     ;|
$A8:D0AF 18          CLC                    ;} If not [layer 1 Y position] < [enemy Y position] <= [layer 1 Y position] + E0h: return
$A8:D0B0 69 E0 00    ADC #$00E0             ;|
$A8:D0B3 DD 7E 0F    CMP $0F7E,x[$7E:0FBE]  ;|
$A8:D0B6 30 07       BMI $07    [$D0BF]     ;/
$A8:D0B8 A9 68 00    LDA #$0068             ;\
$A8:D0BB 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 68h, sound library 2, max queued sounds allowed = 6 (work robot)

$A8:D0BF 7A          PLY
$A8:D0C0 FA          PLX
$A8:D0C1 6B          RTL
}


;;; $D0C2: Instruction - go to $C6E9 ;;;
{
$A8:D0C2 A0 E9 C6    LDY #$C6E9
$A8:D0C5 6B          RTL
}


;;; $D0C6: Instruction - try shooting laser up-right and go to $CB1D if so ;;;
{
$A8:D0C6 A9 1D CB    LDA #$CB1D             ;\
$A8:D0C9 85 32       STA $32    [$7E:0032]  ;} $32 = $CB1D
$A8:D0CB A9 D0 D2    LDA #$D2D0             ;\
$A8:D0CE 85 30       STA $30    [$7E:0030]  ;} $30 = $D2D0 (work robot laser - up-right)
$A8:D0D0 80 0A       BRA $0A    [$D0DC]     ; Go to handle firing laser - upwards
}


;;; $D0D2: Instruction - try shooting laser up-left and go to $C8D1 if so ;;;
{
$A8:D0D2 A9 D1 C8    LDA #$C8D1             ;\
$A8:D0D5 85 32       STA $32    [$7E:0032]  ;} $32 = $C8D1
$A8:D0D7 A9 A6 D2    LDA #$D2A6             ;\
$A8:D0DA 85 30       STA $30    [$7E:0030]  ;} $30 = $D2A6 (work robot laser - up-left)
}


;;; $D0DC: Handle firing laser - upwards ;;;
{
$A8:D0DC BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:D0DF D0 1B       BNE $1B    [$D0FC]     ;} If [enemy laser cooldown] = 0:
$A8:D0E1 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A8:D0E4 29 1F 00    AND #$001F             ;|
$A8:D0E7 18          CLC                    ;} Enemy laser cooldown = [random number] % 20h + 10h
$A8:D0E8 69 10 00    ADC #$0010             ;|
$A8:D0EB 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:D0EE DA          PHX                    ;\
$A8:D0EF A4 30       LDY $30    [$7E:0030]  ;|
$A8:D0F1 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn enemy projectile [$30]
$A8:D0F4 22 27 80 86 JSL $868027[$86:8027]  ;|
$A8:D0F8 FA          PLX                    ;/
$A8:D0F9 A4 32       LDY $32    [$7E:0032]  ; Y = [$32]
$A8:D0FB 6B          RTL                    ; Return

$A8:D0FC 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:D0FF 6B          RTL
}


;;; $D100: Instruction - try shooting laser horizontally and go to $CB09 if so ;;;
{
$A8:D100 A9 09 CB    LDA #$CB09             ;\
$A8:D103 85 32       STA $32    [$7E:0032]  ;} $32 = $CB09
$A8:D105 80 05       BRA $05    [$D10C]     ; Go to handle firing laser - horizontal
}


;;; $D107: Instruction - try shooting laser horizontally and go to $C8BD if so ;;;
{
$A8:D107 A9 BD C8    LDA #$C8BD             ;\
$A8:D10A 85 32       STA $32    [$7E:0032]  ;} $32 = $C8BD
}


;;; $D10C: Handle firing laser - horizontal ;;;
{
$A8:D10C BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:D10F D0 1C       BNE $1C    [$D12D]     ;} If [enemy laser cooldown] = 0:
$A8:D111 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A8:D114 29 1F 00    AND #$001F             ;|
$A8:D117 18          CLC                    ;} Enemy laser cooldown = [random number] % 20h + 10h
$A8:D118 69 10 00    ADC #$0010             ;|
$A8:D11B 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:D11E DA          PHX                    ;\
$A8:D11F A0 B4 D2    LDY #$D2B4             ;|
$A8:D122 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn work robot laser - horizontal enemy projectile
$A8:D125 22 27 80 86 JSL $868027[$86:8027]  ;|
$A8:D129 FA          PLX                    ;/
$A8:D12A A4 32       LDY $32    [$7E:0032]  ; Y = [$32]
$A8:D12C 6B          RTL                    ; Return

$A8:D12D 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:D130 6B          RTL
}


;;; $D131: Instruction - try shooting laser down-right and go to $CAFD if so ;;;
{
$A8:D131 A9 DE D2    LDA #$D2DE             ;\
$A8:D134 85 30       STA $30    [$7E:0030]  ;} $30 = $D2DE (work robot laser - down-right)
$A8:D136 A9 FD CA    LDA #$CAFD             ;\
$A8:D139 85 32       STA $32    [$7E:0032]  ;} $32 = $CAFD
$A8:D13B 80 0A       BRA $0A    [$D147]     ; Go to handle firing laser - downwards
}


;;; $D13D: Instruction - try shooting laser down-left and go to $C8B1 if so ;;;
{
$A8:D13D A9 C2 D2    LDA #$D2C2             ;\
$A8:D140 85 30       STA $30    [$7E:0030]  ;} $30 = $D2C2 (work robot laser - down-left)
$A8:D142 A9 B1 C8    LDA #$C8B1             ;\
$A8:D145 85 32       STA $32    [$7E:0032]  ;} $32 = $C8B1
}


;;; $D147: Handle firing laser - downwards ;;;
{
$A8:D147 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A8:D14A D0 1B       BNE $1B    [$D167]     ;} If [enemy laser cooldown] = 0:
$A8:D14C AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A8:D14F 29 1F 00    AND #$001F             ;|
$A8:D152 18          CLC                    ;} Enemy laser cooldown = [random number] % 20h + 10h
$A8:D153 69 10 00    ADC #$0010             ;|
$A8:D156 9D AA 0F    STA $0FAA,x[$7E:11AA]  ;/
$A8:D159 DA          PHX
$A8:D15A A4 30       LDY $30    [$7E:0030]  ;\
$A8:D15C AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn enemy projectile [$30]
$A8:D15F 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:D163 A4 32       LDY $32    [$7E:0032]  ; Y = [$32]
$A8:D165 FA          PLX
$A8:D166 6B          RTL                    ; Return

$A8:D167 20 FF CC    JSR $CCFF  [$A8:CCFF]  ; Decrement enemy laser cooldown
$A8:D16A 6B          RTL
}


;;; $D16B: Instruction - decrement enemy laser cooldown ;;;
{
$A8:D16B DA          PHX
$A8:D16C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D16F 20 FF CC    JSR $CCFF  [$A8:CCFF]
$A8:D172 FA          PLX
$A8:D173 6B          RTL
}
}


;;; $D174: Enemy touch - enemy $E8FF/$E93F (work robot) ;;;
{
$A8:D174 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D177 BD 7A 0F    LDA $0F7A,x            ;\
$A8:D17A CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [enemy X position] >= [Samus X position]:
$A8:D17D 30 07       BMI $07    [$D186]     ;/
$A8:D17F A9 FC FF    LDA #$FFFC             ;\
$A8:D182 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = -4
$A8:D185 6B          RTL                    ; Return

$A8:D186 A9 04 00    LDA #$0004             ;\
$A8:D189 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = 4
$A8:D18C 6B          RTL
}


;;; $D18D: Enemy shot - enemy $E93F (work robot deactivated) ;;;
{
$A8:D18D 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A8:D191 6B          RTL
}


;;; $D192: Enemy shot - enemy $E8FF (work robot) ;;;
{
$A8:D192 C2 30       REP #$30
$A8:D194 DA          PHX
$A8:D195 5A          PHY
$A8:D196 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A8:D199 BF 28 D8 7E LDA $7ED828,x[$7E:D82B];|
$A8:D19D 89 01 00    BIT #$0001             ;} If area boss is not dead: return
$A8:D1A0 F0 26       BEQ $26    [$D1C8]     ;/
$A8:D1A2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D1A5 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A8:D1A9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D1AC BD 8C 0F    LDA $0F8C,x[$7E:0FCC]  ;\
$A8:D1AF F0 17       BEQ $17    [$D1C8]     ;} If [enemy health] = 0: return
$A8:D1B1 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A8:D1B4 30 15       BMI $15    [$D1CB]     ;} If [enemy laser X velocity] < 0: go to BRANCH_FACING_LEFT
$A8:D1B6 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:D1B9 DD 7A 0F    CMP $0F7A,x[$7E:0FBA]  ;} If [Samus X position] >= [enemy X position]:
$A8:D1BC 30 05       BMI $05    [$D1C3]     ;/
$A8:D1BE A9 01 CA    LDA #$CA01             ; Enemy instruction list pointer = $CA01 (facing right, Samus is ahead)
$A8:D1C1 80 13       BRA $13    [$D1D6]     ; Go to BRANCH_MERGE

$A8:D1C3 A9 7D CA    LDA #$CA7D             ; Enemy instruction list pointer = $CA7D (facing right, Samus is behind)
$A8:D1C6 80 0E       BRA $0E    [$D1D6]     ; Go to BRANCH_MERGE

$A8:D1C8 7A          PLY
$A8:D1C9 FA          PLX
$A8:D1CA 6B          RTL

; BRANCH_FACING_LEFT
$A8:D1CB AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:D1CE DD 7A 0F    CMP $0F7A,x[$7E:0FBA]  ;} If [Samus X position] >= [enemy X position]: go to BRANCH_FACING_LEFT_SAMUS_BEHIND
$A8:D1D1 10 19       BPL $19    [$D1EC]     ;/
$A8:D1D3 A9 BB C7    LDA #$C7BB             ; Enemy instruction list pointer = $C7BB (facing left, Samus is ahead)

; BRANCH_MERGE
$A8:D1D6 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A8:D1D9 A9 01 00    LDA #$0001             ;\
$A8:D1DC 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:D1DF BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A8:D1E2 18          CLC                    ;|
$A8:D1E3 69 40 00    ADC #$0040             ;} Enemy laser cooldown += 40h
$A8:D1E6 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A8:D1E9 7A          PLY
$A8:D1EA FA          PLX
$A8:D1EB 6B          RTL                    ; Return

; BRANCH_FACING_LEFT_SAMUS_BEHIND
$A8:D1EC A9 33 C8    LDA #$C833             ; Enemy instruction list pointer = $C833 (facing left, Samus is behind)
$A8:D1EF 80 E5       BRA $E5    [$D1D6]     ; Go to BRANCH_MERGE
}


;;; $D1F1: Work robot spritemaps ;;;
{
$A8:D1F1             dx 000C, 8000,01,212E, 81F0,01,212C, 0008,17,2149, 0000,17,2148, 8000,07,210C, 0000,19,214B, 01F8,19,214A, 81F8,09,210E, 8000,F1,2122, 81F0,F1,2120, 8000,E1,2102, 81F0,E1,2100
$A8:D22F             dx 000C, 8001,01,2146, 81F1,01,2144, 0003,18,2149, 01FB,18,2148, 81FB,08,210C, 0000,19,214B, 01F8,19,214A, 81F8,09,210E, 8000,F1,2126, 81F0,F1,2124, 81FF,E1,2106, 81EF,E1,2104
$A8:D26D             dx 000C, 8000,01,2146, 81F0,01,2144, 01FF,19,2149, 01F7,19,2148, 81F7,09,210C, 0001,19,214B, 01F9,19,214A, 81F9,09,210E, 8000,F1,2126, 81F0,F1,2124, 8000,E1,2106, 81F0,E1,2104
$A8:D2AB             dx 000C, 81FF,01,2146, 81EF,01,2144, 01FC,18,2149, 01F4,18,2148, 81F4,08,210C, 0000,19,214B, 01F8,19,214A, 81F8,09,210E, 8000,F1,2126, 81F0,F1,2124, 8001,E1,2106, 81F1,E1,2104
$A8:D2E9             dx 000C, 8000,01,2142, 81F0,01,2140, 01F7,16,2149, 01EF,16,2148, 81EF,06,210C, 0001,19,214B, 01F9,19,214A, 81F9,09,210E, 8000,F1,212A, 81F0,F1,2128, 8000,E1,210A, 81F0,E1,2108
$A8:D327             dx 000C, 8000,01,2146, 81F0,01,2144, 01FC,17,2149, 01F4,17,2148, 81F4,07,210C, 0004,19,214B, 01FC,19,214A, 81FC,09,210E, 8000,F1,2126, 81F0,F1,2124, 8000,E1,2106, 81F0,E1,2104
$A8:D365             dx 000C, 8000,01,212E, 81F0,01,212C, 0000,19,2149, 01F8,19,2148, 81F8,09,210C, 0008,17,214B, 0000,17,214A, 8000,07,210E, 8000,F1,2122, 81F0,F1,2120, 8000,E1,2102, 81F0,E1,2100
$A8:D3A3             dx 000C, 8001,01,2146, 81F1,01,2144, 0000,19,2149, 01F8,19,2148, 81F8,09,210C, 0003,18,214B, 01FB,18,214A, 81FB,08,210E, 8000,F1,2126, 81F0,F1,2124, 81FF,E1,2106, 81EF,E1,2104
$A8:D3E1             dx 000C, 8000,01,2146, 81F0,01,2144, 01F8,19,2148, 0000,19,2149, 81F8,09,210C, 01FE,19,214B, 01F6,19,214A, 81F6,09,210E, 8000,F1,2126, 81F0,F1,2124, 8000,E1,2106, 81F0,E1,2104
$A8:D41F             dx 000C, 81FF,01,2146, 81EF,01,2144, 0000,19,2149, 01F8,19,2148, 81F8,09,210C, 01FC,18,214B, 01F4,18,214A, 81F4,08,210E, 8000,F1,2126, 81F0,F1,2124, 8001,E1,2106, 81F1,E1,2104
$A8:D45D             dx 000C, 8000,01,2142, 81F0,01,2140, 0001,19,2149, 01F9,19,2148, 81F9,09,210C, 01F7,16,214B, 01EF,16,214A, 81EF,06,210E, 8000,F1,212A, 81F0,F1,2128, 8000,E1,210A, 81F0,E1,2108
$A8:D49B             dx 000C, 8000,01,2146, 81F0,01,2144, 0004,19,2149, 01FC,19,2148, 81FC,09,210C, 01FC,17,214B, 01F4,17,214A, 81F4,07,210E, 8000,F1,2126, 81F0,F1,2124, 8000,E1,2106, 81F0,E1,2104
$A8:D4D9             dx 000C, 81F0,01,612E, 8000,01,612C, 01F0,17,6149, 01F8,17,6148, 81F0,07,610C, 01F8,19,614B, 0000,19,614A, 81F8,09,610E, 81F0,F1,6122, 8000,F1,6120, 81F0,E1,6102, 8000,E1,6100
$A8:D517             dx 000C, 81EF,01,6146, 81FF,01,6144, 01F5,18,6149, 01FD,18,6148, 81F5,08,610C, 01F8,19,614B, 0000,19,614A, 81F8,09,610E, 81F0,F1,6126, 8000,F1,6124, 81F1,E1,6106, 8001,E1,6104
$A8:D555             dx 000C, 81F0,01,6146, 8000,01,6144, 01F9,19,6149, 0001,19,6148, 81F9,09,610C, 01F7,19,614B, 01FF,19,614A, 81F7,09,610E, 81F0,F1,6126, 8000,F1,6124, 81F0,E1,6106, 8000,E1,6104
$A8:D593             dx 000C, 81F1,01,6146, 8001,01,6144, 01FC,18,6149, 0004,18,6148, 81FC,08,610C, 01F8,19,614B, 0000,19,614A, 81F8,09,610E, 81F0,F1,6126, 8000,F1,6124, 81EF,E1,6106, 81FF,E1,6104
$A8:D5D1             dx 000C, 81F0,01,6142, 8000,01,6140, 0001,16,6149, 0009,16,6148, 8001,06,610C, 01F7,19,614B, 01FF,19,614A, 81F7,09,610E, 81F0,F1,612A, 8000,F1,6128, 81F0,E1,610A, 8000,E1,6108
$A8:D60F             dx 000C, 81F0,01,6146, 8000,01,6144, 01FC,17,6149, 0004,17,6148, 81FC,07,610C, 01F4,19,614B, 01FC,19,614A, 81F4,09,610E, 81F0,F1,6126, 8000,F1,6124, 81F0,E1,6106, 8000,E1,6104
$A8:D64D             dx 000C, 81F0,01,612E, 8000,01,612C, 01F8,19,6149, 0000,19,6148, 81F8,09,610C, 01F0,17,614B, 01F8,17,614A, 81F0,07,610E, 81F0,F1,6122, 8000,F1,6120, 81F0,E1,6102, 8000,E1,6100
$A8:D68B             dx 000C, 81EF,01,6146, 81FF,01,6144, 01F8,19,6149, 0000,19,6148, 81F8,09,610C, 01F5,18,614B, 01FD,18,614A, 81F5,08,610E, 81F0,F1,6126, 8000,F1,6124, 81F1,E1,6106, 8001,E1,6104
$A8:D6C9             dx 000C, 81F0,01,6146, 8000,01,6144, 0000,19,6148, 01F8,19,6149, 81F8,09,610C, 01FA,19,614B, 0002,19,614A, 81FA,09,610E, 81F0,F1,6126, 8000,F1,6124, 81F0,E1,6106, 8000,E1,6104
$A8:D707             dx 000C, 81F1,01,6146, 8001,01,6144, 01F8,19,6149, 0000,19,6148, 81F8,09,610C, 01FC,18,614B, 0004,18,614A, 81FC,08,610E, 81F0,F1,6126, 8000,F1,6124, 81EF,E1,6106, 81FF,E1,6104
$A8:D745             dx 000C, 81F0,01,6142, 8000,01,6140, 01F7,19,6149, 01FF,19,6148, 81F7,09,610C, 0001,16,614B, 0009,16,614A, 8001,06,610E, 81F0,F1,612A, 8000,F1,6128, 81F0,E1,610A, 8000,E1,6108
$A8:D783             dx 000C, 81F0,01,6146, 8000,01,6144, 01F4,19,6149, 01FC,19,6148, 81F4,09,610C, 01FC,17,614B, 0004,17,614A, 81FC,07,610E, 81F0,F1,6126, 8000,F1,6124, 81F0,E1,6106, 8000,E1,6104
$A8:D7C1             dx 0006, 8000,01,212E, 81F0,01,212C, 8000,F1,2122, 81F0,F1,2120, 8000,E1,2102, 81F0,E1,2100
$A8:D7E1             dx 0006, 8000,01,2146, 81F0,01,2144, 8000,F1,2126, 81F0,F1,2124, 8000,E1,2106, 81F0,E1,2104
$A8:D801             dx 0006, 8000,01,2142, 81F0,01,2140, 8000,F1,212A, 81F0,F1,2128, 8000,E1,210A, 81F0,E1,2108
}
}


;;; $D821..DBC6: Bull ;;;
{
;;; $D821: Palette - enemy $E97F (bull) ;;;
{
$A8:D821             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 435A, 3694, 15AD, 0508, 03FF, 0237, 00D1
}


;;; $D841: Instruction list - normal ;;;
{
$A8:D841             dw 000A,DB76,
                        000A,DB8C,
                        000A,DB76,
                        000A,DBA2,
                        80ED,D841   ; Go to $D841
}


;;; $D855: Instruction list - shot ;;;
{
$A8:D855             dw 8123,0005   ; Timer = 5
$A2:D859             dw 0003,DB76,
                        0003,DB8C,
                        0003,DB76,
                        0003,DBA2,
                        8110,D859,  ; Decrement timer and go to $D859 if non-zero
                        80ED,D841   ; Go to $D841 (normal)
}


;;; $D871: Bull constants ;;;
{
; Angle to move when shot by non-damaging projectile
$A8:D871             dw 00C0, ; 0: Up, facing right
                        00E0, ; 1: Up-right
                        0000, ; 2: Right
                        0020, ; 3: Down-right
                        0040, ; 4: Down, facing right
                        0040, ; 5: Down, facing left
                        0060, ; 6: Down-left
                        0080, ; 7: Left
                        00A0, ; 8: Up-left
                        00C0  ; 9: Up, facing left

; Max speeds. Indexed by [enemy parameter 2] * 2
$A8:D885             dw 03FF, 04FF, 05FF, 06FF, 07FF, 08FF, 09FF, 0AFF
}


;;; $D895: Bull acceleration interval table ;;;
{
; Indexed by [enemy parameter 1] * 4
;                        ________ Acceleration interval timer reset value
;                       |     ___ Deceleration interval timer reset value
;                       |    |
$A8:D895             dw 0003,0001,
                        0004,0001, 
                        0005,0002, 
                        0006,0002, 
                        0007,0002, 
                        0008,0003, 
                        0009,0003, 
                        000A,0004,
                        000B,0004, 
                        000C,0005, 
                        000D,0005, 
                        000E,0006, 
                        000F,0006
}


;;; $D8C9: Initialisation AI - enemy $E97F (bull) ;;;
{
$A8:D8C9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D8CC A9 01 00    LDA #$0001             ;\
$A8:D8CF 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A8:D8D2 9E 90 0F    STZ $0F90,x[$7E:1010]  ; Enemy timer = 0
$A8:D8D5 A9 41 D8    LDA #$D841             ;\
$A8:D8D8 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $D841 (normal)
$A8:D8DB BD B4 0F    LDA $0FB4,x[$7E:1034]  ;\
$A8:D8DE 0A          ASL A                  ;|
$A8:D8DF 0A          ASL A                  ;} Y = [enemy parameter 1] * 4
$A8:D8E0 A8          TAY                    ;/
$A8:D8E1 B9 95 D8    LDA $D895,y[$A8:D8A1]  ;\
$A8:D8E4 9F 0A 78 7E STA $7E780A,x[$7E:788A];} Enemy acceleration interval timer reset value = [$D895 + [Y]]
$A8:D8E8 9D B2 0F    STA $0FB2,x[$7E:1032]  ; Enemy acceleration interval timer = [$D895 + [Y]]
$A8:D8EB B9 97 D8    LDA $D897,y[$A8:D8A3]  ;\
$A8:D8EE 9F 0C 78 7E STA $7E780C,x[$7E:788C];} Enemy deceleration interval timer reset value = [$D895 + [Y] + 2]
$A8:D8F2 A9 10 00    LDA #$0010             ;\
$A8:D8F5 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy activation timer = 10h
$A8:D8F8 A9 2B D9    LDA #$D92B             ;\
$A8:D8FB 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $D92B (movement delay)
$A8:D8FE BD B6 0F    LDA $0FB6,x[$7E:1036]  ;\
$A8:D901 0A          ASL A                  ;|
$A8:D902 A8          TAY                    ;} Enemy max speed = [$D885 + [enemy parameter 2] * 2]
$A8:D903 B9 85 D8    LDA $D885,y[$A8:D88B]  ;|
$A8:D906 9F 00 78 7E STA $7E7800,x[$7E:7880];/
$A8:D90A 6B          RTL
}


;;; $D90B: Main AI - enemy $E97F (bull) ;;;
{
$A8:D90B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D90E BF 0E 78 7E LDA $7E780E,x[$7E:788E];\
$A8:D912 3A          DEC A                  ;} Decrement enemy shot reaction disable timer
$A8:D913 9F 0E 78 7E STA $7E780E,x[$7E:788E];/
$A8:D917 D0 0E       BNE $0E    [$D927]     ; If [enemy shot reaction disable timer] = 0:
$A8:D919 A9 01 00    LDA #$0001             ;\
$A8:D91C 9F 0E 78 7E STA $7E780E,x[$7E:788E];} Enemy shot reaction disable timer = 1
$A8:D920 A9 00 00    LDA #$0000             ;\
$A8:D923 9F 06 78 7E STA $7E7806,x[$7E:7886];} Enemy shot reaction disable flag = 0

$A8:D927 FC A8 0F    JSR ($0FA8,x)[$A8:D92B]; Execute [enemy function]
$A8:D92A 6B          RTL
}


;;; $D92B: Bull function - movement delay ;;;
{
$A8:D92B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D92E DE B0 0F    DEC $0FB0,x[$7E:1030]  ; Decrement enemy activation timer
$A8:D931 D0 0C       BNE $0C    [$D93F]     ; If [enemy activation timer] = 0:
$A8:D933 A9 10 00    LDA #$0010             ;\
$A8:D936 9D B0 0F    STA $0FB0,x[$7E:1030]  ;} Enemy activation timer = 10h
$A8:D939 A9 40 D9    LDA #$D940             ;\
$A8:D93C 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $D940 (target Samus)

$A8:D93F 60          RTS
}


;;; $D940: Bull function - target Samus ;;;
{
$A8:D940 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D943 22 66 C0 A0 JSL $A0C066[$A0:C066]  ; A = angle of Samus from enemy
$A8:D947 38          SEC                    ;\
$A8:D948 E9 40 00    SBC #$0040             ;|
$A8:D94B 29 FF 00    AND #$00FF             ;} Enemy angle to Samus = ([A] - 40h) % 100h (transform angle origin to positive x axis)
$A8:D94E 9F 02 78 7E STA $7E7802,x[$7E:7882];/
$A8:D952 9F 04 78 7E STA $7E7804,x[$7E:7884]; Enemy angle = [enemy angle to Samus]
$A8:D956 A9 63 D9    LDA #$D963             ;\
$A8:D959 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $D963 (accelerating)
$A8:D95C A9 18 00    LDA #$0018             ;\
$A8:D95F 9D AC 0F    STA $0FAC,x[$7E:102C]  ;} Enemy acceleration delta = 18h
$A8:D962 60          RTS
}


;;; $D963: Bull function - accelerating ;;;
{
$A8:D963 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D966 BD AE 0F    LDA $0FAE,x[$7E:102E]  ;\
$A8:D969 DF 00 78 7E CMP $7E7800,x[$7E:7880];} If [enemy speed] < [enemy max speed]:
$A8:D96D 10 03       BPL $03    [$D972]     ;/
$A8:D96F 20 71 DA    JSR $DA71  [$A8:DA71]  ; Accelerate bull

$A8:D972 20 DB D9    JSR $D9DB  [$A8:D9DB]  ; Bull X movement
$A8:D975 20 28 DA    JSR $DA28  [$A8:DA28]  ; Bull Y movement
$A8:D978 20 AA D9    JSR $D9AA  [$A8:D9AA]  ; Trigger bull deceleration if too far off target
$A8:D97B 60          RTS
}


;;; $D97C: Bull function - decelerating ;;;
{
$A8:D97C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D97F BD AE 0F    LDA $0FAE,x[$7E:102E]  ;\
$A8:D982 F0 09       BEQ $09    [$D98D]     ;} If [enemy speed] > 0:
$A8:D984 30 07       BMI $07    [$D98D]     ;/
$A8:D986 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A8:D989 F0 02       BEQ $02    [$D98D]     ;} If [enemy acceleration] > 0: go to BRANCH_DECELERATE
$A8:D98B 10 13       BPL $13    [$D9A0]     ;/

$A8:D98D A9 2B D9    LDA #$D92B             ;\
$A8:D990 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $D92B (movement delay)
$A8:D993 A9 00 00    LDA #$0000             ;\
$A8:D996 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy acceleration = 0
$A8:D999 9D AC 0F    STA $0FAC,x[$7E:102C]  ; Enemy acceleration delta = 0
$A8:D99C 9D AE 0F    STA $0FAE,x[$7E:102E]  ; Enemy speed = 0
$A8:D99F 60          RTS                    ; Return

; BRANCH_DECELERATE
$A8:D9A0 20 DB D9    JSR $D9DB  [$A8:D9DB]  ; Bull X movement
$A8:D9A3 20 28 DA    JSR $DA28  [$A8:DA28]  ; Bull Y movement
$A8:D9A6 20 92 DA    JSR $DA92  [$A8:DA92]  ; Decelerate bull
$A8:D9A9 60          RTS
}


;;; $D9AA: Trigger bull deceleration if too far off target ;;;
{
$A8:D9AA AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D9AD 22 66 C0 A0 JSL $A0C066[$A0:C066]  ; A = angle of Samus from enemy
$A8:D9B1 38          SEC                    ;\
$A8:D9B2 E9 40 00    SBC #$0040             ;|
$A8:D9B5 29 FF 00    AND #$00FF             ;} Enemy angle to Samus = ([A] - 40h) % 100h
$A8:D9B8 9F 02 78 7E STA $7E7802,x[$7E:7882];/
$A8:D9BC 38          SEC                    ;\
$A8:D9BD FF 04 78 7E SBC $7E7804,x[$7E:7884];} A = ([enemy angle to Samus] - [enemy angle]) % 100h
$A8:D9C1 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ; Sign extend A
$A8:D9C5 22 67 B0 A0 JSL $A0B067[$A0:B067]  ; A = |[A]|
$A8:D9C9 C9 30 00    CMP #$0030             ;\
$A8:D9CC 30 0C       BMI $0C    [$D9DA]     ;} If [A] >= 30h:
$A8:D9CE A9 7C D9    LDA #$D97C             ;\
$A8:D9D1 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $D97C (decelerating)
$A8:D9D4 A9 18 00    LDA #$0018             ;\
$A8:D9D7 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy acceleration delta = 18h

$A8:D9DA 60          RTS
}


;;; $D9DB: Bull X movement ;;;
{
$A8:D9DB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:D9DE 64 1A       STZ $1A    [$7E:001A]  ; $1A = 0 (moving left flag)
$A8:D9E0 BF 04 78 7E LDA $7E7804,x[$7E:7884];\
$A8:D9E4 DA          PHX                    ;|
$A8:D9E5 18          CLC                    ;|
$A8:D9E6 69 40 00    ADC #$0040             ;|
$A8:D9E9 29 FF 00    AND #$00FF             ;|
$A8:D9EC 0A          ASL A                  ;} $12 = cos([enemy angle] * pi / 80h) * 7FFFh
$A8:D9ED AA          TAX                    ;|
$A8:D9EE BF C3 B1 A0 LDA $A0B1C3,x[$A0:B33D];|
$A8:D9F2 85 12       STA $12    [$7E:0012]  ;|
$A8:D9F4 FA          PLX                    ;/
$A8:D9F5 A5 12       LDA $12    [$7E:0012]  ;\
$A8:D9F7 10 02       BPL $02    [$D9FB]     ;} If [$12] < 0:
$A8:D9F9 E6 1A       INC $1A    [$7E:001A]  ; (Moving left flag) = 1

$A8:D9FB A5 12       LDA $12    [$7E:0012]  ;\
$A8:D9FD 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;|
$A8:DA01 29 00 FF    AND #$FF00             ;} $16 = |[$12]| / 100h
$A8:DA04 EB          XBA                    ;|
$A8:DA05 85 16       STA $16    [$7E:0016]  ;/
$A8:DA07 BD AE 0F    LDA $0FAE,x[$7E:102E]  ;\
$A8:DA0A 85 18       STA $18    [$7E:0018]  ;} $18 = [enemy speed]
$A8:DA0C 20 B3 DA    JSR $DAB3  [$A8:DAB3]  ; $1E.$1C = [$16] * [$18] / 10000h
$A8:DA0F A5 1A       LDA $1A    [$7E:001A]  ;\
$A8:DA11 F0 03       BEQ $03    [$DA16]     ;} If (moving left flag) != 0:
$A8:DA13 20 F6 DA    JSR $DAF6  [$A8:DAF6]  ; Negate $1E.$1C

$A8:DA16 18          CLC                    ;\
$A8:DA17 BD 7C 0F    LDA $0F7C,x[$7E:0FFC]  ;|
$A8:DA1A 65 1C       ADC $1C    [$7E:001C]  ;|
$A8:DA1C 9D 7C 0F    STA $0F7C,x[$7E:0FFC]  ;} Enemy X position += [$1E].[$1C]
$A8:DA1F BD 7A 0F    LDA $0F7A,x[$7E:0FFA]  ;|
$A8:DA22 65 1E       ADC $1E    [$7E:001E]  ;|
$A8:DA24 9D 7A 0F    STA $0F7A,x[$7E:0FFA]  ;/
$A8:DA27 60          RTS
}


;;; $DA28: Bull Y movement ;;;
{
$A8:DA28 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DA2B 64 1A       STZ $1A    [$7E:001A]  ; $1A = 0 (moving up flag)
$A8:DA2D BF 04 78 7E LDA $7E7804,x[$7E:7884];\
$A8:DA31 DA          PHX                    ;|
$A8:DA32 29 FF 00    AND #$00FF             ;|
$A8:DA35 0A          ASL A                  ;|
$A8:DA36 AA          TAX                    ;} $12 = sin([enemy angle] * pi / 80h) * 7FFFh
$A8:DA37 BF C3 B1 A0 LDA $A0B1C3,x[$A0:B2BD];|
$A8:DA3B 85 12       STA $12    [$7E:0012]  ;|
$A8:DA3D FA          PLX                    ;/
$A8:DA3E A5 12       LDA $12    [$7E:0012]  ;\
$A8:DA40 10 02       BPL $02    [$DA44]     ;} If [$12] < 0:
$A8:DA42 E6 1A       INC $1A    [$7E:001A]  ; (Moving up flag) = 1
                                            
$A8:DA44 A5 12       LDA $12    [$7E:0012]  ;\
$A8:DA46 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;|
$A8:DA4A 29 00 FF    AND #$FF00             ;} $16 = |[$12]| / 100h
$A8:DA4D EB          XBA                    ;|
$A8:DA4E 85 16       STA $16    [$7E:0016]  ;/
$A8:DA50 BD AE 0F    LDA $0FAE,x[$7E:102E]  ;\
$A8:DA53 85 18       STA $18    [$7E:0018]  ;} $18 = [enemy speed]
$A8:DA55 20 B3 DA    JSR $DAB3  [$A8:DAB3]  ; $1E.$1C = [$16] * [$18] / 10000h
$A8:DA58 A5 1A       LDA $1A    [$7E:001A]  ;\
$A8:DA5A F0 03       BEQ $03    [$DA5F]     ;} If (moving up flag) != 0:
$A8:DA5C 20 F6 DA    JSR $DAF6  [$A8:DAF6]  ; Negate $1E.$1C

$A8:DA5F 18          CLC                    ;\
$A8:DA60 BD 80 0F    LDA $0F80,x[$7E:1000]  ;|
$A8:DA63 65 1C       ADC $1C    [$7E:001C]  ;|
$A8:DA65 9D 80 0F    STA $0F80,x[$7E:1000]  ;} Enemy Y position += [$1E].[$1C]
$A8:DA68 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$A8:DA6B 65 1E       ADC $1E    [$7E:001E]  ;|
$A8:DA6D 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A8:DA70 60          RTS
}


;;; $DA71: Accelerate bull ;;;
{
$A8:DA71 DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy acceleration interval timer
$A8:DA74 D0 1B       BNE $1B    [$DA91]     ; If [enemy acceleration interval timer] != 0: return
$A8:DA76 BF 0A 78 7E LDA $7E780A,x[$7E:788A];\
$A8:DA7A 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy acceleration interval timer = [acceleration interval timer reset value]
$A8:DA7D BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A8:DA80 18          CLC                    ;|
$A8:DA81 7D AC 0F    ADC $0FAC,x[$7E:102C]  ;} Enemy acceleration += [enemy acceleration delta]
$A8:DA84 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/
$A8:DA87 BD AE 0F    LDA $0FAE,x[$7E:102E]  ;\
$A8:DA8A 18          CLC                    ;|
$A8:DA8B 7D AA 0F    ADC $0FAA,x[$7E:102A]  ;} Enemy speed += [enemy acceleration]
$A8:DA8E 9D AE 0F    STA $0FAE,x[$7E:102E]  ;/

$A8:DA91 60          RTS
}


;;; $DA92: Decelerate bull ;;;
{
$A8:DA92 DE B2 0F    DEC $0FB2,x[$7E:1032]  ; Decrement enemy acceleration interval timer
$A8:DA95 D0 1B       BNE $1B    [$DAB2]     ; If [enemy acceleration interval timer] != 0: return
$A8:DA97 BF 0C 78 7E LDA $7E780C,x[$7E:788C];\
$A8:DA9B 9D B2 0F    STA $0FB2,x[$7E:1032]  ;} Enemy acceleration interval timer = [deceleration interval timer reset value]
$A8:DA9E BD AA 0F    LDA $0FAA,x[$7E:102A]  ;\
$A8:DAA1 38          SEC                    ;|
$A8:DAA2 FD AC 0F    SBC $0FAC,x[$7E:102C]  ;} Enemy acceleration -= [enemy acceleration delta]
$A8:DAA5 9D AA 0F    STA $0FAA,x[$7E:102A]  ;/
$A8:DAA8 BD AE 0F    LDA $0FAE,x[$7E:102E]  ;\
$A8:DAAB 38          SEC                    ;|
$A8:DAAC FD AA 0F    SBC $0FAA,x[$7E:102A]  ;} Enemy speed -= [enemy acceleration]
$A8:DAAF 9D AE 0F    STA $0FAE,x[$7E:102E]  ;/

$A8:DAB2 60          RTS
}


;;; $DAB3: $1E.$1C = [$16] * [$18] / 10000h (24-bit unsigned multiplication) ;;;
{
; Let:
;     $16 = a
;     $18 = b + c * 100h
$A8:DAB3 08          PHP
$A8:DAB4 E2 20       SEP #$20               ;\
$A8:DAB6 A5 16       LDA $16    [$7E:0016]  ;|
$A8:DAB8 8D 02 42    STA $4202              ;|
$A8:DABB A5 18       LDA $18    [$7E:0018]  ;|
$A8:DABD 8D 03 42    STA $4203              ;|
$A8:DAC0 EA          NOP                    ;} $1C = ab
$A8:DAC1 EA          NOP                    ;|
$A8:DAC2 EA          NOP                    ;|
$A8:DAC3 C2 20       REP #$20               ;|
$A8:DAC5 AD 16 42    LDA $4216              ;|
$A8:DAC8 85 1C       STA $1C    [$7E:001C]  ;/
$A8:DACA E2 20       SEP #$20               ;\
$A8:DACC A5 16       LDA $16    [$7E:0016]  ;|
$A8:DACE 8D 02 42    STA $4202              ;|
$A8:DAD1 A5 19       LDA $19    [$7E:0019]  ;|
$A8:DAD3 8D 03 42    STA $4203              ;|
$A8:DAD6 EA          NOP                    ;|
$A8:DAD7 EA          NOP                    ;} $1E = ac / 100h
$A8:DAD8 EA          NOP                    ;|
$A8:DAD9 C2 20       REP #$20               ;|
$A8:DADB AD 16 42    LDA $4216              ;|
$A8:DADE 29 00 FF    AND #$FF00             ;|
$A8:DAE1 EB          XBA                    ;|
$A8:DAE2 85 1E       STA $1E    [$7E:001E]  ;/
$A8:DAE4 AD 16 42    LDA $4216              ;\
$A8:DAE7 29 FF 00    AND #$00FF             ;|
$A8:DAEA EB          XBA                    ;|
$A8:DAEB 18          CLC                    ;|
$A8:DAEC 65 1C       ADC $1C    [$7E:001C]  ;} $1E.$1C = (ac / 100h + ab) / 10000h
$A8:DAEE 85 1C       STA $1C    [$7E:001C]  ;|
$A8:DAF0 90 02       BCC $02    [$DAF4]     ;|
$A8:DAF2 E6 1E       INC $1E    [$7E:001E]  ;/

$A8:DAF4 28          PLP
$A8:DAF5 60          RTS
}


;;; $DAF6: Negate $1E.$1C ;;;
{
; Actual result is as follows:
;     If [$1E].[$1C] = 0.0:
;         Return
;     
;     If [$1C] != 0:
;         $1E = -[$1E].[$1C]
;     Else:
;         $1E = -0.0001h - [$1E].[$1C]

$A8:DAF6 A5 1C       LDA $1C    [$7E:001C]  ;\
$A8:DAF8 D0 08       BNE $08    [$DB02]     ;} If [$1C] = 0:
$A8:DAFA A5 1E       LDA $1E    [$7E:001E]  ;\
$A8:DAFC F0 15       BEQ $15    [$DB13]     ;} If [$1E] = 0: return
$A8:DAFE C6 1C       DEC $1C    [$7E:001C]  ; $1C = FFFFh
$A8:DB00 80 0A       BRA $0A    [$DB0C]

$A8:DB02 A5 1C       LDA $1C    [$7E:001C]  ; >_<;
$A8:DB04 A9 00 00    LDA #$0000             ;\ Else ([$1C] != 0):
$A8:DB07 38          SEC                    ;|
$A8:DB08 E5 1C       SBC $1C    [$7E:001C]  ;} Negate $1C
$A8:DB0A 85 1C       STA $1C    [$7E:001C]  ;/

$A8:DB0C A5 1E       LDA $1E    [$7E:001E]  ;\
$A8:DB0E 49 FF FF    EOR #$FFFF             ;} $1E = -1 - [$1E]
$A8:DB11 85 1E       STA $1E    [$7E:001E]  ;/

$A8:DB13 60          RTS
}


;;; $DB14: Enemy shot - enemy $E97F (bull) ;;;
{
$A8:DB14 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DB17 BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A8:DB1A 9F 00 88 7E STA $7E8800,x[$7E:8880];} Enemy previous health = [enemy health]
$A8:DB1E 22 2D 80 A8 JSL $A8802D[$A8:802D]  ; Normal enemy shot AI
$A8:DB22 BD 8C 0F    LDA $0F8C,x[$7E:100C]  ;\
$A8:DB25 DF 00 88 7E CMP $7E8800,x[$7E:8880];} If [enemy health] != [enemy previous health]:
$A8:DB29 F0 01       BEQ $01    [$DB2C]     ;/
$A8:DB2B 6B          RTL                    ; Return

$A8:DB2C BF 06 78 7E LDA $7E7806,x[$7E:7886];\
$A8:DB30 D0 43       BNE $43    [$DB75]     ;} If [enemy shot reaction disable flag] != 0: return
$A8:DB32 A9 01 00    LDA #$0001             ;\
$A8:DB35 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A8:DB38 9E 90 0F    STZ $0F90,x[$7E:1010]  ; Enemy timer = 0
$A8:DB3B A9 55 D8    LDA #$D855             ;\
$A8:DB3E 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $D855 (shot)
$A8:DB41 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A8:DB44 0A          ASL A                  ;} Y = [collided projectile index] * 2
$A8:DB45 A8          TAY                    ;/
$A8:DB46 B9 04 0C    LDA $0C04,y[$7E:0C04]  ;\
$A8:DB49 29 0F 00    AND #$000F             ;|
$A8:DB4C 0A          ASL A                  ;|
$A8:DB4D A8          TAY                    ;} Enemy angle = [$D871 + ([projectile direction] & Fh) * 2]
$A8:DB4E B9 71 D8    LDA $D871,y[$A8:D875]  ;|
$A8:DB51 9F 04 78 7E STA $7E7804,x[$7E:7884];/
$A8:DB55 A9 00 01    LDA #$0100             ;\
$A8:DB58 9D AA 0F    STA $0FAA,x[$7E:102A]  ;} Enemy acceleration = 100h
$A8:DB5B A9 00 06    LDA #$0600             ;\
$A8:DB5E 9D AE 0F    STA $0FAE,x[$7E:102E]  ;} Enemy speed = 600h
$A8:DB61 A9 7C D9    LDA #$D97C             ;\
$A8:DB64 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = $D97C (decelerating)
$A8:DB67 A9 30 00    LDA #$0030             ;\
$A8:DB6A 9F 0E 78 7E STA $7E780E,x[$7E:788E];} Enemy shot reaction disable timer = 30h
$A8:DB6E A9 01 00    LDA #$0001             ;\
$A8:DB71 9F 06 78 7E STA $7E7806,x[$7E:7886];} Enemy shot reaction disable flag = 1

$A8:DB75 6B          RTL
}


;;; $DB76: Bull spritemaps ;;;
{
$A8:DB76             dx 0004, 81F8,00,210A, 81F0,00,2109, 81F8,F0,2107, 81F0,F0,2106
$A8:DB8C             dx 0004, 81F8,00,210D, 81F0,00,210C, 81F8,F0,2104, 81F0,F0,2103
$A8:DBA2             dx 0007, 0000,08,211F, 0000,00,210F, 01F8,08,2123, 01F0,08,2122, 81F0,F8,2110, 81F8,F0,2101, 81F0,F0,2100
}
}


;;; $DBC7..E22F: Alcoon ;;;
{
;;; $DBC7: Palette - enemy $E9BF (alcoon) ;;;
{
$A8:DBC7             dw 3800, 02FF, 01BF, 000F, 0008, 01BF, 011B, 00BA, 0011, 5A5C, 41B4, 290D, 1065, 03FF, 0237, 00D1
}


;;; $DBE7..DCC6: Instruction lists ;;;
{
;;; $DBE7: Instruction list - facing left - walking ;;;
{
$A8:DBE7             dx DF71,       ; Move horizontally
                        000A,DFA2,
                        DF71,       ; Move horizontally
                        000A,DFC2,
                        DF71,       ; Move horizontally
                        000A,DFE2,
                        DF63,       ; Decrement step counter and move horizontally
                        000A,E007,
                        80ED,DBE7   ; Go to $DBE7
}


;;; $DC03: Instruction list - facing left - spawn fireballs ;;;
{
$A8:DC03             dx 0014,E027,
                        0009,E047,
                        0010,E06C,
                        0003,E047,
                        DF33,       ; Spawn alcoon fireball with Y velocity index 2
                        000A,E09B,
                        000A,E027,
                        0009,E047,
                        0010,E06C,
                        0003,E047,
                        DF1C,       ; Spawn alcoon fireball with Y velocity index 0
                        000A,E09B,
                        000A,E027,
                        0009,E047,
                        0010,E06C,
                        0003,E047,
                        DF39,       ; Spawn alcoon fireball with Y velocity index 4
                        0028,E09B,
                        DF3F,       ; Start walking
                        0001,E09B
}


;;; $DC4B: Instruction list - facing left - airborne - looking up ;;;
{
$A8:DC4B             dx 7FFF,E0BB,
                        812F        ; Sleep
}


;;; $DC51: Instruction list - facing left - airborne - looking forward ;;;
{
$A8:DC51             dx 7FFF,E007,
                        812F        ; Sleep
}


;;; $DC57: Instruction list - facing right - walking ;;;
{
$A8:DC57             dx DF71,       ; Move horizontally
                        000A,E0DB,
                        DF71,       ; Move horizontally
                        000A,E0FB,
                        DF71,       ; Move horizontally
                        000A,E11B,
                        DF63,       ; Decrement step counter and move horizontally
                        000A,E140,
                        80ED,DC57   ; Go to $DC57
}


;;; $DC73: Instruction list - facing right - spawn fireballs ;;;
{
$A8:DC73             dx 0014,E160,
                        0009,E180,
                        0010,E1A5,
                        0003,E180,
                        DF33,       ; Spawn alcoon fireball with Y velocity index 2
                        000A,E1D4,
                        000A,E160,
                        0009,E180,
                        0010,E1A5,
                        0003,E180,
                        DF1C,       ; Spawn alcoon fireball with Y velocity index 0
                        000A,E1D4,
                        000A,E160,
                        0009,E180,
                        0010,E1A5,
                        0003,E180,
                        DF39,       ; Spawn alcoon fireball with Y velocity index 4
                        0028,E1D4,
                        DF3F,       ; Start walking
                        0001,E1D4
}


;;; $DCBB: Instruction list - facing right - airborne - looking up ;;;
{
$A8:DCBB             dx 7FFF,E1F4,
                        812F        ; Sleep
}


;;; $DCC1: Instruction list - facing right - airborne - looking forward ;;;
{
$A8:DCC1             dx 7FFF,E140,
                        812F        ; Sleep
}
}


;;; $DCC7: Alcoon constants ;;;
{
$A8:DCC7             dw 0050 ; X threshold to emerge
$A8:DCC9             dw 0040 ; Unused
$A8:DCCB             dw 0070 ; X threshold to hide
}


;;; $DCCD: Initialisation AI - enemy $E9BF (alcoon) ;;;
{
$A8:DCCD AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DCD0 A9 00 00    LDA #$0000             ;\
$A8:DCD3 9F 08 78 7E STA $7E7808,x[$7E:78C8];} Enemy step counter = 0
$A8:DCD7 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A8:DCDA 9D B2 0F    STA $0FB2,x[$7E:1072]  ;} Enemy spawn Y position = [enemy Y position]
$A8:DCDD BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$A8:DCE0 9F 04 78 7E STA $7E7804,x[$7E:78C4];} Enemy spawn X position = [enemy X position]
$A8:DCE4 BD 86 0F    LDA $0F86,x[$7E:1046]  ;\
$A8:DCE7 09 00 20    ORA #$2000             ;} Set enemies to process instructions
$A8:DCEA 9D 86 0F    STA $0F86,x[$7E:1046]  ;/
$A8:DCED A9 E7 DB    LDA #$DBE7             ;\
$A8:DCF0 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $DBE7 (facing left - walking)
$A8:DCF3 A9 71 DD    LDA #$DD71             ;\
$A8:DCF6 9D A8 0F    STA $0FA8,x[$7E:1068]  ;} Enemy function = $DD71 (wait for Samus to get near)
$A8:DCF9 20 37 DD    JSR $DD37  [$A8:DD37]  ; Set up jump movement

; LOOP_RISING
$A8:DCFC BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:DCFF 18          CLC                    ;|
$A8:DD00 7D 80 0F    ADC $0F80,x[$7E:1040]  ;|
$A8:DD03 9D 80 0F    STA $0F80,x[$7E:1040]  ;} Enemy Y position += [enemy Y velocity]
$A8:DD06 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;|
$A8:DD09 7D 7E 0F    ADC $0F7E,x[$7E:103E]  ;|
$A8:DD0C 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;/
$A8:DD0F 20 55 DD    JSR $DD55  [$A8:DD55]  ; Alcoon Y acceleration
$A8:DD12 30 E8       BMI $E8    [$DCFC]     ; If [enemy Y velocity] < 0: go to LOOP_RISING

; LOOP_FALLING
$A8:DD14 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:DD17 85 12       STA $12    [$7E:0012]  ;|
$A8:DD19 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;} Move enemy down by [enemy Y velocity]
$A8:DD1C 85 14       STA $14    [$7E:0014]  ;|
$A8:DD1E 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:DD22 B0 05       BCS $05    [$DD29]     ; If not collided with block:
$A8:DD24 20 55 DD    JSR $DD55  [$A8:DD55]  ; Alcoon Y acceleration
$A8:DD27 80 EB       BRA $EB    [$DD14]     ; Go to LOOP_FALLING

$A8:DD29 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A8:DD2C 9F 06 78 7E STA $7E7806,x[$7E:78C6];} Enemy landing Y position = [enemy Y position]
$A8:DD30 BD B2 0F    LDA $0FB2,x[$7E:1072]  ;\
$A8:DD33 9D 7E 0F    STA $0F7E,x[$7E:103E]  ;} Enemy Y position = [enemy spawn Y position]
$A8:DD36 6B          RTL
}


;;; $DD37: Set up jump movement ;;;
{
$A8:DD37 A9 F4 FF    LDA #$FFF4             ;\
$A8:DD3A 9D AA 0F    STA $0FAA,x[$7E:106A]  ;|
$A8:DD3D A9 00 00    LDA #$0000             ;} Enemy Y velocity = -C.0h
$A8:DD40 9D AC 0F    STA $0FAC,x[$7E:106C]  ;/
$A8:DD43 9D AE 0F    STA $0FAE,x[$7E:106E]  ; Enemy X velocity = 0
$A8:DD46 9D B0 0F    STA $0FB0,x[$7E:1070]  ; Enemy $0FB0 = 0 (never read)
$A8:DD49 9F 00 78 7E STA $7E7800,x[$7E:78C0];\
$A8:DD4D A9 00 80    LDA #$8000             ;} Enemy Y acceleration = 0.8000h
$A8:DD50 9F 02 78 7E STA $7E7802,x[$7E:78C2];/
$A8:DD54 60          RTS
}


;;; $DD55: Alcoon Y acceleration ;;;
{
$A8:DD55 BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A8:DD58 18          CLC                    ;|
$A8:DD59 7F 02 78 7E ADC $7E7802,x[$7E:78C2];|
$A8:DD5D 9D AC 0F    STA $0FAC,x[$7E:106C]  ;} Enemy Y velocity += [enemy Y acceleration]
$A8:DD60 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;|
$A8:DD63 7F 00 78 7E ADC $7E7800,x[$7E:78C0];|
$A8:DD67 9D AA 0F    STA $0FAA,x[$7E:106A]  ;/
$A8:DD6A 60          RTS
}


;;; $DD6B: Main AI - enemy $E9BF (alcoon) ;;;
{
$A8:DD6B AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DD6E 7C A8 0F    JMP ($0FA8,x)[$A8:DD71]; Go to [enemy function]
}


;;; $DD71: Alcoon function - wait for Samus to get near ;;;
{
$A8:DD71 BF 06 78 7E LDA $7E7806,x[$7E:78C6];\
$A8:DD75 38          SEC                    ;|
$A8:DD76 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$A8:DD79 10 04       BPL $04    [$DD7F]     ;|
$A8:DD7B 49 FF FF    EOR #$FFFF             ;} If |[enemy landing Y position] - [Samus Y position]| >= 20h: return
$A8:DD7E 1A          INC A                  ;|
                                            ;|
$A8:DD7F C9 20 00    CMP #$0020             ;|
$A8:DD82 10 3F       BPL $3F    [$DDC3]     ;/
$A8:DD84 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:DD87 38          SEC                    ;|
$A8:DD88 FD 7A 0F    SBC $0F7A,x[$7E:10BA]  ;|
$A8:DD8B 08          PHP                    ;|
$A8:DD8C 10 04       BPL $04    [$DD92]     ;|
$A8:DD8E 49 FF FF    EOR #$FFFF             ;} If |[Samus X position] - [enemy X position]| >= 50h: return
$A8:DD91 1A          INC A                  ;|
                                            ;|
$A8:DD92 CD C7 DC    CMP $DCC7  [$A8:DCC7]  ;|
$A8:DD95 10 2D       BPL $2D    [$DDC4]     ;/
$A8:DD97 20 37 DD    JSR $DD37  [$A8:DD37]  ; Set up jump movement
$A8:DD9A A0 4B DC    LDY #$DC4B             ; Enemy instruction list pointer = $DC4B (facing left - airborne - looking up)
$A8:DD9D A9 FE FF    LDA #$FFFE             ; Enemy X velocity = -2
$A8:DDA0 28          PLP                    ;\
$A8:DDA1 30 06       BMI $06    [$DDA9]     ;} If [Samus X position] >= [enemy X position]:
$A8:DDA3 A0 BB DC    LDY #$DCBB             ; Enemy instruction list pointer = $DCBB (airborne - looking up)
$A8:DDA6 A9 02 00    LDA #$0002             ; Enemy X velocity = 2

$A8:DDA9 9D AE 0F    STA $0FAE,x[$7E:10EE]
$A8:DDAC 98          TYA
$A8:DDAD 9D 92 0F    STA $0F92,x[$7E:10D2]
$A8:DDB0 A9 01 00    LDA #$0001             ;\
$A8:DDB3 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:DDB6 A9 C6 DD    LDA #$DDC6             ;\
$A8:DDB9 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = $DDC6 (emerging - rising)
$A8:DDBC A9 5E 00    LDA #$005E             ;\
$A8:DDBF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Eh, sound library 2, max queued sounds allowed = 6 (alcoon spawns)

$A8:DDC3 6B          RTL

$A8:DDC4 28          PLP
$A8:DDC5 6B          RTL
}


;;; $DDC6: Alcoon function - emerging - rising ;;;
{
$A8:DDC6 BD AC 0F    LDA $0FAC,x[$7E:10EC]  ;\
$A8:DDC9 18          CLC                    ;|
$A8:DDCA 7D 80 0F    ADC $0F80,x[$7E:10C0]  ;|
$A8:DDCD 9D 80 0F    STA $0F80,x[$7E:10C0]  ;} Enemy Y position += [enemy Y velocity]
$A8:DDD0 BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;|
$A8:DDD3 7D 7E 0F    ADC $0F7E,x[$7E:10BE]  ;|
$A8:DDD6 9D 7E 0F    STA $0F7E,x[$7E:10BE]  ;/
$A8:DDD9 20 55 DD    JSR $DD55  [$A8:DD55]  ; Alcoon Y acceleration
$A8:DDDC 30 1B       BMI $1B    [$DDF9]     ; If [enemy Y velocity] < 0: return

; BRANCH_FALLING
$A8:DDDE A9 05 DE    LDA #$DE05             ;\
$A8:DDE1 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = $DE05 (falling)
$A8:DDE4 A0 51 DC    LDY #$DC51             ; Enemy instruction list pointer = $DC51 (facing left - airborne - looking forward)
$A8:DDE7 BD AE 0F    LDA $0FAE,x[$7E:10EE]  ;\
$A8:DDEA 30 03       BMI $03    [$DDEF]     ;} If [enemy X velocity] >= 0:
$A8:DDEC A0 C1 DC    LDY #$DCC1             ; Enemy instruction list pointer = $DCC1 (facing right - airborne - looking forward)

$A8:DDEF 98          TYA
$A8:DDF0 9D 92 0F    STA $0F92,x[$7E:10D2]
$A8:DDF3 A9 01 00    LDA #$0001             ;\
$A8:DDF6 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1

$A8:DDF9 6B          RTL

; Nothing points here
$A8:DDFA A9 00 00    LDA #$0000             ;\
$A8:DDFD 9D AA 0F    STA $0FAA,x            ;} Enemy Y velocity = 0.0
$A8:DE00 9D AC 0F    STA $0FAC,x            ;/
$A8:DE03 80 D9       BRA $D9    [$DDDE]     ; Go to BRANCH_FALLING
}


;;; $DE05: Alcoon function - emerging - falling ;;;
{
$A8:DE05 BD AC 0F    LDA $0FAC,x[$7E:10EC]  ;\
$A8:DE08 85 12       STA $12    [$7E:0012]  ;|
$A8:DE0A BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;} Move enemy down by [enemy Y velocity]
$A8:DE0D 85 14       STA $14    [$7E:0014]  ;|
$A8:DE0F 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:DE13 B0 04       BCS $04    [$DE19]     ; If not collided with block:
$A8:DE15 20 55 DD    JSR $DD55  [$A8:DD55]  ; Alcoon Y acceleration
$A8:DE18 6B          RTL                    ; Return

$A8:DE19 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:DE1C 38          SEC                    ;} A = [Samus X position] - [enemy X position]
$A8:DE1D FD 7A 0F    SBC $0F7A,x[$7E:10BA]  ;/
$A8:DE20 08          PHP
$A8:DE21 A0 E7 DB    LDY #$DBE7             ; Enemy instruction list pointer = $DBE7 (facing left - walking)
$A8:DE24 A9 FE FF    LDA #$FFFE             ; Enemy X velocity = -2
$A8:DE27 28          PLP
$A8:DE28 30 06       BMI $06    [$DE30]     ; If [Samus X position] >= [enemy X position]:
$A8:DE2A A9 02 00    LDA #$0002             ; Enemy X velocity = 2
$A8:DE2D A0 57 DC    LDY #$DC57             ; Enemy instruction list pointer = $DC57 (facing right - walking)

$A8:DE30 9D AE 0F    STA $0FAE,x[$7E:10EE]
$A8:DE33 98          TYA
$A8:DE34 9D 92 0F    STA $0F92,x[$7E:10D2]
$A8:DE37 A9 01 00    LDA #$0001             ;\
$A8:DE3A 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:DE3D A9 4B DE    LDA #$DE4B             ;\
$A8:DE40 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = $DE4B
$A8:DE43 A9 01 00    LDA #$0001             ;\
$A8:DE46 9F 08 78 7E STA $7E7808,x[$7E:7948];} Enemy step counter = 1
$A8:DE4A 6B          RTL
}


;;; $DE4B: Alcoon function - emerged ;;;
{
$A8:DE4B 64 12       STZ $12    [$7E:0012]  ;\
$A8:DE4D A9 02 00    LDA #$0002             ;|
$A8:DE50 85 14       STA $14    [$7E:0014]  ;} Move enemy down by 2.0
$A8:DE52 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:DE56 BF 04 78 7E LDA $7E7804,x[$7E:7944];\
$A8:DE5A 38          SEC                    ;|
$A8:DE5B FD 7A 0F    SBC $0F7A,x[$7E:10BA]  ;|
$A8:DE5E 10 04       BPL $04    [$DE64]     ;|
$A8:DE60 49 FF FF    EOR #$FFFF             ;} If |[enemy spawn X position] - [enemy X position]| >= 70h: go to BRANCH_FAR_AWAY
$A8:DE63 1A          INC A                  ;|
                                            ;|
$A8:DE64 CD CB DC    CMP $DCCB  [$A8:DCCB]  ;|
$A8:DE67 10 3B       BPL $3B    [$DEA4]     ;/
$A8:DE69 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:DE6C 38          SEC                    ;} A = [Samus X position] - [enemy X position]
$A8:DE6D FD 7A 0F    SBC $0F7A,x[$7E:10BA]  ;/
$A8:DE70 08          PHP
$A8:DE71 10 04       BPL $04    [$DE77]     ;\
$A8:DE73 49 FF FF    EOR #$FFFF             ;} >_<;
$A8:DE76 1A          INC A                  ;/

$A8:DE77 BF 08 78 7E LDA $7E7808,x[$7E:7948];\
$A8:DE7B D0 0C       BNE $0C    [$DE89]     ;} If [enemy step counter] != 0: return
$A8:DE7D 28          PLP
$A8:DE7E 30 0B       BMI $0B    [$DE8B]     ; If [Samus X position] < [enemy X position]: go to BRANCH_LEFT
$A8:DE80 A0 73 DC    LDY #$DC73             ; Y = $DC73 (facing right - spawn fireballs)
$A8:DE83 BD AE 0F    LDA $0FAE,x[$7E:10AE]  ;\
$A8:DE86 10 0B       BPL $0B    [$DE93]     ;} If [enemy X velocity] >= 0: go to BRANCH_FIREBALLS
$A8:DE88 6B          RTL                    ; Return

$A8:DE89 28          PLP
$A8:DE8A 6B          RTL

; BRANCH_LEFT
$A8:DE8B A0 03 DC    LDY #$DC03             ; Y = $DC03 (facing left - spawn fireballs)
$A8:DE8E BD AE 0F    LDA $0FAE,x[$7E:10EE]  ;\
$A8:DE91 10 10       BPL $10    [$DEA3]     ;} If [enemy X velocity] >= 0: return

; BRANCH_FIREBALLS
$A8:DE93 98          TYA                    ;\
$A8:DE94 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = [Y]
$A8:DE97 A9 01 00    LDA #$0001             ;\
$A8:DE9A 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:DE9D A9 CC DE    LDA #$DECC             ;\
$A8:DEA0 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = RTL

$A8:DEA3 6B          RTL                    ; Return

; BRANCH_FAR_AWAY
$A8:DEA4 A9 CD DE    LDA #$DECD             ;\
$A8:DEA7 9D A8 0F    STA $0FA8,x            ;} Enemy function = $DECD (hiding - rising)
$A8:DEAA A9 FC FF    LDA #$FFFC             ;\
$A8:DEAD 9D AA 0F    STA $0FAA,x            ;|
$A8:DEB0 A9 00 00    LDA #$0000             ;} Enemy Y velocity = -4.0
$A8:DEB3 9D AC 0F    STA $0FAC,x            ;/
$A8:DEB6 A0 51 DC    LDY #$DC51             ; Enemy instruction list pointer = $DC51 (facing left - airborne - looking forward)
$A8:DEB9 BD AE 0F    LDA $0FAE,x            ;\
$A8:DEBC 30 03       BMI $03    [$DEC1]     ;} If [enemy X velocity] >= 0:
$A8:DEBE A0 C1 DC    LDY #$DCC1             ; Enemy instruction list pointer = $DCC1 (facing right - airborne - looking forward)

$A8:DEC1 98          TYA
$A8:DEC2 9D 92 0F    STA $0F92,x
$A8:DEC5 A9 01 00    LDA #$0001             ;\
$A8:DEC8 9D 94 0F    STA $0F94,x            ;} Enemy instruction timer = 1
$A8:DECB 6B          RTL
}


;;; $DECC: RTL ;;;
{
$A8:DECC 6B          RTL
}


;;; $DECD: Alcoon function - hiding - rising ;;;
{
$A8:DECD BD AC 0F    LDA $0FAC,x            ;\
$A8:DED0 18          CLC                    ;|
$A8:DED1 7D 80 0F    ADC $0F80,x            ;|
$A8:DED4 9D 80 0F    STA $0F80,x            ;} Enemy Y position += [enemy Y velocity]
$A8:DED7 BD AA 0F    LDA $0FAA,x            ;|
$A8:DEDA 7D 7E 0F    ADC $0F7E,x            ;|
$A8:DEDD 9D 7E 0F    STA $0F7E,x            ;/
$A8:DEE0 20 55 DD    JSR $DD55  [$A8:DD55]  ; Alcoon Y acceleration
$A8:DEE3 30 06       BMI $06    [$DEEB]     ; If [enemy Y velocity] >= 0:
$A8:DEE5 A9 EC DE    LDA #$DEEC             ;\
$A8:DEE8 9D A8 0F    STA $0FA8,x            ;} Enemy function = $DEEC (falling)

$A8:DEEB 6B          RTL
}


;;; $DEEC: Alcoon function - hiding - falling ;;;
{
$A8:DEEC BD AC 0F    LDA $0FAC,x            ;\
$A8:DEEF 18          CLC                    ;|
$A8:DEF0 7D 80 0F    ADC $0F80,x            ;|
$A8:DEF3 9D 80 0F    STA $0F80,x            ;} Enemy Y position += [enemy Y velocity]
$A8:DEF6 BD AA 0F    LDA $0FAA,x            ;|
$A8:DEF9 7D 7E 0F    ADC $0F7E,x            ;|
$A8:DEFC 9D 7E 0F    STA $0F7E,x            ;/
$A8:DEFF DD B2 0F    CMP $0FB2,x            ;\
$A8:DF02 10 04       BPL $04    [$DF08]     ;} If [enemy Y position] < [enemy spawn Y position]:
$A8:DF04 20 55 DD    JSR $DD55  [$A8:DD55]  ; Alcoon Y acceleration
$A8:DF07 6B          RTL                    ; Return

$A8:DF08 BD B2 0F    LDA $0FB2,x            ;\
$A8:DF0B 9D 7E 0F    STA $0F7E,x            ;} Enemy Y position = [enemy spawn Y position]
$A8:DF0E BF 04 78 7E LDA $7E7804,x          ;\
$A8:DF12 9D 7A 0F    STA $0F7A,x            ;} Enemy X position = [enemy spawn X position]
$A8:DF15 A9 71 DD    LDA #$DD71             ;\
$A8:DF18 9D A8 0F    STA $0FA8,x            ;} Enemy function = $DD71 (wait for Samus to get near)
$A8:DF1B 6B          RTL
}


;;; $DF1C..9B: Instructions ;;;
{
;;; $DF1C: Instruction - spawn alcoon fireball with Y velocity index 0 ;;;
{
$A8:DF1C 5A          PHY
$A8:DF1D A9 00 00    LDA #$0000             ; A = 0 (Y velocity index)
}


;;; $DF20: Spawn alcoon fireball with Y velocity index [A] ;;;
{
;; Parameters:
;;     A: Y velocity index

; Expects a pushed Y
$A8:DF20 A0 90 9E    LDY #$9E90             ;\
$A8:DF23 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Spawn alcoon fireball enemy projectile
$A8:DF26 22 27 80 86 JSL $868027[$86:8027]  ;/
$A8:DF2A A9 3F 00    LDA #$003F             ;\
$A8:DF2D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Fh, sound library 2, max queued sounds allowed = 6 (alcoon spit)
$A8:DF31 7A          PLY
$A8:DF32 6B          RTL
}


;;; $DF33: Instruction - spawn alcoon fireball with Y velocity index 2 ;;;
{
$A8:DF33 5A          PHY
$A8:DF34 A9 02 00    LDA #$0002             ; A = 2 (Y velocity index)
$A8:DF37 80 E7       BRA $E7    [$DF20]     ; Go to spawn alcoon fireball
}


;;; $DF39: Instruction - spawn alcoon fireball with Y velocity index 4 ;;;
{
$A8:DF39 5A          PHY
$A8:DF3A A9 04 00    LDA #$0004             ; A = 4 (Y velocity index)
$A8:DF3D 80 E1       BRA $E1    [$DF20]     ; Go to spawn alcoon fireball
}


;;; $DF3F: Instruction - start walking ;;;
{
$A8:DF3F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DF42 A9 4B DE    LDA #$DE4B             ;\
$A8:DF45 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = $DE4B (emerged)
$A8:DF48 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A8:DF4B 29 03 00    AND #$0003             ;} A = [random number] % 4
$A8:DF4E D0 03       BNE $03    [$DF53]     ; If [A] = 0:
$A8:DF50 A9 02 00    LDA #$0002             ; A = 2

$A8:DF53 9F 08 78 7E STA $7E7808,x[$7E:7948]; Enemy step counter = [A]
$A8:DF57 A0 E7 DB    LDY #$DBE7             ; Y = $DBE7 (facing left - walking)
$A8:DF5A BD AE 0F    LDA $0FAE,x[$7E:10EE]  ;\
$A8:DF5D 30 03       BMI $03    [$DF62]     ;} If [enemy X velocity] >= 0:
$A8:DF5F A0 57 DC    LDY #$DC57             ; Y = $DC57 (facing right - walking)

$A8:DF62 6B          RTL
}


;;; $DF63: Instruction - decrement step counter and move horizontally ;;;
{
$A8:DF63 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DF66 BF 08 78 7E LDA $7E7808,x[$7E:78C8];\
$A8:DF6A F0 05       BEQ $05    [$DF71]     ;} If [enemy step counter] != 0:
$A8:DF6C 3A          DEC A                  ;\
$A8:DF6D 9F 08 78 7E STA $7E7808,x[$7E:7948];} Decrement step counter
}


;;; $DF71: Instruction - move horizontally ;;;
{
$A8:DF71 5A          PHY
$A8:DF72 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:DF75 64 12       STZ $12    [$7E:0012]  ;\
$A8:DF77 BD AE 0F    LDA $0FAE,x[$7E:106E]  ;|
$A8:DF7A 85 14       STA $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity]
$A8:DF7C 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:DF80 B0 06       BCS $06    [$DF88]     ; If not collided with wall:
$A8:DF82 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A8:DF86 7A          PLY
$A8:DF87 6B          RTL                    ; Return

$A8:DF88 7A          PLY
$A8:DF89 A0 E9 DB    LDY #$DBE9             ; Y = $DBE9
$A8:DF8C BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A8:DF8F 10 03       BPL $03    [$DF94]     ;} If [enemy X velocity] < 0:
$A8:DF91 A0 59 DC    LDY #$DC59             ; Y = $DC59

$A8:DF94 49 FF FF    EOR #$FFFF             ;\
$A8:DF97 1A          INC A                  ;} Negate enemy X velocity
$A8:DF98 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;/
$A8:DF9B 6B          RTL
}
}


;;; $DF9C: RTL ;;;
{
$A8:DF9C 6B          RTL
}


;;; $DF9D: Unused. Normal enemy shot AI ;;;
{
$A8:DF9D 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A8:DFA1 6B          RTL
}


;;; $DFA2: Alcoon spritemaps ;;;
{
$A8:DFA2             dx 0006, 81FD,F3,2124, 8004,FC,210C, 81F8,F8,210A, 81F8,08,2102, 01ED,F0,212A, 81F5,E8,2100
$A8:DFC2             dx 0006, 8004,FB,210E, 81FD,F2,2126, 81F8,07,2104, 81F8,F7,210A, 01EE,EF,212A, 81F6,E7,2100
$A8:DFE2             dx 0007, 01FD,FB,213D, 01FD,F3,213C, 8004,FC,2120, 81F8,08,2106, 81F8,F8,210A, 01EF,F0,212A, 81F7,E8,2100
$A8:E007             dx 0006, 8004,FB,2122, 81FD,F2,2126, 81F8,07,2108, 81F8,F7,210A, 01EE,EF,212A, 81F6,E7,2100
$A8:E027             dx 0006, 81FD,F3,2124, 8004,FC,210C, 81F8,08,2106, 81F8,F8,210A, 01EE,F0,212A, 81F6,E8,2100
$A8:E047             dx 0007, 81FE,F3,2126, 8005,FC,210E, 01F7,F0,212E, 81F8,08,2106, 81F9,F8,210A, 01F0,F0,212A, 81F7,E8,2100
$A8:E06C             dx 0009, 0000,F0,213B, 01FE,FB,213D, 01FE,F3,213C, 8005,FC,2120, 01F8,F0,212F, 81F8,08,2106, 81F9,F8,210A, 01F2,F0,212A, 81F8,E8,2100
$A8:E09B             dx 0006, 81FD,F3,2124, 8004,FC,2122, 01EE,F0,212B, 81F8,08,2106, 81F8,F8,210A, 81F6,E8,2100
$A8:E0BB             dx 0006, 81FD,F3,2124, 01FA,E4,613A, 81FA,EC,2128, 8004,FC,2122, 81F8,08,2108, 81F8,F8,210A
$A8:E0DB             dx 0006, 81F3,F3,6124, 81EC,FC,610C, 81F8,F8,610A, 81F8,08,6102, 000B,F0,612A, 81FB,E8,6100
$A8:E0FB             dx 0006, 81EC,FB,610E, 81F3,F2,6126, 81F8,07,6104, 81F8,F7,610A, 000A,EF,612A, 81FA,E7,6100
$A8:E11B             dx 0007, 01FB,FB,613D, 01FB,F3,613C, 81EC,FC,6120, 81F8,08,6106, 81F8,F8,610A, 0009,F0,612A, 81F9,E8,6100
$A8:E140             dx 0006, 81EC,FB,6122, 81F3,F2,6126, 81F8,07,6108, 81F8,F7,610A, 000A,EF,612A, 81FA,E7,6100
$A8:E160             dx 0006, 81F3,F3,6124, 81EC,FC,610C, 81F8,08,6106, 81F8,F8,610A, 000A,F0,612A, 81FA,E8,6100
$A8:E180             dx 0007, 81F2,F3,6126, 81EB,FC,610E, 0001,F0,612E, 81F8,08,6106, 81F7,F8,610A, 0008,F0,612A, 81F9,E8,6100
$A8:E1A5             dx 0009, 01F8,F0,613B, 01FA,FB,613D, 01FA,F3,613C, 81EB,FC,6120, 0000,F0,612F, 81F8,08,6106, 81F7,F8,610A, 0006,F0,612A, 81F8,E8,6100
$A8:E1D4             dx 0006, 81F3,F3,6124, 81EC,FC,6122, 000A,F0,612B, 81F8,08,6106, 81F8,F8,610A, 81FA,E8,6100
$A8:E1F4             dx 0006, 81F3,F3,6124, 01FE,E4,213A, 81F6,EC,6128, 81EC,FC,6122, 81F8,08,6108, 81F8,F8,610A

; Unused. X flipped version of the alcoon fireball enemy projectile
$A8:E214             dx 0001, 01FC,FC,612C
$A8:E21B             dx 0001, 01FC,FC,E12D
$A8:E222             dx 0001, 01FC,FC,A12C
$A8:E229             dx 0001, 01FC,FC,212D
}
}


;;; $E230..E586: Atomic ;;;
{
;;; $E230: Palette - enemy $E9FF (atomic) ;;;
{
$A8:E230             dw 3800, 7FFF, 56E0, 3180, 18C0, 6BC0, 5EC0, 4A20, 35A0, 7FFF, 039C, 0237, 00D1, 03FF, 0237, 00D1
}


;;; $E250: Palettes - atomic ;;;
{
$A8:E250             dw 3800,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,
$A8:E270             dw 3800,7FFF,6A40,44E0,2C20,7F20,7220,5D80,4900,03FF,001F,0016,000E,03FF,0237,00D1,
$A8:E290             dw 3800,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,435A,3694,15AD,0508,03FF,0237,00D1,
$A8:E2B0             dw 3800,7FFF,6A40,44E0,2C20,7F20,7220,5D80,4900,7FFF,039C,0237,00D1,03FF,0237,00D1,
$A8:E2D0             dw 3800,02FF,01BF,000F,0008,01BF,011B,00BA,0011,7FFF,039C,0237,00D1,03FF,0237,00D1,
$A8:E2F0             dw 3800,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000,0000
}


;;; $E310..7F: Instruction lists - atomic ;;;
{
;;; $E310: Instruction list - spinning up-right ;;;
{
$A8:E310             dx 0008,E489,
                        0008,E49F,
                        0008,E4B5,
                        0008,E4CB,
                        0008,E4E1,
                        0008,E4F2,
                        80ED,E310   ; Go to $E310
}


;;; $E32C: Instruction list - spinning up-left ;;;
{
$A8:E32C             dx 0008,E508,
                        0008,E51E,
                        0008,E534,
                        0008,E54A,
                        0008,E560,
                        0008,E571,
                        80ED,E32C   ; Go to $E32C
}


;;; $E348: Instruction list - spinning down-left ;;;
{
$A8:E348             dx 0008,E4F2,
                        0008,E4E1,
                        0008,E4CB,
                        0008,E4B5,
                        0008,E49F,
                        0008,E489,
                        80ED,E348   ; Go to $E348
}


;;; $E364: Instruction list - spinning down-right ;;;
{
$A8:E364             dx 0008,E571,
                        0008,E560,
                        0008,E54A,
                        0008,E534,
                        0008,E51E,
                        0008,E508,
                        80ED,E364   ; Go to $E364
}
}


;;; $E380: Atomic instruction list pointers ;;;
{
; Indexed by [enemy parameter 1] * 2
$A8:E380             dw E310, E32C, E348, E364
}


;;; $E388: Initialisation AI - enemy $E9FF (atomic) ;;;
{
$A8:E388 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E38B A9 01 00    LDA #$0001             ;\
$A8:E38E 9D 94 0F    STA $0F94,x[$7E:16D4]  ;} Enemy instruction timer = 1
$A8:E391 9E 90 0F    STZ $0F90,x[$7E:16D0]  ; Enemy timer = 0
$A8:E394 BD B4 0F    LDA $0FB4,x[$7E:16F4]  ;\
$A8:E397 0A          ASL A                  ;|
$A8:E398 A8          TAY                    ;} Enemy instruction list pointer = [$E380 + [enemy parameter 1] * 2]
$A8:E399 B9 80 E3    LDA $E380,y[$A8:E380]  ;|
$A8:E39C 9D 92 0F    STA $0F92,x[$7E:16D2]  ;/
$A8:E39F BD B6 0F    LDA $0FB6,x[$7E:16F6]  ;\
$A8:E3A2 0A          ASL A                  ;|
$A8:E3A3 0A          ASL A                  ;} Y = [enemy parameter 2] * 8 (linear speed table index)
$A8:E3A4 0A          ASL A                  ;|
$A8:E3A5 A8          TAY                    ;/
$A8:E3A6 B9 87 81    LDA $8187,y[$A8:8187]  ;\
$A8:E3A9 9F 02 78 7E STA $7E7802,x[$7E:7F42];|
$A8:E3AD B9 89 81    LDA $8189,y[$A8:8189]  ;} Enemy speed = [$8187 + [Y]].[$8187 + [Y] + 2]
$A8:E3B0 9F 00 78 7E STA $7E7800,x[$7E:7F40];/
$A8:E3B4 B9 8B 81    LDA $818B,y[$A8:818B]  ;\
$A8:E3B7 9F 06 78 7E STA $7E7806,x[$7E:7F46];|
$A8:E3BB B9 8D 81    LDA $818D,y[$A8:818D]  ;} Enemy negated speed = [$8187 + [Y] + 4].[$8187 + [Y] + 6]
$A8:E3BE 9F 04 78 7E STA $7E7804,x[$7E:7F44];/
$A8:E3C2 6B          RTL
}


;;; $E3C3: Main AI - enemy $E9FF (atomic) ;;;
{
$A8:E3C3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E3C6 20 D9 E3    JSR $E3D9  [$A8:E3D9]  ; Set atomic Y movement function
$A8:E3C9 20 EF E3    JSR $E3EF  [$A8:E3EF]  ; Set atomic X movement function
$A8:E3CC AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E3CF FC A8 0F    JSR ($0FA8,x)[$A8:E405]; Execute [enemy Y movement function]
$A8:E3D2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E3D5 FC AA 0F    JSR ($0FAA,x)[$A8:E462]; Execute [enemy X movement function]
$A8:E3D8 6B          RTL
}


;;; $E3D9: Set atomic Y movement function ;;;
{
$A8:E3D9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E3DC A9 05 E4    LDA #$E405             ;\
$A8:E3DF 9D A8 0F    STA $0FA8,x[$7E:16E8]  ;} Enemy Y movement function = $E405 (move up)
$A8:E3E2 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A8:E3E6 30 06       BMI $06    [$E3EE]     ;} If [Samus Y position] >= [enemy Y position]:
$A8:E3E8 A9 24 E4    LDA #$E424             ;\
$A8:E3EB 9D A8 0F    STA $0FA8,x[$7E:16E8]  ;} Enemy Y movement function = $E424 (move down)

$A8:E3EE 60          RTS
}


;;; $E3EF: Set atomic X movement function ;;;
{
$A8:E3EF AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E3F2 A9 43 E4    LDA #$E443             ;\
$A8:E3F5 9D AA 0F    STA $0FAA,x[$7E:16EA]  ;} Enemy X movement function = $E443 (move left)
$A8:E3F8 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:E3FC 30 06       BMI $06    [$E404]     ;} If [Samus X position] >= [enemy X position]:
$A8:E3FE A9 62 E4    LDA #$E462             ;\
$A8:E401 9D AA 0F    STA $0FAA,x[$7E:16EA]  ;} Enemy X movement function = $E462 (move right)

$A8:E404 60          RTS
}


;;; $E405: Atomic Y movement function - move up ;;;
{
$A8:E405 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E408 BD 7E 0F    LDA $0F7E,x[$7E:16BE]  ;\
$A8:E40B 18          CLC                    ;|
$A8:E40C 7F 06 78 7E ADC $7E7806,x[$7E:7F46];|
$A8:E410 9D 7E 0F    STA $0F7E,x[$7E:16BE]  ;|
$A8:E413 BD 80 0F    LDA $0F80,x[$7E:16C0]  ;|
$A8:E416 18          CLC                    ;} Enemy Y position += [enemy negated speed]
$A8:E417 7F 04 78 7E ADC $7E7804,x[$7E:7F44];|
$A8:E41B 90 03       BCC $03    [$E420]     ;|
$A8:E41D FE 7E 0F    INC $0F7E,x[$7E:103E]  ;|
                                            ;|
$A8:E420 9D 80 0F    STA $0F80,x[$7E:16C0]  ;/
$A8:E423 60          RTS
}


;;; $E424: Atomic Y movement function - move down ;;;
{
$A8:E424 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E427 BD 7E 0F    LDA $0F7E,x[$7E:16BE]  ;\
$A8:E42A 18          CLC                    ;|
$A8:E42B 7F 02 78 7E ADC $7E7802,x[$7E:7F42];|
$A8:E42F 9D 7E 0F    STA $0F7E,x[$7E:16BE]  ;|
$A8:E432 BD 80 0F    LDA $0F80,x[$7E:16C0]  ;|
$A8:E435 18          CLC                    ;} Enemy Y position += [enemy speed]
$A8:E436 7F 00 78 7E ADC $7E7800,x[$7E:7F40];|
$A8:E43A 90 03       BCC $03    [$E43F]     ;|
$A8:E43C FE 7E 0F    INC $0F7E,x[$7E:107E]  ;|
                                            ;|
$A8:E43F 9D 80 0F    STA $0F80,x[$7E:16C0]  ;/
$A8:E442 60          RTS
}


;;; $E443: Atomic X movement function - move left ;;;
{
$A8:E443 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E446 BD 7A 0F    LDA $0F7A,x[$7E:16FA]  ;\
$A8:E449 18          CLC                    ;|
$A8:E44A 7F 06 78 7E ADC $7E7806,x[$7E:7F86];|
$A8:E44E 9D 7A 0F    STA $0F7A,x[$7E:16FA]  ;|
$A8:E451 BD 7C 0F    LDA $0F7C,x[$7E:16FC]  ;|
$A8:E454 18          CLC                    ;} Enemy X position += [enemy negated speed]
$A8:E455 7F 04 78 7E ADC $7E7804,x[$7E:7F84];|
$A8:E459 90 03       BCC $03    [$E45E]     ;|
$A8:E45B FE 7A 0F    INC $0F7A,x[$7E:107A]  ;|
                                            ;|
$A8:E45E 9D 7C 0F    STA $0F7C,x[$7E:16FC]  ;/
$A8:E461 60          RTS
}


;;; $E462: Atomic X movement function - move right ;;;
{
$A8:E462 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E465 BD 7A 0F    LDA $0F7A,x[$7E:16BA]  ;\
$A8:E468 18          CLC                    ;|
$A8:E469 7F 02 78 7E ADC $7E7802,x[$7E:7F42];|
$A8:E46D 9D 7A 0F    STA $0F7A,x[$7E:16BA]  ;|
$A8:E470 BD 7C 0F    LDA $0F7C,x[$7E:16BC]  ;|
$A8:E473 18          CLC                    ;} Enemy X position += [enemy speed]
$A8:E474 7F 00 78 7E ADC $7E7800,x[$7E:7F40];|
$A8:E478 90 03       BCC $03    [$E47D]     ;|
$A8:E47A FE 7A 0F    INC $0F7A,x[$7E:107A]  ;|
                                            ;|
$A8:E47D 9D 7C 0F    STA $0F7C,x[$7E:16BC]  ;/
$A8:E480 60          RTS
}


;;; $E481: Unused. RTL ;;;
{
$A8:E481 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E484 6B          RTL
}


;;; $E485: Unused. RTL ;;;
{
$A8:E485 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E488 6B          RTL
}


;;; $E489: Spritemaps - atomic ;;;
{
$A8:E489             dx 0004, 01F8,00,2102, 81F8,F8,2100, 01FC,F4,2103, 0004,FC,2103
$A8:E49F             dx 0004, 01FC,FC,2102, 81F8,F8,2100, 01F8,F8,2103, 0000,00,2103
$A8:E4B5             dx 0004, 0000,F8,2102, 81F8,F8,2100, 01F4,FC,2103, 01FC,04,2103
$A8:E4CB             dx 0004, 01F4,FC,2102, 01FC,04,2102, 81F8,F8,2100, 0001,F7,2103
$A8:E4E1             dx 0003, 01F8,F8,2102, 0000,00,2102, 81F8,F8,2100
$A8:E4F2             dx 0004, 01FC,F4,2102, 0004,FC,2102, 81F8,F8,2100, 01F7,01,2103
$A8:E508             dx 0004, 0000,00,2102, 81F8,F8,2100, 01FC,F4,2103, 01F4,FC,2103
$A8:E51E             dx 0004, 01FC,FC,2102, 81F8,F8,2100, 0000,F8,6103, 01F8,00,6103
$A8:E534             dx 0004, 01F8,F8,2102, 81F8,F8,2100, 0004,FC,2103, 01FC,04,2103
$A8:E54A             dx 0004, 0004,FC,2102, 01FC,04,2102, 81F8,F8,2100, 01F7,F7,2103
$A8:E560             dx 0003, 0000,F8,2102, 01F8,00,2102, 81F8,F8,2100
$A8:E571             dx 0004, 01FC,F4,2102, 01F4,FC,2102, 81F8,F8,2100, 0001,01,2103
}
}


;;; $E587..E7AB: Wrecked Ship spark ;;;
{
;;; $E587: Palette - enemy $EA3F (Wrecked Ship spark) ;;;
{
$A8:E587             dw 3800, 7FFF, 3BE0, 2680, 1580, 6BFA, 4BF2, 2BEA, 03E0, 0000, 0000, 0000, 0000, 0000, 0000, 0000
}


;;; $E5A7..E61C: Wrecked Ship spark instruction lists ;;;
{
;;; $E5A7: Instruction list - activate ;;;
{
$A8:E5A7             dx E62A,       ; Set enemy as tangible
                        0001,E74F,
                        0002,804D,
                        0001,E74F,
                        0002,804D,
                        0001,E76A,
                        0002,804D,
                        0001,E76A,
                        0001,804D,
                        0002,E785,
                        0002,E79B
}


;;; $E5D1: Instruction list - active ;;;
{
$A8:E5D1             dx 0003,E71F,
                        0003,E72B,
                        0003,E737,
                        0003,E743,
                        80ED,E5D1   ; Go to $E5D1
}


;;; $E5E5: Instruction list - deactivate ;;;
{
$A8:E5E5             dx 0001,E74F,
                        0001,E74F,
                        0001,E76A,
                        0001,E76A,
                        0001,E785,
                        0001,804D,
                        0001,E785,
                        0001,804D,
                        E61D,       ; Set enemy as intangible
                        812F        ; Sleep
}


;;; $E609: Instruction list - emit falling sparks ;;;
{
$A8:E609             dx 0003,E74F,
                        0003,E76A,
                        0003,E785,
                        0003,E79B,
                        80ED,E609   ; Go to $E609
}
}


;;; $E61D: Instruction - set enemy as intangible ;;;
{
$A8:E61D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E620 BD 86 0F    LDA $0F86,x[$7E:10C6]
$A8:E623 09 00 04    ORA #$0400
$A8:E626 9D 86 0F    STA $0F86,x[$7E:10C6]
$A8:E629 6B          RTL
}


;;; $E62A: Instruction - set enemy as tangible ;;;
{
$A8:E62A AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E62D BD 86 0F    LDA $0F86,x[$7E:10C6]
$A8:E630 29 FF FB    AND #$FBFF
$A8:E633 9D 86 0F    STA $0F86,x[$7E:10C6]
$A8:E636 6B          RTL
}


;;; $E637: Initialisation AI - enemy $EA3F (Wrecked Ship spark) ;;;
{
$A8:E637 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E63A BD B4 0F    LDA $0FB4,x[$7E:10F4]  ;\
$A8:E63D 29 03 00    AND #$0003             ;|
$A8:E640 0A          ASL A                  ;} Y = [enemy parameter 1] % 4 * 2
$A8:E641 A8          TAY                    ;/
$A8:E642 B9 88 E6    LDA $E688,y[$A8:E68A]  ;\
$A8:E645 9D AA 0F    STA $0FAA,x[$7E:10EA]  ;} Enemy function = [$E688 + [Y]]
$A8:E648 BD B6 0F    LDA $0FB6,x[$7E:10F6]  ;\
$A8:E64B 9D B0 0F    STA $0FB0,x[$7E:10F0]  ;} Enemy base function time = [enemy parameter 2]
$A8:E64E 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A8:E650 20 F6 E6    JSR $E6F6  [$A8:E6F6]  ; Set Wrecked Ship spark function timer
$A8:E653 A9 01 00    LDA #$0001             ;\
$A8:E656 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:E659 B9 82 E6    LDA $E682,y[$A8:E684]  ;\
$A8:E65C 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = [$E682 + [Y]]
$A8:E65F 9E 90 0F    STZ $0F90,x[$7E:10D0]  ; Enemy timer = 0
$A8:E662 A9 01 00    LDA #$0001             ;\
$A8:E665 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} >_<;
$A8:E668 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A8:E66B BF 28 D8 7E LDA $7ED828,x[$7E:D82B];|
$A8:E66F 29 01 00    AND #$0001             ;} If area boss is dead:
$A8:E672 F0 01       BEQ $01    [$E675]     ;/
$A8:E674 6B          RTL                    ; Return

$A8:E675 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E678 BD 86 0F    LDA $0F86,x            ;\
$A8:E67B 0D 00 01    ORA $0100  [$7E:0100]  ;} Enemy properties |= [$0100] <-- bug (should be 100h to make enemy invisible)
$A8:E67E 9D 86 0F    STA $0F86,x            ;/
$A8:E681 6B          RTL

$A8:E682             dw E5D1, E5D1, E609 ; Instruction list pointers
$A8:E688             dw E694, E6B7, E6DC ; Function pointers
}


;;; $E68E: Main AI - enemy $EA3F (Wrecked Ship spark) ;;;
{
$A8:E68E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E691 7C AA 0F    JMP ($0FAA,x)[$A8:E6B7]; Go to [enemy function]
}


;;; $E694: RTL. Wrecked Ship spark function - always active ;;;
{
$A8:E694 6B          RTL
}


;;; $E695: Wrecked Ship spark function - intermittent - inactive ;;;
{
$A8:E695 BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A8:E698 3A          DEC A                  ;} If [enemy function timer] != 1:
$A8:E699 F0 04       BEQ $04    [$E69F]     ;/
$A8:E69B 9D B2 0F    STA $0FB2,x[$7E:10F2]  ; Decrement enemy function timer
$A8:E69E 6B          RTL                    ; Return

$A8:E69F A9 B7 E6    LDA #$E6B7             ;\
$A8:E6A2 9D AA 0F    STA $0FAA,x[$7E:10EA]  ;} Enemy function = $E6B7 (active)
$A8:E6A5 A9 A7 E5    LDA #$E5A7             ;\
$A8:E6A8 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = $E5A7 (activate)
$A8:E6AB A9 01 00    LDA #$0001             ;\
$A8:E6AE 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:E6B1 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A8:E6B3 20 F6 E6    JSR $E6F6  [$A8:E6F6]  ; Set Wrecked Ship spark function timer
$A8:E6B6 6B          RTL
}

 
;;; $E6B7: Wrecked Ship spark function - intermittent - active ;;;
{
$A8:E6B7 BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A8:E6BA 3A          DEC A                  ;} If [enemy function timer] != 1:
$A8:E6BB F0 04       BEQ $04    [$E6C1]     ;/
$A8:E6BD 9D B2 0F    STA $0FB2,x[$7E:10F2]  ; Decrement enemy function timer
$A8:E6C0 6B          RTL                    ; Return

$A8:E6C1 A9 95 E6    LDA #$E695             ;\
$A8:E6C4 9D AA 0F    STA $0FAA,x[$7E:10EA]  ;} Enemy function = $E695 (inactive)
$A8:E6C7 A9 E5 E5    LDA #$E5E5             ;\
$A8:E6CA 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = $E5E5 (deactivate)
$A8:E6CD A9 01 00    LDA #$0001             ;\
$A8:E6D0 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:E6D3 A9 08 00    LDA #$0008             ;\
$A8:E6D6 85 12       STA $12    [$7E:0012]  ;} $12 = 8
$A8:E6D8 20 F6 E6    JSR $E6F6  [$A8:E6F6]  ; Set Wrecked Ship spark function timer
$A8:E6DB 6B          RTL
}


;;; $E6DC: Wrecked Ship spark function - emit falling sparks ;;;
{
$A8:E6DC BD B2 0F    LDA $0FB2,x[$7E:1132]  ;\
$A8:E6DF 3A          DEC A                  ;} If [enemy function timer] != 1:
$A8:E6E0 F0 04       BEQ $04    [$E6E6]     ;/
$A8:E6E2 9D B2 0F    STA $0FB2,x[$7E:1132]  ; Decrement enemy function timer
$A8:E6E5 6B          RTL                    ; Return

$A8:E6E6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E6E9 A0 98 F4    LDY #$F498             ;\
$A8:E6EC 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn falling spark enemy projectile
$A8:E6F0 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A8:E6F2 20 F6 E6    JSR $E6F6  [$A8:E6F6]  ; Set Wrecked Ship spark function timer
$A8:E6F5 6B          RTL
}


;;; $E6F6: Set Wrecked Ship spark function timer ;;;
{
;; Parameters:
;;     $12: Additional function time
$A8:E6F6 BD B0 0F    LDA $0FB0,x[$7E:10F0]  ; A = [enemy base function time]
$A8:E6F9 10 0B       BPL $0B    [$E706]     ; If [A] < 0:
$A8:E6FB 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A8:E6FF 29 3F 00    AND #$003F             ;\
$A8:E702 18          CLC                    ;} A = [random number] % 40h + 4
$A8:E703 69 04 00    ADC #$0004             ;/

$A8:E706 18          CLC                    ;\
$A8:E707 65 12       ADC $12    [$7E:0012]  ;} Enemy function timer = [A] + [$12]
$A8:E709 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;/
$A8:E70C 60          RTS
}


;;; $E70D: RTL ;;;
{
$A8:E70D 6B          RTL
}


;;; $E70E: Enemy shot - enemy $EA3F (Wrecked Ship spark) ;;;
{
$A8:E70E DA          PHX
$A8:E70F AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A8:E712 0A          ASL A                  ;} X = [collided projectile index] * 2
$A8:E713 AA          TAX                    ;/
$A8:E714 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$A8:E717 29 EF FF    AND #$FFEF             ;} Unflag projectile for deletion
$A8:E71A 9D 04 0C    STA $0C04,x[$7E:0C04]  ;/
$A8:E71D FA          PLX
$A8:E71E 6B          RTL
}


;;; $E71F: Spritemaps - Wrecked Ship spark ;;;
{
; Active
$A8:E71F             dx 0002, 01FC,01,3103, 01FC,FC,3100
$A8:E72B             dx 0002, 01FC,06,7104, 01FC,FC,3101
$A8:E737             dx 0002, 01FC,08,3105, 01FC,FC,3102
$A8:E743             dx 0002, 01FC,0A,3106, 01FC,FC,7101

; Activate / deactivate / emit falling sparks
$A8:E74F             dx 0005, 0002,FE,3109, 01F6,FC,3108, 0000,F8,3107, 01FC,03,3103, 01FC,FC,3100
$A8:E76A             dx 0005, 01F4,FC,3109, 0004,00,310A, 0002,F6,3108, 01FC,06,7104, 01FC,FC,3101
$A8:E785             dx 0004, 01F4,FC,310A, 0004,F4,3109, 01FC,09,3105, 01FC,FC,3102
$A8:E79B             dx 0003, 0004,F4,310A, 01FC,0E,3106, 01FC,FC,7101
}
}


;;; $E7AC..E999: Blue Brinstar face block ;;;
{
;;; $E7AC: Palette - enemy $EA7F (blue Brinstar face block) ;;;
{
$A8:E7AC             dw 3800, 72B2, 71C7, 2461, 1840, 7A8E, 660B, 4D03, 30A4, 30A4, 2461, 1840, 0800, 0000, 0000, 0000
}


;;; $E7CC: Blue Brinstar face block glow colours ;;;
{
$A8:E7CC             dw 001F,0012,000A,002B,
                        051F,0096,0011,0007,
                        0A3F,013B,0018,000D,
                        0F3F,01BF,001F,0012,
                        0F3F,01BF,001F,0012,
                        0A3F,013B,0018,000D,
                        051F,0096,0011,0007,
                        001F,0012,000A,002B
}


;;; $E80C: Instruction list - turning left ;;;
{
$A8:E80C             dx 0030,E92C,
                        0010,E942,
                        0010,E958,
                        812F        ; Sleep
}


;;; $E81A: Instruction list - turning right ;;;
{
$A8:E81A             dx 0030,E92C,
                        0010,E96E,
                        0010,E984,
                        812F        ; Sleep
}


;;; $E828: Instruction list - facing forward ;;;
{
$A8:E828             dx 0001,E92C,
                        812F        ; Sleep
}


;;; $E82E: Initialisation AI - enemy $EA7F (blue Brinstar face block) ;;;
{
$A8:E82E AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E831 A9 28 E8    LDA #$E828             ;\
$A8:E834 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $E828
$A8:E837 A0 6E E8    LDY #$E86E             ; Enemy graphics drawn hook = $E86E
$A8:E83A AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$A8:E83D 89 04 00    BIT #$0004             ;} If morph ball not collected:
$A8:E840 D0 03       BNE $03    [$E845]     ;/
$A8:E842 A0 4C 80    LDY #$804C             ; Enemy graphics drawn hook = RTL

$A8:E845 8C 8C 17    STY $178C  [$7E:178C]
$A8:E848 A9 A8 00    LDA #$00A8             ;\
$A8:E84B 8D 8E 17    STA $178E  [$7E:178E]  ;} Enemy graphics drawn hook bank = $A8
$A8:E84E BD 96 0F    LDA $0F96,x[$7E:1056]  ;\
$A8:E851 0A          ASL A                  ;|
$A8:E852 0A          ASL A                  ;|
$A8:E853 0A          ASL A                  ;|
$A8:E854 0A          ASL A                  ;} Enemy palette cycle enemy palette index = [enemy palette index] / 10h
$A8:E855 29 00 FF    AND #$FF00             ;|
$A8:E858 EB          XBA                    ;|
$A8:E859 8D 94 17    STA $1794  [$7E:1794]  ;/
$A8:E85C A9 10 00    LDA #$0010             ;\
$A8:E85F 8D 98 17    STA $1798  [$7E:1798]  ;} Enemy palette cycle timer = 10h
$A8:E862 BD B6 0F    LDA $0FB6,x[$7E:1076]  ;\
$A8:E865 29 01 00    AND #$0001             ;|
$A8:E868 6A          ROR A                  ;} Enemy direction to not turn = [enemy parameter 2] % 2 * 8000h
$A8:E869 6A          ROR A                  ;|
$A8:E86A 9D B6 0F    STA $0FB6,x[$7E:1076]  ;/
$A8:E86D 6B          RTL
}


;;; $E86E: Enemy graphics drawn hook - blue Brinstar face block - periodically cycle between palettes ;;;
{
; This enemy doesn't set $1796 to zero anywhere,
; so visiting a magdollite can cause this routine to execute with [$1796] >= 8,
; giving this enemy a glitch palette for its first palette cycle
$A8:E86E AD 97 07    LDA $0797  [$7E:0797]  ;\
$A8:E871 D0 3A       BNE $3A    [$E8AD]     ;} If currently transitioning the room: return
$A8:E873 AD 98 17    LDA $1798  [$7E:1798]  ;\
$A8:E876 3A          DEC A                  ;} Decrement enemy palette cycle timer
$A8:E877 8D 98 17    STA $1798  [$7E:1798]  ;/
$A8:E87A D0 31       BNE $31    [$E8AD]     ; If [enemy palette cycle timer] != 0: return
$A8:E87C A9 10 00    LDA #$0010             ;\
$A8:E87F 8D 98 17    STA $1798  [$7E:1798]  ;} Enemy palette cycle timer = 10h
$A8:E882 AD 94 17    LDA $1794  [$7E:1794]  ;\
$A8:E885 AA          TAX                    ;|
$A8:E886 AD 96 17    LDA $1796  [$7E:1796]  ;|
$A8:E889 0A          ASL A                  ;|
$A8:E88A 0A          ASL A                  ;|
$A8:E88B 0A          ASL A                  ;|
$A8:E88C A8          TAY                    ;|
$A8:E88D A9 04 00    LDA #$0004             ;|
$A8:E890 8D 0B 06    STA $060B  [$7E:060B]  ;|
                                            ;} Copy 4 colours from $E7CC + [enemy palette cycle colour set index] * 8 to enemy palette colours 9..Ch
$A8:E893 B9 CC E7    LDA $E7CC,y[$A8:E7CC]  ;|
$A8:E896 9F 12 C1 7E STA $7EC112,x[$7E:C1F2];|
$A8:E89A C8          INY                    ;|
$A8:E89B C8          INY                    ;|
$A8:E89C E8          INX                    ;|
$A8:E89D E8          INX                    ;|
$A8:E89E CE 0B 06    DEC $060B  [$7E:060B]  ;|
$A8:E8A1 D0 F0       BNE $F0    [$E893]     ;/
$A8:E8A3 AD 96 17    LDA $1796  [$7E:1796]  ;\
$A8:E8A6 1A          INC A                  ;|
$A8:E8A7 29 07 00    AND #$0007             ;} Enemy palette cycle colour set index = ([enemy palette cycle colour set index] + 1) % 8
$A8:E8AA 8D 96 17    STA $1796  [$7E:1796]  ;/

$A8:E8AD 6B          RTL
}


;;; $E8AE: Main AI - enemy $EA7F (blue Brinstar face block) ;;;
{
$A8:E8AE AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:E8B1 AD A4 09    LDA $09A4  [$7E:09A4]  ;\
$A8:E8B4 89 04 00    BIT #$0004             ;} If morph ball not collected: return
$A8:E8B7 F0 62       BEQ $62    [$E91B]     ;/
$A8:E8B9 A0 6E E8    LDY #$E86E             ;\
$A8:E8BC 8C 8C 17    STY $178C  [$7E:178C]  ;} Enemy graphics drawn hook = $E86E
$A8:E8BF BD 96 0F    LDA $0F96,x[$7E:10D6]  ;\
$A8:E8C2 0A          ASL A                  ;|
$A8:E8C3 0A          ASL A                  ;|
$A8:E8C4 0A          ASL A                  ;|
$A8:E8C5 0A          ASL A                  ;} Enemy palette cycle enemy palette index = [enemy palette index] / 10h
$A8:E8C6 29 00 FF    AND #$FF00             ;|
$A8:E8C9 EB          XBA                    ;|
$A8:E8CA 8D 94 17    STA $1794  [$7E:1794]  ;/
$A8:E8CD BD A8 0F    LDA $0FA8,x[$7E:10E8]  ;\
$A8:E8D0 D0 49       BNE $49    [$E91B]     ;} If [enemy activated flag] != 0: return
$A8:E8D2 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A8:E8D6 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;|
$A8:E8DA DD B4 0F    CMP $0FB4,x[$7E:10F4]  ;} If |[Samus Y position] - [enemy Y position]| >= [enemy parameter 1]: return
$A8:E8DD 10 3C       BPL $3C    [$E91B]     ;/
$A8:E8DF 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A8:E8E3 9D AA 0F    STA $0FAA,x[$7E:10EA]  ;} Enemy direction to Samus = [Samus X position] - [enemy X position]
$A8:E8E6 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;\
$A8:E8EA DD B4 0F    CMP $0FB4,x[$7E:10F4]  ;} If |[Samus X position] - [enemy X position]| >= [enemy parameter 1]: return
$A8:E8ED 10 2C       BPL $2C    [$E91B]     ;/
$A8:E8EF BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;\
$A8:E8F2 29 00 80    AND #$8000             ;|
$A8:E8F5 DD B6 0F    CMP $0FB6,x[$7E:10F6]  ;} If [enemy direction to Samus] & 8000h = [enemy direction to not turn]: return
$A8:E8F8 F0 21       BEQ $21    [$E91B]     ;/
$A8:E8FA A0 0C E8    LDY #$E80C             ; Enemy instruction list pointer = $E80C (turning left)
$A8:E8FD BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;\
$A8:E900 30 03       BMI $03    [$E905]     ;} If [direction to Samus] = right:
$A8:E902 A0 1A E8    LDY #$E81A             ; Enemy instruction list pointer = $E81A (turning right)

$A8:E905 98          TYA
$A8:E906 9D 92 0F    STA $0F92,x[$7E:10D2]
$A8:E909 A9 01 00    LDA #$0001             ;\
$A8:E90C 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction timer = 1
$A8:E90F A9 01 00    LDA #$0001             ;\
$A8:E912 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy activated flag = 1
$A8:E915 A9 10 00    LDA #$0010             ;\
$A8:E918 8D 98 17    STA $1798  [$7E:1798]  ;} Enemy palette cycle timer = 10h

$A8:E91B 6B          RTL
}


;;; $E91C: RTL ;;;
{
$A8:E91C 6B          RTL
}


;;; $E91D: Enemy shot - enemy $EA7F (blue Brinstar face block) ;;;
{
; Undeletes the collided projectile!
$A8:E91D AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A8:E920 0A          ASL A                  ;} X = [collided projectile index] * 2
$A8:E921 AA          TAX                    ;/
$A8:E922 BD 04 0C    LDA $0C04,x[$7E:0C04]  ;\
$A8:E925 29 EF FF    AND #$FFEF             ;} Unflag projectile for deletion
$A8:E928 9D 04 0C    STA $0C04,x[$7E:0C04]  ;/
$A8:E92B 6B          RTL
}


;;; $E92C: Blue Brinstar face block spritemaps ;;;
{
; Facing forward
$A8:E92C             dx 0004, 0000,00,3107, 01F8,00,3106, 0000,F8,3101, 01F8,F8,3100

; Turning left
$A8:E942             dx 0004, 0000,00,3109, 01F8,00,3108, 0000,F8,3103, 01F8,F8,3102
$A8:E958             dx 0004, 0000,00,310B, 01F8,00,310A, 0000,F8,3105, 01F8,F8,3104

; Turning right
$A8:E96E             dx 0004, 01F8,00,7109, 0000,00,7108, 01F8,F8,7103, 0000,F8,7102
$A8:E984             dx 0004, 01F8,00,710B, 0000,00,710A, 01F8,F8,7105, 0000,F8,7104
}
}


;;; $E99A..F9BD: Ki-hunter ;;;
{
;;; $E99A: Palette - enemy $EABF/$EAFF (green ki-hunter) ;;;
{
$A8:E99A             dw 3800, 4B57, 3A4D, 0CE2, 0040, 46B0, 2E0B, 1D66, 1524, 48FF, 38B6, 246E, 1448, 03FF, 0237, 00D1
}


;;; $E9BA: Palette - enemy $EB3F/$EB7F (yellow ki-hunter) ;;;
{
$A8:E9BA             dw 3800, 57FF, 42F7, 158C, 00A5, 4F5A, 36B5, 2610, 1DCE, 03E0, 0301, 01A1, 00C1, 6BFA, 42B0, 1545
}


;;; $E9DA: Palette - enemy $EB7F/$EBBF (red ki-hunter) ;;;
{
$A8:E9DA             dw 3800, 5ADF, 3975, 0C0A, 0006, 4E1A, 2D33, 1C8E, 102B, 6F11, 522A, 3124, 1824, 02FF, 01BF, 000F
}


;;; $E9FA..EB2D: Instruction lists - ki-hunter ;;;
{
;;; $E9FA: Instruction list - ki-hunter - idling - facing left ;;;
{
$A8:E9FA             dx 0002,EB2E,
                        0002,EB58,
                        0001,EB82,
                        F526        ; Set idling instruction lists facing forwards
}


;;; $EA08: Instruction list - ki-hunter - swiping - facing left ;;;
{
$A8:EA08             dx 0002,ECEA,
                        0006,ED14,
                        0002,ECEA,
                        0002,ECC0,
                        0002,ED3E,
                        0020,ED68,
                        80ED,E9FA   ; Go to $E9FA (idling - facing left)
}


;;; $EA24: Instruction list - ki-hunter - idling - facing right ;;;
{
$A8:EA24             dx 0002,EBF7,
                        0002,EC21,
                        0001,EC4B,
                        F526        ; Set idling instruction lists facing forwards
}


;;; $EA32: Instruction list - ki-hunter - swiping - facing right ;;;
{
$A8:EA32             dx 0002,EDBC,
                        0006,EDE6,
                        0002,EDBC,
                        0002,ED92,
                        0002,EE10,
                        0020,EE3A,
                        80ED,EA24   ; Go to $EA24 (idling - facing right)
}


;;; $EA4E: Instruction list - ki-hunter wings - facing left ;;;
{
$A8:EA4E             dx 0002,EBAC,
                        0002,EBC2,
                        0001,EBCE,
                        80ED,EA4E   ; Go to $EA4E
}


;;; $EA5E: Instruction list - ki-hunter wings - facing right ;;;
{
$A8:EA5E             dx 0002,EC75,
                        0002,EC8B,
                        0001,EC97,
                        80ED,EA5E   ; Go to $EA5E
}


;;; $EA6E: Unused. Instruction list - ki-hunter wings - falling - X flipped ;;;
{
$A8:EA6E             dx 0010,EBDF,
                        80ED,EA6E   ; Go to $EA6E
}


;;; $EA76: Unused. Instruction list - ki-hunter wings - falling - X flipped ;;;
{
; Spritemap $EBEB is a clone of $EBDF, so this instruction list is a clone of $EA6E
$A8:EA76             dx 0010,EBEB,
                        80ED,EA76   ; Go to $EA76
}


;;; $EA7E: Instruction list - ki-hunter wings - falling ;;;
{
$A8:EA7E             dx 0001,ECA8,
                        812F        ; Sleep
}


;;; $EA84: Unused. Instruction list - ki-hunter wings - falling ;;;
{
; Spritemap $ECB4 is a clone of $ECA8, so this instruction list is a clone of $EA7E
$A8:EA84             dx 0001,ECB4,
                        812F        ; Sleep
}


;;; $EA8A: Instruction list - ki-hunter - hop - facing left ;;;
{
$A8:EA8A             dx 0008,EE64,
                        0008,EE8E,
                        000B,EEB8,
                        0002,EE8E,
                        0002,EE64,
                        F5E4,       ; Enemy function = hop
                        0001,EEE2,
                        812F        ; Sleep
}


;;; $EAA6: Instruction list - ki-hunter - hop - facing right ;;;
{
$A8:EAA6             dx 0008,EF0C,
                        0008,EF36,
                        000B,EF60,
                        0002,EF36,
                        0002,EF0C,
                        F5E4,       ; Enemy function = hop
                        0001,EF8A,
                        812F        ; Sleep
}


;;; $EAC2: Instruction list - ki-hunter - landed from hop - facing left ;;;
{
$A8:EAC2             dx 0008,EE64,
                        0008,EE8E,
                        000B,EEB8,
                        0008,EE8E,
                        F67F,       ; Enemy function = wingless - thinking
                        0001,EE64,
                        812F        ; Sleep
}


;;; $EADA: Instruction list - ki-hunter - landed from hop - facing right ;;;
{
$A8:EADA             dx 0008,EF0C,
                        0008,EF36,
                        000B,EF60,
                        0008,EF36,
                        F67F,       ; Enemy function = wingless - thinking
                        0001,EF0C,
                        812F        ; Sleep
}


;;; $EAF2: Instruction list - acid spit attack - facing left ;;;
{
$A8:EAF2             dx 0020,EFB4,
                        0006,EFDE,
                        0010,F00D,
                        0002,F03C,
                        F6D2,       ; Fire acid spit left
                        0018,F06B,
                        F67F,       ; Enemy function = wingless - thinking
                        0001,EFB4,
                        812F        ; Sleep
}


;;; $EB10: Instruction list - acid spit attack - facing right ;;;
{
$A8:EB10             dx 0020,F09A,
                        0006,F0C4,
                        0010,F0F3,
                        0002,F122,
                        F6D8,       ; Fire acid spit right
                        0018,F151,
                        F67F,       ; Enemy function = wingless - thinking
                        0001,F09A,
                        812F        ; Sleep
}
}


;;; $EB2E: Ki-hunter spritemaps ;;;
{
$A8:EB2E             dx 0008, 01E5,03,210E, C3EB,FE,2126, C3F4,F8,212C, C3FD,01,211E, C3FD,09,212E, C200,00,2122, C3EF,F0,2100, 01E2,02,210E
$A8:EB58             dx 0008, 01E5,02,210E, C3EB,FD,2126, C3F4,F7,212C, C3FD,00,211E, C3FD,08,212E, C200,FF,2122, C3EF,EF,2100, 01E2,01,210E
$A8:EB82             dx 0008, 01E5,03,210E, C3EB,FE,2126, C3F4,F8,212C, C3FD,01,211E, C3FD,09,212E, C200,00,2122, C3EF,F0,2100, 01E2,02,210E
$A8:EBAC             dx 0004, 000B,E3,2144, 0001,E3,2143, C209,EB,2141, C201,EB,2140
$A8:EBC2             dx 0002, 0012,FB,2145, C202,F3,2146
$A8:EBCE             dx 0003, 0011,F3,2155, 0009,F3,2154, 0001,F3,2153
$A8:EBDF             dx 0002, C3FC,F8,2149, C3F4,F8,2148
$A8:EBEB             dx 0002, C3FC,F8,2149, C3F4,F8,2148
$A8:EBF7             dx 0008, 0013,03,610E, C205,FE,6126, C3FC,F8,612C, C3F3,01,611E, C3F3,09,612E, C3F0,00,6122, C201,F0,6100, 0016,02,610E
$A8:EC21             dx 0008, 0013,02,610E, C205,FD,6126, C3FC,F7,612C, C3F3,00,611E, C3F3,08,612E, C3F0,FF,6122, C201,EF,6100, 0016,01,610E
$A8:EC4B             dx 0008, 0013,03,610E, C205,FE,6126, C3FC,F8,612C, C3F3,01,611E, C3F3,09,612E, C3F0,00,6122, C201,F0,6100, 0016,02,610E
$A8:EC75             dx 0004, 01ED,E3,6144, 01F7,E3,6143, C3E7,EB,6141, C3EF,EB,6140
$A8:EC8B             dx 0002, 01E6,FB,6145, C3EE,F3,6146
$A8:EC97             dx 0003, 01E7,F3,6155, 01EF,F3,6154, 01F7,F3,6153
$A8:ECA8             dx 0002, C3F4,F8,6149, C3FC,F8,6148
$A8:ECB4             dx 0002, C3F4,F8,6149, C3FC,F8,6148
$A8:ECC0             dx 0008, 01E5,03,210E, C3EB,FE,2126, C3F4,F8,212C, C3FD,01,211E, C3FD,09,212E, C200,00,2122, C3EF,F0,2100, 01E2,02,210E
$A8:ECEA             dx 0008, 01E9,F5,210F, C3EC,FA,2128, C3F4,F8,212C, C3FD,01,211E, C3FD,09,212E, C200,00,2122, C3EF,F0,2100, 01E6,F4,210F
$A8:ED14             dx 0008, 01F0,F5,214F, C3EC,FA,2128, C3F4,F8,212C, C3FD,01,211E, C3FD,09,212E, C200,00,2122, C3EF,F0,2100, 01ED,F4,214F
$A8:ED3E             dx 0008, 01E8,0F,210E, C3ED,03,2124, C3F4,F9,212C, C3FD,01,211E, C3FD,09,212E, C200,00,2122, C3EF,F1,2100, 01E5,0E,210E
$A8:ED68             dx 0008, C3ED,03,2124, 01F0,0F,214E, C3F4,F9,212C, C3FD,02,211E, C3FD,0A,212E, C200,01,2122, C3EF,F2,2100, 01ED,0E,214E
$A8:ED92             dx 0008, 0013,03,610E, C205,FE,6126, C3FC,F8,612C, C3F3,01,611E, C3F3,09,612E, C3F0,00,6122, C201,F0,6100, 0016,02,610E
$A8:EDBC             dx 0008, 000F,F5,610F, C204,FA,6128, C3FC,F8,612C, C3F3,01,611E, C3F3,09,612E, C3F0,00,6122, C201,F0,6100, 0012,F4,610F
$A8:EDE6             dx 0008, 0008,F5,614F, C204,FA,6128, C3FC,F8,612C, C3F3,01,611E, C3F3,09,612E, C3F0,00,6122, C201,F0,6100, 000B,F4,614F
$A8:EE10             dx 0008, 0010,0F,610E, C203,03,6124, C3FC,F9,612C, C3F3,01,611E, C3F3,09,612E, C3F0,00,6122, C201,F1,6100, 0013,0E,610E
$A8:EE3A             dx 0008, C203,03,6124, 0008,0F,614E, C3FC,F9,612C, C3F3,02,611E, C3F3,0A,612E, C3F0,01,6122, C201,F2,6100, 000B,0E,614E
$A8:EE64             dx 0008, 01E3,FF,210E, C3E9,FA,2126, C3F2,F4,212C, C3FA,F8,215E, C3FA,00,216E, C3FE,FC,2122, C3EE,ED,2100, 01E0,FE,210E
$A8:EE8E             dx 0008, 01E3,04,210E, C3E9,FF,2126, C3F2,F9,212C, C3FB,00,2162, C3FE,01,2122, C3ED,F1,2100, 01E0,03,210E, C3F9,FF,2162
$A8:EEB8             dx 0008, 01E3,07,210E, C3E9,02,2126, C3F2,FC,212C, C3FB,00,2160, C3FE,04,2122, C3ED,F4,2100, 01E0,06,210E, C3F9,FF,2160
$A8:EEE2             dx 0008, 01E8,00,210E, C3EE,FB,2126, C3F7,F5,212C, C200,FE,211E, C200,06,212E, C203,FD,2122, C3F3,EE,2100, 01E5,FF,210E
$A8:EF0C             dx 0008, 0015,FF,610E, C207,FA,6126, C3FE,F4,612C, C3F6,F8,615E, C3F6,00,616E, C3F2,FC,6122, C202,ED,6100, 0018,FE,610E
$A8:EF36             dx 0008, 0015,04,610E, C207,FF,6126, C3FE,F9,612C, C3F5,00,6162, C3F2,01,6122, C203,F1,6100, 0018,03,610E, C3F7,FF,6162
$A8:EF60             dx 0008, 0015,07,610E, C207,02,6126, C3FE,FC,612C, C3F5,00,6160, C3F2,04,6122, C203,F4,6100, 0018,06,610E, C3F7,FF,6160
$A8:EF8A             dx 0008, 0012,FF,610E, C204,FA,6126, C3FB,F4,612C, C3F0,FE,611E, C3F0,06,612E, C3EF,FC,6122, C3FF,ED,6100, 0015,FE,610E
$A8:EFB4             dx 0008, 01E3,FF,210E, C3E9,FA,2126, C3F2,F4,212C, C3FA,F8,215E, C3FA,00,216E, C3FE,FC,2122, C3EE,ED,2100, 01E0,FE,210E
$A8:EFDE             dx 0009, 01E4,FF,210E, C3EA,FA,2126, C3F3,F4,212C, C3FA,F8,215E, C3FA,00,216E, C3FE,FC,2122, C3F2,EC,2103, C3EA,EC,2102, 01E1,FE,210E
$A8:F00D             dx 0009, 01E5,FF,210E, C3EB,FA,2126, C3F4,F4,212C, C3FA,F8,215E, C3FA,00,216E, C3FD,FC,2122, C3FC,EC,2107, C3EC,EC,2105, 01E2,FE,210E
$A8:F03C             dx 0009, 01E5,FF,210E, C3EB,FA,2126, C3F4,F4,212C, C3FA,F8,215E, C3FA,00,216E, C3EB,EC,210A, C3FB,EC,2107, C3FF,FC,2122, 01E2,FE,210E
$A8:F06B             dx 0009, 01E4,FF,210E, C3EA,FA,2126, C3F3,F4,212C, C3FA,F8,215E, C3FA,00,216E, C3FD,FC,2122, C3EA,EC,210C, C3FA,EC,2107, 01E1,FE,210E
$A8:F09A             dx 0008, 0015,FF,610E, C207,FA,6126, C3FE,F4,612C, C3F6,F8,615E, C3F6,00,616E, C3F2,FC,6122, C202,ED,6100, 0018,FE,610E
$A8:F0C4             dx 0009, 0014,FF,610E, C206,FA,6126, C3FD,F4,612C, C3F6,F8,615E, C3F6,00,616E, C3F2,FC,6122, C3FE,EC,6103, C206,EC,6102, 0017,FE,610E
$A8:F0F3             dx 0009, 0013,FF,610E, C205,FA,6126, C3FC,F4,612C, C3F6,F8,615E, C3F6,00,616E, C3F3,FC,6122, C3F4,EC,6107, C204,EC,6105, 0016,FE,610E
$A8:F122             dx 0009, 0013,FF,610E, C205,FA,6126, C3FC,F4,612C, C3F6,F8,615E, C3F6,00,616E, C205,EC,610A, C3F5,EC,6107, C3F1,FC,6122, 0016,FE,610E
$A8:F151             dx 0009, 0014,FF,610E, C206,FA,6126, C3FD,F4,612C, C3F6,F8,615E, C3F6,00,616E, C3F3,FC,6122, C206,EC,610C, C3F6,EC,6107, 0017,FE,610E
}


;;; $F180: Ki-hunter constants ;;;
{
$A8:F180             dw 0060 ; X proximity to activate swoop
$A8:F182             dw E000, 0000 ; Falling acceleration (for hop and for when wings are clipped)
$A8:F186             dw 0030 ; Falling wings arc radius
}


;;; $F188: Initialisation AI - enemy $EABF/$EB3F/$EBBF (ki-hunter) ;;;
{
$A8:F188 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F18B BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A8:F18E 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A8:F191 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A8:F194 A9 00 00    LDA #$0000             ;\
$A8:F197 9F 28 78 7E STA $7E7828,x[$7E:7828];} Enemy wingless flag = 0
$A8:F19B A9 01 00    LDA #$0001             ;\
$A8:F19E 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:F1A1 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A8:F1A4 A9 FA E9    LDA #$E9FA             ;\
$A8:F1A7 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $E9FA (idling - facing left)
$A8:F1AA A9 00 00    LDA #$0000             ;\
$A8:F1AD 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy arc angle = 0
$A8:F1B0 A9 68 F2    LDA #$F268             ;\
$A8:F1B3 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F268 (winged - idle flying)
$A8:F1B6 A9 00 00    LDA #$0000             ;\
$A8:F1B9 9F 10 78 7E STA $7E7810,x[$7E:7810];|
$A8:F1BD A9 01 00    LDA #$0001             ;} Enemy Y velocity = 1.0
$A8:F1C0 9F 12 78 7E STA $7E7812,x[$7E:7812];/
$A8:F1C4 A9 00 00    LDA #$0000             ;\
$A8:F1C7 9F 0C 78 7E STA $7E780C,x[$7E:780C];|
$A8:F1CB A9 FF FF    LDA #$FFFF             ;} Enemy X velocity = -1.0
$A8:F1CE 9F 0E 78 7E STA $7E780E,x[$7E:780E];/
$A8:F1D2 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:F1D5 38          SEC                    ;|
$A8:F1D6 E9 10 00    SBC #$0010             ;} Enemy idle zone top position = [enemy Y position] - 10h
$A8:F1D9 9F 14 78 7E STA $7E7814,x[$7E:7814];/
$A8:F1DD 18          CLC                    ;\
$A8:F1DE 69 20 00    ADC #$0020             ;} Enemy idle zone bottom position = [enemy Y position] + 10h
$A8:F1E1 9F 16 78 7E STA $7E7816,x[$7E:7816];/
$A8:F1E5 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:F1E8 9F 18 78 7E STA $7E7818,x[$7E:7818];} Enemy spawn X position = [enemy X position]
$A8:F1EC BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:F1EF 9F 1A 78 7E STA $7E781A,x[$7E:781A];} Enemy spawn Y position = [enemy Y position]
$A8:F1F3 BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A8:F1F6 10 1B       BPL $1B    [$F213]     ;} If [enemy parameter 1] & 8000h != 0 (no wings):
$A8:F1F8 A9 01 00    LDA #$0001             ;\
$A8:F1FB 9F 28 78 7E STA $7E7828,x[$7E:7828];} Enemy wingless flag = 1
$A8:F1FF A9 5A F5    LDA #$F55A             ;\
$A8:F202 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F55A (wingless - initial falling)
$A8:F205 A9 00 00    LDA #$0000             ;\
$A8:F208 9F 10 78 7E STA $7E7810,x[$7E:7810];|
$A8:F20C A9 01 00    LDA #$0001             ;} >_<;
$A8:F20F 9F 12 78 7E STA $7E7812,x[$7E:7812];/

$A8:F213 6B          RTL
}


;;; $F214: Initialisation AI - enemy $EAFF/$EB7F/$EBFF (ki-hunter wings) ;;;
{
$A8:F214 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F217 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A8:F21A 09 00 20    ORA #$2000             ;} Set enemy to process instructions
$A8:F21D 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A8:F220 A9 01 00    LDA #$0001             ;\
$A8:F223 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A8:F226 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0
$A8:F229 A9 4E EA    LDA #$EA4E             ;\
$A8:F22C 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $EA4E (facing left)
$A8:F22F BD 3E 0F    LDA $0F3E,x[$7E:0F7E]  ;\
$A8:F232 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy ([X] - 1) Y position]
$A8:F235 BD 3A 0F    LDA $0F3A,x[$7E:0F7A]  ;\
$A8:F238 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy ([X] - 1) X position]
$A8:F23B A9 F3 F6    LDA #$F6F3             ;\
$A8:F23E 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = $F6F3 (attached)
$A8:F241 BD 56 0F    LDA $0F56,x[$7E:0F96]  ;\
$A8:F244 9D 96 0F    STA $0F96,x[$7E:0FD6]  ;} Enemy palette index = [enemy ([X] - 1) palette index]
$A8:F247 BD 58 0F    LDA $0F58,x[$7E:0F98]  ;\
$A8:F24A 9D 98 0F    STA $0F98,x[$7E:0FD8]  ;} Enemy VRAM tiles index = [enemy ([X] - 1) VRAM tiles index]
$A8:F24D BD 74 0F    LDA $0F74,x[$7E:0FB4]  ;\
$A8:F250 10 09       BPL $09    [$F25B]     ;} If [enemy ([X] - 1) parameter 1] & 8000h != 0 (no wings):
$A8:F252 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A8:F255 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$A8:F258 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/

$A8:F25B 6B          RTL
}


;;; $F25C: Main AI - enemy $EABF/$EB3F/$EBBF (ki-hunter) ;;;
{
$A8:F25C AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F25F 7C A8 0F    JMP ($0FA8,x)[$A8:F268]; Execute [enemy function]
}


;;; $F262: Main AI - enemy $EAFF/$EB7F/$EBFF (ki-hunter wings) ;;;
{
$A8:F262 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F265 7C A8 0F    JMP ($0FA8,x)[$A8:F6F3]; Execute [enemy function]
}


;;; $F268: Ki-hunter function - winged - idle flying ;;;
{
$A8:F268 BF 10 78 7E LDA $7E7810,x[$7E:7810];\
$A8:F26C 85 12       STA $12    [$7E:0012]  ;|
$A8:F26E BF 12 78 7E LDA $7E7812,x[$7E:7812];} Move enemy down by [enemy Y velocity]
$A8:F272 85 14       STA $14    [$7E:0014]  ;|
$A8:F274 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:F278 B0 14       BCS $14    [$F28E]     ; If not collided with block:
$A8:F27A BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:F27D DF 14 78 7E CMP $7E7814,x[$7E:7814];} If [enemy Y position] < [enemy idle zone top position]: go to BRANCH_IDLE_DOWN
$A8:F281 30 15       BMI $15    [$F298]     ;/
$A8:F283 DF 16 78 7E CMP $7E7816,x[$7E:7816];\
$A8:F287 30 16       BMI $16    [$F29F]     ;} If [enemy Y position] < [enemy idle zone bottom position]: go to BRANCH_NO_CHANGE_Y
$A8:F289 A9 FF FF    LDA #$FFFF             ; Enemy Y velocity = -1
$A8:F28C 80 0D       BRA $0D    [$F29B]     ; Go to BRANCH_CHANGE_Y

$A8:F28E BF 12 78 7E LDA $7E7812,x[$7E:7892];\
$A8:F292 49 FF FF    EOR #$FFFF             ;} Negate enemy Y velocity
$A8:F295 1A          INC A                  ;/
$A8:F296 80 03       BRA $03    [$F29B]     ; Go to BRANCH_CHANGE_Y

; BRANCH_IDLE_DOWN
$A8:F298 A9 01 00    LDA #$0001             ; Enemy Y velocity = 1

; BRANCH_CHANGE_Y
$A8:F29B 9F 12 78 7E STA $7E7812,x[$7E:7812]

; BRANCH_NO_CHANGE_Y
$A8:F29F BF 0C 78 7E LDA $7E780C,x[$7E:780C];\
$A8:F2A3 85 12       STA $12    [$7E:0012]  ;|
$A8:F2A5 BF 0E 78 7E LDA $7E780E,x[$7E:780E];} Move enemy right by [enemy X velocity]
$A8:F2A9 85 14       STA $14    [$7E:0014]  ;|
$A8:F2AB 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:F2AF 90 29       BCC $29    [$F2DA]     ; If not collided with wall: go to BRANCH_NO_COLLISION
$A8:F2B1 A0 00 00    LDY #$0000             ; Y = 0
$A8:F2B4 BF 0E 78 7E LDA $7E780E,x[$7E:798E];\
$A8:F2B8 49 FF FF    EOR #$FFFF             ;|
$A8:F2BB 1A          INC A                  ;} Negate enemy X velocity
$A8:F2BC 9F 0E 78 7E STA $7E780E,x[$7E:798E];/
$A8:F2C0 30 03       BMI $03    [$F2C5]     ; If [enemy X velocity] >= 0:
$A8:F2C2 A0 04 00    LDY #$0004             ; Y = 4

$A8:F2C5 B9 B0 F3    LDA $F3B0,y[$A8:F3B4]  ;\
$A8:F2C8 9D 92 0F    STA $0F92,x[$7E:1112]  ;} Enemy instruction list pointer = [$F3B0 + [Y]]
$A8:F2CB B9 B2 F3    LDA $F3B2,y[$A8:F3B6]  ;\
$A8:F2CE 9D D2 0F    STA $0FD2,x[$7E:1152]  ;} Wings enemy instruction list pointer = [$F3B0 + [Y] + 2]
$A8:F2D1 A9 01 00    LDA #$0001             ;\
$A8:F2D4 9D 94 0F    STA $0F94,x[$7E:1114]  ;} Enemy instruction timer = 1
$A8:F2D7 9D D4 0F    STA $0FD4,x[$7E:1154]  ; Wings enemy instruction timer = 1

; BRANCH_NO_COLLISION
$A8:F2DA 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A8:F2DE AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A8:F2E1 38          SEC                    ;|
$A8:F2E2 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;} $12 = [Samus X position] - [enemy X position]
$A8:F2E5 85 12       STA $12    [$7E:0012]  ;/
$A8:F2E7 10 04       BPL $04    [$F2ED]     ;\
$A8:F2E9 49 FF FF    EOR #$FFFF             ;|
$A8:F2EC 1A          INC A                  ;} $14 = |[Samus X position] - [enemy X position]|
                                            ;|
$A8:F2ED 85 14       STA $14    [$7E:0014]  ;/
$A8:F2EF CD 80 F1    CMP $F180  [$A8:F180]  ;\
$A8:F2F2 30 01       BMI $01    [$F2F5]     ;} If |[Samus X position] - [enemy X position]| >= 60h:
$A8:F2F4 6B          RTL                    ; Return

$A8:F2F5 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A8:F2F8 38          SEC                    ;|
$A8:F2F9 FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;} If [Samus Y position] - [enemy Y position] < 20h:
$A8:F2FC C9 20 00    CMP #$0020             ;|
$A8:F2FF 10 01       BPL $01    [$F302]     ;/
$A8:F301 6B          RTL                    ; Return

$A8:F302 85 18       STA $18    [$7E:0018]  ; $18 = [Samus Y position] - [enemy Y position]
$A8:F304 A5 12       LDA $12    [$7E:0012]  ;\
$A8:F306 30 36       BMI $36    [$F33E]     ;} If [Samus X position] >= [enemy X position]:
$A8:F308 A9 02 00    LDA #$0002             ;\
$A8:F30B 9F 00 78 7E STA $7E7800,x[$7E:7980];} Enemy arc angular velocity cap = 2
$A8:F30F A9 00 00    LDA #$0000             ;\
$A8:F312 9F 04 78 7E STA $7E7804,x[$7E:7984];} Enemy arc angular velocity = 0.0
$A8:F316 9F 06 78 7E STA $7E7806,x[$7E:7986];/
$A8:F31A 9F 08 78 7E STA $7E7808,x[$7E:7988]; Enemy arc angular acceleration = 0
$A8:F31E A9 00 20    LDA #$2000             ;\
$A8:F321 9F 0A 78 7E STA $7E780A,x[$7E:798A];} Enemy arc angular subacceleration = 2000h
$A8:F325 A9 80 00    LDA #$0080             ;\
$A8:F328 9D B2 0F    STA $0FB2,x[$7E:1132]  ;} Enemy arc angle = 80h
$A8:F32B A9 01 00    LDA #$0001             ;\
$A8:F32E 9F 0E 78 7E STA $7E780E,x[$7E:798E];} Enemy X velocity = 1
$A8:F332 A9 90 00    LDA #$0090             ;\
$A8:F335 9F 1C 78 7E STA $7E781C,x[$7E:799C];} Enemy swipe trigger angle = 90h
$A8:F339 A0 04 00    LDY #$0004             ; Y = 4
$A8:F33C 80 34       BRA $34    [$F372]

$A8:F33E A9 FE FF    LDA #$FFFE             ;\ Else ([Samus X position] < [enemy X position]):
$A8:F341 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy arc angular velocity cap = -2
$A8:F345 A9 00 00    LDA #$0000             ;\
$A8:F348 9F 04 78 7E STA $7E7804,x[$7E:7804];} Enemy arc angular velocity = 0.0
$A8:F34C 9F 06 78 7E STA $7E7806,x[$7E:7806];/
$A8:F350 A9 FF FF    LDA #$FFFF             ;\
$A8:F353 9F 08 78 7E STA $7E7808,x[$7E:7808];|
$A8:F357 9F 0E 78 7E STA $7E780E,x[$7E:780E];} Enemy arc angular acceleration = -0.2000h
$A8:F35B A9 00 E0    LDA #$E000             ;} Enemy X velocity = -1
$A8:F35E 9F 0A 78 7E STA $7E780A,x[$7E:780A];/
$A8:F362 A9 FF 00    LDA #$00FF             ;\
$A8:F365 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy arc angle = FFh
$A8:F368 A9 F0 00    LDA #$00F0             ;\
$A8:F36B 9F 1C 78 7E STA $7E781C,x[$7E:781C];} Enemy swipe trigger angle = F0h
$A8:F36F A0 00 00    LDY #$0000             ; Y = 0

$A8:F372 B9 B0 F3    LDA $F3B0,y[$A8:F3B0]  ;\
$A8:F375 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = [$F3B0 + [Y]]
$A8:F378 B9 B2 F3    LDA $F3B2,y[$A8:F3B2]  ;\
$A8:F37B 9D D2 0F    STA $0FD2,x[$7E:0FD2]  ;} Wings enemy instruction list pointer = [$F3B0 + [Y] + 2]
$A8:F37E A9 01 00    LDA #$0001             ;\
$A8:F381 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:F384 9D D4 0F    STA $0FD4,x[$7E:0FD4]  ; Wings enemy instruction timer = 1
$A8:F387 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:F38A 18          CLC                    ;|
$A8:F38B 65 12       ADC $12    [$7E:0012]  ;} Enemy arc centre X position = [Samus X position]
$A8:F38D 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A8:F390 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A8:F393 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy arc centre Y position = [enemy Y position]
$A8:F396 A9 B8 F3    LDA #$F3B8             ;\
$A8:F399 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F3B8 (winged - swoop)
$A8:F39C A5 18       LDA $18    [$7E:0018]  ;\
$A8:F39E 9F 24 78 7E STA $7E7824,x[$7E:7824];} Enemy arc Y radius = [Samus Y position] - [enemy Y position]
$A8:F3A2 A5 14       LDA $14    [$7E:0014]  ;\
$A8:F3A4 9F 22 78 7E STA $7E7822,x[$7E:7822];} Enemy arc X radius = |[Samus X position] - [enemy X position]|
$A8:F3A8 A9 00 00    LDA #$0000             ;\
$A8:F3AB 9F 20 78 7E STA $7E7820,x[$7E:7820];} Enemy swoop swipe flag = 0
$A8:F3AF 6B          RTL

; Instruction list pointers
;                        ________ Ki-hunter
;                       |     ___ Ki-hunter wings
;                       |    |
$A8:F3B0             dw E9FA,EA4E, ; Facing left
                        EA24,EA5E  ; Facing right
}


;;; $F3B8: Ki-hunter function - winged - swoop ;;;
{
$A8:F3B8 BF 08 78 7E LDA $7E7808,x[$7E:7808];\
$A8:F3BC 10 0B       BPL $0B    [$F3C9]     ;} If [enemy arc angular acceleration] < 0:
$A8:F3BE BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A8:F3C1 DF 1C 78 7E CMP $7E781C,x[$7E:781C];} If [enemy arc angle] >= [enemy swipe trigger angle]: go to BRANCH_NO_INSTRUCTION_LIST_CHANGE
$A8:F3C5 10 2E       BPL $2E    [$F3F5]     ;/
$A8:F3C7 80 09       BRA $09    [$F3D2]

$A8:F3C9 BD B2 0F    LDA $0FB2,x[$7E:1132]  ;\ Else ([enemy arc angular acceleration] >= 0):
$A8:F3CC DF 1C 78 7E CMP $7E781C,x[$7E:799C];} If [enemy arc angle] < [enemy swipe trigger angle]: go to BRANCH_NO_INSTRUCTION_LIST_CHANGE
$A8:F3D0 30 23       BMI $23    [$F3F5]     ;/

$A8:F3D2 BF 20 78 7E LDA $7E7820,x[$7E:7920];\
$A8:F3D6 D0 1D       BNE $1D    [$F3F5]     ;} If [enemy swoop swipe flag] != 0: go to BRANCH_NO_INSTRUCTION_LIST_CHANGE
$A8:F3D8 A9 01 00    LDA #$0001             ;\
$A8:F3DB 9F 20 78 7E STA $7E7820,x[$7E:7920];} Enemy swoop swipe flag = 1
$A8:F3DF A0 32 EA    LDY #$EA32             ; Enemy instruction list pointer = $EA32 (swiping - facing right)
$A8:F3E2 BF 08 78 7E LDA $7E7808,x[$7E:7908];\
$A8:F3E6 10 03       BPL $03    [$F3EB]     ;} If [enemy arc angular acceleration] < 0:
$A8:F3E8 A0 08 EA    LDY #$EA08             ; Enemy instruction list pointer = $EA08 (swiping - facing left)

$A8:F3EB 98          TYA
$A8:F3EC 9D 92 0F    STA $0F92,x[$7E:1092]
$A8:F3EF A9 01 00    LDA #$0001             ;\
$A8:F3F2 9D 94 0F    STA $0F94,x[$7E:1094]  ;} Enemy instruction timer = 1

; BRANCH_NO_INSTRUCTION_LIST_CHANGE
$A8:F3F5 BF 08 78 7E LDA $7E7808,x[$7E:7808];\
$A8:F3F9 10 3A       BPL $3A    [$F435]     ;} If [enemy arc angular acceleration] >= 0: go to BRANCH_RIGHTWARDS
$A8:F3FB BF 06 78 7E LDA $7E7806,x[$7E:7806];\
$A8:F3FF 18          CLC                    ;|
$A8:F400 7F 0A 78 7E ADC $7E780A,x[$7E:780A];|
$A8:F404 9F 06 78 7E STA $7E7806,x[$7E:7806];} Enemy arc angular velocity += [enemy arc angular acceleration]
$A8:F408 BF 04 78 7E LDA $7E7804,x[$7E:7804];|
$A8:F40C 7F 08 78 7E ADC $7E7808,x[$7E:7808];/
$A8:F410 DF 00 78 7E CMP $7E7800,x[$7E:7800];\
$A8:F414 10 04       BPL $04    [$F41A]     ;} Enemy arc angular velocity = max([enemy arc angular velocity], [enemy arc angular velocity cap])
$A8:F416 BF 00 78 7E LDA $7E7800,x[$7E:7900];/

$A8:F41A 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A8:F41E BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A8:F421 18          CLC                    ;|
$A8:F422 7F 04 78 7E ADC $7E7804,x[$7E:7804];} Enemy arc angle += [enemy arc angular velocity]
$A8:F426 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;/
$A8:F429 C9 80 00    CMP #$0080             ;\
$A8:F42C 10 41       BPL $41    [$F46F]     ;} If [enemy arc angle] >= 80h: go to BRANCH_SWOOP_CONTINUES
$A8:F42E A9 68 F2    LDA #$F268             ;\
$A8:F431 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = $F268 (winged - idle flying)
$A8:F434 6B          RTL                    ; Return

; BRANCH_RIGHTWARDS
$A8:F435 BF 06 78 7E LDA $7E7806,x[$7E:7986];\
$A8:F439 18          CLC                    ;|
$A8:F43A 7F 0A 78 7E ADC $7E780A,x[$7E:798A];|
$A8:F43E 9F 06 78 7E STA $7E7806,x[$7E:7986];} Enemy arc angular velocity += [enemy arc angular acceleration]
$A8:F442 BF 04 78 7E LDA $7E7804,x[$7E:7984];|
$A8:F446 7F 08 78 7E ADC $7E7808,x[$7E:7988];/
$A8:F44A DF 00 78 7E CMP $7E7800,x[$7E:7980];\
$A8:F44E 30 04       BMI $04    [$F454]     ;} Enemy arc angular velocity = min([enemy arc angular velocity], [enemy arc angular velocity cap])
$A8:F450 BF 00 78 7E LDA $7E7800,x[$7E:7980];/

$A8:F454 9F 04 78 7E STA $7E7804,x[$7E:7984]
$A8:F458 BD B2 0F    LDA $0FB2,x[$7E:1132]  ;\
$A8:F45B 18          CLC                    ;|
$A8:F45C 7F 04 78 7E ADC $7E7804,x[$7E:7984];} Enemy arc angle += [enemy arc angular velocity]
$A8:F460 9D B2 0F    STA $0FB2,x[$7E:1132]  ;/
$A8:F463 C9 00 01    CMP #$0100             ;\
$A8:F466 30 07       BMI $07    [$F46F]     ;} If [enemy arc angle] < 100h: go to BRANCH_SWOOP_CONTINUES
$A8:F468 A9 68 F2    LDA #$F268             ;\
$A8:F46B 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $F268 (winged - idle flying)
$A8:F46E 6B          RTL                    ; Return

; BRANCH_SWOOP_CONTINUES
$A8:F46F BF 22 78 7E LDA $7E7822,x[$7E:7822];\
$A8:F473 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F476 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;|
$A8:F479 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;|
$A8:F47D 18          CLC                    ;} $14 = [enemy arc centre X position] + [enemy arc X radius] * cos([enemy arc angle] * pi / 80h) * FFh / 100h - [enemy X position]
$A8:F47E 7D AA 0F    ADC $0FAA,x[$7E:0FAA]  ;|
$A8:F481 38          SEC                    ;|
$A8:F482 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A8:F485 85 14       STA $14    [$7E:0014]  ;/
$A8:F487 64 12       STZ $12    [$7E:0012]  ;\
$A8:F489 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;} Move enemy right by [$14]
$A8:F48D B0 25       BCS $25    [$F4B4]     ; If collided with wall: go to BRANCH_COLLIDED_HORIZONTALLY
$A8:F48F 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A8:F493 BF 24 78 7E LDA $7E7824,x[$7E:7824];\
$A8:F497 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F49A BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;|
$A8:F49D 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A8:F4A1 18          CLC                    ;} $14 = [enemy arc centre Y position] + [enemy arc Y radius] * -sin([enemy arc angle] * pi / 80h) * FFh / 100h - [enemy Y position]
$A8:F4A2 7D AC 0F    ADC $0FAC,x[$7E:0FAC]  ;|
$A8:F4A5 38          SEC                    ;|
$A8:F4A6 FD 7E 0F    SBC $0F7E,x[$7E:0F7E]  ;|
$A8:F4A9 85 14       STA $14    [$7E:0014]  ;/
$A8:F4AB 64 12       STZ $12    [$7E:0012]  ;\
$A8:F4AD 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;} Move enemy down by [$14]
$A8:F4B1 B0 25       BCS $25    [$F4D8]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A8:F4B3 6B          RTL                    ; Return

; BRANCH_COLLIDED_HORIZONTALLY
$A8:F4B4 BF 08 78 7E LDA $7E7808,x[$7E:7808];\
$A8:F4B8 10 10       BPL $10    [$F4CA]     ;} If [enemy arc angular acceleration] < 0:
$A8:F4BA A9 00 00    LDA #$0000             ;\
$A8:F4BD 9F 0C 78 7E STA $7E780C,x[$7E:780C];|
$A8:F4C1 A9 01 00    LDA #$0001             ;} Enemy X velocity = 1.0
$A8:F4C4 9F 0E 78 7E STA $7E780E,x[$7E:780E];/
$A8:F4C8 80 0E       BRA $0E    [$F4D8]

$A8:F4CA A9 00 00    LDA #$0000             ;\ Else ([enemy arc angular acceleration] >= 0):
$A8:F4CD 9F 0C 78 7E STA $7E780C,x[$7E:780C];|
$A8:F4D1 A9 FF FF    LDA #$FFFF             ;} Enemy X velocity = -1.0
$A8:F4D4 9F 0E 78 7E STA $7E780E,x[$7E:780E];/

; BRANCH_COLLIDED_VERTICALLY
$A8:F4D8 A9 ED F4    LDA #$F4ED             ;\
$A8:F4DB 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = $F4ED (back off)
$A8:F4DE A9 00 00    LDA #$0000             ;\
$A8:F4E1 9F 10 78 7E STA $7E7810,x[$7E:7990];|
$A8:F4E5 A9 FF FF    LDA #$FFFF             ;} Enemy Y velocity = -1.0
$A8:F4E8 9F 12 78 7E STA $7E7812,x[$7E:7992];/
$A8:F4EC 6B          RTL
}


;;; $F4ED: Ki-hunter function - winged - back off ;;;
{
$A8:F4ED BF 0C 78 7E LDA $7E780C,x[$7E:798C];\
$A8:F4F1 85 12       STA $12    [$7E:0012]  ;|
$A8:F4F3 BF 0E 78 7E LDA $7E780E,x[$7E:798E];} Move enemy right by [enemy X velocity]
$A8:F4F7 85 14       STA $14    [$7E:0014]  ;|
$A8:F4F9 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:F4FD B0 20       BCS $20    [$F51F]     ; If not collided with wall:
$A8:F4FF 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A8:F503 BF 10 78 7E LDA $7E7810,x[$7E:7990];\
$A8:F507 85 12       STA $12    [$7E:0012]  ;|
$A8:F509 BF 12 78 7E LDA $7E7812,x[$7E:7992];} Move enemy down by [enemy Y velocity]
$A8:F50D 85 14       STA $14    [$7E:0014]  ;|
$A8:F50F 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:F513 B0 0A       BCS $0A    [$F51F]     ; If not collided with block:
$A8:F515 BD 7E 0F    LDA $0F7E,x[$7E:10FE]  ;\
$A8:F518 DF 1A 78 7E CMP $7E781A,x[$7E:799A];} If [enemy Y position] >= [enemy spawn Y position]:
$A8:F51C 30 01       BMI $01    [$F51F]     ;/
$A8:F51E 6B          RTL                    ; Return

$A8:F51F A9 68 F2    LDA #$F268             ;\
$A8:F522 9D A8 0F    STA $0FA8,x[$7E:1128]  ;} Enemy function = $F268 (winged - idle flying)
$A8:F525 6B          RTL
}


;;; $F526: Instruction - set idling instruction lists facing forwards ;;;
{
$A8:F526 A0 FA E9    LDY #$E9FA             ; Y = $E9FA (idling - facing left)
$A8:F529 A9 4E EA    LDA #$EA4E             ;\
$A8:F52C 85 12       STA $12    [$7E:0012]  ;} $12 = $EA4E (ki-hunter wings - facing left)
$A8:F52E BF 0E 78 7E LDA $7E780E,x[$7E:780E];\
$A8:F532 30 08       BMI $08    [$F53C]     ;} If [enemy X velocity] >= 0:
$A8:F534 A0 24 EA    LDY #$EA24             ; Y = $EA24 (idling - facing right)
$A8:F537 A9 5E EA    LDA #$EA5E             ;\
$A8:F53A 85 12       STA $12    [$7E:0012]  ;} $12 = $EA5E (ki-hunter wings - facing right)

$A8:F53C 98          TYA                    ;\
$A8:F53D 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list = [Y] <-- this gets overwritten by the caller routine
$A8:F540 A9 01 00    LDA #$0001             ;\
$A8:F543 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:F546 BD E8 0F    LDA $0FE8,x[$7E:0FE8]  ;\
$A8:F549 C9 F3 F6    CMP #$F6F3             ;} If [wings enemy function] = $F6F3 (attached):
$A8:F54C D0 0B       BNE $0B    [$F559]     ;/
$A8:F54E A5 12       LDA $12    [$7E:0012]  ;\
$A8:F550 9D D2 0F    STA $0FD2,x[$7E:0FD2]  ;} Wings enemy instruction list pointer = [$12]
$A8:F553 A9 01 00    LDA #$0001             ;\
$A8:F556 9D D4 0F    STA $0FD4,x[$7E:0FD4]  ;} Wings enemy instruction timer = 1

$A8:F559 6B          RTL
}


;;; $F55A: Ki-hunter function - wingless - initial falling ;;;
{
$A8:F55A BF 10 78 7E LDA $7E7810,x[$7E:7910];\
$A8:F55E 85 12       STA $12    [$7E:0012]  ;|
$A8:F560 BF 12 78 7E LDA $7E7812,x[$7E:7912];} Move enemy down by [enemy Y velocity]
$A8:F564 85 14       STA $14    [$7E:0014]  ;|
$A8:F566 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:F56A 90 07       BCC $07    [$F573]     ; If collided with block:
$A8:F56C A9 8B F5    LDA #$F58B             ;\
$A8:F56F 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = $F58B (wingless - prepare to hop)
$A8:F572 6B          RTL                    ; Return

$A8:F573 BF 10 78 7E LDA $7E7810,x[$7E:7910];\
$A8:F577 18          CLC                    ;|
$A8:F578 6D 82 F1    ADC $F182  [$A8:F182]  ;|
$A8:F57B 9F 10 78 7E STA $7E7810,x[$7E:7910];} Enemy Y velocity += 0.E000h
$A8:F57F BF 12 78 7E LDA $7E7812,x[$7E:7912];|
$A8:F583 6D 84 F1    ADC $F184  [$A8:F184]  ;|
$A8:F586 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:F58A 6B          RTL
}


;;; $F58B: Ki-hunter function - wingless - prepare to hop ;;;
{
$A8:F58B A9 E3 F5    LDA #$F5E3             ;\
$A8:F58E 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = RTL
$A8:F591 A9 00 00    LDA #$0000             ;\
$A8:F594 9F 10 78 7E STA $7E7810,x[$7E:7910];|
$A8:F598 AD E5 05    LDA $05E5  [$7E:05E5]  ;|
$A8:F59B 29 01 00    AND #$0001             ;} Enemy Y velocity = -8.0 + [random number] % 2
$A8:F59E 18          CLC                    ;|
$A8:F59F 69 F8 FF    ADC #$FFF8             ;|
$A8:F5A2 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:F5A6 BD 7A 0F    LDA $0F7A,x[$7E:107A]  ;\
$A8:F5A9 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [enemy X position] < [Samus X position]:
$A8:F5AC 10 1B       BPL $1B    [$F5C9]     ;/
$A8:F5AE A9 00 00    LDA #$0000             ;\
$A8:F5B1 9F 0C 78 7E STA $7E780C,x[$7E:798C];|
$A8:F5B5 A9 02 00    LDA #$0002             ;} Enemy X velocity = 2.0
$A8:F5B8 9F 0E 78 7E STA $7E780E,x[$7E:798E];/
$A8:F5BC A9 A6 EA    LDA #$EAA6             ;\
$A8:F5BF 9D 92 0F    STA $0F92,x[$7E:1112]  ;} Enemy instruction list pointer = $EAA6 (hop - facing right)
$A8:F5C2 A9 01 00    LDA #$0001             ;\
$A8:F5C5 9D 94 0F    STA $0F94,x[$7E:1114]  ;} Enemy instruction timer = 1
$A8:F5C8 6B          RTL                    ; Return

$A8:F5C9 A9 00 00    LDA #$0000             ;\
$A8:F5CC 9F 0C 78 7E STA $7E780C,x[$7E:790C];|
$A8:F5D0 A9 FE FF    LDA #$FFFE             ;} Enemy X velocity = -2.0
$A8:F5D3 9F 0E 78 7E STA $7E780E,x[$7E:790E];/
$A8:F5D7 A9 8A EA    LDA #$EA8A             ;\
$A8:F5DA 9D 92 0F    STA $0F92,x[$7E:1092]  ;} Enemy instruction list pointer = $EA8A (hop - facing left)
$A8:F5DD A9 01 00    LDA #$0001             ;\
$A8:F5E0 9D 94 0F    STA $0F94,x[$7E:1094]  ;} Enemy instruction timer = 1
$A8:F5E3 6B          RTL
}


;;; $F5E4: Instruction - enemy function = hop ;;;
{
$A8:F5E4 DA          PHX
$A8:F5E5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F5E8 A9 F0 F5    LDA #$F5F0
$A8:F5EB 9D A8 0F    STA $0FA8,x[$7E:1028]
$A8:F5EE FA          PLX
$A8:F5EF 6B          RTL
}


;;; $F5F0: Ki-hunter function - wingless - hop ;;;
{
$A8:F5F0 BF 10 78 7E LDA $7E7810,x[$7E:7890];\
$A8:F5F4 85 12       STA $12    [$7E:0012]  ;|
$A8:F5F6 BF 12 78 7E LDA $7E7812,x[$7E:7892];} Move enemy down by [enemy Y velocity]
$A8:F5FA 85 14       STA $14    [$7E:0014]  ;|
$A8:F5FC 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A8:F600 B0 3B       BCS $3B    [$F63D]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A8:F602 BF 0C 78 7E LDA $7E780C,x[$7E:788C];\
$A8:F606 85 12       STA $12    [$7E:0012]  ;|
$A8:F608 BF 0E 78 7E LDA $7E780E,x[$7E:788E];} Move enemy right by [enemy X velocity]
$A8:F60C 85 14       STA $14    [$7E:0014]  ;|
$A8:F60E 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A8:F612 B0 1C       BCS $1C    [$F630]     ; If collided with wall: go to BRANCH_COLLIDED_HORIZONTALLY
$A8:F614 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]  ; Align enemy Y position with non-square slope
$A8:F618 BF 10 78 7E LDA $7E7810,x[$7E:7890];\
$A8:F61C 18          CLC                    ;|
$A8:F61D 6D 82 F1    ADC $F182  [$A8:F182]  ;|
$A8:F620 9F 10 78 7E STA $7E7810,x[$7E:7890];} Enemy Y velocity += 0.E000h
$A8:F624 BF 12 78 7E LDA $7E7812,x[$7E:7892];|
$A8:F628 6D 84 F1    ADC $F184  [$A8:F184]  ;|
$A8:F62B 9F 12 78 7E STA $7E7812,x[$7E:7892];/
$A8:F62F 6B          RTL                    ; Return

; BRANCH_COLLIDED_HORIZONTALLY
$A8:F630 BF 0E 78 7E LDA $7E780E,x          ;\
$A8:F634 49 FF FF    EOR #$FFFF             ;|
$A8:F637 1A          INC A                  ;} Negate enemy X velocity
$A8:F638 9F 0E 78 7E STA $7E780E,x          ;/
$A8:F63C 6B          RTL                    ; Return

; BRANCH_COLLIDED_VERTICALLY
$A8:F63D BF 12 78 7E LDA $7E7812,x[$7E:7892];\
$A8:F641 30 34       BMI $34    [$F677]     ;} If [enemy Y velocity] < 0: go to BRANCH_HIT_CEILING
$A8:F643 A9 00 00    LDA #$0000             ;\
$A8:F646 9F 10 78 7E STA $7E7810,x[$7E:7890];|
$A8:F64A A9 FC FF    LDA #$FFFC             ;} Enemy Y velocity = -4.0
$A8:F64D 9F 12 78 7E STA $7E7812,x[$7E:7892];/
$A8:F651 A9 E3 F5    LDA #$F5E3             ;\
$A8:F654 9D A8 0F    STA $0FA8,x[$7E:1028]  ;} Enemy function = RTL
$A8:F657 A9 0C 00    LDA #$000C             ;\
$A8:F65A 9F 1E 78 7E STA $7E781E,x[$7E:789E];} Enemy thinking timer = Ch
$A8:F65E A0 C2 EA    LDY #$EAC2             ; Y = $EAC2 (landed from hop - facing left)
$A8:F661 BD 92 0F    LDA $0F92,x[$7E:1012]  ;\
$A8:F664 C9 A6 EA    CMP #$EAA6             ;} If [enemy instruction list pointer] >= $EAA6 (hop - facing right):
$A8:F667 30 03       BMI $03    [$F66C]     ;/
$A8:F669 A0 DA EA    LDY #$EADA             ; Y = $EADA (landed from hop - facing right)

$A8:F66C 98          TYA                    ;\
$A8:F66D 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = [Y]
$A8:F670 A9 01 00    LDA #$0001             ;\
$A8:F673 9D 94 0F    STA $0F94,x[$7E:1014]  ;} Enemy instruction timer = 1
$A8:F676 6B          RTL                    ; Return

; BRANCH_HIT_CEILING
$A8:F677 A9 01 00    LDA #$0001             ;\
$A8:F67A 9F 12 78 7E STA $7E7812,x          ;} Enemy Y velocity = 1
$A8:F67E 6B          RTL
}


;;; $F67F: Instruction - enemy function = wingless - thinking ;;;
{
$A8:F67F DA          PHX
$A8:F680 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F683 A9 8B F6    LDA #$F68B
$A8:F686 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A8:F689 FA          PLX
$A8:F68A 6B          RTL
}


;;; $F68B: Ki-hunter function - wingless - thinking ;;;
{
$A8:F68B BF 1E 78 7E LDA $7E781E,x[$7E:781E];\
$A8:F68F 3A          DEC A                  ;} Decrement enemy thinking timer
$A8:F690 9F 1E 78 7E STA $7E781E,x[$7E:781E];/
$A8:F694 D0 1C       BNE $1C    [$F6B2]     ; If [enemy thinking timer] != 0: return
$A8:F696 A0 8B F5    LDY #$F58B             ; Enemy function = $F58B (wingless - prepare to hop)
$A8:F699 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:F69C 38          SEC                    ;|
$A8:F69D ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A8:F6A0 10 04       BPL $04    [$F6A6]     ;|
$A8:F6A2 49 FF FF    EOR #$FFFF             ;} If |[enemy X position] - [Samus X position]| < 60h:
$A8:F6A5 1A          INC A                  ;|
                                            ;|
$A8:F6A6 C9 60 00    CMP #$0060             ;|
$A8:F6A9 10 03       BPL $03    [$F6AE]     ;/
$A8:F6AB A0 B3 F6    LDY #$F6B3             ; Enemy function = $F6B3 (wingless - fire acid spit)

$A8:F6AE 98          TYA
$A8:F6AF 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A8:F6B2 6B          RTL
}


;;; $F6B3: Ki-hunter function - wingless - fire acid spit ;;;
{
$A8:F6B3 A0 F2 EA    LDY #$EAF2             ; Enemy instruction list pointer = $EAF2 (acid spit attack - facing left)
$A8:F6B6 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A8:F6B9 CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [enemy X position] < [Samus X position]:
$A8:F6BC 10 03       BPL $03    [$F6C1]     ;/
$A8:F6BE A0 10 EB    LDY #$EB10             ; Enemy instruction list pointer = $EB10 (acid spit attack - facing right)

$A8:F6C1 98          TYA
$A8:F6C2 9D 92 0F    STA $0F92,x[$7E:0F92]
$A8:F6C5 A9 01 00    LDA #$0001             ;\
$A8:F6C8 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A8:F6CB A9 E3 F5    LDA #$F5E3             ;\
$A8:F6CE 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = RTL
$A8:F6D1 6B          RTL
}


;;; $F6D2: Instruction - fire acid spit left ;;;
{
$A8:F6D2 5A          PHY
$A8:F6D3 A0 18 CF    LDY #$CF18             ; Y = $CF18 (ki hunter acid spit - left)
$A8:F6D6 80 04       BRA $04    [$F6DC]     ; Go to fire acid spit
}


;;; $F6D8: Instruction - fire acid spit right ;;;
{
$A8:F6D8 5A          PHY
$A8:F6D9 A0 26 CF    LDY #$CF26             ; Y = $CF26 (ki hunter acid spit - right)
}


;;; $F6DC: Fire acid spit ;;;
{
;; Parameters:
;;     Y: Enemy projectile ID

; Expects a pushed instruction list pointer
$A8:F6DC A9 4C 00    LDA #$004C             ;\
$A8:F6DF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 4Ch, sound library 2, max queued sounds allowed = 6 (ki-hunter spit)
$A8:F6E3 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A8:F6E6 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn enemy projectile [Y]
$A8:F6EA A9 18 00    LDA #$0018             ;\
$A8:F6ED 9F 1E 78 7E STA $7E781E,x[$7E:781E];} Enemy thinking timer = 18h
$A8:F6F1 7A          PLY
$A8:F6F2 6B          RTL
}


;;; $F6F3..F9BD: Ki-hunter wings ;;;
{
;;; $F6F3: Ki-hunter wings function - attached ;;;
{
$A8:F6F3 BD 3A 0F    LDA $0F3A,x[$7E:0F7A]  ;\
$A8:F6F6 9D 7A 0F    STA $0F7A,x[$7E:0FBA]  ;} Enemy X position = [enemy ([X] - 1) X position]
$A8:F6F9 BD 3E 0F    LDA $0F3E,x[$7E:0F7E]  ;\
$A8:F6FC 9D 7E 0F    STA $0F7E,x[$7E:0FBE]  ;} Enemy Y position = [enemy ([X] - 1) Y position]
$A8:F6FF 6B          RTL
}


;;; $F700: RTL ;;;
{
$A8:F700 6B          RTL
}


;;; $F701: Enemy shot - enemy $EABF/$EB3F/$EBBF (ki-hunter) ;;;
{
$A8:F701 22 3D A6 A0 JSL $A0A63D[$A0:A63D]  ; Normal enemy shot AI
$A8:F705 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F708 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]  ;\
$A8:F70B F0 20       BEQ $20    [$F72D]     ;} If [enemy health] = 0: go to BRANCH_DEAD
$A8:F70D DD F4 0F    CMP $0FF4,x[$7E:10F4]  ;\
$A8:F710 F0 22       BEQ $22    [$F734]     ;} If [enemy health] <= [wings enemy parameter 1]: go to BRANCH_CLIP_WINGS
$A8:F712 30 20       BMI $20    [$F734]     ;/
$A8:F714 BD 8A 0F    LDA $0F8A,x[$7E:108A]  ;\
$A8:F717 9D CA 0F    STA $0FCA,x[$7E:10CA]  ;} Wings enemy AI handler = [enemy AI handler]
$A8:F71A BD 9E 0F    LDA $0F9E,x[$7E:109E]  ;\
$A8:F71D 9D DE 0F    STA $0FDE,x[$7E:10DE]  ;} Wings enemy frozen timer = [enemy frozen timer]
$A8:F720 BD A0 0F    LDA $0FA0,x[$7E:10A0]  ;\
$A8:F723 9D E0 0F    STA $0FE0,x[$7E:10E0]  ;} Wings enemy invincibility timer = [enemy invincibility timer]
$A8:F726 BD 9C 0F    LDA $0F9C,x[$7E:109C]  ;\
$A8:F729 9D DC 0F    STA $0FDC,x[$7E:10DC]  ;} Wings enemy flash timer = [enemy flash timer]

$A8:F72C 6B          RTL                    ; Return

; BRANCH_DEAD
$A8:F72D A9 00 02    LDA #$0200             ;\
$A8:F730 9D C6 0F    STA $0FC6,x[$7E:0FC6]  ;} Mark wings enemy for deletion
$A8:F733 6B          RTL                    ; Return

; BRANCH_CLIP_WINGS
$A8:F734 BF 28 78 7E LDA $7E7828,x[$7E:7928];\
$A8:F738 D0 F2       BNE $F2    [$F72C]     ;} If [enemy wingless flag] != 0: return
$A8:F73A A9 01 00    LDA #$0001             ;\
$A8:F73D 9F 28 78 7E STA $7E7828,x[$7E:7928];} Enemy wingless flag = 1
$A8:F741 A9 5A F5    LDA #$F55A             ;\
$A8:F744 9D A8 0F    STA $0FA8,x[$7E:10A8]  ;} Enemy function = $F55A (wingless - initial falling)
$A8:F747 A9 00 00    LDA #$0000             ;\
$A8:F74A 9F 10 78 7E STA $7E7810,x[$7E:7910];|
$A8:F74E A9 01 00    LDA #$0001             ;} Enemy Y velocity = 1.0
$A8:F751 9F 12 78 7E STA $7E7812,x[$7E:7912];/
$A8:F755 DA          PHX
$A8:F756 8A          TXA                    ;\
$A8:F757 18          CLC                    ;|
$A8:F758 69 40 00    ADC #$0040             ;} Enemy index += 40h (wings enemy)
$A8:F75B 8D 54 0E    STA $0E54  [$7E:0E54]  ;|
$A8:F75E AA          TAX                    ;/
$A8:F75F BD A8 0F    LDA $0FA8,x[$7E:10E8]  ;\
$A8:F762 C9 CF F7    CMP #$F7CF             ;} If [enemy function] = $F7CF (falling): go to BRANCH_RETURN
$A8:F765 F0 63       BEQ $63    [$F7CA]     ;/
$A8:F767 BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;\
$A8:F76A 9F 0E 78 7E STA $7E780E,x[$7E:794E];} Enemy fall start Y position = [enemy Y position]
$A8:F76E BD 7A 0F    LDA $0F7A,x[$7E:10BA]  ;\
$A8:F771 9F 10 78 7E STA $7E7810,x[$7E:7950];} Enemy fall start X position = [enemy X position]
$A8:F775 20 8D F9    JSR $F98D  [$A8:F98D]  ; Determine falling ki-hunter wings speed table index reset value
$A8:F778 20 51 F8    JSR $F851  [$A8:F851]  ; Determine falling ki-hunter wings left arc centre offsets
$A8:F77B 20 7F F8    JSR $F87F  [$A8:F87F]  ; Determine falling ki-hunter wings right arc centre offsets
$A8:F77E A9 00 E0    LDA #$E000             ;\
$A8:F781 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;} Enemy arc angle = -2000h
$A8:F784 A9 CF F7    LDA #$F7CF             ;\
$A8:F787 9D A8 0F    STA $0FA8,x[$7E:10E8]  ;} Enemy function = $F7CF (falling)
$A8:F78A A9 DB F7    LDA #$F7DB             ;\
$A8:F78D 9F 00 78 7E STA $7E7800,x[$7E:7940];} Enemy falling function = $F7DB (drifting left)
$A8:F791 BF 0E 78 7E LDA $7E780E,x[$7E:794E];\
$A8:F795 38          SEC                    ;|
$A8:F796 FF 16 78 7E SBC $7E7816,x[$7E:7956];} Enemy arc start Y position = [enemy fall start Y position] (enemy $7E:7816 is always zero)
$A8:F79A 9F 0C 78 7E STA $7E780C,x[$7E:794C];/
$A8:F79E BD 7A 0F    LDA $0F7A,x[$7E:10BA]  ;\
$A8:F7A1 9F 0A 78 7E STA $7E780A,x[$7E:794A];} Enemy arc start X position = [enemy X position]
$A8:F7A5 BF 14 78 7E LDA $7E7814,x[$7E:7954];\
$A8:F7A9 9D AA 0F    STA $0FAA,x[$7E:10EA]  ;} Enemy speed table index = [speed table index reset value]
$A8:F7AC A9 7E EA    LDA #$EA7E             ;\
$A8:F7AF 9D 92 0F    STA $0F92,x[$7E:10D2]  ;} Enemy instruction list pointer = $EA7E (falling)
$A8:F7B2 A9 4D 80    LDA #$804D             ;\
$A8:F7B5 9D 8E 0F    STA $0F8E,x[$7E:10CE]  ;} Enemy spritemap pointer = $804D
$A8:F7B8 A9 01 00    LDA #$0001             ;\
$A8:F7BB 9D 94 0F    STA $0F94,x[$7E:10D4]  ;} Enemy instruction list timer = 1
$A8:F7BE 9E 90 0F    STZ $0F90,x[$7E:10D0]  ; Enemy timer = 0
$A8:F7C1 BD 86 0F    LDA $0F86,x[$7E:10C6]  ;\
$A8:F7C4 09 00 08    ORA #$0800             ;} Set enemy to process whilst off-screen
$A8:F7C7 9D 86 0F    STA $0F86,x[$7E:10C6]  ;/

; BRANCH_RETURN
$A8:F7CA 68          PLA                    ;\
$A8:F7CB 8D 54 0E    STA $0E54  [$7E:0E54]  ;} Enemy index -= 40h (ki-hunter enemy)
$A8:F7CE 6B          RTL
}


;;; $F7CF: Ki-hunter wings function - falling ;;;
{
$A8:F7CF AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F7D2 BF 00 78 7E LDA $7E7800,x[$7E:7940];\
$A8:F7D6 85 12       STA $12    [$7E:0012]  ;} Go to [enemy falling function]
$A8:F7D8 6C 12 00    JMP ($0012)[$A8:F7DB]  ;/
}


;;; $F7DB: Ki-hunter wings falling function - drifting left ;;;
{
$A8:F7DB AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F7DE BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;\
$A8:F7E1 29 00 FF    AND #$FF00             ;|
$A8:F7E4 EB          XBA                    ;|
$A8:F7E5 0A          ASL A                  ;} Y = [enemy speed table index] / 100h * 8 (quadratic speed table index)
$A8:F7E6 0A          ASL A                  ;|
$A8:F7E7 0A          ASL A                  ;|
$A8:F7E8 A8          TAY                    ;/
$A8:F7E9 BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A8:F7EC 18          CLC                    ;|
$A8:F7ED 79 94 83    ADC $8394,y[$A8:84E4]  ;} Enemy arc angle += [$838F + [Y] + 4 + 1] (negated speed * 100h)
$A8:F7F0 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;/
$A8:F7F3 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F7F6 29 FF 00    AND #$00FF             ;|
$A8:F7F9 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F7FC BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;|
$A8:F7FF EB          XBA                    ;|
$A8:F800 29 FF 00    AND #$00FF             ;|
$A8:F803 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;} Enemy Y position = [enemy arc start Y position] - [enemy left arc centre Y offset] + 30h * -sin([enemy arc angle] * pi / 8000h) * FFh / 100h
$A8:F807 38          SEC                    ;|
$A8:F808 FF 08 78 7E SBC $7E7808,x[$7E:7948];|
$A8:F80C 18          CLC                    ;|
$A8:F80D 7F 0C 78 7E ADC $7E780C,x[$7E:794C];|
$A8:F811 9D 7E 0F    STA $0F7E,x[$7E:10BE]  ;/
$A8:F814 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F817 29 FF 00    AND #$00FF             ;|
$A8:F81A 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F81D BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;|
$A8:F820 EB          XBA                    ;|
$A8:F821 29 FF 00    AND #$00FF             ;|
$A8:F824 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Enemy X position = [enemy arc start X position] - [enemy left arc centre X offset] + 30h * cos([enemy arc angle] * pi / 8000h) * FFh / 100h
$A8:F828 38          SEC                    ;|
$A8:F829 FF 06 78 7E SBC $7E7806,x[$7E:7946];|
$A8:F82D 18          CLC                    ;|
$A8:F82E 7F 0A 78 7E ADC $7E780A,x[$7E:794A];|
$A8:F832 9D 7A 0F    STA $0F7A,x[$7E:10BA]  ;/
$A8:F835 BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A8:F838 C9 00 C0    CMP #$C000             ;} If [enemy arc angle] < -4000h:
$A8:F83B 10 04       BPL $04    [$F841]     ;/
$A8:F83D 20 6A F9    JSR $F96A  [$A8:F96A]  ; Set up falling ki-hunter wings drifting right
$A8:F840 6B          RTL                    ; Return

$A8:F841 BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;\
$A8:F844 38          SEC                    ;} Enemy speed table index -= 180h
$A8:F845 E9 80 01    SBC #$0180             ;/
$A8:F848 10 03       BPL $03    [$F84D]     ; If [enemy speed table index] < 0:
$A8:F84A A9 00 01    LDA #$0100             ; Enemy speed table index = 100h

$A8:F84D 9D AA 0F    STA $0FAA,x[$7E:10EA]
$A8:F850 6B          RTL
}


;;; $F851: Determine falling ki-hunter wings left arc centre offsets ;;;
{
$A8:F851 AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F854 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F857 29 FF 00    AND #$00FF             ;|
$A8:F85A 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F85D A9 00 E0    LDA #$E000             ;} Enemy left arc centre X offset = 30h * cos(-20h * pi / 80h) * FFh / 100h
$A8:F860 EB          XBA                    ;|
$A8:F861 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;|
$A8:F865 9F 06 78 7E STA $7E7806,x[$7E:7946];/
$A8:F869 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F86C 29 FF 00    AND #$00FF             ;|
$A8:F86F 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F872 A9 00 E0    LDA #$E000             ;} Enemy left arc centre Y offset = 30h * -sin(-20h * pi / 80h) * FFh / 100h
$A8:F875 EB          XBA                    ;|
$A8:F876 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A8:F87A 9F 08 78 7E STA $7E7808,x[$7E:7948];/
$A8:F87E 60          RTS
}


;;; $F87F: Determine falling ki-hunter wings right arc centre offsets ;;;
{
$A8:F87F AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F882 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F885 29 FF 00    AND #$00FF             ;|
$A8:F888 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F88B A9 00 A0    LDA #$A000             ;} Enemy right arc centre X offset = 30h * cos(-60h * pi / 80h) * FFh / 100h
$A8:F88E EB          XBA                    ;|
$A8:F88F 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;|
$A8:F893 9F 02 78 7E STA $7E7802,x[$7E:7942];/
$A8:F897 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F89A 29 FF 00    AND #$00FF             ;|
$A8:F89D 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F8A0 A9 00 A0    LDA #$A000             ;} Enemy right arc centre Y offset = 30h * -sin(-60h * pi / 80h) * FFh / 100h
$A8:F8A3 EB          XBA                    ;|
$A8:F8A4 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A8:F8A8 9F 04 78 7E STA $7E7804,x[$7E:7944];/
$A8:F8AC 60          RTS
}


;;; $F8AD: Ki-hunter wings falling function - drifting right ;;;
{
$A8:F8AD AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F8B0 BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;\
$A8:F8B3 29 00 FF    AND #$FF00             ;|
$A8:F8B6 EB          XBA                    ;|
$A8:F8B7 0A          ASL A                  ;} Y = [enemy speed table index] / 100h * 8 (quadratic speed table index)
$A8:F8B8 0A          ASL A                  ;|
$A8:F8B9 0A          ASL A                  ;|
$A8:F8BA A8          TAY                    ;/
$A8:F8BB BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A8:F8BE 18          CLC                    ;|
$A8:F8BF 79 90 83    ADC $8390,y[$A8:84E0]  ;} Enemy arc angle += [$838F + [Y] + 1] (speed * 100h)
$A8:F8C2 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;/
$A8:F8C5 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F8C8 29 FF 00    AND #$00FF             ;|
$A8:F8CB 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F8CE BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;|
$A8:F8D1 EB          XBA                    ;|
$A8:F8D2 29 FF 00    AND #$00FF             ;} A = [enemy arc start Y position] - [enemy right arc centre Y offset] + 30h * -sin([enemy arc angle] * pi / 8000h) * FFh / 100h
$A8:F8D5 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A8:F8D9 38          SEC                    ;|
$A8:F8DA FF 04 78 7E SBC $7E7804,x[$7E:7944];|
$A8:F8DE 18          CLC                    ;|
$A8:F8DF 7F 0C 78 7E ADC $7E780C,x[$7E:794C];/
$A8:F8E3 38          SEC                    ;\
$A8:F8E4 FD 7E 0F    SBC $0F7E,x[$7E:10BE]  ;} $14 = [A] - [enemy Y position]
$A8:F8E7 85 14       STA $14    [$7E:0014]  ;/
$A8:F8E9 64 12       STZ $12    [$7E:0012]  ;\
$A8:F8EB 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;} Move enemy down by [$14]
$A8:F8EF B0 3D       BCS $3D    [$F92E]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A8:F8F1 AD 86 F1    LDA $F186  [$A8:F186]  ;\
$A8:F8F4 29 FF 00    AND #$00FF             ;|
$A8:F8F7 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A8:F8FA BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;|
$A8:F8FD EB          XBA                    ;|
$A8:F8FE 29 FF 00    AND #$00FF             ;|
$A8:F901 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Enemy X position = [enemy arc start X position] - [enemy right arc centre X offset] + 30h * cos([enemy arc angle] * pi / 8000h) * FFh / 100h
$A8:F905 38          SEC                    ;|
$A8:F906 FF 02 78 7E SBC $7E7802,x[$7E:7942];|
$A8:F90A 18          CLC                    ;|
$A8:F90B 7F 0A 78 7E ADC $7E780A,x[$7E:794A];|
$A8:F90F 9D 7A 0F    STA $0F7A,x[$7E:10BA]  ;/
$A8:F912 BD B2 0F    LDA $0FB2,x[$7E:10F2]  ;\
$A8:F915 C9 00 C0    CMP #$C000             ;} If [enemy arc angle] >= -4000h:
$A8:F918 30 04       BMI $04    [$F91E]     ;/
$A8:F91A 20 47 F9    JSR $F947  [$A8:F947]  ; Set up falling ki-hunter wings drifting left
$A8:F91D 6B          RTL                    ; Return

$A8:F91E BD AA 0F    LDA $0FAA,x[$7E:10EA]  ;\
$A8:F921 38          SEC                    ;} Enemy speed table index -= 180h
$A8:F922 E9 80 01    SBC #$0180             ;/
$A8:F925 10 03       BPL $03    [$F92A]     ; If [enemy speed table index] < 0:
$A8:F927 A9 00 01    LDA #$0100             ; Enemy speed table index = 100h

$A8:F92A 9D AA 0F    STA $0FAA,x[$7E:10EA]
$A8:F92D 6B          RTL                    ; Return

; BRANCH_COLLIDED_VERTICALLY
$A8:F92E BD 86 0F    LDA $0F86,x[$7E:1146]  ;\
$A8:F931 09 00 02    ORA #$0200             ;} Mark enemy for deletion
$A8:F934 9D 86 0F    STA $0F86,x[$7E:1146]  ;/
$A8:F937 BF 10 78 7E LDA $7E7810,x[$7E:79D0];\
$A8:F93B 9D 7A 0F    STA $0F7A,x[$7E:113A]  ;} Enemy X position = [enemy fall start X position]
$A8:F93E BF 0E 78 7E LDA $7E780E,x[$7E:79CE];\
$A8:F942 9D 7E 0F    STA $0F7E,x[$7E:113E]  ;} Enemy Y position = [enemy fall start Y position]
$A8:F945 80 E3       BRA $E3    [$F92A]     ; Return (the store to $0FAA,x doesn't matter, so not sure why this isn't just an RTL)
}


;;; $F947: Set up falling ki-hunter wings drifting left ;;;
{
$A8:F947 A9 DB F7    LDA #$F7DB             ;\
$A8:F94A 9F 00 78 7E STA $7E7800,x          ;} Enemy falling function = $F7DB (drifting left)
$A8:F94E BF 14 78 7E LDA $7E7814,x          ;\
$A8:F952 9D AA 0F    STA $0FAA,x            ;} Enemy speed table index = [enemy speed table index reset value]
$A8:F955 A9 00 E0    LDA #$E000             ;\
$A8:F958 9D B2 0F    STA $0FB2,x            ;} Enemy arc angle = -2000h
$A8:F95B BD 7A 0F    LDA $0F7A,x            ;\
$A8:F95E 9F 0A 78 7E STA $7E780A,x          ;} Enemy arc start X position = [enemy X position]
$A8:F962 BD 7E 0F    LDA $0F7E,x            ;\
$A8:F965 9F 0C 78 7E STA $7E780C,x          ;} Enemy arc start Y position = [enemy Y position]
$A8:F969 60          RTS
}


;;; $F96A: Set up falling ki-hunter wings drifting right ;;;
{
$A8:F96A A9 AD F8    LDA #$F8AD             ;\
$A8:F96D 9F 00 78 7E STA $7E7800,x[$7E:7940];} Enemy falling function = $F8AD (drifting right)
$A8:F971 BF 14 78 7E LDA $7E7814,x[$7E:7954];\
$A8:F975 9D AA 0F    STA $0FAA,x[$7E:10EA]  ;} Enemy speed table index = [enemy speed table index reset value]
$A8:F978 A9 00 A0    LDA #$A000             ;\
$A8:F97B 9D B2 0F    STA $0FB2,x[$7E:10F2]  ;} Enemy arc angle = -6000h
$A8:F97E BD 7A 0F    LDA $0F7A,x[$7E:10BA]  ;\
$A8:F981 9F 0A 78 7E STA $7E780A,x[$7E:794A];} Enemy arc start X position = [enemy X position]
$A8:F985 BD 7E 0F    LDA $0F7E,x[$7E:10BE]  ;\
$A8:F988 9F 0C 78 7E STA $7E780C,x[$7E:794C];} Enemy arc start Y position = [enemy Y position]
$A8:F98C 60          RTS
}


;;; $F98D: Determine falling ki-hunter wings speed table index reset value ;;;
{
$A8:F98D AE 54 0E    LDX $0E54  [$7E:0E54]
$A8:F990 A9 00 00    LDA #$0000             ;\
$A8:F993 9F 14 78 7E STA $7E7814,x[$7E:7954];} Enemy speed table index reset value = 0
$A8:F997 9D AA 0F    STA $0FAA,x[$7E:10EA]  ; Enemy speed table index = 0

; LOOP
$A8:F99A BF 14 78 7E LDA $7E7814,x[$7E:7954];\
$A8:F99E 18          CLC                    ;|
$A8:F99F 69 80 01    ADC #$0180             ;} Enemy speed table index reset value += 180h
$A8:F9A2 9F 14 78 7E STA $7E7814,x[$7E:7954];/
$A8:F9A6 29 00 FF    AND #$FF00             ;\
$A8:F9A9 EB          XBA                    ;|
$A8:F9AA 0A          ASL A                  ;|
$A8:F9AB 0A          ASL A                  ;} Y = [enemy speed table index reset value] / 100h * 8 (quadratic speed table index)
$A8:F9AC 0A          ASL A                  ;|
$A8:F9AD A8          TAY                    ;/
$A8:F9AE BD AE 0F    LDA $0FAE,x[$7E:10EE]  ;\
$A8:F9B1 18          CLC                    ;|
$A8:F9B2 79 90 83    ADC $8390,y[$A8:8398]  ;} Enemy angle accumulator += [$838F + [Y] + 1] (speed * 100h)
$A8:F9B5 9D AE 0F    STA $0FAE,x[$7E:10EE]  ;/
$A8:F9B8 C9 00 20    CMP #$2000             ;\
$A8:F9BB 30 DD       BMI $DD    [$F99A]     ;} If [enemy angle accumulator] < 2000h: go to LOOP
$A8:F9BD 60          RTS
}
}
}


;;; $F9BE: Free space ;;;
{
$A8:F9BE             fillto $A98000, $FF
}
