;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687: Hurt AI - enemy $DD8F (Crocomire) ;;;
{
; No call to $8C95, I guess that's why charged plasma lets you roll over past Crocomire
$A4:8687 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:868A 22 5B 8B A4 JSL $A48B5B[$A4:8B5B]  ; Update Crocomire BG2 scroll
$A4:868E 20 CB 8C    JSR $8CCB  [$A4:8CCB]  ; Crocomire hurt flash handling
$A4:8691 6B          RTL
}


;;; $8692: Crocomire constants ;;;
{
$A4:8692             dw 0008
$A4:8694             dw 0008
$A4:8696             dw 0000
$A4:8698             dw 0002
$A4:869A             dw 0001
$A4:869C             dw 0003
$A4:869E             dw 0003
$A4:86A0             dw 0008
$A4:86A2             dw 0300
$A4:86A4             dw 0640
}


;;; $86A6..8A39: Fight AI ;;;
{
;;; $86A6: Instruction - fight AI ;;;
{
$A4:86A6 DA          PHX
$A4:86A7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:86AA BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A4:86AD AA          TAX                    ;} Execute [$86B3 + [Crocomire fight function index]]
$A4:86AE FC B3 86    JSR ($86B3,x)[$A4:86F2];/
$A4:86B1 FA          PLX
$A4:86B2 6B          RTL

$A4:86B3             dw 86DE, 86E8, 86F2, 8717, 876C, 87B2, 87CA, 87E9, 87FB, 8812, 8836, 885A, 887E, 889A, 88D2, 891B,
                        8940, 895E, 89A8, 89DE, 89F9
}


;;; $86DD: RTS ;;;
{
$A4:86DD 60          RTS
}


;;; $86DE: Fight AI - index 0 - lock up (unused) / set initial Crocomire instruction list ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:86DE A0 DE BA    LDY #$BADE             ; Y = $BADE (initial)
$A4:86E1 A9 01 00    LDA #$0001             ;\
$A4:86E4 9D 94 0F    STA $0F94,x            ;} Crocomire instruction timer = 1
$A4:86E7 60          RTS
}


;;; $86E8: Fight AI - index 2 - step forward until on screen (unused) / step forward ;;;
{
;; Returns:
;;     Y: Instruction list pointer

; Skips the "wait for damage" stage if Crocomire happens to perform a projectile attack during its stepping forward
$A4:86E8 A9 04 00    LDA #$0004             ;\
$A4:86EB 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 4 (asleep)
$A4:86EE A0 CE BB    LDY #$BBCE             ; Y = $BBCE (step forward)
$A4:86F1 60          RTS
}


;;; $86F2: Fight AI - index 4 - asleep ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:86F2 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:86F5 38          SEC                    ;|
$A4:86F6 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A4:86F9 10 04       BPL $04    [$86FF]     ;|
$A4:86FB 49 FF FF    EOR #$FFFF             ;} If |[Crocomire X position] - [Samus X position]| < E0h:
$A4:86FE 1A          INC A                  ;|
                                            ;|
$A4:86FF C9 E0 00    CMP #$00E0             ;|
$A4:8702 10 12       BPL $12    [$8716]     ;/
$A4:8704 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8707 09 00 80    ORA #$8000             ;} Crocomire fight flags |= 8000h (awake)
$A4:870A 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:870D A0 56 BC    LDY #$BC56             ; Y = $BC56 (wait for first/second damage)
$A4:8710 A9 12 00    LDA #$0012             ;\
$A4:8713 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 12h (wait for first damage)

$A4:8716 60          RTS
}


;;; $8717: Fight AI - index 6 - stepping forward ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:8717 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:871A 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h != 0 (damaged):
$A4:871D F0 18       BEQ $18    [$8737]     ;/
$A4:871F AD AA 0F    LDA $0FAA  [$7E:0FAA]  ; >_<;
$A4:8722 29 FF F7    AND #$F7FF             ;\
$A4:8725 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~800h (not damaged)
$A4:8728 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:872B F0 0A       BEQ $0A    [$8737]     ;} If [Crocomire step back counter] != 0:
$A4:872D A0 30 BC    LDY #$BC30             ; Y = $BC30 (step back)
$A4:8730 A9 0C 00    LDA #$000C             ;\
$A4:8733 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (stepping back)
$A4:8736 60          RTS                    ; Return

$A4:8737 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:873A CD A2 86    CMP $86A2  [$A4:86A2]  ;} If [Crocomire X position] < 300h: go to BRANCH_NEAR_SPIKE_WALL
$A4:873D 30 09       BMI $09    [$8748]     ;/
$A4:873F C0 34 BC    CPY #$BC34             ;\
$A4:8742 30 03       BMI $03    [$8747]     ;} If [Y] >= $BC34:
$A4:8744 A0 CE BB    LDY #$BBCE             ; Y = $BBCE (step forward)

$A4:8747 60          RTS                    ; Return

; BRANCH_NEAR_SPIKE_WALL
$A4:8748 A0 7E BE    LDY #$BE7E             ; Y = $BE7E (near spike wall charge)
$A4:874B A9 0A 00    LDA #$000A             ;\
$A4:874E 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ah (near spike wall charge)
$A4:8751 60          RTS
}


;;; $8752: Instruction - maybe start projectile attack ;;;
{
$A4:8752 DA          PHX
$A4:8753 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A4:8756 29 FF 0F    AND #$0FFF             ;|
$A4:8759 C9 00 04    CMP #$0400             ;} If [random number] % 1000h < 400h:
$A4:875C 10 0C       BPL $0C    [$876A]     ;/
$A4:875E A9 08 00    LDA #$0008             ;\
$A4:8761 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 8 (projectile attack)
$A4:8764 9C B2 0F    STZ $0FB2  [$7E:0FB2]  ; Crocomire projectile counter = 0
$A4:8767 A0 36 BB    LDY #$BB36             ; Y = $BB36 (projectile attack)

$A4:876A FA          PLX
$A4:876B 6B          RTL
}


;;; $876C: Fight AI - index 8 - projectile attack ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:876C AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:876F 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h != 0 (damaged):
$A4:8772 F0 10       BEQ $10    [$8784]     ;/
$A4:8774 29 FF F7    AND #$F7FF             ;\
$A4:8777 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~800h (not damaged)
$A4:877A A0 30 BC    LDY #$BC30             ; Y = $BC30 (step back)
$A4:877D A9 0C 00    LDA #$000C             ;\
$A4:8780 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (stepping back)
$A4:8783 60          RTS                    ; Return

$A4:8784 AD B2 0F    LDA $0FB2  [$7E:0FB2]  ; A = [Crocomire projectile counter]
$A4:8787 C9 12 00    CMP #$0012             ;\
$A4:878A 10 1C       BPL $1C    [$87A8]     ;} If [Crocomire projectile counter] < 12h:
$A4:878C EE B2 0F    INC $0FB2  [$7E:0FB2]  ;\
$A4:878F EE B2 0F    INC $0FB2  [$7E:0FB2]  ;} Crocomire projectile counter += 2
$A4:8792 DA          PHX
$A4:8793 5A          PHY
$A4:8794 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8797 A0 8F 8F    LDY #$8F8F             ;\
$A4:879A 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Crocomire's projectile enemy projectile
$A4:879E A9 1C 00    LDA #$001C             ;\
$A4:87A1 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 1Ch, sound library 3, max queued sounds allowed = 6 (Crocomire spit)
$A4:87A5 7A          PLY
$A4:87A6 FA          PLX
$A4:87A7 60          RTS                    ; Return

$A4:87A8 A0 CA BB    LDY #$BBCA             ; Y = $BBCA (step forward after delay)
$A4:87AB A9 06 00    LDA #$0006             ;\
$A4:87AE 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 6 (stepping forward)
$A4:87B1 60          RTS
}


;;; $87B2: Fight AI - index Ah - near spike wall charge ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:87B2 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:87B5 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h != 0 (damaged):
$A4:87B8 F0 0F       BEQ $0F    [$87C9]     ;/
$A4:87BA 29 FF F7    AND #$F7FF             ;\
$A4:87BD 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~800h (not damaged)
$A4:87C0 A0 30 BC    LDY #$BC30             ; Y = $BC30 (step back)
$A4:87C3 A9 0C 00    LDA #$000C             ;\
$A4:87C6 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (stepping back)

$A4:87C9 60          RTS
}


;;; $87CA: Fight AI - index Ch - stepping back ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:87CA AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:87CD F0 10       BEQ $10    [$87DF]     ;} If [Crocomire step back counter] != 0:
$A4:87CF 3A          DEC A                  ;\
$A4:87D0 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Decrement Crocomire step back counter
$A4:87D3 F0 0A       BEQ $0A    [$87DF]     ; If [Crocomire step back counter] != 0:
$A4:87D5 A0 34 BC    LDY #$BC34             ; Y = $BC34 (stepping back)
$A4:87D8 A9 0C 00    LDA #$000C             ;\
$A4:87DB 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (>_<;)
$A4:87DE 60          RTS                    ; Return

$A4:87DF A9 06 00    LDA #$0006             ;\
$A4:87E2 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 6 (stepping forward)
$A4:87E5 A0 CE BB    LDY #$BBCE             ; Y = $BBCE (step forward)
$A4:87E8 60          RTS
}


;;; $87E9: Fight AI - index Eh - back off from spike wall ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:87E9 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:87EC CD A2 86    CMP $86A2  [$A4:86A2]  ;} If [Crocomire X position] >= 300h:
$A4:87EF 30 09       BMI $09    [$87FA]     ;/
$A4:87F1 A9 06 00    LDA #$0006             ;\
$A4:87F4 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 6 (stepping forward)
$A4:87F7 A0 CE BB    LDY #$BBCE             ; Y = $BBCE (step forward)

$A4:87FA 60          RTS
}


;;; $87FB: Fight AI - index 10h - roar and step forwards (unused) ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:87FB A9 06 00    LDA #$0006             ;\
$A4:87FE 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 6 (stepping forward)
$A4:8801 A0 2A BD    LDY #$BD2A             ; Y = $BD2A (wait for first/second damage - roar)
$A4:8804 60          RTS
}


;;; $8805:  ;;;
{
$A4:8805 A0 D8 BC    LDY #$BCD8             ; Y = $BCD8 (wait for first/second damage - moving claws)
$A4:8808 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:880B 29 FF FB    AND #$FBFF             ;} Crocomire fight flags &= ~400h
$A4:880E 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:8811 60          RTS
}


;;; $8812: Fight AI - index 12h - wait for first damage ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:8812 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8815 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h != 0 (damaged):
$A4:8818 F0 13       BEQ $13    [$882D]     ;/
$A4:881A AD AA 0F    LDA $0FAA  [$7E:0FAA]  ; >_<;
$A4:881D 29 FF F7    AND #$F7FF             ;\
$A4:8820 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~800h (not damaged)
$A4:8823 A0 30 BC    LDY #$BC30             ; Y = $BC30 (step back)
$A4:8826 A9 14 00    LDA #$0014             ;\
$A4:8829 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 14h (wait for second damage)
$A4:882C 60          RTS                    ; Return

$A4:882D C0 A2 BD    CPY #$BDA2             ;\
$A4:8830 30 03       BMI $03    [$8835]     ;} If [Y] >= $BDA2:
$A4:8832 A0 2A BD    LDY #$BD2A             ; Y = $BD2A (wait for first/second damage - roar)

$A4:8835 60          RTS
}


;;; $8836: Fight AI - index 14h - wait for second damage ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:8836 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8839 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h != 0 (damaged):
$A4:883C F0 13       BEQ $13    [$8851]     ;/
$A4:883E AD AA 0F    LDA $0FAA  [$7E:0FAA]  ; >_<;
$A4:8841 29 FF F7    AND #$F7FF             ;\
$A4:8844 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~800h (not damaged)
$A4:8847 A0 30 BC    LDY #$BC30             ; Y = $BC30 (step back)
$A4:884A A9 0C 00    LDA #$000C             ;\
$A4:884D 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (stepping back)
$A4:8850 60          RTS                    ; Return

$A4:8851 C0 A2 BD    CPY #$BDA2             ;\
$A4:8854 30 03       BMI $03    [$8859]     ;} If [Y] >= $BDA2:
$A4:8856 A0 2A BD    LDY #$BD2A             ; Y = $BD2A (wait for first/second damage - roar)

$A4:8859 60          RTS
}


;;; $885A: Fight AI - index 16h - wait for second damage (unused) ;;;
{
;; Returns:
;;     Y: Instruction list pointer

; Clone of $8836
$A4:885A AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A4:885D 89 00 08    BIT #$0800
$A4:8860 F0 13       BEQ $13    [$8875]
$A4:8862 AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A4:8865 29 FF F7    AND #$F7FF
$A4:8868 8D AA 0F    STA $0FAA  [$7E:0FAA]
$A4:886B A0 30 BC    LDY #$BC30
$A4:886E A9 0C 00    LDA #$000C
$A4:8871 8D AC 0F    STA $0FAC  [$7E:0FAC]
$A4:8874 60          RTS

$A4:8875 C0 A2 BD    CPY #$BDA2
$A4:8878 30 03       BMI $03    [$887D]
$A4:887A A0 2A BD    LDY #$BD2A

$A4:887D 60          RTS
}


;;; $887E: Fight AI - index 18h - power bombed charge ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:887E AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8881 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:8884 3A          DEC A                  ;} Decrement Crocomire step forward counter
$A4:8885 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;/
$A4:8888 C9 02 00    CMP #$0002             ;\
$A4:888B 10 0C       BPL $0C    [$8899]     ;} If [Crocomire step forward counter] < 2:
$A4:888D 9C AE 0F    STZ $0FAE  [$7E:0FAE]  ; Crocomire step forward counter = 0
$A4:8890 A9 06 00    LDA #$0006             ;\
$A4:8893 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 6 (stepping forward)
$A4:8896 A0 CE BB    LDY #$BBCE             ; Y = $BBCE (step forward)

$A4:8899 60          RTS
}


;;; $889A: Fight AI - index 1Ah - do near spike wall charge unless damaged (unused) ;;;
{
;; Returns:
;;     Y: Instruction list pointer

; The sound effect played here sound a bit like skree (sound 5Bh)
$A4:889A AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:889D AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:88A0 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h = 0 (not damaged):
$A4:88A3 D0 0A       BNE $0A    [$88AF]     ;/
$A4:88A5 A9 0A 00    LDA #$000A             ;\
$A4:88A8 9D AC 0F    STA $0FAC,x            ;} Crocomire fight function index = Ah (near spike wall charge)
$A4:88AB A0 8E BD    LDY #$BD8E             ; Y = $BD8E (wait for first/second damage - roar - close mouth)
$A4:88AE 60          RTS                    ; Return

$A4:88AF 29 00 BF    AND #$BF00             ; Crocomire fight flags &= ~40FFh (Samus not hit by claw)
$A4:88B2 09 00 A0    ORA #$A000             ;\
$A4:88B5 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags |= A000h (awake, unused bit)
$A4:88B8 A9 01 00    LDA #$0001             ;\
$A4:88BB 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Crocomire step back counter = 1
$A4:88BE A9 0A 00    LDA #$000A             ;\
$A4:88C1 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} $0FB0 = Ah
$A4:88C4 A9 0C 00    LDA #$000C             ;\
$A4:88C7 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (stepping back)
$A4:88CA A9 54 00    LDA #$0054             ;\
$A4:88CD 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 54h, sound library 2, max queued sounds allowed = 6 (shot Crocomire)
$A4:88D1 60          RTS
}


;;; $88D2: Fight AI - index 1Ch ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:88D2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:88D5 20 DE 86    JSR $86DE  [$A4:86DE]  ; Set initial Crocomire instruction list
$A4:88D8 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:88DB 09 00 02    ORA #$0200             ;} Crocomire fight flags |= 200h
$A4:88DE 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:88E1 A9 20 00    LDA #$0020             ;\
$A4:88E4 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} $0FAE = 20h
$A4:88E7 A9 1E 00    LDA #$001E             ;\
$A4:88EA 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 1Eh
$A4:88ED 60          RTS
}


;;; $88EE: Unused. Charge Crocomire forward one step after delay ;;;
{
$A4:88EE AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:88F1 20 DE 86    JSR $86DE  [$A4:86DE]  ; Set initial Crocomire instruction list
$A4:88F4 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:88F7 F0 05       BEQ $05    [$88FE]     ;} If [$0FAE] != 0:
$A4:88F9 CE AE 0F    DEC $0FAE  [$7E:0FAE]  ; Decrement $0FAE
$A4:88FC D0 0C       BNE $0C    [$890A]     ; If [$0FAE] != 0: return

$A4:88FE AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8901 20 0B 89    JSR $890B  [$A4:890B]  ; Charge Crocomire forward one step
$A4:8904 A9 20 00    LDA #$0020             ;\
$A4:8907 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 20h

$A4:890A 60          RTS
}


;;; $890B: Charge Crocomire forward one step ;;;
{
; Both callers of this function immediately overwrite $0FAC
$A4:890B A9 14 00    LDA #$0014             ;\
$A4:890E 9D AC 0F    STA $0FAC,x            ;} Crocomire fight function index = 14h (wait for second damage)
$A4:8911 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8914 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} >_<;
$A4:8917 A0 EA BA    LDY #$BAEA             ; Y = $BAEA (charge forward one step)
$A4:891A 60          RTS
}


;;; $891B: Fight AI - index 1Eh ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:891B AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:891E AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8921 89 00 01    BIT #$0100             ;} If [Crocomire fight flags] & 100h = 0:
$A4:8924 D0 0A       BNE $0A    [$8930]     ;/
$A4:8926 20 0B 89    JSR $890B  [$A4:890B]  ; Charge Crocomire forward one step
$A4:8929 A9 20 00    LDA #$0020             ;\
$A4:892C 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 20h
$A4:892F 60          RTS                    ; Return

$A4:8930 20 DE 86    JSR $86DE  [$A4:86DE]  ; Set initial Crocomire instruction list
$A4:8933 A9 10 00    LDA #$0010             ;\
$A4:8936 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} $0FAE = 10h
$A4:8939 A9 22 00    LDA #$0022             ;\
$A4:893C 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 22h
$A4:893F 60          RTS
}


;;; $8940: Fight AI - index 20h ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:8940 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8943 20 DE 86    JSR $86DE  [$A4:86DE]  ; Set initial Crocomire instruction list
$A4:8946 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:8949 D0 12       BNE $12    [$895D]     ;} If [$0FAE] = 0:
$A4:894B AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:894E 09 00 20    ORA #$2000             ;} Crocomire fight flags |= 2000h
$A4:8951 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:8954 20 E8 86    JSR $86E8  [$A4:86E8]  ; Step forward
$A4:8957 A9 24 00    LDA #$0024             ;\
$A4:895A 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 24h

$A4:895D 60          RTS
}


;;; $895E: Fight AI - index 22h ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:895E AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:8961 C9 A0 02    CMP #$02A0             ;} If [Crocomire X position] < 2A0h:
$A4:8964 10 13       BPL $13    [$8979]     ;/
$A4:8966 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8969 20 E8 86    JSR $86E8  [$A4:86E8]  ; Step forward
$A4:896C A9 24 00    LDA #$0024             ;\
$A4:896F 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 24h
$A4:8972 A9 03 00    LDA #$0003             ;\
$A4:8975 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} $0FAE = 3
$A4:8978 60          RTS                    ; Return

$A4:8979 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:897C 89 00 40    BIT #$4000             ;} If [Crocomire fight flags] & 4000h = 0 (Samus not hit by claw):
$A4:897F D0 09       BNE $09    [$898A]     ;/
$A4:8981 A9 26 00    LDA #$0026             ;\
$A4:8984 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 26h
$A4:8987 20 05 88    JSR $8805  [$A4:8805]  ; Execute $8805

$A4:898A AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:898D 89 00 40    BIT #$4000             ;} If [Crocomire fight flags] & 4000h != 0 (Samus hit by claw):
$A4:8990 F0 15       BEQ $15    [$89A7]     ;/
$A4:8992 A9 05 00    LDA #$0005             ;\
$A4:8995 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} $0FAE = 5
$A4:8998 A0 D8 BC    LDY #$BCD8             ; Y = $BCD8 (wait for first/second damage - moving claws)
$A4:899B AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A4:899E 8D B2 0F    STA $0FB2  [$7E:0FB2]  ;} $0FB2 = [Crocomire fight function index]
$A4:89A1 A9 2A 00    LDA #$002A             ;\
$A4:89A4 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 2Ah

$A4:89A7 60          RTS
}


;;; $89A8: Fight AI - index 24h ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:89A8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:89AB AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:89AE F0 1B       BEQ $1B    [$89CB]     ;} If [$0FAE] != 0:
$A4:89B0 CE AE 0F    DEC $0FAE  [$7E:0FAE]  ; Decrement $0FAE
$A4:89B3 F0 16       BEQ $16    [$89CB]     ; If [$0FAE] != 0:
$A4:89B5 A9 24 00    LDA #$0024             ;\
$A4:89B8 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 24h
$A4:89BB 9C EE 0F    STZ $0FEE  [$7E:0FEE]  ; $0FEE = 0
$A4:89BE AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:89C1 09 00 04    ORA #$0400             ;} Crocomire fight flags |= 400h
$A4:89C4 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:89C7 A0 D8 BC    LDY #$BCD8             ; Y = $BCD8 (wait for first/second damage - moving claws)
$A4:89CA 60          RTS                    ; Return

$A4:89CB 20 E8 86    JSR $86E8  [$A4:86E8]  ; Step forward
$A4:89CE A9 28 00    LDA #$0028             ;\
$A4:89D1 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 28h
$A4:89D4 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:89D7 29 FF FB    AND #$FBFF             ;} Crocomire fight flags &= ~400h
$A4:89DA 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:89DD 60          RTS
}


;;; $89DE: Fight AI - index 26h ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:89DE AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:89E1 89 00 20    BIT #$2000             ;} If [Crocomire fight flags] & 2000h = 0:
$A4:89E4 D0 06       BNE $06    [$89EC]     ;/
$A4:89E6 29 FF FC    AND #$FCFF             ;\
$A4:89E9 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~300h

$A4:89EC AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:89EF 20 E8 86    JSR $86E8  [$A4:86E8]  ; Step forward
$A4:89F2 A9 28 00    LDA #$0028             ;\
$A4:89F5 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 28h
$A4:89F8 60          RTS
}


;;; $89F9: Fight AI - index 28h ;;;
{
;; Returns:
;;     Y: Instruction list pointer
$A4:89F9 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:89FC D0 19       BNE $19    [$8A17]     ;} If [$0FAE] = 0:
$A4:89FE AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8A01 29 FF BF    AND #$BFFF             ;} Crocomire fight flags &= ~4000h (Samus not hit by claw)
$A4:8A04 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:8A07 A9 01 00    LDA #$0001             ;\
$A4:8A0A 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Crocomire instruction timer = 1
$A4:8A0D AD B2 0F    LDA $0FB2  [$7E:0FB2]  ;\
$A4:8A10 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = [$0FB2]
$A4:8A13 A0 D8 BC    LDY #$BCD8             ; Y = $BCD8 (wait for first/second damage - moving claws)
$A4:8A16 60          RTS                    ; Return

$A4:8A17 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8A1A 89 00 40    BIT #$4000             ;} If [Crocomire fight flags] & 4000h != 0 (Samus hit by claw):
$A4:8A1D F0 0E       BEQ $0E    [$8A2D]     ;/
$A4:8A1F CE AE 0F    DEC $0FAE  [$7E:0FAE]  ; Decrement $0FAE
$A4:8A22 A9 3B 00    LDA #$003B             ;\
$A4:8A25 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Bh, sound library 2, max queued sounds allowed = 6 (dachora shinespark)
$A4:8A29 A0 D8 BC    LDY #$BCD8             ; Y = $BCD8 (wait for first/second damage - moving claws)
$A4:8A2C 60          RTS                    ; Return

$A4:8A2D 29 FF BF    AND #$BFFF             ;\
$A4:8A30 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags &= ~4000h (Samus not hit by claw)
$A4:8A33 A9 0C 00    LDA #$000C             ;\
$A4:8A36 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Ch (stepping back)
$A4:8A39 60          RTS
}
}


;;; $8A3A: Crocomire palette ;;;
{
$A4:8A3A             dw 3800, 7FFF, 6B40, 6A80, 6980, 68E0, 6800, 5294, 39CE, 2108, 08BF, 0895, 039F, 023A, 0176, 0000
}


;;; $8A5A: Initialisation AI - enemy $DDBF (Crocomire) ;;;
{
$A4:8A5A C2 30       REP #$30
$A4:8A5C A9 06 00    LDA #$0006             ;\
$A4:8A5F 8D 9C 17    STA $179C  [$7E:179C]  ;} Boss ID = 6
$A4:8A62 A2 00 00    LDX #$0000             ;\
$A4:8A65 A9 38 03    LDA #$0338             ;|
                                            ;|
$A4:8A68 9F 00 20 7E STA $7E2000,x[$7E:2000];|
$A4:8A6C E8          INX                    ;} $7E:2000..2FFF = 338h (BG2 tilemap)
$A4:8A6D E8          INX                    ;|
$A4:8A6E E0 00 10    CPX #$1000             ;|
$A4:8A71 30 F5       BMI $F5    [$8A68]     ;/
$A4:8A73 AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A4:8A76 BF 28 D8 7E LDA $7ED828,x[$7E:D82A];|
$A4:8A7A 89 02 00    BIT #$0002             ;} If area mini-boss dead: go to BRANCH_DEAD
$A4:8A7D D0 5D       BNE $5D    [$8ADC]     ;/
$A4:8A7F 22 E2 A7 90 JSL $90A7E2[$90:A7E2]  ; Disable mini-map and mark boss room map tiles as explored
$A4:8A83 9C 9A 06    STZ $069A  [$7E:069A]  ; $069A = 0
$A4:8A86 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8A89 9E A8 0F    STZ $0FA8,x[$7E:0FA8]  ; Crocomire death sequence index = 0
$A4:8A8C 9E B0 0F    STZ $0FB0,x[$7E:0FB0]  ; $0FB0 = 0
$A4:8A8F A9 00 00    LDA #$0000             ;\
$A4:8A92 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scrolls 0..1 = red
$A4:8A96 A2 20 00    LDX #$0020             ;\
                                            ;|
$A4:8A99 BD BD B8    LDA $B8BD,x[$A4:B8DD]  ;|
$A4:8A9C 9F 40 C3 7E STA $7EC340,x[$7E:C360];|
$A4:8AA0 BD DD B8    LDA $B8DD,x[$A4:B8FD]  ;} Target sprite palette 2 = [$B8BD..DC]
$A4:8AA3 9F A0 C3 7E STA $7EC3A0,x[$7E:C3C0];} Target sprite palette 5 = [$B8DD..FC]
$A4:8AA7 CA          DEX                    ;|
$A4:8AA8 CA          DEX                    ;|
$A4:8AA9 10 EE       BPL $EE    [$8A99]     ;/
$A4:8AAB AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8AAE A9 04 00    LDA #$0004             ;\
$A4:8AB1 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Crocomire fight function index = 4
$A4:8AB4 A9 10 00    LDA #$0010             ;\
$A4:8AB7 8D 9E 17    STA $179E  [$7E:179E]  ;} $179E = 10h (never read)
$A4:8ABA A9 02 00    LDA #$0002             ;\
$A4:8ABD 8D 41 09    STA $0941  [$7E:0941]  ;} Camera distance index = 2 (camera is 40h/50h pixels to the left of Samus)
$A4:8AC0 A9 00 04    LDA #$0400             ;\
$A4:8AC3 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 400h
$A4:8AC6 A9 DE BA    LDA #$BADE             ;\
$A4:8AC9 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Crocomire instruction list pointer = $BADE
$A4:8ACC BD 88 0F    LDA $0F88,x[$7E:0F88]  ;\
$A4:8ACF 09 04 00    ORA #$0004             ;} Enable enemy extended spritemap format
$A4:8AD2 9D 88 0F    STA $0F88,x[$7E:0F88]  ;/
$A4:8AD5 A9 01 00    LDA #$0001             ;\
$A4:8AD8 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A4:8ADB 6B          RTL                    ; Return

; BRANCH_DEAD
$A4:8ADC A9 01 01    LDA #$0101             ;\
$A4:8ADF 8F 20 CD 7E STA $7ECD20[$7E:CD20]  ;} Scrolls 0..3 = blue
$A4:8AE3 8F 22 CD 7E STA $7ECD22[$7E:CD22]  ;/
$A4:8AE7 9C 88 06    STZ $0688  [$7E:0688]  ; $0688 = 0
$A4:8AEA AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A4:8AED 09 00 04    ORA #$0400             ;|
$A4:8AF0 29 FF 7F    AND #$7FFF             ;} Set Crocomire as intangible and not solid
$A4:8AF3 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A4:8AF6 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8AFA             dx 20,03,B753          ;} Spawn PLM to clear Crocomire invisible wall at (20h, 3)
$A4:8AFE 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8B02             dx 1E,03,B753          ;} Spawn PLM to clear Crocomire invisible wall at (1Eh, 3)
$A4:8B06 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8B0A             dx 61,0B,B747          ;} Spawn PLM to clear Crocomire's bridge
$A4:8B0E A9 54 00    LDA #$0054             ;\
$A4:8B11 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Crocomire death sequence index = 54h
$A4:8B14 A9 CC E1    LDA #$E1CC             ;\
$A4:8B17 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Crocomire instruction list pointer = $E1CC
$A4:8B1A A9 01 00    LDA #$0001             ;\
$A4:8B1D 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Crocomire instruction timer = 1
$A4:8B20 A9 40 02    LDA #$0240             ;\
$A4:8B23 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Crocomire X position = 240h
$A4:8B26 A9 90 00    LDA #$0090             ;\
$A4:8B29 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Crocomire Y position = 90h
$A4:8B2C A9 1C 00    LDA #$001C             ;\
$A4:8B2F 8D 84 0F    STA $0F84  [$7E:0F84]  ;} Crocomire Y radius = 1Ch
$A4:8B32 A9 28 00    LDA #$0028             ;\
$A4:8B35 8D 82 0F    STA $0F82  [$7E:0F82]  ;} Crocomire X radius = 28h
$A4:8B38 AE 30 03    LDX $0330  [$7E:0330]  ;\
$A4:8B3B A9 00 08    LDA #$0800             ;|
$A4:8B3E 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A4:8B40 A9 00 20    LDA #$2000             ;|
$A4:8B43 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A4:8B45 A9 7E 00    LDA #$007E             ;|
$A4:8B48 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A4:8B4A A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of $7E:2000..7FFF to VRAM BG2 tilemap
$A4:8B4C 29 FC 00    AND #$00FC             ;|
$A4:8B4F EB          XBA                    ;|
$A4:8B50 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A4:8B52 8A          TXA                    ;|
$A4:8B53 18          CLC                    ;|
$A4:8B54 69 07 00    ADC #$0007             ;|
$A4:8B57 8D 30 03    STA $0330  [$7E:0330]  ;/
$A4:8B5A 6B          RTL
}


;;; $8B5B: Update Crocomire BG2 scroll ;;;
{
$A4:8B5B BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A4:8B5E 38          SEC                    ;|
$A4:8B5F E9 43 00    SBC #$0043             ;|
$A4:8B62 49 FF FF    EOR #$FFFF             ;} BG2 Y scroll = 43h - [Crocomire Y position]
$A4:8B65 1A          INC A                  ;|
$A4:8B66 85 B7       STA $B7    [$7E:00B7]  ;/
$A4:8B68 A2 20 00    LDX #$0020             ; X = 20h

; LOOP
$A4:8B6B AD 8E 0F    LDA $0F8E  [$7E:0F8E]  ;\
$A4:8B6E DD 79 8B    CMP $8B79,x[$A4:8B99]  ;} If [$8B79 + [X]] = [Crocomire spritemap pointer]: go to BRANCH_FOUND
$A4:8B71 F0 28       BEQ $28    [$8B9B]     ;/
$A4:8B73 CA          DEX                    ;\
$A4:8B74 CA          DEX                    ;} X -= 2
$A4:8B75 10 F4       BPL $F4    [$8B6B]     ; If [X] >= 0: go to LOOP
$A4:8B77 80 2B       BRA $2B    [$8BA4]     ; Go to update Crocomire BG2 X scroll

$A4:8B79             dw BFC4, BFF6, C028, C05A, C08C, C0BE, C0F0, C122, C154, C186, C1B8, C1EA, C47A, C4AC, C4DE, C510, C542

; BRANCH_FOUND
$A4:8B9B A8          TAY                    ;\
$A4:8B9C B9 1C 00    LDA $001C,y[$A4:C496]  ;|
$A4:8B9F 18          CLC                    ;} BG2 Y scroll += [Crocomire spritemap entry 3 Y offset]
$A4:8BA0 65 B7       ADC $B7    [$7E:00B7]  ;|
$A4:8BA2 85 B7       STA $B7    [$7E:00B7]  ;/
}


;;; $8BA4: Update Crocomire BG2 X scroll ;;;
{
$A4:8BA4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8BA7 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A4:8BAA 18          CLC                    ;|
$A4:8BAB 7D E8 0F    ADC $0FE8,x[$7E:0FE8]  ;} Crocomire's tongue X position = [Crocomire X position] + [Crocomire's tongue X offset]
$A4:8BAE 9D BA 0F    STA $0FBA,x[$7E:0FBA]  ;/
$A4:8BB1 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A4:8BB4 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;} Crocomire's tongue Y position = [Crocomire Y position]
$A4:8BB7 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A4:8BBA CD 11 09    CMP $0911  [$7E:0911]  ;} If [Crocomire X position] >= [layer 1 X position]: go to BRANCH_RIGHT_OFF_SCREEN_CHECK
$A4:8BBD 10 2F       BPL $2F    [$8BEE]     ;/
$A4:8BBF 18          CLC                    ;\
$A4:8BC0 69 80 00    ADC #$0080             ;|
$A4:8BC3 CD 11 09    CMP $0911  [$7E:0911]  ;} If [Crocomire X position] + 80h < [layer 1 X position]: go to BRANCH_OFF_SCREEN
$A4:8BC6 30 20       BMI $20    [$8BE8]     ;/

; BRANCH_ON_SCREEN
$A4:8BC8 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A4:8BCB 38          SEC                    ;|
$A4:8BCC FD 7A 0F    SBC $0F7A,x[$7E:0F7A]  ;|
$A4:8BCF 18          CLC                    ;} BG2 X scroll = [layer 1 X position] + 33h - [Crocomire X position]
$A4:8BD0 69 33 00    ADC #$0033             ;|
$A4:8BD3 48          PHA                    ;/
$A4:8BD4 10 04       BPL $04    [$8BDA]     ;\
$A4:8BD6 49 FF FF    EOR #$FFFF             ;|
$A4:8BD9 1A          INC A                  ;|
                                            ;} If |[BG2 X scroll]| >= 11Ch:
$A4:8BDA C9 1C 01    CMP #$011C             ;|
$A4:8BDD 30 05       BMI $05    [$8BE4]     ;/
$A4:8BDF 68          PLA                    ;\
$A4:8BE0 A9 00 01    LDA #$0100             ;} BG2 X scroll = 100h
$A4:8BE3 48          PHA                    ;/

$A4:8BE4 68          PLA
$A4:8BE5 85 B5       STA $B5    [$7E:00B5]
$A4:8BE7 6B          RTL                    ; Return

; BRANCH_OFF_SCREEN
$A4:8BE8 A9 00 01    LDA #$0100             ;\
$A4:8BEB 85 B5       STA $B5    [$7E:00B5]  ;} BG2 X scroll = 100h
$A4:8BED 6B          RTL                    ; Return

; BRANCH_RIGHT_OFF_SCREEN_CHECK
$A4:8BEE AD 11 09    LDA $0911  [$7E:0911]  ;\
$A4:8BF1 18          CLC                    ;|
$A4:8BF2 69 00 01    ADC #$0100             ;|
$A4:8BF5 85 12       STA $12    [$7E:0012]  ;|
$A4:8BF7 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;} If [Crocomire X position] - 80h >= [layer 1 X position] + 100h: go to BRANCH_OFF_SCREEN
$A4:8BFA 38          SEC                    ;|
$A4:8BFB E9 80 00    SBC #$0080             ;|
$A4:8BFE C5 12       CMP $12    [$7E:0012]  ;|
$A4:8C00 10 E6       BPL $E6    [$8BE8]     ;/
$A4:8C02 80 C4       BRA $C4    [$8BC8]     ; Go to BRANCH_ON_SCREEN
}


;;; $8C04: Main AI - enemy $DDBF (Crocomire) ;;;
{
$A4:8C04 8B          PHB
$A4:8C05 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A4:8C08 AA          TAX                    ;} Execute [$8C14 + [Crocomire death sequence index]]
$A4:8C09 FC 14 8C    JSR ($8C14,x)[$A4:8C6E];/
$A4:8C0C 20 95 8C    JSR $8C95  [$A4:8C95]  ; Crocomire / Samus collision handling
$A4:8C0F 20 CB 8C    JSR $8CCB  [$A4:8CCB]  ; Crocomire hurt flash handling
$A4:8C12 AB          PLB
$A4:8C13 6B          RTL

