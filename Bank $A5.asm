;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..E358: Draygon ;;;
{
;;; $8687: Initialisation AI - enemy $DE3F (Draygon body) ;;;
{
; Draygon's making the error of trying to set the instruction list pointer of enemies that haven't yet spawned
; When an enemy spawns, its RAM gets cleared or initialised from enemy header, so these stores have no effect
; The enemies set their own instruction list pointers in their init AI, which match up except for the arms, which use $97E7 instead of $9813

$A5:8687 A2 30 00    LDX #$0030             ;\
                                            ;|
$A5:868A BD 17 A2    LDA $A217,x[$A5:A247]  ;|
$A5:868D 9F 20 C3 7E STA $7EC320,x[$7E:C350];} Target sprite palette 1..3 = [$A217..46]
$A5:8691 CA          DEX                    ;|
$A5:8692 CA          DEX                    ;|
$A5:8693 10 F5       BPL $F5    [$868A]     ;/
$A5:8695 A2 FE 0F    LDX #$0FFE             ;\
$A5:8698 A9 38 03    LDA #$0338             ;|
                                            ;|
$A5:869B 9F 00 20 7E STA $7E2000,x[$7E:2FFE];} $7E:2000..2FFF = 0338h
$A5:869F CA          DEX                    ;|
$A5:86A0 CA          DEX                    ;|
$A5:86A1 10 F8       BPL $F8    [$869B]     ;/
$A5:86A3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:86A6 A9 00 07    LDA #$0700             ;\
$A5:86A9 0A          ASL A                  ;} Enemy palette index = E00h (palette 7)
$A5:86AA 9D 96 0F    STA $0F96,x[$7E:0F96]  ;/
$A5:86AD A9 A5 00    LDA #$00A5             ;\
$A5:86B0 8D 8E 17    STA $178E  [$7E:178E]  ;|
$A5:86B3 A9 42 93    LDA #$9342             ;} Enemy graphics drawn hook = $A5:9342
$A5:86B6 8D 8C 17    STA $178C  [$7E:178C]  ;/
$A5:86B9 A9 FF FF    LDA #$FFFF             ;\
$A5:86BC 8D 3C 18    STA $183C  [$7E:183C]  ;} Process off-screen enemies
$A5:86BF A9 89 98    LDA #$9889             ;\
$A5:86C2 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $9889
$A5:86C5 A9 44 99    LDA #$9944             ;\
$A5:86C8 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Draygon eye instruction list pointer = $9944 >_<;
$A5:86CB A9 FC 99    LDA #$99FC             ;\
$A5:86CE 8D 12 10    STA $1012  [$7E:1012]  ;} Draygon tail instruction list pointer = $99FC >_<;
$A5:86D1 A9 13 98    LDA #$9813             ;\
$A5:86D4 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9813 >_<;
$A5:86D7 A9 00 04    LDA #$0400             ;\
$A5:86DA 8D 9A 17    STA $179A  [$7E:179A]  ;} Enemy BG2 tilemap size = 400h
$A5:86DD A9 1B 87    LDA #$871B             ;\
$A5:86E0 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = $871B
$A5:86E3 22 34 DF 88 JSL $88DF34[$88:DF34]  ; Spawn Draygon main screen layers HDMA object
$A5:86E7 A9 0C 00    LDA #$000C             ;\
$A5:86EA 85 A9       STA $A9    [$7E:00A9]  ;} Room loading interrupt command = Draygon's room - begin HUD drawing
$A5:86EC 22 65 D8 88 JSL $88D865[$88:D865]  ; Spawn BG3 scroll HDMA object
$A5:86F0 A9 01 00    LDA #$0001             ;\
$A5:86F3 8F 0A 88 7E STA $7E880A[$7E:880A]  ;} Set "turret 5" as destroyed
$A5:86F7 22 E2 A7 90 JSL $90A7E2[$90:A7E2]  ; Disable mini-map and mark boss room map tiles as explored
$A5:86FB 6B          RTL
}


;;; $86FC: Main AI - enemy $DE3F (Draygon body) ;;;
{
$A5:86FC AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:86FF FC A8 0F    JSR ($0FA8,x)[$A5:871B]; Execute [enemy function]
$A5:8702 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:8705 8D BA 0F    STA $0FBA  [$7E:0FBA]  ;|
$A5:8708 8D FA 0F    STA $0FFA  [$7E:0FFA]  ;} Draygon X positions = [Draygon body X position]
$A5:870B 8D 3A 10    STA $103A  [$7E:103A]  ;/
$A5:870E AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:8711 8D BE 0F    STA $0FBE  [$7E:0FBE]  ;|
$A5:8714 8D FE 0F    STA $0FFE  [$7E:0FFE]  ;} Draygon Y positions = [Draygon body Y position]
$A5:8717 8D 3E 10    STA $103E  [$7E:103E]  ;/
$A5:871A 6B          RTL
}


;;; $871B: Draygon body function - fight intro - initial delay ;;;
{
$A5:871B 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:871E AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:8721 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A5:8724 C9 00 01    CMP #$0100             ;} If [Draygon body function timer] >= 100h: go to BRANCH_DONE
$A5:8727 10 2D       BPL $2D    [$8756]     ;/
$A5:8729 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ; >_<;
$A5:872C D0 24       BNE $24    [$8752]     ; If [Draygon body function timer] = 0:
$A5:872E AE 30 03    LDX $0330  [$7E:0330]  ;\
$A5:8731 A9 00 06    LDA #$0600             ;|
$A5:8734 95 D0       STA $D0,x  [$7E:00D0]  ;|
$A5:8736 A9 00 94    LDA #$9400             ;|
$A5:8739 95 D2       STA $D2,x  [$7E:00D2]  ;|
$A5:873B A9 B1 00    LDA #$00B1             ;|
$A5:873E 95 D4       STA $D4,x  [$7E:00D4]  ;} Queue transfer of $B1:9400..99FF to VRAM $6D00..6FFF (mini-Draygon tiles)
$A5:8740 A9 00 6D    LDA #$6D00             ;|
$A5:8743 95 D5       STA $D5,x  [$7E:00D5]  ;|
$A5:8745 AD 30 03    LDA $0330  [$7E:0330]  ;|
$A5:8748 18          CLC                    ;|
$A5:8749 69 07 00    ADC #$0007             ;|
$A5:874C 8D 30 03    STA $0330  [$7E:0330]  ;/
$A5:874F 20 D9 A0    JSR $A0D9  [$A5:A0D9]  ; Spawn fight intro mini-Draygon sprite objects

$A5:8752 EE AA 0F    INC $0FAA  [$7E:0FAA]  ; Increment Draygon body function timer
$A5:8755 60          RTS                    ; Return

; BRANCH_DONE
$A5:8756 A9 8B 87    LDA #$878B             ;\
$A5:8759 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $878B
$A5:875C 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ; Draygon body function timer = 0
$A5:875F AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:8762 8F 00 78 7E STA $7E7800[$7E:7800]  ;} Draygon left side reset X position = [Draygon body X position]
$A5:8766 18          CLC                    ;\
$A5:8767 69 A0 02    ADC #$02A0             ;} Draygon right side reset X position = [Draygon body X position] + 2A0h
$A5:876A 8F 04 78 7E STA $7E7804[$7E:7804]  ;/
$A5:876E AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:8771 8F 02 78 7E STA $7E7802[$7E:7802]  ;} Draygon reset Y position = [Draygon body Y position]
$A5:8775 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A5:8779 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;|
$A5:877C AF 02 78 7E LDA $7E7802[$7E:7802]  ;} >_<;
$A5:8780 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8783 A9 18 00    LDA #$0018             ;\
$A5:8786 8F 1E 78 7E STA $7E781E[$7E:781E]  ;} Draygon swoop Y acceleration = 18h
$A5:878A 60          RTS
}


;;; $878B: Draygon body function - fight intro - dance ;;;
{
$A5:878B 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:878E AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:8791 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A5:8794 C9 D0 04    CMP #$04D0             ;} If [Draygon body function timer] < 4D0h:
$A5:8797 10 07       BPL $07    [$87A0]     ;/
$A5:8799 20 3E A1    JSR $A13E  [$A5:A13E]  ; Handle Draygon fight intro dance
$A5:879C EE AA 0F    INC $0FAA  [$7E:0FAA]  ; Increment Draygon body function timer
$A5:879F 60          RTS                    ; Return

$A5:87A0 A9 F4 87    LDA #$87F4             ;\
$A5:87A3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $87F4 (swoop right)
$A5:87A6 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ; Draygon body function timer = 0
$A5:87A9 60          RTS
}


;;; $87AA: Handle firing wall turret ;;;
{
$A5:87AA AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A5:87AD 29 3F 00    AND #$003F             ;} If [frame counter] % 40h != 0: return
$A5:87B0 D0 29       BNE $29    [$87DB]     ;/
$A5:87B2 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A5:87B6 29 03 00    AND #$0003             ;\
$A5:87B9 18          CLC                    ;|
$A5:87BA 69 02 00    ADC #$0002             ;} X = (2 + [random number] % 4) * 2
$A5:87BD 0A          ASL A                  ;|
$A5:87BE AA          TAX                    ;/
$A5:87BF 0A          ASL A                  ;\
$A5:87C0 A8          TAY                    ;} Y = [X] * 2
$A5:87C1 BF 00 88 7E LDA $7E8800,x[$7E:8808];\
$A5:87C5 D0 14       BNE $14    [$87DB]     ;} If [$7E:8800 + [X]] != 0 (turret destroyed): return
$A5:87C7 B9 DC 87    LDA $87DC,y[$A5:87EC]  ;\
$A5:87CA 85 12       STA $12    [$7E:0012]  ;} $12 = [$87DC + [Y]] (X position)
$A5:87CC B9 DE 87    LDA $87DE,y[$A5:87EE]  ;\
$A5:87CF 85 14       STA $14    [$7E:0014]  ;} $14 = [$87DC + [Y] + 2] (Y position)
$A5:87D1 A0 5E 8E    LDY #$8E5E             ;\
$A5:87D4 A9 03 00    LDA #$0003             ;} Spawn Draygon's wall turret projectile enemy projectile with speed 3px/frame
$A5:87D7 22 27 80 86 JSL $868027[$86:8027]  ;/

$A5:87DB 60          RTS

; X/Y positions to spawn turret projectiles. First two entries are unused... and last entry is made unused by init AI
$A5:87DC             dw 0040,0060,
                        0038,00C0,
                        0034,012F, ; Left turret
                        01CC,0101, ; Top right turret
                        01CC,015E, ; Bottom right turret
                        01BC,0188
}


;;; $87F4: Draygon body function - swoop right - setup ;;;
{
$A5:87F4 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:87F7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:87FA 20 17 88    JSR $8817  [$A5:8817]  ; Calculate Draygon swoop Y positions
$A5:87FD A9 B1 88    LDA #$88B1             ;\
$A5:8800 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $88B1
$A5:8803 A9 D1 97    LDA #$97D1             ;\
$A5:8806 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $97D1
$A5:8809 A9 01 00    LDA #$0001             ;\
$A5:880C 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:880F A9 01 00    LDA #$0001             ;\
$A5:8812 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = right
$A5:8816 60          RTS
}


;;; $8817: Calculate Draygon swoop Y positions ;;;
{
$A5:8817 A9 80 01    LDA #$0180             ;\
$A5:881A 8D 28 0E    STA $0E28  [$7E:0E28]  ;} $0E28 = 180h (unused)
$A5:881D AD 28 0E    LDA $0E28  [$7E:0E28]  ; >_<;
$A5:8820 8D 24 0E    STA $0E24  [$7E:0E24]  ; $0E24 = 180h (swoop Y position)
$A5:8823 9C 22 0E    STZ $0E22  [$7E:0E22]  ; $0E22 = 0 (swoop Y speed)
$A5:8826 9C 26 0E    STZ $0E26  [$7E:0E26]  ; $0E26 = 0 (swoop Y position index)

; LOOP
$A5:8829 AE 54 0E    LDX $0E54  [$7E:0E54]  ; >_<;
$A5:882C AF 1E 78 7E LDA $7E781E[$7E:781E]  ;\
$A5:8830 18          CLC                    ;|
$A5:8831 6D 22 0E    ADC $0E22  [$7E:0E22]  ;} (Swoop Y speed) += [Draygon swoop Y acceleration]
$A5:8834 8D 22 0E    STA $0E22  [$7E:0E22]  ;/
$A5:8837 EB          XBA                    ;\
$A5:8838 29 FF 00    AND #$00FF             ;|
$A5:883B 49 FF FF    EOR #$FFFF             ;|
$A5:883E 1A          INC A                  ;|
$A5:883F 18          CLC                    ;} If (swoop Y position) - (swoop Y speed) / 100h >= [Draygon reset Y position]:
$A5:8840 6D 24 0E    ADC $0E24  [$7E:0E24]  ;|
$A5:8843 CF 02 78 7E CMP $7E7802[$7E:7802]  ;|
$A5:8847 30 20       BMI $20    [$8869]     ;/
$A5:8849 8D 24 0E    STA $0E24  [$7E:0E24]  ; (Swoop Y position) -= (swoop Y speed) / 100h
$A5:884C AE 26 0E    LDX $0E26  [$7E:0E26]  ;\
$A5:884F 9F 02 90 7E STA $7E9002,x[$7E:9002];} $7E:9002 + (swoop Y position index) = (swoop Y position)
$A5:8853 EE 26 0E    INC $0E26  [$7E:0E26]  ;\
$A5:8856 EE 26 0E    INC $0E26  [$7E:0E26]  ;|
$A5:8859 EE 26 0E    INC $0E26  [$7E:0E26]  ;} (Swoop Y position index) += 4
$A5:885C EE 26 0E    INC $0E26  [$7E:0E26]  ;/
$A5:885F AD 26 0E    LDA $0E26  [$7E:0E26]  ;\
$A5:8862 C9 00 08    CMP #$0800             ;} If (swoop Y position index) < 800h: go to LOOP
$A5:8865 30 C2       BMI $C2    [$8829]     ;/
$A5:8867 80 FE       BRA $FE    [$8867]     ; Crash

$A5:8869 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A5:886D 30 0A       BMI $0A    [$8879]     ;} If [Draygon left side reset X position] >= 0: (this condition is always false... and the code of the two branches is equivalent anyway)
$A5:886F 38          SEC                    ;\
$A5:8870 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $2C = |[Samus X position] - [Draygon left side reset X position]| (X distance to Samus)
$A5:8873 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;/
$A5:8877 80 0C       BRA $0C    [$8885]

$A5:8879 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;\ Else ([Draygon left side reset X position] < 0):
$A5:887D 18          CLC                    ;|
$A5:887E 6D F6 0A    ADC $0AF6  [$7E:0AF6]  ;} $2C = |[Samus X position] - [Draygon left side reset X position]| (X distance to Samus)
$A5:8881 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;/

$A5:8885 85 2C       STA $2C    [$7E:002C]
$A5:8887 64 2A       STZ $2A    [$7E:002A]
$A5:8889 AD 26 0E    LDA $0E26  [$7E:0E26]  ;\
$A5:888C 4A          LSR A                  ;|
$A5:888D 4A          LSR A                  ;} $2E = (swoop Y position index) / 4 (swoop duration)
$A5:888E 85 2E       STA $2E    [$7E:002E]  ;/
$A5:8890 64 30       STZ $30    [$7E:0030]  ;\
$A5:8892 22 61 B7 A0 JSL $A0B761[$A0:B761]  ;|
$A5:8896 A5 2C       LDA $2C    [$7E:002C]  ;|
$A5:8898 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Draygon X speed = (X distance to Samus) / (swoop duration)
$A5:889B A5 2A       LDA $2A    [$7E:002A]  ;|
$A5:889D 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;/
$A5:88A0 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:88A3 AE 26 0E    LDX $0E26  [$7E:0E26]  ;} $7E:9002 + (swoop Y position index) = [Draygon Y position]
$A5:88A6 9F 02 90 7E STA $7E9002,x[$7E:91A2];/
$A5:88AA 8E AA 0F    STX $0FAA  [$7E:0FAA]  ; Draygon swoop Y position index = (swoop Y position index)
$A5:88AD 8E AC 0F    STX $0FAC  [$7E:0FAC]  ; Draygon swoop duration * 4 = (swoop Y position index)
$A5:88B0 60          RTS
}


;;; $88B1: Draygon body function - swoop right - descending ;;;
{
$A5:88B1 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:88B4 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:88B7 AC 54 0E    LDY $0E54  [$7E:0E54]
$A5:88BA AE AA 0F    LDX $0FAA  [$7E:0FAA]  ;\
$A5:88BD E0 68 00    CPX #$0068             ;} If [Draygon swoop Y position index] = 68h:
$A5:88C0 D0 0C       BNE $0C    [$88CE]     ;/
$A5:88C2 A9 06 9C    LDA #$9C06             ;\
$A5:88C5 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9C06
$A5:88C8 A9 01 00    LDA #$0001             ;\
$A5:88CB 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1

$A5:88CE BF 02 90 7E LDA $7E9002,x[$7E:91A2];\
$A5:88D2 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;} Draygon Y position = [$7E:9002 + [Draygon swoop Y position index]]
$A5:88D5 CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;\
$A5:88D8 CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;|
$A5:88DB CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index -= 4
$A5:88DE CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;/
$A5:88E1 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A5:88E4 F0 14       BEQ $14    [$88FA]     ;} If [Draygon swoop Y position index] != 0:
$A5:88E6 AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:88E9 18          CLC                    ;|
$A5:88EA 6D B0 0F    ADC $0FB0  [$7E:0FB0]  ;|
$A5:88ED 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position += [Draygon X speed]
$A5:88F0 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:88F3 6D AE 0F    ADC $0FAE  [$7E:0FAE]  ;|
$A5:88F6 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:88F9 60          RTS                    ; Return

$A5:88FA A9 22 89    LDA #$8922             ;\
$A5:88FD 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8922
$A5:8900 60          RTS
}


;;; $8901: Unused.  ;;;
{
; Fire goop?
$A5:8901 AD B6 05    LDA $05B6  [$7E:05B6]  ;\
$A5:8904 29 0F 00    AND #$000F             ;} If [frame counter] % 10h != 0: return
$A5:8907 D0 18       BNE $18    [$8921]     ;/
$A5:8909 A9 FE 98    LDA #$98FE             ;\
$A5:890C 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $98FE
$A5:890F AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A5:8913 F0 06       BEQ $06    [$891B]     ;} If [Draygon facing direction] != left:
$A5:8915 A9 90 9C    LDA #$9C90             ;\
$A5:8918 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $9C90

$A5:891B A9 01 00    LDA #$0001             ;\
$A5:891E 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1

$A5:8921 60          RTS
}


;;; $8922: Draygon body function - swoop right - apex ;;;
{
$A5:8922 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8925 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:8928 A9 A0 02    LDA #$02A0             ;\
$A5:892B 38          SEC                    ;|
$A5:892C ED 7A 0F    SBC $0F7A  [$7E:0F7A]  ;|
$A5:892F 85 2C       STA $2C    [$7E:002C]  ;|
$A5:8931 64 2A       STZ $2A    [$7E:002A]  ;|
$A5:8933 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;|
$A5:8936 4A          LSR A                  ;|
$A5:8937 4A          LSR A                  ;} Draygon X speed = (2A0h - [Draygon X position]) / (Draygon swoop duration)
$A5:8938 85 2E       STA $2E    [$7E:002E]  ;|
$A5:893A 64 30       STZ $30    [$7E:0030]  ;|
$A5:893C 22 61 B7 A0 JSL $A0B761[$A0:B761]  ;|
$A5:8940 A5 2C       LDA $2C    [$7E:002C]  ;|
$A5:8942 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;|
$A5:8945 A5 2A       LDA $2A    [$7E:002A]  ;|
$A5:8947 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;/
$A5:894A A9 51 89    LDA #$8951             ;\
$A5:894D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8951
$A5:8950 60          RTS
}


;;; $8951: Draygon body function - swoop right - ascending ;;;
{
; [random number] % 2: 0 = goop, 1 = swoop
$A5:8951 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8954 AC 54 0E    LDY $0E54  [$7E:0E54]
$A5:8957 AE AA 0F    LDX $0FAA  [$7E:0FAA]  ;\
$A5:895A E0 68 00    CPX #$0068             ;} If [Draygon swoop Y position index] = 68h:
$A5:895D D0 0C       BNE $0C    [$896B]     ;/
$A5:895F A9 DA 9B    LDA #$9BDA             ;\
$A5:8962 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9BDA
$A5:8965 A9 01 00    LDA #$0001             ;\
$A5:8968 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1

$A5:896B BF 02 90 7E LDA $7E9002,x[$7E:9002];\
$A5:896F 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;} Draygon Y position = [$7E:9002 + [Draygon swoop Y position index]]
$A5:8972 EE AA 0F    INC $0FAA  [$7E:0FAA]  ;\
$A5:8975 EE AA 0F    INC $0FAA  [$7E:0FAA]  ;|
$A5:8978 EE AA 0F    INC $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index += 4
$A5:897B EE AA 0F    INC $0FAA  [$7E:0FAA]  ;/
$A5:897E AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A5:8981 CD AC 0F    CMP $0FAC  [$7E:0FAC]  ;} If [Draygon swoop Y position index] != [Draygon swoop duration * 4]:
$A5:8984 F0 14       BEQ $14    [$899A]     ;/
$A5:8986 AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8989 18          CLC                    ;|
$A5:898A 6D B0 0F    ADC $0FB0  [$7E:0FB0]  ;|
$A5:898D 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position += [Draygon X speed]
$A5:8990 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8993 6D AE 0F    ADC $0FAE  [$7E:0FAE]  ;|
$A5:8996 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8999 60          RTS                    ; Return

$A5:899A 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ; Draygon swoop Y position index = 0
$A5:899D AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A5:89A0 29 01 00    AND #$0001             ;} If [random number] % 2 != 0:
$A5:89A3 F0 07       BEQ $07    [$89AC]     ;/
$A5:89A5 A9 B3 89    LDA #$89B3             ;\
$A5:89A8 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $89B3 (swoop left)
$A5:89AB 60          RTS                    ; Return

$A5:89AC A9 8E 8C    LDA #$8C8E             ;\
$A5:89AF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8C8E
$A5:89B2 60          RTS
}


;;; $89B3: Draygon body function - swoop left - setup ;;;
{
; Uses $0E26(!) which was calculated as part of:
;     $8817: Calculate Draygon swoop Y positions
; $0FAC contains the same value and is part of enemy RAM instead of a random temporary >_<;
$A5:89B3 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:89B6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:89B9 AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A5:89BD 38          SEC                    ;|
$A5:89BE ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} $2C = |[Samus X position] - [Draygon right side reset X position]| (X distance to Samus)
$A5:89C1 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;|
$A5:89C5 85 2C       STA $2C    [$7E:002C]  ;/
$A5:89C7 64 2A       STZ $2A    [$7E:002A]
$A5:89C9 AD 26 0E    LDA $0E26  [$7E:0E26]  ;\
$A5:89CC 4A          LSR A                  ;|
$A5:89CD 4A          LSR A                  ;} $2E = (swoop Y position index) / 4 (swoop duration)
$A5:89CE 85 2E       STA $2E    [$7E:002E]  ;/
$A5:89D0 64 30       STZ $30    [$7E:0030]  ;\
$A5:89D2 22 61 B7 A0 JSL $A0B761[$A0:B761]  ;|
$A5:89D6 A5 2C       LDA $2C    [$7E:002C]  ;|
$A5:89D8 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Draygon X speed = (X distance to Samus) / (swoop duration)
$A5:89DB A5 2A       LDA $2A    [$7E:002A]  ;|
$A5:89DD 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;/
$A5:89E0 A9 00 8A    LDA #$8A00             ;\
$A5:89E3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8A00
$A5:89E6 A9 BB 97    LDA #$97BB             ;\
$A5:89E9 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $97BB
$A5:89EC A9 01 00    LDA #$0001             ;\
$A5:89EF 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:89F2 A9 00 00    LDA #$0000             ;\
$A5:89F5 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = left
$A5:89F9 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A5:89FC 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index = [Draygon swoop duration * 4]
$A5:89FF 60          RTS
}


;;; $8A00: Draygon body function - swoop left - descending ;;;
{
$A5:8A00 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8A03 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:8A06 AC 54 0E    LDY $0E54  [$7E:0E54]
$A5:8A09 AE AA 0F    LDX $0FAA  [$7E:0FAA]  ;\
$A5:8A0C E0 68 00    CPX #$0068             ;} If [Draygon swoop Y position index] = 68h:
$A5:8A0F D0 0C       BNE $0C    [$8A1D]     ;/
$A5:8A11 A9 13 98    LDA #$9813             ;\
$A5:8A14 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9813
$A5:8A17 A9 01 00    LDA #$0001             ;\
$A5:8A1A 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1

$A5:8A1D BF 02 90 7E LDA $7E9002,x[$7E:91A2];\
$A5:8A21 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;} Draygon Y position = [$7E:9002 + [Draygon swoop Y position index]]
$A5:8A24 CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;\
$A5:8A27 CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;|
$A5:8A2A CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index -= 4
$A5:8A2D CE AA 0F    DEC $0FAA  [$7E:0FAA]  ;/
$A5:8A30 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A5:8A33 F0 14       BEQ $14    [$8A49]     ;} If [Draygon swoop Y position index] != 0:
$A5:8A35 AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8A38 38          SEC                    ;|
$A5:8A39 ED B0 0F    SBC $0FB0  [$7E:0FB0]  ;|
$A5:8A3C 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position -= [Draygon X speed]
$A5:8A3F AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8A42 ED AE 0F    SBC $0FAE  [$7E:0FAE]  ;|
$A5:8A45 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8A48 60          RTS                    ; Return

$A5:8A49 A9 50 8A    LDA #$8A50             ;\
$A5:8A4C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8A50
$A5:8A4F 60          RTS
}


;;; $8A50: Draygon body function - swoop left - apex ;;;
{
$A5:8A50 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8A53 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:8A56 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A5:8A5A 30 0A       BMI $0A    [$8A66]     ;} If [Draygon left side reset X position] >= 0: (this condition is always false... and the code of the two branches is equivalent anyway)
$A5:8A5C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:8A5F 38          SEC                    ;} $2C = |[Samus X position] - [Draygon left side reset X position]| (X distance to Samus)
$A5:8A60 EF 00 78 7E SBC $7E7800[$7E:7800]  ;/
$A5:8A64 80 08       BRA $08    [$8A6E]

$A5:8A66 49 FF FF    EOR #$FFFF             ;\ Else ([Draygon left side reset X position] < 0):
$A5:8A69 1A          INC A                  ;|
$A5:8A6A 18          CLC                    ;} $2C = |[Samus X position] - [Draygon left side reset X position]| (X distance to Samus)
$A5:8A6B 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;/

$A5:8A6E 85 2C       STA $2C    [$7E:002C]
$A5:8A70 64 2A       STZ $2A    [$7E:002A]
$A5:8A72 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A5:8A75 4A          LSR A                  ;|
$A5:8A76 4A          LSR A                  ;} $2E = (Draygon swoop duration)
$A5:8A77 85 2E       STA $2E    [$7E:002E]  ;/
$A5:8A79 64 30       STZ $30    [$7E:0030]  ;\
$A5:8A7B 22 61 B7 A0 JSL $A0B761[$A0:B761]  ;|
$A5:8A7F A5 2C       LDA $2C    [$7E:002C]  ;|
$A5:8A81 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;} Draygon X speed = (X distance to Samus) / (swoop duration)
$A5:8A84 A5 2A       LDA $2A    [$7E:002A]  ;|
$A5:8A86 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;/
$A5:8A89 A9 90 8A    LDA #$8A90             ;\
$A5:8A8C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8A90
$A5:8A8F 60          RTS
}


;;; $8A90: Draygon body function - swoop left - ascending ;;;
{
; [random number] % 2: 0 = goop, 1 = swoop
$A5:8A90 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8A93 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:8A96 AC 54 0E    LDY $0E54  [$7E:0E54]
$A5:8A99 AE AA 0F    LDX $0FAA  [$7E:0FAA]  ;\
$A5:8A9C E0 68 00    CPX #$0068             ;} If [Draygon swoop Y position index] = 68h:
$A5:8A9F D0 0C       BNE $0C    [$8AAD]     ;/
$A5:8AA1 A9 E7 97    LDA #$97E7             ;\
$A5:8AA4 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $97E7
$A5:8AA7 A9 01 00    LDA #$0001             ;\
$A5:8AAA 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1

$A5:8AAD BF 02 90 7E LDA $7E9002,x[$7E:9002];\
$A5:8AB1 99 7E 0F    STA $0F7E,y[$7E:0F7E]  ;} Draygon Y position = [$7E:9002 + [Draygon swoop Y position index]]
$A5:8AB4 EE AA 0F    INC $0FAA  [$7E:0FAA]  ;\
$A5:8AB7 EE AA 0F    INC $0FAA  [$7E:0FAA]  ;|
$A5:8ABA EE AA 0F    INC $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index += 4
$A5:8ABD EE AA 0F    INC $0FAA  [$7E:0FAA]  ;/
$A5:8AC0 AD AA 0F    LDA $0FAA  [$7E:0FAA]  ;\
$A5:8AC3 CD AC 0F    CMP $0FAC  [$7E:0FAC]  ;} If [Draygon swoop Y position index] != [Draygon swoop duration * 4]:
$A5:8AC6 F0 14       BEQ $14    [$8ADC]     ;/
$A5:8AC8 AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8ACB 38          SEC                    ;|
$A5:8ACC ED B0 0F    SBC $0FB0  [$7E:0FB0]  ;|
$A5:8ACF 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position -= [Draygon X speed]
$A5:8AD2 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8AD5 ED AE 0F    SBC $0FAE  [$7E:0FAE]  ;|
$A5:8AD8 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8ADB 60          RTS                    ; Return

$A5:8ADC AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A5:8ADF 29 01 00    AND #$0001             ;} If [random number] % 2 != 0:
$A5:8AE2 F0 18       BEQ $18    [$8AFC]     ;/
$A5:8AE4 A9 F4 87    LDA #$87F4             ;\
$A5:8AE7 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $87F4 (swoop right)
$A5:8AEA 9C AA 0F    STZ $0FAA  [$7E:0FAA]  ; Draygon swoop Y position index = 0
$A5:8AED AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A5:8AF1 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Draygon X position = [Draygon left side reset X position]
$A5:8AF4 AF 02 78 7E LDA $7E7802[$7E:7802]  ;\
$A5:8AF8 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Draygon Y position = [Draygon reset Y position]
$A5:8AFB 60          RTS                    ; Return

$A5:8AFC A9 0A 8B    LDA #$8B0A             ;\
$A5:8AFF 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8B0A
$A5:8B02 AF 00 78 7E LDA $7E7800[$7E:7800]  ;\
$A5:8B06 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Draygon X position = [Draygon left side reset X position]
$A5:8B09 60          RTS
}


;;; $8B0A: Draygon body function - goop right - setup ;;;
{
$A5:8B0A 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8B0D A9 B0 FF    LDA #$FFB0             ;\
$A5:8B10 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Draygon X position = -50h
$A5:8B13 A9 80 01    LDA #$0180             ;\
$A5:8B16 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Draygon Y position = 180h
$A5:8B19 A9 00 00    LDA #$0000             ;\
$A5:8B1C 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;|
$A5:8B1F A9 01 00    LDA #$0001             ;} Draygon X speed = 1.0
$A5:8B22 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;/
$A5:8B25 A9 00 00    LDA #$0000             ;\
$A5:8B28 8F 1A 78 7E STA $7E781A[$7E:781A]  ;} Draygon goop Y oscillation angle = 0
$A5:8B2C A9 06 9C    LDA #$9C06             ;\
$A5:8B2F 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9C06
$A5:8B32 A9 01 00    LDA #$0001             ;\
$A5:8B35 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1
$A5:8B38 A9 52 8B    LDA #$8B52             ;\
$A5:8B3B 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8B52
$A5:8B3E A9 D1 97    LDA #$97D1             ;\
$A5:8B41 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $97D1
$A5:8B44 A9 01 00    LDA #$0001             ;\
$A5:8B47 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:8B4A A9 01 00    LDA #$0001             ;\
$A5:8B4D 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = right
$A5:8B51 60          RTS
}


;;; $8B52: Draygon body function - goop right - move until Samus in range ;;;
{
$A5:8B52 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8B55 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:8B58 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:8B5B 38          SEC                    ;|
$A5:8B5C ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A5:8B5F 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;} If |[Draygon X position] - [Samus X position]| < D0h:
$A5:8B63 C9 D0 00    CMP #$00D0             ;|
$A5:8B66 10 0E       BPL $0E    [$8B76]     ;/
$A5:8B68 A9 AE 8B    LDA #$8BAE             ;\
$A5:8B6B 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8BAE
$A5:8B6E A9 10 00    LDA #$0010             ;\
$A5:8B71 8F 06 78 7E STA $7E7806[$7E:7806]  ;} Draygon goop counter = 10h
$A5:8B75 60          RTS                    ; Return

$A5:8B76 A9 20 00    LDA #$0020             ;\
$A5:8B79 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:8B7C AF 1A 78 7E LDA $7E781A[$7E:781A]  ;|
$A5:8B80 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon Y position = 180h + 20h * cos([Draygon goop Y oscillation angle] * pi / 80h) * FFh / 100h
$A5:8B84 18          CLC                    ;|
$A5:8B85 69 80 01    ADC #$0180             ;|
$A5:8B88 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8B8B AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A5:8B8F 18          CLC                    ;|
$A5:8B90 69 01 00    ADC #$0001             ;} Draygon goop Y oscillation angle = ([Draygon goop Y oscillation angle] + 1) % 100h
$A5:8B93 29 FF 00    AND #$00FF             ;|
$A5:8B96 8F 1A 78 7E STA $7E781A[$7E:781A]  ;/
$A5:8B9A AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8B9D 18          CLC                    ;|
$A5:8B9E 6D B0 0F    ADC $0FB0  [$7E:0FB0]  ;|
$A5:8BA1 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position += [Draygon X speed]
$A5:8BA4 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8BA7 6D AE 0F    ADC $0FAE  [$7E:0FAE]  ;|
$A5:8BAA 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8BAD 60          RTS
}


;;; $8BAE: Draygon body function - goop right - firing goops ;;;
{
$A5:8BAE 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8BB1 AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$A5:8BB4 D0 63       BNE $63    [$8C19]     ;} If [Samus X speed divisor] != 0: go to BRANCH_SAMUS_GOOPED
$A5:8BB6 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A5:8BB9 29 0F 00    AND #$000F             ;} If [random number] % 10h = 0:
$A5:8BBC D0 17       BNE $17    [$8BD5]     ;/
$A5:8BBE AF 06 78 7E LDA $7E7806[$7E:7806]  ;\
$A5:8BC2 3A          DEC A                  ;} Decrement Draygon goop counter
$A5:8BC3 8F 06 78 7E STA $7E7806[$7E:7806]  ;/
$A5:8BC7 F0 4B       BEQ $4B    [$8C14]     ; If [Draygon goop counter] = 0: go to BRANCH_DONE
$A5:8BC9 A0 90 9C    LDY #$9C90             ;\
$A5:8BCC 8C 92 0F    STY $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $9C90 <-- ok sure, we'll use the Y register this time
$A5:8BCF A9 01 00    LDA #$0001             ;\
$A5:8BD2 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1

$A5:8BD5 A9 20 00    LDA #$0020             ;\
$A5:8BD8 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:8BDB AF 1A 78 7E LDA $7E781A[$7E:781A]  ;|
$A5:8BDF 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon Y position = 180h + 20h * cos([Draygon goop Y oscillation angle] * pi / 80h) * FFh / 100h
$A5:8BE3 18          CLC                    ;|
$A5:8BE4 69 80 01    ADC #$0180             ;|
$A5:8BE7 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8BEA AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A5:8BEE 18          CLC                    ;|
$A5:8BEF 69 01 00    ADC #$0001             ;} Draygon goop Y oscillation angle = ([Draygon goop Y oscillation angle] + 1) % 100h
$A5:8BF2 29 FF 00    AND #$00FF             ;|
$A5:8BF5 8F 1A 78 7E STA $7E781A[$7E:781A]  ;/
$A5:8BF9 AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8BFC 18          CLC                    ;|
$A5:8BFD 6D B0 0F    ADC $0FB0  [$7E:0FB0]  ;|
$A5:8C00 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position += [Draygon X speed]
$A5:8C03 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8C06 6D AE 0F    ADC $0FAE  [$7E:0FAE]  ;|
$A5:8C09 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8C0C 30 05       BMI $05    [$8C13]
$A5:8C0E C9 A0 02    CMP #$02A0             ;\
$A5:8C11 10 01       BPL $01    [$8C14]     ;} If [Draygon X position] >= 2A0h: go to BRANCH_DONE

$A5:8C13 60          RTS                    ; Return

$A5:8C14 AD 66 0A    LDA $0A66  [$7E:0A66]
$A5:8C17 F0 07       BEQ $07    [$8C20]

; BRANCH_SAMUS_GOOPED
$A5:8C19 A9 19 8E    LDA #$8E19             ;\
$A5:8C1C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8E19
$A5:8C1F 60          RTS                    ; Return

; BRANCH_DONE
$A5:8C20 A9 DA 9B    LDA #$9BDA             ;\
$A5:8C23 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9BDA
$A5:8C26 A9 01 00    LDA #$0001             ;\
$A5:8C29 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1
$A5:8C2C A9 33 8C    LDA #$8C33             ;\
$A5:8C2F 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8C33
$A5:8C32 60          RTS
}


;;; $8C33: Draygon body function - goop right - move until off-screen ;;;
{
$A5:8C33 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:8C36 A9 20 00    LDA #$0020             ;\
$A5:8C39 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:8C3C AF 1A 78 7E LDA $7E781A[$7E:781A]  ;|
$A5:8C40 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon Y position = 180h + 20h * cos([Draygon goop Y oscillation angle] * pi / 80h) * FFh / 100h
$A5:8C44 18          CLC                    ;|
$A5:8C45 69 80 01    ADC #$0180             ;|
$A5:8C48 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8C4B AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A5:8C4F 18          CLC                    ;|
$A5:8C50 69 01 00    ADC #$0001             ;} Draygon goop Y oscillation angle = ([Draygon goop Y oscillation angle] + 1) % 100h
$A5:8C53 29 FF 00    AND #$00FF             ;|
$A5:8C56 8F 1A 78 7E STA $7E781A[$7E:781A]  ;/
$A5:8C5A AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8C5D 18          CLC                    ;|
$A5:8C5E 6D B0 0F    ADC $0FB0  [$7E:0FB0]  ;|
$A5:8C61 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position += [Draygon X speed]
$A5:8C64 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8C67 6D AE 0F    ADC $0FAE  [$7E:0FAE]  ;|
$A5:8C6A 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8C6D 30 05       BMI $05    [$8C74]
$A5:8C6F C9 A0 02    CMP #$02A0             ;\
$A5:8C72 10 01       BPL $01    [$8C75]     ;} If [Draygon X position] >= 2A0h: go to BRANCH_DONE

$A5:8C74 60          RTS                    ; Return

; BRANCH_DONE
$A5:8C75 A9 B3 89    LDA #$89B3             ;\
$A5:8C78 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $89B3 (swoop left)
$A5:8C7B A9 50 02    LDA #$0250             ;\
$A5:8C7E 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Draygon X position = 250h
$A5:8C81 A9 B0 FF    LDA #$FFB0             ;\
$A5:8C84 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Draygon Y position = -50h
$A5:8C87 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A5:8C8A 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index = [Draygon swoop duration * 4]
$A5:8C8D 60          RTS
}


;;; $8C8E: Draygon body function - goop left - setup ;;;
{
$A5:8C8E AF 04 78 7E LDA $7E7804[$7E:7804]  ;\
$A5:8C92 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Draygon X position = [Draygon right side reset X position]
$A5:8C95 A9 80 01    LDA #$0180             ;\
$A5:8C98 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Draygon Y position = 180h
$A5:8C9B A9 00 00    LDA #$0000             ;\
$A5:8C9E 8D B0 0F    STA $0FB0  [$7E:0FB0]  ;|
$A5:8CA1 A9 01 00    LDA #$0001             ;} Draygon X speed = 1.0
$A5:8CA4 8D AE 0F    STA $0FAE  [$7E:0FAE]  ;/
$A5:8CA7 A9 00 00    LDA #$0000             ;\
$A5:8CAA 8F 1A 78 7E STA $7E781A[$7E:781A]  ;} Draygon goop Y oscillation angle = 0
$A5:8CAE A9 06 9C    LDA #$9C06             ;\
$A5:8CB1 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $9C06
$A5:8CB4 A9 01 00    LDA #$0001             ;\
$A5:8CB7 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1
$A5:8CBA A9 D4 8C    LDA #$8CD4             ;\
$A5:8CBD 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8CD4
$A5:8CC0 A9 BB 97    LDA #$97BB             ;\
$A5:8CC3 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $97BB
$A5:8CC6 A9 01 00    LDA #$0001             ;\
$A5:8CC9 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:8CCC A9 00 00    LDA #$0000             ;\
$A5:8CCF 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = left
$A5:8CD3 60          RTS
}


;;; $8CD4: Draygon body function - goop left - move until Samus in range ;;;
{
$A5:8CD4 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8CD7 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:8CDA AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:8CDD 38          SEC                    ;|
$A5:8CDE ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A5:8CE1 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;} If |[Draygon X position] - [Samus X position]| < D0h:
$A5:8CE5 C9 D0 00    CMP #$00D0             ;|
$A5:8CE8 10 0E       BPL $0E    [$8CF8]     ;/
$A5:8CEA A9 30 8D    LDA #$8D30             ;\
$A5:8CED 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8D30
$A5:8CF0 A9 10 00    LDA #$0010             ;\
$A5:8CF3 8F 06 78 7E STA $7E7806[$7E:7806]  ;} Draygon goop counter = 10h
$A5:8CF7 60          RTS                    ; Return

$A5:8CF8 A9 20 00    LDA #$0020             ;\
$A5:8CFB 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:8CFE AF 1A 78 7E LDA $7E781A[$7E:781A]  ;|
$A5:8D02 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon Y position = 180h + 20h * cos([Draygon goop Y oscillation angle] * pi / 80h) * FFh / 100h
$A5:8D06 18          CLC                    ;|
$A5:8D07 69 80 01    ADC #$0180             ;|
$A5:8D0A 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8D0D AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A5:8D11 18          CLC                    ;|
$A5:8D12 69 01 00    ADC #$0001             ;} Draygon goop Y oscillation angle = ([Draygon goop Y oscillation angle] + 1) % 100h
$A5:8D15 29 FF 00    AND #$00FF             ;|
$A5:8D18 8F 1A 78 7E STA $7E781A[$7E:781A]  ;/
$A5:8D1C AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8D1F 38          SEC                    ;|
$A5:8D20 ED B0 0F    SBC $0FB0  [$7E:0FB0]  ;|
$A5:8D23 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position -= [Draygon X speed]
$A5:8D26 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8D29 ED AE 0F    SBC $0FAE  [$7E:0FAE]  ;|
$A5:8D2C 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8D2F 60          RTS
}


;;; $8D30: Draygon body function - goop left - firing goops ;;;
{
$A5:8D30 AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$A5:8D33 D0 63       BNE $63    [$8D98]     ;} If [Samus X speed divisor] != 0: go to BRANCH_SAMUS_GOOPED
$A5:8D35 AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A5:8D38 29 0F 00    AND #$000F             ;} If [random number] % 10h = 0:
$A5:8D3B D0 17       BNE $17    [$8D54]     ;/
$A5:8D3D AF 06 78 7E LDA $7E7806[$7E:7806]  ;\
$A5:8D41 3A          DEC A                  ;} Decrement Draygon goop counter
$A5:8D42 8F 06 78 7E STA $7E7806[$7E:7806]  ;/
$A5:8D46 F0 4B       BEQ $4B    [$8D93]     ; If [Draygon goop counter] = 0: go to BRANCH_DONE
$A5:8D48 A0 FE 98    LDY #$98FE             ;\
$A5:8D4B 8C 92 0F    STY $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = $98FE <-- ok sure, we'll use the Y register this time
$A5:8D4E A9 01 00    LDA #$0001             ;\
$A5:8D51 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1

$A5:8D54 A9 20 00    LDA #$0020             ;\
$A5:8D57 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:8D5A AF 1A 78 7E LDA $7E781A[$7E:781A]  ;|
$A5:8D5E 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon Y position = 180h + 20h * cos([Draygon goop Y oscillation angle] * pi / 80h) * FFh / 100h
$A5:8D62 18          CLC                    ;|
$A5:8D63 69 80 01    ADC #$0180             ;|
$A5:8D66 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8D69 AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A5:8D6D 18          CLC                    ;|
$A5:8D6E 69 01 00    ADC #$0001             ;} Draygon goop Y oscillation angle = ([Draygon goop Y oscillation angle] + 1) % 100h
$A5:8D71 29 FF 00    AND #$00FF             ;|
$A5:8D74 8F 1A 78 7E STA $7E781A[$7E:781A]  ;/
$A5:8D78 AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8D7B 38          SEC                    ;|
$A5:8D7C ED B0 0F    SBC $0FB0  [$7E:0FB0]  ;|
$A5:8D7F 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position -= [Draygon X speed]
$A5:8D82 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8D85 ED AE 0F    SBC $0FAE  [$7E:0FAE]  ;|
$A5:8D88 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8D8B 10 05       BPL $05    [$8D92]
$A5:8D8D C9 B0 FF    CMP #$FFB0             ;\
$A5:8D90 30 01       BMI $01    [$8D93]     ;} If [Draygon X position] < -50h: go to BRANCH_DONE

$A5:8D92 60          RTS                    ; Return

$A5:8D93 AD 66 0A    LDA $0A66  [$7E:0A66]
$A5:8D96 F0 07       BEQ $07    [$8D9F]

; BRANCH_SAMUS_GOOPED
$A5:8D98 A9 19 8E    LDA #$8E19             ;\
$A5:8D9B 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8E19
$A5:8D9E 60          RTS                    ; Return

; BRANCH_DONE
$A5:8D9F A9 E7 97    LDA #$97E7             ;\
$A5:8DA2 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = $97E7
$A5:8DA5 A9 01 00    LDA #$0001             ;\
$A5:8DA8 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1
$A5:8DAB A9 B2 8D    LDA #$8DB2             ;\
$A5:8DAE 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8DB2
$A5:8DB1 60          RTS
}


;;; $8DB2: Draygon body function - goop left - move until off-screen ;;;
{
$A5:8DB2 20 1C 93    JSR $931C  [$A5:931C]  ; Handle short Draygon breath bubbles
$A5:8DB5 AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$A5:8DB8 D0 3F       BNE $3F    [$8DF9]     ;} If [Samus X speed divisor] != 0: go to BRANCH_SAMUS_GOOPED
$A5:8DBA A9 20 00    LDA #$0020             ;\
$A5:8DBD 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:8DC0 AF 1A 78 7E LDA $7E781A[$7E:781A]  ;|
$A5:8DC4 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon Y position = 180h + 20h * cos([Draygon goop Y oscillation angle] * pi / 80h) * FFh / 100h
$A5:8DC8 18          CLC                    ;|
$A5:8DC9 69 80 01    ADC #$0180             ;|
$A5:8DCC 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:8DCF AF 1A 78 7E LDA $7E781A[$7E:781A]  ;\
$A5:8DD3 18          CLC                    ;|
$A5:8DD4 69 01 00    ADC #$0001             ;} Draygon goop Y oscillation angle = ([Draygon goop Y oscillation angle] + 1) % 100h
$A5:8DD7 29 FF 00    AND #$00FF             ;|
$A5:8DDA 8F 1A 78 7E STA $7E781A[$7E:781A]  ;/
$A5:8DDE AD 7C 0F    LDA $0F7C  [$7E:0F7C]  ;\
$A5:8DE1 38          SEC                    ;|
$A5:8DE2 ED B0 0F    SBC $0FB0  [$7E:0FB0]  ;|
$A5:8DE5 8D 7C 0F    STA $0F7C  [$7E:0F7C]  ;} Draygon X position -= [Draygon X speed]
$A5:8DE8 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;|
$A5:8DEB ED AE 0F    SBC $0FAE  [$7E:0FAE]  ;|
$A5:8DEE 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:8DF1 10 05       BPL $05    [$8DF8]
$A5:8DF3 C9 B0 FF    CMP #$FFB0             ;\
$A5:8DF6 30 08       BMI $08    [$8E00]     ;} If [Draygon X position] < -50h: go to BRANCH_DONE

$A5:8DF8 60          RTS                    ; Return

; BRANCH_SAMUS_GOOPED
$A5:8DF9 A9 19 8E    LDA #$8E19             ;\
$A5:8DFC 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8E19
$A5:8DFF 60          RTS                    ; Return

; BRANCH_DONE
$A5:8E00 A9 F4 87    LDA #$87F4             ;\
$A5:8E03 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $87F4 (swoop right)
$A5:8E06 A9 B0 FF    LDA #$FFB0             ;\
$A5:8E09 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;} Draygon X position = -50h
$A5:8E0C A9 B0 FF    LDA #$FFB0             ;\
$A5:8E0F 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;} Draygon Y position = -50h
$A5:8E12 AD AC 0F    LDA $0FAC  [$7E:0FAC]  ;\
$A5:8E15 8D AA 0F    STA $0FAA  [$7E:0FAA]  ;} Draygon swoop Y position index = [Draygon swoop duration * 4]
$A5:8E18 60          RTS
}


;;; $8E19: Draygon body function -  ;;;
{
; Hone in on Samus to grab her
$A5:8E19 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:8E1C AD 66 0A    LDA $0A66  [$7E:0A66]  ;\
$A5:8E1F D0 07       BNE $07    [$8E28]     ;} If [Samus X speed divisor] = 0:
$A5:8E21 A9 54 91    LDA #$9154             ;\
$A5:8E24 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $9154
$A5:8E27 60          RTS                    ; Return

$A5:8E28 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A5:8E2B 09 00 04    ORA #$0400             ;} Set Draygon body as intangible
$A5:8E2E 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A5:8E31 A0 08 00    LDY #$0008             ; Y = 8
$A5:8E34 AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A5:8E38 D0 03       BNE $03    [$8E3D]     ;} If [Draygon facing direction] = left:
$A5:8E3A A0 F8 FF    LDY #$FFF8             ; Y = -8

$A5:8E3D 98          TYA                    ;\
$A5:8E3E 18          CLC                    ;|
$A5:8E3F 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;|
$A5:8E42 38          SEC                    ;|
$A5:8E43 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;} If |[Draygon X position] + [Y] - [Samus X position]| < 8:
$A5:8E46 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;|
$A5:8E4A C9 08 00    CMP #$0008             ;|
$A5:8E4D 10 12       BPL $12    [$8E61]     ;/
$A5:8E4F AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:8E52 38          SEC                    ;|
$A5:8E53 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$A5:8E56 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;} If |[Draygon Y position] - [Samus Y position]| < 8:
$A5:8E5A C9 08 00    CMP #$0008             ;|
$A5:8E5D 10 02       BPL $02    [$8E61]     ;/
$A5:8E5F 80 48       BRA $48    [$8EA9]     ; Go to BRANCH_GRAB

$A5:8E61 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A5:8E64 38          SEC                    ;|
$A5:8E65 ED 7A 0F    SBC $0F7A  [$7E:0F7A]  ;|
$A5:8E68 85 12       STA $12    [$7E:0012]  ;|
$A5:8E6A AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;} A = angle from Draygon position to Samus position
$A5:8E6D 38          SEC                    ;|
$A5:8E6E ED 7E 0F    SBC $0F7E  [$7E:0F7E]  ;|
$A5:8E71 85 14       STA $14    [$7E:0014]  ;|
$A5:8E73 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A5:8E77 49 FF 00    EOR #$00FF             ;\
$A5:8E7A 1A          INC A                  ;|
$A5:8E7B 18          CLC                    ;|
$A5:8E7C 69 40 00    ADC #$0040             ;} $0E20 = (40h - [A]) % 100h (angle using the common maths convention)
$A5:8E7F 29 FF 00    AND #$00FF             ;|
$A5:8E82 8D 20 0E    STA $0E20  [$7E:0E20]  ;/
$A5:8E85 85 12       STA $12    [$7E:0012]  ;\
$A5:8E87 A9 02 00    LDA #$0002             ;|
$A5:8E8A 85 14       STA $14    [$7E:0014]  ;} ($16.$18, $1A.$1C) = (2 * |cos([$0E20] * pi / 80h)|, 2 * |sin([$0E20] * pi / 80h)|)
$A5:8E8C 22 43 B6 A0 JSL $A0B643[$A0:B643]  ;/
$A5:8E90 A5 16       LDA $16    [$7E:0016]  ;\
$A5:8E92 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$A5:8E95 A5 18       LDA $18    [$7E:0018]  ;} $0E24.$0E26 = [$16].[$18] (X speed)
$A5:8E97 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$A5:8E9A A5 1A       LDA $1A    [$7E:001A]  ;\
$A5:8E9C 8D 28 0E    STA $0E28  [$7E:0E28]  ;|
$A5:8E9F A5 1C       LDA $1C    [$7E:001C]  ;} $0E28.$0E2A = [$1A].[$1C] (Y speed)
$A5:8EA1 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/
$A5:8EA4 22 91 B6 A0 JSL $A0B691[$A0:B691]  ; Move enemy according to angle and X/Y speeds
$A5:8EA8 60          RTS                    ; Return

; BRANCH_GRAB
$A5:8EA9 A0 45 98    LDY #$9845             ; Draygon arms instruction list pointer = $9845
$A5:8EAC AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A5:8EB0 F0 03       BEQ $03    [$8EB5]     ;} If [Draygon facing direction] != left:
$A5:8EB2 A0 38 9C    LDY #$9C38             ; Draygon arms instruction list pointer = $9C38

$A5:8EB5 8C 52 10    STY $1052  [$7E:1052]
$A5:8EB8 A9 01 00    LDA #$0001             ;\
$A5:8EBB 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1
$A5:8EBE A9 0D 00    LDA #$000D             ;\
$A5:8EC1 22 84 F0 90 JSL $90F084[$90:F084]  ;|
$A5:8EC5 29 FF FF    AND #$FFFF             ;} If grapple beam is active: go to BRANCH_RETREAT
$A5:8EC8 D0 3F       BNE $3F    [$8F09]     ;/
$A5:8ECA A0 00 00    LDY #$0000             ;\
$A5:8ECD AF 00 80 7E LDA $7E8000[$7E:8000]  ;|
$A5:8ED1 F0 03       BEQ $03    [$8ED6]     ;|
$A5:8ED3 A0 01 00    LDY #$0001             ;} A = [Draygon facing direction]
                                            ;|
$A5:8ED6 98          TYA                    ;/
$A5:8ED7 22 3B E2 90 JSL $90E23B[$90:E23B]  ; Set Samus into the grabbed by Draygon pose
$A5:8EDB A9 00 01    LDA #$0100             ;\
$A5:8EDE 8F 0C 78 7E STA $7E780C[$7E:780C]  ;} Draygon spiral X position = 100h
$A5:8EE2 A9 80 01    LDA #$0180             ;\
$A5:8EE5 8F 0E 78 7E STA $7E780E[$7E:780E]  ;} Draygon spiral Y position = 180h
$A5:8EE9 A9 00 00    LDA #$0000             ;\
$A5:8EEC 8F 0A 78 7E STA $7E780A[$7E:780A]  ;} Draygon spiral X radius = 0.0
$A5:8EF0 8F 12 78 7E STA $7E7812[$7E:7812]  ;/
$A5:8EF4 A9 C0 00    LDA #$00C0             ;\
$A5:8EF7 8F 10 78 7E STA $7E7810[$7E:7810]  ;} Draygon spiral angle = C0h
$A5:8EFB A9 00 08    LDA #$0800             ;\
$A5:8EFE 8F 16 78 7E STA $7E7816[$7E:7816]  ;} Draygon spiral angle delta = 800h
$A5:8F02 A9 1E 8F    LDA #$8F1E             ;\
$A5:8F05 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8F1E
$A5:8F08 60          RTS                    ; Return

; BRANCH_RETREAT
$A5:8F09 A9 10 8F    LDA #$8F10             ;\
$A5:8F0C 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8F10
$A5:8F0F 60          RTS
}


;;; $8F10: Draygon body function -  ;;;
{
$A5:8F10 A9 C5 C8    LDA #$C8C5             ;\
$A5:8F13 8D 32 0D    STA $0D32  [$7E:0D32]  ;} Grapple beam function = dropped
$A5:8F16 A9 28 91    LDA #$9128             ;\
$A5:8F19 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $9128
$A5:8F1C 60          RTS
}


;;; $8F1D: Unused. RTS ;;;
{
$A5:8F1D 60          RTS
}


;;; $8F1E: Draygon body function -  ;;;
{
; Grabbed Samus, moving to target position
$A5:8F1E AD 64 0A    LDA $0A64  [$7E:0A64]  ;\
$A5:8F21 89 01 00    BIT #$0001             ;} If grapple connected with block:
$A5:8F24 F0 1D       BEQ $1D    [$8F43]     ;/
$A5:8F26 DA          PHX
$A5:8F27 AE 78 0F    LDX $0F78  [$7E:0F78]  ;\
$A5:8F2A BF 0D 00 A0 LDA $A0000D,x          ;|
$A5:8F2E 29 FF 00    AND #$00FF             ;|
$A5:8F31 18          CLC                    ;} Draygon body flash timer = (Draygon body hurt AI time) + 8
$A5:8F32 69 08 00    ADC #$0008             ;|
$A5:8F35 8D 9C 0F    STA $0F9C  [$7E:0F9C]  ;/
$A5:8F38 FA          PLX
$A5:8F39 AD 8A 0F    LDA $0F8A  [$7E:0F8A]  ;\
$A5:8F3C 09 02 00    ORA #$0002             ;} Draygon body AI handler |= hurt AI
$A5:8F3F 8D 8A 0F    STA $0F8A  [$7E:0F8A]  ;/
$A5:8F42 60          RTS                    ; Return

$A5:8F43 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:8F46 38          SEC                    ;|
$A5:8F47 E9 00 01    SBC #$0100             ;|
$A5:8F4A 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;} If |[Draygon X position] - 100h| < 2:
$A5:8F4E C9 02 00    CMP #$0002             ;|
$A5:8F51 10 12       BPL $12    [$8F65]     ;/
$A5:8F53 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:8F56 38          SEC                    ;|
$A5:8F57 E9 80 01    SBC #$0180             ;|
$A5:8F5A 22 67 B0 A0 JSL $A0B067[$A0:B067]  ;} If |[Draygon Y position] - 180h| < 2:
$A5:8F5E C9 02 00    CMP #$0002             ;|
$A5:8F61 10 02       BPL $02    [$8F65]     ;/
$A5:8F63 80 4B       BRA $4B    [$8FB0]     ; Go to BRANCH_REACHED_TARGET_POSITION

$A5:8F65 A9 00 01    LDA #$0100             ;\
$A5:8F68 38          SEC                    ;|
$A5:8F69 ED 7A 0F    SBC $0F7A  [$7E:0F7A]  ;|
$A5:8F6C 85 12       STA $12    [$7E:0012]  ;|
$A5:8F6E A9 80 01    LDA #$0180             ;} A = angle from Draygon position to (100h, 180h)
$A5:8F71 38          SEC                    ;|
$A5:8F72 ED 7E 0F    SBC $0F7E  [$7E:0F7E]  ;|
$A5:8F75 85 14       STA $14    [$7E:0014]  ;|
$A5:8F77 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A5:8F7B 49 FF 00    EOR #$00FF             ;\
$A5:8F7E 1A          INC A                  ;|
$A5:8F7F 18          CLC                    ;|
$A5:8F80 69 40 00    ADC #$0040             ;} $0E20 = (40h - [A]) % 100h (angle using the common maths convention)
$A5:8F83 29 FF 00    AND #$00FF             ;|
$A5:8F86 8D 20 0E    STA $0E20  [$7E:0E20]  ;/
$A5:8F89 85 12       STA $12    [$7E:0012]  ;\
$A5:8F8B A9 02 00    LDA #$0002             ;|
$A5:8F8E 85 14       STA $14    [$7E:0014]  ;} ($16.$18, $1A.$1C) = (2 * |cos([$0E20] * pi / 80h)|, 2 * |sin([$0E20] * pi / 80h)|)
$A5:8F90 22 43 B6 A0 JSL $A0B643[$A0:B643]  ;/
$A5:8F94 A5 16       LDA $16    [$7E:0016]  ;\
$A5:8F96 8D 24 0E    STA $0E24  [$7E:0E24]  ;|
$A5:8F99 A5 18       LDA $18    [$7E:0018]  ;} $0E24.$0E26 = [$16].[$18] (X speed)
$A5:8F9B 8D 26 0E    STA $0E26  [$7E:0E26]  ;/
$A5:8F9E A5 1A       LDA $1A    [$7E:001A]  ;\
$A5:8FA0 8D 28 0E    STA $0E28  [$7E:0E28]  ;|
$A5:8FA3 A5 1C       LDA $1C    [$7E:001C]  ;} $0E28.$0E2A = [$1A].[$1C] (Y speed)
$A5:8FA5 8D 2A 0E    STA $0E2A  [$7E:0E2A]  ;/
$A5:8FA8 22 91 B6 A0 JSL $A0B691[$A0:B691]  ; Move enemy according to angle and X/Y speeds
$A5:8FAC 20 A9 94    JSR $94A9  [$A5:94A9]  ; Move Samus with Draygon
$A5:8FAF 60          RTS                    ; Return

; BRANCH_REACHED_TARGET_POSITION
$A5:8FB0 A9 D6 8F    LDA #$8FD6             ;\
$A5:8FB3 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $8FD6
$A5:8FB6 A0 22 99    LDY #$9922             ; Draygon body instruction list pointer = $9922
$A5:8FB9 AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A5:8FBD F0 03       BEQ $03    [$8FC2]     ;} If [Draygon facing direction] != left:
$A5:8FBF A0 B4 9C    LDY #$9CB4             ; Draygon body instruction list pointer = $9CB4

$A5:8FC2 98          TYA
$A5:8FC3 9D 92 0F    STA $0F92,x[$7E:0F92]
$A5:8FC6 A9 01 00    LDA #$0001             ;\
$A5:8FC9 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:8FCC AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A5:8FCF 09 00 04    ORA #$0400             ;} Set Draygon body as intangible
$A5:8FD2 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A5:8FD5 60          RTS
}


;;; $8FD6: Draygon body function -  ;;;
{
; Grabbed Samus, do rising spiral movement
$A5:8FD6 AD 64 0A    LDA $0A64  [$7E:0A64]  ;\
$A5:8FD9 89 01 00    BIT #$0001             ;} If grapple connected with block:
$A5:8FDC F0 1D       BEQ $1D    [$8FFB]     ;/
$A5:8FDE DA          PHX
$A5:8FDF AE 78 0F    LDX $0F78  [$7E:0F78]  ;\
$A5:8FE2 BF 0D 00 A0 LDA $A0000D,x          ;|
$A5:8FE6 29 FF 00    AND #$00FF             ;|
$A5:8FE9 18          CLC                    ;} Draygon body flash timer = (Draygon body hurt AI time) + 8
$A5:8FEA 69 08 00    ADC #$0008             ;|
$A5:8FED 8D 9C 0F    STA $0F9C  [$7E:0F9C]  ;/
$A5:8FF0 FA          PLX
$A5:8FF1 AD 8A 0F    LDA $0F8A  [$7E:0F8A]  ;\
$A5:8FF4 09 02 00    ORA #$0002             ;} Draygon body AI handler |= hurt AI
$A5:8FF7 8D 8A 0F    STA $0F8A  [$7E:0F8A]  ;/
$A5:8FFA 60          RTS                    ; Return

$A5:8FFB AD E5 05    LDA $05E5  [$7E:05E5]  ;\
$A5:8FFE 29 FF 00    AND #$00FF             ;} If [random number] % 100h = 0:
$A5:9001 D0 0E       BNE $0E    [$9011]     ;/
$A5:9003 A9 40 00    LDA #$0040             ;\
$A5:9006 8F 18 78 7E STA $7E7818[$7E:7818]  ;} $7E:7818 = 40h
$A5:900A A9 D4 90    LDA #$90D4             ;\
$A5:900D 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $90D4
$A5:9010 60          RTS                    ; Return

$A5:9011 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A5:9015 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:9018 AF 10 78 7E LDA $7E7810[$7E:7810]  ;|
$A5:901C 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Draygon X position = [Draygon spiral X position] + [Draygon spiral X radius] * cos([Draygon spiral angle] * pi / 80h) * FFh / 100h
$A5:9020 18          CLC                    ;|
$A5:9021 6F 0C 78 7E ADC $7E780C[$7E:780C]  ;|
$A5:9025 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:9028 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A5:902C 4A          LSR A                  ;|
$A5:902D 4A          LSR A                  ;|
$A5:902E 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:9031 AF 10 78 7E LDA $7E7810[$7E:7810]  ;} Draygon Y position = [Draygon spiral Y position] - [Draygon spiral X radius] / 4 * sin([Draygon spiral angle] * pi / 80h) * FFh / 100h
$A5:9035 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A5:9039 18          CLC                    ;|
$A5:903A 6F 0E 78 7E ADC $7E780E[$7E:780E]  ;|
$A5:903E 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:9041 BD A4 0F    LDA $0FA4,x[$7E:0FA4]  ;\
$A5:9044 29 07 00    AND #$0007             ;} If [Draygon body frame counter] % 8 != 0: go to BRANCH_NO_FOAM
$A5:9047 D0 2C       BNE $2C    [$9075]     ;/
$A5:9049 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:904C 38          SEC                    ;|
$A5:904D E9 20 00    SBC #$0020             ;} $12 = [Draygon X position] - 20h
$A5:9050 85 12       STA $12    [$7E:0012]  ;/
$A5:9052 AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A5:9056 F0 09       BEQ $09    [$9061]     ;} If [Draygon facing direction] != left:
$A5:9058 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:905B 18          CLC                    ;|
$A5:905C 69 20 00    ADC #$0020             ;} $12 = [Draygon X position] + 20h
$A5:905F 85 12       STA $12    [$7E:0012]  ;/

$A5:9061 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:9064 38          SEC                    ;|
$A5:9065 E9 10 00    SBC #$0010             ;} $14 = [Draygon Y position] - 10h
$A5:9068 85 14       STA $14    [$7E:0014]  ;/
$A5:906A A9 3D 00    LDA #$003D             ;\
$A5:906D 85 16       STA $16    [$7E:0016]  ;|
$A5:906F 64 18       STZ $18    [$7E:0018]  ;} Create sprite object 3Dh (Draygon foaming at the mouth) at position ([$12], [$14]) with palette 0
$A5:9071 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

; BRANCH_NO_FOAM
$A5:9075 AF 12 78 7E LDA $7E7812[$7E:7812]  ;\
$A5:9079 18          CLC                    ;|
$A5:907A 69 00 20    ADC #$2000             ;|
$A5:907D 8F 12 78 7E STA $7E7812[$7E:7812]  ;} Draygon spiral X radius += 0.2000h
$A5:9081 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;|
$A5:9085 69 00 00    ADC #$0000             ;|
$A5:9088 8F 0A 78 7E STA $7E780A[$7E:780A]  ;/
$A5:908C C9 A0 00    CMP #$00A0             ;\
$A5:908F 10 3C       BPL $3C    [$90CD]     ;} If [Draygon spiral X radius] < A0h:
$A5:9091 AF 16 78 7E LDA $7E7816[$7E:7816]  ;\
$A5:9095 38          SEC                    ;|
$A5:9096 E9 01 00    SBC #$0001             ;} Draygon spiral angle delta -= 1
$A5:9099 8F 16 78 7E STA $7E7816[$7E:7816]  ;/
$A5:909D 29 00 FF    AND #$FF00             ;\
$A5:90A0 EB          XBA                    ;|
$A5:90A1 18          CLC                    ;|
$A5:90A2 6F 10 78 7E ADC $7E7810[$7E:7810]  ;} Draygon spiral angle = ([Draygon spiral angle] + [Draygon spiral angle delta] / 100h) % 100h
$A5:90A6 29 FF 00    AND #$00FF             ;|
$A5:90A9 8F 10 78 7E STA $7E7810[$7E:7810]  ;/
$A5:90AD AF 14 78 7E LDA $7E7814[$7E:7814]  ;\
$A5:90B1 38          SEC                    ;|
$A5:90B2 E9 00 40    SBC #$4000             ;|
$A5:90B5 8F 14 78 7E STA $7E7814[$7E:7814]  ;} Draygon spiral Y position -= 0.4000h
$A5:90B9 AF 0E 78 7E LDA $7E780E[$7E:780E]  ;|
$A5:90BD E9 00 00    SBC #$0000             ;|
$A5:90C0 8F 0E 78 7E STA $7E780E[$7E:780E]  ;/
$A5:90C4 C9 40 00    CMP #$0040             ;\
$A5:90C7 30 04       BMI $04    [$90CD]     ;} If [Draygon spiral Y position] >= 40h:
$A5:90C9 20 A9 94    JSR $94A9  [$A5:94A9]  ; Move Samus with Draygon
$A5:90CC 60          RTS                    ; Return

$A5:90CD A9 05 91    LDA #$9105             ;\
$A5:90D0 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $9105
$A5:90D3 60          RTS
}


;;; $90D4: Draygon body function -  ;;;
{
; tail whip
$A5:90D4 20 A9 94    JSR $94A9  [$A5:94A9]  ; Move Samus with Draygon
$A5:90D7 AF 18 78 7E LDA $7E7818[$7E:7818]
$A5:90DB 3A          DEC A
$A5:90DC 8F 18 78 7E STA $7E7818[$7E:7818]
$A5:90E0 F0 1C       BEQ $1C    [$90FE]
$A5:90E2 C9 3F 00    CMP #$003F
$A5:90E5 F0 01       BEQ $01    [$90E8]
$A5:90E7 60          RTS

$A5:90E8 A0 E8 9A    LDY #$9AE8
$A5:90EB AF 00 80 7E LDA $7E8000[$7E:8000]
$A5:90EF F0 03       BEQ $03    [$90F4]
$A5:90F1 A0 A1 9E    LDY #$9EA1

$A5:90F4 8C 12 10    STY $1012  [$7E:1012]
$A5:90F7 A9 01 00    LDA #$0001
$A5:90FA 8D 14 10    STA $1014  [$7E:1014]
$A5:90FD 60          RTS

$A5:90FE A9 D6 8F    LDA #$8FD6
$A5:9101 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9104 60          RTS
}


;;; $9105: Draygon body function -  ;;;
{
; final tail whip before releasing Samus
$A5:9105 20 A9 94    JSR $94A9  [$A5:94A9]  ; Move Samus with Draygon
$A5:9108 A0 68 9A    LDY #$9A68
$A5:910B BF 00 80 7E LDA $7E8000,x
$A5:910F F0 03       BEQ $03    [$9114]
$A5:9111 A0 21 9E    LDY #$9E21

$A5:9114 8C 12 10    STY $1012  [$7E:1012]
$A5:9117 A9 01 00    LDA #$0001
$A5:911A 8D 14 10    STA $1014  [$7E:1014]
$A5:911D A9 24 91    LDA #$9124
$A5:9120 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9123 60          RTS
}


;;; $9124: Draygon body function -  ;;;
{
$A5:9124 20 A9 94    JSR $94A9  [$A5:94A9]  ; Move Samus with Draygon
$A5:9127 60          RTS
}


;;; $9128: Draygon body function -  ;;;
{
$A5:9128 22 D4 E2 90 JSL $90E2D4[$90:E2D4]  ; Release Samus from Draygon
$A5:912C 9C 64 0A    STZ $0A64  [$7E:0A64]
$A5:912F A9 54 91    LDA #$9154
$A5:9132 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9135 AD 86 0F    LDA $0F86  [$7E:0F86]
$A5:9138 29 FF FB    AND #$FBFF
$A5:913B 8D 86 0F    STA $0F86  [$7E:0F86]
$A5:913E A0 5A 9B    LDY #$9B5A
$A5:9141 AF 00 80 7E LDA $7E8000[$7E:8000]
$A5:9145 F0 03       BEQ $03    [$914A]
$A5:9147 A0 15 9F    LDY #$9F15

$A5:914A 8C 12 10    STY $1012  [$7E:1012]
$A5:914D A9 01 00    LDA #$0001
$A5:9150 8D 14 10    STA $1014  [$7E:1014]
$A5:9153 60          RTS
}


;;; $9154: Draygon body function -  ;;;
{
; fly straight up
$A5:9154 20 AA 87    JSR $87AA  [$A5:87AA]  ; Handle firing wall turret
$A5:9157 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:915A 38          SEC
$A5:915B E9 04 00    SBC #$0004
$A5:915E 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A5:9161 30 01       BMI $01    [$9164]
$A5:9163 60          RTS

$A5:9164 AD 86 0F    LDA $0F86  [$7E:0F86]
$A5:9167 29 FF FB    AND #$FBFF
$A5:916A 8D 86 0F    STA $0F86  [$7E:0F86]
$A5:916D A9 F4 87    LDA #$87F4
$A5:9170 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9173 9C AA 0F    STZ $0FAA  [$7E:0FAA]
$A5:9176 AF 00 78 7E LDA $7E7800[$7E:7800]
$A5:917A 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A5:917D AF 02 78 7E LDA $7E7802[$7E:7802]
$A5:9181 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A5:9184 60          RTS
}


;;; $9185: Draygon body function -  ;;;
{
; move to death spot
$A5:9185 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:9188 BD A4 0F    LDA $0FA4,x[$7E:0FA4]  ;\
$A5:918B 29 0F 00    AND #$000F             ;} If [Draygon body frame counter] % 10h != 0: go to BRANCH_NO_FOAM
$A5:918E D0 2C       BNE $2C    [$91BC]     ;/
$A5:9190 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:9193 38          SEC                    ;|
$A5:9194 E9 20 00    SBC #$0020             ;} $12 = [Draygon X position] - 20h
$A5:9197 85 12       STA $12    [$7E:0012]  ;/
$A5:9199 AF 00 80 7E LDA $7E8000[$7E:8000]  ;\
$A5:919D F0 09       BEQ $09    [$91A8]     ;} If [Draygon facing direction] != left:
$A5:919F AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:91A2 18          CLC                    ;|
$A5:91A3 69 20 00    ADC #$0020             ;} $12 = [Draygon X position] + 20h
$A5:91A6 85 12       STA $12    [$7E:0012]  ;/
                                            
$A5:91A8 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:91AB 38          SEC                    ;|
$A5:91AC E9 10 00    SBC #$0010             ;} $14 = [Draygon Y position] - 10h
$A5:91AF 85 14       STA $14    [$7E:0014]  ;/
$A5:91B1 A9 3D 00    LDA #$003D             ;\
$A5:91B4 85 16       STA $16    [$7E:0016]  ;|
$A5:91B6 64 18       STZ $18    [$7E:0018]  ;} Create sprite object 3Dh (Draygon foaming at the mouth) at position ([$12], [$14]) with palette 0
$A5:91B8 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

; BRANCH_NO_FOAM
$A5:91BC AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:91BF 4A          LSR A
$A5:91C0 4A          LSR A
$A5:91C1 85 12       STA $12    [$7E:0012]
$A5:91C3 A9 00 01    LDA #$0100
$A5:91C6 4A          LSR A
$A5:91C7 4A          LSR A
$A5:91C8 38          SEC
$A5:91C9 E5 12       SBC $12    [$7E:0012]
$A5:91CB 85 12       STA $12    [$7E:0012]
$A5:91CD AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:91D0 4A          LSR A
$A5:91D1 4A          LSR A
$A5:91D2 85 14       STA $14    [$7E:0014]
$A5:91D4 A9 E0 01    LDA #$01E0
$A5:91D7 4A          LSR A
$A5:91D8 4A          LSR A
$A5:91D9 38          SEC
$A5:91DA E5 14       SBC $14    [$7E:0014]
$A5:91DC 85 14       STA $14    [$7E:0014]
$A5:91DE 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]
$A5:91E2 38          SEC
$A5:91E3 E9 40 00    SBC #$0040
$A5:91E6 49 FF FF    EOR #$FFFF
$A5:91E9 1A          INC A
$A5:91EA 29 FF 00    AND #$00FF
$A5:91ED 8F 06 88 7E STA $7E8806[$7E:8806]
$A5:91F1 A9 01 00    LDA #$0001
$A5:91F4 85 14       STA $14    [$7E:0014]
$A5:91F6 AF 06 88 7E LDA $7E8806[$7E:8806]
$A5:91FA 29 FF 00    AND #$00FF
$A5:91FD 85 12       STA $12    [$7E:0012]
$A5:91FF 22 43 B6 A0 JSL $A0B643[$A0:B643]
$A5:9203 A5 16       LDA $16    [$7E:0016]
$A5:9205 8D 24 0E    STA $0E24  [$7E:0E24]
$A5:9208 A5 18       LDA $18    [$7E:0018]
$A5:920A 8D 26 0E    STA $0E26  [$7E:0E26]
$A5:920D A5 1A       LDA $1A    [$7E:001A]
$A5:920F 8D 28 0E    STA $0E28  [$7E:0E28]
$A5:9212 A5 1C       LDA $1C    [$7E:001C]
$A5:9214 8D 2A 0E    STA $0E2A  [$7E:0E2A]
$A5:9217 AF 06 88 7E LDA $7E8806[$7E:8806]
$A5:921B 29 FF 00    AND #$00FF
$A5:921E 8D 20 0E    STA $0E20  [$7E:0E20]
$A5:9221 22 91 B6 A0 JSL $A0B691[$A0:B691]
$A5:9225 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:9228 38          SEC
$A5:9229 E9 00 01    SBC #$0100
$A5:922C 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A5:9230 C9 04 00    CMP #$0004
$A5:9233 10 12       BPL $12    [$9247]
$A5:9235 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:9238 38          SEC
$A5:9239 E9 E0 01    SBC #$01E0
$A5:923C 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A5:9240 C9 04 00    CMP #$0004
$A5:9243 10 02       BPL $02    [$9247]
$A5:9245 80 03       BRA $03    [$924A]

$A5:9247 4C 93 92    JMP $9293  [$A5:9293]

$A5:924A 20 6C A0    JSR $A06C  [$A5:A06C]
$A5:924D A9 94 92    LDA #$9294
$A5:9250 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9253 A9 03 00    LDA #$0003             ;\
$A5:9256 22 C1 8F 80 JSL $808FC1[$80:8FC1]  ;} Queue elevator music track
$A5:925A A9 A0 01    LDA #$01A0
$A5:925D 8D AA 0F    STA $0FAA  [$7E:0FAA]
$A5:9260 A9 B9 97    LDA #$97B9
$A5:9263 8D 92 0F    STA $0F92  [$7E:0F92]
$A5:9266 A9 01 00    LDA #$0001
$A5:9269 8D 94 0F    STA $0F94  [$7E:0F94]
$A5:926C AD 86 0F    LDA $0F86  [$7E:0F86]
$A5:926F 09 00 02    ORA #$0200
$A5:9272 8D 06 10    STA $1006  [$7E:1006]
$A5:9275 8D 46 10    STA $1046  [$7E:1046]
$A5:9278 A0 9C 99    LDY #$999C
$A5:927B AF 00 80 7E LDA $7E8000[$7E:8000]
$A5:927F F0 03       BEQ $03    [$9284]
$A5:9281 A0 3E 9D    LDY #$9D3E

$A5:9284 8C D2 0F    STY $0FD2  [$7E:0FD2]
$A5:9287 A9 01 00    LDA #$0001
$A5:928A 8D D4 0F    STA $0FD4  [$7E:0FD4]
$A5:928D A9 4B 80    LDA #$804B
$A5:9290 8D E8 0F    STA $0FE8  [$7E:0FE8]

$A5:9293 60          RTS
}


;;; $9294: Draygon body function -  ;;;
{
; laying on floor
$A5:9294 20 EA 92    JSR $92EA  [$A5:92EA]
$A5:9297 CE AA 0F    DEC $0FAA  [$7E:0FAA]
$A5:929A AD AA 0F    LDA $0FAA  [$7E:0FAA]
$A5:929D F0 05       BEQ $05    [$92A4]
$A5:929F 20 E0 9F    JSR $9FE0  [$A5:9FE0]
$A5:92A2 80 06       BRA $06    [$92AA]

$A5:92A4 A9 AB 92    LDA #$92AB
$A5:92A7 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A5:92AA 60          RTS
}


;;; $92AB: Draygon body function -  ;;;
{
; carried by evirs
$A5:92AB 20 EA 92    JSR $92EA  [$A5:92EA]
$A5:92AE 20 E0 9F    JSR $9FE0  [$A5:9FE0]
$A5:92B1 EE 7E 0F    INC $0F7E  [$7E:0F7E]
$A5:92B4 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:92B7 C9 40 02    CMP #$0240
$A5:92BA 30 2D       BMI $2D    [$92E9]
$A5:92BC A9 ED 98    LDA #$98ED
$A5:92BF 8D 92 0F    STA $0F92  [$7E:0F92]
$A5:92C2 A9 01 00    LDA #$0001
$A5:92C5 8D 94 0F    STA $0F94  [$7E:0F94]
$A5:92C8 AD 86 0F    LDA $0F86  [$7E:0F86]
$A5:92CB 09 00 02    ORA #$0200
$A5:92CE 8D 86 0F    STA $0F86  [$7E:0F86]
$A5:92D1 8D C6 0F    STA $0FC6  [$7E:0FC6]
$A5:92D4 AE 9F 07    LDX $079F  [$7E:079F]
$A5:92D7 BF 28 D8 7E LDA $7ED828,x[$7E:D82C]
$A5:92DB 09 01 00    ORA #$0001
$A5:92DE 9F 28 D8 7E STA $7ED828,x[$7E:D82C]
$A5:92E2 22 3D BB A0 JSL $A0BB3D[$A0:BB3D]
$A5:92E6 20 C6 A0    JSR $A0C6  [$A5:A0C6]

$A5:92E9 60          RTS
}


;;; $92EA:  ;;;
{
; spawn death dust cloud
$A5:92EA 5A          PHY
$A5:92EB DA          PHX
$A5:92EC AD B6 05    LDA $05B6  [$7E:05B6]
$A5:92EF 29 07 00    AND #$0007
$A5:92F2 D0 25       BNE $25    [$9319]
$A5:92F4 22 11 81 80 JSL $808111[$80:8111]
$A5:92F8 29 7F 00    AND #$007F
$A5:92FB 18          CLC
$A5:92FC 69 C0 00    ADC #$00C0
$A5:92FF 85 12       STA $12    [$7E:0012]
$A5:9301 AD E5 05    LDA $05E5  [$7E:05E5]
$A5:9304 29 00 3F    AND #$3F00
$A5:9307 EB          XBA
$A5:9308 18          CLC
$A5:9309 69 90 01    ADC #$0190
$A5:930C 85 14       STA $14    [$7E:0014]
$A5:930E A9 15 00    LDA #$0015
$A5:9311 85 16       STA $16    [$7E:0016]
$A5:9313 64 18       STZ $18    [$7E:0018]
$A5:9315 22 26 BC B4 JSL $B4BC26[$B4:BC26]

$A5:9319 FA          PLX
$A5:931A 7A          PLY
$A5:931B 60          RTS
}


;;; $931C: Handle short Draygon breath bubbles ;;;
{
$A5:931C BD A4 0F    LDA $0FA4,x[$7E:0FA4]  ;\
$A5:931F 29 7F 00    AND #$007F             ;} If [enemy frame counter] % 80h = 0:
$A5:9322 D0 1D       BNE $1D    [$9341]     ;/
$A5:9324 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:9327 18          CLC                    ;|
$A5:9328 69 F0 FF    ADC #$FFF0             ;} $12 = [Draygon X position] - 10h
$A5:932B 85 12       STA $12    [$7E:0012]  ;/
$A5:932D AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:9330 18          CLC                    ;|
$A5:9331 69 F0 FF    ADC #$FFF0             ;} $14 = [Draygon Y position] - 10h
$A5:9334 85 14       STA $14    [$7E:0014]  ;/
$A5:9336 A9 18 00    LDA #$0018             ;\
$A5:9339 85 16       STA $16    [$7E:0016]  ;|
$A5:933B 64 18       STZ $18    [$7E:0018]  ;} Create sprite object 18h (short Draygon breath bubbles) at position ([$12], [$14]) with palette 7
$A5:933D 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/

$A5:9341 60          RTS
}


;;; $9342: Enemy graphics drawn hook - Draygon - set BG2 X/Y scroll ;;;
{
$A5:9342 AD 11 09    LDA $0911  [$7E:0911]  ;\
$A5:9345 38          SEC                    ;|
$A5:9346 ED 7A 0F    SBC $0F7A  [$7E:0F7A]  ;|
$A5:9349 38          SEC                    ;|
$A5:934A E9 C2 01    SBC #$01C2             ;} BG2 X scroll = [layer 1 X position] - [Draygon X position] - 1C2h + [$7E:883C]
$A5:934D 18          CLC                    ;|
$A5:934E 6F 3C 88 7E ADC $7E883C[$7E:883C]  ;|
$A5:9352 85 B5       STA $B5    [$7E:00B5]  ;/
$A5:9354 AD 15 09    LDA $0915  [$7E:0915]  ;\
$A5:9357 38          SEC                    ;|
$A5:9358 ED 7E 0F    SBC $0F7E  [$7E:0F7E]  ;|
$A5:935B 38          SEC                    ;|
$A5:935C E9 C0 00    SBC #$00C0             ;} BG2 Y scroll = [layer 1 X position] - [Draygon Y position] - C0h + [$7E:883E]
$A5:935F 18          CLC                    ;|
$A5:9360 6F 3E 88 7E ADC $7E883E[$7E:883E]  ;|
$A5:9364 85 B7       STA $B7    [$7E:00B7]  ;/
$A5:9366 6B          RTL
}


;;; $9367: Debug. Draygon controller 2 input handling ;;;
{
$A5:9367 A2 00 00    LDX #$0000
$A5:936A A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:936C 89 40 00    BIT #$0040             ;} If controller 2 pressing X:
$A5:936F F0 06       BEQ $06    [$9377]     ;/
$A5:9371 22 30 94 A5 JSL $A59430[$A5:9430]  ; Move Draygon with d-pad - fast
$A5:9375 80 04       BRA $04    [$937B]

                                            ; Else (controller 2 not pressing X):
$A5:9377 22 DA 93 A5 JSL $A593DA[$A5:93DA]  ; Move Draygon with d-pad - slow

$A5:937B A2 00 00    LDX #$0000
$A5:937E A5 91       LDA $91    [$7E:0091]  ;\
$A5:9380 89 00 40    BIT #$4000             ;} If controller 2 not newly pressed Y: go to BRANCH_FIRE_GUNK_END
$A5:9383 F0 17       BEQ $17    [$939C]     ;/
$A5:9385 A0 FE 98    LDY #$98FE             ; Draygon body instruction list pointer = $98FE
$A5:9388 BF 00 80 7E LDA $7E8000,x          ;\
$A5:938C F0 03       BEQ $03    [$9391]     ;} If [Draygon facing direction] != left:
$A5:938E A0 90 9C    LDY #$9C90             ; Draygon body instruction list pointer = $9C90

$A5:9391 8C 92 0F    STY $0F92  [$7E:0F92]
$A5:9394 A9 01 00    LDA #$0001             ;\
$A5:9397 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:939A 80 3D       BRA $3D    [$93D9]     ; Return

; BRANCH_FIRE_GUNK_END
$A5:939C 89 00 80    BIT #$8000             ;\
$A5:939F F0 17       BEQ $17    [$93B8]     ;} If controller 2 not newly pressed B: go to BRANCH_WHIP_TAIL_END
$A5:93A1 A0 FC 99    LDY #$99FC             ; Draygon tail instruction list pointer = $99FC
$A5:93A4 BF 00 80 7E LDA $7E8000,x          ;\
$A5:93A8 F0 03       BEQ $03    [$93AD]     ;} If [Draygon facing direction] != left:
$A5:93AA A0 9E 9D    LDY #$9D9E             ; Draygon tail instruction list pointer = $9D9E

$A5:93AD 8C 12 10    STY $1012  [$7E:1012]
$A5:93B0 A9 01 00    LDA #$0001             ;\
$A5:93B3 8D 14 10    STA $1014  [$7E:1014]  ;} Draygon tail instruction timer = 1
$A5:93B6 80 21       BRA $21    [$93D9]     ; Return

; BRANCH_WHIP_TAIL_END
$A5:93B8 89 80 00    BIT #$0080             ;\
$A5:93BB F0 17       BEQ $17    [$93D4]     ;} If controller 2 not newly pressed A: go to BRANCH_BIG_HUG_END
$A5:93BD A0 25 98    LDY #$9825             ; Draygon arms instruction list pointer = $9825
$A5:93C0 BF 00 80 7E LDA $7E8000,x          ;\
$A5:93C4 F0 03       BEQ $03    [$93C9]     ;} If [Draygon facing direction] != left:
$A5:93C6 A0 18 9C    LDY #$9C18             ; Draygon arms instruction list pointer = $9C18

$A5:93C9 8C 52 10    STY $1052  [$7E:1052]
$A5:93CC A9 01 00    LDA #$0001             ;\
$A5:93CF 8D 54 10    STA $1054  [$7E:1054]  ;} Draygon arms instruction timer = 1
$A5:93D2 80 05       BRA $05    [$93D9]     ; Return

; BRANCH_BIG_HUG_END
$A5:93D4 89 40 00    BIT #$0040
$A5:93D7 F0 00       BEQ $00    [$93D9]

$A5:93D9 6B          RTL
}


;;; $93DA: Debug. Move Draygon with d-pad - slow ;;;
{
$A5:93DA A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:93DC 89 00 02    BIT #$0200             ;} If controller 2 pressing left:
$A5:93DF F0 17       BEQ $17    [$93F8]     ;/
$A5:93E1 CE 7A 0F    DEC $0F7A  [$7E:0F7A]  ; Draygon X position -= 1
$A5:93E4 CD 66 18    CMP $1866  [$7E:1866]  ;\
$A5:93E7 F0 0F       BEQ $0F    [$93F8]     ;} If [controller 2 input] != [previous controller 2 input]:
$A5:93E9 8D 66 18    STA $1866  [$7E:1866]  ; Previous controller 2 input = [controller 2 input]
$A5:93EC A0 BB 97    LDY #$97BB             ; Y = $97BB
$A5:93EF A9 00 00    LDA #$0000             ;\
$A5:93F2 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = left
$A5:93F6 80 1A       BRA $1A    [$9412]     ; Go to BRANCH_SET_NEXT_INSTRUCTION

$A5:93F8 89 00 01    BIT #$0100             ;\
$A5:93FB F0 1E       BEQ $1E    [$941B]     ;} If controller 2 not pressing right: go to BRANCH_DONT_SET_NEXT_INSTRUCTION
$A5:93FD EE 7A 0F    INC $0F7A  [$7E:0F7A]  ; Draygon X position += 1
$A5:9400 CD 66 18    CMP $1866  [$7E:1866]  ;\
$A5:9403 F0 16       BEQ $16    [$941B]     ;} If [controller 2 input] = [previous controller 2 input]: go to BRANCH_DONT_SET_NEXT_INSTRUCTION
$A5:9405 8D 66 18    STA $1866  [$7E:1866]  ; Previous controller 2 input = [controller 2 input]
$A5:9408 A0 D1 97    LDY #$97D1             ; Y = $97D1
$A5:940B A9 01 00    LDA #$0001             ;\
$A5:940E 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = right

; BRANCH_SET_NEXT_INSTRUCTION
$A5:9412 8C 92 0F    STY $0F92  [$7E:0F92]  ; Draygon body instruction list pointer = [Y]
$A5:9415 A9 01 00    LDA #$0001             ;\
$A5:9418 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1

; BRANCH_DONT_SET_NEXT_INSTRUCTION
$A5:941B A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:941D 89 00 08    BIT #$0800             ;} If controller 2 pressing up:
$A5:9420 F0 05       BEQ $05    [$9427]     ;/
$A5:9422 CE 7E 0F    DEC $0F7E  [$7E:0F7E]  ; Draygon Y position -= 1
$A5:9425 80 08       BRA $08    [$942F]     ; Return

$A5:9427 89 00 04    BIT #$0400             ;\
$A5:942A F0 03       BEQ $03    [$942F]     ;} If controller 2 pressing down:
$A5:942C EE 7E 0F    INC $0F7E  [$7E:0F7E]  ; Draygon Y position += 1

$A5:942F 6B          RTL
}


;;; $9430: Debug. Move Draygon with d-pad - fast ;;;
{
$A5:9430 A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:9432 89 00 02    BIT #$0200             ;} If controller 2 pressing left:
$A5:9435 F0 20       BEQ $20    [$9457]     ;/
$A5:9437 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:943A 38          SEC                    ;|
$A5:943B E9 04 00    SBC #$0004             ;} Draygon X position -= 4
$A5:943E 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:9441 A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:9443 CD 66 18    CMP $1866  [$7E:1866]  ;} If [controller 2 input] != [previous controller 2 input]:
$A5:9446 F0 0F       BEQ $0F    [$9457]     ;/
$A5:9448 8D 66 18    STA $1866  [$7E:1866]  ; Previous controller 2 input = [controller 2 input]
$A5:944B A0 BB 97    LDY #$97BB             ; Y = $97BB
$A5:944E A9 00 00    LDA #$0000             ;\
$A5:9451 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = left
$A5:9455 80 23       BRA $23    [$947A]     ; Go to BRANCH_SET_NEXT_INSTRUCTION

$A5:9457 89 00 01    BIT #$0100             ;\
$A5:945A F0 27       BEQ $27    [$9483]     ;} If controller 2 not pressing right: go to BRANCH_DONT_SET_NEXT_INSTRUCTION
$A5:945C AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:945F 18          CLC                    ;|
$A5:9460 69 04 00    ADC #$0004             ;} Draygon X position += 4
$A5:9463 8D 7A 0F    STA $0F7A  [$7E:0F7A]  ;/
$A5:9466 A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:9468 CD 66 18    CMP $1866  [$7E:1866]  ;} If [controller 2 input] = [previous controller 2 input]: go to BRANCH_DONT_SET_NEXT_INSTRUCTION
$A5:946B F0 16       BEQ $16    [$9483]     ;/
$A5:946D 8D 66 18    STA $1866  [$7E:1866]  ; Previous controller 2 input = [controller 2 input]
$A5:9470 A0 D1 97    LDY #$97D1             ; Y = $97D1
$A5:9473 A9 01 00    LDA #$0001             ;\
$A5:9476 8F 00 80 7E STA $7E8000[$7E:8000]  ;} Draygon facing direction = right

; BRANCH_SET_NEXT_INSTRUCTION
$A5:947A 8C 92 0F    STY $0F92  [$7E:0F92]  ; Draygon body instruction list pointer = [Y]
$A5:947D A9 01 00    LDA #$0001             ;\
$A5:9480 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1

; BRANCH_DONT_SET_NEXT_INSTRUCTION
$A5:9483 A5 8D       LDA $8D    [$7E:008D]  ;\
$A5:9485 89 00 08    BIT #$0800             ;} If controller 2 pressing up:
$A5:9488 F0 0C       BEQ $0C    [$9496]     ;/
$A5:948A AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:948D 38          SEC                    ;|
$A5:948E E9 04 00    SBC #$0004             ;} Draygon Y position -= 4
$A5:9491 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/
$A5:9494 80 12       BRA $12    [$94A8]     ; Return

$A5:9496 89 00 04    BIT #$0400             ;\
$A5:9499 F0 0D       BEQ $0D    [$94A8]     ;} If controller 2 pressing down:
$A5:949B EE 7E 0F    INC $0F7E  [$7E:0F7E]  ;\
$A5:949E AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;|
$A5:94A1 18          CLC                    ;} Draygon Y position += 5
$A5:94A2 69 04 00    ADC #$0004             ;|
$A5:94A5 8D 7E 0F    STA $0F7E  [$7E:0F7E]  ;/

$A5:94A8 6B          RTL
}


;;; $94A9: Move Samus with Draygon ;;;
{
$A5:94A9 A0 08 00    LDY #$0008             ; Y = 8
$A5:94AC BF 00 80 7E LDA $7E8000,x[$7E:8000];\
$A5:94B0 D0 03       BNE $03    [$94B5]     ;} If [Draygon facing direction] = left:
$A5:94B2 A0 F8 FF    LDY #$FFF8             ; Y = -8

$A5:94B5 98          TYA                    ;\
$A5:94B6 18          CLC                    ;|
$A5:94B7 6D 7A 0F    ADC $0F7A  [$7E:0F7A]  ;} Samus X position = [Draygon X position] + [Y]
$A5:94BA 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;/
$A5:94BD AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:94C0 18          CLC                    ;|
$A5:94C1 69 28 00    ADC #$0028             ;} Samus Y position = [Draygon Y position] + 28h
$A5:94C4 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A5:94C7 22 A1 B7 A0 JSL $A0B7A1[$A0:B7A1]  ; Cap scrolling speed
$A5:94CB AD 64 0A    LDA $0A64  [$7E:0A64]  ;\
$A5:94CE 89 02 00    BIT #$0002             ;} If Samus released from Draygon:
$A5:94D1 F0 09       BEQ $09    [$94DC]     ;/
$A5:94D3 9C 64 0A    STZ $0A64  [$7E:0A64]  ; Grapple connected flags = 0
$A5:94D6 A9 54 91    LDA #$9154             ;\
$A5:94D9 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Draygon body function = $9154

$A5:94DC 60          RTS
}


;;; $94DD: Instruction - Draygon instructions lists = [[Y]], [[Y] + 2], [[Y] + 4], [[Y] + 6] ;;;
{
$A5:94DD 5A          PHY
$A5:94DE B9 00 00    LDA $0000,y[$A5:97D3]  ;\
$A5:94E1 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Draygon body instruction list pointer = [[Y]]
$A5:94E4 B9 02 00    LDA $0002,y[$A5:97D5]  ;\
$A5:94E7 8D D2 0F    STA $0FD2  [$7E:0FD2]  ;} Draygon eye instruction list pointer = [[Y] + 2]
$A5:94EA B9 04 00    LDA $0004,y[$A5:97D7]  ;\
$A5:94ED 8D 12 10    STA $1012  [$7E:1012]  ;} Draygon tail instruction list pointer = [[Y] + 4]
$A5:94F0 B9 06 00    LDA $0006,y[$A5:97D9]  ;\
$A5:94F3 8D 52 10    STA $1052  [$7E:1052]  ;} Draygon arms instruction list pointer = [[Y] + 6]
$A5:94F6 A9 01 00    LDA #$0001             ;\
$A5:94F9 8D 94 0F    STA $0F94  [$7E:0F94]  ;} Draygon body instruction timer = 1
$A5:94FC 8D D4 0F    STA $0FD4  [$7E:0FD4]  ; Draygon eye instruction timer = 1
$A5:94FF 8D 14 10    STA $1014  [$7E:1014]  ; Draygon tail instruction timer = 1
$A5:9502 8D 54 10    STA $1054  [$7E:1054]  ; Draygon arms instruction timer = 1
$A5:9505 7A          PLY
$A5:9506 98          TYA                    ;\
$A5:9507 18          CLC                    ;|
$A5:9508 69 08 00    ADC #$0008             ;} Y += 8
$A5:950B A8          TAY                    ;/
$A5:950C 6B          RTL
}


;;; $950D: Unused. Draygon instruction list pointers ;;;
{
$A5:950D             dw 97E7, 9813, 9805, 9BDA, 9C06, 9BF8, 0000, ; Draygon arms
                        9889, 9867, 987B, 98FE, 9C7E, 9C5A, 9C70, 9C90, 0000, ; Draygon body
                        9944, 99AE, 99B4, 99BA, 99C0, 9CD6, 9D50, 9D56, 9D5C, 9D62, 0000, ; Draygon eye
                        99C6, 99FC, 9D68, 9D9E, 0000 ; Draygon tail
}


;;; $954D: Hurt AI - enemy $DE3F (Draygon) ;;;
{
$A5:954D A0 77 A2    LDY #$A277
$A5:9550 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:9553 BD 9C 0F    LDA $0F9C,x[$7E:0F9C]
$A5:9556 89 02 00    BIT #$0002
$A5:9559 F0 03       BEQ $03    [$955E]
$A5:955B A0 97 A2    LDY #$A297

$A5:955E A2 A0 C0    LDX #$C0A0
$A5:9561 A9 10 00    LDA #$0010
$A5:9564 8D 0B 06    STA $060B  [$7E:060B]

$A5:9567 B9 00 00    LDA $0000,y[$A5:A277]
$A5:956A 9F 00 00 7E STA $7E0000,x[$7E:C0A0]
$A5:956E E8          INX
$A5:956F E8          INX
$A5:9570 C8          INY
$A5:9571 C8          INY
$A5:9572 CE 0B 06    DEC $060B  [$7E:060B]
$A5:9575 D0 F0       BNE $F0    [$9567]
$A5:9577 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:957A BD 9C 0F    LDA $0F9C,x[$7E:0F9C]
$A5:957D 89 02 00    BIT #$0002
$A5:9580 D0 1A       BNE $1A    [$959C]
$A5:9582 AF 1C 78 7E LDA $7E781C[$7E:781C]
$A5:9586 0A          ASL A
$A5:9587 0A          ASL A
$A5:9588 A8          TAY
$A5:9589 A2 00 00    LDX #$0000

$A5:958C B9 AF 96    LDA $96AF,y[$A5:96AF]
$A5:958F 9F B2 C0 7E STA $7EC0B2,x[$7E:C0B2]
$A5:9593 C8          INY
$A5:9594 C8          INY
$A5:9595 E8          INX
$A5:9596 E8          INX
$A5:9597 E0 08 00    CPX #$0008
$A5:959A D0 F0       BNE $F0    [$958C]

$A5:959C A0 F7 A1    LDY #$A1F7
$A5:959F AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:95A2 BD 9C 0F    LDA $0F9C,x[$7E:0F9C]
$A5:95A5 89 02 00    BIT #$0002
$A5:95A8 F0 03       BEQ $03    [$95AD]
$A5:95AA A0 97 A2    LDY #$A297

$A5:95AD A2 E0 C1    LDX #$C1E0
$A5:95B0 A9 10 00    LDA #$0010
$A5:95B3 8D 0B 06    STA $060B  [$7E:060B]

$A5:95B6 B9 00 00    LDA $0000,y[$A5:A1F7]
$A5:95B9 9F 00 00 7E STA $7E0000,x[$7E:C1E0]
$A5:95BD E8          INX
$A5:95BE E8          INX
$A5:95BF C8          INY
$A5:95C0 C8          INY
$A5:95C1 CE 0B 06    DEC $060B  [$7E:060B]
$A5:95C4 D0 F0       BNE $F0    [$95B6]
$A5:95C6 AD 64 0A    LDA $0A64  [$7E:0A64]
$A5:95C9 89 01 00    BIT #$0001
$A5:95CC F0 1B       BEQ $1B    [$95E9]
$A5:95CE AD A4 0F    LDA $0FA4  [$7E:0FA4]
$A5:95D1 29 07 00    AND #$0007
$A5:95D4 D0 13       BNE $13    [$95E9]
$A5:95D6 AD 8C 0F    LDA $0F8C  [$7E:0F8C]
$A5:95D9 38          SEC
$A5:95DA E9 00 01    SBC #$0100
$A5:95DD 10 03       BPL $03    [$95E2]
$A5:95DF A9 00 00    LDA #$0000

$A5:95E2 8D 8C 0F    STA $0F8C  [$7E:0F8C]
$A5:95E5 22 0D 96 A5 JSL $A5960D[$A5:960D]

$A5:95E9 6B          RTL
}


;;; $95EA: Enemy touch - enemy $DE3F (Draygon) ;;;
{
$A5:95EA 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal touch AI, but skips death animation
$A5:95EE 80 1D       BRA $1D    [$960D]     ; Go to Draygon reaction
}


;;; $95F0: Enemy shot - enemy $DE7F (Draygon) ;;;
{
$A5:95F0 AF 1E 78 7E LDA $7E781E[$7E:781E]  ;\
$A5:95F4 18          CLC                    ;|
$A5:95F5 69 08 00    ADC #$0008             ;|
$A5:95F8 C9 A0 00    CMP #$00A0             ;} Draygon swoop Y acceleration = min(98h, [$Draygon swoop Y acceleration] + 8)
$A5:95FB 10 04       BPL $04    [$9601]     ;|
$A5:95FD 8F 1E 78 7E STA $7E781E[$7E:781E]  ;/

$A5:9601 22 A7 A6 A0 JSL $A0A6A7[$A0:A6A7]  ; Normal enemy shot AI, but skips hit-projectile and death animation
$A5:9605 80 06       BRA $06    [$960D]     ; Go to Draygon reaction
}


;;; $9607: Power bomb reaction - enemy $DE3F (Draygon) ;;;
{
$A5:9607 22 B7 A5 A0 JSL $A0A5B7[$A0:A5B7]  ; Normal enemy power bomb AI, but skips death animation
$A5:960B 80 00       BRA $00    [$960D]
}


;;; $960D: Draygon reaction ;;;
{
$A5:960D AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:9610 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]
$A5:9613 F0 03       BEQ $03    [$9618]
$A5:9615 4C AB 96    JMP $96AB  [$A5:96AB]

$A5:9618 A9 C5 C8    LDA #$C8C5
$A5:961B 8D 32 0D    STA $0D32  [$7E:0D32]
$A5:961E A0 67 98    LDY #$9867
$A5:9621 AF 00 80 7E LDA $7E8000[$7E:8000]
$A5:9625 F0 03       BEQ $03    [$962A]
$A5:9627 A0 5A 9C    LDY #$9C5A

$A5:962A 8C 92 0F    STY $0F92  [$7E:0F92]
$A5:962D A9 01 00    LDA #$0001
$A5:9630 8D 94 0F    STA $0F94  [$7E:0F94]
$A5:9633 A0 7A 99    LDY #$997A
$A5:9636 AF 00 80 7E LDA $7E8000[$7E:8000]
$A5:963A F0 03       BEQ $03    [$963F]
$A5:963C A0 1C 9D    LDY #$9D1C

$A5:963F 8C D2 0F    STY $0FD2  [$7E:0FD2]
$A5:9642 A9 01 00    LDA #$0001
$A5:9645 8D D4 0F    STA $0FD4  [$7E:0FD4]
$A5:9648 A9 4B 80    LDA #$804B
$A5:964B 8D E8 0F    STA $0FE8  [$7E:0FE8]
$A5:964E A9 85 91    LDA #$9185
$A5:9651 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9654 22 D4 E2 90 JSL $90E2D4[$90:E2D4]  ; Release Samus from Draygon
$A5:9658 9C 64 0A    STZ $0A64  [$7E:0A64]
$A5:965B A9 00 01    LDA #$0100
$A5:965E 38          SEC
$A5:965F ED 7A 0F    SBC $0F7A  [$7E:0F7A]
$A5:9662 85 12       STA $12    [$7E:0012]
$A5:9664 A9 E0 01    LDA #$01E0
$A5:9667 38          SEC
$A5:9668 ED 7E 0F    SBC $0F7E  [$7E:0F7E]
$A5:966B 85 14       STA $14    [$7E:0014]
$A5:966D 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]
$A5:9671 38          SEC
$A5:9672 E9 40 00    SBC #$0040
$A5:9675 49 FF FF    EOR #$FFFF
$A5:9678 1A          INC A
$A5:9679 29 FF 00    AND #$00FF
$A5:967C 8F 06 88 7E STA $7E8806[$7E:8806]
$A5:9680 A9 01 00    LDA #$0001
$A5:9683 85 14       STA $14    [$7E:0014]
$A5:9685 AF 06 88 7E LDA $7E8806[$7E:8806]
$A5:9689 29 FF 00    AND #$00FF
$A5:968C 85 12       STA $12    [$7E:0012]
$A5:968E 22 43 B6 A0 JSL $A0B643[$A0:B643]
$A5:9692 A5 16       LDA $16    [$7E:0016]
$A5:9694 8F 10 80 7E STA $7E8010[$7E:8010]
$A5:9698 A5 18       LDA $18    [$7E:0018]
$A5:969A 8F 12 80 7E STA $7E8012[$7E:8012]
$A5:969E A5 1A       LDA $1A    [$7E:001A]
$A5:96A0 8F 14 80 7E STA $7E8014[$7E:8014]
$A5:96A4 A5 1C       LDA $1C    [$7E:001C]
$A5:96A6 8F 16 80 7E STA $7E8016[$7E:8016]
$A5:96AA 6B          RTL

$A5:96AB 20 01 97    JSR $9701  [$A5:9701]
$A5:96AE 6B          RTL
}


;;; $96AF:  ;;;
{
$A5:96AF             dw 0319,0254,018F,00CA,
                        02BA,01F4,014F,00AA,
                        023B,01B5,012F,0089,
                        01DC,0155,00EF,0069,
                        015C,0116,00B0,0069,
                        00FD,00B6,0070,0049,
                        007E,0077,0050,0028,
                        001F,0017,0010,0008
}


;;; $96EF:  ;;;
{
; Draygon health-based palette thresholds
$A5:96EF             dw 1482, 1194, 0EA6, 0BB8, 08CA, 05DC, 02EE, 0000, FFFF
}


;;; $9701:  ;;;
{
$A5:9701 A2 00 00    LDX #$0000

$A5:9704 AD 8C 0F    LDA $0F8C  [$7E:0F8C]
$A5:9707 DD EF 96    CMP $96EF,x[$A5:96EF]
$A5:970A 10 04       BPL $04    [$9710]
$A5:970C E8          INX
$A5:970D E8          INX
$A5:970E 80 F4       BRA $F4    [$9704]

$A5:9710 8A          TXA
$A5:9711 CF 1C 78 7E CMP $7E781C[$7E:781C]
$A5:9715 F0 1E       BEQ $1E    [$9735]
$A5:9717 8F 1C 78 7E STA $7E781C[$7E:781C]
$A5:971B AF 1C 78 7E LDA $7E781C[$7E:781C]
$A5:971F 0A          ASL A
$A5:9720 0A          ASL A
$A5:9721 A8          TAY
$A5:9722 A2 00 00    LDX #$0000

$A5:9725 B9 AF 96    LDA $96AF,y[$A5:96B7]
$A5:9728 9F B2 C0 7E STA $7EC0B2,x[$7E:C0B2]
$A5:972C C8          INY
$A5:972D C8          INY
$A5:972E E8          INX
$A5:972F E8          INX
$A5:9730 E0 08 00    CPX #$0008
$A5:9733 D0 F0       BNE $F0    [$9725]

$A5:9735 60          RTS
}


;;; $9736..9FDF: Instruction lists and instructions ;;;
{
;;; $9736: Instruction - enemy function = [[Y]] ;;;
{
$A5:9736 B9 00 00    LDA $0000,y
$A5:9739 9D A8 0F    STA $0FA8,x
$A5:973C C8          INY
$A5:973D C8          INY
$A5:973E 6B          RTL
}


;;; $973F: Instruction ;;;
{
$A5:973F 5A          PHY
$A5:9740 DA          PHX
$A5:9741 20 8B 97    JSR $978B  [$A5:978B]
$A5:9744 A9 15 00    LDA #$0015
$A5:9747 85 16       STA $16    [$7E:0016]
$A5:9749 64 18       STZ $18    [$7E:0018]
$A5:974B 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:974F FA          PLX
$A5:9750 7A          PLY
$A5:9751 6B          RTL
}


;;; $9752: Instruction ;;;
{
$A5:9752 5A          PHY
$A5:9753 DA          PHX
$A5:9754 20 8B 97    JSR $978B  [$A5:978B]
$A5:9757 A9 03 00    LDA #$0003
$A5:975A 85 16       STA $16    [$7E:0016]
$A5:975C 64 18       STZ $18    [$7E:0018]
$A5:975E 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:9762 FA          PLX
$A5:9763 7A          PLY
$A5:9764 6B          RTL
}


;;; $9765: Instruction ;;;
{
$A5:9765 5A          PHY
$A5:9766 DA          PHX
$A5:9767 20 8B 97    JSR $978B  [$A5:978B]
$A5:976A A9 1D 00    LDA #$001D
$A5:976D 85 16       STA $16    [$7E:0016]
$A5:976F 64 18       STZ $18    [$7E:0018]
$A5:9771 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:9775 FA          PLX
$A5:9776 7A          PLY
$A5:9777 6B          RTL
}


;;; $9778: Instruction ;;;
{
$A5:9778 5A          PHY
$A5:9779 DA          PHX
$A5:977A 20 8B 97    JSR $978B  [$A5:978B]
$A5:977D A9 18 00    LDA #$0018
$A5:9780 85 16       STA $16    [$7E:0016]
$A5:9782 64 18       STZ $18    [$7E:0018]
$A5:9784 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:9788 FA          PLX
$A5:9789 7A          PLY
$A5:978A 6B          RTL
}


;;; $978B:  ;;;
{
$A5:978B 22 11 81 80 JSL $808111[$80:8111]
$A5:978F AD E5 05    LDA $05E5  [$7E:05E5]
$A5:9792 29 7F 00    AND #$007F
$A5:9795 38          SEC
$A5:9796 E9 40 00    SBC #$0040
$A5:9799 85 12       STA $12    [$7E:0012]
$A5:979B AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:979E 18          CLC
$A5:979F 65 12       ADC $12    [$7E:0012]
$A5:97A1 85 12       STA $12    [$7E:0012]
$A5:97A3 AD E5 05    LDA $05E5  [$7E:05E5]
$A5:97A6 29 00 7F    AND #$7F00
$A5:97A9 EB          XBA
$A5:97AA 38          SEC
$A5:97AB E9 40 00    SBC #$0040
$A5:97AE 85 14       STA $14    [$7E:0014]
$A5:97B0 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:97B3 18          CLC
$A5:97B4 65 14       ADC $14    [$7E:0014]
$A5:97B6 85 14       STA $14    [$7E:0014]
$A5:97B8 60          RTS
}


;;; $97B9: Instruction list -  ;;;
{
$A5:97B9             dx 812F        ; Sleep
}


;;; $97BB: Instruction list -  ;;;
{
$A5:97BB             dx 94DD,9889,9944,99C6,97E7,   ; Draygon instructions lists = $9889, $9944, $99C6, $97E7
                        9895,                       ; Room loading interrupt command = Draygon's room - begin HUD drawing
                        C47B,C48D,                  ; ???
                        0001,A3BB,
                        812F                        ; Sleep
}


;;; $97D1: Instruction list -  ;;;
{
$A5:97D1             dx 94DD,9C7E,9CD6,9D68,9BDA,   ; Draygon instructions lists = $9C7E, $9CD6, $9D68, $9BDA
                        9895,                       ; Room loading interrupt command = Draygon's room - begin HUD drawing
                        C47B,C513,                  ; ???
                        0001,A6E3,
                        812F                        ; Sleep
}


;;; $97E7: Instruction list - Draygon arms -  ;;;
{
$A5:97E7             dx 0005,A2DF,
                        0005,A2E9,
                        0005,A2F3,
                        0005,A2FD,
                        0005,A307,
                        0005,A311,
                        80ED,97E7   ; Go to $97E7
}


;;; $9803: Instruction list -  ;;;
{
$A5:9803             dx 812F        ; Sleep
}


;;; $9805: Instruction list -  ;;;
{
$A5:9805             dx 0001,A3D9,
                        0001,A3CF,
                        0040,A3C5,
                        812F        ; Sleep
}


;;; $9813: Instruction list -  ;;;
{
$A5:9813             dx 0001,A3C5,
                        0001,A3CF,
                        0001,A3D9,
                        0040,A3E3,
                        812F        ; Sleep
}


;;; $9825: Instruction list -  ;;;
{
$A5:9825             dx 0001,A3C5,
                        0001,A3CF,
                        0001,A3D9,
                        0040,A3E3,
                        0001,A3D9,
                        0001,A3CF,
                        0040,A3C5,
                        80ED,97E7   ; Go to $97E7
}


;;; $9845: Instruction list -  ;;;
{
$A5:9845             dx 0001,A3C5,
                        0001,A3CF,
                        0001,A3D9,
                        0008,A3E3,
                        0001,A3D9,
                        0001,A3CF,
                        0001,A3C5,
                        0001,A3CF,
                        812F        ; Sleep
}


;;; $9867: Instruction list -  ;;;
{
$A5:9867             dx 0005,A31B,
                        0005,A325,
                        0005,A32F,
                        0005,A339,
                        80ED,989B   ; Go to $989B
}


;;; $987B: Instruction list -  ;;;
{
$A5:987B             dx 0005,A32F,
                        0005,A325,
                        0005,A31B,
                        812F        ; Sleep
}


;;; $9889: Instruction list - Draygon body -  ;;;
{
$A5:9889             dx 9895,       ; Room loading interrupt command = Draygon's room - begin HUD drawing
                        C47B,C48D,  ; ???
                        0001,A3BB,
                        812F        ; Sleep
}


;;; $9895: Instruction - room loading interrupt command = Draygon's room - begin HUD drawing ;;;
{
$A5:9895 A9 0C 00    LDA #$000C
$A5:9898 85 A9       STA $A9    [$7E:00A9]
$A5:989A 6B          RTL
}


;;; $989B: Instruction list -  ;;;
{
$A5:989B             dx 9F6E,001B,  ; Queue sound 001Bh, sound library 3, max queued sounds allowed = 6
                        98EF,       ; Set enemy as intangible
                        8123,0008,  ; Timer = 0008h
                        813A,000C,  ; Wait 000Ch frames
                        9765,       ; ???
                        9752,       ; ???
                        973F,       ; ???
                        9778,       ; ???
                        9F60,0025,  ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        8110,98A5,  ; Decrement timer and go to $98A5 if non-zero
                        813A,0001,  ; Wait 0001h frames
                        98D3,       ; ???
                        813A,0010,  ; Wait 0010h frames
                        9765,       ; ???
                        9752,       ; ???
                        973F,       ; ???
                        9778,       ; ???
                        9F60,0025,  ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        80ED,98BF   ; Go to $98BF
}


;;; $98D3: Instruction ;;;
{
$A5:98D3 DA          PHX
$A5:98D4 5A          PHY
$A5:98D5 A9 01 00    LDA #$0001
$A5:98D8 8D 14 10    STA $1014  [$7E:1014]
$A5:98DB 8D 54 10    STA $1054  [$7E:1054]
$A5:98DE A9 B9 97    LDA #$97B9
$A5:98E1 8D 12 10    STA $1012  [$7E:1012]
$A5:98E4 A9 B9 97    LDA #$97B9
$A5:98E7 8D 52 10    STA $1052  [$7E:1052]
$A5:98EA 7A          PLY
$A5:98EB FA          PLX
$A5:98EC 6B          RTL
}


;;; $98ED: Instruction list -  ;;;
{
$A5:98ED             dx 807C        ; Delete
}


;;; $98EF: Instruction - set enemy as intangible ;;;
{
$A5:98EF DA          PHX
$A5:98F0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:98F3 AD 86 0F    LDA $0F86  [$7E:0F86]
$A5:98F6 09 00 04    ORA #$0400
$A5:98F9 8D 86 0F    STA $0F86  [$7E:0F86]
$A5:98FC FA          PLX
$A5:98FD 6B          RTL
}


;;; $98FE: Instruction list -  ;;;
{
$A5:98FE             dx 0001,A343,
                        0002,A34D,
                        0003,A357,
                        9F7C,       ; ???
                        9F60,004C,  ; Queue sound 004Ch, sound library 2, max queued sounds allowed = 6
                        0003,A361,
                        0002,A357,
                        0002,A34D,
                        0001,A343,
                        812F        ; Sleep
}


;;; $9922: Instruction list -  ;;;
{
$A5:9922             dx 9F60,0073,  ; Queue sound 0073h, sound library 2, max queued sounds allowed = 6
                        0006,A343,
                        0006,A34D,
                        0006,A357,
                        0006,A361,
                        0006,A357,
                        0006,A34D,
                        0006,A343,
                        812F        ; Sleep
}


;;; $9944: Instruction list - Draygon eye -  ;;;
{
$A5:9944             dx 0015,A36B,
                        0005,A375,
                        0005,A37F,
                        000A,A375,
                        000A,A393,
                        000A,A393,
                        000A,A3A7,
                        000A,A3A7,
                        000A,A3B1,
                        0005,A37F,
                        0005,A375,
                        0005,A36B,
                        9736,C48D,  ; Enemy function = $C48D (facing left)
                        812F        ; Sleep
}


;;; $997A: Instruction list -  ;;;
{
$A5:997A             dx 8123,0004,  ; Timer = 0004h
                        0004,A393,
                        0004,A3A7,
                        0004,A39D,
                        0004,A3B1,
                        8110,997E,  ; Decrement timer and go to $997E if non-zero
                        0020,A389,
                        0010,A37F,
                        812F        ; Sleep
}


;;; $999C: Instruction list -  ;;;
{
$A5:999C             dx 0020,A389,
                        0020,A37F,
                        0020,A375,
                        0001,A36B,
                        812F        ; Sleep
}


;;; $99AE: Instruction list - Draygon eye - facing left - looking left ;;;
{
$A5:99AE             dx 0001,A393,
                        812F        ; Sleep
}


;;; $99B4: Instruction list - Draygon eye - facing left - looking right ;;;
{
$A5:99B4             dx 0001,A39D,
                        812F        ; Sleep
}


;;; $99BA: Instruction list - Draygon eye - facing left - looking up ;;;
{
$A5:99BA             dx 0001,A3A7,
                        812F        ; Sleep
}


;;; $99C0: Instruction list - Draygon eye - facing left - looking down ;;;
{
$A5:99C0             dx 0001,A3B1,
                        812F        ; Sleep
}


;;; $99C6: Instruction list - Draygon tail -  ;;;
{
$A5:99C6             dx 0008,A40B,
                        0007,A41D,
                        0006,A42F,
                        0006,A441,
                        0006,A453,
                        0006,A465,
                        0006,A477,
                        0006,A465,
                        0006,A453,
                        0006,A441,
                        0006,A42F,
                        0007,A41D,
                        80ED,99C6   ; Go to $99C6
}


;;; $99FA: Instruction list -  ;;;
{
$A5:99FA             dx 812F        ; Sleep
}


;;; $99FC: Instruction list -  ;;;
{
$A5:99FC             dx 9E0A,FFFF,FFFF, ; ???
                        0010,A42F,
                        9E0A,FFFE,FFFE, ; ???
                        0006,A489,
                        9E0A,FFFD,FFFD, ; ???
                        0005,A4A3,
                        9E0A,FFFC,FFFC, ; ???
                        0004,A4C5,
                        9E0A,FFFB,FFFB, ; ???
                        0003,A4EF,
                        9E0A,FFFA,FFFA, ; ???
                        0002,A521,
                        9E0A,FFF8,FFF8, ; ???
                        0001,A55B,
                        9E0A,0000,0000, ; ???
                        0010,A59D,
                        0001,A55B,
                        0002,A521,
                        0003,A4EF,
                        0004,A4C5,
                        0005,A4A3,
                        0006,A489,
                        80ED,99C6       ; Go to $99C6
}


;;; $9A68: Instruction list -  ;;;
{
$A5:9A68             dx 8123,0004       ; Timer = 0004h
$A5:9A6C             dx 9E0A,FFFF,FFFF, ; ???
                        0002,A42F,
                        9E0A,FFFE,FFFE, ; ???
                        0006,A489,
                        9E0A,FFFD,FFFD, ; ???
                        0005,A4A3,
                        9E0A,FFFC,FFFC, ; ???
                        0004,A4C5,
                        9E0A,FFFB,FFFB, ; ???
                        0003,A4EF,
                        9E0A,FFFA,FFFA, ; ???
                        0002,A521,
                        9E0A,FFF8,FFF8, ; ???
                        0001,A55B,
                        9E0A,0000,0000, ; ???
                        9B9A,           ; ???
                        9F60,0025,      ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        0003,A59D,
                        0001,A55B,
                        0002,A521,
                        0003,A4EF,
                        0004,A4C5,
                        0005,A4A3,
                        0006,A489,
                        8110,9A6C,      ; Decrement timer and go to $9A6C if non-zero
                        9F57,9128,      ; ???
                        80ED,99C6       ; Go to $99C6
}


;;; $9AE6: Instruction list -  ;;;
{
$A5:9AE6             dx 812F        ; Sleep
}


;;; $9AE8: Instruction list -  ;;;
{
$A5:9AE8             dx 9E0A,FFFF,FFFF, ; ???
                        0002,A42F,
                        9E0A,FFFE,FFFE, ; ???
                        0006,A489,
                        9E0A,FFFD,FFFD, ; ???
                        0005,A4A3,
                        9E0A,FFFC,FFFC, ; ???
                        0004,A4C5,
                        9E0A,FFFB,FFFB, ; ???
                        0003,A4EF,
                        9E0A,FFFA,FFFA, ; ???
                        0002,A521,
                        9E0A,FFF8,FFF8, ; ???
                        0001,A55B,
                        9E0A,0000,0000, ; ???
                        9B9A,           ; ???
                        9F60,0025,      ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        0003,A59D,
                        0001,A55B,
                        0002,A521,
                        0003,A4EF,
                        0004,A4C5,
                        0005,A4A3,
                        0006,A489,
                        80ED,99C6       ; Go to $99C6
}


;;; $9B5A: Instruction list -  ;;;
{
$A5:9B5A             dx 0002,A42F,
                        0006,A489,
                        0005,A4A3,
                        0004,A4C5,
                        0003,A4EF,
                        0002,A521,
                        0001,A55B,
                        9F60,0025,  ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        0003,A59D,
                        0001,A55B,
                        0002,A521,
                        0003,A4EF,
                        0004,A4C5,
                        0005,A4A3,
                        0006,A489,
                        80ED,99C6   ; Go to $99C6
}


;;; $9B9A: Instruction -  ;;;
{
; hurt samus from tailstab
$A5:9B9A DA          PHX
$A5:9B9B 5A          PHY
$A5:9B9C A9 18 00    LDA #$0018
$A5:9B9F 8F 1E 78 7E STA $7E781E[$7E:781E]
$A5:9BA3 AE 78 0F    LDX $0F78  [$7E:0F78]
$A5:9BA6 BF 06 00 A0 LDA $A00006,x[$A0:DE45]
$A5:9BAA 22 5E A4 A0 JSL $A0A45E[$A0:A45E]
$A5:9BAE 22 51 DF 91 JSL $91DF51[$91:DF51]
$A5:9BB2 A9 20 00    LDA #$0020
$A5:9BB5 8D 40 18    STA $1840  [$7E:1840]
$A5:9BB8 A9 07 00    LDA #$0007
$A5:9BBB 8D 3E 18    STA $183E  [$7E:183E]
$A5:9BBE AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A5:9BC1 85 12       STA $12    [$7E:0012]
$A5:9BC3 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A5:9BC6 18          CLC
$A5:9BC7 69 10 00    ADC #$0010
$A5:9BCA 85 14       STA $14    [$7E:0014]
$A5:9BCC A9 15 00    LDA #$0015
$A5:9BCF 85 16       STA $16    [$7E:0016]
$A5:9BD1 64 18       STZ $18    [$7E:0018]
$A5:9BD3 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:9BD7 7A          PLY
$A5:9BD8 FA          PLX
$A5:9BD9 6B          RTL
}


;;; $9BDA: Instruction list - Draygon arms ;;;
{
$A5:9BDA             dx 0005,A607,
                        0005,A611,
                        0005,A61B,
                        0005,A625,
                        0005,A62F,
                        0005,A639,
                        80ED,9BDA   ; Go to $9BDA
}


;;; $9BF6: Instruction list -  ;;;
{
$A5:9BF6             dx 812F        ; Sleep
}


;;; $9BF8: Instruction list -  ;;;
{
$A5:9BF8             dx 0001,A701,
                        0001,A6F7,
                        0040,A6ED,
                        812F        ; Sleep
}


;;; $9C06: Instruction list -  ;;;
{
$A5:9C06             dx 0001,A6ED,
                        0001,A6F7,
                        0001,A701,
                        0040,A70B,
                        812F        ; Sleep
}


;;; $9C18: Instruction list -  ;;;
{
$A5:9C18             dx 0001,A6ED,
                        0001,A6F7,
                        0001,A701,
                        0040,A70B,
                        0001,A701,
                        0001,A6F7,
                        0040,A6ED,
                        80ED,9BDA   ; Go to $9BDA
}


;;; $9C38: Instruction list -  ;;;
{
$A5:9C38             dx 0001,A6ED,
                        0001,A6F7,
                        0001,A701,
                        0008,A70B,
                        0001,A701,
                        0001,A6F7,
                        0001,A6ED,
                        0001,A6F7,
                        812F        ; Sleep
}


;;; $9C5A: Instruction list -  ;;;
{
$A5:9C5A             dx 0005,A643,
                        0005,A64D,
                        0005,A657,
                        0005,A661,
                        80ED,989B   ; Go to $989B
}


;;; $9C6E: Instruction list -  ;;;
{
$A5:9C6E             dx 812F        ; Sleep
}


;;; $9C70: Instruction list -  ;;;
{
$A5:9C70             dx 0005,A657,
                        0005,A64D,
                        0005,A643,
                        812F        ; Sleep
}


;;; $9C7E: Instruction list - Draygon body -  ;;;
{
$A5:9C7E             dx 9C8A,       ; Room loading interrupt command = Draygon's room - begin HUD drawing
                        C47B,C513,  ; ???
                        0001,A6E3,
                        812F        ; Sleep
}


;;; $9C8A: Instruction - room loading interrupt command = Draygon's room - begin HUD drawing ;;;
{
$A5:9C8A A9 0C 00    LDA #$000C
$A5:9C8D 85 A9       STA $A9    [$7E:00A9]
$A5:9C8F 6B          RTL
}


;;; $9C90: Instruction list -  ;;;
{
$A5:9C90             dx 0001,A66B,
                        0002,A675,
                        0003,A67F,
                        9FAE,       ; ???
                        9F60,004C,  ; Queue sound 004Ch, sound library 2, max queued sounds allowed = 6
                        0003,A689,
                        0002,A67F,
                        0002,A675,
                        0001,A66B,
                        812F        ; Sleep
}


;;; $9CB4: Instruction list -  ;;;
{
$A5:9CB4             dx 9F60,0073,  ; Queue sound 0073h, sound library 2, max queued sounds allowed = 6
                        0006,A66B,
                        0006,A675,
                        0006,A67F,
                        0006,A689,
                        0006,A67F,
                        0006,A675,
                        0006,A66B,
                        812F        ; Sleep
}


;;; $9CD6: Instruction list - Draygon eye -  ;;;
{
$A5:9CD6             dx 0015,A693,
                        0005,A69D,
                        0005,A6A7,
                        000A,A69D,
                        000A,A6BB,
                        000A,A6BB,
                        000A,A6CF,
                        000A,A6CF,
                        000A,A6D9,
                        0005,A6A7,
                        0005,A69D,
                        0005,A693,
                        9736,C48D,  ; ???
                        812F        ; Sleep
}


;;; $9D0C: Instruction list -  ;;;
{
$A5:9D0C             dx 0015,A693,
                        0005,A69D,
                        0005,A6A7,
                        000A,A6B1,
                        8123,0004,  ; Timer = 0004h
                        0004,A6BB,
                        0004,A6CF,
                        0004,A6C5,
                        0004,A6D9,
                        8110,9D20,  ; Decrement timer and go to $9D20 if non-zero
                        0020,A6B1,
                        0010,A6A7,
                        812F        ; Sleep
}


;;; $9D3E: Instruction list -  ;;;
{
$A5:9D3E             dx 0020,A6B1,
                        0020,A6A7,
                        0020,A69D,
                        0001,A693,
                        812F        ; Sleep
}


;;; $9D50: Instruction list - Draygon eye - facing right - looking right ;;;
{
$A5:9D50             dx 0001,A6BB,
                        812F        ; Sleep
}


;;; $9D56: Instruction list - Draygon eye - facing right - looking left ;;;
{
$A5:9D56             dx 0001,A6C5,
                        812F        ; Sleep
}


;;; $9D5C: Instruction list - Draygon eye - facing right - looking up ;;;
{
$A5:9D5C             dx 0001,A6CF,
                        812F        ; Sleep
}


;;; $9D62: Instruction list - Draygon eye - facing right - looking down ;;;
{
$A5:9D62             dx 0001,A6D9,
                        812F        ; Sleep
}


;;; $9D68: Instruction list - Draygon tail -  ;;;
{
$A5:9D68             dx 0008,A779,
                        0007,A78B,
                        0006,A79D,
                        0006,A7AF,
                        0006,A7C1,
                        0006,A7D3,
                        0006,A7E5,
                        0006,A7D3,
                        0006,A7C1,
                        0006,A7AF,
                        0006,A79D,
                        0007,A78B,
                        80ED,9D68   ; Go to $9D68
}


;;; $9D9C: Instruction list -  ;;;
{
$A5:9D9C             dx 812F        ; Sleep
}


;;; $9D9E: Instruction list -  ;;;
{
$A5:9D9E             dx 9E0A,0001,FFFF, ; ???
                        0010,A79D,
                        9E0A,0002,FFFE, ; ???
                        0006,A7F7,
                        9E0A,0003,FFFD, ; ???
                        0005,A811,
                        9E0A,0004,FFFC, ; ???
                        0004,A833,
                        9E0A,0005,FFFB, ; ???
                        0003,A85D,
                        9E0A,0006,FFFA, ; ???
                        0002,A88F,
                        9E0A,0008,FFF9, ; ???
                        0001,A8C9,
                        9E0A,0000,0000, ; ???
                        0010,A90B,
                        0001,A8C9,
                        0002,A88F,
                        0003,A85D,
                        0004,A833,
                        0005,A811,
                        0006,A7F7,
                        80ED,9D68       ; Go to $9D68
}


;;; $9E0A: Instruction ;;;
{
$A5:9E0A DA          PHX
$A5:9E0B 5A          PHY
$A5:9E0C B9 00 00    LDA $0000,y[$A5:99FE]
$A5:9E0F 8F 3C 88 7E STA $7E883C[$7E:883C]
$A5:9E13 B9 02 00    LDA $0002,y[$A5:9A00]
$A5:9E16 8F 3E 88 7E STA $7E883E[$7E:883E]
$A5:9E1A 7A          PLY
$A5:9E1B FA          PLX
$A5:9E1C C8          INY
$A5:9E1D C8          INY
$A5:9E1E C8          INY
$A5:9E1F C8          INY
$A5:9E20 6B          RTL
}


;;; $9E21: Instruction list -  ;;;
{
$A5:9E21             dx 8123,0004       ; Timer = 0004h
$A5:9E25             dx 9E0A,0001,FFFF, ; ???
                        0002,A79D,
                        9E0A,0002,FFFE, ; ???
                        0006,A7F7,
                        9E0A,0003,FFFD, ; ???
                        0005,A811,
                        9E0A,0004,FFFC, ; ???
                        0004,A833,
                        9E0A,0005,FFFB, ; ???
                        0003,A85D,
                        9E0A,0006,FFFA, ; ???
                        0002,A88F,
                        9E0A,0008,FFF8, ; ???
                        0001,A8C9,
                        9E0A,0000,0000, ; ???
                        9B9A,           ; ???
                        9F60,0025,      ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        0003,A90B,
                        0001,A8C9,
                        0002,A88F,
                        0003,A85D,
                        0004,A833,
                        0005,A811,
                        0006,A7F7,
                        8110,9E25,      ; Decrement timer and go to $9E25 if non-zero
                        9F57,9128,      ; ???
                        80ED,9D68       ; Go to $9D68
}


;;; $9E9F: Instruction list -  ;;;
{
$A5:9E9F             dx 812F        ; Sleep
}


;;; $9EA1: Instruction list -  ;;;
{
$A5:9EA1             dx 9E0A,0001,FFFF, ; ???
                        0002,A79D,
                        9E0A,0002,FFFE, ; ???
                        0006,A7F7,
                        9E0A,0003,FFFD, ; ???
                        0005,A811,
                        9E0A,0004,FFFC, ; ???
                        0004,A833,
                        9E0A,0005,FFFB, ; ???
                        0003,A85D,
                        9E0A,0006,FFFA, ; ???
                        0002,A88F,
                        9E0A,0008,FFF8, ; ???
                        0001,A8C9,
                        9E0A,0000,0000, ; ???
                        9B9A,           ; ???
                        9F60,0025,      ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        0003,A90B,
                        0001,A8C9,
                        0002,A88F,
                        0003,A85D,
                        0004,A833,
                        0005,A811,
                        0006,A7F7,
                        80ED,9D68       ; Go to $9D68
}


;;; $9F13: Instruction list -  ;;;
{
$A5:9F13             dx 812F        ; Sleep
}


;;; $9F15: Instruction list -  ;;;
{
$A5:9F15             dx 0002,A79D,
                        0006,A7F7,
                        0005,A811,
                        0004,A833,
                        0003,A85D,
                        0002,A88F,
                        0001,A8C9,
                        9F60,0025,  ; Queue sound 0025h, sound library 2, max queued sounds allowed = 6
                        0003,A90B,
                        0001,A8C9,
                        0002,A88F,
                        0003,A85D,
                        0004,A833,
                        0005,A811,
                        0006,A7F7,
                        80ED,9D68   ; Go to $9D68
}


;;; $9F55: Instruction list -  ;;;
{
$A5:9F55             dx 812F        ; Sleep
}


;;; $9F57: Instruction - Draygon body function = [[Y]] ;;;
{
$A5:9F57 B9 00 00    LDA $0000,y
$A5:9F5A 8D A8 0F    STA $0FA8  [$7E:0FA8]
$A5:9F5D C8          INY
$A5:9F5E C8          INY
$A5:9F5F 6B          RTL
}


;;; $9F60: Instruction - queue sound [[Y]], sound library 2, max sounds allowed = 6 ;;;
{
$A5:9F60 DA          PHX
$A5:9F61 5A          PHY
$A5:9F62 B9 00 00    LDA $0000,y[$A5:9CA0]
$A5:9F65 22 CB 90 80 JSL $8090CB[$80:90CB]
$A5:9F69 7A          PLY
$A5:9F6A FA          PLX
$A5:9F6B C8          INY
$A5:9F6C C8          INY
$A5:9F6D 6B          RTL
}


;;; $9F6E: Instruction - queue sound [[Y]], sound library 3, max sounds allowed = 6 ;;;
{
$A5:9F6E DA          PHX
$A5:9F6F 5A          PHY
$A5:9F70 B9 00 00    LDA $0000,y[$A5:989D]
$A5:9F73 22 4D 91 80 JSL $80914D[$80:914D]
$A5:9F77 7A          PLY
$A5:9F78 FA          PLX
$A5:9F79 C8          INY
$A5:9F7A C8          INY
$A5:9F7B 6B          RTL
}


;;; $9F7C: Instruction ;;;
{
$A5:9F7C DA          PHX
$A5:9F7D 5A          PHY
$A5:9F7E AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:9F81 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:9F84 18          CLC
$A5:9F85 69 E4 FF    ADC #$FFE4
$A5:9F88 85 12       STA $12    [$7E:0012]
$A5:9F8A AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:9F8D 18          CLC
$A5:9F8E 69 F0 FF    ADC #$FFF0
$A5:9F91 85 14       STA $14    [$7E:0014]
$A5:9F93 22 11 81 80 JSL $808111[$80:8111]
$A5:9F97 29 3F 00    AND #$003F
$A5:9F9A 18          CLC
$A5:9F9B 69 80 00    ADC #$0080
$A5:9F9E 8D 95 19    STA $1995  [$7E:1995]
$A5:9FA1 A0 50 8E    LDY #$8E50             ;\
$A5:9FA4 A9 02 00    LDA #$0002             ;} Spawn Draygon's gunk enemy projectile
$A5:9FA7 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:9FAB 7A          PLY
$A5:9FAC FA          PLX
$A5:9FAD 6B          RTL
}


;;; $9FAE: Instruction ;;;
{
$A5:9FAE DA          PHX
$A5:9FAF 5A          PHY
$A5:9FB0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:9FB3 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:9FB6 18          CLC
$A5:9FB7 69 18 00    ADC #$0018
$A5:9FBA 85 12       STA $12    [$7E:0012]
$A5:9FBC AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:9FBF 18          CLC
$A5:9FC0 69 F0 FF    ADC #$FFF0
$A5:9FC3 85 14       STA $14    [$7E:0014]
$A5:9FC5 22 11 81 80 JSL $808111[$80:8111]
$A5:9FC9 29 3F 00    AND #$003F
$A5:9FCC 18          CLC
$A5:9FCD 69 C0 00    ADC #$00C0
$A5:9FD0 8D 95 19    STA $1995  [$7E:1995]
$A5:9FD3 A0 50 8E    LDY #$8E50             ;\
$A5:9FD6 A9 02 00    LDA #$0002             ;} Spawn Draygon's gunk enemy projectile
$A5:9FD9 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:9FDD 7A          PLY
$A5:9FDE FA          PLX
$A5:9FDF 6B          RTL
}
}


;;; $9FE0:  ;;;
{
; move death evirs
$A5:9FE0 5A          PHY
$A5:9FE1 A2 3E 00    LDX #$003E
$A5:9FE4 A0 14 00    LDY #$0014

$A5:9FE7 B9 DF A1    LDA $A1DF,y[$A5:A1F3]
$A5:9FEA 18          CLC
$A5:9FEB 69 40 00    ADC #$0040
$A5:9FEE 89 80 00    BIT #$0080
$A5:9FF1 F0 19       BEQ $19    [$A00C]
$A5:9FF3 BF 78 F1 7E LDA $7EF178,x[$7E:F1B0]
$A5:9FF7 18          CLC
$A5:9FF8 79 AF A1    ADC $A1AF,y[$A5:A1B7]
$A5:9FFB 9F 78 F1 7E STA $7EF178,x[$7E:F1B0]
$A5:9FFF BF F8 F0 7E LDA $7EF0F8,x[$7E:F130]
$A5:A003 69 00 00    ADC #$0000
$A5:A006 9F F8 F0 7E STA $7EF0F8,x[$7E:F130]
$A5:A00A 80 17       BRA $17    [$A023]

$A5:A00C BF 78 F1 7E LDA $7EF178,x[$7E:F1B6]
$A5:A010 38          SEC
$A5:A011 F9 AF A1    SBC $A1AF,y[$A5:A1C3]
$A5:A014 9F 78 F1 7E STA $7EF178,x[$7E:F1B6]
$A5:A018 BF F8 F0 7E LDA $7EF0F8,x[$7E:F136]
$A5:A01C ED 24 0E    SBC $0E24  [$7E:0E24]
$A5:A01F 9F F8 F0 7E STA $7EF0F8,x[$7E:F136]

$A5:A023 B9 DF A1    LDA $A1DF,y[$A5:A1F3]
$A5:A026 18          CLC
$A5:A027 69 80 00    ADC #$0080
$A5:A02A 89 80 00    BIT #$0080
$A5:A02D F0 19       BEQ $19    [$A048]
$A5:A02F BF 78 F2 7E LDA $7EF278,x[$7E:F2B6]
$A5:A033 18          CLC
$A5:A034 79 B1 A1    ADC $A1B1,y[$A5:A1C5]
$A5:A037 9F 78 F2 7E STA $7EF278,x[$7E:F2B6]
$A5:A03B BF F8 F1 7E LDA $7EF1F8,x[$7E:F236]
$A5:A03F 69 00 00    ADC #$0000
$A5:A042 9F F8 F1 7E STA $7EF1F8,x[$7E:F236]
$A5:A046 80 17       BRA $17    [$A05F]

$A5:A048 BF 78 F2 7E LDA $7EF278,x
$A5:A04C 38          SEC
$A5:A04D F9 B1 A1    SBC $A1B1,y
$A5:A050 9F 78 F2 7E STA $7EF278,x
$A5:A054 BF F8 F1 7E LDA $7EF1F8,x
$A5:A058 E9 00 00    SBC #$0000
$A5:A05B 9F F8 F1 7E STA $7EF1F8,x

$A5:A05F CA          DEX
$A5:A060 CA          DEX
$A5:A061 88          DEY
$A5:A062 88          DEY
$A5:A063 88          DEY
$A5:A064 88          DEY
$A5:A065 10 02       BPL $02    [$A069]
$A5:A067 7A          PLY
$A5:A068 60          RTS

$A5:A069 4C E7 9F    JMP $9FE7  [$A5:9FE7]
}


;;; $A06C:  ;;;
{
$A5:A06C DA          PHX
$A5:A06D 5A          PHY
$A5:A06E A2 3E 00    LDX #$003E
$A5:A071 A9 00 00    LDA #$0000

$A5:A074 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6]
$A5:A078 CA          DEX
$A5:A079 CA          DEX
$A5:A07A 10 F8       BPL $F8    [$A074]
$A5:A07C A2 02 00    LDX #$0002
$A5:A07F A0 14 00    LDY #$0014

$A5:A082 B9 C7 A1    LDA $A1C7,y[$A5:A1DB]
$A5:A085 85 12       STA $12    [$7E:0012]
$A5:A087 B9 C9 A1    LDA $A1C9,y[$A5:A1DD]
$A5:A08A 85 14       STA $14    [$7E:0014]
$A5:A08C A9 3B 00    LDA #$003B
$A5:A08F 85 16       STA $16    [$7E:0016]
$A5:A091 A9 00 0E    LDA #$0E00
$A5:A094 85 18       STA $18    [$7E:0018]
$A5:A096 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:A09A 88          DEY
$A5:A09B 88          DEY
$A5:A09C 88          DEY
$A5:A09D 88          DEY
$A5:A09E CA          DEX
$A5:A09F 10 E1       BPL $E1    [$A082]
$A5:A0A1 A2 02 00    LDX #$0002

$A5:A0A4 B9 C7 A1    LDA $A1C7,y[$A5:A1CF]
$A5:A0A7 85 12       STA $12    [$7E:0012]
$A5:A0A9 B9 C9 A1    LDA $A1C9,y[$A5:A1D1]
$A5:A0AC 85 14       STA $14    [$7E:0014]
$A5:A0AE A9 3C 00    LDA #$003C
$A5:A0B1 85 16       STA $16    [$7E:0016]
$A5:A0B3 A9 00 0E    LDA #$0E00
$A5:A0B6 85 18       STA $18    [$7E:0018]
$A5:A0B8 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:A0BC 88          DEY
$A5:A0BD 88          DEY
$A5:A0BE 88          DEY
$A5:A0BF 88          DEY
$A5:A0C0 CA          DEX
$A5:A0C1 10 E1       BPL $E1    [$A0A4]
$A5:A0C3 7A          PLY
$A5:A0C4 FA          PLX
$A5:A0C5 60          RTS
}


;;; $A0C6:  ;;;
{
; delete death evirs
$A5:A0C6 DA          PHX
$A5:A0C7 5A          PHY
$A5:A0C8 A2 3E 00    LDX #$003E
$A5:A0CB A9 00 00    LDA #$0000

$A5:A0CE 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6]
$A5:A0D2 CA          DEX
$A5:A0D3 CA          DEX
$A5:A0D4 10 F8       BPL $F8    [$A0CE]
$A5:A0D6 7A          PLY
$A5:A0D7 FA          PLX
$A5:A0D8 60          RTS
}


;;; $A0D9: Spawn fight intro mini-Draygon sprite objects ;;;
{
$A5:A0D9 DA          PHX
$A5:A0DA 5A          PHY
$A5:A0DB A9 10 00    LDA #$0010             ;\
$A5:A0DE 85 12       STA $12    [$7E:0012]  ;|
$A5:A0E0 A9 80 01    LDA #$0180             ;|
$A5:A0E3 85 14       STA $14    [$7E:0014]  ;|
$A5:A0E5 A9 3B 00    LDA #$003B             ;} Create sprite object 3Bh (mini-Draygon facing left) at position (10h, 180h) with palette 7
$A5:A0E8 85 16       STA $16    [$7E:0016]  ;|
$A5:A0EA A9 00 0E    LDA #$0E00             ;|
$A5:A0ED 85 18       STA $18    [$7E:0018]  ;|
$A5:A0EF 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A5:A0F3 A9 10 00    LDA #$0010             ;\
$A5:A0F6 85 12       STA $12    [$7E:0012]  ;|
$A5:A0F8 A9 80 01    LDA #$0180             ;|
$A5:A0FB 85 14       STA $14    [$7E:0014]  ;|
$A5:A0FD A9 3B 00    LDA #$003B             ;} Create sprite object 3Bh (mini-Draygon facing left) at position (10h, 180h) with palette 7
$A5:A100 85 16       STA $16    [$7E:0016]  ;|
$A5:A102 A9 00 0E    LDA #$0E00             ;|
$A5:A105 85 18       STA $18    [$7E:0018]  ;|
$A5:A107 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A5:A10B A9 10 00    LDA #$0010             ;\
$A5:A10E 85 12       STA $12    [$7E:0012]  ;|
$A5:A110 A9 80 01    LDA #$0180             ;|
$A5:A113 85 14       STA $14    [$7E:0014]  ;|
$A5:A115 A9 3B 00    LDA #$003B             ;} Create sprite object 3Bh (mini-Draygon facing left) at position (10h, 180h) with palette 7
$A5:A118 85 16       STA $16    [$7E:0016]  ;|
$A5:A11A A9 00 0E    LDA #$0E00             ;|
$A5:A11D 85 18       STA $18    [$7E:0018]  ;|
$A5:A11F 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A5:A123 A9 10 00    LDA #$0010             ;\
$A5:A126 85 12       STA $12    [$7E:0012]  ;|
$A5:A128 A9 80 01    LDA #$0180             ;|
$A5:A12B 85 14       STA $14    [$7E:0014]  ;|
$A5:A12D A9 3B 00    LDA #$003B             ;} Create sprite object 3Bh (mini-Draygon facing left) at position (10h, 180h) with palette 7
$A5:A130 85 16       STA $16    [$7E:0016]  ;|
$A5:A132 A9 00 0E    LDA #$0E00             ;|
$A5:A135 85 18       STA $18    [$7E:0018]  ;|
$A5:A137 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A5:A13B 7A          PLY
$A5:A13C FA          PLX
$A5:A13D 60          RTS
}


;;; $A13E: Handle Draygon fight intro dance ;;;
{
; There's 8 entries in the movement latency table $A19F, but only 4 mini-Draygon are processed
; I guess there was supposed to be 8 originally and then it was reduced to 4?
; In any case, it's the first four entries of the table that are used, where the last 4 would have made more sense
; The consequence of this is a 128 frames of this routine doing nothing
$A5:A13E 5A          PHY
$A5:A13F A2 3E 00    LDX #$003E             ; X = 3Eh (sprite object index)

; LOOP
$A5:A142 8A          TXA                    ;\
$A5:A143 38          SEC                    ;|
$A5:A144 E9 38 00    SBC #$0038             ;|
$A5:A147 A8          TAY                    ;|
$A5:A148 B9 9F A1    LDA $A19F,y[$A5:A1A5]  ;} If [$A19F + [X] - 38h] + [Draygon fight intro dance index] < 0: go to BRANCH_NEXT
$A5:A14B 18          CLC                    ;|
$A5:A14C 6F 0C 88 7E ADC $7E880C[$7E:880C]  ;|
$A5:A150 30 2F       BMI $2F    [$A181]     ;/
$A5:A152 A8          TAY                    ; Y = [$A19F + [X] - 38h] + [Draygon fight intro dance index]
$A5:A153 B9 07 CE    LDA $CE07,y[$A5:CE07]  ;\
$A5:A156 C9 80 80    CMP #$8080             ;} If [$CE07 + [Y]] = 80h,80h: go to BRANCH_DELETE_SPRITE_OBJECT
$A5:A159 F0 3B       BEQ $3B    [$A196]     ;/
$A5:A15B B9 07 CE    LDA $CE07,y[$A5:CE07]  ;\
$A5:A15E 29 FF 00    AND #$00FF             ;|
$A5:A161 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$A5:A165 18          CLC                    ;} Sprite object [X] X position += ±[$CE07 + [Y]]
$A5:A166 7F F8 F0 7E ADC $7EF0F8,x[$7E:F136];|
$A5:A16A 9F F8 F0 7E STA $7EF0F8,x[$7E:F136];/
$A5:A16E B9 08 CE    LDA $CE08,y[$A5:CE08]  ;\
$A5:A171 29 FF 00    AND #$00FF             ;|
$A5:A174 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]  ;|
$A5:A178 18          CLC                    ;} Sprite object [X] Y position += ±[$CE07 + [Y] + 1]
$A5:A179 7F F8 F1 7E ADC $7EF1F8,x[$7E:F236];|
$A5:A17D 9F F8 F1 7E STA $7EF1F8,x[$7E:F236];/

; BRANCH_NEXT
$A5:A181 CA          DEX                    ;\
$A5:A182 CA          DEX                    ;} X -= 2 (next sprite object)
$A5:A183 E0 38 00    CPX #$0038             ;\
$A5:A186 10 BA       BPL $BA    [$A142]     ;} If [X] >= 38h: go to LOOP
$A5:A188 AF 0C 88 7E LDA $7E880C[$7E:880C]  ;\
$A5:A18C 1A          INC A                  ;|
$A5:A18D 1A          INC A                  ;|
$A5:A18E 1A          INC A                  ;} Draygon fight intro dance index += 4 (!)
$A5:A18F 1A          INC A                  ;|
$A5:A190 8F 0C 88 7E STA $7E880C[$7E:880C]  ;/
$A5:A194 7A          PLY
$A5:A195 60          RTS                    ; Return

; BRANCH_DELETE_SPRITE_OBJECT
$A5:A196 A9 00 00    LDA #$0000             ;\
$A5:A199 9F 78 EF 7E STA $7EEF78,x[$7E:EFB6];} Sprite object [X] instruction list pointer = 0
$A5:A19D 80 E2       BRA $E2    [$A181]     ; Go to BRANCH_NEXT

; Movement latency for each mini-Draygon sprite object (each mini-Draygon moves 80h bytes later in the movement table than the next)
$A5:A19F             dw FC80, FD00, FD80, FE00,
                        FE80, FF00, FF80, 0000 ; <-- Unused
}


;;; $A1AF:  ;;;
{
$A5:A1AF             dw D4DA,8E39, 8E39,D4DA, 31F1,FB13, 31F1,FB13, 8E39,D4DA, D4DA,8E39
$A5:A1C7             dw FF59,00E5, FFE5,0059, 009C,000D, 0163,000D, 021A,0059, 02A6,00E5
$A5:A1DF             dw 0068,0000, 0058,0000, 0048,0000, 0038,0000, 0028,0000, 0018,0000
}


;;; $A1F7: Palette - enemy $DE3F/$DEBF/$DEFF (Draygon body/tail/arms) ;;;
{
$A5:A1F7             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 0319, 0254, 018F, 00CA, 581B, 1892, 0145
}


;;; $A217: Draygon palettes ;;;
{
$A5:A217             dw 3800,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,0319,0254,018F,00CA,581B,1892,0145,
$A5:A237             dw 3800,6B5A,5652,28E7,1863,62B5,4A10,396B,3129,43FF,0113,000F,175C,0299,01D6,03E0,
$A5:A257             dw 3800,4B9C,3694,0929,0042,42F7,2A52,19AD,116B,1420,1420,1420,1420,1420,1420,1420,
$A5:A277             dw 3800,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,0319,0254,018F,00CA,581B,1892,0145,
$A5:A297             dw 3800,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF,7FFF
}


;;; $A2B7: Draygon extended spritemaps ;;;
{
$A5:A2B7             dx 0001, 0000,0000,ABDF,AAC7
$A5:A2C1             dx 0001, 0000,0000,ABDF,AAC7
$A5:A2CB             dx 0001, 0000,0000,ABDF,AAC7
$A5:A2D5             dx 0001, 0000,0000,ABDF,AAC7
$A5:A2DF             dx 0001, 0000,0001,AE6B,AAC7
$A5:A2E9             dx 0001, 0000,0001,AECC,AAC7
$A5:A2F3             dx 0001, 0000,0001,AF23,AAC7
$A5:A2FD             dx 0001, 0000,0001,AF7A,AAC7
$A5:A307             dx 0001, 0000,0001,AFDB,AAC7
$A5:A311             dx 0001, 0000,0001,B041,AAC7
$A5:A31B             dx 0001, 0000,0000,B380,AA95
$A5:A325             dx 0001, 0000,0000,B3A2,AA95
$A5:A32F             dx 0001, 0000,0000,B3C0,AA95
$A5:A339             dx 0001, 0000,0000,B3E2,AA95
$A5:A343             dx 0001, 0000,0000,B330,AA95
$A5:A34D             dx 0001, 0000,0000,B344,AA95
$A5:A357             dx 0001, 0000,0000,B358,AA95
$A5:A361             dx 0001, 0000,0000,B36C,AA95
$A5:A36B             dx 0001, 0000,0000,B404,AAC7
$A5:A375             dx 0001, 0000,0000,B418,AAC7
$A5:A37F             dx 0001, 0000,0000,B42C,AAC7
$A5:A389             dx 0001, 0000,0000,B440,AAC7
$A5:A393             dx 0001, 0000,0000,B454,AAC7
$A5:A39D             dx 0001, 0000,0000,B468,AAC7
$A5:A3A7             dx 0001, 0000,0000,B47C,AAC7
$A5:A3B1             dx 0001, 0000,0000,B490,AAC7
$A5:A3BB             dx 0001, 0000,0000,B4A4,AA95
$A5:A3C5             dx 0001, 0000,0001,AC17,AAC7
$A5:A3CF             dx 0001, 0000,0001,AC91,AAC7
$A5:A3D9             dx 0001, 0000,0001,ACF7,AAC7
$A5:A3E3             dx 0001, 0000,0001,AD49,AAC7
$A5:A3ED             dx 0001, 0029,0001,ABDF,AAC7
$A5:A3F7             dx 0001, 0000,0000,B29A,AA25
$A5:A401             dx 0001, 0000,0000,B2E6,AA25
$A5:A40B             dx 0002, 001B,003F,B747,AAC7, 0037,0021,AD9B,AAC7
$A5:A41D             dx 0002, 0017,003D,B73B,AAC7, 0037,0021,AD9B,AAC7
$A5:A42F             dx 0002, 0013,003A,B72A,AAC7, 0037,0021,ADCF,AAC7
$A5:A441             dx 0002, 000E,0035,B719,AAC7, 0037,0021,ADCF,AAC7
$A5:A453             dx 0002, 000C,002E,B708,AAC7, 0037,0021,AE03,AAC7
$A5:A465             dx 0002, 000E,002D,B6FC,AAC7, 0037,0021,AE03,AAC7
$A5:A477             dx 0002, 0011,0028,B6E6,AAC7, 0037,0021,AE37,AAC7
$A5:A489             dx 0003, 000B,003C,B72A,AAC7, 0019,0032,B7D8,AAC7, 0037,0021,AD9B,AAC7
$A5:A4A3             dx 0004, 0008,0043,B72A,AAC7, 0014,0036,B7D8,AAC7, 0018,0031,B7D8,AAC7, 0037,0021,AD9B,AAC7
$A5:A4C5             dx 0005, 0009,004D,B73B,AAC7, 000F,003D,B7D8,AAC7, 0013,0036,B7D8,AAC7, 0019,0031,B7D1,AAC7, 0037,0021,ADCF,AAC7
$A5:A4EF             dx 0006, FFF8,004D,B72A,AAC7, 0007,0042,B7D8,AAC7, 000C,003C,B7D8,AAC7, 0013,0037,B7D1,AAC7, 001A,0032,B7D1,AAC7, 0037,0021,AE03,AAC7
$A5:A521             dx 0007, FFEC,0037,B6FC,AAC7, FFFC,003D,B7D8,AAC7, 0005,003F,B7D8,AAC7, 000D,003E,B7D1,AAC7, 0015,003A,B7D1,AAC7, 001B,0034,B7CA,AAC7, 0037,0021,AE37,AAC7
$A5:A55B             dx 0008, FFED,002E,B6E6,AAC7, FFF9,003A,B7D8,AAC7, 0000,0040,B7D8,AAC7, 0008,0041,B7D1,AAC7, 0011,0043,B7D1,AAC7, 0019,003F,B7CA,AAC7, 001D,0035,B7CA,AAC7, 0037,0021,AE37,AAC7
$A5:A59D             dx 0008, FFF7,0025,B6C4,AAC7, FFF8,0038,B7D8,AAC7, FFFD,0041,B7D8,AAC7, 0006,0043,B7D1,AAC7, 0010,0044,B7D1,AAC7, 0018,0041,B7CA,AAC7, 001E,0037,B7CA,AAC7, 0037,0021,AE37,AAC7
$A5:A5DF             dx 0001, 0000,0000,B7F4,AAC7
$A5:A5E9             dx 0001, 0000,0000,B7F4,AAC7
$A5:A5F3             dx 0001, 0000,0000,B7F4,AAC7
$A5:A5FD             dx 0001, 0000,0000,B7F4,AAC7
$A5:A607             dx 0001, 0000,0001,BAE2,AAC7
$A5:A611             dx 0001, 0000,0001,BB43,AAC7
$A5:A61B             dx 0001, 0000,0001,BB9A,AAC7
$A5:A625             dx 0001, 0000,0001,BBF1,AAC7
$A5:A62F             dx 0001, 0000,0001,BC52,AAC7
$A5:A639             dx 0001, 0000,0001,BCB8,AAC7
$A5:A643             dx 0001, 0000,0000,BFF7,ABAB
$A5:A64D             dx 0001, 0000,0000,C019,ABAB
$A5:A657             dx 0001, 0000,0000,C037,ABAB
$A5:A661             dx 0001, 0000,0000,C059,ABAB
$A5:A66B             dx 0001, 0000,0000,BFA7,ABAB
$A5:A675             dx 0001, 0000,0000,BFBB,ABAB
$A5:A67F             dx 0001, 0000,0000,BFCF,ABAB
$A5:A689             dx 0001, 0000,0000,BFE3,ABAB
$A5:A693             dx 0001, 0000,0000,C07B,AAC7
$A5:A69D             dx 0001, 0000,0000,C08F,AAC7
$A5:A6A7             dx 0001, 0000,0000,C0A3,AAC7
$A5:A6B1             dx 0001, 0000,0000,C0B7,AAC7
$A5:A6BB             dx 0001, 0000,0000,C0CB,AAC7
$A5:A6C5             dx 0001, 0000,0000,C0DF,AAC7
$A5:A6CF             dx 0001, 0000,0000,C0F3,AAC7
$A5:A6D9             dx 0001, 0000,0000,C107,AAC7
$A5:A6E3             dx 0001, 0000,0000,C11B,ABAB
$A5:A6ED             dx 0001, 0000,0001,B82C,AAC7
$A5:A6F7             dx 0001, 0000,0001,B8A6,AAC7
$A5:A701             dx 0001, 0000,0001,B90C,AAC7
$A5:A70B             dx 0001, 0000,0001,B95E,AAC7
$A5:A715             dx 0001, 0000,0000,B7F4,AAC7
$A5:A71F             dx 0001, 0000,0000,B7F4,AAC7
$A5:A729             dx 0001, 0000,0000,B7F4,AAC7
$A5:A733             dx 0001, 0000,0000,B7F4,AAC7
$A5:A73D             dx 0001, 0000,0000,B7F4,AAC7
$A5:A747             dx 0001, 0000,0000,B7F4,AAC7
$A5:A751             dx 0001, 0000,0000,B7F4,AAC7
$A5:A75B             dx 0001, 0000,0000,B7F4,AAC7
$A5:A765             dx 0001, 0000,0000,BF11,AB73
$A5:A76F             dx 0001, 0000,0000,BF5D,AB73
$A5:A779             dx 0002, FFE5,003F,C3BE,AAC7, FFCE,0021,B9D3,AAC7
$A5:A78B             dx 0002, FFE9,003D,C3B2,AAC7, FFCE,0021,B9D3,AAC7
$A5:A79D             dx 0002, FFED,003A,C3A1,AAC7, FFCE,0021,BA07,AAC7
$A5:A7AF             dx 0002, FFF2,0035,C390,AAC7, FFCE,0021,BA07,AAC7
$A5:A7C1             dx 0002, FFF4,002E,C37F,AAC7, FFCE,0021,BA7A,AAC7
$A5:A7D3             dx 0002, FFF2,002D,C373,AAC7, FFCE,0021,BA7A,AAC7
$A5:A7E5             dx 0002, FFEF,0028,C35D,AAC7, FFCE,0021,BAAE,AAC7
$A5:A7F7             dx 0003, FFF5,003C,C3A1,ABDD, FFE7,0032,C44F,AAC7, FFCE,0021,B9D3,AAC7
$A5:A811             dx 0004, FFF8,0043,C3A1,ABDD, FFEC,0036,C44F,AAC7, FFE8,0031,C44F,AAC7, FFCE,0021,B9D3,AAC7
$A5:A833             dx 0005, FFF7,004D,C3B2,ABDD, FFF1,003D,C44F,AAC7, FFED,0036,C44F,AAC7, FFE7,0031,C448,AAC7, FFCE,0021,BA07,AAC7
$A5:A85D             dx 0006, 0008,004D,C3A1,ABDD, FFF9,0042,C44F,AAC7, FFF4,003C,C44F,AAC7, FFED,0037,C448,AAC7, FFE6,0032,C448,AAC7, FFCE,0021,BA07,AAC7
$A5:A88F             dx 0007, 0014,0037,C373,ABDD, 0004,003D,C44F,AAC7, FFFB,003F,C44F,AAC7, FFF3,003E,C448,AAC7, FFEB,003A,C448,AAC7, FFE5,0034,C441,AAC7, FFCE,0021,BA7A,AAC7
$A5:A8C9             dx 0008, 0013,002E,C35D,ABDD, 0007,003A,C44F,AAC7, 0000,0040,C44F,AAC7, FFF8,0041,C448,AAC7, FFEF,0043,C448,AAC7, FFE7,003F,C441,AAC7, FFE3,0035,C441,AAC7, FFCE,0021,BA7A,AAC7
$A5:A90B             dx 0008, 0009,0025,C33B,ABDD, 0008,0038,C44F,AAC7, 0003,0041,C44F,AAC7, FFFA,0043,C448,AAC7, FFF0,0044,C448,AAC7, FFE8,0041,C441,AAC7, FFE2,0037,C441,AAC7, FFCE,0021,BAAE,AAC7
}


;;; $A94D: Draygon hitboxes ;;;
{
$A5:A94D             dx 0001, 0000,0000,0017,001F,95EA,802D
$A5:A95B             dx 0001, 0000,0000,0015,001F,95EA,802D
$A5:A969             dx 0001, 0000,0000,000C,0021,95EA,802D
$A5:A977             dx 0001, FFF9,FFF8,0006,0006,95EA,802D
$A5:A985             dx 0001, FFF7,FFF6,0009,0008,95EA,802D
$A5:A993             dx 0001, FFF9,FFF8,0007,0007,95EA,802D
$A5:A9A1             dx 0001, FFF8,FFF8,0006,0006,95EA,802D
$A5:A9AF             dx 0001, FFF7,FFF7,0004,0007,804C,804C
$A5:A9BD             dx 0000
$A5:A9BF             dx 0000
$A5:A9C1             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:A9CF             dx 0001, FFFB,FFFB,0003,0005,95EA,802D
$A5:A9DD             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:A9EB             dx 0001, FFF9,FFF9,0007,0006,95EA,802D
$A5:A9F9             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:AA07             dx 0001, FFFB,FFFC,0004,0004,95EA,802D
$A5:AA15             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:AA23             dx 0000
$A5:AA25             dx 0001, FFE2,FFE6,FFF2,FFF5,95EA,802D
$A5:AA33             dx 0001, FFE1,FFE6,FFF2,FFF6,95EA,802D
$A5:AA41             dx 0001, FFE1,FFE6,FFF2,FFF6,95EA,802D
$A5:AA4F             dx 0001, FFE1,FFE6,FFF2,FFF7,95EA,802D
$A5:AA5D             dx 0001, FFF3,0000,000A,0017,95EA,802D
$A5:AA6B             dx 0001, FFF3,0000,000A,0017,95EA,802D
$A5:AA79             dx 0001, FFF3,0000,000A,0017,95EA,802D
$A5:AA87             dx 0001, FFF3,0000,000A,0017,95EA,802D
$A5:AA95             dx 0004, FFEF,FFF0,0012,001E,804C,95F0, FFC5,FFBE,0003,FFE2,95EA,8046, 0010,0001,003C,0035,95EA,8046, FFE4,FFDB,003D,FFF6,95EA,8046
$A5:AAC7             dx 0000
$A5:AAC9             dx 0001, FFF9,FFF8,0006,0006,95EA,802D
$A5:AAD7             dx 0001, FFF7,FFF6,0009,0008,95EA,802D
$A5:AAE5             dx 0001, FFF9,FFF8,0007,0007,95EA,802D
$A5:AAF3             dx 0001, FFF8,FFF8,0006,0006,95EA,802D
$A5:AB01             dx 0001, FFFB,FFF7,0007,0007,804C,804C
$A5:AB0F             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:AB1D             dx 0001, FFFB,FFFB,0003,0005,95EA,802D
$A5:AB2B             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:AB39             dx 0001, FFF9,FFF9,0007,0006,95EA,802D
$A5:AB47             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:AB55             dx 0001, FFFB,FFFC,0004,0004,95EA,802D
$A5:AB63             dx 0001, FFFB,FFFB,0004,0004,95EA,802D
$A5:AB71             dx 0000
$A5:AB73             dx 0001, FFFA,0000,0010,0017,95EA,802D
$A5:AB81             dx 0001, FFFA,0000,0010,0017,95EA,802D
$A5:AB8F             dx 0001, FFFA,0000,0010,0017,95EA,802D
$A5:AB9D             dx 0001, FFFA,0000,0010,0017,95EA,802D
$A5:ABAB             dx 0004, FFEE,FFF9,0012,001E,804C,95F0, FFF6,FFC1,003E,FFE6,95EA,8046, FFC9,0000,FFEB,0039,95EA,8046, FFC2,FFDF,000F,FFFB,95EA,8046
$A5:ABDD             dx 0000
}


;;; $ABDF: Draygon spritemaps / extended tilemaps ;;;
{
$A5:ABDF             dx 0004, 8008,10,0721, 8008,00,0701, 8000,10,0720, 8000,00,0700
$A5:ABF5             dx 0004, 0000,10,2723, 8000,00,2703, 8008,10,2724, 8008,00,2704
$A5:AC0B             dx 0002, 8000,10,2726, 8000,00,2706
$A5:AC17             dx 0018, 81E5,02,271C, 81DD,0A,272B, 81ED,FA,270D, 01F4,EC,2750, 81FC,E4,2741, 81F4,F4,2760, 81ED,0A,271C, 81E5,12,272B, 81F5,02,270D, 01FC,F4,2750, 8004,EC,2741, 81FC,FC,2760, 81F5,12,271C, 81ED,1A,272B, 81FD,0A,270D, 0004,FC,2750, 800C,F4,2741, 8004,04,2760, 81FC,1B,271C, 81F4,23,272B, 8004,13,270D, 000B,05,2750, 8013,FD,2741, 800B,0D,2760
$A5:AC91             dx 0014, 81F8,F9,272E, 01E8,09,274C, 81F0,01,273D, 81FC,F4,2762, 81FC,E4,2743, 8000,01,272E, 01F0,11,274C, 81F8,09,273D, 8004,FC,2762, 8004,EC,2743, 8008,09,272E, 01F8,19,274C, 8000,11,273D, 800C,04,2762, 800C,F4,2743, 800F,12,272E, 01FF,22,274C, 8007,1A,273D, 8013,0D,2762, 8013,FD,2743
$A5:ACF7             dx 0010, 81F9,F9,2738, 8001,F1,2729, 8004,EC,2756, 81FC,E4,2745, 8000,00,2738, 8008,F8,2729, 800B,F3,2756, 8003,EB,2745, 8007,07,2738, 800F,FF,2729, 8012,FA,2756, 800A,F2,2745, 800E,0E,2738, 8016,06,2729, 8019,01,2756, 8011,F9,2745
$A5:AD49             dx 0010, 8000,F4,2768, 8000,EC,2758, 8004,E4,2709, 81FC,E4,2708, 8007,FC,2768, 8007,F4,2758, 800B,EC,2709, 8003,EC,2708, 800E,03,2768, 800E,FB,2758, 8012,F3,2709, 800A,F3,2708, 8015,0A,2768, 8015,02,2758, 8019,FA,2709, 8011,FA,2708
$A5:AD9B             dx 000A, 81FC,F0,0721, 81FC,E0,0701, 81F4,F0,0720, 81F4,E0,0700, 01F4,04,2723, 81F4,F4,2703, 81FC,04,2724, 81FC,F4,2704, 81F4,14,2726, 81F4,04,2706
$A5:ADCF             dx 000A, 81FB,F0,0721, 81FB,E0,0701, 81F3,F0,0720, 81F3,E0,0700, 01F3,04,2723, 81F3,F4,2703, 81FB,04,2724, 81FB,F4,2704, 81F3,14,2726, 81F3,04,2706
$A5:AE03             dx 000A, 81FB,F0,0721, 81FB,E0,0701, 81F3,F0,0720, 81F3,E0,0700, 01F2,04,2723, 81F2,F4,2703, 81FA,04,2724, 81FA,F4,2704, 81F2,14,2726, 81F2,04,2706
$A5:AE37             dx 000A, 81FB,F0,0721, 81FB,E0,0701, 81F3,F0,0720, 81F3,E0,0700, 01F2,04,2723, 81F2,F4,2703, 81FA,04,2724, 81FA,F4,2704, 81F1,14,2726, 81F1,04,2706
$A5:AE6B             dx 0013, 81E5,02,271C, 81DD,0A,272B, 81ED,FA,270D, 01F4,EC,2750, 81FC,E4,2741, 81F4,F4,2760, 8000,01,272E, 01F0,11,274C, 81F8,09,273D, 8004,FC,2762, 8004,EC,2743, 8009,09,2738, 8011,01,2729, 8014,FC,2756, 800C,F4,2745, 8018,0C,2768, 8018,04,2758, 801C,FC,2709, 8014,FC,2708
$A5:AECC             dx 0011, 81F8,F9,272E, 01E8,09,274C, 81F0,01,273D, 81FC,F4,2762, 81FC,E4,2743, 8001,01,2738, 8009,F9,2729, 800C,F4,2756, 8004,EC,2745, 8010,04,2768, 8010,FC,2758, 8014,F4,2709, 800C,F4,2708, 8011,11,2738, 8019,09,2729, 801C,04,2756, 8014,FC,2745
$A5:AF23             dx 0011, 81F9,F9,2738, 8001,F1,2729, 8004,EC,2756, 81FC,E4,2745, 8008,FC,2768, 8008,F4,2758, 800C,EC,2709, 8004,EC,2708, 8009,09,2738, 8011,01,2729, 8014,FC,2756, 800C,F4,2745, 8010,11,272E, 0000,21,274C, 8008,19,273D, 8014,0C,2762, 8014,FC,2743
$A5:AF7A             dx 0013, 8000,F4,2768, 8000,EC,2758, 8004,E4,2709, 81FC,E4,2708, 8001,01,2738, 8009,F9,2729, 800C,F4,2756, 8004,EC,2745, 8008,09,272E, 01F8,19,274C, 8000,11,273D, 800C,04,2762, 800C,F4,2743, 81FD,1A,271C, 81F5,22,272B, 8005,12,270D, 000C,04,2750, 8014,FC,2741, 800C,0C,2760
$A5:AFDB             dx 0014, 81F9,F9,2738, 8001,F1,2729, 8004,EC,2756, 81FC,E4,2745, 8000,01,272E, 01F0,11,274C, 81F8,09,273D, 8004,FC,2762, 8004,EC,2743, 81F5,12,271C, 81ED,1A,272B, 81FD,0A,270D, 0004,FC,2750, 800C,F4,2741, 8004,04,2760, 8010,11,272E, 0000,21,274C, 8008,19,273D, 8014,0C,2762, 8014,FC,2743
$A5:B041             dx 0014, 81F8,F9,272E, 01E8,09,274C, 81F0,01,273D, 81FC,F4,2762, 81FC,E4,2743, 81ED,0A,271C, 81E5,12,272B, 81F5,02,270D, 01FC,F4,2750, 8004,EC,2741, 81FC,FC,2760, 8008,09,272E, 01F8,19,274C, 8000,11,273D, 800C,04,2762, 800C,F4,2743, 8011,11,2738, 8019,09,2729, 801C,04,2756, 8014,FC,2745
$A5:B0A7             dx 0013, 81BB,E5,271C, 81B3,ED,272B, 81C3,DD,270D, 01CA,CF,2750, 81D2,C7,2741, 81CA,D7,2760, 800E,05,2768, 800E,FD,2758, 8012,F5,2709, 800A,F5,2708, 81F7,F0,2738, 81FF,E8,2729, 8002,E3,2756, 81FA,DB,2745, 81D8,ED,272E, 01C8,FD,274C, 81D0,F5,273D, 81DC,E8,2762, 81DC,D8,2743

$A5:B108             dx FFFE,
                        2316,0002, 159F,15A0,
                        2356,0002, 15AC,15AD,
                        2394,0003, 15B9,15BA,15BB,
                        23D4,0003, 15C8,15C9,15CA,
                        2414,0003, 15D7,15D8,15D9,
                        2454,0003, 15DF,15E0,1547,
                        2496,0002, 1547,1547,
                        FFFF

$A5:B14C             dx FFFE,
                        2316,0002, 1559,155A,
                        2356,0002, 1569,156A,
                        2394,0003, 1576,1577,1578,
                        23D2,0004, 1585,1586,1587,1588,
                        2412,0004, 1592,1593,1594,1595,
                        2452,0004, 15A1,15A2,15A3,0147,
                        2496,0002, 0147,0147,
                        FFFF

$A5:B196             dx FFFE,
                        2316,0002, 1596,1597,
                        2356,0002, 15A4,15A5,
                        2390,0005, 15AE,15AF,15B0,15B1,15B2,
                        23CE,0006, 15BC,15BD,15BE,15BF,15C0,15C1,
                        240E,0006, 15CB,15CC,15CD,15CE,15CF,15D0,
                        2452,0003, 0147,0147,0147,
                        FFFF

$A5:B1E2             dx FFFE,
                        230A,0003, 15DA,15DB,1547,
                        2316,0002, 15DC,15DD,
                        234C,0003, 15E1,15E2,15E3,
                        2354,0003, 15AE,15E4,15E5,
                        238C,0007, 15E9,15EA,15EB,15EC,15ED,15EE,15EF,
                        23CC,0007, 15F3,15F4,15F5,15F6,15F7,15F8,15F9,
                        240E,0005, 1600,1601,1602,1603,1604,
                        FFFF

$A5:B23E             dx FFFE,
                        230A,0003, 0147,0147,0147,
                        2316,0002, 1596,1597,
                        234C,0003, 0147,0147,0147,
                        2354,0003, 0147,15A4,15A5,
                        238C,0007, 0147,0147,15AE,15AF,15B0,15B1,15B2,
                        23CC,0007, 0147,15BC,15BD,15BE,15BF,15C0,15C1,
                        240E,0005, 15CB,15CC,15CD,15CE,15CF,
                        FFFF

$A5:B29A             dx FFFE,
                        2316,0002, 1559,155A,
                        2356,0002, 1569,156A,
                        2390,0005, 0147,0147,1576,1577,1578,
                        23CE,0006, 0147,0147,1585,1586,1587,1588,
                        240E,0006, 0147,0147,1592,1593,1594,1595,
                        2452,0003, 15A1,15A2,15A3,
                        FFFF

$A5:B2E6             dx FFFE,
                        2316,0002, 159F,15A0,
                        2356,0002, 15AC,15AD,
                        2394,0003, 15B9,15BA,15BB,
                        23D2,0004, 0147,15C8,15C9,15CA,
                        2412,0004, 0147,15D7,15D8,15D9,
                        2452,0004, 0147,15DF,15E0,1547,
                        2496,0002, 1547,1547,
                        FFFF

$A5:B330             dx FFFE,
                        2148,0002, 1554,1555,
                        2188,0002, 1564,1565,
                        FFFF

$A5:B344             dx FFFE,
                        2148,0002, 1580,1581,
                        2188,0002, 1590,1591,
                        FFFF

$A5:B358             dx FFFE,
                        2148,0002, 1582,1583,
                        2188,0002, 1592,1593,
                        FFFF

$A5:B36C             dx FFFE,
                        2148,0002, 1562,1563,
                        2188,0002, 1572,1573,
                        FFFF

$A5:B380             dx FFFE,
                        220C,0003, 1586,159E,159F,
                        224C,0003, 1596,1597,1598,
                        228C,0003, 15A6,15A7,15A8,
                        FFFF

$A5:B3A2             dx FFFE,
                        220C,0001, 159D,
                        224C,0003, 15AD,15AE,15AF,
                        228C,0003, 15BD,15BE,15BF,
                        FFFF

$A5:B3C0             dx FFFE,
                        220C,0003, 15A0,15A1,15A2,
                        224C,0003, 15B0,15B1,15B2,
                        228C,0003, 15B4,15B5,15B6,
                        FFFF

$A5:B3E2             dx FFFE,
                        220C,0003, 15A3,1584,1585,
                        224C,0003, 15B3,1594,1595,
                        228C,0003, 1574,15A4,15A5,
                        FFFF

$A5:B404             dx FFFE,
                        20C8,0002, 1540,1541,
                        2108,0002, 1550,1551,
                        FFFF

$A5:B418             dx FFFE,
                        20C8,0002, 1560,1561,
                        2108,0002, 1570,1571,
                        FFFF

$A5:B42C             dx FFFE,
                        20C8,0002, 150A,150B,
                        2108,0002, 151A,151B,
                        FFFF

$A5:B440             dx FFFE,
                        20C8,0002, 150C,150D,
                        2108,0002, 151C,151D,
                        FFFF

$A5:B454             dx FFFE,
                        20C8,0002, 1534,1535,
                        2108,0002, 1544,1545,
                        FFFF

$A5:B468             dx FFFE,
                        20C8,0002, 150E,150F,
                        2108,0002, 151E,151F,
                        FFFF

$A5:B47C             dx FFFE,
                        20C8,0002, 152C,152D,
                        2108,0002, 153C,153D,
                        FFFF

$A5:B490             dx FFFE,
                        20C8,0002, 152E,152F,
                        2108,0002, 153E,153F,
                        FFFF

$A5:B4A4             dx FFFE,
                        2000,0010, 1500,1501,1502,1503,1504,1505,1506,1507,0338,0338,0338,0338,0338,0338,0338,0338,
                        2040,0010, 1510,1511,1512,1513,1514,1515,1516,1517,1518,0338,0338,0338,0338,0338,0338,0338,
                        2080,0010, 1520,1521,1522,1523,1524,1525,1526,1527,1528,1529,0338,0338,0338,0338,0338,0338,
                        20C0,0010, 1530,1531,1532,1533,02FF,02FF,1536,1537,1538,1539,153A,0338,0338,0338,0338,0338,
                        2100,0010, 0338,0338,1542,1543,02FF,02FF,1546,1547,1548,1549,154A,154B,154C,154D,154E,1738,
                        2140,0010, 0338,0338,0338,1553,1554,1555,1556,1557,1558,1559,155A,155B,155C,155D,155E,155F,
                        2180,0010, 0338,0338,0338,0338,1564,1565,1566,1567,1568,1569,156A,156B,156C,156D,156E,156F,
                        21C0,0010, 0338,0338,0338,0338,0338,1575,1576,1577,1578,1579,157A,157B,157C,157D,157E,157F,
                        2200,0010, 0338,0338,0338,0338,0338,0338,1586,159E,159F,1589,158A,158B,158C,158D,158E,158F,
                        2240,0010, 0338,0338,0338,0338,0338,0338,1596,1597,1598,1599,159A,159B,159C,0338,0338,0338,
                        2280,0010, 0338,0338,0338,0338,0338,0338,15A6,15A7,15A8,15A9,15AA,15AB,15AC,0338,0338,0338,
                        22C0,0010, 0338,0338,0338,0338,0338,0338,0338,15B7,15B8,15B9,15BA,15BB,15BC,0338,0338,0338,
                        2300,0010, 8338,8338,8338,8338,8338,8338,8338,8338,8338,8338,8338,1508,1509,8338,8338,8338,
                        2340,0010, 8338,8338,8338,8338,8338,8338,8338,8338,8338,8338,8338,153B,1519,8338,8338,8338,
                        2380,0010, 8338,8338,8338,8338,8338,8338,8338,8338,8338,8338,8338,152A,152B,8338,8338,8338,
                        FFFF

$A5:B6C4             dx 0003, 01F8,F8,27BD, 01F8,F0,27AD, 81F8,00,27A9
$A5:B6D5             dx 0003, 01F8,F8,27BC, 01F8,F0,27AC, 81F8,00,27A7
$A5:B6E6             dx 0004, 01F4,F4,27BB, 01F4,EC,27AB, 01F4,FC,27A4, 81FC,FC,27A5
$A5:B6FC             dx 0002, 81F0,F8,27A0, 8000,F8,27A2
$A5:B708             dx 0003, 01F8,00,2797, 01F0,00,2796, 8000,F8,27AE
$A5:B719             dx 0003, 01F8,00,27D1, 01F0,00,27D0, 8000,F8,27C2
$A5:B72A             dx 0003, 01FC,04,2787, 01F4,04,2786, 81FC,F4,27C4
$A5:B73B             dx 0002, 81F8,00,2788, 81F8,F0,27C6
$A5:B747             dx 0003, 0000,00,E1BD, 0000,08,E1AD, 81F8,F0,21C8
$A5:B758             dx 0003, 0000,00,E7BC, 0000,08,E7AC, 81F8,F0,E7A7
$A5:B769             dx 0004, 0004,04,E7BB, 0004,0C,E7AB, 0004,FC,E7A4, 81F4,F4,E7A5
$A5:B77F             dx 0002, 8000,F8,E7A0, 81F0,F8,E7A2
$A5:B78B             dx 0003, 0000,F8,E797, 0008,F8,E796, 81F0,F8,E7AE
$A5:B79C             dx 0003, 0000,F8,E7D1, 0008,F8,E7D0, 81F0,F8,E7C2
$A5:B7AD             dx 0003, 01FC,F4,E787, 0004,F4,E786, 81F4,FC,E7C4
$A5:B7BE             dx 0002, 81F8,F0,E788, 81F8,00,E7C6
$A5:B7CA             dx 0001, 81F8,F8,2784
$A5:B7D1             dx 0001, 81F8,F8,2782
$A5:B7D8             dx 0001, 81F8,F8,2780
$A5:B7DF             dx 0001, 81F8,F8,6784
$A5:B7E6             dx 0001, 81F8,F8,6782
$A5:B7ED             dx 0001, 81F8,F8,6780
$A5:B7F4             dx 0004, 81E8,10,4721, 81E8,00,6701, 81F0,10,6720, 81F0,00,6700
$A5:B80A             dx 0004, 01F8,10,6723, 81F0,00,6703, 81E8,10,6724, 81E8,00,6704
$A5:B820             dx 0002, 81F0,10,6726, 81F0,00,6706
$A5:B82C             dx 0018, 800B,02,671C, 8013,0A,672B, 8003,FA,670D, 0004,EC,6750, 81F4,E4,6741, 81FC,F4,6760, 8003,0A,671C, 800B,12,672B, 81FB,02,670D, 01FC,F4,6750, 81EC,EC,6741, 81F4,FC,6760, 81FB,12,671C, 8003,1A,672B, 81F3,0A,670D, 01F4,FC,6750, 81E4,F4,6741, 81EC,04,6760, 81F4,1B,671C, 81FC,23,672B, 81EC,13,670D, 01ED,05,6750, 81DD,FD,6741, 81E5,0D,6760
$A5:B8A6             dx 0014, 81F8,F9,672E, 0010,09,674C, 8000,01,673D, 81F4,F4,6762, 81F4,E4,6743, 81F0,01,672E, 0008,11,674C, 81F8,09,673D, 81EC,FC,6762, 81EC,EC,6743, 81E8,09,672E, 0000,19,674C, 81F0,11,673D, 81E4,04,6762, 81E4,F4,6743, 81E1,12,672E, 01F9,22,674C, 81E9,1A,673D, 81DD,0D,6762, 81DD,FD,6743
$A5:B90C             dx 0010, 81F7,F9,6738, 81EF,F1,6729, 81EC,EC,6756, 81F4,E4,6745, 81F0,00,6738, 81E8,F8,6729, 81E5,F3,6756, 81ED,EB,6745, 81E9,07,6738, 81E1,FF,6729, 81DE,FA,6756, 81E6,F2,6745, 81E2,0E,6738, 81DA,06,6729, 81D7,01,6756, 81DF,F9,6745
$A5:B95E             dx 0010, 81F0,F4,6768, 81F0,EC,6758, 81EC,E4,6709, 81F4,E4,6708, 81E9,FC,6768, 81E9,F4,6758, 81E5,EC,6709, 81ED,EC,6708, 81E2,03,6768, 81E2,FB,6758, 81DE,F3,6709, 81E6,F3,6708, 81DB,0A,6768, 81DB,02,6758, 81D7,FA,6709, 81DF,FA,6708
$A5:B9B0             dx 0001, 81F8,F8,2764
$A5:B9B7             dx 0001, 81F8,F8,276A
$A5:B9BE             dx 0001, 81F8,F8,275E
$A5:B9C5             dx 0001, 81F8,F8,275C
$A5:B9CC             dx 0001, 81F8,F8,274A
$A5:B9D3             dx 000A, 81F4,F0,4721, 81F4,E0,4701, 81FC,F0,4720, 81FC,E0,4700, 0004,04,6723, 81FC,F4,6703, 81F4,04,6724, 81F4,F4,6704, 81FC,14,6726, 81FC,04,6706
$A5:BA07             dx 000A, 81F5,F0,4721, 81F5,E0,4701, 81FD,F0,4720, 81FD,E0,4700, 0005,04,6723, 81FD,F4,6703, 81F5,04,6724, 81F5,F4,6704, 81FD,14,6726, 81FD,04,6706
$A5:BA3B             dx 0001, 01FC,FC,277E
$A5:BA42             dx 0001, 01FC,FC,277D
$A5:BA49             dx 0001, 01FC,FC,277C
$A5:BA50             dx 0001, 81F8,F8,278A
$A5:BA57             dx 0001, 01FC,FC,277F
$A5:BA5E             dx 0001, 01FC,FC,2777
$A5:BA65             dx 0001, 01FC,FC,2776
$A5:BA6C             dx 0001, 81F8,F8,278C
$A5:BA73             dx 0001, 81F8,F8,278E
$A5:BA7A             dx 000A, 81F5,F0,4721, 81F5,E0,4701, 81FD,F0,4720, 81FD,E0,4700, 0006,04,6723, 81FE,F4,6703, 81F6,04,6724, 81F6,F4,6704, 81FE,14,6726, 81FE,04,6706
$A5:BAAE             dx 000A, 81F5,F0,4721, 81F5,E0,4701, 81FD,F0,4720, 81FD,E0,4700, 0006,04,6723, 81FE,F4,6703, 81F6,04,6724, 81F6,F4,6704, 81FF,14,6726, 81FF,04,6706
$A5:BAE2             dx 0013, 800B,02,671C, 8013,0A,672B, 8003,FA,670D, 0004,EC,6750, 81F4,E4,6741, 81FC,F4,6760, 81F0,01,672E, 0008,11,674C, 81F8,09,673D, 81EC,FC,6762, 81EC,EC,6743, 81E7,09,6738, 81DF,01,6729, 81DC,FC,6756, 81E4,F4,6745, 81D8,0C,6768, 81D8,04,6758, 81D4,FC,6709, 81DC,FC,6708
$A5:BB43             dx 0011, 81F8,F9,672E, 0010,09,674C, 8000,01,673D, 81F4,F4,6762, 81F4,E4,6743, 81EF,01,6738, 81E7,F9,6729, 81E4,F4,6756, 81EC,EC,6745, 81E0,04,6768, 81E0,FC,6758, 81DC,F4,6709, 81E4,F4,6708, 81DF,11,6738, 81D7,09,6729, 81D4,04,6756, 81DC,FC,6745
$A5:BB9A             dx 0011, 81F7,F9,6738, 81EF,F1,6729, 81EC,EC,6756, 81F4,E4,6745, 81E8,FC,6768, 81E8,F4,6758, 81E4,EC,6709, 81EC,EC,6708, 81E7,09,6738, 81DF,01,6729, 81DC,FC,6756, 81E4,F4,6745, 81E0,11,672E, 01F8,21,674C, 81E8,19,673D, 81DC,0C,6762, 81DC,FC,6743
$A5:BBF1             dx 0013, 81F0,F4,6768, 81F0,EC,6758, 81EC,E4,6709, 81F4,E4,6708, 81EF,01,6738, 81E7,F9,6729, 81E4,F4,6756, 81EC,EC,6745, 81E8,09,672E, 0000,19,674C, 81F0,11,673D, 81E4,04,6762, 81E4,F4,6743, 81F3,1A,671C, 81FB,22,672B, 81EB,12,670D, 01EC,04,6750, 81DC,FC,6741, 81E4,0C,6760
$A5:BC52             dx 0014, 81F7,F9,6738, 81EF,F1,6729, 81EC,EC,6756, 81F4,E4,6745, 81F0,01,672E, 0008,11,674C, 81F8,09,673D, 81EC,FC,6762, 81EC,EC,6743, 81FB,12,671C, 8003,1A,672B, 81F3,0A,670D, 01F4,FC,6750, 81E4,F4,6741, 81EC,04,6760, 81E0,11,672E, 01F8,21,674C, 81E8,19,673D, 81DC,0C,6762, 81DC,FC,6743
$A5:BCB8             dx 0014, 81F8,F9,672E, 0010,09,674C, 8000,01,673D, 81F4,F4,6762, 81F4,E4,6743, 8003,0A,671C, 800B,12,672B, 81FB,02,670D, 01FC,F4,6750, 81EC,EC,6741, 81F4,FC,6760, 81E8,09,672E, 0000,19,674C, 81F0,11,673D, 81E4,04,6762, 81E4,F4,6743, 81DF,11,6738, 81D7,09,6729, 81D4,04,6756, 81DC,FC,6745
$A5:BD1E             dx 0013, 8035,E5,671C, 803D,ED,672B, 802D,DD,670D, 002E,CF,6750, 801E,C7,6741, 8026,D7,6760, 81E2,05,6768, 81E2,FD,6758, 81DE,F5,6709, 81E6,F5,6708, 81F9,F0,6738, 81F1,E8,6729, 81EE,E3,6756, 81F6,DB,6745, 8018,ED,672E, 0030,FD,674C, 8020,F5,673D, 8014,E8,6762, 8014,D8,6743

$A5:BD7F             dx FFFE,
                        2316,0002, 159F,15A0,
                        2356,0002, 15AC,15AD,
                        2394,0003, 15B9,15BA,15BB,
                        23D4,0003, 15C8,15C9,15CA,
                        2414,0003, 15D7,15D8,15D9,
                        2454,0003, 15DF,15E0,1547,
                        2496,0002, 1547,1547,
                        FFFF

$A5:BDC3             dx FFFE,
                        2316,0002, 1559,155A,
                        2356,0002, 1569,156A,
                        2394,0003, 1576,1577,1578,
                        23D2,0004, 1585,1586,1587,1588,
                        2412,0004, 1592,1593,1594,1595,
                        2452,0004, 15A1,15A2,15A3,0147,
                        2496,0002, 0147,0147,
                        FFFF

$A5:BE0D             dx FFFE,
                        2316,0002, 1596,1597,
                        2356,0002, 15A4,15A5,
                        2390,0005, 15AE,15AF,15B0,15B1,15B2,
                        23CE,0006, 15BC,15BD,15BE,15BF,15C0,15C1,
                        240E,0006, 15CB,15CC,15CD,15CE,15CF,15D0,
                        2452,0003, 0147,0147,0147,
                        FFFF

$A5:BE59             dx FFFE,
                        230A,0003, 15DA,15DB,1547,
                        2316,0002, 15DC,15DD,
                        234C,0003, 15E1,15E2,15E3,
                        2354,0003, 15AE,15E4,15E5,
                        238C,0007, 15E9,15EA,15EB,15EC,15ED,15EE,15EF,
                        23CC,0007, 15F3,15F4,15F5,15F6,15F7,15F8,15F9,
                        240E,0005, 1600,1601,1602,1603,1604,
                        FFFF

$A5:BEB5             dx FFFE,
                        230A,0003, 0147,0147,0147,
                        2316,0002, 1596,1597,
                        234C,0003, 0147,0147,0147,
                        2354,0003, 0147,15A4,15A5,
                        238C,0007, 0147,0147,15AE,15AF,15B0,15B1,15B2,
                        23CC,0007, 0147,15BC,15BD,15BE,15BF,15C0,15C1,
                        240E,0005, 15CB,15CC,15CD,15CE,15CF,
                        FFFF

$A5:BF11             dx FFFE,
                        2316,0002, 1559,155A,
                        2356,0002, 1569,156A,
                        2390,0005, 0147,0147,1576,1577,1578,
                        23CE,0006, 0147,0147,1585,1586,1587,1588,
                        240E,0006, 0147,0147,1592,1593,1594,1595,
                        2452,0003, 15A1,15A2,15A3,
                        FFFF

$A5:BF5D             dx FFFE,
                        2316,0002, 159F,15A0,
                        2356,0002, 15AC,15AD,
                        2394,0003, 15B9,15BA,15BB,
                        23D2,0004, 0147,15C8,15C9,15CA,
                        2412,0004, 0147,15D7,15D8,15D9,
                        2452,0004, 0147,15DF,15E0,1547,
                        2496,0002, 1547,1547,
                        FFFF

$A5:BFA7             dx FFFE,
                        2154,0002, 5555,5554,
                        2194,0002, 5565,5564,
                        FFFF

$A5:BFBB             dx FFFE,
                        2154,0002, 5581,5580,
                        2194,0002, 5591,5590,
                        FFFF

$A5:BFCF             dx FFFE,
                        2154,0002, 5583,5582,
                        2194,0002, 5593,5592,
                        FFFF

$A5:BFE3             dx FFFE,
                        2154,0002, 5563,5562,
                        2194,0002, 5573,5572,
                        FFFF

$A5:BFF7             dx FFFE,
                        220E,0003, 559F,559E,5586,
                        224E,0003, 5598,5597,5596,
                        228E,0003, 55A8,55A7,55A6,
                        FFFF

$A5:C019             dx FFFE,
                        2212,0001, 559D,
                        224E,0003, 55AF,55AE,55AD,
                        228E,0003, 55BF,55BE,55BD,
                        FFFF

$A5:C037             dx FFFE,
                        220E,0003, 55A2,55A1,55A0,
                        224E,0003, 55B2,55B1,55B0,
                        228E,0003, 55B6,55B5,55B4,
                        FFFF

$A5:C059             dx FFFE,
                        220E,0003, 5585,5584,55A3,
                        224E,0003, 5595,5594,55B3,
                        228E,0003, 55A5,55A4,5574,
                        FFFF

$A5:C07B             dx FFFE,
                        20D4,0002, 5541,5540,
                        2114,0002, 5551,5550,
                        FFFF

$A5:C08F             dx FFFE,
                        20D4,0002, 5561,5560,
                        2114,0002, 5571,5570,
                        FFFF

$A5:C0A3             dx FFFE,
                        20D4,0002, 550B,550A,
                        2114,0002, 551B,551A,
                        FFFF

$A5:C0B7             dx FFFE,
                        20D4,0002, 550D,550C,
                        2114,0002, 551D,551C,
                        FFFF

$A5:C0CB             dx FFFE,
                        20D4,0002, 5535,5534,
                        2114,0002, 5545,5544,
                        FFFF

$A5:C0DF             dx FFFE,
                        20D4,0002, 550F,550E,
                        2114,0002, 551F,551E,
                        FFFF

$A5:C0F3             dx FFFE,
                        20D4,0002, 552D,552C,
                        2114,0002, 553D,553C,
                        FFFF

$A5:C107             dx FFFE,
                        20D4,0002, 552F,552E,
                        2114,0002, 553F,553E,
                        FFFF

$A5:C11B             dx FFFE,
                        2000,0010, 4338,4338,4338,4338,4338,4338,4338,4338,5507,5506,5505,5504,5503,5502,5501,5500,
                        2040,0010, 4338,4338,4338,4338,4338,4338,4338,5518,5517,5516,5515,5514,5513,5512,5511,5510,
                        2080,0010, 4338,4338,4338,4338,4338,4338,5529,5528,5527,5526,5525,5524,5523,5522,5521,5520,
                        20C0,0010, 4338,4338,4338,4338,4338,553A,5539,5538,5537,5536,02FF,02FF,5533,5532,5531,5530,
                        2100,0010, 5738,554E,554D,554C,554B,554A,5549,5548,5547,5546,02FF,02FF,5543,5542,4338,4338,
                        2140,0010, 555F,555E,555D,555C,555B,555A,5559,5558,5557,5556,5555,5554,5553,4338,4338,4338,
                        2180,0010, 556F,556E,556D,556C,556B,556A,5569,5568,5567,5566,5565,5564,4338,4338,4338,4338,
                        21C0,0010, 557F,557E,557D,557C,557B,557A,5579,5578,5577,5576,5575,4338,4338,4338,4338,4338,
                        2200,0010, 558F,558E,558D,558C,558B,558A,5589,559F,559E,5586,4338,4338,4338,4338,4338,4338,
                        2240,0010, 4338,4338,4338,559C,559B,559A,5599,5598,5597,5596,4338,4338,4338,4338,4338,4338,
                        2280,0010, 4338,4338,4338,55AC,55AB,55AA,55A9,55A8,55A7,55A6,4338,4338,4338,4338,4338,4338,
                        22C0,0010, 4338,4338,4338,55BC,55BB,55BA,55B9,55B8,55B7,4338,4338,4338,4338,4338,4338,4338,
                        2300,0010, C338,C338,C338,5509,5508,C338,C338,C338,C338,C338,C338,C338,C338,C338,C338,C338,
                        2340,0010, C338,C338,C338,5519,553B,C338,C338,C338,C338,C338,C338,C338,C338,C338,C338,C338,
                        2380,0010, C338,C338,C338,552B,552A,C338,C338,C338,C338,C338,C338,C338,C338,C338,C338,C338,
                        FFFF

$A5:C33B             dx 0003, 0000,F8,67BD, 0000,F0,67AD, 81F8,00,67A9
$A5:C34C             dx 0003, 0000,F8,67BC, 0000,F0,67AC, 81F8,00,67A7
$A5:C35D             dx 0004, 0004,F4,67BB, 0004,EC,67AB, 0004,FC,67A4, 81F4,FC,67A5
$A5:C373             dx 0002, 8000,F8,67A0, 81F0,F8,67A2
$A5:C37F             dx 0003, 0000,00,6797, 0008,00,6796, 81F0,F8,67AE
$A5:C390             dx 0003, 0000,00,67D1, 0008,00,67D0, 81F0,F8,67C2
$A5:C3A1             dx 0003, 01FC,04,6787, 0004,04,6786, 81F4,F4,67C4
$A5:C3B2             dx 0002, 81F8,00,6788, 81F8,F0,67C6
$A5:C3BE             dx 0003, 0000,00,E1BD, 0000,08,E1AD, 81F8,F0,21C8
$A5:C3CF             dx 0003, 01F8,00,A7BC, 01F8,08,A7AC, 81F8,F0,A7A7
$A5:C3E0             dx 0004, 01F4,04,A7BB, 01F4,0C,A7AB, 01F4,FC,A7A4, 81FC,F4,A7A5
$A5:C3F6             dx 0002, 81F0,F8,A7A0, 8000,F8,A7A2
$A5:C402             dx 0003, 01F8,F8,A797, 01F0,F8,A796, 8000,F8,A7AE
$A5:C413             dx 0003, 01F8,F8,A7D1, 01F0,F8,A7D0, 8000,F8,A7C2
$A5:C424             dx 0003, 01FC,F4,A787, 01F4,F4,A786, 81FC,FC,A7C4
$A5:C435             dx 0002, 81F8,F0,A788, 81F8,00,A7C6
$A5:C441             dx 0001, 81F8,F8,6784
$A5:C448             dx 0001, 81F8,F8,6782
$A5:C44F             dx 0001, 81F8,F8,6780
$A5:C456             dx 0001, 81F8,F8,2784
$A5:C45D             dx 0001, 81F8,F8,2782
$A5:C464             dx 0001, 81F8,F8,2780
}


;;; $C46B: Initialisation AI - enemy $DE7F (Draygon eye) ;;;
{
$A5:C46B AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:C46E A9 44 99    LDA #$9944             ;\
$A5:C471 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $9944
$A5:C474 A9 4B 80    LDA #$804B             ;\
$A5:C477 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;} Enemy function = RTS
$A5:C47A 6B          RTL
}


;;; $C47B: Instruction ;;;
{
$A5:C47B 5A          PHY
$A5:C47C B9 00 00    LDA $0000,y[$A5:988D]
$A5:C47F 8D E8 0F    STA $0FE8  [$7E:0FE8]
$A5:C482 7A          PLY
$A5:C483 C8          INY
$A5:C484 C8          INY
$A5:C485 6B          RTL
}


;;; $C486: Main AI - enemy $DE7F (Draygon eye) ;;;
{
$A5:C486 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:C489 FC A8 0F    JSR ($0FA8,x)[$A5:C48D]; Execute [enemy function]
$A5:C48C 6B          RTL
}


;;; $C48D: Draygon eye function - facing left ;;;
{
$A5:C48D BD A4 0F    LDA $0FA4,x[$7E:0FE4]  ;\
$A5:C490 29 7F 00    AND #$007F             ;} If [Draygon body frame counter] % 80h = 0:
$A5:C493 D0 1C       BNE $1C    [$C4B1]     ;/
$A5:C495 AD BA 0F    LDA $0FBA  [$7E:0FBA]  ;\
$A5:C498 38          SEC                    ;|
$A5:C499 E9 18 00    SBC #$0018             ;} $12 = [Draygon X position] - 18h
$A5:C49C 85 12       STA $12    [$7E:0012]  ;/
$A5:C49E AD BE 0F    LDA $0FBE  [$7E:0FBE]  ;\
$A5:C4A1 38          SEC                    ;|
$A5:C4A2 E9 20 00    SBC #$0020             ;} $14 = [Draygon Y position] - 20h
$A5:C4A5 85 14       STA $14    [$7E:0014]  ;/
$A5:C4A7 A9 18 00    LDA #$0018             ;\
$A5:C4AA A0 09 E5    LDY #$E509             ;} Spawn long breath bubbles enemy projectile
$A5:C4AD 22 97 80 86 JSL $868097[$86:8097]  ;/

$A5:C4B1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:C4B4 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:C4B7 38          SEC                    ;|
$A5:C4B8 E9 18 00    SBC #$0018             ;|
$A5:C4BB 85 12       STA $12    [$7E:0012]  ;|
$A5:C4BD AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A5:C4C0 38          SEC                    ;|
$A5:C4C1 E5 12       SBC $12    [$7E:0012]  ;|
$A5:C4C3 85 12       STA $12    [$7E:0012]  ;|
$A5:C4C5 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;} A = angle from ([$12], [$14]) to Samus position
$A5:C4C8 38          SEC                    ;|
$A5:C4C9 E9 20 00    SBC #$0020             ;|
$A5:C4CC 85 14       STA $14    [$7E:0014]  ;|
$A5:C4CE AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A5:C4D1 38          SEC                    ;|
$A5:C4D2 E5 14       SBC $14    [$7E:0014]  ;|
$A5:C4D4 85 14       STA $14    [$7E:0014]  ;|
$A5:C4D6 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A5:C4DA DD B2 0F    CMP $0FB2,x[$7E:0FF2]  ;\
$A5:C4DD F0 33       BEQ $33    [$C512]     ;} If [A] = [Draygon eye angle to Samus]: return
$A5:C4DF A0 BA 99    LDY #$99BA             ; Y = $99BA (looking up)
$A5:C4E2 C9 20 00    CMP #$0020             ;\
$A5:C4E5 30 1B       BMI $1B    [$C502]     ;} If [A] >= 20h:
$A5:C4E7 A0 B4 99    LDY #$99B4             ; Y = $99B4 (looking right)
$A5:C4EA C9 60 00    CMP #$0060             ;\
$A5:C4ED 30 13       BMI $13    [$C502]     ;} If [A] >= 60h:
$A5:C4EF A0 C0 99    LDY #$99C0             ; Y = $99C0 (looking down)
$A5:C4F2 C9 A0 00    CMP #$00A0             ;\
$A5:C4F5 30 0B       BMI $0B    [$C502]     ;} If [A] >= A0h:
$A5:C4F7 A0 AE 99    LDY #$99AE             ; Y = $99AE (looking left)
$A5:C4FA C9 E0 00    CMP #$00E0             ;\
$A5:C4FD 30 03       BMI $03    [$C502]     ;} If [A] >= E0h:
$A5:C4FF A0 BA 99    LDY #$99BA             ; Y = $99BA (looking up)

$A5:C502 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ; Draygon eye angle to Samus = [A]
$A5:C505 98          TYA                    ;\
$A5:C506 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = [Y]
$A5:C509 A9 01 00    LDA #$0001             ;\
$A5:C50C 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A5:C50F 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0

$A5:C512 60          RTS
}


;;; $C513: Draygon eye function - facing right ;;;
{
$A5:C513 BD A4 0F    LDA $0FA4,x[$7E:0FE4]  ;\
$A5:C516 29 7F 00    AND #$007F             ;} If [Draygon body frame counter] % 80h = 0:
$A5:C519 D0 1C       BNE $1C    [$C537]     ;/
$A5:C51B AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:C51E 18          CLC                    ;|
$A5:C51F 69 18 00    ADC #$0018             ;} $12 = [Draygon X position] + 18h
$A5:C522 85 12       STA $12    [$7E:0012]  ;/
$A5:C524 AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:C527 38          SEC                    ;|
$A5:C528 E9 20 00    SBC #$0020             ;} $14 = [Draygon Y position] - 20h
$A5:C52B 85 14       STA $14    [$7E:0014]  ;/
$A5:C52D A9 18 00    LDA #$0018             ;\
$A5:C530 A0 09 E5    LDY #$E509             ;} Spawn long breath bubbles enemy projectile
$A5:C533 22 97 80 86 JSL $868097[$86:8097]  ;/

$A5:C537 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:C53A AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:C53D 18          CLC                    ;|
$A5:C53E 69 18 00    ADC #$0018             ;|
$A5:C541 85 12       STA $12    [$7E:0012]  ;|
$A5:C543 AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;|
$A5:C546 38          SEC                    ;|
$A5:C547 E5 12       SBC $12    [$7E:0012]  ;|
$A5:C549 85 12       STA $12    [$7E:0012]  ;|
$A5:C54B AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;} A = angle from ([$12], [$14]) to Samus position
$A5:C54E 38          SEC                    ;|
$A5:C54F E9 20 00    SBC #$0020             ;|
$A5:C552 85 14       STA $14    [$7E:0014]  ;|
$A5:C554 AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;|
$A5:C557 38          SEC                    ;|
$A5:C558 E5 14       SBC $14    [$7E:0014]  ;|
$A5:C55A 85 14       STA $14    [$7E:0014]  ;|
$A5:C55C 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]  ;/
$A5:C560 DD B2 0F    CMP $0FB2,x[$7E:0FF2]  ;\
$A5:C563 F0 33       BEQ $33    [$C598]     ;} If [A] = [Draygon eye angle to Samus]: return
$A5:C565 A0 5C 9D    LDY #$9D5C             ; Y = $9D5C (looking up)
$A5:C568 C9 20 00    CMP #$0020             ;\
$A5:C56B 30 1B       BMI $1B    [$C588]     ;} If [A] >= 20h:
$A5:C56D A0 50 9D    LDY #$9D50             ; Y = $9D50 (looking right)
$A5:C570 C9 60 00    CMP #$0060             ;\
$A5:C573 30 13       BMI $13    [$C588]     ;} If [A] >= 60h:
$A5:C575 A0 62 9D    LDY #$9D62             ; Y = $9D62 (looking down)
$A5:C578 C9 A0 00    CMP #$00A0             ;\
$A5:C57B 30 0B       BMI $0B    [$C588]     ;} If [A] >= A0h:
$A5:C57D A0 56 9D    LDY #$9D56             ; Y = $9D56 (looking left)
$A5:C580 C9 E0 00    CMP #$00E0             ;\
$A5:C583 30 03       BMI $03    [$C588]     ;} If [A] >= E0h:
$A5:C585 A0 5C 9D    LDY #$9D5C             ; Y = $9D5C (looking up)

$A5:C588 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ; Draygon eye angle to Samus = [A]
$A5:C58B 98          TYA                    ;\
$A5:C58C 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = [Y]
$A5:C58F A9 01 00    LDA #$0001             ;\
$A5:C592 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A5:C595 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0

$A5:C598 60          RTS
}


;;; $C599: Initialisation AI - enemy $DEBF (Draygon tail) ;;;
{
$A5:C599 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:C59C A9 FC 99    LDA #$99FC             ;\
$A5:C59F 9D 92 0F    STA $0F92,x[$7E:1012]  ;} Enemy instruction list pointer = $99FC
$A5:C5A2 A9 00 07    LDA #$0700             ;\
$A5:C5A5 0A          ASL A                  ;} Enemy palette index = E00h (palette 7)
$A5:C5A6 9D 96 0F    STA $0F96,x[$7E:1016]  ;/
$A5:C5A9 6B          RTL
}


;;; $C5AA: RTL. Main AI - enemy $DEBF (Draygon tail) ;;;
{
$A5:C5AA 6B          RTL
}


;;; $C5AB: RTL ;;;
{
$A5:C5AB 6B          RTL
}


;;; $C5AC: RTL ;;;
{
$A5:C5AC 6B          RTL
}


;;; $C5AD: Initialisation AI - enemy $DEFF (Draygon arms) ;;;
{
$A5:C5AD AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:C5B0 A9 E7 97    LDA #$97E7             ;\
$A5:C5B3 9D 92 0F    STA $0F92,x[$7E:1052]  ;} Enemy instruction list pointer = $97E7
$A5:C5B6 A9 00 07    LDA #$0700             ;\
$A5:C5B9 0A          ASL A                  ;} Enemy palette index = E00h (palette 7)
$A5:C5BA 9D 96 0F    STA $0F96,x[$7E:1056]  ;/
$A5:C5BD A9 02 00    LDA #$0002             ;\
$A5:C5C0 9D 9A 0F    STA $0F9A,x[$7E:105A]  ;} Enemy layer = 2
$A5:C5C3 6B          RTL
}


;;; $C5C4: RTL. Main AI - enemy $DEFF (Draygon arms) ;;;
{
$A5:C5C4 6B          RTL
}


;;; $C5C5: RTL ;;;
{
$A5:C5C5 6B          RTL
}


;;; $C5C6: RTL ;;;
{
$A5:C5C6 6B          RTL
}


;;; $C5C7: Unused Draygon fight intro dance data ;;;
{
$A5:C5C7             db 01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00,
                        01,FF, 01,00, 00,FF, 01,00, 01,FF, 00,FF, 01,00, 01,FF,
                        01,FF, 01,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF,
                        01,00, 00,FF, 01,FF, 00,FF, 00,FF, 01,00, 00,FF, 00,FF,
                        00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FE,
                        00,FF, 00,FF, 00,FF, 00,FF, 00,FE, FF,FF, 00,FF, 00,FF,
                        00,FE, FF,FF, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, FF,FF,
                        00,FF, FF,FF, 00,FF, 00,FF, FF,00, 00,FF, FF,00, 00,FF,
                        FF,00, FF,00, FF,01, 00,01, FF,00, 00,01, FF,01, 00,01,
                        00,01, 00,01, FF,01, 00,01, 00,01, 00,01, FF,01, 00,01,
                        00,01, 00,02, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 01,00, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,02, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,02, 00,01, 00,01, 00,01, 00,02, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,FF, 01,FF, 00,FF,
                        00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF,
                        00,FE, 00,FF, 00,FF, 01,FF, 00,FE, 00,FF, 00,FF, 00,FF,
                        00,FE, 01,FF, 00,FF, 00,FF, 00,FF, 00,FE, 01,FF, 00,FF,
                        00,FF, 00,FF, 01,FF, 00,FF, 01,FF, 00,FF, 01,FF, 01,FF,
                        01,00, 00,FF, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00,
                        01,01, 01,00, 01,01, 01,00, 01,01, 01,01, 00,01, 01,01,
                        00,01, 01,00, 00,01, 00,01, 00,01, 01,02, 00,01, 00,01,
                        FF,01, 00,01, 00,01, 00,01, FF,01, 00,01, FF,01, 00,01,
                        FF,01, FF,01, FF,01, FF,00, FF,01, FF,00, FF,00, FF,00,
                        FF,00, FF,00, FF,FF, FF,00, FF,FF, FF,00, FF,FF, 00,01,
                        01,01, 01,01, 01,01, 00,01, 01,01, 01,01, 01,01, 01,00,
                        01,01, 01,01, 01,01, 02,01, 01,00, 00,01, 01,00, 01,01,
                        01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 02,00,
                        01,00, 02,FF, 01,00, 02,00, 01,00, 02,FF, 01,00, 02,00,
                        01,FF, 02,00, 01,00, 01,FF, 02,00, 01,FF, 01,00, 01,FF,
                        02,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,00, 00,FF, 01,FF,
                        01,FF, 01,FE, 00,FF, 01,FF, 01,FF, 00,FF, 00,FE, 01,FF,
                        00,FE, 00,FF, 01,FF, 00,FE, 00,FF, 00,FE, 00,FE, 00,FF,
                        00,FE, 00,FF, 00,FE, FF,FE, 00,FF, 00,FE, FF,FE, 00,FF,
                        00,FE, FF,FE, FF,FE, 00,FF, FF,FE, FF,FE, 00,FE, FF,FF,
                        FF,FE, FF,FF, FF,FE, FF,FF, 00,FF, FF,FE, FF,FF, FF,FF,
                        FF,FF, FF,00, FF,FF, FF,00, FF,FF, FF,00, FF,00, FF,00,
                        FF,01, FF,00, FF,01, FF,01, FF,01, FF,02, FF,01, 00,01,
                        FF,02, FF,01, 00,02, FF,01, FF,02, 00,02, FF,01, 00,02,
                        00,02, FF,02, 00,01, 00,02, FF,02, 00,02, 00,01, 00,02,
                        00,01, 00,02, 00,02, 00,01, 00,02, 00,01, 01,02, 00,01,
                        00,01, 01,02, 00,01, 01,02, 00,01, 01,01, 00,01, 01,02,
                        01,01, 00,01, 01,01, 01,01, 01,01, 01,01, 01,01, 01,01,
                        01,01, 01,01, 02,00, 01,01, 01,01, 01,01, 02,00, 01,01,
                        01,00, 02,01, 01,00, 01,01, 02,00, 01,00, 02,01, 01,00,
                        02,00, 01,00, 01,00, 02,00, 01,00, 02,00, 01,00, 02,00,
                        01,00, 01,00, 02,00, 01,FF, 01,00, 02,00, 01,00, 01,FF,
                        01,00, 01,FF, 01,00, 01,FF, 01,00, 01,FF, 01,FF, 01,FF,
                        00,FF, 01,FF, 00,FF, 00,FF, 01,FE, 00,FF, 00,FF, 00,FF,
                        00,FE, 00,FF, 00,FE, 00,FF, 00,FE, 00,FF, 00,FE, 00,FF,
                        00,FE, 00,FE, 00,FF, 00,FE, 00,FE, 00,FE, 00,FF, 00,FE,
                        00,FE, 00,FF, 00,FE, 00,FE, 00,FF, 00,FE, 00,FE, 00,FF,
                        00,FE, 00,FF, 00,FF, 00,FE, 00,FF, 00,FF, 00,FF, 01,FF,
                        00,FF, 00,FF, 00,FF, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 01,02, 00,01, 00,02, 00,01, 00,02,
                        00,01, 00,02, FF,01, 00,02, 00,02, 00,02, 00,01, 00,02,
                        00,02, 00,01, 00,02, 00,02, 00,02, 00,01, 00,02, 00,01,
                        00,02, FF,01, 00,02, 00,01, 00,02, 00,01, 01,01, 00,01,
                        00,02, 00,01, 00,01, 01,01, 00,01, 00,01, 01,01, 01,01,
                        01,01, 01,01, 01,00, 01,01, 01,00, 01,01, 01,00, 02,00,
                        01,01, 01,00, 02,00, 01,01, 01,FF, 01,00, 00,FF, 01,00,
                        01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,00,
                        01,FF, 00,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,FF, 00,FF,
                        01,00, 00,FF, 01,FF, 00,FF, 01,00, 00,FF, 01,FF, 00,FF,
                        00,FF, 01,00, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF,
                        00,FF, 00,FF, 00,FF, 00,FE, 00,FF, 00,FF, 00,FF, 00,FF,
                        00,FE, FF,FF, 00,FF, 00,FF, 00,FE, FF,FF, 00,FF, 00,FF,
                        FF,FF, 00,FF, 00,FF, FF,FF, 00,FF, FF,FF, 00,FF, 00,FF,
                        FF,00, 00,FF, FF,00, 00,FF, FF,00, FF,00, FF,01, 00,01,
                        FF,00, 00,01, FF,01, 00,01, 00,01, 00,01, FF,01, 00,01,
                        00,01, 00,01, FF,01, 00,01, 00,01, 00,02, 00,01, 00,01,
                        FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 01,00, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,02, 00,01, 00,01, 00,01, 00,01, 00,01, 00,02, 00,01,
                        00,01, 00,01, 00,02, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF,
                        00,FF, 01,FF, 00,FF, 00,FF, 00,FE, 00,FF, 00,FF, 01,FF,
                        00,FE, 00,FF, 00,FF, 00,FF, 00,FE, 01,FF, 00,FF, 00,FF,
                        00,FF, 00,FE, 01,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF,
                        01,FF, 00,FF, 01,FF, 01,FF, 01,00, 00,FF, 01,00, 01,00,
                        01,00, 01,FF, 01,00, 01,00, 01,01, 01,00, 01,01, 01,00,
                        01,01, 01,01, 00,01, 01,01, 00,01, 01,00, 00,01, 00,01,
                        00,01, 01,02, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01,
                        FF,01, 00,01, FF,01, 00,01, FF,01, FF,01, FF,01, FF,00,
                        FF,01, FF,00, FF,00, FF,00, FF,00, FF,00, FF,FF, FF,00,
                        FF,FF, FF,00, FF,FF, 00,01, 01,01, 01,01, 01,01, 00,01,
                        01,01, 01,01, 01,01, 01,00, 01,01, 01,01, 01,01, 02,01,
                        01,00, 00,01, 01,00, 01,01, 01,00, 01,00, 01,01, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,FF, 01,FF, 00,FF, 01,00, 01,FF,
                        00,FF, 01,00, 01,FF, 00,FF, 01,00, 00,FF, 01,FF, 01,FF,
                        01,FF, 01,FF, 00,FF, 01,FF, 00,FF, 01,FF, 01,FF, 00,FF,
                        01,FF, 01,FF, 00,FF, 01,FF, 00,FF, 01,FF, 01,FF, 00,FF,
                        01,FE, 01,FF, 00,FF, 01,FE, 00,FF, 01,FF, 00,FF, 01,FE,
                        01,FF, 00,FF, 00,FE, 01,FF, 00,FF, 01,FF, 00,FF, 00,FE,
                        00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF,
                        00,FF, FF,00, 00,FF, FF,FF, FF,00, FF,00, FF,00, FF,00,
                        FF,00, 00,01, FF,00, FF,01, FF,00, FF,01, FF,00, FF,01,
                        FF,01, FF,00, FF,01, FF,01, FF,01, FF,01, FF,01, FF,01,
                        FF,01, 00,01, FF,01, 00,01, FF,01, 00,01, 00,01, FF,01,
                        00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 01,01,
                        00,01, 00,01, 01,01, 00,01, 00,01, 01,01, 00,01, 00,01,
                        01,01, 00,01, 01,01, 01,01, 00,01, 01,01, 00,01, 01,01,
                        01,01, 01,01, 01,00, 01,01, 01,00, 01,00, 01,00, 01,FF,
                        01,00, 01,FF, 01,00, 01,FF, 00,FF, 01,00, 01,FF, 01,FF,
                        01,FF, 00,FF, 01,FF, 01,FF, 00,FF, 01,FF, 01,FE, 00,FF,
                        01,FF, 00,FF, 01,FF, 00,FF, 01,FF, 01,FF, 00,FF, 00,FF,
                        01,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF,
                        01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF,
                        00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF,
                        00,FF, 00,FE, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF, FF,FF,
                        FF,FF, 00,FF, FF,FF, FF,FF, FF,FF, 00,FF, FF,00, FF,FF,
                        FF,00, FF,FF, FF,00, FF,00, FF,00, FF,00, FF,00, FF,01,
                        FF,00, FF,01, FF,01, FF,01, FF,00, FF,01, 00,01, FF,02,
                        00,01, 00,01, 00,01, 00,01, 01,01, 01,01, 01,00, 01,01,
                        01,00, 01,00, 02,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,FF, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,FF, 01,00,
                        01,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,00, 01,FF, 01,00,
                        01,FF, 01,FF, 01,00, 01,FF, 01,00, 01,FF, 01,00, 01,FF,
                        01,00, 00,FF, 01,00, 01,FF, 01,00, 01,FF, 01,00, 01,FF,
                        01,00, 01,FF, 01,FF, 01,00, 01,FF, 01,00, 01,FF, 01,00
}


;;; $CE07: Draygon fight intro dance data ;;;
{
; The Keiko love dance
; The table index is incremented by 4 per movement instead of 2, so only entries 2k for some k are used
$A5:CE07             db 03,00, 03,00, 03,00, 02,FF, 03,00, 03,FF, 03,00, 02,FF,
                        03,FF, 02,FE, 02,FF, 02,FE, 02,FE, 02,FD, 02,FE, 01,FD,
                        02,FD, 01,FE, 01,FD, 02,FE, 01,FE, 00,FE, 01,FE, 01,FF,
                        01,00, 00,FF, 01,00, 01,01, 00,01, 00,01, 00,02, 00,02,
                        00,02, 00,02, 00,02, 00,03, FF,03, 00,03, 00,03, FF,04,
                        00,03, FF,04, 00,04, FF,04, 00,04, FF,04, FF,04, 00,05,
                        FF,04, FF,04, 00,05, FF,04, FF,04, FF,05, FF,04, 00,04,
                        FF,05, FF,04, FF,04, FF,04, FF,04, 00,04, FF,03, FF,04,
                        FF,03, 00,03, FF,03, FF,03, FF,03, 00,02, FF,02, FF,02,
                        00,01, FF,02, 00,01, FF,01, FF,00, 00,FF, 00,FF, 00,FF,
                        00,FF, 00,FE, 00,FF, 00,FD, 00,FE, 00,FE, 00,FD, 00,FD,
                        01,FD, 00,FD, 00,FD, 01,FD, 00,FC, 01,FD, 01,FC, 00,FD,
                        01,FC, 01,FD, 00,FC, 01,FC, 01,FD, 01,FC, 01,FD, 01,FC,
                        01,FD, 01,FD, 02,FD, 01,FD, 01,FD, 02,FD, 01,FD, 01,FE,
                        02,FE, 02,FE, 01,FD, 02,FF, 02,FE, 02,FE, 01,FE, 02,FF,
                        02,FE, 03,FE, 02,FF, 02,FE, 03,FE, 02,FF, 03,FE, 02,FF,
                        03,FE, 03,FE, 03,FE, 03,FE, 03,FE, 02,FF, 03,FE, 03,FE,
                        03,FF, 03,FE, 02,FF, 03,FF, 02,FF, 03,FF, 02,00, 01,FF,
                        02,00, 01,01, 02,00, 00,01, 01,01, 00,02, 00,02, 00,02,
                        00,02, FF,02, 00,03, FF,02, FF,03, FE,03, FF,03, FF,03,
                        FE,03, FE,03, FE,03, FE,04, FE,03, FE,03, FE,03, FE,02,
                        FE,03, FD,03, FE,02, FE,03, FD,02, FE,02, FE,01, FD,02,
                        FE,01, FD,02, FE,01, FD,01, FD,01, FE,00, FD,01, FD,00,
                        FE,00, FD,00, FD,FF, FD,00, FD,FF, FD,FF, FD,FF, FD,FE,
                        FD,FF, FD,FE, FE,FE, FE,FE, FF,FE, 00,FF, 01,FE, 01,FE,
                        02,FE, 02,FF, 03,FE, 03,FF, 04,FF, 03,FF, 03,00, 03,00,
                        03,00, 03,01, 03,00, 02,01, 02,02, 03,01, 02,02, 02,02,
                        02,02, 01,02, 02,02, 02,03, 01,03, 02,02, 01,03, 02,03,
                        01,03, 01,03, 02,03, 01,03, 01,02, 01,03, 01,03, 02,03,
                        01,03, 01,02, 01,03, 02,03, 01,02, 01,03, 02,02, 01,02,
                        02,02, 01,02, 02,02, 02,02, 02,02, 02,02, 02,01, 02,02,
                        02,01, 02,01, 03,01, 02,01, 03,01, 02,01, 03,00, 03,01,
                        03,01, 01,FF, 02,00, 01,FF, 02,00, 01,FF, 02,00, 01,FF,
                        01,00, 02,FF, 01,FF, 02,00, 01,FF, 02,00, 01,FF, 01,FF,
                        02,00, 01,FF, 01,FF, 02,FF, 01,FF, 01,00, 02,FF, 01,FF,
                        01,FF, 01,FF, 02,FF, 01,FF, 01,FF, 01,FF, 01,FF, 02,FF,
                        01,FF, 01,FE, 01,FF, 01,FF, 01,FF, 01,FE, 01,FF, 01,FF,
                        01,FE, 00,FF, 01,FE, 01,FF, 01,FE, 00,FF, 01,FE, 01,FF,
                        00,FE, 01,FF, 00,FE, 00,FF, 01,FE, 00,FE, 00,FF, 00,FE,
                        00,FF, 00,FE, 00,FE, 00,FF, 00,FE, 00,FF, FF,FE, 00,FE,
                        00,FF, FF,FE, FF,FE, 00,FF, FF,FE, FF,FF, FF,FE, FF,FF,
                        FF,FF, FF,FF, FF,FF, FF,FF, FE,FF, FF,00, FF,00, FE,00,
                        FF,00, FF,00, FE,01, FF,00, FE,01, FF,01, FE,01, FF,01,
                        FF,01, FE,01, FF,01, FF,02, FF,01, FF,01, FF,02, FF,01,
                        FF,01, 00,02, FF,01, FF,02, 00,01, FF,01, 00,02, 00,01,
                        FF,02, 00,01, 00,02, 00,01, 00,02, FF,01, 00,02, 00,02,
                        00,01, 00,02, 00,01, 00,02, 00,02, 00,01, 00,02, 00,02,
                        00,01, 00,02, 00,02, 00,01, 00,02, 00,02, 01,01, 00,02,
                        00,01, 01,02, 00,01, 01,01, 00,02, 01,01, 01,01, 00,01,
                        01,01, 01,02, 02,00, 01,01, 01,01, 01,01, 02,01, 01,00,
                        02,01, 01,00, 02,01, 01,00, 02,01, 01,00, 02,00, 02,01,
                        01,00, 02,00, 01,00, 02,00, 02,00, 01,00, 02,00, 01,00,
                        02,00, 01,00, 02,00, 01,00, 02,00, 01,00, 01,00, 02,FF,
                        01,00, 02,00, 01,FF, 01,00, 02,FF, 01,00, 01,00, 02,FF,
                        01,00, 01,FF, 01,FF, 01,00, 02,FF, 01,00, 01,FF, 01,FF,
                        01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,FF, 01,FF,
                        01,FE, 00,FF, 01,FF, 00,FF, 01,FE, 01,FF, 00,FE, 01,FF,
                        00,FE, 01,FF, 00,FE, 01,FE, 00,FF, 01,FE, 00,FE, 01,FE,
                        01,FE, 00,FE, 01,FE, 00,FF, 01,FE, 00,FE, 01,FE, 00,FE,
                        01,FE, 00,FE, 01,FE, 00,FE, 01,FE, 00,FE, 00,FE, 01,FF,
                        00,FE, 01,FE, 00,FF, 01,FE, 00,FF, 00,FE, 01,FF, 00,FF,
                        00,FE, 01,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 01,00,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,02, 00,01, 00,02, FF,01, 00,02, 00,02, 00,01, 00,02,
                        00,02, FF,01, 00,02, 00,02, 00,01, FF,02, 00,02, 00,01,
                        00,02, FF,01, 00,02, 00,01, 00,02, FF,01, 00,01, 00,02,
                        00,01, 00,01, 00,02, FF,01, 00,01, 00,02, 00,01, 00,01,
                        00,02, 00,01, 00,01, 00,01, 00,02, 00,01, 00,01, 01,02,
                        00,01, 00,01, 01,01, 00,02, 00,01, 01,01, 00,02, 01,01,
                        00,01, 01,01, 01,02, 01,01, 00,01, 01,01, 01,01, 01,01,
                        01,01, 01,01, 01,01, 01,01, 01,00, 02,01, 01,01, 01,00,
                        01,01, 02,00, 01,00, 01,01, 02,00, 01,00, 02,00, 01,01,
                        01,00, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 02,FF,
                        01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF,
                        01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF,
                        01,FF, 01,FF, 01,FF, 00,FF, 01,FF, 01,FE, 01,FF, 01,FF,
                        01,FF, 00,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,FF, 01,FF,
                        00,FF, 01,FF, 01,FF, 00,FE, 01,FF, 01,FF, 00,FF, 01,FF,
                        00,FF, 01,FE, 01,FF, 00,FF, 01,FF, 00,FE, 01,FF, 00,FF,
                        01,FE, 00,FF, 00,FE, 01,FF, 00,FF, 01,FE, 00,FF, 00,FE,
                        01,FE, 00,FF, 01,FE, 00,FF, 00,FE, 00,FE, 01,FE, 00,FF,
                        00,FE, 01,FE, 00,FE, 00,FE, 00,FE, 01,FE, 00,FE, 00,FE,
                        00,FE, 00,FE, 00,FE, 01,FE, 00,FE, 00,FE, 00,FE, 00,FE,
                        00,FE, 00,FE, 00,FE, 00,FF, 00,FE, 00,FE, 00,FF, 00,FE,
                        00,FF, 00,FE, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, FF,FF,
                        00,FF, FF,00, FF,00, FF,00, 00,01, FF,00, 00,01, FF,01,
                        FF,01, 00,01, FF,01, FF,01, 00,02, FF,01, FF,02, 00,01,
                        FF,02, 00,02, FF,01, FF,02, 00,02, FF,02, FF,01, 00,02,
                        FF,02, 00,02, FF,01, 00,02, 00,02, FF,01, 00,02, FF,01,
                        00,02, 00,02, 00,01, FF,02, 00,01, 00,02, 00,01, 00,02,
                        FF,01, 00,02, 00,01, 00,01, 00,02, 00,01, 00,02, 00,01,
                        00,01, 00,02, 00,01, 00,01, 00,02, 00,01, 00,01, 00,02,
                        00,01, 00,01, 01,01, 00,02, 00,01, 00,01, 00,02, 00,01,
                        00,01, 00,02, 00,01, 00,01, 00,02, 01,01, 00,01, 00,02,
                        00,01, 00,01, 00,02, 00,01, 00,01, 00,02, 00,01, 00,02,
                        00,01, 00,01, 00,02, 00,01, 00,02, 00,01, 00,02, 00,01,
                        00,02, 00,01, 00,02, FF,02, 00,01, 00,02, 00,02, 00,01,
                        FF,02, 00,02, 00,01, 00,02, FF,01, 00,01, 00,01, 00,01,
                        FF,00, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FE, 00,FF,
                        00,FE, 00,FF, 00,FE, 01,FE, 00,FE, 00,FE, 00,FE, 00,FE,
                        01,FE, 00,FE, 00,FD, 01,FE, 00,FE, 01,FE, 00,FE, 01,FE,
                        00,FD, 01,FE, 01,FE, 00,FE, 01,FE, 01,FE, 00,FF, 01,FE,
                        01,FE, 01,FF, 01,FF, 01,FE, 01,FF, 01,FF, 01,FF, 01,FF,
                        01,FF, 01,00, 01,FF, 01,00, 01,00, 02,00, 01,00, 01,00,
                        02,01, 01,00, 01,01, 02,01, 01,01, 01,01, 01,01, 01,01,
                        02,01, 01,01, 01,01, 00,02, 01,01, 01,01, 01,02, 00,01,
                        01,02, 00,01, 00,02, 01,01, 00,02, 00,01, 00,02, 00,01,
                        00,02, FF,01, 00,02, 00,01, FF,02, 00,01, FF,01, FF,02,
                        FF,01, FF,01, FF,02, FF,01, FF,01, FF,01, FF,01, FE,01,
                        FF,00, FF,00, FE,00, FF,00, FE,FF, FF,FF, FE,00, FF,FF,
                        FF,FF, FF,FF, FF,00, FF,00, 00,01, 00,02, 01,01, 00,01,
                        01,02, 01,02, 01,02, 01,01, 01,02, 02,02, 01,01, 01,01,
                        02,01, 01,01, 01,01, 02,01, 01,00, 02,00, 01,00, 01,01,
                        02,00, 01,00, 02,FF, 01,00, 02,00, 01,00, 01,00, 02,FF,
                        01,00, 02,00, 01,FF, 01,00, 02,00, 01,FF, 02,00, 02,FF,
                        01,FE, 02,FF, 02,FF, 02,FF, 01,FE, 02,FF, 02,FE, 01,FE,
                        02,FF, 02,FE, 01,FE, 02,FE, 02,FE, 01,FD, 02,FE, 01,FD,
                        02,FE, 01,FD, 02,FD, 01,FE, 02,FD, 01,FD, 01,FD, 02,FD,
                        01,FD, 01,FD, 01,FD, 01,FD, 01,FD, 01,FD, 01,FD, 01,FE,
                        00,FD, 01,FE, 01,FD, 00,FE, 01,FD, 00,FE, 00,FE, 01,FF,
                        00,FE, 00,FF, 00,FE, FF,FF, 00,FF, FF,FF, FF,00, FF,00,
                        00,01, FF,01, FF,01, FE,01, FF,01, FF,02, FF,02, FF,02,
                        FE,02, FF,02, FF,02, FF,03, FF,03, FE,02, FF,03, FF,03,
                        00,03, FF,03, FF,03, 00,03, FF,03, 00,03, 00,03, 00,03,
                        00,03, 00,03, 00,03, 01,03, 00,03, 01,03, 00,03, 01,02,
                        01,03, 01,02, 01,02, 01,03, 01,02, 01,01, 01,02, 01,02,
                        02,01, 01,01, 01,01, 02,01, 01,01, 01,00, 02,00, 01,00,
                        02,00, 01,FF, 02,FF, 02,FF, 01,FF, 02,FF, 01,FE, 02,FF,
                        01,FE, 02,FE, 01,FE, 02,FE, 01,FD, 01,FE, 02,FD, 01,FE,
                        01,FD, 02,FD, 01,FD, 01,FD, 01,FD, 01,FD, 01,FD, 01,FD,
                        01,FD, 00,FD, 01,FD, 01,FC, 00,FD, 00,FD, 01,FE, 00,FD,
                        00,FD, 00,FD, FF,FE, 00,FD, FF,FE, 00,FE, FF,FE, FF,FE,
                        FF,FE, FE,FE, FF,FF, FE,FF, FE,FF, FE,00, FE,FF, FD,00,
                        FD,00, FE,00, FD,01, FD,01, FE,01, FE,01, FE,01, FF,01,
                        FF,02, 00,01, 01,02, 01,02, 02,01, 02,02, 02,01, 03,02,
                        02,01, 03,01, 03,00, 02,01, 03,00, 02,00, 02,00, 03,00,
                        02,00, 02,FF, 02,00, 02,FF, 02,00, 03,FF, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 02,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,FF, 01,00, 01,00, 02,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,00,
                        01,00, 01,FF, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00,
                        01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,FF, 01,00,
                        01,00, 01,FF, 01,00, 01,00, 01,FF, 01,00, 01,FF, 01,00,
                        01,00, 00,FF, 01,00, 01,FF, 01,00, 01,FF, 01,00, 01,00,
                        01,FF, 01,FF, 01,FF, 01,00, 01,FF, 01,00, 01,FF, 01,FF,
                        01,FF, 01,00, 01,FF, 01,00, 01,FF, 01,FF, 01,00, 01,FF,
                        00,FF, 01,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,00, 01,FF,
                        01,FF, 01,FF, 01,FF, 00,FF, 01,00, 01,FF, 01,FF, 01,FF,
                        01,FF, 00,FF, 01,FF, 01,FF, 00,FF, 01,FF, 01,FF, 00,FF,
                        01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF,
                        00,FF, 00,FF, 00,FF, FF,FF, 00,FF, FF,FF, FF,FF, 00,FF,
                        FF,00, FF,FF, FF,FF, FF,00, FF,FF, FF,00, FF,00, FF,00,
                        FF,01, FF,00, 00,01, FF,00, FF,01, 00,01, FF,01, FF,01,
                        00,01, FF,01, 00,01, FF,01, 00,02, 00,01, FF,01, 00,01,
                        00,01, 00,01, FF,02, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        01,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,02, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,02, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, FF,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,02, 00,01,
                        00,01, 00,01, 00,01, FF,01, 00,02, 00,01, 00,01, FF,01,
                        00,01, 00,01, FF,01, 00,01, FF,00, 00,01, FF,01, FF,00,
                        FF,01, FF,00, FE,01, FF,00, FF,00, FF,00, FF,FF, FF,00,
                        FF,00, FF,FF, FE,00, FF,FF, FF,00, FF,FF, FF,FF, FF,FF,
                        00,FF, FF,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FF, 01,FF,
                        00,FF, 01,FF, 00,FF, 01,FF, 01,FF, 01,FF, 00,FF, 01,00,
                        01,FF, 01,FF, 01,00, 01,FF, 01,FF, 01,00, 01,00, 01,FF,
                        01,00, 01,00, 01,00, 01,FF, 02,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,01, 01,00, 01,00, 01,00, 01,01, 01,00,
                        01,00, 01,01, 01,00, 01,01, 01,01, 01,00, 01,01, 01,01,
                        01,01, 01,01, 01,00, 00,01, 01,01, 01,00, 01,01, 00,01,
                        01,01, 01,00, 01,01, 01,01, 01,01, 01,01, 01,00, 01,01,
                        00,01, 01,00, 01,01, 01,00, 01,01, 01,00, 01,01, 01,00,
                        01,01, 01,00, 00,01, 01,00, 01,00, 01,01, 01,00, 01,00,
                        01,00, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,FF, 01,00,
                        02,00, 01,00, 01,00, 01,00, 01,00, 01,FE, 00,FF, 01,FE,
                        00,FF, 01,FE, 01,FF, 00,FE, 01,FF, 00,FE, 01,FF, 00,FE,
                        01,FF, 01,FE, 00,FF, 01,FE, 00,FF, 01,FF, 00,FE, 01,FF,
                        00,FE, 01,FF, 00,FF, 01,FE, 00,FF, 01,FF, 00,FF, 00,FF,
                        01,FE, 00,FF, 01,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF,
                        01,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF,
                        00,FF, 00,FF, FF,00, FF,00, FF,01, FF,00, 00,01, FF,00,
                        00,01, FF,01, FF,01, 00,01, FF,01, 00,01, FF,00, FF,01,
                        00,01, FF,01, 00,01, FF,01, 00,01, FF,02, 00,01, FF,01,
                        00,01, FF,01, 00,01, 00,02, FF,01, 00,01, 00,01, 00,02,
                        00,01, FF,01, 00,02, 00,01, 00,01, 00,01, 00,02, 00,01,
                        00,01, 01,01, 00,02, 00,01, 00,01, 00,01, 01,01, 00,01,
                        00,02, 01,01, 00,01, 01,01, 00,01, 01,01, 00,01, 01,01,
                        01,01, 01,01, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00,
                        00,FF, 01,00, 01,FF, 01,00, 00,FF, 01,FF, 01,00, 00,FF,
                        01,FF, 00,FF, 01,FF, 00,FF, 01,FF, 01,FF, 00,FF, 01,FF,
                        00,FF, 01,FF, 00,FF, 01,FE, 00,FF, 00,FF, 01,FE, 00,FF,
                        01,FF, 00,FE, 00,FF, 01,FE, 00,FF, 00,FF, 00,FE, 00,FF,
                        01,FE, 00,FF, 00,FE, 00,FF, 00,FE, 00,FF, 00,FF, 00,FE,
                        00,FF, FF,FF, 00,FE, 00,FF, 00,FF, FF,FF, 00,FF, 00,FF,
                        FF,FF, 00,FF, FF,FF, FF,FF, FF,00, 00,FF, FF,00, FF,00,
                        FF,00, FF,00, FF,00, FF,00, FF,01, FF,01, FF,00, FF,01,
                        FF,01, FF,00, FF,01, 00,01, FF,01, 00,01, 00,01, 01,00,
                        00,01, 01,00, 01,01, 01,00, 01,00, 01,01, 01,00, 01,00,
                        01,00, 02,01, 01,00, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,00, 01,00, 01,00, 01,FF, 01,00, 01,00, 01,FF,
                        01,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF,
                        01,FF, 01,FF, 00,FF, 01,00, 01,FF, 01,00, 01,00, 01,01,
                        00,01, 01,01, 00,01, 00,01, 00,01, 00,01, 00,02, 00,01,
                        00,01, 00,02, 00,01, 00,02, 00,01, 00,02, 00,02, 00,01,
                        00,02, 00,01, FF,02, 00,01, 00,02, 00,01, 00,02, FF,01,
                        00,01, 00,02, 00,01, FF,01, 00,01, 00,02, 00,01, 00,01,
                        FF,01, 00,01, 00,01, 00,01, 00,01, 00,01, 00,01, FF,01,
                        00,01, 00,01, 01,01, 00,01, 00,01, 01,00, 01,00, 01,00,
                        01,00, 01,FF, 01,00, 00,FF, 01,00, 01,FF, 01,00, 00,FF,
                        01,00, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF,
                        00,FF, 01,FF, 01,FF, 01,FF, 01,FE, 00,FF, 01,FF, 01,FF,
                        00,FE, 01,FF, 01,FF, 00,FE, 01,FF, 00,FF, 01,FE, 00,FF,
                        00,FF, 01,FE, 00,FF, 01,FE, 00,FF, 00,FF, 01,FE, 00,FF,
                        00,FF, 00,FF, 00,FE, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF,
                        00,FF, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,01, 00,01, 01,01, 00,01, 00,01,
                        00,01, 00,01, 00,01, 00,02, 01,01, 00,01, 00,01, 00,02,
                        01,01, 00,01, 00,01, 01,02, 00,01, 00,01, 01,01, 00,01,
                        01,01, 01,01, 00,01, 01,01, 01,01, 01,01, 00,01, 01,00,
                        01,01, 00,01, 01,00, 01,01, 01,01, 01,01, 01,01, 00,01,
                        01,00, 00,01, 01,01, 00,01, 01,01, 00,01, 01,01, 00,01,
                        01,01, 00,01, 01,01, 00,01, 01,00, 00,01, 01,01, 00,01,
                        01,00, 01,01, 01,01, 01,00, 01,00, 01,00, 01,00, 01,00,
                        01,00, 01,FF, 01,00, 01,00, 01,FF, 01,00, 01,FF, 01,00,
                        01,FF, 01,00, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 01,FF,
                        00,FF, 01,FF, 00,FF, 01,FF, 00,FF, 00,FF, 01,FF, 00,FF,
                        00,FF, 00,FE, 01,FF, 00,FF, 00,FF, 00,FF, 00,FF, 00,FE,
                        00,FF, 00,FF, 00,FF, 00,FE, 00,FF, 00,FF, 00,FF, 00,FE,
                        FF,FF, 00,FF, 00,FE, 00,FF, 00,FF, FF,FF, 00,FE, 00,FF,
                        00,FF, FF,FF, 00,FF, 00,FF, FF,FF, 00,FF, FF,FF, 00,FF,
                        00,FF, FF,FF, 00,FF, FF,FF, FF,FF, 00,FF, FF,00, 00,FF,
                        FF,00, 00,FF, FF,00, FF,00, FF,00, FF,00, 00,01, FF,00,
                        FF,01, FF,01, 00,01, FF,00, 00,01, FF,01, 00,01, 00,01,
                        FF,01, 00,01, FF,01, 00,01, FF,01, 00,01, 00,01, FF,01,
                        00,01, 00,02, FF,01, 00,01, 00,01, 00,02, 00,01, FF,01,
                        00,02, 00,01, 00,01, 00,01, 00,02, 00,01, 00,01, 00,02,
                        00,01, 00,01, 00,01, 01,01, 00,02, 00,01, 00,01, 01,01,
                        00,01, 01,01, 00,01, 00,01, 01,01, 00,01, 01,01, 00,01,
                        01,01, 01,00, 00,01, 01,01, 80,80, 80,80, 80,80, 80,80
}


;;; $DDC7: Unused Draygon fight intro dance data ;;;
{
; This section is read even though the mini-Draygon's are deleted at this point
; (deleted due to the 80,80 terminator, but the movement routine sets their position anyway)
$A5:DDC7             db 01,FF, 02,FE, 01,FF, 02,FE, 01,FF, 01,FE, 02,FF, 01,FE,
                        02,FF, 01,FE, 01,FF, 02,FE, 01,FE, 01,FF, 02,FE, 01,FE,
                        01,FF, 02,FE, 01,FE, 01,FE, 01,FE, 02,FF, 01,FE, 01,FE,
                        01,FD, 02,FE, 01,FE, 01,FE, 01,FE, 01,FD, 01,FE, 01,FE,
                        01,FD, 01,FD, 01,FE, 01,FD, 01,FD, 01,FE, 01,FD, 01,FD,
                        01,FD, 00,FE, 01,FD, 01,FE, 00,FD, 00,FE, 01,FE, 00,FE,
                        00,FF, 00,FE, FF,FF, 00,FF, FF,FF, FF,00, FF,00, FF,01,
                        FF,01, FF,01, FF,01, FE,01, FF,02, FF,01, FE,02, FF,02,
                        FE,03, FF,02, FE,02, FF,03, FE,03, FF,03, FE,02, FF,03,
                        FF,03, FF,03, FF,04, FF,03, FF,03, FF,03, FF,03, 00,03,
                        00,03, FF,03, 00,03, 00,03, 00,03, 01,03, 00,03, 00,02,
                        01,03, 01,03, 00,02, 01,02, 01,03, 01,02, 01,02, 01,02,
                        01,02, 02,01, 01,02, 01,01, 02,01, 01,01, 02,01, 01,01,
                        02,01, 01,00, 02,00, 02,00, 01,00, 02,00, 02,FF, 02,00,
                        01,FF, 02,FF, 02,FF, 02,FE, 01,FF, 02,FE, 02,FF, 01,FE,
                        02,FE, 01,FE, 02,FE, 01,FD, 02,FE, 01,FE, 01,FD, 01,FD,
                        01,FE, 01,FD, 01,FD, 01,FD, 01,FD, 00,FD, 01,FD, 00,FD,
                        00,FC, 01,FD, 00,FD, FF,FD, 00,FD, 00,FC, 00,FD, FF,FD,
                        00,FD, FF,FD, FF,FD, FF,FD, 00,FE, FF,FD, FF,FE, FF,FD,
                        FE,FE, FF,FE, FF,FE, FF,FF, FE,FE, FF,FF, FF,FF, FE,00,
                        FF,FF, FE,00, FF,00, FE,01, FF,01, FF,01, FE,01, FF,01,
                        FE,02, FF,02, FF,02, FE,02, FF,03, FF,02, 00,03, FF,02,
                        FF,02, 00,03, 00,02, 00,02, 00,03, 00,02, 01,02, 01,02,
                        01,02, 00,02, 02,02, 01,01, 01,02, 01,02, 02,02, 02,01

$A5:DF47             db 01,02, 02,02, 02,01, 01,02, 02,02, 02,01, 02,02, 02,01,
                        02,02, 02,02, 02,01, 02,02, 01,02, 02,01, 02,02, 02,02,
                        01,01, 02,02, 01,02, 02,02, 01,02, 02,01, 01,02, 02,02,
                        01,02, 02,01, 01,02, 02,02, 01,01, 02,01, 02,02, 02,01,
                        01,01, 02,01, 02,01, 02,01, 03,01, 02,00, 02,01, 00,FF,
                        00,FE, 00,FF, 01,FF, 00,FF, 00,FE, 00,FF, 00,FF, 01,FE,
                        00,FF, 00,FF, 00,FE, 00,FF, 01,FF, 00,FE, 00,FF, 00,FF,
                        01,FE, 00,FF, 00,FE, 01,FF, 00,FF, 00,FE, 01,FF, 00,FE,
                        00,FF, 01,FE, 00,FF, 01,FE, 00,FF, 01,FE, 00,FF, 01,FE,
                        01,FE, 00,FF, 01,FE, 00,FF, 01,FE, 01,FE, 01,FE, 01,FF,
                        00,FE, 01,FE, 01,FE, 01,FF, 01,FE, 01,FE, 01,FE, 01,FE,
                        01,FE, 01,FE, 01,FF, 02,FE, 01,FF, 01,FF, 01,FF, 01,FF,
                        01,00, 01,00, 01,01, 01,01, 00,01, 01,02, 00,01, 00,02,
                        01,02, 00,02, 00,02, 00,02, 00,02, 00,01, 00,02, 00,02,
                        00,01, 00,02, FF,02, 00,01, 00,02, 00,01, FF,02, 00,01,
                        00,02, 00,01, FF,01, 00,02, 00,01, FF,02, 00,01, 00,01,
                        FF,02, 00,01, 00,02, 00,01, 00,02, 00,01, 00,02, 00,01,
                        00,02, 00,02, 00,01, 00,02, 00,02, 01,02, 00,02, 01,02,
                        00,01, 01,02, 00,02, 01,02, 01,01, 00,02, 01,01, 01,02,
                        01,01, 00,01, 01,01, 01,01, 01,00, 01,01, 01,00, 01,00,
                        01,00, 01,FF, 01,FF, 01,00, 01,FF, 01,FE, 00,FF, 01,FF,
                        01,FE, 01,FF, 01,FE, 00,FE, 01,FE, 01,FE, 01,FE, 00,FE,
                        01,FD, 00,FE, 01,FE, 01,FD, 00,FE, 01,FD, 00,FE, 00,FE,
                        01,FD, 00,FE, 01,FD, 00,FE, 00,FD, 01,FE, 00,FE, 00,FD,
                        00,FE, 01,FE, 00,FE, 00,FE, 00,FE, 01,FE, 00,FE, 00,FF,
                        00,FE, 00,FF, 01,FF, 00,FF, 00,FF, 00,FF, 01,FF, 00,FF,
                        01,00, 00,01, 01,00, 00,01, 00,01, 01,01, 00,01, 01,02,
                        00,01, 01,02, 00,01, 00,02, 01,02, 00,02, 00,01, 01,02,
                        00,02, 00,01, 01,02, 00,02, 00,01, 00,02, 00,01, 00,02,
                        01,01, 00,02, 00,01, 00,02, 00,01, 00,02, 00,01, 01,02,
                        00,01, 00,02, 00,01, 00,02, 01,01, 00,02, 00,01, 01,02,
                        00,01, 00,02, 01,01, 00,02, 01,01, 00,02, 01,01, 01,02,
                        00,01, 01,01, 01,02, 01,01, 01,01, 01,01, 01,01, 01,01,
                        02,01, 01,01, 01,01, 01,01, 02,00, 01,01, 02,01, 01,01,
                        02,00, 02,00, 02,00, 01,00, 02,00, 02,00, 01,00, 02,00,
                        02,00, 02,00, 01,00, 02,00, 01,00, 02,00, 02,00, 01,FF,
                        02,00, 01,00, 02,FF, 01,00, 02,FF, 01,00, 01,FF, 02,FF,
                        01,FF, 01,FF, 01,FF, 01,FF, 01,FF, 02,FF, 01,FF, 01,FF,
                        01,FF, 01,FE, 01,FF, 01,FF, 00,FE, 01,FF, 01,FE, 01,FF,
                        01,FE, 01,FF, 01,FE, 01,FF, 01,FE, 00,FF, 01,FE, 01,FF,
                        01,FE, 01,FF, 01,FE, 01,FF, 01,FE, 00,FF, 01,FE, 01,FF,
                        01,FE, 01,FF, 00,FE, 01,FF, 01,FE, 00,FF, 01,FE, 00,FF,
                        01,FE, 00,FF, 00,FE, 01,FF, 00,FE, 00,FE, 00,FF, 00,FE,
                        00,FF, 00,FE, FF,FE, 00,FF, 00,FE, FF,FE, 00,FE, FF,FF,
                        FF,FE, FF,FE, FF,FF, FF,FE, FF,FE, FF,FF, FF,FE, FF,FF,
                        FF,FF, FF,FE, FE,FF, FF,FF, FF,FF, FE,FF, FF,00, FF,FF,
                        FE,FF, FF,00, FF,00, FE,00, FF,00, FF,01, FF,00, FE,01,
                        FF,00, FF,01, FF,01, FF,01, FE,01, FF,02, FF,01, FF,02,
                        FF,01, FF,02, FF,01, FF,02, 00,02, FF,01, FF,02, FF,02,
                        00,02, FF,02, FF,02, 00,01, FF,02, 00,02, 00,02, FF,01,
                        00,02, 00,02, 00,01, 00,02, 00,02, 00,01, 00,02, 00,01,
                        00,02, 00,02, 00,01, 00,02, 01,01, 00,02, 00,01, 01,02,
                        00,02, 01,01, 00,02, 01,01, 00,02, 01,01, 00,02, 01,01,
                        00,02, 01,01, 01,02, 00,02, 01,01, 01,02, 01,01, 00,02,
                        01,01, 01,02, 01,01, 01,02, 01,01, 01,01, 01,02, 01,01,
                        01,01, 01,01, 01,01, 01,01, 01,01, 02,01, 01,01, 01,01,
                        01,01, 02,00, 01,01, 02,01, 01,00, 02,01, 01,00, 02,00,
                        01,01, 02,00, 01,00, 02,00, 02,00, 01,00, 02,00, 02,00,
                        02,00, 01,00, 02,00, 02,00, 01,00, 02,00, 02,00, 01,FF,
                        02,00, 02,00, 02,00, 01,00, 02,00, 02,FF, 01,00, 02,00,
                        01,00, 02,00, 02,FF, 01,00, 02,00, 02,00, 01,00, 02,00,
                        01,FF, 02,00, 01,00, 02,00, 02,00, 01,00, 02,00, 01,FF,
                        02,00, 02,00, 01,00, 02,00, 01,00, 02,00, 02,00, 01,00,
                        02,00, 01,00, 02,00, 02,00, 01,00, 02,00, 01,00, 02,00,
                        02,00, 01,00, 02,00, 02,00, 01,00, 02,00, 01,00, 02,00,
                        02,00
}
}


;;; $E359..F959: Spore Spawn ;;;
{
;;; $E359: Palette - enemy $DF3F/$DF7F (Spore Spawn) ;;;
{
; Used for spores
$A5:E359             dw 0000, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 57FF, 3AB5, 1DCE, 00E7, 03FF, 0216, 00B0
}


;;; $E379: Spore Spawn palettes ;;;
{
; Sprite palette 1. Spore Spawn and spore spawner
$A5:E379             dw 0000,3F57,2E4D,00E2,0060,3AB0,220B,1166,0924,57FF,3AB5,1DCE,00E7,03FF,0216,00B0
$A5:E399             dw 3800,2A92,21CC,00C4,0062,260E,15AA,0D27,04E5,475A,2E52,198C,00C6,033F,01B6,008F
$A5:E3B9             dw 3800,15EF,156B,00A5,0063,15AC,0D49,0907,04C6,36D6,21D0,114B,00A6,025F,0137,008D
$A5:E3D9             dw 3800,094A,0908,0463,0000,0929,04C6,04A5,0484,2631,156D,0D09,0085,019F,00D7,006C
}


;;; $E3F9: Spore Spawn palettes ;;;
{
; Sprite palette 1. Spore Spawn and spore spawner
$A5:E3F9             dw 3800,094A,0908,0463,0000,0929,04C6,04A5,0484,2631,156D,0D09,0085,019F,00D7,006C
$A5:E419             dw 3800,118C,0D2A,0464,0000,0D4B,08E8,04A6,0485,2A53,156E,0D09,0065,09DF,04F6,006C
$A5:E439             dw 3800,15AF,114B,0465,0001,156D,0D09,08C7,04A6,2A74,158E,08EA,0065,11FE,0916,008C
$A5:E459             dw 3800,1DF1,156D,0466,0001,198F,112B,08C8,04A7,2E96,158F,08EA,0045,1A3E,0D35,008C
$A5:E479             dw 3800,2213,1D8F,0086,0001,21D0,114D,08EA,04A8,2E97,1990,04EA,0044,1E5D,0D54,00AB
$A5:E499             dw 3800,2A55,21B1,0087,0001,25F2,156F,08EB,04A9,32B9,1991,04EA,0024,269D,1173,00AB
$A5:E4B9             dw 3800,2E78,25D2,0088,0002,2E14,1990,0D0C,04CA,32DA,19B1,00CB,0024,2EBC,1593,00CB
$A5:E4D9             dw 3800,36BA,29F4,0089,0002,3236,1DB2,0D0D,04CB,36FC,19B2,00CB,0004,36FC,19B2,00CB

; BG1/2 palette 4. Level graphics (green)
$A5:E4F9             dw 2003,6318,6318,1CE1,1DA9,2923,24A1,1400,2269,21C9,1544,0420,268B,04C5,2731,0000
$A5:E519             dw 2003,6318,6318,18C3,1DAA,2524,1CA3,1000,1E2A,1D8A,1145,0000,2A8D,0CE7,22F1,0001
$A5:E539             dw 0000,6318,6318,14C4,1DAC,2126,18A4,0C00,19EA,196A,1147,0001,2A6F,112A,22B1,0001
$A5:E559             dw 0000,6318,6318,0CA5,19AD,1908,1085,0400,118A,114A,0D29,0001,2E70,194C,1E72,0002
$A5:E579             dw 0000,6318,6318,08A6,19AF,150A,0C86,0000,0D4A,0D2A,0D2B,0002,2E52,1D8F,1E32,0002
$A5:E599             dw 0000,6318,6318,0488,19B0,110B,0488,0001,090B,08EB,092C,0003,3254,25B1,19F2,0002
$A5:E5B9             dw 0000,6318,6318,0089,19B2,0D0D,0089,0002,04CB,04CB,092E,0004,3236,29F4,19B2,0002

; BG1/2 palette 7. Background graphics (blue)
$A5:E5D9             dw 3800,5544,3C84,1441,24E3,18A2,1081,0C40,129C,11B5,14EE,1066,7FFF,7FFF,16BD,0800
$A5:E5F9             dw 3800,4947,3486,1063,2105,18C4,1083,0C21,1239,1194,110E,1065,7FFF,7FFF,167B,0401
$A5:E619             dw 3800,4169,2CA7,0C64,2128,14C6,0C84,0821,0DF6,0D72,110E,0C45,7FFF,7FFF,1659,0401
$A5:E639             dw 3800,356B,24C9,0C65,1D4A,14E7,0885,0821,0DB4,0D30,0D0E,0845,7FFF,7FFF,1A38,0401
$A5:E659             dw 3800,2D8D,1CEA,0866,1D6D,10E9,0486,0421,0971,090E,0D0E,0425,7FFF,7FFF,1A16,0401
$A5:E679             dw 3800,2190,14EC,0488,198F,110B,0488,0402,090E,08ED,092E,0424,7FFF,7FFF,19D4,0002
$A5:E699             dw 3800,19B2,0D0D,0089,19B2,0D0D,0089,0002,04CB,04CB,092E,0004,7FFF,7FFF,19B2,0002
}


;;; $E6B9: Instruction list - initial - Spore Spawn is dead ;;;
{
$A5:E6B9             dx E91C,00C0,  ; ???
                        E8BA,EB1A,  ; Enemy function = RTS
                        0001,EE65,
                        812F        ; Sleep
}


;;; $E6C7: Instruction list - initial - Spore Spawn is alive ;;;
{
$A5:E6C7             dx 0100,EE6F,
                        E8BA,EB1B,  ; Enemy function = $EB1B (descent)
                        0001,EE6F,
                        812F        ; Sleep
}


;;; $E6D5: Instruction list - fight has started ;;;
{
$A5:E6D5             dw E82D,0040,0001, ; Spore Spawn speed = 40h, angle delta = 1
                        E8BA,EB52,      ; Enemy function = $EB52 (moving)
                        0300,EE6F
$A5:E6E3             dw E872,0001,      ; Disable spore generation
                        E895,002C,      ; Queue sound 2Ch, sound library 2, max queued sounds allowed = 6 (Spore Spawn opens up)
                        0001,EE6F,
                        0008,EE79,
                        0008,EE8B,
                        0008,EE9D,
                        0007,EEAF,
                        0007,EEC1,
                        0006,EED3,
                        0001,EEE5,
                        E771,           ; ???
                        E8BA,EB1A,      ; Enemy function = RTS
                        8123,0005       ; Timer = 5
$A5:E715             dw 0008,EF3D,
                        0008,EF4F,
                        0008,EF61,
                        0008,EF4F,
                        8110,E715       ; Decrement timer and go to $E715 if non-zero
$A5:E729             dw 0008,EED3,
                        0008,EEC1,
                        0008,EEAF,
                        0008,EE9D,
                        0008,EE8B,
                        0008,EE79,
                        0001,EE6F,
                        E8BA,EB52,      ; Enemy function = $EB52 (moving)
                        E872,0000,      ; Enable spore generation
                        E75F,           ; ???
                        0200,EE6F,
                        E872,0001,      ; Disable spore generation
                        00D0,EE6F,
                        80ED,E6E3       ; Go to $E6E3
}


;;; $E75F: Instruction ;;;
{
; This function has no effect, Spore Spawn speed is always 30h or 40h
$A5:E75F AF 16 78 7E LDA $7E7816[$7E:7816]  ;\
$A5:E763 18          CLC                    ;|
$A5:E764 69 08 00    ADC #$0008             ;} If [Spore Spawn speed] < 28h:
$A5:E767 C9 30 00    CMP #$0030             ;|
$A5:E76A 10 04       BPL $04    [$E770]     ;/
$A5:E76C 8F 16 78 7E STA $7E7816[$7E:7816]  ; Spore Spawn speed += 8

$A5:E770 6B          RTL
}


;;; $E771: Instruction ;;;
{
; Somehow stops Spore Spawn from moving when shot until it starts closes up, or something like that
$A5:E771 DA          PHX
$A5:E772 5A          PHY
$A5:E773 A9 00 00    LDA #$0000
$A5:E776 8F 1E 80 7E STA $7E801E[$7E:801E]
$A5:E77A 7A          PLY
$A5:E77B FA          PLX
$A5:E77C 6B          RTL
}


;;; $E77D: Instruction list - death sequence ;;;
{
$A5:E77D             dx E8BA,EB9B,  ; Enemy function = $EB9B
                        0001,EED3,
                        E8BA,EBEE,  ; Enemy function = $EBEE
                        8123,000A   ; Timer = Ah
$A5:E78D             dx 0001,EED3,
                        E9B1,       ; ???
                        813A,0008,  ; Wait 8 frames
                        8110,E78D,  ; Decrement timer and go to $E78D if non-zero
                        0008,EED3,
                        0008,EEC1,
                        0008,EEAF,
                        0008,EE9D,
                        0008,EE8B,
                        0008,EE79,
                        0001,EE65,
                        E87C,       ; ???
                        8123,000A   ; Timer = Ah
$A5:E7BD             dx E96E,       ; ???
                        813A,0008,  ; Wait 8 frames
                        8110,E7BD,  ; Decrement timer and go to $E7BD if non-zero
                        E8CA,0000,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8CA,0020,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8CA,0040,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8CA,0060,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8CA,0080,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8CA,00A0,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8CA,00C0,  ; ???
                        E96E,       ; ???
                        0010,EE65,
                        E8B1,       ; Call Spore Spawn death item drop routine
                        812F        ; Sleep
}


;;; $E811: Unused. Instruction - Spore Spawn speed = [[Y]], angle delta = [[Y] + 2], angle = [[Y] + 4] ;;;
{
$A5:E811 B9 00 00    LDA $0000,y
$A5:E814 8F 16 78 7E STA $7E7816[$7E:7816]
$A5:E818 B9 02 00    LDA $0002,y
$A5:E81B 8F 18 78 7E STA $7E7818[$7E:7818]
$A5:E81F B9 04 00    LDA $0004,y
$A5:E822 8F 14 78 7E STA $7E7814[$7E:7814]
$A5:E826 98          TYA
$A5:E827 18          CLC
$A5:E828 69 06 00    ADC #$0006
$A5:E82B A8          TAY
$A5:E82C 6B          RTL
}


;;; $E82D: Instruction - Spore Spawn speed = [[Y]], angle delta = [[Y] + 2] ;;;
{
$A5:E82D B9 00 00    LDA $0000,y[$A5:E6D7]
$A5:E830 8F 16 78 7E STA $7E7816[$7E:7816]
$A5:E834 B9 02 00    LDA $0002,y[$A5:E6D9]
$A5:E837 8F 18 78 7E STA $7E7818[$7E:7818]
$A5:E83B C8          INY
$A5:E83C C8          INY
$A5:E83D C8          INY
$A5:E83E C8          INY
$A5:E83F 6B          RTL
}


;;; $E840: Unused. Instruction - Spore Spawn speed = [[Y]] ;;;
{
$A5:E840 B9 00 00    LDA $0000,y
$A5:E843 8F 16 78 7E STA $7E7816[$7E:7816]
$A5:E847 C8          INY
$A5:E848 C8          INY
$A5:E849 6B          RTL
}


;;; $E84A: Unused. Instruction - Spore Spawn angle delta = [[Y]] ;;;
{
$A5:E84A B9 00 00    LDA $0000,y
$A5:E84D 8F 18 78 7E STA $7E7818[$7E:7818]
$A5:E851 C8          INY
$A5:E852 C8          INY
$A5:E853 6B          RTL
}


;;; $E854: Unused. Instruction - Spore Spawn speed += [[Y]] ;;;
{
$A5:E854 AF 16 78 7E LDA $7E7816[$7E:7816]
$A5:E858 18          CLC
$A5:E859 79 00 00    ADC $0000,y
$A5:E85C 8F 16 78 7E STA $7E7816[$7E:7816]
$A5:E860 C8          INY
$A5:E861 C8          INY
$A5:E862 6B          RTL
}


;;; $E863: Unused. Instruction - Spore Spawn angle delta += [[Y]] ;;;
{
$A5:E863 AF 18 78 7E LDA $7E7818[$7E:7818]
$A5:E867 18          CLC
$A5:E868 79 00 00    ADC $0000,y
$A5:E86B 8F 18 78 7E STA $7E7818[$7E:7818]
$A5:E86F C8          INY
$A5:E870 C8          INY
$A5:E871 6B          RTL
}


;;; $E872: Instruction - spore generation flag = [[Y]] ;;;
{
$A5:E872 B9 00 00    LDA $0000,y[$A5:E6E5]
$A5:E875 8F 00 90 7E STA $7E9000[$7E:9000]
$A5:E879 C8          INY
$A5:E87A C8          INY
$A5:E87B 6B          RTL
}


;;; $E87C: Instruction ;;;
{
$A5:E87C A9 80 00    LDA #$0080
$A5:E87F 8D 7A 0F    STA $0F7A  [$7E:0F7A]
$A5:E882 A9 70 02    LDA #$0270
$A5:E885 8D 7E 0F    STA $0F7E  [$7E:0F7E]
$A5:E888 AD 86 0F    LDA $0F86  [$7E:0F86]
$A5:E88B 09 00 A0    ORA #$A000
$A5:E88E 29 FF FB    AND #$FBFF
$A5:E891 8D 86 0F    STA $0F86  [$7E:0F86]
$A5:E894 6B          RTL
}


;;; $E895: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 6 ;;;
{
$A5:E895 DA          PHX
$A5:E896 5A          PHY
$A5:E897 B9 00 00    LDA $0000,y[$A5:E6E9]
$A5:E89A 22 CB 90 80 JSL $8090CB[$80:90CB]
$A5:E89E 7A          PLY
$A5:E89F FA          PLX
$A5:E8A0 C8          INY
$A5:E8A1 C8          INY
$A5:E8A2 6B          RTL
}


;;; $E8A3: Instruction - queue sound [[Y]], sound library 3, max queued sounds allowed = 6 ;;;
{
$A5:E8A3 DA          PHX
$A5:E8A4 5A          PHY
$A5:E8A5 B9 00 00    LDA $0000,y
$A5:E8A8 22 4D 91 80 JSL $80914D[$80:914D]
$A5:E8AC 7A          PLY
$A5:E8AD FA          PLX
$A5:E8AE C8          INY
$A5:E8AF C8          INY
$A5:E8B0 6B          RTL
}


;;; $E8B1: Instruction - call Spore Spawn death item drop routine ;;;
{
$A5:E8B1 DA          PHX
$A5:E8B2 5A          PHY
$A5:E8B3 22 0A BB A0 JSL $A0BB0A[$A0:BB0A]
$A5:E8B7 7A          PLY
$A5:E8B8 FA          PLX
$A5:E8B9 6B          RTL
}


;;; $E8BA: Instruction - enemy function = [[Y]] ;;;
{
$A5:E8BA 5A          PHY
$A5:E8BB DA          PHX
$A5:E8BC AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:E8BF B9 00 00    LDA $0000,y[$A5:E6CD]
$A5:E8C2 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A5:E8C5 FA          PLX
$A5:E8C6 7A          PLY
$A5:E8C7 C8          INY
$A5:E8C8 C8          INY
$A5:E8C9 6B          RTL
}


;;; $E8CA: Instruction ;;;
{
; Changes spore colours during Spore Spawn fight
$A5:E8CA 5A          PHY
$A5:E8CB DA          PHX
$A5:E8CC 84 12       STY $12    [$7E:0012]
$A5:E8CE B9 00 00    LDA $0000,y[$A5:E7C9]
$A5:E8D1 A8          TAY
$A5:E8D2 A2 00 00    LDX #$0000

$A5:E8D5 B9 F9 E3    LDA $E3F9,y[$A5:E3F9]
$A5:E8D8 9F 20 C1 7E STA $7EC120,x[$7E:C120]
$A5:E8DC C8          INY
$A5:E8DD C8          INY
$A5:E8DE E8          INX
$A5:E8DF E8          INX
$A5:E8E0 E0 20 00    CPX #$0020
$A5:E8E3 D0 F0       BNE $F0    [$E8D5]
$A5:E8E5 A4 12       LDY $12    [$7E:0012]
$A5:E8E7 B9 00 00    LDA $0000,y[$A5:E7C9]
$A5:E8EA A8          TAY
$A5:E8EB A2 00 00    LDX #$0000

$A5:E8EE B9 F9 E4    LDA $E4F9,y[$A5:E4F9]
$A5:E8F1 9F 80 C0 7E STA $7EC080,x[$7E:C080]
$A5:E8F5 C8          INY
$A5:E8F6 C8          INY
$A5:E8F7 E8          INX
$A5:E8F8 E8          INX
$A5:E8F9 E0 20 00    CPX #$0020
$A5:E8FC D0 F0       BNE $F0    [$E8EE]
$A5:E8FE A4 12       LDY $12    [$7E:0012]
$A5:E900 B9 00 00    LDA $0000,y[$A5:E7C9]
$A5:E903 A8          TAY
$A5:E904 A2 00 00    LDX #$0000

$A5:E907 B9 D9 E5    LDA $E5D9,y[$A5:E5D9]
$A5:E90A 9F E0 C0 7E STA $7EC0E0,x[$7E:C0E0]
$A5:E90E C8          INY
$A5:E90F C8          INY
$A5:E910 E8          INX
$A5:E911 E8          INX
$A5:E912 E0 20 00    CPX #$0020
$A5:E915 D0 F0       BNE $F0    [$E907]
$A5:E917 FA          PLX
$A5:E918 7A          PLY
$A5:E919 C8          INY
$A5:E91A C8          INY
$A5:E91B 6B          RTL
}


;;; $E91C: Instruction ;;;
{
; Similar to $E8CA, but writing to target palette colours instead (called before fade-in)
$A5:E91C 5A          PHY
$A5:E91D DA          PHX
$A5:E91E 84 12       STY $12    [$7E:0012]  ;\
$A5:E920 B9 00 00    LDA $0000,y            ;|
$A5:E923 A8          TAY                    ;|
$A5:E924 A2 00 00    LDX #$0000             ;|
                                            ;|
$A5:E927 B9 F9 E3    LDA $E3F9,y            ;|
$A5:E92A 9F 20 C3 7E STA $7EC320,x          ;|
$A5:E92E C8          INY                    ;} Target sprite palette 1 = 20h bytes from $E3F9 + [Y]
$A5:E92F C8          INY                    ;|
$A5:E930 E8          INX                    ;|
$A5:E931 E8          INX                    ;|
$A5:E932 E0 20 00    CPX #$0020             ;|
$A5:E935 D0 F0       BNE $F0    [$E927]     ;|
$A5:E937 A4 12       LDY $12    [$7E:0012]  ;/
$A5:E939 B9 00 00    LDA $0000,y            ;\
$A5:E93C A8          TAY                    ;|
$A5:E93D A2 00 00    LDX #$0000             ;|
                                            ;|
$A5:E940 B9 F9 E4    LDA $E4F9,y            ;|
$A5:E943 9F 80 C2 7E STA $7EC280,x          ;|
$A5:E947 C8          INY                    ;} Target BG1/2 palette 4 = 20h bytes from $E4F9 + [Y]
$A5:E948 C8          INY                    ;|
$A5:E949 E8          INX                    ;|
$A5:E94A E8          INX                    ;|
$A5:E94B E0 20 00    CPX #$0020             ;|
$A5:E94E D0 F0       BNE $F0    [$E940]     ;|
$A5:E950 A4 12       LDY $12    [$7E:0012]  ;/
$A5:E952 B9 00 00    LDA $0000,y            ;\
$A5:E955 A8          TAY                    ;|
$A5:E956 A2 00 00    LDX #$0000             ;|
                                            ;|
$A5:E959 B9 D9 E5    LDA $E5D9,y            ;|
$A5:E95C 9F E0 C2 7E STA $7EC2E0,x          ;|
$A5:E960 C8          INY                    ;} Target BG1/2 palette 7 = 20h bytes from $E5D9 + [Y]
$A5:E961 C8          INY                    ;|
$A5:E962 E8          INX                    ;|
$A5:E963 E8          INX                    ;|
$A5:E964 E0 20 00    CPX #$0020             ;|
$A5:E967 D0 F0       BNE $F0    [$E959]     ;/
$A5:E969 FA          PLX
$A5:E96A 7A          PLY
$A5:E96B C8          INY
$A5:E96C C8          INY
$A5:E96D 6B          RTL
}


;;; $E96E: Instruction ;;;
{
$A5:E96E 5A          PHY
$A5:E96F DA          PHX
$A5:E970 22 11 81 80 JSL $808111[$80:8111]
$A5:E974 AD E5 05    LDA $05E5  [$7E:05E5]
$A5:E977 29 7F 00    AND #$007F
$A5:E97A 38          SEC
$A5:E97B E9 40 00    SBC #$0040
$A5:E97E 85 12       STA $12    [$7E:0012]
$A5:E980 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:E983 18          CLC
$A5:E984 65 12       ADC $12    [$7E:0012]
$A5:E986 85 12       STA $12    [$7E:0012]
$A5:E988 AD E5 05    LDA $05E5  [$7E:05E5]
$A5:E98B 29 00 7F    AND #$7F00
$A5:E98E EB          XBA
$A5:E98F 38          SEC
$A5:E990 E9 40 00    SBC #$0040
$A5:E993 85 14       STA $14    [$7E:0014]
$A5:E995 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:E998 18          CLC
$A5:E999 65 14       ADC $14    [$7E:0014]
$A5:E99B 85 14       STA $14    [$7E:0014]
$A5:E99D A9 15 00    LDA #$0015             ; A = 15h
$A5:E9A0 A0 09 E5    LDY #$E509             ;\
$A5:E9A3 22 97 80 86 JSL $868097[$86:8097]  ;} Spawn dust cloud / explosion enemy projectile
$A5:E9A7 A9 29 00    LDA #$0029             ;\
$A5:E9AA 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 29h, sound library 2, max queued sounds allowed = 6 (Spore Spawn gets hard)
$A5:E9AE FA          PLX
$A5:E9AF 7A          PLY
$A5:E9B0 6B          RTL
}


;;; $E9B1: Instruction ;;;
{
$A5:E9B1 5A          PHY
$A5:E9B2 DA          PHX
$A5:E9B3 22 11 81 80 JSL $808111[$80:8111]
$A5:E9B7 AD E5 05    LDA $05E5  [$7E:05E5]
$A5:E9BA 29 7F 00    AND #$007F
$A5:E9BD 38          SEC
$A5:E9BE E9 40 00    SBC #$0040
$A5:E9C1 85 12       STA $12    [$7E:0012]
$A5:E9C3 AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:E9C6 18          CLC
$A5:E9C7 65 12       ADC $12    [$7E:0012]
$A5:E9C9 85 12       STA $12    [$7E:0012]
$A5:E9CB AD E5 05    LDA $05E5  [$7E:05E5]
$A5:E9CE 29 00 3F    AND #$3F00
$A5:E9D1 EB          XBA
$A5:E9D2 38          SEC
$A5:E9D3 E9 20 00    SBC #$0020
$A5:E9D6 85 14       STA $14    [$7E:0014]
$A5:E9D8 AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:E9DB 18          CLC
$A5:E9DC 65 14       ADC $14    [$7E:0014]
$A5:E9DE 85 14       STA $14    [$7E:0014]
$A5:E9E0 A9 03 00    LDA #$0003
$A5:E9E3 85 16       STA $16    [$7E:0016]
$A5:E9E5 64 18       STZ $18    [$7E:0018]
$A5:E9E7 22 26 BC B4 JSL $B4BC26[$B4:BC26]
$A5:E9EB A9 25 00    LDA #$0025             ;\
$A5:E9EE 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 25h, sound library 2, max queued sounds allowed = 6 (big explosion)
$A5:E9F2 FA          PLX
$A5:E9F3 7A          PLY
$A5:E9F4 6B          RTL
}


;;; $E9F5: Spawn random Spore Spawn death explosion ;;;
{
$A5:E9F5 5A          PHY
$A5:E9F6 DA          PHX
$A5:E9F7 AD B6 05    LDA $05B6  [$7E:05B6]
$A5:E9FA 29 0F 00    AND #$000F
$A5:E9FD D0 28       BNE $28    [$EA27]
$A5:E9FF 22 11 81 80 JSL $808111[$80:8111]
$A5:EA03 AD E5 05    LDA $05E5  [$7E:05E5]
$A5:EA06 29 3F 00    AND #$003F
$A5:EA09 18          CLC
$A5:EA0A 69 60 00    ADC #$0060
$A5:EA0D 85 12       STA $12    [$7E:0012]
$A5:EA0F AD E5 05    LDA $05E5  [$7E:05E5]
$A5:EA12 29 00 0F    AND #$0F00
$A5:EA15 EB          XBA
$A5:EA16 18          CLC
$A5:EA17 69 E0 01    ADC #$01E0
$A5:EA1A 85 14       STA $14    [$7E:0014]
$A5:EA1C A9 15 00    LDA #$0015
$A5:EA1F 85 16       STA $16    [$7E:0016]
$A5:EA21 64 18       STZ $18    [$7E:0018]
$A5:EA23 22 26 BC B4 JSL $B4BC26[$B4:BC26]

$A5:EA27 FA          PLX
$A5:EA28 7A          PLY
$A5:EA29 6B          RTL
}


;;; $EA2A: Initialisation AI - enemy $DF3F/$DF7F (Spore Spawn) ;;;
{
$A5:EA2A A0 00 00    LDY #$0000             ;\
$A5:EA2D A2 00 00    LDX #$0000             ;|
                                            ;|
$A5:EA30 B9 59 E3    LDA $E359,y[$A5:E359]  ;|
$A5:EA33 9F E0 C3 7E STA $7EC3E0,x[$7E:C3E0];|
$A5:EA37 C8          INY                    ;} Target sprite palette 7 = [$E359..78] (spores)
$A5:EA38 C8          INY                    ;|
$A5:EA39 E8          INX                    ;|
$A5:EA3A E8          INX                    ;|
$A5:EA3B E0 20 00    CPX #$0020             ;|
$A5:EA3E D0 F0       BNE $F0    [$EA30]     ;/
$A5:EA40 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EA43 A9 00 00    LDA #$0000             ;\
$A5:EA46 A0 6C DE    LDY #$DE6C             ;} Spawn Spore Spawn's stalk enemy projectile
$A5:EA49 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EA4D A9 01 00    LDA #$0001             ;\
$A5:EA50 A0 6C DE    LDY #$DE6C             ;} Spawn Spore Spawn's stalk enemy projectile
$A5:EA53 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EA57 A9 02 00    LDA #$0002             ;\
$A5:EA5A A0 6C DE    LDY #$DE6C             ;} Spawn Spore Spawn's stalk enemy projectile
$A5:EA5D 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EA61 A9 03 00    LDA #$0003             ;\
$A5:EA64 A0 6C DE    LDY #$DE6C             ;} Spawn Spore Spawn's stalk enemy projectile
$A5:EA67 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EA6B AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EA6E BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A5:EA71 9F 08 78 7E STA $7E7808,x[$7E:7808];} Enemy stalk X origin = [enemy X position]
$A5:EA75 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A5:EA78 38          SEC                    ;|
$A5:EA79 E9 48 00    SBC #$0048             ;} Enemy stalk Y origin = [enemy Y position] - 48h
$A5:EA7C 9F 0A 78 7E STA $7E780A,x[$7E:780A];/
$A5:EA80 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A5:EA83 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy X origin = [enemy X position]
$A5:EA86 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A5:EA89 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;} Enemy Y origin = [enemy Y position]
$A5:EA8C 9E B2 0F    STZ $0FB2,x[$7E:0FB2]  ; Enemy $0FB2 = 0
$A5:EA8F AE 9F 07    LDX $079F  [$7E:079F]  ;\
$A5:EA92 BF 28 D8 7E LDA $7ED828,x[$7E:D829];|
$A5:EA96 29 02 00    AND #$0002             ;} If area mini-boss is dead:
$A5:EA99 F0 24       BEQ $24    [$EABF]     ;/
$A5:EA9B A9 B9 E6    LDA #$E6B9             ;\
$A5:EA9E 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Spore Spawn instruction list pointer = $E6B9
$A5:EAA1 A9 1A EB    LDA #$EB1A             ;\
$A5:EAA4 8D A8 0F    STA $0FA8  [$7E:0FA8]  ;} Spore Spawn function = RTS
$A5:EAA7 AD 86 0F    LDA $0F86  [$7E:0F86]  ;\
$A5:EAAA 09 00 80    ORA #$8000             ;} Set Spore Spawn's hitbox as solid to Samus
$A5:EAAD 8D 86 0F    STA $0F86  [$7E:0F86]  ;/
$A5:EAB0 20 49 EC    JSR $EC49  [$A5:EC49]  ; Update Spore Spawn stalk segment positions
$A5:EAB3 22 D7 83 84 JSL $8483D7[$84:83D7]  ;\
$A5:EAB7             dx  07, 1E, B793       ;} Spawn PLM to clear Spore Spawn ceiling
$A5:EABB 9C E9 07    STZ $07E9  [$7E:07E9]  ; Scrolling finished hook = 0
$A5:EABE 6B          RTL

$A5:EABF AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EAC2 A9 C7 E6    LDA #$E6C7             ;\
$A5:EAC5 8D 92 0F    STA $0F92  [$7E:0F92]  ;} Spore Spawn instruction list pointer = $E6C7
$A5:EAC8 A9 FF FF    LDA #$FFFF             ;\
$A5:EACB 8D 3C 18    STA $183C  [$7E:183C]  ;} Enable global off-screen enemy processing
$A5:EACE AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EAD1 A9 1A EB    LDA #$EB1A             ;\
$A5:EAD4 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy function = RTS
$A5:EAD7 A9 89 95    LDA #$9589             ;\
$A5:EADA 8D E9 07    STA $07E9  [$7E:07E9]  ;} Scrolling finished hook = $9589
$A5:EADD BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A5:EAE0 38          SEC                    ;|
$A5:EAE1 E9 80 00    SBC #$0080             ;} Enemy Y position -= 80h
$A5:EAE4 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A5:EAE7 A9 00 00    LDA #$0000             ;\
$A5:EAEA A0 88 DE    LDY #$DE88             ;} Spawn Spore spawner enemy projectile
$A5:EAED 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EAF1 A9 01 00    LDA #$0001             ;\
$A5:EAF4 A0 88 DE    LDY #$DE88             ;} Spawn Spore spawner enemy projectile
$A5:EAF7 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EAFB A9 02 00    LDA #$0002             ;\
$A5:EAFE A0 88 DE    LDY #$DE88             ;} Spawn Spore spawner enemy projectile
$A5:EB01 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EB05 A9 03 00    LDA #$0003             ;\
$A5:EB08 A0 88 DE    LDY #$DE88             ;} Spawn Spore spawner enemy projectile
$A5:EB0B 22 27 80 86 JSL $868027[$86:8027]  ;/
$A5:EB0F 20 49 EC    JSR $EC49  [$A5:EC49]  ; Update Spore Spawn stalk segment positions
$A5:EB12 6B          RTL
}


;;; $EB13: Main AI - enemy $DF3F/$DF7F (Spore Spawn) ;;;
{
$A5:EB13 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EB16 FC A8 0F    JSR ($0FA8,x)[$A5:EB1A]; Execute [enemy function]
$A5:EB19 6B          RTL
}


;;; $EB1A: RTS ;;;
{
$A5:EB1A 60          RTS
}


;;; $EB1B: Spore Spawn function - descent ;;;
{
$A5:EB1B 20 49 EC    JSR $EC49  [$A5:EC49]  ; Update Spore Spawn stalk segment positions
$A5:EB1E AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EB21 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A5:EB24 18          CLC                    ;|
$A5:EB25 69 01 00    ADC #$0001             ;} Enemy Y position += 1
$A5:EB28 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A5:EB2B C9 70 02    CMP #$0270             ;\
$A5:EB2E 30 0C       BMI $0C    [$EB3C]     ;} If [enemy Y position] >= 270h:
$A5:EB30 A9 D5 E6    LDA #$E6D5             ;\
$A5:EB33 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $E6D5
$A5:EB36 A9 01 00    LDA #$0001             ;\
$A5:EB39 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1

$A5:EB3C A9 30 00    LDA #$0030             ;\
$A5:EB3F 8F 16 78 7E STA $7E7816[$7E:7816]  ;} Spore Spawn speed = 30h
$A5:EB43 A9 01 00    LDA #$0001             ;\
$A5:EB46 8F 18 78 7E STA $7E7818[$7E:7818]  ;} Spore Spawn angle delta = 1
$A5:EB4A A9 C0 00    LDA #$00C0             ;\
$A5:EB4D 8F 14 78 7E STA $7E7814[$7E:7814]  ;} Spore Spawn angle = C0h
$A5:EB51 60          RTS
}


;;; $EB52: Spore Spawn function - moving ;;;
{
$A5:EB52 20 49 EC    JSR $EC49  [$A5:EC49]  ; Update Spore Spawn stalk segment positions
$A5:EB55 AF 16 78 7E LDA $7E7816[$7E:7816]  ;\
$A5:EB59 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:EB5C AF 14 78 7E LDA $7E7814[$7E:7814]  ;|
$A5:EB60 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]  ;} Enemy X position = [enemy X origin] + [Spore Spawn speed] * cos([Spore Spawn angle] * pi / 80h) * FFh / 100h
$A5:EB64 18          CLC                    ;|
$A5:EB65 7D AC 0F    ADC $0FAC,x[$7E:0FAC]  ;|
$A5:EB68 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;/
$A5:EB6B AF 16 78 7E LDA $7E7816[$7E:7816]  ;\
$A5:EB6F 38          SEC                    ;|
$A5:EB70 E9 10 00    SBC #$0010             ;|
$A5:EB73 8D 32 0E    STA $0E32  [$7E:0E32]  ;|
$A5:EB76 AF 14 78 7E LDA $7E7814[$7E:7814]  ;|
$A5:EB7A 38          SEC                    ;} Enemy Y position = [enemy Y origin] + ([Spore Spawn speed] - 10h) * sin([Spore Spawn angle] * 2 * pi / 80h) * FFh / 100h
$A5:EB7B E9 40 00    SBC #$0040             ;|
$A5:EB7E 0A          ASL A                  ;|
$A5:EB7F 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]  ;|
$A5:EB83 18          CLC                    ;|
$A5:EB84 7D AE 0F    ADC $0FAE,x[$7E:0FAE]  ;|
$A5:EB87 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A5:EB8A AF 14 78 7E LDA $7E7814[$7E:7814]  ;\
$A5:EB8E 18          CLC                    ;|
$A5:EB8F 6F 18 78 7E ADC $7E7818[$7E:7818]  ;} Spore Spawn angle = ([Spore Spawn angle] + [Spore Spawn angle delta]) % 100h
$A5:EB93 29 FF 00    AND #$00FF             ;|
$A5:EB96 8F 14 78 7E STA $7E7814[$7E:7814]  ;/
$A5:EB9A 60          RTS
}


;;; $EB9B: Spore Spawn function - set up death ;;;
{
$A5:EB9B AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EB9E A9 80 00    LDA #$0080
$A5:EBA1 38          SEC
$A5:EBA2 ED 7A 0F    SBC $0F7A  [$7E:0F7A]
$A5:EBA5 85 12       STA $12    [$7E:0012]
$A5:EBA7 A9 70 02    LDA #$0270
$A5:EBAA 38          SEC
$A5:EBAB ED 7E 0F    SBC $0F7E  [$7E:0F7E]
$A5:EBAE 85 14       STA $14    [$7E:0014]
$A5:EBB0 22 AE C0 A0 JSL $A0C0AE[$A0:C0AE]
$A5:EBB4 38          SEC
$A5:EBB5 E9 40 00    SBC #$0040
$A5:EBB8 49 FF FF    EOR #$FFFF
$A5:EBBB 1A          INC A
$A5:EBBC 29 FF 00    AND #$00FF
$A5:EBBF 8F 06 88 7E STA $7E8806[$7E:8806]
$A5:EBC3 A9 01 00    LDA #$0001
$A5:EBC6 85 14       STA $14    [$7E:0014]
$A5:EBC8 AF 06 88 7E LDA $7E8806[$7E:8806]
$A5:EBCC 29 FF 00    AND #$00FF
$A5:EBCF 85 12       STA $12    [$7E:0012]
$A5:EBD1 22 43 B6 A0 JSL $A0B643[$A0:B643]
$A5:EBD5 A5 16       LDA $16    [$7E:0016]
$A5:EBD7 9F 10 80 7E STA $7E8010,x[$7E:8010]
$A5:EBDB A5 18       LDA $18    [$7E:0018]
$A5:EBDD 9F 12 80 7E STA $7E8012,x[$7E:8012]
$A5:EBE1 A5 1A       LDA $1A    [$7E:001A]
$A5:EBE3 9F 14 80 7E STA $7E8014,x[$7E:8014]
$A5:EBE7 A5 1C       LDA $1C    [$7E:001C]
$A5:EBE9 9F 16 80 7E STA $7E8016,x[$7E:8016]
$A5:EBED 60          RTS
}


;;; $EBEE: Spore Spawn function - dying ;;;
{
$A5:EBEE AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EBF1 BF 10 80 7E LDA $7E8010,x[$7E:8010]
$A5:EBF5 8D 24 0E    STA $0E24  [$7E:0E24]
$A5:EBF8 BF 12 80 7E LDA $7E8012,x[$7E:8012]
$A5:EBFC 8D 26 0E    STA $0E26  [$7E:0E26]
$A5:EBFF BF 14 80 7E LDA $7E8014,x[$7E:8014]
$A5:EC03 8D 28 0E    STA $0E28  [$7E:0E28]
$A5:EC06 BF 16 80 7E LDA $7E8016,x[$7E:8016]
$A5:EC0A 8D 2A 0E    STA $0E2A  [$7E:0E2A]
$A5:EC0D AF 06 88 7E LDA $7E8806[$7E:8806]
$A5:EC11 29 FF 00    AND #$00FF
$A5:EC14 8D 20 0E    STA $0E20  [$7E:0E20]
$A5:EC17 22 91 B6 A0 JSL $A0B691[$A0:B691]
$A5:EC1B AD 7A 0F    LDA $0F7A  [$7E:0F7A]
$A5:EC1E 38          SEC
$A5:EC1F E9 80 00    SBC #$0080
$A5:EC22 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A5:EC26 C9 08 00    CMP #$0008
$A5:EC29 10 16       BPL $16    [$EC41]
$A5:EC2B AD 7E 0F    LDA $0F7E  [$7E:0F7E]
$A5:EC2E 38          SEC
$A5:EC2F E9 70 02    SBC #$0270
$A5:EC32 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A5:EC36 C9 08 00    CMP #$0008
$A5:EC39 10 06       BPL $06    [$EC41]
$A5:EC3B A9 1A EB    LDA #$EB1A
$A5:EC3E 8D A8 0F    STA $0FA8  [$7E:0FA8]

$A5:EC41 20 49 EC    JSR $EC49  [$A5:EC49]  ; Update Spore Spawn stalk segment positions
$A5:EC44 22 F5 E9 A5 JSL $A5E9F5[$A5:E9F5]  ; Spawn random Spore Spawn death explosion
$A5:EC48 60          RTS
}


;;; $EC49: Update Spore Spawn stalk segment positions ;;;
{
$A5:EC49 AD 7A 0F    LDA $0F7A  [$7E:0F7A]  ;\
$A5:EC4C 38          SEC                    ;} A = [Spore Spawn X position] - [Spore Spawn stalk X origin]
$A5:EC4D EF 08 78 7E SBC $7E7808[$7E:7808]  ;/
$A5:EC51 10 41       BPL $41    [$EC94]     ; If [A] < 0:
$A5:EC53 49 FF FF    EOR #$FFFF             ;\
$A5:EC56 1A          INC A                  ;} Negate A
$A5:EC57 4A          LSR A                  ;\
$A5:EC58 85 12       STA $12    [$7E:0012]  ;} $12 = [A] * 2/4
$A5:EC5A 4A          LSR A                  ;\
$A5:EC5B 85 14       STA $14    [$7E:0014]  ;} $14 = [A] * 1/4
$A5:EC5D 18          CLC                    ;\
$A5:EC5E 65 12       ADC $12    [$7E:0012]  ;} $16 = [A] * 3/4
$A5:EC60 85 16       STA $16    [$7E:0016]  ;/
$A5:EC62 A9 80 00    LDA #$0080             ;\
$A5:EC65 8D 67 1A    STA $1A67  [$7E:1A67]  ;} Spore Spawn stalk segment 3 X position = 80h
$A5:EC68 AF 08 78 7E LDA $7E7808[$7E:7808]  ;\
$A5:EC6C 38          SEC                    ;|
$A5:EC6D E5 14       SBC $14    [$7E:0014]  ;} Spore Spawn stalk segment 2 X position = [Spore Spawn stalk X origin] - [$14]
$A5:EC6F 8D 69 1A    STA $1A69  [$7E:1A69]  ;/
$A5:EC72 8F 00 80 7E STA $7E8000[$7E:8000]  ; $7E:8000 = [Spore Spawn stalk segment 2 X position]
$A5:EC76 AF 08 78 7E LDA $7E7808[$7E:7808]  ;\
$A5:EC7A 38          SEC                    ;|
$A5:EC7B E5 12       SBC $12    [$7E:0012]  ;} Spore Spawn stalk segment 1 X position = [Spore Spawn stalk X origin] - [$12]
$A5:EC7D 8D 6B 1A    STA $1A6B  [$7E:1A6B]  ;/
$A5:EC80 8F 02 80 7E STA $7E8002[$7E:8002]  ; $7E:8002 = [Spore Spawn stalk segment 1 X position]
$A5:EC84 AF 08 78 7E LDA $7E7808[$7E:7808]  ;\
$A5:EC88 38          SEC                    ;|
$A5:EC89 E5 16       SBC $16    [$7E:0016]  ;} Spore Spawn stalk segment 0 X position = [Spore Spawn stalk X origin] - [$16]
$A5:EC8B 8D 6D 1A    STA $1A6D  [$7E:1A6D]  ;/
$A5:EC8E 8F 04 80 7E STA $7E8004[$7E:8004]  ; $7E:8004 = [Spore Spawn stalk segment 0 X position]
$A5:EC92 80 3B       BRA $3B    [$ECCF]

$A5:EC94 4A          LSR A                  ;\ Else ([A] >= 0):
$A5:EC95 85 12       STA $12    [$7E:0012]  ;} $12 = [A] * 2/4
$A5:EC97 4A          LSR A                  ;\
$A5:EC98 85 14       STA $14    [$7E:0014]  ;} $14 = [A] * 1/4
$A5:EC9A 18          CLC                    ;\
$A5:EC9B 65 12       ADC $12    [$7E:0012]  ;} $16 = [A] * 3/4
$A5:EC9D 85 16       STA $16    [$7E:0016]  ;/
$A5:EC9F A9 80 00    LDA #$0080             ;\
$A5:ECA2 8D 67 1A    STA $1A67  [$7E:1A67]  ;} Spore Spawn stalk segment 3 X position = 80h
$A5:ECA5 A5 14       LDA $14    [$7E:0014]  ;\
$A5:ECA7 18          CLC                    ;|
$A5:ECA8 6F 08 78 7E ADC $7E7808[$7E:7808]  ;} Spore Spawn stalk segment 2 X position = [Spore Spawn stalk X origin] + [$14]
$A5:ECAC 8D 69 1A    STA $1A69  [$7E:1A69]  ;/
$A5:ECAF 8F 00 80 7E STA $7E8000[$7E:8000]  ; $7E:8000 = [Spore Spawn stalk segment 2 X position]
$A5:ECB3 A5 12       LDA $12    [$7E:0012]  ;\
$A5:ECB5 18          CLC                    ;|
$A5:ECB6 6F 08 78 7E ADC $7E7808[$7E:7808]  ;} Spore Spawn stalk segment 1 X position = [Spore Spawn stalk X origin] + [$12]
$A5:ECBA 8D 6B 1A    STA $1A6B  [$7E:1A6B]  ;/
$A5:ECBD 8F 02 80 7E STA $7E8002[$7E:8002]  ; $7E:8002 = [Spore Spawn stalk segment 1 X position]
$A5:ECC1 A5 16       LDA $16    [$7E:0016]  ;\
$A5:ECC3 18          CLC                    ;|
$A5:ECC4 6F 08 78 7E ADC $7E7808[$7E:7808]  ;} Spore Spawn stalk segment 0 X position = [Spore Spawn stalk X origin] + [$16]
$A5:ECC8 8D 6D 1A    STA $1A6D  [$7E:1A6D]  ;/
$A5:ECCB 8F 04 80 7E STA $7E8004[$7E:8004]  ; $7E:8004 = [Spore Spawn stalk segment 0 X position]

$A5:ECCF AD 7E 0F    LDA $0F7E  [$7E:0F7E]  ;\
$A5:ECD2 38          SEC                    ;|
$A5:ECD3 E9 28 00    SBC #$0028             ;} A = [Spore Spawn Y position] - 28h - [$7E:780A]
$A5:ECD6 38          SEC                    ;|
$A5:ECD7 EF 0A 78 7E SBC $7E780A[$7E:780A]  ;/
$A5:ECDB 10 41       BPL $41    [$ED1E]     ; If [A] < 0:
$A5:ECDD 49 FF FF    EOR #$FFFF             ;\
$A5:ECE0 1A          INC A                  ;} Negate A
$A5:ECE1 4A          LSR A                  ;\
$A5:ECE2 85 12       STA $12    [$7E:0012]  ;} $12 = [A] * 2/4
$A5:ECE4 4A          LSR A                  ;\
$A5:ECE5 85 14       STA $14    [$7E:0014]  ;} $14 = [A] * 1/4
$A5:ECE7 18          CLC                    ;\
$A5:ECE8 65 12       ADC $12    [$7E:0012]  ;} $16 = [A] * 3/4
$A5:ECEA 85 16       STA $16    [$7E:0016]  ;/
$A5:ECEC A9 30 02    LDA #$0230             ;\
$A5:ECEF 8D AF 1A    STA $1AAF  [$7E:1AAF]  ;} Spore Spawn stalk segment 3 Y position = 80h
$A5:ECF2 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A5:ECF6 38          SEC                    ;|
$A5:ECF7 E5 14       SBC $14    [$7E:0014]  ;} Spore Spawn stalk segment 2 Y position = [Spore Spawn stalk Y origin] - [$14]
$A5:ECF9 8D B1 1A    STA $1AB1  [$7E:1AB1]  ;/
$A5:ECFC 8F 06 80 7E STA $7E8006[$7E:8006]  ; $7E:8000 = [Spore Spawn stalk segment 2 Y position]
$A5:ED00 AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A5:ED04 38          SEC                    ;|
$A5:ED05 E5 12       SBC $12    [$7E:0012]  ;} Spore Spawn stalk segment 1 Y position = [Spore Spawn stalk Y origin] - [$12]
$A5:ED07 8D B3 1A    STA $1AB3  [$7E:1AB3]  ;/
$A5:ED0A 8F 08 80 7E STA $7E8008[$7E:8008]  ; $7E:8002 = [Spore Spawn stalk segment 1 Y position]
$A5:ED0E AF 0A 78 7E LDA $7E780A[$7E:780A]  ;\
$A5:ED12 38          SEC                    ;|
$A5:ED13 E5 16       SBC $16    [$7E:0016]  ;} Spore Spawn stalk segment 0 Y position = [Spore Spawn stalk Y origin] - [$16]
$A5:ED15 8D B5 1A    STA $1AB5  [$7E:1AB5]  ;/
$A5:ED18 8F 0A 80 7E STA $7E800A[$7E:800A]  ; $7E:8004 = [Spore Spawn stalk segment 0 Y position]
$A5:ED1C 80 3B       BRA $3B    [$ED59]

$A5:ED1E 4A          LSR A                  ;\ Else ([A] >= 0):
$A5:ED1F 85 12       STA $12    [$7E:0012]  ;} $12 = [A] * 2/4
$A5:ED21 4A          LSR A                  ;\
$A5:ED22 85 14       STA $14    [$7E:0014]  ;} $14 = [A] * 1/4
$A5:ED24 18          CLC                    ;\
$A5:ED25 65 12       ADC $12    [$7E:0012]  ;} $16 = [A] * 3/4
$A5:ED27 85 16       STA $16    [$7E:0016]  ;/
$A5:ED29 A9 30 02    LDA #$0230             ;\
$A5:ED2C 8D AF 1A    STA $1AAF  [$7E:1AAF]  ;} Spore Spawn stalk segment 3 Y position = 80h
$A5:ED2F A5 14       LDA $14    [$7E:0014]  ;\
$A5:ED31 18          CLC                    ;|
$A5:ED32 6F 0A 78 7E ADC $7E780A[$7E:780A]  ;} Spore Spawn stalk segment 2 Y position = [Spore Spawn stalk Y origin] - [$14]
$A5:ED36 8D B1 1A    STA $1AB1  [$7E:1AB1]  ;/
$A5:ED39 8F 06 80 7E STA $7E8006[$7E:8006]  ; $7E:8000 = [Spore Spawn stalk segment 2 Y position]
$A5:ED3D A5 12       LDA $12    [$7E:0012]  ;\
$A5:ED3F 18          CLC                    ;|
$A5:ED40 6F 0A 78 7E ADC $7E780A[$7E:780A]  ;} Spore Spawn stalk segment 1 Y position = [Spore Spawn stalk Y origin] - [$12]
$A5:ED44 8D B3 1A    STA $1AB3  [$7E:1AB3]  ;/
$A5:ED47 8F 08 80 7E STA $7E8008[$7E:8008]  ; $7E:8002 = [Spore Spawn stalk segment 1 Y position]
$A5:ED4B A5 16       LDA $16    [$7E:0016]  ;\
$A5:ED4D 18          CLC                    ;|
$A5:ED4E 6F 0A 78 7E ADC $7E780A[$7E:780A]  ;} Spore Spawn stalk segment 0 Y position = [Spore Spawn stalk Y origin] - [$16]
$A5:ED52 8D B5 1A    STA $1AB5  [$7E:1AB5]  ;/
$A5:ED55 8F 0A 80 7E STA $7E800A[$7E:800A]  ; $7E:8004 = [Spore Spawn stalk segment 0 Y position]

$A5:ED59 60          RTS
}


;;; $ED5A:  ;;;
{
$A5:ED5A AD A6 18    LDA $18A6  [$7E:18A6]
$A5:ED5D 0A          ASL A
$A5:ED5E AA          TAX
$A5:ED5F BD 18 0C    LDA $0C18,x[$7E:0C18]
$A5:ED62 89 00 07    BIT #$0700
$A5:ED65 D0 06       BNE $06    [$ED6D]
$A5:ED67 89 10 00    BIT #$0010
$A5:ED6A D0 01       BNE $01    [$ED6D]
$A5:ED6C 6B          RTL

$A5:ED6D 22 B4 A6 A0 JSL $A0A6B4[$A0:A6B4]
$A5:ED71 BD 9C 0F    LDA $0F9C,x[$7E:0F9C]
$A5:ED74 F0 74       BEQ $74    [$EDEA]
$A5:ED76 A9 52 EB    LDA #$EB52
$A5:ED79 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A5:ED7C A0 02 00    LDY #$0002
$A5:ED7F BD 8C 0F    LDA $0F8C,x[$7E:0F8C]
$A5:ED82 C9 90 01    CMP #$0190
$A5:ED85 10 11       BPL $11    [$ED98]
$A5:ED87 AF 18 78 7E LDA $7E7818[$7E:7818]
$A5:ED8B 10 06       BPL $06    [$ED93]
$A5:ED8D 98          TYA
$A5:ED8E 49 FF FF    EOR #$FFFF
$A5:ED91 1A          INC A
$A5:ED92 A8          TAY

$A5:ED93 98          TYA
$A5:ED94 8F 18 78 7E STA $7E7818[$7E:7818]

$A5:ED98 AF 1E 80 7E LDA $7E801E[$7E:801E]
$A5:ED9C D0 4C       BNE $4C    [$EDEA]
$A5:ED9E AF 18 78 7E LDA $7E7818[$7E:7818]
$A5:EDA2 49 FF FF    EOR #$FFFF
$A5:EDA5 1A          INC A
$A5:EDA6 8F 18 78 7E STA $7E7818[$7E:7818]
$A5:EDAA A9 01 00    LDA #$0001
$A5:EDAD 8F 1E 80 7E STA $7E801E[$7E:801E]
$A5:EDB1 A9 29 E7    LDA #$E729
$A5:EDB4 9D 92 0F    STA $0F92,x[$7E:0F92]
$A5:EDB7 A9 01 00    LDA #$0001
$A5:EDBA 9D 94 0F    STA $0F94,x[$7E:0F94]
$A5:EDBD A0 60 00    LDY #$0060
$A5:EDC0 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]
$A5:EDC3 C9 46 00    CMP #$0046
$A5:EDC6 30 13       BMI $13    [$EDDB]
$A5:EDC8 A0 40 00    LDY #$0040
$A5:EDCB C9 9A 01    CMP #$019A
$A5:EDCE 30 0B       BMI $0B    [$EDDB]
$A5:EDD0 A0 20 00    LDY #$0020
$A5:EDD3 C9 02 03    CMP #$0302
$A5:EDD6 30 03       BMI $03    [$EDDB]
$A5:EDD8 A0 00 00    LDY #$0000

$A5:EDDB CF 00 88 7E CMP $7E8800[$7E:8800]
$A5:EDDF F0 09       BEQ $09    [$EDEA]
$A5:EDE1 8F 00 88 7E STA $7E8800[$7E:8800]
$A5:EDE5 98          TYA
$A5:EDE6 22 4A EE A5 JSL $A5EE4A[$A5:EE4A]
}


;;; $EDEA: Enemy shot - enemy $DF3F/$DF7F (Spore Spawn) ;;;
{
$A5:EDEA 80 07       BRA $07    [$EDF3]     ; Go to Spore Spawn reaction
}


;;; $EDEC: Enemy touch - enemy $DF3F/$DF7F (Spore Spawn) ;;;
{
$A5:EDEC 22 97 A4 A0 JSL $A0A497[$A0:A497]  ; Normal touch AI, but skips death animation
$A5:EDF0 80 01       BRA $01    [$EDF3]     ; Go to Spore Spawn reaction
}


;;; $EDF2: RTL. Power bomb reaction - enemy $DF3F (Spore Spawn) ;;;
{
$A5:EDF2 6B          RTL
}


;;; $EDF3: Spore Spawn reaction ;;;
{
$A5:EDF3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EDF6 BD 8C 0F    LDA $0F8C,x[$7E:0F8C]
$A5:EDF9 D0 4E       BNE $4E    [$EE49]
$A5:EDFB AE 54 0E    LDX $0E54  [$7E:0E54]
$A5:EDFE A9 00 00    LDA #$0000
$A5:EE01 8F 1C 78 7E STA $7E781C[$7E:781C]
$A5:EE05 9E A0 0F    STZ $0FA0,x[$7E:0FA0]
$A5:EE08 9E 9C 0F    STZ $0F9C,x[$7E:0F9C]
$A5:EE0B 9E 8A 0F    STZ $0F8A,x[$7E:0F8A]
$A5:EE0E BD 86 0F    LDA $0F86,x[$7E:0F86]
$A5:EE11 09 00 04    ORA #$0400
$A5:EE14 9D 86 0F    STA $0F86,x[$7E:0F86]
$A5:EE17 A0 1A 00    LDY #$001A
$A5:EE1A A9 00 00    LDA #$0000

$A5:EE1D 99 97 19    STA $1997,y[$7E:19B1]
$A5:EE20 88          DEY
$A5:EE21 88          DEY
$A5:EE22 10 F9       BPL $F9    [$EE1D]
$A5:EE24 A9 7D E7    LDA #$E77D
$A5:EE27 8D 92 0F    STA $0F92  [$7E:0F92]
$A5:EE2A A9 01 00    LDA #$0001
$A5:EE2D 8D 94 0F    STA $0F94  [$7E:0F94]
$A5:EE30 AE 9F 07    LDX $079F  [$7E:079F]
$A5:EE33 BF 28 D8 7E LDA $7ED828,x[$7E:D829]
$A5:EE37 09 02 00    ORA #$0002
$A5:EE3A 9F 28 D8 7E STA $7ED828,x[$7E:D829]
$A5:EE3E 9C E9 07    STZ $07E9  [$7E:07E9]  ; Scrolling finished hook = 0
$A5:EE41 22 D7 83 84 JSL $8483D7[$84:83D7]
$A5:EE45             dx 07, 1E, B78F

$A5:EE49 6B          RTL
}


;;; $EE4A:  ;;;
{
$A5:EE4A 5A          PHY
$A5:EE4B DA          PHX
$A5:EE4C 85 12       STA $12    [$7E:0012]
$A5:EE4E A8          TAY
$A5:EE4F A2 00 00    LDX #$0000

$A5:EE52 B9 79 E3    LDA $E379,y
$A5:EE55 9F 20 C1 7E STA $7EC120,x
$A5:EE59 C8          INY
$A5:EE5A C8          INY
$A5:EE5B E8          INX
$A5:EE5C E8          INX
$A5:EE5D E0 20 00    CPX #$0020
$A5:EE60 D0 F0       BNE $F0    [$EE52]
$A5:EE62 FA          PLX
$A5:EE63 7A          PLY
$A5:EE64 6B          RTL
}


;;; $EE65: Spore Spawn extended spritemaps ;;;
{
; Dead
$A5:EE65             dx 0001, 0000,0000,F20D,EF73

; Closed / closing / opening
$A5:EE6F             dx 0001, 0000,0000,F20D,EF8D
$A5:EE79             dx 0002, 0000,0000,F291,EFA7, 0000,0000,F7C1,F139
$A5:EE8B             dx 0002, 0000,0000,F329,EFC1, 0000,0000,F7E1,F147
$A5:EE9D             dx 0002, 0000,0000,F3D5,EFF3, 0000,0000,F801,F155
$A5:EEAF             dx 0002, 0000,0000,F481,F025, 0000,0000,F7E1,F147
$A5:EEC1             dx 0002, 0000,0000,F52D,F057, 0000,0000,F7C1,F139
$A5:EED3             dx 0002, 0000,0000,F852,F1A9, 0000,0000,F7E1,F147
$A5:EEE5             dx 0002, 0000,0000,F8D6,F1DB, 0000,0000,F801,F155

; Unused
$A5:EEF7             dx 0001, 0000,0000,F828,F171
$A5:EF01             dx 0001, 0000,0000,F82F,F17F
$A5:EF0B             dx 0001, 0000,0000,F836,F18D
$A5:EF15             dx 0001, 0000,0000,F83D,F19B
$A5:EF1F             dx 0001, 0000,0000,F844,F1A9
$A5:EF29             dx 0001, 0000,0000,F84B,F1A9
$A5:EF33             dx 0001, 0000,0000,F821,F163

; Fully open
$A5:EF3D             dx 0002, 0000,0000,F8D6,F1DB, 0000,0000,F7C1,F139
$A5:EF4F             dx 0002, 0000,0000,F8D6,F1DB, 0000,0000,F7E1,F147
$A5:EF61             dx 0002, 0000,0000,F8D6,F1DB, 0000,0000,F801,F155
}


;;; $EF73: Spore Spawn hitboxes ;;;
{
$A5:EF73             dx 0002, FFD7,FFE2,0029,001E,804C,8046, FFF0,FFD3,000F,FFE2,804C,8046
$A5:EF8D             dx 0002, FFD7,FFE2,0029,001E,EDEC,8046, FFF0,FFD3,000F,FFE2,EDEC,8046
$A5:EFA7             dx 0002, FFD4,FFDD,002B,0021,EDEC,8046, FFF0,FFCF,000F,FFDD,EDEC,8046
$A5:EFC1             dx 0004, FFD3,FFDA,002C,FFF7,EDEC,8046, FFD3,0008,002C,0023,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFCA,0010,FFEA,EDEC,8046
$A5:EFF3             dx 0004, FFD5,FFD4,002A,FFF3,EDEC,8046, FFD4,000C,002A,002A,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFC6,0010,FFD6,EDEC,8046
$A5:F025             dx 0004, FFD3,FFD1,002C,FFEF,EDEC,8046, FFD4,0010,002B,002E,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFC2,0010,FFD3,EDEC,8046
$A5:F057             dx 0004, FFD4,FFCE,002D,FFEB,EDEC,8046, FFD5,0014,002B,0032,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFC0,0010,FFD0,EDEC,8046
$A5:F089             dx 0002, FFD2,FFDD,002C,0023,EDEC,8046, FFF0,FFD0,0010,FFE0,EDEC,8046
$A5:F0A3             dx 0004, FFD3,FFD9,002D,FFF7,EDEC,8046, FFD4,0008,002C,0026,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFCA,0010,FFE0,EDEC,8046
$A5:F0D5             dx 0004, FFD3,FFD4,002D,FFF3,EDEC,8046, FFD6,000C,002A,002B,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFC6,0010,FFE0,EDEC,8046
$A5:F107             dx 0004, FFD4,FFD1,0029,FFEF,EDEC,8046, FFD4,0010,002C,002D,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFC3,0010,FFD2,EDEC,8046
$A5:F139             dx 0001, FFF1,FFE8,000E,0017,EDEC,ED5A
$A5:F147             dx 0001, FFF1,FFE8,000E,0017,EDEC,ED5A
$A5:F155             dx 0001, FFF1,FFE8,000E,0017,EDEC,8046
$A5:F163             dx 0001, FFF8,FFF8,0007,0007,EDEC,8046
$A5:F171             dx 0001, FFF8,FFF8,0007,0006,EDEC,8046
$A5:F17F             dx 0001, FFF8,FFF8,0007,0006,EDEC,8046
$A5:F18D             dx 0001, FFF8,FFF8,0007,0006,EDEC,ED5A
$A5:F19B             dx 0001, FFFC,FFFC,0003,0003,EDEC,ED5A
$A5:F1A9             dx 0004, FFD4,FFCB,002C,FFE9,EDEC,8046, FFD4,0016,002B,0034,EDEC,8046, FFF1,FFE8,000E,0017,EDEC,ED5A, FFF0,FFBC,0010,FFD0,EDEC,8046
$A5:F1DB             dx 0004, FFD4,FFC9,002B,FFE7,EDEC,8046, FFD3,0018,002B,0037,EDEC,8046, FFF1,FFE7,000E,0018,EDEC,ED5A, FFF0,FFBB,0010,FFD0,EDEC,8046
}


;;; $F20D: Spore Spawn spritemaps ;;;
{
$A5:F20D             dx 001A, 8000,F0,6124, 8010,F0,6122, 8020,F0,6120, 8000,E0,6104, 8010,E0,6102, 8020,E0,6100, 81F0,F0,2124, 81E0,F0,2122, 81D0,F0,2120, 81F0,E0,2104, 81E0,E0,2102, 81D0,E0,2100, 8000,D2,6142, 81F0,D2,2142, 8000,10,614E, 8010,10,614C, 8020,10,614A, 8000,00,6148, 8010,00,6146, 8020,00,6144, 81F0,10,214E, 81E0,10,214C, 81D0,10,214A, 81F0,00,2148, 81E0,00,2146, 81D0,00,2144
$A5:F291             dx 001E, 8000,EC,6124, 8010,EC,6122, 8020,EC,6120, 8000,DC,6104, 8010,DC,6102, 8020,DC,6100, 81F0,EC,2124, 81E0,EC,2122, 81D0,EC,2120, 81F0,DC,2104, 81E0,DC,2102, 81D0,DC,2100, 8000,CE,6142, 81F0,CE,2142, 8000,14,614E, 8010,14,614C, 8020,14,614A, 8000,04,6148, 8010,04,6146, 8020,04,6144, 81F0,14,214E, 81E0,14,214C, 81D0,14,214A, 81F0,04,2148, 81E0,04,2146, 81D0,04,2144, 0010,FC,613F, 0024,FC,613F, 01D4,FC,213F, 01E8,FC,213F
$A5:F329             dx 0022, 8000,E8,6124, 8010,E8,6122, 8020,E8,6120, 8000,D8,6104, 8010,D8,6102, 8020,D8,6100, 81F0,E8,2124, 81E0,E8,2122, 81D0,E8,2120, 81F0,D8,2104, 81E0,D8,2102, 81D0,D8,2100, 8000,CA,6142, 81F0,CA,2142, 0024,00,6161, 000E,00,6161, 01EA,00,2161, 01D5,00,2161, 0024,F8,6160, 000E,F8,6160, 01EA,F8,2160, 01D5,F8,2160, 8000,18,614E, 8010,18,614C, 8020,18,614A, 8000,08,6148, 8010,08,6146, 8020,08,6144, 81F0,18,214E, 81E0,18,214C, 81D0,18,214A, 81F0,08,2148, 81E0,08,2146, 81D0,08,2144
$A5:F3D5             dx 0022, 8000,E4,6124, 8010,E4,6122, 8020,E4,6120, 8000,D4,6104, 8010,D4,6102, 8020,D4,6100, 81F0,E4,2124, 81E0,E4,2122, 81D0,E4,2120, 81F0,D4,2104, 81E0,D4,2102, 81D0,D4,2100, 8000,C6,6142, 81F0,C6,2142, 0020,04,6163, 000C,04,6163, 01EC,04,2163, 01D8,04,2163, 0020,F4,6162, 000C,F4,6162, 01EC,F4,2162, 01D8,F4,2162, 8000,1C,614E, 8010,1C,614C, 8020,1C,614A, 8000,0C,6148, 8010,0C,6146, 8020,0C,6144, 81F0,1C,214E, 81E0,1C,214C, 81D0,1C,214A, 81F0,0C,2148, 81E0,0C,2146, 81D0,0C,2144
$A5:F481             dx 0022, 8000,D0,6104, 8010,D0,6102, 8020,D0,6100, 81F0,D0,2104, 81E0,D0,2102, 81D0,D0,2100, 8000,E0,6124, 8010,E0,6122, 8020,E0,6120, 81F0,E0,2124, 81E0,E0,2122, 81D0,E0,2120, 8000,C2,6142, 81F0,C2,2142, 001F,08,6165, 000B,08,6165, 01ED,08,2165, 01D9,08,2165, 001F,F0,6164, 000B,F0,6164, 01ED,F0,2164, 01D9,F0,2164, 8000,20,614E, 8010,20,614C, 8020,20,614A, 8000,10,6148, 8010,10,6146, 8020,10,6144, 81F0,20,214E, 81E0,20,214C, 81D0,20,214A, 81F0,10,2148, 81E0,10,2146, 81D0,10,2144
$A5:F52D             dx 001A, 8000,CC,6104, 8010,CC,6102, 8020,CC,6100, 81F0,CC,2104, 81E0,CC,2102, 81D0,CC,2100, 8000,BE,6142, 81F0,BE,2142, 8000,24,614E, 8010,24,614C, 8020,24,614A, 8000,14,6148, 8010,14,6146, 8020,14,6144, 81F0,24,214E, 81E0,24,214C, 81D0,24,214A, 81F0,14,2148, 81E0,14,2146, 81D0,14,2144, 8000,DC,6124, 8010,DC,6122, 8020,DC,6120, 81F0,DC,2124, 81E0,DC,2122, 81D0,DC,2120
$A5:F5B1             dx 001A, 8000,DC,6104, 8010,DC,6102, 8020,DC,6100, 81F0,DC,2104, 81E0,DC,2102, 81D0,DC,2100, 8000,CE,6142, 81F0,CE,2142, 8000,14,614E, 8010,14,614C, 8020,14,614A, 8000,04,6148, 8010,04,6146, 8020,04,6144, 81F0,14,214E, 81E0,14,214C, 81D0,14,214A, 81F0,04,2148, 81E0,04,2146, 81D0,04,2144, 8000,EC,6124, 8010,EC,6122, 8020,EC,6120, 81F0,EC,2124, 81E0,EC,2122, 81D0,EC,2120
$A5:F635             dx 001A, 8000,D8,6104, 8010,D8,6102, 8020,D8,6100, 81F0,D8,2104, 81E0,D8,2102, 81D0,D8,2100, 8000,CA,6142, 81F0,CA,2142, 8000,18,614E, 8010,18,614C, 8020,18,614A, 8000,08,6148, 8010,08,6146, 8020,08,6144, 81F0,18,214E, 81E0,18,214C, 81D0,18,214A, 81F0,08,2148, 81E0,08,2146, 81D0,08,2144, 8000,E8,6124, 8010,E8,6122, 8020,E8,6120, 81F0,E8,2124, 81E0,E8,2122, 81D0,E8,2120
$A5:F6B9             dx 001A, 8000,E4,6124, 8010,E4,6122, 8020,E4,6120, 8000,D4,6104, 8010,D4,6102, 8020,D4,6100, 81F0,E4,2124, 81E0,E4,2122, 81D0,E4,2120, 81F0,D4,2104, 81E0,D4,2102, 81D0,D4,2100, 8000,C6,6142, 81F0,C6,2142, 8000,1C,614E, 8010,1C,614C, 8020,1C,614A, 8000,0C,6148, 8010,0C,6146, 8020,0C,6144, 81F0,1C,214E, 81E0,1C,214C, 81D0,1C,214A, 81F0,0C,2148, 81E0,0C,2146, 81D0,0C,2144
$A5:F73D             dx 001A, 8000,E0,6124, 8010,E0,6122, 8020,E0,6120, 8000,D0,6104, 8010,D0,6102, 8020,D0,6100, 81F0,E0,2124, 81E0,E0,2122, 81D0,E0,2120, 81F0,D0,2104, 81E0,D0,2102, 81D0,D0,2100, 8000,C2,6142, 81F0,C2,2142, 8000,20,614E, 8010,20,614C, 8020,20,614A, 8000,10,6148, 8010,10,6146, 8020,10,6144, 81F0,20,214E, 81E0,20,214C, 81D0,20,214A, 81F0,10,2148, 81E0,10,2146, 81D0,10,2144
$A5:F7C1             dx 0006, 8000,F8,6106, 81F0,F8,2106, 8000,E8,E126, 8000,08,6126, 81F0,E8,A126, 81F0,08,2126
$A5:F7E1             dx 0006, 8000,F8,6108, 81F0,F8,2108, 8000,E8,E128, 81F0,E8,A128, 8000,08,6128, 81F0,08,2128
$A5:F801             dx 0006, 8000,F8,610A, 81F0,F8,210A, 8000,E8,E12A, 81F0,E8,A12A, 8000,08,612A, 81F0,08,212A
$A5:F821             dx 0001, 81F8,F8,2140
$A5:F828             dx 0001, 81F8,F8,210C
$A5:F82F             dx 0001, 81F8,F8,210E
$A5:F836             dx 0001, 81F8,F8,212C
$A5:F83D             dx 0001, 01FC,FC,213E
$A5:F844             dx 0001, 01FC,FC,212F
$A5:F84B             dx 0001, 01FC,FC,212E
$A5:F852             dx 001A, 8000,DA,6124, 8010,DA,6122, 8020,DA,6120, 8000,CA,6104, 8010,CA,6102, 8020,CA,6100, 81F0,DA,2124, 81E0,DA,2122, 81D0,DA,2120, 81F0,CA,2104, 81E0,CA,2102, 81D0,CA,2100, 8000,BC,6142, 81F0,BC,2142, 8000,26,614E, 8010,26,614C, 8020,26,614A, 8000,16,6148, 8010,16,6146, 8020,16,6144, 81F0,26,214E, 81E0,26,214C, 81D0,26,214A, 81F0,16,2148, 81E0,16,2146, 81D0,16,2144
$A5:F8D6             dx 001A, 8000,C8,6104, 8010,C8,6102, 81F0,C8,2104, 81E0,C8,2102, 81D0,C8,2100, 8000,BA,6142, 81F0,BA,2142, 8000,28,614E, 8010,28,614C, 8020,28,614A, 8000,18,6148, 8010,18,6146, 8020,18,6144, 81F0,28,214E, 81E0,28,214C, 81D0,28,214A, 81F0,18,2148, 81E0,18,2146, 81D0,18,2144, 8000,D8,6124, 8010,D8,6122, 8020,D8,6120, 8020,C8,6100, 81F0,D8,2124, 81E0,D8,2122, 81D0,D8,2120
}
}


;;; $F95A: Free space ;;;
{
$A5:F95A             fillto $A68000, $FF
}
