;;; $8000..8686: Common to all enemy banks ;;;
{
; See bank $A0
}


;;; $8687..88EF: Waver ;;;
{
;;; $8687: Palette - enemy $D63F (waver) ;;;
{
$A3:8687             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 241F, 1C17, 142F, 0C47, 3BE0, 2680, 1580
}


;;; $86A7..DA: Instruction lists - waver  ;;;
{
;;; $86A7: Instruction list -  ;;;
{
$A3:86A7             dx 0001,884A,
                        812F        ; Sleep
}


;;; $86AD: Instruction list -  ;;;
{
$A3:86AD             dx 0001,88B3,
                        812F        ; Sleep
}


;;; $86B3: Instruction list -  ;;;
{
$A3:86B3             dx 0008,885B,
                        0008,8871,
                        0008,881E,
                        0008,8834,
                        86E3,       ; ???
                        812F        ; Sleep
}


;;; $86C7: Instruction list -  ;;;
{
$A3:86C7             dx 0008,88C4,
                        0008,88DA,
                        0008,8887,
                        0008,889D,
                        86E3,       ; ???
                        812F        ; Sleep
}
}


;;; $86DB: Instruction list pointers ;;;
{
; See $87FE
$A3:86DB             dw 86A7, 86AD, 86B3, 86C7
}


;;; $86E3: Instruction -  ;;;
{
$A3:86E3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:86E6 A9 01 00    LDA #$0001
$A3:86E9 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A3:86EC 6B          RTL
}


;;; $86ED: Initialisation AI - enemy $D63F (waver) ;;;
{
$A3:86ED AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:86F0 A9 80 01    LDA #$0180
$A3:86F3 29 00 FF    AND #$FF00
$A3:86F6 EB          XBA
$A3:86F7 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:86FA A9 80 01    LDA #$0180
$A3:86FD 29 FF 00    AND #$00FF
$A3:8700 EB          XBA
$A3:8701 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:8704 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:8707 29 01 00    AND #$0001
$A3:870A D0 24       BNE $24    [$8730]
$A3:870C A9 80 01    LDA #$0180
$A3:870F 49 FF FF    EOR #$FFFF
$A3:8712 1A          INC A
$A3:8713 29 00 FF    AND #$FF00
$A3:8716 EB          XBA
$A3:8717 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$A3:871B 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A3:871E A9 80 01    LDA #$0180
$A3:8721 49 FF FF    EOR #$FFFF
$A3:8724 1A          INC A
$A3:8725 29 FF 00    AND #$00FF
$A3:8728 EB          XBA
$A3:8729 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$A3:872D 9D A8 0F    STA $0FA8,x[$7E:0FE8]

$A3:8730 9E B2 0F    STZ $0FB2,x[$7E:0FB2]
$A3:8733 9E AC 0F    STZ $0FAC,x[$7E:0FAC]
$A3:8736 9E B0 0F    STZ $0FB0,x[$7E:0FB0]
$A3:8739 A9 A7 86    LDA #$86A7
$A3:873C 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:873F BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:8742 29 01 00    AND #$0001
$A3:8745 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:8748 20 FE 87    JSR $87FE  [$A3:87FE]
$A3:874B 6B          RTL
}


;;; $874C: Main AI - enemy $D63F (waver) ;;;
{
$A3:874C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:874F BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A3:8752 85 12       STA $12    [$7E:0012]  ;|
$A3:8754 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;} Move enemy right by [enemy X velocity]
$A3:8757 85 14       STA $14    [$7E:0014]  ;|
$A3:8759 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:875D 90 37       BCC $37    [$8796]     ; If collided with wall:
$A3:875F BD A9 0F    LDA $0FA9,x[$7E:1029]
$A3:8762 85 12       STA $12    [$7E:0012]
$A3:8764 49 FF FF    EOR #$FFFF
$A3:8767 1A          INC A
$A3:8768 29 00 FF    AND #$FF00
$A3:876B EB          XBA
$A3:876C 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$A3:8770 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:8773 A5 12       LDA $12    [$7E:0012]
$A3:8775 49 FF FF    EOR #$FFFF
$A3:8778 1A          INC A
$A3:8779 29 FF 00    AND #$00FF
$A3:877C EB          XBA
$A3:877D 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$A3:8781 9D A8 0F    STA $0FA8,x[$7E:1028]
$A3:8784 BD B2 0F    LDA $0FB2,x[$7E:1032]
$A3:8787 49 01 00    EOR #$0001
$A3:878A 29 01 00    AND #$0001
$A3:878D 9D B2 0F    STA $0FB2,x[$7E:1032]
$A3:8790 20 FE 87    JSR $87FE  [$A3:87FE]
$A3:8793 4C CF 87    JMP $87CF  [$A3:87CF]

$A3:8796 A9 04 00    LDA #$0004
$A3:8799 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:879C BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:879F 29 FF 00    AND #$00FF
$A3:87A2 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:87A6 85 14       STA $14    [$7E:0014]  ;\
$A3:87A8 64 12       STZ $12    [$7E:0012]  ;} Move enemy down by [A]
$A3:87AA 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:87AE 90 12       BCC $12    [$87C2]     ; If collided with block:
$A3:87B0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:87B3 BD AE 0F    LDA $0FAE,x[$7E:0FEE]
$A3:87B6 18          CLC
$A3:87B7 69 80 00    ADC #$0080
$A3:87BA 29 FF 00    AND #$00FF
$A3:87BD 9D AE 0F    STA $0FAE,x[$7E:0FEE]
$A3:87C0 80 0D       BRA $0D    [$87CF]

$A3:87C2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:87C5 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:87C8 18          CLC
$A3:87C9 69 02 00    ADC #$0002
$A3:87CC 9D AE 0F    STA $0FAE,x[$7E:0FAE]

$A3:87CF AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:87D2 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:87D5 29 7F 00    AND #$007F
$A3:87D8 C9 38 00    CMP #$0038
$A3:87DB D0 0C       BNE $0C    [$87E9]
$A3:87DD BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A3:87E0 09 02 00    ORA #$0002
$A3:87E3 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:87E6 20 FE 87    JSR $87FE  [$A3:87FE]

$A3:87E9 BD B0 0F    LDA $0FB0,x[$7E:0FB0]
$A3:87EC F0 0F       BEQ $0F    [$87FD]
$A3:87EE 9E B0 0F    STZ $0FB0,x[$7E:0FB0]
$A3:87F1 BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A3:87F4 29 01 00    AND #$0001
$A3:87F7 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:87FA 20 FE 87    JSR $87FE  [$A3:87FE]

$A3:87FD 6B          RTL
}


;;; $87FE:  ;;;
{
$A3:87FE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8801 BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A3:8804 DD AC 0F    CMP $0FAC,x[$7E:0FAC]
$A3:8807 F0 14       BEQ $14    [$881D]
$A3:8809 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:880C 0A          ASL A
$A3:880D A8          TAY
$A3:880E B9 DB 86    LDA $86DB,y[$A3:86DD]
$A3:8811 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:8814 A9 01 00    LDA #$0001
$A3:8817 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:881A 9E 90 0F    STZ $0F90,x[$7E:0F90]

$A3:881D 60          RTS
}


;;; $881E: Spritemaps - waver ;;;
{
$A3:881E             dx 0004, 0000,08,2122, 01F8,08,2121, 8000,F8,2102, 81F0,F8,2100
$A3:8834             dx 0004, 01ED,FC,2124, 0005,00,2116, 0005,F8,2106, 81F5,F8,2104
$A3:884A             dx 0003, 01ED,FD,2126, 01F5,FD,2127, 81FD,F8,2107
$A3:885B             dx 0004, 01EC,FC,2129, 0004,00,211B, 0004,F8,210B, 81F4,F8,2109
$A3:8871             dx 0004, 0000,08,212E, 01F8,08,212D, 8000,F8,210E, 81F0,F8,210C
$A3:8887             dx 0004, 01F8,08,6122, 0000,08,6121, 81F0,F8,6102, 8000,F8,6100
$A3:889D             dx 0004, 000B,FC,6124, 01F3,00,6116, 01F3,F8,6106, 81FB,F8,6104
$A3:88B3             dx 0003, 000B,FD,6126, 0003,FD,6127, 81F3,F8,6107
$A3:88C4             dx 0004, 000C,FC,6129, 01F4,00,611B, 01F4,F8,610B, 81FC,F8,6109
$A3:88DA             dx 0004, 01F8,08,612E, 0000,08,612D, 81F0,F8,610E, 8000,F8,610C
}
}


;;; $88F0..8C0E: Metal skree ;;;
{
;;; $88F0: Palette - enemy $D67F (metal skree) ;;;
{
$A3:88F0             dw 3800, 4D1F, 38B6, 246E, 1448, 47FF, 2EFA, 1616, 0132, 6F39, 5A73, 41AD, 2D08, 1863, 7FFF, 0041
}


;;; $8910: Instruction list -  ;;;
{
$A3:8910             dx 000A,8B65,
                        000A,8BB9,
                        000A,8BDE,
                        000A,8BEA,
                        80ED,8910   ; Go to $8910
}


;;; $8924: Instruction list -  ;;;
{
$A3:8924             dx 0010,8B65,
                        0008,8B94,
                        8956,       ; ???
                        812F        ; Sleep
}


;;; $8930: Instruction list -  ;;;
{
$A3:8930             dx 8173        ; Enable off-screen processing
$A3:8932             dx 0002,8BB9,
                        0002,8BDE,
                        0002,8BEA,
                        0002,8B65,
                        80ED,8932   ; Go to $8932
}


;;; $8946: Instruction list -  ;;;
{
$A3:8946             dx 817D,       ; Disable off-screen processing
                        0001,8B65,
                        812F        ; Sleep
}


;;; $894E: Metal skree instruction list pointers ;;;
{
$A3:894E             dw 8910, 8924, 8930, 8946
}


;;; $8956: Instruction ;;;
{
$A3:8956 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8959 A9 01 00    LDA #$0001
$A3:895C 9D B0 0F    STA $0FB0,x[$7E:1030]
$A3:895F 6B          RTL
}


;;; $8960: Initialisation AI - enemy $D67F (metaree, metal skree) ;;;
{
$A3:8960 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8963 9E AC 0F    STZ $0FAC,x[$7E:102C]
$A3:8966 9E AE 0F    STZ $0FAE,x[$7E:102E]
$A3:8969 9E B0 0F    STZ $0FB0,x[$7E:1030]
$A3:896C A9 10 89    LDA #$8910
$A3:896F 9D 92 0F    STA $0F92,x[$7E:1012]
$A3:8972 A9 87 89    LDA #$8987
$A3:8975 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:8978 6B          RTL
}


;;; $8979: Main AI - enemy $D67F (metal skree) ;;;
{
$A3:8979 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:897C 7C AA 0F    JMP ($0FAA,x)[$A3:8987]
}


;;; $897F: Metal skree function pointers ;;;
{
$A3:897F             dw 8987, 89D4, 89F3, 8A5C
}


;;; $8987:  ;;;
{
$A3:8987 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:898A BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:898D 38          SEC
$A3:898E ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A3:8991 10 04       BPL $04    [$8997]
$A3:8993 49 FF FF    EOR #$FFFF
$A3:8996 1A          INC A

$A3:8997 C9 48 00    CMP #$0048
$A3:899A B0 0F       BCS $0F    [$89AB]
$A3:899C 20 AC 89    JSR $89AC  [$A3:89AC]
$A3:899F FE AC 0F    INC $0FAC,x[$7E:102C]
$A3:89A2 20 B2 8A    JSR $8AB2  [$A3:8AB2]
$A3:89A5 A9 D4 89    LDA #$89D4
$A3:89A8 9D AA 0F    STA $0FAA,x[$7E:102A]

$A3:89AB 6B          RTL
}


;;; $89AC:  ;;;
{
$A3:89AC AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A3:89AF 38          SEC
$A3:89B0 FD 7E 0F    SBC $0F7E,x[$7E:0FFE]
$A3:89B3 8D 04 42    STA $4204  [$7E:4204]
$A3:89B6 E2 20       SEP #$20
$A3:89B8 A9 18       LDA #$18
$A3:89BA 8D 06 42    STA $4206  [$7E:4206]
$A3:89BD C2 20       REP #$20
$A3:89BF EA          NOP
$A3:89C0 EA          NOP
$A3:89C1 EA          NOP
$A3:89C2 EA          NOP
$A3:89C3 EA          NOP
$A3:89C4 EA          NOP
$A3:89C5 EA          NOP
$A3:89C6 AD 14 42    LDA $4214  [$7E:4214]
$A3:89C9 29 FF 00    AND #$00FF
$A3:89CC 18          CLC
$A3:89CD 69 04 00    ADC #$0004
$A3:89D0 9D B2 0F    STA $0FB2,x[$7E:1032]
$A3:89D3 60          RTS
}


;;; $89D4:  ;;;
{
$A3:89D4 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A3:89D7 F0 19       BEQ $19    [$89F2]
$A3:89D9 9E B0 0F    STZ $0FB0,x[$7E:1030]
$A3:89DC AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:89DF FE AC 0F    INC $0FAC,x[$7E:102C]
$A3:89E2 20 B2 8A    JSR $8AB2  [$A3:8AB2]
$A3:89E5 A9 F3 89    LDA #$89F3
$A3:89E8 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:89EB A9 5B 00    LDA #$005B             ;\
$A3:89EE 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Bh, sound library 2, max queued sounds allowed = 6 (skree launches attack)

$A3:89F2 6B          RTL
}


;;; $89F3:  ;;;
{
$A3:89F3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:89F6 A9 15 00    LDA #$0015
$A3:89F9 9D A8 0F    STA $0FA8,x[$7E:1028]
$A3:89FC BD B2 0F    LDA $0FB2,x[$7E:1032]
$A3:89FF 85 14       STA $14    [$7E:0014]
$A3:8A01 64 12       STZ $12    [$7E:0012]
$A3:8A03 BD 86 0F    LDA $0F86,x[$7E:1006]
$A3:8A06 09 03 00    ORA #$0003
$A3:8A09 9D 86 0F    STA $0F86,x[$7E:1006]
$A3:8A0C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A0F 22 8A BF A0 JSL $A0BF8A[$A0:BF8A]
$A3:8A13 B0 2D       BCS $2D    [$8A42]
$A3:8A15 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A18 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A3:8A1B 18          CLC
$A3:8A1C 7D B2 0F    ADC $0FB2,x[$7E:1032]
$A3:8A1F 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A3:8A22 A9 02 00    LDA #$0002
$A3:8A25 8D 24 0E    STA $0E24  [$7E:0E24]
$A3:8A28 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:8A2B CD F6 0A    CMP $0AF6  [$7E:0AF6]
$A3:8A2E 30 06       BMI $06    [$8A36]
$A3:8A30 A9 FE FF    LDA #$FFFE
$A3:8A33 8D 24 0E    STA $0E24  [$7E:0E24]

$A3:8A36 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:8A39 18          CLC
$A3:8A3A 6D 24 0E    ADC $0E24  [$7E:0E24]
$A3:8A3D 9D 7A 0F    STA $0F7A,x[$7E:0FFA]
$A3:8A40 80 19       BRA $19    [$8A5B]

$A3:8A42 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A45 A9 01 00    LDA #$0001
$A3:8A48 9D 94 0F    STA $0F94,x[$7E:1014]
$A3:8A4B 9E 90 0F    STZ $0F90,x[$7E:1010]
$A3:8A4E A9 5C 8A    LDA #$8A5C
$A3:8A51 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:8A54 A9 5C 00    LDA #$005C             ;\
$A3:8A57 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Ch, sound library 2, max queued sounds allowed = 6 (skree hits the ground)

$A3:8A5B 6B          RTL
}


;;; $8A5C:  ;;;
{
$A3:8A5C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A5F DE A8 0F    DEC $0FA8,x[$7E:1028]
$A3:8A62 F0 2E       BEQ $2E    [$8A92]
$A3:8A64 BD A8 0F    LDA $0FA8,x[$7E:1028]
$A3:8A67 C9 08 00    CMP #$0008
$A3:8A6A D0 1F       BNE $1F    [$8A8B]
$A3:8A6C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A6F A0 FA 8B    LDY #$8BFA             ;\
$A3:8A72 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn metal skree particle - down-right enemy projectile
$A3:8A76 A0 08 8C    LDY #$8C08             ;\
$A3:8A79 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn metal skree particle - up-right enemy projectile
$A3:8A7D A0 16 8C    LDY #$8C16             ;\
$A3:8A80 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn metal skree particle - down-left enemy projectile
$A3:8A84 A0 24 8C    LDY #$8C24             ;\
$A3:8A87 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn metal skree particle - up-left enemy projectile

$A3:8A8B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A8E FE 7E 0F    INC $0F7E,x[$7E:0FFE]
$A3:8A91 6B          RTL

$A3:8A92 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8A95 BD 96 0F    LDA $0F96,x[$7E:1016]
$A3:8A98 1D 98 0F    ORA $0F98,x[$7E:1018]
$A3:8A9B 9F 06 70 7E STA $7E7006,x[$7E:7086]
$A3:8A9F A9 00 0A    LDA #$0A00
$A3:8AA2 9D 96 0F    STA $0F96,x[$7E:1016]
$A3:8AA5 9E 98 0F    STZ $0F98,x[$7E:1018]
$A3:8AA8 BD 86 0F    LDA $0F86,x[$7E:1006]
$A3:8AAB 09 00 02    ORA #$0200
$A3:8AAE 9D 86 0F    STA $0F86,x[$7E:1006]
$A3:8AB1 6B          RTL
}


;;; $8AB2:  ;;;
{
$A3:8AB2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8AB5 BD AC 0F    LDA $0FAC,x[$7E:102C]
$A3:8AB8 DD AE 0F    CMP $0FAE,x[$7E:102E]
$A3:8ABB F0 14       BEQ $14    [$8AD1]
$A3:8ABD 9D AE 0F    STA $0FAE,x[$7E:102E]
$A3:8AC0 0A          ASL A
$A3:8AC1 A8          TAY
$A3:8AC2 B9 4E 89    LDA $894E,y[$A3:8950]
$A3:8AC5 9D 92 0F    STA $0F92,x[$7E:1012]
$A3:8AC8 A9 01 00    LDA #$0001
$A3:8ACB 9D 94 0F    STA $0F94,x[$7E:1014]
$A3:8ACE 9E 90 0F    STZ $0F90,x[$7E:1010]

$A3:8AD1 60          RTS
}


;;; $8AD2:  ;;;
{
$A3:8AD2             dw 8ADC, 8AE6, 8AF0, 8AFA, 8B04

$A3:8ADC             dw 0001,0000,FFFE,0008,000C
$A3:8AE6             dw 0001,0000,FFFC,0008,0008
$A3:8AF0             dw 0001,0004,0000,0002,000C
$A3:8AFA             dw 0001,0000,0000,0008,0008
$A3:8B04             dw 0001,FFFC,0000,0002,000C
}


;;; $8B0E: RTL ;;;
{
$A3:8B0E 6B          RTL
}


;;; $8B0F: Enemy shot - enemy $D67F (metal skree) ;;;
{
$A3:8B0F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8B12 BD 98 0F    LDA $0F98,x[$7E:1118]
$A3:8B15 8D 2A 0E    STA $0E2A  [$7E:0E2A]
$A3:8B18 BD 96 0F    LDA $0F96,x[$7E:1116]
$A3:8B1B 8D 2C 0E    STA $0E2C  [$7E:0E2C]
$A3:8B1E 22 2D 80 A3 JSL $A3802D[$A3:802D]
$A3:8B22 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8B25 BD 8C 0F    LDA $0F8C,x[$7E:110C]
$A3:8B28 D0 3A       BNE $3A    [$8B64]
$A3:8B2A AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8B2D AD 2A 0E    LDA $0E2A  [$7E:0E2A]
$A3:8B30 9D 98 0F    STA $0F98,x
$A3:8B33 AD 2C 0E    LDA $0E2C  [$7E:0E2C]
$A3:8B36 9D 96 0F    STA $0F96,x
$A3:8B39 BD A8 0F    LDA $0FA8,x
$A3:8B3C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8B3F A0 FA 8B    LDY #$8BFA
$A3:8B42 22 27 80 86 JSL $868027[$86:8027]
$A3:8B46 A0 08 8C    LDY #$8C08
$A3:8B49 22 27 80 86 JSL $868027[$86:8027]
$A3:8B4D A0 16 8C    LDY #$8C16
$A3:8B50 22 27 80 86 JSL $868027[$86:8027]
$A3:8B54 A0 24 8C    LDY #$8C24
$A3:8B57 22 27 80 86 JSL $868027[$86:8027]
$A3:8B5B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8B5E 9E 98 0F    STZ $0F98,x
$A3:8B61 9E 96 0F    STZ $0F96,x

$A3:8B64 6B          RTL
}


;;; $8B65: Metal skree spritemaps ;;;
{
$A3:8B65             dx 0009, 0004,F5,6122, 0004,FD,6123, 0004,05,6124, 01F4,05,2124, 01F4,FD,2123, 01F4,F5,2122, 0000,03,2121, 01F8,03,2120, 81F8,F3,2100
$A3:8B94             dx 0007, 0005,03,6127, 01F3,03,2127, 0005,FB,6126, 01F3,FB,2126, 0005,F3,6125, 01F3,F3,2125, 81F8,F3,2102
$A3:8BB9             dx 0007, 81F5,03,2106, 81F5,F3,2104, 0000,03,2121, 81F8,F3,2100, 0000,03,212A, 0000,FB,2129, 0000,F3,2128
$A3:8BDE             dx 0002, 81F8,03,210E, 81F8,F3,210C
$A3:8BEA             dx 0007, 81FB,03,210A, 81FB,F3,2108, 01F8,03,2120, 81F8,F3,2100, 01F8,03,612A, 01F8,FB,6129, 01F8,F3,6128
}
}


;;; $8C0F..9009: Fireflea ;;;
{
;;; $8C0F: Palette - enemy $D6BF (fireflea) ;;;
{
$A3:8C0F             dw 3800, 02FF, 01BF, 000F, 0008, 01BF, 011B, 00BA, 0011, 7F5A, 5D45, 40C3, 2462, 53E9, 3AC6, 1961
}


;;; $8C2F: Instruction list -  ;;;
{
$A3:8C2F             dx 0002,8EA5,
                        0001,8EB6,
                        0002,8EC7,
                        0001,8EB6,
                        0002,8EA5,
                        0001,8EB6,
                        0002,8EC7,
                        0001,8EB6,
                        0002,8ED8,
                        0001,8EE9,
                        0002,8EFA,
                        0001,8EE9,
                        0002,8F0B,
                        0001,8F1C,
                        0002,8F2D,
                        0001,8F1C,
                        0002,8F3E,
                        0001,8F4F,
                        0002,8F60,
                        0001,8F4F,
                        0002,8F71,
                        0001,8F82,
                        0002,8F93,
                        0001,8F82,
                        0002,8FA4,
                        0001,8FB5,
                        0002,8FC6,
                        0001,8FB5,
                        0002,8FD7,
                        0001,8FE8,
                        0002,8FF9,
                        0001,8FE8,
                        0002,8FA4,
                        0001,8FB5,
                        0002,8FC6,
                        0001,8FB5,
                        0002,8F71,
                        0001,8F82,
                        0002,8F93,
                        0001,8F82,
                        0002,8F3E,
                        0001,8F4F,
                        0002,8F60,
                        0001,8F4F,
                        0002,8F0B,
                        0001,8F1C,
                        0002,8F2D,
                        0001,8F1C,
                        0002,8ED8,
                        0001,8EE9,
                        0002,8EFA,
                        0001,8EE9,
                        80ED,8C2F   ; Go to $8C2F
}


;;; $8D03:  ;;;
{
; Unused?
$A3:8D03             dw 1000, 2000, 4000, 6000, 8000, A000, C000, E000

; Unused?
$A3:8D13             dw 0001, 2001, 4001, 6001, 8001

$A3:8D1D             dw 0008, 0010, 0018, 0020, 0028, 0030, 0038, 0040
}


;;; $8D2D: Initialisation AI - enemy $D6BF (fireflea) ;;;
{
$A3:8D2D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8D30 A9 2F 8C    LDA #$8C2F
$A3:8D33 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:8D36 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:8D39 29 FF 00    AND #$00FF
$A3:8D3C 85 12       STA $12    [$7E:0012]
$A3:8D3E 29 02 00    AND #$0002
$A3:8D41 D0 0A       BNE $0A    [$8D4D]
$A3:8D43 20 75 8D    JSR $8D75  [$A3:8D75]
$A3:8D46 20 9C 8D    JSR $8D9C  [$A3:8D9C]
$A3:8D49 20 D7 8D    JSR $8DD7  [$A3:8DD7]
$A3:8D4C 6B          RTL

$A3:8D4D 20 5D 8D    JSR $8D5D  [$A3:8D5D]
$A3:8D50 20 6A 8D    JSR $8D6A  [$A3:8D6A]
$A3:8D53 20 75 8D    JSR $8D75  [$A3:8D75]
$A3:8D56 20 9C 8D    JSR $8D9C  [$A3:8D9C]
$A3:8D59 20 AE 8D    JSR $8DAE  [$A3:8DAE]
$A3:8D5C 6B          RTL
}


;;; $8D5D:  ;;;
{
$A3:8D5D BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A3:8D60 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A3:8D63 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A3:8D66 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:8D69 60          RTS
}


;;; $8D6A:  ;;;
{
$A3:8D6A BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:8D6D 29 FF 00    AND #$00FF
$A3:8D70 EB          XBA
$A3:8D71 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:8D74 60          RTS
}


;;; $8D75:  ;;;
{
$A3:8D75 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A3:8D78 29 FF 00    AND #$00FF
$A3:8D7B 0A          ASL A
$A3:8D7C 0A          ASL A
$A3:8D7D 0A          ASL A
$A3:8D7E A8          TAY
$A3:8D7F A5 12       LDA $12    [$7E:0012]
$A3:8D81 29 01 00    AND #$0001
$A3:8D84 D0 04       BNE $04    [$8D8A]
$A3:8D86 C8          INY
$A3:8D87 C8          INY
$A3:8D88 C8          INY
$A3:8D89 C8          INY

$A3:8D8A 98          TYA
$A3:8D8B 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:8D8F B9 87 81    LDA $8187,y[$A3:820B]
$A3:8D92 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:8D95 B9 89 81    LDA $8189,y[$A3:820D]
$A3:8D98 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:8D9B 60          RTS
}


;;; $8D9C:  ;;;
{
$A3:8D9C BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A3:8D9F 29 FF 00    AND #$00FF
$A3:8DA2 0A          ASL A
$A3:8DA3 A8          TAY
$A3:8DA4 B9 1D 8D    LDA $8D1D,y[$A3:8D21]
$A3:8DA7 29 FF 00    AND #$00FF
$A3:8DAA 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:8DAD 60          RTS
}


;;; $8DAE:  ;;;
{
$A3:8DAE BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:8DB1 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:8DB4 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:8DB7 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]
$A3:8DBB 18          CLC
$A3:8DBC 7D B0 0F    ADC $0FB0,x[$7E:0FB0]
$A3:8DBF 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A3:8DC2 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:8DC5 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:8DC8 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:8DCB 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:8DCF 18          CLC
$A3:8DD0 7D B2 0F    ADC $0FB2,x[$7E:0FB2]
$A3:8DD3 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A3:8DD6 60          RTS
}


;;; $8DD7:  ;;;
{
$A3:8DD7 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A3:8DDA 38          SEC
$A3:8DDB FD AC 0F    SBC $0FAC,x[$7E:106C]
$A3:8DDE 9F 00 78 7E STA $7E7800,x[$7E:78C0]
$A3:8DE2 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A3:8DE5 18          CLC
$A3:8DE6 7D AC 0F    ADC $0FAC,x[$7E:106C]
$A3:8DE9 9F 02 78 7E STA $7E7802,x[$7E:78C2]
$A3:8DED 60          RTS
}


;;; $8DEE: Main AI - enemy $D6BF (fireflea) ;;;
{
$A3:8DEE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8DF1 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:8DF4 29 02 00    AND #$0002
$A3:8DF7 F0 3B       BEQ $3B    [$8E34]
$A3:8DF9 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:8DFC 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:8DFF BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:8E02 29 00 FF    AND #$FF00
$A3:8E05 EB          XBA
$A3:8E06 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]
$A3:8E0A 18          CLC
$A3:8E0B 7D B0 0F    ADC $0FB0,x[$7E:0FB0]
$A3:8E0E 9D 7A 0F    STA $0F7A,x[$7E:0F7A]
$A3:8E11 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:8E14 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:8E17 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:8E1A 29 00 FF    AND #$FF00
$A3:8E1D EB          XBA
$A3:8E1E 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:8E22 18          CLC
$A3:8E23 7D B2 0F    ADC $0FB2,x[$7E:0FB2]
$A3:8E26 9D 7E 0F    STA $0F7E,x[$7E:0F7E]
$A3:8E29 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:8E2C 18          CLC
$A3:8E2D 7D A9 0F    ADC $0FA9,x[$7E:0FA9]
$A3:8E30 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:8E33 6B          RTL

$A3:8E34 BF 04 78 7E LDA $7E7804,x[$7E:7904]
$A3:8E38 A8          TAY
$A3:8E39 18          CLC
$A3:8E3A BD 80 0F    LDA $0F80,x[$7E:1080]
$A3:8E3D 79 89 81    ADC $8189,y[$A3:81CD]
$A3:8E40 9D 80 0F    STA $0F80,x[$7E:1080]
$A3:8E43 BD 7E 0F    LDA $0F7E,x[$7E:107E]
$A3:8E46 79 87 81    ADC $8187,y[$A3:81CB]
$A3:8E49 9D 7E 0F    STA $0F7E,x[$7E:107E]
$A3:8E4C BD 7E 0F    LDA $0F7E,x[$7E:107E]
$A3:8E4F DF 00 78 7E CMP $7E7800,x[$7E:7900]
$A3:8E53 30 0A       BMI $0A    [$8E5F]
$A3:8E55 BD 7E 0F    LDA $0F7E,x[$7E:107E]
$A3:8E58 DF 02 78 7E CMP $7E7802,x[$7E:7902]
$A3:8E5C 10 01       BPL $01    [$8E5F]
$A3:8E5E 6B          RTL

$A3:8E5F BF 04 78 7E LDA $7E7804,x[$7E:7904]
$A3:8E63 49 04 00    EOR #$0004
$A3:8E66 9F 04 78 7E STA $7E7804,x[$7E:7904]
$A3:8E6A 6B          RTL
}


;;; $8E6B: Enemy touch - enemy $D6BF (fireflea) ;;;
{
$A3:8E6B 22 23 80 A3 JSL $A38023[$A3:8023]  ; Normal enemy touch AI
$A3:8E6F 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]  ; Death animation
$A3:8E73 AD 7E 17    LDA $177E  [$7E:177E]  ;\
$A3:8E76 18          CLC                    ;|
$A3:8E77 69 02 00    ADC #$0002             ;} If [fireflea darkness level] < Ch: (this should actually be compared to Ah, Ch causes table overread)
$A3:8E7A C9 0E 00    CMP #$000E             ;|
$A3:8E7D 10 03       BPL $03    [$8E82]     ;/
$A3:8E7F 8D 7E 17    STA $177E  [$7E:177E]  ; Fireflea darkness level += 2

$A3:8E82 6B          RTL
}


;;; $8E83: Power bomb reaction - enemy $D6BF (fireflea) ;;;
{
$A3:8E83 22 37 80 A3 JSL $A38037[$A3:8037]
$A3:8E87 80 04       BRA $04    [$8E8D]
}


;;; $8E89: Enemy shot - enemy $D6BF (fireflea) ;;;
{
$A3:8E89 22 2D 80 A3 JSL $A3802D[$A3:802D]
}


;;; $8E8D:  ;;;
{
$A3:8E8D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:8E90 BD 8C 0F    LDA $0F8C,x[$7E:100C]
$A3:8E93 D0 0F       BNE $0F    [$8EA4]
$A3:8E95 AD 7E 17    LDA $177E  [$7E:177E]
$A3:8E98 18          CLC
$A3:8E99 69 02 00    ADC #$0002
$A3:8E9C C9 0E 00    CMP #$000E
$A3:8E9F 10 03       BPL $03    [$8EA4]
$A3:8EA1 8D 7E 17    STA $177E  [$7E:177E]

$A3:8EA4 6B          RTL
}


;;; $8EA5: Fireflea spritemaps ;;;
{
$A3:8EA5             dx 0003, 81F8,F8,3100, 0001,F6,3121, 01F7,F6,3120
$A3:8EB6             dx 0003, 81F8,F8,3100, 0001,F6,3123, 01F7,F6,3122
$A3:8EC7             dx 0003, 81F8,F8,3100, 0001,F6,3125, 01F7,F6,3124
$A3:8ED8             dx 0003, 81F8,F8,3102, 0001,F6,3121, 01F7,F6,3120
$A3:8EE9             dx 0003, 81F8,F8,3102, 0001,F6,3123, 01F7,F6,3122
$A3:8EFA             dx 0003, 81F8,F8,3102, 0001,F6,3125, 01F7,F6,3124
$A3:8F0B             dx 0003, 81F8,F8,3104, 0001,F6,3127, 01F7,F6,3126
$A3:8F1C             dx 0003, 81F8,F8,3104, 0001,F6,3129, 01F7,F6,3128
$A3:8F2D             dx 0003, 81F8,F8,3104, 0001,F6,312B, 01F7,F6,312A
$A3:8F3E             dx 0003, 81F8,F8,3106, 0001,F6,3127, 01F7,F6,3126
$A3:8F4F             dx 0003, 81F8,F8,3106, 0001,F6,3129, 01F7,F6,3128
$A3:8F60             dx 0003, 81F8,F8,3106, 0001,F6,312B, 01F7,F6,312A
$A3:8F71             dx 0003, 81F8,F8,3108, 0001,F6,3127, 01F7,F6,3126
$A3:8F82             dx 0003, 81F8,F8,3108, 0001,F6,3129, 01F7,F6,3128
$A3:8F93             dx 0003, 81F8,F8,3108, 0001,F6,312B, 01F7,F6,312A
$A3:8FA4             dx 0003, 81F8,F8,310A, 0001,F6,312D, 01F7,F6,312C
$A3:8FB5             dx 0003, 81F8,F8,310A, 0001,F6,312F, 01F7,F6,312E
$A3:8FC6             dx 0003, 81F8,F8,310A, 0001,F6,311F, 01F7,F6,311E
$A3:8FD7             dx 0003, 81F8,F8,310C, 0001,F6,312D, 01F7,F6,312C
$A3:8FE8             dx 0003, 0001,F6,312F, 01F7,F6,312E, 81F8,F8,310C
$A3:8FF9             dx 0003, 0001,F6,311F, 01F7,F6,311E, 81F8,F8,310C
}
}


;;; $900A..94D5: Maridia fish ;;;
{
;;; $900A: Palette - enemy $D6FF (Maridia fish) ;;;
{
$A3:900A             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 241F, 1C17, 142F, 0C47, 03FF, 0237, 00D1
}


;;; $902A: Instruction list -  ;;;
{
$A3:902A             dx 90A0,       ; ???
                        000E,928A,
                        000E,92A5,
                        000E,92C0,
                        80ED,902C   ; Go to $902C
}


;;; $903C: Instruction list -  ;;;
{
$A3:903C             dx 000D,92DB,
                        000A,92F6,
                        0008,9311,
                        0006,9327,
                        0006,933D,
                        0008,934E,
                        000A,9364,
                        000D,937F,
                        90AA,       ; ???
                        812F        ; Sleep
}


;;; $9060: Instruction list -  ;;;
{
$A3:9060             dx 9096,       ; ???
                        000E,939A,
                        000E,93B5,
                        000E,93D0,
                        80ED,9062   ; Go to $9062
}


;;; $9072: Instruction list -  ;;;
{
$A3:9072             dx 000D,93EB,
                        000A,9406,
                        0008,9421,
                        0006,9437,
                        0006,944D,
                        0008,945E,
                        000A,9474,
                        000D,948F,
                        90AA,       ; ???
                        812F        ; Sleep
}


;;; $9096: Instruction ;;;
{
$A3:9096 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9099 A9 06 00    LDA #$0006
$A3:909C 9D 9A 0F    STA $0F9A,x[$7E:0FDA]
$A3:909F 6B          RTL
}


;;; $90A0: Instruction ;;;
{
$A3:90A0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:90A3 A9 02 00    LDA #$0002
$A3:90A6 9D 9A 0F    STA $0F9A,x[$7E:0FDA]
$A3:90A9 6B          RTL
}


;;; $90AA: Instruction ;;;
{
$A3:90AA AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:90AD A9 01 00    LDA #$0001
$A3:90B0 9F 02 78 7E STA $7E7802,x[$7E:7842]
$A3:90B4 6B          RTL
}


;;; $90B5: Initialisation AI - enemy $D6FF (Maridia fish) ;;;
{
$A3:90B5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:90B8 A9 2A 90    LDA #$902A
$A3:90BB 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:90BE A9 32 91    LDA #$9132
$A3:90C1 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:90C4 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:90C7 29 FF 00    AND #$00FF
$A3:90CA D0 0C       BNE $0C    [$90D8]
$A3:90CC A9 60 90    LDA #$9060
$A3:90CF 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:90D2 A9 AB 91    LDA #$91AB
$A3:90D5 9D A8 0F    STA $0FA8,x[$7E:0FA8]

$A3:90D8 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:90DB 29 FF 00    AND #$00FF
$A3:90DE 0A          ASL A
$A3:90DF 0A          ASL A
$A3:90E0 0A          ASL A
$A3:90E1 A8          TAY
$A3:90E2 B9 87 81    LDA $8187,y[$A3:8207]
$A3:90E5 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:90E8 B9 89 81    LDA $8189,y[$A3:8209]
$A3:90EB 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:90EE B9 8B 81    LDA $818B,y[$A3:820B]
$A3:90F1 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A3:90F4 B9 8D 81    LDA $818D,y[$A3:820D]
$A3:90F7 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:90FA BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A3:90FD 29 FF 00    AND #$00FF
$A3:9100 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:9104 BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A3:9107 29 FF 00    AND #$00FF
$A3:910A 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:910E A9 00 00    LDA #$0000
$A3:9111 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:9114 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A3:9118 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A3:911C 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:911F BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A3:9122 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:9126 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:912A 6B          RTL
}


;;; $912B: Main AI - enemy $D6FF (Maridia fish) ;;;
{
$A3:912B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:912E FC A8 0F    JSR ($0FA8,x)[$A3:9132]
$A3:9131 6B          RTL
}


;;; $9132:  ;;;
{
$A3:9132 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9135 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$A3:9138 85 12       STA $12    [$7E:0012]  ;|
$A3:913A BD B0 0F    LDA $0FB0,x[$7E:0FF0]  ;} Move enemy right by [enemy X velocity]
$A3:913D 85 14       STA $14    [$7E:0014]  ;|
$A3:913F 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:9143 90 17       BCC $17    [$915C]     ; If collided with wall:
$A3:9145 A9 24 92    LDA #$9224
$A3:9148 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$A3:914B A9 01 00    LDA #$0001
$A3:914E 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:9151 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A3:9154 A9 3C 90    LDA #$903C
$A3:9157 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:915A 80 46       BRA $46    [$91A2]

$A3:915C BF 00 78 7E LDA $7E7800,x[$7E:7840]
$A3:9160 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:9163 BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:9166 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:916A 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A3:916E 38          SEC
$A3:916F FF 06 78 7E SBC $7E7806,x[$7E:7846]
$A3:9173 85 14       STA $14    [$7E:0014]
$A3:9175 64 12       STZ $12    [$7E:0012]  ;\
$A3:9177 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;} Move enemy down by [$14]
$A3:917B 90 17       BCC $17    [$9194]     ; If collided with block:
$A3:917D A9 24 92    LDA #$9224
$A3:9180 9D A8 0F    STA $0FA8,x[$7E:10E8]
$A3:9183 A9 01 00    LDA #$0001
$A3:9186 9D 94 0F    STA $0F94,x[$7E:10D4]
$A3:9189 9E 90 0F    STZ $0F90,x[$7E:10D0]
$A3:918C A9 3C 90    LDA #$903C
$A3:918F 9D 92 0F    STA $0F92,x[$7E:10D2]
$A3:9192 80 0E       BRA $0E    [$91A2]

$A3:9194 BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:9197 18          CLC
$A3:9198 7F 04 78 7E ADC $7E7804,x[$7E:7844]
$A3:919C 29 FF 00    AND #$00FF
$A3:919F 9D B2 0F    STA $0FB2,x[$7E:0FF2]

$A3:91A2 BF 08 78 7E LDA $7E7808,x[$7E:7848]
$A3:91A6 9F 06 78 7E STA $7E7806,x[$7E:7846]
$A3:91AA 60          RTS
}


;;; $91AB:  ;;;
{
$A3:91AB AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:91AE BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;\
$A3:91B1 85 12       STA $12    [$7E:0012]  ;|
$A3:91B3 BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;} Move enemy right by [enemy X velocity]
$A3:91B6 85 14       STA $14    [$7E:0014]  ;|
$A3:91B8 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:91BC 90 17       BCC $17    [$91D5]     ; If collided with wall:
$A3:91BE A9 56 92    LDA #$9256
$A3:91C1 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:91C4 A9 01 00    LDA #$0001
$A3:91C7 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:91CA 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A3:91CD A9 72 90    LDA #$9072
$A3:91D0 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:91D3 80 46       BRA $46    [$921B]

$A3:91D5 BF 00 78 7E LDA $7E7800,x[$7E:7840]
$A3:91D9 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:91DC BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:91DF 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:91E3 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A3:91E7 38          SEC
$A3:91E8 FF 06 78 7E SBC $7E7806,x[$7E:7846]
$A3:91EC 85 14       STA $14    [$7E:0014]
$A3:91EE 64 12       STZ $12    [$7E:0012]  ;\
$A3:91F0 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;} Move enemy down by [$14]
$A3:91F4 90 17       BCC $17    [$920D]     ; If collided with block:
$A3:91F6 A9 56 92    LDA #$9256
$A3:91F9 9D A8 0F    STA $0FA8,x[$7E:1128]
$A3:91FC A9 01 00    LDA #$0001
$A3:91FF 9D 94 0F    STA $0F94,x[$7E:1114]
$A3:9202 9E 90 0F    STZ $0F90,x[$7E:1110]
$A3:9205 A9 72 90    LDA #$9072
$A3:9208 9D 92 0F    STA $0F92,x[$7E:1112]
$A3:920B 80 0E       BRA $0E    [$921B]

$A3:920D BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:9210 18          CLC
$A3:9211 7F 04 78 7E ADC $7E7804,x[$7E:7844]
$A3:9215 29 FF 00    AND #$00FF
$A3:9218 9D B2 0F    STA $0FB2,x[$7E:0FF2]

$A3:921B BF 08 78 7E LDA $7E7808,x[$7E:7848]
$A3:921F 9F 06 78 7E STA $7E7806,x[$7E:7846]
$A3:9223 60          RTS
}


;;; $9224:  ;;;
{
$A3:9224 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9227 BF 02 78 7E LDA $7E7802,x[$7E:7842]
$A3:922B F0 28       BEQ $28    [$9255]
$A3:922D A9 00 00    LDA #$0000
$A3:9230 9F 02 78 7E STA $7E7802,x[$7E:7842]
$A3:9234 A9 AB 91    LDA #$91AB
$A3:9237 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$A3:923A BF 04 78 7E LDA $7E7804,x[$7E:7844]
$A3:923E 49 FF FF    EOR #$FFFF
$A3:9241 1A          INC A
$A3:9242 9F 04 78 7E STA $7E7804,x[$7E:7844]
$A3:9246 A9 01 00    LDA #$0001
$A3:9249 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:924C 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A3:924F A9 60 90    LDA #$9060
$A3:9252 9D 92 0F    STA $0F92,x[$7E:0FD2]

$A3:9255 60          RTS
}


;;; $9256:  ;;;
{
$A3:9256 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9259 BF 02 78 7E LDA $7E7802,x[$7E:7802]
$A3:925D F0 28       BEQ $28    [$9287]
$A3:925F A9 00 00    LDA #$0000
$A3:9262 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A3:9266 A9 32 91    LDA #$9132
$A3:9269 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:926C BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A3:9270 49 FF FF    EOR #$FFFF
$A3:9273 1A          INC A
$A3:9274 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:9278 A9 01 00    LDA #$0001
$A3:927B 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:927E 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A3:9281 A9 2A 90    LDA #$902A
$A3:9284 9D 92 0F    STA $0F92,x[$7E:0F92]

$A3:9287 60          RTS
}


;;; $9288: RTL ;;;
{
$A3:9288 6B          RTL
}


;;; $9289: RTL ;;;
{
$A3:9289 6B          RTL
}


;;; $928A: Maridia fish spritemaps ;;;
{
$A3:928A             dx 0005, C3F2,00,2104, C3F2,F0,2100, 01FE,FD,2120, 0003,FE,2121, 0008,FE,2123
$A3:92A5             dx 0005, C3F2,00,2102, C3F2,F0,2100, 01FE,FE,2121, 0003,00,2122, 0008,FE,2124
$A3:92C0             dx 0005, C3F2,00,2102, C3F2,F0,2100, 01FE,00,2122, 0003,FD,2120, 0008,FE,2125
$A3:92DB             dx 0005, 0008,FE,2123, 0003,FE,2121, 01FE,FD,2120, C3F2,00,2102, C3F2,F0,2100
$A3:92F6             dx 0005, C3F2,00,2108, C3F2,F0,2106, 01FC,FE,2121, 0001,00,2122, 0006,FE,2124
$A3:9311             dx 0004, C3F2,00,210C, C3F2,F0,210A, 01FE,FD,2120, 0003,FE,2125
$A3:9327             dx 0004, C3F0,00,6108, C3F0,F0,6106, 01EE,FD,6120, 01FD,FE,2123
$A3:933D             dx 0003, C3F2,F0,6100, C3F2,00,6102, 01EF,FD,6121
$A3:934E             dx 0004, C3F5,00,6104, C3F5,F0,6100, 01F1,00,6122, 01EF,FD,6120
$A3:9364             dx 0005, C3FB,00,6102, C3FB,F0,6100, 01F7,FD,6120, 01F2,00,6122, 01F0,FE,6124
$A3:937F             dx 0005, C3FF,00,6102, C3FF,F0,6100, 01FB,00,6122, 01F6,FD,6120, 01F1,FE,6125
$A3:939A             dx 0005, C3FE,F0,6100, C3FE,00,6104, 01FA,FD,6120, 01F5,FE,6121, 01F0,FE,6123
$A3:93B5             dx 0005, C3FE,00,6102, C3FE,F0,6100, 01FA,FE,6121, 01F5,00,6122, 01F0,FE,6124
$A3:93D0             dx 0005, C3FE,00,6102, C3FE,F0,6100, 01FA,00,6122, 01F5,FD,6120, 01F0,FE,6125
$A3:93EB             dx 0005, 01F0,FE,6123, 01F5,FE,6121, 01FA,FD,6120, C3FE,00,6102, C3FE,F0,6100
$A3:9406             dx 0005, C3FE,00,6108, C3FE,F0,6106, 01FC,FE,6121, 01F7,00,6122, 01F2,FE,6124
$A3:9421             dx 0004, C3FE,00,610C, C3FE,F0,610A, 01FA,FD,6120, 01F5,FE,6125
$A3:9437             dx 0004, C200,00,2108, C200,F0,2106, 000A,FD,2120, 01FB,FE,6123
$A3:944D             dx 0003, C3FE,F0,2100, C3FE,00,2102, 0009,FD,2121
$A3:945E             dx 0004, C3FB,00,2104, C3FB,F0,2100, 0007,00,2122, 0009,FD,2120
$A3:9474             dx 0005, C3F5,00,2102, C3F5,F0,2100, 0001,FD,2120, 0006,00,2122, 0008,FE,2124
$A3:948F             dx 0005, C3F1,00,2102, C3F1,F0,2100, 01FD,00,2122, 0002,FD,2120, 0007,FE,2125
}



;;; $94AA: Maridia fish spritemap pointers ;;;
{
$A3:94AA             dw 928A, 92A5, 92C0, 92DB, 92F6, 9311, 9327, 933D, 934E, 9364, 937F, 939A, 93B5, 93D0, 93EB, 9406,
                        9421, 9437, 944D, 945E, 9474, 948F
}
}


;;; $94D6..965A: Elevator ;;;
{
;;; $94D6: Instruction list - elevator ;;;
{
$A3:94D6             dx 0002,962F,
                        0002,9645,
                        80ED,94D6   ; Go to $94D6
}


;;; $94E2: Elevator controller inputs ;;;
{
; Indexed by parameter 1 (Speed in SMILE), which is multiplied by 2 in the init AI
$A3:94E2             dw 0400, ; Down
                        0800  ; Up
}


;;; $94E6: Initialisation AI - enemy $D73F (elevator) ;;;
{
$A3:94E6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:94E9 A9 4D 80    LDA #$804D             ;\
$A3:94EC 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D (empty)
$A3:94EF A9 01 00    LDA #$0001             ;\
$A3:94F2 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A3:94F5 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0
$A3:94F8 A9 D6 94    LDA #$94D6             ;\
$A3:94FB 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $94D6
$A3:94FE 1E B4 0F    ASL $0FB4,x[$7E:0FB4]  ; Enemy parameter 1 *= 2
$A3:9501 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;\
$A3:9504 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy $0FA8 = [enemy Y position]
$A3:9507 AD 18 0E    LDA $0E18  [$7E:0E18]  ;\
$A3:950A C9 02 00    CMP #$0002             ;} If [elevator status] != door transition:
$A3:950D F0 06       BEQ $06    [$9515]     ;/
$A3:950F 9C 16 0E    STZ $0E16  [$7E:0E16]  ; Elevator properties = 0
$A3:9512 9C 18 0E    STZ $0E18  [$7E:0E18]  ; Elevator status = inactive

$A3:9515 AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$A3:9518 0D 18 0E    ORA $0E18  [$7E:0E18]  ;} If [elevator properties] | [elevator status] = 0: return
$A3:951B F0 0C       BEQ $0C    [$9529]     ;/
$A3:951D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9520 BD B6 0F    LDA $0FB6,x[$7E:1036]  ;\
$A3:9523 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;} Enemy Y position = [enemy parameter 2]
$A3:9526 20 12 96    JSR $9612  [$A3:9612]  ; Place Samus on top of elevator

$A3:9529 6B          RTL
}


;;; $952A: Main AI / grapple AI / frozen AI - enemy $D73F (elevator) ;;;
{
$A3:952A AD 95 07    LDA $0795  [$7E:0795]  ;\
$A3:952D D0 10       BNE $10    [$953F]     ;} If in door transition: return
$A3:952F AD 16 0E    LDA $0E16  [$7E:0E16]  ;\
$A3:9532 0D 18 0E    ORA $0E18  [$7E:0E18]  ;} If [elevator properties] | [elevator status] = 0: return
$A3:9535 F0 08       BEQ $08    [$953F]     ;/
$A3:9537 AD 18 0E    LDA $0E18  [$7E:0E18]  ;\
$A3:953A 0A          ASL A                  ;|
$A3:953B AA          TAX                    ;} Execute [$9540 + [elevator status] * 2]
$A3:953C FC 40 95    JSR ($9540,x)[$A3:9548];/

$A3:953F 6B          RTL

$A3:9540             dw 9548, 9579, 95B9, 95BC
}


;;; $9548: Elevator AI - elevator status = 0: inactive ;;;
{
$A3:9548 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A3:954B BC B4 0F    LDY $0FB4,x[$7E:0FB4]  ;|
$A3:954E A5 8F       LDA $8F    [$7E:008F]  ;} If newly pressed [$94E2 + [enemy parameter 1]]:
$A3:9550 39 E2 94    AND $94E2,y[$A3:94E2]  ;|
$A3:9553 F0 20       BEQ $20    [$9575]     ;/
$A3:9555 A9 0B 00    LDA #$000B             ;\
$A3:9558 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound Bh, sound library 3, max queued sounds allowed = 6 (elevator)
$A3:955C A9 32 00    LDA #$0032             ;\
$A3:955F 22 49 90 80 JSL $809049[$80:9049]  ;} Queue sound 32h, sound library 1, max queued sounds allowed = 6 (spin jump end)
$A3:9563 A9 07 00    LDA #$0007             ; A = 7
$A3:9566 22 84 F0 90 JSL $90F084[$90:F084]  ; Execute $90:F084
$A3:956A 22 22 AD 90 JSL $90AD22[$90:AD22]  ; Reset projectile data
$A3:956E 20 12 96    JSR $9612  [$A3:9612]  ; Place Samus on top of elevator
$A3:9571 EE 18 0E    INC $0E18  [$7E:0E18]  ; Elevator state = leaving the room
$A3:9574 60          RTS

$A3:9575 9C 16 0E    STZ $0E16  [$7E:0E16]  ; Elevator properties = 0
$A3:9578 60          RTS
}


;;; $9579: Elevator AI - elevator status = 1: leaving room ;;;
{
$A3:9579 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A3:957C BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;} If [enemy parameter 1] = 0:
$A3:957F D0 1B       BNE $1B    [$959C]     ;/
$A3:9581 A9 00 00    LDA #$0000             ;\
$A3:9584 8D 99 07    STA $0799  [$7E:0799]  ;} Elevator direction = down
$A3:9587 BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\
$A3:958A 18          CLC                    ;|
$A3:958B 69 00 80    ADC #$8000             ;|
$A3:958E 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y position += 1.8000h
$A3:9591 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A3:9594 69 01 00    ADC #$0001             ;|
$A3:9597 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A3:959A 80 19       BRA $19    [$95B5]

$A3:959C A9 00 80    LDA #$8000             ;\ Else ([enemy parameter 1] != 0):
$A3:959F 8D 99 07    STA $0799  [$7E:0799]  ;} Elevator direction = up
$A3:95A2 BD 80 0F    LDA $0F80,x[$7E:1000]  ;\
$A3:95A5 38          SEC                    ;|
$A3:95A6 E9 00 80    SBC #$8000             ;|
$A3:95A9 9D 80 0F    STA $0F80,x[$7E:1000]  ;} Enemy Y position -= 1.8000h
$A3:95AC BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$A3:95AF E9 01 00    SBC #$0001             ;|
$A3:95B2 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/

$A3:95B5 20 12 96    JSR $9612  [$A3:9612]  ; Place Samus on top of elevator
$A3:95B8 60          RTS
}


;;; $95B9: Elevator AI - elevator status = 2: door transition ;;;
{
$A3:95B9 EE 18 0E    INC $0E18  [$7E:0E18]  ; Elevator status = entering room
}


;;; $95BC: Elevator AI - elevator status = 3: entering room ;;;
{
$A3:95BC AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A3:95BF BD B4 0F    LDA $0FB4,x[$7E:1034]  ;} If [enemy parameter 1] != 0:
$A3:95C2 F0 1A       BEQ $1A    [$95DE]     ;/
$A3:95C4 BD 80 0F    LDA $0F80,x[$7E:1000]  ;\
$A3:95C7 18          CLC                    ;|
$A3:95C8 69 00 80    ADC #$8000             ;|
$A3:95CB 9D 80 0F    STA $0F80,x[$7E:1000]  ;} Enemy Y position += 1.8000h
$A3:95CE BD 7E 0F    LDA $0F7E,x[$7E:0FFE]  ;|
$A3:95D1 69 01 00    ADC #$0001             ;|
$A3:95D4 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;/
$A3:95D7 DD A8 0F    CMP $0FA8,x[$7E:1028]  ;\
$A3:95DA B0 1C       BCS $1C    [$95F8]     ;} If [enemy Y position] < [enemy $0FA8]:
$A3:95DC 80 34       BRA $34    [$9612]     ; Go to place Samus on top of elevator

$A3:95DE BD 80 0F    LDA $0F80,x[$7E:0F80]  ;\ Else ([enemy parameter 1] = 0):
$A3:95E1 38          SEC                    ;|
$A3:95E2 E9 00 80    SBC #$8000             ;|
$A3:95E5 9D 80 0F    STA $0F80,x[$7E:0F80]  ;} Enemy Y position -= 1.8000h
$A3:95E8 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A3:95EB E9 01 00    SBC #$0001             ;|
$A3:95EE 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;/
$A3:95F1 DD A8 0F    CMP $0FA8,x[$7E:0FA8]  ;\
$A3:95F4 90 02       BCC $02    [$95F8]     ;} If [enemy Y position] >= [enemy $0FA8]:
$A3:95F6 80 1A       BRA $1A    [$9612]     ; Go to place Samus on top of elevator

$A3:95F8 9C 18 0E    STZ $0E18  [$7E:0E18]  ; Elevator status = inactive
$A3:95FB 9C 16 0E    STZ $0E16  [$7E:0E16]  ; Elevator properties = 0
$A3:95FE A9 25 00    LDA #$0025             ;\
$A3:9601 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 25h, sound library 3, max queued sounds allowed = 6 (silence)
$A3:9605 BD A8 0F    LDA $0FA8,x[$7E:1028]  ;\
$A3:9608 9D 7E 0F    STA $0F7E,x[$7E:0FFE]  ;} Enemy Y position = [enemy $0FA8]
$A3:960B A9 0B 00    LDA #$000B             ; A = Bh
$A3:960E 22 84 F0 90 JSL $90F084[$90:F084]  ; Execute $90:F084
}


;;; $9612: Place Samus on top of elevator ;;;
{
$A3:9612 AE 54 0E    LDX $0E54  [$7E:0E54]  ;\
$A3:9615 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A3:9618 38          SEC                    ;} Samus Y position = [enemy Y position] - 1Ah
$A3:9619 E9 1A 00    SBC #$001A             ;|
$A3:961C 8D FA 0A    STA $0AFA  [$7E:0AFA]  ;/
$A3:961F 9C FC 0A    STZ $0AFC  [$7E:0AFC]  ; Samus Y subposition = 0
$A3:9622 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A3:9625 8D F6 0A    STA $0AF6  [$7E:0AF6]  ;} Samus X position = [enemy X position]
$A3:9628 9C 2E 0B    STZ $0B2E  [$7E:0B2E]  ; Samus Y speed = 0
$A3:962B 9C 2C 0B    STZ $0B2C  [$7E:0B2C]  ; Samus Y subspeed = 0
$A3:962E 60          RTS
}


;;; $962F: Spritemaps - elevator ;;;
{
$A3:962F             dx 0004, 01F2,FC,6A6C, 0006,FC,6A6C, 0000,FC,6A6C, 01F8,FC,2A6C
$A3:9645             dx 0004, 0000,FC,6A6E, 0008,FC,6A6D, 01F8,FC,2A6E, 01F0,FC,2A6D
}
}


;;; $965B..980A: Crab ;;;
{
;;; $965B: Palette - enemy $D77F (crab) ;;;
{
$A3:965B             dw 3800, 3EDF, 0018, 000F, 0005, 01DD, 0118, 0093, 002F, 7FE0, 7DA0, 48E0, 30A0, 3BE0, 2680, 1580
}


;;; $967B: Instruction list -  ;;;
{
$A3:967B             dx E660,E6C8   ; Enemy $0FB2 = $E6C8
$A3:967F             dx 0008,9745,
                        0008,975B,
                        0008,9771,
                        0008,975B,
                        80ED,967F   ; Go to $967F
}


;;; $9693: Instruction list -  ;;;
{
$A3:9693             dx E660,E6C8   ; Enemy $0FB2 = $E6C8
$A3:9697             dx 0008,97C9,
                        0008,97DF,
                        0008,97F5,
                        0008,97DF,
                        80ED,9697   ; Go to $9697
}


;;; $96AB: Instruction list -  ;;;
{
$A3:96AB             dx E660,E7F2   ; Enemy $0FB2 = $E7F2
$A3:96AF             dx 0008,9787,
                        0008,979D,
                        0008,97B3,
                        0008,979D,
                        80ED,96AF   ; Go to $96AF
}


;;; $96C3: Instruction list -  ;;;
{
$A3:96C3             dx E660,E7F2   ; Enemy $0FB2 = $E7F2
$A3:96C7             dx 0008,9703,
                        0008,9719,
                        0008,972F,
                        0008,9719,
                        80ED,96C7   ; Go to $96C7
}


;;; $96DB: Instruction list pointers ;;;
{
$A3:96DB             dw 967B, 9693, 96AB, 96C3
}


;;; $96E3: Initialisation AI - enemy $D77F (crab) ;;;
{
$A3:96E3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:96E6 A9 08 00    LDA #$0008
$A3:96E9 9D B6 0F    STA $0FB6,x[$7E:10B6]
$A3:96EC BD 92 0F    LDA $0F92,x[$7E:1092]
$A3:96EF 29 03 00    AND #$0003
$A3:96F2 0A          ASL A
$A3:96F3 A8          TAY
$A3:96F4 B9 DB 96    LDA $96DB,y[$A3:96E1]
$A3:96F7 9D 92 0F    STA $0F92,x[$7E:1092]
$A3:96FA 4C 7A E6    JMP $E67A  [$A3:E67A]  ; Go to creepy crawly common initialisation AI
}


;;; $96FD:  ;;;
{
$A3:96FD AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9700 6B          RTL
}


;;; $9701: RTL ;;;
{
$A3:9701 6B          RTL
}


;;; $9702: RTL ;;;
{
$A3:9702 6B          RTL
}


;;; $9703: Crab spritemaps ;;;
{
$A3:9703             dx 0004, 81FF,F3,6106, 81F3,F4,2106, 8000,FC,6104, 81F0,FC,2100
$A3:9719             dx 0004, 81FE,F3,6106, 81F2,F3,2106, 8000,FB,6102, 81F0,FB,2102
$A3:972F             dx 0004, 81FD,F4,6106, 81F1,F3,2106, 8000,FC,6100, 81F0,FC,2104
$A3:9745             dx 0004, 81FD,FF,A10E, 81FC,F3,210E, 81F4,00,A10C, 81F4,F0,2108
$A3:975B             dx 0004, 81FD,FE,A10E, 81FD,F2,210E, 81F5,00,A10A, 81F5,F0,210A
$A3:9771             dx 0004, 81FC,FD,A10E, 81FD,F1,210E, 81F4,00,A108, 81F4,F0,210C
$A3:9787             dx 0004, 81FF,FD,E106, 81F3,FC,A106, 8000,F4,E104, 81F0,F4,A100
$A3:979D             dx 0004, 81FE,FD,E106, 81F2,FD,A106, 8000,F5,E102, 81F0,F5,A102
$A3:97B3             dx 0004, 81FD,FC,E106, 81F1,FD,A106, 8000,F4,E100, 81F0,F4,A104
$A3:97C9             dx 0004, 81F3,FF,E10E, 81F4,F3,610E, 81FC,00,E10C, 81FC,F0,6108
$A3:97DF             dx 0004, 81F3,FE,E10E, 81F3,F2,610E, 81FB,00,E10A, 81FB,F0,610A
$A3:97F5             dx 0004, 81F4,FD,E10E, 81F3,F1,610E, 81FC,00,E108, 81FC,F0,610C
}
}


;;; $980B..9B7A: Slug ;;;
{
;;; $980B: Palette - enemy $D7BF (slug) ;;;
{
$A3:980B             dw 3800, 57F5, 4AEF, 1182, 00C0, 5752, 3EAD, 2E08, 25C6, 03FD, 02D5, 020F, 0149, 3EDF, 0018, 000F
}


;;; $982B..992A: Instruction lists - slug ;;;
{
;;; $982B: Instruction list -  ;;;
{
$A3:982B             dx E660,E6C8,  ; Enemy $0FB2 = E6C8h
                        0004,9AAF,
                        0004,9AC0,
                        0004,9AD1,
                        0004,9AE2,
                        0004,9AD1,
                        0004,9AC0,
                        80ED,982F   ; Go to $982F
}


;;; $984B: Instruction list -  ;;;
{
$A3:984B             dx E660,E6C8,  ; Enemy $0FB2 = E6C8h
                        0004,9B37,
                        0004,9B48,
                        0004,9B59,
                        0004,9B6A,
                        0004,9B59,
                        0004,9B48,
                        80ED,984F   ; Go to $984F
}


;;; $986B: Instruction list -  ;;;
{
$A3:986B             dx E660,E6C8,  ; Enemy $0FB2 = E6C8h
                        0004,9A27,
                        0004,9A38,
                        0004,9A49,
                        0004,9A5A,
                        0004,9A49,
                        0004,9A38,
                        80ED,986F   ; Go to $986F
}


;;; $988B: Instruction list -  ;;;
{
$A3:988B             dx E660,E6C8,  ; Enemy $0FB2 = E6C8h
                        0004,999F,
                        0004,99B0,
                        0004,99C1,
                        0004,99D2,
                        0004,99C1,
                        0004,99B0,
                        80ED,988F   ; Go to $988F
}


;;; $98AB: Instruction list -  ;;;
{
$A3:98AB             dx E660,E7F2,  ; Enemy $0FB2 = E7F2h
                        0004,99E3,
                        0004,99F4,
                        0004,9A05,
                        0004,9A16,
                        0004,9A05,
                        0004,99F4,
                        80ED,98AF   ; Go to $98AF
}


;;; $98CB: Instruction list -  ;;;
{
$A3:98CB             dx E660,E7F2,  ; Enemy $0FB2 = E7F2h
                        0004,9A6B,
                        0004,9A7C,
                        0004,9A8D,
                        0004,9A9E,
                        0004,9A8D,
                        0004,9A7C,
                        80ED,98CF   ; Go to $98CF
}


;;; $98EB: Instruction list -  ;;;
{
$A3:98EB             dx E660,E7F2,  ; Enemy $0FB2 = E7F2h
                        0004,9AF3,
                        0004,9B04,
                        0004,9B15,
                        0004,9B26,
                        0004,9B15,
                        0004,9B04,
                        80ED,98EF   ; Go to $98EF
}


;;; $990B: Instruction list -  ;;;
{
$A3:990B             dx E660,E7F2,  ; Enemy $0FB2 = E7F2h
                        0004,995B,
                        0004,996C,
                        0004,997D,
                        0004,998E,
                        0004,997D,
                        0004,996C,
                        80ED,990F   ; Go to $990F
}
}


;;; $992B: Slug instruction list pointers ;;;
{
$A3:992B             dw 984B, 988B, 98AB, 990B, 982B, 986B, 98CB, 98EB
}


;;; $993B: Initialisation AI - enemy $D7BF (slug) ;;;
{
$A3:993B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:993E A9 0A 00    LDA #$000A
$A3:9941 9D B6 0F    STA $0FB6,x[$7E:0FF6]
$A3:9944 BD 92 0F    LDA $0F92,x[$7E:0FD2]
$A3:9947 29 03 00    AND #$0003
$A3:994A 0A          ASL A
$A3:994B A8          TAY
$A3:994C B9 2B 99    LDA $992B,y[$A3:9931]
$A3:994F 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:9952 4C 7A E6    JMP $E67A  [$A3:E67A]  ; Go to creepy crawly common initialisation AI
}


;;; $9955:  ;;;
{
$A3:9955 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9958 6B          RTL
}


;;; $9959: RTL ;;;
{
$A3:9959 6B          RTL
}


;;; $995A: RTL ;;;
{
$A3:995A 6B          RTL
}


;;; $995B: Slug spritemaps ;;;
{
$A3:995B             dx 0003, 8000,F8,2104, 81FA,F8,2102, 81F1,F8,2100
$A3:996C             dx 0003, 8000,F8,2104, 81FA,F8,2102, 81F0,F8,2100
$A3:997D             dx 0003, 8001,F8,2104, 81FA,F8,2102, 81EF,F8,2100
$A3:998E             dx 0003, 8002,F8,2104, 81FA,F8,2102, 81EE,F8,2100
$A3:999F             dx 0003, 81F8,00,610A, 81F8,FA,6108, 81F8,F1,6106
$A3:99B0             dx 0003, 81F8,00,610A, 81F8,FA,6108, 81F8,F0,6106
$A3:99C1             dx 0003, 81F8,01,610A, 81F8,FA,6108, 81F8,EF,6106
$A3:99D2             dx 0003, 81F8,02,610A, 81F8,FA,6108, 81F8,EE,6106
$A3:99E3             dx 0003, 81F0,F8,E104, 81F6,F8,E102, 81FF,F8,E100
$A3:99F4             dx 0003, 81F0,F8,E104, 81F6,F8,E102, 8000,F8,E100
$A3:9A05             dx 0003, 81EF,F8,E104, 81F6,F8,E102, 8001,F8,E100
$A3:9A16             dx 0003, 81EE,F8,E104, 81F6,F8,E102, 8002,F8,E100
$A3:9A27             dx 0003, 81F8,F0,E10A, 81F8,F6,E108, 81F8,FF,E106
$A3:9A38             dx 0003, 81F8,F0,E10A, 81F8,F6,E108, 81F8,00,E106
$A3:9A49             dx 0003, 81F8,EF,E10A, 81F8,F6,E108, 81F8,01,E106
$A3:9A5A             dx 0003, 81F8,EE,E10A, 81F8,F6,E108, 81F8,02,E106
$A3:9A6B             dx 0003, 8000,F8,A104, 81FA,F8,A102, 81F1,F8,A100
$A3:9A7C             dx 0003, 8000,F8,A104, 81FA,F8,A102, 81F0,F8,A100
$A3:9A8D             dx 0003, 8001,F8,A104, 81FA,F8,A102, 81EF,F8,A100
$A3:9A9E             dx 0003, 8002,F8,A104, 81FA,F8,A102, 81EE,F8,A100
$A3:9AAF             dx 0003, 81F8,00,210A, 81F8,FA,2108, 81F8,F1,2106
$A3:9AC0             dx 0003, 81F8,00,210A, 81F8,FA,2108, 81F8,F0,2106
$A3:9AD1             dx 0003, 81F8,01,210A, 81F8,FA,2108, 81F8,EF,2106
$A3:9AE2             dx 0003, 81F8,02,210A, 81F8,FA,2108, 81F8,EE,2106
$A3:9AF3             dx 0003, 81F0,F8,6104, 81F6,F8,6102, 81FF,F8,6100
$A3:9B04             dx 0003, 81F0,F8,6104, 81F6,F8,6102, 8000,F8,6100
$A3:9B15             dx 0003, 81EF,F8,6104, 81F6,F8,6102, 8001,F8,6100
$A3:9B26             dx 0003, 81EE,F8,6104, 81F6,F8,6102, 8002,F8,6100
$A3:9B37             dx 0003, 81F8,F0,A10A, 81F8,F6,A108, 81F8,FF,A106
$A3:9B48             dx 0003, 81F8,F0,A10A, 81F8,F6,A108, 81F8,00,A106
$A3:9B59             dx 0003, 81F8,EF,A10A, 81F8,F6,A108, 81F8,01,A106
$A3:9B6A             dx 0003, 81F8,EE,A10A, 81F8,F6,A108, 81F8,02,A106
}
}


;;; $9B7B..A050: Platforms ;;;
{
;;; $9B7B: Palette - enemy $D7FF (fast-moving slowly-sinking platform) ;;;
{
$A3:9B7B             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 7F5A, 7EC0, 6DE0, 54E0, 03FF, 0237, 00D1
}


;;; $9B9B: Palette - enemy $D83F (platform that falls with Samus weight) ;;;
{
$A3:9B9B             dw 3800, 7F5A, 3BE0, 2680, 0920, 4F5A, 36B5, 2610, 1DCE, 5294, 39CE, 2108, 1084, 033B, 0216, 0113
}


;;; $9BBB..9C6A: Instruction lists - sinking platforms ;;;
{
;;; $9BBB: Instruction list -  ;;;
{
$A3:9BBB             dx 9C81,       ; ???
                        000A,A021,
                        000A,A02D,
                        000A,A039,
                        000A,A045,
                        80ED,9BBD   ; Go to $9BBD
}


;;; $9BD1: Instruction list -  ;;;
{
$A3:9BD1             dx 9C8C,       ; ???
                        000A,A021,
                        000A,A02D,
                        000A,A039,
                        000A,A045,
                        80ED,9BD3   ; Go to $9BD3
}


;;; $9BE7: Instruction list -  ;;;
{
$A3:9BE7             dx 9C6B,       ; ???
                        000A,A021,
                        000A,A02D,
                        000A,A039,
                        000A,A045,
                        80ED,9BE9   ; Go to $9BE9
}


;;; $9BFD: Instruction list -  ;;;
{
$A3:9BFD             dx 9C76,       ; ???
                        000A,A021,
                        000A,A02D,
                        000A,A039,
                        000A,A045,
                        80ED,9BFF   ; Go to $9BFF
}


;;; $9C13: Instruction list -  ;;;
{
$A3:9C13             dx 9C81,       ; ???
                        0007,9F29,
                        0008,9F3A,
                        0007,9F29,
                        0008,9F4B,
                        80ED,9C15   ; Go to $9C15
}


;;; $9C29: Instruction list -  ;;;
{
$A3:9C29             dx 9C8C,       ; ???
                        0007,9F5C,
                        0008,9F6D,
                        0007,9F5C,
                        0008,9F7E,
                        80ED,9C2B   ; Go to $9C2B
}


;;; $9C3F: Instruction list -  ;;;
{
$A3:9C3F             dx 9C6B,       ; ???
                        0007,9F8F,
                        0008,9FA5,
                        0007,9F8F,
                        0008,9FB6,
                        80ED,9C41   ; Go to $9C41
}


;;; $9C55: Instruction list -  ;;;
{
$A3:9C55             dx 9C76,       ; ???
                        0007,9FCC,
                        0008,9FE2,
                        0007,9FCC,
                        0008,9FF3,
                        80ED,9C57   ; Go to $9C57
}
}


;;; $9C6B: Instruction ;;;
{
$A3:9C6B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9C6E A9 00 00    LDA #$0000
$A3:9C71 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:9C75 6B          RTL
}


;;; $9C76: Instruction ;;;
{
$A3:9C76 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9C79 A9 01 00    LDA #$0001
$A3:9C7C 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:9C80 6B          RTL
}


;;; $9C81: Instruction ;;;
{
$A3:9C81 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9C84 A9 00 00    LDA #$0000
$A3:9C87 9F 04 78 7E STA $7E7804,x[$7E:7A44]
$A3:9C8B 6B          RTL
}


;;; $9C8C: Instruction ;;;
{
$A3:9C8C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9C8F A9 01 00    LDA #$0001
$A3:9C92 9F 04 78 7E STA $7E7804,x
$A3:9C96 6B          RTL
}


;;; $9C97:  ;;;
{
$A3:9C97             dw 9D5E, 9D83, 9DA8, 9DE4
}


;;; $9C9F: Initialisation AI - enemy $D83F (platform that falls with Samus weight) ;;;
{
$A3:9C9F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9CA2 A9 FF FF    LDA #$FFFF
$A3:9CA5 9F 3E 78 7E STA $7E783E,x[$7E:79BE]
$A3:9CA9 A0 E7 9B    LDY #$9BE7
$A3:9CAC BD B4 0F    LDA $0FB4,x[$7E:1134]
$A3:9CAF 9F 04 78 7E STA $7E7804,x[$7E:7984]
$A3:9CB3 F0 17       BEQ $17    [$9CCC]
$A3:9CB5 A0 FD 9B    LDY #$9BFD
$A3:9CB8 80 12       BRA $12    [$9CCC]
}


;;; $9CBA: Initialisation AI - enemy $D7FF (fast-moving slowly-sinking platform) ;;;
{
$A3:9CBA AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9CBD A0 3F 9C    LDY #$9C3F
$A3:9CC0 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:9CC3 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:9CC7 F0 03       BEQ $03    [$9CCC]
$A3:9CC9 A0 55 9C    LDY #$9C55
}


;;; $9CCC: Sinking platform enemy common initialisation AI ;;;
{
$A3:9CCC 98          TYA
$A3:9CCD 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:9CD0 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A3:9CD3 29 FF 00    AND #$00FF
$A3:9CD6 0A          ASL A
$A3:9CD7 0A          ASL A
$A3:9CD8 0A          ASL A
$A3:9CD9 A8          TAY
$A3:9CDA B9 87 81    LDA $8187,y[$A3:8207]
$A3:9CDD 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:9CE0 B9 89 81    LDA $8189,y[$A3:8209]
$A3:9CE3 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:9CE6 B9 8B 81    LDA $818B,y[$A3:820B]
$A3:9CE9 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A3:9CEC B9 8D 81    LDA $818D,y[$A3:820D]
$A3:9CEF 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:9CF2 A9 00 00    LDA #$0000
$A3:9CF5 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:9CF9 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:9CFD 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:9D01 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A3:9D04 1A          INC A
$A3:9D05 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:9D08 9E B2 0F    STZ $0FB2,x[$7E:0FB2]
$A3:9D0B BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A3:9D0E 29 FF 00    AND #$00FF
$A3:9D11 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A3:9D15 6B          RTL
}


;;; $9D16: Main AI - enemy $D7FF/$D83F (fast-moving slowly-sinking platform / platform that falls with Samus weight) ;;;
{
$A3:9D16 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9D19 A9 00 00    LDA #$0000
$A3:9D1C 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:9D20 22 E7 AB A0 JSL $A0ABE7[$A0:ABE7]  ;\
$A3:9D24 F0 07       BEQ $07    [$9D2D]     ;} If enemy is touching Samus from below:
$A3:9D26 A9 01 00    LDA #$0001
$A3:9D29 9F 00 78 7E STA $7E7800,x[$7E:7840]

$A3:9D2D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9D30 BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A3:9D34 0A          ASL A
$A3:9D35 AA          TAX
$A3:9D36 FC 97 9C    JSR ($9C97,x)[$A3:9D5E]
$A3:9D39 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9D3C BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A3:9D40 0A          ASL A
$A3:9D41 AA          TAX
$A3:9D42 FC 9B 9C    JSR ($9C9B,x)[$A3:9DA8]
$A3:9D45 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9D48 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A3:9D4C DF 0C 78 7E CMP $7E780C,x[$7E:780C]
$A3:9D50 F0 03       BEQ $03    [$9D55]
$A3:9D52 9E B2 0F    STZ $0FB2,x[$7E:0FF2]

$A3:9D55 BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A3:9D59 9F 0C 78 7E STA $7E780C,x[$7E:780C]
$A3:9D5D 6B          RTL
}


;;; $9D5E:  ;;;
{
$A3:9D5E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9D61 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A3:9D64 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A3:9D68 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A3:9D6B 85 12       STA $12    [$7E:0012]  ;|
$A3:9D6D BD B0 0F    LDA $0FB0,x[$7E:0FB0]  ;} Move enemy right by [enemy X velocity]
$A3:9D70 85 14       STA $14    [$7E:0014]  ;|
$A3:9D72 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:9D76 90 0A       BCC $0A    [$9D82]     ; If collided with wall:
$A3:9D78 A9 01 00    LDA #$0001
$A3:9D7B 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:9D7F 20 9E 9E    JSR $9E9E  [$A3:9E9E]

$A3:9D82 60          RTS
}


;;; $9D83:  ;;;
{
$A3:9D83 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9D86 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A3:9D89 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A3:9D8D BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A3:9D90 85 12       STA $12    [$7E:0012]  ;|
$A3:9D92 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;} Move enemy right by [enemy X velocity]
$A3:9D95 85 14       STA $14    [$7E:0014]  ;|
$A3:9D97 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:9D9B 90 0A       BCC $0A    [$9DA7]     ; If collided with wall:
$A3:9D9D A9 00 00    LDA #$0000
$A3:9DA0 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:9DA4 20 81 9E    JSR $9E81  [$A3:9E81]

$A3:9DA7 60          RTS
}


;;; $9DA8:  ;;;
{
$A3:9DA8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9DAB BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A3:9DAE DD A8 0F    CMP $0FA8,x[$7E:0FA8]
$A3:9DB1 30 2A       BMI $2A    [$9DDD]
$A3:9DB3 20 BB 9E    JSR $9EBB  [$A3:9EBB]
$A3:9DB6 FE B2 0F    INC $0FB2,x[$7E:11F2]
$A3:9DB9 BD B2 0F    LDA $0FB2,x[$7E:11F2]
$A3:9DBC DF 0A 78 7E CMP $7E780A,x[$7E:7A4A]
$A3:9DC0 30 07       BMI $07    [$9DC9]
$A3:9DC2 BF 0A 78 7E LDA $7E780A,x[$7E:78CA]
$A3:9DC6 9D B2 0F    STA $0FB2,x[$7E:1072]

$A3:9DC9 0A          ASL A                  ;\
$A3:9DCA 0A          ASL A                  ;|
$A3:9DCB 0A          ASL A                  ;} Y = [enemy $0FB2] * 8 (quadratic speed table index)
$A3:9DCC A8          TAY                    ;/
$A3:9DCD B9 93 83    LDA $8393,y[$A3:841B]  ;\
$A3:9DD0 85 12       STA $12    [$7E:0012]  ;|
$A3:9DD2 B9 95 83    LDA $8395,y[$A3:841D]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A3:9DD5 85 14       STA $14    [$7E:0014]  ;/
$A3:9DD7 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:9DDB 90 06       BCC $06    [$9DE3]     ; If not collided with block: return

$A3:9DDD 9E B2 0F    STZ $0FB2,x[$7E:0FB2]
$A3:9DE0 20 E1 9E    JSR $9EE1  [$A3:9EE1]

$A3:9DE3 60          RTS
}


;;; $9DE4:  ;;;
{
$A3:9DE4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9DE7 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A3:9DEA DD A8 0F    CMP $0FA8,x[$7E:0FE8]
$A3:9DED 20 46 9E    JSR $9E46  [$A3:9E46]
$A3:9DF0 FE B2 0F    INC $0FB2,x[$7E:0FF2]
$A3:9DF3 BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:9DF6 DF 0A 78 7E CMP $7E780A,x[$7E:784A]
$A3:9DFA 30 07       BMI $07    [$9E03]
$A3:9DFC BF 0A 78 7E LDA $7E780A,x[$7E:784A]
$A3:9E00 9D B2 0F    STA $0FB2,x[$7E:0FF2]

$A3:9E03 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A3:9E06 38          SEC                    ;|
$A3:9E07 FF 02 78 7E SBC $7E7802,x[$7E:7842];|
$A3:9E0B 18          CLC                    ;} Extra Samus X displacement += [enemy X position] - [enemy $7E:7802]
$A3:9E0C 6D 58 0B    ADC $0B58  [$7E:0B58]  ;|
$A3:9E0F 8D 58 0B    STA $0B58  [$7E:0B58]  ;/
$A3:9E12 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A3:9E15 9F 02 78 7E STA $7E7802,x[$7E:7842]
$A3:9E19 BD B2 0F    LDA $0FB2,x[$7E:0FF2]  ;\
$A3:9E1C 0A          ASL A                  ;|
$A3:9E1D 0A          ASL A                  ;} Y = [enemy $0FB2] * 8 (quadratic speed table index)
$A3:9E1E 0A          ASL A                  ;|
$A3:9E1F A8          TAY                    ;/
$A3:9E20 B9 8F 83    LDA $838F,y[$A3:8397]  ;\
$A3:9E23 85 12       STA $12    [$7E:0012]  ;|
$A3:9E25 B9 91 83    LDA $8391,y[$A3:8399]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A3:9E28 85 14       STA $14    [$7E:0014]  ;/
$A3:9E2A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:9E2E 90 06       BCC $06    [$9E36]     ; If collided with block:
$A3:9E30 9E B2 0F    STZ $0FB2,x[$7E:1272]
$A3:9E33 20 E1 9E    JSR $9EE1  [$A3:9EE1]

$A3:9E36 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A3:9E39 38          SEC                    ;|
$A3:9E3A FF 02 78 7E SBC $7E7802,x[$7E:7842];|
$A3:9E3E 18          CLC                    ;} Extra Samus Y displacement += [enemy Y position] - [enemy $7E:7802]
$A3:9E3F 6D 5C 0B    ADC $0B5C  [$7E:0B5C]  ;|
$A3:9E42 8D 5C 0B    STA $0B5C  [$7E:0B5C]  ;/
$A3:9E45 60          RTS
}


;;; $9E46: RTS ;;;
{
$A3:9E46 60          RTS
}


;;; $9E47:  ;;;
{
$A3:9E47 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9E4A A0 13 9C    LDY #$9C13
$A3:9E4D BF 3E 78 7E LDA $7E783E,x[$7E:7A7E]
$A3:9E51 10 03       BPL $03    [$9E56]
$A3:9E53 A0 BB 9B    LDY #$9BBB

$A3:9E56 98          TYA
$A3:9E57 9D 92 0F    STA $0F92,x[$7E:11D2]
$A3:9E5A A9 01 00    LDA #$0001
$A3:9E5D 9D 94 0F    STA $0F94,x[$7E:11D4]
$A3:9E60 9E 90 0F    STZ $0F90,x[$7E:11D0]
$A3:9E63 60          RTS
}


;;; $9E64:  ;;;
{
$A3:9E64 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9E67 A0 29 9C    LDY #$9C29
$A3:9E6A BF 3E 78 7E LDA $7E783E,x
$A3:9E6E 10 03       BPL $03    [$9E73]
$A3:9E70 A0 D1 9B    LDY #$9BD1

$A3:9E73 98          TYA
$A3:9E74 9D 92 0F    STA $0F92,x
$A3:9E77 A9 01 00    LDA #$0001
$A3:9E7A 9D 94 0F    STA $0F94,x
$A3:9E7D 9E 90 0F    STZ $0F90,x
$A3:9E80 60          RTS
}


;;; $9E81:  ;;;
{
$A3:9E81 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9E84 A0 3F 9C    LDY #$9C3F
$A3:9E87 BF 3E 78 7E LDA $7E783E,x[$7E:783E]
$A3:9E8B 10 03       BPL $03    [$9E90]
$A3:9E8D A0 E7 9B    LDY #$9BE7

$A3:9E90 98          TYA
$A3:9E91 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:9E94 A9 01 00    LDA #$0001
$A3:9E97 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:9E9A 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A3:9E9D 60          RTS
}


;;; $9E9E:  ;;;
{
$A3:9E9E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9EA1 A0 55 9C    LDY #$9C55
$A3:9EA4 BF 3E 78 7E LDA $7E783E,x[$7E:783E]
$A3:9EA8 10 03       BPL $03    [$9EAD]
$A3:9EAA A0 FD 9B    LDY #$9BFD

$A3:9EAD 98          TYA
$A3:9EAE 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:9EB1 A9 01 00    LDA #$0001
$A3:9EB4 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:9EB7 9E 90 0F    STZ $0F90,x[$7E:0F90]
$A3:9EBA 60          RTS
}


;;; $9EBB:  ;;;
{
$A3:9EBB AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9EBE BF 06 78 7E LDA $7E7806,x[$7E:7A46]
$A3:9EC2 D0 15       BNE $15    [$9ED9]
$A3:9EC4 A9 01 00    LDA #$0001
$A3:9EC7 9F 06 78 7E STA $7E7806,x[$7E:7A46]
$A3:9ECB BF 04 78 7E LDA $7E7804,x[$7E:7A44]
$A3:9ECF F0 05       BEQ $05    [$9ED6]
$A3:9ED1 20 64 9E    JSR $9E64  [$A3:9E64]
$A3:9ED4 80 03       BRA $03    [$9ED9]

$A3:9ED6 20 47 9E    JSR $9E47  [$A3:9E47]

$A3:9ED9 A9 00 00    LDA #$0000
$A3:9EDC 9F 08 78 7E STA $7E7808,x[$7E:7A48]
$A3:9EE0 60          RTS
}


;;; $9EE1:  ;;;
{
$A3:9EE1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9EE4 BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A3:9EE8 D0 15       BNE $15    [$9EFF]
$A3:9EEA A9 01 00    LDA #$0001
$A3:9EED 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:9EF1 BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A3:9EF5 F0 05       BEQ $05    [$9EFC]
$A3:9EF7 20 9E 9E    JSR $9E9E  [$A3:9E9E]
$A3:9EFA 80 03       BRA $03    [$9EFF]

$A3:9EFC 20 81 9E    JSR $9E81  [$A3:9E81]

$A3:9EFF A9 00 00    LDA #$0000
$A3:9F02 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:9F06 60          RTS
}


;;; $9F07: Enemy touch - enemy $D7FF/$D83F (sinking platform) ;;;
{
$A3:9F07 6B          RTL
}


;;; $9F08: Enemy shot - enemy $D7FF (fast-moving slowly-sinking platform) ;;;
{
$A3:9F08 22 2D 80 A3 JSL $A3802D[$A3:802D]
$A3:9F0C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:9F0F BD 9E 0F    LDA $0F9E,x[$7E:10DE]
$A3:9F12 F0 14       BEQ $14    [$9F28]
$A3:9F14 BF 04 78 7E LDA $7E7804,x[$7E:7944]
$A3:9F18 F0 08       BEQ $08    [$9F22]
$A3:9F1A A9 15 A0    LDA #$A015
$A3:9F1D 9D 8E 0F    STA $0F8E,x[$7E:10CE]
$A3:9F20 80 06       BRA $06    [$9F28]

$A3:9F22 A9 09 A0    LDA #$A009
$A3:9F25 9D 8E 0F    STA $0F8E,x

$A3:9F28 6B          RTL
}


;;; $9F29: Sinking platform spritemaps ;;;
{
$A3:9F29             dx 0003, 01F9,08,210E, C200,F8,2102, C3F0,F8,2100
$A3:9F3A             dx 0003, C200,F8,2102, 01F9,08,210F, C3F0,F8,2108
$A3:9F4B             dx 0003, C200,F8,2102, 01F9,08,210F, C3F0,F8,2104
$A3:9F5C             dx 0003, 01FF,08,610E, C3F0,F8,6102, C200,F8,6100
$A3:9F6D             dx 0003, C3F0,F8,6102, 01FF,08,610F, C200,F8,6108
$A3:9F7E             dx 0003, C3F0,F8,6102, 01FF,08,610F, C200,F8,6104
$A3:9F8F             dx 0004, C200,F8,2102, 000B,02,211D, 0003,02,211C, C3F0,F8,2100
$A3:9FA5             dx 0003, C200,F8,2102, 0002,02,211E, C3F0,F8,2104
$A3:9FB6             dx 0004, C200,F8,2102, 000B,02,210D, 0003,02,210C, C3F0,F8,2108
$A3:9FCC             dx 0004, C3F0,F8,6102, 01ED,02,611D, 01F5,02,611C, C200,F8,6100
$A3:9FE2             dx 0003, C3F0,F8,6102, 01F6,02,611E, C200,F8,6104
$A3:9FF3             dx 0004, C3F0,F8,6102, 01ED,02,610D, 01F5,02,610C, C200,F8,6108
$A3:A009             dx 0002, 8000,F8,2102, 81F0,F8,2108
$A3:A015             dx 0002, 81F0,F8,6102, 8000,F8,6108
$A3:A021             dx 0002, 8000,F8,6100, 81F0,F8,2100
$A3:A02D             dx 0002, 8000,F8,6102, 81F0,F8,2102
$A3:A039             dx 0002, 8000,F8,6104, 81F0,F8,2104
$A3:A045             dx 0002, 8000,F8,6106, 81F0,F8,2106
}
}


;;; $A051..A724: Roach ;;;
{
;;; $A051: Palette - enemy $D87F/$D8BF (roach) ;;;
{
$A3:A051             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 435A, 3694, 15AD, 0508, 03FF, 0237, 00D1
}


;;; $A071..A110: Instruction lists - roach ;;;
{
;;; $A071: Instruction list -  ;;;
{
$A3:A071             dx 0005,A67D,
                        0005,A684,
                        0005,A67D,
                        0005,A68B,
                        80ED,A071   ; Go to $A071
}


;;; $A085: Instruction list -  ;;;
{
$A3:A085             dx 0005,A692,
                        0005,A699,
                        0005,A692,
                        0005,A6A0,
                        80ED,A085   ; Go to $A085
}


;;; $A099: Instruction list -  ;;;
{
$A3:A099             dx 0005,A6A7,
                        0005,A6AE,
                        0005,A6A7,
                        0005,A6B5,
                        80ED,A099   ; Go to $A099
}


;;; $A0AD: Instruction list -  ;;;
{
$A3:A0AD             dx 0005,A6BC,
                        0005,A6C3,
                        0005,A6BC,
                        0005,A6CA,
                        80ED,A0AD   ; Go to $A0AD
}


;;; $A0C1: Instruction list -  ;;;
{
$A3:A0C1             dx 0005,A6D1,
                        0005,A6D8,
                        0005,A6D1,
                        0005,A6DF,
                        80ED,A0C1   ; Go to $A0C1
}


;;; $A0D5: Instruction list -  ;;;
{
$A3:A0D5             dx 0005,A6E6,
                        0005,A6ED,
                        0005,A6E6,
                        0005,A6F4,
                        80ED,A0D5   ; Go to $A0D5
}


;;; $A0E9: Instruction list -  ;;;
{
$A3:A0E9             dx 0005,A6FB,
                        0005,A702,
                        0005,A6FB,
                        0005,A709,
                        80ED,A0E9   ; Go to $A0E9
}


;;; $A0FD: Instruction list -  ;;;
{
$A3:A0FD             dx 0005,A710,
                        0005,A717,
                        0005,A710,
                        0005,A71E,
                        80ED,A0FD   ; Go to $A0FD
}
}


;;; $A111: Roach instruction list pointers ;;;
{
$A3:A111             dw A071, A085, A099, A0AD, A0C1, A0D5, A0E9, A0FD,
}


;;; $A121:  ;;;
{
$A3:A121             dw A301, A30B, A34B, A315, A325, A33B, A380
}


;;; $A12F:  ;;;
{
$A3:A12F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A132 BF 08 80 7E LDA $7E8008,x[$7E:8008]
$A3:A136 DF 0A 80 7E CMP $7E800A,x[$7E:800A]
$A3:A13A F0 10       BEQ $10    [$A14C]
$A3:A13C 9F 0A 80 7E STA $7E800A,x[$7E:800A]
$A3:A140 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:A143 A9 01 00    LDA #$0001
$A3:A146 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:A149 9E 90 0F    STZ $0F90,x[$7E:0F90]

$A3:A14C 60          RTS
}


;;; $A14D: Initialisation AI - enemy $D87F/$D8BF (roach) ;;;
{
$A3:A14D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A150 A9 00 00    LDA #$0000
$A3:A153 9F 0A 80 7E STA $7E800A,x[$7E:800A]
$A3:A157 9F 08 80 7E STA $7E8008,x[$7E:8008]
$A3:A15B 20 83 A1    JSR $A183  [$A3:A183]
$A3:A15E 20 F3 A1    JSR $A1F3  [$A3:A1F3]
$A3:A161 20 3E A2    JSR $A23E  [$A3:A23E]
$A3:A164 20 89 A2    JSR $A289  [$A3:A289]
$A3:A167 20 9E A2    JSR $A29E  [$A3:A29E]
$A3:A16A 20 B7 A2    JSR $A2B7  [$A3:A2B7]
$A3:A16D BF 00 80 7E LDA $7E8000,x[$7E:8000]
$A3:A171 A8          TAY
$A3:A172 B9 11 A1    LDA $A111,y[$A3:A117]
$A3:A175 9F 08 80 7E STA $7E8008,x[$7E:8008]
$A3:A179 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A17C A9 D7 A2    LDA #$A2D7
$A3:A17F 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:A182 6B          RTL
}


;;; $A183:  ;;;
{
$A3:A183 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:A186 29 FF 00    AND #$00FF
$A3:A189 85 14       STA $14    [$7E:0014]
$A3:A18B BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A18E 29 FF 00    AND #$00FF
$A3:A191 85 12       STA $12    [$7E:0012]
$A3:A193 22 43 B6 A0 JSL $A0B643[$A0:B643]
$A3:A197 A5 16       LDA $16    [$7E:0016]
$A3:A199 9F 02 78 7E STA $7E7802,x[$7E:7802]
$A3:A19D A5 18       LDA $18    [$7E:0018]
$A3:A19F 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:A1A3 A5 1A       LDA $1A    [$7E:001A]
$A3:A1A5 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:A1A9 A5 1C       LDA $1C    [$7E:001C]
$A3:A1AB 9F 04 78 7E STA $7E7804,x[$7E:7804]
$A3:A1AF 60          RTS
}


;;; $A1B0:  ;;;
{
$A3:A1B0 BD B4 0F    LDA $0FB4,x
$A3:A1B3 29 FF 00    AND #$00FF
$A3:A1B6 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A1B9 BD B5 0F    LDA $0FB5,x
$A3:A1BC 29 FF 00    AND #$00FF
$A3:A1BF 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]
$A3:A1C3 AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A1C6 9F 02 78 7E STA $7E7802,x
$A3:A1CA AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A1CD 9F 00 78 7E STA $7E7800,x
$A3:A1D1 BD B4 0F    LDA $0FB4,x
$A3:A1D4 29 FF 00    AND #$00FF
$A3:A1D7 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A1DA BD B5 0F    LDA $0FB5,x
$A3:A1DD 29 FF 00    AND #$00FF
$A3:A1E0 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:A1E4 AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A1E7 9F 06 78 7E STA $7E7806,x
$A3:A1EB AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A1EE 9F 04 78 7E STA $7E7804,x
$A3:A1F2 60          RTS
}


;;; $A1F3:  ;;;
{
$A3:A1F3 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:A1F6 29 FF 00    AND #$00FF
$A3:A1F9 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A1FC BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A1FF 38          SEC
$A3:A200 E9 20 00    SBC #$0020
$A3:A203 29 FF 00    AND #$00FF
$A3:A206 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]
$A3:A20A AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A20D 9F 0A 78 7E STA $7E780A,x[$7E:780A]
$A3:A211 AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A214 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:A218 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:A21B 29 FF 00    AND #$00FF
$A3:A21E 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A221 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A224 38          SEC
$A3:A225 E9 20 00    SBC #$0020
$A3:A228 29 FF 00    AND #$00FF
$A3:A22B 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:A22F AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A232 9F 0E 78 7E STA $7E780E,x[$7E:780E]
$A3:A236 AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A239 9F 0C 78 7E STA $7E780C,x[$7E:780C]
$A3:A23D 60          RTS
}


;;; $A23E:  ;;;
{
$A3:A23E BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:A241 29 FF 00    AND #$00FF
$A3:A244 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A247 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A24A 18          CLC
$A3:A24B 69 20 00    ADC #$0020
$A3:A24E 29 FF 00    AND #$00FF
$A3:A251 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]
$A3:A255 AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A258 9F 12 78 7E STA $7E7812,x[$7E:7812]
$A3:A25C AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A25F 9F 10 78 7E STA $7E7810,x[$7E:7810]
$A3:A263 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:A266 29 FF 00    AND #$00FF
$A3:A269 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A26C BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A26F 18          CLC
$A3:A270 69 20 00    ADC #$0020
$A3:A273 29 FF 00    AND #$00FF
$A3:A276 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:A27A AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A27D 9F 16 78 7E STA $7E7816,x[$7E:7816]
$A3:A281 AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A284 9F 14 78 7E STA $7E7814,x[$7E:7814]
$A3:A288 60          RTS
}


;;; $A289:  ;;;
{
$A3:A289 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A28C 38          SEC
$A3:A28D E9 30 00    SBC #$0030
$A3:A290 29 FF 00    AND #$00FF
$A3:A293 4A          LSR A
$A3:A294 4A          LSR A
$A3:A295 4A          LSR A
$A3:A296 4A          LSR A
$A3:A297 4A          LSR A
$A3:A298 0A          ASL A
$A3:A299 9F 00 80 7E STA $7E8000,x[$7E:8000]
$A3:A29D 60          RTS
}


;;; $A29E:  ;;;
{
$A3:A29E BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A2A1 38          SEC
$A3:A2A2 E9 30 00    SBC #$0030
$A3:A2A5 38          SEC
$A3:A2A6 E9 20 00    SBC #$0020
$A3:A2A9 29 FF 00    AND #$00FF
$A3:A2AC 4A          LSR A
$A3:A2AD 4A          LSR A
$A3:A2AE 4A          LSR A
$A3:A2AF 4A          LSR A
$A3:A2B0 4A          LSR A
$A3:A2B1 0A          ASL A
$A3:A2B2 9F 02 80 7E STA $7E8002,x[$7E:8002]
$A3:A2B6 60          RTS
}


;;; $A2B7:  ;;;
{
$A3:A2B7 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A2BA 38          SEC
$A3:A2BB E9 30 00    SBC #$0030
$A3:A2BE 18          CLC
$A3:A2BF 69 20 00    ADC #$0020
$A3:A2C2 29 FF 00    AND #$00FF
$A3:A2C5 4A          LSR A
$A3:A2C6 4A          LSR A
$A3:A2C7 4A          LSR A
$A3:A2C8 4A          LSR A
$A3:A2C9 4A          LSR A
$A3:A2CA 0A          ASL A
$A3:A2CB 9F 04 80 7E STA $7E8004,x[$7E:8004]
$A3:A2CF 60          RTS
}


;;; $A2D0: Main AI - enemy $D87F/$D8BF (roach) ;;;
{
$A3:A2D0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A2D3 FC AA 0F    JSR ($0FAA,x)[$A3:A2D7]
$A3:A2D6 6B          RTL
}


;;; $A2D7:  ;;;
{
$A3:A2D7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A2DA BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A3:A2DD 29 FF 00    AND #$00FF
$A3:A2E0 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]
$A3:A2E4 F0 1A       BEQ $1A    [$A300]
$A3:A2E6 BD B6 0F    LDA $0FB6,x[$7E:0FB6]
$A3:A2E9 29 FF 00    AND #$00FF
$A3:A2EC 22 ED AE A0 JSL $A0AEED[$A0:AEED]
$A3:A2F0 F0 0E       BEQ $0E    [$A300]
$A3:A2F2 BD B7 0F    LDA $0FB7,x[$7E:0FB7]
$A3:A2F5 29 FF 00    AND #$00FF
$A3:A2F8 0A          ASL A
$A3:A2F9 A8          TAY
$A3:A2FA B9 21 A1    LDA $A121,y[$A3:A121]
$A3:A2FD 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A3:A300 60          RTS
}


;;; $A301:  ;;;
{
$A3:A301 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A304 A9 07 A4    LDA #$A407
$A3:A307 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:A30A 60          RTS
}


;;; $A30B:  ;;;
{
$A3:A30B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A30E A9 0E A4    LDA #$A40E
$A3:A311 9D AA 0F    STA $0FAA,x
$A3:A314 60          RTS
}


;;; $A315:  ;;;
{
$A3:A315 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A318 A9 0B 00    LDA #$000B             ;\
$A3:A31B 8D E5 05    STA $05E5  [$7E:05E5]  ;} Random number = Bh
$A3:A31E A9 F0 A4    LDA #$A4F0
$A3:A321 9D AA 0F    STA $0FAA,x
$A3:A324 60          RTS
}


;;; $A325:  ;;;
{
$A3:A325 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A328 A9 00 02    LDA #$0200
$A3:A32B 9D A8 0F    STA $0FA8,x
$A3:A32E A9 0B 00    LDA #$000B             ;\
$A3:A331 8D E5 05    STA $05E5  [$7E:05E5]  ;} Random number = Bh
$A3:A334 A9 B6 A4    LDA #$A4B6
$A3:A337 9D AA 0F    STA $0FAA,x
$A3:A33A 60          RTS
}


;;; $A33B:  ;;;
{
$A3:A33B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A33E A9 20 00    LDA #$0020
$A3:A341 9D B2 0F    STA $0FB2,x
$A3:A344 A9 4E A4    LDA #$A44E
$A3:A347 9D AA 0F    STA $0FAA,x
$A3:A34A 60          RTS
}


;;; $A34B:  ;;;
{
$A3:A34B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A34E 22 66 C0 A0 JSL $A0C066[$A0:C066]
$A3:A352 38          SEC
$A3:A353 E9 40 00    SBC #$0040
$A3:A356 49 FF FF    EOR #$FFFF
$A3:A359 1A          INC A
$A3:A35A 18          CLC
$A3:A35B 69 00 01    ADC #$0100
$A3:A35E 29 FF 00    AND #$00FF
$A3:A361 9D AC 0F    STA $0FAC,x
$A3:A364 20 CA A3    JSR $A3CA  [$A3:A3CA]
$A3:A367 20 B5 A3    JSR $A3B5  [$A3:A3B5]
$A3:A36A BF 06 80 7E LDA $7E8006,x
$A3:A36E A8          TAY
$A3:A36F B9 11 A1    LDA $A111,y
$A3:A372 9F 08 80 7E STA $7E8008,x
$A3:A376 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A379 A9 40 A4    LDA #$A440
$A3:A37C 9D AA 0F    STA $0FAA,x
$A3:A37F 60          RTS
}


;;; $A380:  ;;;
{
$A3:A380 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A383 22 66 C0 A0 JSL $A0C066[$A0:C066]
$A3:A387 38          SEC
$A3:A388 E9 40 00    SBC #$0040
$A3:A38B 49 FF FF    EOR #$FFFF
$A3:A38E 1A          INC A
$A3:A38F 18          CLC
$A3:A390 69 80 00    ADC #$0080
$A3:A393 29 FF 00    AND #$00FF
$A3:A396 9D AC 0F    STA $0FAC,x
$A3:A399 20 CA A3    JSR $A3CA  [$A3:A3CA]
$A3:A39C 20 B5 A3    JSR $A3B5  [$A3:A3B5]
$A3:A39F BF 06 80 7E LDA $7E8006,x
$A3:A3A3 A8          TAY
$A3:A3A4 B9 11 A1    LDA $A111,y
$A3:A3A7 9F 08 80 7E STA $7E8008,x
$A3:A3AB 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A3AE A9 47 A4    LDA #$A447
$A3:A3B1 9D AA 0F    STA $0FAA,x
$A3:A3B4 60          RTS
}


;;; $A3B5:  ;;;
{
$A3:A3B5 BD AC 0F    LDA $0FAC,x
$A3:A3B8 38          SEC
$A3:A3B9 E9 30 00    SBC #$0030
$A3:A3BC 29 FF 00    AND #$00FF
$A3:A3BF 4A          LSR A
$A3:A3C0 4A          LSR A
$A3:A3C1 4A          LSR A
$A3:A3C2 4A          LSR A
$A3:A3C3 4A          LSR A
$A3:A3C4 0A          ASL A
$A3:A3C5 9F 06 80 7E STA $7E8006,x
$A3:A3C9 60          RTS
}


;;; $A3CA:  ;;;
{
$A3:A3CA BD B4 0F    LDA $0FB4,x
$A3:A3CD 29 FF 00    AND #$00FF
$A3:A3D0 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A3D3 BD AC 0F    LDA $0FAC,x
$A3:A3D6 22 B2 B0 A0 JSL $A0B0B2[$A0:B0B2]
$A3:A3DA AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A3DD 9F 1A 78 7E STA $7E781A,x
$A3:A3E1 AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A3E4 9F 18 78 7E STA $7E7818,x
$A3:A3E8 BD B4 0F    LDA $0FB4,x
$A3:A3EB 29 FF 00    AND #$00FF
$A3:A3EE 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:A3F1 BD AC 0F    LDA $0FAC,x
$A3:A3F4 22 C6 B0 A0 JSL $A0B0C6[$A0:B0C6]
$A3:A3F8 AD 36 0E    LDA $0E36  [$7E:0E36]
$A3:A3FB 9F 1E 78 7E STA $7E781E,x
$A3:A3FF AD 38 0E    LDA $0E38  [$7E:0E38]
$A3:A402 9F 1C 78 7E STA $7E781C,x
$A3:A406 60          RTS
}


;;; $A407:  ;;;
{
$A3:A407 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A40A 20 78 A5    JSR $A578  [$A3:A578]
$A3:A40D 60          RTS
}


;;; $A40E:  ;;;
{
$A3:A40E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A411 BD A4 0F    LDA $0FA4,x
$A3:A414 29 10 00    AND #$0010
$A3:A417 D0 14       BNE $14    [$A42D]
$A3:A419 BF 02 80 7E LDA $7E8002,x
$A3:A41D A8          TAY
$A3:A41E B9 11 A1    LDA $A111,y
$A3:A421 9F 08 80 7E STA $7E8008,x
$A3:A425 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A428 20 A3 A5    JSR $A5A3  [$A3:A5A3]
$A3:A42B 80 12       BRA $12    [$A43F]

$A3:A42D BF 04 80 7E LDA $7E8004,x
$A3:A431 A8          TAY
$A3:A432 B9 11 A1    LDA $A111,y
$A3:A435 9F 08 80 7E STA $7E8008,x
$A3:A439 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A43C 20 DA A5    JSR $A5DA  [$A3:A5DA]

$A3:A43F 60          RTS
}


;;; $A440:  ;;;
{
$A3:A440 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A443 20 11 A6    JSR $A611  [$A3:A611]
$A3:A446 60          RTS
}


;;; $A447:  ;;;
{
$A3:A447 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A44A 20 11 A6    JSR $A611  [$A3:A611]
$A3:A44D 60          RTS
}


;;; $A44E:  ;;;
{
$A3:A44E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A451 DE B2 0F    DEC $0FB2,x
$A3:A454 30 05       BMI $05    [$A45B]
$A3:A456 20 78 A5    JSR $A578  [$A3:A578]
$A3:A459 80 06       BRA $06    [$A461]

$A3:A45B A9 D7 A2    LDA #$A2D7
$A3:A45E 9D AA 0F    STA $0FAA,x

$A3:A461 60          RTS
}


;;; $A462:  ;;;
{
$A3:A462 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A465 DE B2 0F    DEC $0FB2,x
$A3:A468 30 05       BMI $05    [$A46F]
$A3:A46A 20 48 A6    JSR $A648  [$A3:A648]
$A3:A46D 80 06       BRA $06    [$A475]

$A3:A46F A9 F0 A4    LDA #$A4F0
$A3:A472 9D AA 0F    STA $0FAA,x

$A3:A475 60          RTS
}


;;; $A476:  ;;;
{
$A3:A476 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A479 DE A8 0F    DEC $0FA8,x
$A3:A47C 30 2C       BMI $2C    [$A4AA]
$A3:A47E DE B2 0F    DEC $0FB2,x
$A3:A481 30 2C       BMI $2C    [$A4AF]
$A3:A483 BD 7A 0F    LDA $0F7A,x
$A3:A486 38          SEC
$A3:A487 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A3:A48A 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A3:A48E C9 60 00    CMP #$0060
$A3:A491 10 02       BPL $02    [$A495]
$A3:A493 80 15       BRA $15    [$A4AA]

$A3:A495 BD 7E 0F    LDA $0F7E,x
$A3:A498 38          SEC
$A3:A499 ED FA 0A    SBC $0AFA  [$7E:0AFA]
$A3:A49C 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A3:A4A0 C9 60 00    CMP #$0060
$A3:A4A3 10 02       BPL $02    [$A4A7]
$A3:A4A5 80 03       BRA $03    [$A4AA]

$A3:A4A7 20 2A A5    JSR $A52A  [$A3:A52A]

$A3:A4AA 20 11 A6    JSR $A611  [$A3:A611]
$A3:A4AD 80 06       BRA $06    [$A4B5]

$A3:A4AF A9 B6 A4    LDA #$A4B6
$A3:A4B2 9D AA 0F    STA $0FAA,x

$A3:A4B5 60          RTS
}


;;; $A4B6:  ;;;
{
$A3:A4B6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A4B9 22 11 81 80 JSL $808111[$80:8111]
$A3:A4BD 29 FF 00    AND #$00FF
$A3:A4C0 38          SEC
$A3:A4C1 E9 40 00    SBC #$0040
$A3:A4C4 29 FF 00    AND #$00FF
$A3:A4C7 18          CLC
$A3:A4C8 7D AC 0F    ADC $0FAC,x
$A3:A4CB 9D AC 0F    STA $0FAC,x
$A3:A4CE 20 CA A3    JSR $A3CA  [$A3:A3CA]
$A3:A4D1 20 B5 A3    JSR $A3B5  [$A3:A3B5]
$A3:A4D4 BF 06 80 7E LDA $7E8006,x
$A3:A4D8 A8          TAY
$A3:A4D9 B9 11 A1    LDA $A111,y
$A3:A4DC 9F 08 80 7E STA $7E8008,x
$A3:A4E0 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A4E3 A9 20 00    LDA #$0020
$A3:A4E6 9D B2 0F    STA $0FB2,x
$A3:A4E9 A9 76 A4    LDA #$A476
$A3:A4EC 9D AA 0F    STA $0FAA,x
$A3:A4EF 60          RTS
}


;;; $A4F0:  ;;;
{
$A3:A4F0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A4F3 22 11 81 80 JSL $808111[$80:8111]
$A3:A4F7 29 FF 00    AND #$00FF
$A3:A4FA 38          SEC
$A3:A4FB E9 40 00    SBC #$0040
$A3:A4FE 29 FF 00    AND #$00FF
$A3:A501 18          CLC
$A3:A502 7D AC 0F    ADC $0FAC,x
$A3:A505 9D AC 0F    STA $0FAC,x
$A3:A508 20 CA A3    JSR $A3CA  [$A3:A3CA]
$A3:A50B 20 B5 A3    JSR $A3B5  [$A3:A3B5]
$A3:A50E BF 06 80 7E LDA $7E8006,x
$A3:A512 A8          TAY
$A3:A513 B9 11 A1    LDA $A111,y
$A3:A516 9F 08 80 7E STA $7E8008,x
$A3:A51A 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A51D A9 20 00    LDA #$0020
$A3:A520 9D B2 0F    STA $0FB2,x
$A3:A523 A9 62 A4    LDA #$A462
$A3:A526 9D AA 0F    STA $0FAA,x
$A3:A529 60          RTS
}


;;; $A52A:  ;;;
{
; Note these fixed point negations are all off by 1.0 if the low word is non-zero
$A3:A52A AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A52D BF 1A 78 7E LDA $7E781A,x          ;\
$A3:A531 49 FF FF    EOR #$FFFF             ;|
$A3:A534 1A          INC A                  ;} Negate enemy X velocity
$A3:A535 9F 1A 78 7E STA $7E781A,x          ;/
$A3:A539 BF 18 78 7E LDA $7E7818,x          ;\
$A3:A53D 49 FF FF    EOR #$FFFF             ;|
$A3:A540 1A          INC A                  ;} Negate enemy X subvelocity
$A3:A541 9F 18 78 7E STA $7E7818,x          ;/
$A3:A545 BF 1E 78 7E LDA $7E781E,x          ;\
$A3:A549 49 FF FF    EOR #$FFFF             ;|
$A3:A54C 1A          INC A                  ;} Negate enemy Y velocity
$A3:A54D 9F 1E 78 7E STA $7E781E,x          ;/
$A3:A551 BF 1C 78 7E LDA $7E781C,x          ;\
$A3:A555 49 FF FF    EOR #$FFFF             ;|
$A3:A558 1A          INC A                  ;} Negate enemy Y subvelocity
$A3:A559 9F 1C 78 7E STA $7E781C,x          ;/
$A3:A55D BF 06 80 7E LDA $7E8006,x
$A3:A561 18          CLC
$A3:A562 69 04 00    ADC #$0004
$A3:A565 29 07 00    AND #$0007
$A3:A568 9F 06 80 7E STA $7E8006,x
$A3:A56C A8          TAY
$A3:A56D B9 11 A1    LDA $A111,y
$A3:A570 9F 08 80 7E STA $7E8008,x
$A3:A574 20 2F A1    JSR $A12F  [$A3:A12F]
$A3:A577 60          RTS
}


;;; $A578:  ;;;
{
$A3:A578 BF 02 78 7E LDA $7E7802,x[$7E:7802]
$A3:A57C 8D 24 0E    STA $0E24  [$7E:0E24]
$A3:A57F BF 00 78 7E LDA $7E7800,x[$7E:7800]
$A3:A583 8D 26 0E    STA $0E26  [$7E:0E26]
$A3:A586 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A3:A58A 8D 28 0E    STA $0E28  [$7E:0E28]
$A3:A58D BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A3:A591 8D 2A 0E    STA $0E2A  [$7E:0E2A]
$A3:A594 BD B5 0F    LDA $0FB5,x[$7E:0FB5]
$A3:A597 29 FF 00    AND #$00FF
$A3:A59A 8D 20 0E    STA $0E20  [$7E:0E20]
$A3:A59D 22 91 B6 A0 JSL $A0B691[$A0:B691]
$A3:A5A1 60          RTS
}


;;; $A5A2: RTS ;;;
{
$A3:A5A2 60          RTS
}


;;; $A5A3:  ;;;
{
$A3:A5A3 BD 7A 0F    LDA $0F7A,x
$A3:A5A6 18          CLC
$A3:A5A7 7F 0A 78 7E ADC $7E780A,x
$A3:A5AB 9D 7A 0F    STA $0F7A,x
$A3:A5AE BD 7C 0F    LDA $0F7C,x
$A3:A5B1 18          CLC
$A3:A5B2 7F 08 78 7E ADC $7E7808,x
$A3:A5B6 90 03       BCC $03    [$A5BB]
$A3:A5B8 FE 7A 0F    INC $0F7A,x

$A3:A5BB 9D 7C 0F    STA $0F7C,x
$A3:A5BE BD 7E 0F    LDA $0F7E,x
$A3:A5C1 18          CLC
$A3:A5C2 7F 0E 78 7E ADC $7E780E,x
$A3:A5C6 9D 7E 0F    STA $0F7E,x
$A3:A5C9 BD 80 0F    LDA $0F80,x
$A3:A5CC 18          CLC
$A3:A5CD 7F 0C 78 7E ADC $7E780C,x
$A3:A5D1 90 03       BCC $03    [$A5D6]
$A3:A5D3 FE 7E 0F    INC $0F7E,x

$A3:A5D6 9D 80 0F    STA $0F80,x
$A3:A5D9 60          RTS
}


;;; $A5DA:  ;;;
{
$A3:A5DA BD 7A 0F    LDA $0F7A,x
$A3:A5DD 18          CLC
$A3:A5DE 7F 12 78 7E ADC $7E7812,x
$A3:A5E2 9D 7A 0F    STA $0F7A,x
$A3:A5E5 BD 7C 0F    LDA $0F7C,x
$A3:A5E8 18          CLC
$A3:A5E9 7F 10 78 7E ADC $7E7810,x
$A3:A5ED 90 03       BCC $03    [$A5F2]
$A3:A5EF FE 7A 0F    INC $0F7A,x

$A3:A5F2 9D 7C 0F    STA $0F7C,x
$A3:A5F5 BD 7E 0F    LDA $0F7E,x
$A3:A5F8 18          CLC
$A3:A5F9 7F 16 78 7E ADC $7E7816,x
$A3:A5FD 9D 7E 0F    STA $0F7E,x
$A3:A600 BD 80 0F    LDA $0F80,x
$A3:A603 18          CLC
$A3:A604 7F 14 78 7E ADC $7E7814,x
$A3:A608 90 03       BCC $03    [$A60D]
$A3:A60A FE 7E 0F    INC $0F7E,x

$A3:A60D 9D 80 0F    STA $0F80,x
$A3:A610 60          RTS
}


;;; $A611:  ;;;
{
$A3:A611 BD 7A 0F    LDA $0F7A,x
$A3:A614 18          CLC
$A3:A615 7F 1A 78 7E ADC $7E781A,x
$A3:A619 9D 7A 0F    STA $0F7A,x
$A3:A61C BD 7C 0F    LDA $0F7C,x
$A3:A61F 18          CLC
$A3:A620 7F 18 78 7E ADC $7E7818,x
$A3:A624 90 03       BCC $03    [$A629]
$A3:A626 FE 7A 0F    INC $0F7A,x

$A3:A629 9D 7C 0F    STA $0F7C,x
$A3:A62C BD 7E 0F    LDA $0F7E,x
$A3:A62F 18          CLC
$A3:A630 7F 1E 78 7E ADC $7E781E,x
$A3:A634 9D 7E 0F    STA $0F7E,x
$A3:A637 BD 80 0F    LDA $0F80,x
$A3:A63A 18          CLC
$A3:A63B 7F 1C 78 7E ADC $7E781C,x
$A3:A63F 90 03       BCC $03    [$A644]
$A3:A641 FE 7E 0F    INC $0F7E,x

$A3:A644 9D 80 0F    STA $0F80,x
$A3:A647 60          RTS
}


;;; $A648:  ;;;
{
$A3:A648 BF 18 78 7E LDA $7E7818,x          ;\
$A3:A64C 85 12       STA $12    [$7E:0012]  ;|
$A3:A64E BF 1A 78 7E LDA $7E781A,x          ;} Move enemy right by [enemy X velocity]
$A3:A652 85 14       STA $14    [$7E:0014]  ;|
$A3:A654 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:A658 90 08       BCC $08    [$A662]     ; If collided with wall:
$A3:A65A A9 D7 A2    LDA #$A2D7
$A3:A65D 9D AA 0F    STA $0FAA,x
$A3:A660 80 18       BRA $18    [$A67A]

$A3:A662 BF 1C 78 7E LDA $7E781C,x          ;\
$A3:A666 85 12       STA $12    [$7E:0012]  ;|
$A3:A668 BF 1E 78 7E LDA $7E781E,x          ;} Move enemy down by [enemy Y velocity]
$A3:A66C 85 14       STA $14    [$7E:0014]  ;|
$A3:A66E 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:A672 90 06       BCC $06    [$A67A]     ; If collided with block:
$A3:A674 A9 D7 A2    LDA #$A2D7
$A3:A677 9D AA 0F    STA $0FAA,x

$A3:A67A 60          RTS
}


;;; $A67B: RTL ;;;
{
$A3:A67B 6B          RTL
}


;;; $A67C: RTL ;;;
{
$A3:A67C 6B          RTL
}


;;; $A67D: Roach spritemaps ;;;
{
$A3:A67D             dx 0001, 01FC,FC,3100
$A3:A684             dx 0001, 01FC,FC,3101
$A3:A68B             dx 0001, 01FC,FC,3102
$A3:A692             dx 0001, 01FC,FC,3103
$A3:A699             dx 0001, 01FC,FC,3104
$A3:A6A0             dx 0001, 01FC,FC,3105
$A3:A6A7             dx 0001, 01FC,FC,3106
$A3:A6AE             dx 0001, 01FC,FC,3107
$A3:A6B5             dx 0001, 01FC,FC,3108
$A3:A6BC             dx 0001, 01FC,FC,B103
$A3:A6C3             dx 0001, 01FC,FC,B104
$A3:A6CA             dx 0001, 01FC,FC,B105
$A3:A6D1             dx 0001, 01FC,FC,B100
$A3:A6D8             dx 0001, 01FC,FC,B101
$A3:A6DF             dx 0001, 01FC,FC,B102
$A3:A6E6             dx 0001, 01FC,FC,F103
$A3:A6ED             dx 0001, 01FC,FC,F104
$A3:A6F4             dx 0001, 01FC,FC,F105
$A3:A6FB             dx 0001, 01FC,FC,7106
$A3:A702             dx 0001, 01FC,FC,7107
$A3:A709             dx 0001, 01FC,FC,7108
$A3:A710             dx 0001, 01FC,FC,7103
$A3:A717             dx 0001, 01FC,FC,7104
$A3:A71E             dx 0001, 01FC,FC,7105
}
}


;;; $A725..AA47: Mochtroid ;;;
{
;;; $A725: Palette - enemy $D8FF (mochtroid) ;;;
{
$A3:A725             dw 3800, 3FB7, 2EAD, 0142, 0060, 3B10, 226B, 11C6, 0984, 72FF, 2CDF, 24B9, 1CAF, 2A9D, 19D6, 0D10
}


;;; $A745: Instruction list - not touching Samus ;;;
{
$A3:A745             dx 000E,A9B0,
                        000E,A9D0,
                        000E,A9F0,
                        000E,A9D0,
                        80ED,A745   ; Go to $A745
}


;;; $A759: Instruction list - touching Samus ;;;
{
$A3:A759             dx 0005,AA06,
                        0005,AA1C,
                        0005,AA32,
                        0005,AA1C,
                        80ED,A759   ; Go to $A759
}


;;; $A76D: Mochtroid constants ;;;
{
; Velocities for unused main AI function $A88F
; Indexed by [enemy $0FB0]
$A3:A76D             dw 0002, 0000, FFFE, 0000 ; X velocity
$A3:A775             dw 0000, FFFE, 0000, 0002 ; Y velocity
}


;;; $A77D: Initialisation AI - enemy $D8FF (mochtroid) ;;;
{
; Note respawn crash bug in $A93C, can fix by replacing `JSR $A93C` with `JSR $A942`
$A3:A77D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A780 A9 02 00    LDA #$0002             ;\
$A3:A783 9D 9A 0F    STA $0F9A,x[$7E:0F9A]  ;} Enemy layer = 2
$A3:A786 A9 45 A7    LDA #$A745             ;\
$A3:A789 20 3C A9    JSR $A93C  [$A3:A93C]  ;} Set enemy instruction list to $A745
$A3:A78C 9E B2 0F    STZ $0FB2,x[$7E:0FB2]  ; Enemy function index = 0
$A3:A78F 6B          RTL
}


;;; $A790: Main AI - enemy $D8FF (mochtroid) ;;;
{
$A3:A790 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A793 BD B2 0F    LDA $0FB2,x[$7E:0FB2]  ;\
$A3:A796 0A          ASL A                  ;} X = [enemy function index] * 2
$A3:A797 AA          TAX                    ;/
$A3:A798 DA          PHX                    ;\
$A3:A799 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A3:A79C 9E B2 0F    STZ $0FB2,x[$7E:0FB2]  ;} Enemy function index = 0
$A3:A79F FA          PLX                    ;/
$A3:A7A0 FC A4 A7    JSR ($A7A4,x)[$A3:A7AA]; Execute [$A7A4 + [X]]
$A3:A7A3 6B          RTL

$A3:A7A4             dw A7AA, A8C8, A88F
}


;;; $A7AA: Mochtroid main AI - [enemy $0FB2] = 0: not touching Samus ;;;
{
$A3:A7AA AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A7AD 64 12       STZ $12    [$7E:0012]  ;\
$A3:A7AF 64 14       STZ $14    [$7E:0014]  ;|
$A3:A7B1 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A3:A7B4 38          SEC                    ;|
$A3:A7B5 ED FA 0A    SBC $0AFA  [$7E:0AFA]  ;|
$A3:A7B8 4A          LSR A                  ;|
$A3:A7B9 4A          LSR A                  ;} $14.$12 = ([enemy Y position] - [Samus Y position]) / 400h
$A3:A7BA 85 13       STA $13    [$7E:0013]  ;|
$A3:A7BC 29 00 20    AND #$2000             ;|
$A3:A7BF F0 07       BEQ $07    [$A7C8]     ;|
$A3:A7C1 A5 14       LDA $14    [$7E:0014]  ;|
$A3:A7C3 09 C0 FF    ORA #$FFC0             ;|
$A3:A7C6 85 14       STA $14    [$7E:0014]  ;/

$A3:A7C8 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:A7CB 38          SEC                    ;|
$A3:A7CC E5 12       SBC $12    [$7E:0012]  ;|
$A3:A7CE 9D AC 0F    STA $0FAC,x[$7E:0FAC]  ;} Enemy Y velocity -= [$14].[$12]
$A3:A7D1 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;|
$A3:A7D4 E5 14       SBC $14    [$7E:0014]  ;|
$A3:A7D6 9D AE 0F    STA $0FAE,x[$7E:0FAE]  ;/
$A3:A7D9 30 0A       BMI $0A    [$A7E5]     ;\
$A3:A7DB C9 03 00    CMP #$0003             ;|
$A3:A7DE 90 13       BCC $13    [$A7F3]     ;|
$A3:A7E0 A9 03 00    LDA #$0003             ;|
$A3:A7E3 80 08       BRA $08    [$A7ED]     ;|
                                            ;|
$A3:A7E5 C9 FD FF    CMP #$FFFD             ;} Enemy Y velocity = clamp([enemy Y velocity], -3.0, 3.0)
$A3:A7E8 B0 09       BCS $09    [$A7F3]     ;|
$A3:A7EA A9 FD FF    LDA #$FFFD             ;|
                                            ;|
$A3:A7ED 9D AE 0F    STA $0FAE,x[$7E:10EE]  ;|
$A3:A7F0 9E AC 0F    STZ $0FAC,x[$7E:10EC]  ;/

$A3:A7F3 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:A7F6 D0 0B       BNE $0B    [$A803]     ;|
$A3:A7F8 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;|
$A3:A7FB D0 06       BNE $06    [$A803]     ;} >_<;
$A3:A7FD 9E AC 0F    STZ $0FAC,x[$7E:0FEC]  ;|
$A3:A800 9E AE 0F    STZ $0FAE,x[$7E:0FEE]  ;/

$A3:A803 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:A806 85 12       STA $12    [$7E:0012]  ;|
$A3:A808 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;} Move enemy down by [enemy Y velocity]
$A3:A80B 85 14       STA $14    [$7E:0014]  ;|
$A3:A80D 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:A811 90 06       BCC $06    [$A819]     ; If collided with block:
$A3:A813 9E AC 0F    STZ $0FAC,x[$7E:0FAC]  ;\
$A3:A816 9E AE 0F    STZ $0FAE,x[$7E:0FAE]  ;} Enemy Y velocity = 0.0

$A3:A819 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A81C 64 12       STZ $12    [$7E:0012]  ;\
$A3:A81E 64 14       STZ $14    [$7E:0014]  ;|
$A3:A820 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;|
$A3:A823 38          SEC                    ;|
$A3:A824 ED F6 0A    SBC $0AF6  [$7E:0AF6]  ;|
$A3:A827 4A          LSR A                  ;|
$A3:A828 4A          LSR A                  ;} $14.$12 = ([enemy X position] - [Samus x position]) / 400h
$A3:A829 85 13       STA $13    [$7E:0013]  ;|
$A3:A82B 29 00 20    AND #$2000             ;|
$A3:A82E F0 07       BEQ $07    [$A837]     ;|
$A3:A830 A5 14       LDA $14    [$7E:0014]  ;|
$A3:A832 09 C0 FF    ORA #$FFC0             ;|
$A3:A835 85 14       STA $14    [$7E:0014]  ;/

$A3:A837 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A3:A83A 38          SEC                    ;|
$A3:A83B E5 12       SBC $12    [$7E:0012]  ;|
$A3:A83D 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;} Enemy X velocity -= [$14].[$12]
$A3:A840 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;|
$A3:A843 E5 14       SBC $14    [$7E:0014]  ;|
$A3:A845 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A3:A848 30 0A       BMI $0A    [$A854]     ;\
$A3:A84A C9 03 00    CMP #$0003             ;|
$A3:A84D 90 13       BCC $13    [$A862]     ;|
$A3:A84F A9 03 00    LDA #$0003             ;|
$A3:A852 80 08       BRA $08    [$A85C]     ;|
                                            ;|
$A3:A854 C9 FD FF    CMP #$FFFD             ;} Enemy X velocity = clamp([enemy X velocity], -3.0, 3.0)
$A3:A857 B0 09       BCS $09    [$A862]     ;|
$A3:A859 A9 FD FF    LDA #$FFFD             ;|
                                            ;|
$A3:A85C 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;|
$A3:A85F 9E A8 0F    STZ $0FA8,x[$7E:0FE8]  ;/

$A3:A862 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A3:A865 D0 0B       BNE $0B    [$A872]     ;|
$A3:A867 BD AA 0F    LDA $0FAA,x[$7E:102A]  ;|
$A3:A86A D0 06       BNE $06    [$A872]     ;} >_<;
$A3:A86C 9E A8 0F    STZ $0FA8,x[$7E:1028]  ;|
$A3:A86F 9E AA 0F    STZ $0FAA,x[$7E:102A]  ;/

$A3:A872 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A3:A875 85 12       STA $12    [$7E:0012]  ;|
$A3:A877 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;} Move enemy right by [enemy X velocity]
$A3:A87A 85 14       STA $14    [$7E:0014]  ;|
$A3:A87C 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:A880 90 06       BCC $06    [$A888]     ; If collided with block:
$A3:A882 9E A8 0F    STZ $0FA8,x[$7E:0FA8]  ;\
$A3:A885 9E AA 0F    STZ $0FAA,x[$7E:0FAA]  ;} Enemy X velocity = 0.0

$A3:A888 A9 45 A7    LDA #$A745             ;\
$A3:A88B 20 3C A9    JSR $A93C  [$A3:A93C]  ;} Set enemy instruction list to $A745
$A3:A88E 60          RTS
}


;;; $A88F: Unused. Mochtroid main AI - [enemy $0FB2] = 2 ;;;
{
$A3:A88F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A892 BD B0 0F    LDA $0FB0,x            ;\
$A3:A895 29 06 00    AND #$0006             ;} Y = [enemy $0FB0] & 6
$A3:A898 A8          TAY                    ;/
$A3:A899 BD 7A 0F    LDA $0F7A,x            ;\
$A3:A89C 18          CLC                    ;|
$A3:A89D 79 6D A7    ADC $A76D,y            ;} Enemy X position = [$A76D + [Y]]
$A3:A8A0 9D 7A 0F    STA $0F7A,x            ;/
$A3:A8A3 BD 7E 0F    LDA $0F7E,x            ;\
$A3:A8A6 18          CLC                    ;|
$A3:A8A7 79 75 A7    ADC $A775,y            ;} Enemy Y position = [$A775 + [Y]]
$A3:A8AA 9D 7E 0F    STA $0F7E,x            ;/
$A3:A8AD 9E A8 0F    STZ $0FA8,x            ;\
$A3:A8B0 9E AA 0F    STZ $0FAA,x            ;} Enemy X velocity = 0.0
$A3:A8B3 9E AC 0F    STZ $0FAC,x            ;\
$A3:A8B6 9E AE 0F    STZ $0FAE,x            ;} Enemy Y velocity = 0.0
$A3:A8B9 DE B0 0F    DEC $0FB0,x            ; Decrement enemy $0FB0
$A3:A8BC D0 03       BNE $03    [$A8C1]     ; If [enemy $0FB0] = 0:
$A3:A8BE 9E B2 0F    STZ $0FB2,x            ; Enemy function index = 0

$A3:A8C1 A9 45 A7    LDA #$A745             ;\
$A3:A8C4 20 3C A9    JSR $A93C  [$A3:A93C]  ;} Set enemy instruction list = $A745
$A3:A8C7 60          RTS
}


;;; $A8C8: Mochtroid main AI - [enemy $0FB2] = 1: touching Samus ;;;
{
$A3:A8C8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A8CB BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A3:A8CE CD F6 0A    CMP $0AF6  [$7E:0AF6]  ;} If [enemy X position] != [Samus X position]:
$A3:A8D1 F0 04       BEQ $04    [$A8D7]     ;/
$A3:A8D3 10 0A       BPL $0A    [$A8DF]     ; If [enemy X position] >= [Samus X position]: go to BRANCH_MOVE_LEFT
$A3:A8D5 30 13       BMI $13    [$A8EA]     ; Go to BRANCH_MOVE_RIGHT

$A3:A8D7 9E A8 0F    STZ $0FA8,x[$7E:1128]  ;\
$A3:A8DA 9E AA 0F    STZ $0FAA,x[$7E:112A]  ;} Enemy X velocity = 0.0
$A3:A8DD 80 16       BRA $16    [$A8F5]     ; Go to BRANCH_MOVE_X

; BRANCH_MOVE_LEFT
$A3:A8DF 9E A8 0F    STZ $0FA8,x[$7E:0FE8]  ;\
$A3:A8E2 A9 FF FF    LDA #$FFFF             ;} Enemy X velocity = -1.0
$A3:A8E5 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A3:A8E8 80 0B       BRA $0B    [$A8F5]     ; Go to BRANCH_MOVE_X

; BRANCH_MOVE_RIGHT
$A3:A8EA 9E A8 0F    STZ $0FA8,x[$7E:0FE8]  ;\
$A3:A8ED A9 01 00    LDA #$0001             ;} Enemy X velocity = 1.0
$A3:A8F0 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A3:A8F3 80 00       BRA $00    [$A8F5]

; BRANCH_MOVE_X
$A3:A8F5 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;\
$A3:A8F8 85 12       STA $12    [$7E:0012]  ;|
$A3:A8FA BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;} Move enemy right by [enemy X velocity]
$A3:A8FD 85 14       STA $14    [$7E:0014]  ;|
$A3:A8FF 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:A903 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A3:A906 CD FA 0A    CMP $0AFA  [$7E:0AFA]  ;} If [enemy Y position] != [Samus Y position]:
$A3:A909 F0 04       BEQ $04    [$A90F]     ;/
$A3:A90B 10 0A       BPL $0A    [$A917]     ; If [enemy Y position] >= [Samus Y position]: go to BRANCH_MOVE_UP
$A3:A90D 30 13       BMI $13    [$A922]     ; Go to BRANCH_MOVE_DOWN

$A3:A90F 9E AC 0F    STZ $0FAC,x[$7E:112C]  ;\
$A3:A912 9E AE 0F    STZ $0FAE,x[$7E:112E]  ;} Enemy Y velocity = 0.0
$A3:A915 80 16       BRA $16    [$A92D]     ; Go to BRANCH_MOVE_Y

; BRANCH_MOVE_UP
$A3:A917 9E AC 0F    STZ $0FAC,x[$7E:0FEC]  ;\
$A3:A91A A9 FF FF    LDA #$FFFF             ;} Enemy Y velocity = -1.0
$A3:A91D 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/
$A3:A920 80 0B       BRA $0B    [$A92D]     ; Go to BRANCH_MOVE_Y

; BRANCH_MOVE_DOWN
$A3:A922 9E AC 0F    STZ $0FAC,x[$7E:112C]  ;\
$A3:A925 A9 01 00    LDA #$0001             ;} Enemy Y velocity = 1.0
$A3:A928 9D AE 0F    STA $0FAE,x[$7E:112E]  ;/
$A3:A92B 80 00       BRA $00    [$A92D]

; BRANCH_MOVE_Y
$A3:A92D BD AC 0F    LDA $0FAC,x[$7E:0FEC]  ;\
$A3:A930 85 12       STA $12    [$7E:0012]  ;|
$A3:A932 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;} Move enemy down by [enemy Y velocity]
$A3:A935 85 14       STA $14    [$7E:0014]  ;|
$A3:A937 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:A93B 60          RTS
}


;;; $A93C: Set mochtroid instruction list ;;;
{
; Mocktroid respawn crash: if mochtroid is set to respawn,
; then [enemy $7E:7802] is likely already set to [A],
; so the enemy instruction list pointer never gets set,
; meaning it will be 0 when enemy instruction processing takes place,
; causing garbage instructions to be processed.

$A3:A93C DF 02 78 7E CMP $7E7802,x[$7E:7802];\
$A3:A940 F0 10       BEQ $10    [$A952]     ;} If [A] = [enemy $7E:7802]: return
$A3:A942 9F 02 78 7E STA $7E7802,x[$7E:7802]; Enemy $7E:7802 = [A]
$A3:A946 9D 92 0F    STA $0F92,x[$7E:0F92]  ; Enemy instruction list pointer = [A]
$A3:A949 A9 01 00    LDA #$0001             ;\
$A3:A94C 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A3:A94F 9E 90 0F    STZ $0F90,x[$7E:0F90]  ; Enemy timer = 0

$A3:A952 60          RTS
}


;;; $A953: Enemy touch - enemy $D8FF (mochtroid) ;;;
{
$A3:A953 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A956 A9 01 00    LDA #$0001             ;\
$A3:A959 9D B2 0F    STA $0FB2,x[$7E:0FF2]  ;} Enemy function index = 1
$A3:A95C A9 59 A7    LDA #$A759             ;\
$A3:A95F 20 3C A9    JSR $A93C  [$A3:A93C]  ;} Set enemy instruction list = $A759
$A3:A962 BF 00 80 7E LDA $7E8000,x[$7E:8040];\
$A3:A966 1A          INC A                  ;} Increment enemy $7E:8000
$A3:A967 9F 00 80 7E STA $7E8000,x[$7E:8040];/
$A3:A96B AD 6E 0A    LDA $0A6E  [$7E:0A6E]  ;\
$A3:A96E D0 2A       BNE $2A    [$A99A]     ;} If [Samus contact damage index] != normal: go to BRANCH_DAMAGE
$A3:A970 AD 44 0E    LDA $0E44  [$7E:0E44]  ;\
$A3:A973 29 07 00    AND #$0007             ;|
$A3:A976 C9 07 00    CMP #$0007             ;} If [number of times main enemy routine has been executed] % 8 = 7:
$A3:A979 D0 0F       BNE $0F    [$A98A]     ;/
$A3:A97B AD C2 09    LDA $09C2  [$7E:09C2]  ;\
$A3:A97E C9 1E 00    CMP #$001E             ;} If [Samus health] >= 30:
$A3:A981 30 07       BMI $07    [$A98A]     ;/
$A3:A983 A9 2D 00    LDA #$002D             ;\
$A3:A986 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 6 (gaining/losing incremental health)

$A3:A98A BF 00 80 7E LDA $7E8000,x[$7E:8040];\
$A3:A98E C9 50 00    CMP #$0050             ;} If [enemy $7E:8000] < 50h: return
$A3:A991 30 14       BMI $14    [$A9A7]     ;/
$A3:A993 A9 00 00    LDA #$0000             ;\
$A3:A996 9F 00 80 7E STA $7E8000,x[$7E:8180];} Enemy $7E:8000 = 0

; BRANCH_DAMAGE
$A3:A99A 22 23 80 A3 JSL $A38023[$A3:8023]  ; Normal enemy touch AI
$A3:A99E A9 00 00    LDA #$0000
$A3:A9A1 8D A8 18    STA $18A8  [$7E:18A8]  ; Samus invincibility timer = 0
$A3:A9A4 8D AA 18    STA $18AA  [$7E:18AA]  ; Samus knockback timer = 0

$A3:A9A7 6B          RTL
}


;;; $A9A8: Enemy shot - enemy $D8FF (mochtroid) ;;;
{
$A3:A9A8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:A9AB 22 2D 80 A3 JSL $A3802D[$A3:802D]  ; Normal enemy shot AI
$A3:A9AF 6B          RTL
}


;;; $A9B0: Mochtroid spritemaps ;;;
{
; Not touching Samus
$A3:A9B0             dx 0006, 8000,F4,6100, 81F0,F4,2100, 0006,04,611C, 01FE,04,611D, 01FA,04,211D, 01F2,04,211C
$A3:A9D0             dx 0006, 8000,F4,6102, 81F0,F4,2102, 0007,04,610C, 01FF,04,610D, 01F9,04,210D, 01F1,04,210C
$A3:A9F0             dx 0004, 8000,F2,6104, 81F0,F2,2104, 81F8,02,610E, 81F8,02,210E

; Touching Samus
$A3:AA06             dx 0004, 81F9,02,610E, 8000,F2,6106, 81F0,F2,2106, 81F7,02,210E
$A3:AA1C             dx 0004, 81F0,F1,2108, 81FA,01,610E, 81F6,01,210E, 8000,F1,6108
$A3:AA32             dx 0004, 81F9,02,610E, 81F7,02,210E, 8000,F2,610A, 81F0,F2,210A
}
}


;;; $AA48..B3A0: Sidehoppers ;;;
{
;;; $AA48: Palette - enemy $D93F (sidehopper) ;;;
{
$A3:AA48             dw 3800, 57FF, 42F7, 0D4A, 0063, 4F5A, 36B5, 2610, 1DCE, 4EDA, 3A35, 2990, 14EB, 5FE0, 32A0, 1940
}


;;; $AA68: Instruction - queue sound [[Y]], sound library 2, max queued sounds allowed = 3 ;;;
{
$A3:AA68 5A          PHY
$A3:AA69 DA          PHX
$A3:AA6A B9 00 00    LDA $0000,y[$A3:AAAC]
$A3:AA6D 22 B7 90 80 JSL $8090B7[$80:90B7]
$A3:AA71 FA          PLX
$A3:AA72 7A          PLY
$A3:AA73 C8          INY
$A3:AA74 C8          INY
$A3:AA75 6B          RTL
}


;;; $AA76: Instruction list -  ;;;
{
$A3:AA76             dx 8173,       ; Enable off-screen processing
                        AA68,005D,  ; Queue sound 5Dh, sound library 2, max queued sounds allowed = 3
                        0001,AF19,
                        812F        ; Sleep
}


;;; $AA82: Instruction list - sidehopper ;;;
{
$A3:AA82             dx 817D,       ; Disable off-screen processing
                        AA68,005E,  ; Queue sound 5Eh, sound library 2, max queued sounds allowed = 3
                        0002,AEE3,
                        0005,AEFE,
                        0002,AEE3,
                        0003,AEFE,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $AA9C: Instruction list -  ;;;
{
$A3:AA9C             dx 8173,       ; Enable off-screen processing
                        AA68,005D,  ; Queue sound 5Dh, sound library 2, max queued sounds allowed = 3
                        0001,AF6A,
                        812F        ; Sleep
}


;;; $AAA8: Instruction list - sidehopper ;;;
{
$A3:AAA8             dx 817D,       ; Disable off-screen processing
                        AA68,005E,  ; Queue sound 5Eh, sound library 2, max queued sounds allowed = 3
                        0002,AF34,
                        0005,AF4F,
                        0002,AF34,
                        0003,AF4F,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $AAC2:  ;;;
{
; Instruction list pointers. Indexed by [$A0:002A + [enemy ID]] * 2
$A3:AAC2             dw AA82, B0D1, B23F, AFAD ; Initial - enemy parameter 1 = 0
$A3:AACA             dw AAA8, B0F7, B25D, AFCB ; Initial - enemy parameter 1 != 0
$A3:AAD2             dw AA76, B0C5, B237, AFA5
$A3:AADA             dw AA9C, B0EB, B255, AFC3

$A3:AAE2             dw ABE6, AC13
$A3:AAE6             dw 0003, 0003, 0003, 0003
$A3:AAEE             dw 1000, 1000
$A3:AAF2             dw 0004, 0004, 0003, 0003
$A3:AAFA             dw 3000, 3000
}


;;; $AAFE: Instruction ;;;
{
$A3:AAFE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AB01 A9 01 00    LDA #$0001
$A3:AB04 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:AB08 6B          RTL
}


;;; $AB09: Initialisation AI - enemy $D93F/$D97F/$D9BF/$D9FF/$DA3F (sidehopper / desgeega / super-sidehopper / super-desgeega) ;;;
{
$A3:AB09 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AB0C A9 25 00    LDA #$0025             ;\
$A3:AB0F 8D E5 05    STA $05E5  [$7E:05E5]  ;} Random number = 25h
$A3:AB12 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A3:AB16 A9 00 00    LDA #$0000
$A3:AB19 9F 06 78 7E STA $7E7806,x[$7E:7846]; Enemy $7E:7806 = 0
$A3:AB1D 9F 08 78 7E STA $7E7808,x[$7E:7848]; Enemy $7E:7808 = 0
$A3:AB21 9F 0A 78 7E STA $7E780A,x[$7E:784A]; Enemy $7E:780A = 0
$A3:AB25 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\
$A3:AB28 AA          TAX                    ;|
$A3:AB29 BF 2A 00 A0 LDA $A0002A,x[$A0:D9E9];|
$A3:AB2D 0A          ASL A                  ;} Enemy sidehopper variant index = [$A0:002A + [enemy ID]] * 2
$A3:AB2E AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A3:AB31 9F 0C 78 7E STA $7E780C,x[$7E:784C];/
$A3:AB35 BD B4 0F    LDA $0FB4,x[$7E:0FF4]  ;\
$A3:AB38 D0 0A       BNE $0A    [$AB44]     ;} If [enemy parameter 1] = 0:
$A3:AB3A BF 0C 78 7E LDA $7E780C,x[$7E:784C];\
$A3:AB3E A8          TAY                    ;} Enemy $7E:7800 = [$AAC2 + [enemy sidehopper variant index]]
$A3:AB3F B9 C2 AA    LDA $AAC2,y[$A3:AAC4]  ;/
$A3:AB42 80 08       BRA $08    [$AB4C]

$A3:AB44 BF 0C 78 7E LDA $7E780C,x[$7E:78CC];\
$A3:AB48 A8          TAY                    ;} Enemy $7E:7800 = [$AACA + [enemy sidehopper variant index]]
$A3:AB49 B9 CA AA    LDA $AACA,y[$A3:AACC]  ;/

$A3:AB4C 9F 00 78 7E STA $7E7800,x[$7E:7840]
$A3:AB50 20 BB AB    JSR $ABBB  [$A3:ABBB]  ; Set sidehopper enemy instruction list
$A3:AB53 BD 78 0F    LDA $0F78,x[$7E:0FB8]  ;\
$A3:AB56 AA          TAX                    ;|
$A3:AB57 BF 2A 00 A0 LDA $A0002A,x[$A0:D9E9];} If [enemy sidehopper variant index] != sidehopper:
$A3:AB5B F0 0A       BEQ $0A    [$AB67]     ;/
$A3:AB5D A9 02 00    LDA #$0002             ;\
$A3:AB60 AE 54 0E    LDX $0E54  [$7E:0E54]  ;} Enemy $7E:780A = 2
$A3:AB63 9F 0A 78 7E STA $7E780A,x[$7E:784A];/

$A3:AB67 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AB6A BF 0A 78 7E LDA $7E780A,x[$7E:784A]
$A3:AB6E A8          TAY
$A3:AB6F B9 EE AA    LDA $AAEE,y[$A3:AAF0]
$A3:AB72 85 16       STA $16    [$7E:0016]
$A3:AB74 B9 E6 AA    LDA $AAE6,y[$A3:AAE8]
$A3:AB77 85 18       STA $18    [$7E:0018]
$A3:AB79 20 9D AB    JSR $AB9D  [$A3:AB9D]
$A3:AB7C 9F 02 78 7E STA $7E7802,x[$7E:7842]
$A3:AB80 BF 0A 78 7E LDA $7E780A,x[$7E:784A]
$A3:AB84 A8          TAY
$A3:AB85 B9 FA AA    LDA $AAFA,y[$A3:AAFC]
$A3:AB88 85 16       STA $16    [$7E:0016]
$A3:AB8A B9 F2 AA    LDA $AAF2,y[$A3:AAF4]
$A3:AB8D 85 18       STA $18    [$7E:0018]
$A3:AB8F 20 9D AB    JSR $AB9D  [$A3:AB9D]
$A3:AB92 9F 04 78 7E STA $7E7804,x[$7E:7844]
$A3:AB96 A9 D6 AB    LDA #$ABD6
$A3:AB99 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A3:AB9C 6B          RTL
}


;;; $AB9D:  ;;;
{
$A3:AB9D 64 12       STZ $12    [$7E:0012]
$A3:AB9F 64 14       STZ $14    [$7E:0014]

$A3:ABA1 A5 12       LDA $12    [$7E:0012]
$A3:ABA3 18          CLC
$A3:ABA4 65 18       ADC $18    [$7E:0018]
$A3:ABA6 85 12       STA $12    [$7E:0012]
$A3:ABA8 0A          ASL A
$A3:ABA9 0A          ASL A
$A3:ABAA 0A          ASL A
$A3:ABAB A8          TAY
$A3:ABAC A5 14       LDA $14    [$7E:0014]
$A3:ABAE 18          CLC
$A3:ABAF 79 90 83    ADC $8390,y[$A3:83A8]
$A3:ABB2 85 14       STA $14    [$7E:0014]
$A3:ABB4 C5 16       CMP $16    [$7E:0016]
$A3:ABB6 30 E9       BMI $E9    [$ABA1]
$A3:ABB8 A5 12       LDA $12    [$7E:0012]
$A3:ABBA 60          RTS
}


;;; $ABBB: Set sidehopper enemy instruction list ;;;
{
$A3:ABBB AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ABBE BF 00 78 7E LDA $7E7800,x[$7E:7840]
$A3:ABC2 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:ABC5 A9 01 00    LDA #$0001
$A3:ABC8 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:ABCB 9E 90 0F    STZ $0F90,x[$7E:0FD0]
$A3:ABCE 60          RTS
}


;;; $ABCF: Main AI - enemy $D93F/$D97F/$D9BF/$D9FF/$DA3F (sidehopper / desgeega / super-sidehopper / super-desgeega) ;;;
{
$A3:ABCF AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ABD2 FC AA 0F    JSR ($0FAA,x)[$A3:ABD6]
$A3:ABD5 6B          RTL
}


;;; $ABD6:  ;;;
{
$A3:ABD6 22 11 81 80 JSL $808111[$80:8111]
$A3:ABDA 29 01 00    AND #$0001
$A3:ABDD 0A          ASL A
$A3:ABDE A8          TAY
$A3:ABDF B9 E2 AA    LDA $AAE2,y[$A3:AAE2]
$A3:ABE2 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:ABE5 60          RTS
}


;;; $ABE6:  ;;;
{
$A3:ABE6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ABE9 BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A3:ABED A8          TAY
$A3:ABEE B9 E6 AA    LDA $AAE6,y[$A3:AAE6]
$A3:ABF1 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A3:ABF4 B9 EA AA    LDA $AAEA,y[$A3:AAEA]
$A3:ABF7 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:ABFA BF 02 78 7E LDA $7E7802,x[$7E:7802]
$A3:ABFE 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:AC01 A9 40 AC    LDA #$AC40
$A3:AC04 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AC07 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:AC0A F0 06       BEQ $06    [$AC12]
$A3:AC0C A9 56 AC    LDA #$AC56
$A3:AC0F 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A3:AC12 60          RTS
}


;;; $AC13:  ;;;
{
$A3:AC13 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AC16 BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A3:AC1A A8          TAY
$A3:AC1B B9 F2 AA    LDA $AAF2,y[$A3:AAF2]
$A3:AC1E 9D B0 0F    STA $0FB0,x[$7E:0FB0]
$A3:AC21 B9 F6 AA    LDA $AAF6,y[$A3:AAF6]
$A3:AC24 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:AC27 BF 04 78 7E LDA $7E7804,x[$7E:7804]
$A3:AC2B 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:AC2E A9 40 AC    LDA #$AC40
$A3:AC31 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AC34 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:AC37 F0 06       BEQ $06    [$AC3F]
$A3:AC39 A9 56 AC    LDA #$AC56
$A3:AC3C 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A3:AC3F 60          RTS
}


;;; $AC40:  ;;;
{
$A3:AC40 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AC43 A9 6C AC    LDA #$AC6C
$A3:AC46 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AC49 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]
$A3:AC4D 30 06       BMI $06    [$AC55]
$A3:AC4F A9 8F AC    LDA #$AC8F
$A3:AC52 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A3:AC55 60          RTS
}


;;; $AC56:  ;;;
{
$A3:AC56 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AC59 A9 A8 AC    LDA #$ACA8
$A3:AC5C 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AC5F 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]
$A3:AC63 30 06       BMI $06    [$AC6B]
$A3:AC65 A9 CB AC    LDA #$ACCB
$A3:AC68 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A3:AC6B 60          RTS
}


;;; $AC6C:  ;;;
{
$A3:AC6C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AC6F BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:AC72 49 FF FF    EOR #$FFFF
$A3:AC75 1A          INC A
$A3:AC76 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:AC79 BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A3:AC7D A8          TAY
$A3:AC7E B9 D2 AA    LDA $AAD2,y[$A3:AAD2]
$A3:AC81 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:AC85 20 BB AB    JSR $ABBB  [$A3:ABBB]
$A3:AC88 A9 0E AD    LDA #$AD0E
$A3:AC8B 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AC8E 60          RTS
}


;;; $AC8F:  ;;;
{
$A3:AC8F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AC92 BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A3:AC96 A8          TAY
$A3:AC97 B9 D2 AA    LDA $AAD2,y[$A3:AAD2]
$A3:AC9A 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:AC9E 20 BB AB    JSR $ABBB  [$A3:ABBB]
$A3:ACA1 A9 20 AD    LDA #$AD20
$A3:ACA4 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:ACA7 60          RTS
}


;;; $ACA8:  ;;;
{
$A3:ACA8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ACAB BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:ACAE 49 FF FF    EOR #$FFFF
$A3:ACB1 1A          INC A
$A3:ACB2 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:ACB5 BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A3:ACB9 A8          TAY
$A3:ACBA B9 DA AA    LDA $AADA,y[$A3:AADA]
$A3:ACBD 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:ACC1 20 BB AB    JSR $ABBB  [$A3:ABBB]
$A3:ACC4 A9 32 AD    LDA #$AD32
$A3:ACC7 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:ACCA 60          RTS
}


;;; $ACCB:  ;;;
{
$A3:ACCB AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ACCE BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A3:ACD2 A8          TAY
$A3:ACD3 B9 DA AA    LDA $AADA,y[$A3:AADA]
$A3:ACD6 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:ACDA 20 BB AB    JSR $ABBB  [$A3:ABBB]
$A3:ACDD A9 44 AD    LDA #$AD44
$A3:ACE0 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:ACE3 60          RTS
}


;;; $ACE4:  ;;;
{
$A3:ACE4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ACE7 BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A3:ACEB A8          TAY
$A3:ACEC B9 C2 AA    LDA $AAC2,y[$A3:AAC2]
$A3:ACEF 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:ACF3 BD B4 0F    LDA $0FB4,x[$7E:0FB4]
$A3:ACF6 F0 0C       BEQ $0C    [$AD04]
$A3:ACF8 BF 0C 78 7E LDA $7E780C,x[$7E:780C]
$A3:ACFC A8          TAY
$A3:ACFD B9 CA AA    LDA $AACA,y[$A3:AACA]
$A3:AD00 9F 00 78 7E STA $7E7800,x[$7E:7800]

$A3:AD04 20 BB AB    JSR $ABBB  [$A3:ABBB]
$A3:AD07 A9 56 AD    LDA #$AD56
$A3:AD0A 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AD0D 60          RTS
}


;;; $AD0E:  ;;;
{
$A3:AD0E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AD11 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A3:AD15 D0 05       BNE $05    [$AD1C]
$A3:AD17 20 6D AD    JSR $AD6D  [$A3:AD6D]
$A3:AD1A 80 03       BRA $03    [$AD1F]

$A3:AD1C 20 D4 AD    JSR $ADD4  [$A3:ADD4]

$A3:AD1F 60          RTS
}


;;; $AD20:  ;;;
{
$A3:AD20 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AD23 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A3:AD27 D0 05       BNE $05    [$AD2E]
$A3:AD29 20 6D AD    JSR $AD6D  [$A3:AD6D]
$A3:AD2C 80 03       BRA $03    [$AD31]

$A3:AD2E 20 D4 AD    JSR $ADD4  [$A3:ADD4]

$A3:AD31 60          RTS
}


;;; $AD32:  ;;;
{
$A3:AD32 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AD35 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A3:AD39 D0 05       BNE $05    [$AD40]
$A3:AD3B 20 27 AE    JSR $AE27  [$A3:AE27]
$A3:AD3E 80 03       BRA $03    [$AD43]

$A3:AD40 20 8E AE    JSR $AE8E  [$A3:AE8E]

$A3:AD43 60          RTS
}


;;; $AD44:  ;;;
{
$A3:AD44 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AD47 BF 06 78 7E LDA $7E7806,x[$7E:7806]
$A3:AD4B D0 05       BNE $05    [$AD52]
$A3:AD4D 20 27 AE    JSR $AE27  [$A3:AE27]
$A3:AD50 80 03       BRA $03    [$AD55]

$A3:AD52 20 8E AE    JSR $AE8E  [$A3:AE8E]

$A3:AD55 60          RTS
}


;;; $AD56:  ;;;
{
$A3:AD56 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AD59 BF 08 78 7E LDA $7E7808,x[$7E:7808]
$A3:AD5D F0 0D       BEQ $0D    [$AD6C]
$A3:AD5F A9 00 00    LDA #$0000
$A3:AD62 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:AD66 A9 D6 AB    LDA #$ABD6
$A3:AD69 9D AA 0F    STA $0FAA,x[$7E:0FAA]

$A3:AD6C 60          RTS
}


;;; $AD6D:  ;;;
{
$A3:AD6D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AD70 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:AD73 0A          ASL A                  ;|
$A3:AD74 0A          ASL A                  ;} Y = [enemy $0FAC] * 8 (quadratic speed table index)
$A3:AD75 0A          ASL A                  ;|
$A3:AD76 A8          TAY                    ;/
$A3:AD77 B9 95 83    LDA $8395,y[$A3:85B5]  ;\
$A3:AD7A 85 14       STA $14    [$7E:0014]  ;|
$A3:AD7C B9 93 83    LDA $8393,y[$A3:85B3]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A3:AD7F 85 12       STA $12    [$7E:0012]  ;/
$A3:AD81 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:AD85 90 13       BCC $13    [$AD9A]     ; If collided with block:
$A3:AD87 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:AD8A 49 FF FF    EOR #$FFFF
$A3:AD8D 1A          INC A
$A3:AD8E 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:AD91 A9 01 00    LDA #$0001
$A3:AD94 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:AD98 80 39       BRA $39    [$ADD3]

$A3:AD9A BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A3:AD9D 85 14       STA $14    [$7E:0014]  ;|
$A3:AD9F 64 12       STZ $12    [$7E:0012]  ;} Move enemy right by [enemy X velocity]
$A3:ADA1 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:ADA5 90 13       BCC $13    [$ADBA]     ; If collided with wall:
$A3:ADA7 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:ADAA 49 FF FF    EOR #$FFFF
$A3:ADAD 1A          INC A
$A3:ADAE 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:ADB1 A9 01 00    LDA #$0001
$A3:ADB4 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:ADB8 80 19       BRA $19    [$ADD3]

$A3:ADBA BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:ADBD 38          SEC
$A3:ADBE FD B0 0F    SBC $0FB0,x[$7E:0FB0]
$A3:ADC1 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:ADC4 10 0D       BPL $0D    [$ADD3]
$A3:ADC6 A9 01 00    LDA #$0001
$A3:ADC9 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:ADCD A9 00 00    LDA #$0000
$A3:ADD0 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A3:ADD3 60          RTS
}


;;; $ADD4:  ;;;
{
$A3:ADD4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ADD7 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:ADDA 0A          ASL A                  ;|
$A3:ADDB 0A          ASL A                  ;} Y = [enemy $0FAC] * 8 (quadratic speed table index)
$A3:ADDC 0A          ASL A                  ;|
$A3:ADDD A8          TAY                    ;/
$A3:ADDE B9 91 83    LDA $8391,y[$A3:8551]  ;\
$A3:ADE1 85 14       STA $14    [$7E:0014]  ;|
$A3:ADE3 B9 8F 83    LDA $838F,y[$A3:854F]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A3:ADE6 85 12       STA $12    [$7E:0012]  ;/
$A3:ADE8 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:ADEC 90 0F       BCC $0F    [$ADFD]     ; If collided with block:
$A3:ADEE A9 00 00    LDA #$0000
$A3:ADF1 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:ADF5 A9 E4 AC    LDA #$ACE4
$A3:ADF8 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:ADFB 80 29       BRA $29    [$AE26]

$A3:ADFD BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A3:AE00 85 14       STA $14    [$7E:0014]  ;|
$A3:AE02 64 12       STZ $12    [$7E:0012]  ;} Move enemy right by [enemy X velocity]
$A3:AE04 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:AE08 90 0A       BCC $0A    [$AE14]     ; If collided with wall:
$A3:AE0A BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:AE0D 49 FF FF    EOR #$FFFF
$A3:AE10 1A          INC A
$A3:AE11 9D AE 0F    STA $0FAE,x[$7E:0FAE]

$A3:AE14 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:AE17 18          CLC
$A3:AE18 7D B0 0F    ADC $0FB0,x[$7E:0FB0]
$A3:AE1B C9 40 00    CMP #$0040
$A3:AE1E 30 03       BMI $03    [$AE23]
$A3:AE20 A9 40 00    LDA #$0040

$A3:AE23 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A3:AE26 60          RTS
}


;;; $AE27:  ;;;
{
$A3:AE27 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AE2A BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:AE2D 0A          ASL A                  ;|
$A3:AE2E 0A          ASL A                  ;} Y = [enemy $0FAC] * 8 (quadratic speed table index)
$A3:AE2F 0A          ASL A                  ;|
$A3:AE30 A8          TAY                    ;/
$A3:AE31 B9 91 83    LDA $8391,y[$A3:84E1]  ;\
$A3:AE34 85 14       STA $14    [$7E:0014]  ;|
$A3:AE36 B9 8F 83    LDA $838F,y[$A3:84DF]  ;} $14.$12 = [$838F + [Y] + 2].[$838F + [Y]]
$A3:AE39 85 12       STA $12    [$7E:0012]  ;/
$A3:AE3B 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:AE3F 90 13       BCC $13    [$AE54]     ; If collided with block:
$A3:AE41 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:AE44 49 FF FF    EOR #$FFFF
$A3:AE47 1A          INC A
$A3:AE48 9D AE 0F    STA $0FAE,x[$7E:0FAE]
$A3:AE4B A9 01 00    LDA #$0001
$A3:AE4E 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:AE52 80 39       BRA $39    [$AE8D]

$A3:AE54 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A3:AE57 85 14       STA $14    [$7E:0014]  ;|
$A3:AE59 64 12       STZ $12    [$7E:0012]  ;} Move enemy right by [enemy X velocity]
$A3:AE5B 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:AE5F 90 13       BCC $13    [$AE74]     ; If collided with wall:
$A3:AE61 BD AE 0F    LDA $0FAE,x[$7E:106E]
$A3:AE64 49 FF FF    EOR #$FFFF
$A3:AE67 1A          INC A
$A3:AE68 9D AE 0F    STA $0FAE,x[$7E:106E]
$A3:AE6B A9 01 00    LDA #$0001
$A3:AE6E 9F 06 78 7E STA $7E7806,x[$7E:78C6]
$A3:AE72 80 19       BRA $19    [$AE8D]

$A3:AE74 BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:AE77 38          SEC
$A3:AE78 FD B0 0F    SBC $0FB0,x[$7E:0FB0]
$A3:AE7B 9D AC 0F    STA $0FAC,x[$7E:0FAC]
$A3:AE7E 10 0D       BPL $0D    [$AE8D]
$A3:AE80 A9 01 00    LDA #$0001
$A3:AE83 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:AE87 A9 00 00    LDA #$0000
$A3:AE8A 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A3:AE8D 60          RTS
}


;;; $AE8E:  ;;;
{
$A3:AE8E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:AE91 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:AE94 0A          ASL A                  ;|
$A3:AE95 0A          ASL A                  ;} Y = [enemy $0FAC] * 8 (quadratic speed table index)
$A3:AE96 0A          ASL A                  ;|
$A3:AE97 A8          TAY                    ;/
$A3:AE98 B9 95 83    LDA $8395,y[$A3:8395]  ;\
$A3:AE9B 85 14       STA $14    [$7E:0014]  ;|
$A3:AE9D B9 93 83    LDA $8393,y[$A3:8393]  ;} $14.$12 = [$838F + [Y] + 6].[$838F + [Y] + 4]
$A3:AEA0 85 12       STA $12    [$7E:0012]  ;/
$A3:AEA2 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:AEA6 90 0F       BCC $0F    [$AEB7]     ; If collided with block:
$A3:AEA8 A9 00 00    LDA #$0000
$A3:AEAB 9F 06 78 7E STA $7E7806,x[$7E:7806]
$A3:AEAF A9 E4 AC    LDA #$ACE4
$A3:AEB2 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:AEB5 80 29       BRA $29    [$AEE0]

$A3:AEB7 BD AE 0F    LDA $0FAE,x[$7E:0FAE]  ;\
$A3:AEBA 85 14       STA $14    [$7E:0014]  ;|
$A3:AEBC 64 12       STZ $12    [$7E:0012]  ;} Move enemy right by [enemy X velocity]
$A3:AEBE 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:AEC2 90 0A       BCC $0A    [$AECE]     ; If collided with wall:
$A3:AEC4 BD AE 0F    LDA $0FAE,x[$7E:0FAE]
$A3:AEC7 49 FF FF    EOR #$FFFF
$A3:AECA 1A          INC A
$A3:AECB 9D AE 0F    STA $0FAE,x[$7E:0FAE]

$A3:AECE BD AC 0F    LDA $0FAC,x[$7E:0FAC]
$A3:AED1 18          CLC
$A3:AED2 7D B0 0F    ADC $0FB0,x[$7E:0FB0]
$A3:AED5 C9 40 00    CMP #$0040
$A3:AED8 30 03       BMI $03    [$AEDD]
$A3:AEDA A9 40 00    LDA #$0040

$A3:AEDD 9D AC 0F    STA $0FAC,x[$7E:0FAC]

$A3:AEE0 60          RTS
}


;;; $AEE1: RTL ;;;
{
$A3:AEE1 6B          RTL
}


;;; $AEE2: RTL ;;;
{
$A3:AEE2 6B          RTL
}


;;; $AEE3: Sidehopper spritemaps ;;;
{
$A3:AEE3             dx 0005, 81F8,F3,2100, 8004,EC,6106, 8004,FC,6104, 81EC,EC,2106, 81EC,FC,2104
$A3:AEFE             dx 0005, 81F8,F5,2102, 8004,EC,610A, 81EC,EC,210A, 8004,FC,6108, 81EC,FC,2108
$A3:AF19             dx 0005, 81F8,EF,2100, 8004,04,610E, 8004,F4,610C, 81EC,04,210E, 81EC,F4,210C
$A3:AF34             dx 0005, 81F8,FD,A100, 8004,04,E106, 8004,F4,E104, 81EC,04,A106, 81EC,F4,A104
$A3:AF4F             dx 0005, 81F8,FB,A102, 8004,04,E10A, 81EC,04,A10A, 8004,F4,E108, 81EC,F4,A108
$A3:AF6A             dx 0005, 81F8,01,A100, 8004,EC,E10E, 8004,FC,E10C, 81EC,EC,A10E, 81EC,FC,A10C
}


;;; $AF85: Palette - enemy $D97F (desgeega) ;;;
{
$A3:AF85             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 241F, 1C17, 142F, 0C47, 03E0, 02A0, 0140
}


;;; $AFA5: Instruction list -  ;;;
{
$A3:AFA5             dx 8173,       ; Enable off-screen processing
                        0001,B019,
                        812F        ; Sleep
}


;;; $AFAD: Instruction list - desgeega ;;;
{
$A3:AFAD             dx 817D,       ; Disable off-screen processing
                        0002,AFE3,
                        0005,AFFE,
                        0002,AFE3,
                        0003,AFFE,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $AFC3: Instruction list -  ;;;
{
$A3:AFC3             dx 8173,       ; Enable off-screen processing
                        0001,B06A,
                        812F        ; Sleep
}


;;; $AFCB: Instruction list - desgeega ;;;
{
$A3:AFCB             dx 817D,       ; Disable off-screen processing
                        0002,B034,
                        0005,B04F,
                        0002,B034,
                        0003,B04F,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $AFE1: RTL ;;;
{
$A3:AFE1 6B          RTL
}


;;; $AFE2: RTL ;;;
{
$A3:AFE2 6B          RTL
}


;;; $AFE3: Desgeega spritemaps ;;;
{
$A3:AFE3             dx 0005, 81F8,F3,2100, 8004,EC,6106, 8004,FC,6104, 81EC,EC,2106, 81EC,FC,2104
$A3:AFFE             dx 0005, 81F8,F5,2102, 8004,EC,610A, 81EC,EC,210A, 8004,FC,6108, 81EC,FC,2108
$A3:B019             dx 0005, 81F8,EF,2100, 8004,04,610E, 8004,F4,610C, 81EC,04,210E, 81EC,F4,210C
$A3:B034             dx 0005, 81F8,FD,A100, 8004,04,E106, 8004,F4,E104, 81EC,04,A106, 81EC,F4,A104
$A3:B04F             dx 0005, 81F8,FB,A102, 8004,04,E10A, 81EC,04,A10A, 8004,F4,E108, 81EC,F4,A108
$A3:B06A             dx 0005, 81F8,01,A100, 8004,EC,E10E, 8004,FC,E10C, 81EC,EC,A10E, 81EC,FC,A10C
}


;;; $B085: Palette - enemy $D9BF (super-sidehopper) ;;;
{
$A3:B085             dw 3800, 57FF, 42F7, 0D4A, 0063, 4F5A, 36B5, 2610, 1DCE, 4EDA, 3A35, 2990, 14EB, 5FE0, 32A0, 1940
}


;;; $B0A5: Palette - enemy $D9FF (Tourian super-sidehopper) ;;;
{
$A3:B0A5             dw 3800, 7FFF, 56E0, 3180, 18C0, 6BC0, 5EC0, 4A20, 35A0, 7FFF, 039C, 0237, 00D1, 03FF, 0237, 00D1
}


;;; $B0C5: Instruction list -  ;;;
{
$A3:B0C5             dx 8173,       ; Enable off-screen processing
                        AA68,005D,  ; Queue sound 5Dh, sound library 2, max queued sounds allowed = 3
                        0001,B15B,
                        812F        ; Sleep
}


;;; $B0D1: Instruction list - super-sidehopper ;;;
{
$A3:B0D1             dx 817D,       ; Disable off-screen processing
                        AA68,005E,  ; Queue sound 5Eh, sound library 2, max queued sounds allowed = 3
                        0002,B111,
                        0005,B136,
                        0002,B111,
                        0003,B136,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $B0EB: Instruction list -  ;;;
{
$A3:B0EB             dx 8173,       ; Enable off-screen processing
                        AA68,005D,  ; Queue sound 5Dh, sound library 2, max queued sounds allowed = 3
                        0001,B1DE,
                        812F        ; Sleep
}


;;; $B0F7: Instruction list - super-sidehopper ;;;
{
$A3:B0F7             dx 817D,       ; Disable off-screen processing
                        AA68,005E,  ; Queue sound 5Eh, sound library 2, max queued sounds allowed = 3
                        0002,B194,
                        0005,B1B9,
                        0002,B194,
                        0003,B1B9,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $B111: Tourian super-sidehopper spritemaps ;;;
{
$A3:B111             dx 0007, 0000,EC,2101, 01F8,EC,2100, C20C,04,6106, C3E4,04,2106, C208,F4,6104, C3E8,F4,2104, C3F8,F4,2110
$A3:B136             dx 0007, C3F8,F6,2112, C20D,04,610A, C3E3,04,210A, C208,F4,6108, C3E8,F4,2108, 0000,EE,2101, 01F8,EE,2100
$A3:B15B             dx 000B, 0010,0C,6102, 0008,0C,6103, 01F0,0C,2103, 01E8,0C,2102, C208,FC,610E, C3E8,FC,210E, C208,EC,610C, C3E8,EC,210C, 0000,E3,2101, 01F8,E3,2100, C3F8,EB,2110
$A3:B194             dx 0007, 0000,0C,A101, 01F8,0C,A100, C20C,EC,E106, C3E4,EC,A106, C208,FC,E104, C3E8,FC,A104, C3F8,FC,A110
$A3:B1B9             dx 0007, C3F8,FA,A112, C20D,EC,E10A, C3E3,EC,A10A, C208,FC,E108, C3E8,FC,A108, 0000,0A,A101, 01F8,0A,A100
$A3:B1DE             dx 000B, 0010,EC,E102, 0008,EC,E103, 01F0,EC,A103, 01E8,EC,A102, C208,F4,E10E, C3E8,F4,A10E, C208,04,E10C, C3E8,04,A10C, 0000,15,A101, 01F8,15,A100, C3F8,05,A110
}


;;; $B217: Palette - enemy $DA3F (super-desgeega) ;;;
{
$A3:B217             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 241F, 1C17, 142F, 0C47, 03E0, 02A0, 0140
}


;;; $B237: Instruction list -  ;;;
{
$A3:B237             dx 8173,       ; Enable off-screen processing
                        0001,B2D1,
                        812F        ; Sleep
}


;;; $B23F: Instruction list - super-desgeega ;;;
{
$A3:B23F             dx 817D,       ; Disable off-screen processing
                        0002,B273,
                        0005,B2A2,
                        0002,B273,
                        0003,B2A2,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $B255: Instruction list -  ;;;
{
$A3:B255             dx 8173,       ; Enable off-screen processing
                        0001,B368,
                        812F        ; Sleep
}


;;; $B25D: Instruction list - super-desgeega ;;;
{
$A3:B25D             dx 817D,       ; Disable off-screen processing
                        0002,B30A,
                        0005,B339,
                        0002,B30A,
                        0003,B339,
                        AAFE,       ; ???
                        812F        ; Sleep
}


;;; $B273: Super-desgeega spritemaps ;;;
{
$A3:B273             dx 0009, C3F8,F5,2100, C3E5,F4,2104, C20B,F4,6104, 0006,F5,611A, 01F2,F5,211A, C20B,04,6106, C3E5,04,2106, 0000,ED,210D, 01F8,ED,210C
$A3:B2A2             dx 0009, C3F8,F6,2102, C20A,F4,6104, C3E6,F4,2104, 0006,F6,611C, 01F2,F6,211C, C20B,04,6106, C3E5,04,2106, 0000,EE,210B, 01F8,EE,210A
$A3:B2D1             dx 000B, C3F8,F0,2100, C20B,F4,6104, C3E5,F4,2104, 0007,F4,611B, 01F1,F4,211B, 0000,E8,210D, 01F8,E8,210C, C20A,14,610E, C3E6,14,210E, C20A,04,6108, C3E6,04,2108
$A3:B30A             dx 0009, C3F8,FB,A100, C3E5,FC,A104, C20B,FC,E104, 0006,03,E11A, 01F2,03,A11A, C20B,EC,E106, C3E5,EC,A106, 0000,0B,A10D, 01F8,0B,A10C
$A3:B339             dx 0009, C3F8,FA,A102, C20A,FC,E104, C3E6,FC,A104, 0006,02,E11C, 01F2,02,A11C, C20B,EC,E106, C3E5,EC,A106, 0000,0A,A10B, 01F8,0A,A10A
$A3:B368             dx 000B, C3F8,04,A100, C20B,00,E104, C3E5,00,A104, 0007,08,E11B, 01F1,08,A11B, 0000,14,A10D, 01F8,14,A10C, C20A,E0,E10E, C3E6,E0,A10E, C20A,F0,E108, C3E6,F0,A108
}
}


;;; $B3A1..B5B2: Maridia refill candy ;;;
{
;;; $B3A1: Palette - enemy $DA7F (Maridia refill candy) ;;;
{
$A3:B3A1             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 1D79, 1933, 150E, 10C8, 3BE0, 2680, 1580
}


;;; $B3C1: Instruction list - facing left - shooting ;;;
{
$A3:B3C1             dx B429,       ; Enemy X speed table index = 4
                        0040,B55F,
                        B434,       ; Enemy X speed table index = 8
                        0008,B566,
                        B43F,       ; Enemy X speed table index = Ch
                        0030,B56D,
                        80ED,B3C1   ; Go to $B3C1
}


;;; $B3D7: Instruction list - facing left - rising ;;;
{
$A3:B3D7             dx 0004,B57B,
                        0004,B574,
                        0004,B582,
                        80ED,B3D7   ; Go to $B3D7
}


;;; $B3E7: Instruction list - facing right - shooting ;;;
{
$A3:B3E7             dx B429,       ; Enemy X speed table index = 4
                        0040,B589,  
                        B434,       ; Enemy X speed table index = 8
                        0008,B590,  
                        B43F,       ; Enemy X speed table index = Ch
                        0030,B597,
                        80ED,B3E7   ; Go to $B3E7
}


;;; $B3FD: Instruction list - facing right - rising ;;;
{
$A3:B3FD             dx 0004,B5A5,
                        0004,B59E,
                        0004,B5AC,
                        80ED,B3FD   ; Go to $B3FD
}


;;; $B40D: Maridia refill candy instruction list pointers ;;;
{
$A3:B40D             dw B3C1, B3D7, B3E7, B3FD
}


;;; $B415: Maridia refill candy X speed table ;;;
{
; Indexed by enemy $7E:7800
;                        ________ X speed
;                       |     ___ X subspeed
;                       |    |
$A3:B415             dw 0000,0000, 
                        0000,8000, 
                        0000,A000, 
                        0002,0000, 
                        0000,0000
}


;;; $B429: Instruction - enemy X speed table index = 4 ;;;
{
$A3:B429 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B42C A9 04 00    LDA #$0004
$A3:B42F 9F 00 78 7E STA $7E7800,x[$7E:7840]
$A3:B433 6B          RTL
}


;;; $B434: Instruction - enemy X speed table index = 8 ;;;
{
$A3:B434 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B437 A9 08 00    LDA #$0008
$A3:B43A 9F 00 78 7E STA $7E7800,x[$7E:7840]
$A3:B43E 6B          RTL
}


;;; $B43F: Instruction - enemy X speed table index = Ch ;;;
{
$A3:B43F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B442 A9 0C 00    LDA #$000C
$A3:B445 9F 00 78 7E STA $7E7800,x[$7E:7800]
$A3:B449 6B          RTL
}


;;; $B44A: Initialisation AI - enemy $DA7F (Maridia refill candy) ;;;
{
$A3:B44A AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B44D A9 82 B4    LDA #$B482             ;\
$A3:B450 9D B4 0F    STA $0FB4,x[$7E:0FF4]  ;| Enemy function = $B482 (wait for Samus to get near)
$A3:B453 A9 00 00    LDA #$0000             ;\
$A3:B456 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;} Enemy instruction list table index = 0
$A3:B459 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ; Enemy previous instruction list table index = 0
$A3:B45C 9F 00 78 7E STA $7E7800,x[$7E:7840]; Enemy X speed table index = 0
$A3:B460 A9 C1 B3    LDA #$B3C1             ;\
$A3:B463 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;} Enemy instruction list pointer = $B3C1
$A3:B466 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A3:B469 09 00 01    ORA #$0100             ;} Set enemy to be invisible
$A3:B46C 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A3:B46F BD 7A 0F    LDA $0F7A,x[$7E:0FBA]  ;\
$A3:B472 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;} Enemy spawn X position = [enemy X position]
$A3:B475 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]  ;\
$A3:B478 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;} Enemy spawn Y position = [enemy Y position]
$A3:B47B 6B          RTL
}


;;; $B47C: Main AI - enemy $DA7F (Maridia refill candy) ;;;
{
$A3:B47C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B47F 7C B4 0F    JMP ($0FB4,x)[$A3:B482]; Go to [enemy function]
}


;;; $B482: Maridia refill candy function - wait for Samus to get near ;;;
{
$A3:B482 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B485 A9 80 00    LDA #$0080             ;\
$A3:B488 22 0B AF A0 JSL $A0AF0B[$A0:AF0B]  ;} If Samus is not within 80h pixel columns of enemy: return
$A3:B48C F0 19       BEQ $19    [$B4A7]     ;/
$A3:B48E A0 01 00    LDY #$0001             ; Enemy instruction list table index = 1
$A3:B491 22 E5 AE A0 JSL $A0AEE5[$A0:AEE5]  ;\
$A3:B495 30 03       BMI $03    [$B49A]     ;} If [Samus X position] >= [enemy X position]:
$A3:B497 A0 03 00    LDY #$0003             ; Enemy instruction list table index = 3

$A3:B49A 98          TYA
$A3:B49B 9D AE 0F    STA $0FAE,x[$7E:0FEE]
$A3:B49E 20 37 B5    JSR $B537  [$A3:B537]  ; Set Maridia refill candy instruction list
$A3:B4A1 A9 A8 B4    LDA #$B4A8             ;\
$A3:B4A4 9D B4 0F    STA $0FB4,x[$7E:0FF4]  ;} Enemy function = $B4A8 (rising)

$A3:B4A7 6B          RTL
}


;;; $B4A8: Maridia refill candy function - rising ;;;
{
$A3:B4A8 BD 86 0F    LDA $0F86,x[$7E:0FC6]  ;\
$A3:B4AB 29 FF FE    AND #$FEFF             ;} Set enemy to be visible
$A3:B4AE 9D 86 0F    STA $0F86,x[$7E:0FC6]  ;/
$A3:B4B1 22 DD AE A0 JSL $A0AEDD[$A0:AEDD]  ;\
$A3:B4B5 30 10       BMI $10    [$B4C7]     ;} If [Samus Y position] >= [enemy Y position]:
$A3:B4B7 DE AE 0F    DEC $0FAE,x[$7E:0FEE]  ; Enemy instruction list table index -= 1
$A3:B4BA 20 37 B5    JSR $B537  [$A3:B537]  ; Set Maridia refill candy instruction list
$A3:B4BD 9E B2 0F    STZ $0FB2,x[$7E:0FF2]
$A3:B4C0 A9 D6 B4    LDA #$B4D6             ;\
$A3:B4C3 9D B4 0F    STA $0FB4,x[$7E:0FF4]  ;} Enemy function = $B4D6 (shooting)
$A3:B4C6 6B          RTL

$A3:B4C7 A9 00 00    LDA #$0000             ;\
$A3:B4CA 85 14       STA $14    [$7E:0014]  ;|
$A3:B4CC A9 00 80    LDA #$8000             ;} Enemy Y position -= 0.8000h
$A3:B4CF 85 12       STA $12    [$7E:0012]  ;|
$A3:B4D1 22 7E AF A0 JSL $A0AF7E[$A0:AF7E]  ;/
$A3:B4D5 6B          RTL
}


;;; $B4D6: Maridia refill candy function - shooting ;;;
{
$A3:B4D6 BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$A3:B4D9 F0 1D       BEQ $1D    [$B4F8]     ;} If [enemy direction] = left:
$A3:B4DB BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$A3:B4DF A8          TAY                    ;} Y = [enemy X speed table index]
$A3:B4E0 B9 15 B4    LDA $B415,y[$A3:B419]  ;\
$A3:B4E3 85 14       STA $14    [$7E:0014]  ;|
$A3:B4E5 B9 17 B4    LDA $B417,y[$A3:B41B]  ;} Enemy X position += [$B415 + [Y]].[$B415 + [Y] + 2]
$A3:B4E8 85 12       STA $12    [$7E:0012]  ;|
$A3:B4EA 22 6C AF A0 JSL $A0AF6C[$A0:AF6C]  ;/
$A3:B4EE 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$A3:B4F2 D0 21       BNE $21    [$B515]     ;} If enemy is off-screen: go to BRANCH_OFF_SCREEN
$A3:B4F4 20 37 B5    JSR $B537  [$A3:B537]  ; Set Maridia refill candy instruction list
$A3:B4F7 6B          RTL

$A3:B4F8 BF 00 78 7E LDA $7E7800,x[$7E:7840];\
$A3:B4FC A8          TAY                    ;} Y = [enemy X speed table index]
$A3:B4FD B9 15 B4    LDA $B415,y[$A3:B419]  ;\
$A3:B500 85 14       STA $14    [$7E:0014]  ;|
$A3:B502 B9 17 B4    LDA $B417,y[$A3:B41B]  ;} Enemy X position -= [$B415 + [Y]].[$B415 + [Y] + 2]
$A3:B505 85 12       STA $12    [$7E:0012]  ;|
$A3:B507 22 5A AF A0 JSL $A0AF5A[$A0:AF5A]  ;/
$A3:B50B 22 70 AD A0 JSL $A0AD70[$A0:AD70]  ;\
$A3:B50F D0 04       BNE $04    [$B515]     ;} If enemy is off-screen: go to BRANCH_OFF_SCREEN
$A3:B511 20 37 B5    JSR $B537  [$A3:B537]  ; Set Maridia refill candy instruction list
$A3:B514 6B          RTL

; BRANCH_OFF_SCREEN
$A3:B515 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A3:B518 09 00 01    ORA #$0100             ;} Set enemy to be invisible
$A3:B51B 9D 86 0F    STA $0F86,x[$7E:0F86]  ;/
$A3:B51E BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;\
$A3:B521 9D 7A 0F    STA $0F7A,x[$7E:0F7A]  ;} Enemy X position = [enemy spawn X position]
$A3:B524 BD AC 0F    LDA $0FAC,x[$7E:0FAC]  ;\
$A3:B527 9D 7E 0F    STA $0F7E,x[$7E:0F7E]  ;} Enemy Y position = [enemy spawn Y position]
$A3:B52A 9E AE 0F    STZ $0FAE,x[$7E:0FAE]  ; Enemy instruction list table index = 0
$A3:B52D 20 37 B5    JSR $B537  [$A3:B537]  ; Set Maridia refill candy instruction list
$A3:B530 A9 82 B4    LDA #$B482             ;\
$A3:B533 9D B4 0F    STA $0FB4,x[$7E:0FB4]  ;} Enemy function = $B482 (wait for Samus to get near)
$A3:B536 6B          RTL
}


;;; $B537: Set Maridia refill candy instruction list ;;;
{
$A3:B537 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B53A BD AE 0F    LDA $0FAE,x[$7E:0FEE]  ;\
$A3:B53D DD B0 0F    CMP $0FB0,x[$7E:0FF0]  ;} If [enemy previous instruction list table index] = [enemy instruction list table index]: return
$A3:B540 F0 14       BEQ $14    [$B556]     ;/
$A3:B542 9D B0 0F    STA $0FB0,x[$7E:0FF0]  ; Enemy previous instruction list table index = [enemy instruction list table index]
$A3:B545 0A          ASL A                  ;\
$A3:B546 A8          TAY                    ;|
$A3:B547 B9 0D B4    LDA $B40D,y[$A3:B413]  ;} Enemy instruction list pointer = [$B40D + [enemy instruction list table index] * 2]
$A3:B54A 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;/
$A3:B54D A9 01 00    LDA #$0001             ;\
$A3:B550 9D 94 0F    STA $0F94,x[$7E:0FD4]  ;} Enemy instruction timer = 1
$A3:B553 9E 90 0F    STZ $0F90,x[$7E:0FD0]  ; Enemy timer = 0

$A3:B556 60          RTS
}


;;; $B557: RTL ;;;
{
$A3:B557 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B55A 6B          RTL
}


;;; $B55B: RTL ;;;
{
$A3:B55B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B55E 6B          RTL
}


;;; $B55F: Maridia refill candy spritemaps ;;;
{
$A3:B55F             dx 0001, 81F8,F8,2100
$A3:B566             dx 0001, 81F8,F8,2102
$A3:B56D             dx 0001, 81F8,F8,2104
$A3:B574             dx 0001, 81F8,F8,2106
$A3:B57B             dx 0001, 81F8,F8,2108
$A3:B582             dx 0001, 81F8,F8,210A
$A3:B589             dx 0001, 81F8,F8,6100
$A3:B590             dx 0001, 81F8,F8,6102
$A3:B597             dx 0001, 81F8,F8,6104
$A3:B59E             dx 0001, 81F8,F8,6106
$A3:B5A5             dx 0001, 81F8,F8,6108
$A3:B5AC             dx 0001, 81F8,F8,610A
}
}


;;; $B5B3..B6F8: Norfair slow fireball ;;;
{
;;; $B5B3: Palette - enemy $DABF (Norfair slow fireball) ;;;
{
$A3:B5B3             dw 3800, 7FFF, 56E0, 3180, 18C0, 6BC0, 5EC0, 4A20, 35A0, 241F, 1C17, 142F, 0C47, 03E0, 02A0, 0140
}


;;; $B5D3: Instruction list -  ;;;
{
$A3:B5D3             dx E660,E7F2,  ; Enemy $0FB2 = $E7F2
                        80ED,B5EF   ; Go to $B5EF
}


;;; $B5DB: Instruction list -  ;;;
{
$A3:B5DB             dx E660,E7F2,  ; Enemy $0FB2 = $E7F2
                        80ED,B5EF   ; Go to $B5EF
}


;;; $B5E3: Instruction list -  ;;;
{
$A3:B5E3             dx E660,E6C8,  ; Enemy $0FB2 = $E6C8
                        80ED,B5EF   ; Go to $B5EF
}


;;; $B5EB: Instruction list -  ;;;
{
$A3:B5EB             dx E660,E6C8   ; Enemy $0FB2 = E6C8h
}


;;; $B5EF: Instruction list -  ;;;
{
$A3:B5EF             dx 000A,B689,
                        000A,B690,
                        000A,B697,
                        000A,B69E,
                        000A,B6A5,
                        000A,B6AC,
                        000A,B6B3,
                        000A,B6BA,
                        000A,B6B3,
                        000A,B6AC,
                        000A,B6A5,
                        000A,B69E,
                        000A,B697,
                        000A,B690,
                        80ED,B5EF   ; Go to $B5EF
}


;;; $B62B: Instruction list -  ;;;
{
$A3:B62B             dx 0006,B6C1,
                        0006,B6C8,
                        0006,B6CF,
                        0006,B6D6,
                        0006,B6DD,
                        0006,B6E4,
                        0006,B6EB,
                        0006,B6F2,
                        0006,B6EB,
                        0006,B6E4,
                        0006,B6DD,
                        0006,B6D6,
                        0006,B6CF,
                        0006,B6C8,
                        80ED,B62B   ; Go to $B62B
}


;;; $B667: Norfair slow fireball instruction list pointers ;;;
{
$A3:B667             dw B5E3, B5EB, B5D3, B5DB
}


;;; $B66F: Initialisation AI - enemy $DABF (Norfair slow fireball) ;;;
{
$A3:B66F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B672 A9 06 00    LDA #$0006
$A3:B675 9D B6 0F    STA $0FB6,x[$7E:0FB6]
$A3:B678 BD 86 0F    LDA $0F86,x[$7E:0F86]
$A3:B67B 29 03 00    AND #$0003
$A3:B67E 0A          ASL A
$A3:B67F A8          TAY
$A3:B680 B9 67 B6    LDA $B667,y[$A3:B667]
$A3:B683 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:B686 4C 7A E6    JMP $E67A  [$A3:E67A]  ; Go to creepy crawly common initialisation AI
}


;;; $B689: Norfair slow fireball spritemaps ;;;
{
$A3:B689             dx 0001, 81F8,F8,2100
$A3:B690             dx 0001, 81F8,F8,2102
$A3:B697             dx 0001, 81F8,F8,2104
$A3:B69E             dx 0001, 81F8,F8,2106
$A3:B6A5             dx 0001, 81F8,F8,2108
$A3:B6AC             dx 0001, 81F8,F8,210A
$A3:B6B3             dx 0001, 81F8,F8,210C
$A3:B6BA             dx 0001, 81F8,F8,210E
$A3:B6C1             dx 0001, 81F8,F8,6100
$A3:B6C8             dx 0001, 81F8,F8,6102
$A3:B6CF             dx 0001, 81F8,F8,6104
$A3:B6D6             dx 0001, 81F8,F8,6106
$A3:B6DD             dx 0001, 81F8,F8,6108
$A3:B6E4             dx 0001, 81F8,F8,610A
$A3:B6EB             dx 0001, 81F8,F8,610C
$A3:B6F2             dx 0001, 81F8,F8,610E
}
}


;;; $B6F9:  ;;;
{
$A3:B6F9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:B6FC BD 92 0F    LDA $0F92,x

$A3:B6FF D0 FE       BNE $FE    [$B6FF]
$A3:B701 6B          RTL
}


;;; $B702..C63D: Bang ;;;
{
;;; $B702: Palette - enemy $DB3F (bang) ;;;
{
$A3:B702             dw 3800, 013F, 00D8, 0091, 002B, 7F12, 5B13, 2B15, 0318, 6A03, 5DA2, 40E1, 2C60, 2020, 7FFF, 0842
}


;;; $B722: Instruction list pointers ;;;
{
$A3:B722             dw B75E, B772, B790, B7A4, B7C2, B7D6, B7F4, B838, B85A, B88A, B9FA, B9FA, B9FA, B9FA, B9FA, B9FA,
                        B9FA, BA00, B9FA, BA00, B8AC, B8C0, B8DE, B8F2, B910, B924, B942, B986, B9A8, B9D8
}


;;; $B75E: Instruction lists - bang ;;;
{
;;; $B75E: Instruction list - yyyy ;;;
{
$A3:B75E             dx 0020,BF7D,
                        000D,BF8B,
                        0010,BF99,
                        000D,BF8B,
                        80ED,B75E   ; Go to $B75E
}


;;; $B772: Instruction list - yyyy ;;;
{
$A3:B772             dx BA78,       ; Play acquired suit sound effect
                        0004,BFA7,
                        0008,BFAE,
                        0004,BFA7,
                        0002,BFB5,
                        0004,BFD2,
                        0010,BFEF,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B790: Instruction list - yyyy ;;;
{
$A3:B790             dx 0010,C00C,
                        0008,C029,
                        000D,C046,
                        0008,C029,
                        80ED,B790   ; Go to $B790
}


;;; $B7A4: Instruction list - yyyy ;;;
{
$A3:B7A4             dx BA78,       ; Play acquired suit sound effect
                        0004,C063,
                        0008,C079,
                        0004,C063,
                        0002,C08F,
                        0004,C0AC,
                        0010,C0C9,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B7C2: Instruction list - yyyy ;;;
{
$A3:B7C2             dx 000C,C0E6,
                        0006,C103,
                        0004,C120,
                        0006,C103,
                        80ED,B7C2   ; Go to $B7C2
}


;;; $B7D6: Instruction list - yyyy ;;;
{
$A3:B7D6             dx BA78,       ; Play acquired suit sound effect
                        0004,C13D,
                        0008,C15A,
                        0004,C13D,
                        0002,C177,
                        0004,C194,
                        0010,C1B1,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B7F4: Instruction list - yyyy ;;;
{
$A3:B7F4             dx 0008,C1CE,
                        0003,C1EB,
                        0002,C208,
                        0003,C1EB,
                        0008,C225,
                        0003,C242,
                        0002,C25F,
                        0003,C242,
                        0008,C1CE,
                        0003,C1EB,
                        0002,C208,
                        0003,C1EB,
                        0008,C27C,
                        0003,C299,
                        0002,C2B6,
                        0003,C299,
                        80ED,B7F4   ; Go to $B7F4
}


;;; $B838: Instruction list - yyyy ;;;
{
$A3:B838             dx BA78,       ; Play acquired suit sound effect
                        0004,C2D3,
                        0008,C2F0,
                        0004,C2D3,
                        0002,C30D,
                        0004,C32A,
                        0004,C347,
                        0010,C364,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B85A: Instruction list - yyyy ;;;
{
$A3:B85A             dx 0006,C411,
                        0002,C42E,
                        0001,C44B,
                        0002,C42E,
                        0006,C468,
                        0001,C44B,
                        0002,C42E,
                        0006,C4BF,
                        0002,C4DC,
                        0001,C4F9,
                        0002,C4DC,
                        80ED,B85A   ; Go to $B85A
}


;;; $B88A: Instruction list - yyyy ;;;
{
$A3:B88A             dx BA78,       ; Play acquired suit sound effect
                        0004,C516,
                        0008,C533,
                        0004,C516,
                        0002,C550,
                        0004,C56D,
                        0004,C58A,
                        0010,C5A7,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B8AC: Instruction list - yyyy ;;;
{
$A3:B8AC             dx 0020,BF84,
                        000D,BF92,
                        0010,BFA0,
                        000D,BF92,
                        80ED,B8AC   ; Go to $B8AC
}


;;; $B8C0: Instruction list - yyyy ;;;
{
$A3:B8C0             dx BA78,       ; Play acquired suit sound effect
                        0004,804D,
                        0008,804D,
                        0004,804D,
                        0002,BFBC,
                        0004,BFD9,
                        0010,BFF6,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B8DE: Instruction list - yyyy ;;;
{
$A3:B8DE             dx 0010,C013,
                        0008,C030,
                        000D,C04D,
                        0008,C030,
                        80ED,B8DE   ; Go to $B8DE
}


;;; $B8F2: Instruction list - yyyy ;;;
{
$A3:B8F2             dx BA78,       ; Play acquired suit sound effect
                        0004,804D,
                        0008,804D,
                        0004,804D,
                        0002,C096,
                        0004,C0B3,
                        0010,C0D0,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B910: Instruction list - yyyy ;;;
{
$A3:B910             dx 000C,C0ED,
                        0006,C10A,
                        0004,C127,
                        0006,C10A,
                        80ED,B910   ; Go to $B910
}


;;; $B924: Instruction list - yyyy ;;;
{
$A3:B924             dx BA78,       ; Play acquired suit sound effect
                        0004,C144,
                        0008,C161,
                        0004,C144,
                        0002,C17E,
                        0004,C19B,
                        0010,C1B8,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B942: Instruction list - yyyy ;;;
{
$A3:B942             dx 0008,C1D5,
                        0003,C1F2,
                        0002,C20F,
                        0003,C1F2,
                        0008,C22C,
                        0003,C249,
                        0002,C266,
                        0003,C249,
                        0008,C1D5,
                        0003,C1F2,
                        0002,C20F,
                        0003,C1F2,
                        0008,C283,
                        0003,C2A0,
                        0002,C2BD,
                        0003,C2A0,
                        80ED,B942   ; Go to $B942
}


;;; $B986: Instruction list - yyyy ;;;
{
$A3:B986             dx BA78,       ; Play acquired suit sound effect
                        0004,C2DA,
                        0008,C2F7,
                        0004,C2DA,
                        0002,C314,
                        0004,C331,
                        0004,C34E,
                        0010,C36B,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B9A8: Instruction list - yyyy ;;;
{
$A3:B9A8             dx 0006,C418,
                        0002,C435,
                        0001,C452,
                        0002,C435,
                        0006,C46F,
                        0001,C452,
                        0002,C435,
                        0006,C4C6,
                        0002,C4E3,
                        0001,C500,
                        0002,C4E3,
                        80ED,B9A8   ; Go to $B9A8
}


;;; $B9D8: Instruction list - yyyy ;;;
{
$A3:B9D8             dx BA78,       ; Play acquired suit sound effect
                        0004,C51D,
                        0008,C53A,
                        0004,C51D,
                        0002,C557,
                        0004,C574,
                        0004,C591,
                        0010,804D,
                        BAA8,       ; Enemy $7E:8004 = 1
                        812F        ; Sleep
}


;;; $B9FA: Instruction list - yyyy ;;;
{
$A3:B9FA             dx 0001,804D,
                        812F        ; Sleep
}


;;; $BA00: Instruction list - yyyy ;;;
{
$A3:BA00             dx 0002,C381,
                        0003,C38D,
                        0004,C399,
                        0002,804D,
                        0004,C3A5,
                        0002,C3B1,
                        0003,C3BD,
                        0002,C3C9,
                        0004,C3D5,
                        0003,C3E1,
                        000A,804D,
                        0003,C3ED,
                        0002,C3F9,
                        0004,C405,
                        80ED,BA00   ; Go to $BA00
}


;;; $BA3C: Instruction list - yyyy ;;;
{
$A3:BA3C             dx 0002,C5AE,
                        0003,C5BA,
                        0004,C5C6,
                        0002,804D,
                        0004,C5D2,
                        0002,C5DE,
                        0003,C5EA,
                        0002,C5F6,
                        0004,C602,
                        0003,C60E,
                        000A,804D,
                        0003,C61A,
                        0002,C626,
                        0004,C632,
                        80ED,BA3C   ; Go to $BA3C
}
}


;;; $BA78: Instruction - play acquired suit sound effect ;;;
{
$A3:BA78 5A          PHY
$A3:BA79 DA          PHX
$A3:BA7A A9 56 00    LDA #$0056             ;\
$A3:BA7D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 56h, sound library 2, max queued sounds allowed = 6 (acquired suit)
$A3:BA81 FA          PLX
$A3:BA82 7A          PLY
$A3:BA83 6B          RTL
}


;;; $BA84:  ;;;
{
$A3:BA84             dw 02FF, 03FF, 04FF, 05FF, 06FF, 07FF, 08FF, 09FF
}


;;; $BA94:  ;;;
{
$A3:BA94             dw 00C0, ; 0: Up, facing right
                        00E0, ; 1: Up-right
                        0000, ; 2: Right
                        0020, ; 3: Down-right
                        0040, ; 4: Down, facing right
                        0040, ; 5: Down, facing left
                        0060, ; 6: Down-left
                        0080, ; 7: Left
                        00A0, ; 8: Up-left
                        00C0  ; 9: Up, facing left
}


;;; $BAA8: Instruction -  ;;;
{
$A3:BAA8 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BAAB A9 01 00    LDA #$0001
$A3:BAAE 9F 04 80 7E STA $7E8004,x
$A3:BAB2 6B          RTL
}


;;; $BAB3: Initialisation AI - enemy $DB3F (bang) ;;;
{
$A3:BAB3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BAB6 BD 96 0F    LDA $0F96,x
$A3:BAB9 9D AA 0F    STA $0FAA,x
$A3:BABC BD 86 0F    LDA $0F86,x
$A3:BABF 09 00 10    ORA #$1000
$A3:BAC2 9D 86 0F    STA $0F86,x
$A3:BAC5 A9 A5 BC    LDA #$BCA5
$A3:BAC8 9D B2 0F    STA $0FB2,x
$A3:BACB A9 10 00    LDA #$0010
$A3:BACE 9F 00 78 7E STA $7E7800,x
$A3:BAD2 A9 00 00    LDA #$0000
$A3:BAD5 9F 02 78 7E STA $7E7802,x
$A3:BAD9 9F 04 78 7E STA $7E7804,x
$A3:BADD 9F 00 80 7E STA $7E8000,x
$A3:BAE1 9F 02 80 7E STA $7E8002,x
$A3:BAE5 9F 04 80 7E STA $7E8004,x
$A3:BAE9 BD B6 0F    LDA $0FB6,x
$A3:BAEC 29 FF 00    AND #$00FF
$A3:BAEF 0A          ASL A
$A3:BAF0 A8          TAY
$A3:BAF1 B9 84 BA    LDA $BA84,y
$A3:BAF4 9F 16 78 7E STA $7E7816,x
$A3:BAF8 BD B7 0F    LDA $0FB7,x
$A3:BAFB 29 FF 00    AND #$00FF
$A3:BAFE 0A          ASL A
$A3:BAFF 0A          ASL A
$A3:BB00 A8          TAY
$A3:BB01 B9 6A BC    LDA $BC6A,y
$A3:BB04 9F 18 78 7E STA $7E7818,x
$A3:BB08 9F 1A 78 7E STA $7E781A,x
$A3:BB0C B9 6C BC    LDA $BC6C,y
$A3:BB0F 9F 1C 78 7E STA $7E781C,x
$A3:BB13 BD 92 0F    LDA $0F92,x
$A3:BB16 D0 06       BNE $06    [$BB1E]
$A3:BB18 A9 C1 BC    LDA #$BCC1
$A3:BB1B 9D B2 0F    STA $0FB2,x

$A3:BB1E A9 5E B7    LDA #$B75E
$A3:BB21 9D 92 0F    STA $0F92,x
$A3:BB24 6B          RTL
}


;;; $BB25: Main AI - enemy $DB3F (bang) ;;;
{
$A3:BB25 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BB28 7C B4 0F    JMP ($0FB4,x)
}


;;; $BB2B:  ;;;
{
$A3:BB2B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BB2E BF 40 80 7E LDA $7E8040,x
$A3:BB32 18          CLC
$A3:BB33 69 0A 00    ADC #$000A
$A3:BB36 9F 00 80 7E STA $7E8000,x
$A3:BB3A 20 DA BE    JSR $BEDA  [$A3:BEDA]
$A3:BB3D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BB40 BD 86 0F    LDA $0F86,x
$A3:BB43 09 00 04    ORA #$0400
$A3:BB46 9D 86 0F    STA $0F86,x
$A3:BB49 6B          RTL
}


;;; $BB4A:  ;;;
{
$A3:BB4A AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BB4D BF C0 7F 7E LDA $7E7FC0,x
$A3:BB51 18          CLC
$A3:BB52 69 14 00    ADC #$0014
$A3:BB55 9F 00 80 7E STA $7E8000,x
$A3:BB59 20 DA BE    JSR $BEDA  [$A3:BEDA]
$A3:BB5C BD 86 0F    LDA $0F86,x
$A3:BB5F 09 00 04    ORA #$0400
$A3:BB62 9D 86 0F    STA $0F86,x
$A3:BB65 6B          RTL
}


;;; $BB66:  ;;;
{
$A3:BB66 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BB69 20 9E BC    JSR $BC9E  [$A3:BC9E]
$A3:BB6C BD 7A 0F    LDA $0F7A,x
$A3:BB6F 9D 3A 0F    STA $0F3A,x
$A3:BB72 9D BA 0F    STA $0FBA,x
$A3:BB75 BD 7E 0F    LDA $0F7E,x
$A3:BB78 9D 3E 0F    STA $0F3E,x
$A3:BB7B 9D BE 0F    STA $0FBE,x
$A3:BB7E BC AA 0F    LDY $0FAA,x
$A3:BB81 BF 00 80 7E LDA $7E8000,x
$A3:BB85 29 01 00    AND #$0001
$A3:BB88 F0 03       BEQ $03    [$BB8D]
$A3:BB8A A0 00 0C    LDY #$0C00

$A3:BB8D 98          TYA
$A3:BB8E 9D 96 0F    STA $0F96,x
$A3:BB91 20 DA BE    JSR $BEDA  [$A3:BEDA]
$A3:BB94 BF 04 80 7E LDA $7E8004,x
$A3:BB98 D0 01       BNE $01    [$BB9B]
$A3:BB9A 6B          RTL

$A3:BB9B A9 00 00    LDA #$0000
$A3:BB9E 9F 04 80 7E STA $7E8004,x
$A3:BBA2 BF 00 80 7E LDA $7E8000,x
$A3:BBA6 C9 09 00    CMP #$0009
$A3:BBA9 D0 30       BNE $30    [$BBDB]
$A3:BBAB A9 10 00    LDA #$0010
$A3:BBAE 9D A0 0F    STA $0FA0,x
$A3:BBB1 BD 86 0F    LDA $0F86,x
$A3:BBB4 09 00 04    ORA #$0400
$A3:BBB7 9D 86 0F    STA $0F86,x
$A3:BBBA 22 29 AE A0 JSL $A0AE29[$A0:AE29]
$A3:BBBE 20 EB BB    JSR $BBEB  [$A3:BBEB]
$A3:BBC1 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]
$A3:BBC5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BBC8 BD C6 0F    LDA $0FC6,x
$A3:BBCB 09 00 02    ORA #$0200
$A3:BBCE 9D C6 0F    STA $0FC6,x
$A3:BBD1 BD 46 0F    LDA $0F46,x
$A3:BBD4 09 00 02    ORA #$0200
$A3:BBD7 9D 46 0F    STA $0F46,x
$A3:BBDA 6B          RTL

$A3:BBDB AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BBDE BF 00 80 7E LDA $7E8000,x
$A3:BBE2 1A          INC A
$A3:BBE3 9F 00 80 7E STA $7E8000,x
$A3:BBE7 20 DA BE    JSR $BEDA  [$A3:BEDA]
$A3:BBEA 6B          RTL
}


;;; $BBEB:  ;;;
{
$A3:BBEB 8D 72 18    STA $1872  [$7E:1872]
$A3:BBEE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BBF1 AD CE 0C    LDA $0CCE  [$7E:0CCE]
$A3:BBF4 C9 05 00    CMP #$0005
$A3:BBF7 10 4D       BPL $4D    [$BC46]
$A3:BBF9 A9 00 00    LDA #$0000
$A3:BBFC A8          TAY

$A3:BBFD B9 2C 0C    LDA $0C2C,y
$A3:BC00 F0 04       BEQ $04    [$BC06]
$A3:BC02 C8          INY
$A3:BC03 C8          INY
$A3:BC04 80 F7       BRA $F7    [$BBFD]

$A3:BC06 BD 7A 0F    LDA $0F7A,x
$A3:BC09 99 64 0B    STA $0B64,y
$A3:BC0C BD 7E 0F    LDA $0F7E,x
$A3:BC0F 99 78 0B    STA $0B78,y
$A3:BC12 AD 72 18    LDA $1872  [$7E:1872]
$A3:BC15 99 04 0C    STA $0C04,y
$A3:BC18 AD A6 09    LDA $09A6  [$7E:09A6]
$A3:BC1B 29 0F 00    AND #$000F
$A3:BC1E 09 10 00    ORA #$0010
$A3:BC21 99 18 0C    STA $0C18,y
$A3:BC24 EE CE 0C    INC $0CCE  [$7E:0CCE]
$A3:BC27 84 14       STY $14    [$7E:0014]
$A3:BC29 22 00 BE 90 JSL $90BE00[$90:BE00]
$A3:BC2D BD B0 0F    LDA $0FB0,x
$A3:BC30 99 2C 0C    STA $0C2C,y
$A3:BC33 B9 18 0C    LDA $0C18,y            ;\
$A3:BC36 29 0F 00    AND #$000F             ;|
$A3:BC39 0A          ASL A                  ;|
$A3:BC3A AA          TAX                    ;} Queue sound [$BC4A + ([projectile type] & Fh) * 2], sound library 1, max queued sounds allowed = 6
$A3:BC3B BD 4A BC    LDA $BC4A,x            ;|
$A3:BC3E 22 49 90 80 JSL $809049[$80:9049]  ;/
$A3:BC42 A9 00 00    LDA #$0000
$A3:BC45 60          RTS

$A3:BC46 A9 01 00    LDA #$0001
$A3:BC49 60          RTS

$A3:BC4A             dw 0017, 0019, 0018, 001A, 001E, 001C, 001D, 001F, 0022, 0020, 0021, 0000, 0000, 0000, 0000, 0000
}


;;; $BC6A:  ;;;
{
$A3:BC6A             dw 0003, 0001, 0004, 0001, 0005, 0002, 0006, 0002, 0007, 0002, 0008, 0003, 0009, 0003, 000A, 0004,
                        000B, 0004, 000C, 0005, 000D, 0005, 000E, 0006, 000F, 0006
}


;;; $BC9E:  ;;;
{
$A3:BC9E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BCA1 FC B2 0F    JSR ($0FB2,x)
$A3:BCA4 60          RTS
}


;;; $BCA5:  ;;;
{
$A3:BCA5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BCA8 BF 00 78 7E LDA $7E7800,x
$A3:BCAC 3A          DEC A
$A3:BCAD 9F 00 78 7E STA $7E7800,x
$A3:BCB1 D0 0D       BNE $0D    [$BCC0]
$A3:BCB3 A9 10 00    LDA #$0010
$A3:BCB6 9F 00 78 7E STA $7E7800,x
$A3:BCBA A9 C5 BC    LDA #$BCC5
$A3:BCBD 9D B2 0F    STA $0FB2,x

$A3:BCC0 60          RTS
}


;;; $BCC1:  ;;;
{
$A3:BCC1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BCC4 60          RTS
}


;;; $BCC5:  ;;;
{
$A3:BCC5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BCC8 22 66 C0 A0 JSL $A0C066[$A0:C066]
$A3:BCCC 38          SEC
$A3:BCCD E9 40 00    SBC #$0040
$A3:BCD0 29 FF 00    AND #$00FF
$A3:BCD3 9F 02 78 7E STA $7E7802,x
$A3:BCD7 A9 1C BD    LDA #$BD1C
$A3:BCDA 9D B2 0F    STA $0FB2,x
$A3:BCDD A9 00 00    LDA #$0000
$A3:BCE0 9F 0E 78 7E STA $7E780E,x
$A3:BCE4 9F 10 78 7E STA $7E7810,x
$A3:BCE8 9F 12 78 7E STA $7E7812,x
$A3:BCEC 9F 14 78 7E STA $7E7814,x
$A3:BCF0 60          RTS
}


;;; $BCF1:  ;;;
{
$A3:BCF1 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BCF4 22 66 C0 A0 JSL $A0C066[$A0:C066]
$A3:BCF8 38          SEC
$A3:BCF9 E9 40 00    SBC #$0040
$A3:BCFC 29 FF 00    AND #$00FF
$A3:BCFF 9F 04 78 7E STA $7E7804,x
$A3:BD03 38          SEC
$A3:BD04 FF 02 78 7E SBC $7E7802,x
$A3:BD08 22 EA AF A0 JSL $A0AFEA[$A0:AFEA]
$A3:BD0C 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A3:BD10 C9 30 00    CMP #$0030
$A3:BD13 30 06       BMI $06    [$BD1B]
$A3:BD15 A9 2C BD    LDA #$BD2C
$A3:BD18 9D B2 0F    STA $0FB2,x

$A3:BD1B 60          RTS
}


;;; $BD1C:  ;;;
{
$A3:BD1C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BD1F 20 B9 BD    JSR $BDB9  [$A3:BDB9]
$A3:BD22 20 1C BE    JSR $BE1C  [$A3:BE1C]
$A3:BD25 20 4F BD    JSR $BD4F  [$A3:BD4F]
$A3:BD28 20 F1 BC    JSR $BCF1  [$A3:BCF1]
$A3:BD2B 60          RTS
}


;;; $BD2C:  ;;;
{
$A3:BD2C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BD2F 20 B9 BD    JSR $BDB9  [$A3:BDB9]
$A3:BD32 20 1C BE    JSR $BE1C  [$A3:BE1C]
$A3:BD35 20 89 BD    JSR $BD89  [$A3:BD89]
$A3:BD38 BF 14 78 7E LDA $7E7814,x
$A3:BD3C D0 0A       BNE $0A    [$BD48]
$A3:BD3E 30 08       BMI $08    [$BD48]
$A3:BD40 BF 12 78 7E LDA $7E7812,x
$A3:BD44 F0 02       BEQ $02    [$BD48]
$A3:BD46 10 06       BPL $06    [$BD4E]

$A3:BD48 A9 A5 BC    LDA #$BCA5
$A3:BD4B 9D B2 0F    STA $0FB2,x

$A3:BD4E 60          RTS
}


;;; $BD4F:  ;;;
{
$A3:BD4F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BD52 BF 18 78 7E LDA $7E7818,x
$A3:BD56 3A          DEC A
$A3:BD57 9F 18 78 7E STA $7E7818,x
$A3:BD5B 10 2B       BPL $2B    [$BD88]
$A3:BD5D BF 1A 78 7E LDA $7E781A,x
$A3:BD61 9F 18 78 7E STA $7E7818,x
$A3:BD65 BF 14 78 7E LDA $7E7814,x
$A3:BD69 DF 16 78 7E CMP $7E7816,x
$A3:BD6D 10 19       BPL $19    [$BD88]
$A3:BD6F BF 12 78 7E LDA $7E7812,x
$A3:BD73 18          CLC
$A3:BD74 69 16 00    ADC #$0016
$A3:BD77 9F 12 78 7E STA $7E7812,x
$A3:BD7B BF 14 78 7E LDA $7E7814,x
$A3:BD7F 18          CLC
$A3:BD80 7F 12 78 7E ADC $7E7812,x
$A3:BD84 9F 14 78 7E STA $7E7814,x

$A3:BD88 60          RTS
}


;;; $BD89:  ;;;
{
$A3:BD89 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BD8C BF 18 78 7E LDA $7E7818,x
$A3:BD90 3A          DEC A
$A3:BD91 9F 18 78 7E STA $7E7818,x
$A3:BD95 10 21       BPL $21    [$BDB8]
$A3:BD97 BF 1C 78 7E LDA $7E781C,x
$A3:BD9B 9F 18 78 7E STA $7E7818,x
$A3:BD9F BF 12 78 7E LDA $7E7812,x
$A3:BDA3 38          SEC
$A3:BDA4 E9 16 00    SBC #$0016
$A3:BDA7 9F 12 78 7E STA $7E7812,x
$A3:BDAB BF 14 78 7E LDA $7E7814,x
$A3:BDAF 38          SEC
$A3:BDB0 FF 12 78 7E SBC $7E7812,x
$A3:BDB4 9F 14 78 7E STA $7E7814,x

$A3:BDB8 60          RTS
}


;;; $BDB9:  ;;;
{
$A3:BDB9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BDBC BF 02 78 7E LDA $7E7802,x
$A3:BDC0 DA          PHX
$A3:BDC1 18          CLC
$A3:BDC2 69 40 00    ADC #$0040
$A3:BDC5 29 FF 00    AND #$00FF
$A3:BDC8 0A          ASL A
$A3:BDC9 AA          TAX
$A3:BDCA BF C3 B1 A0 LDA $A0B1C3,x
$A3:BDCE 85 12       STA $12    [$7E:0012]
$A3:BDD0 FA          PLX
$A3:BDD1 A5 12       LDA $12    [$7E:0012]
$A3:BDD3 10 07       BPL $07    [$BDDC]
$A3:BDD5 A9 01 00    LDA #$0001
$A3:BDD8 9F 0E 78 7E STA $7E780E,x

$A3:BDDC A5 12       LDA $12    [$7E:0012]
$A3:BDDE 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A3:BDE2 29 00 FF    AND #$FF00
$A3:BDE5 EB          XBA
$A3:BDE6 85 16       STA $16    [$7E:0016]
$A3:BDE8 BF 14 78 7E LDA $7E7814,x
$A3:BDEC 85 18       STA $18    [$7E:0018]
$A3:BDEE 20 7B BE    JSR $BE7B  [$A3:BE7B]
$A3:BDF1 A5 1C       LDA $1C    [$7E:001C]
$A3:BDF3 85 16       STA $16    [$7E:0016]
$A3:BDF5 A5 1E       LDA $1E    [$7E:001E]
$A3:BDF7 85 18       STA $18    [$7E:0018]
$A3:BDF9 BF 0E 78 7E LDA $7E780E,x
$A3:BDFD F0 0B       BEQ $0B    [$BE0A]
$A3:BDFF 20 BE BE    JSR $BEBE  [$A3:BEBE]
$A3:BE02 A5 1C       LDA $1C    [$7E:001C]
$A3:BE04 85 16       STA $16    [$7E:0016]
$A3:BE06 A5 1E       LDA $1E    [$7E:001E]
$A3:BE08 85 18       STA $18    [$7E:0018]

$A3:BE0A 18          CLC
$A3:BE0B BD 7C 0F    LDA $0F7C,x
$A3:BE0E 65 16       ADC $16    [$7E:0016]
$A3:BE10 9D 7C 0F    STA $0F7C,x
$A3:BE13 BD 7A 0F    LDA $0F7A,x
$A3:BE16 65 18       ADC $18    [$7E:0018]
$A3:BE18 9D 7A 0F    STA $0F7A,x
$A3:BE1B 60          RTS
}


;;; $BE1C:  ;;;
{
$A3:BE1C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BE1F BF 02 78 7E LDA $7E7802,x
$A3:BE23 DA          PHX
$A3:BE24 29 FF 00    AND #$00FF
$A3:BE27 0A          ASL A
$A3:BE28 AA          TAX
$A3:BE29 BF C3 B1 A0 LDA $A0B1C3,x
$A3:BE2D 85 12       STA $12    [$7E:0012]
$A3:BE2F FA          PLX
$A3:BE30 A5 12       LDA $12    [$7E:0012]
$A3:BE32 10 07       BPL $07    [$BE3B]
$A3:BE34 A9 01 00    LDA #$0001
$A3:BE37 9F 10 78 7E STA $7E7810,x

$A3:BE3B A5 12       LDA $12    [$7E:0012]
$A3:BE3D 22 67 B0 A0 JSL $A0B067[$A0:B067]
$A3:BE41 29 00 FF    AND #$FF00
$A3:BE44 EB          XBA
$A3:BE45 85 16       STA $16    [$7E:0016]
$A3:BE47 BF 14 78 7E LDA $7E7814,x
$A3:BE4B 85 18       STA $18    [$7E:0018]
$A3:BE4D 20 7B BE    JSR $BE7B  [$A3:BE7B]
$A3:BE50 A5 1C       LDA $1C    [$7E:001C]
$A3:BE52 85 16       STA $16    [$7E:0016]
$A3:BE54 A5 1E       LDA $1E    [$7E:001E]
$A3:BE56 85 18       STA $18    [$7E:0018]
$A3:BE58 BF 10 78 7E LDA $7E7810,x
$A3:BE5C F0 0B       BEQ $0B    [$BE69]
$A3:BE5E 20 BE BE    JSR $BEBE  [$A3:BEBE]
$A3:BE61 A5 1C       LDA $1C    [$7E:001C]
$A3:BE63 85 16       STA $16    [$7E:0016]
$A3:BE65 A5 1E       LDA $1E    [$7E:001E]
$A3:BE67 85 18       STA $18    [$7E:0018]

$A3:BE69 18          CLC
$A3:BE6A BD 80 0F    LDA $0F80,x
$A3:BE6D 65 16       ADC $16    [$7E:0016]
$A3:BE6F 9D 80 0F    STA $0F80,x
$A3:BE72 BD 7E 0F    LDA $0F7E,x
$A3:BE75 65 18       ADC $18    [$7E:0018]
$A3:BE77 9D 7E 0F    STA $0F7E,x
$A3:BE7A 60          RTS
}


;;; $BE7B:  ;;;
{
$A3:BE7B 08          PHP
$A3:BE7C E2 20       SEP #$20
$A3:BE7E A5 16       LDA $16    [$7E:0016]
$A3:BE80 8D 02 42    STA $4202  [$7E:4202]
$A3:BE83 A5 18       LDA $18    [$7E:0018]
$A3:BE85 8D 03 42    STA $4203  [$7E:4203]
$A3:BE88 EA          NOP
$A3:BE89 EA          NOP
$A3:BE8A EA          NOP
$A3:BE8B C2 20       REP #$20
$A3:BE8D AD 16 42    LDA $4216  [$7E:4216]
$A3:BE90 85 1C       STA $1C    [$7E:001C]
$A3:BE92 E2 20       SEP #$20
$A3:BE94 A5 16       LDA $16    [$7E:0016]
$A3:BE96 8D 02 42    STA $4202  [$7E:4202]
$A3:BE99 A5 19       LDA $19    [$7E:0019]
$A3:BE9B 8D 03 42    STA $4203  [$7E:4203]
$A3:BE9E EA          NOP
$A3:BE9F EA          NOP
$A3:BEA0 EA          NOP
$A3:BEA1 C2 20       REP #$20
$A3:BEA3 AD 16 42    LDA $4216  [$7E:4216]
$A3:BEA6 29 00 FF    AND #$FF00
$A3:BEA9 EB          XBA
$A3:BEAA 85 1E       STA $1E    [$7E:001E]
$A3:BEAC AD 16 42    LDA $4216  [$7E:4216]
$A3:BEAF 29 FF 00    AND #$00FF
$A3:BEB2 EB          XBA
$A3:BEB3 18          CLC
$A3:BEB4 65 1C       ADC $1C    [$7E:001C]
$A3:BEB6 85 1C       STA $1C    [$7E:001C]
$A3:BEB8 90 02       BCC $02    [$BEBC]
$A3:BEBA E6 1E       INC $1E    [$7E:001E]

$A3:BEBC 28          PLP
$A3:BEBD 60          RTS
}


;;; $BEBE:  ;;;
{
$A3:BEBE A5 16       LDA $16    [$7E:0016]
$A3:BEC0 D0 06       BNE $06    [$BEC8]
$A3:BEC2 A5 18       LDA $18    [$7E:0018]
$A3:BEC4 D0 02       BNE $02    [$BEC8]
$A3:BEC6 80 11       BRA $11    [$BED9]

$A3:BEC8 A5 16       LDA $16    [$7E:0016]  ; >_<;
$A3:BECA A9 00 00    LDA #$0000
$A3:BECD 38          SEC
$A3:BECE E5 16       SBC $16    [$7E:0016]
$A3:BED0 85 1C       STA $1C    [$7E:001C]
$A3:BED2 A5 18       LDA $18    [$7E:0018]
$A3:BED4 49 FF FF    EOR #$FFFF
$A3:BED7 85 1E       STA $1E    [$7E:001E]

$A3:BED9 60          RTS
}


;;; $BEDA:  ;;;
{
$A3:BEDA AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BEDD BF 00 80 7E LDA $7E8000,x
$A3:BEE1 DF 02 80 7E CMP $7E8002,x
$A3:BEE5 F0 15       BEQ $15    [$BEFC]
$A3:BEE7 9F 02 80 7E STA $7E8002,x
$A3:BEEB 0A          ASL A
$A3:BEEC A8          TAY
$A3:BEED B9 22 B7    LDA $B722,y
$A3:BEF0 9D 92 0F    STA $0F92,x
$A3:BEF3 A9 01 00    LDA #$0001
$A3:BEF6 9D 94 0F    STA $0F94,x
$A3:BEF9 9E 90 0F    STZ $0F90,x

$A3:BEFC 60          RTS
}


;;; $BEFD: Enemy shot - enemy $DB3F (bang) ;;;
{
$A3:BEFD AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BF00 BD B2 0F    LDA $0FB2,x
$A3:BF03 C9 C1 BC    CMP #$BCC1
$A3:BF06 F0 33       BEQ $33    [$BF3B]
$A3:BF08 AD A6 18    LDA $18A6  [$7E:18A6]
$A3:BF0B 0A          ASL A
$A3:BF0C A8          TAY
$A3:BF0D B9 04 0C    LDA $0C04,y
$A3:BF10 29 0F 00    AND #$000F
$A3:BF13 0A          ASL A
$A3:BF14 A8          TAY
$A3:BF15 B9 94 BA    LDA $BA94,y
$A3:BF18 9F 02 78 7E STA $7E7802,x
$A3:BF1C A9 2C BD    LDA #$BD2C
$A3:BF1F 9D B2 0F    STA $0FB2,x
$A3:BF22 A9 00 00    LDA #$0000
$A3:BF25 9F 0E 78 7E STA $7E780E,x
$A3:BF29 9F 10 78 7E STA $7E7810,x
$A3:BF2D A9 00 01    LDA #$0100
$A3:BF30 9F 12 78 7E STA $7E7812,x
$A3:BF34 A9 00 06    LDA #$0600
$A3:BF37 9F 14 78 7E STA $7E7814,x

$A3:BF3B BF 00 80 7E LDA $7E8000,x
$A3:BF3F C9 09 00    CMP #$0009
$A3:BF42 D0 01       BNE $01    [$BF45]
$A3:BF44 6B          RTL

$A3:BF45 BF 00 80 7E LDA $7E8000,x
$A3:BF49 1A          INC A
$A3:BF4A 9F 00 80 7E STA $7E8000,x
$A3:BF4E 20 DA BE    JSR $BEDA  [$A3:BEDA]
$A3:BF51 AD A6 18    LDA $18A6  [$7E:18A6]
$A3:BF54 0A          ASL A
$A3:BF55 A8          TAY
$A3:BF56 B9 2C 0C    LDA $0C2C,y
$A3:BF59 18          CLC
$A3:BF5A 7D B0 0F    ADC $0FB0,x
$A3:BF5D 9D B0 0F    STA $0FB0,x
$A3:BF60 B9 04 0C    LDA $0C04,y
$A3:BF63 09 10 00    ORA #$0010
$A3:BF66 99 04 0C    STA $0C04,y
$A3:BF69 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:BF6C BF 00 80 7E LDA $7E8000,x
$A3:BF70 C9 09 00    CMP #$0009
$A3:BF73 F0 01       BEQ $01    [$BF76]
$A3:BF75 6B          RTL

$A3:BF76 A9 01 00    LDA #$0001
$A3:BF79 9D AE 0F    STA $0FAE,x
$A3:BF7C 6B          RTL
}


;;; $BF7D: Bang spritemaps ;;;
{
$A3:BF7D             dx 0001, 01FC,FC,3113
$A3:BF84             dx 0001, 01FC,FC,3110
$A3:BF8B             dx 0001, 01FC,FC,3114
$A3:BF92             dx 0001, 01FC,FC,3111
$A3:BF99             dx 0001, 01FC,FC,3115
$A3:BFA0             dx 0001, 01FC,FC,3112
$A3:BFA7             dx 0001, 01FC,FC,3170
$A3:BFAE             dx 0001, 01FC,FC,3160
$A3:BFB5             dx 0001, 01FC,FC,3116
$A3:BFBC             dx 0004, 01F9,FF,F101, 01FF,FF,B101, 01FF,F9,3101, 01F9,F9,3100
$A3:BFD2             dx 0001, 01FC,FC,3116
$A3:BFD9             dx 0004, 01F8,FF,F101, 0000,FF,B101, 0000,F9,3101, 01F8,F9,3100
$A3:BFEF             dx 0001, 01FC,FC,3116
$A3:BFF6             dx 0004, 01F8,00,F101, 0000,00,B101, 0000,F8,3101, 01F8,F8,3100
$A3:C00C             dx 0001, 01FC,FC,3116
$A3:C013             dx 0004, 01F8,00,F101, 0000,00,B101, 0000,F8,3101, 01F8,F8,3100
$A3:C029             dx 0001, 01FC,FC,3117
$A3:C030             dx 0004, 01F8,00,F103, 0000,00,B103, 0000,F8,3103, 01F8,F8,3102
$A3:C046             dx 0001, 01FC,FC,3118
$A3:C04D             dx 0004, 01F8,00,F105, 0000,00,B105, 0000,F8,3105, 01F8,F8,3104
$A3:C063             dx 0004, 0000,00,F172, 01F8,00,B172, 0000,F8,7172, 01F8,F8,3172
$A3:C079             dx 0004, 0000,00,F171, 01F8,00,B171, 0000,F8,7171, 01F8,F8,3171
$A3:C08F             dx 0001, 01FC,FC,3119
$A3:C096             dx 0004, 01F9,FF,F107, 01FF,FF,B107, 01FF,F9,3107, 01F9,F9,3106
$A3:C0AC             dx 0001, 01FC,FC,3119
$A3:C0B3             dx 0004, 01F9,00,F107, 01FF,00,B107, 01FF,F8,3107, 01F9,F8,3106
$A3:C0C9             dx 0001, 01FC,FC,3119
$A3:C0D0             dx 0004, 01F8,00,F107, 0000,00,B107, 0000,F8,3107, 01F8,F8,3106
$A3:C0E6             dx 0001, 01FC,FC,3119
$A3:C0ED             dx 0004, 01F8,00,F107, 0000,00,B107, 0000,F8,3107, 01F8,F8,3106
$A3:C103             dx 0001, 01FC,FC,311A
$A3:C10A             dx 0004, 01F8,00,F109, 0000,00,B109, 0000,F8,3109, 01F8,F8,3108
$A3:C120             dx 0001, 01FC,FC,311B
$A3:C127             dx 0004, 01F8,00,F10B, 0000,00,B10B, 0000,F8,310B, 01F8,F8,310A
$A3:C13D             dx 0001, 01FC,FC,3119
$A3:C144             dx 0004, 0000,00,F177, 01F8,00,B177, 0000,F8,7177, 01F8,F8,3177
$A3:C15A             dx 0001, 01FC,FC,3119
$A3:C161             dx 0004, 0000,00,F167, 01F8,00,B167, 0000,F8,7167, 01F8,F8,3167
$A3:C177             dx 0001, C3F8,F8,310C
$A3:C17E             dx 0004, C3F2,FE,F122, C3FE,FE,B122, C3FE,F2,3122, C3F2,F2,3120
$A3:C194             dx 0001, C3F8,F8,310C
$A3:C19B             dx 0004, C3FF,F1,3122, C3F1,F1,3120, C3F1,FF,F122, C3FF,FF,B122
$A3:C1B1             dx 0001, C3F8,F8,310C
$A3:C1B8             dx 0004, C3F0,00,F122, C200,00,B122, C200,F0,3122, C3F0,F0,3120
$A3:C1CE             dx 0001, C3F8,F8,310C
$A3:C1D5             dx 0004, C200,F0,3122, C3F0,F0,3120, C3F0,00,F122, C200,00,B122
$A3:C1EB             dx 0001, C3F8,F8,312C
$A3:C1F2             dx 0004, C3F0,00,F126, C200,00,B126, C200,F0,3126, C3F0,F0,3124
$A3:C208             dx 0001, C3F8,F8,314C
$A3:C20F             dx 0004, C200,F0,312A, C3F0,F0,3128, C3F0,00,F12A, C200,00,B12A
$A3:C225             dx 0001, C3F8,F8,310C
$A3:C22C             dx 0004, C200,FF,B122, C3F0,FF,F122, C200,F1,3122, C3F0,F1,3120
$A3:C242             dx 0001, C3F8,F8,312C
$A3:C249             dx 0004, C200,FF,B126, C3F0,FF,F126, C200,F1,3126, C3F0,F1,3124
$A3:C25F             dx 0001, C3F8,F8,314C
$A3:C266             dx 0004, C200,FF,B12A, C3F0,FF,F12A, C200,F1,312A, C3F0,F1,3128
$A3:C27C             dx 0001, C3F8,F8,310C
$A3:C283             dx 0004, C3FF,00,B122, C3F1,00,F122, C3FF,F0,3122, C3F1,F0,3120
$A3:C299             dx 0001, C3F8,F8,312C
$A3:C2A0             dx 0004, C3FF,00,B126, C3F1,00,F126, C3FF,F0,3126, C3F1,F0,3124
$A3:C2B6             dx 0001, C3F8,F8,314C
$A3:C2BD             dx 0004, C3FF,00,B12A, C3F1,00,F12A, C3FF,F0,312A, C3F1,F0,3128
$A3:C2D3             dx 0001, C3F8,F8,316A
$A3:C2DA             dx 0004, C3F0,00,F122, C200,00,B122, C200,F0,3122, C3F0,F0,3120
$A3:C2F0             dx 0001, C3F8,F8,3168
$A3:C2F7             dx 0004, C3F0,00,F122, C200,00,B122, C200,F0,3122, C3F0,F0,3120
$A3:C30D             dx 0001, C3F8,F8,316C
$A3:C314             dx 0004, C3F2,FE,F142, C3FE,FE,B142, C3FE,F2,3142, C3F2,F2,3140
$A3:C32A             dx 0001, C3F8,F8,316E
$A3:C331             dx 0004, C3F1,FF,F142, C3FF,FF,B142, C3FF,F1,3142, C3F1,F1,3140
$A3:C347             dx 0001, C3F8,F8,316C
$A3:C34E             dx 0004, C200,00,B142, C3F0,00,F142, C200,F0,3142, C3F0,F0,3140
$A3:C364             dx 0001, C3F8,F8,310E
$A3:C36B             dx 0004, C200,00,B142, C3F0,00,F142, C200,F0,3142, C3F0,F0,3140
$A3:C381             dx 0002, 0004,FC,3164, 01F6,F6,3161
$A3:C38D             dx 0002, 0004,FC,3165, 01F6,F6,3162
$A3:C399             dx 0002, 0004,FC,3166, 01F6,F6,3163
$A3:C3A5             dx 0002, 0002,F6,7161, 01F4,FD,3164
$A3:C3B1             dx 0002, 0002,F6,7162, 01F4,FD,3165
$A3:C3BD             dx 0002, 01F4,FD,3166, 0002,F6,7163
$A3:C3C9             dx 0002, 01FA,03,3176, 01FC,F5,3174
$A3:C3D5             dx 0002, 01FA,03,3175, 01FC,F5,3175
$A3:C3E1             dx 0002, 01FB,03,3174, 01FC,F5,3176
$A3:C3ED             dx 0002, 0002,02,3163, 01F6,02,7161
$A3:C3F9             dx 0002, 0002,02,3162, 01F6,02,7162
$A3:C405             dx 0002, 0002,02,3161, 01F6,02,7163
$A3:C411             dx 0001, C3F8,F8,310E
$A3:C418             dx 0004, C200,00,B142, C3F0,00,F142, C200,F0,3142, C3F0,F0,3140
$A3:C42E             dx 0001, C3F8,F8,312E
$A3:C435             dx 0004, C200,00,B146, C3F0,00,F146, C200,F0,3146, C3F0,F0,3144
$A3:C44B             dx 0001, C3F8,F8,314E
$A3:C452             dx 0004, C200,00,B14A, C3F0,00,F14A, C200,F0,314A, C3F0,F0,3148
$A3:C468             dx 0001, C3F8,F8,310E
$A3:C46F             dx 0004, C3F0,FF,F142, C200,FF,B142, C200,F1,3142, C3F0,F1,3140
$A3:C485             dx 0001, C3F8,F8,312E
$A3:C48C             dx 0004, C3F0,FF,F146, C200,FF,B146, C200,F1,3146, C3F0,F1,3144
$A3:C4A2             dx 0001, C3F8,F8,314E
$A3:C4A9             dx 0004, C3F0,FF,F14A, C200,FF,B14A, C200,F1,314A, C3F0,F1,3148
$A3:C4BF             dx 0001, C3F8,F8,310E
$A3:C4C6             dx 0004, C3FF,00,B142, C3F1,00,F142, C3FF,F0,3142, C3F1,F0,3140
$A3:C4DC             dx 0001, C3F8,F8,312E
$A3:C4E3             dx 0004, C3FF,00,B146, C3F1,00,F146, C3FF,F0,3146, C3F1,F0,3144
$A3:C4F9             dx 0001, C3F8,F8,314E
$A3:C500             dx 0004, C3FF,00,B14A, C3F1,00,F14A, C3FF,F0,314A, C3F1,F0,3148
$A3:C516             dx 0001, C3F8,F8,316E
$A3:C51D             dx 0004, C3F0,00,F142, C200,00,B142, C200,F0,3142, C3F0,F0,3140
$A3:C533             dx 0001, C3F8,F8,316C
$A3:C53A             dx 0004, C200,00,B142, C3F0,00,F142, C200,F0,3142, C3F0,F0,3140
$A3:C550             dx 0001, C3F8,F8,316E
$A3:C557             dx 0004, C3EF,EF,7142, C3EF,01,F142, C201,01,B142, C201,EF,3142
$A3:C56D             dx 0001, C3F8,F8,316C
$A3:C574             dx 0004, C3EE,EE,7146, C3EE,02,F146, C202,02,B146, C202,EE,3146
$A3:C58A             dx 0001, C3F8,F8,316E
$A3:C591             dx 0004, C3ED,ED,714A, C3ED,03,F14A, C203,03,B14A, C203,ED,314A
$A3:C5A7             dx 0001, C3F8,F8,316C
$A3:C5AE             dx 0002, 0006,FC,3164, 01F5,F5,3161
$A3:C5BA             dx 0002, 0006,FC,3165, 01F5,F5,3162
$A3:C5C6             dx 0002, 0006,FC,3166, 01F5,F5,3163
$A3:C5D2             dx 0002, 0003,F5,7161, 01F2,FD,3164
$A3:C5DE             dx 0002, 0003,F5,7162, 01F2,FD,3165
$A3:C5EA             dx 0002, 01F2,FD,3166, 0003,F5,7163
$A3:C5F6             dx 0002, 01FA,05,3176, 01FC,F3,3174
$A3:C602             dx 0002, 01FA,05,3175, 01FC,F3,3175
$A3:C60E             dx 0002, 01FB,05,3174, 01FC,F3,3176
$A3:C61A             dx 0002, 0003,03,3163, 01F5,03,7161
$A3:C626             dx 0002, 0003,03,3162, 01F5,03,7162
$A3:C632             dx 0002, 0003,03,3161, 01F5,03,7163
}
}


;;; $C63E..C8A5: Skree ;;;
{
;;; $C63E: Palette - enemy $DB7F (skree) ;;;
{
$A3:C63E             dw 3800, 3F57, 2E4D, 00E2, 0060, 3AB0, 220B, 1166, 0924, 7FFF, 039C, 0237, 00D1, 61BF, 38B6, 1448
}


;;; $C65E: Instruction list -  ;;;
{
$A3:C65E             dx 000A,C842,
                        000A,C878,
                        000A,C884,
                        000A,C89A,
                        80ED,C65E   ; Go to $C65E
}


;;; $C672: Instruction list -  ;;;
{
$A3:C672             dx 0010,C842,
                        0008,C862,
                        C6A4,       ; ???
                        812F        ; Sleep
}


;;; $C67E: Instruction list -  ;;;
{
$A3:C67E             dx 8173,       ; Enable off-screen processing
                        0002,C878,
                        0002,C884,
                        0002,C89A,
                        0002,C842,
                        80ED,C680   ; Go to $C680
}


;;; $C694: Instruction list -  ;;;
{
$A3:C694             dx 817D,       ; Disable off-screen processing
                        0001,C842,
                        812F        ; Sleep
}


;;; $C69C: Skree instruction list pointers ;;;
{
$A3:C69C             dw C65E, C672, C67E, C694
}


;;; $C6A4: Instruction ;;;
{
$A3:C6A4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C6A7 A9 01 00    LDA #$0001
$A3:C6AA 9D B0 0F    STA $0FB0,x[$7E:1030]
$A3:C6AD 6B          RTL
}


;;; $C6AE: Initialisation AI - enemy $DB7F (skree) ;;;
{
$A3:C6AE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C6B1 9E AC 0F    STZ $0FAC,x[$7E:102C]
$A3:C6B4 9E AE 0F    STZ $0FAE,x[$7E:102E]
$A3:C6B7 9E B0 0F    STZ $0FB0,x[$7E:1030]
$A3:C6BA A9 5E C6    LDA #$C65E
$A3:C6BD 9D 92 0F    STA $0F92,x[$7E:1012]
$A3:C6C0 A9 D5 C6    LDA #$C6D5
$A3:C6C3 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:C6C6 6B          RTL
}


;;; $C6C7: Main AI - enemy $DB7F (skree) ;;;
{
$A3:C6C7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C6CA 7C AA 0F    JMP ($0FAA,x)[$A3:C6D5]
}


;;; $C6CD:  ;;;
{
$A3:C6CD             dw C6D5, C6F7, C716, C77F
}


;;; $C6D5:  ;;;
{
$A3:C6D5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C6D8 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:C6DB 38          SEC
$A3:C6DC ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A3:C6DF 10 04       BPL $04    [$C6E5]
$A3:C6E1 49 FF FF    EOR #$FFFF
$A3:C6E4 1A          INC A

$A3:C6E5 C9 30 00    CMP #$0030
$A3:C6E8 B0 0C       BCS $0C    [$C6F6]
$A3:C6EA FE AC 0F    INC $0FAC,x[$7E:102C]
$A3:C6ED 20 D5 C7    JSR $C7D5  [$A3:C7D5]
$A3:C6F0 A9 F7 C6    LDA #$C6F7
$A3:C6F3 9D AA 0F    STA $0FAA,x[$7E:102A]

$A3:C6F6 6B          RTL
}


;;; $C6F7:  ;;;
{
$A3:C6F7 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A3:C6FA F0 19       BEQ $19    [$C715]
$A3:C6FC 9E B0 0F    STZ $0FB0,x[$7E:1030]
$A3:C6FF AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C702 FE AC 0F    INC $0FAC,x[$7E:102C]
$A3:C705 20 D5 C7    JSR $C7D5  [$A3:C7D5]
$A3:C708 A9 16 C7    LDA #$C716
$A3:C70B 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:C70E A9 5B 00    LDA #$005B             ;\
$A3:C711 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Bh, sound library 2, max queued sounds allowed = 6 (skree launches attack)

$A3:C715 6B          RTL
}


;;; $C716:  ;;;
{
$A3:C716 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C719 A9 15 00    LDA #$0015
$A3:C71C 9D A8 0F    STA $0FA8,x[$7E:1028]
$A3:C71F A9 06 00    LDA #$0006
$A3:C722 85 14       STA $14    [$7E:0014]
$A3:C724 64 12       STZ $12    [$7E:0012]
$A3:C726 BD 86 0F    LDA $0F86,x[$7E:1006]
$A3:C729 09 03 00    ORA #$0003
$A3:C72C 9D 86 0F    STA $0F86,x[$7E:1006]
$A3:C72F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C732 22 8A BF A0 JSL $A0BF8A[$A0:BF8A]
$A3:C736 B0 2D       BCS $2D    [$C765]
$A3:C738 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C73B BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A3:C73E 18          CLC
$A3:C73F 69 06 00    ADC #$0006
$A3:C742 9D 7E 0F    STA $0F7E,x[$7E:0FFE]
$A3:C745 A9 01 00    LDA #$0001
$A3:C748 8D 24 0E    STA $0E24  [$7E:0E24]
$A3:C74B BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:C74E CD F6 0A    CMP $0AF6  [$7E:0AF6]
$A3:C751 30 06       BMI $06    [$C759]
$A3:C753 A9 FF FF    LDA #$FFFF
$A3:C756 8D 24 0E    STA $0E24  [$7E:0E24]

$A3:C759 BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:C75C 18          CLC
$A3:C75D 6D 24 0E    ADC $0E24  [$7E:0E24]
$A3:C760 9D 7A 0F    STA $0F7A,x[$7E:0FFA]
$A3:C763 80 19       BRA $19    [$C77E]

$A3:C765 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C768 A9 01 00    LDA #$0001
$A3:C76B 9D 94 0F    STA $0F94,x[$7E:1014]
$A3:C76E 9E 90 0F    STZ $0F90,x[$7E:1010]
$A3:C771 A9 7F C7    LDA #$C77F
$A3:C774 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:C777 A9 5C 00    LDA #$005C             ;\
$A3:C77A 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Ch, sound library 2, max queued sounds allowed = 6 (skree hits the ground)

$A3:C77E 6B          RTL
}


;;; $C77F:  ;;;
{
$A3:C77F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C782 DE A8 0F    DEC $0FA8,x[$7E:1028]
$A3:C785 F0 2E       BEQ $2E    [$C7B5]
$A3:C787 BD A8 0F    LDA $0FA8,x[$7E:1028]
$A3:C78A C9 08 00    CMP #$0008
$A3:C78D D0 1F       BNE $1F    [$C7AE]
$A3:C78F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C792 A0 C2 8B    LDY #$8BC2             ;\
$A3:C795 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - down-right enemy projectile
$A3:C799 A0 D0 8B    LDY #$8BD0             ;\
$A3:C79C 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - up-right enemy projectile
$A3:C7A0 A0 DE 8B    LDY #$8BDE             ;\
$A3:C7A3 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - down-left enemy projectile
$A3:C7A7 A0 EC 8B    LDY #$8BEC             ;\
$A3:C7AA 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - up-left enemy projectile

$A3:C7AE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C7B1 FE 7E 0F    INC $0F7E,x[$7E:0FFE]
$A3:C7B4 6B          RTL

$A3:C7B5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C7B8 BD 96 0F    LDA $0F96,x[$7E:1016]
$A3:C7BB 1D 98 0F    ORA $0F98,x[$7E:1018]
$A3:C7BE 9F 06 70 7E STA $7E7006,x[$7E:7086]
$A3:C7C2 A9 00 0A    LDA #$0A00
$A3:C7C5 9D 96 0F    STA $0F96,x[$7E:1016]
$A3:C7C8 9E 98 0F    STZ $0F98,x[$7E:1018]
$A3:C7CB BD 86 0F    LDA $0F86,x[$7E:1006]
$A3:C7CE 09 00 02    ORA #$0200
$A3:C7D1 9D 86 0F    STA $0F86,x[$7E:1006]
$A3:C7D4 6B          RTL
}


;;; $C7D5:  ;;;
{
$A3:C7D5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C7D8 BD AC 0F    LDA $0FAC,x[$7E:102C]
$A3:C7DB DD AE 0F    CMP $0FAE,x[$7E:102E]
$A3:C7DE F0 14       BEQ $14    [$C7F4]
$A3:C7E0 9D AE 0F    STA $0FAE,x[$7E:102E]
$A3:C7E3 0A          ASL A
$A3:C7E4 A8          TAY
$A3:C7E5 B9 9C C6    LDA $C69C,y[$A3:C69E]
$A3:C7E8 9D 92 0F    STA $0F92,x[$7E:1012]
$A3:C7EB A9 01 00    LDA #$0001
$A3:C7EE 9D 94 0F    STA $0F94,x[$7E:1014]
$A3:C7F1 9E 90 0F    STZ $0F90,x[$7E:1010]

$A3:C7F4 60          RTS
}


;;; $C7F5: Enemy shot - enemy $DB7F (skree) ;;;
{
$A3:C7F5 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C7F8 22 32 80 A3 JSL $A38032[$A3:8032]
$A3:C7FC AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C7FF BD 8C 0F    LDA $0F8C,x[$7E:108C]
$A3:C802 D0 3D       BNE $3D    [$C841]
$A3:C804 BD A8 0F    LDA $0FA8,x[$7E:10A8]
$A3:C807 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:C80A A0 C2 8B    LDY #$8BC2             ;\
$A3:C80D 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - down-right enemy projectile
$A3:C811 A0 D0 8B    LDY #$8BD0             ;\
$A3:C814 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - up-right enemy projectile
$A3:C818 A0 DE 8B    LDY #$8BDE             ;\
$A3:C81B 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - down-left enemy projectile
$A3:C81F A0 EC 8B    LDY #$8BEC             ;\
$A3:C822 22 27 80 86 JSL $868027[$86:8027]  ;} Spawn skree particle - up-left enemy projectile
$A3:C826 A0 02 00    LDY #$0002
$A3:C829 AD A6 18    LDA $18A6  [$7E:18A6]
$A3:C82C 0A          ASL A
$A3:C82D AA          TAX
$A3:C82E BD 18 0C    LDA $0C18,x[$7E:0C18]
$A3:C831 29 00 0F    AND #$0F00
$A3:C834 C9 00 02    CMP #$0200
$A3:C837 F0 03       BEQ $03    [$C83C]
$A3:C839 A0 00 00    LDY #$0000

$A3:C83C 98          TYA
$A3:C83D 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]

$A3:C841 6B          RTL
}


;;; $C842: Skree spritemaps ;;;
{
$A3:C842             dx 0006, 0000,0C,6112, 0000,04,6102, 01F8,0C,2112, 01F8,04,2102, 8000,F4,6100, 81F0,F4,2100
$A3:C862             dx 0004, 0004,04,6105, 01F4,04,2105, 8000,F4,6103, 81F0,F4,2103
$A3:C878             dx 0002, 81F8,04,2108, 81F8,F4,2106
$A3:C884             dx 0004, 01FC,0C,211B, 01FC,04,210B, 01FC,FC,211A, 01FC,F4,210A
$A3:C89A             dx 0002, 81F8,04,210E, 81F8,F4,210C
}
}


;;; $C8A6..DA9B: Maridia snail ;;;
{
;;; $C8A6: Palette - enemy $DBBF (Maridia snail) ;;;
{
$A3:C8A6             dw 3800, 57FF, 42F7, 158C, 00A5, 4F5A, 36B5, 2610, 1DCE, 77FF, 62B5, 314A, 1063, 4D1F, 38B6, 246E
}


;;; $C8C6..CC35: Instruction lists - Maridia snail ;;;
{
;;; $C8C6: Instruction list -  ;;;
{
$A3:C8C6             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D6A8,
                        0004,D6B4,
                        0007,D6C0,
                        CC5F,FFFC,FFF8, ; Move (FFFCh, FFF8h) pixels
                        CC36,CFA6,      ; Enemy $0FB2 = $CFA6
                        CC3F,CB36,      ; Enemy $0FAE = $CB36
                        CC48,0006,      ; ???
                        0009,D5AC,
                        000D,D5B8,
                        0009,D5C4,
                        80ED,C8E0       ; Go to $C8E0
}


;;; $C8FC: Instruction list -  ;;;
{
$A3:C8FC             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D5D0,
                        0004,D5DC,
                        0007,D5E8,
                        CC5F,FFF8,0004, ; Move (FFF8h, 0004h) pixels
                        CC36,CFB7,      ; Enemy $0FB2 = $CFB7
                        CC3F,CBD2,      ; Enemy $0FAE = $CBD2
                        CC48,0003,      ; ???
                        0009,D5F4,
                        000D,D600,
                        0009,D60C,
                        80ED,C916       ; Go to $C916
}


;;; $C932: Instruction list -  ;;;
{
$A3:C932             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D618,
                        0004,D624,
                        0007,D630,
                        CC5F,0004,0008, ; Move (0004h, 0008h) pixels
                        CC36,CFBD,      ; Enemy $0FB2 = $CFBD
                        CC3F,CB6A,      ; Enemy $0FAE = $CB6A
                        CC48,0005,      ; ???
                        0009,D63C,
                        000D,D648,
                        0009,D654,
                        80ED,C94C       ; Go to $C94C
}


;;; $C968: Instruction list -  ;;;
{
$A3:C968             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D660,
                        0004,D66C,
                        0007,D678,
                        CC5F,0008,FFFC, ; Move (0008h, FFFCh) pixels
                        CC36,CFCE,      ; Enemy $0FB2 = $CFCE
                        CC3F,CB9E,      ; Enemy $0FAE = $CB9E
                        CC48,0000,      ; ???
                        0009,D684,
                        000D,D690,
                        0009,D69C,
                        80ED,C982       ; Go to $C982
}


;;; $C99E: Instruction list -  ;;;
{
$A3:C99E             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D814,
                        0004,D820,
                        0007,D82C,
                        CC5F,0004,FFF8, ; Move (0004h, FFF8h) pixels
                        CC36,CFD4,      ; Enemy $0FB2 = $CFD4
                        CC3F,CB84,      ; Enemy $0FAE = $CB84
                        CC48,0007,      ; ???
                        0009,D718,
                        000D,D724,
                        0009,D730,
                        80ED,C9B8       ; Go to $C9B8
}


;;; $C9D4: Instruction list -  ;;;
{
$A3:C9D4             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D73C,
                        0004,D748,
                        0007,D754,
                        CC5F,0008,0004, ; Move (0008h, 0004h) pixels
                        CC36,CFE5,      ; Enemy $0FB2 = $CFE5
                        CC3F,CBEC,      ; Enemy $0FAE = $CBEC
                        CC48,0001,      ; ???
                        0009,D760,
                        000D,D76C,
                        0009,D778,
                        80ED,C9EE       ; Go to $C9EE
}


;;; $CA0A: Instruction list -  ;;;
{
$A3:CA0A             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D784,
                        0004,D790,
                        0007,D79C,
                        CC5F,FFFC,0008, ; Move (FFFCh, 0008h) pixels
                        CC36,CFEB,      ; Enemy $0FB2 = $CFEB
                        CC3F,CB50,      ; Enemy $0FAE = $CB50
                        CC48,0004,      ; ???
                        0009,D7A8,
                        000D,D7B4,
                        0009,D7C0,
                        80ED,CA24       ; Go to $CA24
}


;;; $CA40: Instruction list -  ;;;
{
$A3:CA40             dx CC36,CF5F,      ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,      ; Enemy $0FAE = $CF5F
                        0007,D7CC,
                        0004,D7D8,
                        0007,D7E4,
                        CC5F,FFF8,FFFC, ; Move (FFF8h, FFFCh) pixels
                        CC36,CFFC,      ; Enemy $0FB2 = $CFFC
                        CC3F,CBB8,      ; Enemy $0FAE = $CBB8
                        CC48,0002,      ; ???
                        0009,D7F0,
                        000D,D7FC,
                        0009,D808,
                        80ED,CA5A       ; Go to $CA5A
}


;;; $CA76: Instruction list -  ;;;
{
$A3:CA76             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D890,
                        0004,D89C,
                        0007,D8A8,
                        80ED,C982   ; Go to $C982
}


;;; $CA8E: Instruction list -  ;;;
{
$A3:CA8E             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D8C0,
                        0004,D8CC,
                        0007,D8D8,
                        80ED,C94C   ; Go to $C94C
}


;;; $CAA6: Instruction list -  ;;;
{
$A3:CAA6             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D8F0,
                        0004,D8FC,
                        0007,D908,
                        80ED,C916   ; Go to $C916
}


;;; $CABE: Instruction list -  ;;;
{
$A3:CABE             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D920,
                        0004,D92C,
                        0007,D938,
                        80ED,C8E0   ; Go to $C8E0
}


;;; $CAD6: Instruction list -  ;;;
{
$A3:CAD6             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D99C,
                        0004,D9A8,
                        0007,D9B4,
                        80ED,CA5A   ; Go to $CA5A
}


;;; $CAEE: Instruction list -  ;;;
{
$A3:CAEE             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D9CC,
                        0004,D9D8,
                        0007,D9E4,
                        80ED,CA24   ; Go to $CA24
}


;;; $CB06: Instruction list -  ;;;
{
$A3:CB06             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,D9FC,
                        0004,DA08,
                        0007,DA14,
                        80ED,C9EE   ; Go to $C9EE
}


;;; $CB1E: Instruction list -  ;;;
{
$A3:CB1E             dx CC36,CF5F,  ; Enemy $0FB2 = $CF5F
                        CC3F,CF5F,  ; Enemy $0FAE = $CF5F
                        0007,DA2C,
                        0004,DA38,
                        0007,DA44,
                        80ED,C9B8   ; Go to $C9B8
}


;;; $CB36: Instruction list -  ;;;
{
$A3:CB36             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D6CC,
                        0001,D6D8,
                        CC78,       ; ???
                        0030,D944,
                        0010,D94B,
                        80ED,C8E0   ; Go to $C8E0
}


;;; $CB50: Instruction list -  ;;;
{
$A3:CB50             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D85E,
                        0001,D86A,
                        CC78,       ; ???
                        0030,DA76,
                        0010,DA7D,
                        80ED,CA24   ; Go to $CA24
}


;;; $CB6A: Instruction list -  ;;;
{
$A3:CB6A             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D6F2,
                        0001,D6FE,
                        CC78,       ; ???
                        0030,D96A,
                        0010,D971,
                        80ED,C94C   ; Go to $C94C
}


;;; $CB84: Instruction list -  ;;;
{
$A3:CB84             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D838,
                        0001,D844,
                        CC78,       ; ???
                        0030,DA50,
                        0010,DA57,
                        80ED,C9B8   ; Go to $C9B8
}


;;; $CB9E: Instruction list -  ;;;
{
$A3:CB9E             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D705,
                        0001,D711,
                        CC78,       ; ???
                        0030,D957,
                        0010,D95E,
                        80ED,C982   ; Go to $C982
}


;;; $CBB8: Instruction list -  ;;;
{
$A3:CBB8             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D871,
                        0001,D87D,
                        CC78,       ; ???
                        0030,DA63,
                        0010,DA6A,
                        80ED,CA5A   ; Go to $CA5A
}


;;; $CBD2: Instruction list -  ;;;
{
$A3:CBD2             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D6DF,
                        0001,D6EB,
                        CC78,       ; ???
                        0030,D97D,
                        0010,D984,
                        80ED,C916   ; Go to $C916
}


;;; $CBEC: Instruction list -  ;;;
{
$A3:CBEC             dx CC36,CF60,  ; Enemy $0FB2 = $CF60
                        0005,D84B,
                        0001,D857,
                        CC78,       ; ???
                        0030,DA89,
                        0010,DA90,
                        80ED,C9EE   ; Go to $C9EE
}


;;; $CC06: Instruction list -  ;;;
{
$A3:CC06             dx CC36,D1B3,  ; Enemy $0FB2 = $D1B3
                        0003,D711,
                        0003,D6EB,
                        0003,D6FE,
                        0003,D711,
                        80ED,CC0E   ; Go to $CC0E
}


;;; $CC1E: Instruction list -  ;;;
{
$A3:CC1E             dx CC36,D1B3,  ; Enemy $0FB2 = $D1B3
                        0003,D87D,
                        0003,D857,
                        0003,D86A,
                        0003,D87D,
                        80ED,CC26   ; Go to $CC26
}
}


;;; $CC36: Instruction - enemy $0FB2 = [[Y]] ;;;
{
$A3:CC36 B9 00 00    LDA $0000,y[$A3:CB38]
$A3:CC39 9D B2 0F    STA $0FB2,x[$7E:1032]
$A3:CC3C C8          INY
$A3:CC3D C8          INY
$A3:CC3E 6B          RTL
}


;;; $CC3F: Instruction - enemy $0FAE = [[Y]] ;;;
{
$A3:CC3F B9 00 00    LDA $0000,y[$A3:C8E6]
$A3:CC42 9D AE 0F    STA $0FAE,x[$7E:116E]
$A3:CC45 C8          INY
$A3:CC46 C8          INY
$A3:CC47 6B          RTL
}


;;; $CC48: Instruction ;;;
{
$A3:CC48 5A          PHY
$A3:CC49 B9 00 00    LDA $0000,y[$A3:C8EA]
$A3:CC4C 9F 0E 78 7E STA $7E780E,x[$7E:79CE]
$A3:CC50 0A          ASL A
$A3:CC51 0A          ASL A
$A3:CC52 0A          ASL A
$A3:CC53 A8          TAY
$A3:CC54 B9 48 CD    LDA $CD48,y[$A3:CD78]
$A3:CC57 9F AC 0F 00 STA $000FAC,x[$7E:116C]
$A3:CC5B 7A          PLY
$A3:CC5C C8          INY
$A3:CC5D C8          INY
$A3:CC5E 6B          RTL
}


;;; $CC5F: Instruction - move ([[Y]], [[Y] + 2]) pixels ;;;
{
$A3:CC5F B9 00 00    LDA $0000,y[$A3:C8DC]
$A3:CC62 18          CLC
$A3:CC63 7D 7A 0F    ADC $0F7A,x[$7E:113A]
$A3:CC66 9D 7A 0F    STA $0F7A,x[$7E:113A]
$A3:CC69 B9 02 00    LDA $0002,y[$A3:C8DE]
$A3:CC6C 18          CLC
$A3:CC6D 7D 7E 0F    ADC $0F7E,x[$7E:113E]
$A3:CC70 9D 7E 0F    STA $0F7E,x[$7E:113E]
$A3:CC73 C8          INY
$A3:CC74 C8          INY
$A3:CC75 C8          INY
$A3:CC76 C8          INY
$A3:CC77 6B          RTL
}


;;; $CC78:  ;;;
{
$A3:CC78 BF 10 78 7E LDA $7E7810,x[$7E:7890]
$A3:CC7C C9 02 00    CMP #$0002
$A3:CC7F F0 0A       BEQ $0A    [$CC8B]
$A3:CC81 22 11 81 80 JSL $808111[$80:8111]
$A3:CC85 89 01 00    BIT #$0001
$A3:CC88 D0 01       BNE $01    [$CC8B]
$A3:CC8A 6B          RTL

$A3:CC8B 98          TYA
$A3:CC8C 38          SEC
$A3:CC8D E9 06 00    SBC #$0006
$A3:CC90 A8          TAY
$A3:CC91 6B          RTL
}


;;; $CC92:  ;;;
{
; Wild NOP appears!
$A3:CC92 EA          NOP
$A3:CC93 5A          PHY
$A3:CC94 22 15 D3 A3 JSL $A3D315[$A3:D315]
$A3:CC98 90 06       BCC $06    [$CCA0]
$A3:CC9A 7A          PLY
$A3:CC9B BD 92 0F    LDA $0F92,x
$A3:CC9E A8          TAY
$A3:CC9F 6B          RTL

$A3:CCA0 7A          PLY
$A3:CCA1 6B          RTL
}


;;; $CCA2:  ;;;
{
$A3:CCA2             dw 0040, 0080, 00C0, 0100, 0140, 0180, 01C0, 0200, 0240, 0280, 02C0, 0300, 0340, 0380, 0400, 0440,
                        0540, 0580, 05C0, 0600, 0640, 0680, 06C0, 0700, 0740, 0780, 07C0, 0800, 0840, 0880, 0800, 0000
}


;;; $CCE2:  ;;;
{
$A3:CCE2             dw FFF9,0000,C8FC,CA76
$A3:CCEA             dw 0000,0007,C932,CABE
$A3:CCF2             dw 0007,0000,C968,CAA6
$A3:CCFA             dw 0000,FFF9,C8C6,CA8E
$A3:CD02             dw 0007,0000,C9D4,CAD6
$A3:CD0A             dw 0000,0007,CA0A,CB1E
$A3:CD12             dw FFF9,0000,CA40,CB06
$A3:CD1A             dw 0000,FFF9,C99E,CAEE
$A3:CD22             dw 0000,0000,C916,C982
$A3:CD2A             dw 0000,0000,C982,C916
$A3:CD32             dw 0000,0000,C9EE,CA5A
$A3:CD3A             dw 0000,0000,CA5A,C9EE
}


;;; $CD42:  ;;;
{
$A3:CD42             dw C982,0002,CB9E,0000
$A3:CD4A             dw C9EE,0003,CBEC,0001
$A3:CD52             dw CA5A,0002,CBB8,0001
$A3:CD5A             dw C916,0003,CBD2,0000
$A3:CD62             dw CA24,0000,CB50,0001
$A3:CD6A             dw C94C,0001,CB6A,0000
$A3:CD72             dw C8E0,0000,CB36,0000
$A3:CD7A             dw C9B8,0001,CB84,0001
}


;;; $CD82:  ;;;
{
$A3:CD82             dw FFFF,0001,FFFF,0001
$A3:CD8A             dw FFFF,0001,0000,0000
$A3:CD92             dw 0000,0000,FFFF,0001
$A3:CD9A             dw 0000,0000,0000,0000

$A3:CDA2             dw FFFF,0001,FFFF,0001
$A3:CDAA             dw 0000,0000,FFFF,0001
$A3:CDB2             dw FFFF,0001,0000,0000
$A3:CDBA             dw 0000,0000,0000,0000
}


;;; $CDC2:  ;;;
{
$A3:CDC2             dw 0001,0000,0003,0002,0005,0004,0007,0006
}


;;; $CDD2:  ;;;
{
$A3:CDD2             dw CFEB,CFE5,CFFC,CFB7,CFCE,CFBD,CFA6,CFD4
}


;;; $CDE2: Initialisation AI - enemy $DBBF (Maridia snail) ;;;
{
$A3:CDE2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:CDE5 A9 5F CF    LDA #$CF5F
$A3:CDE8 9D B2 0F    STA $0FB2,x[$7E:1032]
$A3:CDEB A9 4D 80    LDA #$804D
$A3:CDEE 9D 8E 0F    STA $0F8E,x[$7E:100E]
$A3:CDF1 A9 01 00    LDA #$0001
$A3:CDF4 9D 94 0F    STA $0F94,x[$7E:1014]
$A3:CDF7 BD 92 0F    LDA $0F92,x[$7E:1012]
$A3:CDFA 0A          ASL A
$A3:CDFB 0A          ASL A
$A3:CDFC 0A          ASL A
$A3:CDFD A8          TAY
$A3:CDFE B9 42 CD    LDA $CD42,y[$A3:CD72]
$A3:CE01 9D 92 0F    STA $0F92,x[$7E:1012]
$A3:CE04 B9 44 CD    LDA $CD44,y[$A3:CD74]
$A3:CE07 1D 86 0F    ORA $0F86,x[$7E:1006]
$A3:CE0A 9D 86 0F    STA $0F86,x[$7E:1006]
$A3:CE0D B9 46 CD    LDA $CD46,y[$A3:CD76]
$A3:CE10 9D AE 0F    STA $0FAE,x[$7E:102E]
$A3:CE13 B9 48 CD    LDA $CD48,y[$A3:CD78]
$A3:CE16 9D AC 0F    STA $0FAC,x[$7E:102C]
$A3:CE19 A9 00 00    LDA #$0000
$A3:CE1C 9F 10 78 7E STA $7E7810,x[$7E:7890]
$A3:CE20 BD B4 0F    LDA $0FB4,x[$7E:1034]
$A3:CE23 9F 0C 78 7E STA $7E780C,x[$7E:788C]
}


;;; $CE27:  ;;;
{
$A3:CE27 B9 82 CD    LDA $CD82,y[$A3:CDB2]
$A3:CE2A 85 12       STA $12    [$7E:0012]
$A3:CE2C B9 84 CD    LDA $CD84,y[$A3:CDB4]
$A3:CE2F 85 14       STA $14    [$7E:0014]
$A3:CE31 B9 86 CD    LDA $CD86,y[$A3:CDB6]
$A3:CE34 85 16       STA $16    [$7E:0016]
$A3:CE36 B9 88 CD    LDA $CD88,y[$A3:CDB8]
$A3:CE39 85 18       STA $18    [$7E:0018]
$A3:CE3B BD B4 0F    LDA $0FB4,x[$7E:1034]
$A3:CE3E 0A          ASL A
$A3:CE3F A8          TAY
$A3:CE40 B9 A2 CC    LDA $CCA2,y[$A3:CCA6]
$A3:CE43 45 12       EOR $12    [$7E:0012]
$A3:CE45 18          CLC
$A3:CE46 65 14       ADC $14    [$7E:0014]
$A3:CE48 9D A8 0F    STA $0FA8,x[$7E:1028]
$A3:CE4B B9 A2 CC    LDA $CCA2,y[$A3:CCA6]
$A3:CE4E 45 16       EOR $16    [$7E:0016]
$A3:CE50 18          CLC
$A3:CE51 65 18       ADC $18    [$7E:0018]
$A3:CE53 9D AA 0F    STA $0FAA,x[$7E:102A]
$A3:CE56 6B          RTL
}


;;; $CE57:  ;;;
{
$A3:CE57 BF 0E 78 7E LDA $7E780E,x[$7E:784E]
$A3:CE5B 0A          ASL A
$A3:CE5C A8          TAY
$A3:CE5D B9 D2 CD    LDA $CDD2,y[$A3:CDE0]
$A3:CE60 9D B2 0F    STA $0FB2,x[$7E:0FF2]
$A3:CE63 6B          RTL
}


;;; $CE64: Main AI - enemy $DBBF (Maridia snail) ;;;
{
$A3:CE64 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:CE67 20 73 CE    JSR $CE73  [$A3:CE73]
$A3:CE6A 20 9A CE    JSR $CE9A  [$A3:CE9A]
$A3:CE6D 20 11 CF    JSR $CF11  [$A3:CF11]
$A3:CE70 7C B2 0F    JMP ($0FB2,x)[$A3:CF5F]
}


;;; $CE73:  ;;;
{
$A3:CE73 BF 10 78 7E LDA $7E7810,x[$7E:7890]
$A3:CE77 C9 03 00    CMP #$0003
$A3:CE7A F0 1D       BEQ $1D    [$CE99]
$A3:CE7C C9 04 00    CMP #$0004
$A3:CE7F F0 18       BEQ $18    [$CE99]
$A3:CE81 C9 05 00    CMP #$0005
$A3:CE84 F0 13       BEQ $13    [$CE99]
$A3:CE86 AD 40 18    LDA $1840  [$7E:1840]
$A3:CE89 C9 1E 00    CMP #$001E
$A3:CE8C D0 0B       BNE $0B    [$CE99]
$A3:CE8E AD 3E 18    LDA $183E  [$7E:183E]
$A3:CE91 C9 14 00    CMP #$0014
$A3:CE94 D0 03       BNE $03    [$CE99]
$A3:CE96 20 64 D1    JSR $D164  [$A3:D164]

$A3:CE99 60          RTS
}


;;; $CE9A:  ;;;
{
$A3:CE9A BF 10 78 7E LDA $7E7810,x[$7E:7890]
$A3:CE9E C9 01 00    CMP #$0001
$A3:CEA1 F0 6D       BEQ $6D    [$CF10]
$A3:CEA3 C9 03 00    CMP #$0003
$A3:CEA6 F0 68       BEQ $68    [$CF10]
$A3:CEA8 C9 04 00    CMP #$0004
$A3:CEAB F0 63       BEQ $63    [$CF10]
$A3:CEAD C9 05 00    CMP #$0005
$A3:CEB0 F0 5E       BEQ $5E    [$CF10]
$A3:CEB2 BD 7E 0F    LDA $0F7E,x[$7E:0FFE]
$A3:CEB5 38          SEC
$A3:CEB6 ED FA 0A    SBC $0AFA  [$7E:0AFA]
$A3:CEB9 C9 A0 FF    CMP #$FFA0
$A3:CEBC 30 4B       BMI $4B    [$CF09]
$A3:CEBE BD 7A 0F    LDA $0F7A,x[$7E:0FFA]
$A3:CEC1 CD F6 0A    CMP $0AF6  [$7E:0AF6]
$A3:CEC4 30 0D       BMI $0D    [$CED3]
$A3:CEC6 AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A3:CEC9 29 FF 00    AND #$00FF
$A3:CECC C9 08 00    CMP #$0008
$A3:CECF D0 38       BNE $38    [$CF09]
$A3:CED1 80 0B       BRA $0B    [$CEDE]

$A3:CED3 AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A3:CED6 29 FF 00    AND #$00FF
$A3:CED9 C9 04 00    CMP #$0004
$A3:CEDC D0 2B       BNE $2B    [$CF09]

$A3:CEDE BF 10 78 7E LDA $7E7810,x[$7E:7890]
$A3:CEE2 C9 02 00    CMP #$0002
$A3:CEE5 F0 21       BEQ $21    [$CF08]
$A3:CEE7 BD AE 0F    LDA $0FAE,x[$7E:102E]
$A3:CEEA C9 5F CF    CMP #$CF5F
$A3:CEED F0 1A       BEQ $1A    [$CF09]
$A3:CEEF 9D 92 0F    STA $0F92,x[$7E:1012]
$A3:CEF2 A9 4D 80    LDA #$804D
$A3:CEF5 9D 8E 0F    STA $0F8E,x[$7E:100E]
$A3:CEF8 A9 01 00    LDA #$0001
$A3:CEFB 9D 94 0F    STA $0F94,x[$7E:1014]
$A3:CEFE 9E 90 0F    STZ $0F90,x[$7E:1010]
$A3:CF01 A9 02 00    LDA #$0002
$A3:CF04 9F 10 78 7E STA $7E7810,x[$7E:7890]

$A3:CF08 60          RTS

$A3:CF09 A9 00 00    LDA #$0000
$A3:CF0C 9F 10 78 7E STA $7E7810,x[$7E:7890]

$A3:CF10 60          RTS
}


;;; $CF11:  ;;;
{
$A3:CF11 BD B2 0F    LDA $0FB2,x[$7E:1032]
$A3:CF14 C9 B3 D1    CMP #$D1B3
$A3:CF17 F0 3C       BEQ $3C    [$CF55]
$A3:CF19 BF 10 78 7E LDA $7E7810,x[$7E:7890]
$A3:CF1D C9 01 00    CMP #$0001
$A3:CF20 F0 1A       BEQ $1A    [$CF3C]
$A3:CF22 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$A3:CF25 D0 2E       BNE $2E    [$CF55]     ;} If [Samus running momentum flag] != 0: go to BRANCH_NOT_SOLID
$A3:CF27 BF 10 78 7E LDA $7E7810,x[$7E:7890]
$A3:CF2B C9 02 00    CMP #$0002
$A3:CF2E F0 1B       BEQ $1B    [$CF4B]
$A3:CF30 C9 03 00    CMP #$0003
$A3:CF33 F0 20       BEQ $20    [$CF55]
$A3:CF35 C9 05 00    CMP #$0005
$A3:CF38 D0 11       BNE $11    [$CF4B]
$A3:CF3A 80 19       BRA $19    [$CF55]

$A3:CF3C AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$A3:CF3F D0 14       BNE $14    [$CF55]     ;} If [Samus running momentum flag] != 0: go to BRANCH_NOT_SOLID
$A3:CF41 BD B2 0F    LDA $0FB2,x[$7E:1172]
$A3:CF44 C9 5F CF    CMP #$CF5F
$A3:CF47 F0 02       BEQ $02    [$CF4B]
$A3:CF49 80 0A       BRA $0A    [$CF55]

$A3:CF4B BD 86 0F    LDA $0F86,x[$7E:1006]
$A3:CF4E 09 00 80    ORA #$8000
$A3:CF51 9D 86 0F    STA $0F86,x[$7E:1006]
$A3:CF54 60          RTS

; BRANCH_NOT_SOLID
$A3:CF55 BD 86 0F    LDA $0F86,x[$7E:1146]
$A3:CF58 29 FF 7F    AND #$7FFF
$A3:CF5B 9D 86 0F    STA $0F86,x[$7E:1146]
$A3:CF5E 60          RTS
}


;;; $CF5F: RTL ;;;
{
$A3:CF5F 6B          RTL
}


;;; $CF60:  ;;;
{
$A3:CF60 BF 0E 78 7E LDA $7E780E,x[$7E:788E]
$A3:CF64 C9 04 00    CMP #$0004
$A3:CF67 B0 11       BCS $11    [$CF7A]
$A3:CF69 64 12       STZ $12    [$7E:0012]
$A3:CF6B 64 14       STZ $14    [$7E:0014]
$A3:CF6D BD A8 0F    LDA $0FA8,x[$7E:1028]
$A3:CF70 20 8F CF    JSR $CF8F  [$A3:CF8F]
$A3:CF73 22 BF BB A0 JSL $A0BBBF[$A0:BBBF]
$A3:CF77 90 12       BCC $12    [$CF8B]
$A3:CF79 6B          RTL

$A3:CF7A 64 12       STZ $12    [$7E:0012]
$A3:CF7C 64 14       STZ $14    [$7E:0014]
$A3:CF7E BD AA 0F    LDA $0FAA,x[$7E:10AA]
$A3:CF81 20 8F CF    JSR $CF8F  [$A3:CF8F]
$A3:CF84 22 76 BC A0 JSL $A0BC76[$A0:BC76]
$A3:CF88 90 01       BCC $01    [$CF8B]
$A3:CF8A 6B          RTL

$A3:CF8B 20 64 D1    JSR $D164  [$A3:D164]
$A3:CF8E 6B          RTL
}


;;; $CF8F:  ;;;
{
$A3:CF8F 10 02       BPL $02    [$CF93]
$A3:CF91 C6 14       DEC $14    [$7E:0014]

$A3:CF93 85 13       STA $13    [$7E:0013]
$A3:CF95 A5 14       LDA $14    [$7E:0014]
$A3:CF97 10 06       BPL $06    [$CF9F]
$A3:CF99 38          SEC
$A3:CF9A E9 07 00    SBC #$0007
$A3:CF9D 80 04       BRA $04    [$CFA3]

$A3:CF9F 18          CLC
$A3:CFA0 69 07 00    ADC #$0007

$A3:CFA3 85 14       STA $14    [$7E:0014]
$A3:CFA5 60          RTS
}


;;; $CFA6:  ;;;
{
$A3:CFA6 BF 0A 78 7E LDA $7E780A,x[$7E:79CA]
$A3:CFAA D0 05       BNE $05    [$CFB1]
$A3:CFAC A0 E2 CC    LDY #$CCE2
$A3:CFAF 80 03       BRA $03    [$CFB4]

$A3:CFB1 A0 22 CD    LDY #$CD22

$A3:CFB4 4C 7E D0    JMP $D07E  [$A3:D07E]
}


;;; $CFB7:  ;;;
{
$A3:CFB7 A0 EA CC    LDY #$CCEA
$A3:CFBA 4C 02 D0    JMP $D002  [$A3:D002]
}


;;; $CFBD:  ;;;
{
$A3:CFBD BF 0A 78 7E LDA $7E780A,x[$7E:78CA]
$A3:CFC1 D0 05       BNE $05    [$CFC8]
$A3:CFC3 A0 F2 CC    LDY #$CCF2
$A3:CFC6 80 03       BRA $03    [$CFCB]

$A3:CFC8 A0 2A CD    LDY #$CD2A

$A3:CFCB 4C 7E D0    JMP $D07E  [$A3:D07E]
}


;;; $CFCE:  ;;;
{
$A3:CFCE A0 FA CC    LDY #$CCFA
$A3:CFD1 4C 02 D0    JMP $D002  [$A3:D002]
}


;;; $CFD4:  ;;;
{
$A3:CFD4 BF 0A 78 7E LDA $7E780A,x[$7E:780A]
$A3:CFD8 D0 05       BNE $05    [$CFDF]
$A3:CFDA A0 02 CD    LDY #$CD02
$A3:CFDD 80 03       BRA $03    [$CFE2]

$A3:CFDF A0 32 CD    LDY #$CD32

$A3:CFE2 4C 7E D0    JMP $D07E  [$A3:D07E]
}


;;; $CFE5:  ;;;
{
$A3:CFE5 A0 0A CD    LDY #$CD0A
$A3:CFE8 4C 02 D0    JMP $D002  [$A3:D002]
}


;;; $CFEB:  ;;;
{
$A3:CFEB BF 0A 78 7E LDA $7E780A,x[$7E:7A0A]
$A3:CFEF D0 05       BNE $05    [$CFF6]
$A3:CFF1 A0 12 CD    LDY #$CD12
$A3:CFF4 80 03       BRA $03    [$CFF9]

$A3:CFF6 A0 3A CD    LDY #$CD3A

$A3:CFF9 4C 7E D0    JMP $D07E  [$A3:D07E]
}


;;; $CFFC:  ;;;
{
$A3:CFFC A0 1A CD    LDY #$CD1A
$A3:CFFF 4C 02 D0    JMP $D002  [$A3:D002]
}


;;; $D002:  ;;;
{
$A3:D002 20 F8 D0    JSR $D0F8  [$A3:D0F8]
$A3:D005 64 12       STZ $12    [$7E:0012]  ;\
$A3:D007 64 14       STZ $14    [$7E:0014]  ;|
$A3:D009 BD A8 0F    LDA $0FA8,x[$7E:1168]  ;|
$A3:D00C 10 02       BPL $02    [$D010]     ;} $14.$12 = [enemy X velocity] / 100h
$A3:D00E C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:D010 85 13       STA $13    [$7E:0013]  ;/
$A3:D012 A5 14       LDA $14    [$7E:0014]  ;\
$A3:D014 10 03       BPL $03    [$D019]     ;} If [$14] < 0:
$A3:D016 3A          DEC A                  ; $14 -= 1
$A3:D017 80 01       BRA $01    [$D01A]
                                            ; Else ([$14] >= 0):
$A3:D019 1A          INC A                  ; $14 += 1

$A3:D01A 85 14       STA $14    [$7E:0014]
$A3:D01C 5A          PHY
$A3:D01D 22 A4 C6 A0 JSL $A0C6A4[$A0:C6A4]  ; Move enemy right by [$14].[$12], process slopes
$A3:D021 7A          PLY
$A3:D022 20 0D D1    JSR $D10D  [$A3:D10D]
$A3:D025 90 36       BCC $36    [$D05D]     ; If not collided with wall: go to BRANCH_NO_COLLISION
$A3:D027 A9 00 00    LDA #$0000
$A3:D02A 9D B0 0F    STA $0FB0,x[$7E:1170]
$A3:D02D 5A          PHY
$A3:D02E 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]
$A3:D032 7A          PLY
$A3:D033 20 24 D1    JSR $D124  [$A3:D124]
$A3:D036 64 12       STZ $12    [$7E:0012]  ;\
$A3:D038 64 14       STZ $14    [$7E:0014]  ;|
$A3:D03A BD AA 0F    LDA $0FAA,x[$7E:116A]  ;|
$A3:D03D 10 02       BPL $02    [$D041]     ;} $14.$12 = [enemy Y velocity] / 100h
$A3:D03F C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:D041 85 13       STA $13    [$7E:0013]  ;/
$A3:D043 5A          PHY
$A3:D044 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:D048 7A          PLY
$A3:D049 B0 01       BCS $01    [$D04C]     ; If not collided with block:
$A3:D04B 6B          RTL                    ; Return

$A3:D04C BD A8 0F    LDA $0FA8,x[$7E:11A8]
$A3:D04F 49 FF FF    EOR #$FFFF
$A3:D052 1A          INC A
$A3:D053 9D A8 0F    STA $0FA8,x[$7E:11A8]
$A3:D056 B9 06 00    LDA $0006,y[$A3:CD20]
$A3:D059 20 4C D1    JSR $D14C  [$A3:D14C]
$A3:D05C 6B          RTL

; BRANCH_NO_COLLISION
$A3:D05D BD B0 0F    LDA $0FB0,x[$7E:1170]
$A3:D060 1A          INC A
$A3:D061 9D B0 0F    STA $0FB0,x[$7E:1170]
$A3:D064 C9 04 00    CMP #$0004
$A3:D067 30 04       BMI $04    [$D06D]
$A3:D069 20 64 D1    JSR $D164  [$A3:D164]
$A3:D06C 6B          RTL

$A3:D06D BD AA 0F    LDA $0FAA,x[$7E:116A]
$A3:D070 49 FF FF    EOR #$FFFF
$A3:D073 1A          INC A
$A3:D074 9D AA 0F    STA $0FAA,x[$7E:116A]
$A3:D077 B9 04 00    LDA $0004,y[$A3:CCFE]
$A3:D07A 20 4C D1    JSR $D14C  [$A3:D14C]
$A3:D07D 6B          RTL
}


;;; $D07E:  ;;;
{
$A3:D07E 20 F8 D0    JSR $D0F8  [$A3:D0F8]
$A3:D081 64 12       STZ $12    [$7E:0012]  ;\
$A3:D083 64 14       STZ $14    [$7E:0014]  ;|
$A3:D085 BD AA 0F    LDA $0FAA,x[$7E:116A]  ;|
$A3:D088 10 02       BPL $02    [$D08C]     ;} $14.$12 = [enemy Y velocity] / 100h
$A3:D08A C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:D08C 85 13       STA $13    [$7E:0013]  ;/
$A3:D08E A5 14       LDA $14    [$7E:0014]  ;\
$A3:D090 10 03       BPL $03    [$D095]     ;} If [$14] < 0:
$A3:D092 3A          DEC A                  ; $14 -= 1
$A3:D093 80 01       BRA $01    [$D096]
                                            ; Else ([$14] >= 0):
$A3:D095 1A          INC A                  ; $14 += 1

$A3:D096 85 14       STA $14    [$7E:0014]
$A3:D098 5A          PHY
$A3:D099 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:D09D 7A          PLY
$A3:D09E 20 0D D1    JSR $D10D  [$A3:D10D]
$A3:D0A1 90 34       BCC $34    [$D0D7]     ; If not collided with block: go to BRANCH_NO_COLLISION
$A3:D0A3 A9 00 00    LDA #$0000
$A3:D0A6 9D B0 0F    STA $0FB0,x[$7E:1170]
$A3:D0A9 64 12       STZ $12    [$7E:0012]  ;\
$A3:D0AB 64 14       STZ $14    [$7E:0014]  ;|
$A3:D0AD BD A8 0F    LDA $0FA8,x[$7E:1168]  ;|
$A3:D0B0 10 02       BPL $02    [$D0B4]     ;} $14.$12 = [enemy X velocity] / 100h
$A3:D0B2 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:D0B4 85 13       STA $13    [$7E:0013]  ;/
$A3:D0B6 5A          PHY
$A3:D0B7 22 A4 C6 A0 JSL $A0C6A4[$A0:C6A4]  ; Move enemy right by [$14].[$12], process slopes
$A3:D0BB 7A          PLY
$A3:D0BC B0 08       BCS $08    [$D0C6]     ; If not collided with wall:
$A3:D0BE 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]
$A3:D0C2 20 24 D1    JSR $D124  [$A3:D124]
$A3:D0C5 6B          RTL

$A3:D0C6 BD AA 0F    LDA $0FAA,x[$7E:116A]
$A3:D0C9 49 FF FF    EOR #$FFFF
$A3:D0CC 1A          INC A
$A3:D0CD 9D AA 0F    STA $0FAA,x[$7E:116A]
$A3:D0D0 B9 06 00    LDA $0006,y[$A3:CCE8]
$A3:D0D3 20 4C D1    JSR $D14C  [$A3:D14C]
$A3:D0D6 6B          RTL

$A3:D0D7 BD B0 0F    LDA $0FB0,x[$7E:1030]
$A3:D0DA 1A          INC A
$A3:D0DB 9D B0 0F    STA $0FB0,x[$7E:1030]
$A3:D0DE C9 04 00    CMP #$0004
$A3:D0E1 30 04       BMI $04    [$D0E7]
$A3:D0E3 20 64 D1    JSR $D164  [$A3:D164]
$A3:D0E6 6B          RTL

$A3:D0E7 BD A8 0F    LDA $0FA8,x[$7E:1028]
$A3:D0EA 49 FF FF    EOR #$FFFF
$A3:D0ED 1A          INC A
$A3:D0EE 9D A8 0F    STA $0FA8,x[$7E:1028]
$A3:D0F1 B9 04 00    LDA $0004,y[$A3:CD3E]
$A3:D0F4 20 4C D1    JSR $D14C  [$A3:D14C]
$A3:D0F7 6B          RTL
}


;;; $D0F8:  ;;;
{
$A3:D0F8 BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A3:D0FB 18          CLC
$A3:D0FC 79 00 00    ADC $0000,y[$A3:CD22]
$A3:D0FF 9D 7A 0F    STA $0F7A,x[$7E:113A]
$A3:D102 BD 7E 0F    LDA $0F7E,x[$7E:113E]
$A3:D105 18          CLC
$A3:D106 79 02 00    ADC $0002,y[$A3:CD24]
$A3:D109 9D 7E 0F    STA $0F7E,x[$7E:113E]
$A3:D10C 60          RTS
}


;;; $D10D:  ;;;
{
; Important that the carry flag is preserved here
$A3:D10D 08          PHP
$A3:D10E BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A3:D111 38          SEC
$A3:D112 F9 00 00    SBC $0000,y[$A3:CD22]
$A3:D115 9D 7A 0F    STA $0F7A,x[$7E:113A]
$A3:D118 BD 7E 0F    LDA $0F7E,x[$7E:113E]
$A3:D11B 38          SEC
$A3:D11C F9 02 00    SBC $0002,y[$A3:CD24]
$A3:D11F 9D 7E 0F    STA $0F7E,x[$7E:113E]
$A3:D122 28          PLP
$A3:D123 60          RTS
}


;;; $D124:  ;;;
{
$A3:D124 B0 0F       BCS $0F    [$D135]
$A3:D126 BF 08 78 7E LDA $7E7808,x[$7E:79C8]
$A3:D12A 1A          INC A
$A3:D12B C9 10 00    CMP #$0010
$A3:D12E B0 14       BCS $14    [$D144]
$A3:D130 9F 08 78 7E STA $7E7808,x[$7E:79C8]
$A3:D134 60          RTS

$A3:D135 A9 01 00    LDA #$0001
$A3:D138 9F 0A 78 7E STA $7E780A,x
$A3:D13C A9 00 00    LDA #$0000
$A3:D13F 9F 08 78 7E STA $7E7808,x
$A3:D143 60          RTS

$A3:D144 A9 00 00    LDA #$0000
$A3:D147 9F 0A 78 7E STA $7E780A,x[$7E:79CA]
$A3:D14B 60          RTS
}


;;; $D14C:  ;;;
{
$A3:D14C 9D 92 0F    STA $0F92,x[$7E:1152]
$A3:D14F A9 01 00    LDA #$0001
$A3:D152 9D 94 0F    STA $0F94,x[$7E:1154]
$A3:D155 A9 01 00    LDA #$0001
$A3:D158 9F 0A 78 7E STA $7E780A,x[$7E:79CA]
$A3:D15C A9 00 00    LDA #$0000
$A3:D15F 9F 08 78 7E STA $7E7808,x[$7E:79C8]
$A3:D163 60          RTS
}


;;; $D164:  ;;;
{
$A3:D164 5A          PHY
$A3:D165 BF 10 78 7E LDA $7E7810,x[$7E:79D0]
$A3:D169 C9 03 00    CMP #$0003
$A3:D16C F0 3B       BEQ $3B    [$D1A9]
$A3:D16E A9 03 00    LDA #$0003
$A3:D171 9F 10 78 7E STA $7E7810,x[$7E:79D0]
$A3:D175 A9 B3 D1    LDA #$D1B3
$A3:D178 9D B2 0F    STA $0FB2,x[$7E:1172]
$A3:D17B BD AC 0F    LDA $0FAC,x[$7E:116C]
$A3:D17E 0A          ASL A
$A3:D17F 0A          ASL A
$A3:D180 A8          TAY
$A3:D181 B9 AB D1    LDA $D1AB,y[$A3:D1AB]
$A3:D184 9D 92 0F    STA $0F92,x[$7E:1152]
$A3:D187 B9 AD D1    LDA $D1AD,y[$A3:D1AD]
$A3:D18A 9D AE 0F    STA $0FAE,x[$7E:116E]
$A3:D18D A9 01 00    LDA #$0001
$A3:D190 9D 94 0F    STA $0F94,x[$7E:1154]
$A3:D193 9E 90 0F    STZ $0F90,x[$7E:1150]
$A3:D196 A9 00 00    LDA #$0000
$A3:D199 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A3:D19D 9F 06 78 7E STA $7E7806,x[$7E:79C6]
$A3:D1A1 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A3:D1A5 9F 02 78 7E STA $7E7802,x[$7E:79C2]

$A3:D1A9 7A          PLY
$A3:D1AA 60          RTS

$A3:D1AB             dw CC06,CB44, CC1E,CB92
}


;;; $D1B3:  ;;;
{
; Note the two fixed point negation operations at $D20A and $D26D are off by 1.0 when the low word is zero
$A3:D1B3 BF 10 78 7E LDA $7E7810,x[$7E:79D0]
$A3:D1B7 C9 03 00    CMP #$0003
$A3:D1BA F0 77       BEQ $77    [$D233]
$A3:D1BC BF 04 78 7E LDA $7E7804,x[$7E:79C4];\
$A3:D1C0 85 12       STA $12    [$7E:0012]  ;|
$A3:D1C2 BF 06 78 7E LDA $7E7806,x[$7E:79C6];} Move enemy right by [enemy X velocity]
$A3:D1C6 85 14       STA $14    [$7E:0014]  ;|
$A3:D1C8 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:D1CC B0 3C       BCS $3C    [$D20A]     ; If collided with wall: go to BRANCH_HIT_WALL
$A3:D1CE BF 06 78 7E LDA $7E7806,x[$7E:79C6]
$A3:D1D2 30 13       BMI $13    [$D1E7]
$A3:D1D4 A9 00 10    LDA #$1000
$A3:D1D7 49 FF FF    EOR #$FFFF
$A3:D1DA 1A          INC A
$A3:D1DB 85 16       STA $16    [$7E:0016]
$A3:D1DD A9 00 00    LDA #$0000
$A3:D1E0 49 FF FF    EOR #$FFFF
$A3:D1E3 85 18       STA $18    [$7E:0018]
$A3:D1E5 80 0A       BRA $0A    [$D1F1]

$A3:D1E7 A9 00 10    LDA #$1000
$A3:D1EA 85 16       STA $16    [$7E:0016]
$A3:D1EC A9 00 00    LDA #$0000
$A3:D1EF 85 18       STA $18    [$7E:0018]

$A3:D1F1 18          CLC
$A3:D1F2 BF 04 78 7E LDA $7E7804,x[$7E:79C4]
$A3:D1F6 65 16       ADC $16    [$7E:0016]
$A3:D1F8 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A3:D1FC BF 06 78 7E LDA $7E7806,x[$7E:79C6]
$A3:D200 65 18       ADC $18    [$7E:0018]
$A3:D202 F0 04       BEQ $04    [$D208]
$A3:D204 9F 06 78 7E STA $7E7806,x[$7E:79C6]

$A3:D208 80 29       BRA $29    [$D233]

; BRANCH_HIT_WALL
$A3:D20A BF 04 78 7E LDA $7E7804,x[$7E:7844];\
$A3:D20E 49 FF FF    EOR #$FFFF             ;|
$A3:D211 1A          INC A                  ;} Negate enemy X subvelocity
$A3:D212 9F 04 78 7E STA $7E7804,x[$7E:7844];/
$A3:D216 BF 06 78 7E LDA $7E7806,x[$7E:7846];\
$A3:D21A 49 FF FF    EOR #$FFFF             ;|
$A3:D21D 1A          INC A                  ;} Negate enemy X velocity
$A3:D21E 9F 06 78 7E STA $7E7806,x[$7E:7846];/
$A3:D222 A9 01 00    LDA #$0001
$A3:D225 9F 00 80 7E STA $7E8000,x[$7E:8040]
$A3:D229 A9 70 00    LDA #$0070             ;\
$A3:D22C 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 70h, sound library 2, max queued sounds allowed = 3 (Maridia snail bounce)
$A3:D230 4C 33 D2    JMP $D233  [$A3:D233]

$A3:D233 BF 00 78 7E LDA $7E7800,x[$7E:79C0];\
$A3:D237 85 12       STA $12    [$7E:0012]  ;|
$A3:D239 BF 02 78 7E LDA $7E7802,x[$7E:79C2];} Move enemy down by [enemy Y velocity]
$A3:D23D 85 14       STA $14    [$7E:0014]  ;|
$A3:D23F 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:D243 B0 1D       BCS $1D    [$D262]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A3:D245 18          CLC
$A3:D246 BF 00 78 7E LDA $7E7800,x[$7E:79C0]
$A3:D24A 69 00 20    ADC #$2000
$A3:D24D 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A3:D251 BF 02 78 7E LDA $7E7802,x[$7E:79C2]
$A3:D255 69 00 00    ADC #$0000
$A3:D258 C9 04 00    CMP #$0004
$A3:D25B 10 04       BPL $04    [$D261]
$A3:D25D 9F 02 78 7E STA $7E7802,x[$7E:79C2]

$A3:D261 6B          RTL

; BRANCH_COLLIDED_VERTICALLY
$A3:D262 BF 02 78 7E LDA $7E7802,x[$7E:79C2]
$A3:D266 30 05       BMI $05    [$D26D]
$A3:D268 C9 03 00    CMP #$0003
$A3:D26B 30 20       BMI $20    [$D28D]

$A3:D26D BF 00 78 7E LDA $7E7800,x[$7E:79C0];\
$A3:D271 49 FF FF    EOR #$FFFF             ;|
$A3:D274 1A          INC A                  ;} Negate enemy Y subvelocity
$A3:D275 9F 00 78 7E STA $7E7800,x[$7E:79C0];/
$A3:D279 BF 02 78 7E LDA $7E7802,x[$7E:79C2];\
$A3:D27D 49 FF FF    EOR #$FFFF             ;|
$A3:D280 1A          INC A                  ;} Negate enemy Y velocity
$A3:D281 9F 02 78 7E STA $7E7802,x[$7E:79C2];/
$A3:D285 A9 00 00    LDA #$0000
$A3:D288 9F 00 80 7E STA $7E8000,x[$7E:81C0]
$A3:D28C 6B          RTL

$A3:D28D A9 00 00    LDA #$0000
$A3:D290 9F 06 78 7E STA $7E7806,x[$7E:79C6]
$A3:D294 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A3:D298 9F 02 78 7E STA $7E7802,x[$7E:79C2]
$A3:D29C 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A3:D2A0 9D B0 0F    STA $0FB0,x[$7E:1170]
$A3:D2A3 9F 08 78 7E STA $7E7808,x[$7E:79C8]
$A3:D2A7 A9 01 00    LDA #$0001
$A3:D2AA 9F 0A 78 7E STA $7E780A,x[$7E:79CA]
$A3:D2AE BF 10 78 7E LDA $7E7810,x[$7E:79D0]
$A3:D2B2 C9 03 00    CMP #$0003
$A3:D2B5 F0 16       BEQ $16    [$D2CD]
$A3:D2B7 A9 01 00    LDA #$0001
$A3:D2BA 9F 10 78 7E STA $7E7810,x[$7E:79D0]
$A3:D2BE A9 08 00    LDA #$0008
$A3:D2C1 9D B4 0F    STA $0FB4,x[$7E:1174]
$A3:D2C4 22 3E D3 A3 JSL $A3D33E[$A3:D33E]
$A3:D2C8 20 FA D2    JSR $D2FA  [$A3:D2FA]
$A3:D2CB 80 07       BRA $07    [$D2D4]

$A3:D2CD A9 00 00    LDA #$0000
$A3:D2D0 9F 10 78 7E STA $7E7810,x[$7E:79D0]

$A3:D2D4 BD 86 0F    LDA $0F86,x[$7E:1146]
$A3:D2D7 29 FC FF    AND #$FFFC
$A3:D2DA 1D AC 0F    ORA $0FAC,x[$7E:116C]
$A3:D2DD 9D 86 0F    STA $0F86,x[$7E:1146]
$A3:D2E0 22 7A E6 A3 JSL $A3E67A[$A3:E67A]  ; Execute creepy crawly common initialisation AI
$A3:D2E4 A9 5F CF    LDA #$CF5F
$A3:D2E7 9D B2 0F    STA $0FB2,x[$7E:1172]
$A3:D2EA BD AE 0F    LDA $0FAE,x[$7E:116E]
$A3:D2ED 9D 92 0F    STA $0F92,x[$7E:1152]
$A3:D2F0 A9 01 00    LDA #$0001
$A3:D2F3 9D 94 0F    STA $0F94,x[$7E:1154]
$A3:D2F6 9E 90 0F    STZ $0F90,x[$7E:1150]
$A3:D2F9 6B          RTL
}


;;; $D2FA:  ;;;
{
$A3:D2FA BD AC 0F    LDA $0FAC,x[$7E:116C]
$A3:D2FD 0A          ASL A
$A3:D2FE 0A          ASL A
$A3:D2FF A8          TAY
$A3:D300 B9 0D D3    LDA $D30D,y[$A3:D30D]
$A3:D303 9D 92 0F    STA $0F92,x[$7E:1152]
$A3:D306 B9 0F D3    LDA $D30F,y[$A3:D30F]
$A3:D309 9D AE 0F    STA $0FAE,x[$7E:116E]
$A3:D30C 60          RTS

$A3:D30D             dw CC06,CB44, CC1E,CB92
}


;;; $D315:  ;;;
{
$A3:D315 BF 0A 78 7E LDA $7E780A,x
$A3:D319 F0 02       BEQ $02    [$D31D]
$A3:D31B 18          CLC
$A3:D31C 6B          RTL

$A3:D31D BF 0E 78 7E LDA $7E780E,x
$A3:D321 C9 04 00    CMP #$0004
$A3:D324 B0 18       BCS $18    [$D33E]
$A3:D326 89 01 00    BIT #$0001
$A3:D329 D0 0A       BNE $0A    [$D335]
$A3:D32B BD 7E 0F    LDA $0F7E,x
$A3:D32E CD FA 0A    CMP $0AFA  [$7E:0AFA]
$A3:D331 90 23       BCC $23    [$D356]
$A3:D333 18          CLC
$A3:D334 6B          RTL

$A3:D335 BD 7E 0F    LDA $0F7E,x
$A3:D338 CD FA 0A    CMP $0AFA  [$7E:0AFA]
$A3:D33B B0 19       BCS $19    [$D356]
$A3:D33D 6B          RTL
}


;;; $D33E:  ;;;
{
$A3:D33E BD AC 0F    LDA $0FAC,x[$7E:116C]
$A3:D341 D0 0A       BNE $0A    [$D34D]
$A3:D343 BD 7A 0F    LDA $0F7A,x[$7E:113A]
$A3:D346 CD F6 0A    CMP $0AF6  [$7E:0AF6]
$A3:D349 90 0B       BCC $0B    [$D356]
$A3:D34B 18          CLC
$A3:D34C 6B          RTL

$A3:D34D BD 7A 0F    LDA $0F7A,x[$7E:107A]
$A3:D350 CD F6 0A    CMP $0AF6  [$7E:0AF6]
$A3:D353 B0 01       BCS $01    [$D356]
$A3:D355 6B          RTL
}


;;; $D356:  ;;;
{
$A3:D356 BF 10 78 7E LDA $7E7810,x[$7E:7850]
$A3:D35A C9 02 00    CMP #$0002
$A3:D35D F0 4F       BEQ $4F    [$D3AE]
$A3:D35F BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:D362 C9 5F CF    CMP #$CF5F
$A3:D365 F0 47       BEQ $47    [$D3AE]
$A3:D367 BF 0E 78 7E LDA $7E780E,x[$7E:784E]
$A3:D36B 0A          ASL A
$A3:D36C A8          TAY
$A3:D36D B9 C2 CD    LDA $CDC2,y[$A3:CDCE]
$A3:D370 9F 0E 78 7E STA $7E780E,x[$7E:784E]
$A3:D374 0A          ASL A
$A3:D375 0A          ASL A
$A3:D376 0A          ASL A
$A3:D377 A8          TAY
$A3:D378 B9 42 CD    LDA $CD42,y[$A3:CD7A]
$A3:D37B 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:D37E BD 86 0F    LDA $0F86,x[$7E:0FC6]
$A3:D381 29 FC FF    AND #$FFFC
$A3:D384 19 44 CD    ORA $CD44,y[$A3:CD7C]
$A3:D387 9D 86 0F    STA $0F86,x[$7E:0FC6]
$A3:D38A B9 46 CD    LDA $CD46,y[$A3:CD7E]
$A3:D38D 9D AE 0F    STA $0FAE,x[$7E:0FEE]
$A3:D390 B9 48 CD    LDA $CD48,y[$A3:CD80]
$A3:D393 9D AC 0F    STA $0FAC,x[$7E:0FEC]
$A3:D396 22 27 CE A3 JSL $A3CE27[$A3:CE27]
$A3:D39A 22 57 CE A3 JSL $A3CE57[$A3:CE57]
$A3:D39E A9 01 00    LDA #$0001
$A3:D3A1 9F 0A 78 7E STA $7E780A,x[$7E:784A]
$A3:D3A5 A9 00 00    LDA #$0000
$A3:D3A8 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A3:D3AC 38          SEC
$A3:D3AD 6B          RTL

$A3:D3AE 18          CLC
$A3:D3AF 6B          RTL
}


;;; $D3B0: Enemy touch - enemy $DBBF (Maridia snail) ;;;
{
$A3:D3B0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:D3B3 BF 10 78 7E LDA $7E7810,x[$7E:79D0]
$A3:D3B7 C9 01 00    CMP #$0001
$A3:D3BA D0 0F       BNE $0F    [$D3CB]
$A3:D3BC BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:D3BF C9 5F CF    CMP #$CF5F
$A3:D3C2 F0 07       BEQ $07    [$D3CB]
$A3:D3C4 20 21 D4    JSR $D421  [$A3:D421]
$A3:D3C7 90 02       BCC $02    [$D3CB]
$A3:D3C9 80 20       BRA $20    [$D3EB]

$A3:D3CB BD B2 0F    LDA $0FB2,x[$7E:1172]
$A3:D3CE C9 B3 D1    CMP #$D1B3
$A3:D3D1 F0 05       BEQ $05    [$D3D8]
$A3:D3D3 AD 3C 0B    LDA $0B3C  [$7E:0B3C]  ;\
$A3:D3D6 F0 13       BEQ $13    [$D3EB]     ;} If [Samus running momentum flag] = 0: go to BRANCH_D3EB

$A3:D3D8 20 9F D4    JSR $D49F  [$A3:D49F]
$A3:D3DB BD B2 0F    LDA $0FB2,x[$7E:1172]
$A3:D3DE C9 B3 D1    CMP #$D1B3
$A3:D3E1 D0 07       BNE $07    [$D3EA]
$A3:D3E3 A9 70 00    LDA #$0070             ;\
$A3:D3E6 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 70h, sound library 2, max queued sounds allowed = 3 (Maridia snail bounce)

$A3:D3EA 6B          RTL

; BRANCH_D3EB
$A3:D3EB BD B2 0F    LDA $0FB2,x[$7E:0FB2]
$A3:D3EE C9 5F CF    CMP #$CF5F
$A3:D3F1 F0 2D       BEQ $2D    [$D420]
$A3:D3F3 BF 10 78 7E LDA $7E7810,x
$A3:D3F7 C9 04 00    CMP #$0004
$A3:D3FA F0 24       BEQ $24    [$D420]
$A3:D3FC C9 03 00    CMP #$0003
$A3:D3FF F0 1F       BEQ $1F    [$D420]
$A3:D401 22 23 80 A3 JSL $A38023[$A3:8023]
$A3:D405 BF 0C 78 7E LDA $7E780C,x
$A3:D409 9D B4 0F    STA $0FB4,x
$A3:D40C BF 10 78 7E LDA $7E7810,x
$A3:D410 C9 00 00    CMP #$0000
$A3:D413 F0 04       BEQ $04    [$D419]
$A3:D415 22 56 D3 A3 JSL $A3D356[$A3:D356]

$A3:D419 A9 00 00    LDA #$0000
$A3:D41C 9F 10 78 7E STA $7E7810,x

$A3:D420 6B          RTL
}


;;; $D421:  ;;;
{
$A3:D421 A5 8B       LDA $8B    [$7E:008B]
$A3:D423 29 00 03    AND #$0300
$A3:D426 EB          XBA
$A3:D427 3A          DEC A
$A3:D428 85 12       STA $12    [$7E:0012]
$A3:D42A BD AC 0F    LDA $0FAC,x
$A3:D42D 29 01 00    AND #$0001
$A3:D430 85 14       STA $14    [$7E:0014]
$A3:D432 A5 12       LDA $12    [$7E:0012]
$A3:D434 D0 06       BNE $06    [$D43C]
$A3:D436 A5 14       LDA $14    [$7E:0014]
$A3:D438 F0 0A       BEQ $0A    [$D444]
$A3:D43A 80 06       BRA $06    [$D442]

$A3:D43C A5 14       LDA $14    [$7E:0014]
$A3:D43E F0 02       BEQ $02    [$D442]
$A3:D440 80 02       BRA $02    [$D444]

$A3:D442 18          CLC
$A3:D443 60          RTS

$A3:D444 38          SEC
$A3:D445 60          RTS
}


;;; $D446:  ;;;
{
$A3:D446 BD A8 0F    LDA $0FA8,x
$A3:D449 10 0D       BPL $0D    [$D458]
$A3:D44B AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A3:D44E 29 FF 00    AND #$00FF
$A3:D451 C9 08 00    CMP #$0008
$A3:D454 D0 0F       BNE $0F    [$D465]
$A3:D456 80 0F       BRA $0F    [$D467]

$A3:D458 AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A3:D45B 29 FF 00    AND #$00FF
$A3:D45E C9 04 00    CMP #$0004
$A3:D461 D0 02       BNE $02    [$D465]
$A3:D463 80 02       BRA $02    [$D467]

$A3:D465 18          CLC
$A3:D466 60          RTS

$A3:D467 38          SEC
$A3:D468 60          RTS
}


;;; $D469: Enemy shot - enemy $DBBF (Maridia snail) ;;;
{
$A3:D469 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:D46C AD A6 18    LDA $18A6  [$7E:18A6]
$A3:D46F 0A          ASL A
$A3:D470 A8          TAY
$A3:D471 B9 18 0C    LDA $0C18,y[$7E:0C18]
$A3:D474 29 00 FF    AND #$FF00
$A3:D477 C9 00 03    CMP #$0300
$A3:D47A F0 05       BEQ $05    [$D481]
$A3:D47C C9 00 05    CMP #$0500
$A3:D47F D0 05       BNE $05    [$D486]

$A3:D481 22 2D 80 A3 JSL $A3802D[$A3:802D]
$A3:D485 6B          RTL

$A3:D486 BF 10 78 7E LDA $7E7810,x[$7E:79D0]
$A3:D48A C9 03 00    CMP #$0003
$A3:D48D F0 08       BEQ $08    [$D497]
$A3:D48F C9 04 00    CMP #$0004
$A3:D492 F0 03       BEQ $03    [$D497]
$A3:D494 20 57 D5    JSR $D557  [$A3:D557]

$A3:D497 A9 70 00    LDA #$0070             ;\
$A3:D49A 22 B7 90 80 JSL $8090B7[$80:90B7]  ;} Queue sound 70h, sound library 2, max queued sounds allowed = 3 (Maridia snail bounce)
$A3:D49E 6B          RTL
}


;;; $D49F:  ;;;
{
; Note the fixed point negation operation at $D4F6 is off by 1.0 when the low word is zero
$A3:D49F A9 04 00    LDA #$0004
$A3:D4A2 9F 10 78 7E STA $7E7810,x[$7E:79D0]
$A3:D4A6 A9 B3 D1    LDA #$D1B3
$A3:D4A9 9D B2 0F    STA $0FB2,x[$7E:1172]
$A3:D4AC BD AC 0F    LDA $0FAC,x[$7E:116C]
$A3:D4AF 0A          ASL A
$A3:D4B0 0A          ASL A
$A3:D4B1 A8          TAY
$A3:D4B2 B9 0F D5    LDA $D50F,y[$A3:D50F]
$A3:D4B5 9D 92 0F    STA $0F92,x[$7E:1152]
$A3:D4B8 B9 11 D5    LDA $D511,y[$A3:D511]
$A3:D4BB 9D AE 0F    STA $0FAE,x[$7E:116E]
$A3:D4BE A9 01 00    LDA #$0001
$A3:D4C1 9D 94 0F    STA $0F94,x[$7E:1154]
$A3:D4C4 9E 90 0F    STZ $0F90,x[$7E:1150]
$A3:D4C7 AD A4 0D    LDA $0DA4  [$7E:0DA4]
$A3:D4CA 9F 04 78 7E STA $7E7804,x[$7E:79C4]
$A3:D4CE AD A2 0D    LDA $0DA2  [$7E:0DA2]
$A3:D4D1 9F 06 78 7E STA $7E7806,x[$7E:79C6]
$A3:D4D5 C9 10 00    CMP #$0010
$A3:D4D8 90 03       BCC $03    [$D4DD]
$A3:D4DA A9 0F 00    LDA #$000F

$A3:D4DD 0A          ASL A
$A3:D4DE 0A          ASL A
$A3:D4DF A8          TAY
$A3:D4E0 B9 17 D5    LDA $D517,y[$A3:D523]
$A3:D4E3 9F 00 78 7E STA $7E7800,x[$7E:79C0]
$A3:D4E7 B9 19 D5    LDA $D519,y[$A3:D525]
$A3:D4EA 9F 02 78 7E STA $7E7802,x[$7E:79C2]
$A3:D4EE AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A3:D4F1 89 04 00    BIT #$0004
$A3:D4F4 F0 18       BEQ $18    [$D50E]
$A3:D4F6 BF 04 78 7E LDA $7E7804,x[$7E:79C4];\
$A3:D4FA 49 FF FF    EOR #$FFFF             ;|
$A3:D4FD 1A          INC A                  ;} Negate enemy X subvelocity
$A3:D4FE 9F 04 78 7E STA $7E7804,x[$7E:79C4];/
$A3:D502 BF 06 78 7E LDA $7E7806,x[$7E:79C6];\
$A3:D506 49 FF FF    EOR #$FFFF             ;|
$A3:D509 1A          INC A                  ;} Negate enemy X velocity
$A3:D50A 9F 06 78 7E STA $7E7806,x[$7E:79C6];/

$A3:D50E 60          RTS

$A3:D50F             dw CC06,CB44, CC1E,CB92
$A3:D517             dw 0000,FFFD, A000,FFFD, 4000,FFFD, 0000,FFFC, A000,FFFC, 4000,FFFC, 0000,FFFB, A000,FFFB,
                        4000,FFFB, 0000,FFFA, A000,FFFA, 4000,FFFA, 0000,FFF9, A000,FFF9, 4000,FFF9, 0000,FFF8
}


;;; $D557:  ;;;
{
$A3:D557 5A          PHY
$A3:D558 A9 05 00    LDA #$0005
$A3:D55B 9F 10 78 7E STA $7E7810,x[$7E:79D0]
$A3:D55F A9 B3 D1    LDA #$D1B3
$A3:D562 9D B2 0F    STA $0FB2,x[$7E:1172]
$A3:D565 BD AC 0F    LDA $0FAC,x[$7E:116C]
$A3:D568 0A          ASL A
$A3:D569 0A          ASL A
$A3:D56A A8          TAY
$A3:D56B B9 A4 D5    LDA $D5A4,y[$A3:D5A4]
$A3:D56E 9D 92 0F    STA $0F92,x[$7E:1152]
$A3:D571 B9 A6 D5    LDA $D5A6,y[$A3:D5A6]
$A3:D574 9D AE 0F    STA $0FAE,x[$7E:116E]
$A3:D577 A9 01 00    LDA #$0001
$A3:D57A 9D 94 0F    STA $0F94,x[$7E:1154]
$A3:D57D 9E 90 0F    STZ $0F90,x[$7E:1150]
$A3:D580 A9 FF FF    LDA #$FFFF
$A3:D583 9F 02 78 7E STA $7E7802,x[$7E:79C2]
$A3:D587 AD 1E 0A    LDA $0A1E  [$7E:0A1E]
$A3:D58A 29 FF 00    AND #$00FF
$A3:D58D C9 04 00    CMP #$0004
$A3:D590 D0 09       BNE $09    [$D59B]
$A3:D592 A9 FF FF    LDA #$FFFF
$A3:D595 9F 06 78 7E STA $7E7806,x[$7E:79C6]
$A3:D599 80 07       BRA $07    [$D5A2]

$A3:D59B A9 01 00    LDA #$0001
$A3:D59E 9F 06 78 7E STA $7E7806,x[$7E:79C6]

$A3:D5A2 7A          PLY
$A3:D5A3 60          RTS

$A3:D5A4             dw CC06,CB44, CC1E,CB92
}


;;; $D5AC: Maridia snail spritemaps ;;;
{
$A3:D5AC             dx 0002, C3FB,F6,2120, C3F5,F8,2100
$A3:D5B8             dx 0002, C3FC,F6,2120, C3F4,F8,2102
$A3:D5C4             dx 0002, C3FB,F5,2120, C3F5,F8,2104
$A3:D5D0             dx 0002, C3F9,F6,2120, C3F4,FE,2106
$A3:D5DC             dx 0002, C3F2,F6,2122, C3F0,01,2108
$A3:D5E8             dx 0002, C3EE,F8,2124, C3F0,00,2108
$A3:D5F4             dx 0002, C3F6,F5,2124, C3F8,FB,2108
$A3:D600             dx 0002, C3F6,F4,2124, C3F8,FC,210A
$A3:D60C             dx 0002, C3F5,F5,2124, C3F8,FB,210C
$A3:D618             dx 0002, C3F6,F7,2124, C3FE,FC,210E
$A3:D624             dx 0002, C3F6,FE,2126, C201,00,E100
$A3:D630             dx 0002, C3F8,02,E120, C200,00,E100
$A3:D63C             dx 0002, C3F5,FA,E120, C3FB,F8,E100
$A3:D648             dx 0002, C3F4,FA,E120, C3FC,F8,E102
$A3:D654             dx 0002, C3F5,FB,E120, C3FB,F8,E104
$A3:D660             dx 0002, C3F7,FA,E120, C3FC,F2,E106
$A3:D66C             dx 0002, C3FE,FA,E122, C200,EF,E108
$A3:D678             dx 0002, C202,F8,E124, C200,F0,E108
$A3:D684             dx 0002, C3FA,FB,E124, C3F8,F5,E108
$A3:D690             dx 0002, C3FA,FC,E124, C3F8,F4,E10A
$A3:D69C             dx 0002, C3FB,FB,E124, C3F8,F5,E10C
$A3:D6A8             dx 0002, C3FA,F9,E124, C3F2,F4,E10E
$A3:D6B4             dx 0002, C3FA,F2,E126, C3EF,F0,2100
$A3:D6C0             dx 0002, C3F8,EE,2120, C3F0,F0,2100
$A3:D6CC             dx 0002, C3FB,F7,2120, C3F9,F8,2100
$A3:D6D8             dx 0001, C3F8,F8,2122
$A3:D6DF             dx 0002, C3F7,F6,2124, C3F8,F8,2108
$A3:D6EB             dx 0001, C3F8,F8,2126
$A3:D6F2             dx 0002, C3F6,F9,E120, C3F8,F8,E100
$A3:D6FE             dx 0001, C3F8,F8,E122
$A3:D705             dx 0002, C3F9,FA,6124, C3F8,F8,E108
$A3:D711             dx 0001, C3F8,F8,E126
$A3:D718             dx 0002, C3F5,F6,6120, C3FB,F8,6100
$A3:D724             dx 0002, C3F4,F6,6120, C3FC,F8,6102
$A3:D730             dx 0002, C3F5,F5,6120, C3FB,F8,6104
$A3:D73C             dx 0002, C3F7,F6,6120, C3FC,FE,6106
$A3:D748             dx 0002, C3FE,F6,6122, C200,01,6108
$A3:D754             dx 0002, C202,F8,6124, C200,00,6108
$A3:D760             dx 0002, C3FA,F5,6124, C3F8,FB,6108
$A3:D76C             dx 0002, C3FA,F4,6124, C3F8,FC,610A
$A3:D778             dx 0002, C3FB,F5,6124, C3F8,FB,610C
$A3:D784             dx 0002, C3FA,F7,6124, C3F2,FC,610E
$A3:D790             dx 0002, C3FA,FE,6126, C3EF,00,A100
$A3:D79C             dx 0002, C3F8,02,A120, C3F0,00,A100
$A3:D7A8             dx 0002, C3FB,FA,A120, C3F5,F8,A100
$A3:D7B4             dx 0002, C3FC,FA,A120, C3F4,F8,A102
$A3:D7C0             dx 0002, C3FB,FB,A120, C3F5,F8,A104
$A3:D7CC             dx 0002, C3F9,FA,A120, C3F4,F2,A106
$A3:D7D8             dx 0002, C3F2,FA,A122, C3F0,EF,A108
$A3:D7E4             dx 0002, C3EE,F8,A124, C3F0,F0,A108
$A3:D7F0             dx 0002, C3F6,FB,A124, C3F8,F5,A108
$A3:D7FC             dx 0002, C3F6,FC,A124, C3F8,F4,A10A
$A3:D808             dx 0002, C3F5,FB,A124, C3F8,F5,A10C
$A3:D814             dx 0002, C3F7,F9,A124, C3FF,F4,A10E
$A3:D820             dx 0002, C3F6,F2,A126, C201,F0,6100
$A3:D82C             dx 0002, C3F8,EE,6120, C200,F0,6100
$A3:D838             dx 0002, C3F5,F7,6120, C3F7,F8,6100
$A3:D844             dx 0001, C3F8,F8,6122
$A3:D84B             dx 0002, C3F9,F6,6124, C3F8,F8,6108
$A3:D857             dx 0001, C3F8,F8,6126
$A3:D85E             dx 0002, C3FA,F9,A120, C3F8,F8,A100
$A3:D86A             dx 0001, C3F8,F8,A122
$A3:D871             dx 0002, C3F7,FA,A124, C3F8,F8,A108
$A3:D87D             dx 0001, C3F8,F8,A126
$A3:D884             dx 0002, C3FB,F6,2120, C3F5,F8,2100
$A3:D890             dx 0002, C3F5,F8,2128, C3FB,F7,2120
$A3:D89C             dx 0002, C3FA,FA,E126, C3F8,F7,E108
$A3:D8A8             dx 0002, C3FA,FA,E124, C3F8,F6,E108
$A3:D8B4             dx 0002, C3FA,FB,E124, C3F8,F5,E108
$A3:D8C0             dx 0002, C3F8,F5,E12A, C3F9,FB,E124
$A3:D8CC             dx 0002, C3F6,FA,2126, C3F9,F8,E100
$A3:D8D8             dx 0002, C3F6,FA,E120, C3FA,F8,E100
$A3:D8E4             dx 0002, C3F5,FA,E120, C3FB,F8,E100
$A3:D8F0             dx 0002, C3FB,F8,E128, C3F5,F9,E120
$A3:D8FC             dx 0002, C3F6,F6,2126, C3F8,F9,2108
$A3:D908             dx 0002, C3F6,F6,2124, C3F8,FA,2108
$A3:D914             dx 0002, C3F6,F5,2124, C3F8,FB,2108
$A3:D920             dx 0002, C3F8,FB,212A, C3F7,F5,2124
$A3:D92C             dx 0002, C3FA,F6,2122, C3F7,F8,2100
$A3:D938             dx 0002, C3FB,F6,2120, C3F7,F8,2100
$A3:D944             dx 0001, C3F8,F8,2122
$A3:D94B             dx 0002, C3F8,F7,2120, C3F6,F8,2100
$A3:D957             dx 0001, C3F8,F8,E126
$A3:D95E             dx 0002, C3F9,F8,E124, C3F8,F6,E108
$A3:D96A             dx 0001, C3F8,F8,E122
$A3:D971             dx 0002, C3F8,F9,E120, C3FA,F8,E100
$A3:D97D             dx 0001, C3F8,F8,2126
$A3:D984             dx 0002, C3F7,F8,2124, C3F8,FA,2108
$A3:D990             dx 0002, C3F5,F6,6120, C3FB,F8,6100
$A3:D99C             dx 0002, C3FB,F8,6128, C3F5,F7,6120
$A3:D9A8             dx 0002, C3F6,FA,A126, C3F8,F7,A108
$A3:D9B4             dx 0002, C3F6,FA,A124, C3F8,F6,A108
$A3:D9C0             dx 0002, C3F6,FB,A124, C3F8,F5,A108
$A3:D9CC             dx 0002, C3F8,F5,A12A, C3F7,FB,A124
$A3:D9D8             dx 0002, C3FA,FA,6126, C3F7,F8,A100
$A3:D9E4             dx 0002, C3FA,FA,A120, C3F6,F8,A100
$A3:D9F0             dx 0002, C3FB,FA,A120, C3F5,F8,A100
$A3:D9FC             dx 0002, C3F5,F8,A128, C3FB,F9,A120
$A3:DA08             dx 0002, C3FA,F6,6126, C3F8,F9,6108
$A3:DA14             dx 0002, C3FA,F6,6124, C3F8,FA,6108
$A3:DA20             dx 0002, C3FA,F5,6124, C3F8,FB,6108
$A3:DA2C             dx 0002, C3F8,FB,612A, C3F9,F5,6124
$A3:DA38             dx 0002, C3F6,F6,6122, C3F9,F8,6100
$A3:DA44             dx 0002, C3F5,F6,6120, C3F9,F8,6100
$A3:DA50             dx 0001, C3F8,F8,6122
$A3:DA57             dx 0002, C3F8,F7,6120, C3FA,F8,6100
$A3:DA63             dx 0001, C3F8,F8,A126
$A3:DA6A             dx 0002, C3F7,F8,A124, C3F8,F6,A108
$A3:DA76             dx 0001, C3F8,F8,A122
$A3:DA7D             dx 0002, C3F8,F9,A120, C3F6,F8,A100
$A3:DA89             dx 0001, C3F8,F8,6126
$A3:DA90             dx 0002, C3F9,F8,6124, C3F8,FA,6108
}
}


;;; $DA9C..DFA1: Reflec ;;;
{
;;; $DA9C: Palette - enemy $DBFF (reflec) ;;;
{
$A3:DA9C             dw 3800, 7FBD, 5EB5, 1884, 0800, 777B, 5EB5, 45EF, 2D29, 241F, 1C17, 142F, 0C47, 06E1, 6BF5, 05A1
}


;;; $DABC: Reflec glow colours ;;;
{
$A3:DABC             dw 241F,1C17,142F,0C47,
                        211F,18D8,10B1,086A,
                        221F,1999,1113,08AD,
                        1EFF,163A,0D95,04D0,
                        1BFF,12FB,09F7,00F3,
                        1BFF,12FB,09F7,00F3,
                        1EFF,163A,0D95,04D0,
                        221F,1999,1113,08AD,
                        211F,18D8,10B1,086A,
                        241F,1C17,142F,0C47
}


;;; $DB0C: Enemy graphics drawn hook - reflec - periodically cycle between palettes ;;;
{
$A3:DB0C AD 97 07    LDA $0797  [$7E:0797]  ;\
$A3:DB0F D0 3A       BNE $3A    [$DB4B]     ;} If currently transitioning the room: return
$A3:DB11 AD 98 17    LDA $1798  [$7E:1798]  ;\
$A3:DB14 3A          DEC A                  ;} Decrement $1798
$A3:DB15 8D 98 17    STA $1798  [$7E:1798]  ;/
$A3:DB18 D0 31       BNE $31    [$DB4B]     ; If [$1798] != 0: return
$A3:DB1A A9 10 00    LDA #$0010             ;\
$A3:DB1D 8D 98 17    STA $1798  [$7E:1798]  ;} $1798 = 10h
$A3:DB20 AD 94 17    LDA $1794  [$7E:1794]  ;\
$A3:DB23 AA          TAX                    ;|
$A3:DB24 AD 96 17    LDA $1796  [$7E:1796]  ;|
$A3:DB27 0A          ASL A                  ;|
$A3:DB28 0A          ASL A                  ;|
$A3:DB29 0A          ASL A                  ;|
$A3:DB2A A8          TAY                    ;|
$A3:DB2B A9 04 00    LDA #$0004             ;|
$A3:DB2E 8D 0B 06    STA $060B  [$7E:060B]  ;|
                                            ;} Copy 4 colours from $DABC + [$1796] * 8 to enemy palette colours 9..Ch
$A3:DB31 B9 BC DA    LDA $DABC,y            ;|
$A3:DB34 9F 12 C1 7E STA $7EC112,x          ;|
$A3:DB38 C8          INY                    ;|
$A3:DB39 C8          INY                    ;|
$A3:DB3A E8          INX                    ;|
$A3:DB3B E8          INX                    ;|
$A3:DB3C CE 0B 06    DEC $060B  [$7E:060B]  ;|
$A3:DB3F D0 F0       BNE $F0    [$DB31]     ;/
$A3:DB41 AD 96 17    LDA $1796  [$7E:1796]  ;\
$A3:DB44 1A          INC A                  ;|
$A3:DB45 29 07 00    AND #$0007             ;} $1796 = ([$1796] + 1) % 8
$A3:DB48 8D 96 17    STA $1796  [$7E:1796]  ;/

$A3:DB4B 6B          RTL
}


;;; $DB4C..C7: Instruction lists - reflec ;;;
{
;;; $DB4C: Instruction list -  ;;;
{
$A3:DB4C             dx DBC8,0000,  ; Enemy $0FB6 = 0000h
                        0040,DF1A,
                        80ED,DB4C   ; Go to $DB4C
}


;;; $DB58: Instruction list -  ;;;
{
$A3:DB58             dx DBC8,0001,  ; Enemy $0FB6 = 0001h
                        0040,DF2B,
                        80ED,DB58   ; Go to $DB58
}


;;; $DB64: Instruction list -  ;;;
{
$A3:DB64             dx DBC8,0002,  ; Enemy $0FB6 = 0002h
                        0040,DF3C,
                        812F        ; Sleep
}


;;; $DB6E: Instruction list -  ;;;
{
$A3:DB6E             dx DBC8,0003,  ; Enemy $0FB6 = 0003h
                        0040,DF4D,
                        812F        ; Sleep
}


;;; $DB78: Instruction list -  ;;;
{
$A3:DB78             dx DBC8,0000,  ; Enemy $0FB6 = 0000h
                        0040,DF5E,
                        812F        ; Sleep
}


;;; $DB82: Instruction list -  ;;;
{
$A3:DB82             dx DBC8,0001,  ; Enemy $0FB6 = 0001h
                        0040,DF6F,
                        812F        ; Sleep
}


;;; $DB8C: Instruction list -  ;;;
{
$A3:DB8C             dx DBC8,0002,  ; Enemy $0FB6 = 0002h
                        0040,DF80,
                        812F        ; Sleep
}


;;; $DB96: Instruction list -  ;;;
{
$A3:DB96             dx DBC8,0003,  ; Enemy $0FB6 = 0003h
                        0040,DF91,
                        812F        ; Sleep
}


;;; $DBA0: Instruction list -  ;;;
{
$A3:DBA0             dx DBC8,0000,  ; Enemy $0FB6 = 0000h
                        0001,DF1A,
                        812F        ; Sleep
}


;;; $DBAA: Instruction list -  ;;;
{
$A3:DBAA             dx DBC8,0001,  ; Enemy $0FB6 = 0001h
                        0001,DF2B,
                        812F        ; Sleep
}


;;; $DBB4: Instruction list -  ;;;
{
$A3:DBB4             dx DBC8,0002,  ; Enemy $0FB6 = 0002h
                        0001,DF3C,
                        812F        ; Sleep
}


;;; $DBBE: Instruction list -  ;;;
{
$A3:DBBE             dx DBC8,0003,  ; Enemy $0FB6 = 0003h
                        0001,DF4D,
                        812F        ; Sleep
}
}


;;; $DBC8: Instruction - enemy $0FB6 = [[Y]] ;;;
{
$A3:DBC8 5A          PHY
$A3:DBC9 B9 00 00    LDA $0000,y
$A3:DBCC 9D B6 0F    STA $0FB6,x
$A3:DBCF 7A          PLY
$A3:DBD0 C8          INY
$A3:DBD1 C8          INY
$A3:DBD2 6B          RTL
}


;;; $DBD3: Initialisation AI - enemy $DBFF (reflec) ;;;
{
$A3:DBD3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DBD6 BD 86 0F    LDA $0F86,x
$A3:DBD9 09 00 10    ORA #$1000
$A3:DBDC 9D 86 0F    STA $0F86,x
$A3:DBDF BD B4 0F    LDA $0FB4,x
$A3:DBE2 0A          ASL A
$A3:DBE3 A8          TAY
$A3:DBE4 B9 0B DC    LDA $DC0B,y
$A3:DBE7 9D 92 0F    STA $0F92,x
$A3:DBEA A9 0C DB    LDA #$DB0C
$A3:DBED 8D 8C 17    STA $178C  [$7E:178C]
$A3:DBF0 A9 A3 00    LDA #$00A3
$A3:DBF3 8D 8E 17    STA $178E  [$7E:178E]
$A3:DBF6 BD 96 0F    LDA $0F96,x
$A3:DBF9 0A          ASL A
$A3:DBFA 0A          ASL A
$A3:DBFB 0A          ASL A
$A3:DBFC 0A          ASL A
$A3:DBFD 29 00 FF    AND #$FF00
$A3:DC00 EB          XBA
$A3:DC01 8D 94 17    STA $1794  [$7E:1794]
$A3:DC04 A9 10 00    LDA #$0010
$A3:DC07 8D 98 17    STA $1798  [$7E:1798]
$A3:DC0A 6B          RTL

$A3:DC0B             dw DB4C, DB58, DB64, DB6E, DB78, DB82, DB8C, DB96
}


;;; $DC1B: Main AI - enemy $DBFF (reflec) ;;;
{
$A3:DC1B 6B          RTL
}


;;; $DC1C: Enemy shot - enemy $DBFF (reflec) ;;;
{
$A3:DC1C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DC1F AD A6 18    LDA $18A6  [$7E:18A6]
$A3:DC22 0A          ASL A
$A3:DC23 A8          TAY
$A3:DC24 A9 0A 00    LDA #$000A
$A3:DC27 9D A0 0F    STA $0FA0,x
$A3:DC2A BD B6 0F    LDA $0FB6,x
$A3:DC2D 0A          ASL A
$A3:DC2E 0A          ASL A
$A3:DC2F 0A          ASL A
$A3:DC30 0A          ASL A
$A3:DC31 0A          ASL A
$A3:DC32 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:DC35 B9 04 0C    LDA $0C04,y
$A3:DC38 29 0F 00    AND #$000F
$A3:DC3B 0A          ASL A
$A3:DC3C 18          CLC
$A3:DC3D 6D 32 0E    ADC $0E32  [$7E:0E32]
$A3:DC40 AA          TAX
$A3:DC41 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:DC44 BD AE DC    LDA $DCAE,x
$A3:DC47 C9 00 80    CMP #$8000
$A3:DC4A F0 2E       BEQ $2E    [$DC7A]
$A3:DC4C BD AE DC    LDA $DCAE,x
$A3:DC4F 30 02       BMI $02    [$DC53]
$A3:DC51 80 0D       BRA $0D    [$DC60]

$A3:DC53 FC 2E DD    JSR ($DD2E,x)
$A3:DC56 AE 32 0E    LDX $0E32  [$7E:0E32]
$A3:DC59 BD AE DC    LDA $DCAE,x
$A3:DC5C 49 FF FF    EOR #$FFFF
$A3:DC5F 1A          INC A

$A3:DC60 99 04 0C    STA $0C04,y
$A3:DC63 B9 18 0C    LDA $0C18,y
$A3:DC66 29 FF 7F    AND #$7FFF
$A3:DC69 99 18 0C    STA $0C18,y
$A3:DC6C 84 14       STY $14    [$7E:0014]
$A3:DC6E 22 00 BE 90 JSL $90BE00[$90:BE00]
$A3:DC72 A9 57 00    LDA #$0057             ;\
$A3:DC75 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 57h, sound library 2, max queued sounds allowed = 6 (shot reflec)
$A3:DC79 6B          RTL

$A3:DC7A B9 04 0C    LDA $0C04,y
$A3:DC7D 09 10 00    ORA #$0010
$A3:DC80 99 04 0C    STA $0C04,y
$A3:DC83 BD 8C 0F    LDA $0F8C,x
$A3:DC86 F0 1D       BEQ $1D    [$DCA5]
$A3:DC88 22 32 80 A3 JSL $A38032[$A3:8032]
$A3:DC8C BD 8C 0F    LDA $0F8C,x
$A3:DC8F D0 14       BNE $14    [$DCA5]
$A3:DC91 BD B6 0F    LDA $0FB6,x
$A3:DC94 0A          ASL A
$A3:DC95 A8          TAY
$A3:DC96 B9 A6 DC    LDA $DCA6,y
$A3:DC99 9D 92 0F    STA $0F92,x
$A3:DC9C A9 01 00    LDA #$0001
$A3:DC9F 9D 94 0F    STA $0F94,x
$A3:DCA2 9E 90 0F    STZ $0F90,x

$A3:DCA5 6B          RTL

$A3:DCA6             dw DBA0, DBAA, DBB4, DBBE


;                        ______________________________________________ Up, facing right
;                       |     _________________________________________ Up-right
;                       |    |     ____________________________________ Right
;                       |    |    |     _______________________________ Down-right
;                       |    |    |    |     __________________________ Down, facing right
;                       |    |    |    |    |     _____________________ Down, facing left
;                       |    |    |    |    |    |     ________________ Down-left
;                       |    |    |    |    |    |    |     ___________ Left
;                       |    |    |    |    |    |    |    |     ______ Up-left
;                       |    |    |    |    |    |    |    |    |     _ Up, facing left
;                       |    |    |    |    |    |    |    |    |    |
$A3:DCAE             dw 8000,FFF8,0007,FFFA,8000,8000,FFFD,0002,FFFF,8000, 0000,0000,0000,0000,0000,0000,
                        FFFE,8000,FFF7,0008,FFF9,FFF9,8000,FFFB,0003,FFFE, 0000,0000,0000,0000,0000,0000,
                        0004,FFFD,8000,FFFF,0000,0009,FFF8,8000,FFFA,0005, 0000,0000,0000,0000,0000,0000,
                        FFF9,0006,FFFC,8000,FFFE,FFFE,0001,FFF7,8000,FFF9, 0000,0000,0000,0000,0000,0000

$A3:DD2E             dw 0000,DDAE,0000,DDAE,0000,0000,DDCF,0000,DDCF,0000, 0000,0000,0000,0000,0000,0000,
                        DDF0,0000,DE0D,0000,DE2A,DE2A,0000,DE47,0000,DDF0, 0000,0000,0000,0000,0000,0000,
                        0000,DE64,0000,DE85,0000,0000,DE85,0000,DE64,0000, 0000,0000,0000,0000,0000,0000,
                        DEA6,0000,DEC3,0000,DEE0,DEE0,0000,DEFD,0000,DEA6, 0000,0000,0000,0000,0000,0000
}


;;; $DDAE:  ;;;
{
$A3:DDAE AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DDB1 BD 7A 0F    LDA $0F7A,x
$A3:DDB4 38          SEC
$A3:DDB5 E9 08 00    SBC #$0008
$A3:DDB8 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DDBB B9 64 0B    LDA $0B64,y
$A3:DDBE 18          CLC
$A3:DDBF 79 B4 0B    ADC $0BB4,y
$A3:DDC2 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DDC5 10 04       BPL $04    [$DDCB]
$A3:DDC7 A9 00 00    LDA #$0000
$A3:DDCA 60          RTS

$A3:DDCB A9 01 00    LDA #$0001
$A3:DDCE 60          RTS
}


;;; $DDCF:  ;;;
{
$A3:DDCF AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DDD2 BD 7A 0F    LDA $0F7A,x
$A3:DDD5 18          CLC
$A3:DDD6 69 08 00    ADC #$0008
$A3:DDD9 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DDDC B9 64 0B    LDA $0B64,y
$A3:DDDF 38          SEC
$A3:DDE0 F9 B4 0B    SBC $0BB4,y
$A3:DDE3 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DDE6 30 04       BMI $04    [$DDEC]
$A3:DDE8 A9 00 00    LDA #$0000
$A3:DDEB 60          RTS

$A3:DDEC A9 01 00    LDA #$0001
$A3:DDEF 60          RTS
}


;;; $DDF0:  ;;;
{
$A3:DDF0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DDF3 BD 7A 0F    LDA $0F7A,x
$A3:DDF6 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DDF9 B9 64 0B    LDA $0B64,y
$A3:DDFC 18          CLC
$A3:DDFD 79 B4 0B    ADC $0BB4,y
$A3:DE00 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DE03 30 04       BMI $04    [$DE09]
$A3:DE05 A9 00 00    LDA #$0000
$A3:DE08 60          RTS

$A3:DE09 A9 01 00    LDA #$0001
$A3:DE0C 60          RTS
}


;;; $DE0D:  ;;;
{
$A3:DE0D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DE10 BD 7E 0F    LDA $0F7E,x
$A3:DE13 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DE16 B9 78 0B    LDA $0B78,y
$A3:DE19 38          SEC
$A3:DE1A F9 C8 0B    SBC $0BC8,y
$A3:DE1D CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DE20 10 04       BPL $04    [$DE26]
$A3:DE22 A9 00 00    LDA #$0000
$A3:DE25 60          RTS

$A3:DE26 A9 01 00    LDA #$0001
$A3:DE29 60          RTS
}


;;; $DE2A:  ;;;
{
$A3:DE2A AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DE2D BD 7A 0F    LDA $0F7A,x
$A3:DE30 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DE33 B9 64 0B    LDA $0B64,y
$A3:DE36 38          SEC
$A3:DE37 F9 B4 0B    SBC $0BB4,y
$A3:DE3A CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DE3D 10 04       BPL $04    [$DE43]
$A3:DE3F A9 00 00    LDA #$0000
$A3:DE42 60          RTS

$A3:DE43 A9 01 00    LDA #$0001
$A3:DE46 60          RTS
}


;;; $DE47:  ;;;
{
$A3:DE47 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DE4A BD 7E 0F    LDA $0F7E,x
$A3:DE4D 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DE50 B9 78 0B    LDA $0B78,y
$A3:DE53 18          CLC
$A3:DE54 79 C8 0B    ADC $0BC8,y
$A3:DE57 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DE5A 30 04       BMI $04    [$DE60]
$A3:DE5C A9 00 00    LDA #$0000
$A3:DE5F 60          RTS

$A3:DE60 A9 01 00    LDA #$0001
$A3:DE63 60          RTS
}


;;; $DE64:  ;;;
{
$A3:DE64 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DE67 BD 7E 0F    LDA $0F7E,x
$A3:DE6A 18          CLC
$A3:DE6B 69 08 00    ADC #$0008
$A3:DE6E 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DE71 B9 78 0B    LDA $0B78,y
$A3:DE74 38          SEC
$A3:DE75 F9 C8 0B    SBC $0BC8,y
$A3:DE78 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DE7B 30 04       BMI $04    [$DE81]
$A3:DE7D A9 00 00    LDA #$0000
$A3:DE80 60          RTS

$A3:DE81 A9 01 00    LDA #$0001
$A3:DE84 60          RTS
}


;;; $DE85:  ;;;
{
$A3:DE85 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DE88 BD 7E 0F    LDA $0F7E,x
$A3:DE8B 38          SEC
$A3:DE8C E9 08 00    SBC #$0008
$A3:DE8F 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DE92 B9 78 0B    LDA $0B78,y
$A3:DE95 18          CLC
$A3:DE96 79 C8 0B    ADC $0BC8,y
$A3:DE99 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DE9C 10 04       BPL $04    [$DEA2]
$A3:DE9E A9 00 00    LDA #$0000
$A3:DEA1 60          RTS

$A3:DEA2 A9 01 00    LDA #$0001
$A3:DEA5 60          RTS
}


;;; $DEA6:  ;;;
{
$A3:DEA6 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DEA9 BD 7A 0F    LDA $0F7A,x
$A3:DEAC 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DEAF B9 64 0B    LDA $0B64,y
$A3:DEB2 38          SEC
$A3:DEB3 F9 B4 0B    SBC $0BB4,y
$A3:DEB6 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DEB9 30 04       BMI $04    [$DEBF]
$A3:DEBB A9 00 00    LDA #$0000
$A3:DEBE 60          RTS

$A3:DEBF A9 01 00    LDA #$0001
$A3:DEC2 60          RTS
}


;;; $DEC3:  ;;;
{
$A3:DEC3 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DEC6 BD 7E 0F    LDA $0F7E,x
$A3:DEC9 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DECC B9 78 0B    LDA $0B78,y
$A3:DECF 18          CLC
$A3:DED0 79 C8 0B    ADC $0BC8,y
$A3:DED3 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DED6 10 04       BPL $04    [$DEDC]
$A3:DED8 A9 01 00    LDA #$0001
$A3:DEDB 60          RTS

$A3:DEDC A9 00 00    LDA #$0000
$A3:DEDF 60          RTS
}


;;; $DEE0:  ;;;
{
$A3:DEE0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DEE3 BD 7A 0F    LDA $0F7A,x
$A3:DEE6 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DEE9 B9 64 0B    LDA $0B64,y
$A3:DEEC 38          SEC
$A3:DEED F9 B4 0B    SBC $0BB4,y
$A3:DEF0 CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DEF3 30 04       BMI $04    [$DEF9]
$A3:DEF5 A9 00 00    LDA #$0000
$A3:DEF8 60          RTS

$A3:DEF9 A9 01 00    LDA #$0001
$A3:DEFC 60          RTS
}


;;; $DEFD:  ;;;
{
$A3:DEFD AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:DF00 BD 7E 0F    LDA $0F7E,x
$A3:DF03 8D 36 0E    STA $0E36  [$7E:0E36]
$A3:DF06 B9 78 0B    LDA $0B78,y
$A3:DF09 38          SEC
$A3:DF0A F9 C8 0B    SBC $0BC8,y
$A3:DF0D CD 36 0E    CMP $0E36  [$7E:0E36]
$A3:DF10 10 04       BPL $04    [$DF16]
$A3:DF12 A9 00 00    LDA #$0000
$A3:DF15 60          RTS

$A3:DF16 A9 01 00    LDA #$0001
$A3:DF19 60          RTS
}


;;; $DF1A: Reflec spritemaps ;;;
{
$A3:DF1A             dx 0003, 81F0,00,610E, 81F0,F0,210D, 81F8,F8,2100
$A3:DF2B             dx 0003, 81EA,F3,211A, 81F2,EB,210B, 81F8,F8,2102
$A3:DF3C             dx 0003, 81F8,F8,2104, 8000,F1,A118, 81F0,F1,2108
$A3:DF4D             dx 0003, 81F8,F8,2106, 8006,F3,611A, 81FE,EB,610B
$A3:DF5E             dx 0003, 8000,00,210E, 8000,F0,610D, 81F8,F8,2100
$A3:DF6F             dx 0003, 81F8,F8,2102, 8006,FD,E11A, 81FE,05,E10B
$A3:DF80             dx 0003, 81F8,F8,2104, 8000,FF,2118, 81F0,FF,A108
$A3:DF91             dx 0003, 81F8,F8,2106, 81EA,FD,A11A, 81F2,05,A10B
}
}


;;; $DFA2..E9AE: Creepy crawlies ;;;
{
;;; $DFA2: Palette - enemy $DC3F (Wrecked Ship orange zoomer) ;;;
{
$A3:DFA2             dw 3800, 7F5A, 3BE0, 2680, 0920, 4F5A, 36B5, 2610, 1DCE, 5294, 39CE, 2108, 1084, 033B, 0216, 0113
}


;;; $DFC2: Instruction - enemy function = [[Y]] ;;;
{
$A3:DFC2 B9 00 00    LDA $0000,y[$A3:E021]
$A3:DFC5 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:DFC8 C8          INY
$A3:DFC9 C8          INY
$A3:DFCA 6B          RTL
}


;;; $DFCB: Instruction list - Wrecked Ship orange zoomer - on right facing wall ;;;
{
$A3:DFCB             dx DFC2,E091,  ; Enemy function = $E091
                        0003,E50E,
                        0003,E524,
                        0003,E53A,
                        0003,E550,
                        0003,E566,
                        80ED,DFCF   ; Go to $DFCF
}


;;; $DFE7: Instruction list - Wrecked Ship orange zoomer - on left facing wall ;;;
{
$A3:DFE7             dx DFC2,E091,  ; Enemy function = $E091
                        0003,E3C4,
                        0003,E3DA,
                        0003,E3F0,
                        0003,E406,
                        0003,E41C,
                        80ED,DFEB   ; Go to $DFEB
}


;;; $E003: Instruction list - Wrecked Ship orange zoomer - on ceiling ;;;
{
$A3:E003             dx DFC2,E168,  ; Enemy function = $E168
                        0003,E432,
                        0003,E448,
                        0003,E45E,
                        0003,E474,
                        0003,E48A,
                        80ED,E007   ; Go to $E007
}


;;; $E01F: Instruction list - Wrecked Ship orange zoomer - on floor ;;;
{
$A3:E01F             dx DFC2,E168,  ; Enemy function = $E168
                        0003,E2E8,
                        0003,E2FE,
                        0003,E314,
                        0003,E32A,
                        0003,E340,
                        80ED,E023   ; Go to $E023
}


;;; $E03B: Wrecked Ship orange zoomer instruction list pointers ;;;
{
$A3:E03B             dw DFCB, DFE7, E003, E01F
}


;;; $E043: Initialisation AI - enemy $DC3F (Wrecked Ship orange zoomer) ;;;
{
$A3:E043 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E046 BD 92 0F    LDA $0F92,x[$7E:0F92]  ;\
$A3:E049 29 03 00    AND #$0003             ;|
$A3:E04C 0A          ASL A                  ;|
$A3:E04D A8          TAY                    ;} Enemy instruction list pointer = [$E03B + ([enemy initialisation parameter] & 3) * 2]
$A3:E04E B9 3B E0    LDA $E03B,y[$A3:E041]  ;|
$A3:E051 9D 92 0F    STA $0F92,x[$7E:0F92]  ;/
$A3:E054 A9 8A E0    LDA #$E08A             ;\
$A3:E057 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = RTL
$A3:E05A BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A3:E05D 0A          ASL A                  ;|
$A3:E05E A8          TAY                    ;|
$A3:E05F B9 F0 E5    LDA $E5F0,y[$A3:E5F2]  ;} Enemy X velocity = enemy Y velocity = [$E5F0 + [enemy parameter 1] * 2]
$A3:E062 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;|
$A3:E065 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/
$A3:E068 BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A3:E06B 29 03 00    AND #$0003             ;} If [enemy properties] & 3 = 0:
$A3:E06E D0 0B       BNE $0B    [$E07B]     ;/
$A3:E070 BD A8 0F    LDA $0FA8,x            ;\
$A3:E073 49 FF FF    EOR #$FFFF             ;|
$A3:E076 1A          INC A                  ;} Negate enemy X velocity
$A3:E077 9D A8 0F    STA $0FA8,x            ;/
$A3:E07A 6B          RTL                    ; Return

$A3:E07B C9 02 00    CMP #$0002             ;\
$A3:E07E D0 0A       BNE $0A    [$E08A]     ;} If [enemy properties] & 3 = 2:
$A3:E080 BD AA 0F    LDA $0FAA,x            ;\
$A3:E083 49 FF FF    EOR #$FFFF             ;|
$A3:E086 1A          INC A                  ;} Negate enemy Y velocity
$A3:E087 9D AA 0F    STA $0FAA,x            ;/

$A3:E08A 6B          RTL
}


;;; $E08B: Main AI - enemy $DC3F (Wrecked Ship orange zoomer) ;;;
{
$A3:E08B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E08E 7C B2 0F    JMP ($0FB2,x)[$A3:E08A]
}


;;; $E091: Wrecked Ship orange zoomer function - moving vertically ;;;
{
$A3:E091 AD 40 18    LDA $1840  [$7E:1840]
$A3:E094 C9 1E 00    CMP #$001E
$A3:E097 D0 15       BNE $15    [$E0AE]
$A3:E099 AD 3E 18    LDA $183E  [$7E:183E]
$A3:E09C C9 14 00    CMP #$0014
$A3:E09F D0 0D       BNE $0D    [$E0AE]
$A3:E0A1 BD B2 0F    LDA $0FB2,x
$A3:E0A4 9F 06 78 7E STA $7E7806,x
$A3:E0A8 A9 85 E7    LDA #$E785
$A3:E0AB 9D B2 0F    STA $0FB2,x

$A3:E0AE 64 12       STZ $12    [$7E:0012]  ;\
$A3:E0B0 64 14       STZ $14    [$7E:0014]  ;|
$A3:E0B2 BD A8 0F    LDA $0FA8,x            ;|
$A3:E0B5 10 02       BPL $02    [$E0B9]     ;} $14.$12 = [enemy X velocity] / 100h
$A3:E0B7 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E0B9 85 13       STA $13    [$7E:0013]  ;/
$A3:E0BB A5 14       LDA $14    [$7E:0014]  ;\
$A3:E0BD 10 03       BPL $03    [$E0C2]     ;} If [$14] < 0:
$A3:E0BF 3A          DEC A                  ; $14 -= 1
$A3:E0C0 80 01       BRA $01    [$E0C3]
                                            ; Else ([$14] >= 0):
$A3:E0C2 1A          INC A                  ; $14 += 1

$A3:E0C3 85 14       STA $14    [$7E:0014]
$A3:E0C5 22 A4 C6 A0 JSL $A0C6A4[$A0:C6A4]  ; Move enemy right by [$14].[$12], process slopes
$A3:E0C9 90 61       BCC $61    [$E12C]     ; If not collided with wall: go to BRANCH_NO_COLLISION
$A3:E0CB A9 00 00    LDA #$0000
$A3:E0CE 9F 08 78 7E STA $7E7808,x
$A3:E0D2 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]
$A3:E0D6 64 12       STZ $12    [$7E:0012]  ;\
$A3:E0D8 64 14       STZ $14    [$7E:0014]  ;|
$A3:E0DA BD AA 0F    LDA $0FAA,x            ;|
$A3:E0DD 10 02       BPL $02    [$E0E1]     ;} $14.$12 = [enemy Y velocity] / 100h
$A3:E0DF C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E0E1 85 13       STA $13    [$7E:0013]  ;/
$A3:E0E3 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:E0E7 B0 20       BCS $20    [$E109]     ; If collided with block: go to BRANCH_COLLIDED_VERTICALLY
$A3:E0E9 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E0EC AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A3:E0EF 38          SEC
$A3:E0F0 FD 7E 0F    SBC $0F7E,x
$A3:E0F3 10 07       BPL $07    [$E0FC]
$A3:E0F5 BD AA 0F    LDA $0FAA,x
$A3:E0F8 30 0B       BMI $0B    [$E105]
$A3:E0FA 80 05       BRA $05    [$E101]

$A3:E0FC BD AA 0F    LDA $0FAA,x
$A3:E0FF 10 04       BPL $04    [$E105]

$A3:E101 49 FF FF    EOR #$FFFF
$A3:E104 1A          INC A

$A3:E105 9D AA 0F    STA $0FAA,x
$A3:E108 6B          RTL

; BRANCH_COLLIDED_VERTICALLY
$A3:E109 BD A8 0F    LDA $0FA8,x
$A3:E10C 49 FF FF    EOR #$FFFF
$A3:E10F 1A          INC A
$A3:E110 9D A8 0F    STA $0FA8,x
$A3:E113 A0 1F E0    LDY #$E01F
$A3:E116 A0 1F E0    LDY #$E01F
$A3:E119 BD AA 0F    LDA $0FAA,x
$A3:E11C 10 03       BPL $03    [$E121]
$A3:E11E A0 03 E0    LDY #$E003

$A3:E121 98          TYA
$A3:E122 9D 92 0F    STA $0F92,x
$A3:E125 A9 01 00    LDA #$0001
$A3:E128 9D 94 0F    STA $0F94,x
$A3:E12B 6B          RTL

; BRANCH_NO_COLLISION
$A3:E12C BF 08 78 7E LDA $7E7808,x
$A3:E130 1A          INC A
$A3:E131 9F 08 78 7E STA $7E7808,x
$A3:E135 C9 04 00    CMP #$0004
$A3:E138 30 0E       BMI $0E    [$E148]
$A3:E13A BD B2 0F    LDA $0FB2,x
$A3:E13D 9F 06 78 7E STA $7E7806,x
$A3:E141 A9 85 E7    LDA #$E785
$A3:E144 9D B2 0F    STA $0FB2,x
$A3:E147 6B          RTL

$A3:E148 BD AA 0F    LDA $0FAA,x
$A3:E14B 49 FF FF    EOR #$FFFF
$A3:E14E 1A          INC A
$A3:E14F 9D AA 0F    STA $0FAA,x
$A3:E152 A0 1F E0    LDY #$E01F
$A3:E155 BD AA 0F    LDA $0FAA,x
$A3:E158 10 03       BPL $03    [$E15D]
$A3:E15A A0 03 E0    LDY #$E003

$A3:E15D 98          TYA
$A3:E15E 9D 92 0F    STA $0F92,x
$A3:E161 A9 01 00    LDA #$0001
$A3:E164 9D 94 0F    STA $0F94,x
$A3:E167 6B          RTL
}


;;; $E168: Wrecked Ship orange zoomer function - moving horizontally ;;;
{
$A3:E168 AD 40 18    LDA $1840  [$7E:1840]
$A3:E16B C9 1E 00    CMP #$001E
$A3:E16E D0 15       BNE $15    [$E185]
$A3:E170 AD 3E 18    LDA $183E  [$7E:183E]
$A3:E173 C9 14 00    CMP #$0014
$A3:E176 D0 0D       BNE $0D    [$E185]
$A3:E178 BD B2 0F    LDA $0FB2,x
$A3:E17B 9F 06 78 7E STA $7E7806,x
$A3:E17F A9 85 E7    LDA #$E785
$A3:E182 9D B2 0F    STA $0FB2,x

$A3:E185 64 12       STZ $12    [$7E:0012]  ;\
$A3:E187 64 14       STZ $14    [$7E:0014]  ;|
$A3:E189 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;|
$A3:E18C 10 02       BPL $02    [$E190]     ;} $14.$12 = [enemy Y velocity] / 100h
$A3:E18E C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E190 85 13       STA $13    [$7E:0013]  ;/
$A3:E192 A5 14       LDA $14    [$7E:0014]  ;\
$A3:E194 10 03       BPL $03    [$E199]     ;} If [$14] < 0:
$A3:E196 3A          DEC A                  ; $14 -= 1
$A3:E197 80 01       BRA $01    [$E19A]
                                            ; Else ([$14] >= 0):
$A3:E199 1A          INC A                  ; $14 += 1

$A3:E19A 85 14       STA $14    [$7E:0014]
$A3:E19C 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:E1A0 90 5E       BCC $5E    [$E200]     ; If not collided with block: go to BRANCH_NO_COLLISION
$A3:E1A2 A9 00 00    LDA #$0000
$A3:E1A5 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:E1A9 64 12       STZ $12    [$7E:0012]  ;\
$A3:E1AB 64 14       STZ $14    [$7E:0014]  ;|
$A3:E1AD BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;|
$A3:E1B0 10 02       BPL $02    [$E1B4]     ;} $14.$12 = [enemy X velocity] / 100h
$A3:E1B2 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E1B4 85 13       STA $13    [$7E:0013]  ;/
$A3:E1B6 22 A4 C6 A0 JSL $A0C6A4[$A0:C6A4]  ; Move enemy right by [$14].[$12], process slopes
$A3:E1BA B0 24       BCS $24    [$E1E0]     ; If collided with wall: go to BRANCH_COLLIDED_HORIZONTALLY
$A3:E1BC 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]
$A3:E1C0 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E1C3 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A3:E1C6 38          SEC
$A3:E1C7 FD 7A 0F    SBC $0F7A,x[$7E:0F7A]
$A3:E1CA 10 07       BPL $07    [$E1D3]
$A3:E1CC BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A3:E1CF 30 0B       BMI $0B    [$E1DC]
$A3:E1D1 80 05       BRA $05    [$E1D8]

$A3:E1D3 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A3:E1D6 10 04       BPL $04    [$E1DC]

$A3:E1D8 49 FF FF    EOR #$FFFF
$A3:E1DB 1A          INC A

$A3:E1DC 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:E1DF 6B          RTL

; BRANCH_COLLIDED_HORIZONTALLY
$A3:E1E0 BD AA 0F    LDA $0FAA,x
$A3:E1E3 49 FF FF    EOR #$FFFF
$A3:E1E6 1A          INC A
$A3:E1E7 9D AA 0F    STA $0FAA,x
$A3:E1EA A0 E7 DF    LDY #$DFE7
$A3:E1ED BD A8 0F    LDA $0FA8,x
$A3:E1F0 10 03       BPL $03    [$E1F5]
$A3:E1F2 A0 CB DF    LDY #$DFCB

$A3:E1F5 98          TYA
$A3:E1F6 9D 92 0F    STA $0F92,x
$A3:E1F9 A9 01 00    LDA #$0001
$A3:E1FC 9D 94 0F    STA $0F94,x
$A3:E1FF 6B          RTL

; BRANCH_NO_COLLISION
$A3:E200 BF 08 78 7E LDA $7E7808,x
$A3:E204 1A          INC A
$A3:E205 9F 08 78 7E STA $7E7808,x
$A3:E209 C9 04 00    CMP #$0004
$A3:E20C 30 0E       BMI $0E    [$E21C]
$A3:E20E BD B2 0F    LDA $0FB2,x
$A3:E211 9F 06 78 7E STA $7E7806,x
$A3:E215 A9 85 E7    LDA #$E785
$A3:E218 9D B2 0F    STA $0FB2,x
$A3:E21B 6B          RTL

$A3:E21C BD A8 0F    LDA $0FA8,x
$A3:E21F 49 FF FF    EOR #$FFFF
$A3:E222 1A          INC A
$A3:E223 9D A8 0F    STA $0FA8,x
$A3:E226 A0 E7 DF    LDY #$DFE7
$A3:E229 BD A8 0F    LDA $0FA8,x
$A3:E22C 10 03       BPL $03    [$E231]
$A3:E22E A0 CB DF    LDY #$DFCB

$A3:E231 98          TYA
$A3:E232 9D 92 0F    STA $0F92,x
$A3:E235 A9 01 00    LDA #$0001
$A3:E238 9D 94 0F    STA $0F94,x
$A3:E23B 6B          RTL
}


;;; $E23C: Palette - enemy $DC7F (big eye bugs) ;;;
{
$A3:E23C             dw 3800, 3F5A, 2E50, 00E5, 0063, 3AB3, 220E, 1169, 0927, 03FF, 02F7, 0210, 0108, 7FFF, 0299, 0170
}


;;; $E25C: Instruction list - creepy crawly - on right facing wall ;;;
{
$A3:E25C             dx E660,E6C8,  ; Enemy function = $E6C8
                        0003,E50E,
                        0003,E524,
                        0003,E53A,
                        0003,E550,
                        0003,E566,
                        80ED,E260   ; Go to $E260
}


;;; $E278: Instruction list - creepy crawly - on left facing wall ;;;
{
$A3:E278             dx E660,E6C8,  ; Enemy function = $E6C8
                        0003,E3C4,
                        0003,E3DA,
                        0003,E3F0,
                        0003,E406,
                        0003,E41C,
                        80ED,E27C   ; Go to $E27C
}


;;; $E294: Instruction list - creepy crawly - on ceiling ;;;
{
$A3:E294             dx E660,E7F2,  ; Enemy function = $E7F2
                        0003,E432,
                        0003,E448,
                        0003,E45E,
                        0003,E474,
                        0003,E48A,
                        80ED,E298   ; Go to $E298
}


;;; $E2B0: Instruction list - creepy crawly - on floor ;;;
{
$A3:E2B0             dx E660,E7F2,  ; Enemy function = $E7F2
                        0003,E2E8,
                        0003,E2FE,
                        0003,E314,
                        0003,E32A,
                        0003,E340,
                        80ED,E2B4   ; Go to $E2B4
}


;;; $E2CC: Creepy crawly instruction list pointers ;;;
{
; Indexed by [enemy initialisation parameter] * 2
$A3:E2CC             dw E25C, E278, E294, E2B0
}


;;; $E2D4: Initialisation AI - enemy $DC7F (big eye bugs) ;;;
{
$A3:E2D4 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E2D7 BD 92 0F    LDA $0F92,x[$7E:0FD2]  ;\
$A3:E2DA 29 03 00    AND #$0003             ;|
$A3:E2DD 0A          ASL A                  ;|
$A3:E2DE A8          TAY                    ;} Enemy instruction list pointer = [$E2CC + ([enemy initialisation parameter] & 3) * 2]
$A3:E2DF B9 CC E2    LDA $E2CC,y[$A3:E2CE]  ;|
$A3:E2E2 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;/
$A3:E2E5 4C 7A E6    JMP $E67A  [$A3:E67A]  ; Go to creepy crawly common initialisation AI
}


;;; $E2E8: Spritemaps ;;;
{
$A3:E2E8             dx 0004, 0002,00,2121, 01F6,00,2120, 8000,F8,2102, 81F0,F8,2100
$A3:E2FE             dx 0004, 0002,00,2123, 01F6,00,2122, 8000,F7,2102, 81F0,F7,2100
$A3:E314             dx 0004, 0002,00,2125, 01F6,00,2124, 81F0,F7,6102, 8000,F7,6100
$A3:E32A             dx 0004, 0002,00,2127, 01F6,00,2126, 81F0,F7,6102, 8000,F7,6100
$A3:E340             dx 0004, 0002,00,2129, 01F6,00,2128, 8000,F8,2102, 81F0,F8,2100
$A3:E356             dx 0004, 01F5,00,6121, 0001,00,6120, 81EF,F8,6102, 81FF,F8,6100
$A3:E36C             dx 0004, 01F5,00,6123, 0001,00,6122, 81EF,F7,6102, 81FF,F7,6100
$A3:E382             dx 0004, 01F5,00,6125, 0001,00,6124, 81FF,F7,2102, 81EF,F7,2100
$A3:E398             dx 0004, 01F5,00,6127, 0001,00,6126, 81FF,F7,2102, 81EF,F7,2100
$A3:E3AE             dx 0004, 01F5,00,6129, 0001,00,6128, 81EF,F8,6102, 81FF,F8,6100
$A3:E3C4             dx 0004, 0000,F6,2108, 0000,02,2118, 81F8,00,2106, 81F8,F0,2104
$A3:E3DA             dx 0004, 0000,F6,2109, 0000,02,2119, 81F7,00,2106, 81F7,F0,2104
$A3:E3F0             dx 0004, 0000,F6,210A, 0000,02,211A, 81F7,F0,A106, 81F7,00,A104
$A3:E406             dx 0004, 0000,F6,210B, 0000,02,211B, 81F7,F0,A106, 81F7,00,A104
$A3:E41C             dx 0004, 0000,F6,210C, 0000,02,211C, 81F8,00,2106, 81F8,F0,2104
$A3:E432             dx 0004, 0002,F8,A121, 01F6,F8,A120, 8000,F8,A102, 81F0,F8,A100
$A3:E448             dx 0004, 0002,F7,A123, 01F6,F7,A122, 8000,F9,A102, 81F0,F9,A100
$A3:E45E             dx 0004, 0002,F7,A125, 01F6,F7,A124, 81F0,F9,E102, 8000,F9,E100
$A3:E474             dx 0004, 0002,F7,A127, 01F6,F7,A126, 81F0,F9,E102, 8000,F9,E100
$A3:E48A             dx 0004, 0002,F8,A129, 01F6,F8,A128, 8000,F8,A102, 81F0,F8,A100
$A3:E4A0             dx 0004, 01F5,F8,E121, 0001,F8,E120, 81EF,F8,E102, 81FF,F8,E100
$A3:E4B6             dx 0004, 01F5,F7,E123, 0001,F7,E122, 81EF,F9,E102, 81FF,F9,E100
$A3:E4CC             dx 0004, 01F5,F7,E125, 0001,F7,E124, 81FF,F9,A102, 81EF,F9,A100
$A3:E4E2             dx 0004, 01F5,F7,E127, 0001,F7,E126, 81FF,F9,A102, 81EF,F9,A100
$A3:E4F8             dx 0004, 01F5,F8,E129, 0001,F8,E128, 81EF,F8,E102, 81FF,F8,E100
$A3:E50E             dx 0004, 01F8,F6,6108, 01F8,02,6118, 81F8,00,6106, 81F8,F0,6104
$A3:E524             dx 0004, 01F7,F6,6109, 01F7,02,6119, 81F9,00,6106, 81F9,F0,6104
$A3:E53A             dx 0004, 01F7,F6,610A, 01F7,02,611A, 81F9,F0,E106, 81F9,00,E104
$A3:E550             dx 0004, 01F7,F6,610B, 01F7,02,611B, 81F9,F0,E106, 81F9,00,E104
$A3:E566             dx 0004, 01F8,F6,610C, 01F8,02,611C, 81F8,00,6106, 81F8,F0,6104
}


;;; $E57C: Palette - enemy $DCBF (fire zoomer) ;;;
{
$A3:E57C             dw 3800, 02FF, 01BF, 000F, 0008, 01BF, 011B, 00BA, 0011, 7FFF, 039C, 0237, 00D1, 3BE0, 2680, 1580
}


;;; $E59C: Initialisation AI - enemy $DCBF (fire zoomer) ;;;
{
$A3:E59C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E59F BD 92 0F    LDA $0F92,x[$7E:0FD2]  ;\
$A3:E5A2 29 03 00    AND #$0003             ;|
$A3:E5A5 0A          ASL A                  ;|
$A3:E5A6 A8          TAY                    ;} Enemy instruction list pointer = [$E2CC + ([enemy initialisation parameter] & 3) * 2]
$A3:E5A7 B9 CC E2    LDA $E2CC,y[$A3:E2D2]  ;|
$A3:E5AA 9D 92 0F    STA $0F92,x[$7E:0FD2]  ;/
$A3:E5AD 4C 7A E6    JMP $E67A  [$A3:E67A]  ; Go to creepy crawly common initialisation AI
}


;;; $E5B0: Palette - enemy $DCFF (zoomer) ;;;
{
$A3:E5B0             dw 3800, 72FA, 55B0, 2845, 1801, 6210, 496B, 38C6, 2C63, 7FE0, 7DA0, 48E0, 30A0, 03FF, 0237, 00D1
}


;;; $E5D0: Palette - enemy $DD3F (stone zoomer) ;;;
{
$A3:E5D0             dw 3800, 7FFF, 4ED3, 1926, 0481, 5F57, 4691, 360D, 2DCB, 6BBA, 56B2, 2947, 18C3, 7FFF, 4ED3, 1926
}


;;; $E5F0:  ;;;
{
; Speed. Unit is 1/100h px/frame. Indexed by [enemy parameter 1] * 2
$A3:E5F0             dw 0040, 0080, 00C0, 0100, 0140, 0180, 01C0, 0200, 0240, 0280, 02C0, 0300, 0340, 0380, 0400, 0440,
                        0540, 0580, 05C0, 0600, 0640, 0680, 06C0, 0700, 0740, 0780, 07C0, 0800, 0840, 0880, 0800, 0000

; Instruction list pointers
$A3:E630             dw E294, E294, E294, B5D3, 96AB, 98AB
$A3:E63C             dw E2B0, E2B0, E2B0, B5DB, 96C3, 990B
$A3:E648             dw E25C, E25C, E25C, B5E3, 967B, 984B
$A3:E654             dw E278, E278, E278, B5EB, 9693, 988B
}


;;; $E660: Instruction - enemy function = [[Y]] ;;;
{
$A3:E660 B9 00 00    LDA $0000,y[$A3:E2B2]
$A3:E663 9D B2 0F    STA $0FB2,x[$7E:0FB2]
$A3:E666 C8          INY
$A3:E667 C8          INY
$A3:E668 6B          RTL
}


;;; $E669: Initialisation AI - enemy $DCFF/$DD3F (zoomer / stone zoomer) ;;;
{
$A3:E669 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E66C BD 92 0F    LDA $0F92,x[$7E:0F92]  ;\
$A3:E66F 29 03 00    AND #$0003             ;|
$A3:E672 0A          ASL A                  ;|
$A3:E673 A8          TAY                    ;} Enemy instruction list pointer = [$E2CC + ([enemy initialisation parameter] & 3) * 2]
$A3:E674 B9 CC E2    LDA $E2CC,y[$A3:E2D2]  ;|
$A3:E677 9D 92 0F    STA $0F92,x[$7E:0F92]  ;/
}


;;; $E67A: Creepy crawly common initialisation AI ;;;
{
; Crab / slug / Norfair slow fireball / Maridia snail / big eye bugs / zoomer
$A3:E67A A9 4D 80    LDA #$804D             ;\
$A3:E67D 9D 8E 0F    STA $0F8E,x[$7E:0F8E]  ;} Enemy spritemap pointer = $804D (nothing)
$A3:E680 A9 01 00    LDA #$0001             ;\
$A3:E683 9D 94 0F    STA $0F94,x[$7E:0F94]  ;} Enemy instruction timer = 1
$A3:E686 A9 C1 E6    LDA #$E6C1             ;\
$A3:E689 9D B2 0F    STA $0FB2,x[$7E:0FB2]  ;} Enemy function = RTL
$A3:E68C BD B4 0F    LDA $0FB4,x[$7E:0FB4]  ;\
$A3:E68F C9 FF 00    CMP #$00FF             ;} If [enemy parameter 2] != FFh:
$A3:E692 F0 0B       BEQ $0B    [$E69F]     ;/
$A3:E694 0A          ASL A                  ;\
$A3:E695 A8          TAY                    ;|
$A3:E696 B9 F0 E5    LDA $E5F0,y[$A3:E5F4]  ;} Enemy X velocity = enemy Y velocity = [$E5F0 + [enemy parameter 1] * 2]
$A3:E699 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;|
$A3:E69C 9D AA 0F    STA $0FAA,x[$7E:0FAA]  ;/

$A3:E69F BD 86 0F    LDA $0F86,x[$7E:0F86]  ;\
$A3:E6A2 29 03 00    AND #$0003             ;} If [enemy properties] & 3 = 0:
$A3:E6A5 D0 0B       BNE $0B    [$E6B2]     ;/
$A3:E6A7 BD A8 0F    LDA $0FA8,x[$7E:0FA8]  ;\
$A3:E6AA 49 FF FF    EOR #$FFFF             ;|
$A3:E6AD 1A          INC A                  ;} Negate enemy X velocity
$A3:E6AE 9D A8 0F    STA $0FA8,x[$7E:0FA8]  ;/
$A3:E6B1 6B          RTL                    ; Return

$A3:E6B2 C9 02 00    CMP #$0002             ;\
$A3:E6B5 D0 0A       BNE $0A    [$E6C1]     ;} If [enemy properties] & 3 = 2:
$A3:E6B7 BD AA 0F    LDA $0FAA,x[$7E:126A]  ;\
$A3:E6BA 49 FF FF    EOR #$FFFF             ;|
$A3:E6BD 1A          INC A                  ;} Negate enemy Y velocity
$A3:E6BE 9D AA 0F    STA $0FAA,x[$7E:126A]  ;/

$A3:E6C1 6B          RTL
}


;;; $E6C2: Main AI - enemy $D77F/$D7BF/$DABF/$DC7F/$DCBF/$DCFF/$DD3F (crab / slug / Norfair slow fireball / big eye bugs / zoomer) ;;;
{
$A3:E6C2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E6C5 7C B2 0F    JMP ($0FB2,x)[$A3:E6C1]
}


;;; $E6C8:  ;;;
{
$A3:E6C8 AD 40 18    LDA $1840  [$7E:1840]
$A3:E6CB C9 1E 00    CMP #$001E
$A3:E6CE D0 15       BNE $15    [$E6E5]
$A3:E6D0 AD 3E 18    LDA $183E  [$7E:183E]
$A3:E6D3 C9 14 00    CMP #$0014
$A3:E6D6 D0 0D       BNE $0D    [$E6E5]
$A3:E6D8 BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:E6DB 9F 06 78 7E STA $7E7806,x[$7E:7846]
$A3:E6DF A9 85 E7    LDA #$E785
$A3:E6E2 9D B2 0F    STA $0FB2,x[$7E:0FF2]

$A3:E6E5 64 12       STZ $12    [$7E:0012]  ;\
$A3:E6E7 64 14       STZ $14    [$7E:0014]  ;|
$A3:E6E9 BD A8 0F    LDA $0FA8,x[$7E:0FE8]  ;|
$A3:E6EC 10 02       BPL $02    [$E6F0]     ;} $14.$12 = [enemy X velocity] / 100h
$A3:E6EE C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E6F0 85 13       STA $13    [$7E:0013]  ;/
$A3:E6F2 A5 14       LDA $14    [$7E:0014]  ;\
$A3:E6F4 10 03       BPL $03    [$E6F9]     ;} If [$14] < 0:
$A3:E6F6 3A          DEC A                  ; $14 -= 1
$A3:E6F7 80 01       BRA $01    [$E6FA]
                                            ; Else ([$14] >= 0):
$A3:E6F9 1A          INC A                  ; $14 += 1

$A3:E6FA 85 14       STA $14    [$7E:0014]
$A3:E6FC 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$A3:E700 90 43       BCC $43    [$E745]     ; If not collided with wall: go to BRANCH_NO_COLLISION
$A3:E702 A9 00 00    LDA #$0000
$A3:E705 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A3:E709 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]
$A3:E70D 64 12       STZ $12    [$7E:0012]  ;\
$A3:E70F 64 14       STZ $14    [$7E:0014]  ;|
$A3:E711 BD AA 0F    LDA $0FAA,x[$7E:0FEA]  ;|
$A3:E714 10 02       BPL $02    [$E718]     ;} $14.$12 = [enemy Y velocity] / 100h
$A3:E716 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E718 85 13       STA $13    [$7E:0013]  ;/
$A3:E71A 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:E71E B0 01       BCS $01    [$E721]     ; If not collided with block:
$A3:E720 6B          RTL                    ; Return

$A3:E721 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A3:E724 49 FF FF    EOR #$FFFF
$A3:E727 1A          INC A
$A3:E728 9D A8 0F    STA $0FA8,x[$7E:0FA8]
$A3:E72B BC B6 0F    LDY $0FB6,x[$7E:0FB6]
$A3:E72E BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A3:E731 10 05       BPL $05    [$E738]
$A3:E733 B9 30 E6    LDA $E630,y[$A3:E630]
$A3:E736 80 03       BRA $03    [$E73B]

$A3:E738 B9 3C E6    LDA $E63C,y[$A3:E63C]

$A3:E73B 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:E73E A9 01 00    LDA #$0001
$A3:E741 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:E744 6B          RTL

; BRANCH_NO_COLLISION
$A3:E745 BF 08 78 7E LDA $7E7808,x[$7E:7848]
$A3:E749 1A          INC A
$A3:E74A 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A3:E74E C9 04 00    CMP #$0004
$A3:E751 30 0E       BMI $0E    [$E761]
$A3:E753 BD B2 0F    LDA $0FB2,x[$7E:10F2]
$A3:E756 9F 06 78 7E STA $7E7806,x[$7E:7946]
$A3:E75A A9 85 E7    LDA #$E785
$A3:E75D 9D B2 0F    STA $0FB2,x[$7E:10F2]
$A3:E760 6B          RTL

$A3:E761 BD AA 0F    LDA $0FAA,x[$7E:0FEA]
$A3:E764 49 FF FF    EOR #$FFFF
$A3:E767 1A          INC A
$A3:E768 9D AA 0F    STA $0FAA,x[$7E:0FEA]
$A3:E76B BC B6 0F    LDY $0FB6,x[$7E:0FF6]
$A3:E76E BD AA 0F    LDA $0FAA,x[$7E:0FEA]
$A3:E771 10 05       BPL $05    [$E778]
$A3:E773 B9 30 E6    LDA $E630,y[$A3:E630]
$A3:E776 80 03       BRA $03    [$E77B]

$A3:E778 B9 3C E6    LDA $E63C,y[$A3:E63C]

$A3:E77B 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:E77E A9 01 00    LDA #$0001
$A3:E781 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:E784 6B          RTL
}


;;; $E785: Creepy crawly function - falling ;;;
{
$A3:E785 BF 02 78 7E LDA $7E7802,x[$7E:7A02];\
$A3:E789 85 12       STA $12    [$7E:0012]  ;|
$A3:E78B BF 04 78 7E LDA $7E7804,x[$7E:7A04];} Move enemy down by [enemy Y velocity]
$A3:E78F 85 14       STA $14    [$7E:0014]  ;|
$A3:E791 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:E795 90 28       BCC $28    [$E7BF]     ; If not collided with block: go to BRANCH_NO_COLLISION
$A3:E797 BD B4 0F    LDA $0FB4,x[$7E:11B4]
$A3:E79A C9 FF 00    CMP #$00FF
$A3:E79D D0 09       BNE $09    [$E7A8]
$A3:E79F A9 80 00    LDA #$0080
$A3:E7A2 9D A8 0F    STA $0FA8,x[$7E:1068]
$A3:E7A5 9D AA 0F    STA $0FAA,x[$7E:106A]

$A3:E7A8 A9 00 00    LDA #$0000
$A3:E7AB 9F 02 78 7E STA $7E7802,x[$7E:7A02]
$A3:E7AF 9F 04 78 7E STA $7E7804,x[$7E:7A04]
$A3:E7B3 9F 08 78 7E STA $7E7808,x[$7E:7A08]
$A3:E7B7 BF 06 78 7E LDA $7E7806,x[$7E:7A06]
$A3:E7BB 9D B2 0F    STA $0FB2,x[$7E:11B2]
$A3:E7BE 6B          RTL

; BRANCH_NO_COLLISION
$A3:E7BF BF 04 78 7E LDA $7E7804,x[$7E:7A04]
$A3:E7C3 C9 04 00    CMP #$0004
$A3:E7C6 10 17       BPL $17    [$E7DF]
$A3:E7C8 BF 02 78 7E LDA $7E7802,x[$7E:7A02]
$A3:E7CC 18          CLC
$A3:E7CD 69 00 80    ADC #$8000
$A3:E7D0 9F 02 78 7E STA $7E7802,x[$7E:7A02]
$A3:E7D4 BF 04 78 7E LDA $7E7804,x[$7E:7A04]
$A3:E7D8 69 00 00    ADC #$0000
$A3:E7DB 9F 04 78 7E STA $7E7804,x[$7E:7A04]

$A3:E7DF BF 02 78 7E LDA $7E7802,x[$7E:7A02]
$A3:E7E3 D0 0C       BNE $0C    [$E7F1]
$A3:E7E5 BF 04 78 7E LDA $7E7804,x[$7E:7A04]
$A3:E7E9 D0 06       BNE $06    [$E7F1]
$A3:E7EB A9 C8 E6    LDA #$E6C8
$A3:E7EE 9D B2 0F    STA $0FB2,x

$A3:E7F1 6B          RTL
}


;;; $E7F2:  ;;;
{
$A3:E7F2 AD 40 18    LDA $1840  [$7E:1840]
$A3:E7F5 C9 1E 00    CMP #$001E
$A3:E7F8 D0 15       BNE $15    [$E80F]
$A3:E7FA AD 3E 18    LDA $183E  [$7E:183E]
$A3:E7FD C9 14 00    CMP #$0014
$A3:E800 D0 0D       BNE $0D    [$E80F]
$A3:E802 BD B2 0F    LDA $0FB2,x[$7E:10B2]
$A3:E805 9F 06 78 7E STA $7E7806,x[$7E:7906]
$A3:E809 A9 85 E7    LDA #$E785
$A3:E80C 9D B2 0F    STA $0FB2,x[$7E:10B2]

$A3:E80F 64 12       STZ $12    [$7E:0012]  ;\
$A3:E811 64 14       STZ $14    [$7E:0014]  ;|
$A3:E813 BD AA 0F    LDA $0FAA,x[$7E:0FAA]  ;|
$A3:E816 10 02       BPL $02    [$E81A]     ;} $14.$12 = [enemy Y velocity] / 100h
$A3:E818 C6 14       DEC $14    [$7E:0014]  ;|
                                            ;|
$A3:E81A 85 13       STA $13    [$7E:0013]  ;/
$A3:E81C A5 14       LDA $14    [$7E:0014]  ;\
$A3:E81E 10 03       BPL $03    [$E823]     ;} If [$14] < 0:
$A3:E820 3A          DEC A                  ; $14 -= 1
$A3:E821 80 01       BRA $01    [$E824]
                                            ; Else ([$14] >= 0):
$A3:E823 1A          INC A                  ; $14 += 1

$A3:E824 85 14       STA $14    [$7E:0014]
$A3:E826 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [$14].[$12]
$A3:E82A 90 39       BCC $39    [$E865]     ; If not collided with block: go to BRANCH_NO_COLLISION
$A3:E82C A9 00 00    LDA #$0000
$A3:E82F 9F 08 78 7E STA $7E7808,x[$7E:7808]
$A3:E833 20 A5 E8    JSR $E8A5  [$A3:E8A5]
$A3:E836 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [$14].[$12]
$A3:E83A B0 05       BCS $05    [$E841]     ; If not collided with wall:
$A3:E83C 22 AD C8 A0 JSL $A0C8AD[$A0:C8AD]
$A3:E840 6B          RTL

$A3:E841 BD AA 0F    LDA $0FAA,x[$7E:0FAA]
$A3:E844 49 FF FF    EOR #$FFFF
$A3:E847 1A          INC A
$A3:E848 9D AA 0F    STA $0FAA,x[$7E:0FAA]
$A3:E84B BC B6 0F    LDY $0FB6,x[$7E:0FB6]
$A3:E84E BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A3:E851 10 05       BPL $05    [$E858]
$A3:E853 B9 48 E6    LDA $E648,y[$A3:E648]
$A3:E856 80 03       BRA $03    [$E85B]

$A3:E858 B9 54 E6    LDA $E654,y[$A3:E654]

$A3:E85B 9D 92 0F    STA $0F92,x[$7E:0F92]
$A3:E85E A9 01 00    LDA #$0001
$A3:E861 9D 94 0F    STA $0F94,x[$7E:0F94]
$A3:E864 6B          RTL

; BRANCH_NO_COLLISION
$A3:E865 BF 08 78 7E LDA $7E7808,x[$7E:7848]
$A3:E869 1A          INC A
$A3:E86A 9F 08 78 7E STA $7E7808,x[$7E:7848]
$A3:E86E C9 04 00    CMP #$0004
$A3:E871 30 0E       BMI $0E    [$E881]
$A3:E873 BD B2 0F    LDA $0FB2,x[$7E:11B2]
$A3:E876 9F 06 78 7E STA $7E7806,x[$7E:7A06]
$A3:E87A A9 85 E7    LDA #$E785
$A3:E87D 9D B2 0F    STA $0FB2,x[$7E:11B2]
$A3:E880 6B          RTL

$A3:E881 BD A8 0F    LDA $0FA8,x[$7E:0FE8]
$A3:E884 49 FF FF    EOR #$FFFF
$A3:E887 1A          INC A
$A3:E888 9D A8 0F    STA $0FA8,x[$7E:0FE8]
$A3:E88B BC B6 0F    LDY $0FB6,x[$7E:0FF6]
$A3:E88E BD A8 0F    LDA $0FA8,x[$7E:0FE8]
$A3:E891 10 05       BPL $05    [$E898]
$A3:E893 B9 48 E6    LDA $E648,y[$A3:E648]
$A3:E896 80 03       BRA $03    [$E89B]

$A3:E898 B9 54 E6    LDA $E654,y[$A3:E654]

$A3:E89B 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:E89E A9 01 00    LDA #$0001
$A3:E8A1 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:E8A4 6B          RTL
}


;;; $E8A5:  ;;;
{
; Used by geemers... adjusts horizontal speed according to current slope being traversed
$A3:E8A5 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]
$A3:E8A8 48          PHA
$A3:E8A9 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]
$A3:E8AC 3C AA 0F    BIT $0FAA,x[$7E:0FAA]
$A3:E8AF 10 06       BPL $06    [$E8B7]
$A3:E8B1 38          SEC
$A3:E8B2 FD 84 0F    SBC $0F84,x[$7E:0FC4]
$A3:E8B5 80 05       BRA $05    [$E8BC]

$A3:E8B7 18          CLC
$A3:E8B8 7D 84 0F    ADC $0F84,x[$7E:0F84]
$A3:E8BB 3A          DEC A

$A3:E8BC 48          PHA
$A3:E8BD 22 70 BB A0 JSL $A0BB70[$A0:BB70]
$A3:E8C1 AD C4 0D    LDA $0DC4  [$7E:0DC4]
$A3:E8C4 0A          ASL A
$A3:E8C5 AA          TAX
$A3:E8C6 BF 02 00 7F LDA $7F0002,x[$7F:00EC]
$A3:E8CA 29 00 F0    AND #$F000
$A3:E8CD C9 00 10    CMP #$1000
$A3:E8D0 D0 4C       BNE $4C    [$E91E]
$A3:E8D2 AE C4 0D    LDX $0DC4  [$7E:0DC4]
$A3:E8D5 BF 02 64 7F LDA $7F6402,x[$7F:6A6C]
$A3:E8D9 29 1F 00    AND #$001F
$A3:E8DC C9 05 00    CMP #$0005
$A3:E8DF 90 3D       BCC $3D    [$E91E]
$A3:E8E1 0A          ASL A
$A3:E8E2 0A          ASL A
$A3:E8E3 AA          TAX
$A3:E8E4 BC 31 E9    LDY $E931,x[$A3:E979]
$A3:E8E7 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E8EA BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A3:E8ED 10 20       BPL $20    [$E90F]
$A3:E8EF 49 FF FF    EOR #$FFFF
$A3:E8F2 1A          INC A
$A3:E8F3 22 D6 82 80 JSL $8082D6[$80:82D6]
$A3:E8F7 AD F1 05    LDA $05F1  [$7E:05F1]
$A3:E8FA 49 FF FF    EOR #$FFFF
$A3:E8FD 18          CLC
$A3:E8FE 69 01 00    ADC #$0001
$A3:E901 85 12       STA $12    [$7E:0012]
$A3:E903 AD F3 05    LDA $05F3  [$7E:05F3]
$A3:E906 49 FF FF    EOR #$FFFF
$A3:E909 69 00 00    ADC #$0000
$A3:E90C 85 14       STA $14    [$7E:0014]
$A3:E90E 60          RTS

$A3:E90F 22 D6 82 80 JSL $8082D6[$80:82D6]
$A3:E913 AD F1 05    LDA $05F1  [$7E:05F1]
$A3:E916 85 12       STA $12    [$7E:0012]
$A3:E918 AD F3 05    LDA $05F3  [$7E:05F3]
$A3:E91B 85 14       STA $14    [$7E:0014]
$A3:E91D 60          RTS

$A3:E91E AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:E921 64 12       STZ $12    [$7E:0012]
$A3:E923 64 14       STZ $14    [$7E:0014]
$A3:E925 BD A8 0F    LDA $0FA8,x[$7E:0FA8]
$A3:E928 10 02       BPL $02    [$E92C]
$A3:E92A C6 14       DEC $14    [$7E:0014]

$A3:E92C 85 13       STA $13    [$7E:0013]
$A3:E92E 60          RTS

$A3:E92F             dw 0000
$A3:E931             dw 0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000,
                        0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000, 0100, 0000, 0100, 1000, 00B0, 1000, 00B0, 0000,
                        0100, 0000, 0100, 1000, 00C0, 0000, 0100, 1000, 00C0, 1000, 00C0, 0800, 00D8, 0800, 00D8, 0600,
                        00F0, 0600, 00F0, 0600, 00F0, 4000, 0080, 4000, 0080, 6000, 0050, 6000, 0050, 6000, 0050
}
}


;;; $E9AF..F310: Metroid ;;;
{
;;; $E9AF: Palette - enemy $DD7F (metroid) ;;;
{
$A3:E9AF             dw 3800, 6BF5, 06E1, 0641, 05A1, 5E5F, 183F, 1014, 080A, 0404, 4F9F, 3ED8, 2E12, 6F70, 7FFF, 5EE0
}


;;; $E9CF: Instruction list - metroid - chasing Samus ;;;
{
$A3:E9CF             dx 0010,F10D,
                        0010,F137,
                        0006,F157,
                        000A,F181,
                        0010,F137,
                        0010,F10D,
                        0010,F137,
                        0006,F157,
                        000A,F181,
                        0010,F137,
                        0010,F10D,
                        0010,F137,
                        0006,F157,
                        000A,F181,
                        0010,F137,
                        0010,F10D,
                        0010,F137,
                        0006,F157,
                        000A,F181,
                        0010,F137,
                        EAB1,       ; Play random Metroid cry
                        80ED,E9CF   ; Go to $E9CF
}


;;; $EA25: Instruction list - metroid - draining Samus ;;;
{
$A3:EA25             dx 0010,F10D,
                        0010,F137,
                        0006,F157,
                        000A,F181,
                        0010,F137,
                        EAA5,       ; Play Metroid cry
                        80ED,EA25   ; Go to $EA25
}


;;; $EA3F: Speeds ;;;
{
$A3:EA3F             dw 0002, 0000, FFFE, 0000
$A3:EA47             dw 0000, FFFE, 0000, 0002
}


;;; $EA4F: Initialisation AI - enemy $DD7F (metroid) ;;;
{
$A3:EA4F AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A3:EA52 A9 CF E9    LDA #$E9CF             ;\
$A3:EA55 9D 92 0F    STA $0F92,x[$7E:0F92]  ;} Enemy instruction list pointer = $E9CF (metroid - chasing Samus)
$A3:EA58 BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A3:EA5B 1D 98 0F    ORA $0F98,x[$7E:0F98]  ;} $18 = [enemy palette index] | [enemy VRAM tiles index]
$A3:EA5E 85 18       STA $18    [$7E:0018]  ;/
$A3:EA60 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A3:EA63 85 12       STA $12    [$7E:0012]  ;|
$A3:EA65 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A3:EA68 85 14       STA $14    [$7E:0014]  ;} Create sprite object 32h (metroid electricity) at enemy position
$A3:EA6A A9 32 00    LDA #$0032             ;|
$A3:EA6D 85 16       STA $16    [$7E:0016]  ;|
$A3:EA6F 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A3:EA73 A5 12       LDA $12    [$7E:0012]  ;\
$A3:EA75 9F 00 78 7E STA $7E7800,x[$7E:7800];} Enemy $7E:7800 = [sprite object index]
$A3:EA79 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EA7C BD 96 0F    LDA $0F96,x[$7E:0F96]  ;\
$A3:EA7F 1D 98 0F    ORA $0F98,x[$7E:0F98]  ;} $18 = [enemy palette index] | [enemy VRAM tiles index]
$A3:EA82 85 18       STA $18    [$7E:0018]  ;/
$A3:EA84 BD 7A 0F    LDA $0F7A,x[$7E:0F7A]  ;\
$A3:EA87 85 12       STA $12    [$7E:0012]  ;|
$A3:EA89 BD 7E 0F    LDA $0F7E,x[$7E:0F7E]  ;|
$A3:EA8C 85 14       STA $14    [$7E:0014]  ;} Create sprite object 34h (metroid shell) at enemy position
$A3:EA8E A9 34 00    LDA #$0034             ;|
$A3:EA91 85 16       STA $16    [$7E:0016]  ;|
$A3:EA93 22 26 BC B4 JSL $B4BC26[$B4:BC26]  ;/
$A3:EA97 A5 12       LDA $12    [$7E:0012]  ;\
$A3:EA99 9F 02 78 7E STA $7E7802,x[$7E:7802];} Enemy $7E:7802 = [sprite object index]
$A3:EA9D A9 00 00    LDA #$0000             ;\
$A3:EAA0 9F 04 78 7E STA $7E7804,x[$7E:7804];} Enemy $7E:7804 = 0
$A3:EAA4 6B          RTL
}


;;; $EAA5: Instruction - play Metroid draining Samus ;;;
{
$A3:EAA5 DA          PHX
$A3:EAA6 5A          PHY
$A3:EAA7 A9 50 00    LDA #$0050             ;\
$A3:EAAA 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 50h, sound library 2, max queued sounds allowed = 6 (Metroid draining Samus)
$A3:EAAE 7A          PLY
$A3:EAAF FA          PLX
$A3:EAB0 6B          RTL
}


;;; $EAB1: Instruction - play random Metroid cry ;;;
{
$A3:EAB1 DA          PHX
$A3:EAB2 5A          PHY
$A3:EAB3 22 11 81 80 JSL $808111[$80:8111]  ; Generate random number
$A3:EAB7 29 07 00    AND #$0007             ;\
$A3:EABA 0A          ASL A                  ;|
$A3:EABB AA          TAX                    ;} Queue sound [$EAD6 + [random number] % 8], sound library 2, max queued sounds allowed = 6
$A3:EABC BD D6 EA    LDA $EAD6,x[$A3:EAE4]  ;|
$A3:EABF 22 CB 90 80 JSL $8090CB[$80:90CB]  ;/
$A3:EAC3 7A          PLY
$A3:EAC4 FA          PLX
$A3:EAC5 6B          RTL

$A3:EAC6             dw 00B4, 00BE, 00C8, 00D2, 00DC, 00E6, 00F0, 00FA

$A3:EAD6             dw 0050, 0058, 005A, 0050, 0058, 005A, 0058, 005A
}


;;; $EAE6: Frozen AI - enemy $DD7F (metroid) ;;;
{
$A3:EAE6 22 41 80 A3 JSL $A38041[$A3:8041]  ; Normal frozen AI
$A3:EAEA AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EAED BD B0 0F    LDA $0FB0,x[$7E:1070]
$A3:EAF0 F0 09       BEQ $09    [$EAFB]
$A3:EAF2 DE B0 0F    DEC $0FB0,x
$A3:EAF5 A9 02 00    LDA #$0002
$A3:EAF8 9D 9C 0F    STA $0F9C,x

$A3:EAFB BF 00 78 7E LDA $7E7800,x[$7E:78C0]
$A3:EAFF AA          TAX
$A3:EB00 A9 00 0C    LDA #$0C00
$A3:EB03 9F 78 F0 7E STA $7EF078,x[$7E:F0AA]
$A3:EB07 A9 01 00    LDA #$0001
$A3:EB0A 9F F8 F2 7E STA $7EF2F8,x[$7E:F32A]
$A3:EB0E A9 BA C3    LDA #$C3BA
$A3:EB11 9F 78 EF 7E STA $7EEF78,x[$7E:EFAA]
$A3:EB15 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EB18 BF 02 78 7E LDA $7E7802,x[$7E:78C2]
$A3:EB1C AA          TAX
$A3:EB1D A9 00 0C    LDA #$0C00
$A3:EB20 9F 78 F0 7E STA $7EF078,x[$7E:F0A8]
$A3:EB24 A9 01 00    LDA #$0001
$A3:EB27 9F F8 F2 7E STA $7EF2F8,x[$7E:F328]
$A3:EB2B A9 B6 C4    LDA #$C4B6
$A3:EB2E 9F 78 EF 7E STA $7EEF78,x[$7E:EFA8]
$A3:EB32 6B          RTL
}


;;; $EB33: Hurt AI - enemy $DD7F (metroid) ;;;
{
; Synch flashing with sprite objects
$A3:EB33 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EB36 A0 FF F1    LDY #$F1FF
$A3:EB39 BD 9C 0F    LDA $0F9C,x[$7E:105C]  ;\
$A3:EB3C 89 02 00    BIT #$0002             ;} If [enemy flash timer] & 2 != 0:
$A3:EB3F F0 30       BEQ $30    [$EB71]     ;/
$A3:EB41 BD 96 0F    LDA $0F96,x[$7E:1056]  ;\
$A3:EB44 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy palette index]
$A3:EB46 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EB49 BF 00 78 7E LDA $7E7800,x[$7E:78C0];\
$A3:EB4D AA          TAX                    ;} X = [enemy $7E:7800] (sprite object 0 index)
$A3:EB4E BF 78 F0 7E LDA $7EF078,x[$7E:F0AA];\
$A3:EB52 29 FF F1    AND #$F1FF             ;|
$A3:EB55 05 12       ORA $12    [$7E:0012]  ;} Sprite object [X] palette bits = [enemy palette index]
$A3:EB57 9F 78 F0 7E STA $7EF078,x[$7E:F0AA];/
$A3:EB5B AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EB5E BF 02 78 7E LDA $7E7802,x[$7E:78C2];\
$A3:EB62 AA          TAX                    ;} X = [enemy $7E:7802] (sprite object 1 index)
$A3:EB63 BF 78 F0 7E LDA $7EF078,x[$7E:F0A8];\
$A3:EB67 29 FF F1    AND #$F1FF             ;|
$A3:EB6A 05 12       ORA $12    [$7E:0012]  ;} Sprite object [X] palette bits = [enemy palette index]
$A3:EB6C 9F 78 F0 7E STA $7EF078,x[$7E:F0A8];/
$A3:EB70 6B          RTL

$A3:EB71 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EB74 BF 00 78 7E LDA $7E7800,x[$7E:78C0];\
$A3:EB78 AA          TAX                    ;} X = [enemy $7E:7800] (sprite object 0 index)
$A3:EB79 BF 78 F0 7E LDA $7EF078,x[$7E:F0AA];\
$A3:EB7D 29 FF F1    AND #$F1FF             ;} Sprite object [X] palette bits = 0
$A3:EB80 9F 78 F0 7E STA $7EF078,x[$7E:F0AA];/
$A3:EB84 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EB87 BF 02 78 7E LDA $7E7802,x[$7E:78C2];\
$A3:EB8B AA          TAX                    ;} X = [enemy $7E:7802] (sprite object 1 index)
$A3:EB8C BF 78 F0 7E LDA $7EF078,x[$7E:F0A8];\
$A3:EB90 29 FF F1    AND #$F1FF             ;} Sprite object [X] palette bits = 0
$A3:EB93 9F 78 F0 7E STA $7EF078,x[$7E:F0A8];/
$A3:EB97 6B          RTL
}


;;; $EB98: Main AI - enemy $DD7F (metroid) ;;;
{
$A3:EB98 AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A3:EB9B AD FA 0A    LDA $0AFA  [$7E:0AFA]  ;\
$A3:EB9E 38          SEC                    ;|
$A3:EB9F E9 08 00    SBC #$0008             ;} $0E32 = [Samus Y position] - 8
$A3:EBA2 8D 32 0E    STA $0E32  [$7E:0E32]  ;/
$A3:EBA5 BD B2 0F    LDA $0FB2,x[$7E:1072]  ;\
$A3:EBA8 0A          ASL A                  ;|
$A3:EBA9 AA          TAX                    ;} Execute [$EC09 + [enemy function index] * 2]
$A3:EBAA FC 09 EC    JSR ($EC09,x)[$A3:EC11];/
$A3:EBAD BD 96 0F    LDA $0F96,x[$7E:1056]  ;\
$A3:EBB0 1D 98 0F    ORA $0F98,x[$7E:1058]  ;} $18 = [enemy palette index] | [enemy VRAM tiles index]
$A3:EBB3 85 18       STA $18    [$7E:0018]  ;/
$A3:EBB5 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$A3:EBB8 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A3:EBBA BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A3:EBBD 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$A3:EBBF BF 00 78 7E LDA $7E7800,x[$7E:78C0];\
$A3:EBC3 AA          TAX                    ;} X = [metroid electricity sprite object index]
$A3:EBC4 A5 12       LDA $12    [$7E:0012]  ;\
$A3:EBC6 9F F8 F0 7E STA $7EF0F8,x[$7E:F12A];} Metroid electricity sprite object X position = [$12]
$A3:EBCA A5 14       LDA $14    [$7E:0014]  ;\
$A3:EBCC 9F F8 F1 7E STA $7EF1F8,x[$7E:F22A];} Metroid electricity sprite object Y position = [$14]
$A3:EBD0 A5 18       LDA $18    [$7E:0018]  ;\
$A3:EBD2 9F 78 F0 7E STA $7EF078,x[$7E:F0AA];} Metroid electricity sprite object palette / VRAM index = [$18]
$A3:EBD6 A9 00 00    LDA #$0000             ;\
$A3:EBD9 9F F8 F2 7E STA $7EF2F8,x[$7E:F32A];} Metroid electricity sprite object $7E:F2F8 = 0
$A3:EBDD AE 54 0E    LDX $0E54  [$7E:0E54]  ; X = [enemy index]
$A3:EBE0 BD 7A 0F    LDA $0F7A,x[$7E:103A]  ;\
$A3:EBE3 85 12       STA $12    [$7E:0012]  ;} $12 = [enemy X position]
$A3:EBE5 BD 7E 0F    LDA $0F7E,x[$7E:103E]  ;\
$A3:EBE8 85 14       STA $14    [$7E:0014]  ;} $14 = [enemy Y position]
$A3:EBEA BF 02 78 7E LDA $7E7802,x[$7E:78C2];\
$A3:EBEE AA          TAX                    ;} X = [metroid shell sprite object index]
$A3:EBEF A5 12       LDA $12    [$7E:0012]  ;\
$A3:EBF1 9F F8 F0 7E STA $7EF0F8,x[$7E:F128];} Metroid shell sprite object X position = [$12]
$A3:EBF5 A5 14       LDA $14    [$7E:0014]  ;\
$A3:EBF7 9F F8 F1 7E STA $7EF1F8,x[$7E:F228];} Metroid shell sprite object Y position = [$14]
$A3:EBFB A5 18       LDA $18    [$7E:0018]  ;\
$A3:EBFD 9F 78 F0 7E STA $7EF078,x[$7E:F0A8];} Metroid shell sprite object palette / VRAM index = [$18]
$A3:EC01 A9 00 00    LDA #$0000             ;\
$A3:EC04 9F F8 F2 7E STA $7EF2F8,x[$7E:F328];} Metroid shell sprite object $7E:F2F8 = 0
$A3:EC08 6B          RTL

$A3:EC09             dw EC11, ECDC, ED8F, EDAB
}


;;; $EC11: Metroid function ;;;
{
$A3:EC11 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EC14 64 12       STZ $12    [$7E:0012]
$A3:EC16 64 14       STZ $14    [$7E:0014]
$A3:EC18 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A3:EC1B 38          SEC
$A3:EC1C ED 32 0E    SBC $0E32  [$7E:0E32]
$A3:EC1F 4A          LSR A
$A3:EC20 4A          LSR A
$A3:EC21 85 13       STA $13    [$7E:0013]
$A3:EC23 29 00 20    AND #$2000
$A3:EC26 F0 07       BEQ $07    [$EC2F]
$A3:EC28 A5 14       LDA $14    [$7E:0014]
$A3:EC2A 09 C0 FF    ORA #$FFC0
$A3:EC2D 85 14       STA $14    [$7E:0014]

$A3:EC2F BD AC 0F    LDA $0FAC,x[$7E:106C]
$A3:EC32 38          SEC
$A3:EC33 E5 12       SBC $12    [$7E:0012]
$A3:EC35 9D AC 0F    STA $0FAC,x[$7E:106C]
$A3:EC38 BD AE 0F    LDA $0FAE,x[$7E:106E]
$A3:EC3B E5 14       SBC $14    [$7E:0014]
$A3:EC3D 9D AE 0F    STA $0FAE,x[$7E:106E]
$A3:EC40 30 0A       BMI $0A    [$EC4C]
$A3:EC42 C9 03 00    CMP #$0003
$A3:EC45 90 13       BCC $13    [$EC5A]
$A3:EC47 A9 03 00    LDA #$0003
$A3:EC4A 80 08       BRA $08    [$EC54]

$A3:EC4C C9 FD FF    CMP #$FFFD
$A3:EC4F B0 09       BCS $09    [$EC5A]
$A3:EC51 A9 FD FF    LDA #$FFFD

$A3:EC54 9D AE 0F    STA $0FAE,x
$A3:EC57 9E AC 0F    STZ $0FAC,x

$A3:EC5A BD AC 0F    LDA $0FAC,x[$7E:106C]  ;\
$A3:EC5D 85 12       STA $12    [$7E:0012]  ;|
$A3:EC5F BD AE 0F    LDA $0FAE,x[$7E:106E]  ;|
$A3:EC62 85 14       STA $14    [$7E:0014]  ;} Move enemy down by [enemy Y velocity]
$A3:EC64 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A3:EC67 22 86 C7 A0 JSL $A0C786[$A0:C786]  ;/
$A3:EC6B 90 09       BCC $09    [$EC76]     ; If collided with block:
$A3:EC6D AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EC70 9E AC 0F    STZ $0FAC,x[$7E:0FAC]
$A3:EC73 9E AE 0F    STZ $0FAE,x[$7E:0FAE]

$A3:EC76 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EC79 64 12       STZ $12    [$7E:0012]
$A3:EC7B 64 14       STZ $14    [$7E:0014]
$A3:EC7D BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A3:EC80 38          SEC
$A3:EC81 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A3:EC84 4A          LSR A
$A3:EC85 4A          LSR A
$A3:EC86 85 13       STA $13    [$7E:0013]
$A3:EC88 29 00 20    AND #$2000
$A3:EC8B F0 07       BEQ $07    [$EC94]
$A3:EC8D A5 14       LDA $14    [$7E:0014]
$A3:EC8F 09 C0 FF    ORA #$FFC0
$A3:EC92 85 14       STA $14    [$7E:0014]

$A3:EC94 BD A8 0F    LDA $0FA8,x[$7E:1068]
$A3:EC97 38          SEC
$A3:EC98 E5 12       SBC $12    [$7E:0012]
$A3:EC9A 9D A8 0F    STA $0FA8,x[$7E:1068]
$A3:EC9D BD AA 0F    LDA $0FAA,x[$7E:106A]
$A3:ECA0 E5 14       SBC $14    [$7E:0014]
$A3:ECA2 9D AA 0F    STA $0FAA,x[$7E:106A]
$A3:ECA5 30 0A       BMI $0A    [$ECB1]
$A3:ECA7 C9 03 00    CMP #$0003
$A3:ECAA 90 13       BCC $13    [$ECBF]
$A3:ECAC A9 03 00    LDA #$0003
$A3:ECAF 80 08       BRA $08    [$ECB9]

$A3:ECB1 C9 FD FF    CMP #$FFFD
$A3:ECB4 B0 09       BCS $09    [$ECBF]
$A3:ECB6 A9 FD FF    LDA #$FFFD

$A3:ECB9 9D AA 0F    STA $0FAA,x[$7E:106A]
$A3:ECBC 9E A8 0F    STZ $0FA8,x[$7E:1068]

$A3:ECBF BD A8 0F    LDA $0FA8,x[$7E:1068]  ;\
$A3:ECC2 85 12       STA $12    [$7E:0012]  ;|
$A3:ECC4 BD AA 0F    LDA $0FAA,x[$7E:106A]  ;|
$A3:ECC7 85 14       STA $14    [$7E:0014]  ;} Move enemy right by [enemy X velocity]
$A3:ECC9 AE 54 0E    LDX $0E54  [$7E:0E54]  ;|
$A3:ECCC 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ;/
$A3:ECD0 90 09       BCC $09    [$ECDB]     ; If collided with wall:
$A3:ECD2 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ECD5 9E A8 0F    STZ $0FA8,x            ;\
$A3:ECD8 9E AA 0F    STZ $0FAA,x            ;} Enemy X velocity = 0.0

$A3:ECDB 60          RTS
}


;;; $ECDC: Metroid function ;;;
{
$A3:ECDC AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ECDF 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A3:ECE1 64 14       STZ $14    [$7E:0014]
$A3:ECE3 AD 32 0E    LDA $0E32  [$7E:0E32]  ;\
$A3:ECE6 38          SEC                    ;|
$A3:ECE7 FD 7E 0F    SBC $0F7E,x[$7E:0FBE]  ;|
$A3:ECEA EB          XBA                    ;|
$A3:ECEB 29 00 FF    AND #$FF00             ;|
$A3:ECEE 4A          LSR A                  ;|
$A3:ECEF 4A          LSR A                  ;|
$A3:ECF0 4A          LSR A                  ;} $14 = ([$0E32] - [enemy Y position]) % 100h * 20h
$A3:ECF1 85 14       STA $14    [$7E:0014]  ;|
$A3:ECF3 29 00 10    AND #$1000             ;|
$A3:ECF6 F0 07       BEQ $07    [$ECFF]     ;|
$A3:ECF8 A5 14       LDA $14    [$7E:0014]  ;|
$A3:ECFA 09 00 E0    ORA #$E000             ;|
$A3:ECFD 85 14       STA $14    [$7E:0014]  ;/

$A3:ECFF A5 14       LDA $14    [$7E:0014]  ;\
$A3:ED01 30 0A       BMI $0A    [$ED0D]     ;|
$A3:ED03 C9 03 00    CMP #$0003             ;|
$A3:ED06 90 11       BCC $11    [$ED19]     ;|
$A3:ED08 A9 03 00    LDA #$0003             ;|
$A3:ED0B 80 08       BRA $08    [$ED15]     ;|
                                            ;} $14 = clamp([$14], -3, 3)
$A3:ED0D C9 FD FF    CMP #$FFFD             ;|
$A3:ED10 B0 07       BCS $07    [$ED19]     ;|
$A3:ED12 A9 FD FF    LDA #$FFFD             ;|
                                            ;|
$A3:ED15 85 14       STA $14    [$7E:0014]  ;/
$A3:ED17 64 12       STZ $12    [$7E:0012]

$A3:ED19 A5 12       LDA $12    [$7E:0012]  ;\
$A3:ED1B 9D AC 0F    STA $0FAC,x[$7E:0FEC]  ;|
$A3:ED1E A5 14       LDA $14    [$7E:0014]  ;} Enemy Y velocity = [$14].[$12]
$A3:ED20 9D AE 0F    STA $0FAE,x[$7E:0FEE]  ;/
$A3:ED23 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ED26 22 86 C7 A0 JSL $A0C786[$A0:C786]  ; Move enemy down by [enemy Y velocity]
$A3:ED2A 90 09       BCC $09    [$ED35]     ; If collided with block:
$A3:ED2C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ED2F 9E AC 0F    STZ $0FAC,x            ;\
$A3:ED32 9E AE 0F    STZ $0FAE,x            ;} Enemy Y velocity = 0.0

$A3:ED35 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ED38 64 12       STZ $12    [$7E:0012]  ; $12 = 0
$A3:ED3A 64 14       STZ $14    [$7E:0014]
$A3:ED3C AD F6 0A    LDA $0AF6  [$7E:0AF6]  ;\
$A3:ED3F 38          SEC                    ;|
$A3:ED40 FD 7A 0F    SBC $0F7A,x[$7E:0FBA]  ;|
$A3:ED43 EB          XBA                    ;|
$A3:ED44 29 00 FF    AND #$FF00             ;|
$A3:ED47 4A          LSR A                  ;|
$A3:ED48 4A          LSR A                  ;|
$A3:ED49 4A          LSR A                  ;} $14 = ([Samus X position] - [enemy X position]) % 100h * 20h
$A3:ED4A 85 14       STA $14    [$7E:0014]  ;|
$A3:ED4C 29 00 10    AND #$1000             ;|
$A3:ED4F F0 07       BEQ $07    [$ED58]     ;|
$A3:ED51 A5 14       LDA $14    [$7E:0014]  ;|
$A3:ED53 09 00 E0    ORA #$E000             ;|
$A3:ED56 85 14       STA $14    [$7E:0014]  ;/

$A3:ED58 A5 14       LDA $14    [$7E:0014]  ;\
$A3:ED5A 30 0A       BMI $0A    [$ED66]     ;|
$A3:ED5C C9 03 00    CMP #$0003             ;|
$A3:ED5F 90 11       BCC $11    [$ED72]     ;|
$A3:ED61 A9 03 00    LDA #$0003             ;|
$A3:ED64 80 08       BRA $08    [$ED6E]     ;|
                                            ;} $14 = clamp([$14], -3, 3)
$A3:ED66 C9 FD FF    CMP #$FFFD             ;|
$A3:ED69 B0 07       BCS $07    [$ED72]     ;|
$A3:ED6B A9 FD FF    LDA #$FFFD             ;|
                                            ;|
$A3:ED6E 85 14       STA $14    [$7E:0014]  ;/
$A3:ED70 64 12       STZ $12    [$7E:0012]

$A3:ED72 A5 12       LDA $12    [$7E:0012]  ;\
$A3:ED74 9D A8 0F    STA $0FA8,x[$7E:0FE8]  ;|
$A3:ED77 A5 14       LDA $14    [$7E:0014]  ;} Enemy X velocity = [$14].[$12]
$A3:ED79 9D AA 0F    STA $0FAA,x[$7E:0FEA]  ;/
$A3:ED7C AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ED7F 22 AB C6 A0 JSL $A0C6AB[$A0:C6AB]  ; Move enemy right by [enemy X velocity]
$A3:ED83 90 09       BCC $09    [$ED8E]     ; If collided with wall:
$A3:ED85 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ED88 9E A8 0F    STZ $0FA8,x            ;\
$A3:ED8B 9E AA 0F    STZ $0FAA,x            ;} Enemy X velocity = 0.0

$A3:ED8E 60          RTS
}


;;; $ED8F: Metroid function ;;;
{
$A3:ED8F AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:ED92 AD F6 0A    LDA $0AF6  [$7E:0AF6]
$A3:ED95 9D 7A 0F    STA $0F7A,x[$7E:0FBA]
$A3:ED98 AD 32 0E    LDA $0E32  [$7E:0E32]
$A3:ED9B 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A3:ED9E 9E A8 0F    STZ $0FA8,x[$7E:0FE8]
$A3:EDA1 9E AA 0F    STZ $0FAA,x[$7E:0FEA]
$A3:EDA4 9E AC 0F    STZ $0FAC,x[$7E:0FEC]
$A3:EDA7 9E AE 0F    STZ $0FAE,x[$7E:0FEE]
$A3:EDAA 60          RTS
}


;;; $EDAB: Metroid function ;;;
{
$A3:EDAB AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EDAE BD B0 0F    LDA $0FB0,x[$7E:0FF0]
$A3:EDB1 29 03 00    AND #$0003
$A3:EDB4 0A          ASL A
$A3:EDB5 A8          TAY
$A3:EDB6 BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A3:EDB9 18          CLC
$A3:EDBA 79 3F EA    ADC $EA3F,y[$A3:EA3F]
$A3:EDBD 9D 7A 0F    STA $0F7A,x[$7E:0FBA]
$A3:EDC0 BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A3:EDC3 18          CLC
$A3:EDC4 79 47 EA    ADC $EA47,y[$A3:EA47]
$A3:EDC7 9D 7E 0F    STA $0F7E,x[$7E:0FBE]
$A3:EDCA 9E A8 0F    STZ $0FA8,x[$7E:0FE8]
$A3:EDCD 9E AA 0F    STZ $0FAA,x[$7E:0FEA]
$A3:EDD0 9E AC 0F    STZ $0FAC,x[$7E:0FEC]
$A3:EDD3 9E AE 0F    STZ $0FAE,x[$7E:0FEE]
$A3:EDD6 DE B0 0F    DEC $0FB0,x[$7E:0FF0]
$A3:EDD9 D0 0F       BNE $0F    [$EDEA]
$A3:EDDB 9E B2 0F    STZ $0FB2,x[$7E:0FF2]
$A3:EDDE A9 CF E9    LDA #$E9CF
$A3:EDE1 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:EDE4 A9 01 00    LDA #$0001
$A3:EDE7 9D 94 0F    STA $0F94,x[$7E:0FD4]

$A3:EDEA 60          RTS
}


;;; $EDEB: Enemy touch - enemy $DD7F (metroid) ;;;
{
$A3:EDEB AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A3:EDEE 38          SEC
$A3:EDEF E9 08 00    SBC #$0008
$A3:EDF2 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:EDF5 AD 6E 0A    LDA $0A6E  [$7E:0A6E]
$A3:EDF8 F0 5D       BEQ $5D    [$EE57]
$A3:EDFA AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EDFD BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:EE00 C9 02 00    CMP #$0002
$A3:EE03 F0 51       BEQ $51    [$EE56]
$A3:EE05 9E A8 0F    STZ $0FA8,x
$A3:EE08 9E AC 0F    STZ $0FAC,x
$A3:EE0B A0 00 00    LDY #$0000
$A3:EE0E BD 7A 0F    LDA $0F7A,x
$A3:EE11 38          SEC
$A3:EE12 ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A3:EE15 10 03       BPL $03    [$EE1A]
$A3:EE17 A0 00 FF    LDY #$FF00

$A3:EE1A 48          PHA
$A3:EE1B 98          TYA
$A3:EE1C 9D AA 0F    STA $0FAA,x
$A3:EE1F 68          PLA
$A3:EE20 0A          ASL A
$A3:EE21 0A          ASL A
$A3:EE22 0A          ASL A
$A3:EE23 0A          ASL A
$A3:EE24 0A          ASL A
$A3:EE25 0A          ASL A
$A3:EE26 9D A9 0F    STA $0FA9,x
$A3:EE29 A0 00 00    LDY #$0000
$A3:EE2C BD 7E 0F    LDA $0F7E,x
$A3:EE2F 38          SEC
$A3:EE30 ED 32 0E    SBC $0E32  [$7E:0E32]
$A3:EE33 10 03       BPL $03    [$EE38]
$A3:EE35 A0 00 FF    LDY #$FF00

$A3:EE38 48          PHA
$A3:EE39 98          TYA
$A3:EE3A 9D AE 0F    STA $0FAE,x
$A3:EE3D 68          PLA
$A3:EE3E 0A          ASL A
$A3:EE3F 0A          ASL A
$A3:EE40 0A          ASL A
$A3:EE41 0A          ASL A
$A3:EE42 0A          ASL A
$A3:EE43 0A          ASL A
$A3:EE44 9D AD 0F    STA $0FAD,x
$A3:EE47 9E B2 0F    STZ $0FB2,x
$A3:EE4A A9 CF E9    LDA #$E9CF
$A3:EE4D 9D 92 0F    STA $0F92,x
$A3:EE50 A9 01 00    LDA #$0001
$A3:EE53 9D 94 0F    STA $0F94,x

$A3:EE56 6B          RTL

$A3:EE57 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EE5A BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:EE5D C9 03 00    CMP #$0003
$A3:EE60 F0 1D       BEQ $1D    [$EE7F]
$A3:EE62 AD 44 0E    LDA $0E44  [$7E:0E44]
$A3:EE65 29 07 00    AND #$0007
$A3:EE68 C9 07 00    CMP #$0007
$A3:EE6B D0 0F       BNE $0F    [$EE7C]
$A3:EE6D AD C2 09    LDA $09C2  [$7E:09C2]
$A3:EE70 C9 1E 00    CMP #$001E
$A3:EE73 30 07       BMI $07    [$EE7C]
$A3:EE75 A9 2D 00    LDA #$002D             ;\
$A3:EE78 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound 2Dh, sound library 3, max queued sounds allowed = 6 (gaining/losing incremental health)

$A3:EE7C 20 CE EE    JSR $EECE  [$A3:EECE]

$A3:EE7F BD B2 0F    LDA $0FB2,x[$7E:0FF2]
$A3:EE82 C9 02 00    CMP #$0002
$A3:EE85 B0 CF       BCS $CF    [$EE56]
$A3:EE87 A0 01 00    LDY #$0001
$A3:EE8A BD 7A 0F    LDA $0F7A,x[$7E:0FBA]
$A3:EE8D 38          SEC
$A3:EE8E ED F6 0A    SBC $0AF6  [$7E:0AF6]
$A3:EE91 10 04       BPL $04    [$EE97]
$A3:EE93 49 FF FF    EOR #$FFFF
$A3:EE96 1A          INC A

$A3:EE97 C9 08 00    CMP #$0008
$A3:EE9A B0 1C       BCS $1C    [$EEB8]
$A3:EE9C BD 7E 0F    LDA $0F7E,x[$7E:0FBE]
$A3:EE9F 38          SEC
$A3:EEA0 ED 32 0E    SBC $0E32  [$7E:0E32]
$A3:EEA3 10 04       BPL $04    [$EEA9]
$A3:EEA5 49 FF FF    EOR #$FFFF
$A3:EEA8 1A          INC A

$A3:EEA9 C9 08 00    CMP #$0008
$A3:EEAC B0 0A       BCS $0A    [$EEB8]
$A3:EEAE A0 02 00    LDY #$0002
$A3:EEB1 A9 12 00    LDA #$0012
$A3:EEB4 22 84 F0 90 JSL $90F084[$90:F084]

$A3:EEB8 98          TYA
$A3:EEB9 9D B2 0F    STA $0FB2,x[$7E:0FF2]
$A3:EEBC C9 02 00    CMP #$0002
$A3:EEBF D0 95       BNE $95    [$EE56]
$A3:EEC1 A9 25 EA    LDA #$EA25
$A3:EEC4 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:EEC7 A9 01 00    LDA #$0001
$A3:EECA 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:EECD 6B          RTL
}


;;; $EECE:  ;;;
{
$A3:EECE AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A3:EED1 38          SEC
$A3:EED2 E9 08 00    SBC #$0008
$A3:EED5 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:EED8 AD A2 09    LDA $09A2  [$7E:09A2]
$A3:EEDB 89 20 00    BIT #$0020
$A3:EEDE D0 08       BNE $08    [$EEE8]
$A3:EEE0 4A          LSR A
$A3:EEE1 90 0A       BCC $0A    [$EEED]
$A3:EEE3 A9 00 60    LDA #$6000
$A3:EEE6 80 08       BRA $08    [$EEF0]

$A3:EEE8 A9 00 30    LDA #$3000
$A3:EEEB 80 03       BRA $03    [$EEF0]

$A3:EEED A9 00 C0    LDA #$C000

$A3:EEF0 85 12       STA $12    [$7E:0012]
$A3:EEF2 BF 04 78 7E LDA $7E7804,x[$7E:7844]
$A3:EEF6 38          SEC
$A3:EEF7 E5 12       SBC $12    [$7E:0012]
$A3:EEF9 9F 04 78 7E STA $7E7804,x[$7E:7844]
$A3:EEFD B0 07       BCS $07    [$EF06]
$A3:EEFF A9 01 00    LDA #$0001
$A3:EF02 22 51 DF 91 JSL $91DF51[$91:DF51]

$A3:EF06 60          RTS
}


;;; $EF07: Enemy shot - enemy $DD7F (metroid) ;;;
{
$A3:EF07 AD FA 0A    LDA $0AFA  [$7E:0AFA]
$A3:EF0A 38          SEC
$A3:EF0B E9 08 00    SBC #$0008
$A3:EF0E 8D 32 0E    STA $0E32  [$7E:0E32]
$A3:EF11 AD A6 18    LDA $18A6  [$7E:18A6]
$A3:EF14 0A          ASL A
$A3:EF15 A8          TAY
$A3:EF16 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EF19 BD 9E 0F    LDA $0F9E,x[$7E:105E]
$A3:EF1C F0 5B       BEQ $5B    [$EF79]
$A3:EF1E B9 18 0C    LDA $0C18,y[$7E:0C18]
$A3:EF21 29 00 0F    AND #$0F00
$A3:EF24 C9 00 01    CMP #$0100
$A3:EF27 F0 05       BEQ $05    [$EF2E]
$A3:EF29 C9 00 02    CMP #$0200
$A3:EF2C D0 4A       BNE $4A    [$EF78]

$A3:EF2E BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A3:EF31 8F 34 F4 7E STA $7EF434[$7E:F434]
$A3:EF35 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A3:EF38 8F 36 F4 7E STA $7EF436[$7E:F436]
$A3:EF3C 22 32 80 A3 JSL $A38032[$A3:8032]
$A3:EF40 BD 8C 0F    LDA $0F8C,x[$7E:104C]
$A3:EF43 D0 33       BNE $33    [$EF78]
$A3:EF45 9E AA 0F    STZ $0FAA,x[$7E:106A]
$A3:EF48 A9 04 00    LDA #$0004
$A3:EF4B 22 AF A3 A0 JSL $A0A3AF[$A0:A3AF]
$A3:EF4F A9 13 00    LDA #$0013
$A3:EF52 22 84 F0 90 JSL $90F084[$90:F084]
$A3:EF56 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EF59 BF 00 78 7E LDA $7E7800,x[$7E:78C0]
$A3:EF5D AA          TAX
$A3:EF5E A9 00 00    LDA #$0000
$A3:EF61 9F 78 EF 7E STA $7EEF78,x[$7E:EFAA]
$A3:EF65 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:EF68 BF 02 78 7E LDA $7E7802,x[$7E:78C2]
$A3:EF6C AA          TAX
$A3:EF6D A9 00 00    LDA #$0000
$A3:EF70 9F 78 EF 7E STA $7EEF78,x[$7E:EFA8]
$A3:EF74 22 68 B9 A0 JSL $A0B968[$A0:B968]

$A3:EF78 6B          RTL

$A3:EF79 BD B2 0F    LDA $0FB2,x[$7E:1072]
$A3:EF7C C9 02 00    CMP #$0002
$A3:EF7F D0 2B       BNE $2B    [$EFAC]
$A3:EF81 B9 18 0C    LDA $0C18,y[$7E:0C18]
$A3:EF84 29 00 0F    AND #$0F00
$A3:EF87 C9 00 05    CMP #$0500
$A3:EF8A D0 1F       BNE $1F    [$EFAB]
$A3:EF8C A9 04 00    LDA #$0004
$A3:EF8F 9D B0 0F    STA $0FB0,x[$7E:0FF0]
$A3:EF92 A9 03 00    LDA #$0003
$A3:EF95 9D B2 0F    STA $0FB2,x[$7E:0FF2]
$A3:EF98 A9 CF E9    LDA #$E9CF
$A3:EF9B 9D 92 0F    STA $0F92,x[$7E:0FD2]
$A3:EF9E A9 01 00    LDA #$0001
$A3:EFA1 9D 94 0F    STA $0F94,x[$7E:0FD4]
$A3:EFA4 A9 13 00    LDA #$0013
$A3:EFA7 22 84 F0 90 JSL $90F084[$90:F084]

$A3:EFAB 6B          RTL

$A3:EFAC 9E A8 0F    STZ $0FA8,x[$7E:1068]
$A3:EFAF 9E AC 0F    STZ $0FAC,x[$7E:106C]
$A3:EFB2 A0 00 00    LDY #$0000
$A3:EFB5 BD 7A 0F    LDA $0F7A,x[$7E:103A]
$A3:EFB8 38          SEC
$A3:EFB9 F9 64 0B    SBC $0B64,y[$7E:0B64]
$A3:EFBC 10 03       BPL $03    [$EFC1]
$A3:EFBE A0 00 FF    LDY #$FF00

$A3:EFC1 48          PHA
$A3:EFC2 98          TYA
$A3:EFC3 9D AA 0F    STA $0FAA,x[$7E:106A]
$A3:EFC6 68          PLA
$A3:EFC7 0A          ASL A
$A3:EFC8 0A          ASL A
$A3:EFC9 0A          ASL A
$A3:EFCA 0A          ASL A
$A3:EFCB 0A          ASL A
$A3:EFCC 9D A9 0F    STA $0FA9,x[$7E:1069]
$A3:EFCF A0 00 00    LDY #$0000
$A3:EFD2 BD 7E 0F    LDA $0F7E,x[$7E:103E]
$A3:EFD5 38          SEC
$A3:EFD6 F9 78 0B    SBC $0B78,y[$7E:0B78]
$A3:EFD9 10 03       BPL $03    [$EFDE]
$A3:EFDB A0 00 FF    LDY #$FF00

$A3:EFDE 48          PHA
$A3:EFDF 98          TYA
$A3:EFE0 9D AE 0F    STA $0FAE,x[$7E:106E]
$A3:EFE3 68          PLA
$A3:EFE4 0A          ASL A
$A3:EFE5 0A          ASL A
$A3:EFE6 0A          ASL A
$A3:EFE7 0A          ASL A
$A3:EFE8 0A          ASL A
$A3:EFE9 9D AD 0F    STA $0FAD,x[$7E:106D]
$A3:EFEC 9E B2 0F    STZ $0FB2,x[$7E:1072]
$A3:EFEF A9 CF E9    LDA #$E9CF
$A3:EFF2 9D 92 0F    STA $0F92,x[$7E:1052]
$A3:EFF5 A9 01 00    LDA #$0001
$A3:EFF8 9D 94 0F    STA $0F94,x[$7E:1054]
$A3:EFFB AD A6 18    LDA $18A6  [$7E:18A6]
$A3:EFFE 0A          ASL A
$A3:EFFF A8          TAY
$A3:F000 B9 18 0C    LDA $0C18,y[$7E:0C18]
$A3:F003 29 02 00    AND #$0002
$A3:F006 F0 32       BEQ $32    [$F03A]
$A3:F008 A9 0A 00    LDA #$000A             ;\
$A3:F00B 22 4D 91 80 JSL $80914D[$80:914D]  ;} Queue sound Ah, sound library 3, max queued sounds allowed = 6 (enemy frozen)
$A3:F00F B9 2C 0C    LDA $0C2C,y[$7E:0C2C]
$A3:F012 85 12       STA $12    [$7E:0012]
$A3:F014 A9 04 00    LDA #$0004
$A3:F017 9D 9C 0F    STA $0F9C,x[$7E:105C]
$A3:F01A BD B6 0F    LDA $0FB6,x[$7E:1076]
$A3:F01D 38          SEC
$A3:F01E E5 12       SBC $12    [$7E:0012]
$A3:F020 F0 02       BEQ $02    [$F024]
$A3:F022 B0 13       BCS $13    [$F037]

$A3:F024 9E B6 0F    STZ $0FB6,x[$7E:1076]
$A3:F027 A9 90 01    LDA #$0190
$A3:F02A 9D 9E 0F    STA $0F9E,x[$7E:105E]
$A3:F02D BD 8A 0F    LDA $0F8A,x[$7E:104A]
$A3:F030 09 04 00    ORA #$0004
$A3:F033 9D 8A 0F    STA $0F8A,x[$7E:104A]
$A3:F036 6B          RTL

$A3:F037 9D B6 0F    STA $0FB6,x

$A3:F03A A9 5A 00    LDA #$005A             ;\
$A3:F03D 22 CB 90 80 JSL $8090CB[$80:90CB]  ;} Queue sound 5Ah, sound library 2, max queued sounds allowed = 6 (shot Metroid)
$A3:F041 6B          RTL
}


;;; $F042: Power bomb reaction - enemy $DD7F (metroid) ;;;
{
$A3:F042 22 97 A5 A0 JSL $A0A597[$A0:A597]
$A3:F046 BD 8C 0F    LDA $0F8C,x[$7E:0FCC]
$A3:F049 D0 25       BNE $25    [$F070]
$A3:F04B A9 13 00    LDA #$0013
$A3:F04E 22 84 F0 90 JSL $90F084[$90:F084]
$A3:F052 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:F055 BF 00 78 7E LDA $7E7800,x[$7E:7840]
$A3:F059 AA          TAX
$A3:F05A A9 00 00    LDA #$0000
$A3:F05D 9F 78 EF 7E STA $7EEF78,x[$7E:EFB2]
$A3:F061 AE 54 0E    LDX $0E54  [$7E:0E54]
$A3:F064 BF 02 78 7E LDA $7E7802,x[$7E:7842]
$A3:F068 AA          TAX
$A3:F069 A9 00 00    LDA #$0000
$A3:F06C 9F 78 EF 7E STA $7EEF78,x[$7E:EFB0]

$A3:F070 6B          RTL
}


;;; $F071: Metroid spritemaps ;;;
{
; Unused
$A3:F071             dx 000A, 0010,04,6130, 0010,FC,6120, 0010,F4,6110, 01E8,04,2130, 01E8,FC,2120, 01E8,F4,2110, 8000,FC,6121, 8000,EC,2103, 81F0,FC,2121, 81F0,EC,2101
$A3:F0A5             dx 000A, 0010,FC,612A, 0010,04,613A, 0010,F4,211F, 01E8,04,213A, 01E8,FC,212A, 01E8,F4,211A, 8000,EC,210D, 8000,FC,612B, 81F0,FC,212B, 81F0,EC,210B
$A3:F0D9             dx 000A, 01E8,FC,2125, 0010,04,6135, 0010,FC,6125, 0010,F4,6115, 01E8,04,2135, 01E8,F4,2115, 8000,FC,6126, 8000,EC,2108, 81F0,FC,2126, 81F0,EC,2106

; Only these four frames are used
$A3:F10D             dx 0008, 0010,00,6160, 0010,F8,6150, 01E8,00,2160, 01E8,F8,2150, 8000,00,6161, 8000,F0,6141, 81F0,00,2161, 81F0,F0,2141
$A3:F137             dx 0006, 0010,00,6163, 01E8,00,2163, 8000,00,6164, 8000,F0,6144, 81F0,00,2164, 81F0,F0,2144
$A3:F157             dx 0008, 0010,00,6166, 0010,F8,6156, 01E8,00,2166, 01E8,F8,2156, 8000,00,6167, 8000,F0,6147, 81F0,00,2167, 81F0,F0,2147
$A3:F181             dx 0008, 0010,00,6169, 0010,F8,6159, 01E8,00,2169, 01E8,F8,2159, 8000,00,616A, 8000,F0,614A, 81F0,00,216A, 81F0,F0,214A

; Unused
$A3:F1AB             dx 0003, 0000,EC,217C, 01F8,FC,214D, 01F0,FC,214C
$A3:F1BC             dx 0003, 0000,EC,217D, 01F8,FC,215D, 01F0,FC,215C
$A3:F1CD             dx 0003, 0000,EC,217E, 01F8,FC,216D, 01F0,FC,216C
$A3:F1DE             dx 0004, 0008,FC,214F, 0000,FC,214E, 01F8,F4,213D, 01F8,EC,212D
$A3:F1F4             dx 0004, 0008,FC,215F, 0000,FC,215E, 01F8,F4,213E, 01F8,EC,212E
$A3:F20A             dx 0004, 0008,FC,216F, 0000,FC,216E, 01F8,F4,213F, 01F8,EC,212F
$A3:F220             dx 0003, 0008,FC,214D, 0000,FC,214C, 01F8,EC,617C
$A3:F231             dx 0003, 0008,FC,215D, 0000,FC,215C, 01F8,EC,617D
$A3:F242             dx 0003, 0008,FC,216D, 0000,FC,216C, 01F8,EC,617E
$A3:F253             dx 0004, 01F8,FC,214F, 01F0,FC,214E, 0000,F4,613D, 0000,EC,612D
$A3:F269             dx 0004, 01F8,FC,216F, 01F0,FC,216E, 0000,F4,613E, 0000,EC,612E
$A3:F27F             dx 0004, 01F8,FC,215F, 01F0,FC,215E, 0000,F4,613F, 0000,EC,612F
$A3:F295             dx 0002, 01F8,FC,214D, 01F0,FC,214C
$A3:F2A1             dx 0001, 01F0,FC,215C
$A3:F2A8             dx 0002, 01F8,FC,216D, 01F0,FC,216C
$A3:F2B4             dx 0002, 01F8,F4,213D, 01F8,EC,212D
$A3:F2C0             dx 0002, 01F8,F4,213E, 01F8,EC,212E
$A3:F2CC             dx 0002, 01F8,F4,213F, 01F8,EC,212F
$A3:F2D8             dx 0002, 0008,FC,214D, 0000,FC,214C
$A3:F2E4             dx 0002, 0008,FC,215D, 0000,FC,215C
$A3:F2F0             dx 0002, 0008,FC,216D, 0000,FC,216C
$A3:F2FC             dx 0001, 0000,EC,217C
$A3:F303             dx 0001, 0000,EC,217D
$A3:F30A             dx 0001, 0000,EC,217E
}
}


;;; $F311: Free space ;;;
{
$A3:F311             fillto $A48000, $FF
}