$A4:8C14             dw 8C6E, 9136, 8D3F, 92CE, 91BA, 8D3F, 92CE, 91BA, 9341, 943D, 94B6, 929E, 94FB, 9580, 9653, 9108,
                        8D47, 929E, 9108, 8D47, 929E, 9108, 93ED, 943D, 94B6, 9576, 926E, 9506, 9580, 9653, 9099, 97D3,
                        9859, 990A, 99E5, 9A38, 9B06, 9B65, 9B7D, 9B7B, 9B86, 8C8F, 9BBA, 8C90, 9830
}


;;; $8C6E: Crocomire main AI - death sequence index 0 - death sequence not started ;;;
{
$A4:8C6E 22 5E 8D A4 JSL $A48D5E[$A4:8D5E]  ; Handle Crocomire's bridge
$A4:8C72 A9 01 01    LDA #$0101             ;\
$A4:8C75 8F 24 CD 7E STA $7ECD24[$7E:CD24]  ;} Scrolls 4/5 = blue
$A4:8C79 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A4:8C7C C9 20 05    CMP #$0520             ;} If [Samus X position] >= 520h:
$A4:8C7F 30 07       BMI $07    [$8C88]     ;/
$A4:8C81 A9 00 01    LDA #$0100             ;\
$A4:8C84 8F 24 CD 7E STA $7ECD24[$7E:CD24]  ;} Scroll 4 = red

$A4:8C88 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8C8B 22 5B 8B A4 JSL $A48B5B[$A4:8B5B]  ; Update Crocomire BG2 scroll
}


;;; $8C8F: RTS. Crocomire main AI - death sequence index 52h - dead (due to death sequence, final state) ;;;
{
$A4:8C8F 60          RTS
}


;;; $8C90: Crocomire main AI - death sequence index 56h - dead (on room entry, final state) ;;;
{
$A4:8C90 64 B5       STZ $B5    [$7E:00B5]  ; BG2 X scroll = 0
$A4:8C92 64 B7       STZ $B7    [$7E:00B7]  ; BG2 Y scroll = 0
$A4:8C94 60          RTS
}


;;; $8C95: Crocomire / Samus collision handling ;;;
{
$A4:8C95 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A4:8C98 D0 30       BNE $30    [$8CCA]     ;} If [Crocomire death sequence index] = 0:
$A4:8C9A AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:8C9D 38          SEC                    ;|
$A4:8C9E ED 82 0F    SBC $0F82  [$7E:0F82]  ;|
$A4:8CA1 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;} If (Crocomire left boundary) <= (Samus right boundary):
$A4:8CA4 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A4:8CA7 10 21       BPL $21    [$8CCA]     ;/
$A4:8CA9 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A4:8CAD AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:8CB0 38          SEC                    ;|
$A4:8CB1 ED 82 0F    SBC $0F82  [$7E:0F82]  ;|
$A4:8CB4 38          SEC                    ;} Samus X position = (Crocomire left boundary) - [Samus X radius]
$A4:8CB5 ED FE 0A    SBC $0AFE  [$7E:0AFE]  ;|
$A4:8CB8 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$A4:8CBB 8D 10 0B    STA $0B10  [$7E:0B10]  ; Samus previous X position = [Samus X position]
$A4:8CBE A9 FC FF    LDA #$FFFC             ;\
$A4:8CC1 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = -4
$A4:8CC4 A9 FF FF    LDA #$FFFF             ;\
$A4:8CC7 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;} Extra Samus Y displacement = -1

$A4:8CCA 60          RTS
}


;;; $8CCB: Crocomire hurt flash handling ;;;
{
$A4:8CCB AD 97 07    LDA $0797  [$7E:0797]  ;\
$A4:8CCE D0 2A       BNE $2A    [$8CFA]     ;} If door transition active: return
$A4:8CD0 AD 9C 0F    LDA $0F9C  [$7E:0F9C]  ;\
$A4:8CD3 F0 17       BEQ $17    [$8CEC]     ;} If [enemy flash timer] != 0:
$A4:8CD5 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A4:8CD8 89 02 00    BIT #$0002             ;} If [number of times main enemy routine has been executed] / 2 % 2 != 0:
$A4:8CDB F0 0F       BEQ $0F    [$8CEC]     ;/
$A4:8CDD A9 FF 7F    LDA #$7FFF             ;\
$A4:8CE0 A2 0E 00    LDX #$000E             ;|
                                            ;|
$A4:8CE3 9F E0 C0 7E STA $7EC0E0,x[$7E:C0EE];} BG1/2 palette 7 colours 0..7 = 7FFFh
$A4:8CE7 CA          DEX                    ;|
$A4:8CE8 CA          DEX                    ;|
$A4:8CE9 10 F8       BPL $F8    [$8CE3]     ;/
$A4:8CEB 60          RTS                    ; Return

$A4:8CEC A2 0E 00    LDX #$000E             ;\
                                            ;|
$A4:8CEF BD 9D B8    LDA $B89D,x[$A4:B8AB]  ;|
$A4:8CF2 9F E0 C0 7E STA $7EC0E0,x[$7E:C0EE];} BG1/2 palette 7 colours 0..7 = [$B89D..AC]
$A4:8CF6 CA          DEX                    ;|
$A4:8CF7 CA          DEX                    ;|
$A4:8CF8 10 F5       BPL $F5    [$8CEF]     ;/

$A4:8CFA 60          RTS
}


;;; $8CFB: Instruction - queue Crocomire's cry sound effect ;;;
{
$A4:8CFB DA          PHX
$A4:8CFC 5A          PHY
$A4:8CFD A9 74 00    LDA #$0074             ;\
$A4:8D00 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 74h, sound library 2, max queued sounds allowed = 6 (Crocomire's cry)
$A4:8D04 7A          PLY
$A4:8D05 FA          PLX
$A4:8D06 6B          RTL
}


;;; $8D07: Instruction - queue big explosion sound effect ;;;
{
$A4:8D07 DA          PHX
$A4:8D08 5A          PHY
$A4:8D09 A9 25 00    LDA #$0025             ;\
$A4:8D0C 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 25h, sound library 2, max queued sounds allowed = 6 (big explosion)
$A4:8D10 7A          PLY
$A4:8D11 FA          PLX
$A4:8D12 6B          RTL
}


;;; $8D13: Instruction - queue Crocomire's skeleton collapses sound effect ;;;
{
$A4:8D13 DA          PHX
$A4:8D14 5A          PHY
$A4:8D15 A9 75 00    LDA #$0075             ;\
$A4:8D18 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 75h, sound library 2, max queued sounds allowed = 6 (Crocomire's skeleton collapses)
$A4:8D1C 7A          PLY
$A4:8D1D FA          PLX
$A4:8D1E 6B          RTL
}


;;; $8D1F: Handle playing Crocomire acid damage sound effect ;;;
{
$A4:8D1F DA          PHX
$A4:8D20 5A          PHY
$A4:8D21 AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A4:8D25 F0 15       BEQ $15    [$8D3C]     ;} If [Crocomire acid damage sound effect timer] != 0:
$A4:8D27 3A          DEC A                  ;\
$A4:8D28 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Decrement Crocomire acid damage sound effect timer
$A4:8D2C D0 0E       BNE $0E    [$8D3C]     ; If [Crocomire acid damage sound effect timer] = 0:
$A4:8D2E A9 20 00    LDA #$0020             ;\
$A4:8D31 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Crocomire acid damage sound effect timer = 20h
$A4:8D35 A9 22 00    LDA #$0022             ;\
$A4:8D38 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 22h, sound library 3, max queued sounds allowed = 6 (Crocomire acid damage)

$A4:8D3C 7A          PLY
$A4:8D3D FA          PLX
$A4:8D3E 6B          RTL
}


;;; $8D3F: Crocomire main AI - death sequence index 4/Ah - hop 1/2 - resting ;;;
{
$A4:8D3F 22 1F 8D A4 JSL $A48D1F[$A4:8D1F]  ; Handle playing Crocomire acid damage sound effect
$A4:8D43 22 A4 8B A4 JSL $A48BA4[$A4:8BA4]  ; Update Crocomire BG2 X scroll
}


;;; $8D47: Crocomire main AI - death sequence index 20h/26h - hop 4/5 - resting ;;;
{
$A4:8D47 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:8D4A F0 05       BEQ $05    [$8D51]     ;} If [Crocomire rest timer] != 0:
$A4:8D4C 3A          DEC A                  ;\
$A4:8D4D 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Decrement Crocomire rest timer
$A4:8D50 60          RTS                    ; Return

$A4:8D51 EE A8 0F    INC $0FA8  [$7E:0FA8]  ;\
$A4:8D54 EE A8 0F    INC $0FA8  [$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:8D57 A9 00 03    LDA #$0300             ;\
$A4:8D5A 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} $0FB0 = 300h
$A4:8D5D 60          RTS
}


;;; $8D5E: Handle Crocomire's bridge ;;;
{
$A4:8D5E 5A          PHY
$A4:8D5F AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:8D62 C9 00 06    CMP #$0600             ;} If [Crocomire X position] < 600h: go to BRANCH_NOT_ON_BRIDGE
$A4:8D65 30 28       BMI $28    [$8D8F]     ;/
$A4:8D67 C9 10 06    CMP #$0610             ;\
$A4:8D6A 10 38       BPL $38    [$8DA4]     ;} If [Crocomire X position] >= 610h: go to BRANCH_1_BLOCK_DEEP
$A4:8D6C AF 00 90 7E LDA $7E9000[$7E:9000]  ;\
$A4:8D70 D0 1B       BNE $1B    [$8D8D]     ;} If [Crocomire pre-bridge block dust cloud spawned flag] = 0:
$A4:8D72 A9 01 00    LDA #$0001             ;\
$A4:8D75 8F 00 90 7E STA $7E9000[$7E:9000]  ;} Crocomire pre-bridge block dust cloud spawned flag = 1
$A4:8D79 A9 00 06    LDA #$0600             ;\
$A4:8D7C 85 12       STA $12    [$7E:0012]  ;} $12 = 600h (X position)
$A4:8D7E A9 B0 00    LDA #$00B0             ;\
$A4:8D81 85 14       STA $14    [$7E:0014]  ;} $14 = B0h (Y position)
$A4:8D83 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8D86 A0 09 E5    LDY #$E509             ;\
$A4:8D89 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile

$A4:8D8D 7A          PLY
$A4:8D8E 6B          RTL                    ; Return

; BRANCH_NOT_ON_BRIDGE
$A4:8D8F A9 00 00    LDA #$0000             ;\
$A4:8D92 8F 00 90 7E STA $7E9000[$7E:9000]  ;} Crocomire pre-bridge block dust cloud spawned flag = 0
$A4:8D96 8F 02 90 7E STA $7E9002[$7E:9002]  ; Crocomire bridge part 1 crumbled flag = 0
$A4:8D9A 8F 06 90 7E STA $7E9006[$7E:9006]  ; Crocomire bridge part 2 crumbled flag = 0
$A4:8D9E 8F 0A 90 7E STA $7E900A[$7E:900A]  ; $7E:900A = 0 (never read)
$A4:8DA2 7A          PLY
$A4:8DA3 6B          RTL                    ; Return

; BRANCH_1_BLOCK_DEEP
$A4:8DA4 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:8DA7 C9 10 06    CMP #$0610             ;} >_<;
$A4:8DAA 30 30       BMI $30    [$8DDC]     ;/
$A4:8DAC C9 20 06    CMP #$0620             ;\
$A4:8DAF 10 3C       BPL $3C    [$8DED]     ;} If [Crocomire X position] >= 620h: go to BRANCH_2_BLOCKS_DEEP
$A4:8DB1 AF 02 90 7E LDA $7E9002[$7E:9002]  ;\
$A4:8DB5 D0 23       BNE $23    [$8DDA]     ;} If [Crocomire bridge part 1 crumbled flag] = 0:
$A4:8DB7 A9 01 00    LDA #$0001             ;\
$A4:8DBA 8F 02 90 7E STA $7E9002[$7E:9002]  ;} Crocomire bridge part 1 crumbled flag = 1
$A4:8DBE 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8DC2             dx 61,0B,B74B          ;} Spawn PLM to crumble a block of Crocomire's bridge at (61h, Bh)
$A4:8DC6 A9 20 06    LDA #$0620             ;\
$A4:8DC9 85 12       STA $12    [$7E:0012]  ;} $12 = 620h (X position)
$A4:8DCB A9 B0 00    LDA #$00B0             ;\
$A4:8DCE 85 14       STA $14    [$7E:0014]  ;} $14 = B0h (Y position)
$A4:8DD0 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8DD3 A0 09 E5    LDY #$E509             ;\
$A4:8DD6 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile

$A4:8DDA 7A          PLY
$A4:8DDB 6B          RTL                    ; Return

; This branch is never executed
$A4:8DDC A9 00 00    LDA #$0000
$A4:8DDF 8F 02 90 7E STA $7E9002[$7E:9002]
$A4:8DE3 8F 06 90 7E STA $7E9006[$7E:9006]
$A4:8DE7 8F 0A 90 7E STA $7E900A[$7E:900A]
$A4:8DEB 7A          PLY
$A4:8DEC 6B          RTL

; BRANCH_2_BLOCKS_DEEP
$A4:8DED AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:8DF0 C9 20 06    CMP #$0620             ;} >_<;
$A4:8DF3 30 38       BMI $38    [$8E2D]     ;/
$A4:8DF5 C9 30 06    CMP #$0630             ;\
$A4:8DF8 10 40       BPL $40    [$8E3A]     ;} If [Crocomire X position] >= 630h: go to BRANCH_3_BLOCKS_DEEP
$A4:8DFA AF 06 90 7E LDA $7E9006[$7E:9006]  ;\
$A4:8DFE D0 2B       BNE $2B    [$8E2B]     ;} If [Crocomire bridge part 2 crumbled flag] = 0:
$A4:8E00 A9 01 00    LDA #$0001             ;\
$A4:8E03 8F 06 90 7E STA $7E9006[$7E:9006]  ;} Crocomire bridge part 2 crumbled flag = 1
$A4:8E07 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8E0B             dx 62,0B,B74B          ;} Spawn PLM to crumble a block of Crocomire's bridge at (62h, Bh)
$A4:8E0F 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8E13             dx 63,0B,B74B          ;} Spawn PLM to crumble a block of Crocomire's bridge at (63h, Bh)
$A4:8E17 A9 30 06    LDA #$0630             ;\
$A4:8E1A 85 12       STA $12    [$7E:0012]  ;} $12 = 630h (X position)
$A4:8E1C A9 B0 00    LDA #$00B0             ;\
$A4:8E1F 85 14       STA $14    [$7E:0014]  ;} $14 = B0h (Y position)
$A4:8E21 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8E24 A0 09 E5    LDY #$E509             ;\
$A4:8E27 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile

$A4:8E2B 7A          PLY
$A4:8E2C 6B          RTL                    ; Return

; This branch is never executed
$A4:8E2D A9 00 00    LDA #$0000
$A4:8E30 8F 06 90 7E STA $7E9006[$7E:9006]
$A4:8E34 8F 0A 90 7E STA $7E900A[$7E:900A]
$A4:8E38 7A          PLY
$A4:8E39 6B          RTL                    ; Return

; BRANCH_3_BLOCKS_DEEP
$A4:8E3A CD A4 86    CMP $86A4  [$A4:86A4]  ;\
$A4:8E3D 10 02       BPL $02    [$8E41]     ;} If [Crocomire X position] < 640h:
$A4:8E3F 7A          PLY
$A4:8E40 6B          RTL                    ; Return

$A4:8E41 20 E5 8E    JSR $8EE5  [$A4:8EE5]  ; Collapse Crocomire's bridge
$A4:8E44 A9 01 00    LDA #$0001             ;\
$A4:8E47 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Crocomire acid damage sound effect timer = 1
$A4:8E4B A9 01 00    LDA #$0001             ;\
$A4:8E4E 8F 18 90 7E STA $7E9018[$7E:9018]  ;} Crocomire acid damage smoke timer = 1
$A4:8E52 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8E55 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:8E58 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index = 2
$A4:8E5B A9 02 00    LDA #$0002             ;\
$A4:8E5E 8F 00 78 7E STA $7E7800[$7E:7800]  ;} $7E:7800 = 2
$A4:8E62 8F 40 78 7E STA $7E7840[$7E:7840]  ; $7E:7840 = 2
$A4:8E66 8F 80 78 7E STA $7E7880[$7E:7880]  ; $7E:7880 = 2
$A4:8E6A 8F C0 78 7E STA $7E78C0[$7E:78C0]  ; $7E:78C0 = 2
$A4:8E6E 8F 00 79 7E STA $7E7900[$7E:7900]  ; $7E:7900 = 2
$A4:8E72 8F 40 79 7E STA $7E7940[$7E:7940]  ; $7E:7940 = 2
$A4:8E76 A9 00 00    LDA #$0000             ;\
$A4:8E79 8F 02 78 7E STA $7E7802[$7E:7802]  ;} $7E:7802 = 0
$A4:8E7D 8F 42 78 7E STA $7E7842[$7E:7842]  ; $7E:7842 = 0
$A4:8E81 8F 82 78 7E STA $7E7882[$7E:7882]  ; $7E:7882 = 0
$A4:8E85 8F C2 78 7E STA $7E78C2[$7E:78C2]  ; $7E:78C2 = 0
$A4:8E89 8F 02 79 7E STA $7E7902[$7E:7902]  ; $7E:7902 = 0
$A4:8E8D 8F 42 79 7E STA $7E7942[$7E:7942]  ; $7E:7942 = 0
$A4:8E91 A9 3B 00    LDA #$003B             ;\
$A4:8E94 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 3Bh, sound library 2, max queued sounds allowed = 6 (dachora shinespark)
$A4:8E98 A9 00 00    LDA #$0000             ;\
$A4:8E9B 8F 16 90 7E STA $7E9016[$7E:9016]  ;} Crocomire death sequence crumbling bridge index = 0
$A4:8E9F 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8EA3             dx 4E,03,B757          ;} Spawn PLM to create Crocomire invisible wall at (4Eh, 3)
$A4:8EA7 A9 B0 BF    LDA #$BFB0             ;\
$A4:8EAA 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Crocomire instruction list pointer = $BFB0
$A4:8EAD A9 01 00    LDA #$0001             ;\
$A4:8EB0 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Crocomire instruction timer = 1
$A4:8EB3 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A4:8EB6 09 00 04    ORA #$0400             ;} Set Crocomire as intangible
$A4:8EB9 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A4:8EBC A9 FF 7F    LDA #$7FFF             ;\
$A4:8EBF 9D D4 0F    STA $0FD4,x[$7E:0FD4]  ;} Crocomire's tongue instruction timer = 7FFFh
$A4:8EC2 A9 62 BF    LDA #$BF62             ;\
$A4:8EC5 9D D2 0F    STA $0FD2,x[$7E:0FD2]  ;} Crocomire's tongue instruction list pointer = $BF62 (sleep)
$A4:8EC8 AD C6 0F    LDA $0FC6  [$7E:0FC6]  ;\
$A4:8ECB 09 00 01    ORA #$0100             ;} Set Crocomire's tongue to be invisible
$A4:8ECE 8D C6 0F    STA $0FC6  [$7E:0FC6]  ;/
$A4:8ED1 9E B0 0F    STZ $0FB0,x[$7E:0FB0]  ; $0FB0 = 0
$A4:8ED4 9E B2 0F    STZ $0FB2,x[$7E:0FB2]  ; $0FB2 = 0
$A4:8ED7 A9 00 08    LDA #$0800             ;\
$A4:8EDA 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} $0FAE = 800h
$A4:8EDD A9 10 00    LDA #$0010             ;\
$A4:8EE0 8D 84 0F    STA $0F84  [$7E:0F84]  ;} Crocomire Y radius = 10h
$A4:8EE3 7A          PLY
$A4:8EE4 6B          RTL
}


;;; $8EE5: Collapse Crocomire's bridge ;;;
{
$A4:8EE5 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8EE9             dx 61,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (61h, Bh)
$A4:8EED 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8EF1             dx 62,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (62h, Bh)
$A4:8EF5 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8EF9             dx 63,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (63h, Bh)
$A4:8EFD 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F01             dx 64,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (64h, Bh)
$A4:8F05 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F09             dx 65,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (65h, Bh)
$A4:8F0D 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F11             dx 66,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (66h, Bh)
$A4:8F15 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F19             dx 67,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (67h, Bh)
$A4:8F1D 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F21             dx 68,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (68h, Bh)
$A4:8F25 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F29             dx 69,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (69h, Bh)
$A4:8F2D 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:8F31             dx 6A,0B,B74F          ;} Spawn PLM to clear a block of Crocomire's bridge at (6Ah, Bh)
$A4:8F35 A9 00 06    LDA #$0600             ;\
$A4:8F38 85 12       STA $12    [$7E:0012]  ;} $12 = 600h (X position)
$A4:8F3A A9 B0 00    LDA #$00B0             ;\
$A4:8F3D 85 14       STA $14    [$7E:0014]  ;} $14 = B0h (Y position)
$A4:8F3F A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8F42 A0 09 E5    LDY #$E509             ;\
$A4:8F45 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8F49 A9 10 06    LDA #$0610             ;\
$A4:8F4C 85 12       STA $12    [$7E:0012]  ;} $12 = 610h (X position)
$A4:8F4E A9 C0 00    LDA #$00C0             ;\
$A4:8F51 85 14       STA $14    [$7E:0014]  ;} $14 = C0h (Y position)
$A4:8F53 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8F56 A0 09 E5    LDY #$E509             ;\
$A4:8F59 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8F5D A9 20 06    LDA #$0620             ;\
$A4:8F60 85 12       STA $12    [$7E:0012]  ;} $12 = 620h (X position)
$A4:8F62 A9 B0 00    LDA #$00B0             ;\
$A4:8F65 85 14       STA $14    [$7E:0014]  ;} $14 = B0h (Y position)
$A4:8F67 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8F6A A0 09 E5    LDY #$E509             ;\
$A4:8F6D 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8F71 A9 30 06    LDA #$0630             ;\
$A4:8F74 85 12       STA $12    [$7E:0012]  ;} $12 = 630h (X position)
$A4:8F76 A9 C0 00    LDA #$00C0             ;\
$A4:8F79 85 14       STA $14    [$7E:0014]  ;} $14 = C0h (Y position)
$A4:8F7B A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8F7E A0 09 E5    LDY #$E509             ;\
$A4:8F81 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8F85 A9 40 06    LDA #$0640             ;\
$A4:8F88 85 12       STA $12    [$7E:0012]  ;} $12 = 640h (X position)
$A4:8F8A A9 C0 00    LDA #$00C0             ;\
$A4:8F8D 85 14       STA $14    [$7E:0014]  ;} $14 = C0h (Y position)
$A4:8F8F A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8F92 A0 09 E5    LDY #$E509             ;\
$A4:8F95 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8F99 A9 50 06    LDA #$0650             ;\
$A4:8F9C 85 12       STA $12    [$7E:0012]  ;} $12 = 650h (X position)
$A4:8F9E A9 C0 00    LDA #$00C0             ;\
$A4:8FA1 85 14       STA $14    [$7E:0014]  ;} $14 = C0h (Y position)
$A4:8FA3 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8FA6 A0 09 E5    LDY #$E509             ;\
$A4:8FA9 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8FAD A9 60 06    LDA #$0660             ;\
$A4:8FB0 85 12       STA $12    [$7E:0012]  ;} $12 = 660h (X position)
$A4:8FB2 A9 C0 00    LDA #$00C0             ;\
$A4:8FB5 85 14       STA $14    [$7E:0014]  ;} $14 = C0h (Y position)
$A4:8FB7 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:8FBA A0 09 E5    LDY #$E509             ;\
$A4:8FBD 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:8FC1 60          RTS
}


;;; $8FC2: Unused. Move enemy down by [$14].[$12] ;;;
{
$A4:8FC2 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A4:8FC6 6B          RTL
}


;;; $8FC7..9098: Instructions ;;;
{
;;; $8FC7: Instruction - shake screen ;;;
{
$A4:8FC7 DA          PHX
$A4:8FC8 5A          PHY
$A4:8FC9 A9 04 00    LDA #$0004             ;\
$A4:8FCC 8D 3E 18    STA $183E  [$7E:183E]  ;} Earthquake type = BG1 only, 2 pixel displacement, vertical
$A4:8FCF A9 05 00    LDA #$0005             ;\
$A4:8FD2 8D 40 18    STA $1840  [$7E:1840]  ;} Earthquake timer = 5
$A4:8FD5 A9 76 00    LDA #$0076             ;\
$A4:8FD8 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 76h, sound library 2, max queued sounds allowed = 6 (quake)
$A4:8FDC 7A          PLY
$A4:8FDD FA          PLX
$A4:8FDE 6B          RTL
}


;;; $8FDF: Instruction - move left 4px ;;;
{
$A4:8FDF DA          PHX
$A4:8FE0 5A          PHY
$A4:8FE1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:8FE4 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:8FE7 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h = 0 (not damaged):
$A4:8FEA D0 0B       BNE $0B    [$8FF7]     ;/
$A4:8FEC 64 12       STZ $12    [$7E:0012]  ;\
$A4:8FEE A9 FC FF    LDA #$FFFC             ;|
$A4:8FF1 85 14       STA $14    [$7E:0014]  ;} Move enemy left by 4.0
$A4:8FF3 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/

$A4:8FF7 7A          PLY
$A4:8FF8 FA          PLX
$A4:8FF9 6B          RTL
}


;;; $8FFA: Instruction - move left 4px and spawn big dust cloud ;;;
{
$A4:8FFA 20 04 90    JSR $9004  [$A4:9004]  ; Spawn big dust cloud enemy projectile with random X offset
$A4:8FFD 80 E0       BRA $E0    [$8FDF]     ; Go to $8FDF
}


;;; $8FFF: Instruction - move left 4px and spawn big dust cloud ;;;
{
; Clone of $8FFA
$A4:8FFF 20 04 90    JSR $9004  [$A4:9004]
$A4:9002 80 DB       BRA $DB    [$8FDF]
}


;;; $9004: Spawn big dust cloud enemy projectile with random X offset ;;;
{
$A4:9004 DA          PHX
$A4:9005 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A4:9008 29 1F 00    AND #$001F             ;} A = [random number] % 20h
$A4:900B AE E5 05    LDX $05E5  [$7E:05E5]  ;\
$A4:900E E0 00 10    CPX #$1000             ;} If [random number] - 1000h & 8000h = 0:
$A4:9011 30 04       BMI $04    [$9017]     ;/
$A4:9013 49 FF FF    EOR #$FFFF             ;\
$A4:9016 1A          INC A                  ;} Negate A

$A4:9017 22 DA 9A A4 JSL $A49ADA[$A4:9ADA]  ; Spawn big dust cloud enemy projectile
$A4:901B FA          PLX
$A4:901C 60          RTS
}


;;; $901D: Instruction - move left 4px and spawn big dust cloud and handle spike wall collision ;;;
{
$A4:901D DA          PHX
$A4:901E 5A          PHY
$A4:901F AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9022 64 12       STZ $12    [$7E:0012]  ;\
$A4:9024 A9 FC FF    LDA #$FFFC             ;|
$A4:9027 85 14       STA $14    [$7E:0014]  ;} Move enemy left by 4.0
$A4:9029 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A4:902D B0 20       BCS $20    [$904F]     ; If collided with wall: go to BRANCH_HIT_WALL
$A4:902F A2 20 00    LDX #$0020             ; X = 20h
$A4:9032 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A4:9035 C9 00 08    CMP #$0800             ;} If [random number] >= 800h:
$A4:9038 30 03       BMI $03    [$903D]     ;/
$A4:903A A2 E0 FF    LDX #$FFE0             ; X = -20h

$A4:903D AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A4:9040 29 0F 00    AND #$000F             ;|
$A4:9043 86 12       STX $12    [$7E:0012]  ;} A = [X] + [random number] % 10h (X offset)
$A4:9045 18          CLC                    ;|
$A4:9046 65 12       ADC $12    [$7E:0012]  ;/
$A4:9048 22 DA 9A A4 JSL $A49ADA[$A4:9ADA]  ; Spawn big dust cloud enemy projectile
$A4:904C 7A          PLY
$A4:904D FA          PLX
$A4:904E 6B          RTL                    ; Return

; BRANCH_HIT_WALL
$A4:904F 7A          PLY
$A4:9050 A0 3C BF    LDY #$BF3C             ; Y = $BF3C (back off from spike wall)
$A4:9053 A9 0E 00    LDA #$000E             ;\
$A4:9056 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = Eh (back off from spike wall)
$A4:9059 FA          PLX
$A4:905A 6B          RTL
}


;;; $905B: Instruction - move right 4px if on-screen ;;;
{
$A4:905B DA          PHX
$A4:905C 5A          PHY
$A4:905D AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9060 64 12       STZ $12    [$7E:0012]  ;\
$A4:9062 A9 04 00    LDA #$0004             ;} $14.$12 = 4.0
$A4:9065 85 14       STA $14    [$7E:0014]  ;/
$A4:9067 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:906A 38          SEC                    ;|
$A4:906B ED 82 0F    SBC $0F82  [$7E:0F82]  ;|
$A4:906E E9 00 01    SBC #$0100             ;} If (Crocomire left boundary) < [layer 1 X position] + 100h:
$A4:9071 E5 14       SBC $14    [$7E:0014]  ;|
$A4:9073 CD 11 09    CMP $0911  [$7E:0911]  ;|
$A4:9076 10 04       BPL $04    [$907C]     ;/
$A4:9078 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]

$A4:907C 7A          PLY
$A4:907D FA          PLX
$A4:907E 6B          RTL
}


;;; $907F: Instruction - move right 4px ;;;
{
$A4:907F DA          PHX
$A4:9080 5A          PHY
$A4:9081 64 12       STZ $12    [$7E:0012]  ;\
$A4:9083 A9 04 00    LDA #$0004             ;} $14.$12 = 4.0
$A4:9086 85 14       STA $14    [$7E:0014]  ;/
$A4:9088 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$A4:908C 7A          PLY
$A4:908D FA          PLX
$A4:908E 6B          RTL
}


;;; $908F: Instruction - move right 4px if on-screen and spawn big dust cloud ;;;
{
$A4:908F 20 04 90    JSR $9004  [$A4:9004]  ; Spawn big dust cloud enemy projectile with random X offset
$A4:9092 80 C7       BRA $C7    [$905B]     ; Move right 4px if on-screen
}


;;; $9094: Instruction - move right 4px and spawn big dust cloud ;;;
{
$A4:9094 20 04 90    JSR $9004  [$A4:9004]  ; Spawn big dust cloud enemy projectile with random X offset
$A4:9097 80 E6       BRA $E6    [$907F]     ; Move right 4px
}
}


;;; $9099: Crocomire main AI - death sequence index 3Ch - hop 6 - sinking ;;;
{
$A4:9099 20 DF 90    JSR $90DF  [$A4:90DF]
$A4:909C 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
$A4:909F 20 C1 91    JSR $91C1  [$A4:91C1]  ; Sink Crocomire down
$A4:90A2 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A4:90A5 C9 3E 00    CMP #$003E             ;} If [Crocomire death sequence index] = 3Eh:
$A4:90A8 D0 34       BNE $34    [$90DE]     ;/
$A4:90AA A9 06 00    LDA #$0006             ;\
$A4:90AD 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 1 music track
$A4:90B1 A9 58 00    LDA #$0058             ;\
$A4:90B4 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Crocomire death sequence index = 58h
$A4:90B7 A9 D2 E1    LDA #$E1D2
$A4:90BA 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:90BD A9 01 01    LDA #$0101
$A4:90C0 8F 24 CD 7E STA $7ECD24[$7E:CD24]
$A4:90C4 9C F7 05    STZ $05F7  [$7E:05F7]
$A4:90C7 AD C6 0F    LDA $0FC6  [$7E:0FC6]
$A4:90CA 09 00 02    ORA #$0200
$A4:90CD 8D C6 0F    STA $0FC6  [$7E:0FC6]
$A4:90D0 22 D7 83 84 JSL $8483D7[$84:83D7]
$A4:90D4             dx 4E,03,B753
$A4:90D8 9C 41 09    STZ $0941  [$7E:0941]
$A4:90DB 9C 88 06    STZ $0688  [$7E:0688]

$A4:90DE 60          RTS
}


;;; $90DF:  ;;;
{
$A4:90DF AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A4:90E2 A0 7E BF    LDY #$BF7E
$A4:90E5 C9 18 01    CMP #$0118
$A4:90E8 10 13       BPL $13    [$90FD]
$A4:90EA A0 86 BF    LDY #$BF86
$A4:90ED C9 08 01    CMP #$0108
$A4:90F0 10 0B       BPL $0B    [$90FD]
$A4:90F2 A0 8C BF    LDY #$BF8C
$A4:90F5 C9 F8 00    CMP #$00F8
$A4:90F8 10 03       BPL $03    [$90FD]
$A4:90FA A0 92 BF    LDY #$BF92

$A4:90FD 98          TYA
$A4:90FE 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:9101 A9 01 00    LDA #$0001
$A4:9104 8D 94 0F    STA $0F94  [$7E:0F94]
$A4:9107 60          RTS
}


;;; $9108: Crocomire main AI - death sequence index 1Eh/24h/2Ah - hop 3/4/5 - sinking ;;;
{
$A4:9108 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
$A4:910B AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A4:910E A0 64 BF    LDY #$BF64
$A4:9111 C9 18 01    CMP #$0118
$A4:9114 10 13       BPL $13    [$9129]
$A4:9116 A0 6C BF    LDY #$BF6C
$A4:9119 C9 08 01    CMP #$0108
$A4:911C 10 0B       BPL $0B    [$9129]
$A4:911E A0 72 BF    LDY #$BF72
$A4:9121 C9 F8 00    CMP #$00F8
$A4:9124 10 03       BPL $03    [$9129]
$A4:9126 A0 78 BF    LDY #$BF78

$A4:9129 98          TYA
$A4:912A 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:912D A9 01 00    LDA #$0001
$A4:9130 8D 94 0F    STA $0F94  [$7E:0F94]
$A4:9133 4C C1 91    JMP $91C1  [$A4:91C1]  ; Go to sink Crocomire down
}


;;; $9136: Crocomire main AI - death sequence index 2 - falling ;;;
{
$A4:9136 AF 16 90 7E LDA $7E9016[$7E:9016]  ;\
$A4:913A C9 16 00    CMP #$0016             ;} If [Crocomire death sequence crumbling bridge index] >= 16h:
$A4:913D 30 03       BMI $03    [$9142]     ;/
$A4:913F 4C BA 91    JMP $91BA  [$A4:91BA]  ; Go to hop 1/2 - sinking

$A4:9142 AA          TAX                    ; X = [Crocomire death sequence crumbling bridge index]
$A4:9143 1A          INC A                  ;\
$A4:9144 1A          INC A                  ;} Crocomire death sequence crumbling bridge index += 2
$A4:9145 8F 16 90 7E STA $7E9016[$7E:9016]  ;/
$A4:9149 BD 56 91    LDA $9156,x[$A4:9156]  ; A = [$9156 + [X]] (X position)
$A4:914C A0 9D 8F    LDY #$8F9D             ;\
$A4:914F 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Crocomire bridge crumbling enemy projectile
$A4:9153 4C BA 91    JMP $91BA  [$A4:91BA]  ; Go to hop 1/2 - sinking

; Crocomire bridge crumbling enemy projectile X positions
; Note that these are all on the screen to the right of the one Crocomire dies on,
; and they use the normal floor graphics, not the bridge graphics
; I would guess that this is a leftover effect from a previous room design
$A4:9156             dw 0780, 0730, 0790, 0740, 07B0, 0760, 07A0, 0770, 0710, 0750, 0720
}


;;; $916C: Handle Crocomire acid damage smoke ;;;
{
$A4:916C AF 18 90 7E LDA $7E9018[$7E:9018]  ;\
$A4:9170 3A          DEC A                  ;} Decrement Crocomire acid damage smoke timer
$A4:9171 8F 18 90 7E STA $7E9018[$7E:9018]  ;/
$A4:9175 D0 42       BNE $42    [$91B9]     ; If [Crocomire acid damage smoke timer] != 0: return
$A4:9177 A9 06 00    LDA #$0006             ;\
$A4:917A 8F 18 90 7E STA $7E9018[$7E:9018]  ;} Crocomire acid damage smoke timer = 6
$A4:917E AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A4:9181 29 3F 00    AND #$003F             ;} X = [random number] % 40h
$A4:9184 AA          TAX                    ;/
$A4:9185 AD E5 05    LDA $05E5  [$7E:05E5]  ; >_<;
$A4:9188 89 02 00    BIT #$0002             ;\
$A4:918B D0 05       BNE $05    [$9192]     ;} If [X] / 2 % 2 = 0:
$A4:918D 8A          TXA                    ;\
$A4:918E 49 FF FF    EOR #$FFFF             ;} X = -1 - [X]
$A4:9191 AA          TAX                    ;/

$A4:9192 8A          TXA                    ;\
$A4:9193 18          CLC                    ;|
$A4:9194 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} $12 = [Crocomire X position] + [X]
$A4:9197 85 12       STA $12    [$7E:0012]  ;/
$A4:9199 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A4:919C 29 00 1F    AND #$1F00             ;|
$A4:919F EB          XBA                    ;|
$A4:91A0 85 14       STA $14    [$7E:0014]  ;|
$A4:91A2 AD 62 19    LDA $1962  [$7E:1962]  ;|
$A4:91A5 18          CLC                    ;} $14 = [lava/acid Y position] + 10h - [random number high] % 20h
$A4:91A6 69 10 00    ADC #$0010             ;|
$A4:91A9 38          SEC                    ;|
$A4:91AA E5 14       SBC $14    [$7E:0014]  ;|
$A4:91AC 85 14       STA $14    [$7E:0014]  ;/
$A4:91AE A9 15 00    LDA #$0015             ;\
$A4:91B1 85 16       STA $16    [$7E:0016]  ;|
$A4:91B3 64 18       STZ $18    [$7E:0018]  ;} Create sprite object 15h (big dust cloud) at position ([$12], [$14])
$A4:91B5 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

$A4:91B9 60          RTS
}


;;; $91BA: Crocomire main AI - death sequence index 8/Eh - hop 1/2 - sinking ;;;
{
$A4:91BA 22 1F 8D A4 JSL $A48D1F[$A4:8D1F]  ; Handle playing Crocomire acid damage sound effect
$A4:91BE 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
}


;;; $91C1: Sink Crocomire down ;;;
{
; The tilemap row offset calculated at $91E9 is 20h px into the vertically wrapped section of BG2 (recall that BG2 size = 64x32),
; i.e. where the bottom of Crocomire would start to appear below the HUD
$A4:91C1 20 DF 93    JSR $93DF  [$A4:93DF]  ; Reset Crocomire BG2 Y scroll HDMA data table
$A4:91C4 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:91C7 29 FF F7    AND #$F7FF             ;} Crocomire fight flags &= ~800h (not damaged)
$A4:91CA 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:91CD AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:91D0 22 5B 8B A4 JSL $A48B5B[$A4:8B5B]  ; Update Crocomire BG2 scroll
$A4:91D4 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A4:91D7 C9 18 01    CMP #$0118             ;} If [Crocomire Y position] >= 118h:
$A4:91DA 30 0D       BMI $0D    [$91E9]     ;/
$A4:91DC FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:91DF FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:91E2 A9 30 00    LDA #$0030             ;\
$A4:91E5 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Crocomire rest timer = 30h
$A4:91E8 60          RTS                    ; Return

$A4:91E9 A5 B7       LDA $B7    [$7E:00B7]  ;\
$A4:91EB 49 FF FF    EOR #$FFFF             ;|
$A4:91EE 1A          INC A                  ;|
$A4:91EF 85 12       STA $12    [$7E:0012]  ;|
$A4:91F1 A9 20 01    LDA #$0120             ;|
$A4:91F4 38          SEC                    ;|
$A4:91F5 E5 12       SBC $12    [$7E:0012]  ;} X = (120h + [BG2 Y scroll]) / 8 * 40h (tilemap row offset)
$A4:91F7 29 F8 FF    AND #$FFF8             ;|
$A4:91FA 0A          ASL A                  ;|
$A4:91FB 0A          ASL A                  ;|
$A4:91FC 0A          ASL A                  ;|
$A4:91FD AA          TAX                    ;/
$A4:91FE A9 20 00    LDA #$0020             ;\
$A4:9201 85 12       STA $12    [$7E:0012]  ;|
$A4:9203 A9 38 03    LDA #$0338             ;|
                                            ;|
$A4:9206 9F 00 20 7E STA $7E2000,x[$7E:2740];} Write 40h bytes of 338h to $7E:2000 + [X]
$A4:920A E8          INX                    ;|
$A4:920B E8          INX                    ;|
$A4:920C C6 12       DEC $12    [$7E:0012]  ;|
$A4:920E D0 F6       BNE $F6    [$9206]     ;/
$A4:9210 A9 01 00    LDA #$0001             ;\
$A4:9213 8D 1E 0E    STA $0E1E  [$7E:0E1E]  ;} Request enemy BG2 tilemap VRAM transfer
$A4:9216 AD 88 0F    LDA $0F88  [$7E:0F88]  ;\
$A4:9219 29 FF 7F    AND #$7FFF             ;} Clear enemy graphic updated flag
$A4:921C 8D 88 0F    STA $0F88  [$7E:0F88]  ;/
$A4:921F AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9222 E2 20       SEP #$20
$A4:9224 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A4:9227 18          CLC                    ;|
$A4:9228 69 80       ADC #$80               ;|
$A4:922A 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Crocomire Y acceleration += 3.80h
$A4:922D BD AF 0F    LDA $0FAF,x[$7E:0FAF]  ;|
$A4:9230 69 03       ADC #$03               ;/
$A4:9232 C9 30       CMP #$30               ;\
$A4:9234 30 02       BMI $02    [$9238]     ;|
$A4:9236 A9 30       LDA #$30               ;} Crocomire Y acceleration = min([Crocomire Y acceleration], 30h)
                                            ;|
$A4:9238 9D AF 0F    STA $0FAF,x[$7E:0FAF]  ;/
$A4:923B 18          CLC                    ;\
$A4:923C 7D B0 0F    ADC $0FB0,x[$7E:0FB0]  ;|
$A4:923F 9D B0 0F    STA $0FB0,x[$7E:0FB0]  ;} Crocomire Y velocity += [Crocomire Y acceleration] / 100h
$A4:9242 BD B1 0F    LDA $0FB1,x[$7E:0FB1]  ;|
$A4:9245 69 00       ADC #$00               ;/
$A4:9247 C9 03       CMP #$03               ;\
$A4:9249 30 02       BMI $02    [$924D]     ;|
$A4:924B A9 03       LDA #$03               ;} Crocomire Y velocity = min([Crocomire Y velocity], 3)
                                            ;|
$A4:924D 9D B1 0F    STA $0FB1,x[$7E:0FB1]  ;/
$A4:9250 BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;\
$A4:9253 18          CLC                    ;|
$A4:9254 7D B3 0F    ADC $0FB3,x[$7E:0FB3]  ;|
$A4:9257 9D B3 0F    STA $0FB3,x[$7E:0FB3]  ;|
$A4:925A BD B1 0F    LDA $0FB1,x[$7E:0FB1]  ;|
$A4:925D 7D 7E 0F    ADC $0F7E,x[$7E:0F7E]  ;} Crocomire Y position += [Crocomire Y velocity] (with $0FB3 as Y subposition...)
$A4:9260 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;|
$A4:9263 BD 7F 0F    LDA $0F7F,x[$7E:0F7F]  ;|
$A4:9266 69 00       ADC #$00               ;|
$A4:9268 9D 7F 0F    STA $0F7F,x[$7E:0F7F]  ;/
$A4:926B C2 20       REP #$20
$A4:926D 60          RTS
}


;;; $926E: Crocomire main AI - death sequence index 34h - hop 6 - rising ;;;
{
$A4:926E AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9271 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A4:9274 A0 7E BF    LDY #$BF7E
$A4:9277 C9 18 01    CMP #$0118
$A4:927A 10 13       BPL $13    [$928F]
$A4:927C A0 86 BF    LDY #$BF86
$A4:927F C9 08 01    CMP #$0108
$A4:9282 10 0B       BPL $0B    [$928F]
$A4:9284 A0 8C BF    LDY #$BF8C
$A4:9287 C9 F8 00    CMP #$00F8
$A4:928A 10 03       BPL $03    [$928F]
$A4:928C A0 92 BF    LDY #$BF92

$A4:928F 98          TYA
$A4:9290 9D 92 0F    STA $0F92,x[$7E:0F92]
$A4:9293 A9 01 00    LDA #$0001
$A4:9296 9D 94 0F    STA $0F94,x[$7E:0F94]
$A4:9299 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
$A4:929C 80 3A       BRA $3A    [$92D8]     ; Go to rise Crocomire up
}


;;; $929E: Crocomire main AI - death sequence index 16h/22h/28h - hop 3/4/5 - rising ;;;
{
$A4:929E 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
$A4:92A1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:92A4 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A4:92A7 A0 64 BF    LDY #$BF64
$A4:92AA C9 18 01    CMP #$0118
$A4:92AD 10 13       BPL $13    [$92C2]
$A4:92AF A0 6C BF    LDY #$BF6C
$A4:92B2 C9 08 01    CMP #$0108
$A4:92B5 10 0B       BPL $0B    [$92C2]
$A4:92B7 A0 72 BF    LDY #$BF72
$A4:92BA C9 F8 00    CMP #$00F8
$A4:92BD 10 03       BPL $03    [$92C2]
$A4:92BF A0 78 BF    LDY #$BF78

$A4:92C2 98          TYA
$A4:92C3 9D 92 0F    STA $0F92,x[$7E:0F92]
$A4:92C6 A9 01 00    LDA #$0001
$A4:92C9 9D 94 0F    STA $0F94,x[$7E:0F94]
$A4:92CC 80 0A       BRA $0A    [$92D8]     ; Go to rise Crocomire up
}


;;; $92CE: Crocomire main AI - death sequence index 6/Ch - hop 1/2 - rising ;;;
{
$A4:92CE 22 1F 8D A4 JSL $A48D1F[$A4:8D1F]  ; Handle playing Crocomire acid damage sound effect
$A4:92D2 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
$A4:92D5 AE 54 0E    LDX $0E54  [$7E:0E54]
}


;;; $92D8: Rise Crocomire up ;;;
{
$A4:92D8 20 DF 93    JSR $93DF  [$A4:93DF]  ; Reset Crocomire BG2 Y scroll HDMA data table
$A4:92DB AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:92DE BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A4:92E1 C9 DA 00    CMP #$00DA             ;} If [Crocomire Y position] < DAh:
$A4:92E4 10 0A       BPL $0A    [$92F0]     ;/
$A4:92E6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:92E9 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:92EC FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:92EF 60          RTS                    ; Return

$A4:92F0 22 5B 8B A4 JSL $A48B5B[$A4:8B5B]  ; Update Crocomire BG2 scroll
$A4:92F4 AD AE 0F    LDA $0FAE  [$7E:0FAE]  ;\
$A4:92F7 18          CLC                    ;|
$A4:92F8 69 00 01    ADC #$0100             ;|
$A4:92FB C9 00 1F    CMP #$1F00             ;|
$A4:92FE 30 03       BMI $03    [$9303]     ;} Crocomire Y acceleration = min(1F.00h, [Crocomire Y acceleration] + 1.00h)
$A4:9300 A9 00 1F    LDA #$1F00             ;|
                                            ;|
$A4:9303 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;/
$A4:9306 E2 20       SEP #$20
$A4:9308 AD B0 0F    LDA $0FB0  [$7E:0FB0]  ;\
$A4:930B 38          SEC                    ;|
$A4:930C ED AF 0F    SBC $0FAF  [$7E:0FAF]  ;|
$A4:930F 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} Crocomire Y velocity -= [Crocomire Y acceleration] / 100h
$A4:9312 AD B1 0F    LDA $0FB1  [$7E:0FB1]  ;|
$A4:9315 E9 00       SBC #$00               ;/
$A4:9317 10 07       BPL $07    [$9320]     ; If [Crocomire Y velocity] < 0:
$A4:9319 A9 FF       LDA #$FF               ;\
$A4:931B 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} Crocomire Y velocity = 0.FFh
$A4:931E A9 00       LDA #$00               ;/

$A4:9320 8D B1 0F    STA $0FB1  [$7E:0FB1]
$A4:9323 AD B3 0F    LDA $0FB3  [$7E:0FB3]  ;\
$A4:9326 38          SEC                    ;|
$A4:9327 ED B0 0F    SBC $0FB0  [$7E:0FB0]  ;|
$A4:932A 8D B3 0F    STA $0FB3  [$7E:0FB3]  ;|
$A4:932D AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$A4:9330 ED B1 0F    SBC $0FB1  [$7E:0FB1]  ;} Crocomire Y position -= [Crocomire Y velocity] (with $0FB3 as Y subposition)
$A4:9333 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;|
$A4:9336 AD 7F 0F    LDA $0F7F  [$7E:0F7F]  ;|
$A4:9339 E9 00       SBC #$00               ;|
$A4:933B 8D 7F 0F    STA $0F7F  [$7E:0F7F]  ;/
$A4:933E C2 20       REP #$20
$A4:9340 60          RTS
}


;;; $9341: Crocomire main AI - death sequence index 10h ;;;
{
$A4:9341 A9 30 00    LDA #$0030             ;\
$A4:9344 8D 8C 06    STA $068C  [$7E:068C]  ;} $068C = 30h
$A4:9347 8D 88 06    STA $0688  [$7E:0688]  ; $0688 = 30h
$A4:934A AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:934D FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:9350 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:9353 A9 64 BF    LDA #$BF64             ;\
$A4:9356 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Crocomire instruction list pointer = $BF64
$A4:9359 A9 01 00    LDA #$0001             ;\
$A4:935C 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Crocomire instruction timer = 1
$A4:935F A9 01 00    LDA #$0001             ;\
$A4:9362 8D 1E 0E    STA $0E1E  [$7E:0E1E]  ;} Request enemy BG2 tilemap VRAM transfer
$A4:9365 A9 98 BF    LDA #$BF98             ;\
$A4:9368 9D D2 0F    STA $0FD2,x[$7E:0FD2]  ;} Crocomire's tongue instruction list pointer = $BF98
$A4:936B A9 01 00    LDA #$0001             ;\
$A4:936E 9D D4 0F    STA $0FD4,x[$7E:0FD4]  ;} Crocomire's tongue instruction timer = 1
$A4:9371 BD C6 0F    LDA $0FC6,x[$7E:0FC6]  ;\
$A4:9374 09 00 2C    ORA #$2C00             ;|
$A4:9377 29 FF FE    AND #$FEFF             ;} Set Crocomire's tongue to process instructions, process whilst off-screen, as intangible, and visible
$A4:937A 9D C6 0F    STA $0FC6,x[$7E:0FC6]  ;/
$A4:937D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A4:9380 9D BA 0F    STA $0FBA,x[$7E:0FBA]  ;} Crocomire's tongue X position = [Crocomire X position]
$A4:9383 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A4:9386 18          CLC                    ;|
$A4:9387 69 10 00    ADC #$0010             ;} Crocomire's tongue Y position = [Crocomire Y position] + 10h
$A4:938A 9D BE 0F    STA $0FBE,x[$7E:0FBE]  ;/
$A4:938D A2 00 00    LDX #$0000             ;\
$A4:9390 A9 38 03    LDA #$0338             ;|
                                            ;|
$A4:9393 9F 00 20 7E STA $7E2000,x[$7E:2000];|
$A4:9397 9F 02 20 7E STA $7E2002,x[$7E:2002];|
$A4:939B E8          INX                    ;} $7E:2000..23FF = 338h
$A4:939C E8          INX                    ;|
$A4:939D E8          INX                    ;|
$A4:939E E8          INX                    ;|
$A4:939F E0 00 04    CPX #$0400             ;|
$A4:93A2 30 EF       BMI $EF    [$9393]     ;/
$A4:93A4 A2 00 00    LDX #$0000             ;\
                                            ;|
$A4:93A7 BF 79 9C A4 LDA $A49C79,x[$A4:9C79];|
$A4:93AB C9 FF FF    CMP #$FFFF             ;|
$A4:93AE F0 08       BEQ $08    [$93B8]     ;} $7E:2040..223F = [$A4:9C79..9E78]
$A4:93B0 9F 40 20 7E STA $7E2040,x[$7E:2040];|
$A4:93B4 E8          INX                    ;|
$A4:93B5 E8          INX                    ;|
$A4:93B6 80 EF       BRA $EF    [$93A7]     ;/

$A4:93B8 8A          TXA                    ;\
$A4:93B9 18          CLC                    ;|
$A4:93BA 69 00 04    ADC #$0400             ;} X = 600h
$A4:93BD AA          TAX                    ;/
}


;;; $93BE: Write Crocomire BG2 tilemap ;;;
{
;; Parameters:
;;     X: BG2 tilemap size. 600h
$A4:93BE 9B          TXY                    ;\
$A4:93BF AE 30 03    LDX $0330  [$7E:0330]  ;|
$A4:93C2 94 D0       STY $D0,x  [$7E:00D0]  ;|
$A4:93C4 A9 00 20    LDA #$2000             ;|
$A4:93C7 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A4:93C9 A9 7E 00    LDA #$007E             ;|
$A4:93CC 95 D4       STA $D4,x  [$7E:00D4]  ;|
$A4:93CE A5 59       LDA $59    [$7E:0059]  ;} Queue transfer of [X] bytes from $7E:2000 to VRAM BG2 tilemap
$A4:93D0 29 FC 00    AND #$00FC             ;|
$A4:93D3 EB          XBA                    ;|
$A4:93D4 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A4:93D6 8A          TXA                    ;|
$A4:93D7 18          CLC                    ;|
$A4:93D8 69 07 00    ADC #$0007             ;|
$A4:93DB 8D 30 03    STA $0330  [$7E:0330]  ;/
$A4:93DE 60          RTS
}


;;; $93DF: Reset Crocomire BG2 Y scroll HDMA data table ;;;
{
$A4:93DF A5 B7       LDA $B7    [$7E:00B7]  ;\
$A4:93E1 A2 FE 01    LDX #$01FE             ;|
                                            ;|
$A4:93E4 9F F0 CA 7E STA $7ECAF0,x[$7E:CCEE];} Crocomire BG2 Y scroll HDMA data table = [BG2 Y scroll]
$A4:93E8 CA          DEX                    ;|
$A4:93E9 CA          DEX                    ;|
$A4:93EA 10 F8       BPL $F8    [$93E4]     ;/
$A4:93EC 60          RTS
}


;;; $93ED: Crocomire main AI - death sequence index 2Ch ;;;
{
$A4:93ED 20 DF 93    JSR $93DF  [$A4:93DF]  ; Reset Crocomire BG2 Y scroll HDMA data table
$A4:93F0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:93F3 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:93F6 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:93F9 A9 01 00    LDA #$0001             ;\
$A4:93FC 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Crocomire instruction timer = 1
$A4:93FF A9 30 00    LDA #$0030             ;\
$A4:9402 8D 8C 06    STA $068C  [$7E:068C]  ;} $068C = 30h
$A4:9405 8D 88 06    STA $0688  [$7E:0688]  ; $0688 = 30h
$A4:9408 A9 7E BF    LDA #$BF7E             ;\
$A4:940B 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Crocomire instruction list pointer = $BF7E
$A4:940E A2 00 00    LDX #$0000             ;\
$A4:9411 A9 38 03    LDA #$0338             ;|
                                            ;|
$A4:9414 9F 00 20 7E STA $7E2000,x[$7E:2000];|
$A4:9418 E8          INX                    ;} $7E:2000..27FF = 338h
$A4:9419 E8          INX                    ;|
$A4:941A E0 00 08    CPX #$0800             ;|
$A4:941D 30 F5       BMI $F5    [$9414]     ;/
$A4:941F A2 00 00    LDX #$0000             ;\
                                            ;|
$A4:9422 BF 7B 9E A4 LDA $A49E7B,x[$A4:9E7B];|
$A4:9426 C9 FF FF    CMP #$FFFF             ;|
$A4:9429 F0 08       BEQ $08    [$9433]     ;} $7E:2040..223F = [$A4:9E7B..A07A]
$A4:942B 9F 40 20 7E STA $7E2040,x[$7E:2040];|
$A4:942F E8          INX                    ;|
$A4:9430 E8          INX                    ;|
$A4:9431 80 EF       BRA $EF    [$9422]     ;/
                                            
$A4:9433 8A          TXA                    ;\
$A4:9434 18          CLC                    ;|
$A4:9435 69 00 04    ADC #$0400             ;} X = 600h
$A4:9438 AA          TAX                    ;/
$A4:9439 4C BE 93    JMP $93BE  [$A4:93BE]  ; Go to write Crocomire BG2 tilemap
}


;;; $943C: RTL ;;;
{
$A4:943C 6B          RTL
}


;;; $943D: Crocomire main AI - death sequence index 12h/2Eh ;;;
{
$A4:943D C2 30       REP #$30
$A4:943F 8B          PHB
$A4:9440 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9443 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:9446 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:9449 A9 00 01    LDA #$0100             ;\
$A4:944C 8D 92 06    STA $0692  [$7E:0692]  ;} $0692 = 100h
$A4:944F 9C 90 06    STZ $0690  [$7E:0690]  ; $0690 = 0
$A4:9452 AE 9A 06    LDX $069A  [$7E:069A]  ; X = [$069A]
$A4:9455 BD C5 9B    LDA $9BC5,x[$A4:9BC5]  ;\
$A4:9458 8D 98 06    STA $0698  [$7E:0698]  ;} $0698 = 58h
$A4:945B 8D 94 06    STA $0694  [$7E:0694]  ; $0694 = 58h
$A4:945E BD C7 9B    LDA $9BC7,x[$A4:9BC7]  ;\
$A4:9461 8D 96 06    STA $0696  [$7E:0696]  ;} $0696 = 30h
$A4:9464 BD C9 9B    LDA $9BC9,x[$A4:9BC9]  ;\
$A4:9467 8D 8E 06    STA $068E  [$7E:068E]  ;} $068E = 200h
$A4:946A 64 00       STZ $00    [$7E:0000]  ;\
$A4:946C BD CB 9B    LDA $9BCB,x[$A4:9BCB]  ;} $00 = $A7:0000
$A4:946F 85 02       STA $02    [$7E:0002]  ;/
$A4:9471 8A          TXA                    ;\
$A4:9472 18          CLC                    ;|
$A4:9473 69 08 00    ADC #$0008             ;} X += 8
$A4:9476 AA          TAX                    ;/

; LOOP
$A4:9477 BC C5 9B    LDY $9BC5,x[$A4:9BCD]  ;\
$A4:947A C0 FF FF    CPY #$FFFF             ;} If [$9BC5 + [X]] = FFFFh: go to BRANCH_DONE
$A4:947D F0 1F       BEQ $1F    [$949E]     ;/
$A4:947F DA          PHX                    ;\
$A4:9480 BD C7 9B    LDA $9BC7,x[$A4:9BCF]  ;|
$A4:9483 AA          TAX                    ;|
$A4:9484 AD 8E 06    LDA $068E  [$7E:068E]  ;|
$A4:9487 85 12       STA $12    [$7E:0012]  ;|
                                            ;|
$A4:9489 B7 00       LDA [$00],y[$A4:A07D]  ;|
$A4:948B 9F 00 00 7E STA $7E0000,x[$7E:4000];} Copy 400h bytes from $A7:0000 + [$9BC5 + [X]] to $7E:4000 + [X] / 4 * 200h
$A4:948F E8          INX                    ;|
$A4:9490 E8          INX                    ;|
$A4:9491 C8          INY                    ;|
$A4:9492 C8          INY                    ;|
$A4:9493 C6 12       DEC $12    [$7E:0012]  ;|
$A4:9495 10 F2       BPL $F2    [$9489]     ;|
$A4:9497 FA          PLX                    ;/
$A4:9498 E8          INX                    ;\
$A4:9499 E8          INX                    ;|
$A4:949A E8          INX                    ;} X += 4
$A4:949B E8          INX                    ;/
$A4:949C 80 D9       BRA $D9    [$9477]     ; Go to LOOP

; BRANCH_DONE
$A4:949E E8          INX                    ;\
$A4:949F E8          INX                    ;} $069A = [X] + 2
$A4:94A0 8E 9A 06    STX $069A  [$7E:069A]  ;/
$A4:94A3 8E 8A 06    STX $068A  [$7E:068A]  ; $068A = [$069A]
$A4:94A6 A2 80 00    LDX #$0080             ;\ <-- should be 7Eh?
                                            ;|
$A4:94A9 9E 9C 06    STZ $069C,x[$7E:071C]  ;|
$A4:94AC CA          DEX                    ;} $069C..071D = 0
$A4:94AD CA          DEX                    ;|
$A4:94AE 10 F9       BPL $F9    [$94A9]     ;/
$A4:94B0 AB          PLB
$A4:94B1 60          RTS
}


;;; $94B2:  ;;;
{
$A4:94B2 20 B6 94    JSR $94B6  [$A4:94B6]
$A4:94B5 60          RTS
}


;;; $94B6: Crocomire main AI - death sequence index 14h/30h ;;;
{
$A4:94B6 AE 8A 06    LDX $068A  [$7E:068A]  ; X = [$068A]
$A4:94B9 AC 30 03    LDY $0330  [$7E:0330]  ; Y = [VRAM write table stack pointer]
$A4:94BC BD C5 9B    LDA $9BC5,x[$A4:9BE7]  ;\
$A4:94BF C9 FF FF    CMP #$FFFF             ;} If [$9BC5 + [X]] != FFFFh:
$A4:94C2 F0 27       BEQ $27    [$94EB]     ;/
$A4:94C4 99 D0 00    STA $00D0,y[$7E:00D0]  ;\
$A4:94C7 BD CB 9B    LDA $9BCB,x[$A4:9BED]  ;|
$A4:94CA 99 D2 00    STA $00D2,y[$7E:00D2]  ;|
$A4:94CD BD C9 9B    LDA $9BC9,x[$A4:9BEB]  ;} Queue transfer of 160h bytes from $7E:0000 + [$9BC5 + [X] + 6] to VRAM [$9BC5 + [X] + 2]
$A4:94D0 99 D4 00    STA $00D4,y[$7E:00D4]  ;|
$A4:94D3 BD C7 9B    LDA $9BC7,x[$A4:9BE9]  ;|
$A4:94D6 99 D5 00    STA $00D5,y[$7E:00D5]  ;/
$A4:94D9 98          TYA                    ;\
$A4:94DA 18          CLC                    ;|
$A4:94DB 69 07 00    ADC #$0007             ;} Y += 7
$A4:94DE A8          TAY                    ;/
$A4:94DF 8A          TXA                    ;\
$A4:94E0 18          CLC                    ;|
$A4:94E1 69 08 00    ADC #$0008             ;} $068A += 8
$A4:94E4 8D 8A 06    STA $068A  [$7E:068A]  ;/
$A4:94E7 8C 30 03    STY $0330  [$7E:0330]  ; VRAM write table stack pointer = [Y]
$A4:94EA 60          RTS                    ; Return

$A4:94EB 8C 30 03    STY $0330  [$7E:0330]
$A4:94EE AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:94F1 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:94F4 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:94F7 9C 8A 06    STZ $068A  [$7E:068A]  ; $068A = 0
$A4:94FA 60          RTS
}


;;; $94FB: Crocomire main AI - death sequence index 18h ;;;
{
$A4:94FB C2 30       REP #$30
$A4:94FD A9 77 00    LDA #$0077             ;\
$A4:9500 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 77h, sound library 2, max queued sounds allowed = 6 (Crocomire melting cry)
$A4:9504 80 09       BRA $09    [$950F]
}


;;; $9506: Crocomire main AI - death sequence index 36h ;;;
{
$A4:9506 C2 30       REP #$30
$A4:9508 A9 2D 00    LDA #$002D             ;\
$A4:950B 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Dh, sound library 2, max queued sounds allowed = 6 (Crocomire dying cry)
}


;;; $950F:  ;;;
{
$A4:950F AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A4:9512 38          SEC                    ;|
$A4:9513 E9 48 00    SBC #$0048             ;} X = ([Crocomire's tongue Y position] - 48h) * 2
$A4:9516 0A          ASL A                  ;|
$A4:9517 AA          TAX                    ;/
$A4:9518 A5 B7       LDA $B7    [$7E:00B7]

; LOOP
$A4:951A 9F F0 CA 7E STA $7ECAF0,x[$7E:CC18]; $7E:CAF0 + [X] = [BG2 Y scroll]
$A4:951E CA          DEX                    ;\
$A4:951F CA          DEX                    ;} X -= 2
$A4:9520 10 F8       BPL $F8    [$951A]     ; If [X] >= 0: go to LOOP
$A4:9522 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9525 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:9528 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:952B AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:952E 8D 2E 10    STA $102E  [$7E:102E]  ;} $102E (!) = [Crocomire X position]
$A4:9531 08          PHP
$A4:9532 A9 FF 00    LDA #$00FF             ;\
$A4:9535 8F E0 CA 7E STA $7ECAE0[$7E:CAE0]  ;|
$A4:9539 A9 F0 CA    LDA #$CAF0             ;|
$A4:953C 8F E1 CA 7E STA $7ECAE1[$7E:CAE1]  ;|
$A4:9540 A9 E1 00    LDA #$00E1             ;|
$A4:9543 8F E3 CA 7E STA $7ECAE3[$7E:CAE3]  ;} $7E:CAE0..E7 = FFh,$CAF0, E1h,$CBEE, 0,0
$A4:9547 A9 EE CB    LDA #$CBEE             ;|
$A4:954A 8F E4 CA 7E STA $7ECAE4[$7E:CAE4]  ;|
$A4:954E A9 00 00    LDA #$0000             ;|
$A4:9551 8F E6 CA 7E STA $7ECAE6[$7E:CAE6]  ;/
$A4:9555 22 35 84 88 JSL $888435[$88:8435]  ;\
$A4:9559             dx 42, 10, 9563        ;} Spawn indirect HDMA object for BG2 Y scroll with instruction list $9563
$A4:955D 8F 3E 78 7E STA $7E783E[$7E:783E]  ; $7E:783E = [A] (HDMA object index)
$A4:9561 28          PLP
$A4:9562 60          RTS
}


;;; $9563: HDMA object instruction list ;;;
{
$A4:9563             dx 8655,7E,    ; HDMA table bank = $7E
                        866A,7E,    ; Indirect HDMA data bank = $7E
                        8570,A4943C ; Pre-instruction = RTL
$A4:956E             dx 7777,CAE0,
                        85EC,956E   ; Go to $956E
}


;;; $9576: Crocomire main AI - death sequence index 32h ;;;
{
$A4:9576 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9579 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:957C FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:957F 60          RTS
}


;;; $9580: Crocomire main AI - death sequence index 1Ah/38h - hop 3/6 - melting ;;;
{
$A4:9580 C2 30       REP #$30
$A4:9582 20 6C 91    JSR $916C  [$A4:916C]  ; Handle Crocomire acid damage smoke
$A4:9585 AE 2E 10    LDX $102E  [$7E:102E]
$A4:9588 CE EE 0F    DEC $0FEE  [$7E:0FEE]
$A4:958B AD EE 0F    LDA $0FEE  [$7E:0FEE]
$A4:958E 29 02 00    AND #$0002
$A4:9591 F0 06       BEQ $06    [$9599]
$A4:9593 8A          TXA
$A4:9594 18          CLC
$A4:9595 69 04 00    ADC #$0004
$A4:9598 AA          TAX

$A4:9599 8E 7A 0F    STX $0F7A  [$7E:0F7A]
$A4:959C 22 C8 96 A4 JSL $A496C8[$A4:96C8]
$A4:95A0 C9 00 00    CMP #$0000
$A4:95A3 D0 2D       BNE $2D    [$95D2]

$A4:95A5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:95A8 FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;\
$A4:95AB FE A8 0F    INC $0FA8,x[$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:95AE AE 9A 06    LDX $069A  [$7E:069A]

$A4:95B1 BD C5 9B    LDA $9BC5,x[$A4:9BE7]
$A4:95B4 C9 FF FF    CMP #$FFFF
$A4:95B7 F0 08       BEQ $08    [$95C1]
$A4:95B9 8A          TXA
$A4:95BA 18          CLC
$A4:95BB 69 08 00    ADC #$0008
$A4:95BE AA          TAX
$A4:95BF 80 F0       BRA $F0    [$95B1]

$A4:95C1 E8          INX
$A4:95C2 E8          INX
$A4:95C3 8E 9A 06    STX $069A  [$7E:069A]
$A4:95C6 AF 3E 78 7E LDA $7E783E[$7E:783E]
$A4:95CA AA          TAX
$A4:95CB A9 00 00    LDA #$0000
$A4:95CE 9D B4 18    STA $18B4,x[$7E:18B8]
$A4:95D1 60          RTS

$A4:95D2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:95D5 22 5B 8B A4 JSL $A48B5B[$A4:8B5B]  ; Update Crocomire BG2 scroll
$A4:95D9 AD 92 06    LDA $0692  [$7E:0692]
$A4:95DC AA          TAX
$A4:95DD 29 00 FF    AND #$FF00
$A4:95E0 EB          XBA
$A4:95E1 85 12       STA $12    [$7E:0012]
$A4:95E3 AD 94 06    LDA $0694  [$7E:0694]
$A4:95E6 38          SEC
$A4:95E7 E9 03 00    SBC #$0003
$A4:95EA C9 10 00    CMP #$0010
$A4:95ED 10 08       BPL $08    [$95F7]
$A4:95EF E0 00 50    CPX #$5000
$A4:95F2 10 B1       BPL $B1    [$95A5]
$A4:95F4 A9 10 00    LDA #$0010

$A4:95F7 8D 94 06    STA $0694  [$7E:0694]
$A4:95FA AD 92 06    LDA $0692  [$7E:0692]
$A4:95FD 18          CLC
$A4:95FE 69 80 01    ADC #$0180
$A4:9601 C9 00 50    CMP #$5000
$A4:9604 30 03       BMI $03    [$9609]
$A4:9606 A9 00 50    LDA #$5000

$A4:9609 8D 92 06    STA $0692  [$7E:0692]
$A4:960C 64 12       STZ $12    [$7E:0012]
$A4:960E AD BE 0F    LDA $0FBE  [$7E:0FBE]
$A4:9611 38          SEC
$A4:9612 E9 48 00    SBC #$0048
$A4:9615 0A          ASL A
$A4:9616 AA          TAX
$A4:9617 AD 94 06    LDA $0694  [$7E:0694]
$A4:961A A8          TAY
$A4:961B 8D A6 05    STA $05A6  [$7E:05A6]
$A4:961E 0A          ASL A

$A4:961F 98          TYA
$A4:9620 38          SEC
$A4:9621 ED A6 05    SBC $05A6  [$7E:05A6]
$A4:9624 18          CLC
$A4:9625 65 B7       ADC $B7    [$7E:00B7]
$A4:9627 9F F0 CA 7E STA $7ECAF0,x[$7E:CC12]
$A4:962B A5 12       LDA $12    [$7E:0012]
$A4:962D 18          CLC
$A4:962E 6D 92 06    ADC $0692  [$7E:0692]
$A4:9631 85 12       STA $12    [$7E:0012]
$A4:9633 B0 01       BCS $01    [$9636]
$A4:9635 C8          INY

$A4:9636 EE A6 05    INC $05A6  [$7E:05A6]
$A4:9639 E8          INX
$A4:963A E8          INX
$A4:963B CC 98 06    CPY $0698  [$7E:0698]
$A4:963E 30 DF       BMI $DF    [$961F]
$A4:9640 E0 00 02    CPX #$0200
$A4:9643 10 0D       BPL $0D    [$9652]
$A4:9645 A5 B7       LDA $B7    [$7E:00B7]

$A4:9647 9F F0 CA 7E STA $7ECAF0,x[$7E:CC18]
$A4:964B E8          INX
$A4:964C E8          INX
$A4:964D E0 00 02    CPX #$0200
$A4:9650 30 F5       BMI $F5    [$9647]

$A4:9652 60          RTS
}


;;; $9653: Crocomire main AI - death sequence index 1Ch/3Ah ;;;
{
$A4:9653 C2 30       REP #$30
$A4:9655 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:9658 9E B0 0F    STZ $0FB0,x[$7E:0FB0]
$A4:965B 9E B2 0F    STZ $0FB2,x[$7E:0FB2]
$A4:965E A9 00 08    LDA #$0800
$A4:9661 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A4:9664 A9 38 03    LDA #$0338
$A4:9667 A2 FE 0F    LDX #$0FFE

$A4:966A 9F 00 20 7E STA $7E2000,x[$7E:2FFE]
$A4:966E CA          DEX
$A4:966F CA          DEX
$A4:9670 10 F8       BPL $F8    [$966A]
$A4:9672 AE 30 03    LDX $0330  [$7E:0330]
$A4:9675 A9 00 08    LDA #$0800
$A4:9678 95 D0       STA $D0,x  [$7E:00D0]
$A4:967A A9 00 20    LDA #$2000
$A4:967D 95 D2       STA $D2,x  [$7E:00D2]
$A4:967F A9 7E 00    LDA #$007E
$A4:9682 95 D4       STA $D4,x  [$7E:00D4]
$A4:9684 A5 59       LDA $59    [$7E:0059]
$A4:9686 29 FE 00    AND #$00FE
$A4:9689 EB          XBA
$A4:968A 95 D5       STA $D5,x  [$7E:00D5]
$A4:968C 8A          TXA
$A4:968D 18          CLC
$A4:968E 69 07 00    ADC #$0007
$A4:9691 8D 30 03    STA $0330  [$7E:0330]
$A4:9694 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2
}


;;; $9697:  ;;;
{
$A4:9697             db 2B, 28, 21, 1F, 2C, 10, 16, 17, 0F, 00, 06, 07, 0B, 08, 01, 2A,
                        0C, 24, 2E, 2D, 1A, 14, 1D, 23, 1E, 29, 25, 22, 13, 19, 15, 12,
                        30, 03, 09, 02, 1B, 05, 18, 1C, 11, 0A, 04, 0D, 2F, 0E, 20, 26,
                        27
}


;;; $96C8:  ;;;
{
$A4:96C8 08          PHP
$A4:96C9 E2 20       SEP #$20
$A4:96CB C2 10       REP #$10
$A4:96CD EB          XBA
$A4:96CE AD 8C 06    LDA $068C  [$7E:068C]
$A4:96D1 85 12       STA $12    [$7E:0012]
$A4:96D3 64 13       STZ $13    [$7E:0013]
$A4:96D5 64 14       STZ $14    [$7E:0014]
$A4:96D7 64 15       STZ $15    [$7E:0015]
$A4:96D9 64 16       STZ $16    [$7E:0016]
$A4:96DB 64 17       STZ $17    [$7E:0017]
$A4:96DD AE 90 06    LDX $0690  [$7E:0690]

$A4:96E0 BD 97 96    LDA $9697,x[$A4:9697]
$A4:96E3 A8          TAY
$A4:96E4 B9 9C 06    LDA $069C,y[$7E:4AC7]
$A4:96E7 CD 88 06    CMP $0688  [$7E:0688]
$A4:96EA 30 0D       BMI $0D    [$96F9]
$A4:96EC E8          INX
$A4:96ED E0 80 00    CPX #$0080
$A4:96F0 30 EE       BMI $EE    [$96E0]
$A4:96F2 9C 90 06    STZ $0690  [$7E:0690]
$A4:96F5 A9 00 28    LDA #$2800
$A4:96F8 6B          RTL

$A4:96F9 8E 90 06    STX $0690  [$7E:0690]
$A4:96FC 8A          TXA
$A4:96FD 29 07       AND #$07
$A4:96FF A8          TAY
$A4:9700 C2 20       REP #$20

$A4:9702 AE 90 06    LDX $0690  [$7E:0690]
$A4:9705 BD 97 96    LDA $9697,x[$A4:9697]
$A4:9708 29 FF 00    AND #$00FF
$A4:970B AA          TAX
$A4:970C 29 F8 FF    AND #$FFF8
$A4:970F 0A          ASL A
$A4:9710 0A          ASL A
$A4:9711 85 14       STA $14    [$7E:0014]
$A4:9713 BD 9C 06    LDA $069C,x[$7E:06C7]
$A4:9716 29 07 00    AND #$0007
$A4:9719 0A          ASL A
$A4:971A 18          CLC
$A4:971B 65 14       ADC $14    [$7E:0014]
$A4:971D 85 14       STA $14    [$7E:0014]
$A4:971F BD 9C 06    LDA $069C,x[$7E:06C7]
$A4:9722 29 F8 FF    AND #$FFF8
$A4:9725 0A          ASL A
$A4:9726 0A          ASL A
$A4:9727 0A          ASL A
$A4:9728 0A          ASL A
$A4:9729 0A          ASL A
$A4:972A 0A          ASL A
$A4:972B 18          CLC
$A4:972C 65 14       ADC $14    [$7E:0014]
$A4:972E AA          TAX
$A4:972F E2 20       SEP #$20
$A4:9731 BF 00 40 7E LDA $7E4000,x[$7E:40A0]
$A4:9735 39 BD 9B    AND $9BBD,y[$A4:DFBD]
$A4:9738 9F 00 40 7E STA $7E4000,x[$7E:40A0]
$A4:973C BF 01 40 7E LDA $7E4001,x[$7E:40A1]
$A4:9740 39 BD 9B    AND $9BBD,y[$A4:DFBD]
$A4:9743 9F 01 40 7E STA $7E4001,x[$7E:40A1]
$A4:9747 BF 10 40 7E LDA $7E4010,x[$7E:40B0]
$A4:974B 39 BD 9B    AND $9BBD,y[$A4:DFBD]
$A4:974E 9F 10 40 7E STA $7E4010,x[$7E:40B0]
$A4:9752 BF 11 40 7E LDA $7E4011,x[$7E:40B1]
$A4:9756 39 BD 9B    AND $9BBD,y[$A4:DFBD]
$A4:9759 9F 11 40 7E STA $7E4011,x[$7E:40B1]
$A4:975D A9 00       LDA #$00
$A4:975F EB          XBA
$A4:9760 AE 90 06    LDX $0690  [$7E:0690]
$A4:9763 BD 97 96    LDA $9697,x[$A4:9697]
$A4:9766 AA          TAX
$A4:9767 BD 9C 06    LDA $069C,x[$7E:06C7]
$A4:976A C9 30       CMP #$30
$A4:976C F0 11       BEQ $11    [$977F]
$A4:976E C2 20       REP #$20
$A4:9770 FE 9C 06    INC $069C,x[$7E:06C7]
$A4:9773 BD 9C 06    LDA $069C,x[$7E:06C7]
$A4:9776 29 FF 00    AND #$00FF
$A4:9779 85 16       STA $16    [$7E:0016]
$A4:977B C6 12       DEC $12    [$7E:0012]
$A4:977D D0 83       BNE $83    [$9702]

$A4:977F C2 30       REP #$30

$A4:9781 AD 9A 06    LDA $069A  [$7E:069A]
$A4:9784 18          CLC
$A4:9785 6D 8A 06    ADC $068A  [$7E:068A]
$A4:9788 AA          TAX
$A4:9789 AC 30 03    LDY $0330  [$7E:0330]
$A4:978C BD C5 9B    LDA $9BC5,x[$A4:9BE7]
$A4:978F C9 FF FF    CMP #$FFFF
$A4:9792 D0 05       BNE $05    [$9799]
$A4:9794 9C 8A 06    STZ $068A  [$7E:068A]
$A4:9797 80 E8       BRA $E8    [$9781]

$A4:9799 99 D0 00    STA $00D0,y[$7E:00D0]
$A4:979C BD CB 9B    LDA $9BCB,x[$A4:9BED]
$A4:979F 99 D2 00    STA $00D2,y[$7E:00D2]
$A4:97A2 BD C9 9B    LDA $9BC9,x[$A4:9BEB]
$A4:97A5 99 D4 00    STA $00D4,y[$7E:00D4]
$A4:97A8 BD C7 9B    LDA $9BC7,x[$A4:9BE9]
$A4:97AB 99 D5 00    STA $00D5,y[$7E:00D5]
$A4:97AE 98          TYA
$A4:97AF 18          CLC
$A4:97B0 69 07 00    ADC #$0007
$A4:97B3 8D 30 03    STA $0330  [$7E:0330]
$A4:97B6 AD 8A 06    LDA $068A  [$7E:068A]
$A4:97B9 18          CLC
$A4:97BA 69 08 00    ADC #$0008
$A4:97BD 8D 8A 06    STA $068A  [$7E:068A]
$A4:97C0 AD 90 06    LDA $0690  [$7E:0690]
$A4:97C3 C9 80 00    CMP #$0080
$A4:97C6 30 03       BMI $03    [$97CB]
$A4:97C8 9C 90 06    STZ $0690  [$7E:0690]

$A4:97CB 8D 90 06    STA $0690  [$7E:0690]
$A4:97CE A9 01 00    LDA #$0001
$A4:97D1 28          PLP
$A4:97D2 6B          RTL
}


;;; $97D3: Crocomire main AI - death sequence index 3Eh - behind wall - wait for Samus ;;;
{
$A4:97D3 C2 20       REP #$20
$A4:97D5 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A4:97D8 C9 80 02    CMP #$0280
$A4:97DB 10 52       BPL $52    [$982F]
$A4:97DD A9 05 00    LDA #$0005             ;\
$A4:97E0 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 0 music track
$A4:97E4 A9 00 01    LDA #$0100
$A4:97E7 8F 23 CD 7E STA $7ECD23[$7E:CD23]
$A4:97EB 22 D7 83 84 JSL $8483D7[$84:83D7]
$A4:97EF             dx 30,03,B757
$A4:97F3 A9 06 00    LDA #$0006
$A4:97F6 8D 41 09    STA $0941  [$7E:0941]
$A4:97F9 AD 86 0F    LDA $0F86  [$7E:0F86]
$A4:97FC 29 FF 7F    AND #$7FFF
$A4:97FF 09 00 04    ORA #$0400
$A4:9802 8D 86 0F    STA $0F86  [$7E:0F86]
$A4:9805 AD C6 0F    LDA $0FC6  [$7E:0FC6]
$A4:9808 09 00 05    ORA #$0500
$A4:980B 8D C6 0F    STA $0FC6  [$7E:0FC6]
$A4:980E A9 04 00    LDA #$0004
$A4:9811 8D AE 0F    STA $0FAE  [$7E:0FAE]
$A4:9814 9C EE 0F    STZ $0FEE  [$7E:0FEE]
$A4:9817 A9 0A 00    LDA #$000A
$A4:981A 8D 2E 10    STA $102E  [$7E:102E]
$A4:981D A9 01 00    LDA #$0001
$A4:9820 8D 6E 10    STA $106E  [$7E:106E]
$A4:9823 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ; Crocomire fight flags = 0
$A4:9826 A9 38 00    LDA #$0038
$A4:9829 8D 84 0F    STA $0F84  [$7E:0F84]
$A4:982C 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2

$A4:982F 60          RTS
}


;;; $9830: Crocomire main AI - death sequence index 58h - flowing down the river ;;;
{
; Strangely, sequenced between 3Ch and 3Eh
$A4:9830 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A4:9833 38          SEC
$A4:9834 E9 02 00    SBC #$0002
$A4:9837 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A4:983A C9 E0 01    CMP #$01E0
$A4:983D 30 07       BMI $07    [$9846]
$A4:983F A9 DC 00    LDA #$00DC
$A4:9842 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A4:9845 60          RTS

$A4:9846 A9 E0 01    LDA #$01E0
$A4:9849 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A4:984C A9 36 00    LDA #$0036
$A4:984F 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A4:9852 A9 3E 00    LDA #$003E             ;\
$A4:9855 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Crocomire death sequence index = 3Eh
$A4:9858 60          RTS
}


;;; $9859: Crocomire main AI - death sequence index 40h - behind wall - rumbling ;;;
{
$A4:9859 AE AE 0F    LDX $0FAE  [$7E:0FAE]
$A4:985C BD CA 98    LDA $98CA,x[$A4:98CE]
$A4:985F C9 80 80    CMP #$8080
$A4:9862 D0 1A       BNE $1A    [$987E]
$A4:9864 8D EE 0F    STA $0FEE  [$7E:0FEE]
$A4:9867 A9 80 00    LDA #$0080
$A4:986A 8D AE 0F    STA $0FAE  [$7E:0FAE]
$A4:986D A2 1E 00    LDX #$001E

$A4:9870 BD 1D B9    LDA $B91D,x[$A4:B93B]
$A4:9873 9F 60 C1 7E STA $7EC160,x[$7E:C17E]
$A4:9877 CA          DEX
$A4:9878 CA          DEX
$A4:9879 10 F5       BPL $F5    [$9870]
$A4:987B 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2

$A4:987E AE AE 0F    LDX $0FAE  [$7E:0FAE]
$A4:9881 AD EE 0F    LDA $0FEE  [$7E:0FEE]
$A4:9884 DD CA 98    CMP $98CA,x[$A4:98CE]
$A4:9887 F0 10       BEQ $10    [$9899]
$A4:9889 10 08       BPL $08    [$9893]
$A4:988B 18          CLC
$A4:988C 6D 6E 10    ADC $106E  [$7E:106E]

$A4:988F 8D EE 0F    STA $0FEE  [$7E:0FEE]
$A4:9892 60          RTS

$A4:9893 38          SEC
$A4:9894 ED 6E 10    SBC $106E  [$7E:106E]
$A4:9897 80 F6       BRA $F6    [$988F]

$A4:9899 BD CA 98    LDA $98CA,x[$A4:98CE]
$A4:989C 10 26       BPL $26    [$98C4]
$A4:989E AD 2E 10    LDA $102E  [$7E:102E]
$A4:98A1 F0 11       BEQ $11    [$98B4]
$A4:98A3 3A          DEC A
$A4:98A4 8D 2E 10    STA $102E  [$7E:102E]
$A4:98A7 CA          DEX
$A4:98A8 CA          DEX
$A4:98A9 8E AE 0F    STX $0FAE  [$7E:0FAE]
$A4:98AC A9 2B 00    LDA #$002B             ;\
$A4:98AF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 2Bh, sound library 2, max queued sounds allowed = 6 (Crocomire post-death rumble)
$A4:98B3 60          RTS

$A4:98B4 E8          INX
$A4:98B5 E8          INX
$A4:98B6 BD CA 98    LDA $98CA,x[$A4:98D2]
$A4:98B9 8D 2E 10    STA $102E  [$7E:102E]
$A4:98BC E8          INX
$A4:98BD E8          INX
$A4:98BE BD CA 98    LDA $98CA,x[$A4:98D4]
$A4:98C1 8D 6E 10    STA $106E  [$7E:106E]

$A4:98C4 E8          INX
$A4:98C5 E8          INX
$A4:98C6 8E AE 0F    STX $0FAE  [$7E:0FAE]
$A4:98C9 60          RTS

$A4:98CA             dw 0004, 0001, 0000, FFFF, 0008, 0001, 0001, FFFF, 000C, 0001, 0001, FFFE, 0010, 0002, 0002, FFFE,
                        0010, 0002, 0002, FFFC, 0008, 0001, 0001, FFFE, 0003, 0001, 0001, FFFF, 8080, 8080, 8080, 8080
}


;;; $990A: Crocomire main AI - death sequence index 42h - behind wall - no more rumbling ;;;
{
$A4:990A AD AE 0F    LDA $0FAE  [$7E:0FAE]
$A4:990D F0 43       BEQ $43    [$9952]
$A4:990F 3A          DEC A
$A4:9910 8D AE 0F    STA $0FAE  [$7E:0FAE]
$A4:9913 AC 88 06    LDY $0688  [$7E:0688]
$A4:9916 B9 CB 99    LDA $99CB,y[$A4:99CB]
$A4:9919 C9 FF FF    CMP #$FFFF
$A4:991C D0 01       BNE $01    [$991F]
$A4:991E 60          RTS

$A4:991F AE 30 03    LDX $0330  [$7E:0330]
$A4:9922 A9 00 02    LDA #$0200
$A4:9925 95 D0       STA $D0,x  [$7E:00D0]
$A4:9927 B9 D9 99    LDA $99D9,y[$A4:99D9]
$A4:992A 95 D2       STA $D2,x  [$7E:00D2]
$A4:992C A9 AD 00    LDA #$00AD
$A4:992F 95 D4       STA $D4,x  [$7E:00D4]
$A4:9931 A5 52       LDA $52    [$7E:0052]
$A4:9933 29 07 00    AND #$0007
$A4:9936 EB          XBA
$A4:9937 0A          ASL A
$A4:9938 0A          ASL A
$A4:9939 0A          ASL A
$A4:993A 0A          ASL A
$A4:993B 0A          ASL A
$A4:993C 85 12       STA $12    [$7E:0012]
$A4:993E 18          CLC
$A4:993F 79 CB 99    ADC $99CB,y[$A4:99CB]
$A4:9942 95 D5       STA $D5,x  [$7E:00D5]
$A4:9944 8A          TXA
$A4:9945 18          CLC
$A4:9946 69 07 00    ADC #$0007
$A4:9949 8D 30 03    STA $0330  [$7E:0330]
$A4:994C C8          INY
$A4:994D C8          INY
$A4:994E 8C 88 06    STY $0688  [$7E:0688]
$A4:9951 60          RTS

$A4:9952 A9 E0 01    LDA #$01E0
$A4:9955 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A4:9958 A9 36 00    LDA #$0036
$A4:995B 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A4:995E A9 50 00    LDA #$0050
$A4:9961 8D 2E 10    STA $102E  [$7E:102E]
$A4:9964 9C B0 0F    STZ $0FB0  [$7E:0FB0]
$A4:9967 9C B2 0F    STZ $0FB2  [$7E:0FB2]
$A4:996A 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:996E             dx 20,03,B753          ;} Spawn PLM to clear Crocomire invisible wall at (20h, 3)
$A4:9972 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:9976             dx 1E,03,B757          ;} Spawn PLM to clear Crocomire invisible wall at (1Eh, 3)
$A4:997A 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A4:997E             dx 70,0B,B747          ;} Spawn PLM to clear Crocomire's bridge at (70h, Bh) <-- ok but the bridge is Fh blocks to the left... so this does nothing
$A4:9982 A9 29 00    LDA #$0029             ;\
$A4:9985 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 29h, sound library 2, max queued sounds allowed = 6 (Crocomire's wall explodes)
$A4:9989 A9 58 E1    LDA #$E158
$A4:998C 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:998F A9 01 00    LDA #$0001
$A4:9992 8D 94 0F    STA $0F94  [$7E:0F94]
$A4:9995 A9 00 00    LDA #$0000
$A4:9998 8D 96 0F    STA $0F96  [$7E:0F96]
$A4:999B A2 1E 00    LDX #$001E

$A4:999E BD FD B8    LDA $B8FD,x[$A4:B91B]
$A4:99A1 9F 20 C1 7E STA $7EC120,x[$7E:C13E]
$A4:99A5 CA          DEX
$A4:99A6 CA          DEX
$A4:99A7 10 F5       BPL $F5    [$999E]
$A4:99A9 22 16 80 86 JSL $868016[$86:8016]
$A4:99AD A9 08 00    LDA #$0008
$A4:99B0 85 12       STA $12    [$7E:0012]

$A4:99B2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:99B5 A0 C1 90    LDY #$90C1             ;\
$A4:99B8 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn Crocomire spike wall pieces enemy projectile
$A4:99BC C6 12       DEC $12    [$7E:0012]
$A4:99BE D0 F2       BNE $F2    [$99B2]
$A4:99C0 A9 30 00    LDA #$0030             ;\
$A4:99C3 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 30h, sound library 2, max queued sounds allowed = 6 (Crocomire destroys wall)
$A4:99C7 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2

; Nothing points here
$A4:99CA 60          RTS

$A4:99CB             dw 1600, 1700, 1800, 1900, 1E00, 1F00, FFFF
$A4:99D9             dw A600, A800, AA00, AC00, AE00, B000
}


;;; $99E5: Crocomire main AI - death sequence index 44h - breaks down wall ;;;
{
$A4:99E5 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A4:99E8 C9 E0 00    CMP #$00E0
$A4:99EB 10 2E       BPL $2E    [$9A1B]
$A4:99ED AD B0 0F    LDA $0FB0  [$7E:0FB0]
$A4:99F0 18          CLC
$A4:99F1 69 00 80    ADC #$8000
$A4:99F4 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A4:99F7 AD B2 0F    LDA $0FB2  [$7E:0FB2]
$A4:99FA 69 00 00    ADC #$0000
$A4:99FD C9 02 00    CMP #$0002
$A4:9A00 30 03       BMI $03    [$9A05]
$A4:9A02 A9 02 00    LDA #$0002

$A4:9A05 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A4:9A08 AD 7C 0F    LDA $0F7C  [$7E:0F7C]
$A4:9A0B 18          CLC
$A4:9A0C 6D B0 0F    ADC $0FB0  [$7E:0FB0]
$A4:9A0F 8D 7C 0F    STA $0F7C  [$7E:0F7C]
$A4:9A12 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A4:9A15 6D B2 0F    ADC $0FB2  [$7E:0FB2]
$A4:9A18 8D 7A 0F    STA $0F7A  [$7E:0F7A]

$A4:9A1B AD 2E 10    LDA $102E  [$7E:102E]
$A4:9A1E F0 17       BEQ $17    [$9A37]
$A4:9A20 CE 2E 10    DEC $102E  [$7E:102E]
$A4:9A23 D0 12       BNE $12    [$9A37]
$A4:9A25 9C B0 0F    STZ $0FB0  [$7E:0FB0]
$A4:9A28 A9 4A E1    LDA #$E14A
$A4:9A2B 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:9A2E A9 01 00    LDA #$0001
$A4:9A31 8D 94 0F    STA $0F94  [$7E:0F94]
$A4:9A34 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2

$A4:9A37 60          RTS
}


;;; $9A38: Crocomire main AI - death sequence index 46h - skeleton falls ;;;
{
$A4:9A38 AD B0 0F    LDA $0FB0  [$7E:0FB0]
$A4:9A3B 18          CLC
$A4:9A3C 69 00 08    ADC #$0800
$A4:9A3F 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A4:9A42 AD B2 0F    LDA $0FB2  [$7E:0FB2]
$A4:9A45 69 00 00    ADC #$0000
$A4:9A48 C9 05 00    CMP #$0005
$A4:9A4B 30 03       BMI $03    [$9A50]
$A4:9A4D A9 05 00    LDA #$0005

$A4:9A50 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A4:9A53 A9 00 E0    LDA #$E000
$A4:9A56 18          CLC
$A4:9A57 6D 80 0F    ADC $0F80  [$7E:0F80]
$A4:9A5A 8D 80 0F    STA $0F80  [$7E:0F80]
$A4:9A5D AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A4:9A60 69 00 00    ADC #$0000
$A4:9A63 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A4:9A66 AD 7C 0F    LDA $0F7C  [$7E:0F7C]
$A4:9A69 18          CLC
$A4:9A6A 6D B0 0F    ADC $0FB0  [$7E:0FB0]
$A4:9A6D 8D 7C 0F    STA $0F7C  [$7E:0F7C]
$A4:9A70 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A4:9A73 6D B2 0F    ADC $0FB2  [$7E:0FB2]
$A4:9A76 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A4:9A79 C9 40 02    CMP #$0240
$A4:9A7C 30 1C       BMI $1C    [$9A9A]
$A4:9A7E A9 25 00    LDA #$0025             ;\
$A4:9A81 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 25h, sound library 2, max queued sounds allowed = 6 (big explosion)
$A4:9A85 AD 96 0F    LDA $0F96  [$7E:0F96]
$A4:9A88 8D D6 0F    STA $0FD6  [$7E:0FD6]
$A4:9A8B A9 58 E1    LDA #$E158
$A4:9A8E 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:9A91 A9 01 00    LDA #$0001
$A4:9A94 8D 94 0F    STA $0F94  [$7E:0F94]
$A4:9A97 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2

$A4:9A9A 60          RTS
}


;;; $9A9B..9B05: Spawn big dust cloud enemy projectile instructions ;;;
{
;;; $9A9B: Instruction - Spawn big dust cloud enemy projectile - X offset -20h ;;;
{
$A4:9A9B A9 E0 FF    LDA #$FFE0         ; A = -20h
$A4:9A9E 80 3A       BRA $3A    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AA0: Instruction - Spawn big dust cloud enemy projectile - X offset 0 ;;;
{
$A4:9AA0 A9 00 00    LDA #$0000         ; A = 0
$A4:9AA3 80 35       BRA $35    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AA5: Instruction - Spawn big dust cloud enemy projectile - X offset -10h ;;;
{
$A4:9AA5 A9 F0 FF    LDA #$FFF0         ; A = -10h
$A4:9AA8 80 30       BRA $30    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AAA: Instruction - Spawn big dust cloud enemy projectile - X offset 10h ;;;
{
$A4:9AAA A9 10 00    LDA #$0010         ; A = 10h
$A4:9AAD 80 2B       BRA $2B    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AAF: Instruction - Spawn big dust cloud enemy projectile - X offset 0 ;;;
{
$A4:9AAF A9 00 00    LDA #$0000         ; A = 0
$A4:9AB2 80 26       BRA $26    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AB4: Instruction - Spawn big dust cloud enemy projectile - X offset 8 ;;;
{
$A4:9AB4 A9 08 00    LDA #$0008         ; A = 8
$A4:9AB7 80 21       BRA $21    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AB9: Instruction - Spawn big dust cloud enemy projectile - X offset 10h ;;;
{
$A4:9AB9 A9 10 00    LDA #$0010         ; A = 10h
$A4:9ABC 80 1C       BRA $1C    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9ABE: Instruction - Spawn big dust cloud enemy projectile - X offset 18h ;;;
{
$A4:9ABE A9 18 00    LDA #$0018         ; A = 18h
$A4:9AC1 80 17       BRA $17    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AC3: Instruction - Spawn big dust cloud enemy projectile - X offset 20h ;;;
{
$A4:9AC3 A9 20 00    LDA #$0020         ; A = 20h
$A4:9AC6 80 12       BRA $12    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AC8: Instruction - Spawn big dust cloud enemy projectile - X offset 28h ;;;
{
$A4:9AC8 A9 28 00    LDA #$0028         ; A = 28h
$A4:9ACB 80 0D       BRA $0D    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9ACD: Instruction - Spawn big dust cloud enemy projectile - X offset 30h ;;;
{
$A4:9ACD A9 30 00    LDA #$0030         ; A = 30h
$A4:9AD0 80 08       BRA $08    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AD2: Instruction - Spawn big dust cloud enemy projectile - X offset 38h ;;;
{
$A4:9AD2 A9 38 00    LDA #$0038         ; A = 38h
$A4:9AD5 80 03       BRA $03    [$9ADA] ; Go to spawn big dust cloud enemy projectile
}


;;; $9AD7: Instruction - Spawn big dust cloud enemy projectile - X offset 40h ;;;
{
$A4:9AD7 A9 40 00    LDA #$0040         ; A = 40h
}


;;; $9ADA: Spawn big dust cloud enemy projectile ;;;
{
;; Parameters:
;;     A: X offset
$A4:9ADA DA          PHX
$A4:9ADB 5A          PHY
$A4:9ADC 85 12       STA $12    [$7E:0012]  ;\
$A4:9ADE AD E5 05    LDA $05E5  [$7E:05E5]  ;|
$A4:9AE1 29 07 00    AND #$0007             ;|
$A4:9AE4 18          CLC                    ;} $12 = [Crocomire X position] + [A] + [random number] % 8
$A4:9AE5 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;|
$A4:9AE8 65 12       ADC $12    [$7E:0012]  ;|
$A4:9AEA 85 12       STA $12    [$7E:0012]  ;/
$A4:9AEC AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A4:9AEF 18          CLC                    ;|
$A4:9AF0 6D 84 0F    ADC $0F84  [$7E:0F84]  ;|
$A4:9AF3 38          SEC                    ;} $14 = (Crocomire bottom boundary) - Fh
$A4:9AF4 E9 10 00    SBC #$0010             ;|
$A4:9AF7 85 14       STA $14    [$7E:0014]  ;/
$A4:9AF9 A9 15 00    LDA #$0015             ; A = 15h (big dust cloud)
$A4:9AFC A0 09 E5    LDY #$E509             ;\
$A4:9AFF 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:9B03 7A          PLY
$A4:9B04 FA          PLX
$A4:9B05 6B          RTL
}
}


;;; $9B06: Crocomire main AI - death sequence index 48h - skeleton falls apart ;;;
{
$A4:9B06 AD 92 0F    LDA $0F92  [$7E:0F92]
$A4:9B09 C9 C6 E1    CMP #$E1C6
$A4:9B0C 30 3B       BMI $3B    [$9B49]
$A4:9B0E A9 CC E1    LDA #$E1CC
$A4:9B11 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:9B14 A9 01 00    LDA #$0001
$A4:9B17 8D 94 0F    STA $0F94  [$7E:0F94]
$A4:9B1A AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A4:9B1D 18          CLC
$A4:9B1E 69 40 00    ADC #$0040
$A4:9B21 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A4:9B24 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A4:9B27 18          CLC
$A4:9B28 69 15 00    ADC #$0015
$A4:9B2B 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A4:9B2E A9 1C 00    LDA #$001C
$A4:9B31 8D 84 0F    STA $0F84  [$7E:0F84]
$A4:9B34 A9 28 00    LDA #$0028
$A4:9B37 8D 82 0F    STA $0F82  [$7E:0F82]
$A4:9B3A 22 D7 83 84 JSL $8483D7[$84:83D7]
$A4:9B3E             dx 30,03,B753
$A4:9B42 22 D8 B9 A0 JSL $A0B9D8[$A0:B9D8]  ; Crocomire death item drop routine
$A4:9B46 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2

$A4:9B49 AD B0 0F    LDA $0FB0  [$7E:0FB0]
$A4:9B4C 18          CLC
$A4:9B4D 69 00 10    ADC #$1000
$A4:9B50 8D B0 0F    STA $0FB0  [$7E:0FB0]
$A4:9B53 AD B2 0F    LDA $0FB2  [$7E:0FB2]
$A4:9B56 69 00 00    ADC #$0000
$A4:9B59 C9 06 00    CMP #$0006
$A4:9B5C 30 03       BMI $03    [$9B61]
$A4:9B5E A9 06 00    LDA #$0006

$A4:9B61 8D B2 0F    STA $0FB2  [$7E:0FB2]
$A4:9B64 60          RTS
}


;;; $9B65: Crocomire main AI - death sequence index 4Ah ;;;
{
$A4:9B65 A9 01 01    LDA #$0101
$A4:9B68 8F 20 CD 7E STA $7ECD20[$7E:CD20]
$A4:9B6C 8F 22 CD 7E STA $7ECD22[$7E:CD22]
$A4:9B70 22 D7 83 84 JSL $8483D7[$84:83D7]
$A4:9B74             dx 1E,03,B753
$A4:9B78 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2
}


;;; $9B7B: Crocomire main AI - death sequence index 4Eh ;;;
{
$A4:9B7B 80 36       BRA $36    [$9BB3]     ; Go to Crocomire death sequence index += 2
}


;;; $9B7D: Crocomire main AI - death sequence index 4Ch ;;;
{
$A4:9B7D AD 92 0F    LDA $0F92  [$7E:0F92]
$A4:9B80 C9 C6 E1    CMP #$E1C6
$A4:9B83 10 2E       BPL $2E    [$9BB3]     ; Go to Crocomire death sequence index += 2
$A4:9B85 60          RTS
}


;;; $9B86: Crocomire main AI - death sequence index 50h ;;;
{
$A4:9B86 A9 06 00    LDA #$0006             ;\
$A4:9B89 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 1 music track
$A4:9B8D 9C 41 09    STZ $0941  [$7E:0941]
$A4:9B90 AE 9F 07    LDX $079F  [$7E:079F]
$A4:9B93 BF 28 D8 7E LDA $7ED828,x[$7E:D82A]
$A4:9B97 09 02 00    ORA #$0002
$A4:9B9A 9F 28 D8 7E STA $7ED828,x[$7E:D82A]
$A4:9B9E A9 06 00    LDA #$0006             ;\
$A4:9BA1 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue song 1 music track
$A4:9BA5 A9 F0 FF    LDA #$FFF0
$A4:9BA8 22 DA 9A A4 JSL $A49ADA[$A4:9ADA]
$A4:9BAC A9 10 00    LDA #$0010
$A4:9BAF 22 DA 9A A4 JSL $A49ADA[$A4:9ADA]
}


;;; $9BB3: Crocomire death sequence index += 2 ;;;
{
$A4:9BB3 EE A8 0F    INC $0FA8  [$7E:0FA8]  ;\
$A4:9BB6 EE A8 0F    INC $0FA8  [$7E:0FA8]  ;} Crocomire death sequence index += 2
$A4:9BB9 60          RTS
}


;;; $9BBA: Crocomire main AI - death sequence index 54h - set dead state ;;;
{
$A4:9BBA 4C B3 9B    JMP $9BB3  [$A4:9BB3]  ; Go to Crocomire death sequence index += 2
}


;;; $9BBD:  ;;;
{
$A4:9BBD             dw BF7F, EFDF, FBF7, FEFD
}


;;; $9BC5: Melting Crocomire tiles loading table ;;;
{
; Tables for loading Crocomire melting tiles

; Format:
;     ????,????,nnnn,bbbb
;     ssss,dddd
;     [...]
;     FFFF
; where
;     n: Number of words to copy
;     b: Source bank
;     s: Source address
;     d: Destination address (bank $7E)

;     nnnn,dddd,bbbb,ssss
;     [...]
;     FFFF
; where
;     n: Number of bytes to copy
;     b: Source bank
;     s: Source address
;     d: VRAM destination address

; Melting 1
$A4:9BC5             dw 0058,0030,0200,00A4,
                        A07D,4000,
                        A27D,4200,
                        A47D,4400,
                        A67D,4600,
                        A87D,4800,
                        AA7D,4A00,
                        FFFF

$A4:9BE7             dw 0160,0000,007E,4000,
                        0160,0100,007E,4200,
                        0160,0200,007E,4400,
                        0160,0300,007E,4600,
                        0160,0400,007E,4800,
                        0160,0500,007E,4A00,
                        FFFF

; Melting 2
$A4:9C19             dw 0058,0030,0200,00A4,
                        AC7D,4000,
                        AE7D,4200,
                        B07D,4400,
                        B27D,4600,
                        B47D,4800,
                        B67D,4A00,
                        B87D,4C00,
                        FFFF

$A4:9C3F             dw 0160,0000,007E,4000,
                        0160,0100,007E,4200,
                        0160,0200,007E,4400,
                        0160,0300,007E,4600,
                        0160,0400,007E,4800,
                        0160,0500,007E,4A00,
                        0160,0600,007E,4C00,
                        FFFF
}


;;; $9C79:  ;;;
{
$A4:9C79             dw 3C00,3C20,3C30,3C40,3C50,3C01,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        3C10,3C11,3C04,3C33,3C43,3C23,3C41,3C51,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,3C02,3C14,3C05,3C44,3C54,3C24,3C34,3C12,3C22,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,0338,3C53,3C15,3C06,3C16,3C26,3C36,3C46,3C13,3C52,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,0338,0338,3C25,3C56,3C07,3C17,3C27,3C37,3C47,3C03,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,0338,0338,0338,3C57,3C08,3C18,3C28,3C38,3C48,3C35,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,3C32,3C21,3C45,3C58,3C09,3C19,3C29,3C29,3C49,3C59,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,3C42,3C31,3C55,3C0A,3C1A,3C2A,3C3A,3C4A,3C5A,3C0B,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        FFFF
}


;;; $9E7B:  ;;;
{
$A4:9E7B             dw 3C00,3C10,3C20,3C30,0338,0338,0338,0338,0338,3C00,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        3C40,3C11,3C21,3C50,3C23,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,3C32,3C42,3C04,3C54,3C03,0338,0338,3C33,3C01,3C53,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,0338,0338,3C34,3C44,3C05,3C24,3C14,3C02,3C12,3C22,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,0338,0338,0338,3C35,3C45,3C55,3C06,3C16,3C26,3C36,3C3A,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,0338,0338,0338,0338,3C46,3C56,3C07,3C17,3C27,3C37,3C47,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,3C31,3C41,3C51,3C57,3C08,3C18,3C28,3C38,3C48,3C58,3C09,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        0338,3C43,3C52,3C19,3C13,3C39,3C49,3C59,3C0A,3C1A,3C2A,3C3A,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        FFFF
}


;;; $A07D: Crocomire melting tiles ;;;
{
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |      66|        |     F6F|5F      |54566666|FFBB9878|666FBA98|24444455|55433223|55443333|55554245|F5525   |        |        |        |        |
; |     666|        |      FF|4F      |556BBBBF|6FBB98A8|5555FAAA|42554344|65433223|54443333|66655245|54535   |        |        |        |        |
; |    6656|        |       F|55F     |FFBBA19B|FFFAA989|444555FA|54454333|65432223|44443333|66665335|43555   |        |        |        |        |
; |   FF665|        |        |455FF   |FF6B9989|55FBAAA9|33334455|55444433|65432223|44343333|65554346|35355F  |        |        |        |        |
; |  FF6654|        |        |34552F  |FFFAA99B|555FBBBA|33433445|55444443|64433322|44343333|55554446|354455  |        |        |        |        |
; |  F66554|        |        |335335  |6FBBA999|65444FBF|54443333|65443334|54433322|34344333|54456665|454445F |        |        |        |        |
; |  FF6556|6F      |        |33555F  |F6FBBBAB|6444455F|44444243|55543333|55433332|44334443|34455555|555445F |        |        |        |        |
; | FF6555F|666FFF  |        |34555FF |6FFFFFFF|66444455|55544423|55543333|55433332|44324443|43444445|555455F |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | 6655566|55555555|F F555  |3344566 |66F6FFFF|65444445|A999BBBF|BBB99999|34454444|34455566|44325444|        |        |        |        |        |
; | F665566|66666666|664325F |444334FF|F6565FFF|66544455|89A8BBF6|55A9A988|33434434|34566666|54435445|        |        |        |        |        |
; | F665665|66666F6F|564334FF|4443356F|FF666555|66655435|A9BAAB6F|455AB99B|33355446|3456666F|54435445|        |        |        |        |        |
; | F666654|55466F6F|46644446|4443455F| FFF6655|F6655444|FABBB666|3555B99B|33445566|44566FF5|54435455|        |        |        |        |        |
; | F656664|66465566|36666555|44434546|  FFF666| F665544|5FBFF66F|33455BAB|33445556|4456F555|55445555|        |        |        |        |        |
; | F656666|66666656|33444555|44433356|   FFF65|  F66554|455F66FB|533455BB|33424555|445F5544|55435555|        |        |        |        |        |
; | F6FFFFF|66F66665|22334454|44433445|    FFF6|   F6655|345F66FF|45344566|34443455|45544423|55444555|        |        |        |        |        |
; | FFFF  F|FFFF6666|22234453|44333445|     FF6|   F6666|445555FF|45344555|34455455|55543224|55545555|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |66666666|        |        |4546FFFF|34334454|    FF66|6F66BFBB|99AAB665|43334434|66F54445|54442235|        |        |        |        |        |
; |66444446|        |        |25446665|44344454|     FF6|FFBBBABB|9B9BF655|44444444|6FF54444|55443345|        |        |        |        |        |
; |44444545|        |        |33343466|54444543|      FF|FBBAA1AA|99BFF655|44544444|F5544443|55444455|        |        |        |        |        |
; |55555555|FFF  F  |5F      |44433344|54444443|        |BAAA1111|9AFFFFF5|65554445|54544433|55554556|        |        |        |        |        |
; |56F65444|6F6FF66F|56F     |44233333|54455333|        |BBA9A119|BFFFFFFF|66555555|44544332|55555566|        |        |        |        |        |
; |FF554443|66556555|566F    |33332222|65554455|        |BA988889|66F54555|65555566|34554332|55455666|        |        |        |        |        |
; |F4444444|65555555|5465F   |34333322|65555665|        |BBBA8888|FF444444|55555664|45544323|54555666|        |        |        |        |        |
; |54554554|66655555|55555F  |44454433|66666F66|        |BA999888|44444443|55555544|55454534|55556666|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |66F     |F6666665|        |F5355322|45523544|3233545F|FFF65543|44444434|44444444|44444444|55454555|        |        |        |        |        |
; |6466FF  |FF6F6666|        |FF555322|44443344|3234452F|BBFF6553|44444444|44444545|44444545|65544353|        |        |        |        |        |
; |54546666|FFF6FF6F|        |B6644445|33343334|2233445F|9BBFF654|54444444|45555554|45555554|65544333|        |        |        |        |        |
; |54334444|BFFFFFFF| FFFFFFF|BF555566|33332233|2333344F|AAABB654|55445444|55565644|55565644|65544433|        |        |        |        |        |
; |32333233|ABBBBBBF|F666666F|BF6666B6|33333223|2333345F|999AF665|F5555543|55664444|55664444|55554433|        |        |        |        |        |
; |22222223|AAABAABB|6666F665|F666B9AA|43433332|3333345F|8899B665|55554433|64445443|64445443|55555443|        |        |        |        |        |
; |43345454|9999AAAB|FFF66F56|FF6BA911|65454333|3334445F|999ABF64|44443434|43334332|43334332|55555544|        |        |        |        |        |
; |45456656|9889999B|FFFFFF65|66FBB9AA|66655433|544555FF|8A9ABF65|34344444|32345322|32345322|55555554|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |FFF     |FFBBBFF6|22224334|89AF6545|        |32233244|43333455|44444333|35554333|33345355|        |        |        |        |        |
; |        |666FFF  | FBABBFF|44322445|88AF6666|        |33223334|43334344|44443332|66654544|33445555|        |        |        |        |        |
; | FF     |56666F6F| FBAABBB|55542353|8ABF66B6|      FF|33223334|53333345|44433444|65555555|33343536|        |        |        |        |        |
; |6664FFF |35454666|  BBAAAB|66654345|AABF6BBA|     F5F|43223344|34352334|44433432|65544666|33344456|        |        |        |        |        |
; |245335F4|33455666|   BA9AA|BF665344|BBF6FBA8|FFFFFF45|34323344|34552234|34443333|65433444|34344556|        |        |        |        |        |
; |22344544|23345554|   BAA9A|BBF66543|FFFFFB9A|56666434|34333344|45533243|34544443|65443323|44445566|        |        |        |        |        |
; |53534243|22344554|   BAA8A|9BBF6544|FFFFBAA8|23554434|44333443|33552233|25332445|65544333|44445665|        |        |        |        |        |
; |54555232|22344544|  BBA889|89FF6444|F6FFBA98|35454423|44333444|34333344|34423445|65554434|45555655|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |        |      FF|65665553|55555434|65555444|      F6|     FF5|455FFFF |65665445|        |        |        |        |        |
; |        |        |        |       F|66666655|65555434|66656554|      F6|FF66F55F|34555FF |656566FF|        |        |        |        |        |
; |        |        |F       |        |BABFFF65|66555544|66666665|      FF|FFFF5445|55FFF   |66655554|        |        |        |        |        |
; |        |FFF     |F       |        |9A9ABFF6|66666666|F6F66666|       F|55543335|FFFFF   |66655555|        |        |        |        |        |
; |F FF    |66F6    |F       |        |8188BBFF|FF555565| FFFF666|       F|44322334|44455F  |56555554|        |        |        |        |        |
; |46666FFF|44666F  |6       |        |181A9AF6|BFF45555|   FFF66|      F6|33322344|33345FF |56555553|        |        |        |        |        |
; |33444666|6666666 |FF      |        |888A99F6|BFF54444|    FFF6|      F6|54433344|33455F  |55545544|        |        |        |        |        |
; |23234346|44555446|6F      |        |98898ABF|BF533544|      F6|      F6|54444245|5FF4F   |45445445|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|

$A4:A07D             db 00,03,00,07,02,0D,19,1E,32,3C,26,38,36,39,6F,71,03,00,07,00,0F,00,1F,18,3F,30,3F,20,3F,30,7F,61,
                        00,00,00,00,00,00,00,00,00,00,00,00,40,C0,1C,FC,00,00,00,00,00,00,00,00,00,00,00,00,C0,40,FC,1C,
                        05,07,03,03,01,01,00,00,00,00,00,00,00,00,00,00,07,05,03,03,01,01,00,00,00,00,00,00,00,00,00,00,
                        C0,40,40,40,E0,20,78,18,B4,8C,FC,D8,FC,C4,BE,86,C0,40,C0,40,E0,20,F8,18,74,04,24,00,3C,04,7E,06,
                        A0,1F,DF,3F,F7,F9,DD,F0,E7,F9,77,F8,BD,FF,7F,FF,FF,00,E1,1F,C0,FB,E0,DF,E0,FF,C0,7F,E0,BF,FF,7F,
                        FA,F2,78,F2,E5,F8,F1,3E,FE,1F,47,87,07,81,03,C0,C2,FD,C0,7F,E0,FF,E0,3F,F0,1F,FD,07,FF,01,FF,00,
                        1A,FC,F8,0F,1E,03,F3,F0,D9,D8,8F,0F,01,05,E1,03,F0,1F,F8,0F,FE,03,0F,00,27,00,F0,00,FA,00,FC,00,
                        03,80,34,44,97,07,C3,03,C1,01,4E,8E,EF,0F,EF,0F,7F,00,BB,00,F8,00,FC,00,FE,00,F1,00,F0,00,F0,00,
                        D9,1F,59,9F,51,9F,51,9F,1C,9F,9C,1F,DE,1F,DE,1F,E0,00,E0,00,E0,00,E0,00,E0,00,E0,00,E0,00,E0,00,
                        CF,0F,8F,0F,0F,0F,2F,2F,2F,2F,A7,A7,31,31,21,31,F0,00,F0,00,F0,00,D0,00,D0,00,58,00,CE,00,CE,00,
                        F1,04,19,E4,0F,F6,74,85,F0,01,91,0E,9F,80,41,40,FB,00,FB,00,F9,00,FB,00,FF,00,FF,00,7F,00,BF,00,
                        E8,90,B8,10,78,40,FC,A4,CC,80,46,02,E6,02,EE,02,E8,80,E8,00,B8,00,5C,04,7C,00,FE,02,FE,02,FE,02,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        1C,63,4C,73,49,76,42,7C,50,6E,50,6F,5F,7F,79,79,7F,00,7F,40,7F,40,7F,40,7F,40,7F,40,7F,5F,79,79,
                        FF,00,00,FF,05,FF,C5,1F,0C,D3,02,FD,21,FE,F0,FF,FF,00,FF,00,FF,05,FF,05,FF,00,FF,00,FF,20,FF,F0,
                        BC,A0,16,DA,9B,5B,00,61,87,F8,C7,C0,32,F0,13,F1,BC,A0,E6,02,E7,03,FF,00,7F,00,3F,00,0F,00,0E,00,
                        C8,C6,1B,1B,1D,1B,17,11,14,11,1E,1D,19,18,39,38,3E,00,E7,03,E7,01,EF,01,EF,00,E3,00,E7,00,C7,00,
                        2F,FF,AF,D7,C7,F8,73,7C,38,3F,1D,1E,0E,0F,06,07,FF,2F,FF,87,FF,C0,7F,70,3F,38,1F,1C,0F,0E,07,06,
                        41,80,23,C0,1B,E2,98,E0,4C,70,26,38,13,1C,10,1F,FF,00,FF,00,FD,00,FF,80,7F,40,3F,20,1F,10,1F,10,
                        7F,8F,4E,2F,65,BF,B8,FF,F9,7F,73,1F,B3,9F,3F,03,01,FF,03,FE,03,FD,87,F8,DF,79,FE,13,7F,13,FF,03,
                        FF,E0,D4,28,6F,19,FF,89,DD,C7,EF,63,64,23,67,20,00,FF,C0,3F,E0,1F,70,0F,38,07,9C,03,DF,00,DF,00,
                        90,80,D2,D2,F8,E1,CC,C3,CE,C1,C7,D0,8B,88,9B,80,7F,00,2D,00,1F,00,3F,00,3F,00,2F,00,77,00,7F,00,
                        9C,83,A0,9F,A1,9F,27,1E,2F,18,3C,10,61,03,E8,0E,7F,00,7F,00,7F,01,FF,06,FF,08,FF,10,FC,00,F1,00,
                        28,30,99,10,99,10,9B,10,CF,00,DF,10,C7,00,EF,00,CF,00,EF,00,EF,00,EF,00,FF,00,EF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,FF,00,C1,05,00,FF,00,A8,70,F1,C1,80,80,B6,00,FF,00,FF,00,FF,00,FF,00,FF,20,FE,C0,FF,80,FF,00,
                        00,00,00,00,00,00,E4,E4,59,FF,37,C8,7F,80,1F,E0,00,00,00,00,00,00,E4,E4,FF,59,FF,00,FF,00,FF,00,
                        00,00,00,00,00,00,C0,40,A0,60,90,70,98,28,FC,04,00,00,00,00,00,00,C0,40,E0,20,F0,10,F8,08,FC,04,
                        4F,1F,41,8E,E8,EB,1C,1C,1F,3F,F0,FF,BC,BF,13,03,FF,0F,7F,00,17,00,E3,00,C0,00,00,00,40,00,FC,00,
                        B2,B0,22,20,85,01,81,01,9F,07,73,80,79,86,04,FF,4F,00,DF,00,FE,00,FE,00,F8,00,FF,00,FF,00,FF,04,
                        0C,0F,06,07,03,03,00,00,00,00,00,00,00,00,00,00,0F,0C,07,06,03,03,00,00,00,00,00,00,00,00,00,00,
                        4F,FF,FB,FF,E4,FB,8F,F0,D7,E8,A1,C0,E0,F0,B8,C0,F4,4F,C0,FF,80,FB,00,F0,00,F9,00,FF,00,FF,00,FF,
                        C9,3E,FB,5C,FB,3C,BF,7E,FF,FF,37,E0,C0,C0,01,01,07,F8,0F,F8,1F,F8,3F,FE,7F,FF,FF,20,FF,C0,FE,00,
                        72,72,00,00,20,00,71,80,3F,C0,7C,83,F8,06,FC,00,8D,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        31,E0,70,E0,E1,81,A3,03,26,07,B6,87,65,07,D6,02,FF,20,FF,60,FE,80,FC,00,F8,00,78,00,F8,00,FD,00,
                        83,0E,CD,0C,C3,00,F6,01,FC,03,D8,07,B8,07,F0,0F,F1,00,F3,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        20,E0,0C,BC,A0,0F,B0,30,BB,FF,01,FF,6A,60,52,0D,E0,20,FC,0C,FF,00,CF,00,00,00,00,00,9F,00,FF,00,
                        81,FE,D0,FF,ED,FF,FF,FF,7F,FF,13,FF,F1,0F,9F,01,FF,80,FF,D0,FF,ED,7F,FF,01,FF,00,FF,00,FF,00,FF,
                        00,00,00,00,00,00,7F,7F,81,FF,09,FE,E6,FD,FD,FE,00,00,00,00,00,00,7F,7F,FF,81,FF,08,FF,E4,FF,FC,
                        FC,A7,FC,C7,81,E0,FC,C3,C2,FF,8C,FB,D7,F8,3C,FB,D8,80,F8,C0,7F,80,7F,C0,7D,C2,F0,8F,E0,DC,E0,3F,
                        6C,18,0C,0C,EE,EE,F3,FF,F9,FF,5E,5F,57,87,1B,E3,E7,00,F3,00,11,00,00,00,00,00,A0,00,F8,00,FC,00,
                        BB,F1,A5,E3,33,F1,79,F9,7B,F9,FB,F9,E3,E1,9F,03,0F,01,1D,01,0F,01,07,01,07,01,07,01,1F,01,FF,03,
                        ED,F1,F7,F9,FA,7C,1A,FC,E9,1E,39,0E,EC,1E,2D,5E,FE,E0,3E,F0,1F,F8,07,F8,0F,F8,07,F8,07,FC,07,FC,
                        02,02,00,00,80,00,C8,00,FD,81,F3,03,0A,0A,A0,A0,FD,00,FF,00,FF,00,FF,00,FE,80,FC,00,F5,00,5F,00,
                        00,00,05,00,7E,00,E8,14,C0,30,09,81,76,77,AC,E7,FF,00,FF,00,FF,00,FF,00,FF,00,FE,00,88,00,18,00,
                        00,00,05,00,7E,00,E8,14,C0,30,09,81,76,77,AC,E7,FF,00,FF,00,FF,00,FF,00,FF,00,FE,00,88,00,18,00,
                        D7,00,67,85,67,87,63,83,F3,03,F9,01,FC,00,FE,00,FF,00,FA,00,F8,00,FC,00,FC,00,FE,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,60,60,0E,EE,3E,9A,24,E0,F1,55,BA,07,00,00,00,00,60,60,FE,0E,67,02,1F,00,AA,00,F8,00,
                        E0,E0,1C,FC,85,7F,D0,87,D8,C7,6E,E0,26,E0,24,E0,E0,E0,FC,1C,FF,05,7F,00,3F,00,1F,00,1F,00,1F,00,
                        FE,FF,6F,7F,67,7F,31,3F,14,1B,12,1D,10,1D,31,38,C7,FE,43,7F,40,7F,00,3F,00,1F,00,1F,00,1F,00,3F,
                        06,F6,21,38,E7,0D,15,E4,CC,F4,E5,F9,F4,78,70,38,09,00,C7,00,F2,00,FB,00,7B,C0,3E,E0,1F,F0,3F,F0,
                        55,38,10,3F,32,7F,36,FF,EC,FE,FE,FD,F8,FE,BA,FC,1F,F0,1F,F0,1D,F2,18,F7,38,EF,F8,FF,F0,FF,F0,BF,
                        00,00,00,00,03,03,07,05,FD,FC,82,7A,72,C2,D1,83,00,00,00,00,03,03,07,05,FF,FC,FD,00,3D,00,7C,00,
                        98,FC,CE,FE,CE,FE,4C,7C,AC,BC,BC,BC,39,39,38,38,03,00,01,00,01,00,83,00,43,00,43,00,C6,00,C7,00,
                        7B,78,74,74,FD,7C,B6,AE,B2,8E,79,1D,F3,CF,BC,BC,87,00,8B,00,83,00,51,00,71,00,E2,00,30,00,43,00,
                        07,07,0E,0F,18,18,1A,1B,8F,8F,A1,81,71,B8,89,98,F8,00,F0,00,E7,00,E4,00,70,00,7E,00,47,00,67,00,
                        F7,87,14,E0,7F,80,60,87,58,98,4D,8F,67,87,72,82,78,00,FF,00,FF,00,FF,00,E7,00,F0,00,F8,00,FD,00,
                        EF,E4,CF,C0,EE,EB,E2,E1,A6,A1,0C,03,09,06,7B,04,1B,00,3F,00,15,00,1F,00,5F,00,FF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,B0,B0,07,7F,C0,C7,54,F5,00,00,00,00,00,00,00,00,B0,B0,FF,07,3F,00,0B,00,
                        00,00,00,00,00,00,E0,E0,20,F0,04,3C,00,FE,38,01,00,00,00,00,00,00,E0,E0,F0,20,FC,04,FE,00,FF,00,
                        00,00,00,00,80,80,80,80,80,80,00,80,C0,C0,40,C0,00,00,00,00,80,80,80,80,80,80,80,00,C0,C0,C0,40,
                        03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,00,03,03,01,01,00,00,00,00,00,00,00,00,00,00,00,00,
                        4F,B1,03,FC,BD,FE,AE,5F,4F,0F,AA,17,0E,13,93,07,FE,00,FF,00,1F,FC,07,FE,03,BF,03,5E,03,FE,01,FF,
                        FA,02,7A,82,3C,C0,00,FF,FD,C2,EF,E0,F0,E0,FC,D8,FD,00,FD,00,FF,00,FF,00,FF,C0,7F,E0,7F,E0,67,C0,
                        78,80,16,E8,01,FE,A0,FF,78,7F,1C,1F,0E,0F,02,03,FF,00,FF,00,FF,00,FF,A0,7F,78,1F,1C,0F,0E,03,02,
                        02,03,02,03,03,03,01,01,01,01,02,03,02,03,02,03,03,02,03,02,03,03,01,01,01,01,03,02,03,02,03,02,
                        07,06,CF,F9,F9,F0,EF,0E,26,3E,E4,FC,9C,1C,81,04,07,06,FF,C9,FF,F0,F1,00,C1,00,03,00,E3,00,FB,00,
                        7E,1E,BE,86,F8,38,F8,F8,1C,04,EE,E6,DC,C4,E8,68,FE,1E,7E,06,F8,38,F8,F8,FC,04,1E,06,3C,04,F8,68,
                        49,B0,53,AF,1E,E0,1F,E0,BE,40,BF,41,EC,00,49,00,FF,00,FF,03,FF,00,FF,00,FF,00,FE,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
}


;;; $AC7D: Crocomire tiles ;;;
{
; Pointed to by table $A4:9C19

; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |      33|        |8BFFFBBB|8BBB    |   BBA9B|A4443335|FF555445|FF      | 5533345|        |        |        |        |        |
; |        |55F     |55333623|        |9BF6FBA9|9A9AABBB|BBBA99BF|43444445|55F5444 |FF      | 5333445|        |        |        |        |        |
; |       6|5465F   |65433223|        |955FFFAA|AFA99BAA|99B99BFF|44644545|44544  5|        |3 333343|        |        |        |        |        |
; |      FF|55556F  |65443223|B       |A5555FBA|A5AF89AB|89B9AFFF|566655  |33544  5|        |43333344|        |        |        |        |        |
; |     FF6|533566F |66534323|B       |A66555FB|44A58AFF|8ABBFFFF|55666   |3344  43|F       |43334344|        |        |        |        |        |
; |     F66|5545465F|66534333|B       |F6565444|33A49AF6|8BB66F54|  565   |3443 344|FF      |44344445|        |        |        |        |        |
; |     FF6|43355555|F6444333|A       |FF664444|24339AF6|966FF444|  55    |3444 334|F       |54444445|        |        |        |        |        |
; |    FF65|44343445|F6544333|9B      |FF666444|42349855|A5544444|  5     |2454 324|        |55445555|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; | 6666666|56655555|24433445|43455554|        |66555555|66544444|5554444 |        |66555555|35565665|        |        |        |        |        |
; |66666444|56666666|33444433|43466655|        |66665555|65544444|   5444 |       6|66665555|55565656|        |        |        |        |        |
; |65644444|66566666|33444533|54466665|       F|F6F66555|65554444|    555 |      66|F6F66555|53666655|        |        |        |        |        |
; |66555555|65455466|34445 34|66665554|     BBB|FFF66666|FF555445|     565|      66|FFF66666|45666655|        |        |        |        |        |
; |65456F65|66466465|34445  4|56555554|      AF|BBFFF555|FFFF5555|     664|     56F|BBFFF555|55656555|        |        |        |        |        |
; |554FF554|66666666|34445  3|55554456|      9B|ABBBFF45|55555554|    4445|3   45F |ABBBFF45|56656555|        |        |        |        |        |
; |556F4444|FFF66F66|44544  3|44434455|     BAB|AABBFF54|44444445|   43334|4   5544|AABBFF54|66555545|        |        |        |        |        |
; |55F54554|  FFFFF5|45 44  3|54443444|    BBAB|99BBF533|4433434 |  432345|44  5543|99BBF533|65545445|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |66666F  |55554566|66      |        |BBF     |        |45 533 3|     444|  6 6   |43455554|445F5525|        |        |        |        |        |
; |446646  |666556BB|4FF     |3245    |BF6     |        |45  33 4|     443| 666F   |43466655|6FF54535|        |        |        |        |        |
; |54554   |F6FFFBBA|56FF    |445     |B6FF    |        |45  33 3|     433| 6FF5   |54466665|55443555|        |        |        |        |        |
; |55554   |F6FFF6B9|55FF    |56      |666BA   |        |45  43 2|645 4433| F554   |66665554|55535355|        |        |        |        |        |
; |44432   |566FFFAA|546F    |6       |66FBB   |F       |5    5 2|445  543| 5544   |56555554|55435445|        |        |        |        |        |
; |44322222|6566FBBA|3566    |        |6FBBA   |5       |5    533|445  544|5443    |55554456|55345444|        |        |        |        |        |
; |44443345|665F6FAB|445FF   |        |6FFBB   |F       |5    552|335   32|4234    |44434455|54455544|        |        |        |        |        |
; |55445456|6666FFAB|4456F   |        |5FF9ABB |FF      |     333|325  423|224554  |54443444|44555545|        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |        |        |     FF5|        |FFF65444|FA665555|4555F   |33332335|  533345|2454 325|        |        |        |        |        |        |
; |        |        |     FF6|        | FF66544|FF666656|3444F   |33232344|  453543|2455 435|        |        |        |        |        |        |
; |        |        |      F6|      55| FF66655| FF66666|34555F  |44422334|  345434|33554435|        |        |        |        |        |        |
; |        |    FFFF|      6F|     565| F F6655| FFF6F66|334455FF|43223333|  334334|34654435|F       |        |        |        |        |        |
; |        |   F6666|      FF|     645| F  F665|  FFFFFF|23434552|33323333|  243344|44655445|5       |        |        |        |        |        |
; |22      |   6666F|      F |     635|    FF66|  F   FF|24333533|44333333|  243344|66555435|5F      |        |        |        |        |        |
; |4       |   FFF66|        |      35|    FFF6|      FF|23333555|44533344|  343344|55555444|5F      |        |        |        |        |        |
; |      5 |   FFFFF|        |      33|    F F6|        |34434555|44554455| 3433345|44555545|5F      |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    6655|        |F6F66FAB|   FFBBB|4A9666FB|4442499A| F655435|45F     |335 5554|44  4442|        |        |        |        |        |        |
; |    F665|        |FFFF65A5|    FBAB|4A85555F|5544258A| F665435|52F     |53366654|44  5443|        |        |        |        |        |        |
; |    F665|        |F FFF666|    FBAA|4A844455|6655449A| FF65435|45F     |55665555|44  5444|        |        |        |        |        |        |
; |    F666|FFFFFF  |    FFF6|     BBA|449A3334|6665549A|  F65432|44F     |45665544|455 5554|        |        |        |        |        |        |
; |    F656|66F6F6FF|     FFF|      BA|548A3433|666559A9|  F64433|45F     |45565433|555 5555|        |        |        |        |        |        |
; |    F656|66566556|      FF|      BA|55954443|F6665943| F654435|45F     |45565443|55555455|        |        |        |        |        |        |
; |    F6FF|F5665555|      FF|      BA|6AA44444|FF65AA43| F655435|45F     |44565544|55554555|        |        |        |        |        |        |
; |    FFFF|F6566655|       F|     BBA|6AA55544| F65A545| F655435|5FF     |23565554|55555556|        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|
; |    535 |        |FF6F6666|        |B    AF6|45ABBA9A|  33 459|        |333455FF|235554  |        |        |        |        |        |        |
; |    F555|        |BFFFF6F6|        |9A  8AF6|B9955A99|  33 43A|   FF66F|54434555|345655  |        |        |        |        |        |        |
; |BBBB6644|        |BBBFFF6F|        |9898ABF6|98B455AB|  33 3 A| FFFFFF5|55555FFF|455655  |        |        |        |        |        |        |
; |989BF555|F       |AABBFFFF|        |A98AABF6|9BB35559|  53 4 5|F5F55543|666FFFFF|556655  |        |        |        |        |        |        |
; |99BBF666|66FFFFFF|9AAABBBB|        |B989BF6F|B4333459|   3 445|F4544322|44444455|566555  |        |        |        |        |        |        |
; |899F666 |55556666|A9AAAABA|        |F89BFFFF| 345334A|   4 42 |43433322|32333345|666555  |        |        |        |        |        |        |
; |8ABFF6B |55523554|A8A9999A|F       |59ABFFFB| 534534A|   4 4  |43454433|33333455|66655555|        |        |        |        |        |        |
; |8BF66FB |55535454|88998899|6F      |49AF6FFB|  345349|   5    |42354444|4345FF4F|66655555|        |        |        |        |        |        |
; |--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|--------|

$A4:AC7D             db 00,00,00,00,00,01,03,03,06,07,04,07,06,07,0D,0E,00,00,00,00,01,00,03,03,07,06,07,04,07,06,0F,0C,
                        00,00,E0,20,98,28,F4,0C,F2,6E,D3,05,7F,60,29,28,00,00,E0,20,F8,08,FC,04,9E,02,FF,01,9F,00,D7,00,
                        03,03,F9,3F,59,9F,49,8F,35,D7,37,D7,87,C7,A7,C7,00,00,C4,00,E0,00,F0,00,E8,00,E8,00,F8,80,F8,80,
                        00,00,00,00,00,00,80,80,80,80,80,80,00,80,C0,40,00,00,00,00,00,00,00,80,00,80,00,80,00,80,00,C0,
                        7F,7F,ED,7E,FC,1F,7E,87,1F,E3,A8,D0,C0,F0,C0,F8,38,FF,38,EF,7C,9F,7C,87,7E,83,FF,80,FF,C0,FF,C0,
                        70,70,A7,5F,5C,E7,55,B3,13,27,CA,E7,3A,B7,2B,60,00,F0,00,FF,40,FF,50,BF,D3,2F,13,2E,43,0E,93,0C,
                        1B,1D,EF,F3,FF,27,77,2F,3F,7F,66,7C,98,78,60,80,00,1F,01,FF,03,FF,07,FF,0F,FF,1F,E4,7F,98,7F,80,
                        0F,8E,41,40,05,20,8C,70,C0,38,28,10,30,00,20,00,71,80,BF,00,FF,00,FC,00,F8,00,38,00,30,00,20,00,
                        F9,C0,F0,20,21,00,E1,C0,C1,C1,94,94,86,86,24,86,FF,C0,FE,20,F9,00,39,00,32,00,63,00,71,00,71,00,
                        C0,C0,C0,C0,00,00,00,00,80,80,C0,C0,80,80,00,00,C0,C0,C0,C0,00,00,00,00,80,80,C0,C0,80,80,00,00,
                        7D,1C,79,38,BD,BD,7C,7C,74,74,21,20,81,00,CF,00,63,00,47,00,02,00,83,00,8B,00,DF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,7F,00,F8,40,A0,3F,C0,55,8E,DE,18,D0,30,F6,20,7F,00,FF,00,FF,00,FF,00,FF,04,FF,18,FF,10,FF,20,
                        9F,60,80,7F,20,DF,58,83,01,DA,00,FF,E4,FF,3F,3E,FF,00,FF,00,FF,00,FF,00,FF,00,FF,00,FF,E4,3F,3E,
                        19,98,C3,C3,C7,C3,8A,82,88,80,89,81,21,01,41,01,67,00,3C,00,3C,00,79,00,79,00,78,00,F8,00,D8,00,
                        5E,40,43,5C,81,1E,0E,F0,BE,40,F2,01,13,10,88,08,BF,00,BF,00,FF,00,FF,00,FF,00,FF,00,EF,00,F7,00,
                        00,00,00,00,01,01,07,07,01,03,03,01,05,07,0D,0F,00,00,00,00,01,01,00,07,01,03,00,03,00,07,00,0F,
                        3F,C0,0F,F0,A7,F8,E0,FF,FF,F8,7D,FC,3E,FC,FF,3B,FF,00,FF,00,FF,A0,FF,E0,3F,F8,0F,FC,0F,FC,0C,F8,
                        20,C0,60,80,70,80,F9,C0,FF,F0,FE,00,01,00,34,34,FF,00,FF,00,FF,00,FF,C0,FF,F0,FF,00,FF,00,CA,00,
                        E0,00,10,00,0E,00,05,02,00,06,01,00,0E,0E,15,1C,FE,00,1E,00,0E,00,07,00,07,00,0F,00,11,00,23,00,
                        00,00,00,01,00,03,00,03,05,03,86,82,0C,00,0D,01,00,00,01,00,03,00,03,00,07,01,0E,02,8F,00,CE,00,
                        3F,C0,0F,F0,A7,F8,E0,FF,FF,F8,7D,FC,3E,FC,FF,3B,FF,00,FF,00,FF,A0,FF,E0,3F,F8,0F,FC,0F,FC,0C,F8,
                        E9,96,EA,15,C3,7C,43,3C,D7,28,97,68,3D,C0,69,80,7F,00,FF,00,BF,00,FF,00,FF,00,FF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        04,FC,00,34,B0,00,F0,00,10,18,20,3F,0D,0C,CA,01,FC,04,FC,00,F8,00,F8,00,E0,00,C0,00,F3,00,FF,00,
                        F4,03,1B,E7,BE,FF,BB,FE,9C,7F,4E,BF,35,DF,0D,FF,FF,00,FC,03,F8,BF,FC,BB,FC,1F,F8,0F,FC,17,FC,0F,
                        00,C0,60,60,B0,70,F0,30,90,30,C0,B0,38,18,28,18,C0,00,E0,60,F0,30,F0,30,F0,10,70,00,F8,18,F8,08,
                        00,00,90,C0,20,00,80,40,00,80,00,00,00,00,00,00,00,00,30,00,E0,00,C0,00,80,00,00,00,00,00,00,00,
                        E0,E0,C0,E0,B0,F0,10,F8,38,F8,70,F8,78,F8,F6,6E,20,E0,60,C0,70,B0,E0,18,E0,38,C0,78,E0,78,E0,7E,
                        00,00,00,00,00,00,00,00,80,80,80,00,80,80,C0,C0,00,00,00,00,00,00,00,00,80,80,80,00,80,80,C0,C0,
                        5D,0D,4C,0C,4D,0D,44,05,84,01,87,03,86,01,07,07,D0,00,C1,00,C0,00,C8,00,84,00,84,00,86,00,00,00,
                        00,00,01,01,03,03,23,83,25,01,24,00,E2,C3,A1,C3,07,00,06,00,04,00,EC,00,E6,00,E7,00,20,00,24,00,
                        00,28,08,78,38,70,70,40,60,00,90,10,20,60,18,C0,28,00,78,08,78,30,78,40,78,00,E0,00,90,00,3C,00,
                        5E,40,43,5C,81,1E,0E,F0,BE,40,F2,01,13,10,88,08,BF,00,BF,00,FF,00,FF,00,FF,00,FF,00,EF,00,F7,00,
                        3D,12,77,E2,CF,08,FF,14,D9,10,E8,20,9C,00,3D,00,FD,10,FD,60,F7,00,EB,00,EF,00,DF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,C0,00,00,02,00,00,00,00,00,00,00,00,00,00,00,00,00,80,00,02,00,
                        00,00,00,00,00,00,0F,0F,10,1F,01,1F,1C,1F,1F,1F,00,00,00,00,00,00,0F,0F,1F,10,1F,01,1F,1C,1F,1F,
                        07,06,06,07,02,03,01,03,03,03,02,02,00,00,00,00,07,06,07,06,03,02,03,01,03,03,02,02,00,00,00,00,
                        00,00,00,00,03,00,05,02,01,04,03,06,03,02,03,03,00,00,00,00,03,00,07,00,07,00,05,00,01,00,00,00,
                        E8,F0,64,78,63,7C,53,5C,49,4E,0C,0F,0E,0F,0A,0B,FF,E0,7F,60,7F,60,5F,50,4F,48,0F,0C,0F,0E,0B,0A,
                        8F,F0,C2,FD,60,7F,74,7F,3F,3F,23,23,03,03,00,00,BF,C0,FF,C0,7F,60,7F,74,3F,3F,23,23,03,03,00,00,
                        78,08,88,88,BC,84,CF,C3,56,D1,3F,BB,7F,F8,97,90,F8,08,78,08,7C,04,3F,03,2E,00,44,00,07,00,6F,00,
                        F7,FE,D4,FC,06,1E,4F,7F,EF,FF,3F,3F,3C,1C,33,00,01,00,03,00,E1,00,80,00,00,00,C0,00,E3,00,FF,00,
                        3D,1C,1D,09,2A,22,36,36,0C,2C,0C,2C,2C,2C,5D,5C,23,00,36,00,1D,00,09,00,13,00,13,00,13,00,23,00,
                        25,86,33,82,F3,C2,93,A2,19,20,3B,C2,F8,00,3D,00,71,00,75,00,3D,00,7D,00,FF,00,FD,00,FF,00,FF,00,
                        00,00,00,00,00,00,80,80,80,00,C0,40,C0,40,C0,40,00,00,00,00,00,00,80,80,80,00,C0,40,C0,40,C0,40,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        03,0C,09,0E,09,0E,08,0F,0A,0D,0A,0D,0B,0F,0F,0F,0F,00,0F,08,0F,08,0F,08,0F,08,0F,08,0F,0B,0F,0F,
                        00,00,00,00,00,00,FC,FC,2B,FF,26,D9,CF,B0,A3,DC,00,00,00,00,00,00,FC,FC,FF,2B,FF,00,FF,80,FF,80,
                        A5,FF,F5,FA,B8,BF,0E,0F,07,07,03,03,03,03,01,01,FC,A7,FD,F2,BF,B8,0F,0E,07,07,03,03,03,03,01,01,
                        1F,1F,0D,0F,0C,0F,06,07,02,03,02,03,02,03,06,07,18,1F,08,0F,08,0F,00,07,00,03,00,03,00,03,00,07,
                        23,5F,1F,41,03,40,2E,1E,8B,1B,F1,01,00,E0,1C,E0,9E,63,9F,61,9F,60,C1,30,C4,30,DE,20,9F,60,9F,60,
                        06,11,C4,09,32,C1,1A,E1,1D,E2,8D,F1,D1,ED,55,68,E8,07,F4,03,FC,03,FC,03,F8,07,FA,84,F2,CC,77,48,
                        5B,62,4B,72,6B,72,2A,33,23,33,53,62,5B,62,5B,62,7D,40,7D,40,7D,60,3C,20,3C,20,7D,40,7D,40,7D,40,
                        60,20,A0,60,60,20,20,20,60,20,60,20,60,20,E0,60,E0,20,A0,20,E0,20,E0,20,E0,20,E0,20,E0,20,E0,60,
                        EE,C0,E2,7C,CF,30,4C,30,6B,13,69,11,2C,10,6E,D0,2F,00,9F,00,FF,00,FF,00,FC,00,FE,00,FF,00,3F,00,
                        00,01,09,01,08,00,6E,00,EF,00,FB,00,F7,00,FE,01,CE,00,CE,00,CF,00,EF,00,EF,00,FF,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        0E,04,0F,08,F0,FC,BF,18,F8,3F,70,1E,3A,7E,66,7E,0A,00,0F,08,0F,F0,0F,F8,0F,F8,1E,F0,1C,FA,3C,E6,
                        00,00,00,00,00,00,80,80,3F,FF,F0,0F,EE,18,FA,10,00,00,00,00,00,00,80,80,FF,3F,FF,00,E7,00,EF,00,
                        D0,FF,FA,FF,FD,FF,3F,FF,8F,7F,42,BF,1E,A1,33,00,FF,D0,7F,FA,1F,FD,0F,FF,00,FF,00,FF,00,FF,00,FF,
                        00,00,00,00,00,00,00,00,00,00,00,00,80,80,40,C0,00,00,00,00,00,00,00,00,00,00,00,00,80,80,C0,40,
                        82,87,82,47,A6,0F,46,9F,DD,8F,BF,9F,DF,3F,57,3F,03,86,03,CE,03,FE,03,FE,07,FD,8F,FF,8E,7F,9E,77,
                        5A,3D,FB,84,AD,23,FF,70,BB,B8,5C,4D,6C,25,2D,24,C0,3F,18,E7,1C,E3,0E,E1,46,81,32,01,5A,01,1A,01,
                        33,30,32,33,34,35,31,10,11,10,00,02,00,00,10,00,06,01,04,01,00,01,25,00,07,00,14,00,14,00,10,00,
                        00,00,19,1F,7F,7E,FD,A1,A4,87,5C,5F,53,43,30,60,00,00,1F,19,7F,7E,FE,A0,F8,80,A0,00,BC,00,9F,00,
                        EF,E3,97,10,FF,07,1F,FF,03,00,BD,FC,FB,F8,5D,4D,1F,03,EF,00,FF,07,FF,1F,FF,00,03,00,07,00,BF,0D,
                        78,C0,AC,90,6C,10,CC,30,9C,60,1C,E0,1F,E0,1F,E0,3C,00,7C,00,FC,00,FC,00,FC,00,FC,00,FF,00,FF,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,
                        00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
}


;;; $B87D: Palette - enemy $DDBF/$DDFF (Crocomire) ;;;
{
$A4:B87D             dw 3800, 7FFF, 0DFF, 08BF, 0895, 086C, 0447, 6B7E, 571E, 3A58, 2171, 0CCB, 039F, 023A, 0176, 0000
}


;;; $B89D: Crocomire palettes ;;;
{
$A4:B89D             dw 0000, 7FFF, 0DFF, 08BF, 0895, 086C, 0447, 6B7E, 571E, 3A58, 2171, 0CCB, 039F, 023A, 0176, 0000 ; BG1/2 palette 7
$A4:B8BD             dw 3800, 571E, 6318, 6318, 6318, 6318, 6318, 4A7B, 1C90, 1469, 1424, 0008, 24BF, 2495, 1C6C, 1045 ; Sprite palette 2
$A4:B8DD             dw 3800, 7F5A, 033B, 0216, 0113, 7C1D, 5814, 300A, 3BE0, 2680, 1580, 5294, 39CE, 2108, 2484, 03E0 ; Sprite palette 5. Changes colour Fh from 7D08h to 3E0h, no observable difference
$A4:B8FD             dw 3800, 7FFF, 6B7E, 571E, 3A58, 2171, 0CCB, 6B7E, 571E, 3A58, 2171, 0CCB, 039F, 023A, 0176, 0000 ; Sprite palette 1
$A4:B91D             dw 3800, 02DF, 01D7, 00AC, 5A73, 41AD, 2D08, 1863, 0BB1, 48FB, 7FFF, 0000, 7FFF, 44E5, 7FFF, 0000 ; Sprite palette 3
}


;;; $B93D: Enemy touch - Crocomire - claws ;;;
{
; Used for some other hitboxes, but those are placed behind Crocomire's invisible wall ($8C95)
$A4:B93D 22 77 A4 A0 JSL $A0A477[$A0:A477]  ; Normal enemy touch AI
$A4:B941 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:B944 09 00 40    ORA #$4000             ;} $0FAA |= 4000h (Samus hit by claw)
$A4:B947 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:B94A A9 FC FF    LDA #$FFFC             ;\
$A4:B94D 8D 58 0B    STA $0B58  [$7E:0B58]  ;} Extra Samus X displacement = -4
}


;;; $B950: RTL. Enemy touch - enemy $DDBF (Crocomire) ;;;
{
$A4:B950 6B          RTL
}


;;; $B951: Enemy shot - Crocomire - nothing ;;;
{
; Used for the claws during (most of) Crocomire's projectile attack, used for the lower half of Crocomire's body
; This function has no effect, as the low byte of $0FAA is never meaningfully read
; Looks like it was supposed to be a normal increment operation up to a cap of Fh,
; but fails to be one because it doesn't mask off the existing bits before doing the OR
$A4:B951 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:B954 29 0F 00    AND #$000F             ;|
$A4:B957 C9 0F 00    CMP #$000F             ;|
$A4:B95A 10 01       BPL $01    [$B95D]     ;|
$A4:B95C 1A          INC A                  ;|
                                            ;} Crocomire fight flags |= min(Fh, ([Crocomire fight flags] & Fh) + 1)
$A4:B95D 85 12       STA $12    [$7E:0012]  ;|
$A4:B95F AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;|
$A4:B962 05 12       ORA $12    [$7E:0012]  ;|
$A4:B964 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;/
$A4:B967 6B          RTL
}


;;; $B968: Enemy shot - Crocomire - spawn shot explosion ;;;
{
$A4:B968 DA          PHX
$A4:B969 5A          PHY
$A4:B96A AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A4:B96D 0A          ASL A                  ;} X = (collided projectile index)
$A4:B96E AA          TAX                    ;/
$A4:B96F BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$A4:B972 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile X position]
$A4:B974 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$A4:B977 85 14       STA $14    [$7E:0014]  ;} $14 = [projectile Y position]
$A4:B979 BD 18 0C    LDA $0C18,x[$7E:0C18]
$A4:B97C A0 1D 00    LDY #$001D             ; A = 1Dh (big explosion)
$A4:B97F 89 00 02    BIT #$0200             ;\
$A4:B982 D0 03       BNE $03    [$B987]     ;} If [projectile type] & 200h = 0 (beam or missile or bomb):
$A4:B984 A0 06 00    LDY #$0006             ; A = 6 (dud shot)

$A4:B987 98          TYA
$A4:B988 A0 09 E5    LDY #$E509             ;\
$A4:B98B 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:B98F 7A          PLY
$A4:B990 FA          PLX
$A4:B991 6B          RTL
}


;;; $B992: Power bomb reaction - enemy $DDBF (Crocomire) ;;;
{
$A4:B992 AD A8 0F    LDA $0FA8  [$7E:0FA8]  ;\
$A4:B995 D0 6D       BNE $6D    [$BA04]     ;} If [Crocomire death sequence index] != 0: return
$A4:B997 AD 9E 86    LDA $869E  [$A4:869E]  ;\
$A4:B99A F0 68       BEQ $68    [$BA04]     ;} If 3 = 0: return (>_<;)
$A4:B99C 8D AE 0F    STA $0FAE  [$7E:0FAE]  ; Crocomire step forward counter = 3
$A4:B99F AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A4:B9A2 C9 18 00    CMP #$0018             ;} If [Crocomire fight function index] = 18h (power bombed charge): return
$A4:B9A5 F0 5D       BEQ $5D    [$BA04]     ;/
$A4:B9A7 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:B9AA 29 F0 BF    AND #$BFF0             ;} Crocomire fight flags &= ~400Fh (Samus not hit by claw)
$A4:B9AD 09 00 80    ORA #$8000             ;\
$A4:B9B0 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags |= 8000h (awake)
$A4:B9B3 A9 0A 00    LDA #$000A             ;\
$A4:B9B6 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} $0FB0 = Ah
$A4:B9B9 AD 9C 0F    LDA $0F9C  [$7E:0F9C]  ;\
$A4:B9BC 18          CLC                    ;|
$A4:B9BD 69 04 00    ADC #$0004             ;} Crocomire flash timer += 4
$A4:B9C0 8D 9C 0F    STA $0F9C  [$7E:0F9C]  ;/
$A4:B9C3 AD 8A 0F    LDA $0F8A  [$7E:0F8A]  ;\
$A4:B9C6 09 02 00    ORA #$0002             ;} Crocomire AI handler = hurt AI
$A4:B9C9 8D 8A 0F    STA $0F8A  [$7E:0F8A]  ;/
$A4:B9CC A9 18 00    LDA #$0018             ;\
$A4:B9CF 8D AC 0F    STA $0FAC  [$7E:0FAC]  ;} Crocomire fight function index = 18h (power bombed charge)
$A4:B9D2 AE 8E 0F    LDX $0F8E  [$7E:0F8E]  ; X = [spritemap pointer]
$A4:B9D5 BD 00 00    LDA $0000,x            ;\
$A4:B9D8 85 12       STA $12    [$7E:0012]  ;} $12 = [[X]] (number of entries)

; LOOP
$A4:B9DA BD 06 00    LDA $0006,x            ; A = [[X] + 2 + 4] (spritemap pointer)
$A4:B9DD A0 AE BD    LDY #$BDAE             ; Crocomire instruction list pointer = $BDAE (power bomb reaction - mouth fully open)
$A4:B9E0 C9 00 D6    CMP #$D600             ;\
$A4:B9E3 F0 15       BEQ $15    [$B9FA]     ;} If (spritemap pointer) != $D600 (mouth fully open):
$A4:B9E5 A0 B2 BD    LDY #$BDB2             ; Crocomire instruction list pointer = $BDB2 (power bomb reaction - mouth partially open)
$A4:B9E8 C9 1C D5    CMP #$D51C             ;\
$A4:B9EB F0 0D       BEQ $0D    [$B9FA]     ;} If (spritemap pointer) != $D51C (mouth partially open):
$A4:B9ED 8A          TXA                    ;\
$A4:B9EE 18          CLC                    ;|
$A4:B9EF 69 08 00    ADC #$0008             ;} X += 8 (next spritemap entry)
$A4:B9F2 AA          TAX                    ;/
$A4:B9F3 C6 12       DEC $12    [$7E:0012]  ; Decrement $12
$A4:B9F5 D0 E3       BNE $E3    [$B9DA]     ; If [$12] != 0: go to LOOP
$A4:B9F7 A0 B6 BD    LDY #$BDB6             ; Crocomire instruction list pointer = $BDB6 (power bomb reaction - mouth not open)

$A4:B9FA 98          TYA
$A4:B9FB 8D 92 0F    STA $0F92  [$7E:0F92]
$A4:B9FE A9 01 00    LDA #$0001             ;\
$A4:BA01 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Crocomire instruction timer = 1

$A4:BA04 6B          RTL
}


;;; $BA05: Enemy shot - Crocomire - open mouth ;;;
{
$A4:BA05 A9 00 00    LDA #$0000             ;\
$A4:BA08 8D A0 0F    STA $0FA0  [$7E:0FA0]  ;} Crocomire invincibility timer = 0
$A4:BA0B AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A4:BA0E 38          SEC                    ;|
$A4:BA0F ED 82 0F    SBC $0F82  [$7E:0F82]  ;|
$A4:BA12 38          SEC                    ;|
$A4:BA13 E9 00 01    SBC #$0100             ;} If (Crocomire left boundary) >= [layer 1 X position] + 100h: go to BRANCH_OFF_SCREEN
$A4:BA16 38          SEC                    ;|
$A4:BA17 ED 11 09    SBC $0911  [$7E:0911]  ;|
$A4:BA1A 10 44       BPL $44    [$BA60]     ;/
$A4:BA1C AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A4:BA1F 0A          ASL A                  ;} X = (collided projectile index)
$A4:BA20 AA          TAX                    ;/
$A4:BA21 BD 18 0C    LDA $0C18,x[$7E:0C18]  ;\
$A4:BA24 89 00 0F    BIT #$0F00             ;} If (projectile type) = beam:
$A4:BA27 D0 14       BNE $14    [$BA3D]     ;/
$A4:BA29 AE 98 86    LDX $8698  [$A4:8698]  ; X = 2
$A4:BA2C 89 10 00    BIT #$0010             ;\
$A4:BA2F D0 22       BNE $22    [$BA53]     ;} If projectile is charged beam: go to BRANCH_DAMAGE
$A4:BA31 AD A0 86    LDA $86A0  [$A4:86A0]  ;\
$A4:BA34 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Crocomire instruction timer = 8
$A4:BA37 AE 96 86    LDX $8696  [$A4:8696]  ; X = 0 (never read)
$A4:BA3A 4C B4 BA    JMP $BAB4  [$A4:BAB4]  ; Go to spawn shot explosion

$A4:BA3D 29 00 0F    AND #$0F00
$A4:BA40 AE 9A 86    LDX $869A  [$A4:869A]  ; X = 1
$A4:BA43 C9 00 01    CMP #$0100             ;\
$A4:BA46 F0 0B       BEQ $0B    [$BA53]     ;} If (projectile type) != missile:
$A4:BA48 AE 9C 86    LDX $869C  [$A4:869C]  ; X = 3
$A4:BA4B C9 00 02    CMP #$0200             ;\
$A4:BA4E F0 03       BEQ $03    [$BA53]     ;} If (projectile type) != super missile:
$A4:BA50 A2 00 00    LDX #$0000             ; Go to BRANCH_FLASH

; BRANCH_DAMAGE
$A4:BA53 8A          TXA
$A4:BA54 C9 00 00    CMP #$0000
$A4:BA57 F0 47       BEQ $47    [$BAA0]
$A4:BA59 18          CLC                    ;\
$A4:BA5A 6D AE 0F    ADC $0FAE  [$7E:0FAE]  ;} Crocomire step back counter += [X]
$A4:BA5D 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;/

; BRANCH_OFF_SCREEN
$A4:BA60 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:BA63 29 0F 00    AND #$000F             ;|
$A4:BA66 C9 0F 00    CMP #$000F             ;|
$A4:BA69 10 01       BPL $01    [$BA6C]     ;} $12 = min(Fh, ([Crocomire fight flags] & Fh) + 1)
$A4:BA6B 1A          INC A                  ;|
                                            ;|
$A4:BA6C 85 12       STA $12    [$7E:0012]  ;/
$A4:BA6E AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:BA71 89 00 08    BIT #$0800             ;} If [Crocomire fight flags] & 800h = 0 (not damaged):
$A4:BA74 D0 16       BNE $16    [$BA8C]     ;/
$A4:BA76 AE 92 86    LDX $8692  [$A4:8692]  ;\
$A4:BA79 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A4:BA7C C9 08 00    CMP #$0008             ;|
$A4:BA7F D0 03       BNE $03    [$BA84]     ;|
$A4:BA81 AE 94 86    LDX $8694  [$A4:8694]  ;|
                                            ;} Crocomire instruction timer += 8
$A4:BA84 8A          TXA                    ;|
$A4:BA85 18          CLC                    ;|
$A4:BA86 6D 94 0F    ADC $0F94  [$7E:0F94]  ;|
$A4:BA89 8D 94 0F    STA $0F94  [$7E:0F94]  ;/

$A4:BA8C AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A4:BA8F 29 F0 BF    AND #$BFF0             ;} Crocomire fight flags &= ~400Fh (Samus not hit by claw)
$A4:BA92 09 00 08    ORA #$0800             ; Crocomire fight flags |= 800h (damaged)
$A4:BA95 05 12       ORA $12    [$7E:0012]  ;\
$A4:BA97 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Crocomire fight flags |= [$12] (this low byte is never meaningfully read)
$A4:BA9A A9 0A 00    LDA #$000A             ;\
$A4:BA9D 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;} $0FB0 = Ah

; BRANCH_FLASH
$A4:BAA0 AD 9C 0F    LDA $0F9C  [$7E:0F9C]  ;\
$A4:BAA3 18          CLC                    ;|
$A4:BAA4 69 0E 00    ADC #$000E             ;} Crocomire flash timer += Eh
$A4:BAA7 8D 9C 0F    STA $0F9C  [$7E:0F9C]  ;/
$A4:BAAA AD 8A 0F    LDA $0F8A  [$7E:0F8A]  ;\
$A4:BAAD 09 02 00    ORA #$0002             ;} Crocomire AI handler = hurt AI
$A4:BAB0 8D 8A 0F    STA $0F8A  [$7E:0F8A]  ;/
$A4:BAB3 6B          RTL
}


;;; $BAB4: Enemy shot - Crocomire - spawn shot explosion ;;;
{
; Clone of $B968
; Used for claws
$A4:BAB4 DA          PHX
$A4:BAB5 5A          PHY
$A4:BAB6 AD A6 18    LDA $18A6  [$7E:18A6]  ;\
$A4:BAB9 0A          ASL A                  ;} X = (collided projectile index)
$A4:BABA AA          TAX                    ;/
$A4:BABB BD 64 0B    LDA $0B64,x[$7E:0B64]  ;\
$A4:BABE 85 12       STA $12    [$7E:0012]  ;} $12 = [projectile X position]
$A4:BAC0 BD 78 0B    LDA $0B78,x[$7E:0B78]  ;\
$A4:BAC3 85 14       STA $14    [$7E:0014]  ;} $14 = [projectile Y position]
$A4:BAC5 BD 18 0C    LDA $0C18,x[$7E:0C18]
$A4:BAC8 A0 1D 00    LDY #$001D             ; A = 1Dh (big explosion)
$A4:BACB 89 00 02    BIT #$0200             ;\
$A4:BACE D0 03       BNE $03    [$BAD3]     ;} If [projectile type] & 200h = 0 (beam or missile or bomb):
$A4:BAD0 A0 06 00    LDY #$0006             ; A = 6 (dud shot)

$A4:BAD3 98          TYA
$A4:BAD4 A0 09 E5    LDY #$E509             ;\
$A4:BAD7 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A4:BADB 7A          PLY
$A4:BADC FA          PLX
$A4:BADD 6B          RTL
}


;;; $BADE..BFC3: Crocomire instruction lists ;;;
{
;;; $BADE: Instruction list - Crocomire - initial ;;;
{
$A4:BADE             dx 0001,C2EC,
                        86A6,       ; Fight AI
                        80ED,BADE,  ; Go to $BADE
                        812F        ; Sleep
}


;;; $BAEA: Instruction list - Crocomire - charge forward one step (unused) ;;;
{
$A4:BAEA             dx 0008,BFC4,
                        8FC7,       ; Shake screen
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0008,BFF6,
                        8FDF,       ; Move left 4px
                        0008,C028,
                        8FDF,       ; Move left 4px
                        0008,C05A,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0008,C08C,
                        8FDF,       ; Move left 4px
                        0008,C0BE,
                        8FDF,       ; Move left 4px
                        0008,C0F0,
                        8FC7,       ; Shake screen
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0008,C122,
                        8FDF,       ; Move left 4px
                        0008,C154,
                        8FDF,       ; Move left 4px
                        0008,C186,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0008,C1B8,
                        8FDF,       ; Move left 4px
                        0008,C1EA,
                        86A6        ; Fight AI
}


;;; $BB36: Instruction list - Crocomire - projectile attack ;;;
{
$A4:BB36             dx 9AAA,       ; Spawn big dust cloud enemy projectile - X offset 10h
                        0005,C47A,
                        0005,C4AC,
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9A9B,       ; Spawn big dust cloud enemy projectile - X offset -20h
                        0005,C47A,
                        0005,C4AC,
                        9AA5,       ; Spawn big dust cloud enemy projectile - X offset -10h
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,C47A,
                        0005,C4AC,
                        9AC8,       ; Spawn big dust cloud enemy projectile - X offset 28h
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9AA5,       ; Spawn big dust cloud enemy projectile - X offset -10h
                        0005,C574,
                        8CFB,       ; Queue Crocomire's cry sound effect
                        0005,C5AE,
                        0005,C5E8
$A4:BB94             dx 86A6,       ; Fight AI
                        0008,C95C,
                        0007,C996,
                        0007,C9D0,
                        0007,CA0A,
                        0007,CA44,
                        80ED,BB94   ; Go to $BB94
}


;;; $BBAE: Unused. Instruction list ;;;
{
$A4:BBAE             dx 0004,C6A4,
                        8FC7,       ; Shake screen
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        86A6,       ; Fight AI
                        8752,       ; Maybe start projectile attack
                        0004,C6DE,
                        8FDF,       ; Move left 4px
                        86A6,       ; Fight AI
                        0004,C718,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        86A6        ; Fight AI
}


;;; $BBCA: Instruction list - Crocomire - step forward after delay ;;;
{
$A4:BBCA             dx 00B4,C6A4
}


;;; $BBCE: Instruction list - Crocomire - step forward ;;;
{
$A4:BBCE             dx 8752,       ; Maybe start projectile attack
                        0005,C574,
                        86A6,       ; Fight AI
                        0005,C5AE,
                        8CFB,       ; Queue Crocomire's cry sound effect
                        86A6,       ; Fight AI
                        0005,C5E8,
                        86A6,       ; Fight AI
                        0010,C752,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        86A6,       ; Fight AI
                        0004,C78C,
                        8FDF,       ; Move left 4px
                        86A6,       ; Fight AI
                        0004,C7C6,
                        8FDF,       ; Move left 4px
                        86A6,       ; Fight AI
                        0004,C800,
                        8FC7,       ; Shake screen
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        86A6,       ; Fight AI
                        0004,C83A,
                        8FDF,       ; Move left 4px
                        86A6,       ; Fight AI
                        0004,C874,
                        8FDF,       ; Move left 4px
                        86A6,       ; Fight AI
                        0004,C8AE,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        86A6,       ; Fight AI
                        0004,C8E8,
                        8FDF,       ; Move left 4px
                        86A6,       ; Fight AI
                        0004,C922,
                        86A6,       ; Fight AI
                        80ED,BBCE   ; Go to $BBCE
}


;;; $BC30: Instruction list - Crocomire - step back ;;;
{
$A4:BC30             dx 0002,C5AE
}


;;; $BC34: Instruction list - Crocomire - stepping back ;;;
{
$A4:BC34             dx 0008,C1EA,
                        908F,       ; Move right 4px if on-screen and spawn big dust cloud
                        0008,C1B8,
                        905B,       ; Move right 4px if on-screen
                        0008,C186,
                        905B,       ; Move right 4px if on-screen
                        0008,C154,
                        908F,       ; Move right 4px if on-screen and spawn big dust cloud
                        0008,C122,
                        8FC7,       ; Shake screen
                        905B,       ; Move right 4px if on-screen
                        86A6        ; Fight AI
}


;;; $BC56: Instruction list - Crocomire - wait for first/second damage ;;;
{
; Blinking in disbelief
$A4:BC56             dx 0022,C448,
                        0002,C40E,
                        0002,C3D4,
                        0002,C39A,
                        0002,C360,
                        0002,C326,
                        0002,C2EC,
                        0010,C2EC,
                        0001,C326,
                        0001,C360,
                        0001,C39A,
                        0001,C3D4,
                        0001,C40E,
                        0010,C448,
                        0001,C40E,
                        0001,C3D4,
                        0001,C39A,
                        0001,C360,
                        0001,C326,
                        0001,C2EC,
                        0001,C326,
                        0001,C360,
                        0001,C39A,
                        0001,C3D4,
                        0001,C40E,
                        0001,C448,
                        0001,C40E,
                        0001,C3D4,
                        0001,C39A,
                        0001,C360,
                        0001,C326,
                        0001,C2EC,
                        86A6        ; Fight AI
}


;;; $BCD8: Instruction list - Crocomire - wait for first/second damage - moving claws ;;;
{
; Moving claws
$A4:BCD8             dx 9AAA,       ; Spawn big dust cloud enemy projectile - X offset 10h
                        0005,C47A,
                        0005,C4AC,
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9A9B,       ; Spawn big dust cloud enemy projectile - X offset -20h
                        0005,C47A,
                        0005,C4AC,
                        9AA5,       ; Spawn big dust cloud enemy projectile - X offset -10h
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,C47A,
                        0005,C4AC,
                        9AC8,       ; Spawn big dust cloud enemy projectile - X offset 28h
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9AA5,       ; Spawn big dust cloud enemy projectile - X offset -10h
                        86A6        ; Fight AI
}


;;; $BD2A: Instruction list - Crocomire - wait for first/second damage - roar ;;;
{
; Rawr, open mouth
$A4:BD2A             dx 0030,C574,
                        8CFB,       ; Queue Crocomire's cry sound effect
                        0005,C5AE,
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0020,C5E8,
                        86A6,       ; Fight AI
                        0001,C5E8,
                        86A6        ; Fight AI
}


;;; $BD8E: Instruction list - Crocomire - wait for first/second damage - roar - close mouth ;;;
{
; Rawr, close mouth
$A4:BD8E             dx 0020,C5E8,
                        86A6,       ; Fight AI
                        0005,C5AE,
                        86A6,       ; Fight AI
                        0008,C5AE,
                        0002,C574
$A4:BDA2             dx 0001,C574,
                        86A6,       ; Fight AI
; TODO: is this part of the instruction list ever accessible?
                        0001,C574,
                        86A6        ; Fight AI
}


;;; $BDAE: Instruction list - Crocomire - power bomb reaction - mouth fully open ;;;
{
$A4:BDAE             dx 0002,C5AE
}


;;; $BDB2: Instruction list - Crocomire - power bomb reaction - mouth partially open ;;;
{
$A4:BDB2             dx 0002,C574
}


;;; $BDB6: Instruction list - Crocomire - power bomb reaction - mouth not open ;;;
{
$A4:BDB6             dx 9AAA,       ; Spawn big dust cloud enemy projectile - X offset 10h
                        0005,C47A,
                        0005,C4AC,
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9A9B,       ; Spawn big dust cloud enemy projectile - X offset -20h
                        0005,C47A,
                        0005,C4AC,
                        9AA5,       ; Spawn big dust cloud enemy projectile - X offset -10h
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,C47A,
                        0005,C4AC,
                        9AC8,       ; Spawn big dust cloud enemy projectile - X offset 28h
                        0005,C4DE,
                        0005,C510,
                        0005,C542,
                        8D07,       ; Queue big explosion sound effect
                        9AA5        ; Spawn big dust cloud enemy projectile - X offset -10h
$A4:BE06             dx 0004,BFC4,
                        8FC7,       ; Shake screen
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0004,BFF6,
                        8FDF,       ; Move left 4px
                        0004,C028,
                        8FDF,       ; Move left 4px
                        0004,C05A,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0004,C08C,
                        8FDF,       ; Move left 4px
                        0004,C0BE,
                        8FDF,       ; Move left 4px
                        0004,C0F0,
                        8FC7,       ; Shake screen
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0004,C122,
                        8FDF,       ; Move left 4px
                        0004,C154,
                        8FDF,       ; Move left 4px
                        0004,C186,
                        8FFA,       ; Move left 4px and spawn big dust cloud
                        0004,C1B8,
                        8FDF,       ; Move left 4px
                        0004,C1EA,
                        86A6,       ; Fight AI
                        80ED,BE06   ; Go to $BE06
}


;;; $BE56: Instruction list - Crocomire's tongue - initial ;;;
{
$A4:BE56             dx 0005,C65E,
                        0005,C668,
                        0005,C672,
                        0005,C67C,
                        80ED,BE56   ; Go to $BE56
}


;;; $BE6A: Instruction list ;;;
{
$A4:BE6A             dx 0005,C67C,
                        0005,C672,
                        0005,C668,
                        0005,C65E,
                        80ED,BE56   ; Go to $BE56
}


;;; $BE7E: Instruction list - Crocomire - near spike wall charge ;;;
{
$A4:BE7E             dx 0005,C574,
                        8CFB,       ; Queue Crocomire's cry sound effect
                        86A6,       ; Fight AI
                        0005,C5AE,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0002,C5E8,
                        86A6,       ; Fight AI
                        0005,C5AE,
                        86A6,       ; Fight AI
                        0008,C5AE,
                        86A6,       ; Fight AI
                        0002,C574,
                        86A6        ; Fight AI
$A4:BEEC             dx 0003,BFC4,
                        8FC7,       ; Shake screen
                        8FFF,       ; Move left 4px and spawn big dust cloud
                        0003,BFF6,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C028,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C05A,
                        8FFF,       ; Move left 4px and spawn big dust cloud
                        0003,C08C,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C0BE,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C0F0,
                        8FC7,       ; Shake screen
                        8FFF,       ; Move left 4px and spawn big dust cloud
                        0003,C122,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C154,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C186,
                        8FFF,       ; Move left 4px and spawn big dust cloud
                        0003,C1B8,
                        901D,       ; Move left 4px and spawn big dust cloud and handle spike wall collision
                        0003,C1EA,
                        86A6,       ; Fight AI
                        80ED,BEEC   ; Go to $BEEC
}


;;; $BF3C: Instruction list - Crocomire - back off from spike wall ;;;
{
$A4:BF3C             dx 0008,C1EA,
                        9094,       ; Move right 4px and spawn big dust cloud
                        0008,C1B8,
                        907F,       ; Move right 4px
                        0008,C186,
                        907F,       ; Move right 4px
                        0008,C154,
                        9094,       ; Move right 4px and spawn big dust cloud
                        0008,C122,
                        8FC7,       ; Shake screen
                        907F,       ; Move right 4px
                        86A6,       ; Fight AI
                        80ED,BF3C   ; Go to $BF3C
}


;;; $BF62: Instruction list - sleep ;;;
{
$A4:BF62             dx 812F        ; Sleep
}


;;; $BF64: Instruction list ;;;
{
$A4:BF64             dx 7FFF,CA7E,
                        80ED,BF64   ; Go to $BF64
}


;;; $BF6C: Instruction list ;;;
{
$A4:BF6C             dx 7FFF,CA88,
                        812F        ; Sleep
}


;;; $BF72: Instruction list ;;;
{
$A4:BF72             dx 7FFF,CA92,
                        812F        ; Sleep
}


;;; $BF78: Instruction list ;;;
{
$A4:BF78             dx 7FFF,CA9C,
                        812F        ; Sleep
}


;;; $BF7E: Instruction list ;;;
{
$A4:BF7E             dx 7FFF,CAA6,
                        80ED,BF7E   ; Go to $BF7E
}


;;; $BF86: Instruction list ;;;
{
$A4:BF86             dx 7FFF,CAB0,
                        812F        ; Sleep
}


;;; $BF8C: Instruction list ;;;
{
$A4:BF8C             dx 7FFF,CABA,
                        812F        ; Sleep
}


;;; $BF92: Instruction list ;;;
{
$A4:BF92             dx 7FFF,CAC4,
                        812F        ; Sleep
}


;;; $BF98: Instruction list ;;;
{
$A4:BF98             dx 0005,CACE,
                        0005,CAD8,
                        0005,CAE2,
                        0005,CAEC,
                        0005,CAF6,
                        80ED,BF98   ; Go to $BF98
}


;;; $BFB0: Instruction list - Crocomire - bridge collapsed ;;;
{
$A4:BFB0             dx 0005,C5AE,
                        0005,C574,
                        8CFB,       ; Queue Crocomire's cry sound effect
                        0005,C5AE,
                        0005,C5E8,
                        812F        ; Sleep
}
}


;;; $BFC4: Crocomire extended spritemaps ;;;
{
$A4:BFC4             dx 0006, 0003,000B,CF15,CB31, 0000,0026,D065,CB4D, FFE3,0026,CF69,CB4D, 0000,0000,D7B6,CC1F, 0000,0000,D8BE,CC1F, 0000,FFFF,D852,CC1F
$A4:BFF6             dx 0006, 0001,000B,CF44,CB3F, 0000,0026,D08F,CB4D, FFE3,0026,CF93,CB4D, 0000,FFFE,D7EA,CC1F, 0000,FFFE,D8BE,CC1F, 0000,FFFE,D876,CC1F
$A4:C028             dx 0006, 0000,0008,CEC1,CB15, 0000,0026,D0B9,CB4D, FFE3,0026,CFBD,CB4D, 0000,FFFE,D81E,CC1F, 0000,FFFE,D8BE,CC1F, 0000,FFFE,D89A,CC1F
$A4:C05A             dx 0006, 0001,000B,CE92,CB07, 0000,0026,D0E3,CB4D, FFE3,0026,CFE7,CB4D, 0000,FFFF,D7EA,CC1F, 0000,FFFF,D8BE,CC1F, 0000,FFFE,D876,CC1F
$A4:C08C             dx 0006, 0001,000A,CE92,CB07, 0000,0026,D10D,CB4D, FFE3,0026,D011,CB4D, 0000,FFFE,D7B6,CC1F, 0000,FFFE,D8BE,CC1F, 0000,FFFE,D852,CC1F
$A4:C0BE             dx 0006, 0001,000A,CEF0,CB23, 0000,0026,D137,CB4D, FFE3,0026,D03B,CB4D, 0000,FFFE,D7EA,CC1F, 0000,FFFE,D8BE,CC1F, 0000,FFFE,D876,CC1F
$A4:C0F0             dx 0006, 0001,000A,CF15,CB31, 0000,0026,CF69,CB4D, FFE3,0026,D065,CB4D, 0000,FFFF,D81E,CC1F, 0000,FFFF,D8BE,CC1F, 0000,FFFF,D89A,CC1F
$A4:C122             dx 0006, 0001,000A,CF44,CB3F, 0000,0026,CF93,CB4D, FFE3,0026,D08F,CB4D, 0000,FFFF,D7EA,CC1F, 0000,FFFF,D8BE,CC1F, 0000,FFFF,D876,CC1F
$A4:C154             dx 0006, 0001,000A,CEC1,CB15, 0000,0026,CFBD,CB4D, FFE3,0026,D0B9,CB4D, 0000,0000,D7B6,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D852,CC1F
$A4:C186             dx 0006, 0001,000C,CE92,CB07, 0000,0026,CFE7,CB4D, FFE3,0026,D0E3,CB4D, 0000,0000,D7EA,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D876,CC1F
$A4:C1B8             dx 0006, 0001,000D,CE92,CB07, 0000,0026,D011,CB4D, FFE3,0026,D10D,CB4D, 0000,0000,D81E,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D89A,CC1F
$A4:C1EA             dx 0006, 0001,000B,CEF0,CB23, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D7EA,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D876,CC1F
$A4:C21C             dx 0006, 0001,000A,CE92,CB07, 0000,0029,D18B,CB4D, FFE3,0029,D18B,CB4D, 0000,FFFE,D7B6,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D852,CC1F ; Unused
$A4:C24E             dx 0006, 0001,0008,CE92,CB07, 0000,0029,D1B5,CB4D, FFE3,0029,D1B5,CB4D, 0000,FFFC,D7EA,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D876,CC1F ; Unused
$A4:C280             dx 0006, 0001,0006,CE92,CB07, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,FFFA,D81E,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D89A,CC1F ; Unused
$A4:C2B2             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D4B3,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F ; Unused
$A4:C2EC             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D493,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C326             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D4B3,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C360             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D4D3,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C39A             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D4F3,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C3D4             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D509,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C40E             dx 0007, 0000,000B,CEF0,CB23, FFFD,FFE4,D515,CBC3, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C448             dx 0006, 0000,000B,CEF0,CB23, 0000,0029,D1DF,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C47A             dx 0006, 0001,000B,D388,CB5F, 0000,0025,D18B,CB4D, FFE3,0029,D1DF,CB4D, 0000,0000,D7B6,CC1F, 0000,0000,D8BE,CC1F, 0000,0000,D852,CC1F
$A4:C4AC             dx 0006, 0000,0008,D3B7,CB6D, 0000,0027,D1B5,CB4D, FFE3,0027,D1B5,CB4D, 0000,FFFE,D7EA,CC1F, 0000,FFFE,D8BE,CC1F, 0000,FFFE,D876,CC1F
$A4:C4DE             dx 0006, 0001,0008,D2BB,CB4F, 0000,0029,D1DF,CB4D, FFE3,0020,D18B,CB4D, 0000,FFFC,D81E,CC1F, 0000,FFFC,D8BE,CC1F, 0000,FFFC,D89A,CC1F
$A4:C510             dx 0006, 0000,000A,CEC1,CB15, 0000,0027,D1B5,CB4D, FFE3,0025,D1B5,CB4D, 0000,FFFE,D7EA,CC1F, 0000,FFFE,D8BE,CC1F, 0000,FFFE,D876,CC1F
$A4:C542             dx 0006, 0001,000C,CE92,CB07, 0000,0025,D18B,CB4D, FFE3,0028,D1DF,CB4D, 0000,FFFF,D7B6,CC1F, 0000,FFFF,D8BE,CC1F, 0000,FFFF,D852,CC1F
$A4:C574             dx 0007, 0001,000B,CEF0,CB23, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D6DA,CC11, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C5AE             dx 0007, 0001,000B,CEF0,CB23, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D51C,CBC5, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C5E8             dx 0007, 0001,000B,CEF0,CB23, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D600,CBEB, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C622             dx 0001, 0000,0000,D7B6,CC1F ; Unused
$A4:C62C             dx 0001, 0000,0000,D7EA,CC1F ; Unused
$A4:C636             dx 0001, 0000,0000,D81E,CC1F ; Unused
$A4:C640             dx 0001, 0000,0000,D852,CC1F ; Unused
$A4:C64A             dx 0001, 0000,0000,D876,CC1F ; Unused
$A4:C654             dx 0001, 0000,0000,D89A,CC1F ; Unused
$A4:C65E             dx 0001, FFE0,FFE8,D43E,CBB3
$A4:C668             dx 0001, FFE0,FFE8,D454,CBB3
$A4:C672             dx 0001, FFE0,FFE8,D465,CBB3
$A4:C67C             dx 0001, FFE0,FFE8,D47B,CBB3
$A4:C686             dx 0001, 0000,0000,D48C,CBB5 ; Unused
$A4:C690             dx 0001, 0000,0000,D8BE,CC1F ; Unused
$A4:C69A             dx 0001, 0000,0000,DA4A,CC2D ; Unused
$A4:C6A4             dx 0007, 0003,000B,CF15,CB31, 0000,0026,D065,CB4D, FFE3,0026,CF69,CB4D, 0000,0000,D6DA,CC11, 0000,0000,D7B6,CC1F, 0000,0000,DA4A,CC2D, 0000,FFFF,D852,CC1F
$A4:C6DE             dx 0007, 0001,000B,CF44,CB3F, 0000,0026,D08F,CB4D, FFE3,0026,CF93,CB4D, 0000,0000,D7EA,CC1F, 0000,0000,D51C,CBC5, 0000,0000,DA4A,CC2D, 0000,FFFE,D876,CC1F
$A4:C718             dx 0007, 0000,0008,CEC1,CB15, 0000,0026,D0B9,CB4D, FFE3,0026,CFBD,CB4D, 0000,FFFF,D81E,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,FFFE,D89A,CC1F
$A4:C752             dx 0007, 0001,000B,CE92,CB07, 0000,0026,D0E3,CB4D, FFE3,0026,CFE7,CB4D, 0000,FFFF,D7EA,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,FFFE,D876,CC1F
$A4:C78C             dx 0007, 0001,000A,CE92,CB07, 0000,0026,D10D,CB4D, FFE3,0026,D011,CB4D, 0000,FFFF,D7B6,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,FFFE,D852,CC1F
$A4:C7C6             dx 0007, 0001,000A,CEF0,CB23, 0000,0026,D137,CB4D, FFE3,0026,D03B,CB4D, 0000,FFFF,D7EA,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,FFFE,D876,CC1F
$A4:C800             dx 0007, 0001,000A,CF15,CB31, 0000,0026,CF69,CB4D, FFE3,0026,D065,CB4D, 0000,FFFF,D81E,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,0000,D89A,CC1F
$A4:C83A             dx 0007, 0001,000A,CF44,CB3F, 0000,0026,CF93,CB4D, FFE3,0026,D08F,CB4D, 0000,FFFF,D7EA,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C874             dx 0007, 0001,000A,CEC1,CB15, 0000,0026,CFBD,CB4D, FFE3,0026,D0B9,CB4D, 0000,0000,D7B6,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,0000,D852,CC1F
$A4:C8AE             dx 0007, 0001,000C,CE92,CB07, 0000,0026,CFE7,CB4D, FFE3,0026,D0E3,CB4D, 0000,0000,D7EA,CC1F, 0000,0000,D600,CBEB, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C8E8             dx 0007, 0001,000D,CE92,CB07, 0000,0026,D011,CB4D, FFE3,0026,D10D,CB4D, 0000,0000,D81E,CC1F, 0000,0000,D51C,CBC5, 0000,0000,DA4A,CC2D, 0000,0000,D89A,CC1F
$A4:C922             dx 0007, 0001,000B,CEF0,CB23, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D81E,CC1F, 0000,0000,D6DA,CC11, 0000,0000,DA4A,CC2D, 0000,0000,D89A,CC1F
$A4:C95C             dx 0007, 0001,000B,D388,CB5F, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D600,CBEB, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C996             dx 0007, 0000,0006,D3B7,CB6D, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D600,CBEB, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:C9D0             dx 0007, 0001,0004,D2BB,CB4F, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D600,CBEB, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:CA0A             dx 0007, 0000,0008,CEC1,CB15, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D600,CBEB, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:CA44             dx 0007, 0001,000B,CE92,CB07, 0000,0026,D03B,CB4D, FFE3,0026,D137,CB4D, 0000,0000,D600,CBEB, 0000,0000,D7EA,CC1F, 0000,0000,DA4A,CC2D, 0000,0000,D876,CC1F
$A4:CA7E             dx 0001, 0000,0000,DB04,CB15
$A4:CA88             dx 0001, 0000,0000,DB79,CB15
$A4:CA92             dx 0001, 0000,0000,DC25,CB15
$A4:CA9C             dx 0001, 0000,0000,DD08,CB15
$A4:CAA6             dx 0001, 0000,0000,DE1D,CB15
$A4:CAB0             dx 0001, 0000,0000,DE97,CB15
$A4:CABA             dx 0001, 0000,0000,DF48,CB15
$A4:CAC4             dx 0001, 0000,0000,E030,CB15
$A4:CACE             dx 0001, 0001,000B,D388,CC3B
$A4:CAD8             dx 0001, 0000,0008,D3B7,CC3B
$A4:CAE2             dx 0001, 0001,0008,D2BB,CC3B
$A4:CAEC             dx 0001, 0000,000A,CEC1,CC3B
$A4:CAF6             dx 0001, 0001,000C,CE92,CC3B
}


;;; $CB00: RTL ;;;
{
$A4:CB00 6B          RTL
}


;;; $CB01: RTL ;;;
{
$A4:CB01 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:CB04 6B          RTL
}


;;; $CB05: Crocomire hitboxes ;;;
{
$A4:CB05             dx 0000 ; Unused
$A4:CB07             dx 0001, FFB2,0020,FFF0,002B,B93D,BAB4
$A4:CB15             dx 0001, FFA1,000B,FFF0,000B,B93D,BAB4
$A4:CB23             dx 0001, FFBB,001F,FFF0,002C,B93D,BAB4
$A4:CB31             dx 0001, FFC4,0012,FFF0,0020,B93D,BAB4
$A4:CB3F             dx 0001, FFB0,000D,FFF0,001B,B93D,BAB4
$A4:CB4D             dx 0000
$A4:CB4F             dx 0001, FFA1,FFFA,FFF0,001B,B93D,B951
$A4:CB5D             dx 0000 ; Unused
$A4:CB5F             dx 0001, FFC5,FFF7,FFF0,0005,B93D,B951
$A4:CB6D             dx 0001, FFA3,FFDC,FFE2,FFF3,B93D,B951
$A4:CB7B             dx 0001, FFFB,FFFB,0004,0004,B93D,B951 ; Unused
$A4:CB89             dx 0001, FFFA,FFF9,0005,0006,B93D,B951 ; Unused
$A4:CB97             dx 0001, FFF8,FFF8,0007,0007,B93D,B951 ; Unused
$A4:CBA5             dx 0001, FFF7,FFF8,0008,0007,B93D,B951 ; Unused
$A4:CBB3             dx 0000
$A4:CBB5             dx 0001, FFF7,FFF7,0008,0007,B93D,B951
$A4:CBC3             dx 0000
$A4:CBC5             dx 0003, FFCE,FFDB,0028,FFF0,8023,BA05, FFCC,FFC6,002A,FFDA,8023,802D, FFE0,FFF3,0028,0000,8023,802D
$A4:CBEB             dx 0003, FFD2,FFCB,000D,FFF0,8023,BA05, FFD7,FFB6,0010,FFC7,8023,802D, FFDB,FFF0,0010,FFFD,8023,802D
$A4:CC11             dx 0001, FFDB,FFCE,0026,FFFC,B93D,802D
$A4:CC1F             dx 0001, FFDA,FFD0,0025,0034,B93D,B968
$A4:CC2D             dx 0001, FFDA,FFFC,002A,0034,B93D,B951
$A4:CC3B             dx 0000
}


;;; $CC3D: Crocomire spritemaps / extended tilemaps ;;;
{
$A4:CC3D             dx 0011, 01E4,18,31A6, 01F4,18,31BF, 01EC,18,31AF, 801C,10,31CA, 800C,10,31C8, 81FC,10,31C6, 801C,00,31C4, 800C,00,31C2, 81FC,00,31C0, 000C,E8,31B6, 801C,F0,31AD, 800C,F0,31AB, 81FC,F0,31A9, 81EC,F0,31A7, 81FC,E0,31A4, 81EC,E0,31A2, 81DC,E0,31A0 ; Unused
$A4:CC94             dx 0011, 0014,18,71A6, 0004,18,71BF, 000C,18,71AF, 81D4,10,71CA, 81E4,10,71C8, 81F4,10,71C6, 81D4,00,71C4, 81E4,00,71C2, 81F4,00,71C0, 01EC,E8,71B6, 81D4,F0,71AD, 81E4,F0,71AB, 81F4,F0,71A9, 8004,F0,71A7, 81F4,E0,71A4, 8004,E0,71A2, 8014,E0,71A0 ; Unused
$A4:CCEB             dx 000A, 0018,0C,316B, 0010,0C,316A, 8010,FC,3168, 8010,EC,3166, 8000,00,3164, 81F0,00,3162, 8000,F0,3164, 81F0,F0,3162, 81E0,FC,3180, 81E0,EC,3160 ; Unused
$A4:CD1F             dx 000A, 01E0,0C,716B, 01E8,0C,716A, 81E0,FC,7168, 81E0,EC,7166, 81F0,00,7164, 8000,00,7162, 81F0,F0,7164, 8000,F0,7162, 8010,FC,7180, 8010,EC,7160 ; Unused
$A4:CD53             dx 000F, 8020,10,318E, 8000,10,318A, 8010,10,318C, 01F8,18,317B, 01F0,10,310F, 01F8,10,311F, 01E7,18,717A, 01E0,18,317A, 01D0,10,3188, 01D8,10,3189, 01E0,10,3198, 01E8,10,3199, 81F0,00,3186, 81E0,00,3184, 81D0,00,3182 ; Unused
$A4:CDA0             dx 000F, 81D0,10,718E, 81F0,10,718A, 81E0,10,718C, 0000,18,717B, 0008,10,710F, 0000,10,711F, 0011,18,317A, 0018,18,717A, 0028,10,7188, 0020,10,7189, 0018,10,7198, 0010,10,7199, 8000,00,7186, 8010,00,7184, 8020,00,7182 ; Unused
$A4:CDED             dx 0002, 8000,F8,316E, 81F0,F8,316C ; Unused
$A4:CDF9             dx 0002, 81F0,F8,716E, 8000,F8,716C ; Unused
$A4:CE05             dx 0001, 81F8,F8,7160 ; Unused
$A4:CE0C             dx 0001, 81F8,F8,7180 ; Unused
$A4:CE13             dx 0001, 81F8,F8,7162 ; Unused
$A4:CE1A             dx 0001, 81F8,F8,7164 ; Unused
$A4:CE21             dx 0001, 81F8,F8,7166 ; Unused
$A4:CE28             dx 0001, 81F8,F8,7168 ; Unused
$A4:CE2F             dx 0002, 01F8,FC,716B, 0000,FC,716A ; Unused
$A4:CE3B             dx 0003, 0000,04,7188, 01F8,04,7189, 81F8,F4,7182 ; Unused
$A4:CE4C             dx 0005, 01F9,08,317A, 0000,08,717A, 0000,00,7198, 01F8,00,7199, 81F8,F0,7184 ; Unused
$A4:CE67             dx 0004, 0000,05,710F, 01F8,0D,717B, 01F8,05,711F, 81F8,F5,7186 ; Unused
$A4:CE7D             dx 0001, 81F8,F8,718A ; Unused
$A4:CE84             dx 0001, 81F8,F8,718C ; Unused
$A4:CE8B             dx 0001, 81F8,F8,718E ; Unused
$A4:CE92             dx 0009, 81C3,1A,30E4, 81B3,1E,3100, 0000,07,3108, 01F0,FF,30F6, 81F0,07,3106, 81F8,F7,30E7, 81EC,0B,30E0, 81DE,12,30E0, 81D0,19,30E0
$A4:CEC1             dx 0009, 81B1,13,30E4, 81A1,13,3100, 01F8,09,30FF, 01F0,F9,30EF, 81E8,01,30ED, 81F8,F9,310D, 81DE,05,3102, 81CE,0F,3104, 81C0,0F,3102
$A4:CEF0             dx 0007, 81CC,1C,30E4, 81BC,1E,3100, 81F8,08,3109, 81F8,F8,30E9, 81F6,0D,30E0, 81E8,14,30E0, 81DA,1B,30E0
$A4:CF15             dx 0009, 0000,08,70FF, 0008,F8,70EF, 8008,00,70ED, 81F8,F8,710D, 81D5,11,30E4, 81C5,11,3100, 8002,03,3102, 81F2,0D,3104, 81E4,0D,3102
$A4:CF44             dx 0007, 81C0,0C,30E4, 81B0,0C,3100, 81F8,08,3109, 81F8,F8,30E9, 81F0,0C,30E2, 81E0,0C,30E2, 81D0,0C,30E2
$A4:CF69             dx 0008, 0002,09,30DF, 01FA,09,30DE, 01F2,09,30DD, 01EA,09,30DC, 01E2,09,30DB, 81F2,F9,312D, 81F6,F9,314B, 8001,F9,312B
$A4:CF93             dx 0008, 0005,09,30DF, 01FD,09,30DE, 01F5,09,30DD, 01ED,09,30DC, 01E5,09,30DB, 81F5,F9,312D, 81F7,F9,314B, 8001,F9,312B
$A4:CFBD             dx 0008, 0008,09,30DF, 0000,09,30DE, 01F8,09,30DD, 01F0,09,30DC, 01E8,09,30DB, 81F8,F9,312D, 81F9,F9,314B, 8000,F9,312B
$A4:CFE7             dx 0008, 000C,09,30DF, 0004,09,30DE, 01FC,09,30DD, 01F4,09,30DC, 01EC,09,30DB, 81FC,F9,312D, 81FC,F9,314B, 8000,F9,312B
$A4:D011             dx 0008, 8003,F9,312D, 8002,F9,714B, 0011,09,30DF, 0009,09,30DE, 0001,09,30DD, 01F9,09,30DC, 01F1,09,30DB, 8001,F9,712B
$A4:D03B             dx 0008, 8009,F9,312D, 8006,F9,714B, 0018,09,30DF, 0010,09,30DE, 0008,09,30DD, 0000,09,30DC, 01F8,09,30DB, 8001,F9,712B
$A4:D065             dx 0008, 8010,F9,312D, 800B,F9,714B, 0020,09,30DF, 0018,09,30DE, 0010,09,30DD, 0008,09,30DC, 0000,09,30DB, 8003,F9,712B
$A4:D08F             dx 0008, 8009,F8,312D, 8006,F8,714B, 0018,09,30DF, 0010,08,30DE, 0008,08,30DD, 0000,09,30DC, 01F8,09,30DB, 8001,F9,712B
$A4:D0B9             dx 0008, 8003,F5,312D, 8002,F5,714B, 0011,06,30DF, 0009,05,30DE, 0001,05,30DD, 01F9,07,30DC, 01F1,07,30DB, 8001,F9,712B
$A4:D0E3             dx 0008, 000C,06,30DF, 0004,05,30DE, 01FC,05,30DD, 01F4,07,30DC, 01EC,07,30DB, 81FC,F5,312D, 81FC,F5,314B, 8000,F9,312B
$A4:D10D             dx 0008, 0008,06,30DF, 0000,05,30DE, 01F8,05,30DD, 01F0,07,30DC, 01E8,07,30DB, 81F8,F5,312D, 81F9,F5,314B, 8000,F9,312B
$A4:D137             dx 0008, 0005,07,30DF, 01FD,06,30DE, 01F5,06,30DD, 01ED,08,30DC, 01E5,08,30DB, 81F5,F6,312D, 81F7,F6,314B, 8001,F9,312B
$A4:D161             dx 0008, 0002,08,30DF, 01FA,07,30DE, 01F2,07,30DD, 01EA,08,30DC, 01E2,08,30DB, 81F2,F7,312D, 81F6,F7,314B, 8001,F9,312B ; Unused
$A4:D18B             dx 0008, 000C,04,30DF, 0004,05,30DE, 01FC,05,30DD, 01F4,05,30DC, 01EC,05,30DB, 81FC,F5,312D, 81FC,F5,314B, 8000,F9,312B
$A4:D1B5             dx 0008, 000C,04,30DF, 0004,05,30DE, 01FC,05,30DD, 01F4,05,30DC, 01EC,05,30DB, 81FC,F5,312D, 81FC,F3,314B, 8000,F5,312B
$A4:D1DF             dx 0008, 000C,04,30DF, 0004,05,30DE, 01FC,05,30DD, 01F4,05,30DC, 01EC,05,30DB, 81FC,F5,312D, 81FC,F1,314B, 8000,F1,312B
$A4:D209             dx 0009, 802D,1A,70E4, 803D,1E,7100, 01F8,07,7108, 0008,FF,70F6, 8000,07,7106, 81F8,F7,70E7, 8004,0B,70E0, 8012,12,70E0, 8020,19,70E0 ; Unused
$A4:D238             dx 0009, 803F,13,70E4, 804F,13,7100, 0000,09,70FF, 0008,F9,70EF, 8008,01,70ED, 81F8,F9,710D, 8012,05,7102, 8022,0F,7104, 8030,0F,7102 ; Unused
$A4:D267             dx 0007, 8024,1C,70E4, 8034,1E,7100, 81F8,08,7109, 81F8,F8,70E9, 81FA,0D,70E0, 8008,14,70E0, 8016,1B,70E0 ; Unused
$A4:D28C             dx 0009, 01F8,08,30FF, 01F0,F8,30EF, 81E8,00,30ED, 81F8,F8,310D, 801B,11,70E4, 802B,11,7100, 81EE,03,7102, 81FE,0D,7104, 800C,0D,7102 ; Unused
$A4:D2BB             dx 0007, 81E6,FA,30EB, 81F6,FA,310B, 81AD,FA,30E4, 819D,FA,3100, 81DD,FA,30E2, 81CD,FA,30E2, 81BD,FA,30E2
$A4:D2E0             dx 0009, 0000,F0,F0FF, 0008,00,F0EF, 8008,F0,F0ED, 81F8,F8,F10D, 803D,DB,70E4, 804D,DB,7100, 8010,EC,F102, 8020,E2,F104, 802E,E2,F102 ; Unused
$A4:D30F             dx 0007, 800A,FA,70EB, 81FA,FA,710B, 8043,FA,70E4, 8053,FA,7100, 8013,FA,70E2, 8023,FA,70E2, 8033,FA,70E2 ; Unused
$A4:D334             dx 0009, 01F8,08,30FF, 01F0,F8,30EF, 81E8,00,30ED, 81F8,F8,310D, 801B,F6,70E4, 802B,F6,7100, 81EE,07,F102, 81FE,FD,F104, 800C,FD,F102 ; Unused
$A4:D363             dx 0007, 81F8,08,7109, 81F8,F8,70E9, 802A,FA,70E4, 803A,FA,7100, 81FD,0B,F102, 800D,01,F104, 801B,01,F102 ; Unused
$A4:D388             dx 0009, 0000,08,70FF, 0008,F8,70EF, 8008,00,70ED, 81F8,F8,710D, 81D5,F6,30E4, 81C5,F6,3100, 8002,07,B102, 81F2,FD,B104, 81E4,FD,B102
$A4:D3B7             dx 0009, 01F8,F0,B0FF, 01F0,00,B0EF, 81E8,F0,B0ED, 81F8,F8,B10D, 81B3,DB,30E4, 81A3,DB,3100, 81E0,EC,B102, 81D0,E2,B104, 81C2,E2,B102
$A4:D3E6             dx 0004, 0000,F8,70D0, 0000,00,F0D0, 01F8,00,B0D0, 01F8,F8,30D0 ; Unused
$A4:D3FC             dx 0004, 0000,F8,70D1, 0000,00,F0D1, 01F8,00,B0D1, 01F8,F8,30D1 ; Unused
$A4:D412             dx 0004, 0000,00,F0D2, 0000,F8,70D2, 01F8,00,B0D2, 01F8,F8,30D2 ; Unused
$A4:D428             dx 0004, 0000,00,F0D3, 0000,F8,70D3, 01F8,00,B0D3, 01F8,F8,30D3 ; Unused
$A4:D43E             dx 0004, 0008,00,20D7, 0000,00,20D6, 01F8,00,20D5, 01F8,F8,20D4
$A4:D454             dx 0003, 0008,00,20DA, 0000,00,20D9, 01F8,00,20D8
$A4:D465             dx 0004, 0008,F8,A0D7, 0000,F8,A0D6, 01F8,F8,A0D5, 01F8,00,A0D4
$A4:D47B             dx 0003, 0008,F8,A0DA, 0000,F8,A0D9, 01F8,F8,A0D8
$A4:D48C             dx 0001, 81F8,F8,31CC
$A4:D493             dx 0006, 01E0,00,31DE, 01E0,F8,31CE, 01E8,00,315D, 01E8,F8,314D, 81F0,F0,31E6, 8000,F0,31E0
$A4:D4B3             dx 0006, 01E0,00,31DF, 01E0,F8,31CF, 01E8,00,315D, 01E8,F8,314D, 81F0,F0,31E6, 8000,F0,31E0
$A4:D4D3             dx 0006, 01E8,00,315E, 01E8,F8,314E, 01E0,00,313F, 01E0,F8,312F, 81F0,F0,31E6, 8000,F0,31E0
$A4:D4F3             dx 0004, 8000,F0,31E0, 81F0,F0,31E8, 01E8,00,315F, 01E8,F8,314F
$A4:D509             dx 0002, 8000,F0,31E2, 81F0,F0,31EA
$A4:D515             dx 0001, 8000,F0,31E4

$A4:D51C             dx FFFE,
                        2000,000C, 0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,0338,
                        2040,000C, 0338,0338,3CA2,3CA3,3CA4,3CA5,3CA6,3CA7,3CA8,3CA9,3CAA,0338,
                        2080,000C, 3CB0,3CB1,3CB2,3CB3,3CB4,3CB5,3CB6,3CB7,3CB8,3CB9,3CBA,3CBB,
                        20C0,000C, 3CAC,3CAD,3CAE,3CAF,3CC0,3CC1,3CC2,3CC3,3CC4,3CC5,3CC6,3CC7,
                        2100,000C, 3CBC,3CBD,3CBE,3CBF,3CD0,3CD1,3CD2,3CD3,3CD4,3CD5,3CD6,3CD7,
                        2140,000C, 0338,0338,0338,0338,3CCA,3CCB,3CCC,3CCD,3CCE,3CCF,3C8B,3C8C,
                        2180,000C, 0338,0338,3CD8,3CD9,3CDA,3CDB,3CDC,3CDD,3CDE,3CDF,3C9B,3C9C,
                        21C0,000C, 0338,0338,3C43,3C44,3C45,3C46,3C8D,3C8E,3C8F,3C9D,3C9E,3C9F,
                        FFFF

$A4:D600             dx FFFE,
                        2000,0008, 0338,3CE0,3CE1,3CE2,3CE3,3CE4,3CE5,3CE6,
                        2040,000B, 0338,3CF0,3CF1,3CF2,3CF3,3CF4,3CF5,3CF6,3CF7,3CF8,0338,
                        2080,000C, 0338,0338,3CE9,3CEA,3CEB,3CEC,3CED,3CEE,3CEF,3D00,3D01,0338,
                        20C0,000C, 0338,0338,0338,3CFA,3CFB,3CFC,3CFD,3CFE,3CFF,3D10,3D11,3D12,
                        2100,000C, 0338,0338,0338,0338,3D03,3D04,3D05,3D06,3D07,3D08,3D09,3D0A,
                        2140,000C, 0338,0338,0338,0338,0338,3D14,3D15,3D16,3D17,3D18,3D19,3D1A,
                        2180,000C, 0338,0338,3D0C,3D0D,3D0E,3D0F,3D20,3D21,3D22,3D23,3D24,3D25,
                        21C0,000C, 0338,0338,3D1C,3D1D,3D1E,3D1F,3D30,3D31,3D32,3D33,3D34,3D35,
                        FFFF

$A4:D6DA             dx FFFE,
                        2000,0008, 0338,0338,0338,0338,0338,0338,0338,0338,
                        2040,000B, 0338,0338,0338,0338,0338,3C02,3C03,3C04,3C05,3C06,3C07,
                        2080,000C, 0338,0338,0338,3C10,3C11,3C12,3C13,3C14,3C15,3C16,3C17,3C18,
                        20C0,000C, 0338,3C0A,3C0B,3C0C,3C0D,3C0E,3C0F,3C20,3C21,3C22,3C23,3C24,
                        2100,000C, 3C19,3C1A,3C1B,3C1C,3C1D,3C1E,3C1F,3C30,3C31,3C32,3C33,3C34,
                        2140,000C, 3C25,3C26,3C27,3C28,3C29,3C2A,3C2B,3C2C,3C2D,3C2E,3C2F,3C40,
                        2180,000C, 3C35,3C36,3C37,3C38,3C39,3C3A,3C3B,3C3C,3C3D,3C3E,3C3F,3C50,
                        21C0,0001, 3C00,
                        21C4,000A, 3C43,3C44,3C45,3C46,3C47,3C48,3C49,3C4A,3C4B,3C4C,
                        FFFF

$A4:D7B6             dx FFFE,
                        2246,0004, 3C4F,3C60,3C61,3C62,
                        2286,0004, 3C5F,3C70,3C71,3C72,
                        22C6,0004, 3C6A,3C6B,3C6C,3C6D,
                        2306,0004, 3C7A,3C7B,3C7C,3C7D,
                        FFFF

$A4:D7EA             dx FFFE,
                        2246,0004, 3D46,3D47,3D48,3D49,
                        2286,0004, 3D56,3D57,3D58,3D59,
                        22C6,0004, 3D4A,3D4B,3D4C,3D4D,
                        2306,0004, 3D5A,3D5B,3D5C,3D5D,
                        FFFF

$A4:D81E             dx FFFE,
                        2246,0004, 3D4E,3D4F,3D02,3D0B,
                        2286,0004, 3D13,3D1B,3C42,3C51,
                        22C6,0004, 3CA0,3CA1,3CAB,3CF9,
                        2306,0004, 3C01,3C08,3C09,3C41,
                        FFFF

$A4:D852             dx FFFE,
                        2354,0006, 3D40,3D41,3D42,3D43,3D44,3D45,
                        2394,0006, 3D50,3D51,3D52,3D53,3D54,3D55,
                        FFFF

$A4:D876             dx FFFE,
                        2354,0006, 3D26,3D27,3D28,3D29,3D2A,3D2B,
                        2394,0006, 3D36,3D37,3D38,3D39,3D3A,3D3B,
                        FFFF

$A4:D89A             dx FFFE,
                        2354,0006, 3D2C,3D2D,3D2E,3D2F,3CC8,3CC9,
                        2394,0006, 3D3C,3D3D,3D3E,3D3F,3CE7,3CE8,
                        FFFF

$A4:D8BE             dx FFFE,
                        2040,000C, 0338,0338,0338,0338,0338,3C02,3C03,3C04,3C05,3C06,3C07,0338,
                        2080,000C, 0338,0338,0338,3C10,3C11,3C12,3C13,3C14,3C15,3C16,3C17,3C18,
                        20C0,000C, 0338,3C0A,3C0B,3C0C,3C0D,3C0E,3C0F,3C20,3C21,3C22,3C23,3C24,
                        2100,000C, 3C19,3C1A,3C1B,3C1C,3C1D,3C1E,3C1F,3C30,3C31,3C32,3C33,3C34,
                        2140,000C, 3C25,3C26,3C27,3C28,3C29,3C2A,3C2B,3C2C,3C2D,3C2E,3C2F,3C40,
                        2180,000C, 3C35,3C36,3C37,3C38,3C39,3C3A,3C3B,3C3C,3C3D,3C3E,3C3F,3C50,
                        21C0,000C, 3C00,0338,3C43,3C44,3C45,3C46,3C47,3C48,3C49,3C4A,3C4B,3C4C,
                        2200,000C, 0338,0338,3C53,3C54,3C55,3C56,3C57,3C58,3C59,3C5A,3C5B,3C5C,
                        2240,000C, 0338,3C4D,3C4E,3C4F,3C60,3C61,3C62,3C63,3C64,3C65,3C66,3C67,
                        2280,000C, 0338,3C5D,3C5E,3C5F,3C70,3C71,3C72,3C73,3C74,3C75,3C76,3C77,
                        22C0,000C, 0338,3C68,3C69,3C6A,3C6B,3C6C,3C6D,3C6E,3C6F,3C80,3C81,0338,
                        2300,000C, 0338,3C78,3C79,3C7A,3C7B,3C7C,3C7D,3C7E,3C7F,3C90,3C91,0338,
                        2340,000C, 0338,3C82,3C83,3C84,3C85,3C86,3C87,3C88,3C89,3C8A,3D40,3D41,
                        2380,000C, 0338,0338,3C93,3C94,3C95,3C96,3C97,3C98,3C99,3C9A,3D50,3D51,
                        FFFF

$A4:DA4A             dx FFFE,
                        2202,000B, 0338,3C53,3C54,3C55,3C56,3C57,3C58,3C59,3C5A,3C5B,3C5C,
                        2242,000B, 3C4D,3C4E,3C4F,3C60,3C61,3C62,3C63,3C64,3C65,3C66,3C67,
                        2282,000B, 3C5D,3C5E,3C5F,3C70,3C71,3C72,3C73,3C74,3C75,3C76,3C77,
                        22C2,000B, 3C68,3C69,3C6A,3C6B,3C6C,3C6D,3C6E,3C6F,3C80,3C81,0338,
                        2302,000B, 3C78,3C79,3C7A,3C7B,3C7C,3C7D,3C7E,3C7F,3C90,3C91,0338,
                        2342,000B, 3C82,3C83,3C84,3C85,3C86,3C87,3C88,3C89,3C8A,3D40,3D41,
                        2382,000B, 0338,3C93,3C94,3C95,3C96,3C97,3C98,3C99,3C9A,3D50,3D51,
                        FFFF

$A4:DB04             dx 0017, 01D8,D8,2F77, 01E8,E8,2F66, 01F0,E8,2F65, 0000,D0,2F76, 01F8,D0,2F75, 01F0,D0,2F74, 01F0,C8,2F64, C3E0,C8,2F62, C3D0,C8,2F60, C3E8,D8,2F68, 01E0,E0,2F77, 01E0,D8,2F67, C218,D8,2F6E, C208,D8,2F6C, C3F8,D8,2F6A, C218,E8,2F84, C208,E8,2F82, C3F8,E8,2F80, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, C3E8,F8,2F88, C3D8,F8,2F86
$A4:DB79             dx 0022, 01D8,D8,2F77, 01E8,E8,2F66, 01F0,E8,2F65, 0000,D0,2F76, 01F8,D0,2F75, 01F0,D0,2F74, 01F0,C8,2F64, C3E0,C8,2F62, C3D0,C8,2F60, C3E8,D8,2F68, 01E0,E0,2F77, 01E0,D8,2F67, C218,D8,2F6E, C208,D8,2F6C, C3F8,D8,2F6A, C218,E8,2F84, C208,E8,2F82, C3F8,E8,2F80, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, C3E8,F8,2F88, C3D8,F8,2F86, 0020,08,2F3A, 0018,08,2F39, 0010,08,2F38, 0008,08,2F37, 0000,08,2F36, 01F8,08,2F35, 01F0,08,2F34, 01E8,08,2F33, 01E0,08,2F32, 01D8,08,2F31, 01D0,08,2F30
$A4:DC25             dx 002D, 01D8,D8,2F77, 01E8,E8,2F66, 01F0,E8,2F65, 0000,D0,2F76, 01F8,D0,2F75, 01F0,D0,2F74, 01F0,C8,2F64, C3E0,C8,2F62, C3D0,C8,2F60, C3E8,D8,2F68, 01E0,E0,2F77, 01E0,D8,2F67, C218,D8,2F6E, C208,D8,2F6C, C3F8,D8,2F6A, C218,E8,2F84, C208,E8,2F82, C3F8,E8,2F80, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, C3E8,F8,2F88, C3D8,F8,2F86, 0020,10,2F4A, 0018,10,2F49, 0010,10,2F48, 0008,10,2F47, 0000,10,2F46, 01F8,10,2F45, 01F0,10,2F44, 01E8,10,2F43, 01E0,10,2F42, 01D8,10,2F41, 01D0,10,2F40, 0020,08,2F3A, 0018,08,2F39, 0010,08,2F38, 0008,08,2F37, 0000,08,2F36, 01F8,08,2F35, 01F0,08,2F34, 01E8,08,2F33, 01E0,08,2F32, 01D8,08,2F31, 01D0,08,2F30
$A4:DD08             dx 0037, 01D8,D8,2F77, 01E8,E8,2F66, 01F0,E8,2F65, 0000,D0,2F76, 01F8,D0,2F75, 01F0,D0,2F74, 01F0,C8,2F64, C3E0,C8,2F62, C3D0,C8,2F60, C3E8,D8,2F68, 01E0,E0,2F77, 01E0,D8,2F67, C218,D8,2F6E, C208,D8,2F6C, C3F8,D8,2F6A, C218,E8,2F84, C208,E8,2F82, C3F8,E8,2F80, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, C3E8,F8,2F88, C3D8,F8,2F86, 0018,18,2F59, 0010,18,2F58, 0008,18,2F57, 0000,18,2F56, 01F8,18,2F55, 01F0,18,2F54, 01E8,18,2F53, 01E0,18,2F52, 01D8,18,2F51, 01D0,18,2F50, 0020,10,2F4A, 0018,10,2F49, 0010,10,2F48, 0008,10,2F47, 0000,10,2F46, 01F8,10,2F45, 01F0,10,2F44, 01E8,10,2F43, 01E0,10,2F42, 01D8,10,2F41, 01D0,10,2F40, 0020,08,2F3A, 0018,08,2F39, 0010,08,2F38, 0008,08,2F37, 0000,08,2F36, 01F8,08,2F35, 01F0,08,2F34, 01E8,08,2F33, 01E0,08,2F32, 01D8,08,2F31, 01D0,08,2F30
$A4:DE1D             dx 0018, 0010,F0,2FED, 0008,F0,2FEC, 0020,F0,2FFD, 0018,F0,2FFC, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, 0001,D0,2FB6, 01D9,00,2FA6, 01E1,00,2FAF, 01E9,00,2FBF, C211,F8,2FCA, C201,F8,2FC8, C3F1,F8,2FC6, C211,E8,2FC4, C201,E8,2FC2, C3F1,E8,2FC0, C211,D8,2FAD, C201,D8,2FAB, C3F1,D8,2FA9, C3E1,D8,2FA7, C3F1,C8,2FA4, C3E1,C8,2FA2, C3D1,C8,2FA0
$A4:DE97             dx 0023, 0010,F0,2FED, 0008,F0,2FEC, 0020,F0,2FFD, 0018,F0,2FFC, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, 0001,D0,2FB6, 01D9,00,2FA6, 01E1,00,2FAF, 01E9,00,2FBF, C211,F8,2FCA, C201,F8,2FC8, C3F1,F8,2FC6, C211,E8,2FC4, C201,E8,2FC2, C3F1,E8,2FC0, C211,D8,2FAD, C201,D8,2FAB, C3F1,D8,2FA9, C3E1,D8,2FA7, C3F1,C8,2FA4, C3E1,C8,2FA2, C3D1,C8,2FA0, 0020,08,2F3A, 0018,08,2F39, 0010,08,2F38, 0008,08,2F37, 0000,08,2F36, 01F8,08,2F35, 01F0,08,2F34, 01E8,08,2F33, 01E0,08,2F32, 01D8,08,2F31, 01D0,08,2F30
$A4:DF48             dx 002E, 0010,F0,2FED, 0008,F0,2FEC, 0020,F0,2FFD, 0018,F0,2FFC, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, 0001,D0,2FB6, 01D9,00,2FA6, 01E1,00,2FAF, 01E9,00,2FBF, C211,F8,2FCA, C201,F8,2FC8, C3F1,F8,2FC6, C211,E8,2FC4, C201,E8,2FC2, C3F1,E8,2FC0, C211,D8,2FAD, C201,D8,2FAB, C3F1,D8,2FA9, C3E1,D8,2FA7, C3F1,C8,2FA4, C3E1,C8,2FA2, C3D1,C8,2FA0, 0020,10,2F4A, 0018,10,2F49, 0010,10,2F48, 0008,10,2F47, 0000,10,2F46, 01F8,10,2F45, 01F0,10,2F44, 01E8,10,2F43, 01E0,10,2F42, 01D8,10,2F41, 01D0,10,2F40, 0020,08,2F3A, 0018,08,2F39, 0010,08,2F38, 0008,08,2F37, 0000,08,2F36, 01F8,08,2F35, 01F0,08,2F34, 01E8,08,2F33, 01E0,08,2F32, 01D8,08,2F31, 01D0,08,2F30
$A4:E030             dx 0038, 0010,F0,2FED, 0008,F0,2FEC, 0020,F0,2FFD, 0018,F0,2FFC, C218,F8,2F8E, C208,F8,2F8C, C3F8,F8,2F8A, 0001,D0,2FB6, 01D9,00,2FA6, 01E1,00,2FAF, 01E9,00,2FBF, C211,F8,2FCA, C201,F8,2FC8, C3F1,F8,2FC6, C211,E8,2FC4, C201,E8,2FC2, C3F1,E8,2FC0, C211,D8,2FAD, C201,D8,2FAB, C3F1,D8,2FA9, C3E1,D8,2FA7, C3F1,C8,2FA4, C3E1,C8,2FA2, C3D1,C8,2FA0, 0018,18,2F59, 0010,18,2F58, 0008,18,2F57, 0000,18,2F56, 01F8,18,2F55, 01F0,18,2F54, 01E8,18,2F53, 01E0,18,2F52, 01D8,18,2F51, 01D0,18,2F50, 0020,10,2F4A, 0018,10,2F49, 0010,10,2F48, 0008,10,2F47, 0000,10,2F46, 01F8,10,2F45, 01F0,10,2F44, 01E8,10,2F43, 01E0,10,2F42, 01D8,10,2F41, 01D0,10,2F40, 0020,08,2F3A, 0018,08,2F39, 0010,08,2F38, 0008,08,2F37, 0000,08,2F36, 01F8,08,2F35, 01F0,08,2F34, 01E8,08,2F33, 01E0,08,2F32, 01D8,08,2F31, 01D0,08,2F30
}


;;; $E14A..E1FD: Crocomire corpse instruction lists ;;;
{
;;; $E14A: Instruction list ;;;
{
$A4:E14A             dx 000A,E1FE,
                        000A,E228,
                        000A,E252,
                        812F        ; Sleep
}


;;; $E158: Instruction list ;;;
{
$A4:E158             dx 000A,E27C,
                        9A9B,       ; Spawn big dust cloud enemy projectile - X offset -20h
                        0005,E2A6,
                        9AA0,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0005,E2A6,
                        9AA5,       ; Spawn big dust cloud enemy projectile - X offset -10h
                        0005,E2D0,
                        9AAA,       ; Spawn big dust cloud enemy projectile - X offset 10h
                        0005,E2D0,
                        000A,E2FA,
                        0020,E324,
                        0010,E34E,
                        8D13,       ; Queue Crocomire's skeleton collapses sound effect
                        000A,E378,
                        0009,E3A2,
                        0009,E3CC,
                        9AAF,       ; Spawn big dust cloud enemy projectile - X offset 0
                        0008,E3F6,
                        9AB4,       ; Spawn big dust cloud enemy projectile - X offset 8
                        0008,E420,
                        9AB9,       ; Spawn big dust cloud enemy projectile - X offset 10h
                        0007,E46A,
                        9ABE,       ; Spawn big dust cloud enemy projectile - X offset 18h
                        0007,E4D4,
                        9AC3,       ; Spawn big dust cloud enemy projectile - X offset 20h
                        0006,E53E,
                        9AC8,       ; Spawn big dust cloud enemy projectile - X offset 28h
                        0006,E5A8,
                        9ACD,       ; Spawn big dust cloud enemy projectile - X offset 30h
                        0006,E60A,
                        9AD2,       ; Spawn big dust cloud enemy projectile - X offset 38h
                        0005,E65C,
                        9AD7,       ; Spawn big dust cloud enemy projectile - X offset 40h
                        8D07,       ; Queue big explosion sound effect
                        0005,E68E,
                        7FFF,E6A8,
                        812F        ; Sleep
}


;;; $E1CC: Instruction list - Crocomire - dead ;;;
{
$A4:E1CC             dx 7FFF,E6B2,
                        812F        ; Sleep
}


;;; $E1D2: Instruction list ;;;
{
$A4:E1D2             dx 0004,E6BC,
                        0004,E6C6,
                        0004,E6D0,
                        0004,E6DA,
                        0004,E6E4,
                        0004,E6EE,
                        0004,E6F8,
                        0004,E702,
                        0004,E70C,
                        0014,E716,
                        80ED,E1D2   ; Go to $E1D2
}
}


;;; $E1FE: Crocomire corpse extended spritemaps ;;;
{
$A4:E1FE             dx 0005, FFF0,0007,EE41,E748, FFFC,FFD1,E7A1,E72E, FFE7,FFF8,E8FA,E748, FFFF,0005,E82C,E748, FFE4,0014,E8AD,E748
$A4:E228             dx 0005, FFF0,0004,EE70,E748, FFFD,FFCF,E7A1,E72E, FFE7,FFF8,E8FA,E748, FFFF,0003,E82C,E748, FFE2,0014,E8AD,E748
$A4:E252             dx 0005, FFF5,FFFF,EDED,E748, FFFF,FFCE,E7A1,E72E, FFE7,FFF6,E8FA,E748, FFFF,0002,E82C,E748, FFE1,0014,E8AD,E748

$A4:E27C             dx 0005, FFF0,0003,EE1C,E748, 0000,FFCD,E7A1,E72E, FFE7,FFF8,E8FA,E748, FFFF,0001,E82C,E748, FFE0,0014,E8AD,E748
$A4:E2A6             dx 0005, FFF4,0007,ED16,E748, 0002,FFD0,E7A1,E72E, FFE7,FFFB,E8FA,E748, FFFF,0004,E82C,E748, FFDF,0014,E8AD,E748
$A4:E2D0             dx 0005, FFF4,0006,ED16,E748, 0002,FFD4,E7A1,E72E, FFE7,FFFB,E8FA,E748, FFFF,0006,E82C,E748, FFDE,0014,E8AD,E748
$A4:E2FA             dx 0005, FFF5,0004,ED16,E748, 0003,FFD1,E7A1,E72E, FFE7,FFFB,E8FA,E748, FFFF,0004,E82C,E748, FFDE,0014,E8AD,E748
$A4:E324             dx 0005, FFF4,0005,ED16,E748, 0002,FFD0,E7A1,E72E, FFE7,FFFB,E8FA,E748, FFFF,0003,E82C,E748, FFDD,0014,E8AD,E748
$A4:E34E             dx 0005, FFF0,000E,ED45,E748, 0009,FFD1,E7A1,E72E, FFE7,0000,E8FA,E748, 0001,0005,E82C,E748, FFDA,0014,E8AD,E748
$A4:E378             dx 0005, FFEB,001A,EE1C,E748, 0010,FFD9,E7A1,E72E, FFE7,0007,E8FA,E748, 0005,000B,E82C,E748, FFDA,0014,E8AD,E748
$A4:E3A2             dx 0005, FFEA,0023,EE1C,E748, 0015,FFDD,E7A1,E72E, FFE6,0013,E8FA,E748, 0007,000F,E82C,E748, FFDA,0014,E8AD,E748
$A4:E3CC             dx 0005, FFEA,002F,EE1C,E748, 001F,FFEC,E7A1,E72E, FFE7,001E,E8FA,E748, 000A,0014,E82C,E748, FFDA,0014,E8AD,E748
$A4:E3F6             dx 0005, FFEA,0036,EE1C,E748, 0024,FFF2,E7A1,E72E, FFE7,0023,E8FA,E748, 000A,0019,E82C,E748, FFDA,0014,E8AD,E748
$A4:E420             dx 0009, 002E,FFFC,E7A1,E72E, FFE7,002B,E8FA,E748, 000C,001E,E82C,E748, 0001,0024,E948,E748, FFEB,0020,E959,E748, FFD8,0022,E974,E748, FFC6,001E,E98A,E748, FFB6,0029,E991,E748, FFA3,0029,E998,E748
$A4:E46A             dx 000D, 0037,0007,E7A1,E72E, 0029,0027,E919,E748, FFF9,0014,E92E,E748, 0019,002C,E920,E748, 0019,001C,E920,E748, FFF8,0025,E935,E748, 0008,0019,E927,E748, 0009,002A,E927,E748, FFF7,0031,E93C,E748, FFE8,0024,E959,E748, FFD3,0028,E974,E748, FFC3,001C,E98A,E748, FFB4,002B,E991,E748
$A4:E4D4             dx 000D, 003C,000C,E7A1,E72E, 0029,002C,E919,E748, FFF9,0019,E92E,E748, 001C,0030,E920,E748, 001A,0020,E920,E748, FFFD,0025,E935,E748, 0009,001E,E927,E748, 000D,002D,E927,E748, FFF8,0033,E93C,E748, FFE9,002A,E959,E748, FFD0,002A,E974,E748, FFC2,0021,E98A,E748, FFAE,002F,E991,E748
$A4:E53E             dx 000D, 003E,0011,E7A1,E72E, 0029,0031,E919,E748, FFF8,0020,E92E,E748, 001C,0030,E920,E748, 0018,0025,E920,E748, FFFE,0029,E935,E748, 0009,0023,E927,E748, 000F,0030,E927,E748, FFF6,0036,E93C,E748, FFE8,002F,E959,E748, FFCE,002D,E974,E748, FFC0,0026,E98A,E748, FFAC,0033,E991,E748
$A4:E5A8             dx 000C, 0040,0016,E7A1,E72E, 0029,0031,E919,E748, FFF7,0026,E92E,E748, 001C,002C,E920,E748, 0016,0028,E920,E748, 0002,002C,E935,E748, 000C,0027,E927,E748, 000F,0030,E927,E748, FFF6,0036,E93C,E748, FFE9,0034,E959,E748, FFD2,0032,E974,E748, FFBE,002C,E98A,E748
$A4:E60A             dx 000A, 0040,0014,E7A1,E72E, 0029,0036,E919,E748, FFF6,002B,E92E,E748, 001C,0031,E920,E748, 0016,002D,E920,E748, 0002,002C,E935,E748, 000C,002C,E927,E748, 000F,0035,E927,E748, FFEA,0039,E959,E748, FFD2,0037,E974,E748
$A4:E65C             dx 0006, 0040,0013,E7A1,E72E, FFF3,002E,E92E,E748, 001D,0033,E920,E748, 0014,002F,E920,E748, 0002,0031,E935,E748, 000C,002C,E927,E748
$A4:E68E             dx 0003, 0040,0014,E7A1,E72E, FFF3,0031,E92E,E748, 000E,0030,E927,E748
$A4:E6A8             dx 0001, 0040,0015,E7A1,E72E

$A4:E6B2             dx 0001, 0000,0000,E7A1,E72E
$A4:E6BC             dx 0001, 0000,0000,F5F3,E748
$A4:E6C6             dx 0001, 0000,0000,F5FA,E748
$A4:E6D0             dx 0001, 0000,0000,F60B,E748
$A4:E6DA             dx 0001, 0000,0000,F61C,E748
$A4:E6E4             dx 0001, 0000,0000,F62D,E748
$A4:E6EE             dx 0001, 0000,0000,F63E,E748
$A4:E6F8             dx 0001, 0000,0000,F64F,E748
$A4:E702             dx 0001, 0000,0000,F660,E748
$A4:E70C             dx 0001, 0000,0000,F66C,E748
$A4:E716             dx 0001, 0020,0020,F673,E748
}


;;; $E720: Crocomire corpse hitboxes ;;;
{
$A4:E720             dx 0001, FFE6,FFE2,0026,001D,B950,B968 ; Unused
$A4:E72E             dx 0002, FFDA,FFF0,0000,001F,B950,B968, 0000,FFE3,001A,001C,B950,B968
$A4:E748             dx 0000
}


;;; $E74A: Crocomire corpse spritemaps / extended tilemaps ;;;
{
$A4:E74A             dx 0011, 01E4,18,2FA6, 01F4,18,2FBF, 01EC,18,2FAF, 801C,10,2FCA, 800C,10,2FC8, 81FC,10,2FC6, 801C,00,2FC4, 800C,00,2FC2, 81FC,00,2FC0, 000C,E8,2FB6, 801C,F0,2FAD, 800C,F0,2FAB, 81FC,F0,2FA9, 81EC,F0,2FA7, 81FC,E0,2FA4, 81EC,E0,2FA2, 81DC,E0,2FA0 ; Unused
$A4:E7A1             dx 0011, 0014,18,6FA6, 0004,18,6FBF, 000C,18,6FAF, 81D4,10,6FCA, 81E4,10,6FC8, 81F4,10,6FC6, 81D4,00,6FC4, 81E4,00,6FC2, 81F4,00,6FC0, 01EC,E8,6FB6, 81D4,F0,6FAD, 81E4,F0,6FAB, 81F4,F0,6FA9, 8004,F0,6FA7, 81F4,E0,6FA4, 8004,E0,6FA2, 8014,E0,6FA0
$A4:E7F8             dx 000A, 0018,0C,2F6B, 0010,0C,2F6A, 8010,FC,2F68, 8010,EC,2F66, 8000,00,2F64, 81F0,00,2F62, 8000,F0,2F64, 81F0,F0,2F62, 81E0,FC,2F80, 81E0,EC,2F60 ; Unused
$A4:E82C             dx 000A, 01E0,0C,6F6B, 01E8,0C,6F6A, 81E0,FC,6F68, 81E0,EC,6F66, 81F0,00,6F64, 8000,00,6F62, 81F0,F0,6F64, 8000,F0,6F62, 8010,FC,6F80, 8010,EC,6F60
$A4:E860             dx 000F, 8020,10,2F8E, 8000,10,2F8A, 8010,10,2F8C, 01F8,18,2F7B, 01F0,10,2F0F, 01F8,10,2F1F, 01E7,18,6F7A, 01E0,18,2F7A, 01D0,10,2F88, 01D8,10,2F89, 01E0,10,2F98, 01E8,10,2F99, 81F0,00,2F86, 81E0,00,2F84, 81D0,00,2F82 ; Unused
$A4:E8AD             dx 000F, 81D0,10,6F8E, 81F0,10,6F8A, 81E0,10,6F8C, 0000,18,6F7B, 0008,10,6F0F, 0000,10,6F1F, 0011,18,2F7A, 0018,18,6F7A, 0028,10,6F88, 0020,10,6F89, 0018,10,6F98, 0010,10,6F99, 8000,00,6F86, 8010,00,6F84, 8020,00,6F82
$A4:E8FA             dx 0002, 8000,F8,2F6E, 81F0,F8,2F6C
$A4:E906             dx 0002, 81F0,F8,6F6E, 8000,F8,6F6C ; Unused
$A4:E912             dx 0001, 81F8,F8,6F60 ; Unused
$A4:E919             dx 0001, 81F8,F8,6F80
$A4:E920             dx 0001, 81F8,F8,6F62
$A4:E927             dx 0001, 81F8,F8,6F64
$A4:E92E             dx 0001, 81F8,F8,6F66
$A4:E935             dx 0001, 81F8,F8,6F68
$A4:E93C             dx 0002, 01F8,FC,6F6B, 0000,FC,6F6A
$A4:E948             dx 0003, 0000,04,6F88, 01F8,04,6F89, 81F8,F4,6F82
$A4:E959             dx 0005, 01F9,08,2F7A, 0000,08,6F7A, 0000,00,6F98, 01F8,00,6F99, 81F8,F0,6F84
$A4:E974             dx 0004, 0000,05,6F0F, 01F8,0D,6F7B, 01F8,05,6F1F, 81F8,F5,6F86
$A4:E98A             dx 0001, 81F8,F8,6F8A
$A4:E991             dx 0001, 81F8,F8,6F8C
$A4:E998             dx 0001, 81F8,F8,6F8E
$A4:E99F             dx 0009, 81C3,1A,20E4, 81B3,1E,2100, 0000,07,2108, 01F0,FF,20F6, 81F0,07,2106, 81F8,F7,20E7, 81EC,0B,20E0, 81DE,12,20E0, 81D0,19,20E0 ; Unused
$A4:E9CE             dx 0009, 81B1,13,20E4, 81A1,13,2100, 01F8,09,20FF, 01F0,F9,20EF, 81E8,01,20ED, 81F8,F9,210D, 81DE,05,2102, 81CE,0F,2104, 81C0,0F,2102 ; Unused
$A4:E9FD             dx 0007, 81CC,1C,20E4, 81BC,1E,2100, 81F8,08,2109, 81F8,F8,20E9, 81F6,0D,20E0, 81E8,14,20E0, 81DA,1B,20E0 ; Unused
$A4:EA22             dx 0009, 0000,08,60FF, 0008,F8,60EF, 8008,00,60ED, 81F8,F8,610D, 81D5,11,20E4, 81C5,11,2100, 8002,03,2102, 81F2,0D,2104, 81E4,0D,2102 ; Unused
$A4:EA51             dx 0007, 81C0,0C,20E4, 81B0,0C,2100, 81F8,08,2109, 81F8,F8,20E9, 81F0,0C,20E2, 81E0,0C,20E2, 81D0,0C,20E2 ; Unused
$A4:EA76             dx 0008, 0002,09,20DF, 01FA,09,20DE, 01F2,09,20DD, 01EA,09,20DC, 01E2,09,20DB, 81F2,F9,212D, 81F6,F9,214B, 8001,F9,212B ; Unused
$A4:EAA0             dx 0008, 0005,09,20DF, 01FD,09,20DE, 01F5,09,20DD, 01ED,09,20DC, 01E5,09,20DB, 81F5,F9,212D, 81F7,F9,214B, 8001,F9,212B ; Unused
$A4:EACA             dx 0008, 0008,09,20DF, 0000,09,20DE, 01F8,09,20DD, 01F0,09,20DC, 01E8,09,20DB, 81F8,F9,212D, 81F9,F9,214B, 8000,F9,212B ; Unused
$A4:EAF4             dx 0008, 000C,09,20DF, 0004,09,20DE, 01FC,09,20DD, 01F4,09,20DC, 01EC,09,20DB, 81FC,F9,212D, 81FC,F9,214B, 8000,F9,212B ; Unused
$A4:EB1E             dx 0008, 8003,F9,212D, 8002,F9,614B, 0011,09,20DF, 0009,09,20DE, 0001,09,20DD, 01F9,09,20DC, 01F1,09,20DB, 8001,F9,612B ; Unused
$A4:EB48             dx 0008, 8009,F9,212D, 8006,F9,614B, 0018,09,20DF, 0010,09,20DE, 0008,09,20DD, 0000,09,20DC, 01F8,09,20DB, 8001,F9,612B ; Unused
$A4:EB72             dx 0008, 8010,F9,212D, 800B,F9,614B, 0020,09,20DF, 0018,09,20DE, 0010,09,20DD, 0008,09,20DC, 0000,09,20DB, 8003,F9,612B ; Unused
$A4:EB9C             dx 0008, 8009,F8,212D, 8006,F8,614B, 0018,09,20DF, 0010,08,20DE, 0008,08,20DD, 0000,09,20DC, 01F8,09,20DB, 8001,F9,612B ; Unused
$A4:EBC6             dx 0008, 8003,F5,212D, 8002,F5,614B, 0011,06,20DF, 0009,05,20DE, 0001,05,20DD, 01F9,07,20DC, 01F1,07,20DB, 8001,F9,612B ; Unused
$A4:EBF0             dx 0008, 000C,06,20DF, 0004,05,20DE, 01FC,05,20DD, 01F4,07,20DC, 01EC,07,20DB, 81FC,F5,212D, 81FC,F5,214B, 8000,F9,212B ; Unused
$A4:EC1A             dx 0008, 0008,06,20DF, 0000,05,20DE, 01F8,05,20DD, 01F0,07,20DC, 01E8,07,20DB, 81F8,F5,212D, 81F9,F5,214B, 8000,F9,212B ; Unused
$A4:EC44             dx 0008, 0005,07,20DF, 01FD,06,20DE, 01F5,06,20DD, 01ED,08,20DC, 01E5,08,20DB, 81F5,F6,212D, 81F7,F6,214B, 8001,F9,212B ; Unused
$A4:EC6E             dx 0008, 0002,08,20DF, 01FA,07,20DE, 01F2,07,20DD, 01EA,08,20DC, 01E2,08,20DB, 81F2,F7,212D, 81F6,F7,214B, 8001,F9,212B ; Unused
$A4:EC98             dx 0008, 000C,04,20DF, 0004,05,20DE, 01FC,05,20DD, 01F4,05,20DC, 01EC,05,20DB, 81FC,F5,212D, 81FC,F5,214B, 8000,F9,212B ; Unused
$A4:ECC2             dx 0008, 000C,04,20DF, 0004,05,20DE, 01FC,05,20DD, 01F4,05,20DC, 01EC,05,20DB, 81FC,F5,212D, 81FC,F3,214B, 8000,F5,212B ; Unused
$A4:ECEC             dx 0008, 000C,04,20DF, 0004,05,20DE, 01FC,05,20DD, 01F4,05,20DC, 01EC,05,20DB, 81FC,F5,212D, 81FC,F1,214B, 8000,F1,212B ; Unused
$A4:ED16             dx 0009, 802D,1A,62E4, 803D,1E,6300, 01F8,07,6308, 0008,FF,62F6, 8000,07,6306, 81F8,F7,62E7, 8004,0B,62E0, 8012,12,62E0, 8020,19,62E0
$A4:ED45             dx 0009, 803F,13,62E4, 804F,13,6300, 0000,09,62FF, 0008,F9,62EF, 8008,01,62ED, 81F8,F9,630D, 8012,05,6302, 8022,0F,6304, 8030,0F,6302
$A4:ED74             dx 0007, 8024,1C,62E4, 8034,1E,6300, 81F8,08,6309, 81F8,F8,62E9, 81FA,0D,62E0, 8008,14,62E0, 8016,1B,62E0 ; Unused
$A4:ED99             dx 0009, 01F8,08,22FF, 01F0,F8,22EF, 81E8,00,22ED, 81F8,F8,230D, 801B,11,62E4, 802B,11,6300, 81EE,03,6302, 81FE,0D,6304, 800C,0D,6302 ; Unused
$A4:EDC8             dx 0007, 81E6,FA,20EB, 81F6,FA,210B, 81AD,FA,20E4, 819D,FA,2100, 81DD,FA,20E2, 81CD,FA,20E2, 81BD,FA,20E2 ; Unused
$A4:EDED             dx 0009, 0000,F0,E2FF, 0008,00,E2EF, 8008,F0,E2ED, 81F8,F8,E30D, 803D,DB,62E4, 804D,DB,6300, 8010,EC,E302, 8020,E2,E304, 802E,E2,E302
$A4:EE1C             dx 0007, 800A,FA,62EB, 81FA,FA,630B, 8043,FA,62E4, 8053,FA,6300, 8013,FA,62E2, 8023,FA,62E2, 8033,FA,62E2
$A4:EE41             dx 0009, 01F8,08,22FF, 01F0,F8,22EF, 81E8,00,22ED, 81F8,F8,230D, 801B,F6,62E4, 802B,F6,6300, 81EE,07,E302, 81FE,FD,E304, 800C,FD,E302
$A4:EE70             dx 0007, 81F8,08,6309, 81F8,F8,62E9, 802A,FA,62E4, 803A,FA,6300, 81FD,0B,E302, 800D,01,E304, 801B,01,E302
$A4:EE95             dx 0009, 0000,08,60FF, 0008,F8,60EF, 8008,00,60ED, 81F8,F8,610D, 81D5,F6,20E4, 81C5,F6,2100, 8002,07,A102, 81F2,FD,A104, 81E4,FD,A102 ; Unused
$A4:EEC4             dx 0009, 01F8,F0,A0FF, 01F0,00,A0EF, 81E8,F0,A0ED, 81F8,F8,A10D, 81B3,DB,20E4, 81A3,DB,2100, 81E0,EC,A102, 81D0,E2,A104, 81C2,E2,A102 ; Unused
$A4:EEF3             dx 0004, 0000,F8,60D0, 0000,00,E0D0, 01F8,00,A0D0, 01F8,F8,20D0 ; Unused
$A4:EF09             dx 0004, 0000,F8,60D1, 0000,00,E0D1, 01F8,00,A0D1, 01F8,F8,20D1 ; Unused
$A4:EF1F             dx 0004, 0000,00,E0D2, 0000,F8,60D2, 01F8,00,A0D2, 01F8,F8,20D2 ; Unused
$A4:EF35             dx 0004, 0000,00,E0D3, 0000,F8,60D3, 01F8,00,A0D3, 01F8,F8,20D3 ; Unused
$A4:EF4B             dx 0004, 0008,00,20D7, 0000,00,20D6, 01F8,00,20D5, 01F8,F8,20D4 ; Unused
$A4:EF61             dx 0003, 0008,00,20DA, 0000,00,20D9, 01F8,00,20D8 ; Unused
$A4:EF72             dx 0004, 0008,F8,A0D7, 0000,F8,A0D6, 01F8,F8,A0D5, 01F8,00,A0D4 ; Unused
$A4:EF88             dx 0003, 0008,F8,A0DA, 0000,F8,A0D9, 01F8,F8,A0D8 ; Unused
$A4:EF99             dx 0001, 81F8,F8,21CC ; Unused
$A4:EFA0             dx 0006, 01E0,00,21DE, 01E0,F8,21CE, 01E8,00,215D, 01E8,F8,214D, 81F0,F0,21E6, 8000,F0,21E0 ; Unused
$A4:EFC0             dx 0006, 01E0,00,21DF, 01E0,F8,21CF, 01E8,00,215D, 01E8,F8,214D, 81F0,F0,21E6, 8000,F0,21E0 ; Unused
$A4:EFE0             dx 0006, 01E8,00,215E, 01E8,F8,214E, 01E0,00,213F, 01E0,F8,212F, 81F0,F0,21E6, 8000,F0,21E0 ; Unused
$A4:F000             dx 0004, 8000,F0,21E0, 81F0,F0,21E8, 01E8,00,215F, 01E8,F8,214F ; Unused
$A4:F016             dx 0002, 8000,F0,21E2, 81F0,F0,21EA ; Unused
$A4:F022             dx 0001, 8000,F0,21E4 ; Unused

; Unused
$A4:F029             dx FFFE,
                        2000,000C,01FF,01FF,01FF,01FF,01FF,01FF,01FF,01FF,01FF,01FF,01FF,01FF,
                        2040,000C,01FF,01FF,1CA2,1CA3,1CA4,1CA5,1CA6,1CA7,1CA8,1CA9,1CAA,01FF,
                        2080,000C,1CB0,1CB1,1CB2,1CB3,1CB4,1CB5,1CB6,1CB7,1CB8,1CB9,1CBA,1CBB,
                        20C0,000C,1CAC,1CAD,1CAE,1CAF,1CC0,1CC1,1CC2,1CC3,1CC4,1CC5,1CC6,1CC7,
                        2100,000C,1CBC,1CBD,1CBE,1CBF,1CD0,1CD1,1CD2,1CD3,1CD4,1CD5,1CD6,1CD7,
                        2140,000C,01FF,01FF,01FF,01FF,1CCA,1CCB,1CCC,1CCD,1CCE,1CCF,1C8B,1C8C,
                        2180,000C,01FF,01FF,1CD8,1CD9,1CDA,1CDB,1CDC,1CDD,1CDE,1CDF,1C9B,1C9C,
                        21C0,000C,01FF,01FF,1C43,1C44,1C45,1C46,1C8D,1C8E,1C8F,1C9D,1C9E,1C9F,
                        FFFF

; Unused
$A4:F10D             dx FFFE,
                        2002,0007,1CE0,1CE1,1CE2,1CE3,1CE4,1CE5,1CE6,
                        2042,000A,1CF0,1CF1,1CF2,1CF3,1CF4,1CF5,1CF6,1CF7,1CF8,01FF,
                        2080,000C,01FF,01FF,1CE9,1CEA,1CEB,1CEC,1CED,1CEE,1CEF,1D00,1D01,01FF,
                        20C0,000C,01FF,01FF,01FF,1CFA,1CFB,1CFC,1CFD,1CFE,1CFF,1D10,1D11,1D12,
                        2100,000C,01FF,01FF,01FF,01FF,1D03,1D04,1D05,1D06,1D07,1D08,1D09,1D0A,
                        2148,0008,01FF,1D14,1D15,1D16,1D17,1D18,1D19,1D1A,
                        2184,000A,1D0C,1D0D,1D0E,1D0F,1D20,1D21,1D22,1D23,1D24,1D25,
                        21C4,000A,1D1C,1D1D,1D1E,1D1F,1D30,1D31,1D32,1D33,1D34,1D35,
                        FFFF

; Unused
$A4:F1D3             dx FFFE,
                        2002,0007,01FF,01FF,01FF,01FF,01FF,01FF,01FF,
                        2042,000A,01FF,01FF,01FF,01FF,1C02,1C03,1C04,1C05,1C06,1C07,
                        2084,000A,01FF,1C10,1C11,1C12,1C13,1C14,1C15,1C16,1C17,1C18,
                        20C2,000B,1C0A,1C0B,1C0C,1C0D,1C0E,1C0F,1C20,1C21,1C22,1C23,1C24,
                        2100,000C,1C19,1C1A,1C1B,1C1C,1C1D,1C1E,1C1F,1C30,1C31,1C32,1C33,1C34,
                        2140,000C,1C25,1C26,1C27,1C28,1C29,1C2A,1C2B,1C2C,1C2D,1C2E,1C2F,1C40,
                        2180,000C,1C35,1C36,1C37,1C38,1C39,1C3A,1C3B,1C3C,1C3D,1C3E,1C3F,1C50,
                        21C0,0001,1C00,
                        21C4,000A,1C43,1C44,1C45,1C46,1C47,1C48,1C49,1C4A,1C4B,1C4C,
                        FFFF

; Unused
$A4:F2A5             dx FFFE,
                        2246,0004,1C4F,1C60,1C61,1C62,
                        2286,0004,1C5F,1C70,1C71,1C72,
                        22C6,0004,1C6A,1C6B,1C6C,1C6D,
                        2306,0004,1C7A,1C7B,1C7C,1C7D,
                        FFFF

; Unused
$A4:F2D9             dx FFFE,
                        2246,0004,1D46,1D47,1D48,1D49,
                        2286,0004,1D56,1D57,1D58,1D59,
                        22C6,0004,1D4A,1D4B,1D4C,1D4D,
                        2306,0004,1D5A,1D5B,1D5C,1D5D,
                        FFFF

; Unused
$A4:F30D             dx FFFE,
                        2246,0004,1D4E,1D4F,1D02,1D0B,
                        2286,0004,1D13,1D1B,1C42,1C51,
                        22C6,0004,1CA0,1CA1,1CAB,1CF9,
                        2306,0004,1C01,1C08,1C09,1C41,
                        FFFF

; Unused
$A4:F341             dx FFFE,
                        2354,0006,1D40,1D41,1D42,1D43,1D44,1D45,
                        2394,0006,1D50,1D51,1D52,1D53,1D54,1D55,
                        FFFF

; Unused
$A4:F365             dx FFFE,
                        2354,0006,1D26,1D27,1D28,1D29,1D2A,1D2B,
                        2394,0006,1D36,1D37,1D38,1D39,1D3A,1D3B,
                        FFFF

; Unused
$A4:F389             dx FFFE,
                        2354,0006,1D2C,1D2D,1D2E,1D2F,1CC8,1CC9,
                        2394,0006,1D3C,1D3D,1D3E,1D3F,1CE7,1CE8,
                        FFFF

; Unused
$A4:F3AD             dx FFFE,
                        2040,000C,01FF,01FF,01FF,01FF,01FF,1C02,1C03,1C04,1C05,1C06,1C07,01FF,
                        2080,000C,01FF,01FF,01FF,1C10,1C11,1C12,1C13,1C14,1C15,1C16,1C17,1C18,
                        20C0,000C,01FF,1C0A,1C0B,1C0C,1C0D,1C0E,1C0F,1C20,1C21,1C22,1C23,1C24,
                        2100,000C,1C19,1C1A,1C1B,1C1C,1C1D,1C1E,1C1F,1C30,1C31,1C32,1C33,1C34,
                        2140,000C,1C25,1C26,1C27,1C28,1C29,1C2A,1C2B,1C2C,1C2D,1C2E,1C2F,1C40,
                        2180,000C,1C35,1C36,1C37,1C38,1C39,1C3A,1C3B,1C3C,1C3D,1C3E,1C3F,1C50,
                        21C0,000C,1C00,01FF,1C43,1C44,1C45,1C46,1C47,1C48,1C49,1C4A,1C4B,1C4C,
                        2200,000C,01FF,01FF,1C53,1C54,1C55,1C56,1C57,1C58,1C59,1C5A,1C5B,1C5C,
                        2240,000C,01FF,1C4D,1C4E,1C4F,1C60,1C61,1C62,1C63,1C64,1C65,1C66,1C67,
                        2280,000C,01FF,1C5D,1C5E,1C5F,1C70,1C71,1C72,1C73,1C74,1C75,1C76,1C77,
                        22C0,000C,01FF,1C68,1C69,1C6A,1C6B,1C6C,1C6D,1C6E,1C6F,1C80,1C81,01FF,
                        2300,000C,01FF,1C78,1C79,1C7A,1C7B,1C7C,1C7D,1C7E,1C7F,1C90,1C91,01FF,
                        2340,000C,01FF,1C82,1C83,1C84,1C85,1C86,1C87,1C88,1C89,1C8A,0140,0141,
                        2380,000C,01FF,01FF,1C93,1C94,1C95,1C96,1C97,1C98,1C99,1C9A,0150,0151,
                        FFFF

; Unused
$A4:F539             dx FFFE,
                        2202,000B,01FF,1C53,1C54,1C55,1C56,1C57,1C58,1C59,1C5A,1C5B,1C5C,
                        2242,000B,1C4D,1C4E,1C4F,1C60,1C61,1C62,1C63,1C64,1C65,1C66,1C67,
                        2282,000B,1C5D,1C5E,1C5F,1C70,1C71,1C72,1C73,1C74,1C75,1C76,1C77,
                        22C2,000B,1C68,1C69,1C6A,1C6B,1C6C,1C6D,1C6E,1C6F,1C80,1C81,01FF,
                        2302,000B,1C78,1C79,1C7A,1C7B,1C7C,1C7D,1C7E,1C7F,1C90,1C91,01FF,
                        2342,000B,1C82,1C83,1C84,1C85,1C86,1C87,1C88,1C89,1C8A,0140,0141,
                        2382,000B,01FF,1C93,1C94,1C95,1C96,1C97,1C98,1C99,1C9A,0150,0151,
                        FFFF

$A4:F5F3             dx 0001, 01FC,FC,3A25
$A4:F5FA             dx 0003, 0000,F8,3A25, 01FA,F6,3A25, 01FC,FB,3A25
$A4:F60B             dx 0003, 0001,F7,3A25, 01F9,F4,3A25, 01FB,FA,3A25
$A4:F61C             dx 0003, 0001,F5,3A43, 01FC,F8,3A43, 01FA,F1,3A43
$A4:F62D             dx 0003, 0001,F3,3A43, 01FC,F5,3A43, 01FA,EE,3A43
$A4:F63E             dx 0003, 0000,F0,3A40, 01FC,F4,3A40, 01FA,ED,3A40
$A4:F64F             dx 0003, 0000,EE,3A40, 01FC,F2,3A40, 01FA,EC,3A40
$A4:F660             dx 0002, 0000,EC,3A40, 01FC,F0,3A40
$A4:F66C             dx 0001, 01FC,EE,3A40
$A4:F673             dx 0001, 01FC,EE,0A40
}


;;; $F67A: Initialisation AI - enemy $DDFF (Crocomire's tongue) ;;;
{
$A4:F67A AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A4:F67D BF 28 D8 7E LDA $7ED828,x[$7E:D82A];|
$A4:F681 89 02 00    BIT #$0002             ;} If area mini-boss dead: go to BRANCH_DEAD
$A4:F684 D0 25       BNE $25    [$F6AB]     ;/
$A4:F686 AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:F689 A9 56 BE    LDA #$BE56             ;\
$A4:F68C 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $BE56
$A4:F68F BD 88 0F    LDA $0F88,x[$7E:0FC8]  ;\
$A4:F692 09 04 04    ORA #$0404             ;} Set enemy to use extended spritemap format (and set unused bit 400h)
$A4:F695 9D 88 0F    STA $0F88,x[$7E:0FC8]  ;/
$A4:F698 A9 01 00    LDA #$0001             ;\
$A4:F69B 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A4:F69E A9 17 00    LDA #$0017             ;\
$A4:F6A1 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy X offset = 17h
$A4:F6A4 A9 00 0E    LDA #$0E00             ;\
$A4:F6A7 9D 96 0F    STA $0F96,x[$7E:0FD6]  ;} Enemy palette index = E00h (palette 7)
$A4:F6AA 6B          RTL                    ; Return

; BRANCH_DEAD
$A4:F6AB AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:F6AE BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A4:F6B1 09 00 03    ORA #$0300             ;|
$A4:F6B4 29 FF DF    AND #$DFFF             ;} Set enemy to not process instructions, mark for deletion and be invisible
$A4:F6B7 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A4:F6BA 6B          RTL
}


;;; $F6BB: RTL. Main AI - enemy $DDFF (Crocomire's tongue) ;;;
{
$A4:F6BB AE 54 0E    LDX $0E54  [$7E:0E54]
$A4:F6BE 6B          RTL
}


;;; $F6BF: RTL ;;;
{
$A4:F6BF 6B          RTL
}


;;; $F6C0: Free space ;;;
{
$A4:F6C0             fillto $A58000, $FF
}
